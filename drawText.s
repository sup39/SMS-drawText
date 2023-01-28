	.globl drawText
	.type	drawText, @function
drawText:
.LFB0:
	stwu 1,-248(1)
	mflr 0
	stmw 30,240(1)
	mr 31,3 # r31 = opt
	stw 0,252(1)
	mr 30,4 # r30 = fmt
	stw 5,136(1)
	stw 6,140(1)
	stw 7,144(1)
	stw 8,148(1)
	stw 9,152(1)
	stw 10,156(1)
#bne- 1,.L3
	stfd 1,160(1)
	stfd 2,168(1)
	stfd 3,176(1)
	stfd 4,184(1)
	stfd 5,192(1)
	stfd 6,200(1)
	stfd 7,208(1)
	stfd 8,216(1)
.L3:
  li 9,0x200
	lwz 6,4(31) # opt->fontSize
  sth 9,112(1)
	li 9,0
	addi 9,1,256
	stw 9,116(1)
	addi 9,1,128
	stw 9,120(1)
  lwz 4,gpSystemFont$r13(13)
	addi 8,31,12 # opt->colorBot
	addi 7,31,8 # opt->colorTop
	li 5,0
	addi 3,1,8 # &printer
	bl new_J2DPrint
################################
	lwz 9,4(31) # fontSize
addi 3,1,8 # &printer
	stw 9,100(1) # printer.fontHeight =
	stw 9,96(1) # printer.fontWidth =

	lha 10,0(31) # x
li 4,255 # 0xff
	stw 10,36(1) # printer.xInt =

#	lha 9,2(31) # y
mr 5,30 # fmt
#	stw 9,40(1) # printer.yInt =

### xFloat, yFloat
### GQR5 = 0x70007 (s16)
  psq_l f0, 0(r31), 0, gqr5
addi 6,1,112 # ...
  psq_st f0, 44(r1), 0, gqr0

### zFloat
  li r0, 0
  stw r0, 52(r1)

	bl J2DPrint_print_alpha_va
################################
  lmw 30,240(1)
  addi 1,1,248
  lwz 0, 4(1)
  mtlr 0
  blr
