extends Node

const TerrainData = preload("res://scripts/data_type/terrain_data.gd")
const BuildingData = preload("res://scripts/data_type/building_data.gd")
const UnitData = preload("res://scripts/data_type/unit_data.gd")

class_name TileData

var terrain_data
#var effect_data = 0
var building_data
var unit_data

func _init(terrain_data=null, building_data=null, unit_data=null):
	if (terrain_data != null):
		self.terrain_data = terrain_data
	else:
		self.terrain_data = TerrainData.new()

	if (building_data != null):
		self.building_data = building_data
	else:
		self.building_data = BuildingData.new()

	if (unit_data != null):
		self.unit_data = unit_data
	else:
		self.unit_data = UnitData.new()

func _process(delta):
	terrain_data._process(delta)
	building_data._process(delta)
	unit_data._process(delta)