class_name SquareCamera3D
extends Camera3D

func _ready():
	_on_size_changed()
	get_tree().get_root().size_changed.connect(_on_size_changed)

func _on_size_changed():
	# Make sure the camera always fit the viewport rect, both in very wide and very tall views
	var window_size = get_viewport().size
	var aspect_ratio = float(window_size.x) / window_size.y

	# Decide which one to keep based on the window size
	if aspect_ratio > 1:
		# Wider window, keep height and adjust width
		self.keep_aspect = Camera3D.KEEP_HEIGHT
	else:
		# Taller window, keep width and adjust height
		self.keep_aspect = Camera3D.KEEP_WIDTH
