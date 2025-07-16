extends Interactable
class_name ClearInteractable
## Class for player interactivity that deletes the parent.

@export var cleared_nodes : Array[Node3D] ## The nodes we clear when interacted with.

## Called when this Interactable is fully interacted with.
func interacted():
	for node in cleared_nodes:
		node.queue_free()
