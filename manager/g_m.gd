extends Node

##################################################
var game_over: bool = false
# 게임 오버 여부
var game_score: int = 0
# 게임 점수
var player_position: Vector2
# 플레이어 좌표
# 자동차 생성 시 기준점으로 사용

##################################################
func get_game_over() -> bool:
	return game_over

##################################################
func set_game_over(game_over_value: bool) -> void:
	game_over = game_over_value

##################################################
func get_score() -> int:
	return game_score

##################################################
func set_score(score_value: int) -> void:
	game_score = score_value
	SM.score_audio_play()
	# 점수가 바뀔 때마다 효과음 재생

##################################################
func get_player_position() -> Vector2:
	return player_position

##################################################
func set_player_position(player_position_value: Vector2) -> void:
	player_position = player_position_value
