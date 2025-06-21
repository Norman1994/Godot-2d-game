extends CharacterBody2D


const SPEED = 50.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var direction := -1
var can_turn := true
var spawn_position : Vector2

func _ready() -> void:
	velocity = Vector2.ZERO
	spawn_position = position
	if randf() < 0.5:
		direction = -1
	else:
		direction = 1
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_wall():
		print_debug("ТЫК")
		try_reverse()
		
	# Разворот на краю платформы
	var forward_ray = $"ray_left" if direction < 0 else $"ray_right"
	
	if not forward_ray.is_colliding():
		try_reverse()

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_animation()
	if position.y > 650:
		on_death()
	
func update_animation():
	if velocity.x < 0:
		animated_sprite_2d.flip_h = false
	elif velocity.x > 0: 
		animated_sprite_2d.flip_h = true	
	
	if velocity.x: #если прыжок
		animated_sprite_2d.play("Run")
	else:
		animated_sprite_2d.play("Idle")

func on_death():
	spawn_position = position
	
func try_reverse():
	if not can_turn:
		return
	direction *= -1
	can_turn = false
	await get_tree().create_timer(0.2).timeout  # Пауза между разворотами
	can_turn = true
