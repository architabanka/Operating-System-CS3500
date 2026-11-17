
user/_dorphan:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char buf[BUFSZ];

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
  char *s = argv[0];
   a:	6184                	ld	s1,0(a1)

  if(mkdir("dd") != 0){
   c:	00001517          	auipc	a0,0x1
  10:	a0450513          	addi	a0,a0,-1532 # a10 <statistics+0x80>
  14:	396000ef          	jal	3aa <mkdir>
  18:	c919                	beqz	a0,2e <main+0x2e>
    printf("%s: mkdir dd failed\n", s);
  1a:	85a6                	mv	a1,s1
  1c:	00001517          	auipc	a0,0x1
  20:	9fc50513          	addi	a0,a0,-1540 # a18 <statistics+0x88>
  24:	7be000ef          	jal	7e2 <printf>
    exit(1);
  28:	4505                	li	a0,1
  2a:	318000ef          	jal	342 <exit>
  }

  if(chdir("dd") != 0){
  2e:	00001517          	auipc	a0,0x1
  32:	9e250513          	addi	a0,a0,-1566 # a10 <statistics+0x80>
  36:	37c000ef          	jal	3b2 <chdir>
  3a:	c919                	beqz	a0,50 <main+0x50>
    printf("%s: chdir dd failed\n", s);
  3c:	85a6                	mv	a1,s1
  3e:	00001517          	auipc	a0,0x1
  42:	9f250513          	addi	a0,a0,-1550 # a30 <statistics+0xa0>
  46:	79c000ef          	jal	7e2 <printf>
    exit(1);
  4a:	4505                	li	a0,1
  4c:	2f6000ef          	jal	342 <exit>
  }

  if (unlink("../dd") < 0) {
  50:	00001517          	auipc	a0,0x1
  54:	9f850513          	addi	a0,a0,-1544 # a48 <statistics+0xb8>
  58:	33a000ef          	jal	392 <unlink>
  5c:	00054e63          	bltz	a0,78 <main+0x78>
    printf("%s: unlink failed\n", s);
    exit(1);
  }
  printf("wait for kill and reclaim\n");
  60:	00001517          	auipc	a0,0x1
  64:	a0850513          	addi	a0,a0,-1528 # a68 <statistics+0xd8>
  68:	77a000ef          	jal	7e2 <printf>
  // sit around until killed
  for(;;) pause(1000);
  6c:	3e800493          	li	s1,1000
  70:	8526                	mv	a0,s1
  72:	360000ef          	jal	3d2 <pause>
  76:	bfed                	j	70 <main+0x70>
    printf("%s: unlink failed\n", s);
  78:	85a6                	mv	a1,s1
  7a:	00001517          	auipc	a0,0x1
  7e:	9d650513          	addi	a0,a0,-1578 # a50 <statistics+0xc0>
  82:	760000ef          	jal	7e2 <printf>
    exit(1);
  86:	4505                	li	a0,1
  88:	2ba000ef          	jal	342 <exit>

000000000000008c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  8c:	1141                	addi	sp,sp,-16
  8e:	e406                	sd	ra,8(sp)
  90:	e022                	sd	s0,0(sp)
  92:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  94:	f6dff0ef          	jal	0 <main>
  exit(r);
  98:	2aa000ef          	jal	342 <exit>

000000000000009c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  9c:	1141                	addi	sp,sp,-16
  9e:	e406                	sd	ra,8(sp)
  a0:	e022                	sd	s0,0(sp)
  a2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a4:	87aa                	mv	a5,a0
  a6:	0585                	addi	a1,a1,1
  a8:	0785                	addi	a5,a5,1
  aa:	fff5c703          	lbu	a4,-1(a1)
  ae:	fee78fa3          	sb	a4,-1(a5)
  b2:	fb75                	bnez	a4,a6 <strcpy+0xa>
    ;
  return os;
}
  b4:	60a2                	ld	ra,8(sp)
  b6:	6402                	ld	s0,0(sp)
  b8:	0141                	addi	sp,sp,16
  ba:	8082                	ret

00000000000000bc <strcmp>:

int
strcmp(const char *p, const char *q)
{
  bc:	1141                	addi	sp,sp,-16
  be:	e406                	sd	ra,8(sp)
  c0:	e022                	sd	s0,0(sp)
  c2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  c4:	00054783          	lbu	a5,0(a0)
  c8:	cb91                	beqz	a5,dc <strcmp+0x20>
  ca:	0005c703          	lbu	a4,0(a1)
  ce:	00f71763          	bne	a4,a5,dc <strcmp+0x20>
    p++, q++;
  d2:	0505                	addi	a0,a0,1
  d4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  d6:	00054783          	lbu	a5,0(a0)
  da:	fbe5                	bnez	a5,ca <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  dc:	0005c503          	lbu	a0,0(a1)
}
  e0:	40a7853b          	subw	a0,a5,a0
  e4:	60a2                	ld	ra,8(sp)
  e6:	6402                	ld	s0,0(sp)
  e8:	0141                	addi	sp,sp,16
  ea:	8082                	ret

00000000000000ec <strlen>:

uint
strlen(const char *s)
{
  ec:	1141                	addi	sp,sp,-16
  ee:	e406                	sd	ra,8(sp)
  f0:	e022                	sd	s0,0(sp)
  f2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  f4:	00054783          	lbu	a5,0(a0)
  f8:	cf91                	beqz	a5,114 <strlen+0x28>
  fa:	00150793          	addi	a5,a0,1
  fe:	86be                	mv	a3,a5
 100:	0785                	addi	a5,a5,1
 102:	fff7c703          	lbu	a4,-1(a5)
 106:	ff65                	bnez	a4,fe <strlen+0x12>
 108:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 10c:	60a2                	ld	ra,8(sp)
 10e:	6402                	ld	s0,0(sp)
 110:	0141                	addi	sp,sp,16
 112:	8082                	ret
  for(n = 0; s[n]; n++)
 114:	4501                	li	a0,0
 116:	bfdd                	j	10c <strlen+0x20>

0000000000000118 <memset>:

void*
memset(void *dst, int c, uint n)
{
 118:	1141                	addi	sp,sp,-16
 11a:	e406                	sd	ra,8(sp)
 11c:	e022                	sd	s0,0(sp)
 11e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 120:	ca19                	beqz	a2,136 <memset+0x1e>
 122:	87aa                	mv	a5,a0
 124:	1602                	slli	a2,a2,0x20
 126:	9201                	srli	a2,a2,0x20
 128:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 12c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 130:	0785                	addi	a5,a5,1
 132:	fee79de3          	bne	a5,a4,12c <memset+0x14>
  }
  return dst;
}
 136:	60a2                	ld	ra,8(sp)
 138:	6402                	ld	s0,0(sp)
 13a:	0141                	addi	sp,sp,16
 13c:	8082                	ret

