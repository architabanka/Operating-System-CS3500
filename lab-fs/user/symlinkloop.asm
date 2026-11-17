
user/_symlinkloop:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

#if defined(SYS_symlink) && defined(O_NOFOLLOW)

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  int fd;

  unlink("loop1");
   8:	00001517          	auipc	a0,0x1
   c:	9a850513          	addi	a0,a0,-1624 # 9b0 <malloc+0xf8>
  10:	3c6000ef          	jal	3d6 <unlink>
  unlink("loop2");
  14:	00001517          	auipc	a0,0x1
  18:	9ac50513          	addi	a0,a0,-1620 # 9c0 <malloc+0x108>
  1c:	3ba000ef          	jal	3d6 <unlink>

  // Create a symlink cycle: loop1 -> loop2 -> loop1
  if (symlink("loop2", "loop1") < 0) {
  20:	00001597          	auipc	a1,0x1
  24:	99058593          	addi	a1,a1,-1648 # 9b0 <malloc+0xf8>
  28:	00001517          	auipc	a0,0x1
  2c:	99850513          	addi	a0,a0,-1640 # 9c0 <malloc+0x108>
  30:	40e000ef          	jal	43e <symlink>
  34:	04054563          	bltz	a0,7e <main+0x7e>
    printf("symlinkloop: symlink loop1 failed\n");
    exit(1);
  }

  if (symlink("loop1", "loop2") < 0) {
  38:	00001597          	auipc	a1,0x1
  3c:	98858593          	addi	a1,a1,-1656 # 9c0 <malloc+0x108>
  40:	00001517          	auipc	a0,0x1
  44:	97050513          	addi	a0,a0,-1680 # 9b0 <malloc+0xf8>
  48:	3f6000ef          	jal	43e <symlink>
  4c:	04054363          	bltz	a0,92 <main+0x92>
  50:	e426                	sd	s1,8(sp)
    printf("symlinkloop: symlink loop2 failed\n");
    exit(1);
  }

  // Opening a cyclic symlink must fail (not hang or panic).
  fd = open("loop1", O_RDONLY);
  52:	4581                	li	a1,0
  54:	00001517          	auipc	a0,0x1
  58:	95c50513          	addi	a0,a0,-1700 # 9b0 <malloc+0xf8>
  5c:	36a000ef          	jal	3c6 <open>
  60:	84aa                	mv	s1,a0
  if (fd >= 0) {
  62:	04054263          	bltz	a0,a6 <main+0xa6>
    printf("symlinkloop: open loop should have failed\n");
  66:	00001517          	auipc	a0,0x1
  6a:	9b250513          	addi	a0,a0,-1614 # a18 <malloc+0x160>
  6e:	78e000ef          	jal	7fc <printf>
    close(fd);
  72:	8526                	mv	a0,s1
  74:	33a000ef          	jal	3ae <close>
    exit(1);
  78:	4505                	li	a0,1
  7a:	30c000ef          	jal	386 <exit>
  7e:	e426                	sd	s1,8(sp)
    printf("symlinkloop: symlink loop1 failed\n");
  80:	00001517          	auipc	a0,0x1
  84:	94850513          	addi	a0,a0,-1720 # 9c8 <malloc+0x110>
  88:	774000ef          	jal	7fc <printf>
    exit(1);
  8c:	4505                	li	a0,1
  8e:	2f8000ef          	jal	386 <exit>
  92:	e426                	sd	s1,8(sp)
    printf("symlinkloop: symlink loop2 failed\n");
  94:	00001517          	auipc	a0,0x1
  98:	95c50513          	addi	a0,a0,-1700 # 9f0 <malloc+0x138>
  9c:	760000ef          	jal	7fc <printf>
    exit(1);
  a0:	4505                	li	a0,1
  a2:	2e4000ef          	jal	386 <exit>
  }

  printf("symlinkloop: passed\n");
  a6:	00001517          	auipc	a0,0x1
  aa:	9a250513          	addi	a0,a0,-1630 # a48 <malloc+0x190>
  ae:	74e000ef          	jal	7fc <printf>

  unlink("loop1");
  b2:	00001517          	auipc	a0,0x1
  b6:	8fe50513          	addi	a0,a0,-1794 # 9b0 <malloc+0xf8>
  ba:	31c000ef          	jal	3d6 <unlink>
  unlink("loop2");
  be:	00001517          	auipc	a0,0x1
  c2:	90250513          	addi	a0,a0,-1790 # 9c0 <malloc+0x108>
  c6:	310000ef          	jal	3d6 <unlink>
  exit(0);
  ca:	4501                	li	a0,0
  cc:	2ba000ef          	jal	386 <exit>

00000000000000d0 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  d0:	1141                	addi	sp,sp,-16
  d2:	e406                	sd	ra,8(sp)
  d4:	e022                	sd	s0,0(sp)
  d6:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  d8:	f29ff0ef          	jal	0 <main>
  exit(r);
  dc:	2aa000ef          	jal	386 <exit>

00000000000000e0 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  e0:	1141                	addi	sp,sp,-16
  e2:	e406                	sd	ra,8(sp)
  e4:	e022                	sd	s0,0(sp)
  e6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  e8:	87aa                	mv	a5,a0
  ea:	0585                	addi	a1,a1,1
  ec:	0785                	addi	a5,a5,1
  ee:	fff5c703          	lbu	a4,-1(a1)
  f2:	fee78fa3          	sb	a4,-1(a5)
  f6:	fb75                	bnez	a4,ea <strcpy+0xa>
    ;
  return os;
}
  f8:	60a2                	ld	ra,8(sp)
  fa:	6402                	ld	s0,0(sp)
  fc:	0141                	addi	sp,sp,16
  fe:	8082                	ret

