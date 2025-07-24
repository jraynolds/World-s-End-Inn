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
	if !super():
		return
	
	print("Changing node visibilities:")
	for node in nodes_to_change_visibility.keys():
		match nodes_to_change_visibility[node]:
			BooleanMode.True:
				print("Changing node " + node.name + " visibility to true")
				node.visible = true
			BooleanMode.False:
				print("Changing node " + node.name + " visibility to false")
				node.visible = false
			BooleanMode.Toggle:
				print("Changing node " + node.name + " visibility to " + str(!node.visible))
				node.visible = !node.visible
