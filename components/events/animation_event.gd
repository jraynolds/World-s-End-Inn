extends Event
class_name AnimationEvent
## Event for playing object animations.

## The node that will be animated.
## Must have an "animation_player" variable that points to an AnimationPlayer.
@export var animation_target : Node 
@export var animation_name : String ## The name of the animation that will be animated.

## Called when this event should transpire. Finds the animation target and plays its animation.
func take_effect():
	super()
	
	assert(animation_target, "We couldn't find that animation target!")
	var animation_player = animation_target.animation_player
	assert(animation_player, "That target doesn't have an animation player!")
	animation_player = animation_player as AnimationPlayer
	assert(animation_player, "That animation player isn't an AnimationPlayer!")
	assert(animation_player.has_animation(animation_name), "That AnimationPlayer doesn't have that animation!")
	
	print("Playing animation " + animation_name + " for animation target " + animation_target.name)
	animation_player.play(animation_name)
