extends Node

# Warrior
var Warrior = preload("res://scripts/units/warrior.gd")

# Civil
var Worker = preload("res://scripts/units/warrior.gd")

enum MillitaryUnit {
	NONE,
	WARRIOR,
	
	_END_OF_MILLITARY,
}

enum CivilUnit {
	NONE = MillitaryUnit._END_OF_MILLITARY,
	WORKER,
}


var MillitaryUnitClass = {
	MillitaryUnit.NONE: null,
	MillitaryUnit.WARRIOR: Warrior,
}


var CivilUnitClass = {
	CivilUnit.NONE: null,
	CivilUnit.WORKER: Worker,
}


class_name UnitData

var millitary_unit
var millitary_unit_type

var civil_unit
var civil_unit_type

var node

var needs_ui_update = false

func needs_ui_update():
	var temp = needs_ui_update
	needs_ui_update = false
	return temp

func _init(millitary_unit_type=MillitaryUnit.NONE, civil_unit_type=CivilUnit.NONE):
	self.millitary_unit_type = millitary_unit_type
	self.millitary_unit = MillitaryUnitClass[millitary_unit_type]
	
	self.civil_unit_type = civil_unit_type
	self.civil_unit = CivilUnitClass[civil_unit_type]
	
	self.node = null
	
	self.needs_ui_update = (millitary_unit_type != null or civil_unit_type != null)


func add_millitary(millitary_unit_type, millitary_unit=null):
	self.millitary_unit_type = millitary_unit_type
	self.millitary_unit = millitary_unit
	if millitary_unit == null:
		self.millitary_unit = MillitaryUnitClass[millitary_unit_type].new()

func remove_millitary():
	self.millitary_unit_type = MillitaryUnit.NONE


func add_civil(civil_unit_type, civil_unit=null):
	self.civil_unit_type = civil_unit_type
	self.civil_unit = civil_unit
	if civil_unit == null:
		self.civil_unit = CivilUnitClass[civil_unit_type].new()

func remove_civil():
	self.millitary_unit_type = CivilUnit.NONE

