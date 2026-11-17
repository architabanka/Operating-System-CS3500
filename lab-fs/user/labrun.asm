
user/_labrun:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
  int status = -1;
   8:	57fd                	li	a5,-1
   a:	fcf42e23          	sw	a5,-36(s0)
  if (argc < 3) {
   e:	4789                	li	a5,2
  10:	00a7ce63          	blt	a5,a0,2c <main+0x2c>
  14:	ec26                	sd	s1,24(sp)
  16:	e84a                	sd	s2,16(sp)
    fprintf(2, "usage: labrun token program [arguments]\n");
  18:	00001597          	auipc	a1,0x1
  1c:	95858593          	addi	a1,a1,-1704 # 970 <malloc+0xf4>
  20:	853e                	mv	a0,a5
  22:	774000ef          	jal	796 <fprintf>
    exit(1);
  26:	4505                	li	a0,1
  28:	322000ef          	jal	34a <exit>
  2c:	ec26                	sd	s1,24(sp)
  2e:	e84a                	sd	s2,16(sp)
  30:	84ae                	mv	s1,a1
  }
  int pid = fork();
  32:	310000ef          	jal	342 <fork>
  36:	892a                	mv	s2,a0
  if (pid == 0) {
  38:	c505                	beqz	a0,60 <main+0x60>
    exec(argv[2], &argv[2]);
    fprintf(2, "labrun: exec failed\n");
    exit(127);
  }
  if (pid > 0 && wait(&status) != pid)
  3a:	04a04363          	bgtz	a0,80 <main+0x80>
    status = -1;
  sync();
  3e:	3ac000ef          	jal	3ea <sync>
  printf("\nLAB_RESULT %s %d\n", argv[1], status);
  42:	fdc42603          	lw	a2,-36(s0)
  46:	648c                	ld	a1,8(s1)
  48:	00001517          	auipc	a0,0x1
  4c:	97050513          	addi	a0,a0,-1680 # 9b8 <malloc+0x13c>
  50:	770000ef          	jal	7c0 <printf>
  exit(status == 0 ? 0 : 1);
  54:	fdc42503          	lw	a0,-36(s0)
  58:	00a03533          	snez	a0,a0
  5c:	2ee000ef          	jal	34a <exit>
    exec(argv[2], &argv[2]);
  60:	01048593          	addi	a1,s1,16
  64:	6888                	ld	a0,16(s1)
  66:	31c000ef          	jal	382 <exec>
    fprintf(2, "labrun: exec failed\n");
  6a:	00001597          	auipc	a1,0x1
  6e:	93658593          	addi	a1,a1,-1738 # 9a0 <malloc+0x124>
  72:	4509                	li	a0,2
  74:	722000ef          	jal	796 <fprintf>
    exit(127);
  78:	07f00513          	li	a0,127
  7c:	2ce000ef          	jal	34a <exit>
  if (pid > 0 && wait(&status) != pid)
  80:	fdc40513          	addi	a0,s0,-36
  84:	2ce000ef          	jal	352 <wait>
  88:	fb250be3          	beq	a0,s2,3e <main+0x3e>
    status = -1;
  8c:	57fd                	li	a5,-1
  8e:	fcf42e23          	sw	a5,-36(s0)
  92:	b775                	j	3e <main+0x3e>

0000000000000094 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  94:	1141                	addi	sp,sp,-16
  96:	e406                	sd	ra,8(sp)
  98:	e022                	sd	s0,0(sp)
  9a:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  9c:	f65ff0ef          	jal	0 <main>
  exit(r);
  a0:	2aa000ef          	jal	34a <exit>

00000000000000a4 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  a4:	1141                	addi	sp,sp,-16
  a6:	e406                	sd	ra,8(sp)
  a8:	e022                	sd	s0,0(sp)
  aa:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  ac:	87aa                	mv	a5,a0
  ae:	0585                	addi	a1,a1,1
  b0:	0785                	addi	a5,a5,1
  b2:	fff5c703          	lbu	a4,-1(a1)
  b6:	fee78fa3          	sb	a4,-1(a5)
  ba:	fb75                	bnez	a4,ae <strcpy+0xa>
    ;
  return os;
}
  bc:	60a2                	ld	ra,8(sp)
  be:	6402                	ld	s0,0(sp)
  c0:	0141                	addi	sp,sp,16
  c2:	8082                	ret

00000000000000c4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c4:	1141                	addi	sp,sp,-16
  c6:	e406                	sd	ra,8(sp)
  c8:	e022                	sd	s0,0(sp)
  ca:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  cc:	00054783          	lbu	a5,0(a0)
  d0:	cb91                	beqz	a5,e4 <strcmp+0x20>
  d2:	0005c703          	lbu	a4,0(a1)
  d6:	00f71763          	bne	a4,a5,e4 <strcmp+0x20>
    p++, q++;
  da:	0505                	addi	a0,a0,1
  dc:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  de:	00054783          	lbu	a5,0(a0)
  e2:	fbe5                	bnez	a5,d2 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  e4:	0005c503          	lbu	a0,0(a1)
}
  e8:	40a7853b          	subw	a0,a5,a0
  ec:	60a2                	ld	ra,8(sp)
  ee:	6402                	ld	s0,0(sp)
  f0:	0141                	addi	sp,sp,16
  f2:	8082                	ret

00000000000000f4 <strlen>:

uint
strlen(const char *s)
{
  f4:	1141                	addi	sp,sp,-16
  f6:	e406                	sd	ra,8(sp)
  f8:	e022                	sd	s0,0(sp)
  fa:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  fc:	00054783          	lbu	a5,0(a0)
 100:	cf91                	beqz	a5,11c <strlen+0x28>
 102:	00150793          	addi	a5,a0,1
 106:	86be                	mv	a3,a5
 108:	0785                	addi	a5,a5,1
 10a:	fff7c703          	lbu	a4,-1(a5)
 10e:	ff65                	bnez	a4,106 <strlen+0x12>
 110:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 114:	60a2                	ld	ra,8(sp)
 116:	6402                	ld	s0,0(sp)
 118:	0141                	addi	sp,sp,16
 11a:	8082                	ret
  for (n = 0; s[n]; n++)
 11c:	4501                	li	a0,0
 11e:	bfdd                	j	114 <strlen+0x20>

0000000000000120 <memset>:

void *
memset(void *dst, int c, uint n)
{
 120:	1141                	addi	sp,sp,-16
 122:	e406                	sd	ra,8(sp)
 124:	e022                	sd	s0,0(sp)
 126:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 128:	ca19                	beqz	a2,13e <memset+0x1e>
 12a:	87aa                	mv	a5,a0
 12c:	1602                	slli	a2,a2,0x20
 12e:	9201                	srli	a2,a2,0x20
 130:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 134:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 138:	0785                	addi	a5,a5,1
 13a:	fee79de3          	bne	a5,a4,134 <memset+0x14>
  }
  return dst;
}
 13e:	60a2                	ld	ra,8(sp)
 140:	6402                	ld	s0,0(sp)
 142:	0141                	addi	sp,sp,16
 144:	8082                	ret

0000000000000146 <strchr>:

char *
strchr(const char *s, char c)
{
 146:	1141                	addi	sp,sp,-16
 148:	e406                	sd	ra,8(sp)
 14a:	e022                	sd	s0,0(sp)
 14c:	0800                	addi	s0,sp,16
  for (; *s; s++)
 14e:	00054783          	lbu	a5,0(a0)
 152:	c799                	beqz	a5,160 <strchr+0x1a>
    if (*s == c)
 154:	00f58763          	beq	a1,a5,162 <strchr+0x1c>
  for (; *s; s++)
 158:	0505                	addi	a0,a0,1
 15a:	00054783          	lbu	a5,0(a0)
 15e:	fbfd                	bnez	a5,154 <strchr+0xe>
      return (char *)s;
  return 0;
 160:	4501                	li	a0,0
}
 162:	60a2                	ld	ra,8(sp)
 164:	6402                	ld	s0,0(sp)
 166:	0141                	addi	sp,sp,16
 168:	8082                	ret

000000000000016a <gets>:

char *
gets(char *buf, int max)
{
 16a:	711d                	addi	sp,sp,-96
 16c:	ec86                	sd	ra,88(sp)
 16e:	e8a2                	sd	s0,80(sp)
 170:	e4a6                	sd	s1,72(sp)
 172:	e0ca                	sd	s2,64(sp)
 174:	fc4e                	sd	s3,56(sp)
 176:	f852                	sd	s4,48(sp)
 178:	f456                	sd	s5,40(sp)
 17a:	f05a                	sd	s6,32(sp)
 17c:	ec5e                	sd	s7,24(sp)
 17e:	e862                	sd	s8,16(sp)
 180:	1080                	addi	s0,sp,96
 182:	8baa                	mv	s7,a0
 184:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 186:	892a                	mv	s2,a0
 188:	4481                	li	s1,0
    cc = read(0, &c, 1);
 18a:	faf40b13          	addi	s6,s0,-81
 18e:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;) {
 190:	8c26                	mv	s8,s1
 192:	0014899b          	addiw	s3,s1,1
 196:	84ce                	mv	s1,s3
 198:	0349d863          	bge	s3,s4,1c8 <gets+0x5e>
    cc = read(0, &c, 1);
 19c:	8656                	mv	a2,s5
 19e:	85da                	mv	a1,s6
 1a0:	4501                	li	a0,0
 1a2:	1c0000ef          	jal	362 <read>
    if (cc < 1)
 1a6:	02a05163          	blez	a0,1c8 <gets+0x5e>
      break;
    buf[i++] = c;
 1aa:	faf44783          	lbu	a5,-81(s0)
 1ae:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 1b2:	0905                	addi	s2,s2,1
 1b4:	ff678713          	addi	a4,a5,-10
 1b8:	00173713          	seqz	a4,a4
 1bc:	17cd                	addi	a5,a5,-13
 1be:	0017b793          	seqz	a5,a5
 1c2:	8fd9                	or	a5,a5,a4
 1c4:	d7f1                	beqz	a5,190 <gets+0x26>
    buf[i++] = c;
 1c6:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 1c8:	9c5e                	add	s8,s8,s7
 1ca:	000c0023          	sb	zero,0(s8)
  return buf;
}
 1ce:	855e                	mv	a0,s7
 1d0:	60e6                	ld	ra,88(sp)
 1d2:	6446                	ld	s0,80(sp)
 1d4:	64a6                	ld	s1,72(sp)
 1d6:	6906                	ld	s2,64(sp)
 1d8:	79e2                	ld	s3,56(sp)
 1da:	7a42                	ld	s4,48(sp)
 1dc:	7aa2                	ld	s5,40(sp)
 1de:	7b02                	ld	s6,32(sp)
 1e0:	6be2                	ld	s7,24(sp)
 1e2:	6c42                	ld	s8,16(sp)
 1e4:	6125                	addi	sp,sp,96
 1e6:	8082                	ret

00000000000001e8 <stat>:

int
stat(const char *n, struct stat *st)
{
 1e8:	1101                	addi	sp,sp,-32
 1ea:	ec06                	sd	ra,24(sp)
 1ec:	e822                	sd	s0,16(sp)
 1ee:	e04a                	sd	s2,0(sp)
 1f0:	1000                	addi	s0,sp,32
 1f2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f4:	4581                	li	a1,0
 1f6:	194000ef          	jal	38a <open>
  if (fd < 0)
 1fa:	02054263          	bltz	a0,21e <stat+0x36>
 1fe:	e426                	sd	s1,8(sp)
 200:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 202:	85ca                	mv	a1,s2
 204:	19e000ef          	jal	3a2 <fstat>
 208:	892a                	mv	s2,a0
  close(fd);
 20a:	8526                	mv	a0,s1
 20c:	166000ef          	jal	372 <close>
  return r;
 210:	64a2                	ld	s1,8(sp)
}
 212:	854a                	mv	a0,s2
 214:	60e2                	ld	ra,24(sp)
 216:	6442                	ld	s0,16(sp)
 218:	6902                	ld	s2,0(sp)
 21a:	6105                	addi	sp,sp,32
 21c:	8082                	ret
    return -1;
 21e:	57fd                	li	a5,-1
 220:	893e                	mv	s2,a5
 222:	bfc5                	j	212 <stat+0x2a>

