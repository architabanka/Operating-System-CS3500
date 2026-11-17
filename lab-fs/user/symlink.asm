
user/_symlink:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"

#ifdef SYS_symlink
int
main(int argc, char *argv[])
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if (argc != 3) {
   8:	470d                	li	a4,3
   a:	00e50b63          	beq	a0,a4,20 <main+0x20>
    printf("usage: symlink target linkpath\n");
   e:	00001517          	auipc	a0,0x1
  12:	91250513          	addi	a0,a0,-1774 # 920 <malloc+0xf2>
  16:	75c000ef          	jal	772 <printf>
    exit(1);
  1a:	4505                	li	a0,1
  1c:	2e0000ef          	jal	2fc <exit>
  20:	87ae                	mv	a5,a1
  }

  if (symlink(argv[1], argv[2]) < 0) {
  22:	698c                	ld	a1,16(a1)
  24:	6788                	ld	a0,8(a5)
  26:	38e000ef          	jal	3b4 <symlink>
  2a:	00054563          	bltz	a0,34 <main+0x34>
    printf("symlink: failed\n");
    exit(1);
  }

  exit(0);
  2e:	4501                	li	a0,0
  30:	2cc000ef          	jal	2fc <exit>
    printf("symlink: failed\n");
  34:	00001517          	auipc	a0,0x1
  38:	90c50513          	addi	a0,a0,-1780 # 940 <malloc+0x112>
  3c:	736000ef          	jal	772 <printf>
    exit(1);
  40:	4505                	li	a0,1
  42:	2ba000ef          	jal	2fc <exit>

0000000000000046 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  46:	1141                	addi	sp,sp,-16
  48:	e406                	sd	ra,8(sp)
  4a:	e022                	sd	s0,0(sp)
  4c:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  4e:	fb3ff0ef          	jal	0 <main>
  exit(r);
  52:	2aa000ef          	jal	2fc <exit>

0000000000000056 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  56:	1141                	addi	sp,sp,-16
  58:	e406                	sd	ra,8(sp)
  5a:	e022                	sd	s0,0(sp)
  5c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  5e:	87aa                	mv	a5,a0
  60:	0585                	addi	a1,a1,1
  62:	0785                	addi	a5,a5,1
  64:	fff5c703          	lbu	a4,-1(a1)
  68:	fee78fa3          	sb	a4,-1(a5)
  6c:	fb75                	bnez	a4,60 <strcpy+0xa>
    ;
  return os;
}
  6e:	60a2                	ld	ra,8(sp)
  70:	6402                	ld	s0,0(sp)
  72:	0141                	addi	sp,sp,16
  74:	8082                	ret

0000000000000076 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  76:	1141                	addi	sp,sp,-16
  78:	e406                	sd	ra,8(sp)
  7a:	e022                	sd	s0,0(sp)
  7c:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  7e:	00054783          	lbu	a5,0(a0)
  82:	cb91                	beqz	a5,96 <strcmp+0x20>
  84:	0005c703          	lbu	a4,0(a1)
  88:	00f71763          	bne	a4,a5,96 <strcmp+0x20>
    p++, q++;
  8c:	0505                	addi	a0,a0,1
  8e:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  90:	00054783          	lbu	a5,0(a0)
  94:	fbe5                	bnez	a5,84 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  96:	0005c503          	lbu	a0,0(a1)
}
  9a:	40a7853b          	subw	a0,a5,a0
  9e:	60a2                	ld	ra,8(sp)
  a0:	6402                	ld	s0,0(sp)
  a2:	0141                	addi	sp,sp,16
  a4:	8082                	ret

00000000000000a6 <strlen>:

uint
strlen(const char *s)
{
  a6:	1141                	addi	sp,sp,-16
  a8:	e406                	sd	ra,8(sp)
  aa:	e022                	sd	s0,0(sp)
  ac:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  ae:	00054783          	lbu	a5,0(a0)
  b2:	cf91                	beqz	a5,ce <strlen+0x28>
  b4:	00150793          	addi	a5,a0,1
  b8:	86be                	mv	a3,a5
  ba:	0785                	addi	a5,a5,1
  bc:	fff7c703          	lbu	a4,-1(a5)
  c0:	ff65                	bnez	a4,b8 <strlen+0x12>
  c2:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  c6:	60a2                	ld	ra,8(sp)
  c8:	6402                	ld	s0,0(sp)
  ca:	0141                	addi	sp,sp,16
  cc:	8082                	ret
  for (n = 0; s[n]; n++)
  ce:	4501                	li	a0,0
  d0:	bfdd                	j	c6 <strlen+0x20>

00000000000000d2 <memset>:

void *
memset(void *dst, int c, uint n)
{
  d2:	1141                	addi	sp,sp,-16
  d4:	e406                	sd	ra,8(sp)
  d6:	e022                	sd	s0,0(sp)
  d8:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
  da:	ca19                	beqz	a2,f0 <memset+0x1e>
  dc:	87aa                	mv	a5,a0
  de:	1602                	slli	a2,a2,0x20
  e0:	9201                	srli	a2,a2,0x20
  e2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  e6:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
  ea:	0785                	addi	a5,a5,1
  ec:	fee79de3          	bne	a5,a4,e6 <memset+0x14>
  }
  return dst;
}
  f0:	60a2                	ld	ra,8(sp)
  f2:	6402                	ld	s0,0(sp)
  f4:	0141                	addi	sp,sp,16
  f6:	8082                	ret

00000000000000f8 <strchr>:

char *
strchr(const char *s, char c)
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e406                	sd	ra,8(sp)
  fc:	e022                	sd	s0,0(sp)
  fe:	0800                	addi	s0,sp,16
  for (; *s; s++)
 100:	00054783          	lbu	a5,0(a0)
 104:	c799                	beqz	a5,112 <strchr+0x1a>
    if (*s == c)
 106:	00f58763          	beq	a1,a5,114 <strchr+0x1c>
  for (; *s; s++)
 10a:	0505                	addi	a0,a0,1
 10c:	00054783          	lbu	a5,0(a0)
 110:	fbfd                	bnez	a5,106 <strchr+0xe>
      return (char *)s;
  return 0;
 112:	4501                	li	a0,0
}
 114:	60a2                	ld	ra,8(sp)
 116:	6402                	ld	s0,0(sp)
 118:	0141                	addi	sp,sp,16
 11a:	8082                	ret

000000000000011c <gets>:

char *
gets(char *buf, int max)
{
 11c:	711d                	addi	sp,sp,-96
 11e:	ec86                	sd	ra,88(sp)
 120:	e8a2                	sd	s0,80(sp)
 122:	e4a6                	sd	s1,72(sp)
 124:	e0ca                	sd	s2,64(sp)
 126:	fc4e                	sd	s3,56(sp)
 128:	f852                	sd	s4,48(sp)
 12a:	f456                	sd	s5,40(sp)
 12c:	f05a                	sd	s6,32(sp)
 12e:	ec5e                	sd	s7,24(sp)
 130:	e862                	sd	s8,16(sp)
 132:	1080                	addi	s0,sp,96
 134:	8baa                	mv	s7,a0
 136:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 138:	892a                	mv	s2,a0
 13a:	4481                	li	s1,0
    cc = read(0, &c, 1);
 13c:	faf40b13          	addi	s6,s0,-81
 140:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;) {
 142:	8c26                	mv	s8,s1
 144:	0014899b          	addiw	s3,s1,1
 148:	84ce                	mv	s1,s3
 14a:	0349d863          	bge	s3,s4,17a <gets+0x5e>
    cc = read(0, &c, 1);
 14e:	8656                	mv	a2,s5
 150:	85da                	mv	a1,s6
 152:	4501                	li	a0,0
 154:	1c0000ef          	jal	314 <read>
    if (cc < 1)
 158:	02a05163          	blez	a0,17a <gets+0x5e>
      break;
    buf[i++] = c;
 15c:	faf44783          	lbu	a5,-81(s0)
 160:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 164:	0905                	addi	s2,s2,1
 166:	ff678713          	addi	a4,a5,-10
 16a:	00173713          	seqz	a4,a4
 16e:	17cd                	addi	a5,a5,-13
 170:	0017b793          	seqz	a5,a5
 174:	8fd9                	or	a5,a5,a4
 176:	d7f1                	beqz	a5,142 <gets+0x26>
    buf[i++] = c;
 178:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 17a:	9c5e                	add	s8,s8,s7
 17c:	000c0023          	sb	zero,0(s8)
  return buf;
}
 180:	855e                	mv	a0,s7
 182:	60e6                	ld	ra,88(sp)
 184:	6446                	ld	s0,80(sp)
 186:	64a6                	ld	s1,72(sp)
 188:	6906                	ld	s2,64(sp)
 18a:	79e2                	ld	s3,56(sp)
 18c:	7a42                	ld	s4,48(sp)
 18e:	7aa2                	ld	s5,40(sp)
 190:	7b02                	ld	s6,32(sp)
 192:	6be2                	ld	s7,24(sp)
 194:	6c42                	ld	s8,16(sp)
 196:	6125                	addi	sp,sp,96
 198:	8082                	ret

000000000000019a <stat>:

int
stat(const char *n, struct stat *st)
{
 19a:	1101                	addi	sp,sp,-32
 19c:	ec06                	sd	ra,24(sp)
 19e:	e822                	sd	s0,16(sp)
 1a0:	e04a                	sd	s2,0(sp)
 1a2:	1000                	addi	s0,sp,32
 1a4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a6:	4581                	li	a1,0
 1a8:	194000ef          	jal	33c <open>
  if (fd < 0)
 1ac:	02054263          	bltz	a0,1d0 <stat+0x36>
 1b0:	e426                	sd	s1,8(sp)
 1b2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1b4:	85ca                	mv	a1,s2
 1b6:	19e000ef          	jal	354 <fstat>
 1ba:	892a                	mv	s2,a0
  close(fd);
 1bc:	8526                	mv	a0,s1
 1be:	166000ef          	jal	324 <close>
  return r;
 1c2:	64a2                	ld	s1,8(sp)
}
 1c4:	854a                	mv	a0,s2
 1c6:	60e2                	ld	ra,24(sp)
 1c8:	6442                	ld	s0,16(sp)
 1ca:	6902                	ld	s2,0(sp)
 1cc:	6105                	addi	sp,sp,32
 1ce:	8082                	ret
    return -1;
 1d0:	57fd                	li	a5,-1
 1d2:	893e                	mv	s2,a5
 1d4:	bfc5                	j	1c4 <stat+0x2a>

00000000000001d6 <atoi>:

int
atoi(const char *s)
{
 1d6:	1141                	addi	sp,sp,-16
 1d8:	e406                	sd	ra,8(sp)
 1da:	e022                	sd	s0,0(sp)
 1dc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 1de:	00054683          	lbu	a3,0(a0)
 1e2:	fd06879b          	addiw	a5,a3,-48
 1e6:	0ff7f793          	zext.b	a5,a5
 1ea:	4625                	li	a2,9
 1ec:	02f66963          	bltu	a2,a5,21e <atoi+0x48>
 1f0:	872a                	mv	a4,a0
  n = 0;
 1f2:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 1f4:	0705                	addi	a4,a4,1
 1f6:	0025179b          	slliw	a5,a0,0x2
 1fa:	9fa9                	addw	a5,a5,a0
 1fc:	0017979b          	slliw	a5,a5,0x1
 200:	9fb5                	addw	a5,a5,a3
 202:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 206:	00074683          	lbu	a3,0(a4)
 20a:	fd06879b          	addiw	a5,a3,-48
 20e:	0ff7f793          	zext.b	a5,a5
 212:	fef671e3          	bgeu	a2,a5,1f4 <atoi+0x1e>
  return n;
}
 216:	60a2                	ld	ra,8(sp)
 218:	6402                	ld	s0,0(sp)
 21a:	0141                	addi	sp,sp,16
 21c:	8082                	ret
  n = 0;
 21e:	4501                	li	a0,0
 220:	bfdd                	j	216 <atoi+0x40>

