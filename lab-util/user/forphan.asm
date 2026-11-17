
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
  14:	98050513          	addi	a0,a0,-1664 # 990 <malloc+0xf8>
  18:	3a6000ef          	jal	3be <open>
  1c:	04054463          	bltz	a0,64 <main+0x64>
    printf("%s: open failed\n", s);
    exit(1);
  }
  if(fstat(fd, &st) < 0){
  20:	fc840593          	addi	a1,s0,-56
  24:	3b2000ef          	jal	3d6 <fstat>
  28:	04054863          	bltz	a0,78 <main+0x78>
    fprintf(2, "%s: cannot stat %s\n", s, "ff");
    exit(1);
  }
  if (unlink(ff) < 0) {
  2c:	00001517          	auipc	a0,0x1
  30:	96450513          	addi	a0,a0,-1692 # 990 <malloc+0xf8>
  34:	39a000ef          	jal	3ce <unlink>
  38:	04054f63          	bltz	a0,96 <main+0x96>
    printf("%s: unlink failed\n", s);
    exit(1);
  }
  if (open(ff, O_RDONLY) != -1) {
  3c:	4581                	li	a1,0
  3e:	00001517          	auipc	a0,0x1
  42:	95250513          	addi	a0,a0,-1710 # 990 <malloc+0xf8>
  46:	378000ef          	jal	3be <open>
  4a:	57fd                	li	a5,-1
  4c:	04f50f63          	beq	a0,a5,aa <main+0xaa>
    printf("%s: open successed\n", s);
  50:	85a6                	mv	a1,s1
  52:	00001517          	auipc	a0,0x1
  56:	99e50513          	addi	a0,a0,-1634 # 9f0 <malloc+0x158>
  5a:	782000ef          	jal	7dc <printf>
    exit(1);
  5e:	4505                	li	a0,1
  60:	31e000ef          	jal	37e <exit>
    printf("%s: open failed\n", s);
  64:	85a6                	mv	a1,s1
  66:	00001517          	auipc	a0,0x1
  6a:	93a50513          	addi	a0,a0,-1734 # 9a0 <malloc+0x108>
  6e:	76e000ef          	jal	7dc <printf>
    exit(1);
  72:	4505                	li	a0,1
  74:	30a000ef          	jal	37e <exit>
    fprintf(2, "%s: cannot stat %s\n", s, "ff");
  78:	00001697          	auipc	a3,0x1
  7c:	94068693          	addi	a3,a3,-1728 # 9b8 <malloc+0x120>
  80:	8626                	mv	a2,s1
  82:	00001597          	auipc	a1,0x1
  86:	93e58593          	addi	a1,a1,-1730 # 9c0 <malloc+0x128>
  8a:	4509                	li	a0,2
  8c:	726000ef          	jal	7b2 <fprintf>
    exit(1);
  90:	4505                	li	a0,1
  92:	2ec000ef          	jal	37e <exit>
    printf("%s: unlink failed\n", s);
  96:	85a6                	mv	a1,s1
  98:	00001517          	auipc	a0,0x1
  9c:	94050513          	addi	a0,a0,-1728 # 9d8 <malloc+0x140>
  a0:	73c000ef          	jal	7dc <printf>
    exit(1);
  a4:	4505                	li	a0,1
  a6:	2d8000ef          	jal	37e <exit>
  }
  printf("wait for kill and reclaim %d\n", st.ino);
  aa:	fcc42583          	lw	a1,-52(s0)
  ae:	00001517          	auipc	a0,0x1
  b2:	95a50513          	addi	a0,a0,-1702 # a08 <malloc+0x170>
  b6:	726000ef          	jal	7dc <printf>
  // sit around until killed
  for(;;) pause(1000);
  ba:	3e800493          	li	s1,1000
  be:	8526                	mv	a0,s1
  c0:	34e000ef          	jal	40e <pause>
  c4:	bfed                	j	be <main+0xbe>

00000000000000c6 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  c6:	1141                	addi	sp,sp,-16
  c8:	e406                	sd	ra,8(sp)
  ca:	e022                	sd	s0,0(sp)
  cc:	0800                	addi	s0,sp,16
  extern int main();
  main();
  ce:	f33ff0ef          	jal	0 <main>
  exit(0);
  d2:	4501                	li	a0,0
  d4:	2aa000ef          	jal	37e <exit>

00000000000000d8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  d8:	1141                	addi	sp,sp,-16
  da:	e406                	sd	ra,8(sp)
  dc:	e022                	sd	s0,0(sp)
  de:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  e0:	87aa                	mv	a5,a0
  e2:	0585                	addi	a1,a1,1
  e4:	0785                	addi	a5,a5,1
  e6:	fff5c703          	lbu	a4,-1(a1)
  ea:	fee78fa3          	sb	a4,-1(a5)
  ee:	fb75                	bnez	a4,e2 <strcpy+0xa>
    ;
  return os;
}
  f0:	60a2                	ld	ra,8(sp)
  f2:	6402                	ld	s0,0(sp)
  f4:	0141                	addi	sp,sp,16
  f6:	8082                	ret

00000000000000f8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e406                	sd	ra,8(sp)
  fc:	e022                	sd	s0,0(sp)
  fe:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 100:	00054783          	lbu	a5,0(a0)
 104:	cb91                	beqz	a5,118 <strcmp+0x20>
 106:	0005c703          	lbu	a4,0(a1)
 10a:	00f71763          	bne	a4,a5,118 <strcmp+0x20>
    p++, q++;
 10e:	0505                	addi	a0,a0,1
 110:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 112:	00054783          	lbu	a5,0(a0)
 116:	fbe5                	bnez	a5,106 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 118:	0005c503          	lbu	a0,0(a1)
}
 11c:	40a7853b          	subw	a0,a5,a0
 120:	60a2                	ld	ra,8(sp)
 122:	6402                	ld	s0,0(sp)
 124:	0141                	addi	sp,sp,16
 126:	8082                	ret

