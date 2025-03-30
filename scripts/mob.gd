extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
@onready var health_component: HealthComponent = $HealthComponent
@export var speed:float = 300.0

func _ready() -> void:
	%Slime.play_walk()

func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_hit_box_component_hit_by_bullet(damage_amount: float) -> void:
	%Slime.play_hurt()


func _on_health_component_death() -> void:
	queue_free()

	const SMOKE_EXPLOSION = preload("res://smoke_explosion/smoke_explosion.tscn")
	var smoke = SMOKE_EXPLOSION.instantiate()
	get_parent().add_child(smoke)
	smoke.global_position = global_position
