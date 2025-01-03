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
	if active_checkpoint:
		#var procent = $VehicleController2/VehicleRigidBody.speed * 3.6
		var progress = (100.0*active_checkpoint.time_left)/active_checkpoint.total_time
		$HUD.set_progressbar(progress)
		if progress < 0:
			$HUD/ProgressBar.hide()
			active_checkpoint.hide()
			active_checkpoint.end.hide()
			active_checkpoint = null
			points -= 1
			update_points()
			#show_checkpoint()

func _on_checkpoint_checkpoint_entered(checkpoint: Node3D) -> void:
	if active_checkpoint:
		return
		
	active_checkpoint = checkpoint
	$HUD/ProgressBar.show()
	active_checkpoint.hide()
	active_checkpoint.end.show()
	$VehicleController2/VehicleRigidBody/Crate2.show()

func _on_easy_1_checkpoint_won(checkpoint: Node3D) -> void:
	points += 1
	update_points()
	checkpoint.hide()
	$HUD/ProgressBar.hide()
	#show_checkpoint()
	$VehicleController2/VehicleRigidBody/Crate2.hide()
