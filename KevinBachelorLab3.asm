#---------------------------------
# Ex.3: A Loop of Your Own in MIPS
# --------------------------------

.data
        
startString:      .asciiz     "Processing Pixels\n"
finishString:     .asciiz     "Finished.\n"
ret:		  .asciiz     "\n"
pixel:		  .asciiz     "Pixel num : "
red:		  .asciiz     "Red : "
blue:		  .asciiz     "Blue : "
green:		  .asciiz     "Green : "


Pixels:           .word       0x00010000,0x010101,0x6,0x3333,0x030c,0x700853,0x294999,-1

.text

main:
      li $v0, 4               #System call code for print_str
      la $a0, startString     #address of string to print 
      syscall                 #print the string
      
      la $t0, Pixels	      #Sets pixels as source
      add $t3, $t0, $0	      #t0 = original
      addi $t0, $t0, -4
      

pl:
      addi $t0, $t0, 4	      #Increments loop (t0 is counter and address)
      lw $t1, 0($t0)	      #Gets contents of t0 and puts in t1 (should be the individual pixel)
      
      beq $t1, $t7, exit
      
      li $v0, 4		      #Prints the word Pixel
      la $a0, pixel           #See above
      syscall                 #See above
      
      sub $t4, $t0, $t3	      #Original pixel - current to get pixel num
      srl $t4, $t4, 2	      #Gets num as number not bit
      
      li $v0, 1		      #Print pixel num
      add $a0, $0, $t4	      #See above
      syscall		      #See above
      
      #li $v0, 4		      #Prints the word \n
      #la $a0, ret             #See above
      #syscall                 #See above
      
      #li $v0, 34               #Print the pixel hex
      #add $a0, $0, $t1
      #syscall
      
      li $v0, 4		      #Prints the word \n
      la $a0, ret             #See above
      syscall                 #See above
      
      li $v0, 4		      #Prints the word Blue
      la $a0, blue            #See above
      syscall                 #See above
      
      sll $t2, $t1, 24	      #Isolates first byte
      srl $t2, $t2, 24	      #see above
      
      add $a0, $0, $t2        #Prints t2
      li  $v0, 1	      #See above
      syscall		      #See above
      
      li $v0, 4		      #Prints the word \n
      la $a0, ret             #See above
      syscall                 #See above
      
      li $v0, 4		      #Prints the word Green
      la $a0, green           #See above
      syscall                 #See above
      
      sll $t2, $t1, 16	      #Isolates Second byte
      srl $t2, $t2, 24	      #see above
      
      add $a0, $0, $t2        #Prints t2
      li  $v0, 1	      #See above
      syscall		      #See above
      
      li $v0, 4		      #Prints the word \n
      la $a0, ret             #See above
      syscall                 #See above
      
      li $v0, 4		      #Prints the word Red
      la $a0, red             #See above
      syscall                 #See above
      
      sll $t2, $t1, 8	      #Isolates Third byte
      srl $t2, $t2, 24	      #see above
      
      add $a0, $0, $t2        #Prints t2
      li  $v0, 1	      #See above
      syscall		      #See above
      
      li $v0, 4		      #Prints the word \n
      la $a0, ret             #See above
      syscall                 #See above
      syscall		      #New line again
      
      li $t7, -1
      j pl 
      

exit:
      li $v0, 4               #System call code for print_str
      la $a0, finishString    #address of string to print 
      syscall                 #print the string

      li   $v0, 10            #System call code for exit
      syscall                 #exit the program
