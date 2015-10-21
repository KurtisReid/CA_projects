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
	
	#volume
	
	# pi
	
	# radius
	#l.d $f2, 20 #diameter
	#div.d $f6, $f2, 2 #find radius
	li $t0, 10
	
	
	mult $t0, $t0#radius^2
	mf
	# pi
	ldc1 $f2, pi($0)
	
	mul.s $f0, $f2, $f0
	#height
	li $f4, 30 #height
	mul.s $f8, $f0, $f4
	