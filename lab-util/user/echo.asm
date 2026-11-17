
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	e05a                	sd	s6,0(sp)
  12:	0080                	addi	s0,sp,64
  int i;

  for(i = 1; i < argc; i++){
  14:	4785                	li	a5,1
  16:	06a7d063          	bge	a5,a0,76 <main+0x76>
  1a:	00858493          	addi	s1,a1,8
  1e:	3579                	addiw	a0,a0,-2
  20:	02051793          	slli	a5,a0,0x20
  24:	01d7d513          	srli	a0,a5,0x1d
  28:	00a48ab3          	add	s5,s1,a0
  2c:	05c1                	addi	a1,a1,16
  2e:	00a58a33          	add	s4,a1,a0
    write(1, argv[i], strlen(argv[i]));
  32:	4985                	li	s3,1
    if(i + 1 < argc){
      write(1, " ", 1);
  34:	00001b17          	auipc	s6,0x1
  38:	90cb0b13          	addi	s6,s6,-1780 # 940 <malloc+0xf2>
  3c:	a809                	j	4e <main+0x4e>
  3e:	864e                	mv	a2,s3
  40:	85da                	mv	a1,s6
  42:	854e                	mv	a0,s3
  44:	310000ef          	jal	354 <write>
  for(i = 1; i < argc; i++){
  48:	04a1                	addi	s1,s1,8
  4a:	03448663          	beq	s1,s4,76 <main+0x76>
    write(1, argv[i], strlen(argv[i]));
  4e:	0004b903          	ld	s2,0(s1)
  52:	854a                	mv	a0,s2
  54:	08a000ef          	jal	de <strlen>
  58:	862a                	mv	a2,a0
  5a:	85ca                	mv	a1,s2
  5c:	854e                	mv	a0,s3
  5e:	2f6000ef          	jal	354 <write>
    if(i + 1 < argc){
  62:	fd549ee3          	bne	s1,s5,3e <main+0x3e>
    } else {
      write(1, "\n", 1);
  66:	4605                	li	a2,1
  68:	00001597          	auipc	a1,0x1
  6c:	8e058593          	addi	a1,a1,-1824 # 948 <malloc+0xfa>
  70:	8532                	mv	a0,a2
  72:	2e2000ef          	jal	354 <write>
    }
  }
  exit(0);
  76:	4501                	li	a0,0
  78:	2bc000ef          	jal	334 <exit>

000000000000007c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  7c:	1141                	addi	sp,sp,-16
  7e:	e406                	sd	ra,8(sp)
  80:	e022                	sd	s0,0(sp)
  82:	0800                	addi	s0,sp,16
  extern int main();
  main();
  84:	f7dff0ef          	jal	0 <main>
  exit(0);
  88:	4501                	li	a0,0
  8a:	2aa000ef          	jal	334 <exit>

000000000000008e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  8e:	1141                	addi	sp,sp,-16
  90:	e406                	sd	ra,8(sp)
  92:	e022                	sd	s0,0(sp)
  94:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  96:	87aa                	mv	a5,a0
  98:	0585                	addi	a1,a1,1
  9a:	0785                	addi	a5,a5,1
  9c:	fff5c703          	lbu	a4,-1(a1)
  a0:	fee78fa3          	sb	a4,-1(a5)
  a4:	fb75                	bnez	a4,98 <strcpy+0xa>
    ;
  return os;
}
  a6:	60a2                	ld	ra,8(sp)
  a8:	6402                	ld	s0,0(sp)
  aa:	0141                	addi	sp,sp,16
  ac:	8082                	ret

00000000000000ae <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ae:	1141                	addi	sp,sp,-16
  b0:	e406                	sd	ra,8(sp)
  b2:	e022                	sd	s0,0(sp)
  b4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  b6:	00054783          	lbu	a5,0(a0)
  ba:	cb91                	beqz	a5,ce <strcmp+0x20>
  bc:	0005c703          	lbu	a4,0(a1)
  c0:	00f71763          	bne	a4,a5,ce <strcmp+0x20>
    p++, q++;
  c4:	0505                	addi	a0,a0,1
  c6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  c8:	00054783          	lbu	a5,0(a0)
  cc:	fbe5                	bnez	a5,bc <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  ce:	0005c503          	lbu	a0,0(a1)
}
  d2:	40a7853b          	subw	a0,a5,a0
  d6:	60a2                	ld	ra,8(sp)
  d8:	6402                	ld	s0,0(sp)
  da:	0141                	addi	sp,sp,16
  dc:	8082                	ret

00000000000000de <strlen>:

uint
strlen(const char *s)
{
  de:	1141                	addi	sp,sp,-16
  e0:	e406                	sd	ra,8(sp)
  e2:	e022                	sd	s0,0(sp)
  e4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  e6:	00054783          	lbu	a5,0(a0)
  ea:	cf91                	beqz	a5,106 <strlen+0x28>
  ec:	00150793          	addi	a5,a0,1
  f0:	86be                	mv	a3,a5
  f2:	0785                	addi	a5,a5,1
  f4:	fff7c703          	lbu	a4,-1(a5)
  f8:	ff65                	bnez	a4,f0 <strlen+0x12>
  fa:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  fe:	60a2                	ld	ra,8(sp)
 100:	6402                	ld	s0,0(sp)
 102:	0141                	addi	sp,sp,16
 104:	8082                	ret
  for(n = 0; s[n]; n++)
 106:	4501                	li	a0,0
 108:	bfdd                	j	fe <strlen+0x20>

000000000000010a <memset>:

void*
memset(void *dst, int c, uint n)
{
 10a:	1141                	addi	sp,sp,-16
 10c:	e406                	sd	ra,8(sp)
 10e:	e022                	sd	s0,0(sp)
 110:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 112:	ca19                	beqz	a2,128 <memset+0x1e>
 114:	87aa                	mv	a5,a0
 116:	1602                	slli	a2,a2,0x20
 118:	9201                	srli	a2,a2,0x20
 11a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 11e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 122:	0785                	addi	a5,a5,1
 124:	fee79de3          	bne	a5,a4,11e <memset+0x14>
  }
  return dst;
}
 128:	60a2                	ld	ra,8(sp)
 12a:	6402                	ld	s0,0(sp)
 12c:	0141                	addi	sp,sp,16
 12e:	8082                	ret

