extends Area3D
class_name Interactable
## Class for player interactivity.

@export var message : String ## The message that pops up on the screen when the player comes near.
@export var duration : float ## The time in seconds it takes to interact with this Interactable.

## Listens to entry signal. If the player enters, sends to Interaction.
func _on_body_entered(body: Node) -> void:
	if body is Player:
		Interaction.add_interactable(self)


## Listens to exit signal. If the player exits, sends to Interaction.
func _on_body_exited(body: Node) -> void:
	if body is Player:
		Interaction.erase_interactable(self)


## Called when this Interactable is fully interacted with.
func interacted():
	pass