0000000000000100 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 100:	1141                	addi	sp,sp,-16
 102:	e406                	sd	ra,8(sp)
 104:	e022                	sd	s0,0(sp)
 106:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 108:	00054783          	lbu	a5,0(a0)
 10c:	cb91                	beqz	a5,120 <strcmp+0x20>
 10e:	0005c703          	lbu	a4,0(a1)
 112:	00f71763          	bne	a4,a5,120 <strcmp+0x20>
    p++, q++;
 116:	0505                	addi	a0,a0,1
 118:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 11a:	00054783          	lbu	a5,0(a0)
 11e:	fbe5                	bnez	a5,10e <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 120:	0005c503          	lbu	a0,0(a1)
}
 124:	40a7853b          	subw	a0,a5,a0
 128:	60a2                	ld	ra,8(sp)
 12a:	6402                	ld	s0,0(sp)
 12c:	0141                	addi	sp,sp,16
 12e:	8082                	ret

0000000000000130 <strlen>:

uint
strlen(const char *s)
{
 130:	1141                	addi	sp,sp,-16
 132:	e406                	sd	ra,8(sp)
 134:	e022                	sd	s0,0(sp)
 136:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 138:	00054783          	lbu	a5,0(a0)
 13c:	cf91                	beqz	a5,158 <strlen+0x28>
 13e:	00150793          	addi	a5,a0,1
 142:	86be                	mv	a3,a5
 144:	0785                	addi	a5,a5,1
 146:	fff7c703          	lbu	a4,-1(a5)
 14a:	ff65                	bnez	a4,142 <strlen+0x12>
 14c:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 150:	60a2                	ld	ra,8(sp)
 152:	6402                	ld	s0,0(sp)
 154:	0141                	addi	sp,sp,16
 156:	8082                	ret
  for (n = 0; s[n]; n++)
 158:	4501                	li	a0,0
 15a:	bfdd                	j	150 <strlen+0x20>

000000000000015c <memset>:

void *
memset(void *dst, int c, uint n)
{
 15c:	1141                	addi	sp,sp,-16
 15e:	e406                	sd	ra,8(sp)
 160:	e022                	sd	s0,0(sp)
 162:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 164:	ca19                	beqz	a2,17a <memset+0x1e>
 166:	87aa                	mv	a5,a0
 168:	1602                	slli	a2,a2,0x20
 16a:	9201                	srli	a2,a2,0x20
 16c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 170:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 174:	0785                	addi	a5,a5,1
 176:	fee79de3          	bne	a5,a4,170 <memset+0x14>
  }
  return dst;
}
 17a:	60a2                	ld	ra,8(sp)
 17c:	6402                	ld	s0,0(sp)
 17e:	0141                	addi	sp,sp,16
 180:	8082                	ret

0000000000000182 <strchr>:

char *
strchr(const char *s, char c)
{
 182:	1141                	addi	sp,sp,-16
 184:	e406                	sd	ra,8(sp)
 186:	e022                	sd	s0,0(sp)
 188:	0800                	addi	s0,sp,16
  for (; *s; s++)
 18a:	00054783          	lbu	a5,0(a0)
 18e:	c799                	beqz	a5,19c <strchr+0x1a>
    if (*s == c)
 190:	00f58763          	beq	a1,a5,19e <strchr+0x1c>
  for (; *s; s++)
 194:	0505                	addi	a0,a0,1
 196:	00054783          	lbu	a5,0(a0)
 19a:	fbfd                	bnez	a5,190 <strchr+0xe>
      return (char *)s;
  return 0;
 19c:	4501                	li	a0,0
}
 19e:	60a2                	ld	ra,8(sp)
 1a0:	6402                	ld	s0,0(sp)
 1a2:	0141                	addi	sp,sp,16
 1a4:	8082                	ret

00000000000001a6 <gets>:

char *
gets(char *buf, int max)
{
 1a6:	711d                	addi	sp,sp,-96
 1a8:	ec86                	sd	ra,88(sp)
 1aa:	e8a2                	sd	s0,80(sp)
 1ac:	e4a6                	sd	s1,72(sp)
 1ae:	e0ca                	sd	s2,64(sp)
 1b0:	fc4e                	sd	s3,56(sp)
 1b2:	f852                	sd	s4,48(sp)
 1b4:	f456                	sd	s5,40(sp)
 1b6:	f05a                	sd	s6,32(sp)
 1b8:	ec5e                	sd	s7,24(sp)
 1ba:	e862                	sd	s8,16(sp)
 1bc:	1080                	addi	s0,sp,96
 1be:	8baa                	mv	s7,a0
 1c0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 1c2:	892a                	mv	s2,a0
 1c4:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1c6:	faf40b13          	addi	s6,s0,-81
 1ca:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;) {
 1cc:	8c26                	mv	s8,s1
 1ce:	0014899b          	addiw	s3,s1,1
 1d2:	84ce                	mv	s1,s3
 1d4:	0349d863          	bge	s3,s4,204 <gets+0x5e>
    cc = read(0, &c, 1);
 1d8:	8656                	mv	a2,s5
 1da:	85da                	mv	a1,s6
 1dc:	4501                	li	a0,0
 1de:	1c0000ef          	jal	39e <read>
    if (cc < 1)
 1e2:	02a05163          	blez	a0,204 <gets+0x5e>
      break;
    buf[i++] = c;
 1e6:	faf44783          	lbu	a5,-81(s0)
 1ea:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 1ee:	0905                	addi	s2,s2,1
 1f0:	ff678713          	addi	a4,a5,-10
 1f4:	00173713          	seqz	a4,a4
 1f8:	17cd                	addi	a5,a5,-13
 1fa:	0017b793          	seqz	a5,a5
 1fe:	8fd9                	or	a5,a5,a4
 200:	d7f1                	beqz	a5,1cc <gets+0x26>
    buf[i++] = c;
 202:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 204:	9c5e                	add	s8,s8,s7
 206:	000c0023          	sb	zero,0(s8)
  return buf;
}
 20a:	855e                	mv	a0,s7
 20c:	60e6                	ld	ra,88(sp)
 20e:	6446                	ld	s0,80(sp)
 210:	64a6                	ld	s1,72(sp)
 212:	6906                	ld	s2,64(sp)
 214:	79e2                	ld	s3,56(sp)
 216:	7a42                	ld	s4,48(sp)
 218:	7aa2                	ld	s5,40(sp)
 21a:	7b02                	ld	s6,32(sp)
 21c:	6be2                	ld	s7,24(sp)
 21e:	6c42                	ld	s8,16(sp)
 220:	6125                	addi	sp,sp,96
 222:	8082                	ret