0000000000000222 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 222:	1141                	addi	sp,sp,-16
 224:	e406                	sd	ra,8(sp)
 226:	e022                	sd	s0,0(sp)
 228:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 22a:	02b57563          	bgeu	a0,a1,254 <memmove+0x32>
    while (n-- > 0)
 22e:	00c05f63          	blez	a2,24c <memmove+0x2a>
 232:	1602                	slli	a2,a2,0x20
 234:	9201                	srli	a2,a2,0x20
 236:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 23a:	872a                	mv	a4,a0
      *dst++ = *src++;
 23c:	0585                	addi	a1,a1,1
 23e:	0705                	addi	a4,a4,1
 240:	fff5c683          	lbu	a3,-1(a1)
 244:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 248:	fee79ae3          	bne	a5,a4,23c <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 24c:	60a2                	ld	ra,8(sp)
 24e:	6402                	ld	s0,0(sp)
 250:	0141                	addi	sp,sp,16
 252:	8082                	ret
    while (n-- > 0)
 254:	fec05ce3          	blez	a2,24c <memmove+0x2a>
    dst += n;
 258:	00c50733          	add	a4,a0,a2
    src += n;
 25c:	95b2                	add	a1,a1,a2
 25e:	fff6079b          	addiw	a5,a2,-1
 262:	1782                	slli	a5,a5,0x20
 264:	9381                	srli	a5,a5,0x20
 266:	fff7c793          	not	a5,a5
 26a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 26c:	15fd                	addi	a1,a1,-1
 26e:	177d                	addi	a4,a4,-1
 270:	0005c683          	lbu	a3,0(a1)
 274:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 278:	fef71ae3          	bne	a4,a5,26c <memmove+0x4a>
 27c:	bfc1                	j	24c <memmove+0x2a>

000000000000027e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 27e:	1141                	addi	sp,sp,-16
 280:	e406                	sd	ra,8(sp)
 282:	e022                	sd	s0,0(sp)
 284:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 286:	ce19                	beqz	a2,2a4 <memcmp+0x26>
 288:	1602                	slli	a2,a2,0x20
 28a:	9201                	srli	a2,a2,0x20
 28c:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 290:	00054783          	lbu	a5,0(a0)
 294:	0005c703          	lbu	a4,0(a1)
 298:	00e79b63          	bne	a5,a4,2ae <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 29c:	0505                	addi	a0,a0,1
    p2++;
 29e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2a0:	fed518e3          	bne	a0,a3,290 <memcmp+0x12>
  }
  return 0;
 2a4:	4501                	li	a0,0
}
 2a6:	60a2                	ld	ra,8(sp)
 2a8:	6402                	ld	s0,0(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret
      return *p1 - *p2;
 2ae:	40e7853b          	subw	a0,a5,a4
 2b2:	bfd5                	j	2a6 <memcmp+0x28>

00000000000002b4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2b4:	1141                	addi	sp,sp,-16
 2b6:	e406                	sd	ra,8(sp)
 2b8:	e022                	sd	s0,0(sp)
 2ba:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2bc:	f67ff0ef          	jal	222 <memmove>
}
 2c0:	60a2                	ld	ra,8(sp)
 2c2:	6402                	ld	s0,0(sp)
 2c4:	0141                	addi	sp,sp,16
 2c6:	8082                	ret

00000000000002c8 <sbrk>:

char *
sbrk(int n)
{
 2c8:	1141                	addi	sp,sp,-16
 2ca:	e406                	sd	ra,8(sp)
 2cc:	e022                	sd	s0,0(sp)
 2ce:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2d0:	4585                	li	a1,1
 2d2:	0b2000ef          	jal	384 <sys_sbrk>
}
 2d6:	60a2                	ld	ra,8(sp)
 2d8:	6402                	ld	s0,0(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret

00000000000002de <sbrklazy>:

char *
sbrklazy(int n)
{
 2de:	1141                	addi	sp,sp,-16
 2e0:	e406                	sd	ra,8(sp)
 2e2:	e022                	sd	s0,0(sp)
 2e4:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 2e6:	4589                	li	a1,2
 2e8:	09c000ef          	jal	384 <sys_sbrk>
}
 2ec:	60a2                	ld	ra,8(sp)
 2ee:	6402                	ld	s0,0(sp)
 2f0:	0141                	addi	sp,sp,16
 2f2:	8082                	ret

00000000000002f4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2f4:	4885                	li	a7,1
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <exit>:
.global exit
exit:
 li a7, SYS_exit
 2fc:	4889                	li	a7,2
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <wait>:
.global wait
wait:
 li a7, SYS_wait
 304:	488d                	li	a7,3
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 30c:	4891                	li	a7,4
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <read>:
.global read
read:
 li a7, SYS_read
 314:	4895                	li	a7,5
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <write>:
.global write
write:
 li a7, SYS_write
 31c:	48c1                	li	a7,16
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <close>:
.global close
close:
 li a7, SYS_close
 324:	48d5                	li	a7,21
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <kill>:
.global kill
kill:
 li a7, SYS_kill
 32c:	4899                	li	a7,6
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <exec>:
.global exec
exec:
 li a7, SYS_exec
 334:	489d                	li	a7,7
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <open>:
.global open
open:
 li a7, SYS_open
 33c:	48bd                	li	a7,15
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 344:	48c5                	li	a7,17
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 34c:	48c9                	li	a7,18
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 354:	48a1                	li	a7,8
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <link>:
.global link
link:
 li a7, SYS_link
 35c:	48cd                	li	a7,19
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 364:	48d1                	li	a7,20
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 36c:	48a5                	li	a7,9
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <dup>:
.global dup
dup:
 li a7, SYS_dup
 374:	48a9                	li	a7,10
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 37c:	48ad                	li	a7,11
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 384:	48b1                	li	a7,12
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <pause>:
.global pause
pause:
 li a7, SYS_pause
 38c:	48b5                	li	a7,13
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 394:	48b9                	li	a7,14
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <sync>:
.global sync
sync:
 li a7, SYS_sync
 39c:	48d9                	li	a7,22
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <istat>:
.global istat
istat:
 li a7, SYS_istat
 3a4:	48dd                	li	a7,23
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <iprint>:
.global iprint
iprint:
 li a7, SYS_iprint
 3ac:	48e1                	li	a7,24
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <symlink>:
.global symlink
symlink:
 li a7, SYS_symlink
 3b4:	48e5                	li	a7,25
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3bc:	1101                	addi	sp,sp,-32
 3be:	ec06                	sd	ra,24(sp)
 3c0:	e822                	sd	s0,16(sp)
 3c2:	1000                	addi	s0,sp,32
 3c4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3c8:	4605                	li	a2,1
 3ca:	fef40593          	addi	a1,s0,-17
 3ce:	f4fff0ef          	jal	31c <write>
}
 3d2:	60e2                	ld	ra,24(sp)
 3d4:	6442                	ld	s0,16(sp)
 3d6:	6105                	addi	sp,sp,32
 3d8:	8082                	ret

00000000000003da <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 3da:	715d                	addi	sp,sp,-80
 3dc:	e486                	sd	ra,72(sp)
 3de:	e0a2                	sd	s0,64(sp)
 3e0:	f84a                	sd	s2,48(sp)
 3e2:	f44e                	sd	s3,40(sp)
 3e4:	0880                	addi	s0,sp,80
 3e6:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 3e8:	00d036b3          	snez	a3,a3
 3ec:	03f5d793          	srli	a5,a1,0x3f
 3f0:	8efd                	and	a3,a3,a5
  neg = 0;
 3f2:	4301                	li	t1,0
  if (sgn && xx < 0) {
 3f4:	c681                	beqz	a3,3fc <printint+0x22>
    neg = 1;
    x = -xx;
 3f6:	40b005b3          	neg	a1,a1
    neg = 1;
 3fa:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 3fc:	fb840993          	addi	s3,s0,-72
  neg = 0;
 400:	86ce                	mv	a3,s3
  i = 0;
 402:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
 404:	00000817          	auipc	a6,0x0
 408:	55c80813          	addi	a6,a6,1372 # 960 <digits>
 40c:	88ba                	mv	a7,a4
 40e:	0017051b          	addiw	a0,a4,1
 412:	872a                	mv	a4,a0
 414:	02c5f7b3          	remu	a5,a1,a2
 418:	97c2                	add	a5,a5,a6
 41a:	0007c783          	lbu	a5,0(a5)
 41e:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
 422:	87ae                	mv	a5,a1
 424:	02c5d5b3          	divu	a1,a1,a2
 428:	0685                	addi	a3,a3,1
 42a:	fec7f1e3          	bgeu	a5,a2,40c <printint+0x32>
  if (neg)
 42e:	00030b63          	beqz	t1,444 <printint+0x6a>
    buf[i++] = '-';
 432:	fd040793          	addi	a5,s0,-48
 436:	953e                	add	a0,a0,a5
 438:	02d00793          	li	a5,45
 43c:	fef50423          	sb	a5,-24(a0)
 440:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
 444:	02e05563          	blez	a4,46e <printint+0x94>
 448:	fc26                	sd	s1,56(sp)
 44a:	377d                	addiw	a4,a4,-1
 44c:	00e984b3          	add	s1,s3,a4
 450:	19fd                	addi	s3,s3,-1
 452:	99ba                	add	s3,s3,a4
 454:	1702                	slli	a4,a4,0x20
 456:	9301                	srli	a4,a4,0x20
 458:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 45c:	0004c583          	lbu	a1,0(s1)
 460:	854a                	mv	a0,s2
 462:	f5bff0ef          	jal	3bc <putc>
  while (--i >= 0)
 466:	14fd                	addi	s1,s1,-1
 468:	ff349ae3          	bne	s1,s3,45c <printint+0x82>
 46c:	74e2                	ld	s1,56(sp)
}
 46e:	60a6                	ld	ra,72(sp)
 470:	6406                	ld	s0,64(sp)
 472:	7942                	ld	s2,48(sp)
 474:	79a2                	ld	s3,40(sp)
 476:	6161                	addi	sp,sp,80
 478:	8082                	ret

