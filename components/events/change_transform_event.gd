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
	if !super():
		return
	
	assert(node, "No node to change things for!")
	if tween_duration <= 0:
		if change_position:
			print("Instantly changing node " + node.name + "position to " + str(new_position))
			node.position = new_position
		if change_rotation:
			print("Instantly changing node " + node.name + "rotation to " + str(new_rotation))
			node.rotation = new_rotation
		if change_scale:
			print("Instantly changing node " + node.name + "scale to " + str(new_scale))
			node.scale = new_scale
	else :
		var tween = get_tree().create_tween().set_parallel()
		if change_position:
			tween.tween_property(node, "position", new_position, tween_duration)
			print("Slowly changing node " + node.name + "position to " + str(new_position))
		if change_rotation:
			tween.tween_property(node, "rotation", new_rotation, tween_duration)
			print("Slowly changing node " + node.name + "rotation to " + str(new_rotation))
		if change_scale:
			tween.tween_property(node, "scale", new_scale, tween_duration)
			print("Slowly changing node " + node.name + "scale to " + str(new_scale))
		
