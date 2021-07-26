.data 0x10000000 ##!
  display: 	.space 65536
  		.align 2
  redPrompt:	.asciiz "Enter a RED color value for the background (integer in range 0-255):\n"
  greenPrompt:	.asciiz "Enter a GREEN color value for the background (integer in range 0-255):\n"
  bluePrompt:	.asciiz "Enter a BLUE color value for the background (integer in range 0-255):\n"
  redLinePrompt:	.asciiz "Enter a RED color value for the line (integer in range 0-255):\n"
  greenLinePrompt:	.asciiz "Enter a GREEN color value for the line (integer in range 0-255):\n"
  blueLinePrompt:	.asciiz "Enter a BLUE color value for the line (integer in range 0-255):\n"
  x1Prompt: 	.asciiz "Enter x1 (integer in range 0-127):\n"  
  y1Prompt: 	.asciiz "Enter y1 (integer in range 0-127):\n"
  x2Prompt: 	.asciiz "Enter x2 (integer in range 0-127):\n"
  y2Prompt: 	.asciiz "Enter y2 (integer in range 0-127):\n"
  x3Prompt: 	.asciiz "Enter x3 (integer in range 0-127):\n"
  y3Prompt: 	.asciiz "Enter y3 (integer in range 0-127):\n"


.text 0x00400000 ##!
main:

	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, redPrompt 		# address of columnPrompt is in $a0
	syscall           			# print the string
	# read in the R value
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
 	add	$s0, $0, $v0			# copy N into $s0
 	
 	
 	
 	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, greenPrompt 		# address of columnPrompt is in $a0
	syscall           			# print the string
	# read in the G value
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
 	add	$s1, $0, $v0			# copy N into $s1
 	
 	
 	
 	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, bluePrompt 		# address of columnPrompt is in $a0
	syscall           			# print the string
	# read in the B value
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
 	add	$s2, $0, $v0			# copy N into $s2
 	
 	j setupDisplay
 	
 	
	
# Exit from the program
exit:
  ori $v0, $0, 10       		# system call code 10 for exit
  syscall               		# exit the program
  
##################################################################################
##   Do not modify any of the code above    		                        ##
##################################################################################
	
setupDisplay:
	li $t0, 0
	li $s3, 16384
##################################################################################
##   Insert your code for getting combinging the RGB integers (from 		##
##   exercise 1) here!    
	sll $t5, $s1, 8			#shift green left two bytes
	sll $t4, $s0, 16		# shift red left 4 bytes
	or $t1, $t5, $t4		# or these two
	or $t1, $t1, $s2		# or the red/green with blue		                        		##
##################################################################################
	j drawDisplay
	
drawDisplay:
	mul $t3, $t0, 4
	sw $t1, display($t3)
	addi $t0, $t0, 1
	bne $t0, $s3, drawDisplay
	
	
readLineColors:
	addi	$v0, $0, 4  	
	la 	$a0, redLinePrompt 
	syscall           	
	# read in the R value
	addi	$v0, $0, 5	
	syscall 		
 	add	$s0, $0, $v0	
 	
 	
 	
 	addi	$v0, $0, 4  			
	la 	$a0, greenLinePrompt 		
	syscall           			
	# read in the G value
	addi	$v0, $0, 5			
	syscall 				
 	add	$s1, $0, $v0			
 	
 	
 	
 	addi	$v0, $0, 4  		
	la 	$a0, blueLinePrompt 	
	syscall           		
	# read in the B value
	addi	$v0, $0, 5		
	syscall 			
 	add	$s2, $0, $v0	
 	
 	
##################################################################################
##   Insert your code for getting combinging the RGB integers (from 		##
##   exercise 1) here!		

	sll $t5, $s1, 8			# shift green left two bytes
	sll $t4, $s0, 16		# shift red left 4 bytes
	add $s3, $0, $0			# initialize line color reg to 0
	or $s3, $t5, $t4		# or these two
	or $s6, $s3, $s2		# put line color in s6
														##
##################################################################################	
	j setupDrawTriangle # Do not change this line
	
