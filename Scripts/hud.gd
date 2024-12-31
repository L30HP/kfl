extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	$ProgressBar.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_progressbar(procent):
	$ProgressBar.value = procent
