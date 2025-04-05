extends Area2D
class_name BulletComponent

signal bullet_hit(target: Node)
signal bullet_destroyed

@export var damage_amount: float = 10.0
@export var speed: float = 400.0
@export var max_distance: float = 1000.0
@export var pierce_count: int = 1
@export var knockback: float = 0.0

var direction: Vector2
var distance_traveled: float = 0.0
var current_pierce: int = 0

func _ready():
	# Connect to area entered signal for collision detection
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)

func initialize(start_pos: Vector2, target_pos: Vector2):
	global_position = start_pos
	direction = (target_pos - start_pos).normalized()
	# Set rotation to face movement direction
	rotation = direction.angle()

func _physics_process(delta: float) -> void:
	# Move the bullet
	var movement = direction * speed * delta
	position += movement
	
	# Track distance traveled
	distance_traveled += movement.length()
	
	# Check if bullet has traveled too far
	if distance_traveled >= max_distance:
		destroy_bullet()

func _on_area_entered(area: Area2D) -> void:
	# Check if the area is a hitbox
	if area is HurtBoxComponent:
		print("Bullet hit area")
		area.handle_bullet_collision(self)
		bullet_hit.emit(area)
		
		destroy_bullet()

func _on_body_entered(body: Node2D) -> void:
	# Handle collision with static bodies
	if body.is_class("StaticBody2D"):
		print("Bullet hit static body")
		destroy_bullet()

func destroy_bullet() -> void:
	bullet_destroyed.emit()
	queue_free()

# Optional: Add visual effects
func play_hit_effect() -> void:
	# You could spawn particles or play an animation here
	pass 
