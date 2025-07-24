extends Event
class_name ChangeParentEvent
## Event which changes the parent of a gameobject.

@export var child : Node3D ## The Node to reparent.
@export var new_parent : Node3D ## The Node to assign as the new parent.
@export var keep_position : bool=true ## Whether the object should stay at the same global location. 

## Called when this event should transpire.
## Begins the conversation.
func take_effect():
	if !super():
		return
	
	assert(child, "No object to reparent!")
	assert(new_parent, "No object to be the parent!")
	print(
		"Changing parent of node " + child.name + " to " + new_parent.name + 
		("keeping position" if keep_position else "")
	)
	child.reparent(new_parent, keep_position)