0000000000000128 <strlen>:

uint
strlen(const char *s)
{
 128:	1141                	addi	sp,sp,-16
 12a:	e406                	sd	ra,8(sp)
 12c:	e022                	sd	s0,0(sp)
 12e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 130:	00054783          	lbu	a5,0(a0)
 134:	cf91                	beqz	a5,150 <strlen+0x28>
 136:	00150793          	addi	a5,a0,1
 13a:	86be                	mv	a3,a5
 13c:	0785                	addi	a5,a5,1
 13e:	fff7c703          	lbu	a4,-1(a5)
 142:	ff65                	bnez	a4,13a <strlen+0x12>
 144:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 148:	60a2                	ld	ra,8(sp)
 14a:	6402                	ld	s0,0(sp)
 14c:	0141                	addi	sp,sp,16
 14e:	8082                	ret
  for(n = 0; s[n]; n++)
 150:	4501                	li	a0,0
 152:	bfdd                	j	148 <strlen+0x20>

0000000000000154 <memset>:

void*
memset(void *dst, int c, uint n)
{
 154:	1141                	addi	sp,sp,-16
 156:	e406                	sd	ra,8(sp)
 158:	e022                	sd	s0,0(sp)
 15a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 15c:	ca19                	beqz	a2,172 <memset+0x1e>
 15e:	87aa                	mv	a5,a0
 160:	1602                	slli	a2,a2,0x20
 162:	9201                	srli	a2,a2,0x20
 164:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 168:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 16c:	0785                	addi	a5,a5,1
 16e:	fee79de3          	bne	a5,a4,168 <memset+0x14>
  }
  return dst;
}
 172:	60a2                	ld	ra,8(sp)
 174:	6402                	ld	s0,0(sp)
 176:	0141                	addi	sp,sp,16
 178:	8082                	ret

000000000000017a <strchr>:

char*
strchr(const char *s, char c)
{
 17a:	1141                	addi	sp,sp,-16
 17c:	e406                	sd	ra,8(sp)
 17e:	e022                	sd	s0,0(sp)
 180:	0800                	addi	s0,sp,16
  for(; *s; s++)
 182:	00054783          	lbu	a5,0(a0)
 186:	c799                	beqz	a5,194 <strchr+0x1a>
    if(*s == c)
 188:	00f58763          	beq	a1,a5,196 <strchr+0x1c>
  for(; *s; s++)
 18c:	0505                	addi	a0,a0,1
 18e:	00054783          	lbu	a5,0(a0)
 192:	fbfd                	bnez	a5,188 <strchr+0xe>
      return (char*)s;
  return 0;
 194:	4501                	li	a0,0
}
 196:	60a2                	ld	ra,8(sp)
 198:	6402                	ld	s0,0(sp)
 19a:	0141                	addi	sp,sp,16
 19c:	8082                	ret

000000000000019e <gets>:

char*
gets(char *buf, int max)
{
 19e:	711d                	addi	sp,sp,-96
 1a0:	ec86                	sd	ra,88(sp)
 1a2:	e8a2                	sd	s0,80(sp)
 1a4:	e4a6                	sd	s1,72(sp)
 1a6:	e0ca                	sd	s2,64(sp)
 1a8:	fc4e                	sd	s3,56(sp)
 1aa:	f852                	sd	s4,48(sp)
 1ac:	f456                	sd	s5,40(sp)
 1ae:	f05a                	sd	s6,32(sp)
 1b0:	ec5e                	sd	s7,24(sp)
 1b2:	e862                	sd	s8,16(sp)
 1b4:	1080                	addi	s0,sp,96
 1b6:	8baa                	mv	s7,a0
 1b8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ba:	892a                	mv	s2,a0
 1bc:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1be:	faf40b13          	addi	s6,s0,-81
 1c2:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 1c4:	8c26                	mv	s8,s1
 1c6:	0014899b          	addiw	s3,s1,1
 1ca:	84ce                	mv	s1,s3
 1cc:	0349d863          	bge	s3,s4,1fc <gets+0x5e>
    cc = read(0, &c, 1);
 1d0:	8656                	mv	a2,s5
 1d2:	85da                	mv	a1,s6
 1d4:	4501                	li	a0,0
 1d6:	1c0000ef          	jal	396 <read>
    if(cc < 1)
 1da:	02a05163          	blez	a0,1fc <gets+0x5e>
      break;
    buf[i++] = c;
 1de:	faf44783          	lbu	a5,-81(s0)
 1e2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1e6:	0905                	addi	s2,s2,1
 1e8:	ff678713          	addi	a4,a5,-10
 1ec:	00173713          	seqz	a4,a4
 1f0:	17cd                	addi	a5,a5,-13
 1f2:	0017b793          	seqz	a5,a5
 1f6:	8fd9                	or	a5,a5,a4
 1f8:	d7f1                	beqz	a5,1c4 <gets+0x26>
    buf[i++] = c;
 1fa:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 1fc:	9c5e                	add	s8,s8,s7
 1fe:	000c0023          	sb	zero,0(s8)
  return buf;
}
 202:	855e                	mv	a0,s7
 204:	60e6                	ld	ra,88(sp)
 206:	6446                	ld	s0,80(sp)
 208:	64a6                	ld	s1,72(sp)
 20a:	6906                	ld	s2,64(sp)
 20c:	79e2                	ld	s3,56(sp)
 20e:	7a42                	ld	s4,48(sp)
 210:	7aa2                	ld	s5,40(sp)
 212:	7b02                	ld	s6,32(sp)
 214:	6be2                	ld	s7,24(sp)
 216:	6c42                	ld	s8,16(sp)
 218:	6125                	addi	sp,sp,96
 21a:	8082                	ret

000000000000021c <stat>:

