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

; determine which pause we want
Func _pause_action($length)
	; delay between actions
	If $length = 1 Then
		Sleep(Random(200, 250, 1))
	ElseIf $length = 2 Then
		Sleep(Random(680, 700, 1))
	ElseIf $length = 3 Then
		Sleep(Random(1050, 1100, 1))
	Else
		Sleep(Random(16800, 17300, 1))
	EndIf
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



$item_l = 178
$item_t = 366
$item_r = 203
$item_b = 391

; grabs X amount of strings from the bank
Func _buy()
	$rand_x = Random($item_l, $item_r, 1)
	$rand_y = Random($item_t, $item_b, 1)

	; right click to have grab many option
	_rand_click($right, $rand_x, $rand_y, $rand_x, $rand_y)
	;_pause_action($veryshort)
	; left click to select X amount wanted
	_rand_click($left, $rand_x, $rand_y, $rand_x, $rand_y, -15, 40, 15, 45)
EndFunc

While 1
	_check(760, 763, 760, 763, 0xA97B60)
	_buy()
	_pause_action(1)
WEnd