0000000000000224 <atoi>:

int
atoi(const char *s)
{
 224:	1141                	addi	sp,sp,-16
 226:	e406                	sd	ra,8(sp)
 228:	e022                	sd	s0,0(sp)
 22a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 22c:	00054683          	lbu	a3,0(a0)
 230:	fd06879b          	addiw	a5,a3,-48
 234:	0ff7f793          	zext.b	a5,a5
 238:	4625                	li	a2,9
 23a:	02f66963          	bltu	a2,a5,26c <atoi+0x48>
 23e:	872a                	mv	a4,a0
  n = 0;
 240:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 242:	0705                	addi	a4,a4,1
 244:	0025179b          	slliw	a5,a0,0x2
 248:	9fa9                	addw	a5,a5,a0
 24a:	0017979b          	slliw	a5,a5,0x1
 24e:	9fb5                	addw	a5,a5,a3
 250:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 254:	00074683          	lbu	a3,0(a4)
 258:	fd06879b          	addiw	a5,a3,-48
 25c:	0ff7f793          	zext.b	a5,a5
 260:	fef671e3          	bgeu	a2,a5,242 <atoi+0x1e>
  return n;
}
 264:	60a2                	ld	ra,8(sp)
 266:	6402                	ld	s0,0(sp)
 268:	0141                	addi	sp,sp,16
 26a:	8082                	ret
  n = 0;
 26c:	4501                	li	a0,0
 26e:	bfdd                	j	264 <atoi+0x40>

0000000000000270 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 270:	1141                	addi	sp,sp,-16
 272:	e406                	sd	ra,8(sp)
 274:	e022                	sd	s0,0(sp)
 276:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 278:	02b57563          	bgeu	a0,a1,2a2 <memmove+0x32>
    while (n-- > 0)
 27c:	00c05f63          	blez	a2,29a <memmove+0x2a>
 280:	1602                	slli	a2,a2,0x20
 282:	9201                	srli	a2,a2,0x20
 284:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 288:	872a                	mv	a4,a0
      *dst++ = *src++;
 28a:	0585                	addi	a1,a1,1
 28c:	0705                	addi	a4,a4,1
 28e:	fff5c683          	lbu	a3,-1(a1)
 292:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 296:	fee79ae3          	bne	a5,a4,28a <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 29a:	60a2                	ld	ra,8(sp)
 29c:	6402                	ld	s0,0(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret
    while (n-- > 0)
 2a2:	fec05ce3          	blez	a2,29a <memmove+0x2a>
    dst += n;
 2a6:	00c50733          	add	a4,a0,a2
    src += n;
 2aa:	95b2                	add	a1,a1,a2
 2ac:	fff6079b          	addiw	a5,a2,-1
 2b0:	1782                	slli	a5,a5,0x20
 2b2:	9381                	srli	a5,a5,0x20
 2b4:	fff7c793          	not	a5,a5
 2b8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2ba:	15fd                	addi	a1,a1,-1
 2bc:	177d                	addi	a4,a4,-1
 2be:	0005c683          	lbu	a3,0(a1)
 2c2:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 2c6:	fef71ae3          	bne	a4,a5,2ba <memmove+0x4a>
 2ca:	bfc1                	j	29a <memmove+0x2a>

00000000000002cc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2cc:	1141                	addi	sp,sp,-16
 2ce:	e406                	sd	ra,8(sp)
 2d0:	e022                	sd	s0,0(sp)
 2d2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2d4:	ce19                	beqz	a2,2f2 <memcmp+0x26>
 2d6:	1602                	slli	a2,a2,0x20
 2d8:	9201                	srli	a2,a2,0x20
 2da:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 2de:	00054783          	lbu	a5,0(a0)
 2e2:	0005c703          	lbu	a4,0(a1)
 2e6:	00e79b63          	bne	a5,a4,2fc <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 2ea:	0505                	addi	a0,a0,1
    p2++;
 2ec:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2ee:	fed518e3          	bne	a0,a3,2de <memcmp+0x12>
  }
  return 0;
 2f2:	4501                	li	a0,0
}
 2f4:	60a2                	ld	ra,8(sp)
 2f6:	6402                	ld	s0,0(sp)
 2f8:	0141                	addi	sp,sp,16
 2fa:	8082                	ret
      return *p1 - *p2;
 2fc:	40e7853b          	subw	a0,a5,a4
 300:	bfd5                	j	2f4 <memcmp+0x28>

