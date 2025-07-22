extends Node
## Global extension method class.

## Returns the first node in the given group, whose name is the given name.
func find_node_in_group(group_name: StringName, node_name: String) -> Node3D:
	var group_nodes = get_tree().get_nodes_in_group(group_name)
	for node in group_nodes:
		if node.name == node_name:
			return node
	return null
