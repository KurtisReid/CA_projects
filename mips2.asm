.data
arr:.word 8
size: .double 8
calcarr: .double 7
calcarrsize: .double 7
space: .asciiz " new york "
head: .asciiz "Calcarr is \n"
pi: .double 3.14

.text
	la $s1, arr #load address of arr
	la $s5, size #load adreess of size var
	lw $s5, 0($s5) #load array size
	
	
	li $t0, 90
	sw $t0, 0($s1) # arr[0] = 90
	li $t0, 80
	sw $t0, 4($s1) # arr[1] = 80
	li $t0, 70
	sw $t0, 8($s1) # arr[2] = 70
	li $t0, 60
	sw $t0, 12($s1) # arr[3] = 60
	li $t0, 50
	sw $t0, 16($s1) # arr[4] = 50
	li $t0, 40
	sw $t0, 20($s1) # arr[5] = 40
	li $t0, 30
	sw $t0, 24($s1) # arr[6] = 30
	li $t0, 20
	sw $t0, 28($s1) # arr[7] = 20
	# $s2 = calcarr[]
	#jump to checkneg
	
	#jal CHECKNEG
	
	#la $a0, arr #inputing first arg for print (calcarr)
	#add $a1, $zero, $s5 # calcarr size -> a1
	#jal PRINT
	
	la $s3, calcarr #load address of calcarr
	la $s4, calcarrsize #load adreess of calcarrsize var
	lw $s4, 0($s4) #load array calcarrsize
	
	#works
	lw $s0, 0($s1)# $t0 = arr[0] = height = 90
	lw $s2, 4($s1)# $t4 = arr[1] = width = 80
	lw $s6, 8($s1)# $t2 = arr[2] = length = 70
	jal PERIMETER
	sw $s7, 0($s3) #calcarr[0] = r1_perm
	
	
	#li $v0, 1
	#add $a0, $s7, $zero
	#syscall
	
	# works 12:02
	jal PRISMVOLUME
	sw $s7, 4($s3) #calcarr[1] = r1_vol = 504000
	
	#li $v0, 1
	#add $a0, $s7, $zero
	#syscall
	
	# works
	lw $s0, 12($s1)# $t0 = arr[3]
	lw $s2, 16($s1)# $t4 = arr[4]
	lw $s6, 20($s1)# $t2 = arr[5]
	jal PERIMETER
	sw $s7, 8($s3) #calcarr[2] = r2_perm = 180
	
	# works
	jal PRISMVOLUME
	sw $s7, 12($s3) #calcarr[3] = r2_vol = 120000
	
	li $s2, 2
	ld $s0, 28($s1)# $t0 = ar[7]
	
	
	
	#check 87
	div $s0, $s2 #$f1 = radius = arr[7] / 2 = 10
	mflo $s6
	
	#lwc1 $f2, pi($s0)
	#ldc1 $f2, 
	#la $t0, pi
	#lwc1 $f1, ($t0)
	#lwc1 $f1, pi($s0)
	jal CIRCUMFRENCE 
	sw $s7, 16($s3)
	#li $v0, 3
	#add $a0, $s7, $zero
	#syscall

	#lw $s7, 24($s1) #$t0 = arr[6]
	jal CYLINDERVOLUME
	sw $s7, 20($s3)
	li $v0, 2
	add $a0, $s7, $zero
	syscall

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
	 
	#lwc1 $f2, pi($s0)
	#swc1 $f2, 0($sp)
	mul $s7, $s6, $s2#radius*2
	mul $s7, $s7, $s0#rad*3.14
	jr $ra
	

CYLINDERVOLUME:
	#l.d $f1, pi
	mul $s7, $s6, $s6#radius * radius
	mul $s7, $s7, $s2#radius*height
	mul $s7, $s7, $s2 #vol = 
	jr $ra

CHECKNEG:
	sw $t3, -1
	slt $t1, $t2, $t3
	bnez $t3, EXIT
	jr $ra
	
	
EXIT:
	li $v0, 10
	syscall