0000000000000302 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 302:	1141                	addi	sp,sp,-16
 304:	e406                	sd	ra,8(sp)
 306:	e022                	sd	s0,0(sp)
 308:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 30a:	f67ff0ef          	jal	270 <memmove>
}
 30e:	60a2                	ld	ra,8(sp)
 310:	6402                	ld	s0,0(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret

0000000000000316 <sbrk>:

char *
sbrk(int n)
{
 316:	1141                	addi	sp,sp,-16
 318:	e406                	sd	ra,8(sp)
 31a:	e022                	sd	s0,0(sp)
 31c:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 31e:	4585                	li	a1,1
 320:	0b2000ef          	jal	3d2 <sys_sbrk>
}
 324:	60a2                	ld	ra,8(sp)
 326:	6402                	ld	s0,0(sp)
 328:	0141                	addi	sp,sp,16
 32a:	8082                	ret

000000000000032c <sbrklazy>:

char *
sbrklazy(int n)
{
 32c:	1141                	addi	sp,sp,-16
 32e:	e406                	sd	ra,8(sp)
 330:	e022                	sd	s0,0(sp)
 332:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 334:	4589                	li	a1,2
 336:	09c000ef          	jal	3d2 <sys_sbrk>
}
 33a:	60a2                	ld	ra,8(sp)
 33c:	6402                	ld	s0,0(sp)
 33e:	0141                	addi	sp,sp,16
 340:	8082                	ret

0000000000000342 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 342:	4885                	li	a7,1
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <exit>:
.global exit
exit:
 li a7, SYS_exit
 34a:	4889                	li	a7,2
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <wait>:
.global wait
wait:
 li a7, SYS_wait
 352:	488d                	li	a7,3
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 35a:	4891                	li	a7,4
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <read>:
.global read
read:
 li a7, SYS_read
 362:	4895                	li	a7,5
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <write>:
.global write
write:
 li a7, SYS_write
 36a:	48c1                	li	a7,16
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <close>:
.global close
close:
 li a7, SYS_close
 372:	48d5                	li	a7,21
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <kill>:
.global kill
kill:
 li a7, SYS_kill
 37a:	4899                	li	a7,6
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <exec>:
.global exec
exec:
 li a7, SYS_exec
 382:	489d                	li	a7,7
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <open>:
.global open
open:
 li a7, SYS_open
 38a:	48bd                	li	a7,15
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 392:	48c5                	li	a7,17
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 39a:	48c9                	li	a7,18
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3a2:	48a1                	li	a7,8
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <link>:
.global link
link:
 li a7, SYS_link
 3aa:	48cd                	li	a7,19
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3b2:	48d1                	li	a7,20
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3ba:	48a5                	li	a7,9
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3c2:	48a9                	li	a7,10
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3ca:	48ad                	li	a7,11
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3d2:	48b1                	li	a7,12
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <pause>:
.global pause
pause:
 li a7, SYS_pause
 3da:	48b5                	li	a7,13
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3e2:	48b9                	li	a7,14
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <sync>:
.global sync
sync:
 li a7, SYS_sync
 3ea:	48d9                	li	a7,22
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <istat>:
.global istat
istat:
 li a7, SYS_istat
 3f2:	48dd                	li	a7,23
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <iprint>:
.global iprint
iprint:
 li a7, SYS_iprint
 3fa:	48e1                	li	a7,24
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <symlink>:
.global symlink
symlink:
 li a7, SYS_symlink
 402:	48e5                	li	a7,25
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 40a:	1101                	addi	sp,sp,-32
 40c:	ec06                	sd	ra,24(sp)
 40e:	e822                	sd	s0,16(sp)
 410:	1000                	addi	s0,sp,32
 412:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 416:	4605                	li	a2,1
 418:	fef40593          	addi	a1,s0,-17
 41c:	f4fff0ef          	jal	36a <write>
}
 420:	60e2                	ld	ra,24(sp)
 422:	6442                	ld	s0,16(sp)
 424:	6105                	addi	sp,sp,32
 426:	8082                	ret

0000000000000428 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 428:	715d                	addi	sp,sp,-80
 42a:	e486                	sd	ra,72(sp)
 42c:	e0a2                	sd	s0,64(sp)
 42e:	f84a                	sd	s2,48(sp)
 430:	f44e                	sd	s3,40(sp)
 432:	0880                	addi	s0,sp,80
 434:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 436:	00d036b3          	snez	a3,a3
 43a:	03f5d793          	srli	a5,a1,0x3f
 43e:	8efd                	and	a3,a3,a5
  neg = 0;
 440:	4301                	li	t1,0
  if (sgn && xx < 0) {
 442:	c681                	beqz	a3,44a <printint+0x22>
    neg = 1;
    x = -xx;
 444:	40b005b3          	neg	a1,a1
    neg = 1;
 448:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 44a:	fb840993          	addi	s3,s0,-72
  neg = 0;
 44e:	86ce                	mv	a3,s3
  i = 0;
 450:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
 452:	00000817          	auipc	a6,0x0
 456:	58680813          	addi	a6,a6,1414 # 9d8 <digits>
 45a:	88ba                	mv	a7,a4
 45c:	0017051b          	addiw	a0,a4,1
 460:	872a                	mv	a4,a0
 462:	02c5f7b3          	remu	a5,a1,a2
 466:	97c2                	add	a5,a5,a6
 468:	0007c783          	lbu	a5,0(a5)
 46c:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
 470:	87ae                	mv	a5,a1
 472:	02c5d5b3          	divu	a1,a1,a2
 476:	0685                	addi	a3,a3,1
 478:	fec7f1e3          	bgeu	a5,a2,45a <printint+0x32>
  if (neg)
 47c:	00030b63          	beqz	t1,492 <printint+0x6a>
    buf[i++] = '-';
 480:	fd040793          	addi	a5,s0,-48
 484:	953e                	add	a0,a0,a5
 486:	02d00793          	li	a5,45
 48a:	fef50423          	sb	a5,-24(a0)
 48e:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
 492:	02e05563          	blez	a4,4bc <printint+0x94>
 496:	fc26                	sd	s1,56(sp)
 498:	377d                	addiw	a4,a4,-1
 49a:	00e984b3          	add	s1,s3,a4
 49e:	19fd                	addi	s3,s3,-1
 4a0:	99ba                	add	s3,s3,a4
 4a2:	1702                	slli	a4,a4,0x20
 4a4:	9301                	srli	a4,a4,0x20
 4a6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4aa:	0004c583          	lbu	a1,0(s1)
 4ae:	854a                	mv	a0,s2
 4b0:	f5bff0ef          	jal	40a <putc>
  while (--i >= 0)
 4b4:	14fd                	addi	s1,s1,-1
 4b6:	ff349ae3          	bne	s1,s3,4aa <printint+0x82>
 4ba:	74e2                	ld	s1,56(sp)
}
 4bc:	60a6                	ld	ra,72(sp)
 4be:	6406                	ld	s0,64(sp)
 4c0:	7942                	ld	s2,48(sp)
 4c2:	79a2                	ld	s3,40(sp)
 4c4:	6161                	addi	sp,sp,80
 4c6:	8082                	ret

