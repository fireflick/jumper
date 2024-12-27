extends CharacterBody2D

@export var bullet: PackedScene
@onready var shoot_sound: AudioStreamPlayer2D = $shootSound

var can_shoot: bool = true

const BULLET_SPEED =  324
const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const DOUBLE_JUMP_VELOCITY = -200.0
const LAUNCH_RESET_MSEC = 300
var max_slope_angle = 45

var facing_right = true
var can_double_jump = false
var double_jump_window = 0.2
var double_jump_timer = 0
var jump_count = 0
var max_jumps = 2


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $jump_sound
@onready var _2_jump_sound: AudioStreamPlayer2D = $"2_jump_sound"

func _physics_process(delta):
	var is_on_ground = is_on_floor()
	if is_on_ground:
		jump_count = 0
		
	# Add the gravity.
	if not is_on_ground:
		velocity.y += gravity * delta
		
	spawn_bullet()
		
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_ground:
			jump()
		elif jump_count < max_jumps:
			double_jump()

	if can_double_jump  and not is_on_ground:
		double_jump_timer -= delta
		if double_jump_timer <= 0:
			can_double_jump = false

	# Get the input direciton: -1, 0, 1,
	var direction = Input.get_axis("move_left", "move_right")
	
	#Flip the Sprite
	if direction > 0:
		facing_right = true
		animated_sprite.flip_h = false
	elif direction < 0:
		facing_right = false
		animated_sprite.flip_h = true
	
	#Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func jump():
	velocity.y = JUMP_VELOCITY
	jump_count += 1
	can_double_jump = true
	double_jump_timer = double_jump_window
	jump_sound.play()

func double_jump():
	velocity.y = DOUBLE_JUMP_VELOCITY
	jump_count += 1
	can_double_jump = false
	_2_jump_sound.play()
	
func launch(force: Vector2):
	velocity += force
	
func spawn_bullet():
	if can_shoot and Input.is_action_just_pressed("Shoot"):
		var bullet_instance = bullet.instantiate()
		bullet_instance.global_transform = global_transform
		var facing_direction = global_transform.x.normalized()
		bullet_instance.global_position.y -= 7
		bullet_instance.velocity = Vector2(1.0, 0).normalized() * BULLET_SPEED
		if (facing_right == false):
			bullet_instance.global_position.x -= 20
			bullet_instance.velocity = Vector2(-1.0, 0).normalized() * BULLET_SPEED
			bullet_instance.rotation_degrees = 180
		
		get_parent().add_child(bullet_instance)
		shoot_sound.play()
		
