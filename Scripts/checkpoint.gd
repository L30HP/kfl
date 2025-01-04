extends Node3D

var time_left = 0
var active = false

@export var total_time = 5.0
@export var end: Area3D

signal checkpoint_entered(checkpoint: Node3D)
signal checkpoint_won(checkpoint: Node3D)

# Called when the node enters the scene tree for the first time.
func _ready():
	end.hide()
	end.connect("body_entered", _on_end_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		time_left -= delta

func _on_body_entered(body):
	if not visible:
		return
	
	active = true
	checkpoint_entered.emit(self)
	end.show()
	time_left = total_time

func _on_body_exited(body):
	pass

func _on_end_body_entered(body: Node3D) -> void:
	if not end.visible:
		return

	active = false
	if time_left > 0:
		checkpoint_won.emit(self)
	end.hide()
