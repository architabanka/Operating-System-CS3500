
user/_nofollowtest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

#if defined(SYS_symlink) && defined(O_NOFOLLOW)

int
main(void)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	0080                	addi	s0,sp,64
  int fd;
  char buf[32];
  int n;

  unlink("target");
   8:	00001517          	auipc	a0,0x1
   c:	a1850513          	addi	a0,a0,-1512 # a20 <malloc+0xfa>
  10:	434000ef          	jal	444 <unlink>
  unlink("s1");
  14:	00001517          	auipc	a0,0x1
  18:	a1c50513          	addi	a0,a0,-1508 # a30 <malloc+0x10a>
  1c:	428000ef          	jal	444 <unlink>

  fd = open("target", O_CREATE | O_WRONLY);
  20:	20100593          	li	a1,513
  24:	00001517          	auipc	a0,0x1
  28:	9fc50513          	addi	a0,a0,-1540 # a20 <malloc+0xfa>
  2c:	408000ef          	jal	434 <open>
  if (fd < 0) {
  30:	06054d63          	bltz	a0,aa <main+0xaa>
  34:	f426                	sd	s1,40(sp)
  36:	84aa                	mv	s1,a0
    printf("target create failed\n");
    exit(1);
  }

  write(fd, "hello", 5);
  38:	4615                	li	a2,5
  3a:	00001597          	auipc	a1,0x1
  3e:	a1658593          	addi	a1,a1,-1514 # a50 <malloc+0x12a>
  42:	3d2000ef          	jal	414 <write>
  close(fd);
  46:	8526                	mv	a0,s1
  48:	3d4000ef          	jal	41c <close>

  if (symlink("target", "s1") < 0) {
  4c:	00001597          	auipc	a1,0x1
  50:	9e458593          	addi	a1,a1,-1564 # a30 <malloc+0x10a>
  54:	00001517          	auipc	a0,0x1
  58:	9cc50513          	addi	a0,a0,-1588 # a20 <malloc+0xfa>
  5c:	450000ef          	jal	4ac <symlink>
  60:	06054063          	bltz	a0,c0 <main+0xc0>
    printf("symlink failed\n");
    exit(1);
  }

  fd = open("s1", O_RDONLY | O_NOFOLLOW);
  64:	6585                	lui	a1,0x1
  66:	80058593          	addi	a1,a1,-2048 # 800 <vprintf+0x28e>
  6a:	00001517          	auipc	a0,0x1
  6e:	9c650513          	addi	a0,a0,-1594 # a30 <malloc+0x10a>
  72:	3c2000ef          	jal	434 <open>
  76:	84aa                	mv	s1,a0
  if (fd < 0) {
  78:	04054e63          	bltz	a0,d4 <main+0xd4>
  7c:	f04a                	sd	s2,32(sp)
    printf("O_NOFOLLOW open failed\n");
    exit(1);
  }

  n = read(fd, buf, sizeof(buf) - 1);
  7e:	467d                	li	a2,31
  80:	fc040593          	addi	a1,s0,-64
  84:	388000ef          	jal	40c <read>
  88:	892a                	mv	s2,a0
  close(fd);
  8a:	8526                	mv	a0,s1
  8c:	390000ef          	jal	41c <close>

  if (n != 7) {
  90:	479d                	li	a5,7
  92:	85ca                	mv	a1,s2
  94:	04f90a63          	beq	s2,a5,e8 <main+0xe8>
    printf("wrong symlink size: %d\n", n);
  98:	00001517          	auipc	a0,0x1
  9c:	9e850513          	addi	a0,a0,-1560 # a80 <malloc+0x15a>
  a0:	7ca000ef          	jal	86a <printf>
    exit(1);
  a4:	4505                	li	a0,1
  a6:	34e000ef          	jal	3f4 <exit>
  aa:	f426                	sd	s1,40(sp)
  ac:	f04a                	sd	s2,32(sp)
    printf("target create failed\n");
  ae:	00001517          	auipc	a0,0x1
  b2:	98a50513          	addi	a0,a0,-1654 # a38 <malloc+0x112>
  b6:	7b4000ef          	jal	86a <printf>
    exit(1);
  ba:	4505                	li	a0,1
  bc:	338000ef          	jal	3f4 <exit>
  c0:	f04a                	sd	s2,32(sp)
    printf("symlink failed\n");
  c2:	00001517          	auipc	a0,0x1
  c6:	99650513          	addi	a0,a0,-1642 # a58 <malloc+0x132>
  ca:	7a0000ef          	jal	86a <printf>
    exit(1);
  ce:	4505                	li	a0,1
  d0:	324000ef          	jal	3f4 <exit>
  d4:	f04a                	sd	s2,32(sp)
    printf("O_NOFOLLOW open failed\n");
  d6:	00001517          	auipc	a0,0x1
  da:	99250513          	addi	a0,a0,-1646 # a68 <malloc+0x142>
  de:	78c000ef          	jal	86a <printf>
    exit(1);
  e2:	4505                	li	a0,1
  e4:	310000ef          	jal	3f4 <exit>
  }

  buf[n] = 0;
  e8:	fc0403a3          	sb	zero,-57(s0)

  if (strcmp(buf, "target") != 0) {
  ec:	00001597          	auipc	a1,0x1
  f0:	93458593          	addi	a1,a1,-1740 # a20 <malloc+0xfa>
  f4:	fc040513          	addi	a0,s0,-64
  f8:	076000ef          	jal	16e <strcmp>
  fc:	cd01                	beqz	a0,114 <main+0x114>
    printf("wrong symlink contents: %s\n", buf);
  fe:	fc040593          	addi	a1,s0,-64
 102:	00001517          	auipc	a0,0x1
 106:	99650513          	addi	a0,a0,-1642 # a98 <malloc+0x172>
 10a:	760000ef          	jal	86a <printf>
    exit(1);
 10e:	4505                	li	a0,1
 110:	2e4000ef          	jal	3f4 <exit>
  }

  printf("nofollowtest: passed\n");
 114:	00001517          	auipc	a0,0x1
 118:	9a450513          	addi	a0,a0,-1628 # ab8 <malloc+0x192>
 11c:	74e000ef          	jal	86a <printf>

  unlink("s1");
 120:	00001517          	auipc	a0,0x1
 124:	91050513          	addi	a0,a0,-1776 # a30 <malloc+0x10a>
 128:	31c000ef          	jal	444 <unlink>
  unlink("target");
 12c:	00001517          	auipc	a0,0x1
 130:	8f450513          	addi	a0,a0,-1804 # a20 <malloc+0xfa>
 134:	310000ef          	jal	444 <unlink>
  exit(0);
 138:	4501                	li	a0,0
 13a:	2ba000ef          	jal	3f4 <exit>

