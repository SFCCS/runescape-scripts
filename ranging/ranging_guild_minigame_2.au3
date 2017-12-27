; target window
WinActivate("OSBuddy")


; hot key to stop
HotKeySet("{`}", "_exit")
; exit out program
Func _exit()
	Exit(0)
EndFunc


; hot key to pause
HotKeySet("{Home}", "_pause")
$pause = False
; pause program
Func _pause()
	$pause = Not $pause

	While $pause
	WEnd
EndFunc


; check
Func _check($left, $top, $right, $bottom, $color)
	$check = 1
	while $check
		$check_item = PixelSearch($left, $top, $right, $bottom, $color)
		If IsArray($check_item) Then
			$check = 0
		EndIf
	WEnd
EndFunc


; left and right click
Global $left = "LEFT"
Global $right = "RIGHT"
; random left click relative to a square area
Func _rand_click($click, $left, $top, $right, $bottom, $l_offset=0, $t_offset=0, $r_offset=0, $b_offset=0)
	; random click speed between 2-4
	$normal_click_speed = Random(2, 3, 1)

	; rand x coord in box
	$rand_x = Random($left+$l_offset, $right+$r_offset, 1)
	; rand y coor in box
	$rand_y = Random($top+$t_offset, $bottom+$b_offset, 1)

	; click
	MouseClick($click, $rand_x, $rand_y, 1, $normal_click_speed)
EndFunc


; determine which pause we want
Func _pause_action($length)
	; delay between actions
	If $length = 1 Then
		Sleep(Random(100, 150, 1))
	ElseIf $length = 2 Then
		Sleep(Random(300, 350, 1))
	ElseIf $length = 3 Then
		Sleep(Random(900, 1000, 1))
	Else
		Sleep(Random(8800, 9300, 1))
	EndIf
EndFunc


$npc_color = 0x4C462A
$npc_l = 287
$npc_t = 451
$npc_r = 312
$npc_b = 486

$npc_talking = 0x0000FF
$npc_t_x = 254
$npc_t_y = 983

$npc_t_x2 = 244
$npc_t_y2 = 988

$npc_t_x3 = 285
$npc_t_y3 = 988

$options = 0x3F9F9C
$options_x = 117
$options_y = 904

$target = 0xE7DB5B
$t_l = 472
$t_t = 150
$t_r = 514
$t_b = 193

$target2 = 0xFF0000
$t_x = 357
$t_y = 459

$target_off = 0x000035
$to_x = 474
$to_y = 467

While 1
	_check($npc_l, $npc_t, $npc_r, $npc_b, $npc_color)
	_pause_action(1)
	_rand_click($left, $npc_l, $npc_t, $npc_r, $npc_b)

	_check($npc_t_x, $npc_t_y, $npc_t_x, $npc_t_y, $npc_talking)
	_pause_action(1)
	Send("{Space}")

	_check($options_x, $options_y, $options_x, $options_y, $options)
	_pause_action(1)
	Send("{1}")

	_check($npc_t_x2, $npc_t_y2, $npc_t_x2, $npc_t_y2, $npc_talking)
	_pause_action(1)
	Send("{Space}")

	_check($npc_t_x, $npc_t_y, $npc_t_x, $npc_t_y, $npc_talking)
	_pause_action(1)
	Send("{Space}")

	$tt_x = Random($t_l, $t_r, 1)
	$tt_y = Random($t_t, $t_b, 1)

	For $i = 1 to 11 Step 1
		_check($t_l, $t_t, $t_r, $t_b, $target)
		_pause_action(1)
		_rand_click($left, $tt_x, $tt_y, $tt_x, $tt_y)


		_check($to_x, $to_y, $to_x, $to_y, $target_off)


		If $i < 11 Then
			_check($t_x, $t_y, $t_x, $t_y, $target2)
			_pause_action(1)
			;Send("{Esc}")
			;_pause_action(3)
		EndIf
	Next

	_check($npc_t_x3, $npc_t_y3, $npc_t_x3, $npc_t_y3, $npc_talking)
	_pause_action(1)
	Send("{Space}")
	_pause_action(1)
WEnd