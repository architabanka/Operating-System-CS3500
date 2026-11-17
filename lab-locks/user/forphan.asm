
user/_forphan:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char buf[BUFSZ];

int
main(int argc, char **argv)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
  int fd = 0;
  char *s = argv[0];
   a:	6184                	ld	s1,0(a1)
  struct stat st;
  char *ff = "file0";
  
  if ((fd = open(ff, O_CREATE|O_WRONLY)) < 0) {
   c:	20100593          	li	a1,513
  10:	00001517          	auipc	a0,0x1
  14:	a3050513          	addi	a0,a0,-1488 # a40 <statistics+0x76>
  18:	3a4000ef          	jal	3bc <open>
  1c:	04054463          	bltz	a0,64 <main+0x64>
    printf("%s: open failed\n", s);
    exit(1);
  }
  if(fstat(fd, &st) < 0){
  20:	fc840593          	addi	a1,s0,-56
  24:	3b0000ef          	jal	3d4 <fstat>
  28:	04054863          	bltz	a0,78 <main+0x78>
    fprintf(2, "%s: cannot stat %s\n", s, "ff");
    exit(1);
  }
  if (unlink(ff) < 0) {
  2c:	00001517          	auipc	a0,0x1
  30:	a1450513          	addi	a0,a0,-1516 # a40 <statistics+0x76>
  34:	398000ef          	jal	3cc <unlink>
  38:	04054f63          	bltz	a0,96 <main+0x96>
    printf("%s: unlink failed\n", s);
    exit(1);
  }
  if (open(ff, O_RDONLY) != -1) {
  3c:	4581                	li	a1,0
  3e:	00001517          	auipc	a0,0x1
  42:	a0250513          	addi	a0,a0,-1534 # a40 <statistics+0x76>
  46:	376000ef          	jal	3bc <open>
  4a:	57fd                	li	a5,-1
  4c:	04f50f63          	beq	a0,a5,aa <main+0xaa>
    printf("%s: open successed\n", s);
  50:	85a6                	mv	a1,s1
  52:	00001517          	auipc	a0,0x1
  56:	a4e50513          	addi	a0,a0,-1458 # aa0 <statistics+0xd6>
  5a:	7c2000ef          	jal	81c <printf>
    exit(1);
  5e:	4505                	li	a0,1
  60:	31c000ef          	jal	37c <exit>
    printf("%s: open failed\n", s);
  64:	85a6                	mv	a1,s1
  66:	00001517          	auipc	a0,0x1
  6a:	9ea50513          	addi	a0,a0,-1558 # a50 <statistics+0x86>
  6e:	7ae000ef          	jal	81c <printf>
    exit(1);
  72:	4505                	li	a0,1
  74:	308000ef          	jal	37c <exit>
    fprintf(2, "%s: cannot stat %s\n", s, "ff");
  78:	00001697          	auipc	a3,0x1
  7c:	9f068693          	addi	a3,a3,-1552 # a68 <statistics+0x9e>
  80:	8626                	mv	a2,s1
  82:	00001597          	auipc	a1,0x1
  86:	9ee58593          	addi	a1,a1,-1554 # a70 <statistics+0xa6>
  8a:	4509                	li	a0,2
  8c:	766000ef          	jal	7f2 <fprintf>
    exit(1);
  90:	4505                	li	a0,1
  92:	2ea000ef          	jal	37c <exit>
    printf("%s: unlink failed\n", s);
  96:	85a6                	mv	a1,s1
  98:	00001517          	auipc	a0,0x1
  9c:	9f050513          	addi	a0,a0,-1552 # a88 <statistics+0xbe>
  a0:	77c000ef          	jal	81c <printf>
    exit(1);
  a4:	4505                	li	a0,1
  a6:	2d6000ef          	jal	37c <exit>
  }
  printf("wait for kill and reclaim %d\n", st.ino);
  aa:	fcc42583          	lw	a1,-52(s0)
  ae:	00001517          	auipc	a0,0x1
  b2:	a0a50513          	addi	a0,a0,-1526 # ab8 <statistics+0xee>
  b6:	766000ef          	jal	81c <printf>
  // sit around until killed
  for(;;) pause(1000);
  ba:	3e800493          	li	s1,1000
  be:	8526                	mv	a0,s1
  c0:	34c000ef          	jal	40c <pause>
  c4:	bfed                	j	be <main+0xbe>

00000000000000c6 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  c6:	1141                	addi	sp,sp,-16
  c8:	e406                	sd	ra,8(sp)
  ca:	e022                	sd	s0,0(sp)
  cc:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  ce:	f33ff0ef          	jal	0 <main>
  exit(r);
  d2:	2aa000ef          	jal	37c <exit>

00000000000000d6 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  d6:	1141                	addi	sp,sp,-16
  d8:	e406                	sd	ra,8(sp)
  da:	e022                	sd	s0,0(sp)
  dc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  de:	87aa                	mv	a5,a0
  e0:	0585                	addi	a1,a1,1
  e2:	0785                	addi	a5,a5,1
  e4:	fff5c703          	lbu	a4,-1(a1)
  e8:	fee78fa3          	sb	a4,-1(a5)
  ec:	fb75                	bnez	a4,e0 <strcpy+0xa>
    ;
  return os;
}
  ee:	60a2                	ld	ra,8(sp)
  f0:	6402                	ld	s0,0(sp)
  f2:	0141                	addi	sp,sp,16
  f4:	8082                	ret

00000000000000f6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f6:	1141                	addi	sp,sp,-16
  f8:	e406                	sd	ra,8(sp)
  fa:	e022                	sd	s0,0(sp)
  fc:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  fe:	00054783          	lbu	a5,0(a0)
 102:	cb91                	beqz	a5,116 <strcmp+0x20>
 104:	0005c703          	lbu	a4,0(a1)
 108:	00f71763          	bne	a4,a5,116 <strcmp+0x20>
    p++, q++;
 10c:	0505                	addi	a0,a0,1
 10e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 110:	00054783          	lbu	a5,0(a0)
 114:	fbe5                	bnez	a5,104 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 116:	0005c503          	lbu	a0,0(a1)
}
 11a:	40a7853b          	subw	a0,a5,a0
 11e:	60a2                	ld	ra,8(sp)
 120:	6402                	ld	s0,0(sp)
 122:	0141                	addi	sp,sp,16
 124:	8082                	ret

