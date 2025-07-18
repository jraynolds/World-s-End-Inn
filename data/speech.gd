extends Resource
class_name Speech
## Data storage for a single story branch.

@export var sentences : Array[Sentence] ## An array of individual text boxes that occur in this branch.

## Returns the next Sentence after the given one in the list, if any.
func get_next_sentence(sentence: Sentence) -> Sentence:
	var sentence_index = sentences.find(sentence)
	assert(sentence_index > -1, "We didn't find the sentence we're following!")
	if sentence_index < len(sentences) - 1:
		return sentences[sentence_index+1]
	return null
