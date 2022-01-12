extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spawnPoints = [25, 50, 75, 100, 125, 150, 175, 200, 225, 250, 275]
var enemyList = []
var spawnTimer = Timer
var bigWallScene
var smallWallScene
var leftP = Sprite
var rightP = Sprite
var gameover = true

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnTimer = $"enemySpawnTimer"
	bigWallScene = preload("res://BigWall.tscn")
	smallWallScene = preload("res://SmallWall.tscn")
	#leftP = $"Player/AreaLeftP"
	#rightP = $"Player/AreaRightP"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for enemy in enemyList:
		enemy.position.y += 3
		if(enemy.position.y >= 397):
			enemyList.erase(enemy)
			enemy.queue_free()
		
	
	pass


func _on_enemySpawnTimer_timeout():
	if !gameover:
		var rand = randi()%2
		if rand == 1:
			var enemy = bigWallScene.instance()
			add_child(enemy)
			enemy.position = Vector2(spawnPoints[randi()%spawnPoints.size()], -96/2 - 1)
			enemyList.append(enemy)
			enemy.set_monitoring(true)
		else:
			var enemy = smallWallScene.instance()
			add_child(enemy)
			enemy.position = Vector2(spawnPoints[randi()%spawnPoints.size()], -32/2 - 1)
			enemyList.append(enemy)
			enemy.set_monitoring(true)
		
func _gameover():
	gameover = true

func _restart():
	spawnTimer.start()
	gameover = false

