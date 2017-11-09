; willow logs 3 hours
; maple logs 4 hours ~101k, 400kexp
; maple longbow (u), 2 hours, 250k, ~ 125k/hr


; target window
WinActivate("OSBuddy")

; hot key to stop
HotKeySet("{Esc}", "_exit")

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

; bank slot 2
$bs2_left = 218
$bs2_top = 144

; inventory slot 1
$is1_left = 795
$is1_top = 861

; inventory slot 2
$is2_left = 793
$is2_top = 893




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
		_rand_click($left, $banker[0], $banker[0], $banker[1], $banker[1], -30, 30, -35, 40)

		; check if bank is open
		_check_bank_open()

		; deposit all items into the bank
		_deposit_all()
		_pause_action($veryshort)

		; grab the string
		_get_strings()
		_pause_action($veryshort)

		; grab the unstrung bows
		_get_bows()
		_pause_action($veryshort)

		; exit the bank to string bows
		_exit_bank()

		; make sure bank is closed
		_check_bank_closed()

		; make sure our first inventory item is rendered
		_check_inv_1()
		_pause_action($veryshort)

		; select the first inventory item
		_select_first()
		_pause_action($veryshort)

		; make sure the second inventory item is rendered
		_check_inv_2()

		; select unstrung bow to string
		_select_second()
		_pause_action($veryshort)

		; check for combine action
		_check_combine()
		_pause_action($veryshort)

		; string the bows
		_combine()
		_pause_action($make)
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


; check inv item 1 rendered
Func _check_inv_1()
	$check = 1
	while $check
		$check_item = PixelSearch(796, 867, 815, 885, 0x837758)
		If IsArray($check_item) Then
			$check = 0
		EndIf
	WEnd
EndFunc


; check inv item 2 rendered
Func _check_inv_2()
	$check = 1
	while $check
		$check_item = PixelSearch(838, 893, 858, 914, 0xC8AF18)
		If IsArray($check_item) Then
			$check = 0
		EndIf
	WEnd
EndFunc


; checks if bank is open
Func _check_bank_open()
	$check = 1
	while $check
		$check_item = PixelSearch(171, 148, 196, 168, 0x70664C)
		If IsArray($check_item) Then
			$check = 0
		EndIf
	WEnd
EndFunc


; check for combine action
Func _check_combine()
	$check = 1
	while $check
		$check_item = PixelSearch(245, 936, 291, 977, 0xA59015)
		If IsArray($check_item) Then
			$check = 0
		EndIf
	WEnd
EndFunc


; randomly selects the first item to combine with second
Func _select_first()
	_rand_click($left, $is1_left, $is1_left, $is1_top, $is1_top, 0, 20, 0, 20)
EndFunc


; randomly selects the second item to combine with first
Func _select_second()
	_rand_click($left, $is2_left, $is2_left, $is2_top, $is2_top, 0, 20, 0, 20)
EndFunc


; grabs X amount of strings from the bank
Func _get_strings()
	$rand_x = Random($bs1_left, $bs1_left+20, 1)
	$rand_y = Random($bs1_top, $bs1_top+20, 1)

	; right click to have grab many option
	_rand_click($right, $rand_x, $rand_x, $rand_y, $rand_y)
	_pause_action($veryshort)
	; left click to select X amount wanted
	_rand_click($left, $rand_x, $rand_x, $rand_y, $rand_y, -70, 70, 70, 76)
EndFunc


; grabs X amount of bows from the bank
Func _get_bows()
	$rand_x = Random($bs2_left, $bs2_left+20, 1)
	$rand_y = Random($bs2_top, $bs2_top+20, 1)

	; right click to have grab many option
	_rand_click($right, $rand_x, $rand_x, $rand_y, $rand_y)
	_pause_action($veryshort)
	; left click to select X amount wanted
	_rand_click($left, $rand_x, $rand_x, $rand_y, $rand_y, -70, 70, 70, 76)
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
		Sleep(Random(150, 250, 1))
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