000000000000013e <strchr>:

char*
strchr(const char *s, char c)
{
 13e:	1141                	addi	sp,sp,-16
 140:	e406                	sd	ra,8(sp)
 142:	e022                	sd	s0,0(sp)
 144:	0800                	addi	s0,sp,16
  for(; *s; s++)
 146:	00054783          	lbu	a5,0(a0)
 14a:	c799                	beqz	a5,158 <strchr+0x1a>
    if(*s == c)
 14c:	00f58763          	beq	a1,a5,15a <strchr+0x1c>
  for(; *s; s++)
 150:	0505                	addi	a0,a0,1
 152:	00054783          	lbu	a5,0(a0)
 156:	fbfd                	bnez	a5,14c <strchr+0xe>
      return (char*)s;
  return 0;
 158:	4501                	li	a0,0
}
 15a:	60a2                	ld	ra,8(sp)
 15c:	6402                	ld	s0,0(sp)
 15e:	0141                	addi	sp,sp,16
 160:	8082                	ret

0000000000000162 <gets>:

char*
gets(char *buf, int max)
{
 162:	711d                	addi	sp,sp,-96
 164:	ec86                	sd	ra,88(sp)
 166:	e8a2                	sd	s0,80(sp)
 168:	e4a6                	sd	s1,72(sp)
 16a:	e0ca                	sd	s2,64(sp)
 16c:	fc4e                	sd	s3,56(sp)
 16e:	f852                	sd	s4,48(sp)
 170:	f456                	sd	s5,40(sp)
 172:	f05a                	sd	s6,32(sp)
 174:	ec5e                	sd	s7,24(sp)
 176:	e862                	sd	s8,16(sp)
 178:	1080                	addi	s0,sp,96
 17a:	8baa                	mv	s7,a0
 17c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 17e:	892a                	mv	s2,a0
 180:	4481                	li	s1,0
    cc = read(0, &c, 1);
 182:	faf40b13          	addi	s6,s0,-81
 186:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 188:	8c26                	mv	s8,s1
 18a:	0014899b          	addiw	s3,s1,1
 18e:	84ce                	mv	s1,s3
 190:	0349d863          	bge	s3,s4,1c0 <gets+0x5e>
    cc = read(0, &c, 1);
 194:	8656                	mv	a2,s5
 196:	85da                	mv	a1,s6
 198:	4501                	li	a0,0
 19a:	1c0000ef          	jal	35a <read>
    if(cc < 1)
 19e:	02a05163          	blez	a0,1c0 <gets+0x5e>
      break;
    buf[i++] = c;
 1a2:	faf44783          	lbu	a5,-81(s0)
 1a6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1aa:	0905                	addi	s2,s2,1
 1ac:	ff678713          	addi	a4,a5,-10
 1b0:	00173713          	seqz	a4,a4
 1b4:	17cd                	addi	a5,a5,-13
 1b6:	0017b793          	seqz	a5,a5
 1ba:	8fd9                	or	a5,a5,a4
 1bc:	d7f1                	beqz	a5,188 <gets+0x26>
    buf[i++] = c;
 1be:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 1c0:	9c5e                	add	s8,s8,s7
 1c2:	000c0023          	sb	zero,0(s8)
  return buf;
}
 1c6:	855e                	mv	a0,s7
 1c8:	60e6                	ld	ra,88(sp)
 1ca:	6446                	ld	s0,80(sp)
 1cc:	64a6                	ld	s1,72(sp)
 1ce:	6906                	ld	s2,64(sp)
 1d0:	79e2                	ld	s3,56(sp)
 1d2:	7a42                	ld	s4,48(sp)
 1d4:	7aa2                	ld	s5,40(sp)
 1d6:	7b02                	ld	s6,32(sp)
 1d8:	6be2                	ld	s7,24(sp)
 1da:	6c42                	ld	s8,16(sp)
 1dc:	6125                	addi	sp,sp,96
 1de:	8082                	ret

00000000000001e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1e0:	1101                	addi	sp,sp,-32
 1e2:	ec06                	sd	ra,24(sp)
 1e4:	e822                	sd	s0,16(sp)
 1e6:	e04a                	sd	s2,0(sp)
 1e8:	1000                	addi	s0,sp,32
 1ea:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ec:	4581                	li	a1,0
 1ee:	194000ef          	jal	382 <open>
  if(fd < 0)
 1f2:	02054263          	bltz	a0,216 <stat+0x36>
 1f6:	e426                	sd	s1,8(sp)
 1f8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1fa:	85ca                	mv	a1,s2
 1fc:	19e000ef          	jal	39a <fstat>
 200:	892a                	mv	s2,a0
  close(fd);
 202:	8526                	mv	a0,s1
 204:	166000ef          	jal	36a <close>
  return r;
 208:	64a2                	ld	s1,8(sp)
}
 20a:	854a                	mv	a0,s2
 20c:	60e2                	ld	ra,24(sp)
 20e:	6442                	ld	s0,16(sp)
 210:	6902                	ld	s2,0(sp)
 212:	6105                	addi	sp,sp,32
 214:	8082                	ret
    return -1;
 216:	57fd                	li	a5,-1
 218:	893e                	mv	s2,a5
 21a:	bfc5                	j	20a <stat+0x2a>

000000000000021c <atoi>:

int
atoi(const char *s)
{
 21c:	1141                	addi	sp,sp,-16
 21e:	e406                	sd	ra,8(sp)
 220:	e022                	sd	s0,0(sp)
 222:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 224:	00054683          	lbu	a3,0(a0)
 228:	fd06879b          	addiw	a5,a3,-48
 22c:	0ff7f793          	zext.b	a5,a5
 230:	4625                	li	a2,9
 232:	02f66963          	bltu	a2,a5,264 <atoi+0x48>
 236:	872a                	mv	a4,a0
  n = 0;
 238:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 23a:	0705                	addi	a4,a4,1
 23c:	0025179b          	slliw	a5,a0,0x2
 240:	9fa9                	addw	a5,a5,a0
 242:	0017979b          	slliw	a5,a5,0x1
 246:	9fb5                	addw	a5,a5,a3
 248:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 24c:	00074683          	lbu	a3,0(a4)
 250:	fd06879b          	addiw	a5,a3,-48
 254:	0ff7f793          	zext.b	a5,a5
 258:	fef671e3          	bgeu	a2,a5,23a <atoi+0x1e>
  return n;
}
 25c:	60a2                	ld	ra,8(sp)
 25e:	6402                	ld	s0,0(sp)
 260:	0141                	addi	sp,sp,16
 262:	8082                	ret
  n = 0;
 264:	4501                	li	a0,0
 266:	bfdd                	j	25c <atoi+0x40>

0000000000000268 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 268:	1141                	addi	sp,sp,-16
 26a:	e406                	sd	ra,8(sp)
 26c:	e022                	sd	s0,0(sp)
 26e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 270:	02b57563          	bgeu	a0,a1,29a <memmove+0x32>
    while(n-- > 0)
 274:	00c05f63          	blez	a2,292 <memmove+0x2a>
 278:	1602                	slli	a2,a2,0x20
 27a:	9201                	srli	a2,a2,0x20
 27c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 280:	872a                	mv	a4,a0
      *dst++ = *src++;
 282:	0585                	addi	a1,a1,1
 284:	0705                	addi	a4,a4,1
 286:	fff5c683          	lbu	a3,-1(a1)
 28a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 28e:	fee79ae3          	bne	a5,a4,282 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 292:	60a2                	ld	ra,8(sp)
 294:	6402                	ld	s0,0(sp)
 296:	0141                	addi	sp,sp,16
 298:	8082                	ret
    while(n-- > 0)
 29a:	fec05ce3          	blez	a2,292 <memmove+0x2a>
    dst += n;
 29e:	00c50733          	add	a4,a0,a2
    src += n;
 2a2:	95b2                	add	a1,a1,a2
 2a4:	fff6079b          	addiw	a5,a2,-1
 2a8:	1782                	slli	a5,a5,0x20
 2aa:	9381                	srli	a5,a5,0x20
 2ac:	fff7c793          	not	a5,a5
 2b0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2b2:	15fd                	addi	a1,a1,-1
 2b4:	177d                	addi	a4,a4,-1
 2b6:	0005c683          	lbu	a3,0(a1)
 2ba:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2be:	fef71ae3          	bne	a4,a5,2b2 <memmove+0x4a>
 2c2:	bfc1                	j	292 <memmove+0x2a>

00000000000002c4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2c4:	1141                	addi	sp,sp,-16
 2c6:	e406                	sd	ra,8(sp)
 2c8:	e022                	sd	s0,0(sp)
 2ca:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2cc:	ce19                	beqz	a2,2ea <memcmp+0x26>
 2ce:	1602                	slli	a2,a2,0x20
 2d0:	9201                	srli	a2,a2,0x20
 2d2:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 2d6:	00054783          	lbu	a5,0(a0)
 2da:	0005c703          	lbu	a4,0(a1)
 2de:	00e79b63          	bne	a5,a4,2f4 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 2e2:	0505                	addi	a0,a0,1
    p2++;
 2e4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2e6:	fed518e3          	bne	a0,a3,2d6 <memcmp+0x12>
  }
  return 0;
 2ea:	4501                	li	a0,0
}
 2ec:	60a2                	ld	ra,8(sp)
 2ee:	6402                	ld	s0,0(sp)
 2f0:	0141                	addi	sp,sp,16
 2f2:	8082                	ret
      return *p1 - *p2;
 2f4:	40e7853b          	subw	a0,a5,a4
 2f8:	bfd5                	j	2ec <memcmp+0x28>

00000000000002fa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2fa:	1141                	addi	sp,sp,-16
 2fc:	e406                	sd	ra,8(sp)
 2fe:	e022                	sd	s0,0(sp)
 300:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 302:	f67ff0ef          	jal	268 <memmove>
}
 306:	60a2                	ld	ra,8(sp)
 308:	6402                	ld	s0,0(sp)
 30a:	0141                	addi	sp,sp,16
 30c:	8082                	ret

000000000000030e <sbrk>:

char *
sbrk(int n) {
 30e:	1141                	addi	sp,sp,-16
 310:	e406                	sd	ra,8(sp)
 312:	e022                	sd	s0,0(sp)
 314:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 316:	4585                	li	a1,1
 318:	0b2000ef          	jal	3ca <sys_sbrk>
}
 31c:	60a2                	ld	ra,8(sp)
 31e:	6402                	ld	s0,0(sp)
 320:	0141                	addi	sp,sp,16
 322:	8082                	ret

0000000000000324 <sbrklazy>:

char *
sbrklazy(int n) {
 324:	1141                	addi	sp,sp,-16
 326:	e406                	sd	ra,8(sp)
 328:	e022                	sd	s0,0(sp)
 32a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 32c:	4589                	li	a1,2
 32e:	09c000ef          	jal	3ca <sys_sbrk>
}
 332:	60a2                	ld	ra,8(sp)
 334:	6402                	ld	s0,0(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret

000000000000033a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 33a:	4885                	li	a7,1
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <exit>:
.global exit
exit:
 li a7, SYS_exit
 342:	4889                	li	a7,2
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <wait>:
.global wait
wait:
 li a7, SYS_wait
 34a:	488d                	li	a7,3
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 352:	4891                	li	a7,4
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <read>:
.global read
read:
 li a7, SYS_read
 35a:	4895                	li	a7,5
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <write>:
.global write
write:
 li a7, SYS_write
 362:	48c1                	li	a7,16
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <close>:
.global close
close:
 li a7, SYS_close
 36a:	48d5                	li	a7,21
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <kill>:
.global kill
kill:
 li a7, SYS_kill
 372:	4899                	li	a7,6
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <exec>:
.global exec
exec:
 li a7, SYS_exec
 37a:	489d                	li	a7,7
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <open>:
.global open
open:
 li a7, SYS_open
 382:	48bd                	li	a7,15
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 38a:	48c5                	li	a7,17
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 392:	48c9                	li	a7,18
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 39a:	48a1                	li	a7,8
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <link>:
.global link
link:
 li a7, SYS_link
 3a2:	48cd                	li	a7,19
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3aa:	48d1                	li	a7,20
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3b2:	48a5                	li	a7,9
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <dup>:
.global dup
dup:
 li a7, SYS_dup
 3ba:	48a9                	li	a7,10
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3c2:	48ad                	li	a7,11
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3ca:	48b1                	li	a7,12
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <pause>:
.global pause
pause:
 li a7, SYS_pause
 3d2:	48b5                	li	a7,13
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3da:	48b9                	li	a7,14
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <bind>:
.global bind
bind:
 li a7, SYS_bind
 3e2:	48f5                	li	a7,29
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 3ea:	48f9                	li	a7,30
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <send>:
.global send
send:
 li a7, SYS_send
 3f2:	48fd                	li	a7,31
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <recv>:
.global recv
recv:
 li a7, SYS_recv
 3fa:	02000893          	li	a7,32
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 404:	02100893          	li	a7,33
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 40e:	02200893          	li	a7,34
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <rwlktest>:
.global rwlktest
rwlktest:
 li a7, SYS_rwlktest
 418:	02300893          	li	a7,35
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <cpupin>:
.global cpupin
cpupin:
 li a7, SYS_cpupin
 422:	02400893          	li	a7,36
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 42c:	1101                	addi	sp,sp,-32
 42e:	ec06                	sd	ra,24(sp)
 430:	e822                	sd	s0,16(sp)
 432:	1000                	addi	s0,sp,32
 434:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 438:	4605                	li	a2,1
 43a:	fef40593          	addi	a1,s0,-17
 43e:	f25ff0ef          	jal	362 <write>
}
 442:	60e2                	ld	ra,24(sp)
 444:	6442                	ld	s0,16(sp)
 446:	6105                	addi	sp,sp,32
 448:	8082                	ret

000000000000044a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 44a:	715d                	addi	sp,sp,-80
 44c:	e486                	sd	ra,72(sp)
 44e:	e0a2                	sd	s0,64(sp)
 450:	f84a                	sd	s2,48(sp)
 452:	f44e                	sd	s3,40(sp)
 454:	0880                	addi	s0,sp,80
 456:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 458:	00d036b3          	snez	a3,a3
 45c:	03f5d793          	srli	a5,a1,0x3f
 460:	8efd                	and	a3,a3,a5
  neg = 0;
 462:	4301                	li	t1,0
  if(sgn && xx < 0){
 464:	c681                	beqz	a3,46c <printint+0x22>
    neg = 1;
    x = -xx;
 466:	40b005b3          	neg	a1,a1
    neg = 1;
 46a:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 46c:	fb840993          	addi	s3,s0,-72
  neg = 0;
 470:	86ce                	mv	a3,s3
  i = 0;
 472:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 474:	00000817          	auipc	a6,0x0
 478:	64480813          	addi	a6,a6,1604 # ab8 <digits>
 47c:	88ba                	mv	a7,a4
 47e:	0017051b          	addiw	a0,a4,1
 482:	872a                	mv	a4,a0
 484:	02c5f7b3          	remu	a5,a1,a2
 488:	97c2                	add	a5,a5,a6
 48a:	0007c783          	lbu	a5,0(a5)
 48e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 492:	87ae                	mv	a5,a1
 494:	02c5d5b3          	divu	a1,a1,a2
 498:	0685                	addi	a3,a3,1
 49a:	fec7f1e3          	bgeu	a5,a2,47c <printint+0x32>
  if(neg)
 49e:	00030b63          	beqz	t1,4b4 <printint+0x6a>
    buf[i++] = '-';
 4a2:	fd040793          	addi	a5,s0,-48
 4a6:	953e                	add	a0,a0,a5
 4a8:	02d00793          	li	a5,45
 4ac:	fef50423          	sb	a5,-24(a0)
 4b0:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 4b4:	02e05563          	blez	a4,4de <printint+0x94>
 4b8:	fc26                	sd	s1,56(sp)
 4ba:	377d                	addiw	a4,a4,-1
 4bc:	00e984b3          	add	s1,s3,a4
 4c0:	19fd                	addi	s3,s3,-1
 4c2:	99ba                	add	s3,s3,a4
 4c4:	1702                	slli	a4,a4,0x20
 4c6:	9301                	srli	a4,a4,0x20
 4c8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4cc:	0004c583          	lbu	a1,0(s1)
 4d0:	854a                	mv	a0,s2
 4d2:	f5bff0ef          	jal	42c <putc>
  while(--i >= 0)
 4d6:	14fd                	addi	s1,s1,-1
 4d8:	ff349ae3          	bne	s1,s3,4cc <printint+0x82>
 4dc:	74e2                	ld	s1,56(sp)
}
 4de:	60a6                	ld	ra,72(sp)
 4e0:	6406                	ld	s0,64(sp)
 4e2:	7942                	ld	s2,48(sp)
 4e4:	79a2                	ld	s3,40(sp)
 4e6:	6161                	addi	sp,sp,80
 4e8:	8082                	ret

