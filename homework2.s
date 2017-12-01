   addi $t1, $zero, 19
   addi $s1, $zero, 3013866891
   ori  $s2, $zero, -1
   sll  $s2, $s2, 16
   ori  $s2, $s2, -1
   sll  $s2, $s2, 2
   ori  $t2, $zero, 1
   sll  $t2, $t2, 16
   sll  $t2, $t2, 15
start:
   andi $s7, $t1, 1
   beq  $s7, $zero, else
   srl  $s1, $s1, 1
   and  $s1, $s1, $s2
   ori  $s1, $s1, 1
   j    ctrl
else:
   srl  $s1, $s1, 1
   or   $s1, $s1, $t2
   sra  $s1, $s1, 2
ctrl:
   addi $t1, $t1, -3
   slt  $s5, $t1, $zero
   bne  $s5, $zero, done
   j    start
done:
   srl $s1, $s1, 2