000000000000013e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 13e:	1141                	addi	sp,sp,-16
 140:	e406                	sd	ra,8(sp)
 142:	e022                	sd	s0,0(sp)
 144:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 146:	ebbff0ef          	jal	0 <main>
  exit(r);
 14a:	2aa000ef          	jal	3f4 <exit>

000000000000014e <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 14e:	1141                	addi	sp,sp,-16
 150:	e406                	sd	ra,8(sp)
 152:	e022                	sd	s0,0(sp)
 154:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 156:	87aa                	mv	a5,a0
 158:	0585                	addi	a1,a1,1
 15a:	0785                	addi	a5,a5,1
 15c:	fff5c703          	lbu	a4,-1(a1)
 160:	fee78fa3          	sb	a4,-1(a5)
 164:	fb75                	bnez	a4,158 <strcpy+0xa>
    ;
  return os;
}
 166:	60a2                	ld	ra,8(sp)
 168:	6402                	ld	s0,0(sp)
 16a:	0141                	addi	sp,sp,16
 16c:	8082                	ret

000000000000016e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 16e:	1141                	addi	sp,sp,-16
 170:	e406                	sd	ra,8(sp)
 172:	e022                	sd	s0,0(sp)
 174:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 176:	00054783          	lbu	a5,0(a0)
 17a:	cb91                	beqz	a5,18e <strcmp+0x20>
 17c:	0005c703          	lbu	a4,0(a1)
 180:	00f71763          	bne	a4,a5,18e <strcmp+0x20>
    p++, q++;
 184:	0505                	addi	a0,a0,1
 186:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 188:	00054783          	lbu	a5,0(a0)
 18c:	fbe5                	bnez	a5,17c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 18e:	0005c503          	lbu	a0,0(a1)
}
 192:	40a7853b          	subw	a0,a5,a0
 196:	60a2                	ld	ra,8(sp)
 198:	6402                	ld	s0,0(sp)
 19a:	0141                	addi	sp,sp,16
 19c:	8082                	ret

000000000000019e <strlen>:

uint
strlen(const char *s)
{
 19e:	1141                	addi	sp,sp,-16
 1a0:	e406                	sd	ra,8(sp)
 1a2:	e022                	sd	s0,0(sp)
 1a4:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 1a6:	00054783          	lbu	a5,0(a0)
 1aa:	cf91                	beqz	a5,1c6 <strlen+0x28>
 1ac:	00150793          	addi	a5,a0,1
 1b0:	86be                	mv	a3,a5
 1b2:	0785                	addi	a5,a5,1
 1b4:	fff7c703          	lbu	a4,-1(a5)
 1b8:	ff65                	bnez	a4,1b0 <strlen+0x12>
 1ba:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 1be:	60a2                	ld	ra,8(sp)
 1c0:	6402                	ld	s0,0(sp)
 1c2:	0141                	addi	sp,sp,16
 1c4:	8082                	ret
  for (n = 0; s[n]; n++)
 1c6:	4501                	li	a0,0
 1c8:	bfdd                	j	1be <strlen+0x20>

00000000000001ca <memset>:

void *
memset(void *dst, int c, uint n)
{
 1ca:	1141                	addi	sp,sp,-16
 1cc:	e406                	sd	ra,8(sp)
 1ce:	e022                	sd	s0,0(sp)
 1d0:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 1d2:	ca19                	beqz	a2,1e8 <memset+0x1e>
 1d4:	87aa                	mv	a5,a0
 1d6:	1602                	slli	a2,a2,0x20
 1d8:	9201                	srli	a2,a2,0x20
 1da:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1de:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 1e2:	0785                	addi	a5,a5,1
 1e4:	fee79de3          	bne	a5,a4,1de <memset+0x14>
  }
  return dst;
}
 1e8:	60a2                	ld	ra,8(sp)
 1ea:	6402                	ld	s0,0(sp)
 1ec:	0141                	addi	sp,sp,16
 1ee:	8082                	ret

00000000000001f0 <strchr>:

char *
strchr(const char *s, char c)
{
 1f0:	1141                	addi	sp,sp,-16
 1f2:	e406                	sd	ra,8(sp)
 1f4:	e022                	sd	s0,0(sp)
 1f6:	0800                	addi	s0,sp,16
  for (; *s; s++)
 1f8:	00054783          	lbu	a5,0(a0)
 1fc:	c799                	beqz	a5,20a <strchr+0x1a>
    if (*s == c)
 1fe:	00f58763          	beq	a1,a5,20c <strchr+0x1c>
  for (; *s; s++)
 202:	0505                	addi	a0,a0,1
 204:	00054783          	lbu	a5,0(a0)
 208:	fbfd                	bnez	a5,1fe <strchr+0xe>
      return (char *)s;
  return 0;
 20a:	4501                	li	a0,0
}
 20c:	60a2                	ld	ra,8(sp)
 20e:	6402                	ld	s0,0(sp)
 210:	0141                	addi	sp,sp,16
 212:	8082                	ret

0000000000000214 <gets>:

char *
gets(char *buf, int max)
{
 214:	711d                	addi	sp,sp,-96
 216:	ec86                	sd	ra,88(sp)
 218:	e8a2                	sd	s0,80(sp)
 21a:	e4a6                	sd	s1,72(sp)
 21c:	e0ca                	sd	s2,64(sp)
 21e:	fc4e                	sd	s3,56(sp)
 220:	f852                	sd	s4,48(sp)
 222:	f456                	sd	s5,40(sp)
 224:	f05a                	sd	s6,32(sp)
 226:	ec5e                	sd	s7,24(sp)
 228:	e862                	sd	s8,16(sp)
 22a:	1080                	addi	s0,sp,96
 22c:	8baa                	mv	s7,a0
 22e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 230:	892a                	mv	s2,a0
 232:	4481                	li	s1,0
    cc = read(0, &c, 1);
 234:	faf40b13          	addi	s6,s0,-81
 238:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;) {
 23a:	8c26                	mv	s8,s1
 23c:	0014899b          	addiw	s3,s1,1
 240:	84ce                	mv	s1,s3
 242:	0349d863          	bge	s3,s4,272 <gets+0x5e>
    cc = read(0, &c, 1);
 246:	8656                	mv	a2,s5
 248:	85da                	mv	a1,s6
 24a:	4501                	li	a0,0
 24c:	1c0000ef          	jal	40c <read>
    if (cc < 1)
 250:	02a05163          	blez	a0,272 <gets+0x5e>
      break;
    buf[i++] = c;
 254:	faf44783          	lbu	a5,-81(s0)
 258:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 25c:	0905                	addi	s2,s2,1
 25e:	ff678713          	addi	a4,a5,-10
 262:	00173713          	seqz	a4,a4
 266:	17cd                	addi	a5,a5,-13
 268:	0017b793          	seqz	a5,a5
 26c:	8fd9                	or	a5,a5,a4
 26e:	d7f1                	beqz	a5,23a <gets+0x26>
    buf[i++] = c;
 270:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 272:	9c5e                	add	s8,s8,s7
 274:	000c0023          	sb	zero,0(s8)
  return buf;
}
 278:	855e                	mv	a0,s7
 27a:	60e6                	ld	ra,88(sp)
 27c:	6446                	ld	s0,80(sp)
 27e:	64a6                	ld	s1,72(sp)
 280:	6906                	ld	s2,64(sp)
 282:	79e2                	ld	s3,56(sp)
 284:	7a42                	ld	s4,48(sp)
 286:	7aa2                	ld	s5,40(sp)
 288:	7b02                	ld	s6,32(sp)
 28a:	6be2                	ld	s7,24(sp)
 28c:	6c42                	ld	s8,16(sp)
 28e:	6125                	addi	sp,sp,96
 290:	8082                	ret

0000000000000292 <stat>:

int
stat(const char *n, struct stat *st)
{
 292:	1101                	addi	sp,sp,-32
 294:	ec06                	sd	ra,24(sp)
 296:	e822                	sd	s0,16(sp)
 298:	e04a                	sd	s2,0(sp)
 29a:	1000                	addi	s0,sp,32
 29c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29e:	4581                	li	a1,0
 2a0:	194000ef          	jal	434 <open>
  if (fd < 0)
 2a4:	02054263          	bltz	a0,2c8 <stat+0x36>
 2a8:	e426                	sd	s1,8(sp)
 2aa:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2ac:	85ca                	mv	a1,s2
 2ae:	19e000ef          	jal	44c <fstat>
 2b2:	892a                	mv	s2,a0
  close(fd);
 2b4:	8526                	mv	a0,s1
 2b6:	166000ef          	jal	41c <close>
  return r;
 2ba:	64a2                	ld	s1,8(sp)
}
 2bc:	854a                	mv	a0,s2
 2be:	60e2                	ld	ra,24(sp)
 2c0:	6442                	ld	s0,16(sp)
 2c2:	6902                	ld	s2,0(sp)
 2c4:	6105                	addi	sp,sp,32
 2c6:	8082                	ret
    return -1;
 2c8:	57fd                	li	a5,-1
 2ca:	893e                	mv	s2,a5
 2cc:	bfc5                	j	2bc <stat+0x2a>

00000000000002ce <atoi>:

int
atoi(const char *s)
{
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e406                	sd	ra,8(sp)
 2d2:	e022                	sd	s0,0(sp)
 2d4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 2d6:	00054683          	lbu	a3,0(a0)
 2da:	fd06879b          	addiw	a5,a3,-48
 2de:	0ff7f793          	zext.b	a5,a5
 2e2:	4625                	li	a2,9
 2e4:	02f66963          	bltu	a2,a5,316 <atoi+0x48>
 2e8:	872a                	mv	a4,a0
  n = 0;
 2ea:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 2ec:	0705                	addi	a4,a4,1
 2ee:	0025179b          	slliw	a5,a0,0x2
 2f2:	9fa9                	addw	a5,a5,a0
 2f4:	0017979b          	slliw	a5,a5,0x1
 2f8:	9fb5                	addw	a5,a5,a3
 2fa:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 2fe:	00074683          	lbu	a3,0(a4)
 302:	fd06879b          	addiw	a5,a3,-48
 306:	0ff7f793          	zext.b	a5,a5
 30a:	fef671e3          	bgeu	a2,a5,2ec <atoi+0x1e>
  return n;
}
 30e:	60a2                	ld	ra,8(sp)
 310:	6402                	ld	s0,0(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret
  n = 0;
 316:	4501                	li	a0,0
 318:	bfdd                	j	30e <atoi+0x40>

000000000000031a <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 31a:	1141                	addi	sp,sp,-16
 31c:	e406                	sd	ra,8(sp)
 31e:	e022                	sd	s0,0(sp)
 320:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 322:	02b57563          	bgeu	a0,a1,34c <memmove+0x32>
    while (n-- > 0)
 326:	00c05f63          	blez	a2,344 <memmove+0x2a>
 32a:	1602                	slli	a2,a2,0x20
 32c:	9201                	srli	a2,a2,0x20
 32e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 332:	872a                	mv	a4,a0
      *dst++ = *src++;
 334:	0585                	addi	a1,a1,1
 336:	0705                	addi	a4,a4,1
 338:	fff5c683          	lbu	a3,-1(a1)
 33c:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 340:	fee79ae3          	bne	a5,a4,334 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 344:	60a2                	ld	ra,8(sp)
 346:	6402                	ld	s0,0(sp)
 348:	0141                	addi	sp,sp,16
 34a:	8082                	ret
    while (n-- > 0)
 34c:	fec05ce3          	blez	a2,344 <memmove+0x2a>
    dst += n;
 350:	00c50733          	add	a4,a0,a2
    src += n;
 354:	95b2                	add	a1,a1,a2
 356:	fff6079b          	addiw	a5,a2,-1
 35a:	1782                	slli	a5,a5,0x20
 35c:	9381                	srli	a5,a5,0x20
 35e:	fff7c793          	not	a5,a5
 362:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 364:	15fd                	addi	a1,a1,-1
 366:	177d                	addi	a4,a4,-1
 368:	0005c683          	lbu	a3,0(a1)
 36c:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 370:	fef71ae3          	bne	a4,a5,364 <memmove+0x4a>
 374:	bfc1                	j	344 <memmove+0x2a>

0000000000000376 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 376:	1141                	addi	sp,sp,-16
 378:	e406                	sd	ra,8(sp)
 37a:	e022                	sd	s0,0(sp)
 37c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 37e:	ce19                	beqz	a2,39c <memcmp+0x26>
 380:	1602                	slli	a2,a2,0x20
 382:	9201                	srli	a2,a2,0x20
 384:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 388:	00054783          	lbu	a5,0(a0)
 38c:	0005c703          	lbu	a4,0(a1)
 390:	00e79b63          	bne	a5,a4,3a6 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 394:	0505                	addi	a0,a0,1
    p2++;
 396:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 398:	fed518e3          	bne	a0,a3,388 <memcmp+0x12>
  }
  return 0;
 39c:	4501                	li	a0,0
}
 39e:	60a2                	ld	ra,8(sp)
 3a0:	6402                	ld	s0,0(sp)
 3a2:	0141                	addi	sp,sp,16
 3a4:	8082                	ret
      return *p1 - *p2;
 3a6:	40e7853b          	subw	a0,a5,a4
 3aa:	bfd5                	j	39e <memcmp+0x28>

