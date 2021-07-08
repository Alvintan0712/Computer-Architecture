.data
a: .space 256
b: .space 256
Ans: .space 256
space: .asciiz " "
breakline: .asciiz "\n"

.macro getindex(%i,%j,%ans)
	sll %ans, %i, 3
	add %ans, %ans, %j
	sll %ans, %ans, 2
.end_macro

.text
main:
	li $v0, 5
	syscall
	move $s0, $v0 # cin >> n

scanf_a:
	li $t0, 0 # int i = 0
for_i_a:
	bge $t0, $s0, scanf_b # i < n
	li $t1, 0 # int j = 0
for_j_a:
	bge $t1, $s0, for_i_a_end # j < n
	li $v0, 5
	syscall
	getindex($t0,$t1,$t2)
	sw $v0, a($t2) # cin >> a[i][j]
for_j_a_end:
	add $t1, $t1, 1 # j++
	j for_j_a
for_i_a_end:
	add $t0, $t0, 1 # i++
	j for_i_a

scanf_b:
	li $t0, 0 # int i =0
for_i_b:
	bge $t0, $s0, getans # i < n
	li $t1, 0 # int j = 0
for_j_b:
	bge $t1, $s0, for_i_b_end # j < n
	li $v0, 5
	syscall
	getindex($t0,$t1,$t2)
	sw $v0, b($t2) # cin >> b[i][j]
for_j_b_end:
	add $t1, $t1, 1 # j++
	j for_j_b
for_i_b_end:
	add $t0, $t0, 1 # i++
	j for_i_b

getans:
	li $t0, 0 # int i = 0
for_i_ans:
	bge $t0, $s0, printf # i < n
	li $t1, 0 # int j = 0 
for_j_ans:
	bge $t1, $s0, for_i_ans_end # j < n
	li $t2, 0 # int k = 0
for_k_ans:
	bge $t2, $s0, for_j_ans_end # k < n
	getindex($t0,$t2,$t3)
	lw $a0, a($t3) # a[i][k]

	getindex($t2,$t1,$t3)
	lw $a1, b($t3) # b[k][j]

	getindex($t0,$t1,$t3)
	lw $v0, Ans($t3) # ans[i][j]

	mul $v1, $a0, $a1 # a[i][k]*b[k][j]
	add $v0, $v0, $v1 # ans[i][j] += a[i][k]*b[k][j]
	sw $v0, Ans($t3)
for_k_ans_end:
	add $t2, $t2, 1
	j for_k_ans
for_j_ans_end:
	add $t1, $t1, 1
	j for_j_ans
for_i_ans_end:
	add $t0, $t0, 1
	j for_i_ans

printf:
	li $t0, 0 # int i = 0
for_i_print:
	bge $t0, $s0, return # i < n
	li $t1, 0 # int j = 0
for_j_print:
	bge $t1, $s0, for_i_print_end # j < n
	getindex($t0,$t1,$t2)
	lw $a0, Ans($t2) # ans[i][j]
	li $v0, 1 # cout << ans[i][j]
	syscall
	la $a0, space
	li $v0, 4 # cout << ' '
	syscall
for_j_print_end:
	add $t1, $t1, 1 # j++
	j for_j_print
for_i_print_end:
	la $a0, breakline
	li $v0, 4 # cout << endl
	syscall
	add $t0, $t0, 1 # i++
	j for_i_print
return:
	li $v0, 10
	syscall
