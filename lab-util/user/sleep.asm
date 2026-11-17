
user/_sleep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    if (argc != 2) {
   8:	4789                	li	a5,2
   a:	00f50c63          	beq	a0,a5,22 <main+0x22>
        fprintf(2, "Incorrect Usage specify : sleep ticks\n");
   e:	00001597          	auipc	a1,0x1
  12:	8f258593          	addi	a1,a1,-1806 # 900 <malloc+0xfc>
  16:	853e                	mv	a0,a5
  18:	706000ef          	jal	71e <fprintf>
        exit(1);
  1c:	4505                	li	a0,1
  1e:	2cc000ef          	jal	2ea <exit>
    }
    int tm = atoi(argv[1]);
  22:	6588                	ld	a0,8(a1)
  24:	1a0000ef          	jal	1c4 <atoi>
    pause(tm);
  28:	352000ef          	jal	37a <pause>
    exit(0);
  2c:	4501                	li	a0,0
  2e:	2bc000ef          	jal	2ea <exit>

0000000000000032 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  32:	1141                	addi	sp,sp,-16
  34:	e406                	sd	ra,8(sp)
  36:	e022                	sd	s0,0(sp)
  38:	0800                	addi	s0,sp,16
  extern int main();
  main();
  3a:	fc7ff0ef          	jal	0 <main>
  exit(0);
  3e:	4501                	li	a0,0
  40:	2aa000ef          	jal	2ea <exit>

0000000000000044 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  44:	1141                	addi	sp,sp,-16
  46:	e406                	sd	ra,8(sp)
  48:	e022                	sd	s0,0(sp)
  4a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  4c:	87aa                	mv	a5,a0
  4e:	0585                	addi	a1,a1,1
  50:	0785                	addi	a5,a5,1
  52:	fff5c703          	lbu	a4,-1(a1)
  56:	fee78fa3          	sb	a4,-1(a5)
  5a:	fb75                	bnez	a4,4e <strcpy+0xa>
    ;
  return os;
}
  5c:	60a2                	ld	ra,8(sp)
  5e:	6402                	ld	s0,0(sp)
  60:	0141                	addi	sp,sp,16
  62:	8082                	ret

0000000000000064 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  64:	1141                	addi	sp,sp,-16
  66:	e406                	sd	ra,8(sp)
  68:	e022                	sd	s0,0(sp)
  6a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  6c:	00054783          	lbu	a5,0(a0)
  70:	cb91                	beqz	a5,84 <strcmp+0x20>
  72:	0005c703          	lbu	a4,0(a1)
  76:	00f71763          	bne	a4,a5,84 <strcmp+0x20>
    p++, q++;
  7a:	0505                	addi	a0,a0,1
  7c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  7e:	00054783          	lbu	a5,0(a0)
  82:	fbe5                	bnez	a5,72 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  84:	0005c503          	lbu	a0,0(a1)
}
  88:	40a7853b          	subw	a0,a5,a0
  8c:	60a2                	ld	ra,8(sp)
  8e:	6402                	ld	s0,0(sp)
  90:	0141                	addi	sp,sp,16
  92:	8082                	ret

0000000000000094 <strlen>:

uint
strlen(const char *s)
{
  94:	1141                	addi	sp,sp,-16
  96:	e406                	sd	ra,8(sp)
  98:	e022                	sd	s0,0(sp)
  9a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  9c:	00054783          	lbu	a5,0(a0)
  a0:	cf91                	beqz	a5,bc <strlen+0x28>
  a2:	00150793          	addi	a5,a0,1
  a6:	86be                	mv	a3,a5
  a8:	0785                	addi	a5,a5,1
  aa:	fff7c703          	lbu	a4,-1(a5)
  ae:	ff65                	bnez	a4,a6 <strlen+0x12>
  b0:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  b4:	60a2                	ld	ra,8(sp)
  b6:	6402                	ld	s0,0(sp)
  b8:	0141                	addi	sp,sp,16
  ba:	8082                	ret
  for(n = 0; s[n]; n++)
  bc:	4501                	li	a0,0
  be:	bfdd                	j	b4 <strlen+0x20>

00000000000000c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  c0:	1141                	addi	sp,sp,-16
  c2:	e406                	sd	ra,8(sp)
  c4:	e022                	sd	s0,0(sp)
  c6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  c8:	ca19                	beqz	a2,de <memset+0x1e>
  ca:	87aa                	mv	a5,a0
  cc:	1602                	slli	a2,a2,0x20
  ce:	9201                	srli	a2,a2,0x20
  d0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  d4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  d8:	0785                	addi	a5,a5,1
  da:	fee79de3          	bne	a5,a4,d4 <memset+0x14>
  }
  return dst;
}
  de:	60a2                	ld	ra,8(sp)
  e0:	6402                	ld	s0,0(sp)
  e2:	0141                	addi	sp,sp,16
  e4:	8082                	ret

00000000000000e6 <strchr>:

char*
strchr(const char *s, char c)
{
  e6:	1141                	addi	sp,sp,-16
  e8:	e406                	sd	ra,8(sp)
  ea:	e022                	sd	s0,0(sp)
  ec:	0800                	addi	s0,sp,16
  for(; *s; s++)
  ee:	00054783          	lbu	a5,0(a0)
  f2:	c799                	beqz	a5,100 <strchr+0x1a>
    if(*s == c)
  f4:	00f58763          	beq	a1,a5,102 <strchr+0x1c>
  for(; *s; s++)
  f8:	0505                	addi	a0,a0,1
  fa:	00054783          	lbu	a5,0(a0)
  fe:	fbfd                	bnez	a5,f4 <strchr+0xe>
      return (char*)s;
  return 0;
 100:	4501                	li	a0,0
}
 102:	60a2                	ld	ra,8(sp)
 104:	6402                	ld	s0,0(sp)
 106:	0141                	addi	sp,sp,16
 108:	8082                	ret

