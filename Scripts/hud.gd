extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	$ProgressBar.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_star_count():
	return min(ceil($ProgressBar.value/33.333), 3)

func set_progressbar(procent):
	# Vis stjerner
	var stars = $Stars.get_children()
	for n in range(stars.size()):
		stars[n].hide()
	for n in range(get_star_count()):
		stars[n].show()

	$ProgressBar.value = procent
