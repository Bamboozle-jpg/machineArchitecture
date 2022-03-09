.data
	inString:	.space 	64 
	revString:	.space 	64
	forString:	.space 	64
	ret:		.asciiz	"\n"
	yay:		.asciiz "Congrats, that is a palindrome!"
	boo:		.asciiz "Nice try, but that's not a palindrome!"
.text
main:
	li $v0, 8		#Get user input
	la $a0, inString
	li $a1, 64
	syscall
	move $s0, $a0
	
	la $s3, revString	#where the reverse string is put
	la $s4, forString	#Where the char only string is put
				#Put reverse in revstring
				#Use bltu to check put in place
				
	addi $s0, $s0, -1
	move $t1, $0		#Sets up t1 as counter
	
loopOutside:
	addi $s0, $s0, 1	#Moves to next letter in a0
	lb $s1, 0($s0)		#s1 contains current thing

	li $t0, 97		#Escapes loop if it's not a lowercase char
	bltu $s1, $t0, notChar 
	li $t0, 123
	bltu $t0, $s1, notChar
	
postCheck:			#Jump here if converted
	sb $s1, 0($s3)		#Stores letter in both strings
	sb $s1, 0($s4)
	
	lb $a0, 0($s3)
	li $v0, 11
	syscall
	
	addi $s3, $s3, -1	#Prev letter in s3
	addi $s4, $s4, 1	#Next letter in s4
	addi $t1, $t1, 1	#t1 is counter

	j loopOutside
	
exitLoop:
	sub $s4, $s4, $t1	#Preps s4 to be printed
	addi $s3, $s3, 1
	li $v0, 4		#Prints the word \n
      	la $a0, ret             
      	syscall                 
loop2:
	lb $a0, 0($s4)
	lb $a1, 0($s3)
	li $v0, 11
	syscall
	beq $a0, $0, success
	bne $a1, $a0, fail

	addi $s4, $s4, 1
	addi $s3, $s3, 1
	j loop2

exit:																		
	li   $v0, 10            #System call code for exit
       	syscall                 #exit the program
       	
notChar:
	beq $s1, $0, exitLoop	#If current letter is \0, exit
	li $t0, 65		#If not letter, just move on
	bltu $s1, $t0, noConvert
	li $t0, 91
	bltu $t0, $s1, noConvert
				#Else
	addi $s1, $s1, 32	#Uppercase to lower case
	j postCheck		#Go back to the loop right after we exited
	
noConvert:
	li $t0, 48		#If not a number just move on
	bltu $s1, $t0, loopOutside
	li $t0, 58
	bltu $t0, $s1, loopOutside
	j postCheck		#Else it's a number and go back to where we left
	
success:			#FAIL
	li $v0, 4		
      	la $a0, ret             
      	syscall    
      	la $a0, yay
      	syscall
      	j exit
      	
fail:				#SUCCESS!
	li $v0, 4
	la $a0, ret
	syscall
	la $a0, boo
	syscall
	j exit
	