000000000000010a <gets>:

char*
gets(char *buf, int max)
{
 10a:	711d                	addi	sp,sp,-96
 10c:	ec86                	sd	ra,88(sp)
 10e:	e8a2                	sd	s0,80(sp)
 110:	e4a6                	sd	s1,72(sp)
 112:	e0ca                	sd	s2,64(sp)
 114:	fc4e                	sd	s3,56(sp)
 116:	f852                	sd	s4,48(sp)
 118:	f456                	sd	s5,40(sp)
 11a:	f05a                	sd	s6,32(sp)
 11c:	ec5e                	sd	s7,24(sp)
 11e:	e862                	sd	s8,16(sp)
 120:	1080                	addi	s0,sp,96
 122:	8baa                	mv	s7,a0
 124:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 126:	892a                	mv	s2,a0
 128:	4481                	li	s1,0
    cc = read(0, &c, 1);
 12a:	faf40b13          	addi	s6,s0,-81
 12e:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 130:	8c26                	mv	s8,s1
 132:	0014899b          	addiw	s3,s1,1
 136:	84ce                	mv	s1,s3
 138:	0349d863          	bge	s3,s4,168 <gets+0x5e>
    cc = read(0, &c, 1);
 13c:	8656                	mv	a2,s5
 13e:	85da                	mv	a1,s6
 140:	4501                	li	a0,0
 142:	1c0000ef          	jal	302 <read>
    if(cc < 1)
 146:	02a05163          	blez	a0,168 <gets+0x5e>
      break;
    buf[i++] = c;
 14a:	faf44783          	lbu	a5,-81(s0)
 14e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 152:	0905                	addi	s2,s2,1
 154:	ff678713          	addi	a4,a5,-10
 158:	00173713          	seqz	a4,a4
 15c:	17cd                	addi	a5,a5,-13
 15e:	0017b793          	seqz	a5,a5
 162:	8fd9                	or	a5,a5,a4
 164:	d7f1                	beqz	a5,130 <gets+0x26>
    buf[i++] = c;
 166:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 168:	9c5e                	add	s8,s8,s7
 16a:	000c0023          	sb	zero,0(s8)
  return buf;
}
 16e:	855e                	mv	a0,s7
 170:	60e6                	ld	ra,88(sp)
 172:	6446                	ld	s0,80(sp)
 174:	64a6                	ld	s1,72(sp)
 176:	6906                	ld	s2,64(sp)
 178:	79e2                	ld	s3,56(sp)
 17a:	7a42                	ld	s4,48(sp)
 17c:	7aa2                	ld	s5,40(sp)
 17e:	7b02                	ld	s6,32(sp)
 180:	6be2                	ld	s7,24(sp)
 182:	6c42                	ld	s8,16(sp)
 184:	6125                	addi	sp,sp,96
 186:	8082                	ret

0000000000000188 <stat>:

int
stat(const char *n, struct stat *st)
{
 188:	1101                	addi	sp,sp,-32
 18a:	ec06                	sd	ra,24(sp)
 18c:	e822                	sd	s0,16(sp)
 18e:	e04a                	sd	s2,0(sp)
 190:	1000                	addi	s0,sp,32
 192:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 194:	4581                	li	a1,0
 196:	194000ef          	jal	32a <open>
  if(fd < 0)
 19a:	02054263          	bltz	a0,1be <stat+0x36>
 19e:	e426                	sd	s1,8(sp)
 1a0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1a2:	85ca                	mv	a1,s2
 1a4:	19e000ef          	jal	342 <fstat>
 1a8:	892a                	mv	s2,a0
  close(fd);
 1aa:	8526                	mv	a0,s1
 1ac:	166000ef          	jal	312 <close>
  return r;
 1b0:	64a2                	ld	s1,8(sp)
}
 1b2:	854a                	mv	a0,s2
 1b4:	60e2                	ld	ra,24(sp)
 1b6:	6442                	ld	s0,16(sp)
 1b8:	6902                	ld	s2,0(sp)
 1ba:	6105                	addi	sp,sp,32
 1bc:	8082                	ret
    return -1;
 1be:	57fd                	li	a5,-1
 1c0:	893e                	mv	s2,a5
 1c2:	bfc5                	j	1b2 <stat+0x2a>

00000000000001c4 <atoi>:

int
atoi(const char *s)
{
 1c4:	1141                	addi	sp,sp,-16
 1c6:	e406                	sd	ra,8(sp)
 1c8:	e022                	sd	s0,0(sp)
 1ca:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1cc:	00054683          	lbu	a3,0(a0)
 1d0:	fd06879b          	addiw	a5,a3,-48
 1d4:	0ff7f793          	zext.b	a5,a5
 1d8:	4625                	li	a2,9
 1da:	02f66963          	bltu	a2,a5,20c <atoi+0x48>
 1de:	872a                	mv	a4,a0
  n = 0;
 1e0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1e2:	0705                	addi	a4,a4,1
 1e4:	0025179b          	slliw	a5,a0,0x2
 1e8:	9fa9                	addw	a5,a5,a0
 1ea:	0017979b          	slliw	a5,a5,0x1
 1ee:	9fb5                	addw	a5,a5,a3
 1f0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1f4:	00074683          	lbu	a3,0(a4)
 1f8:	fd06879b          	addiw	a5,a3,-48
 1fc:	0ff7f793          	zext.b	a5,a5
 200:	fef671e3          	bgeu	a2,a5,1e2 <atoi+0x1e>
  return n;
}
 204:	60a2                	ld	ra,8(sp)
 206:	6402                	ld	s0,0(sp)
 208:	0141                	addi	sp,sp,16
 20a:	8082                	ret
  n = 0;
 20c:	4501                	li	a0,0
 20e:	bfdd                	j	204 <atoi+0x40>