int
stat(const char *n, struct stat *st)
{
 21c:	1101                	addi	sp,sp,-32
 21e:	ec06                	sd	ra,24(sp)
 220:	e822                	sd	s0,16(sp)
 222:	e04a                	sd	s2,0(sp)
 224:	1000                	addi	s0,sp,32
 226:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 228:	4581                	li	a1,0
 22a:	194000ef          	jal	3be <open>
  if(fd < 0)
 22e:	02054263          	bltz	a0,252 <stat+0x36>
 232:	e426                	sd	s1,8(sp)
 234:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 236:	85ca                	mv	a1,s2
 238:	19e000ef          	jal	3d6 <fstat>
 23c:	892a                	mv	s2,a0
  close(fd);
 23e:	8526                	mv	a0,s1
 240:	166000ef          	jal	3a6 <close>
  return r;
 244:	64a2                	ld	s1,8(sp)
}
 246:	854a                	mv	a0,s2
 248:	60e2                	ld	ra,24(sp)
 24a:	6442                	ld	s0,16(sp)
 24c:	6902                	ld	s2,0(sp)
 24e:	6105                	addi	sp,sp,32
 250:	8082                	ret
    return -1;
 252:	57fd                	li	a5,-1
 254:	893e                	mv	s2,a5
 256:	bfc5                	j	246 <stat+0x2a>

0000000000000258 <atoi>:

int
atoi(const char *s)
{
 258:	1141                	addi	sp,sp,-16
 25a:	e406                	sd	ra,8(sp)
 25c:	e022                	sd	s0,0(sp)
 25e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 260:	00054683          	lbu	a3,0(a0)
 264:	fd06879b          	addiw	a5,a3,-48
 268:	0ff7f793          	zext.b	a5,a5
 26c:	4625                	li	a2,9
 26e:	02f66963          	bltu	a2,a5,2a0 <atoi+0x48>
 272:	872a                	mv	a4,a0
  n = 0;
 274:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 276:	0705                	addi	a4,a4,1
 278:	0025179b          	slliw	a5,a0,0x2
 27c:	9fa9                	addw	a5,a5,a0
 27e:	0017979b          	slliw	a5,a5,0x1
 282:	9fb5                	addw	a5,a5,a3
 284:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 288:	00074683          	lbu	a3,0(a4)
 28c:	fd06879b          	addiw	a5,a3,-48
 290:	0ff7f793          	zext.b	a5,a5
 294:	fef671e3          	bgeu	a2,a5,276 <atoi+0x1e>
  return n;
}
 298:	60a2                	ld	ra,8(sp)
 29a:	6402                	ld	s0,0(sp)
 29c:	0141                	addi	sp,sp,16
 29e:	8082                	ret
  n = 0;
 2a0:	4501                	li	a0,0
 2a2:	bfdd                	j	298 <atoi+0x40>

00000000000002a4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a4:	1141                	addi	sp,sp,-16
 2a6:	e406                	sd	ra,8(sp)
 2a8:	e022                	sd	s0,0(sp)
 2aa:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2ac:	02b57563          	bgeu	a0,a1,2d6 <memmove+0x32>
    while(n-- > 0)
 2b0:	00c05f63          	blez	a2,2ce <memmove+0x2a>
 2b4:	1602                	slli	a2,a2,0x20
 2b6:	9201                	srli	a2,a2,0x20
 2b8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2bc:	872a                	mv	a4,a0
      *dst++ = *src++;
 2be:	0585                	addi	a1,a1,1
 2c0:	0705                	addi	a4,a4,1
 2c2:	fff5c683          	lbu	a3,-1(a1)
 2c6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2ca:	fee79ae3          	bne	a5,a4,2be <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2ce:	60a2                	ld	ra,8(sp)
 2d0:	6402                	ld	s0,0(sp)
 2d2:	0141                	addi	sp,sp,16
 2d4:	8082                	ret
    while(n-- > 0)
 2d6:	fec05ce3          	blez	a2,2ce <memmove+0x2a>
    dst += n;
 2da:	00c50733          	add	a4,a0,a2
    src += n;
 2de:	95b2                	add	a1,a1,a2
 2e0:	fff6079b          	addiw	a5,a2,-1
 2e4:	1782                	slli	a5,a5,0x20
 2e6:	9381                	srli	a5,a5,0x20
 2e8:	fff7c793          	not	a5,a5
 2ec:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2ee:	15fd                	addi	a1,a1,-1
 2f0:	177d                	addi	a4,a4,-1
 2f2:	0005c683          	lbu	a3,0(a1)
 2f6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2fa:	fef71ae3          	bne	a4,a5,2ee <memmove+0x4a>
 2fe:	bfc1                	j	2ce <memmove+0x2a>

0000000000000300 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 300:	1141                	addi	sp,sp,-16
 302:	e406                	sd	ra,8(sp)
 304:	e022                	sd	s0,0(sp)
 306:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 308:	ce19                	beqz	a2,326 <memcmp+0x26>
 30a:	1602                	slli	a2,a2,0x20
 30c:	9201                	srli	a2,a2,0x20
 30e:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 312:	00054783          	lbu	a5,0(a0)
 316:	0005c703          	lbu	a4,0(a1)
 31a:	00e79b63          	bne	a5,a4,330 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 31e:	0505                	addi	a0,a0,1
    p2++;
 320:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 322:	fed518e3          	bne	a0,a3,312 <memcmp+0x12>
  }
  return 0;
 326:	4501                	li	a0,0
}
 328:	60a2                	ld	ra,8(sp)
 32a:	6402                	ld	s0,0(sp)
 32c:	0141                	addi	sp,sp,16
 32e:	8082                	ret
      return *p1 - *p2;
 330:	40e7853b          	subw	a0,a5,a4
 334:	bfd5                	j	328 <memcmp+0x28>

