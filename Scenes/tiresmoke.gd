extends CPUParticles3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Access the parent node
	var parent = get_parent()

	# Check if the parent has the 'speed' property
	if parent and parent.has_method("get_speed"):  # Replace "get_speed" with the exact method or use direct property
		var speed = parent.speed  # Access the speed property
		emitting = speed >= 3  # Emit only if speed is 3 or greater
	else:
		emitting = false  # Default behavior if parent or speed is not accessible
