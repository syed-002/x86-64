.global _start

.text

_start:
		mov $1, %r12	# %r12=acc, acc=1
		mov $2001, %r8	# r8=a
		mov $2002, %r9	# r9=b
		mov $2003, %r10	# r10=n
		mov %r8, %rax	# rax=a
		divq %r10	# a mod n
		mov %rdx, %r8	# a=remainder(rdx)
		mov $0, %rdx	# Making the register which is storing the register(rdx) equals to zero, because if we compute division again, there might be chance 					  of showing wrong remainder
loop1:
		cmp $0, %r9 	# coparing 0 and b ie.,(b-0)
		jz label_1	# if compared value is zero, jump to labe_1
		mov %r9, %rax	# $rax = b
		mov $2, %r14	# $r14 = 2
		divq %r14	# divide with 2 to check if b is odd or not
		cmp $0, %rdx	# comparing the remiander and zero
		jnz if_condition#jump to if_condition if compared value is not zero
		jmp loop2	# jump to loop2 unconditionally
		
loop2:
		mov $0, %rdx	# making the remainder zero
		mov %r9, %rax	# $rax = b
		mov $2, %r14	# $r14 =2
		divq %r14	# computing b/2
		mov %rax, %r9	# b=quotient(rax)
		mov $0, %rdx	# making the remainder zero
		imul %r8, %r8	# a=a*a
		mov %r8, %rax	# $rax = a
		divq %r10	# a mod n
		mov %rdx, %r8	# a=remainder(rdx)
		mov $0, %rdx	# making the remainder zero
		jmp loop1

if_condition:
		mov $0, %rdx	# making the remainder zero(from b%2 in loop)
		imul %r8, %r12	# acc=acc*a
		mov %r12, %rax	# $rax = acc
		divq %r10	# acc%n
		mov %rdx, %r12	# acc=remainder(rdx)
		mov $0, %rdx	# making the remainder zero
		jmp loop2	# jump to loop2 unconditionally


label_1:
		mov %r12, %r11 	# Storing the final result in r11

exit:
		mov $60, %rax	# Sys call 60 on exit
		xor %rdi, %rdi	# return 0
		syscall		# Invokes Operating system to exit