0000000000000336 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 336:	1141                	addi	sp,sp,-16
 338:	e406                	sd	ra,8(sp)
 33a:	e022                	sd	s0,0(sp)
 33c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 33e:	f67ff0ef          	jal	2a4 <memmove>
}
 342:	60a2                	ld	ra,8(sp)
 344:	6402                	ld	s0,0(sp)
 346:	0141                	addi	sp,sp,16
 348:	8082                	ret

000000000000034a <sbrk>:

char *
sbrk(int n) {
 34a:	1141                	addi	sp,sp,-16
 34c:	e406                	sd	ra,8(sp)
 34e:	e022                	sd	s0,0(sp)
 350:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 352:	4585                	li	a1,1
 354:	0b2000ef          	jal	406 <sys_sbrk>
}
 358:	60a2                	ld	ra,8(sp)
 35a:	6402                	ld	s0,0(sp)
 35c:	0141                	addi	sp,sp,16
 35e:	8082                	ret

0000000000000360 <sbrklazy>:

char *
sbrklazy(int n) {
 360:	1141                	addi	sp,sp,-16
 362:	e406                	sd	ra,8(sp)
 364:	e022                	sd	s0,0(sp)
 366:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 368:	4589                	li	a1,2
 36a:	09c000ef          	jal	406 <sys_sbrk>
}
 36e:	60a2                	ld	ra,8(sp)
 370:	6402                	ld	s0,0(sp)
 372:	0141                	addi	sp,sp,16
 374:	8082                	ret

0000000000000376 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 376:	4885                	li	a7,1
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <exit>:
.global exit
exit:
 li a7, SYS_exit
 37e:	4889                	li	a7,2
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <wait>:
.global wait
wait:
 li a7, SYS_wait
 386:	488d                	li	a7,3
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 38e:	4891                	li	a7,4
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <read>:
.global read
read:
 li a7, SYS_read
 396:	4895                	li	a7,5
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <write>:
.global write
write:
 li a7, SYS_write
 39e:	48c1                	li	a7,16
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <close>:
.global close
close:
 li a7, SYS_close
 3a6:	48d5                	li	a7,21
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <kill>:
.global kill
kill:
 li a7, SYS_kill
 3ae:	4899                	li	a7,6
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3b6:	489d                	li	a7,7
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <open>:
.global open
open:
 li a7, SYS_open
 3be:	48bd                	li	a7,15
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3c6:	48c5                	li	a7,17
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3ce:	48c9                	li	a7,18
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3d6:	48a1                	li	a7,8
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <link>:
.global link
link:
 li a7, SYS_link
 3de:	48cd                	li	a7,19
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3e6:	48d1                	li	a7,20
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3ee:	48a5                	li	a7,9
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3f6:	48a9                	li	a7,10
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3fe:	48ad                	li	a7,11
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 406:	48b1                	li	a7,12
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <pause>:
.global pause
pause:
 li a7, SYS_pause
 40e:	48b5                	li	a7,13
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 416:	48b9                	li	a7,14
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 41e:	1101                	addi	sp,sp,-32
 420:	ec06                	sd	ra,24(sp)
 422:	e822                	sd	s0,16(sp)
 424:	1000                	addi	s0,sp,32
 426:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 42a:	4605                	li	a2,1
 42c:	fef40593          	addi	a1,s0,-17
 430:	f6fff0ef          	jal	39e <write>
}
 434:	60e2                	ld	ra,24(sp)
 436:	6442                	ld	s0,16(sp)
 438:	6105                	addi	sp,sp,32
 43a:	8082                	ret

000000000000043c <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 43c:	715d                	addi	sp,sp,-80
 43e:	e486                	sd	ra,72(sp)
 440:	e0a2                	sd	s0,64(sp)
 442:	f84a                	sd	s2,48(sp)
 444:	f44e                	sd	s3,40(sp)
 446:	0880                	addi	s0,sp,80
 448:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 44a:	00d036b3          	snez	a3,a3
 44e:	03f5d793          	srli	a5,a1,0x3f
 452:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 454:	0005871b          	sext.w	a4,a1
  neg = 0;
 458:	4301                	li	t1,0
  if(sgn && xx < 0){
 45a:	c681                	beqz	a3,462 <printint+0x26>
    x = -xx;
 45c:	40b0073b          	negw	a4,a1
    neg = 1;
 460:	4305                	li	t1,1
  }

  i = 0;
 462:	fb840993          	addi	s3,s0,-72
  neg = 0;
 466:	85ce                	mv	a1,s3
  i = 0;
 468:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 46a:	00000817          	auipc	a6,0x0
 46e:	5c680813          	addi	a6,a6,1478 # a30 <digits>
 472:	88b6                	mv	a7,a3
 474:	0016851b          	addiw	a0,a3,1
 478:	86aa                	mv	a3,a0
 47a:	02c777bb          	remuw	a5,a4,a2
 47e:	1782                	slli	a5,a5,0x20
 480:	9381                	srli	a5,a5,0x20
 482:	97c2                	add	a5,a5,a6
 484:	0007c783          	lbu	a5,0(a5)
 488:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 48c:	87ba                	mv	a5,a4
 48e:	02c7573b          	divuw	a4,a4,a2
 492:	0585                	addi	a1,a1,1
 494:	fcc7ffe3          	bgeu	a5,a2,472 <printint+0x36>
  if(neg)
 498:	00030b63          	beqz	t1,4ae <printint+0x72>
    buf[i++] = '-';
 49c:	fd040793          	addi	a5,s0,-48
 4a0:	953e                	add	a0,a0,a5
 4a2:	02d00793          	li	a5,45
 4a6:	fef50423          	sb	a5,-24(a0)
 4aa:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 4ae:	02d05563          	blez	a3,4d8 <printint+0x9c>
 4b2:	fc26                	sd	s1,56(sp)
 4b4:	36fd                	addiw	a3,a3,-1
 4b6:	00d984b3          	add	s1,s3,a3
 4ba:	19fd                	addi	s3,s3,-1
 4bc:	99b6                	add	s3,s3,a3
 4be:	1682                	slli	a3,a3,0x20
 4c0:	9281                	srli	a3,a3,0x20
 4c2:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 4c6:	0004c583          	lbu	a1,0(s1)
 4ca:	854a                	mv	a0,s2
 4cc:	f53ff0ef          	jal	41e <putc>
  while(--i >= 0)
 4d0:	14fd                	addi	s1,s1,-1
 4d2:	ff349ae3          	bne	s1,s3,4c6 <printint+0x8a>
 4d6:	74e2                	ld	s1,56(sp)
}
 4d8:	60a6                	ld	ra,72(sp)
 4da:	6406                	ld	s0,64(sp)
 4dc:	7942                	ld	s2,48(sp)
 4de:	79a2                	ld	s3,40(sp)
 4e0:	6161                	addi	sp,sp,80
 4e2:	8082                	ret

