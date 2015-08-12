.text
.type	_x86_64_AES_encrypt,@function
.align	16
_x86_64_AES_encrypt:
	xorl	0(%r15),%eax
	xorl	4(%r15),%ebx
	xorl	8(%r15),%ecx
	xorl	12(%r15),%edx

	movl	240(%r15),%r13d
	subl	$1,%r13d
	jmp	.Lenc_loop
.align	16
.Lenc_loop:

	movzbl	%al,%esi
	movzbl	%bl,%edi
	movzbl	%cl,%ebp
	movl	0(%r14,%rsi,8),%r10d
	movl	0(%r14,%rdi,8),%r11d
	movl	0(%r14,%rbp,8),%r12d

	movzbl	%bh,%esi
	movzbl	%ch,%edi
	movzbl	%dl,%ebp
	xorl	3(%r14,%rsi,8),%r10d
	xorl	3(%r14,%rdi,8),%r11d
	movl	0(%r14,%rbp,8),%r8d

	movzbl	%dh,%esi
	shrl	$16,%ecx
	movzbl	%ah,%ebp
	xorl	3(%r14,%rsi,8),%r12d
	shrl	$16,%edx
	xorl	3(%r14,%rbp,8),%r8d

	shrl	$16,%ebx
	leaq	16(%r15),%r15
	shrl	$16,%eax

	movzbl	%cl,%esi
	movzbl	%dl,%edi
	movzbl	%al,%ebp
	xorl	2(%r14,%rsi,8),%r10d
	xorl	2(%r14,%rdi,8),%r11d
	xorl	2(%r14,%rbp,8),%r12d

	movzbl	%dh,%esi
	movzbl	%ah,%edi
	movzbl	%bl,%ebp
	xorl	1(%r14,%rsi,8),%r10d
	xorl	1(%r14,%rdi,8),%r11d
	xorl	2(%r14,%rbp,8),%r8d

	movl	12(%r15),%edx
	movzbl	%bh,%edi
	movzbl	%ch,%ebp
	movl	0(%r15),%eax
	xorl	1(%r14,%rdi,8),%r12d
	xorl	1(%r14,%rbp,8),%r8d

	movl	4(%r15),%ebx
	movl	8(%r15),%ecx
	xorl	%r10d,%eax
	xorl	%r11d,%ebx
	xorl	%r12d,%ecx
	xorl	%r8d,%edx
	subl	$1,%r13d
	jnz	.Lenc_loop
	movzbl	%al,%esi
	movzbl	%bl,%edi
	movzbl	%cl,%ebp
	movl	2(%r14,%rsi,8),%r10d
	movl	2(%r14,%rdi,8),%r11d
	movl	2(%r14,%rbp,8),%r12d

	andl	$255,%r10d
	andl	$255,%r11d
	andl	$255,%r12d

	movzbl	%dl,%esi
	movzbl	%bh,%edi
	movzbl	%ch,%ebp
	movl	2(%r14,%rsi,8),%r8d
	movl	0(%r14,%rdi,8),%edi
	movl	0(%r14,%rbp,8),%ebp

	andl	$255,%r8d
	andl	$65280,%edi
	andl	$65280,%ebp

	xorl	%edi,%r10d
	xorl	%ebp,%r11d
	shrl	$16,%ecx

	movzbl	%dh,%esi
	movzbl	%ah,%edi
	shrl	$16,%edx
	movl	0(%r14,%rsi,8),%esi
	movl	0(%r14,%rdi,8),%edi

	andl	$65280,%esi
	andl	$65280,%edi
	shrl	$16,%ebx
	xorl	%esi,%r12d
	xorl	%edi,%r8d
	shrl	$16,%eax

	movzbl	%cl,%esi
	movzbl	%dl,%edi
	movzbl	%al,%ebp
	movl	0(%r14,%rsi,8),%esi
	movl	0(%r14,%rdi,8),%edi
	movl	0(%r14,%rbp,8),%ebp

	andl	$16711680,%esi
	andl	$16711680,%edi
	andl	$16711680,%ebp

	xorl	%esi,%r10d
	xorl	%edi,%r11d
	xorl	%ebp,%r12d

	movzbl	%bl,%esi
	movzbl	%dh,%edi
	movzbl	%ah,%ebp
	movl	0(%r14,%rsi,8),%esi
	movl	2(%r14,%rdi,8),%edi
	movl	2(%r14,%rbp,8),%ebp

	andl	$16711680,%esi
	andl	$4278190080,%edi
	andl	$4278190080,%ebp

	xorl	%esi,%r8d
	xorl	%edi,%r10d
	xorl	%ebp,%r11d

	movzbl	%bh,%esi
	movzbl	%ch,%edi
	movl	16+12(%r15),%edx
	movl	2(%r14,%rsi,8),%esi
	movl	2(%r14,%rdi,8),%edi
	movl	16+0(%r15),%eax

	andl	$4278190080,%esi
	andl	$4278190080,%edi

	xorl	%esi,%r12d
	xorl	%edi,%r8d

	movl	16+4(%r15),%ebx
	movl	16+8(%r15),%ecx
	xorl	%r10d,%eax
	xorl	%r11d,%ebx
	xorl	%r12d,%ecx
	xorl	%r8d,%edx
.byte	0xf3,0xc3			
.size	_x86_64_AES_encrypt,.-_x86_64_AES_encrypt
.globl	AES_encrypt
.type	AES_encrypt,@function
.align	16
AES_encrypt:
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15

	movq	%rdx,%r15
	movq	%rdi,%r8
	movq	%rsi,%r9

	.long	0x1358d4c,0x90000000
	leaq	AES_Te-.(%r14),%r14

	movl	0(%r8),%eax
	movl	4(%r8),%ebx
	movl	8(%r8),%ecx
	movl	12(%r8),%edx

	call	_x86_64_AES_encrypt

	movl	%eax,0(%r9)
	movl	%ebx,4(%r9)
	movl	%ecx,8(%r9)
	movl	%edx,12(%r9)

	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	.byte	0xf3,0xc3
.size	AES_encrypt,.-AES_encrypt
.type	_x86_64_AES_decrypt,@function
.align	16
_x86_64_AES_decrypt:
	xorl	0(%r15),%eax
	xorl	4(%r15),%ebx
	xorl	8(%r15),%ecx
	xorl	12(%r15),%edx

	movl	240(%r15),%r13d
	subl	$1,%r13d
	jmp	.Ldec_loop
