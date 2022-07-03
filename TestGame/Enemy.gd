#Enemy Node
extends Area2D
signal EHit

export(PackedScene) var Enemy_bullet

var startPos = 0
var EnemySp1 = preload("res://Sprites/spr_TankBod1.png")
var EnemySp2 = preload("res://Sprites/spr_TankBod1_2.png")
var velocity = Vector2.ZERO  
var EnemyNewBull
var EnemyShot = 0
export var IsDead = false

func _ready():
	velocity = Vector2.ZERO 
	IsDead = false
	$MoveTimer.start()
	$EnemyBulletDelay.start()


# enemies movement
func EnemyMove():
	velocity = Vector2.ZERO 
	var enemove = randi() % 4
	if enemove == 0:
		velocity.x += 3
	elif enemove == 1:
		velocity.x -= 3
	elif enemove == 2:
		velocity.y += 3
	elif enemove == 3:
		velocity.y -= 3
	$MoveTimer.start()

	
func EnemyFire():
	var willFire = randi() % 5
	if willFire == 1 :
		#get_node("EnemyCollision").disabled = true
		remove_child(EnemyNewBull)
		EnemyNewBull = Enemy_bullet.instance()
		add_child(EnemyNewBull)
		EnemyNewBull.show()
		EnemyNewBull.transform = $EnemyTank.transform
		EnemyShot = 1;
		$EnemyShotTimer.start()
		$EnemyBulletDelay.start()
		
	
	

func _process(delta):
	
	position += velocity * delta
	
	if velocity.x != 0:
		$EnemyBody.texture = EnemySp1
	elif velocity.y != 0:
		$EnemyBody.texture = EnemySp2
	$EnemyTank.rotation -= (PI / 100)
	
	


func _on_Enemy_body_entered(body):
	if body != EnemyNewBull:
		hide()
		IsDead = true
		emit_signal("EHit")
		$EnemyCollision.set_deferred("disabled", true)
	
	









func _on_EnemyShotTimer_timeout():
	#get_node("EnemyCollision").disabled = false
	EnemyShot = 0


