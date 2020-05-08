extends Node

enum TerrainType {
	EMPTY,
}

class_name TerrainData

var terrain_type

func _init(terrain_type=TerrainType.EMPTY):
	self.terrain_type = terrain_type

func _process(delta):
	pass

func to_string():
	return str(terrain_type)