extends VBoxContainer
## Autoload class that handles dialogue and conversation.

@export var starting_conversation : Conversation ## Debug purposes.

@export var advance_button : Button ## The Button which covers the entire screen. Click to advance.
@export var name_label : Label ## The Label which notes the speaker's name.
@export var speech_label : Label ## The Label which notes the speaker's words.

var current_conversation : Conversation ## The current Conversation.
var current_speech : Speech ## The current Speech.
var current_sentence : Sentence : ## The current Sentence.
	set(val):
		current_sentence = val
		name_label.text = val.speaker
		speech_label.text = val.words
		if val.words.contains("[url"):
			advance_button.visible = false
			advance_button.disabled = true
		else :
			advance_button.visible = true
			advance_button.disabled = false

## Sets the active conversation.
func set_conversation(conversation: Conversation):
	current_conversation = conversation
	current_speech = current_conversation.get_starting_speech()
	current_sentence = current_speech.sentences[0]
	visible = true


## Listens for clicks on the advance_button. Advances the text, or closes it if we've got nothing left.
func _on_button_pressed() -> void:
	var next_sentence = current_speech.get_next_sentence(current_sentence)
	if next_sentence:
		current_sentence = next_sentence
	else :
		visible = false