readLineCoordinates:
	
	# initialize stack items
	addi $sp, $sp, -8
	sw $ra, 4($sp)		# save ra
	sw $fp, 0($sp)		# save fp 
	addi $fp, $sp, 4	# set fp 
	
	
	addi	$v0, $0, 4  	
	la 	$a0, x1Prompt
	syscall           	
	addi	$v0, $0, 5	
	syscall 		
 	add	$s0, $0, $v0	
 	
 	
 	
 	addi	$v0, $0, 4  			
	la 	$a0, y1Prompt
	syscall           			
	addi	$v0, $0, 5			
	syscall 				
 	add	$a1, $0, $v0			
 	
 	
 	
 	addi	$v0, $0, 4  		
	la 	$a0, x2Prompt	
	syscall           		
	addi	$v0, $0, 5		
	syscall 			
 	add	$a2, $0, $v0	
 	
 	addi	$v0, $0, 4  		
	la 	$a0, y2Prompt	
	syscall           		
	addi	$v0, $0, 5		
	syscall 			
 	add	$a3, $0, $v0
 	
 	addi	$v0, $0, 4  		
	la 	$a0, x3Prompt	
	syscall           		
	addi	$v0, $0, 5		
	syscall 			
 	add	$t0, $0, $v0	# We only have 4 argument registers!! We're storing these 
			 	# last two values for now in $t registers, but you'll 
			 	# have to save them onto the stack!
 	
 	addi	$v0, $0, 4  		
	la 	$a0, y3Prompt	
	syscall           		
	addi	$v0, $0, 5		
	syscall 			
 	add	$t1, $0, $v0
 	
 	move $a0, $s0	

	#add $s4, $t0, 0  		# give s4 the x3 coordinate
	#add $s5, $t1, 0 		# give s5 the y3 coordinate
	
	addi $sp, $fp, 4
	lw $ra, 0($fp)
	lw $fp, -4($fp)
	jr $ra
	
setupDrawTriangle:
	# Insert any code necessary before calling drawTriangle
	
	addi $sp, $sp, -8
	sw $ra, 4($sp)		# save ra
	sw $fp, 0($sp)		# save fp 
	addi $fp, $sp, 4	# set fp
	
	#addi $sp, $sp, -8
	#sw $t0, 4($sp)		# make room for x3 in t0
	#sw $t1, 0($sp)		# make room for y3 in t1
		
	jal readLineCoordinates
	
	# save the coordinates in saved registers 0-5
	add $s0, $a0, 0
	add $s1, $a1, 0
	add $s2, $a2, 0
	add $s3, $a3, 0
	add $s4, $t0, 0
	add $s5, $t1, 0
	
	# x1 = s0, y1 = s1, x2 = s2, y2 = s3, x3 = s4, y3 = s5
	
	j drawTriangle
	
drawTriangle:
	# Insert any code necessary to prepare the stack
	# set up 4 parameters to hold the 2 x,y value pairs before each jal
	
	#addi $sp, $sp, -8
	#sw $ra, 4($sp)		# save ra
	#sw $fp, 0($sp)		# save fp 
	#addi $fp, $sp, 4	# set fp
	
	# store dx1 and dy1
	#sub $s6, $s2, $s0	# store dx in s6
	#sub $s7, $s3, $s1	# store dy in s7
	
	# give the first 4 arguments the (x,y) coordinates
	add $a0, $s0, 0
	add $a1, $s1, 0
	add $a2, $s2, 0
	add $a3, $s3, 0
	
	
	# save these 2 points
	addi $sp, $sp, -24
	sw $s0, 20($sp)
	sw $s1, 16($sp)
	sw $s2, 12($sp)
	sw $s3, 8($sp)
	sw $s4, 4($sp)
	sw $s5, 0($sp)
	
	jal drawLine 
	
	# Insert any code necessary to prepare the stack
	
	# store dx2 and dy2
	#sub $s6, $s2, $t0	# store dx in s6
	#sub $s7, $s3, $t1	# store dy in s7
	
	# give the first 4 arguments the (x,y) coordinates
	add $a0, $s4, 0
	add $a1, $s5, 0
	add $a2, $s2, 0
	add $a3, $s3, 0
	
	
	# save these 2 points
	addi $sp, $sp, -24
	sw $s0, 20($sp)
	sw $s1, 16($sp)
	sw $s2, 12($sp)
	sw $s3, 8($sp)
	sw $s4, 4($sp)
	sw $s5, 0($sp)
	
	jal drawLine
	
	# Insert any code necessary to prepare the stack	
	
	# store dx3 and dy3
	#sub $s6, $s4, $s0	# store dx in s6
	#sub $s7, $s5, $s1	# store dy in s7
	
	# give the first 4 arguments the (x,y) coordinates
	add $a0, $s0, 0
	add $a1, $s1, 0
	add $a2, $s4, 0
	add $a3, $s5, 0
	
	# save these 2 points
	addi $sp, $sp, -24
	sw $s0, 20($sp)
	sw $s1, 16($sp)
	sw $s2, 12($sp)
	sw $s3, 8($sp)
	sw $s4, 4($sp)
	sw $s5, 0($sp)
	
	jal drawLine 
	
	j exit	     # Do not change this line	


