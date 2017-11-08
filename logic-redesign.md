## pauses
1. very short (200, 300)
2. short (300, 400)
3. medium (400, 500)
4. long (500, 600)
5. very long (950, 1100)

## coordinates
1. bank
2. close bank
3. deposit
4. bank slot 1
5. bank slot 2
6. inventory slot 1
7. inventory slot 2

## colors
1. bank color
2. slot 1 color
3. slot 2 color
4. inventory 1 color
5. inventory 2 color


## Steps
1. open bank
	1. find bank
	2. check if coord for bank is clickable
	3. open bank if found clickable
	4. check if bank open
	5. if not open goto step 1
2. deposit items
	1. check if deposit is available
	2. deposit
3. get bank slot 1
	1. check if bank slot 1 available
	2. right click bank slot 1
	3. left click desired amount
3. get bank slot 2
	1. check if bank slot 2 available
	2. right click bank slot 1
	3. left click desired amount
4. close bank
	1. check if close button is clickable
	2. close bank
	3. check if bank closed
	4. if not goto 1
5. select inventory item 1
	1. check if inventory item 1 available
	2. click on inventory item 1
6. select inventory item 2
	1. check if inventory item 2 available
	2. click on inventory item 2
7. item action combine or make
	1. check if action is clickable
	2. if clickable press space
	3. else wait until clickable
8. wait till action complete
	1. wait till action complete
	2. goto step (1) of steps



