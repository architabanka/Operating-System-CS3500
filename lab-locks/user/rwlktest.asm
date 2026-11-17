
user/_rwlktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int
main(void)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
   a:	4491                	li	s1,4
  int ncpu = 4;

  for (int i = 0; i < ncpu; i++) {
    if (fork() == 0) {
   c:	2fc000ef          	jal	308 <fork>
  10:	c911                	beqz	a0,24 <main+0x24>
  for (int i = 0; i < ncpu; i++) {
  12:	34fd                	addiw	s1,s1,-1
  14:	fce5                	bnez	s1,c <main+0xc>
  16:	f04a                	sd	s2,32(sp)
  18:	ec4e                	sd	s3,24(sp)
  1a:	4491                	li	s1,4
      int r = rwlktest();
      exit(r);
    }
  }

  int passed = 0;
  1c:	4901                	li	s2,0
  for (int i = 0; i < ncpu; i++) {
    int status;
    wait(&status);
  1e:	fcc40993          	addi	s3,s0,-52
  22:	a809                	j	34 <main+0x34>
  24:	f04a                	sd	s2,32(sp)
  26:	ec4e                	sd	s3,24(sp)
      int r = rwlktest();
  28:	3be000ef          	jal	3e6 <rwlktest>
      exit(r);
  2c:	2e4000ef          	jal	310 <exit>
  for (int i = 0; i < ncpu; i++) {
  30:	34fd                	addiw	s1,s1,-1
  32:	c889                	beqz	s1,44 <main+0x44>
    wait(&status);
  34:	854e                	mv	a0,s3
  36:	2e2000ef          	jal	318 <wait>
    if (status == 0)
  3a:	fcc42783          	lw	a5,-52(s0)
  3e:	fbed                	bnez	a5,30 <main+0x30>
      passed++;
  40:	2905                	addiw	s2,s2,1
  42:	b7fd                	j	30 <main+0x30>
  }

  printf("rwlktest: %d/%d CPUs succeeded\n", passed, ncpu);
  44:	4611                	li	a2,4
  46:	85ca                	mv	a1,s2
  48:	00001517          	auipc	a0,0x1
  4c:	98850513          	addi	a0,a0,-1656 # 9d0 <statistics+0x72>
  50:	760000ef          	jal	7b0 <printf>
  exit(0);
  54:	4501                	li	a0,0
  56:	2ba000ef          	jal	310 <exit>

000000000000005a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  5a:	1141                	addi	sp,sp,-16
  5c:	e406                	sd	ra,8(sp)
  5e:	e022                	sd	s0,0(sp)
  60:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  62:	f9fff0ef          	jal	0 <main>
  exit(r);
  66:	2aa000ef          	jal	310 <exit>

000000000000006a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  6a:	1141                	addi	sp,sp,-16
  6c:	e406                	sd	ra,8(sp)
  6e:	e022                	sd	s0,0(sp)
  70:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  72:	87aa                	mv	a5,a0
  74:	0585                	addi	a1,a1,1
  76:	0785                	addi	a5,a5,1
  78:	fff5c703          	lbu	a4,-1(a1)
  7c:	fee78fa3          	sb	a4,-1(a5)
  80:	fb75                	bnez	a4,74 <strcpy+0xa>
    ;
  return os;
}
  82:	60a2                	ld	ra,8(sp)
  84:	6402                	ld	s0,0(sp)
  86:	0141                	addi	sp,sp,16
  88:	8082                	ret

000000000000008a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8a:	1141                	addi	sp,sp,-16
  8c:	e406                	sd	ra,8(sp)
  8e:	e022                	sd	s0,0(sp)
  90:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  92:	00054783          	lbu	a5,0(a0)
  96:	cb91                	beqz	a5,aa <strcmp+0x20>
  98:	0005c703          	lbu	a4,0(a1)
  9c:	00f71763          	bne	a4,a5,aa <strcmp+0x20>
    p++, q++;
  a0:	0505                	addi	a0,a0,1
  a2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  a4:	00054783          	lbu	a5,0(a0)
  a8:	fbe5                	bnez	a5,98 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  aa:	0005c503          	lbu	a0,0(a1)
}
  ae:	40a7853b          	subw	a0,a5,a0
  b2:	60a2                	ld	ra,8(sp)
  b4:	6402                	ld	s0,0(sp)
  b6:	0141                	addi	sp,sp,16
  b8:	8082                	ret

00000000000000ba <strlen>:

uint
strlen(const char *s)
{
  ba:	1141                	addi	sp,sp,-16
  bc:	e406                	sd	ra,8(sp)
  be:	e022                	sd	s0,0(sp)
  c0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  c2:	00054783          	lbu	a5,0(a0)
  c6:	cf91                	beqz	a5,e2 <strlen+0x28>
  c8:	00150793          	addi	a5,a0,1
  cc:	86be                	mv	a3,a5
  ce:	0785                	addi	a5,a5,1
  d0:	fff7c703          	lbu	a4,-1(a5)
  d4:	ff65                	bnez	a4,cc <strlen+0x12>
  d6:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  da:	60a2                	ld	ra,8(sp)
  dc:	6402                	ld	s0,0(sp)
  de:	0141                	addi	sp,sp,16
  e0:	8082                	ret
  for(n = 0; s[n]; n++)
  e2:	4501                	li	a0,0
  e4:	bfdd                	j	da <strlen+0x20>

00000000000000e6 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e6:	1141                	addi	sp,sp,-16
  e8:	e406                	sd	ra,8(sp)
  ea:	e022                	sd	s0,0(sp)
  ec:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  ee:	ca19                	beqz	a2,104 <memset+0x1e>
  f0:	87aa                	mv	a5,a0
  f2:	1602                	slli	a2,a2,0x20
  f4:	9201                	srli	a2,a2,0x20
  f6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  fa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  fe:	0785                	addi	a5,a5,1
 100:	fee79de3          	bne	a5,a4,fa <memset+0x14>
  }
  return dst;
}
 104:	60a2                	ld	ra,8(sp)
 106:	6402                	ld	s0,0(sp)
 108:	0141                	addi	sp,sp,16
 10a:	8082                	ret

