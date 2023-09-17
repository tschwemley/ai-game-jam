extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	SceneManager.no_effect_change_scene("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# TODO: changing a scene should be done via a signal (e.g. change_scene_signal; defined by us)
	pass
	
