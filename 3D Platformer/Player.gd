extends KinematicBody

const MOUS_SENSIVITY = 0.3
onready var camera = $CamRoot/Camera

#Variablen für die Bewegung
var velocity = Vector3.ZERO
var current_vel = Vector3.ZERO
var direction = Vector3.ZERO

const SPEED = 10
const SPRINT_SPEED = 20
const ACCEL = 15.0

#Springen
const GRAVITY = -40
const JUMP_SPEED = 15
var jump_counter = 0
const AIR_ACCEL = 9.0
 


func _process(delta):
	window_activity()


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



#Alles was mit der Kamera zu tun hat
func _input(event):
	if event is InputEventMouseMotion:
		
		$CamRoot.rotate_x(deg2rad(event.relative.y * -1))
		
		self.rotate_y(deg2rad(event.relative.x * MOUS_SENSIVITY * -1))
		$CamRoot.rotation_degrees.x = clamp($CamRoot.rotation_degrees.x,-75 , 75)
		
		

func _physics_process(delta):
	direction = Vector3.ZERO
	
	if Input.is_action_pressed("forward"):
		direction -= camera.global_transform.basis.z
	if Input.is_action_pressed("backward"):
		direction += camera.global_transform.basis.z
	if Input.is_action_pressed("right"):
		direction += camera.global_transform.basis.x
	if Input.is_action_pressed("left"):
		direction -= camera.global_transform.basis.x
	
	direction = direction.normalized()
	
	velocity.y += GRAVITY * delta
	
	if is_on_floor():
		jump_counter = 0
		
	if Input.is_action_just_pressed("jump") and jump_counter < 2:
		jump_counter += 1
		velocity.y = JUMP_SPEED
		
		 
	
	var speed = SPRINT_SPEED if Input.is_action_pressed("sprint") else SPEED
	var target_vel = direction * speed
	
	var accel = ACCEL if is_on_floor() else AIR_ACCEL
	
	current_vel = current_vel.linear_interpolate(target_vel, accel * delta)
	velocity.x = current_vel.x
	velocity.z = current_vel.z
	
	velocity = move_and_slide(velocity, Vector3.UP,true, 4, deg2rad(45))
		
	
	
	
	

#Um die Maus zu zeigen oder zu verstecken
func window_activity():
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
