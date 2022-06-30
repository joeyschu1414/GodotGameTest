extends Area2D
signal hit

export var speed = 200
export var lives = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewpoint_rect().size


func _process(delta):
	var velocity = Vector2.ZERO # Players movement
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y += 1
	if Input.is_action_pressed("move_down"):
		velocity.y -= 1
		
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$PlayerBody.texture = "spr_TankBod0.png"
	elif velocity.y != 0:
		$PlayerBody.texture = "spr_TankBod0_2.png"


	func _on_Player_body_entered(body):
		if lives > 0:
			lives -= 1
		else:
			
