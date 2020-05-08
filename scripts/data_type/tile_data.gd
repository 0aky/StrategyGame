extends Node

const TerrainData = preload("res://scripts/data_type/terrain_data.gd")
const BuildingData = preload("res://scripts/data_type/building_data.gd")

class_name TileData

var terrain_data
#var effect_data = 0
var building_data
#var unit_data = 0

func _init(terrain_data=null, building_data=null):
	if (terrain_data != null):
		self.terrain_data = terrain_data
	else:
		self.terrain_data = TerrainData.new()

	if (building_data != null):
		self.building_data = building_data
	else:
		self.building_data = BuildingData.new()

func _process(delta):
	terrain_data._process(delta)
	building_data._process(delta)

func to_string():
	return "{ terrain: " + self.terrain_data.to_string() + ", building: " + self.building_data.to_string() + "}"