0000000000000126 <strlen>:

uint
strlen(const char *s)
{
 126:	1141                	addi	sp,sp,-16
 128:	e406                	sd	ra,8(sp)
 12a:	e022                	sd	s0,0(sp)
 12c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 12e:	00054783          	lbu	a5,0(a0)
 132:	cf91                	beqz	a5,14e <strlen+0x28>
 134:	00150793          	addi	a5,a0,1
 138:	86be                	mv	a3,a5
 13a:	0785                	addi	a5,a5,1
 13c:	fff7c703          	lbu	a4,-1(a5)
 140:	ff65                	bnez	a4,138 <strlen+0x12>
 142:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 146:	60a2                	ld	ra,8(sp)
 148:	6402                	ld	s0,0(sp)
 14a:	0141                	addi	sp,sp,16
 14c:	8082                	ret
  for(n = 0; s[n]; n++)
 14e:	4501                	li	a0,0
 150:	bfdd                	j	146 <strlen+0x20>

0000000000000152 <memset>:

void*
memset(void *dst, int c, uint n)
{
 152:	1141                	addi	sp,sp,-16
 154:	e406                	sd	ra,8(sp)
 156:	e022                	sd	s0,0(sp)
 158:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 15a:	ca19                	beqz	a2,170 <memset+0x1e>
 15c:	87aa                	mv	a5,a0
 15e:	1602                	slli	a2,a2,0x20
 160:	9201                	srli	a2,a2,0x20
 162:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 166:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 16a:	0785                	addi	a5,a5,1
 16c:	fee79de3          	bne	a5,a4,166 <memset+0x14>
  }
  return dst;
}
 170:	60a2                	ld	ra,8(sp)
 172:	6402                	ld	s0,0(sp)
 174:	0141                	addi	sp,sp,16
 176:	8082                	ret

0000000000000178 <strchr>:

char*
strchr(const char *s, char c)
{
 178:	1141                	addi	sp,sp,-16
 17a:	e406                	sd	ra,8(sp)
 17c:	e022                	sd	s0,0(sp)
 17e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 180:	00054783          	lbu	a5,0(a0)
 184:	c799                	beqz	a5,192 <strchr+0x1a>
    if(*s == c)
 186:	00f58763          	beq	a1,a5,194 <strchr+0x1c>
  for(; *s; s++)
 18a:	0505                	addi	a0,a0,1
 18c:	00054783          	lbu	a5,0(a0)
 190:	fbfd                	bnez	a5,186 <strchr+0xe>
      return (char*)s;
  return 0;
 192:	4501                	li	a0,0
}
 194:	60a2                	ld	ra,8(sp)
 196:	6402                	ld	s0,0(sp)
 198:	0141                	addi	sp,sp,16
 19a:	8082                	ret

000000000000019c <gets>:

char*
gets(char *buf, int max)
{
 19c:	711d                	addi	sp,sp,-96
 19e:	ec86                	sd	ra,88(sp)
 1a0:	e8a2                	sd	s0,80(sp)
 1a2:	e4a6                	sd	s1,72(sp)
 1a4:	e0ca                	sd	s2,64(sp)
 1a6:	fc4e                	sd	s3,56(sp)
 1a8:	f852                	sd	s4,48(sp)
 1aa:	f456                	sd	s5,40(sp)
 1ac:	f05a                	sd	s6,32(sp)
 1ae:	ec5e                	sd	s7,24(sp)
 1b0:	e862                	sd	s8,16(sp)
 1b2:	1080                	addi	s0,sp,96
 1b4:	8baa                	mv	s7,a0
 1b6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b8:	892a                	mv	s2,a0
 1ba:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1bc:	faf40b13          	addi	s6,s0,-81
 1c0:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 1c2:	8c26                	mv	s8,s1
 1c4:	0014899b          	addiw	s3,s1,1
 1c8:	84ce                	mv	s1,s3
 1ca:	0349d863          	bge	s3,s4,1fa <gets+0x5e>
    cc = read(0, &c, 1);
 1ce:	8656                	mv	a2,s5
 1d0:	85da                	mv	a1,s6
 1d2:	4501                	li	a0,0
 1d4:	1c0000ef          	jal	394 <read>
    if(cc < 1)
 1d8:	02a05163          	blez	a0,1fa <gets+0x5e>
      break;
    buf[i++] = c;
 1dc:	faf44783          	lbu	a5,-81(s0)
 1e0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1e4:	0905                	addi	s2,s2,1
 1e6:	ff678713          	addi	a4,a5,-10
 1ea:	00173713          	seqz	a4,a4
 1ee:	17cd                	addi	a5,a5,-13
 1f0:	0017b793          	seqz	a5,a5
 1f4:	8fd9                	or	a5,a5,a4
 1f6:	d7f1                	beqz	a5,1c2 <gets+0x26>
    buf[i++] = c;
 1f8:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 1fa:	9c5e                	add	s8,s8,s7
 1fc:	000c0023          	sb	zero,0(s8)
  return buf;
}
 200:	855e                	mv	a0,s7
 202:	60e6                	ld	ra,88(sp)
 204:	6446                	ld	s0,80(sp)
 206:	64a6                	ld	s1,72(sp)
 208:	6906                	ld	s2,64(sp)
 20a:	79e2                	ld	s3,56(sp)
 20c:	7a42                	ld	s4,48(sp)
 20e:	7aa2                	ld	s5,40(sp)
 210:	7b02                	ld	s6,32(sp)
 212:	6be2                	ld	s7,24(sp)
 214:	6c42                	ld	s8,16(sp)
 216:	6125                	addi	sp,sp,96
 218:	8082                	ret

000000000000021a <stat>:

int
stat(const char *n, struct stat *st)
{
 21a:	1101                	addi	sp,sp,-32
 21c:	ec06                	sd	ra,24(sp)
 21e:	e822                	sd	s0,16(sp)
 220:	e04a                	sd	s2,0(sp)
 222:	1000                	addi	s0,sp,32
 224:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 226:	4581                	li	a1,0
 228:	194000ef          	jal	3bc <open>
  if(fd < 0)
 22c:	02054263          	bltz	a0,250 <stat+0x36>
 230:	e426                	sd	s1,8(sp)
 232:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 234:	85ca                	mv	a1,s2
 236:	19e000ef          	jal	3d4 <fstat>
 23a:	892a                	mv	s2,a0
  close(fd);
 23c:	8526                	mv	a0,s1
 23e:	166000ef          	jal	3a4 <close>
  return r;
 242:	64a2                	ld	s1,8(sp)
}
 244:	854a                	mv	a0,s2
 246:	60e2                	ld	ra,24(sp)
 248:	6442                	ld	s0,16(sp)
 24a:	6902                	ld	s2,0(sp)
 24c:	6105                	addi	sp,sp,32
 24e:	8082                	ret
    return -1;
 250:	57fd                	li	a5,-1
 252:	893e                	mv	s2,a5
 254:	bfc5                	j	244 <stat+0x2a>

