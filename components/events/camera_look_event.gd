extends Event
class_name CameraLookEvent
## Event which causes the camera to look at the target.

@export var target : Node3D ## The target for us to look at.

## Called when this event should transpire.
## Sets the camera look target to the target.
func take_effect():
	if !super():
		return
	
	print("Making player camera look at target " + (target.name if target else "none"))
	Globals.get_player().look_at_target = target
