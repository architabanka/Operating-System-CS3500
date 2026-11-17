
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	a4250513          	addi	a0,a0,-1470 # a50 <statistics+0x80>
  16:	3ac000ef          	jal	3c2 <open>
  1a:	04054563          	bltz	a0,64 <main+0x64>
    mknod("console", CONSOLE, 0);
    mknod("statistics", STATS, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  1e:	4501                	li	a0,0
  20:	3da000ef          	jal	3fa <dup>
  dup(0);  // stderr
  24:	4501                	li	a0,0
  26:	3d4000ef          	jal	3fa <dup>

  for(;;){
    printf("init: starting sh\n");
  2a:	00001917          	auipc	s2,0x1
  2e:	a3e90913          	addi	s2,s2,-1474 # a68 <statistics+0x98>
  32:	854a                	mv	a0,s2
  34:	7ee000ef          	jal	822 <printf>
    pid = fork();
  38:	342000ef          	jal	37a <fork>
  3c:	84aa                	mv	s1,a0
    if(pid < 0){
  3e:	04054b63          	bltz	a0,94 <main+0x94>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  42:	c135                	beqz	a0,a6 <main+0xa6>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  44:	4501                	li	a0,0
  46:	344000ef          	jal	38a <wait>
      if(wpid == pid){
  4a:	fea484e3          	beq	s1,a0,32 <main+0x32>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  4e:	fe055be3          	bgez	a0,44 <main+0x44>
        printf("init: wait returned an error\n");
  52:	00001517          	auipc	a0,0x1
  56:	a6650513          	addi	a0,a0,-1434 # ab8 <statistics+0xe8>
  5a:	7c8000ef          	jal	822 <printf>
        exit(1);
  5e:	4505                	li	a0,1
  60:	322000ef          	jal	382 <exit>
    mknod("console", CONSOLE, 0);
  64:	4601                	li	a2,0
  66:	4585                	li	a1,1
  68:	00001517          	auipc	a0,0x1
  6c:	9e850513          	addi	a0,a0,-1560 # a50 <statistics+0x80>
  70:	35a000ef          	jal	3ca <mknod>
    mknod("statistics", STATS, 0);
  74:	4601                	li	a2,0
  76:	4589                	li	a1,2
  78:	00001517          	auipc	a0,0x1
  7c:	9e050513          	addi	a0,a0,-1568 # a58 <statistics+0x88>
  80:	34a000ef          	jal	3ca <mknod>
    open("console", O_RDWR);
  84:	4589                	li	a1,2
  86:	00001517          	auipc	a0,0x1
  8a:	9ca50513          	addi	a0,a0,-1590 # a50 <statistics+0x80>
  8e:	334000ef          	jal	3c2 <open>
  92:	b771                	j	1e <main+0x1e>
      printf("init: fork failed\n");
  94:	00001517          	auipc	a0,0x1
  98:	9ec50513          	addi	a0,a0,-1556 # a80 <statistics+0xb0>
  9c:	786000ef          	jal	822 <printf>
      exit(1);
  a0:	4505                	li	a0,1
  a2:	2e0000ef          	jal	382 <exit>
      exec("sh", argv);
  a6:	00001597          	auipc	a1,0x1
  aa:	f5a58593          	addi	a1,a1,-166 # 1000 <argv>
  ae:	00001517          	auipc	a0,0x1
  b2:	9ea50513          	addi	a0,a0,-1558 # a98 <statistics+0xc8>
  b6:	304000ef          	jal	3ba <exec>
      printf("init: exec sh failed\n");
  ba:	00001517          	auipc	a0,0x1
  be:	9e650513          	addi	a0,a0,-1562 # aa0 <statistics+0xd0>
  c2:	760000ef          	jal	822 <printf>
      exit(1);
  c6:	4505                	li	a0,1
  c8:	2ba000ef          	jal	382 <exit>

00000000000000cc <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  cc:	1141                	addi	sp,sp,-16
  ce:	e406                	sd	ra,8(sp)
  d0:	e022                	sd	s0,0(sp)
  d2:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  d4:	f2dff0ef          	jal	0 <main>
  exit(r);
  d8:	2aa000ef          	jal	382 <exit>

00000000000000dc <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  dc:	1141                	addi	sp,sp,-16
  de:	e406                	sd	ra,8(sp)
  e0:	e022                	sd	s0,0(sp)
  e2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  e4:	87aa                	mv	a5,a0
  e6:	0585                	addi	a1,a1,1
  e8:	0785                	addi	a5,a5,1
  ea:	fff5c703          	lbu	a4,-1(a1)
  ee:	fee78fa3          	sb	a4,-1(a5)
  f2:	fb75                	bnez	a4,e6 <strcpy+0xa>
    ;
  return os;
}
  f4:	60a2                	ld	ra,8(sp)
  f6:	6402                	ld	s0,0(sp)
  f8:	0141                	addi	sp,sp,16
  fa:	8082                	ret

00000000000000fc <strcmp>:

int
strcmp(const char *p, const char *q)
{
  fc:	1141                	addi	sp,sp,-16
  fe:	e406                	sd	ra,8(sp)
 100:	e022                	sd	s0,0(sp)
 102:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 104:	00054783          	lbu	a5,0(a0)
 108:	cb91                	beqz	a5,11c <strcmp+0x20>
 10a:	0005c703          	lbu	a4,0(a1)
 10e:	00f71763          	bne	a4,a5,11c <strcmp+0x20>
    p++, q++;
 112:	0505                	addi	a0,a0,1
 114:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 116:	00054783          	lbu	a5,0(a0)
 11a:	fbe5                	bnez	a5,10a <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 11c:	0005c503          	lbu	a0,0(a1)
}
 120:	40a7853b          	subw	a0,a5,a0
 124:	60a2                	ld	ra,8(sp)
 126:	6402                	ld	s0,0(sp)
 128:	0141                	addi	sp,sp,16
 12a:	8082                	ret

000000000000012c <strlen>:

uint
strlen(const char *s)
{
 12c:	1141                	addi	sp,sp,-16
 12e:	e406                	sd	ra,8(sp)
 130:	e022                	sd	s0,0(sp)
 132:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 134:	00054783          	lbu	a5,0(a0)
 138:	cf91                	beqz	a5,154 <strlen+0x28>
 13a:	00150793          	addi	a5,a0,1
 13e:	86be                	mv	a3,a5
 140:	0785                	addi	a5,a5,1
 142:	fff7c703          	lbu	a4,-1(a5)
 146:	ff65                	bnez	a4,13e <strlen+0x12>
 148:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 14c:	60a2                	ld	ra,8(sp)
 14e:	6402                	ld	s0,0(sp)
 150:	0141                	addi	sp,sp,16
 152:	8082                	ret
  for(n = 0; s[n]; n++)
 154:	4501                	li	a0,0
 156:	bfdd                	j	14c <strlen+0x20>

0000000000000158 <memset>:

void*
memset(void *dst, int c, uint n)
{
 158:	1141                	addi	sp,sp,-16
 15a:	e406                	sd	ra,8(sp)
 15c:	e022                	sd	s0,0(sp)
 15e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 160:	ca19                	beqz	a2,176 <memset+0x1e>
 162:	87aa                	mv	a5,a0
 164:	1602                	slli	a2,a2,0x20
 166:	9201                	srli	a2,a2,0x20
 168:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 16c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 170:	0785                	addi	a5,a5,1
 172:	fee79de3          	bne	a5,a4,16c <memset+0x14>
  }
  return dst;
}
 176:	60a2                	ld	ra,8(sp)
 178:	6402                	ld	s0,0(sp)
 17a:	0141                	addi	sp,sp,16
 17c:	8082                	ret

000000000000017e <strchr>:

char*
strchr(const char *s, char c)
{
 17e:	1141                	addi	sp,sp,-16
 180:	e406                	sd	ra,8(sp)
 182:	e022                	sd	s0,0(sp)
 184:	0800                	addi	s0,sp,16
  for(; *s; s++)
 186:	00054783          	lbu	a5,0(a0)
 18a:	c799                	beqz	a5,198 <strchr+0x1a>
    if(*s == c)
 18c:	00f58763          	beq	a1,a5,19a <strchr+0x1c>
  for(; *s; s++)
 190:	0505                	addi	a0,a0,1
 192:	00054783          	lbu	a5,0(a0)
 196:	fbfd                	bnez	a5,18c <strchr+0xe>
      return (char*)s;
  return 0;
 198:	4501                	li	a0,0
}
 19a:	60a2                	ld	ra,8(sp)
 19c:	6402                	ld	s0,0(sp)
 19e:	0141                	addi	sp,sp,16
 1a0:	8082                	ret

00000000000001a2 <gets>:

char*
gets(char *buf, int max)
{
 1a2:	711d                	addi	sp,sp,-96
 1a4:	ec86                	sd	ra,88(sp)
 1a6:	e8a2                	sd	s0,80(sp)
 1a8:	e4a6                	sd	s1,72(sp)
 1aa:	e0ca                	sd	s2,64(sp)
 1ac:	fc4e                	sd	s3,56(sp)
 1ae:	f852                	sd	s4,48(sp)
 1b0:	f456                	sd	s5,40(sp)
 1b2:	f05a                	sd	s6,32(sp)
 1b4:	ec5e                	sd	s7,24(sp)
 1b6:	e862                	sd	s8,16(sp)
 1b8:	1080                	addi	s0,sp,96
 1ba:	8baa                	mv	s7,a0
 1bc:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1be:	892a                	mv	s2,a0
 1c0:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1c2:	faf40b13          	addi	s6,s0,-81
 1c6:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 1c8:	8c26                	mv	s8,s1
 1ca:	0014899b          	addiw	s3,s1,1
 1ce:	84ce                	mv	s1,s3
 1d0:	0349d863          	bge	s3,s4,200 <gets+0x5e>
    cc = read(0, &c, 1);
 1d4:	8656                	mv	a2,s5
 1d6:	85da                	mv	a1,s6
 1d8:	4501                	li	a0,0
 1da:	1c0000ef          	jal	39a <read>
    if(cc < 1)
 1de:	02a05163          	blez	a0,200 <gets+0x5e>
      break;
    buf[i++] = c;
 1e2:	faf44783          	lbu	a5,-81(s0)
 1e6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1ea:	0905                	addi	s2,s2,1
 1ec:	ff678713          	addi	a4,a5,-10
 1f0:	00173713          	seqz	a4,a4
 1f4:	17cd                	addi	a5,a5,-13
 1f6:	0017b793          	seqz	a5,a5
 1fa:	8fd9                	or	a5,a5,a4
 1fc:	d7f1                	beqz	a5,1c8 <gets+0x26>
    buf[i++] = c;
 1fe:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 200:	9c5e                	add	s8,s8,s7
 202:	000c0023          	sb	zero,0(s8)
  return buf;
}
 206:	855e                	mv	a0,s7
 208:	60e6                	ld	ra,88(sp)
 20a:	6446                	ld	s0,80(sp)
 20c:	64a6                	ld	s1,72(sp)
 20e:	6906                	ld	s2,64(sp)
 210:	79e2                	ld	s3,56(sp)
 212:	7a42                	ld	s4,48(sp)
 214:	7aa2                	ld	s5,40(sp)
 216:	7b02                	ld	s6,32(sp)
 218:	6be2                	ld	s7,24(sp)
 21a:	6c42                	ld	s8,16(sp)
 21c:	6125                	addi	sp,sp,96
 21e:	8082                	ret

0000000000000220 <stat>:

int
stat(const char *n, struct stat *st)
{
 220:	1101                	addi	sp,sp,-32
 222:	ec06                	sd	ra,24(sp)
 224:	e822                	sd	s0,16(sp)
 226:	e04a                	sd	s2,0(sp)
 228:	1000                	addi	s0,sp,32
 22a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 22c:	4581                	li	a1,0
 22e:	194000ef          	jal	3c2 <open>
  if(fd < 0)
 232:	02054263          	bltz	a0,256 <stat+0x36>
 236:	e426                	sd	s1,8(sp)
 238:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 23a:	85ca                	mv	a1,s2
 23c:	19e000ef          	jal	3da <fstat>
 240:	892a                	mv	s2,a0
  close(fd);
 242:	8526                	mv	a0,s1
 244:	166000ef          	jal	3aa <close>
  return r;
 248:	64a2                	ld	s1,8(sp)
}
 24a:	854a                	mv	a0,s2
 24c:	60e2                	ld	ra,24(sp)
 24e:	6442                	ld	s0,16(sp)
 250:	6902                	ld	s2,0(sp)
 252:	6105                	addi	sp,sp,32
 254:	8082                	ret
    return -1;
 256:	57fd                	li	a5,-1
 258:	893e                	mv	s2,a5
 25a:	bfc5                	j	24a <stat+0x2a>

000000000000025c <atoi>:

int
atoi(const char *s)
{
 25c:	1141                	addi	sp,sp,-16
 25e:	e406                	sd	ra,8(sp)
 260:	e022                	sd	s0,0(sp)
 262:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 264:	00054683          	lbu	a3,0(a0)
 268:	fd06879b          	addiw	a5,a3,-48
 26c:	0ff7f793          	zext.b	a5,a5
 270:	4625                	li	a2,9
 272:	02f66963          	bltu	a2,a5,2a4 <atoi+0x48>
 276:	872a                	mv	a4,a0
  n = 0;
 278:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 27a:	0705                	addi	a4,a4,1
 27c:	0025179b          	slliw	a5,a0,0x2
 280:	9fa9                	addw	a5,a5,a0
 282:	0017979b          	slliw	a5,a5,0x1
 286:	9fb5                	addw	a5,a5,a3
 288:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 28c:	00074683          	lbu	a3,0(a4)
 290:	fd06879b          	addiw	a5,a3,-48
 294:	0ff7f793          	zext.b	a5,a5
 298:	fef671e3          	bgeu	a2,a5,27a <atoi+0x1e>
  return n;
}
 29c:	60a2                	ld	ra,8(sp)
 29e:	6402                	ld	s0,0(sp)
 2a0:	0141                	addi	sp,sp,16
 2a2:	8082                	ret
  n = 0;
 2a4:	4501                	li	a0,0
 2a6:	bfdd                	j	29c <atoi+0x40>

00000000000002a8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a8:	1141                	addi	sp,sp,-16
 2aa:	e406                	sd	ra,8(sp)
 2ac:	e022                	sd	s0,0(sp)
 2ae:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2b0:	02b57563          	bgeu	a0,a1,2da <memmove+0x32>
    while(n-- > 0)
 2b4:	00c05f63          	blez	a2,2d2 <memmove+0x2a>
 2b8:	1602                	slli	a2,a2,0x20
 2ba:	9201                	srli	a2,a2,0x20
 2bc:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2c0:	872a                	mv	a4,a0
      *dst++ = *src++;
 2c2:	0585                	addi	a1,a1,1
 2c4:	0705                	addi	a4,a4,1
 2c6:	fff5c683          	lbu	a3,-1(a1)
 2ca:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2ce:	fee79ae3          	bne	a5,a4,2c2 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2d2:	60a2                	ld	ra,8(sp)
 2d4:	6402                	ld	s0,0(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret
    while(n-- > 0)
 2da:	fec05ce3          	blez	a2,2d2 <memmove+0x2a>
    dst += n;
 2de:	00c50733          	add	a4,a0,a2
    src += n;
 2e2:	95b2                	add	a1,a1,a2
 2e4:	fff6079b          	addiw	a5,a2,-1
 2e8:	1782                	slli	a5,a5,0x20
 2ea:	9381                	srli	a5,a5,0x20
 2ec:	fff7c793          	not	a5,a5
 2f0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2f2:	15fd                	addi	a1,a1,-1
 2f4:	177d                	addi	a4,a4,-1
 2f6:	0005c683          	lbu	a3,0(a1)
 2fa:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2fe:	fef71ae3          	bne	a4,a5,2f2 <memmove+0x4a>
 302:	bfc1                	j	2d2 <memmove+0x2a>

0000000000000304 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 304:	1141                	addi	sp,sp,-16
 306:	e406                	sd	ra,8(sp)
 308:	e022                	sd	s0,0(sp)
 30a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 30c:	ce19                	beqz	a2,32a <memcmp+0x26>
 30e:	1602                	slli	a2,a2,0x20
 310:	9201                	srli	a2,a2,0x20
 312:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 316:	00054783          	lbu	a5,0(a0)
 31a:	0005c703          	lbu	a4,0(a1)
 31e:	00e79b63          	bne	a5,a4,334 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 322:	0505                	addi	a0,a0,1
    p2++;
 324:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 326:	fed518e3          	bne	a0,a3,316 <memcmp+0x12>
  }
  return 0;
 32a:	4501                	li	a0,0
}
 32c:	60a2                	ld	ra,8(sp)
 32e:	6402                	ld	s0,0(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret
      return *p1 - *p2;
 334:	40e7853b          	subw	a0,a5,a4
 338:	bfd5                	j	32c <memcmp+0x28>

000000000000033a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 33a:	1141                	addi	sp,sp,-16
 33c:	e406                	sd	ra,8(sp)
 33e:	e022                	sd	s0,0(sp)
 340:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 342:	f67ff0ef          	jal	2a8 <memmove>
}
 346:	60a2                	ld	ra,8(sp)
 348:	6402                	ld	s0,0(sp)
 34a:	0141                	addi	sp,sp,16
 34c:	8082                	ret

000000000000034e <sbrk>:

char *
sbrk(int n) {
 34e:	1141                	addi	sp,sp,-16
 350:	e406                	sd	ra,8(sp)
 352:	e022                	sd	s0,0(sp)
 354:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 356:	4585                	li	a1,1
 358:	0b2000ef          	jal	40a <sys_sbrk>
}
 35c:	60a2                	ld	ra,8(sp)
 35e:	6402                	ld	s0,0(sp)
 360:	0141                	addi	sp,sp,16
 362:	8082                	ret

0000000000000364 <sbrklazy>:

char *
sbrklazy(int n) {
 364:	1141                	addi	sp,sp,-16
 366:	e406                	sd	ra,8(sp)
 368:	e022                	sd	s0,0(sp)
 36a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 36c:	4589                	li	a1,2
 36e:	09c000ef          	jal	40a <sys_sbrk>
}
 372:	60a2                	ld	ra,8(sp)
 374:	6402                	ld	s0,0(sp)
 376:	0141                	addi	sp,sp,16
 378:	8082                	ret

000000000000037a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 37a:	4885                	li	a7,1
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <exit>:
.global exit
exit:
 li a7, SYS_exit
 382:	4889                	li	a7,2
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <wait>:
.global wait
wait:
 li a7, SYS_wait
 38a:	488d                	li	a7,3
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 392:	4891                	li	a7,4
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <read>:
.global read
read:
 li a7, SYS_read
 39a:	4895                	li	a7,5
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <write>:
.global write
write:
 li a7, SYS_write
 3a2:	48c1                	li	a7,16
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <close>:
.global close
close:
 li a7, SYS_close
 3aa:	48d5                	li	a7,21
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3b2:	4899                	li	a7,6
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ba:	489d                	li	a7,7
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <open>:
.global open
open:
 li a7, SYS_open
 3c2:	48bd                	li	a7,15
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3ca:	48c5                	li	a7,17
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3d2:	48c9                	li	a7,18
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3da:	48a1                	li	a7,8
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <link>:
.global link
link:
 li a7, SYS_link
 3e2:	48cd                	li	a7,19
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3ea:	48d1                	li	a7,20
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3f2:	48a5                	li	a7,9
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <dup>:
.global dup
dup:
 li a7, SYS_dup
 3fa:	48a9                	li	a7,10
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 402:	48ad                	li	a7,11
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 40a:	48b1                	li	a7,12
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <pause>:
.global pause
pause:
 li a7, SYS_pause
 412:	48b5                	li	a7,13
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 41a:	48b9                	li	a7,14
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <bind>:
.global bind
bind:
 li a7, SYS_bind
 422:	48f5                	li	a7,29
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 42a:	48f9                	li	a7,30
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <send>:
.global send
send:
 li a7, SYS_send
 432:	48fd                	li	a7,31
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <recv>:
.global recv
recv:
 li a7, SYS_recv
 43a:	02000893          	li	a7,32
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 444:	02100893          	li	a7,33
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 44e:	02200893          	li	a7,34
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <rwlktest>:
.global rwlktest
rwlktest:
 li a7, SYS_rwlktest
 458:	02300893          	li	a7,35
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <cpupin>:
.global cpupin
cpupin:
 li a7, SYS_cpupin
 462:	02400893          	li	a7,36
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 46c:	1101                	addi	sp,sp,-32
 46e:	ec06                	sd	ra,24(sp)
 470:	e822                	sd	s0,16(sp)
 472:	1000                	addi	s0,sp,32
 474:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 478:	4605                	li	a2,1
 47a:	fef40593          	addi	a1,s0,-17
 47e:	f25ff0ef          	jal	3a2 <write>
}
 482:	60e2                	ld	ra,24(sp)
 484:	6442                	ld	s0,16(sp)
 486:	6105                	addi	sp,sp,32
 488:	8082                	ret

000000000000048a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 48a:	715d                	addi	sp,sp,-80
 48c:	e486                	sd	ra,72(sp)
 48e:	e0a2                	sd	s0,64(sp)
 490:	f84a                	sd	s2,48(sp)
 492:	f44e                	sd	s3,40(sp)
 494:	0880                	addi	s0,sp,80
 496:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 498:	00d036b3          	snez	a3,a3
 49c:	03f5d793          	srli	a5,a1,0x3f
 4a0:	8efd                	and	a3,a3,a5
  neg = 0;
 4a2:	4301                	li	t1,0
  if(sgn && xx < 0){
 4a4:	c681                	beqz	a3,4ac <printint+0x22>
    neg = 1;
    x = -xx;
 4a6:	40b005b3          	neg	a1,a1
    neg = 1;
 4aa:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 4ac:	fb840993          	addi	s3,s0,-72
  neg = 0;
 4b0:	86ce                	mv	a3,s3
  i = 0;
 4b2:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4b4:	00000817          	auipc	a6,0x0
 4b8:	64480813          	addi	a6,a6,1604 # af8 <digits>
 4bc:	88ba                	mv	a7,a4
 4be:	0017051b          	addiw	a0,a4,1
 4c2:	872a                	mv	a4,a0
 4c4:	02c5f7b3          	remu	a5,a1,a2
 4c8:	97c2                	add	a5,a5,a6
 4ca:	0007c783          	lbu	a5,0(a5)
 4ce:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4d2:	87ae                	mv	a5,a1
 4d4:	02c5d5b3          	divu	a1,a1,a2
 4d8:	0685                	addi	a3,a3,1
 4da:	fec7f1e3          	bgeu	a5,a2,4bc <printint+0x32>
  if(neg)
 4de:	00030b63          	beqz	t1,4f4 <printint+0x6a>
    buf[i++] = '-';
 4e2:	fd040793          	addi	a5,s0,-48
 4e6:	953e                	add	a0,a0,a5
 4e8:	02d00793          	li	a5,45
 4ec:	fef50423          	sb	a5,-24(a0)
 4f0:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 4f4:	02e05563          	blez	a4,51e <printint+0x94>
 4f8:	fc26                	sd	s1,56(sp)
 4fa:	377d                	addiw	a4,a4,-1
 4fc:	00e984b3          	add	s1,s3,a4
 500:	19fd                	addi	s3,s3,-1
 502:	99ba                	add	s3,s3,a4
 504:	1702                	slli	a4,a4,0x20
 506:	9301                	srli	a4,a4,0x20
 508:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 50c:	0004c583          	lbu	a1,0(s1)
 510:	854a                	mv	a0,s2
 512:	f5bff0ef          	jal	46c <putc>
  while(--i >= 0)
 516:	14fd                	addi	s1,s1,-1
 518:	ff349ae3          	bne	s1,s3,50c <printint+0x82>
 51c:	74e2                	ld	s1,56(sp)
}
 51e:	60a6                	ld	ra,72(sp)
 520:	6406                	ld	s0,64(sp)
 522:	7942                	ld	s2,48(sp)
 524:	79a2                	ld	s3,40(sp)
 526:	6161                	addi	sp,sp,80
 528:	8082                	ret

000000000000052a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 52a:	711d                	addi	sp,sp,-96
 52c:	ec86                	sd	ra,88(sp)
 52e:	e8a2                	sd	s0,80(sp)
 530:	e4a6                	sd	s1,72(sp)
 532:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 534:	0005c483          	lbu	s1,0(a1)
 538:	2a048063          	beqz	s1,7d8 <vprintf+0x2ae>
 53c:	e0ca                	sd	s2,64(sp)
 53e:	fc4e                	sd	s3,56(sp)
 540:	f852                	sd	s4,48(sp)
 542:	f456                	sd	s5,40(sp)
 544:	f05a                	sd	s6,32(sp)
 546:	ec5e                	sd	s7,24(sp)
 548:	e862                	sd	s8,16(sp)
 54a:	8b2a                	mv	s6,a0
 54c:	8a2e                	mv	s4,a1
 54e:	8bb2                	mv	s7,a2
  state = 0;
 550:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 552:	4901                	li	s2,0
 554:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 556:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 55a:	06400c13          	li	s8,100
 55e:	a00d                	j	580 <vprintf+0x56>
        putc(fd, c0);
 560:	85a6                	mv	a1,s1
 562:	855a                	mv	a0,s6
 564:	f09ff0ef          	jal	46c <putc>
 568:	a019                	j	56e <vprintf+0x44>
    } else if(state == '%'){
 56a:	03598363          	beq	s3,s5,590 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 56e:	0019079b          	addiw	a5,s2,1
 572:	893e                	mv	s2,a5
 574:	873e                	mv	a4,a5
 576:	97d2                	add	a5,a5,s4
 578:	0007c483          	lbu	s1,0(a5)
 57c:	24048763          	beqz	s1,7ca <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 580:	0004879b          	sext.w	a5,s1
    if(state == 0){
 584:	fe0993e3          	bnez	s3,56a <vprintf+0x40>
      if(c0 == '%'){
 588:	fd579ce3          	bne	a5,s5,560 <vprintf+0x36>
        state = '%';
 58c:	89be                	mv	s3,a5
 58e:	b7c5                	j	56e <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 590:	00ea06b3          	add	a3,s4,a4
 594:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 598:	24060563          	beqz	a2,7e2 <vprintf+0x2b8>
      if(c0 == 'd'){
 59c:	0b878763          	beq	a5,s8,64a <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5a0:	f9478693          	addi	a3,a5,-108
 5a4:	0016b693          	seqz	a3,a3
 5a8:	f9c60593          	addi	a1,a2,-100
 5ac:	0015b593          	seqz	a1,a1
 5b0:	8df5                	and	a1,a1,a3
 5b2:	e9c5                	bnez	a1,662 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 5b4:	9752                	add	a4,a4,s4
 5b6:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5ba:	f9460713          	addi	a4,a2,-108
 5be:	00173713          	seqz	a4,a4
 5c2:	8f75                	and	a4,a4,a3
 5c4:	f9c50593          	addi	a1,a0,-100
 5c8:	0015b593          	seqz	a1,a1
 5cc:	8df9                	and	a1,a1,a4
 5ce:	e5dd                	bnez	a1,67c <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5d0:	07500593          	li	a1,117
 5d4:	0cb78163          	beq	a5,a1,696 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 5d8:	f8b60593          	addi	a1,a2,-117
 5dc:	0015b593          	seqz	a1,a1
 5e0:	8df5                	and	a1,a1,a3
 5e2:	e5f1                	bnez	a1,6ae <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 5e4:	f8b50593          	addi	a1,a0,-117
 5e8:	0015b593          	seqz	a1,a1
 5ec:	8df9                	and	a1,a1,a4
 5ee:	ede9                	bnez	a1,6c8 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5f0:	07800593          	li	a1,120
 5f4:	0eb78763          	beq	a5,a1,6e2 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 5f8:	f8860613          	addi	a2,a2,-120
 5fc:	00163613          	seqz	a2,a2
 600:	8ef1                	and	a3,a3,a2
 602:	0e069c63          	bnez	a3,6fa <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 606:	f8850513          	addi	a0,a0,-120
 60a:	00153513          	seqz	a0,a0
 60e:	8f69                	and	a4,a4,a0
 610:	10071263          	bnez	a4,714 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 614:	07000713          	li	a4,112
 618:	10e78a63          	beq	a5,a4,72c <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 61c:	06300713          	li	a4,99
 620:	14e78a63          	beq	a5,a4,774 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 624:	07300713          	li	a4,115
 628:	16e78063          	beq	a5,a4,788 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 62c:	02500713          	li	a4,37
 630:	18e78863          	beq	a5,a4,7c0 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 634:	02500593          	li	a1,37
 638:	855a                	mv	a0,s6
 63a:	e33ff0ef          	jal	46c <putc>
        putc(fd, c0);
 63e:	85a6                	mv	a1,s1
 640:	855a                	mv	a0,s6
 642:	e2bff0ef          	jal	46c <putc>
      }

      state = 0;
 646:	4981                	li	s3,0
 648:	b71d                	j	56e <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 64a:	008b8493          	addi	s1,s7,8
 64e:	4685                	li	a3,1
 650:	4629                	li	a2,10
 652:	000ba583          	lw	a1,0(s7)
 656:	855a                	mv	a0,s6
 658:	e33ff0ef          	jal	48a <printint>
 65c:	8ba6                	mv	s7,s1
      state = 0;
 65e:	4981                	li	s3,0
 660:	b739                	j	56e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 662:	008b8493          	addi	s1,s7,8
 666:	4685                	li	a3,1
 668:	4629                	li	a2,10
 66a:	000bb583          	ld	a1,0(s7)
 66e:	855a                	mv	a0,s6
 670:	e1bff0ef          	jal	48a <printint>
        i += 1;
 674:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 676:	8ba6                	mv	s7,s1
      state = 0;
 678:	4981                	li	s3,0
 67a:	bdd5                	j	56e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 67c:	008b8493          	addi	s1,s7,8
 680:	4685                	li	a3,1
 682:	4629                	li	a2,10
 684:	000bb583          	ld	a1,0(s7)
 688:	855a                	mv	a0,s6
 68a:	e01ff0ef          	jal	48a <printint>
        i += 2;
 68e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 690:	8ba6                	mv	s7,s1
      state = 0;
 692:	4981                	li	s3,0
        i += 2;
 694:	bde9                	j	56e <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 696:	008b8493          	addi	s1,s7,8
 69a:	4681                	li	a3,0
 69c:	4629                	li	a2,10
 69e:	000be583          	lwu	a1,0(s7)
 6a2:	855a                	mv	a0,s6
 6a4:	de7ff0ef          	jal	48a <printint>
 6a8:	8ba6                	mv	s7,s1
      state = 0;
 6aa:	4981                	li	s3,0
 6ac:	b5c9                	j	56e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ae:	008b8493          	addi	s1,s7,8
 6b2:	4681                	li	a3,0
 6b4:	4629                	li	a2,10
 6b6:	000bb583          	ld	a1,0(s7)
 6ba:	855a                	mv	a0,s6
 6bc:	dcfff0ef          	jal	48a <printint>
        i += 1;
 6c0:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6c2:	8ba6                	mv	s7,s1
      state = 0;
 6c4:	4981                	li	s3,0
 6c6:	b565                	j	56e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6c8:	008b8493          	addi	s1,s7,8
 6cc:	4681                	li	a3,0
 6ce:	4629                	li	a2,10
 6d0:	000bb583          	ld	a1,0(s7)
 6d4:	855a                	mv	a0,s6
 6d6:	db5ff0ef          	jal	48a <printint>
        i += 2;
 6da:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6dc:	8ba6                	mv	s7,s1
      state = 0;
 6de:	4981                	li	s3,0
        i += 2;
 6e0:	b579                	j	56e <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6e2:	008b8493          	addi	s1,s7,8
 6e6:	4681                	li	a3,0
 6e8:	4641                	li	a2,16
 6ea:	000be583          	lwu	a1,0(s7)
 6ee:	855a                	mv	a0,s6
 6f0:	d9bff0ef          	jal	48a <printint>
 6f4:	8ba6                	mv	s7,s1
      state = 0;
 6f6:	4981                	li	s3,0
 6f8:	bd9d                	j	56e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6fa:	008b8493          	addi	s1,s7,8
 6fe:	4681                	li	a3,0
 700:	4641                	li	a2,16
 702:	000bb583          	ld	a1,0(s7)
 706:	855a                	mv	a0,s6
 708:	d83ff0ef          	jal	48a <printint>
        i += 1;
 70c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 70e:	8ba6                	mv	s7,s1
      state = 0;
 710:	4981                	li	s3,0
 712:	bdb1                	j	56e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 714:	008b8493          	addi	s1,s7,8
 718:	4641                	li	a2,16
 71a:	000bb583          	ld	a1,0(s7)
 71e:	855a                	mv	a0,s6
 720:	d6bff0ef          	jal	48a <printint>
        i += 2;
 724:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 726:	8ba6                	mv	s7,s1
      state = 0;
 728:	4981                	li	s3,0
        i += 2;
 72a:	b591                	j	56e <vprintf+0x44>
 72c:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 72e:	008b8793          	addi	a5,s7,8
 732:	8cbe                	mv	s9,a5
 734:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 738:	03000593          	li	a1,48
 73c:	855a                	mv	a0,s6
 73e:	d2fff0ef          	jal	46c <putc>
  putc(fd, 'x');
 742:	07800593          	li	a1,120
 746:	855a                	mv	a0,s6
 748:	d25ff0ef          	jal	46c <putc>
 74c:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 74e:	00000b97          	auipc	s7,0x0
 752:	3aab8b93          	addi	s7,s7,938 # af8 <digits>
 756:	03c9d793          	srli	a5,s3,0x3c
 75a:	97de                	add	a5,a5,s7
 75c:	0007c583          	lbu	a1,0(a5)
 760:	855a                	mv	a0,s6
 762:	d0bff0ef          	jal	46c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 766:	0992                	slli	s3,s3,0x4
 768:	34fd                	addiw	s1,s1,-1
 76a:	f4f5                	bnez	s1,756 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 76c:	8be6                	mv	s7,s9
      state = 0;
 76e:	4981                	li	s3,0
 770:	6ca2                	ld	s9,8(sp)
 772:	bbf5                	j	56e <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 774:	008b8493          	addi	s1,s7,8
 778:	000bc583          	lbu	a1,0(s7)
 77c:	855a                	mv	a0,s6
 77e:	cefff0ef          	jal	46c <putc>
 782:	8ba6                	mv	s7,s1
      state = 0;
 784:	4981                	li	s3,0
 786:	b3e5                	j	56e <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 788:	008b8993          	addi	s3,s7,8
 78c:	000bb483          	ld	s1,0(s7)
 790:	cc91                	beqz	s1,7ac <vprintf+0x282>
        for(; *s; s++)
 792:	0004c583          	lbu	a1,0(s1)
 796:	c195                	beqz	a1,7ba <vprintf+0x290>
          putc(fd, *s);
 798:	855a                	mv	a0,s6
 79a:	cd3ff0ef          	jal	46c <putc>
        for(; *s; s++)
 79e:	0485                	addi	s1,s1,1
 7a0:	0004c583          	lbu	a1,0(s1)
 7a4:	f9f5                	bnez	a1,798 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 7a6:	8bce                	mv	s7,s3
      state = 0;
 7a8:	4981                	li	s3,0
 7aa:	b3d1                	j	56e <vprintf+0x44>
          s = "(null)";
 7ac:	00000497          	auipc	s1,0x0
 7b0:	32c48493          	addi	s1,s1,812 # ad8 <statistics+0x108>
        for(; *s; s++)
 7b4:	02800593          	li	a1,40
 7b8:	b7c5                	j	798 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 7ba:	8bce                	mv	s7,s3
      state = 0;
 7bc:	4981                	li	s3,0
 7be:	bb45                	j	56e <vprintf+0x44>
        putc(fd, '%');
 7c0:	85be                	mv	a1,a5
 7c2:	855a                	mv	a0,s6
 7c4:	ca9ff0ef          	jal	46c <putc>
 7c8:	bdbd                	j	646 <vprintf+0x11c>
 7ca:	6906                	ld	s2,64(sp)
 7cc:	79e2                	ld	s3,56(sp)
 7ce:	7a42                	ld	s4,48(sp)
 7d0:	7aa2                	ld	s5,40(sp)
 7d2:	7b02                	ld	s6,32(sp)
 7d4:	6be2                	ld	s7,24(sp)
 7d6:	6c42                	ld	s8,16(sp)
    }
  }
}
 7d8:	60e6                	ld	ra,88(sp)
 7da:	6446                	ld	s0,80(sp)
 7dc:	64a6                	ld	s1,72(sp)
 7de:	6125                	addi	sp,sp,96
 7e0:	8082                	ret
      if(c0 == 'd'){
 7e2:	06400713          	li	a4,100
 7e6:	e6e782e3          	beq	a5,a4,64a <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 7ea:	f9478693          	addi	a3,a5,-108
 7ee:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 7f2:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7f4:	4701                	li	a4,0
 7f6:	bbe9                	j	5d0 <vprintf+0xa6>

00000000000007f8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7f8:	715d                	addi	sp,sp,-80
 7fa:	ec06                	sd	ra,24(sp)
 7fc:	e822                	sd	s0,16(sp)
 7fe:	1000                	addi	s0,sp,32
 800:	e010                	sd	a2,0(s0)
 802:	e414                	sd	a3,8(s0)
 804:	e818                	sd	a4,16(s0)
 806:	ec1c                	sd	a5,24(s0)
 808:	03043023          	sd	a6,32(s0)
 80c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 810:	8622                	mv	a2,s0
 812:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 816:	d15ff0ef          	jal	52a <vprintf>
}
 81a:	60e2                	ld	ra,24(sp)
 81c:	6442                	ld	s0,16(sp)
 81e:	6161                	addi	sp,sp,80
 820:	8082                	ret

