extends State
class_name EnemyFollow

@export var enemy: MobEnemy

const MAX_DISTANCE_FROM_PLAYER: int = 500;
const MIN_DISTANCE_FROM_PLAYER: int = 112;

var player: CharacterBody2D

var _move_speed: float

func init(_player) -> void:
	player = _player;

func Enter() -> void:
	if enemy and enemy.stats_component:
		_move_speed = enemy.stats_component.stats.move_speed
	
func Physics_Update(_delta: float) -> void:
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > MIN_DISTANCE_FROM_PLAYER:
		enemy.velocity = direction.normalized() * _move_speed
	
	if direction.length() > MAX_DISTANCE_FROM_PLAYER:
		Transitioned.emit(self, "idle")