0000000000000224 <stat>:

int
stat(const char *n, struct stat *st)
{
 224:	1101                	addi	sp,sp,-32
 226:	ec06                	sd	ra,24(sp)
 228:	e822                	sd	s0,16(sp)
 22a:	e04a                	sd	s2,0(sp)
 22c:	1000                	addi	s0,sp,32
 22e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 230:	4581                	li	a1,0
 232:	194000ef          	jal	3c6 <open>
  if (fd < 0)
 236:	02054263          	bltz	a0,25a <stat+0x36>
 23a:	e426                	sd	s1,8(sp)
 23c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 23e:	85ca                	mv	a1,s2
 240:	19e000ef          	jal	3de <fstat>
 244:	892a                	mv	s2,a0
  close(fd);
 246:	8526                	mv	a0,s1
 248:	166000ef          	jal	3ae <close>
  return r;
 24c:	64a2                	ld	s1,8(sp)
}
 24e:	854a                	mv	a0,s2
 250:	60e2                	ld	ra,24(sp)
 252:	6442                	ld	s0,16(sp)
 254:	6902                	ld	s2,0(sp)
 256:	6105                	addi	sp,sp,32
 258:	8082                	ret
    return -1;
 25a:	57fd                	li	a5,-1
 25c:	893e                	mv	s2,a5
 25e:	bfc5                	j	24e <stat+0x2a>

0000000000000260 <atoi>:

int
atoi(const char *s)
{
 260:	1141                	addi	sp,sp,-16
 262:	e406                	sd	ra,8(sp)
 264:	e022                	sd	s0,0(sp)
 266:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 268:	00054683          	lbu	a3,0(a0)
 26c:	fd06879b          	addiw	a5,a3,-48
 270:	0ff7f793          	zext.b	a5,a5
 274:	4625                	li	a2,9
 276:	02f66963          	bltu	a2,a5,2a8 <atoi+0x48>
 27a:	872a                	mv	a4,a0
  n = 0;
 27c:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 27e:	0705                	addi	a4,a4,1
 280:	0025179b          	slliw	a5,a0,0x2
 284:	9fa9                	addw	a5,a5,a0
 286:	0017979b          	slliw	a5,a5,0x1
 28a:	9fb5                	addw	a5,a5,a3
 28c:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 290:	00074683          	lbu	a3,0(a4)
 294:	fd06879b          	addiw	a5,a3,-48
 298:	0ff7f793          	zext.b	a5,a5
 29c:	fef671e3          	bgeu	a2,a5,27e <atoi+0x1e>
  return n;
}
 2a0:	60a2                	ld	ra,8(sp)
 2a2:	6402                	ld	s0,0(sp)
 2a4:	0141                	addi	sp,sp,16
 2a6:	8082                	ret
  n = 0;
 2a8:	4501                	li	a0,0
 2aa:	bfdd                	j	2a0 <atoi+0x40>

00000000000002ac <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 2ac:	1141                	addi	sp,sp,-16
 2ae:	e406                	sd	ra,8(sp)
 2b0:	e022                	sd	s0,0(sp)
 2b2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2b4:	02b57563          	bgeu	a0,a1,2de <memmove+0x32>
    while (n-- > 0)
 2b8:	00c05f63          	blez	a2,2d6 <memmove+0x2a>
 2bc:	1602                	slli	a2,a2,0x20
 2be:	9201                	srli	a2,a2,0x20
 2c0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2c4:	872a                	mv	a4,a0
      *dst++ = *src++;
 2c6:	0585                	addi	a1,a1,1
 2c8:	0705                	addi	a4,a4,1
 2ca:	fff5c683          	lbu	a3,-1(a1)
 2ce:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 2d2:	fee79ae3          	bne	a5,a4,2c6 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2d6:	60a2                	ld	ra,8(sp)
 2d8:	6402                	ld	s0,0(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret
    while (n-- > 0)
 2de:	fec05ce3          	blez	a2,2d6 <memmove+0x2a>
    dst += n;
 2e2:	00c50733          	add	a4,a0,a2
    src += n;
 2e6:	95b2                	add	a1,a1,a2
 2e8:	fff6079b          	addiw	a5,a2,-1
 2ec:	1782                	slli	a5,a5,0x20
 2ee:	9381                	srli	a5,a5,0x20
 2f0:	fff7c793          	not	a5,a5
 2f4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2f6:	15fd                	addi	a1,a1,-1
 2f8:	177d                	addi	a4,a4,-1
 2fa:	0005c683          	lbu	a3,0(a1)
 2fe:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 302:	fef71ae3          	bne	a4,a5,2f6 <memmove+0x4a>
 306:	bfc1                	j	2d6 <memmove+0x2a>

0000000000000308 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 308:	1141                	addi	sp,sp,-16
 30a:	e406                	sd	ra,8(sp)
 30c:	e022                	sd	s0,0(sp)
 30e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 310:	ce19                	beqz	a2,32e <memcmp+0x26>
 312:	1602                	slli	a2,a2,0x20
 314:	9201                	srli	a2,a2,0x20
 316:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 31a:	00054783          	lbu	a5,0(a0)
 31e:	0005c703          	lbu	a4,0(a1)
 322:	00e79b63          	bne	a5,a4,338 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 326:	0505                	addi	a0,a0,1
    p2++;
 328:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 32a:	fed518e3          	bne	a0,a3,31a <memcmp+0x12>
  }
  return 0;
 32e:	4501                	li	a0,0
}
 330:	60a2                	ld	ra,8(sp)
 332:	6402                	ld	s0,0(sp)
 334:	0141                	addi	sp,sp,16
 336:	8082                	ret
      return *p1 - *p2;
 338:	40e7853b          	subw	a0,a5,a4
 33c:	bfd5                	j	330 <memcmp+0x28>

