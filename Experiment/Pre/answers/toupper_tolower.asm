.data

.text
main:
	li $a1, 120
	li $v0, 8
	syscall

	li $t0, 0
	la $s1, ($a0)
	la $s0, ($a0)
loop:
	beq $t0, $a1, main_end

	lb $a0, ($s1)
	bge $a0, 97, lower
	bge $a0, 65, upper

	j loop_end
upper:
	ble $a0, 90, upper_end
	j loop_end
upper_end:
	add $a0, $a0, 32 # tolower
	j loop_end
lower:
	ble $a0, 122, lower_end
	j loop_end
lower_end:
	sub $a0, $a0, 32 # toupper
	j loop_end
loop_end:
	li $v0, 11
	syscall
	add $s1, $s1, 1
	add $t0, $t0, 1
	j loop
main_end:
	li $v0, 10
	syscall