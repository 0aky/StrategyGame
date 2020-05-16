extends Node

class_name BasicUnit

var speed

func _init(speed):
	self.speed = speed

func movement_cost(tiles, x_origin, y_origin, x_target, y_target):
	if x_target == x_origin:
		return abs(y_target - y_origin)
	elif y_target == y_origin:
		return abs(x_target - x_origin)
	return -1
