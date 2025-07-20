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
	for node in nodes_to_change_visibility.keys():
		match nodes_to_change_visibility[node]:
			BooleanMode.True:
				node.visible = true
			BooleanMode.False:
				node.visible = false
			BooleanMode.Toggle:
				node.visible = !node.visible
