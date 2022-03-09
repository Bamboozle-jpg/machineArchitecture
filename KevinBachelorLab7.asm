li $t1, 1 #a
li $t2, 2 #b
li $t3, 0 #c
li $t4, 5 #d
li $s0, 0 #i
li $s1, 0 #x

loop:
add $t1, $t1, $t2
addi $s0, $s0, 1
slt $s1, $s0, $t4
bne $s1, $0, loop

end:
li $v0, 1
move $a0, $t1
syscall