0000000000000822 <printf>:

void
printf(const char *fmt, ...)
{
 822:	711d                	addi	sp,sp,-96
 824:	ec06                	sd	ra,24(sp)
 826:	e822                	sd	s0,16(sp)
 828:	1000                	addi	s0,sp,32
 82a:	e40c                	sd	a1,8(s0)
 82c:	e810                	sd	a2,16(s0)
 82e:	ec14                	sd	a3,24(s0)
 830:	f018                	sd	a4,32(s0)
 832:	f41c                	sd	a5,40(s0)
 834:	03043823          	sd	a6,48(s0)
 838:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 83c:	00840613          	addi	a2,s0,8
 840:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 844:	85aa                	mv	a1,a0
 846:	4505                	li	a0,1
 848:	ce3ff0ef          	jal	52a <vprintf>
}
 84c:	60e2                	ld	ra,24(sp)
 84e:	6442                	ld	s0,16(sp)
 850:	6125                	addi	sp,sp,96
 852:	8082                	ret

0000000000000854 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 854:	1141                	addi	sp,sp,-16
 856:	e406                	sd	ra,8(sp)
 858:	e022                	sd	s0,0(sp)
 85a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 85c:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 860:	00000797          	auipc	a5,0x0
 864:	7b07b783          	ld	a5,1968(a5) # 1010 <freep>
 868:	a095                	j	8cc <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 86a:	ff852583          	lw	a1,-8(a0)
 86e:	6390                	ld	a2,0(a5)
 870:	02059813          	slli	a6,a1,0x20
 874:	01c85693          	srli	a3,a6,0x1c
 878:	96ba                	add	a3,a3,a4
 87a:	02d60563          	beq	a2,a3,8a4 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 87e:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 882:	4790                	lw	a2,8(a5)
 884:	02061593          	slli	a1,a2,0x20
 888:	01c5d693          	srli	a3,a1,0x1c
 88c:	96be                	add	a3,a3,a5
 88e:	02d70263          	beq	a4,a3,8b2 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 892:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 894:	00000717          	auipc	a4,0x0
 898:	76f73e23          	sd	a5,1916(a4) # 1010 <freep>
}
 89c:	60a2                	ld	ra,8(sp)
 89e:	6402                	ld	s0,0(sp)
 8a0:	0141                	addi	sp,sp,16
 8a2:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 8a4:	4614                	lw	a3,8(a2)
 8a6:	9ead                	addw	a3,a3,a1
 8a8:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ac:	6394                	ld	a3,0(a5)
 8ae:	6290                	ld	a2,0(a3)
 8b0:	b7f9                	j	87e <free+0x2a>
    p->s.size += bp->s.size;
 8b2:	ff852703          	lw	a4,-8(a0)
 8b6:	9f31                	addw	a4,a4,a2
 8b8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8ba:	ff053703          	ld	a4,-16(a0)
 8be:	bfd1                	j	892 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c0:	6394                	ld	a3,0(a5)
 8c2:	00d7e463          	bltu	a5,a3,8ca <free+0x76>
 8c6:	fad762e3          	bltu	a4,a3,86a <free+0x16>
 8ca:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8cc:	fee7fae3          	bgeu	a5,a4,8c0 <free+0x6c>
 8d0:	6394                	ld	a3,0(a5)
 8d2:	f8d76ce3          	bltu	a4,a3,86a <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d6:	f8d7fae3          	bgeu	a5,a3,86a <free+0x16>
 8da:	87b6                	mv	a5,a3
 8dc:	bfc5                	j	8cc <free+0x78>

