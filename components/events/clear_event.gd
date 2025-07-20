extends Event
class_name ClearEvent
## Event that frees a node or nodes.

@export var nodes_to_clear : Array[Node] ## The nodes we free.

## Called when this event should transpire.
## Frees the nodes in the nodes_to_clear array.
func take_effect():
	for node in nodes_to_clear:
		node.queue_free()
