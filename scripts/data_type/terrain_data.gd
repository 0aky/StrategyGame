extends Node

enum TerrainType {
	EMPTY,
	GOLD,
}

class_name TerrainData

var terrain_type

func _init(terrain_type=TerrainType.EMPTY):
	self.terrain_type = terrain_type


func to_string():
	return str(terrain_type)