.data
	array: .space 1001
	message1: .asciiz "\nYou have entered a string that is 1000 characters long!!!\n"
	invalidMessage: .asciiz "Not even a letter or a number big fella\n"
.text
main:
		
		
		
#Starting index = 0 
#Ending index    = 0

#read a:
			
#Starting index = 0 
#Ending index    = 1

#read a:		
#Starting index = 0 
#Ending index    = 2

#read a:
#Starting index = 0 
#Ending index    = 3

#read , :

#call subprogram 2 with
			
#Starting index = 0 
#Ending index    = 3
		
		
		
				
		#[  a |  a | a | , |  b | b | NL]
		 # 0     1   2   3   4     5   6
#....

#read NL:

#starting index = 4
#ending index = 5	
	  
		 #substring 1: [0:2]
		 #substring 2: [4:5]
		
		 la $s0, array
		 li $t0, 0 	#starting index
		 li $t1, 0 	#ending index
input_loop:
		lb $s1, 0($s0)	#using load byte on memory addrress to get 1 character
		
		beq $s1, 0, call_subprogram_2	#null
		beq $s1, 10, call_subprogram_2	#newline
		beq $s1, 44, call_subprogram_2	#comma, if read go to sub2
		
		add $t0, $t0, 1	# increment ending index
		add $s0, $s0, 1	#increment byte address in input
		
		
		j input_loop
		
		
call_subprogram_2:
		sw $t0, 4($sp)	#store the starting index on the stack
		sw $t1, 8($sp) 	#store the ending index on the stack
		
		sw $s0, 12($sp)	#stores current address in input onto stack
		
		jal subprogram_2	#stores into $ra this line of code to return to
		
		lw $t0, 4($sp)	#loads the starting index from the stack
		lw $t1, 8($sp) 	#loads the ending index from the stack
		lw $s0, 12($sp)	#loads current address in input from stack
	
		add $t0, $t1, 1
		add $t1, $t1, 1	  #puts new starting index and ending index at next substring
		
		add $s0, $s0, 1	#increment byte address in input
		
		j input_loop
		
subprogram_2:
		sw $ra, 40($sp)	#saves return address of sub2 -> main on stack
		
		lw $t0, 4($sp)	#loads the starting index from the stack
		lw $t1, 8($sp) 	#loads the ending index from the stack
		
		la $s0, array	#get memory address of input
		
		add $s0, $s0, $t0	#makes s0 start at substring (base + starting index)
		
		li $s2, 0	#length of substring
		sub $s2, $t1, $t0	#ending index - starting index is the length of the string
		li $s3, 0		#value of the substring
		
		
subprogram_2_loop:	#loops through characters of substring and calls subprogram 1 for each character
		beq $t0, $t1, subprogram_2_exit		#when starting index = ending index exit 
		lb $s1, 0($s0)	#using load byte on memory addrress to get 1 character
		
		sw $s1, 16($sp)	#stores current character onstack
		sw $s0, 20($sp)	#puts memory address on stack
		sw $t0, 24($sp)	#puts starting on stack
		sw $t0, 28($sp)	#puts ending on stack
		sw $s2, 32($sp)	#puts length on stack
		sw $s3, 36($sp)	#puts length on stack
		
		
		jal subprogram_1
		
		
		
subprogram_2_exit:	

		
		lw $ra, 40($sp)	#loads return address of sub2 -> main on stack
		jr $ra
		#we have starting index of a substring and ending index of a substring


subprogram_1:
		lw $s1, 16($sp)	#loads character to be translated

		lw $s2, 32($sp)	#loads length on stack
		
		#For invalids
		
		#blt $s1, 48, translate_0_9
		blt $s0, 48, invalidMessage 
		blt $s1, 58, translate_0_9 
		blt $s0, 65, invalidMessage
				#blt $s1, 48, translate_0_9 
		blt $s1, 71, translate_A_F
		blt $s0, 97, invalidMessage
				#blt $s1, 48, translate_0_9 
		blt $s1, 102, translate_a_f
				#blt $s1, 48, translate_0_9 
		
		j subprogram_2_loop

translate_0_9:
		sub $s1, $s1, 48
		sub $s2, $s2, 1
		li $t1, 4
		
		mult $s2, $t1
		mflo $t2
		
		sllv $s1, $s1, $t2	# (position -1) * 4
		sw $s1, 44($sp)		#saves value of character ont o stack
		
		
		jr $ra
		
translate_A_F:
		sub $s1, $s1, 55
		sub $s2, $s2, 1
		li $t1, 4
		
		mult $s2, $t1
		mflo $t2
		
		sllv $s1, $s1, $t2
		sw $s1, 44($sp)
		
		
		jr $ra
		
translate_a_f:
		sub $s1, $s1, 87
		sub $s2, $s2, 1
		li $t1, 4
		
		mult $s2, $t1
		mflo $t2
		
		sllv $s1, $s1, $t2
		sw $s1, 44($sp)
		
		
		jr $ra

invalid:
		li $v0, 4
		la $a0, invalidMessage
		syscall
		jr $ra
		
		
exit_main:	
	#This is the end of main
	li $v0, 10
	syscall
	