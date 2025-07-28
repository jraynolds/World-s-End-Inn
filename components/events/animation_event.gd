extends Event
class_name AnimationEvent
## Event for playing object animations.

## The node that will be animated.
## Must have an "animation_player" variable that points to an AnimationPlayer,
## Or an "animation_tree" variable that points to an AnimationTree.
@export var animation_target : Node
@export var animation_name : String ## The name of the animation that will be animated.

## Called when this event should transpire. Finds the animation target and plays its animation.
func take_effect():
	if !can_take_effect():
		return
	
	queue_effect(send_animation, [animation_target, animation_name])

## Makes the target play the given animation by name.
func send_animation(target: Node, animation: String):
	assert(target, "We couldn't find that animation target!")
	if "animation_tree" in target:
		assert(target.animation_tree, "That target has no valid animation tree!")
		var animation_tree = target.animation_tree as AnimationTree
		animation_tree.set( ## Assumes this is a one-shot.
			"parameters/" + animation + "_one_shot/request", 
			AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
		)
		print("Playing animation " + animation + " for animation target " + target.name)
	elif "animation_player" in target:
		assert(target.animation_player, "That target has no valid animation player!")
		var animation_player = target.animation_player as AnimationPlayer
		assert(animation_player.has_animation(animation), "That AnimationPlayer doesn't have that animation!")
		print("Playing animation " + animation + " for animation target " + target.name)
		animation_player.play(animation)
	else :
		assert(false, "That animation target has no animators!")
