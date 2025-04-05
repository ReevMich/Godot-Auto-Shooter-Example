extends Area2D

var damage: int = 2
var enemiesDetected: bool = false
var _enemies_in_range: Array[Node2D] = []

@onready var cooldown_timer: Timer = $"Timer"

func _physics_process(delta: float) -> void:
	_enemies_in_range = get_overlapping_bodies()
	
	if _enemies_in_range.size() > 0:
		var target_enemy = _enemies_in_range.front()
		look_at(target_enemy.global_position)
		enemiesDetected = true
	else:
		enemiesDetected = false

func shoot():
	if !enemiesDetected:
		return;
		
	const BULLET = preload("res://scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	#Make sure the rotation of the bullet is the same as the gun
	var shooting_point = get_node("Weapon Pivot/Pistol/ShootingPoint")
	new_bullet.initialize(shooting_point.global_position, _enemies_in_range.front().global_position)
	new_bullet.global_position = shooting_point.global_position
	new_bullet.global_rotation = shooting_point.global_rotation
	shooting_point.add_child(new_bullet)


func _on_timer_timeout() -> void:
	shoot()