00000000000004e4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4e4:	711d                	addi	sp,sp,-96
 4e6:	ec86                	sd	ra,88(sp)
 4e8:	e8a2                	sd	s0,80(sp)
 4ea:	e4a6                	sd	s1,72(sp)
 4ec:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4ee:	0005c483          	lbu	s1,0(a1)
 4f2:	2a048063          	beqz	s1,792 <vprintf+0x2ae>
 4f6:	e0ca                	sd	s2,64(sp)
 4f8:	fc4e                	sd	s3,56(sp)
 4fa:	f852                	sd	s4,48(sp)
 4fc:	f456                	sd	s5,40(sp)
 4fe:	f05a                	sd	s6,32(sp)
 500:	ec5e                	sd	s7,24(sp)
 502:	e862                	sd	s8,16(sp)
 504:	8b2a                	mv	s6,a0
 506:	8a2e                	mv	s4,a1
 508:	8bb2                	mv	s7,a2
  state = 0;
 50a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 50c:	4901                	li	s2,0
 50e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 510:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 514:	06400c13          	li	s8,100
 518:	a00d                	j	53a <vprintf+0x56>
        putc(fd, c0);
 51a:	85a6                	mv	a1,s1
 51c:	855a                	mv	a0,s6
 51e:	f01ff0ef          	jal	41e <putc>
 522:	a019                	j	528 <vprintf+0x44>
    } else if(state == '%'){
 524:	03598363          	beq	s3,s5,54a <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 528:	0019079b          	addiw	a5,s2,1
 52c:	893e                	mv	s2,a5
 52e:	873e                	mv	a4,a5
 530:	97d2                	add	a5,a5,s4
 532:	0007c483          	lbu	s1,0(a5)
 536:	24048763          	beqz	s1,784 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 53a:	0004879b          	sext.w	a5,s1
    if(state == 0){
 53e:	fe0993e3          	bnez	s3,524 <vprintf+0x40>
      if(c0 == '%'){
 542:	fd579ce3          	bne	a5,s5,51a <vprintf+0x36>
        state = '%';
 546:	89be                	mv	s3,a5
 548:	b7c5                	j	528 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 54a:	00ea06b3          	add	a3,s4,a4
 54e:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 552:	24060563          	beqz	a2,79c <vprintf+0x2b8>
      if(c0 == 'd'){
 556:	0b878763          	beq	a5,s8,604 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 55a:	f9478693          	addi	a3,a5,-108
 55e:	0016b693          	seqz	a3,a3
 562:	f9c60593          	addi	a1,a2,-100
 566:	0015b593          	seqz	a1,a1
 56a:	8df5                	and	a1,a1,a3
 56c:	e9c5                	bnez	a1,61c <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 56e:	9752                	add	a4,a4,s4
 570:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 574:	f9460713          	addi	a4,a2,-108
 578:	00173713          	seqz	a4,a4
 57c:	8f75                	and	a4,a4,a3
 57e:	f9c50593          	addi	a1,a0,-100
 582:	0015b593          	seqz	a1,a1
 586:	8df9                	and	a1,a1,a4
 588:	e5dd                	bnez	a1,636 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 58a:	07500593          	li	a1,117
 58e:	0cb78163          	beq	a5,a1,650 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 592:	f8b60593          	addi	a1,a2,-117
 596:	0015b593          	seqz	a1,a1
 59a:	8df5                	and	a1,a1,a3
 59c:	e5f1                	bnez	a1,668 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 59e:	f8b50593          	addi	a1,a0,-117
 5a2:	0015b593          	seqz	a1,a1
 5a6:	8df9                	and	a1,a1,a4
 5a8:	ede9                	bnez	a1,682 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5aa:	07800593          	li	a1,120
 5ae:	0eb78763          	beq	a5,a1,69c <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 5b2:	f8860613          	addi	a2,a2,-120
 5b6:	00163613          	seqz	a2,a2
 5ba:	8ef1                	and	a3,a3,a2
 5bc:	0e069c63          	bnez	a3,6b4 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5c0:	f8850513          	addi	a0,a0,-120
 5c4:	00153513          	seqz	a0,a0
 5c8:	8f69                	and	a4,a4,a0
 5ca:	10071263          	bnez	a4,6ce <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5ce:	07000713          	li	a4,112
 5d2:	10e78a63          	beq	a5,a4,6e6 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5d6:	06300713          	li	a4,99
 5da:	14e78a63          	beq	a5,a4,72e <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5de:	07300713          	li	a4,115
 5e2:	16e78063          	beq	a5,a4,742 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5e6:	02500713          	li	a4,37
 5ea:	18e78863          	beq	a5,a4,77a <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5ee:	02500593          	li	a1,37
 5f2:	855a                	mv	a0,s6
 5f4:	e2bff0ef          	jal	41e <putc>
        putc(fd, c0);
 5f8:	85a6                	mv	a1,s1
 5fa:	855a                	mv	a0,s6
 5fc:	e23ff0ef          	jal	41e <putc>
      }

      state = 0;
 600:	4981                	li	s3,0
 602:	b71d                	j	528 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 604:	008b8493          	addi	s1,s7,8
 608:	4685                	li	a3,1
 60a:	4629                	li	a2,10
 60c:	000ba583          	lw	a1,0(s7)
 610:	855a                	mv	a0,s6
 612:	e2bff0ef          	jal	43c <printint>
 616:	8ba6                	mv	s7,s1
      state = 0;
 618:	4981                	li	s3,0
 61a:	b739                	j	528 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 61c:	008b8493          	addi	s1,s7,8
 620:	4685                	li	a3,1
 622:	4629                	li	a2,10
 624:	000bb583          	ld	a1,0(s7)
 628:	855a                	mv	a0,s6
 62a:	e13ff0ef          	jal	43c <printint>
        i += 1;
 62e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 630:	8ba6                	mv	s7,s1
      state = 0;
 632:	4981                	li	s3,0
 634:	bdd5                	j	528 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 636:	008b8493          	addi	s1,s7,8
 63a:	4685                	li	a3,1
 63c:	4629                	li	a2,10
 63e:	000bb583          	ld	a1,0(s7)
 642:	855a                	mv	a0,s6
 644:	df9ff0ef          	jal	43c <printint>
        i += 2;
 648:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 64a:	8ba6                	mv	s7,s1
      state = 0;
 64c:	4981                	li	s3,0
        i += 2;
 64e:	bde9                	j	528 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 650:	008b8493          	addi	s1,s7,8
 654:	4681                	li	a3,0
 656:	4629                	li	a2,10
 658:	000be583          	lwu	a1,0(s7)
 65c:	855a                	mv	a0,s6
 65e:	ddfff0ef          	jal	43c <printint>
 662:	8ba6                	mv	s7,s1
      state = 0;
 664:	4981                	li	s3,0
 666:	b5c9                	j	528 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 668:	008b8493          	addi	s1,s7,8
 66c:	4681                	li	a3,0
 66e:	4629                	li	a2,10
 670:	000bb583          	ld	a1,0(s7)
 674:	855a                	mv	a0,s6
 676:	dc7ff0ef          	jal	43c <printint>
        i += 1;
 67a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 67c:	8ba6                	mv	s7,s1
      state = 0;
 67e:	4981                	li	s3,0
 680:	b565                	j	528 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 682:	008b8493          	addi	s1,s7,8
 686:	4681                	li	a3,0
 688:	4629                	li	a2,10
 68a:	000bb583          	ld	a1,0(s7)
 68e:	855a                	mv	a0,s6
 690:	dadff0ef          	jal	43c <printint>
        i += 2;
 694:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 696:	8ba6                	mv	s7,s1
      state = 0;
 698:	4981                	li	s3,0
        i += 2;
 69a:	b579                	j	528 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 69c:	008b8493          	addi	s1,s7,8
 6a0:	4681                	li	a3,0
 6a2:	4641                	li	a2,16
 6a4:	000be583          	lwu	a1,0(s7)
 6a8:	855a                	mv	a0,s6
 6aa:	d93ff0ef          	jal	43c <printint>
 6ae:	8ba6                	mv	s7,s1
      state = 0;
 6b0:	4981                	li	s3,0
 6b2:	bd9d                	j	528 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6b4:	008b8493          	addi	s1,s7,8
 6b8:	4681                	li	a3,0
 6ba:	4641                	li	a2,16
 6bc:	000bb583          	ld	a1,0(s7)
 6c0:	855a                	mv	a0,s6
 6c2:	d7bff0ef          	jal	43c <printint>
        i += 1;
 6c6:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6c8:	8ba6                	mv	s7,s1
      state = 0;
 6ca:	4981                	li	s3,0
 6cc:	bdb1                	j	528 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6ce:	008b8493          	addi	s1,s7,8
 6d2:	4641                	li	a2,16
 6d4:	000bb583          	ld	a1,0(s7)
 6d8:	855a                	mv	a0,s6
 6da:	d63ff0ef          	jal	43c <printint>
        i += 2;
 6de:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6e0:	8ba6                	mv	s7,s1
      state = 0;
 6e2:	4981                	li	s3,0
        i += 2;
 6e4:	b591                	j	528 <vprintf+0x44>
 6e6:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 6e8:	008b8793          	addi	a5,s7,8
 6ec:	8cbe                	mv	s9,a5
 6ee:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6f2:	03000593          	li	a1,48
 6f6:	855a                	mv	a0,s6
 6f8:	d27ff0ef          	jal	41e <putc>
  putc(fd, 'x');
 6fc:	07800593          	li	a1,120
 700:	855a                	mv	a0,s6
 702:	d1dff0ef          	jal	41e <putc>
 706:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 708:	00000b97          	auipc	s7,0x0
 70c:	328b8b93          	addi	s7,s7,808 # a30 <digits>
 710:	03c9d793          	srli	a5,s3,0x3c
 714:	97de                	add	a5,a5,s7
 716:	0007c583          	lbu	a1,0(a5)
 71a:	855a                	mv	a0,s6
 71c:	d03ff0ef          	jal	41e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 720:	0992                	slli	s3,s3,0x4
 722:	34fd                	addiw	s1,s1,-1
 724:	f4f5                	bnez	s1,710 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 726:	8be6                	mv	s7,s9
      state = 0;
 728:	4981                	li	s3,0
 72a:	6ca2                	ld	s9,8(sp)
 72c:	bbf5                	j	528 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 72e:	008b8493          	addi	s1,s7,8
 732:	000bc583          	lbu	a1,0(s7)
 736:	855a                	mv	a0,s6
 738:	ce7ff0ef          	jal	41e <putc>
 73c:	8ba6                	mv	s7,s1
      state = 0;
 73e:	4981                	li	s3,0
 740:	b3e5                	j	528 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 742:	008b8993          	addi	s3,s7,8
 746:	000bb483          	ld	s1,0(s7)
 74a:	cc91                	beqz	s1,766 <vprintf+0x282>
        for(; *s; s++)
 74c:	0004c583          	lbu	a1,0(s1)
 750:	c195                	beqz	a1,774 <vprintf+0x290>
          putc(fd, *s);
 752:	855a                	mv	a0,s6
 754:	ccbff0ef          	jal	41e <putc>
        for(; *s; s++)
 758:	0485                	addi	s1,s1,1
 75a:	0004c583          	lbu	a1,0(s1)
 75e:	f9f5                	bnez	a1,752 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 760:	8bce                	mv	s7,s3
      state = 0;
 762:	4981                	li	s3,0
 764:	b3d1                	j	528 <vprintf+0x44>
          s = "(null)";
 766:	00000497          	auipc	s1,0x0
 76a:	2c248493          	addi	s1,s1,706 # a28 <malloc+0x190>
        for(; *s; s++)
 76e:	02800593          	li	a1,40
 772:	b7c5                	j	752 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 774:	8bce                	mv	s7,s3
      state = 0;
 776:	4981                	li	s3,0
 778:	bb45                	j	528 <vprintf+0x44>
        putc(fd, '%');
 77a:	85be                	mv	a1,a5
 77c:	855a                	mv	a0,s6
 77e:	ca1ff0ef          	jal	41e <putc>
 782:	bdbd                	j	600 <vprintf+0x11c>
 784:	6906                	ld	s2,64(sp)
 786:	79e2                	ld	s3,56(sp)
 788:	7a42                	ld	s4,48(sp)
 78a:	7aa2                	ld	s5,40(sp)
 78c:	7b02                	ld	s6,32(sp)
 78e:	6be2                	ld	s7,24(sp)
 790:	6c42                	ld	s8,16(sp)
    }
  }
}
 792:	60e6                	ld	ra,88(sp)
 794:	6446                	ld	s0,80(sp)
 796:	64a6                	ld	s1,72(sp)
 798:	6125                	addi	sp,sp,96
 79a:	8082                	ret
      if(c0 == 'd'){
 79c:	06400713          	li	a4,100
 7a0:	e6e782e3          	beq	a5,a4,604 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 7a4:	f9478693          	addi	a3,a5,-108
 7a8:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 7ac:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7ae:	4701                	li	a4,0
 7b0:	bbe9                	j	58a <vprintf+0xa6>

00000000000007b2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7b2:	715d                	addi	sp,sp,-80
 7b4:	ec06                	sd	ra,24(sp)
 7b6:	e822                	sd	s0,16(sp)
 7b8:	1000                	addi	s0,sp,32
 7ba:	e010                	sd	a2,0(s0)
 7bc:	e414                	sd	a3,8(s0)
 7be:	e818                	sd	a4,16(s0)
 7c0:	ec1c                	sd	a5,24(s0)
 7c2:	03043023          	sd	a6,32(s0)
 7c6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7ca:	8622                	mv	a2,s0
 7cc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7d0:	d15ff0ef          	jal	4e4 <vprintf>
}
 7d4:	60e2                	ld	ra,24(sp)
 7d6:	6442                	ld	s0,16(sp)
 7d8:	6161                	addi	sp,sp,80
 7da:	8082                	ret

