.data
     message:  .asciiz "Please enter a word 8 letters long: "
     userInput:  .space 32
.text
.globl main

main:
      addi $t0,$zero,userInput
      div $t1,10
      mfhi $t2
      mflo $t3 