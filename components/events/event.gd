@icon("res://editor/icons/calendar-check-solid-full.svg")
extends Node3D
class_name Event
## Base-level component for effects that change the game world.

@export var delay : float ## The duration in seconds we should wait before taking effect.

## Called when this event should transpire.
func take_effect():
	pass

## Returns whether this Event can transpire. If it's not visible, no.
func can_take_effect() -> bool:
	if !visible: ## Break if we're not visible personally.
		print("Event " + name + " isn't visible. Ignoring")
		return false
	else :
		return true

## Queues the Event if there's a delay, or runs it instantly. Takes the effect and the arguments.
## If there's a delay, we add ourselves to the root, then back, to dodge deletion while we're waiting.
func queue_effect(callable: Callable, args: Array):
	if !delay:
		callable.callv(args)
	else :
		print("Creating a timer for event " + name + " with delay " + str(delay))
		var original_parent = get_parent()
		reparent(get_tree().root)
		await get_tree().create_timer(delay).timeout
		callable.callv(args)
		if original_parent:
			reparent(original_parent)
		else :
			queue_free()
