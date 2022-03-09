       .data 
n:     .word 13
       .text
main:  addu    $t0, $0, $zero	#$t0 = 0
	addiu   $t1, $zero, 1	#$t1 = 1
	la      $t3, n		#$t3's address = n
	lw      $t3, 0($t3)	#Load the value at t3's address into t3

fun:   beq     $t3, $0, finish	#If t3 = 0, go to finish
	add     $t2, $t1, $t0	#t2 = t1 + t0 (t2 = 1)
	move    $t0, $t1	#t0 = t1 (t0 = 1)
	move    $t1, $t2	#t1 = t2 (t1 = 1)
	subi    $t3, $t3, 1	#t3--
	j       fun		#jump to top

finish: addiu   $a0, $t0, 0	#a0 = t0
	li      $v0, 1		#v0 = 1
	syscall			#syscall prints a0
	li      $v0, 10		#v0 = 10
	syscall			#syscall Exit
