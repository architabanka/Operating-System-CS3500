
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
  12:	97250513          	addi	a0,a0,-1678 # 980 <malloc+0xf2>
  16:	39e000ef          	jal	3b4 <open>
  1a:	04054563          	bltz	a0,64 <main+0x64>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  1e:	4501                	li	a0,0
  20:	3cc000ef          	jal	3ec <dup>
  dup(0);  // stderr
  24:	4501                	li	a0,0
  26:	3c6000ef          	jal	3ec <dup>

  for(;;){
    printf("init: starting sh\n");
  2a:	00001917          	auipc	s2,0x1
  2e:	95e90913          	addi	s2,s2,-1698 # 988 <malloc+0xfa>
  32:	854a                	mv	a0,s2
  34:	79e000ef          	jal	7d2 <printf>
    pid = fork();
  38:	334000ef          	jal	36c <fork>
  3c:	84aa                	mv	s1,a0
    if(pid < 0){
  3e:	04054363          	bltz	a0,84 <main+0x84>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  42:	c931                	beqz	a0,96 <main+0x96>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  44:	4501                	li	a0,0
  46:	336000ef          	jal	37c <wait>
      if(wpid == pid){
  4a:	fea484e3          	beq	s1,a0,32 <main+0x32>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  4e:	fe055be3          	bgez	a0,44 <main+0x44>
        printf("init: wait returned an error\n");
  52:	00001517          	auipc	a0,0x1
  56:	98650513          	addi	a0,a0,-1658 # 9d8 <malloc+0x14a>
  5a:	778000ef          	jal	7d2 <printf>
        exit(1);
  5e:	4505                	li	a0,1
  60:	314000ef          	jal	374 <exit>
    mknod("console", CONSOLE, 0);
  64:	4601                	li	a2,0
  66:	4585                	li	a1,1
  68:	00001517          	auipc	a0,0x1
  6c:	91850513          	addi	a0,a0,-1768 # 980 <malloc+0xf2>
  70:	34c000ef          	jal	3bc <mknod>
    open("console", O_RDWR);
  74:	4589                	li	a1,2
  76:	00001517          	auipc	a0,0x1
  7a:	90a50513          	addi	a0,a0,-1782 # 980 <malloc+0xf2>
  7e:	336000ef          	jal	3b4 <open>
  82:	bf71                	j	1e <main+0x1e>
      printf("init: fork failed\n");
  84:	00001517          	auipc	a0,0x1
  88:	91c50513          	addi	a0,a0,-1764 # 9a0 <malloc+0x112>
  8c:	746000ef          	jal	7d2 <printf>
      exit(1);
  90:	4505                	li	a0,1
  92:	2e2000ef          	jal	374 <exit>
      exec("sh", argv);
  96:	00001597          	auipc	a1,0x1
  9a:	f6a58593          	addi	a1,a1,-150 # 1000 <argv>
  9e:	00001517          	auipc	a0,0x1
  a2:	91a50513          	addi	a0,a0,-1766 # 9b8 <malloc+0x12a>
  a6:	306000ef          	jal	3ac <exec>
      printf("init: exec sh failed\n");
  aa:	00001517          	auipc	a0,0x1
  ae:	91650513          	addi	a0,a0,-1770 # 9c0 <malloc+0x132>
  b2:	720000ef          	jal	7d2 <printf>
      exit(1);
  b6:	4505                	li	a0,1
  b8:	2bc000ef          	jal	374 <exit>

00000000000000bc <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  bc:	1141                	addi	sp,sp,-16
  be:	e406                	sd	ra,8(sp)
  c0:	e022                	sd	s0,0(sp)
  c2:	0800                	addi	s0,sp,16
  extern int main();
  main();
  c4:	f3dff0ef          	jal	0 <main>
  exit(0);
  c8:	4501                	li	a0,0
  ca:	2aa000ef          	jal	374 <exit>

00000000000000ce <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  ce:	1141                	addi	sp,sp,-16
  d0:	e406                	sd	ra,8(sp)
  d2:	e022                	sd	s0,0(sp)
  d4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  d6:	87aa                	mv	a5,a0
  d8:	0585                	addi	a1,a1,1
  da:	0785                	addi	a5,a5,1
  dc:	fff5c703          	lbu	a4,-1(a1)
  e0:	fee78fa3          	sb	a4,-1(a5)
  e4:	fb75                	bnez	a4,d8 <strcpy+0xa>
    ;
  return os;
}
  e6:	60a2                	ld	ra,8(sp)
  e8:	6402                	ld	s0,0(sp)
  ea:	0141                	addi	sp,sp,16
  ec:	8082                	ret

00000000000000ee <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ee:	1141                	addi	sp,sp,-16
  f0:	e406                	sd	ra,8(sp)
  f2:	e022                	sd	s0,0(sp)
  f4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  f6:	00054783          	lbu	a5,0(a0)
  fa:	cb91                	beqz	a5,10e <strcmp+0x20>
  fc:	0005c703          	lbu	a4,0(a1)
 100:	00f71763          	bne	a4,a5,10e <strcmp+0x20>
    p++, q++;
 104:	0505                	addi	a0,a0,1
 106:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 108:	00054783          	lbu	a5,0(a0)
 10c:	fbe5                	bnez	a5,fc <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 10e:	0005c503          	lbu	a0,0(a1)
}
 112:	40a7853b          	subw	a0,a5,a0
 116:	60a2                	ld	ra,8(sp)
 118:	6402                	ld	s0,0(sp)
 11a:	0141                	addi	sp,sp,16
 11c:	8082                	ret

000000000000011e <strlen>:

uint
strlen(const char *s)
{
 11e:	1141                	addi	sp,sp,-16
 120:	e406                	sd	ra,8(sp)
 122:	e022                	sd	s0,0(sp)
 124:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 126:	00054783          	lbu	a5,0(a0)
 12a:	cf91                	beqz	a5,146 <strlen+0x28>
 12c:	00150793          	addi	a5,a0,1
 130:	86be                	mv	a3,a5
 132:	0785                	addi	a5,a5,1
 134:	fff7c703          	lbu	a4,-1(a5)
 138:	ff65                	bnez	a4,130 <strlen+0x12>
 13a:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 13e:	60a2                	ld	ra,8(sp)
 140:	6402                	ld	s0,0(sp)
 142:	0141                	addi	sp,sp,16
 144:	8082                	ret
  for(n = 0; s[n]; n++)
 146:	4501                	li	a0,0
 148:	bfdd                	j	13e <strlen+0x20>

000000000000014a <memset>:

void*
memset(void *dst, int c, uint n)
{
 14a:	1141                	addi	sp,sp,-16
 14c:	e406                	sd	ra,8(sp)
 14e:	e022                	sd	s0,0(sp)
 150:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 152:	ca19                	beqz	a2,168 <memset+0x1e>
 154:	87aa                	mv	a5,a0
 156:	1602                	slli	a2,a2,0x20
 158:	9201                	srli	a2,a2,0x20
 15a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 15e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 162:	0785                	addi	a5,a5,1
 164:	fee79de3          	bne	a5,a4,15e <memset+0x14>
  }
  return dst;
}
 168:	60a2                	ld	ra,8(sp)
 16a:	6402                	ld	s0,0(sp)
 16c:	0141                	addi	sp,sp,16
 16e:	8082                	ret

0000000000000170 <strchr>:

char*
strchr(const char *s, char c)
{
 170:	1141                	addi	sp,sp,-16
 172:	e406                	sd	ra,8(sp)
 174:	e022                	sd	s0,0(sp)
 176:	0800                	addi	s0,sp,16
  for(; *s; s++)
 178:	00054783          	lbu	a5,0(a0)
 17c:	c799                	beqz	a5,18a <strchr+0x1a>
    if(*s == c)
 17e:	00f58763          	beq	a1,a5,18c <strchr+0x1c>
  for(; *s; s++)
 182:	0505                	addi	a0,a0,1
 184:	00054783          	lbu	a5,0(a0)
 188:	fbfd                	bnez	a5,17e <strchr+0xe>
      return (char*)s;
  return 0;
 18a:	4501                	li	a0,0
}
 18c:	60a2                	ld	ra,8(sp)
 18e:	6402                	ld	s0,0(sp)
 190:	0141                	addi	sp,sp,16
 192:	8082                	ret

0000000000000194 <gets>:

char*
gets(char *buf, int max)
{
 194:	711d                	addi	sp,sp,-96
 196:	ec86                	sd	ra,88(sp)
 198:	e8a2                	sd	s0,80(sp)
 19a:	e4a6                	sd	s1,72(sp)
 19c:	e0ca                	sd	s2,64(sp)
 19e:	fc4e                	sd	s3,56(sp)
 1a0:	f852                	sd	s4,48(sp)
 1a2:	f456                	sd	s5,40(sp)
 1a4:	f05a                	sd	s6,32(sp)
 1a6:	ec5e                	sd	s7,24(sp)
 1a8:	e862                	sd	s8,16(sp)
 1aa:	1080                	addi	s0,sp,96
 1ac:	8baa                	mv	s7,a0
 1ae:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b0:	892a                	mv	s2,a0
 1b2:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1b4:	faf40b13          	addi	s6,s0,-81
 1b8:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 1ba:	8c26                	mv	s8,s1
 1bc:	0014899b          	addiw	s3,s1,1
 1c0:	84ce                	mv	s1,s3
 1c2:	0349d863          	bge	s3,s4,1f2 <gets+0x5e>
    cc = read(0, &c, 1);
 1c6:	8656                	mv	a2,s5
 1c8:	85da                	mv	a1,s6
 1ca:	4501                	li	a0,0
 1cc:	1c0000ef          	jal	38c <read>
    if(cc < 1)
 1d0:	02a05163          	blez	a0,1f2 <gets+0x5e>
      break;
    buf[i++] = c;
 1d4:	faf44783          	lbu	a5,-81(s0)
 1d8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1dc:	0905                	addi	s2,s2,1
 1de:	ff678713          	addi	a4,a5,-10
 1e2:	00173713          	seqz	a4,a4
 1e6:	17cd                	addi	a5,a5,-13
 1e8:	0017b793          	seqz	a5,a5
 1ec:	8fd9                	or	a5,a5,a4
 1ee:	d7f1                	beqz	a5,1ba <gets+0x26>
    buf[i++] = c;
 1f0:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 1f2:	9c5e                	add	s8,s8,s7
 1f4:	000c0023          	sb	zero,0(s8)
  return buf;
}
 1f8:	855e                	mv	a0,s7
 1fa:	60e6                	ld	ra,88(sp)
 1fc:	6446                	ld	s0,80(sp)
 1fe:	64a6                	ld	s1,72(sp)
 200:	6906                	ld	s2,64(sp)
 202:	79e2                	ld	s3,56(sp)
 204:	7a42                	ld	s4,48(sp)
 206:	7aa2                	ld	s5,40(sp)
 208:	7b02                	ld	s6,32(sp)
 20a:	6be2                	ld	s7,24(sp)
 20c:	6c42                	ld	s8,16(sp)
 20e:	6125                	addi	sp,sp,96
 210:	8082                	ret

0000000000000212 <stat>:

int
stat(const char *n, struct stat *st)
{
 212:	1101                	addi	sp,sp,-32
 214:	ec06                	sd	ra,24(sp)
 216:	e822                	sd	s0,16(sp)
 218:	e04a                	sd	s2,0(sp)
 21a:	1000                	addi	s0,sp,32
 21c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 21e:	4581                	li	a1,0
 220:	194000ef          	jal	3b4 <open>
  if(fd < 0)
 224:	02054263          	bltz	a0,248 <stat+0x36>
 228:	e426                	sd	s1,8(sp)
 22a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 22c:	85ca                	mv	a1,s2
 22e:	19e000ef          	jal	3cc <fstat>
 232:	892a                	mv	s2,a0
  close(fd);
 234:	8526                	mv	a0,s1
 236:	166000ef          	jal	39c <close>
  return r;
 23a:	64a2                	ld	s1,8(sp)
}
 23c:	854a                	mv	a0,s2
 23e:	60e2                	ld	ra,24(sp)
 240:	6442                	ld	s0,16(sp)
 242:	6902                	ld	s2,0(sp)
 244:	6105                	addi	sp,sp,32
 246:	8082                	ret
    return -1;
 248:	57fd                	li	a5,-1
 24a:	893e                	mv	s2,a5
 24c:	bfc5                	j	23c <stat+0x2a>

000000000000024e <atoi>:

int
atoi(const char *s)
{
 24e:	1141                	addi	sp,sp,-16
 250:	e406                	sd	ra,8(sp)
 252:	e022                	sd	s0,0(sp)
 254:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 256:	00054683          	lbu	a3,0(a0)
 25a:	fd06879b          	addiw	a5,a3,-48
 25e:	0ff7f793          	zext.b	a5,a5
 262:	4625                	li	a2,9
 264:	02f66963          	bltu	a2,a5,296 <atoi+0x48>
 268:	872a                	mv	a4,a0
  n = 0;
 26a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 26c:	0705                	addi	a4,a4,1
 26e:	0025179b          	slliw	a5,a0,0x2
 272:	9fa9                	addw	a5,a5,a0
 274:	0017979b          	slliw	a5,a5,0x1
 278:	9fb5                	addw	a5,a5,a3
 27a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 27e:	00074683          	lbu	a3,0(a4)
 282:	fd06879b          	addiw	a5,a3,-48
 286:	0ff7f793          	zext.b	a5,a5
 28a:	fef671e3          	bgeu	a2,a5,26c <atoi+0x1e>
  return n;
}
 28e:	60a2                	ld	ra,8(sp)
 290:	6402                	ld	s0,0(sp)
 292:	0141                	addi	sp,sp,16
 294:	8082                	ret
  n = 0;
 296:	4501                	li	a0,0
 298:	bfdd                	j	28e <atoi+0x40>

000000000000029a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 29a:	1141                	addi	sp,sp,-16
 29c:	e406                	sd	ra,8(sp)
 29e:	e022                	sd	s0,0(sp)
 2a0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2a2:	02b57563          	bgeu	a0,a1,2cc <memmove+0x32>
    while(n-- > 0)
 2a6:	00c05f63          	blez	a2,2c4 <memmove+0x2a>
 2aa:	1602                	slli	a2,a2,0x20
 2ac:	9201                	srli	a2,a2,0x20
 2ae:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2b2:	872a                	mv	a4,a0
      *dst++ = *src++;
 2b4:	0585                	addi	a1,a1,1
 2b6:	0705                	addi	a4,a4,1
 2b8:	fff5c683          	lbu	a3,-1(a1)
 2bc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2c0:	fee79ae3          	bne	a5,a4,2b4 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2c4:	60a2                	ld	ra,8(sp)
 2c6:	6402                	ld	s0,0(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret
    while(n-- > 0)
 2cc:	fec05ce3          	blez	a2,2c4 <memmove+0x2a>
    dst += n;
 2d0:	00c50733          	add	a4,a0,a2
    src += n;
 2d4:	95b2                	add	a1,a1,a2
 2d6:	fff6079b          	addiw	a5,a2,-1
 2da:	1782                	slli	a5,a5,0x20
 2dc:	9381                	srli	a5,a5,0x20
 2de:	fff7c793          	not	a5,a5
 2e2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2e4:	15fd                	addi	a1,a1,-1
 2e6:	177d                	addi	a4,a4,-1
 2e8:	0005c683          	lbu	a3,0(a1)
 2ec:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2f0:	fef71ae3          	bne	a4,a5,2e4 <memmove+0x4a>
 2f4:	bfc1                	j	2c4 <memmove+0x2a>

00000000000002f6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2f6:	1141                	addi	sp,sp,-16
 2f8:	e406                	sd	ra,8(sp)
 2fa:	e022                	sd	s0,0(sp)
 2fc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2fe:	ce19                	beqz	a2,31c <memcmp+0x26>
 300:	1602                	slli	a2,a2,0x20
 302:	9201                	srli	a2,a2,0x20
 304:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 308:	00054783          	lbu	a5,0(a0)
 30c:	0005c703          	lbu	a4,0(a1)
 310:	00e79b63          	bne	a5,a4,326 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 314:	0505                	addi	a0,a0,1
    p2++;
 316:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 318:	fed518e3          	bne	a0,a3,308 <memcmp+0x12>
  }
  return 0;
 31c:	4501                	li	a0,0
}
 31e:	60a2                	ld	ra,8(sp)
 320:	6402                	ld	s0,0(sp)
 322:	0141                	addi	sp,sp,16
 324:	8082                	ret
      return *p1 - *p2;
 326:	40e7853b          	subw	a0,a5,a4
 32a:	bfd5                	j	31e <memcmp+0x28>

