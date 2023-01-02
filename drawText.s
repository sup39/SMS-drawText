	.globl drawText
	.type	drawText, @function
drawText:
.LFB0:
	stwu 1,-296(1)
	mflr 0
	stmw 30,288(1)
	mr 31,3
	stw 0,300(1)
	mr 30,4
	stw 5,184(1)
	stw 6,188(1)
	stw 7,192(1)
	stw 8,196(1)
	stw 9,200(1)
	stw 10,204(1)
#bne- 1,.L3
	stfd 1,208(1)
	stfd 2,216(1)
	stfd 3,224(1)
	stfd 4,232(1)
	stfd 5,240(1)
	stfd 6,248(1)
	stfd 7,256(1)
	stfd 8,264(1)
.L3:
  li 9,0x200
	lwz 6,4(31) # opt->fontSize
  sth 9,160(1)
	addi 9,1,304
	stw 9,164(1)
	addi 9,1,176
	stw 9,168(1)
  lwz 4,gpSystemFont$r13(13)
	addi 7,31,8 # opt->colorTop
	li 5,0
	addi 8,31,12 # opt->colorBot
	addi 3,1,8 # &printer
	bl new_J2DPrint
################################
### font size
	lwz 9,4(31)
	stw 9,100(1)
	stw 9,96(1)
################################
### mtx
	addi 3,1,112
### GQR5 = 0x70007 (s16)
#### load (x, y) to f0
  psq_l f0, 0(r31), 0, gqr5
  ps_merge00 f1, f0, f0
  ps_merge11 f2, f0, f0
#### z = 0
  fsubs f3, f0, f0
	bl PSMTXTrans
################################
	li 4,0
	addi 3,1,112
	bl GXLoadPosMtxImm
################################
	addi 6,1,160
	mr 5,30
	li 4,255
	addi 3,1,8
	bl J2DPrint_print_alpha_va
################################
	addi 3,1,112
	bl PSMTXIdentity
################################
	li 4,0
	addi 3,1,112
  lmw 30,288(1)
  addi 1,1,296
  lwz 0, 4(1)
  mtlr 0
  b GXLoadPosMtxImm
