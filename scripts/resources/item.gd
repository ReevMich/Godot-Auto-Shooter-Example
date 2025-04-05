class_name Item extends Resource

@export var item_name: String
@export var item_type: ITEM_TYPE
@export var item_sprite: Texture2D
@export var scene: PackedScene
@export var stats: EntityStats
@export var rarity: RARITY
@export var description: String
@export var is_consumable: bool = false
@export var use_effect: StatusEffect

enum ITEM_TYPE { WEAPON, CONSUMABLE, UPGRADE, ARMOR, ACCESSORY }
enum RARITY { COMMON, UNCOMMON, RARE, EPIC, LEGENDARY }

func use(target: Node) -> bool:
	if not is_consumable or not use_effect:
		return false
		
	if target.has_method("apply_status_effect"):
		target.apply_status_effect(use_effect)
		return true
	return false
