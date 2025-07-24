extends CharacterBody3D
class_name Player
### Class for the Player entity.

@export var speed : float = 5.0 ## The movement speed of the player.
@export var mouse_sensitivity : float = 0.003 ## How much the mouse movement turns us.
@export var jump_velocity : float = 4.5 ## The velocity of the player's jump.
@export var gravity : float = 9.8 ## The velocity of gravity applied to the player.
@export var look_at_target : Node3D ## The optional target the player is looking at.
@export var look_at_speed : float ## The speed with which we stare at the look_at_target.
@export var move_disabled : bool ## Whether the player can currently move. 

var yaw : float = 0.0 ## The current stored yaw of the camera.
var pitch : float = 0.0 ## The current stored pitch of the camera.

@export var camera : Camera3D ## The player camera.
@export var animation_player : AnimationPlayer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

## Catches unhandled input. Handles player and camera rotation.
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if look_at_target:
			return
		
		yaw -= event.relative.x * mouse_sensitivity
		pitch -= event.relative.y * mouse_sensitivity
		pitch = clamp(pitch, deg_to_rad(-89), deg_to_rad(89))

		rotation.y = yaw
		camera.rotation.x = pitch

## Runs on the physics tick. Does the actual movement.
func _physics_process(delta):
	var direction = Vector3.ZERO
	var input = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("back") - Input.get_action_strength("forward")
	)

	if input.length() > 0:
		input = input.normalized()
		direction += (transform.basis * Vector3(input.x, 0, input.y)).normalized()

	# Apply movement
	if !move_disabled:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed

	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity

	move_and_slide()
	
	# Look-at rotation handling
	if is_instance_valid(look_at_target):
		var self_pos = global_transform.origin
		var target_pos = look_at_target.global_transform.origin
		var to_target = target_pos - self_pos

		# --- Player Yaw (turn around Y axis only) ---
		var flat_dir = Vector3(to_target.x, 0, to_target.z)
		if flat_dir.length_squared() > 0.001:
			var target_yaw = atan2(-flat_dir.x, -flat_dir.z)
			var delta_yaw = wrapf(target_yaw - rotation.y, -PI, PI)
			rotation.y += clamp(delta_yaw, -look_at_speed * delta, look_at_speed * delta)

		# --- Camera Pitch (tilt around X axis only) ---
		# Get the target direction in global space relative to camera's position
		var cam_to_target = (target_pos - camera.global_transform.origin).normalized()
		var forward = -camera.global_transform.basis.z.normalized()
		
		# Compute angle between forward and direction-to-target projected onto XZ plane
		var pitch_angle = asin(cam_to_target.y)
		var current_pitch = camera.rotation.x
		var delta_pitch = wrapf(pitch_angle - current_pitch, -PI, PI)
		camera.rotation.x += clamp(delta_pitch, -look_at_speed * delta, look_at_speed * delta)

		# Clamp pitch to prevent flipping
		var min_pitch := deg_to_rad(-89.0)
		var max_pitch := deg_to_rad(89.0)
		camera.rotation.x = clamp(camera.rotation.x, min_pitch, max_pitch)