00000000000004ea <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4ea:	711d                	addi	sp,sp,-96
 4ec:	ec86                	sd	ra,88(sp)
 4ee:	e8a2                	sd	s0,80(sp)
 4f0:	e4a6                	sd	s1,72(sp)
 4f2:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4f4:	0005c483          	lbu	s1,0(a1)
 4f8:	2a048063          	beqz	s1,798 <vprintf+0x2ae>
 4fc:	e0ca                	sd	s2,64(sp)
 4fe:	fc4e                	sd	s3,56(sp)
 500:	f852                	sd	s4,48(sp)
 502:	f456                	sd	s5,40(sp)
 504:	f05a                	sd	s6,32(sp)
 506:	ec5e                	sd	s7,24(sp)
 508:	e862                	sd	s8,16(sp)
 50a:	8b2a                	mv	s6,a0
 50c:	8a2e                	mv	s4,a1
 50e:	8bb2                	mv	s7,a2
  state = 0;
 510:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 512:	4901                	li	s2,0
 514:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 516:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 51a:	06400c13          	li	s8,100
 51e:	a00d                	j	540 <vprintf+0x56>
        putc(fd, c0);
 520:	85a6                	mv	a1,s1
 522:	855a                	mv	a0,s6
 524:	f09ff0ef          	jal	42c <putc>
 528:	a019                	j	52e <vprintf+0x44>
    } else if(state == '%'){
 52a:	03598363          	beq	s3,s5,550 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 52e:	0019079b          	addiw	a5,s2,1
 532:	893e                	mv	s2,a5
 534:	873e                	mv	a4,a5
 536:	97d2                	add	a5,a5,s4
 538:	0007c483          	lbu	s1,0(a5)
 53c:	24048763          	beqz	s1,78a <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 540:	0004879b          	sext.w	a5,s1
    if(state == 0){
 544:	fe0993e3          	bnez	s3,52a <vprintf+0x40>
      if(c0 == '%'){
 548:	fd579ce3          	bne	a5,s5,520 <vprintf+0x36>
        state = '%';
 54c:	89be                	mv	s3,a5
 54e:	b7c5                	j	52e <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 550:	00ea06b3          	add	a3,s4,a4
 554:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 558:	24060563          	beqz	a2,7a2 <vprintf+0x2b8>
      if(c0 == 'd'){
 55c:	0b878763          	beq	a5,s8,60a <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 560:	f9478693          	addi	a3,a5,-108
 564:	0016b693          	seqz	a3,a3
 568:	f9c60593          	addi	a1,a2,-100
 56c:	0015b593          	seqz	a1,a1
 570:	8df5                	and	a1,a1,a3
 572:	e9c5                	bnez	a1,622 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 574:	9752                	add	a4,a4,s4
 576:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 57a:	f9460713          	addi	a4,a2,-108
 57e:	00173713          	seqz	a4,a4
 582:	8f75                	and	a4,a4,a3
 584:	f9c50593          	addi	a1,a0,-100
 588:	0015b593          	seqz	a1,a1
 58c:	8df9                	and	a1,a1,a4
 58e:	e5dd                	bnez	a1,63c <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 590:	07500593          	li	a1,117
 594:	0cb78163          	beq	a5,a1,656 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 598:	f8b60593          	addi	a1,a2,-117
 59c:	0015b593          	seqz	a1,a1
 5a0:	8df5                	and	a1,a1,a3
 5a2:	e5f1                	bnez	a1,66e <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 5a4:	f8b50593          	addi	a1,a0,-117
 5a8:	0015b593          	seqz	a1,a1
 5ac:	8df9                	and	a1,a1,a4
 5ae:	ede9                	bnez	a1,688 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5b0:	07800593          	li	a1,120
 5b4:	0eb78763          	beq	a5,a1,6a2 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 5b8:	f8860613          	addi	a2,a2,-120
 5bc:	00163613          	seqz	a2,a2
 5c0:	8ef1                	and	a3,a3,a2
 5c2:	0e069c63          	bnez	a3,6ba <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5c6:	f8850513          	addi	a0,a0,-120
 5ca:	00153513          	seqz	a0,a0
 5ce:	8f69                	and	a4,a4,a0
 5d0:	10071263          	bnez	a4,6d4 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5d4:	07000713          	li	a4,112
 5d8:	10e78a63          	beq	a5,a4,6ec <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5dc:	06300713          	li	a4,99
 5e0:	14e78a63          	beq	a5,a4,734 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5e4:	07300713          	li	a4,115
 5e8:	16e78063          	beq	a5,a4,748 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5ec:	02500713          	li	a4,37
 5f0:	18e78863          	beq	a5,a4,780 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f4:	02500593          	li	a1,37
 5f8:	855a                	mv	a0,s6
 5fa:	e33ff0ef          	jal	42c <putc>
        putc(fd, c0);
 5fe:	85a6                	mv	a1,s1
 600:	855a                	mv	a0,s6
 602:	e2bff0ef          	jal	42c <putc>
      }

      state = 0;
 606:	4981                	li	s3,0
 608:	b71d                	j	52e <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 60a:	008b8493          	addi	s1,s7,8
 60e:	4685                	li	a3,1
 610:	4629                	li	a2,10
 612:	000ba583          	lw	a1,0(s7)
 616:	855a                	mv	a0,s6
 618:	e33ff0ef          	jal	44a <printint>
 61c:	8ba6                	mv	s7,s1
      state = 0;
 61e:	4981                	li	s3,0
 620:	b739                	j	52e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 622:	008b8493          	addi	s1,s7,8
 626:	4685                	li	a3,1
 628:	4629                	li	a2,10
 62a:	000bb583          	ld	a1,0(s7)
 62e:	855a                	mv	a0,s6
 630:	e1bff0ef          	jal	44a <printint>
        i += 1;
 634:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 636:	8ba6                	mv	s7,s1
      state = 0;
 638:	4981                	li	s3,0
 63a:	bdd5                	j	52e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 63c:	008b8493          	addi	s1,s7,8
 640:	4685                	li	a3,1
 642:	4629                	li	a2,10
 644:	000bb583          	ld	a1,0(s7)
 648:	855a                	mv	a0,s6
 64a:	e01ff0ef          	jal	44a <printint>
        i += 2;
 64e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 650:	8ba6                	mv	s7,s1
      state = 0;
 652:	4981                	li	s3,0
        i += 2;
 654:	bde9                	j	52e <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 656:	008b8493          	addi	s1,s7,8
 65a:	4681                	li	a3,0
 65c:	4629                	li	a2,10
 65e:	000be583          	lwu	a1,0(s7)
 662:	855a                	mv	a0,s6
 664:	de7ff0ef          	jal	44a <printint>
 668:	8ba6                	mv	s7,s1
      state = 0;
 66a:	4981                	li	s3,0
 66c:	b5c9                	j	52e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 66e:	008b8493          	addi	s1,s7,8
 672:	4681                	li	a3,0
 674:	4629                	li	a2,10
 676:	000bb583          	ld	a1,0(s7)
 67a:	855a                	mv	a0,s6
 67c:	dcfff0ef          	jal	44a <printint>
        i += 1;
 680:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 682:	8ba6                	mv	s7,s1
      state = 0;
 684:	4981                	li	s3,0
 686:	b565                	j	52e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 688:	008b8493          	addi	s1,s7,8
 68c:	4681                	li	a3,0
 68e:	4629                	li	a2,10
 690:	000bb583          	ld	a1,0(s7)
 694:	855a                	mv	a0,s6
 696:	db5ff0ef          	jal	44a <printint>
        i += 2;
 69a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 69c:	8ba6                	mv	s7,s1
      state = 0;
 69e:	4981                	li	s3,0
        i += 2;
 6a0:	b579                	j	52e <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6a2:	008b8493          	addi	s1,s7,8
 6a6:	4681                	li	a3,0
 6a8:	4641                	li	a2,16
 6aa:	000be583          	lwu	a1,0(s7)
 6ae:	855a                	mv	a0,s6
 6b0:	d9bff0ef          	jal	44a <printint>
 6b4:	8ba6                	mv	s7,s1
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	bd9d                	j	52e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6ba:	008b8493          	addi	s1,s7,8
 6be:	4681                	li	a3,0
 6c0:	4641                	li	a2,16
 6c2:	000bb583          	ld	a1,0(s7)
 6c6:	855a                	mv	a0,s6
 6c8:	d83ff0ef          	jal	44a <printint>
        i += 1;
 6cc:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6ce:	8ba6                	mv	s7,s1
      state = 0;
 6d0:	4981                	li	s3,0
 6d2:	bdb1                	j	52e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d4:	008b8493          	addi	s1,s7,8
 6d8:	4641                	li	a2,16
 6da:	000bb583          	ld	a1,0(s7)
 6de:	855a                	mv	a0,s6
 6e0:	d6bff0ef          	jal	44a <printint>
        i += 2;
 6e4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6e6:	8ba6                	mv	s7,s1
      state = 0;
 6e8:	4981                	li	s3,0
        i += 2;
 6ea:	b591                	j	52e <vprintf+0x44>
 6ec:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 6ee:	008b8793          	addi	a5,s7,8
 6f2:	8cbe                	mv	s9,a5
 6f4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6f8:	03000593          	li	a1,48
 6fc:	855a                	mv	a0,s6
 6fe:	d2fff0ef          	jal	42c <putc>
  putc(fd, 'x');
 702:	07800593          	li	a1,120
 706:	855a                	mv	a0,s6
 708:	d25ff0ef          	jal	42c <putc>
 70c:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 70e:	00000b97          	auipc	s7,0x0
 712:	3aab8b93          	addi	s7,s7,938 # ab8 <digits>
 716:	03c9d793          	srli	a5,s3,0x3c
 71a:	97de                	add	a5,a5,s7
 71c:	0007c583          	lbu	a1,0(a5)
 720:	855a                	mv	a0,s6
 722:	d0bff0ef          	jal	42c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 726:	0992                	slli	s3,s3,0x4
 728:	34fd                	addiw	s1,s1,-1
 72a:	f4f5                	bnez	s1,716 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 72c:	8be6                	mv	s7,s9
      state = 0;
 72e:	4981                	li	s3,0
 730:	6ca2                	ld	s9,8(sp)
 732:	bbf5                	j	52e <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 734:	008b8493          	addi	s1,s7,8
 738:	000bc583          	lbu	a1,0(s7)
 73c:	855a                	mv	a0,s6
 73e:	cefff0ef          	jal	42c <putc>
 742:	8ba6                	mv	s7,s1
      state = 0;
 744:	4981                	li	s3,0
 746:	b3e5                	j	52e <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 748:	008b8993          	addi	s3,s7,8
 74c:	000bb483          	ld	s1,0(s7)
 750:	cc91                	beqz	s1,76c <vprintf+0x282>
        for(; *s; s++)
 752:	0004c583          	lbu	a1,0(s1)
 756:	c195                	beqz	a1,77a <vprintf+0x290>
          putc(fd, *s);
 758:	855a                	mv	a0,s6
 75a:	cd3ff0ef          	jal	42c <putc>
        for(; *s; s++)
 75e:	0485                	addi	s1,s1,1
 760:	0004c583          	lbu	a1,0(s1)
 764:	f9f5                	bnez	a1,758 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 766:	8bce                	mv	s7,s3
      state = 0;
 768:	4981                	li	s3,0
 76a:	b3d1                	j	52e <vprintf+0x44>
          s = "(null)";
 76c:	00000497          	auipc	s1,0x0
 770:	31c48493          	addi	s1,s1,796 # a88 <statistics+0xf8>
        for(; *s; s++)
 774:	02800593          	li	a1,40
 778:	b7c5                	j	758 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 77a:	8bce                	mv	s7,s3
      state = 0;
 77c:	4981                	li	s3,0
 77e:	bb45                	j	52e <vprintf+0x44>
        putc(fd, '%');
 780:	85be                	mv	a1,a5
 782:	855a                	mv	a0,s6
 784:	ca9ff0ef          	jal	42c <putc>
 788:	bdbd                	j	606 <vprintf+0x11c>
 78a:	6906                	ld	s2,64(sp)
 78c:	79e2                	ld	s3,56(sp)
 78e:	7a42                	ld	s4,48(sp)
 790:	7aa2                	ld	s5,40(sp)
 792:	7b02                	ld	s6,32(sp)
 794:	6be2                	ld	s7,24(sp)
 796:	6c42                	ld	s8,16(sp)
    }
  }
}
 798:	60e6                	ld	ra,88(sp)
 79a:	6446                	ld	s0,80(sp)
 79c:	64a6                	ld	s1,72(sp)
 79e:	6125                	addi	sp,sp,96
 7a0:	8082                	ret
      if(c0 == 'd'){
 7a2:	06400713          	li	a4,100
 7a6:	e6e782e3          	beq	a5,a4,60a <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 7aa:	f9478693          	addi	a3,a5,-108
 7ae:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 7b2:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7b4:	4701                	li	a4,0
 7b6:	bbe9                	j	590 <vprintf+0xa6>

00000000000007b8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7b8:	715d                	addi	sp,sp,-80
 7ba:	ec06                	sd	ra,24(sp)
 7bc:	e822                	sd	s0,16(sp)
 7be:	1000                	addi	s0,sp,32
 7c0:	e010                	sd	a2,0(s0)
 7c2:	e414                	sd	a3,8(s0)
 7c4:	e818                	sd	a4,16(s0)
 7c6:	ec1c                	sd	a5,24(s0)
 7c8:	03043023          	sd	a6,32(s0)
 7cc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7d0:	8622                	mv	a2,s0
 7d2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7d6:	d15ff0ef          	jal	4ea <vprintf>
}
 7da:	60e2                	ld	ra,24(sp)
 7dc:	6442                	ld	s0,16(sp)
 7de:	6161                	addi	sp,sp,80
 7e0:	8082                	ret

