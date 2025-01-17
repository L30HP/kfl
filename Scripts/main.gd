extends Node3D

@export_file("*.tscn") var next_level

# Called when the node enters the scene tree for the first time.
var active_checkpoint: Node3D
var points = 0
func _ready():
	for Checkpoint in $Map/Checkpoints.get_children():
		Checkpoint.hide()
	#show_checkpoint()
	update_points()


func crates_visible():
	var count = 0 
	for crate in $Map/Crates.get_children():
		if crate.visible:
			count += 1
	return count

func show_checkpoint():
	var i = randi_range(0, $Map/Checkpoints.get_children().size() - 1)
	var Checkpoint = $Map/Checkpoints.get_children()[i]
	Checkpoint.show()

func update_points():
	$HUD/Points.text = str(Game.points + points)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active_checkpoint and active_checkpoint.time_left > -delta:
		#var procent = $VehicleController2/VehicleRigidBody.speed * 3.6
		var progress = (100.0*active_checkpoint.time_left)/active_checkpoint.total_time
		$HUD.set_progressbar(progress)
		if progress <= 0:
			$HUD/ProgressBar.hide()
			$HUD/Stars.hide()
			
	if $Vehicle/VehicleController2/VehicleRigidBody2.speed > 3.0:
		$Intro.hide()
	elif not $Intro.visible:
		$Intro.show()
		$Intro/Restart.show()

func _on_checkpoint_checkpoint_entered(checkpoint: Node3D) -> void:
	if active_checkpoint:
		return

	checkpoint.active = true
	active_checkpoint = checkpoint

	$HUD/ProgressBar.show()
	$HUD/Stars.show()
	$Vehicle/VehicleController2/VehicleRigidBody2/Crate2.show()

func _on_easy_1_checkpoint_won(checkpoint: Node3D) -> void:
	points += $HUD.get_star_count()
	update_points()

	active_checkpoint = null
	$HUD/ProgressBar.hide()
	$HUD/Stars.hide()
	$Vehicle/VehicleController2/VehicleRigidBody2/Crate2.hide()

	if crates_visible() <= 0:
		$End.show()


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_next_pressed() -> void:
	Game.points += points
	get_tree().change_scene_to_file(next_level)
	
	
