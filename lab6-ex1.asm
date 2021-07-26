.data 0x10000000 ##!
  display: 	.space 65536
  		.align 2
  redPrompt:	.asciiz "Enter a RED color value (integer in range 0-255):\n"
  greenPrompt:	.asciiz "Enter a GREEN color value (integer in range 0-255):\n"
  bluePrompt:	.asciiz "Enter a BLUE color value (integer in range 0-255):\n"


.text 0x00400000 ##!
main:

	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, redPrompt 			# address of columnPrompt is in $a0
	syscall           			# print the string
	# read in the R value
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
 	add	$s0, $0, $v0			# copy red N into $s0
 	
 	
 	
 	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, greenPrompt 		# address of columnPrompt is in $a0
	syscall           			# print the string
	# read in the G value
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
 	add	$s1, $0, $v0			# copy green N into $s1
 	
 	
 	
 	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, bluePrompt 		# address of columnPrompt is in $a0
	syscall           			# print the string
	# read in the B value
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
 	add	$s2, $0, $v0			# copy blue N into $s2
 	
 	
 	
 	
##################################################################################
##   Setup for drawing a white display    		                        ##
##################################################################################
 	#li $t0, 0
	#li $s3, 16384
	#li $t1, 0x00ffffff # = RGB(255,255,255)
	#j drawDisplay
##################################################################################	

##################################################################################
##   Insert code here for drawing a colored display. Be sure to comment out 	##
##   or remove the code above for drawing a white display.    		        ##
##################################################################################
	sll $t5, $s1, 8			#shift green left two bytes
	sll $t4, $s0, 16			# shift red left 4 bytes
	or $t1, $t5, $t4		# or these two
	or $t1, $t1, $s2		# or the red/green with blue
	
	j drawDisplay

 	

	
drawDisplay:
	mul $t3, $t0, 4
	sw $t1, display($t3)
	addi $t0, $t0, 1
	bne $t0, $s3, drawDisplay

# Exit from the program
exit:
  ori $v0, $0, 10       		# system call code 10 for exit
  syscall               		# exit the program
