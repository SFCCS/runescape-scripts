; target window
WinActivate("OSBuddy")

; hot key to stop
HotKeySet("{Esc}", "_exit")

; error checking to prevent script freaking out
$check_fail = 0

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
$make_wait = Random(16800, 17300, 1)

; coords for closing bank
$close_bank_left = 573
$close_bank_right = 589
$close_bank_top = 75
$close_bank_bottom = 91

; first slot of bank
$bank_1_left = 170
$bank_1_right = 196
$bank_1_top = 144
$bank_1_bottom = 170

; second slot of bank
$bank_2_left = 218
$bank_2_right = 244
$bank_2_top = 144
$bank_2_bottom = 170

; deposit button
$deposit_left = 524
$deposit_right = 551
$deposit_top = 827
$deposit_bottom = 854

; first inv item
$item_1_left = 795
$item_1_right = 815
$item_1_top = 861
$item_1_bottom = 884

; second inv item
$item_2_left = 794
$item_2_right = 816
$item_2_top = 893
$item_2_bottom = 921





; run program until we stop it using esc
While 1
	_bank()
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
Func _rand_click($click, $left, $right, $top, $bottom, $l_offset=0, $r_offset=0, $t_offset=0, $b_offset=0)
	; rand x coord in box
	$rand_x = Random($left+$l_offset, $right+$r_offset, 1)
	; rand y coor in box
	$rand_y = Random($top+$t_offset, $bottom+$b_offset, 1)

	; click
	MouseClick($click, $rand_x, $rand_y, 1, $normal_click_speed)
EndFunc


; increment the error and checks if the program has failed
Func _increment_error()
	; if we fail 10 times in a row, we stop the program
	$check_fail += 1

	If $check_fail = 10 Then
		_exit()
	EndIf
EndFunc


Func _reset_error()
	; reset the fail checker since it fixed itself
	If $check_fail = 3 Then
		$check_fail = 0
	EndIf
EndFunc


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
Func _bank()
	; Use pixel color search to find the banker
	$banker = PixelSearch(237, 43, 701, 407, 0x605409)
	; check if the color pixels relative to the banker coords are what we want to make sure we click
	; on the correct object
	$banker_cloth1 = PixelSearch($banker[0]-50, $banker[1]-50, $banker[0]+50, $banker[1]+50, 0xE3E0E3)
	$banker_cloth2 = PixelSearch($banker[0]-50, $banker[1]-50, $banker[0]+50, $banker[1]+50, 0x847A7A)

	; if found
	If IsArray($banker) AND IsArray($banker_cloth1) AND IsArray($banker_cloth2) Then
		; click on a random spot around the banker
		_rand_click($left, $banker[0], $banker[0], $banker[1], $banker[1], -10, 10, -10, 40)
		; pause while bank opens
		_pause_action($long)

		; pixel search the color of the first item to make sure we
		; did not run out of the first item
		$string = PixelSearch(173, 150, 192, 166, 0x837758)

		; if item is there
		If Not @error Then
			; if the script fixes itself, we can reset error
			_reset_error()

			; does all the actions we need
			_doAll()
		Else
			_increment_error()
		EndIf
	Else
		_increment_error()
	EndIf
EndFunc


; exits the bank using the exit button coord
Func _exit_bank()
	_rand_click($left, $close_bank_left, $close_bank_right, $close_bank_top, $close_bank_bottom)
EndFunc


; gets the string from our second bank slot
; this combines right click then left click
; right click is used to select the number of items we want
Func _get_string()
	$rand_x = Random($bank_1_left, $bank_1_right, 1)
	$rand_y = Random($bank_1_top, $bank_1_bottom, 1)

	_rand_click($right, $rand_x, $rand_x, $rand_y, $rand_y)
	_pause_action($veryshort)
	_rand_click($left, $rand_x, $rand_x, $rand_y, $rand_y, -70, 70, 70, 76)
EndFunc


; gets the bow from our second bank slot
; this combines right click then left click
; right click is used to select the number of items we want
Func _get_bow()
	$rand_x = Random($bank_2_left, $bank_2_right, 1)
	$rand_y = Random($bank_2_top, $bank_2_bottom, 1)

	_rand_click($right, $rand_x, $rand_x, $rand_y, $rand_y)
	_pause_action($veryshort)
	_rand_click($left, $rand_x, $rand_x, $rand_y, $rand_y, -70, 70, 70, 76)
EndFunc


; deposit all the items in our inventory using the deposit item coord
Func _deposit_all()
	_rand_click($left, $deposit_left, $deposit_right, $deposit_top, $deposit_bottom)
EndFunc


; combine the first and second item in the inventory using their coordinates
Func _combine()
	_rand_click($left, $item_1_left, $item_1_right, $item_1_top, $item_1_bottom)

	_rand_click($left, $item_2_left, $item_2_right, $item_2_top, $item_2_bottom)
EndFunc


; does all the actions we need
Func _doAll()
	; deposit all items first then delay
	_deposit_all()
	_pause_action($short)

	; get the first item then delay
	_get_string()
	_pause_action($short)

	; get the second item then delay
	_get_bow()
	_pause_action($short)

	; exit bank then delay
	_exit_bank()
	_pause_action($long)

	; combine the item then delay
	_combine()
	_pause_action($long)

	; make the item and pause for a longer period while item is being made
	_make()
	_pause_action($make)
	_pause_action($long)
EndFunc


; press space as a shortcut to make all the items in our inv
Func _make()
	Send("{Space}")
EndFunc


; exit out program
Func _exit()
	Exit(0)
EndFunc