00000000000007dc <printf>:

void
printf(const char *fmt, ...)
{
 7dc:	711d                	addi	sp,sp,-96
 7de:	ec06                	sd	ra,24(sp)
 7e0:	e822                	sd	s0,16(sp)
 7e2:	1000                	addi	s0,sp,32
 7e4:	e40c                	sd	a1,8(s0)
 7e6:	e810                	sd	a2,16(s0)
 7e8:	ec14                	sd	a3,24(s0)
 7ea:	f018                	sd	a4,32(s0)
 7ec:	f41c                	sd	a5,40(s0)
 7ee:	03043823          	sd	a6,48(s0)
 7f2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7f6:	00840613          	addi	a2,s0,8
 7fa:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7fe:	85aa                	mv	a1,a0
 800:	4505                	li	a0,1
 802:	ce3ff0ef          	jal	4e4 <vprintf>
}
 806:	60e2                	ld	ra,24(sp)
 808:	6442                	ld	s0,16(sp)
 80a:	6125                	addi	sp,sp,96
 80c:	8082                	ret

000000000000080e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 80e:	1141                	addi	sp,sp,-16
 810:	e406                	sd	ra,8(sp)
 812:	e022                	sd	s0,0(sp)
 814:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 816:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 81a:	00000797          	auipc	a5,0x0
 81e:	7e67b783          	ld	a5,2022(a5) # 1000 <freep>
 822:	a095                	j	886 <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 824:	ff852583          	lw	a1,-8(a0)
 828:	6390                	ld	a2,0(a5)
 82a:	02059813          	slli	a6,a1,0x20
 82e:	01c85693          	srli	a3,a6,0x1c
 832:	96ba                	add	a3,a3,a4
 834:	02d60563          	beq	a2,a3,85e <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 838:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 83c:	4790                	lw	a2,8(a5)
 83e:	02061593          	slli	a1,a2,0x20
 842:	01c5d693          	srli	a3,a1,0x1c
 846:	96be                	add	a3,a3,a5
 848:	02d70263          	beq	a4,a3,86c <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 84c:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 84e:	00000717          	auipc	a4,0x0
 852:	7af73923          	sd	a5,1970(a4) # 1000 <freep>
}
 856:	60a2                	ld	ra,8(sp)
 858:	6402                	ld	s0,0(sp)
 85a:	0141                	addi	sp,sp,16
 85c:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 85e:	4614                	lw	a3,8(a2)
 860:	9ead                	addw	a3,a3,a1
 862:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 866:	6394                	ld	a3,0(a5)
 868:	6290                	ld	a2,0(a3)
 86a:	b7f9                	j	838 <free+0x2a>
    p->s.size += bp->s.size;
 86c:	ff852703          	lw	a4,-8(a0)
 870:	9f31                	addw	a4,a4,a2
 872:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 874:	ff053703          	ld	a4,-16(a0)
 878:	bfd1                	j	84c <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 87a:	6394                	ld	a3,0(a5)
 87c:	00d7e463          	bltu	a5,a3,884 <free+0x76>
 880:	fad762e3          	bltu	a4,a3,824 <free+0x16>
 884:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 886:	fee7fae3          	bgeu	a5,a4,87a <free+0x6c>
 88a:	6394                	ld	a3,0(a5)
 88c:	f8d76ce3          	bltu	a4,a3,824 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 890:	f8d7fae3          	bgeu	a5,a3,824 <free+0x16>
 894:	87b6                	mv	a5,a3
 896:	bfc5                	j	886 <free+0x78>

