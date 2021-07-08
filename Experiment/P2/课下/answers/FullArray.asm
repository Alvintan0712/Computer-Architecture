.data
symbol: .space 28
array: .space 28
space: .asciiz " "
endl: .asciiz "\n"
.text
main:
	li $v0, 5
	syscall
	move $s0, $v0 # cin >> n

	li $t0, 0 # int index = 0
	jal FullArray # FullArray(0)

	li $v0, 10
	syscall
FullArray:
	bge $t0, $s0, print

recur:
	li $t1, 0 # int i = 0
for:
	bge $t1, $s0, return # i < n
	sll $t2, $t1, 2 # $t2 = i*4
	lw $s1, symbol($t2) # symbol[i]
	bne $s1, 0, for_end # symbol[i] == 0
if:
	li $s1, 1 # symbol[i] = 1
	sw $s1, symbol($t2)

	sll $t2, $t0, 2 # $t2 = index*4
	lw $s2, array($t2) # array[index]
	add $s2, $0, $t1 # array[index] = i
	add $s2, $s2, 1  # array[index] = i + 1
	sw $s2, array($t2)

	sub $sp, $sp, 8
	sw $ra, ($sp) # save address
	sw $t1, 4($sp) # save i
	add $t0, $t0, 1 # index + 1
	jal FullArray # FullArray(index + 1)
	sub $t0, $t0, 1 # index
	lw $ra, ($sp) # load address
	lw $t1, 4($sp) # load i
	add $sp, $sp, 8
	sll $t2, $t1, 2 # i*4
	sw $0, symbol($t2) # symbol[i] = 0
for_end:
	add $t1, $t1, 1 # i++
	j for

print:
	li $t1, 0 # int i = 0
For:
	bge $t1, $s0, break
	sll $t2, $t1, 2 # i*4
	lw $a0, array($t2) # array[i]
	li $v0, 1
	syscall
	la $a0, space # print ' '
	li $v0, 4
	syscall
For_end:
	add $t1, $t1, 1 # i++
	j For
break:
	la $a0, endl
	li $v0, 4
	syscall
return:
	jr $ra
