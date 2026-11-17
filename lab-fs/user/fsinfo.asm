
user/_fsinfo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7135                	addi	sp,sp,-160
   2:	ed06                	sd	ra,152(sp)
   4:	e922                	sd	s0,144(sp)
   6:	1100                	addi	s0,sp,160
  struct istat_info info;

  if (argc != 2) {
   8:	4789                	li	a5,2
   a:	02f50063          	beq	a0,a5,2a <main+0x2a>
   e:	e526                	sd	s1,136(sp)
  10:	e14a                	sd	s2,128(sp)
  12:	fcce                	sd	s3,120(sp)
  14:	f8d2                	sd	s4,112(sp)
    fprintf(2, "usage: fsinfo path\n");
  16:	00001597          	auipc	a1,0x1
  1a:	9da58593          	addi	a1,a1,-1574 # 9f0 <malloc+0x100>
  1e:	853e                	mv	a0,a5
  20:	7ea000ef          	jal	80a <fprintf>
    exit(1);
  24:	4505                	li	a0,1
  26:	398000ef          	jal	3be <exit>
  2a:	e526                	sd	s1,136(sp)
  2c:	84ae                	mv	s1,a1
  }

  if (istat(argv[1], &info) < 0) {
  2e:	f6840593          	addi	a1,s0,-152
  32:	6488                	ld	a0,8(s1)
  34:	432000ef          	jal	466 <istat>
  38:	0a054a63          	bltz	a0,ec <main+0xec>
  3c:	e14a                	sd	s2,128(sp)
  3e:	fcce                	sd	s3,120(sp)
  40:	f8d2                	sd	s4,112(sp)
    fprintf(2, "fsinfo: cannot inspect %s\n", argv[1]);
    exit(1);
  }

  printf("superblock: size %d nblocks %d ninodes %d nlog %d\n", info.sb.size,
  42:	f7842703          	lw	a4,-136(s0)
  46:	f7442683          	lw	a3,-140(s0)
  4a:	f7042603          	lw	a2,-144(s0)
  4e:	f6c42583          	lw	a1,-148(s0)
  52:	00001517          	auipc	a0,0x1
  56:	9d650513          	addi	a0,a0,-1578 # a28 <malloc+0x138>
  5a:	7da000ef          	jal	834 <printf>
         info.sb.nblocks, info.sb.ninodes, info.sb.nlog);
  printf("            logstart %d inodestart %d bmapstart %d refstart %d\n",
  5e:	f8842703          	lw	a4,-120(s0)
  62:	f8442683          	lw	a3,-124(s0)
  66:	f8042603          	lw	a2,-128(s0)
  6a:	f7c42583          	lw	a1,-132(s0)
  6e:	00001517          	auipc	a0,0x1
  72:	9f250513          	addi	a0,a0,-1550 # a60 <malloc+0x170>
  76:	7be000ef          	jal	834 <printf>
         info.sb.logstart, info.sb.inodestart, info.sb.bmapstart,
         info.sb.refstart);
  printf("\n");
  7a:	00001517          	auipc	a0,0x1
  7e:	a5e50513          	addi	a0,a0,-1442 # ad8 <malloc+0x1e8>
  82:	7b2000ef          	jal	834 <printf>

  printf("inode %d: type %d nlink %d size %d\n", info.inum, info.type,
  86:	f9442703          	lw	a4,-108(s0)
  8a:	f9241683          	lh	a3,-110(s0)
  8e:	f9041603          	lh	a2,-112(s0)
  92:	f8c42583          	lw	a1,-116(s0)
  96:	00001517          	auipc	a0,0x1
  9a:	a0a50513          	addi	a0,a0,-1526 # aa0 <malloc+0x1b0>
  9e:	796000ef          	jal	834 <printf>
         info.nlink, info.size);

  for (int i = 0; i < NDIRECT; i++)
  a2:	f9840913          	addi	s2,s0,-104
  a6:	4481                	li	s1,0
    printf("  addrs[%d] = %d\n", i, info.addrs[i]);
  a8:	00001a17          	auipc	s4,0x1
  ac:	a20a0a13          	addi	s4,s4,-1504 # ac8 <malloc+0x1d8>
  for (int i = 0; i < NDIRECT; i++)
  b0:	49ad                	li	s3,11
    printf("  addrs[%d] = %d\n", i, info.addrs[i]);
  b2:	00092603          	lw	a2,0(s2)
  b6:	85a6                	mv	a1,s1
  b8:	8552                	mv	a0,s4
  ba:	77a000ef          	jal	834 <printf>
  for (int i = 0; i < NDIRECT; i++)
  be:	2485                	addiw	s1,s1,1
  c0:	0911                	addi	s2,s2,4
  c2:	ff3498e3          	bne	s1,s3,b2 <main+0xb2>
  printf("  indirect = %d\n", info.addrs[NDIRECT]);
  c6:	fc442583          	lw	a1,-60(s0)
  ca:	00001517          	auipc	a0,0x1
  ce:	a1650513          	addi	a0,a0,-1514 # ae0 <malloc+0x1f0>
  d2:	762000ef          	jal	834 <printf>
  if (NDIRECT == 11)
    printf("  double-indirect = %d\n", info.addrs[NDIRECT + 1]);
  d6:	fc842583          	lw	a1,-56(s0)
  da:	00001517          	auipc	a0,0x1
  de:	a1e50513          	addi	a0,a0,-1506 # af8 <malloc+0x208>
  e2:	752000ef          	jal	834 <printf>

  exit(0);
  e6:	4501                	li	a0,0
  e8:	2d6000ef          	jal	3be <exit>
  ec:	e14a                	sd	s2,128(sp)
  ee:	fcce                	sd	s3,120(sp)
  f0:	f8d2                	sd	s4,112(sp)
    fprintf(2, "fsinfo: cannot inspect %s\n", argv[1]);
  f2:	6490                	ld	a2,8(s1)
  f4:	00001597          	auipc	a1,0x1
  f8:	91458593          	addi	a1,a1,-1772 # a08 <malloc+0x118>
  fc:	4509                	li	a0,2
  fe:	70c000ef          	jal	80a <fprintf>
    exit(1);
 102:	4505                	li	a0,1
 104:	2ba000ef          	jal	3be <exit>

