extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")

@export var health: int = 10
@export var speed:float = 300.0

func _ready() -> void:
	%Slime.play_walk()

func _physics_process(delta: float) -> void:
	move_and_slide()

func take_damage(damage: int) -> void: 
	health -= damage
	%Slime.play_hurt()
	
	if health <= 0:
		queue_free()

		const SMOKE_EXPLOSION = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
