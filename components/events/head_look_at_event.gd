extends Event
class_name HeadLookAtEvent
## Event which sets a character's head look at target.

## The name of the character whose head look at we're setting.
## They must have a "head_look_at_modifier" field which is a LookAtModifier3D.
@export var character_looking : Character
@export var look_at_target : Node3D ## The object we're looking at.

## Called when this event should transpire.
## Sets the head look at for the character.
func take_effect():
	super()
	
	print("Setting character " + character_looking.name + " head look target to " + look_at_target.name)
	character_looking.head_look_at_target = look_at_target
