
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
  22:	9c278793          	addi	a5,a5,-1598 # 9e0 <malloc+0x126>
  26:	6398                	ld	a4,0(a5)
  28:	fce43023          	sd	a4,-64(s0)
  2c:	0087d783          	lhu	a5,8(a5)
  30:	fcf41423          	sh	a5,-56(s0)
  char data[512];

  printf("stressfs starting\n");
  34:	00001517          	auipc	a0,0x1
  38:	97c50513          	addi	a0,a0,-1668 # 9b0 <malloc+0xf6>
  3c:	7c2000ef          	jal	7fe <printf>
  memset(data, 'a', sizeof(data));
  40:	20000613          	li	a2,512
  44:	06100593          	li	a1,97
  48:	dc040513          	addi	a0,s0,-576
  4c:	12a000ef          	jal	176 <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	344000ef          	jal	398 <fork>
  58:	00a04563          	bgtz	a0,62 <main+0x62>
  for(i = 0; i < 4; i++)
  5c:	2485                	addiw	s1,s1,1
  5e:	ff249be3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  62:	85a6                	mv	a1,s1
  64:	00001517          	auipc	a0,0x1
  68:	96450513          	addi	a0,a0,-1692 # 9c8 <malloc+0x10e>
  6c:	792000ef          	jal	7fe <printf>

  path[8] += i;
  70:	fc844783          	lbu	a5,-56(s0)
  74:	9fa5                	addw	a5,a5,s1
  76:	fcf40423          	sb	a5,-56(s0)
  fd = open(path, O_CREATE | O_RDWR);
  7a:	20200593          	li	a1,514
  7e:	fc040513          	addi	a0,s0,-64
  82:	35e000ef          	jal	3e0 <open>
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
  98:	328000ef          	jal	3c0 <write>
  for(i = 0; i < 20; i++)
  9c:	34fd                	addiw	s1,s1,-1
  9e:	f8f5                	bnez	s1,92 <main+0x92>
  close(fd);
  a0:	854a                	mv	a0,s2
  a2:	326000ef          	jal	3c8 <close>

  printf("read\n");
  a6:	00001517          	auipc	a0,0x1
  aa:	93250513          	addi	a0,a0,-1742 # 9d8 <malloc+0x11e>
  ae:	750000ef          	jal	7fe <printf>

  fd = open(path, O_RDONLY);
  b2:	4581                	li	a1,0
  b4:	fc040513          	addi	a0,s0,-64
  b8:	328000ef          	jal	3e0 <open>
  bc:	892a                	mv	s2,a0
  be:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  c0:	dc040a13          	addi	s4,s0,-576
  c4:	20000993          	li	s3,512
  c8:	864e                	mv	a2,s3
  ca:	85d2                	mv	a1,s4
  cc:	854a                	mv	a0,s2
  ce:	2ea000ef          	jal	3b8 <read>
  for (i = 0; i < 20; i++)
  d2:	34fd                	addiw	s1,s1,-1
  d4:	f8f5                	bnez	s1,c8 <main+0xc8>
  close(fd);
  d6:	854a                	mv	a0,s2
  d8:	2f0000ef          	jal	3c8 <close>

  wait(0);
  dc:	4501                	li	a0,0
  de:	2ca000ef          	jal	3a8 <wait>

  exit(0);
  e2:	4501                	li	a0,0
  e4:	2bc000ef          	jal	3a0 <exit>

00000000000000e8 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  e8:	1141                	addi	sp,sp,-16
  ea:	e406                	sd	ra,8(sp)
  ec:	e022                	sd	s0,0(sp)
  ee:	0800                	addi	s0,sp,16
  extern int main();
  main();
  f0:	f11ff0ef          	jal	0 <main>
  exit(0);
  f4:	4501                	li	a0,0
  f6:	2aa000ef          	jal	3a0 <exit>

00000000000000fa <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  fa:	1141                	addi	sp,sp,-16
  fc:	e406                	sd	ra,8(sp)
  fe:	e022                	sd	s0,0(sp)
 100:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 102:	87aa                	mv	a5,a0
 104:	0585                	addi	a1,a1,1
 106:	0785                	addi	a5,a5,1
 108:	fff5c703          	lbu	a4,-1(a1)
 10c:	fee78fa3          	sb	a4,-1(a5)
 110:	fb75                	bnez	a4,104 <strcpy+0xa>
    ;
  return os;
}
 112:	60a2                	ld	ra,8(sp)
 114:	6402                	ld	s0,0(sp)
 116:	0141                	addi	sp,sp,16
 118:	8082                	ret

000000000000011a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 11a:	1141                	addi	sp,sp,-16
 11c:	e406                	sd	ra,8(sp)
 11e:	e022                	sd	s0,0(sp)
 120:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 122:	00054783          	lbu	a5,0(a0)
 126:	cb91                	beqz	a5,13a <strcmp+0x20>
 128:	0005c703          	lbu	a4,0(a1)
 12c:	00f71763          	bne	a4,a5,13a <strcmp+0x20>
    p++, q++;
 130:	0505                	addi	a0,a0,1
 132:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 134:	00054783          	lbu	a5,0(a0)
 138:	fbe5                	bnez	a5,128 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 13a:	0005c503          	lbu	a0,0(a1)
}
 13e:	40a7853b          	subw	a0,a5,a0
 142:	60a2                	ld	ra,8(sp)
 144:	6402                	ld	s0,0(sp)
 146:	0141                	addi	sp,sp,16
 148:	8082                	ret

000000000000014a <strlen>:

uint
strlen(const char *s)
{
 14a:	1141                	addi	sp,sp,-16
 14c:	e406                	sd	ra,8(sp)
 14e:	e022                	sd	s0,0(sp)
 150:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 152:	00054783          	lbu	a5,0(a0)
 156:	cf91                	beqz	a5,172 <strlen+0x28>
 158:	00150793          	addi	a5,a0,1
 15c:	86be                	mv	a3,a5
 15e:	0785                	addi	a5,a5,1
 160:	fff7c703          	lbu	a4,-1(a5)
 164:	ff65                	bnez	a4,15c <strlen+0x12>
 166:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 16a:	60a2                	ld	ra,8(sp)
 16c:	6402                	ld	s0,0(sp)
 16e:	0141                	addi	sp,sp,16
 170:	8082                	ret
  for(n = 0; s[n]; n++)
 172:	4501                	li	a0,0
 174:	bfdd                	j	16a <strlen+0x20>

0000000000000176 <memset>:

void*
memset(void *dst, int c, uint n)
{
 176:	1141                	addi	sp,sp,-16
 178:	e406                	sd	ra,8(sp)
 17a:	e022                	sd	s0,0(sp)
 17c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 17e:	ca19                	beqz	a2,194 <memset+0x1e>
 180:	87aa                	mv	a5,a0
 182:	1602                	slli	a2,a2,0x20
 184:	9201                	srli	a2,a2,0x20
 186:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 18a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 18e:	0785                	addi	a5,a5,1
 190:	fee79de3          	bne	a5,a4,18a <memset+0x14>
  }
  return dst;
}
 194:	60a2                	ld	ra,8(sp)
 196:	6402                	ld	s0,0(sp)
 198:	0141                	addi	sp,sp,16
 19a:	8082                	ret

000000000000019c <strchr>:

char*
strchr(const char *s, char c)
{
 19c:	1141                	addi	sp,sp,-16
 19e:	e406                	sd	ra,8(sp)
 1a0:	e022                	sd	s0,0(sp)
 1a2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1a4:	00054783          	lbu	a5,0(a0)
 1a8:	c799                	beqz	a5,1b6 <strchr+0x1a>
    if(*s == c)
 1aa:	00f58763          	beq	a1,a5,1b8 <strchr+0x1c>
  for(; *s; s++)
 1ae:	0505                	addi	a0,a0,1
 1b0:	00054783          	lbu	a5,0(a0)
 1b4:	fbfd                	bnez	a5,1aa <strchr+0xe>
      return (char*)s;
  return 0;
 1b6:	4501                	li	a0,0
}
 1b8:	60a2                	ld	ra,8(sp)
 1ba:	6402                	ld	s0,0(sp)
 1bc:	0141                	addi	sp,sp,16
 1be:	8082                	ret

00000000000001c0 <gets>:

char*
gets(char *buf, int max)
{
 1c0:	711d                	addi	sp,sp,-96
 1c2:	ec86                	sd	ra,88(sp)
 1c4:	e8a2                	sd	s0,80(sp)
 1c6:	e4a6                	sd	s1,72(sp)
 1c8:	e0ca                	sd	s2,64(sp)
 1ca:	fc4e                	sd	s3,56(sp)
 1cc:	f852                	sd	s4,48(sp)
 1ce:	f456                	sd	s5,40(sp)
 1d0:	f05a                	sd	s6,32(sp)
 1d2:	ec5e                	sd	s7,24(sp)
 1d4:	e862                	sd	s8,16(sp)
 1d6:	1080                	addi	s0,sp,96
 1d8:	8baa                	mv	s7,a0
 1da:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1dc:	892a                	mv	s2,a0
 1de:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1e0:	faf40b13          	addi	s6,s0,-81
 1e4:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 1e6:	8c26                	mv	s8,s1
 1e8:	0014899b          	addiw	s3,s1,1
 1ec:	84ce                	mv	s1,s3
 1ee:	0349d863          	bge	s3,s4,21e <gets+0x5e>
    cc = read(0, &c, 1);
 1f2:	8656                	mv	a2,s5
 1f4:	85da                	mv	a1,s6
 1f6:	4501                	li	a0,0
 1f8:	1c0000ef          	jal	3b8 <read>
    if(cc < 1)
 1fc:	02a05163          	blez	a0,21e <gets+0x5e>
      break;
    buf[i++] = c;
 200:	faf44783          	lbu	a5,-81(s0)
 204:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 208:	0905                	addi	s2,s2,1
 20a:	ff678713          	addi	a4,a5,-10
 20e:	00173713          	seqz	a4,a4
 212:	17cd                	addi	a5,a5,-13
 214:	0017b793          	seqz	a5,a5
 218:	8fd9                	or	a5,a5,a4
 21a:	d7f1                	beqz	a5,1e6 <gets+0x26>
    buf[i++] = c;
 21c:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 21e:	9c5e                	add	s8,s8,s7
 220:	000c0023          	sb	zero,0(s8)
  return buf;
}
 224:	855e                	mv	a0,s7
 226:	60e6                	ld	ra,88(sp)
 228:	6446                	ld	s0,80(sp)
 22a:	64a6                	ld	s1,72(sp)
 22c:	6906                	ld	s2,64(sp)
 22e:	79e2                	ld	s3,56(sp)
 230:	7a42                	ld	s4,48(sp)
 232:	7aa2                	ld	s5,40(sp)
 234:	7b02                	ld	s6,32(sp)
 236:	6be2                	ld	s7,24(sp)
 238:	6c42                	ld	s8,16(sp)
 23a:	6125                	addi	sp,sp,96
 23c:	8082                	ret

000000000000023e <stat>:

int
stat(const char *n, struct stat *st)
{
 23e:	1101                	addi	sp,sp,-32
 240:	ec06                	sd	ra,24(sp)
 242:	e822                	sd	s0,16(sp)
 244:	e04a                	sd	s2,0(sp)
 246:	1000                	addi	s0,sp,32
 248:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 24a:	4581                	li	a1,0
 24c:	194000ef          	jal	3e0 <open>
  if(fd < 0)
 250:	02054263          	bltz	a0,274 <stat+0x36>
 254:	e426                	sd	s1,8(sp)
 256:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 258:	85ca                	mv	a1,s2
 25a:	19e000ef          	jal	3f8 <fstat>
 25e:	892a                	mv	s2,a0
  close(fd);
 260:	8526                	mv	a0,s1
 262:	166000ef          	jal	3c8 <close>
  return r;
 266:	64a2                	ld	s1,8(sp)
}
 268:	854a                	mv	a0,s2
 26a:	60e2                	ld	ra,24(sp)
 26c:	6442                	ld	s0,16(sp)
 26e:	6902                	ld	s2,0(sp)
 270:	6105                	addi	sp,sp,32
 272:	8082                	ret
    return -1;
 274:	57fd                	li	a5,-1
 276:	893e                	mv	s2,a5
 278:	bfc5                	j	268 <stat+0x2a>

000000000000027a <atoi>:

int
atoi(const char *s)
{
 27a:	1141                	addi	sp,sp,-16
 27c:	e406                	sd	ra,8(sp)
 27e:	e022                	sd	s0,0(sp)
 280:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 282:	00054683          	lbu	a3,0(a0)
 286:	fd06879b          	addiw	a5,a3,-48
 28a:	0ff7f793          	zext.b	a5,a5
 28e:	4625                	li	a2,9
 290:	02f66963          	bltu	a2,a5,2c2 <atoi+0x48>
 294:	872a                	mv	a4,a0
  n = 0;
 296:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 298:	0705                	addi	a4,a4,1
 29a:	0025179b          	slliw	a5,a0,0x2
 29e:	9fa9                	addw	a5,a5,a0
 2a0:	0017979b          	slliw	a5,a5,0x1
 2a4:	9fb5                	addw	a5,a5,a3
 2a6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2aa:	00074683          	lbu	a3,0(a4)
 2ae:	fd06879b          	addiw	a5,a3,-48
 2b2:	0ff7f793          	zext.b	a5,a5
 2b6:	fef671e3          	bgeu	a2,a5,298 <atoi+0x1e>
  return n;
}
 2ba:	60a2                	ld	ra,8(sp)
 2bc:	6402                	ld	s0,0(sp)
 2be:	0141                	addi	sp,sp,16
 2c0:	8082                	ret
  n = 0;
 2c2:	4501                	li	a0,0
 2c4:	bfdd                	j	2ba <atoi+0x40>

00000000000002c6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e406                	sd	ra,8(sp)
 2ca:	e022                	sd	s0,0(sp)
 2cc:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2ce:	02b57563          	bgeu	a0,a1,2f8 <memmove+0x32>
    while(n-- > 0)
 2d2:	00c05f63          	blez	a2,2f0 <memmove+0x2a>
 2d6:	1602                	slli	a2,a2,0x20
 2d8:	9201                	srli	a2,a2,0x20
 2da:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2de:	872a                	mv	a4,a0
      *dst++ = *src++;
 2e0:	0585                	addi	a1,a1,1
 2e2:	0705                	addi	a4,a4,1
 2e4:	fff5c683          	lbu	a3,-1(a1)
 2e8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2ec:	fee79ae3          	bne	a5,a4,2e0 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2f0:	60a2                	ld	ra,8(sp)
 2f2:	6402                	ld	s0,0(sp)
 2f4:	0141                	addi	sp,sp,16
 2f6:	8082                	ret
    while(n-- > 0)
 2f8:	fec05ce3          	blez	a2,2f0 <memmove+0x2a>
    dst += n;
 2fc:	00c50733          	add	a4,a0,a2
    src += n;
 300:	95b2                	add	a1,a1,a2
 302:	fff6079b          	addiw	a5,a2,-1
 306:	1782                	slli	a5,a5,0x20
 308:	9381                	srli	a5,a5,0x20
 30a:	fff7c793          	not	a5,a5
 30e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 310:	15fd                	addi	a1,a1,-1
 312:	177d                	addi	a4,a4,-1
 314:	0005c683          	lbu	a3,0(a1)
 318:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 31c:	fef71ae3          	bne	a4,a5,310 <memmove+0x4a>
 320:	bfc1                	j	2f0 <memmove+0x2a>

0000000000000322 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 322:	1141                	addi	sp,sp,-16
 324:	e406                	sd	ra,8(sp)
 326:	e022                	sd	s0,0(sp)
 328:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 32a:	ce19                	beqz	a2,348 <memcmp+0x26>
 32c:	1602                	slli	a2,a2,0x20
 32e:	9201                	srli	a2,a2,0x20
 330:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 334:	00054783          	lbu	a5,0(a0)
 338:	0005c703          	lbu	a4,0(a1)
 33c:	00e79b63          	bne	a5,a4,352 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 340:	0505                	addi	a0,a0,1
    p2++;
 342:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 344:	fed518e3          	bne	a0,a3,334 <memcmp+0x12>
  }
  return 0;
 348:	4501                	li	a0,0
}
 34a:	60a2                	ld	ra,8(sp)
 34c:	6402                	ld	s0,0(sp)
 34e:	0141                	addi	sp,sp,16
 350:	8082                	ret
      return *p1 - *p2;
 352:	40e7853b          	subw	a0,a5,a4
 356:	bfd5                	j	34a <memcmp+0x28>

0000000000000358 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 358:	1141                	addi	sp,sp,-16
 35a:	e406                	sd	ra,8(sp)
 35c:	e022                	sd	s0,0(sp)
 35e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 360:	f67ff0ef          	jal	2c6 <memmove>
}
 364:	60a2                	ld	ra,8(sp)
 366:	6402                	ld	s0,0(sp)
 368:	0141                	addi	sp,sp,16
 36a:	8082                	ret

