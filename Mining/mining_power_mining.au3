; target window
WinActivate("OSBuddy")

; hot key to pause
HotKeySet("{Home}", "_pause")
$pause = False
; pause program
Func _pause()
	$pause = Not $pause

	While $pause
	WEnd
EndFunc


; hot key to stop
; hot key to stop
HotKeySet("{Esc}", "_exit")
; exit out program
Func _exit()
	Exit(0)
EndFunc



; left and right click
Global $left = "LEFT"
Global $right = "RIGHT"
; random left click relative to a square area
Func _rand_click($click, $left, $top, $right, $bottom, $l_offset=0, $t_offset=0, $r_offset=0, $b_offset=0)
	; random click speed between 2-4
	$normal_click_speed = Random(2, 2, 1)

	; rand x coord in box
	$rand_x = Random($left+$l_offset, $right+$r_offset, 1)
	; rand y coor in box
	$rand_y = Random($top+$t_offset, $bottom+$b_offset, 1)

	; click
	MouseClick($click, $rand_x, $rand_y, 1, $normal_click_speed)
EndFunc



; delay between actions
Global $short = 1
Global $medium = 2
Global $long = 3
Global $walk = 4
Global $walklong = 5
; determine which pause we want
Func _pause_action($length)
	; delay between actions
	If $length = 1 Then
		Sleep(Random(100, 150, 1))
	ElseIf $length = 2 Then
		Sleep(Random(2000, 2100, 1))
	ElseIf $length = 3 Then
		Sleep(Random(3050, 3070, 1))
	ElseIf $length = 4 Then
		Sleep(Random(400, 550, 1))
	Else
		Sleep(Random(6000, 6500, 1))
	EndIf
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



; inventory, column, row, column bottom, row bottom
Global $inv_c = 755
Global $inv_r = 755
Global $inv_c_r = 775
Global $inv_r_b = 775

; to calculate (col pos) c1, c2, c3, and etc. (c# * 40 + 715)
; to calculate (row pos) r1, r2, r3, and etc. (r# * 40 + 715)
Func _pos($col, $row, $click=False, $mouse=$left)
	$inv_c = ($col * 40) + 715
	$inv_r = ($row * 40) + 715
	$inv_c_r = $inv_c + 15
	$inv_r_b = $inv_r + 15

	If $click Then
		_rand_click($mouse, $inv_c, $inv_r, $inv_c_r, $inv_r_b)
	EndIf
EndFunc



$ore1l = 469
$ore1t = 810
$ore1r = 585
$ore1b = 910

$ore2l = 197
$ore2t = 802
$ore2r = 289
$ore2b = 893

$ore2lc = 400
$ore2tc = 795
$ore2rc = 493
$ore2bc = 882

$ore3l = 396
$ore3t = 301
$ore3r = 497
$ore3b = 404

$ore4l = 895
$ore4t = 522
$ore4r = 937
$ore4b = 578

$ore4lc = 724
$ore4tc = 521
$ore4rc = 829
$ore4bc = 636

$ore = 0x2E1D15
$noore = 0x282626

Send("{SHIFTDOWN}")

While 1
	Send("{SHIFTDOWN}")
	_check($ore1l, $ore1t, $ore1r, $ore1b, $ore)
	_rand_click($left, $ore1l, $ore1t, $ore1r, $ore1b)
	_check($ore1l, $ore1t, $ore1r, $ore1b, $noore)

	_pos(1, 2, True)
	_pause_action(1)
	_pos(2, 2, True)
	_pause_action(1)
	_pos(3, 2, True)
	_pause_action(1)
	_pos(4, 2, True)

	_pause_action(1)
	Send("{SHIFTUP}")
	_pause_action(1)

	_pos(1, 1, True)
	_pause_action(1)
	_pos(2, 1, True)

	_check($ore1l, $ore2t, $ore2r, $ore2b, $ore)
	_rand_click($left, $ore2l, $ore2t, $ore2r, $ore2b)
	_pause_action(2)
	_check($ore1l, $ore2tc, $ore2rc, $ore2bc, $noore)

	_check($ore3l, $ore3t, $ore3r, $ore3b, $ore)
	_rand_click($left, $ore3l, $ore3t, $ore3r, $ore3b)
	_check($ore3l, $ore3t, $ore3r, $ore3b, $noore)

	_pos(1, 1, True)
	_pause_action(1)
	_pos(2, 1, True)


	_check($ore4l, $ore4t, $ore4r, $ore4b, $ore)
	_rand_click($left, $ore4l, $ore4t, $ore4r, $ore4b)
	_pause_action(2)
	_check($ore4lc, $ore4tc, $ore4rc, $ore4bc, $noore)
WEnd