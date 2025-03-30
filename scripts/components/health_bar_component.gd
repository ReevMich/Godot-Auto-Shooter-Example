extends ProgressBar
class_name HealthBarComponent

@export var health_component: HealthComponent


func _ready() -> void:
	health_component.health_changed.connect(update_health)
	update_health(0,0, health_component.get_current_health_percentage())
 	

func update_health(current_health: float, max_health: float, health_percentage: float):
	value = health_percentage * 100