.align	16
.Ldec_loop:

	movzbl	%al,%esi
	movzbl	%bl,%edi
	movzbl	%cl,%ebp
	movl	0(%r14,%rsi,8),%r10d
	movl	0(%r14,%rdi,8),%r11d
	movl	0(%r14,%rbp,8),%r12d

	movzbl	%dh,%esi
	movzbl	%ah,%edi
	movzbl	%dl,%ebp
	xorl	3(%r14,%rsi,8),%r10d
	xorl	3(%r14,%rdi,8),%r11d
	movl	0(%r14,%rbp,8),%r8d

	movzbl	%bh,%esi
	shrl	$16,%eax
	movzbl	%ch,%ebp
	xorl	3(%r14,%rsi,8),%r12d
	shrl	$16,%edx
	xorl	3(%r14,%rbp,8),%r8d

	shrl	$16,%ebx
	leaq	16(%r15),%r15
	shrl	$16,%ecx

	movzbl	%cl,%esi
	movzbl	%dl,%edi
	movzbl	%al,%ebp
	xorl	2(%r14,%rsi,8),%r10d
	xorl	2(%r14,%rdi,8),%r11d
	xorl	2(%r14,%rbp,8),%r12d

	movzbl	%bh,%esi
	movzbl	%ch,%edi
	movzbl	%bl,%ebp
	xorl	1(%r14,%rsi,8),%r10d
	xorl	1(%r14,%rdi,8),%r11d
	xorl	2(%r14,%rbp,8),%r8d

	movzbl	%dh,%esi
	movl	12(%r15),%edx
	movzbl	%ah,%ebp
	xorl	1(%r14,%rsi,8),%r12d
	movl	0(%r15),%eax
	xorl	1(%r14,%rbp,8),%r8d

	xorl	%r10d,%eax
	movl	4(%r15),%ebx
	movl	8(%r15),%ecx
	xorl	%r12d,%ecx
	xorl	%r11d,%ebx
	xorl	%r8d,%edx
	subl	$1,%r13d
	jnz	.Ldec_loop
	movzbl	%al,%esi
	movzbl	%bl,%edi
	movzbl	%cl,%ebp
	movzbl	2048(%r14,%rsi,1),%r10d
	movzbl	2048(%r14,%rdi,1),%r11d
	movzbl	2048(%r14,%rbp,1),%r12d

	movzbl	%dl,%esi
	movzbl	%dh,%edi
	movzbl	%ah,%ebp
	movzbl	2048(%r14,%rsi,1),%r8d
	movzbl	2048(%r14,%rdi,1),%edi
	movzbl	2048(%r14,%rbp,1),%ebp

	shll	$8,%edi
	shll	$8,%ebp

	xorl	%edi,%r10d
	xorl	%ebp,%r11d
	shrl	$16,%edx

	movzbl	%bh,%esi
	movzbl	%ch,%edi
	shrl	$16,%eax
	movzbl	2048(%r14,%rsi,1),%esi
	movzbl	2048(%r14,%rdi,1),%edi

	shll	$8,%esi
	shll	$8,%edi
	shrl	$16,%ebx
	xorl	%esi,%r12d
	xorl	%edi,%r8d
	shrl	$16,%ecx

	movzbl	%cl,%esi
	movzbl	%dl,%edi
	movzbl	%al,%ebp
	movzbl	2048(%r14,%rsi,1),%esi
	movzbl	2048(%r14,%rdi,1),%edi
	movzbl	2048(%r14,%rbp,1),%ebp

	shll	$16,%esi
	shll	$16,%edi
	shll	$16,%ebp

	xorl	%esi,%r10d
	xorl	%edi,%r11d
	xorl	%ebp,%r12d

	movzbl	%bl,%esi
	movzbl	%bh,%edi
	movzbl	%ch,%ebp
	movzbl	2048(%r14,%rsi,1),%esi
	movzbl	2048(%r14,%rdi,1),%edi
	movzbl	2048(%r14,%rbp,1),%ebp

	shll	$16,%esi
	shll	$24,%edi
	shll	$24,%ebp

	xorl	%esi,%r8d
	xorl	%edi,%r10d
	xorl	%ebp,%r11d

	movzbl	%dh,%esi
	movzbl	%ah,%edi
	movl	16+12(%r15),%edx
	movzbl	2048(%r14,%rsi,1),%esi
	movzbl	2048(%r14,%rdi,1),%edi
	movl	16+0(%r15),%eax

	shll	$24,%esi
	shll	$24,%edi

	xorl	%esi,%r12d
	xorl	%edi,%r8d

	movl	16+4(%r15),%ebx
	movl	16+8(%r15),%ecx
	xorl	%r10d,%eax
	xorl	%r11d,%ebx
	xorl	%r12d,%ecx
	xorl	%r8d,%edx
.byte	0xf3,0xc3			
.size	_x86_64_AES_decrypt,.-_x86_64_AES_decrypt
.globl	AES_decrypt
.type	AES_decrypt,@function
.align	16
AES_decrypt:
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15

	movq	%rdx,%r15
	movq	%rdi,%r8
	movq	%rsi,%r9

	.long	0x1358d4c,0x90000000
	leaq	AES_Td-.(%r14),%r14


	leaq	2048+128(%r14),%r14;
	movl	0-128(%r14),%eax
	movl	32-128(%r14),%ebx
	movl	64-128(%r14),%ecx
	movl	96-128(%r14),%edx
	movl	128-128(%r14),%eax
	movl	160-128(%r14),%ebx
	movl	192-128(%r14),%ecx
	movl	224-128(%r14),%edx
	leaq	-2048-128(%r14),%r14;

	movl	0(%r8),%eax
	movl	4(%r8),%ebx
	movl	8(%r8),%ecx
	movl	12(%r8),%edx

	call	_x86_64_AES_decrypt

	movl	%eax,0(%r9)
	movl	%ebx,4(%r9)
	movl	%ecx,8(%r9)
	movl	%edx,12(%r9)

	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	.byte	0xf3,0xc3
.size	AES_decrypt,.-AES_decrypt
.globl	AES_set_encrypt_key
.type	AES_set_encrypt_key,@function
.align	16
AES_set_encrypt_key:
	pushq	%rbx
	pushq	%rbp
	subq	$8,%rsp

	call	_x86_64_AES_set_encrypt_key

	movq	8(%rsp),%rbp
	movq	16(%rsp),%rbx
	addq	$24,%rsp
	.byte	0xf3,0xc3
.size	AES_set_encrypt_key,.-AES_set_encrypt_key

.type	_x86_64_AES_set_encrypt_key,@function
.align	16
_x86_64_AES_set_encrypt_key:
	movl	%esi,%ecx
	movq	%rdi,%rsi
	movq	%rdx,%rdi

	testq	$-1,%rsi
	jz	.Lbadpointer
	testq	$-1,%rdi
	jz	.Lbadpointer

	.long	0x12d8d48,0x90000000
	leaq	AES_Te-.(%rbp),%rbp

	cmpl	$128,%ecx
	je	.L10rounds
	cmpl	$192,%ecx
	je	.L12rounds
	cmpl	$256,%ecx
	je	.L14rounds
	movq	$-2,%rax
	jmp	.Lexit

.L10rounds:
	movl	0(%rsi),%eax
	movl	4(%rsi),%ebx
	movl	8(%rsi),%ecx
	movl	12(%rsi),%edx
	movl	%eax,0(%rdi)
	movl	%ebx,4(%rdi)
	movl	%ecx,8(%rdi)
	movl	%edx,12(%rdi)

	xorl	%ecx,%ecx
	jmp	.L10shortcut
.align	4
.L10loop:
	movl	0(%rdi),%eax
	movl	12(%rdi),%edx
.L10shortcut:
	movzbl	%dl,%esi
	movl	2(%rbp,%rsi,8),%ebx
	movzbl	%dh,%esi
	andl	$4278190080,%ebx
	xorl	%ebx,%eax

	movl	2(%rbp,%rsi,8),%ebx
	shrl	$16,%edx
	andl	$255,%ebx
	movzbl	%dl,%esi
	xorl	%ebx,%eax

	movl	0(%rbp,%rsi,8),%ebx
	movzbl	%dh,%esi
	andl	$65280,%ebx
	xorl	%ebx,%eax

	movl	0(%rbp,%rsi,8),%ebx
	andl	$16711680,%ebx
	xorl	%ebx,%eax

	xorl	2048(%rbp,%rcx,4),%eax
	movl	%eax,16(%rdi)
	xorl	4(%rdi),%eax
	movl	%eax,20(%rdi)
	xorl	8(%rdi),%eax
	movl	%eax,24(%rdi)
	xorl	12(%rdi),%eax
	movl	%eax,28(%rdi)
	addl	$1,%ecx
	leaq	16(%rdi),%rdi
	cmpl	$10,%ecx
	jl	.L10loop

	movl	$10,80(%rdi)
	xorq	%rax,%rax
	jmp	.Lexit

.L12rounds:
	movl	0(%rsi),%eax
	movl	4(%rsi),%ebx
	movl	8(%rsi),%ecx
	movl	12(%rsi),%edx
	movl	%eax,0(%rdi)
	movl	%ebx,4(%rdi)
	movl	%ecx,8(%rdi)
	movl	%edx,12(%rdi)
	movl	16(%rsi),%ecx
	movl	20(%rsi),%edx
	movl	%ecx,16(%rdi)
	movl	%edx,20(%rdi)

	xorl	%ecx,%ecx
	jmp	.L12shortcut
.align	4
.L12loop:
	movl	0(%rdi),%eax
	movl	20(%rdi),%edx
