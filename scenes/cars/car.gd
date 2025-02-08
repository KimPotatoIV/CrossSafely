extends RigidBody2D

##################################################
const texture_0: Texture = preload("res://scenes/cars/car_0.png")
const texture_1: Texture = preload("res://scenes/cars/car_1.png")
const texture_2: Texture = preload("res://scenes/cars/car_2.png")
# 자동차 텍스처 세 가지 미리 불러오기
const SPEED: float = 50.0
# 자동차 이동 속도

var velocity: Vector2
# 자동차 방향 및 속도 벡터

##################################################
func _ready() -> void:
	gravity_scale = 0.0
	lock_rotation = true
	# 중력 제거 및 회전 고정
	
	var rand_texture = randi_range(0, 2)
	match rand_texture:
		0: $Sprite2D.texture = texture_0
		1: $Sprite2D.texture = texture_1
		2: $Sprite2D.texture = texture_2
	# 인스턴스 준비 시 임의의 세 텍스처 중 하나를 골라 설정
	
	connect("body_entered", Callable(self, "_on_body_entered"))
	# 충돌 시 _on_body_entered 함수와 연결

##################################################
func _physics_process(delta: float) -> void:
	if not GM.get_game_over():
	# 게임 오버가 아닐 때
		velocity.x -= delta * SPEED
		linear_velocity = velocity
		# 우에서 좌로 속도에 따라 velocity에 설정 및 적용

##################################################
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		# 충돌 그룹이 Player면
		if not GM.get_game_over():
			SM.game_over_audio_play()
		# 게임 오버가 아닐 때 게임 오버 사운드 재생
		# 1회 재생을 위해 if문 사용
		
		GM.set_game_over(true)
		# 게임 오버 설정
