extends Control

func clamp_position_to_screen(position: Vector2, margin: int = 0) -> Vector2:
	var screen_size = get_viewport().get_visible_rect().size
	return Vector2(
		clamp(position.x, margin, screen_size.x - margin),
		clamp(position.y, margin, screen_size.y - margin)
	)

func _process(delta: float) -> void:
	# Add this code to set the crosshair position
	var camera = get_viewport().get_camera_3d()
	if camera == null:
		return

	var parent = get_parent() as Node3D

	# Project the player's position in screen space
	position = camera.unproject_position(parent.global_transform.origin)
	visible = parent.visible and !get_viewport().get_visible_rect().has_point(position)
	position = clamp_position_to_screen(position, 100)

	var direction = parent.transform.basis.z

	#rotation = Vector2.UP.angle_to(Vector2(direction.x, direction.z))