0000000000000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	1141                	addi	sp,sp,-16
 132:	e406                	sd	ra,8(sp)
 134:	e022                	sd	s0,0(sp)
 136:	0800                	addi	s0,sp,16
  for(; *s; s++)
 138:	00054783          	lbu	a5,0(a0)
 13c:	c799                	beqz	a5,14a <strchr+0x1a>
    if(*s == c)
 13e:	00f58763          	beq	a1,a5,14c <strchr+0x1c>
  for(; *s; s++)
 142:	0505                	addi	a0,a0,1
 144:	00054783          	lbu	a5,0(a0)
 148:	fbfd                	bnez	a5,13e <strchr+0xe>
      return (char*)s;
  return 0;
 14a:	4501                	li	a0,0
}
 14c:	60a2                	ld	ra,8(sp)
 14e:	6402                	ld	s0,0(sp)
 150:	0141                	addi	sp,sp,16
 152:	8082                	ret

0000000000000154 <gets>:

char*
gets(char *buf, int max)
{
 154:	711d                	addi	sp,sp,-96
 156:	ec86                	sd	ra,88(sp)
 158:	e8a2                	sd	s0,80(sp)
 15a:	e4a6                	sd	s1,72(sp)
 15c:	e0ca                	sd	s2,64(sp)
 15e:	fc4e                	sd	s3,56(sp)
 160:	f852                	sd	s4,48(sp)
 162:	f456                	sd	s5,40(sp)
 164:	f05a                	sd	s6,32(sp)
 166:	ec5e                	sd	s7,24(sp)
 168:	e862                	sd	s8,16(sp)
 16a:	1080                	addi	s0,sp,96
 16c:	8baa                	mv	s7,a0
 16e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 170:	892a                	mv	s2,a0
 172:	4481                	li	s1,0
    cc = read(0, &c, 1);
 174:	faf40b13          	addi	s6,s0,-81
 178:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 17a:	8c26                	mv	s8,s1
 17c:	0014899b          	addiw	s3,s1,1
 180:	84ce                	mv	s1,s3
 182:	0349d863          	bge	s3,s4,1b2 <gets+0x5e>
    cc = read(0, &c, 1);
 186:	8656                	mv	a2,s5
 188:	85da                	mv	a1,s6
 18a:	4501                	li	a0,0
 18c:	1c0000ef          	jal	34c <read>
    if(cc < 1)
 190:	02a05163          	blez	a0,1b2 <gets+0x5e>
      break;
    buf[i++] = c;
 194:	faf44783          	lbu	a5,-81(s0)
 198:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 19c:	0905                	addi	s2,s2,1
 19e:	ff678713          	addi	a4,a5,-10
 1a2:	00173713          	seqz	a4,a4
 1a6:	17cd                	addi	a5,a5,-13
 1a8:	0017b793          	seqz	a5,a5
 1ac:	8fd9                	or	a5,a5,a4
 1ae:	d7f1                	beqz	a5,17a <gets+0x26>
    buf[i++] = c;
 1b0:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 1b2:	9c5e                	add	s8,s8,s7
 1b4:	000c0023          	sb	zero,0(s8)
  return buf;
}
 1b8:	855e                	mv	a0,s7
 1ba:	60e6                	ld	ra,88(sp)
 1bc:	6446                	ld	s0,80(sp)
 1be:	64a6                	ld	s1,72(sp)
 1c0:	6906                	ld	s2,64(sp)
 1c2:	79e2                	ld	s3,56(sp)
 1c4:	7a42                	ld	s4,48(sp)
 1c6:	7aa2                	ld	s5,40(sp)
 1c8:	7b02                	ld	s6,32(sp)
 1ca:	6be2                	ld	s7,24(sp)
 1cc:	6c42                	ld	s8,16(sp)
 1ce:	6125                	addi	sp,sp,96
 1d0:	8082                	ret

00000000000001d2 <stat>:

int
stat(const char *n, struct stat *st)
{
 1d2:	1101                	addi	sp,sp,-32
 1d4:	ec06                	sd	ra,24(sp)
 1d6:	e822                	sd	s0,16(sp)
 1d8:	e04a                	sd	s2,0(sp)
 1da:	1000                	addi	s0,sp,32
 1dc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1de:	4581                	li	a1,0
 1e0:	194000ef          	jal	374 <open>
  if(fd < 0)
 1e4:	02054263          	bltz	a0,208 <stat+0x36>
 1e8:	e426                	sd	s1,8(sp)
 1ea:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1ec:	85ca                	mv	a1,s2
 1ee:	19e000ef          	jal	38c <fstat>
 1f2:	892a                	mv	s2,a0
  close(fd);
 1f4:	8526                	mv	a0,s1
 1f6:	166000ef          	jal	35c <close>
  return r;
 1fa:	64a2                	ld	s1,8(sp)
}
 1fc:	854a                	mv	a0,s2
 1fe:	60e2                	ld	ra,24(sp)
 200:	6442                	ld	s0,16(sp)
 202:	6902                	ld	s2,0(sp)
 204:	6105                	addi	sp,sp,32
 206:	8082                	ret
    return -1;
 208:	57fd                	li	a5,-1
 20a:	893e                	mv	s2,a5
 20c:	bfc5                	j	1fc <stat+0x2a>

