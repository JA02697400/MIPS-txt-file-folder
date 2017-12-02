.data
	prompt: .asciiz "Enter 1000 characters: "
	message: .asciiz "\nToo Large\n"
.text
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 8
	syscall
	
	move $t0, $v0
	
	li $v0, 4
	la $a0, message
	syscall
	
	li $v0, 4
	move $a0, $t0
	syscall
	