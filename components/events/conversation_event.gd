extends Event
class_name ConversationEvent
## Starts a given conversation.

@export var conversation_tree : ConversationTree ## The conversation tree to start.

## Called when this event should transpire.
## Begins the conversation.
func take_effect():
	super()
	
	print("Playing conversation tree " + conversation_tree.name)
	Dialogue.set_conversation_tree(conversation_tree)