000000000000032c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 32c:	1141                	addi	sp,sp,-16
 32e:	e406                	sd	ra,8(sp)
 330:	e022                	sd	s0,0(sp)
 332:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 334:	f67ff0ef          	jal	29a <memmove>
}
 338:	60a2                	ld	ra,8(sp)
 33a:	6402                	ld	s0,0(sp)
 33c:	0141                	addi	sp,sp,16
 33e:	8082                	ret

0000000000000340 <sbrk>:

char *
sbrk(int n) {
 340:	1141                	addi	sp,sp,-16
 342:	e406                	sd	ra,8(sp)
 344:	e022                	sd	s0,0(sp)
 346:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 348:	4585                	li	a1,1
 34a:	0b2000ef          	jal	3fc <sys_sbrk>
}
 34e:	60a2                	ld	ra,8(sp)
 350:	6402                	ld	s0,0(sp)
 352:	0141                	addi	sp,sp,16
 354:	8082                	ret

0000000000000356 <sbrklazy>:

char *
sbrklazy(int n) {
 356:	1141                	addi	sp,sp,-16
 358:	e406                	sd	ra,8(sp)
 35a:	e022                	sd	s0,0(sp)
 35c:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 35e:	4589                	li	a1,2
 360:	09c000ef          	jal	3fc <sys_sbrk>
}
 364:	60a2                	ld	ra,8(sp)
 366:	6402                	ld	s0,0(sp)
 368:	0141                	addi	sp,sp,16
 36a:	8082                	ret

