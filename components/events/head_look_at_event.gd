extends Event
class_name HeadLookAtEvent
## Event which sets a character's head look at target.

## The name of the character whose head look at we're setting.
## They must have a "head_look_at_modifier" field which is a LookAtModifier3D.
@export var character_looking : String
## The name of the object we're looking at. 
## Must be in the "look_at_targets" group.
@export var look_at_target : String

## Called when this event should transpire.
## Sets the head look at for the character.
func take_effect():
	super()
	
	var character = Globals.find_node_in_group("characters", character_looking)
	assert(character, "We couldn't find a character to set their head look at!")
	character = character as Character
	assert(character, "That's not a character!")
	var look_at = character.head_look_at_modifier
	assert(look_at, "There's no head look at modifier!")
	look_at = look_at as LookAtModifier3D
	assert(look_at, "That's not a LookAtModifier3D!")
	
	var target = Globals.find_node_in_group("look_at_targets", look_at_target)
	assert(target, "There's no target to look at!")
	
	look_at.target_node = target
