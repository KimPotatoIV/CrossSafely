extends Node2D

##################################################
const car_scene: PackedScene = preload("res://scenes/cars/car.tscn")
# 자동차 씬 미리 불러오기
const CELL_SIZE: float = 128.0
# 자동차 인스턴스 생성을 위한 간격. 플레이어 1회 이동 간격과 같음
const SCREEN_SIZE: Vector2 = Vector2(1920.0, 1080.0)
# 화면 크기

var spawn_timer: Timer
# 자동차 생성 주기 타이머

##################################################
func _ready() -> void:
	spawn_timer = $Timer
	spawn_timer.wait_time = 2.0
	spawn_timer.one_shot = true
	spawn_timer.autostart = true
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))	
	spawn_timer.start()
	# 타이머 설정 및 연결

##################################################
func _on_spawn_timer_timeout() -> void:
	var player_pos = GM.player_position
	for i in range(-19, 19):
		if not i % 2 == 0:
			car_spawn(player_pos, CELL_SIZE * i)
	# 플레이어 좌표 기준으로 위 아래 각 10줄씩 간격에 맞춰 자동차 생성

##################################################
func car_spawn(player_position: Vector2, offset: float) -> void:
	var spawn_true = randi_range(0, 1)
	if spawn_true == 0 or player_position.x / CELL_SIZE * 2 == 0:
		return
	# 1/2 확률로 자동차 생성
	
	var car_instance = car_scene.instantiate()
	var y_offset = player_position.y + offset	
	
	car_instance.global_position = \
	Vector2(player_position.x + SCREEN_SIZE.x / 1.5, y_offset)
	add_child(car_instance)
	# 자동차 인스턴스 설정 후 생성. 화면 우측 밖에서 생성
	# 플레이어 기준으로 위 아래 생성하기 때문에 플레이어가 이동하더라도 상관 없음
	
	if not GM.get_game_over():
		spawn_timer.start()
	# 게임 오버가 아닐 때만 타이머 재시작