000000000000010c <strchr>:

char*
strchr(const char *s, char c)
{
 10c:	1141                	addi	sp,sp,-16
 10e:	e406                	sd	ra,8(sp)
 110:	e022                	sd	s0,0(sp)
 112:	0800                	addi	s0,sp,16
  for(; *s; s++)
 114:	00054783          	lbu	a5,0(a0)
 118:	c799                	beqz	a5,126 <strchr+0x1a>
    if(*s == c)
 11a:	00f58763          	beq	a1,a5,128 <strchr+0x1c>
  for(; *s; s++)
 11e:	0505                	addi	a0,a0,1
 120:	00054783          	lbu	a5,0(a0)
 124:	fbfd                	bnez	a5,11a <strchr+0xe>
      return (char*)s;
  return 0;
 126:	4501                	li	a0,0
}
 128:	60a2                	ld	ra,8(sp)
 12a:	6402                	ld	s0,0(sp)
 12c:	0141                	addi	sp,sp,16
 12e:	8082                	ret

0000000000000130 <gets>:

char*
gets(char *buf, int max)
{
 130:	711d                	addi	sp,sp,-96
 132:	ec86                	sd	ra,88(sp)
 134:	e8a2                	sd	s0,80(sp)
 136:	e4a6                	sd	s1,72(sp)
 138:	e0ca                	sd	s2,64(sp)
 13a:	fc4e                	sd	s3,56(sp)
 13c:	f852                	sd	s4,48(sp)
 13e:	f456                	sd	s5,40(sp)
 140:	f05a                	sd	s6,32(sp)
 142:	ec5e                	sd	s7,24(sp)
 144:	e862                	sd	s8,16(sp)
 146:	1080                	addi	s0,sp,96
 148:	8baa                	mv	s7,a0
 14a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 14c:	892a                	mv	s2,a0
 14e:	4481                	li	s1,0
    cc = read(0, &c, 1);
 150:	faf40b13          	addi	s6,s0,-81
 154:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 156:	8c26                	mv	s8,s1
 158:	0014899b          	addiw	s3,s1,1
 15c:	84ce                	mv	s1,s3
 15e:	0349d863          	bge	s3,s4,18e <gets+0x5e>
    cc = read(0, &c, 1);
 162:	8656                	mv	a2,s5
 164:	85da                	mv	a1,s6
 166:	4501                	li	a0,0
 168:	1c0000ef          	jal	328 <read>
    if(cc < 1)
 16c:	02a05163          	blez	a0,18e <gets+0x5e>
      break;
    buf[i++] = c;
 170:	faf44783          	lbu	a5,-81(s0)
 174:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 178:	0905                	addi	s2,s2,1
 17a:	ff678713          	addi	a4,a5,-10
 17e:	00173713          	seqz	a4,a4
 182:	17cd                	addi	a5,a5,-13
 184:	0017b793          	seqz	a5,a5
 188:	8fd9                	or	a5,a5,a4
 18a:	d7f1                	beqz	a5,156 <gets+0x26>
    buf[i++] = c;
 18c:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 18e:	9c5e                	add	s8,s8,s7
 190:	000c0023          	sb	zero,0(s8)
  return buf;
}
 194:	855e                	mv	a0,s7
 196:	60e6                	ld	ra,88(sp)
 198:	6446                	ld	s0,80(sp)
 19a:	64a6                	ld	s1,72(sp)
 19c:	6906                	ld	s2,64(sp)
 19e:	79e2                	ld	s3,56(sp)
 1a0:	7a42                	ld	s4,48(sp)
 1a2:	7aa2                	ld	s5,40(sp)
 1a4:	7b02                	ld	s6,32(sp)
 1a6:	6be2                	ld	s7,24(sp)
 1a8:	6c42                	ld	s8,16(sp)
 1aa:	6125                	addi	sp,sp,96
 1ac:	8082                	ret

00000000000001ae <stat>:

int
stat(const char *n, struct stat *st)
{
 1ae:	1101                	addi	sp,sp,-32
 1b0:	ec06                	sd	ra,24(sp)
 1b2:	e822                	sd	s0,16(sp)
 1b4:	e04a                	sd	s2,0(sp)
 1b6:	1000                	addi	s0,sp,32
 1b8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ba:	4581                	li	a1,0
 1bc:	194000ef          	jal	350 <open>
  if(fd < 0)
 1c0:	02054263          	bltz	a0,1e4 <stat+0x36>
 1c4:	e426                	sd	s1,8(sp)
 1c6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1c8:	85ca                	mv	a1,s2
 1ca:	19e000ef          	jal	368 <fstat>
 1ce:	892a                	mv	s2,a0
  close(fd);
 1d0:	8526                	mv	a0,s1
 1d2:	166000ef          	jal	338 <close>
  return r;
 1d6:	64a2                	ld	s1,8(sp)
}
 1d8:	854a                	mv	a0,s2
 1da:	60e2                	ld	ra,24(sp)
 1dc:	6442                	ld	s0,16(sp)
 1de:	6902                	ld	s2,0(sp)
 1e0:	6105                	addi	sp,sp,32
 1e2:	8082                	ret
    return -1;
 1e4:	57fd                	li	a5,-1
 1e6:	893e                	mv	s2,a5
 1e8:	bfc5                	j	1d8 <stat+0x2a>

00000000000001ea <atoi>:

int
atoi(const char *s)
{
 1ea:	1141                	addi	sp,sp,-16
 1ec:	e406                	sd	ra,8(sp)
 1ee:	e022                	sd	s0,0(sp)
 1f0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f2:	00054683          	lbu	a3,0(a0)
 1f6:	fd06879b          	addiw	a5,a3,-48
 1fa:	0ff7f793          	zext.b	a5,a5
 1fe:	4625                	li	a2,9
 200:	02f66963          	bltu	a2,a5,232 <atoi+0x48>
 204:	872a                	mv	a4,a0
  n = 0;
 206:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 208:	0705                	addi	a4,a4,1
 20a:	0025179b          	slliw	a5,a0,0x2
 20e:	9fa9                	addw	a5,a5,a0
 210:	0017979b          	slliw	a5,a5,0x1
 214:	9fb5                	addw	a5,a5,a3
 216:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 21a:	00074683          	lbu	a3,0(a4)
 21e:	fd06879b          	addiw	a5,a3,-48
 222:	0ff7f793          	zext.b	a5,a5
 226:	fef671e3          	bgeu	a2,a5,208 <atoi+0x1e>
  return n;
}
 22a:	60a2                	ld	ra,8(sp)
 22c:	6402                	ld	s0,0(sp)
 22e:	0141                	addi	sp,sp,16
 230:	8082                	ret
  n = 0;
 232:	4501                	li	a0,0
 234:	bfdd                	j	22a <atoi+0x40>

