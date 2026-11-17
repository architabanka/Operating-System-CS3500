
user/_logstress:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
main(int argc, char **argv)
{
  int fd, n;
  enum { N = 250, SZ=2000 };
  
  for (int i = 1; i < argc; i++){
   0:	4785                	li	a5,1
   2:	0ea7de63          	bge	a5,a0,fe <main+0xfe>
{
   6:	7139                	addi	sp,sp,-64
   8:	fc06                	sd	ra,56(sp)
   a:	f822                	sd	s0,48(sp)
   c:	f426                	sd	s1,40(sp)
   e:	f04a                	sd	s2,32(sp)
  10:	ec4e                	sd	s3,24(sp)
  12:	e852                	sd	s4,16(sp)
  14:	0080                	addi	s0,sp,64
  16:	892a                	mv	s2,a0
  18:	8a2e                	mv	s4,a1
  for (int i = 1; i < argc; i++){
  1a:	84be                	mv	s1,a5
  1c:	a011                	j	20 <main+0x20>
  1e:	84be                	mv	s1,a5
    int pid1 = fork();
  20:	390000ef          	jal	3b0 <fork>
    if(pid1 < 0){
  24:	00054b63          	bltz	a0,3a <main+0x3a>
      printf("%s: fork failed\n", argv[0]);
      exit(1);
    }
    if(pid1 == 0) {
  28:	c505                	beqz	a0,50 <main+0x50>
  for (int i = 1; i < argc; i++){
  2a:	0014879b          	addiw	a5,s1,1
  2e:	fef918e3          	bne	s2,a5,1e <main+0x1e>
      }
      exit(0);
    }
  }
  int xstatus;
  for(int i = 1; i < argc; i++){
  32:	4905                	li	s2,1
    wait(&xstatus);
  34:	fcc40993          	addi	s3,s0,-52
  38:	a871                	j	d4 <main+0xd4>
      printf("%s: fork failed\n", argv[0]);
  3a:	000a3583          	ld	a1,0(s4)
  3e:	00001517          	auipc	a0,0x1
  42:	a4250513          	addi	a0,a0,-1470 # a80 <statistics+0x7a>
  46:	013000ef          	jal	858 <printf>
      exit(1);
  4a:	4505                	li	a0,1
  4c:	36c000ef          	jal	3b8 <exit>
      fd = open(argv[i], O_CREATE | O_RDWR);
  50:	00349913          	slli	s2,s1,0x3
  54:	9952                	add	s2,s2,s4
  56:	20200593          	li	a1,514
  5a:	00093503          	ld	a0,0(s2)
  5e:	39a000ef          	jal	3f8 <open>
  62:	89aa                	mv	s3,a0
      if(fd < 0){
  64:	04054063          	bltz	a0,a4 <main+0xa4>
      memset(buf, '0'+i, SZ);
  68:	7d000613          	li	a2,2000
  6c:	0304859b          	addiw	a1,s1,48
  70:	00001517          	auipc	a0,0x1
  74:	fa050513          	addi	a0,a0,-96 # 1010 <buf>
  78:	116000ef          	jal	18e <memset>
  7c:	0fa00493          	li	s1,250
        if((n = write(fd, buf, SZ)) != SZ){
  80:	7d000913          	li	s2,2000
  84:	00001a17          	auipc	s4,0x1
  88:	f8ca0a13          	addi	s4,s4,-116 # 1010 <buf>
  8c:	864a                	mv	a2,s2
  8e:	85d2                	mv	a1,s4
  90:	854e                	mv	a0,s3
  92:	346000ef          	jal	3d8 <write>
  96:	03251463          	bne	a0,s2,be <main+0xbe>
      for(i = 0; i < N; i++){
  9a:	34fd                	addiw	s1,s1,-1
  9c:	f8e5                	bnez	s1,8c <main+0x8c>
      exit(0);
  9e:	4501                	li	a0,0
  a0:	318000ef          	jal	3b8 <exit>
        printf("%s: create %s failed\n", argv[0], argv[i]);
  a4:	00093603          	ld	a2,0(s2)
  a8:	000a3583          	ld	a1,0(s4)
  ac:	00001517          	auipc	a0,0x1
  b0:	9ec50513          	addi	a0,a0,-1556 # a98 <statistics+0x92>
  b4:	7a4000ef          	jal	858 <printf>
        exit(1);
  b8:	4505                	li	a0,1
  ba:	2fe000ef          	jal	3b8 <exit>
          printf("write failed %d\n", n);
  be:	85aa                	mv	a1,a0
  c0:	00001517          	auipc	a0,0x1
  c4:	9f050513          	addi	a0,a0,-1552 # ab0 <statistics+0xaa>
  c8:	790000ef          	jal	858 <printf>
          exit(1);
  cc:	4505                	li	a0,1
  ce:	2ea000ef          	jal	3b8 <exit>
  for(int i = 1; i < argc; i++){
  d2:	893e                	mv	s2,a5
    wait(&xstatus);
  d4:	854e                	mv	a0,s3
  d6:	2ea000ef          	jal	3c0 <wait>
    if(xstatus != 0)
  da:	fcc42503          	lw	a0,-52(s0)
  de:	ed11                	bnez	a0,fa <main+0xfa>
  for(int i = 1; i < argc; i++){
  e0:	0019079b          	addiw	a5,s2,1
  e4:	ff2497e3          	bne	s1,s2,d2 <main+0xd2>
      exit(xstatus);
  }
  return 0;
}
  e8:	4501                	li	a0,0
  ea:	70e2                	ld	ra,56(sp)
  ec:	7442                	ld	s0,48(sp)
  ee:	74a2                	ld	s1,40(sp)
  f0:	7902                	ld	s2,32(sp)
  f2:	69e2                	ld	s3,24(sp)
  f4:	6a42                	ld	s4,16(sp)
  f6:	6121                	addi	sp,sp,64
  f8:	8082                	ret
      exit(xstatus);
  fa:	2be000ef          	jal	3b8 <exit>
}
  fe:	4501                	li	a0,0
 100:	8082                	ret

0000000000000102 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 102:	1141                	addi	sp,sp,-16
 104:	e406                	sd	ra,8(sp)
 106:	e022                	sd	s0,0(sp)
 108:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 10a:	ef7ff0ef          	jal	0 <main>
  exit(r);
 10e:	2aa000ef          	jal	3b8 <exit>

0000000000000112 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 112:	1141                	addi	sp,sp,-16
 114:	e406                	sd	ra,8(sp)
 116:	e022                	sd	s0,0(sp)
 118:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11a:	87aa                	mv	a5,a0
 11c:	0585                	addi	a1,a1,1
 11e:	0785                	addi	a5,a5,1
 120:	fff5c703          	lbu	a4,-1(a1)
 124:	fee78fa3          	sb	a4,-1(a5)
 128:	fb75                	bnez	a4,11c <strcpy+0xa>
    ;
  return os;
}
 12a:	60a2                	ld	ra,8(sp)
 12c:	6402                	ld	s0,0(sp)
 12e:	0141                	addi	sp,sp,16
 130:	8082                	ret

0000000000000132 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 132:	1141                	addi	sp,sp,-16
 134:	e406                	sd	ra,8(sp)
 136:	e022                	sd	s0,0(sp)
 138:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 13a:	00054783          	lbu	a5,0(a0)
 13e:	cb91                	beqz	a5,152 <strcmp+0x20>
 140:	0005c703          	lbu	a4,0(a1)
 144:	00f71763          	bne	a4,a5,152 <strcmp+0x20>
    p++, q++;
 148:	0505                	addi	a0,a0,1
 14a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 14c:	00054783          	lbu	a5,0(a0)
 150:	fbe5                	bnez	a5,140 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 152:	0005c503          	lbu	a0,0(a1)
}
 156:	40a7853b          	subw	a0,a5,a0
 15a:	60a2                	ld	ra,8(sp)
 15c:	6402                	ld	s0,0(sp)
 15e:	0141                	addi	sp,sp,16
 160:	8082                	ret

0000000000000162 <strlen>:

uint
strlen(const char *s)
{
 162:	1141                	addi	sp,sp,-16
 164:	e406                	sd	ra,8(sp)
 166:	e022                	sd	s0,0(sp)
 168:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 16a:	00054783          	lbu	a5,0(a0)
 16e:	cf91                	beqz	a5,18a <strlen+0x28>
 170:	00150793          	addi	a5,a0,1
 174:	86be                	mv	a3,a5
 176:	0785                	addi	a5,a5,1
 178:	fff7c703          	lbu	a4,-1(a5)
 17c:	ff65                	bnez	a4,174 <strlen+0x12>
 17e:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 182:	60a2                	ld	ra,8(sp)
 184:	6402                	ld	s0,0(sp)
 186:	0141                	addi	sp,sp,16
 188:	8082                	ret
  for(n = 0; s[n]; n++)
 18a:	4501                	li	a0,0
 18c:	bfdd                	j	182 <strlen+0x20>

000000000000018e <memset>:

void*
memset(void *dst, int c, uint n)
{
 18e:	1141                	addi	sp,sp,-16
 190:	e406                	sd	ra,8(sp)
 192:	e022                	sd	s0,0(sp)
 194:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 196:	ca19                	beqz	a2,1ac <memset+0x1e>
 198:	87aa                	mv	a5,a0
 19a:	1602                	slli	a2,a2,0x20
 19c:	9201                	srli	a2,a2,0x20
 19e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1a2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1a6:	0785                	addi	a5,a5,1
 1a8:	fee79de3          	bne	a5,a4,1a2 <memset+0x14>
  }
  return dst;
}
 1ac:	60a2                	ld	ra,8(sp)
 1ae:	6402                	ld	s0,0(sp)
 1b0:	0141                	addi	sp,sp,16
 1b2:	8082                	ret

00000000000001b4 <strchr>:

char*
strchr(const char *s, char c)
{
 1b4:	1141                	addi	sp,sp,-16
 1b6:	e406                	sd	ra,8(sp)
 1b8:	e022                	sd	s0,0(sp)
 1ba:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1bc:	00054783          	lbu	a5,0(a0)
 1c0:	c799                	beqz	a5,1ce <strchr+0x1a>
    if(*s == c)
 1c2:	00f58763          	beq	a1,a5,1d0 <strchr+0x1c>
  for(; *s; s++)
 1c6:	0505                	addi	a0,a0,1
 1c8:	00054783          	lbu	a5,0(a0)
 1cc:	fbfd                	bnez	a5,1c2 <strchr+0xe>
      return (char*)s;
  return 0;
 1ce:	4501                	li	a0,0
}
 1d0:	60a2                	ld	ra,8(sp)
 1d2:	6402                	ld	s0,0(sp)
 1d4:	0141                	addi	sp,sp,16
 1d6:	8082                	ret

00000000000001d8 <gets>:

char*
gets(char *buf, int max)
{
 1d8:	711d                	addi	sp,sp,-96
 1da:	ec86                	sd	ra,88(sp)
 1dc:	e8a2                	sd	s0,80(sp)
 1de:	e4a6                	sd	s1,72(sp)
 1e0:	e0ca                	sd	s2,64(sp)
 1e2:	fc4e                	sd	s3,56(sp)
 1e4:	f852                	sd	s4,48(sp)
 1e6:	f456                	sd	s5,40(sp)
 1e8:	f05a                	sd	s6,32(sp)
 1ea:	ec5e                	sd	s7,24(sp)
 1ec:	e862                	sd	s8,16(sp)
 1ee:	1080                	addi	s0,sp,96
 1f0:	8baa                	mv	s7,a0
 1f2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f4:	892a                	mv	s2,a0
 1f6:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1f8:	faf40b13          	addi	s6,s0,-81
 1fc:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 1fe:	8c26                	mv	s8,s1
 200:	0014899b          	addiw	s3,s1,1
 204:	84ce                	mv	s1,s3
 206:	0349d863          	bge	s3,s4,236 <gets+0x5e>
    cc = read(0, &c, 1);
 20a:	8656                	mv	a2,s5
 20c:	85da                	mv	a1,s6
 20e:	4501                	li	a0,0
 210:	1c0000ef          	jal	3d0 <read>
    if(cc < 1)
 214:	02a05163          	blez	a0,236 <gets+0x5e>
      break;
    buf[i++] = c;
 218:	faf44783          	lbu	a5,-81(s0)
 21c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 220:	0905                	addi	s2,s2,1
 222:	ff678713          	addi	a4,a5,-10
 226:	00173713          	seqz	a4,a4
 22a:	17cd                	addi	a5,a5,-13
 22c:	0017b793          	seqz	a5,a5
 230:	8fd9                	or	a5,a5,a4
 232:	d7f1                	beqz	a5,1fe <gets+0x26>
    buf[i++] = c;
 234:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 236:	9c5e                	add	s8,s8,s7
 238:	000c0023          	sb	zero,0(s8)
  return buf;
}
 23c:	855e                	mv	a0,s7
 23e:	60e6                	ld	ra,88(sp)
 240:	6446                	ld	s0,80(sp)
 242:	64a6                	ld	s1,72(sp)
 244:	6906                	ld	s2,64(sp)
 246:	79e2                	ld	s3,56(sp)
 248:	7a42                	ld	s4,48(sp)
 24a:	7aa2                	ld	s5,40(sp)
 24c:	7b02                	ld	s6,32(sp)
 24e:	6be2                	ld	s7,24(sp)
 250:	6c42                	ld	s8,16(sp)
 252:	6125                	addi	sp,sp,96
 254:	8082                	ret

0000000000000256 <stat>:

int
stat(const char *n, struct stat *st)
{
 256:	1101                	addi	sp,sp,-32
 258:	ec06                	sd	ra,24(sp)
 25a:	e822                	sd	s0,16(sp)
 25c:	e04a                	sd	s2,0(sp)
 25e:	1000                	addi	s0,sp,32
 260:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 262:	4581                	li	a1,0
 264:	194000ef          	jal	3f8 <open>
  if(fd < 0)
 268:	02054263          	bltz	a0,28c <stat+0x36>
 26c:	e426                	sd	s1,8(sp)
 26e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 270:	85ca                	mv	a1,s2
 272:	19e000ef          	jal	410 <fstat>
 276:	892a                	mv	s2,a0
  close(fd);
 278:	8526                	mv	a0,s1
 27a:	166000ef          	jal	3e0 <close>
  return r;
 27e:	64a2                	ld	s1,8(sp)
}
 280:	854a                	mv	a0,s2
 282:	60e2                	ld	ra,24(sp)
 284:	6442                	ld	s0,16(sp)
 286:	6902                	ld	s2,0(sp)
 288:	6105                	addi	sp,sp,32
 28a:	8082                	ret
    return -1;
 28c:	57fd                	li	a5,-1
 28e:	893e                	mv	s2,a5
 290:	bfc5                	j	280 <stat+0x2a>

0000000000000292 <atoi>:

int
atoi(const char *s)
{
 292:	1141                	addi	sp,sp,-16
 294:	e406                	sd	ra,8(sp)
 296:	e022                	sd	s0,0(sp)
 298:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29a:	00054683          	lbu	a3,0(a0)
 29e:	fd06879b          	addiw	a5,a3,-48
 2a2:	0ff7f793          	zext.b	a5,a5
 2a6:	4625                	li	a2,9
 2a8:	02f66963          	bltu	a2,a5,2da <atoi+0x48>
 2ac:	872a                	mv	a4,a0
  n = 0;
 2ae:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2b0:	0705                	addi	a4,a4,1
 2b2:	0025179b          	slliw	a5,a0,0x2
 2b6:	9fa9                	addw	a5,a5,a0
 2b8:	0017979b          	slliw	a5,a5,0x1
 2bc:	9fb5                	addw	a5,a5,a3
 2be:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2c2:	00074683          	lbu	a3,0(a4)
 2c6:	fd06879b          	addiw	a5,a3,-48
 2ca:	0ff7f793          	zext.b	a5,a5
 2ce:	fef671e3          	bgeu	a2,a5,2b0 <atoi+0x1e>
  return n;
}
 2d2:	60a2                	ld	ra,8(sp)
 2d4:	6402                	ld	s0,0(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret
  n = 0;
 2da:	4501                	li	a0,0
 2dc:	bfdd                	j	2d2 <atoi+0x40>

00000000000002de <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2de:	1141                	addi	sp,sp,-16
 2e0:	e406                	sd	ra,8(sp)
 2e2:	e022                	sd	s0,0(sp)
 2e4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2e6:	02b57563          	bgeu	a0,a1,310 <memmove+0x32>
    while(n-- > 0)
 2ea:	00c05f63          	blez	a2,308 <memmove+0x2a>
 2ee:	1602                	slli	a2,a2,0x20
 2f0:	9201                	srli	a2,a2,0x20
 2f2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2f6:	872a                	mv	a4,a0
      *dst++ = *src++;
 2f8:	0585                	addi	a1,a1,1
 2fa:	0705                	addi	a4,a4,1
 2fc:	fff5c683          	lbu	a3,-1(a1)
 300:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 304:	fee79ae3          	bne	a5,a4,2f8 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 308:	60a2                	ld	ra,8(sp)
 30a:	6402                	ld	s0,0(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret
    while(n-- > 0)
 310:	fec05ce3          	blez	a2,308 <memmove+0x2a>
    dst += n;
 314:	00c50733          	add	a4,a0,a2
    src += n;
 318:	95b2                	add	a1,a1,a2
 31a:	fff6079b          	addiw	a5,a2,-1
 31e:	1782                	slli	a5,a5,0x20
 320:	9381                	srli	a5,a5,0x20
 322:	fff7c793          	not	a5,a5
 326:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 328:	15fd                	addi	a1,a1,-1
 32a:	177d                	addi	a4,a4,-1
 32c:	0005c683          	lbu	a3,0(a1)
 330:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 334:	fef71ae3          	bne	a4,a5,328 <memmove+0x4a>
 338:	bfc1                	j	308 <memmove+0x2a>

000000000000033a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 33a:	1141                	addi	sp,sp,-16
 33c:	e406                	sd	ra,8(sp)
 33e:	e022                	sd	s0,0(sp)
 340:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 342:	ce19                	beqz	a2,360 <memcmp+0x26>
 344:	1602                	slli	a2,a2,0x20
 346:	9201                	srli	a2,a2,0x20
 348:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 34c:	00054783          	lbu	a5,0(a0)
 350:	0005c703          	lbu	a4,0(a1)
 354:	00e79b63          	bne	a5,a4,36a <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 358:	0505                	addi	a0,a0,1
    p2++;
 35a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 35c:	fed518e3          	bne	a0,a3,34c <memcmp+0x12>
  }
  return 0;
 360:	4501                	li	a0,0
}
 362:	60a2                	ld	ra,8(sp)
 364:	6402                	ld	s0,0(sp)
 366:	0141                	addi	sp,sp,16
 368:	8082                	ret
      return *p1 - *p2;
 36a:	40e7853b          	subw	a0,a5,a4
 36e:	bfd5                	j	362 <memcmp+0x28>

0000000000000370 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 370:	1141                	addi	sp,sp,-16
 372:	e406                	sd	ra,8(sp)
 374:	e022                	sd	s0,0(sp)
 376:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 378:	f67ff0ef          	jal	2de <memmove>
}
 37c:	60a2                	ld	ra,8(sp)
 37e:	6402                	ld	s0,0(sp)
 380:	0141                	addi	sp,sp,16
 382:	8082                	ret

0000000000000384 <sbrk>:

char *
sbrk(int n) {
 384:	1141                	addi	sp,sp,-16
 386:	e406                	sd	ra,8(sp)
 388:	e022                	sd	s0,0(sp)
 38a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 38c:	4585                	li	a1,1
 38e:	0b2000ef          	jal	440 <sys_sbrk>
}
 392:	60a2                	ld	ra,8(sp)
 394:	6402                	ld	s0,0(sp)
 396:	0141                	addi	sp,sp,16
 398:	8082                	ret

000000000000039a <sbrklazy>:

char *
sbrklazy(int n) {
 39a:	1141                	addi	sp,sp,-16
 39c:	e406                	sd	ra,8(sp)
 39e:	e022                	sd	s0,0(sp)
 3a0:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 3a2:	4589                	li	a1,2
 3a4:	09c000ef          	jal	440 <sys_sbrk>
}
 3a8:	60a2                	ld	ra,8(sp)
 3aa:	6402                	ld	s0,0(sp)
 3ac:	0141                	addi	sp,sp,16
 3ae:	8082                	ret

00000000000003b0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3b0:	4885                	li	a7,1
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3b8:	4889                	li	a7,2
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3c0:	488d                	li	a7,3
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3c8:	4891                	li	a7,4
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <read>:
.global read
read:
 li a7, SYS_read
 3d0:	4895                	li	a7,5
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <write>:
.global write
write:
 li a7, SYS_write
 3d8:	48c1                	li	a7,16
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <close>:
.global close
close:
 li a7, SYS_close
 3e0:	48d5                	li	a7,21
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3e8:	4899                	li	a7,6
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3f0:	489d                	li	a7,7
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <open>:
.global open
open:
 li a7, SYS_open
 3f8:	48bd                	li	a7,15
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 400:	48c5                	li	a7,17
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 408:	48c9                	li	a7,18
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 410:	48a1                	li	a7,8
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <link>:
.global link
link:
 li a7, SYS_link
 418:	48cd                	li	a7,19
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 420:	48d1                	li	a7,20
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 428:	48a5                	li	a7,9
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <dup>:
.global dup
dup:
 li a7, SYS_dup
 430:	48a9                	li	a7,10
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 438:	48ad                	li	a7,11
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 440:	48b1                	li	a7,12
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <pause>:
.global pause
pause:
 li a7, SYS_pause
 448:	48b5                	li	a7,13
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 450:	48b9                	li	a7,14
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <bind>:
.global bind
bind:
 li a7, SYS_bind
 458:	48f5                	li	a7,29
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 460:	48f9                	li	a7,30
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <send>:
.global send
send:
 li a7, SYS_send
 468:	48fd                	li	a7,31
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <recv>:
.global recv
recv:
 li a7, SYS_recv
 470:	02000893          	li	a7,32
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 47a:	02100893          	li	a7,33
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 484:	02200893          	li	a7,34
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <rwlktest>:
.global rwlktest
rwlktest:
 li a7, SYS_rwlktest
 48e:	02300893          	li	a7,35
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <cpupin>:
.global cpupin
cpupin:
 li a7, SYS_cpupin
 498:	02400893          	li	a7,36
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4a2:	1101                	addi	sp,sp,-32
 4a4:	ec06                	sd	ra,24(sp)
 4a6:	e822                	sd	s0,16(sp)
 4a8:	1000                	addi	s0,sp,32
 4aa:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4ae:	4605                	li	a2,1
 4b0:	fef40593          	addi	a1,s0,-17
 4b4:	f25ff0ef          	jal	3d8 <write>
}
 4b8:	60e2                	ld	ra,24(sp)
 4ba:	6442                	ld	s0,16(sp)
 4bc:	6105                	addi	sp,sp,32
 4be:	8082                	ret

00000000000004c0 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4c0:	715d                	addi	sp,sp,-80
 4c2:	e486                	sd	ra,72(sp)
 4c4:	e0a2                	sd	s0,64(sp)
 4c6:	f84a                	sd	s2,48(sp)
 4c8:	f44e                	sd	s3,40(sp)
 4ca:	0880                	addi	s0,sp,80
 4cc:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 4ce:	00d036b3          	snez	a3,a3
 4d2:	03f5d793          	srli	a5,a1,0x3f
 4d6:	8efd                	and	a3,a3,a5
  neg = 0;
 4d8:	4301                	li	t1,0
  if(sgn && xx < 0){
 4da:	c681                	beqz	a3,4e2 <printint+0x22>
    neg = 1;
    x = -xx;
 4dc:	40b005b3          	neg	a1,a1
    neg = 1;
 4e0:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 4e2:	fb840993          	addi	s3,s0,-72
  neg = 0;
 4e6:	86ce                	mv	a3,s3
  i = 0;
 4e8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4ea:	00000817          	auipc	a6,0x0
 4ee:	60e80813          	addi	a6,a6,1550 # af8 <digits>
 4f2:	88ba                	mv	a7,a4
 4f4:	0017051b          	addiw	a0,a4,1
 4f8:	872a                	mv	a4,a0
 4fa:	02c5f7b3          	remu	a5,a1,a2
 4fe:	97c2                	add	a5,a5,a6
 500:	0007c783          	lbu	a5,0(a5)
 504:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 508:	87ae                	mv	a5,a1
 50a:	02c5d5b3          	divu	a1,a1,a2
 50e:	0685                	addi	a3,a3,1
 510:	fec7f1e3          	bgeu	a5,a2,4f2 <printint+0x32>
  if(neg)
 514:	00030b63          	beqz	t1,52a <printint+0x6a>
    buf[i++] = '-';
 518:	fd040793          	addi	a5,s0,-48
 51c:	953e                	add	a0,a0,a5
 51e:	02d00793          	li	a5,45
 522:	fef50423          	sb	a5,-24(a0)
 526:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 52a:	02e05563          	blez	a4,554 <printint+0x94>
 52e:	fc26                	sd	s1,56(sp)
 530:	377d                	addiw	a4,a4,-1
 532:	00e984b3          	add	s1,s3,a4
 536:	19fd                	addi	s3,s3,-1
 538:	99ba                	add	s3,s3,a4
 53a:	1702                	slli	a4,a4,0x20
 53c:	9301                	srli	a4,a4,0x20
 53e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 542:	0004c583          	lbu	a1,0(s1)
 546:	854a                	mv	a0,s2
 548:	f5bff0ef          	jal	4a2 <putc>
  while(--i >= 0)
 54c:	14fd                	addi	s1,s1,-1
 54e:	ff349ae3          	bne	s1,s3,542 <printint+0x82>
 552:	74e2                	ld	s1,56(sp)
}
 554:	60a6                	ld	ra,72(sp)
 556:	6406                	ld	s0,64(sp)
 558:	7942                	ld	s2,48(sp)
 55a:	79a2                	ld	s3,40(sp)
 55c:	6161                	addi	sp,sp,80
 55e:	8082                	ret

0000000000000560 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 560:	711d                	addi	sp,sp,-96
 562:	ec86                	sd	ra,88(sp)
 564:	e8a2                	sd	s0,80(sp)
 566:	e4a6                	sd	s1,72(sp)
 568:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 56a:	0005c483          	lbu	s1,0(a1)
 56e:	2a048063          	beqz	s1,80e <vprintf+0x2ae>
 572:	e0ca                	sd	s2,64(sp)
 574:	fc4e                	sd	s3,56(sp)
 576:	f852                	sd	s4,48(sp)
 578:	f456                	sd	s5,40(sp)
 57a:	f05a                	sd	s6,32(sp)
 57c:	ec5e                	sd	s7,24(sp)
 57e:	e862                	sd	s8,16(sp)
 580:	8b2a                	mv	s6,a0
 582:	8a2e                	mv	s4,a1
 584:	8bb2                	mv	s7,a2
  state = 0;
 586:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 588:	4901                	li	s2,0
 58a:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 58c:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 590:	06400c13          	li	s8,100
 594:	a00d                	j	5b6 <vprintf+0x56>
        putc(fd, c0);
 596:	85a6                	mv	a1,s1
 598:	855a                	mv	a0,s6
 59a:	f09ff0ef          	jal	4a2 <putc>
 59e:	a019                	j	5a4 <vprintf+0x44>
    } else if(state == '%'){
 5a0:	03598363          	beq	s3,s5,5c6 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 5a4:	0019079b          	addiw	a5,s2,1
 5a8:	893e                	mv	s2,a5
 5aa:	873e                	mv	a4,a5
 5ac:	97d2                	add	a5,a5,s4
 5ae:	0007c483          	lbu	s1,0(a5)
 5b2:	24048763          	beqz	s1,800 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 5b6:	0004879b          	sext.w	a5,s1
    if(state == 0){
 5ba:	fe0993e3          	bnez	s3,5a0 <vprintf+0x40>
      if(c0 == '%'){
 5be:	fd579ce3          	bne	a5,s5,596 <vprintf+0x36>
        state = '%';
 5c2:	89be                	mv	s3,a5
 5c4:	b7c5                	j	5a4 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 5c6:	00ea06b3          	add	a3,s4,a4
 5ca:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 5ce:	24060563          	beqz	a2,818 <vprintf+0x2b8>
      if(c0 == 'd'){
 5d2:	0b878763          	beq	a5,s8,680 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5d6:	f9478693          	addi	a3,a5,-108
 5da:	0016b693          	seqz	a3,a3
 5de:	f9c60593          	addi	a1,a2,-100
 5e2:	0015b593          	seqz	a1,a1
 5e6:	8df5                	and	a1,a1,a3
 5e8:	e9c5                	bnez	a1,698 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 5ea:	9752                	add	a4,a4,s4
 5ec:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5f0:	f9460713          	addi	a4,a2,-108
 5f4:	00173713          	seqz	a4,a4
 5f8:	8f75                	and	a4,a4,a3
 5fa:	f9c50593          	addi	a1,a0,-100
 5fe:	0015b593          	seqz	a1,a1
 602:	8df9                	and	a1,a1,a4
 604:	e5dd                	bnez	a1,6b2 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 606:	07500593          	li	a1,117
 60a:	0cb78163          	beq	a5,a1,6cc <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 60e:	f8b60593          	addi	a1,a2,-117
 612:	0015b593          	seqz	a1,a1
 616:	8df5                	and	a1,a1,a3
 618:	e5f1                	bnez	a1,6e4 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 61a:	f8b50593          	addi	a1,a0,-117
 61e:	0015b593          	seqz	a1,a1
 622:	8df9                	and	a1,a1,a4
 624:	ede9                	bnez	a1,6fe <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 626:	07800593          	li	a1,120
 62a:	0eb78763          	beq	a5,a1,718 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 62e:	f8860613          	addi	a2,a2,-120
 632:	00163613          	seqz	a2,a2
 636:	8ef1                	and	a3,a3,a2
 638:	0e069c63          	bnez	a3,730 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 63c:	f8850513          	addi	a0,a0,-120
 640:	00153513          	seqz	a0,a0
 644:	8f69                	and	a4,a4,a0
 646:	10071263          	bnez	a4,74a <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 64a:	07000713          	li	a4,112
 64e:	10e78a63          	beq	a5,a4,762 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 652:	06300713          	li	a4,99
 656:	14e78a63          	beq	a5,a4,7aa <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 65a:	07300713          	li	a4,115
 65e:	16e78063          	beq	a5,a4,7be <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 662:	02500713          	li	a4,37
 666:	18e78863          	beq	a5,a4,7f6 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 66a:	02500593          	li	a1,37
 66e:	855a                	mv	a0,s6
 670:	e33ff0ef          	jal	4a2 <putc>
        putc(fd, c0);
 674:	85a6                	mv	a1,s1
 676:	855a                	mv	a0,s6
 678:	e2bff0ef          	jal	4a2 <putc>
      }

      state = 0;
 67c:	4981                	li	s3,0
 67e:	b71d                	j	5a4 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 680:	008b8493          	addi	s1,s7,8
 684:	4685                	li	a3,1
 686:	4629                	li	a2,10
 688:	000ba583          	lw	a1,0(s7)
 68c:	855a                	mv	a0,s6
 68e:	e33ff0ef          	jal	4c0 <printint>
 692:	8ba6                	mv	s7,s1
      state = 0;
 694:	4981                	li	s3,0
 696:	b739                	j	5a4 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 698:	008b8493          	addi	s1,s7,8
 69c:	4685                	li	a3,1
 69e:	4629                	li	a2,10
 6a0:	000bb583          	ld	a1,0(s7)
 6a4:	855a                	mv	a0,s6
 6a6:	e1bff0ef          	jal	4c0 <printint>
        i += 1;
 6aa:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ac:	8ba6                	mv	s7,s1
      state = 0;
 6ae:	4981                	li	s3,0
 6b0:	bdd5                	j	5a4 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6b2:	008b8493          	addi	s1,s7,8
 6b6:	4685                	li	a3,1
 6b8:	4629                	li	a2,10
 6ba:	000bb583          	ld	a1,0(s7)
 6be:	855a                	mv	a0,s6
 6c0:	e01ff0ef          	jal	4c0 <printint>
        i += 2;
 6c4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6c6:	8ba6                	mv	s7,s1
      state = 0;
 6c8:	4981                	li	s3,0
        i += 2;
 6ca:	bde9                	j	5a4 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6cc:	008b8493          	addi	s1,s7,8
 6d0:	4681                	li	a3,0
 6d2:	4629                	li	a2,10
 6d4:	000be583          	lwu	a1,0(s7)
 6d8:	855a                	mv	a0,s6
 6da:	de7ff0ef          	jal	4c0 <printint>
 6de:	8ba6                	mv	s7,s1
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	b5c9                	j	5a4 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6e4:	008b8493          	addi	s1,s7,8
 6e8:	4681                	li	a3,0
 6ea:	4629                	li	a2,10
 6ec:	000bb583          	ld	a1,0(s7)
 6f0:	855a                	mv	a0,s6
 6f2:	dcfff0ef          	jal	4c0 <printint>
        i += 1;
 6f6:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6f8:	8ba6                	mv	s7,s1
      state = 0;
 6fa:	4981                	li	s3,0
 6fc:	b565                	j	5a4 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6fe:	008b8493          	addi	s1,s7,8
 702:	4681                	li	a3,0
 704:	4629                	li	a2,10
 706:	000bb583          	ld	a1,0(s7)
 70a:	855a                	mv	a0,s6
 70c:	db5ff0ef          	jal	4c0 <printint>
        i += 2;
 710:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 712:	8ba6                	mv	s7,s1
      state = 0;
 714:	4981                	li	s3,0
        i += 2;
 716:	b579                	j	5a4 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 718:	008b8493          	addi	s1,s7,8
 71c:	4681                	li	a3,0
 71e:	4641                	li	a2,16
 720:	000be583          	lwu	a1,0(s7)
 724:	855a                	mv	a0,s6
 726:	d9bff0ef          	jal	4c0 <printint>
 72a:	8ba6                	mv	s7,s1
      state = 0;
 72c:	4981                	li	s3,0
 72e:	bd9d                	j	5a4 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 730:	008b8493          	addi	s1,s7,8
 734:	4681                	li	a3,0
 736:	4641                	li	a2,16
 738:	000bb583          	ld	a1,0(s7)
 73c:	855a                	mv	a0,s6
 73e:	d83ff0ef          	jal	4c0 <printint>
        i += 1;
 742:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 744:	8ba6                	mv	s7,s1
      state = 0;
 746:	4981                	li	s3,0
 748:	bdb1                	j	5a4 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 74a:	008b8493          	addi	s1,s7,8
 74e:	4641                	li	a2,16
 750:	000bb583          	ld	a1,0(s7)
 754:	855a                	mv	a0,s6
 756:	d6bff0ef          	jal	4c0 <printint>
        i += 2;
 75a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 75c:	8ba6                	mv	s7,s1
      state = 0;
 75e:	4981                	li	s3,0
        i += 2;
 760:	b591                	j	5a4 <vprintf+0x44>
 762:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 764:	008b8793          	addi	a5,s7,8
 768:	8cbe                	mv	s9,a5
 76a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 76e:	03000593          	li	a1,48
 772:	855a                	mv	a0,s6
 774:	d2fff0ef          	jal	4a2 <putc>
  putc(fd, 'x');
 778:	07800593          	li	a1,120
 77c:	855a                	mv	a0,s6
 77e:	d25ff0ef          	jal	4a2 <putc>
 782:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 784:	00000b97          	auipc	s7,0x0
 788:	374b8b93          	addi	s7,s7,884 # af8 <digits>
 78c:	03c9d793          	srli	a5,s3,0x3c
 790:	97de                	add	a5,a5,s7
 792:	0007c583          	lbu	a1,0(a5)
 796:	855a                	mv	a0,s6
 798:	d0bff0ef          	jal	4a2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 79c:	0992                	slli	s3,s3,0x4
 79e:	34fd                	addiw	s1,s1,-1
 7a0:	f4f5                	bnez	s1,78c <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 7a2:	8be6                	mv	s7,s9
      state = 0;
 7a4:	4981                	li	s3,0
 7a6:	6ca2                	ld	s9,8(sp)
 7a8:	bbf5                	j	5a4 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 7aa:	008b8493          	addi	s1,s7,8
 7ae:	000bc583          	lbu	a1,0(s7)
 7b2:	855a                	mv	a0,s6
 7b4:	cefff0ef          	jal	4a2 <putc>
 7b8:	8ba6                	mv	s7,s1
      state = 0;
 7ba:	4981                	li	s3,0
 7bc:	b3e5                	j	5a4 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 7be:	008b8993          	addi	s3,s7,8
 7c2:	000bb483          	ld	s1,0(s7)
 7c6:	cc91                	beqz	s1,7e2 <vprintf+0x282>
        for(; *s; s++)
 7c8:	0004c583          	lbu	a1,0(s1)
 7cc:	c195                	beqz	a1,7f0 <vprintf+0x290>
          putc(fd, *s);
 7ce:	855a                	mv	a0,s6
 7d0:	cd3ff0ef          	jal	4a2 <putc>
        for(; *s; s++)
 7d4:	0485                	addi	s1,s1,1
 7d6:	0004c583          	lbu	a1,0(s1)
 7da:	f9f5                	bnez	a1,7ce <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 7dc:	8bce                	mv	s7,s3
      state = 0;
 7de:	4981                	li	s3,0
 7e0:	b3d1                	j	5a4 <vprintf+0x44>
          s = "(null)";
 7e2:	00000497          	auipc	s1,0x0
 7e6:	2e648493          	addi	s1,s1,742 # ac8 <statistics+0xc2>
        for(; *s; s++)
 7ea:	02800593          	li	a1,40
 7ee:	b7c5                	j	7ce <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 7f0:	8bce                	mv	s7,s3
      state = 0;
 7f2:	4981                	li	s3,0
 7f4:	bb45                	j	5a4 <vprintf+0x44>
        putc(fd, '%');
 7f6:	85be                	mv	a1,a5
 7f8:	855a                	mv	a0,s6
 7fa:	ca9ff0ef          	jal	4a2 <putc>
 7fe:	bdbd                	j	67c <vprintf+0x11c>
 800:	6906                	ld	s2,64(sp)
 802:	79e2                	ld	s3,56(sp)
 804:	7a42                	ld	s4,48(sp)
 806:	7aa2                	ld	s5,40(sp)
 808:	7b02                	ld	s6,32(sp)
 80a:	6be2                	ld	s7,24(sp)
 80c:	6c42                	ld	s8,16(sp)
    }
  }
}
 80e:	60e6                	ld	ra,88(sp)
 810:	6446                	ld	s0,80(sp)
 812:	64a6                	ld	s1,72(sp)
 814:	6125                	addi	sp,sp,96
 816:	8082                	ret
      if(c0 == 'd'){
 818:	06400713          	li	a4,100
 81c:	e6e782e3          	beq	a5,a4,680 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 820:	f9478693          	addi	a3,a5,-108
 824:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 828:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 82a:	4701                	li	a4,0
 82c:	bbe9                	j	606 <vprintf+0xa6>

000000000000082e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 82e:	715d                	addi	sp,sp,-80
 830:	ec06                	sd	ra,24(sp)
 832:	e822                	sd	s0,16(sp)
 834:	1000                	addi	s0,sp,32
 836:	e010                	sd	a2,0(s0)
 838:	e414                	sd	a3,8(s0)
 83a:	e818                	sd	a4,16(s0)
 83c:	ec1c                	sd	a5,24(s0)
 83e:	03043023          	sd	a6,32(s0)
 842:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 846:	8622                	mv	a2,s0
 848:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 84c:	d15ff0ef          	jal	560 <vprintf>
}
 850:	60e2                	ld	ra,24(sp)
 852:	6442                	ld	s0,16(sp)
 854:	6161                	addi	sp,sp,80
 856:	8082                	ret

0000000000000858 <printf>:

void
printf(const char *fmt, ...)
{
 858:	711d                	addi	sp,sp,-96
 85a:	ec06                	sd	ra,24(sp)
 85c:	e822                	sd	s0,16(sp)
 85e:	1000                	addi	s0,sp,32
 860:	e40c                	sd	a1,8(s0)
 862:	e810                	sd	a2,16(s0)
 864:	ec14                	sd	a3,24(s0)
 866:	f018                	sd	a4,32(s0)
 868:	f41c                	sd	a5,40(s0)
 86a:	03043823          	sd	a6,48(s0)
 86e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 872:	00840613          	addi	a2,s0,8
 876:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 87a:	85aa                	mv	a1,a0
 87c:	4505                	li	a0,1
 87e:	ce3ff0ef          	jal	560 <vprintf>
}
 882:	60e2                	ld	ra,24(sp)
 884:	6442                	ld	s0,16(sp)
 886:	6125                	addi	sp,sp,96
 888:	8082                	ret

000000000000088a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 88a:	1141                	addi	sp,sp,-16
 88c:	e406                	sd	ra,8(sp)
 88e:	e022                	sd	s0,0(sp)
 890:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 892:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 896:	00000797          	auipc	a5,0x0
 89a:	76a7b783          	ld	a5,1898(a5) # 1000 <freep>
 89e:	a095                	j	902 <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 8a0:	ff852583          	lw	a1,-8(a0)
 8a4:	6390                	ld	a2,0(a5)
 8a6:	02059813          	slli	a6,a1,0x20
 8aa:	01c85693          	srli	a3,a6,0x1c
 8ae:	96ba                	add	a3,a3,a4
 8b0:	02d60563          	beq	a2,a3,8da <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 8b4:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 8b8:	4790                	lw	a2,8(a5)
 8ba:	02061593          	slli	a1,a2,0x20
 8be:	01c5d693          	srli	a3,a1,0x1c
 8c2:	96be                	add	a3,a3,a5
 8c4:	02d70263          	beq	a4,a3,8e8 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 8c8:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8ca:	00000717          	auipc	a4,0x0
 8ce:	72f73b23          	sd	a5,1846(a4) # 1000 <freep>
}
 8d2:	60a2                	ld	ra,8(sp)
 8d4:	6402                	ld	s0,0(sp)
 8d6:	0141                	addi	sp,sp,16
 8d8:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 8da:	4614                	lw	a3,8(a2)
 8dc:	9ead                	addw	a3,a3,a1
 8de:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8e2:	6394                	ld	a3,0(a5)
 8e4:	6290                	ld	a2,0(a3)
 8e6:	b7f9                	j	8b4 <free+0x2a>
    p->s.size += bp->s.size;
 8e8:	ff852703          	lw	a4,-8(a0)
 8ec:	9f31                	addw	a4,a4,a2
 8ee:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8f0:	ff053703          	ld	a4,-16(a0)
 8f4:	bfd1                	j	8c8 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f6:	6394                	ld	a3,0(a5)
 8f8:	00d7e463          	bltu	a5,a3,900 <free+0x76>
 8fc:	fad762e3          	bltu	a4,a3,8a0 <free+0x16>
 900:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 902:	fee7fae3          	bgeu	a5,a4,8f6 <free+0x6c>
 906:	6394                	ld	a3,0(a5)
 908:	f8d76ce3          	bltu	a4,a3,8a0 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 90c:	f8d7fae3          	bgeu	a5,a3,8a0 <free+0x16>
 910:	87b6                	mv	a5,a3
 912:	bfc5                	j	902 <free+0x78>

