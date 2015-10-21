.data
arr:.double 0 : 9
size: .word 9
calcarr: .double 0 : 7
calcarrsize: .double 7
space: .asciiz " new york "
head: .asciiz "Calcarr is \n"
pi:.float 3.14
two: .float 2



.text
	la $s1, arr #load address of arr
	la $s5, size #load adreess of size var
	lw $s5, 0($s5) #load array size
	
	la $s3, calcarr #load address of calcarr
	la $s4, calcarrsize #load adreess of calcarrsize var
	lw $s4, 0($s4) #load array calcarrsize
	

	#ldc1 $f2, 3.14
	#swc1 

	#$s3 = ar[]
	
	li $t0, 90
	sd $t0, 0($s1) # arr[0] = 90
	li $t0, 80
	sd $t0, 4($s1) # arr[1] = 80
	li $t0, 70
	sd $t0, 8($s1) # arr[2] = 70
	li $t0, 60
	sd $t0, 12($s1) # arr[3] = 60
	li $t0, 50
	sd $t0, 16($s1) # arr[4] = 50
	li $t0, 40
	sd $t0, 20($s1) # arr[5] = 40
	li $t0, 30
	sd $t0, 24($s1) # arr[6] = 30
	li $t0, 20
	sd $t0, 28($s1) # arr[7] = 20
	# $s2 = calcarr[]
	#jump to checkneg
	
	#jal CHECKNEG
	
	la $a0, arr #inputing first arg for print (calcarr)
	add $a1, $zero, $s5 # calcarr size -> a1
	#jal PRINT
	addi $s2, $s5, -1
	#works
	loop:
		ble $s2, 4, cyclinder
		lw $s0, 0($s1)# $t0 = arr[0] = height = 90
		lw $s2, 4($s1)# $t4 = arr[1] = width = 80
		lw $s6, 8($s1)# $t2 = arr[2] = length = 70
		jal PERIMETER
		addi $s3, $s3, 4
		sw $s7, 0($s3) #calcarr[0] = r1_perm
		#addi $s3, $s3, 4
	
	#li $v0, 1
	#add $a0, $s7, $zero
	#syscall
	
	# works 12:02
		jal PRISMVOLUME
		sw $s7, 4($s3) #calcarr[1] = r1_vol = 504000
		addi $s3, $s3, 4
	
	#li $v0, 1
	#add $a0, $s7, $zero
	#syscall
	
		addi $s1, $s1, 12 #incriment address
		
		addi $s2, $s2, -2
		bgtz $s2, loop
	
	
	# works
	#lw $s0, 12($s1)# $t0 = arr[3]
	#lw $s2, 16($s1)# $t4 = arr[4]
	#lw $s6, 20($s1)# $t2 = arr[5]
	#jal PERIMETER
	#sw $s7, 8($s3) #calcarr[2] = r2_perm = 180
	
	# works
	#jal PRISMVOLUME
	#sw $s7, 12($s3) #calcarr[3] = r2_vol = 120000
	

	cyclinder:
		jal CIRCUMFRENCE 

		#lw $s7, 24($s1) #$t0 = arr[6]
		jal CYLINDERVOLUME
		#sw $s7, 20($s3)
		#li $v0, 2
		#add $a0, $s7, $zero
		#syscall

	la $a0, calcarr #inputing first arg for print (calcarr)
	add $a1, $zero, $s4 # calcarr size -> a1
	#jal PRINT
	
	jal EXIT
	

	
PERIMETER:
	# works march 11 2015 11:58
	mul $s7, $s6, 2#$t3 = 2 * length = 2 * 70
	mul $t4, $s2, 2#$t4 = 2 * width = 2 * 80
	add $s7, $s7, $t4#$t3 = 300
	jr $ra

PRISMVOLUME:
	# works
	mul $t4, $s0, $s2
	mul $s7, $t4, $s6
	jr $ra

CIRCUMFRENCE:
	#li $f2, 2
	#ldc1 $f2, ($t1)
	lw $t4, 28($s1)# $t0 = ar[7]
	li $t2, 2
	#f0 = f2
	
	#f2 = f4
	#check 87
	div $t4, $t2 #$f8 = radius = arr[7] / 2 = 10
	mflo $f6
	cvt.d.w $f2, $f6
	l.s $f6, pi
	mul.s $f0, $f8, $f2#radius*2
	#mfhi $t0
	mul.s $f10, $f0, $f6#rad*3.14
	#mfhi $t1
	#mflo $t2
	swc1 $f10, 16($s3)
	jr $ra

CYLINDERVOLUME:
	#l.d $f1, pi
	
	l.s $f4, 28($s1)# $t0 = ar[7]
	
	l.s $f2, 24($s1)
	l.d $f6, pi($0)
	#f0 = f2
	
	#f2 = f4
	#check 87
	div.s $f8, $f4, $f10 #$f8 = radius = arr[7] / 2 = 10
	#ldc1 $f10, pi($0)
	
	mul.s $f10, $f8, $f8#radius * radius
	mul.s $f4, $f10, $f2#radius*height
	mul.s $f8, $f4, $f6 #vol = 
	#mflo 
	s.d $f8, 20($s3)
	#swc1 $f8, 20($s3)
	jr $ra

CHECKNEG:
	sw $t3, -1
	slt $t1, $t2, $t3
	bnez $t3, EXIT
	jr $ra
	
	
EXIT:
	li $v0, 10
	syscall
