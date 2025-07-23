extends RichTextLabel
class_name Typewriter
## Text field that updates text character by character.

@export var delay_between_characters : float =.025 ## The duration in seconds between each character addition.
var delay_left : float ## The duration in seconds left before the next character should be added.
var typewriter_text : String : ## The text to be gradually displayed.
	set(val):
		text = ""
		typewriter_text = val
		
		var regex_open = RegEx.new()
		regex_open.compile(r"\[url=.*?\]")
		var regex_close = RegEx.new()
		regex_close.compile(r"\[/url\]")
		var text_stripped = regex_open.sub(typewriter_text, "", true)
		text_stripped = regex_close.sub(text_stripped, "", true)
		typewriter_text_stripped = text_stripped
		stripped_text_left = typewriter_text_stripped.split()
		
		typewriting = true
var typewriter_text_stripped : String ## The final text, with no tags.
var stripped_text_left : PackedStringArray ## The final text, as an array of strings.
var skip_typewriter : bool ## Whether we should abort early and just show the text.
var typewriting : bool : ## Whether the typewriter is currently typing.
	set(val):
		if val and !typewriting:
			on_typewriting_begun.emit()
		elif !val and typewriting:
			on_typewriting_ended.emit()
		typewriting = val

signal on_typewriting_begun ## Emitted when typewriting begins.
signal on_typewriting_ended ## Emitted when typewriting has ended.

## Called every frame. Reduces the delay left and adds a character, if necessary.
func _process(delta: float) -> void:
	if typewriter_text and typewriter_text != text:
		if skip_typewriter:
			skip_typewriter = false
			text = typewriter_text
			typewriting = false
		else :
			delay_left -= delta
			if delay_left <= 0:
				delay_left = delay_between_characters
				text = text + stripped_text_left.get(0)
				stripped_text_left.remove_at(0)
				if stripped_text_left.is_empty():
					text = typewriter_text
					typewriting = false
