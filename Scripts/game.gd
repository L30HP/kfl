extends Node2D

var points = 0

var has_touch = false

func _input(event):
	if event is InputEventScreenTouch:
		has_touch = true
