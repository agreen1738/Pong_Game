extends Sprite2D

var score := [0, 0] # 0: Player, 1: CPU
var PADDLE_SPEED : int = 500
var game_started := false # Boolean to track if the game has started
var start_position_player = Vector2(50, 324)
var start_position_cpu = Vector2(1082, 324)
var start_position_ball = Vector2(576, 324)

func _ready():
	# Hide the ball initially
	PADDLE_SPEED = 0
	$Ball.hide()
	$"GameWin".hide()
	$"GameLost".hide()
	start_color_swap()

func _process(delta):
	if Input.is_action_just_pressed("ui_select") and not game_started:
		$Player.position = start_position_player
		$CPU.position = start_position_cpu
		$Ball.position = start_position_ball
		game_started = true
		PADDLE_SPEED = 500
		$Ball.speed = 500
		$"GameWin".hide()
		$"GameLost".hide()
		$HUD/PlayerScore.text = str(0)
		score[0] = 0
		$HUD/CPUScore.text = str(0)
		score[1] = 0
		$Ball.show()
		$StartText.hide() # Hide the StartText label
		

func start_color_swap():
	# This will loop indefinitely until game_started is false
	while game_started == false:
		color_swap()
		await get_tree().create_timer(0.75).timeout  # Adjust the delay as needed

func _on_ball_timer_timeout():
	if game_started:
		$Ball.new_ball()

func _on_score_left_body_entered(body):
	score[1] += 1
	$HUD/CPUScore.text = str(score[1])
	$BallTimer.start()
	check_game_end()

func _on_score_right_body_entered(body):
	score[0] += 1
	$HUD/PlayerScore.text = str(score[0])
	$BallTimer.start()
	check_game_end()

func check_game_end():
	if score[0] >= 3 or score[1] >= 3:
		#Game Ends
		$Ball.hide()
		$Player.position = start_position_player
		$CPU.position = start_position_cpu
		$Ball.position = start_position_ball
		PADDLE_SPEED = 0
		$Ball.speed = 0
		game_started = false
		if score[0] > score[1]:
			$"GameWin".show()
		else:
			$"GameLost".show()
		start_color_swap()
		print(str($Ball.position))

func color_swap():	
	if $StartText.modulate == Color(1, 1, 1):
		$StartText.modulate = Color(1, 1, 0)
	else: 
		$StartText.modulate = Color(1, 1, 1)

	if $GameWin.modulate == Color(1, 1, 1):
		$GameWin.modulate = Color(1, 1, 0)
	else: 
		$GameWin.modulate = Color(1, 1, 1)

	if $GameLost.modulate == Color(1, 1, 1):
		$GameLost.modulate = Color(1, 0, 0)
	else: 
		$GameLost.modulate = Color(1, 1, 1)
