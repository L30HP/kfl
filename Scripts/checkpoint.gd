extends Node3D
var time_left = 0
var active = false

@export var total_time = 5.0

signal checkpoint_entered(checkpoint: Node3D)
signal checkpoint_won(checkpoint: Node3D)

@onready var end: Area3D = $End


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label3D.visible = false
	end.hide()
	print("ready")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		time_left -= delta

func _on_body_entered(body):
	if not visible: return
	active = true
	$Label3D.visible = true
	checkpoint_entered.emit(self)
	end.show()
	time_left = total_time
	print("on_entered")

func _on_body_exited(body):
	$Label3D.visible = false

func _on_end_body_entered(body: Node3D) -> void:
	if not end.visible:
		return
	print("on_end_entered")
	active = false
	if time_left > 0:
		checkpoint_won.emit(self)
	end.hide()
