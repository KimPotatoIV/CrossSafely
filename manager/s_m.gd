extends Node

##################################################
var audio_player: AudioStreamPlayer
# 효과음 플래이어
var bgm_player: AudioStreamPlayer
# 배경음악 플레이어
var game_over_stream: AudioStream = preload("res://sounds/game_over.wav")
var game_score_stream: AudioStream = preload("res://sounds/maou_se_onepoint26.wav")
var bgm_stream: AudioStream = preload("res://sounds/cross_safely.wav")
# 각 효과음 미리 불러오기

##################################################
func _ready() -> void:
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	# 효과음 플레이어 설정
	
	bgm_player = AudioStreamPlayer.new()
	add_child(bgm_player)
	bgm_player.stream = bgm_stream
	bgm_player.play()
	# 배경음악 플레이어 설정 및 재생

##################################################
func game_over_audio_play() -> void:
	audio_player.stream = game_over_stream
	audio_player.play()
	# 게임 오버 사운드 재생

##################################################
func score_audio_play() -> void:
	audio_player.stream = game_score_stream
	audio_player.play()
	# 게임 점수 바뀔 때마다 재생
