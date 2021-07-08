.data
g: .space 256
vis: .space 256

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

	li $v0, 5
	syscall
	move $s1, $v0 # cin >> m
	li $a0, 0 # cnt = 0

scanf:
	li $t0, 0 # int i = 0
for_i:
	bge $t0, $s0, scan
	li $t1, 0 # int j = 0
for_j:
	bge $t1, $s1, for_i_end # j < m
	li $v0, 5
	syscall
	getindex($t0,$t1,$t2)
	sw $v0, g($t2) # cin >> g[i][j]
for_j_end:
	add $t1, $t1, 1 # j++
	j for_j
for_i_end:
	add $t0, $t0, 1 # i++
	j for_i

scan:
	li $v0, 5
	syscall
	sub $s2, $v0, 1 # cin >> start_i

	li $v0, 5
	syscall
	sub $s3, $v0, 1 # cin >> start_j

	li $v0, 5
	syscall
	sub $s4, $v0, 1 # cin >> end_i

	li $v0, 5
	syscall
	sub $s5, $v0, 1 # cin >> end_j

	li $t0, 1
	getindex($s2,$s3,$t2)
	sw $t0, vis($t2) # vis[start_i][start_j] = 1
	move $t0, $s2 # x = start_i
	move $t1, $s3 # y = start_j

	jal dfs # dfs(start_i,start_j)

	li $v0, 1
	syscall

	li $v0, 10
	syscall

dfs:

if:
	bne $t0, $s4, if1 # x != end_i
	bne $t1, $s5, if1 # x != end_j
	j done

if1:
	blez $t0, if2 # x <= 0

	sub $t0, $t0, 1 # x - 1
	getindex($t0,$t1,$t2)
	lw $t3, g($t2) # g[x - 1][y]
	bnez $t3, if1_end # g[x - 1][y] != 0

	lw $t3, vis($t2) # vis[x - 1][y]
	bnez $t3, if1_end # vis[x - 1][y] != 0

	li $t3, 1
	sw $t3, vis($t2) # vis[x - 1][y] = 1

	sub $sp, $sp, 12
	sw $ra, ($sp) # push address
	sw $t0, 4($sp) # push x - 1
	sw $t1, 8($sp) # push y

	jal dfs # dfs(x - 1,y)

	lw $ra, ($sp) # pop address
	lw $t0, 4($sp) # pop x - 1
	lw $t1, 8($sp) # pop y
	add $sp, $sp, 12

	getindex($t0,$t1,$t2)
	sw $0, vis($t2) # vis[x - 1][y] = 0
if1_end:
	add $t0, $t0, 1 # x

if2:
	blez $t1, if3

	sub $t1, $t1, 1 # y - 1
	getindex($t0,$t1,$t2)
	lw $t3, g($t2) # g[x][y - 1]
	bnez $t3, if2_end # g[x][y - 1] != 0

	lw $t3, vis($t2) # vis[x][y - 1]
	bnez $t3, if2_end # vis[x][y - 1] != 0

	li $t3, 1
	sw $t3, vis($t2) # vis[x][y - 1] = 1

	sub $sp, $sp, 12
	sw $ra, ($sp)
	sw $t0, 4($sp)
	sw $t1, 8($sp) 

	jal dfs

	lw $ra, ($sp) 
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	add $sp, $sp, 12

	getindex($t0,$t1,$t2)
	sw $0, vis($t2) # vis[x][y - 1] = 0
if2_end:
	add $t1, $t1, 1 # y

if3:
	add $t0, $t0, 1 # x + 1
	bge $t0, $s0, if3_end # x + 1 >= n

	getindex($t0,$t1,$t2)
	lw $t3, g($t2) # g[x + 1][y]
	bnez $t3, if3_end # g[x + 1][y] != 0

	lw $t3, vis($t2) # vis[x + 1][y]
	bnez $t3, if3_end # vis[x + 1][y] != 0

	li $t3, 1
	sw $t3, vis($t2) # vis[x + 1][y] = 1

	sub $sp, $sp, 12
	sw $ra, ($sp) # push address
	sw $t0, 4($sp) # push x + 1
	sw $t1, 8($sp) # push y

	jal dfs # dfs(x + 1,y)

	lw $ra, ($sp) # pop address
	lw $t0, 4($sp) # pop x + 1
	lw $t1, 8($sp) # pop y
	add $sp, $sp, 12

	getindex($t0,$t1,$t2)
	sw $0, vis($t2) # vis[x - 1][y] = 0
if3_end:
	sub $t0, $t0, 1 # x

if4:
	add $t1, $t1, 1 # y + 1
	bge $t1, $s1, if4_end # y + 1 >= m

	getindex($t0,$t1,$t2)
	lw $t3, g($t2) # g[x][y + 1]
	bnez $t3, if4_end # g[x][y + 1] != 0

	lw $t3, vis($t2) # vis[x][y + 1]
	bnez $t3, if4_end # vis[x][y + 1] != 0

	li $t3, 1
	sw $t3, vis($t2) # vis[x][y + 1] = 1

	sub $sp, $sp, 12
	sw $ra, ($sp) # push address
	sw $t0, 4($sp) # push x
	sw $t1, 8($sp) # push y + 1

	jal dfs # dfs(x + 1,y)

	lw $ra, ($sp) # pop address
	lw $t0, 4($sp) # pop x
	lw $t1, 8($sp) # pop y + 1
	add $sp, $sp, 12

	getindex($t0,$t1,$t2)
	sw $0, vis($t2) # vis[x][y + 1] = 0

if4_end:
	sub $t1, $t1, 1 # y
	j return
done:
	add $a0, $a0, 1 # cnt++
return:
	jr $ra

# $a0 = cnt
# $s0 = n
# $s1 = m
# $s2 = start_i
# $s3 = start_j
# $s4 = end_i
# $s5 = end_j
# $t0 = x
# $t1 = y
