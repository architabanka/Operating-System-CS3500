
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dc010113          	addi	sp,sp,-576
   4:	22113c23          	sd	ra,568(sp)
   8:	22813823          	sd	s0,560(sp)
   c:	22913423          	sd	s1,552(sp)
  10:	23213023          	sd	s2,544(sp)
  14:	21313c23          	sd	s3,536(sp)
  18:	21413823          	sd	s4,528(sp)
  1c:	0480                	addi	s0,sp,576
  int fd, i;
  char path[] = "stressfs0";
  1e:	00001797          	auipc	a5,0x1
  22:	a7278793          	addi	a5,a5,-1422 # a90 <statistics+0xa4>
  26:	6398                	ld	a4,0(a5)
  28:	fce43023          	sd	a4,-64(s0)
  2c:	0087d783          	lhu	a5,8(a5)
  30:	fcf41423          	sh	a5,-56(s0)
  char data[512];

  printf("stressfs starting\n");
  34:	00001517          	auipc	a0,0x1
  38:	a2c50513          	addi	a0,a0,-1492 # a60 <statistics+0x74>
  3c:	003000ef          	jal	83e <printf>
  memset(data, 'a', sizeof(data));
  40:	20000613          	li	a2,512
  44:	06100593          	li	a1,97
  48:	dc040513          	addi	a0,s0,-576
  4c:	128000ef          	jal	174 <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	342000ef          	jal	396 <fork>
  58:	00a04563          	bgtz	a0,62 <main+0x62>
  for(i = 0; i < 4; i++)
  5c:	2485                	addiw	s1,s1,1
  5e:	ff249be3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  62:	85a6                	mv	a1,s1
  64:	00001517          	auipc	a0,0x1
  68:	a1450513          	addi	a0,a0,-1516 # a78 <statistics+0x8c>
  6c:	7d2000ef          	jal	83e <printf>

  path[8] += i;
  70:	fc844783          	lbu	a5,-56(s0)
  74:	9fa5                	addw	a5,a5,s1
  76:	fcf40423          	sb	a5,-56(s0)
  fd = open(path, O_CREATE | O_RDWR);
  7a:	20200593          	li	a1,514
  7e:	fc040513          	addi	a0,s0,-64
  82:	35c000ef          	jal	3de <open>
  86:	892a                	mv	s2,a0
  88:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  8a:	dc040a13          	addi	s4,s0,-576
  8e:	20000993          	li	s3,512
  92:	864e                	mv	a2,s3
  94:	85d2                	mv	a1,s4
  96:	854a                	mv	a0,s2
  98:	326000ef          	jal	3be <write>
  for(i = 0; i < 20; i++)
  9c:	34fd                	addiw	s1,s1,-1
  9e:	f8f5                	bnez	s1,92 <main+0x92>
  close(fd);
  a0:	854a                	mv	a0,s2
  a2:	324000ef          	jal	3c6 <close>

  printf("read\n");
  a6:	00001517          	auipc	a0,0x1
  aa:	9e250513          	addi	a0,a0,-1566 # a88 <statistics+0x9c>
  ae:	790000ef          	jal	83e <printf>

  fd = open(path, O_RDONLY);
  b2:	4581                	li	a1,0
  b4:	fc040513          	addi	a0,s0,-64
  b8:	326000ef          	jal	3de <open>
  bc:	892a                	mv	s2,a0
  be:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  c0:	dc040a13          	addi	s4,s0,-576
  c4:	20000993          	li	s3,512
  c8:	864e                	mv	a2,s3
  ca:	85d2                	mv	a1,s4
  cc:	854a                	mv	a0,s2
  ce:	2e8000ef          	jal	3b6 <read>
  for (i = 0; i < 20; i++)
  d2:	34fd                	addiw	s1,s1,-1
  d4:	f8f5                	bnez	s1,c8 <main+0xc8>
  close(fd);
  d6:	854a                	mv	a0,s2
  d8:	2ee000ef          	jal	3c6 <close>

  wait(0);
  dc:	4501                	li	a0,0
  de:	2c8000ef          	jal	3a6 <wait>

  exit(0);
  e2:	4501                	li	a0,0
  e4:	2ba000ef          	jal	39e <exit>

00000000000000e8 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  e8:	1141                	addi	sp,sp,-16
  ea:	e406                	sd	ra,8(sp)
  ec:	e022                	sd	s0,0(sp)
  ee:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  f0:	f11ff0ef          	jal	0 <main>
  exit(r);
  f4:	2aa000ef          	jal	39e <exit>

00000000000000f8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e406                	sd	ra,8(sp)
  fc:	e022                	sd	s0,0(sp)
  fe:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 100:	87aa                	mv	a5,a0
 102:	0585                	addi	a1,a1,1
 104:	0785                	addi	a5,a5,1
 106:	fff5c703          	lbu	a4,-1(a1)
 10a:	fee78fa3          	sb	a4,-1(a5)
 10e:	fb75                	bnez	a4,102 <strcpy+0xa>
    ;
  return os;
}
 110:	60a2                	ld	ra,8(sp)
 112:	6402                	ld	s0,0(sp)
 114:	0141                	addi	sp,sp,16
 116:	8082                	ret

0000000000000118 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 118:	1141                	addi	sp,sp,-16
 11a:	e406                	sd	ra,8(sp)
 11c:	e022                	sd	s0,0(sp)
 11e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 120:	00054783          	lbu	a5,0(a0)
 124:	cb91                	beqz	a5,138 <strcmp+0x20>
 126:	0005c703          	lbu	a4,0(a1)
 12a:	00f71763          	bne	a4,a5,138 <strcmp+0x20>
    p++, q++;
 12e:	0505                	addi	a0,a0,1
 130:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 132:	00054783          	lbu	a5,0(a0)
 136:	fbe5                	bnez	a5,126 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 138:	0005c503          	lbu	a0,0(a1)
}
 13c:	40a7853b          	subw	a0,a5,a0
 140:	60a2                	ld	ra,8(sp)
 142:	6402                	ld	s0,0(sp)
 144:	0141                	addi	sp,sp,16
 146:	8082                	ret

0000000000000148 <strlen>:

uint
strlen(const char *s)
{
 148:	1141                	addi	sp,sp,-16
 14a:	e406                	sd	ra,8(sp)
 14c:	e022                	sd	s0,0(sp)
 14e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 150:	00054783          	lbu	a5,0(a0)
 154:	cf91                	beqz	a5,170 <strlen+0x28>
 156:	00150793          	addi	a5,a0,1
 15a:	86be                	mv	a3,a5
 15c:	0785                	addi	a5,a5,1
 15e:	fff7c703          	lbu	a4,-1(a5)
 162:	ff65                	bnez	a4,15a <strlen+0x12>
 164:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 168:	60a2                	ld	ra,8(sp)
 16a:	6402                	ld	s0,0(sp)
 16c:	0141                	addi	sp,sp,16
 16e:	8082                	ret
  for(n = 0; s[n]; n++)
 170:	4501                	li	a0,0
 172:	bfdd                	j	168 <strlen+0x20>

0000000000000174 <memset>:

void*
memset(void *dst, int c, uint n)
{
 174:	1141                	addi	sp,sp,-16
 176:	e406                	sd	ra,8(sp)
 178:	e022                	sd	s0,0(sp)
 17a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 17c:	ca19                	beqz	a2,192 <memset+0x1e>
 17e:	87aa                	mv	a5,a0
 180:	1602                	slli	a2,a2,0x20
 182:	9201                	srli	a2,a2,0x20
 184:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 188:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 18c:	0785                	addi	a5,a5,1
 18e:	fee79de3          	bne	a5,a4,188 <memset+0x14>
  }
  return dst;
}
 192:	60a2                	ld	ra,8(sp)
 194:	6402                	ld	s0,0(sp)
 196:	0141                	addi	sp,sp,16
 198:	8082                	ret

000000000000019a <strchr>:

char*
strchr(const char *s, char c)
{
 19a:	1141                	addi	sp,sp,-16
 19c:	e406                	sd	ra,8(sp)
 19e:	e022                	sd	s0,0(sp)
 1a0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1a2:	00054783          	lbu	a5,0(a0)
 1a6:	c799                	beqz	a5,1b4 <strchr+0x1a>
    if(*s == c)
 1a8:	00f58763          	beq	a1,a5,1b6 <strchr+0x1c>
  for(; *s; s++)
 1ac:	0505                	addi	a0,a0,1
 1ae:	00054783          	lbu	a5,0(a0)
 1b2:	fbfd                	bnez	a5,1a8 <strchr+0xe>
      return (char*)s;
  return 0;
 1b4:	4501                	li	a0,0
}
 1b6:	60a2                	ld	ra,8(sp)
 1b8:	6402                	ld	s0,0(sp)
 1ba:	0141                	addi	sp,sp,16
 1bc:	8082                	ret

00000000000001be <gets>:

char*
gets(char *buf, int max)
{
 1be:	711d                	addi	sp,sp,-96
 1c0:	ec86                	sd	ra,88(sp)
 1c2:	e8a2                	sd	s0,80(sp)
 1c4:	e4a6                	sd	s1,72(sp)
 1c6:	e0ca                	sd	s2,64(sp)
 1c8:	fc4e                	sd	s3,56(sp)
 1ca:	f852                	sd	s4,48(sp)
 1cc:	f456                	sd	s5,40(sp)
 1ce:	f05a                	sd	s6,32(sp)
 1d0:	ec5e                	sd	s7,24(sp)
 1d2:	e862                	sd	s8,16(sp)
 1d4:	1080                	addi	s0,sp,96
 1d6:	8baa                	mv	s7,a0
 1d8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1da:	892a                	mv	s2,a0
 1dc:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1de:	faf40b13          	addi	s6,s0,-81
 1e2:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 1e4:	8c26                	mv	s8,s1
 1e6:	0014899b          	addiw	s3,s1,1
 1ea:	84ce                	mv	s1,s3
 1ec:	0349d863          	bge	s3,s4,21c <gets+0x5e>
    cc = read(0, &c, 1);
 1f0:	8656                	mv	a2,s5
 1f2:	85da                	mv	a1,s6
 1f4:	4501                	li	a0,0
 1f6:	1c0000ef          	jal	3b6 <read>
    if(cc < 1)
 1fa:	02a05163          	blez	a0,21c <gets+0x5e>
      break;
    buf[i++] = c;
 1fe:	faf44783          	lbu	a5,-81(s0)
 202:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 206:	0905                	addi	s2,s2,1
 208:	ff678713          	addi	a4,a5,-10
 20c:	00173713          	seqz	a4,a4
 210:	17cd                	addi	a5,a5,-13
 212:	0017b793          	seqz	a5,a5
 216:	8fd9                	or	a5,a5,a4
 218:	d7f1                	beqz	a5,1e4 <gets+0x26>
    buf[i++] = c;
 21a:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 21c:	9c5e                	add	s8,s8,s7
 21e:	000c0023          	sb	zero,0(s8)
  return buf;
}
 222:	855e                	mv	a0,s7
 224:	60e6                	ld	ra,88(sp)
 226:	6446                	ld	s0,80(sp)
 228:	64a6                	ld	s1,72(sp)
 22a:	6906                	ld	s2,64(sp)
 22c:	79e2                	ld	s3,56(sp)
 22e:	7a42                	ld	s4,48(sp)
 230:	7aa2                	ld	s5,40(sp)
 232:	7b02                	ld	s6,32(sp)
 234:	6be2                	ld	s7,24(sp)
 236:	6c42                	ld	s8,16(sp)
 238:	6125                	addi	sp,sp,96
 23a:	8082                	ret

000000000000023c <stat>:

int
stat(const char *n, struct stat *st)
{
 23c:	1101                	addi	sp,sp,-32
 23e:	ec06                	sd	ra,24(sp)
 240:	e822                	sd	s0,16(sp)
 242:	e04a                	sd	s2,0(sp)
 244:	1000                	addi	s0,sp,32
 246:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 248:	4581                	li	a1,0
 24a:	194000ef          	jal	3de <open>
  if(fd < 0)
 24e:	02054263          	bltz	a0,272 <stat+0x36>
 252:	e426                	sd	s1,8(sp)
 254:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 256:	85ca                	mv	a1,s2
 258:	19e000ef          	jal	3f6 <fstat>
 25c:	892a                	mv	s2,a0
  close(fd);
 25e:	8526                	mv	a0,s1
 260:	166000ef          	jal	3c6 <close>
  return r;
 264:	64a2                	ld	s1,8(sp)
}
 266:	854a                	mv	a0,s2
 268:	60e2                	ld	ra,24(sp)
 26a:	6442                	ld	s0,16(sp)
 26c:	6902                	ld	s2,0(sp)
 26e:	6105                	addi	sp,sp,32
 270:	8082                	ret
    return -1;
 272:	57fd                	li	a5,-1
 274:	893e                	mv	s2,a5
 276:	bfc5                	j	266 <stat+0x2a>

0000000000000278 <atoi>:

int
atoi(const char *s)
{
 278:	1141                	addi	sp,sp,-16
 27a:	e406                	sd	ra,8(sp)
 27c:	e022                	sd	s0,0(sp)
 27e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 280:	00054683          	lbu	a3,0(a0)
 284:	fd06879b          	addiw	a5,a3,-48
 288:	0ff7f793          	zext.b	a5,a5
 28c:	4625                	li	a2,9
 28e:	02f66963          	bltu	a2,a5,2c0 <atoi+0x48>
 292:	872a                	mv	a4,a0
  n = 0;
 294:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 296:	0705                	addi	a4,a4,1
 298:	0025179b          	slliw	a5,a0,0x2
 29c:	9fa9                	addw	a5,a5,a0
 29e:	0017979b          	slliw	a5,a5,0x1
 2a2:	9fb5                	addw	a5,a5,a3
 2a4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2a8:	00074683          	lbu	a3,0(a4)
 2ac:	fd06879b          	addiw	a5,a3,-48
 2b0:	0ff7f793          	zext.b	a5,a5
 2b4:	fef671e3          	bgeu	a2,a5,296 <atoi+0x1e>
  return n;
}
 2b8:	60a2                	ld	ra,8(sp)
 2ba:	6402                	ld	s0,0(sp)
 2bc:	0141                	addi	sp,sp,16
 2be:	8082                	ret
  n = 0;
 2c0:	4501                	li	a0,0
 2c2:	bfdd                	j	2b8 <atoi+0x40>

00000000000002c4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2c4:	1141                	addi	sp,sp,-16
 2c6:	e406                	sd	ra,8(sp)
 2c8:	e022                	sd	s0,0(sp)
 2ca:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2cc:	02b57563          	bgeu	a0,a1,2f6 <memmove+0x32>
    while(n-- > 0)
 2d0:	00c05f63          	blez	a2,2ee <memmove+0x2a>
 2d4:	1602                	slli	a2,a2,0x20
 2d6:	9201                	srli	a2,a2,0x20
 2d8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2dc:	872a                	mv	a4,a0
      *dst++ = *src++;
 2de:	0585                	addi	a1,a1,1
 2e0:	0705                	addi	a4,a4,1
 2e2:	fff5c683          	lbu	a3,-1(a1)
 2e6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2ea:	fee79ae3          	bne	a5,a4,2de <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2ee:	60a2                	ld	ra,8(sp)
 2f0:	6402                	ld	s0,0(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret
    while(n-- > 0)
 2f6:	fec05ce3          	blez	a2,2ee <memmove+0x2a>
    dst += n;
 2fa:	00c50733          	add	a4,a0,a2
    src += n;
 2fe:	95b2                	add	a1,a1,a2
 300:	fff6079b          	addiw	a5,a2,-1
 304:	1782                	slli	a5,a5,0x20
 306:	9381                	srli	a5,a5,0x20
 308:	fff7c793          	not	a5,a5
 30c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 30e:	15fd                	addi	a1,a1,-1
 310:	177d                	addi	a4,a4,-1
 312:	0005c683          	lbu	a3,0(a1)
 316:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 31a:	fef71ae3          	bne	a4,a5,30e <memmove+0x4a>
 31e:	bfc1                	j	2ee <memmove+0x2a>

0000000000000320 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 320:	1141                	addi	sp,sp,-16
 322:	e406                	sd	ra,8(sp)
 324:	e022                	sd	s0,0(sp)
 326:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 328:	ce19                	beqz	a2,346 <memcmp+0x26>
 32a:	1602                	slli	a2,a2,0x20
 32c:	9201                	srli	a2,a2,0x20
 32e:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 332:	00054783          	lbu	a5,0(a0)
 336:	0005c703          	lbu	a4,0(a1)
 33a:	00e79b63          	bne	a5,a4,350 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 33e:	0505                	addi	a0,a0,1
    p2++;
 340:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 342:	fed518e3          	bne	a0,a3,332 <memcmp+0x12>
  }
  return 0;
 346:	4501                	li	a0,0
}
 348:	60a2                	ld	ra,8(sp)
 34a:	6402                	ld	s0,0(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret
      return *p1 - *p2;
 350:	40e7853b          	subw	a0,a5,a4
 354:	bfd5                	j	348 <memcmp+0x28>

0000000000000356 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 356:	1141                	addi	sp,sp,-16
 358:	e406                	sd	ra,8(sp)
 35a:	e022                	sd	s0,0(sp)
 35c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 35e:	f67ff0ef          	jal	2c4 <memmove>
}
 362:	60a2                	ld	ra,8(sp)
 364:	6402                	ld	s0,0(sp)
 366:	0141                	addi	sp,sp,16
 368:	8082                	ret

000000000000036a <sbrk>:

char *
sbrk(int n) {
 36a:	1141                	addi	sp,sp,-16
 36c:	e406                	sd	ra,8(sp)
 36e:	e022                	sd	s0,0(sp)
 370:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 372:	4585                	li	a1,1
 374:	0b2000ef          	jal	426 <sys_sbrk>
}
 378:	60a2                	ld	ra,8(sp)
 37a:	6402                	ld	s0,0(sp)
 37c:	0141                	addi	sp,sp,16
 37e:	8082                	ret

0000000000000380 <sbrklazy>:

char *
sbrklazy(int n) {
 380:	1141                	addi	sp,sp,-16
 382:	e406                	sd	ra,8(sp)
 384:	e022                	sd	s0,0(sp)
 386:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 388:	4589                	li	a1,2
 38a:	09c000ef          	jal	426 <sys_sbrk>
}
 38e:	60a2                	ld	ra,8(sp)
 390:	6402                	ld	s0,0(sp)
 392:	0141                	addi	sp,sp,16
 394:	8082                	ret