0000000000000256 <atoi>:

int
atoi(const char *s)
{
 256:	1141                	addi	sp,sp,-16
 258:	e406                	sd	ra,8(sp)
 25a:	e022                	sd	s0,0(sp)
 25c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 25e:	00054683          	lbu	a3,0(a0)
 262:	fd06879b          	addiw	a5,a3,-48
 266:	0ff7f793          	zext.b	a5,a5
 26a:	4625                	li	a2,9
 26c:	02f66963          	bltu	a2,a5,29e <atoi+0x48>
 270:	872a                	mv	a4,a0
  n = 0;
 272:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 274:	0705                	addi	a4,a4,1
 276:	0025179b          	slliw	a5,a0,0x2
 27a:	9fa9                	addw	a5,a5,a0
 27c:	0017979b          	slliw	a5,a5,0x1
 280:	9fb5                	addw	a5,a5,a3
 282:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 286:	00074683          	lbu	a3,0(a4)
 28a:	fd06879b          	addiw	a5,a3,-48
 28e:	0ff7f793          	zext.b	a5,a5
 292:	fef671e3          	bgeu	a2,a5,274 <atoi+0x1e>
  return n;
}
 296:	60a2                	ld	ra,8(sp)
 298:	6402                	ld	s0,0(sp)
 29a:	0141                	addi	sp,sp,16
 29c:	8082                	ret
  n = 0;
 29e:	4501                	li	a0,0
 2a0:	bfdd                	j	296 <atoi+0x40>

00000000000002a2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a2:	1141                	addi	sp,sp,-16
 2a4:	e406                	sd	ra,8(sp)
 2a6:	e022                	sd	s0,0(sp)
 2a8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2aa:	02b57563          	bgeu	a0,a1,2d4 <memmove+0x32>
    while(n-- > 0)
 2ae:	00c05f63          	blez	a2,2cc <memmove+0x2a>
 2b2:	1602                	slli	a2,a2,0x20
 2b4:	9201                	srli	a2,a2,0x20
 2b6:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2ba:	872a                	mv	a4,a0
      *dst++ = *src++;
 2bc:	0585                	addi	a1,a1,1
 2be:	0705                	addi	a4,a4,1
 2c0:	fff5c683          	lbu	a3,-1(a1)
 2c4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2c8:	fee79ae3          	bne	a5,a4,2bc <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2cc:	60a2                	ld	ra,8(sp)
 2ce:	6402                	ld	s0,0(sp)
 2d0:	0141                	addi	sp,sp,16
 2d2:	8082                	ret
    while(n-- > 0)
 2d4:	fec05ce3          	blez	a2,2cc <memmove+0x2a>
    dst += n;
 2d8:	00c50733          	add	a4,a0,a2
    src += n;
 2dc:	95b2                	add	a1,a1,a2
 2de:	fff6079b          	addiw	a5,a2,-1
 2e2:	1782                	slli	a5,a5,0x20
 2e4:	9381                	srli	a5,a5,0x20
 2e6:	fff7c793          	not	a5,a5
 2ea:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2ec:	15fd                	addi	a1,a1,-1
 2ee:	177d                	addi	a4,a4,-1
 2f0:	0005c683          	lbu	a3,0(a1)
 2f4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2f8:	fef71ae3          	bne	a4,a5,2ec <memmove+0x4a>
 2fc:	bfc1                	j	2cc <memmove+0x2a>

00000000000002fe <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2fe:	1141                	addi	sp,sp,-16
 300:	e406                	sd	ra,8(sp)
 302:	e022                	sd	s0,0(sp)
 304:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 306:	ce19                	beqz	a2,324 <memcmp+0x26>
 308:	1602                	slli	a2,a2,0x20
 30a:	9201                	srli	a2,a2,0x20
 30c:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 310:	00054783          	lbu	a5,0(a0)
 314:	0005c703          	lbu	a4,0(a1)
 318:	00e79b63          	bne	a5,a4,32e <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 31c:	0505                	addi	a0,a0,1
    p2++;
 31e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 320:	fed518e3          	bne	a0,a3,310 <memcmp+0x12>
  }
  return 0;
 324:	4501                	li	a0,0
}
 326:	60a2                	ld	ra,8(sp)
 328:	6402                	ld	s0,0(sp)
 32a:	0141                	addi	sp,sp,16
 32c:	8082                	ret
      return *p1 - *p2;
 32e:	40e7853b          	subw	a0,a5,a4
 332:	bfd5                	j	326 <memcmp+0x28>

0000000000000334 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 334:	1141                	addi	sp,sp,-16
 336:	e406                	sd	ra,8(sp)
 338:	e022                	sd	s0,0(sp)
 33a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 33c:	f67ff0ef          	jal	2a2 <memmove>
}
 340:	60a2                	ld	ra,8(sp)
 342:	6402                	ld	s0,0(sp)
 344:	0141                	addi	sp,sp,16
 346:	8082                	ret

0000000000000348 <sbrk>:

char *
sbrk(int n) {
 348:	1141                	addi	sp,sp,-16
 34a:	e406                	sd	ra,8(sp)
 34c:	e022                	sd	s0,0(sp)
 34e:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 350:	4585                	li	a1,1
 352:	0b2000ef          	jal	404 <sys_sbrk>
}
 356:	60a2                	ld	ra,8(sp)
 358:	6402                	ld	s0,0(sp)
 35a:	0141                	addi	sp,sp,16
 35c:	8082                	ret

000000000000035e <sbrklazy>:

char *
sbrklazy(int n) {
 35e:	1141                	addi	sp,sp,-16
 360:	e406                	sd	ra,8(sp)
 362:	e022                	sd	s0,0(sp)
 364:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 366:	4589                	li	a1,2
 368:	09c000ef          	jal	404 <sys_sbrk>
}
 36c:	60a2                	ld	ra,8(sp)
 36e:	6402                	ld	s0,0(sp)
 370:	0141                	addi	sp,sp,16
 372:	8082                	ret

