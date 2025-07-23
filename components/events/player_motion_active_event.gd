extends Event
class_name PlayerMotionActiveEvent
## Event which causes the camera to look at the target.

@export var motion_active : bool ## Whether the player should be able to move.

## Called when this event should transpire.
## Enables or disables player movement.
func take_effect():
	super()
	
	print("Setting player motion to " + str(motion_active))
	Globals.get_player().move_disabled = !motion_active
