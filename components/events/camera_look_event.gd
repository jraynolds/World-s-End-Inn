extends Event
class_name CameraLookEvent
## Event which causes the camera to look at the target.

@export var target : Node3D ## The target for us to look at.

## Called when this event should transpire.
## Sets the camera look target to the target.
func take_effect():
	if !can_take_effect():
		return
	
	queue_effect(camera_look, [target])


## Makes the camera look at the given target.
func camera_look(look_target: Node3D):
	print("Making player camera look at target " + (look_target.name if look_target else "none"))
	Globals.get_player().look_at_target = look_target
