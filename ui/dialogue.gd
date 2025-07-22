extends Control
## Autoload class that handles dialogue and conversation.

@export var starting_conversation : Conversation ## Debug purposes.

@export var advance_button : Button ## The Button which covers the entire screen. Click to advance.
@export var small_advance_button : Button ## The Button which appears at the end of the text box. Click to advance.
@export var name_label : Label ## The Label which notes the speaker's name.
@export var speech_typewriter : Typewriter ## The Typewriter which slowly reveals the speaker's words.

var player : Player : ## The player controller.
	get :
		return get_tree().get_first_node_in_group("player") as Player

var current_conversation : Conversation : ## The current Conversation.
	set(val):
		current_conversation = val
		if val:
			current_speech = current_conversation.get_starting_speech()
			Input.mouse_mode = Input.MouseMode.MOUSE_MODE_VISIBLE
		else :
			current_speech = null
			Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CAPTURED
		visible = val != null
var current_speech : Speech : ## The current Speech.
	set(val):
		current_speech = val
		current_sentence = current_speech.sentences[0] if val else null
var current_sentence : Sentence : ## The current Sentence.
	set(val):
		current_sentence = val
		if val:
			name_label.text = val.speaker
			speech_typewriter.typewriter_text = val.words
			if val.focus_speaker:
				player.move_disabled = true
				for target in get_tree().get_nodes_in_group("look_at_targets"):
						if target.name == val.speaker:
							player.look_at_target = target

## Sets the active conversation.
func set_conversation(conversation: Conversation):
	current_conversation = conversation


## Listens for clicks on the advance_button. Advances the text, or closes it if we've got nothing left.
func _on_button_pressed() -> void:
	if speech_typewriter.typewriting:
		speech_typewriter.skip_typewriter = true
	elif !current_sentence.words.contains("[url="):
		var next_sentence = current_speech.get_next_sentence(current_sentence)
		if next_sentence:
			current_sentence = next_sentence
		else :
			current_conversation = null
	else :
		pass ## We shouldn't be able to skip a text box with options in it!


## Listens for clicks on "meta" tags ([url]) and processes them.
func _on_label_meta_clicked(meta: Variant) -> void:
	var speech = current_conversation.get_speech(meta)
	assert(speech, "No speech passed to us!")
	current_speech = speech


## Listens for the typewriting of our speech label beginning.
func _on_typewriting_begun() -> void:
	small_advance_button.visible = false
	small_advance_button.disabled = true


## Listens for the typewriting of our speech label ending.
func _on_typewriting_ended() -> void:
	if !current_sentence.words.contains("[url="):
		small_advance_button.visible = true
		small_advance_button.disabled = false
