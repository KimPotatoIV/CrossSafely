extends CharacterBody2D

##################################################
enum STATE {
	# 플레이어 상태
	IDLE_U, IDLE_R, IDLE_D, IDLE_L,
	# 서 있는 네 방향
	WALK_U, 	WALK_R, 	WALK_D, 	WALK_L
	# 걷는 네 방향
}

##################################################
const MOVE_SPEED: float = 500.0
# 걷는 속도
const CELL_SIZE: float = 128.0
# 한 번에 이동하는 한 칸 크기

var destination: Vector2
# 이동 모적 좌표
var moving: bool = false
# 이동 중 여부
var state: STATE = STATE.IDLE_U
# 현재 상태
var anim_node: AnimatedSprite2D
var camera_node: Camera2D
# 애니메이션 및 카메라 노드

##################################################
func _ready() -> void:
	add_to_group("Player")
	# Player 그룹에 추가
	
	anim_node = $AnimatedSprite2D
	camera_node = $Camera2D
	# 각 노드 설정
	
	camera_node.position_smoothing_enabled = true
	# 카메라 부드러운 움직임 활성화
	destination = global_position
	# 시작 시 목적지를 현재 좌표로 설정
	
	GM.set_player_position(global_position)
	# 시작 시 플레이어 좌표 설정

##################################################
func _physics_process(delta: float) -> void:
	if not moving and not GM.get_game_over():
	# 이동 중이 아니고 게임 오버가 아닐 때
		if Input.is_action_just_pressed("ui_up"):
		# 위 입력 시
			input_process(STATE.WALK_U)
			# 방향에 맞는 이동 관련 연산 실행
			GM.set_score(GM.get_score() + 1)
			# 점수 증가
		elif Input.is_action_just_pressed("ui_right"):
		# 오른쪽 입력 시
			input_process(STATE.WALK_R)
			# 방향에 맞는 이동 관련 연산 실행
		elif Input.is_action_just_pressed("ui_down"):
		# 아래 입력 시
			input_process(STATE.WALK_D)
			# 방향에 맞는 이동 관련 연산 실행
			GM.set_score(GM.get_score() - 1)
			# 점수 감소
		elif Input.is_action_just_pressed("ui_left"):
		# 왼쪽 입력 시
			input_process(STATE.WALK_L)
			# 방향에 맞는 이동 관련 연산 실행
	
	move_player(state, delta)
	# 목적지까지 실제 이동
	
	if not GM.get_game_over():
		move_and_slide()
	# 게임 오버가 아닐 때만 이동 적용

##################################################
func input_process(state_value: STATE) -> void:
	match state_value:
		STATE.WALK_U:
			destination.y -= CELL_SIZE
		STATE.WALK_R:
			destination.x += CELL_SIZE
		STATE.WALK_D:
			destination.y += CELL_SIZE
		STATE.WALK_L:
			destination.x -= CELL_SIZE
	# state_value에 따른 목적지 설정. 1회 CELL_SIZE 만큼 이동
	
	moving = true
	# 이동 중 설정
	state = state_value
	# 현재 상태 설정
	set_state(state_value)
	# 상태에 따른 애니메이션 재생

##################################################
func move_player(state_value: STATE, delta: float) -> void:
	match state_value:
	# 맞는 상태에 따라
		STATE.WALK_U:
			if global_position <= destination:
			# 현재 좌표가 목적지에 도달했다면
				moving = false
				global_position = destination
				set_state(STATE.IDLE_U)
				GM.set_player_position(global_position)
				# 각 설정 및 현재 포지션 업데이트
				# 목표에 도달 한 시점에만 좌표 업데이트를 해야 자동차가 올바른 좌표에서 생성 됨
			if moving:
				global_position.y -= delta * MOVE_SPEED
			# 상태에 따른 방향으로 이동
		STATE.WALK_R:
			if global_position >= destination:
			# 현재 좌표가 목적지에 도달했다면
				moving = false
				global_position = destination
				set_state(STATE.IDLE_R)
				GM.set_player_position(global_position)
				# 각 설정 및 현재 포지션 업데이트
			if moving:
				global_position.x += delta * MOVE_SPEED
			# 상태에 따른 방향으로 이동
		STATE.WALK_D:
			if global_position >= destination:
			# 현재 좌표가 목적지에 도달했다면
				moving = false
				global_position = destination
				set_state(STATE.IDLE_D)
				GM.set_player_position(global_position)
				# 각 설정 및 현재 포지션 업데이트
			if moving:
				global_position.y += delta * MOVE_SPEED
			# 상태에 따른 방향으로 이동
		STATE.WALK_L:
			if global_position <= destination:
			# 현재 좌표가 목적지에 도달했다면
				moving = false
				global_position = destination
				set_state(STATE.IDLE_L)
				GM.set_player_position(global_position)
				# 각 설정 및 현재 포지션 업데이트
			if moving:
				global_position.x -= delta * MOVE_SPEED
			# 상태에 따른 방향으로 이동

##################################################
func set_state(state_value: STATE) -> void:
	match state_value:
		STATE.IDLE_U:
			anim_node.play("idle_u")
		STATE.IDLE_R:
			anim_node.play("idle_r")
		STATE.IDLE_D:
			anim_node.play("idle_d")
		STATE.IDLE_L:
			anim_node.play("idle_l")
		STATE.WALK_L:
			anim_node.play("walk_l")
		STATE.WALK_U:
			anim_node.play("walk_u")
		STATE.WALK_R:
			anim_node.play("walk_r")
		STATE.WALK_D:
			anim_node.play("walk_d")
# 상태에 따른 애니메이션 재생
