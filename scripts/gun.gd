extends Area2D

var damage: int = 2
var enemiesDetected: bool = false

func _physics_process(delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
		enemiesDetected = true
	else:
		enemiesDetected = false

func shoot():
	if !enemiesDetected:
		return;
		
	const BULLET = preload("res://scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.init(damage)
	var shooting_point = get_node("Weapon Pivot/Pistol/ShootingPoint")
	new_bullet.global_position = shooting_point.global_position
	new_bullet.global_rotation = shooting_point.global_rotation
	shooting_point.add_child(new_bullet)


func _on_timer_timeout() -> void:
	shoot()
