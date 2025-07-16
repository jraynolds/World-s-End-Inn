extends HBoxContainer
## Global class for player interaction UI and handling.

@export var progress_bar : TextureProgressBar
@export var key_label : Label
@export var action_label : Label

var interactables : Array[Interactable] ## The list of Interactables the player can currently use.
var earliest_interactable : Interactable : ## The current Interactable the player can use, if any. We prioritize the earliest added.
	set(val):
		earliest_interactable = val
		if val:
			key_label.text = "E"
			action_label.text = val.message
			visible = true
		else :
			visible = false
var active_interactable : Interactable : ## The active Interactable being used.
	set(val):
		active_interactable = val
		if val:
			progress_bar.visible = true
		else :
			progress_bar.visible = false
var interaction_timer_left : float ## The seconds left before the active interactable is done being used.

## Add an Interactable to our available list.
func add_interactable(inter: Interactable):
	assert(inter not in interactables, "We've tried to add the same Interactable twice!")
	interactables.append(inter)
	if earliest_interactable == null:
		earliest_interactable = inter

## Remove an Interactable from our available list.
func erase_interactable(inter: Interactable):
	assert(inter in interactables, "We've tried to remove an Interactable that's not in our list!")
	interactables.erase(inter)
	if earliest_interactable == inter:
		earliest_interactable = interactables[0] if !interactables.is_empty() else null
	if active_interactable == inter:
		active_interactable = null


## Called every frame. If we have an active Interactable, counts down from it.
func _process(delta: float) -> void:
	if active_interactable:
		interaction_timer_left -= delta
		var duration_passed = active_interactable.duration - interaction_timer_left
		var fill_ratio = duration_passed / active_interactable.duration
		progress_bar.value = fill_ratio * 100.0
		if interaction_timer_left < 0:
			active_interactable.interacted()


## Called whenever an input is read. Processes interaction events.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("activate"):
		if !earliest_interactable:
			return
		active_interactable = earliest_interactable
		interaction_timer_left = earliest_interactable.duration
	elif event.is_action_released("activate"):
		active_interactable = null
