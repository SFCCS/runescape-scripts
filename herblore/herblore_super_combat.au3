; target window
WinActivate("OSBuddy")

; hot key to stop
HotKeySet("{Esc}", "_exit")

; hot key to pause
HotKeySet("{Home}", "_pause")
$pause = False

; error tracker
$error_count = 0

; delay between actions
$veryshort = 1
$short = 2
$long = 3
$make = 4

; close bank
$close_left = 573
$close_top = 75

; deposit items
$deposit_left = 525
$deposit_top = 828

; bank slot 1
$bs1_left = 170
$bs1_top = 144

; bank slot 2
$bs2_left = 218
$bs2_top = 144

; bank slot 3
$bs3_left = 266
$bs3_top = 144

; bank slot 4
$bs4_left = 314
$bs4_top = 144

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
		_rand_click($left, $banker[0], $banker[1], $banker[0], $banker[1], -20, 20, -20, 20)

		; check if bank is open
		_check_bank_open()

		; deposit all items into the bank
		_deposit_all()
		_pause_action($veryshort)


		; get first item
		_get_from_bank($bs1_left, $bs1_top)
		_pause_action(1)

		; get second item
		_get_from_bank($bs2_left, $bs2_top)
		_pause_action(1)

		; get third item
		_get_from_bank($bs3_left, $bs3_top)
		_pause_action(1)

		; get fourth item
		_get_from_bank($bs4_left, $bs4_top)
		_pause_action(1)


		_exit_bank()

		_check_bank_closed()

		_pos(3, 2, False, 0, True, $left)
		_pause_action(1)
		_pos(4, 2, False, 0, True, $left)
		_check_combine()
		_combine()
		_pause_action(4)


	Else
		; if error occurs 10 times then we exit
		_increment_error()
	EndIf

EndFunc




; check bank closed
Func _check_bank_closed()
	$check = 1
	while $check
		$check_item = PixelSearch(362, 230, 457, 309, 0x574815)
		If IsArray($check_item) Then
			$check = 0
		EndIf
	WEnd
EndFunc

; checks if bank is open
Func _check_bank_open()
	$check = 1
	while $check
		$check_item = PixelSearch($bs1_left, $bs1_top, $bs1_left+20, $bs1_top+20, 0x09560D)
		If IsArray($check_item) Then
			$check = 0
		EndIf
	WEnd
EndFunc


; check for combine action
Func _check_combine()
	$check = 1
	while $check
		$check_item = PixelSearch(245, 936, 291, 977, 0x2F751A)
		If IsArray($check_item) Then
			$check = 0
		EndIf
	WEnd
EndFunc


; grabs X amount of strings from the bank
Func _get_from_bank($x, $y)
	$rand_x = Random($x, $x+20, 1)
	$rand_y = Random($y, $y+20, 1)

	; right click to have grab many option
	_rand_click($right, $rand_x, $rand_y, $rand_x, $rand_y)
	;_pause_action($veryshort)
	; left click to select X amount wanted
	_rand_click($left, $rand_x, $rand_y, $rand_x, $rand_y, -70, 70, 70, 76)
EndFunc



; deposits all items to bank
Func _deposit_all()
	_rand_click($left, $deposit_left, $deposit_top, $deposit_left, $deposit_top, 0, 0, 20, 20)
EndFunc


; exits the bank
Func _exit_bank()
	_rand_click($left, $close_left, $close_top, $close_left, $close_top, 0, 0, 13, 15)
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






; determine which pause we want
Func _pause_action($length)
	; delay between actions
	If $length = 1 Then
		Sleep(Random(200, 250, 1))
	ElseIf $length = 2 Then
		Sleep(Random(680, 700, 1))
	ElseIf $length = 3 Then
		Sleep(Random(1550, 1600, 1))
	Else
		Sleep(Random(8800, 9300, 1))
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