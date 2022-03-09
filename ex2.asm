	
	
	
	add $t0, $0, $s0	#t0 = s0
	add $t1, $0, $s1	#t1 = s1
	xor $t2, $t0, $t1 
	xor $t3, $t1, $t2 
	xor $t4, $t2, $t3 
	xor $t5, $t3, $t4 
	xor $t6, $t4, $t5 
	xor $t7, $t5, $t6 
	addi $v0, $0, 10
	syscall