.L12shortcut:
	movzbl	%dl,%esi
	movl	2(%rbp,%rsi,8),%ebx
	movzbl	%dh,%esi
	andl	$4278190080,%ebx
	xorl	%ebx,%eax

	movl	2(%rbp,%rsi,8),%ebx
	shrl	$16,%edx
	andl	$255,%ebx
	movzbl	%dl,%esi
	xorl	%ebx,%eax

	movl	0(%rbp,%rsi,8),%ebx
	movzbl	%dh,%esi
	andl	$65280,%ebx
	xorl	%ebx,%eax

	movl	0(%rbp,%rsi,8),%ebx
	andl	$16711680,%ebx
	xorl	%ebx,%eax

	xorl	2048(%rbp,%rcx,4),%eax
	movl	%eax,24(%rdi)
	xorl	4(%rdi),%eax
	movl	%eax,28(%rdi)
	xorl	8(%rdi),%eax
	movl	%eax,32(%rdi)
	xorl	12(%rdi),%eax
	movl	%eax,36(%rdi)

	cmpl	$7,%ecx
	je	.L12break
	addl	$1,%ecx

	xorl	16(%rdi),%eax
	movl	%eax,40(%rdi)
	xorl	20(%rdi),%eax
	movl	%eax,44(%rdi)

	leaq	24(%rdi),%rdi
	jmp	.L12loop
.L12break:
	movl	$12,72(%rdi)
	xorq	%rax,%rax
	jmp	.Lexit

.L14rounds:
	movl	0(%rsi),%eax
	movl	4(%rsi),%ebx
	movl	8(%rsi),%ecx
	movl	12(%rsi),%edx
	movl	%eax,0(%rdi)
	movl	%ebx,4(%rdi)
	movl	%ecx,8(%rdi)
	movl	%edx,12(%rdi)
	movl	16(%rsi),%eax
	movl	20(%rsi),%ebx
	movl	24(%rsi),%ecx
	movl	28(%rsi),%edx
	movl	%eax,16(%rdi)
	movl	%ebx,20(%rdi)
	movl	%ecx,24(%rdi)
	movl	%edx,28(%rdi)

	xorl	%ecx,%ecx
	jmp	.L14shortcut
.align	4
.L14loop:
	movl	28(%rdi),%edx
.L14shortcut:
	movl	0(%rdi),%eax
	movzbl	%dl,%esi
	movl	2(%rbp,%rsi,8),%ebx
	movzbl	%dh,%esi
	andl	$4278190080,%ebx
	xorl	%ebx,%eax

	movl	2(%rbp,%rsi,8),%ebx
	shrl	$16,%edx
	andl	$255,%ebx
	movzbl	%dl,%esi
	xorl	%ebx,%eax

	movl	0(%rbp,%rsi,8),%ebx
	movzbl	%dh,%esi
	andl	$65280,%ebx
	xorl	%ebx,%eax

	movl	0(%rbp,%rsi,8),%ebx
	andl	$16711680,%ebx
	xorl	%ebx,%eax

	xorl	2048(%rbp,%rcx,4),%eax
	movl	%eax,32(%rdi)
	xorl	4(%rdi),%eax
	movl	%eax,36(%rdi)
	xorl	8(%rdi),%eax
	movl	%eax,40(%rdi)
	xorl	12(%rdi),%eax
	movl	%eax,44(%rdi)

	cmpl	$6,%ecx
	je	.L14break
	addl	$1,%ecx

	movl	%eax,%edx
	movl	16(%rdi),%eax
	movzbl	%dl,%esi
	movl	2(%rbp,%rsi,8),%ebx
	movzbl	%dh,%esi
	andl	$255,%ebx
	xorl	%ebx,%eax

	movl	0(%rbp,%rsi,8),%ebx
	shrl	$16,%edx
	andl	$65280,%ebx
	movzbl	%dl,%esi
	xorl	%ebx,%eax

	movl	0(%rbp,%rsi,8),%ebx
	movzbl	%dh,%esi
	andl	$16711680,%ebx
	xorl	%ebx,%eax

	movl	2(%rbp,%rsi,8),%ebx
	andl	$4278190080,%ebx
	xorl	%ebx,%eax

	movl	%eax,48(%rdi)
	xorl	20(%rdi),%eax
	movl	%eax,52(%rdi)
	xorl	24(%rdi),%eax
	movl	%eax,56(%rdi)
	xorl	28(%rdi),%eax
	movl	%eax,60(%rdi)

	leaq	32(%rdi),%rdi
	jmp	.L14loop
.L14break:
	movl	$14,48(%rdi)
	xorq	%rax,%rax
	jmp	.Lexit

.Lbadpointer:
	movq	$-1,%rax
.Lexit:
.byte	0xf3,0xc3		
.size	_x86_64_AES_set_encrypt_key,.-_x86_64_AES_set_encrypt_key
.globl	AES_set_decrypt_key
.type	AES_set_decrypt_key,@function
.align	16
AES_set_decrypt_key:
	pushq	%rbx
	pushq	%rbp
	pushq	%rdx

	call	_x86_64_AES_set_encrypt_key
	movq	(%rsp),%r8
	cmpl	$0,%eax
	jne	.Labort

	movl	240(%r8),%ecx
	xorq	%rdi,%rdi
	leaq	(%rdi,%rcx,4),%rcx
	movq	%r8,%rsi
	leaq	(%r8,%rcx,4),%rdi
.align	4
.Linvert:
	movq	0(%rsi),%rax
	movq	8(%rsi),%rbx
	movq	0(%rdi),%rcx
	movq	8(%rdi),%rdx
	movq	%rax,0(%rdi)
	movq	%rbx,8(%rdi)
	movq	%rcx,0(%rsi)
	movq	%rdx,8(%rsi)
	leaq	16(%rsi),%rsi
	leaq	-16(%rdi),%rdi
	cmpq	%rsi,%rdi
	jne	.Linvert

	.long	0x10d8d4c,0x90000000
	leaq	AES_Td-.(%r9),%rdi
	leaq	AES_Te-AES_Td(%rdi),%r9

	movq	%r8,%rsi
	movl	240(%r8),%ecx
	subl	$1,%ecx
.align	4
.Lpermute:
	leaq	16(%rsi),%rsi
	movl	0(%rsi),%eax
	movl	%eax,%edx
	movzbl	%ah,%ebx
	shrl	$16,%edx
	andl	$255,%eax
	movzbq	2(%r9,%rax,8),%rax
	movzbq	2(%r9,%rbx,8),%rbx
	movl	0(%rdi,%rax,8),%eax
	xorl	3(%rdi,%rbx,8),%eax
	movzbl	%dh,%ebx
	andl	$255,%edx
	movzbq	2(%r9,%rdx,8),%rdx
	movzbq	2(%r9,%rbx,8),%rbx
	xorl	2(%rdi,%rdx,8),%eax
	xorl	1(%rdi,%rbx,8),%eax
	movl	%eax,0(%rsi)
	movl	4(%rsi),%eax
	movl	%eax,%edx
	movzbl	%ah,%ebx
	shrl	$16,%edx
	andl	$255,%eax
	movzbq	2(%r9,%rax,8),%rax
	movzbq	2(%r9,%rbx,8),%rbx
	movl	0(%rdi,%rax,8),%eax
	xorl	3(%rdi,%rbx,8),%eax
	movzbl	%dh,%ebx
	andl	$255,%edx
	movzbq	2(%r9,%rdx,8),%rdx
	movzbq	2(%r9,%rbx,8),%rbx
	xorl	2(%rdi,%rdx,8),%eax
	xorl	1(%rdi,%rbx,8),%eax
	movl	%eax,4(%rsi)
	movl	8(%rsi),%eax
	movl	%eax,%edx
	movzbl	%ah,%ebx
	shrl	$16,%edx
	andl	$255,%eax
	movzbq	2(%r9,%rax,8),%rax
	movzbq	2(%r9,%rbx,8),%rbx
	movl	0(%rdi,%rax,8),%eax
	xorl	3(%rdi,%rbx,8),%eax
	movzbl	%dh,%ebx
	andl	$255,%edx
	movzbq	2(%r9,%rdx,8),%rdx
	movzbq	2(%r9,%rbx,8),%rbx
	xorl	2(%rdi,%rdx,8),%eax
	xorl	1(%rdi,%rbx,8),%eax
	movl	%eax,8(%rsi)
	movl	12(%rsi),%eax
	movl	%eax,%edx
	movzbl	%ah,%ebx
	shrl	$16,%edx
	andl	$255,%eax
	movzbq	2(%r9,%rax,8),%rax
	movzbq	2(%r9,%rbx,8),%rbx
	movl	0(%rdi,%rax,8),%eax
	xorl	3(%rdi,%rbx,8),%eax
	movzbl	%dh,%ebx
	andl	$255,%edx
	movzbq	2(%r9,%rdx,8),%rdx
	movzbq	2(%r9,%rbx,8),%rbx
	xorl	2(%rdi,%rdx,8),%eax
	xorl	1(%rdi,%rbx,8),%eax
	movl	%eax,12(%rsi)
	subl	$1,%ecx
	jnz	.Lpermute

	xorq	%rax,%rax
