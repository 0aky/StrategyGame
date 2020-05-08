extends Camera

export(float) var ZOOM_SPEED = 7
export(float) var MOVMENT_SPEED = 10

func _ready():
	var board_data = get_node("/root/board_data")

func _physics_process(delta):
	var currnet_rotation = Quat(self.transform.basis)
	var movment = Vector3(0, 0, 0)
	var zoom = 0
	if Input.is_action_pressed("ui_left"):
		movment.z += MOVMENT_SPEED
	if Input.is_action_pressed("ui_right"):
		movment.z -= MOVMENT_SPEED
	if Input.is_action_pressed("ui_up"):
		movment.x -= MOVMENT_SPEED
	if Input.is_action_pressed("ui_down"):
		movment.x += MOVMENT_SPEED
	
	if Input.is_action_just_released("ui_zoom_in"):
		zoom += ZOOM_SPEED
	if Input.is_action_just_released("ui_zoom_out"):
		zoom -= ZOOM_SPEED
	
	movment = currnet_rotation.inverse() * movment
	movment += currnet_rotation * Vector3(zoom, 0, 0)
	
	self.transform = self.transform.translated(movment * delta)
