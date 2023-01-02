/** drawText(option, fmt, ...)
 * r3 = option
 * r4 = fmt
 */

.macro .opt x y size top bot
  bl 16
  .short \x
  .short \y
  .long \size
  .long \top
  .long \bot
  mflr 3
.endm

.test:

.test.qft:
  lwz r12, gpMarDirector$r13(r13)
  lwz r12, 0x5C(r12)
  mulli r12, r12, 1001
  li r0, 120
  divwu r12, r12, r0
### r7 = ms
  li r0, 1000
  divwu r11, r12, r0
  mulli r10, r11, 1000
  sub r7, r12, r10
### r6 = s
### r5 = m
  li r0, 60
  divwu r5, r11, r0
  mulli r10, r5, 60
  sub r6, r11, r10
## option
  .opt 16 327 30 0xf43464ff 0xf6f6f6ff
## fmt
  bl .qft.fmt.bl
  .asciz "%d:%02d.%03d"
  .align 2; .qft.fmt.bl: mflr r4
## call
  lis r12, drawText@h
  ori r12, r12, drawText@l
  mtlr r12
  blrl

.test.display:
  lwz r12, gpMarioOriginal$r13(r13)
  lfs f1, 0x10(r12)
  lfs f2, 0x14(r12)
  lfs f3, 0x18(r12)
  lfs f4, 0xB0(r12)
  lfs f5, 0xA8(r12)
### r5 = A
  lhz r5, 0x96(r12)
### r6 = C
  lwz r12, gpCamera$r13(r13)
  lhz r6, 0xA6(r12)
  addi r6, r6, -0x8000
### r7 = QF
  lwz r12, gpMarDirector$r13(r13)
  lwz r7, 0x58(r12)
  rlwinm. r7, r7, 0, 0x3
## option
  .opt 16 188 15 0xffffffff 0xffffffff
## fmt
  bl .display.bl
  .asciz "X %.0f\nY %.0f\nZ %.0f\nA %hu\nC %hu\nH %.2f\nV %.2f\nQF %d"
  .align 2; .display.bl: mflr r4
## call
  lis r12, drawText@h
  ori r12, r12, drawText@l
  mtlr r12
  blrl
