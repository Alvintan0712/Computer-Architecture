label0:ori $t0, $0, 0x1234
beq $0, $0, label3
label1:ori $t1, $0, 0xffff
beq $0, $0, label7
label2:addu $t0, $t0, $t1
beq $0, $0, label1
label3:addu $t0, $t0, 0
beq $0, $0, label5
label4:addu $t0, $t0, 0xffffffff
beq $0, $0, label2
label5:ori $t0, 1234
beq $0, $0, label9
label6:addu $t1, $0, 0xffff
beq $0, $0, label8
label7:lui $t0, 0xffff
beq $0, $0, label0
label8:subu $t0, $t1, $t0
beq $0, $0, label4
label9:subu $t1, $t1, $t0
beq $0, $0, label6