000000000000047a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 47a:	711d                	addi	sp,sp,-96
 47c:	ec86                	sd	ra,88(sp)
 47e:	e8a2                	sd	s0,80(sp)
 480:	e4a6                	sd	s1,72(sp)
 482:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 484:	0005c483          	lbu	s1,0(a1)
 488:	2a048063          	beqz	s1,728 <vprintf+0x2ae>
 48c:	e0ca                	sd	s2,64(sp)
 48e:	fc4e                	sd	s3,56(sp)
 490:	f852                	sd	s4,48(sp)
 492:	f456                	sd	s5,40(sp)
 494:	f05a                	sd	s6,32(sp)
 496:	ec5e                	sd	s7,24(sp)
 498:	e862                	sd	s8,16(sp)
 49a:	8b2a                	mv	s6,a0
 49c:	8a2e                	mv	s4,a1
 49e:	8bb2                	mv	s7,a2
  state = 0;
 4a0:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 4a2:	4901                	li	s2,0
 4a4:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 4a6:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 4aa:	06400c13          	li	s8,100
 4ae:	a00d                	j	4d0 <vprintf+0x56>
        putc(fd, c0);
 4b0:	85a6                	mv	a1,s1
 4b2:	855a                	mv	a0,s6
 4b4:	f09ff0ef          	jal	3bc <putc>
 4b8:	a019                	j	4be <vprintf+0x44>
    } else if (state == '%') {
 4ba:	03598363          	beq	s3,s5,4e0 <vprintf+0x66>
  for (i = 0; fmt[i]; i++) {
 4be:	0019079b          	addiw	a5,s2,1
 4c2:	893e                	mv	s2,a5
 4c4:	873e                	mv	a4,a5
 4c6:	97d2                	add	a5,a5,s4
 4c8:	0007c483          	lbu	s1,0(a5)
 4cc:	24048763          	beqz	s1,71a <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 4d0:	0004879b          	sext.w	a5,s1
    if (state == 0) {
 4d4:	fe0993e3          	bnez	s3,4ba <vprintf+0x40>
      if (c0 == '%') {
 4d8:	fd579ce3          	bne	a5,s5,4b0 <vprintf+0x36>
        state = '%';
 4dc:	89be                	mv	s3,a5
 4de:	b7c5                	j	4be <vprintf+0x44>
        c1 = fmt[i + 1] & 0xff;
 4e0:	00ea06b3          	add	a3,s4,a4
 4e4:	0016c603          	lbu	a2,1(a3)
      if (c1)
 4e8:	24060563          	beqz	a2,732 <vprintf+0x2b8>
      if (c0 == 'd') {
 4ec:	0b878763          	beq	a5,s8,59a <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 4f0:	f9478693          	addi	a3,a5,-108
 4f4:	0016b693          	seqz	a3,a3
 4f8:	f9c60593          	addi	a1,a2,-100
 4fc:	0015b593          	seqz	a1,a1
 500:	8df5                	and	a1,a1,a3
 502:	e9c5                	bnez	a1,5b2 <vprintf+0x138>
        c2 = fmt[i + 2] & 0xff;
 504:	9752                	add	a4,a4,s4
 506:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 50a:	f9460713          	addi	a4,a2,-108
 50e:	00173713          	seqz	a4,a4
 512:	8f75                	and	a4,a4,a3
 514:	f9c50593          	addi	a1,a0,-100
 518:	0015b593          	seqz	a1,a1
 51c:	8df9                	and	a1,a1,a4
 51e:	e5dd                	bnez	a1,5cc <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 520:	07500593          	li	a1,117
 524:	0cb78163          	beq	a5,a1,5e6 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if (c0 == 'l' && c1 == 'u') {
 528:	f8b60593          	addi	a1,a2,-117
 52c:	0015b593          	seqz	a1,a1
 530:	8df5                	and	a1,a1,a3
 532:	e5f1                	bnez	a1,5fe <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 534:	f8b50593          	addi	a1,a0,-117
 538:	0015b593          	seqz	a1,a1
 53c:	8df9                	and	a1,a1,a4
 53e:	ede9                	bnez	a1,618 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 540:	07800593          	li	a1,120
 544:	0eb78763          	beq	a5,a1,632 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if (c0 == 'l' && c1 == 'x') {
 548:	f8860613          	addi	a2,a2,-120
 54c:	00163613          	seqz	a2,a2
 550:	8ef1                	and	a3,a3,a2
 552:	0e069c63          	bnez	a3,64a <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 556:	f8850513          	addi	a0,a0,-120
 55a:	00153513          	seqz	a0,a0
 55e:	8f69                	and	a4,a4,a0
 560:	10071263          	bnez	a4,664 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 564:	07000713          	li	a4,112
 568:	10e78a63          	beq	a5,a4,67c <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 56c:	06300713          	li	a4,99
 570:	14e78a63          	beq	a5,a4,6c4 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 574:	07300713          	li	a4,115
 578:	16e78063          	beq	a5,a4,6d8 <vprintf+0x25e>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 57c:	02500713          	li	a4,37
 580:	18e78863          	beq	a5,a4,710 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 584:	02500593          	li	a1,37
 588:	855a                	mv	a0,s6
 58a:	e33ff0ef          	jal	3bc <putc>
        putc(fd, c0);
 58e:	85a6                	mv	a1,s1
 590:	855a                	mv	a0,s6
 592:	e2bff0ef          	jal	3bc <putc>
      }

      state = 0;
 596:	4981                	li	s3,0
 598:	b71d                	j	4be <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 59a:	008b8493          	addi	s1,s7,8
 59e:	4685                	li	a3,1
 5a0:	4629                	li	a2,10
 5a2:	000ba583          	lw	a1,0(s7)
 5a6:	855a                	mv	a0,s6
 5a8:	e33ff0ef          	jal	3da <printint>
 5ac:	8ba6                	mv	s7,s1
      state = 0;
 5ae:	4981                	li	s3,0
 5b0:	b739                	j	4be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5b2:	008b8493          	addi	s1,s7,8
 5b6:	4685                	li	a3,1
 5b8:	4629                	li	a2,10
 5ba:	000bb583          	ld	a1,0(s7)
 5be:	855a                	mv	a0,s6
 5c0:	e1bff0ef          	jal	3da <printint>
        i += 1;
 5c4:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5c6:	8ba6                	mv	s7,s1
      state = 0;
 5c8:	4981                	li	s3,0
 5ca:	bdd5                	j	4be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5cc:	008b8493          	addi	s1,s7,8
 5d0:	4685                	li	a3,1
 5d2:	4629                	li	a2,10
 5d4:	000bb583          	ld	a1,0(s7)
 5d8:	855a                	mv	a0,s6
 5da:	e01ff0ef          	jal	3da <printint>
        i += 2;
 5de:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5e0:	8ba6                	mv	s7,s1
      state = 0;
 5e2:	4981                	li	s3,0
        i += 2;
 5e4:	bde9                	j	4be <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 5e6:	008b8493          	addi	s1,s7,8
 5ea:	4681                	li	a3,0
 5ec:	4629                	li	a2,10
 5ee:	000be583          	lwu	a1,0(s7)
 5f2:	855a                	mv	a0,s6
 5f4:	de7ff0ef          	jal	3da <printint>
 5f8:	8ba6                	mv	s7,s1
      state = 0;
 5fa:	4981                	li	s3,0
 5fc:	b5c9                	j	4be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5fe:	008b8493          	addi	s1,s7,8
 602:	4681                	li	a3,0
 604:	4629                	li	a2,10
 606:	000bb583          	ld	a1,0(s7)
 60a:	855a                	mv	a0,s6
 60c:	dcfff0ef          	jal	3da <printint>
        i += 1;
 610:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 612:	8ba6                	mv	s7,s1
      state = 0;
 614:	4981                	li	s3,0
 616:	b565                	j	4be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 618:	008b8493          	addi	s1,s7,8
 61c:	4681                	li	a3,0
 61e:	4629                	li	a2,10
 620:	000bb583          	ld	a1,0(s7)
 624:	855a                	mv	a0,s6
 626:	db5ff0ef          	jal	3da <printint>
        i += 2;
 62a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 62c:	8ba6                	mv	s7,s1
      state = 0;
 62e:	4981                	li	s3,0
        i += 2;
 630:	b579                	j	4be <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 632:	008b8493          	addi	s1,s7,8
 636:	4681                	li	a3,0
 638:	4641                	li	a2,16
 63a:	000be583          	lwu	a1,0(s7)
 63e:	855a                	mv	a0,s6
 640:	d9bff0ef          	jal	3da <printint>
 644:	8ba6                	mv	s7,s1
      state = 0;
 646:	4981                	li	s3,0
 648:	bd9d                	j	4be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 64a:	008b8493          	addi	s1,s7,8
 64e:	4681                	li	a3,0
 650:	4641                	li	a2,16
 652:	000bb583          	ld	a1,0(s7)
 656:	855a                	mv	a0,s6
 658:	d83ff0ef          	jal	3da <printint>
        i += 1;
 65c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 65e:	8ba6                	mv	s7,s1
      state = 0;
 660:	4981                	li	s3,0
 662:	bdb1                	j	4be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 664:	008b8493          	addi	s1,s7,8
 668:	4641                	li	a2,16
 66a:	000bb583          	ld	a1,0(s7)
 66e:	855a                	mv	a0,s6
 670:	d6bff0ef          	jal	3da <printint>
        i += 2;
 674:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 676:	8ba6                	mv	s7,s1
      state = 0;
 678:	4981                	li	s3,0
        i += 2;
 67a:	b591                	j	4be <vprintf+0x44>
 67c:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 67e:	008b8793          	addi	a5,s7,8
 682:	8cbe                	mv	s9,a5
 684:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 688:	03000593          	li	a1,48
 68c:	855a                	mv	a0,s6
 68e:	d2fff0ef          	jal	3bc <putc>
  putc(fd, 'x');
 692:	07800593          	li	a1,120
 696:	855a                	mv	a0,s6
 698:	d25ff0ef          	jal	3bc <putc>
 69c:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 69e:	00000b97          	auipc	s7,0x0
 6a2:	2c2b8b93          	addi	s7,s7,706 # 960 <digits>
 6a6:	03c9d793          	srli	a5,s3,0x3c
 6aa:	97de                	add	a5,a5,s7
 6ac:	0007c583          	lbu	a1,0(a5)
 6b0:	855a                	mv	a0,s6
 6b2:	d0bff0ef          	jal	3bc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6b6:	0992                	slli	s3,s3,0x4
 6b8:	34fd                	addiw	s1,s1,-1
 6ba:	f4f5                	bnez	s1,6a6 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 6bc:	8be6                	mv	s7,s9
      state = 0;
 6be:	4981                	li	s3,0
 6c0:	6ca2                	ld	s9,8(sp)
 6c2:	bbf5                	j	4be <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 6c4:	008b8493          	addi	s1,s7,8
 6c8:	000bc583          	lbu	a1,0(s7)
 6cc:	855a                	mv	a0,s6
 6ce:	cefff0ef          	jal	3bc <putc>
 6d2:	8ba6                	mv	s7,s1
      state = 0;
 6d4:	4981                	li	s3,0
 6d6:	b3e5                	j	4be <vprintf+0x44>
        if ((s = va_arg(ap, char *)) == 0)
 6d8:	008b8993          	addi	s3,s7,8
 6dc:	000bb483          	ld	s1,0(s7)
 6e0:	cc91                	beqz	s1,6fc <vprintf+0x282>
        for (; *s; s++)
 6e2:	0004c583          	lbu	a1,0(s1)
 6e6:	c195                	beqz	a1,70a <vprintf+0x290>
          putc(fd, *s);
 6e8:	855a                	mv	a0,s6
 6ea:	cd3ff0ef          	jal	3bc <putc>
        for (; *s; s++)
 6ee:	0485                	addi	s1,s1,1
 6f0:	0004c583          	lbu	a1,0(s1)
 6f4:	f9f5                	bnez	a1,6e8 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 6f6:	8bce                	mv	s7,s3
      state = 0;
 6f8:	4981                	li	s3,0
 6fa:	b3d1                	j	4be <vprintf+0x44>
          s = "(null)";
 6fc:	00000497          	auipc	s1,0x0
 700:	25c48493          	addi	s1,s1,604 # 958 <malloc+0x12a>
        for (; *s; s++)
 704:	02800593          	li	a1,40
 708:	b7c5                	j	6e8 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 70a:	8bce                	mv	s7,s3
      state = 0;
 70c:	4981                	li	s3,0
 70e:	bb45                	j	4be <vprintf+0x44>
        putc(fd, '%');
 710:	85be                	mv	a1,a5
 712:	855a                	mv	a0,s6
 714:	ca9ff0ef          	jal	3bc <putc>
 718:	bdbd                	j	596 <vprintf+0x11c>
 71a:	6906                	ld	s2,64(sp)
 71c:	79e2                	ld	s3,56(sp)
 71e:	7a42                	ld	s4,48(sp)
 720:	7aa2                	ld	s5,40(sp)
 722:	7b02                	ld	s6,32(sp)
 724:	6be2                	ld	s7,24(sp)
 726:	6c42                	ld	s8,16(sp)
    }
  }
}
 728:	60e6                	ld	ra,88(sp)
 72a:	6446                	ld	s0,80(sp)
 72c:	64a6                	ld	s1,72(sp)
 72e:	6125                	addi	sp,sp,96
 730:	8082                	ret
      if (c0 == 'd') {
 732:	06400713          	li	a4,100
 736:	e6e782e3          	beq	a5,a4,59a <vprintf+0x120>
      } else if (c0 == 'l' && c1 == 'd') {
 73a:	f9478693          	addi	a3,a5,-108
 73e:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 742:	8532                	mv	a0,a2
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 744:	4701                	li	a4,0
 746:	bbe9                	j	520 <vprintf+0xa6>

0000000000000748 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 748:	715d                	addi	sp,sp,-80
 74a:	ec06                	sd	ra,24(sp)
 74c:	e822                	sd	s0,16(sp)
 74e:	1000                	addi	s0,sp,32
 750:	e010                	sd	a2,0(s0)
 752:	e414                	sd	a3,8(s0)
 754:	e818                	sd	a4,16(s0)
 756:	ec1c                	sd	a5,24(s0)
 758:	03043023          	sd	a6,32(s0)
 75c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 760:	8622                	mv	a2,s0
 762:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 766:	d15ff0ef          	jal	47a <vprintf>
}
 76a:	60e2                	ld	ra,24(sp)
 76c:	6442                	ld	s0,16(sp)
 76e:	6161                	addi	sp,sp,80
 770:	8082                	ret

0000000000000772 <printf>:

void
printf(const char *fmt, ...)
{
 772:	711d                	addi	sp,sp,-96
 774:	ec06                	sd	ra,24(sp)
 776:	e822                	sd	s0,16(sp)
 778:	1000                	addi	s0,sp,32
 77a:	e40c                	sd	a1,8(s0)
 77c:	e810                	sd	a2,16(s0)
 77e:	ec14                	sd	a3,24(s0)
 780:	f018                	sd	a4,32(s0)
 782:	f41c                	sd	a5,40(s0)
 784:	03043823          	sd	a6,48(s0)
 788:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 78c:	00840613          	addi	a2,s0,8
 790:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 794:	85aa                	mv	a1,a0
 796:	4505                	li	a0,1
 798:	ce3ff0ef          	jal	47a <vprintf>
}
 79c:	60e2                	ld	ra,24(sp)
 79e:	6442                	ld	s0,16(sp)
 7a0:	6125                	addi	sp,sp,96
 7a2:	8082                	ret

00000000000007a4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a4:	1141                	addi	sp,sp,-16
 7a6:	e406                	sd	ra,8(sp)
 7a8:	e022                	sd	s0,0(sp)
 7aa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 7ac:	ff050713          	addi	a4,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b0:	00001797          	auipc	a5,0x1
 7b4:	8507b783          	ld	a5,-1968(a5) # 1000 <freep>
 7b8:	a095                	j	81c <free+0x78>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
 7ba:	ff852583          	lw	a1,-8(a0)
 7be:	6390                	ld	a2,0(a5)
 7c0:	02059813          	slli	a6,a1,0x20
 7c4:	01c85693          	srli	a3,a6,0x1c
 7c8:	96ba                	add	a3,a3,a4
 7ca:	02d60563          	beq	a2,a3,7f4 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7ce:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
 7d2:	4790                	lw	a2,8(a5)
 7d4:	02061593          	slli	a1,a2,0x20
 7d8:	01c5d693          	srli	a3,a1,0x1c
 7dc:	96be                	add	a3,a3,a5
 7de:	02d70263          	beq	a4,a3,802 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7e2:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7e4:	00001717          	auipc	a4,0x1
 7e8:	80f73e23          	sd	a5,-2020(a4) # 1000 <freep>
}
 7ec:	60a2                	ld	ra,8(sp)
 7ee:	6402                	ld	s0,0(sp)
 7f0:	0141                	addi	sp,sp,16
 7f2:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 7f4:	4614                	lw	a3,8(a2)
 7f6:	9ead                	addw	a3,a3,a1
 7f8:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7fc:	6394                	ld	a3,0(a5)
 7fe:	6290                	ld	a2,0(a3)
 800:	b7f9                	j	7ce <free+0x2a>
    p->s.size += bp->s.size;
 802:	ff852703          	lw	a4,-8(a0)
 806:	9f31                	addw	a4,a4,a2
 808:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 80a:	ff053703          	ld	a4,-16(a0)
 80e:	bfd1                	j	7e2 <free+0x3e>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 810:	6394                	ld	a3,0(a5)
 812:	00d7e463          	bltu	a5,a3,81a <free+0x76>
 816:	fad762e3          	bltu	a4,a3,7ba <free+0x16>
 81a:	87b6                	mv	a5,a3
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 81c:	fee7fae3          	bgeu	a5,a4,810 <free+0x6c>
 820:	6394                	ld	a3,0(a5)
 822:	f8d76ce3          	bltu	a4,a3,7ba <free+0x16>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 826:	f8d7fae3          	bgeu	a5,a3,7ba <free+0x16>
 82a:	87b6                	mv	a5,a3
 82c:	bfc5                	j	81c <free+0x78>

000000000000082e <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
 82e:	7139                	addi	sp,sp,-64
 830:	fc06                	sd	ra,56(sp)
 832:	f822                	sd	s0,48(sp)
 834:	f04a                	sd	s2,32(sp)
 836:	ec4e                	sd	s3,24(sp)
 838:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 83a:	02051993          	slli	s3,a0,0x20
 83e:	0209d993          	srli	s3,s3,0x20
 842:	09bd                	addi	s3,s3,15
 844:	0049d993          	srli	s3,s3,0x4
 848:	2985                	addiw	s3,s3,1
 84a:	894e                	mv	s2,s3
  if ((prevp = freep) == 0) {
 84c:	00000517          	auipc	a0,0x0
 850:	7b453503          	ld	a0,1972(a0) # 1000 <freep>
 854:	c905                	beqz	a0,884 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 856:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 858:	4798                	lw	a4,8(a5)
 85a:	09377663          	bgeu	a4,s3,8e6 <malloc+0xb8>
 85e:	f426                	sd	s1,40(sp)
 860:	e852                	sd	s4,16(sp)
 862:	e456                	sd	s5,8(sp)
 864:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 866:	8a4e                	mv	s4,s3
 868:	6705                	lui	a4,0x1
 86a:	00e9f363          	bgeu	s3,a4,870 <malloc+0x42>
 86e:	6a05                	lui	s4,0x1
 870:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 874:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 878:	00000497          	auipc	s1,0x0
 87c:	78848493          	addi	s1,s1,1928 # 1000 <freep>
  if (p == SBRK_ERROR)
 880:	5afd                	li	s5,-1
 882:	a83d                	j	8c0 <malloc+0x92>
 884:	f426                	sd	s1,40(sp)
 886:	e852                	sd	s4,16(sp)
 888:	e456                	sd	s5,8(sp)
 88a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 88c:	00000797          	auipc	a5,0x0
 890:	78478793          	addi	a5,a5,1924 # 1010 <base>
 894:	00000717          	auipc	a4,0x0
 898:	76f73623          	sd	a5,1900(a4) # 1000 <freep>
 89c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 89e:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 8a2:	b7d1                	j	866 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8a4:	6398                	ld	a4,0(a5)
 8a6:	e118                	sd	a4,0(a0)
 8a8:	a899                	j	8fe <malloc+0xd0>
  hp->s.size = nu;
 8aa:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 8ae:	0541                	addi	a0,a0,16
 8b0:	ef5ff0ef          	jal	7a4 <free>
  return freep;
 8b4:	6088                	ld	a0,0(s1)
      if ((p = morecore(nunits)) == 0)
 8b6:	c125                	beqz	a0,916 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 8b8:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 8ba:	4798                	lw	a4,8(a5)
 8bc:	03277163          	bgeu	a4,s2,8de <malloc+0xb0>
    if (p == freep)
 8c0:	6098                	ld	a4,0(s1)
 8c2:	853e                	mv	a0,a5
 8c4:	fef71ae3          	bne	a4,a5,8b8 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 8c8:	8552                	mv	a0,s4
 8ca:	9ffff0ef          	jal	2c8 <sbrk>
  if (p == SBRK_ERROR)
 8ce:	fd551ee3          	bne	a0,s5,8aa <malloc+0x7c>
        return 0;
 8d2:	4501                	li	a0,0
 8d4:	74a2                	ld	s1,40(sp)
 8d6:	6a42                	ld	s4,16(sp)
 8d8:	6aa2                	ld	s5,8(sp)
 8da:	6b02                	ld	s6,0(sp)
 8dc:	a03d                	j	90a <malloc+0xdc>
 8de:	74a2                	ld	s1,40(sp)
 8e0:	6a42                	ld	s4,16(sp)
 8e2:	6aa2                	ld	s5,8(sp)
 8e4:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
 8e6:	fae90fe3          	beq	s2,a4,8a4 <malloc+0x76>
        p->s.size -= nunits;
 8ea:	4137073b          	subw	a4,a4,s3
 8ee:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8f0:	02071693          	slli	a3,a4,0x20
 8f4:	01c6d713          	srli	a4,a3,0x1c
 8f8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8fa:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8fe:	00000717          	auipc	a4,0x0
 902:	70a73123          	sd	a0,1794(a4) # 1000 <freep>
      return (void *)(p + 1);
 906:	01078513          	addi	a0,a5,16
  }
}
 90a:	70e2                	ld	ra,56(sp)
 90c:	7442                	ld	s0,48(sp)
 90e:	7902                	ld	s2,32(sp)
 910:	69e2                	ld	s3,24(sp)
 912:	6121                	addi	sp,sp,64
 914:	8082                	ret
 916:	74a2                	ld	s1,40(sp)
 918:	6a42                	ld	s4,16(sp)
 91a:	6aa2                	ld	s5,8(sp)
 91c:	6b02                	ld	s6,0(sp)
 91e:	b7f5                	j	90a <malloc+0xdc>