0000000000000210 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 210:	1141                	addi	sp,sp,-16
 212:	e406                	sd	ra,8(sp)
 214:	e022                	sd	s0,0(sp)
 216:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 218:	02b57563          	bgeu	a0,a1,242 <memmove+0x32>
    while(n-- > 0)
 21c:	00c05f63          	blez	a2,23a <memmove+0x2a>
 220:	1602                	slli	a2,a2,0x20
 222:	9201                	srli	a2,a2,0x20
 224:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 228:	872a                	mv	a4,a0
      *dst++ = *src++;
 22a:	0585                	addi	a1,a1,1
 22c:	0705                	addi	a4,a4,1
 22e:	fff5c683          	lbu	a3,-1(a1)
 232:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 236:	fee79ae3          	bne	a5,a4,22a <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 23a:	60a2                	ld	ra,8(sp)
 23c:	6402                	ld	s0,0(sp)
 23e:	0141                	addi	sp,sp,16
 240:	8082                	ret
    while(n-- > 0)
 242:	fec05ce3          	blez	a2,23a <memmove+0x2a>
    dst += n;
 246:	00c50733          	add	a4,a0,a2
    src += n;
 24a:	95b2                	add	a1,a1,a2
 24c:	fff6079b          	addiw	a5,a2,-1
 250:	1782                	slli	a5,a5,0x20
 252:	9381                	srli	a5,a5,0x20
 254:	fff7c793          	not	a5,a5
 258:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 25a:	15fd                	addi	a1,a1,-1
 25c:	177d                	addi	a4,a4,-1
 25e:	0005c683          	lbu	a3,0(a1)
 262:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 266:	fef71ae3          	bne	a4,a5,25a <memmove+0x4a>
 26a:	bfc1                	j	23a <memmove+0x2a>

000000000000026c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 26c:	1141                	addi	sp,sp,-16
 26e:	e406                	sd	ra,8(sp)
 270:	e022                	sd	s0,0(sp)
 272:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 274:	ce19                	beqz	a2,292 <memcmp+0x26>
 276:	1602                	slli	a2,a2,0x20
 278:	9201                	srli	a2,a2,0x20
 27a:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 27e:	00054783          	lbu	a5,0(a0)
 282:	0005c703          	lbu	a4,0(a1)
 286:	00e79b63          	bne	a5,a4,29c <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 28a:	0505                	addi	a0,a0,1
    p2++;
 28c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 28e:	fed518e3          	bne	a0,a3,27e <memcmp+0x12>
  }
  return 0;
 292:	4501                	li	a0,0
}
 294:	60a2                	ld	ra,8(sp)
 296:	6402                	ld	s0,0(sp)
 298:	0141                	addi	sp,sp,16
 29a:	8082                	ret
      return *p1 - *p2;
 29c:	40e7853b          	subw	a0,a5,a4
 2a0:	bfd5                	j	294 <memcmp+0x28>

00000000000002a2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2a2:	1141                	addi	sp,sp,-16
 2a4:	e406                	sd	ra,8(sp)
 2a6:	e022                	sd	s0,0(sp)
 2a8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2aa:	f67ff0ef          	jal	210 <memmove>
}
 2ae:	60a2                	ld	ra,8(sp)
 2b0:	6402                	ld	s0,0(sp)
 2b2:	0141                	addi	sp,sp,16
 2b4:	8082                	ret

00000000000002b6 <sbrk>:

char *
sbrk(int n) {
 2b6:	1141                	addi	sp,sp,-16
 2b8:	e406                	sd	ra,8(sp)
 2ba:	e022                	sd	s0,0(sp)
 2bc:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2be:	4585                	li	a1,1
 2c0:	0b2000ef          	jal	372 <sys_sbrk>
}
 2c4:	60a2                	ld	ra,8(sp)
 2c6:	6402                	ld	s0,0(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret

00000000000002cc <sbrklazy>:

char *
sbrklazy(int n) {
 2cc:	1141                	addi	sp,sp,-16
 2ce:	e406                	sd	ra,8(sp)
 2d0:	e022                	sd	s0,0(sp)
 2d2:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 2d4:	4589                	li	a1,2
 2d6:	09c000ef          	jal	372 <sys_sbrk>
}
 2da:	60a2                	ld	ra,8(sp)
 2dc:	6402                	ld	s0,0(sp)
 2de:	0141                	addi	sp,sp,16
 2e0:	8082                	ret

00000000000002e2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2e2:	4885                	li	a7,1
 ecall
 2e4:	00000073          	ecall
 ret
 2e8:	8082                	ret

00000000000002ea <exit>:
.global exit
exit:
 li a7, SYS_exit
 2ea:	4889                	li	a7,2
 ecall
 2ec:	00000073          	ecall
 ret
 2f0:	8082                	ret

00000000000002f2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2f2:	488d                	li	a7,3
 ecall
 2f4:	00000073          	ecall
 ret
 2f8:	8082                	ret

00000000000002fa <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2fa:	4891                	li	a7,4
 ecall
 2fc:	00000073          	ecall
 ret
 300:	8082                	ret

0000000000000302 <read>:
.global read
read:
 li a7, SYS_read
 302:	4895                	li	a7,5
 ecall
 304:	00000073          	ecall
 ret
 308:	8082                	ret

000000000000030a <write>:
.global write
write:
 li a7, SYS_write
 30a:	48c1                	li	a7,16
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <close>:
.global close
close:
 li a7, SYS_close
 312:	48d5                	li	a7,21
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <kill>:
.global kill
kill:
 li a7, SYS_kill
 31a:	4899                	li	a7,6
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <exec>:
.global exec
exec:
 li a7, SYS_exec
 322:	489d                	li	a7,7
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <open>:
.global open
open:
 li a7, SYS_open
 32a:	48bd                	li	a7,15
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 332:	48c5                	li	a7,17
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 33a:	48c9                	li	a7,18
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 342:	48a1                	li	a7,8
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <link>:
.global link
link:
 li a7, SYS_link
 34a:	48cd                	li	a7,19
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 352:	48d1                	li	a7,20
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 35a:	48a5                	li	a7,9
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <dup>:
.global dup
dup:
 li a7, SYS_dup
 362:	48a9                	li	a7,10
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 36a:	48ad                	li	a7,11
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 372:	48b1                	li	a7,12
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <pause>:
.global pause
pause:
 li a7, SYS_pause
 37a:	48b5                	li	a7,13
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 382:	48b9                	li	a7,14
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 38a:	1101                	addi	sp,sp,-32
 38c:	ec06                	sd	ra,24(sp)
 38e:	e822                	sd	s0,16(sp)
 390:	1000                	addi	s0,sp,32
 392:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 396:	4605                	li	a2,1
 398:	fef40593          	addi	a1,s0,-17
 39c:	f6fff0ef          	jal	30a <write>
}
 3a0:	60e2                	ld	ra,24(sp)
 3a2:	6442                	ld	s0,16(sp)
 3a4:	6105                	addi	sp,sp,32
 3a6:	8082                	ret

00000000000003a8 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 3a8:	715d                	addi	sp,sp,-80
 3aa:	e486                	sd	ra,72(sp)
 3ac:	e0a2                	sd	s0,64(sp)
 3ae:	f84a                	sd	s2,48(sp)
 3b0:	f44e                	sd	s3,40(sp)
 3b2:	0880                	addi	s0,sp,80
 3b4:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3b6:	00d036b3          	snez	a3,a3
 3ba:	03f5d793          	srli	a5,a1,0x3f
 3be:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3c0:	0005871b          	sext.w	a4,a1
  neg = 0;
 3c4:	4301                	li	t1,0
  if(sgn && xx < 0){
 3c6:	c681                	beqz	a3,3ce <printint+0x26>
    x = -xx;
 3c8:	40b0073b          	negw	a4,a1
    neg = 1;
 3cc:	4305                	li	t1,1
  }

  i = 0;
 3ce:	fb840993          	addi	s3,s0,-72
  neg = 0;
 3d2:	85ce                	mv	a1,s3
  i = 0;
 3d4:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 3d6:	00000817          	auipc	a6,0x0
 3da:	55a80813          	addi	a6,a6,1370 # 930 <digits>
 3de:	88b6                	mv	a7,a3
 3e0:	0016851b          	addiw	a0,a3,1
 3e4:	86aa                	mv	a3,a0
 3e6:	02c777bb          	remuw	a5,a4,a2
 3ea:	1782                	slli	a5,a5,0x20
 3ec:	9381                	srli	a5,a5,0x20
 3ee:	97c2                	add	a5,a5,a6
 3f0:	0007c783          	lbu	a5,0(a5)
 3f4:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 3f8:	87ba                	mv	a5,a4
 3fa:	02c7573b          	divuw	a4,a4,a2
 3fe:	0585                	addi	a1,a1,1
 400:	fcc7ffe3          	bgeu	a5,a2,3de <printint+0x36>
  if(neg)
 404:	00030b63          	beqz	t1,41a <printint+0x72>
    buf[i++] = '-';
 408:	fd040793          	addi	a5,s0,-48
 40c:	953e                	add	a0,a0,a5
 40e:	02d00793          	li	a5,45
 412:	fef50423          	sb	a5,-24(a0)
 416:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 41a:	02d05563          	blez	a3,444 <printint+0x9c>
 41e:	fc26                	sd	s1,56(sp)
 420:	36fd                	addiw	a3,a3,-1
 422:	00d984b3          	add	s1,s3,a3
 426:	19fd                	addi	s3,s3,-1
 428:	99b6                	add	s3,s3,a3
 42a:	1682                	slli	a3,a3,0x20
 42c:	9281                	srli	a3,a3,0x20
 42e:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 432:	0004c583          	lbu	a1,0(s1)
 436:	854a                	mv	a0,s2
 438:	f53ff0ef          	jal	38a <putc>
  while(--i >= 0)
 43c:	14fd                	addi	s1,s1,-1
 43e:	ff349ae3          	bne	s1,s3,432 <printint+0x8a>
 442:	74e2                	ld	s1,56(sp)
}
 444:	60a6                	ld	ra,72(sp)
 446:	6406                	ld	s0,64(sp)
 448:	7942                	ld	s2,48(sp)
 44a:	79a2                	ld	s3,40(sp)
 44c:	6161                	addi	sp,sp,80
 44e:	8082                	ret

