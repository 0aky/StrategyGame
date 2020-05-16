extends Button

var board_data

func _ready():
	board_data = get_node("/root/board_data")

func _on_Button_pressed():
	board_data.tiles[1][1].building_data.set_building_type(BuildingData.BuildingType.CASTLE)
	board_data.change_building(1, 1)
	board_data.tiles[0][0].terrain_data.terrain_type = TerrainData.TerrainType.GOLD
	board_data.change_terrain(0, 0)
	board_data.tiles[0][1].terrain_data.terrain_type = TerrainData.TerrainType.GOLD
	board_data.change_terrain(0, 1)
	board_data.tiles[0][2].terrain_data.terrain_type = TerrainData.TerrainType.GOLD
	board_data.change_terrain(0, 2)
	board_data.tiles[1][0].terrain_data.terrain_type = TerrainData.TerrainType.GOLD
	board_data.change_terrain(1, 0)
	board_data.tiles[1][2].terrain_data.terrain_type = TerrainData.TerrainType.GOLD
	board_data.change_terrain(1, 2)
	board_data.tiles[2][0].terrain_data.terrain_type = TerrainData.TerrainType.GOLD
	board_data.change_terrain(2, 0)
	board_data.tiles[2][1].terrain_data.terrain_type = TerrainData.TerrainType.GOLD
	board_data.change_terrain(2, 1)
	board_data.tiles[2][2].terrain_data.terrain_type = TerrainData.TerrainType.GOLD
	board_data.change_terrain(2, 2)