.Labort:
	movq	8(%rsp),%rbp
	movq	16(%rsp),%rbx
	addq	$24,%rsp
	.byte	0xf3,0xc3
.size	AES_set_decrypt_key,.-AES_set_decrypt_key
.globl	AES_cbc_encrypt
.type	AES_cbc_encrypt,@function
.align	16
AES_cbc_encrypt:
	cmpq	$0,%rdx
	je	.Lcbc_just_ret
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	pushfq
	cld
	movl	%r9d,%r9d

	.long	0x1358d4c,0x90000000
.Lcbc_pic_point:

	cmpq	$0,%r9
	je	.LDECRYPT

	leaq	AES_Te-.Lcbc_pic_point(%r14),%r14


	leaq	-64-248(%rsp),%r15
	andq	$-64,%r15


	movq	%r14,%r10
	leaq	2048(%r14),%r11
	movq	%r15,%r12
	andq	$4095,%r10
	andq	$4095,%r11
	andq	$4095,%r12

	cmpq	%r11,%r12
	jb	.Lcbc_te_break_out
	subq	%r11,%r12
	subq	%r12,%r15
	jmp	.Lcbc_te_ok
.Lcbc_te_break_out:
	subq	%r10,%r12
	andq	$4095,%r12
	addq	$320,%r12
	subq	%r12,%r15
.align	4
.Lcbc_te_ok:

	xchgq	%rsp,%r15
	addq	$8,%rsp
	movq	%r15,0(%rsp)
	movq	%rdx,8(%rsp)
	movq	%rcx,16(%rsp)
	movq	%r8,24(%rsp)
	movl	$0,56+240(%rsp)
	movq	%r8,%rbp
	movq	%rsi,%r9
	movq	%rdi,%r8
	movq	%rcx,%r15


	movq	%r15,%r10
	subq	%r14,%r10
	andq	$4095,%r10
	cmpq	$2048,%r10
	jb	.Lcbc_do_ecopy
	cmpq	$4096-248,%r10
	jb	.Lcbc_skip_ecopy
.align	4
.Lcbc_do_ecopy:
	movq	%r15,%rsi
	leaq	56(%rsp),%rdi
	leaq	56(%rsp),%r15
	movl	$30,%ecx
.long	0x90A548F3	
	movl	(%rsi),%eax
	movl	%eax,(%rdi)
.Lcbc_skip_ecopy:
	movq	%r15,32(%rsp)

	movl	$16,%ecx
.align	4
.Lcbc_prefetch_te:
	movq	0(%r14),%r10
	movq	32(%r14),%r11
	movq	64(%r14),%r12
	movq	96(%r14),%r13
	leaq	128(%r14),%r14
	subl	$1,%ecx
	jnz	.Lcbc_prefetch_te
	subq	$2048,%r14

	testq	$-16,%rdx
	movq	%rdx,%r10
	movl	0(%rbp),%eax
	movl	4(%rbp),%ebx
	movl	8(%rbp),%ecx
	movl	12(%rbp),%edx
	jz	.Lcbc_enc_tail		

.align	4
.Lcbc_enc_loop:
	xorl	0(%r8),%eax
	xorl	4(%r8),%ebx
	xorl	8(%r8),%ecx
	xorl	12(%r8),%edx
	movq	%r8,40(%rsp)

	movq	32(%rsp),%r15
	call	_x86_64_AES_encrypt

	movq	40(%rsp),%r8
	movl	%eax,0(%r9)
	movl	%ebx,4(%r9)
	movl	%ecx,8(%r9)
	movl	%edx,12(%r9)

	movq	8(%rsp),%r10
	leaq	16(%r8),%r8
	leaq	16(%r9),%r9
	subq	$16,%r10
	testq	$-16,%r10
	movq	%r10,8(%rsp)
	jnz	.Lcbc_enc_loop
	testq	$15,%r10
	jnz	.Lcbc_enc_tail
	movq	24(%rsp),%rbp
	movl	%eax,0(%rbp)
	movl	%ebx,4(%rbp)
	movl	%ecx,8(%rbp)
	movl	%edx,12(%rbp)

.align	4
.Lcbc_cleanup:
	cmpl	$0,56+240(%rsp)
	leaq	56(%rsp),%rdi
	je	.Lcbc_exit
	movl	$30,%ecx
	xorq	%rax,%rax
.long	0x90AB48F3	
.Lcbc_exit:
	movq	0(%rsp),%rsp
	popfq
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
.Lcbc_just_ret:
	.byte	0xf3,0xc3
.align	4
.Lcbc_enc_tail:
	movq	%rax,%r11
	movq	%rcx,%r12
	movq	%r10,%rcx
	movq	%r8,%rsi
	movq	%r9,%rdi
.long	0xF689A4F3		
	movq	$16,%rcx
	subq	%r10,%rcx
	xorq	%rax,%rax
.long	0xF689AAF3		
	movq	%r9,%r8
	movq	$16,8(%rsp)
	movq	%r11,%rax
	movq	%r12,%rcx
	jmp	.Lcbc_enc_loop		

.align	16
.LDECRYPT:
	leaq	AES_Td-.Lcbc_pic_point(%r14),%r14


	leaq	-64-248(%rsp),%r15
	andq	$-64,%r15


	movq	%r14,%r10
	leaq	2304(%r14),%r11
	movq	%r15,%r12
	andq	$4095,%r10
	andq	$4095,%r11
	andq	$4095,%r12

	cmpq	%r11,%r12
	jb	.Lcbc_td_break_out
	subq	%r11,%r12
	subq	%r12,%r15
	jmp	.Lcbc_td_ok
.Lcbc_td_break_out:
	subq	%r10,%r12
	andq	$4095,%r12
	addq	$320,%r12
	subq	%r12,%r15
.align	4
.Lcbc_td_ok:

	xchgq	%rsp,%r15
	addq	$8,%rsp
	movq	%r15,0(%rsp)
	movq	%rdx,8(%rsp)
	movq	%rcx,16(%rsp)
	movq	%r8,24(%rsp)
	movl	$0,56+240(%rsp)
	movq	%r8,%rbp
	movq	%rsi,%r9
	movq	%rdi,%r8
	movq	%rcx,%r15


	movq	%r15,%r10
	subq	%r14,%r10
	andq	$4095,%r10
	cmpq	$2304,%r10
	jb	.Lcbc_do_dcopy
	cmpq	$4096-248,%r10
	jb	.Lcbc_skip_dcopy
.align	4
.Lcbc_do_dcopy:
	movq	%r15,%rsi
	leaq	56(%rsp),%rdi
	leaq	56(%rsp),%r15
	movl	$30,%ecx
.long	0x90A548F3	
	movl	(%rsi),%eax
	movl	%eax,(%rdi)
.Lcbc_skip_dcopy:
	movq	%r15,32(%rsp)

	movl	$18,%ecx
.align	4
.Lcbc_prefetch_td:
	movq	0(%r14),%r10
	movq	32(%r14),%r11
	movq	64(%r14),%r12
	movq	96(%r14),%r13
	leaq	128(%r14),%r14
	subl	$1,%ecx
	jnz	.Lcbc_prefetch_td
	subq	$2304,%r14

	cmpq	%r8,%r9
	je	.Lcbc_dec_in_place

	movq	%rbp,40(%rsp)