00000000000007e2 <printf>:

void
printf(const char *fmt, ...)
{
 7e2:	711d                	addi	sp,sp,-96
 7e4:	ec06                	sd	ra,24(sp)
 7e6:	e822                	sd	s0,16(sp)
 7e8:	1000                	addi	s0,sp,32
 7ea:	e40c                	sd	a1,8(s0)
 7ec:	e810                	sd	a2,16(s0)
 7ee:	ec14                	sd	a3,24(s0)
 7f0:	f018                	sd	a4,32(s0)
 7f2:	f41c                	sd	a5,40(s0)
 7f4:	03043823          	sd	a6,48(s0)
 7f8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7fc:	00840613          	addi	a2,s0,8
 800:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 804:	85aa                	mv	a1,a0
 806:	4505                	li	a0,1
 808:	ce3ff0ef          	jal	4ea <vprintf>
}
 80c:	60e2                	ld	ra,24(sp)
 80e:	6442                	ld	s0,16(sp)
 810:	6125                	addi	sp,sp,96
 812:	8082                	ret

0000000000000814 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 814:	1141                	addi	sp,sp,-16
 816:	e406                	sd	ra,8(sp)
 818:	e022                	sd	s0,0(sp)
 81a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 81c:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 820:	00000797          	auipc	a5,0x0
 824:	7e07b783          	ld	a5,2016(a5) # 1000 <freep>
 828:	a095                	j	88c <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 82a:	ff852583          	lw	a1,-8(a0)
 82e:	6390                	ld	a2,0(a5)
 830:	02059813          	slli	a6,a1,0x20
 834:	01c85693          	srli	a3,a6,0x1c
 838:	96ba                	add	a3,a3,a4
 83a:	02d60563          	beq	a2,a3,864 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 83e:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 842:	4790                	lw	a2,8(a5)
 844:	02061593          	slli	a1,a2,0x20
 848:	01c5d693          	srli	a3,a1,0x1c
 84c:	96be                	add	a3,a3,a5
 84e:	02d70263          	beq	a4,a3,872 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 852:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 854:	00000717          	auipc	a4,0x0
 858:	7af73623          	sd	a5,1964(a4) # 1000 <freep>
}
 85c:	60a2                	ld	ra,8(sp)
 85e:	6402                	ld	s0,0(sp)
 860:	0141                	addi	sp,sp,16
 862:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 864:	4614                	lw	a3,8(a2)
 866:	9ead                	addw	a3,a3,a1
 868:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 86c:	6394                	ld	a3,0(a5)
 86e:	6290                	ld	a2,0(a3)
 870:	b7f9                	j	83e <free+0x2a>
    p->s.size += bp->s.size;
 872:	ff852703          	lw	a4,-8(a0)
 876:	9f31                	addw	a4,a4,a2
 878:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 87a:	ff053703          	ld	a4,-16(a0)
 87e:	bfd1                	j	852 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 880:	6394                	ld	a3,0(a5)
 882:	00d7e463          	bltu	a5,a3,88a <free+0x76>
 886:	fad762e3          	bltu	a4,a3,82a <free+0x16>
 88a:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 88c:	fee7fae3          	bgeu	a5,a4,880 <free+0x6c>
 890:	6394                	ld	a3,0(a5)
 892:	f8d76ce3          	bltu	a4,a3,82a <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 896:	f8d7fae3          	bgeu	a5,a3,82a <free+0x16>
 89a:	87b6                	mv	a5,a3
 89c:	bfc5                	j	88c <free+0x78>

