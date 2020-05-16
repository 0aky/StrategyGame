extends GridMap

const TerrainData = preload("res://scripts/data_type/terrain_data.gd")
const BuildingData = preload("res://scripts/data_type/building_data.gd")
const UnitData = preload("res://scripts/data_type/unit_data.gd")

var BUILDING_SCENES = {
	BuildingData.BuildingType.EMPTY: null,
	BuildingData.BuildingType.CASTLE: preload("res://scenes/castle.tscn")
}

var UNIT_SCENES = {
	UnitData.MillitaryUnit.NONE: null,
	UnitData.MillitaryUnit.WARRIOR: preload("res://scenes/millitary_units/warrior.tscn"),
	
	UnitData.CivilUnit.NONE: null,
	UnitData.CivilUnit.WORKER: preload("res://scenes/civil_units/worker.tscn"),
}

var board_data

func _ready():
	board_data = get_node("/root/board_data")

func _create_snapped_node(scene, x, y):
	var node = scene.instance()
	node.transform = node.transform.translated(Vector3(
		y - (board_data.BOARD_HEIGHT - 1) / 2,
		0,
		x - (board_data.BOARD_WIDTH - 1) / 2)
	)
	return node

func _update_units(unit, x, y, delta):
	if unit.needs_ui_update():
		if unit.millitary_unit_type != UnitData.MillitaryUnit.NONE:
			var millitary_scene = UNIT_SCENES[unit.millitary_unit_type]	
			if unit.node == null or not unit.node.is_object_instance_of(millitary_scene):
				if unit.node != null:
					self.get_parent().remove_child(unit.node)
					unit.node.queue_free()
				unit.node = self._create_snapped_node(millitary_scene, x, y)
				self.get_parent().add_child(unit.node)
			return
		else:
			var new_node = null
			
			if unit.civil_unit_type != UnitData.CivilUnit.NONE:
				var civil_scene = UNIT_SCENES[unit.civil_unit_type]
				if unit.node == null or not unit.node.is_object_instance_of(civil_scene):
					unit.node = self._create_snapped_node(civil_scene, x, y)
					self.get_parent().add_child(unit.node)
				else:
					new_node = unit.node
			
			if unit.node != null and unit.node == null:
				self.get_parent().remove_child(unit.node)
				unit.node.queue_free()
			
			unit.node = new_node

func _update_buildings(building, x, y, delta):
	if building.needs_replacement():
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
	for change in board_data.changes:
		match change.level:
			board_data.Change.LEVEL.TERRAIN:
				_update_terrain(board_data.tiles[change.x][change.y].terrain_data, change.x, change.y, delta)
			board_data.Change.LEVEL.BUILDING:
				_update_buildings(board_data.tiles[change.x][change.y].building_data, change.x, change.y, delta)
			board_data.Change.LEVEL.UNIT:
				_update_units(board_data.tiles[change.x][change.y].unit_data, change.x, change.y, delta)
	board_data.changes.clear()
	
#	for x in range(board_data.BOARD_WIDTH):
#		for y in range(board_data.BOARD_HEIGHT):
#			var tile = board_data.tiles[x][y]
#			_update_terrain(tile.terrain_data, x, y, delta)
#			_update_buildings(tile.building_data, x, y, delta)