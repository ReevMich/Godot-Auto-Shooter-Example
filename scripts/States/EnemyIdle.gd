extends State
class_name EnemyIdle

@export var enemy: MobEnemy

var player: CharacterBody2D

const MIN_DISTANCE_TO_FOLLOW: int = 300;

var move_direction: Vector2
var wander_time: float
var _move_speed: float

func init(_player) -> void:
	player = _player

func randomize_wander(): 
	move_direction = Vector2(randf_range(-1,1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)
	
	if enemy and enemy.stats_component:
		_move_speed = enemy.stats_component.stats.move_speed * .25
		print(_move_speed)

func Enter():
	randomize_wander()

		
func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else: 
		randomize_wander()

func Physics_Update(delta: float):
	if enemy:
		enemy.velocity = move_direction * _move_speed
		
	var direction = player.global_position - enemy.global_position;
	if direction.length() < MIN_DISTANCE_TO_FOLLOW:
		Transitioned.emit(self, 'follow')