0000000000000914 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 914:	7139                	addi	sp,sp,-64
 916:	fc06                	sd	ra,56(sp)
 918:	f822                	sd	s0,48(sp)
 91a:	f04a                	sd	s2,32(sp)
 91c:	ec4e                	sd	s3,24(sp)
 91e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 920:	02051993          	slli	s3,a0,0x20
 924:	0209d993          	srli	s3,s3,0x20
 928:	09bd                	addi	s3,s3,15
 92a:	0049d993          	srli	s3,s3,0x4
 92e:	2985                	addiw	s3,s3,1
 930:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 932:	00000517          	auipc	a0,0x0
 936:	6ce53503          	ld	a0,1742(a0) # 1000 <freep>
 93a:	c905                	beqz	a0,96a <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 93c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 93e:	4798                	lw	a4,8(a5)
 940:	09377663          	bgeu	a4,s3,9cc <malloc+0xb8>
 944:	f426                	sd	s1,40(sp)
 946:	e852                	sd	s4,16(sp)
 948:	e456                	sd	s5,8(sp)
 94a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 94c:	8a4e                	mv	s4,s3
 94e:	6705                	lui	a4,0x1
 950:	00e9f363          	bgeu	s3,a4,956 <malloc+0x42>
 954:	6a05                	lui	s4,0x1
 956:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 95a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 95e:	00000497          	auipc	s1,0x0
 962:	6a248493          	addi	s1,s1,1698 # 1000 <freep>
  if(p == SBRK_ERROR)
 966:	5afd                	li	s5,-1
 968:	a83d                	j	9a6 <malloc+0x92>
 96a:	f426                	sd	s1,40(sp)
 96c:	e852                	sd	s4,16(sp)
 96e:	e456                	sd	s5,8(sp)
 970:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 972:	00001797          	auipc	a5,0x1
 976:	89678793          	addi	a5,a5,-1898 # 1208 <base>
 97a:	00000717          	auipc	a4,0x0
 97e:	68f73323          	sd	a5,1670(a4) # 1000 <freep>
 982:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 984:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 988:	b7d1                	j	94c <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 98a:	6398                	ld	a4,0(a5)
 98c:	e118                	sd	a4,0(a0)
 98e:	a899                	j	9e4 <malloc+0xd0>
  hp->s.size = nu;
 990:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 994:	0541                	addi	a0,a0,16
 996:	ef5ff0ef          	jal	88a <free>
  return freep;
 99a:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 99c:	c125                	beqz	a0,9fc <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 99e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9a0:	4798                	lw	a4,8(a5)
 9a2:	03277163          	bgeu	a4,s2,9c4 <malloc+0xb0>
    if(p == freep)
 9a6:	6098                	ld	a4,0(s1)
 9a8:	853e                	mv	a0,a5
 9aa:	fef71ae3          	bne	a4,a5,99e <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 9ae:	8552                	mv	a0,s4
 9b0:	9d5ff0ef          	jal	384 <sbrk>
  if(p == SBRK_ERROR)
 9b4:	fd551ee3          	bne	a0,s5,990 <malloc+0x7c>
        return 0;
 9b8:	4501                	li	a0,0
 9ba:	74a2                	ld	s1,40(sp)
 9bc:	6a42                	ld	s4,16(sp)
 9be:	6aa2                	ld	s5,8(sp)
 9c0:	6b02                	ld	s6,0(sp)
 9c2:	a03d                	j	9f0 <malloc+0xdc>
 9c4:	74a2                	ld	s1,40(sp)
 9c6:	6a42                	ld	s4,16(sp)
 9c8:	6aa2                	ld	s5,8(sp)
 9ca:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9cc:	fae90fe3          	beq	s2,a4,98a <malloc+0x76>
        p->s.size -= nunits;
 9d0:	4137073b          	subw	a4,a4,s3
 9d4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9d6:	02071693          	slli	a3,a4,0x20
 9da:	01c6d713          	srli	a4,a3,0x1c
 9de:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9e0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9e4:	00000717          	auipc	a4,0x0
 9e8:	60a73e23          	sd	a0,1564(a4) # 1000 <freep>
      return (void*)(p + 1);
 9ec:	01078513          	addi	a0,a5,16
  }
}
 9f0:	70e2                	ld	ra,56(sp)
 9f2:	7442                	ld	s0,48(sp)
 9f4:	7902                	ld	s2,32(sp)
 9f6:	69e2                	ld	s3,24(sp)
 9f8:	6121                	addi	sp,sp,64
 9fa:	8082                	ret
 9fc:	74a2                	ld	s1,40(sp)
 9fe:	6a42                	ld	s4,16(sp)
 a00:	6aa2                	ld	s5,8(sp)
 a02:	6b02                	ld	s6,0(sp)
 a04:	b7f5                	j	9f0 <malloc+0xdc>

