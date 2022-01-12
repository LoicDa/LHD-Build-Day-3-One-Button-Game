extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var leftP = Sprite
var rightP = Sprite
var direction = -1 #used to modify movement direction
var pressedLastFrame = false
var speed = 2
var scoreText = Label
var score = 0
var gameover = true

# Called when the node enters the scene tree for the first time.
func _ready():
	leftP = $"AreaLeftP"
	rightP = $"AreaRightP"
	scoreText = $"../display/vLayout/score"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !gameover:
		if Input.is_action_pressed("ui_select") && pressedLastFrame: #player keeps pressing
			leftP.position.x  += direction*speed
			rightP.position.x = 300.0 - leftP.position.x
		elif Input.is_action_pressed("ui_select") && !pressedLastFrame: #player just pressed and direction must be changed
			pressedLastFrame = true
			direction = -1*direction
			leftP.position.x  += direction*speed
			rightP.position.x -= direction*speed
		else: #player doesn't press the button
			pressedLastFrame = false
		
		#Correct the direction if goes to far
		if leftP.position.x >= 150-32/4:
			leftP.position.x = 150-32/4-0.5
			direction = -1
		if leftP.position.x <= 32/2:
			leftP.position.x = 32/2+0.5
			direction = 1
		score += delta*3 #score depends on time
		scoreText.text = String(score as int)
	
func _gameover():
	$".."._gameover()
	gameover = true
	$"../UI".visible = true
	$"../UI/ColorRect/VBoxContainer/titreLbl".text = "GAME OVER"
	$"../UI/ColorRect/VBoxContainer/scoreLbl".text = String(score as int)
	direction = -1 
	pressedLastFrame = false
	score = 0
	scoreText.text = "0"
	leftP.position.x = 50
	rightP.position.x = 300.0 - leftP.position.x


func _on_AreaLeftP_area_entered(area):
	_gameover()

func _on_AreaRightP_area_entered(area):
	_gameover()

func _on_noButton_pressed():
	get_tree().quit()


func _on_yesButton_pressed():
	$"../UI".visible = false
	gameover = false
	$".."._restart()
	
