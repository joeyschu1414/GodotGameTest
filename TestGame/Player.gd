#Player Tank Node
extends Area2D
signal PHit

export var speed = 20
var PlayerSp1 = preload("res://Sprites/spr_TankBod0.png")
var PlayerSp2 = preload("res://Sprites/spr_TankBod0_2.png")
var screen_size
export(PackedScene) var Player_bullet
var PlayerNewBull



#function called when the game starts
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()
	$PlayerBody.texture = PlayerSp1
	#$BulletDelay.start()



func _process(delta):
	var velocity = Vector2.ZERO # Players movement
	
	# Move Tank
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	if Input.is_action_pressed("rotate_left"):
		$PlayerTank.rotation += -(PI / 80)
		
		#$PlayerTank/PlayerBulletStart.transform.x = $PlayerTank.transform.x 
		#$PlayerTank/PlayerBulletStart.transform.y = $PlayerTank.transform.y 
	if Input.is_action_pressed("rotate_right"):
		$PlayerTank.rotation += (PI / 80)
		#$PlayerTank/PlayerBulletStart.transform.y = $PlayerTank.transform.y 
		#$PlayerTank/PlayerBulletStart.transform.y = $PlayerTank.transform.y
	
	
	
	
	#Set the Tank's speed
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	#Set the Tank's position and filed of play
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	#Animation change
	if velocity.x != 0:
		$PlayerBody.texture = PlayerSp1
	elif velocity.y != 0:
		$PlayerBody.texture = PlayerSp2
	
	 
	PlayerFire()
	
	
		
		

	
	
func PlayerFire():
	if Input.is_action_pressed("fire") :
		#get_node("CollisionShape2D").disabled = true
		remove_child(PlayerNewBull)
		PlayerNewBull = Player_bullet.instance()
		add_child(PlayerNewBull)
		PlayerNewBull.rotation = $PlayerTank.rotation
		#$PlayerShotTimer.start()




#Colision function
# warning-ignore:unused_argument
func _on_Player_body_entered(body):
	if body != PlayerNewBull:
		hide()
		emit_signal("PHit")
		$CollisionShape2D.set_deferred("disabled", true)
	