000000000000020e <atoi>:

int
atoi(const char *s)
{
 20e:	1141                	addi	sp,sp,-16
 210:	e406                	sd	ra,8(sp)
 212:	e022                	sd	s0,0(sp)
 214:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 216:	00054683          	lbu	a3,0(a0)
 21a:	fd06879b          	addiw	a5,a3,-48
 21e:	0ff7f793          	zext.b	a5,a5
 222:	4625                	li	a2,9
 224:	02f66963          	bltu	a2,a5,256 <atoi+0x48>
 228:	872a                	mv	a4,a0
  n = 0;
 22a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 22c:	0705                	addi	a4,a4,1
 22e:	0025179b          	slliw	a5,a0,0x2
 232:	9fa9                	addw	a5,a5,a0
 234:	0017979b          	slliw	a5,a5,0x1
 238:	9fb5                	addw	a5,a5,a3
 23a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 23e:	00074683          	lbu	a3,0(a4)
 242:	fd06879b          	addiw	a5,a3,-48
 246:	0ff7f793          	zext.b	a5,a5
 24a:	fef671e3          	bgeu	a2,a5,22c <atoi+0x1e>
  return n;
}
 24e:	60a2                	ld	ra,8(sp)
 250:	6402                	ld	s0,0(sp)
 252:	0141                	addi	sp,sp,16
 254:	8082                	ret
  n = 0;
 256:	4501                	li	a0,0
 258:	bfdd                	j	24e <atoi+0x40>

000000000000025a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 25a:	1141                	addi	sp,sp,-16
 25c:	e406                	sd	ra,8(sp)
 25e:	e022                	sd	s0,0(sp)
 260:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 262:	02b57563          	bgeu	a0,a1,28c <memmove+0x32>
    while(n-- > 0)
 266:	00c05f63          	blez	a2,284 <memmove+0x2a>
 26a:	1602                	slli	a2,a2,0x20
 26c:	9201                	srli	a2,a2,0x20
 26e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 272:	872a                	mv	a4,a0
      *dst++ = *src++;
 274:	0585                	addi	a1,a1,1
 276:	0705                	addi	a4,a4,1
 278:	fff5c683          	lbu	a3,-1(a1)
 27c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 280:	fee79ae3          	bne	a5,a4,274 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 284:	60a2                	ld	ra,8(sp)
 286:	6402                	ld	s0,0(sp)
 288:	0141                	addi	sp,sp,16
 28a:	8082                	ret
    while(n-- > 0)
 28c:	fec05ce3          	blez	a2,284 <memmove+0x2a>
    dst += n;
 290:	00c50733          	add	a4,a0,a2
    src += n;
 294:	95b2                	add	a1,a1,a2
 296:	fff6079b          	addiw	a5,a2,-1
 29a:	1782                	slli	a5,a5,0x20
 29c:	9381                	srli	a5,a5,0x20
 29e:	fff7c793          	not	a5,a5
 2a2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2a4:	15fd                	addi	a1,a1,-1
 2a6:	177d                	addi	a4,a4,-1
 2a8:	0005c683          	lbu	a3,0(a1)
 2ac:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2b0:	fef71ae3          	bne	a4,a5,2a4 <memmove+0x4a>
 2b4:	bfc1                	j	284 <memmove+0x2a>

00000000000002b6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2b6:	1141                	addi	sp,sp,-16
 2b8:	e406                	sd	ra,8(sp)
 2ba:	e022                	sd	s0,0(sp)
 2bc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2be:	ce19                	beqz	a2,2dc <memcmp+0x26>
 2c0:	1602                	slli	a2,a2,0x20
 2c2:	9201                	srli	a2,a2,0x20
 2c4:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 2c8:	00054783          	lbu	a5,0(a0)
 2cc:	0005c703          	lbu	a4,0(a1)
 2d0:	00e79b63          	bne	a5,a4,2e6 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 2d4:	0505                	addi	a0,a0,1
    p2++;
 2d6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2d8:	fed518e3          	bne	a0,a3,2c8 <memcmp+0x12>
  }
  return 0;
 2dc:	4501                	li	a0,0
}
 2de:	60a2                	ld	ra,8(sp)
 2e0:	6402                	ld	s0,0(sp)
 2e2:	0141                	addi	sp,sp,16
 2e4:	8082                	ret
      return *p1 - *p2;
 2e6:	40e7853b          	subw	a0,a5,a4
 2ea:	bfd5                	j	2de <memcmp+0x28>

