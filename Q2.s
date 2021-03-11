.global _start

.text

_start:
	movq $416, %r8		# x=416
	movq $1, %r9		# i=1			
	movq $1, %r10		# factorial=1
loop:
	cmp %r8, %r9		# computes (i-x)
	je label_1		# jumps to label_1 if (i-x)=0
	imul %r9, %r10		# factorial = factorial*i	
	movq %r10, %rax		# $rax = factorial
	idivq %r8		# factorial is divided by x
	cmp $0, %rdx		# Remainder is stored in %rdx and quotient is stored in %rax, so we are computing $rdx-0 
	je label_1		# checking if above computed value is zero or not. If it is zero then jumps to label_1 
	movq $0, %rdx		# Making the register which is storing the register(rdx) equals to zero, because if we compute division again, there might be chance 					  of showing wrong remainder
	inc %r9			# i++
	jmp loop		# jumps back to loop 	
label_1:
	mov %r9, %r11		# storing the result in r11 register
exit:
	mov $60, %rax		# System call 60 is exit
	xor %rdi, %rdi		# returns 0
	syscall			# Invokes Operating system to exit

