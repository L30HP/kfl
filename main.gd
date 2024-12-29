extends Node3D
var points = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#var procent = $VehicleController2/VehicleRigidBody.speed * 3.6
	var progress = $Map/Checkpoint.progress
	$HUD.set_progressbar(progress)
	if progress == 100:
		points += 1