00000000000002ec <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2ec:	1141                	addi	sp,sp,-16
 2ee:	e406                	sd	ra,8(sp)
 2f0:	e022                	sd	s0,0(sp)
 2f2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2f4:	f67ff0ef          	jal	25a <memmove>
}
 2f8:	60a2                	ld	ra,8(sp)
 2fa:	6402                	ld	s0,0(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret

0000000000000300 <sbrk>:

char *
sbrk(int n) {
 300:	1141                	addi	sp,sp,-16
 302:	e406                	sd	ra,8(sp)
 304:	e022                	sd	s0,0(sp)
 306:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 308:	4585                	li	a1,1
 30a:	0b2000ef          	jal	3bc <sys_sbrk>
}
 30e:	60a2                	ld	ra,8(sp)
 310:	6402                	ld	s0,0(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret

0000000000000316 <sbrklazy>:

char *
sbrklazy(int n) {
 316:	1141                	addi	sp,sp,-16
 318:	e406                	sd	ra,8(sp)
 31a:	e022                	sd	s0,0(sp)
 31c:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 31e:	4589                	li	a1,2
 320:	09c000ef          	jal	3bc <sys_sbrk>
}
 324:	60a2                	ld	ra,8(sp)
 326:	6402                	ld	s0,0(sp)
 328:	0141                	addi	sp,sp,16
 32a:	8082                	ret

000000000000032c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 32c:	4885                	li	a7,1
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <exit>:
.global exit
exit:
 li a7, SYS_exit
 334:	4889                	li	a7,2
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <wait>:
.global wait
wait:
 li a7, SYS_wait
 33c:	488d                	li	a7,3
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 344:	4891                	li	a7,4
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <read>:
.global read
read:
 li a7, SYS_read
 34c:	4895                	li	a7,5
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <write>:
.global write
write:
 li a7, SYS_write
 354:	48c1                	li	a7,16
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <close>:
.global close
close:
 li a7, SYS_close
 35c:	48d5                	li	a7,21
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <kill>:
.global kill
kill:
 li a7, SYS_kill
 364:	4899                	li	a7,6
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <exec>:
.global exec
exec:
 li a7, SYS_exec
 36c:	489d                	li	a7,7
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <open>:
.global open
open:
 li a7, SYS_open
 374:	48bd                	li	a7,15
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 37c:	48c5                	li	a7,17
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 384:	48c9                	li	a7,18
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 38c:	48a1                	li	a7,8
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <link>:
.global link
link:
 li a7, SYS_link
 394:	48cd                	li	a7,19
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 39c:	48d1                	li	a7,20
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3a4:	48a5                	li	a7,9
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <dup>:
.global dup
dup:
 li a7, SYS_dup
 3ac:	48a9                	li	a7,10
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3b4:	48ad                	li	a7,11
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3bc:	48b1                	li	a7,12
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <pause>:
.global pause
pause:
 li a7, SYS_pause
 3c4:	48b5                	li	a7,13
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3cc:	48b9                	li	a7,14
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3d4:	1101                	addi	sp,sp,-32
 3d6:	ec06                	sd	ra,24(sp)
 3d8:	e822                	sd	s0,16(sp)
 3da:	1000                	addi	s0,sp,32
 3dc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3e0:	4605                	li	a2,1
 3e2:	fef40593          	addi	a1,s0,-17
 3e6:	f6fff0ef          	jal	354 <write>
}
 3ea:	60e2                	ld	ra,24(sp)
 3ec:	6442                	ld	s0,16(sp)
 3ee:	6105                	addi	sp,sp,32
 3f0:	8082                	ret

00000000000003f2 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 3f2:	715d                	addi	sp,sp,-80
 3f4:	e486                	sd	ra,72(sp)
 3f6:	e0a2                	sd	s0,64(sp)
 3f8:	f84a                	sd	s2,48(sp)
 3fa:	f44e                	sd	s3,40(sp)
 3fc:	0880                	addi	s0,sp,80
 3fe:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 400:	00d036b3          	snez	a3,a3
 404:	03f5d793          	srli	a5,a1,0x3f
 408:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 40a:	0005871b          	sext.w	a4,a1
  neg = 0;
 40e:	4301                	li	t1,0
  if(sgn && xx < 0){
 410:	c681                	beqz	a3,418 <printint+0x26>
    x = -xx;
 412:	40b0073b          	negw	a4,a1
    neg = 1;
 416:	4305                	li	t1,1
  }

  i = 0;
 418:	fb840993          	addi	s3,s0,-72
  neg = 0;
 41c:	85ce                	mv	a1,s3
  i = 0;
 41e:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 420:	00000817          	auipc	a6,0x0
 424:	53880813          	addi	a6,a6,1336 # 958 <digits>
 428:	88b6                	mv	a7,a3
 42a:	0016851b          	addiw	a0,a3,1
 42e:	86aa                	mv	a3,a0
 430:	02c777bb          	remuw	a5,a4,a2
 434:	1782                	slli	a5,a5,0x20
 436:	9381                	srli	a5,a5,0x20
 438:	97c2                	add	a5,a5,a6
 43a:	0007c783          	lbu	a5,0(a5)
 43e:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 442:	87ba                	mv	a5,a4
 444:	02c7573b          	divuw	a4,a4,a2
 448:	0585                	addi	a1,a1,1
 44a:	fcc7ffe3          	bgeu	a5,a2,428 <printint+0x36>
  if(neg)
 44e:	00030b63          	beqz	t1,464 <printint+0x72>
    buf[i++] = '-';
 452:	fd040793          	addi	a5,s0,-48
 456:	953e                	add	a0,a0,a5
 458:	02d00793          	li	a5,45
 45c:	fef50423          	sb	a5,-24(a0)
 460:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 464:	02d05563          	blez	a3,48e <printint+0x9c>
 468:	fc26                	sd	s1,56(sp)
 46a:	36fd                	addiw	a3,a3,-1
 46c:	00d984b3          	add	s1,s3,a3
 470:	19fd                	addi	s3,s3,-1
 472:	99b6                	add	s3,s3,a3
 474:	1682                	slli	a3,a3,0x20
 476:	9281                	srli	a3,a3,0x20
 478:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 47c:	0004c583          	lbu	a1,0(s1)
 480:	854a                	mv	a0,s2
 482:	f53ff0ef          	jal	3d4 <putc>
  while(--i >= 0)
 486:	14fd                	addi	s1,s1,-1
 488:	ff349ae3          	bne	s1,s3,47c <printint+0x8a>
 48c:	74e2                	ld	s1,56(sp)
}
 48e:	60a6                	ld	ra,72(sp)
 490:	6406                	ld	s0,64(sp)
 492:	7942                	ld	s2,48(sp)
 494:	79a2                	ld	s3,40(sp)
 496:	6161                	addi	sp,sp,80
 498:	8082                	ret

