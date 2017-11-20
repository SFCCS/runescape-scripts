; target window
WinActivate("OSBuddy")



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
	$normal_click_speed = Random(2, 4, 1)

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
; determine which pause we want
Func _pause_action($length)
	; delay between actions
	If $length = 1 Then
		Sleep(Random(80, 90, 1))
	ElseIf $length = 2 Then
		Sleep(Random(210, 230, 1))
	ElseIf $length = 3 Then
		Sleep(Random(950, 1000, 1))
	Else
		Sleep(Random(5300, 5500, 1))
	EndIf
EndFunc

; check, maybe click
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
Func _pos($col, $row, $check=False, $color=0, $click=False, $mouse=$left)
	$inv_c = ($col * 40) + 715
	$inv_r = ($row * 40) + 715
	$inv_c_r = $inv_c + 15
	$inv_r_b = $inv_r + 15

	If $check Then
		_check($inv_c, $inv_r, $inv_c_r, $inv_r_b, $color)
	EndIf

	If $click Then
		_rand_click($mouse, $inv_c, $inv_r, $inv_c_r, $inv_r_b)
	EndIf
EndFunc



;fishing spot left, top, right, bottom, color
Global $fish_l = 545
Global $fish_t = 770
Global $fish_r = 705
Global $fish_b = 1025
Global $fish_c = 0x00FFFF

; map spot left, top, right, bottom, color
Global $map_l = 809
Global $map_t = 90
Global $map_r = 927
Global $map_b = 164
Global $map_c = 0x00FFFF

; inventory item colors
Global $herb = 0x095109
Global $tar = 0x322E2E

While 1
	; check fishing spot
	_check($fish_l, $fish_t, $fish_r, $fish_b, $fish_c)

	; check tar
	; then click
	_pos(1, 1, True, $tar, True)

	_pause_action($short)

	; check herb
	; then click
	_pos(1, 2, True, $herb, True)

	_pause_action($short)

	; shift drop inv row 3 column 1
	Send("{SHIFTDOWN}")
	_pos(1, 3, False, 0, True)
	_pause_action(2)
	Send("{SHIFTUP}")

	; click fishing spot
	$fish = PixelSearch($fish_l, $fish_t, $fish_r, $fish_b, $fish_c)
	If IsArray($fish) Then
		_rand_click($left, $fish[0], $fish[1], $fish[0], $fish[1], 20, -20, 50, 30)
	EndIf

	_pause_action(3)
WEnd
