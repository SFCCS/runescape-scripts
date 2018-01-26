; target window
WinActivate("OSBuddy")


; hot key to stop
HotKeySet("{`}", "_exit")
; exit out program
Func _exit()
	Exit(0)
EndFunc


Global $slow = False
; hot key to slowdown
HotKeySet("{=}", "_slowdown")
; slowdown program
Func _slowdown()
	$slow = Not $slow
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
		Sleep(Random(150000, 150200, 1))
	ElseIf $length = 2 Then
		Sleep(Random(250, 350, 1))
	ElseIf $length = 3 Then
		Sleep(Random(5500, 5600, 1))
	Else
		Sleep(Random(8800, 9300, 1))
	EndIf
EndFunc



$noted_bar = 0x4E4948
$3_l = 837
$3_t = 756
$3_r = 860
$3_b = 777

$unnoted_bar = 0x776F6E
$4_l = 882
$4_t = 757
$4_r = 901
$4_b = 770

$banker = 0xA98260
$b_l = 465
$b_t = 716
$b_r = 518
$b_b = 761

$unnote = 0x000000
$un_l = 273
$un_t = 936

$furn_l = 910
$furn_t = 119

$smelt = 0x66452E
$s_l = 601
$s_t = 473
$s_r = 636
$s_b = 548

$smelt_act = 0x3C3737
$sa_l = 274
$sa_t = 960

$goto_b_l = 823
$goto_b_t = 160

While 1
	_check($3_l, $3_t, $3_r, $3_b, $noted_bar)
	_rand_click($left, $3_l, $3_t, $3_r, $3_b)

	_check($b_l, $b_t, $b_r, $b_b, $banker)
	_rand_click($left, $b_l, $b_t, $b_r, $b_b)

	_check($un_l, $un_t, $un_l, $un_t, $unnote)
	Send("{1}")

	_check($4_l, $4_t, $4_r, $4_b, $unnoted_bar)
	_rand_click($left, $furn_l, $furn_t, $furn_l, $furn_t)

	_check($s_l, $s_t, $s_r, $s_b, $smelt)
	_pause_action(2)
	_rand_click($left, $4_l, $4_t, $4_r, $4_b)
	_rand_click($left, $s_l, $s_t, $s_r, $s_b)

	_check($sa_l, $sa_t, $sa_l, $sa_t, $smelt_act)
	Send("{Space}")

	_pause_action(1)
	_rand_click($left, $goto_b_l, $goto_b_t, $goto_b_l, $goto_b_t)
	_pause_action(3)
WEnd