000000000000049a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 49a:	711d                	addi	sp,sp,-96
 49c:	ec86                	sd	ra,88(sp)
 49e:	e8a2                	sd	s0,80(sp)
 4a0:	e4a6                	sd	s1,72(sp)
 4a2:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4a4:	0005c483          	lbu	s1,0(a1)
 4a8:	2a048063          	beqz	s1,748 <vprintf+0x2ae>
 4ac:	e0ca                	sd	s2,64(sp)
 4ae:	fc4e                	sd	s3,56(sp)
 4b0:	f852                	sd	s4,48(sp)
 4b2:	f456                	sd	s5,40(sp)
 4b4:	f05a                	sd	s6,32(sp)
 4b6:	ec5e                	sd	s7,24(sp)
 4b8:	e862                	sd	s8,16(sp)
 4ba:	8b2a                	mv	s6,a0
 4bc:	8a2e                	mv	s4,a1
 4be:	8bb2                	mv	s7,a2
  state = 0;
 4c0:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 4c2:	4901                	li	s2,0
 4c4:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 4c6:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4ca:	06400c13          	li	s8,100
 4ce:	a00d                	j	4f0 <vprintf+0x56>
        putc(fd, c0);
 4d0:	85a6                	mv	a1,s1
 4d2:	855a                	mv	a0,s6
 4d4:	f01ff0ef          	jal	3d4 <putc>
 4d8:	a019                	j	4de <vprintf+0x44>
    } else if(state == '%'){
 4da:	03598363          	beq	s3,s5,500 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 4de:	0019079b          	addiw	a5,s2,1
 4e2:	893e                	mv	s2,a5
 4e4:	873e                	mv	a4,a5
 4e6:	97d2                	add	a5,a5,s4
 4e8:	0007c483          	lbu	s1,0(a5)
 4ec:	24048763          	beqz	s1,73a <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 4f0:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4f4:	fe0993e3          	bnez	s3,4da <vprintf+0x40>
      if(c0 == '%'){
 4f8:	fd579ce3          	bne	a5,s5,4d0 <vprintf+0x36>
        state = '%';
 4fc:	89be                	mv	s3,a5
 4fe:	b7c5                	j	4de <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 500:	00ea06b3          	add	a3,s4,a4
 504:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 508:	24060563          	beqz	a2,752 <vprintf+0x2b8>
      if(c0 == 'd'){
 50c:	0b878763          	beq	a5,s8,5ba <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 510:	f9478693          	addi	a3,a5,-108
 514:	0016b693          	seqz	a3,a3
 518:	f9c60593          	addi	a1,a2,-100
 51c:	0015b593          	seqz	a1,a1
 520:	8df5                	and	a1,a1,a3
 522:	e9c5                	bnez	a1,5d2 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 524:	9752                	add	a4,a4,s4
 526:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 52a:	f9460713          	addi	a4,a2,-108
 52e:	00173713          	seqz	a4,a4
 532:	8f75                	and	a4,a4,a3
 534:	f9c50593          	addi	a1,a0,-100
 538:	0015b593          	seqz	a1,a1
 53c:	8df9                	and	a1,a1,a4
 53e:	e5dd                	bnez	a1,5ec <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 540:	07500593          	li	a1,117
 544:	0cb78163          	beq	a5,a1,606 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 548:	f8b60593          	addi	a1,a2,-117
 54c:	0015b593          	seqz	a1,a1
 550:	8df5                	and	a1,a1,a3
 552:	e5f1                	bnez	a1,61e <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 554:	f8b50593          	addi	a1,a0,-117
 558:	0015b593          	seqz	a1,a1
 55c:	8df9                	and	a1,a1,a4
 55e:	ede9                	bnez	a1,638 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 560:	07800593          	li	a1,120
 564:	0eb78763          	beq	a5,a1,652 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 568:	f8860613          	addi	a2,a2,-120
 56c:	00163613          	seqz	a2,a2
 570:	8ef1                	and	a3,a3,a2
 572:	0e069c63          	bnez	a3,66a <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 576:	f8850513          	addi	a0,a0,-120
 57a:	00153513          	seqz	a0,a0
 57e:	8f69                	and	a4,a4,a0
 580:	10071263          	bnez	a4,684 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 584:	07000713          	li	a4,112
 588:	10e78a63          	beq	a5,a4,69c <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 58c:	06300713          	li	a4,99
 590:	14e78a63          	beq	a5,a4,6e4 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 594:	07300713          	li	a4,115
 598:	16e78063          	beq	a5,a4,6f8 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 59c:	02500713          	li	a4,37
 5a0:	18e78863          	beq	a5,a4,730 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5a4:	02500593          	li	a1,37
 5a8:	855a                	mv	a0,s6
 5aa:	e2bff0ef          	jal	3d4 <putc>
        putc(fd, c0);
 5ae:	85a6                	mv	a1,s1
 5b0:	855a                	mv	a0,s6
 5b2:	e23ff0ef          	jal	3d4 <putc>
      }

      state = 0;
 5b6:	4981                	li	s3,0
 5b8:	b71d                	j	4de <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 5ba:	008b8493          	addi	s1,s7,8
 5be:	4685                	li	a3,1
 5c0:	4629                	li	a2,10
 5c2:	000ba583          	lw	a1,0(s7)
 5c6:	855a                	mv	a0,s6
 5c8:	e2bff0ef          	jal	3f2 <printint>
 5cc:	8ba6                	mv	s7,s1
      state = 0;
 5ce:	4981                	li	s3,0
 5d0:	b739                	j	4de <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d2:	008b8493          	addi	s1,s7,8
 5d6:	4685                	li	a3,1
 5d8:	4629                	li	a2,10
 5da:	000bb583          	ld	a1,0(s7)
 5de:	855a                	mv	a0,s6
 5e0:	e13ff0ef          	jal	3f2 <printint>
        i += 1;
 5e4:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5e6:	8ba6                	mv	s7,s1
      state = 0;
 5e8:	4981                	li	s3,0
 5ea:	bdd5                	j	4de <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5ec:	008b8493          	addi	s1,s7,8
 5f0:	4685                	li	a3,1
 5f2:	4629                	li	a2,10
 5f4:	000bb583          	ld	a1,0(s7)
 5f8:	855a                	mv	a0,s6
 5fa:	df9ff0ef          	jal	3f2 <printint>
        i += 2;
 5fe:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 600:	8ba6                	mv	s7,s1
      state = 0;
 602:	4981                	li	s3,0
        i += 2;
 604:	bde9                	j	4de <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 606:	008b8493          	addi	s1,s7,8
 60a:	4681                	li	a3,0
 60c:	4629                	li	a2,10
 60e:	000be583          	lwu	a1,0(s7)
 612:	855a                	mv	a0,s6
 614:	ddfff0ef          	jal	3f2 <printint>
 618:	8ba6                	mv	s7,s1
      state = 0;
 61a:	4981                	li	s3,0
 61c:	b5c9                	j	4de <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 61e:	008b8493          	addi	s1,s7,8
 622:	4681                	li	a3,0
 624:	4629                	li	a2,10
 626:	000bb583          	ld	a1,0(s7)
 62a:	855a                	mv	a0,s6
 62c:	dc7ff0ef          	jal	3f2 <printint>
        i += 1;
 630:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 632:	8ba6                	mv	s7,s1
      state = 0;
 634:	4981                	li	s3,0
 636:	b565                	j	4de <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 638:	008b8493          	addi	s1,s7,8
 63c:	4681                	li	a3,0
 63e:	4629                	li	a2,10
 640:	000bb583          	ld	a1,0(s7)
 644:	855a                	mv	a0,s6
 646:	dadff0ef          	jal	3f2 <printint>
        i += 2;
 64a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 64c:	8ba6                	mv	s7,s1
      state = 0;
 64e:	4981                	li	s3,0
        i += 2;
 650:	b579                	j	4de <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 652:	008b8493          	addi	s1,s7,8
 656:	4681                	li	a3,0
 658:	4641                	li	a2,16
 65a:	000be583          	lwu	a1,0(s7)
 65e:	855a                	mv	a0,s6
 660:	d93ff0ef          	jal	3f2 <printint>
 664:	8ba6                	mv	s7,s1
      state = 0;
 666:	4981                	li	s3,0
 668:	bd9d                	j	4de <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 66a:	008b8493          	addi	s1,s7,8
 66e:	4681                	li	a3,0
 670:	4641                	li	a2,16
 672:	000bb583          	ld	a1,0(s7)
 676:	855a                	mv	a0,s6
 678:	d7bff0ef          	jal	3f2 <printint>
        i += 1;
 67c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 67e:	8ba6                	mv	s7,s1
      state = 0;
 680:	4981                	li	s3,0
 682:	bdb1                	j	4de <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 684:	008b8493          	addi	s1,s7,8
 688:	4641                	li	a2,16
 68a:	000bb583          	ld	a1,0(s7)
 68e:	855a                	mv	a0,s6
 690:	d63ff0ef          	jal	3f2 <printint>
        i += 2;
 694:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 696:	8ba6                	mv	s7,s1
      state = 0;
 698:	4981                	li	s3,0
        i += 2;
 69a:	b591                	j	4de <vprintf+0x44>
 69c:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 69e:	008b8793          	addi	a5,s7,8
 6a2:	8cbe                	mv	s9,a5
 6a4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6a8:	03000593          	li	a1,48
 6ac:	855a                	mv	a0,s6
 6ae:	d27ff0ef          	jal	3d4 <putc>
  putc(fd, 'x');
 6b2:	07800593          	li	a1,120
 6b6:	855a                	mv	a0,s6
 6b8:	d1dff0ef          	jal	3d4 <putc>
 6bc:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6be:	00000b97          	auipc	s7,0x0
 6c2:	29ab8b93          	addi	s7,s7,666 # 958 <digits>
 6c6:	03c9d793          	srli	a5,s3,0x3c
 6ca:	97de                	add	a5,a5,s7
 6cc:	0007c583          	lbu	a1,0(a5)
 6d0:	855a                	mv	a0,s6
 6d2:	d03ff0ef          	jal	3d4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6d6:	0992                	slli	s3,s3,0x4
 6d8:	34fd                	addiw	s1,s1,-1
 6da:	f4f5                	bnez	s1,6c6 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 6dc:	8be6                	mv	s7,s9
      state = 0;
 6de:	4981                	li	s3,0
 6e0:	6ca2                	ld	s9,8(sp)
 6e2:	bbf5                	j	4de <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 6e4:	008b8493          	addi	s1,s7,8
 6e8:	000bc583          	lbu	a1,0(s7)
 6ec:	855a                	mv	a0,s6
 6ee:	ce7ff0ef          	jal	3d4 <putc>
 6f2:	8ba6                	mv	s7,s1
      state = 0;
 6f4:	4981                	li	s3,0
 6f6:	b3e5                	j	4de <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 6f8:	008b8993          	addi	s3,s7,8
 6fc:	000bb483          	ld	s1,0(s7)
 700:	cc91                	beqz	s1,71c <vprintf+0x282>
        for(; *s; s++)
 702:	0004c583          	lbu	a1,0(s1)
 706:	c195                	beqz	a1,72a <vprintf+0x290>
          putc(fd, *s);
 708:	855a                	mv	a0,s6
 70a:	ccbff0ef          	jal	3d4 <putc>
        for(; *s; s++)
 70e:	0485                	addi	s1,s1,1
 710:	0004c583          	lbu	a1,0(s1)
 714:	f9f5                	bnez	a1,708 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 716:	8bce                	mv	s7,s3
      state = 0;
 718:	4981                	li	s3,0
 71a:	b3d1                	j	4de <vprintf+0x44>
          s = "(null)";
 71c:	00000497          	auipc	s1,0x0
 720:	23448493          	addi	s1,s1,564 # 950 <malloc+0x102>
        for(; *s; s++)
 724:	02800593          	li	a1,40
 728:	b7c5                	j	708 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 72a:	8bce                	mv	s7,s3
      state = 0;
 72c:	4981                	li	s3,0
 72e:	bb45                	j	4de <vprintf+0x44>
        putc(fd, '%');
 730:	85be                	mv	a1,a5
 732:	855a                	mv	a0,s6
 734:	ca1ff0ef          	jal	3d4 <putc>
 738:	bdbd                	j	5b6 <vprintf+0x11c>
 73a:	6906                	ld	s2,64(sp)
 73c:	79e2                	ld	s3,56(sp)
 73e:	7a42                	ld	s4,48(sp)
 740:	7aa2                	ld	s5,40(sp)
 742:	7b02                	ld	s6,32(sp)
 744:	6be2                	ld	s7,24(sp)
 746:	6c42                	ld	s8,16(sp)
    }
  }
}
 748:	60e6                	ld	ra,88(sp)
 74a:	6446                	ld	s0,80(sp)
 74c:	64a6                	ld	s1,72(sp)
 74e:	6125                	addi	sp,sp,96
 750:	8082                	ret
      if(c0 == 'd'){
 752:	06400713          	li	a4,100
 756:	e6e782e3          	beq	a5,a4,5ba <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 75a:	f9478693          	addi	a3,a5,-108
 75e:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 762:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 764:	4701                	li	a4,0
 766:	bbe9                	j	540 <vprintf+0xa6>

0000000000000768 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 768:	715d                	addi	sp,sp,-80
 76a:	ec06                	sd	ra,24(sp)
 76c:	e822                	sd	s0,16(sp)
 76e:	1000                	addi	s0,sp,32
 770:	e010                	sd	a2,0(s0)
 772:	e414                	sd	a3,8(s0)
 774:	e818                	sd	a4,16(s0)
 776:	ec1c                	sd	a5,24(s0)
 778:	03043023          	sd	a6,32(s0)
 77c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 780:	8622                	mv	a2,s0
 782:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 786:	d15ff0ef          	jal	49a <vprintf>
}
 78a:	60e2                	ld	ra,24(sp)
 78c:	6442                	ld	s0,16(sp)
 78e:	6161                	addi	sp,sp,80
 790:	8082                	ret

