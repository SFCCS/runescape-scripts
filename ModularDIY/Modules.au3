; target window
WinActivate("OSBuddy")






; hot key to stop
HotKeySet("{Esc}", "_exit")
; exit out program
Func _exit()
	Exit(0)
EndFunc





; hot key to pause
HotKeySet("{`}", "_pause")
$pause = False
; pause program
Func _pause()
	$pause = Not $pause

	While $pause
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