0000000000000236 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 236:	1141                	addi	sp,sp,-16
 238:	e406                	sd	ra,8(sp)
 23a:	e022                	sd	s0,0(sp)
 23c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 23e:	02b57563          	bgeu	a0,a1,268 <memmove+0x32>
    while(n-- > 0)
 242:	00c05f63          	blez	a2,260 <memmove+0x2a>
 246:	1602                	slli	a2,a2,0x20
 248:	9201                	srli	a2,a2,0x20
 24a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 24e:	872a                	mv	a4,a0
      *dst++ = *src++;
 250:	0585                	addi	a1,a1,1
 252:	0705                	addi	a4,a4,1
 254:	fff5c683          	lbu	a3,-1(a1)
 258:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 25c:	fee79ae3          	bne	a5,a4,250 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 260:	60a2                	ld	ra,8(sp)
 262:	6402                	ld	s0,0(sp)
 264:	0141                	addi	sp,sp,16
 266:	8082                	ret
    while(n-- > 0)
 268:	fec05ce3          	blez	a2,260 <memmove+0x2a>
    dst += n;
 26c:	00c50733          	add	a4,a0,a2
    src += n;
 270:	95b2                	add	a1,a1,a2
 272:	fff6079b          	addiw	a5,a2,-1
 276:	1782                	slli	a5,a5,0x20
 278:	9381                	srli	a5,a5,0x20
 27a:	fff7c793          	not	a5,a5
 27e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 280:	15fd                	addi	a1,a1,-1
 282:	177d                	addi	a4,a4,-1
 284:	0005c683          	lbu	a3,0(a1)
 288:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 28c:	fef71ae3          	bne	a4,a5,280 <memmove+0x4a>
 290:	bfc1                	j	260 <memmove+0x2a>

0000000000000292 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 292:	1141                	addi	sp,sp,-16
 294:	e406                	sd	ra,8(sp)
 296:	e022                	sd	s0,0(sp)
 298:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 29a:	ce19                	beqz	a2,2b8 <memcmp+0x26>
 29c:	1602                	slli	a2,a2,0x20
 29e:	9201                	srli	a2,a2,0x20
 2a0:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 2a4:	00054783          	lbu	a5,0(a0)
 2a8:	0005c703          	lbu	a4,0(a1)
 2ac:	00e79b63          	bne	a5,a4,2c2 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 2b0:	0505                	addi	a0,a0,1
    p2++;
 2b2:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2b4:	fed518e3          	bne	a0,a3,2a4 <memcmp+0x12>
  }
  return 0;
 2b8:	4501                	li	a0,0
}
 2ba:	60a2                	ld	ra,8(sp)
 2bc:	6402                	ld	s0,0(sp)
 2be:	0141                	addi	sp,sp,16
 2c0:	8082                	ret
      return *p1 - *p2;
 2c2:	40e7853b          	subw	a0,a5,a4
 2c6:	bfd5                	j	2ba <memcmp+0x28>

00000000000002c8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2c8:	1141                	addi	sp,sp,-16
 2ca:	e406                	sd	ra,8(sp)
 2cc:	e022                	sd	s0,0(sp)
 2ce:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2d0:	f67ff0ef          	jal	236 <memmove>
}
 2d4:	60a2                	ld	ra,8(sp)
 2d6:	6402                	ld	s0,0(sp)
 2d8:	0141                	addi	sp,sp,16
 2da:	8082                	ret

00000000000002dc <sbrk>:

char *
sbrk(int n) {
 2dc:	1141                	addi	sp,sp,-16
 2de:	e406                	sd	ra,8(sp)
 2e0:	e022                	sd	s0,0(sp)
 2e2:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2e4:	4585                	li	a1,1
 2e6:	0b2000ef          	jal	398 <sys_sbrk>
}
 2ea:	60a2                	ld	ra,8(sp)
 2ec:	6402                	ld	s0,0(sp)
 2ee:	0141                	addi	sp,sp,16
 2f0:	8082                	ret

00000000000002f2 <sbrklazy>:

char *
sbrklazy(int n) {
 2f2:	1141                	addi	sp,sp,-16
 2f4:	e406                	sd	ra,8(sp)
 2f6:	e022                	sd	s0,0(sp)
 2f8:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 2fa:	4589                	li	a1,2
 2fc:	09c000ef          	jal	398 <sys_sbrk>
}
 300:	60a2                	ld	ra,8(sp)
 302:	6402                	ld	s0,0(sp)
 304:	0141                	addi	sp,sp,16
 306:	8082                	ret

0000000000000308 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 308:	4885                	li	a7,1
 ecall
 30a:	00000073          	ecall
 ret
 30e:	8082                	ret

