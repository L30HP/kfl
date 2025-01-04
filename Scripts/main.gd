extends Node3D
var points = 0
# Called when the node enters the scene tree for the first time.
var active_checkpoint: Node3D

func _ready():
	for Checkpoint in $Map/Checkpoints.get_children():
		Checkpoint.hide()
	#show_checkpoint()
		
func show_checkpoint():
	var i = randi_range(0, $Map/Checkpoints.get_children().size() - 1)
	var Checkpoint = $Map/Checkpoints.get_children()[i]
	Checkpoint.show()

func update_points():
	$HUD/Points.text = str(points)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active_checkpoint and active_checkpoint.time_left > 0:
		#var procent = $VehicleController2/VehicleRigidBody.speed * 3.6
		var progress = (100.0*active_checkpoint.time_left)/active_checkpoint.total_time
		$HUD.set_progressbar(progress)
		if progress < 0:
			$HUD/ProgressBar.hide()

func _on_checkpoint_checkpoint_entered(checkpoint: Node3D) -> void:
	if active_checkpoint:
		return

	checkpoint.active = true
	active_checkpoint = checkpoint

	$HUD/ProgressBar.show()
	$VehicleController2/VehicleRigidBody/Crate2.show()

func _on_easy_1_checkpoint_won(checkpoint: Node3D) -> void:
	if checkpoint.time_left > 0:
		points += 1
		update_points()

	active_checkpoint = null
	$HUD/ProgressBar.hide()
	$VehicleController2/VehicleRigidBody/Crate2.hide()
