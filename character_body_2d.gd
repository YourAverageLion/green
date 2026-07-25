class_name Player
extends CharacterBody2D

var count:int = 0
var prev_count: int = 0
var sprites = []
@export var tex : Texture2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func respawn_sprites():
	if prev_count > count:
		var diff = prev_count-count
		for i in range(diff):
			var removed = sprites.pop_back()
			removed.queue_free()
		#for s in sprites:
			#s.queue_free()
		#sprites.clear()
	else:
		var diff = count-prev_count
		
		for i in range(diff):
			var sprite = preload("res://player_sprite.tscn").instantiate()
			sprites.append(sprite)
			add_child(sprite)
			#sprite.position = Vector2(randf_range(-5,5),randf_range(-5,5))
	var total_sprites = count
	for i in range(count):
		sprites[i].t = (float(i) / float(total_sprites)) * 2.0 * PI
	prev_count = count
		

func _ready() -> void:
	#respawn_sprites()
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
