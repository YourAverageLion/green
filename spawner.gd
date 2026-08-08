extends Marker2D

var barrier_count:float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_timer_timeout() -> void:
	var newbarrier = preload("res://scorebarriers.tscn").instantiate()
	add_child(newbarrier)
	barrier_count += 1
	newbarrier.speed = 350.0*(1.0+(barrier_count/100.0))
	newbarrier.global_position = global_position
	
	pass # Replace with function body.