0000000000000374 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 374:	4885                	li	a7,1
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <exit>:
.global exit
exit:
 li a7, SYS_exit
 37c:	4889                	li	a7,2
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <wait>:
.global wait
wait:
 li a7, SYS_wait
 384:	488d                	li	a7,3
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 38c:	4891                	li	a7,4
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <read>:
.global read
read:
 li a7, SYS_read
 394:	4895                	li	a7,5
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <write>:
.global write
write:
 li a7, SYS_write
 39c:	48c1                	li	a7,16
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <close>:
.global close
close:
 li a7, SYS_close
 3a4:	48d5                	li	a7,21
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <kill>:
.global kill
kill:
 li a7, SYS_kill
 3ac:	4899                	li	a7,6
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3b4:	489d                	li	a7,7
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <open>:
.global open
open:
 li a7, SYS_open
 3bc:	48bd                	li	a7,15
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3c4:	48c5                	li	a7,17
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3cc:	48c9                	li	a7,18
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3d4:	48a1                	li	a7,8
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <link>:
.global link
link:
 li a7, SYS_link
 3dc:	48cd                	li	a7,19
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3e4:	48d1                	li	a7,20
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3ec:	48a5                	li	a7,9
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3f4:	48a9                	li	a7,10
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3fc:	48ad                	li	a7,11
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 404:	48b1                	li	a7,12
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <pause>:
.global pause
pause:
 li a7, SYS_pause
 40c:	48b5                	li	a7,13
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 414:	48b9                	li	a7,14
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <bind>:
.global bind
bind:
 li a7, SYS_bind
 41c:	48f5                	li	a7,29
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 424:	48f9                	li	a7,30
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <send>:
.global send
send:
 li a7, SYS_send
 42c:	48fd                	li	a7,31
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <recv>:
.global recv
recv:
 li a7, SYS_recv
 434:	02000893          	li	a7,32
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 43e:	02100893          	li	a7,33
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 448:	02200893          	li	a7,34
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <rwlktest>:
.global rwlktest
rwlktest:
 li a7, SYS_rwlktest
 452:	02300893          	li	a7,35
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <cpupin>:
.global cpupin
cpupin:
 li a7, SYS_cpupin
 45c:	02400893          	li	a7,36
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 466:	1101                	addi	sp,sp,-32
 468:	ec06                	sd	ra,24(sp)
 46a:	e822                	sd	s0,16(sp)
 46c:	1000                	addi	s0,sp,32
 46e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 472:	4605                	li	a2,1
 474:	fef40593          	addi	a1,s0,-17
 478:	f25ff0ef          	jal	39c <write>
}
 47c:	60e2                	ld	ra,24(sp)
 47e:	6442                	ld	s0,16(sp)
 480:	6105                	addi	sp,sp,32
 482:	8082                	ret

0000000000000484 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 484:	715d                	addi	sp,sp,-80
 486:	e486                	sd	ra,72(sp)
 488:	e0a2                	sd	s0,64(sp)
 48a:	f84a                	sd	s2,48(sp)
 48c:	f44e                	sd	s3,40(sp)
 48e:	0880                	addi	s0,sp,80
 490:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 492:	00d036b3          	snez	a3,a3
 496:	03f5d793          	srli	a5,a1,0x3f
 49a:	8efd                	and	a3,a3,a5
  neg = 0;
 49c:	4301                	li	t1,0
  if(sgn && xx < 0){
 49e:	c681                	beqz	a3,4a6 <printint+0x22>
    neg = 1;
    x = -xx;
 4a0:	40b005b3          	neg	a1,a1
    neg = 1;
 4a4:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 4a6:	fb840993          	addi	s3,s0,-72
  neg = 0;
 4aa:	86ce                	mv	a3,s3
  i = 0;
 4ac:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4ae:	00000817          	auipc	a6,0x0
 4b2:	65a80813          	addi	a6,a6,1626 # b08 <digits>
 4b6:	88ba                	mv	a7,a4
 4b8:	0017051b          	addiw	a0,a4,1
 4bc:	872a                	mv	a4,a0
 4be:	02c5f7b3          	remu	a5,a1,a2
 4c2:	97c2                	add	a5,a5,a6
 4c4:	0007c783          	lbu	a5,0(a5)
 4c8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4cc:	87ae                	mv	a5,a1
 4ce:	02c5d5b3          	divu	a1,a1,a2
 4d2:	0685                	addi	a3,a3,1
 4d4:	fec7f1e3          	bgeu	a5,a2,4b6 <printint+0x32>
  if(neg)
 4d8:	00030b63          	beqz	t1,4ee <printint+0x6a>
    buf[i++] = '-';
 4dc:	fd040793          	addi	a5,s0,-48
 4e0:	953e                	add	a0,a0,a5
 4e2:	02d00793          	li	a5,45
 4e6:	fef50423          	sb	a5,-24(a0)
 4ea:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 4ee:	02e05563          	blez	a4,518 <printint+0x94>
 4f2:	fc26                	sd	s1,56(sp)
 4f4:	377d                	addiw	a4,a4,-1
 4f6:	00e984b3          	add	s1,s3,a4
 4fa:	19fd                	addi	s3,s3,-1
 4fc:	99ba                	add	s3,s3,a4
 4fe:	1702                	slli	a4,a4,0x20
 500:	9301                	srli	a4,a4,0x20
 502:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 506:	0004c583          	lbu	a1,0(s1)
 50a:	854a                	mv	a0,s2
 50c:	f5bff0ef          	jal	466 <putc>
  while(--i >= 0)
 510:	14fd                	addi	s1,s1,-1
 512:	ff349ae3          	bne	s1,s3,506 <printint+0x82>
 516:	74e2                	ld	s1,56(sp)
}
 518:	60a6                	ld	ra,72(sp)
 51a:	6406                	ld	s0,64(sp)
 51c:	7942                	ld	s2,48(sp)
 51e:	79a2                	ld	s3,40(sp)
 520:	6161                	addi	sp,sp,80
 522:	8082                	ret

