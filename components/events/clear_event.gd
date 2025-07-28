extends Event
class_name ClearEvent
## Event that frees a node or nodes.

@export var nodes_to_clear : Array[Node] ## The nodes we free.

## Called when this event should transpire.
## Frees the nodes in the nodes_to_clear array.
func take_effect():
	if !can_take_effect():
		return
	
	queue_effect(clear_nodes, [nodes_to_clear])
	

## Clears the given nodes.
func clear_nodes(nodes: Array[Node]):
	print("Clearing nodes:")
	for node in nodes:
		print("Clearing node " + node.name)
		node.queue_free()
