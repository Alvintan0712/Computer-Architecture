.data
str: .space 20
.text
main:
	li $v0, 5
	syscall
	move $a1, $v0 # cin >> n
	srl $s0, $a1, 1 # $s0 = n/2

scanf:
	li $t0, 0 # int i = 0
for:
	beq $t0, $a1, printf

	li $v0, 12
	syscall
	sb $v0, str($t0) # cin >> s[i]
for_end:
	add $t0, $t0, 1 # i++
	j for
printf:
	li $t0, 0 # int i = 0
For:
	beq $t0, $s0, print1
	lb $s1, ($t0) # s[i]
	sub $t1, $a1, $t0 # n - i
	lb $s2, -1($t1) # s[n - i - 1]
	bne $s1, $s2, print0 # s[i] != s[n - i - 1]
For_end:
	add $t0, $t0, 1 # i++
	j For
print0:
	li $a0, 0
	li $v0, 1
	syscall
	j return
print1:
	li $a0, 1
	li $v0, 1
	syscall
return:
	li $v0, 10
	syscall