0000000000000108 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 108:	1141                	addi	sp,sp,-16
 10a:	e406                	sd	ra,8(sp)
 10c:	e022                	sd	s0,0(sp)
 10e:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 110:	ef1ff0ef          	jal	0 <main>
  exit(r);
 114:	2aa000ef          	jal	3be <exit>

0000000000000118 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 118:	1141                	addi	sp,sp,-16
 11a:	e406                	sd	ra,8(sp)
 11c:	e022                	sd	s0,0(sp)
 11e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 120:	87aa                	mv	a5,a0
 122:	0585                	addi	a1,a1,1
 124:	0785                	addi	a5,a5,1
 126:	fff5c703          	lbu	a4,-1(a1)
 12a:	fee78fa3          	sb	a4,-1(a5)
 12e:	fb75                	bnez	a4,122 <strcpy+0xa>
    ;
  return os;
}
 130:	60a2                	ld	ra,8(sp)
 132:	6402                	ld	s0,0(sp)
 134:	0141                	addi	sp,sp,16
 136:	8082                	ret

0000000000000138 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 138:	1141                	addi	sp,sp,-16
 13a:	e406                	sd	ra,8(sp)
 13c:	e022                	sd	s0,0(sp)
 13e:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 140:	00054783          	lbu	a5,0(a0)
 144:	cb91                	beqz	a5,158 <strcmp+0x20>
 146:	0005c703          	lbu	a4,0(a1)
 14a:	00f71763          	bne	a4,a5,158 <strcmp+0x20>
    p++, q++;
 14e:	0505                	addi	a0,a0,1
 150:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 152:	00054783          	lbu	a5,0(a0)
 156:	fbe5                	bnez	a5,146 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 158:	0005c503          	lbu	a0,0(a1)
}
 15c:	40a7853b          	subw	a0,a5,a0
 160:	60a2                	ld	ra,8(sp)
 162:	6402                	ld	s0,0(sp)
 164:	0141                	addi	sp,sp,16
 166:	8082                	ret

0000000000000168 <strlen>:

uint
strlen(const char *s)
{
 168:	1141                	addi	sp,sp,-16
 16a:	e406                	sd	ra,8(sp)
 16c:	e022                	sd	s0,0(sp)
 16e:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 170:	00054783          	lbu	a5,0(a0)
 174:	cf91                	beqz	a5,190 <strlen+0x28>
 176:	00150793          	addi	a5,a0,1
 17a:	86be                	mv	a3,a5
 17c:	0785                	addi	a5,a5,1
 17e:	fff7c703          	lbu	a4,-1(a5)
 182:	ff65                	bnez	a4,17a <strlen+0x12>
 184:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 188:	60a2                	ld	ra,8(sp)
 18a:	6402                	ld	s0,0(sp)
 18c:	0141                	addi	sp,sp,16
 18e:	8082                	ret
  for (n = 0; s[n]; n++)
 190:	4501                	li	a0,0
 192:	bfdd                	j	188 <strlen+0x20>

0000000000000194 <memset>:

void *
memset(void *dst, int c, uint n)
{
 194:	1141                	addi	sp,sp,-16
 196:	e406                	sd	ra,8(sp)
 198:	e022                	sd	s0,0(sp)
 19a:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 19c:	ca19                	beqz	a2,1b2 <memset+0x1e>
 19e:	87aa                	mv	a5,a0
 1a0:	1602                	slli	a2,a2,0x20
 1a2:	9201                	srli	a2,a2,0x20
 1a4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1a8:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 1ac:	0785                	addi	a5,a5,1
 1ae:	fee79de3          	bne	a5,a4,1a8 <memset+0x14>
  }
  return dst;
}
 1b2:	60a2                	ld	ra,8(sp)
 1b4:	6402                	ld	s0,0(sp)
 1b6:	0141                	addi	sp,sp,16
 1b8:	8082                	ret

00000000000001ba <strchr>:

char *
strchr(const char *s, char c)
{
 1ba:	1141                	addi	sp,sp,-16
 1bc:	e406                	sd	ra,8(sp)
 1be:	e022                	sd	s0,0(sp)
 1c0:	0800                	addi	s0,sp,16
  for (; *s; s++)
 1c2:	00054783          	lbu	a5,0(a0)
 1c6:	c799                	beqz	a5,1d4 <strchr+0x1a>
    if (*s == c)
 1c8:	00f58763          	beq	a1,a5,1d6 <strchr+0x1c>
  for (; *s; s++)
 1cc:	0505                	addi	a0,a0,1
 1ce:	00054783          	lbu	a5,0(a0)
 1d2:	fbfd                	bnez	a5,1c8 <strchr+0xe>
      return (char *)s;
  return 0;
 1d4:	4501                	li	a0,0
}
 1d6:	60a2                	ld	ra,8(sp)
 1d8:	6402                	ld	s0,0(sp)
 1da:	0141                	addi	sp,sp,16
 1dc:	8082                	ret

00000000000001de <gets>:

char *
gets(char *buf, int max)
{
 1de:	711d                	addi	sp,sp,-96
 1e0:	ec86                	sd	ra,88(sp)
 1e2:	e8a2                	sd	s0,80(sp)
 1e4:	e4a6                	sd	s1,72(sp)
 1e6:	e0ca                	sd	s2,64(sp)
 1e8:	fc4e                	sd	s3,56(sp)
 1ea:	f852                	sd	s4,48(sp)
 1ec:	f456                	sd	s5,40(sp)
 1ee:	f05a                	sd	s6,32(sp)
 1f0:	ec5e                	sd	s7,24(sp)
 1f2:	e862                	sd	s8,16(sp)
 1f4:	1080                	addi	s0,sp,96
 1f6:	8baa                	mv	s7,a0
 1f8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 1fa:	892a                	mv	s2,a0
 1fc:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1fe:	faf40b13          	addi	s6,s0,-81
 202:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;) {
 204:	8c26                	mv	s8,s1
 206:	0014899b          	addiw	s3,s1,1
 20a:	84ce                	mv	s1,s3
 20c:	0349d863          	bge	s3,s4,23c <gets+0x5e>
    cc = read(0, &c, 1);
 210:	8656                	mv	a2,s5
 212:	85da                	mv	a1,s6
 214:	4501                	li	a0,0
 216:	1c0000ef          	jal	3d6 <read>
    if (cc < 1)
 21a:	02a05163          	blez	a0,23c <gets+0x5e>
      break;
    buf[i++] = c;
 21e:	faf44783          	lbu	a5,-81(s0)
 222:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 226:	0905                	addi	s2,s2,1
 228:	ff678713          	addi	a4,a5,-10
 22c:	00173713          	seqz	a4,a4
 230:	17cd                	addi	a5,a5,-13
 232:	0017b793          	seqz	a5,a5
 236:	8fd9                	or	a5,a5,a4
 238:	d7f1                	beqz	a5,204 <gets+0x26>
    buf[i++] = c;
 23a:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 23c:	9c5e                	add	s8,s8,s7
 23e:	000c0023          	sb	zero,0(s8)
  return buf;
}
 242:	855e                	mv	a0,s7
 244:	60e6                	ld	ra,88(sp)
 246:	6446                	ld	s0,80(sp)
 248:	64a6                	ld	s1,72(sp)
 24a:	6906                	ld	s2,64(sp)
 24c:	79e2                	ld	s3,56(sp)
 24e:	7a42                	ld	s4,48(sp)
 250:	7aa2                	ld	s5,40(sp)
 252:	7b02                	ld	s6,32(sp)
 254:	6be2                	ld	s7,24(sp)
 256:	6c42                	ld	s8,16(sp)
 258:	6125                	addi	sp,sp,96
 25a:	8082                	ret

