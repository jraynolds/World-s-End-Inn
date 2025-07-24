@icon("res://editor/icons/calendar-check-solid-full.svg")
extends Node3D
class_name Event
## Base-level component for effects that change the game world.

## Called when this event should transpire.
func take_effect():
	if !visible: ## Break if we're not visible personally.
		print("Event " + name + " isn't visible. Ignoring")
		return false
	return true
