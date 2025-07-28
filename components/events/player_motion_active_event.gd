extends Event
class_name PlayerMotionActiveEvent
## Event which causes the camera to look at the target.

@export var motion_active : bool ## Whether the player should be able to move.

## Called when this event should transpire.
## Enables or disables player movement.
func take_effect():
	if !can_take_effect():
		return
	
	queue_effect(set_player_motion, [motion_active])


## Sets the player's motion to the given value.
func set_player_motion(active: bool):
	print("Setting player motion to " + str(active))
	Globals.get_player().move_disabled = !active
