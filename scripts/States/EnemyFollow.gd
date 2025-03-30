extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed: int = 140

const MAX_DISTANCE_FROM_PLAYER: int = 500;
const MIN_DISTANCE_FROM_PLAYER: int = 112;

var player: CharacterBody2D

func Enter():
	player = get_node("/root/Game/Player")
	
func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > MIN_DISTANCE_FROM_PLAYER:
		enemy.velocity = direction.normalized() * move_speed
	
	
	if direction.length() > MAX_DISTANCE_FROM_PLAYER:
		Transitioned.emit(self, "idle")
