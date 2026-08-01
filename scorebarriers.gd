extends Node2D

var barrierdisable = false
@onready var left:=$leftwall
@onready var right:=$rightwall
@onready var RightLabel:=$rightwall/RightLabel
@onready var LeftLabel:=$leftwall/LeftLabel

var operators = ["+", "-", "*", "/"]
var left_op = ""
var right_op = ""
var left_number = 0
var right_number = 0
var speed = 350

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	left_op = operators.pick_random()
	right_op = operators.pick_random()
	match left_op:
		"+":
			left_number = randi_range(-5,5)
		"-":
			left_number = randi_range(-5,5)
		"*":
			left_number = randi_range(0,3)
		"/":
			left_number = randi_range(1,10)
	match right_op:
		"+":
			right_number = randi_range(-5,5)
		"-":
			right_number = randi_range(-5,5)
		"*":
			right_number = randi_range(0,3)
		"/":
			right_number = randi_range(1,10)
	LeftLabel.text = "%s %d"%[left_op, left_number]
	RightLabel.text = "%s %d"%[right_op, right_number]
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y+=speed*delta
	
	if not barrierdisable:
		for body in left.get_overlapping_bodies():
			if body is Player:
				
				print("leftwall")
				
				match left_op:
					"+":
						body.count += left_number
					"-":
						body.count -= left_number
					"*":
						body.count *= left_number
					"/":
						body.count /= left_number
				
				#body.count+=1
				body.respawn_sprites()
				barrierdisable = true
		for body in right.get_overlapping_bodies():
			if body is Player:

				print("rightwall")
				match right_op:
					"+":
						body.count += right_number
					"-":
						body.count -= right_number
					"*":
						body.count *= right_number
					"/":
						body.count /= right_number
				
				#body.count-=1
				body.respawn_sprites()
				barrierdisable = true
	
	
	pass
