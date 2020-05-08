extends GridMap

const BuildingData = preload("res://scripts/data_type/building_data.gd")

var BUILDING_SCENES = {
	BuildingData.BuildingType.EMPTY: null,
	BuildingData.BuildingType.CASTLE: preload("res://scenes/castle.tscn")
}

var board_data

func _ready():
	board_data = get_node("/root/board_data")

func _update_buildings(delta):
	for i in range(board_data.BOARD_WIDTH):
		for j in range(board_data.BOARD_HEIGHT):
			var building = board_data.tiles[i][j].building_data
			if (building.update()):
				if building.building_type == BuildingData.BuildingType.EMPTY and building.node != null:
					self.get_parent().remove_child(building.node)
					building.node.queue_free()
					building.node = null
				elif building.building_type != BuildingData.BuildingType.EMPTY and building.node == null:
						var scene = BUILDING_SCENES[building.building_type]
						building.node = scene.instance()
						building.node.transform = building.node.transform.translated(Vector3(
							j - (board_data.BOARD_HEIGHT - 1) / 2,
							0,
							i - (board_data.BOARD_WIDTH - 1) / 2)
						)
						self.get_parent().add_child(building.node)


func _process(delta):
	_update_buildings(delta)