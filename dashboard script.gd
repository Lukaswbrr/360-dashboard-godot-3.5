extends Control

onready var tabs_node = $Background/TabContainer
onready var tab1_startbutton = $Background/TabContainer/home/LeftContainer/GreenButton
onready var anim = $AnimationPlayer

onready var sound_select = $Sounds/Select
onready var sound_back = $Sounds/Back
onready var sound_slide1 = $Sounds/Slide1
onready var sound_slide2 = $Sounds/Slide2
onready var sound_special = $Sounds/Special
onready var sound_select_box = $Sounds/Select_box

onready var select_button_text = $Background/SelectButton/Text

onready var error_popup = $Background/ErrorPopup

var disabled = false
var selected = false
var special_selected = false

var current_focus

func _process(_delta):
	if Input.is_action_just_pressed("next_tab"):
		if !tabs_node.current_tab == tabs_node.get_tab_count() - 1:
			if selected:
				return
			sound_slide1.play()
			tabs_node.current_tab += 1
	elif Input.is_action_just_pressed("previous_tab"):
		if selected:
			return
		if !tabs_node.current_tab == 0:
			sound_slide2.play()
			tabs_node.current_tab -= 1
	
	if Input.is_action_just_pressed("ui_accept"):
		if DemoDashBoardGlobalVariables.dashboard_disabled:
			return
		if !selected:
			stop_sounds()
			if current_focus.name == "MeltyBloodButton" and tabs_node.current_tab == 0:
				DemoDashBoardGlobalVariables.dashboard_disabled = true
				special_selected = true
				sound_special.play()
				anim.play("fade_out_special")
				get_tree().create_timer(3.0).connect("timeout", self, "_timer_out" )
			else:
				sound_select.play()
				anim.play("fade_out")
			current_focus.release_focus()
			selected = true
	
	if Input.is_action_just_pressed("ui_cancel"):
		if special_selected:
			return
		if selected:
			current_focus.grab_focus()
			anim.play("fade_in")
			stop_sounds()
			sound_back.play()
			selected = false

func _ready():
	get_viewport().connect("gui_focus_changed", self, "_on_focus_changed")
	current_focus = tab1_startbutton

func _on_focus_changed(control):
	if !control == null:
		if selected:
			return
		if control.name == "MeltyBloodButton":
			select_button_text.text = "Play"
		else:
			select_button_text.text = "Select"
		sound_select_box.play()
		current_focus = control
		print(control)

func stop_sounds():
	sound_back.stop()
	sound_select.stop()
	sound_special.stop()

func _timer_out():
	select_button_text.text = "Select"
	anim.play("home_load")
	selected = false
	special_selected = false
	error_popup.open_popup()
	print(selected)
