extends SquareCamera3D

@export var target: RigidBody3D
@export var base_follow_speed: float = 0.05  # Base speed of following
@export var offset: Vector3 = Vector3(0, 10, 0)  # Camera offset from the player
@export var distance_factor: float = 2.0  # How much the speed increases with distance
@export var overshoot_factor: float = 1.0  # Overshoot, to look further in the direction the player travels
@export var extra_offset_scale: float = 0.1 # How much to zoom out with velocity

@onready var initial_fov := fov
@onready var extra_offset_factor := 0.0

var last_position: Vector3

func _physics_process(delta: float) -> void:
	if target:
		var velocity = (target.position - last_position)*20.
		last_position = target.position

		# First remove old extra offset, to avoid it affecting distance calculation
		global_transform.origin -= offset * (1.0 + extra_offset_factor)
		
		# Desired position based on the target's position plus the offset
		var target_position = target.global_transform.origin + velocity * overshoot_factor

		# Calculate the distance between the camera and the target position
		var distance_to_target = global_transform.origin.distance_to(target_position)

		# Adjust the speed based on the distance to the target
		var adjusted_speed = base_follow_speed + (distance_to_target * distance_factor)

		# Smoothly move the camera towards the target position, with adjusted speed
		global_transform.origin = global_transform.origin.move_toward(target_position, adjusted_speed * delta)

		# Re-apply offset
		global_transform.origin += offset * (1.0 + extra_offset_factor)

		# Adjust offset based on speed, to zoom out when speed increases
		var target_offset_factor = velocity.length() * extra_offset_scale
		if target_offset_factor > extra_offset_factor:
			extra_offset_factor = move_toward(extra_offset_factor, target_offset_factor, 5*delta)
		else:
			extra_offset_factor = move_toward(extra_offset_factor, target_offset_factor, .125*delta)
