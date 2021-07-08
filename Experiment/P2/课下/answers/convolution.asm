.data
f: .space 484
h: .space 484
g: .space 484
endl: .asciiz "\n"
space: .asciiz " "

.macro getindex(%i,%j,%ans)
	mul %ans, %i, 11
	add %ans, %ans, %j
	sll %ans, %ans, 2
.end_macro

.text
	li $v0, 5
	syscall
	move $s0, $v0 # cin >> m1
	li $v0, 5
	syscall
	move $s1, $v0 # cin >> n1
	li $v0, 5
	syscall
	move $s2, $v0 # cin >> m2
	li $v0, 5
	syscall
	move $s3, $v0 # cin >> n2
	sub $s4, $s0, $s2 # m1 - m2
	sub $s5, $s1, $s3 # n1 - n2

	li $t0, 0 # int i = 0

for1:
	beq $t0, $s0, buff1 # i < m1
	li $t1, 0 # int j = 0
for1_j:
	beq $t1, $s1, for1_end
	li $v0, 5
	syscall
	getindex($t0,$t1,$t2)
	sw $v0, f($t2) # cin >> f[i][j]
for1_j_end:
	add $t1, $t1, 1
	j for1_j
for1_end:
	add $t0, $t0, 1
	j for1

buff1:
	li $t0, 0 # int i = 0
for2:
	beq $t0, $s2, buff2 # i < m2
	li $t1, 0 # int j = 0
for2_j:
	beq $t1, $s3, for2_end # j < n2
	li $v0, 5
	syscall
	getindex($t0,$t1,$t2)
	sw $v0, h($t2) # cin >> f[i][j]	
for2_j_end:
	add $t1, $t1, 1
	j for2_j
for2_end:
	add $t0, $t0, 1
	j for2

buff2:
	li $t0, 0 # int i = 0
for_i:
	bgt $t0, $s4, return # i <= m1 - m2
	li $t1, 0 # int j = 0
for_j:
	bgt $t1, $s5, for_i_end # j <= n1 - n2
	li $t2, 0 # int k = 0
for_k:
	bge $t2, $s2, for_j_end # k < m2
	li $t3, 0 # int l = 0
for_l:
	bge $t3, $s3, for_k_end # l < n2

	add $t5, $t0, $t2 # i + k
	add $t6, $t1, $t3 # j + l

	getindex($t2,$t3,$t4)
	lw $t7, h($t4) # h[k][l]

	getindex($t5,$t6,$t4)
	lw $t8, f($t4) # f[i + k][j + l]
	mul $t7, $t7, $t8 # f[i + k][j + l]*h[k][l]

	getindex($t0,$t1,$t4)
	lw $t8, g($t4) # g[i][j]
	add $t8, $t8, $t7 # g[i][j] += f[i + k][j + l]
	sw $t8, g($t4)

for_l_end:
	add $t3, $t3, 1 # l++
	j for_l
for_k_end:
	add $t2, $t2, 1 # l++
	j for_k
for_j_end:
	getindex($t0,$t1,$t2)
	lw $a0, g($t2)
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall
	add $t1, $t1, 1 # l++
	j for_j
for_i_end:
	la $a0, endl
	li $v0, 4
	syscall
	add $t0, $t0, 1 # l++
	j for_i

return:
	li $v0, 10
	syscall