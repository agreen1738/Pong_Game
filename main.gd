extends Sprite2D

var score := [0, 0] # 0: Player, 1: CPU
const PADDLE_SPEED : int = 500
var game_started := false # Boolean to track if the game has started

func _ready():
	# Hide the ball initially
	$Ball.hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_select") and not game_started:
		game_started = true
		$Ball.show()
		$Ball.new_ball()
		$StartText.hide() # Hide the StartText label

func _on_ball_timer_timeout():
	if game_started:
		$Ball.new_ball()

func _on_score_left_body_entered(body):
	score[1] += 1
	$HUD/CPUScore.text = str(score[1])
	$BallTimer.start()

func _on_score_right_body_entered(body):
	score[0] += 1
	$HUD/PlayerScore.text = str(score[0])
	$BallTimer.start()