0000000000000524 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 524:	711d                	addi	sp,sp,-96
 526:	ec86                	sd	ra,88(sp)
 528:	e8a2                	sd	s0,80(sp)
 52a:	e4a6                	sd	s1,72(sp)
 52c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 52e:	0005c483          	lbu	s1,0(a1)
 532:	2a048063          	beqz	s1,7d2 <vprintf+0x2ae>
 536:	e0ca                	sd	s2,64(sp)
 538:	fc4e                	sd	s3,56(sp)
 53a:	f852                	sd	s4,48(sp)
 53c:	f456                	sd	s5,40(sp)
 53e:	f05a                	sd	s6,32(sp)
 540:	ec5e                	sd	s7,24(sp)
 542:	e862                	sd	s8,16(sp)
 544:	8b2a                	mv	s6,a0
 546:	8a2e                	mv	s4,a1
 548:	8bb2                	mv	s7,a2
  state = 0;
 54a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 54c:	4901                	li	s2,0
 54e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 550:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 554:	06400c13          	li	s8,100
 558:	a00d                	j	57a <vprintf+0x56>
        putc(fd, c0);
 55a:	85a6                	mv	a1,s1
 55c:	855a                	mv	a0,s6
 55e:	f09ff0ef          	jal	466 <putc>
 562:	a019                	j	568 <vprintf+0x44>
    } else if(state == '%'){
 564:	03598363          	beq	s3,s5,58a <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 568:	0019079b          	addiw	a5,s2,1
 56c:	893e                	mv	s2,a5
 56e:	873e                	mv	a4,a5
 570:	97d2                	add	a5,a5,s4
 572:	0007c483          	lbu	s1,0(a5)
 576:	24048763          	beqz	s1,7c4 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 57a:	0004879b          	sext.w	a5,s1
    if(state == 0){
 57e:	fe0993e3          	bnez	s3,564 <vprintf+0x40>
      if(c0 == '%'){
 582:	fd579ce3          	bne	a5,s5,55a <vprintf+0x36>
        state = '%';
 586:	89be                	mv	s3,a5
 588:	b7c5                	j	568 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 58a:	00ea06b3          	add	a3,s4,a4
 58e:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 592:	24060563          	beqz	a2,7dc <vprintf+0x2b8>
      if(c0 == 'd'){
 596:	0b878763          	beq	a5,s8,644 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 59a:	f9478693          	addi	a3,a5,-108
 59e:	0016b693          	seqz	a3,a3
 5a2:	f9c60593          	addi	a1,a2,-100
 5a6:	0015b593          	seqz	a1,a1
 5aa:	8df5                	and	a1,a1,a3
 5ac:	e9c5                	bnez	a1,65c <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 5ae:	9752                	add	a4,a4,s4
 5b0:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5b4:	f9460713          	addi	a4,a2,-108
 5b8:	00173713          	seqz	a4,a4
 5bc:	8f75                	and	a4,a4,a3
 5be:	f9c50593          	addi	a1,a0,-100
 5c2:	0015b593          	seqz	a1,a1
 5c6:	8df9                	and	a1,a1,a4
 5c8:	e5dd                	bnez	a1,676 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5ca:	07500593          	li	a1,117
 5ce:	0cb78163          	beq	a5,a1,690 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 5d2:	f8b60593          	addi	a1,a2,-117
 5d6:	0015b593          	seqz	a1,a1
 5da:	8df5                	and	a1,a1,a3
 5dc:	e5f1                	bnez	a1,6a8 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 5de:	f8b50593          	addi	a1,a0,-117
 5e2:	0015b593          	seqz	a1,a1
 5e6:	8df9                	and	a1,a1,a4
 5e8:	ede9                	bnez	a1,6c2 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5ea:	07800593          	li	a1,120
 5ee:	0eb78763          	beq	a5,a1,6dc <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 5f2:	f8860613          	addi	a2,a2,-120
 5f6:	00163613          	seqz	a2,a2
 5fa:	8ef1                	and	a3,a3,a2
 5fc:	0e069c63          	bnez	a3,6f4 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 600:	f8850513          	addi	a0,a0,-120
 604:	00153513          	seqz	a0,a0
 608:	8f69                	and	a4,a4,a0
 60a:	10071263          	bnez	a4,70e <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 60e:	07000713          	li	a4,112
 612:	10e78a63          	beq	a5,a4,726 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 616:	06300713          	li	a4,99
 61a:	14e78a63          	beq	a5,a4,76e <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 61e:	07300713          	li	a4,115
 622:	16e78063          	beq	a5,a4,782 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 626:	02500713          	li	a4,37
 62a:	18e78863          	beq	a5,a4,7ba <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 62e:	02500593          	li	a1,37
 632:	855a                	mv	a0,s6
 634:	e33ff0ef          	jal	466 <putc>
        putc(fd, c0);
 638:	85a6                	mv	a1,s1
 63a:	855a                	mv	a0,s6
 63c:	e2bff0ef          	jal	466 <putc>
      }

      state = 0;
 640:	4981                	li	s3,0
 642:	b71d                	j	568 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 644:	008b8493          	addi	s1,s7,8
 648:	4685                	li	a3,1
 64a:	4629                	li	a2,10
 64c:	000ba583          	lw	a1,0(s7)
 650:	855a                	mv	a0,s6
 652:	e33ff0ef          	jal	484 <printint>
 656:	8ba6                	mv	s7,s1
      state = 0;
 658:	4981                	li	s3,0
 65a:	b739                	j	568 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 65c:	008b8493          	addi	s1,s7,8
 660:	4685                	li	a3,1
 662:	4629                	li	a2,10
 664:	000bb583          	ld	a1,0(s7)
 668:	855a                	mv	a0,s6
 66a:	e1bff0ef          	jal	484 <printint>
        i += 1;
 66e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 670:	8ba6                	mv	s7,s1
      state = 0;
 672:	4981                	li	s3,0
 674:	bdd5                	j	568 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 676:	008b8493          	addi	s1,s7,8
 67a:	4685                	li	a3,1
 67c:	4629                	li	a2,10
 67e:	000bb583          	ld	a1,0(s7)
 682:	855a                	mv	a0,s6
 684:	e01ff0ef          	jal	484 <printint>
        i += 2;
 688:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 68a:	8ba6                	mv	s7,s1
      state = 0;
 68c:	4981                	li	s3,0
        i += 2;
 68e:	bde9                	j	568 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 690:	008b8493          	addi	s1,s7,8
 694:	4681                	li	a3,0
 696:	4629                	li	a2,10
 698:	000be583          	lwu	a1,0(s7)
 69c:	855a                	mv	a0,s6
 69e:	de7ff0ef          	jal	484 <printint>
 6a2:	8ba6                	mv	s7,s1
      state = 0;
 6a4:	4981                	li	s3,0
 6a6:	b5c9                	j	568 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a8:	008b8493          	addi	s1,s7,8
 6ac:	4681                	li	a3,0
 6ae:	4629                	li	a2,10
 6b0:	000bb583          	ld	a1,0(s7)
 6b4:	855a                	mv	a0,s6
 6b6:	dcfff0ef          	jal	484 <printint>
        i += 1;
 6ba:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6bc:	8ba6                	mv	s7,s1
      state = 0;
 6be:	4981                	li	s3,0
 6c0:	b565                	j	568 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6c2:	008b8493          	addi	s1,s7,8
 6c6:	4681                	li	a3,0
 6c8:	4629                	li	a2,10
 6ca:	000bb583          	ld	a1,0(s7)
 6ce:	855a                	mv	a0,s6
 6d0:	db5ff0ef          	jal	484 <printint>
        i += 2;
 6d4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d6:	8ba6                	mv	s7,s1
      state = 0;
 6d8:	4981                	li	s3,0
        i += 2;
 6da:	b579                	j	568 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6dc:	008b8493          	addi	s1,s7,8
 6e0:	4681                	li	a3,0
 6e2:	4641                	li	a2,16
 6e4:	000be583          	lwu	a1,0(s7)
 6e8:	855a                	mv	a0,s6
 6ea:	d9bff0ef          	jal	484 <printint>
 6ee:	8ba6                	mv	s7,s1
      state = 0;
 6f0:	4981                	li	s3,0
 6f2:	bd9d                	j	568 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6f4:	008b8493          	addi	s1,s7,8
 6f8:	4681                	li	a3,0
 6fa:	4641                	li	a2,16
 6fc:	000bb583          	ld	a1,0(s7)
 700:	855a                	mv	a0,s6
 702:	d83ff0ef          	jal	484 <printint>
        i += 1;
 706:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 708:	8ba6                	mv	s7,s1
      state = 0;
 70a:	4981                	li	s3,0
 70c:	bdb1                	j	568 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 70e:	008b8493          	addi	s1,s7,8
 712:	4641                	li	a2,16
 714:	000bb583          	ld	a1,0(s7)
 718:	855a                	mv	a0,s6
 71a:	d6bff0ef          	jal	484 <printint>
        i += 2;
 71e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 720:	8ba6                	mv	s7,s1
      state = 0;
 722:	4981                	li	s3,0
        i += 2;
 724:	b591                	j	568 <vprintf+0x44>
 726:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 728:	008b8793          	addi	a5,s7,8
 72c:	8cbe                	mv	s9,a5
 72e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 732:	03000593          	li	a1,48
 736:	855a                	mv	a0,s6
 738:	d2fff0ef          	jal	466 <putc>
  putc(fd, 'x');
 73c:	07800593          	li	a1,120
 740:	855a                	mv	a0,s6
 742:	d25ff0ef          	jal	466 <putc>
 746:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 748:	00000b97          	auipc	s7,0x0
 74c:	3c0b8b93          	addi	s7,s7,960 # b08 <digits>
 750:	03c9d793          	srli	a5,s3,0x3c
 754:	97de                	add	a5,a5,s7
 756:	0007c583          	lbu	a1,0(a5)
 75a:	855a                	mv	a0,s6
 75c:	d0bff0ef          	jal	466 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 760:	0992                	slli	s3,s3,0x4
 762:	34fd                	addiw	s1,s1,-1
 764:	f4f5                	bnez	s1,750 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 766:	8be6                	mv	s7,s9
      state = 0;
 768:	4981                	li	s3,0
 76a:	6ca2                	ld	s9,8(sp)
 76c:	bbf5                	j	568 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 76e:	008b8493          	addi	s1,s7,8
 772:	000bc583          	lbu	a1,0(s7)
 776:	855a                	mv	a0,s6
 778:	cefff0ef          	jal	466 <putc>
 77c:	8ba6                	mv	s7,s1
      state = 0;
 77e:	4981                	li	s3,0
 780:	b3e5                	j	568 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 782:	008b8993          	addi	s3,s7,8
 786:	000bb483          	ld	s1,0(s7)
 78a:	cc91                	beqz	s1,7a6 <vprintf+0x282>
        for(; *s; s++)
 78c:	0004c583          	lbu	a1,0(s1)
 790:	c195                	beqz	a1,7b4 <vprintf+0x290>
          putc(fd, *s);
 792:	855a                	mv	a0,s6
 794:	cd3ff0ef          	jal	466 <putc>
        for(; *s; s++)
 798:	0485                	addi	s1,s1,1
 79a:	0004c583          	lbu	a1,0(s1)
 79e:	f9f5                	bnez	a1,792 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 7a0:	8bce                	mv	s7,s3
      state = 0;
 7a2:	4981                	li	s3,0
 7a4:	b3d1                	j	568 <vprintf+0x44>
          s = "(null)";
 7a6:	00000497          	auipc	s1,0x0
 7aa:	33248493          	addi	s1,s1,818 # ad8 <statistics+0x10e>
        for(; *s; s++)
 7ae:	02800593          	li	a1,40
 7b2:	b7c5                	j	792 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 7b4:	8bce                	mv	s7,s3
      state = 0;
 7b6:	4981                	li	s3,0
 7b8:	bb45                	j	568 <vprintf+0x44>
        putc(fd, '%');
 7ba:	85be                	mv	a1,a5
 7bc:	855a                	mv	a0,s6
 7be:	ca9ff0ef          	jal	466 <putc>
 7c2:	bdbd                	j	640 <vprintf+0x11c>
 7c4:	6906                	ld	s2,64(sp)
 7c6:	79e2                	ld	s3,56(sp)
 7c8:	7a42                	ld	s4,48(sp)
 7ca:	7aa2                	ld	s5,40(sp)
 7cc:	7b02                	ld	s6,32(sp)
 7ce:	6be2                	ld	s7,24(sp)
 7d0:	6c42                	ld	s8,16(sp)
    }
  }
}
 7d2:	60e6                	ld	ra,88(sp)
 7d4:	6446                	ld	s0,80(sp)
 7d6:	64a6                	ld	s1,72(sp)
 7d8:	6125                	addi	sp,sp,96
 7da:	8082                	ret
      if(c0 == 'd'){
 7dc:	06400713          	li	a4,100
 7e0:	e6e782e3          	beq	a5,a4,644 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 7e4:	f9478693          	addi	a3,a5,-108
 7e8:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 7ec:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7ee:	4701                	li	a4,0
 7f0:	bbe9                	j	5ca <vprintf+0xa6>

00000000000007f2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7f2:	715d                	addi	sp,sp,-80
 7f4:	ec06                	sd	ra,24(sp)
 7f6:	e822                	sd	s0,16(sp)
 7f8:	1000                	addi	s0,sp,32
 7fa:	e010                	sd	a2,0(s0)
 7fc:	e414                	sd	a3,8(s0)
 7fe:	e818                	sd	a4,16(s0)
 800:	ec1c                	sd	a5,24(s0)
 802:	03043023          	sd	a6,32(s0)
 806:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 80a:	8622                	mv	a2,s0
 80c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 810:	d15ff0ef          	jal	524 <vprintf>
}
 814:	60e2                	ld	ra,24(sp)
 816:	6442                	ld	s0,16(sp)
 818:	6161                	addi	sp,sp,80
 81a:	8082                	ret

