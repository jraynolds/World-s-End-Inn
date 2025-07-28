extends Event
class_name VisibilityEvent
## Event that changes the visibility of nodes.

@export var nodes_to_change_visibility : Dictionary[Node, BooleanMode]
enum BooleanMode {
	True, ## Set visibility to true
	False, ## Set visibility to false
	Toggle ## Toggle current visibility
}

## Called when this event should transpire.
## Changes the visibility of given nodes.
func take_effect():
	if !can_take_effect():
		return
	
	queue_effect(change_visibility, [nodes_to_change_visibility])


## Sets the visibility on the given nodes to the given matched values.
func change_visibility(node_dict: Dictionary[Node, BooleanMode]):
	print("Changing node visibilities:")
	for node in node_dict.keys():
		match node_dict[node]:
			BooleanMode.True:
				print("Changing node " + node.name + " visibility to true")
				node.visible = true
			BooleanMode.False:
				print("Changing node " + node.name + " visibility to false")
				node.visible = false
			BooleanMode.Toggle:
				print("Changing node " + node.name + " visibility to " + str(!node.visible))
				node.visible = !node.visible