0000000000000396 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 396:	4885                	li	a7,1
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <exit>:
.global exit
exit:
 li a7, SYS_exit
 39e:	4889                	li	a7,2
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3a6:	488d                	li	a7,3
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3ae:	4891                	li	a7,4
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <read>:
.global read
read:
 li a7, SYS_read
 3b6:	4895                	li	a7,5
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <write>:
.global write
write:
 li a7, SYS_write
 3be:	48c1                	li	a7,16
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <close>:
.global close
close:
 li a7, SYS_close
 3c6:	48d5                	li	a7,21
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <kill>:
.global kill
kill:
 li a7, SYS_kill
 3ce:	4899                	li	a7,6
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3d6:	489d                	li	a7,7
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <open>:
.global open
open:
 li a7, SYS_open
 3de:	48bd                	li	a7,15
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3e6:	48c5                	li	a7,17
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3ee:	48c9                	li	a7,18
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3f6:	48a1                	li	a7,8
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <link>:
.global link
link:
 li a7, SYS_link
 3fe:	48cd                	li	a7,19
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 406:	48d1                	li	a7,20
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 40e:	48a5                	li	a7,9
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <dup>:
.global dup
dup:
 li a7, SYS_dup
 416:	48a9                	li	a7,10
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 41e:	48ad                	li	a7,11
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 426:	48b1                	li	a7,12
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <pause>:
.global pause
pause:
 li a7, SYS_pause
 42e:	48b5                	li	a7,13
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 436:	48b9                	li	a7,14
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <bind>:
.global bind
bind:
 li a7, SYS_bind
 43e:	48f5                	li	a7,29
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 446:	48f9                	li	a7,30
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <send>:
.global send
send:
 li a7, SYS_send
 44e:	48fd                	li	a7,31
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <recv>:
.global recv
recv:
 li a7, SYS_recv
 456:	02000893          	li	a7,32
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 460:	02100893          	li	a7,33
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 46a:	02200893          	li	a7,34
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <rwlktest>:
.global rwlktest
rwlktest:
 li a7, SYS_rwlktest
 474:	02300893          	li	a7,35
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <cpupin>:
.global cpupin
cpupin:
 li a7, SYS_cpupin
 47e:	02400893          	li	a7,36
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 488:	1101                	addi	sp,sp,-32
 48a:	ec06                	sd	ra,24(sp)
 48c:	e822                	sd	s0,16(sp)
 48e:	1000                	addi	s0,sp,32
 490:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 494:	4605                	li	a2,1
 496:	fef40593          	addi	a1,s0,-17
 49a:	f25ff0ef          	jal	3be <write>
}
 49e:	60e2                	ld	ra,24(sp)
 4a0:	6442                	ld	s0,16(sp)
 4a2:	6105                	addi	sp,sp,32
 4a4:	8082                	ret

00000000000004a6 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4a6:	715d                	addi	sp,sp,-80
 4a8:	e486                	sd	ra,72(sp)
 4aa:	e0a2                	sd	s0,64(sp)
 4ac:	f84a                	sd	s2,48(sp)
 4ae:	f44e                	sd	s3,40(sp)
 4b0:	0880                	addi	s0,sp,80
 4b2:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 4b4:	00d036b3          	snez	a3,a3
 4b8:	03f5d793          	srli	a5,a1,0x3f
 4bc:	8efd                	and	a3,a3,a5
  neg = 0;
 4be:	4301                	li	t1,0
  if(sgn && xx < 0){
 4c0:	c681                	beqz	a3,4c8 <printint+0x22>
    neg = 1;
    x = -xx;
 4c2:	40b005b3          	neg	a1,a1
    neg = 1;
 4c6:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 4c8:	fb840993          	addi	s3,s0,-72
  neg = 0;
 4cc:	86ce                	mv	a3,s3
  i = 0;
 4ce:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4d0:	00000817          	auipc	a6,0x0
 4d4:	60080813          	addi	a6,a6,1536 # ad0 <digits>
 4d8:	88ba                	mv	a7,a4
 4da:	0017051b          	addiw	a0,a4,1
 4de:	872a                	mv	a4,a0
 4e0:	02c5f7b3          	remu	a5,a1,a2
 4e4:	97c2                	add	a5,a5,a6
 4e6:	0007c783          	lbu	a5,0(a5)
 4ea:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4ee:	87ae                	mv	a5,a1
 4f0:	02c5d5b3          	divu	a1,a1,a2
 4f4:	0685                	addi	a3,a3,1
 4f6:	fec7f1e3          	bgeu	a5,a2,4d8 <printint+0x32>
  if(neg)
 4fa:	00030b63          	beqz	t1,510 <printint+0x6a>
    buf[i++] = '-';
 4fe:	fd040793          	addi	a5,s0,-48
 502:	953e                	add	a0,a0,a5
 504:	02d00793          	li	a5,45
 508:	fef50423          	sb	a5,-24(a0)
 50c:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 510:	02e05563          	blez	a4,53a <printint+0x94>
 514:	fc26                	sd	s1,56(sp)
 516:	377d                	addiw	a4,a4,-1
 518:	00e984b3          	add	s1,s3,a4
 51c:	19fd                	addi	s3,s3,-1
 51e:	99ba                	add	s3,s3,a4
 520:	1702                	slli	a4,a4,0x20
 522:	9301                	srli	a4,a4,0x20
 524:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 528:	0004c583          	lbu	a1,0(s1)
 52c:	854a                	mv	a0,s2
 52e:	f5bff0ef          	jal	488 <putc>
  while(--i >= 0)
 532:	14fd                	addi	s1,s1,-1
 534:	ff349ae3          	bne	s1,s3,528 <printint+0x82>
 538:	74e2                	ld	s1,56(sp)
}
 53a:	60a6                	ld	ra,72(sp)
 53c:	6406                	ld	s0,64(sp)
 53e:	7942                	ld	s2,48(sp)
 540:	79a2                	ld	s3,40(sp)
 542:	6161                	addi	sp,sp,80
 544:	8082                	ret

