extends Event
class_name ConversationEvent
## Starts a given conversation.

@export var conversation_tree : ConversationTree ## The conversation tree to start.

## Called when this event should transpire.
## Begins the conversation.
func take_effect():
	if !can_take_effect():
		return
	
	queue_effect(start_conversation, [conversation_tree])


## Starts the given conversation.
func start_conversation(conversation: ConversationTree):
	assert(conversation, "No conversation tree specified!")
	print("Playing conversation tree " + conversation.name)
	Dialogue.set_conversation_tree(conversation)
