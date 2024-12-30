extends Node3D
var points = 0
# Called when the node enters the scene tree for the first time.
var active_checkpoint: Node3D

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#var procent = $VehicleController2/VehicleRigidBody.speed * 3.6
	var progress = $Map/Checkpoint.progress
	$HUD.set_progressbar(progress)
	if progress == 100:
		points += 1

func _on_checkpoint_checkpoint_entered(checkpoint: Node3D) -> void:
	active_checkpoint = checkpoint
	$HUD/ProgressBar.visible = true