.align	4
.Lcbc_dec_loop:
	movl	0(%r8),%eax
	movl	4(%r8),%ebx
	movl	8(%r8),%ecx
	movl	12(%r8),%edx
	movq	%r8,8+40(%rsp)

	movq	32(%rsp),%r15
	call	_x86_64_AES_decrypt

	movq	40(%rsp),%rbp
	movq	8+40(%rsp),%r8
	xorl	0(%rbp),%eax
	xorl	4(%rbp),%ebx
	xorl	8(%rbp),%ecx
	xorl	12(%rbp),%edx
	movq	%r8,%rbp

	movq	8(%rsp),%r10
	subq	$16,%r10
	jc	.Lcbc_dec_partial
	movq	%r10,8(%rsp)
	movq	%rbp,40(%rsp)

	movl	%eax,0(%r9)
	movl	%ebx,4(%r9)
	movl	%ecx,8(%r9)
	movl	%edx,12(%r9)

	leaq	16(%r8),%r8
	leaq	16(%r9),%r9
	jnz	.Lcbc_dec_loop
.Lcbc_dec_end:
	movq	24(%rsp),%r12
	movq	0(%rbp),%r10
	movq	8(%rbp),%r11
	movq	%r10,0(%r12)
	movq	%r11,8(%r12)
	jmp	.Lcbc_cleanup

.align	4
.Lcbc_dec_partial:
	movl	%eax,0+40(%rsp)
	movl	%ebx,4+40(%rsp)
	movl	%ecx,8+40(%rsp)
	movl	%edx,12+40(%rsp)
	movq	%r9,%rdi
	leaq	40(%rsp),%rsi
	movq	$16,%rcx
	addq	%r10,%rcx
.long	0xF689A4F3		
	jmp	.Lcbc_dec_end

.align	16
.Lcbc_dec_in_place:
	movl	0(%r8),%eax
	movl	4(%r8),%ebx
	movl	8(%r8),%ecx
	movl	12(%r8),%edx

	movq	%r8,40(%rsp)
	movq	32(%rsp),%r15
	call	_x86_64_AES_decrypt

	movq	40(%rsp),%r8
	movq	24(%rsp),%rbp
	xorl	0(%rbp),%eax
	xorl	4(%rbp),%ebx
	xorl	8(%rbp),%ecx
	xorl	12(%rbp),%edx

	movq	0(%r8),%r10
	movq	8(%r8),%r11
	movq	%r10,0(%rbp)
	movq	%r11,8(%rbp)

	movl	%eax,0(%r9)
	movl	%ebx,4(%r9)
	movl	%ecx,8(%r9)
	movl	%edx,12(%r9)

	movq	8(%rsp),%rcx
	leaq	16(%r8),%r8
	leaq	16(%r9),%r9
	subq	$16,%rcx
	jc	.Lcbc_dec_in_place_partial
	movq	%rcx,8(%rsp)
	jnz	.Lcbc_dec_in_place
	jmp	.Lcbc_cleanup

.align	4
.Lcbc_dec_in_place_partial:

	leaq	(%r9,%rcx,1),%rdi
	leaq	(%rbp,%rcx,1),%rsi
	negq	%rcx
.long	0xF689A4F3	
	jmp	.Lcbc_cleanup