0000000000000546 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 546:	711d                	addi	sp,sp,-96
 548:	ec86                	sd	ra,88(sp)
 54a:	e8a2                	sd	s0,80(sp)
 54c:	e4a6                	sd	s1,72(sp)
 54e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 550:	0005c483          	lbu	s1,0(a1)
 554:	2a048063          	beqz	s1,7f4 <vprintf+0x2ae>
 558:	e0ca                	sd	s2,64(sp)
 55a:	fc4e                	sd	s3,56(sp)
 55c:	f852                	sd	s4,48(sp)
 55e:	f456                	sd	s5,40(sp)
 560:	f05a                	sd	s6,32(sp)
 562:	ec5e                	sd	s7,24(sp)
 564:	e862                	sd	s8,16(sp)
 566:	8b2a                	mv	s6,a0
 568:	8a2e                	mv	s4,a1
 56a:	8bb2                	mv	s7,a2
  state = 0;
 56c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 56e:	4901                	li	s2,0
 570:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 572:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 576:	06400c13          	li	s8,100
 57a:	a00d                	j	59c <vprintf+0x56>
        putc(fd, c0);
 57c:	85a6                	mv	a1,s1
 57e:	855a                	mv	a0,s6
 580:	f09ff0ef          	jal	488 <putc>
 584:	a019                	j	58a <vprintf+0x44>
    } else if(state == '%'){
 586:	03598363          	beq	s3,s5,5ac <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 58a:	0019079b          	addiw	a5,s2,1
 58e:	893e                	mv	s2,a5
 590:	873e                	mv	a4,a5
 592:	97d2                	add	a5,a5,s4
 594:	0007c483          	lbu	s1,0(a5)
 598:	24048763          	beqz	s1,7e6 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 59c:	0004879b          	sext.w	a5,s1
    if(state == 0){
 5a0:	fe0993e3          	bnez	s3,586 <vprintf+0x40>
      if(c0 == '%'){
 5a4:	fd579ce3          	bne	a5,s5,57c <vprintf+0x36>
        state = '%';
 5a8:	89be                	mv	s3,a5
 5aa:	b7c5                	j	58a <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 5ac:	00ea06b3          	add	a3,s4,a4
 5b0:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 5b4:	24060563          	beqz	a2,7fe <vprintf+0x2b8>
      if(c0 == 'd'){
 5b8:	0b878763          	beq	a5,s8,666 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5bc:	f9478693          	addi	a3,a5,-108
 5c0:	0016b693          	seqz	a3,a3
 5c4:	f9c60593          	addi	a1,a2,-100
 5c8:	0015b593          	seqz	a1,a1
 5cc:	8df5                	and	a1,a1,a3
 5ce:	e9c5                	bnez	a1,67e <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 5d0:	9752                	add	a4,a4,s4
 5d2:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5d6:	f9460713          	addi	a4,a2,-108
 5da:	00173713          	seqz	a4,a4
 5de:	8f75                	and	a4,a4,a3
 5e0:	f9c50593          	addi	a1,a0,-100
 5e4:	0015b593          	seqz	a1,a1
 5e8:	8df9                	and	a1,a1,a4
 5ea:	e5dd                	bnez	a1,698 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5ec:	07500593          	li	a1,117
 5f0:	0cb78163          	beq	a5,a1,6b2 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 5f4:	f8b60593          	addi	a1,a2,-117
 5f8:	0015b593          	seqz	a1,a1
 5fc:	8df5                	and	a1,a1,a3
 5fe:	e5f1                	bnez	a1,6ca <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 600:	f8b50593          	addi	a1,a0,-117
 604:	0015b593          	seqz	a1,a1
 608:	8df9                	and	a1,a1,a4
 60a:	ede9                	bnez	a1,6e4 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 60c:	07800593          	li	a1,120
 610:	0eb78763          	beq	a5,a1,6fe <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 614:	f8860613          	addi	a2,a2,-120
 618:	00163613          	seqz	a2,a2
 61c:	8ef1                	and	a3,a3,a2
 61e:	0e069c63          	bnez	a3,716 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 622:	f8850513          	addi	a0,a0,-120
 626:	00153513          	seqz	a0,a0
 62a:	8f69                	and	a4,a4,a0
 62c:	10071263          	bnez	a4,730 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 630:	07000713          	li	a4,112
 634:	10e78a63          	beq	a5,a4,748 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 638:	06300713          	li	a4,99
 63c:	14e78a63          	beq	a5,a4,790 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 640:	07300713          	li	a4,115
 644:	16e78063          	beq	a5,a4,7a4 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 648:	02500713          	li	a4,37
 64c:	18e78863          	beq	a5,a4,7dc <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 650:	02500593          	li	a1,37
 654:	855a                	mv	a0,s6
 656:	e33ff0ef          	jal	488 <putc>
        putc(fd, c0);
 65a:	85a6                	mv	a1,s1
 65c:	855a                	mv	a0,s6
 65e:	e2bff0ef          	jal	488 <putc>
      }

      state = 0;
 662:	4981                	li	s3,0
 664:	b71d                	j	58a <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 666:	008b8493          	addi	s1,s7,8
 66a:	4685                	li	a3,1
 66c:	4629                	li	a2,10
 66e:	000ba583          	lw	a1,0(s7)
 672:	855a                	mv	a0,s6
 674:	e33ff0ef          	jal	4a6 <printint>
 678:	8ba6                	mv	s7,s1
      state = 0;
 67a:	4981                	li	s3,0
 67c:	b739                	j	58a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 67e:	008b8493          	addi	s1,s7,8
 682:	4685                	li	a3,1
 684:	4629                	li	a2,10
 686:	000bb583          	ld	a1,0(s7)
 68a:	855a                	mv	a0,s6
 68c:	e1bff0ef          	jal	4a6 <printint>
        i += 1;
 690:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 692:	8ba6                	mv	s7,s1
      state = 0;
 694:	4981                	li	s3,0
 696:	bdd5                	j	58a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 698:	008b8493          	addi	s1,s7,8
 69c:	4685                	li	a3,1
 69e:	4629                	li	a2,10
 6a0:	000bb583          	ld	a1,0(s7)
 6a4:	855a                	mv	a0,s6
 6a6:	e01ff0ef          	jal	4a6 <printint>
        i += 2;
 6aa:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ac:	8ba6                	mv	s7,s1
      state = 0;
 6ae:	4981                	li	s3,0
        i += 2;
 6b0:	bde9                	j	58a <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6b2:	008b8493          	addi	s1,s7,8
 6b6:	4681                	li	a3,0
 6b8:	4629                	li	a2,10
 6ba:	000be583          	lwu	a1,0(s7)
 6be:	855a                	mv	a0,s6
 6c0:	de7ff0ef          	jal	4a6 <printint>
 6c4:	8ba6                	mv	s7,s1
      state = 0;
 6c6:	4981                	li	s3,0
 6c8:	b5c9                	j	58a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ca:	008b8493          	addi	s1,s7,8
 6ce:	4681                	li	a3,0
 6d0:	4629                	li	a2,10
 6d2:	000bb583          	ld	a1,0(s7)
 6d6:	855a                	mv	a0,s6
 6d8:	dcfff0ef          	jal	4a6 <printint>
        i += 1;
 6dc:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6de:	8ba6                	mv	s7,s1
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	b565                	j	58a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6e4:	008b8493          	addi	s1,s7,8
 6e8:	4681                	li	a3,0
 6ea:	4629                	li	a2,10
 6ec:	000bb583          	ld	a1,0(s7)
 6f0:	855a                	mv	a0,s6
 6f2:	db5ff0ef          	jal	4a6 <printint>
        i += 2;
 6f6:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6f8:	8ba6                	mv	s7,s1
      state = 0;
 6fa:	4981                	li	s3,0
        i += 2;
 6fc:	b579                	j	58a <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6fe:	008b8493          	addi	s1,s7,8
 702:	4681                	li	a3,0
 704:	4641                	li	a2,16
 706:	000be583          	lwu	a1,0(s7)
 70a:	855a                	mv	a0,s6
 70c:	d9bff0ef          	jal	4a6 <printint>
 710:	8ba6                	mv	s7,s1
      state = 0;
 712:	4981                	li	s3,0
 714:	bd9d                	j	58a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 716:	008b8493          	addi	s1,s7,8
 71a:	4681                	li	a3,0
 71c:	4641                	li	a2,16
 71e:	000bb583          	ld	a1,0(s7)
 722:	855a                	mv	a0,s6
 724:	d83ff0ef          	jal	4a6 <printint>
        i += 1;
 728:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 72a:	8ba6                	mv	s7,s1
      state = 0;
 72c:	4981                	li	s3,0
 72e:	bdb1                	j	58a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 730:	008b8493          	addi	s1,s7,8
 734:	4641                	li	a2,16
 736:	000bb583          	ld	a1,0(s7)
 73a:	855a                	mv	a0,s6
 73c:	d6bff0ef          	jal	4a6 <printint>
        i += 2;
 740:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 742:	8ba6                	mv	s7,s1
      state = 0;
 744:	4981                	li	s3,0
        i += 2;
 746:	b591                	j	58a <vprintf+0x44>
 748:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 74a:	008b8793          	addi	a5,s7,8
 74e:	8cbe                	mv	s9,a5
 750:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 754:	03000593          	li	a1,48
 758:	855a                	mv	a0,s6
 75a:	d2fff0ef          	jal	488 <putc>
  putc(fd, 'x');
 75e:	07800593          	li	a1,120
 762:	855a                	mv	a0,s6
 764:	d25ff0ef          	jal	488 <putc>
 768:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 76a:	00000b97          	auipc	s7,0x0
 76e:	366b8b93          	addi	s7,s7,870 # ad0 <digits>
 772:	03c9d793          	srli	a5,s3,0x3c
 776:	97de                	add	a5,a5,s7
 778:	0007c583          	lbu	a1,0(a5)
 77c:	855a                	mv	a0,s6
 77e:	d0bff0ef          	jal	488 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 782:	0992                	slli	s3,s3,0x4
 784:	34fd                	addiw	s1,s1,-1
 786:	f4f5                	bnez	s1,772 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 788:	8be6                	mv	s7,s9
      state = 0;
 78a:	4981                	li	s3,0
 78c:	6ca2                	ld	s9,8(sp)
 78e:	bbf5                	j	58a <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 790:	008b8493          	addi	s1,s7,8
 794:	000bc583          	lbu	a1,0(s7)
 798:	855a                	mv	a0,s6
 79a:	cefff0ef          	jal	488 <putc>
 79e:	8ba6                	mv	s7,s1
      state = 0;
 7a0:	4981                	li	s3,0
 7a2:	b3e5                	j	58a <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 7a4:	008b8993          	addi	s3,s7,8
 7a8:	000bb483          	ld	s1,0(s7)
 7ac:	cc91                	beqz	s1,7c8 <vprintf+0x282>
        for(; *s; s++)
 7ae:	0004c583          	lbu	a1,0(s1)
 7b2:	c195                	beqz	a1,7d6 <vprintf+0x290>
          putc(fd, *s);
 7b4:	855a                	mv	a0,s6
 7b6:	cd3ff0ef          	jal	488 <putc>
        for(; *s; s++)
 7ba:	0485                	addi	s1,s1,1
 7bc:	0004c583          	lbu	a1,0(s1)
 7c0:	f9f5                	bnez	a1,7b4 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 7c2:	8bce                	mv	s7,s3
      state = 0;
 7c4:	4981                	li	s3,0
 7c6:	b3d1                	j	58a <vprintf+0x44>
          s = "(null)";
 7c8:	00000497          	auipc	s1,0x0
 7cc:	2d848493          	addi	s1,s1,728 # aa0 <statistics+0xb4>
        for(; *s; s++)
 7d0:	02800593          	li	a1,40
 7d4:	b7c5                	j	7b4 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 7d6:	8bce                	mv	s7,s3
      state = 0;
 7d8:	4981                	li	s3,0
 7da:	bb45                	j	58a <vprintf+0x44>
        putc(fd, '%');
 7dc:	85be                	mv	a1,a5
 7de:	855a                	mv	a0,s6
 7e0:	ca9ff0ef          	jal	488 <putc>
 7e4:	bdbd                	j	662 <vprintf+0x11c>
 7e6:	6906                	ld	s2,64(sp)
 7e8:	79e2                	ld	s3,56(sp)
 7ea:	7a42                	ld	s4,48(sp)
 7ec:	7aa2                	ld	s5,40(sp)
 7ee:	7b02                	ld	s6,32(sp)
 7f0:	6be2                	ld	s7,24(sp)
 7f2:	6c42                	ld	s8,16(sp)
    }
  }
}
 7f4:	60e6                	ld	ra,88(sp)
 7f6:	6446                	ld	s0,80(sp)
 7f8:	64a6                	ld	s1,72(sp)
 7fa:	6125                	addi	sp,sp,96
 7fc:	8082                	ret
      if(c0 == 'd'){
 7fe:	06400713          	li	a4,100
 802:	e6e782e3          	beq	a5,a4,666 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 806:	f9478693          	addi	a3,a5,-108
 80a:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 80e:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 810:	4701                	li	a4,0
 812:	bbe9                	j	5ec <vprintf+0xa6>

0000000000000814 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 814:	715d                	addi	sp,sp,-80
 816:	ec06                	sd	ra,24(sp)
 818:	e822                	sd	s0,16(sp)
 81a:	1000                	addi	s0,sp,32
 81c:	e010                	sd	a2,0(s0)
 81e:	e414                	sd	a3,8(s0)
 820:	e818                	sd	a4,16(s0)
 822:	ec1c                	sd	a5,24(s0)
 824:	03043023          	sd	a6,32(s0)
 828:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 82c:	8622                	mv	a2,s0
 82e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 832:	d15ff0ef          	jal	546 <vprintf>
}
 836:	60e2                	ld	ra,24(sp)
 838:	6442                	ld	s0,16(sp)
 83a:	6161                	addi	sp,sp,80
 83c:	8082                	ret

