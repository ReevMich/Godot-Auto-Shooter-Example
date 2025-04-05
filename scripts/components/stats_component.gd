extends Node
class_name StatsComponent

signal stats_changed(stats: EntityStats)

@export var stats: EntityStats:
	set(value):
		stats = value
		stats_changed.emit(stats)
