extends Node2D

func _ready() -> void:
	%GameOver.hide()

func spawn_mob():
	var new_mob = preload("res://scenes/mob.tscn").instantiate()
	%SpawnPath.progress_ratio = randf()
	new_mob.global_position = %SpawnPath.global_position
	%Enemies.add_child(new_mob)


func _on_spawn_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	Engine.time_scale = 0.5
	await get_tree().create_timer(2).timeout;
	%GameOver.show()
	
	get_tree().paused = true
	
	
