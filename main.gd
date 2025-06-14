
class_name Main extends Node2D

enum GameState { PLAYING, PAUSED, GAME_OVER }
var state : GameState = GameState.PLAYING
var play_time_sec : float = 0.0




@onready var player_camera: Camera2D = $PlayerCamera
@onready var player: Node2D = $Player

@onready var world: Node2D = $"."
@onready var gui      : CanvasLayer = $GUI

# -----------------------[Ready]----------------------------------------------------------------------------------
func _ready() -> void:
	gui.get_node("PauseMenu").visible = false





func _process(delta: float) -> void:
	if state == GameState.PLAYING:
		play_time_sec += delta

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_toggle_pause()
	elif event.is_action_pressed("debug_screenshot"):
		_take_screenshot()


func _toggle_pause() -> void:
	state = GameState.PAUSED if state == GameState.PLAYING else GameState.PLAYING
	get_tree().paused = (state == GameState.PAUSED)
	gui.get_node("PauseMenu").visible = get_tree().paused

func goto_game_over() -> void:
	state = GameState.GAME_OVER
	get_tree().paused = true
	gui.get_node("GameOverMenu").visible = true






# ------------------------[Utl]--------------------------

func _take_screenshot() -> void:
	var img := get_viewport().get_texture().get_image()
	img.save_png("user://shot_%s.png" % Time.get_datetime_string_from_system())