0000000000000450 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 450:	711d                	addi	sp,sp,-96
 452:	ec86                	sd	ra,88(sp)
 454:	e8a2                	sd	s0,80(sp)
 456:	e4a6                	sd	s1,72(sp)
 458:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 45a:	0005c483          	lbu	s1,0(a1)
 45e:	2a048063          	beqz	s1,6fe <vprintf+0x2ae>
 462:	e0ca                	sd	s2,64(sp)
 464:	fc4e                	sd	s3,56(sp)
 466:	f852                	sd	s4,48(sp)
 468:	f456                	sd	s5,40(sp)
 46a:	f05a                	sd	s6,32(sp)
 46c:	ec5e                	sd	s7,24(sp)
 46e:	e862                	sd	s8,16(sp)
 470:	8b2a                	mv	s6,a0
 472:	8a2e                	mv	s4,a1
 474:	8bb2                	mv	s7,a2
  state = 0;
 476:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 478:	4901                	li	s2,0
 47a:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 47c:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 480:	06400c13          	li	s8,100
 484:	a00d                	j	4a6 <vprintf+0x56>
        putc(fd, c0);
 486:	85a6                	mv	a1,s1
 488:	855a                	mv	a0,s6
 48a:	f01ff0ef          	jal	38a <putc>
 48e:	a019                	j	494 <vprintf+0x44>
    } else if(state == '%'){
 490:	03598363          	beq	s3,s5,4b6 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 494:	0019079b          	addiw	a5,s2,1
 498:	893e                	mv	s2,a5
 49a:	873e                	mv	a4,a5
 49c:	97d2                	add	a5,a5,s4
 49e:	0007c483          	lbu	s1,0(a5)
 4a2:	24048763          	beqz	s1,6f0 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 4a6:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4aa:	fe0993e3          	bnez	s3,490 <vprintf+0x40>
      if(c0 == '%'){
 4ae:	fd579ce3          	bne	a5,s5,486 <vprintf+0x36>
        state = '%';
 4b2:	89be                	mv	s3,a5
 4b4:	b7c5                	j	494 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 4b6:	00ea06b3          	add	a3,s4,a4
 4ba:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 4be:	24060563          	beqz	a2,708 <vprintf+0x2b8>
      if(c0 == 'd'){
 4c2:	0b878763          	beq	a5,s8,570 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4c6:	f9478693          	addi	a3,a5,-108
 4ca:	0016b693          	seqz	a3,a3
 4ce:	f9c60593          	addi	a1,a2,-100
 4d2:	0015b593          	seqz	a1,a1
 4d6:	8df5                	and	a1,a1,a3
 4d8:	e9c5                	bnez	a1,588 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 4da:	9752                	add	a4,a4,s4
 4dc:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 4e0:	f9460713          	addi	a4,a2,-108
 4e4:	00173713          	seqz	a4,a4
 4e8:	8f75                	and	a4,a4,a3
 4ea:	f9c50593          	addi	a1,a0,-100
 4ee:	0015b593          	seqz	a1,a1
 4f2:	8df9                	and	a1,a1,a4
 4f4:	e5dd                	bnez	a1,5a2 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 4f6:	07500593          	li	a1,117
 4fa:	0cb78163          	beq	a5,a1,5bc <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 4fe:	f8b60593          	addi	a1,a2,-117
 502:	0015b593          	seqz	a1,a1
 506:	8df5                	and	a1,a1,a3
 508:	e5f1                	bnez	a1,5d4 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 50a:	f8b50593          	addi	a1,a0,-117
 50e:	0015b593          	seqz	a1,a1
 512:	8df9                	and	a1,a1,a4
 514:	ede9                	bnez	a1,5ee <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 516:	07800593          	li	a1,120
 51a:	0eb78763          	beq	a5,a1,608 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 51e:	f8860613          	addi	a2,a2,-120
 522:	00163613          	seqz	a2,a2
 526:	8ef1                	and	a3,a3,a2
 528:	0e069c63          	bnez	a3,620 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 52c:	f8850513          	addi	a0,a0,-120
 530:	00153513          	seqz	a0,a0
 534:	8f69                	and	a4,a4,a0
 536:	10071263          	bnez	a4,63a <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 53a:	07000713          	li	a4,112
 53e:	10e78a63          	beq	a5,a4,652 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 542:	06300713          	li	a4,99
 546:	14e78a63          	beq	a5,a4,69a <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 54a:	07300713          	li	a4,115
 54e:	16e78063          	beq	a5,a4,6ae <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 552:	02500713          	li	a4,37
 556:	18e78863          	beq	a5,a4,6e6 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 55a:	02500593          	li	a1,37
 55e:	855a                	mv	a0,s6
 560:	e2bff0ef          	jal	38a <putc>
        putc(fd, c0);
 564:	85a6                	mv	a1,s1
 566:	855a                	mv	a0,s6
 568:	e23ff0ef          	jal	38a <putc>
      }

      state = 0;
 56c:	4981                	li	s3,0
 56e:	b71d                	j	494 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 570:	008b8493          	addi	s1,s7,8
 574:	4685                	li	a3,1
 576:	4629                	li	a2,10
 578:	000ba583          	lw	a1,0(s7)
 57c:	855a                	mv	a0,s6
 57e:	e2bff0ef          	jal	3a8 <printint>
 582:	8ba6                	mv	s7,s1
      state = 0;
 584:	4981                	li	s3,0
 586:	b739                	j	494 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 588:	008b8493          	addi	s1,s7,8
 58c:	4685                	li	a3,1
 58e:	4629                	li	a2,10
 590:	000bb583          	ld	a1,0(s7)
 594:	855a                	mv	a0,s6
 596:	e13ff0ef          	jal	3a8 <printint>
        i += 1;
 59a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 59c:	8ba6                	mv	s7,s1
      state = 0;
 59e:	4981                	li	s3,0
 5a0:	bdd5                	j	494 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5a2:	008b8493          	addi	s1,s7,8
 5a6:	4685                	li	a3,1
 5a8:	4629                	li	a2,10
 5aa:	000bb583          	ld	a1,0(s7)
 5ae:	855a                	mv	a0,s6
 5b0:	df9ff0ef          	jal	3a8 <printint>
        i += 2;
 5b4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5b6:	8ba6                	mv	s7,s1
      state = 0;
 5b8:	4981                	li	s3,0
        i += 2;
 5ba:	bde9                	j	494 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 5bc:	008b8493          	addi	s1,s7,8
 5c0:	4681                	li	a3,0
 5c2:	4629                	li	a2,10
 5c4:	000be583          	lwu	a1,0(s7)
 5c8:	855a                	mv	a0,s6
 5ca:	ddfff0ef          	jal	3a8 <printint>
 5ce:	8ba6                	mv	s7,s1
      state = 0;
 5d0:	4981                	li	s3,0
 5d2:	b5c9                	j	494 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5d4:	008b8493          	addi	s1,s7,8
 5d8:	4681                	li	a3,0
 5da:	4629                	li	a2,10
 5dc:	000bb583          	ld	a1,0(s7)
 5e0:	855a                	mv	a0,s6
 5e2:	dc7ff0ef          	jal	3a8 <printint>
        i += 1;
 5e6:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 5e8:	8ba6                	mv	s7,s1
      state = 0;
 5ea:	4981                	li	s3,0
 5ec:	b565                	j	494 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5ee:	008b8493          	addi	s1,s7,8
 5f2:	4681                	li	a3,0
 5f4:	4629                	li	a2,10
 5f6:	000bb583          	ld	a1,0(s7)
 5fa:	855a                	mv	a0,s6
 5fc:	dadff0ef          	jal	3a8 <printint>
        i += 2;
 600:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 602:	8ba6                	mv	s7,s1
      state = 0;
 604:	4981                	li	s3,0
        i += 2;
 606:	b579                	j	494 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 608:	008b8493          	addi	s1,s7,8
 60c:	4681                	li	a3,0
 60e:	4641                	li	a2,16
 610:	000be583          	lwu	a1,0(s7)
 614:	855a                	mv	a0,s6
 616:	d93ff0ef          	jal	3a8 <printint>
 61a:	8ba6                	mv	s7,s1
      state = 0;
 61c:	4981                	li	s3,0
 61e:	bd9d                	j	494 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 620:	008b8493          	addi	s1,s7,8
 624:	4681                	li	a3,0
 626:	4641                	li	a2,16
 628:	000bb583          	ld	a1,0(s7)
 62c:	855a                	mv	a0,s6
 62e:	d7bff0ef          	jal	3a8 <printint>
        i += 1;
 632:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 634:	8ba6                	mv	s7,s1
      state = 0;
 636:	4981                	li	s3,0
 638:	bdb1                	j	494 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 63a:	008b8493          	addi	s1,s7,8
 63e:	4641                	li	a2,16
 640:	000bb583          	ld	a1,0(s7)
 644:	855a                	mv	a0,s6
 646:	d63ff0ef          	jal	3a8 <printint>
        i += 2;
 64a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 64c:	8ba6                	mv	s7,s1
      state = 0;
 64e:	4981                	li	s3,0
        i += 2;
 650:	b591                	j	494 <vprintf+0x44>
 652:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 654:	008b8793          	addi	a5,s7,8
 658:	8cbe                	mv	s9,a5
 65a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 65e:	03000593          	li	a1,48
 662:	855a                	mv	a0,s6
 664:	d27ff0ef          	jal	38a <putc>
  putc(fd, 'x');
 668:	07800593          	li	a1,120
 66c:	855a                	mv	a0,s6
 66e:	d1dff0ef          	jal	38a <putc>
 672:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 674:	00000b97          	auipc	s7,0x0
 678:	2bcb8b93          	addi	s7,s7,700 # 930 <digits>
 67c:	03c9d793          	srli	a5,s3,0x3c
 680:	97de                	add	a5,a5,s7
 682:	0007c583          	lbu	a1,0(a5)
 686:	855a                	mv	a0,s6
 688:	d03ff0ef          	jal	38a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 68c:	0992                	slli	s3,s3,0x4
 68e:	34fd                	addiw	s1,s1,-1
 690:	f4f5                	bnez	s1,67c <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 692:	8be6                	mv	s7,s9
      state = 0;
 694:	4981                	li	s3,0
 696:	6ca2                	ld	s9,8(sp)
 698:	bbf5                	j	494 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 69a:	008b8493          	addi	s1,s7,8
 69e:	000bc583          	lbu	a1,0(s7)
 6a2:	855a                	mv	a0,s6
 6a4:	ce7ff0ef          	jal	38a <putc>
 6a8:	8ba6                	mv	s7,s1
      state = 0;
 6aa:	4981                	li	s3,0
 6ac:	b3e5                	j	494 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 6ae:	008b8993          	addi	s3,s7,8
 6b2:	000bb483          	ld	s1,0(s7)
 6b6:	cc91                	beqz	s1,6d2 <vprintf+0x282>
        for(; *s; s++)
 6b8:	0004c583          	lbu	a1,0(s1)
 6bc:	c195                	beqz	a1,6e0 <vprintf+0x290>
          putc(fd, *s);
 6be:	855a                	mv	a0,s6
 6c0:	ccbff0ef          	jal	38a <putc>
        for(; *s; s++)
 6c4:	0485                	addi	s1,s1,1
 6c6:	0004c583          	lbu	a1,0(s1)
 6ca:	f9f5                	bnez	a1,6be <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 6cc:	8bce                	mv	s7,s3
      state = 0;
 6ce:	4981                	li	s3,0
 6d0:	b3d1                	j	494 <vprintf+0x44>
          s = "(null)";
 6d2:	00000497          	auipc	s1,0x0
 6d6:	25648493          	addi	s1,s1,598 # 928 <malloc+0x124>
        for(; *s; s++)
 6da:	02800593          	li	a1,40
 6de:	b7c5                	j	6be <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 6e0:	8bce                	mv	s7,s3
      state = 0;
 6e2:	4981                	li	s3,0
 6e4:	bb45                	j	494 <vprintf+0x44>
        putc(fd, '%');
 6e6:	85be                	mv	a1,a5
 6e8:	855a                	mv	a0,s6
 6ea:	ca1ff0ef          	jal	38a <putc>
 6ee:	bdbd                	j	56c <vprintf+0x11c>
 6f0:	6906                	ld	s2,64(sp)
 6f2:	79e2                	ld	s3,56(sp)
 6f4:	7a42                	ld	s4,48(sp)
 6f6:	7aa2                	ld	s5,40(sp)
 6f8:	7b02                	ld	s6,32(sp)
 6fa:	6be2                	ld	s7,24(sp)
 6fc:	6c42                	ld	s8,16(sp)
    }
  }
}
 6fe:	60e6                	ld	ra,88(sp)
 700:	6446                	ld	s0,80(sp)
 702:	64a6                	ld	s1,72(sp)
 704:	6125                	addi	sp,sp,96
 706:	8082                	ret
      if(c0 == 'd'){
 708:	06400713          	li	a4,100
 70c:	e6e782e3          	beq	a5,a4,570 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 710:	f9478693          	addi	a3,a5,-108
 714:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 718:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 71a:	4701                	li	a4,0
 71c:	bbe9                	j	4f6 <vprintf+0xa6>

000000000000071e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 71e:	715d                	addi	sp,sp,-80
 720:	ec06                	sd	ra,24(sp)
 722:	e822                	sd	s0,16(sp)
 724:	1000                	addi	s0,sp,32
 726:	e010                	sd	a2,0(s0)
 728:	e414                	sd	a3,8(s0)
 72a:	e818                	sd	a4,16(s0)
 72c:	ec1c                	sd	a5,24(s0)
 72e:	03043023          	sd	a6,32(s0)
 732:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 736:	8622                	mv	a2,s0
 738:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 73c:	d15ff0ef          	jal	450 <vprintf>
}
 740:	60e2                	ld	ra,24(sp)
 742:	6442                	ld	s0,16(sp)
 744:	6161                	addi	sp,sp,80
 746:	8082                	ret