0000000000000310 <exit>:
.global exit
exit:
 li a7, SYS_exit
 310:	4889                	li	a7,2
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <wait>:
.global wait
wait:
 li a7, SYS_wait
 318:	488d                	li	a7,3
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 320:	4891                	li	a7,4
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <read>:
.global read
read:
 li a7, SYS_read
 328:	4895                	li	a7,5
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <write>:
.global write
write:
 li a7, SYS_write
 330:	48c1                	li	a7,16
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <close>:
.global close
close:
 li a7, SYS_close
 338:	48d5                	li	a7,21
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <kill>:
.global kill
kill:
 li a7, SYS_kill
 340:	4899                	li	a7,6
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <exec>:
.global exec
exec:
 li a7, SYS_exec
 348:	489d                	li	a7,7
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <open>:
.global open
open:
 li a7, SYS_open
 350:	48bd                	li	a7,15
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 358:	48c5                	li	a7,17
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 360:	48c9                	li	a7,18
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 368:	48a1                	li	a7,8
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <link>:
.global link
link:
 li a7, SYS_link
 370:	48cd                	li	a7,19
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 378:	48d1                	li	a7,20
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 380:	48a5                	li	a7,9
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <dup>:
.global dup
dup:
 li a7, SYS_dup
 388:	48a9                	li	a7,10
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 390:	48ad                	li	a7,11
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 398:	48b1                	li	a7,12
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <pause>:
.global pause
pause:
 li a7, SYS_pause
 3a0:	48b5                	li	a7,13
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3a8:	48b9                	li	a7,14
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <bind>:
.global bind
bind:
 li a7, SYS_bind
 3b0:	48f5                	li	a7,29
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 3b8:	48f9                	li	a7,30
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <send>:
.global send
send:
 li a7, SYS_send
 3c0:	48fd                	li	a7,31
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <recv>:
.global recv
recv:
 li a7, SYS_recv
 3c8:	02000893          	li	a7,32
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 3d2:	02100893          	li	a7,33
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 3dc:	02200893          	li	a7,34
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <rwlktest>:
.global rwlktest
rwlktest:
 li a7, SYS_rwlktest
 3e6:	02300893          	li	a7,35
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <cpupin>:
.global cpupin
cpupin:
 li a7, SYS_cpupin
 3f0:	02400893          	li	a7,36
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3fa:	1101                	addi	sp,sp,-32
 3fc:	ec06                	sd	ra,24(sp)
 3fe:	e822                	sd	s0,16(sp)
 400:	1000                	addi	s0,sp,32
 402:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 406:	4605                	li	a2,1
 408:	fef40593          	addi	a1,s0,-17
 40c:	f25ff0ef          	jal	330 <write>
}
 410:	60e2                	ld	ra,24(sp)
 412:	6442                	ld	s0,16(sp)
 414:	6105                	addi	sp,sp,32
 416:	8082                	ret

0000000000000418 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 418:	715d                	addi	sp,sp,-80
 41a:	e486                	sd	ra,72(sp)
 41c:	e0a2                	sd	s0,64(sp)
 41e:	f84a                	sd	s2,48(sp)
 420:	f44e                	sd	s3,40(sp)
 422:	0880                	addi	s0,sp,80
 424:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 426:	00d036b3          	snez	a3,a3
 42a:	03f5d793          	srli	a5,a1,0x3f
 42e:	8efd                	and	a3,a3,a5
  neg = 0;
 430:	4301                	li	t1,0
  if(sgn && xx < 0){
 432:	c681                	beqz	a3,43a <printint+0x22>
    neg = 1;
    x = -xx;
 434:	40b005b3          	neg	a1,a1
    neg = 1;
 438:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 43a:	fb840993          	addi	s3,s0,-72
  neg = 0;
 43e:	86ce                	mv	a3,s3
  i = 0;
 440:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 442:	00000817          	auipc	a6,0x0
 446:	5de80813          	addi	a6,a6,1502 # a20 <digits>
 44a:	88ba                	mv	a7,a4
 44c:	0017051b          	addiw	a0,a4,1
 450:	872a                	mv	a4,a0
 452:	02c5f7b3          	remu	a5,a1,a2
 456:	97c2                	add	a5,a5,a6
 458:	0007c783          	lbu	a5,0(a5)
 45c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 460:	87ae                	mv	a5,a1
 462:	02c5d5b3          	divu	a1,a1,a2
 466:	0685                	addi	a3,a3,1
 468:	fec7f1e3          	bgeu	a5,a2,44a <printint+0x32>
  if(neg)
 46c:	00030b63          	beqz	t1,482 <printint+0x6a>
    buf[i++] = '-';
 470:	fd040793          	addi	a5,s0,-48
 474:	953e                	add	a0,a0,a5
 476:	02d00793          	li	a5,45
 47a:	fef50423          	sb	a5,-24(a0)
 47e:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 482:	02e05563          	blez	a4,4ac <printint+0x94>
 486:	fc26                	sd	s1,56(sp)
 488:	377d                	addiw	a4,a4,-1
 48a:	00e984b3          	add	s1,s3,a4
 48e:	19fd                	addi	s3,s3,-1
 490:	99ba                	add	s3,s3,a4
 492:	1702                	slli	a4,a4,0x20
 494:	9301                	srli	a4,a4,0x20
 496:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 49a:	0004c583          	lbu	a1,0(s1)
 49e:	854a                	mv	a0,s2
 4a0:	f5bff0ef          	jal	3fa <putc>
  while(--i >= 0)
 4a4:	14fd                	addi	s1,s1,-1
 4a6:	ff349ae3          	bne	s1,s3,49a <printint+0x82>
 4aa:	74e2                	ld	s1,56(sp)
}
 4ac:	60a6                	ld	ra,72(sp)
 4ae:	6406                	ld	s0,64(sp)
 4b0:	7942                	ld	s2,48(sp)
 4b2:	79a2                	ld	s3,40(sp)
 4b4:	6161                	addi	sp,sp,80
 4b6:	8082                	ret

