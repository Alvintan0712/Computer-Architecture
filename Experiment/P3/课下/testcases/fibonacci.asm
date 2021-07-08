addu $t0, $0, 1
sw $t0, 0($0)
sw $t0, 4($0)

addu $t0, $0, 2
addu $t1, $0, 0
addu $s0, $0, 50

for:
	beq $t0, $s0, for_end
	
	lw $t2, 0($t1)
	lw $t3, 4($t1)
	addu $t1, $t1, 4
	addu $t3, $t2, $t3
	sw $t3, 4($t1)
	
	addu $t0, $t0, 1
	jal for
for_end: