extends Node

enum BuildingType {
	EMPTY,
	CASTLE,
}

class_name BuildingData

# public vars
var building_type
var node

# private vars
var _needs_update

func _init(building_type=BuildingType.EMPTY):
	self.building_type = building_type
	self._needs_update = building_type != BuildingType.EMPTY
	self.node = null

func _process(delta):
	pass

func set_building_type(building_type):
	self.building_type = building_type
	self._needs_update = true

func update():
	var ret = _needs_update
	_needs_update = false
	return ret

func to_string():
	return str(building_type)