; target window
WinActivate("OSBuddy")


; hot key to stop
HotKeySet("{Esc}", "_exit")
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
		Sleep(Random(400, 450, 1))
	ElseIf $length = 2 Then
		Sleep(Random(680, 700, 1))
	ElseIf $length = 3 Then
		Sleep(Random(1550, 1600, 1))
	Else
		Sleep(Random(8800, 9300, 1))
	EndIf
EndFunc



$alch = 0x30C130
$a_l = 895
$a_t = 858
$a_r = 908
$a_b = 870

$stun = 0xFEFEFD
$s_l = 798
$s_t = 955
$s_r = 809
$s_b = 965

$target = 0x672824
$t_l = 506
$t_t = 818
$t_r = 674
$t_b = 951

$item = 0x604809
$i_l = 881
$i_t = 861
$i_r = 899
$i_b = 882

$mm_l = 925
$mm_t = 849
$mm_r = 937
$mm_b = 887

While 1
	_check($a_l, $a_t, $a_r, $a_b, $alch)
	_pause_action(1)
	_rand_click($left, $a_l, $a_t, $a_r, $a_b)

	_check($i_l, $i_t, $i_r, $i_b, $item)
	_pause_action(1)
	_rand_click($left, $i_l, $i_t, $i_r, $i_b)


	$mm_x = Random($mm_l, $mm_r, 1)
	$mm_y = Random($mm_t, $mm_b, 1)

	MouseMove ($mm_x, $mm_y, 10)

	_check($s_l, $s_t, $s_r, $s_b, $stun)
	_pause_action(1)
	_rand_click($left, $s_l, $s_t, $s_r, $s_b)

	_check($t_l, $t_t, $t_r, $t_b, $target)
	_pause_action(1)
	_rand_click($left, $t_l, $t_t, $t_r, $t_b)
WEnd