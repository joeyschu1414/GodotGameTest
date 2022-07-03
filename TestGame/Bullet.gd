#Bullet Node
extends KinematicBody2D

export var speed = 200
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	show()
	screen_size = get_viewport_rect().size

	


func _process(delta):
	var velocity = Vector2.ZERO # bullet movement
	
	#Determines the direction of the bullet when it is spawned
	
	if rotation < (PI / 2) && rotation > 0:
		velocity.x += 1
		velocity.y -= 1
	elif rotation < PI && rotation > (PI / 2):
		velocity.x -= 1
		velocity.y -= 1
	elif rotation < ((3 * PI)/2) && rotation > PI:
		velocity.x -= 1
		velocity.y += 1
	elif rotation < (2 * PI) && rotation > ((3 * PI)/2):
		velocity.x += 1
		velocity.y += 1
	elif rotation == (PI / 2):
		velocity.y -= 1
	elif rotation == PI:
		velocity.x -= 1
	elif rotation == ((3 * PI)/2):
		velocity.y += 1
	else:
		velocity.x += 1
	
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += transform.x * speed * delta
	
	