000000000000083e <printf>:

void
printf(const char *fmt, ...)
{
 83e:	711d                	addi	sp,sp,-96
 840:	ec06                	sd	ra,24(sp)
 842:	e822                	sd	s0,16(sp)
 844:	1000                	addi	s0,sp,32
 846:	e40c                	sd	a1,8(s0)
 848:	e810                	sd	a2,16(s0)
 84a:	ec14                	sd	a3,24(s0)
 84c:	f018                	sd	a4,32(s0)
 84e:	f41c                	sd	a5,40(s0)
 850:	03043823          	sd	a6,48(s0)
 854:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 858:	00840613          	addi	a2,s0,8
 85c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 860:	85aa                	mv	a1,a0
 862:	4505                	li	a0,1
 864:	ce3ff0ef          	jal	546 <vprintf>
}
 868:	60e2                	ld	ra,24(sp)
 86a:	6442                	ld	s0,16(sp)
 86c:	6125                	addi	sp,sp,96
 86e:	8082                	ret

0000000000000870 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 870:	1141                	addi	sp,sp,-16
 872:	e406                	sd	ra,8(sp)
 874:	e022                	sd	s0,0(sp)
 876:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 878:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 87c:	00000797          	auipc	a5,0x0
 880:	7847b783          	ld	a5,1924(a5) # 1000 <freep>
 884:	a095                	j	8e8 <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 886:	ff852583          	lw	a1,-8(a0)
 88a:	6390                	ld	a2,0(a5)
 88c:	02059813          	slli	a6,a1,0x20
 890:	01c85693          	srli	a3,a6,0x1c
 894:	96ba                	add	a3,a3,a4
 896:	02d60563          	beq	a2,a3,8c0 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 89a:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 89e:	4790                	lw	a2,8(a5)
 8a0:	02061593          	slli	a1,a2,0x20
 8a4:	01c5d693          	srli	a3,a1,0x1c
 8a8:	96be                	add	a3,a3,a5
 8aa:	02d70263          	beq	a4,a3,8ce <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 8ae:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8b0:	00000717          	auipc	a4,0x0
 8b4:	74f73823          	sd	a5,1872(a4) # 1000 <freep>
}
 8b8:	60a2                	ld	ra,8(sp)
 8ba:	6402                	ld	s0,0(sp)
 8bc:	0141                	addi	sp,sp,16
 8be:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 8c0:	4614                	lw	a3,8(a2)
 8c2:	9ead                	addw	a3,a3,a1
 8c4:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8c8:	6394                	ld	a3,0(a5)
 8ca:	6290                	ld	a2,0(a3)
 8cc:	b7f9                	j	89a <free+0x2a>
    p->s.size += bp->s.size;
 8ce:	ff852703          	lw	a4,-8(a0)
 8d2:	9f31                	addw	a4,a4,a2
 8d4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8d6:	ff053703          	ld	a4,-16(a0)
 8da:	bfd1                	j	8ae <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8dc:	6394                	ld	a3,0(a5)
 8de:	00d7e463          	bltu	a5,a3,8e6 <free+0x76>
 8e2:	fad762e3          	bltu	a4,a3,886 <free+0x16>
 8e6:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e8:	fee7fae3          	bgeu	a5,a4,8dc <free+0x6c>
 8ec:	6394                	ld	a3,0(a5)
 8ee:	f8d76ce3          	bltu	a4,a3,886 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f2:	f8d7fae3          	bgeu	a5,a3,886 <free+0x16>
 8f6:	87b6                	mv	a5,a3
 8f8:	bfc5                	j	8e8 <free+0x78>

