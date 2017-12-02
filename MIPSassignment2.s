.data
	prompt: .asciiz "Enter 1000 characters: "
	array: .space 1001
	message: .asciiz "\nToo Large\n"
.text
	main:
		li $v0, 8
		la $a0, array
		li $a1, 1001
		syscall
		
		li $v0, 4
		
		
		
		
	#This is the end of main
	li $v0, 10
	syscall
	