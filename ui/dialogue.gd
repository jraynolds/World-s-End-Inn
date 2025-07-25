extends Control
## Autoload class that handles dialogue and conversation.

@export var advance_button : Button ## The Button which covers the entire screen. Click to advance.
@export var small_advance_button : Button ## The Button which appears at the end of the text box. Click to advance.
@export var name_label : Label ## The Label which notes the speaker's name.
@export var speech_typewriter : Typewriter ## The Typewriter which slowly reveals the speaker's words.

var tree : ConversationTree : ## The current ConversationTree.
	set(val):
		tree = val
		if val:
			Interaction.suppressed = true
			tree.begin()
			branch = tree.get_starting_branch()
			Input.mouse_mode = Input.MouseMode.MOUSE_MODE_VISIBLE
		else :
			Interaction.suppressed = false
			branch = null
			Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CAPTURED
		visible = val != null
var branch : ConversationBranch : ## The current Speech.
	set(val):
		branch = val
		leaf = val.leaves[0] if val else null
var leaf : ConversationLeaf : ## The current Sentence.
	set(val):
		leaf = val
		if val:
			val.begin()
			name_label.text = val.speaker.title
			speech = val.speeches[0]
			#if val.focus_speaker:
				#player.move_disabled = true
				#for target in get_tree().get_nodes_in_group("look_at_targets"):
						#if target.name == val.speaker:
							#player.look_at_target = target
var speech : String : ## The current set of words we're displaying.
	set(val):
		speech = val
		speech_typewriter.typewriter_text = val


## Sets the current conversation tree.
func set_conversation_tree(conversation_tree: ConversationTree):
	tree = conversation_tree


## Listens for clicks on the advance_button. Advances the text, or closes it if we've got nothing left.
func _on_button_pressed() -> void:
	if speech_typewriter.typewriting:
		speech_typewriter.skip_typewriter = true
	elif !speech.contains("[url="):
		var next_speech = leaf.get_next_speech(speech)
		if next_speech:
			speech = next_speech
		else :
			var next_leaf = branch.get_next_leaf(leaf)
			if next_leaf:
				leaf = next_leaf
			else :
				tree.end()
				tree = null
	else :
		pass ## We shouldn't be able to skip a text box with options in it!


## Listens for clicks on "meta" tags ([url]) and processes them.
func _on_label_meta_clicked(meta: Variant) -> void:
	var keyed_branch = tree.get_branch_by_key(meta)
	assert(branch, "No branch passed to us!")
	branch = keyed_branch


## Listens for the typewriting of our speech label beginning.
func _on_typewriting_begun() -> void:
	small_advance_button.visible = false
	small_advance_button.disabled = true


## Listens for the typewriting of our speech label ending.
func _on_typewriting_ended() -> void:
	if !speech.contains("[url="):
		small_advance_button.visible = true
		small_advance_button.disabled = false
	leaf.end()