000000000000036c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 36c:	4885                	li	a7,1
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <exit>:
.global exit
exit:
 li a7, SYS_exit
 374:	4889                	li	a7,2
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <wait>:
.global wait
wait:
 li a7, SYS_wait
 37c:	488d                	li	a7,3
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 384:	4891                	li	a7,4
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <read>:
.global read
read:
 li a7, SYS_read
 38c:	4895                	li	a7,5
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <write>:
.global write
write:
 li a7, SYS_write
 394:	48c1                	li	a7,16
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <close>:
.global close
close:
 li a7, SYS_close
 39c:	48d5                	li	a7,21
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3a4:	4899                	li	a7,6
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ac:	489d                	li	a7,7
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <open>:
.global open
open:
 li a7, SYS_open
 3b4:	48bd                	li	a7,15
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3bc:	48c5                	li	a7,17
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3c4:	48c9                	li	a7,18
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3cc:	48a1                	li	a7,8
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <link>:
.global link
link:
 li a7, SYS_link
 3d4:	48cd                	li	a7,19
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3dc:	48d1                	li	a7,20
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3e4:	48a5                	li	a7,9
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <dup>:
.global dup
dup:
 li a7, SYS_dup
 3ec:	48a9                	li	a7,10
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3f4:	48ad                	li	a7,11
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3fc:	48b1                	li	a7,12
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <pause>:
.global pause
pause:
 li a7, SYS_pause
 404:	48b5                	li	a7,13
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 40c:	48b9                	li	a7,14
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 414:	1101                	addi	sp,sp,-32
 416:	ec06                	sd	ra,24(sp)
 418:	e822                	sd	s0,16(sp)
 41a:	1000                	addi	s0,sp,32
 41c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 420:	4605                	li	a2,1
 422:	fef40593          	addi	a1,s0,-17
 426:	f6fff0ef          	jal	394 <write>
}
 42a:	60e2                	ld	ra,24(sp)
 42c:	6442                	ld	s0,16(sp)
 42e:	6105                	addi	sp,sp,32
 430:	8082                	ret

