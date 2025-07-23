@icon("res://editor/icons/comments-solid-full.svg")
extends Node
class_name ConversationTree
## Node solution for dialogue. A conversation tree can have many branches, which can have many leaves.

@export var events_before : Array[Event] ## The list of events that transpire just before the conversation begins.
@export var branches : Array[ConversationBranch] ## The branches in this conversation tree.
@export var events_after : Array[Event] ## The list of events that transpire after the conversation ends.

## Called when this node enters the scene. Sets this as the tree for all our branches.
func _ready() -> void:
	for branch in branches:
		branch.tree = self


## Returns the child ConversationBranch with the given name (key).
func get_branch_by_key(key: String):
	for branch in branches:
		if branch.name == key:
			return branch
	return null


## Returns the starting ConversationBranch.
func get_starting_branch():
	return get_branch_by_key("start")


## Called when the conversation begins. Each of the "before" events transpire.
func begin():
	for event in events_before:
		event.take_effect()


## Called when the conversation ends. Each of the "after" events transpire.
func end():
	for event in events_after:
		event.take_effect()