00000000000008fa <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8fa:	7139                	addi	sp,sp,-64
 8fc:	fc06                	sd	ra,56(sp)
 8fe:	f822                	sd	s0,48(sp)
 900:	f04a                	sd	s2,32(sp)
 902:	ec4e                	sd	s3,24(sp)
 904:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 906:	02051993          	slli	s3,a0,0x20
 90a:	0209d993          	srli	s3,s3,0x20
 90e:	09bd                	addi	s3,s3,15
 910:	0049d993          	srli	s3,s3,0x4
 914:	2985                	addiw	s3,s3,1
 916:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 918:	00000517          	auipc	a0,0x0
 91c:	6e853503          	ld	a0,1768(a0) # 1000 <freep>
 920:	c905                	beqz	a0,950 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 922:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 924:	4798                	lw	a4,8(a5)
 926:	09377663          	bgeu	a4,s3,9b2 <malloc+0xb8>
 92a:	f426                	sd	s1,40(sp)
 92c:	e852                	sd	s4,16(sp)
 92e:	e456                	sd	s5,8(sp)
 930:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 932:	8a4e                	mv	s4,s3
 934:	6705                	lui	a4,0x1
 936:	00e9f363          	bgeu	s3,a4,93c <malloc+0x42>
 93a:	6a05                	lui	s4,0x1
 93c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 940:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 944:	00000497          	auipc	s1,0x0
 948:	6bc48493          	addi	s1,s1,1724 # 1000 <freep>
  if(p == SBRK_ERROR)
 94c:	5afd                	li	s5,-1
 94e:	a83d                	j	98c <malloc+0x92>
 950:	f426                	sd	s1,40(sp)
 952:	e852                	sd	s4,16(sp)
 954:	e456                	sd	s5,8(sp)
 956:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 958:	00000797          	auipc	a5,0x0
 95c:	6b878793          	addi	a5,a5,1720 # 1010 <base>
 960:	00000717          	auipc	a4,0x0
 964:	6af73023          	sd	a5,1696(a4) # 1000 <freep>
 968:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 96a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 96e:	b7d1                	j	932 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 970:	6398                	ld	a4,0(a5)
 972:	e118                	sd	a4,0(a0)
 974:	a899                	j	9ca <malloc+0xd0>
  hp->s.size = nu;
 976:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 97a:	0541                	addi	a0,a0,16
 97c:	ef5ff0ef          	jal	870 <free>
  return freep;
 980:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 982:	c125                	beqz	a0,9e2 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 984:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 986:	4798                	lw	a4,8(a5)
 988:	03277163          	bgeu	a4,s2,9aa <malloc+0xb0>
    if(p == freep)
 98c:	6098                	ld	a4,0(s1)
 98e:	853e                	mv	a0,a5
 990:	fef71ae3          	bne	a4,a5,984 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 994:	8552                	mv	a0,s4
 996:	9d5ff0ef          	jal	36a <sbrk>
  if(p == SBRK_ERROR)
 99a:	fd551ee3          	bne	a0,s5,976 <malloc+0x7c>
        return 0;
 99e:	4501                	li	a0,0
 9a0:	74a2                	ld	s1,40(sp)
 9a2:	6a42                	ld	s4,16(sp)
 9a4:	6aa2                	ld	s5,8(sp)
 9a6:	6b02                	ld	s6,0(sp)
 9a8:	a03d                	j	9d6 <malloc+0xdc>
 9aa:	74a2                	ld	s1,40(sp)
 9ac:	6a42                	ld	s4,16(sp)
 9ae:	6aa2                	ld	s5,8(sp)
 9b0:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9b2:	fae90fe3          	beq	s2,a4,970 <malloc+0x76>
        p->s.size -= nunits;
 9b6:	4137073b          	subw	a4,a4,s3
 9ba:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9bc:	02071693          	slli	a3,a4,0x20
 9c0:	01c6d713          	srli	a4,a3,0x1c
 9c4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9c6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9ca:	00000717          	auipc	a4,0x0
 9ce:	62a73b23          	sd	a0,1590(a4) # 1000 <freep>
      return (void*)(p + 1);
 9d2:	01078513          	addi	a0,a5,16
  }
}
 9d6:	70e2                	ld	ra,56(sp)
 9d8:	7442                	ld	s0,48(sp)
 9da:	7902                	ld	s2,32(sp)
 9dc:	69e2                	ld	s3,24(sp)
 9de:	6121                	addi	sp,sp,64
 9e0:	8082                	ret
 9e2:	74a2                	ld	s1,40(sp)
 9e4:	6a42                	ld	s4,16(sp)
 9e6:	6aa2                	ld	s5,8(sp)
 9e8:	6b02                	ld	s6,0(sp)
 9ea:	b7f5                	j	9d6 <malloc+0xdc>

