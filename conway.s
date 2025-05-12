.data
	lin: .space 4		#nr linii
	col: .space 4		#nr coloane
	p: .space 4		#nr puncte
	x: .space 4		#auxiliar citire punct x
	y: .space 4		#auxiliar citire punct y
	k: .space 4		#nr pasi Conway
	vec: .space 1600	#matrice
	vec2: .space 1600	#matrice auxiliara
	formscan: .asciz " %d"	#format scanf
	formprint: .asciz "%d "	#format printf
	endl: .asciz "\n"	
	sum: .space 4		#nr vecini
	
.text
.global main
main:
mov $vec, %edi

push $lin
push $formscan
call scanf
add $8, %esp
mov lin, %eax
add $2, %eax
mov %eax, lin
	
push $col
push $formscan
call scanf
add $8, %esp
mov col, %eax
add $2, %eax
mov %eax, col
	
push $p
push $formscan
call scanf
add $8, %esp
	
mov p, %ecx
puncte:
	push %ecx
	
	push $y
	push $formscan
	call scanf
	add $8, %esp
	
	push $x
	push $formscan
	call scanf
	add $8, %esp
	
	mov y, %eax
	inc %eax
	mull col
	add x, %eax
	inc %eax
	mov $1, (%edi, %eax, 4)
	
	pop %ecx
	loop puncte
	
push $k
push $formscan
call scanf
add $8, %esp
	
#----------------sfarsit citire----------------
#----------------conway----------------
#ebx = y, ecx = x, eax = col * ebx + ecx, %edx = sum (nr vecini)
#de la 1 la n-1 (fara border)

mov k, %eax
cmp $0, %eax
je afisare

mov k, %ecx
conw:
push %ecx

mov $2, %ebx 	#incepem de la 2 si folosim ebx-1 pentru intervalul [1,lin-1]
vec_y:
	push %ebx
	dec %ebx
	
	mov $2, %ecx
	vec_x:
		push %ecx
		dec %ecx
				
		mov %ebx, %eax
		mull col
		add %ecx, %eax
		
		xor %edx, %edx
		
		dec %eax			#(x-1,y)
		add (%edi, %eax, 4), %edx
		add $2, %eax			#(x+1,y)
		add (%edi, %eax, 4), %edx
		sub col, %eax			#(x+1,y-1)
		add (%edi, %eax, 4), %edx
		dec %eax			#(x,y-1)
		add (%edi, %eax, 4), %edx
		dec %eax			#(x-1,y-1)
		add (%edi, %eax, 4), %edx
		add col, %eax
		add col, %eax			#(x-1,y+1)
		add (%edi, %eax, 4), %edx
		inc %eax			#(x,y+1)
		add (%edi, %eax, 4), %edx
		inc %eax			#(x+1,y+1)
		add (%edi, %eax, 4), %edx
		sub col, %eax
		dec %eax			#(x,y)
		
		mov %edx, sum
		
		c1:				#vecini < 2
			cmp $1, %edx
			jg c2
			
			push %edi
			mov $vec2, %edi
			mov $0, (%edi, %eax, 4)
			pop %edi
			jmp cend
		c2:				#vecini == 2
			cmp $2, %edx
			jg c3
			
			mov (%edi, %eax, 4), %edx
			push %edi
			mov $vec2, %edi
			mov %edx, (%edi, %eax, 4)
			pop %edi
			
			mov sum, %edx
			jmp cend
		c3:				#vecini == 3
			cmp $3, %edx
			jg c4
			
			push %edi
			mov $vec2, %edi
			mov $1, (%edi, %eax, 4)
			pop %edi
			jmp cend
		c4:				#vecini >= 4
			push %edi
			mov $vec2, %edi
			mov $0, (%edi, %eax, 4)
			pop %edi
		cend:
		
		#push %edx
		#push $formprint
		#call printf
		#add $8, %esp
		
		pop %ecx
		inc %ecx
		cmp col, %ecx
		jne vec_x
	
	pop %ebx
	inc %ebx
	cmp lin, %ebx
	jne vec_y
#----------------vec = vec2----------------
	mov $400, %ecx	#parcurge vec2 de la 1600 la 0 (4 cate 4)
	mov $vec, %edi
copie:
	mov $vec2, %edi
	mov (%edi, %ecx, 4), %eax
	mov $vec, %edi
	mov %eax, (%edi, %ecx, 4)
	loop copie
	
pop %ecx
dec %ecx
jnz conw

#----------------afisare matrice----------------
#ebx = y, ecx = x, eax = col * ebx + ecx 
afisare:

mov $2, %ebx
afisare_lin:
	push %ebx
	dec %ebx
	
	mov $2, %ecx
	afisare_col:
		push %ecx
		dec %ecx
		
		mov %ebx, %eax
		mull col
		add %ecx, %eax
		
		push (%edi, %eax, 4)
		push $formprint
		call printf
		add $8, %esp
		
		pop %ecx
		inc %ecx
		cmp col, %ecx
		jne afisare_col
	
	push $endl
	call printf
	add $4, %esp
	
	pop %ebx
	inc %ebx
	cmp lin, %ebx
	jne afisare_lin
	
#----------------return 0----------------

push $0
call fflush
add $4, %esp

mov $1, %eax
mov $0, %ebx
int $0x80