00000000000008de <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8de:	7139                	addi	sp,sp,-64
 8e0:	fc06                	sd	ra,56(sp)
 8e2:	f822                	sd	s0,48(sp)
 8e4:	f04a                	sd	s2,32(sp)
 8e6:	ec4e                	sd	s3,24(sp)
 8e8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8ea:	02051993          	slli	s3,a0,0x20
 8ee:	0209d993          	srli	s3,s3,0x20
 8f2:	09bd                	addi	s3,s3,15
 8f4:	0049d993          	srli	s3,s3,0x4
 8f8:	2985                	addiw	s3,s3,1
 8fa:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8fc:	00000517          	auipc	a0,0x0
 900:	71453503          	ld	a0,1812(a0) # 1010 <freep>
 904:	c905                	beqz	a0,934 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 906:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 908:	4798                	lw	a4,8(a5)
 90a:	09377663          	bgeu	a4,s3,996 <malloc+0xb8>
 90e:	f426                	sd	s1,40(sp)
 910:	e852                	sd	s4,16(sp)
 912:	e456                	sd	s5,8(sp)
 914:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 916:	8a4e                	mv	s4,s3
 918:	6705                	lui	a4,0x1
 91a:	00e9f363          	bgeu	s3,a4,920 <malloc+0x42>
 91e:	6a05                	lui	s4,0x1
 920:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 924:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 928:	00000497          	auipc	s1,0x0
 92c:	6e848493          	addi	s1,s1,1768 # 1010 <freep>
  if(p == SBRK_ERROR)
 930:	5afd                	li	s5,-1
 932:	a83d                	j	970 <malloc+0x92>
 934:	f426                	sd	s1,40(sp)
 936:	e852                	sd	s4,16(sp)
 938:	e456                	sd	s5,8(sp)
 93a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 93c:	00000797          	auipc	a5,0x0
 940:	6e478793          	addi	a5,a5,1764 # 1020 <base>
 944:	00000717          	auipc	a4,0x0
 948:	6cf73623          	sd	a5,1740(a4) # 1010 <freep>
 94c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 94e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 952:	b7d1                	j	916 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 954:	6398                	ld	a4,0(a5)
 956:	e118                	sd	a4,0(a0)
 958:	a899                	j	9ae <malloc+0xd0>
  hp->s.size = nu;
 95a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 95e:	0541                	addi	a0,a0,16
 960:	ef5ff0ef          	jal	854 <free>
  return freep;
 964:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 966:	c125                	beqz	a0,9c6 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 968:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 96a:	4798                	lw	a4,8(a5)
 96c:	03277163          	bgeu	a4,s2,98e <malloc+0xb0>
    if(p == freep)
 970:	6098                	ld	a4,0(s1)
 972:	853e                	mv	a0,a5
 974:	fef71ae3          	bne	a4,a5,968 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 978:	8552                	mv	a0,s4
 97a:	9d5ff0ef          	jal	34e <sbrk>
  if(p == SBRK_ERROR)
 97e:	fd551ee3          	bne	a0,s5,95a <malloc+0x7c>
        return 0;
 982:	4501                	li	a0,0
 984:	74a2                	ld	s1,40(sp)
 986:	6a42                	ld	s4,16(sp)
 988:	6aa2                	ld	s5,8(sp)
 98a:	6b02                	ld	s6,0(sp)
 98c:	a03d                	j	9ba <malloc+0xdc>
 98e:	74a2                	ld	s1,40(sp)
 990:	6a42                	ld	s4,16(sp)
 992:	6aa2                	ld	s5,8(sp)
 994:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 996:	fae90fe3          	beq	s2,a4,954 <malloc+0x76>
        p->s.size -= nunits;
 99a:	4137073b          	subw	a4,a4,s3
 99e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9a0:	02071693          	slli	a3,a4,0x20
 9a4:	01c6d713          	srli	a4,a3,0x1c
 9a8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9aa:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9ae:	00000717          	auipc	a4,0x0
 9b2:	66a73123          	sd	a0,1634(a4) # 1010 <freep>
      return (void*)(p + 1);
 9b6:	01078513          	addi	a0,a5,16
  }
}
 9ba:	70e2                	ld	ra,56(sp)
 9bc:	7442                	ld	s0,48(sp)
 9be:	7902                	ld	s2,32(sp)
 9c0:	69e2                	ld	s3,24(sp)
 9c2:	6121                	addi	sp,sp,64
 9c4:	8082                	ret
 9c6:	74a2                	ld	s1,40(sp)
 9c8:	6a42                	ld	s4,16(sp)
 9ca:	6aa2                	ld	s5,8(sp)
 9cc:	6b02                	ld	s6,0(sp)
 9ce:	b7f5                	j	9ba <malloc+0xdc>

