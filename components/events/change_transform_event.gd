extends Event
class_name ChangeTransformEvent
## Event which changes the transform for a Node.

@export var node : Node3D ## The node to change the transform for.
@export var new_position : Vector3 ## The position to set for this Node.
@export var change_position : bool ## If true, we change the position.
@export var new_rotation : Vector3 ## The rotation to set for this Node.
@export var change_rotation : bool ## If true, we change the rotation.
@export var new_scale : Vector3 ## The scale to set for this Node.
@export var change_scale : bool ## If true, we change the scale.
@export var tween_duration : float ## How long it takes to tween this transform change.

## Called when this event should transpire.
## Begins the conversation.
func take_effect():
	if !can_take_effect():
		return
	
	queue_effect(
		change_transform, 
		[node, new_position, change_position, new_rotation, change_rotation, new_scale, change_scale, tween_duration]
	)

## Manipulates the given node's Transform.
func change_transform(
	n: Node3D, 
	new_pos: Vector3, 
	change_pos: bool, 
	new_rot: Vector3, 
	change_rot: bool, 
	new_s: Vector3, 
	change_s: bool, 
	duration: float
):
	assert(n, "No node to change things for!")
	if duration <= 0:
		if change_pos:
			print("Instantly changing node " + n.name + "position to " + str(new_pos))
			n.position = new_pos
		if change_rot:
			print("Instantly changing node " + n.name + "rotation to " + str(new_rot))
			n.rotation = new_rot
		if change_s:
			print("Instantly changing node " + n.name + "scale to " + str(new_s))
			n.scale = new_s
	else :
		var tween = get_tree().create_tween().set_parallel().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		if change_pos:
			tween.tween_property(n, "position", new_pos, duration)
			print("Slowly changing node " + n.name + "position to " + str(new_pos))
		if change_rot:
			tween.tween_property(n, "rotation", new_rot, duration)
			print("Slowly changing node " + n.name + "rotation to " + str(new_rot))
		if change_s:
			tween.tween_property(n, "scale", new_s, duration)
			print("Slowly changing node " + n.name + "scale to " + str(new_s))