000000000000081c <printf>:

void
printf(const char *fmt, ...)
{
 81c:	711d                	addi	sp,sp,-96
 81e:	ec06                	sd	ra,24(sp)
 820:	e822                	sd	s0,16(sp)
 822:	1000                	addi	s0,sp,32
 824:	e40c                	sd	a1,8(s0)
 826:	e810                	sd	a2,16(s0)
 828:	ec14                	sd	a3,24(s0)
 82a:	f018                	sd	a4,32(s0)
 82c:	f41c                	sd	a5,40(s0)
 82e:	03043823          	sd	a6,48(s0)
 832:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 836:	00840613          	addi	a2,s0,8
 83a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 83e:	85aa                	mv	a1,a0
 840:	4505                	li	a0,1
 842:	ce3ff0ef          	jal	524 <vprintf>
}
 846:	60e2                	ld	ra,24(sp)
 848:	6442                	ld	s0,16(sp)
 84a:	6125                	addi	sp,sp,96
 84c:	8082                	ret

000000000000084e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 84e:	1141                	addi	sp,sp,-16
 850:	e406                	sd	ra,8(sp)
 852:	e022                	sd	s0,0(sp)
 854:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 856:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 85a:	00000797          	auipc	a5,0x0
 85e:	7a67b783          	ld	a5,1958(a5) # 1000 <freep>
 862:	a095                	j	8c6 <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 864:	ff852583          	lw	a1,-8(a0)
 868:	6390                	ld	a2,0(a5)
 86a:	02059813          	slli	a6,a1,0x20
 86e:	01c85693          	srli	a3,a6,0x1c
 872:	96ba                	add	a3,a3,a4
 874:	02d60563          	beq	a2,a3,89e <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 878:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 87c:	4790                	lw	a2,8(a5)
 87e:	02061593          	slli	a1,a2,0x20
 882:	01c5d693          	srli	a3,a1,0x1c
 886:	96be                	add	a3,a3,a5
 888:	02d70263          	beq	a4,a3,8ac <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 88c:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 88e:	00000717          	auipc	a4,0x0
 892:	76f73923          	sd	a5,1906(a4) # 1000 <freep>
}
 896:	60a2                	ld	ra,8(sp)
 898:	6402                	ld	s0,0(sp)
 89a:	0141                	addi	sp,sp,16
 89c:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 89e:	4614                	lw	a3,8(a2)
 8a0:	9ead                	addw	a3,a3,a1
 8a2:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8a6:	6394                	ld	a3,0(a5)
 8a8:	6290                	ld	a2,0(a3)
 8aa:	b7f9                	j	878 <free+0x2a>
    p->s.size += bp->s.size;
 8ac:	ff852703          	lw	a4,-8(a0)
 8b0:	9f31                	addw	a4,a4,a2
 8b2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8b4:	ff053703          	ld	a4,-16(a0)
 8b8:	bfd1                	j	88c <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ba:	6394                	ld	a3,0(a5)
 8bc:	00d7e463          	bltu	a5,a3,8c4 <free+0x76>
 8c0:	fad762e3          	bltu	a4,a3,864 <free+0x16>
 8c4:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c6:	fee7fae3          	bgeu	a5,a4,8ba <free+0x6c>
 8ca:	6394                	ld	a3,0(a5)
 8cc:	f8d76ce3          	bltu	a4,a3,864 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d0:	f8d7fae3          	bgeu	a5,a3,864 <free+0x16>
 8d4:	87b6                	mv	a5,a3
 8d6:	bfc5                	j	8c6 <free+0x78>