0000000000000432 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 432:	715d                	addi	sp,sp,-80
 434:	e486                	sd	ra,72(sp)
 436:	e0a2                	sd	s0,64(sp)
 438:	f84a                	sd	s2,48(sp)
 43a:	f44e                	sd	s3,40(sp)
 43c:	0880                	addi	s0,sp,80
 43e:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 440:	00d036b3          	snez	a3,a3
 444:	03f5d793          	srli	a5,a1,0x3f
 448:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 44a:	0005871b          	sext.w	a4,a1
  neg = 0;
 44e:	4301                	li	t1,0
  if(sgn && xx < 0){
 450:	c681                	beqz	a3,458 <printint+0x26>
    x = -xx;
 452:	40b0073b          	negw	a4,a1
    neg = 1;
 456:	4305                	li	t1,1
  }

  i = 0;
 458:	fb840993          	addi	s3,s0,-72
  neg = 0;
 45c:	85ce                	mv	a1,s3
  i = 0;
 45e:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 460:	00000817          	auipc	a6,0x0
 464:	5a080813          	addi	a6,a6,1440 # a00 <digits>
 468:	88b6                	mv	a7,a3
 46a:	0016851b          	addiw	a0,a3,1
 46e:	86aa                	mv	a3,a0
 470:	02c777bb          	remuw	a5,a4,a2
 474:	1782                	slli	a5,a5,0x20
 476:	9381                	srli	a5,a5,0x20
 478:	97c2                	add	a5,a5,a6
 47a:	0007c783          	lbu	a5,0(a5)
 47e:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 482:	87ba                	mv	a5,a4
 484:	02c7573b          	divuw	a4,a4,a2
 488:	0585                	addi	a1,a1,1
 48a:	fcc7ffe3          	bgeu	a5,a2,468 <printint+0x36>
  if(neg)
 48e:	00030b63          	beqz	t1,4a4 <printint+0x72>
    buf[i++] = '-';
 492:	fd040793          	addi	a5,s0,-48
 496:	953e                	add	a0,a0,a5
 498:	02d00793          	li	a5,45
 49c:	fef50423          	sb	a5,-24(a0)
 4a0:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 4a4:	02d05563          	blez	a3,4ce <printint+0x9c>
 4a8:	fc26                	sd	s1,56(sp)
 4aa:	36fd                	addiw	a3,a3,-1
 4ac:	00d984b3          	add	s1,s3,a3
 4b0:	19fd                	addi	s3,s3,-1
 4b2:	99b6                	add	s3,s3,a3
 4b4:	1682                	slli	a3,a3,0x20
 4b6:	9281                	srli	a3,a3,0x20
 4b8:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 4bc:	0004c583          	lbu	a1,0(s1)
 4c0:	854a                	mv	a0,s2
 4c2:	f53ff0ef          	jal	414 <putc>
  while(--i >= 0)
 4c6:	14fd                	addi	s1,s1,-1
 4c8:	ff349ae3          	bne	s1,s3,4bc <printint+0x8a>
 4cc:	74e2                	ld	s1,56(sp)
}
 4ce:	60a6                	ld	ra,72(sp)
 4d0:	6406                	ld	s0,64(sp)
 4d2:	7942                	ld	s2,48(sp)
 4d4:	79a2                	ld	s3,40(sp)
 4d6:	6161                	addi	sp,sp,80
 4d8:	8082                	ret