000000000000036c <sbrk>:

char *
sbrk(int n) {
 36c:	1141                	addi	sp,sp,-16
 36e:	e406                	sd	ra,8(sp)
 370:	e022                	sd	s0,0(sp)
 372:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 374:	4585                	li	a1,1
 376:	0b2000ef          	jal	428 <sys_sbrk>
}
 37a:	60a2                	ld	ra,8(sp)
 37c:	6402                	ld	s0,0(sp)
 37e:	0141                	addi	sp,sp,16
 380:	8082                	ret

0000000000000382 <sbrklazy>:

char *
sbrklazy(int n) {
 382:	1141                	addi	sp,sp,-16
 384:	e406                	sd	ra,8(sp)
 386:	e022                	sd	s0,0(sp)
 388:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 38a:	4589                	li	a1,2
 38c:	09c000ef          	jal	428 <sys_sbrk>
}
 390:	60a2                	ld	ra,8(sp)
 392:	6402                	ld	s0,0(sp)
 394:	0141                	addi	sp,sp,16
 396:	8082                	ret

0000000000000398 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 398:	4885                	li	a7,1
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3a0:	4889                	li	a7,2
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3a8:	488d                	li	a7,3
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3b0:	4891                	li	a7,4
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <read>:
.global read
read:
 li a7, SYS_read
 3b8:	4895                	li	a7,5
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <write>:
.global write
write:
 li a7, SYS_write
 3c0:	48c1                	li	a7,16
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <close>:
.global close
close:
 li a7, SYS_close
 3c8:	48d5                	li	a7,21
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3d0:	4899                	li	a7,6
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3d8:	489d                	li	a7,7
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <open>:
.global open
open:
 li a7, SYS_open
 3e0:	48bd                	li	a7,15
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3e8:	48c5                	li	a7,17
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3f0:	48c9                	li	a7,18
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3f8:	48a1                	li	a7,8
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <link>:
.global link
link:
 li a7, SYS_link
 400:	48cd                	li	a7,19
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 408:	48d1                	li	a7,20
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 410:	48a5                	li	a7,9
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <dup>:
.global dup
dup:
 li a7, SYS_dup
 418:	48a9                	li	a7,10
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 420:	48ad                	li	a7,11
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 428:	48b1                	li	a7,12
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <pause>:
.global pause
pause:
 li a7, SYS_pause
 430:	48b5                	li	a7,13
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 438:	48b9                	li	a7,14
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 440:	1101                	addi	sp,sp,-32
 442:	ec06                	sd	ra,24(sp)
 444:	e822                	sd	s0,16(sp)
 446:	1000                	addi	s0,sp,32
 448:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 44c:	4605                	li	a2,1
 44e:	fef40593          	addi	a1,s0,-17
 452:	f6fff0ef          	jal	3c0 <write>
}
 456:	60e2                	ld	ra,24(sp)
 458:	6442                	ld	s0,16(sp)
 45a:	6105                	addi	sp,sp,32
 45c:	8082                	ret

000000000000045e <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 45e:	715d                	addi	sp,sp,-80
 460:	e486                	sd	ra,72(sp)
 462:	e0a2                	sd	s0,64(sp)
 464:	f84a                	sd	s2,48(sp)
 466:	f44e                	sd	s3,40(sp)
 468:	0880                	addi	s0,sp,80
 46a:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 46c:	00d036b3          	snez	a3,a3
 470:	03f5d793          	srli	a5,a1,0x3f
 474:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 476:	0005871b          	sext.w	a4,a1
  neg = 0;
 47a:	4301                	li	t1,0
  if(sgn && xx < 0){
 47c:	c681                	beqz	a3,484 <printint+0x26>
    x = -xx;
 47e:	40b0073b          	negw	a4,a1
    neg = 1;
 482:	4305                	li	t1,1
  }

  i = 0;
 484:	fb840993          	addi	s3,s0,-72
  neg = 0;
 488:	85ce                	mv	a1,s3
  i = 0;
 48a:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 48c:	00000817          	auipc	a6,0x0
 490:	56c80813          	addi	a6,a6,1388 # 9f8 <digits>
 494:	88b6                	mv	a7,a3
 496:	0016851b          	addiw	a0,a3,1
 49a:	86aa                	mv	a3,a0
 49c:	02c777bb          	remuw	a5,a4,a2
 4a0:	1782                	slli	a5,a5,0x20
 4a2:	9381                	srli	a5,a5,0x20
 4a4:	97c2                	add	a5,a5,a6
 4a6:	0007c783          	lbu	a5,0(a5)
 4aa:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 4ae:	87ba                	mv	a5,a4
 4b0:	02c7573b          	divuw	a4,a4,a2
 4b4:	0585                	addi	a1,a1,1
 4b6:	fcc7ffe3          	bgeu	a5,a2,494 <printint+0x36>
  if(neg)
 4ba:	00030b63          	beqz	t1,4d0 <printint+0x72>
    buf[i++] = '-';
 4be:	fd040793          	addi	a5,s0,-48
 4c2:	953e                	add	a0,a0,a5
 4c4:	02d00793          	li	a5,45
 4c8:	fef50423          	sb	a5,-24(a0)
 4cc:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 4d0:	02d05563          	blez	a3,4fa <printint+0x9c>
 4d4:	fc26                	sd	s1,56(sp)
 4d6:	36fd                	addiw	a3,a3,-1
 4d8:	00d984b3          	add	s1,s3,a3
 4dc:	19fd                	addi	s3,s3,-1
 4de:	99b6                	add	s3,s3,a3
 4e0:	1682                	slli	a3,a3,0x20
 4e2:	9281                	srli	a3,a3,0x20
 4e4:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 4e8:	0004c583          	lbu	a1,0(s1)
 4ec:	854a                	mv	a0,s2
 4ee:	f53ff0ef          	jal	440 <putc>
  while(--i >= 0)
 4f2:	14fd                	addi	s1,s1,-1
 4f4:	ff349ae3          	bne	s1,s3,4e8 <printint+0x8a>
 4f8:	74e2                	ld	s1,56(sp)
}
 4fa:	60a6                	ld	ra,72(sp)
 4fc:	6406                	ld	s0,64(sp)
 4fe:	7942                	ld	s2,48(sp)
 500:	79a2                	ld	s3,40(sp)
 502:	6161                	addi	sp,sp,80
 504:	8082                	ret

0000000000000506 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 506:	711d                	addi	sp,sp,-96
 508:	ec86                	sd	ra,88(sp)
 50a:	e8a2                	sd	s0,80(sp)
 50c:	e4a6                	sd	s1,72(sp)
 50e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 510:	0005c483          	lbu	s1,0(a1)
 514:	2a048063          	beqz	s1,7b4 <vprintf+0x2ae>
 518:	e0ca                	sd	s2,64(sp)
 51a:	fc4e                	sd	s3,56(sp)
 51c:	f852                	sd	s4,48(sp)
 51e:	f456                	sd	s5,40(sp)
 520:	f05a                	sd	s6,32(sp)
 522:	ec5e                	sd	s7,24(sp)
 524:	e862                	sd	s8,16(sp)
 526:	8b2a                	mv	s6,a0
 528:	8a2e                	mv	s4,a1
 52a:	8bb2                	mv	s7,a2
  state = 0;
 52c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 52e:	4901                	li	s2,0
 530:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 532:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 536:	06400c13          	li	s8,100
 53a:	a00d                	j	55c <vprintf+0x56>
        putc(fd, c0);
 53c:	85a6                	mv	a1,s1
 53e:	855a                	mv	a0,s6
 540:	f01ff0ef          	jal	440 <putc>
 544:	a019                	j	54a <vprintf+0x44>
    } else if(state == '%'){
 546:	03598363          	beq	s3,s5,56c <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 54a:	0019079b          	addiw	a5,s2,1
 54e:	893e                	mv	s2,a5
 550:	873e                	mv	a4,a5
 552:	97d2                	add	a5,a5,s4
 554:	0007c483          	lbu	s1,0(a5)
 558:	24048763          	beqz	s1,7a6 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 55c:	0004879b          	sext.w	a5,s1
    if(state == 0){
 560:	fe0993e3          	bnez	s3,546 <vprintf+0x40>
      if(c0 == '%'){
 564:	fd579ce3          	bne	a5,s5,53c <vprintf+0x36>
        state = '%';
 568:	89be                	mv	s3,a5
 56a:	b7c5                	j	54a <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 56c:	00ea06b3          	add	a3,s4,a4
 570:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 574:	24060563          	beqz	a2,7be <vprintf+0x2b8>
      if(c0 == 'd'){
 578:	0b878763          	beq	a5,s8,626 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 57c:	f9478693          	addi	a3,a5,-108
 580:	0016b693          	seqz	a3,a3
 584:	f9c60593          	addi	a1,a2,-100
 588:	0015b593          	seqz	a1,a1
 58c:	8df5                	and	a1,a1,a3
 58e:	e9c5                	bnez	a1,63e <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 590:	9752                	add	a4,a4,s4
 592:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 596:	f9460713          	addi	a4,a2,-108
 59a:	00173713          	seqz	a4,a4
 59e:	8f75                	and	a4,a4,a3
 5a0:	f9c50593          	addi	a1,a0,-100
 5a4:	0015b593          	seqz	a1,a1
 5a8:	8df9                	and	a1,a1,a4
 5aa:	e5dd                	bnez	a1,658 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5ac:	07500593          	li	a1,117
 5b0:	0cb78163          	beq	a5,a1,672 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 5b4:	f8b60593          	addi	a1,a2,-117
 5b8:	0015b593          	seqz	a1,a1
 5bc:	8df5                	and	a1,a1,a3
 5be:	e5f1                	bnez	a1,68a <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 5c0:	f8b50593          	addi	a1,a0,-117
 5c4:	0015b593          	seqz	a1,a1
 5c8:	8df9                	and	a1,a1,a4
 5ca:	ede9                	bnez	a1,6a4 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5cc:	07800593          	li	a1,120
 5d0:	0eb78763          	beq	a5,a1,6be <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 5d4:	f8860613          	addi	a2,a2,-120
 5d8:	00163613          	seqz	a2,a2
 5dc:	8ef1                	and	a3,a3,a2
 5de:	0e069c63          	bnez	a3,6d6 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5e2:	f8850513          	addi	a0,a0,-120
 5e6:	00153513          	seqz	a0,a0
 5ea:	8f69                	and	a4,a4,a0
 5ec:	10071263          	bnez	a4,6f0 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5f0:	07000713          	li	a4,112
 5f4:	10e78a63          	beq	a5,a4,708 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5f8:	06300713          	li	a4,99
 5fc:	14e78a63          	beq	a5,a4,750 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 600:	07300713          	li	a4,115
 604:	16e78063          	beq	a5,a4,764 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 608:	02500713          	li	a4,37
 60c:	18e78863          	beq	a5,a4,79c <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 610:	02500593          	li	a1,37
 614:	855a                	mv	a0,s6
 616:	e2bff0ef          	jal	440 <putc>
        putc(fd, c0);
 61a:	85a6                	mv	a1,s1
 61c:	855a                	mv	a0,s6
 61e:	e23ff0ef          	jal	440 <putc>
      }

      state = 0;
 622:	4981                	li	s3,0
 624:	b71d                	j	54a <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 626:	008b8493          	addi	s1,s7,8
 62a:	4685                	li	a3,1
 62c:	4629                	li	a2,10
 62e:	000ba583          	lw	a1,0(s7)
 632:	855a                	mv	a0,s6
 634:	e2bff0ef          	jal	45e <printint>
 638:	8ba6                	mv	s7,s1
      state = 0;
 63a:	4981                	li	s3,0
 63c:	b739                	j	54a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 63e:	008b8493          	addi	s1,s7,8
 642:	4685                	li	a3,1
 644:	4629                	li	a2,10
 646:	000bb583          	ld	a1,0(s7)
 64a:	855a                	mv	a0,s6
 64c:	e13ff0ef          	jal	45e <printint>
        i += 1;
 650:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 652:	8ba6                	mv	s7,s1
      state = 0;
 654:	4981                	li	s3,0
 656:	bdd5                	j	54a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 658:	008b8493          	addi	s1,s7,8
 65c:	4685                	li	a3,1
 65e:	4629                	li	a2,10
 660:	000bb583          	ld	a1,0(s7)
 664:	855a                	mv	a0,s6
 666:	df9ff0ef          	jal	45e <printint>
        i += 2;
 66a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 66c:	8ba6                	mv	s7,s1
      state = 0;
 66e:	4981                	li	s3,0
        i += 2;
 670:	bde9                	j	54a <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 672:	008b8493          	addi	s1,s7,8
 676:	4681                	li	a3,0
 678:	4629                	li	a2,10
 67a:	000be583          	lwu	a1,0(s7)
 67e:	855a                	mv	a0,s6
 680:	ddfff0ef          	jal	45e <printint>
 684:	8ba6                	mv	s7,s1
      state = 0;
 686:	4981                	li	s3,0
 688:	b5c9                	j	54a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 68a:	008b8493          	addi	s1,s7,8
 68e:	4681                	li	a3,0
 690:	4629                	li	a2,10
 692:	000bb583          	ld	a1,0(s7)
 696:	855a                	mv	a0,s6
 698:	dc7ff0ef          	jal	45e <printint>
        i += 1;
 69c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 69e:	8ba6                	mv	s7,s1
      state = 0;
 6a0:	4981                	li	s3,0
 6a2:	b565                	j	54a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a4:	008b8493          	addi	s1,s7,8
 6a8:	4681                	li	a3,0
 6aa:	4629                	li	a2,10
 6ac:	000bb583          	ld	a1,0(s7)
 6b0:	855a                	mv	a0,s6
 6b2:	dadff0ef          	jal	45e <printint>
        i += 2;
 6b6:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b8:	8ba6                	mv	s7,s1
      state = 0;
 6ba:	4981                	li	s3,0
        i += 2;
 6bc:	b579                	j	54a <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6be:	008b8493          	addi	s1,s7,8
 6c2:	4681                	li	a3,0
 6c4:	4641                	li	a2,16
 6c6:	000be583          	lwu	a1,0(s7)
 6ca:	855a                	mv	a0,s6
 6cc:	d93ff0ef          	jal	45e <printint>
 6d0:	8ba6                	mv	s7,s1
      state = 0;
 6d2:	4981                	li	s3,0
 6d4:	bd9d                	j	54a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d6:	008b8493          	addi	s1,s7,8
 6da:	4681                	li	a3,0
 6dc:	4641                	li	a2,16
 6de:	000bb583          	ld	a1,0(s7)
 6e2:	855a                	mv	a0,s6
 6e4:	d7bff0ef          	jal	45e <printint>
        i += 1;
 6e8:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6ea:	8ba6                	mv	s7,s1
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	bdb1                	j	54a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6f0:	008b8493          	addi	s1,s7,8
 6f4:	4641                	li	a2,16
 6f6:	000bb583          	ld	a1,0(s7)
 6fa:	855a                	mv	a0,s6
 6fc:	d63ff0ef          	jal	45e <printint>
        i += 2;
 700:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 702:	8ba6                	mv	s7,s1
      state = 0;
 704:	4981                	li	s3,0
        i += 2;
 706:	b591                	j	54a <vprintf+0x44>
 708:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 70a:	008b8793          	addi	a5,s7,8
 70e:	8cbe                	mv	s9,a5
 710:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 714:	03000593          	li	a1,48
 718:	855a                	mv	a0,s6
 71a:	d27ff0ef          	jal	440 <putc>
  putc(fd, 'x');
 71e:	07800593          	li	a1,120
 722:	855a                	mv	a0,s6
 724:	d1dff0ef          	jal	440 <putc>
 728:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 72a:	00000b97          	auipc	s7,0x0
 72e:	2ceb8b93          	addi	s7,s7,718 # 9f8 <digits>
 732:	03c9d793          	srli	a5,s3,0x3c
 736:	97de                	add	a5,a5,s7
 738:	0007c583          	lbu	a1,0(a5)
 73c:	855a                	mv	a0,s6
 73e:	d03ff0ef          	jal	440 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 742:	0992                	slli	s3,s3,0x4
 744:	34fd                	addiw	s1,s1,-1
 746:	f4f5                	bnez	s1,732 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 748:	8be6                	mv	s7,s9
      state = 0;
 74a:	4981                	li	s3,0
 74c:	6ca2                	ld	s9,8(sp)
 74e:	bbf5                	j	54a <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 750:	008b8493          	addi	s1,s7,8
 754:	000bc583          	lbu	a1,0(s7)
 758:	855a                	mv	a0,s6
 75a:	ce7ff0ef          	jal	440 <putc>
 75e:	8ba6                	mv	s7,s1
      state = 0;
 760:	4981                	li	s3,0
 762:	b3e5                	j	54a <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 764:	008b8993          	addi	s3,s7,8
 768:	000bb483          	ld	s1,0(s7)
 76c:	cc91                	beqz	s1,788 <vprintf+0x282>
        for(; *s; s++)
 76e:	0004c583          	lbu	a1,0(s1)
 772:	c195                	beqz	a1,796 <vprintf+0x290>
          putc(fd, *s);
 774:	855a                	mv	a0,s6
 776:	ccbff0ef          	jal	440 <putc>
        for(; *s; s++)
 77a:	0485                	addi	s1,s1,1
 77c:	0004c583          	lbu	a1,0(s1)
 780:	f9f5                	bnez	a1,774 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 782:	8bce                	mv	s7,s3
      state = 0;
 784:	4981                	li	s3,0
 786:	b3d1                	j	54a <vprintf+0x44>
          s = "(null)";
 788:	00000497          	auipc	s1,0x0
 78c:	26848493          	addi	s1,s1,616 # 9f0 <malloc+0x136>
        for(; *s; s++)
 790:	02800593          	li	a1,40
 794:	b7c5                	j	774 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 796:	8bce                	mv	s7,s3
      state = 0;
 798:	4981                	li	s3,0
 79a:	bb45                	j	54a <vprintf+0x44>
        putc(fd, '%');
 79c:	85be                	mv	a1,a5
 79e:	855a                	mv	a0,s6
 7a0:	ca1ff0ef          	jal	440 <putc>
 7a4:	bdbd                	j	622 <vprintf+0x11c>
 7a6:	6906                	ld	s2,64(sp)
 7a8:	79e2                	ld	s3,56(sp)
 7aa:	7a42                	ld	s4,48(sp)
 7ac:	7aa2                	ld	s5,40(sp)
 7ae:	7b02                	ld	s6,32(sp)
 7b0:	6be2                	ld	s7,24(sp)
 7b2:	6c42                	ld	s8,16(sp)
    }
  }
}
 7b4:	60e6                	ld	ra,88(sp)
 7b6:	6446                	ld	s0,80(sp)
 7b8:	64a6                	ld	s1,72(sp)
 7ba:	6125                	addi	sp,sp,96
 7bc:	8082                	ret
      if(c0 == 'd'){
 7be:	06400713          	li	a4,100
 7c2:	e6e782e3          	beq	a5,a4,626 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 7c6:	f9478693          	addi	a3,a5,-108
 7ca:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 7ce:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7d0:	4701                	li	a4,0
 7d2:	bbe9                	j	5ac <vprintf+0xa6>

00000000000007d4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7d4:	715d                	addi	sp,sp,-80
 7d6:	ec06                	sd	ra,24(sp)
 7d8:	e822                	sd	s0,16(sp)
 7da:	1000                	addi	s0,sp,32
 7dc:	e010                	sd	a2,0(s0)
 7de:	e414                	sd	a3,8(s0)
 7e0:	e818                	sd	a4,16(s0)
 7e2:	ec1c                	sd	a5,24(s0)
 7e4:	03043023          	sd	a6,32(s0)
 7e8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7ec:	8622                	mv	a2,s0
 7ee:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7f2:	d15ff0ef          	jal	506 <vprintf>
}
 7f6:	60e2                	ld	ra,24(sp)
 7f8:	6442                	ld	s0,16(sp)
 7fa:	6161                	addi	sp,sp,80
 7fc:	8082                	ret

00000000000007fe <printf>:

void
printf(const char *fmt, ...)
{
 7fe:	711d                	addi	sp,sp,-96
 800:	ec06                	sd	ra,24(sp)
 802:	e822                	sd	s0,16(sp)
 804:	1000                	addi	s0,sp,32
 806:	e40c                	sd	a1,8(s0)
 808:	e810                	sd	a2,16(s0)
 80a:	ec14                	sd	a3,24(s0)
 80c:	f018                	sd	a4,32(s0)
 80e:	f41c                	sd	a5,40(s0)
 810:	03043823          	sd	a6,48(s0)
 814:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 818:	00840613          	addi	a2,s0,8
 81c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 820:	85aa                	mv	a1,a0
 822:	4505                	li	a0,1
 824:	ce3ff0ef          	jal	506 <vprintf>
}
 828:	60e2                	ld	ra,24(sp)
 82a:	6442                	ld	s0,16(sp)
 82c:	6125                	addi	sp,sp,96
 82e:	8082                	ret

0000000000000830 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 830:	1141                	addi	sp,sp,-16
 832:	e406                	sd	ra,8(sp)
 834:	e022                	sd	s0,0(sp)
 836:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 838:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83c:	00000797          	auipc	a5,0x0
 840:	7c47b783          	ld	a5,1988(a5) # 1000 <freep>
 844:	a095                	j	8a8 <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 846:	ff852583          	lw	a1,-8(a0)
 84a:	6390                	ld	a2,0(a5)
 84c:	02059813          	slli	a6,a1,0x20
 850:	01c85693          	srli	a3,a6,0x1c
 854:	96ba                	add	a3,a3,a4
 856:	02d60563          	beq	a2,a3,880 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 85a:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 85e:	4790                	lw	a2,8(a5)
 860:	02061593          	slli	a1,a2,0x20
 864:	01c5d693          	srli	a3,a1,0x1c
 868:	96be                	add	a3,a3,a5
 86a:	02d70263          	beq	a4,a3,88e <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 86e:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 870:	00000717          	auipc	a4,0x0
 874:	78f73823          	sd	a5,1936(a4) # 1000 <freep>
}
 878:	60a2                	ld	ra,8(sp)
 87a:	6402                	ld	s0,0(sp)
 87c:	0141                	addi	sp,sp,16
 87e:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 880:	4614                	lw	a3,8(a2)
 882:	9ead                	addw	a3,a3,a1
 884:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 888:	6394                	ld	a3,0(a5)
 88a:	6290                	ld	a2,0(a3)
 88c:	b7f9                	j	85a <free+0x2a>
    p->s.size += bp->s.size;
 88e:	ff852703          	lw	a4,-8(a0)
 892:	9f31                	addw	a4,a4,a2
 894:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 896:	ff053703          	ld	a4,-16(a0)
 89a:	bfd1                	j	86e <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 89c:	6394                	ld	a3,0(a5)
 89e:	00d7e463          	bltu	a5,a3,8a6 <free+0x76>
 8a2:	fad762e3          	bltu	a4,a3,846 <free+0x16>
 8a6:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a8:	fee7fae3          	bgeu	a5,a4,89c <free+0x6c>
 8ac:	6394                	ld	a3,0(a5)
 8ae:	f8d76ce3          	bltu	a4,a3,846 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b2:	f8d7fae3          	bgeu	a5,a3,846 <free+0x16>
 8b6:	87b6                	mv	a5,a3
 8b8:	bfc5                	j	8a8 <free+0x78>

00000000000008ba <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8ba:	7139                	addi	sp,sp,-64
 8bc:	fc06                	sd	ra,56(sp)
 8be:	f822                	sd	s0,48(sp)
 8c0:	f04a                	sd	s2,32(sp)
 8c2:	ec4e                	sd	s3,24(sp)
 8c4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8c6:	02051993          	slli	s3,a0,0x20
 8ca:	0209d993          	srli	s3,s3,0x20
 8ce:	09bd                	addi	s3,s3,15
 8d0:	0049d993          	srli	s3,s3,0x4
 8d4:	2985                	addiw	s3,s3,1
 8d6:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8d8:	00000517          	auipc	a0,0x0
 8dc:	72853503          	ld	a0,1832(a0) # 1000 <freep>
 8e0:	c905                	beqz	a0,910 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8e4:	4798                	lw	a4,8(a5)
 8e6:	09377663          	bgeu	a4,s3,972 <malloc+0xb8>
 8ea:	f426                	sd	s1,40(sp)
 8ec:	e852                	sd	s4,16(sp)
 8ee:	e456                	sd	s5,8(sp)
 8f0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8f2:	8a4e                	mv	s4,s3
 8f4:	6705                	lui	a4,0x1
 8f6:	00e9f363          	bgeu	s3,a4,8fc <malloc+0x42>
 8fa:	6a05                	lui	s4,0x1
 8fc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 900:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 904:	00000497          	auipc	s1,0x0
 908:	6fc48493          	addi	s1,s1,1788 # 1000 <freep>
  if(p == SBRK_ERROR)
 90c:	5afd                	li	s5,-1
 90e:	a83d                	j	94c <malloc+0x92>
 910:	f426                	sd	s1,40(sp)
 912:	e852                	sd	s4,16(sp)
 914:	e456                	sd	s5,8(sp)
 916:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 918:	00000797          	auipc	a5,0x0
 91c:	6f878793          	addi	a5,a5,1784 # 1010 <base>
 920:	00000717          	auipc	a4,0x0
 924:	6ef73023          	sd	a5,1760(a4) # 1000 <freep>
 928:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 92a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 92e:	b7d1                	j	8f2 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 930:	6398                	ld	a4,0(a5)
 932:	e118                	sd	a4,0(a0)
 934:	a899                	j	98a <malloc+0xd0>
  hp->s.size = nu;
 936:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 93a:	0541                	addi	a0,a0,16
 93c:	ef5ff0ef          	jal	830 <free>
  return freep;
 940:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 942:	c125                	beqz	a0,9a2 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 944:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 946:	4798                	lw	a4,8(a5)
 948:	03277163          	bgeu	a4,s2,96a <malloc+0xb0>
    if(p == freep)
 94c:	6098                	ld	a4,0(s1)
 94e:	853e                	mv	a0,a5
 950:	fef71ae3          	bne	a4,a5,944 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 954:	8552                	mv	a0,s4
 956:	a17ff0ef          	jal	36c <sbrk>
  if(p == SBRK_ERROR)
 95a:	fd551ee3          	bne	a0,s5,936 <malloc+0x7c>
        return 0;
 95e:	4501                	li	a0,0
 960:	74a2                	ld	s1,40(sp)
 962:	6a42                	ld	s4,16(sp)
 964:	6aa2                	ld	s5,8(sp)
 966:	6b02                	ld	s6,0(sp)
 968:	a03d                	j	996 <malloc+0xdc>
 96a:	74a2                	ld	s1,40(sp)
 96c:	6a42                	ld	s4,16(sp)
 96e:	6aa2                	ld	s5,8(sp)
 970:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 972:	fae90fe3          	beq	s2,a4,930 <malloc+0x76>
        p->s.size -= nunits;
 976:	4137073b          	subw	a4,a4,s3
 97a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 97c:	02071693          	slli	a3,a4,0x20
 980:	01c6d713          	srli	a4,a3,0x1c
 984:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 986:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 98a:	00000717          	auipc	a4,0x0
 98e:	66a73b23          	sd	a0,1654(a4) # 1000 <freep>
      return (void*)(p + 1);
 992:	01078513          	addi	a0,a5,16
  }
}
 996:	70e2                	ld	ra,56(sp)
 998:	7442                	ld	s0,48(sp)
 99a:	7902                	ld	s2,32(sp)
 99c:	69e2                	ld	s3,24(sp)
 99e:	6121                	addi	sp,sp,64
 9a0:	8082                	ret
 9a2:	74a2                	ld	s1,40(sp)
 9a4:	6a42                	ld	s4,16(sp)
 9a6:	6aa2                	ld	s5,8(sp)
 9a8:	6b02                	ld	s6,0(sp)
 9aa:	b7f5                	j	996 <malloc+0xdc>