00000000000008d8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8d8:	7139                	addi	sp,sp,-64
 8da:	fc06                	sd	ra,56(sp)
 8dc:	f822                	sd	s0,48(sp)
 8de:	f04a                	sd	s2,32(sp)
 8e0:	ec4e                	sd	s3,24(sp)
 8e2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8e4:	02051993          	slli	s3,a0,0x20
 8e8:	0209d993          	srli	s3,s3,0x20
 8ec:	09bd                	addi	s3,s3,15
 8ee:	0049d993          	srli	s3,s3,0x4
 8f2:	2985                	addiw	s3,s3,1
 8f4:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8f6:	00000517          	auipc	a0,0x0
 8fa:	70a53503          	ld	a0,1802(a0) # 1000 <freep>
 8fe:	c905                	beqz	a0,92e <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 900:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 902:	4798                	lw	a4,8(a5)
 904:	09377663          	bgeu	a4,s3,990 <malloc+0xb8>
 908:	f426                	sd	s1,40(sp)
 90a:	e852                	sd	s4,16(sp)
 90c:	e456                	sd	s5,8(sp)
 90e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 910:	8a4e                	mv	s4,s3
 912:	6705                	lui	a4,0x1
 914:	00e9f363          	bgeu	s3,a4,91a <malloc+0x42>
 918:	6a05                	lui	s4,0x1
 91a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 91e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 922:	00000497          	auipc	s1,0x0
 926:	6de48493          	addi	s1,s1,1758 # 1000 <freep>
  if(p == SBRK_ERROR)
 92a:	5afd                	li	s5,-1
 92c:	a83d                	j	96a <malloc+0x92>
 92e:	f426                	sd	s1,40(sp)
 930:	e852                	sd	s4,16(sp)
 932:	e456                	sd	s5,8(sp)
 934:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 936:	00001797          	auipc	a5,0x1
 93a:	8d278793          	addi	a5,a5,-1838 # 1208 <base>
 93e:	00000717          	auipc	a4,0x0
 942:	6cf73123          	sd	a5,1730(a4) # 1000 <freep>
 946:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 948:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 94c:	b7d1                	j	910 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 94e:	6398                	ld	a4,0(a5)
 950:	e118                	sd	a4,0(a0)
 952:	a899                	j	9a8 <malloc+0xd0>
  hp->s.size = nu;
 954:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 958:	0541                	addi	a0,a0,16
 95a:	ef5ff0ef          	jal	84e <free>
  return freep;
 95e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 960:	c125                	beqz	a0,9c0 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 962:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 964:	4798                	lw	a4,8(a5)
 966:	03277163          	bgeu	a4,s2,988 <malloc+0xb0>
    if(p == freep)
 96a:	6098                	ld	a4,0(s1)
 96c:	853e                	mv	a0,a5
 96e:	fef71ae3          	bne	a4,a5,962 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 972:	8552                	mv	a0,s4
 974:	9d5ff0ef          	jal	348 <sbrk>
  if(p == SBRK_ERROR)
 978:	fd551ee3          	bne	a0,s5,954 <malloc+0x7c>
        return 0;
 97c:	4501                	li	a0,0
 97e:	74a2                	ld	s1,40(sp)
 980:	6a42                	ld	s4,16(sp)
 982:	6aa2                	ld	s5,8(sp)
 984:	6b02                	ld	s6,0(sp)
 986:	a03d                	j	9b4 <malloc+0xdc>
 988:	74a2                	ld	s1,40(sp)
 98a:	6a42                	ld	s4,16(sp)
 98c:	6aa2                	ld	s5,8(sp)
 98e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 990:	fae90fe3          	beq	s2,a4,94e <malloc+0x76>
        p->s.size -= nunits;
 994:	4137073b          	subw	a4,a4,s3
 998:	c798                	sw	a4,8(a5)
        p += p->s.size;
 99a:	02071693          	slli	a3,a4,0x20
 99e:	01c6d713          	srli	a4,a3,0x1c
 9a2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9a4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9a8:	00000717          	auipc	a4,0x0
 9ac:	64a73c23          	sd	a0,1624(a4) # 1000 <freep>
      return (void*)(p + 1);
 9b0:	01078513          	addi	a0,a5,16
  }
}
 9b4:	70e2                	ld	ra,56(sp)
 9b6:	7442                	ld	s0,48(sp)
 9b8:	7902                	ld	s2,32(sp)
 9ba:	69e2                	ld	s3,24(sp)
 9bc:	6121                	addi	sp,sp,64
 9be:	8082                	ret
 9c0:	74a2                	ld	s1,40(sp)
 9c2:	6a42                	ld	s4,16(sp)
 9c4:	6aa2                	ld	s5,8(sp)
 9c6:	6b02                	ld	s6,0(sp)
 9c8:	b7f5                	j	9b4 <malloc+0xdc>