00000000000004da <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4da:	711d                	addi	sp,sp,-96
 4dc:	ec86                	sd	ra,88(sp)
 4de:	e8a2                	sd	s0,80(sp)
 4e0:	e4a6                	sd	s1,72(sp)
 4e2:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4e4:	0005c483          	lbu	s1,0(a1)
 4e8:	2a048063          	beqz	s1,788 <vprintf+0x2ae>
 4ec:	e0ca                	sd	s2,64(sp)
 4ee:	fc4e                	sd	s3,56(sp)
 4f0:	f852                	sd	s4,48(sp)
 4f2:	f456                	sd	s5,40(sp)
 4f4:	f05a                	sd	s6,32(sp)
 4f6:	ec5e                	sd	s7,24(sp)
 4f8:	e862                	sd	s8,16(sp)
 4fa:	8b2a                	mv	s6,a0
 4fc:	8a2e                	mv	s4,a1
 4fe:	8bb2                	mv	s7,a2
  state = 0;
 500:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 502:	4901                	li	s2,0
 504:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 506:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 50a:	06400c13          	li	s8,100
 50e:	a00d                	j	530 <vprintf+0x56>
        putc(fd, c0);
 510:	85a6                	mv	a1,s1
 512:	855a                	mv	a0,s6
 514:	f01ff0ef          	jal	414 <putc>
 518:	a019                	j	51e <vprintf+0x44>
    } else if(state == '%'){
 51a:	03598363          	beq	s3,s5,540 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 51e:	0019079b          	addiw	a5,s2,1
 522:	893e                	mv	s2,a5
 524:	873e                	mv	a4,a5
 526:	97d2                	add	a5,a5,s4
 528:	0007c483          	lbu	s1,0(a5)
 52c:	24048763          	beqz	s1,77a <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 530:	0004879b          	sext.w	a5,s1
    if(state == 0){
 534:	fe0993e3          	bnez	s3,51a <vprintf+0x40>
      if(c0 == '%'){
 538:	fd579ce3          	bne	a5,s5,510 <vprintf+0x36>
        state = '%';
 53c:	89be                	mv	s3,a5
 53e:	b7c5                	j	51e <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 540:	00ea06b3          	add	a3,s4,a4
 544:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 548:	24060563          	beqz	a2,792 <vprintf+0x2b8>
      if(c0 == 'd'){
 54c:	0b878763          	beq	a5,s8,5fa <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 550:	f9478693          	addi	a3,a5,-108
 554:	0016b693          	seqz	a3,a3
 558:	f9c60593          	addi	a1,a2,-100
 55c:	0015b593          	seqz	a1,a1
 560:	8df5                	and	a1,a1,a3
 562:	e9c5                	bnez	a1,612 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 564:	9752                	add	a4,a4,s4
 566:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 56a:	f9460713          	addi	a4,a2,-108
 56e:	00173713          	seqz	a4,a4
 572:	8f75                	and	a4,a4,a3
 574:	f9c50593          	addi	a1,a0,-100
 578:	0015b593          	seqz	a1,a1
 57c:	8df9                	and	a1,a1,a4
 57e:	e5dd                	bnez	a1,62c <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 580:	07500593          	li	a1,117
 584:	0cb78163          	beq	a5,a1,646 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 588:	f8b60593          	addi	a1,a2,-117
 58c:	0015b593          	seqz	a1,a1
 590:	8df5                	and	a1,a1,a3
 592:	e5f1                	bnez	a1,65e <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 594:	f8b50593          	addi	a1,a0,-117
 598:	0015b593          	seqz	a1,a1
 59c:	8df9                	and	a1,a1,a4
 59e:	ede9                	bnez	a1,678 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5a0:	07800593          	li	a1,120
 5a4:	0eb78763          	beq	a5,a1,692 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 5a8:	f8860613          	addi	a2,a2,-120
 5ac:	00163613          	seqz	a2,a2
 5b0:	8ef1                	and	a3,a3,a2
 5b2:	0e069c63          	bnez	a3,6aa <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5b6:	f8850513          	addi	a0,a0,-120
 5ba:	00153513          	seqz	a0,a0
 5be:	8f69                	and	a4,a4,a0
 5c0:	10071263          	bnez	a4,6c4 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5c4:	07000713          	li	a4,112
 5c8:	10e78a63          	beq	a5,a4,6dc <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5cc:	06300713          	li	a4,99
 5d0:	14e78a63          	beq	a5,a4,724 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5d4:	07300713          	li	a4,115
 5d8:	16e78063          	beq	a5,a4,738 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5dc:	02500713          	li	a4,37
 5e0:	18e78863          	beq	a5,a4,770 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5e4:	02500593          	li	a1,37
 5e8:	855a                	mv	a0,s6
 5ea:	e2bff0ef          	jal	414 <putc>
        putc(fd, c0);
 5ee:	85a6                	mv	a1,s1
 5f0:	855a                	mv	a0,s6
 5f2:	e23ff0ef          	jal	414 <putc>
      }

      state = 0;
 5f6:	4981                	li	s3,0
 5f8:	b71d                	j	51e <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 5fa:	008b8493          	addi	s1,s7,8
 5fe:	4685                	li	a3,1
 600:	4629                	li	a2,10
 602:	000ba583          	lw	a1,0(s7)
 606:	855a                	mv	a0,s6
 608:	e2bff0ef          	jal	432 <printint>
 60c:	8ba6                	mv	s7,s1
      state = 0;
 60e:	4981                	li	s3,0
 610:	b739                	j	51e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 612:	008b8493          	addi	s1,s7,8
 616:	4685                	li	a3,1
 618:	4629                	li	a2,10
 61a:	000bb583          	ld	a1,0(s7)
 61e:	855a                	mv	a0,s6
 620:	e13ff0ef          	jal	432 <printint>
        i += 1;
 624:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 626:	8ba6                	mv	s7,s1
      state = 0;
 628:	4981                	li	s3,0
 62a:	bdd5                	j	51e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 62c:	008b8493          	addi	s1,s7,8
 630:	4685                	li	a3,1
 632:	4629                	li	a2,10
 634:	000bb583          	ld	a1,0(s7)
 638:	855a                	mv	a0,s6
 63a:	df9ff0ef          	jal	432 <printint>
        i += 2;
 63e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 640:	8ba6                	mv	s7,s1
      state = 0;
 642:	4981                	li	s3,0
        i += 2;
 644:	bde9                	j	51e <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 646:	008b8493          	addi	s1,s7,8
 64a:	4681                	li	a3,0
 64c:	4629                	li	a2,10
 64e:	000be583          	lwu	a1,0(s7)
 652:	855a                	mv	a0,s6
 654:	ddfff0ef          	jal	432 <printint>
 658:	8ba6                	mv	s7,s1
      state = 0;
 65a:	4981                	li	s3,0
 65c:	b5c9                	j	51e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 65e:	008b8493          	addi	s1,s7,8
 662:	4681                	li	a3,0
 664:	4629                	li	a2,10
 666:	000bb583          	ld	a1,0(s7)
 66a:	855a                	mv	a0,s6
 66c:	dc7ff0ef          	jal	432 <printint>
        i += 1;
 670:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 672:	8ba6                	mv	s7,s1
      state = 0;
 674:	4981                	li	s3,0
 676:	b565                	j	51e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 678:	008b8493          	addi	s1,s7,8
 67c:	4681                	li	a3,0
 67e:	4629                	li	a2,10
 680:	000bb583          	ld	a1,0(s7)
 684:	855a                	mv	a0,s6
 686:	dadff0ef          	jal	432 <printint>
        i += 2;
 68a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 68c:	8ba6                	mv	s7,s1
      state = 0;
 68e:	4981                	li	s3,0
        i += 2;
 690:	b579                	j	51e <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 692:	008b8493          	addi	s1,s7,8
 696:	4681                	li	a3,0
 698:	4641                	li	a2,16
 69a:	000be583          	lwu	a1,0(s7)
 69e:	855a                	mv	a0,s6
 6a0:	d93ff0ef          	jal	432 <printint>
 6a4:	8ba6                	mv	s7,s1
      state = 0;
 6a6:	4981                	li	s3,0
 6a8:	bd9d                	j	51e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6aa:	008b8493          	addi	s1,s7,8
 6ae:	4681                	li	a3,0
 6b0:	4641                	li	a2,16
 6b2:	000bb583          	ld	a1,0(s7)
 6b6:	855a                	mv	a0,s6
 6b8:	d7bff0ef          	jal	432 <printint>
        i += 1;
 6bc:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6be:	8ba6                	mv	s7,s1
      state = 0;
 6c0:	4981                	li	s3,0
 6c2:	bdb1                	j	51e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6c4:	008b8493          	addi	s1,s7,8
 6c8:	4641                	li	a2,16
 6ca:	000bb583          	ld	a1,0(s7)
 6ce:	855a                	mv	a0,s6
 6d0:	d63ff0ef          	jal	432 <printint>
        i += 2;
 6d4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d6:	8ba6                	mv	s7,s1
      state = 0;
 6d8:	4981                	li	s3,0
        i += 2;
 6da:	b591                	j	51e <vprintf+0x44>
 6dc:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 6de:	008b8793          	addi	a5,s7,8
 6e2:	8cbe                	mv	s9,a5
 6e4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6e8:	03000593          	li	a1,48
 6ec:	855a                	mv	a0,s6
 6ee:	d27ff0ef          	jal	414 <putc>
  putc(fd, 'x');
 6f2:	07800593          	li	a1,120
 6f6:	855a                	mv	a0,s6
 6f8:	d1dff0ef          	jal	414 <putc>
 6fc:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6fe:	00000b97          	auipc	s7,0x0
 702:	302b8b93          	addi	s7,s7,770 # a00 <digits>
 706:	03c9d793          	srli	a5,s3,0x3c
 70a:	97de                	add	a5,a5,s7
 70c:	0007c583          	lbu	a1,0(a5)
 710:	855a                	mv	a0,s6
 712:	d03ff0ef          	jal	414 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 716:	0992                	slli	s3,s3,0x4
 718:	34fd                	addiw	s1,s1,-1
 71a:	f4f5                	bnez	s1,706 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 71c:	8be6                	mv	s7,s9
      state = 0;
 71e:	4981                	li	s3,0
 720:	6ca2                	ld	s9,8(sp)
 722:	bbf5                	j	51e <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 724:	008b8493          	addi	s1,s7,8
 728:	000bc583          	lbu	a1,0(s7)
 72c:	855a                	mv	a0,s6
 72e:	ce7ff0ef          	jal	414 <putc>
 732:	8ba6                	mv	s7,s1
      state = 0;
 734:	4981                	li	s3,0
 736:	b3e5                	j	51e <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 738:	008b8993          	addi	s3,s7,8
 73c:	000bb483          	ld	s1,0(s7)
 740:	cc91                	beqz	s1,75c <vprintf+0x282>
        for(; *s; s++)
 742:	0004c583          	lbu	a1,0(s1)
 746:	c195                	beqz	a1,76a <vprintf+0x290>
          putc(fd, *s);
 748:	855a                	mv	a0,s6
 74a:	ccbff0ef          	jal	414 <putc>
        for(; *s; s++)
 74e:	0485                	addi	s1,s1,1
 750:	0004c583          	lbu	a1,0(s1)
 754:	f9f5                	bnez	a1,748 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 756:	8bce                	mv	s7,s3
      state = 0;
 758:	4981                	li	s3,0
 75a:	b3d1                	j	51e <vprintf+0x44>
          s = "(null)";
 75c:	00000497          	auipc	s1,0x0
 760:	29c48493          	addi	s1,s1,668 # 9f8 <malloc+0x16a>
        for(; *s; s++)
 764:	02800593          	li	a1,40
 768:	b7c5                	j	748 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 76a:	8bce                	mv	s7,s3
      state = 0;
 76c:	4981                	li	s3,0
 76e:	bb45                	j	51e <vprintf+0x44>
        putc(fd, '%');
 770:	85be                	mv	a1,a5
 772:	855a                	mv	a0,s6
 774:	ca1ff0ef          	jal	414 <putc>
 778:	bdbd                	j	5f6 <vprintf+0x11c>
 77a:	6906                	ld	s2,64(sp)
 77c:	79e2                	ld	s3,56(sp)
 77e:	7a42                	ld	s4,48(sp)
 780:	7aa2                	ld	s5,40(sp)
 782:	7b02                	ld	s6,32(sp)
 784:	6be2                	ld	s7,24(sp)
 786:	6c42                	ld	s8,16(sp)
    }
  }
}
 788:	60e6                	ld	ra,88(sp)
 78a:	6446                	ld	s0,80(sp)
 78c:	64a6                	ld	s1,72(sp)
 78e:	6125                	addi	sp,sp,96
 790:	8082                	ret
      if(c0 == 'd'){
 792:	06400713          	li	a4,100
 796:	e6e782e3          	beq	a5,a4,5fa <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 79a:	f9478693          	addi	a3,a5,-108
 79e:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 7a2:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7a4:	4701                	li	a4,0
 7a6:	bbe9                	j	580 <vprintf+0xa6>

00000000000007a8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7a8:	715d                	addi	sp,sp,-80
 7aa:	ec06                	sd	ra,24(sp)
 7ac:	e822                	sd	s0,16(sp)
 7ae:	1000                	addi	s0,sp,32
 7b0:	e010                	sd	a2,0(s0)
 7b2:	e414                	sd	a3,8(s0)
 7b4:	e818                	sd	a4,16(s0)
 7b6:	ec1c                	sd	a5,24(s0)
 7b8:	03043023          	sd	a6,32(s0)
 7bc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7c0:	8622                	mv	a2,s0
 7c2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7c6:	d15ff0ef          	jal	4da <vprintf>
}
 7ca:	60e2                	ld	ra,24(sp)
 7cc:	6442                	ld	s0,16(sp)
 7ce:	6161                	addi	sp,sp,80
 7d0:	8082                	ret

