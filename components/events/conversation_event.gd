extends Event
class_name ConversationEvent
## Starts a given conversation.

@export var conversation : Conversation ## The conversation to start.

## Called when this event should transpire.
## Begins the conversation.
func take_effect():
	super()
	
	Dialogue.set_conversation(conversation)
