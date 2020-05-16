extends BasicUnit

class CombatData:
	var health
	var strength
	var defence
	
	func _init(health, strength, defence):
		self.health = health
		self.strength = strength
		self.defence = defence

class Attack:
	enum DamageType {
		NORMAL,
	}
	
	var damage
	var type
	
	func _init(type, damage):
		self.type = type
		self.damage = damage

class_name BasicMillitary

var combat_data

func attack_unit(attack, defender):
	# preform an attack and returns if the attack hits
	return false

func attack_building(attack, building):
	# preform an attack and returns if the attack hits
	return false

func _create_combat_data(health, strength, defence):
	return CombatData.new(health, strength, defence)

func _get_attacked(attack):
	self.combat_data.health -= attack.damage
	return true

func _init(health, strength, defence, speed).(speed):
	self.combat_data = self._create_combat_data(health, strength, defence)

func get_combat_data():
	return self.combat_data

func get_melee_attacks():
	return []

func get_ranged_attacks():
	return []

# base protected methods
func movement_cost(tiles, x_origin, y_origin, x_target, y_target):
	return .movement_cost(tiles, x_origin, y_origin, x_target, y_target)
