; target window
WinActivate("OSBuddy")

; hot key to stop
HotKeySet("{Esc}", "stop")

; click speed between 1-3
$normal_click_speed = Random(1, 3, 1)

; left and right click
$left = "LEFT"
$right = "RIGHT"

; delay between actions
$veryshort = 0
$veryshort_wait = Random(200, 350, 1)
$short = 1
$short_wait = Random(500, 700, 1)
$long = 2
$long_wait = Random(800, 1000, 1)
$make = 3
$make_wait = Random(11950, 12400, 1)

; arrow shaft coordinates
$as_x = Random(752, 776, 1)
$as_y = Random(752, 776, 1)

; feather coordinates
$f_x = Random(752, 776, 1)
$f_y = Random(796, 817, 1)





; run the script until stopped
While 1
	_rand_click($left, $as_x, $as_y)
	_rand_click($left, $f_x, $f_y)
	_pause_action(1)
	_make()
WEnd







; determine which pause we want
Func _pause_action(ByRef $length)
	If $length = 0 Then
		Sleep($veryshort_wait)
	ElseIf $length = 1 Then
		Sleep($short_wait)
	ElseIf $length = 2 Then
		Sleep($long_wait)
	Else
		Sleep($make_wait)
	EndIf
EndFunc


; random left click relative to a square area
Func _rand_click($click, $x, $y)
	; click
	MouseClick($click, $x, $y, 1, $normal_click_speed)
EndFunc


; combine the two items together
Func _make()
	Send("{Space}")
	_pause_action(3)
EndFunc


; exit function
Func stop()
	Exit(0)
EndFunc