00000000000003ac <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3ac:	1141                	addi	sp,sp,-16
 3ae:	e406                	sd	ra,8(sp)
 3b0:	e022                	sd	s0,0(sp)
 3b2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3b4:	f67ff0ef          	jal	31a <memmove>
}
 3b8:	60a2                	ld	ra,8(sp)
 3ba:	6402                	ld	s0,0(sp)
 3bc:	0141                	addi	sp,sp,16
 3be:	8082                	ret

00000000000003c0 <sbrk>:

char *
sbrk(int n)
{
 3c0:	1141                	addi	sp,sp,-16
 3c2:	e406                	sd	ra,8(sp)
 3c4:	e022                	sd	s0,0(sp)
 3c6:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 3c8:	4585                	li	a1,1
 3ca:	0b2000ef          	jal	47c <sys_sbrk>
}
 3ce:	60a2                	ld	ra,8(sp)
 3d0:	6402                	ld	s0,0(sp)
 3d2:	0141                	addi	sp,sp,16
 3d4:	8082                	ret

00000000000003d6 <sbrklazy>:

char *
sbrklazy(int n)
{
 3d6:	1141                	addi	sp,sp,-16
 3d8:	e406                	sd	ra,8(sp)
 3da:	e022                	sd	s0,0(sp)
 3dc:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 3de:	4589                	li	a1,2
 3e0:	09c000ef          	jal	47c <sys_sbrk>
}
 3e4:	60a2                	ld	ra,8(sp)
 3e6:	6402                	ld	s0,0(sp)
 3e8:	0141                	addi	sp,sp,16
 3ea:	8082                	ret

00000000000003ec <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3ec:	4885                	li	a7,1
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3f4:	4889                	li	a7,2
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <wait>:
.global wait
wait:
 li a7, SYS_wait
 3fc:	488d                	li	a7,3
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 404:	4891                	li	a7,4
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <read>:
.global read
read:
 li a7, SYS_read
 40c:	4895                	li	a7,5
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <write>:
.global write
write:
 li a7, SYS_write
 414:	48c1                	li	a7,16
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <close>:
.global close
close:
 li a7, SYS_close
 41c:	48d5                	li	a7,21
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <kill>:
.global kill
kill:
 li a7, SYS_kill
 424:	4899                	li	a7,6
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <exec>:
.global exec
exec:
 li a7, SYS_exec
 42c:	489d                	li	a7,7
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <open>:
.global open
open:
 li a7, SYS_open
 434:	48bd                	li	a7,15
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 43c:	48c5                	li	a7,17
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 444:	48c9                	li	a7,18
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 44c:	48a1                	li	a7,8
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <link>:
.global link
link:
 li a7, SYS_link
 454:	48cd                	li	a7,19
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 45c:	48d1                	li	a7,20
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 464:	48a5                	li	a7,9
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <dup>:
.global dup
dup:
 li a7, SYS_dup
 46c:	48a9                	li	a7,10
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 474:	48ad                	li	a7,11
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 47c:	48b1                	li	a7,12
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <pause>:
.global pause
pause:
 li a7, SYS_pause
 484:	48b5                	li	a7,13
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 48c:	48b9                	li	a7,14
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <sync>:
.global sync
sync:
 li a7, SYS_sync
 494:	48d9                	li	a7,22
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <istat>:
.global istat
istat:
 li a7, SYS_istat
 49c:	48dd                	li	a7,23
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <iprint>:
.global iprint
iprint:
 li a7, SYS_iprint
 4a4:	48e1                	li	a7,24
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <symlink>:
.global symlink
symlink:
 li a7, SYS_symlink
 4ac:	48e5                	li	a7,25
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4b4:	1101                	addi	sp,sp,-32
 4b6:	ec06                	sd	ra,24(sp)
 4b8:	e822                	sd	s0,16(sp)
 4ba:	1000                	addi	s0,sp,32
 4bc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4c0:	4605                	li	a2,1
 4c2:	fef40593          	addi	a1,s0,-17
 4c6:	f4fff0ef          	jal	414 <write>
}
 4ca:	60e2                	ld	ra,24(sp)
 4cc:	6442                	ld	s0,16(sp)
 4ce:	6105                	addi	sp,sp,32
 4d0:	8082                	ret