000000000000025c <stat>:

int
stat(const char *n, struct stat *st)
{
 25c:	1101                	addi	sp,sp,-32
 25e:	ec06                	sd	ra,24(sp)
 260:	e822                	sd	s0,16(sp)
 262:	e04a                	sd	s2,0(sp)
 264:	1000                	addi	s0,sp,32
 266:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 268:	4581                	li	a1,0
 26a:	194000ef          	jal	3fe <open>
  if (fd < 0)
 26e:	02054263          	bltz	a0,292 <stat+0x36>
 272:	e426                	sd	s1,8(sp)
 274:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 276:	85ca                	mv	a1,s2
 278:	19e000ef          	jal	416 <fstat>
 27c:	892a                	mv	s2,a0
  close(fd);
 27e:	8526                	mv	a0,s1
 280:	166000ef          	jal	3e6 <close>
  return r;
 284:	64a2                	ld	s1,8(sp)
}
 286:	854a                	mv	a0,s2
 288:	60e2                	ld	ra,24(sp)
 28a:	6442                	ld	s0,16(sp)
 28c:	6902                	ld	s2,0(sp)
 28e:	6105                	addi	sp,sp,32
 290:	8082                	ret
    return -1;
 292:	57fd                	li	a5,-1
 294:	893e                	mv	s2,a5
 296:	bfc5                	j	286 <stat+0x2a>

0000000000000298 <atoi>:

int
atoi(const char *s)
{
 298:	1141                	addi	sp,sp,-16
 29a:	e406                	sd	ra,8(sp)
 29c:	e022                	sd	s0,0(sp)
 29e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 2a0:	00054683          	lbu	a3,0(a0)
 2a4:	fd06879b          	addiw	a5,a3,-48
 2a8:	0ff7f793          	zext.b	a5,a5
 2ac:	4625                	li	a2,9
 2ae:	02f66963          	bltu	a2,a5,2e0 <atoi+0x48>
 2b2:	872a                	mv	a4,a0
  n = 0;
 2b4:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 2b6:	0705                	addi	a4,a4,1
 2b8:	0025179b          	slliw	a5,a0,0x2
 2bc:	9fa9                	addw	a5,a5,a0
 2be:	0017979b          	slliw	a5,a5,0x1
 2c2:	9fb5                	addw	a5,a5,a3
 2c4:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 2c8:	00074683          	lbu	a3,0(a4)
 2cc:	fd06879b          	addiw	a5,a3,-48
 2d0:	0ff7f793          	zext.b	a5,a5
 2d4:	fef671e3          	bgeu	a2,a5,2b6 <atoi+0x1e>
  return n;
}
 2d8:	60a2                	ld	ra,8(sp)
 2da:	6402                	ld	s0,0(sp)
 2dc:	0141                	addi	sp,sp,16
 2de:	8082                	ret
  n = 0;
 2e0:	4501                	li	a0,0
 2e2:	bfdd                	j	2d8 <atoi+0x40>

00000000000002e4 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 2e4:	1141                	addi	sp,sp,-16
 2e6:	e406                	sd	ra,8(sp)
 2e8:	e022                	sd	s0,0(sp)
 2ea:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2ec:	02b57563          	bgeu	a0,a1,316 <memmove+0x32>
    while (n-- > 0)
 2f0:	00c05f63          	blez	a2,30e <memmove+0x2a>
 2f4:	1602                	slli	a2,a2,0x20
 2f6:	9201                	srli	a2,a2,0x20
 2f8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2fc:	872a                	mv	a4,a0
      *dst++ = *src++;
 2fe:	0585                	addi	a1,a1,1
 300:	0705                	addi	a4,a4,1
 302:	fff5c683          	lbu	a3,-1(a1)
 306:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 30a:	fee79ae3          	bne	a5,a4,2fe <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 30e:	60a2                	ld	ra,8(sp)
 310:	6402                	ld	s0,0(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret
    while (n-- > 0)
 316:	fec05ce3          	blez	a2,30e <memmove+0x2a>
    dst += n;
 31a:	00c50733          	add	a4,a0,a2
    src += n;
 31e:	95b2                	add	a1,a1,a2
 320:	fff6079b          	addiw	a5,a2,-1
 324:	1782                	slli	a5,a5,0x20
 326:	9381                	srli	a5,a5,0x20
 328:	fff7c793          	not	a5,a5
 32c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 32e:	15fd                	addi	a1,a1,-1
 330:	177d                	addi	a4,a4,-1
 332:	0005c683          	lbu	a3,0(a1)
 336:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 33a:	fef71ae3          	bne	a4,a5,32e <memmove+0x4a>
 33e:	bfc1                	j	30e <memmove+0x2a>

0000000000000340 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 340:	1141                	addi	sp,sp,-16
 342:	e406                	sd	ra,8(sp)
 344:	e022                	sd	s0,0(sp)
 346:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 348:	ce19                	beqz	a2,366 <memcmp+0x26>
 34a:	1602                	slli	a2,a2,0x20
 34c:	9201                	srli	a2,a2,0x20
 34e:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 352:	00054783          	lbu	a5,0(a0)
 356:	0005c703          	lbu	a4,0(a1)
 35a:	00e79b63          	bne	a5,a4,370 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 35e:	0505                	addi	a0,a0,1
    p2++;
 360:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 362:	fed518e3          	bne	a0,a3,352 <memcmp+0x12>
  }
  return 0;
 366:	4501                	li	a0,0
}
 368:	60a2                	ld	ra,8(sp)
 36a:	6402                	ld	s0,0(sp)
 36c:	0141                	addi	sp,sp,16
 36e:	8082                	ret
      return *p1 - *p2;
 370:	40e7853b          	subw	a0,a5,a4
 374:	bfd5                	j	368 <memcmp+0x28>

0000000000000376 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 376:	1141                	addi	sp,sp,-16
 378:	e406                	sd	ra,8(sp)
 37a:	e022                	sd	s0,0(sp)
 37c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 37e:	f67ff0ef          	jal	2e4 <memmove>
}
 382:	60a2                	ld	ra,8(sp)
 384:	6402                	ld	s0,0(sp)
 386:	0141                	addi	sp,sp,16
 388:	8082                	ret

000000000000038a <sbrk>:

char *
sbrk(int n)
{
 38a:	1141                	addi	sp,sp,-16
 38c:	e406                	sd	ra,8(sp)
 38e:	e022                	sd	s0,0(sp)
 390:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 392:	4585                	li	a1,1
 394:	0b2000ef          	jal	446 <sys_sbrk>
}
 398:	60a2                	ld	ra,8(sp)
 39a:	6402                	ld	s0,0(sp)
 39c:	0141                	addi	sp,sp,16
 39e:	8082                	ret

00000000000003a0 <sbrklazy>:

char *
sbrklazy(int n)
{
 3a0:	1141                	addi	sp,sp,-16
 3a2:	e406                	sd	ra,8(sp)
 3a4:	e022                	sd	s0,0(sp)
 3a6:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 3a8:	4589                	li	a1,2
 3aa:	09c000ef          	jal	446 <sys_sbrk>
}
 3ae:	60a2                	ld	ra,8(sp)
 3b0:	6402                	ld	s0,0(sp)
 3b2:	0141                	addi	sp,sp,16
 3b4:	8082                	ret

00000000000003b6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3b6:	4885                	li	a7,1
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <exit>:
.global exit
exit:
 li a7, SYS_exit
 3be:	4889                	li	a7,2
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3c6:	488d                	li	a7,3
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3ce:	4891                	li	a7,4
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <read>:
.global read
read:
 li a7, SYS_read
 3d6:	4895                	li	a7,5
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <write>:
.global write
write:
 li a7, SYS_write
 3de:	48c1                	li	a7,16
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <close>:
.global close
close:
 li a7, SYS_close
 3e6:	48d5                	li	a7,21
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <kill>:
.global kill
kill:
 li a7, SYS_kill
 3ee:	4899                	li	a7,6
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3f6:	489d                	li	a7,7
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <open>:
.global open
open:
 li a7, SYS_open
 3fe:	48bd                	li	a7,15
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 406:	48c5                	li	a7,17
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 40e:	48c9                	li	a7,18
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 416:	48a1                	li	a7,8
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <link>:
.global link
link:
 li a7, SYS_link
 41e:	48cd                	li	a7,19
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 426:	48d1                	li	a7,20
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 42e:	48a5                	li	a7,9
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <dup>:
.global dup
dup:
 li a7, SYS_dup
 436:	48a9                	li	a7,10
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 43e:	48ad                	li	a7,11
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 446:	48b1                	li	a7,12
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <pause>:
.global pause
pause:
 li a7, SYS_pause
 44e:	48b5                	li	a7,13
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 456:	48b9                	li	a7,14
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <sync>:
.global sync
sync:
 li a7, SYS_sync
 45e:	48d9                	li	a7,22
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <istat>:
.global istat
istat:
 li a7, SYS_istat
 466:	48dd                	li	a7,23
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <iprint>:
.global iprint
iprint:
 li a7, SYS_iprint
 46e:	48e1                	li	a7,24
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <symlink>:
.global symlink
symlink:
 li a7, SYS_symlink
 476:	48e5                	li	a7,25
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 47e:	1101                	addi	sp,sp,-32
 480:	ec06                	sd	ra,24(sp)
 482:	e822                	sd	s0,16(sp)
 484:	1000                	addi	s0,sp,32
 486:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 48a:	4605                	li	a2,1
 48c:	fef40593          	addi	a1,s0,-17
 490:	f4fff0ef          	jal	3de <write>
}
 494:	60e2                	ld	ra,24(sp)
 496:	6442                	ld	s0,16(sp)
 498:	6105                	addi	sp,sp,32
 49a:	8082                	ret

