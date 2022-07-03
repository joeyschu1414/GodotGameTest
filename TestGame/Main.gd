#Main Node
extends Node

export(PackedScene) var Enemy_scene
var lives
export var NumEnem = 3
export(PackedScene) var Player_bullet
export(PackedScene) var Enemy_bullet
var enemies
var EnemyPos
var EnemDefeat
  
func new_game():
	EnemDefeat = NumEnem
	$Player.start($PlayerStart.position)
	$Player.show()
	#get_tree().call_group("Enemies", "queue_free")
	var enemy_spawn
	enemies = []
	for n in NumEnem:
		
		enemies.append_array([Enemy_scene.instance()])
		enemies[n].connect("EHit", self, "EnemyHit")
		#enemies = Enemy_scene.instance()
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		enemies[n].position.x = rng.randf_range(50, 900)
		rng = RandomNumberGenerator.new()
		rng.randomize()
		enemies[n].position.y = rng.randf_range(50, 450)
		add_child(enemies[n])	
		
	
func PlayerWins():
	$Player.hide()
	$Title.show_win_screen()




func _ready():
	$Player.connect("PHit", self, "PlayerHit")
	connect("EHit", self, "EnemyHit")
	EnemDefeat = NumEnem
	
	
func game_over():
	$Title.show_game_over()
	for n in NumEnem:
		enemies[n].hide()
		enemies[n].queue_free()
func _process(delta):
	if EnemDefeat == 0:
		PlayerWins()
		
		
func PlayerHit():
	game_over()
	
func EnemyHit():
	EnemDefeat -= 1


