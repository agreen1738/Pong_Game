extends Sprite2D

var score := [0, 0] # 0: Player, 1: CPU
const PADDLE_SPEED : int = 500
var game_started := false # Boolean to track if the game has started

func _ready():
	# Hide the ball initially
	$Ball.hide()
	$"GameWin".hide()
	$"GameLost".hide()
	start_color_swap()

func _process(delta):
	if Input.is_action_just_pressed("ui_select") and not game_started:
		game_started = true
		$"GameWin".hide()
		$"GameLost".hide()
		$HUD/PlayerScore.text = str(0)
		score[0] = 0
		$HUD/CPUScore.text = str(0)
		score[1] = 0
		$Ball.show()
		$Ball.new_ball()
		$StartText.hide() # Hide the StartText label
		

func start_color_swap():
	# This will loop indefinitely until game_started is false
	while game_started == false:
		color_swap()
		await get_tree().create_timer(0.5).timeout  # Adjust the delay as needed

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
		game_started = false
		if score[0] > score[1]:
			$"GameWin".show()
		else:
			$"GameLost".show()
		start_color_swap()

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