000000000000033e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 33e:	1141                	addi	sp,sp,-16
 340:	e406                	sd	ra,8(sp)
 342:	e022                	sd	s0,0(sp)
 344:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 346:	f67ff0ef          	jal	2ac <memmove>
}
 34a:	60a2                	ld	ra,8(sp)
 34c:	6402                	ld	s0,0(sp)
 34e:	0141                	addi	sp,sp,16
 350:	8082                	ret

0000000000000352 <sbrk>:

char *
sbrk(int n)
{
 352:	1141                	addi	sp,sp,-16
 354:	e406                	sd	ra,8(sp)
 356:	e022                	sd	s0,0(sp)
 358:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 35a:	4585                	li	a1,1
 35c:	0b2000ef          	jal	40e <sys_sbrk>
}
 360:	60a2                	ld	ra,8(sp)
 362:	6402                	ld	s0,0(sp)
 364:	0141                	addi	sp,sp,16
 366:	8082                	ret

0000000000000368 <sbrklazy>:

char *
sbrklazy(int n)
{
 368:	1141                	addi	sp,sp,-16
 36a:	e406                	sd	ra,8(sp)
 36c:	e022                	sd	s0,0(sp)
 36e:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 370:	4589                	li	a1,2
 372:	09c000ef          	jal	40e <sys_sbrk>
}
 376:	60a2                	ld	ra,8(sp)
 378:	6402                	ld	s0,0(sp)
 37a:	0141                	addi	sp,sp,16
 37c:	8082                	ret

000000000000037e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 37e:	4885                	li	a7,1
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <exit>:
.global exit
exit:
 li a7, SYS_exit
 386:	4889                	li	a7,2
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <wait>:
.global wait
wait:
 li a7, SYS_wait
 38e:	488d                	li	a7,3
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 396:	4891                	li	a7,4
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <read>:
.global read
read:
 li a7, SYS_read
 39e:	4895                	li	a7,5
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <write>:
.global write
write:
 li a7, SYS_write
 3a6:	48c1                	li	a7,16
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <close>:
.global close
close:
 li a7, SYS_close
 3ae:	48d5                	li	a7,21
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3b6:	4899                	li	a7,6
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <exec>:
.global exec
exec:
 li a7, SYS_exec
 3be:	489d                	li	a7,7
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <open>:
.global open
open:
 li a7, SYS_open
 3c6:	48bd                	li	a7,15
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3ce:	48c5                	li	a7,17
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3d6:	48c9                	li	a7,18
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3de:	48a1                	li	a7,8
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <link>:
.global link
link:
 li a7, SYS_link
 3e6:	48cd                	li	a7,19
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3ee:	48d1                	li	a7,20
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3f6:	48a5                	li	a7,9
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <dup>:
.global dup
dup:
 li a7, SYS_dup
 3fe:	48a9                	li	a7,10
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 406:	48ad                	li	a7,11
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 40e:	48b1                	li	a7,12
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <pause>:
.global pause
pause:
 li a7, SYS_pause
 416:	48b5                	li	a7,13
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 41e:	48b9                	li	a7,14
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <sync>:
.global sync
sync:
 li a7, SYS_sync
 426:	48d9                	li	a7,22
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <istat>:
.global istat
istat:
 li a7, SYS_istat
 42e:	48dd                	li	a7,23
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <iprint>:
.global iprint
iprint:
 li a7, SYS_iprint
 436:	48e1                	li	a7,24
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <symlink>:
.global symlink
symlink:
 li a7, SYS_symlink
 43e:	48e5                	li	a7,25
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 446:	1101                	addi	sp,sp,-32
 448:	ec06                	sd	ra,24(sp)
 44a:	e822                	sd	s0,16(sp)
 44c:	1000                	addi	s0,sp,32
 44e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 452:	4605                	li	a2,1
 454:	fef40593          	addi	a1,s0,-17
 458:	f4fff0ef          	jal	3a6 <write>
}
 45c:	60e2                	ld	ra,24(sp)
 45e:	6442                	ld	s0,16(sp)
 460:	6105                	addi	sp,sp,32
 462:	8082                	ret

0000000000000464 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 464:	715d                	addi	sp,sp,-80
 466:	e486                	sd	ra,72(sp)
 468:	e0a2                	sd	s0,64(sp)
 46a:	f84a                	sd	s2,48(sp)
 46c:	f44e                	sd	s3,40(sp)
 46e:	0880                	addi	s0,sp,80
 470:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 472:	00d036b3          	snez	a3,a3
 476:	03f5d793          	srli	a5,a1,0x3f
 47a:	8efd                	and	a3,a3,a5
  neg = 0;
 47c:	4301                	li	t1,0
  if (sgn && xx < 0) {
 47e:	c681                	beqz	a3,486 <printint+0x22>
    neg = 1;
    x = -xx;
 480:	40b005b3          	neg	a1,a1
    neg = 1;
 484:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 486:	fb840993          	addi	s3,s0,-72
  neg = 0;
 48a:	86ce                	mv	a3,s3
  i = 0;
 48c:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
 48e:	00000817          	auipc	a6,0x0
 492:	5da80813          	addi	a6,a6,1498 # a68 <digits>
 496:	88ba                	mv	a7,a4
 498:	0017051b          	addiw	a0,a4,1
 49c:	872a                	mv	a4,a0
 49e:	02c5f7b3          	remu	a5,a1,a2
 4a2:	97c2                	add	a5,a5,a6
 4a4:	0007c783          	lbu	a5,0(a5)
 4a8:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
 4ac:	87ae                	mv	a5,a1
 4ae:	02c5d5b3          	divu	a1,a1,a2
 4b2:	0685                	addi	a3,a3,1
 4b4:	fec7f1e3          	bgeu	a5,a2,496 <printint+0x32>
  if (neg)
 4b8:	00030b63          	beqz	t1,4ce <printint+0x6a>
    buf[i++] = '-';
 4bc:	fd040793          	addi	a5,s0,-48
 4c0:	953e                	add	a0,a0,a5
 4c2:	02d00793          	li	a5,45
 4c6:	fef50423          	sb	a5,-24(a0)
 4ca:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
 4ce:	02e05563          	blez	a4,4f8 <printint+0x94>
 4d2:	fc26                	sd	s1,56(sp)
 4d4:	377d                	addiw	a4,a4,-1
 4d6:	00e984b3          	add	s1,s3,a4
 4da:	19fd                	addi	s3,s3,-1
 4dc:	99ba                	add	s3,s3,a4
 4de:	1702                	slli	a4,a4,0x20
 4e0:	9301                	srli	a4,a4,0x20
 4e2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4e6:	0004c583          	lbu	a1,0(s1)
 4ea:	854a                	mv	a0,s2
 4ec:	f5bff0ef          	jal	446 <putc>
  while (--i >= 0)
 4f0:	14fd                	addi	s1,s1,-1
 4f2:	ff349ae3          	bne	s1,s3,4e6 <printint+0x82>
 4f6:	74e2                	ld	s1,56(sp)
}
 4f8:	60a6                	ld	ra,72(sp)
 4fa:	6406                	ld	s0,64(sp)
 4fc:	7942                	ld	s2,48(sp)
 4fe:	79a2                	ld	s3,40(sp)
 500:	6161                	addi	sp,sp,80
 502:	8082                	ret

