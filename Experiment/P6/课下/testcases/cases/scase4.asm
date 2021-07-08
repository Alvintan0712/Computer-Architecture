addiu $20, $0, 0x3000
ori $22, $0, 0x1234
xori $23, $0, 20
addi $24, $0, 1
sw $20, 0x0($23)

xori $21, $0, 0x3028
or $3, $0, $21
jr $3
lui $2, 0xefe6
srl $6, $5, 2
ori $21, $0, 0x3038
or $1, $0, $21
jalr $4, $1
mfhi $6
lui $5, 0xe773
xor $3, $1, $2
beq $3, $5, QfvmS1LnI2J
mflo $5
srl $6, $2, 1
QfvmS1LnI2J:
ori $5, $0, 0x305c
jr $5
addiu $6, $6, -0x3bbf
ori $3, $5, 0x57d6
ori $6, $0, 0x3068
jalr $1, $6
subu $2, $1, $2
mfhi $4
xori $4, $1, 0xe9a0
bne $4, $5, bhJKtpXY3gD
srl $3, $0, 5
mfhi $6
bhJKtpXY3gD:
lui $6, 0x7fd3
bgtz $6, vqhdES1Vdjz
mflo $2
subu $1, $6, $2
vqhdES1Vdjz:
xori $2, $0, 0x30a0
srl $4, $2, 0
jr $4
mfhi $1
sltu $1, $3, $4
addiu $4, $0, 0x30b0
sll $2, $4, 0
jalr $4, $2
slt $4, $1, $5
lui $3, 0x8fb3
sra $4, $4, 1
beq $1, $4, i1rk1Et6MWD
xori $1, $5, 0xe3f5
lui $5, 0x743e
i1rk1Et6MWD:
ori $3, $0, 0x30dc
mult $3, $24
mflo $5
jr $5
sll $1, $3, 5
lui $2, 0xb771
xori $2, $0, 0x30f0
mult $2, $24
mflo $6
jalr $3, $6
sllv $2, $6, $1
mflo $4
mfhi $2
bgez $2, k9IUafmddtO
sltiu $1, $3, 0x3cb6
mflo $3
k9IUafmddtO:
addiu $4, $0, 0x311c
sw $4, 0x0($23)
lw $4, 0x0($23)
jr $4
mflo $5
slt $5, $1, $0
addiu $5, $0, 0x3130
sw $5, 0x0($23)
lw $5, 0x0($23)
jalr $6, $5
mfhi $2
lui $4, 0x5377
xori $1, $0, 4
lb $2, 0x0($1)
bltz $2, XKfXszxaeDK
slti $1, $1, 0x117b
lui $3, 0xa711
XKfXszxaeDK:
ori $1, $0, 0x3160
sw $1, 0x0($23)
lw $1, 0x0($23)
jr $1
addiu $6, $5, -0x7f9b
lui $5, 0xa305
addiu $3, $0, 0x3174
sw $3, 0x0($23)
lw $3, 0x0($23)
jalr $1, $3
lui $6, 0xe9d6
addu $4, $5, $0
addiu $1, $0, 38
lh $2, 0x0($1)
bgez $2, vqMKk5ahHzt
lui $3, 0xe5a1
lui $6, 0x96a8
vqMKk5ahHzt:
xori $2, $0, 16
lw $3, 0x0($2)
sw $3, 0x0($23)
srlv $1, $5, $6
xor $3, $4, $1
nor $6, $5, $1
addiu $4, $6, 0x4689
srlv $1, $6, $3
mult $1, $2
and $3, $6, $4
mthi $3
slt $3, $0, $6
sll $1, $3, 2
ori $21, $0, 0x24
xor $1, $0, $21
lw $4, 0x0($1)
addiu $21, $0, 0x24
or $1, $0, $21
sb $3, 0x0($1)
xori $5, $1, 0x1c67
addu $3, $0, $5
slti $4, $1, -0x1b48
ori $5, $4, 0xf81c
sltiu $2, $2, -0x35d2
multu $5, $2
addiu $5, $3, -0x5401
mthi $5
sltiu $2, $4, 0x4826
srl $2, $2, 4
xori $2, $0, 0x18
lw $3, 0x0($2)
addiu $2, $0, 0x1d
sb $4, 0x0($2)
lui $6, 0x217e
xor $5, $0, $6
lui $2, 0x6706
ori $5, $2, 0xe9d4
lui $3, 0x7987
div $3, $23
lui $3, 0xa450
mthi $3
lui $4, 0x8f87
srl $4, $4, 2
sll $4, $0, 3
srlv $2, $6, $4
sra $2, $1, 5
ori $5, $2, 0x6d54
sra $2, $1, 5
divu $2, $23
sra $6, $4, 1
mthi $6
sra $6, $6, 3
sra $4, $6, 2
addiu $1, $0, 0x4
sll $5, $1, 0
lw $5, 0x0($5)
ori $2, $0, 0xc
sll $3, $2, 0
sw $5, 0x0($3)
mfhi $6
srlv $5, $6, $4
mflo $5
ori $2, $5, 0xdbcb
mflo $2
div $2, $23
mfhi $2
mtlo $2
mfhi $1
srl $2, $1, 3
addiu $2, $0, 0x20
mult $2, $24
mflo $1
lw $6, 0x0($1)
addiu $2, $0, 0x19
mult $2, $24
mflo $5
sb $0, 0x0($5)
addiu $4, $0, 36
lw $6, 0x0($4)
or $5, $6, $5
ori $1, $0, 13
lbu $3, 0x0($1)
ori $3, $3, 0x3c24
addiu $2, $0, 12
lw $1, 0x0($2)
divu $1, $23
xori $2, $0, 35
lbu $5, 0x0($2)
mtlo $5
ori $2, $0, 31
lb $4, 0x0($2)
sra $6, $4, 2
addiu $2, $0, 0x24
sw $2, 0x0($23)
lw $2, 0x0($23)
lw $1, 0x0($2)
addiu $1, $0, 0xc
sw $1, 0x0($23)
lw $1, 0x0($23)
sb $4, 0x0($1)
ori $21, $0, 0x3330
xor $1, $0, $21
jr $1
lui $4, 0x53e9
slti $4, $4, 0x684
ori $21, $0, 0x3340
or $5, $0, $21
jalr $4, $5
lui $2, 0x61f0
lui $2, 0x13b2
xor $2, $1, $3
bne $2, $5, V0NXhv7f6oq
lui $3, 0x7aaa
and $3, $2, $1
V0NXhv7f6oq:
addiu $4, $0, 0x3364
jr $4
xori $5, $2, 0x29cc
sltu $5, $3, $3
xori $3, $0, 0x3370
jalr $4, $3
srav $5, $4, $3
or $6, $6, $6
ori $1, $1, 0x388b
bltz $1, CieU4qyWqLn
sll $5, $4, 1
sra $6, $1, 4
CieU4qyWqLn:
lui $5, 0xca04
bgez $5, qGVVUS1K5Og
nor $2, $5, $6
sll $1, $4, 4
qGVVUS1K5Og:
addiu $3, $0, 0x33a8
srl $3, $3, 0
jr $3
lui $1, 0xdcbb
sra $5, $4, 1
xori $2, $0, 0x33b8
sra $1, $2, 0
jalr $5, $1
sra $4, $2, 1
srl $6, $4, 5
sra $3, $3, 3
blez $3, vpcnIuUU1PK
srl $6, $4, 2
nor $6, $4, $1
vpcnIuUU1PK:
xori $1, $0, 0x33e4
mult $1, $24
mflo $5
jr $5
andi $6, $3, 0x8121
sll $2, $1, 4
ori $2, $0, 0x33f8
mult $2, $24
mflo $1
jalr $4, $1
sra $3, $5, 1
sra $2, $0, 2
mflo $1
beq $0, $1, XmbV7s4M0y9
sra $3, $6, 4
srl $4, $3, 5
XmbV7s4M0y9:
xori $1, $0, 28
lh $3, 0x0($1)
xor $3, $5, $3
xori $1, $0, 38
lh $5, 0x0($1)
ori $3, $5, 0x2381
xori $1, $0, 26
lh $6, 0x0($1)
divu $6, $23
addiu $6, $0, 14
lh $4, 0x0($6)
mtlo $4
xori $4, $0, 10
lhu $1, 0x0($4)
srl $3, $1, 2
ori $5, $0, 0xc
sw $5, 0x0($23)
lw $5, 0x0($23)
lw $3, 0x0($5)
addiu $2, $0, 0x1f
sw $2, 0x0($23)
lw $2, 0x0($23)
sb $2, 0x0($2)
nor $4, $4, $3
sllv $2, $4, $4
nor $1, $3, $3
andi $6, $1, 0xc6f3
srlv $6, $3, $1
div $6, $23
xor $1, $4, $1
mthi $1
xor $2, $1, $1
sll $2, $2, 1
ori $21, $0, 0x10
or $4, $0, $21
lw $2, 0x0($4)
ori $21, $0, 0x1f
xor $2, $0, $21
sb $5, 0x0($2)
addiu $3, $4, 0x46fb
or $3, $3, $2
slti $3, $4, -0x767b
andi $6, $3, 0xaaef
slti $2, $3, 0x5bf2
divu $2, $23
andi $1, $4, 0x5456
mthi $1
sltiu $4, $5, 0x3bd7
sll $4, $4, 5
ori $2, $0, 0x1c
lw $3, 0x0($2)
xori $5, $0, 0x18
sw $0, 0x0($5)
lui $3, 0x572e
addu $5, $2, $3
lui $6, 0x9529
xori $1, $6, 0x8413
lui $5, 0xbf7f
div $5, $23
lui $3, 0x98c7
mthi $3
lui $1, 0x537f
sra $1, $1, 3
sra $3, $5, 4
srlv $1, $3, $3
sra $6, $6, 4
andi $1, $6, 0x1cd8
sll $1, $3, 1
mult $5, $1
sll $5, $5, 4
mtlo $5
sll $3, $3, 5
sra $2, $3, 1
ori $5, $0, 0x4
srl $2, $5, 0
lw $5, 0x0($2)
addiu $5, $0, 0x7
srl $6, $5, 0
sb $1, 0x0($6)
mflo $3
xor $2, $4, $3
mfhi $3
sltiu $6, $3, 0x1b74
mflo $3
div $3, $23
mflo $1
mthi $1
mflo $6
sra $6, $6, 1
xori $2, $0, 0x4
mult $2, $24
mflo $1
lw $3, 0x0($1)
addiu $1, $0, 0x10
mult $1, $24
mflo $2
sb $0, 0x0($2)
addiu $1, $0, 0x35a8
sw $1, 0x0($23)
lw $1, 0x0($23)
jr $1
lui $6, 0x3d2d
lui $4, 0xbc00
xori $3, $0, 0x35bc
sw $3, 0x0($23)
lw $3, 0x0($23)
jalr $2, $3
srl $4, $1, 1
slt $2, $3, $3
ori $4, $0, 36
lhu $6, 0x0($4)
bltz $6, OY1l150rdlB
lui $5, 0x8bb5
lui $5, 0xf824
OY1l150rdlB:
xori $21, $0, 0x35e8
or $3, $0, $21
jr $3
xor $6, $6, $3
lui $6, 0xa6a7
xori $21, $0, 0x35f8
addu $1, $0, $21
jalr $5, $1
srlv $4, $3, $3
srl $5, $4, 3
slt $3, $2, $1
bgez $3, XirQ77uNUbt
ori $1, $0, 0xfadd
mfhi $1
XirQ77uNUbt:
addiu $1, $0, 0x361c
jr $1
lui $2, 0x8f8
mfhi $6
xori $5, $0, 0x3628
jalr $3, $5
lui $2, 0x41fe
lui $2, 0xb48
slti $1, $2, 0x7a5a
bgez $1, i5xTBf9RKpw
xor $5, $0, $2
mflo $2
i5xTBf9RKpw:
lui $1, 0xf2c4
bltz $1, C15USd3iD6I
addu $4, $2, $3
sllv $6, $5, $2
C15USd3iD6I:
ori $1, $0, 0x3660
sra $2, $1, 0
jr $2
addiu $4, $4, -0x5263
mflo $4
ori $5, $0, 0x3670
sll $1, $5, 0
jalr $2, $1
mflo $6
srav $6, $2, $2
sll $1, $3, 2
bgtz $1, m9bRB3hC3Yb
mflo $5
addiu $3, $6, -0x762
m9bRB3hC3Yb:
addiu $1, $0, 0x369c
mult $1, $24
mflo $4
jr $4
sra $2, $2, 1
slti $2, $2, -0x2c83
addiu $4, $0, 0x36b0
mult $4, $24
mflo $1
jalr $4, $1
addiu $2, $4, 0x7d28
nor $2, $0, $0
mflo $1
bgtz $1, unuQTz39hBs
sll $6, $0, 5
sra $6, $5, 5
unuQTz39hBs:
srav $4, $4, $1
sw $4, 0x0($23)
addiu $4, $3, 0x2f5c
sw $4, 0x0($23)
lui $3, 0xff0f
sw $3, 0x0($23)
sra $6, $4, 3
sw $6, 0x0($23)
mfhi $6
sw $6, 0x0($23)