.size	AES_cbc_encrypt,.-AES_cbc_encrypt
.globl	AES_Te
.align	64
AES_Te:
.long	0xa56363c6,0xa56363c6
.long	0x847c7cf8,0x847c7cf8
.long	0x997777ee,0x997777ee
.long	0x8d7b7bf6,0x8d7b7bf6
.long	0x0df2f2ff,0x0df2f2ff
.long	0xbd6b6bd6,0xbd6b6bd6
.long	0xb16f6fde,0xb16f6fde
.long	0x54c5c591,0x54c5c591
.long	0x50303060,0x50303060
.long	0x03010102,0x03010102
.long	0xa96767ce,0xa96767ce
.long	0x7d2b2b56,0x7d2b2b56
.long	0x19fefee7,0x19fefee7
.long	0x62d7d7b5,0x62d7d7b5
.long	0xe6abab4d,0xe6abab4d
.long	0x9a7676ec,0x9a7676ec
.long	0x45caca8f,0x45caca8f
.long	0x9d82821f,0x9d82821f
.long	0x40c9c989,0x40c9c989
.long	0x877d7dfa,0x877d7dfa
.long	0x15fafaef,0x15fafaef
.long	0xeb5959b2,0xeb5959b2
.long	0xc947478e,0xc947478e
.long	0x0bf0f0fb,0x0bf0f0fb
.long	0xecadad41,0xecadad41
.long	0x67d4d4b3,0x67d4d4b3
.long	0xfda2a25f,0xfda2a25f
.long	0xeaafaf45,0xeaafaf45
.long	0xbf9c9c23,0xbf9c9c23
.long	0xf7a4a453,0xf7a4a453
.long	0x967272e4,0x967272e4
.long	0x5bc0c09b,0x5bc0c09b
.long	0xc2b7b775,0xc2b7b775
.long	0x1cfdfde1,0x1cfdfde1
.long	0xae93933d,0xae93933d
.long	0x6a26264c,0x6a26264c
.long	0x5a36366c,0x5a36366c
.long	0x413f3f7e,0x413f3f7e
.long	0x02f7f7f5,0x02f7f7f5
.long	0x4fcccc83,0x4fcccc83
.long	0x5c343468,0x5c343468
.long	0xf4a5a551,0xf4a5a551
.long	0x34e5e5d1,0x34e5e5d1
.long	0x08f1f1f9,0x08f1f1f9
.long	0x937171e2,0x937171e2
.long	0x73d8d8ab,0x73d8d8ab
.long	0x53313162,0x53313162
.long	0x3f15152a,0x3f15152a
.long	0x0c040408,0x0c040408
.long	0x52c7c795,0x52c7c795
.long	0x65232346,0x65232346
.long	0x5ec3c39d,0x5ec3c39d
.long	0x28181830,0x28181830
.long	0xa1969637,0xa1969637
.long	0x0f05050a,0x0f05050a
.long	0xb59a9a2f,0xb59a9a2f
.long	0x0907070e,0x0907070e
.long	0x36121224,0x36121224
.long	0x9b80801b,0x9b80801b
.long	0x3de2e2df,0x3de2e2df
.long	0x26ebebcd,0x26ebebcd
.long	0x6927274e,0x6927274e
.long	0xcdb2b27f,0xcdb2b27f
.long	0x9f7575ea,0x9f7575ea
.long	0x1b090912,0x1b090912
.long	0x9e83831d,0x9e83831d
.long	0x742c2c58,0x742c2c58
.long	0x2e1a1a34,0x2e1a1a34
.long	0x2d1b1b36,0x2d1b1b36
.long	0xb26e6edc,0xb26e6edc
.long	0xee5a5ab4,0xee5a5ab4
.long	0xfba0a05b,0xfba0a05b
.long	0xf65252a4,0xf65252a4
.long	0x4d3b3b76,0x4d3b3b76
.long	0x61d6d6b7,0x61d6d6b7
.long	0xceb3b37d,0xceb3b37d
.long	0x7b292952,0x7b292952
.long	0x3ee3e3dd,0x3ee3e3dd
.long	0x712f2f5e,0x712f2f5e
.long	0x97848413,0x97848413
.long	0xf55353a6,0xf55353a6
.long	0x68d1d1b9,0x68d1d1b9
.long	0x00000000,0x00000000
.long	0x2cededc1,0x2cededc1
.long	0x60202040,0x60202040
.long	0x1ffcfce3,0x1ffcfce3
.long	0xc8b1b179,0xc8b1b179
.long	0xed5b5bb6,0xed5b5bb6
.long	0xbe6a6ad4,0xbe6a6ad4
.long	0x46cbcb8d,0x46cbcb8d
.long	0xd9bebe67,0xd9bebe67
.long	0x4b393972,0x4b393972
.long	0xde4a4a94,0xde4a4a94
.long	0xd44c4c98,0xd44c4c98
.long	0xe85858b0,0xe85858b0
.long	0x4acfcf85,0x4acfcf85
.long	0x6bd0d0bb,0x6bd0d0bb
.long	0x2aefefc5,0x2aefefc5
.long	0xe5aaaa4f,0xe5aaaa4f
.long	0x16fbfbed,0x16fbfbed
.long	0xc5434386,0xc5434386
.long	0xd74d4d9a,0xd74d4d9a
.long	0x55333366,0x55333366
.long	0x94858511,0x94858511
.long	0xcf45458a,0xcf45458a
.long	0x10f9f9e9,0x10f9f9e9
.long	0x06020204,0x06020204
.long	0x817f7ffe,0x817f7ffe
.long	0xf05050a0,0xf05050a0
.long	0x443c3c78,0x443c3c78
.long	0xba9f9f25,0xba9f9f25
.long	0xe3a8a84b,0xe3a8a84b
.long	0xf35151a2,0xf35151a2
.long	0xfea3a35d,0xfea3a35d
.long	0xc0404080,0xc0404080
.long	0x8a8f8f05,0x8a8f8f05
.long	0xad92923f,0xad92923f
.long	0xbc9d9d21,0xbc9d9d21
.long	0x48383870,0x48383870
.long	0x04f5f5f1,0x04f5f5f1
.long	0xdfbcbc63,0xdfbcbc63
.long	0xc1b6b677,0xc1b6b677
.long	0x75dadaaf,0x75dadaaf
.long	0x63212142,0x63212142
.long	0x30101020,0x30101020
.long	0x1affffe5,0x1affffe5
.long	0x0ef3f3fd,0x0ef3f3fd
.long	0x6dd2d2bf,0x6dd2d2bf
.long	0x4ccdcd81,0x4ccdcd81
.long	0x140c0c18,0x140c0c18
.long	0x35131326,0x35131326
.long	0x2fececc3,0x2fececc3
.long	0xe15f5fbe,0xe15f5fbe
.long	0xa2979735,0xa2979735
.long	0xcc444488,0xcc444488
.long	0x3917172e,0x3917172e
.long	0x57c4c493,0x57c4c493
.long	0xf2a7a755,0xf2a7a755
.long	0x827e7efc,0x827e7efc
.long	0x473d3d7a,0x473d3d7a
.long	0xac6464c8,0xac6464c8
.long	0xe75d5dba,0xe75d5dba
.long	0x2b191932,0x2b191932
.long	0x957373e6,0x957373e6
.long	0xa06060c0,0xa06060c0
.long	0x98818119,0x98818119
.long	0xd14f4f9e,0xd14f4f9e
.long	0x7fdcdca3,0x7fdcdca3
.long	0x66222244,0x66222244
.long	0x7e2a2a54,0x7e2a2a54
.long	0xab90903b,0xab90903b
.long	0x8388880b,0x8388880b
.long	0xca46468c,0xca46468c
.long	0x29eeeec7,0x29eeeec7
.long	0xd3b8b86b,0xd3b8b86b
.long	0x3c141428,0x3c141428
.long	0x79dedea7,0x79dedea7
.long	0xe25e5ebc,0xe25e5ebc
.long	0x1d0b0b16,0x1d0b0b16
.long	0x76dbdbad,0x76dbdbad
.long	0x3be0e0db,0x3be0e0db
.long	0x56323264,0x56323264
.long	0x4e3a3a74,0x4e3a3a74
.long	0x1e0a0a14,0x1e0a0a14
.long	0xdb494992,0xdb494992
.long	0x0a06060c,0x0a06060c
.long	0x6c242448,0x6c242448
.long	0xe45c5cb8,0xe45c5cb8
.long	0x5dc2c29f,0x5dc2c29f
.long	0x6ed3d3bd,0x6ed3d3bd
.long	0xefacac43,0xefacac43
.long	0xa66262c4,0xa66262c4
.long	0xa8919139,0xa8919139
.long	0xa4959531,0xa4959531
.long	0x37e4e4d3,0x37e4e4d3
.long	0x8b7979f2,0x8b7979f2
.long	0x32e7e7d5,0x32e7e7d5
.long	0x43c8c88b,0x43c8c88b
.long	0x5937376e,0x5937376e
.long	0xb76d6dda,0xb76d6dda
.long	0x8c8d8d01,0x8c8d8d01
.long	0x64d5d5b1,0x64d5d5b1
.long	0xd24e4e9c,0xd24e4e9c
.long	0xe0a9a949,0xe0a9a949
.long	0xb46c6cd8,0xb46c6cd8
.long	0xfa5656ac,0xfa5656ac
.long	0x07f4f4f3,0x07f4f4f3
.long	0x25eaeacf,0x25eaeacf
.long	0xaf6565ca,0xaf6565ca
.long	0x8e7a7af4,0x8e7a7af4
.long	0xe9aeae47,0xe9aeae47
.long	0x18080810,0x18080810
.long	0xd5baba6f,0xd5baba6f
.long	0x887878f0,0x887878f0
.long	0x6f25254a,0x6f25254a
.long	0x722e2e5c,0x722e2e5c
.long	0x241c1c38,0x241c1c38
.long	0xf1a6a657,0xf1a6a657
.long	0xc7b4b473,0xc7b4b473
.long	0x51c6c697,0x51c6c697
.long	0x23e8e8cb,0x23e8e8cb
.long	0x7cdddda1,0x7cdddda1
.long	0x9c7474e8,0x9c7474e8
.long	0x211f1f3e,0x211f1f3e
.long	0xdd4b4b96,0xdd4b4b96
.long	0xdcbdbd61,0xdcbdbd61
.long	0x868b8b0d,0x868b8b0d
.long	0x858a8a0f,0x858a8a0f
.long	0x907070e0,0x907070e0
.long	0x423e3e7c,0x423e3e7c
.long	0xc4b5b571,0xc4b5b571
.long	0xaa6666cc,0xaa6666cc
.long	0xd8484890,0xd8484890
.long	0x05030306,0x05030306
.long	0x01f6f6f7,0x01f6f6f7
.long	0x120e0e1c,0x120e0e1c
.long	0xa36161c2,0xa36161c2
.long	0x5f35356a,0x5f35356a
.long	0xf95757ae,0xf95757ae
.long	0xd0b9b969,0xd0b9b969
.long	0x91868617,0x91868617
.long	0x58c1c199,0x58c1c199
.long	0x271d1d3a,0x271d1d3a
.long	0xb99e9e27,0xb99e9e27
.long	0x38e1e1d9,0x38e1e1d9
.long	0x13f8f8eb,0x13f8f8eb
.long	0xb398982b,0xb398982b
.long	0x33111122,0x33111122
.long	0xbb6969d2,0xbb6969d2
.long	0x70d9d9a9,0x70d9d9a9
.long	0x898e8e07,0x898e8e07
.long	0xa7949433,0xa7949433
.long	0xb69b9b2d,0xb69b9b2d
.long	0x221e1e3c,0x221e1e3c
.long	0x92878715,0x92878715
.long	0x20e9e9c9,0x20e9e9c9
.long	0x49cece87,0x49cece87
.long	0xff5555aa,0xff5555aa
.long	0x78282850,0x78282850
.long	0x7adfdfa5,0x7adfdfa5
.long	0x8f8c8c03,0x8f8c8c03
.long	0xf8a1a159,0xf8a1a159
.long	0x80898909,0x80898909
.long	0x170d0d1a,0x170d0d1a
.long	0xdabfbf65,0xdabfbf65
.long	0x31e6e6d7,0x31e6e6d7
.long	0xc6424284,0xc6424284
.long	0xb86868d0,0xb86868d0
.long	0xc3414182,0xc3414182
.long	0xb0999929,0xb0999929
.long	0x772d2d5a,0x772d2d5a
.long	0x110f0f1e,0x110f0f1e
.long	0xcbb0b07b,0xcbb0b07b
.long	0xfc5454a8,0xfc5454a8
.long	0xd6bbbb6d,0xd6bbbb6d
.long	0x3a16162c,0x3a16162c
.long	0x00000001, 0x00000002, 0x00000004, 0x00000008
.long	0x00000010, 0x00000020, 0x00000040, 0x00000080
.long	0x0000001b, 0x00000036, 0, 0, 0, 0, 0, 0
.globl	AES_Td
.align	64
AES_Td:
.long	0x50a7f451,0x50a7f451
.long	0x5365417e,0x5365417e
.long	0xc3a4171a,0xc3a4171a
.long	0x965e273a,0x965e273a
.long	0xcb6bab3b,0xcb6bab3b
.long	0xf1459d1f,0xf1459d1f
.long	0xab58faac,0xab58faac
.long	0x9303e34b,0x9303e34b
.long	0x55fa3020,0x55fa3020
.long	0xf66d76ad,0xf66d76ad
.long	0x9176cc88,0x9176cc88
.long	0x254c02f5,0x254c02f5
.long	0xfcd7e54f,0xfcd7e54f
.long	0xd7cb2ac5,0xd7cb2ac5
.long	0x80443526,0x80443526
.long	0x8fa362b5,0x8fa362b5
.long	0x495ab1de,0x495ab1de
.long	0x671bba25,0x671bba25
.long	0x980eea45,0x980eea45
.long	0xe1c0fe5d,0xe1c0fe5d
.long	0x02752fc3,0x02752fc3
.long	0x12f04c81,0x12f04c81
.long	0xa397468d,0xa397468d
.long	0xc6f9d36b,0xc6f9d36b
.long	0xe75f8f03,0xe75f8f03
.long	0x959c9215,0x959c9215
.long	0xeb7a6dbf,0xeb7a6dbf
.long	0xda595295,0xda595295
.long	0x2d83bed4,0x2d83bed4
.long	0xd3217458,0xd3217458
.long	0x2969e049,0x2969e049
.long	0x44c8c98e,0x44c8c98e
.long	0x6a89c275,0x6a89c275
.long	0x78798ef4,0x78798ef4
.long	0x6b3e5899,0x6b3e5899
.long	0xdd71b927,0xdd71b927
.long	0xb64fe1be,0xb64fe1be
.long	0x17ad88f0,0x17ad88f0
.long	0x66ac20c9,0x66ac20c9
.long	0xb43ace7d,0xb43ace7d
.long	0x184adf63,0x184adf63
.long	0x82311ae5,0x82311ae5
.long	0x60335197,0x60335197
.long	0x457f5362,0x457f5362
.long	0xe07764b1,0xe07764b1
.long	0x84ae6bbb,0x84ae6bbb
.long	0x1ca081fe,0x1ca081fe
.long	0x942b08f9,0x942b08f9
.long	0x58684870,0x58684870
.long	0x19fd458f,0x19fd458f
.long	0x876cde94,0x876cde94
.long	0xb7f87b52,0xb7f87b52
.long	0x23d373ab,0x23d373ab
.long	0xe2024b72,0xe2024b72
.long	0x578f1fe3,0x578f1fe3
.long	0x2aab5566,0x2aab5566
.long	0x0728ebb2,0x0728ebb2
.long	0x03c2b52f,0x03c2b52f
.long	0x9a7bc586,0x9a7bc586
.long	0xa50837d3,0xa50837d3
.long	0xf2872830,0xf2872830
.long	0xb2a5bf23,0xb2a5bf23
.long	0xba6a0302,0xba6a0302
.long	0x5c8216ed,0x5c8216ed
.long	0x2b1ccf8a,0x2b1ccf8a
.long	0x92b479a7,0x92b479a7
.long	0xf0f207f3,0xf0f207f3
.long	0xa1e2694e,0xa1e2694e
.long	0xcdf4da65,0xcdf4da65
.long	0xd5be0506,0xd5be0506
.long	0x1f6234d1,0x1f6234d1
.long	0x8afea6c4,0x8afea6c4
.long	0x9d532e34,0x9d532e34
.long	0xa055f3a2,0xa055f3a2
.long	0x32e18a05,0x32e18a05
.long	0x75ebf6a4,0x75ebf6a4
.long	0x39ec830b,0x39ec830b
.long	0xaaef6040,0xaaef6040
.long	0x069f715e,0x069f715e
.long	0x51106ebd,0x51106ebd
.long	0xf98a213e,0xf98a213e
.long	0x3d06dd96,0x3d06dd96
.long	0xae053edd,0xae053edd
.long	0x46bde64d,0x46bde64d
.long	0xb58d5491,0xb58d5491
.long	0x055dc471,0x055dc471
.long	0x6fd40604,0x6fd40604
.long	0xff155060,0xff155060
.long	0x24fb9819,0x24fb9819
.long	0x97e9bdd6,0x97e9bdd6
.long	0xcc434089,0xcc434089
.long	0x779ed967,0x779ed967
.long	0xbd42e8b0,0xbd42e8b0
.long	0x888b8907,0x888b8907
.long	0x385b19e7,0x385b19e7
.long	0xdbeec879,0xdbeec879
.long	0x470a7ca1,0x470a7ca1
.long	0xe90f427c,0xe90f427c
.long	0xc91e84f8,0xc91e84f8
.long	0x00000000,0x00000000
.long	0x83868009,0x83868009
.long	0x48ed2b32,0x48ed2b32
.long	0xac70111e,0xac70111e
.long	0x4e725a6c,0x4e725a6c
.long	0xfbff0efd,0xfbff0efd
.long	0x5638850f,0x5638850f
.long	0x1ed5ae3d,0x1ed5ae3d
.long	0x27392d36,0x27392d36
.long	0x64d90f0a,0x64d90f0a
.long	0x21a65c68,0x21a65c68
.long	0xd1545b9b,0xd1545b9b
.long	0x3a2e3624,0x3a2e3624
.long	0xb1670a0c,0xb1670a0c
.long	0x0fe75793,0x0fe75793
.long	0xd296eeb4,0xd296eeb4
.long	0x9e919b1b,0x9e919b1b
.long	0x4fc5c080,0x4fc5c080
.long	0xa220dc61,0xa220dc61
.long	0x694b775a,0x694b775a
.long	0x161a121c,0x161a121c
.long	0x0aba93e2,0x0aba93e2
.long	0xe52aa0c0,0xe52aa0c0
.long	0x43e0223c,0x43e0223c
.long	0x1d171b12,0x1d171b12
.long	0x0b0d090e,0x0b0d090e
.long	0xadc78bf2,0xadc78bf2
.long	0xb9a8b62d,0xb9a8b62d
.long	0xc8a91e14,0xc8a91e14
.long	0x8519f157,0x8519f157
.long	0x4c0775af,0x4c0775af
.long	0xbbdd99ee,0xbbdd99ee
.long	0xfd607fa3,0xfd607fa3
.long	0x9f2601f7,0x9f2601f7
.long	0xbcf5725c,0xbcf5725c
.long	0xc53b6644,0xc53b6644
.long	0x347efb5b,0x347efb5b
.long	0x7629438b,0x7629438b
.long	0xdcc623cb,0xdcc623cb
.long	0x68fcedb6,0x68fcedb6
.long	0x63f1e4b8,0x63f1e4b8
.long	0xcadc31d7,0xcadc31d7
.long	0x10856342,0x10856342
.long	0x40229713,0x40229713
.long	0x2011c684,0x2011c684
.long	0x7d244a85,0x7d244a85
.long	0xf83dbbd2,0xf83dbbd2
.long	0x1132f9ae,0x1132f9ae
.long	0x6da129c7,0x6da129c7
.long	0x4b2f9e1d,0x4b2f9e1d
.long	0xf330b2dc,0xf330b2dc
.long	0xec52860d,0xec52860d
.long	0xd0e3c177,0xd0e3c177
.long	0x6c16b32b,0x6c16b32b
.long	0x99b970a9,0x99b970a9
.long	0xfa489411,0xfa489411
.long	0x2264e947,0x2264e947
.long	0xc48cfca8,0xc48cfca8
.long	0x1a3ff0a0,0x1a3ff0a0
.long	0xd82c7d56,0xd82c7d56
.long	0xef903322,0xef903322
.long	0xc74e4987,0xc74e4987
.long	0xc1d138d9,0xc1d138d9
.long	0xfea2ca8c,0xfea2ca8c
.long	0x360bd498,0x360bd498
.long	0xcf81f5a6,0xcf81f5a6
.long	0x28de7aa5,0x28de7aa5
.long	0x268eb7da,0x268eb7da
.long	0xa4bfad3f,0xa4bfad3f
.long	0xe49d3a2c,0xe49d3a2c
.long	0x0d927850,0x0d927850
.long	0x9bcc5f6a,0x9bcc5f6a
.long	0x62467e54,0x62467e54
.long	0xc2138df6,0xc2138df6
.long	0xe8b8d890,0xe8b8d890
.long	0x5ef7392e,0x5ef7392e
.long	0xf5afc382,0xf5afc382
.long	0xbe805d9f,0xbe805d9f
.long	0x7c93d069,0x7c93d069
.long	0xa92dd56f,0xa92dd56f
.long	0xb31225cf,0xb31225cf
.long	0x3b99acc8,0x3b99acc8
.long	0xa77d1810,0xa77d1810
.long	0x6e639ce8,0x6e639ce8
.long	0x7bbb3bdb,0x7bbb3bdb
.long	0x097826cd,0x097826cd
.long	0xf418596e,0xf418596e
.long	0x01b79aec,0x01b79aec
.long	0xa89a4f83,0xa89a4f83
.long	0x656e95e6,0x656e95e6
.long	0x7ee6ffaa,0x7ee6ffaa
.long	0x08cfbc21,0x08cfbc21
.long	0xe6e815ef,0xe6e815ef
.long	0xd99be7ba,0xd99be7ba
.long	0xce366f4a,0xce366f4a
.long	0xd4099fea,0xd4099fea
.long	0xd67cb029,0xd67cb029
.long	0xafb2a431,0xafb2a431
.long	0x31233f2a,0x31233f2a
.long	0x3094a5c6,0x3094a5c6
.long	0xc066a235,0xc066a235
.long	0x37bc4e74,0x37bc4e74
.long	0xa6ca82fc,0xa6ca82fc
.long	0xb0d090e0,0xb0d090e0
.long	0x15d8a733,0x15d8a733
.long	0x4a9804f1,0x4a9804f1
.long	0xf7daec41,0xf7daec41
.long	0x0e50cd7f,0x0e50cd7f
.long	0x2ff69117,0x2ff69117
.long	0x8dd64d76,0x8dd64d76
.long	0x4db0ef43,0x4db0ef43
.long	0x544daacc,0x544daacc
.long	0xdf0496e4,0xdf0496e4
.long	0xe3b5d19e,0xe3b5d19e
.long	0x1b886a4c,0x1b886a4c
.long	0xb81f2cc1,0xb81f2cc1
.long	0x7f516546,0x7f516546
.long	0x04ea5e9d,0x04ea5e9d
.long	0x5d358c01,0x5d358c01
.long	0x737487fa,0x737487fa
.long	0x2e410bfb,0x2e410bfb
.long	0x5a1d67b3,0x5a1d67b3
.long	0x52d2db92,0x52d2db92
.long	0x335610e9,0x335610e9
.long	0x1347d66d,0x1347d66d
.long	0x8c61d79a,0x8c61d79a
.long	0x7a0ca137,0x7a0ca137
.long	0x8e14f859,0x8e14f859
.long	0x893c13eb,0x893c13eb
.long	0xee27a9ce,0xee27a9ce
.long	0x35c961b7,0x35c961b7
.long	0xede51ce1,0xede51ce1
.long	0x3cb1477a,0x3cb1477a
.long	0x59dfd29c,0x59dfd29c
.long	0x3f73f255,0x3f73f255
.long	0x79ce1418,0x79ce1418
.long	0xbf37c773,0xbf37c773
.long	0xeacdf753,0xeacdf753
.long	0x5baafd5f,0x5baafd5f
.long	0x146f3ddf,0x146f3ddf
.long	0x86db4478,0x86db4478
.long	0x81f3afca,0x81f3afca
.long	0x3ec468b9,0x3ec468b9
.long	0x2c342438,0x2c342438
.long	0x5f40a3c2,0x5f40a3c2
.long	0x72c31d16,0x72c31d16
.long	0x0c25e2bc,0x0c25e2bc
.long	0x8b493c28,0x8b493c28
.long	0x41950dff,0x41950dff
.long	0x7101a839,0x7101a839
.long	0xdeb30c08,0xdeb30c08
.long	0x9ce4b4d8,0x9ce4b4d8
.long	0x90c15664,0x90c15664
.long	0x6184cb7b,0x6184cb7b
.long	0x70b632d5,0x70b632d5
.long	0x745c6c48,0x745c6c48
.long	0x4257b8d0,0x4257b8d0
.byte	0x52,0x09,0x6a,0xd5,0x30,0x36,0xa5,0x38
.byte	0xbf,0x40,0xa3,0x9e,0x81,0xf3,0xd7,0xfb
.byte	0x7c,0xe3,0x39,0x82,0x9b,0x2f,0xff,0x87
.byte	0x34,0x8e,0x43,0x44,0xc4,0xde,0xe9,0xcb
.byte	0x54,0x7b,0x94,0x32,0xa6,0xc2,0x23,0x3d
.byte	0xee,0x4c,0x95,0x0b,0x42,0xfa,0xc3,0x4e
.byte	0x08,0x2e,0xa1,0x66,0x28,0xd9,0x24,0xb2
.byte	0x76,0x5b,0xa2,0x49,0x6d,0x8b,0xd1,0x25
.byte	0x72,0xf8,0xf6,0x64,0x86,0x68,0x98,0x16
.byte	0xd4,0xa4,0x5c,0xcc,0x5d,0x65,0xb6,0x92
.byte	0x6c,0x70,0x48,0x50,0xfd,0xed,0xb9,0xda
.byte	0x5e,0x15,0x46,0x57,0xa7,0x8d,0x9d,0x84
.byte	0x90,0xd8,0xab,0x00,0x8c,0xbc,0xd3,0x0a
.byte	0xf7,0xe4,0x58,0x05,0xb8,0xb3,0x45,0x06
.byte	0xd0,0x2c,0x1e,0x8f,0xca,0x3f,0x0f,0x02
.byte	0xc1,0xaf,0xbd,0x03,0x01,0x13,0x8a,0x6b
.byte	0x3a,0x91,0x11,0x41,0x4f,0x67,0xdc,0xea
.byte	0x97,0xf2,0xcf,0xce,0xf0,0xb4,0xe6,0x73
.byte	0x96,0xac,0x74,0x22,0xe7,0xad,0x35,0x85
.byte	0xe2,0xf9,0x37,0xe8,0x1c,0x75,0xdf,0x6e
.byte	0x47,0xf1,0x1a,0x71,0x1d,0x29,0xc5,0x89
.byte	0x6f,0xb7,0x62,0x0e,0xaa,0x18,0xbe,0x1b
.byte	0xfc,0x56,0x3e,0x4b,0xc6,0xd2,0x79,0x20
.byte	0x9a,0xdb,0xc0,0xfe,0x78,0xcd,0x5a,0xf4
.byte	0x1f,0xdd,0xa8,0x33,0x88,0x07,0xc7,0x31
.byte	0xb1,0x12,0x10,0x59,0x27,0x80,0xec,0x5f
.byte	0x60,0x51,0x7f,0xa9,0x19,0xb5,0x4a,0x0d
.byte	0x2d,0xe5,0x7a,0x9f,0x93,0xc9,0x9c,0xef
.byte	0xa0,0xe0,0x3b,0x4d,0xae,0x2a,0xf5,0xb0
.byte	0xc8,0xeb,0xbb,0x3c,0x83,0x53,0x99,0x61
.byte	0x17,0x2b,0x04,0x7e,0xba,0x77,0xd6,0x26
.byte	0xe1,0x69,0x14,0x63,0x55,0x21,0x0c,0x7d