.data
shouldben1:	.asciiz "Should be -1, and firstposshift and firstposmask returned: "
shouldbe0:	.asciiz "Should be 0 , and firstposshift and firstposmask returned: "
shouldbe16:	.asciiz "Should be 16, and firstposshift and firstposmask returned: "
shouldbe31:	.asciiz "Should be 31, and firstposshift and firstposmask returned: "

.text
main:
	la	$a0, shouldbe31	#Sets a0 to shouldbe31
	jal	print_str	# Prints it
	lui	$a0, 0x8000	# should be 31  
	jal	first1posshift	# Jump and link to first1posShift
	move	$a0, $v0	# moves v0 to a0
	jal	print_int	# Prints 
	jal	print_space	# Prints a Space

	lui	$a0, 0x8000
	jal	first1posmask
	move	$a0, $v0
	jal	print_int
	jal	print_newline

	la	$a0, shouldbe16
	jal	print_str
	lui	$a0, 0x0001	# should be 16 
	jal	first1posshift
	move	$a0, $v0
	jal	print_int
	jal	print_space	# Prints a space

	lui	$a0, 0x0001
	jal	first1posmask
	move	$a0, $v0
	jal	print_int
	jal	print_newline

	la	$a0, shouldbe0
	jal	print_str
	li	$a0, 1		# should be 0
	jal	first1posshift
	move	$a0, $v0
	jal	print_int
	jal	print_space

	li	$a0, 1
	jal	first1posmask
	move	$a0, $v0
	jal	print_int
	jal	print_newline	#DONE UP TO HERE

	la	$a0, shouldben1
	jal	print_str
	move	$a0, $0		# should be -1
	jal	first1posshift
	move	$a0, $v0
	jal	print_int
	jal	print_space

	move	$a0, $0
	jal	first1posmask
	move	$a0, $v0
	jal	print_int
	jal	print_newline
	li	$v0, 10		# Exit
	syscall

first1posshift:
	li	$t1, 0x000001
	li 	$t0, 0
	li 	$t3, 40
shiftLoop:
	beq	$a0, $t1, shiftLoopExit2
	srl 	$a0, $a0, 1
	add	$t2, $t0, $t1
	beq	$a0, $t1, shiftLoopExit
	addi 	$t0, $t0, 1
	beq 	$t0, $t3, shiftLoopExit3
	j shiftLoop
shiftLoopExit2:
	subi 	$t0, $t0, 1
shiftLoopExit:
	addi 	$t0, $t0, 1
	move 	$v0, $t0
	jr 	$ra
shiftLoopExit3:
	li 	$v0, -1
	jr	$ra


first1posmask:
	li	$t1, 0x80000000
	li 	$t0, 31
	and	$t2, $t1, $a0
	bne	$t2, $0 exitMask
	li	$t3, -1
maskLoop:
	subi	$t0, $t0, 1
	srl	$t1, $t1, 1
	and	$t2, $t1, $a0
	bne	$t2, $0 exitMask
	beq	$t0, $t3 exitMask2
	j maskLoop
exitMask:
	move 	$v0, $t0
	jr 	$ra
exitMask2:
	li 	$v0, -1
	jr $ra
	
	
print_int:			# prints integer in v0
	move	$a0, $v0	# moves v0 into a0
	li	$v0, 1		
	syscall
	jr	$ra

print_str:			# prints string in a0
	li	$v0, 4
	syscall
	jr	$ra
	
print_space:			# Prints a space
	li	$a0, ' '
	li	$v0, 11
	syscall
	jr	$ra
	
print_newline:			# Prints a new line
	li	$a0, '\n'
	li	$v0, 11
	syscall
	jr	$ra