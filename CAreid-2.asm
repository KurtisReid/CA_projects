.data
arr:.double 0 : 8
size: .double 8
calcarr: .double 0:6
calcarrsize: .double 6

.text
	la $s1, arr #load address of arr
	la $s5, size #load adreess of size var
	lw $s5, 0($s5) #load array size
	
	la $s2, calcarr #load address of calcarr
	la $s4, calcarrsize #load adreess of calcarrsize var
	lw $s4, 0($s4) #load array calcarrsize


	#$s3 = ar[]
	li $t0,  90
	sw $t0, 0($s1) # arr[0] = 90
	li $t0,  80
	sw $t0, 4($s1) # arr[1] = 80
	li $t0,  70
	sw $t0, 8($s1) # arr[2] = 70
	li $t0,  60
	sw $t0, 12($s1) # arr[3] = 60
	li $t0,  50
	sw $t0, 16($s1) # arr[4] = 50
	li $t0,  40
	sw $t0, 20($s1) # arr[5] = 40
	li $t0,  30
	sw $t0, 24($s1) # arr[6] = 30
	li $t0,  20
	sw $t0, 28($s1) # arr[7] = 20
	# $s2 = calcarr[]
	#jump to checkneg
	
	#jal CHECKNEG
	
	
	
	lw $t0, 4($s1)# $t0 = arr[0]
	lw $t1, 8($s1)# $t4 = arr[1]
	lw $t2, 12($s1)# $t2 = arr[2]
	jal PERIMETER
	sw $t3, 4($s2) #calcarr[0] = r1_perm
	jal PRISMVOLUME
	sw $t5, 8($s2) #calcarr[1] = r1_vol
	
	lw $t0, 12($s1)# $t0 = arr[3]
	lw $t1, 16($s1)# $t4 = arr[4]
	lw $t2, 20($s1)# $t2 = arr[5]
	jal PERIMETER
	sw $t3, 12($s2) #calcarr[2] = r2_perm
	jal PRISMVOLUME
	sw $t5, 16($s2) #calcarr[3] = r2_vol
	
	#lw $f0, 32($s1)# $t0 = ar[7]
	#li $f2, 2
	#div.s $f1, $f0, $f2#$f1 = radius
	
	#jal CIRCUMFRENCE 
	#sw $f0, 20($s2)

	#lw $f0, 24($s1)#$t0 = arr[6]
	#jal CYLINDERVOLUME
	#sw $f0, 24($s2)
	
	jal EXIT
	

	
PERIMETER:
	mul $t3, $t0, 2#$t3 = 2 * height
	mul $t4, $t1, 2#$t4 = 2 * width
	add $t3, $t3, $t4#$t3 = 
	jr $ra

PRISMVOLUME:
	mul $t4, $t0, $t1
	mul $t5, $t4, $t2
	jr $ra

CIRCUMFRENCE:
	#swc1 
	mul.s $f0, $f1, $f2#radius*2
	mul.s $f0, $f0, $f6#rad*3.14
	jr $ra

CYLINDERVOLUME:
	#li $f6, 2.0
	mul.s $f0, $f1, $f1#radius * radius
	mul.s $f2, $f0, $f0#radius*height
	mul.s $f0, $f2, $f6 #vol = vol*2
	jr $ra

CHECKNEG:
	sw $t3, -1
	slt $t1, $t2, $t3
	bnez $t3, EXIT
	jr $ra
EXIT:
	li $v0, 10
	syscall
