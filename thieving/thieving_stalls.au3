; target window
WinActivate("OSBuddy")

; hot key to stop
HotKeySet("{Esc}", "_exit")

; hot key to pause
HotKeySet("{`}", "_pause")
$pause = False

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

$stand_color = 0x822820

$stand_left = 615
$stand_top = 794
$stand_right = 698
$stand_bottom = 860

$nostand_left = 765
$nostand_top = 765

$nostand_color = 0x3E3529

$c1 = 755
$c2 = 775
Send("{SHIFTDOWN}")

; run program until we stop it using esc or encounter an error
while 1
	; start the problem
	_check($stand_left, $stand_top, $stand_right, $stand_bottom, $stand_color)
	$stand = PixelSearch($stand_left, $stand_top, $stand_right, $stand_bottom, $stand_color)
	If IsArray($stand) Then
		_pause_action(1)
		_rand_click($left, $stand[0], $stand[0], $stand[1], $stand[1], -70, -50, -100, 0)

		_pause_action(3)

		; 1
		_rand_click($left, $c1, $c1, $c1, $c1, 0, 15, 0, 15)
	Else
		; if error occurs 10 times then we exit
		_increment_error()
	EndIf
WEnd


; increment error everytime something bad happens
; if error occurs 10 times we exit program
Func _increment_error()
	$error_count += 1

	If $error_count = 10 Then
		_exit()
	EndIf
EndFunc


; reset error
Func _reset_error()
	$error_count = 0
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
		Sleep(Random(50, 200, 1))
	ElseIf $length = 2 Then
		Sleep(Random(680, 700, 1))
	ElseIf $length = 3 Then
		Sleep(Random(1200, 1500, 1))
	Else
		Sleep(0)
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