00000000000009d0 <statistics>:
#include "kernel/fcntl.h"
#include "user/user.h"

int
statistics(void *buf, int sz)
{
 9d0:	7179                	addi	sp,sp,-48
 9d2:	f406                	sd	ra,40(sp)
 9d4:	f022                	sd	s0,32(sp)
 9d6:	ec26                	sd	s1,24(sp)
 9d8:	e84a                	sd	s2,16(sp)
 9da:	e44e                	sd	s3,8(sp)
 9dc:	e052                	sd	s4,0(sp)
 9de:	1800                	addi	s0,sp,48
 9e0:	8a2a                	mv	s4,a0
 9e2:	892e                	mv	s2,a1
  int fd, i, n;
  
  fd = open("statistics", O_RDONLY);
 9e4:	4581                	li	a1,0
 9e6:	00000517          	auipc	a0,0x0
 9ea:	07250513          	addi	a0,a0,114 # a58 <statistics+0x88>
 9ee:	9d5ff0ef          	jal	3c2 <open>
  if(fd < 0) {
 9f2:	02054e63          	bltz	a0,a2e <statistics+0x5e>
 9f6:	89aa                	mv	s3,a0
      fprintf(2, "stats: open failed\n");
      exit(1);
  }
  for (i = 0; i < sz; ) {
 9f8:	4481                	li	s1,0
 9fa:	01205e63          	blez	s2,a16 <statistics+0x46>
    if ((n = read(fd, buf+i, sz-i)) < 0) {
 9fe:	4099063b          	subw	a2,s2,s1
 a02:	009a05b3          	add	a1,s4,s1
 a06:	854e                	mv	a0,s3
 a08:	993ff0ef          	jal	39a <read>
 a0c:	00054563          	bltz	a0,a16 <statistics+0x46>
      break;
    }
    i += n;
 a10:	9ca9                	addw	s1,s1,a0
  for (i = 0; i < sz; ) {
 a12:	ff24c6e3          	blt	s1,s2,9fe <statistics+0x2e>
  }
  close(fd);
 a16:	854e                	mv	a0,s3
 a18:	993ff0ef          	jal	3aa <close>
  return i;
}
 a1c:	8526                	mv	a0,s1
 a1e:	70a2                	ld	ra,40(sp)
 a20:	7402                	ld	s0,32(sp)
 a22:	64e2                	ld	s1,24(sp)
 a24:	6942                	ld	s2,16(sp)
 a26:	69a2                	ld	s3,8(sp)
 a28:	6a02                	ld	s4,0(sp)
 a2a:	6145                	addi	sp,sp,48
 a2c:	8082                	ret
      fprintf(2, "stats: open failed\n");
 a2e:	00000597          	auipc	a1,0x0
 a32:	0b258593          	addi	a1,a1,178 # ae0 <statistics+0x110>
 a36:	4509                	li	a0,2
 a38:	dc1ff0ef          	jal	7f8 <fprintf>
      exit(1);
 a3c:	4505                	li	a0,1
 a3e:	945ff0ef          	jal	382 <exit>
