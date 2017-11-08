; target window
WinActivate("OSBuddy")

; hot key to stop
HotKeySet("{Esc}", "_exit")

; error tracker
$error_count = 0

; delay between actions
$veryshort = 1
$short = 2
$long = 3
$make = 4

; left and right click
$left = "LEFT"
$right = "RIGHT"

; inventory slot 1
$is1_left = 752
$is1_top = 752

; inventory slot 2
$is2_left = 793
$is2_top = 752




; run program until we stop it using esc or encounter an error
while 1
	; start the problem
	_start()
WEnd





; 1 --> click item 1
; 2 --> click item 2
; 3 --> combine them
; 4 --> goto --> 1
Func _start()
	; select the arrow shafts
	_select_first()
	_pause_action($veryshort)

	; select the arrows
	_select_second()
	_pause_action($long)

	; combine them into headless arrows
	_combine()
	_pause_action($make)
EndFunc


; randomly selects the first item to combine with second
Func _select_first()
	_rand_click($left, $is1_left, $is1_left, $is1_top, $is1_top, 0, 20, 0, 20)
EndFunc


; randomly selects the second item to combine with first
Func _select_second()
	_rand_click($left, $is2_left, $is2_left, $is2_top, $is2_top, 0, 20, 0, 20)
EndFunc


; random left click relative to a square area
Func _rand_click($click, $left, $right, $top, $bottom, $l_offset=0, $r_offset=0, $t_offset=0, $b_offset=0)
	; random click speed between 2-4
	$normal_click_speed = Random(2, 4, 1)

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
		Sleep(Random(200, 350, 1))
	ElseIf $length = 2 Then
		Sleep(Random(680, 700, 1))
	ElseIf $length = 3 Then
		Sleep(Random(1050, 1100, 1))
	Else
		Sleep(Random(16800, 17300, 1))
	EndIf
EndFunc


; press key as a shortcut to make all the items in our inv
Func _combine()
	Send("{Space}")
EndFunc


; exit out program
Func _exit()
	Exit(0)
EndFunc
