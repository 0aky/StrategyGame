extends Node

var _inited = false

const TileData = preload("res://scripts/data_type/tile_data.gd")
const TerrainData = preload("res://scripts/data_type/terrain_data.gd")
const BuildingData = preload("res://scripts/data_type/building_data.gd")
const UnitData = preload("res://scripts/data_type/unit_data.gd")


var BOARD_WIDTH = 23
var BOARD_HEIGHT = 11

var tiles = []
var changes = []

class Change:
	enum LEVEL {
		TERRAIN,
		BUILDING,
		UNIT,
	}
	
	var x
	var y
	var level
	
	func _init(x, y, level):
		self.x = x
		self.y = y
		self.level = level

func _init():
	if _inited:
		return
	_inited = true
	
	for i in range(BOARD_WIDTH):
		var col = []
		for j in range(BOARD_HEIGHT):
			col.append(TileData.new())
		tiles.append(col)
	
	for i in range(3):
		var r = int((BOARD_HEIGHT - 1) * (0.8 * i / 3 + 0.2))
		tiles[1][r].terrain_data.terrain_type = TerrainData.TerrainType.GOLD
		change_terrain(1, r)
		tiles[BOARD_WIDTH - 2][BOARD_HEIGHT - r - 1].terrain_data.terrain_type = TerrainData.TerrainType.GOLD
		change_terrain(BOARD_WIDTH - 2, BOARD_HEIGHT - r - 1)
	
	tiles[BOARD_WIDTH - 1][(BOARD_HEIGHT - 1) / 2].building_data.set_building_type(BuildingData.BuildingType.CASTLE)
	change_building(BOARD_WIDTH - 1, (BOARD_HEIGHT - 1) / 2)
	tiles[0][(BOARD_HEIGHT - 1) / 2].building_data.set_building_type(BuildingData.BuildingType.CASTLE)
	change_building(0, (BOARD_HEIGHT - 1) / 2)
	
	tiles[3][3].unit_data.add_millitary(UnitData.MillitaryUnit.WARRIOR)
	tiles[3][3].unit_data.add_civil(UnitData.CivilUnit.WORKER)
	change_unit(3, 3)
	tiles[2][2].unit_data.add_civil(UnitData.CivilUnit.WORKER)
	change_unit(2, 2)

func change_terrain(x, y):
	changes.append(Change.new(x, y, Change.LEVEL.TERRAIN))
	
func change_building(x, y):
	changes.append(Change.new(x, y, Change.LEVEL.BUILDING))
	
func change_unit(x, y):
	changes.append(Change.new(x, y, Change.LEVEL.UNIT))