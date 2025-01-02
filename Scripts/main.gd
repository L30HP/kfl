extends Node3D
var points = 0
# Called when the node enters the scene tree for the first time.
var active_checkpoint: Node3D

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active_checkpoint:
		#var procent = $VehicleController2/VehicleRigidBody.speed * 3.6
		var progress = (100.0*active_checkpoint.time_left)/active_checkpoint.total_time
		$HUD.set_progressbar(progress)

func _on_checkpoint_checkpoint_entered(checkpoint: Node3D) -> void:
	active_checkpoint = checkpoint
	$HUD/ProgressBar.visible = true


func _on_easy_1_checkpoint_won(checkpoint: Node3D) -> void:
	points += 1
	checkpoint.visible = false
