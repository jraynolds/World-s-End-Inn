extends Node
## Global extension method class.

## Returns the first node in the given group, whose name is the given name.
func find_node_in_group(group_name: StringName, node_name: String) -> Node3D:
	var group_nodes = get_tree().get_nodes_in_group(group_name)
	for node in group_nodes:
		if node.name == node_name:
			return node
	return null


## Returns the first Character with a matching resource.
func find_character_by_resource(resource: CharacterResource) -> Character:
	var character_nodes = get_tree().get_nodes_in_group("characters")
	for character in character_nodes:
		if character.resource == resource:
			return character as Character
	return null


## Returns the first Character with a matching title.
func find_character_by_name(title: String) -> Character:
	var character_nodes = get_tree().get_nodes_in_group("characters")
	for character in character_nodes:
		if character.resource.title == title:
			return character as Character
	return null


## Returns the player controller.
func get_player() -> Player:
	return get_tree().get_first_node_in_group("player") as Player
