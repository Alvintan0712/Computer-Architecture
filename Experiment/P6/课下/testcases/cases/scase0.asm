addiu $20, $0, 0x3000
ori $22, $0, 0x1234
xori $23, $0, 20
addi $24, $0, 1
sw $20, 0x0($23)

and $2, $0, $3
sw $2, 0x0($23)
andi $2, $4, 0x560f
sw $2, 0x0($23)
lui $5, 0x9331
sw $5, 0x0($23)
srl $6, $5, 3
sw $6, 0x0($23)
mfhi $5
sw $5, 0x0($23)
xori $21, $0, 0x3050
or $5, $0, $21
jr $5
and $1, $5, $0
lui $1, 0xa6b6
ori $21, $0, 0x3060
xor $6, $0, $21
jalr $1, $6
mflo $5
mflo $4
subu $1, $4, $5
blez $1, W4MCWFCAGcE
nor $2, $0, $2
lui $3, 0x5190
W4MCWFCAGcE:
addiu $3, $0, 0x3084
jr $3
andi $6, $0, 0xb5cb
xori $1, $6, 0x7953
addiu $5, $0, 0x3090
jalr $6, $5
srl $1, $1, 1
mflo $6
ori $1, $3, 0x5308
bltz $1, mSoZwKyuXNY
mfhi $2
subu $6, $1, $3
mSoZwKyuXNY:
lui $1, 0xce52
bgtz $1, YHnwU6l68Ib
lui $4, 0xd112
srl $6, $3, 4
YHnwU6l68Ib:
addiu $4, $0, 0x30c8
sll $1, $4, 0
jr $1
sllv $4, $3, $3
lui $4, 0xb2bd
addiu $4, $0, 0x30d8
sra $4, $4, 0
jalr $2, $4
sllv $2, $1, $6
andi $3, $3, 0x388b
sll $1, $1, 3
beq $4, $1, eSAlv82KIgu
srl $2, $2, 2
or $6, $6, $3
eSAlv82KIgu:
addiu $2, $0, 0x3104
mult $2, $24
mflo $1
jr $1
addiu $6, $0, 0x642f
lui $3, 0x3794
xori $6, $0, 0x3118
mult $6, $24
mflo $4
jalr $2, $4
mflo $6
sltu $3, $2, $5
mfhi $6
bne $5, $6, cXdEwkOre2N
mfhi $4
mfhi $2
cXdEwkOre2N:
and $6, $4, $5
and $1, $2, $6
srlv $5, $2, $0
andi $6, $5, 0x975d
and $1, $5, $4
multu $1, $1
srlv $2, $6, $2
mthi $2
addu $6, $1, $2
sra $5, $6, 1
ori $21, $0, 0xc
or $1, $0, $21
lw $1, 0x0($1)
ori $21, $0, 0x10
addu $5, $0, $21
sh $6, 0x0($5)
slti $3, $4, 0x693b
sltu $1, $3, $6
ori $1, $6, 0xf9cc
addiu $5, $1, 0x61e2
andi $5, $3, 0x9251
mult $5, $1
ori $4, $2, 0xd5a2
mtlo $4
andi $5, $1, 0x9cd0
sra $5, $5, 5
ori $5, $0, 0x14
lw $5, 0x0($5)
xori $3, $0, 0x8
sw $1, 0x0($3)
lui $5, 0x5a06
nor $4, $3, $5
lui $2, 0xfef1
addiu $2, $2, -0x789a
lui $1, 0x96d4
div $1, $23
lui $1, 0xc87f
mtlo $1
lui $3, 0x75cb
sra $1, $3, 2
sra $3, $0, 3
srlv $6, $5, $3
srl $5, $4, 3
xori $6, $5, 0xd19f
srl $3, $5, 5
div $3, $23
sll $1, $2, 5
mtlo $1
sll $2, $6, 3
sll $1, $2, 5
ori $3, $0, 0x14
sll $1, $3, 0
lw $4, 0x0($1)
addiu $3, $0, 0x21
srl $2, $3, 0
sb $6, 0x0($2)
mflo $3
subu $4, $3, $5
mflo $6
andi $1, $6, 0x5820
mfhi $3
mult $1, $3
mfhi $2
mthi $2
mfhi $3
srl $4, $3, 3
addiu $4, $0, 0x14
mult $4, $24
mflo $3
lw $2, 0x0($3)
xori $2, $0, 0x24
mult $2, $24
mflo $3
sw $2, 0x0($3)
or $1, $2, $5
and $2, $1, $1
and $5, $5, $0
ori $4, $5, 0x3ad8
addu $5, $5, $6
divu $5, $23
nor $6, $5, $2
mthi $6
srav $5, $1, $2
sra $1, $5, 5
xori $21, $0, 0x10
xor $6, $0, $21
lw $3, 0x0($6)
addiu $21, $0, 0x1c
or $5, $0, $21
sw $0, 0x0($5)
andi $1, $0, 0x730f
and $6, $1, $1
slti $3, $4, 0xf12
ori $6, $3, 0x8458
addiu $5, $6, -0x2be5
mult $1, $5
addiu $4, $1, 0x2d38
mthi $4
slti $4, $6, 0x328
srl $5, $4, 4
xori $3, $0, 0xc
lw $1, 0x0($3)
ori $6, $0, 0x1d
sb $4, 0x0($6)
lui $1, 0x8ec7
slt $1, $1, $4
lui $3, 0xa4f0
andi $2, $3, 0xcca8
lui $2, 0x3939
multu $1, $2
lui $3, 0x391f
mthi $3
lui $1, 0x5fbe
sll $6, $1, 5
srl $5, $1, 2
xor $4, $5, $6
sra $5, $5, 5
sltiu $2, $5, 0x2f94
sra $3, $5, 2
divu $3, $23
sll $2, $0, 5
mthi $2
sll $1, $1, 2
sra $2, $1, 3
xori $5, $0, 0x18
sll $2, $5, 0
lw $3, 0x0($2)
addiu $6, $0, 0x10
srl $5, $6, 0
sw $0, 0x0($5)
mflo $5
srav $5, $5, $4
mfhi $5
ori $4, $5, 0x5c79
mfhi $6
mult $0, $6
mfhi $2
mtlo $2
mfhi $3
srl $6, $3, 4
addiu $3, $0, 0x20
mult $3, $24
mflo $4
lw $5, 0x0($4)
xori $2, $0, 0x8
mult $2, $24
mflo $4
sw $0, 0x0($4)
addiu $21, $0, 0x3390
xor $2, $0, $21
jr $2
or $1, $0, $2
sll $1, $3, 1
ori $21, $0, 0x33a0
addu $5, $0, $21
jalr $6, $5
sra $3, $0, 3
sll $1, $1, 1
nor $1, $2, $0
bgtz $1, xZJXUT4C3gJ
lui $4, 0xcc52
sll $6, $2, 1
xZJXUT4C3gJ:
ori $1, $0, 0x33c4
jr $1
lui $3, 0x9b74
srlv $2, $1, $5
ori $1, $0, 0x33d0
jalr $3, $1
xori $2, $0, 0x3382
mflo $2
sltiu $3, $6, -0x628c
bne $3, $6, D5vGApSKEcA
mflo $4
sll $4, $5, 3
D5vGApSKEcA:
lui $1, 0x9208
blez $1, CkOcmHYeEwv
slti $4, $4, 0xda1
ori $4, $0, 0x5c62
CkOcmHYeEwv:
addiu $5, $0, 0x3408
srl $6, $5, 0
jr $6
mflo $5
sltu $1, $2, $5
xori $4, $0, 0x3418
srl $3, $4, 0
jalr $1, $3
sltiu $4, $0, 0x4477
srl $5, $4, 3
sra $1, $4, 5
bgez $1, YOyPS1u34Oi
ori $5, $6, 0x84a2
lui $5, 0x3528
YOyPS1u34Oi:
xori $2, $0, 0x3444
mult $2, $24
mflo $6
jr $6
addu $1, $1, $1
lui $3, 0x8257
xori $3, $0, 0x3458
mult $3, $24
mflo $2
jalr $4, $2
srl $4, $3, 2
lui $4, 0xd32
mflo $6
bltz $6, NMs9CdLv1Jj
and $3, $0, $6
addiu $4, $1, -0x572a
NMs9CdLv1Jj:
addiu $5, $0, 0x3484
sw $5, 0x0($23)
lw $5, 0x0($23)
jr $5
srl $1, $1, 1
sra $3, $5, 1
ori $6, $0, 0x3498
sw $6, 0x0($23)
lw $6, 0x0($23)
jalr $4, $6
sra $4, $1, 4
lui $3, 0xfdd8
xori $1, $0, 36
lw $4, 0x0($1)
bne $4, $0, nVjPng6Jg7W
or $5, $2, $4
slti $5, $3, -0x3d20
nVjPng6Jg7W:
addiu $6, $0, 38
lbu $4, 0x0($6)
sw $4, 0x0($23)
ori $5, $0, 32
lh $1, 0x0($5)
sllv $2, $1, $3
xori $2, $0, 38
lhu $3, 0x0($2)
slti $1, $3, -0xffa
xori $5, $0, 10
lb $1, 0x0($5)
multu $5, $1
ori $2, $0, 20
lh $4, 0x0($2)
mtlo $4
ori $3, $0, 38
lb $5, 0x0($3)
sra $6, $5, 3
xori $3, $0, 0x10
sw $3, 0x0($23)
lw $3, 0x0($23)
lw $2, 0x0($3)
addiu $3, $0, 0x10
sw $3, 0x0($23)
lw $3, 0x0($23)
sw $6, 0x0($3)
ori $6, $0, 5
lb $5, 0x0($6)
sltu $6, $5, $2
xori $6, $0, 28
lw $1, 0x0($6)
addiu $6, $1, 0x1ce3
xori $3, $0, 38
lhu $6, 0x0($3)
mult $6, $2
addiu $6, $0, 6
lbu $3, 0x0($6)
mthi $3
addiu $5, $0, 36
lw $3, 0x0($5)
sll $2, $3, 2
addiu $4, $0, 0x4
sw $4, 0x0($23)
lw $4, 0x0($23)
lw $2, 0x0($4)
xori $2, $0, 0xc
sw $2, 0x0($23)
lw $2, 0x0($23)
sh $6, 0x0($2)
ori $1, $0, 0x358c
sw $1, 0x0($23)
lw $1, 0x0($23)
jr $1
sltu $4, $6, $4
srl $5, $3, 4
ori $2, $0, 0x35a0
sw $2, 0x0($23)
lw $2, 0x0($23)
jalr $5, $2
nor $3, $4, $2
ori $1, $6, 0x613a
addiu $2, $0, 36
lw $4, 0x0($2)
bgtz $4, DpFLU9tS8iG
lui $6, 0x44bb
or $2, $5, $0
DpFLU9tS8iG:
addiu $3, $0, 0x35d0
sw $3, 0x0($23)
lw $3, 0x0($23)
jr $3
sll $4, $0, 5
nor $6, $4, $5
addiu $6, $0, 0x35e4
sw $6, 0x0($23)
lw $6, 0x0($23)
jalr $5, $6
mfhi $5
sll $2, $1, 2
xori $3, $0, 11
lbu $2, 0x0($3)
beq $2, $2, wtbnvhC6DY6
nor $4, $6, $4
slti $4, $6, 0x6907
wtbnvhC6DY6:
ori $21, $0, 0x3610
xor $1, $0, $21
jr $1
mflo $3
lui $5, 0xe46b
ori $21, $0, 0x3620
or $5, $0, $21
jalr $2, $5
lui $2, 0x9057
subu $1, $0, $3
addu $6, $6, $2
bgtz $6, v09tI4Oq41o
srl $4, $5, 5
mfhi $2
v09tI4Oq41o:
xori $2, $0, 0x3644
jr $2
sra $6, $0, 5
sra $1, $3, 2
ori $1, $0, 0x3650
jalr $4, $1
lui $3, 0xa4c3
srl $5, $2, 5
slti $1, $1, -0x6715
blez $1, NRtJV6NkGbc
xor $5, $6, $5
mfhi $4
NRtJV6NkGbc:
lui $6, 0x6f7d
bgez $6, oP12aO3EmTw
lui $1, 0x27b0
andi $1, $2, 0xe52d
oP12aO3EmTw:
ori $1, $0, 0x3688
sll $5, $1, 0
jr $5
mflo $6
mfhi $3
xori $3, $0, 0x3698
srl $2, $3, 0
jalr $3, $2
addu $3, $0, $5
srav $1, $4, $0
sra $1, $6, 1
bgtz $1, jfjwJVw1jlx
sll $3, $5, 5
sll $6, $2, 1
jfjwJVw1jlx:
addiu $1, $0, 0x36c4
mult $1, $24
mflo $4
jr $4
sra $1, $6, 4
or $5, $3, $4
addiu $1, $0, 0x36d8
mult $1, $24
mflo $5
jalr $2, $5
lui $6, 0xe959
sra $2, $6, 1
mflo $5
bltz $5, XDH2mlAw3TG
srl $4, $1, 4
addu $1, $2, $3
XDH2mlAw3TG: