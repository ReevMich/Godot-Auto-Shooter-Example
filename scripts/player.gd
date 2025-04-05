extends CharacterBody2D

signal dealth

@export var speed: float = 600.0
@export var display_health_bar: bool = false;
@onready var stats_component: StatsComponent = $StatsComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var health_bar_component: HealthBarComponent = $HealthBarComponent
@onready var hitbox_component: HurtBoxComponent = $HitBoxComponent

func _ready() -> void:
	#Sets initial health
	if health_component and stats_component:
		health_component.max_health = stats_component.stats.max_health
		health_component.current_health = stats_component.stats.max_health
		
	if display_health_bar:
		health_bar_component.show()
	else:
		health_bar_component.hide()
		
		

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	
	move_and_slide()
	
	if velocity.length() > 0.0:
		$HappyBoo.play_walk_animation()
	else:
		$HappyBoo.play_idle_animation()
		
	const DAMAGE_RATE = 2.0;
	var overlapping_mobs = hitbox_component.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health_component.damage(DAMAGE_RATE * overlapping_mobs.size() * delta)



func _on_health_component_death() -> void:
	dealth.emit() # Replace with function body.