00000000000004b8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4b8:	711d                	addi	sp,sp,-96
 4ba:	ec86                	sd	ra,88(sp)
 4bc:	e8a2                	sd	s0,80(sp)
 4be:	e4a6                	sd	s1,72(sp)
 4c0:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4c2:	0005c483          	lbu	s1,0(a1)
 4c6:	2a048063          	beqz	s1,766 <vprintf+0x2ae>
 4ca:	e0ca                	sd	s2,64(sp)
 4cc:	fc4e                	sd	s3,56(sp)
 4ce:	f852                	sd	s4,48(sp)
 4d0:	f456                	sd	s5,40(sp)
 4d2:	f05a                	sd	s6,32(sp)
 4d4:	ec5e                	sd	s7,24(sp)
 4d6:	e862                	sd	s8,16(sp)
 4d8:	8b2a                	mv	s6,a0
 4da:	8a2e                	mv	s4,a1
 4dc:	8bb2                	mv	s7,a2
  state = 0;
 4de:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 4e0:	4901                	li	s2,0
 4e2:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 4e4:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4e8:	06400c13          	li	s8,100
 4ec:	a00d                	j	50e <vprintf+0x56>
        putc(fd, c0);
 4ee:	85a6                	mv	a1,s1
 4f0:	855a                	mv	a0,s6
 4f2:	f09ff0ef          	jal	3fa <putc>
 4f6:	a019                	j	4fc <vprintf+0x44>
    } else if(state == '%'){
 4f8:	03598363          	beq	s3,s5,51e <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 4fc:	0019079b          	addiw	a5,s2,1
 500:	893e                	mv	s2,a5
 502:	873e                	mv	a4,a5
 504:	97d2                	add	a5,a5,s4
 506:	0007c483          	lbu	s1,0(a5)
 50a:	24048763          	beqz	s1,758 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 50e:	0004879b          	sext.w	a5,s1
    if(state == 0){
 512:	fe0993e3          	bnez	s3,4f8 <vprintf+0x40>
      if(c0 == '%'){
 516:	fd579ce3          	bne	a5,s5,4ee <vprintf+0x36>
        state = '%';
 51a:	89be                	mv	s3,a5
 51c:	b7c5                	j	4fc <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 51e:	00ea06b3          	add	a3,s4,a4
 522:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 526:	24060563          	beqz	a2,770 <vprintf+0x2b8>
      if(c0 == 'd'){
 52a:	0b878763          	beq	a5,s8,5d8 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 52e:	f9478693          	addi	a3,a5,-108
 532:	0016b693          	seqz	a3,a3
 536:	f9c60593          	addi	a1,a2,-100
 53a:	0015b593          	seqz	a1,a1
 53e:	8df5                	and	a1,a1,a3
 540:	e9c5                	bnez	a1,5f0 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 542:	9752                	add	a4,a4,s4
 544:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 548:	f9460713          	addi	a4,a2,-108
 54c:	00173713          	seqz	a4,a4
 550:	8f75                	and	a4,a4,a3
 552:	f9c50593          	addi	a1,a0,-100
 556:	0015b593          	seqz	a1,a1
 55a:	8df9                	and	a1,a1,a4
 55c:	e5dd                	bnez	a1,60a <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 55e:	07500593          	li	a1,117
 562:	0cb78163          	beq	a5,a1,624 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 566:	f8b60593          	addi	a1,a2,-117
 56a:	0015b593          	seqz	a1,a1
 56e:	8df5                	and	a1,a1,a3
 570:	e5f1                	bnez	a1,63c <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 572:	f8b50593          	addi	a1,a0,-117
 576:	0015b593          	seqz	a1,a1
 57a:	8df9                	and	a1,a1,a4
 57c:	ede9                	bnez	a1,656 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 57e:	07800593          	li	a1,120
 582:	0eb78763          	beq	a5,a1,670 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 586:	f8860613          	addi	a2,a2,-120
 58a:	00163613          	seqz	a2,a2
 58e:	8ef1                	and	a3,a3,a2
 590:	0e069c63          	bnez	a3,688 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 594:	f8850513          	addi	a0,a0,-120
 598:	00153513          	seqz	a0,a0
 59c:	8f69                	and	a4,a4,a0
 59e:	10071263          	bnez	a4,6a2 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5a2:	07000713          	li	a4,112
 5a6:	10e78a63          	beq	a5,a4,6ba <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5aa:	06300713          	li	a4,99
 5ae:	14e78a63          	beq	a5,a4,702 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5b2:	07300713          	li	a4,115
 5b6:	16e78063          	beq	a5,a4,716 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5ba:	02500713          	li	a4,37
 5be:	18e78863          	beq	a5,a4,74e <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5c2:	02500593          	li	a1,37
 5c6:	855a                	mv	a0,s6
 5c8:	e33ff0ef          	jal	3fa <putc>
        putc(fd, c0);
 5cc:	85a6                	mv	a1,s1
 5ce:	855a                	mv	a0,s6
 5d0:	e2bff0ef          	jal	3fa <putc>
      }

      state = 0;
 5d4:	4981                	li	s3,0
 5d6:	b71d                	j	4fc <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 5d8:	008b8493          	addi	s1,s7,8
 5dc:	4685                	li	a3,1
 5de:	4629                	li	a2,10
 5e0:	000ba583          	lw	a1,0(s7)
 5e4:	855a                	mv	a0,s6
 5e6:	e33ff0ef          	jal	418 <printint>
 5ea:	8ba6                	mv	s7,s1
      state = 0;
 5ec:	4981                	li	s3,0
 5ee:	b739                	j	4fc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5f0:	008b8493          	addi	s1,s7,8
 5f4:	4685                	li	a3,1
 5f6:	4629                	li	a2,10
 5f8:	000bb583          	ld	a1,0(s7)
 5fc:	855a                	mv	a0,s6
 5fe:	e1bff0ef          	jal	418 <printint>
        i += 1;
 602:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 604:	8ba6                	mv	s7,s1
      state = 0;
 606:	4981                	li	s3,0
 608:	bdd5                	j	4fc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 60a:	008b8493          	addi	s1,s7,8
 60e:	4685                	li	a3,1
 610:	4629                	li	a2,10
 612:	000bb583          	ld	a1,0(s7)
 616:	855a                	mv	a0,s6
 618:	e01ff0ef          	jal	418 <printint>
        i += 2;
 61c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 61e:	8ba6                	mv	s7,s1
      state = 0;
 620:	4981                	li	s3,0
        i += 2;
 622:	bde9                	j	4fc <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 624:	008b8493          	addi	s1,s7,8
 628:	4681                	li	a3,0
 62a:	4629                	li	a2,10
 62c:	000be583          	lwu	a1,0(s7)
 630:	855a                	mv	a0,s6
 632:	de7ff0ef          	jal	418 <printint>
 636:	8ba6                	mv	s7,s1
      state = 0;
 638:	4981                	li	s3,0
 63a:	b5c9                	j	4fc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 63c:	008b8493          	addi	s1,s7,8
 640:	4681                	li	a3,0
 642:	4629                	li	a2,10
 644:	000bb583          	ld	a1,0(s7)
 648:	855a                	mv	a0,s6
 64a:	dcfff0ef          	jal	418 <printint>
        i += 1;
 64e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 650:	8ba6                	mv	s7,s1
      state = 0;
 652:	4981                	li	s3,0
 654:	b565                	j	4fc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 656:	008b8493          	addi	s1,s7,8
 65a:	4681                	li	a3,0
 65c:	4629                	li	a2,10
 65e:	000bb583          	ld	a1,0(s7)
 662:	855a                	mv	a0,s6
 664:	db5ff0ef          	jal	418 <printint>
        i += 2;
 668:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 66a:	8ba6                	mv	s7,s1
      state = 0;
 66c:	4981                	li	s3,0
        i += 2;
 66e:	b579                	j	4fc <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 670:	008b8493          	addi	s1,s7,8
 674:	4681                	li	a3,0
 676:	4641                	li	a2,16
 678:	000be583          	lwu	a1,0(s7)
 67c:	855a                	mv	a0,s6
 67e:	d9bff0ef          	jal	418 <printint>
 682:	8ba6                	mv	s7,s1
      state = 0;
 684:	4981                	li	s3,0
 686:	bd9d                	j	4fc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 688:	008b8493          	addi	s1,s7,8
 68c:	4681                	li	a3,0
 68e:	4641                	li	a2,16
 690:	000bb583          	ld	a1,0(s7)
 694:	855a                	mv	a0,s6
 696:	d83ff0ef          	jal	418 <printint>
        i += 1;
 69a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 69c:	8ba6                	mv	s7,s1
      state = 0;
 69e:	4981                	li	s3,0
 6a0:	bdb1                	j	4fc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6a2:	008b8493          	addi	s1,s7,8
 6a6:	4641                	li	a2,16
 6a8:	000bb583          	ld	a1,0(s7)
 6ac:	855a                	mv	a0,s6
 6ae:	d6bff0ef          	jal	418 <printint>
        i += 2;
 6b2:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6b4:	8ba6                	mv	s7,s1
      state = 0;
 6b6:	4981                	li	s3,0
        i += 2;
 6b8:	b591                	j	4fc <vprintf+0x44>
 6ba:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 6bc:	008b8793          	addi	a5,s7,8
 6c0:	8cbe                	mv	s9,a5
 6c2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6c6:	03000593          	li	a1,48
 6ca:	855a                	mv	a0,s6
 6cc:	d2fff0ef          	jal	3fa <putc>
  putc(fd, 'x');
 6d0:	07800593          	li	a1,120
 6d4:	855a                	mv	a0,s6
 6d6:	d25ff0ef          	jal	3fa <putc>
 6da:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6dc:	00000b97          	auipc	s7,0x0
 6e0:	344b8b93          	addi	s7,s7,836 # a20 <digits>
 6e4:	03c9d793          	srli	a5,s3,0x3c
 6e8:	97de                	add	a5,a5,s7
 6ea:	0007c583          	lbu	a1,0(a5)
 6ee:	855a                	mv	a0,s6
 6f0:	d0bff0ef          	jal	3fa <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6f4:	0992                	slli	s3,s3,0x4
 6f6:	34fd                	addiw	s1,s1,-1
 6f8:	f4f5                	bnez	s1,6e4 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 6fa:	8be6                	mv	s7,s9
      state = 0;
 6fc:	4981                	li	s3,0
 6fe:	6ca2                	ld	s9,8(sp)
 700:	bbf5                	j	4fc <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 702:	008b8493          	addi	s1,s7,8
 706:	000bc583          	lbu	a1,0(s7)
 70a:	855a                	mv	a0,s6
 70c:	cefff0ef          	jal	3fa <putc>
 710:	8ba6                	mv	s7,s1
      state = 0;
 712:	4981                	li	s3,0
 714:	b3e5                	j	4fc <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 716:	008b8993          	addi	s3,s7,8
 71a:	000bb483          	ld	s1,0(s7)
 71e:	cc91                	beqz	s1,73a <vprintf+0x282>
        for(; *s; s++)
 720:	0004c583          	lbu	a1,0(s1)
 724:	c195                	beqz	a1,748 <vprintf+0x290>
          putc(fd, *s);
 726:	855a                	mv	a0,s6
 728:	cd3ff0ef          	jal	3fa <putc>
        for(; *s; s++)
 72c:	0485                	addi	s1,s1,1
 72e:	0004c583          	lbu	a1,0(s1)
 732:	f9f5                	bnez	a1,726 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 734:	8bce                	mv	s7,s3
      state = 0;
 736:	4981                	li	s3,0
 738:	b3d1                	j	4fc <vprintf+0x44>
          s = "(null)";
 73a:	00000497          	auipc	s1,0x0
 73e:	2b648493          	addi	s1,s1,694 # 9f0 <statistics+0x92>
        for(; *s; s++)
 742:	02800593          	li	a1,40
 746:	b7c5                	j	726 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 748:	8bce                	mv	s7,s3
      state = 0;
 74a:	4981                	li	s3,0
 74c:	bb45                	j	4fc <vprintf+0x44>
        putc(fd, '%');
 74e:	85be                	mv	a1,a5
 750:	855a                	mv	a0,s6
 752:	ca9ff0ef          	jal	3fa <putc>
 756:	bdbd                	j	5d4 <vprintf+0x11c>
 758:	6906                	ld	s2,64(sp)
 75a:	79e2                	ld	s3,56(sp)
 75c:	7a42                	ld	s4,48(sp)
 75e:	7aa2                	ld	s5,40(sp)
 760:	7b02                	ld	s6,32(sp)
 762:	6be2                	ld	s7,24(sp)
 764:	6c42                	ld	s8,16(sp)
    }
  }
}
 766:	60e6                	ld	ra,88(sp)
 768:	6446                	ld	s0,80(sp)
 76a:	64a6                	ld	s1,72(sp)
 76c:	6125                	addi	sp,sp,96
 76e:	8082                	ret
      if(c0 == 'd'){
 770:	06400713          	li	a4,100
 774:	e6e782e3          	beq	a5,a4,5d8 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 778:	f9478693          	addi	a3,a5,-108
 77c:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 780:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 782:	4701                	li	a4,0
 784:	bbe9                	j	55e <vprintf+0xa6>

0000000000000786 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 786:	715d                	addi	sp,sp,-80
 788:	ec06                	sd	ra,24(sp)
 78a:	e822                	sd	s0,16(sp)
 78c:	1000                	addi	s0,sp,32
 78e:	e010                	sd	a2,0(s0)
 790:	e414                	sd	a3,8(s0)
 792:	e818                	sd	a4,16(s0)
 794:	ec1c                	sd	a5,24(s0)
 796:	03043023          	sd	a6,32(s0)
 79a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 79e:	8622                	mv	a2,s0
 7a0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7a4:	d15ff0ef          	jal	4b8 <vprintf>
}
 7a8:	60e2                	ld	ra,24(sp)
 7aa:	6442                	ld	s0,16(sp)
 7ac:	6161                	addi	sp,sp,80
 7ae:	8082                	ret

