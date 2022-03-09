.data

begStr: .asciiz "12"
ret:	.asciiz     "\n"

.text

main: 	la $s0, begStr		#Loads '12' into $s0			
	li $s3, 0		#s3 is final result
	li $s4, -48		#s4 for checking to exit
	li $t2, 48		#t2 is for subtracting (48)
	
	li $t1, 10		#t1 is counter
loop:	lb $s1, 0($s0)		#s1 contains current thing
	sub $s1, $s1, $t2
	beq $s1, $s4, exit	#If the ascii in s1 is \0, branch
	mul $s3, $t1, $s3	#mutliply the current thing you got by 1/10/100 depending on when you are
	addi $s0, $s0, 1	#Move s0 to next part of string
	add $s3, $s3, $s1	#add what we just got to total
	
	li $v0, 1		#Print Num that's being worked on
      	add $a0, $0, $s3
	syscall	
	
	li $v0, 4		      #Prints the word \n
      	la $a0, ret             #See above
      	syscall                 #See above

	j loop
	
exit:	move $s1, $s3		#Haha! Now it works, it is saved in 
	li $v0, 1		#Print final
      	add $a0, $0, $s1
	syscall			#NOW YOU CAN USE ANYTHING BUT S1!!
	li $s6 0
	
	li $s0, 0
	li $s6, 0
	
	li $s2, 0			#Setup s2 is the main total
	
fib:	

	move $t0, $0			#Setup (t0 is current thing getting added
	
	bne $s1, $0, Base1		#On 0 return 0
	move $t0, $0
	jr $ra

Base1: 	
	bne $s1, $0, Recurse		#On 1 return 1
	li $t0, 1
	jr $ra
	
Recurse:
	addi $s1, $s1, -1
	jal fib				#fib(n-1)
	addi $s1, $s2, -1
	jal fib				#fib(n-2)
	add $s2, $s2, $t0
	
	
	
exit2:	li $v0, 1
	move $a0, $s2
	syscall
	li   $v0, 10            #System call code for exit
       	syscall                 #exit the program

