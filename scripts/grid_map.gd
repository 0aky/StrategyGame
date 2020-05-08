extends GridMap

const TerrainData = preload("res://scripts/data_type/terrain_data.gd")
const BuildingData = preload("res://scripts/data_type/building_data.gd")

var BUILDING_SCENES = {
	BuildingData.BuildingType.EMPTY: null,
	BuildingData.BuildingType.CASTLE: preload("res://scenes/castle.tscn")
}

var board_data

func _ready():
	board_data = get_node("/root/board_data")

func _update_buildings(building, x, y, delta):
	if building.update():
		if building.building_type == BuildingData.BuildingType.EMPTY and building.node != null:
			self.get_parent().remove_child(building.node)
			building.node.queue_free()
			building.node = null
		elif building.building_type != BuildingData.BuildingType.EMPTY and building.node == null:
				var scene = BUILDING_SCENES[building.building_type]
				building.node = scene.instance()
				building.node.transform = building.node.transform.translated(Vector3(
					y - (board_data.BOARD_HEIGHT - 1) / 2,
					0,
					x - (board_data.BOARD_WIDTH - 1) / 2)
				)
				self.get_parent().add_child(building.node)


func _get_terrain_mesh_id(terrain):
	if terrain.terrain_type == TerrainData.TerrainType.GOLD:
		return 1
	return 0


func _update_terrain(terrain, x, y, delta):
	var id = self.get_cell_item(y - ((board_data.BOARD_HEIGHT - 1) / 2), 0, x - ((board_data.BOARD_WIDTH - 1) / 2))
	if id == -1:
		print("Problem at: (" + str(x) + ", " + str(y) + ")")
	var new_id = _get_terrain_mesh_id(terrain)
	if new_id != id:
		self.set_cell_item(y - ((board_data.BOARD_HEIGHT - 1) / 2), 0, x - ((board_data.BOARD_WIDTH - 1) / 2), new_id)

func _process(delta):
	for x in range(board_data.BOARD_WIDTH):
		for y in range(board_data.BOARD_HEIGHT):
			var tile = board_data.tiles[x][y]
			_update_terrain(tile.terrain_data, x, y, delta)
			_update_buildings(tile.building_data, x, y, delta)