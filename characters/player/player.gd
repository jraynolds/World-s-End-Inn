#extends CharacterBody3D
class_name Player
### Class for the Player entity.
#
#@export var acceleration : float ## How fast we accelerate upon input.
#@export var velocity_max : float ## The maximum velocity we can reach.
#@export var mouse_sensitivity : float ## The sensitivity of our mouselook.
#@export var jump_velocity : float ## The speed we jump with.
#
#func _input(event: InputEvent) -> void:
	#velocity = Vector3.ZERO
	#if event.is_action("forward"):
		#velocity.z = maxf(velocity.z - acceleration, -velocity_max)
	#elif event.is_action("back"):
		#velocity.z = minf(velocity.z + acceleration, velocity_max)
	#if event.is_action("left"):
		#velocity.x = minf(velocity.x - acceleration, -velocity_max)
	#elif event.is_action("right"):
		#velocity.x = maxf(velocity.x + acceleration, velocity_max)
#
#func _unhandled_input(event):
	#if event is InputEventMouseMotion:
		#yaw -= event.relative.x * mouse_sensitivity
		#pitch -= event.relative.y * mouse_sensitivity
		#pitch = clamp(pitch, deg_to_rad(-89), deg_to_rad(89))
#
		#rotation.y = yaw
		#camera.rotation.x = pitch
#
#
#func _physics_process(delta: float) -> void:
	#var direction = Vector3.ZERO
	#var input = Vector2(
		#Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		#Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	#)
#
	#if input.length() > 0:
		#input = input.normalized()
		#direction += (transform.basis * Vector3(input.x, 0, input.y)).normalized()
#
	## Apply movement
	#velocity.x = direction.x * speed
	#velocity.z = direction.z * speed
#
	## Gravity
	#if not is_on_floor():
		#velocity.y -= gravity * delta
	#else:
		#if Input.is_action_just_pressed("jump"):
			#velocity.y = jump_velocity
#
	#move_and_slide()


extends CharacterBody3D

@export var speed := 5.0
@export var mouse_sensitivity := 0.003
@export var jump_velocity := 4.5
@export var gravity := 9.8

var yaw := 0.0
var pitch := 0.0

@onready var camera = $Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * mouse_sensitivity
		pitch -= event.relative.y * mouse_sensitivity
		pitch = clamp(pitch, deg_to_rad(-89), deg_to_rad(89))

		rotation.y = yaw
		camera.rotation.x = pitch

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
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity

	move_and_slide()