00000000000009ca <statistics>:
#include "kernel/fcntl.h"
#include "user/user.h"

int
statistics(void *buf, int sz)
{
 9ca:	7179                	addi	sp,sp,-48
 9cc:	f406                	sd	ra,40(sp)
 9ce:	f022                	sd	s0,32(sp)
 9d0:	ec26                	sd	s1,24(sp)
 9d2:	e84a                	sd	s2,16(sp)
 9d4:	e44e                	sd	s3,8(sp)
 9d6:	e052                	sd	s4,0(sp)
 9d8:	1800                	addi	s0,sp,48
 9da:	8a2a                	mv	s4,a0
 9dc:	892e                	mv	s2,a1
  int fd, i, n;
  
  fd = open("statistics", O_RDONLY);
 9de:	4581                	li	a1,0
 9e0:	00000517          	auipc	a0,0x0
 9e4:	10050513          	addi	a0,a0,256 # ae0 <statistics+0x116>
 9e8:	9d5ff0ef          	jal	3bc <open>
  if(fd < 0) {
 9ec:	02054e63          	bltz	a0,a28 <statistics+0x5e>
 9f0:	89aa                	mv	s3,a0
      fprintf(2, "stats: open failed\n");
      exit(1);
  }
  for (i = 0; i < sz; ) {
 9f2:	4481                	li	s1,0
 9f4:	01205e63          	blez	s2,a10 <statistics+0x46>
    if ((n = read(fd, buf+i, sz-i)) < 0) {
 9f8:	4099063b          	subw	a2,s2,s1
 9fc:	009a05b3          	add	a1,s4,s1
 a00:	854e                	mv	a0,s3
 a02:	993ff0ef          	jal	394 <read>
 a06:	00054563          	bltz	a0,a10 <statistics+0x46>
      break;
    }
    i += n;
 a0a:	9ca9                	addw	s1,s1,a0
  for (i = 0; i < sz; ) {
 a0c:	ff24c6e3          	blt	s1,s2,9f8 <statistics+0x2e>
  }
  close(fd);
 a10:	854e                	mv	a0,s3
 a12:	993ff0ef          	jal	3a4 <close>
  return i;
}
 a16:	8526                	mv	a0,s1
 a18:	70a2                	ld	ra,40(sp)
 a1a:	7402                	ld	s0,32(sp)
 a1c:	64e2                	ld	s1,24(sp)
 a1e:	6942                	ld	s2,16(sp)
 a20:	69a2                	ld	s3,8(sp)
 a22:	6a02                	ld	s4,0(sp)
 a24:	6145                	addi	sp,sp,48
 a26:	8082                	ret
      fprintf(2, "stats: open failed\n");
 a28:	00000597          	auipc	a1,0x0
 a2c:	0c858593          	addi	a1,a1,200 # af0 <statistics+0x126>
 a30:	4509                	li	a0,2
 a32:	dc1ff0ef          	jal	7f2 <fprintf>
      exit(1);
 a36:	4505                	li	a0,1
 a38:	945ff0ef          	jal	37c <exit>
