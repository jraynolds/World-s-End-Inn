@icon("res://editor/icons/comment-dots-solid-full.svg")
extends Node
class_name ConversationLeaf
## Node-based approach to dialogue. A leaf is expected to have words and it can have events before or after.

@export var speaker : CharacterResource ## The speaker of this text, if any.
@export var events_before : Array[Event] ## Events which will happen before this text shows.
@export_multiline var speeches : Array[String] ## The list of speeches that appear in the dialogue box.
@export var events_after : Array[Event] ## Events which will happen after this text has completely showed.

## Runs the beginning events of this leaf.
func begin():
	for event in events_before:
		event.take_effect()


## Returns the next words element in the array from the given one, or null if it's the last.
func get_next_speech(speech: String):
	assert(speeches.has(speech), "That speech isn't in our speeches!")
	var index = speeches.find(speech)
	if index == len(speeches) - 1:
		return null
	return speeches[index+1]


## Runs the ending events of this leaf.
func end():
	for event in events_after:
		event.take_effect()
