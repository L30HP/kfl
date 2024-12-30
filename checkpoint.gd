extends Node3D
var progress = 0
var active = false

signal checkpoint_entered(checkpoint: Node3D)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label3D.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		progress += (100 / 5) * delta
	else:
		progress = 0


func _on_body_entered(body):
	active = true
	$Label3D.visible = true
	checkpoint_entered.emit(self)


func _on_body_exited(body):
	active = false
	$Label3D.visible = false