0000000000000792 <printf>:

void
printf(const char *fmt, ...)
{
 792:	711d                	addi	sp,sp,-96
 794:	ec06                	sd	ra,24(sp)
 796:	e822                	sd	s0,16(sp)
 798:	1000                	addi	s0,sp,32
 79a:	e40c                	sd	a1,8(s0)
 79c:	e810                	sd	a2,16(s0)
 79e:	ec14                	sd	a3,24(s0)
 7a0:	f018                	sd	a4,32(s0)
 7a2:	f41c                	sd	a5,40(s0)
 7a4:	03043823          	sd	a6,48(s0)
 7a8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7ac:	00840613          	addi	a2,s0,8
 7b0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7b4:	85aa                	mv	a1,a0
 7b6:	4505                	li	a0,1
 7b8:	ce3ff0ef          	jal	49a <vprintf>
}
 7bc:	60e2                	ld	ra,24(sp)
 7be:	6442                	ld	s0,16(sp)
 7c0:	6125                	addi	sp,sp,96
 7c2:	8082                	ret

00000000000007c4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7c4:	1141                	addi	sp,sp,-16
 7c6:	e406                	sd	ra,8(sp)
 7c8:	e022                	sd	s0,0(sp)
 7ca:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7cc:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d0:	00001797          	auipc	a5,0x1
 7d4:	8307b783          	ld	a5,-2000(a5) # 1000 <freep>
 7d8:	a095                	j	83c <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7da:	ff852583          	lw	a1,-8(a0)
 7de:	6390                	ld	a2,0(a5)
 7e0:	02059813          	slli	a6,a1,0x20
 7e4:	01c85693          	srli	a3,a6,0x1c
 7e8:	96ba                	add	a3,a3,a4
 7ea:	02d60563          	beq	a2,a3,814 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7ee:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7f2:	4790                	lw	a2,8(a5)
 7f4:	02061593          	slli	a1,a2,0x20
 7f8:	01c5d693          	srli	a3,a1,0x1c
 7fc:	96be                	add	a3,a3,a5
 7fe:	02d70263          	beq	a4,a3,822 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 802:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 804:	00000717          	auipc	a4,0x0
 808:	7ef73e23          	sd	a5,2044(a4) # 1000 <freep>
}
 80c:	60a2                	ld	ra,8(sp)
 80e:	6402                	ld	s0,0(sp)
 810:	0141                	addi	sp,sp,16
 812:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 814:	4614                	lw	a3,8(a2)
 816:	9ead                	addw	a3,a3,a1
 818:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 81c:	6394                	ld	a3,0(a5)
 81e:	6290                	ld	a2,0(a3)
 820:	b7f9                	j	7ee <free+0x2a>
    p->s.size += bp->s.size;
 822:	ff852703          	lw	a4,-8(a0)
 826:	9f31                	addw	a4,a4,a2
 828:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 82a:	ff053703          	ld	a4,-16(a0)
 82e:	bfd1                	j	802 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 830:	6394                	ld	a3,0(a5)
 832:	00d7e463          	bltu	a5,a3,83a <free+0x76>
 836:	fad762e3          	bltu	a4,a3,7da <free+0x16>
 83a:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83c:	fee7fae3          	bgeu	a5,a4,830 <free+0x6c>
 840:	6394                	ld	a3,0(a5)
 842:	f8d76ce3          	bltu	a4,a3,7da <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 846:	f8d7fae3          	bgeu	a5,a3,7da <free+0x16>
 84a:	87b6                	mv	a5,a3
 84c:	bfc5                	j	83c <free+0x78>

