extends Node2D

var barrierdisable = false
@onready var left:=$leftwall
@onready var right:=$rightwall

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y+=100*delta
	
	if not barrierdisable:
		for body in left.get_overlapping_bodies():
			if body is Player:
				print("leftwall")
				barrierdisable = true
		for body in right.get_overlapping_bodies():
			if body is Player:
				print("rightwall")
				barrierdisable = true
	
	
	pass
