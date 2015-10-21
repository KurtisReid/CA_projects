.data

arr:.word 0 : 9
size: .word 9
calcarr: .float 0:7
calcarrsize: .float 7
space: .asciiz "\n"

pi:.float 6.28
two: .float 2
realpi: .float 3.14


.text
	la $s1, arr #load address of arr222222222
	la $s5, size #load adreess of size var
	lw $s5, 0($s5) #load array size
	
	
	la $a1, calcarr #load address of calcarr
	
	
	
	li $s0, 90 #height of r1
	jal CHECKNEG
	sd $s0, 0($s1) # arr[0] = 90
	li $s0, 80 #width of r1
	jal CHECKNEG
	sd $s0, 4($s1) # arr[1] = 80
	li $s0, 70 #length of r1
	jal CHECKNEG
	sd $s0, 8($s1) # arr[2] = 70
	li $s0, 60 #height of r2
	jal CHECKNEG
	sd $s0, 12($s1) # arr[3] = 60
	li $s0, 50 #width of r2
	jal CHECKNEG
	sd $s0, 16($s1) # arr[4] = 50
	li $s0, 40 #length of r2
	jal CHECKNEG
	sd $s0, 20($s1) # arr[5] = 40
	li $s0, 30 # height of c
	jal CHECKNEG
	sd $s0, 24($s1) # arr[6] = 30
	li $s0, 20 # diameter of c
	jal CHECKNEG
	sd $s0, 28($s1) # arr[7] = 20

	addi $s2, $s5, -1 #determining end condition
	
	li $t1, 0 # int i = 0
	
	loop:
		ble $s2, 4, cyclinder #if ($s2 <= 4) got to cyclinder
		lw $s0, 0($s1)# $t0 = arr[0] = height = 90
		lw $s4, 4($s1)# $t4 = arr[1] = width = 80
		lw $s6, 8($s1)# $t2 = arr[2] = length = 70
		jal PERIMETER
		jal CONVERT_TO_FLOAT
		s.s $f26, ($a1) # stroing r1_perimeter into array at calcarr[0]
		jal PRINT_CHECK
		addi $a1, $a1, 4#incriment address of calcarr by 8



		jal PRISMVOLUME
		jal CONVERT_TO_FLOAT
		s.s $f26, ($a1) # stroing r1_volume (504000) into array at calcarr[1]
		jal PRINT_CHECK
		addi $a1, $a1, 4#incriment address of calcarr by 8

		addi $s1, $s1, 12 #incriment address of array by 12
		addi $s2, $s2, -2 #i = i -2
		bgtz $s2, loop #if (i > 0) repeat loop
	
	

	cyclinder:
		jal CIRCUMFRENCE
		#s.s $f28, 16($a1) # stroing ircumfrence (504000) into array 
		addi $a1, $a1, 4
		la $a0, space #load address of space string
    		li $v0, 4 #signal system to get ready to print space
    		syscall #call system to print
		
		jal CYLINDERVOLUME
		#jal PRINT_CHECK
		jal EXIT
	

	
PERIMETER:
	# works march 11 2015 11:58
	mul $s7, $s6, 2#$t3 = 2 * length = 2 * 70
	mul $t4, $s4, 2#$t4 = 2 * width = 2 * 80
	add $s7, $s7, $t4#$t3 = 300
	jr $ra

PRISMVOLUME:
	# works
	mul $t4, $s0, $s4
	mul $s7, $t4, $s6
	jr $ra

CIRCUMFRENCE:
	
	#lwc1 $f4, 0($s1)# $t0 = ar[7]
	lw $t5, 4($s1)
	#lwc1 $f10, two
	lwc1 $f7, pi($0) #load 2pi
	div $s6,$t5, 2 #radius
	#mul.s $f1, $f6, 2 #pi * 2
	mflo $t8
	sw   $t8, -88($fp) #storing word and pointer
	lwc1 $f4, -88($fp) #loading  pointer as float
	cvt.s.w $f6, $f4
	#mfc1 $t8, $f6#makes pi  a tmep
	mul.s $f28, $f7, $f6
	
	s.s $f28, 16($a1) # stroing ircumfrence into array
	
	li $v0, 2 #signal system to get ready to print floats
	l.s $f12, 16($a1) #load calcar[i] into $f12
    	syscall	#call system to print
    		
    	la $a0, space #load address of space string
    	li $v0, 4 #signal system to get ready to print space
    	syscall #call system to print
	jr $ra
	

CYLINDERVOLUME:
	#l.d $f1, pi
	lw $t2, 0($s1)# diameter
	lw $t4, 4($s1)# $t0 = ar[7] height
	
	
	
	lwc1 $f7, realpi($0)
	
	div $t8, $t4, 2 #$f8 = radius = arr[7] / 2 = 10
	#ldc1 $f10, pi($0)
	
	mul $t1, $t8, $t8#radius * radius
	mul $t5, $t1, $t2#radius*height
	sw   $t5, -88($fp) #storing word and pointer
	lwc1 $f4, -88($fp) #loading  pointer as float
	cvt.s.w $f6, $f4 #converting to float
	mul.s $f28, $f6, $f7 #vol = 
	s.s $f28, 20($a1) # stroing cyclinder volume into array
	
	la $a0, space #load address of space string
    	li $v0, 4 #signal system to get ready to print space
    	syscall #call system to print
    	
	li $v0, 2 #signal system to get ready to print floats
	l.s $f12, 20($a1) #load calcar[i] into $f12
    	syscall	#call system to print
    		
    	
	#swc1 $f6, 20($f30)
	jr $ra

CHECKNEG:
	#passed value
	blez $s0, EXIT #if (s0, <= 0) exit(1);
	jr $ra #if (s0, > 0) go back

STALL:
	jr $ra
CONVERT_TO_FLOAT:
	#$s7 = int
	sw   $s7, -88($fp)
	lwc1 $f4, -88($fp)
	cvt.s.w $f26, $f4 #store value from temporary variable $f4, into saved temp $f26
	jr $ra
	
PRINT_CHECK:
	li $v0, 2 #signal system to get ready to print floats
	l.s $f12, ($a1) #load calcar[i] into $f12
    	syscall	#call system to print
    		
    	la $a0, space #load address of space string
    	li $v0, 4 #signal system to get ready to print space
    	syscall #call system to print
	jr $ra
EXIT:
	li $v0, 10
	syscall
