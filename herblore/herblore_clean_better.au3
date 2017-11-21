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

; close bank
$close_left = 573
$close_top = 75

; deposit items
$deposit_left = 525
$deposit_top = 828

; bank slot 1
$bs1_left = 170
$bs1_top = 144



$c1 = 755
$c2 = 795
$c3 = 835
$c4 = 875


$r1 = 755
$r2 = 790
$r3 = 825
$r4 = 860
$r5 = 895
$r6 = 930
$r7 = 965









; run program until we stop it using esc or encounter an error
while 1
	; start the problem
	_start()
WEnd





; bank first
; 1 --> click banker
; 2 --> deposit items
; 3 --> get 14 items from slot 1
; 4 --> get 14 items from slot 2
; 5 --> close bank
; 6 --> click item 1
; 7 --> click item 2
; 8 --> combine them
; 9 --> goto --> 1
Func _start()

	; find banker
	$banker = PixelSearch(253, 64, 739, 268, 0x7D768D)
	; if found then bank and do other actions
	If IsArray($banker) Then
		; since no error we can set error to none
		; this is also in the case program fixed itself
		_reset_error()

		; click on the banker then wait for bank to open
		_rand_click($left, $banker[0], $banker[0], $banker[1], $banker[1], -15, 20, -15, 20)


		; check if bank is open
		_check_bank_open()

		; deposit all items into the bank
		_deposit_all()
		_pause_action($veryshort)


		; grab the string
		_get_herbs()
		_pause_action($veryshort)

		; exit the bank to clean herbs
		_exit_bank()

		; make sure the bank is closed
		_check_bank_closed()

		; make sure inventory item is rendered
		_check_inv_1()
		_pause_action($veryshort)

		; 1
		_rand_click($left, $c1, $c1, $r1, $r1, 0, 20, 0, 20)

		; 2
		_rand_click($left, $c2, $c2, $r1, $r1, 0, 20, 0, 20)

		; 3
		_rand_click($left, $c3, $c3, $r1, $r1, 0, 20, 0, 20)

		; 4
		_rand_click($left, $c4, $c4, $r1, $r1, 0, 20, 0, 20)



		; 8
		_rand_click($left, $c4, $c4, $r2, $r2, 0, 20, 0, 20)

		; 7
		_rand_click($left, $c3, $c3, $r2, $r2, 0, 20, 0, 20)

		; 6
		_rand_click($left, $c2, $c2, $r2, $r2, 0, 20, 0, 20)

		; 5
		_rand_click($left, $c1, $c1, $r2, $r2, 0, 20, 0, 20)





		; 9
		_rand_click($left, $c1, $c1, $r3, $r3, 0, 20, 0, 20)

		; 10
		_rand_click($left, $c2, $c2, $r3, $r3, 0, 20, 0, 20)

		; 11
		_rand_click($left, $c3, $c3, $r3, $r3, 0, 20, 0, 20)

		; 12
		_rand_click($left, $c4, $c4, $r3, $r3, 0, 20, 0, 20)





		; 16
		_rand_click($left, $c4, $c4, $r4, $r4, 0, 20, 0, 20)

		; 15
		_rand_click($left, $c3, $c3, $r4, $r4, 0, 20, 0, 20)

		; 14
		_rand_click($left, $c2, $c2, $r4, $r4, 0, 20, 0, 20)

		; 13
		_rand_click($left, $c1, $c1, $r4, $r4, 0, 20, 0, 20)






		; 17
		_rand_click($left, $c1, $c1, $r5, $r5, 0, 20, 0, 20)

		; 18
		_rand_click($left, $c2, $c2, $r5, $r5, 0, 20, 0, 20)

		; 19
		_rand_click($left, $c3, $c3, $r5, $r5, 0, 20, 0, 20)

		; 20
		_rand_click($left, $c4, $c4, $r5, $r5, 0, 20, 0, 20)




		; 24
		_rand_click($left, $c4, $c4, $r6, $r6, 0, 20, 0, 20)

		; 23
		_rand_click($left, $c3, $c3, $r6, $r6, 0, 20, 0, 20)

		; 22
		_rand_click($left, $c2, $c2, $r6, $r6, 0, 20, 0, 20)

		; 21
		_rand_click($left, $c1, $c1, $r6, $r6, 0, 20, 0, 20)



		; 25
		_rand_click($left, $c1, $c1, $r7, $r7, 0, 20, 0, 20)

		; 26
		_rand_click($left, $c2, $c2, $r7, $r7, 0, 20, 0, 20)

		; 27
		_rand_click($left, $c3, $c3, $r7, $r7, 0, 20, 0, 20)

		; 28
		_rand_click($left, $c4, $c4, $r7, $r7, 0, 20, 0, 20)


		_pause_action($short)
	Else
		; if error occurs 10 times then we exit
		_increment_error()
	EndIf
EndFunc


; check bank closed
Func _check_bank_closed()
	$check = 1
	while $check
		$check_item = PixelSearch(288, 195, 405, 341, 0x574815)
		If IsArray($check_item) Then
			$check = 0
		EndIf
	WEnd
EndFunc


; check inv item 1 rendered
Func _check_inv_1()
	$check = 1
	while $check
		$check_item = PixelSearch(758, 761, 774, 772, 0x514209)
		If IsArray($check_item) Then
			$check = 0
		EndIf
	WEnd
EndFunc

; grabs X amount of herbs from the bank
Func _get_herbs()
	$rand_x = Random($bs1_left, $bs1_left+20, 1)
	$rand_y = Random($bs1_top, $bs1_top+20, 1)

	; right click to have grab many option
	_rand_click($right, $rand_x, $rand_x, $rand_y, $rand_y)
	_pause_action($veryshort)
	; left click to select X amount wanted
	_rand_click($left, $rand_x, $rand_x, $rand_y, $rand_y, -70, 70, 70, 76)
EndFunc


; checks if bank is open
Func _check_bank_open()
	$check = 1
	while $check
		$check_item = PixelSearch(171, 148, 196, 168, 0x514209)
		If IsArray($check_item) Then
			$check = 0
		EndIf
	WEnd
EndFunc


; deposits all items to bank
Func _deposit_all()
	_rand_click($left, $deposit_left, $deposit_left, $deposit_top, $deposit_top, 0, 20, 0, 20)
EndFunc


; exits the bank
Func _exit_bank()
	_rand_click($left, $close_left, $close_left, $close_top, $close_top, 0, 13, 0, 15)
EndFunc


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


; press key as a shortcut to make all the items in our inv
Func _combine()
	Send("{Space}")
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