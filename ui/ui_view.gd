extends Control
## Autoload class for sprite viewing.

@export var sprite_rect : TextureRect ## The texture rect that shows the sprite.
@export var close_button : Button ## The button to close this view.

var is_visible : bool : ## Setter for visibility side effects.
	set(val):
		var old_val = is_visible
		is_visible = val
		visible = is_visible
		if old_val != val:
			if val:
				Input.mouse_mode = Input.MouseMode.MOUSE_MODE_VISIBLE
				on_shown.emit()
			else :
				Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CAPTURED
				on_hidden.emit()

signal on_shown ## Emitted when this view appears.
signal on_hidden ## Emitted when this view disappears.

## Called as this node enters the scene tree.
func _ready() -> void:
	is_visible = visible

## Shows this and the given sprite.
func show_sprite(sprite: Texture2D):
	sprite_rect.texture = sprite
	is_visible = true


## Triggered when the close button is pressed.
func _on_close_button_pressed() -> void:
	is_visible = false