000000000000089e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 89e:	7139                	addi	sp,sp,-64
 8a0:	fc06                	sd	ra,56(sp)
 8a2:	f822                	sd	s0,48(sp)
 8a4:	f04a                	sd	s2,32(sp)
 8a6:	ec4e                	sd	s3,24(sp)
 8a8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8aa:	02051993          	slli	s3,a0,0x20
 8ae:	0209d993          	srli	s3,s3,0x20
 8b2:	09bd                	addi	s3,s3,15
 8b4:	0049d993          	srli	s3,s3,0x4
 8b8:	2985                	addiw	s3,s3,1
 8ba:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8bc:	00000517          	auipc	a0,0x0
 8c0:	74453503          	ld	a0,1860(a0) # 1000 <freep>
 8c4:	c905                	beqz	a0,8f4 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8c8:	4798                	lw	a4,8(a5)
 8ca:	09377663          	bgeu	a4,s3,956 <malloc+0xb8>
 8ce:	f426                	sd	s1,40(sp)
 8d0:	e852                	sd	s4,16(sp)
 8d2:	e456                	sd	s5,8(sp)
 8d4:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8d6:	8a4e                	mv	s4,s3
 8d8:	6705                	lui	a4,0x1
 8da:	00e9f363          	bgeu	s3,a4,8e0 <malloc+0x42>
 8de:	6a05                	lui	s4,0x1
 8e0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8e4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8e8:	00000497          	auipc	s1,0x0
 8ec:	71848493          	addi	s1,s1,1816 # 1000 <freep>
  if(p == SBRK_ERROR)
 8f0:	5afd                	li	s5,-1
 8f2:	a83d                	j	930 <malloc+0x92>
 8f4:	f426                	sd	s1,40(sp)
 8f6:	e852                	sd	s4,16(sp)
 8f8:	e456                	sd	s5,8(sp)
 8fa:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8fc:	00001797          	auipc	a5,0x1
 900:	90c78793          	addi	a5,a5,-1780 # 1208 <base>
 904:	00000717          	auipc	a4,0x0
 908:	6ef73e23          	sd	a5,1788(a4) # 1000 <freep>
 90c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 90e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 912:	b7d1                	j	8d6 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 914:	6398                	ld	a4,0(a5)
 916:	e118                	sd	a4,0(a0)
 918:	a899                	j	96e <malloc+0xd0>
  hp->s.size = nu;
 91a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 91e:	0541                	addi	a0,a0,16
 920:	ef5ff0ef          	jal	814 <free>
  return freep;
 924:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 926:	c125                	beqz	a0,986 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 928:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 92a:	4798                	lw	a4,8(a5)
 92c:	03277163          	bgeu	a4,s2,94e <malloc+0xb0>
    if(p == freep)
 930:	6098                	ld	a4,0(s1)
 932:	853e                	mv	a0,a5
 934:	fef71ae3          	bne	a4,a5,928 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 938:	8552                	mv	a0,s4
 93a:	9d5ff0ef          	jal	30e <sbrk>
  if(p == SBRK_ERROR)
 93e:	fd551ee3          	bne	a0,s5,91a <malloc+0x7c>
        return 0;
 942:	4501                	li	a0,0
 944:	74a2                	ld	s1,40(sp)
 946:	6a42                	ld	s4,16(sp)
 948:	6aa2                	ld	s5,8(sp)
 94a:	6b02                	ld	s6,0(sp)
 94c:	a03d                	j	97a <malloc+0xdc>
 94e:	74a2                	ld	s1,40(sp)
 950:	6a42                	ld	s4,16(sp)
 952:	6aa2                	ld	s5,8(sp)
 954:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 956:	fae90fe3          	beq	s2,a4,914 <malloc+0x76>
        p->s.size -= nunits;
 95a:	4137073b          	subw	a4,a4,s3
 95e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 960:	02071693          	slli	a3,a4,0x20
 964:	01c6d713          	srli	a4,a3,0x1c
 968:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 96a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 96e:	00000717          	auipc	a4,0x0
 972:	68a73923          	sd	a0,1682(a4) # 1000 <freep>
      return (void*)(p + 1);
 976:	01078513          	addi	a0,a5,16
  }
}
 97a:	70e2                	ld	ra,56(sp)
 97c:	7442                	ld	s0,48(sp)
 97e:	7902                	ld	s2,32(sp)
 980:	69e2                	ld	s3,24(sp)
 982:	6121                	addi	sp,sp,64
 984:	8082                	ret
 986:	74a2                	ld	s1,40(sp)
 988:	6a42                	ld	s4,16(sp)
 98a:	6aa2                	ld	s5,8(sp)
 98c:	6b02                	ld	s6,0(sp)
 98e:	b7f5                	j	97a <malloc+0xdc>