00000000000007b0 <printf>:

void
printf(const char *fmt, ...)
{
 7b0:	711d                	addi	sp,sp,-96
 7b2:	ec06                	sd	ra,24(sp)
 7b4:	e822                	sd	s0,16(sp)
 7b6:	1000                	addi	s0,sp,32
 7b8:	e40c                	sd	a1,8(s0)
 7ba:	e810                	sd	a2,16(s0)
 7bc:	ec14                	sd	a3,24(s0)
 7be:	f018                	sd	a4,32(s0)
 7c0:	f41c                	sd	a5,40(s0)
 7c2:	03043823          	sd	a6,48(s0)
 7c6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7ca:	00840613          	addi	a2,s0,8
 7ce:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7d2:	85aa                	mv	a1,a0
 7d4:	4505                	li	a0,1
 7d6:	ce3ff0ef          	jal	4b8 <vprintf>
}
 7da:	60e2                	ld	ra,24(sp)
 7dc:	6442                	ld	s0,16(sp)
 7de:	6125                	addi	sp,sp,96
 7e0:	8082                	ret

00000000000007e2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7e2:	1141                	addi	sp,sp,-16
 7e4:	e406                	sd	ra,8(sp)
 7e6:	e022                	sd	s0,0(sp)
 7e8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ea:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ee:	00001797          	auipc	a5,0x1
 7f2:	8127b783          	ld	a5,-2030(a5) # 1000 <freep>
 7f6:	a095                	j	85a <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7f8:	ff852583          	lw	a1,-8(a0)
 7fc:	6390                	ld	a2,0(a5)
 7fe:	02059813          	slli	a6,a1,0x20
 802:	01c85693          	srli	a3,a6,0x1c
 806:	96ba                	add	a3,a3,a4
 808:	02d60563          	beq	a2,a3,832 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 80c:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 810:	4790                	lw	a2,8(a5)
 812:	02061593          	slli	a1,a2,0x20
 816:	01c5d693          	srli	a3,a1,0x1c
 81a:	96be                	add	a3,a3,a5
 81c:	02d70263          	beq	a4,a3,840 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 820:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 822:	00000717          	auipc	a4,0x0
 826:	7cf73f23          	sd	a5,2014(a4) # 1000 <freep>
}
 82a:	60a2                	ld	ra,8(sp)
 82c:	6402                	ld	s0,0(sp)
 82e:	0141                	addi	sp,sp,16
 830:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 832:	4614                	lw	a3,8(a2)
 834:	9ead                	addw	a3,a3,a1
 836:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 83a:	6394                	ld	a3,0(a5)
 83c:	6290                	ld	a2,0(a3)
 83e:	b7f9                	j	80c <free+0x2a>
    p->s.size += bp->s.size;
 840:	ff852703          	lw	a4,-8(a0)
 844:	9f31                	addw	a4,a4,a2
 846:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 848:	ff053703          	ld	a4,-16(a0)
 84c:	bfd1                	j	820 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 84e:	6394                	ld	a3,0(a5)
 850:	00d7e463          	bltu	a5,a3,858 <free+0x76>
 854:	fad762e3          	bltu	a4,a3,7f8 <free+0x16>
 858:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 85a:	fee7fae3          	bgeu	a5,a4,84e <free+0x6c>
 85e:	6394                	ld	a3,0(a5)
 860:	f8d76ce3          	bltu	a4,a3,7f8 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 864:	f8d7fae3          	bgeu	a5,a3,7f8 <free+0x16>
 868:	87b6                	mv	a5,a3
 86a:	bfc5                	j	85a <free+0x78>

