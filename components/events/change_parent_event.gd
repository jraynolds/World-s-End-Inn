extends Event
class_name ChangeParentEvent
## Event which changes the parent of a gameobject.

@export var child : Node3D ## The Node to reparent.
@export var new_parent : Node3D ## The Node to assign as the new parent.
@export var keep_position : bool=true ## Whether the object should stay at the same global location. 

## Called when this event should transpire.
## Begins the conversation.
func take_effect():
	if !can_take_effect():
		return
	
	queue_effect(change_parent, [child, new_parent, keep_position])


## Reparents the given node to the given parent, optionally keeping its global transform. By default, yes.
func change_parent(node: Node3D, parent: Node3D, keep: bool=true):
	assert(node, "No object to reparent!")
	assert(parent, "No object to be the parent!")
	print(
		"Changing parent of node " + node.name + " to " + parent.name + 
		("keeping position" if keep else "")
	)
	node.reparent(parent, keep)