000000000000084e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 84e:	7139                	addi	sp,sp,-64
 850:	fc06                	sd	ra,56(sp)
 852:	f822                	sd	s0,48(sp)
 854:	f04a                	sd	s2,32(sp)
 856:	ec4e                	sd	s3,24(sp)
 858:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 85a:	02051993          	slli	s3,a0,0x20
 85e:	0209d993          	srli	s3,s3,0x20
 862:	09bd                	addi	s3,s3,15
 864:	0049d993          	srli	s3,s3,0x4
 868:	2985                	addiw	s3,s3,1
 86a:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 86c:	00000517          	auipc	a0,0x0
 870:	79453503          	ld	a0,1940(a0) # 1000 <freep>
 874:	c905                	beqz	a0,8a4 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 876:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 878:	4798                	lw	a4,8(a5)
 87a:	09377663          	bgeu	a4,s3,906 <malloc+0xb8>
 87e:	f426                	sd	s1,40(sp)
 880:	e852                	sd	s4,16(sp)
 882:	e456                	sd	s5,8(sp)
 884:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 886:	8a4e                	mv	s4,s3
 888:	6705                	lui	a4,0x1
 88a:	00e9f363          	bgeu	s3,a4,890 <malloc+0x42>
 88e:	6a05                	lui	s4,0x1
 890:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 894:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 898:	00000497          	auipc	s1,0x0
 89c:	76848493          	addi	s1,s1,1896 # 1000 <freep>
  if(p == SBRK_ERROR)
 8a0:	5afd                	li	s5,-1
 8a2:	a83d                	j	8e0 <malloc+0x92>
 8a4:	f426                	sd	s1,40(sp)
 8a6:	e852                	sd	s4,16(sp)
 8a8:	e456                	sd	s5,8(sp)
 8aa:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8ac:	00000797          	auipc	a5,0x0
 8b0:	76478793          	addi	a5,a5,1892 # 1010 <base>
 8b4:	00000717          	auipc	a4,0x0
 8b8:	74f73623          	sd	a5,1868(a4) # 1000 <freep>
 8bc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8be:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8c2:	b7d1                	j	886 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8c4:	6398                	ld	a4,0(a5)
 8c6:	e118                	sd	a4,0(a0)
 8c8:	a899                	j	91e <malloc+0xd0>
  hp->s.size = nu;
 8ca:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8ce:	0541                	addi	a0,a0,16
 8d0:	ef5ff0ef          	jal	7c4 <free>
  return freep;
 8d4:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8d6:	c125                	beqz	a0,936 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8da:	4798                	lw	a4,8(a5)
 8dc:	03277163          	bgeu	a4,s2,8fe <malloc+0xb0>
    if(p == freep)
 8e0:	6098                	ld	a4,0(s1)
 8e2:	853e                	mv	a0,a5
 8e4:	fef71ae3          	bne	a4,a5,8d8 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 8e8:	8552                	mv	a0,s4
 8ea:	a17ff0ef          	jal	300 <sbrk>
  if(p == SBRK_ERROR)
 8ee:	fd551ee3          	bne	a0,s5,8ca <malloc+0x7c>
        return 0;
 8f2:	4501                	li	a0,0
 8f4:	74a2                	ld	s1,40(sp)
 8f6:	6a42                	ld	s4,16(sp)
 8f8:	6aa2                	ld	s5,8(sp)
 8fa:	6b02                	ld	s6,0(sp)
 8fc:	a03d                	j	92a <malloc+0xdc>
 8fe:	74a2                	ld	s1,40(sp)
 900:	6a42                	ld	s4,16(sp)
 902:	6aa2                	ld	s5,8(sp)
 904:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 906:	fae90fe3          	beq	s2,a4,8c4 <malloc+0x76>
        p->s.size -= nunits;
 90a:	4137073b          	subw	a4,a4,s3
 90e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 910:	02071693          	slli	a3,a4,0x20
 914:	01c6d713          	srli	a4,a3,0x1c
 918:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 91a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 91e:	00000717          	auipc	a4,0x0
 922:	6ea73123          	sd	a0,1762(a4) # 1000 <freep>
      return (void*)(p + 1);
 926:	01078513          	addi	a0,a5,16
  }
}
 92a:	70e2                	ld	ra,56(sp)
 92c:	7442                	ld	s0,48(sp)
 92e:	7902                	ld	s2,32(sp)
 930:	69e2                	ld	s3,24(sp)
 932:	6121                	addi	sp,sp,64
 934:	8082                	ret
 936:	74a2                	ld	s1,40(sp)
 938:	6a42                	ld	s4,16(sp)
 93a:	6aa2                	ld	s5,8(sp)
 93c:	6b02                	ld	s6,0(sp)
 93e:	b7f5                	j	92a <malloc+0xdc>
