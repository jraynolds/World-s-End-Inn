extends Resource
class_name Conversation
## A data storage class for a conversation the player can have with a character.

## A Dictionary of possible dialogues in this conversation: the key is an actual string key.
## Must have a Sentence with key "start".
@export var speeches : Dictionary[String, Speech]

## Returns a Speech with the "start" key.
func get_starting_speech() -> Speech:
	return speeches["start"]


## Returns a Speech with the given key.
func get_sentence(key: String) -> Speech:
	if key not in speeches:
		return null
	return speeches[key]
