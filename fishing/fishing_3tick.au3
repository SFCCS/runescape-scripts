; target window
WinActivate("OSBuddy")

; hot key to stop
HotKeySet("{Esc}", "_exit")

; hot key to pause
HotKeySet("{`}", "_pause")
$pause = False

; delay between actions
$veryshort = 1
$short = 2
$long = 3
$make = 4


; left and right click
$left = "LEFT"
$right = "RIGHT"

$m1 = 809
$m2 = 90
$m3 = 927
$m4 = 164

$mc = 0x00FFFF

$c1 = 755
$r1 = 755
$r2 = 795
$r3 = 835

$f1 = 538
$f2 = 807

$check = 0x00FFFF
$ch1 = 630
$ch2 = 825
$ch3 = 708
$ch4 = 946

Func _map_move()
	$check_map = PixelSearch($m1, $m2, $m3, $m4, $mc)
	If IsArray($check_map) Then
		$check_f = 0
		_rand_click($left, $check_map[0], $check_map[0], $check_map[1], $check_map[1])
		_pause_action($make)
	EndIf
EndFunc

While 1
	_check($ch1, $ch2, $ch3, $ch4, $check)
	_rand_click($left, $c1, $c1, $r1, $r1, 0, 15, 0, 15)
	_pause_action(1)
	_rand_click($left, $c1, $c1, $r2, $r2, 0, 15, 0, 15)
	_pause_action(1)
	Send("{SHIFTDOWN}")
	_rand_click($left, $c1, $c1, $r3, $r3, 0, 15, 0, 15)
	Send("{SHIFTUP}")
	_pause_action(3)
	_rand_click($left, $f1, $f1, $f2, $f2, 60, 100, 60, 100)
	_pause_action(2)
WEnd


Func _move()
	$check_map = PixelSearch($m1, $m2, $m3, $m4, $mc)
	If IsArray($check_map) Then
		$check_f = 0
		_rand_click($left, $check_map[0], $check_map[0], $check_map[1], $check_map[1])
		_pause_action($make)
	Else
		_map_move()
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



; determine which pause we want
Func _pause_action($length)
	; delay between actions
	If $length = 1 Then
		Sleep(Random(60, 70, 1))
	ElseIf $length = 2 Then
		Sleep(Random(950, 1000, 1))
	ElseIf $length = 3 Then
		Sleep(Random(210, 230, 1))
	Else
		Sleep(Random(10000, 11000, 1))
	EndIf
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


; exit out program
Func _exit()
	Exit(0)
EndFunc

; pause program
Func _pause()
	$pause = Not $pause

	While $pause
	WEnd
EndFunc