000000000000086c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 86c:	7139                	addi	sp,sp,-64
 86e:	fc06                	sd	ra,56(sp)
 870:	f822                	sd	s0,48(sp)
 872:	f04a                	sd	s2,32(sp)
 874:	ec4e                	sd	s3,24(sp)
 876:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 878:	02051993          	slli	s3,a0,0x20
 87c:	0209d993          	srli	s3,s3,0x20
 880:	09bd                	addi	s3,s3,15
 882:	0049d993          	srli	s3,s3,0x4
 886:	2985                	addiw	s3,s3,1
 888:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 88a:	00000517          	auipc	a0,0x0
 88e:	77653503          	ld	a0,1910(a0) # 1000 <freep>
 892:	c905                	beqz	a0,8c2 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 894:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 896:	4798                	lw	a4,8(a5)
 898:	09377663          	bgeu	a4,s3,924 <malloc+0xb8>
 89c:	f426                	sd	s1,40(sp)
 89e:	e852                	sd	s4,16(sp)
 8a0:	e456                	sd	s5,8(sp)
 8a2:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8a4:	8a4e                	mv	s4,s3
 8a6:	6705                	lui	a4,0x1
 8a8:	00e9f363          	bgeu	s3,a4,8ae <malloc+0x42>
 8ac:	6a05                	lui	s4,0x1
 8ae:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8b2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8b6:	00000497          	auipc	s1,0x0
 8ba:	74a48493          	addi	s1,s1,1866 # 1000 <freep>
  if(p == SBRK_ERROR)
 8be:	5afd                	li	s5,-1
 8c0:	a83d                	j	8fe <malloc+0x92>
 8c2:	f426                	sd	s1,40(sp)
 8c4:	e852                	sd	s4,16(sp)
 8c6:	e456                	sd	s5,8(sp)
 8c8:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8ca:	00000797          	auipc	a5,0x0
 8ce:	74678793          	addi	a5,a5,1862 # 1010 <base>
 8d2:	00000717          	auipc	a4,0x0
 8d6:	72f73723          	sd	a5,1838(a4) # 1000 <freep>
 8da:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8dc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8e0:	b7d1                	j	8a4 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8e2:	6398                	ld	a4,0(a5)
 8e4:	e118                	sd	a4,0(a0)
 8e6:	a899                	j	93c <malloc+0xd0>
  hp->s.size = nu;
 8e8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8ec:	0541                	addi	a0,a0,16
 8ee:	ef5ff0ef          	jal	7e2 <free>
  return freep;
 8f2:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8f4:	c125                	beqz	a0,954 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8f8:	4798                	lw	a4,8(a5)
 8fa:	03277163          	bgeu	a4,s2,91c <malloc+0xb0>
    if(p == freep)
 8fe:	6098                	ld	a4,0(s1)
 900:	853e                	mv	a0,a5
 902:	fef71ae3          	bne	a4,a5,8f6 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 906:	8552                	mv	a0,s4
 908:	9d5ff0ef          	jal	2dc <sbrk>
  if(p == SBRK_ERROR)
 90c:	fd551ee3          	bne	a0,s5,8e8 <malloc+0x7c>
        return 0;
 910:	4501                	li	a0,0
 912:	74a2                	ld	s1,40(sp)
 914:	6a42                	ld	s4,16(sp)
 916:	6aa2                	ld	s5,8(sp)
 918:	6b02                	ld	s6,0(sp)
 91a:	a03d                	j	948 <malloc+0xdc>
 91c:	74a2                	ld	s1,40(sp)
 91e:	6a42                	ld	s4,16(sp)
 920:	6aa2                	ld	s5,8(sp)
 922:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 924:	fae90fe3          	beq	s2,a4,8e2 <malloc+0x76>
        p->s.size -= nunits;
 928:	4137073b          	subw	a4,a4,s3
 92c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 92e:	02071693          	slli	a3,a4,0x20
 932:	01c6d713          	srli	a4,a3,0x1c
 936:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 938:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 93c:	00000717          	auipc	a4,0x0
 940:	6ca73223          	sd	a0,1732(a4) # 1000 <freep>
      return (void*)(p + 1);
 944:	01078513          	addi	a0,a5,16
  }
}
 948:	70e2                	ld	ra,56(sp)
 94a:	7442                	ld	s0,48(sp)
 94c:	7902                	ld	s2,32(sp)
 94e:	69e2                	ld	s3,24(sp)
 950:	6121                	addi	sp,sp,64
 952:	8082                	ret
 954:	74a2                	ld	s1,40(sp)
 956:	6a42                	ld	s4,16(sp)
 958:	6aa2                	ld	s5,8(sp)
 95a:	6b02                	ld	s6,0(sp)
 95c:	b7f5                	j	948 <malloc+0xdc>

