extends CharacterBody2D
class_name MobEnemy

@onready var player = get_node("/root/Game/Player")
@onready var stats_component: StatsComponent = $StatsComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var state_machine: StateMachine = $"State Machine"

func _ready() -> void:
	state_machine.initialize(player)
	# Set initial health
	if health_component and stats_component:
		health_component.max_health = stats_component.stats.max_health
		health_component.current_health = stats_component.stats.max_health

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _on_hit_box_component_hit_by_bullet(_damage_amount: float) -> void:
	%Slime.play_hurt()

func _on_health_component_death() -> void:
	queue_free()

	const SMOKE_EXPLOSION: PackedScene = preload("res://smoke_explosion/smoke_explosion.tscn")
	var smoke: Node2D = SMOKE_EXPLOSION.instantiate()
	get_parent().add_child(smoke)
	smoke.global_position = global_position