0000000000000748 <printf>:

void
printf(const char *fmt, ...)
{
 748:	711d                	addi	sp,sp,-96
 74a:	ec06                	sd	ra,24(sp)
 74c:	e822                	sd	s0,16(sp)
 74e:	1000                	addi	s0,sp,32
 750:	e40c                	sd	a1,8(s0)
 752:	e810                	sd	a2,16(s0)
 754:	ec14                	sd	a3,24(s0)
 756:	f018                	sd	a4,32(s0)
 758:	f41c                	sd	a5,40(s0)
 75a:	03043823          	sd	a6,48(s0)
 75e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 762:	00840613          	addi	a2,s0,8
 766:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 76a:	85aa                	mv	a1,a0
 76c:	4505                	li	a0,1
 76e:	ce3ff0ef          	jal	450 <vprintf>
}
 772:	60e2                	ld	ra,24(sp)
 774:	6442                	ld	s0,16(sp)
 776:	6125                	addi	sp,sp,96
 778:	8082                	ret

000000000000077a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 77a:	1141                	addi	sp,sp,-16
 77c:	e406                	sd	ra,8(sp)
 77e:	e022                	sd	s0,0(sp)
 780:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 782:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 786:	00001797          	auipc	a5,0x1
 78a:	87a7b783          	ld	a5,-1926(a5) # 1000 <freep>
 78e:	a095                	j	7f2 <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 790:	ff852583          	lw	a1,-8(a0)
 794:	6390                	ld	a2,0(a5)
 796:	02059813          	slli	a6,a1,0x20
 79a:	01c85693          	srli	a3,a6,0x1c
 79e:	96ba                	add	a3,a3,a4
 7a0:	02d60563          	beq	a2,a3,7ca <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7a4:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7a8:	4790                	lw	a2,8(a5)
 7aa:	02061593          	slli	a1,a2,0x20
 7ae:	01c5d693          	srli	a3,a1,0x1c
 7b2:	96be                	add	a3,a3,a5
 7b4:	02d70263          	beq	a4,a3,7d8 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7b8:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7ba:	00001717          	auipc	a4,0x1
 7be:	84f73323          	sd	a5,-1978(a4) # 1000 <freep>
}
 7c2:	60a2                	ld	ra,8(sp)
 7c4:	6402                	ld	s0,0(sp)
 7c6:	0141                	addi	sp,sp,16
 7c8:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 7ca:	4614                	lw	a3,8(a2)
 7cc:	9ead                	addw	a3,a3,a1
 7ce:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d2:	6394                	ld	a3,0(a5)
 7d4:	6290                	ld	a2,0(a3)
 7d6:	b7f9                	j	7a4 <free+0x2a>
    p->s.size += bp->s.size;
 7d8:	ff852703          	lw	a4,-8(a0)
 7dc:	9f31                	addw	a4,a4,a2
 7de:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7e0:	ff053703          	ld	a4,-16(a0)
 7e4:	bfd1                	j	7b8 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e6:	6394                	ld	a3,0(a5)
 7e8:	00d7e463          	bltu	a5,a3,7f0 <free+0x76>
 7ec:	fad762e3          	bltu	a4,a3,790 <free+0x16>
 7f0:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f2:	fee7fae3          	bgeu	a5,a4,7e6 <free+0x6c>
 7f6:	6394                	ld	a3,0(a5)
 7f8:	f8d76ce3          	bltu	a4,a3,790 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fc:	f8d7fae3          	bgeu	a5,a3,790 <free+0x16>
 800:	87b6                	mv	a5,a3
 802:	bfc5                	j	7f2 <free+0x78>