00000000000004d2 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4d2:	715d                	addi	sp,sp,-80
 4d4:	e486                	sd	ra,72(sp)
 4d6:	e0a2                	sd	s0,64(sp)
 4d8:	f84a                	sd	s2,48(sp)
 4da:	f44e                	sd	s3,40(sp)
 4dc:	0880                	addi	s0,sp,80
 4de:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 4e0:	00d036b3          	snez	a3,a3
 4e4:	03f5d793          	srli	a5,a1,0x3f
 4e8:	8efd                	and	a3,a3,a5
  neg = 0;
 4ea:	4301                	li	t1,0
  if (sgn && xx < 0) {
 4ec:	c681                	beqz	a3,4f4 <printint+0x22>
    neg = 1;
    x = -xx;
 4ee:	40b005b3          	neg	a1,a1
    neg = 1;
 4f2:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 4f4:	fb840993          	addi	s3,s0,-72
  neg = 0;
 4f8:	86ce                	mv	a3,s3
  i = 0;
 4fa:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
 4fc:	00000817          	auipc	a6,0x0
 500:	5dc80813          	addi	a6,a6,1500 # ad8 <digits>
 504:	88ba                	mv	a7,a4
 506:	0017051b          	addiw	a0,a4,1
 50a:	872a                	mv	a4,a0
 50c:	02c5f7b3          	remu	a5,a1,a2
 510:	97c2                	add	a5,a5,a6
 512:	0007c783          	lbu	a5,0(a5)
 516:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
 51a:	87ae                	mv	a5,a1
 51c:	02c5d5b3          	divu	a1,a1,a2
 520:	0685                	addi	a3,a3,1
 522:	fec7f1e3          	bgeu	a5,a2,504 <printint+0x32>
  if (neg)
 526:	00030b63          	beqz	t1,53c <printint+0x6a>
    buf[i++] = '-';
 52a:	fd040793          	addi	a5,s0,-48
 52e:	953e                	add	a0,a0,a5
 530:	02d00793          	li	a5,45
 534:	fef50423          	sb	a5,-24(a0)
 538:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
 53c:	02e05563          	blez	a4,566 <printint+0x94>
 540:	fc26                	sd	s1,56(sp)
 542:	377d                	addiw	a4,a4,-1
 544:	00e984b3          	add	s1,s3,a4
 548:	19fd                	addi	s3,s3,-1
 54a:	99ba                	add	s3,s3,a4
 54c:	1702                	slli	a4,a4,0x20
 54e:	9301                	srli	a4,a4,0x20
 550:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 554:	0004c583          	lbu	a1,0(s1)
 558:	854a                	mv	a0,s2
 55a:	f5bff0ef          	jal	4b4 <putc>
  while (--i >= 0)
 55e:	14fd                	addi	s1,s1,-1
 560:	ff349ae3          	bne	s1,s3,554 <printint+0x82>
 564:	74e2                	ld	s1,56(sp)
}
 566:	60a6                	ld	ra,72(sp)
 568:	6406                	ld	s0,64(sp)
 56a:	7942                	ld	s2,48(sp)
 56c:	79a2                	ld	s3,40(sp)
 56e:	6161                	addi	sp,sp,80
 570:	8082                	ret

