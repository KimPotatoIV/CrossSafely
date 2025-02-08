extends CanvasLayer

##################################################
var score_label: Label
# 점수 라벨
var game_over_label: Label
# 게임 오버 라벨
var score: int = 0
# 잦은 점수 업데이트를 막기 위한 점수 지역 변수

##################################################
func _ready() -> void:
	score_label = $ScoreLabel
	game_over_label = $GameOverLabel
	# 점수 라벨과 게임 오버 라벨 설정

##################################################
func _process(delta: float) -> void:
	if not score == GM.get_score():
	# 점수 지역 변수가 게임 점수와 다를 때만
		score = GM.get_score()
		# 점수 지역 변수를 게임 점수와 동기화 
		score_label.text = "SCORE " + str(score)
		# 점수 라벨 업데이트
	
	game_over_label.visible = GM.get_game_over()
	# 게임 오버 여부에 따른 게임 오버 라벨 보이기 여부 설정
