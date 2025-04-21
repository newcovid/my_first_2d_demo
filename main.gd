extends Node

@export var mob_scene: PackedScene
var score

# 当节点首次进入场景树时调用。
func _ready():
	new_game()


# 每个帧都被调用。'delta'是前一个帧以来的经过时间。
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_mob_timer_timeout() -> void:
	# 创建 Mob 场景的新实例。
	var mob = mob_scene.instantiate()

	# 在 Path2D 上选择一个随机位置。
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# 将mob的位置设置为随机位置。
	mob.position = mob_spawn_location.position

	# 将mob的方向设置为与路径方向垂直。
	var direction = mob_spawn_location.rotation + PI / 2

	# 为方向添加一些随机性。
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# 为怪物选择速度。
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# 通过将怪物添加到主场景中来生成它。
	add_child(mob)
	pass # Replace with function body.


func _on_score_timer_timeout() -> void:
	score += 1
	pass # Replace with function body.


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	pass # Replace with function body.