0000000000000898 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 898:	7139                	addi	sp,sp,-64
 89a:	fc06                	sd	ra,56(sp)
 89c:	f822                	sd	s0,48(sp)
 89e:	f04a                	sd	s2,32(sp)
 8a0:	ec4e                	sd	s3,24(sp)
 8a2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a4:	02051993          	slli	s3,a0,0x20
 8a8:	0209d993          	srli	s3,s3,0x20
 8ac:	09bd                	addi	s3,s3,15
 8ae:	0049d993          	srli	s3,s3,0x4
 8b2:	2985                	addiw	s3,s3,1
 8b4:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8b6:	00000517          	auipc	a0,0x0
 8ba:	74a53503          	ld	a0,1866(a0) # 1000 <freep>
 8be:	c905                	beqz	a0,8ee <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8c2:	4798                	lw	a4,8(a5)
 8c4:	09377663          	bgeu	a4,s3,950 <malloc+0xb8>
 8c8:	f426                	sd	s1,40(sp)
 8ca:	e852                	sd	s4,16(sp)
 8cc:	e456                	sd	s5,8(sp)
 8ce:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8d0:	8a4e                	mv	s4,s3
 8d2:	6705                	lui	a4,0x1
 8d4:	00e9f363          	bgeu	s3,a4,8da <malloc+0x42>
 8d8:	6a05                	lui	s4,0x1
 8da:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8de:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8e2:	00000497          	auipc	s1,0x0
 8e6:	71e48493          	addi	s1,s1,1822 # 1000 <freep>
  if(p == SBRK_ERROR)
 8ea:	5afd                	li	s5,-1
 8ec:	a83d                	j	92a <malloc+0x92>
 8ee:	f426                	sd	s1,40(sp)
 8f0:	e852                	sd	s4,16(sp)
 8f2:	e456                	sd	s5,8(sp)
 8f4:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8f6:	00001797          	auipc	a5,0x1
 8fa:	91278793          	addi	a5,a5,-1774 # 1208 <base>
 8fe:	00000717          	auipc	a4,0x0
 902:	70f73123          	sd	a5,1794(a4) # 1000 <freep>
 906:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 908:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 90c:	b7d1                	j	8d0 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 90e:	6398                	ld	a4,0(a5)
 910:	e118                	sd	a4,0(a0)
 912:	a899                	j	968 <malloc+0xd0>
  hp->s.size = nu;
 914:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 918:	0541                	addi	a0,a0,16
 91a:	ef5ff0ef          	jal	80e <free>
  return freep;
 91e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 920:	c125                	beqz	a0,980 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 922:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 924:	4798                	lw	a4,8(a5)
 926:	03277163          	bgeu	a4,s2,948 <malloc+0xb0>
    if(p == freep)
 92a:	6098                	ld	a4,0(s1)
 92c:	853e                	mv	a0,a5
 92e:	fef71ae3          	bne	a4,a5,922 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 932:	8552                	mv	a0,s4
 934:	a17ff0ef          	jal	34a <sbrk>
  if(p == SBRK_ERROR)
 938:	fd551ee3          	bne	a0,s5,914 <malloc+0x7c>
        return 0;
 93c:	4501                	li	a0,0
 93e:	74a2                	ld	s1,40(sp)
 940:	6a42                	ld	s4,16(sp)
 942:	6aa2                	ld	s5,8(sp)
 944:	6b02                	ld	s6,0(sp)
 946:	a03d                	j	974 <malloc+0xdc>
 948:	74a2                	ld	s1,40(sp)
 94a:	6a42                	ld	s4,16(sp)
 94c:	6aa2                	ld	s5,8(sp)
 94e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 950:	fae90fe3          	beq	s2,a4,90e <malloc+0x76>
        p->s.size -= nunits;
 954:	4137073b          	subw	a4,a4,s3
 958:	c798                	sw	a4,8(a5)
        p += p->s.size;
 95a:	02071693          	slli	a3,a4,0x20
 95e:	01c6d713          	srli	a4,a3,0x1c
 962:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 964:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 968:	00000717          	auipc	a4,0x0
 96c:	68a73c23          	sd	a0,1688(a4) # 1000 <freep>
      return (void*)(p + 1);
 970:	01078513          	addi	a0,a5,16
  }
}
 974:	70e2                	ld	ra,56(sp)
 976:	7442                	ld	s0,48(sp)
 978:	7902                	ld	s2,32(sp)
 97a:	69e2                	ld	s3,24(sp)
 97c:	6121                	addi	sp,sp,64
 97e:	8082                	ret
 980:	74a2                	ld	s1,40(sp)
 982:	6a42                	ld	s4,16(sp)
 984:	6aa2                	ld	s5,8(sp)
 986:	6b02                	ld	s6,0(sp)
 988:	b7f5                	j	974 <malloc+0xdc>