00000000000004c8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4c8:	711d                	addi	sp,sp,-96
 4ca:	ec86                	sd	ra,88(sp)
 4cc:	e8a2                	sd	s0,80(sp)
 4ce:	e4a6                	sd	s1,72(sp)
 4d0:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 4d2:	0005c483          	lbu	s1,0(a1)
 4d6:	2a048063          	beqz	s1,776 <vprintf+0x2ae>
 4da:	e0ca                	sd	s2,64(sp)
 4dc:	fc4e                	sd	s3,56(sp)
 4de:	f852                	sd	s4,48(sp)
 4e0:	f456                	sd	s5,40(sp)
 4e2:	f05a                	sd	s6,32(sp)
 4e4:	ec5e                	sd	s7,24(sp)
 4e6:	e862                	sd	s8,16(sp)
 4e8:	8b2a                	mv	s6,a0
 4ea:	8a2e                	mv	s4,a1
 4ec:	8bb2                	mv	s7,a2
  state = 0;
 4ee:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 4f0:	4901                	li	s2,0
 4f2:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 4f4:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 4f8:	06400c13          	li	s8,100
 4fc:	a00d                	j	51e <vprintf+0x56>
        putc(fd, c0);
 4fe:	85a6                	mv	a1,s1
 500:	855a                	mv	a0,s6
 502:	f09ff0ef          	jal	40a <putc>
 506:	a019                	j	50c <vprintf+0x44>
    } else if (state == '%') {
 508:	03598363          	beq	s3,s5,52e <vprintf+0x66>
  for (i = 0; fmt[i]; i++) {
 50c:	0019079b          	addiw	a5,s2,1
 510:	893e                	mv	s2,a5
 512:	873e                	mv	a4,a5
 514:	97d2                	add	a5,a5,s4
 516:	0007c483          	lbu	s1,0(a5)
 51a:	24048763          	beqz	s1,768 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 51e:	0004879b          	sext.w	a5,s1
    if (state == 0) {
 522:	fe0993e3          	bnez	s3,508 <vprintf+0x40>
      if (c0 == '%') {
 526:	fd579ce3          	bne	a5,s5,4fe <vprintf+0x36>
        state = '%';
 52a:	89be                	mv	s3,a5
 52c:	b7c5                	j	50c <vprintf+0x44>
        c1 = fmt[i + 1] & 0xff;
 52e:	00ea06b3          	add	a3,s4,a4
 532:	0016c603          	lbu	a2,1(a3)
      if (c1)
 536:	24060563          	beqz	a2,780 <vprintf+0x2b8>
      if (c0 == 'd') {
 53a:	0b878763          	beq	a5,s8,5e8 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 53e:	f9478693          	addi	a3,a5,-108
 542:	0016b693          	seqz	a3,a3
 546:	f9c60593          	addi	a1,a2,-100
 54a:	0015b593          	seqz	a1,a1
 54e:	8df5                	and	a1,a1,a3
 550:	e9c5                	bnez	a1,600 <vprintf+0x138>
        c2 = fmt[i + 2] & 0xff;
 552:	9752                	add	a4,a4,s4
 554:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 558:	f9460713          	addi	a4,a2,-108
 55c:	00173713          	seqz	a4,a4
 560:	8f75                	and	a4,a4,a3
 562:	f9c50593          	addi	a1,a0,-100
 566:	0015b593          	seqz	a1,a1
 56a:	8df9                	and	a1,a1,a4
 56c:	e5dd                	bnez	a1,61a <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 56e:	07500593          	li	a1,117
 572:	0cb78163          	beq	a5,a1,634 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if (c0 == 'l' && c1 == 'u') {
 576:	f8b60593          	addi	a1,a2,-117
 57a:	0015b593          	seqz	a1,a1
 57e:	8df5                	and	a1,a1,a3
 580:	e5f1                	bnez	a1,64c <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 582:	f8b50593          	addi	a1,a0,-117
 586:	0015b593          	seqz	a1,a1
 58a:	8df9                	and	a1,a1,a4
 58c:	ede9                	bnez	a1,666 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 58e:	07800593          	li	a1,120
 592:	0eb78763          	beq	a5,a1,680 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if (c0 == 'l' && c1 == 'x') {
 596:	f8860613          	addi	a2,a2,-120
 59a:	00163613          	seqz	a2,a2
 59e:	8ef1                	and	a3,a3,a2
 5a0:	0e069c63          	bnez	a3,698 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 5a4:	f8850513          	addi	a0,a0,-120
 5a8:	00153513          	seqz	a0,a0
 5ac:	8f69                	and	a4,a4,a0
 5ae:	10071263          	bnez	a4,6b2 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 5b2:	07000713          	li	a4,112
 5b6:	10e78a63          	beq	a5,a4,6ca <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 5ba:	06300713          	li	a4,99
 5be:	14e78a63          	beq	a5,a4,712 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 5c2:	07300713          	li	a4,115
 5c6:	16e78063          	beq	a5,a4,726 <vprintf+0x25e>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 5ca:	02500713          	li	a4,37
 5ce:	18e78863          	beq	a5,a4,75e <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5d2:	02500593          	li	a1,37
 5d6:	855a                	mv	a0,s6
 5d8:	e33ff0ef          	jal	40a <putc>
        putc(fd, c0);
 5dc:	85a6                	mv	a1,s1
 5de:	855a                	mv	a0,s6
 5e0:	e2bff0ef          	jal	40a <putc>
      }

      state = 0;
 5e4:	4981                	li	s3,0
 5e6:	b71d                	j	50c <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 5e8:	008b8493          	addi	s1,s7,8
 5ec:	4685                	li	a3,1
 5ee:	4629                	li	a2,10
 5f0:	000ba583          	lw	a1,0(s7)
 5f4:	855a                	mv	a0,s6
 5f6:	e33ff0ef          	jal	428 <printint>
 5fa:	8ba6                	mv	s7,s1
      state = 0;
 5fc:	4981                	li	s3,0
 5fe:	b739                	j	50c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 600:	008b8493          	addi	s1,s7,8
 604:	4685                	li	a3,1
 606:	4629                	li	a2,10
 608:	000bb583          	ld	a1,0(s7)
 60c:	855a                	mv	a0,s6
 60e:	e1bff0ef          	jal	428 <printint>
        i += 1;
 612:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 614:	8ba6                	mv	s7,s1
      state = 0;
 616:	4981                	li	s3,0
 618:	bdd5                	j	50c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 61a:	008b8493          	addi	s1,s7,8
 61e:	4685                	li	a3,1
 620:	4629                	li	a2,10
 622:	000bb583          	ld	a1,0(s7)
 626:	855a                	mv	a0,s6
 628:	e01ff0ef          	jal	428 <printint>
        i += 2;
 62c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 62e:	8ba6                	mv	s7,s1
      state = 0;
 630:	4981                	li	s3,0
        i += 2;
 632:	bde9                	j	50c <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 634:	008b8493          	addi	s1,s7,8
 638:	4681                	li	a3,0
 63a:	4629                	li	a2,10
 63c:	000be583          	lwu	a1,0(s7)
 640:	855a                	mv	a0,s6
 642:	de7ff0ef          	jal	428 <printint>
 646:	8ba6                	mv	s7,s1
      state = 0;
 648:	4981                	li	s3,0
 64a:	b5c9                	j	50c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 64c:	008b8493          	addi	s1,s7,8
 650:	4681                	li	a3,0
 652:	4629                	li	a2,10
 654:	000bb583          	ld	a1,0(s7)
 658:	855a                	mv	a0,s6
 65a:	dcfff0ef          	jal	428 <printint>
        i += 1;
 65e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 660:	8ba6                	mv	s7,s1
      state = 0;
 662:	4981                	li	s3,0
 664:	b565                	j	50c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 666:	008b8493          	addi	s1,s7,8
 66a:	4681                	li	a3,0
 66c:	4629                	li	a2,10
 66e:	000bb583          	ld	a1,0(s7)
 672:	855a                	mv	a0,s6
 674:	db5ff0ef          	jal	428 <printint>
        i += 2;
 678:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 67a:	8ba6                	mv	s7,s1
      state = 0;
 67c:	4981                	li	s3,0
        i += 2;
 67e:	b579                	j	50c <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 680:	008b8493          	addi	s1,s7,8
 684:	4681                	li	a3,0
 686:	4641                	li	a2,16
 688:	000be583          	lwu	a1,0(s7)
 68c:	855a                	mv	a0,s6
 68e:	d9bff0ef          	jal	428 <printint>
 692:	8ba6                	mv	s7,s1
      state = 0;
 694:	4981                	li	s3,0
 696:	bd9d                	j	50c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 698:	008b8493          	addi	s1,s7,8
 69c:	4681                	li	a3,0
 69e:	4641                	li	a2,16
 6a0:	000bb583          	ld	a1,0(s7)
 6a4:	855a                	mv	a0,s6
 6a6:	d83ff0ef          	jal	428 <printint>
        i += 1;
 6aa:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6ac:	8ba6                	mv	s7,s1
      state = 0;
 6ae:	4981                	li	s3,0
 6b0:	bdb1                	j	50c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6b2:	008b8493          	addi	s1,s7,8
 6b6:	4641                	li	a2,16
 6b8:	000bb583          	ld	a1,0(s7)
 6bc:	855a                	mv	a0,s6
 6be:	d6bff0ef          	jal	428 <printint>
        i += 2;
 6c2:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6c4:	8ba6                	mv	s7,s1
      state = 0;
 6c6:	4981                	li	s3,0
        i += 2;
 6c8:	b591                	j	50c <vprintf+0x44>
 6ca:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 6cc:	008b8793          	addi	a5,s7,8
 6d0:	8cbe                	mv	s9,a5
 6d2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6d6:	03000593          	li	a1,48
 6da:	855a                	mv	a0,s6
 6dc:	d2fff0ef          	jal	40a <putc>
  putc(fd, 'x');
 6e0:	07800593          	li	a1,120
 6e4:	855a                	mv	a0,s6
 6e6:	d25ff0ef          	jal	40a <putc>
 6ea:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6ec:	00000b97          	auipc	s7,0x0
 6f0:	2ecb8b93          	addi	s7,s7,748 # 9d8 <digits>
 6f4:	03c9d793          	srli	a5,s3,0x3c
 6f8:	97de                	add	a5,a5,s7
 6fa:	0007c583          	lbu	a1,0(a5)
 6fe:	855a                	mv	a0,s6
 700:	d0bff0ef          	jal	40a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 704:	0992                	slli	s3,s3,0x4
 706:	34fd                	addiw	s1,s1,-1
 708:	f4f5                	bnez	s1,6f4 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 70a:	8be6                	mv	s7,s9
      state = 0;
 70c:	4981                	li	s3,0
 70e:	6ca2                	ld	s9,8(sp)
 710:	bbf5                	j	50c <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 712:	008b8493          	addi	s1,s7,8
 716:	000bc583          	lbu	a1,0(s7)
 71a:	855a                	mv	a0,s6
 71c:	cefff0ef          	jal	40a <putc>
 720:	8ba6                	mv	s7,s1
      state = 0;
 722:	4981                	li	s3,0
 724:	b3e5                	j	50c <vprintf+0x44>
        if ((s = va_arg(ap, char *)) == 0)
 726:	008b8993          	addi	s3,s7,8
 72a:	000bb483          	ld	s1,0(s7)
 72e:	cc91                	beqz	s1,74a <vprintf+0x282>
        for (; *s; s++)
 730:	0004c583          	lbu	a1,0(s1)
 734:	c195                	beqz	a1,758 <vprintf+0x290>
          putc(fd, *s);
 736:	855a                	mv	a0,s6
 738:	cd3ff0ef          	jal	40a <putc>
        for (; *s; s++)
 73c:	0485                	addi	s1,s1,1
 73e:	0004c583          	lbu	a1,0(s1)
 742:	f9f5                	bnez	a1,736 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 744:	8bce                	mv	s7,s3
      state = 0;
 746:	4981                	li	s3,0
 748:	b3d1                	j	50c <vprintf+0x44>
          s = "(null)";
 74a:	00000497          	auipc	s1,0x0
 74e:	28648493          	addi	s1,s1,646 # 9d0 <malloc+0x154>
        for (; *s; s++)
 752:	02800593          	li	a1,40
 756:	b7c5                	j	736 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 758:	8bce                	mv	s7,s3
      state = 0;
 75a:	4981                	li	s3,0
 75c:	bb45                	j	50c <vprintf+0x44>
        putc(fd, '%');
 75e:	85be                	mv	a1,a5
 760:	855a                	mv	a0,s6
 762:	ca9ff0ef          	jal	40a <putc>
 766:	bdbd                	j	5e4 <vprintf+0x11c>
 768:	6906                	ld	s2,64(sp)
 76a:	79e2                	ld	s3,56(sp)
 76c:	7a42                	ld	s4,48(sp)
 76e:	7aa2                	ld	s5,40(sp)
 770:	7b02                	ld	s6,32(sp)
 772:	6be2                	ld	s7,24(sp)
 774:	6c42                	ld	s8,16(sp)
    }
  }
}
 776:	60e6                	ld	ra,88(sp)
 778:	6446                	ld	s0,80(sp)
 77a:	64a6                	ld	s1,72(sp)
 77c:	6125                	addi	sp,sp,96
 77e:	8082                	ret
      if (c0 == 'd') {
 780:	06400713          	li	a4,100
 784:	e6e782e3          	beq	a5,a4,5e8 <vprintf+0x120>
      } else if (c0 == 'l' && c1 == 'd') {
 788:	f9478693          	addi	a3,a5,-108
 78c:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 790:	8532                	mv	a0,a2
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 792:	4701                	li	a4,0
 794:	bbe9                	j	56e <vprintf+0xa6>

0000000000000796 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 796:	715d                	addi	sp,sp,-80
 798:	ec06                	sd	ra,24(sp)
 79a:	e822                	sd	s0,16(sp)
 79c:	1000                	addi	s0,sp,32
 79e:	e010                	sd	a2,0(s0)
 7a0:	e414                	sd	a3,8(s0)
 7a2:	e818                	sd	a4,16(s0)
 7a4:	ec1c                	sd	a5,24(s0)
 7a6:	03043023          	sd	a6,32(s0)
 7aa:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7ae:	8622                	mv	a2,s0
 7b0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7b4:	d15ff0ef          	jal	4c8 <vprintf>
}
 7b8:	60e2                	ld	ra,24(sp)
 7ba:	6442                	ld	s0,16(sp)
 7bc:	6161                	addi	sp,sp,80
 7be:	8082                	ret

00000000000007c0 <printf>:

void
printf(const char *fmt, ...)
{
 7c0:	711d                	addi	sp,sp,-96
 7c2:	ec06                	sd	ra,24(sp)
 7c4:	e822                	sd	s0,16(sp)
 7c6:	1000                	addi	s0,sp,32
 7c8:	e40c                	sd	a1,8(s0)
 7ca:	e810                	sd	a2,16(s0)
 7cc:	ec14                	sd	a3,24(s0)
 7ce:	f018                	sd	a4,32(s0)
 7d0:	f41c                	sd	a5,40(s0)
 7d2:	03043823          	sd	a6,48(s0)
 7d6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7da:	00840613          	addi	a2,s0,8
 7de:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7e2:	85aa                	mv	a1,a0
 7e4:	4505                	li	a0,1
 7e6:	ce3ff0ef          	jal	4c8 <vprintf>
}
 7ea:	60e2                	ld	ra,24(sp)
 7ec:	6442                	ld	s0,16(sp)
 7ee:	6125                	addi	sp,sp,96
 7f0:	8082                	ret

00000000000007f2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7f2:	1141                	addi	sp,sp,-16
 7f4:	e406                	sd	ra,8(sp)
 7f6:	e022                	sd	s0,0(sp)
 7f8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 7fa:	ff050713          	addi	a4,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7fe:	00001797          	auipc	a5,0x1
 802:	8027b783          	ld	a5,-2046(a5) # 1000 <freep>
 806:	a095                	j	86a <free+0x78>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
 808:	ff852583          	lw	a1,-8(a0)
 80c:	6390                	ld	a2,0(a5)
 80e:	02059813          	slli	a6,a1,0x20
 812:	01c85693          	srli	a3,a6,0x1c
 816:	96ba                	add	a3,a3,a4
 818:	02d60563          	beq	a2,a3,842 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 81c:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
 820:	4790                	lw	a2,8(a5)
 822:	02061593          	slli	a1,a2,0x20
 826:	01c5d693          	srli	a3,a1,0x1c
 82a:	96be                	add	a3,a3,a5
 82c:	02d70263          	beq	a4,a3,850 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 830:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 832:	00000717          	auipc	a4,0x0
 836:	7cf73723          	sd	a5,1998(a4) # 1000 <freep>
}
 83a:	60a2                	ld	ra,8(sp)
 83c:	6402                	ld	s0,0(sp)
 83e:	0141                	addi	sp,sp,16
 840:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 842:	4614                	lw	a3,8(a2)
 844:	9ead                	addw	a3,a3,a1
 846:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 84a:	6394                	ld	a3,0(a5)
 84c:	6290                	ld	a2,0(a3)
 84e:	b7f9                	j	81c <free+0x2a>
    p->s.size += bp->s.size;
 850:	ff852703          	lw	a4,-8(a0)
 854:	9f31                	addw	a4,a4,a2
 856:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 858:	ff053703          	ld	a4,-16(a0)
 85c:	bfd1                	j	830 <free+0x3e>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 85e:	6394                	ld	a3,0(a5)
 860:	00d7e463          	bltu	a5,a3,868 <free+0x76>
 864:	fad762e3          	bltu	a4,a3,808 <free+0x16>
 868:	87b6                	mv	a5,a3
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 86a:	fee7fae3          	bgeu	a5,a4,85e <free+0x6c>
 86e:	6394                	ld	a3,0(a5)
 870:	f8d76ce3          	bltu	a4,a3,808 <free+0x16>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 874:	f8d7fae3          	bgeu	a5,a3,808 <free+0x16>
 878:	87b6                	mv	a5,a3
 87a:	bfc5                	j	86a <free+0x78>

000000000000087c <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
 87c:	7139                	addi	sp,sp,-64
 87e:	fc06                	sd	ra,56(sp)
 880:	f822                	sd	s0,48(sp)
 882:	f04a                	sd	s2,32(sp)
 884:	ec4e                	sd	s3,24(sp)
 886:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 888:	02051993          	slli	s3,a0,0x20
 88c:	0209d993          	srli	s3,s3,0x20
 890:	09bd                	addi	s3,s3,15
 892:	0049d993          	srli	s3,s3,0x4
 896:	2985                	addiw	s3,s3,1
 898:	894e                	mv	s2,s3
  if ((prevp = freep) == 0) {
 89a:	00000517          	auipc	a0,0x0
 89e:	76653503          	ld	a0,1894(a0) # 1000 <freep>
 8a2:	c905                	beqz	a0,8d2 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 8a4:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 8a6:	4798                	lw	a4,8(a5)
 8a8:	09377663          	bgeu	a4,s3,934 <malloc+0xb8>
 8ac:	f426                	sd	s1,40(sp)
 8ae:	e852                	sd	s4,16(sp)
 8b0:	e456                	sd	s5,8(sp)
 8b2:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 8b4:	8a4e                	mv	s4,s3
 8b6:	6705                	lui	a4,0x1
 8b8:	00e9f363          	bgeu	s3,a4,8be <malloc+0x42>
 8bc:	6a05                	lui	s4,0x1
 8be:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8c2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 8c6:	00000497          	auipc	s1,0x0
 8ca:	73a48493          	addi	s1,s1,1850 # 1000 <freep>
  if (p == SBRK_ERROR)
 8ce:	5afd                	li	s5,-1
 8d0:	a83d                	j	90e <malloc+0x92>
 8d2:	f426                	sd	s1,40(sp)
 8d4:	e852                	sd	s4,16(sp)
 8d6:	e456                	sd	s5,8(sp)
 8d8:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8da:	00000797          	auipc	a5,0x0
 8de:	73678793          	addi	a5,a5,1846 # 1010 <base>
 8e2:	00000717          	auipc	a4,0x0
 8e6:	70f73f23          	sd	a5,1822(a4) # 1000 <freep>
 8ea:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8ec:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 8f0:	b7d1                	j	8b4 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8f2:	6398                	ld	a4,0(a5)
 8f4:	e118                	sd	a4,0(a0)
 8f6:	a899                	j	94c <malloc+0xd0>
  hp->s.size = nu;
 8f8:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 8fc:	0541                	addi	a0,a0,16
 8fe:	ef5ff0ef          	jal	7f2 <free>
  return freep;
 902:	6088                	ld	a0,0(s1)
      if ((p = morecore(nunits)) == 0)
 904:	c125                	beqz	a0,964 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 906:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 908:	4798                	lw	a4,8(a5)
 90a:	03277163          	bgeu	a4,s2,92c <malloc+0xb0>
    if (p == freep)
 90e:	6098                	ld	a4,0(s1)
 910:	853e                	mv	a0,a5
 912:	fef71ae3          	bne	a4,a5,906 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 916:	8552                	mv	a0,s4
 918:	9ffff0ef          	jal	316 <sbrk>
  if (p == SBRK_ERROR)
 91c:	fd551ee3          	bne	a0,s5,8f8 <malloc+0x7c>
        return 0;
 920:	4501                	li	a0,0
 922:	74a2                	ld	s1,40(sp)
 924:	6a42                	ld	s4,16(sp)
 926:	6aa2                	ld	s5,8(sp)
 928:	6b02                	ld	s6,0(sp)
 92a:	a03d                	j	958 <malloc+0xdc>
 92c:	74a2                	ld	s1,40(sp)
 92e:	6a42                	ld	s4,16(sp)
 930:	6aa2                	ld	s5,8(sp)
 932:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
 934:	fae90fe3          	beq	s2,a4,8f2 <malloc+0x76>
        p->s.size -= nunits;
 938:	4137073b          	subw	a4,a4,s3
 93c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 93e:	02071693          	slli	a3,a4,0x20
 942:	01c6d713          	srli	a4,a3,0x1c
 946:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 948:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 94c:	00000717          	auipc	a4,0x0
 950:	6aa73a23          	sd	a0,1716(a4) # 1000 <freep>
      return (void *)(p + 1);
 954:	01078513          	addi	a0,a5,16
  }
}
 958:	70e2                	ld	ra,56(sp)
 95a:	7442                	ld	s0,48(sp)
 95c:	7902                	ld	s2,32(sp)
 95e:	69e2                	ld	s3,24(sp)
 960:	6121                	addi	sp,sp,64
 962:	8082                	ret
 964:	74a2                	ld	s1,40(sp)
 966:	6a42                	ld	s4,16(sp)
 968:	6aa2                	ld	s5,8(sp)
 96a:	6b02                	ld	s6,0(sp)
 96c:	b7f5                	j	958 <malloc+0xdc>
