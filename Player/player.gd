extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.play("Idle")

func _physics_process(delta: float) -> void:	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	update_animation()
	move_and_slide()
	
	if position.y > 650:
		on_death()

func update_animation():
	if velocity.x < 0:
		animated_sprite_2d.flip_h = true
	elif velocity.x > 0: 
		animated_sprite_2d.flip_h = false	
	
	if velocity.x: #если прыжок
		animated_sprite_2d.play("Run")
	else:
		animated_sprite_2d.play("Idle")
	
	if velocity.y < 0: #если прыжок
		animated_sprite_2d.play("Jump")
	elif velocity.y > 0: #если падение
		animated_sprite_2d.play("Fall")

func on_death():
	self.queue_free()
	$"../CanvasLayer/DeathScreen".visible = true