0000000000000504 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 504:	711d                	addi	sp,sp,-96
 506:	ec86                	sd	ra,88(sp)
 508:	e8a2                	sd	s0,80(sp)
 50a:	e4a6                	sd	s1,72(sp)
 50c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 50e:	0005c483          	lbu	s1,0(a1)
 512:	2a048063          	beqz	s1,7b2 <vprintf+0x2ae>
 516:	e0ca                	sd	s2,64(sp)
 518:	fc4e                	sd	s3,56(sp)
 51a:	f852                	sd	s4,48(sp)
 51c:	f456                	sd	s5,40(sp)
 51e:	f05a                	sd	s6,32(sp)
 520:	ec5e                	sd	s7,24(sp)
 522:	e862                	sd	s8,16(sp)
 524:	8b2a                	mv	s6,a0
 526:	8a2e                	mv	s4,a1
 528:	8bb2                	mv	s7,a2
  state = 0;
 52a:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 52c:	4901                	li	s2,0
 52e:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 530:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 534:	06400c13          	li	s8,100
 538:	a00d                	j	55a <vprintf+0x56>
        putc(fd, c0);
 53a:	85a6                	mv	a1,s1
 53c:	855a                	mv	a0,s6
 53e:	f09ff0ef          	jal	446 <putc>
 542:	a019                	j	548 <vprintf+0x44>
    } else if (state == '%') {
 544:	03598363          	beq	s3,s5,56a <vprintf+0x66>
  for (i = 0; fmt[i]; i++) {
 548:	0019079b          	addiw	a5,s2,1
 54c:	893e                	mv	s2,a5
 54e:	873e                	mv	a4,a5
 550:	97d2                	add	a5,a5,s4
 552:	0007c483          	lbu	s1,0(a5)
 556:	24048763          	beqz	s1,7a4 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 55a:	0004879b          	sext.w	a5,s1
    if (state == 0) {
 55e:	fe0993e3          	bnez	s3,544 <vprintf+0x40>
      if (c0 == '%') {
 562:	fd579ce3          	bne	a5,s5,53a <vprintf+0x36>
        state = '%';
 566:	89be                	mv	s3,a5
 568:	b7c5                	j	548 <vprintf+0x44>
        c1 = fmt[i + 1] & 0xff;
 56a:	00ea06b3          	add	a3,s4,a4
 56e:	0016c603          	lbu	a2,1(a3)
      if (c1)
 572:	24060563          	beqz	a2,7bc <vprintf+0x2b8>
      if (c0 == 'd') {
 576:	0b878763          	beq	a5,s8,624 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 57a:	f9478693          	addi	a3,a5,-108
 57e:	0016b693          	seqz	a3,a3
 582:	f9c60593          	addi	a1,a2,-100
 586:	0015b593          	seqz	a1,a1
 58a:	8df5                	and	a1,a1,a3
 58c:	e9c5                	bnez	a1,63c <vprintf+0x138>
        c2 = fmt[i + 2] & 0xff;
 58e:	9752                	add	a4,a4,s4
 590:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 594:	f9460713          	addi	a4,a2,-108
 598:	00173713          	seqz	a4,a4
 59c:	8f75                	and	a4,a4,a3
 59e:	f9c50593          	addi	a1,a0,-100
 5a2:	0015b593          	seqz	a1,a1
 5a6:	8df9                	and	a1,a1,a4
 5a8:	e5dd                	bnez	a1,656 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 5aa:	07500593          	li	a1,117
 5ae:	0cb78163          	beq	a5,a1,670 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if (c0 == 'l' && c1 == 'u') {
 5b2:	f8b60593          	addi	a1,a2,-117
 5b6:	0015b593          	seqz	a1,a1
 5ba:	8df5                	and	a1,a1,a3
 5bc:	e5f1                	bnez	a1,688 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 5be:	f8b50593          	addi	a1,a0,-117
 5c2:	0015b593          	seqz	a1,a1
 5c6:	8df9                	and	a1,a1,a4
 5c8:	ede9                	bnez	a1,6a2 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 5ca:	07800593          	li	a1,120
 5ce:	0eb78763          	beq	a5,a1,6bc <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if (c0 == 'l' && c1 == 'x') {
 5d2:	f8860613          	addi	a2,a2,-120
 5d6:	00163613          	seqz	a2,a2
 5da:	8ef1                	and	a3,a3,a2
 5dc:	0e069c63          	bnez	a3,6d4 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 5e0:	f8850513          	addi	a0,a0,-120
 5e4:	00153513          	seqz	a0,a0
 5e8:	8f69                	and	a4,a4,a0
 5ea:	10071263          	bnez	a4,6ee <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 5ee:	07000713          	li	a4,112
 5f2:	10e78a63          	beq	a5,a4,706 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 5f6:	06300713          	li	a4,99
 5fa:	14e78a63          	beq	a5,a4,74e <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 5fe:	07300713          	li	a4,115
 602:	16e78063          	beq	a5,a4,762 <vprintf+0x25e>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 606:	02500713          	li	a4,37
 60a:	18e78863          	beq	a5,a4,79a <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 60e:	02500593          	li	a1,37
 612:	855a                	mv	a0,s6
 614:	e33ff0ef          	jal	446 <putc>
        putc(fd, c0);
 618:	85a6                	mv	a1,s1
 61a:	855a                	mv	a0,s6
 61c:	e2bff0ef          	jal	446 <putc>
      }

      state = 0;
 620:	4981                	li	s3,0
 622:	b71d                	j	548 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 624:	008b8493          	addi	s1,s7,8
 628:	4685                	li	a3,1
 62a:	4629                	li	a2,10
 62c:	000ba583          	lw	a1,0(s7)
 630:	855a                	mv	a0,s6
 632:	e33ff0ef          	jal	464 <printint>
 636:	8ba6                	mv	s7,s1
      state = 0;
 638:	4981                	li	s3,0
 63a:	b739                	j	548 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 63c:	008b8493          	addi	s1,s7,8
 640:	4685                	li	a3,1
 642:	4629                	li	a2,10
 644:	000bb583          	ld	a1,0(s7)
 648:	855a                	mv	a0,s6
 64a:	e1bff0ef          	jal	464 <printint>
        i += 1;
 64e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 650:	8ba6                	mv	s7,s1
      state = 0;
 652:	4981                	li	s3,0
 654:	bdd5                	j	548 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 656:	008b8493          	addi	s1,s7,8
 65a:	4685                	li	a3,1
 65c:	4629                	li	a2,10
 65e:	000bb583          	ld	a1,0(s7)
 662:	855a                	mv	a0,s6
 664:	e01ff0ef          	jal	464 <printint>
        i += 2;
 668:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 66a:	8ba6                	mv	s7,s1
      state = 0;
 66c:	4981                	li	s3,0
        i += 2;
 66e:	bde9                	j	548 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 670:	008b8493          	addi	s1,s7,8
 674:	4681                	li	a3,0
 676:	4629                	li	a2,10
 678:	000be583          	lwu	a1,0(s7)
 67c:	855a                	mv	a0,s6
 67e:	de7ff0ef          	jal	464 <printint>
 682:	8ba6                	mv	s7,s1
      state = 0;
 684:	4981                	li	s3,0
 686:	b5c9                	j	548 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 688:	008b8493          	addi	s1,s7,8
 68c:	4681                	li	a3,0
 68e:	4629                	li	a2,10
 690:	000bb583          	ld	a1,0(s7)
 694:	855a                	mv	a0,s6
 696:	dcfff0ef          	jal	464 <printint>
        i += 1;
 69a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 69c:	8ba6                	mv	s7,s1
      state = 0;
 69e:	4981                	li	s3,0
 6a0:	b565                	j	548 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a2:	008b8493          	addi	s1,s7,8
 6a6:	4681                	li	a3,0
 6a8:	4629                	li	a2,10
 6aa:	000bb583          	ld	a1,0(s7)
 6ae:	855a                	mv	a0,s6
 6b0:	db5ff0ef          	jal	464 <printint>
        i += 2;
 6b4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b6:	8ba6                	mv	s7,s1
      state = 0;
 6b8:	4981                	li	s3,0
        i += 2;
 6ba:	b579                	j	548 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6bc:	008b8493          	addi	s1,s7,8
 6c0:	4681                	li	a3,0
 6c2:	4641                	li	a2,16
 6c4:	000be583          	lwu	a1,0(s7)
 6c8:	855a                	mv	a0,s6
 6ca:	d9bff0ef          	jal	464 <printint>
 6ce:	8ba6                	mv	s7,s1
      state = 0;
 6d0:	4981                	li	s3,0
 6d2:	bd9d                	j	548 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d4:	008b8493          	addi	s1,s7,8
 6d8:	4681                	li	a3,0
 6da:	4641                	li	a2,16
 6dc:	000bb583          	ld	a1,0(s7)
 6e0:	855a                	mv	a0,s6
 6e2:	d83ff0ef          	jal	464 <printint>
        i += 1;
 6e6:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6e8:	8ba6                	mv	s7,s1
      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	bdb1                	j	548 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6ee:	008b8493          	addi	s1,s7,8
 6f2:	4641                	li	a2,16
 6f4:	000bb583          	ld	a1,0(s7)
 6f8:	855a                	mv	a0,s6
 6fa:	d6bff0ef          	jal	464 <printint>
        i += 2;
 6fe:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 700:	8ba6                	mv	s7,s1
      state = 0;
 702:	4981                	li	s3,0
        i += 2;
 704:	b591                	j	548 <vprintf+0x44>
 706:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 708:	008b8793          	addi	a5,s7,8
 70c:	8cbe                	mv	s9,a5
 70e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 712:	03000593          	li	a1,48
 716:	855a                	mv	a0,s6
 718:	d2fff0ef          	jal	446 <putc>
  putc(fd, 'x');
 71c:	07800593          	li	a1,120
 720:	855a                	mv	a0,s6
 722:	d25ff0ef          	jal	446 <putc>
 726:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 728:	00000b97          	auipc	s7,0x0
 72c:	340b8b93          	addi	s7,s7,832 # a68 <digits>
 730:	03c9d793          	srli	a5,s3,0x3c
 734:	97de                	add	a5,a5,s7
 736:	0007c583          	lbu	a1,0(a5)
 73a:	855a                	mv	a0,s6
 73c:	d0bff0ef          	jal	446 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 740:	0992                	slli	s3,s3,0x4
 742:	34fd                	addiw	s1,s1,-1
 744:	f4f5                	bnez	s1,730 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 746:	8be6                	mv	s7,s9
      state = 0;
 748:	4981                	li	s3,0
 74a:	6ca2                	ld	s9,8(sp)
 74c:	bbf5                	j	548 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 74e:	008b8493          	addi	s1,s7,8
 752:	000bc583          	lbu	a1,0(s7)
 756:	855a                	mv	a0,s6
 758:	cefff0ef          	jal	446 <putc>
 75c:	8ba6                	mv	s7,s1
      state = 0;
 75e:	4981                	li	s3,0
 760:	b3e5                	j	548 <vprintf+0x44>
        if ((s = va_arg(ap, char *)) == 0)
 762:	008b8993          	addi	s3,s7,8
 766:	000bb483          	ld	s1,0(s7)
 76a:	cc91                	beqz	s1,786 <vprintf+0x282>
        for (; *s; s++)
 76c:	0004c583          	lbu	a1,0(s1)
 770:	c195                	beqz	a1,794 <vprintf+0x290>
          putc(fd, *s);
 772:	855a                	mv	a0,s6
 774:	cd3ff0ef          	jal	446 <putc>
        for (; *s; s++)
 778:	0485                	addi	s1,s1,1
 77a:	0004c583          	lbu	a1,0(s1)
 77e:	f9f5                	bnez	a1,772 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 780:	8bce                	mv	s7,s3
      state = 0;
 782:	4981                	li	s3,0
 784:	b3d1                	j	548 <vprintf+0x44>
          s = "(null)";
 786:	00000497          	auipc	s1,0x0
 78a:	2da48493          	addi	s1,s1,730 # a60 <malloc+0x1a8>
        for (; *s; s++)
 78e:	02800593          	li	a1,40
 792:	b7c5                	j	772 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 794:	8bce                	mv	s7,s3
      state = 0;
 796:	4981                	li	s3,0
 798:	bb45                	j	548 <vprintf+0x44>
        putc(fd, '%');
 79a:	85be                	mv	a1,a5
 79c:	855a                	mv	a0,s6
 79e:	ca9ff0ef          	jal	446 <putc>
 7a2:	bdbd                	j	620 <vprintf+0x11c>
 7a4:	6906                	ld	s2,64(sp)
 7a6:	79e2                	ld	s3,56(sp)
 7a8:	7a42                	ld	s4,48(sp)
 7aa:	7aa2                	ld	s5,40(sp)
 7ac:	7b02                	ld	s6,32(sp)
 7ae:	6be2                	ld	s7,24(sp)
 7b0:	6c42                	ld	s8,16(sp)
    }
  }
}
 7b2:	60e6                	ld	ra,88(sp)
 7b4:	6446                	ld	s0,80(sp)
 7b6:	64a6                	ld	s1,72(sp)
 7b8:	6125                	addi	sp,sp,96
 7ba:	8082                	ret
      if (c0 == 'd') {
 7bc:	06400713          	li	a4,100
 7c0:	e6e782e3          	beq	a5,a4,624 <vprintf+0x120>
      } else if (c0 == 'l' && c1 == 'd') {
 7c4:	f9478693          	addi	a3,a5,-108
 7c8:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 7cc:	8532                	mv	a0,a2
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 7ce:	4701                	li	a4,0
 7d0:	bbe9                	j	5aa <vprintf+0xa6>

00000000000007d2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7d2:	715d                	addi	sp,sp,-80
 7d4:	ec06                	sd	ra,24(sp)
 7d6:	e822                	sd	s0,16(sp)
 7d8:	1000                	addi	s0,sp,32
 7da:	e010                	sd	a2,0(s0)
 7dc:	e414                	sd	a3,8(s0)
 7de:	e818                	sd	a4,16(s0)
 7e0:	ec1c                	sd	a5,24(s0)
 7e2:	03043023          	sd	a6,32(s0)
 7e6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7ea:	8622                	mv	a2,s0
 7ec:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7f0:	d15ff0ef          	jal	504 <vprintf>
}
 7f4:	60e2                	ld	ra,24(sp)
 7f6:	6442                	ld	s0,16(sp)
 7f8:	6161                	addi	sp,sp,80
 7fa:	8082                	ret

00000000000007fc <printf>:

void
printf(const char *fmt, ...)
{
 7fc:	711d                	addi	sp,sp,-96
 7fe:	ec06                	sd	ra,24(sp)
 800:	e822                	sd	s0,16(sp)
 802:	1000                	addi	s0,sp,32
 804:	e40c                	sd	a1,8(s0)
 806:	e810                	sd	a2,16(s0)
 808:	ec14                	sd	a3,24(s0)
 80a:	f018                	sd	a4,32(s0)
 80c:	f41c                	sd	a5,40(s0)
 80e:	03043823          	sd	a6,48(s0)
 812:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 816:	00840613          	addi	a2,s0,8
 81a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 81e:	85aa                	mv	a1,a0
 820:	4505                	li	a0,1
 822:	ce3ff0ef          	jal	504 <vprintf>
}
 826:	60e2                	ld	ra,24(sp)
 828:	6442                	ld	s0,16(sp)
 82a:	6125                	addi	sp,sp,96
 82c:	8082                	ret

000000000000082e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 82e:	1141                	addi	sp,sp,-16
 830:	e406                	sd	ra,8(sp)
 832:	e022                	sd	s0,0(sp)
 834:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 836:	ff050713          	addi	a4,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83a:	00000797          	auipc	a5,0x0
 83e:	7c67b783          	ld	a5,1990(a5) # 1000 <freep>
 842:	a095                	j	8a6 <free+0x78>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
 844:	ff852583          	lw	a1,-8(a0)
 848:	6390                	ld	a2,0(a5)
 84a:	02059813          	slli	a6,a1,0x20
 84e:	01c85693          	srli	a3,a6,0x1c
 852:	96ba                	add	a3,a3,a4
 854:	02d60563          	beq	a2,a3,87e <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 858:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
 85c:	4790                	lw	a2,8(a5)
 85e:	02061593          	slli	a1,a2,0x20
 862:	01c5d693          	srli	a3,a1,0x1c
 866:	96be                	add	a3,a3,a5
 868:	02d70263          	beq	a4,a3,88c <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 86c:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 86e:	00000717          	auipc	a4,0x0
 872:	78f73923          	sd	a5,1938(a4) # 1000 <freep>
}
 876:	60a2                	ld	ra,8(sp)
 878:	6402                	ld	s0,0(sp)
 87a:	0141                	addi	sp,sp,16
 87c:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 87e:	4614                	lw	a3,8(a2)
 880:	9ead                	addw	a3,a3,a1
 882:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 886:	6394                	ld	a3,0(a5)
 888:	6290                	ld	a2,0(a3)
 88a:	b7f9                	j	858 <free+0x2a>
    p->s.size += bp->s.size;
 88c:	ff852703          	lw	a4,-8(a0)
 890:	9f31                	addw	a4,a4,a2
 892:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 894:	ff053703          	ld	a4,-16(a0)
 898:	bfd1                	j	86c <free+0x3e>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 89a:	6394                	ld	a3,0(a5)
 89c:	00d7e463          	bltu	a5,a3,8a4 <free+0x76>
 8a0:	fad762e3          	bltu	a4,a3,844 <free+0x16>
 8a4:	87b6                	mv	a5,a3
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a6:	fee7fae3          	bgeu	a5,a4,89a <free+0x6c>
 8aa:	6394                	ld	a3,0(a5)
 8ac:	f8d76ce3          	bltu	a4,a3,844 <free+0x16>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b0:	f8d7fae3          	bgeu	a5,a3,844 <free+0x16>
 8b4:	87b6                	mv	a5,a3
 8b6:	bfc5                	j	8a6 <free+0x78>

00000000000008b8 <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
 8b8:	7139                	addi	sp,sp,-64
 8ba:	fc06                	sd	ra,56(sp)
 8bc:	f822                	sd	s0,48(sp)
 8be:	f04a                	sd	s2,32(sp)
 8c0:	ec4e                	sd	s3,24(sp)
 8c2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 8c4:	02051993          	slli	s3,a0,0x20
 8c8:	0209d993          	srli	s3,s3,0x20
 8cc:	09bd                	addi	s3,s3,15
 8ce:	0049d993          	srli	s3,s3,0x4
 8d2:	2985                	addiw	s3,s3,1
 8d4:	894e                	mv	s2,s3
  if ((prevp = freep) == 0) {
 8d6:	00000517          	auipc	a0,0x0
 8da:	72a53503          	ld	a0,1834(a0) # 1000 <freep>
 8de:	c905                	beqz	a0,90e <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 8e0:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 8e2:	4798                	lw	a4,8(a5)
 8e4:	09377663          	bgeu	a4,s3,970 <malloc+0xb8>
 8e8:	f426                	sd	s1,40(sp)
 8ea:	e852                	sd	s4,16(sp)
 8ec:	e456                	sd	s5,8(sp)
 8ee:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 8f0:	8a4e                	mv	s4,s3
 8f2:	6705                	lui	a4,0x1
 8f4:	00e9f363          	bgeu	s3,a4,8fa <malloc+0x42>
 8f8:	6a05                	lui	s4,0x1
 8fa:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8fe:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 902:	00000497          	auipc	s1,0x0
 906:	6fe48493          	addi	s1,s1,1790 # 1000 <freep>
  if (p == SBRK_ERROR)
 90a:	5afd                	li	s5,-1
 90c:	a83d                	j	94a <malloc+0x92>
 90e:	f426                	sd	s1,40(sp)
 910:	e852                	sd	s4,16(sp)
 912:	e456                	sd	s5,8(sp)
 914:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 916:	00000797          	auipc	a5,0x0
 91a:	6fa78793          	addi	a5,a5,1786 # 1010 <base>
 91e:	00000717          	auipc	a4,0x0
 922:	6ef73123          	sd	a5,1762(a4) # 1000 <freep>
 926:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 928:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 92c:	b7d1                	j	8f0 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 92e:	6398                	ld	a4,0(a5)
 930:	e118                	sd	a4,0(a0)
 932:	a899                	j	988 <malloc+0xd0>
  hp->s.size = nu;
 934:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 938:	0541                	addi	a0,a0,16
 93a:	ef5ff0ef          	jal	82e <free>
  return freep;
 93e:	6088                	ld	a0,0(s1)
      if ((p = morecore(nunits)) == 0)
 940:	c125                	beqz	a0,9a0 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 942:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 944:	4798                	lw	a4,8(a5)
 946:	03277163          	bgeu	a4,s2,968 <malloc+0xb0>
    if (p == freep)
 94a:	6098                	ld	a4,0(s1)
 94c:	853e                	mv	a0,a5
 94e:	fef71ae3          	bne	a4,a5,942 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 952:	8552                	mv	a0,s4
 954:	9ffff0ef          	jal	352 <sbrk>
  if (p == SBRK_ERROR)
 958:	fd551ee3          	bne	a0,s5,934 <malloc+0x7c>
        return 0;
 95c:	4501                	li	a0,0
 95e:	74a2                	ld	s1,40(sp)
 960:	6a42                	ld	s4,16(sp)
 962:	6aa2                	ld	s5,8(sp)
 964:	6b02                	ld	s6,0(sp)
 966:	a03d                	j	994 <malloc+0xdc>
 968:	74a2                	ld	s1,40(sp)
 96a:	6a42                	ld	s4,16(sp)
 96c:	6aa2                	ld	s5,8(sp)
 96e:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
 970:	fae90fe3          	beq	s2,a4,92e <malloc+0x76>
        p->s.size -= nunits;
 974:	4137073b          	subw	a4,a4,s3
 978:	c798                	sw	a4,8(a5)
        p += p->s.size;
 97a:	02071693          	slli	a3,a4,0x20
 97e:	01c6d713          	srli	a4,a3,0x1c
 982:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 984:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 988:	00000717          	auipc	a4,0x0
 98c:	66a73c23          	sd	a0,1656(a4) # 1000 <freep>
      return (void *)(p + 1);
 990:	01078513          	addi	a0,a5,16
  }
}
 994:	70e2                	ld	ra,56(sp)
 996:	7442                	ld	s0,48(sp)
 998:	7902                	ld	s2,32(sp)
 99a:	69e2                	ld	s3,24(sp)
 99c:	6121                	addi	sp,sp,64
 99e:	8082                	ret
 9a0:	74a2                	ld	s1,40(sp)
 9a2:	6a42                	ld	s4,16(sp)
 9a4:	6aa2                	ld	s5,8(sp)
 9a6:	6b02                	ld	s6,0(sp)
 9a8:	b7f5                	j	994 <malloc+0xdc>
