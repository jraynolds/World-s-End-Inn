extends CharacterBody3D
class_name Character
## Base class for NPCs.

@export var animation_player : AnimationPlayer

@export var head_look_at_modifier : LookAtModifier3D ## The LookAtModifier3D for this character's head.
var head_look_at_target : Node3D : ## The LookAt target for our head.
	set(val):
		head_look_at_modifier.target_node = val.get_path() if val else null
		head_look_at_modifier.active = true if val else false