00000000000009ec <statistics>:
#include "kernel/fcntl.h"
#include "user/user.h"

int
statistics(void *buf, int sz)
{
 9ec:	7179                	addi	sp,sp,-48
 9ee:	f406                	sd	ra,40(sp)
 9f0:	f022                	sd	s0,32(sp)
 9f2:	ec26                	sd	s1,24(sp)
 9f4:	e84a                	sd	s2,16(sp)
 9f6:	e44e                	sd	s3,8(sp)
 9f8:	e052                	sd	s4,0(sp)
 9fa:	1800                	addi	s0,sp,48
 9fc:	8a2a                	mv	s4,a0
 9fe:	892e                	mv	s2,a1
  int fd, i, n;
  
  fd = open("statistics", O_RDONLY);
 a00:	4581                	li	a1,0
 a02:	00000517          	auipc	a0,0x0
 a06:	0a650513          	addi	a0,a0,166 # aa8 <statistics+0xbc>
 a0a:	9d5ff0ef          	jal	3de <open>
  if(fd < 0) {
 a0e:	02054e63          	bltz	a0,a4a <statistics+0x5e>
 a12:	89aa                	mv	s3,a0
      fprintf(2, "stats: open failed\n");
      exit(1);
  }
  for (i = 0; i < sz; ) {
 a14:	4481                	li	s1,0
 a16:	01205e63          	blez	s2,a32 <statistics+0x46>
    if ((n = read(fd, buf+i, sz-i)) < 0) {
 a1a:	4099063b          	subw	a2,s2,s1
 a1e:	009a05b3          	add	a1,s4,s1
 a22:	854e                	mv	a0,s3
 a24:	993ff0ef          	jal	3b6 <read>
 a28:	00054563          	bltz	a0,a32 <statistics+0x46>
      break;
    }
    i += n;
 a2c:	9ca9                	addw	s1,s1,a0
  for (i = 0; i < sz; ) {
 a2e:	ff24c6e3          	blt	s1,s2,a1a <statistics+0x2e>
  }
  close(fd);
 a32:	854e                	mv	a0,s3
 a34:	993ff0ef          	jal	3c6 <close>
  return i;
}
 a38:	8526                	mv	a0,s1
 a3a:	70a2                	ld	ra,40(sp)
 a3c:	7402                	ld	s0,32(sp)
 a3e:	64e2                	ld	s1,24(sp)
 a40:	6942                	ld	s2,16(sp)
 a42:	69a2                	ld	s3,8(sp)
 a44:	6a02                	ld	s4,0(sp)
 a46:	6145                	addi	sp,sp,48
 a48:	8082                	ret
      fprintf(2, "stats: open failed\n");
 a4a:	00000597          	auipc	a1,0x0
 a4e:	06e58593          	addi	a1,a1,110 # ab8 <statistics+0xcc>
 a52:	4509                	li	a0,2
 a54:	dc1ff0ef          	jal	814 <fprintf>
      exit(1);
 a58:	4505                	li	a0,1
 a5a:	945ff0ef          	jal	39e <exit>