00000000000007d2 <printf>:

void
printf(const char *fmt, ...)
{
 7d2:	711d                	addi	sp,sp,-96
 7d4:	ec06                	sd	ra,24(sp)
 7d6:	e822                	sd	s0,16(sp)
 7d8:	1000                	addi	s0,sp,32
 7da:	e40c                	sd	a1,8(s0)
 7dc:	e810                	sd	a2,16(s0)
 7de:	ec14                	sd	a3,24(s0)
 7e0:	f018                	sd	a4,32(s0)
 7e2:	f41c                	sd	a5,40(s0)
 7e4:	03043823          	sd	a6,48(s0)
 7e8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7ec:	00840613          	addi	a2,s0,8
 7f0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7f4:	85aa                	mv	a1,a0
 7f6:	4505                	li	a0,1
 7f8:	ce3ff0ef          	jal	4da <vprintf>
}
 7fc:	60e2                	ld	ra,24(sp)
 7fe:	6442                	ld	s0,16(sp)
 800:	6125                	addi	sp,sp,96
 802:	8082                	ret

0000000000000804 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 804:	1141                	addi	sp,sp,-16
 806:	e406                	sd	ra,8(sp)
 808:	e022                	sd	s0,0(sp)
 80a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 80c:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 810:	00001797          	auipc	a5,0x1
 814:	8007b783          	ld	a5,-2048(a5) # 1010 <freep>
 818:	a095                	j	87c <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 81a:	ff852583          	lw	a1,-8(a0)
 81e:	6390                	ld	a2,0(a5)
 820:	02059813          	slli	a6,a1,0x20
 824:	01c85693          	srli	a3,a6,0x1c
 828:	96ba                	add	a3,a3,a4
 82a:	02d60563          	beq	a2,a3,854 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 82e:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 832:	4790                	lw	a2,8(a5)
 834:	02061593          	slli	a1,a2,0x20
 838:	01c5d693          	srli	a3,a1,0x1c
 83c:	96be                	add	a3,a3,a5
 83e:	02d70263          	beq	a4,a3,862 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 842:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 844:	00000717          	auipc	a4,0x0
 848:	7cf73623          	sd	a5,1996(a4) # 1010 <freep>
}
 84c:	60a2                	ld	ra,8(sp)
 84e:	6402                	ld	s0,0(sp)
 850:	0141                	addi	sp,sp,16
 852:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 854:	4614                	lw	a3,8(a2)
 856:	9ead                	addw	a3,a3,a1
 858:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 85c:	6394                	ld	a3,0(a5)
 85e:	6290                	ld	a2,0(a3)
 860:	b7f9                	j	82e <free+0x2a>
    p->s.size += bp->s.size;
 862:	ff852703          	lw	a4,-8(a0)
 866:	9f31                	addw	a4,a4,a2
 868:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 86a:	ff053703          	ld	a4,-16(a0)
 86e:	bfd1                	j	842 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 870:	6394                	ld	a3,0(a5)
 872:	00d7e463          	bltu	a5,a3,87a <free+0x76>
 876:	fad762e3          	bltu	a4,a3,81a <free+0x16>
 87a:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 87c:	fee7fae3          	bgeu	a5,a4,870 <free+0x6c>
 880:	6394                	ld	a3,0(a5)
 882:	f8d76ce3          	bltu	a4,a3,81a <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 886:	f8d7fae3          	bgeu	a5,a3,81a <free+0x16>
 88a:	87b6                	mv	a5,a3
 88c:	bfc5                	j	87c <free+0x78>

