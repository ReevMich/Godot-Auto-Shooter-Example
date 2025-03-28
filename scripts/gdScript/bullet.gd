extends Area2D

signal hit

@export var speed: int = 1000
@export var range: int = 600

var damage;

var distance_travelled: int = 0

func init(_damage: int):
	damage = _damage

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
	distance_travelled += speed * delta
	if distance_travelled > range:
		queue_free()


func _on_body_entered(area) -> void:
	print('hit something')
	queue_free()
	
	if area is HitBoxComponent:
		var hitbox: HitBoxComponent = area;
		hitbox.take_damage(damage)
		
	hit.emit()
