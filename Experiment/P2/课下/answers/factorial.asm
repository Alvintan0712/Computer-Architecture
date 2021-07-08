.data
num: .space 400

.text
main:
	li $v0, 5
	syscall # cin >> n

	li $s0, 1 # len = 1
	li $v1, 10 # v1 = constant 10

	sw $s0, num($0) # num[0] = 1

whilen:
	ble $v0, 1, while # n <= 1
	li $t0, 0 # i = 0
	li $s1, 0 # cout = 0
for:
	blt $t0, $s0, run # i < len
	beqz $s1, whilen_end # cout == 0
run:
	sll $t1, $t0, 2
	lw  $t2, num($t1) # num[i]
	mul $t2, $t2, $v0 # num[i]*n
	add $t2, $t2, $s1 # num[i]*n + cout

	div $t2, $v1
	mflo $s1 # num[i] = res / 10
	mfhi $t2 # cout = res % 10
	sw $t2, num($t1)
for_end:
	add $t0, $t0, 1 # i++
	j for
whilen_end:
	add $s0, $0, $t0 # len = i
	sub $v0, $v0, 1 # n--
	j whilen
while:
	beqz $s0, return # len == 0
	sub $s0, $s0, 1 # len--
	sll $t0, $s0, 2
	lw $a0, num($t0) # num[len]
	li $v0, 1
	syscall
	j while

return:
	li $v0, 10
	syscall