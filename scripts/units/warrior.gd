extends BasicMillitary

func _init().(100.0, 50.0, 30.0, 2):
	pass

func get_melee_attacks():
	var damage = .get_combat_data().strength
	return [Attack.new(Attack.DamageType, damage)]
