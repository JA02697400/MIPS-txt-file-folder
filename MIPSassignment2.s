.data
	number1: .word 5
	number2: .word 25
.text
	lw $t0, number1($zero)
	lw $t1, number2($zero)
	sub $t2, $t1, $t0
	li $v0, 1
	add $a0, $zero, $t2
	syscall

