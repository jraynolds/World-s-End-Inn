extends Resource
class_name Sentence
## Data storage for a single box of text.

@export var speaker : String ## The speaker for this text.
@export var focus_speaker : bool ## Whether we should turn the camera to them while they speak.
@export_multiline var words : String ## What text gets output.