0000000000000990 <statistics>:
#include "kernel/fcntl.h"
#include "user/user.h"

int
statistics(void *buf, int sz)
{
 990:	7179                	addi	sp,sp,-48
 992:	f406                	sd	ra,40(sp)
 994:	f022                	sd	s0,32(sp)
 996:	ec26                	sd	s1,24(sp)
 998:	e84a                	sd	s2,16(sp)
 99a:	e44e                	sd	s3,8(sp)
 99c:	e052                	sd	s4,0(sp)
 99e:	1800                	addi	s0,sp,48
 9a0:	8a2a                	mv	s4,a0
 9a2:	892e                	mv	s2,a1
  int fd, i, n;
  
  fd = open("statistics", O_RDONLY);
 9a4:	4581                	li	a1,0
 9a6:	00000517          	auipc	a0,0x0
 9aa:	0ea50513          	addi	a0,a0,234 # a90 <statistics+0x100>
 9ae:	9d5ff0ef          	jal	382 <open>
  if(fd < 0) {
 9b2:	02054e63          	bltz	a0,9ee <statistics+0x5e>
 9b6:	89aa                	mv	s3,a0
      fprintf(2, "stats: open failed\n");
      exit(1);
  }
  for (i = 0; i < sz; ) {
 9b8:	4481                	li	s1,0
 9ba:	01205e63          	blez	s2,9d6 <statistics+0x46>
    if ((n = read(fd, buf+i, sz-i)) < 0) {
 9be:	4099063b          	subw	a2,s2,s1
 9c2:	009a05b3          	add	a1,s4,s1
 9c6:	854e                	mv	a0,s3
 9c8:	993ff0ef          	jal	35a <read>
 9cc:	00054563          	bltz	a0,9d6 <statistics+0x46>
      break;
    }
    i += n;
 9d0:	9ca9                	addw	s1,s1,a0
  for (i = 0; i < sz; ) {
 9d2:	ff24c6e3          	blt	s1,s2,9be <statistics+0x2e>
  }
  close(fd);
 9d6:	854e                	mv	a0,s3
 9d8:	993ff0ef          	jal	36a <close>
  return i;
}
 9dc:	8526                	mv	a0,s1
 9de:	70a2                	ld	ra,40(sp)
 9e0:	7402                	ld	s0,32(sp)
 9e2:	64e2                	ld	s1,24(sp)
 9e4:	6942                	ld	s2,16(sp)
 9e6:	69a2                	ld	s3,8(sp)
 9e8:	6a02                	ld	s4,0(sp)
 9ea:	6145                	addi	sp,sp,48
 9ec:	8082                	ret
      fprintf(2, "stats: open failed\n");
 9ee:	00000597          	auipc	a1,0x0
 9f2:	0b258593          	addi	a1,a1,178 # aa0 <statistics+0x110>
 9f6:	4509                	li	a0,2
 9f8:	dc1ff0ef          	jal	7b8 <fprintf>
      exit(1);
 9fc:	4505                	li	a0,1
 9fe:	945ff0ef          	jal	342 <exit>