drawLine:
##################################################################################
##   Insert your code here for setting up the stack frame and drawing 		##
##   the line itself. Return to appropriate point in drawTriangle when 		##
##   finished. You can reuse your code from exercise 2, but you'll have 	##
##   to make additions to deal with saving some arguments			##
##   on the stack and reading them from there.					##
##################################################################################
	
	# initialize stack items
	addi $sp, $sp, -8
	sw $ra, 4($sp)		# save ra
	sw $fp, 0($sp)		# save fp 
	addi $fp, $sp, 4	# set fp
	
	# store dx and dy
	sub $t0, $a2, $a0	# store dx in t0
	sub $t1, $a3, $a1	# store dy in t1

	# get the memory address for x1,y1
	#sll $t7, $a0, 2		# multiply x by 4
	#sll $t8, $a1, 9		# myltiply y by 512
	#add $t9, $t7, $t8	# add the two values to get memory address in $s6
	
	# paint the first point
	#sw $s6, display($t9) 	# paint memory addr in s6 the color in s3
	
	# start $s0 at x1
	addi $t2, $a0, 0
	
	#initalize the temporary registers to 0
	addi $t3, $0, 0
	addi $t4, $0, 0
	
	# set up loop stack to save s4, s5, s6
	addi $sp, $sp, -12
	sw $t2, 8($sp)
	sw $t3, 4($sp)
	sw $t4, 0($sp)
	
	jal loop
	
	# get the memory address for x1,y1
	#sll $t7, $a2, 2		# multiply x by 4
	#sll $t8, $a3, 9		# myltiply y by 512
	#add $t9, $t7, $t8	# add the two values to get memory address in $s6
	
	# paint the first point
	#sw $s6, display($t9) 	# paint memory addr in s6 the color in s3
	
	# restore coordinates
	lw $s0, -8($fp)
	lw $s1, -12($fp)
	lw $s2, -16($fp)
	lw $s3, -20($fp)
	lw $s4, -24($fp)
	lw $s5, -28($fp)

	# return to drawTriangle
	addi $sp, $fp, 4
	lw $ra, 0($fp)
	lw $fp, -4($fp)
	jr $ra

	
loop: 
	
	# formula to get y-value into s5
	sub $t3, $t2, $a0	# x - x1
	mul $t3, $t1, $t3	# dy *		
	div $t3, $t3, $t0	# / dx
	add $t3, $t3, $a1 	# + y1; final result of y = y1 +(dy(x-x1))/dx
	
	# get the memory address
	sll $t5, $t2, 2		# multiply x by 4
	sll $t6, $t3, 9		# myltiply y by 512
	add $t4, $t5, $t6	# add the two values to get memory address in $s6
	
	sw $s6, display($t4) 	# paint memory addr in t4 the color in s6
	
	# increment x-value
	addi $t2, $t2, 1	
	
	# check condition
	blt $t2, $a2, loop	# go through loop again in x counter ($s4) = x2 ($a2) 
	
	# restore saved values
	lw $t2, -8($fp)
	lw $t3, -12($fp)
	lw $t4, -16($fp)
	
	addi $sp, $fp, 4
	lw $ra, 0($fp)
	lw $fp, -4($fp)
	jr $ra




