extends Node

var _inited = false

const TileData = preload("res://scripts/data_type/tile_data.gd")
const BuildingData = preload("res://scripts/data_type/building_data.gd")


var BOARD_WIDTH = 23
var BOARD_HEIGHT = 11

export var tiles = []

func _init():
	if _inited:
		return
	_inited = true
	
	for i in range(BOARD_WIDTH):
		var col = []
		for j in range(BOARD_HEIGHT):
			var tile = TileData.new()
			if j == (BOARD_HEIGHT - 1) / 2 and (i == 0 or i == BOARD_WIDTH - 1):
				tile.building_data.set_building_type(BuildingData.BuildingType.CASTLE)
			col.append(tile)
		tiles.append(col)
	
	