000000000000088e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 88e:	7139                	addi	sp,sp,-64
 890:	fc06                	sd	ra,56(sp)
 892:	f822                	sd	s0,48(sp)
 894:	f04a                	sd	s2,32(sp)
 896:	ec4e                	sd	s3,24(sp)
 898:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 89a:	02051993          	slli	s3,a0,0x20
 89e:	0209d993          	srli	s3,s3,0x20
 8a2:	09bd                	addi	s3,s3,15
 8a4:	0049d993          	srli	s3,s3,0x4
 8a8:	2985                	addiw	s3,s3,1
 8aa:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8ac:	00000517          	auipc	a0,0x0
 8b0:	76453503          	ld	a0,1892(a0) # 1010 <freep>
 8b4:	c905                	beqz	a0,8e4 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8b8:	4798                	lw	a4,8(a5)
 8ba:	09377663          	bgeu	a4,s3,946 <malloc+0xb8>
 8be:	f426                	sd	s1,40(sp)
 8c0:	e852                	sd	s4,16(sp)
 8c2:	e456                	sd	s5,8(sp)
 8c4:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8c6:	8a4e                	mv	s4,s3
 8c8:	6705                	lui	a4,0x1
 8ca:	00e9f363          	bgeu	s3,a4,8d0 <malloc+0x42>
 8ce:	6a05                	lui	s4,0x1
 8d0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8d4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8d8:	00000497          	auipc	s1,0x0
 8dc:	73848493          	addi	s1,s1,1848 # 1010 <freep>
  if(p == SBRK_ERROR)
 8e0:	5afd                	li	s5,-1
 8e2:	a83d                	j	920 <malloc+0x92>
 8e4:	f426                	sd	s1,40(sp)
 8e6:	e852                	sd	s4,16(sp)
 8e8:	e456                	sd	s5,8(sp)
 8ea:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8ec:	00000797          	auipc	a5,0x0
 8f0:	73478793          	addi	a5,a5,1844 # 1020 <base>
 8f4:	00000717          	auipc	a4,0x0
 8f8:	70f73e23          	sd	a5,1820(a4) # 1010 <freep>
 8fc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8fe:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 902:	b7d1                	j	8c6 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 904:	6398                	ld	a4,0(a5)
 906:	e118                	sd	a4,0(a0)
 908:	a899                	j	95e <malloc+0xd0>
  hp->s.size = nu;
 90a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 90e:	0541                	addi	a0,a0,16
 910:	ef5ff0ef          	jal	804 <free>
  return freep;
 914:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 916:	c125                	beqz	a0,976 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 918:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 91a:	4798                	lw	a4,8(a5)
 91c:	03277163          	bgeu	a4,s2,93e <malloc+0xb0>
    if(p == freep)
 920:	6098                	ld	a4,0(s1)
 922:	853e                	mv	a0,a5
 924:	fef71ae3          	bne	a4,a5,918 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 928:	8552                	mv	a0,s4
 92a:	a17ff0ef          	jal	340 <sbrk>
  if(p == SBRK_ERROR)
 92e:	fd551ee3          	bne	a0,s5,90a <malloc+0x7c>
        return 0;
 932:	4501                	li	a0,0
 934:	74a2                	ld	s1,40(sp)
 936:	6a42                	ld	s4,16(sp)
 938:	6aa2                	ld	s5,8(sp)
 93a:	6b02                	ld	s6,0(sp)
 93c:	a03d                	j	96a <malloc+0xdc>
 93e:	74a2                	ld	s1,40(sp)
 940:	6a42                	ld	s4,16(sp)
 942:	6aa2                	ld	s5,8(sp)
 944:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 946:	fae90fe3          	beq	s2,a4,904 <malloc+0x76>
        p->s.size -= nunits;
 94a:	4137073b          	subw	a4,a4,s3
 94e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 950:	02071693          	slli	a3,a4,0x20
 954:	01c6d713          	srli	a4,a3,0x1c
 958:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 95a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 95e:	00000717          	auipc	a4,0x0
 962:	6aa73923          	sd	a0,1714(a4) # 1010 <freep>
      return (void*)(p + 1);
 966:	01078513          	addi	a0,a5,16
  }
}
 96a:	70e2                	ld	ra,56(sp)
 96c:	7442                	ld	s0,48(sp)
 96e:	7902                	ld	s2,32(sp)
 970:	69e2                	ld	s3,24(sp)
 972:	6121                	addi	sp,sp,64
 974:	8082                	ret
 976:	74a2                	ld	s1,40(sp)
 978:	6a42                	ld	s4,16(sp)
 97a:	6aa2                	ld	s5,8(sp)
 97c:	6b02                	ld	s6,0(sp)
 97e:	b7f5                	j	96a <malloc+0xdc>
