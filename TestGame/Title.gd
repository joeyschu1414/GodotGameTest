extends CanvasLayer

signal start_game




func _ready():
	$Title.show()

func show_message(text):
	$Title.text = text
	$Title.show()
	$TitleTimer.start()

func show_game_over():
	show_message("Game Over")
	
	#Game over Screen Timer
	yield($TitleTimer, "timeout")
	
	#Change to Title Screen
	$Title.text = "TANKS!TANKS!TANKS!TANKS!\nTANKS!TANKS!TANKS!TANKS!"
	
	$Title.show()
	
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	
	

func show_win_screen():
	show_message("You Win!")
	
	#Game over Screen Timer
	yield($TitleTimer, "timeout")
	
	#Change to Title Screen
	$Title.text = "TANKS!TANKS!TANKS!TANKS!\nTANKS!TANKS!TANKS!TANKS!"
	
	$Title.show()
	
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()


func _process(delta):
	pass


func _on_TitleTimer_timeout():
	$Title.hide()
	


func _on_StartButton_pressed():
	$StartButton.hide()
	$Title.hide()
	emit_signal("start_game")
	
