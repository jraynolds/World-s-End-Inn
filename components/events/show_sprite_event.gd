extends Event
class_name ShowSpriteEvent
## Event which puts up a sprite on the UI.

@export var sprite : Texture2D ## The sprite to be shown.

## Called when this event should transpire.
## Pops the sprite up.
func take_effect():
	if !can_take_effect():
		return
	
	queue_effect(show_sprite, [sprite])


## Shows the given texture.
func show_sprite(texture: Texture2D):
	assert(texture, "No sprite to show!")
	print("Showing the sprite named " + texture.resource_path)
	UIView.show_sprite(texture)
