.data
	array: .space 1001
	message1: .asciiz "\nYou have entered a string that is 1000 characters long!!!\n"
.text
	main:
		li $v0, 8
		la $a0, array
		li $a1, 1001
		syscall
		
		li $v0, 4
		la $a0, message1
		syscall
		
		
		li $v0, 4
		la $a0, array
		syscall
		
		
		
	#This is the end of main
	li $v0, 10
	syscall
	