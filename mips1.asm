

# declare global so programmer can see actual addresses.
.globl welcome
.globl conversionQuestion
.globl welcome1


.data
CorForK:
    .asciiz " \n input “C”(celsius) or “F”(Fahrenheit) or “K”(Kelvin)"  
answer:
    .space 256

again:
    .asciiz " \n Again (y or n)? " 
    
welcome1:
	.asciiz " \n This program converts Fahrenheit to Celsius and Kelvin\n\n"

prompt3:
	.asciiz " \n Enter a starting integer Fahrenheit temperature: "
prompt4:
	.asciiz " \n Enter an ending integer Fahrenheit temperature: "	

prompt5:
	.asciiz " \n Enter a starting integer kelvin temperature: "

prompt6:
	.asciiz " \n Enter an ending integer kelvin temperature: "		



welcome:
	.asciiz " \n This program converts Celsius to Fahrenheit and Kelvin \n\n"

prompt1:
	.asciiz " \n Enter an starting integer Celsius temperature: "
prompt2:
	.asciiz " \n Enter an ending integer Celsius temperature: "
sumText: 
	.asciiz " \n F = "
welcome2:
	.asciiz " \n This program converts kelvin to celsius and Fahrenheit \n\n"
TableHead:
	.asciiz " \n C        F        K"
space:
	.asciiz "        "	
newRow:
	.asciiz " \n"
.text 
conversionQuestion: 
    li  $v0, 4  	#ask if C or F or K
    la  $a0, CorForK  
    syscall
    
    la  $a0, answer
    li  $a1, 3
    li  $v0, 8
    syscall

    lb  $t4, 0($a0)
    
    beq $t4, 'C', main	#go to convert C->F,K
    beq $t4, 'F', main1	#go to convert F->C,K  
    beq $t4, 'K', main2 #go to convert K->C,F
    
    j conversionQuestion
    
    #convert C->F,K
main:
	# Display welcome
	ori $v0, $0, 4
	la $a0, welcome
	syscall

	# Display prompt
	ori     $v0, $0, 4
	la $a0, prompt1			
	syscall

	# Read 1st integer
	ori     $v0, $0, 5
	syscall
	
	addi $t2,$v0,0
	
	ori	$v0,$0,4
	la $a0, prompt2
	syscall
	
	# Read 2nd integer
	
	ori $v0,$0,5
	syscall
	
	addi $t3,$v0,0
	
	ori     $v0, $0, 4
	la 	$a0, TableHead			
	syscall

	# C is in $t2	
calc:	
	addi $t0, $0, 9
	mult $t0, $t2
	mflo $t0    # 9*C
	addi $t1, $0, 5
	div $t0, $t1
	mflo $t0    # 9*C/5
	addi $s0, $t0, 32   # 9*C/5+32

	
	ori     $v0, $0, 4
	la 	$a0, newRow		
	syscall
	
	# Display the result
	ori     $v0, $0, 1
	add     $a0,$t2,0				 
	syscall
	
	ori	$v0, $0, 4
	la 	$a0, space
	syscall
	
	ori	$v0, $0, 1
	add 	$a0,$s0,0
	syscall
	
	ori	$v0, $0, 4
	la	$a0, space
	syscall
	
	ori	$v0, $0, 1
	add	$a0, $t2, 273
	syscall
	
	addi $t2,$t2,1
	beq $t2,$t3,continue
	
	 
	#continue till the 2nd intiger is reached
	j calc
	
	
    #convert F->C,K
main1:
	# Display welcome
	ori $v0, $0, 4
	la $a0, welcome1
	syscall

	# Display prompt
	ori     $v0, $0, 4
	la $a0, prompt3			
	syscall

	# Read 1st integer
	ori     $v0, $0, 5
	syscall
	
	addi $t2, $v0,0
	
	ori     $v0, $0, 4
	la $a0, prompt4			
	syscall

	# Read 2nd integer
	ori     $v0, $0, 5
	syscall
	
	addi $t3, $v0,0
	
	ori     $v0, $0, 4
	la 	$a0, TableHead			
	syscall

calc1:
	# F is in $t2			#(F-32) * 5 / 9
	addi $t1, $0, 9		#t1 = 9
	addi $t0, $0, 5		#t0 = 5
	addi $s0, $0, 32	#s0 = 32
	
	sub $t6, $t2, $s0	#F-32
	
	mult $t0, $t6
	mflo $t0    # 5*(F-32)

	div $t0, $t1
	mflo $t0    # 5*(F-32)/9

	# Display the result
	ori     $v0, $0, 4
	la $a0, newRow			
	syscall
	
	ori     $v0, $0, 1
	add     $a0,$t0,0				 
	syscall
	
	ori	$v0, $0, 4
	la 	$a0, space
	syscall
	
	ori	$v0, $0, 1
	add 	$a0,$t2,0
	syscall
	
	ori	$v0, $0, 4
	la	$a0, space
	syscall
	
	ori	$v0, $0, 1
	add	$a0, $t0, 273
	syscall
	
	addi $t2,$t2,1
	beq $t2,$t3,continue
	
	#continue till the 2nd intiger is reached
	j calc1

#convert K->F,C
	
main2:
	ori $v0, $0, 4
	la $a0, welcome2
	syscall
	
	ori $v0, $0, 4
	la $a0, prompt5
	syscall
	
	ori $v0, $0, 5
	syscall
	
	addi $t2,$v0,0
	
	ori $v0, $0,4
	la $a0, prompt6
	syscall
	
	ori $v0, $0, 5
	syscall
	
	addi $t3, $v0, 0
	
	ori $v0,$0,4
	la $a0, TableHead
	syscall
calc2:
	sub $t6,$t2,273
	addi $t0, $0, 9
	mult $t0, $t6
	mflo $t0    # 9*C
	addi $t1, $0, 5
	div $t0, $t1
	mflo $t0    # 9*C/5
	addi $s0, $t0, 32   # 9*C/5+32
	
	ori     $v0, $0, 4
	la  $a0, newRow			
	syscall
	
	ori     $v0, $0, 1
	add     $a0,$t6,0				 
	syscall
	
	ori	$v0, $0, 4
	la 	$a0, space
	syscall
	
	ori	$v0, $0, 1
	add 	$a0,$s0,0
	syscall
	
	ori	$v0, $0, 4
	la	$a0, space
	syscall
	
	ori	$v0, $0, 1
	add	$a0, $t2, 0
	syscall
	
	addi $t2,$t2,1
	beq $t2,$t3,continue
	
	#continue till the number is reached
	j calc2
	
	
	
	
	
	
	
continue:
    li  $v0, 4  
    la  $a0, again  
    syscall  

    la  $a0, answer
    li  $a1, 3
    li  $v0, 8
    syscall

    lb  $t4, 0($a0)

    beq $t4, 'y', conversionQuestion	#ask if C or F or K if continue

    li  $v0, 10 		#else quit
    syscall 