0000000000000572 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 572:	711d                	addi	sp,sp,-96
 574:	ec86                	sd	ra,88(sp)
 576:	e8a2                	sd	s0,80(sp)
 578:	e4a6                	sd	s1,72(sp)
 57a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 57c:	0005c483          	lbu	s1,0(a1)
 580:	2a048063          	beqz	s1,820 <vprintf+0x2ae>
 584:	e0ca                	sd	s2,64(sp)
 586:	fc4e                	sd	s3,56(sp)
 588:	f852                	sd	s4,48(sp)
 58a:	f456                	sd	s5,40(sp)
 58c:	f05a                	sd	s6,32(sp)
 58e:	ec5e                	sd	s7,24(sp)
 590:	e862                	sd	s8,16(sp)
 592:	8b2a                	mv	s6,a0
 594:	8a2e                	mv	s4,a1
 596:	8bb2                	mv	s7,a2
  state = 0;
 598:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 59a:	4901                	li	s2,0
 59c:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 59e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 5a2:	06400c13          	li	s8,100
 5a6:	a00d                	j	5c8 <vprintf+0x56>
        putc(fd, c0);
 5a8:	85a6                	mv	a1,s1
 5aa:	855a                	mv	a0,s6
 5ac:	f09ff0ef          	jal	4b4 <putc>
 5b0:	a019                	j	5b6 <vprintf+0x44>
    } else if (state == '%') {
 5b2:	03598363          	beq	s3,s5,5d8 <vprintf+0x66>
  for (i = 0; fmt[i]; i++) {
 5b6:	0019079b          	addiw	a5,s2,1
 5ba:	893e                	mv	s2,a5
 5bc:	873e                	mv	a4,a5
 5be:	97d2                	add	a5,a5,s4
 5c0:	0007c483          	lbu	s1,0(a5)
 5c4:	24048763          	beqz	s1,812 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 5c8:	0004879b          	sext.w	a5,s1
    if (state == 0) {
 5cc:	fe0993e3          	bnez	s3,5b2 <vprintf+0x40>
      if (c0 == '%') {
 5d0:	fd579ce3          	bne	a5,s5,5a8 <vprintf+0x36>
        state = '%';
 5d4:	89be                	mv	s3,a5
 5d6:	b7c5                	j	5b6 <vprintf+0x44>
        c1 = fmt[i + 1] & 0xff;
 5d8:	00ea06b3          	add	a3,s4,a4
 5dc:	0016c603          	lbu	a2,1(a3)
      if (c1)
 5e0:	24060563          	beqz	a2,82a <vprintf+0x2b8>
      if (c0 == 'd') {
 5e4:	0b878763          	beq	a5,s8,692 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 5e8:	f9478693          	addi	a3,a5,-108
 5ec:	0016b693          	seqz	a3,a3
 5f0:	f9c60593          	addi	a1,a2,-100
 5f4:	0015b593          	seqz	a1,a1
 5f8:	8df5                	and	a1,a1,a3
 5fa:	e9c5                	bnez	a1,6aa <vprintf+0x138>
        c2 = fmt[i + 2] & 0xff;
 5fc:	9752                	add	a4,a4,s4
 5fe:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 602:	f9460713          	addi	a4,a2,-108
 606:	00173713          	seqz	a4,a4
 60a:	8f75                	and	a4,a4,a3
 60c:	f9c50593          	addi	a1,a0,-100
 610:	0015b593          	seqz	a1,a1
 614:	8df9                	and	a1,a1,a4
 616:	e5dd                	bnez	a1,6c4 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 618:	07500593          	li	a1,117
 61c:	0cb78163          	beq	a5,a1,6de <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if (c0 == 'l' && c1 == 'u') {
 620:	f8b60593          	addi	a1,a2,-117
 624:	0015b593          	seqz	a1,a1
 628:	8df5                	and	a1,a1,a3
 62a:	e5f1                	bnez	a1,6f6 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 62c:	f8b50593          	addi	a1,a0,-117
 630:	0015b593          	seqz	a1,a1
 634:	8df9                	and	a1,a1,a4
 636:	ede9                	bnez	a1,710 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 638:	07800593          	li	a1,120
 63c:	0eb78763          	beq	a5,a1,72a <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if (c0 == 'l' && c1 == 'x') {
 640:	f8860613          	addi	a2,a2,-120
 644:	00163613          	seqz	a2,a2
 648:	8ef1                	and	a3,a3,a2
 64a:	0e069c63          	bnez	a3,742 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 64e:	f8850513          	addi	a0,a0,-120
 652:	00153513          	seqz	a0,a0
 656:	8f69                	and	a4,a4,a0
 658:	10071263          	bnez	a4,75c <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 65c:	07000713          	li	a4,112
 660:	10e78a63          	beq	a5,a4,774 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 664:	06300713          	li	a4,99
 668:	14e78a63          	beq	a5,a4,7bc <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 66c:	07300713          	li	a4,115
 670:	16e78063          	beq	a5,a4,7d0 <vprintf+0x25e>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 674:	02500713          	li	a4,37
 678:	18e78863          	beq	a5,a4,808 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 67c:	02500593          	li	a1,37
 680:	855a                	mv	a0,s6
 682:	e33ff0ef          	jal	4b4 <putc>
        putc(fd, c0);
 686:	85a6                	mv	a1,s1
 688:	855a                	mv	a0,s6
 68a:	e2bff0ef          	jal	4b4 <putc>
      }

      state = 0;
 68e:	4981                	li	s3,0
 690:	b71d                	j	5b6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 692:	008b8493          	addi	s1,s7,8
 696:	4685                	li	a3,1
 698:	4629                	li	a2,10
 69a:	000ba583          	lw	a1,0(s7)
 69e:	855a                	mv	a0,s6
 6a0:	e33ff0ef          	jal	4d2 <printint>
 6a4:	8ba6                	mv	s7,s1
      state = 0;
 6a6:	4981                	li	s3,0
 6a8:	b739                	j	5b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6aa:	008b8493          	addi	s1,s7,8
 6ae:	4685                	li	a3,1
 6b0:	4629                	li	a2,10
 6b2:	000bb583          	ld	a1,0(s7)
 6b6:	855a                	mv	a0,s6
 6b8:	e1bff0ef          	jal	4d2 <printint>
        i += 1;
 6bc:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6be:	8ba6                	mv	s7,s1
      state = 0;
 6c0:	4981                	li	s3,0
 6c2:	bdd5                	j	5b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6c4:	008b8493          	addi	s1,s7,8
 6c8:	4685                	li	a3,1
 6ca:	4629                	li	a2,10
 6cc:	000bb583          	ld	a1,0(s7)
 6d0:	855a                	mv	a0,s6
 6d2:	e01ff0ef          	jal	4d2 <printint>
        i += 2;
 6d6:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6d8:	8ba6                	mv	s7,s1
      state = 0;
 6da:	4981                	li	s3,0
        i += 2;
 6dc:	bde9                	j	5b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6de:	008b8493          	addi	s1,s7,8
 6e2:	4681                	li	a3,0
 6e4:	4629                	li	a2,10
 6e6:	000be583          	lwu	a1,0(s7)
 6ea:	855a                	mv	a0,s6
 6ec:	de7ff0ef          	jal	4d2 <printint>
 6f0:	8ba6                	mv	s7,s1
      state = 0;
 6f2:	4981                	li	s3,0
 6f4:	b5c9                	j	5b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6f6:	008b8493          	addi	s1,s7,8
 6fa:	4681                	li	a3,0
 6fc:	4629                	li	a2,10
 6fe:	000bb583          	ld	a1,0(s7)
 702:	855a                	mv	a0,s6
 704:	dcfff0ef          	jal	4d2 <printint>
        i += 1;
 708:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 70a:	8ba6                	mv	s7,s1
      state = 0;
 70c:	4981                	li	s3,0
 70e:	b565                	j	5b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 710:	008b8493          	addi	s1,s7,8
 714:	4681                	li	a3,0
 716:	4629                	li	a2,10
 718:	000bb583          	ld	a1,0(s7)
 71c:	855a                	mv	a0,s6
 71e:	db5ff0ef          	jal	4d2 <printint>
        i += 2;
 722:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 724:	8ba6                	mv	s7,s1
      state = 0;
 726:	4981                	li	s3,0
        i += 2;
 728:	b579                	j	5b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 72a:	008b8493          	addi	s1,s7,8
 72e:	4681                	li	a3,0
 730:	4641                	li	a2,16
 732:	000be583          	lwu	a1,0(s7)
 736:	855a                	mv	a0,s6
 738:	d9bff0ef          	jal	4d2 <printint>
 73c:	8ba6                	mv	s7,s1
      state = 0;
 73e:	4981                	li	s3,0
 740:	bd9d                	j	5b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 742:	008b8493          	addi	s1,s7,8
 746:	4681                	li	a3,0
 748:	4641                	li	a2,16
 74a:	000bb583          	ld	a1,0(s7)
 74e:	855a                	mv	a0,s6
 750:	d83ff0ef          	jal	4d2 <printint>
        i += 1;
 754:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 756:	8ba6                	mv	s7,s1
      state = 0;
 758:	4981                	li	s3,0
 75a:	bdb1                	j	5b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 75c:	008b8493          	addi	s1,s7,8
 760:	4641                	li	a2,16
 762:	000bb583          	ld	a1,0(s7)
 766:	855a                	mv	a0,s6
 768:	d6bff0ef          	jal	4d2 <printint>
        i += 2;
 76c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 76e:	8ba6                	mv	s7,s1
      state = 0;
 770:	4981                	li	s3,0
        i += 2;
 772:	b591                	j	5b6 <vprintf+0x44>
 774:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 776:	008b8793          	addi	a5,s7,8
 77a:	8cbe                	mv	s9,a5
 77c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 780:	03000593          	li	a1,48
 784:	855a                	mv	a0,s6
 786:	d2fff0ef          	jal	4b4 <putc>
  putc(fd, 'x');
 78a:	07800593          	li	a1,120
 78e:	855a                	mv	a0,s6
 790:	d25ff0ef          	jal	4b4 <putc>
 794:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 796:	00000b97          	auipc	s7,0x0
 79a:	342b8b93          	addi	s7,s7,834 # ad8 <digits>
 79e:	03c9d793          	srli	a5,s3,0x3c
 7a2:	97de                	add	a5,a5,s7
 7a4:	0007c583          	lbu	a1,0(a5)
 7a8:	855a                	mv	a0,s6
 7aa:	d0bff0ef          	jal	4b4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ae:	0992                	slli	s3,s3,0x4
 7b0:	34fd                	addiw	s1,s1,-1
 7b2:	f4f5                	bnez	s1,79e <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 7b4:	8be6                	mv	s7,s9
      state = 0;
 7b6:	4981                	li	s3,0
 7b8:	6ca2                	ld	s9,8(sp)
 7ba:	bbf5                	j	5b6 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 7bc:	008b8493          	addi	s1,s7,8
 7c0:	000bc583          	lbu	a1,0(s7)
 7c4:	855a                	mv	a0,s6
 7c6:	cefff0ef          	jal	4b4 <putc>
 7ca:	8ba6                	mv	s7,s1
      state = 0;
 7cc:	4981                	li	s3,0
 7ce:	b3e5                	j	5b6 <vprintf+0x44>
        if ((s = va_arg(ap, char *)) == 0)
 7d0:	008b8993          	addi	s3,s7,8
 7d4:	000bb483          	ld	s1,0(s7)
 7d8:	cc91                	beqz	s1,7f4 <vprintf+0x282>
        for (; *s; s++)
 7da:	0004c583          	lbu	a1,0(s1)
 7de:	c195                	beqz	a1,802 <vprintf+0x290>
          putc(fd, *s);
 7e0:	855a                	mv	a0,s6
 7e2:	cd3ff0ef          	jal	4b4 <putc>
        for (; *s; s++)
 7e6:	0485                	addi	s1,s1,1
 7e8:	0004c583          	lbu	a1,0(s1)
 7ec:	f9f5                	bnez	a1,7e0 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 7ee:	8bce                	mv	s7,s3
      state = 0;
 7f0:	4981                	li	s3,0
 7f2:	b3d1                	j	5b6 <vprintf+0x44>
          s = "(null)";
 7f4:	00000497          	auipc	s1,0x0
 7f8:	2dc48493          	addi	s1,s1,732 # ad0 <malloc+0x1aa>
        for (; *s; s++)
 7fc:	02800593          	li	a1,40
 800:	b7c5                	j	7e0 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 802:	8bce                	mv	s7,s3
      state = 0;
 804:	4981                	li	s3,0
 806:	bb45                	j	5b6 <vprintf+0x44>
        putc(fd, '%');
 808:	85be                	mv	a1,a5
 80a:	855a                	mv	a0,s6
 80c:	ca9ff0ef          	jal	4b4 <putc>
 810:	bdbd                	j	68e <vprintf+0x11c>
 812:	6906                	ld	s2,64(sp)
 814:	79e2                	ld	s3,56(sp)
 816:	7a42                	ld	s4,48(sp)
 818:	7aa2                	ld	s5,40(sp)
 81a:	7b02                	ld	s6,32(sp)
 81c:	6be2                	ld	s7,24(sp)
 81e:	6c42                	ld	s8,16(sp)
    }
  }
}
 820:	60e6                	ld	ra,88(sp)
 822:	6446                	ld	s0,80(sp)
 824:	64a6                	ld	s1,72(sp)
 826:	6125                	addi	sp,sp,96
 828:	8082                	ret
      if (c0 == 'd') {
 82a:	06400713          	li	a4,100
 82e:	e6e782e3          	beq	a5,a4,692 <vprintf+0x120>
      } else if (c0 == 'l' && c1 == 'd') {
 832:	f9478693          	addi	a3,a5,-108
 836:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 83a:	8532                	mv	a0,a2
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 83c:	4701                	li	a4,0
 83e:	bbe9                	j	618 <vprintf+0xa6>

0000000000000840 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 840:	715d                	addi	sp,sp,-80
 842:	ec06                	sd	ra,24(sp)
 844:	e822                	sd	s0,16(sp)
 846:	1000                	addi	s0,sp,32
 848:	e010                	sd	a2,0(s0)
 84a:	e414                	sd	a3,8(s0)
 84c:	e818                	sd	a4,16(s0)
 84e:	ec1c                	sd	a5,24(s0)
 850:	03043023          	sd	a6,32(s0)
 854:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 858:	8622                	mv	a2,s0
 85a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 85e:	d15ff0ef          	jal	572 <vprintf>
}
 862:	60e2                	ld	ra,24(sp)
 864:	6442                	ld	s0,16(sp)
 866:	6161                	addi	sp,sp,80
 868:	8082                	ret

000000000000086a <printf>:

void
printf(const char *fmt, ...)
{
 86a:	711d                	addi	sp,sp,-96
 86c:	ec06                	sd	ra,24(sp)
 86e:	e822                	sd	s0,16(sp)
 870:	1000                	addi	s0,sp,32
 872:	e40c                	sd	a1,8(s0)
 874:	e810                	sd	a2,16(s0)
 876:	ec14                	sd	a3,24(s0)
 878:	f018                	sd	a4,32(s0)
 87a:	f41c                	sd	a5,40(s0)
 87c:	03043823          	sd	a6,48(s0)
 880:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 884:	00840613          	addi	a2,s0,8
 888:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 88c:	85aa                	mv	a1,a0
 88e:	4505                	li	a0,1
 890:	ce3ff0ef          	jal	572 <vprintf>
}
 894:	60e2                	ld	ra,24(sp)
 896:	6442                	ld	s0,16(sp)
 898:	6125                	addi	sp,sp,96
 89a:	8082                	ret

000000000000089c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 89c:	1141                	addi	sp,sp,-16
 89e:	e406                	sd	ra,8(sp)
 8a0:	e022                	sd	s0,0(sp)
 8a2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 8a4:	ff050713          	addi	a4,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a8:	00000797          	auipc	a5,0x0
 8ac:	7587b783          	ld	a5,1880(a5) # 1000 <freep>
 8b0:	a095                	j	914 <free+0x78>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
 8b2:	ff852583          	lw	a1,-8(a0)
 8b6:	6390                	ld	a2,0(a5)
 8b8:	02059813          	slli	a6,a1,0x20
 8bc:	01c85693          	srli	a3,a6,0x1c
 8c0:	96ba                	add	a3,a3,a4
 8c2:	02d60563          	beq	a2,a3,8ec <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 8c6:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
 8ca:	4790                	lw	a2,8(a5)
 8cc:	02061593          	slli	a1,a2,0x20
 8d0:	01c5d693          	srli	a3,a1,0x1c
 8d4:	96be                	add	a3,a3,a5
 8d6:	02d70263          	beq	a4,a3,8fa <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 8da:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8dc:	00000717          	auipc	a4,0x0
 8e0:	72f73223          	sd	a5,1828(a4) # 1000 <freep>
}
 8e4:	60a2                	ld	ra,8(sp)
 8e6:	6402                	ld	s0,0(sp)
 8e8:	0141                	addi	sp,sp,16
 8ea:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 8ec:	4614                	lw	a3,8(a2)
 8ee:	9ead                	addw	a3,a3,a1
 8f0:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8f4:	6394                	ld	a3,0(a5)
 8f6:	6290                	ld	a2,0(a3)
 8f8:	b7f9                	j	8c6 <free+0x2a>
    p->s.size += bp->s.size;
 8fa:	ff852703          	lw	a4,-8(a0)
 8fe:	9f31                	addw	a4,a4,a2
 900:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 902:	ff053703          	ld	a4,-16(a0)
 906:	bfd1                	j	8da <free+0x3e>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 908:	6394                	ld	a3,0(a5)
 90a:	00d7e463          	bltu	a5,a3,912 <free+0x76>
 90e:	fad762e3          	bltu	a4,a3,8b2 <free+0x16>
 912:	87b6                	mv	a5,a3
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 914:	fee7fae3          	bgeu	a5,a4,908 <free+0x6c>
 918:	6394                	ld	a3,0(a5)
 91a:	f8d76ce3          	bltu	a4,a3,8b2 <free+0x16>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 91e:	f8d7fae3          	bgeu	a5,a3,8b2 <free+0x16>
 922:	87b6                	mv	a5,a3
 924:	bfc5                	j	914 <free+0x78>

0000000000000926 <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
 926:	7139                	addi	sp,sp,-64
 928:	fc06                	sd	ra,56(sp)
 92a:	f822                	sd	s0,48(sp)
 92c:	f04a                	sd	s2,32(sp)
 92e:	ec4e                	sd	s3,24(sp)
 930:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 932:	02051993          	slli	s3,a0,0x20
 936:	0209d993          	srli	s3,s3,0x20
 93a:	09bd                	addi	s3,s3,15
 93c:	0049d993          	srli	s3,s3,0x4
 940:	2985                	addiw	s3,s3,1
 942:	894e                	mv	s2,s3
  if ((prevp = freep) == 0) {
 944:	00000517          	auipc	a0,0x0
 948:	6bc53503          	ld	a0,1724(a0) # 1000 <freep>
 94c:	c905                	beqz	a0,97c <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 94e:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 950:	4798                	lw	a4,8(a5)
 952:	09377663          	bgeu	a4,s3,9de <malloc+0xb8>
 956:	f426                	sd	s1,40(sp)
 958:	e852                	sd	s4,16(sp)
 95a:	e456                	sd	s5,8(sp)
 95c:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 95e:	8a4e                	mv	s4,s3
 960:	6705                	lui	a4,0x1
 962:	00e9f363          	bgeu	s3,a4,968 <malloc+0x42>
 966:	6a05                	lui	s4,0x1
 968:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 96c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 970:	00000497          	auipc	s1,0x0
 974:	69048493          	addi	s1,s1,1680 # 1000 <freep>
  if (p == SBRK_ERROR)
 978:	5afd                	li	s5,-1
 97a:	a83d                	j	9b8 <malloc+0x92>
 97c:	f426                	sd	s1,40(sp)
 97e:	e852                	sd	s4,16(sp)
 980:	e456                	sd	s5,8(sp)
 982:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 984:	00000797          	auipc	a5,0x0
 988:	68c78793          	addi	a5,a5,1676 # 1010 <base>
 98c:	00000717          	auipc	a4,0x0
 990:	66f73a23          	sd	a5,1652(a4) # 1000 <freep>
 994:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 996:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 99a:	b7d1                	j	95e <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 99c:	6398                	ld	a4,0(a5)
 99e:	e118                	sd	a4,0(a0)
 9a0:	a899                	j	9f6 <malloc+0xd0>
  hp->s.size = nu;
 9a2:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 9a6:	0541                	addi	a0,a0,16
 9a8:	ef5ff0ef          	jal	89c <free>
  return freep;
 9ac:	6088                	ld	a0,0(s1)
      if ((p = morecore(nunits)) == 0)
 9ae:	c125                	beqz	a0,a0e <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 9b0:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 9b2:	4798                	lw	a4,8(a5)
 9b4:	03277163          	bgeu	a4,s2,9d6 <malloc+0xb0>
    if (p == freep)
 9b8:	6098                	ld	a4,0(s1)
 9ba:	853e                	mv	a0,a5
 9bc:	fef71ae3          	bne	a4,a5,9b0 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 9c0:	8552                	mv	a0,s4
 9c2:	9ffff0ef          	jal	3c0 <sbrk>
  if (p == SBRK_ERROR)
 9c6:	fd551ee3          	bne	a0,s5,9a2 <malloc+0x7c>
        return 0;
 9ca:	4501                	li	a0,0
 9cc:	74a2                	ld	s1,40(sp)
 9ce:	6a42                	ld	s4,16(sp)
 9d0:	6aa2                	ld	s5,8(sp)
 9d2:	6b02                	ld	s6,0(sp)
 9d4:	a03d                	j	a02 <malloc+0xdc>
 9d6:	74a2                	ld	s1,40(sp)
 9d8:	6a42                	ld	s4,16(sp)
 9da:	6aa2                	ld	s5,8(sp)
 9dc:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
 9de:	fae90fe3          	beq	s2,a4,99c <malloc+0x76>
        p->s.size -= nunits;
 9e2:	4137073b          	subw	a4,a4,s3
 9e6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9e8:	02071693          	slli	a3,a4,0x20
 9ec:	01c6d713          	srli	a4,a3,0x1c
 9f0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9f2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9f6:	00000717          	auipc	a4,0x0
 9fa:	60a73523          	sd	a0,1546(a4) # 1000 <freep>
      return (void *)(p + 1);
 9fe:	01078513          	addi	a0,a5,16
  }
}
 a02:	70e2                	ld	ra,56(sp)
 a04:	7442                	ld	s0,48(sp)
 a06:	7902                	ld	s2,32(sp)
 a08:	69e2                	ld	s3,24(sp)
 a0a:	6121                	addi	sp,sp,64
 a0c:	8082                	ret
 a0e:	74a2                	ld	s1,40(sp)
 a10:	6a42                	ld	s4,16(sp)
 a12:	6aa2                	ld	s5,8(sp)
 a14:	6b02                	ld	s6,0(sp)
 a16:	b7f5                	j	a02 <malloc+0xdc>
