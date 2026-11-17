
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
_entry:
        # set up a stack for C.
        # stack0 is declared in start.c,
        # with a 4096-byte stack per CPU.
        # sp = stack0 + ((hartid + 1) * 4096)
        la sp, stack0
    80000000:	00009117          	auipc	sp,0x9
    80000004:	91010113          	addi	sp,sp,-1776 # 80008910 <stack0>
        li a0, 1024*4
    80000008:	6505                	lui	a0,0x1
        csrr a1, mhartid
    8000000a:	f14025f3          	csrr	a1,mhartid
        addi a1, a1, 1
    8000000e:	0585                	addi	a1,a1,1
        mul a0, a0, a1
    80000010:	02b50533          	mul	a0,a0,a1
        add sp, sp, a0
    80000014:	912a                	add	sp,sp,a0
        # jump to start() in start.c
        call start
    80000016:	042000ef          	jal	80000058 <start>

000000008000001a <spin>:
spin:
        j spin
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <timerinit>:
}

// ask each hart to generate timer interrupts.
void
timerinit()
{
    8000001c:	1141                	addi	sp,sp,-16
    8000001e:	e406                	sd	ra,8(sp)
    80000020:	e022                	sd	s0,0(sp)
    80000022:	0800                	addi	s0,sp,16
static inline uint64
r_menvcfg()
{
  uint64 x;
  // asm volatile("csrr %0, menvcfg" : "=r" (x) );
  asm volatile("csrr %0, 0x30a" : "=r"(x));
    80000024:	30a027f3          	csrr	a5,0x30a
  // enable the sstc extension (i.e. stimecmp).
  w_menvcfg(r_menvcfg() | MENVCFG_STCE);
    80000028:	577d                	li	a4,-1
    8000002a:	177e                	slli	a4,a4,0x3f
    8000002c:	8fd9                	or	a5,a5,a4

static inline void
w_menvcfg(uint64 x)
{
  // asm volatile("csrw menvcfg, %0" : : "r" (x));
  asm volatile("csrw 0x30a, %0" : : "r"(x));
    8000002e:	30a79073          	csrw	0x30a,a5

static inline uint64
r_mcounteren()
{
  uint64 x;
  asm volatile("csrr %0, mcounteren" : "=r"(x));
    80000032:	306027f3          	csrr	a5,mcounteren

  // allow supervisor to use stimecmp and time.
  w_mcounteren(r_mcounteren() | 2);
    80000036:	0027e793          	ori	a5,a5,2
  asm volatile("csrw mcounteren, %0" : : "r"(x));
    8000003a:	30679073          	csrw	mcounteren,a5
// machine-mode cycle counter
static inline uint64
r_time()
{
  uint64 x;
  asm volatile("csrr %0, time" : "=r"(x));
    8000003e:	c01027f3          	rdtime	a5

  // ask for the very first timer interrupt.
  w_stimecmp(r_time() + 1000000);
    80000042:	000f4737          	lui	a4,0xf4
    80000046:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    8000004a:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r"(x));
    8000004c:	14d79073          	csrw	stimecmp,a5
}
    80000050:	60a2                	ld	ra,8(sp)
    80000052:	6402                	ld	s0,0(sp)
    80000054:	0141                	addi	sp,sp,16
    80000056:	8082                	ret

0000000080000058 <start>:
{
    80000058:	1141                	addi	sp,sp,-16
    8000005a:	e406                	sd	ra,8(sp)
    8000005c:	e022                	sd	s0,0(sp)
    8000005e:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r"(x));
    80000060:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80000064:	7779                	lui	a4,0xffffe
    80000066:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffa384f>
    8000006a:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    8000006c:	6705                	lui	a4,0x1
    8000006e:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80000072:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r"(x));
    80000074:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r"(x));
    80000078:	00001797          	auipc	a5,0x1
    8000007c:	de878793          	addi	a5,a5,-536 # 80000e60 <main>
    80000080:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r"(x));
    80000084:	4781                	li	a5,0
    80000086:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r"(x));
    8000008a:	67c1                	lui	a5,0x10
    8000008c:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000008e:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r"(x));
    80000092:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r"(x));
    80000096:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE);
    8000009a:	2207e793          	ori	a5,a5,544
  asm volatile("csrw sie, %0" : : "r"(x));
    8000009e:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r"(x));
    800000a2:	57fd                	li	a5,-1
    800000a4:	83a9                	srli	a5,a5,0xa
    800000a6:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r"(x));
    800000aa:	47bd                	li	a5,15
    800000ac:	3a079073          	csrw	pmpcfg0,a5
  asm volatile("csrr %0, 0x30a" : "=r"(x));
    800000b0:	30a027f3          	csrr	a5,0x30a
  w_menvcfg(r_menvcfg() | MENVCFG_ADUE);
    800000b4:	4705                	li	a4,1
    800000b6:	1776                	slli	a4,a4,0x3d
    800000b8:	8fd9                	or	a5,a5,a4
  asm volatile("csrw 0x30a, %0" : : "r"(x));
    800000ba:	30a79073          	csrw	0x30a,a5
  timerinit();
    800000be:	f5fff0ef          	jal	8000001c <timerinit>
  asm volatile("csrr %0, mhartid" : "=r"(x));
    800000c2:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800000c6:	2781                	sext.w	a5,a5
}

static inline void
w_tp(uint64 x)
{
  asm volatile("mv tp, %0" : : "r"(x));
    800000c8:	823e                	mv	tp,a5
  asm volatile("mret");
    800000ca:	30200073          	mret
}
    800000ce:	60a2                	ld	ra,8(sp)
    800000d0:	6402                	ld	s0,0(sp)
    800000d2:	0141                	addi	sp,sp,16
    800000d4:	8082                	ret

00000000800000d6 <consolewrite>:
// user write() system calls to the console go here.
// uses sleep() and UART interrupts.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    800000d6:	7119                	addi	sp,sp,-128
    800000d8:	fc86                	sd	ra,120(sp)
    800000da:	f8a2                	sd	s0,112(sp)
    800000dc:	f4a6                	sd	s1,104(sp)
    800000de:	0100                	addi	s0,sp,128
  char buf[32]; // move batches from user space to uart.
  int i = 0;

  while (i < n) {
    800000e0:	06c05b63          	blez	a2,80000156 <consolewrite+0x80>
    800000e4:	f0ca                	sd	s2,96(sp)
    800000e6:	ecce                	sd	s3,88(sp)
    800000e8:	e8d2                	sd	s4,80(sp)
    800000ea:	e4d6                	sd	s5,72(sp)
    800000ec:	e0da                	sd	s6,64(sp)
    800000ee:	fc5e                	sd	s7,56(sp)
    800000f0:	f862                	sd	s8,48(sp)
    800000f2:	f466                	sd	s9,40(sp)
    800000f4:	f06a                	sd	s10,32(sp)
    800000f6:	8b2a                	mv	s6,a0
    800000f8:	8bae                	mv	s7,a1
    800000fa:	8a32                	mv	s4,a2
  int i = 0;
    800000fc:	4481                	li	s1,0
    int nn = sizeof(buf);
    if (nn > n - i)
    800000fe:	02000c93          	li	s9,32
    80000102:	02000d13          	li	s10,32
      nn = n - i;
    if (either_copyin(buf, user_src, src + i, nn) == -1)
    80000106:	f8040a93          	addi	s5,s0,-128
    8000010a:	5c7d                	li	s8,-1
    8000010c:	a025                	j	80000134 <consolewrite+0x5e>
    if (nn > n - i)
    8000010e:	0009099b          	sext.w	s3,s2
    if (either_copyin(buf, user_src, src + i, nn) == -1)
    80000112:	86ce                	mv	a3,s3
    80000114:	01748633          	add	a2,s1,s7
    80000118:	85da                	mv	a1,s6
    8000011a:	8556                	mv	a0,s5
    8000011c:	1a6020ef          	jal	800022c2 <either_copyin>
    80000120:	03850d63          	beq	a0,s8,8000015a <consolewrite+0x84>
      break;
    uartwrite(buf, nn);
    80000124:	85ce                	mv	a1,s3
    80000126:	8556                	mv	a0,s5
    80000128:	7d6000ef          	jal	800008fe <uartwrite>
    i += nn;
    8000012c:	009904bb          	addw	s1,s2,s1
  while (i < n) {
    80000130:	0144d963          	bge	s1,s4,80000142 <consolewrite+0x6c>
    if (nn > n - i)
    80000134:	409a07bb          	subw	a5,s4,s1
    80000138:	893e                	mv	s2,a5
    8000013a:	fcfcdae3          	bge	s9,a5,8000010e <consolewrite+0x38>
    8000013e:	896a                	mv	s2,s10
    80000140:	b7f9                	j	8000010e <consolewrite+0x38>
    80000142:	7906                	ld	s2,96(sp)
    80000144:	69e6                	ld	s3,88(sp)
    80000146:	6a46                	ld	s4,80(sp)
    80000148:	6aa6                	ld	s5,72(sp)
    8000014a:	6b06                	ld	s6,64(sp)
    8000014c:	7be2                	ld	s7,56(sp)
    8000014e:	7c42                	ld	s8,48(sp)
    80000150:	7ca2                	ld	s9,40(sp)
    80000152:	7d02                	ld	s10,32(sp)
    80000154:	a821                	j	8000016c <consolewrite+0x96>
  int i = 0;
    80000156:	4481                	li	s1,0
    80000158:	a811                	j	8000016c <consolewrite+0x96>
    8000015a:	7906                	ld	s2,96(sp)
    8000015c:	69e6                	ld	s3,88(sp)
    8000015e:	6a46                	ld	s4,80(sp)
    80000160:	6aa6                	ld	s5,72(sp)
    80000162:	6b06                	ld	s6,64(sp)
    80000164:	7be2                	ld	s7,56(sp)
    80000166:	7c42                	ld	s8,48(sp)
    80000168:	7ca2                	ld	s9,40(sp)
    8000016a:	7d02                	ld	s10,32(sp)
  }

  return i;
}
    8000016c:	8526                	mv	a0,s1
    8000016e:	70e6                	ld	ra,120(sp)
    80000170:	7446                	ld	s0,112(sp)
    80000172:	74a6                	ld	s1,104(sp)
    80000174:	6109                	addi	sp,sp,128
    80000176:	8082                	ret

0000000080000178 <consoleread>:
// user_dst indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80000178:	711d                	addi	sp,sp,-96
    8000017a:	ec86                	sd	ra,88(sp)
    8000017c:	e8a2                	sd	s0,80(sp)
    8000017e:	e4a6                	sd	s1,72(sp)
    80000180:	e0ca                	sd	s2,64(sp)
    80000182:	fc4e                	sd	s3,56(sp)
    80000184:	f852                	sd	s4,48(sp)
    80000186:	f05a                	sd	s6,32(sp)
    80000188:	ec5e                	sd	s7,24(sp)
    8000018a:	1080                	addi	s0,sp,96
    8000018c:	8b2a                	mv	s6,a0
    8000018e:	8a2e                	mv	s4,a1
    80000190:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80000192:	8bb2                	mv	s7,a2
  acquire(&cons.lock);
    80000194:	00010517          	auipc	a0,0x10
    80000198:	77c50513          	addi	a0,a0,1916 # 80010910 <cons>
    8000019c:	25d000ef          	jal	80000bf8 <acquire>
  while (n > 0) {
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while (cons.r == cons.w) {
    800001a0:	00010497          	auipc	s1,0x10
    800001a4:	77048493          	addi	s1,s1,1904 # 80010910 <cons>
      if (killed(myproc())) {
        release(&cons.lock);
        return -1;
      }
      sleep_prepare(&cons.r);
    800001a8:	00011917          	auipc	s2,0x11
    800001ac:	80090913          	addi	s2,s2,-2048 # 800109a8 <cons+0x98>
  while (n > 0) {
    800001b0:	0d305263          	blez	s3,80000274 <consoleread+0xfc>
    while (cons.r == cons.w) {
    800001b4:	0984a783          	lw	a5,152(s1)
    800001b8:	09c4a703          	lw	a4,156(s1)
    800001bc:	0af71763          	bne	a4,a5,8000026a <consoleread+0xf2>
      if (killed(myproc())) {
    800001c0:	722010ef          	jal	800018e2 <myproc>
    800001c4:	781010ef          	jal	80002144 <killed>
    800001c8:	e925                	bnez	a0,80000238 <consoleread+0xc0>
      sleep_prepare(&cons.r);
    800001ca:	854a                	mv	a0,s2
    800001cc:	51f010ef          	jal	80001eea <sleep_prepare>
      release(&cons.lock);
    800001d0:	8526                	mv	a0,s1
    800001d2:	2ab000ef          	jal	80000c7c <release>
      sleep();
    800001d6:	551010ef          	jal	80001f26 <sleep>
      acquire(&cons.lock);
    800001da:	8526                	mv	a0,s1
    800001dc:	21d000ef          	jal	80000bf8 <acquire>
    while (cons.r == cons.w) {
    800001e0:	0984a783          	lw	a5,152(s1)
    800001e4:	09c4a703          	lw	a4,156(s1)
    800001e8:	fcf70ce3          	beq	a4,a5,800001c0 <consoleread+0x48>
    800001ec:	f456                	sd	s5,40(sp)
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    800001ee:	00010717          	auipc	a4,0x10
    800001f2:	72270713          	addi	a4,a4,1826 # 80010910 <cons>
    800001f6:	0017869b          	addiw	a3,a5,1
    800001fa:	08d72c23          	sw	a3,152(a4)
    800001fe:	07f7f693          	andi	a3,a5,127
    80000202:	9736                	add	a4,a4,a3
    80000204:	01874703          	lbu	a4,24(a4)
    80000208:	00070a9b          	sext.w	s5,a4

    if (c == C('D')) { // end-of-file
    8000020c:	4691                	li	a3,4
    8000020e:	04da8663          	beq	s5,a3,8000025a <consoleread+0xe2>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80000212:	fae407a3          	sb	a4,-81(s0)
    if (either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80000216:	4685                	li	a3,1
    80000218:	faf40613          	addi	a2,s0,-81
    8000021c:	85d2                	mv	a1,s4
    8000021e:	855a                	mv	a0,s6
    80000220:	056020ef          	jal	80002276 <either_copyout>
    80000224:	57fd                	li	a5,-1
    80000226:	04f50663          	beq	a0,a5,80000272 <consoleread+0xfa>
      break;

    dst++;
    8000022a:	0a05                	addi	s4,s4,1
    --n;
    8000022c:	39fd                	addiw	s3,s3,-1

    if (c == '\n') {
    8000022e:	47a9                	li	a5,10
    80000230:	04fa8b63          	beq	s5,a5,80000286 <consoleread+0x10e>
    80000234:	7aa2                	ld	s5,40(sp)
    80000236:	bfad                	j	800001b0 <consoleread+0x38>
        release(&cons.lock);
    80000238:	00010517          	auipc	a0,0x10
    8000023c:	6d850513          	addi	a0,a0,1752 # 80010910 <cons>
    80000240:	23d000ef          	jal	80000c7c <release>
        return -1;
    80000244:	557d                	li	a0,-1
    }
  }
  release(&cons.lock);

  return target - n;
}
    80000246:	60e6                	ld	ra,88(sp)
    80000248:	6446                	ld	s0,80(sp)
    8000024a:	64a6                	ld	s1,72(sp)
    8000024c:	6906                	ld	s2,64(sp)
    8000024e:	79e2                	ld	s3,56(sp)
    80000250:	7a42                	ld	s4,48(sp)
    80000252:	7b02                	ld	s6,32(sp)
    80000254:	6be2                	ld	s7,24(sp)
    80000256:	6125                	addi	sp,sp,96
    80000258:	8082                	ret
      if (n < target) {
    8000025a:	0179fa63          	bgeu	s3,s7,8000026e <consoleread+0xf6>
        cons.r--;
    8000025e:	00010717          	auipc	a4,0x10
    80000262:	74f72523          	sw	a5,1866(a4) # 800109a8 <cons+0x98>
    80000266:	7aa2                	ld	s5,40(sp)
    80000268:	a031                	j	80000274 <consoleread+0xfc>
    8000026a:	f456                	sd	s5,40(sp)
    8000026c:	b749                	j	800001ee <consoleread+0x76>
    8000026e:	7aa2                	ld	s5,40(sp)
    80000270:	a011                	j	80000274 <consoleread+0xfc>
    80000272:	7aa2                	ld	s5,40(sp)
  release(&cons.lock);
    80000274:	00010517          	auipc	a0,0x10
    80000278:	69c50513          	addi	a0,a0,1692 # 80010910 <cons>
    8000027c:	201000ef          	jal	80000c7c <release>
  return target - n;
    80000280:	413b853b          	subw	a0,s7,s3
    80000284:	b7c9                	j	80000246 <consoleread+0xce>
    80000286:	7aa2                	ld	s5,40(sp)
    80000288:	b7f5                	j	80000274 <consoleread+0xfc>

000000008000028a <consputc>:
{
    8000028a:	1141                	addi	sp,sp,-16
    8000028c:	e406                	sd	ra,8(sp)
    8000028e:	e022                	sd	s0,0(sp)
    80000290:	0800                	addi	s0,sp,16
  if (c == BACKSPACE) {
    80000292:	10000793          	li	a5,256
    80000296:	00f50863          	beq	a0,a5,800002a6 <consputc+0x1c>
    uartputc_sync(c);
    8000029a:	6ea000ef          	jal	80000984 <uartputc_sync>
}
    8000029e:	60a2                	ld	ra,8(sp)
    800002a0:	6402                	ld	s0,0(sp)
    800002a2:	0141                	addi	sp,sp,16
    800002a4:	8082                	ret
    uartputc_sync('\b');
    800002a6:	4521                	li	a0,8
    800002a8:	6dc000ef          	jal	80000984 <uartputc_sync>
    uartputc_sync(' ');
    800002ac:	02000513          	li	a0,32
    800002b0:	6d4000ef          	jal	80000984 <uartputc_sync>
    uartputc_sync('\b');
    800002b4:	4521                	li	a0,8
    800002b6:	6ce000ef          	jal	80000984 <uartputc_sync>
    800002ba:	b7d5                	j	8000029e <consputc+0x14>

00000000800002bc <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800002bc:	1101                	addi	sp,sp,-32
    800002be:	ec06                	sd	ra,24(sp)
    800002c0:	e822                	sd	s0,16(sp)
    800002c2:	e426                	sd	s1,8(sp)
    800002c4:	1000                	addi	s0,sp,32
    800002c6:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    800002c8:	00010517          	auipc	a0,0x10
    800002cc:	64850513          	addi	a0,a0,1608 # 80010910 <cons>
    800002d0:	129000ef          	jal	80000bf8 <acquire>

  switch (c) {
    800002d4:	47d5                	li	a5,21
    800002d6:	0af48163          	beq	s1,a5,80000378 <consoleintr+0xbc>
    800002da:	0297c563          	blt	a5,s1,80000304 <consoleintr+0x48>
    800002de:	47a1                	li	a5,8
    800002e0:	0ef48663          	beq	s1,a5,800003cc <consoleintr+0x110>
    800002e4:	47c1                	li	a5,16
    800002e6:	10f49763          	bne	s1,a5,800003f4 <consoleintr+0x138>
  case C('P'): // Print process list.
    procdump();
    800002ea:	024020ef          	jal	8000230e <procdump>
      }
    }
    break;
  }

  release(&cons.lock);
    800002ee:	00010517          	auipc	a0,0x10
    800002f2:	62250513          	addi	a0,a0,1570 # 80010910 <cons>
    800002f6:	187000ef          	jal	80000c7c <release>
}
    800002fa:	60e2                	ld	ra,24(sp)
    800002fc:	6442                	ld	s0,16(sp)
    800002fe:	64a2                	ld	s1,8(sp)
    80000300:	6105                	addi	sp,sp,32
    80000302:	8082                	ret
  switch (c) {
    80000304:	07f00793          	li	a5,127
    80000308:	0cf48263          	beq	s1,a5,800003cc <consoleintr+0x110>
    if (c != 0 && cons.e - cons.r < INPUT_BUF_SIZE) {
    8000030c:	00010717          	auipc	a4,0x10
    80000310:	60470713          	addi	a4,a4,1540 # 80010910 <cons>
    80000314:	0a072783          	lw	a5,160(a4)
    80000318:	09872703          	lw	a4,152(a4)
    8000031c:	9f99                	subw	a5,a5,a4
    8000031e:	07f00713          	li	a4,127
    80000322:	fcf766e3          	bltu	a4,a5,800002ee <consoleintr+0x32>
      c = (c == '\r') ? '\n' : c;
    80000326:	47b5                	li	a5,13
    80000328:	0cf48963          	beq	s1,a5,800003fa <consoleintr+0x13e>
      consputc(c);
    8000032c:	8526                	mv	a0,s1
    8000032e:	f5dff0ef          	jal	8000028a <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80000332:	00010717          	auipc	a4,0x10
    80000336:	5de70713          	addi	a4,a4,1502 # 80010910 <cons>
    8000033a:	0a072683          	lw	a3,160(a4)
    8000033e:	0016879b          	addiw	a5,a3,1
    80000342:	863e                	mv	a2,a5
    80000344:	0af72023          	sw	a5,160(a4)
    80000348:	07f6f693          	andi	a3,a3,127
    8000034c:	9736                	add	a4,a4,a3
    8000034e:	00970c23          	sb	s1,24(a4)
      if (c == '\n' || c == C('D') || cons.e - cons.r == INPUT_BUF_SIZE) {
    80000352:	ff648713          	addi	a4,s1,-10
    80000356:	00173713          	seqz	a4,a4
    8000035a:	14f1                	addi	s1,s1,-4
    8000035c:	0014b493          	seqz	s1,s1
    80000360:	8f45                	or	a4,a4,s1
    80000362:	e361                	bnez	a4,80000422 <consoleintr+0x166>
    80000364:	00010717          	auipc	a4,0x10
    80000368:	64472703          	lw	a4,1604(a4) # 800109a8 <cons+0x98>
    8000036c:	9f99                	subw	a5,a5,a4
    8000036e:	08000713          	li	a4,128
    80000372:	f6e79ee3          	bne	a5,a4,800002ee <consoleintr+0x32>
    80000376:	a075                	j	80000422 <consoleintr+0x166>
    80000378:	e04a                	sd	s2,0(sp)
    while (cons.e != cons.w &&
    8000037a:	00010717          	auipc	a4,0x10
    8000037e:	59670713          	addi	a4,a4,1430 # 80010910 <cons>
    80000382:	0a072783          	lw	a5,160(a4)
    80000386:	09c72703          	lw	a4,156(a4)
           cons.buf[(cons.e - 1) % INPUT_BUF_SIZE] != '\n') {
    8000038a:	00010497          	auipc	s1,0x10
    8000038e:	58648493          	addi	s1,s1,1414 # 80010910 <cons>
    while (cons.e != cons.w &&
    80000392:	4929                	li	s2,10
    80000394:	02f70863          	beq	a4,a5,800003c4 <consoleintr+0x108>
           cons.buf[(cons.e - 1) % INPUT_BUF_SIZE] != '\n') {
    80000398:	37fd                	addiw	a5,a5,-1
    8000039a:	07f7f713          	andi	a4,a5,127
    8000039e:	9726                	add	a4,a4,s1
    while (cons.e != cons.w &&
    800003a0:	01874703          	lbu	a4,24(a4)
    800003a4:	03270263          	beq	a4,s2,800003c8 <consoleintr+0x10c>
      cons.e--;
    800003a8:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    800003ac:	10000513          	li	a0,256
    800003b0:	edbff0ef          	jal	8000028a <consputc>
    while (cons.e != cons.w &&
    800003b4:	0a04a783          	lw	a5,160(s1)
    800003b8:	09c4a703          	lw	a4,156(s1)
    800003bc:	fcf71ee3          	bne	a4,a5,80000398 <consoleintr+0xdc>
    800003c0:	6902                	ld	s2,0(sp)
    800003c2:	b735                	j	800002ee <consoleintr+0x32>
    800003c4:	6902                	ld	s2,0(sp)
    800003c6:	b725                	j	800002ee <consoleintr+0x32>
    800003c8:	6902                	ld	s2,0(sp)
    800003ca:	b715                	j	800002ee <consoleintr+0x32>
    if (cons.e != cons.w) {
    800003cc:	00010717          	auipc	a4,0x10
    800003d0:	54470713          	addi	a4,a4,1348 # 80010910 <cons>
    800003d4:	0a072783          	lw	a5,160(a4)
    800003d8:	09c72703          	lw	a4,156(a4)
    800003dc:	f0f709e3          	beq	a4,a5,800002ee <consoleintr+0x32>
      cons.e--;
    800003e0:	37fd                	addiw	a5,a5,-1
    800003e2:	00010717          	auipc	a4,0x10
    800003e6:	5cf72723          	sw	a5,1486(a4) # 800109b0 <cons+0xa0>
      consputc(BACKSPACE);
    800003ea:	10000513          	li	a0,256
    800003ee:	e9dff0ef          	jal	8000028a <consputc>
    800003f2:	bdf5                	j	800002ee <consoleintr+0x32>
    if (c != 0 && cons.e - cons.r < INPUT_BUF_SIZE) {
    800003f4:	ee048de3          	beqz	s1,800002ee <consoleintr+0x32>
    800003f8:	bf11                	j	8000030c <consoleintr+0x50>
      consputc(c);
    800003fa:	4529                	li	a0,10
    800003fc:	e8fff0ef          	jal	8000028a <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80000400:	00010797          	auipc	a5,0x10
    80000404:	51078793          	addi	a5,a5,1296 # 80010910 <cons>
    80000408:	0a07a703          	lw	a4,160(a5)
    8000040c:	0017069b          	addiw	a3,a4,1
    80000410:	8636                	mv	a2,a3
    80000412:	0ad7a023          	sw	a3,160(a5)
    80000416:	07f77713          	andi	a4,a4,127
    8000041a:	97ba                	add	a5,a5,a4
    8000041c:	4729                	li	a4,10
    8000041e:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80000422:	00010797          	auipc	a5,0x10
    80000426:	58c7a523          	sw	a2,1418(a5) # 800109ac <cons+0x9c>
        wakeup(&cons.r);
    8000042a:	00010517          	auipc	a0,0x10
    8000042e:	57e50513          	addi	a0,a0,1406 # 800109a8 <cons+0x98>
    80000432:	325010ef          	jal	80001f56 <wakeup>
    80000436:	bd65                	j	800002ee <consoleintr+0x32>

0000000080000438 <consoleinit>:

void
consoleinit(void)
{
    80000438:	1141                	addi	sp,sp,-16
    8000043a:	e406                	sd	ra,8(sp)
    8000043c:	e022                	sd	s0,0(sp)
    8000043e:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80000440:	00008597          	auipc	a1,0x8
    80000444:	bc058593          	addi	a1,a1,-1088 # 80008000 <etext>
    80000448:	00010517          	auipc	a0,0x10
    8000044c:	4c850513          	addi	a0,a0,1224 # 80010910 <cons>
    80000450:	728000ef          	jal	80000b78 <initlock>

  uartinit();
    80000454:	454000ef          	jal	800008a8 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80000458:	0005a797          	auipc	a5,0x5a
    8000045c:	9c078793          	addi	a5,a5,-1600 # 80059e18 <devsw>
    80000460:	00000717          	auipc	a4,0x0
    80000464:	d1870713          	addi	a4,a4,-744 # 80000178 <consoleread>
    80000468:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    8000046a:	00000717          	auipc	a4,0x0
    8000046e:	c6c70713          	addi	a4,a4,-916 # 800000d6 <consolewrite>
    80000472:	ef98                	sd	a4,24(a5)
}
    80000474:	60a2                	ld	ra,8(sp)
    80000476:	6402                	ld	s0,0(sp)
    80000478:	0141                	addi	sp,sp,16
    8000047a:	8082                	ret

000000008000047c <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(long long xx, int base, int sign)
{
    8000047c:	7139                	addi	sp,sp,-64
    8000047e:	fc06                	sd	ra,56(sp)
    80000480:	f822                	sd	s0,48(sp)
    80000482:	f04a                	sd	s2,32(sp)
    80000484:	0080                	addi	s0,sp,64
  char buf[20];
  int i;
  unsigned long long x;

  if (sign && (sign = (xx < 0)))
    80000486:	c219                	beqz	a2,8000048c <printint+0x10>
    80000488:	08054063          	bltz	a0,80000508 <printint+0x8c>
    x = -xx;
  else
    x = xx;
    8000048c:	4301                	li	t1,0

  i = 0;
    8000048e:	fc840913          	addi	s2,s0,-56
    x = xx;
    80000492:	86ca                	mv	a3,s2
  i = 0;
    80000494:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    80000496:	00008817          	auipc	a6,0x8
    8000049a:	30a80813          	addi	a6,a6,778 # 800087a0 <digits>
    8000049e:	88ba                	mv	a7,a4
    800004a0:	0017061b          	addiw	a2,a4,1
    800004a4:	8732                	mv	a4,a2
    800004a6:	02b577b3          	remu	a5,a0,a1
    800004aa:	97c2                	add	a5,a5,a6
    800004ac:	0007c783          	lbu	a5,0(a5)
    800004b0:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
    800004b4:	87aa                	mv	a5,a0
    800004b6:	02b55533          	divu	a0,a0,a1
    800004ba:	0685                	addi	a3,a3,1
    800004bc:	feb7f1e3          	bgeu	a5,a1,8000049e <printint+0x22>

  if (sign)
    800004c0:	00030b63          	beqz	t1,800004d6 <printint+0x5a>
    buf[i++] = '-';
    800004c4:	fe040793          	addi	a5,s0,-32
    800004c8:	963e                	add	a2,a2,a5
    800004ca:	02d00793          	li	a5,45
    800004ce:	fef60423          	sb	a5,-24(a2)
    800004d2:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
    800004d6:	02e05463          	blez	a4,800004fe <printint+0x82>
    800004da:	f426                	sd	s1,40(sp)
    800004dc:	377d                	addiw	a4,a4,-1
    800004de:	00e904b3          	add	s1,s2,a4
    800004e2:	197d                	addi	s2,s2,-1
    800004e4:	993a                	add	s2,s2,a4
    800004e6:	1702                	slli	a4,a4,0x20
    800004e8:	9301                	srli	a4,a4,0x20
    800004ea:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    800004ee:	0004c503          	lbu	a0,0(s1)
    800004f2:	d99ff0ef          	jal	8000028a <consputc>
  while (--i >= 0)
    800004f6:	14fd                	addi	s1,s1,-1
    800004f8:	ff249be3          	bne	s1,s2,800004ee <printint+0x72>
    800004fc:	74a2                	ld	s1,40(sp)
}
    800004fe:	70e2                	ld	ra,56(sp)
    80000500:	7442                	ld	s0,48(sp)
    80000502:	7902                	ld	s2,32(sp)
    80000504:	6121                	addi	sp,sp,64
    80000506:	8082                	ret
    x = -xx;
    80000508:	40a00533          	neg	a0,a0
  if (sign && (sign = (xx < 0)))
    8000050c:	4305                	li	t1,1
    x = -xx;
    8000050e:	b741                	j	8000048e <printint+0x12>

0000000080000510 <printk>:
}

// Print to the console.
int
printk(char *fmt, ...)
{
    80000510:	7131                	addi	sp,sp,-192
    80000512:	fc86                	sd	ra,120(sp)
    80000514:	f8a2                	sd	s0,112(sp)
    80000516:	f4a6                	sd	s1,104(sp)
    80000518:	0100                	addi	s0,sp,128
    8000051a:	84aa                	mv	s1,a0
    8000051c:	e40c                	sd	a1,8(s0)
    8000051e:	e810                	sd	a2,16(s0)
    80000520:	ec14                	sd	a3,24(s0)
    80000522:	f018                	sd	a4,32(s0)
    80000524:	f41c                	sd	a5,40(s0)
    80000526:	03043823          	sd	a6,48(s0)
    8000052a:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, cx, c0, c1, c2;
  char *s;

  if (panicking == 0)
    8000052e:	00008797          	auipc	a5,0x8
    80000532:	3b67a783          	lw	a5,950(a5) # 800088e4 <panicking>
    80000536:	cf9d                	beqz	a5,80000574 <printk+0x64>
    acquire(&pr.lock);

  va_start(ap, fmt);
    80000538:	00840793          	addi	a5,s0,8
    8000053c:	f8f43423          	sd	a5,-120(s0)
  for (i = 0; (cx = fmt[i] & 0xff) != 0; i++) {
    80000540:	0004c503          	lbu	a0,0(s1)
    80000544:	22050363          	beqz	a0,8000076a <printk+0x25a>
    80000548:	f0ca                	sd	s2,96(sp)
    8000054a:	ecce                	sd	s3,88(sp)
    8000054c:	e8d2                	sd	s4,80(sp)
    8000054e:	e4d6                	sd	s5,72(sp)
    80000550:	e0da                	sd	s6,64(sp)
    80000552:	fc5e                	sd	s7,56(sp)
    80000554:	f862                	sd	s8,48(sp)
    80000556:	f06a                	sd	s10,32(sp)
    80000558:	ec6e                	sd	s11,24(sp)
    8000055a:	4a01                	li	s4,0
    if (cx != '%') {
    8000055c:	02500993          	li	s3,37
      printint(va_arg(ap, uint64), 10, 1);
      i += 1;
    } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
      printint(va_arg(ap, uint64), 10, 1);
      i += 2;
    } else if (c0 == 'u') {
    80000560:	07500c13          	li	s8,117
      printint(va_arg(ap, uint64), 10, 0);
      i += 1;
    } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
      printint(va_arg(ap, uint64), 10, 0);
      i += 2;
    } else if (c0 == 'x') {
    80000564:	07800d13          	li	s10,120
      printint(va_arg(ap, uint64), 16, 0);
      i += 1;
    } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
      printint(va_arg(ap, uint64), 16, 0);
      i += 2;
    } else if (c0 == 'p') {
    80000568:	07000d93          	li	s11,112
      printint(va_arg(ap, uint64), 10, 0);
    8000056c:	4b29                	li	s6,10
    if (c0 == 'd') {
    8000056e:	06400b93          	li	s7,100
    80000572:	a015                	j	80000596 <printk+0x86>
    acquire(&pr.lock);
    80000574:	00010517          	auipc	a0,0x10
    80000578:	44450513          	addi	a0,a0,1092 # 800109b8 <pr>
    8000057c:	67c000ef          	jal	80000bf8 <acquire>
    80000580:	bf65                	j	80000538 <printk+0x28>
      consputc(cx);
    80000582:	d09ff0ef          	jal	8000028a <consputc>
  for (i = 0; (cx = fmt[i] & 0xff) != 0; i++) {
    80000586:	001a079b          	addiw	a5,s4,1
    8000058a:	8a3e                	mv	s4,a5
    8000058c:	97a6                	add	a5,a5,s1
    8000058e:	0007c503          	lbu	a0,0(a5)
    80000592:	1c050363          	beqz	a0,80000758 <printk+0x248>
    if (cx != '%') {
    80000596:	ff3516e3          	bne	a0,s3,80000582 <printk+0x72>
    i++;
    8000059a:	001a091b          	addiw	s2,s4,1
    c0 = fmt[i + 0] & 0xff;
    8000059e:	012487b3          	add	a5,s1,s2
    800005a2:	0007ca83          	lbu	s5,0(a5)
    if (c0)
    800005a6:	200a8763          	beqz	s5,800007b4 <printk+0x2a4>
      c1 = fmt[i + 1] & 0xff;
    800005aa:	0017c703          	lbu	a4,1(a5)
    if (c1)
    800005ae:	1e070a63          	beqz	a4,800007a2 <printk+0x292>
    if (c0 == 'd') {
    800005b2:	037a8963          	beq	s5,s7,800005e4 <printk+0xd4>
    } else if (c0 == 'l' && c1 == 'd') {
    800005b6:	f94a8793          	addi	a5,s5,-108
    800005ba:	0017b793          	seqz	a5,a5
    800005be:	f9c70693          	addi	a3,a4,-100
    800005c2:	0016b693          	seqz	a3,a3
    800005c6:	8efd                	and	a3,a3,a5
    800005c8:	ca9d                	beqz	a3,800005fe <printk+0xee>
      printint(va_arg(ap, uint64), 10, 1);
    800005ca:	f8843783          	ld	a5,-120(s0)
    800005ce:	00878713          	addi	a4,a5,8
    800005d2:	f8e43423          	sd	a4,-120(s0)
    800005d6:	4605                	li	a2,1
    800005d8:	85da                	mv	a1,s6
    800005da:	6388                	ld	a0,0(a5)
    800005dc:	ea1ff0ef          	jal	8000047c <printint>
      i += 1;
    800005e0:	2a09                	addiw	s4,s4,2
    800005e2:	b755                	j	80000586 <printk+0x76>
      printint(va_arg(ap, int), 10, 1);
    800005e4:	f8843783          	ld	a5,-120(s0)
    800005e8:	00878713          	addi	a4,a5,8
    800005ec:	f8e43423          	sd	a4,-120(s0)
    800005f0:	4605                	li	a2,1
    800005f2:	85da                	mv	a1,s6
    800005f4:	4388                	lw	a0,0(a5)
    800005f6:	e87ff0ef          	jal	8000047c <printint>
    i++;
    800005fa:	8a4a                	mv	s4,s2
    800005fc:	b769                	j	80000586 <printk+0x76>
      c2 = fmt[i + 2] & 0xff;
    800005fe:	012486b3          	add	a3,s1,s2
    80000602:	863a                	mv	a2,a4
    80000604:	0026c703          	lbu	a4,2(a3)
    80000608:	aa65                	j	800007c0 <printk+0x2b0>
      printint(va_arg(ap, uint64), 10, 1);
    8000060a:	f8843783          	ld	a5,-120(s0)
    8000060e:	00878713          	addi	a4,a5,8
    80000612:	f8e43423          	sd	a4,-120(s0)
    80000616:	4605                	li	a2,1
    80000618:	45a9                	li	a1,10
    8000061a:	6388                	ld	a0,0(a5)
    8000061c:	e61ff0ef          	jal	8000047c <printint>
      i += 2;
    80000620:	2a0d                	addiw	s4,s4,3
    80000622:	b795                	j	80000586 <printk+0x76>
      printint(va_arg(ap, uint32), 10, 0);
    80000624:	f8843783          	ld	a5,-120(s0)
    80000628:	00878713          	addi	a4,a5,8
    8000062c:	f8e43423          	sd	a4,-120(s0)
    80000630:	4601                	li	a2,0
    80000632:	85da                	mv	a1,s6
    80000634:	0007e503          	lwu	a0,0(a5)
    80000638:	e45ff0ef          	jal	8000047c <printint>
    8000063c:	bf7d                	j	800005fa <printk+0xea>
      printint(va_arg(ap, uint64), 10, 0);
    8000063e:	f8843783          	ld	a5,-120(s0)
    80000642:	00878713          	addi	a4,a5,8
    80000646:	f8e43423          	sd	a4,-120(s0)
    8000064a:	4601                	li	a2,0
    8000064c:	85da                	mv	a1,s6
    8000064e:	6388                	ld	a0,0(a5)
    80000650:	e2dff0ef          	jal	8000047c <printint>
      i += 1;
    80000654:	2a09                	addiw	s4,s4,2
    80000656:	bf05                	j	80000586 <printk+0x76>
      printint(va_arg(ap, uint64), 10, 0);
    80000658:	f8843783          	ld	a5,-120(s0)
    8000065c:	00878713          	addi	a4,a5,8
    80000660:	f8e43423          	sd	a4,-120(s0)
    80000664:	4601                	li	a2,0
    80000666:	45a9                	li	a1,10
    80000668:	6388                	ld	a0,0(a5)
    8000066a:	e13ff0ef          	jal	8000047c <printint>
      i += 2;
    8000066e:	2a0d                	addiw	s4,s4,3
    80000670:	bf19                	j	80000586 <printk+0x76>
      printint(va_arg(ap, uint32), 16, 0);
    80000672:	f8843783          	ld	a5,-120(s0)
    80000676:	00878713          	addi	a4,a5,8
    8000067a:	f8e43423          	sd	a4,-120(s0)
    8000067e:	4601                	li	a2,0
    80000680:	45c1                	li	a1,16
    80000682:	0007e503          	lwu	a0,0(a5)
    80000686:	df7ff0ef          	jal	8000047c <printint>
    8000068a:	bf85                	j	800005fa <printk+0xea>
      printint(va_arg(ap, uint64), 16, 0);
    8000068c:	f8843783          	ld	a5,-120(s0)
    80000690:	00878713          	addi	a4,a5,8
    80000694:	f8e43423          	sd	a4,-120(s0)
    80000698:	4601                	li	a2,0
    8000069a:	45c1                	li	a1,16
    8000069c:	6388                	ld	a0,0(a5)
    8000069e:	ddfff0ef          	jal	8000047c <printint>
      i += 1;
    800006a2:	2a09                	addiw	s4,s4,2
    800006a4:	b5cd                	j	80000586 <printk+0x76>
      printint(va_arg(ap, uint64), 16, 0);
    800006a6:	f8843783          	ld	a5,-120(s0)
    800006aa:	00878713          	addi	a4,a5,8
    800006ae:	f8e43423          	sd	a4,-120(s0)
    800006b2:	45c1                	li	a1,16
    800006b4:	6388                	ld	a0,0(a5)
    800006b6:	dc7ff0ef          	jal	8000047c <printint>
      i += 2;
    800006ba:	2a0d                	addiw	s4,s4,3
    800006bc:	b5e9                	j	80000586 <printk+0x76>
    800006be:	f466                	sd	s9,40(sp)
      printptr(va_arg(ap, uint64));
    800006c0:	f8843783          	ld	a5,-120(s0)
    800006c4:	00878713          	addi	a4,a5,8
    800006c8:	f8e43423          	sd	a4,-120(s0)
    800006cc:	0007ba83          	ld	s5,0(a5)
  consputc('0');
    800006d0:	03000513          	li	a0,48
    800006d4:	bb7ff0ef          	jal	8000028a <consputc>
  consputc('x');
    800006d8:	07800513          	li	a0,120
    800006dc:	bafff0ef          	jal	8000028a <consputc>
    800006e0:	4a41                	li	s4,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800006e2:	00008c97          	auipc	s9,0x8
    800006e6:	0bec8c93          	addi	s9,s9,190 # 800087a0 <digits>
    800006ea:	03cad793          	srli	a5,s5,0x3c
    800006ee:	97e6                	add	a5,a5,s9
    800006f0:	0007c503          	lbu	a0,0(a5)
    800006f4:	b97ff0ef          	jal	8000028a <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800006f8:	0a92                	slli	s5,s5,0x4
    800006fa:	3a7d                	addiw	s4,s4,-1
    800006fc:	fe0a17e3          	bnez	s4,800006ea <printk+0x1da>
    80000700:	7ca2                	ld	s9,40(sp)
    80000702:	bde5                	j	800005fa <printk+0xea>
    } else if (c0 == 'c') {
      consputc(va_arg(ap, uint));
    80000704:	f8843783          	ld	a5,-120(s0)
    80000708:	00878713          	addi	a4,a5,8
    8000070c:	f8e43423          	sd	a4,-120(s0)
    80000710:	4388                	lw	a0,0(a5)
    80000712:	b79ff0ef          	jal	8000028a <consputc>
    80000716:	b5d5                	j	800005fa <printk+0xea>
    } else if (c0 == 's') {
      if ((s = va_arg(ap, char *)) == 0)
    80000718:	f8843783          	ld	a5,-120(s0)
    8000071c:	00878713          	addi	a4,a5,8
    80000720:	f8e43423          	sd	a4,-120(s0)
    80000724:	0007ba03          	ld	s4,0(a5)
    80000728:	000a0d63          	beqz	s4,80000742 <printk+0x232>
        s = "(null)";
      for (; *s; s++)
    8000072c:	000a4503          	lbu	a0,0(s4)
    80000730:	ec0505e3          	beqz	a0,800005fa <printk+0xea>
        consputc(*s);
    80000734:	b57ff0ef          	jal	8000028a <consputc>
      for (; *s; s++)
    80000738:	0a05                	addi	s4,s4,1
    8000073a:	000a4503          	lbu	a0,0(s4)
    8000073e:	f97d                	bnez	a0,80000734 <printk+0x224>
    80000740:	bd6d                	j	800005fa <printk+0xea>
        s = "(null)";
    80000742:	00008a17          	auipc	s4,0x8
    80000746:	8c6a0a13          	addi	s4,s4,-1850 # 80008008 <etext+0x8>
      for (; *s; s++)
    8000074a:	02800513          	li	a0,40
    8000074e:	b7dd                	j	80000734 <printk+0x224>
    } else if (c0 == '%') {
      consputc('%');
    80000750:	8556                	mv	a0,s5
    80000752:	b39ff0ef          	jal	8000028a <consputc>
    80000756:	b555                	j	800005fa <printk+0xea>
    80000758:	7906                	ld	s2,96(sp)
    8000075a:	69e6                	ld	s3,88(sp)
    8000075c:	6a46                	ld	s4,80(sp)
    8000075e:	6aa6                	ld	s5,72(sp)
    80000760:	6b06                	ld	s6,64(sp)
    80000762:	7be2                	ld	s7,56(sp)
    80000764:	7c42                	ld	s8,48(sp)
    80000766:	7d02                	ld	s10,32(sp)
    80000768:	6de2                	ld	s11,24(sp)
      consputc(c0);
    }
  }
  va_end(ap);

  if (panicking == 0)
    8000076a:	00008797          	auipc	a5,0x8
    8000076e:	17a7a783          	lw	a5,378(a5) # 800088e4 <panicking>
    80000772:	c38d                	beqz	a5,80000794 <printk+0x284>
    release(&pr.lock);

  return 0;
}
    80000774:	4501                	li	a0,0
    80000776:	70e6                	ld	ra,120(sp)
    80000778:	7446                	ld	s0,112(sp)
    8000077a:	74a6                	ld	s1,104(sp)
    8000077c:	6129                	addi	sp,sp,192
    8000077e:	8082                	ret
    80000780:	7906                	ld	s2,96(sp)
    80000782:	69e6                	ld	s3,88(sp)
    80000784:	6a46                	ld	s4,80(sp)
    80000786:	6aa6                	ld	s5,72(sp)
    80000788:	6b06                	ld	s6,64(sp)
    8000078a:	7be2                	ld	s7,56(sp)
    8000078c:	7c42                	ld	s8,48(sp)
    8000078e:	7d02                	ld	s10,32(sp)
    80000790:	6de2                	ld	s11,24(sp)
    80000792:	bfe1                	j	8000076a <printk+0x25a>
    release(&pr.lock);
    80000794:	00010517          	auipc	a0,0x10
    80000798:	22450513          	addi	a0,a0,548 # 800109b8 <pr>
    8000079c:	4e0000ef          	jal	80000c7c <release>
  return 0;
    800007a0:	bfd1                	j	80000774 <printk+0x264>
    if (c0 == 'd') {
    800007a2:	e57a81e3          	beq	s5,s7,800005e4 <printk+0xd4>
    } else if (c0 == 'l' && c1 == 'd') {
    800007a6:	f94a8793          	addi	a5,s5,-108
    800007aa:	0017b793          	seqz	a5,a5
    800007ae:	863a                	mv	a2,a4
    } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
    800007b0:	4681                	li	a3,0
    800007b2:	a01d                	j	800007d8 <printk+0x2c8>
    } else if (c0 == 'l' && c1 == 'd') {
    800007b4:	f94a8793          	addi	a5,s5,-108
    800007b8:	0017b793          	seqz	a5,a5
    c1 = c2 = 0;
    800007bc:	8656                	mv	a2,s5
    800007be:	8756                	mv	a4,s5
    } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
    800007c0:	f9460693          	addi	a3,a2,-108
    800007c4:	0016b693          	seqz	a3,a3
    800007c8:	8efd                	and	a3,a3,a5
    800007ca:	f9c70593          	addi	a1,a4,-100
    800007ce:	0015b593          	seqz	a1,a1
    800007d2:	8df5                	and	a1,a1,a3
    800007d4:	e2059be3          	bnez	a1,8000060a <printk+0xfa>
    } else if (c0 == 'u') {
    800007d8:	e58a86e3          	beq	s5,s8,80000624 <printk+0x114>
    } else if (c0 == 'l' && c1 == 'u') {
    800007dc:	f8b60593          	addi	a1,a2,-117
    800007e0:	0015b593          	seqz	a1,a1
    800007e4:	8dfd                	and	a1,a1,a5
    800007e6:	e4059ce3          	bnez	a1,8000063e <printk+0x12e>
    } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
    800007ea:	f8b70593          	addi	a1,a4,-117
    800007ee:	0015b593          	seqz	a1,a1
    800007f2:	8df5                	and	a1,a1,a3
    800007f4:	e60592e3          	bnez	a1,80000658 <printk+0x148>
    } else if (c0 == 'x') {
    800007f8:	e7aa8de3          	beq	s5,s10,80000672 <printk+0x162>
    } else if (c0 == 'l' && c1 == 'x') {
    800007fc:	f8860613          	addi	a2,a2,-120
    80000800:	00163613          	seqz	a2,a2
    80000804:	8e7d                	and	a2,a2,a5
    80000806:	e80613e3          	bnez	a2,8000068c <printk+0x17c>
    } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
    8000080a:	f8870713          	addi	a4,a4,-120
    8000080e:	00173713          	seqz	a4,a4
    80000812:	8f75                	and	a4,a4,a3
    80000814:	e80719e3          	bnez	a4,800006a6 <printk+0x196>
    } else if (c0 == 'p') {
    80000818:	ebba83e3          	beq	s5,s11,800006be <printk+0x1ae>
    } else if (c0 == 'c') {
    8000081c:	06300793          	li	a5,99
    80000820:	eefa82e3          	beq	s5,a5,80000704 <printk+0x1f4>
    } else if (c0 == 's') {
    80000824:	07300793          	li	a5,115
    80000828:	eefa88e3          	beq	s5,a5,80000718 <printk+0x208>
    } else if (c0 == '%') {
    8000082c:	02500793          	li	a5,37
    80000830:	f2fa80e3          	beq	s5,a5,80000750 <printk+0x240>
    } else if (c0 == 0) {
    80000834:	f40a86e3          	beqz	s5,80000780 <printk+0x270>
      consputc('%');
    80000838:	02500513          	li	a0,37
    8000083c:	a4fff0ef          	jal	8000028a <consputc>
      consputc(c0);
    80000840:	8556                	mv	a0,s5
    80000842:	a49ff0ef          	jal	8000028a <consputc>
    80000846:	bb55                	j	800005fa <printk+0xea>

0000000080000848 <panic>:

void
panic(char *s)
{
    80000848:	1101                	addi	sp,sp,-32
    8000084a:	ec06                	sd	ra,24(sp)
    8000084c:	e822                	sd	s0,16(sp)
    8000084e:	e426                	sd	s1,8(sp)
    80000850:	e04a                	sd	s2,0(sp)
    80000852:	1000                	addi	s0,sp,32
    80000854:	892a                	mv	s2,a0
  panicking = 1;
    80000856:	4485                	li	s1,1
    80000858:	00008797          	auipc	a5,0x8
    8000085c:	0897a623          	sw	s1,140(a5) # 800088e4 <panicking>
  printk("panic: ");
    80000860:	00007517          	auipc	a0,0x7
    80000864:	7b850513          	addi	a0,a0,1976 # 80008018 <etext+0x18>
    80000868:	ca9ff0ef          	jal	80000510 <printk>
  printk("%s\n", s);
    8000086c:	85ca                	mv	a1,s2
    8000086e:	00007517          	auipc	a0,0x7
    80000872:	7b250513          	addi	a0,a0,1970 # 80008020 <etext+0x20>
    80000876:	c9bff0ef          	jal	80000510 <printk>
  panicked = 1; // freeze uart output from other CPUs
    8000087a:	00008797          	auipc	a5,0x8
    8000087e:	0697a323          	sw	s1,102(a5) # 800088e0 <panicked>
  for (;;)
    80000882:	a001                	j	80000882 <panic+0x3a>

0000000080000884 <printkinit>:
    ;
}

void
printkinit(void)
{
    80000884:	1141                	addi	sp,sp,-16
    80000886:	e406                	sd	ra,8(sp)
    80000888:	e022                	sd	s0,0(sp)
    8000088a:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    8000088c:	00007597          	auipc	a1,0x7
    80000890:	79c58593          	addi	a1,a1,1948 # 80008028 <etext+0x28>
    80000894:	00010517          	auipc	a0,0x10
    80000898:	12450513          	addi	a0,a0,292 # 800109b8 <pr>
    8000089c:	2dc000ef          	jal	80000b78 <initlock>
}
    800008a0:	60a2                	ld	ra,8(sp)
    800008a2:	6402                	ld	s0,0(sp)
    800008a4:	0141                	addi	sp,sp,16
    800008a6:	8082                	ret

00000000800008a8 <uartinit>:
extern volatile int panicking; // from printk.c
extern volatile int panicked;  // from printk.c

void
uartinit(void)
{
    800008a8:	1141                	addi	sp,sp,-16
    800008aa:	e406                	sd	ra,8(sp)
    800008ac:	e022                	sd	s0,0(sp)
    800008ae:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    800008b0:	100007b7          	lui	a5,0x10000
    800008b4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    800008b8:	10000737          	lui	a4,0x10000
    800008bc:	f8000693          	li	a3,-128
    800008c0:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800008c4:	468d                	li	a3,3
    800008c6:	10000637          	lui	a2,0x10000
    800008ca:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800008ce:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800008d2:	00d701a3          	sb	a3,3(a4)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800008d6:	8732                	mv	a4,a2
    800008d8:	461d                	li	a2,7
    800008da:	00c70123          	sb	a2,2(a4)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800008de:	00d780a3          	sb	a3,1(a5)

  initsleeplock(&tx_lock, "uart");
    800008e2:	00007597          	auipc	a1,0x7
    800008e6:	74e58593          	addi	a1,a1,1870 # 80008030 <etext+0x30>
    800008ea:	00010517          	auipc	a0,0x10
    800008ee:	0e650513          	addi	a0,a0,230 # 800109d0 <tx_lock>
    800008f2:	153030ef          	jal	80004244 <initsleeplock>
}
    800008f6:	60a2                	ld	ra,8(sp)
    800008f8:	6402                	ld	s0,0(sp)
    800008fa:	0141                	addi	sp,sp,16
    800008fc:	8082                	ret

00000000800008fe <uartwrite>:
// transmit buf[] to the uart. it blocks if the
// uart is busy, so it cannot be called from
// interrupts, only from write() system calls.
void
uartwrite(char buf[], int n)
{
    800008fe:	7139                	addi	sp,sp,-64
    80000900:	fc06                	sd	ra,56(sp)
    80000902:	f822                	sd	s0,48(sp)
    80000904:	f04a                	sd	s2,32(sp)
    80000906:	e456                	sd	s5,8(sp)
    80000908:	0080                	addi	s0,sp,64
    8000090a:	8aaa                	mv	s5,a0
    8000090c:	892e                	mv	s2,a1
  acquiresleep(&tx_lock);
    8000090e:	00010517          	auipc	a0,0x10
    80000912:	0c250513          	addi	a0,a0,194 # 800109d0 <tx_lock>
    80000916:	165030ef          	jal	8000427a <acquiresleep>

  int i = 0;
  while (i < n) {
    8000091a:	05205963          	blez	s2,8000096c <uartwrite+0x6e>
    8000091e:	f426                	sd	s1,40(sp)
    80000920:	ec4e                	sd	s3,24(sp)
    80000922:	e852                	sd	s4,16(sp)
    80000924:	e05a                	sd	s6,0(sp)
  int i = 0;
    80000926:	4481                	li	s1,0
    sleep_prepare(&tx_chan);
    80000928:	00008a17          	auipc	s4,0x8
    8000092c:	fc0a0a13          	addi	s4,s4,-64 # 800088e8 <tx_chan>
    if (ReadReg(LSR) & LSR_TX_IDLE) {
    80000930:	100009b7          	lui	s3,0x10000
    80000934:	0995                	addi	s3,s3,5 # 10000005 <_entry-0x6ffffffb>
      WriteReg(THR, buf[i]);
    80000936:	10000b37          	lui	s6,0x10000
    8000093a:	a029                	j	80000944 <uartwrite+0x46>
      i += 1;
    } else {
      sleep();
    8000093c:	5ea010ef          	jal	80001f26 <sleep>
  while (i < n) {
    80000940:	0324d263          	bge	s1,s2,80000964 <uartwrite+0x66>
    sleep_prepare(&tx_chan);
    80000944:	8552                	mv	a0,s4
    80000946:	5a4010ef          	jal	80001eea <sleep_prepare>
    if (ReadReg(LSR) & LSR_TX_IDLE) {
    8000094a:	0009c783          	lbu	a5,0(s3)
    8000094e:	0207f793          	andi	a5,a5,32
    80000952:	d7ed                	beqz	a5,8000093c <uartwrite+0x3e>
      WriteReg(THR, buf[i]);
    80000954:	009a87b3          	add	a5,s5,s1
    80000958:	0007c783          	lbu	a5,0(a5)
    8000095c:	00fb0023          	sb	a5,0(s6) # 10000000 <_entry-0x70000000>
      i += 1;
    80000960:	2485                	addiw	s1,s1,1
    80000962:	bff9                	j	80000940 <uartwrite+0x42>
    80000964:	74a2                	ld	s1,40(sp)
    80000966:	69e2                	ld	s3,24(sp)
    80000968:	6a42                	ld	s4,16(sp)
    8000096a:	6b02                	ld	s6,0(sp)
    }
  }

  releasesleep(&tx_lock);
    8000096c:	00010517          	auipc	a0,0x10
    80000970:	06450513          	addi	a0,a0,100 # 800109d0 <tx_lock>
    80000974:	15b030ef          	jal	800042ce <releasesleep>
}
    80000978:	70e2                	ld	ra,56(sp)
    8000097a:	7442                	ld	s0,48(sp)
    8000097c:	7902                	ld	s2,32(sp)
    8000097e:	6aa2                	ld	s5,8(sp)
    80000980:	6121                	addi	sp,sp,64
    80000982:	8082                	ret

0000000080000984 <uartputc_sync>:
// interrupts, for use by kernel printk() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80000984:	1101                	addi	sp,sp,-32
    80000986:	ec06                	sd	ra,24(sp)
    80000988:	e822                	sd	s0,16(sp)
    8000098a:	e426                	sd	s1,8(sp)
    8000098c:	1000                	addi	s0,sp,32
    8000098e:	84aa                	mv	s1,a0
  if (panicking == 0)
    80000990:	00008797          	auipc	a5,0x8
    80000994:	f547a783          	lw	a5,-172(a5) # 800088e4 <panicking>
    80000998:	cb91                	beqz	a5,800009ac <uartputc_sync+0x28>
    push_off();

  if (panicked) {
    8000099a:	00008797          	auipc	a5,0x8
    8000099e:	f467a783          	lw	a5,-186(a5) # 800088e0 <panicked>
    for (;;)
      ;
  }

  // wait for UART to set Transmit Holding Empty in LSR.
  while ((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800009a2:	10000737          	lui	a4,0x10000
    800009a6:	0715                	addi	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
  if (panicked) {
    800009a8:	c789                	beqz	a5,800009b2 <uartputc_sync+0x2e>
    for (;;)
    800009aa:	a001                	j	800009aa <uartputc_sync+0x26>
    push_off();
    800009ac:	212000ef          	jal	80000bbe <push_off>
    800009b0:	b7ed                	j	8000099a <uartputc_sync+0x16>
  while ((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800009b2:	00074783          	lbu	a5,0(a4)
    800009b6:	0207f793          	andi	a5,a5,32
    800009ba:	dfe5                	beqz	a5,800009b2 <uartputc_sync+0x2e>
    ;
  WriteReg(THR, c);
    800009bc:	100007b7          	lui	a5,0x10000
    800009c0:	00978023          	sb	s1,0(a5) # 10000000 <_entry-0x70000000>

  if (panicking == 0)
    800009c4:	00008797          	auipc	a5,0x8
    800009c8:	f207a783          	lw	a5,-224(a5) # 800088e4 <panicking>
    800009cc:	c791                	beqz	a5,800009d8 <uartputc_sync+0x54>
    pop_off();
}
    800009ce:	60e2                	ld	ra,24(sp)
    800009d0:	6442                	ld	s0,16(sp)
    800009d2:	64a2                	ld	s1,8(sp)
    800009d4:	6105                	addi	sp,sp,32
    800009d6:	8082                	ret
    pop_off();
    800009d8:	25c000ef          	jal	80000c34 <pop_off>
}
    800009dc:	bfcd                	j	800009ce <uartputc_sync+0x4a>

00000000800009de <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    800009de:	1101                	addi	sp,sp,-32
    800009e0:	ec06                	sd	ra,24(sp)
    800009e2:	e822                	sd	s0,16(sp)
    800009e4:	e426                	sd	s1,8(sp)
    800009e6:	e04a                	sd	s2,0(sp)
    800009e8:	1000                	addi	s0,sp,32
  ReadReg(ISR); // acknowledge the interrupt
    800009ea:	100007b7          	lui	a5,0x10000
    800009ee:	0027c783          	lbu	a5,2(a5) # 10000002 <_entry-0x6ffffffe>

  if (ReadReg(LSR) & LSR_TX_IDLE) {
    800009f2:	100007b7          	lui	a5,0x10000
    800009f6:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800009fa:	0207f793          	andi	a5,a5,32
    800009fe:	ef99                	bnez	a5,80000a1c <uartintr+0x3e>
  if (ReadReg(LSR) & LSR_RX_READY) {
    80000a00:	100004b7          	lui	s1,0x10000
    80000a04:	0495                	addi	s1,s1,5 # 10000005 <_entry-0x6ffffffb>
    return ReadReg(RHR);
    80000a06:	10000937          	lui	s2,0x10000
  if (ReadReg(LSR) & LSR_RX_READY) {
    80000a0a:	0004c783          	lbu	a5,0(s1)
    80000a0e:	8b85                	andi	a5,a5,1
    80000a10:	cf89                	beqz	a5,80000a2a <uartintr+0x4c>
  // read and process incoming characters, if any.
  while (1) {
    int c = uartgetc();
    if (c == -1)
      break;
    consoleintr(c);
    80000a12:	00094503          	lbu	a0,0(s2) # 10000000 <_entry-0x70000000>
    80000a16:	8a7ff0ef          	jal	800002bc <consoleintr>
  while (1) {
    80000a1a:	bfc5                	j	80000a0a <uartintr+0x2c>
    wakeup(&tx_chan);
    80000a1c:	00008517          	auipc	a0,0x8
    80000a20:	ecc50513          	addi	a0,a0,-308 # 800088e8 <tx_chan>
    80000a24:	532010ef          	jal	80001f56 <wakeup>
    80000a28:	bfe1                	j	80000a00 <uartintr+0x22>
  }
}
    80000a2a:	60e2                	ld	ra,24(sp)
    80000a2c:	6442                	ld	s0,16(sp)
    80000a2e:	64a2                	ld	s1,8(sp)
    80000a30:	6902                	ld	s2,0(sp)
    80000a32:	6105                	addi	sp,sp,32
    80000a34:	8082                	ret

0000000080000a36 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    80000a36:	1101                	addi	sp,sp,-32
    80000a38:	ec06                	sd	ra,24(sp)
    80000a3a:	e822                	sd	s0,16(sp)
    80000a3c:	e426                	sd	s1,8(sp)
    80000a3e:	e04a                	sd	s2,0(sp)
    80000a40:	1000                	addi	s0,sp,32
  struct run *r;

  if (((uint64)pa % PGSIZE) != 0 || (char *)pa < end || (uint64)pa >= PHYSTOP)
    80000a42:	0005a797          	auipc	a5,0x5a
    80000a46:	56e78793          	addi	a5,a5,1390 # 8005afb0 <end>
    80000a4a:	00f53733          	sltu	a4,a0,a5
    80000a4e:	47c5                	li	a5,17
    80000a50:	07ee                	slli	a5,a5,0x1b
    80000a52:	17fd                	addi	a5,a5,-1
    80000a54:	00a7b7b3          	sltu	a5,a5,a0
    80000a58:	8fd9                	or	a5,a5,a4
    80000a5a:	03451713          	slli	a4,a0,0x34
    80000a5e:	8fd9                	or	a5,a5,a4
    80000a60:	eb9d                	bnez	a5,80000a96 <kfree+0x60>
    80000a62:	84aa                	mv	s1,a0
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000a64:	6605                	lui	a2,0x1
    80000a66:	4585                	li	a1,1
    80000a68:	24c000ef          	jal	80000cb4 <memset>

  r = (struct run *)pa;

  acquire(&kmem.lock);
    80000a6c:	00010917          	auipc	s2,0x10
    80000a70:	f9490913          	addi	s2,s2,-108 # 80010a00 <kmem>
    80000a74:	854a                	mv	a0,s2
    80000a76:	182000ef          	jal	80000bf8 <acquire>
  r->next = kmem.freelist;
    80000a7a:	01893783          	ld	a5,24(s2)
    80000a7e:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000a80:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    80000a84:	854a                	mv	a0,s2
    80000a86:	1f6000ef          	jal	80000c7c <release>
}
    80000a8a:	60e2                	ld	ra,24(sp)
    80000a8c:	6442                	ld	s0,16(sp)
    80000a8e:	64a2                	ld	s1,8(sp)
    80000a90:	6902                	ld	s2,0(sp)
    80000a92:	6105                	addi	sp,sp,32
    80000a94:	8082                	ret
    panic("kfree");
    80000a96:	00007517          	auipc	a0,0x7
    80000a9a:	5a250513          	addi	a0,a0,1442 # 80008038 <etext+0x38>
    80000a9e:	dabff0ef          	jal	80000848 <panic>

0000000080000aa2 <freerange>:
{
    80000aa2:	7179                	addi	sp,sp,-48
    80000aa4:	f406                	sd	ra,40(sp)
    80000aa6:	f022                	sd	s0,32(sp)
    80000aa8:	ec26                	sd	s1,24(sp)
    80000aaa:	1800                	addi	s0,sp,48
  p = (char *)PGROUNDUP((uint64)pa_start);
    80000aac:	6785                	lui	a5,0x1
    80000aae:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    80000ab2:	00e504b3          	add	s1,a0,a4
    80000ab6:	777d                	lui	a4,0xfffff
    80000ab8:	8cf9                	and	s1,s1,a4
  for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
    80000aba:	94be                	add	s1,s1,a5
    80000abc:	0295e263          	bltu	a1,s1,80000ae0 <freerange+0x3e>
    80000ac0:	e84a                	sd	s2,16(sp)
    80000ac2:	e44e                	sd	s3,8(sp)
    80000ac4:	e052                	sd	s4,0(sp)
    80000ac6:	892e                	mv	s2,a1
    kfree(p);
    80000ac8:	8a3a                	mv	s4,a4
  for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
    80000aca:	89be                	mv	s3,a5
    kfree(p);
    80000acc:	01448533          	add	a0,s1,s4
    80000ad0:	f67ff0ef          	jal	80000a36 <kfree>
  for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
    80000ad4:	94ce                	add	s1,s1,s3
    80000ad6:	fe997be3          	bgeu	s2,s1,80000acc <freerange+0x2a>
    80000ada:	6942                	ld	s2,16(sp)
    80000adc:	69a2                	ld	s3,8(sp)
    80000ade:	6a02                	ld	s4,0(sp)
}
    80000ae0:	70a2                	ld	ra,40(sp)
    80000ae2:	7402                	ld	s0,32(sp)
    80000ae4:	64e2                	ld	s1,24(sp)
    80000ae6:	6145                	addi	sp,sp,48
    80000ae8:	8082                	ret

0000000080000aea <kinit>:
{
    80000aea:	1141                	addi	sp,sp,-16
    80000aec:	e406                	sd	ra,8(sp)
    80000aee:	e022                	sd	s0,0(sp)
    80000af0:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000af2:	00007597          	auipc	a1,0x7
    80000af6:	54e58593          	addi	a1,a1,1358 # 80008040 <etext+0x40>
    80000afa:	00010517          	auipc	a0,0x10
    80000afe:	f0650513          	addi	a0,a0,-250 # 80010a00 <kmem>
    80000b02:	076000ef          	jal	80000b78 <initlock>
  freerange(end, (void *)PHYSTOP);
    80000b06:	45c5                	li	a1,17
    80000b08:	05ee                	slli	a1,a1,0x1b
    80000b0a:	0005a517          	auipc	a0,0x5a
    80000b0e:	4a650513          	addi	a0,a0,1190 # 8005afb0 <end>
    80000b12:	f91ff0ef          	jal	80000aa2 <freerange>
}
    80000b16:	60a2                	ld	ra,8(sp)
    80000b18:	6402                	ld	s0,0(sp)
    80000b1a:	0141                	addi	sp,sp,16
    80000b1c:	8082                	ret

0000000080000b1e <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000b1e:	1101                	addi	sp,sp,-32
    80000b20:	ec06                	sd	ra,24(sp)
    80000b22:	e822                	sd	s0,16(sp)
    80000b24:	e426                	sd	s1,8(sp)
    80000b26:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000b28:	00010517          	auipc	a0,0x10
    80000b2c:	ed850513          	addi	a0,a0,-296 # 80010a00 <kmem>
    80000b30:	0c8000ef          	jal	80000bf8 <acquire>
  r = kmem.freelist;
    80000b34:	00010497          	auipc	s1,0x10
    80000b38:	ee44b483          	ld	s1,-284(s1) # 80010a18 <kmem+0x18>
  if (r)
    80000b3c:	c49d                	beqz	s1,80000b6a <kalloc+0x4c>
    kmem.freelist = r->next;
    80000b3e:	609c                	ld	a5,0(s1)
    80000b40:	00010717          	auipc	a4,0x10
    80000b44:	ecf73c23          	sd	a5,-296(a4) # 80010a18 <kmem+0x18>
  release(&kmem.lock);
    80000b48:	00010517          	auipc	a0,0x10
    80000b4c:	eb850513          	addi	a0,a0,-328 # 80010a00 <kmem>
    80000b50:	12c000ef          	jal	80000c7c <release>

  if (r)
    memset((char *)r, 5, PGSIZE); // fill with junk
    80000b54:	6605                	lui	a2,0x1
    80000b56:	4595                	li	a1,5
    80000b58:	8526                	mv	a0,s1
    80000b5a:	15a000ef          	jal	80000cb4 <memset>
  return (void *)r;
}
    80000b5e:	8526                	mv	a0,s1
    80000b60:	60e2                	ld	ra,24(sp)
    80000b62:	6442                	ld	s0,16(sp)
    80000b64:	64a2                	ld	s1,8(sp)
    80000b66:	6105                	addi	sp,sp,32
    80000b68:	8082                	ret
  release(&kmem.lock);
    80000b6a:	00010517          	auipc	a0,0x10
    80000b6e:	e9650513          	addi	a0,a0,-362 # 80010a00 <kmem>
    80000b72:	10a000ef          	jal	80000c7c <release>
  if (r)
    80000b76:	b7e5                	j	80000b5e <kalloc+0x40>

0000000080000b78 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80000b78:	1141                	addi	sp,sp,-16
    80000b7a:	e406                	sd	ra,8(sp)
    80000b7c:	e022                	sd	s0,0(sp)
    80000b7e:	0800                	addi	s0,sp,16
  lk->name = name;
    80000b80:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80000b82:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80000b86:	00053823          	sd	zero,16(a0)
}
    80000b8a:	60a2                	ld	ra,8(sp)
    80000b8c:	6402                	ld	s0,0(sp)
    80000b8e:	0141                	addi	sp,sp,16
    80000b90:	8082                	ret

0000000080000b92 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80000b92:	411c                	lw	a5,0(a0)
    80000b94:	e399                	bnez	a5,80000b9a <holding+0x8>
    80000b96:	4501                	li	a0,0
  return r;
}
    80000b98:	8082                	ret
{
    80000b9a:	1101                	addi	sp,sp,-32
    80000b9c:	ec06                	sd	ra,24(sp)
    80000b9e:	e822                	sd	s0,16(sp)
    80000ba0:	e426                	sd	s1,8(sp)
    80000ba2:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80000ba4:	691c                	ld	a5,16(a0)
    80000ba6:	84be                	mv	s1,a5
    80000ba8:	51b000ef          	jal	800018c2 <mycpu>
    80000bac:	40a48533          	sub	a0,s1,a0
    80000bb0:	00153513          	seqz	a0,a0
}
    80000bb4:	60e2                	ld	ra,24(sp)
    80000bb6:	6442                	ld	s0,16(sp)
    80000bb8:	64a2                	ld	s1,8(sp)
    80000bba:	6105                	addi	sp,sp,32
    80000bbc:	8082                	ret

0000000080000bbe <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80000bbe:	1101                	addi	sp,sp,-32
    80000bc0:	ec06                	sd	ra,24(sp)
    80000bc2:	e822                	sd	s0,16(sp)
    80000bc4:	e426                	sd	s1,8(sp)
    80000bc6:	1000                	addi	s0,sp,32
  __asm__ __volatile__("csrrc %0, sstatus, %1" : "=r"(x) : "rK"(x) : "memory");
    80000bc8:	100177f3          	csrrci	a5,sstatus,2
    80000bcc:	84be                	mv	s1,a5
  // disable interrupts to prevent an involuntary context
  // switch while using mycpu().
  uint64 flags = rc_sstatus(SSTATUS_SIE);
  int old = !!(flags & SSTATUS_SIE);

  if (mycpu()->noff == 0)
    80000bce:	4f5000ef          	jal	800018c2 <mycpu>
    80000bd2:	5d3c                	lw	a5,120(a0)
    80000bd4:	cb99                	beqz	a5,80000bea <push_off+0x2c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80000bd6:	4ed000ef          	jal	800018c2 <mycpu>
    80000bda:	5d3c                	lw	a5,120(a0)
    80000bdc:	2785                	addiw	a5,a5,1
    80000bde:	dd3c                	sw	a5,120(a0)
}
    80000be0:	60e2                	ld	ra,24(sp)
    80000be2:	6442                	ld	s0,16(sp)
    80000be4:	64a2                	ld	s1,8(sp)
    80000be6:	6105                	addi	sp,sp,32
    80000be8:	8082                	ret
    mycpu()->intena = old;
    80000bea:	4d9000ef          	jal	800018c2 <mycpu>
  int old = !!(flags & SSTATUS_SIE);
    80000bee:	0014d793          	srli	a5,s1,0x1
    80000bf2:	8b85                	andi	a5,a5,1
    mycpu()->intena = old;
    80000bf4:	dd7c                	sw	a5,124(a0)
    80000bf6:	b7c5                	j	80000bd6 <push_off+0x18>

0000000080000bf8 <acquire>:
{
    80000bf8:	1101                	addi	sp,sp,-32
    80000bfa:	ec06                	sd	ra,24(sp)
    80000bfc:	e822                	sd	s0,16(sp)
    80000bfe:	e426                	sd	s1,8(sp)
    80000c00:	1000                	addi	s0,sp,32
    80000c02:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80000c04:	fbbff0ef          	jal	80000bbe <push_off>
  if (holding(lk))
    80000c08:	8526                	mv	a0,s1
    80000c0a:	f89ff0ef          	jal	80000b92 <holding>
  while (__atomic_exchange_n(&lk->locked, 1, __ATOMIC_ACQUIRE) != 0)
    80000c0e:	4705                	li	a4,1
  if (holding(lk))
    80000c10:	ed01                	bnez	a0,80000c28 <acquire+0x30>
  while (__atomic_exchange_n(&lk->locked, 1, __ATOMIC_ACQUIRE) != 0)
    80000c12:	0ce4a7af          	amoswap.w.aq	a5,a4,(s1)
    80000c16:	fff5                	bnez	a5,80000c12 <acquire+0x1a>
  lk->cpu = mycpu();
    80000c18:	4ab000ef          	jal	800018c2 <mycpu>
    80000c1c:	e888                	sd	a0,16(s1)
}
    80000c1e:	60e2                	ld	ra,24(sp)
    80000c20:	6442                	ld	s0,16(sp)
    80000c22:	64a2                	ld	s1,8(sp)
    80000c24:	6105                	addi	sp,sp,32
    80000c26:	8082                	ret
    panic("acquire");
    80000c28:	00007517          	auipc	a0,0x7
    80000c2c:	42050513          	addi	a0,a0,1056 # 80008048 <etext+0x48>
    80000c30:	c19ff0ef          	jal	80000848 <panic>

0000000080000c34 <pop_off>:

void
pop_off(void)
{
    80000c34:	1141                	addi	sp,sp,-16
    80000c36:	e406                	sd	ra,8(sp)
    80000c38:	e022                	sd	s0,0(sp)
    80000c3a:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80000c3c:	487000ef          	jal	800018c2 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r"(x));
    80000c40:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80000c44:	8b89                	andi	a5,a5,2
  if (intr_get())
    80000c46:	ef99                	bnez	a5,80000c64 <pop_off+0x30>
    panic("pop_off - interruptible");
  if (c->noff < 1)
    80000c48:	5d3c                	lw	a5,120(a0)
    80000c4a:	02f05363          	blez	a5,80000c70 <pop_off+0x3c>
    panic("pop_off");
  c->noff -= 1;
    80000c4e:	37fd                	addiw	a5,a5,-1
    80000c50:	dd3c                	sw	a5,120(a0)
  if (c->noff == 0 && c->intena)
    80000c52:	e789                	bnez	a5,80000c5c <pop_off+0x28>
    80000c54:	5d7c                	lw	a5,124(a0)
    80000c56:	c399                	beqz	a5,80000c5c <pop_off+0x28>
  __asm__ __volatile__("csrs sstatus, %0" ::"rK"(x) : "memory");
    80000c58:	10016073          	csrsi	sstatus,2
    intr_on();
}
    80000c5c:	60a2                	ld	ra,8(sp)
    80000c5e:	6402                	ld	s0,0(sp)
    80000c60:	0141                	addi	sp,sp,16
    80000c62:	8082                	ret
    panic("pop_off - interruptible");
    80000c64:	00007517          	auipc	a0,0x7
    80000c68:	3ec50513          	addi	a0,a0,1004 # 80008050 <etext+0x50>
    80000c6c:	bddff0ef          	jal	80000848 <panic>
    panic("pop_off");
    80000c70:	00007517          	auipc	a0,0x7
    80000c74:	3f850513          	addi	a0,a0,1016 # 80008068 <etext+0x68>
    80000c78:	bd1ff0ef          	jal	80000848 <panic>

0000000080000c7c <release>:
{
    80000c7c:	1101                	addi	sp,sp,-32
    80000c7e:	ec06                	sd	ra,24(sp)
    80000c80:	e822                	sd	s0,16(sp)
    80000c82:	e426                	sd	s1,8(sp)
    80000c84:	1000                	addi	s0,sp,32
    80000c86:	84aa                	mv	s1,a0
  if (!holding(lk))
    80000c88:	f0bff0ef          	jal	80000b92 <holding>
    80000c8c:	cd11                	beqz	a0,80000ca8 <release+0x2c>
  lk->cpu = 0;
    80000c8e:	0004b823          	sd	zero,16(s1)
  __atomic_store_n(&lk->locked, 0, __ATOMIC_RELEASE);
    80000c92:	0310000f          	fence	rw,w
    80000c96:	0004a023          	sw	zero,0(s1)
  pop_off();
    80000c9a:	f9bff0ef          	jal	80000c34 <pop_off>
}
    80000c9e:	60e2                	ld	ra,24(sp)
    80000ca0:	6442                	ld	s0,16(sp)
    80000ca2:	64a2                	ld	s1,8(sp)
    80000ca4:	6105                	addi	sp,sp,32
    80000ca6:	8082                	ret
    panic("release");
    80000ca8:	00007517          	auipc	a0,0x7
    80000cac:	3c850513          	addi	a0,a0,968 # 80008070 <etext+0x70>
    80000cb0:	b99ff0ef          	jal	80000848 <panic>

0000000080000cb4 <memset>:
#include "types.h"

void *
memset(void *dst, int c, uint n)
{
    80000cb4:	1141                	addi	sp,sp,-16
    80000cb6:	e406                	sd	ra,8(sp)
    80000cb8:	e022                	sd	s0,0(sp)
    80000cba:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
    80000cbc:	ca19                	beqz	a2,80000cd2 <memset+0x1e>
    80000cbe:	87aa                	mv	a5,a0
    80000cc0:	1602                	slli	a2,a2,0x20
    80000cc2:	9201                	srli	a2,a2,0x20
    80000cc4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000cc8:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
    80000ccc:	0785                	addi	a5,a5,1
    80000cce:	fee79de3          	bne	a5,a4,80000cc8 <memset+0x14>
  }
  return dst;
}
    80000cd2:	60a2                	ld	ra,8(sp)
    80000cd4:	6402                	ld	s0,0(sp)
    80000cd6:	0141                	addi	sp,sp,16
    80000cd8:	8082                	ret

0000000080000cda <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000cda:	1141                	addi	sp,sp,-16
    80000cdc:	e406                	sd	ra,8(sp)
    80000cde:	e022                	sd	s0,0(sp)
    80000ce0:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while (n-- > 0) {
    80000ce2:	ce19                	beqz	a2,80000d00 <memcmp+0x26>
    80000ce4:	1602                	slli	a2,a2,0x20
    80000ce6:	9201                	srli	a2,a2,0x20
    80000ce8:	00c506b3          	add	a3,a0,a2
    if (*s1 != *s2)
    80000cec:	00054783          	lbu	a5,0(a0)
    80000cf0:	0005c703          	lbu	a4,0(a1)
    80000cf4:	00e79b63          	bne	a5,a4,80000d0a <memcmp+0x30>
      return *s1 - *s2;
    s1++, s2++;
    80000cf8:	0505                	addi	a0,a0,1
    80000cfa:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    80000cfc:	fed518e3          	bne	a0,a3,80000cec <memcmp+0x12>
  }

  return 0;
    80000d00:	4501                	li	a0,0
}
    80000d02:	60a2                	ld	ra,8(sp)
    80000d04:	6402                	ld	s0,0(sp)
    80000d06:	0141                	addi	sp,sp,16
    80000d08:	8082                	ret
      return *s1 - *s2;
    80000d0a:	40e7853b          	subw	a0,a5,a4
    80000d0e:	bfd5                	j	80000d02 <memcmp+0x28>

0000000080000d10 <memmove>:

void *
memmove(void *dst, const void *src, uint n)
{
    80000d10:	1141                	addi	sp,sp,-16
    80000d12:	e406                	sd	ra,8(sp)
    80000d14:	e022                	sd	s0,0(sp)
    80000d16:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if (n == 0)
    80000d18:	c61d                	beqz	a2,80000d46 <memmove+0x36>
    return dst;

  s = src;
  d = dst;
  if (s < d && s + n > d) {
    80000d1a:	00a5f963          	bgeu	a1,a0,80000d2c <memmove+0x1c>
    80000d1e:	02061693          	slli	a3,a2,0x20
    80000d22:	9281                	srli	a3,a3,0x20
    80000d24:	00d58733          	add	a4,a1,a3
    80000d28:	02e56363          	bltu	a0,a4,80000d4e <memmove+0x3e>
    s += n;
    d += n;
    while (n-- > 0)
      *--d = *--s;
  } else
    while (n-- > 0)
    80000d2c:	1602                	slli	a2,a2,0x20
    80000d2e:	9201                	srli	a2,a2,0x20
    80000d30:	00c587b3          	add	a5,a1,a2
{
    80000d34:	872a                	mv	a4,a0
      *d++ = *s++;
    80000d36:	0585                	addi	a1,a1,1
    80000d38:	0705                	addi	a4,a4,1
    80000d3a:	fff5c683          	lbu	a3,-1(a1)
    80000d3e:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
    80000d42:	fef59ae3          	bne	a1,a5,80000d36 <memmove+0x26>

  return dst;
}
    80000d46:	60a2                	ld	ra,8(sp)
    80000d48:	6402                	ld	s0,0(sp)
    80000d4a:	0141                	addi	sp,sp,16
    80000d4c:	8082                	ret
    d += n;
    80000d4e:	96aa                	add	a3,a3,a0
    while (n-- > 0)
    80000d50:	fff6079b          	addiw	a5,a2,-1 # fff <_entry-0x7ffff001>
    80000d54:	1782                	slli	a5,a5,0x20
    80000d56:	9381                	srli	a5,a5,0x20
    80000d58:	fff7c793          	not	a5,a5
    80000d5c:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000d5e:	177d                	addi	a4,a4,-1
    80000d60:	16fd                	addi	a3,a3,-1
    80000d62:	00074603          	lbu	a2,0(a4)
    80000d66:	00c68023          	sb	a2,0(a3)
    while (n-- > 0)
    80000d6a:	fee79ae3          	bne	a5,a4,80000d5e <memmove+0x4e>
    80000d6e:	bfe1                	j	80000d46 <memmove+0x36>

0000000080000d70 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void *
memcpy(void *dst, const void *src, uint n)
{
    80000d70:	1141                	addi	sp,sp,-16
    80000d72:	e406                	sd	ra,8(sp)
    80000d74:	e022                	sd	s0,0(sp)
    80000d76:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000d78:	f99ff0ef          	jal	80000d10 <memmove>
}
    80000d7c:	60a2                	ld	ra,8(sp)
    80000d7e:	6402                	ld	s0,0(sp)
    80000d80:	0141                	addi	sp,sp,16
    80000d82:	8082                	ret

0000000080000d84 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000d84:	1141                	addi	sp,sp,-16
    80000d86:	e406                	sd	ra,8(sp)
    80000d88:	e022                	sd	s0,0(sp)
    80000d8a:	0800                	addi	s0,sp,16
  while (n > 0 && *p && *p == *q)
    80000d8c:	ce01                	beqz	a2,80000da4 <strncmp+0x20>
    80000d8e:	00054783          	lbu	a5,0(a0)
    80000d92:	cb99                	beqz	a5,80000da8 <strncmp+0x24>
    80000d94:	0005c703          	lbu	a4,0(a1)
    80000d98:	00f71863          	bne	a4,a5,80000da8 <strncmp+0x24>
    n--, p++, q++;
    80000d9c:	367d                	addiw	a2,a2,-1
    80000d9e:	0505                	addi	a0,a0,1
    80000da0:	0585                	addi	a1,a1,1
  while (n > 0 && *p && *p == *q)
    80000da2:	f675                	bnez	a2,80000d8e <strncmp+0xa>
  if (n == 0)
    return 0;
    80000da4:	4501                	li	a0,0
    80000da6:	a031                	j	80000db2 <strncmp+0x2e>
  return (uchar)*p - (uchar)*q;
    80000da8:	00054503          	lbu	a0,0(a0)
    80000dac:	0005c783          	lbu	a5,0(a1)
    80000db0:	9d1d                	subw	a0,a0,a5
}
    80000db2:	60a2                	ld	ra,8(sp)
    80000db4:	6402                	ld	s0,0(sp)
    80000db6:	0141                	addi	sp,sp,16
    80000db8:	8082                	ret

0000000080000dba <strncpy>:

char *
strncpy(char *s, const char *t, int n)
{
    80000dba:	1141                	addi	sp,sp,-16
    80000dbc:	e406                	sd	ra,8(sp)
    80000dbe:	e022                	sd	s0,0(sp)
    80000dc0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while (n-- > 0 && (*s++ = *t++) != 0)
    80000dc2:	87aa                	mv	a5,a0
    80000dc4:	a011                	j	80000dc8 <strncpy+0xe>
    80000dc6:	8636                	mv	a2,a3
    80000dc8:	02c05763          	blez	a2,80000df6 <strncpy+0x3c>
    80000dcc:	fff6069b          	addiw	a3,a2,-1
    80000dd0:	0785                	addi	a5,a5,1
    80000dd2:	0005c703          	lbu	a4,0(a1)
    80000dd6:	fee78fa3          	sb	a4,-1(a5)
    80000dda:	0585                	addi	a1,a1,1
    80000ddc:	f76d                	bnez	a4,80000dc6 <strncpy+0xc>
    ;
  while (n-- > 0)
    80000dde:	873e                	mv	a4,a5
    80000de0:	00d05b63          	blez	a3,80000df6 <strncpy+0x3c>
    80000de4:	9fb1                	addw	a5,a5,a2
    80000de6:	37fd                	addiw	a5,a5,-1
    *s++ = 0;
    80000de8:	0705                	addi	a4,a4,1
    80000dea:	fe070fa3          	sb	zero,-1(a4)
  while (n-- > 0)
    80000dee:	40e786bb          	subw	a3,a5,a4
    80000df2:	fed04be3          	bgtz	a3,80000de8 <strncpy+0x2e>
  return os;
}
    80000df6:	60a2                	ld	ra,8(sp)
    80000df8:	6402                	ld	s0,0(sp)
    80000dfa:	0141                	addi	sp,sp,16
    80000dfc:	8082                	ret

0000000080000dfe <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char *
safestrcpy(char *s, const char *t, int n)
{
    80000dfe:	1141                	addi	sp,sp,-16
    80000e00:	e406                	sd	ra,8(sp)
    80000e02:	e022                	sd	s0,0(sp)
    80000e04:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if (n <= 0)
    80000e06:	02c05363          	blez	a2,80000e2c <safestrcpy+0x2e>
    80000e0a:	fff6069b          	addiw	a3,a2,-1
    80000e0e:	1682                	slli	a3,a3,0x20
    80000e10:	9281                	srli	a3,a3,0x20
    80000e12:	96ae                	add	a3,a3,a1
    80000e14:	87aa                	mv	a5,a0
    return os;
  while (--n > 0 && (*s++ = *t++) != 0)
    80000e16:	00d58963          	beq	a1,a3,80000e28 <safestrcpy+0x2a>
    80000e1a:	0585                	addi	a1,a1,1
    80000e1c:	0785                	addi	a5,a5,1
    80000e1e:	fff5c703          	lbu	a4,-1(a1)
    80000e22:	fee78fa3          	sb	a4,-1(a5)
    80000e26:	fb65                	bnez	a4,80000e16 <safestrcpy+0x18>
    ;
  *s = 0;
    80000e28:	00078023          	sb	zero,0(a5)
  return os;
}
    80000e2c:	60a2                	ld	ra,8(sp)
    80000e2e:	6402                	ld	s0,0(sp)
    80000e30:	0141                	addi	sp,sp,16
    80000e32:	8082                	ret

0000000080000e34 <strlen>:

int
strlen(const char *s)
{
    80000e34:	1141                	addi	sp,sp,-16
    80000e36:	e406                	sd	ra,8(sp)
    80000e38:	e022                	sd	s0,0(sp)
    80000e3a:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
    80000e3c:	00054783          	lbu	a5,0(a0)
    80000e40:	cf91                	beqz	a5,80000e5c <strlen+0x28>
    80000e42:	00150793          	addi	a5,a0,1
    80000e46:	86be                	mv	a3,a5
    80000e48:	0785                	addi	a5,a5,1
    80000e4a:	fff7c703          	lbu	a4,-1(a5)
    80000e4e:	ff65                	bnez	a4,80000e46 <strlen+0x12>
    80000e50:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
    80000e54:	60a2                	ld	ra,8(sp)
    80000e56:	6402                	ld	s0,0(sp)
    80000e58:	0141                	addi	sp,sp,16
    80000e5a:	8082                	ret
  for (n = 0; s[n]; n++)
    80000e5c:	4501                	li	a0,0
    80000e5e:	bfdd                	j	80000e54 <strlen+0x20>

0000000080000e60 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000e60:	1141                	addi	sp,sp,-16
    80000e62:	e406                	sd	ra,8(sp)
    80000e64:	e022                	sd	s0,0(sp)
    80000e66:	0800                	addi	s0,sp,16
  if (cpuid() == 0) {
    80000e68:	247000ef          	jal	800018ae <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();         // first user process

    __atomic_store_n(&started, 1, __ATOMIC_RELEASE);
  } else {
    while (__atomic_load_n(&started, __ATOMIC_ACQUIRE) == 0)
    80000e6c:	00008717          	auipc	a4,0x8
    80000e70:	a8070713          	addi	a4,a4,-1408 # 800088ec <started>
  if (cpuid() == 0) {
    80000e74:	c51d                	beqz	a0,80000ea2 <main+0x42>
    while (__atomic_load_n(&started, __ATOMIC_ACQUIRE) == 0)
    80000e76:	431c                	lw	a5,0(a4)
    80000e78:	0230000f          	fence	r,rw
    80000e7c:	2781                	sext.w	a5,a5
    80000e7e:	dfe5                	beqz	a5,80000e76 <main+0x16>
      ;

    printk("hart %d starting\n", cpuid());
    80000e80:	22f000ef          	jal	800018ae <cpuid>
    80000e84:	85aa                	mv	a1,a0
    80000e86:	00007517          	auipc	a0,0x7
    80000e8a:	20a50513          	addi	a0,a0,522 # 80008090 <etext+0x90>
    80000e8e:	e82ff0ef          	jal	80000510 <printk>
    kvminithart();  // turn on paging
    80000e92:	082000ef          	jal	80000f14 <kvminithart>
    trapinithart(); // install kernel trap vector
    80000e96:	5a6010ef          	jal	8000243c <trapinithart>
    plicinithart(); // ask PLIC for device interrupts
    80000e9a:	65f040ef          	jal	80005cf8 <plicinithart>
  }

  scheduler();
    80000e9e:	6b7000ef          	jal	80001d54 <scheduler>
    consoleinit();
    80000ea2:	d96ff0ef          	jal	80000438 <consoleinit>
    printkinit();
    80000ea6:	9dfff0ef          	jal	80000884 <printkinit>
    printk("\n");
    80000eaa:	00007517          	auipc	a0,0x7
    80000eae:	66e50513          	addi	a0,a0,1646 # 80008518 <etext+0x518>
    80000eb2:	e5eff0ef          	jal	80000510 <printk>
    printk("xv6 kernel is booting\n");
    80000eb6:	00007517          	auipc	a0,0x7
    80000eba:	1c250513          	addi	a0,a0,450 # 80008078 <etext+0x78>
    80000ebe:	e52ff0ef          	jal	80000510 <printk>
    printk("\n");
    80000ec2:	00007517          	auipc	a0,0x7
    80000ec6:	65650513          	addi	a0,a0,1622 # 80008518 <etext+0x518>
    80000eca:	e46ff0ef          	jal	80000510 <printk>
    kinit();            // physical page allocator
    80000ece:	c1dff0ef          	jal	80000aea <kinit>
    kvminit();          // create kernel page table
    80000ed2:	2c2000ef          	jal	80001194 <kvminit>
    kvminithart();      // turn on paging
    80000ed6:	03e000ef          	jal	80000f14 <kvminithart>
    procinit();         // process table
    80000eda:	11d000ef          	jal	800017f6 <procinit>
    trapinit();         // trap vectors
    80000ede:	53a010ef          	jal	80002418 <trapinit>
    trapinithart();     // install kernel trap vector
    80000ee2:	55a010ef          	jal	8000243c <trapinithart>
    plicinit();         // set up interrupt controller
    80000ee6:	5f9040ef          	jal	80005cde <plicinit>
    plicinithart();     // ask PLIC for device interrupts
    80000eea:	60f040ef          	jal	80005cf8 <plicinithart>
    binit();            // buffer cache
    80000eee:	3e7010ef          	jal	80002ad4 <binit>
    iinit();            // inode table
    80000ef2:	1f6020ef          	jal	800030e8 <iinit>
    fileinit();         // file table
    80000ef6:	45a030ef          	jal	80004350 <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000efa:	6ef040ef          	jal	80005de8 <virtio_disk_init>
    userinit();         // first user process
    80000efe:	4b5000ef          	jal	80001bb2 <userinit>
    __atomic_store_n(&started, 1, __ATOMIC_RELEASE);
    80000f02:	00008797          	auipc	a5,0x8
    80000f06:	9ea78793          	addi	a5,a5,-1558 # 800088ec <started>
    80000f0a:	4705                	li	a4,1
    80000f0c:	0310000f          	fence	rw,w
    80000f10:	c398                	sw	a4,0(a5)
    80000f12:	b771                	j	80000e9e <main+0x3e>

0000000080000f14 <kvminithart>:

// Switch the current CPU's h/w page table register to
// the kernel's page table, and enable paging.
void
kvminithart()
{
    80000f14:	1141                	addi	sp,sp,-16
    80000f16:	e406                	sd	ra,8(sp)
    80000f18:	e022                	sd	s0,0(sp)
    80000f1a:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero" ::: "memory");
    80000f1c:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    80000f20:	00008797          	auipc	a5,0x8
    80000f24:	9d07b783          	ld	a5,-1584(a5) # 800088f0 <kernel_pagetable>
    80000f28:	83b1                	srli	a5,a5,0xc
    80000f2a:	577d                	li	a4,-1
    80000f2c:	177e                	slli	a4,a4,0x3f
    80000f2e:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r"(x));
    80000f30:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero" ::: "memory");
    80000f34:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    80000f38:	60a2                	ld	ra,8(sp)
    80000f3a:	6402                	ld	s0,0(sp)
    80000f3c:	0141                	addi	sp,sp,16
    80000f3e:	8082                	ret

0000000080000f40 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000f40:	7139                	addi	sp,sp,-64
    80000f42:	fc06                	sd	ra,56(sp)
    80000f44:	f822                	sd	s0,48(sp)
    80000f46:	f426                	sd	s1,40(sp)
    80000f48:	f04a                	sd	s2,32(sp)
    80000f4a:	ec4e                	sd	s3,24(sp)
    80000f4c:	e852                	sd	s4,16(sp)
    80000f4e:	e456                	sd	s5,8(sp)
    80000f50:	e05a                	sd	s6,0(sp)
    80000f52:	0080                	addi	s0,sp,64
    80000f54:	84aa                	mv	s1,a0
    80000f56:	89ae                	mv	s3,a1
    80000f58:	8b32                	mv	s6,a2
  if (va >= MAXVA)
    80000f5a:	57fd                	li	a5,-1
    80000f5c:	83e9                	srli	a5,a5,0x1a
    80000f5e:	4a79                	li	s4,30
    panic("walk");

  for (int level = 2; level > 0; level--) {
    80000f60:	4ab1                	li	s5,12
  if (va >= MAXVA)
    80000f62:	06b7e363          	bltu	a5,a1,80000fc8 <walk+0x88>
    pte_t *pte = &pagetable[PX(level, va)];
    80000f66:	0149d933          	srl	s2,s3,s4
    80000f6a:	1ff97913          	andi	s2,s2,511
    80000f6e:	090e                	slli	s2,s2,0x3
    80000f70:	9926                	add	s2,s2,s1
    if (*pte & PTE_V) {
    80000f72:	00093483          	ld	s1,0(s2)
    80000f76:	0014f793          	andi	a5,s1,1
      pagetable = (pagetable_t)PTE2PA(*pte);
    80000f7a:	80a9                	srli	s1,s1,0xa
    80000f7c:	04b2                	slli	s1,s1,0xc
    if (*pte & PTE_V) {
    80000f7e:	e395                	bnez	a5,80000fa2 <walk+0x62>
    } else {
      if (!alloc || (pagetable = (pde_t *)kalloc()) == 0)
    80000f80:	040b0a63          	beqz	s6,80000fd4 <walk+0x94>
    80000f84:	b9bff0ef          	jal	80000b1e <kalloc>
    80000f88:	84aa                	mv	s1,a0
    80000f8a:	c50d                	beqz	a0,80000fb4 <walk+0x74>
        return 0;
      memset(pagetable, 0, PGSIZE);
    80000f8c:	6605                	lui	a2,0x1
    80000f8e:	4581                	li	a1,0
    80000f90:	d25ff0ef          	jal	80000cb4 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80000f94:	00c4d793          	srli	a5,s1,0xc
    80000f98:	07aa                	slli	a5,a5,0xa
    80000f9a:	0017e793          	ori	a5,a5,1
    80000f9e:	00f93023          	sd	a5,0(s2)
  for (int level = 2; level > 0; level--) {
    80000fa2:	3a5d                	addiw	s4,s4,-9
    80000fa4:	fd5a11e3          	bne	s4,s5,80000f66 <walk+0x26>
    }
  }
  return &pagetable[PX(0, va)];
    80000fa8:	00c9d513          	srli	a0,s3,0xc
    80000fac:	1ff57513          	andi	a0,a0,511
    80000fb0:	050e                	slli	a0,a0,0x3
    80000fb2:	9526                	add	a0,a0,s1
}
    80000fb4:	70e2                	ld	ra,56(sp)
    80000fb6:	7442                	ld	s0,48(sp)
    80000fb8:	74a2                	ld	s1,40(sp)
    80000fba:	7902                	ld	s2,32(sp)
    80000fbc:	69e2                	ld	s3,24(sp)
    80000fbe:	6a42                	ld	s4,16(sp)
    80000fc0:	6aa2                	ld	s5,8(sp)
    80000fc2:	6b02                	ld	s6,0(sp)
    80000fc4:	6121                	addi	sp,sp,64
    80000fc6:	8082                	ret
    panic("walk");
    80000fc8:	00007517          	auipc	a0,0x7
    80000fcc:	0e050513          	addi	a0,a0,224 # 800080a8 <etext+0xa8>
    80000fd0:	879ff0ef          	jal	80000848 <panic>
        return 0;
    80000fd4:	4501                	li	a0,0
    80000fd6:	bff9                	j	80000fb4 <walk+0x74>

0000000080000fd8 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if (va >= MAXVA)
    80000fd8:	57fd                	li	a5,-1
    80000fda:	83e9                	srli	a5,a5,0x1a
    80000fdc:	00b7f463          	bgeu	a5,a1,80000fe4 <walkaddr+0xc>
    return 0;
    80000fe0:	4501                	li	a0,0
    return 0;
  if ((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000fe2:	8082                	ret
{
    80000fe4:	1141                	addi	sp,sp,-16
    80000fe6:	e406                	sd	ra,8(sp)
    80000fe8:	e022                	sd	s0,0(sp)
    80000fea:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80000fec:	4601                	li	a2,0
    80000fee:	f53ff0ef          	jal	80000f40 <walk>
  if (pte == 0)
    80000ff2:	c519                	beqz	a0,80001000 <walkaddr+0x28>
  if ((*pte & PTE_V) == 0)
    80000ff4:	6108                	ld	a0,0(a0)
  if ((*pte & PTE_U) == 0)
    80000ff6:	01157713          	andi	a4,a0,17
    80000ffa:	47c5                	li	a5,17
    80000ffc:	00f70763          	beq	a4,a5,8000100a <walkaddr+0x32>
    return 0;
    80001000:	4501                	li	a0,0
}
    80001002:	60a2                	ld	ra,8(sp)
    80001004:	6402                	ld	s0,0(sp)
    80001006:	0141                	addi	sp,sp,16
    80001008:	8082                	ret
  pa = PTE2PA(*pte);
    8000100a:	8129                	srli	a0,a0,0xa
    8000100c:	0532                	slli	a0,a0,0xc
  return pa;
    8000100e:	bfd5                	j	80001002 <walkaddr+0x2a>

0000000080001010 <mappages>:
// va and size MUST be page-aligned.
// Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80001010:	715d                	addi	sp,sp,-80
    80001012:	e486                	sd	ra,72(sp)
    80001014:	e0a2                	sd	s0,64(sp)
    80001016:	fc26                	sd	s1,56(sp)
    80001018:	f84a                	sd	s2,48(sp)
    8000101a:	f44e                	sd	s3,40(sp)
    8000101c:	f052                	sd	s4,32(sp)
    8000101e:	ec56                	sd	s5,24(sp)
    80001020:	e85a                	sd	s6,16(sp)
    80001022:	e45e                	sd	s7,8(sp)
    80001024:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if ((va % PGSIZE) != 0)
    80001026:	03459793          	slli	a5,a1,0x34
    8000102a:	e7b1                	bnez	a5,80001076 <mappages+0x66>
    8000102c:	8a2a                	mv	s4,a0
    8000102e:	8aba                	mv	s5,a4
    panic("mappages: va not aligned");

  if ((size % PGSIZE) != 0)
    80001030:	03461793          	slli	a5,a2,0x34
    80001034:	e7b9                	bnez	a5,80001082 <mappages+0x72>
    panic("mappages: size not aligned");

  if (size == 0)
    80001036:	ce21                	beqz	a2,8000108e <mappages+0x7e>
    panic("mappages: size");

  a = va;
  last = va + size - PGSIZE;
    80001038:	77fd                	lui	a5,0xfffff
    8000103a:	963e                	add	a2,a2,a5
    8000103c:	00b60933          	add	s2,a2,a1
  a = va;
    80001040:	84ae                	mv	s1,a1
  for (;;) {
    if ((pte = walk(pagetable, a, 1)) == 0)
    80001042:	4b05                	li	s6,1
    80001044:	40b689b3          	sub	s3,a3,a1
    if (*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if (a == last)
      break;
    a += PGSIZE;
    80001048:	6b85                	lui	s7,0x1
    if ((pte = walk(pagetable, a, 1)) == 0)
    8000104a:	865a                	mv	a2,s6
    8000104c:	85a6                	mv	a1,s1
    8000104e:	8552                	mv	a0,s4
    80001050:	ef1ff0ef          	jal	80000f40 <walk>
    80001054:	c929                	beqz	a0,800010a6 <mappages+0x96>
    if (*pte & PTE_V)
    80001056:	611c                	ld	a5,0(a0)
    80001058:	8b85                	andi	a5,a5,1
    8000105a:	e3a1                	bnez	a5,8000109a <mappages+0x8a>
    *pte = PA2PTE(pa) | perm | PTE_V;
    8000105c:	013487b3          	add	a5,s1,s3
    80001060:	83b1                	srli	a5,a5,0xc
    80001062:	07aa                	slli	a5,a5,0xa
    80001064:	0157e7b3          	or	a5,a5,s5
    80001068:	0017e793          	ori	a5,a5,1
    8000106c:	e11c                	sd	a5,0(a0)
    if (a == last)
    8000106e:	05248863          	beq	s1,s2,800010be <mappages+0xae>
    a += PGSIZE;
    80001072:	94de                	add	s1,s1,s7
    if ((pte = walk(pagetable, a, 1)) == 0)
    80001074:	bfd9                	j	8000104a <mappages+0x3a>
    panic("mappages: va not aligned");
    80001076:	00007517          	auipc	a0,0x7
    8000107a:	03a50513          	addi	a0,a0,58 # 800080b0 <etext+0xb0>
    8000107e:	fcaff0ef          	jal	80000848 <panic>
    panic("mappages: size not aligned");
    80001082:	00007517          	auipc	a0,0x7
    80001086:	04e50513          	addi	a0,a0,78 # 800080d0 <etext+0xd0>
    8000108a:	fbeff0ef          	jal	80000848 <panic>
    panic("mappages: size");
    8000108e:	00007517          	auipc	a0,0x7
    80001092:	06250513          	addi	a0,a0,98 # 800080f0 <etext+0xf0>
    80001096:	fb2ff0ef          	jal	80000848 <panic>
      panic("mappages: remap");
    8000109a:	00007517          	auipc	a0,0x7
    8000109e:	06650513          	addi	a0,a0,102 # 80008100 <etext+0x100>
    800010a2:	fa6ff0ef          	jal	80000848 <panic>
      return -1;
    800010a6:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    800010a8:	60a6                	ld	ra,72(sp)
    800010aa:	6406                	ld	s0,64(sp)
    800010ac:	74e2                	ld	s1,56(sp)
    800010ae:	7942                	ld	s2,48(sp)
    800010b0:	79a2                	ld	s3,40(sp)
    800010b2:	7a02                	ld	s4,32(sp)
    800010b4:	6ae2                	ld	s5,24(sp)
    800010b6:	6b42                	ld	s6,16(sp)
    800010b8:	6ba2                	ld	s7,8(sp)
    800010ba:	6161                	addi	sp,sp,80
    800010bc:	8082                	ret
  return 0;
    800010be:	4501                	li	a0,0
    800010c0:	b7e5                	j	800010a8 <mappages+0x98>

00000000800010c2 <kvmmap>:
{
    800010c2:	1141                	addi	sp,sp,-16
    800010c4:	e406                	sd	ra,8(sp)
    800010c6:	e022                	sd	s0,0(sp)
    800010c8:	0800                	addi	s0,sp,16
    800010ca:	87b6                	mv	a5,a3
  if (mappages(kpgtbl, va, sz, pa, perm) != 0)
    800010cc:	86b2                	mv	a3,a2
    800010ce:	863e                	mv	a2,a5
    800010d0:	f41ff0ef          	jal	80001010 <mappages>
    800010d4:	e509                	bnez	a0,800010de <kvmmap+0x1c>
}
    800010d6:	60a2                	ld	ra,8(sp)
    800010d8:	6402                	ld	s0,0(sp)
    800010da:	0141                	addi	sp,sp,16
    800010dc:	8082                	ret
    panic("kvmmap");
    800010de:	00007517          	auipc	a0,0x7
    800010e2:	03250513          	addi	a0,a0,50 # 80008110 <etext+0x110>
    800010e6:	f62ff0ef          	jal	80000848 <panic>

00000000800010ea <kvmmake>:
{
    800010ea:	1101                	addi	sp,sp,-32
    800010ec:	ec06                	sd	ra,24(sp)
    800010ee:	e822                	sd	s0,16(sp)
    800010f0:	e426                	sd	s1,8(sp)
    800010f2:	e04a                	sd	s2,0(sp)
    800010f4:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t)kalloc();
    800010f6:	a29ff0ef          	jal	80000b1e <kalloc>
    800010fa:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    800010fc:	6605                	lui	a2,0x1
    800010fe:	4581                	li	a1,0
    80001100:	bb5ff0ef          	jal	80000cb4 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80001104:	4719                	li	a4,6
    80001106:	6685                	lui	a3,0x1
    80001108:	10000637          	lui	a2,0x10000
    8000110c:	85b2                	mv	a1,a2
    8000110e:	8526                	mv	a0,s1
    80001110:	fb3ff0ef          	jal	800010c2 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80001114:	4719                	li	a4,6
    80001116:	6685                	lui	a3,0x1
    80001118:	10001637          	lui	a2,0x10001
    8000111c:	85b2                	mv	a1,a2
    8000111e:	8526                	mv	a0,s1
    80001120:	fa3ff0ef          	jal	800010c2 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x4000000, PTE_R | PTE_W);
    80001124:	4719                	li	a4,6
    80001126:	040006b7          	lui	a3,0x4000
    8000112a:	0c000637          	lui	a2,0xc000
    8000112e:	85b2                	mv	a1,a2
    80001130:	8526                	mv	a0,s1
    80001132:	f91ff0ef          	jal	800010c2 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext - KERNBASE, PTE_R | PTE_X);
    80001136:	00007917          	auipc	s2,0x7
    8000113a:	eca90913          	addi	s2,s2,-310 # 80008000 <etext>
    8000113e:	4729                	li	a4,10
    80001140:	800006b7          	lui	a3,0x80000
    80001144:	96ca                	add	a3,a3,s2
    80001146:	4605                	li	a2,1
    80001148:	067e                	slli	a2,a2,0x1f
    8000114a:	85b2                	mv	a1,a2
    8000114c:	8526                	mv	a0,s1
    8000114e:	f75ff0ef          	jal	800010c2 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP - (uint64)etext,
    80001152:	4719                	li	a4,6
    80001154:	46c5                	li	a3,17
    80001156:	06ee                	slli	a3,a3,0x1b
    80001158:	412686b3          	sub	a3,a3,s2
    8000115c:	864a                	mv	a2,s2
    8000115e:	85ca                	mv	a1,s2
    80001160:	8526                	mv	a0,s1
    80001162:	f61ff0ef          	jal	800010c2 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80001166:	4729                	li	a4,10
    80001168:	6685                	lui	a3,0x1
    8000116a:	00006617          	auipc	a2,0x6
    8000116e:	e9660613          	addi	a2,a2,-362 # 80007000 <_trampoline>
    80001172:	040005b7          	lui	a1,0x4000
    80001176:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001178:	05b2                	slli	a1,a1,0xc
    8000117a:	8526                	mv	a0,s1
    8000117c:	f47ff0ef          	jal	800010c2 <kvmmap>
  proc_mapstacks(kpgtbl);
    80001180:	8526                	mv	a0,s1
    80001182:	5e0000ef          	jal	80001762 <proc_mapstacks>
}
    80001186:	8526                	mv	a0,s1
    80001188:	60e2                	ld	ra,24(sp)
    8000118a:	6442                	ld	s0,16(sp)
    8000118c:	64a2                	ld	s1,8(sp)
    8000118e:	6902                	ld	s2,0(sp)
    80001190:	6105                	addi	sp,sp,32
    80001192:	8082                	ret

0000000080001194 <kvminit>:
{
    80001194:	1141                	addi	sp,sp,-16
    80001196:	e406                	sd	ra,8(sp)
    80001198:	e022                	sd	s0,0(sp)
    8000119a:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    8000119c:	f4fff0ef          	jal	800010ea <kvmmake>
    800011a0:	00007797          	auipc	a5,0x7
    800011a4:	74a7b823          	sd	a0,1872(a5) # 800088f0 <kernel_pagetable>
}
    800011a8:	60a2                	ld	ra,8(sp)
    800011aa:	6402                	ld	s0,0(sp)
    800011ac:	0141                	addi	sp,sp,16
    800011ae:	8082                	ret

00000000800011b0 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    800011b0:	1101                	addi	sp,sp,-32
    800011b2:	ec06                	sd	ra,24(sp)
    800011b4:	e822                	sd	s0,16(sp)
    800011b6:	e426                	sd	s1,8(sp)
    800011b8:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t)kalloc();
    800011ba:	965ff0ef          	jal	80000b1e <kalloc>
    800011be:	84aa                	mv	s1,a0
  if (pagetable == 0)
    800011c0:	c509                	beqz	a0,800011ca <uvmcreate+0x1a>
    return 0;
  memset(pagetable, 0, PGSIZE);
    800011c2:	6605                	lui	a2,0x1
    800011c4:	4581                	li	a1,0
    800011c6:	aefff0ef          	jal	80000cb4 <memset>
  return pagetable;
}
    800011ca:	8526                	mv	a0,s1
    800011cc:	60e2                	ld	ra,24(sp)
    800011ce:	6442                	ld	s0,16(sp)
    800011d0:	64a2                	ld	s1,8(sp)
    800011d2:	6105                	addi	sp,sp,32
    800011d4:	8082                	ret

00000000800011d6 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. It's OK if the mappings don't exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    800011d6:	7139                	addi	sp,sp,-64
    800011d8:	fc06                	sd	ra,56(sp)
    800011da:	f822                	sd	s0,48(sp)
    800011dc:	0080                	addi	s0,sp,64
  uint64 a;
  pte_t *pte;

  if ((va % PGSIZE) != 0)
    800011de:	03459793          	slli	a5,a1,0x34
    800011e2:	e38d                	bnez	a5,80001204 <uvmunmap+0x2e>
    800011e4:	f04a                	sd	s2,32(sp)
    800011e6:	ec4e                	sd	s3,24(sp)
    800011e8:	e852                	sd	s4,16(sp)
    800011ea:	e456                	sd	s5,8(sp)
    800011ec:	e05a                	sd	s6,0(sp)
    800011ee:	8a2a                	mv	s4,a0
    800011f0:	892e                	mv	s2,a1
    800011f2:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for (a = va; a < va + npages * PGSIZE; a += PGSIZE) {
    800011f4:	0632                	slli	a2,a2,0xc
    800011f6:	00b609b3          	add	s3,a2,a1
    800011fa:	6b05                	lui	s6,0x1
    800011fc:	0535f963          	bgeu	a1,s3,8000124e <uvmunmap+0x78>
    80001200:	f426                	sd	s1,40(sp)
    80001202:	a015                	j	80001226 <uvmunmap+0x50>
    80001204:	f426                	sd	s1,40(sp)
    80001206:	f04a                	sd	s2,32(sp)
    80001208:	ec4e                	sd	s3,24(sp)
    8000120a:	e852                	sd	s4,16(sp)
    8000120c:	e456                	sd	s5,8(sp)
    8000120e:	e05a                	sd	s6,0(sp)
    panic("uvmunmap: not aligned");
    80001210:	00007517          	auipc	a0,0x7
    80001214:	f0850513          	addi	a0,a0,-248 # 80008118 <etext+0x118>
    80001218:	e30ff0ef          	jal	80000848 <panic>
      continue;
    if (do_free) {
      uint64 pa = PTE2PA(*pte);
      kfree((void *)pa);
    }
    *pte = 0;
    8000121c:	0004b023          	sd	zero,0(s1)
  for (a = va; a < va + npages * PGSIZE; a += PGSIZE) {
    80001220:	995a                	add	s2,s2,s6
    80001222:	03397563          	bgeu	s2,s3,8000124c <uvmunmap+0x76>
    if ((pte = walk(pagetable, a, 0)) == 0) // leaf page table entry allocated?
    80001226:	4601                	li	a2,0
    80001228:	85ca                	mv	a1,s2
    8000122a:	8552                	mv	a0,s4
    8000122c:	d15ff0ef          	jal	80000f40 <walk>
    80001230:	84aa                	mv	s1,a0
    80001232:	d57d                	beqz	a0,80001220 <uvmunmap+0x4a>
    if ((*pte & PTE_V) == 0) // has physical page been allocated?
    80001234:	611c                	ld	a5,0(a0)
    80001236:	0017f713          	andi	a4,a5,1
    8000123a:	d37d                	beqz	a4,80001220 <uvmunmap+0x4a>
    if (do_free) {
    8000123c:	fe0a80e3          	beqz	s5,8000121c <uvmunmap+0x46>
      uint64 pa = PTE2PA(*pte);
    80001240:	83a9                	srli	a5,a5,0xa
      kfree((void *)pa);
    80001242:	00c79513          	slli	a0,a5,0xc
    80001246:	ff0ff0ef          	jal	80000a36 <kfree>
    8000124a:	bfc9                	j	8000121c <uvmunmap+0x46>
    8000124c:	74a2                	ld	s1,40(sp)
    8000124e:	7902                	ld	s2,32(sp)
    80001250:	69e2                	ld	s3,24(sp)
    80001252:	6a42                	ld	s4,16(sp)
    80001254:	6aa2                	ld	s5,8(sp)
    80001256:	6b02                	ld	s6,0(sp)
  }
}
    80001258:	70e2                	ld	ra,56(sp)
    8000125a:	7442                	ld	s0,48(sp)
    8000125c:	6121                	addi	sp,sp,64
    8000125e:	8082                	ret

0000000080001260 <uvmdealloc>:
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
  if (newsz >= oldsz)
    80001260:	04b67163          	bgeu	a2,a1,800012a2 <uvmdealloc+0x42>
{
    80001264:	1101                	addi	sp,sp,-32
    80001266:	ec06                	sd	ra,24(sp)
    80001268:	e822                	sd	s0,16(sp)
    8000126a:	e426                	sd	s1,8(sp)
    8000126c:	1000                	addi	s0,sp,32
    8000126e:	84b2                	mv	s1,a2
    return oldsz;

  if (PGROUNDUP(newsz) < PGROUNDUP(oldsz)) {
    80001270:	6785                	lui	a5,0x1
    80001272:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80001274:	00f60733          	add	a4,a2,a5
    80001278:	76fd                	lui	a3,0xfffff
    8000127a:	8f75                	and	a4,a4,a3
    8000127c:	97ae                	add	a5,a5,a1
    8000127e:	8ff5                	and	a5,a5,a3
    80001280:	00f76863          	bltu	a4,a5,80001290 <uvmdealloc+0x30>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
    80001284:	8526                	mv	a0,s1
}
    80001286:	60e2                	ld	ra,24(sp)
    80001288:	6442                	ld	s0,16(sp)
    8000128a:	64a2                	ld	s1,8(sp)
    8000128c:	6105                	addi	sp,sp,32
    8000128e:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80001290:	8f99                	sub	a5,a5,a4
    80001292:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80001294:	4685                	li	a3,1
    80001296:	0007861b          	sext.w	a2,a5
    8000129a:	85ba                	mv	a1,a4
    8000129c:	f3bff0ef          	jal	800011d6 <uvmunmap>
    800012a0:	b7d5                	j	80001284 <uvmdealloc+0x24>
    return oldsz;
    800012a2:	852e                	mv	a0,a1
}
    800012a4:	8082                	ret

00000000800012a6 <uvmalloc>:
  if (newsz < oldsz)
    800012a6:	08b66e63          	bltu	a2,a1,80001342 <uvmalloc+0x9c>
{
    800012aa:	715d                	addi	sp,sp,-80
    800012ac:	e486                	sd	ra,72(sp)
    800012ae:	e0a2                	sd	s0,64(sp)
    800012b0:	f052                	sd	s4,32(sp)
    800012b2:	ec56                	sd	s5,24(sp)
    800012b4:	e45e                	sd	s7,8(sp)
    800012b6:	0880                	addi	s0,sp,80
    800012b8:	8aaa                	mv	s5,a0
    800012ba:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    800012bc:	6785                	lui	a5,0x1
    800012be:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800012c0:	95be                	add	a1,a1,a5
    800012c2:	77fd                	lui	a5,0xfffff
    800012c4:	8fed                	and	a5,a5,a1
    800012c6:	8bbe                	mv	s7,a5
  for (a = oldsz; a < newsz; a += PGSIZE) {
    800012c8:	04c7f163          	bgeu	a5,a2,8000130a <uvmalloc+0x64>
    800012cc:	fc26                	sd	s1,56(sp)
    800012ce:	f84a                	sd	s2,48(sp)
    800012d0:	f44e                	sd	s3,40(sp)
    800012d2:	e85a                	sd	s6,16(sp)
    800012d4:	893e                	mv	s2,a5
    memset(mem, 0, PGSIZE);
    800012d6:	6985                	lui	s3,0x1
    if (mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R | PTE_U | xperm) !=
    800012d8:	0126eb13          	ori	s6,a3,18
    mem = kalloc();
    800012dc:	843ff0ef          	jal	80000b1e <kalloc>
    800012e0:	84aa                	mv	s1,a0
    if (mem == 0) {
    800012e2:	c515                	beqz	a0,8000130e <uvmalloc+0x68>
    memset(mem, 0, PGSIZE);
    800012e4:	864e                	mv	a2,s3
    800012e6:	4581                	li	a1,0
    800012e8:	9cdff0ef          	jal	80000cb4 <memset>
    if (mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R | PTE_U | xperm) !=
    800012ec:	875a                	mv	a4,s6
    800012ee:	86a6                	mv	a3,s1
    800012f0:	864e                	mv	a2,s3
    800012f2:	85ca                	mv	a1,s2
    800012f4:	8556                	mv	a0,s5
    800012f6:	d1bff0ef          	jal	80001010 <mappages>
    800012fa:	e91d                	bnez	a0,80001330 <uvmalloc+0x8a>
  for (a = oldsz; a < newsz; a += PGSIZE) {
    800012fc:	994e                	add	s2,s2,s3
    800012fe:	fd496fe3          	bltu	s2,s4,800012dc <uvmalloc+0x36>
    80001302:	74e2                	ld	s1,56(sp)
    80001304:	7942                	ld	s2,48(sp)
    80001306:	79a2                	ld	s3,40(sp)
    80001308:	6b42                	ld	s6,16(sp)
  return newsz;
    8000130a:	8552                	mv	a0,s4
    8000130c:	a819                	j	80001322 <uvmalloc+0x7c>
      uvmdealloc(pagetable, a, oldsz);
    8000130e:	865e                	mv	a2,s7
    80001310:	85ca                	mv	a1,s2
    80001312:	8556                	mv	a0,s5
    80001314:	f4dff0ef          	jal	80001260 <uvmdealloc>
      return 0;
    80001318:	4501                	li	a0,0
    8000131a:	74e2                	ld	s1,56(sp)
    8000131c:	7942                	ld	s2,48(sp)
    8000131e:	79a2                	ld	s3,40(sp)
    80001320:	6b42                	ld	s6,16(sp)
}
    80001322:	60a6                	ld	ra,72(sp)
    80001324:	6406                	ld	s0,64(sp)
    80001326:	7a02                	ld	s4,32(sp)
    80001328:	6ae2                	ld	s5,24(sp)
    8000132a:	6ba2                	ld	s7,8(sp)
    8000132c:	6161                	addi	sp,sp,80
    8000132e:	8082                	ret
      kfree(mem);
    80001330:	8526                	mv	a0,s1
    80001332:	f04ff0ef          	jal	80000a36 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80001336:	865e                	mv	a2,s7
    80001338:	85ca                	mv	a1,s2
    8000133a:	8556                	mv	a0,s5
    8000133c:	f25ff0ef          	jal	80001260 <uvmdealloc>
      return 0;
    80001340:	bfe1                	j	80001318 <uvmalloc+0x72>
    return oldsz;
    80001342:	852e                	mv	a0,a1
}
    80001344:	8082                	ret

0000000080001346 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80001346:	7179                	addi	sp,sp,-48
    80001348:	f406                	sd	ra,40(sp)
    8000134a:	f022                	sd	s0,32(sp)
    8000134c:	ec26                	sd	s1,24(sp)
    8000134e:	e84a                	sd	s2,16(sp)
    80001350:	e44e                	sd	s3,8(sp)
    80001352:	1800                	addi	s0,sp,48
    80001354:	89aa                	mv	s3,a0
  // there are 2^9 = 512 PTEs in a page table.
  for (int i = 0; i < 512; i++) {
    80001356:	84aa                	mv	s1,a0
    80001358:	6905                	lui	s2,0x1
    8000135a:	992a                	add	s2,s2,a0
    8000135c:	a811                	j	80001370 <freewalk+0x2a>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
      freewalk((pagetable_t)child);
      pagetable[i] = 0;
    } else if (pte & PTE_V) {
      panic("freewalk: leaf");
    8000135e:	00007517          	auipc	a0,0x7
    80001362:	dd250513          	addi	a0,a0,-558 # 80008130 <etext+0x130>
    80001366:	ce2ff0ef          	jal	80000848 <panic>
  for (int i = 0; i < 512; i++) {
    8000136a:	04a1                	addi	s1,s1,8
    8000136c:	03248163          	beq	s1,s2,8000138e <freewalk+0x48>
    pte_t pte = pagetable[i];
    80001370:	609c                	ld	a5,0(s1)
    if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0) {
    80001372:	0017f713          	andi	a4,a5,1
    80001376:	db75                	beqz	a4,8000136a <freewalk+0x24>
    80001378:	00e7f713          	andi	a4,a5,14
    8000137c:	f36d                	bnez	a4,8000135e <freewalk+0x18>
      uint64 child = PTE2PA(pte);
    8000137e:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    80001380:	00c79513          	slli	a0,a5,0xc
    80001384:	fc3ff0ef          	jal	80001346 <freewalk>
      pagetable[i] = 0;
    80001388:	0004b023          	sd	zero,0(s1)
    if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0) {
    8000138c:	bff9                	j	8000136a <freewalk+0x24>
    }
  }
  kfree((void *)pagetable);
    8000138e:	854e                	mv	a0,s3
    80001390:	ea6ff0ef          	jal	80000a36 <kfree>
}
    80001394:	70a2                	ld	ra,40(sp)
    80001396:	7402                	ld	s0,32(sp)
    80001398:	64e2                	ld	s1,24(sp)
    8000139a:	6942                	ld	s2,16(sp)
    8000139c:	69a2                	ld	s3,8(sp)
    8000139e:	6145                	addi	sp,sp,48
    800013a0:	8082                	ret

00000000800013a2 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    800013a2:	1101                	addi	sp,sp,-32
    800013a4:	ec06                	sd	ra,24(sp)
    800013a6:	e822                	sd	s0,16(sp)
    800013a8:	e426                	sd	s1,8(sp)
    800013aa:	1000                	addi	s0,sp,32
    800013ac:	84aa                	mv	s1,a0
  if (sz > 0)
    800013ae:	e989                	bnez	a1,800013c0 <uvmfree+0x1e>
    uvmunmap(pagetable, 0, PGROUNDUP(sz) / PGSIZE, 1);
  freewalk(pagetable);
    800013b0:	8526                	mv	a0,s1
    800013b2:	f95ff0ef          	jal	80001346 <freewalk>
}
    800013b6:	60e2                	ld	ra,24(sp)
    800013b8:	6442                	ld	s0,16(sp)
    800013ba:	64a2                	ld	s1,8(sp)
    800013bc:	6105                	addi	sp,sp,32
    800013be:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz) / PGSIZE, 1);
    800013c0:	6785                	lui	a5,0x1
    800013c2:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800013c4:	95be                	add	a1,a1,a5
    800013c6:	4685                	li	a3,1
    800013c8:	00c5d613          	srli	a2,a1,0xc
    800013cc:	4581                	li	a1,0
    800013ce:	e09ff0ef          	jal	800011d6 <uvmunmap>
    800013d2:	bff9                	j	800013b0 <uvmfree+0xe>

00000000800013d4 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for (i = 0; i < sz; i += PGSIZE) {
    800013d4:	ca59                	beqz	a2,8000146a <uvmcopy+0x96>
{
    800013d6:	715d                	addi	sp,sp,-80
    800013d8:	e486                	sd	ra,72(sp)
    800013da:	e0a2                	sd	s0,64(sp)
    800013dc:	fc26                	sd	s1,56(sp)
    800013de:	f84a                	sd	s2,48(sp)
    800013e0:	f44e                	sd	s3,40(sp)
    800013e2:	f052                	sd	s4,32(sp)
    800013e4:	ec56                	sd	s5,24(sp)
    800013e6:	e85a                	sd	s6,16(sp)
    800013e8:	e45e                	sd	s7,8(sp)
    800013ea:	0880                	addi	s0,sp,80
    800013ec:	8b2a                	mv	s6,a0
    800013ee:	8bae                	mv	s7,a1
    800013f0:	8ab2                	mv	s5,a2
  for (i = 0; i < sz; i += PGSIZE) {
    800013f2:	4481                	li	s1,0
      continue; // physical page hasn't been allocated
    pa = PTE2PA(*pte);
    flags = PTE_FLAGS(*pte);
    if ((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char *)pa, PGSIZE);
    800013f4:	6a05                	lui	s4,0x1
    800013f6:	a021                	j	800013fe <uvmcopy+0x2a>
  for (i = 0; i < sz; i += PGSIZE) {
    800013f8:	94d2                	add	s1,s1,s4
    800013fa:	0554fc63          	bgeu	s1,s5,80001452 <uvmcopy+0x7e>
    if ((pte = walk(old, i, 0)) == 0)
    800013fe:	4601                	li	a2,0
    80001400:	85a6                	mv	a1,s1
    80001402:	855a                	mv	a0,s6
    80001404:	b3dff0ef          	jal	80000f40 <walk>
    80001408:	d965                	beqz	a0,800013f8 <uvmcopy+0x24>
    if ((*pte & PTE_V) == 0)
    8000140a:	00053983          	ld	s3,0(a0)
    8000140e:	0019f793          	andi	a5,s3,1
    80001412:	d3fd                	beqz	a5,800013f8 <uvmcopy+0x24>
    if ((mem = kalloc()) == 0)
    80001414:	f0aff0ef          	jal	80000b1e <kalloc>
    80001418:	892a                	mv	s2,a0
    8000141a:	c11d                	beqz	a0,80001440 <uvmcopy+0x6c>
    pa = PTE2PA(*pte);
    8000141c:	00a9d593          	srli	a1,s3,0xa
    memmove(mem, (char *)pa, PGSIZE);
    80001420:	8652                	mv	a2,s4
    80001422:	05b2                	slli	a1,a1,0xc
    80001424:	8edff0ef          	jal	80000d10 <memmove>
    if (mappages(new, i, PGSIZE, (uint64)mem, flags) != 0) {
    80001428:	3ff9f713          	andi	a4,s3,1023
    8000142c:	86ca                	mv	a3,s2
    8000142e:	8652                	mv	a2,s4
    80001430:	85a6                	mv	a1,s1
    80001432:	855e                	mv	a0,s7
    80001434:	bddff0ef          	jal	80001010 <mappages>
    80001438:	d161                	beqz	a0,800013f8 <uvmcopy+0x24>
      kfree(mem);
    8000143a:	854a                	mv	a0,s2
    8000143c:	dfaff0ef          	jal	80000a36 <kfree>
    }
  }
  return 0;

err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80001440:	4685                	li	a3,1
    80001442:	00c4d613          	srli	a2,s1,0xc
    80001446:	4581                	li	a1,0
    80001448:	855e                	mv	a0,s7
    8000144a:	d8dff0ef          	jal	800011d6 <uvmunmap>
  return -1;
    8000144e:	557d                	li	a0,-1
    80001450:	a011                	j	80001454 <uvmcopy+0x80>
  return 0;
    80001452:	4501                	li	a0,0
}
    80001454:	60a6                	ld	ra,72(sp)
    80001456:	6406                	ld	s0,64(sp)
    80001458:	74e2                	ld	s1,56(sp)
    8000145a:	7942                	ld	s2,48(sp)
    8000145c:	79a2                	ld	s3,40(sp)
    8000145e:	7a02                	ld	s4,32(sp)
    80001460:	6ae2                	ld	s5,24(sp)
    80001462:	6b42                	ld	s6,16(sp)
    80001464:	6ba2                	ld	s7,8(sp)
    80001466:	6161                	addi	sp,sp,80
    80001468:	8082                	ret
  return 0;
    8000146a:	4501                	li	a0,0
}
    8000146c:	8082                	ret

000000008000146e <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    8000146e:	1141                	addi	sp,sp,-16
    80001470:	e406                	sd	ra,8(sp)
    80001472:	e022                	sd	s0,0(sp)
    80001474:	0800                	addi	s0,sp,16
  pte_t *pte;

  pte = walk(pagetable, va, 0);
    80001476:	4601                	li	a2,0
    80001478:	ac9ff0ef          	jal	80000f40 <walk>
  if (pte == 0)
    8000147c:	c901                	beqz	a0,8000148c <uvmclear+0x1e>
    panic("uvmclear");
  *pte &= ~PTE_U;
    8000147e:	611c                	ld	a5,0(a0)
    80001480:	9bbd                	andi	a5,a5,-17
    80001482:	e11c                	sd	a5,0(a0)
}
    80001484:	60a2                	ld	ra,8(sp)
    80001486:	6402                	ld	s0,0(sp)
    80001488:	0141                	addi	sp,sp,16
    8000148a:	8082                	ret
    panic("uvmclear");
    8000148c:	00007517          	auipc	a0,0x7
    80001490:	cb450513          	addi	a0,a0,-844 # 80008140 <etext+0x140>
    80001494:	bb4ff0ef          	jal	80000848 <panic>

0000000080001498 <ismapped>:
  return mem;
}

int
ismapped(pagetable_t pagetable, uint64 va)
{
    80001498:	1141                	addi	sp,sp,-16
    8000149a:	e406                	sd	ra,8(sp)
    8000149c:	e022                	sd	s0,0(sp)
    8000149e:	0800                	addi	s0,sp,16
  pte_t *pte = walk(pagetable, va, 0);
    800014a0:	4601                	li	a2,0
    800014a2:	a9fff0ef          	jal	80000f40 <walk>
  if (pte == 0) {
    800014a6:	c119                	beqz	a0,800014ac <ismapped+0x14>
    return 0;
  }
  if (*pte & PTE_V) {
    800014a8:	6108                	ld	a0,0(a0)
    800014aa:	8905                	andi	a0,a0,1
    return 1;
  }
  return 0;
}
    800014ac:	60a2                	ld	ra,8(sp)
    800014ae:	6402                	ld	s0,0(sp)
    800014b0:	0141                	addi	sp,sp,16
    800014b2:	8082                	ret

00000000800014b4 <vmfault>:
{
    800014b4:	7179                	addi	sp,sp,-48
    800014b6:	f406                	sd	ra,40(sp)
    800014b8:	f022                	sd	s0,32(sp)
    800014ba:	e052                	sd	s4,0(sp)
    800014bc:	1800                	addi	s0,sp,48
  if (va >= psz)
    800014be:	00b66d63          	bltu	a2,a1,800014d8 <vmfault+0x24>
    return 0;
    800014c2:	4a01                	li	s4,0
}
    800014c4:	8552                	mv	a0,s4
    800014c6:	70a2                	ld	ra,40(sp)
    800014c8:	7402                	ld	s0,32(sp)
    800014ca:	6a02                	ld	s4,0(sp)
    800014cc:	6145                	addi	sp,sp,48
    800014ce:	8082                	ret
    800014d0:	64e2                	ld	s1,24(sp)
    800014d2:	6942                	ld	s2,16(sp)
    800014d4:	69a2                	ld	s3,8(sp)
    800014d6:	b7f5                	j	800014c2 <vmfault+0xe>
    800014d8:	e84a                	sd	s2,16(sp)
    800014da:	e44e                	sd	s3,8(sp)
  va = PGROUNDDOWN(va);
    800014dc:	77fd                	lui	a5,0xfffff
    800014de:	00f67933          	and	s2,a2,a5
  if (ismapped(pagetable, va)) {
    800014e2:	85ca                	mv	a1,s2
    800014e4:	89aa                	mv	s3,a0
    800014e6:	fb3ff0ef          	jal	80001498 <ismapped>
    800014ea:	c501                	beqz	a0,800014f2 <vmfault+0x3e>
    800014ec:	6942                	ld	s2,16(sp)
    800014ee:	69a2                	ld	s3,8(sp)
    800014f0:	bfc9                	j	800014c2 <vmfault+0xe>
    800014f2:	ec26                	sd	s1,24(sp)
  mem = (uint64)kalloc();
    800014f4:	e2aff0ef          	jal	80000b1e <kalloc>
    800014f8:	84aa                	mv	s1,a0
  if (mem == 0)
    800014fa:	d979                	beqz	a0,800014d0 <vmfault+0x1c>
  mem = (uint64)kalloc();
    800014fc:	8a2a                	mv	s4,a0
  memset((void *)mem, 0, PGSIZE);
    800014fe:	6605                	lui	a2,0x1
    80001500:	4581                	li	a1,0
    80001502:	fb2ff0ef          	jal	80000cb4 <memset>
  if (mappages(pagetable, va, PGSIZE, mem, PTE_W | PTE_U | PTE_R) != 0) {
    80001506:	4759                	li	a4,22
    80001508:	86a6                	mv	a3,s1
    8000150a:	6605                	lui	a2,0x1
    8000150c:	85ca                	mv	a1,s2
    8000150e:	854e                	mv	a0,s3
    80001510:	b01ff0ef          	jal	80001010 <mappages>
    80001514:	e509                	bnez	a0,8000151e <vmfault+0x6a>
    80001516:	64e2                	ld	s1,24(sp)
    80001518:	6942                	ld	s2,16(sp)
    8000151a:	69a2                	ld	s3,8(sp)
    8000151c:	b765                	j	800014c4 <vmfault+0x10>
    kfree((void *)mem);
    8000151e:	8526                	mv	a0,s1
    80001520:	d16ff0ef          	jal	80000a36 <kfree>
    return 0;
    80001524:	64e2                	ld	s1,24(sp)
    80001526:	6942                	ld	s2,16(sp)
    80001528:	69a2                	ld	s3,8(sp)
    8000152a:	bf61                	j	800014c2 <vmfault+0xe>

000000008000152c <copyout>:
  while (len > 0) {
    8000152c:	cf55                	beqz	a4,800015e8 <copyout+0xbc>
{
    8000152e:	7159                	addi	sp,sp,-112
    80001530:	f486                	sd	ra,104(sp)
    80001532:	f0a2                	sd	s0,96(sp)
    80001534:	eca6                	sd	s1,88(sp)
    80001536:	e8ca                	sd	s2,80(sp)
    80001538:	e4ce                	sd	s3,72(sp)
    8000153a:	e0d2                	sd	s4,64(sp)
    8000153c:	fc56                	sd	s5,56(sp)
    8000153e:	f85a                	sd	s6,48(sp)
    80001540:	f45e                	sd	s7,40(sp)
    80001542:	f062                	sd	s8,32(sp)
    80001544:	ec66                	sd	s9,24(sp)
    80001546:	e86a                	sd	s10,16(sp)
    80001548:	e46e                	sd	s11,8(sp)
    8000154a:	1880                	addi	s0,sp,112
    8000154c:	8baa                	mv	s7,a0
    8000154e:	8dae                	mv	s11,a1
    80001550:	84b2                	mv	s1,a2
    80001552:	8b36                	mv	s6,a3
    80001554:	8aba                	mv	s5,a4
    va0 = PGROUNDDOWN(dstva);
    80001556:	7d7d                	lui	s10,0xfffff
    if (va0 >= MAXVA)
    80001558:	5cfd                	li	s9,-1
    8000155a:	01acdc93          	srli	s9,s9,0x1a
    n = PGSIZE - (dstva - va0);
    8000155e:	6c05                	lui	s8,0x1
    80001560:	a089                	j	800015a2 <copyout+0x76>
      return -1;
    80001562:	557d                	li	a0,-1
}
    80001564:	70a6                	ld	ra,104(sp)
    80001566:	7406                	ld	s0,96(sp)
    80001568:	64e6                	ld	s1,88(sp)
    8000156a:	6946                	ld	s2,80(sp)
    8000156c:	69a6                	ld	s3,72(sp)
    8000156e:	6a06                	ld	s4,64(sp)
    80001570:	7ae2                	ld	s5,56(sp)
    80001572:	7b42                	ld	s6,48(sp)
    80001574:	7ba2                	ld	s7,40(sp)
    80001576:	7c02                	ld	s8,32(sp)
    80001578:	6ce2                	ld	s9,24(sp)
    8000157a:	6d42                	ld	s10,16(sp)
    8000157c:	6da2                	ld	s11,8(sp)
    8000157e:	6165                	addi	sp,sp,112
    80001580:	8082                	ret
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80001582:	03449513          	slli	a0,s1,0x34
    80001586:	9151                	srli	a0,a0,0x34
    80001588:	0009061b          	sext.w	a2,s2
    8000158c:	85da                	mv	a1,s6
    8000158e:	954e                	add	a0,a0,s3
    80001590:	f80ff0ef          	jal	80000d10 <memmove>
    len -= n;
    80001594:	412a8ab3          	sub	s5,s5,s2
    src += n;
    80001598:	9b4a                	add	s6,s6,s2
    dstva = va0 + PGSIZE;
    8000159a:	018a04b3          	add	s1,s4,s8
  while (len > 0) {
    8000159e:	040a8363          	beqz	s5,800015e4 <copyout+0xb8>
    va0 = PGROUNDDOWN(dstva);
    800015a2:	01a4fa33          	and	s4,s1,s10
    if (va0 >= MAXVA)
    800015a6:	fb4ceee3          	bltu	s9,s4,80001562 <copyout+0x36>
    pa0 = walkaddr(pagetable, va0);
    800015aa:	85d2                	mv	a1,s4
    800015ac:	855e                	mv	a0,s7
    800015ae:	a2bff0ef          	jal	80000fd8 <walkaddr>
    800015b2:	89aa                	mv	s3,a0
    if (pa0 == 0) {
    800015b4:	e909                	bnez	a0,800015c6 <copyout+0x9a>
      if ((pa0 = vmfault(pagetable, psz, va0, 0)) == 0) {
    800015b6:	4681                	li	a3,0
    800015b8:	8652                	mv	a2,s4
    800015ba:	85ee                	mv	a1,s11
    800015bc:	855e                	mv	a0,s7
    800015be:	ef7ff0ef          	jal	800014b4 <vmfault>
    800015c2:	89aa                	mv	s3,a0
    800015c4:	dd59                	beqz	a0,80001562 <copyout+0x36>
    pte = walk(pagetable, va0, 0);
    800015c6:	4601                	li	a2,0
    800015c8:	85d2                	mv	a1,s4
    800015ca:	855e                	mv	a0,s7
    800015cc:	975ff0ef          	jal	80000f40 <walk>
    if ((*pte & PTE_W) == 0)
    800015d0:	611c                	ld	a5,0(a0)
    800015d2:	8b91                	andi	a5,a5,4
    800015d4:	d7d9                	beqz	a5,80001562 <copyout+0x36>
    n = PGSIZE - (dstva - va0);
    800015d6:	409a0933          	sub	s2,s4,s1
    800015da:	9962                	add	s2,s2,s8
    if (n > len)
    800015dc:	fb2af3e3          	bgeu	s5,s2,80001582 <copyout+0x56>
    800015e0:	8956                	mv	s2,s5
    800015e2:	b745                	j	80001582 <copyout+0x56>
  return 0;
    800015e4:	4501                	li	a0,0
    800015e6:	bfbd                	j	80001564 <copyout+0x38>
    800015e8:	4501                	li	a0,0
}
    800015ea:	8082                	ret

00000000800015ec <copyin>:
  while (len > 0) {
    800015ec:	cf49                	beqz	a4,80001686 <copyin+0x9a>
{
    800015ee:	711d                	addi	sp,sp,-96
    800015f0:	ec86                	sd	ra,88(sp)
    800015f2:	e8a2                	sd	s0,80(sp)
    800015f4:	e4a6                	sd	s1,72(sp)
    800015f6:	e0ca                	sd	s2,64(sp)
    800015f8:	fc4e                	sd	s3,56(sp)
    800015fa:	f852                	sd	s4,48(sp)
    800015fc:	f456                	sd	s5,40(sp)
    800015fe:	f05a                	sd	s6,32(sp)
    80001600:	ec5e                	sd	s7,24(sp)
    80001602:	e862                	sd	s8,16(sp)
    80001604:	e466                	sd	s9,8(sp)
    80001606:	e06a                	sd	s10,0(sp)
    80001608:	1080                	addi	s0,sp,96
    8000160a:	8baa                	mv	s7,a0
    8000160c:	8cae                	mv	s9,a1
    8000160e:	8ab2                	mv	s5,a2
    80001610:	84b6                	mv	s1,a3
    80001612:	89ba                	mv	s3,a4
    va0 = PGROUNDDOWN(srcva);
    80001614:	7c7d                	lui	s8,0xfffff
      if ((pa0 = vmfault(pagetable, psz, va0, 1)) == 0) {
    80001616:	4d05                	li	s10,1
    n = PGSIZE - (srcva - va0);
    80001618:	6b05                	lui	s6,0x1
    8000161a:	a03d                	j	80001648 <copyin+0x5c>
    8000161c:	409a0933          	sub	s2,s4,s1
    80001620:	995a                	add	s2,s2,s6
    if (n > len)
    80001622:	0129f363          	bgeu	s3,s2,80001628 <copyin+0x3c>
    80001626:	894e                	mv	s2,s3
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80001628:	03449593          	slli	a1,s1,0x34
    8000162c:	91d1                	srli	a1,a1,0x34
    8000162e:	0009061b          	sext.w	a2,s2
    80001632:	95aa                	add	a1,a1,a0
    80001634:	8556                	mv	a0,s5
    80001636:	edaff0ef          	jal	80000d10 <memmove>
    len -= n;
    8000163a:	412989b3          	sub	s3,s3,s2
    dst += n;
    8000163e:	9aca                	add	s5,s5,s2
    srcva = va0 + PGSIZE;
    80001640:	016a04b3          	add	s1,s4,s6
  while (len > 0) {
    80001644:	02098263          	beqz	s3,80001668 <copyin+0x7c>
    va0 = PGROUNDDOWN(srcva);
    80001648:	0184fa33          	and	s4,s1,s8
    pa0 = walkaddr(pagetable, va0);
    8000164c:	85d2                	mv	a1,s4
    8000164e:	855e                	mv	a0,s7
    80001650:	989ff0ef          	jal	80000fd8 <walkaddr>
    if (pa0 == 0) {
    80001654:	f561                	bnez	a0,8000161c <copyin+0x30>
      if ((pa0 = vmfault(pagetable, psz, va0, 1)) == 0) {
    80001656:	86ea                	mv	a3,s10
    80001658:	8652                	mv	a2,s4
    8000165a:	85e6                	mv	a1,s9
    8000165c:	855e                	mv	a0,s7
    8000165e:	e57ff0ef          	jal	800014b4 <vmfault>
    80001662:	fd4d                	bnez	a0,8000161c <copyin+0x30>
        return -1;
    80001664:	557d                	li	a0,-1
    80001666:	a011                	j	8000166a <copyin+0x7e>
  return 0;
    80001668:	4501                	li	a0,0
}
    8000166a:	60e6                	ld	ra,88(sp)
    8000166c:	6446                	ld	s0,80(sp)
    8000166e:	64a6                	ld	s1,72(sp)
    80001670:	6906                	ld	s2,64(sp)
    80001672:	79e2                	ld	s3,56(sp)
    80001674:	7a42                	ld	s4,48(sp)
    80001676:	7aa2                	ld	s5,40(sp)
    80001678:	7b02                	ld	s6,32(sp)
    8000167a:	6be2                	ld	s7,24(sp)
    8000167c:	6c42                	ld	s8,16(sp)
    8000167e:	6ca2                	ld	s9,8(sp)
    80001680:	6d02                	ld	s10,0(sp)
    80001682:	6125                	addi	sp,sp,96
    80001684:	8082                	ret
  return 0;
    80001686:	4501                	li	a0,0
}
    80001688:	8082                	ret

000000008000168a <copyinstr>:
  while (got_null == 0 && max > 0) {
    8000168a:	c771                	beqz	a4,80001756 <copyinstr+0xcc>
{
    8000168c:	711d                	addi	sp,sp,-96
    8000168e:	ec86                	sd	ra,88(sp)
    80001690:	e8a2                	sd	s0,80(sp)
    80001692:	e4a6                	sd	s1,72(sp)
    80001694:	e0ca                	sd	s2,64(sp)
    80001696:	fc4e                	sd	s3,56(sp)
    80001698:	f852                	sd	s4,48(sp)
    8000169a:	f456                	sd	s5,40(sp)
    8000169c:	f05a                	sd	s6,32(sp)
    8000169e:	ec5e                	sd	s7,24(sp)
    800016a0:	e862                	sd	s8,16(sp)
    800016a2:	e466                	sd	s9,8(sp)
    800016a4:	1080                	addi	s0,sp,96
    800016a6:	8b2a                	mv	s6,a0
    800016a8:	8c2e                	mv	s8,a1
    800016aa:	8932                	mv	s2,a2
    800016ac:	84b6                	mv	s1,a3
    800016ae:	8a3a                	mv	s4,a4
    va0 = PGROUNDDOWN(srcva);
    800016b0:	7bfd                	lui	s7,0xfffff
      if ((pa0 = vmfault(pagetable, psz, va0, 1)) == 0) {
    800016b2:	4c85                	li	s9,1
    n = PGSIZE - (srcva - va0);
    800016b4:	6a85                	lui	s5,0x1
    800016b6:	a881                	j	80001706 <copyinstr+0x7c>
      if ((pa0 = vmfault(pagetable, psz, va0, 1)) == 0) {
    800016b8:	86e6                	mv	a3,s9
    800016ba:	864e                	mv	a2,s3
    800016bc:	85e2                	mv	a1,s8
    800016be:	855a                	mv	a0,s6
    800016c0:	df5ff0ef          	jal	800014b4 <vmfault>
    800016c4:	e921                	bnez	a0,80001714 <copyinstr+0x8a>
        return -1;
    800016c6:	557d                	li	a0,-1
    800016c8:	a801                	j	800016d8 <copyinstr+0x4e>
        *dst = '\0';
    800016ca:	00078023          	sb	zero,0(a5) # fffffffffffff000 <end+0xffffffff7ffa4050>
        got_null = 1;
    800016ce:	4785                	li	a5,1
  if (got_null) {
    800016d0:	0017c793          	xori	a5,a5,1
    800016d4:	40f0053b          	negw	a0,a5
}
    800016d8:	60e6                	ld	ra,88(sp)
    800016da:	6446                	ld	s0,80(sp)
    800016dc:	64a6                	ld	s1,72(sp)
    800016de:	6906                	ld	s2,64(sp)
    800016e0:	79e2                	ld	s3,56(sp)
    800016e2:	7a42                	ld	s4,48(sp)
    800016e4:	7aa2                	ld	s5,40(sp)
    800016e6:	7b02                	ld	s6,32(sp)
    800016e8:	6be2                	ld	s7,24(sp)
    800016ea:	6c42                	ld	s8,16(sp)
    800016ec:	6ca2                	ld	s9,8(sp)
    800016ee:	6125                	addi	sp,sp,96
    800016f0:	8082                	ret
    800016f2:	fffa0713          	addi	a4,s4,-1 # fff <_entry-0x7ffff001>
    800016f6:	974a                	add	a4,a4,s2
      --max;
    800016f8:	40a70a33          	sub	s4,a4,a0
    srcva = va0 + PGSIZE;
    800016fc:	015984b3          	add	s1,s3,s5
  while (got_null == 0 && max > 0) {
    80001700:	04e50563          	beq	a0,a4,8000174a <copyinstr+0xc0>
{
    80001704:	893e                	mv	s2,a5
    va0 = PGROUNDDOWN(srcva);
    80001706:	0174f9b3          	and	s3,s1,s7
    pa0 = walkaddr(pagetable, va0);
    8000170a:	85ce                	mv	a1,s3
    8000170c:	855a                	mv	a0,s6
    8000170e:	8cbff0ef          	jal	80000fd8 <walkaddr>
    if (pa0 == 0) {
    80001712:	d15d                	beqz	a0,800016b8 <copyinstr+0x2e>
    n = PGSIZE - (srcva - va0);
    80001714:	40998633          	sub	a2,s3,s1
    80001718:	9656                	add	a2,a2,s5
    if (n > max)
    8000171a:	00ca7363          	bgeu	s4,a2,80001720 <copyinstr+0x96>
    8000171e:	8652                	mv	a2,s4
    while (n > 0) {
    80001720:	c61d                	beqz	a2,8000174e <copyinstr+0xc4>
    char *p = (char *)(pa0 + (srcva - va0));
    80001722:	03449593          	slli	a1,s1,0x34
    80001726:	91d1                	srli	a1,a1,0x34
    80001728:	95aa                	add	a1,a1,a0
    8000172a:	87ca                	mv	a5,s2
      if (*p == '\0') {
    8000172c:	412585b3          	sub	a1,a1,s2
    while (n > 0) {
    80001730:	964a                	add	a2,a2,s2
    80001732:	853e                	mv	a0,a5
      if (*p == '\0') {
    80001734:	00f58733          	add	a4,a1,a5
    80001738:	00074683          	lbu	a3,0(a4)
    8000173c:	d6d9                	beqz	a3,800016ca <copyinstr+0x40>
        *dst = *p;
    8000173e:	00d78023          	sb	a3,0(a5)
      dst++;
    80001742:	0785                	addi	a5,a5,1
    while (n > 0) {
    80001744:	fec797e3          	bne	a5,a2,80001732 <copyinstr+0xa8>
    80001748:	b76d                	j	800016f2 <copyinstr+0x68>
    srcva = va0 + PGSIZE;
    8000174a:	4781                	li	a5,0
    8000174c:	b751                	j	800016d0 <copyinstr+0x46>
    8000174e:	6485                	lui	s1,0x1
    80001750:	94ce                	add	s1,s1,s3
    80001752:	87ca                	mv	a5,s2
    80001754:	bf45                	j	80001704 <copyinstr+0x7a>
    80001756:	4781                	li	a5,0
  if (got_null) {
    80001758:	0017c793          	xori	a5,a5,1
    8000175c:	40f0053b          	negw	a0,a5
}
    80001760:	8082                	ret

0000000080001762 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80001762:	715d                	addi	sp,sp,-80
    80001764:	e486                	sd	ra,72(sp)
    80001766:	e0a2                	sd	s0,64(sp)
    80001768:	fc26                	sd	s1,56(sp)
    8000176a:	f84a                	sd	s2,48(sp)
    8000176c:	f44e                	sd	s3,40(sp)
    8000176e:	f052                	sd	s4,32(sp)
    80001770:	ec56                	sd	s5,24(sp)
    80001772:	e85a                	sd	s6,16(sp)
    80001774:	e45e                	sd	s7,8(sp)
    80001776:	0880                	addi	s0,sp,80
    80001778:	8aaa                	mv	s5,a0
    8000177a:	4481                	li	s1,0

  for (p = proc; p < &proc[NPROC]; p++) {
    char *pa = kalloc();
    if (pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int)(p - proc));
    8000177c:	000a57b7          	lui	a5,0xa5
    80001780:	fa578793          	addi	a5,a5,-91 # a4fa5 <_entry-0x7ff5b05b>
    80001784:	07b2                	slli	a5,a5,0xc
    80001786:	fa578793          	addi	a5,a5,-91
    8000178a:	4fa50937          	lui	s2,0x4fa50
    8000178e:	a4f90913          	addi	s2,s2,-1457 # 4fa4fa4f <_entry-0x305b05b1>
    80001792:	1902                	slli	s2,s2,0x20
    80001794:	993e                	add	s2,s2,a5
    80001796:	040009b7          	lui	s3,0x4000
    8000179a:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    8000179c:	09b2                	slli	s3,s3,0xc
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    8000179e:	4b99                	li	s7,6
    800017a0:	6b05                	lui	s6,0x1
  for (p = proc; p < &proc[NPROC]; p++) {
    800017a2:	6a19                	lui	s4,0x6
    800017a4:	a00a0a13          	addi	s4,s4,-1536 # 5a00 <_entry-0x7fffa600>
    char *pa = kalloc();
    800017a8:	b76ff0ef          	jal	80000b1e <kalloc>
    800017ac:	862a                	mv	a2,a0
    if (pa == 0)
    800017ae:	cd15                	beqz	a0,800017ea <proc_mapstacks+0x88>
    uint64 va = KSTACK((int)(p - proc));
    800017b0:	4034d593          	srai	a1,s1,0x3
    800017b4:	032585b3          	mul	a1,a1,s2
    800017b8:	05b6                	slli	a1,a1,0xd
    800017ba:	6789                	lui	a5,0x2
    800017bc:	9dbd                	addw	a1,a1,a5
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    800017be:	875e                	mv	a4,s7
    800017c0:	86da                	mv	a3,s6
    800017c2:	40b985b3          	sub	a1,s3,a1
    800017c6:	8556                	mv	a0,s5
    800017c8:	8fbff0ef          	jal	800010c2 <kvmmap>
  for (p = proc; p < &proc[NPROC]; p++) {
    800017cc:	16848493          	addi	s1,s1,360 # 1168 <_entry-0x7fffee98>
    800017d0:	fd449ce3          	bne	s1,s4,800017a8 <proc_mapstacks+0x46>
  }
}
    800017d4:	60a6                	ld	ra,72(sp)
    800017d6:	6406                	ld	s0,64(sp)
    800017d8:	74e2                	ld	s1,56(sp)
    800017da:	7942                	ld	s2,48(sp)
    800017dc:	79a2                	ld	s3,40(sp)
    800017de:	7a02                	ld	s4,32(sp)
    800017e0:	6ae2                	ld	s5,24(sp)
    800017e2:	6b42                	ld	s6,16(sp)
    800017e4:	6ba2                	ld	s7,8(sp)
    800017e6:	6161                	addi	sp,sp,80
    800017e8:	8082                	ret
      panic("kalloc");
    800017ea:	00007517          	auipc	a0,0x7
    800017ee:	96650513          	addi	a0,a0,-1690 # 80008150 <etext+0x150>
    800017f2:	856ff0ef          	jal	80000848 <panic>

00000000800017f6 <procinit>:

// initialize the proc table.
void
procinit(void)
{
    800017f6:	7139                	addi	sp,sp,-64
    800017f8:	fc06                	sd	ra,56(sp)
    800017fa:	f822                	sd	s0,48(sp)
    800017fc:	f426                	sd	s1,40(sp)
    800017fe:	f04a                	sd	s2,32(sp)
    80001800:	ec4e                	sd	s3,24(sp)
    80001802:	e852                	sd	s4,16(sp)
    80001804:	e456                	sd	s5,8(sp)
    80001806:	e05a                	sd	s6,0(sp)
    80001808:	0080                	addi	s0,sp,64
  struct proc *p;

  initlock(&pid_lock, "nextpid");
    8000180a:	00007597          	auipc	a1,0x7
    8000180e:	94e58593          	addi	a1,a1,-1714 # 80008158 <etext+0x158>
    80001812:	0000f517          	auipc	a0,0xf
    80001816:	20e50513          	addi	a0,a0,526 # 80010a20 <pid_lock>
    8000181a:	b5eff0ef          	jal	80000b78 <initlock>
  initlock(&wait_lock, "wait_lock");
    8000181e:	00007597          	auipc	a1,0x7
    80001822:	94258593          	addi	a1,a1,-1726 # 80008160 <etext+0x160>
    80001826:	0000f517          	auipc	a0,0xf
    8000182a:	21250513          	addi	a0,a0,530 # 80010a38 <wait_lock>
    8000182e:	b4aff0ef          	jal	80000b78 <initlock>
    80001832:	4901                	li	s2,0
  for (p = proc; p < &proc[NPROC]; p++) {
    80001834:	0000f497          	auipc	s1,0xf
    80001838:	61c48493          	addi	s1,s1,1564 # 80010e50 <proc>
    initlock(&p->lock, "proc");
    8000183c:	00007a97          	auipc	s5,0x7
    80001840:	934a8a93          	addi	s5,s5,-1740 # 80008170 <etext+0x170>
    p->state = UNUSED;
    p->kstack = KSTACK((int)(p - proc));
    80001844:	000a57b7          	lui	a5,0xa5
    80001848:	fa578793          	addi	a5,a5,-91 # a4fa5 <_entry-0x7ff5b05b>
    8000184c:	07b2                	slli	a5,a5,0xc
    8000184e:	fa578793          	addi	a5,a5,-91
    80001852:	4fa509b7          	lui	s3,0x4fa50
    80001856:	a4f98993          	addi	s3,s3,-1457 # 4fa4fa4f <_entry-0x305b05b1>
    8000185a:	1982                	slli	s3,s3,0x20
    8000185c:	99be                	add	s3,s3,a5
    8000185e:	04000a37          	lui	s4,0x4000
    80001862:	1a7d                	addi	s4,s4,-1 # 3ffffff <_entry-0x7c000001>
    80001864:	0a32                	slli	s4,s4,0xc
  for (p = proc; p < &proc[NPROC]; p++) {
    80001866:	00015b17          	auipc	s6,0x15
    8000186a:	feab0b13          	addi	s6,s6,-22 # 80016850 <tickslock>
    initlock(&p->lock, "proc");
    8000186e:	85d6                	mv	a1,s5
    80001870:	8526                	mv	a0,s1
    80001872:	b06ff0ef          	jal	80000b78 <initlock>
    p->state = UNUSED;
    80001876:	0004ac23          	sw	zero,24(s1)
    p->kstack = KSTACK((int)(p - proc));
    8000187a:	40395793          	srai	a5,s2,0x3
    8000187e:	033787b3          	mul	a5,a5,s3
    80001882:	07b6                	slli	a5,a5,0xd
    80001884:	6709                	lui	a4,0x2
    80001886:	9fb9                	addw	a5,a5,a4
    80001888:	40fa07b3          	sub	a5,s4,a5
    8000188c:	e0bc                	sd	a5,64(s1)
  for (p = proc; p < &proc[NPROC]; p++) {
    8000188e:	16848493          	addi	s1,s1,360
    80001892:	16890913          	addi	s2,s2,360
    80001896:	fd649ce3          	bne	s1,s6,8000186e <procinit+0x78>
  }
}
    8000189a:	70e2                	ld	ra,56(sp)
    8000189c:	7442                	ld	s0,48(sp)
    8000189e:	74a2                	ld	s1,40(sp)
    800018a0:	7902                	ld	s2,32(sp)
    800018a2:	69e2                	ld	s3,24(sp)
    800018a4:	6a42                	ld	s4,16(sp)
    800018a6:	6aa2                	ld	s5,8(sp)
    800018a8:	6b02                	ld	s6,0(sp)
    800018aa:	6121                	addi	sp,sp,64
    800018ac:	8082                	ret

00000000800018ae <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    800018ae:	1141                	addi	sp,sp,-16
    800018b0:	e406                	sd	ra,8(sp)
    800018b2:	e022                	sd	s0,0(sp)
    800018b4:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r"(x));
    800018b6:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    800018b8:	2501                	sext.w	a0,a0
    800018ba:	60a2                	ld	ra,8(sp)
    800018bc:	6402                	ld	s0,0(sp)
    800018be:	0141                	addi	sp,sp,16
    800018c0:	8082                	ret

00000000800018c2 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu *
mycpu(void)
{
    800018c2:	1141                	addi	sp,sp,-16
    800018c4:	e406                	sd	ra,8(sp)
    800018c6:	e022                	sd	s0,0(sp)
    800018c8:	0800                	addi	s0,sp,16
    800018ca:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    800018cc:	2781                	sext.w	a5,a5
    800018ce:	079e                	slli	a5,a5,0x7
  return c;
}
    800018d0:	0000f517          	auipc	a0,0xf
    800018d4:	18050513          	addi	a0,a0,384 # 80010a50 <cpus>
    800018d8:	953e                	add	a0,a0,a5
    800018da:	60a2                	ld	ra,8(sp)
    800018dc:	6402                	ld	s0,0(sp)
    800018de:	0141                	addi	sp,sp,16
    800018e0:	8082                	ret

00000000800018e2 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc *
myproc(void)
{
    800018e2:	1101                	addi	sp,sp,-32
    800018e4:	ec06                	sd	ra,24(sp)
    800018e6:	e822                	sd	s0,16(sp)
    800018e8:	e426                	sd	s1,8(sp)
    800018ea:	1000                	addi	s0,sp,32
  push_off();
    800018ec:	ad2ff0ef          	jal	80000bbe <push_off>
    800018f0:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    800018f2:	2781                	sext.w	a5,a5
    800018f4:	079e                	slli	a5,a5,0x7
    800018f6:	0000f717          	auipc	a4,0xf
    800018fa:	12a70713          	addi	a4,a4,298 # 80010a20 <pid_lock>
    800018fe:	97ba                	add	a5,a5,a4
    80001900:	7b9c                	ld	a5,48(a5)
    80001902:	84be                	mv	s1,a5
  pop_off();
    80001904:	b30ff0ef          	jal	80000c34 <pop_off>
  return p;
}
    80001908:	8526                	mv	a0,s1
    8000190a:	60e2                	ld	ra,24(sp)
    8000190c:	6442                	ld	s0,16(sp)
    8000190e:	64a2                	ld	s1,8(sp)
    80001910:	6105                	addi	sp,sp,32
    80001912:	8082                	ret

0000000080001914 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80001914:	7179                	addi	sp,sp,-48
    80001916:	f406                	sd	ra,40(sp)
    80001918:	f022                	sd	s0,32(sp)
    8000191a:	ec26                	sd	s1,24(sp)
    8000191c:	1800                	addi	s0,sp,48
  extern char userret[];
  static int first = 1;
  struct proc *p = myproc();
    8000191e:	fc5ff0ef          	jal	800018e2 <myproc>
    80001922:	84aa                	mv	s1,a0

  // Still holding p->lock from scheduler.
  release(&p->lock);
    80001924:	b58ff0ef          	jal	80000c7c <release>

  if (__atomic_load_n(&first, __ATOMIC_ACQUIRE)) {
    80001928:	00007797          	auipc	a5,0x7
    8000192c:	fa878793          	addi	a5,a5,-88 # 800088d0 <first.1>
    80001930:	439c                	lw	a5,0(a5)
    80001932:	0230000f          	fence	r,rw
    80001936:	2781                	sext.w	a5,a5
    80001938:	c3a1                	beqz	a5,80001978 <forkret+0x64>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    fsinit(ROOTDEV);
    8000193a:	4505                	li	a0,1
    8000193c:	53f010ef          	jal	8000367a <fsinit>

    // ensure other cores see first=0.
    __atomic_store_n(&first, 0, __ATOMIC_RELEASE);
    80001940:	00007797          	auipc	a5,0x7
    80001944:	f9078793          	addi	a5,a5,-112 # 800088d0 <first.1>
    80001948:	0310000f          	fence	rw,w
    8000194c:	0007a023          	sw	zero,0(a5)

    // We can invoke kexec() now that file system is initialized.
    // Put the return value (argc) of kexec into a0.
    p->trapframe->a0 = kexec("/init", (char *[]){"/init", 0});
    80001950:	00007797          	auipc	a5,0x7
    80001954:	82878793          	addi	a5,a5,-2008 # 80008178 <etext+0x178>
    80001958:	fcf43823          	sd	a5,-48(s0)
    8000195c:	fc043c23          	sd	zero,-40(s0)
    80001960:	fd040593          	addi	a1,s0,-48
    80001964:	853e                	mv	a0,a5
    80001966:	13e030ef          	jal	80004aa4 <kexec>
    8000196a:	6cbc                	ld	a5,88(s1)
    8000196c:	fba8                	sd	a0,112(a5)
    if (p->trapframe->a0 == -1) {
    8000196e:	6cbc                	ld	a5,88(s1)
    80001970:	7bb8                	ld	a4,112(a5)
    80001972:	57fd                	li	a5,-1
    80001974:	02f70d63          	beq	a4,a5,800019ae <forkret+0x9a>
      panic("exec");
    }
  }

  // return to user space, mimicing usertrap()'s return.
  prepare_return();
    80001978:	2e1000ef          	jal	80002458 <prepare_return>
  uint64 satp = MAKE_SATP(p->pagetable);
    8000197c:	68a8                	ld	a0,80(s1)
    8000197e:	8131                	srli	a0,a0,0xc
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80001980:	04000737          	lui	a4,0x4000
    80001984:	177d                	addi	a4,a4,-1 # 3ffffff <_entry-0x7c000001>
    80001986:	0732                	slli	a4,a4,0xc
    80001988:	00005797          	auipc	a5,0x5
    8000198c:	71478793          	addi	a5,a5,1812 # 8000709c <userret>
    80001990:	00005697          	auipc	a3,0x5
    80001994:	67068693          	addi	a3,a3,1648 # 80007000 <_trampoline>
    80001998:	8f95                	sub	a5,a5,a3
    8000199a:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    8000199c:	577d                	li	a4,-1
    8000199e:	177e                	slli	a4,a4,0x3f
    800019a0:	8d59                	or	a0,a0,a4
    800019a2:	9782                	jalr	a5
}
    800019a4:	70a2                	ld	ra,40(sp)
    800019a6:	7402                	ld	s0,32(sp)
    800019a8:	64e2                	ld	s1,24(sp)
    800019aa:	6145                	addi	sp,sp,48
    800019ac:	8082                	ret
      panic("exec");
    800019ae:	00006517          	auipc	a0,0x6
    800019b2:	7d250513          	addi	a0,a0,2002 # 80008180 <etext+0x180>
    800019b6:	e93fe0ef          	jal	80000848 <panic>

00000000800019ba <allocpid>:
{
    800019ba:	1101                	addi	sp,sp,-32
    800019bc:	ec06                	sd	ra,24(sp)
    800019be:	e822                	sd	s0,16(sp)
    800019c0:	e426                	sd	s1,8(sp)
    800019c2:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    800019c4:	0000f517          	auipc	a0,0xf
    800019c8:	05c50513          	addi	a0,a0,92 # 80010a20 <pid_lock>
    800019cc:	a2cff0ef          	jal	80000bf8 <acquire>
  pid = nextpid;
    800019d0:	00007797          	auipc	a5,0x7
    800019d4:	f0478793          	addi	a5,a5,-252 # 800088d4 <nextpid>
    800019d8:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    800019da:	0014871b          	addiw	a4,s1,1
    800019de:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    800019e0:	0000f517          	auipc	a0,0xf
    800019e4:	04050513          	addi	a0,a0,64 # 80010a20 <pid_lock>
    800019e8:	a94ff0ef          	jal	80000c7c <release>
}
    800019ec:	8526                	mv	a0,s1
    800019ee:	60e2                	ld	ra,24(sp)
    800019f0:	6442                	ld	s0,16(sp)
    800019f2:	64a2                	ld	s1,8(sp)
    800019f4:	6105                	addi	sp,sp,32
    800019f6:	8082                	ret

00000000800019f8 <proc_pagetable>:
{
    800019f8:	1101                	addi	sp,sp,-32
    800019fa:	ec06                	sd	ra,24(sp)
    800019fc:	e822                	sd	s0,16(sp)
    800019fe:	e426                	sd	s1,8(sp)
    80001a00:	e04a                	sd	s2,0(sp)
    80001a02:	1000                	addi	s0,sp,32
    80001a04:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80001a06:	faaff0ef          	jal	800011b0 <uvmcreate>
    80001a0a:	84aa                	mv	s1,a0
  if (pagetable == 0)
    80001a0c:	cd05                	beqz	a0,80001a44 <proc_pagetable+0x4c>
  if (mappages(pagetable, TRAMPOLINE, PGSIZE, (uint64)trampoline,
    80001a0e:	4729                	li	a4,10
    80001a10:	00005697          	auipc	a3,0x5
    80001a14:	5f068693          	addi	a3,a3,1520 # 80007000 <_trampoline>
    80001a18:	6605                	lui	a2,0x1
    80001a1a:	040005b7          	lui	a1,0x4000
    80001a1e:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001a20:	05b2                	slli	a1,a1,0xc
    80001a22:	deeff0ef          	jal	80001010 <mappages>
    80001a26:	02054663          	bltz	a0,80001a52 <proc_pagetable+0x5a>
  if (mappages(pagetable, TRAPFRAME, PGSIZE, (uint64)(p->trapframe),
    80001a2a:	4719                	li	a4,6
    80001a2c:	05893683          	ld	a3,88(s2)
    80001a30:	6605                	lui	a2,0x1
    80001a32:	020005b7          	lui	a1,0x2000
    80001a36:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001a38:	05b6                	slli	a1,a1,0xd
    80001a3a:	8526                	mv	a0,s1
    80001a3c:	dd4ff0ef          	jal	80001010 <mappages>
    80001a40:	00054f63          	bltz	a0,80001a5e <proc_pagetable+0x66>
}
    80001a44:	8526                	mv	a0,s1
    80001a46:	60e2                	ld	ra,24(sp)
    80001a48:	6442                	ld	s0,16(sp)
    80001a4a:	64a2                	ld	s1,8(sp)
    80001a4c:	6902                	ld	s2,0(sp)
    80001a4e:	6105                	addi	sp,sp,32
    80001a50:	8082                	ret
    uvmfree(pagetable, 0);
    80001a52:	4581                	li	a1,0
    80001a54:	8526                	mv	a0,s1
    80001a56:	94dff0ef          	jal	800013a2 <uvmfree>
    return 0;
    80001a5a:	4481                	li	s1,0
    80001a5c:	b7e5                	j	80001a44 <proc_pagetable+0x4c>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001a5e:	4681                	li	a3,0
    80001a60:	4605                	li	a2,1
    80001a62:	040005b7          	lui	a1,0x4000
    80001a66:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001a68:	05b2                	slli	a1,a1,0xc
    80001a6a:	8526                	mv	a0,s1
    80001a6c:	f6aff0ef          	jal	800011d6 <uvmunmap>
    uvmfree(pagetable, 0);
    80001a70:	4581                	li	a1,0
    80001a72:	8526                	mv	a0,s1
    80001a74:	92fff0ef          	jal	800013a2 <uvmfree>
    return 0;
    80001a78:	b7cd                	j	80001a5a <proc_pagetable+0x62>

0000000080001a7a <proc_freepagetable>:
{
    80001a7a:	1101                	addi	sp,sp,-32
    80001a7c:	ec06                	sd	ra,24(sp)
    80001a7e:	e822                	sd	s0,16(sp)
    80001a80:	e426                	sd	s1,8(sp)
    80001a82:	e04a                	sd	s2,0(sp)
    80001a84:	1000                	addi	s0,sp,32
    80001a86:	84aa                	mv	s1,a0
    80001a88:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001a8a:	4681                	li	a3,0
    80001a8c:	4605                	li	a2,1
    80001a8e:	040005b7          	lui	a1,0x4000
    80001a92:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001a94:	05b2                	slli	a1,a1,0xc
    80001a96:	f40ff0ef          	jal	800011d6 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80001a9a:	4681                	li	a3,0
    80001a9c:	4605                	li	a2,1
    80001a9e:	020005b7          	lui	a1,0x2000
    80001aa2:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001aa4:	05b6                	slli	a1,a1,0xd
    80001aa6:	8526                	mv	a0,s1
    80001aa8:	f2eff0ef          	jal	800011d6 <uvmunmap>
  uvmfree(pagetable, sz);
    80001aac:	85ca                	mv	a1,s2
    80001aae:	8526                	mv	a0,s1
    80001ab0:	8f3ff0ef          	jal	800013a2 <uvmfree>
}
    80001ab4:	60e2                	ld	ra,24(sp)
    80001ab6:	6442                	ld	s0,16(sp)
    80001ab8:	64a2                	ld	s1,8(sp)
    80001aba:	6902                	ld	s2,0(sp)
    80001abc:	6105                	addi	sp,sp,32
    80001abe:	8082                	ret

0000000080001ac0 <freeproc>:
{
    80001ac0:	1101                	addi	sp,sp,-32
    80001ac2:	ec06                	sd	ra,24(sp)
    80001ac4:	e822                	sd	s0,16(sp)
    80001ac6:	e426                	sd	s1,8(sp)
    80001ac8:	1000                	addi	s0,sp,32
    80001aca:	84aa                	mv	s1,a0
  if (p->trapframe)
    80001acc:	6d28                	ld	a0,88(a0)
    80001ace:	c119                	beqz	a0,80001ad4 <freeproc+0x14>
    kfree((void *)p->trapframe);
    80001ad0:	f67fe0ef          	jal	80000a36 <kfree>
  p->trapframe = 0;
    80001ad4:	0404bc23          	sd	zero,88(s1)
  if (p->pagetable)
    80001ad8:	68a8                	ld	a0,80(s1)
    80001ada:	c501                	beqz	a0,80001ae2 <freeproc+0x22>
    proc_freepagetable(p->pagetable, p->sz);
    80001adc:	64ac                	ld	a1,72(s1)
    80001ade:	f9dff0ef          	jal	80001a7a <proc_freepagetable>
  p->pagetable = 0;
    80001ae2:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001ae6:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001aea:	0204a823          	sw	zero,48(s1)
  p->name[0] = 0;
    80001aee:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001af2:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001af6:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001afa:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001afe:	0004ac23          	sw	zero,24(s1)
}
    80001b02:	60e2                	ld	ra,24(sp)
    80001b04:	6442                	ld	s0,16(sp)
    80001b06:	64a2                	ld	s1,8(sp)
    80001b08:	6105                	addi	sp,sp,32
    80001b0a:	8082                	ret

0000000080001b0c <allocproc>:
{
    80001b0c:	1101                	addi	sp,sp,-32
    80001b0e:	ec06                	sd	ra,24(sp)
    80001b10:	e822                	sd	s0,16(sp)
    80001b12:	e426                	sd	s1,8(sp)
    80001b14:	e04a                	sd	s2,0(sp)
    80001b16:	1000                	addi	s0,sp,32
  for (p = proc; p < &proc[NPROC]; p++) {
    80001b18:	0000f497          	auipc	s1,0xf
    80001b1c:	33848493          	addi	s1,s1,824 # 80010e50 <proc>
    80001b20:	00015917          	auipc	s2,0x15
    80001b24:	d3090913          	addi	s2,s2,-720 # 80016850 <tickslock>
    acquire(&p->lock);
    80001b28:	8526                	mv	a0,s1
    80001b2a:	8ceff0ef          	jal	80000bf8 <acquire>
    if (p->state == UNUSED) {
    80001b2e:	4c9c                	lw	a5,24(s1)
    80001b30:	cb91                	beqz	a5,80001b44 <allocproc+0x38>
      release(&p->lock);
    80001b32:	8526                	mv	a0,s1
    80001b34:	948ff0ef          	jal	80000c7c <release>
  for (p = proc; p < &proc[NPROC]; p++) {
    80001b38:	16848493          	addi	s1,s1,360
    80001b3c:	ff2496e3          	bne	s1,s2,80001b28 <allocproc+0x1c>
  return 0;
    80001b40:	4481                	li	s1,0
    80001b42:	a089                	j	80001b84 <allocproc+0x78>
  p->pid = allocpid();
    80001b44:	e77ff0ef          	jal	800019ba <allocpid>
    80001b48:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001b4a:	4785                	li	a5,1
    80001b4c:	cc9c                	sw	a5,24(s1)
  if ((p->trapframe = (struct trapframe *)kalloc()) == 0) {
    80001b4e:	fd1fe0ef          	jal	80000b1e <kalloc>
    80001b52:	892a                	mv	s2,a0
    80001b54:	eca8                	sd	a0,88(s1)
    80001b56:	cd15                	beqz	a0,80001b92 <allocproc+0x86>
  p->pagetable = proc_pagetable(p);
    80001b58:	8526                	mv	a0,s1
    80001b5a:	e9fff0ef          	jal	800019f8 <proc_pagetable>
    80001b5e:	892a                	mv	s2,a0
    80001b60:	e8a8                	sd	a0,80(s1)
  if (p->pagetable == 0) {
    80001b62:	c121                	beqz	a0,80001ba2 <allocproc+0x96>
  memset(&p->context, 0, sizeof(p->context));
    80001b64:	07000613          	li	a2,112
    80001b68:	4581                	li	a1,0
    80001b6a:	06048513          	addi	a0,s1,96
    80001b6e:	946ff0ef          	jal	80000cb4 <memset>
  p->context.ra = (uint64)forkret;
    80001b72:	00000797          	auipc	a5,0x0
    80001b76:	da278793          	addi	a5,a5,-606 # 80001914 <forkret>
    80001b7a:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001b7c:	60bc                	ld	a5,64(s1)
    80001b7e:	6705                	lui	a4,0x1
    80001b80:	97ba                	add	a5,a5,a4
    80001b82:	f4bc                	sd	a5,104(s1)
}
    80001b84:	8526                	mv	a0,s1
    80001b86:	60e2                	ld	ra,24(sp)
    80001b88:	6442                	ld	s0,16(sp)
    80001b8a:	64a2                	ld	s1,8(sp)
    80001b8c:	6902                	ld	s2,0(sp)
    80001b8e:	6105                	addi	sp,sp,32
    80001b90:	8082                	ret
    freeproc(p);
    80001b92:	8526                	mv	a0,s1
    80001b94:	f2dff0ef          	jal	80001ac0 <freeproc>
    release(&p->lock);
    80001b98:	8526                	mv	a0,s1
    80001b9a:	8e2ff0ef          	jal	80000c7c <release>
    return 0;
    80001b9e:	84ca                	mv	s1,s2
    80001ba0:	b7d5                	j	80001b84 <allocproc+0x78>
    freeproc(p);
    80001ba2:	8526                	mv	a0,s1
    80001ba4:	f1dff0ef          	jal	80001ac0 <freeproc>
    release(&p->lock);
    80001ba8:	8526                	mv	a0,s1
    80001baa:	8d2ff0ef          	jal	80000c7c <release>
    return 0;
    80001bae:	84ca                	mv	s1,s2
    80001bb0:	bfd1                	j	80001b84 <allocproc+0x78>

0000000080001bb2 <userinit>:
{
    80001bb2:	1101                	addi	sp,sp,-32
    80001bb4:	ec06                	sd	ra,24(sp)
    80001bb6:	e822                	sd	s0,16(sp)
    80001bb8:	e426                	sd	s1,8(sp)
    80001bba:	1000                	addi	s0,sp,32
  p = allocproc();
    80001bbc:	f51ff0ef          	jal	80001b0c <allocproc>
    80001bc0:	84aa                	mv	s1,a0
  initproc = p;
    80001bc2:	00007797          	auipc	a5,0x7
    80001bc6:	d2a7bb23          	sd	a0,-714(a5) # 800088f8 <initproc>
  p->cwd = namei("/");
    80001bca:	00006517          	auipc	a0,0x6
    80001bce:	5be50513          	addi	a0,a0,1470 # 80008188 <etext+0x188>
    80001bd2:	004020ef          	jal	80003bd6 <namei>
    80001bd6:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001bda:	478d                	li	a5,3
    80001bdc:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001bde:	8526                	mv	a0,s1
    80001be0:	89cff0ef          	jal	80000c7c <release>
}
    80001be4:	60e2                	ld	ra,24(sp)
    80001be6:	6442                	ld	s0,16(sp)
    80001be8:	64a2                	ld	s1,8(sp)
    80001bea:	6105                	addi	sp,sp,32
    80001bec:	8082                	ret

0000000080001bee <growproc>:
{
    80001bee:	1101                	addi	sp,sp,-32
    80001bf0:	ec06                	sd	ra,24(sp)
    80001bf2:	e822                	sd	s0,16(sp)
    80001bf4:	e426                	sd	s1,8(sp)
    80001bf6:	e04a                	sd	s2,0(sp)
    80001bf8:	1000                	addi	s0,sp,32
    80001bfa:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001bfc:	ce7ff0ef          	jal	800018e2 <myproc>
    80001c00:	892a                	mv	s2,a0
  sz = p->sz;
    80001c02:	652c                	ld	a1,72(a0)
  if (n > 0) {
    80001c04:	02905b63          	blez	s1,80001c3a <growproc+0x4c>
    if (sz + n > TRAPFRAME) {
    80001c08:	00b48633          	add	a2,s1,a1
    80001c0c:	020007b7          	lui	a5,0x2000
    80001c10:	17fd                	addi	a5,a5,-1 # 1ffffff <_entry-0x7e000001>
    80001c12:	07b6                	slli	a5,a5,0xd
    80001c14:	02c7e163          	bltu	a5,a2,80001c36 <growproc+0x48>
    if ((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80001c18:	4691                	li	a3,4
    80001c1a:	6928                	ld	a0,80(a0)
    80001c1c:	e8aff0ef          	jal	800012a6 <uvmalloc>
    80001c20:	85aa                	mv	a1,a0
    80001c22:	c911                	beqz	a0,80001c36 <growproc+0x48>
  p->sz = sz;
    80001c24:	04b93423          	sd	a1,72(s2)
  return 0;
    80001c28:	4501                	li	a0,0
}
    80001c2a:	60e2                	ld	ra,24(sp)
    80001c2c:	6442                	ld	s0,16(sp)
    80001c2e:	64a2                	ld	s1,8(sp)
    80001c30:	6902                	ld	s2,0(sp)
    80001c32:	6105                	addi	sp,sp,32
    80001c34:	8082                	ret
      return -1;
    80001c36:	557d                	li	a0,-1
    80001c38:	bfcd                	j	80001c2a <growproc+0x3c>
  } else if (n < 0) {
    80001c3a:	fe04d5e3          	bgez	s1,80001c24 <growproc+0x36>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001c3e:	00b48633          	add	a2,s1,a1
    80001c42:	6928                	ld	a0,80(a0)
    80001c44:	e1cff0ef          	jal	80001260 <uvmdealloc>
    80001c48:	85aa                	mv	a1,a0
    80001c4a:	bfe9                	j	80001c24 <growproc+0x36>

0000000080001c4c <kfork>:
{
    80001c4c:	7139                	addi	sp,sp,-64
    80001c4e:	fc06                	sd	ra,56(sp)
    80001c50:	f822                	sd	s0,48(sp)
    80001c52:	f426                	sd	s1,40(sp)
    80001c54:	e456                	sd	s5,8(sp)
    80001c56:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001c58:	c8bff0ef          	jal	800018e2 <myproc>
    80001c5c:	8aaa                	mv	s5,a0
  if ((np = allocproc()) == 0) {
    80001c5e:	eafff0ef          	jal	80001b0c <allocproc>
    80001c62:	c92d                	beqz	a0,80001cd4 <kfork+0x88>
    80001c64:	e852                	sd	s4,16(sp)
    80001c66:	8a2a                	mv	s4,a0
  if (uvmcopy(p->pagetable, np->pagetable, p->sz) < 0) {
    80001c68:	048ab603          	ld	a2,72(s5)
    80001c6c:	692c                	ld	a1,80(a0)
    80001c6e:	050ab503          	ld	a0,80(s5)
    80001c72:	f62ff0ef          	jal	800013d4 <uvmcopy>
    80001c76:	04054863          	bltz	a0,80001cc6 <kfork+0x7a>
    80001c7a:	f04a                	sd	s2,32(sp)
    80001c7c:	ec4e                	sd	s3,24(sp)
  np->sz = p->sz;
    80001c7e:	048ab783          	ld	a5,72(s5)
    80001c82:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    80001c86:	058ab683          	ld	a3,88(s5)
    80001c8a:	87b6                	mv	a5,a3
    80001c8c:	058a3703          	ld	a4,88(s4)
    80001c90:	12068693          	addi	a3,a3,288
    80001c94:	6388                	ld	a0,0(a5)
    80001c96:	678c                	ld	a1,8(a5)
    80001c98:	6b90                	ld	a2,16(a5)
    80001c9a:	e308                	sd	a0,0(a4)
    80001c9c:	e70c                	sd	a1,8(a4)
    80001c9e:	eb10                	sd	a2,16(a4)
    80001ca0:	6f90                	ld	a2,24(a5)
    80001ca2:	ef10                	sd	a2,24(a4)
    80001ca4:	02078793          	addi	a5,a5,32
    80001ca8:	02070713          	addi	a4,a4,32 # 1020 <_entry-0x7fffefe0>
    80001cac:	fed794e3          	bne	a5,a3,80001c94 <kfork+0x48>
  np->trapframe->a0 = 0;
    80001cb0:	058a3783          	ld	a5,88(s4)
    80001cb4:	0607b823          	sd	zero,112(a5)
  for (i = 0; i < NOFILE; i++)
    80001cb8:	0d0a8493          	addi	s1,s5,208
    80001cbc:	0d0a0913          	addi	s2,s4,208
    80001cc0:	150a8993          	addi	s3,s5,336
    80001cc4:	a831                	j	80001ce0 <kfork+0x94>
    freeproc(np);
    80001cc6:	8552                	mv	a0,s4
    80001cc8:	df9ff0ef          	jal	80001ac0 <freeproc>
    release(&np->lock);
    80001ccc:	8552                	mv	a0,s4
    80001cce:	faffe0ef          	jal	80000c7c <release>
    return -1;
    80001cd2:	6a42                	ld	s4,16(sp)
    return -1;
    80001cd4:	54fd                	li	s1,-1
    80001cd6:	a885                	j	80001d46 <kfork+0xfa>
  for (i = 0; i < NOFILE; i++)
    80001cd8:	04a1                	addi	s1,s1,8
    80001cda:	0921                	addi	s2,s2,8
    80001cdc:	01348963          	beq	s1,s3,80001cee <kfork+0xa2>
    if (p->ofile[i])
    80001ce0:	6088                	ld	a0,0(s1)
    80001ce2:	d97d                	beqz	a0,80001cd8 <kfork+0x8c>
      np->ofile[i] = filedup(p->ofile[i]);
    80001ce4:	6ee020ef          	jal	800043d2 <filedup>
    80001ce8:	00a93023          	sd	a0,0(s2)
    80001cec:	b7f5                	j	80001cd8 <kfork+0x8c>
  np->cwd = idup(p->cwd);
    80001cee:	150ab503          	ld	a0,336(s5)
    80001cf2:	588010ef          	jal	8000327a <idup>
    80001cf6:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001cfa:	4641                	li	a2,16
    80001cfc:	158a8593          	addi	a1,s5,344
    80001d00:	158a0513          	addi	a0,s4,344
    80001d04:	8faff0ef          	jal	80000dfe <safestrcpy>
  pid = np->pid;
    80001d08:	030a2483          	lw	s1,48(s4)
  release(&np->lock);
    80001d0c:	8552                	mv	a0,s4
    80001d0e:	f6ffe0ef          	jal	80000c7c <release>
  acquire(&wait_lock);
    80001d12:	0000f517          	auipc	a0,0xf
    80001d16:	d2650513          	addi	a0,a0,-730 # 80010a38 <wait_lock>
    80001d1a:	edffe0ef          	jal	80000bf8 <acquire>
  np->parent = p;
    80001d1e:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    80001d22:	0000f517          	auipc	a0,0xf
    80001d26:	d1650513          	addi	a0,a0,-746 # 80010a38 <wait_lock>
    80001d2a:	f53fe0ef          	jal	80000c7c <release>
  acquire(&np->lock);
    80001d2e:	8552                	mv	a0,s4
    80001d30:	ec9fe0ef          	jal	80000bf8 <acquire>
  np->state = RUNNABLE;
    80001d34:	478d                	li	a5,3
    80001d36:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    80001d3a:	8552                	mv	a0,s4
    80001d3c:	f41fe0ef          	jal	80000c7c <release>
    80001d40:	7902                	ld	s2,32(sp)
    80001d42:	69e2                	ld	s3,24(sp)
    80001d44:	6a42                	ld	s4,16(sp)
}
    80001d46:	8526                	mv	a0,s1
    80001d48:	70e2                	ld	ra,56(sp)
    80001d4a:	7442                	ld	s0,48(sp)
    80001d4c:	74a2                	ld	s1,40(sp)
    80001d4e:	6aa2                	ld	s5,8(sp)
    80001d50:	6121                	addi	sp,sp,64
    80001d52:	8082                	ret

0000000080001d54 <scheduler>:
{
    80001d54:	711d                	addi	sp,sp,-96
    80001d56:	ec86                	sd	ra,88(sp)
    80001d58:	e8a2                	sd	s0,80(sp)
    80001d5a:	e4a6                	sd	s1,72(sp)
    80001d5c:	e0ca                	sd	s2,64(sp)
    80001d5e:	fc4e                	sd	s3,56(sp)
    80001d60:	f852                	sd	s4,48(sp)
    80001d62:	f456                	sd	s5,40(sp)
    80001d64:	f05a                	sd	s6,32(sp)
    80001d66:	ec5e                	sd	s7,24(sp)
    80001d68:	e862                	sd	s8,16(sp)
    80001d6a:	e466                	sd	s9,8(sp)
    80001d6c:	1080                	addi	s0,sp,96
    80001d6e:	8792                	mv	a5,tp
  int id = r_tp();
    80001d70:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001d72:	00779693          	slli	a3,a5,0x7
    80001d76:	0000f717          	auipc	a4,0xf
    80001d7a:	caa70713          	addi	a4,a4,-854 # 80010a20 <pid_lock>
    80001d7e:	9736                	add	a4,a4,a3
    80001d80:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001d84:	0000fa97          	auipc	s5,0xf
    80001d88:	cd4a8a93          	addi	s5,s5,-812 # 80010a58 <cpus+0x8>
    80001d8c:	9ab6                	add	s5,s5,a3
        p->state = RUNNING;
    80001d8e:	4c11                	li	s8,4
        c->proc = p;
    80001d90:	0000fb17          	auipc	s6,0xf
    80001d94:	c90b0b13          	addi	s6,s6,-880 # 80010a20 <pid_lock>
    80001d98:	8a3a                	mv	s4,a4
        found = 1;
    80001d9a:	4b85                	li	s7,1
    80001d9c:	a0a9                	j	80001de6 <scheduler+0x92>
      release(&p->lock);
    80001d9e:	8526                	mv	a0,s1
    80001da0:	eddfe0ef          	jal	80000c7c <release>
    for (p = proc; p < &proc[NPROC]; p++) {
    80001da4:	16848493          	addi	s1,s1,360
    80001da8:	03248b63          	beq	s1,s2,80001dde <scheduler+0x8a>
      acquire(&p->lock);
    80001dac:	8526                	mv	a0,s1
    80001dae:	e4bfe0ef          	jal	80000bf8 <acquire>
      if (p->state == RUNNABLE) {
    80001db2:	4c9c                	lw	a5,24(s1)
    80001db4:	ff3795e3          	bne	a5,s3,80001d9e <scheduler+0x4a>
        p->state = RUNNING;
    80001db8:	0184ac23          	sw	s8,24(s1)
        c->proc = p;
    80001dbc:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    80001dc0:	06048593          	addi	a1,s1,96
    80001dc4:	8556                	mv	a0,s5
    80001dc6:	5e8000ef          	jal	800023ae <swtch>
    80001dca:	8792                	mv	a5,tp
        mycpu()->intena = 0;
    80001dcc:	2781                	sext.w	a5,a5
    80001dce:	079e                	slli	a5,a5,0x7
    80001dd0:	97da                	add	a5,a5,s6
    80001dd2:	0a07a623          	sw	zero,172(a5)
        c->proc = 0;
    80001dd6:	020a3823          	sd	zero,48(s4)
        found = 1;
    80001dda:	8cde                	mv	s9,s7
    80001ddc:	b7c9                	j	80001d9e <scheduler+0x4a>
    if (found == 0) {
    80001dde:	000c9463          	bnez	s9,80001de6 <scheduler+0x92>
      asm volatile("wfi");
    80001de2:	10500073          	wfi
  __asm__ __volatile__("csrs sstatus, %0" ::"rK"(x) : "memory");
    80001de6:	10016073          	csrsi	sstatus,2
  __asm__ __volatile__("csrc sstatus, %0" ::"rK"(x) : "memory");
    80001dea:	10017073          	csrci	sstatus,2
    int found = 0;
    80001dee:	4c81                	li	s9,0
    for (p = proc; p < &proc[NPROC]; p++) {
    80001df0:	0000f497          	auipc	s1,0xf
    80001df4:	06048493          	addi	s1,s1,96 # 80010e50 <proc>
      if (p->state == RUNNABLE) {
    80001df8:	498d                	li	s3,3
    for (p = proc; p < &proc[NPROC]; p++) {
    80001dfa:	00015917          	auipc	s2,0x15
    80001dfe:	a5690913          	addi	s2,s2,-1450 # 80016850 <tickslock>
    80001e02:	b76d                	j	80001dac <scheduler+0x58>

0000000080001e04 <sched>:
{
    80001e04:	7179                	addi	sp,sp,-48
    80001e06:	f406                	sd	ra,40(sp)
    80001e08:	f022                	sd	s0,32(sp)
    80001e0a:	ec26                	sd	s1,24(sp)
    80001e0c:	e84a                	sd	s2,16(sp)
    80001e0e:	e44e                	sd	s3,8(sp)
    80001e10:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001e12:	ad1ff0ef          	jal	800018e2 <myproc>
    80001e16:	84aa                	mv	s1,a0
  if (!holding(&p->lock))
    80001e18:	d7bfe0ef          	jal	80000b92 <holding>
    80001e1c:	c92d                	beqz	a0,80001e8e <sched+0x8a>
  asm volatile("mv %0, tp" : "=r"(x));
    80001e1e:	8792                	mv	a5,tp
  if (mycpu()->noff != 1)
    80001e20:	2781                	sext.w	a5,a5
    80001e22:	079e                	slli	a5,a5,0x7
    80001e24:	0000f717          	auipc	a4,0xf
    80001e28:	bfc70713          	addi	a4,a4,-1028 # 80010a20 <pid_lock>
    80001e2c:	97ba                	add	a5,a5,a4
    80001e2e:	0a87a703          	lw	a4,168(a5)
    80001e32:	4785                	li	a5,1
    80001e34:	06f71363          	bne	a4,a5,80001e9a <sched+0x96>
  if (p->state == RUNNING)
    80001e38:	4c98                	lw	a4,24(s1)
    80001e3a:	4791                	li	a5,4
    80001e3c:	06f70563          	beq	a4,a5,80001ea6 <sched+0xa2>
  asm volatile("csrr %0, sstatus" : "=r"(x));
    80001e40:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001e44:	8b89                	andi	a5,a5,2
  if (intr_get())
    80001e46:	e7b5                	bnez	a5,80001eb2 <sched+0xae>
  asm volatile("mv %0, tp" : "=r"(x));
    80001e48:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001e4a:	0000f917          	auipc	s2,0xf
    80001e4e:	bd690913          	addi	s2,s2,-1066 # 80010a20 <pid_lock>
    80001e52:	2781                	sext.w	a5,a5
    80001e54:	079e                	slli	a5,a5,0x7
    80001e56:	97ca                	add	a5,a5,s2
    80001e58:	0ac7a983          	lw	s3,172(a5)
    80001e5c:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001e5e:	2781                	sext.w	a5,a5
    80001e60:	079e                	slli	a5,a5,0x7
    80001e62:	0000f597          	auipc	a1,0xf
    80001e66:	bf658593          	addi	a1,a1,-1034 # 80010a58 <cpus+0x8>
    80001e6a:	95be                	add	a1,a1,a5
    80001e6c:	06048513          	addi	a0,s1,96
    80001e70:	53e000ef          	jal	800023ae <swtch>
    80001e74:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001e76:	2781                	sext.w	a5,a5
    80001e78:	079e                	slli	a5,a5,0x7
    80001e7a:	993e                	add	s2,s2,a5
    80001e7c:	0b392623          	sw	s3,172(s2)
}
    80001e80:	70a2                	ld	ra,40(sp)
    80001e82:	7402                	ld	s0,32(sp)
    80001e84:	64e2                	ld	s1,24(sp)
    80001e86:	6942                	ld	s2,16(sp)
    80001e88:	69a2                	ld	s3,8(sp)
    80001e8a:	6145                	addi	sp,sp,48
    80001e8c:	8082                	ret
    panic("sched p->lock");
    80001e8e:	00006517          	auipc	a0,0x6
    80001e92:	30250513          	addi	a0,a0,770 # 80008190 <etext+0x190>
    80001e96:	9b3fe0ef          	jal	80000848 <panic>
    panic("sched locks");
    80001e9a:	00006517          	auipc	a0,0x6
    80001e9e:	30650513          	addi	a0,a0,774 # 800081a0 <etext+0x1a0>
    80001ea2:	9a7fe0ef          	jal	80000848 <panic>
    panic("sched RUNNING");
    80001ea6:	00006517          	auipc	a0,0x6
    80001eaa:	30a50513          	addi	a0,a0,778 # 800081b0 <etext+0x1b0>
    80001eae:	99bfe0ef          	jal	80000848 <panic>
    panic("sched interruptible");
    80001eb2:	00006517          	auipc	a0,0x6
    80001eb6:	30e50513          	addi	a0,a0,782 # 800081c0 <etext+0x1c0>
    80001eba:	98ffe0ef          	jal	80000848 <panic>

0000000080001ebe <yield>:
{
    80001ebe:	1101                	addi	sp,sp,-32
    80001ec0:	ec06                	sd	ra,24(sp)
    80001ec2:	e822                	sd	s0,16(sp)
    80001ec4:	e426                	sd	s1,8(sp)
    80001ec6:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80001ec8:	a1bff0ef          	jal	800018e2 <myproc>
    80001ecc:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001ece:	d2bfe0ef          	jal	80000bf8 <acquire>
  p->state = RUNNABLE;
    80001ed2:	478d                	li	a5,3
    80001ed4:	cc9c                	sw	a5,24(s1)
  sched();
    80001ed6:	f2fff0ef          	jal	80001e04 <sched>
  release(&p->lock);
    80001eda:	8526                	mv	a0,s1
    80001edc:	da1fe0ef          	jal	80000c7c <release>
}
    80001ee0:	60e2                	ld	ra,24(sp)
    80001ee2:	6442                	ld	s0,16(sp)
    80001ee4:	64a2                	ld	s1,8(sp)
    80001ee6:	6105                	addi	sp,sp,32
    80001ee8:	8082                	ret

0000000080001eea <sleep_prepare>:

// Register current process as waiting for wakeups on chan.
void
sleep_prepare(void *chan)
{
    80001eea:	1101                	addi	sp,sp,-32
    80001eec:	ec06                	sd	ra,24(sp)
    80001eee:	e822                	sd	s0,16(sp)
    80001ef0:	e426                	sd	s1,8(sp)
    80001ef2:	e04a                	sd	s2,0(sp)
    80001ef4:	1000                	addi	s0,sp,32
    80001ef6:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001ef8:	9ebff0ef          	jal	800018e2 <myproc>
    80001efc:	892a                	mv	s2,a0

  acquire(&p->lock);
    80001efe:	cfbfe0ef          	jal	80000bf8 <acquire>
  if (chan == 0)
    80001f02:	cc81                	beqz	s1,80001f1a <sleep_prepare+0x30>
    panic("sleep_prepare: zero chan");
  p->chan = chan;
    80001f04:	02993023          	sd	s1,32(s2)
  release(&p->lock);
    80001f08:	854a                	mv	a0,s2
    80001f0a:	d73fe0ef          	jal	80000c7c <release>
}
    80001f0e:	60e2                	ld	ra,24(sp)
    80001f10:	6442                	ld	s0,16(sp)
    80001f12:	64a2                	ld	s1,8(sp)
    80001f14:	6902                	ld	s2,0(sp)
    80001f16:	6105                	addi	sp,sp,32
    80001f18:	8082                	ret
    panic("sleep_prepare: zero chan");
    80001f1a:	00006517          	auipc	a0,0x6
    80001f1e:	2be50513          	addi	a0,a0,702 # 800081d8 <etext+0x1d8>
    80001f22:	927fe0ef          	jal	80000848 <panic>

0000000080001f26 <sleep>:
// Put the thread to sleep.  Assumes sleep_prepare() was called before.
// If the channel registered by sleep_prepare() has been woken up in
// the meantime, do not go to sleep, and instead return immediately.
void
sleep(void)
{
    80001f26:	1101                	addi	sp,sp,-32
    80001f28:	ec06                	sd	ra,24(sp)
    80001f2a:	e822                	sd	s0,16(sp)
    80001f2c:	e426                	sd	s1,8(sp)
    80001f2e:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80001f30:	9b3ff0ef          	jal	800018e2 <myproc>
    80001f34:	84aa                	mv	s1,a0

  acquire(&p->lock);
    80001f36:	cc3fe0ef          	jal	80000bf8 <acquire>
  if (p->chan != 0) {
    80001f3a:	709c                	ld	a5,32(s1)
    80001f3c:	c789                	beqz	a5,80001f46 <sleep+0x20>
    p->state = SLEEPING;
    80001f3e:	4789                	li	a5,2
    80001f40:	cc9c                	sw	a5,24(s1)
    sched();
    80001f42:	ec3ff0ef          	jal	80001e04 <sched>
  }
  release(&p->lock);
    80001f46:	8526                	mv	a0,s1
    80001f48:	d35fe0ef          	jal	80000c7c <release>
}
    80001f4c:	60e2                	ld	ra,24(sp)
    80001f4e:	6442                	ld	s0,16(sp)
    80001f50:	64a2                	ld	s1,8(sp)
    80001f52:	6105                	addi	sp,sp,32
    80001f54:	8082                	ret

0000000080001f56 <wakeup>:

// Wake up all processes sleeping on channel chan.
void
wakeup(void *chan)
{
    80001f56:	7139                	addi	sp,sp,-64
    80001f58:	fc06                	sd	ra,56(sp)
    80001f5a:	f822                	sd	s0,48(sp)
    80001f5c:	f426                	sd	s1,40(sp)
    80001f5e:	f04a                	sd	s2,32(sp)
    80001f60:	ec4e                	sd	s3,24(sp)
    80001f62:	e852                	sd	s4,16(sp)
    80001f64:	e456                	sd	s5,8(sp)
    80001f66:	0080                	addi	s0,sp,64
    80001f68:	892a                	mv	s2,a0
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++) {
    80001f6a:	0000f497          	auipc	s1,0xf
    80001f6e:	ee648493          	addi	s1,s1,-282 # 80010e50 <proc>
      // signal that the wakeup happened by clearing p->chan.
      p->chan = 0;

      // If this waiting process has gotten so far as to actually
      // go to sleep, also set it back to RUNNING.
      if (p->state == SLEEPING) {
    80001f72:	4a09                	li	s4,2
        p->state = RUNNABLE;
    80001f74:	4a8d                	li	s5,3
  for (p = proc; p < &proc[NPROC]; p++) {
    80001f76:	00015997          	auipc	s3,0x15
    80001f7a:	8da98993          	addi	s3,s3,-1830 # 80016850 <tickslock>
    80001f7e:	a801                	j	80001f8e <wakeup+0x38>
      }
    }
    release(&p->lock);
    80001f80:	8526                	mv	a0,s1
    80001f82:	cfbfe0ef          	jal	80000c7c <release>
  for (p = proc; p < &proc[NPROC]; p++) {
    80001f86:	16848493          	addi	s1,s1,360
    80001f8a:	03348063          	beq	s1,s3,80001faa <wakeup+0x54>
    acquire(&p->lock);
    80001f8e:	8526                	mv	a0,s1
    80001f90:	c69fe0ef          	jal	80000bf8 <acquire>
    if (p->chan == chan) {
    80001f94:	709c                	ld	a5,32(s1)
    80001f96:	ff2795e3          	bne	a5,s2,80001f80 <wakeup+0x2a>
      p->chan = 0;
    80001f9a:	0204b023          	sd	zero,32(s1)
      if (p->state == SLEEPING) {
    80001f9e:	4c9c                	lw	a5,24(s1)
    80001fa0:	ff4790e3          	bne	a5,s4,80001f80 <wakeup+0x2a>
        p->state = RUNNABLE;
    80001fa4:	0154ac23          	sw	s5,24(s1)
    80001fa8:	bfe1                	j	80001f80 <wakeup+0x2a>
  }
}
    80001faa:	70e2                	ld	ra,56(sp)
    80001fac:	7442                	ld	s0,48(sp)
    80001fae:	74a2                	ld	s1,40(sp)
    80001fb0:	7902                	ld	s2,32(sp)
    80001fb2:	69e2                	ld	s3,24(sp)
    80001fb4:	6a42                	ld	s4,16(sp)
    80001fb6:	6aa2                	ld	s5,8(sp)
    80001fb8:	6121                	addi	sp,sp,64
    80001fba:	8082                	ret

0000000080001fbc <reparent>:
{
    80001fbc:	7179                	addi	sp,sp,-48
    80001fbe:	f406                	sd	ra,40(sp)
    80001fc0:	f022                	sd	s0,32(sp)
    80001fc2:	ec26                	sd	s1,24(sp)
    80001fc4:	e84a                	sd	s2,16(sp)
    80001fc6:	e44e                	sd	s3,8(sp)
    80001fc8:	e052                	sd	s4,0(sp)
    80001fca:	1800                	addi	s0,sp,48
    80001fcc:	892a                	mv	s2,a0
  for (pp = proc; pp < &proc[NPROC]; pp++) {
    80001fce:	0000f497          	auipc	s1,0xf
    80001fd2:	e8248493          	addi	s1,s1,-382 # 80010e50 <proc>
      pp->parent = initproc;
    80001fd6:	00007a17          	auipc	s4,0x7
    80001fda:	922a0a13          	addi	s4,s4,-1758 # 800088f8 <initproc>
  for (pp = proc; pp < &proc[NPROC]; pp++) {
    80001fde:	00015997          	auipc	s3,0x15
    80001fe2:	87298993          	addi	s3,s3,-1934 # 80016850 <tickslock>
    80001fe6:	a029                	j	80001ff0 <reparent+0x34>
    80001fe8:	16848493          	addi	s1,s1,360
    80001fec:	01348b63          	beq	s1,s3,80002002 <reparent+0x46>
    if (pp->parent == p) {
    80001ff0:	7c9c                	ld	a5,56(s1)
    80001ff2:	ff279be3          	bne	a5,s2,80001fe8 <reparent+0x2c>
      pp->parent = initproc;
    80001ff6:	000a3503          	ld	a0,0(s4)
    80001ffa:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    80001ffc:	f5bff0ef          	jal	80001f56 <wakeup>
    80002000:	b7e5                	j	80001fe8 <reparent+0x2c>
}
    80002002:	70a2                	ld	ra,40(sp)
    80002004:	7402                	ld	s0,32(sp)
    80002006:	64e2                	ld	s1,24(sp)
    80002008:	6942                	ld	s2,16(sp)
    8000200a:	69a2                	ld	s3,8(sp)
    8000200c:	6a02                	ld	s4,0(sp)
    8000200e:	6145                	addi	sp,sp,48
    80002010:	8082                	ret

0000000080002012 <kexit>:
{
    80002012:	7179                	addi	sp,sp,-48
    80002014:	f406                	sd	ra,40(sp)
    80002016:	f022                	sd	s0,32(sp)
    80002018:	ec26                	sd	s1,24(sp)
    8000201a:	e84a                	sd	s2,16(sp)
    8000201c:	e44e                	sd	s3,8(sp)
    8000201e:	e052                	sd	s4,0(sp)
    80002020:	1800                	addi	s0,sp,48
    80002022:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80002024:	8bfff0ef          	jal	800018e2 <myproc>
    80002028:	89aa                	mv	s3,a0
  if (p == initproc)
    8000202a:	00007797          	auipc	a5,0x7
    8000202e:	8ce7b783          	ld	a5,-1842(a5) # 800088f8 <initproc>
    80002032:	0d050493          	addi	s1,a0,208
    80002036:	15050913          	addi	s2,a0,336
    8000203a:	00a79b63          	bne	a5,a0,80002050 <kexit+0x3e>
    panic("init exiting");
    8000203e:	00006517          	auipc	a0,0x6
    80002042:	1ba50513          	addi	a0,a0,442 # 800081f8 <etext+0x1f8>
    80002046:	803fe0ef          	jal	80000848 <panic>
  for (int fd = 0; fd < NOFILE; fd++) {
    8000204a:	04a1                	addi	s1,s1,8
    8000204c:	01248963          	beq	s1,s2,8000205e <kexit+0x4c>
    if (p->ofile[fd]) {
    80002050:	6088                	ld	a0,0(s1)
    80002052:	dd65                	beqz	a0,8000204a <kexit+0x38>
      fileclose(f);
    80002054:	3c4020ef          	jal	80004418 <fileclose>
      p->ofile[fd] = 0;
    80002058:	0004b023          	sd	zero,0(s1)
    8000205c:	b7fd                	j	8000204a <kexit+0x38>
  begin_op();
    8000205e:	701010ef          	jal	80003f5e <begin_op>
  iput(p->cwd);
    80002062:	1509b503          	ld	a0,336(s3)
    80002066:	45a010ef          	jal	800034c0 <iput>
  end_op();
    8000206a:	783010ef          	jal	80003fec <end_op>
  p->cwd = 0;
    8000206e:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80002072:	0000f517          	auipc	a0,0xf
    80002076:	9c650513          	addi	a0,a0,-1594 # 80010a38 <wait_lock>
    8000207a:	b7ffe0ef          	jal	80000bf8 <acquire>
  reparent(p);
    8000207e:	854e                	mv	a0,s3
    80002080:	f3dff0ef          	jal	80001fbc <reparent>
  wakeup(p->parent);
    80002084:	0389b503          	ld	a0,56(s3)
    80002088:	ecfff0ef          	jal	80001f56 <wakeup>
  acquire(&p->lock);
    8000208c:	854e                	mv	a0,s3
    8000208e:	b6bfe0ef          	jal	80000bf8 <acquire>
  p->xstate = status;
    80002092:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80002096:	4795                	li	a5,5
    80002098:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    8000209c:	0000f517          	auipc	a0,0xf
    800020a0:	99c50513          	addi	a0,a0,-1636 # 80010a38 <wait_lock>
    800020a4:	bd9fe0ef          	jal	80000c7c <release>
  sched();
    800020a8:	d5dff0ef          	jal	80001e04 <sched>
  panic("zombie exit");
    800020ac:	00006517          	auipc	a0,0x6
    800020b0:	15c50513          	addi	a0,a0,348 # 80008208 <etext+0x208>
    800020b4:	f94fe0ef          	jal	80000848 <panic>

00000000800020b8 <kkill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kkill(int pid)
{
    800020b8:	7179                	addi	sp,sp,-48
    800020ba:	f406                	sd	ra,40(sp)
    800020bc:	f022                	sd	s0,32(sp)
    800020be:	ec26                	sd	s1,24(sp)
    800020c0:	e84a                	sd	s2,16(sp)
    800020c2:	e44e                	sd	s3,8(sp)
    800020c4:	1800                	addi	s0,sp,48
    800020c6:	892a                	mv	s2,a0
  struct proc *p;

  if (pid == 0)
    return -1;

  for (p = proc; p < &proc[NPROC]; p++) {
    800020c8:	0000f497          	auipc	s1,0xf
    800020cc:	d8848493          	addi	s1,s1,-632 # 80010e50 <proc>
    800020d0:	00014997          	auipc	s3,0x14
    800020d4:	78098993          	addi	s3,s3,1920 # 80016850 <tickslock>
  if (pid == 0)
    800020d8:	cd11                	beqz	a0,800020f4 <kkill+0x3c>
    acquire(&p->lock);
    800020da:	8526                	mv	a0,s1
    800020dc:	b1dfe0ef          	jal	80000bf8 <acquire>
    if (p->pid == pid) {
    800020e0:	589c                	lw	a5,48(s1)
    800020e2:	01278b63          	beq	a5,s2,800020f8 <kkill+0x40>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800020e6:	8526                	mv	a0,s1
    800020e8:	b95fe0ef          	jal	80000c7c <release>
  for (p = proc; p < &proc[NPROC]; p++) {
    800020ec:	16848493          	addi	s1,s1,360
    800020f0:	ff3495e3          	bne	s1,s3,800020da <kkill+0x22>
    return -1;
    800020f4:	557d                	li	a0,-1
    800020f6:	a819                	j	8000210c <kkill+0x54>
      p->killed = 1;
    800020f8:	4785                	li	a5,1
    800020fa:	d49c                	sw	a5,40(s1)
      if (p->state == SLEEPING) {
    800020fc:	4c98                	lw	a4,24(s1)
    800020fe:	4789                	li	a5,2
    80002100:	00f70d63          	beq	a4,a5,8000211a <kkill+0x62>
      release(&p->lock);
    80002104:	8526                	mv	a0,s1
    80002106:	b77fe0ef          	jal	80000c7c <release>
      return 0;
    8000210a:	4501                	li	a0,0
  }
  return -1;
}
    8000210c:	70a2                	ld	ra,40(sp)
    8000210e:	7402                	ld	s0,32(sp)
    80002110:	64e2                	ld	s1,24(sp)
    80002112:	6942                	ld	s2,16(sp)
    80002114:	69a2                	ld	s3,8(sp)
    80002116:	6145                	addi	sp,sp,48
    80002118:	8082                	ret
        p->state = RUNNABLE;
    8000211a:	478d                	li	a5,3
    8000211c:	cc9c                	sw	a5,24(s1)
    8000211e:	b7dd                	j	80002104 <kkill+0x4c>

0000000080002120 <setkilled>:

void
setkilled(struct proc *p)
{
    80002120:	1101                	addi	sp,sp,-32
    80002122:	ec06                	sd	ra,24(sp)
    80002124:	e822                	sd	s0,16(sp)
    80002126:	e426                	sd	s1,8(sp)
    80002128:	1000                	addi	s0,sp,32
    8000212a:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000212c:	acdfe0ef          	jal	80000bf8 <acquire>
  p->killed = 1;
    80002130:	4785                	li	a5,1
    80002132:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    80002134:	8526                	mv	a0,s1
    80002136:	b47fe0ef          	jal	80000c7c <release>
}
    8000213a:	60e2                	ld	ra,24(sp)
    8000213c:	6442                	ld	s0,16(sp)
    8000213e:	64a2                	ld	s1,8(sp)
    80002140:	6105                	addi	sp,sp,32
    80002142:	8082                	ret

0000000080002144 <killed>:

int
killed(struct proc *p)
{
    80002144:	1101                	addi	sp,sp,-32
    80002146:	ec06                	sd	ra,24(sp)
    80002148:	e822                	sd	s0,16(sp)
    8000214a:	e426                	sd	s1,8(sp)
    8000214c:	e04a                	sd	s2,0(sp)
    8000214e:	1000                	addi	s0,sp,32
    80002150:	84aa                	mv	s1,a0
  int k;

  acquire(&p->lock);
    80002152:	aa7fe0ef          	jal	80000bf8 <acquire>
  k = p->killed;
    80002156:	549c                	lw	a5,40(s1)
    80002158:	893e                	mv	s2,a5
  release(&p->lock);
    8000215a:	8526                	mv	a0,s1
    8000215c:	b21fe0ef          	jal	80000c7c <release>
  return k;
}
    80002160:	854a                	mv	a0,s2
    80002162:	60e2                	ld	ra,24(sp)
    80002164:	6442                	ld	s0,16(sp)
    80002166:	64a2                	ld	s1,8(sp)
    80002168:	6902                	ld	s2,0(sp)
    8000216a:	6105                	addi	sp,sp,32
    8000216c:	8082                	ret

000000008000216e <kwait>:
{
    8000216e:	715d                	addi	sp,sp,-80
    80002170:	e486                	sd	ra,72(sp)
    80002172:	e0a2                	sd	s0,64(sp)
    80002174:	fc26                	sd	s1,56(sp)
    80002176:	f84a                	sd	s2,48(sp)
    80002178:	f44e                	sd	s3,40(sp)
    8000217a:	f052                	sd	s4,32(sp)
    8000217c:	ec56                	sd	s5,24(sp)
    8000217e:	e85a                	sd	s6,16(sp)
    80002180:	e45e                	sd	s7,8(sp)
    80002182:	0880                	addi	s0,sp,80
    80002184:	8baa                	mv	s7,a0
  struct proc *p = myproc();
    80002186:	f5cff0ef          	jal	800018e2 <myproc>
    8000218a:	892a                	mv	s2,a0
  acquire(&wait_lock);
    8000218c:	0000f517          	auipc	a0,0xf
    80002190:	8ac50513          	addi	a0,a0,-1876 # 80010a38 <wait_lock>
    80002194:	a65fe0ef          	jal	80000bf8 <acquire>
        if (pp->state == ZOMBIE) {
    80002198:	4a15                	li	s4,5
        havekids = 1;
    8000219a:	4a85                	li	s5,1
    for (pp = proc; pp < &proc[NPROC]; pp++) {
    8000219c:	00014997          	auipc	s3,0x14
    800021a0:	6b498993          	addi	s3,s3,1716 # 80016850 <tickslock>
    release(&wait_lock);
    800021a4:	0000fb17          	auipc	s6,0xf
    800021a8:	894b0b13          	addi	s6,s6,-1900 # 80010a38 <wait_lock>
    800021ac:	a07d                	j	8000225a <kwait+0xec>
          pid = pp->pid;
    800021ae:	0304a983          	lw	s3,48(s1)
          if (addr != 0 &&
    800021b2:	000b8e63          	beqz	s7,800021ce <kwait+0x60>
              copyout(p->pagetable, p->sz, addr, (char *)&pp->xstate,
    800021b6:	4711                	li	a4,4
    800021b8:	02c48693          	addi	a3,s1,44
    800021bc:	865e                	mv	a2,s7
    800021be:	04893583          	ld	a1,72(s2)
    800021c2:	05093503          	ld	a0,80(s2)
    800021c6:	b66ff0ef          	jal	8000152c <copyout>
          if (addr != 0 &&
    800021ca:	02054c63          	bltz	a0,80002202 <kwait+0x94>
          pp->parent = 0;
    800021ce:	0204bc23          	sd	zero,56(s1)
          freeproc(pp);
    800021d2:	8526                	mv	a0,s1
    800021d4:	8edff0ef          	jal	80001ac0 <freeproc>
          release(&pp->lock);
    800021d8:	8526                	mv	a0,s1
    800021da:	aa3fe0ef          	jal	80000c7c <release>
          release(&wait_lock);
    800021de:	0000f517          	auipc	a0,0xf
    800021e2:	85a50513          	addi	a0,a0,-1958 # 80010a38 <wait_lock>
    800021e6:	a97fe0ef          	jal	80000c7c <release>
}
    800021ea:	854e                	mv	a0,s3
    800021ec:	60a6                	ld	ra,72(sp)
    800021ee:	6406                	ld	s0,64(sp)
    800021f0:	74e2                	ld	s1,56(sp)
    800021f2:	7942                	ld	s2,48(sp)
    800021f4:	79a2                	ld	s3,40(sp)
    800021f6:	7a02                	ld	s4,32(sp)
    800021f8:	6ae2                	ld	s5,24(sp)
    800021fa:	6b42                	ld	s6,16(sp)
    800021fc:	6ba2                	ld	s7,8(sp)
    800021fe:	6161                	addi	sp,sp,80
    80002200:	8082                	ret
            release(&pp->lock);
    80002202:	8526                	mv	a0,s1
    80002204:	a79fe0ef          	jal	80000c7c <release>
            release(&wait_lock);
    80002208:	0000f517          	auipc	a0,0xf
    8000220c:	83050513          	addi	a0,a0,-2000 # 80010a38 <wait_lock>
    80002210:	a6dfe0ef          	jal	80000c7c <release>
            return -1;
    80002214:	a8b9                	j	80002272 <kwait+0x104>
    for (pp = proc; pp < &proc[NPROC]; pp++) {
    80002216:	16848493          	addi	s1,s1,360
    8000221a:	03348063          	beq	s1,s3,8000223a <kwait+0xcc>
      if (pp->parent == p) {
    8000221e:	7c9c                	ld	a5,56(s1)
    80002220:	ff279be3          	bne	a5,s2,80002216 <kwait+0xa8>
        acquire(&pp->lock);
    80002224:	8526                	mv	a0,s1
    80002226:	9d3fe0ef          	jal	80000bf8 <acquire>
        if (pp->state == ZOMBIE) {
    8000222a:	4c9c                	lw	a5,24(s1)
    8000222c:	f94781e3          	beq	a5,s4,800021ae <kwait+0x40>
        release(&pp->lock);
    80002230:	8526                	mv	a0,s1
    80002232:	a4bfe0ef          	jal	80000c7c <release>
        havekids = 1;
    80002236:	8756                	mv	a4,s5
    80002238:	bff9                	j	80002216 <kwait+0xa8>
    if (!havekids || killed(p)) {
    8000223a:	c715                	beqz	a4,80002266 <kwait+0xf8>
    8000223c:	854a                	mv	a0,s2
    8000223e:	f07ff0ef          	jal	80002144 <killed>
    80002242:	e115                	bnez	a0,80002266 <kwait+0xf8>
    sleep_prepare(p); //DOC: wait-sleep
    80002244:	854a                	mv	a0,s2
    80002246:	ca5ff0ef          	jal	80001eea <sleep_prepare>
    release(&wait_lock);
    8000224a:	855a                	mv	a0,s6
    8000224c:	a31fe0ef          	jal	80000c7c <release>
    sleep();
    80002250:	cd7ff0ef          	jal	80001f26 <sleep>
    acquire(&wait_lock);
    80002254:	855a                	mv	a0,s6
    80002256:	9a3fe0ef          	jal	80000bf8 <acquire>
    havekids = 0;
    8000225a:	4701                	li	a4,0
    for (pp = proc; pp < &proc[NPROC]; pp++) {
    8000225c:	0000f497          	auipc	s1,0xf
    80002260:	bf448493          	addi	s1,s1,-1036 # 80010e50 <proc>
    80002264:	bf6d                	j	8000221e <kwait+0xb0>
      release(&wait_lock);
    80002266:	0000e517          	auipc	a0,0xe
    8000226a:	7d250513          	addi	a0,a0,2002 # 80010a38 <wait_lock>
    8000226e:	a0ffe0ef          	jal	80000c7c <release>
            return -1;
    80002272:	59fd                	li	s3,-1
    80002274:	bf9d                	j	800021ea <kwait+0x7c>

0000000080002276 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80002276:	7179                	addi	sp,sp,-48
    80002278:	f406                	sd	ra,40(sp)
    8000227a:	f022                	sd	s0,32(sp)
    8000227c:	ec26                	sd	s1,24(sp)
    8000227e:	e84a                	sd	s2,16(sp)
    80002280:	e44e                	sd	s3,8(sp)
    80002282:	e052                	sd	s4,0(sp)
    80002284:	1800                	addi	s0,sp,48
    80002286:	84aa                	mv	s1,a0
    80002288:	8a2e                	mv	s4,a1
    8000228a:	89b2                	mv	s3,a2
    8000228c:	8936                	mv	s2,a3
  struct proc *p = myproc();
    8000228e:	e54ff0ef          	jal	800018e2 <myproc>
  if (user_dst) {
    80002292:	c085                	beqz	s1,800022b2 <either_copyout+0x3c>
    return copyout(p->pagetable, p->sz, dst, src, len);
    80002294:	874a                	mv	a4,s2
    80002296:	86ce                	mv	a3,s3
    80002298:	8652                	mv	a2,s4
    8000229a:	652c                	ld	a1,72(a0)
    8000229c:	6928                	ld	a0,80(a0)
    8000229e:	a8eff0ef          	jal	8000152c <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800022a2:	70a2                	ld	ra,40(sp)
    800022a4:	7402                	ld	s0,32(sp)
    800022a6:	64e2                	ld	s1,24(sp)
    800022a8:	6942                	ld	s2,16(sp)
    800022aa:	69a2                	ld	s3,8(sp)
    800022ac:	6a02                	ld	s4,0(sp)
    800022ae:	6145                	addi	sp,sp,48
    800022b0:	8082                	ret
    memmove((char *)dst, src, len);
    800022b2:	0009061b          	sext.w	a2,s2
    800022b6:	85ce                	mv	a1,s3
    800022b8:	8552                	mv	a0,s4
    800022ba:	a57fe0ef          	jal	80000d10 <memmove>
    return 0;
    800022be:	8526                	mv	a0,s1
    800022c0:	b7cd                	j	800022a2 <either_copyout+0x2c>

00000000800022c2 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800022c2:	7179                	addi	sp,sp,-48
    800022c4:	f406                	sd	ra,40(sp)
    800022c6:	f022                	sd	s0,32(sp)
    800022c8:	ec26                	sd	s1,24(sp)
    800022ca:	e84a                	sd	s2,16(sp)
    800022cc:	e44e                	sd	s3,8(sp)
    800022ce:	e052                	sd	s4,0(sp)
    800022d0:	1800                	addi	s0,sp,48
    800022d2:	8a2a                	mv	s4,a0
    800022d4:	84ae                	mv	s1,a1
    800022d6:	89b2                	mv	s3,a2
    800022d8:	8936                	mv	s2,a3
  struct proc *p = myproc();
    800022da:	e08ff0ef          	jal	800018e2 <myproc>
  if (user_src) {
    800022de:	c085                	beqz	s1,800022fe <either_copyin+0x3c>
    return copyin(p->pagetable, p->sz, dst, src, len);
    800022e0:	874a                	mv	a4,s2
    800022e2:	86ce                	mv	a3,s3
    800022e4:	8652                	mv	a2,s4
    800022e6:	652c                	ld	a1,72(a0)
    800022e8:	6928                	ld	a0,80(a0)
    800022ea:	b02ff0ef          	jal	800015ec <copyin>
  } else {
    memmove(dst, (char *)src, len);
    return 0;
  }
}
    800022ee:	70a2                	ld	ra,40(sp)
    800022f0:	7402                	ld	s0,32(sp)
    800022f2:	64e2                	ld	s1,24(sp)
    800022f4:	6942                	ld	s2,16(sp)
    800022f6:	69a2                	ld	s3,8(sp)
    800022f8:	6a02                	ld	s4,0(sp)
    800022fa:	6145                	addi	sp,sp,48
    800022fc:	8082                	ret
    memmove(dst, (char *)src, len);
    800022fe:	0009061b          	sext.w	a2,s2
    80002302:	85ce                	mv	a1,s3
    80002304:	8552                	mv	a0,s4
    80002306:	a0bfe0ef          	jal	80000d10 <memmove>
    return 0;
    8000230a:	8526                	mv	a0,s1
    8000230c:	b7cd                	j	800022ee <either_copyin+0x2c>

000000008000230e <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    8000230e:	715d                	addi	sp,sp,-80
    80002310:	e486                	sd	ra,72(sp)
    80002312:	e0a2                	sd	s0,64(sp)
    80002314:	fc26                	sd	s1,56(sp)
    80002316:	f84a                	sd	s2,48(sp)
    80002318:	f44e                	sd	s3,40(sp)
    8000231a:	f052                	sd	s4,32(sp)
    8000231c:	ec56                	sd	s5,24(sp)
    8000231e:	e85a                	sd	s6,16(sp)
    80002320:	e45e                	sd	s7,8(sp)
    80002322:	0880                	addi	s0,sp,80
    // clang-format on
  };
  struct proc *p;
  char *state;

  printk("\n");
    80002324:	00006517          	auipc	a0,0x6
    80002328:	1f450513          	addi	a0,a0,500 # 80008518 <etext+0x518>
    8000232c:	9e4fe0ef          	jal	80000510 <printk>
  for (p = proc; p < &proc[NPROC]; p++) {
    80002330:	0000f497          	auipc	s1,0xf
    80002334:	c7848493          	addi	s1,s1,-904 # 80010fa8 <proc+0x158>
    80002338:	00014917          	auipc	s2,0x14
    8000233c:	67090913          	addi	s2,s2,1648 # 800169a8 <bcache+0x140>
    if (p->state == UNUSED)
      continue;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002340:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80002342:	00006a97          	auipc	s5,0x6
    80002346:	ed6a8a93          	addi	s5,s5,-298 # 80008218 <etext+0x218>
    printk("%d %s %s", p->pid, state, p->name);
    8000234a:	00006a17          	auipc	s4,0x6
    8000234e:	ed6a0a13          	addi	s4,s4,-298 # 80008220 <etext+0x220>
    printk("\n");
    80002352:	00006997          	auipc	s3,0x6
    80002356:	1c698993          	addi	s3,s3,454 # 80008518 <etext+0x518>
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000235a:	00006b97          	auipc	s7,0x6
    8000235e:	45eb8b93          	addi	s7,s7,1118 # 800087b8 <states.0>
    80002362:	a829                	j	8000237c <procdump+0x6e>
    printk("%d %s %s", p->pid, state, p->name);
    80002364:	ed86a583          	lw	a1,-296(a3)
    80002368:	8552                	mv	a0,s4
    8000236a:	9a6fe0ef          	jal	80000510 <printk>
    printk("\n");
    8000236e:	854e                	mv	a0,s3
    80002370:	9a0fe0ef          	jal	80000510 <printk>
  for (p = proc; p < &proc[NPROC]; p++) {
    80002374:	16848493          	addi	s1,s1,360
    80002378:	03248063          	beq	s1,s2,80002398 <procdump+0x8a>
    if (p->state == UNUSED)
    8000237c:	86a6                	mv	a3,s1
    8000237e:	ec04a783          	lw	a5,-320(s1)
    80002382:	dbed                	beqz	a5,80002374 <procdump+0x66>
      state = "???";
    80002384:	8656                	mv	a2,s5
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002386:	fcfb6fe3          	bltu	s6,a5,80002364 <procdump+0x56>
    8000238a:	02079713          	slli	a4,a5,0x20
    8000238e:	01d75793          	srli	a5,a4,0x1d
    80002392:	97de                	add	a5,a5,s7
    80002394:	6390                	ld	a2,0(a5)
      state = states[p->state];
    80002396:	b7f9                	j	80002364 <procdump+0x56>
  }
}
    80002398:	60a6                	ld	ra,72(sp)
    8000239a:	6406                	ld	s0,64(sp)
    8000239c:	74e2                	ld	s1,56(sp)
    8000239e:	7942                	ld	s2,48(sp)
    800023a0:	79a2                	ld	s3,40(sp)
    800023a2:	7a02                	ld	s4,32(sp)
    800023a4:	6ae2                	ld	s5,24(sp)
    800023a6:	6b42                	ld	s6,16(sp)
    800023a8:	6ba2                	ld	s7,8(sp)
    800023aa:	6161                	addi	sp,sp,80
    800023ac:	8082                	ret

00000000800023ae <swtch>:
# Save current registers in old. Load from new.	


.globl swtch
swtch:
        sd ra, 0(a0)
    800023ae:	00153023          	sd	ra,0(a0)
        sd sp, 8(a0)
    800023b2:	00253423          	sd	sp,8(a0)
        sd s0, 16(a0)
    800023b6:	e900                	sd	s0,16(a0)
        sd s1, 24(a0)
    800023b8:	ed04                	sd	s1,24(a0)
        sd s2, 32(a0)
    800023ba:	03253023          	sd	s2,32(a0)
        sd s3, 40(a0)
    800023be:	03353423          	sd	s3,40(a0)
        sd s4, 48(a0)
    800023c2:	03453823          	sd	s4,48(a0)
        sd s5, 56(a0)
    800023c6:	03553c23          	sd	s5,56(a0)
        sd s6, 64(a0)
    800023ca:	05653023          	sd	s6,64(a0)
        sd s7, 72(a0)
    800023ce:	05753423          	sd	s7,72(a0)
        sd s8, 80(a0)
    800023d2:	05853823          	sd	s8,80(a0)
        sd s9, 88(a0)
    800023d6:	05953c23          	sd	s9,88(a0)
        sd s10, 96(a0)
    800023da:	07a53023          	sd	s10,96(a0)
        sd s11, 104(a0)
    800023de:	07b53423          	sd	s11,104(a0)

        ld ra, 0(a1)
    800023e2:	0005b083          	ld	ra,0(a1)
        ld sp, 8(a1)
    800023e6:	0085b103          	ld	sp,8(a1)
        ld s0, 16(a1)
    800023ea:	6980                	ld	s0,16(a1)
        ld s1, 24(a1)
    800023ec:	6d84                	ld	s1,24(a1)
        ld s2, 32(a1)
    800023ee:	0205b903          	ld	s2,32(a1)
        ld s3, 40(a1)
    800023f2:	0285b983          	ld	s3,40(a1)
        ld s4, 48(a1)
    800023f6:	0305ba03          	ld	s4,48(a1)
        ld s5, 56(a1)
    800023fa:	0385ba83          	ld	s5,56(a1)
        ld s6, 64(a1)
    800023fe:	0405bb03          	ld	s6,64(a1)
        ld s7, 72(a1)
    80002402:	0485bb83          	ld	s7,72(a1)
        ld s8, 80(a1)
    80002406:	0505bc03          	ld	s8,80(a1)
        ld s9, 88(a1)
    8000240a:	0585bc83          	ld	s9,88(a1)
        ld s10, 96(a1)
    8000240e:	0605bd03          	ld	s10,96(a1)
        ld s11, 104(a1)
    80002412:	0685bd83          	ld	s11,104(a1)
        
        ret
    80002416:	8082                	ret

0000000080002418 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80002418:	1141                	addi	sp,sp,-16
    8000241a:	e406                	sd	ra,8(sp)
    8000241c:	e022                	sd	s0,0(sp)
    8000241e:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80002420:	00006597          	auipc	a1,0x6
    80002424:	e4058593          	addi	a1,a1,-448 # 80008260 <etext+0x260>
    80002428:	00014517          	auipc	a0,0x14
    8000242c:	42850513          	addi	a0,a0,1064 # 80016850 <tickslock>
    80002430:	f48fe0ef          	jal	80000b78 <initlock>
}
    80002434:	60a2                	ld	ra,8(sp)
    80002436:	6402                	ld	s0,0(sp)
    80002438:	0141                	addi	sp,sp,16
    8000243a:	8082                	ret

000000008000243c <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    8000243c:	1141                	addi	sp,sp,-16
    8000243e:	e406                	sd	ra,8(sp)
    80002440:	e022                	sd	s0,0(sp)
    80002442:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r"(x));
    80002444:	00004797          	auipc	a5,0x4
    80002448:	83c78793          	addi	a5,a5,-1988 # 80005c80 <kernelvec>
    8000244c:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80002450:	60a2                	ld	ra,8(sp)
    80002452:	6402                	ld	s0,0(sp)
    80002454:	0141                	addi	sp,sp,16
    80002456:	8082                	ret

0000000080002458 <prepare_return>:
//
// set up trapframe and control registers for a return to user space
//
void
prepare_return(void)
{
    80002458:	1141                	addi	sp,sp,-16
    8000245a:	e406                	sd	ra,8(sp)
    8000245c:	e022                	sd	s0,0(sp)
    8000245e:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80002460:	c82ff0ef          	jal	800018e2 <myproc>
  __asm__ __volatile__("csrc sstatus, %0" ::"rK"(x) : "memory");
    80002464:	10017073          	csrci	sstatus,2
  // kerneltrap() to usertrap(). because a trap from kernel
  // code to usertrap would be a disaster, turn off interrupts.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80002468:	04000737          	lui	a4,0x4000
    8000246c:	177d                	addi	a4,a4,-1 # 3ffffff <_entry-0x7c000001>
    8000246e:	0732                	slli	a4,a4,0xc
    80002470:	00005797          	auipc	a5,0x5
    80002474:	b9078793          	addi	a5,a5,-1136 # 80007000 <_trampoline>
    80002478:	00005697          	auipc	a3,0x5
    8000247c:	b8868693          	addi	a3,a3,-1144 # 80007000 <_trampoline>
    80002480:	8f95                	sub	a5,a5,a3
    80002482:	97ba                	add	a5,a5,a4
  asm volatile("csrw stvec, %0" : : "r"(x));
    80002484:	10579073          	csrw	stvec,a5
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80002488:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, satp" : "=r"(x));
    8000248a:	18002773          	csrr	a4,satp
    8000248e:	e398                	sd	a4,0(a5)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80002490:	6d38                	ld	a4,88(a0)
    80002492:	613c                	ld	a5,64(a0)
    80002494:	6685                	lui	a3,0x1
    80002496:	97b6                	add	a5,a5,a3
    80002498:	e71c                	sd	a5,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    8000249a:	6d3c                	ld	a5,88(a0)
    8000249c:	00000717          	auipc	a4,0x0
    800024a0:	0f470713          	addi	a4,a4,244 # 80002590 <usertrap>
    800024a4:	eb98                	sd	a4,16(a5)
  p->trapframe->kernel_hartid = r_tp(); // hartid for cpuid()
    800024a6:	6d3c                	ld	a5,88(a0)
  asm volatile("mv %0, tp" : "=r"(x));
    800024a8:	8712                	mv	a4,tp
    800024aa:	f398                	sd	a4,32(a5)
  asm volatile("csrr %0, sstatus" : "=r"(x));
    800024ac:	100027f3          	csrr	a5,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.

  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800024b0:	eff7f793          	andi	a5,a5,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800024b4:	0207e793          	ori	a5,a5,32
  asm volatile("csrw sstatus, %0" : : "r"(x));
    800024b8:	10079073          	csrw	sstatus,a5
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    800024bc:	6d3c                	ld	a5,88(a0)
  asm volatile("csrw sepc, %0" : : "r"(x));
    800024be:	6f9c                	ld	a5,24(a5)
    800024c0:	14179073          	csrw	sepc,a5
}
    800024c4:	60a2                	ld	ra,8(sp)
    800024c6:	6402                	ld	s0,0(sp)
    800024c8:	0141                	addi	sp,sp,16
    800024ca:	8082                	ret

00000000800024cc <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    800024cc:	1141                	addi	sp,sp,-16
    800024ce:	e406                	sd	ra,8(sp)
    800024d0:	e022                	sd	s0,0(sp)
    800024d2:	0800                	addi	s0,sp,16
  if (cpuid() == 0) {
    800024d4:	bdaff0ef          	jal	800018ae <cpuid>
    800024d8:	cd11                	beqz	a0,800024f4 <clockintr+0x28>
  asm volatile("csrr %0, time" : "=r"(x));
    800024da:	c01027f3          	rdtime	a5
  }

  // ask for the next timer interrupt. this also clears
  // the interrupt request. 1000000 is about a tenth
  // of a second.
  w_stimecmp(r_time() + 1000000);
    800024de:	000f4737          	lui	a4,0xf4
    800024e2:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    800024e6:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r"(x));
    800024e8:	14d79073          	csrw	stimecmp,a5
}
    800024ec:	60a2                	ld	ra,8(sp)
    800024ee:	6402                	ld	s0,0(sp)
    800024f0:	0141                	addi	sp,sp,16
    800024f2:	8082                	ret
    acquire(&tickslock);
    800024f4:	00014517          	auipc	a0,0x14
    800024f8:	35c50513          	addi	a0,a0,860 # 80016850 <tickslock>
    800024fc:	efcfe0ef          	jal	80000bf8 <acquire>
    ticks++;
    80002500:	00006717          	auipc	a4,0x6
    80002504:	40070713          	addi	a4,a4,1024 # 80008900 <ticks>
    80002508:	431c                	lw	a5,0(a4)
    8000250a:	2785                	addiw	a5,a5,1
    8000250c:	c31c                	sw	a5,0(a4)
    wakeup(&ticks);
    8000250e:	853a                	mv	a0,a4
    80002510:	a47ff0ef          	jal	80001f56 <wakeup>
    release(&tickslock);
    80002514:	00014517          	auipc	a0,0x14
    80002518:	33c50513          	addi	a0,a0,828 # 80016850 <tickslock>
    8000251c:	f60fe0ef          	jal	80000c7c <release>
    80002520:	bf6d                	j	800024da <clockintr+0xe>

0000000080002522 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80002522:	1101                	addi	sp,sp,-32
    80002524:	ec06                	sd	ra,24(sp)
    80002526:	e822                	sd	s0,16(sp)
    80002528:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r"(x));
    8000252a:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if (scause == 0x8000000000000009L) {
    8000252e:	57fd                	li	a5,-1
    80002530:	17fe                	slli	a5,a5,0x3f
    80002532:	07a5                	addi	a5,a5,9
    80002534:	00f70c63          	beq	a4,a5,8000254c <devintr+0x2a>
    // now allowed to interrupt again.
    if (irq)
      plic_complete(irq);

    return 1;
  } else if (scause == 0x8000000000000005L) {
    80002538:	57fd                	li	a5,-1
    8000253a:	17fe                	slli	a5,a5,0x3f
    8000253c:	0795                	addi	a5,a5,5
    // timer interrupt.
    clockintr();
    return 2;
  } else {
    return 0;
    8000253e:	4501                	li	a0,0
  } else if (scause == 0x8000000000000005L) {
    80002540:	04f70463          	beq	a4,a5,80002588 <devintr+0x66>
  }
}
    80002544:	60e2                	ld	ra,24(sp)
    80002546:	6442                	ld	s0,16(sp)
    80002548:	6105                	addi	sp,sp,32
    8000254a:	8082                	ret
    8000254c:	e426                	sd	s1,8(sp)
    int irq = plic_claim();
    8000254e:	7de030ef          	jal	80005d2c <plic_claim>
    80002552:	84aa                	mv	s1,a0
    if (irq == UART0_IRQ) {
    80002554:	47a9                	li	a5,10
    80002556:	02f50363          	beq	a0,a5,8000257c <devintr+0x5a>
    } else if (irq == VIRTIO0_IRQ) {
    8000255a:	4785                	li	a5,1
    8000255c:	02f50363          	beq	a0,a5,80002582 <devintr+0x60>
    } else if (irq) {
    80002560:	c919                	beqz	a0,80002576 <devintr+0x54>
      printk("unexpected interrupt irq=%d\n", irq);
    80002562:	85aa                	mv	a1,a0
    80002564:	00006517          	auipc	a0,0x6
    80002568:	d0450513          	addi	a0,a0,-764 # 80008268 <etext+0x268>
    8000256c:	fa5fd0ef          	jal	80000510 <printk>
      plic_complete(irq);
    80002570:	8526                	mv	a0,s1
    80002572:	7da030ef          	jal	80005d4c <plic_complete>
    return 1;
    80002576:	4505                	li	a0,1
    80002578:	64a2                	ld	s1,8(sp)
    8000257a:	b7e9                	j	80002544 <devintr+0x22>
      uartintr();
    8000257c:	c62fe0ef          	jal	800009de <uartintr>
    if (irq)
    80002580:	bfc5                	j	80002570 <devintr+0x4e>
      virtio_disk_intr();
    80002582:	451030ef          	jal	800061d2 <virtio_disk_intr>
    if (irq)
    80002586:	b7ed                	j	80002570 <devintr+0x4e>
    clockintr();
    80002588:	f45ff0ef          	jal	800024cc <clockintr>
    return 2;
    8000258c:	4509                	li	a0,2
    8000258e:	bf5d                	j	80002544 <devintr+0x22>

0000000080002590 <usertrap>:
{
    80002590:	1101                	addi	sp,sp,-32
    80002592:	ec06                	sd	ra,24(sp)
    80002594:	e822                	sd	s0,16(sp)
    80002596:	e426                	sd	s1,8(sp)
    80002598:	e04a                	sd	s2,0(sp)
    8000259a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r"(x));
    8000259c:	100027f3          	csrr	a5,sstatus
  if ((r_sstatus() & SSTATUS_SPP) != 0)
    800025a0:	1007f793          	andi	a5,a5,256
    800025a4:	eba5                	bnez	a5,80002614 <usertrap+0x84>
  asm volatile("csrw stvec, %0" : : "r"(x));
    800025a6:	00003797          	auipc	a5,0x3
    800025aa:	6da78793          	addi	a5,a5,1754 # 80005c80 <kernelvec>
    800025ae:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    800025b2:	b30ff0ef          	jal	800018e2 <myproc>
    800025b6:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    800025b8:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r"(x));
    800025ba:	14102773          	csrr	a4,sepc
    800025be:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r"(x));
    800025c0:	14202773          	csrr	a4,scause
  if (r_scause() == 8) {
    800025c4:	47a1                	li	a5,8
    800025c6:	04f70d63          	beq	a4,a5,80002620 <usertrap+0x90>
  } else if ((which_dev = devintr()) != 0) {
    800025ca:	f59ff0ef          	jal	80002522 <devintr>
    800025ce:	892a                	mv	s2,a0
    800025d0:	e54d                	bnez	a0,8000267a <usertrap+0xea>
    800025d2:	14202773          	csrr	a4,scause
  } else if ((r_scause() == 15 || r_scause() == 13) &&
    800025d6:	47bd                	li	a5,15
    800025d8:	08f70463          	beq	a4,a5,80002660 <usertrap+0xd0>
    800025dc:	14202773          	csrr	a4,scause
    800025e0:	47b5                	li	a5,13
    800025e2:	06f70f63          	beq	a4,a5,80002660 <usertrap+0xd0>
    800025e6:	142025f3          	csrr	a1,scause
    printk("usertrap(): unexpected scause 0x%lx pid=%d\n", r_scause(), p->pid);
    800025ea:	5890                	lw	a2,48(s1)
    800025ec:	00006517          	auipc	a0,0x6
    800025f0:	cbc50513          	addi	a0,a0,-836 # 800082a8 <etext+0x2a8>
    800025f4:	f1dfd0ef          	jal	80000510 <printk>
  asm volatile("csrr %0, sepc" : "=r"(x));
    800025f8:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r"(x));
    800025fc:	14302673          	csrr	a2,stval
    printk("            sepc=0x%lx stval=0x%lx\n", r_sepc(), r_stval());
    80002600:	00006517          	auipc	a0,0x6
    80002604:	cd850513          	addi	a0,a0,-808 # 800082d8 <etext+0x2d8>
    80002608:	f09fd0ef          	jal	80000510 <printk>
    setkilled(p);
    8000260c:	8526                	mv	a0,s1
    8000260e:	b13ff0ef          	jal	80002120 <setkilled>
    80002612:	a015                	j	80002636 <usertrap+0xa6>
    panic("usertrap: not from user mode");
    80002614:	00006517          	auipc	a0,0x6
    80002618:	c7450513          	addi	a0,a0,-908 # 80008288 <etext+0x288>
    8000261c:	a2cfe0ef          	jal	80000848 <panic>
    if (killed(p))
    80002620:	b25ff0ef          	jal	80002144 <killed>
    80002624:	e915                	bnez	a0,80002658 <usertrap+0xc8>
    p->trapframe->epc += 4;
    80002626:	6cb8                	ld	a4,88(s1)
    80002628:	6f1c                	ld	a5,24(a4)
    8000262a:	0791                	addi	a5,a5,4
    8000262c:	ef1c                	sd	a5,24(a4)
  __asm__ __volatile__("csrs sstatus, %0" ::"rK"(x) : "memory");
    8000262e:	10016073          	csrsi	sstatus,2
    syscall();
    80002632:	240000ef          	jal	80002872 <syscall>
  if (killed(p))
    80002636:	8526                	mv	a0,s1
    80002638:	b0dff0ef          	jal	80002144 <killed>
    8000263c:	e521                	bnez	a0,80002684 <usertrap+0xf4>
  prepare_return();
    8000263e:	e1bff0ef          	jal	80002458 <prepare_return>
  uint64 satp = MAKE_SATP(p->pagetable);
    80002642:	68a8                	ld	a0,80(s1)
    80002644:	8131                	srli	a0,a0,0xc
    80002646:	57fd                	li	a5,-1
    80002648:	17fe                	slli	a5,a5,0x3f
    8000264a:	8d5d                	or	a0,a0,a5
}
    8000264c:	60e2                	ld	ra,24(sp)
    8000264e:	6442                	ld	s0,16(sp)
    80002650:	64a2                	ld	s1,8(sp)
    80002652:	6902                	ld	s2,0(sp)
    80002654:	6105                	addi	sp,sp,32
    80002656:	8082                	ret
      kexit(-1);
    80002658:	557d                	li	a0,-1
    8000265a:	9b9ff0ef          	jal	80002012 <kexit>
    8000265e:	b7e1                	j	80002626 <usertrap+0x96>
  asm volatile("csrr %0, stval" : "=r"(x));
    80002660:	14302673          	csrr	a2,stval
  asm volatile("csrr %0, scause" : "=r"(x));
    80002664:	142026f3          	csrr	a3,scause
             vmfault(p->pagetable, p->sz, r_stval(),
    80002668:	16cd                	addi	a3,a3,-13 # ff3 <_entry-0x7ffff00d>
    8000266a:	0016b693          	seqz	a3,a3
    8000266e:	64ac                	ld	a1,72(s1)
    80002670:	68a8                	ld	a0,80(s1)
    80002672:	e43fe0ef          	jal	800014b4 <vmfault>
  } else if ((r_scause() == 15 || r_scause() == 13) &&
    80002676:	f161                	bnez	a0,80002636 <usertrap+0xa6>
    80002678:	b7bd                	j	800025e6 <usertrap+0x56>
  if (killed(p))
    8000267a:	8526                	mv	a0,s1
    8000267c:	ac9ff0ef          	jal	80002144 <killed>
    80002680:	c511                	beqz	a0,8000268c <usertrap+0xfc>
    80002682:	a011                	j	80002686 <usertrap+0xf6>
    80002684:	4901                	li	s2,0
    kexit(-1);
    80002686:	557d                	li	a0,-1
    80002688:	98bff0ef          	jal	80002012 <kexit>
  if (which_dev == 2)
    8000268c:	4789                	li	a5,2
    8000268e:	faf918e3          	bne	s2,a5,8000263e <usertrap+0xae>
    yield();
    80002692:	82dff0ef          	jal	80001ebe <yield>
    80002696:	b765                	j	8000263e <usertrap+0xae>

0000000080002698 <kerneltrap>:
{
    80002698:	7179                	addi	sp,sp,-48
    8000269a:	f406                	sd	ra,40(sp)
    8000269c:	f022                	sd	s0,32(sp)
    8000269e:	ec26                	sd	s1,24(sp)
    800026a0:	e84a                	sd	s2,16(sp)
    800026a2:	e44e                	sd	s3,8(sp)
    800026a4:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r"(x));
    800026a6:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r"(x));
    800026aa:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r"(x));
    800026ae:	142027f3          	csrr	a5,scause
    800026b2:	89be                	mv	s3,a5
  if ((sstatus & SSTATUS_SPP) == 0)
    800026b4:	1004f793          	andi	a5,s1,256
    800026b8:	c795                	beqz	a5,800026e4 <kerneltrap+0x4c>
  asm volatile("csrr %0, sstatus" : "=r"(x));
    800026ba:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800026be:	8b89                	andi	a5,a5,2
  if (intr_get() != 0)
    800026c0:	eb85                	bnez	a5,800026f0 <kerneltrap+0x58>
  if ((which_dev = devintr()) == 0) {
    800026c2:	e61ff0ef          	jal	80002522 <devintr>
    800026c6:	c91d                	beqz	a0,800026fc <kerneltrap+0x64>
  if (which_dev == 2 && myproc() != 0)
    800026c8:	4789                	li	a5,2
    800026ca:	04f50a63          	beq	a0,a5,8000271e <kerneltrap+0x86>
  asm volatile("csrw sepc, %0" : : "r"(x));
    800026ce:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r"(x));
    800026d2:	10049073          	csrw	sstatus,s1
}
    800026d6:	70a2                	ld	ra,40(sp)
    800026d8:	7402                	ld	s0,32(sp)
    800026da:	64e2                	ld	s1,24(sp)
    800026dc:	6942                	ld	s2,16(sp)
    800026de:	69a2                	ld	s3,8(sp)
    800026e0:	6145                	addi	sp,sp,48
    800026e2:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    800026e4:	00006517          	auipc	a0,0x6
    800026e8:	c1c50513          	addi	a0,a0,-996 # 80008300 <etext+0x300>
    800026ec:	95cfe0ef          	jal	80000848 <panic>
    panic("kerneltrap: interrupts enabled");
    800026f0:	00006517          	auipc	a0,0x6
    800026f4:	c3850513          	addi	a0,a0,-968 # 80008328 <etext+0x328>
    800026f8:	950fe0ef          	jal	80000848 <panic>
  asm volatile("csrr %0, sepc" : "=r"(x));
    800026fc:	14102673          	csrr	a2,sepc
  asm volatile("csrr %0, stval" : "=r"(x));
    80002700:	143026f3          	csrr	a3,stval
    printk("scause=0x%lx sepc=0x%lx stval=0x%lx\n", scause, r_sepc(),
    80002704:	85ce                	mv	a1,s3
    80002706:	00006517          	auipc	a0,0x6
    8000270a:	c4250513          	addi	a0,a0,-958 # 80008348 <etext+0x348>
    8000270e:	e03fd0ef          	jal	80000510 <printk>
    panic("kerneltrap");
    80002712:	00006517          	auipc	a0,0x6
    80002716:	c5e50513          	addi	a0,a0,-930 # 80008370 <etext+0x370>
    8000271a:	92efe0ef          	jal	80000848 <panic>
  if (which_dev == 2 && myproc() != 0)
    8000271e:	9c4ff0ef          	jal	800018e2 <myproc>
    80002722:	d555                	beqz	a0,800026ce <kerneltrap+0x36>
    yield();
    80002724:	f9aff0ef          	jal	80001ebe <yield>
    80002728:	b75d                	j	800026ce <kerneltrap+0x36>

000000008000272a <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    8000272a:	1101                	addi	sp,sp,-32
    8000272c:	ec06                	sd	ra,24(sp)
    8000272e:	e822                	sd	s0,16(sp)
    80002730:	e426                	sd	s1,8(sp)
    80002732:	1000                	addi	s0,sp,32
    80002734:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80002736:	9acff0ef          	jal	800018e2 <myproc>
  switch (n) {
    8000273a:	4795                	li	a5,5
    8000273c:	0497e163          	bltu	a5,s1,8000277e <argraw+0x54>
    80002740:	048a                	slli	s1,s1,0x2
    80002742:	00006717          	auipc	a4,0x6
    80002746:	0a670713          	addi	a4,a4,166 # 800087e8 <states.0+0x30>
    8000274a:	94ba                	add	s1,s1,a4
    8000274c:	409c                	lw	a5,0(s1)
    8000274e:	97ba                	add	a5,a5,a4
    80002750:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80002752:	6d3c                	ld	a5,88(a0)
    80002754:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80002756:	60e2                	ld	ra,24(sp)
    80002758:	6442                	ld	s0,16(sp)
    8000275a:	64a2                	ld	s1,8(sp)
    8000275c:	6105                	addi	sp,sp,32
    8000275e:	8082                	ret
    return p->trapframe->a1;
    80002760:	6d3c                	ld	a5,88(a0)
    80002762:	7fa8                	ld	a0,120(a5)
    80002764:	bfcd                	j	80002756 <argraw+0x2c>
    return p->trapframe->a2;
    80002766:	6d3c                	ld	a5,88(a0)
    80002768:	63c8                	ld	a0,128(a5)
    8000276a:	b7f5                	j	80002756 <argraw+0x2c>
    return p->trapframe->a3;
    8000276c:	6d3c                	ld	a5,88(a0)
    8000276e:	67c8                	ld	a0,136(a5)
    80002770:	b7dd                	j	80002756 <argraw+0x2c>
    return p->trapframe->a4;
    80002772:	6d3c                	ld	a5,88(a0)
    80002774:	6bc8                	ld	a0,144(a5)
    80002776:	b7c5                	j	80002756 <argraw+0x2c>
    return p->trapframe->a5;
    80002778:	6d3c                	ld	a5,88(a0)
    8000277a:	6fc8                	ld	a0,152(a5)
    8000277c:	bfe9                	j	80002756 <argraw+0x2c>
  panic("argraw");
    8000277e:	00006517          	auipc	a0,0x6
    80002782:	c0250513          	addi	a0,a0,-1022 # 80008380 <etext+0x380>
    80002786:	8c2fe0ef          	jal	80000848 <panic>

000000008000278a <fetchaddr>:
{
    8000278a:	1101                	addi	sp,sp,-32
    8000278c:	ec06                	sd	ra,24(sp)
    8000278e:	e822                	sd	s0,16(sp)
    80002790:	e426                	sd	s1,8(sp)
    80002792:	e04a                	sd	s2,0(sp)
    80002794:	1000                	addi	s0,sp,32
    80002796:	84aa                	mv	s1,a0
    80002798:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000279a:	948ff0ef          	jal	800018e2 <myproc>
  if (addr >= p->sz ||
    8000279e:	652c                	ld	a1,72(a0)
    800027a0:	02b4f663          	bgeu	s1,a1,800027cc <fetchaddr+0x42>
      addr + sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    800027a4:	00848793          	addi	a5,s1,8
  if (addr >= p->sz ||
    800027a8:	02f5e263          	bltu	a1,a5,800027cc <fetchaddr+0x42>
  if (copyin(p->pagetable, p->sz, (char *)ip, addr, sizeof(*ip)) != 0)
    800027ac:	4721                	li	a4,8
    800027ae:	86a6                	mv	a3,s1
    800027b0:	864a                	mv	a2,s2
    800027b2:	6928                	ld	a0,80(a0)
    800027b4:	e39fe0ef          	jal	800015ec <copyin>
    800027b8:	00a03533          	snez	a0,a0
    800027bc:	40a0053b          	negw	a0,a0
}
    800027c0:	60e2                	ld	ra,24(sp)
    800027c2:	6442                	ld	s0,16(sp)
    800027c4:	64a2                	ld	s1,8(sp)
    800027c6:	6902                	ld	s2,0(sp)
    800027c8:	6105                	addi	sp,sp,32
    800027ca:	8082                	ret
    return -1;
    800027cc:	557d                	li	a0,-1
    800027ce:	bfcd                	j	800027c0 <fetchaddr+0x36>

00000000800027d0 <fetchstr>:
{
    800027d0:	7179                	addi	sp,sp,-48
    800027d2:	f406                	sd	ra,40(sp)
    800027d4:	f022                	sd	s0,32(sp)
    800027d6:	ec26                	sd	s1,24(sp)
    800027d8:	e84a                	sd	s2,16(sp)
    800027da:	e44e                	sd	s3,8(sp)
    800027dc:	1800                	addi	s0,sp,48
    800027de:	89aa                	mv	s3,a0
    800027e0:	84ae                	mv	s1,a1
    800027e2:	8932                	mv	s2,a2
  struct proc *p = myproc();
    800027e4:	8feff0ef          	jal	800018e2 <myproc>
  if (copyinstr(p->pagetable, p->sz, buf, addr, max) < 0)
    800027e8:	874a                	mv	a4,s2
    800027ea:	86ce                	mv	a3,s3
    800027ec:	8626                	mv	a2,s1
    800027ee:	652c                	ld	a1,72(a0)
    800027f0:	6928                	ld	a0,80(a0)
    800027f2:	e99fe0ef          	jal	8000168a <copyinstr>
    800027f6:	00054c63          	bltz	a0,8000280e <fetchstr+0x3e>
  return strlen(buf);
    800027fa:	8526                	mv	a0,s1
    800027fc:	e38fe0ef          	jal	80000e34 <strlen>
}
    80002800:	70a2                	ld	ra,40(sp)
    80002802:	7402                	ld	s0,32(sp)
    80002804:	64e2                	ld	s1,24(sp)
    80002806:	6942                	ld	s2,16(sp)
    80002808:	69a2                	ld	s3,8(sp)
    8000280a:	6145                	addi	sp,sp,48
    8000280c:	8082                	ret
    return -1;
    8000280e:	557d                	li	a0,-1
    80002810:	bfc5                	j	80002800 <fetchstr+0x30>

0000000080002812 <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    80002812:	1101                	addi	sp,sp,-32
    80002814:	ec06                	sd	ra,24(sp)
    80002816:	e822                	sd	s0,16(sp)
    80002818:	e426                	sd	s1,8(sp)
    8000281a:	1000                	addi	s0,sp,32
    8000281c:	84ae                	mv	s1,a1
  *ip = argraw(n);
    8000281e:	f0dff0ef          	jal	8000272a <argraw>
    80002822:	c088                	sw	a0,0(s1)
}
    80002824:	60e2                	ld	ra,24(sp)
    80002826:	6442                	ld	s0,16(sp)
    80002828:	64a2                	ld	s1,8(sp)
    8000282a:	6105                	addi	sp,sp,32
    8000282c:	8082                	ret

000000008000282e <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    8000282e:	1101                	addi	sp,sp,-32
    80002830:	ec06                	sd	ra,24(sp)
    80002832:	e822                	sd	s0,16(sp)
    80002834:	e426                	sd	s1,8(sp)
    80002836:	1000                	addi	s0,sp,32
    80002838:	84ae                	mv	s1,a1
  *ip = argraw(n);
    8000283a:	ef1ff0ef          	jal	8000272a <argraw>
    8000283e:	e088                	sd	a0,0(s1)
}
    80002840:	60e2                	ld	ra,24(sp)
    80002842:	6442                	ld	s0,16(sp)
    80002844:	64a2                	ld	s1,8(sp)
    80002846:	6105                	addi	sp,sp,32
    80002848:	8082                	ret

000000008000284a <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (not including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    8000284a:	1101                	addi	sp,sp,-32
    8000284c:	ec06                	sd	ra,24(sp)
    8000284e:	e822                	sd	s0,16(sp)
    80002850:	e426                	sd	s1,8(sp)
    80002852:	e04a                	sd	s2,0(sp)
    80002854:	1000                	addi	s0,sp,32
    80002856:	892e                	mv	s2,a1
    80002858:	84b2                	mv	s1,a2
  *ip = argraw(n);
    8000285a:	ed1ff0ef          	jal	8000272a <argraw>
  uint64 addr;
  argaddr(n, &addr);
  return fetchstr(addr, buf, max);
    8000285e:	8626                	mv	a2,s1
    80002860:	85ca                	mv	a1,s2
    80002862:	f6fff0ef          	jal	800027d0 <fetchstr>
}
    80002866:	60e2                	ld	ra,24(sp)
    80002868:	6442                	ld	s0,16(sp)
    8000286a:	64a2                	ld	s1,8(sp)
    8000286c:	6902                	ld	s2,0(sp)
    8000286e:	6105                	addi	sp,sp,32
    80002870:	8082                	ret

0000000080002872 <syscall>:
  // clang-format on
};

void
syscall(void)
{
    80002872:	1101                	addi	sp,sp,-32
    80002874:	ec06                	sd	ra,24(sp)
    80002876:	e822                	sd	s0,16(sp)
    80002878:	e426                	sd	s1,8(sp)
    8000287a:	e04a                	sd	s2,0(sp)
    8000287c:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    8000287e:	864ff0ef          	jal	800018e2 <myproc>
    80002882:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80002884:	05853903          	ld	s2,88(a0)
    80002888:	0a893783          	ld	a5,168(s2)
    8000288c:	0007869b          	sext.w	a3,a5
  if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002890:	37fd                	addiw	a5,a5,-1
    80002892:	4761                	li	a4,24
    80002894:	00f76f63          	bltu	a4,a5,800028b2 <syscall+0x40>
    80002898:	00369713          	slli	a4,a3,0x3
    8000289c:	00006797          	auipc	a5,0x6
    800028a0:	f6478793          	addi	a5,a5,-156 # 80008800 <syscalls>
    800028a4:	97ba                	add	a5,a5,a4
    800028a6:	639c                	ld	a5,0(a5)
    800028a8:	c789                	beqz	a5,800028b2 <syscall+0x40>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    800028aa:	9782                	jalr	a5
    800028ac:	06a93823          	sd	a0,112(s2)
    800028b0:	a829                	j	800028ca <syscall+0x58>
  } else {
    printk("%d %s: unknown sys call %d\n", p->pid, p->name, num);
    800028b2:	15848613          	addi	a2,s1,344
    800028b6:	588c                	lw	a1,48(s1)
    800028b8:	00006517          	auipc	a0,0x6
    800028bc:	ad050513          	addi	a0,a0,-1328 # 80008388 <etext+0x388>
    800028c0:	c51fd0ef          	jal	80000510 <printk>
    p->trapframe->a0 = -1;
    800028c4:	6cbc                	ld	a5,88(s1)
    800028c6:	577d                	li	a4,-1
    800028c8:	fbb8                	sd	a4,112(a5)
  }
}
    800028ca:	60e2                	ld	ra,24(sp)
    800028cc:	6442                	ld	s0,16(sp)
    800028ce:	64a2                	ld	s1,8(sp)
    800028d0:	6902                	ld	s2,0(sp)
    800028d2:	6105                	addi	sp,sp,32
    800028d4:	8082                	ret

00000000800028d6 <sys_exit>:
#include "proc.h"
#include "vm.h"

uint64
sys_exit(void)
{
    800028d6:	1101                	addi	sp,sp,-32
    800028d8:	ec06                	sd	ra,24(sp)
    800028da:	e822                	sd	s0,16(sp)
    800028dc:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    800028de:	fec40593          	addi	a1,s0,-20
    800028e2:	4501                	li	a0,0
    800028e4:	f2fff0ef          	jal	80002812 <argint>
  kexit(n);
    800028e8:	fec42503          	lw	a0,-20(s0)
    800028ec:	f26ff0ef          	jal	80002012 <kexit>
  return 0; // not reached
}
    800028f0:	4501                	li	a0,0
    800028f2:	60e2                	ld	ra,24(sp)
    800028f4:	6442                	ld	s0,16(sp)
    800028f6:	6105                	addi	sp,sp,32
    800028f8:	8082                	ret

00000000800028fa <sys_getpid>:

uint64
sys_getpid(void)
{
    800028fa:	1141                	addi	sp,sp,-16
    800028fc:	e406                	sd	ra,8(sp)
    800028fe:	e022                	sd	s0,0(sp)
    80002900:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002902:	fe1fe0ef          	jal	800018e2 <myproc>
}
    80002906:	5908                	lw	a0,48(a0)
    80002908:	60a2                	ld	ra,8(sp)
    8000290a:	6402                	ld	s0,0(sp)
    8000290c:	0141                	addi	sp,sp,16
    8000290e:	8082                	ret

0000000080002910 <sys_fork>:

uint64
sys_fork(void)
{
    80002910:	1141                	addi	sp,sp,-16
    80002912:	e406                	sd	ra,8(sp)
    80002914:	e022                	sd	s0,0(sp)
    80002916:	0800                	addi	s0,sp,16
  return kfork();
    80002918:	b34ff0ef          	jal	80001c4c <kfork>
}
    8000291c:	60a2                	ld	ra,8(sp)
    8000291e:	6402                	ld	s0,0(sp)
    80002920:	0141                	addi	sp,sp,16
    80002922:	8082                	ret

0000000080002924 <sys_wait>:

uint64
sys_wait(void)
{
    80002924:	1101                	addi	sp,sp,-32
    80002926:	ec06                	sd	ra,24(sp)
    80002928:	e822                	sd	s0,16(sp)
    8000292a:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    8000292c:	fe840593          	addi	a1,s0,-24
    80002930:	4501                	li	a0,0
    80002932:	efdff0ef          	jal	8000282e <argaddr>
  return kwait(p);
    80002936:	fe843503          	ld	a0,-24(s0)
    8000293a:	835ff0ef          	jal	8000216e <kwait>
}
    8000293e:	60e2                	ld	ra,24(sp)
    80002940:	6442                	ld	s0,16(sp)
    80002942:	6105                	addi	sp,sp,32
    80002944:	8082                	ret

0000000080002946 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002946:	7179                	addi	sp,sp,-48
    80002948:	f406                	sd	ra,40(sp)
    8000294a:	f022                	sd	s0,32(sp)
    8000294c:	ec26                	sd	s1,24(sp)
    8000294e:	1800                	addi	s0,sp,48
  uint64 addr;
  int t;
  int n;

  argint(0, &n);
    80002950:	fd840593          	addi	a1,s0,-40
    80002954:	4501                	li	a0,0
    80002956:	ebdff0ef          	jal	80002812 <argint>
  argint(1, &t);
    8000295a:	fdc40593          	addi	a1,s0,-36
    8000295e:	4505                	li	a0,1
    80002960:	eb3ff0ef          	jal	80002812 <argint>
  addr = myproc()->sz;
    80002964:	f7ffe0ef          	jal	800018e2 <myproc>
    80002968:	6524                	ld	s1,72(a0)

  if (t == SBRK_EAGER || n < 0) {
    8000296a:	fdc42703          	lw	a4,-36(s0)
    8000296e:	4785                	li	a5,1
    80002970:	02f70a63          	beq	a4,a5,800029a4 <sys_sbrk+0x5e>
    80002974:	fd842783          	lw	a5,-40(s0)
    80002978:	0207c663          	bltz	a5,800029a4 <sys_sbrk+0x5e>
    }
  } else {
    // Lazily allocate memory for this process: increase its memory
    // size but don't allocate memory. If the processes uses the
    // memory, vmfault() will allocate it.
    if (addr + n < addr)
    8000297c:	00978733          	add	a4,a5,s1
      return -1;
    if (addr + n > TRAPFRAME)
    80002980:	020007b7          	lui	a5,0x2000
    80002984:	17fd                	addi	a5,a5,-1 # 1ffffff <_entry-0x7e000001>
    80002986:	07b6                	slli	a5,a5,0xd
    80002988:	00e7b7b3          	sltu	a5,a5,a4
    if (addr + n < addr)
    8000298c:	00973733          	sltu	a4,a4,s1
    if (addr + n > TRAPFRAME)
    80002990:	8fd9                	or	a5,a5,a4
    80002992:	e79d                	bnez	a5,800029c0 <sys_sbrk+0x7a>
      return -1;
    myproc()->sz += n;
    80002994:	f4ffe0ef          	jal	800018e2 <myproc>
    80002998:	fd842703          	lw	a4,-40(s0)
    8000299c:	653c                	ld	a5,72(a0)
    8000299e:	97ba                	add	a5,a5,a4
    800029a0:	e53c                	sd	a5,72(a0)
    800029a2:	a039                	j	800029b0 <sys_sbrk+0x6a>
    if (growproc(n) < 0) {
    800029a4:	fd842503          	lw	a0,-40(s0)
    800029a8:	a46ff0ef          	jal	80001bee <growproc>
    800029ac:	00054863          	bltz	a0,800029bc <sys_sbrk+0x76>
  }
  return addr;
}
    800029b0:	8526                	mv	a0,s1
    800029b2:	70a2                	ld	ra,40(sp)
    800029b4:	7402                	ld	s0,32(sp)
    800029b6:	64e2                	ld	s1,24(sp)
    800029b8:	6145                	addi	sp,sp,48
    800029ba:	8082                	ret
      return -1;
    800029bc:	54fd                	li	s1,-1
    800029be:	bfcd                	j	800029b0 <sys_sbrk+0x6a>
      return -1;
    800029c0:	54fd                	li	s1,-1
    800029c2:	b7fd                	j	800029b0 <sys_sbrk+0x6a>

00000000800029c4 <sys_pause>:

uint64
sys_pause(void)
{
    800029c4:	7139                	addi	sp,sp,-64
    800029c6:	fc06                	sd	ra,56(sp)
    800029c8:	f822                	sd	s0,48(sp)
    800029ca:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    800029cc:	fcc40593          	addi	a1,s0,-52
    800029d0:	4501                	li	a0,0
    800029d2:	e41ff0ef          	jal	80002812 <argint>
  if (n < 0)
    800029d6:	fcc42783          	lw	a5,-52(s0)
    800029da:	0807c063          	bltz	a5,80002a5a <sys_pause+0x96>
    n = 0;
  acquire(&tickslock);
    800029de:	00014517          	auipc	a0,0x14
    800029e2:	e7250513          	addi	a0,a0,-398 # 80016850 <tickslock>
    800029e6:	a12fe0ef          	jal	80000bf8 <acquire>
  ticks0 = ticks;
  while (ticks - ticks0 < n) {
    800029ea:	fcc42783          	lw	a5,-52(s0)
    800029ee:	cbb9                	beqz	a5,80002a44 <sys_pause+0x80>
    800029f0:	f426                	sd	s1,40(sp)
    800029f2:	f04a                	sd	s2,32(sp)
    800029f4:	ec4e                	sd	s3,24(sp)
  ticks0 = ticks;
    800029f6:	00006997          	auipc	s3,0x6
    800029fa:	f0a9a983          	lw	s3,-246(s3) # 80008900 <ticks>
    if (killed(myproc())) {
      release(&tickslock);
      return -1;
    }
    sleep_prepare(&ticks);
    800029fe:	00006917          	auipc	s2,0x6
    80002a02:	f0290913          	addi	s2,s2,-254 # 80008900 <ticks>
    release(&tickslock);
    80002a06:	00014497          	auipc	s1,0x14
    80002a0a:	e4a48493          	addi	s1,s1,-438 # 80016850 <tickslock>
    if (killed(myproc())) {
    80002a0e:	ed5fe0ef          	jal	800018e2 <myproc>
    80002a12:	f32ff0ef          	jal	80002144 <killed>
    80002a16:	e529                	bnez	a0,80002a60 <sys_pause+0x9c>
    sleep_prepare(&ticks);
    80002a18:	854a                	mv	a0,s2
    80002a1a:	cd0ff0ef          	jal	80001eea <sleep_prepare>
    release(&tickslock);
    80002a1e:	8526                	mv	a0,s1
    80002a20:	a5cfe0ef          	jal	80000c7c <release>
    sleep();
    80002a24:	d02ff0ef          	jal	80001f26 <sleep>
    acquire(&tickslock);
    80002a28:	8526                	mv	a0,s1
    80002a2a:	9cefe0ef          	jal	80000bf8 <acquire>
  while (ticks - ticks0 < n) {
    80002a2e:	00092783          	lw	a5,0(s2)
    80002a32:	413787bb          	subw	a5,a5,s3
    80002a36:	fcc42703          	lw	a4,-52(s0)
    80002a3a:	fce7eae3          	bltu	a5,a4,80002a0e <sys_pause+0x4a>
    80002a3e:	74a2                	ld	s1,40(sp)
    80002a40:	7902                	ld	s2,32(sp)
    80002a42:	69e2                	ld	s3,24(sp)
  }
  release(&tickslock);
    80002a44:	00014517          	auipc	a0,0x14
    80002a48:	e0c50513          	addi	a0,a0,-500 # 80016850 <tickslock>
    80002a4c:	a30fe0ef          	jal	80000c7c <release>
  return 0;
    80002a50:	4501                	li	a0,0
}
    80002a52:	70e2                	ld	ra,56(sp)
    80002a54:	7442                	ld	s0,48(sp)
    80002a56:	6121                	addi	sp,sp,64
    80002a58:	8082                	ret
    n = 0;
    80002a5a:	fc042623          	sw	zero,-52(s0)
    80002a5e:	b741                	j	800029de <sys_pause+0x1a>
      release(&tickslock);
    80002a60:	00014517          	auipc	a0,0x14
    80002a64:	df050513          	addi	a0,a0,-528 # 80016850 <tickslock>
    80002a68:	a14fe0ef          	jal	80000c7c <release>
      return -1;
    80002a6c:	557d                	li	a0,-1
    80002a6e:	74a2                	ld	s1,40(sp)
    80002a70:	7902                	ld	s2,32(sp)
    80002a72:	69e2                	ld	s3,24(sp)
    80002a74:	bff9                	j	80002a52 <sys_pause+0x8e>

0000000080002a76 <sys_kill>:

uint64
sys_kill(void)
{
    80002a76:	1101                	addi	sp,sp,-32
    80002a78:	ec06                	sd	ra,24(sp)
    80002a7a:	e822                	sd	s0,16(sp)
    80002a7c:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80002a7e:	fec40593          	addi	a1,s0,-20
    80002a82:	4501                	li	a0,0
    80002a84:	d8fff0ef          	jal	80002812 <argint>
  return kkill(pid);
    80002a88:	fec42503          	lw	a0,-20(s0)
    80002a8c:	e2cff0ef          	jal	800020b8 <kkill>
}
    80002a90:	60e2                	ld	ra,24(sp)
    80002a92:	6442                	ld	s0,16(sp)
    80002a94:	6105                	addi	sp,sp,32
    80002a96:	8082                	ret

0000000080002a98 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80002a98:	1101                	addi	sp,sp,-32
    80002a9a:	ec06                	sd	ra,24(sp)
    80002a9c:	e822                	sd	s0,16(sp)
    80002a9e:	e426                	sd	s1,8(sp)
    80002aa0:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80002aa2:	00014517          	auipc	a0,0x14
    80002aa6:	dae50513          	addi	a0,a0,-594 # 80016850 <tickslock>
    80002aaa:	94efe0ef          	jal	80000bf8 <acquire>
  xticks = ticks;
    80002aae:	00006797          	auipc	a5,0x6
    80002ab2:	e527a783          	lw	a5,-430(a5) # 80008900 <ticks>
    80002ab6:	84be                	mv	s1,a5
  release(&tickslock);
    80002ab8:	00014517          	auipc	a0,0x14
    80002abc:	d9850513          	addi	a0,a0,-616 # 80016850 <tickslock>
    80002ac0:	9bcfe0ef          	jal	80000c7c <release>
  return xticks;
}
    80002ac4:	02049513          	slli	a0,s1,0x20
    80002ac8:	9101                	srli	a0,a0,0x20
    80002aca:	60e2                	ld	ra,24(sp)
    80002acc:	6442                	ld	s0,16(sp)
    80002ace:	64a2                	ld	s1,8(sp)
    80002ad0:	6105                	addi	sp,sp,32
    80002ad2:	8082                	ret

0000000080002ad4 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80002ad4:	7179                	addi	sp,sp,-48
    80002ad6:	f406                	sd	ra,40(sp)
    80002ad8:	f022                	sd	s0,32(sp)
    80002ada:	ec26                	sd	s1,24(sp)
    80002adc:	e84a                	sd	s2,16(sp)
    80002ade:	e44e                	sd	s3,8(sp)
    80002ae0:	e052                	sd	s4,0(sp)
    80002ae2:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80002ae4:	00006597          	auipc	a1,0x6
    80002ae8:	8c458593          	addi	a1,a1,-1852 # 800083a8 <etext+0x3a8>
    80002aec:	00014517          	auipc	a0,0x14
    80002af0:	d7c50513          	addi	a0,a0,-644 # 80016868 <bcache>
    80002af4:	884fe0ef          	jal	80000b78 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002af8:	00055797          	auipc	a5,0x55
    80002afc:	d7078793          	addi	a5,a5,-656 # 80057868 <bcache+0x41000>
    80002b00:	00055717          	auipc	a4,0x55
    80002b04:	00070713          	mv	a4,a4
    80002b08:	2ee7b023          	sd	a4,736(a5)
  bcache.head.next = &bcache.head;
    80002b0c:	2ee7b423          	sd	a4,744(a5)
  for (b = bcache.buf; b < bcache.buf + NBUF; b++) {
    80002b10:	00014497          	auipc	s1,0x14
    80002b14:	d7048493          	addi	s1,s1,-656 # 80016880 <bcache+0x18>
    b->next = bcache.head.next;
    80002b18:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002b1a:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002b1c:	00006a17          	auipc	s4,0x6
    80002b20:	894a0a13          	addi	s4,s4,-1900 # 800083b0 <etext+0x3b0>
    b->next = bcache.head.next;
    80002b24:	2e893783          	ld	a5,744(s2)
    80002b28:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002b2a:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002b2e:	85d2                	mv	a1,s4
    80002b30:	01048513          	addi	a0,s1,16
    80002b34:	710010ef          	jal	80004244 <initsleeplock>
    bcache.head.next->prev = b;
    80002b38:	2e893783          	ld	a5,744(s2)
    80002b3c:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002b3e:	2e993423          	sd	s1,744(s2)
  for (b = bcache.buf; b < bcache.buf + NBUF; b++) {
    80002b42:	45848493          	addi	s1,s1,1112
    80002b46:	fd349fe3          	bne	s1,s3,80002b24 <binit+0x50>
  }
}
    80002b4a:	70a2                	ld	ra,40(sp)
    80002b4c:	7402                	ld	s0,32(sp)
    80002b4e:	64e2                	ld	s1,24(sp)
    80002b50:	6942                	ld	s2,16(sp)
    80002b52:	69a2                	ld	s3,8(sp)
    80002b54:	6a02                	ld	s4,0(sp)
    80002b56:	6145                	addi	sp,sp,48
    80002b58:	8082                	ret

0000000080002b5a <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf *
bread(uint dev, uint blockno)
{
    80002b5a:	7179                	addi	sp,sp,-48
    80002b5c:	f406                	sd	ra,40(sp)
    80002b5e:	f022                	sd	s0,32(sp)
    80002b60:	ec26                	sd	s1,24(sp)
    80002b62:	e84a                	sd	s2,16(sp)
    80002b64:	e44e                	sd	s3,8(sp)
    80002b66:	1800                	addi	s0,sp,48
    80002b68:	892a                	mv	s2,a0
    80002b6a:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80002b6c:	00014517          	auipc	a0,0x14
    80002b70:	cfc50513          	addi	a0,a0,-772 # 80016868 <bcache>
    80002b74:	884fe0ef          	jal	80000bf8 <acquire>
  for (b = bcache.head.next; b != &bcache.head; b = b->next) {
    80002b78:	00055497          	auipc	s1,0x55
    80002b7c:	fd84b483          	ld	s1,-40(s1) # 80057b50 <bcache+0x412e8>
    80002b80:	00055797          	auipc	a5,0x55
    80002b84:	f8078793          	addi	a5,a5,-128 # 80057b00 <bcache+0x41298>
    80002b88:	02f48b63          	beq	s1,a5,80002bbe <bread+0x64>
    80002b8c:	873e                	mv	a4,a5
    80002b8e:	a021                	j	80002b96 <bread+0x3c>
    80002b90:	68a4                	ld	s1,80(s1)
    80002b92:	02e48663          	beq	s1,a4,80002bbe <bread+0x64>
    if (b->dev == dev && b->blockno == blockno) {
    80002b96:	449c                	lw	a5,8(s1)
    80002b98:	ff279ce3          	bne	a5,s2,80002b90 <bread+0x36>
    80002b9c:	44dc                	lw	a5,12(s1)
    80002b9e:	ff3799e3          	bne	a5,s3,80002b90 <bread+0x36>
      b->refcnt++;
    80002ba2:	40bc                	lw	a5,64(s1)
    80002ba4:	2785                	addiw	a5,a5,1
    80002ba6:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002ba8:	00014517          	auipc	a0,0x14
    80002bac:	cc050513          	addi	a0,a0,-832 # 80016868 <bcache>
    80002bb0:	8ccfe0ef          	jal	80000c7c <release>
      acquiresleep(&b->lock);
    80002bb4:	01048513          	addi	a0,s1,16
    80002bb8:	6c2010ef          	jal	8000427a <acquiresleep>
      return b;
    80002bbc:	a889                	j	80002c0e <bread+0xb4>
  for (b = bcache.head.prev; b != &bcache.head; b = b->prev) {
    80002bbe:	00055497          	auipc	s1,0x55
    80002bc2:	f8a4b483          	ld	s1,-118(s1) # 80057b48 <bcache+0x412e0>
    80002bc6:	00055797          	auipc	a5,0x55
    80002bca:	f3a78793          	addi	a5,a5,-198 # 80057b00 <bcache+0x41298>
    80002bce:	00f48863          	beq	s1,a5,80002bde <bread+0x84>
    80002bd2:	873e                	mv	a4,a5
    if (b->refcnt == 0) {
    80002bd4:	40bc                	lw	a5,64(s1)
    80002bd6:	cb91                	beqz	a5,80002bea <bread+0x90>
  for (b = bcache.head.prev; b != &bcache.head; b = b->prev) {
    80002bd8:	64a4                	ld	s1,72(s1)
    80002bda:	fee49de3          	bne	s1,a4,80002bd4 <bread+0x7a>
  panic("bget: no buffers");
    80002bde:	00005517          	auipc	a0,0x5
    80002be2:	7da50513          	addi	a0,a0,2010 # 800083b8 <etext+0x3b8>
    80002be6:	c63fd0ef          	jal	80000848 <panic>
      b->dev = dev;
    80002bea:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80002bee:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80002bf2:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002bf6:	4785                	li	a5,1
    80002bf8:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002bfa:	00014517          	auipc	a0,0x14
    80002bfe:	c6e50513          	addi	a0,a0,-914 # 80016868 <bcache>
    80002c02:	87afe0ef          	jal	80000c7c <release>
      acquiresleep(&b->lock);
    80002c06:	01048513          	addi	a0,s1,16
    80002c0a:	670010ef          	jal	8000427a <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if (!b->valid) {
    80002c0e:	409c                	lw	a5,0(s1)
    80002c10:	cb89                	beqz	a5,80002c22 <bread+0xc8>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002c12:	8526                	mv	a0,s1
    80002c14:	70a2                	ld	ra,40(sp)
    80002c16:	7402                	ld	s0,32(sp)
    80002c18:	64e2                	ld	s1,24(sp)
    80002c1a:	6942                	ld	s2,16(sp)
    80002c1c:	69a2                	ld	s3,8(sp)
    80002c1e:	6145                	addi	sp,sp,48
    80002c20:	8082                	ret
    virtio_disk_rw(b, 0);
    80002c22:	4581                	li	a1,0
    80002c24:	8526                	mv	a0,s1
    80002c26:	37c030ef          	jal	80005fa2 <virtio_disk_rw>
    b->valid = 1;
    80002c2a:	4785                	li	a5,1
    80002c2c:	c09c                	sw	a5,0(s1)
  return b;
    80002c2e:	b7d5                	j	80002c12 <bread+0xb8>

0000000080002c30 <bwrite>:

// Write b's contents to disk.  Must be locked.
// Only the log calls bwrite.
void
bwrite(struct buf *b)
{
    80002c30:	1101                	addi	sp,sp,-32
    80002c32:	ec06                	sd	ra,24(sp)
    80002c34:	e822                	sd	s0,16(sp)
    80002c36:	e426                	sd	s1,8(sp)
    80002c38:	1000                	addi	s0,sp,32
    80002c3a:	84aa                	mv	s1,a0
  if (!holdingsleep(&b->lock))
    80002c3c:	0541                	addi	a0,a0,16
    80002c3e:	6c8010ef          	jal	80004306 <holdingsleep>
    80002c42:	c911                	beqz	a0,80002c56 <bwrite+0x26>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002c44:	4585                	li	a1,1
    80002c46:	8526                	mv	a0,s1
    80002c48:	35a030ef          	jal	80005fa2 <virtio_disk_rw>
}
    80002c4c:	60e2                	ld	ra,24(sp)
    80002c4e:	6442                	ld	s0,16(sp)
    80002c50:	64a2                	ld	s1,8(sp)
    80002c52:	6105                	addi	sp,sp,32
    80002c54:	8082                	ret
    panic("bwrite");
    80002c56:	00005517          	auipc	a0,0x5
    80002c5a:	77a50513          	addi	a0,a0,1914 # 800083d0 <etext+0x3d0>
    80002c5e:	bebfd0ef          	jal	80000848 <panic>

0000000080002c62 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80002c62:	1101                	addi	sp,sp,-32
    80002c64:	ec06                	sd	ra,24(sp)
    80002c66:	e822                	sd	s0,16(sp)
    80002c68:	e426                	sd	s1,8(sp)
    80002c6a:	e04a                	sd	s2,0(sp)
    80002c6c:	1000                	addi	s0,sp,32
    80002c6e:	84aa                	mv	s1,a0
  if (!holdingsleep(&b->lock))
    80002c70:	01050913          	addi	s2,a0,16
    80002c74:	854a                	mv	a0,s2
    80002c76:	690010ef          	jal	80004306 <holdingsleep>
    80002c7a:	c125                	beqz	a0,80002cda <brelse+0x78>
    panic("brelse");

  releasesleep(&b->lock);
    80002c7c:	854a                	mv	a0,s2
    80002c7e:	650010ef          	jal	800042ce <releasesleep>

  acquire(&bcache.lock);
    80002c82:	00014517          	auipc	a0,0x14
    80002c86:	be650513          	addi	a0,a0,-1050 # 80016868 <bcache>
    80002c8a:	f6ffd0ef          	jal	80000bf8 <acquire>
  b->refcnt--;
    80002c8e:	40bc                	lw	a5,64(s1)
    80002c90:	37fd                	addiw	a5,a5,-1
    80002c92:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80002c94:	e79d                	bnez	a5,80002cc2 <brelse+0x60>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80002c96:	68b8                	ld	a4,80(s1)
    80002c98:	64bc                	ld	a5,72(s1)
    80002c9a:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    80002c9c:	68b8                	ld	a4,80(s1)
    80002c9e:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80002ca0:	00055797          	auipc	a5,0x55
    80002ca4:	bc878793          	addi	a5,a5,-1080 # 80057868 <bcache+0x41000>
    80002ca8:	2e87b703          	ld	a4,744(a5)
    80002cac:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80002cae:	00055717          	auipc	a4,0x55
    80002cb2:	e5270713          	addi	a4,a4,-430 # 80057b00 <bcache+0x41298>
    80002cb6:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80002cb8:	2e87b703          	ld	a4,744(a5)
    80002cbc:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002cbe:	2e97b423          	sd	s1,744(a5)
  }

  release(&bcache.lock);
    80002cc2:	00014517          	auipc	a0,0x14
    80002cc6:	ba650513          	addi	a0,a0,-1114 # 80016868 <bcache>
    80002cca:	fb3fd0ef          	jal	80000c7c <release>
}
    80002cce:	60e2                	ld	ra,24(sp)
    80002cd0:	6442                	ld	s0,16(sp)
    80002cd2:	64a2                	ld	s1,8(sp)
    80002cd4:	6902                	ld	s2,0(sp)
    80002cd6:	6105                	addi	sp,sp,32
    80002cd8:	8082                	ret
    panic("brelse");
    80002cda:	00005517          	auipc	a0,0x5
    80002cde:	6fe50513          	addi	a0,a0,1790 # 800083d8 <etext+0x3d8>
    80002ce2:	b67fd0ef          	jal	80000848 <panic>

0000000080002ce6 <bpin>:

void
bpin(struct buf *b)
{
    80002ce6:	1101                	addi	sp,sp,-32
    80002ce8:	ec06                	sd	ra,24(sp)
    80002cea:	e822                	sd	s0,16(sp)
    80002cec:	e426                	sd	s1,8(sp)
    80002cee:	1000                	addi	s0,sp,32
    80002cf0:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002cf2:	00014517          	auipc	a0,0x14
    80002cf6:	b7650513          	addi	a0,a0,-1162 # 80016868 <bcache>
    80002cfa:	efffd0ef          	jal	80000bf8 <acquire>
  b->refcnt++;
    80002cfe:	40bc                	lw	a5,64(s1)
    80002d00:	2785                	addiw	a5,a5,1
    80002d02:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002d04:	00014517          	auipc	a0,0x14
    80002d08:	b6450513          	addi	a0,a0,-1180 # 80016868 <bcache>
    80002d0c:	f71fd0ef          	jal	80000c7c <release>
}
    80002d10:	60e2                	ld	ra,24(sp)
    80002d12:	6442                	ld	s0,16(sp)
    80002d14:	64a2                	ld	s1,8(sp)
    80002d16:	6105                	addi	sp,sp,32
    80002d18:	8082                	ret

0000000080002d1a <bunpin>:

void
bunpin(struct buf *b)
{
    80002d1a:	1101                	addi	sp,sp,-32
    80002d1c:	ec06                	sd	ra,24(sp)
    80002d1e:	e822                	sd	s0,16(sp)
    80002d20:	e426                	sd	s1,8(sp)
    80002d22:	1000                	addi	s0,sp,32
    80002d24:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002d26:	00014517          	auipc	a0,0x14
    80002d2a:	b4250513          	addi	a0,a0,-1214 # 80016868 <bcache>
    80002d2e:	ecbfd0ef          	jal	80000bf8 <acquire>
  b->refcnt--;
    80002d32:	40bc                	lw	a5,64(s1)
    80002d34:	37fd                	addiw	a5,a5,-1
    80002d36:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002d38:	00014517          	auipc	a0,0x14
    80002d3c:	b3050513          	addi	a0,a0,-1232 # 80016868 <bcache>
    80002d40:	f3dfd0ef          	jal	80000c7c <release>
}
    80002d44:	60e2                	ld	ra,24(sp)
    80002d46:	6442                	ld	s0,16(sp)
    80002d48:	64a2                	ld	s1,8(sp)
    80002d4a:	6105                	addi	sp,sp,32
    80002d4c:	8082                	ret

0000000080002d4e <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80002d4e:	1101                	addi	sp,sp,-32
    80002d50:	ec06                	sd	ra,24(sp)
    80002d52:	e822                	sd	s0,16(sp)
    80002d54:	e426                	sd	s1,8(sp)
    80002d56:	e04a                	sd	s2,0(sp)
    80002d58:	1000                	addi	s0,sp,32
    80002d5a:	84ae                	mv	s1,a1
    panic("bfree: refcount not zero");
#endif
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80002d5c:	00d5d79b          	srliw	a5,a1,0xd
    80002d60:	00055597          	auipc	a1,0x55
    80002d64:	2145a583          	lw	a1,532(a1) # 80057f74 <sb+0x1c>
    80002d68:	9dbd                	addw	a1,a1,a5
    80002d6a:	df1ff0ef          	jal	80002b5a <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80002d6e:	0074f713          	andi	a4,s1,7
    80002d72:	4785                	li	a5,1
    80002d74:	00e797bb          	sllw	a5,a5,a4
  bi = b % BPB;
    80002d78:	14ce                	slli	s1,s1,0x33
  if ((bp->data[bi / 8] & m) == 0)
    80002d7a:	90d9                	srli	s1,s1,0x36
    80002d7c:	00950733          	add	a4,a0,s1
    80002d80:	05874703          	lbu	a4,88(a4)
    80002d84:	00e7f6b3          	and	a3,a5,a4
    80002d88:	c29d                	beqz	a3,80002dae <bfree+0x60>
    80002d8a:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi / 8] &= ~m;
    80002d8c:	94aa                	add	s1,s1,a0
    80002d8e:	fff7c793          	not	a5,a5
    80002d92:	8f7d                	and	a4,a4,a5
    80002d94:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    80002d98:	376010ef          	jal	8000410e <log_write>
  brelse(bp);
    80002d9c:	854a                	mv	a0,s2
    80002d9e:	ec5ff0ef          	jal	80002c62 <brelse>
}
    80002da2:	60e2                	ld	ra,24(sp)
    80002da4:	6442                	ld	s0,16(sp)
    80002da6:	64a2                	ld	s1,8(sp)
    80002da8:	6902                	ld	s2,0(sp)
    80002daa:	6105                	addi	sp,sp,32
    80002dac:	8082                	ret
    panic("freeing free block");
    80002dae:	00005517          	auipc	a0,0x5
    80002db2:	63250513          	addi	a0,a0,1586 # 800083e0 <etext+0x3e0>
    80002db6:	a93fd0ef          	jal	80000848 <panic>

0000000080002dba <balloc>:
{
    80002dba:	715d                	addi	sp,sp,-80
    80002dbc:	e486                	sd	ra,72(sp)
    80002dbe:	e0a2                	sd	s0,64(sp)
    80002dc0:	fc26                	sd	s1,56(sp)
    80002dc2:	0880                	addi	s0,sp,80
  for (b = 0; b < sb.size; b += BPB) {
    80002dc4:	00055797          	auipc	a5,0x55
    80002dc8:	1987a783          	lw	a5,408(a5) # 80057f5c <sb+0x4>
    80002dcc:	0e078263          	beqz	a5,80002eb0 <balloc+0xf6>
    80002dd0:	f84a                	sd	s2,48(sp)
    80002dd2:	f44e                	sd	s3,40(sp)
    80002dd4:	f052                	sd	s4,32(sp)
    80002dd6:	ec56                	sd	s5,24(sp)
    80002dd8:	e85a                	sd	s6,16(sp)
    80002dda:	e45e                	sd	s7,8(sp)
    80002ddc:	e062                	sd	s8,0(sp)
    80002dde:	8baa                	mv	s7,a0
    80002de0:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002de2:	00055b17          	auipc	s6,0x55
    80002de6:	176b0b13          	addi	s6,s6,374 # 80057f58 <sb>
      m = 1 << (bi % 8);
    80002dea:	4985                	li	s3,1
    for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
    80002dec:	6a09                	lui	s4,0x2
  for (b = 0; b < sb.size; b += BPB) {
    80002dee:	6c09                	lui	s8,0x2
    80002df0:	a09d                	j	80002e56 <balloc+0x9c>
        bp->data[bi / 8] |= m;           // Mark block in use.
    80002df2:	97ca                	add	a5,a5,s2
    80002df4:	8e55                	or	a2,a2,a3
    80002df6:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    80002dfa:	854a                	mv	a0,s2
    80002dfc:	312010ef          	jal	8000410e <log_write>
        brelse(bp);
    80002e00:	854a                	mv	a0,s2
    80002e02:	e61ff0ef          	jal	80002c62 <brelse>
  bp = bread(dev, bno);
    80002e06:	85a6                	mv	a1,s1
    80002e08:	855e                	mv	a0,s7
    80002e0a:	d51ff0ef          	jal	80002b5a <bread>
    80002e0e:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    80002e10:	40000613          	li	a2,1024
    80002e14:	4581                	li	a1,0
    80002e16:	05850513          	addi	a0,a0,88
    80002e1a:	e9bfd0ef          	jal	80000cb4 <memset>
  log_write(bp);
    80002e1e:	854a                	mv	a0,s2
    80002e20:	2ee010ef          	jal	8000410e <log_write>
  brelse(bp);
    80002e24:	854a                	mv	a0,s2
    80002e26:	e3dff0ef          	jal	80002c62 <brelse>
        return b + bi;
    80002e2a:	7942                	ld	s2,48(sp)
    80002e2c:	79a2                	ld	s3,40(sp)
    80002e2e:	7a02                	ld	s4,32(sp)
    80002e30:	6ae2                	ld	s5,24(sp)
    80002e32:	6b42                	ld	s6,16(sp)
    80002e34:	6ba2                	ld	s7,8(sp)
    80002e36:	6c02                	ld	s8,0(sp)
}
    80002e38:	8526                	mv	a0,s1
    80002e3a:	60a6                	ld	ra,72(sp)
    80002e3c:	6406                	ld	s0,64(sp)
    80002e3e:	74e2                	ld	s1,56(sp)
    80002e40:	6161                	addi	sp,sp,80
    80002e42:	8082                	ret
    brelse(bp);
    80002e44:	854a                	mv	a0,s2
    80002e46:	e1dff0ef          	jal	80002c62 <brelse>
  for (b = 0; b < sb.size; b += BPB) {
    80002e4a:	015c0abb          	addw	s5,s8,s5
    80002e4e:	004b2783          	lw	a5,4(s6)
    80002e52:	04faf863          	bgeu	s5,a5,80002ea2 <balloc+0xe8>
    bp = bread(dev, BBLOCK(b, sb));
    80002e56:	40dad59b          	sraiw	a1,s5,0xd
    80002e5a:	01cb2783          	lw	a5,28(s6)
    80002e5e:	9dbd                	addw	a1,a1,a5
    80002e60:	855e                	mv	a0,s7
    80002e62:	cf9ff0ef          	jal	80002b5a <bread>
    80002e66:	892a                	mv	s2,a0
    for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
    80002e68:	004b2503          	lw	a0,4(s6)
    80002e6c:	84d6                	mv	s1,s5
    80002e6e:	4701                	li	a4,0
    80002e70:	fca4fae3          	bgeu	s1,a0,80002e44 <balloc+0x8a>
      m = 1 << (bi % 8);
    80002e74:	00777693          	andi	a3,a4,7
    80002e78:	00d996bb          	sllw	a3,s3,a3
      if ((bp->data[bi / 8] & m) == 0) { // Is block free?
    80002e7c:	41f7579b          	sraiw	a5,a4,0x1f
    80002e80:	01d7d79b          	srliw	a5,a5,0x1d
    80002e84:	9fb9                	addw	a5,a5,a4
    80002e86:	4037d79b          	sraiw	a5,a5,0x3
    80002e8a:	00f90633          	add	a2,s2,a5
    80002e8e:	05864603          	lbu	a2,88(a2) # 1058 <_entry-0x7fffefa8>
    80002e92:	00c6f5b3          	and	a1,a3,a2
    80002e96:	ddb1                	beqz	a1,80002df2 <balloc+0x38>
    for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
    80002e98:	2705                	addiw	a4,a4,1
    80002e9a:	2485                	addiw	s1,s1,1
    80002e9c:	fd471ae3          	bne	a4,s4,80002e70 <balloc+0xb6>
    80002ea0:	b755                	j	80002e44 <balloc+0x8a>
    80002ea2:	7942                	ld	s2,48(sp)
    80002ea4:	79a2                	ld	s3,40(sp)
    80002ea6:	7a02                	ld	s4,32(sp)
    80002ea8:	6ae2                	ld	s5,24(sp)
    80002eaa:	6b42                	ld	s6,16(sp)
    80002eac:	6ba2                	ld	s7,8(sp)
    80002eae:	6c02                	ld	s8,0(sp)
  printk("balloc: out of blocks\n");
    80002eb0:	00005517          	auipc	a0,0x5
    80002eb4:	54850513          	addi	a0,a0,1352 # 800083f8 <etext+0x3f8>
    80002eb8:	e58fd0ef          	jal	80000510 <printk>
  return 0;
    80002ebc:	4481                	li	s1,0
    80002ebe:	bfad                	j	80002e38 <balloc+0x7e>

0000000080002ec0 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    80002ec0:	7139                	addi	sp,sp,-64
    80002ec2:	fc06                	sd	ra,56(sp)
    80002ec4:	f822                	sd	s0,48(sp)
    80002ec6:	f426                	sd	s1,40(sp)
    80002ec8:	f04a                	sd	s2,32(sp)
    80002eca:	ec4e                	sd	s3,24(sp)
    80002ecc:	0080                	addi	s0,sp,64
    80002ece:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if (bn < NDIRECT) {
    80002ed0:	47a9                	li	a5,10
    80002ed2:	02b7eb63          	bltu	a5,a1,80002f08 <bmap+0x48>
    if ((addr = ip->addrs[bn]) == 0) {
    80002ed6:	02059793          	slli	a5,a1,0x20
    80002eda:	01e7d593          	srli	a1,a5,0x1e
    80002ede:	00b509b3          	add	s3,a0,a1
    80002ee2:	0509a483          	lw	s1,80(s3)
    80002ee6:	c889                	beqz	s1,80002ef8 <bmap+0x38>
    return addr;
  }
  bn -= NINDIRECT;

  panic("bmap: out of range");
}
    80002ee8:	8526                	mv	a0,s1
    80002eea:	70e2                	ld	ra,56(sp)
    80002eec:	7442                	ld	s0,48(sp)
    80002eee:	74a2                	ld	s1,40(sp)
    80002ef0:	7902                	ld	s2,32(sp)
    80002ef2:	69e2                	ld	s3,24(sp)
    80002ef4:	6121                	addi	sp,sp,64
    80002ef6:	8082                	ret
      addr = balloc(ip->dev);
    80002ef8:	4108                	lw	a0,0(a0)
    80002efa:	ec1ff0ef          	jal	80002dba <balloc>
    80002efe:	84aa                	mv	s1,a0
      if (addr == 0)
    80002f00:	d565                	beqz	a0,80002ee8 <bmap+0x28>
      ip->addrs[bn] = addr;
    80002f02:	04a9a823          	sw	a0,80(s3)
    80002f06:	b7cd                	j	80002ee8 <bmap+0x28>
  bn -= NDIRECT;
    80002f08:	ff55879b          	addiw	a5,a1,-11
    80002f0c:	873e                	mv	a4,a5
    80002f0e:	89be                	mv	s3,a5
  if (bn < NINDIRECT) {
    80002f10:	0ff00793          	li	a5,255
    80002f14:	04e7ef63          	bltu	a5,a4,80002f72 <bmap+0xb2>
    if ((addr = ip->addrs[NDIRECT]) == 0) {
    80002f18:	5d64                	lw	s1,124(a0)
    80002f1a:	e891                	bnez	s1,80002f2e <bmap+0x6e>
      addr = balloc(ip->dev);
    80002f1c:	4108                	lw	a0,0(a0)
    80002f1e:	e9dff0ef          	jal	80002dba <balloc>
    80002f22:	84aa                	mv	s1,a0
      if (addr == 0)
    80002f24:	d171                	beqz	a0,80002ee8 <bmap+0x28>
    80002f26:	e852                	sd	s4,16(sp)
      ip->addrs[NDIRECT] = addr;
    80002f28:	06a92e23          	sw	a0,124(s2)
    80002f2c:	a011                	j	80002f30 <bmap+0x70>
    80002f2e:	e852                	sd	s4,16(sp)
    bp = bread(ip->dev, addr);
    80002f30:	85a6                	mv	a1,s1
    80002f32:	00092503          	lw	a0,0(s2)
    80002f36:	c25ff0ef          	jal	80002b5a <bread>
    80002f3a:	8a2a                	mv	s4,a0
    a = (uint *)bp->data;
    80002f3c:	05850713          	addi	a4,a0,88
    if ((addr = a[bn]) == 0) {
    80002f40:	02099693          	slli	a3,s3,0x20
    80002f44:	01e6d793          	srli	a5,a3,0x1e
    80002f48:	97ba                	add	a5,a5,a4
    80002f4a:	89be                	mv	s3,a5
    80002f4c:	4384                	lw	s1,0(a5)
    80002f4e:	c491                	beqz	s1,80002f5a <bmap+0x9a>
    brelse(bp);
    80002f50:	8552                	mv	a0,s4
    80002f52:	d11ff0ef          	jal	80002c62 <brelse>
    return addr;
    80002f56:	6a42                	ld	s4,16(sp)
    80002f58:	bf41                	j	80002ee8 <bmap+0x28>
      addr = balloc(ip->dev);
    80002f5a:	00092503          	lw	a0,0(s2)
    80002f5e:	e5dff0ef          	jal	80002dba <balloc>
    80002f62:	84aa                	mv	s1,a0
      if (addr) {
    80002f64:	d575                	beqz	a0,80002f50 <bmap+0x90>
        a[bn] = addr;
    80002f66:	00a9a023          	sw	a0,0(s3)
        log_write(bp);
    80002f6a:	8552                	mv	a0,s4
    80002f6c:	1a2010ef          	jal	8000410e <log_write>
    80002f70:	b7c5                	j	80002f50 <bmap+0x90>
    80002f72:	e852                	sd	s4,16(sp)
  bn -= NINDIRECT;
    80002f74:	ef55879b          	addiw	a5,a1,-267
    80002f78:	873e                	mv	a4,a5
    80002f7a:	8a3e                	mv	s4,a5
  if(bn < NINDIRECT * NINDIRECT){
    80002f7c:	67c1                	lui	a5,0x10
    80002f7e:	0af77363          	bgeu	a4,a5,80003024 <bmap+0x164>
    if((addr = ip->addrs[NDIRECT + 1]) == 0){
    80002f82:	08052483          	lw	s1,128(a0)
    80002f86:	e891                	bnez	s1,80002f9a <bmap+0xda>
      addr = balloc(ip->dev);
    80002f88:	4108                	lw	a0,0(a0)
    80002f8a:	e31ff0ef          	jal	80002dba <balloc>
    80002f8e:	84aa                	mv	s1,a0
      if(addr == 0)
    80002f90:	c14d                	beqz	a0,80003032 <bmap+0x172>
    80002f92:	e456                	sd	s5,8(sp)
      ip->addrs[NDIRECT + 1] = addr;
    80002f94:	08a92023          	sw	a0,128(s2)
    80002f98:	a011                	j	80002f9c <bmap+0xdc>
    80002f9a:	e456                	sd	s5,8(sp)
    bp = bread(ip->dev, addr);
    80002f9c:	85a6                	mv	a1,s1
    80002f9e:	00092503          	lw	a0,0(s2)
    80002fa2:	bb9ff0ef          	jal	80002b5a <bread>
    80002fa6:	89aa                	mv	s3,a0
    a = (uint*)bp->data;
    80002fa8:	05850793          	addi	a5,a0,88
    if((addr = a[outer]) == 0){
    80002fac:	008a571b          	srliw	a4,s4,0x8
    80002fb0:	070a                	slli	a4,a4,0x2
    80002fb2:	97ba                	add	a5,a5,a4
    80002fb4:	8abe                	mv	s5,a5
    80002fb6:	4384                	lw	s1,0(a5)
    80002fb8:	e095                	bnez	s1,80002fdc <bmap+0x11c>
      addr = balloc(ip->dev);
    80002fba:	00092503          	lw	a0,0(s2)
    80002fbe:	dfdff0ef          	jal	80002dba <balloc>
    80002fc2:	84aa                	mv	s1,a0
      if(addr == 0){
    80002fc4:	e519                	bnez	a0,80002fd2 <bmap+0x112>
        brelse(bp);
    80002fc6:	854e                	mv	a0,s3
    80002fc8:	c9bff0ef          	jal	80002c62 <brelse>
        return 0;
    80002fcc:	6a42                	ld	s4,16(sp)
    80002fce:	6aa2                	ld	s5,8(sp)
    80002fd0:	bf21                	j	80002ee8 <bmap+0x28>
      a[outer] = addr;
    80002fd2:	00aaa023          	sw	a0,0(s5)
      log_write(bp);
    80002fd6:	854e                	mv	a0,s3
    80002fd8:	136010ef          	jal	8000410e <log_write>
    brelse(bp);
    80002fdc:	854e                	mv	a0,s3
    80002fde:	c85ff0ef          	jal	80002c62 <brelse>
    bp = bread(ip->dev, addr);
    80002fe2:	85a6                	mv	a1,s1
    80002fe4:	00092503          	lw	a0,0(s2)
    80002fe8:	b73ff0ef          	jal	80002b5a <bread>
    80002fec:	89aa                	mv	s3,a0
    a = (uint*)bp->data;
    80002fee:	05850793          	addi	a5,a0,88
    if((addr = a[inner]) == 0){
    80002ff2:	0ffa7593          	zext.b	a1,s4
    80002ff6:	058a                	slli	a1,a1,0x2
    80002ff8:	97ae                	add	a5,a5,a1
    80002ffa:	8a3e                	mv	s4,a5
    80002ffc:	4384                	lw	s1,0(a5)
    80002ffe:	c499                	beqz	s1,8000300c <bmap+0x14c>
    brelse(bp);
    80003000:	854e                	mv	a0,s3
    80003002:	c61ff0ef          	jal	80002c62 <brelse>
    return addr;
    80003006:	6a42                	ld	s4,16(sp)
    80003008:	6aa2                	ld	s5,8(sp)
    8000300a:	bdf9                	j	80002ee8 <bmap+0x28>
      addr = balloc(ip->dev);
    8000300c:	00092503          	lw	a0,0(s2)
    80003010:	dabff0ef          	jal	80002dba <balloc>
    80003014:	84aa                	mv	s1,a0
      if(addr){
    80003016:	d56d                	beqz	a0,80003000 <bmap+0x140>
        a[inner] = addr;
    80003018:	00aa2023          	sw	a0,0(s4) # 2000 <_entry-0x7fffe000>
        log_write(bp);
    8000301c:	854e                	mv	a0,s3
    8000301e:	0f0010ef          	jal	8000410e <log_write>
    80003022:	bff9                	j	80003000 <bmap+0x140>
    80003024:	e456                	sd	s5,8(sp)
  panic("bmap: out of range");
    80003026:	00005517          	auipc	a0,0x5
    8000302a:	3ea50513          	addi	a0,a0,1002 # 80008410 <etext+0x410>
    8000302e:	81bfd0ef          	jal	80000848 <panic>
    80003032:	6a42                	ld	s4,16(sp)
    80003034:	bd55                	j	80002ee8 <bmap+0x28>

0000000080003036 <iget>:
{
    80003036:	7179                	addi	sp,sp,-48
    80003038:	f406                	sd	ra,40(sp)
    8000303a:	f022                	sd	s0,32(sp)
    8000303c:	ec26                	sd	s1,24(sp)
    8000303e:	e84a                	sd	s2,16(sp)
    80003040:	e44e                	sd	s3,8(sp)
    80003042:	e052                	sd	s4,0(sp)
    80003044:	1800                	addi	s0,sp,48
    80003046:	89aa                	mv	s3,a0
    80003048:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    8000304a:	00055517          	auipc	a0,0x55
    8000304e:	f3650513          	addi	a0,a0,-202 # 80057f80 <itable>
    80003052:	ba7fd0ef          	jal	80000bf8 <acquire>
  empty = 0;
    80003056:	4901                	li	s2,0
  for (ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++) {
    80003058:	00055497          	auipc	s1,0x55
    8000305c:	f4048493          	addi	s1,s1,-192 # 80057f98 <itable+0x18>
    80003060:	00057697          	auipc	a3,0x57
    80003064:	9c868693          	addi	a3,a3,-1592 # 80059a28 <log>
    80003068:	a819                	j	8000307e <iget+0x48>
    if (empty == 0 && ip->ref == 0) // Remember empty slot.
    8000306a:	0017b793          	seqz	a5,a5
    8000306e:	00193713          	seqz	a4,s2
    80003072:	8ff9                	and	a5,a5,a4
    80003074:	eb85                	bnez	a5,800030a4 <iget+0x6e>
  for (ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++) {
    80003076:	08848493          	addi	s1,s1,136
    8000307a:	02d48763          	beq	s1,a3,800030a8 <iget+0x72>
    if (ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
    8000307e:	449c                	lw	a5,8(s1)
    80003080:	fef055e3          	blez	a5,8000306a <iget+0x34>
    80003084:	4098                	lw	a4,0(s1)
    80003086:	ff3718e3          	bne	a4,s3,80003076 <iget+0x40>
    8000308a:	40d8                	lw	a4,4(s1)
    8000308c:	ff4715e3          	bne	a4,s4,80003076 <iget+0x40>
      ip->ref++;
    80003090:	2785                	addiw	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80003092:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80003094:	00055517          	auipc	a0,0x55
    80003098:	eec50513          	addi	a0,a0,-276 # 80057f80 <itable>
    8000309c:	be1fd0ef          	jal	80000c7c <release>
      return ip;
    800030a0:	8926                	mv	s2,s1
    800030a2:	a025                	j	800030ca <iget+0x94>
      empty = ip;
    800030a4:	8926                	mv	s2,s1
    800030a6:	bfc1                	j	80003076 <iget+0x40>
  if (empty == 0)
    800030a8:	02090a63          	beqz	s2,800030dc <iget+0xa6>
  ip->dev = dev;
    800030ac:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    800030b0:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    800030b4:	4785                	li	a5,1
    800030b6:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    800030ba:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    800030be:	00055517          	auipc	a0,0x55
    800030c2:	ec250513          	addi	a0,a0,-318 # 80057f80 <itable>
    800030c6:	bb7fd0ef          	jal	80000c7c <release>
}
    800030ca:	854a                	mv	a0,s2
    800030cc:	70a2                	ld	ra,40(sp)
    800030ce:	7402                	ld	s0,32(sp)
    800030d0:	64e2                	ld	s1,24(sp)
    800030d2:	6942                	ld	s2,16(sp)
    800030d4:	69a2                	ld	s3,8(sp)
    800030d6:	6a02                	ld	s4,0(sp)
    800030d8:	6145                	addi	sp,sp,48
    800030da:	8082                	ret
    panic("iget: no inodes");
    800030dc:	00005517          	auipc	a0,0x5
    800030e0:	34c50513          	addi	a0,a0,844 # 80008428 <etext+0x428>
    800030e4:	f64fd0ef          	jal	80000848 <panic>

00000000800030e8 <iinit>:
{
    800030e8:	7179                	addi	sp,sp,-48
    800030ea:	f406                	sd	ra,40(sp)
    800030ec:	f022                	sd	s0,32(sp)
    800030ee:	ec26                	sd	s1,24(sp)
    800030f0:	e84a                	sd	s2,16(sp)
    800030f2:	e44e                	sd	s3,8(sp)
    800030f4:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    800030f6:	00005597          	auipc	a1,0x5
    800030fa:	34258593          	addi	a1,a1,834 # 80008438 <etext+0x438>
    800030fe:	00055517          	auipc	a0,0x55
    80003102:	e8250513          	addi	a0,a0,-382 # 80057f80 <itable>
    80003106:	a73fd0ef          	jal	80000b78 <initlock>
  for (i = 0; i < NINODE; i++) {
    8000310a:	00055497          	auipc	s1,0x55
    8000310e:	e9e48493          	addi	s1,s1,-354 # 80057fa8 <itable+0x28>
    80003112:	00057997          	auipc	s3,0x57
    80003116:	92698993          	addi	s3,s3,-1754 # 80059a38 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    8000311a:	00005917          	auipc	s2,0x5
    8000311e:	32690913          	addi	s2,s2,806 # 80008440 <etext+0x440>
    80003122:	85ca                	mv	a1,s2
    80003124:	8526                	mv	a0,s1
    80003126:	11e010ef          	jal	80004244 <initsleeplock>
  for (i = 0; i < NINODE; i++) {
    8000312a:	08848493          	addi	s1,s1,136
    8000312e:	ff349ae3          	bne	s1,s3,80003122 <iinit+0x3a>
}
    80003132:	70a2                	ld	ra,40(sp)
    80003134:	7402                	ld	s0,32(sp)
    80003136:	64e2                	ld	s1,24(sp)
    80003138:	6942                	ld	s2,16(sp)
    8000313a:	69a2                	ld	s3,8(sp)
    8000313c:	6145                	addi	sp,sp,48
    8000313e:	8082                	ret

0000000080003140 <ialloc>:
{
    80003140:	7139                	addi	sp,sp,-64
    80003142:	fc06                	sd	ra,56(sp)
    80003144:	f822                	sd	s0,48(sp)
    80003146:	0080                	addi	s0,sp,64
  for (inum = 1; inum < sb.ninodes; inum++) {
    80003148:	00055717          	auipc	a4,0x55
    8000314c:	e1c72703          	lw	a4,-484(a4) # 80057f64 <sb+0xc>
    80003150:	4785                	li	a5,1
    80003152:	06e7f063          	bgeu	a5,a4,800031b2 <ialloc+0x72>
    80003156:	f426                	sd	s1,40(sp)
    80003158:	f04a                	sd	s2,32(sp)
    8000315a:	ec4e                	sd	s3,24(sp)
    8000315c:	e852                	sd	s4,16(sp)
    8000315e:	e456                	sd	s5,8(sp)
    80003160:	e05a                	sd	s6,0(sp)
    80003162:	8aaa                	mv	s5,a0
    80003164:	8b2e                	mv	s6,a1
    80003166:	893e                	mv	s2,a5
    bp = bread(dev, IBLOCK(inum, sb));
    80003168:	00055a17          	auipc	s4,0x55
    8000316c:	df0a0a13          	addi	s4,s4,-528 # 80057f58 <sb>
    80003170:	00495593          	srli	a1,s2,0x4
    80003174:	018a2783          	lw	a5,24(s4)
    80003178:	9dbd                	addw	a1,a1,a5
    8000317a:	8556                	mv	a0,s5
    8000317c:	9dfff0ef          	jal	80002b5a <bread>
    80003180:	84aa                	mv	s1,a0
    dip = (struct dinode *)bp->data + inum % IPB;
    80003182:	05850993          	addi	s3,a0,88
    80003186:	00f97793          	andi	a5,s2,15
    8000318a:	079a                	slli	a5,a5,0x6
    8000318c:	99be                	add	s3,s3,a5
    if (dip->type == 0) { // a free inode
    8000318e:	00099783          	lh	a5,0(s3)
    80003192:	cb9d                	beqz	a5,800031c8 <ialloc+0x88>
    brelse(bp);
    80003194:	acfff0ef          	jal	80002c62 <brelse>
  for (inum = 1; inum < sb.ninodes; inum++) {
    80003198:	0905                	addi	s2,s2,1
    8000319a:	00ca2703          	lw	a4,12(s4)
    8000319e:	0009079b          	sext.w	a5,s2
    800031a2:	fce7e7e3          	bltu	a5,a4,80003170 <ialloc+0x30>
    800031a6:	74a2                	ld	s1,40(sp)
    800031a8:	7902                	ld	s2,32(sp)
    800031aa:	69e2                	ld	s3,24(sp)
    800031ac:	6a42                	ld	s4,16(sp)
    800031ae:	6aa2                	ld	s5,8(sp)
    800031b0:	6b02                	ld	s6,0(sp)
  printk("ialloc: no inodes\n");
    800031b2:	00005517          	auipc	a0,0x5
    800031b6:	29650513          	addi	a0,a0,662 # 80008448 <etext+0x448>
    800031ba:	b56fd0ef          	jal	80000510 <printk>
  return 0;
    800031be:	4501                	li	a0,0
}
    800031c0:	70e2                	ld	ra,56(sp)
    800031c2:	7442                	ld	s0,48(sp)
    800031c4:	6121                	addi	sp,sp,64
    800031c6:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    800031c8:	04000613          	li	a2,64
    800031cc:	4581                	li	a1,0
    800031ce:	854e                	mv	a0,s3
    800031d0:	ae5fd0ef          	jal	80000cb4 <memset>
      dip->type = type;
    800031d4:	01699023          	sh	s6,0(s3)
      log_write(bp); // mark it allocated on the disk
    800031d8:	8526                	mv	a0,s1
    800031da:	735000ef          	jal	8000410e <log_write>
      brelse(bp);
    800031de:	8526                	mv	a0,s1
    800031e0:	a83ff0ef          	jal	80002c62 <brelse>
      return iget(dev, inum);
    800031e4:	0009059b          	sext.w	a1,s2
    800031e8:	8556                	mv	a0,s5
    800031ea:	e4dff0ef          	jal	80003036 <iget>
    800031ee:	74a2                	ld	s1,40(sp)
    800031f0:	7902                	ld	s2,32(sp)
    800031f2:	69e2                	ld	s3,24(sp)
    800031f4:	6a42                	ld	s4,16(sp)
    800031f6:	6aa2                	ld	s5,8(sp)
    800031f8:	6b02                	ld	s6,0(sp)
    800031fa:	b7d9                	j	800031c0 <ialloc+0x80>

00000000800031fc <iupdate>:
{
    800031fc:	1101                	addi	sp,sp,-32
    800031fe:	ec06                	sd	ra,24(sp)
    80003200:	e822                	sd	s0,16(sp)
    80003202:	e426                	sd	s1,8(sp)
    80003204:	e04a                	sd	s2,0(sp)
    80003206:	1000                	addi	s0,sp,32
    80003208:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    8000320a:	415c                	lw	a5,4(a0)
    8000320c:	0047d79b          	srliw	a5,a5,0x4
    80003210:	00055597          	auipc	a1,0x55
    80003214:	d605a583          	lw	a1,-672(a1) # 80057f70 <sb+0x18>
    80003218:	9dbd                	addw	a1,a1,a5
    8000321a:	4108                	lw	a0,0(a0)
    8000321c:	93fff0ef          	jal	80002b5a <bread>
    80003220:	892a                	mv	s2,a0
  dip = (struct dinode *)bp->data + ip->inum % IPB;
    80003222:	05850793          	addi	a5,a0,88
    80003226:	40d8                	lw	a4,4(s1)
    80003228:	8b3d                	andi	a4,a4,15
    8000322a:	071a                	slli	a4,a4,0x6
    8000322c:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    8000322e:	04449703          	lh	a4,68(s1)
    80003232:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80003236:	04649703          	lh	a4,70(s1)
    8000323a:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    8000323e:	04849703          	lh	a4,72(s1)
    80003242:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80003246:	04a49703          	lh	a4,74(s1)
    8000324a:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    8000324e:	44f8                	lw	a4,76(s1)
    80003250:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80003252:	03400613          	li	a2,52
    80003256:	05048593          	addi	a1,s1,80
    8000325a:	00c78513          	addi	a0,a5,12
    8000325e:	ab3fd0ef          	jal	80000d10 <memmove>
  log_write(bp);
    80003262:	854a                	mv	a0,s2
    80003264:	6ab000ef          	jal	8000410e <log_write>
  brelse(bp);
    80003268:	854a                	mv	a0,s2
    8000326a:	9f9ff0ef          	jal	80002c62 <brelse>
}
    8000326e:	60e2                	ld	ra,24(sp)
    80003270:	6442                	ld	s0,16(sp)
    80003272:	64a2                	ld	s1,8(sp)
    80003274:	6902                	ld	s2,0(sp)
    80003276:	6105                	addi	sp,sp,32
    80003278:	8082                	ret

000000008000327a <idup>:
{
    8000327a:	1101                	addi	sp,sp,-32
    8000327c:	ec06                	sd	ra,24(sp)
    8000327e:	e822                	sd	s0,16(sp)
    80003280:	e426                	sd	s1,8(sp)
    80003282:	1000                	addi	s0,sp,32
    80003284:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003286:	00055517          	auipc	a0,0x55
    8000328a:	cfa50513          	addi	a0,a0,-774 # 80057f80 <itable>
    8000328e:	96bfd0ef          	jal	80000bf8 <acquire>
  ip->ref++;
    80003292:	449c                	lw	a5,8(s1)
    80003294:	2785                	addiw	a5,a5,1
    80003296:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003298:	00055517          	auipc	a0,0x55
    8000329c:	ce850513          	addi	a0,a0,-792 # 80057f80 <itable>
    800032a0:	9ddfd0ef          	jal	80000c7c <release>
}
    800032a4:	8526                	mv	a0,s1
    800032a6:	60e2                	ld	ra,24(sp)
    800032a8:	6442                	ld	s0,16(sp)
    800032aa:	64a2                	ld	s1,8(sp)
    800032ac:	6105                	addi	sp,sp,32
    800032ae:	8082                	ret

00000000800032b0 <ilock>:
{
    800032b0:	1101                	addi	sp,sp,-32
    800032b2:	ec06                	sd	ra,24(sp)
    800032b4:	e822                	sd	s0,16(sp)
    800032b6:	e426                	sd	s1,8(sp)
    800032b8:	1000                	addi	s0,sp,32
  if (ip == 0 || ip->ref < 1)
    800032ba:	cd19                	beqz	a0,800032d8 <ilock+0x28>
    800032bc:	84aa                	mv	s1,a0
    800032be:	451c                	lw	a5,8(a0)
    800032c0:	00f05c63          	blez	a5,800032d8 <ilock+0x28>
  acquiresleep(&ip->lock);
    800032c4:	0541                	addi	a0,a0,16
    800032c6:	7b5000ef          	jal	8000427a <acquiresleep>
  if (ip->valid == 0) {
    800032ca:	40bc                	lw	a5,64(s1)
    800032cc:	cf89                	beqz	a5,800032e6 <ilock+0x36>
}
    800032ce:	60e2                	ld	ra,24(sp)
    800032d0:	6442                	ld	s0,16(sp)
    800032d2:	64a2                	ld	s1,8(sp)
    800032d4:	6105                	addi	sp,sp,32
    800032d6:	8082                	ret
    800032d8:	e04a                	sd	s2,0(sp)
    panic("ilock");
    800032da:	00005517          	auipc	a0,0x5
    800032de:	18650513          	addi	a0,a0,390 # 80008460 <etext+0x460>
    800032e2:	d66fd0ef          	jal	80000848 <panic>
    800032e6:	e04a                	sd	s2,0(sp)
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800032e8:	40dc                	lw	a5,4(s1)
    800032ea:	0047d79b          	srliw	a5,a5,0x4
    800032ee:	00055597          	auipc	a1,0x55
    800032f2:	c825a583          	lw	a1,-894(a1) # 80057f70 <sb+0x18>
    800032f6:	9dbd                	addw	a1,a1,a5
    800032f8:	4088                	lw	a0,0(s1)
    800032fa:	861ff0ef          	jal	80002b5a <bread>
    800032fe:	892a                	mv	s2,a0
    dip = (struct dinode *)bp->data + ip->inum % IPB;
    80003300:	05850593          	addi	a1,a0,88
    80003304:	40dc                	lw	a5,4(s1)
    80003306:	8bbd                	andi	a5,a5,15
    80003308:	079a                	slli	a5,a5,0x6
    8000330a:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    8000330c:	00059783          	lh	a5,0(a1)
    80003310:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80003314:	00259783          	lh	a5,2(a1)
    80003318:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    8000331c:	00459783          	lh	a5,4(a1)
    80003320:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80003324:	00659783          	lh	a5,6(a1)
    80003328:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    8000332c:	459c                	lw	a5,8(a1)
    8000332e:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80003330:	03400613          	li	a2,52
    80003334:	05b1                	addi	a1,a1,12
    80003336:	05048513          	addi	a0,s1,80
    8000333a:	9d7fd0ef          	jal	80000d10 <memmove>
    brelse(bp);
    8000333e:	854a                	mv	a0,s2
    80003340:	923ff0ef          	jal	80002c62 <brelse>
    ip->valid = 1;
    80003344:	4785                	li	a5,1
    80003346:	c0bc                	sw	a5,64(s1)
    if (ip->type == 0)
    80003348:	04449783          	lh	a5,68(s1)
    8000334c:	c399                	beqz	a5,80003352 <ilock+0xa2>
    8000334e:	6902                	ld	s2,0(sp)
    80003350:	bfbd                	j	800032ce <ilock+0x1e>
      panic("ilock: no type");
    80003352:	00005517          	auipc	a0,0x5
    80003356:	11650513          	addi	a0,a0,278 # 80008468 <etext+0x468>
    8000335a:	ceefd0ef          	jal	80000848 <panic>

000000008000335e <iunlock>:
{
    8000335e:	1101                	addi	sp,sp,-32
    80003360:	ec06                	sd	ra,24(sp)
    80003362:	e822                	sd	s0,16(sp)
    80003364:	e426                	sd	s1,8(sp)
    80003366:	e04a                	sd	s2,0(sp)
    80003368:	1000                	addi	s0,sp,32
  if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    8000336a:	c505                	beqz	a0,80003392 <iunlock+0x34>
    8000336c:	84aa                	mv	s1,a0
    8000336e:	01050913          	addi	s2,a0,16
    80003372:	854a                	mv	a0,s2
    80003374:	793000ef          	jal	80004306 <holdingsleep>
    80003378:	cd09                	beqz	a0,80003392 <iunlock+0x34>
    8000337a:	449c                	lw	a5,8(s1)
    8000337c:	00f05b63          	blez	a5,80003392 <iunlock+0x34>
  releasesleep(&ip->lock);
    80003380:	854a                	mv	a0,s2
    80003382:	74d000ef          	jal	800042ce <releasesleep>
}
    80003386:	60e2                	ld	ra,24(sp)
    80003388:	6442                	ld	s0,16(sp)
    8000338a:	64a2                	ld	s1,8(sp)
    8000338c:	6902                	ld	s2,0(sp)
    8000338e:	6105                	addi	sp,sp,32
    80003390:	8082                	ret
    panic("iunlock");
    80003392:	00005517          	auipc	a0,0x5
    80003396:	0e650513          	addi	a0,a0,230 # 80008478 <etext+0x478>
    8000339a:	caefd0ef          	jal	80000848 <panic>

000000008000339e <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    8000339e:	715d                	addi	sp,sp,-80
    800033a0:	e486                	sd	ra,72(sp)
    800033a2:	e0a2                	sd	s0,64(sp)
    800033a4:	fc26                	sd	s1,56(sp)
    800033a6:	f84a                	sd	s2,48(sp)
    800033a8:	f44e                	sd	s3,40(sp)
    800033aa:	0880                	addi	s0,sp,80
    800033ac:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for (i = 0; i < NDIRECT; i++) {
    800033ae:	05050493          	addi	s1,a0,80
    800033b2:	07c50913          	addi	s2,a0,124
    800033b6:	a021                	j	800033be <itrunc+0x20>
    800033b8:	0491                	addi	s1,s1,4
    800033ba:	01248b63          	beq	s1,s2,800033d0 <itrunc+0x32>
    if (ip->addrs[i]) {
    800033be:	408c                	lw	a1,0(s1)
    800033c0:	dde5                	beqz	a1,800033b8 <itrunc+0x1a>
      bfree(ip->dev, ip->addrs[i]);
    800033c2:	0009a503          	lw	a0,0(s3)
    800033c6:	989ff0ef          	jal	80002d4e <bfree>
      ip->addrs[i] = 0;
    800033ca:	0004a023          	sw	zero,0(s1)
    800033ce:	b7ed                	j	800033b8 <itrunc+0x1a>
    }
  }

  if (ip->addrs[NDIRECT]) {
    800033d0:	07c9a583          	lw	a1,124(s3)
    800033d4:	e185                	bnez	a1,800033f4 <itrunc+0x56>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }
  struct buf *bp2;uint *a2;
  if(ip->addrs[NDIRECT + 1]){
    800033d6:	0809a583          	lw	a1,128(s3)
    800033da:	edb9                	bnez	a1,80003438 <itrunc+0x9a>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT + 1]);
    ip->addrs[NDIRECT + 1] = 0;
  }

  ip->size = 0;
    800033dc:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    800033e0:	854e                	mv	a0,s3
    800033e2:	e1bff0ef          	jal	800031fc <iupdate>
}
    800033e6:	60a6                	ld	ra,72(sp)
    800033e8:	6406                	ld	s0,64(sp)
    800033ea:	74e2                	ld	s1,56(sp)
    800033ec:	7942                	ld	s2,48(sp)
    800033ee:	79a2                	ld	s3,40(sp)
    800033f0:	6161                	addi	sp,sp,80
    800033f2:	8082                	ret
    800033f4:	f052                	sd	s4,32(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    800033f6:	0009a503          	lw	a0,0(s3)
    800033fa:	f60ff0ef          	jal	80002b5a <bread>
    800033fe:	8a2a                	mv	s4,a0
    for (j = 0; j < NINDIRECT; j++) {
    80003400:	05850493          	addi	s1,a0,88
    80003404:	45850913          	addi	s2,a0,1112
    80003408:	a021                	j	80003410 <itrunc+0x72>
    8000340a:	0491                	addi	s1,s1,4
    8000340c:	01248963          	beq	s1,s2,8000341e <itrunc+0x80>
      if (a[j])
    80003410:	408c                	lw	a1,0(s1)
    80003412:	dde5                	beqz	a1,8000340a <itrunc+0x6c>
        bfree(ip->dev, a[j]);
    80003414:	0009a503          	lw	a0,0(s3)
    80003418:	937ff0ef          	jal	80002d4e <bfree>
    8000341c:	b7fd                	j	8000340a <itrunc+0x6c>
    brelse(bp);
    8000341e:	8552                	mv	a0,s4
    80003420:	843ff0ef          	jal	80002c62 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80003424:	07c9a583          	lw	a1,124(s3)
    80003428:	0009a503          	lw	a0,0(s3)
    8000342c:	923ff0ef          	jal	80002d4e <bfree>
    ip->addrs[NDIRECT] = 0;
    80003430:	0609ae23          	sw	zero,124(s3)
    80003434:	7a02                	ld	s4,32(sp)
    80003436:	b745                	j	800033d6 <itrunc+0x38>
    80003438:	f052                	sd	s4,32(sp)
    8000343a:	ec56                	sd	s5,24(sp)
    8000343c:	e85a                	sd	s6,16(sp)
    8000343e:	e45e                	sd	s7,8(sp)
    80003440:	e062                	sd	s8,0(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT + 1]);
    80003442:	0009a503          	lw	a0,0(s3)
    80003446:	f14ff0ef          	jal	80002b5a <bread>
    8000344a:	8c2a                	mv	s8,a0
    for(j = 0; j < NINDIRECT; j++){
    8000344c:	05850a13          	addi	s4,a0,88
    80003450:	45850b13          	addi	s6,a0,1112
    80003454:	a03d                	j	80003482 <itrunc+0xe4>
            bfree(ip->dev, a2[k]);
    80003456:	0009a503          	lw	a0,0(s3)
    8000345a:	8f5ff0ef          	jal	80002d4e <bfree>
        for(int k = 0; k < NINDIRECT; k++){
    8000345e:	0491                	addi	s1,s1,4
    80003460:	01248563          	beq	s1,s2,8000346a <itrunc+0xcc>
          if(a2[k])
    80003464:	408c                	lw	a1,0(s1)
    80003466:	dde5                	beqz	a1,8000345e <itrunc+0xc0>
    80003468:	b7fd                	j	80003456 <itrunc+0xb8>
        brelse(bp2);
    8000346a:	855e                	mv	a0,s7
    8000346c:	ff6ff0ef          	jal	80002c62 <brelse>
        bfree(ip->dev, a[j]);
    80003470:	000aa583          	lw	a1,0(s5)
    80003474:	0009a503          	lw	a0,0(s3)
    80003478:	8d7ff0ef          	jal	80002d4e <bfree>
    for(j = 0; j < NINDIRECT; j++){
    8000347c:	0a11                	addi	s4,s4,4
    8000347e:	036a0063          	beq	s4,s6,8000349e <itrunc+0x100>
      if(a[j]){
    80003482:	8ad2                	mv	s5,s4
    80003484:	000a2583          	lw	a1,0(s4)
    80003488:	d9f5                	beqz	a1,8000347c <itrunc+0xde>
        bp2 = bread(ip->dev, a[j]);
    8000348a:	0009a503          	lw	a0,0(s3)
    8000348e:	eccff0ef          	jal	80002b5a <bread>
    80003492:	8baa                	mv	s7,a0
        for(int k = 0; k < NINDIRECT; k++){
    80003494:	05850493          	addi	s1,a0,88
    80003498:	45850913          	addi	s2,a0,1112
    8000349c:	b7e1                	j	80003464 <itrunc+0xc6>
    brelse(bp);
    8000349e:	8562                	mv	a0,s8
    800034a0:	fc2ff0ef          	jal	80002c62 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT + 1]);
    800034a4:	0809a583          	lw	a1,128(s3)
    800034a8:	0009a503          	lw	a0,0(s3)
    800034ac:	8a3ff0ef          	jal	80002d4e <bfree>
    ip->addrs[NDIRECT + 1] = 0;
    800034b0:	0809a023          	sw	zero,128(s3)
    800034b4:	7a02                	ld	s4,32(sp)
    800034b6:	6ae2                	ld	s5,24(sp)
    800034b8:	6b42                	ld	s6,16(sp)
    800034ba:	6ba2                	ld	s7,8(sp)
    800034bc:	6c02                	ld	s8,0(sp)
    800034be:	bf39                	j	800033dc <itrunc+0x3e>

00000000800034c0 <iput>:
{
    800034c0:	7179                	addi	sp,sp,-48
    800034c2:	f406                	sd	ra,40(sp)
    800034c4:	f022                	sd	s0,32(sp)
    800034c6:	ec26                	sd	s1,24(sp)
    800034c8:	1800                	addi	s0,sp,48
    800034ca:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    800034cc:	00055517          	auipc	a0,0x55
    800034d0:	ab450513          	addi	a0,a0,-1356 # 80057f80 <itable>
    800034d4:	f24fd0ef          	jal	80000bf8 <acquire>
  int last = (ip->ref == 1 && ip->valid && ip->nlink == 0);
    800034d8:	449c                	lw	a5,8(s1)
    800034da:	4705                	li	a4,1
    800034dc:	00e78f63          	beq	a5,a4,800034fa <iput+0x3a>
  ip->ref--;
    800034e0:	37fd                	addiw	a5,a5,-1
    800034e2:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    800034e4:	00055517          	auipc	a0,0x55
    800034e8:	a9c50513          	addi	a0,a0,-1380 # 80057f80 <itable>
    800034ec:	f90fd0ef          	jal	80000c7c <release>
}
    800034f0:	70a2                	ld	ra,40(sp)
    800034f2:	7402                	ld	s0,32(sp)
    800034f4:	64e2                	ld	s1,24(sp)
    800034f6:	6145                	addi	sp,sp,48
    800034f8:	8082                	ret
  int last = (ip->ref == 1 && ip->valid && ip->nlink == 0);
    800034fa:	40b8                	lw	a4,64(s1)
    800034fc:	d375                	beqz	a4,800034e0 <iput+0x20>
    800034fe:	e84a                	sd	s2,16(sp)
    80003500:	e052                	sd	s4,0(sp)
  uint dev = ip->dev, inum = ip->inum;
    80003502:	0004aa03          	lw	s4,0(s1)
    80003506:	0044a903          	lw	s2,4(s1)
  if (last) {
    8000350a:	04a49703          	lh	a4,74(s1)
    8000350e:	ef3d                	bnez	a4,8000358c <iput+0xcc>
    80003510:	e44e                	sd	s3,8(sp)
    acquiresleep(&ip->lock);
    80003512:	01048793          	addi	a5,s1,16
    80003516:	89be                	mv	s3,a5
    80003518:	853e                	mv	a0,a5
    8000351a:	561000ef          	jal	8000427a <acquiresleep>
    release(&itable.lock);
    8000351e:	00055517          	auipc	a0,0x55
    80003522:	a6250513          	addi	a0,a0,-1438 # 80057f80 <itable>
    80003526:	f56fd0ef          	jal	80000c7c <release>
    itrunc(ip); // free the data blocks (type stays nonzero on disk)
    8000352a:	8526                	mv	a0,s1
    8000352c:	e73ff0ef          	jal	8000339e <itrunc>
    ip->valid = 0;
    80003530:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80003534:	854e                	mv	a0,s3
    80003536:	599000ef          	jal	800042ce <releasesleep>
    acquire(&itable.lock);
    8000353a:	00055517          	auipc	a0,0x55
    8000353e:	a4650513          	addi	a0,a0,-1466 # 80057f80 <itable>
    80003542:	eb6fd0ef          	jal	80000bf8 <acquire>
  ip->ref--;
    80003546:	449c                	lw	a5,8(s1)
    80003548:	37fd                	addiw	a5,a5,-1
    8000354a:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    8000354c:	00055517          	auipc	a0,0x55
    80003550:	a3450513          	addi	a0,a0,-1484 # 80057f80 <itable>
    80003554:	f28fd0ef          	jal	80000c7c <release>
  struct buf *bp = bread(dev, IBLOCK(inum, sb));
    80003558:	0049579b          	srliw	a5,s2,0x4
    8000355c:	00055597          	auipc	a1,0x55
    80003560:	a145a583          	lw	a1,-1516(a1) # 80057f70 <sb+0x18>
    80003564:	9dbd                	addw	a1,a1,a5
    80003566:	8552                	mv	a0,s4
    80003568:	df2ff0ef          	jal	80002b5a <bread>
    8000356c:	84aa                	mv	s1,a0
  struct dinode *dip = (struct dinode *)bp->data + inum % IPB;
    8000356e:	00f97793          	andi	a5,s2,15
  dip->type = 0;
    80003572:	079a                	slli	a5,a5,0x6
    80003574:	97aa                	add	a5,a5,a0
    80003576:	04079c23          	sh	zero,88(a5)
  log_write(bp);
    8000357a:	395000ef          	jal	8000410e <log_write>
  brelse(bp);
    8000357e:	8526                	mv	a0,s1
    80003580:	ee2ff0ef          	jal	80002c62 <brelse>
}
    80003584:	6942                	ld	s2,16(sp)
    80003586:	69a2                	ld	s3,8(sp)
    80003588:	6a02                	ld	s4,0(sp)
    8000358a:	b79d                	j	800034f0 <iput+0x30>
    8000358c:	6942                	ld	s2,16(sp)
    8000358e:	6a02                	ld	s4,0(sp)
    80003590:	bf81                	j	800034e0 <iput+0x20>

0000000080003592 <iunlockput>:
{
    80003592:	1101                	addi	sp,sp,-32
    80003594:	ec06                	sd	ra,24(sp)
    80003596:	e822                	sd	s0,16(sp)
    80003598:	e426                	sd	s1,8(sp)
    8000359a:	1000                	addi	s0,sp,32
    8000359c:	84aa                	mv	s1,a0
  iunlock(ip);
    8000359e:	dc1ff0ef          	jal	8000335e <iunlock>
  iput(ip);
    800035a2:	8526                	mv	a0,s1
    800035a4:	f1dff0ef          	jal	800034c0 <iput>
}
    800035a8:	60e2                	ld	ra,24(sp)
    800035aa:	6442                	ld	s0,16(sp)
    800035ac:	64a2                	ld	s1,8(sp)
    800035ae:	6105                	addi	sp,sp,32
    800035b0:	8082                	ret

00000000800035b2 <ireclaim>:
  for (int inum = 1; inum < sb.ninodes; inum++) {
    800035b2:	00055717          	auipc	a4,0x55
    800035b6:	9b272703          	lw	a4,-1614(a4) # 80057f64 <sb+0xc>
    800035ba:	4785                	li	a5,1
    800035bc:	0ae7fe63          	bgeu	a5,a4,80003678 <ireclaim+0xc6>
{
    800035c0:	7139                	addi	sp,sp,-64
    800035c2:	fc06                	sd	ra,56(sp)
    800035c4:	f822                	sd	s0,48(sp)
    800035c6:	f426                	sd	s1,40(sp)
    800035c8:	f04a                	sd	s2,32(sp)
    800035ca:	ec4e                	sd	s3,24(sp)
    800035cc:	e852                	sd	s4,16(sp)
    800035ce:	e456                	sd	s5,8(sp)
    800035d0:	e05a                	sd	s6,0(sp)
    800035d2:	0080                	addi	s0,sp,64
    800035d4:	8aaa                	mv	s5,a0
  for (int inum = 1; inum < sb.ninodes; inum++) {
    800035d6:	84be                	mv	s1,a5
    struct buf *bp = bread(dev, IBLOCK(inum, sb));
    800035d8:	00055a17          	auipc	s4,0x55
    800035dc:	980a0a13          	addi	s4,s4,-1664 # 80057f58 <sb>
      printk("ireclaim: orphaned inode %d\n", inum);
    800035e0:	00005b17          	auipc	s6,0x5
    800035e4:	ea0b0b13          	addi	s6,s6,-352 # 80008480 <etext+0x480>
    800035e8:	a099                	j	8000362e <ireclaim+0x7c>
    800035ea:	85ce                	mv	a1,s3
    800035ec:	855a                	mv	a0,s6
    800035ee:	f23fc0ef          	jal	80000510 <printk>
      ip = iget(dev, inum);
    800035f2:	85ce                	mv	a1,s3
    800035f4:	8556                	mv	a0,s5
    800035f6:	a41ff0ef          	jal	80003036 <iget>
    800035fa:	89aa                	mv	s3,a0
    brelse(bp);
    800035fc:	854a                	mv	a0,s2
    800035fe:	e64ff0ef          	jal	80002c62 <brelse>
    if (ip) {
    80003602:	00098f63          	beqz	s3,80003620 <ireclaim+0x6e>
      begin_op();
    80003606:	159000ef          	jal	80003f5e <begin_op>
      ilock(ip);
    8000360a:	854e                	mv	a0,s3
    8000360c:	ca5ff0ef          	jal	800032b0 <ilock>
      iunlock(ip);
    80003610:	854e                	mv	a0,s3
    80003612:	d4dff0ef          	jal	8000335e <iunlock>
      iput(ip);
    80003616:	854e                	mv	a0,s3
    80003618:	ea9ff0ef          	jal	800034c0 <iput>
      end_op();
    8000361c:	1d1000ef          	jal	80003fec <end_op>
  for (int inum = 1; inum < sb.ninodes; inum++) {
    80003620:	0485                	addi	s1,s1,1
    80003622:	00ca2703          	lw	a4,12(s4)
    80003626:	0004879b          	sext.w	a5,s1
    8000362a:	02e7fd63          	bgeu	a5,a4,80003664 <ireclaim+0xb2>
    8000362e:	0004899b          	sext.w	s3,s1
    struct buf *bp = bread(dev, IBLOCK(inum, sb));
    80003632:	0044d593          	srli	a1,s1,0x4
    80003636:	018a2783          	lw	a5,24(s4)
    8000363a:	9dbd                	addw	a1,a1,a5
    8000363c:	8556                	mv	a0,s5
    8000363e:	d1cff0ef          	jal	80002b5a <bread>
    80003642:	892a                	mv	s2,a0
    struct dinode *dip = (struct dinode *)bp->data + inum % IPB;
    80003644:	05850793          	addi	a5,a0,88
    80003648:	00f9f713          	andi	a4,s3,15
    8000364c:	071a                	slli	a4,a4,0x6
    8000364e:	97ba                	add	a5,a5,a4
    if (dip->type != 0 && dip->nlink == 0) { // is an orphaned inode
    80003650:	00079703          	lh	a4,0(a5)
    80003654:	c701                	beqz	a4,8000365c <ireclaim+0xaa>
    80003656:	00679783          	lh	a5,6(a5)
    8000365a:	dbc1                	beqz	a5,800035ea <ireclaim+0x38>
    brelse(bp);
    8000365c:	854a                	mv	a0,s2
    8000365e:	e04ff0ef          	jal	80002c62 <brelse>
    if (ip) {
    80003662:	bf7d                	j	80003620 <ireclaim+0x6e>
}
    80003664:	70e2                	ld	ra,56(sp)
    80003666:	7442                	ld	s0,48(sp)
    80003668:	74a2                	ld	s1,40(sp)
    8000366a:	7902                	ld	s2,32(sp)
    8000366c:	69e2                	ld	s3,24(sp)
    8000366e:	6a42                	ld	s4,16(sp)
    80003670:	6aa2                	ld	s5,8(sp)
    80003672:	6b02                	ld	s6,0(sp)
    80003674:	6121                	addi	sp,sp,64
    80003676:	8082                	ret
    80003678:	8082                	ret

000000008000367a <fsinit>:
{
    8000367a:	1101                	addi	sp,sp,-32
    8000367c:	ec06                	sd	ra,24(sp)
    8000367e:	e822                	sd	s0,16(sp)
    80003680:	e426                	sd	s1,8(sp)
    80003682:	e04a                	sd	s2,0(sp)
    80003684:	1000                	addi	s0,sp,32
    80003686:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80003688:	4585                	li	a1,1
    8000368a:	cd0ff0ef          	jal	80002b5a <bread>
    8000368e:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80003690:	02400613          	li	a2,36
    80003694:	05850593          	addi	a1,a0,88
    80003698:	00055517          	auipc	a0,0x55
    8000369c:	8c050513          	addi	a0,a0,-1856 # 80057f58 <sb>
    800036a0:	e70fd0ef          	jal	80000d10 <memmove>
  brelse(bp);
    800036a4:	8526                	mv	a0,s1
    800036a6:	dbcff0ef          	jal	80002c62 <brelse>
  if (sb.magic != FSMAGIC)
    800036aa:	00055717          	auipc	a4,0x55
    800036ae:	8ae72703          	lw	a4,-1874(a4) # 80057f58 <sb>
    800036b2:	102037b7          	lui	a5,0x10203
    800036b6:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    800036ba:	02f71263          	bne	a4,a5,800036de <fsinit+0x64>
  initlog(dev, &sb);
    800036be:	00055597          	auipc	a1,0x55
    800036c2:	89a58593          	addi	a1,a1,-1894 # 80057f58 <sb>
    800036c6:	854a                	mv	a0,s2
    800036c8:	015000ef          	jal	80003edc <initlog>
  ireclaim(dev);
    800036cc:	854a                	mv	a0,s2
    800036ce:	ee5ff0ef          	jal	800035b2 <ireclaim>
}
    800036d2:	60e2                	ld	ra,24(sp)
    800036d4:	6442                	ld	s0,16(sp)
    800036d6:	64a2                	ld	s1,8(sp)
    800036d8:	6902                	ld	s2,0(sp)
    800036da:	6105                	addi	sp,sp,32
    800036dc:	8082                	ret
    panic("invalid file system");
    800036de:	00005517          	auipc	a0,0x5
    800036e2:	dc250513          	addi	a0,a0,-574 # 800084a0 <etext+0x4a0>
    800036e6:	962fd0ef          	jal	80000848 <panic>

00000000800036ea <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    800036ea:	1141                	addi	sp,sp,-16
    800036ec:	e406                	sd	ra,8(sp)
    800036ee:	e022                	sd	s0,0(sp)
    800036f0:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    800036f2:	411c                	lw	a5,0(a0)
    800036f4:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    800036f6:	415c                	lw	a5,4(a0)
    800036f8:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    800036fa:	04451783          	lh	a5,68(a0)
    800036fe:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80003702:	04a51783          	lh	a5,74(a0)
    80003706:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    8000370a:	04c56783          	lwu	a5,76(a0)
    8000370e:	e99c                	sd	a5,16(a1)
}
    80003710:	60a2                	ld	ra,8(sp)
    80003712:	6402                	ld	s0,0(sp)
    80003714:	0141                	addi	sp,sp,16
    80003716:	8082                	ret

0000000080003718 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if (off > ip->size || off + n < off)
    80003718:	457c                	lw	a5,76(a0)
    8000371a:	0ed7e663          	bltu	a5,a3,80003806 <readi+0xee>
{
    8000371e:	7159                	addi	sp,sp,-112
    80003720:	f486                	sd	ra,104(sp)
    80003722:	f0a2                	sd	s0,96(sp)
    80003724:	eca6                	sd	s1,88(sp)
    80003726:	e0d2                	sd	s4,64(sp)
    80003728:	fc56                	sd	s5,56(sp)
    8000372a:	f85a                	sd	s6,48(sp)
    8000372c:	f45e                	sd	s7,40(sp)
    8000372e:	1880                	addi	s0,sp,112
    80003730:	8b2a                	mv	s6,a0
    80003732:	8bae                	mv	s7,a1
    80003734:	8a32                	mv	s4,a2
    80003736:	84b6                	mv	s1,a3
    80003738:	8aba                	mv	s5,a4
  if (off > ip->size || off + n < off)
    8000373a:	9f35                	addw	a4,a4,a3
    return 0;
    8000373c:	4501                	li	a0,0
  if (off > ip->size || off + n < off)
    8000373e:	0ad76b63          	bltu	a4,a3,800037f4 <readi+0xdc>
    80003742:	e4ce                	sd	s3,72(sp)
  if (off + n > ip->size)
    80003744:	00e7f463          	bgeu	a5,a4,8000374c <readi+0x34>
    n = ip->size - off;
    80003748:	40d78abb          	subw	s5,a5,a3

  for (tot = 0; tot < n; tot += m, off += m, dst += m) {
    8000374c:	080a8b63          	beqz	s5,800037e2 <readi+0xca>
    80003750:	e8ca                	sd	s2,80(sp)
    80003752:	f062                	sd	s8,32(sp)
    80003754:	ec66                	sd	s9,24(sp)
    80003756:	e86a                	sd	s10,16(sp)
    80003758:	e46e                	sd	s11,8(sp)
    8000375a:	4981                	li	s3,0
    uint addr = bmap(ip, off / BSIZE);
    if (addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off % BSIZE);
    8000375c:	40000c93          	li	s9,1024
    if (either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80003760:	5c7d                	li	s8,-1
    80003762:	a80d                	j	80003794 <readi+0x7c>
    80003764:	020d1d93          	slli	s11,s10,0x20
    80003768:	020ddd93          	srli	s11,s11,0x20
    8000376c:	05890613          	addi	a2,s2,88
    80003770:	86ee                	mv	a3,s11
    80003772:	963e                	add	a2,a2,a5
    80003774:	85d2                	mv	a1,s4
    80003776:	855e                	mv	a0,s7
    80003778:	afffe0ef          	jal	80002276 <either_copyout>
    8000377c:	05850363          	beq	a0,s8,800037c2 <readi+0xaa>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80003780:	854a                	mv	a0,s2
    80003782:	ce0ff0ef          	jal	80002c62 <brelse>
  for (tot = 0; tot < n; tot += m, off += m, dst += m) {
    80003786:	013d09bb          	addw	s3,s10,s3
    8000378a:	009d04bb          	addw	s1,s10,s1
    8000378e:	9a6e                	add	s4,s4,s11
    80003790:	0559f363          	bgeu	s3,s5,800037d6 <readi+0xbe>
    uint addr = bmap(ip, off / BSIZE);
    80003794:	00a4d59b          	srliw	a1,s1,0xa
    80003798:	855a                	mv	a0,s6
    8000379a:	f26ff0ef          	jal	80002ec0 <bmap>
    8000379e:	85aa                	mv	a1,a0
    if (addr == 0)
    800037a0:	c139                	beqz	a0,800037e6 <readi+0xce>
    bp = bread(ip->dev, addr);
    800037a2:	000b2503          	lw	a0,0(s6)
    800037a6:	bb4ff0ef          	jal	80002b5a <bread>
    800037aa:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off % BSIZE);
    800037ac:	3ff4f793          	andi	a5,s1,1023
    800037b0:	40fc873b          	subw	a4,s9,a5
    800037b4:	413a86bb          	subw	a3,s5,s3
    800037b8:	8d3a                	mv	s10,a4
    800037ba:	fae6f5e3          	bgeu	a3,a4,80003764 <readi+0x4c>
    800037be:	8d36                	mv	s10,a3
    800037c0:	b755                	j	80003764 <readi+0x4c>
      brelse(bp);
    800037c2:	854a                	mv	a0,s2
    800037c4:	c9eff0ef          	jal	80002c62 <brelse>
      tot = -1;
    800037c8:	59fd                	li	s3,-1
      break;
    800037ca:	6946                	ld	s2,80(sp)
    800037cc:	7c02                	ld	s8,32(sp)
    800037ce:	6ce2                	ld	s9,24(sp)
    800037d0:	6d42                	ld	s10,16(sp)
    800037d2:	6da2                	ld	s11,8(sp)
    800037d4:	a831                	j	800037f0 <readi+0xd8>
    800037d6:	6946                	ld	s2,80(sp)
    800037d8:	7c02                	ld	s8,32(sp)
    800037da:	6ce2                	ld	s9,24(sp)
    800037dc:	6d42                	ld	s10,16(sp)
    800037de:	6da2                	ld	s11,8(sp)
    800037e0:	a801                	j	800037f0 <readi+0xd8>
  for (tot = 0; tot < n; tot += m, off += m, dst += m) {
    800037e2:	89d6                	mv	s3,s5
    800037e4:	a031                	j	800037f0 <readi+0xd8>
    800037e6:	6946                	ld	s2,80(sp)
    800037e8:	7c02                	ld	s8,32(sp)
    800037ea:	6ce2                	ld	s9,24(sp)
    800037ec:	6d42                	ld	s10,16(sp)
    800037ee:	6da2                	ld	s11,8(sp)
  }
  return tot;
    800037f0:	854e                	mv	a0,s3
    800037f2:	69a6                	ld	s3,72(sp)
}
    800037f4:	70a6                	ld	ra,104(sp)
    800037f6:	7406                	ld	s0,96(sp)
    800037f8:	64e6                	ld	s1,88(sp)
    800037fa:	6a06                	ld	s4,64(sp)
    800037fc:	7ae2                	ld	s5,56(sp)
    800037fe:	7b42                	ld	s6,48(sp)
    80003800:	7ba2                	ld	s7,40(sp)
    80003802:	6165                	addi	sp,sp,112
    80003804:	8082                	ret
    return 0;
    80003806:	4501                	li	a0,0
}
    80003808:	8082                	ret

000000008000380a <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if (off > ip->size || off + n < off)
    8000380a:	457c                	lw	a5,76(a0)
    8000380c:	10d7e363          	bltu	a5,a3,80003912 <writei+0x108>
{
    80003810:	7159                	addi	sp,sp,-112
    80003812:	f486                	sd	ra,104(sp)
    80003814:	f0a2                	sd	s0,96(sp)
    80003816:	e8ca                	sd	s2,80(sp)
    80003818:	e0d2                	sd	s4,64(sp)
    8000381a:	fc56                	sd	s5,56(sp)
    8000381c:	f85a                	sd	s6,48(sp)
    8000381e:	f45e                	sd	s7,40(sp)
    80003820:	1880                	addi	s0,sp,112
    80003822:	8aaa                	mv	s5,a0
    80003824:	8bae                	mv	s7,a1
    80003826:	8a32                	mv	s4,a2
    80003828:	8936                	mv	s2,a3
    8000382a:	8b3a                	mv	s6,a4
  if (off > ip->size || off + n < off)
    8000382c:	9f35                	addw	a4,a4,a3
    return -1;
  if (off + n > MAXFILE * BSIZE)
    8000382e:	040437b7          	lui	a5,0x4043
    80003832:	c0078793          	addi	a5,a5,-1024 # 4042c00 <_entry-0x7bfbd400>
    80003836:	00e7b7b3          	sltu	a5,a5,a4
  if (off > ip->size || off + n < off)
    8000383a:	00d73733          	sltu	a4,a4,a3
  if (off + n > MAXFILE * BSIZE)
    8000383e:	8fd9                	or	a5,a5,a4
    80003840:	ef91                	bnez	a5,8000385c <writei+0x52>
    80003842:	e4ce                	sd	s3,72(sp)
    return -1;

  for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80003844:	0a0b0f63          	beqz	s6,80003902 <writei+0xf8>
    80003848:	eca6                	sd	s1,88(sp)
    8000384a:	f062                	sd	s8,32(sp)
    8000384c:	ec66                	sd	s9,24(sp)
    8000384e:	e86a                	sd	s10,16(sp)
    80003850:	e46e                	sd	s11,8(sp)
    80003852:	4981                	li	s3,0
    uint addr = bmap(ip, off / BSIZE);
    if (addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off % BSIZE);
    80003854:	40000c93          	li	s9,1024
    if (either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003858:	5c7d                	li	s8,-1
    8000385a:	a835                	j	80003896 <writei+0x8c>
    return -1;
    8000385c:	557d                	li	a0,-1
    8000385e:	a849                	j	800038f0 <writei+0xe6>
    if (either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003860:	020d1d93          	slli	s11,s10,0x20
    80003864:	020ddd93          	srli	s11,s11,0x20
    80003868:	05848513          	addi	a0,s1,88
    8000386c:	86ee                	mv	a3,s11
    8000386e:	8652                	mv	a2,s4
    80003870:	85de                	mv	a1,s7
    80003872:	953e                	add	a0,a0,a5
    80003874:	a4ffe0ef          	jal	800022c2 <either_copyin>
    80003878:	05850663          	beq	a0,s8,800038c4 <writei+0xba>
      // Might have partially updated the block, so we need to log it.
      log_write(bp);
      brelse(bp);
      break;
    }
    log_write(bp);
    8000387c:	8526                	mv	a0,s1
    8000387e:	091000ef          	jal	8000410e <log_write>
    brelse(bp);
    80003882:	8526                	mv	a0,s1
    80003884:	bdeff0ef          	jal	80002c62 <brelse>
  for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80003888:	013d09bb          	addw	s3,s10,s3
    8000388c:	012d093b          	addw	s2,s10,s2
    80003890:	9a6e                	add	s4,s4,s11
    80003892:	0369ff63          	bgeu	s3,s6,800038d0 <writei+0xc6>
    uint addr = bmap(ip, off / BSIZE);
    80003896:	00a9559b          	srliw	a1,s2,0xa
    8000389a:	8556                	mv	a0,s5
    8000389c:	e24ff0ef          	jal	80002ec0 <bmap>
    800038a0:	85aa                	mv	a1,a0
    if (addr == 0)
    800038a2:	c51d                	beqz	a0,800038d0 <writei+0xc6>
    bp = bread(ip->dev, addr);
    800038a4:	000aa503          	lw	a0,0(s5)
    800038a8:	ab2ff0ef          	jal	80002b5a <bread>
    800038ac:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off % BSIZE);
    800038ae:	3ff97793          	andi	a5,s2,1023
    800038b2:	40fc873b          	subw	a4,s9,a5
    800038b6:	413b06bb          	subw	a3,s6,s3
    800038ba:	8d3a                	mv	s10,a4
    800038bc:	fae6f2e3          	bgeu	a3,a4,80003860 <writei+0x56>
    800038c0:	8d36                	mv	s10,a3
    800038c2:	bf79                	j	80003860 <writei+0x56>
      log_write(bp);
    800038c4:	8526                	mv	a0,s1
    800038c6:	049000ef          	jal	8000410e <log_write>
      brelse(bp);
    800038ca:	8526                	mv	a0,s1
    800038cc:	b96ff0ef          	jal	80002c62 <brelse>
  }

  if (off > ip->size)
    800038d0:	04caa783          	lw	a5,76(s5)
    800038d4:	0327f963          	bgeu	a5,s2,80003906 <writei+0xfc>
    ip->size = off;
    800038d8:	052aa623          	sw	s2,76(s5)
    800038dc:	64e6                	ld	s1,88(sp)
    800038de:	7c02                	ld	s8,32(sp)
    800038e0:	6ce2                	ld	s9,24(sp)
    800038e2:	6d42                	ld	s10,16(sp)
    800038e4:	6da2                	ld	s11,8(sp)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    800038e6:	8556                	mv	a0,s5
    800038e8:	915ff0ef          	jal	800031fc <iupdate>

  return tot;
    800038ec:	854e                	mv	a0,s3
    800038ee:	69a6                	ld	s3,72(sp)
}
    800038f0:	70a6                	ld	ra,104(sp)
    800038f2:	7406                	ld	s0,96(sp)
    800038f4:	6946                	ld	s2,80(sp)
    800038f6:	6a06                	ld	s4,64(sp)
    800038f8:	7ae2                	ld	s5,56(sp)
    800038fa:	7b42                	ld	s6,48(sp)
    800038fc:	7ba2                	ld	s7,40(sp)
    800038fe:	6165                	addi	sp,sp,112
    80003900:	8082                	ret
  for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80003902:	89da                	mv	s3,s6
    80003904:	b7cd                	j	800038e6 <writei+0xdc>
    80003906:	64e6                	ld	s1,88(sp)
    80003908:	7c02                	ld	s8,32(sp)
    8000390a:	6ce2                	ld	s9,24(sp)
    8000390c:	6d42                	ld	s10,16(sp)
    8000390e:	6da2                	ld	s11,8(sp)
    80003910:	bfd9                	j	800038e6 <writei+0xdc>
    return -1;
    80003912:	557d                	li	a0,-1
}
    80003914:	8082                	ret

0000000080003916 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003916:	1141                	addi	sp,sp,-16
    80003918:	e406                	sd	ra,8(sp)
    8000391a:	e022                	sd	s0,0(sp)
    8000391c:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    8000391e:	4639                	li	a2,14
    80003920:	c64fd0ef          	jal	80000d84 <strncmp>
}
    80003924:	60a2                	ld	ra,8(sp)
    80003926:	6402                	ld	s0,0(sp)
    80003928:	0141                	addi	sp,sp,16
    8000392a:	8082                	ret

000000008000392c <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode *
dirlookup(struct inode *dp, char *name, uint *poff)
{
    8000392c:	711d                	addi	sp,sp,-96
    8000392e:	ec86                	sd	ra,88(sp)
    80003930:	e8a2                	sd	s0,80(sp)
    80003932:	e4a6                	sd	s1,72(sp)
    80003934:	e0ca                	sd	s2,64(sp)
    80003936:	fc4e                	sd	s3,56(sp)
    80003938:	f852                	sd	s4,48(sp)
    8000393a:	f456                	sd	s5,40(sp)
    8000393c:	f05a                	sd	s6,32(sp)
    8000393e:	ec5e                	sd	s7,24(sp)
    80003940:	1080                	addi	s0,sp,96
  uint off, inum;
  struct dirent de;

  if (dp->type != T_DIR)
    80003942:	04451703          	lh	a4,68(a0)
    80003946:	4785                	li	a5,1
    80003948:	02f71963          	bne	a4,a5,8000397a <dirlookup+0x4e>
    8000394c:	892a                	mv	s2,a0
    8000394e:	8aae                	mv	s5,a1
    80003950:	8bb2                	mv	s7,a2
    panic("dirlookup not DIR");

  for (off = 0; off < dp->size; off += sizeof(de)) {
    80003952:	457c                	lw	a5,76(a0)
    80003954:	4481                	li	s1,0
    if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003956:	fa040a13          	addi	s4,s0,-96
    8000395a:	49c1                	li	s3,16
      panic("dirlookup read");
    if (de.inum == 0)
      continue;
    if (namecmp(name, de.name) == 0) {
    8000395c:	fa240b13          	addi	s6,s0,-94
  for (off = 0; off < dp->size; off += sizeof(de)) {
    80003960:	ef95                	bnez	a5,8000399c <dirlookup+0x70>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80003962:	4501                	li	a0,0
}
    80003964:	60e6                	ld	ra,88(sp)
    80003966:	6446                	ld	s0,80(sp)
    80003968:	64a6                	ld	s1,72(sp)
    8000396a:	6906                	ld	s2,64(sp)
    8000396c:	79e2                	ld	s3,56(sp)
    8000396e:	7a42                	ld	s4,48(sp)
    80003970:	7aa2                	ld	s5,40(sp)
    80003972:	7b02                	ld	s6,32(sp)
    80003974:	6be2                	ld	s7,24(sp)
    80003976:	6125                	addi	sp,sp,96
    80003978:	8082                	ret
    panic("dirlookup not DIR");
    8000397a:	00005517          	auipc	a0,0x5
    8000397e:	b3e50513          	addi	a0,a0,-1218 # 800084b8 <etext+0x4b8>
    80003982:	ec7fc0ef          	jal	80000848 <panic>
      panic("dirlookup read");
    80003986:	00005517          	auipc	a0,0x5
    8000398a:	b4a50513          	addi	a0,a0,-1206 # 800084d0 <etext+0x4d0>
    8000398e:	ebbfc0ef          	jal	80000848 <panic>
  for (off = 0; off < dp->size; off += sizeof(de)) {
    80003992:	24c1                	addiw	s1,s1,16
    80003994:	04c92783          	lw	a5,76(s2)
    80003998:	fcf4f5e3          	bgeu	s1,a5,80003962 <dirlookup+0x36>
    if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000399c:	874e                	mv	a4,s3
    8000399e:	86a6                	mv	a3,s1
    800039a0:	8652                	mv	a2,s4
    800039a2:	4581                	li	a1,0
    800039a4:	854a                	mv	a0,s2
    800039a6:	d73ff0ef          	jal	80003718 <readi>
    800039aa:	fd351ee3          	bne	a0,s3,80003986 <dirlookup+0x5a>
    if (de.inum == 0)
    800039ae:	fa045783          	lhu	a5,-96(s0)
    800039b2:	d3e5                	beqz	a5,80003992 <dirlookup+0x66>
    if (namecmp(name, de.name) == 0) {
    800039b4:	85da                	mv	a1,s6
    800039b6:	8556                	mv	a0,s5
    800039b8:	f5fff0ef          	jal	80003916 <namecmp>
    800039bc:	f979                	bnez	a0,80003992 <dirlookup+0x66>
      if (poff)
    800039be:	000b8463          	beqz	s7,800039c6 <dirlookup+0x9a>
        *poff = off;
    800039c2:	009ba023          	sw	s1,0(s7)
      return iget(dp->dev, inum);
    800039c6:	fa045583          	lhu	a1,-96(s0)
    800039ca:	00092503          	lw	a0,0(s2)
    800039ce:	e68ff0ef          	jal	80003036 <iget>
    800039d2:	bf49                	j	80003964 <dirlookup+0x38>

00000000800039d4 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode *
namex(char *path, int nameiparent, char *name)
{
    800039d4:	711d                	addi	sp,sp,-96
    800039d6:	ec86                	sd	ra,88(sp)
    800039d8:	e8a2                	sd	s0,80(sp)
    800039da:	e4a6                	sd	s1,72(sp)
    800039dc:	e0ca                	sd	s2,64(sp)
    800039de:	fc4e                	sd	s3,56(sp)
    800039e0:	f852                	sd	s4,48(sp)
    800039e2:	f456                	sd	s5,40(sp)
    800039e4:	f05a                	sd	s6,32(sp)
    800039e6:	ec5e                	sd	s7,24(sp)
    800039e8:	e862                	sd	s8,16(sp)
    800039ea:	e466                	sd	s9,8(sp)
    800039ec:	e06a                	sd	s10,0(sp)
    800039ee:	1080                	addi	s0,sp,96
    800039f0:	84aa                	mv	s1,a0
    800039f2:	8b2e                	mv	s6,a1
    800039f4:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if (*path == '/')
    800039f6:	00054703          	lbu	a4,0(a0)
    800039fa:	02f00793          	li	a5,47
    800039fe:	00f70f63          	beq	a4,a5,80003a1c <namex+0x48>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003a02:	ee1fd0ef          	jal	800018e2 <myproc>
    80003a06:	15053503          	ld	a0,336(a0)
    80003a0a:	871ff0ef          	jal	8000327a <idup>
    80003a0e:	8a2a                	mv	s4,a0
  while (*path == '/')
    80003a10:	02f00993          	li	s3,47
  if (len >= DIRSIZ)
    80003a14:	4c35                	li	s8,13
    memmove(name, s, DIRSIZ);
    80003a16:	4cb9                	li	s9,14

  while ((path = skipelem(path, name)) != 0) {
    ilock(ip);
    if (ip->type != T_DIR) {
    80003a18:	4b85                	li	s7,1
    80003a1a:	a075                	j	80003ac6 <namex+0xf2>
    ip = iget(ROOTDEV, ROOTINO);
    80003a1c:	4585                	li	a1,1
    80003a1e:	852e                	mv	a0,a1
    80003a20:	e16ff0ef          	jal	80003036 <iget>
    80003a24:	8a2a                	mv	s4,a0
    80003a26:	b7ed                	j	80003a10 <namex+0x3c>
      iunlockput(ip);
    80003a28:	8552                	mv	a0,s4
    80003a2a:	b69ff0ef          	jal	80003592 <iunlockput>
      return 0;
    80003a2e:	4a01                	li	s4,0
  if (nameiparent) {
    iput(ip);
    return 0;
  }
  return ip;
}
    80003a30:	8552                	mv	a0,s4
    80003a32:	60e6                	ld	ra,88(sp)
    80003a34:	6446                	ld	s0,80(sp)
    80003a36:	64a6                	ld	s1,72(sp)
    80003a38:	6906                	ld	s2,64(sp)
    80003a3a:	79e2                	ld	s3,56(sp)
    80003a3c:	7a42                	ld	s4,48(sp)
    80003a3e:	7aa2                	ld	s5,40(sp)
    80003a40:	7b02                	ld	s6,32(sp)
    80003a42:	6be2                	ld	s7,24(sp)
    80003a44:	6c42                	ld	s8,16(sp)
    80003a46:	6ca2                	ld	s9,8(sp)
    80003a48:	6d02                	ld	s10,0(sp)
    80003a4a:	6125                	addi	sp,sp,96
    80003a4c:	8082                	ret
      iunlockput(ip);
    80003a4e:	8552                	mv	a0,s4
    80003a50:	b43ff0ef          	jal	80003592 <iunlockput>
      return 0;
    80003a54:	bfe9                	j	80003a2e <namex+0x5a>
      iunlock(ip);
    80003a56:	8552                	mv	a0,s4
    80003a58:	907ff0ef          	jal	8000335e <iunlock>
      return ip;
    80003a5c:	bfd1                	j	80003a30 <namex+0x5c>
      iunlockput(ip);
    80003a5e:	8552                	mv	a0,s4
    80003a60:	b33ff0ef          	jal	80003592 <iunlockput>
      return 0;
    80003a64:	8a4a                	mv	s4,s2
    80003a66:	b7e9                	j	80003a30 <namex+0x5c>
  while (*path != '/' && *path != 0)
    80003a68:	8926                	mv	s2,s1
  len = path - s;
    80003a6a:	4d01                	li	s10,0
    80003a6c:	4601                	li	a2,0
    memmove(name, s, len);
    80003a6e:	2601                	sext.w	a2,a2
    80003a70:	85a6                	mv	a1,s1
    80003a72:	8556                	mv	a0,s5
    80003a74:	a9cfd0ef          	jal	80000d10 <memmove>
    name[len] = 0;
    80003a78:	9d56                	add	s10,s10,s5
    80003a7a:	000d0023          	sb	zero,0(s10) # fffffffffffff000 <end+0xffffffff7ffa4050>
    80003a7e:	84ca                	mv	s1,s2
  while (*path == '/')
    80003a80:	0004c783          	lbu	a5,0(s1)
    80003a84:	01379763          	bne	a5,s3,80003a92 <namex+0xbe>
    path++;
    80003a88:	0485                	addi	s1,s1,1
  while (*path == '/')
    80003a8a:	0004c783          	lbu	a5,0(s1)
    80003a8e:	ff378de3          	beq	a5,s3,80003a88 <namex+0xb4>
    ilock(ip);
    80003a92:	8552                	mv	a0,s4
    80003a94:	81dff0ef          	jal	800032b0 <ilock>
    if (ip->type != T_DIR) {
    80003a98:	044a1783          	lh	a5,68(s4)
    80003a9c:	f97796e3          	bne	a5,s7,80003a28 <namex+0x54>
    if (ip->nlink == 0) {
    80003aa0:	04aa1783          	lh	a5,74(s4)
    80003aa4:	d7cd                	beqz	a5,80003a4e <namex+0x7a>
    if (nameiparent && *path == '\0') {
    80003aa6:	000b0563          	beqz	s6,80003ab0 <namex+0xdc>
    80003aaa:	0004c783          	lbu	a5,0(s1)
    80003aae:	d7c5                	beqz	a5,80003a56 <namex+0x82>
    if ((next = dirlookup(ip, name, 0)) == 0) {
    80003ab0:	4601                	li	a2,0
    80003ab2:	85d6                	mv	a1,s5
    80003ab4:	8552                	mv	a0,s4
    80003ab6:	e77ff0ef          	jal	8000392c <dirlookup>
    80003aba:	892a                	mv	s2,a0
    80003abc:	d14d                	beqz	a0,80003a5e <namex+0x8a>
    iunlockput(ip);
    80003abe:	8552                	mv	a0,s4
    80003ac0:	ad3ff0ef          	jal	80003592 <iunlockput>
    ip = next;
    80003ac4:	8a4a                	mv	s4,s2
  while (*path == '/')
    80003ac6:	0004c783          	lbu	a5,0(s1)
    80003aca:	01379763          	bne	a5,s3,80003ad8 <namex+0x104>
    path++;
    80003ace:	0485                	addi	s1,s1,1
  while (*path == '/')
    80003ad0:	0004c783          	lbu	a5,0(s1)
    80003ad4:	ff378de3          	beq	a5,s3,80003ace <namex+0xfa>
  if (*path == 0)
    80003ad8:	c7a1                	beqz	a5,80003b20 <namex+0x14c>
  while (*path != '/' && *path != 0)
    80003ada:	0004c703          	lbu	a4,0(s1)
    80003ade:	fd170793          	addi	a5,a4,-47
    80003ae2:	00f037b3          	snez	a5,a5
    80003ae6:	00e03733          	snez	a4,a4
    80003aea:	8ff9                	and	a5,a5,a4
    80003aec:	dfb5                	beqz	a5,80003a68 <namex+0x94>
    80003aee:	8926                	mv	s2,s1
    path++;
    80003af0:	0905                	addi	s2,s2,1
  while (*path != '/' && *path != 0)
    80003af2:	00094703          	lbu	a4,0(s2)
    80003af6:	fd170793          	addi	a5,a4,-47
    80003afa:	00f037b3          	snez	a5,a5
    80003afe:	00e03733          	snez	a4,a4
    80003b02:	8ff9                	and	a5,a5,a4
    80003b04:	f7f5                	bnez	a5,80003af0 <namex+0x11c>
  len = path - s;
    80003b06:	40990633          	sub	a2,s2,s1
    80003b0a:	00060d1b          	sext.w	s10,a2
  if (len >= DIRSIZ)
    80003b0e:	f7ac50e3          	bge	s8,s10,80003a6e <namex+0x9a>
    memmove(name, s, DIRSIZ);
    80003b12:	8666                	mv	a2,s9
    80003b14:	85a6                	mv	a1,s1
    80003b16:	8556                	mv	a0,s5
    80003b18:	9f8fd0ef          	jal	80000d10 <memmove>
    80003b1c:	84ca                	mv	s1,s2
    80003b1e:	b78d                	j	80003a80 <namex+0xac>
  if (nameiparent) {
    80003b20:	f00b08e3          	beqz	s6,80003a30 <namex+0x5c>
    iput(ip);
    80003b24:	8552                	mv	a0,s4
    80003b26:	99bff0ef          	jal	800034c0 <iput>
    return 0;
    80003b2a:	b711                	j	80003a2e <namex+0x5a>

0000000080003b2c <dirlink>:
{
    80003b2c:	715d                	addi	sp,sp,-80
    80003b2e:	e486                	sd	ra,72(sp)
    80003b30:	e0a2                	sd	s0,64(sp)
    80003b32:	f84a                	sd	s2,48(sp)
    80003b34:	ec56                	sd	s5,24(sp)
    80003b36:	e85a                	sd	s6,16(sp)
    80003b38:	0880                	addi	s0,sp,80
    80003b3a:	892a                	mv	s2,a0
    80003b3c:	8aae                	mv	s5,a1
    80003b3e:	8b32                	mv	s6,a2
  if ((ip = dirlookup(dp, name, 0)) != 0) {
    80003b40:	4601                	li	a2,0
    80003b42:	debff0ef          	jal	8000392c <dirlookup>
    80003b46:	ed1d                	bnez	a0,80003b84 <dirlink+0x58>
    80003b48:	fc26                	sd	s1,56(sp)
  for (off = 0; off < dp->size; off += sizeof(de)) {
    80003b4a:	04c92483          	lw	s1,76(s2)
    80003b4e:	c4b9                	beqz	s1,80003b9c <dirlink+0x70>
    80003b50:	f44e                	sd	s3,40(sp)
    80003b52:	f052                	sd	s4,32(sp)
    80003b54:	4481                	li	s1,0
    if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003b56:	fb040a13          	addi	s4,s0,-80
    80003b5a:	49c1                	li	s3,16
    80003b5c:	874e                	mv	a4,s3
    80003b5e:	86a6                	mv	a3,s1
    80003b60:	8652                	mv	a2,s4
    80003b62:	4581                	li	a1,0
    80003b64:	854a                	mv	a0,s2
    80003b66:	bb3ff0ef          	jal	80003718 <readi>
    80003b6a:	03351163          	bne	a0,s3,80003b8c <dirlink+0x60>
    if (de.inum == 0)
    80003b6e:	fb045783          	lhu	a5,-80(s0)
    80003b72:	c39d                	beqz	a5,80003b98 <dirlink+0x6c>
  for (off = 0; off < dp->size; off += sizeof(de)) {
    80003b74:	24c1                	addiw	s1,s1,16
    80003b76:	04c92783          	lw	a5,76(s2)
    80003b7a:	fef4e1e3          	bltu	s1,a5,80003b5c <dirlink+0x30>
    80003b7e:	79a2                	ld	s3,40(sp)
    80003b80:	7a02                	ld	s4,32(sp)
    80003b82:	a829                	j	80003b9c <dirlink+0x70>
    iput(ip);
    80003b84:	93dff0ef          	jal	800034c0 <iput>
    return -1;
    80003b88:	557d                	li	a0,-1
    80003b8a:	a83d                	j	80003bc8 <dirlink+0x9c>
      panic("dirlink read");
    80003b8c:	00005517          	auipc	a0,0x5
    80003b90:	95450513          	addi	a0,a0,-1708 # 800084e0 <etext+0x4e0>
    80003b94:	cb5fc0ef          	jal	80000848 <panic>
    80003b98:	79a2                	ld	s3,40(sp)
    80003b9a:	7a02                	ld	s4,32(sp)
  strncpy(de.name, name, DIRSIZ);
    80003b9c:	4639                	li	a2,14
    80003b9e:	85d6                	mv	a1,s5
    80003ba0:	fb240513          	addi	a0,s0,-78
    80003ba4:	a16fd0ef          	jal	80000dba <strncpy>
  de.inum = inum;
    80003ba8:	fb641823          	sh	s6,-80(s0)
  if (writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003bac:	4741                	li	a4,16
    80003bae:	86a6                	mv	a3,s1
    80003bb0:	fb040613          	addi	a2,s0,-80
    80003bb4:	4581                	li	a1,0
    80003bb6:	854a                	mv	a0,s2
    80003bb8:	c53ff0ef          	jal	8000380a <writei>
    80003bbc:	1541                	addi	a0,a0,-16
    80003bbe:	00a03533          	snez	a0,a0
    80003bc2:	40a0053b          	negw	a0,a0
    80003bc6:	74e2                	ld	s1,56(sp)
}
    80003bc8:	60a6                	ld	ra,72(sp)
    80003bca:	6406                	ld	s0,64(sp)
    80003bcc:	7942                	ld	s2,48(sp)
    80003bce:	6ae2                	ld	s5,24(sp)
    80003bd0:	6b42                	ld	s6,16(sp)
    80003bd2:	6161                	addi	sp,sp,80
    80003bd4:	8082                	ret

0000000080003bd6 <namei>:

struct inode *
namei(char *path)
{
    80003bd6:	1101                	addi	sp,sp,-32
    80003bd8:	ec06                	sd	ra,24(sp)
    80003bda:	e822                	sd	s0,16(sp)
    80003bdc:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003bde:	fe040613          	addi	a2,s0,-32
    80003be2:	4581                	li	a1,0
    80003be4:	df1ff0ef          	jal	800039d4 <namex>
}
    80003be8:	60e2                	ld	ra,24(sp)
    80003bea:	6442                	ld	s0,16(sp)
    80003bec:	6105                	addi	sp,sp,32
    80003bee:	8082                	ret

0000000080003bf0 <nameiparent>:

struct inode *
nameiparent(char *path, char *name)
{
    80003bf0:	1141                	addi	sp,sp,-16
    80003bf2:	e406                	sd	ra,8(sp)
    80003bf4:	e022                	sd	s0,0(sp)
    80003bf6:	0800                	addi	s0,sp,16
    80003bf8:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80003bfa:	4585                	li	a1,1
    80003bfc:	dd9ff0ef          	jal	800039d4 <namex>
}
    80003c00:	60a2                	ld	ra,8(sp)
    80003c02:	6402                	ld	s0,0(sp)
    80003c04:	0141                	addi	sp,sp,16
    80003c06:	8082                	ret

0000000080003c08 <get_superblock>:

// Copy the in-memory superblock into *out.
void
get_superblock(struct superblock *out)
{
    80003c08:	1141                	addi	sp,sp,-16
    80003c0a:	e406                	sd	ra,8(sp)
    80003c0c:	e022                	sd	s0,0(sp)
    80003c0e:	0800                	addi	s0,sp,16
  *out = sb;
    80003c10:	00054797          	auipc	a5,0x54
    80003c14:	34878793          	addi	a5,a5,840 # 80057f58 <sb>
    80003c18:	0007ae03          	lw	t3,0(a5)
    80003c1c:	0047a303          	lw	t1,4(a5)
    80003c20:	0087a883          	lw	a7,8(a5)
    80003c24:	00c7a803          	lw	a6,12(a5)
    80003c28:	4b8c                	lw	a1,16(a5)
    80003c2a:	4bd0                	lw	a2,20(a5)
    80003c2c:	4f94                	lw	a3,24(a5)
    80003c2e:	4fd8                	lw	a4,28(a5)
    80003c30:	01c52023          	sw	t3,0(a0)
    80003c34:	00652223          	sw	t1,4(a0)
    80003c38:	01152423          	sw	a7,8(a0)
    80003c3c:	01052623          	sw	a6,12(a0)
    80003c40:	c90c                	sw	a1,16(a0)
    80003c42:	c950                	sw	a2,20(a0)
    80003c44:	cd14                	sw	a3,24(a0)
    80003c46:	cd58                	sw	a4,28(a0)
    80003c48:	539c                	lw	a5,32(a5)
    80003c4a:	d11c                	sw	a5,32(a0)
}
    80003c4c:	60a2                	ld	ra,8(sp)
    80003c4e:	6402                	ld	s0,0(sp)
    80003c50:	0141                	addi	sp,sp,16
    80003c52:	8082                	ret

0000000080003c54 <itreeprint>:

// Print the block tree of ip.
// Caller must hold ip->lock.
void
itreeprint(struct inode *ip)
{
    80003c54:	711d                	addi	sp,sp,-96
    80003c56:	ec86                	sd	ra,88(sp)
    80003c58:	e8a2                	sd	s0,80(sp)
    80003c5a:	e4a6                	sd	s1,72(sp)
    80003c5c:	e0ca                	sd	s2,64(sp)
    80003c5e:	fc4e                	sd	s3,56(sp)
    80003c60:	f852                	sd	s4,48(sp)
    80003c62:	ec5e                	sd	s7,24(sp)
    80003c64:	1080                	addi	s0,sp,96
    80003c66:	8baa                	mv	s7,a0
  struct buf *bp,*bp2;
  uint *a,*a2;

  printk("inode %d type %d size %d\n", ip->inum, ip->type, ip->size);
    80003c68:	4574                	lw	a3,76(a0)
    80003c6a:	04451603          	lh	a2,68(a0)
    80003c6e:	414c                	lw	a1,4(a0)
    80003c70:	00005517          	auipc	a0,0x5
    80003c74:	88050513          	addi	a0,a0,-1920 # 800084f0 <etext+0x4f0>
    80003c78:	899fc0ef          	jal	80000510 <printk>

  // direct Blocks (ip->addrs[0 ... NDIRECT-1])
  for (int i=0;i<NDIRECT;i++) {
    80003c7c:	050b8913          	addi	s2,s7,80
    80003c80:	4481                	li	s1,0
    if(ip->addrs[i]!=0) {
      printk("..%d: %d\n",i,ip->addrs[i]);
    80003c82:	00005a17          	auipc	s4,0x5
    80003c86:	88ea0a13          	addi	s4,s4,-1906 # 80008510 <etext+0x510>
  for (int i=0;i<NDIRECT;i++) {
    80003c8a:	49ad                	li	s3,11
    80003c8c:	a029                	j	80003c96 <itreeprint+0x42>
    80003c8e:	2485                	addiw	s1,s1,1
    80003c90:	0911                	addi	s2,s2,4
    80003c92:	01348a63          	beq	s1,s3,80003ca6 <itreeprint+0x52>
    if(ip->addrs[i]!=0) {
    80003c96:	00092603          	lw	a2,0(s2)
    80003c9a:	da75                	beqz	a2,80003c8e <itreeprint+0x3a>
      printk("..%d: %d\n",i,ip->addrs[i]);
    80003c9c:	85a6                	mv	a1,s1
    80003c9e:	8552                	mv	a0,s4
    80003ca0:	871fc0ef          	jal	80000510 <printk>
    80003ca4:	b7ed                	j	80003c8e <itreeprint+0x3a>
    }
  }

  //singly-indirect Block (ip->addrs[NDIRECT])
  if(ip->addrs[NDIRECT]!=0){
    80003ca6:	07cba583          	lw	a1,124(s7)
    80003caa:	ed89                	bnez	a1,80003cc4 <itreeprint+0x70>
    }
    brelse(bp);
  }

  //doubly-indirect block 
  if(NDIRECT==11&&ip->addrs[NDIRECT+1]!=0){
    80003cac:	080ba583          	lw	a1,128(s7)
    80003cb0:	e1bd                	bnez	a1,80003d16 <itreeprint+0xc2>
        brelse(bp2);
      }
    }
    brelse(bp);
  }
    80003cb2:	60e6                	ld	ra,88(sp)
    80003cb4:	6446                	ld	s0,80(sp)
    80003cb6:	64a6                	ld	s1,72(sp)
    80003cb8:	6906                	ld	s2,64(sp)
    80003cba:	79e2                	ld	s3,56(sp)
    80003cbc:	7a42                	ld	s4,48(sp)
    80003cbe:	6be2                	ld	s7,24(sp)
    80003cc0:	6125                	addi	sp,sp,96
    80003cc2:	8082                	ret
    80003cc4:	f456                	sd	s5,40(sp)
    printk("..indirect: %d\n",ip->addrs[NDIRECT]);
    80003cc6:	00005517          	auipc	a0,0x5
    80003cca:	85a50513          	addi	a0,a0,-1958 # 80008520 <etext+0x520>
    80003cce:	843fc0ef          	jal	80000510 <printk>
    bp=bread(ip->dev,ip->addrs[NDIRECT]);
    80003cd2:	07cba583          	lw	a1,124(s7)
    80003cd6:	000ba503          	lw	a0,0(s7)
    80003cda:	e81fe0ef          	jal	80002b5a <bread>
    80003cde:	8aaa                	mv	s5,a0
    for(int j=0;j<NINDIRECT;j++){
    80003ce0:	05850913          	addi	s2,a0,88
    80003ce4:	4481                	li	s1,0
        printk(".. ..%d: %d\n",j,a[j]);
    80003ce6:	00005a17          	auipc	s4,0x5
    80003cea:	84aa0a13          	addi	s4,s4,-1974 # 80008530 <etext+0x530>
    for(int j=0;j<NINDIRECT;j++){
    80003cee:	10000993          	li	s3,256
    80003cf2:	a029                	j	80003cfc <itreeprint+0xa8>
    80003cf4:	2485                	addiw	s1,s1,1
    80003cf6:	0911                	addi	s2,s2,4
    80003cf8:	01348a63          	beq	s1,s3,80003d0c <itreeprint+0xb8>
      if(a[j]!=0){
    80003cfc:	00092603          	lw	a2,0(s2)
    80003d00:	da75                	beqz	a2,80003cf4 <itreeprint+0xa0>
        printk(".. ..%d: %d\n",j,a[j]);
    80003d02:	85a6                	mv	a1,s1
    80003d04:	8552                	mv	a0,s4
    80003d06:	80bfc0ef          	jal	80000510 <printk>
    80003d0a:	b7ed                	j	80003cf4 <itreeprint+0xa0>
    brelse(bp);
    80003d0c:	8556                	mv	a0,s5
    80003d0e:	f55fe0ef          	jal	80002c62 <brelse>
    80003d12:	7aa2                	ld	s5,40(sp)
    80003d14:	bf61                	j	80003cac <itreeprint+0x58>
    80003d16:	f456                	sd	s5,40(sp)
    80003d18:	f05a                	sd	s6,32(sp)
    80003d1a:	e862                	sd	s8,16(sp)
    80003d1c:	e466                	sd	s9,8(sp)
    80003d1e:	e06a                	sd	s10,0(sp)
    printk("..double-indirect: %d\n",ip->addrs[NDIRECT + 1]);
    80003d20:	00005517          	auipc	a0,0x5
    80003d24:	82050513          	addi	a0,a0,-2016 # 80008540 <etext+0x540>
    80003d28:	fe8fc0ef          	jal	80000510 <printk>
    bp=bread(ip->dev, ip->addrs[NDIRECT + 1]);
    80003d2c:	080ba583          	lw	a1,128(s7)
    80003d30:	000ba503          	lw	a0,0(s7)
    80003d34:	e27fe0ef          	jal	80002b5a <bread>
    80003d38:	8d2a                	mv	s10,a0
    for(int j=0;j<NINDIRECT;j++){
    80003d3a:	05850b13          	addi	s6,a0,88
    80003d3e:	4a81                	li	s5,0
        printk(".. ..%d: %d\n",j,a[j]);
    80003d40:	00004c17          	auipc	s8,0x4
    80003d44:	7f0c0c13          	addi	s8,s8,2032 # 80008530 <etext+0x530>
            printk(".. .. ..%d: %d\n", k, a2[k]);
    80003d48:	00005a17          	auipc	s4,0x5
    80003d4c:	810a0a13          	addi	s4,s4,-2032 # 80008558 <etext+0x558>
        for(int k=0;k<NINDIRECT;k++){
    80003d50:	10000993          	li	s3,256
    80003d54:	a025                	j	80003d7c <itreeprint+0x128>
            printk(".. .. ..%d: %d\n", k, a2[k]);
    80003d56:	85a6                	mv	a1,s1
    80003d58:	8552                	mv	a0,s4
    80003d5a:	fb6fc0ef          	jal	80000510 <printk>
        for(int k=0;k<NINDIRECT;k++){
    80003d5e:	2485                	addiw	s1,s1,1
    80003d60:	0911                	addi	s2,s2,4
    80003d62:	01348663          	beq	s1,s3,80003d6e <itreeprint+0x11a>
          if(a2[k]!=0){
    80003d66:	00092603          	lw	a2,0(s2)
    80003d6a:	da75                	beqz	a2,80003d5e <itreeprint+0x10a>
    80003d6c:	b7ed                	j	80003d56 <itreeprint+0x102>
        brelse(bp2);
    80003d6e:	8566                	mv	a0,s9
    80003d70:	ef3fe0ef          	jal	80002c62 <brelse>
    for(int j=0;j<NINDIRECT;j++){
    80003d74:	2a85                	addiw	s5,s5,1
    80003d76:	0b11                	addi	s6,s6,4
    80003d78:	033a8463          	beq	s5,s3,80003da0 <itreeprint+0x14c>
      if(a[j]!=0){
    80003d7c:	000b2603          	lw	a2,0(s6)
    80003d80:	da75                	beqz	a2,80003d74 <itreeprint+0x120>
        printk(".. ..%d: %d\n",j,a[j]);
    80003d82:	85d6                	mv	a1,s5
    80003d84:	8562                	mv	a0,s8
    80003d86:	f8afc0ef          	jal	80000510 <printk>
        bp2 = bread(ip->dev, a[j]);
    80003d8a:	000b2583          	lw	a1,0(s6)
    80003d8e:	000ba503          	lw	a0,0(s7)
    80003d92:	dc9fe0ef          	jal	80002b5a <bread>
    80003d96:	8caa                	mv	s9,a0
        for(int k=0;k<NINDIRECT;k++){
    80003d98:	05850913          	addi	s2,a0,88
    80003d9c:	4481                	li	s1,0
    80003d9e:	b7e1                	j	80003d66 <itreeprint+0x112>
    brelse(bp);
    80003da0:	856a                	mv	a0,s10
    80003da2:	ec1fe0ef          	jal	80002c62 <brelse>
    80003da6:	7aa2                	ld	s5,40(sp)
    80003da8:	7b02                	ld	s6,32(sp)
    80003daa:	6c42                	ld	s8,16(sp)
    80003dac:	6ca2                	ld	s9,8(sp)
    80003dae:	6d02                	ld	s10,0(sp)
    80003db0:	b709                	j	80003cb2 <itreeprint+0x5e>

0000000080003db2 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80003db2:	1101                	addi	sp,sp,-32
    80003db4:	ec06                	sd	ra,24(sp)
    80003db6:	e822                	sd	s0,16(sp)
    80003db8:	e426                	sd	s1,8(sp)
    80003dba:	e04a                	sd	s2,0(sp)
    80003dbc:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003dbe:	00056917          	auipc	s2,0x56
    80003dc2:	c6a90913          	addi	s2,s2,-918 # 80059a28 <log>
    80003dc6:	01892583          	lw	a1,24(s2)
    80003dca:	02492503          	lw	a0,36(s2)
    80003dce:	d8dfe0ef          	jal	80002b5a <bread>
    80003dd2:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *)(buf->data);
  int i;
  hb->n = log.lh.n;
    80003dd4:	02c92603          	lw	a2,44(s2)
    80003dd8:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003dda:	00c05f63          	blez	a2,80003df8 <write_head+0x46>
    80003dde:	00056717          	auipc	a4,0x56
    80003de2:	c7a70713          	addi	a4,a4,-902 # 80059a58 <log+0x30>
    80003de6:	87aa                	mv	a5,a0
    80003de8:	060a                	slli	a2,a2,0x2
    80003dea:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    80003dec:	4314                	lw	a3,0(a4)
    80003dee:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    80003df0:	0711                	addi	a4,a4,4
    80003df2:	0791                	addi	a5,a5,4
    80003df4:	fec79ce3          	bne	a5,a2,80003dec <write_head+0x3a>
  }
  bwrite(buf);
    80003df8:	8526                	mv	a0,s1
    80003dfa:	e37fe0ef          	jal	80002c30 <bwrite>
  brelse(buf);
    80003dfe:	8526                	mv	a0,s1
    80003e00:	e63fe0ef          	jal	80002c62 <brelse>
}
    80003e04:	60e2                	ld	ra,24(sp)
    80003e06:	6442                	ld	s0,16(sp)
    80003e08:	64a2                	ld	s1,8(sp)
    80003e0a:	6902                	ld	s2,0(sp)
    80003e0c:	6105                	addi	sp,sp,32
    80003e0e:	8082                	ret

0000000080003e10 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80003e10:	00056797          	auipc	a5,0x56
    80003e14:	c447a783          	lw	a5,-956(a5) # 80059a54 <log+0x2c>
    80003e18:	0cf05163          	blez	a5,80003eda <install_trans+0xca>
{
    80003e1c:	715d                	addi	sp,sp,-80
    80003e1e:	e486                	sd	ra,72(sp)
    80003e20:	e0a2                	sd	s0,64(sp)
    80003e22:	fc26                	sd	s1,56(sp)
    80003e24:	f84a                	sd	s2,48(sp)
    80003e26:	f44e                	sd	s3,40(sp)
    80003e28:	f052                	sd	s4,32(sp)
    80003e2a:	ec56                	sd	s5,24(sp)
    80003e2c:	e85a                	sd	s6,16(sp)
    80003e2e:	e45e                	sd	s7,8(sp)
    80003e30:	e062                	sd	s8,0(sp)
    80003e32:	0880                	addi	s0,sp,80
    80003e34:	8b2a                	mv	s6,a0
    80003e36:	00056a97          	auipc	s5,0x56
    80003e3a:	c22a8a93          	addi	s5,s5,-990 # 80059a58 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003e3e:	4981                	li	s3,0
      printk("recovering tail %d dst %d\n", tail, log.lh.block[tail]);
    80003e40:	00004c17          	auipc	s8,0x4
    80003e44:	728c0c13          	addi	s8,s8,1832 # 80008568 <etext+0x568>
    struct buf *lbuf = bread(log.dev, log.start + tail + 1); // read log block
    80003e48:	00056a17          	auipc	s4,0x56
    80003e4c:	be0a0a13          	addi	s4,s4,-1056 # 80059a28 <log>
    memmove(dbuf->data, lbuf->data, BSIZE); // copy block to dst
    80003e50:	40000b93          	li	s7,1024
    80003e54:	a025                	j	80003e7c <install_trans+0x6c>
      printk("recovering tail %d dst %d\n", tail, log.lh.block[tail]);
    80003e56:	000aa603          	lw	a2,0(s5)
    80003e5a:	85ce                	mv	a1,s3
    80003e5c:	8562                	mv	a0,s8
    80003e5e:	eb2fc0ef          	jal	80000510 <printk>
    80003e62:	a839                	j	80003e80 <install_trans+0x70>
    brelse(lbuf);
    80003e64:	854a                	mv	a0,s2
    80003e66:	dfdfe0ef          	jal	80002c62 <brelse>
    brelse(dbuf);
    80003e6a:	8526                	mv	a0,s1
    80003e6c:	df7fe0ef          	jal	80002c62 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003e70:	2985                	addiw	s3,s3,1
    80003e72:	0a91                	addi	s5,s5,4
    80003e74:	02ca2783          	lw	a5,44(s4)
    80003e78:	04f9d563          	bge	s3,a5,80003ec2 <install_trans+0xb2>
    if (recovering) {
    80003e7c:	fc0b1de3          	bnez	s6,80003e56 <install_trans+0x46>
    struct buf *lbuf = bread(log.dev, log.start + tail + 1); // read log block
    80003e80:	018a2583          	lw	a1,24(s4)
    80003e84:	013585bb          	addw	a1,a1,s3
    80003e88:	2585                	addiw	a1,a1,1
    80003e8a:	024a2503          	lw	a0,36(s4)
    80003e8e:	ccdfe0ef          	jal	80002b5a <bread>
    80003e92:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]);   // read dst
    80003e94:	000aa583          	lw	a1,0(s5)
    80003e98:	024a2503          	lw	a0,36(s4)
    80003e9c:	cbffe0ef          	jal	80002b5a <bread>
    80003ea0:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE); // copy block to dst
    80003ea2:	865e                	mv	a2,s7
    80003ea4:	05890593          	addi	a1,s2,88
    80003ea8:	05850513          	addi	a0,a0,88
    80003eac:	e65fc0ef          	jal	80000d10 <memmove>
    bwrite(dbuf);                           // write dst to disk
    80003eb0:	8526                	mv	a0,s1
    80003eb2:	d7ffe0ef          	jal	80002c30 <bwrite>
    if (recovering == 0)
    80003eb6:	fa0b17e3          	bnez	s6,80003e64 <install_trans+0x54>
      bunpin(dbuf);
    80003eba:	8526                	mv	a0,s1
    80003ebc:	e5ffe0ef          	jal	80002d1a <bunpin>
    80003ec0:	b755                	j	80003e64 <install_trans+0x54>
}
    80003ec2:	60a6                	ld	ra,72(sp)
    80003ec4:	6406                	ld	s0,64(sp)
    80003ec6:	74e2                	ld	s1,56(sp)
    80003ec8:	7942                	ld	s2,48(sp)
    80003eca:	79a2                	ld	s3,40(sp)
    80003ecc:	7a02                	ld	s4,32(sp)
    80003ece:	6ae2                	ld	s5,24(sp)
    80003ed0:	6b42                	ld	s6,16(sp)
    80003ed2:	6ba2                	ld	s7,8(sp)
    80003ed4:	6c02                	ld	s8,0(sp)
    80003ed6:	6161                	addi	sp,sp,80
    80003ed8:	8082                	ret
    80003eda:	8082                	ret

0000000080003edc <initlog>:
{
    80003edc:	7179                	addi	sp,sp,-48
    80003ede:	f406                	sd	ra,40(sp)
    80003ee0:	f022                	sd	s0,32(sp)
    80003ee2:	ec26                	sd	s1,24(sp)
    80003ee4:	e84a                	sd	s2,16(sp)
    80003ee6:	e44e                	sd	s3,8(sp)
    80003ee8:	1800                	addi	s0,sp,48
    80003eea:	84aa                	mv	s1,a0
    80003eec:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003eee:	00056917          	auipc	s2,0x56
    80003ef2:	b3a90913          	addi	s2,s2,-1222 # 80059a28 <log>
    80003ef6:	00004597          	auipc	a1,0x4
    80003efa:	69258593          	addi	a1,a1,1682 # 80008588 <etext+0x588>
    80003efe:	854a                	mv	a0,s2
    80003f00:	c79fc0ef          	jal	80000b78 <initlock>
  log.start = sb->logstart;
    80003f04:	0149a583          	lw	a1,20(s3)
    80003f08:	00b92c23          	sw	a1,24(s2)
  log.dev = dev;
    80003f0c:	02992223          	sw	s1,36(s2)
  struct buf *buf = bread(log.dev, log.start);
    80003f10:	8526                	mv	a0,s1
    80003f12:	c49fe0ef          	jal	80002b5a <bread>
  log.lh.n = lh->n;
    80003f16:	4d30                	lw	a2,88(a0)
    80003f18:	02c92623          	sw	a2,44(s2)
  for (i = 0; i < log.lh.n; i++) {
    80003f1c:	00c05f63          	blez	a2,80003f3a <initlog+0x5e>
    80003f20:	87aa                	mv	a5,a0
    80003f22:	00056717          	auipc	a4,0x56
    80003f26:	b3670713          	addi	a4,a4,-1226 # 80059a58 <log+0x30>
    80003f2a:	060a                	slli	a2,a2,0x2
    80003f2c:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    80003f2e:	4ff4                	lw	a3,92(a5)
    80003f30:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003f32:	0791                	addi	a5,a5,4
    80003f34:	0711                	addi	a4,a4,4
    80003f36:	fec79ce3          	bne	a5,a2,80003f2e <initlog+0x52>
  brelse(buf);
    80003f3a:	d29fe0ef          	jal	80002c62 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80003f3e:	4505                	li	a0,1
    80003f40:	ed1ff0ef          	jal	80003e10 <install_trans>
  log.lh.n = 0;
    80003f44:	00056797          	auipc	a5,0x56
    80003f48:	b007a823          	sw	zero,-1264(a5) # 80059a54 <log+0x2c>
  write_head(); // clear the log
    80003f4c:	e67ff0ef          	jal	80003db2 <write_head>
}
    80003f50:	70a2                	ld	ra,40(sp)
    80003f52:	7402                	ld	s0,32(sp)
    80003f54:	64e2                	ld	s1,24(sp)
    80003f56:	6942                	ld	s2,16(sp)
    80003f58:	69a2                	ld	s3,8(sp)
    80003f5a:	6145                	addi	sp,sp,48
    80003f5c:	8082                	ret

0000000080003f5e <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80003f5e:	1101                	addi	sp,sp,-32
    80003f60:	ec06                	sd	ra,24(sp)
    80003f62:	e822                	sd	s0,16(sp)
    80003f64:	e426                	sd	s1,8(sp)
    80003f66:	e04a                	sd	s2,0(sp)
    80003f68:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80003f6a:	00056517          	auipc	a0,0x56
    80003f6e:	abe50513          	addi	a0,a0,-1346 # 80059a28 <log>
    80003f72:	c87fc0ef          	jal	80000bf8 <acquire>
  while (1) {
    if (log.committing) {
    80003f76:	00056497          	auipc	s1,0x56
    80003f7a:	ab248493          	addi	s1,s1,-1358 # 80059a28 <log>
      sleep_prepare(&log);
      release(&log.lock);
      sleep();
      acquire(&log.lock);
    } else if (log.lh.n + (log.outstanding + 1) * MAXOPBLOCKS > LOGBLOCKS) {
    80003f7e:	0f000913          	li	s2,240
    80003f82:	a821                	j	80003f9a <begin_op+0x3c>
      sleep_prepare(&log);
    80003f84:	8526                	mv	a0,s1
    80003f86:	f65fd0ef          	jal	80001eea <sleep_prepare>
      release(&log.lock);
    80003f8a:	8526                	mv	a0,s1
    80003f8c:	cf1fc0ef          	jal	80000c7c <release>
      sleep();
    80003f90:	f97fd0ef          	jal	80001f26 <sleep>
      acquire(&log.lock);
    80003f94:	8526                	mv	a0,s1
    80003f96:	c63fc0ef          	jal	80000bf8 <acquire>
    if (log.committing) {
    80003f9a:	509c                	lw	a5,32(s1)
    80003f9c:	f7e5                	bnez	a5,80003f84 <begin_op+0x26>
    } else if (log.lh.n + (log.outstanding + 1) * MAXOPBLOCKS > LOGBLOCKS) {
    80003f9e:	4cd8                	lw	a4,28(s1)
    80003fa0:	2705                	addiw	a4,a4,1
    80003fa2:	0027179b          	slliw	a5,a4,0x2
    80003fa6:	9fb9                	addw	a5,a5,a4
    80003fa8:	0047979b          	slliw	a5,a5,0x4
    80003fac:	54d4                	lw	a3,44(s1)
    80003fae:	9fb5                	addw	a5,a5,a3
    80003fb0:	00f95e63          	bge	s2,a5,80003fcc <begin_op+0x6e>
      // this op might exhaust log space; wait for commit.
      sleep_prepare(&log);
    80003fb4:	8526                	mv	a0,s1
    80003fb6:	f35fd0ef          	jal	80001eea <sleep_prepare>
      release(&log.lock);
    80003fba:	8526                	mv	a0,s1
    80003fbc:	cc1fc0ef          	jal	80000c7c <release>
      sleep();
    80003fc0:	f67fd0ef          	jal	80001f26 <sleep>
      acquire(&log.lock);
    80003fc4:	8526                	mv	a0,s1
    80003fc6:	c33fc0ef          	jal	80000bf8 <acquire>
    80003fca:	bfc1                	j	80003f9a <begin_op+0x3c>
    } else {
      log.outstanding += 1;
    80003fcc:	00056797          	auipc	a5,0x56
    80003fd0:	a6e7ac23          	sw	a4,-1416(a5) # 80059a44 <log+0x1c>
      release(&log.lock);
    80003fd4:	00056517          	auipc	a0,0x56
    80003fd8:	a5450513          	addi	a0,a0,-1452 # 80059a28 <log>
    80003fdc:	ca1fc0ef          	jal	80000c7c <release>
      break;
    }
  }
}
    80003fe0:	60e2                	ld	ra,24(sp)
    80003fe2:	6442                	ld	s0,16(sp)
    80003fe4:	64a2                	ld	s1,8(sp)
    80003fe6:	6902                	ld	s2,0(sp)
    80003fe8:	6105                	addi	sp,sp,32
    80003fea:	8082                	ret

0000000080003fec <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003fec:	7139                	addi	sp,sp,-64
    80003fee:	fc06                	sd	ra,56(sp)
    80003ff0:	f822                	sd	s0,48(sp)
    80003ff2:	f426                	sd	s1,40(sp)
    80003ff4:	f04a                	sd	s2,32(sp)
    80003ff6:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003ff8:	00056497          	auipc	s1,0x56
    80003ffc:	a3048493          	addi	s1,s1,-1488 # 80059a28 <log>
    80004000:	8526                	mv	a0,s1
    80004002:	bf7fc0ef          	jal	80000bf8 <acquire>
  log.outstanding -= 1;
    80004006:	4cdc                	lw	a5,28(s1)
    80004008:	37fd                	addiw	a5,a5,-1
    8000400a:	893e                	mv	s2,a5
    8000400c:	ccdc                	sw	a5,28(s1)
  if (log.committing)
    8000400e:	509c                	lw	a5,32(s1)
    80004010:	e7b9                	bnez	a5,8000405e <end_op+0x72>
    panic("log.committing");
  if (log.outstanding == 0) {
    80004012:	04091f63          	bnez	s2,80004070 <end_op+0x84>
    do_commit = 1;
    log.committing = 1;
    80004016:	00056497          	auipc	s1,0x56
    8000401a:	a1248493          	addi	s1,s1,-1518 # 80059a28 <log>
    8000401e:	4785                	li	a5,1
    80004020:	d09c                	sw	a5,32(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80004022:	8526                	mv	a0,s1
    80004024:	c59fc0ef          	jal	80000c7c <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80004028:	54dc                	lw	a5,44(s1)
    8000402a:	06f04063          	bgtz	a5,8000408a <end_op+0x9e>
    acquire(&log.lock);
    8000402e:	00056497          	auipc	s1,0x56
    80004032:	9fa48493          	addi	s1,s1,-1542 # 80059a28 <log>
    80004036:	8526                	mv	a0,s1
    80004038:	bc1fc0ef          	jal	80000bf8 <acquire>
    log.committing = 0;
    8000403c:	0204a023          	sw	zero,32(s1)
    log.ncommit += 1;
    80004040:	549c                	lw	a5,40(s1)
    80004042:	2785                	addiw	a5,a5,1
    80004044:	d49c                	sw	a5,40(s1)
    wakeup(&log);
    80004046:	8526                	mv	a0,s1
    80004048:	f0ffd0ef          	jal	80001f56 <wakeup>
    release(&log.lock);
    8000404c:	8526                	mv	a0,s1
    8000404e:	c2ffc0ef          	jal	80000c7c <release>
}
    80004052:	70e2                	ld	ra,56(sp)
    80004054:	7442                	ld	s0,48(sp)
    80004056:	74a2                	ld	s1,40(sp)
    80004058:	7902                	ld	s2,32(sp)
    8000405a:	6121                	addi	sp,sp,64
    8000405c:	8082                	ret
    8000405e:	ec4e                	sd	s3,24(sp)
    80004060:	e852                	sd	s4,16(sp)
    80004062:	e456                	sd	s5,8(sp)
    panic("log.committing");
    80004064:	00004517          	auipc	a0,0x4
    80004068:	52c50513          	addi	a0,a0,1324 # 80008590 <etext+0x590>
    8000406c:	fdcfc0ef          	jal	80000848 <panic>
    wakeup(&log);
    80004070:	00056517          	auipc	a0,0x56
    80004074:	9b850513          	addi	a0,a0,-1608 # 80059a28 <log>
    80004078:	edffd0ef          	jal	80001f56 <wakeup>
  release(&log.lock);
    8000407c:	00056517          	auipc	a0,0x56
    80004080:	9ac50513          	addi	a0,a0,-1620 # 80059a28 <log>
    80004084:	bf9fc0ef          	jal	80000c7c <release>
  if (do_commit) {
    80004088:	b7e9                	j	80004052 <end_op+0x66>
    8000408a:	ec4e                	sd	s3,24(sp)
    8000408c:	e852                	sd	s4,16(sp)
    8000408e:	e456                	sd	s5,8(sp)
  for (tail = 0; tail < log.lh.n; tail++) {
    80004090:	00056a97          	auipc	s5,0x56
    80004094:	9c8a8a93          	addi	s5,s5,-1592 # 80059a58 <log+0x30>
    struct buf *to = bread(log.dev, log.start + tail + 1); // log block
    80004098:	00056a17          	auipc	s4,0x56
    8000409c:	990a0a13          	addi	s4,s4,-1648 # 80059a28 <log>
    800040a0:	018a2583          	lw	a1,24(s4)
    800040a4:	012585bb          	addw	a1,a1,s2
    800040a8:	2585                	addiw	a1,a1,1
    800040aa:	024a2503          	lw	a0,36(s4)
    800040ae:	aadfe0ef          	jal	80002b5a <bread>
    800040b2:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800040b4:	000aa583          	lw	a1,0(s5)
    800040b8:	024a2503          	lw	a0,36(s4)
    800040bc:	a9ffe0ef          	jal	80002b5a <bread>
    800040c0:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    800040c2:	40000613          	li	a2,1024
    800040c6:	05850593          	addi	a1,a0,88
    800040ca:	05848513          	addi	a0,s1,88
    800040ce:	c43fc0ef          	jal	80000d10 <memmove>
    bwrite(to); // write the log
    800040d2:	8526                	mv	a0,s1
    800040d4:	b5dfe0ef          	jal	80002c30 <bwrite>
    brelse(from);
    800040d8:	854e                	mv	a0,s3
    800040da:	b89fe0ef          	jal	80002c62 <brelse>
    brelse(to);
    800040de:	8526                	mv	a0,s1
    800040e0:	b83fe0ef          	jal	80002c62 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800040e4:	2905                	addiw	s2,s2,1
    800040e6:	0a91                	addi	s5,s5,4
    800040e8:	02ca2783          	lw	a5,44(s4)
    800040ec:	faf94ae3          	blt	s2,a5,800040a0 <end_op+0xb4>
    write_log();      // Write modified blocks from cache to log
    write_head();     // Write header to disk -- the real commit
    800040f0:	cc3ff0ef          	jal	80003db2 <write_head>
    install_trans(0); // Now install writes to home locations
    800040f4:	4501                	li	a0,0
    800040f6:	d1bff0ef          	jal	80003e10 <install_trans>
    log.lh.n = 0;
    800040fa:	00056797          	auipc	a5,0x56
    800040fe:	9407ad23          	sw	zero,-1702(a5) # 80059a54 <log+0x2c>
    write_head(); // Erase the transaction from the log
    80004102:	cb1ff0ef          	jal	80003db2 <write_head>
    80004106:	69e2                	ld	s3,24(sp)
    80004108:	6a42                	ld	s4,16(sp)
    8000410a:	6aa2                	ld	s5,8(sp)
    8000410c:	b70d                	j	8000402e <end_op+0x42>

000000008000410e <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    8000410e:	1101                	addi	sp,sp,-32
    80004110:	ec06                	sd	ra,24(sp)
    80004112:	e822                	sd	s0,16(sp)
    80004114:	e426                	sd	s1,8(sp)
    80004116:	1000                	addi	s0,sp,32
    80004118:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    8000411a:	00056517          	auipc	a0,0x56
    8000411e:	90e50513          	addi	a0,a0,-1778 # 80059a28 <log>
    80004122:	ad7fc0ef          	jal	80000bf8 <acquire>
  if (log.lh.n >= LOGBLOCKS)
    80004126:	00056617          	auipc	a2,0x56
    8000412a:	92e62603          	lw	a2,-1746(a2) # 80059a54 <log+0x2c>
    8000412e:	0ef00793          	li	a5,239
    80004132:	04c7cc63          	blt	a5,a2,8000418a <log_write+0x7c>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80004136:	00056797          	auipc	a5,0x56
    8000413a:	90e7a783          	lw	a5,-1778(a5) # 80059a44 <log+0x1c>
    8000413e:	04f05c63          	blez	a5,80004196 <log_write+0x88>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80004142:	4781                	li	a5,0
    80004144:	04c05f63          	blez	a2,800041a2 <log_write+0x94>
    if (log.lh.block[i] == b->blockno) // log absorption
    80004148:	44cc                	lw	a1,12(s1)
    8000414a:	00056717          	auipc	a4,0x56
    8000414e:	90e70713          	addi	a4,a4,-1778 # 80059a58 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80004152:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno) // log absorption
    80004154:	4314                	lw	a3,0(a4)
    80004156:	04b68663          	beq	a3,a1,800041a2 <log_write+0x94>
  for (i = 0; i < log.lh.n; i++) {
    8000415a:	2785                	addiw	a5,a5,1
    8000415c:	0711                	addi	a4,a4,4
    8000415e:	fef61be3          	bne	a2,a5,80004154 <log_write+0x46>
      break;
  }
  log.lh.block[i] = b->blockno;
    80004162:	0621                	addi	a2,a2,8
    80004164:	060a                	slli	a2,a2,0x2
    80004166:	00056797          	auipc	a5,0x56
    8000416a:	8c278793          	addi	a5,a5,-1854 # 80059a28 <log>
    8000416e:	97b2                	add	a5,a5,a2
    80004170:	44d8                	lw	a4,12(s1)
    80004172:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) { // Add new block to log?
    bpin(b);
    80004174:	8526                	mv	a0,s1
    80004176:	b71fe0ef          	jal	80002ce6 <bpin>
    log.lh.n++;
    8000417a:	00056717          	auipc	a4,0x56
    8000417e:	8ae70713          	addi	a4,a4,-1874 # 80059a28 <log>
    80004182:	575c                	lw	a5,44(a4)
    80004184:	2785                	addiw	a5,a5,1
    80004186:	d75c                	sw	a5,44(a4)
    80004188:	a80d                	j	800041ba <log_write+0xac>
    panic("too big a transaction");
    8000418a:	00004517          	auipc	a0,0x4
    8000418e:	41650513          	addi	a0,a0,1046 # 800085a0 <etext+0x5a0>
    80004192:	eb6fc0ef          	jal	80000848 <panic>
    panic("log_write outside of trans");
    80004196:	00004517          	auipc	a0,0x4
    8000419a:	42250513          	addi	a0,a0,1058 # 800085b8 <etext+0x5b8>
    8000419e:	eaafc0ef          	jal	80000848 <panic>
  log.lh.block[i] = b->blockno;
    800041a2:	00878693          	addi	a3,a5,8
    800041a6:	068a                	slli	a3,a3,0x2
    800041a8:	00056717          	auipc	a4,0x56
    800041ac:	88070713          	addi	a4,a4,-1920 # 80059a28 <log>
    800041b0:	9736                	add	a4,a4,a3
    800041b2:	44d4                	lw	a3,12(s1)
    800041b4:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) { // Add new block to log?
    800041b6:	faf60fe3          	beq	a2,a5,80004174 <log_write+0x66>
  }
  release(&log.lock);
    800041ba:	00056517          	auipc	a0,0x56
    800041be:	86e50513          	addi	a0,a0,-1938 # 80059a28 <log>
    800041c2:	abbfc0ef          	jal	80000c7c <release>
}
    800041c6:	60e2                	ld	ra,24(sp)
    800041c8:	6442                	ld	s0,16(sp)
    800041ca:	64a2                	ld	s1,8(sp)
    800041cc:	6105                	addi	sp,sp,32
    800041ce:	8082                	ret

00000000800041d0 <sys_sync>:

uint64
sys_sync(void)
{
    800041d0:	1101                	addi	sp,sp,-32
    800041d2:	ec06                	sd	ra,24(sp)
    800041d4:	e822                	sd	s0,16(sp)
    800041d6:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    800041d8:	00056517          	auipc	a0,0x56
    800041dc:	85050513          	addi	a0,a0,-1968 # 80059a28 <log>
    800041e0:	a19fc0ef          	jal	80000bf8 <acquire>
  if (log.committing || log.outstanding > 0) {
    800041e4:	00056797          	auipc	a5,0x56
    800041e8:	8647a783          	lw	a5,-1948(a5) # 80059a48 <log+0x20>
    800041ec:	e799                	bnez	a5,800041fa <sys_sync+0x2a>
    800041ee:	00056797          	auipc	a5,0x56
    800041f2:	8567a783          	lw	a5,-1962(a5) # 80059a44 <log+0x1c>
    800041f6:	02f05c63          	blez	a5,8000422e <sys_sync+0x5e>
    800041fa:	e426                	sd	s1,8(sp)
    800041fc:	e04a                	sd	s2,0(sp)
    int n = log.ncommit + 1;
    800041fe:	00056917          	auipc	s2,0x56
    80004202:	85292903          	lw	s2,-1966(s2) # 80059a50 <log+0x28>
    while (log.ncommit < n) {
      sleep_prepare(&log);
    80004206:	00056497          	auipc	s1,0x56
    8000420a:	82248493          	addi	s1,s1,-2014 # 80059a28 <log>
    8000420e:	8526                	mv	a0,s1
    80004210:	cdbfd0ef          	jal	80001eea <sleep_prepare>
      release(&log.lock);
    80004214:	8526                	mv	a0,s1
    80004216:	a67fc0ef          	jal	80000c7c <release>
      sleep();
    8000421a:	d0dfd0ef          	jal	80001f26 <sleep>
      acquire(&log.lock);
    8000421e:	8526                	mv	a0,s1
    80004220:	9d9fc0ef          	jal	80000bf8 <acquire>
    while (log.ncommit < n) {
    80004224:	549c                	lw	a5,40(s1)
    80004226:	fef954e3          	bge	s2,a5,8000420e <sys_sync+0x3e>
    8000422a:	64a2                	ld	s1,8(sp)
    8000422c:	6902                	ld	s2,0(sp)
    }
  }
  release(&log.lock);
    8000422e:	00055517          	auipc	a0,0x55
    80004232:	7fa50513          	addi	a0,a0,2042 # 80059a28 <log>
    80004236:	a47fc0ef          	jal	80000c7c <release>
  return 0;
}
    8000423a:	4501                	li	a0,0
    8000423c:	60e2                	ld	ra,24(sp)
    8000423e:	6442                	ld	s0,16(sp)
    80004240:	6105                	addi	sp,sp,32
    80004242:	8082                	ret

0000000080004244 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80004244:	1101                	addi	sp,sp,-32
    80004246:	ec06                	sd	ra,24(sp)
    80004248:	e822                	sd	s0,16(sp)
    8000424a:	e426                	sd	s1,8(sp)
    8000424c:	e04a                	sd	s2,0(sp)
    8000424e:	1000                	addi	s0,sp,32
    80004250:	84aa                	mv	s1,a0
    80004252:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80004254:	00004597          	auipc	a1,0x4
    80004258:	38458593          	addi	a1,a1,900 # 800085d8 <etext+0x5d8>
    8000425c:	0521                	addi	a0,a0,8
    8000425e:	91bfc0ef          	jal	80000b78 <initlock>
  lk->name = name;
    80004262:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80004266:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8000426a:	0204a423          	sw	zero,40(s1)
}
    8000426e:	60e2                	ld	ra,24(sp)
    80004270:	6442                	ld	s0,16(sp)
    80004272:	64a2                	ld	s1,8(sp)
    80004274:	6902                	ld	s2,0(sp)
    80004276:	6105                	addi	sp,sp,32
    80004278:	8082                	ret

000000008000427a <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    8000427a:	1101                	addi	sp,sp,-32
    8000427c:	ec06                	sd	ra,24(sp)
    8000427e:	e822                	sd	s0,16(sp)
    80004280:	e426                	sd	s1,8(sp)
    80004282:	e04a                	sd	s2,0(sp)
    80004284:	1000                	addi	s0,sp,32
    80004286:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80004288:	00850913          	addi	s2,a0,8
    8000428c:	854a                	mv	a0,s2
    8000428e:	96bfc0ef          	jal	80000bf8 <acquire>
  while (lk->locked) {
    80004292:	409c                	lw	a5,0(s1)
    80004294:	cf91                	beqz	a5,800042b0 <acquiresleep+0x36>
    sleep_prepare(lk);
    80004296:	8526                	mv	a0,s1
    80004298:	c53fd0ef          	jal	80001eea <sleep_prepare>
    release(&lk->lk);
    8000429c:	854a                	mv	a0,s2
    8000429e:	9dffc0ef          	jal	80000c7c <release>
    sleep();
    800042a2:	c85fd0ef          	jal	80001f26 <sleep>
    acquire(&lk->lk);
    800042a6:	854a                	mv	a0,s2
    800042a8:	951fc0ef          	jal	80000bf8 <acquire>
  while (lk->locked) {
    800042ac:	409c                	lw	a5,0(s1)
    800042ae:	f7e5                	bnez	a5,80004296 <acquiresleep+0x1c>
  }
  lk->locked = 1;
    800042b0:	4785                	li	a5,1
    800042b2:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    800042b4:	e2efd0ef          	jal	800018e2 <myproc>
    800042b8:	591c                	lw	a5,48(a0)
    800042ba:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    800042bc:	854a                	mv	a0,s2
    800042be:	9bffc0ef          	jal	80000c7c <release>
}
    800042c2:	60e2                	ld	ra,24(sp)
    800042c4:	6442                	ld	s0,16(sp)
    800042c6:	64a2                	ld	s1,8(sp)
    800042c8:	6902                	ld	s2,0(sp)
    800042ca:	6105                	addi	sp,sp,32
    800042cc:	8082                	ret

00000000800042ce <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800042ce:	1101                	addi	sp,sp,-32
    800042d0:	ec06                	sd	ra,24(sp)
    800042d2:	e822                	sd	s0,16(sp)
    800042d4:	e426                	sd	s1,8(sp)
    800042d6:	e04a                	sd	s2,0(sp)
    800042d8:	1000                	addi	s0,sp,32
    800042da:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800042dc:	00850913          	addi	s2,a0,8
    800042e0:	854a                	mv	a0,s2
    800042e2:	917fc0ef          	jal	80000bf8 <acquire>
  lk->locked = 0;
    800042e6:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800042ea:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    800042ee:	8526                	mv	a0,s1
    800042f0:	c67fd0ef          	jal	80001f56 <wakeup>
  release(&lk->lk);
    800042f4:	854a                	mv	a0,s2
    800042f6:	987fc0ef          	jal	80000c7c <release>
}
    800042fa:	60e2                	ld	ra,24(sp)
    800042fc:	6442                	ld	s0,16(sp)
    800042fe:	64a2                	ld	s1,8(sp)
    80004300:	6902                	ld	s2,0(sp)
    80004302:	6105                	addi	sp,sp,32
    80004304:	8082                	ret

0000000080004306 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80004306:	7179                	addi	sp,sp,-48
    80004308:	f406                	sd	ra,40(sp)
    8000430a:	f022                	sd	s0,32(sp)
    8000430c:	ec26                	sd	s1,24(sp)
    8000430e:	e84a                	sd	s2,16(sp)
    80004310:	1800                	addi	s0,sp,48
    80004312:	84aa                	mv	s1,a0
  int r;

  acquire(&lk->lk);
    80004314:	00850913          	addi	s2,a0,8
    80004318:	854a                	mv	a0,s2
    8000431a:	8dffc0ef          	jal	80000bf8 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    8000431e:	409c                	lw	a5,0(s1)
    80004320:	ef81                	bnez	a5,80004338 <holdingsleep+0x32>
    80004322:	4481                	li	s1,0
  release(&lk->lk);
    80004324:	854a                	mv	a0,s2
    80004326:	957fc0ef          	jal	80000c7c <release>
  return r;
}
    8000432a:	8526                	mv	a0,s1
    8000432c:	70a2                	ld	ra,40(sp)
    8000432e:	7402                	ld	s0,32(sp)
    80004330:	64e2                	ld	s1,24(sp)
    80004332:	6942                	ld	s2,16(sp)
    80004334:	6145                	addi	sp,sp,48
    80004336:	8082                	ret
    80004338:	e44e                	sd	s3,8(sp)
  r = lk->locked && (lk->pid == myproc()->pid);
    8000433a:	0284a983          	lw	s3,40(s1)
    8000433e:	da4fd0ef          	jal	800018e2 <myproc>
    80004342:	5904                	lw	s1,48(a0)
    80004344:	413484b3          	sub	s1,s1,s3
    80004348:	0014b493          	seqz	s1,s1
    8000434c:	69a2                	ld	s3,8(sp)
    8000434e:	bfd9                	j	80004324 <holdingsleep+0x1e>

0000000080004350 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80004350:	1141                	addi	sp,sp,-16
    80004352:	e406                	sd	ra,8(sp)
    80004354:	e022                	sd	s0,0(sp)
    80004356:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80004358:	00004597          	auipc	a1,0x4
    8000435c:	29058593          	addi	a1,a1,656 # 800085e8 <etext+0x5e8>
    80004360:	00056517          	auipc	a0,0x56
    80004364:	b5850513          	addi	a0,a0,-1192 # 80059eb8 <ftable>
    80004368:	811fc0ef          	jal	80000b78 <initlock>
}
    8000436c:	60a2                	ld	ra,8(sp)
    8000436e:	6402                	ld	s0,0(sp)
    80004370:	0141                	addi	sp,sp,16
    80004372:	8082                	ret

0000000080004374 <filealloc>:

// Allocate a file structure.
struct file *
filealloc(void)
{
    80004374:	1101                	addi	sp,sp,-32
    80004376:	ec06                	sd	ra,24(sp)
    80004378:	e822                	sd	s0,16(sp)
    8000437a:	e426                	sd	s1,8(sp)
    8000437c:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    8000437e:	00056517          	auipc	a0,0x56
    80004382:	b3a50513          	addi	a0,a0,-1222 # 80059eb8 <ftable>
    80004386:	873fc0ef          	jal	80000bf8 <acquire>
  for (f = ftable.file; f < ftable.file + NFILE; f++) {
    8000438a:	00056497          	auipc	s1,0x56
    8000438e:	b4648493          	addi	s1,s1,-1210 # 80059ed0 <ftable+0x18>
    80004392:	00057717          	auipc	a4,0x57
    80004396:	ade70713          	addi	a4,a4,-1314 # 8005ae70 <disk>
    if (f->ref == 0) {
    8000439a:	40dc                	lw	a5,4(s1)
    8000439c:	cf89                	beqz	a5,800043b6 <filealloc+0x42>
  for (f = ftable.file; f < ftable.file + NFILE; f++) {
    8000439e:	02848493          	addi	s1,s1,40
    800043a2:	fee49ce3          	bne	s1,a4,8000439a <filealloc+0x26>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    800043a6:	00056517          	auipc	a0,0x56
    800043aa:	b1250513          	addi	a0,a0,-1262 # 80059eb8 <ftable>
    800043ae:	8cffc0ef          	jal	80000c7c <release>
  return 0;
    800043b2:	4481                	li	s1,0
    800043b4:	a809                	j	800043c6 <filealloc+0x52>
      f->ref = 1;
    800043b6:	4785                	li	a5,1
    800043b8:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    800043ba:	00056517          	auipc	a0,0x56
    800043be:	afe50513          	addi	a0,a0,-1282 # 80059eb8 <ftable>
    800043c2:	8bbfc0ef          	jal	80000c7c <release>
}
    800043c6:	8526                	mv	a0,s1
    800043c8:	60e2                	ld	ra,24(sp)
    800043ca:	6442                	ld	s0,16(sp)
    800043cc:	64a2                	ld	s1,8(sp)
    800043ce:	6105                	addi	sp,sp,32
    800043d0:	8082                	ret

00000000800043d2 <filedup>:

// Increment ref count for file f.
struct file *
filedup(struct file *f)
{
    800043d2:	1101                	addi	sp,sp,-32
    800043d4:	ec06                	sd	ra,24(sp)
    800043d6:	e822                	sd	s0,16(sp)
    800043d8:	e426                	sd	s1,8(sp)
    800043da:	1000                	addi	s0,sp,32
    800043dc:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    800043de:	00056517          	auipc	a0,0x56
    800043e2:	ada50513          	addi	a0,a0,-1318 # 80059eb8 <ftable>
    800043e6:	813fc0ef          	jal	80000bf8 <acquire>
  if (f->ref < 1)
    800043ea:	40dc                	lw	a5,4(s1)
    800043ec:	02f05063          	blez	a5,8000440c <filedup+0x3a>
    panic("filedup");
  f->ref++;
    800043f0:	2785                	addiw	a5,a5,1
    800043f2:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    800043f4:	00056517          	auipc	a0,0x56
    800043f8:	ac450513          	addi	a0,a0,-1340 # 80059eb8 <ftable>
    800043fc:	881fc0ef          	jal	80000c7c <release>
  return f;
}
    80004400:	8526                	mv	a0,s1
    80004402:	60e2                	ld	ra,24(sp)
    80004404:	6442                	ld	s0,16(sp)
    80004406:	64a2                	ld	s1,8(sp)
    80004408:	6105                	addi	sp,sp,32
    8000440a:	8082                	ret
    panic("filedup");
    8000440c:	00004517          	auipc	a0,0x4
    80004410:	1e450513          	addi	a0,a0,484 # 800085f0 <etext+0x5f0>
    80004414:	c34fc0ef          	jal	80000848 <panic>

0000000080004418 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80004418:	7139                	addi	sp,sp,-64
    8000441a:	fc06                	sd	ra,56(sp)
    8000441c:	f822                	sd	s0,48(sp)
    8000441e:	f426                	sd	s1,40(sp)
    80004420:	0080                	addi	s0,sp,64
    80004422:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80004424:	00056517          	auipc	a0,0x56
    80004428:	a9450513          	addi	a0,a0,-1388 # 80059eb8 <ftable>
    8000442c:	fccfc0ef          	jal	80000bf8 <acquire>
  if (f->ref < 1)
    80004430:	40dc                	lw	a5,4(s1)
    80004432:	04f05a63          	blez	a5,80004486 <fileclose+0x6e>
    panic("fileclose");
  if (--f->ref > 0) {
    80004436:	37fd                	addiw	a5,a5,-1
    80004438:	c0dc                	sw	a5,4(s1)
    8000443a:	06f04063          	bgtz	a5,8000449a <fileclose+0x82>
    8000443e:	f04a                	sd	s2,32(sp)
    80004440:	ec4e                	sd	s3,24(sp)
    80004442:	e852                	sd	s4,16(sp)
    80004444:	e456                	sd	s5,8(sp)
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80004446:	0004a903          	lw	s2,0(s1)
    8000444a:	0094c783          	lbu	a5,9(s1)
    8000444e:	89be                	mv	s3,a5
    80004450:	689c                	ld	a5,16(s1)
    80004452:	8a3e                	mv	s4,a5
    80004454:	6c9c                	ld	a5,24(s1)
    80004456:	8abe                	mv	s5,a5
  f->ref = 0;
    80004458:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    8000445c:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80004460:	00056517          	auipc	a0,0x56
    80004464:	a5850513          	addi	a0,a0,-1448 # 80059eb8 <ftable>
    80004468:	815fc0ef          	jal	80000c7c <release>

  if (ff.type == FD_PIPE) {
    8000446c:	4785                	li	a5,1
    8000446e:	04f90163          	beq	s2,a5,800044b0 <fileclose+0x98>
    pipeclose(ff.pipe, ff.writable);
  } else if (ff.type == FD_INODE || ff.type == FD_DEVICE) {
    80004472:	ffe9079b          	addiw	a5,s2,-2
    80004476:	4705                	li	a4,1
    80004478:	04f77563          	bgeu	a4,a5,800044c2 <fileclose+0xaa>
    8000447c:	7902                	ld	s2,32(sp)
    8000447e:	69e2                	ld	s3,24(sp)
    80004480:	6a42                	ld	s4,16(sp)
    80004482:	6aa2                	ld	s5,8(sp)
    80004484:	a00d                	j	800044a6 <fileclose+0x8e>
    80004486:	f04a                	sd	s2,32(sp)
    80004488:	ec4e                	sd	s3,24(sp)
    8000448a:	e852                	sd	s4,16(sp)
    8000448c:	e456                	sd	s5,8(sp)
    panic("fileclose");
    8000448e:	00004517          	auipc	a0,0x4
    80004492:	16a50513          	addi	a0,a0,362 # 800085f8 <etext+0x5f8>
    80004496:	bb2fc0ef          	jal	80000848 <panic>
    release(&ftable.lock);
    8000449a:	00056517          	auipc	a0,0x56
    8000449e:	a1e50513          	addi	a0,a0,-1506 # 80059eb8 <ftable>
    800044a2:	fdafc0ef          	jal	80000c7c <release>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
    800044a6:	70e2                	ld	ra,56(sp)
    800044a8:	7442                	ld	s0,48(sp)
    800044aa:	74a2                	ld	s1,40(sp)
    800044ac:	6121                	addi	sp,sp,64
    800044ae:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    800044b0:	85ce                	mv	a1,s3
    800044b2:	8552                	mv	a0,s4
    800044b4:	348000ef          	jal	800047fc <pipeclose>
    800044b8:	7902                	ld	s2,32(sp)
    800044ba:	69e2                	ld	s3,24(sp)
    800044bc:	6a42                	ld	s4,16(sp)
    800044be:	6aa2                	ld	s5,8(sp)
    800044c0:	b7dd                	j	800044a6 <fileclose+0x8e>
    begin_op();
    800044c2:	a9dff0ef          	jal	80003f5e <begin_op>
    iput(ff.ip);
    800044c6:	8556                	mv	a0,s5
    800044c8:	ff9fe0ef          	jal	800034c0 <iput>
    end_op();
    800044cc:	b21ff0ef          	jal	80003fec <end_op>
    800044d0:	7902                	ld	s2,32(sp)
    800044d2:	69e2                	ld	s3,24(sp)
    800044d4:	6a42                	ld	s4,16(sp)
    800044d6:	6aa2                	ld	s5,8(sp)
    800044d8:	b7f9                	j	800044a6 <fileclose+0x8e>

00000000800044da <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    800044da:	715d                	addi	sp,sp,-80
    800044dc:	e486                	sd	ra,72(sp)
    800044de:	e0a2                	sd	s0,64(sp)
    800044e0:	fc26                	sd	s1,56(sp)
    800044e2:	f052                	sd	s4,32(sp)
    800044e4:	0880                	addi	s0,sp,80
    800044e6:	84aa                	mv	s1,a0
    800044e8:	8a2e                	mv	s4,a1
  struct proc *p = myproc();
    800044ea:	bf8fd0ef          	jal	800018e2 <myproc>
  struct stat st;

  if (f->type == FD_INODE || f->type == FD_DEVICE) {
    800044ee:	409c                	lw	a5,0(s1)
    800044f0:	37f9                	addiw	a5,a5,-2
    800044f2:	4705                	li	a4,1
    800044f4:	04f76463          	bltu	a4,a5,8000453c <filestat+0x62>
    800044f8:	f84a                	sd	s2,48(sp)
    800044fa:	f44e                	sd	s3,40(sp)
    800044fc:	892a                	mv	s2,a0
    ilock(f->ip);
    800044fe:	6c88                	ld	a0,24(s1)
    80004500:	db1fe0ef          	jal	800032b0 <ilock>
    stati(f->ip, &st);
    80004504:	fb840993          	addi	s3,s0,-72
    80004508:	85ce                	mv	a1,s3
    8000450a:	6c88                	ld	a0,24(s1)
    8000450c:	9deff0ef          	jal	800036ea <stati>
    iunlock(f->ip);
    80004510:	6c88                	ld	a0,24(s1)
    80004512:	e4dfe0ef          	jal	8000335e <iunlock>
    if (copyout(p->pagetable, p->sz, addr, (char *)&st, sizeof(st)) < 0)
    80004516:	4761                	li	a4,24
    80004518:	86ce                	mv	a3,s3
    8000451a:	8652                	mv	a2,s4
    8000451c:	04893583          	ld	a1,72(s2)
    80004520:	05093503          	ld	a0,80(s2)
    80004524:	808fd0ef          	jal	8000152c <copyout>
    80004528:	41f5551b          	sraiw	a0,a0,0x1f
    8000452c:	7942                	ld	s2,48(sp)
    8000452e:	79a2                	ld	s3,40(sp)
      return -1;
    return 0;
  }
  return -1;
}
    80004530:	60a6                	ld	ra,72(sp)
    80004532:	6406                	ld	s0,64(sp)
    80004534:	74e2                	ld	s1,56(sp)
    80004536:	7a02                	ld	s4,32(sp)
    80004538:	6161                	addi	sp,sp,80
    8000453a:	8082                	ret
  return -1;
    8000453c:	557d                	li	a0,-1
    8000453e:	bfcd                	j	80004530 <filestat+0x56>

0000000080004540 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80004540:	7179                	addi	sp,sp,-48
    80004542:	f406                	sd	ra,40(sp)
    80004544:	f022                	sd	s0,32(sp)
    80004546:	e84a                	sd	s2,16(sp)
    80004548:	1800                	addi	s0,sp,48
  int r = 0;

  if (f->readable == 0 || n < 0)
    8000454a:	00854783          	lbu	a5,8(a0)
    8000454e:	0017b793          	seqz	a5,a5
    80004552:	01f6571b          	srliw	a4,a2,0x1f
    80004556:	8fd9                	or	a5,a5,a4
    80004558:	e3c5                	bnez	a5,800045f8 <fileread+0xb8>
    8000455a:	ec26                	sd	s1,24(sp)
    8000455c:	e44e                	sd	s3,8(sp)
    8000455e:	84aa                	mv	s1,a0
    80004560:	892e                	mv	s2,a1
    80004562:	89b2                	mv	s3,a2
    return -1;

  if (f->type == FD_PIPE) {
    80004564:	411c                	lw	a5,0(a0)
    80004566:	4705                	li	a4,1
    80004568:	04e78363          	beq	a5,a4,800045ae <fileread+0x6e>
    r = piperead(f->pipe, addr, n);
  } else if (f->type == FD_DEVICE) {
    8000456c:	470d                	li	a4,3
    8000456e:	04e78763          	beq	a5,a4,800045bc <fileread+0x7c>
    if (f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if (f->type == FD_INODE) {
    80004572:	4709                	li	a4,2
    80004574:	06e79a63          	bne	a5,a4,800045e8 <fileread+0xa8>
    ilock(f->ip);
    80004578:	6d08                	ld	a0,24(a0)
    8000457a:	d37fe0ef          	jal	800032b0 <ilock>
    if ((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    8000457e:	874e                	mv	a4,s3
    80004580:	5094                	lw	a3,32(s1)
    80004582:	864a                	mv	a2,s2
    80004584:	4585                	li	a1,1
    80004586:	6c88                	ld	a0,24(s1)
    80004588:	990ff0ef          	jal	80003718 <readi>
    8000458c:	892a                	mv	s2,a0
    8000458e:	00a05563          	blez	a0,80004598 <fileread+0x58>
      f->off += r;
    80004592:	509c                	lw	a5,32(s1)
    80004594:	9fa9                	addw	a5,a5,a0
    80004596:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80004598:	6c88                	ld	a0,24(s1)
    8000459a:	dc5fe0ef          	jal	8000335e <iunlock>
    8000459e:	64e2                	ld	s1,24(sp)
    800045a0:	69a2                	ld	s3,8(sp)
  } else {
    panic("fileread");
  }

  return r;
}
    800045a2:	854a                	mv	a0,s2
    800045a4:	70a2                	ld	ra,40(sp)
    800045a6:	7402                	ld	s0,32(sp)
    800045a8:	6942                	ld	s2,16(sp)
    800045aa:	6145                	addi	sp,sp,48
    800045ac:	8082                	ret
    r = piperead(f->pipe, addr, n);
    800045ae:	6908                	ld	a0,16(a0)
    800045b0:	3c6000ef          	jal	80004976 <piperead>
    800045b4:	892a                	mv	s2,a0
    800045b6:	64e2                	ld	s1,24(sp)
    800045b8:	69a2                	ld	s3,8(sp)
    800045ba:	b7e5                	j	800045a2 <fileread+0x62>
    if (f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    800045bc:	02451783          	lh	a5,36(a0)
    800045c0:	03079693          	slli	a3,a5,0x30
    800045c4:	92c1                	srli	a3,a3,0x30
    800045c6:	4725                	li	a4,9
    800045c8:	02d76663          	bltu	a4,a3,800045f4 <fileread+0xb4>
    800045cc:	0792                	slli	a5,a5,0x4
    800045ce:	00056717          	auipc	a4,0x56
    800045d2:	84a70713          	addi	a4,a4,-1974 # 80059e18 <devsw>
    800045d6:	97ba                	add	a5,a5,a4
    800045d8:	639c                	ld	a5,0(a5)
    800045da:	c395                	beqz	a5,800045fe <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    800045dc:	4505                	li	a0,1
    800045de:	9782                	jalr	a5
    800045e0:	892a                	mv	s2,a0
    800045e2:	64e2                	ld	s1,24(sp)
    800045e4:	69a2                	ld	s3,8(sp)
    800045e6:	bf75                	j	800045a2 <fileread+0x62>
    panic("fileread");
    800045e8:	00004517          	auipc	a0,0x4
    800045ec:	02050513          	addi	a0,a0,32 # 80008608 <etext+0x608>
    800045f0:	a58fc0ef          	jal	80000848 <panic>
    800045f4:	64e2                	ld	s1,24(sp)
    800045f6:	69a2                	ld	s3,8(sp)
    return -1;
    800045f8:	57fd                	li	a5,-1
    800045fa:	893e                	mv	s2,a5
    800045fc:	b75d                	j	800045a2 <fileread+0x62>
    800045fe:	64e2                	ld	s1,24(sp)
    80004600:	69a2                	ld	s3,8(sp)
    80004602:	bfdd                	j	800045f8 <fileread+0xb8>

0000000080004604 <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if (f->writable == 0 || n < 0)
    80004604:	00954783          	lbu	a5,9(a0)
    80004608:	0017b793          	seqz	a5,a5
    8000460c:	01f6571b          	srliw	a4,a2,0x1f
    80004610:	8fd9                	or	a5,a5,a4
    80004612:	12079363          	bnez	a5,80004738 <filewrite+0x134>
{
    80004616:	711d                	addi	sp,sp,-96
    80004618:	ec86                	sd	ra,88(sp)
    8000461a:	e8a2                	sd	s0,80(sp)
    8000461c:	e0ca                	sd	s2,64(sp)
    8000461e:	f456                	sd	s5,40(sp)
    80004620:	f05a                	sd	s6,32(sp)
    80004622:	1080                	addi	s0,sp,96
    80004624:	892a                	mv	s2,a0
    80004626:	8b2e                	mv	s6,a1
    80004628:	8ab2                	mv	s5,a2
    return -1;

  if (f->type == FD_PIPE) {
    8000462a:	411c                	lw	a5,0(a0)
    8000462c:	4705                	li	a4,1
    8000462e:	02e78a63          	beq	a5,a4,80004662 <filewrite+0x5e>
    ret = pipewrite(f->pipe, addr, n);
  } else if (f->type == FD_DEVICE) {
    80004632:	470d                	li	a4,3
    80004634:	02e78b63          	beq	a5,a4,8000466a <filewrite+0x66>
    if (f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if (f->type == FD_INODE) {
    80004638:	4709                	li	a4,2
    8000463a:	0ce79763          	bne	a5,a4,80004708 <filewrite+0x104>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    int max = ((MAXOPBLOCKS - 1 - 1 - 2) / 2) * BSIZE;
    int i = 0;
    while (i < n) {
    8000463e:	0ec05363          	blez	a2,80004724 <filewrite+0x120>
    80004642:	e4a6                	sd	s1,72(sp)
    80004644:	fc4e                	sd	s3,56(sp)
    80004646:	f852                	sd	s4,48(sp)
    80004648:	ec5e                	sd	s7,24(sp)
    8000464a:	e862                	sd	s8,16(sp)
    8000464c:	e466                	sd	s9,8(sp)
    int i = 0;
    8000464e:	4a01                	li	s4,0
      int n1 = n - i;
      if (n1 > max)
    80004650:	6ba9                	lui	s7,0xa
    80004652:	800b8b93          	addi	s7,s7,-2048 # 9800 <_entry-0x7fff6800>
    80004656:	67a9                	lui	a5,0xa
    80004658:	8007879b          	addiw	a5,a5,-2048 # 9800 <_entry-0x7fff6800>
    8000465c:	8cbe                	mv	s9,a5
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    8000465e:	4c05                	li	s8,1
    80004660:	a8ad                	j	800046da <filewrite+0xd6>
    ret = pipewrite(f->pipe, addr, n);
    80004662:	6908                	ld	a0,16(a0)
    80004664:	1f6000ef          	jal	8000485a <pipewrite>
    80004668:	a849                	j	800046fa <filewrite+0xf6>
    if (f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    8000466a:	02451783          	lh	a5,36(a0)
    8000466e:	03079693          	slli	a3,a5,0x30
    80004672:	92c1                	srli	a3,a3,0x30
    80004674:	4725                	li	a4,9
    80004676:	0ad76563          	bltu	a4,a3,80004720 <filewrite+0x11c>
    8000467a:	0792                	slli	a5,a5,0x4
    8000467c:	00055717          	auipc	a4,0x55
    80004680:	79c70713          	addi	a4,a4,1948 # 80059e18 <devsw>
    80004684:	97ba                	add	a5,a5,a4
    80004686:	679c                	ld	a5,8(a5)
    80004688:	cfc1                	beqz	a5,80004720 <filewrite+0x11c>
    ret = devsw[f->major].write(1, addr, n);
    8000468a:	4505                	li	a0,1
    8000468c:	9782                	jalr	a5
    8000468e:	a0b5                	j	800046fa <filewrite+0xf6>
      if (n1 > max)
    80004690:	2981                	sext.w	s3,s3
      begin_op();
    80004692:	8cdff0ef          	jal	80003f5e <begin_op>
      ilock(f->ip);
    80004696:	01893503          	ld	a0,24(s2)
    8000469a:	c17fe0ef          	jal	800032b0 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    8000469e:	874e                	mv	a4,s3
    800046a0:	02092683          	lw	a3,32(s2)
    800046a4:	016a0633          	add	a2,s4,s6
    800046a8:	85e2                	mv	a1,s8
    800046aa:	01893503          	ld	a0,24(s2)
    800046ae:	95cff0ef          	jal	8000380a <writei>
    800046b2:	84aa                	mv	s1,a0
    800046b4:	00a05763          	blez	a0,800046c2 <filewrite+0xbe>
        f->off += r;
    800046b8:	02092783          	lw	a5,32(s2)
    800046bc:	9fa9                	addw	a5,a5,a0
    800046be:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    800046c2:	01893503          	ld	a0,24(s2)
    800046c6:	c99fe0ef          	jal	8000335e <iunlock>
      end_op();
    800046ca:	923ff0ef          	jal	80003fec <end_op>

      if (r != n1) {
    800046ce:	00999d63          	bne	s3,s1,800046e8 <filewrite+0xe4>
        // error from writei
        break;
      }
      i += r;
    800046d2:	01448a3b          	addw	s4,s1,s4
    while (i < n) {
    800046d6:	015a5963          	bge	s4,s5,800046e8 <filewrite+0xe4>
      int n1 = n - i;
    800046da:	414a87bb          	subw	a5,s5,s4
    800046de:	89be                	mv	s3,a5
      if (n1 > max)
    800046e0:	fafbd8e3          	bge	s7,a5,80004690 <filewrite+0x8c>
    800046e4:	89e6                	mv	s3,s9
    800046e6:	b76d                	j	80004690 <filewrite+0x8c>
    }
    ret = (i == n ? n : -1);
    800046e8:	054a9063          	bne	s5,s4,80004728 <filewrite+0x124>
    800046ec:	8556                	mv	a0,s5
    800046ee:	64a6                	ld	s1,72(sp)
    800046f0:	79e2                	ld	s3,56(sp)
    800046f2:	7a42                	ld	s4,48(sp)
    800046f4:	6be2                	ld	s7,24(sp)
    800046f6:	6c42                	ld	s8,16(sp)
    800046f8:	6ca2                	ld	s9,8(sp)
  } else {
    panic("filewrite");
  }

  return ret;
}
    800046fa:	60e6                	ld	ra,88(sp)
    800046fc:	6446                	ld	s0,80(sp)
    800046fe:	6906                	ld	s2,64(sp)
    80004700:	7aa2                	ld	s5,40(sp)
    80004702:	7b02                	ld	s6,32(sp)
    80004704:	6125                	addi	sp,sp,96
    80004706:	8082                	ret
    80004708:	e4a6                	sd	s1,72(sp)
    8000470a:	fc4e                	sd	s3,56(sp)
    8000470c:	f852                	sd	s4,48(sp)
    8000470e:	ec5e                	sd	s7,24(sp)
    80004710:	e862                	sd	s8,16(sp)
    80004712:	e466                	sd	s9,8(sp)
    panic("filewrite");
    80004714:	00004517          	auipc	a0,0x4
    80004718:	f0450513          	addi	a0,a0,-252 # 80008618 <etext+0x618>
    8000471c:	92cfc0ef          	jal	80000848 <panic>
    return -1;
    80004720:	557d                	li	a0,-1
    80004722:	bfe1                	j	800046fa <filewrite+0xf6>
    ret = (i == n ? n : -1);
    80004724:	8532                	mv	a0,a2
    80004726:	bfd1                	j	800046fa <filewrite+0xf6>
    80004728:	557d                	li	a0,-1
    8000472a:	64a6                	ld	s1,72(sp)
    8000472c:	79e2                	ld	s3,56(sp)
    8000472e:	7a42                	ld	s4,48(sp)
    80004730:	6be2                	ld	s7,24(sp)
    80004732:	6c42                	ld	s8,16(sp)
    80004734:	6ca2                	ld	s9,8(sp)
    80004736:	b7d1                	j	800046fa <filewrite+0xf6>
    return -1;
    80004738:	557d                	li	a0,-1
}
    8000473a:	8082                	ret

000000008000473c <pipealloc>:
  int writeopen; // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    8000473c:	7179                	addi	sp,sp,-48
    8000473e:	f406                	sd	ra,40(sp)
    80004740:	f022                	sd	s0,32(sp)
    80004742:	ec26                	sd	s1,24(sp)
    80004744:	e052                	sd	s4,0(sp)
    80004746:	1800                	addi	s0,sp,48
    80004748:	84aa                	mv	s1,a0
    8000474a:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    8000474c:	0005b023          	sd	zero,0(a1)
    80004750:	00053023          	sd	zero,0(a0)
  if ((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80004754:	c21ff0ef          	jal	80004374 <filealloc>
    80004758:	e088                	sd	a0,0(s1)
    8000475a:	c549                	beqz	a0,800047e4 <pipealloc+0xa8>
    8000475c:	c19ff0ef          	jal	80004374 <filealloc>
    80004760:	00aa3023          	sd	a0,0(s4)
    80004764:	cd25                	beqz	a0,800047dc <pipealloc+0xa0>
    80004766:	e84a                	sd	s2,16(sp)
    goto bad;
  if ((pi = (struct pipe *)kalloc()) == 0)
    80004768:	bb6fc0ef          	jal	80000b1e <kalloc>
    8000476c:	892a                	mv	s2,a0
    8000476e:	c12d                	beqz	a0,800047d0 <pipealloc+0x94>
    80004770:	e44e                	sd	s3,8(sp)
    goto bad;
  pi->readopen = 1;
    80004772:	4985                	li	s3,1
    80004774:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80004778:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    8000477c:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80004780:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80004784:	00004597          	auipc	a1,0x4
    80004788:	ea458593          	addi	a1,a1,-348 # 80008628 <etext+0x628>
    8000478c:	becfc0ef          	jal	80000b78 <initlock>
  (*f0)->type = FD_PIPE;
    80004790:	609c                	ld	a5,0(s1)
    80004792:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80004796:	609c                	ld	a5,0(s1)
    80004798:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    8000479c:	609c                	ld	a5,0(s1)
    8000479e:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    800047a2:	609c                	ld	a5,0(s1)
    800047a4:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    800047a8:	000a3783          	ld	a5,0(s4)
    800047ac:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    800047b0:	000a3783          	ld	a5,0(s4)
    800047b4:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    800047b8:	000a3783          	ld	a5,0(s4)
    800047bc:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    800047c0:	000a3783          	ld	a5,0(s4)
    800047c4:	0127b823          	sd	s2,16(a5)
  return 0;
    800047c8:	4501                	li	a0,0
    800047ca:	6942                	ld	s2,16(sp)
    800047cc:	69a2                	ld	s3,8(sp)
    800047ce:	a00d                	j	800047f0 <pipealloc+0xb4>

bad:
  if (pi)
    kfree((char *)pi);
  if (*f0)
    800047d0:	6088                	ld	a0,0(s1)
    800047d2:	c119                	beqz	a0,800047d8 <pipealloc+0x9c>
    800047d4:	6942                	ld	s2,16(sp)
    800047d6:	a029                	j	800047e0 <pipealloc+0xa4>
    800047d8:	6942                	ld	s2,16(sp)
    800047da:	a029                	j	800047e4 <pipealloc+0xa8>
    800047dc:	6088                	ld	a0,0(s1)
    800047de:	c901                	beqz	a0,800047ee <pipealloc+0xb2>
    fileclose(*f0);
    800047e0:	c39ff0ef          	jal	80004418 <fileclose>
  if (*f1)
    800047e4:	000a3503          	ld	a0,0(s4)
    800047e8:	c119                	beqz	a0,800047ee <pipealloc+0xb2>
    fileclose(*f1);
    800047ea:	c2fff0ef          	jal	80004418 <fileclose>
  return -1;
    800047ee:	557d                	li	a0,-1
}
    800047f0:	70a2                	ld	ra,40(sp)
    800047f2:	7402                	ld	s0,32(sp)
    800047f4:	64e2                	ld	s1,24(sp)
    800047f6:	6a02                	ld	s4,0(sp)
    800047f8:	6145                	addi	sp,sp,48
    800047fa:	8082                	ret

00000000800047fc <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    800047fc:	1101                	addi	sp,sp,-32
    800047fe:	ec06                	sd	ra,24(sp)
    80004800:	e822                	sd	s0,16(sp)
    80004802:	e426                	sd	s1,8(sp)
    80004804:	e04a                	sd	s2,0(sp)
    80004806:	1000                	addi	s0,sp,32
    80004808:	84aa                	mv	s1,a0
    8000480a:	892e                	mv	s2,a1
  acquire(&pi->lock);
    8000480c:	becfc0ef          	jal	80000bf8 <acquire>
  if (writable) {
    80004810:	02090763          	beqz	s2,8000483e <pipeclose+0x42>
    pi->writeopen = 0;
    80004814:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80004818:	21848513          	addi	a0,s1,536
    8000481c:	f3afd0ef          	jal	80001f56 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if (pi->readopen == 0 && pi->writeopen == 0) {
    80004820:	2204a783          	lw	a5,544(s1)
    80004824:	e781                	bnez	a5,8000482c <pipeclose+0x30>
    80004826:	2244a783          	lw	a5,548(s1)
    8000482a:	c38d                	beqz	a5,8000484c <pipeclose+0x50>
    release(&pi->lock);
    kfree((char *)pi);
  } else
    release(&pi->lock);
    8000482c:	8526                	mv	a0,s1
    8000482e:	c4efc0ef          	jal	80000c7c <release>
}
    80004832:	60e2                	ld	ra,24(sp)
    80004834:	6442                	ld	s0,16(sp)
    80004836:	64a2                	ld	s1,8(sp)
    80004838:	6902                	ld	s2,0(sp)
    8000483a:	6105                	addi	sp,sp,32
    8000483c:	8082                	ret
    pi->readopen = 0;
    8000483e:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80004842:	21c48513          	addi	a0,s1,540
    80004846:	f10fd0ef          	jal	80001f56 <wakeup>
    8000484a:	bfd9                	j	80004820 <pipeclose+0x24>
    release(&pi->lock);
    8000484c:	8526                	mv	a0,s1
    8000484e:	c2efc0ef          	jal	80000c7c <release>
    kfree((char *)pi);
    80004852:	8526                	mv	a0,s1
    80004854:	9e2fc0ef          	jal	80000a36 <kfree>
    80004858:	bfe9                	j	80004832 <pipeclose+0x36>

000000008000485a <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    8000485a:	7159                	addi	sp,sp,-112
    8000485c:	f486                	sd	ra,104(sp)
    8000485e:	f0a2                	sd	s0,96(sp)
    80004860:	eca6                	sd	s1,88(sp)
    80004862:	e8ca                	sd	s2,80(sp)
    80004864:	e4ce                	sd	s3,72(sp)
    80004866:	e0d2                	sd	s4,64(sp)
    80004868:	fc56                	sd	s5,56(sp)
    8000486a:	1880                	addi	s0,sp,112
    8000486c:	84aa                	mv	s1,a0
    8000486e:	8aae                	mv	s5,a1
    80004870:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80004872:	870fd0ef          	jal	800018e2 <myproc>
    80004876:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80004878:	8526                	mv	a0,s1
    8000487a:	b7efc0ef          	jal	80000bf8 <acquire>
  while (i < n) {
    8000487e:	0f405a63          	blez	s4,80004972 <pipewrite+0x118>
    80004882:	f85a                	sd	s6,48(sp)
    80004884:	f45e                	sd	s7,40(sp)
    80004886:	f062                	sd	s8,32(sp)
    80004888:	ec66                	sd	s9,24(sp)
    8000488a:	e86a                	sd	s10,16(sp)
  int i = 0;
    8000488c:	4901                	li	s2,0
      release(&pi->lock);
      sleep();
      acquire(&pi->lock);
    } else {
      char ch;
      if (copyin(pr->pagetable, pr->sz, &ch, addr + i, 1) == -1) {
    8000488e:	f9f40c13          	addi	s8,s0,-97
    80004892:	4b85                	li	s7,1
    80004894:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80004896:	21848d13          	addi	s10,s1,536
      sleep_prepare(&pi->nwrite);
    8000489a:	21c48c93          	addi	s9,s1,540
    8000489e:	a0a1                	j	800048e6 <pipewrite+0x8c>
      release(&pi->lock);
    800048a0:	8526                	mv	a0,s1
    800048a2:	bdafc0ef          	jal	80000c7c <release>
      return -1;
    800048a6:	597d                	li	s2,-1
    800048a8:	7b42                	ld	s6,48(sp)
    800048aa:	7ba2                	ld	s7,40(sp)
    800048ac:	7c02                	ld	s8,32(sp)
    800048ae:	6ce2                	ld	s9,24(sp)
    800048b0:	6d42                	ld	s10,16(sp)
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    800048b2:	854a                	mv	a0,s2
    800048b4:	70a6                	ld	ra,104(sp)
    800048b6:	7406                	ld	s0,96(sp)
    800048b8:	64e6                	ld	s1,88(sp)
    800048ba:	6946                	ld	s2,80(sp)
    800048bc:	69a6                	ld	s3,72(sp)
    800048be:	6a06                	ld	s4,64(sp)
    800048c0:	7ae2                	ld	s5,56(sp)
    800048c2:	6165                	addi	sp,sp,112
    800048c4:	8082                	ret
      wakeup(&pi->nread);
    800048c6:	856a                	mv	a0,s10
    800048c8:	e8efd0ef          	jal	80001f56 <wakeup>
      sleep_prepare(&pi->nwrite);
    800048cc:	8566                	mv	a0,s9
    800048ce:	e1cfd0ef          	jal	80001eea <sleep_prepare>
      release(&pi->lock);
    800048d2:	8526                	mv	a0,s1
    800048d4:	ba8fc0ef          	jal	80000c7c <release>
      sleep();
    800048d8:	e4efd0ef          	jal	80001f26 <sleep>
      acquire(&pi->lock);
    800048dc:	8526                	mv	a0,s1
    800048de:	b1afc0ef          	jal	80000bf8 <acquire>
  while (i < n) {
    800048e2:	07495b63          	bge	s2,s4,80004958 <pipewrite+0xfe>
    if (pi->readopen == 0 || killed(pr)) {
    800048e6:	2204a783          	lw	a5,544(s1)
    800048ea:	dbdd                	beqz	a5,800048a0 <pipewrite+0x46>
    800048ec:	854e                	mv	a0,s3
    800048ee:	857fd0ef          	jal	80002144 <killed>
    800048f2:	f55d                	bnez	a0,800048a0 <pipewrite+0x46>
    if (pi->nwrite == pi->nread + PIPESIZE) { //DOC: pipewrite-full
    800048f4:	2184a783          	lw	a5,536(s1)
    800048f8:	21c4a703          	lw	a4,540(s1)
    800048fc:	2007879b          	addiw	a5,a5,512
    80004900:	fcf703e3          	beq	a4,a5,800048c6 <pipewrite+0x6c>
      if (copyin(pr->pagetable, pr->sz, &ch, addr + i, 1) == -1) {
    80004904:	875e                	mv	a4,s7
    80004906:	015906b3          	add	a3,s2,s5
    8000490a:	8662                	mv	a2,s8
    8000490c:	0489b583          	ld	a1,72(s3)
    80004910:	0509b503          	ld	a0,80(s3)
    80004914:	cd9fc0ef          	jal	800015ec <copyin>
    80004918:	03650163          	beq	a0,s6,8000493a <pipewrite+0xe0>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    8000491c:	21c4a783          	lw	a5,540(s1)
    80004920:	0017871b          	addiw	a4,a5,1
    80004924:	20e4ae23          	sw	a4,540(s1)
    80004928:	1ff7f793          	andi	a5,a5,511
    8000492c:	97a6                	add	a5,a5,s1
    8000492e:	f9f44703          	lbu	a4,-97(s0)
    80004932:	00e78c23          	sb	a4,24(a5)
      i++;
    80004936:	2905                	addiw	s2,s2,1
    80004938:	b76d                	j	800048e2 <pipewrite+0x88>
        if (i == 0)
    8000493a:	00090863          	beqz	s2,8000494a <pipewrite+0xf0>
    8000493e:	7b42                	ld	s6,48(sp)
    80004940:	7ba2                	ld	s7,40(sp)
    80004942:	7c02                	ld	s8,32(sp)
    80004944:	6ce2                	ld	s9,24(sp)
    80004946:	6d42                	ld	s10,16(sp)
    80004948:	a829                	j	80004962 <pipewrite+0x108>
          i = -1;
    8000494a:	892a                	mv	s2,a0
        break;
    8000494c:	7b42                	ld	s6,48(sp)
    8000494e:	7ba2                	ld	s7,40(sp)
    80004950:	7c02                	ld	s8,32(sp)
    80004952:	6ce2                	ld	s9,24(sp)
    80004954:	6d42                	ld	s10,16(sp)
    80004956:	a031                	j	80004962 <pipewrite+0x108>
    80004958:	7b42                	ld	s6,48(sp)
    8000495a:	7ba2                	ld	s7,40(sp)
    8000495c:	7c02                	ld	s8,32(sp)
    8000495e:	6ce2                	ld	s9,24(sp)
    80004960:	6d42                	ld	s10,16(sp)
  wakeup(&pi->nread);
    80004962:	21848513          	addi	a0,s1,536
    80004966:	df0fd0ef          	jal	80001f56 <wakeup>
  release(&pi->lock);
    8000496a:	8526                	mv	a0,s1
    8000496c:	b10fc0ef          	jal	80000c7c <release>
  return i;
    80004970:	b789                	j	800048b2 <pipewrite+0x58>
  int i = 0;
    80004972:	4901                	li	s2,0
    80004974:	b7fd                	j	80004962 <pipewrite+0x108>

0000000080004976 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80004976:	711d                	addi	sp,sp,-96
    80004978:	ec86                	sd	ra,88(sp)
    8000497a:	e8a2                	sd	s0,80(sp)
    8000497c:	e4a6                	sd	s1,72(sp)
    8000497e:	e0ca                	sd	s2,64(sp)
    80004980:	fc4e                	sd	s3,56(sp)
    80004982:	f852                	sd	s4,48(sp)
    80004984:	f456                	sd	s5,40(sp)
    80004986:	1080                	addi	s0,sp,96
    80004988:	84aa                	mv	s1,a0
    8000498a:	89ae                	mv	s3,a1
    8000498c:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    8000498e:	f55fc0ef          	jal	800018e2 <myproc>
    80004992:	892a                	mv	s2,a0
  char ch;

  acquire(&pi->lock);
    80004994:	8526                	mv	a0,s1
    80004996:	a62fc0ef          	jal	80000bf8 <acquire>
  while (pi->nread == pi->nwrite && pi->writeopen) { //DOC: pipe-empty
    8000499a:	2184a703          	lw	a4,536(s1)
    8000499e:	21c4a783          	lw	a5,540(s1)
    if (killed(pr)) {
      release(&pi->lock);
      return -1;
    }
    sleep_prepare(&pi->nread); //DOC: piperead-sleep
    800049a2:	21848a13          	addi	s4,s1,536
  while (pi->nread == pi->nwrite && pi->writeopen) { //DOC: pipe-empty
    800049a6:	02f71a63          	bne	a4,a5,800049da <piperead+0x64>
    800049aa:	2244a783          	lw	a5,548(s1)
    800049ae:	c795                	beqz	a5,800049da <piperead+0x64>
    if (killed(pr)) {
    800049b0:	854a                	mv	a0,s2
    800049b2:	f92fd0ef          	jal	80002144 <killed>
    800049b6:	e149                	bnez	a0,80004a38 <piperead+0xc2>
    sleep_prepare(&pi->nread); //DOC: piperead-sleep
    800049b8:	8552                	mv	a0,s4
    800049ba:	d30fd0ef          	jal	80001eea <sleep_prepare>
    release(&pi->lock);
    800049be:	8526                	mv	a0,s1
    800049c0:	abcfc0ef          	jal	80000c7c <release>
    sleep();
    800049c4:	d62fd0ef          	jal	80001f26 <sleep>
    acquire(&pi->lock);
    800049c8:	8526                	mv	a0,s1
    800049ca:	a2efc0ef          	jal	80000bf8 <acquire>
  while (pi->nread == pi->nwrite && pi->writeopen) { //DOC: pipe-empty
    800049ce:	2184a703          	lw	a4,536(s1)
    800049d2:	21c4a783          	lw	a5,540(s1)
    800049d6:	fcf70ae3          	beq	a4,a5,800049aa <piperead+0x34>
  }
  for (i = 0; i < n; i++) { //DOC: piperead-copy
    800049da:	07505a63          	blez	s5,80004a4e <piperead+0xd8>
    800049de:	f05a                	sd	s6,32(sp)
    800049e0:	ec5e                	sd	s7,24(sp)
    800049e2:	e862                	sd	s8,16(sp)
    800049e4:	4a01                	li	s4,0
    if (pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread % PIPESIZE];
    if (copyout(pr->pagetable, pr->sz, addr + i, &ch, 1) == -1) {
    800049e6:	faf40c13          	addi	s8,s0,-81
    800049ea:	4b85                	li	s7,1
    800049ec:	5b7d                	li	s6,-1
    if (pi->nread == pi->nwrite)
    800049ee:	2184a783          	lw	a5,536(s1)
    800049f2:	21c4a703          	lw	a4,540(s1)
    800049f6:	06f70363          	beq	a4,a5,80004a5c <piperead+0xe6>
    ch = pi->data[pi->nread % PIPESIZE];
    800049fa:	1ff7f793          	andi	a5,a5,511
    800049fe:	97a6                	add	a5,a5,s1
    80004a00:	0187c783          	lbu	a5,24(a5)
    80004a04:	faf407a3          	sb	a5,-81(s0)
    if (copyout(pr->pagetable, pr->sz, addr + i, &ch, 1) == -1) {
    80004a08:	875e                	mv	a4,s7
    80004a0a:	86e2                	mv	a3,s8
    80004a0c:	864e                	mv	a2,s3
    80004a0e:	04893583          	ld	a1,72(s2)
    80004a12:	05093503          	ld	a0,80(s2)
    80004a16:	b17fc0ef          	jal	8000152c <copyout>
    80004a1a:	03650463          	beq	a0,s6,80004a42 <piperead+0xcc>
      if (i == 0)
        i = -1;
      break;
    }
    pi->nread++;
    80004a1e:	2184a783          	lw	a5,536(s1)
    80004a22:	2785                	addiw	a5,a5,1
    80004a24:	20f4ac23          	sw	a5,536(s1)
  for (i = 0; i < n; i++) { //DOC: piperead-copy
    80004a28:	2a05                	addiw	s4,s4,1
    80004a2a:	0985                	addi	s3,s3,1
    80004a2c:	fd4a91e3          	bne	s5,s4,800049ee <piperead+0x78>
    80004a30:	7b02                	ld	s6,32(sp)
    80004a32:	6be2                	ld	s7,24(sp)
    80004a34:	6c42                	ld	s8,16(sp)
    80004a36:	a035                	j	80004a62 <piperead+0xec>
      release(&pi->lock);
    80004a38:	8526                	mv	a0,s1
    80004a3a:	a42fc0ef          	jal	80000c7c <release>
      return -1;
    80004a3e:	5a7d                	li	s4,-1
    80004a40:	a805                	j	80004a70 <piperead+0xfa>
      if (i == 0)
    80004a42:	000a0863          	beqz	s4,80004a52 <piperead+0xdc>
    80004a46:	7b02                	ld	s6,32(sp)
    80004a48:	6be2                	ld	s7,24(sp)
    80004a4a:	6c42                	ld	s8,16(sp)
    80004a4c:	a819                	j	80004a62 <piperead+0xec>
  for (i = 0; i < n; i++) { //DOC: piperead-copy
    80004a4e:	4a01                	li	s4,0
    80004a50:	a809                	j	80004a62 <piperead+0xec>
        i = -1;
    80004a52:	8a2a                	mv	s4,a0
    80004a54:	7b02                	ld	s6,32(sp)
    80004a56:	6be2                	ld	s7,24(sp)
    80004a58:	6c42                	ld	s8,16(sp)
    80004a5a:	a021                	j	80004a62 <piperead+0xec>
    80004a5c:	7b02                	ld	s6,32(sp)
    80004a5e:	6be2                	ld	s7,24(sp)
    80004a60:	6c42                	ld	s8,16(sp)
  }
  wakeup(&pi->nwrite); //DOC: piperead-wakeup
    80004a62:	21c48513          	addi	a0,s1,540
    80004a66:	cf0fd0ef          	jal	80001f56 <wakeup>
  release(&pi->lock);
    80004a6a:	8526                	mv	a0,s1
    80004a6c:	a10fc0ef          	jal	80000c7c <release>
  return i;
}
    80004a70:	8552                	mv	a0,s4
    80004a72:	60e6                	ld	ra,88(sp)
    80004a74:	6446                	ld	s0,80(sp)
    80004a76:	64a6                	ld	s1,72(sp)
    80004a78:	6906                	ld	s2,64(sp)
    80004a7a:	79e2                	ld	s3,56(sp)
    80004a7c:	7a42                	ld	s4,48(sp)
    80004a7e:	7aa2                	ld	s5,40(sp)
    80004a80:	6125                	addi	sp,sp,96
    80004a82:	8082                	ret

0000000080004a84 <flags2perm>:
static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

// map ELF permissions to PTE permission bits.
int
flags2perm(int flags)
{
    80004a84:	1141                	addi	sp,sp,-16
    80004a86:	e406                	sd	ra,8(sp)
    80004a88:	e022                	sd	s0,0(sp)
    80004a8a:	0800                	addi	s0,sp,16
    80004a8c:	87aa                	mv	a5,a0
  int perm = 0;
  if (flags & 0x1)
    80004a8e:	0035151b          	slliw	a0,a0,0x3
    80004a92:	8921                	andi	a0,a0,8
    perm = PTE_X;
  if (flags & 0x2)
    80004a94:	8b89                	andi	a5,a5,2
    80004a96:	c399                	beqz	a5,80004a9c <flags2perm+0x18>
    perm |= PTE_W;
    80004a98:	00456513          	ori	a0,a0,4
  return perm;
}
    80004a9c:	60a2                	ld	ra,8(sp)
    80004a9e:	6402                	ld	s0,0(sp)
    80004aa0:	0141                	addi	sp,sp,16
    80004aa2:	8082                	ret

0000000080004aa4 <kexec>:
//
// the implementation of the exec() system call
//
int
kexec(char *path, char **argv)
{
    80004aa4:	df010113          	addi	sp,sp,-528
    80004aa8:	20113423          	sd	ra,520(sp)
    80004aac:	20813023          	sd	s0,512(sp)
    80004ab0:	ffa6                	sd	s1,504(sp)
    80004ab2:	fbca                	sd	s2,496(sp)
    80004ab4:	0c00                	addi	s0,sp,528
    80004ab6:	892a                	mv	s2,a0
    80004ab8:	e0a43023          	sd	a0,-512(s0)
    80004abc:	deb43c23          	sd	a1,-520(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80004ac0:	e23fc0ef          	jal	800018e2 <myproc>
    80004ac4:	84aa                	mv	s1,a0

  begin_op();
    80004ac6:	c98ff0ef          	jal	80003f5e <begin_op>

  // Open the executable file.
  if ((ip = namei(path)) == 0) {
    80004aca:	854a                	mv	a0,s2
    80004acc:	90aff0ef          	jal	80003bd6 <namei>
    80004ad0:	c931                	beqz	a0,80004b24 <kexec+0x80>
    80004ad2:	f3d2                	sd	s4,480(sp)
    80004ad4:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004ad6:	fdafe0ef          	jal	800032b0 <ilock>

  // Read the ELF header.
  if (readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004ada:	04000713          	li	a4,64
    80004ade:	4681                	li	a3,0
    80004ae0:	e5040613          	addi	a2,s0,-432
    80004ae4:	4581                	li	a1,0
    80004ae6:	8552                	mv	a0,s4
    80004ae8:	c31fe0ef          	jal	80003718 <readi>
    80004aec:	04000793          	li	a5,64
    80004af0:	00f51a63          	bne	a0,a5,80004b04 <kexec+0x60>
    goto bad;

  // Is this really an ELF file?
  if (elf.magic != ELF_MAGIC)
    80004af4:	e5042703          	lw	a4,-432(s0)
    80004af8:	464c47b7          	lui	a5,0x464c4
    80004afc:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004b00:	02f70563          	beq	a4,a5,80004b2a <kexec+0x86>

bad:
  if (pagetable)
    proc_freepagetable(pagetable, sz);
  if (ip) {
    iunlockput(ip);
    80004b04:	8552                	mv	a0,s4
    80004b06:	a8dfe0ef          	jal	80003592 <iunlockput>
    end_op();
    80004b0a:	ce2ff0ef          	jal	80003fec <end_op>
    80004b0e:	7a1e                	ld	s4,480(sp)
    return -1;
    80004b10:	557d                	li	a0,-1
  }
  return -1;
}
    80004b12:	20813083          	ld	ra,520(sp)
    80004b16:	20013403          	ld	s0,512(sp)
    80004b1a:	74fe                	ld	s1,504(sp)
    80004b1c:	795e                	ld	s2,496(sp)
    80004b1e:	21010113          	addi	sp,sp,528
    80004b22:	8082                	ret
    end_op();
    80004b24:	cc8ff0ef          	jal	80003fec <end_op>
    return -1;
    80004b28:	b7e5                	j	80004b10 <kexec+0x6c>
    80004b2a:	ebda                	sd	s6,464(sp)
  if ((pagetable = proc_pagetable(p)) == 0)
    80004b2c:	8526                	mv	a0,s1
    80004b2e:	ecbfc0ef          	jal	800019f8 <proc_pagetable>
    80004b32:	8b2a                	mv	s6,a0
    80004b34:	26050263          	beqz	a0,80004d98 <kexec+0x2f4>
    80004b38:	f7ce                	sd	s3,488(sp)
    80004b3a:	efd6                	sd	s5,472(sp)
    80004b3c:	e7de                	sd	s7,456(sp)
    80004b3e:	e3e2                	sd	s8,448(sp)
    80004b40:	ff66                	sd	s9,440(sp)
    80004b42:	fb6a                	sd	s10,432(sp)
  for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
    80004b44:	e8845783          	lhu	a5,-376(s0)
    80004b48:	12078763          	beqz	a5,80004c76 <kexec+0x1d2>
    80004b4c:	f76e                	sd	s11,424(sp)
    80004b4e:	e7042683          	lw	a3,-400(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004b52:	4901                	li	s2,0
  for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
    80004b54:	4d01                	li	s10,0
    if (readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004b56:	03800d93          	li	s11,56

  for (i = 0; i < sz; i += PGSIZE) {
    pa = walkaddr(pagetable, va + i);
    if (pa == 0)
      panic("loadseg: address should exist");
    if (sz - i < PGSIZE)
    80004b5a:	6c85                	lui	s9,0x1
    80004b5c:	6a85                	lui	s5,0x1
    80004b5e:	a085                	j	80004bbe <kexec+0x11a>
      panic("loadseg: address should exist");
    80004b60:	00004517          	auipc	a0,0x4
    80004b64:	ad050513          	addi	a0,a0,-1328 # 80008630 <etext+0x630>
    80004b68:	ce1fb0ef          	jal	80000848 <panic>
    if (sz - i < PGSIZE)
    80004b6c:	2901                	sext.w	s2,s2
      n = sz - i;
    else
      n = PGSIZE;
    if (readi(ip, 0, (uint64)pa, offset + i, n) != n)
    80004b6e:	874a                	mv	a4,s2
    80004b70:	009b86bb          	addw	a3,s7,s1
    80004b74:	4581                	li	a1,0
    80004b76:	8552                	mv	a0,s4
    80004b78:	ba1fe0ef          	jal	80003718 <readi>
    80004b7c:	22a91263          	bne	s2,a0,80004da0 <kexec+0x2fc>
  for (i = 0; i < sz; i += PGSIZE) {
    80004b80:	009a84bb          	addw	s1,s5,s1
    80004b84:	0334f263          	bgeu	s1,s3,80004ba8 <kexec+0x104>
    pa = walkaddr(pagetable, va + i);
    80004b88:	02049593          	slli	a1,s1,0x20
    80004b8c:	9181                	srli	a1,a1,0x20
    80004b8e:	95e2                	add	a1,a1,s8
    80004b90:	855a                	mv	a0,s6
    80004b92:	c46fc0ef          	jal	80000fd8 <walkaddr>
    80004b96:	862a                	mv	a2,a0
    if (pa == 0)
    80004b98:	d561                	beqz	a0,80004b60 <kexec+0xbc>
    if (sz - i < PGSIZE)
    80004b9a:	409987bb          	subw	a5,s3,s1
    80004b9e:	893e                	mv	s2,a5
    80004ba0:	fcfcf6e3          	bgeu	s9,a5,80004b6c <kexec+0xc8>
    80004ba4:	8956                	mv	s2,s5
    80004ba6:	b7d9                	j	80004b6c <kexec+0xc8>
    sz = sz1;
    80004ba8:	df043903          	ld	s2,-528(s0)
  for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
    80004bac:	2d05                	addiw	s10,s10,1
    80004bae:	e0843783          	ld	a5,-504(s0)
    80004bb2:	0387869b          	addiw	a3,a5,56
    80004bb6:	e8845783          	lhu	a5,-376(s0)
    80004bba:	06fd5863          	bge	s10,a5,80004c2a <kexec+0x186>
    if (readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004bbe:	e0d43423          	sd	a3,-504(s0)
    80004bc2:	876e                	mv	a4,s11
    80004bc4:	e1840613          	addi	a2,s0,-488
    80004bc8:	4581                	li	a1,0
    80004bca:	8552                	mv	a0,s4
    80004bcc:	b4dfe0ef          	jal	80003718 <readi>
    80004bd0:	1db51663          	bne	a0,s11,80004d9c <kexec+0x2f8>
    if (ph.type != ELF_PROG_LOAD)
    80004bd4:	e1842783          	lw	a5,-488(s0)
    80004bd8:	4705                	li	a4,1
    80004bda:	fce799e3          	bne	a5,a4,80004bac <kexec+0x108>
    if (ph.memsz < ph.filesz)
    80004bde:	e4043483          	ld	s1,-448(s0)
    80004be2:	e3843783          	ld	a5,-456(s0)
    80004be6:	1af4eb63          	bltu	s1,a5,80004d9c <kexec+0x2f8>
    if (ph.vaddr + ph.memsz < ph.vaddr)
    80004bea:	e2843783          	ld	a5,-472(s0)
    80004bee:	94be                	add	s1,s1,a5
    80004bf0:	1af4e663          	bltu	s1,a5,80004d9c <kexec+0x2f8>
    if (ph.vaddr % PGSIZE != 0)
    80004bf4:	17d2                	slli	a5,a5,0x34
    80004bf6:	1a079363          	bnez	a5,80004d9c <kexec+0x2f8>
    if ((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz,
    80004bfa:	e1c42503          	lw	a0,-484(s0)
    80004bfe:	e87ff0ef          	jal	80004a84 <flags2perm>
    80004c02:	86aa                	mv	a3,a0
    80004c04:	8626                	mv	a2,s1
    80004c06:	85ca                	mv	a1,s2
    80004c08:	855a                	mv	a0,s6
    80004c0a:	e9cfc0ef          	jal	800012a6 <uvmalloc>
    80004c0e:	dea43823          	sd	a0,-528(s0)
    80004c12:	18050563          	beqz	a0,80004d9c <kexec+0x2f8>
    if (loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004c16:	e3842983          	lw	s3,-456(s0)
  for (i = 0; i < sz; i += PGSIZE) {
    80004c1a:	f80987e3          	beqz	s3,80004ba8 <kexec+0x104>
    if (loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004c1e:	e2843c03          	ld	s8,-472(s0)
    80004c22:	e2042b83          	lw	s7,-480(s0)
  for (i = 0; i < sz; i += PGSIZE) {
    80004c26:	4481                	li	s1,0
    80004c28:	b785                	j	80004b88 <kexec+0xe4>
    80004c2a:	7dba                	ld	s11,424(sp)
  iunlockput(ip);
    80004c2c:	8552                	mv	a0,s4
    80004c2e:	965fe0ef          	jal	80003592 <iunlockput>
  end_op();
    80004c32:	bbaff0ef          	jal	80003fec <end_op>
  p = myproc();
    80004c36:	cadfc0ef          	jal	800018e2 <myproc>
    80004c3a:	89aa                	mv	s3,a0
  uint64 oldsz = p->sz;
    80004c3c:	04853a03          	ld	s4,72(a0)
  sz = PGROUNDUP(sz);
    80004c40:	6485                	lui	s1,0x1
    80004c42:	14fd                	addi	s1,s1,-1 # fff <_entry-0x7ffff001>
    80004c44:	94ca                	add	s1,s1,s2
    80004c46:	77fd                	lui	a5,0xfffff
    80004c48:	8cfd                	and	s1,s1,a5
  if ((sz1 = uvmalloc(pagetable, sz, sz + (USERSTACK + 1) * PGSIZE, PTE_W)) ==
    80004c4a:	4691                	li	a3,4
    80004c4c:	6609                	lui	a2,0x2
    80004c4e:	9626                	add	a2,a2,s1
    80004c50:	85a6                	mv	a1,s1
    80004c52:	855a                	mv	a0,s6
    80004c54:	e52fc0ef          	jal	800012a6 <uvmalloc>
    80004c58:	8aaa                	mv	s5,a0
    80004c5a:	e105                	bnez	a0,80004c7a <kexec+0x1d6>
    proc_freepagetable(pagetable, sz);
    80004c5c:	85a6                	mv	a1,s1
    80004c5e:	855a                	mv	a0,s6
    80004c60:	e1bfc0ef          	jal	80001a7a <proc_freepagetable>
  if (ip) {
    80004c64:	79be                	ld	s3,488(sp)
    80004c66:	7a1e                	ld	s4,480(sp)
    80004c68:	6afe                	ld	s5,472(sp)
    80004c6a:	6b5e                	ld	s6,464(sp)
    80004c6c:	6bbe                	ld	s7,456(sp)
    80004c6e:	6c1e                	ld	s8,448(sp)
    80004c70:	7cfa                	ld	s9,440(sp)
    80004c72:	7d5a                	ld	s10,432(sp)
    80004c74:	bd71                	j	80004b10 <kexec+0x6c>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004c76:	4901                	li	s2,0
    80004c78:	bf55                	j	80004c2c <kexec+0x188>
  uvmclear(pagetable, sz - (USERSTACK + 1) * PGSIZE);
    80004c7a:	75f9                	lui	a1,0xffffe
    80004c7c:	95aa                	add	a1,a1,a0
    80004c7e:	855a                	mv	a0,s6
    80004c80:	feefc0ef          	jal	8000146e <uvmclear>
  stackbase = sp - USERSTACK * PGSIZE;
    80004c84:	7bfd                	lui	s7,0xfffff
    80004c86:	9bd6                	add	s7,s7,s5
  for (argc = 0; argv[argc]; argc++) {
    80004c88:	df843783          	ld	a5,-520(s0)
    80004c8c:	6388                	ld	a0,0(a5)
    80004c8e:	cd3d                	beqz	a0,80004d0c <kexec+0x268>
  sp = sz;
    80004c90:	8c56                	mv	s8,s5
  for (argc = 0; argv[argc]; argc++) {
    80004c92:	4481                	li	s1,0
    ustack[argc] = sp;
    80004c94:	e9040913          	addi	s2,s0,-368
    sp -= strlen(argv[argc]) + 1;
    80004c98:	99cfc0ef          	jal	80000e34 <strlen>
    80004c9c:	0015079b          	addiw	a5,a0,1
    80004ca0:	40fc07b3          	sub	a5,s8,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004ca4:	ff07fc13          	andi	s8,a5,-16
    if (sp < stackbase)
    80004ca8:	077c6063          	bltu	s8,s7,80004d08 <kexec+0x264>
    if (copyout(pagetable, sz, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004cac:	df843d03          	ld	s10,-520(s0)
    80004cb0:	000d3c83          	ld	s9,0(s10)
    80004cb4:	8566                	mv	a0,s9
    80004cb6:	97efc0ef          	jal	80000e34 <strlen>
    80004cba:	0015071b          	addiw	a4,a0,1
    80004cbe:	86e6                	mv	a3,s9
    80004cc0:	8662                	mv	a2,s8
    80004cc2:	85d6                	mv	a1,s5
    80004cc4:	855a                	mv	a0,s6
    80004cc6:	867fc0ef          	jal	8000152c <copyout>
    80004cca:	02054f63          	bltz	a0,80004d08 <kexec+0x264>
    ustack[argc] = sp;
    80004cce:	00349793          	slli	a5,s1,0x3
    80004cd2:	97ca                	add	a5,a5,s2
    80004cd4:	0187b023          	sd	s8,0(a5) # fffffffffffff000 <end+0xffffffff7ffa4050>
  for (argc = 0; argv[argc]; argc++) {
    80004cd8:	0485                	addi	s1,s1,1
    80004cda:	008d0793          	addi	a5,s10,8
    80004cde:	def43c23          	sd	a5,-520(s0)
    80004ce2:	008d3503          	ld	a0,8(s10)
    80004ce6:	f94d                	bnez	a0,80004c98 <kexec+0x1f4>
  ustack[argc] = 0;
    80004ce8:	00349793          	slli	a5,s1,0x3
    80004cec:	f9040713          	addi	a4,s0,-112
    80004cf0:	97ba                	add	a5,a5,a4
    80004cf2:	f007b023          	sd	zero,-256(a5)
  sp -= (argc + 1) * sizeof(uint64);
    80004cf6:	00148713          	addi	a4,s1,1
    80004cfa:	070e                	slli	a4,a4,0x3
    80004cfc:	40ec0933          	sub	s2,s8,a4
  sp -= sp % 16;
    80004d00:	ff097913          	andi	s2,s2,-16
  if (sp < stackbase)
    80004d04:	01797763          	bgeu	s2,s7,80004d12 <kexec+0x26e>
  sz = sz1;
    80004d08:	84d6                	mv	s1,s5
    80004d0a:	bf89                	j	80004c5c <kexec+0x1b8>
  sp = sz;
    80004d0c:	8c56                	mv	s8,s5
  for (argc = 0; argv[argc]; argc++) {
    80004d0e:	4481                	li	s1,0
    80004d10:	bfe1                	j	80004ce8 <kexec+0x244>
  if (copyout(pagetable, sz, sp, (char *)ustack, (argc + 1) * sizeof(uint64)) <
    80004d12:	e9040693          	addi	a3,s0,-368
    80004d16:	864a                	mv	a2,s2
    80004d18:	85d6                	mv	a1,s5
    80004d1a:	855a                	mv	a0,s6
    80004d1c:	811fc0ef          	jal	8000152c <copyout>
    80004d20:	fe0544e3          	bltz	a0,80004d08 <kexec+0x264>
  p->trapframe->a1 = sp;
    80004d24:	0589b783          	ld	a5,88(s3)
    80004d28:	0727bc23          	sd	s2,120(a5)
  for (last = s = path; *s; s++)
    80004d2c:	e0043783          	ld	a5,-512(s0)
    80004d30:	0007c703          	lbu	a4,0(a5)
    80004d34:	cf11                	beqz	a4,80004d50 <kexec+0x2ac>
    80004d36:	0785                	addi	a5,a5,1
    if (*s == '/')
    80004d38:	02f00693          	li	a3,47
    80004d3c:	a029                	j	80004d46 <kexec+0x2a2>
  for (last = s = path; *s; s++)
    80004d3e:	0785                	addi	a5,a5,1
    80004d40:	fff7c703          	lbu	a4,-1(a5)
    80004d44:	c711                	beqz	a4,80004d50 <kexec+0x2ac>
    if (*s == '/')
    80004d46:	fed71ce3          	bne	a4,a3,80004d3e <kexec+0x29a>
      last = s + 1;
    80004d4a:	e0f43023          	sd	a5,-512(s0)
    80004d4e:	bfc5                	j	80004d3e <kexec+0x29a>
  safestrcpy(p->name, last, sizeof(p->name));
    80004d50:	4641                	li	a2,16
    80004d52:	e0043583          	ld	a1,-512(s0)
    80004d56:	15898513          	addi	a0,s3,344
    80004d5a:	8a4fc0ef          	jal	80000dfe <safestrcpy>
  oldpagetable = p->pagetable;
    80004d5e:	0509b503          	ld	a0,80(s3)
  p->pagetable = pagetable;
    80004d62:	0569b823          	sd	s6,80(s3)
  p->sz = sz;
    80004d66:	0559b423          	sd	s5,72(s3)
  p->trapframe->epc = elf.entry; // initial program counter = ulib.c:start()
    80004d6a:	0589b783          	ld	a5,88(s3)
    80004d6e:	e6843703          	ld	a4,-408(s0)
    80004d72:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp;         // initial stack pointer
    80004d74:	0589b783          	ld	a5,88(s3)
    80004d78:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80004d7c:	85d2                	mv	a1,s4
    80004d7e:	cfdfc0ef          	jal	80001a7a <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80004d82:	0004851b          	sext.w	a0,s1
    80004d86:	79be                	ld	s3,488(sp)
    80004d88:	7a1e                	ld	s4,480(sp)
    80004d8a:	6afe                	ld	s5,472(sp)
    80004d8c:	6b5e                	ld	s6,464(sp)
    80004d8e:	6bbe                	ld	s7,456(sp)
    80004d90:	6c1e                	ld	s8,448(sp)
    80004d92:	7cfa                	ld	s9,440(sp)
    80004d94:	7d5a                	ld	s10,432(sp)
    80004d96:	bbb5                	j	80004b12 <kexec+0x6e>
    80004d98:	6b5e                	ld	s6,464(sp)
    80004d9a:	b3ad                	j	80004b04 <kexec+0x60>
    return -1;
    80004d9c:	df243823          	sd	s2,-528(s0)
    proc_freepagetable(pagetable, sz);
    80004da0:	df043583          	ld	a1,-528(s0)
    80004da4:	855a                	mv	a0,s6
    80004da6:	cd5fc0ef          	jal	80001a7a <proc_freepagetable>
  if (ip) {
    80004daa:	79be                	ld	s3,488(sp)
    80004dac:	6afe                	ld	s5,472(sp)
    80004dae:	6b5e                	ld	s6,464(sp)
    80004db0:	6bbe                	ld	s7,456(sp)
    80004db2:	6c1e                	ld	s8,448(sp)
    80004db4:	7cfa                	ld	s9,440(sp)
    80004db6:	7d5a                	ld	s10,432(sp)
    80004db8:	7dba                	ld	s11,424(sp)
    80004dba:	b3a9                	j	80004b04 <kexec+0x60>

0000000080004dbc <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80004dbc:	7179                	addi	sp,sp,-48
    80004dbe:	f406                	sd	ra,40(sp)
    80004dc0:	f022                	sd	s0,32(sp)
    80004dc2:	ec26                	sd	s1,24(sp)
    80004dc4:	e84a                	sd	s2,16(sp)
    80004dc6:	1800                	addi	s0,sp,48
    80004dc8:	892e                	mv	s2,a1
    80004dca:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    80004dcc:	fdc40593          	addi	a1,s0,-36
    80004dd0:	a43fd0ef          	jal	80002812 <argint>
  if (fd < 0 || fd >= NOFILE || (f = myproc()->ofile[fd]) == 0)
    80004dd4:	fdc42703          	lw	a4,-36(s0)
    80004dd8:	47bd                	li	a5,15
    80004dda:	02e7e963          	bltu	a5,a4,80004e0c <argfd+0x50>
    80004dde:	b05fc0ef          	jal	800018e2 <myproc>
    80004de2:	fdc42703          	lw	a4,-36(s0)
    80004de6:	01a70793          	addi	a5,a4,26
    80004dea:	078e                	slli	a5,a5,0x3
    80004dec:	953e                	add	a0,a0,a5
    80004dee:	611c                	ld	a5,0(a0)
    80004df0:	cf91                	beqz	a5,80004e0c <argfd+0x50>
    return -1;
  if (pfd)
    80004df2:	00090463          	beqz	s2,80004dfa <argfd+0x3e>
    *pfd = fd;
    80004df6:	00e92023          	sw	a4,0(s2)
  if (pf)
    80004dfa:	c091                	beqz	s1,80004dfe <argfd+0x42>
    *pf = f;
    80004dfc:	e09c                	sd	a5,0(s1)
  return 0;
    80004dfe:	4501                	li	a0,0
}
    80004e00:	70a2                	ld	ra,40(sp)
    80004e02:	7402                	ld	s0,32(sp)
    80004e04:	64e2                	ld	s1,24(sp)
    80004e06:	6942                	ld	s2,16(sp)
    80004e08:	6145                	addi	sp,sp,48
    80004e0a:	8082                	ret
    return -1;
    80004e0c:	557d                	li	a0,-1
    80004e0e:	bfcd                	j	80004e00 <argfd+0x44>

0000000080004e10 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80004e10:	1101                	addi	sp,sp,-32
    80004e12:	ec06                	sd	ra,24(sp)
    80004e14:	e822                	sd	s0,16(sp)
    80004e16:	e426                	sd	s1,8(sp)
    80004e18:	1000                	addi	s0,sp,32
    80004e1a:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80004e1c:	ac7fc0ef          	jal	800018e2 <myproc>
    80004e20:	862a                	mv	a2,a0

  for (fd = 0; fd < NOFILE; fd++) {
    80004e22:	0d050793          	addi	a5,a0,208
    80004e26:	4501                	li	a0,0
    80004e28:	46c1                	li	a3,16
    if (p->ofile[fd] == 0) {
    80004e2a:	6398                	ld	a4,0(a5)
    80004e2c:	cb19                	beqz	a4,80004e42 <fdalloc+0x32>
  for (fd = 0; fd < NOFILE; fd++) {
    80004e2e:	2505                	addiw	a0,a0,1
    80004e30:	07a1                	addi	a5,a5,8
    80004e32:	fed51ce3          	bne	a0,a3,80004e2a <fdalloc+0x1a>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004e36:	557d                	li	a0,-1
}
    80004e38:	60e2                	ld	ra,24(sp)
    80004e3a:	6442                	ld	s0,16(sp)
    80004e3c:	64a2                	ld	s1,8(sp)
    80004e3e:	6105                	addi	sp,sp,32
    80004e40:	8082                	ret
      p->ofile[fd] = f;
    80004e42:	01a50793          	addi	a5,a0,26
    80004e46:	078e                	slli	a5,a5,0x3
    80004e48:	963e                	add	a2,a2,a5
    80004e4a:	e204                	sd	s1,0(a2)
      return fd;
    80004e4c:	b7f5                	j	80004e38 <fdalloc+0x28>

0000000080004e4e <create>:
  return -1;
}

static struct inode *
create(char *path, short type, short major, short minor)
{
    80004e4e:	715d                	addi	sp,sp,-80
    80004e50:	e486                	sd	ra,72(sp)
    80004e52:	e0a2                	sd	s0,64(sp)
    80004e54:	fc26                	sd	s1,56(sp)
    80004e56:	f84a                	sd	s2,48(sp)
    80004e58:	f44e                	sd	s3,40(sp)
    80004e5a:	ec56                	sd	s5,24(sp)
    80004e5c:	e85a                	sd	s6,16(sp)
    80004e5e:	0880                	addi	s0,sp,80
    80004e60:	89ae                	mv	s3,a1
    80004e62:	8ab2                	mv	s5,a2
    80004e64:	8b36                	mv	s6,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if ((dp = nameiparent(path, name)) == 0)
    80004e66:	fb040593          	addi	a1,s0,-80
    80004e6a:	d87fe0ef          	jal	80003bf0 <nameiparent>
    80004e6e:	84aa                	mv	s1,a0
    return 0;
    80004e70:	892a                	mv	s2,a0
  if ((dp = nameiparent(path, name)) == 0)
    80004e72:	cd31                	beqz	a0,80004ece <create+0x80>

  ilock(dp);
    80004e74:	c3cfe0ef          	jal	800032b0 <ilock>

  if (dp->nlink == 0) {
    80004e78:	04a49783          	lh	a5,74(s1)
    80004e7c:	c3bd                	beqz	a5,80004ee2 <create+0x94>
    iunlockput(dp);
    return 0;
  }

  // a new directory's ".." would push dp->nlink past its maximum
  if (type == T_DIR && dp->nlink >= NLINK_MAX) {
    80004e7e:	7761                	lui	a4,0xffff8
    80004e80:	0705                	addi	a4,a4,1 # ffffffffffff8001 <end+0xffffffff7ff9d051>
    80004e82:	97ba                	add	a5,a5,a4
    80004e84:	0017b793          	seqz	a5,a5
    80004e88:	fff98713          	addi	a4,s3,-1
    80004e8c:	00173713          	seqz	a4,a4
    80004e90:	8ff9                	and	a5,a5,a4
    80004e92:	efa1                	bnez	a5,80004eea <create+0x9c>
    iunlockput(dp);
    return 0;
  }

  if ((ip = dirlookup(dp, name, 0)) != 0) {
    80004e94:	4601                	li	a2,0
    80004e96:	fb040593          	addi	a1,s0,-80
    80004e9a:	8526                	mv	a0,s1
    80004e9c:	a91fe0ef          	jal	8000392c <dirlookup>
    80004ea0:	892a                	mv	s2,a0
    80004ea2:	c921                	beqz	a0,80004ef2 <create+0xa4>
    iunlockput(dp);
    80004ea4:	8526                	mv	a0,s1
    80004ea6:	eecfe0ef          	jal	80003592 <iunlockput>
    ilock(ip);
    80004eaa:	854a                	mv	a0,s2
    80004eac:	c04fe0ef          	jal	800032b0 <ilock>
    if (type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004eb0:	4789                	li	a5,2
    80004eb2:	00f99a63          	bne	s3,a5,80004ec6 <create+0x78>
    80004eb6:	04495783          	lhu	a5,68(s2)
    80004eba:	37f9                	addiw	a5,a5,-2
    80004ebc:	17c2                	slli	a5,a5,0x30
    80004ebe:	93c1                	srli	a5,a5,0x30
    80004ec0:	4705                	li	a4,1
    80004ec2:	00f77663          	bgeu	a4,a5,80004ece <create+0x80>
      return ip;
    iunlockput(ip);
    80004ec6:	854a                	mv	a0,s2
    80004ec8:	ecafe0ef          	jal	80003592 <iunlockput>
    return 0;
    80004ecc:	4901                	li	s2,0
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80004ece:	854a                	mv	a0,s2
    80004ed0:	60a6                	ld	ra,72(sp)
    80004ed2:	6406                	ld	s0,64(sp)
    80004ed4:	74e2                	ld	s1,56(sp)
    80004ed6:	7942                	ld	s2,48(sp)
    80004ed8:	79a2                	ld	s3,40(sp)
    80004eda:	6ae2                	ld	s5,24(sp)
    80004edc:	6b42                	ld	s6,16(sp)
    80004ede:	6161                	addi	sp,sp,80
    80004ee0:	8082                	ret
    iunlockput(dp);
    80004ee2:	8526                	mv	a0,s1
    80004ee4:	eaefe0ef          	jal	80003592 <iunlockput>
    return 0;
    80004ee8:	b7d5                	j	80004ecc <create+0x7e>
    iunlockput(dp);
    80004eea:	8526                	mv	a0,s1
    80004eec:	ea6fe0ef          	jal	80003592 <iunlockput>
    return 0;
    80004ef0:	bff1                	j	80004ecc <create+0x7e>
    80004ef2:	f052                	sd	s4,32(sp)
  if ((ip = ialloc(dp->dev, type)) == 0) {
    80004ef4:	85ce                	mv	a1,s3
    80004ef6:	4088                	lw	a0,0(s1)
    80004ef8:	a48fe0ef          	jal	80003140 <ialloc>
    80004efc:	8a2a                	mv	s4,a0
    80004efe:	cd1d                	beqz	a0,80004f3c <create+0xee>
  ilock(ip);
    80004f00:	bb0fe0ef          	jal	800032b0 <ilock>
  ip->major = major;
    80004f04:	055a1323          	sh	s5,70(s4)
  ip->minor = minor;
    80004f08:	056a1423          	sh	s6,72(s4)
  ip->nlink = 1;
    80004f0c:	4705                	li	a4,1
    80004f0e:	04ea1523          	sh	a4,74(s4)
  iupdate(ip);
    80004f12:	8552                	mv	a0,s4
    80004f14:	ae8fe0ef          	jal	800031fc <iupdate>
  if (type == T_DIR) { // Create . and .. entries.
    80004f18:	4785                	li	a5,1
    80004f1a:	02f98563          	beq	s3,a5,80004f44 <create+0xf6>
  if (dirlink(dp, name, ip->inum) < 0)
    80004f1e:	004a2603          	lw	a2,4(s4)
    80004f22:	fb040593          	addi	a1,s0,-80
    80004f26:	8526                	mv	a0,s1
    80004f28:	c05fe0ef          	jal	80003b2c <dirlink>
    80004f2c:	06054363          	bltz	a0,80004f92 <create+0x144>
  iunlockput(dp);
    80004f30:	8526                	mv	a0,s1
    80004f32:	e60fe0ef          	jal	80003592 <iunlockput>
    return 0;
    80004f36:	8952                	mv	s2,s4
    80004f38:	7a02                	ld	s4,32(sp)
    80004f3a:	bf51                	j	80004ece <create+0x80>
    iunlockput(dp);
    80004f3c:	8526                	mv	a0,s1
    80004f3e:	e54fe0ef          	jal	80003592 <iunlockput>
    return 0;
    80004f42:	bfd5                	j	80004f36 <create+0xe8>
    if (dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80004f44:	004a2603          	lw	a2,4(s4)
    80004f48:	00003597          	auipc	a1,0x3
    80004f4c:	70858593          	addi	a1,a1,1800 # 80008650 <etext+0x650>
    80004f50:	8552                	mv	a0,s4
    80004f52:	bdbfe0ef          	jal	80003b2c <dirlink>
    80004f56:	02054e63          	bltz	a0,80004f92 <create+0x144>
    80004f5a:	40d0                	lw	a2,4(s1)
    80004f5c:	00003597          	auipc	a1,0x3
    80004f60:	6fc58593          	addi	a1,a1,1788 # 80008658 <etext+0x658>
    80004f64:	8552                	mv	a0,s4
    80004f66:	bc7fe0ef          	jal	80003b2c <dirlink>
    80004f6a:	02054463          	bltz	a0,80004f92 <create+0x144>
  if (dirlink(dp, name, ip->inum) < 0)
    80004f6e:	004a2603          	lw	a2,4(s4)
    80004f72:	fb040593          	addi	a1,s0,-80
    80004f76:	8526                	mv	a0,s1
    80004f78:	bb5fe0ef          	jal	80003b2c <dirlink>
    80004f7c:	00054b63          	bltz	a0,80004f92 <create+0x144>
    dp->nlink++; // for ".."
    80004f80:	04a4d783          	lhu	a5,74(s1)
    80004f84:	2785                	addiw	a5,a5,1
    80004f86:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004f8a:	8526                	mv	a0,s1
    80004f8c:	a70fe0ef          	jal	800031fc <iupdate>
    80004f90:	b745                	j	80004f30 <create+0xe2>
  ip->nlink = 0;
    80004f92:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    80004f96:	8552                	mv	a0,s4
    80004f98:	a64fe0ef          	jal	800031fc <iupdate>
  iunlockput(ip);
    80004f9c:	8552                	mv	a0,s4
    80004f9e:	df4fe0ef          	jal	80003592 <iunlockput>
  iunlockput(dp);
    80004fa2:	8526                	mv	a0,s1
    80004fa4:	deefe0ef          	jal	80003592 <iunlockput>
  return 0;
    80004fa8:	7a02                	ld	s4,32(sp)
    80004faa:	b715                	j	80004ece <create+0x80>

0000000080004fac <sys_dup>:
{
    80004fac:	7179                	addi	sp,sp,-48
    80004fae:	f406                	sd	ra,40(sp)
    80004fb0:	f022                	sd	s0,32(sp)
    80004fb2:	1800                	addi	s0,sp,48
  if (argfd(0, 0, &f) < 0)
    80004fb4:	fd840613          	addi	a2,s0,-40
    80004fb8:	4581                	li	a1,0
    80004fba:	4501                	li	a0,0
    80004fbc:	e01ff0ef          	jal	80004dbc <argfd>
    80004fc0:	02054863          	bltz	a0,80004ff0 <sys_dup+0x44>
    80004fc4:	ec26                	sd	s1,24(sp)
    80004fc6:	e84a                	sd	s2,16(sp)
  if ((fd = fdalloc(f)) < 0)
    80004fc8:	fd843483          	ld	s1,-40(s0)
    80004fcc:	8526                	mv	a0,s1
    80004fce:	e43ff0ef          	jal	80004e10 <fdalloc>
    80004fd2:	892a                	mv	s2,a0
    80004fd4:	00054c63          	bltz	a0,80004fec <sys_dup+0x40>
  filedup(f);
    80004fd8:	8526                	mv	a0,s1
    80004fda:	bf8ff0ef          	jal	800043d2 <filedup>
  return fd;
    80004fde:	854a                	mv	a0,s2
    80004fe0:	64e2                	ld	s1,24(sp)
    80004fe2:	6942                	ld	s2,16(sp)
}
    80004fe4:	70a2                	ld	ra,40(sp)
    80004fe6:	7402                	ld	s0,32(sp)
    80004fe8:	6145                	addi	sp,sp,48
    80004fea:	8082                	ret
    80004fec:	64e2                	ld	s1,24(sp)
    80004fee:	6942                	ld	s2,16(sp)
    return -1;
    80004ff0:	557d                	li	a0,-1
    80004ff2:	bfcd                	j	80004fe4 <sys_dup+0x38>

0000000080004ff4 <sys_read>:
{
    80004ff4:	7179                	addi	sp,sp,-48
    80004ff6:	f406                	sd	ra,40(sp)
    80004ff8:	f022                	sd	s0,32(sp)
    80004ffa:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004ffc:	fd840593          	addi	a1,s0,-40
    80005000:	4505                	li	a0,1
    80005002:	82dfd0ef          	jal	8000282e <argaddr>
  argint(2, &n);
    80005006:	fe440593          	addi	a1,s0,-28
    8000500a:	4509                	li	a0,2
    8000500c:	807fd0ef          	jal	80002812 <argint>
  if (argfd(0, 0, &f) < 0)
    80005010:	fe840613          	addi	a2,s0,-24
    80005014:	4581                	li	a1,0
    80005016:	4501                	li	a0,0
    80005018:	da5ff0ef          	jal	80004dbc <argfd>
    8000501c:	87aa                	mv	a5,a0
    return -1;
    8000501e:	557d                	li	a0,-1
  if (argfd(0, 0, &f) < 0)
    80005020:	0007ca63          	bltz	a5,80005034 <sys_read+0x40>
  return fileread(f, p, n);
    80005024:	fe442603          	lw	a2,-28(s0)
    80005028:	fd843583          	ld	a1,-40(s0)
    8000502c:	fe843503          	ld	a0,-24(s0)
    80005030:	d10ff0ef          	jal	80004540 <fileread>
}
    80005034:	70a2                	ld	ra,40(sp)
    80005036:	7402                	ld	s0,32(sp)
    80005038:	6145                	addi	sp,sp,48
    8000503a:	8082                	ret

000000008000503c <sys_write>:
{
    8000503c:	7179                	addi	sp,sp,-48
    8000503e:	f406                	sd	ra,40(sp)
    80005040:	f022                	sd	s0,32(sp)
    80005042:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80005044:	fd840593          	addi	a1,s0,-40
    80005048:	4505                	li	a0,1
    8000504a:	fe4fd0ef          	jal	8000282e <argaddr>
  argint(2, &n);
    8000504e:	fe440593          	addi	a1,s0,-28
    80005052:	4509                	li	a0,2
    80005054:	fbefd0ef          	jal	80002812 <argint>
  if (argfd(0, 0, &f) < 0)
    80005058:	fe840613          	addi	a2,s0,-24
    8000505c:	4581                	li	a1,0
    8000505e:	4501                	li	a0,0
    80005060:	d5dff0ef          	jal	80004dbc <argfd>
    80005064:	87aa                	mv	a5,a0
    return -1;
    80005066:	557d                	li	a0,-1
  if (argfd(0, 0, &f) < 0)
    80005068:	0007ca63          	bltz	a5,8000507c <sys_write+0x40>
  return filewrite(f, p, n);
    8000506c:	fe442603          	lw	a2,-28(s0)
    80005070:	fd843583          	ld	a1,-40(s0)
    80005074:	fe843503          	ld	a0,-24(s0)
    80005078:	d8cff0ef          	jal	80004604 <filewrite>
}
    8000507c:	70a2                	ld	ra,40(sp)
    8000507e:	7402                	ld	s0,32(sp)
    80005080:	6145                	addi	sp,sp,48
    80005082:	8082                	ret

0000000080005084 <sys_close>:
{
    80005084:	1101                	addi	sp,sp,-32
    80005086:	ec06                	sd	ra,24(sp)
    80005088:	e822                	sd	s0,16(sp)
    8000508a:	1000                	addi	s0,sp,32
  if (argfd(0, &fd, &f) < 0)
    8000508c:	fe040613          	addi	a2,s0,-32
    80005090:	fec40593          	addi	a1,s0,-20
    80005094:	4501                	li	a0,0
    80005096:	d27ff0ef          	jal	80004dbc <argfd>
    return -1;
    8000509a:	57fd                	li	a5,-1
  if (argfd(0, &fd, &f) < 0)
    8000509c:	02054063          	bltz	a0,800050bc <sys_close+0x38>
  myproc()->ofile[fd] = 0;
    800050a0:	843fc0ef          	jal	800018e2 <myproc>
    800050a4:	fec42783          	lw	a5,-20(s0)
    800050a8:	07e9                	addi	a5,a5,26
    800050aa:	078e                	slli	a5,a5,0x3
    800050ac:	953e                	add	a0,a0,a5
    800050ae:	00053023          	sd	zero,0(a0)
  fileclose(f);
    800050b2:	fe043503          	ld	a0,-32(s0)
    800050b6:	b62ff0ef          	jal	80004418 <fileclose>
  return 0;
    800050ba:	4781                	li	a5,0
}
    800050bc:	853e                	mv	a0,a5
    800050be:	60e2                	ld	ra,24(sp)
    800050c0:	6442                	ld	s0,16(sp)
    800050c2:	6105                	addi	sp,sp,32
    800050c4:	8082                	ret

00000000800050c6 <sys_fstat>:
{
    800050c6:	1101                	addi	sp,sp,-32
    800050c8:	ec06                	sd	ra,24(sp)
    800050ca:	e822                	sd	s0,16(sp)
    800050cc:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    800050ce:	fe040593          	addi	a1,s0,-32
    800050d2:	4505                	li	a0,1
    800050d4:	f5afd0ef          	jal	8000282e <argaddr>
  if (argfd(0, 0, &f) < 0)
    800050d8:	fe840613          	addi	a2,s0,-24
    800050dc:	4581                	li	a1,0
    800050de:	4501                	li	a0,0
    800050e0:	cddff0ef          	jal	80004dbc <argfd>
    800050e4:	87aa                	mv	a5,a0
    return -1;
    800050e6:	557d                	li	a0,-1
  if (argfd(0, 0, &f) < 0)
    800050e8:	0007c863          	bltz	a5,800050f8 <sys_fstat+0x32>
  return filestat(f, st);
    800050ec:	fe043583          	ld	a1,-32(s0)
    800050f0:	fe843503          	ld	a0,-24(s0)
    800050f4:	be6ff0ef          	jal	800044da <filestat>
}
    800050f8:	60e2                	ld	ra,24(sp)
    800050fa:	6442                	ld	s0,16(sp)
    800050fc:	6105                	addi	sp,sp,32
    800050fe:	8082                	ret

0000000080005100 <sys_link>:
{
    80005100:	7169                	addi	sp,sp,-304
    80005102:	f606                	sd	ra,296(sp)
    80005104:	f222                	sd	s0,288(sp)
    80005106:	1a00                	addi	s0,sp,304
  if (argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80005108:	08000613          	li	a2,128
    8000510c:	ed040593          	addi	a1,s0,-304
    80005110:	4501                	li	a0,0
    80005112:	f38fd0ef          	jal	8000284a <argstr>
    80005116:	0e054c63          	bltz	a0,8000520e <sys_link+0x10e>
    8000511a:	08000613          	li	a2,128
    8000511e:	f5040593          	addi	a1,s0,-176
    80005122:	4505                	li	a0,1
    80005124:	f26fd0ef          	jal	8000284a <argstr>
    80005128:	0e054363          	bltz	a0,8000520e <sys_link+0x10e>
    8000512c:	ee26                	sd	s1,280(sp)
  begin_op();
    8000512e:	e31fe0ef          	jal	80003f5e <begin_op>
  if ((ip = namei(old)) == 0) {
    80005132:	ed040513          	addi	a0,s0,-304
    80005136:	aa1fe0ef          	jal	80003bd6 <namei>
    8000513a:	84aa                	mv	s1,a0
    8000513c:	cd35                	beqz	a0,800051b8 <sys_link+0xb8>
  ilock(ip);
    8000513e:	972fe0ef          	jal	800032b0 <ilock>
  if (ip->type == T_DIR) {
    80005142:	04449703          	lh	a4,68(s1)
    80005146:	4785                	li	a5,1
    80005148:	06f70c63          	beq	a4,a5,800051c0 <sys_link+0xc0>
  if (ip->nlink >= NLINK_MAX) {
    8000514c:	04a49783          	lh	a5,74(s1)
    80005150:	6721                	lui	a4,0x8
    80005152:	177d                	addi	a4,a4,-1 # 7fff <_entry-0x7fff8001>
    80005154:	06e78d63          	beq	a5,a4,800051ce <sys_link+0xce>
    80005158:	ea4a                	sd	s2,272(sp)
  ip->nlink++;
    8000515a:	2785                	addiw	a5,a5,1
    8000515c:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80005160:	8526                	mv	a0,s1
    80005162:	89afe0ef          	jal	800031fc <iupdate>
  iunlock(ip);
    80005166:	8526                	mv	a0,s1
    80005168:	9f6fe0ef          	jal	8000335e <iunlock>
  if ((dp = nameiparent(new, name)) == 0)
    8000516c:	fd040593          	addi	a1,s0,-48
    80005170:	f5040513          	addi	a0,s0,-176
    80005174:	a7dfe0ef          	jal	80003bf0 <nameiparent>
    80005178:	892a                	mv	s2,a0
    8000517a:	c925                	beqz	a0,800051ea <sys_link+0xea>
  ilock(dp);
    8000517c:	934fe0ef          	jal	800032b0 <ilock>
  if (dp->nlink == 0) {
    80005180:	04a91783          	lh	a5,74(s2)
    80005184:	cfa1                	beqz	a5,800051dc <sys_link+0xdc>
  if (dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0) {
    80005186:	854a                	mv	a0,s2
    80005188:	00092703          	lw	a4,0(s2)
    8000518c:	409c                	lw	a5,0(s1)
    8000518e:	04f71b63          	bne	a4,a5,800051e4 <sys_link+0xe4>
    80005192:	40d0                	lw	a2,4(s1)
    80005194:	fd040593          	addi	a1,s0,-48
    80005198:	995fe0ef          	jal	80003b2c <dirlink>
    8000519c:	04054463          	bltz	a0,800051e4 <sys_link+0xe4>
  iunlockput(dp);
    800051a0:	854a                	mv	a0,s2
    800051a2:	bf0fe0ef          	jal	80003592 <iunlockput>
  iput(ip);
    800051a6:	8526                	mv	a0,s1
    800051a8:	b18fe0ef          	jal	800034c0 <iput>
  end_op();
    800051ac:	e41fe0ef          	jal	80003fec <end_op>
  return 0;
    800051b0:	4501                	li	a0,0
    800051b2:	64f2                	ld	s1,280(sp)
    800051b4:	6952                	ld	s2,272(sp)
    800051b6:	a8a9                	j	80005210 <sys_link+0x110>
    end_op();
    800051b8:	e35fe0ef          	jal	80003fec <end_op>
    return -1;
    800051bc:	64f2                	ld	s1,280(sp)
    800051be:	a881                	j	8000520e <sys_link+0x10e>
    iunlockput(ip);
    800051c0:	8526                	mv	a0,s1
    800051c2:	bd0fe0ef          	jal	80003592 <iunlockput>
    end_op();
    800051c6:	e27fe0ef          	jal	80003fec <end_op>
    return -1;
    800051ca:	64f2                	ld	s1,280(sp)
    800051cc:	a089                	j	8000520e <sys_link+0x10e>
    iunlockput(ip);
    800051ce:	8526                	mv	a0,s1
    800051d0:	bc2fe0ef          	jal	80003592 <iunlockput>
    end_op();
    800051d4:	e19fe0ef          	jal	80003fec <end_op>
    return -1;
    800051d8:	64f2                	ld	s1,280(sp)
    800051da:	a815                	j	8000520e <sys_link+0x10e>
    iunlockput(dp);
    800051dc:	854a                	mv	a0,s2
    800051de:	bb4fe0ef          	jal	80003592 <iunlockput>
    goto bad;
    800051e2:	a021                	j	800051ea <sys_link+0xea>
    iunlockput(dp);
    800051e4:	854a                	mv	a0,s2
    800051e6:	bacfe0ef          	jal	80003592 <iunlockput>
  ilock(ip);
    800051ea:	8526                	mv	a0,s1
    800051ec:	8c4fe0ef          	jal	800032b0 <ilock>
  ip->nlink--;
    800051f0:	04a4d783          	lhu	a5,74(s1)
    800051f4:	37fd                	addiw	a5,a5,-1
    800051f6:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800051fa:	8526                	mv	a0,s1
    800051fc:	800fe0ef          	jal	800031fc <iupdate>
  iunlockput(ip);
    80005200:	8526                	mv	a0,s1
    80005202:	b90fe0ef          	jal	80003592 <iunlockput>
  end_op();
    80005206:	de7fe0ef          	jal	80003fec <end_op>
  return -1;
    8000520a:	64f2                	ld	s1,280(sp)
    8000520c:	6952                	ld	s2,272(sp)
    return -1;
    8000520e:	557d                	li	a0,-1
}
    80005210:	70b2                	ld	ra,296(sp)
    80005212:	7412                	ld	s0,288(sp)
    80005214:	6155                	addi	sp,sp,304
    80005216:	8082                	ret

0000000080005218 <sys_unlink>:
{
    80005218:	7151                	addi	sp,sp,-240
    8000521a:	f586                	sd	ra,232(sp)
    8000521c:	f1a2                	sd	s0,224(sp)
    8000521e:	1980                	addi	s0,sp,240
  if (argstr(0, path, MAXPATH) < 0)
    80005220:	08000613          	li	a2,128
    80005224:	f3040593          	addi	a1,s0,-208
    80005228:	4501                	li	a0,0
    8000522a:	e20fd0ef          	jal	8000284a <argstr>
    8000522e:	14054763          	bltz	a0,8000537c <sys_unlink+0x164>
    80005232:	eda6                	sd	s1,216(sp)
  begin_op();
    80005234:	d2bfe0ef          	jal	80003f5e <begin_op>
  if ((dp = nameiparent(path, name)) == 0) {
    80005238:	fb040593          	addi	a1,s0,-80
    8000523c:	f3040513          	addi	a0,s0,-208
    80005240:	9b1fe0ef          	jal	80003bf0 <nameiparent>
    80005244:	84aa                	mv	s1,a0
    80005246:	c955                	beqz	a0,800052fa <sys_unlink+0xe2>
  ilock(dp);
    80005248:	868fe0ef          	jal	800032b0 <ilock>
  if (namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    8000524c:	00003597          	auipc	a1,0x3
    80005250:	40458593          	addi	a1,a1,1028 # 80008650 <etext+0x650>
    80005254:	fb040513          	addi	a0,s0,-80
    80005258:	ebefe0ef          	jal	80003916 <namecmp>
    8000525c:	10050a63          	beqz	a0,80005370 <sys_unlink+0x158>
    80005260:	00003597          	auipc	a1,0x3
    80005264:	3f858593          	addi	a1,a1,1016 # 80008658 <etext+0x658>
    80005268:	fb040513          	addi	a0,s0,-80
    8000526c:	eaafe0ef          	jal	80003916 <namecmp>
    80005270:	10050063          	beqz	a0,80005370 <sys_unlink+0x158>
    80005274:	e9ca                	sd	s2,208(sp)
  if ((ip = dirlookup(dp, name, &off)) == 0)
    80005276:	f2c40613          	addi	a2,s0,-212
    8000527a:	fb040593          	addi	a1,s0,-80
    8000527e:	8526                	mv	a0,s1
    80005280:	eacfe0ef          	jal	8000392c <dirlookup>
    80005284:	892a                	mv	s2,a0
    80005286:	0e050463          	beqz	a0,8000536e <sys_unlink+0x156>
    8000528a:	e5ce                	sd	s3,200(sp)
  ilock(ip);
    8000528c:	824fe0ef          	jal	800032b0 <ilock>
  if (ip->nlink < 1)
    80005290:	04a91783          	lh	a5,74(s2)
    80005294:	06f05763          	blez	a5,80005302 <sys_unlink+0xea>
  if (ip->type == T_DIR && !isdirempty(ip)) {
    80005298:	04491703          	lh	a4,68(s2)
    8000529c:	4785                	li	a5,1
    8000529e:	06f70863          	beq	a4,a5,8000530e <sys_unlink+0xf6>
  memset(&de, 0, sizeof(de));
    800052a2:	fc040993          	addi	s3,s0,-64
    800052a6:	4641                	li	a2,16
    800052a8:	4581                	li	a1,0
    800052aa:	854e                	mv	a0,s3
    800052ac:	a09fb0ef          	jal	80000cb4 <memset>
  if (writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800052b0:	4741                	li	a4,16
    800052b2:	f2c42683          	lw	a3,-212(s0)
    800052b6:	864e                	mv	a2,s3
    800052b8:	4581                	li	a1,0
    800052ba:	8526                	mv	a0,s1
    800052bc:	d4efe0ef          	jal	8000380a <writei>
    800052c0:	47c1                	li	a5,16
    800052c2:	08f51763          	bne	a0,a5,80005350 <sys_unlink+0x138>
  if (ip->type == T_DIR) {
    800052c6:	04491703          	lh	a4,68(s2)
    800052ca:	4785                	li	a5,1
    800052cc:	08f70863          	beq	a4,a5,8000535c <sys_unlink+0x144>
  iunlockput(dp);
    800052d0:	8526                	mv	a0,s1
    800052d2:	ac0fe0ef          	jal	80003592 <iunlockput>
  ip->nlink--;
    800052d6:	04a95783          	lhu	a5,74(s2)
    800052da:	37fd                	addiw	a5,a5,-1
    800052dc:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    800052e0:	854a                	mv	a0,s2
    800052e2:	f1bfd0ef          	jal	800031fc <iupdate>
  iunlockput(ip);
    800052e6:	854a                	mv	a0,s2
    800052e8:	aaafe0ef          	jal	80003592 <iunlockput>
  end_op();
    800052ec:	d01fe0ef          	jal	80003fec <end_op>
  return 0;
    800052f0:	4501                	li	a0,0
    800052f2:	64ee                	ld	s1,216(sp)
    800052f4:	694e                	ld	s2,208(sp)
    800052f6:	69ae                	ld	s3,200(sp)
    800052f8:	a059                	j	8000537e <sys_unlink+0x166>
    end_op();
    800052fa:	cf3fe0ef          	jal	80003fec <end_op>
    return -1;
    800052fe:	64ee                	ld	s1,216(sp)
    80005300:	a8b5                	j	8000537c <sys_unlink+0x164>
    panic("unlink: nlink < 1");
    80005302:	00003517          	auipc	a0,0x3
    80005306:	35e50513          	addi	a0,a0,862 # 80008660 <etext+0x660>
    8000530a:	d3efb0ef          	jal	80000848 <panic>
  for (off = 2 * sizeof(de); off < dp->size; off += sizeof(de)) {
    8000530e:	04c92703          	lw	a4,76(s2)
    80005312:	02000793          	li	a5,32
    80005316:	f8e7f6e3          	bgeu	a5,a4,800052a2 <sys_unlink+0x8a>
    8000531a:	89be                	mv	s3,a5
    if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000531c:	4741                	li	a4,16
    8000531e:	86ce                	mv	a3,s3
    80005320:	f1840613          	addi	a2,s0,-232
    80005324:	4581                	li	a1,0
    80005326:	854a                	mv	a0,s2
    80005328:	bf0fe0ef          	jal	80003718 <readi>
    8000532c:	47c1                	li	a5,16
    8000532e:	00f51b63          	bne	a0,a5,80005344 <sys_unlink+0x12c>
    if (de.inum != 0)
    80005332:	f1845783          	lhu	a5,-232(s0)
    80005336:	eba1                	bnez	a5,80005386 <sys_unlink+0x16e>
  for (off = 2 * sizeof(de); off < dp->size; off += sizeof(de)) {
    80005338:	29c1                	addiw	s3,s3,16
    8000533a:	04c92783          	lw	a5,76(s2)
    8000533e:	fcf9efe3          	bltu	s3,a5,8000531c <sys_unlink+0x104>
    80005342:	b785                	j	800052a2 <sys_unlink+0x8a>
      panic("isdirempty: readi");
    80005344:	00003517          	auipc	a0,0x3
    80005348:	33450513          	addi	a0,a0,820 # 80008678 <etext+0x678>
    8000534c:	cfcfb0ef          	jal	80000848 <panic>
    panic("unlink: writei");
    80005350:	00003517          	auipc	a0,0x3
    80005354:	34050513          	addi	a0,a0,832 # 80008690 <etext+0x690>
    80005358:	cf0fb0ef          	jal	80000848 <panic>
    dp->nlink--;
    8000535c:	04a4d783          	lhu	a5,74(s1)
    80005360:	37fd                	addiw	a5,a5,-1
    80005362:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80005366:	8526                	mv	a0,s1
    80005368:	e95fd0ef          	jal	800031fc <iupdate>
    8000536c:	b795                	j	800052d0 <sys_unlink+0xb8>
    8000536e:	694e                	ld	s2,208(sp)
  iunlockput(dp);
    80005370:	8526                	mv	a0,s1
    80005372:	a20fe0ef          	jal	80003592 <iunlockput>
  end_op();
    80005376:	c77fe0ef          	jal	80003fec <end_op>
  return -1;
    8000537a:	64ee                	ld	s1,216(sp)
    return -1;
    8000537c:	557d                	li	a0,-1
}
    8000537e:	70ae                	ld	ra,232(sp)
    80005380:	740e                	ld	s0,224(sp)
    80005382:	616d                	addi	sp,sp,240
    80005384:	8082                	ret
    iunlockput(ip);
    80005386:	854a                	mv	a0,s2
    80005388:	a0afe0ef          	jal	80003592 <iunlockput>
    goto bad;
    8000538c:	694e                	ld	s2,208(sp)
    8000538e:	69ae                	ld	s3,200(sp)
    80005390:	b7c5                	j	80005370 <sys_unlink+0x158>

0000000080005392 <sys_open>:

uint64
sys_open(void)
{
    80005392:	7105                	addi	sp,sp,-480
    80005394:	ef86                	sd	ra,472(sp)
    80005396:	eba2                	sd	s0,464(sp)
    80005398:	1380                	addi	s0,sp,480
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    8000539a:	f2c40593          	addi	a1,s0,-212
    8000539e:	4505                	li	a0,1
    800053a0:	c72fd0ef          	jal	80002812 <argint>
  if ((n = argstr(0, path, MAXPATH)) < 0)
    800053a4:	08000613          	li	a2,128
    800053a8:	f3040593          	addi	a1,s0,-208
    800053ac:	4501                	li	a0,0
    800053ae:	c9cfd0ef          	jal	8000284a <argstr>
    800053b2:	2e054763          	bltz	a0,800056a0 <sys_open+0x30e>
    800053b6:	e7a6                	sd	s1,456(sp)
    return -1;

  begin_op();
    800053b8:	ba7fe0ef          	jal	80003f5e <begin_op>


  if (omode & O_CREATE) {
    800053bc:	f2c42783          	lw	a5,-212(s0)
    800053c0:	2007f793          	andi	a5,a5,512
    800053c4:	c3dd                	beqz	a5,8000546a <sys_open+0xd8>
    ip = create(path, T_FILE, 0, 0);
    800053c6:	4681                	li	a3,0
    800053c8:	4601                	li	a2,0
    800053ca:	4589                	li	a1,2
    800053cc:	f3040513          	addi	a0,s0,-208
    800053d0:	a7fff0ef          	jal	80004e4e <create>
    800053d4:	84aa                	mv	s1,a0
    if (ip == 0) {
    800053d6:	c551                	beqz	a0,80005462 <sys_open+0xd0>
        }
        ilock(ip);
      }
    }
  }
    if (ip->type == T_DIR && omode != O_RDONLY) {
    800053d8:	04449783          	lh	a5,68(s1)
    800053dc:	4705                	li	a4,1
    800053de:	28e78a63          	beq	a5,a4,80005672 <sys_open+0x2e0>
      iunlockput(ip);
      end_op();
      return -1;
    }
    if (ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)) {
    800053e2:	470d                	li	a4,3
    800053e4:	00e79763          	bne	a5,a4,800053f2 <sys_open+0x60>
    800053e8:	0464d703          	lhu	a4,70(s1)
    800053ec:	47a5                	li	a5,9
    800053ee:	28e7e763          	bltu	a5,a4,8000567c <sys_open+0x2ea>
    800053f2:	e3ca                	sd	s2,448(sp)
      iunlockput(ip);
      end_op();
      return -1;
    }
    if ((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0) {
    800053f4:	f81fe0ef          	jal	80004374 <filealloc>
    800053f8:	892a                	mv	s2,a0
    800053fa:	28050c63          	beqz	a0,80005692 <sys_open+0x300>
    800053fe:	ff4e                	sd	s3,440(sp)
    80005400:	a11ff0ef          	jal	80004e10 <fdalloc>
    80005404:	89aa                	mv	s3,a0
    80005406:	28054263          	bltz	a0,8000568a <sys_open+0x2f8>
      iunlockput(ip);
      end_op();
      return -1;
    }

    if (ip->type == T_DEVICE) {
    8000540a:	04449703          	lh	a4,68(s1)
    8000540e:	478d                	li	a5,3
    80005410:	28f70d63          	beq	a4,a5,800056aa <sys_open+0x318>
      f->type = FD_DEVICE;
      f->major = ip->major;
    } else {
      f->type = FD_INODE;
    80005414:	4789                	li	a5,2
    80005416:	00f92023          	sw	a5,0(s2)
      f->off = 0;
    8000541a:	02092023          	sw	zero,32(s2)
    }
    f->ip = ip;
    8000541e:	00993c23          	sd	s1,24(s2)
    f->readable = !(omode & O_WRONLY);
    80005422:	f2c42783          	lw	a5,-212(s0)
    80005426:	0017f713          	andi	a4,a5,1
    8000542a:	00174713          	xori	a4,a4,1
    8000542e:	00e90423          	sb	a4,8(s2)
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80005432:	0037f713          	andi	a4,a5,3
    80005436:	00e03733          	snez	a4,a4
    8000543a:	00e904a3          	sb	a4,9(s2)

    if ((omode & O_TRUNC) && ip->type == T_FILE) {
    8000543e:	4007f793          	andi	a5,a5,1024
    80005442:	c791                	beqz	a5,8000544e <sys_open+0xbc>
    80005444:	04449703          	lh	a4,68(s1)
    80005448:	4789                	li	a5,2
    8000544a:	26f70763          	beq	a4,a5,800056b8 <sys_open+0x326>
      itrunc(ip);
    }

    iunlock(ip);
    8000544e:	8526                	mv	a0,s1
    80005450:	f0ffd0ef          	jal	8000335e <iunlock>
    end_op();
    80005454:	b99fe0ef          	jal	80003fec <end_op>

    return fd;
    80005458:	854e                	mv	a0,s3
    8000545a:	64be                	ld	s1,456(sp)
    8000545c:	691e                	ld	s2,448(sp)
    8000545e:	79fa                	ld	s3,440(sp)
    80005460:	a489                	j	800056a2 <sys_open+0x310>
      end_op();
    80005462:	b8bfe0ef          	jal	80003fec <end_op>
      return -1;
    80005466:	64be                	ld	s1,456(sp)
    80005468:	ac25                	j	800056a0 <sys_open+0x30e>
    if ((ip = namei(path)) == 0) {
    8000546a:	f3040513          	addi	a0,s0,-208
    8000546e:	f68fe0ef          	jal	80003bd6 <namei>
    80005472:	84aa                	mv	s1,a0
    80005474:	c505                	beqz	a0,8000549c <sys_open+0x10a>
    80005476:	ef5e                	sd	s7,408(sp)
    ilock(ip);
    80005478:	e39fd0ef          	jal	800032b0 <ilock>
    if (!(omode & O_NOFOLLOW)) {
    8000547c:	f2c42703          	lw	a4,-212(s0)
    80005480:	6785                	lui	a5,0x1
    80005482:	80078793          	addi	a5,a5,-2048 # 800 <_entry-0x7ffff800>
    80005486:	8ff9                	and	a5,a5,a4
    80005488:	8bbe                	mv	s7,a5
    8000548a:	1c078163          	beqz	a5,8000564c <sys_open+0x2ba>
    if (ip->type == T_DIR && omode != O_RDONLY) {
    8000548e:	04449783          	lh	a5,68(s1)
    80005492:	4705                	li	a4,1
    80005494:	22e78663          	beq	a5,a4,800056c0 <sys_open+0x32e>
    80005498:	6bfa                	ld	s7,408(sp)
    8000549a:	b7a1                	j	800053e2 <sys_open+0x50>
      end_op();
    8000549c:	b51fe0ef          	jal	80003fec <end_op>
      return -1;
    800054a0:	64be                	ld	s1,456(sp)
    800054a2:	aafd                	j	800056a0 <sys_open+0x30e>
          iunlockput(ip);
    800054a4:	8526                	mv	a0,s1
    800054a6:	8ecfe0ef          	jal	80003592 <iunlockput>
          end_op();
    800054aa:	b43fe0ef          	jal	80003fec <end_op>
          return -1;
    800054ae:	64be                	ld	s1,456(sp)
    800054b0:	691e                	ld	s2,448(sp)
    800054b2:	79fa                	ld	s3,440(sp)
    800054b4:	7a5a                	ld	s4,432(sp)
    800054b6:	7aba                	ld	s5,424(sp)
    800054b8:	7b1a                	ld	s6,416(sp)
    800054ba:	6bfa                	ld	s7,408(sp)
    800054bc:	a2d5                	j	800056a0 <sys_open+0x30e>
          iunlockput(ip);
    800054be:	8526                	mv	a0,s1
    800054c0:	8d2fe0ef          	jal	80003592 <iunlockput>
          end_op();
    800054c4:	b29fe0ef          	jal	80003fec <end_op>
          return -1;
    800054c8:	64be                	ld	s1,456(sp)
    800054ca:	691e                	ld	s2,448(sp)
    800054cc:	79fa                	ld	s3,440(sp)
    800054ce:	7a5a                	ld	s4,432(sp)
    800054d0:	7aba                	ld	s5,424(sp)
    800054d2:	7b1a                	ld	s6,416(sp)
    800054d4:	6bfa                	ld	s7,408(sp)
    800054d6:	a2e9                	j	800056a0 <sys_open+0x30e>
          iunlockput(ip);
    800054d8:	8526                	mv	a0,s1
    800054da:	8b8fe0ef          	jal	80003592 <iunlockput>
          end_op();
    800054de:	b0ffe0ef          	jal	80003fec <end_op>
          return -1;
    800054e2:	64be                	ld	s1,456(sp)
    800054e4:	691e                	ld	s2,448(sp)
    800054e6:	79fa                	ld	s3,440(sp)
    800054e8:	7a5a                	ld	s4,432(sp)
    800054ea:	7aba                	ld	s5,424(sp)
    800054ec:	7b1a                	ld	s6,416(sp)
    800054ee:	6bfa                	ld	s7,408(sp)
    800054f0:	aa45                	j	800056a0 <sys_open+0x30e>
          iunlockput(ip);
    800054f2:	8526                	mv	a0,s1
    800054f4:	89efe0ef          	jal	80003592 <iunlockput>
          end_op();
    800054f8:	af5fe0ef          	jal	80003fec <end_op>
          return -1;
    800054fc:	64be                	ld	s1,456(sp)
    800054fe:	691e                	ld	s2,448(sp)
    80005500:	79fa                	ld	s3,440(sp)
    80005502:	7a5a                	ld	s4,432(sp)
    80005504:	7aba                	ld	s5,424(sp)
    80005506:	7b1a                	ld	s6,416(sp)
    80005508:	6bfa                	ld	s7,408(sp)
    8000550a:	aa59                	j	800056a0 <sys_open+0x30e>
          safestrcpy(next_path, target, MAXPATH);
    8000550c:	08000613          	li	a2,128
    80005510:	85ce                	mv	a1,s3
    80005512:	ea840513          	addi	a0,s0,-344
    80005516:	8e9fb0ef          	jal	80000dfe <safestrcpy>
        iunlockput(ip);
    8000551a:	8526                	mv	a0,s1
    8000551c:	876fe0ef          	jal	80003592 <iunlockput>
        safestrcpy(path, next_path, MAXPATH);
    80005520:	f3040493          	addi	s1,s0,-208
    80005524:	08000613          	li	a2,128
    80005528:	ea840593          	addi	a1,s0,-344
    8000552c:	8526                	mv	a0,s1
    8000552e:	8d1fb0ef          	jal	80000dfe <safestrcpy>
        if ((ip = namei(path)) == 0) { //target missing (dangling link)
    80005532:	8526                	mv	a0,s1
    80005534:	ea2fe0ef          	jal	80003bd6 <namei>
    80005538:	84aa                	mv	s1,a0
    8000553a:	0e050863          	beqz	a0,8000562a <sys_open+0x298>
        ilock(ip);
    8000553e:	d73fd0ef          	jal	800032b0 <ilock>
      while (ip->type == T_SYMLINK) {
    80005542:	04449703          	lh	a4,68(s1)
    80005546:	4791                	li	a5,4
    80005548:	0ef71b63          	bne	a4,a5,8000563e <sys_open+0x2ac>
        if (depth >= 10) { // limit cycle depth
    8000554c:	3a7d                	addiw	s4,s4,-1
    8000554e:	f40a0be3          	beqz	s4,800054a4 <sys_open+0x112>
        if (ip->size < 2 || ip->size > MAXPATH){
    80005552:	44f8                	lw	a4,76(s1)
    80005554:	ffe7079b          	addiw	a5,a4,-2
    80005558:	07e00693          	li	a3,126
    8000555c:	f6f6e1e3          	bltu	a3,a5,800054be <sys_open+0x12c>
        if (readi(ip, 0, (uint64)target, 0, ip->size) != ip->size) {
    80005560:	4681                	li	a3,0
    80005562:	864e                	mv	a2,s3
    80005564:	4581                	li	a1,0
    80005566:	8526                	mv	a0,s1
    80005568:	9b0fe0ef          	jal	80003718 <readi>
    8000556c:	44fc                	lw	a5,76(s1)
    8000556e:	f6f515e3          	bne	a0,a5,800054d8 <sys_open+0x146>
        if (target[ip->size-1]!='\0'||strlen(target)!=ip->size-1){
    80005572:	37fd                	addiw	a5,a5,-1
    80005574:	1782                	slli	a5,a5,0x20
    80005576:	9381                	srli	a5,a5,0x20
    80005578:	fb040713          	addi	a4,s0,-80
    8000557c:	97ba                	add	a5,a5,a4
    8000557e:	e787c783          	lbu	a5,-392(a5)
    80005582:	fba5                	bnez	a5,800054f2 <sys_open+0x160>
    80005584:	854e                	mv	a0,s3
    80005586:	8affb0ef          	jal	80000e34 <strlen>
    8000558a:	44fc                	lw	a5,76(s1)
    8000558c:	37fd                	addiw	a5,a5,-1
    8000558e:	f6a792e3          	bne	a5,a0,800054f2 <sys_open+0x160>
        if (target[0] == '/') {
    80005592:	e2844783          	lbu	a5,-472(s0)
    80005596:	f7278be3          	beq	a5,s2,8000550c <sys_open+0x17a>
          for (int i = 0; path[i] != '\0'; i++) {
    8000559a:	f3044783          	lbu	a5,-208(s0)
    8000559e:	f3140713          	addi	a4,s0,-207
    800055a2:	86de                	mv	a3,s7
          int last_slash = -1;
    800055a4:	567d                	li	a2,-1
    800055a6:	8b32                	mv	s6,a2
          for (int i = 0; path[i] != '\0'; i++) {
    800055a8:	ef91                	bnez	a5,800055c4 <sys_open+0x232>
            safestrcpy(next_path, target, MAXPATH);
    800055aa:	08000613          	li	a2,128
    800055ae:	85ce                	mv	a1,s3
    800055b0:	ea840513          	addi	a0,s0,-344
    800055b4:	84bfb0ef          	jal	80000dfe <safestrcpy>
    800055b8:	b78d                	j	8000551a <sys_open+0x188>
          for (int i = 0; path[i] != '\0'; i++) {
    800055ba:	2685                	addiw	a3,a3,1
    800055bc:	0705                	addi	a4,a4,1
    800055be:	fff74783          	lbu	a5,-1(a4)
    800055c2:	c789                	beqz	a5,800055cc <sys_open+0x23a>
            if (path[i] == '/')
    800055c4:	ff279be3          	bne	a5,s2,800055ba <sys_open+0x228>
              last_slash = i;
    800055c8:	8b36                	mv	s6,a3
    800055ca:	bfc5                	j	800055ba <sys_open+0x228>
          if (last_slash < 0) {
    800055cc:	fc0b4fe3          	bltz	s6,800055aa <sys_open+0x218>
            if (last_slash +1+ strlen(target) >= MAXPATH) {
    800055d0:	001b079b          	addiw	a5,s6,1
    800055d4:	8abe                	mv	s5,a5
    800055d6:	854e                	mv	a0,s3
    800055d8:	85dfb0ef          	jal	80000e34 <strlen>
    800055dc:	00aa853b          	addw	a0,s5,a0
    800055e0:	07f00793          	li	a5,127
    800055e4:	02a7c663          	blt	a5,a0,80005610 <sys_open+0x27e>
            memmove(next_path, path, last_slash + 1);
    800055e8:	8656                	mv	a2,s5
    800055ea:	f3040593          	addi	a1,s0,-208
    800055ee:	ea840513          	addi	a0,s0,-344
    800055f2:	f1efb0ef          	jal	80000d10 <memmove>
            safestrcpy(next_path + last_slash + 1, target, MAXPATH - (last_slash + 1));
    800055f6:	001b0513          	addi	a0,s6,1
    800055fa:	07f00613          	li	a2,127
    800055fe:	4166063b          	subw	a2,a2,s6
    80005602:	85ce                	mv	a1,s3
    80005604:	ea840793          	addi	a5,s0,-344
    80005608:	953e                	add	a0,a0,a5
    8000560a:	ff4fb0ef          	jal	80000dfe <safestrcpy>
    8000560e:	b731                	j	8000551a <sys_open+0x188>
              iunlockput(ip);
    80005610:	8526                	mv	a0,s1
    80005612:	f81fd0ef          	jal	80003592 <iunlockput>
              end_op();
    80005616:	9d7fe0ef          	jal	80003fec <end_op>
              return -1;
    8000561a:	64be                	ld	s1,456(sp)
    8000561c:	691e                	ld	s2,448(sp)
    8000561e:	79fa                	ld	s3,440(sp)
    80005620:	7a5a                	ld	s4,432(sp)
    80005622:	7aba                	ld	s5,424(sp)
    80005624:	7b1a                	ld	s6,416(sp)
    80005626:	6bfa                	ld	s7,408(sp)
    80005628:	a8a5                	j	800056a0 <sys_open+0x30e>
          end_op();
    8000562a:	9c3fe0ef          	jal	80003fec <end_op>
          return -1;
    8000562e:	64be                	ld	s1,456(sp)
    80005630:	691e                	ld	s2,448(sp)
    80005632:	79fa                	ld	s3,440(sp)
    80005634:	7a5a                	ld	s4,432(sp)
    80005636:	7aba                	ld	s5,424(sp)
    80005638:	7b1a                	ld	s6,416(sp)
    8000563a:	6bfa                	ld	s7,408(sp)
    8000563c:	a095                	j	800056a0 <sys_open+0x30e>
    8000563e:	691e                	ld	s2,448(sp)
    80005640:	79fa                	ld	s3,440(sp)
    80005642:	7a5a                	ld	s4,432(sp)
    80005644:	7aba                	ld	s5,424(sp)
    80005646:	7b1a                	ld	s6,416(sp)
    80005648:	6bfa                	ld	s7,408(sp)
    8000564a:	b379                	j	800053d8 <sys_open+0x46>
    8000564c:	fb52                	sd	s4,432(sp)
      while (ip->type == T_SYMLINK) {
    8000564e:	04449703          	lh	a4,68(s1)
    80005652:	4791                	li	a5,4
    80005654:	4a29                	li	s4,10
    80005656:	00f71b63          	bne	a4,a5,8000566c <sys_open+0x2da>
    8000565a:	e3ca                	sd	s2,448(sp)
    8000565c:	ff4e                	sd	s3,440(sp)
    8000565e:	f756                	sd	s5,424(sp)
    80005660:	f35a                	sd	s6,416(sp)
        if (readi(ip, 0, (uint64)target, 0, ip->size) != ip->size) {
    80005662:	e2840993          	addi	s3,s0,-472
        if (target[0] == '/') {
    80005666:	02f00913          	li	s2,47
    8000566a:	b5e5                	j	80005552 <sys_open+0x1c0>
    8000566c:	7a5a                	ld	s4,432(sp)
    8000566e:	6bfa                	ld	s7,408(sp)
    80005670:	b3a5                	j	800053d8 <sys_open+0x46>
    if (ip->type == T_DIR && omode != O_RDONLY) {
    80005672:	f2c42783          	lw	a5,-212(s0)
    80005676:	d6078ee3          	beqz	a5,800053f2 <sys_open+0x60>
    8000567a:	a0a1                	j	800056c2 <sys_open+0x330>
      iunlockput(ip);
    8000567c:	8526                	mv	a0,s1
    8000567e:	f15fd0ef          	jal	80003592 <iunlockput>
      end_op();
    80005682:	96bfe0ef          	jal	80003fec <end_op>
      return -1;
    80005686:	64be                	ld	s1,456(sp)
    80005688:	a821                	j	800056a0 <sys_open+0x30e>
        fileclose(f);
    8000568a:	854a                	mv	a0,s2
    8000568c:	d8dfe0ef          	jal	80004418 <fileclose>
    80005690:	79fa                	ld	s3,440(sp)
      iunlockput(ip);
    80005692:	8526                	mv	a0,s1
    80005694:	efffd0ef          	jal	80003592 <iunlockput>
      end_op();
    80005698:	955fe0ef          	jal	80003fec <end_op>
      return -1;
    8000569c:	64be                	ld	s1,456(sp)
    8000569e:	691e                	ld	s2,448(sp)
    return -1;
    800056a0:	557d                	li	a0,-1
  
}
    800056a2:	60fe                	ld	ra,472(sp)
    800056a4:	645e                	ld	s0,464(sp)
    800056a6:	613d                	addi	sp,sp,480
    800056a8:	8082                	ret
      f->type = FD_DEVICE;
    800056aa:	00e92023          	sw	a4,0(s2)
      f->major = ip->major;
    800056ae:	04649783          	lh	a5,70(s1)
    800056b2:	02f91223          	sh	a5,36(s2)
    800056b6:	b3a5                	j	8000541e <sys_open+0x8c>
      itrunc(ip);
    800056b8:	8526                	mv	a0,s1
    800056ba:	ce5fd0ef          	jal	8000339e <itrunc>
    800056be:	bb41                	j	8000544e <sys_open+0xbc>
    800056c0:	6bfa                	ld	s7,408(sp)
      iunlockput(ip);
    800056c2:	8526                	mv	a0,s1
    800056c4:	ecffd0ef          	jal	80003592 <iunlockput>
      end_op();
    800056c8:	925fe0ef          	jal	80003fec <end_op>
      return -1;
    800056cc:	64be                	ld	s1,456(sp)
    800056ce:	bfc9                	j	800056a0 <sys_open+0x30e>

00000000800056d0 <sys_mkdir>:
uint64
sys_mkdir(void)
{
    800056d0:	7175                	addi	sp,sp,-144
    800056d2:	e506                	sd	ra,136(sp)
    800056d4:	e122                	sd	s0,128(sp)
    800056d6:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    800056d8:	887fe0ef          	jal	80003f5e <begin_op>
  if (argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0) {
    800056dc:	08000613          	li	a2,128
    800056e0:	f7040593          	addi	a1,s0,-144
    800056e4:	4501                	li	a0,0
    800056e6:	964fd0ef          	jal	8000284a <argstr>
    800056ea:	02054363          	bltz	a0,80005710 <sys_mkdir+0x40>
    800056ee:	4681                	li	a3,0
    800056f0:	4601                	li	a2,0
    800056f2:	4585                	li	a1,1
    800056f4:	f7040513          	addi	a0,s0,-144
    800056f8:	f56ff0ef          	jal	80004e4e <create>
    800056fc:	c911                	beqz	a0,80005710 <sys_mkdir+0x40>
    end_op();
    return -1;
  }
  iunlockput(ip);
    800056fe:	e95fd0ef          	jal	80003592 <iunlockput>
  end_op();
    80005702:	8ebfe0ef          	jal	80003fec <end_op>
  return 0;
    80005706:	4501                	li	a0,0
}
    80005708:	60aa                	ld	ra,136(sp)
    8000570a:	640a                	ld	s0,128(sp)
    8000570c:	6149                	addi	sp,sp,144
    8000570e:	8082                	ret
    end_op();
    80005710:	8ddfe0ef          	jal	80003fec <end_op>
    return -1;
    80005714:	557d                	li	a0,-1
    80005716:	bfcd                	j	80005708 <sys_mkdir+0x38>

0000000080005718 <sys_mknod>:

uint64
sys_mknod(void)
{
    80005718:	7135                	addi	sp,sp,-160
    8000571a:	ed06                	sd	ra,152(sp)
    8000571c:	e922                	sd	s0,144(sp)
    8000571e:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80005720:	83ffe0ef          	jal	80003f5e <begin_op>
  argint(1, &major);
    80005724:	f6c40593          	addi	a1,s0,-148
    80005728:	4505                	li	a0,1
    8000572a:	8e8fd0ef          	jal	80002812 <argint>
  argint(2, &minor);
    8000572e:	f6840593          	addi	a1,s0,-152
    80005732:	4509                	li	a0,2
    80005734:	8defd0ef          	jal	80002812 <argint>
  if ((argstr(0, path, MAXPATH)) < 0 ||
    80005738:	08000613          	li	a2,128
    8000573c:	f7040593          	addi	a1,s0,-144
    80005740:	4501                	li	a0,0
    80005742:	908fd0ef          	jal	8000284a <argstr>
    80005746:	02054563          	bltz	a0,80005770 <sys_mknod+0x58>
      (ip = create(path, T_DEVICE, major, minor)) == 0) {
    8000574a:	f6841683          	lh	a3,-152(s0)
    8000574e:	f6c41603          	lh	a2,-148(s0)
    80005752:	458d                	li	a1,3
    80005754:	f7040513          	addi	a0,s0,-144
    80005758:	ef6ff0ef          	jal	80004e4e <create>
  if ((argstr(0, path, MAXPATH)) < 0 ||
    8000575c:	c911                	beqz	a0,80005770 <sys_mknod+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
    8000575e:	e35fd0ef          	jal	80003592 <iunlockput>
  end_op();
    80005762:	88bfe0ef          	jal	80003fec <end_op>
  return 0;
    80005766:	4501                	li	a0,0
}
    80005768:	60ea                	ld	ra,152(sp)
    8000576a:	644a                	ld	s0,144(sp)
    8000576c:	610d                	addi	sp,sp,160
    8000576e:	8082                	ret
    end_op();
    80005770:	87dfe0ef          	jal	80003fec <end_op>
    return -1;
    80005774:	557d                	li	a0,-1
    80005776:	bfcd                	j	80005768 <sys_mknod+0x50>

0000000080005778 <sys_chdir>:

uint64
sys_chdir(void)
{
    80005778:	7135                	addi	sp,sp,-160
    8000577a:	ed06                	sd	ra,152(sp)
    8000577c:	e922                	sd	s0,144(sp)
    8000577e:	e14a                	sd	s2,128(sp)
    80005780:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80005782:	960fc0ef          	jal	800018e2 <myproc>
    80005786:	892a                	mv	s2,a0

  begin_op();
    80005788:	fd6fe0ef          	jal	80003f5e <begin_op>
  if (argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0) {
    8000578c:	08000613          	li	a2,128
    80005790:	f6040593          	addi	a1,s0,-160
    80005794:	4501                	li	a0,0
    80005796:	8b4fd0ef          	jal	8000284a <argstr>
    8000579a:	02054f63          	bltz	a0,800057d8 <sys_chdir+0x60>
    8000579e:	e526                	sd	s1,136(sp)
    800057a0:	f6040513          	addi	a0,s0,-160
    800057a4:	c32fe0ef          	jal	80003bd6 <namei>
    800057a8:	84aa                	mv	s1,a0
    800057aa:	c515                	beqz	a0,800057d6 <sys_chdir+0x5e>
    end_op();
    return -1;
  }
  ilock(ip);
    800057ac:	b05fd0ef          	jal	800032b0 <ilock>
  if (ip->type != T_DIR) {
    800057b0:	04449703          	lh	a4,68(s1)
    800057b4:	4785                	li	a5,1
    800057b6:	02f71963          	bne	a4,a5,800057e8 <sys_chdir+0x70>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    800057ba:	8526                	mv	a0,s1
    800057bc:	ba3fd0ef          	jal	8000335e <iunlock>
  iput(p->cwd);
    800057c0:	15093503          	ld	a0,336(s2)
    800057c4:	cfdfd0ef          	jal	800034c0 <iput>
  end_op();
    800057c8:	825fe0ef          	jal	80003fec <end_op>
  p->cwd = ip;
    800057cc:	14993823          	sd	s1,336(s2)
  return 0;
    800057d0:	4501                	li	a0,0
    800057d2:	64aa                	ld	s1,136(sp)
    800057d4:	a029                	j	800057de <sys_chdir+0x66>
    800057d6:	64aa                	ld	s1,136(sp)
    end_op();
    800057d8:	815fe0ef          	jal	80003fec <end_op>
    return -1;
    800057dc:	557d                	li	a0,-1
}
    800057de:	60ea                	ld	ra,152(sp)
    800057e0:	644a                	ld	s0,144(sp)
    800057e2:	690a                	ld	s2,128(sp)
    800057e4:	610d                	addi	sp,sp,160
    800057e6:	8082                	ret
    iunlockput(ip);
    800057e8:	8526                	mv	a0,s1
    800057ea:	da9fd0ef          	jal	80003592 <iunlockput>
    end_op();
    800057ee:	ffefe0ef          	jal	80003fec <end_op>
    return -1;
    800057f2:	64aa                	ld	s1,136(sp)
    800057f4:	b7e5                	j	800057dc <sys_chdir+0x64>

00000000800057f6 <sys_exec>:

uint64
sys_exec(void)
{
    800057f6:	7105                	addi	sp,sp,-480
    800057f8:	ef86                	sd	ra,472(sp)
    800057fa:	eba2                	sd	s0,464(sp)
    800057fc:	1380                	addi	s0,sp,480
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    800057fe:	e2840593          	addi	a1,s0,-472
    80005802:	4505                	li	a0,1
    80005804:	82afd0ef          	jal	8000282e <argaddr>
  if (argstr(0, path, MAXPATH) < 0) {
    80005808:	08000613          	li	a2,128
    8000580c:	f3040593          	addi	a1,s0,-208
    80005810:	4501                	li	a0,0
    80005812:	838fd0ef          	jal	8000284a <argstr>
    80005816:	0c054e63          	bltz	a0,800058f2 <sys_exec+0xfc>
    8000581a:	e7a6                	sd	s1,456(sp)
    8000581c:	e3ca                	sd	s2,448(sp)
    8000581e:	ff4e                	sd	s3,440(sp)
    80005820:	fb52                	sd	s4,432(sp)
    80005822:	f756                	sd	s5,424(sp)
    80005824:	f35a                	sd	s6,416(sp)
    80005826:	ef5e                	sd	s7,408(sp)
    return -1;
  }
  memset(argv, 0, sizeof(argv));
    80005828:	e3040a13          	addi	s4,s0,-464
    8000582c:	10000613          	li	a2,256
    80005830:	4581                	li	a1,0
    80005832:	8552                	mv	a0,s4
    80005834:	c80fb0ef          	jal	80000cb4 <memset>
  for (i = 0;; i++) {
    if (i >= NELEM(argv)) {
    80005838:	84d2                	mv	s1,s4
  memset(argv, 0, sizeof(argv));
    8000583a:	89d2                	mv	s3,s4
    8000583c:	4901                	li	s2,0
      goto bad;
    }
    if (fetchaddr(uargv + sizeof(uint64) * i, (uint64 *)&uarg) < 0) {
    8000583e:	e2040a93          	addi	s5,s0,-480
      break;
    }
    argv[i] = kalloc();
    if (argv[i] == 0)
      goto bad;
    if (fetchstr(uarg, argv[i], PGSIZE) < 0)
    80005842:	6b05                	lui	s6,0x1
    if (i >= NELEM(argv)) {
    80005844:	02000b93          	li	s7,32
    if (fetchaddr(uargv + sizeof(uint64) * i, (uint64 *)&uarg) < 0) {
    80005848:	00391513          	slli	a0,s2,0x3
    8000584c:	85d6                	mv	a1,s5
    8000584e:	e2843783          	ld	a5,-472(s0)
    80005852:	953e                	add	a0,a0,a5
    80005854:	f37fc0ef          	jal	8000278a <fetchaddr>
    80005858:	02054663          	bltz	a0,80005884 <sys_exec+0x8e>
    if (uarg == 0) {
    8000585c:	e2043783          	ld	a5,-480(s0)
    80005860:	c3b9                	beqz	a5,800058a6 <sys_exec+0xb0>
    argv[i] = kalloc();
    80005862:	abcfb0ef          	jal	80000b1e <kalloc>
    80005866:	85aa                	mv	a1,a0
    80005868:	00a9b023          	sd	a0,0(s3)
    if (argv[i] == 0)
    8000586c:	cd01                	beqz	a0,80005884 <sys_exec+0x8e>
    if (fetchstr(uarg, argv[i], PGSIZE) < 0)
    8000586e:	865a                	mv	a2,s6
    80005870:	e2043503          	ld	a0,-480(s0)
    80005874:	f5dfc0ef          	jal	800027d0 <fetchstr>
    80005878:	00054663          	bltz	a0,80005884 <sys_exec+0x8e>
    if (i >= NELEM(argv)) {
    8000587c:	0905                	addi	s2,s2,1
    8000587e:	09a1                	addi	s3,s3,8
    80005880:	fd7914e3          	bne	s2,s7,80005848 <sys_exec+0x52>
    kfree(argv[i]);

  return ret;

bad:
  for (i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005884:	100a0a13          	addi	s4,s4,256
    80005888:	6088                	ld	a0,0(s1)
    8000588a:	cd29                	beqz	a0,800058e4 <sys_exec+0xee>
    kfree(argv[i]);
    8000588c:	9aafb0ef          	jal	80000a36 <kfree>
  for (i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005890:	04a1                	addi	s1,s1,8
    80005892:	ff449be3          	bne	s1,s4,80005888 <sys_exec+0x92>
    80005896:	64be                	ld	s1,456(sp)
    80005898:	691e                	ld	s2,448(sp)
    8000589a:	79fa                	ld	s3,440(sp)
    8000589c:	7a5a                	ld	s4,432(sp)
    8000589e:	7aba                	ld	s5,424(sp)
    800058a0:	7b1a                	ld	s6,416(sp)
    800058a2:	6bfa                	ld	s7,408(sp)
    800058a4:	a0b9                	j	800058f2 <sys_exec+0xfc>
      argv[i] = 0;
    800058a6:	0009079b          	sext.w	a5,s2
    800058aa:	e3040593          	addi	a1,s0,-464
    800058ae:	078e                	slli	a5,a5,0x3
    800058b0:	97ae                	add	a5,a5,a1
    800058b2:	0007b023          	sd	zero,0(a5)
  int ret = kexec(path, argv);
    800058b6:	f3040513          	addi	a0,s0,-208
    800058ba:	9eaff0ef          	jal	80004aa4 <kexec>
    800058be:	892a                	mv	s2,a0
  for (i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800058c0:	100a0a13          	addi	s4,s4,256
    800058c4:	6088                	ld	a0,0(s1)
    800058c6:	c511                	beqz	a0,800058d2 <sys_exec+0xdc>
    kfree(argv[i]);
    800058c8:	96efb0ef          	jal	80000a36 <kfree>
  for (i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800058cc:	04a1                	addi	s1,s1,8
    800058ce:	ff449be3          	bne	s1,s4,800058c4 <sys_exec+0xce>
  return ret;
    800058d2:	854a                	mv	a0,s2
    800058d4:	64be                	ld	s1,456(sp)
    800058d6:	691e                	ld	s2,448(sp)
    800058d8:	79fa                	ld	s3,440(sp)
    800058da:	7a5a                	ld	s4,432(sp)
    800058dc:	7aba                	ld	s5,424(sp)
    800058de:	7b1a                	ld	s6,416(sp)
    800058e0:	6bfa                	ld	s7,408(sp)
    800058e2:	a809                	j	800058f4 <sys_exec+0xfe>
    800058e4:	64be                	ld	s1,456(sp)
    800058e6:	691e                	ld	s2,448(sp)
    800058e8:	79fa                	ld	s3,440(sp)
    800058ea:	7a5a                	ld	s4,432(sp)
    800058ec:	7aba                	ld	s5,424(sp)
    800058ee:	7b1a                	ld	s6,416(sp)
    800058f0:	6bfa                	ld	s7,408(sp)
    return -1;
    800058f2:	557d                	li	a0,-1
  return -1;
}
    800058f4:	60fe                	ld	ra,472(sp)
    800058f6:	645e                	ld	s0,464(sp)
    800058f8:	613d                	addi	sp,sp,480
    800058fa:	8082                	ret

00000000800058fc <sys_pipe>:

uint64
sys_pipe(void)
{
    800058fc:	7139                	addi	sp,sp,-64
    800058fe:	fc06                	sd	ra,56(sp)
    80005900:	f822                	sd	s0,48(sp)
    80005902:	f426                	sd	s1,40(sp)
    80005904:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005906:	fddfb0ef          	jal	800018e2 <myproc>
    8000590a:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    8000590c:	fd840593          	addi	a1,s0,-40
    80005910:	4501                	li	a0,0
    80005912:	f1dfc0ef          	jal	8000282e <argaddr>
  if (pipealloc(&rf, &wf) < 0)
    80005916:	fc840593          	addi	a1,s0,-56
    8000591a:	fd040513          	addi	a0,s0,-48
    8000591e:	e1ffe0ef          	jal	8000473c <pipealloc>
    80005922:	0a054663          	bltz	a0,800059ce <sys_pipe+0xd2>
    return -1;
  fd0 = -1;
    80005926:	57fd                	li	a5,-1
    80005928:	fcf42223          	sw	a5,-60(s0)
  if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0) {
    8000592c:	fd043503          	ld	a0,-48(s0)
    80005930:	ce0ff0ef          	jal	80004e10 <fdalloc>
    80005934:	fca42223          	sw	a0,-60(s0)
    80005938:	08054363          	bltz	a0,800059be <sys_pipe+0xc2>
    8000593c:	fc843503          	ld	a0,-56(s0)
    80005940:	cd0ff0ef          	jal	80004e10 <fdalloc>
    80005944:	fca42023          	sw	a0,-64(s0)
    80005948:	06054263          	bltz	a0,800059ac <sys_pipe+0xb0>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if (copyout(p->pagetable, p->sz, fdarray, (char *)&fd0, sizeof(fd0)) < 0 ||
    8000594c:	4711                	li	a4,4
    8000594e:	fc440693          	addi	a3,s0,-60
    80005952:	fd843603          	ld	a2,-40(s0)
    80005956:	64ac                	ld	a1,72(s1)
    80005958:	68a8                	ld	a0,80(s1)
    8000595a:	bd3fb0ef          	jal	8000152c <copyout>
    8000595e:	02054063          	bltz	a0,8000597e <sys_pipe+0x82>
      copyout(p->pagetable, p->sz, fdarray + sizeof(fd0), (char *)&fd1,
    80005962:	4711                	li	a4,4
    80005964:	fc040693          	addi	a3,s0,-64
    80005968:	fd843603          	ld	a2,-40(s0)
    8000596c:	963a                	add	a2,a2,a4
    8000596e:	64ac                	ld	a1,72(s1)
    80005970:	68a8                	ld	a0,80(s1)
    80005972:	bbbfb0ef          	jal	8000152c <copyout>
    80005976:	87aa                	mv	a5,a0
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005978:	4501                	li	a0,0
  if (copyout(p->pagetable, p->sz, fdarray, (char *)&fd0, sizeof(fd0)) < 0 ||
    8000597a:	0407db63          	bgez	a5,800059d0 <sys_pipe+0xd4>
    p->ofile[fd0] = 0;
    8000597e:	fc442783          	lw	a5,-60(s0)
    80005982:	07e9                	addi	a5,a5,26
    80005984:	078e                	slli	a5,a5,0x3
    80005986:	97a6                	add	a5,a5,s1
    80005988:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    8000598c:	fc042783          	lw	a5,-64(s0)
    80005990:	07e9                	addi	a5,a5,26
    80005992:	078e                	slli	a5,a5,0x3
    80005994:	94be                	add	s1,s1,a5
    80005996:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    8000599a:	fd043503          	ld	a0,-48(s0)
    8000599e:	a7bfe0ef          	jal	80004418 <fileclose>
    fileclose(wf);
    800059a2:	fc843503          	ld	a0,-56(s0)
    800059a6:	a73fe0ef          	jal	80004418 <fileclose>
    return -1;
    800059aa:	a015                	j	800059ce <sys_pipe+0xd2>
    if (fd0 >= 0)
    800059ac:	fc442783          	lw	a5,-60(s0)
    800059b0:	0007c763          	bltz	a5,800059be <sys_pipe+0xc2>
      p->ofile[fd0] = 0;
    800059b4:	07e9                	addi	a5,a5,26
    800059b6:	078e                	slli	a5,a5,0x3
    800059b8:	97a6                	add	a5,a5,s1
    800059ba:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    800059be:	fd043503          	ld	a0,-48(s0)
    800059c2:	a57fe0ef          	jal	80004418 <fileclose>
    fileclose(wf);
    800059c6:	fc843503          	ld	a0,-56(s0)
    800059ca:	a4ffe0ef          	jal	80004418 <fileclose>
    return -1;
    800059ce:	557d                	li	a0,-1
}
    800059d0:	70e2                	ld	ra,56(sp)
    800059d2:	7442                	ld	s0,48(sp)
    800059d4:	74a2                	ld	s1,40(sp)
    800059d6:	6121                	addi	sp,sp,64
    800059d8:	8082                	ret

00000000800059da <sys_istat>:

uint64
sys_istat(void)
{
    800059da:	716d                	addi	sp,sp,-272
    800059dc:	e606                	sd	ra,264(sp)
    800059de:	e222                	sd	s0,256(sp)
    800059e0:	0a00                	addi	s0,sp,272
  char path[MAXPATH];
  uint64 dst;
  struct inode *ip;
  struct istat_info info = {0};
    800059e2:	ee043823          	sd	zero,-272(s0)
    800059e6:	ee043c23          	sd	zero,-264(s0)
    800059ea:	f0043023          	sd	zero,-256(s0)
    800059ee:	f0043423          	sd	zero,-248(s0)
    800059f2:	f0043823          	sd	zero,-240(s0)
    800059f6:	f0043c23          	sd	zero,-232(s0)
    800059fa:	f2043023          	sd	zero,-224(s0)
    800059fe:	f2043423          	sd	zero,-216(s0)
    80005a02:	f2043823          	sd	zero,-208(s0)
    80005a06:	f2043c23          	sd	zero,-200(s0)
    80005a0a:	f4043023          	sd	zero,-192(s0)
    80005a0e:	f4043423          	sd	zero,-184(s0)
    80005a12:	f4042823          	sw	zero,-176(s0)

  if (argstr(0, path, MAXPATH) < 0)
    80005a16:	08000613          	li	a2,128
    80005a1a:	f6040593          	addi	a1,s0,-160
    80005a1e:	4501                	li	a0,0
    80005a20:	e2bfc0ef          	jal	8000284a <argstr>
    80005a24:	08054d63          	bltz	a0,80005abe <sys_istat+0xe4>
    80005a28:	fda6                	sd	s1,248(sp)
    return -1;

  argaddr(1, &dst);
    80005a2a:	f5840593          	addi	a1,s0,-168
    80005a2e:	4505                	li	a0,1
    80005a30:	dfffc0ef          	jal	8000282e <argaddr>

  begin_op();
    80005a34:	d2afe0ef          	jal	80003f5e <begin_op>
  if ((ip = namei(path)) == 0) {
    80005a38:	f6040513          	addi	a0,s0,-160
    80005a3c:	99afe0ef          	jal	80003bd6 <namei>
    80005a40:	84aa                	mv	s1,a0
    80005a42:	c93d                	beqz	a0,80005ab8 <sys_istat+0xde>
    end_op();
    return -1;
  }

  ilock(ip);
    80005a44:	86dfd0ef          	jal	800032b0 <ilock>

  get_superblock(&info.sb);
    80005a48:	ef040513          	addi	a0,s0,-272
    80005a4c:	9bcfe0ef          	jal	80003c08 <get_superblock>
  info.inum = ip->inum;
    80005a50:	40dc                	lw	a5,4(s1)
    80005a52:	f0f42a23          	sw	a5,-236(s0)
  info.type = ip->type;
    80005a56:	0444d783          	lhu	a5,68(s1)
    80005a5a:	f0f41c23          	sh	a5,-232(s0)
  info.nlink = ip->nlink;
    80005a5e:	04a4d783          	lhu	a5,74(s1)
    80005a62:	f0f41d23          	sh	a5,-230(s0)
  info.size = ip->size;
    80005a66:	44fc                	lw	a5,76(s1)
    80005a68:	f0f42e23          	sw	a5,-228(s0)

  for (int i = 0; i < NELEM(ip->addrs); i++)
    80005a6c:	05048713          	addi	a4,s1,80
    80005a70:	f2040793          	addi	a5,s0,-224
    80005a74:	f5440613          	addi	a2,s0,-172
    info.addrs[i] = ip->addrs[i];
    80005a78:	4314                	lw	a3,0(a4)
    80005a7a:	c394                	sw	a3,0(a5)
  for (int i = 0; i < NELEM(ip->addrs); i++)
    80005a7c:	0711                	addi	a4,a4,4
    80005a7e:	0791                	addi	a5,a5,4
    80005a80:	fec79ce3          	bne	a5,a2,80005a78 <sys_istat+0x9e>

  iunlockput(ip);
    80005a84:	8526                	mv	a0,s1
    80005a86:	b0dfd0ef          	jal	80003592 <iunlockput>
  end_op();
    80005a8a:	d62fe0ef          	jal	80003fec <end_op>

  if (copyout(myproc()->pagetable, myproc()->sz, dst, (char *)&info,
    80005a8e:	e55fb0ef          	jal	800018e2 <myproc>
    80005a92:	6924                	ld	s1,80(a0)
    80005a94:	e4ffb0ef          	jal	800018e2 <myproc>
    80005a98:	06400713          	li	a4,100
    80005a9c:	ef040693          	addi	a3,s0,-272
    80005aa0:	f5843603          	ld	a2,-168(s0)
    80005aa4:	652c                	ld	a1,72(a0)
    80005aa6:	8526                	mv	a0,s1
    80005aa8:	a85fb0ef          	jal	8000152c <copyout>
    80005aac:	957d                	srai	a0,a0,0x3f
    80005aae:	74ee                	ld	s1,248(sp)
              sizeof(info)) < 0)
    return -1;

  return 0;
}
    80005ab0:	60b2                	ld	ra,264(sp)
    80005ab2:	6412                	ld	s0,256(sp)
    80005ab4:	6151                	addi	sp,sp,272
    80005ab6:	8082                	ret
    end_op();
    80005ab8:	d34fe0ef          	jal	80003fec <end_op>
    return -1;
    80005abc:	74ee                	ld	s1,248(sp)
    return -1;
    80005abe:	557d                	li	a0,-1
    80005ac0:	bfc5                	j	80005ab0 <sys_istat+0xd6>

0000000080005ac2 <sys_iprint>:

uint64
sys_iprint(void)
{
    80005ac2:	7135                	addi	sp,sp,-160
    80005ac4:	ed06                	sd	ra,152(sp)
    80005ac6:	e922                	sd	s0,144(sp)
    80005ac8:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;

  if (argstr(0, path, MAXPATH) < 0)
    80005aca:	08000613          	li	a2,128
    80005ace:	f6040593          	addi	a1,s0,-160
    80005ad2:	4501                	li	a0,0
    80005ad4:	d77fc0ef          	jal	8000284a <argstr>
    80005ad8:	02054e63          	bltz	a0,80005b14 <sys_iprint+0x52>
    80005adc:	e526                	sd	s1,136(sp)
    return -1;

  begin_op();
    80005ade:	c80fe0ef          	jal	80003f5e <begin_op>
  if ((ip = namei(path)) == 0) {
    80005ae2:	f6040513          	addi	a0,s0,-160
    80005ae6:	8f0fe0ef          	jal	80003bd6 <namei>
    80005aea:	84aa                	mv	s1,a0
    80005aec:	c10d                	beqz	a0,80005b0e <sys_iprint+0x4c>
    end_op();
    return -1;
  }

  ilock(ip);
    80005aee:	fc2fd0ef          	jal	800032b0 <ilock>
  itreeprint(ip);
    80005af2:	8526                	mv	a0,s1
    80005af4:	960fe0ef          	jal	80003c54 <itreeprint>
  iunlockput(ip);
    80005af8:	8526                	mv	a0,s1
    80005afa:	a99fd0ef          	jal	80003592 <iunlockput>
  end_op();
    80005afe:	ceefe0ef          	jal	80003fec <end_op>

  return 0;
    80005b02:	4501                	li	a0,0
    80005b04:	64aa                	ld	s1,136(sp)
}
    80005b06:	60ea                	ld	ra,152(sp)
    80005b08:	644a                	ld	s0,144(sp)
    80005b0a:	610d                	addi	sp,sp,160
    80005b0c:	8082                	ret
    end_op();
    80005b0e:	cdefe0ef          	jal	80003fec <end_op>
    return -1;
    80005b12:	64aa                	ld	s1,136(sp)
    return -1;
    80005b14:	557d                	li	a0,-1
    80005b16:	bfc5                	j	80005b06 <sys_iprint+0x44>

0000000080005b18 <sys_symlink>:

uint64
sys_symlink(void)
{
    80005b18:	7129                	addi	sp,sp,-320
    80005b1a:	fe06                	sd	ra,312(sp)
    80005b1c:	fa22                	sd	s0,304(sp)
    80005b1e:	0280                	addi	s0,sp,320
  char target[MAXPATH], path[MAXPATH];
  char name[DIRSIZ];
  struct inode *dp, *ip;

  if (argstr(0, target, MAXPATH) < 0 || argstr(1, path, MAXPATH) < 0)
    80005b20:	08000613          	li	a2,128
    80005b24:	f5040593          	addi	a1,s0,-176
    80005b28:	4501                	li	a0,0
    80005b2a:	d21fc0ef          	jal	8000284a <argstr>
    80005b2e:	0e054963          	bltz	a0,80005c20 <sys_symlink+0x108>
    80005b32:	08000613          	li	a2,128
    80005b36:	ed040593          	addi	a1,s0,-304
    80005b3a:	4505                	li	a0,1
    80005b3c:	d0ffc0ef          	jal	8000284a <argstr>
    80005b40:	0e054063          	bltz	a0,80005c20 <sys_symlink+0x108>
    return -1;
  if (target[0] == '\0' || path[0] == '\0')
    80005b44:	f5044783          	lbu	a5,-176(s0)
    80005b48:	0c078c63          	beqz	a5,80005c20 <sys_symlink+0x108>
    80005b4c:	ed044783          	lbu	a5,-304(s0)
    80005b50:	0c078863          	beqz	a5,80005c20 <sys_symlink+0x108>
    80005b54:	ee4e                	sd	s3,280(sp)
    return -1;

  begin_op();
    80005b56:	c08fe0ef          	jal	80003f5e <begin_op>

  if ((dp = nameiparent(path, name)) == 0) {
    80005b5a:	ec040593          	addi	a1,s0,-320
    80005b5e:	ed040513          	addi	a0,s0,-304
    80005b62:	88efe0ef          	jal	80003bf0 <nameiparent>
    80005b66:	89aa                	mv	s3,a0
    80005b68:	c559                	beqz	a0,80005bf6 <sys_symlink+0xde>
    80005b6a:	f626                	sd	s1,296(sp)
    end_op();
    return -1;
  }

  ilock(dp);
    80005b6c:	f44fd0ef          	jal	800032b0 <ilock>

  if (dp->nlink == 0) {
    80005b70:	04a99783          	lh	a5,74(s3)
    80005b74:	c7c9                	beqz	a5,80005bfe <sys_symlink+0xe6>
    iunlockput(dp);
    end_op();
    return -1;
  }

  if ((ip = dirlookup(dp, name, 0)) != 0) {
    80005b76:	4601                	li	a2,0
    80005b78:	ec040593          	addi	a1,s0,-320
    80005b7c:	854e                	mv	a0,s3
    80005b7e:	daffd0ef          	jal	8000392c <dirlookup>
    80005b82:	e551                	bnez	a0,80005c0e <sys_symlink+0xf6>
    iunlockput(dp);
    end_op();
    return -1;
  }

  if ((ip = ialloc(dp->dev, T_SYMLINK)) == 0) {
    80005b84:	4591                	li	a1,4
    80005b86:	0009a503          	lw	a0,0(s3)
    80005b8a:	db6fd0ef          	jal	80003140 <ialloc>
    80005b8e:	84aa                	mv	s1,a0
    80005b90:	cd49                	beqz	a0,80005c2a <sys_symlink+0x112>
    80005b92:	f24a                	sd	s2,288(sp)
    iunlockput(dp);
    end_op();
    return -1;
  }

  ilock(ip);
    80005b94:	f1cfd0ef          	jal	800032b0 <ilock>
  ip->major = 0;
    80005b98:	04049323          	sh	zero,70(s1)
  ip->minor = 0;
    80005b9c:	04049423          	sh	zero,72(s1)
  ip->nlink = 1;
    80005ba0:	4785                	li	a5,1
    80005ba2:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80005ba6:	8526                	mv	a0,s1
    80005ba8:	e54fd0ef          	jal	800031fc <iupdate>

  // store target as zero-terminated string
  int len = strlen(target) + 1;
    80005bac:	f5040513          	addi	a0,s0,-176
    80005bb0:	a84fb0ef          	jal	80000e34 <strlen>
    80005bb4:	0015071b          	addiw	a4,a0,1
    80005bb8:	893a                	mv	s2,a4
  if (writei(ip, 0, (uint64)target, 0, len) != len) {
    80005bba:	4681                	li	a3,0
    80005bbc:	f5040613          	addi	a2,s0,-176
    80005bc0:	4581                	li	a1,0
    80005bc2:	8526                	mv	a0,s1
    80005bc4:	c47fd0ef          	jal	8000380a <writei>
    80005bc8:	07251963          	bne	a0,s2,80005c3a <sys_symlink+0x122>
    end_op();
    return -1;
  }

  //only link into directory once target write succeeds
  if (dirlink(dp, name, ip->inum) < 0) {
    80005bcc:	40d0                	lw	a2,4(s1)
    80005bce:	ec040593          	addi	a1,s0,-320
    80005bd2:	854e                	mv	a0,s3
    80005bd4:	f59fd0ef          	jal	80003b2c <dirlink>
    80005bd8:	08054263          	bltz	a0,80005c5c <sys_symlink+0x144>
    iunlockput(dp);
    end_op();
    return -1;
  }

  iunlockput(ip);
    80005bdc:	8526                	mv	a0,s1
    80005bde:	9b5fd0ef          	jal	80003592 <iunlockput>
  iunlockput(dp);
    80005be2:	854e                	mv	a0,s3
    80005be4:	9affd0ef          	jal	80003592 <iunlockput>
  end_op();
    80005be8:	c04fe0ef          	jal	80003fec <end_op>
  return 0;
    80005bec:	4501                	li	a0,0
    80005bee:	74b2                	ld	s1,296(sp)
    80005bf0:	7912                	ld	s2,288(sp)
    80005bf2:	69f2                	ld	s3,280(sp)
    80005bf4:	a03d                	j	80005c22 <sys_symlink+0x10a>
    end_op();
    80005bf6:	bf6fe0ef          	jal	80003fec <end_op>
    return -1;
    80005bfa:	69f2                	ld	s3,280(sp)
    80005bfc:	a015                	j	80005c20 <sys_symlink+0x108>
    iunlockput(dp);
    80005bfe:	854e                	mv	a0,s3
    80005c00:	993fd0ef          	jal	80003592 <iunlockput>
    end_op();
    80005c04:	be8fe0ef          	jal	80003fec <end_op>
    return -1;
    80005c08:	74b2                	ld	s1,296(sp)
    80005c0a:	69f2                	ld	s3,280(sp)
    80005c0c:	a811                	j	80005c20 <sys_symlink+0x108>
    iput(ip);
    80005c0e:	8b3fd0ef          	jal	800034c0 <iput>
    iunlockput(dp);
    80005c12:	854e                	mv	a0,s3
    80005c14:	97ffd0ef          	jal	80003592 <iunlockput>
    end_op();
    80005c18:	bd4fe0ef          	jal	80003fec <end_op>
    return -1;
    80005c1c:	74b2                	ld	s1,296(sp)
    80005c1e:	69f2                	ld	s3,280(sp)
    return -1;
    80005c20:	557d                	li	a0,-1
    80005c22:	70f2                	ld	ra,312(sp)
    80005c24:	7452                	ld	s0,304(sp)
    80005c26:	6131                	addi	sp,sp,320
    80005c28:	8082                	ret
    iunlockput(dp);
    80005c2a:	854e                	mv	a0,s3
    80005c2c:	967fd0ef          	jal	80003592 <iunlockput>
    end_op();
    80005c30:	bbcfe0ef          	jal	80003fec <end_op>
    return -1;
    80005c34:	74b2                	ld	s1,296(sp)
    80005c36:	69f2                	ld	s3,280(sp)
    80005c38:	b7e5                	j	80005c20 <sys_symlink+0x108>
    ip->nlink = 0;
    80005c3a:	04049523          	sh	zero,74(s1)
    iupdate(ip);
    80005c3e:	8526                	mv	a0,s1
    80005c40:	dbcfd0ef          	jal	800031fc <iupdate>
    iunlockput(ip);
    80005c44:	8526                	mv	a0,s1
    80005c46:	94dfd0ef          	jal	80003592 <iunlockput>
    iunlockput(dp);
    80005c4a:	854e                	mv	a0,s3
    80005c4c:	947fd0ef          	jal	80003592 <iunlockput>
    end_op();
    80005c50:	b9cfe0ef          	jal	80003fec <end_op>
    return -1;
    80005c54:	74b2                	ld	s1,296(sp)
    80005c56:	7912                	ld	s2,288(sp)
    80005c58:	69f2                	ld	s3,280(sp)
    80005c5a:	b7d9                	j	80005c20 <sys_symlink+0x108>
    ip->nlink = 0;
    80005c5c:	04049523          	sh	zero,74(s1)
    iupdate(ip);
    80005c60:	8526                	mv	a0,s1
    80005c62:	d9afd0ef          	jal	800031fc <iupdate>
    iunlockput(ip);
    80005c66:	8526                	mv	a0,s1
    80005c68:	92bfd0ef          	jal	80003592 <iunlockput>
    iunlockput(dp);
    80005c6c:	854e                	mv	a0,s3
    80005c6e:	925fd0ef          	jal	80003592 <iunlockput>
    end_op();
    80005c72:	b7afe0ef          	jal	80003fec <end_op>
    return -1;
    80005c76:	74b2                	ld	s1,296(sp)
    80005c78:	7912                	ld	s2,288(sp)
    80005c7a:	69f2                	ld	s3,280(sp)
    80005c7c:	b755                	j	80005c20 <sys_symlink+0x108>
	...

0000000080005c80 <kernelvec>:
.globl kerneltrap
.globl kernelvec
.align 4
kernelvec:
        # make room to save registers.
        addi sp, sp, -256
    80005c80:	7111                	addi	sp,sp,-256

        # save caller-saved registers.
        sd ra, 0(sp)
    80005c82:	e006                	sd	ra,0(sp)
        # sd sp, 8(sp)
        sd gp, 16(sp)
    80005c84:	e80e                	sd	gp,16(sp)
        # sd tp, 24(sp)
        sd t0, 32(sp)
    80005c86:	f016                	sd	t0,32(sp)
        sd t1, 40(sp)
    80005c88:	f41a                	sd	t1,40(sp)
        sd t2, 48(sp)
    80005c8a:	f81e                	sd	t2,48(sp)
        sd a0, 72(sp)
    80005c8c:	e4aa                	sd	a0,72(sp)
        sd a1, 80(sp)
    80005c8e:	e8ae                	sd	a1,80(sp)
        sd a2, 88(sp)
    80005c90:	ecb2                	sd	a2,88(sp)
        sd a3, 96(sp)
    80005c92:	f0b6                	sd	a3,96(sp)
        sd a4, 104(sp)
    80005c94:	f4ba                	sd	a4,104(sp)
        sd a5, 112(sp)
    80005c96:	f8be                	sd	a5,112(sp)
        sd a6, 120(sp)
    80005c98:	fcc2                	sd	a6,120(sp)
        sd a7, 128(sp)
    80005c9a:	e146                	sd	a7,128(sp)
        sd t3, 216(sp)
    80005c9c:	edf2                	sd	t3,216(sp)
        sd t4, 224(sp)
    80005c9e:	f1f6                	sd	t4,224(sp)
        sd t5, 232(sp)
    80005ca0:	f5fa                	sd	t5,232(sp)
        sd t6, 240(sp)
    80005ca2:	f9fe                	sd	t6,240(sp)

        # call the C trap handler in trap.c
        call kerneltrap
    80005ca4:	9f5fc0ef          	jal	80002698 <kerneltrap>

        # restore registers.
        ld ra, 0(sp)
    80005ca8:	6082                	ld	ra,0(sp)
        # ld sp, 8(sp)
        ld gp, 16(sp)
    80005caa:	61c2                	ld	gp,16(sp)
        # not tp (contains hartid), in case we moved CPUs
        ld t0, 32(sp)
    80005cac:	7282                	ld	t0,32(sp)
        ld t1, 40(sp)
    80005cae:	7322                	ld	t1,40(sp)
        ld t2, 48(sp)
    80005cb0:	73c2                	ld	t2,48(sp)
        ld a0, 72(sp)
    80005cb2:	6526                	ld	a0,72(sp)
        ld a1, 80(sp)
    80005cb4:	65c6                	ld	a1,80(sp)
        ld a2, 88(sp)
    80005cb6:	6666                	ld	a2,88(sp)
        ld a3, 96(sp)
    80005cb8:	7686                	ld	a3,96(sp)
        ld a4, 104(sp)
    80005cba:	7726                	ld	a4,104(sp)
        ld a5, 112(sp)
    80005cbc:	77c6                	ld	a5,112(sp)
        ld a6, 120(sp)
    80005cbe:	7866                	ld	a6,120(sp)
        ld a7, 128(sp)
    80005cc0:	688a                	ld	a7,128(sp)
        ld t3, 216(sp)
    80005cc2:	6e6e                	ld	t3,216(sp)
        ld t4, 224(sp)
    80005cc4:	7e8e                	ld	t4,224(sp)
        ld t5, 232(sp)
    80005cc6:	7f2e                	ld	t5,232(sp)
        ld t6, 240(sp)
    80005cc8:	7fce                	ld	t6,240(sp)

        addi sp, sp, 256
    80005cca:	6111                	addi	sp,sp,256

        # return to whatever we were doing in the kernel.
        sret
    80005ccc:	10200073          	sret
    80005cd0:	0001                	nop
    80005cd2:	00000013          	nop
    80005cd6:	00000013          	nop
    80005cda:	00000013          	nop

0000000080005cde <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    80005cde:	1141                	addi	sp,sp,-16
    80005ce0:	e406                	sd	ra,8(sp)
    80005ce2:	e022                	sd	s0,0(sp)
    80005ce4:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32 *)(PLIC + UART0_IRQ * 4) = 1;
    80005ce6:	0c000737          	lui	a4,0xc000
    80005cea:	4785                	li	a5,1
    80005cec:	d71c                	sw	a5,40(a4)
  *(uint32 *)(PLIC + VIRTIO0_IRQ * 4) = 1;
    80005cee:	c35c                	sw	a5,4(a4)
}
    80005cf0:	60a2                	ld	ra,8(sp)
    80005cf2:	6402                	ld	s0,0(sp)
    80005cf4:	0141                	addi	sp,sp,16
    80005cf6:	8082                	ret

0000000080005cf8 <plicinithart>:

void
plicinithart(void)
{
    80005cf8:	1141                	addi	sp,sp,-16
    80005cfa:	e406                	sd	ra,8(sp)
    80005cfc:	e022                	sd	s0,0(sp)
    80005cfe:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005d00:	baffb0ef          	jal	800018ae <cpuid>

  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32 *)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005d04:	0085171b          	slliw	a4,a0,0x8
    80005d08:	0c0027b7          	lui	a5,0xc002
    80005d0c:	97ba                	add	a5,a5,a4
    80005d0e:	40200713          	li	a4,1026
    80005d12:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32 *)PLIC_SPRIORITY(hart) = 0;
    80005d16:	00d5151b          	slliw	a0,a0,0xd
    80005d1a:	0c2017b7          	lui	a5,0xc201
    80005d1e:	97aa                	add	a5,a5,a0
    80005d20:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80005d24:	60a2                	ld	ra,8(sp)
    80005d26:	6402                	ld	s0,0(sp)
    80005d28:	0141                	addi	sp,sp,16
    80005d2a:	8082                	ret

0000000080005d2c <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005d2c:	1141                	addi	sp,sp,-16
    80005d2e:	e406                	sd	ra,8(sp)
    80005d30:	e022                	sd	s0,0(sp)
    80005d32:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005d34:	b7bfb0ef          	jal	800018ae <cpuid>
  int irq = *(uint32 *)PLIC_SCLAIM(hart);
    80005d38:	00d5151b          	slliw	a0,a0,0xd
    80005d3c:	0c2017b7          	lui	a5,0xc201
    80005d40:	97aa                	add	a5,a5,a0
  return irq;
}
    80005d42:	43c8                	lw	a0,4(a5)
    80005d44:	60a2                	ld	ra,8(sp)
    80005d46:	6402                	ld	s0,0(sp)
    80005d48:	0141                	addi	sp,sp,16
    80005d4a:	8082                	ret

0000000080005d4c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80005d4c:	1101                	addi	sp,sp,-32
    80005d4e:	ec06                	sd	ra,24(sp)
    80005d50:	e822                	sd	s0,16(sp)
    80005d52:	e426                	sd	s1,8(sp)
    80005d54:	1000                	addi	s0,sp,32
    80005d56:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005d58:	b57fb0ef          	jal	800018ae <cpuid>
  *(uint32 *)PLIC_SCLAIM(hart) = irq;
    80005d5c:	00d5179b          	slliw	a5,a0,0xd
    80005d60:	0c201737          	lui	a4,0xc201
    80005d64:	97ba                	add	a5,a5,a4
    80005d66:	c3c4                	sw	s1,4(a5)
}
    80005d68:	60e2                	ld	ra,24(sp)
    80005d6a:	6442                	ld	s0,16(sp)
    80005d6c:	64a2                	ld	s1,8(sp)
    80005d6e:	6105                	addi	sp,sp,32
    80005d70:	8082                	ret

0000000080005d72 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80005d72:	1141                	addi	sp,sp,-16
    80005d74:	e406                	sd	ra,8(sp)
    80005d76:	e022                	sd	s0,0(sp)
    80005d78:	0800                	addi	s0,sp,16
  if (i >= NUM)
    80005d7a:	479d                	li	a5,7
    80005d7c:	04a7ca63          	blt	a5,a0,80005dd0 <free_desc+0x5e>
    panic("free_desc 1");
  if (disk.free[i])
    80005d80:	00055797          	auipc	a5,0x55
    80005d84:	0f078793          	addi	a5,a5,240 # 8005ae70 <disk>
    80005d88:	97aa                	add	a5,a5,a0
    80005d8a:	0187c783          	lbu	a5,24(a5)
    80005d8e:	e7b9                	bnez	a5,80005ddc <free_desc+0x6a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80005d90:	00451693          	slli	a3,a0,0x4
    80005d94:	00055797          	auipc	a5,0x55
    80005d98:	0dc78793          	addi	a5,a5,220 # 8005ae70 <disk>
    80005d9c:	6398                	ld	a4,0(a5)
    80005d9e:	9736                	add	a4,a4,a3
    80005da0:	00073023          	sd	zero,0(a4) # c201000 <_entry-0x73dff000>
  disk.desc[i].len = 0;
    80005da4:	6398                	ld	a4,0(a5)
    80005da6:	9736                	add	a4,a4,a3
    80005da8:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    80005dac:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    80005db0:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    80005db4:	97aa                	add	a5,a5,a0
    80005db6:	4705                	li	a4,1
    80005db8:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    80005dbc:	00055517          	auipc	a0,0x55
    80005dc0:	0cc50513          	addi	a0,a0,204 # 8005ae88 <disk+0x18>
    80005dc4:	992fc0ef          	jal	80001f56 <wakeup>
}
    80005dc8:	60a2                	ld	ra,8(sp)
    80005dca:	6402                	ld	s0,0(sp)
    80005dcc:	0141                	addi	sp,sp,16
    80005dce:	8082                	ret
    panic("free_desc 1");
    80005dd0:	00003517          	auipc	a0,0x3
    80005dd4:	8d050513          	addi	a0,a0,-1840 # 800086a0 <etext+0x6a0>
    80005dd8:	a71fa0ef          	jal	80000848 <panic>
    panic("free_desc 2");
    80005ddc:	00003517          	auipc	a0,0x3
    80005de0:	8d450513          	addi	a0,a0,-1836 # 800086b0 <etext+0x6b0>
    80005de4:	a65fa0ef          	jal	80000848 <panic>

0000000080005de8 <virtio_disk_init>:
{
    80005de8:	1101                	addi	sp,sp,-32
    80005dea:	ec06                	sd	ra,24(sp)
    80005dec:	e822                	sd	s0,16(sp)
    80005dee:	e426                	sd	s1,8(sp)
    80005df0:	e04a                	sd	s2,0(sp)
    80005df2:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005df4:	00003597          	auipc	a1,0x3
    80005df8:	8cc58593          	addi	a1,a1,-1844 # 800086c0 <etext+0x6c0>
    80005dfc:	00055517          	auipc	a0,0x55
    80005e00:	19c50513          	addi	a0,a0,412 # 8005af98 <disk+0x128>
    80005e04:	d75fa0ef          	jal	80000b78 <initlock>
  if (*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005e08:	100017b7          	lui	a5,0x10001
    80005e0c:	4398                	lw	a4,0(a5)
    80005e0e:	747277b7          	lui	a5,0x74727
    80005e12:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005e16:	14f71263          	bne	a4,a5,80005f5a <virtio_disk_init+0x172>
      *R(VIRTIO_MMIO_VERSION) != 2 || *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005e1a:	100017b7          	lui	a5,0x10001
    80005e1e:	43d8                	lw	a4,4(a5)
  if (*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005e20:	4789                	li	a5,2
    80005e22:	12f71c63          	bne	a4,a5,80005f5a <virtio_disk_init+0x172>
      *R(VIRTIO_MMIO_VERSION) != 2 || *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005e26:	100017b7          	lui	a5,0x10001
    80005e2a:	4798                	lw	a4,8(a5)
    80005e2c:	4789                	li	a5,2
    80005e2e:	12f71663          	bne	a4,a5,80005f5a <virtio_disk_init+0x172>
      *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551) {
    80005e32:	100017b7          	lui	a5,0x10001
    80005e36:	47d8                	lw	a4,12(a5)
      *R(VIRTIO_MMIO_VERSION) != 2 || *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005e38:	554d47b7          	lui	a5,0x554d4
    80005e3c:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005e40:	10f71d63          	bne	a4,a5,80005f5a <virtio_disk_init+0x172>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005e44:	100017b7          	lui	a5,0x10001
    80005e48:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005e4c:	4705                	li	a4,1
    80005e4e:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005e50:	470d                	li	a4,3
    80005e52:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005e54:	10001737          	lui	a4,0x10001
    80005e58:	4b18                	lw	a4,16(a4)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005e5a:	c7ffe6b7          	lui	a3,0xc7ffe
    80005e5e:	55f68693          	addi	a3,a3,1375 # ffffffffc7ffe55f <end+0xffffffff47fa35af>
    80005e62:	8f75                	and	a4,a4,a3
    80005e64:	100016b7          	lui	a3,0x10001
    80005e68:	d298                	sw	a4,32(a3)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005e6a:	472d                	li	a4,11
    80005e6c:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    80005e6e:	0707a903          	lw	s2,112(a5)
  if (!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80005e72:	00897793          	andi	a5,s2,8
    80005e76:	0e078863          	beqz	a5,80005f66 <virtio_disk_init+0x17e>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005e7a:	100017b7          	lui	a5,0x10001
    80005e7e:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if (*R(VIRTIO_MMIO_QUEUE_READY))
    80005e82:	43fc                	lw	a5,68(a5)
    80005e84:	0e079763          	bnez	a5,80005f72 <virtio_disk_init+0x18a>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005e88:	100017b7          	lui	a5,0x10001
    80005e8c:	5bdc                	lw	a5,52(a5)
  if (max == 0)
    80005e8e:	0e078863          	beqz	a5,80005f7e <virtio_disk_init+0x196>
  if (max < NUM)
    80005e92:	471d                	li	a4,7
    80005e94:	0ef77b63          	bgeu	a4,a5,80005f8a <virtio_disk_init+0x1a2>
  disk.desc = kalloc();
    80005e98:	c87fa0ef          	jal	80000b1e <kalloc>
    80005e9c:	00055497          	auipc	s1,0x55
    80005ea0:	fd448493          	addi	s1,s1,-44 # 8005ae70 <disk>
    80005ea4:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    80005ea6:	c79fa0ef          	jal	80000b1e <kalloc>
    80005eaa:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    80005eac:	c73fa0ef          	jal	80000b1e <kalloc>
    80005eb0:	87aa                	mv	a5,a0
    80005eb2:	e888                	sd	a0,16(s1)
  if (!disk.desc || !disk.avail || !disk.used)
    80005eb4:	6088                	ld	a0,0(s1)
    80005eb6:	0e050063          	beqz	a0,80005f96 <virtio_disk_init+0x1ae>
    80005eba:	00055717          	auipc	a4,0x55
    80005ebe:	fbe73703          	ld	a4,-66(a4) # 8005ae78 <disk+0x8>
    80005ec2:	00173713          	seqz	a4,a4
    80005ec6:	0017b793          	seqz	a5,a5
    80005eca:	8fd9                	or	a5,a5,a4
    80005ecc:	e7e9                	bnez	a5,80005f96 <virtio_disk_init+0x1ae>
  memset(disk.desc, 0, PGSIZE);
    80005ece:	6605                	lui	a2,0x1
    80005ed0:	4581                	li	a1,0
    80005ed2:	de3fa0ef          	jal	80000cb4 <memset>
  memset(disk.avail, 0, PGSIZE);
    80005ed6:	00055497          	auipc	s1,0x55
    80005eda:	f9a48493          	addi	s1,s1,-102 # 8005ae70 <disk>
    80005ede:	6605                	lui	a2,0x1
    80005ee0:	4581                	li	a1,0
    80005ee2:	6488                	ld	a0,8(s1)
    80005ee4:	dd1fa0ef          	jal	80000cb4 <memset>
  memset(disk.used, 0, PGSIZE);
    80005ee8:	6605                	lui	a2,0x1
    80005eea:	4581                	li	a1,0
    80005eec:	6888                	ld	a0,16(s1)
    80005eee:	dc7fa0ef          	jal	80000cb4 <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005ef2:	100017b7          	lui	a5,0x10001
    80005ef6:	4721                	li	a4,8
    80005ef8:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    80005efa:	4098                	lw	a4,0(s1)
    80005efc:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80005f00:	40d8                	lw	a4,4(s1)
    80005f02:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    80005f06:	649c                	ld	a5,8(s1)
    80005f08:	10001737          	lui	a4,0x10001
    80005f0c:	08f72823          	sw	a5,144(a4) # 10001090 <_entry-0x6fffef70>
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80005f10:	9781                	srai	a5,a5,0x20
    80005f12:	08f72a23          	sw	a5,148(a4)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    80005f16:	689c                	ld	a5,16(s1)
    80005f18:	0af72023          	sw	a5,160(a4)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80005f1c:	9781                	srai	a5,a5,0x20
    80005f1e:	0af72223          	sw	a5,164(a4)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    80005f22:	4785                	li	a5,1
    80005f24:	c37c                	sw	a5,68(a4)
    disk.free[i] = 1;
    80005f26:	00f48c23          	sb	a5,24(s1)
    80005f2a:	00f48ca3          	sb	a5,25(s1)
    80005f2e:	00f48d23          	sb	a5,26(s1)
    80005f32:	00f48da3          	sb	a5,27(s1)
    80005f36:	00f48e23          	sb	a5,28(s1)
    80005f3a:	00f48ea3          	sb	a5,29(s1)
    80005f3e:	00f48f23          	sb	a5,30(s1)
    80005f42:	00f48fa3          	sb	a5,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80005f46:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80005f4a:	07272823          	sw	s2,112(a4)
}
    80005f4e:	60e2                	ld	ra,24(sp)
    80005f50:	6442                	ld	s0,16(sp)
    80005f52:	64a2                	ld	s1,8(sp)
    80005f54:	6902                	ld	s2,0(sp)
    80005f56:	6105                	addi	sp,sp,32
    80005f58:	8082                	ret
    panic("could not find virtio disk");
    80005f5a:	00002517          	auipc	a0,0x2
    80005f5e:	77650513          	addi	a0,a0,1910 # 800086d0 <etext+0x6d0>
    80005f62:	8e7fa0ef          	jal	80000848 <panic>
    panic("virtio disk FEATURES_OK unset");
    80005f66:	00002517          	auipc	a0,0x2
    80005f6a:	78a50513          	addi	a0,a0,1930 # 800086f0 <etext+0x6f0>
    80005f6e:	8dbfa0ef          	jal	80000848 <panic>
    panic("virtio disk should not be ready");
    80005f72:	00002517          	auipc	a0,0x2
    80005f76:	79e50513          	addi	a0,a0,1950 # 80008710 <etext+0x710>
    80005f7a:	8cffa0ef          	jal	80000848 <panic>
    panic("virtio disk has no queue 0");
    80005f7e:	00002517          	auipc	a0,0x2
    80005f82:	7b250513          	addi	a0,a0,1970 # 80008730 <etext+0x730>
    80005f86:	8c3fa0ef          	jal	80000848 <panic>
    panic("virtio disk max queue too short");
    80005f8a:	00002517          	auipc	a0,0x2
    80005f8e:	7c650513          	addi	a0,a0,1990 # 80008750 <etext+0x750>
    80005f92:	8b7fa0ef          	jal	80000848 <panic>
    panic("virtio disk kalloc");
    80005f96:	00002517          	auipc	a0,0x2
    80005f9a:	7da50513          	addi	a0,a0,2010 # 80008770 <etext+0x770>
    80005f9e:	8abfa0ef          	jal	80000848 <panic>

0000000080005fa2 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80005fa2:	711d                	addi	sp,sp,-96
    80005fa4:	ec86                	sd	ra,88(sp)
    80005fa6:	e8a2                	sd	s0,80(sp)
    80005fa8:	e4a6                	sd	s1,72(sp)
    80005faa:	e0ca                	sd	s2,64(sp)
    80005fac:	fc4e                	sd	s3,56(sp)
    80005fae:	f852                	sd	s4,48(sp)
    80005fb0:	f456                	sd	s5,40(sp)
    80005fb2:	f05a                	sd	s6,32(sp)
    80005fb4:	ec5e                	sd	s7,24(sp)
    80005fb6:	e862                	sd	s8,16(sp)
    80005fb8:	1080                	addi	s0,sp,96
    80005fba:	89aa                	mv	s3,a0
    80005fbc:	8b2e                	mv	s6,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80005fbe:	00c52b83          	lw	s7,12(a0)
    80005fc2:	001b9b9b          	slliw	s7,s7,0x1
    80005fc6:	1b82                	slli	s7,s7,0x20
    80005fc8:	020bdb93          	srli	s7,s7,0x20

  acquire(&disk.vdisk_lock);
    80005fcc:	00055517          	auipc	a0,0x55
    80005fd0:	fcc50513          	addi	a0,a0,-52 # 8005af98 <disk+0x128>
    80005fd4:	c25fa0ef          	jal	80000bf8 <acquire>
  for (int i = 0; i < NUM; i++) {
    80005fd8:	44a1                	li	s1,8
      disk.free[i] = 0;
    80005fda:	00055a97          	auipc	s5,0x55
    80005fde:	e96a8a93          	addi	s5,s5,-362 # 8005ae70 <disk>
  for (int i = 0; i < 3; i++) {
    80005fe2:	4a0d                	li	s4,3
    idx[i] = alloc_desc();
    80005fe4:	5c7d                	li	s8,-1
    80005fe6:	a8a5                	j	8000605e <virtio_disk_rw+0xbc>
      disk.free[i] = 0;
    80005fe8:	00fa8733          	add	a4,s5,a5
    80005fec:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80005ff0:	c19c                	sw	a5,0(a1)
    if (idx[i] < 0) {
    80005ff2:	0207c563          	bltz	a5,8000601c <virtio_disk_rw+0x7a>
  for (int i = 0; i < 3; i++) {
    80005ff6:	2905                	addiw	s2,s2,1
    80005ff8:	0611                	addi	a2,a2,4 # 1004 <_entry-0x7fffeffc>
    80005ffa:	07490663          	beq	s2,s4,80006066 <virtio_disk_rw+0xc4>
    idx[i] = alloc_desc();
    80005ffe:	85b2                	mv	a1,a2
  for (int i = 0; i < NUM; i++) {
    80006000:	00055717          	auipc	a4,0x55
    80006004:	e7070713          	addi	a4,a4,-400 # 8005ae70 <disk>
    80006008:	4781                	li	a5,0
    if (disk.free[i]) {
    8000600a:	01874683          	lbu	a3,24(a4)
    8000600e:	fee9                	bnez	a3,80005fe8 <virtio_disk_rw+0x46>
  for (int i = 0; i < NUM; i++) {
    80006010:	2785                	addiw	a5,a5,1
    80006012:	0705                	addi	a4,a4,1
    80006014:	fe979be3          	bne	a5,s1,8000600a <virtio_disk_rw+0x68>
    idx[i] = alloc_desc();
    80006018:	0185a023          	sw	s8,0(a1)
      for (int j = 0; j < i; j++)
    8000601c:	01205d63          	blez	s2,80006036 <virtio_disk_rw+0x94>
        free_desc(idx[j]);
    80006020:	fa042503          	lw	a0,-96(s0)
    80006024:	d4fff0ef          	jal	80005d72 <free_desc>
      for (int j = 0; j < i; j++)
    80006028:	4785                	li	a5,1
    8000602a:	0127d663          	bge	a5,s2,80006036 <virtio_disk_rw+0x94>
        free_desc(idx[j]);
    8000602e:	fa442503          	lw	a0,-92(s0)
    80006032:	d41ff0ef          	jal	80005d72 <free_desc>
  int idx[3];
  while (1) {
    if (alloc3_desc(idx) == 0) {
      break;
    }
    sleep_prepare(&disk.free[0]);
    80006036:	00055517          	auipc	a0,0x55
    8000603a:	e5250513          	addi	a0,a0,-430 # 8005ae88 <disk+0x18>
    8000603e:	eadfb0ef          	jal	80001eea <sleep_prepare>
    release(&disk.vdisk_lock);
    80006042:	00055517          	auipc	a0,0x55
    80006046:	f5650513          	addi	a0,a0,-170 # 8005af98 <disk+0x128>
    8000604a:	c33fa0ef          	jal	80000c7c <release>
    sleep();
    8000604e:	ed9fb0ef          	jal	80001f26 <sleep>
    acquire(&disk.vdisk_lock);
    80006052:	00055517          	auipc	a0,0x55
    80006056:	f4650513          	addi	a0,a0,-186 # 8005af98 <disk+0x128>
    8000605a:	b9ffa0ef          	jal	80000bf8 <acquire>
  for (int i = 0; i < 3; i++) {
    8000605e:	fa040613          	addi	a2,s0,-96
    80006062:	4901                	li	s2,0
    80006064:	bf69                	j	80005ffe <virtio_disk_rw+0x5c>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80006066:	fa042503          	lw	a0,-96(s0)
    8000606a:	00451693          	slli	a3,a0,0x4

  if (write)
    8000606e:	00055797          	auipc	a5,0x55
    80006072:	e0278793          	addi	a5,a5,-510 # 8005ae70 <disk>
    80006076:	00451713          	slli	a4,a0,0x4
    8000607a:	0a070713          	addi	a4,a4,160
    8000607e:	973e                	add	a4,a4,a5
    80006080:	01603633          	snez	a2,s6
    80006084:	c710                	sw	a2,8(a4)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80006086:	00072623          	sw	zero,12(a4)
  buf0->sector = sector;
    8000608a:	01773823          	sd	s7,16(a4)

  disk.desc[idx[0]].addr = (uint64)buf0;
    8000608e:	6398                	ld	a4,0(a5)
    80006090:	9736                	add	a4,a4,a3
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80006092:	0a868613          	addi	a2,a3,168 # 100010a8 <_entry-0x6fffef58>
    80006096:	963e                	add	a2,a2,a5
  disk.desc[idx[0]].addr = (uint64)buf0;
    80006098:	e310                	sd	a2,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    8000609a:	6390                	ld	a2,0(a5)
    8000609c:	00d605b3          	add	a1,a2,a3
    800060a0:	4741                	li	a4,16
    800060a2:	c598                	sw	a4,8(a1)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800060a4:	4805                	li	a6,1
    800060a6:	01059623          	sh	a6,12(a1)
  disk.desc[idx[0]].next = idx[1];
    800060aa:	fa442703          	lw	a4,-92(s0)
    800060ae:	00e59723          	sh	a4,14(a1)

  disk.desc[idx[1]].addr = (uint64)b->data;
    800060b2:	0712                	slli	a4,a4,0x4
    800060b4:	963a                	add	a2,a2,a4
    800060b6:	05898593          	addi	a1,s3,88
    800060ba:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    800060bc:	0007b883          	ld	a7,0(a5)
    800060c0:	9746                	add	a4,a4,a7
    800060c2:	40000613          	li	a2,1024
    800060c6:	c710                	sw	a2,8(a4)
  if (write)
    800060c8:	001b3613          	seqz	a2,s6
    800060cc:	0016161b          	slliw	a2,a2,0x1
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    800060d0:	01066633          	or	a2,a2,a6
    800060d4:	00c71623          	sh	a2,12(a4)
  disk.desc[idx[1]].next = idx[2];
    800060d8:	fa842583          	lw	a1,-88(s0)
    800060dc:	00b71723          	sh	a1,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    800060e0:	00250613          	addi	a2,a0,2
    800060e4:	0612                	slli	a2,a2,0x4
    800060e6:	963e                	add	a2,a2,a5
    800060e8:	577d                	li	a4,-1
    800060ea:	00e60823          	sb	a4,16(a2)
  disk.desc[idx[2]].addr = (uint64)&disk.info[idx[0]].status;
    800060ee:	0592                	slli	a1,a1,0x4
    800060f0:	98ae                	add	a7,a7,a1
    800060f2:	03068713          	addi	a4,a3,48
    800060f6:	973e                	add	a4,a4,a5
    800060f8:	00e8b023          	sd	a4,0(a7)
  disk.desc[idx[2]].len = 1;
    800060fc:	6398                	ld	a4,0(a5)
    800060fe:	972e                	add	a4,a4,a1
    80006100:	01072423          	sw	a6,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80006104:	4689                	li	a3,2
    80006106:	00d71623          	sh	a3,12(a4)
  disk.desc[idx[2]].next = 0;
    8000610a:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    8000610e:	0109a223          	sw	a6,4(s3)
  disk.info[idx[0]].b = b;
    80006112:	01363423          	sd	s3,8(a2)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80006116:	6794                	ld	a3,8(a5)
    80006118:	0026d703          	lhu	a4,2(a3)
    8000611c:	8b1d                	andi	a4,a4,7
    8000611e:	0706                	slli	a4,a4,0x1
    80006120:	96ba                	add	a3,a3,a4
    80006122:	00a69223          	sh	a0,4(a3)

// fence for memory-mapped IO
static inline void
io_fence()
{
  asm volatile("fence iorw, iorw" ::: "memory");
    80006126:	0ff0000f          	fence

  io_fence();

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    8000612a:	6798                	ld	a4,8(a5)
    8000612c:	00275783          	lhu	a5,2(a4)
    80006130:	2785                	addiw	a5,a5,1
    80006132:	00f71123          	sh	a5,2(a4)
    80006136:	0ff0000f          	fence

  io_fence();

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    8000613a:	100017b7          	lui	a5,0x10001
    8000613e:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while (b->disk == 1) {
    80006142:	0049a783          	lw	a5,4(s3)
    80006146:	03079663          	bne	a5,a6,80006172 <virtio_disk_rw+0x1d0>
    sleep_prepare(b);
    release(&disk.vdisk_lock);
    8000614a:	00055497          	auipc	s1,0x55
    8000614e:	e4e48493          	addi	s1,s1,-434 # 8005af98 <disk+0x128>
  while (b->disk == 1) {
    80006152:	893e                	mv	s2,a5
    sleep_prepare(b);
    80006154:	854e                	mv	a0,s3
    80006156:	d95fb0ef          	jal	80001eea <sleep_prepare>
    release(&disk.vdisk_lock);
    8000615a:	8526                	mv	a0,s1
    8000615c:	b21fa0ef          	jal	80000c7c <release>
    sleep();
    80006160:	dc7fb0ef          	jal	80001f26 <sleep>
    acquire(&disk.vdisk_lock);
    80006164:	8526                	mv	a0,s1
    80006166:	a93fa0ef          	jal	80000bf8 <acquire>
  while (b->disk == 1) {
    8000616a:	0049a783          	lw	a5,4(s3)
    8000616e:	ff2783e3          	beq	a5,s2,80006154 <virtio_disk_rw+0x1b2>
  }

  disk.info[idx[0]].b = 0;
    80006172:	fa042903          	lw	s2,-96(s0)
    80006176:	00290713          	addi	a4,s2,2
    8000617a:	0712                	slli	a4,a4,0x4
    8000617c:	00055797          	auipc	a5,0x55
    80006180:	cf478793          	addi	a5,a5,-780 # 8005ae70 <disk>
    80006184:	97ba                	add	a5,a5,a4
    80006186:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    8000618a:	00055997          	auipc	s3,0x55
    8000618e:	ce698993          	addi	s3,s3,-794 # 8005ae70 <disk>
    80006192:	00491713          	slli	a4,s2,0x4
    80006196:	0009b783          	ld	a5,0(s3)
    8000619a:	97ba                	add	a5,a5,a4
    8000619c:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    800061a0:	854a                	mv	a0,s2
    800061a2:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    800061a6:	bcdff0ef          	jal	80005d72 <free_desc>
    if (flag & VRING_DESC_F_NEXT)
    800061aa:	8885                	andi	s1,s1,1
    800061ac:	f0fd                	bnez	s1,80006192 <virtio_disk_rw+0x1f0>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    800061ae:	00055517          	auipc	a0,0x55
    800061b2:	dea50513          	addi	a0,a0,-534 # 8005af98 <disk+0x128>
    800061b6:	ac7fa0ef          	jal	80000c7c <release>
}
    800061ba:	60e6                	ld	ra,88(sp)
    800061bc:	6446                	ld	s0,80(sp)
    800061be:	64a6                	ld	s1,72(sp)
    800061c0:	6906                	ld	s2,64(sp)
    800061c2:	79e2                	ld	s3,56(sp)
    800061c4:	7a42                	ld	s4,48(sp)
    800061c6:	7aa2                	ld	s5,40(sp)
    800061c8:	7b02                	ld	s6,32(sp)
    800061ca:	6be2                	ld	s7,24(sp)
    800061cc:	6c42                	ld	s8,16(sp)
    800061ce:	6125                	addi	sp,sp,96
    800061d0:	8082                	ret

00000000800061d2 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    800061d2:	1101                	addi	sp,sp,-32
    800061d4:	ec06                	sd	ra,24(sp)
    800061d6:	e822                	sd	s0,16(sp)
    800061d8:	e426                	sd	s1,8(sp)
    800061da:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    800061dc:	00055497          	auipc	s1,0x55
    800061e0:	c9448493          	addi	s1,s1,-876 # 8005ae70 <disk>
    800061e4:	00055517          	auipc	a0,0x55
    800061e8:	db450513          	addi	a0,a0,-588 # 8005af98 <disk+0x128>
    800061ec:	a0dfa0ef          	jal	80000bf8 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    800061f0:	100017b7          	lui	a5,0x10001
    800061f4:	53bc                	lw	a5,96(a5)
    800061f6:	8b8d                	andi	a5,a5,3
    800061f8:	10001737          	lui	a4,0x10001
    800061fc:	d37c                	sw	a5,100(a4)
    800061fe:	0ff0000f          	fence
  io_fence();

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while (disk.used_idx != disk.used->idx) {
    80006202:	689c                	ld	a5,16(s1)
    80006204:	0204d703          	lhu	a4,32(s1)
    80006208:	0027d783          	lhu	a5,2(a5) # 10001002 <_entry-0x6fffeffe>
    8000620c:	04f70663          	beq	a4,a5,80006258 <virtio_disk_intr+0x86>
    80006210:	0ff0000f          	fence
    io_fence();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80006214:	6898                	ld	a4,16(s1)
    80006216:	0204d783          	lhu	a5,32(s1)
    8000621a:	8b9d                	andi	a5,a5,7
    8000621c:	078e                	slli	a5,a5,0x3
    8000621e:	97ba                	add	a5,a5,a4
    80006220:	43dc                	lw	a5,4(a5)

    if (disk.info[id].status != 0)
    80006222:	00278713          	addi	a4,a5,2
    80006226:	0712                	slli	a4,a4,0x4
    80006228:	9726                	add	a4,a4,s1
    8000622a:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    8000622e:	e321                	bnez	a4,8000626e <virtio_disk_intr+0x9c>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80006230:	0789                	addi	a5,a5,2
    80006232:	0792                	slli	a5,a5,0x4
    80006234:	97a6                	add	a5,a5,s1
    80006236:	6788                	ld	a0,8(a5)
    b->disk = 0; // disk is done with buf
    80006238:	00052223          	sw	zero,4(a0)
    wakeup(b);
    8000623c:	d1bfb0ef          	jal	80001f56 <wakeup>

    disk.used_idx += 1;
    80006240:	0204d783          	lhu	a5,32(s1)
    80006244:	2785                	addiw	a5,a5,1
    80006246:	17c2                	slli	a5,a5,0x30
    80006248:	93c1                	srli	a5,a5,0x30
    8000624a:	02f49023          	sh	a5,32(s1)
  while (disk.used_idx != disk.used->idx) {
    8000624e:	6898                	ld	a4,16(s1)
    80006250:	00275703          	lhu	a4,2(a4)
    80006254:	faf71ee3          	bne	a4,a5,80006210 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80006258:	00055517          	auipc	a0,0x55
    8000625c:	d4050513          	addi	a0,a0,-704 # 8005af98 <disk+0x128>
    80006260:	a1dfa0ef          	jal	80000c7c <release>
}
    80006264:	60e2                	ld	ra,24(sp)
    80006266:	6442                	ld	s0,16(sp)
    80006268:	64a2                	ld	s1,8(sp)
    8000626a:	6105                	addi	sp,sp,32
    8000626c:	8082                	ret
      panic("virtio_disk_intr status");
    8000626e:	00002517          	auipc	a0,0x2
    80006272:	51a50513          	addi	a0,a0,1306 # 80008788 <etext+0x788>
    80006276:	dd2fa0ef          	jal	80000848 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051073          	csrw	sscratch,a0
    80007004:	02000537          	lui	a0,0x2000
    80007008:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000700a:	0536                	slli	a0,a0,0xd
    8000700c:	02153423          	sd	ra,40(a0)
    80007010:	02253823          	sd	sp,48(a0)
    80007014:	02353c23          	sd	gp,56(a0)
    80007018:	04453023          	sd	tp,64(a0)
    8000701c:	04553423          	sd	t0,72(a0)
    80007020:	04653823          	sd	t1,80(a0)
    80007024:	04753c23          	sd	t2,88(a0)
    80007028:	f120                	sd	s0,96(a0)
    8000702a:	f524                	sd	s1,104(a0)
    8000702c:	fd2c                	sd	a1,120(a0)
    8000702e:	e150                	sd	a2,128(a0)
    80007030:	e554                	sd	a3,136(a0)
    80007032:	e958                	sd	a4,144(a0)
    80007034:	ed5c                	sd	a5,152(a0)
    80007036:	0b053023          	sd	a6,160(a0)
    8000703a:	0b153423          	sd	a7,168(a0)
    8000703e:	0b253823          	sd	s2,176(a0)
    80007042:	0b353c23          	sd	s3,184(a0)
    80007046:	0d453023          	sd	s4,192(a0)
    8000704a:	0d553423          	sd	s5,200(a0)
    8000704e:	0d653823          	sd	s6,208(a0)
    80007052:	0d753c23          	sd	s7,216(a0)
    80007056:	0f853023          	sd	s8,224(a0)
    8000705a:	0f953423          	sd	s9,232(a0)
    8000705e:	0fa53823          	sd	s10,240(a0)
    80007062:	0fb53c23          	sd	s11,248(a0)
    80007066:	11c53023          	sd	t3,256(a0)
    8000706a:	11d53423          	sd	t4,264(a0)
    8000706e:	11e53823          	sd	t5,272(a0)
    80007072:	11f53c23          	sd	t6,280(a0)
    80007076:	140022f3          	csrr	t0,sscratch
    8000707a:	06553823          	sd	t0,112(a0)
    8000707e:	00853103          	ld	sp,8(a0)
    80007082:	02053203          	ld	tp,32(a0)
    80007086:	01053283          	ld	t0,16(a0)
    8000708a:	00053303          	ld	t1,0(a0)
    8000708e:	12000073          	sfence.vma
    80007092:	18031073          	csrw	satp,t1
    80007096:	12000073          	sfence.vma
    8000709a:	9282                	jalr	t0

000000008000709c <userret>:
    8000709c:	0000100f          	fence.i
    800070a0:	12000073          	sfence.vma
    800070a4:	18051073          	csrw	satp,a0
    800070a8:	12000073          	sfence.vma
    800070ac:	02000537          	lui	a0,0x2000
    800070b0:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    800070b2:	0536                	slli	a0,a0,0xd
    800070b4:	02853083          	ld	ra,40(a0)
    800070b8:	03053103          	ld	sp,48(a0)
    800070bc:	03853183          	ld	gp,56(a0)
    800070c0:	04053203          	ld	tp,64(a0)
    800070c4:	04853283          	ld	t0,72(a0)
    800070c8:	05053303          	ld	t1,80(a0)
    800070cc:	05853383          	ld	t2,88(a0)
    800070d0:	7120                	ld	s0,96(a0)
    800070d2:	7524                	ld	s1,104(a0)
    800070d4:	7d2c                	ld	a1,120(a0)
    800070d6:	6150                	ld	a2,128(a0)
    800070d8:	6554                	ld	a3,136(a0)
    800070da:	6958                	ld	a4,144(a0)
    800070dc:	6d5c                	ld	a5,152(a0)
    800070de:	0a053803          	ld	a6,160(a0)
    800070e2:	0a853883          	ld	a7,168(a0)
    800070e6:	0b053903          	ld	s2,176(a0)
    800070ea:	0b853983          	ld	s3,184(a0)
    800070ee:	0c053a03          	ld	s4,192(a0)
    800070f2:	0c853a83          	ld	s5,200(a0)
    800070f6:	0d053b03          	ld	s6,208(a0)
    800070fa:	0d853b83          	ld	s7,216(a0)
    800070fe:	0e053c03          	ld	s8,224(a0)
    80007102:	0e853c83          	ld	s9,232(a0)
    80007106:	0f053d03          	ld	s10,240(a0)
    8000710a:	0f853d83          	ld	s11,248(a0)
    8000710e:	10053e03          	ld	t3,256(a0)
    80007112:	10853e83          	ld	t4,264(a0)
    80007116:	11053f03          	ld	t5,272(a0)
    8000711a:	11853f83          	ld	t6,280(a0)
    8000711e:	7928                	ld	a0,112(a0)
    80007120:	10200073          	sret
	...