000000000000095e <statistics>:
#include "kernel/fcntl.h"
#include "user/user.h"

int
statistics(void *buf, int sz)
{
 95e:	7179                	addi	sp,sp,-48
 960:	f406                	sd	ra,40(sp)
 962:	f022                	sd	s0,32(sp)
 964:	ec26                	sd	s1,24(sp)
 966:	e84a                	sd	s2,16(sp)
 968:	e44e                	sd	s3,8(sp)
 96a:	e052                	sd	s4,0(sp)
 96c:	1800                	addi	s0,sp,48
 96e:	8a2a                	mv	s4,a0
 970:	892e                	mv	s2,a1
  int fd, i, n;
  
  fd = open("statistics", O_RDONLY);
 972:	4581                	li	a1,0
 974:	00000517          	auipc	a0,0x0
 978:	08450513          	addi	a0,a0,132 # 9f8 <statistics+0x9a>
 97c:	9d5ff0ef          	jal	350 <open>
  if(fd < 0) {
 980:	02054e63          	bltz	a0,9bc <statistics+0x5e>
 984:	89aa                	mv	s3,a0
      fprintf(2, "stats: open failed\n");
      exit(1);
  }
  for (i = 0; i < sz; ) {
 986:	4481                	li	s1,0
 988:	01205e63          	blez	s2,9a4 <statistics+0x46>
    if ((n = read(fd, buf+i, sz-i)) < 0) {
 98c:	4099063b          	subw	a2,s2,s1
 990:	009a05b3          	add	a1,s4,s1
 994:	854e                	mv	a0,s3
 996:	993ff0ef          	jal	328 <read>
 99a:	00054563          	bltz	a0,9a4 <statistics+0x46>
      break;
    }
    i += n;
 99e:	9ca9                	addw	s1,s1,a0
  for (i = 0; i < sz; ) {
 9a0:	ff24c6e3          	blt	s1,s2,98c <statistics+0x2e>
  }
  close(fd);
 9a4:	854e                	mv	a0,s3
 9a6:	993ff0ef          	jal	338 <close>
  return i;
}
 9aa:	8526                	mv	a0,s1
 9ac:	70a2                	ld	ra,40(sp)
 9ae:	7402                	ld	s0,32(sp)
 9b0:	64e2                	ld	s1,24(sp)
 9b2:	6942                	ld	s2,16(sp)
 9b4:	69a2                	ld	s3,8(sp)
 9b6:	6a02                	ld	s4,0(sp)
 9b8:	6145                	addi	sp,sp,48
 9ba:	8082                	ret
      fprintf(2, "stats: open failed\n");
 9bc:	00000597          	auipc	a1,0x0
 9c0:	04c58593          	addi	a1,a1,76 # a08 <statistics+0xaa>
 9c4:	4509                	li	a0,2
 9c6:	dc1ff0ef          	jal	786 <fprintf>
      exit(1);
 9ca:	4505                	li	a0,1
 9cc:	945ff0ef          	jal	310 <exit>
