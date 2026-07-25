extends Sprite2D

@onready var player : Player = $"../"
var t = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	t = randf_range(0,2*PI)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var center = player.global_position
	global_position = Vector2(cos(t)*30, sin(t)*30) + center
	t+=delta
	pass
