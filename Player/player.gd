extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var has_key : bool = false
var has_double_jump : bool = false
var can_double_jump : bool = false
var is_hit: bool = false

func _ready() -> void:
	animated_sprite_2d.play("Idle")
	#GlobalVars.current_player = self

func _physics_process(delta: float) -> void:	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept"): 
		if is_on_floor():
			can_double_jump = true
			velocity.y = JUMP_VELOCITY
		if not is_on_floor() and has_double_jump and can_double_jump:
			can_double_jump = false
			velocity.y = JUMP_VELOCITY * 0.75

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
	if is_hit:
		return
	
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


func _on_pickup_area_area_entered(area: Area2D) -> void:
	if area.has_method("on_pickup"):
		area.on_pickup(self)

func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		print_debug("АААА")
		is_hit = true
		animated_sprite_2d.play("Hit")
		await animated_sprite_2d.animation_finished
		animated_sprite_2d.stop() 
		print_debug("Анимация завершилась")
		is_hit = false
		on_death()
