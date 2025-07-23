@icon("res://editor/icons/comment-solid-full.svg")
extends Node
class_name ConversationBranch
## Node-based approach for dialogue. A branch can have many leaves, and has a key as its name.

var tree : ConversationTree ## The conversation tree this branch is part of.
var current_index : int ## The index of our current leaf.
var leaves : Array[ConversationLeaf] : ## The Leaves of this branch. Grabs them as children.
	get :
		var out : Array[ConversationLeaf] = []
		for child in get_children():
			var leaf = child as ConversationLeaf
			if leaf:
				out.append(leaf)
		return out

## Returns the next leaf from this one. If there is none, returns null.
func get_next_leaf(leaf: ConversationLeaf):
	assert(leaves.has(leaf), "That leaf isn't in our leaves!")
	var index = leaves.find(leaf)
	if index == len(leaves) - 1:
		return null
	return leaves[index + 1]
