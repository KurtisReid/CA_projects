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
	
	#cercumfrence
		l.s $f10, two
	#ldc1 $f2, ($t1)
	

	
	
	
	l.s $f4, 28($s1)# $t0 = ar[7]
	
	l.s $f2, 24($s1)
	
	#f0 = f2
	
	#f2 = f4
	#check 87
	div.s $f8, $f4, $f10 #$f8 = radius = arr[7] / 2 = 10
	#ldc1 $f10, pi($0)
	
	mul.s $f4, $f8, $f8#radius * radius
	
	l.d $f6, pi($0)
	mul.s $f4, $f4, $f2#radius*height
	mul.s $f0, $f4, $f6 #vol =
	l.s $f4, 28($s1)# $t0 = ar[7]
	
	lwc1 $f2, 24($s1)
	
	s.s $f0, 20($s3)
	
	li $v0, 10
	syscall