000000000000049c <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 49c:	715d                	addi	sp,sp,-80
 49e:	e486                	sd	ra,72(sp)
 4a0:	e0a2                	sd	s0,64(sp)
 4a2:	f84a                	sd	s2,48(sp)
 4a4:	f44e                	sd	s3,40(sp)
 4a6:	0880                	addi	s0,sp,80
 4a8:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 4aa:	00d036b3          	snez	a3,a3
 4ae:	03f5d793          	srli	a5,a1,0x3f
 4b2:	8efd                	and	a3,a3,a5
  neg = 0;
 4b4:	4301                	li	t1,0
  if (sgn && xx < 0) {
 4b6:	c681                	beqz	a3,4be <printint+0x22>
    neg = 1;
    x = -xx;
 4b8:	40b005b3          	neg	a1,a1
    neg = 1;
 4bc:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 4be:	fb840993          	addi	s3,s0,-72
  neg = 0;
 4c2:	86ce                	mv	a3,s3
  i = 0;
 4c4:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
 4c6:	00000817          	auipc	a6,0x0
 4ca:	65280813          	addi	a6,a6,1618 # b18 <digits>
 4ce:	88ba                	mv	a7,a4
 4d0:	0017051b          	addiw	a0,a4,1
 4d4:	872a                	mv	a4,a0
 4d6:	02c5f7b3          	remu	a5,a1,a2
 4da:	97c2                	add	a5,a5,a6
 4dc:	0007c783          	lbu	a5,0(a5)
 4e0:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
 4e4:	87ae                	mv	a5,a1
 4e6:	02c5d5b3          	divu	a1,a1,a2
 4ea:	0685                	addi	a3,a3,1
 4ec:	fec7f1e3          	bgeu	a5,a2,4ce <printint+0x32>
  if (neg)
 4f0:	00030b63          	beqz	t1,506 <printint+0x6a>
    buf[i++] = '-';
 4f4:	fd040793          	addi	a5,s0,-48
 4f8:	953e                	add	a0,a0,a5
 4fa:	02d00793          	li	a5,45
 4fe:	fef50423          	sb	a5,-24(a0)
 502:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
 506:	02e05563          	blez	a4,530 <printint+0x94>
 50a:	fc26                	sd	s1,56(sp)
 50c:	377d                	addiw	a4,a4,-1
 50e:	00e984b3          	add	s1,s3,a4
 512:	19fd                	addi	s3,s3,-1
 514:	99ba                	add	s3,s3,a4
 516:	1702                	slli	a4,a4,0x20
 518:	9301                	srli	a4,a4,0x20
 51a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 51e:	0004c583          	lbu	a1,0(s1)
 522:	854a                	mv	a0,s2
 524:	f5bff0ef          	jal	47e <putc>
  while (--i >= 0)
 528:	14fd                	addi	s1,s1,-1
 52a:	ff349ae3          	bne	s1,s3,51e <printint+0x82>
 52e:	74e2                	ld	s1,56(sp)
}
 530:	60a6                	ld	ra,72(sp)
 532:	6406                	ld	s0,64(sp)
 534:	7942                	ld	s2,48(sp)
 536:	79a2                	ld	s3,40(sp)
 538:	6161                	addi	sp,sp,80
 53a:	8082                	ret