0000000000000a06 <statistics>:
#include "kernel/fcntl.h"
#include "user/user.h"

int
statistics(void *buf, int sz)
{
 a06:	7179                	addi	sp,sp,-48
 a08:	f406                	sd	ra,40(sp)
 a0a:	f022                	sd	s0,32(sp)
 a0c:	ec26                	sd	s1,24(sp)
 a0e:	e84a                	sd	s2,16(sp)
 a10:	e44e                	sd	s3,8(sp)
 a12:	e052                	sd	s4,0(sp)
 a14:	1800                	addi	s0,sp,48
 a16:	8a2a                	mv	s4,a0
 a18:	892e                	mv	s2,a1
  int fd, i, n;
  
  fd = open("statistics", O_RDONLY);
 a1a:	4581                	li	a1,0
 a1c:	00000517          	auipc	a0,0x0
 a20:	0b450513          	addi	a0,a0,180 # ad0 <statistics+0xca>
 a24:	9d5ff0ef          	jal	3f8 <open>
  if(fd < 0) {
 a28:	02054e63          	bltz	a0,a64 <statistics+0x5e>
 a2c:	89aa                	mv	s3,a0
      fprintf(2, "stats: open failed\n");
      exit(1);
  }
  for (i = 0; i < sz; ) {
 a2e:	4481                	li	s1,0
 a30:	01205e63          	blez	s2,a4c <statistics+0x46>
    if ((n = read(fd, buf+i, sz-i)) < 0) {
 a34:	4099063b          	subw	a2,s2,s1
 a38:	009a05b3          	add	a1,s4,s1
 a3c:	854e                	mv	a0,s3
 a3e:	993ff0ef          	jal	3d0 <read>
 a42:	00054563          	bltz	a0,a4c <statistics+0x46>
      break;
    }
    i += n;
 a46:	9ca9                	addw	s1,s1,a0
  for (i = 0; i < sz; ) {
 a48:	ff24c6e3          	blt	s1,s2,a34 <statistics+0x2e>
  }
  close(fd);
 a4c:	854e                	mv	a0,s3
 a4e:	993ff0ef          	jal	3e0 <close>
  return i;
}
 a52:	8526                	mv	a0,s1
 a54:	70a2                	ld	ra,40(sp)
 a56:	7402                	ld	s0,32(sp)
 a58:	64e2                	ld	s1,24(sp)
 a5a:	6942                	ld	s2,16(sp)
 a5c:	69a2                	ld	s3,8(sp)
 a5e:	6a02                	ld	s4,0(sp)
 a60:	6145                	addi	sp,sp,48
 a62:	8082                	ret
      fprintf(2, "stats: open failed\n");
 a64:	00000597          	auipc	a1,0x0
 a68:	07c58593          	addi	a1,a1,124 # ae0 <statistics+0xda>
 a6c:	4509                	li	a0,2
 a6e:	dc1ff0ef          	jal	82e <fprintf>
      exit(1);
 a72:	4505                	li	a0,1
 a74:	945ff0ef          	jal	3b8 <exit>
