class_name Player
extends CharacterBody2D

var count:int = 1
var prev_count: int = 1
var sprites = []
@export var tex : Texture2D
@onready var count_label : Label = $count_label

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func respawn_sprites():
	
	if count < 0:
		count = 0
	var found_invalid = false
	
	if count < 100:
		if prev_count > count:
			var diff = prev_count-count
			for i in range(diff):
				var removed = sprites.pop_back()
				if is_instance_valid(removed):
					removed.queue_free()
				else:
					found_invalid = true
			#for s in sprites:
				#s.queue_free()
			#sprites.clear()
		else:
			var diff = count-prev_count
			
			for i in range(diff):
				var sprite = preload("res://player_sprite.tscn").instantiate()
				sprites.append(sprite)
				add_child(sprite)

		var total_sprites = count
		for i in range(count):
			if i < sprites.size():
				sprites[i].index = i
				sprites[i].count = clamp(count,0,100)
				sprites[i].t = (float(i) / float(total_sprites)) * 2.0 * PI
			else:
				found_invalid = true
	if (count < 100 and prev_count > 100) or found_invalid:
		respawn_all_sprites()
	
	prev_count = count
	
	count_label.text = str(count)

func respawn_all_sprites():
	for i in range(sprites.size()):
		var sprite = sprites[i]
		sprite.queue_free()
	sprites.clear()
	prev_count = 0
	respawn_sprites()

func _ready() -> void:
	var sprite = preload("res://player_sprite.tscn").instantiate()
	sprites.append(sprite)
	add_child(sprite)
	respawn_sprites()
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