0000000000000804 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 804:	7139                	addi	sp,sp,-64
 806:	fc06                	sd	ra,56(sp)
 808:	f822                	sd	s0,48(sp)
 80a:	f04a                	sd	s2,32(sp)
 80c:	ec4e                	sd	s3,24(sp)
 80e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 810:	02051993          	slli	s3,a0,0x20
 814:	0209d993          	srli	s3,s3,0x20
 818:	09bd                	addi	s3,s3,15
 81a:	0049d993          	srli	s3,s3,0x4
 81e:	2985                	addiw	s3,s3,1
 820:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 822:	00000517          	auipc	a0,0x0
 826:	7de53503          	ld	a0,2014(a0) # 1000 <freep>
 82a:	c905                	beqz	a0,85a <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 82c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 82e:	4798                	lw	a4,8(a5)
 830:	09377663          	bgeu	a4,s3,8bc <malloc+0xb8>
 834:	f426                	sd	s1,40(sp)
 836:	e852                	sd	s4,16(sp)
 838:	e456                	sd	s5,8(sp)
 83a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 83c:	8a4e                	mv	s4,s3
 83e:	6705                	lui	a4,0x1
 840:	00e9f363          	bgeu	s3,a4,846 <malloc+0x42>
 844:	6a05                	lui	s4,0x1
 846:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 84a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 84e:	00000497          	auipc	s1,0x0
 852:	7b248493          	addi	s1,s1,1970 # 1000 <freep>
  if(p == SBRK_ERROR)
 856:	5afd                	li	s5,-1
 858:	a83d                	j	896 <malloc+0x92>
 85a:	f426                	sd	s1,40(sp)
 85c:	e852                	sd	s4,16(sp)
 85e:	e456                	sd	s5,8(sp)
 860:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 862:	00000797          	auipc	a5,0x0
 866:	7ae78793          	addi	a5,a5,1966 # 1010 <base>
 86a:	00000717          	auipc	a4,0x0
 86e:	78f73b23          	sd	a5,1942(a4) # 1000 <freep>
 872:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 874:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 878:	b7d1                	j	83c <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 87a:	6398                	ld	a4,0(a5)
 87c:	e118                	sd	a4,0(a0)
 87e:	a899                	j	8d4 <malloc+0xd0>
  hp->s.size = nu;
 880:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 884:	0541                	addi	a0,a0,16
 886:	ef5ff0ef          	jal	77a <free>
  return freep;
 88a:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 88c:	c125                	beqz	a0,8ec <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 88e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 890:	4798                	lw	a4,8(a5)
 892:	03277163          	bgeu	a4,s2,8b4 <malloc+0xb0>
    if(p == freep)
 896:	6098                	ld	a4,0(s1)
 898:	853e                	mv	a0,a5
 89a:	fef71ae3          	bne	a4,a5,88e <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 89e:	8552                	mv	a0,s4
 8a0:	a17ff0ef          	jal	2b6 <sbrk>
  if(p == SBRK_ERROR)
 8a4:	fd551ee3          	bne	a0,s5,880 <malloc+0x7c>
        return 0;
 8a8:	4501                	li	a0,0
 8aa:	74a2                	ld	s1,40(sp)
 8ac:	6a42                	ld	s4,16(sp)
 8ae:	6aa2                	ld	s5,8(sp)
 8b0:	6b02                	ld	s6,0(sp)
 8b2:	a03d                	j	8e0 <malloc+0xdc>
 8b4:	74a2                	ld	s1,40(sp)
 8b6:	6a42                	ld	s4,16(sp)
 8b8:	6aa2                	ld	s5,8(sp)
 8ba:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8bc:	fae90fe3          	beq	s2,a4,87a <malloc+0x76>
        p->s.size -= nunits;
 8c0:	4137073b          	subw	a4,a4,s3
 8c4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8c6:	02071693          	slli	a3,a4,0x20
 8ca:	01c6d713          	srli	a4,a3,0x1c
 8ce:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8d0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8d4:	00000717          	auipc	a4,0x0
 8d8:	72a73623          	sd	a0,1836(a4) # 1000 <freep>
      return (void*)(p + 1);
 8dc:	01078513          	addi	a0,a5,16
  }
}
 8e0:	70e2                	ld	ra,56(sp)
 8e2:	7442                	ld	s0,48(sp)
 8e4:	7902                	ld	s2,32(sp)
 8e6:	69e2                	ld	s3,24(sp)
 8e8:	6121                	addi	sp,sp,64
 8ea:	8082                	ret
 8ec:	74a2                	ld	s1,40(sp)
 8ee:	6a42                	ld	s4,16(sp)
 8f0:	6aa2                	ld	s5,8(sp)
 8f2:	6b02                	ld	s6,0(sp)
 8f4:	b7f5                	j	8e0 <malloc+0xdc>
