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
	if !can_take_effect():
		return
	
	queue_effect(set_head_look, [character_looking, look_at_target])


## Sets the given character's head look target to the given node.
func set_head_look(character: Character, target: Node3D):
	print("Setting character " + character.name + " head look target to " + target.name)
	character.head_look_at_target = target