000000000000053c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 53c:	711d                	addi	sp,sp,-96
 53e:	ec86                	sd	ra,88(sp)
 540:	e8a2                	sd	s0,80(sp)
 542:	e4a6                	sd	s1,72(sp)
 544:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 546:	0005c483          	lbu	s1,0(a1)
 54a:	2a048063          	beqz	s1,7ea <vprintf+0x2ae>
 54e:	e0ca                	sd	s2,64(sp)
 550:	fc4e                	sd	s3,56(sp)
 552:	f852                	sd	s4,48(sp)
 554:	f456                	sd	s5,40(sp)
 556:	f05a                	sd	s6,32(sp)
 558:	ec5e                	sd	s7,24(sp)
 55a:	e862                	sd	s8,16(sp)
 55c:	8b2a                	mv	s6,a0
 55e:	8a2e                	mv	s4,a1
 560:	8bb2                	mv	s7,a2
  state = 0;
 562:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 564:	4901                	li	s2,0
 566:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 568:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 56c:	06400c13          	li	s8,100
 570:	a00d                	j	592 <vprintf+0x56>
        putc(fd, c0);
 572:	85a6                	mv	a1,s1
 574:	855a                	mv	a0,s6
 576:	f09ff0ef          	jal	47e <putc>
 57a:	a019                	j	580 <vprintf+0x44>
    } else if (state == '%') {
 57c:	03598363          	beq	s3,s5,5a2 <vprintf+0x66>
  for (i = 0; fmt[i]; i++) {
 580:	0019079b          	addiw	a5,s2,1
 584:	893e                	mv	s2,a5
 586:	873e                	mv	a4,a5
 588:	97d2                	add	a5,a5,s4
 58a:	0007c483          	lbu	s1,0(a5)
 58e:	24048763          	beqz	s1,7dc <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 592:	0004879b          	sext.w	a5,s1
    if (state == 0) {
 596:	fe0993e3          	bnez	s3,57c <vprintf+0x40>
      if (c0 == '%') {
 59a:	fd579ce3          	bne	a5,s5,572 <vprintf+0x36>
        state = '%';
 59e:	89be                	mv	s3,a5
 5a0:	b7c5                	j	580 <vprintf+0x44>
        c1 = fmt[i + 1] & 0xff;
 5a2:	00ea06b3          	add	a3,s4,a4
 5a6:	0016c603          	lbu	a2,1(a3)
      if (c1)
 5aa:	24060563          	beqz	a2,7f4 <vprintf+0x2b8>
      if (c0 == 'd') {
 5ae:	0b878763          	beq	a5,s8,65c <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 5b2:	f9478693          	addi	a3,a5,-108
 5b6:	0016b693          	seqz	a3,a3
 5ba:	f9c60593          	addi	a1,a2,-100
 5be:	0015b593          	seqz	a1,a1
 5c2:	8df5                	and	a1,a1,a3
 5c4:	e9c5                	bnez	a1,674 <vprintf+0x138>
        c2 = fmt[i + 2] & 0xff;
 5c6:	9752                	add	a4,a4,s4
 5c8:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 5cc:	f9460713          	addi	a4,a2,-108
 5d0:	00173713          	seqz	a4,a4
 5d4:	8f75                	and	a4,a4,a3
 5d6:	f9c50593          	addi	a1,a0,-100
 5da:	0015b593          	seqz	a1,a1
 5de:	8df9                	and	a1,a1,a4
 5e0:	e5dd                	bnez	a1,68e <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 5e2:	07500593          	li	a1,117
 5e6:	0cb78163          	beq	a5,a1,6a8 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if (c0 == 'l' && c1 == 'u') {
 5ea:	f8b60593          	addi	a1,a2,-117
 5ee:	0015b593          	seqz	a1,a1
 5f2:	8df5                	and	a1,a1,a3
 5f4:	e5f1                	bnez	a1,6c0 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 5f6:	f8b50593          	addi	a1,a0,-117
 5fa:	0015b593          	seqz	a1,a1
 5fe:	8df9                	and	a1,a1,a4
 600:	ede9                	bnez	a1,6da <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 602:	07800593          	li	a1,120
 606:	0eb78763          	beq	a5,a1,6f4 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if (c0 == 'l' && c1 == 'x') {
 60a:	f8860613          	addi	a2,a2,-120
 60e:	00163613          	seqz	a2,a2
 612:	8ef1                	and	a3,a3,a2
 614:	0e069c63          	bnez	a3,70c <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 618:	f8850513          	addi	a0,a0,-120
 61c:	00153513          	seqz	a0,a0
 620:	8f69                	and	a4,a4,a0
 622:	10071263          	bnez	a4,726 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 626:	07000713          	li	a4,112
 62a:	10e78a63          	beq	a5,a4,73e <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 62e:	06300713          	li	a4,99
 632:	14e78a63          	beq	a5,a4,786 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 636:	07300713          	li	a4,115
 63a:	16e78063          	beq	a5,a4,79a <vprintf+0x25e>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 63e:	02500713          	li	a4,37
 642:	18e78863          	beq	a5,a4,7d2 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 646:	02500593          	li	a1,37
 64a:	855a                	mv	a0,s6
 64c:	e33ff0ef          	jal	47e <putc>
        putc(fd, c0);
 650:	85a6                	mv	a1,s1
 652:	855a                	mv	a0,s6
 654:	e2bff0ef          	jal	47e <putc>
      }

      state = 0;
 658:	4981                	li	s3,0
 65a:	b71d                	j	580 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 65c:	008b8493          	addi	s1,s7,8
 660:	4685                	li	a3,1
 662:	4629                	li	a2,10
 664:	000ba583          	lw	a1,0(s7)
 668:	855a                	mv	a0,s6
 66a:	e33ff0ef          	jal	49c <printint>
 66e:	8ba6                	mv	s7,s1
      state = 0;
 670:	4981                	li	s3,0
 672:	b739                	j	580 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 674:	008b8493          	addi	s1,s7,8
 678:	4685                	li	a3,1
 67a:	4629                	li	a2,10
 67c:	000bb583          	ld	a1,0(s7)
 680:	855a                	mv	a0,s6
 682:	e1bff0ef          	jal	49c <printint>
        i += 1;
 686:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 688:	8ba6                	mv	s7,s1
      state = 0;
 68a:	4981                	li	s3,0
 68c:	bdd5                	j	580 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 68e:	008b8493          	addi	s1,s7,8
 692:	4685                	li	a3,1
 694:	4629                	li	a2,10
 696:	000bb583          	ld	a1,0(s7)
 69a:	855a                	mv	a0,s6
 69c:	e01ff0ef          	jal	49c <printint>
        i += 2;
 6a0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6a2:	8ba6                	mv	s7,s1
      state = 0;
 6a4:	4981                	li	s3,0
        i += 2;
 6a6:	bde9                	j	580 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6a8:	008b8493          	addi	s1,s7,8
 6ac:	4681                	li	a3,0
 6ae:	4629                	li	a2,10
 6b0:	000be583          	lwu	a1,0(s7)
 6b4:	855a                	mv	a0,s6
 6b6:	de7ff0ef          	jal	49c <printint>
 6ba:	8ba6                	mv	s7,s1
      state = 0;
 6bc:	4981                	li	s3,0
 6be:	b5c9                	j	580 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6c0:	008b8493          	addi	s1,s7,8
 6c4:	4681                	li	a3,0
 6c6:	4629                	li	a2,10
 6c8:	000bb583          	ld	a1,0(s7)
 6cc:	855a                	mv	a0,s6
 6ce:	dcfff0ef          	jal	49c <printint>
        i += 1;
 6d2:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d4:	8ba6                	mv	s7,s1
      state = 0;
 6d6:	4981                	li	s3,0
 6d8:	b565                	j	580 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6da:	008b8493          	addi	s1,s7,8
 6de:	4681                	li	a3,0
 6e0:	4629                	li	a2,10
 6e2:	000bb583          	ld	a1,0(s7)
 6e6:	855a                	mv	a0,s6
 6e8:	db5ff0ef          	jal	49c <printint>
        i += 2;
 6ec:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ee:	8ba6                	mv	s7,s1
      state = 0;
 6f0:	4981                	li	s3,0
        i += 2;
 6f2:	b579                	j	580 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6f4:	008b8493          	addi	s1,s7,8
 6f8:	4681                	li	a3,0
 6fa:	4641                	li	a2,16
 6fc:	000be583          	lwu	a1,0(s7)
 700:	855a                	mv	a0,s6
 702:	d9bff0ef          	jal	49c <printint>
 706:	8ba6                	mv	s7,s1
      state = 0;
 708:	4981                	li	s3,0
 70a:	bd9d                	j	580 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 70c:	008b8493          	addi	s1,s7,8
 710:	4681                	li	a3,0
 712:	4641                	li	a2,16
 714:	000bb583          	ld	a1,0(s7)
 718:	855a                	mv	a0,s6
 71a:	d83ff0ef          	jal	49c <printint>
        i += 1;
 71e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 720:	8ba6                	mv	s7,s1
      state = 0;
 722:	4981                	li	s3,0
 724:	bdb1                	j	580 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 726:	008b8493          	addi	s1,s7,8
 72a:	4641                	li	a2,16
 72c:	000bb583          	ld	a1,0(s7)
 730:	855a                	mv	a0,s6
 732:	d6bff0ef          	jal	49c <printint>
        i += 2;
 736:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 738:	8ba6                	mv	s7,s1
      state = 0;
 73a:	4981                	li	s3,0
        i += 2;
 73c:	b591                	j	580 <vprintf+0x44>
 73e:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 740:	008b8793          	addi	a5,s7,8
 744:	8cbe                	mv	s9,a5
 746:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 74a:	03000593          	li	a1,48
 74e:	855a                	mv	a0,s6
 750:	d2fff0ef          	jal	47e <putc>
  putc(fd, 'x');
 754:	07800593          	li	a1,120
 758:	855a                	mv	a0,s6
 75a:	d25ff0ef          	jal	47e <putc>
 75e:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 760:	00000b97          	auipc	s7,0x0
 764:	3b8b8b93          	addi	s7,s7,952 # b18 <digits>
 768:	03c9d793          	srli	a5,s3,0x3c
 76c:	97de                	add	a5,a5,s7
 76e:	0007c583          	lbu	a1,0(a5)
 772:	855a                	mv	a0,s6
 774:	d0bff0ef          	jal	47e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 778:	0992                	slli	s3,s3,0x4
 77a:	34fd                	addiw	s1,s1,-1
 77c:	f4f5                	bnez	s1,768 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 77e:	8be6                	mv	s7,s9
      state = 0;
 780:	4981                	li	s3,0
 782:	6ca2                	ld	s9,8(sp)
 784:	bbf5                	j	580 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 786:	008b8493          	addi	s1,s7,8
 78a:	000bc583          	lbu	a1,0(s7)
 78e:	855a                	mv	a0,s6
 790:	cefff0ef          	jal	47e <putc>
 794:	8ba6                	mv	s7,s1
      state = 0;
 796:	4981                	li	s3,0
 798:	b3e5                	j	580 <vprintf+0x44>
        if ((s = va_arg(ap, char *)) == 0)
 79a:	008b8993          	addi	s3,s7,8
 79e:	000bb483          	ld	s1,0(s7)
 7a2:	cc91                	beqz	s1,7be <vprintf+0x282>
        for (; *s; s++)
 7a4:	0004c583          	lbu	a1,0(s1)
 7a8:	c195                	beqz	a1,7cc <vprintf+0x290>
          putc(fd, *s);
 7aa:	855a                	mv	a0,s6
 7ac:	cd3ff0ef          	jal	47e <putc>
        for (; *s; s++)
 7b0:	0485                	addi	s1,s1,1
 7b2:	0004c583          	lbu	a1,0(s1)
 7b6:	f9f5                	bnez	a1,7aa <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 7b8:	8bce                	mv	s7,s3
      state = 0;
 7ba:	4981                	li	s3,0
 7bc:	b3d1                	j	580 <vprintf+0x44>
          s = "(null)";
 7be:	00000497          	auipc	s1,0x0
 7c2:	35248493          	addi	s1,s1,850 # b10 <malloc+0x220>
        for (; *s; s++)
 7c6:	02800593          	li	a1,40
 7ca:	b7c5                	j	7aa <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 7cc:	8bce                	mv	s7,s3
      state = 0;
 7ce:	4981                	li	s3,0
 7d0:	bb45                	j	580 <vprintf+0x44>
        putc(fd, '%');
 7d2:	85be                	mv	a1,a5
 7d4:	855a                	mv	a0,s6
 7d6:	ca9ff0ef          	jal	47e <putc>
 7da:	bdbd                	j	658 <vprintf+0x11c>
 7dc:	6906                	ld	s2,64(sp)
 7de:	79e2                	ld	s3,56(sp)
 7e0:	7a42                	ld	s4,48(sp)
 7e2:	7aa2                	ld	s5,40(sp)
 7e4:	7b02                	ld	s6,32(sp)
 7e6:	6be2                	ld	s7,24(sp)
 7e8:	6c42                	ld	s8,16(sp)
    }
  }
}
 7ea:	60e6                	ld	ra,88(sp)
 7ec:	6446                	ld	s0,80(sp)
 7ee:	64a6                	ld	s1,72(sp)
 7f0:	6125                	addi	sp,sp,96
 7f2:	8082                	ret
      if (c0 == 'd') {
 7f4:	06400713          	li	a4,100
 7f8:	e6e782e3          	beq	a5,a4,65c <vprintf+0x120>
      } else if (c0 == 'l' && c1 == 'd') {
 7fc:	f9478693          	addi	a3,a5,-108
 800:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 804:	8532                	mv	a0,a2
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 806:	4701                	li	a4,0
 808:	bbe9                	j	5e2 <vprintf+0xa6>

000000000000080a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 80a:	715d                	addi	sp,sp,-80
 80c:	ec06                	sd	ra,24(sp)
 80e:	e822                	sd	s0,16(sp)
 810:	1000                	addi	s0,sp,32
 812:	e010                	sd	a2,0(s0)
 814:	e414                	sd	a3,8(s0)
 816:	e818                	sd	a4,16(s0)
 818:	ec1c                	sd	a5,24(s0)
 81a:	03043023          	sd	a6,32(s0)
 81e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 822:	8622                	mv	a2,s0
 824:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 828:	d15ff0ef          	jal	53c <vprintf>
}
 82c:	60e2                	ld	ra,24(sp)
 82e:	6442                	ld	s0,16(sp)
 830:	6161                	addi	sp,sp,80
 832:	8082                	ret

0000000000000834 <printf>:

void
printf(const char *fmt, ...)
{
 834:	711d                	addi	sp,sp,-96
 836:	ec06                	sd	ra,24(sp)
 838:	e822                	sd	s0,16(sp)
 83a:	1000                	addi	s0,sp,32
 83c:	e40c                	sd	a1,8(s0)
 83e:	e810                	sd	a2,16(s0)
 840:	ec14                	sd	a3,24(s0)
 842:	f018                	sd	a4,32(s0)
 844:	f41c                	sd	a5,40(s0)
 846:	03043823          	sd	a6,48(s0)
 84a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 84e:	00840613          	addi	a2,s0,8
 852:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 856:	85aa                	mv	a1,a0
 858:	4505                	li	a0,1
 85a:	ce3ff0ef          	jal	53c <vprintf>
}
 85e:	60e2                	ld	ra,24(sp)
 860:	6442                	ld	s0,16(sp)
 862:	6125                	addi	sp,sp,96
 864:	8082                	ret

0000000000000866 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 866:	1141                	addi	sp,sp,-16
 868:	e406                	sd	ra,8(sp)
 86a:	e022                	sd	s0,0(sp)
 86c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 86e:	ff050713          	addi	a4,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 872:	00000797          	auipc	a5,0x0
 876:	78e7b783          	ld	a5,1934(a5) # 1000 <freep>
 87a:	a095                	j	8de <free+0x78>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
 87c:	ff852583          	lw	a1,-8(a0)
 880:	6390                	ld	a2,0(a5)
 882:	02059813          	slli	a6,a1,0x20
 886:	01c85693          	srli	a3,a6,0x1c
 88a:	96ba                	add	a3,a3,a4
 88c:	02d60563          	beq	a2,a3,8b6 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 890:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
 894:	4790                	lw	a2,8(a5)
 896:	02061593          	slli	a1,a2,0x20
 89a:	01c5d693          	srli	a3,a1,0x1c
 89e:	96be                	add	a3,a3,a5
 8a0:	02d70263          	beq	a4,a3,8c4 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 8a4:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8a6:	00000717          	auipc	a4,0x0
 8aa:	74f73d23          	sd	a5,1882(a4) # 1000 <freep>
}
 8ae:	60a2                	ld	ra,8(sp)
 8b0:	6402                	ld	s0,0(sp)
 8b2:	0141                	addi	sp,sp,16
 8b4:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 8b6:	4614                	lw	a3,8(a2)
 8b8:	9ead                	addw	a3,a3,a1
 8ba:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8be:	6394                	ld	a3,0(a5)
 8c0:	6290                	ld	a2,0(a3)
 8c2:	b7f9                	j	890 <free+0x2a>
    p->s.size += bp->s.size;
 8c4:	ff852703          	lw	a4,-8(a0)
 8c8:	9f31                	addw	a4,a4,a2
 8ca:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8cc:	ff053703          	ld	a4,-16(a0)
 8d0:	bfd1                	j	8a4 <free+0x3e>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d2:	6394                	ld	a3,0(a5)
 8d4:	00d7e463          	bltu	a5,a3,8dc <free+0x76>
 8d8:	fad762e3          	bltu	a4,a3,87c <free+0x16>
 8dc:	87b6                	mv	a5,a3
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8de:	fee7fae3          	bgeu	a5,a4,8d2 <free+0x6c>
 8e2:	6394                	ld	a3,0(a5)
 8e4:	f8d76ce3          	bltu	a4,a3,87c <free+0x16>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e8:	f8d7fae3          	bgeu	a5,a3,87c <free+0x16>
 8ec:	87b6                	mv	a5,a3
 8ee:	bfc5                	j	8de <free+0x78>

00000000000008f0 <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
 8f0:	7139                	addi	sp,sp,-64
 8f2:	fc06                	sd	ra,56(sp)
 8f4:	f822                	sd	s0,48(sp)
 8f6:	f04a                	sd	s2,32(sp)
 8f8:	ec4e                	sd	s3,24(sp)
 8fa:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 8fc:	02051993          	slli	s3,a0,0x20
 900:	0209d993          	srli	s3,s3,0x20
 904:	09bd                	addi	s3,s3,15
 906:	0049d993          	srli	s3,s3,0x4
 90a:	2985                	addiw	s3,s3,1
 90c:	894e                	mv	s2,s3
  if ((prevp = freep) == 0) {
 90e:	00000517          	auipc	a0,0x0
 912:	6f253503          	ld	a0,1778(a0) # 1000 <freep>
 916:	c905                	beqz	a0,946 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 918:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 91a:	4798                	lw	a4,8(a5)
 91c:	09377663          	bgeu	a4,s3,9a8 <malloc+0xb8>
 920:	f426                	sd	s1,40(sp)
 922:	e852                	sd	s4,16(sp)
 924:	e456                	sd	s5,8(sp)
 926:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 928:	8a4e                	mv	s4,s3
 92a:	6705                	lui	a4,0x1
 92c:	00e9f363          	bgeu	s3,a4,932 <malloc+0x42>
 930:	6a05                	lui	s4,0x1
 932:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 936:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 93a:	00000497          	auipc	s1,0x0
 93e:	6c648493          	addi	s1,s1,1734 # 1000 <freep>
  if (p == SBRK_ERROR)
 942:	5afd                	li	s5,-1
 944:	a83d                	j	982 <malloc+0x92>
 946:	f426                	sd	s1,40(sp)
 948:	e852                	sd	s4,16(sp)
 94a:	e456                	sd	s5,8(sp)
 94c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 94e:	00000797          	auipc	a5,0x0
 952:	6c278793          	addi	a5,a5,1730 # 1010 <base>
 956:	00000717          	auipc	a4,0x0
 95a:	6af73523          	sd	a5,1706(a4) # 1000 <freep>
 95e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 960:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 964:	b7d1                	j	928 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 966:	6398                	ld	a4,0(a5)
 968:	e118                	sd	a4,0(a0)
 96a:	a899                	j	9c0 <malloc+0xd0>
  hp->s.size = nu;
 96c:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 970:	0541                	addi	a0,a0,16
 972:	ef5ff0ef          	jal	866 <free>
  return freep;
 976:	6088                	ld	a0,0(s1)
      if ((p = morecore(nunits)) == 0)
 978:	c125                	beqz	a0,9d8 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 97a:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 97c:	4798                	lw	a4,8(a5)
 97e:	03277163          	bgeu	a4,s2,9a0 <malloc+0xb0>
    if (p == freep)
 982:	6098                	ld	a4,0(s1)
 984:	853e                	mv	a0,a5
 986:	fef71ae3          	bne	a4,a5,97a <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 98a:	8552                	mv	a0,s4
 98c:	9ffff0ef          	jal	38a <sbrk>
  if (p == SBRK_ERROR)
 990:	fd551ee3          	bne	a0,s5,96c <malloc+0x7c>
        return 0;
 994:	4501                	li	a0,0
 996:	74a2                	ld	s1,40(sp)
 998:	6a42                	ld	s4,16(sp)
 99a:	6aa2                	ld	s5,8(sp)
 99c:	6b02                	ld	s6,0(sp)
 99e:	a03d                	j	9cc <malloc+0xdc>
 9a0:	74a2                	ld	s1,40(sp)
 9a2:	6a42                	ld	s4,16(sp)
 9a4:	6aa2                	ld	s5,8(sp)
 9a6:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
 9a8:	fae90fe3          	beq	s2,a4,966 <malloc+0x76>
        p->s.size -= nunits;
 9ac:	4137073b          	subw	a4,a4,s3
 9b0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9b2:	02071693          	slli	a3,a4,0x20
 9b6:	01c6d713          	srli	a4,a3,0x1c
 9ba:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9bc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9c0:	00000717          	auipc	a4,0x0
 9c4:	64a73023          	sd	a0,1600(a4) # 1000 <freep>
      return (void *)(p + 1);
 9c8:	01078513          	addi	a0,a5,16
  }
}
 9cc:	70e2                	ld	ra,56(sp)
 9ce:	7442                	ld	s0,48(sp)
 9d0:	7902                	ld	s2,32(sp)
 9d2:	69e2                	ld	s3,24(sp)
 9d4:	6121                	addi	sp,sp,64
 9d6:	8082                	ret
 9d8:	74a2                	ld	s1,40(sp)
 9da:	6a42                	ld	s4,16(sp)
 9dc:	6aa2                	ld	s5,8(sp)
 9de:	6b02                	ld	s6,0(sp)
 9e0:	b7f5                	j	9cc <malloc+0xdc>
