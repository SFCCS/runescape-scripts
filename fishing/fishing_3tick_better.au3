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
	$normal_click_speed = Random(2, 3, 1)

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
		Sleep(Random(40, 50, 1))
	ElseIf $length = 2 Then
		Sleep(Random(160, 170, 1))
	ElseIf $length = 3 Then
		Sleep(Random(850, 870, 1))
	ElseIf $length = 4 Then
		Sleep(Random(2000, 2500, 1))
	Else
		Sleep(Random(6000, 6500, 1))
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
Func _pos($col, $row, $check=False, $color=0, $click=False, $mouse=$left, $herb=False)
	$inv_c = ($col * 40) + 715
	$inv_r = ($row * 40) + 715
	$inv_c_r = $inv_c + 15
	$inv_r_b = $inv_r + 15

	If $herb Then
		$check_herb = PixelSearch($inv_c, $inv_r, $inv_c_r, $inv_r_b, $color)
		If Not IsArray($check_herb) Then
			$check_inv = PixelSearch(755, 755, 917, 962, $color)
			If IsArray($check_inv) Then
				_rand_click($mouse, $check_inv[0], $check_inv[1], $check_inv[0], $check_inv[1])
				Sleep(1500)
				MouseClickDrag($left, $check_inv[0], $check_inv[1], $inv_c, $inv_r)
			EndIf
		EndIf
	EndIf

	If $check Then
		_check($inv_c, $inv_r, $inv_c_r, $inv_r_b, $color)
	EndIf

	If $click Then
		_rand_click($mouse, $inv_c, $inv_r, $inv_c_r, $inv_r_b)
	EndIf
EndFunc



;fishing spot left, top, right, bottom, color
Global $fish_l = 161
Global $fish_t = 229
Global $fish_r = 711
Global $fish_b = 930
Global $fish_c = 0x00FFFF

; map spot left, top, right, bottom, color
Global $map_l = 809
Global $map_t = 90
Global $map_r = 927
Global $map_b = 190
Global $map_c = 0x00FFFF

; inventory item colors
Global $herb = 0x095109
Global $herbuncleaned = 0x6D580D
Global $tar = 0x322E2E

Global $try = True
Func _map()
	$new_spot = PixelSearch($map_l, $map_t, $map_r, $map_b, $map_c)
	If IsArray($new_spot) Then
		$try = True
		_rand_click($left, $new_spot[0], $new_spot[1], $new_spot[0], $new_spot[1])
	Else
		If $try Then
			$try = False
			_rand_click($left, 905, 200, 905, 200)
			_pause_action($walklong)
			_map()
		EndIf
	EndIf
EndFunc


While 1
	; click fishing spot
	$fish = PixelSearch($fish_l, $fish_t, $fish_r, $fish_b, $fish_c)
	If IsArray($fish) Then
	Else
		_pause_action($long)
		_map()
		_check($fish_l, $fish_t, $fish_r, $fish_b, $fish_c)
		_pause_action($walk)
	EndIf

	; if herb missing, use a new herb
	_pos(1, 2, False, $herb, False, $left, True)

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
		_rand_click($left, $fish[0], $fish[1], $fish[0], $fish[1], -10, -10, 40, 40)
	Else
		_pos(-3, 3, False, 0, True)
		_pause_action($long)
		_map()
		_check($fish_l, $fish_t, $fish_r, $fish_b, $fish_c)
		_pause_action($walk)
	EndIf

	_pause_action(3)
WEnd