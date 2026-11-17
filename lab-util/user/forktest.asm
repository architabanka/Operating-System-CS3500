
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:

#define N  1000

void
print(const char *s)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
  write(1, s, strlen(s));
   c:	12a000ef          	jal	136 <strlen>
  10:	862a                	mv	a2,a0
  12:	85a6                	mv	a1,s1
  14:	4505                	li	a0,1
  16:	396000ef          	jal	3ac <write>
}
  1a:	60e2                	ld	ra,24(sp)
  1c:	6442                	ld	s0,16(sp)
  1e:	64a2                	ld	s1,8(sp)
  20:	6105                	addi	sp,sp,32
  22:	8082                	ret

0000000000000024 <forktest>:

void
forktest(void)
{
  24:	1101                	addi	sp,sp,-32
  26:	ec06                	sd	ra,24(sp)
  28:	e822                	sd	s0,16(sp)
  2a:	e426                	sd	s1,8(sp)
  2c:	e04a                	sd	s2,0(sp)
  2e:	1000                	addi	s0,sp,32
  int n, pid;

  print("fork test\n");
  30:	00000517          	auipc	a0,0x0
  34:	40050513          	addi	a0,a0,1024 # 430 <uptime+0xc>
  38:	fc9ff0ef          	jal	0 <print>

  for(n=0; n<N; n++){
  3c:	4481                	li	s1,0
  3e:	3e800913          	li	s2,1000
    pid = fork();
  42:	342000ef          	jal	384 <fork>
    if(pid < 0)
  46:	04054363          	bltz	a0,8c <forktest+0x68>
      break;
    if(pid == 0)
  4a:	cd09                	beqz	a0,64 <forktest+0x40>
  for(n=0; n<N; n++){
  4c:	2485                	addiw	s1,s1,1
  4e:	ff249ae3          	bne	s1,s2,42 <forktest+0x1e>
      exit(0);
  }

  if(n == N){
    print("fork claimed to work N times!\n");
  52:	00000517          	auipc	a0,0x0
  56:	42e50513          	addi	a0,a0,1070 # 480 <uptime+0x5c>
  5a:	fa7ff0ef          	jal	0 <print>
    exit(1);
  5e:	4505                	li	a0,1
  60:	32c000ef          	jal	38c <exit>
      exit(0);
  64:	328000ef          	jal	38c <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
      print("wait stopped early\n");
  68:	00000517          	auipc	a0,0x0
  6c:	3d850513          	addi	a0,a0,984 # 440 <uptime+0x1c>
  70:	f91ff0ef          	jal	0 <print>
      exit(1);
  74:	4505                	li	a0,1
  76:	316000ef          	jal	38c <exit>
    }
  }

  if(wait(0) != -1){
    print("wait got too many\n");
  7a:	00000517          	auipc	a0,0x0
  7e:	3de50513          	addi	a0,a0,990 # 458 <uptime+0x34>
  82:	f7fff0ef          	jal	0 <print>
    exit(1);
  86:	4505                	li	a0,1
  88:	304000ef          	jal	38c <exit>
  for(; n > 0; n--){
  8c:	00905963          	blez	s1,9e <forktest+0x7a>
    if(wait(0) < 0){
  90:	4501                	li	a0,0
  92:	302000ef          	jal	394 <wait>
  96:	fc0549e3          	bltz	a0,68 <forktest+0x44>
  for(; n > 0; n--){
  9a:	34fd                	addiw	s1,s1,-1
  9c:	f8f5                	bnez	s1,90 <forktest+0x6c>
  if(wait(0) != -1){
  9e:	4501                	li	a0,0
  a0:	2f4000ef          	jal	394 <wait>
  a4:	57fd                	li	a5,-1
  a6:	fcf51ae3          	bne	a0,a5,7a <forktest+0x56>
  }

  print("fork test OK\n");
  aa:	00000517          	auipc	a0,0x0
  ae:	3c650513          	addi	a0,a0,966 # 470 <uptime+0x4c>
  b2:	f4fff0ef          	jal	0 <print>
}
  b6:	60e2                	ld	ra,24(sp)
  b8:	6442                	ld	s0,16(sp)
  ba:	64a2                	ld	s1,8(sp)
  bc:	6902                	ld	s2,0(sp)
  be:	6105                	addi	sp,sp,32
  c0:	8082                	ret

00000000000000c2 <main>:

int
main(void)
{
  c2:	1141                	addi	sp,sp,-16
  c4:	e406                	sd	ra,8(sp)
  c6:	e022                	sd	s0,0(sp)
  c8:	0800                	addi	s0,sp,16
  forktest();
  ca:	f5bff0ef          	jal	24 <forktest>
  exit(0);
  ce:	4501                	li	a0,0
  d0:	2bc000ef          	jal	38c <exit>

00000000000000d4 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  d4:	1141                	addi	sp,sp,-16
  d6:	e406                	sd	ra,8(sp)
  d8:	e022                	sd	s0,0(sp)
  da:	0800                	addi	s0,sp,16
  extern int main();
  main();
  dc:	fe7ff0ef          	jal	c2 <main>
  exit(0);
  e0:	4501                	li	a0,0
  e2:	2aa000ef          	jal	38c <exit>

00000000000000e6 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  e6:	1141                	addi	sp,sp,-16
  e8:	e406                	sd	ra,8(sp)
  ea:	e022                	sd	s0,0(sp)
  ec:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ee:	87aa                	mv	a5,a0
  f0:	0585                	addi	a1,a1,1
  f2:	0785                	addi	a5,a5,1
  f4:	fff5c703          	lbu	a4,-1(a1)
  f8:	fee78fa3          	sb	a4,-1(a5)
  fc:	fb75                	bnez	a4,f0 <strcpy+0xa>
    ;
  return os;
}
  fe:	60a2                	ld	ra,8(sp)
 100:	6402                	ld	s0,0(sp)
 102:	0141                	addi	sp,sp,16
 104:	8082                	ret

0000000000000106 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 106:	1141                	addi	sp,sp,-16
 108:	e406                	sd	ra,8(sp)
 10a:	e022                	sd	s0,0(sp)
 10c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 10e:	00054783          	lbu	a5,0(a0)
 112:	cb91                	beqz	a5,126 <strcmp+0x20>
 114:	0005c703          	lbu	a4,0(a1)
 118:	00f71763          	bne	a4,a5,126 <strcmp+0x20>
    p++, q++;
 11c:	0505                	addi	a0,a0,1
 11e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 120:	00054783          	lbu	a5,0(a0)
 124:	fbe5                	bnez	a5,114 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 126:	0005c503          	lbu	a0,0(a1)
}
 12a:	40a7853b          	subw	a0,a5,a0
 12e:	60a2                	ld	ra,8(sp)
 130:	6402                	ld	s0,0(sp)
 132:	0141                	addi	sp,sp,16
 134:	8082                	ret

0000000000000136 <strlen>:

uint
strlen(const char *s)
{
 136:	1141                	addi	sp,sp,-16
 138:	e406                	sd	ra,8(sp)
 13a:	e022                	sd	s0,0(sp)
 13c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 13e:	00054783          	lbu	a5,0(a0)
 142:	cf91                	beqz	a5,15e <strlen+0x28>
 144:	00150793          	addi	a5,a0,1
 148:	86be                	mv	a3,a5
 14a:	0785                	addi	a5,a5,1
 14c:	fff7c703          	lbu	a4,-1(a5)
 150:	ff65                	bnez	a4,148 <strlen+0x12>
 152:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 156:	60a2                	ld	ra,8(sp)
 158:	6402                	ld	s0,0(sp)
 15a:	0141                	addi	sp,sp,16
 15c:	8082                	ret
  for(n = 0; s[n]; n++)
 15e:	4501                	li	a0,0
 160:	bfdd                	j	156 <strlen+0x20>

0000000000000162 <memset>:

void*
memset(void *dst, int c, uint n)
{
 162:	1141                	addi	sp,sp,-16
 164:	e406                	sd	ra,8(sp)
 166:	e022                	sd	s0,0(sp)
 168:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 16a:	ca19                	beqz	a2,180 <memset+0x1e>
 16c:	87aa                	mv	a5,a0
 16e:	1602                	slli	a2,a2,0x20
 170:	9201                	srli	a2,a2,0x20
 172:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 176:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 17a:	0785                	addi	a5,a5,1
 17c:	fee79de3          	bne	a5,a4,176 <memset+0x14>
  }
  return dst;
}
 180:	60a2                	ld	ra,8(sp)
 182:	6402                	ld	s0,0(sp)
 184:	0141                	addi	sp,sp,16
 186:	8082                	ret

0000000000000188 <strchr>:

char*
strchr(const char *s, char c)
{
 188:	1141                	addi	sp,sp,-16
 18a:	e406                	sd	ra,8(sp)
 18c:	e022                	sd	s0,0(sp)
 18e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 190:	00054783          	lbu	a5,0(a0)
 194:	c799                	beqz	a5,1a2 <strchr+0x1a>
    if(*s == c)
 196:	00f58763          	beq	a1,a5,1a4 <strchr+0x1c>
  for(; *s; s++)
 19a:	0505                	addi	a0,a0,1
 19c:	00054783          	lbu	a5,0(a0)
 1a0:	fbfd                	bnez	a5,196 <strchr+0xe>
      return (char*)s;
  return 0;
 1a2:	4501                	li	a0,0
}
 1a4:	60a2                	ld	ra,8(sp)
 1a6:	6402                	ld	s0,0(sp)
 1a8:	0141                	addi	sp,sp,16
 1aa:	8082                	ret

00000000000001ac <gets>:

char*
gets(char *buf, int max)
{
 1ac:	711d                	addi	sp,sp,-96
 1ae:	ec86                	sd	ra,88(sp)
 1b0:	e8a2                	sd	s0,80(sp)
 1b2:	e4a6                	sd	s1,72(sp)
 1b4:	e0ca                	sd	s2,64(sp)
 1b6:	fc4e                	sd	s3,56(sp)
 1b8:	f852                	sd	s4,48(sp)
 1ba:	f456                	sd	s5,40(sp)
 1bc:	f05a                	sd	s6,32(sp)
 1be:	ec5e                	sd	s7,24(sp)
 1c0:	e862                	sd	s8,16(sp)
 1c2:	1080                	addi	s0,sp,96
 1c4:	8baa                	mv	s7,a0
 1c6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c8:	892a                	mv	s2,a0
 1ca:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1cc:	faf40b13          	addi	s6,s0,-81
 1d0:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 1d2:	8c26                	mv	s8,s1
 1d4:	0014899b          	addiw	s3,s1,1
 1d8:	84ce                	mv	s1,s3
 1da:	0349d863          	bge	s3,s4,20a <gets+0x5e>
    cc = read(0, &c, 1);
 1de:	8656                	mv	a2,s5
 1e0:	85da                	mv	a1,s6
 1e2:	4501                	li	a0,0
 1e4:	1c0000ef          	jal	3a4 <read>
    if(cc < 1)
 1e8:	02a05163          	blez	a0,20a <gets+0x5e>
      break;
    buf[i++] = c;
 1ec:	faf44783          	lbu	a5,-81(s0)
 1f0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1f4:	0905                	addi	s2,s2,1
 1f6:	ff678713          	addi	a4,a5,-10
 1fa:	00173713          	seqz	a4,a4
 1fe:	17cd                	addi	a5,a5,-13
 200:	0017b793          	seqz	a5,a5
 204:	8fd9                	or	a5,a5,a4
 206:	d7f1                	beqz	a5,1d2 <gets+0x26>
    buf[i++] = c;
 208:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 20a:	9c5e                	add	s8,s8,s7
 20c:	000c0023          	sb	zero,0(s8)
  return buf;
}
 210:	855e                	mv	a0,s7
 212:	60e6                	ld	ra,88(sp)
 214:	6446                	ld	s0,80(sp)
 216:	64a6                	ld	s1,72(sp)
 218:	6906                	ld	s2,64(sp)
 21a:	79e2                	ld	s3,56(sp)
 21c:	7a42                	ld	s4,48(sp)
 21e:	7aa2                	ld	s5,40(sp)
 220:	7b02                	ld	s6,32(sp)
 222:	6be2                	ld	s7,24(sp)
 224:	6c42                	ld	s8,16(sp)
 226:	6125                	addi	sp,sp,96
 228:	8082                	ret

000000000000022a <stat>:

int
stat(const char *n, struct stat *st)
{
 22a:	1101                	addi	sp,sp,-32
 22c:	ec06                	sd	ra,24(sp)
 22e:	e822                	sd	s0,16(sp)
 230:	e04a                	sd	s2,0(sp)
 232:	1000                	addi	s0,sp,32
 234:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 236:	4581                	li	a1,0
 238:	194000ef          	jal	3cc <open>
  if(fd < 0)
 23c:	02054263          	bltz	a0,260 <stat+0x36>
 240:	e426                	sd	s1,8(sp)
 242:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 244:	85ca                	mv	a1,s2
 246:	19e000ef          	jal	3e4 <fstat>
 24a:	892a                	mv	s2,a0
  close(fd);
 24c:	8526                	mv	a0,s1
 24e:	166000ef          	jal	3b4 <close>
  return r;
 252:	64a2                	ld	s1,8(sp)
}
 254:	854a                	mv	a0,s2
 256:	60e2                	ld	ra,24(sp)
 258:	6442                	ld	s0,16(sp)
 25a:	6902                	ld	s2,0(sp)
 25c:	6105                	addi	sp,sp,32
 25e:	8082                	ret
    return -1;
 260:	57fd                	li	a5,-1
 262:	893e                	mv	s2,a5
 264:	bfc5                	j	254 <stat+0x2a>

0000000000000266 <atoi>:

int
atoi(const char *s)
{
 266:	1141                	addi	sp,sp,-16
 268:	e406                	sd	ra,8(sp)
 26a:	e022                	sd	s0,0(sp)
 26c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26e:	00054683          	lbu	a3,0(a0)
 272:	fd06879b          	addiw	a5,a3,-48
 276:	0ff7f793          	zext.b	a5,a5
 27a:	4625                	li	a2,9
 27c:	02f66963          	bltu	a2,a5,2ae <atoi+0x48>
 280:	872a                	mv	a4,a0
  n = 0;
 282:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 284:	0705                	addi	a4,a4,1
 286:	0025179b          	slliw	a5,a0,0x2
 28a:	9fa9                	addw	a5,a5,a0
 28c:	0017979b          	slliw	a5,a5,0x1
 290:	9fb5                	addw	a5,a5,a3
 292:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 296:	00074683          	lbu	a3,0(a4)
 29a:	fd06879b          	addiw	a5,a3,-48
 29e:	0ff7f793          	zext.b	a5,a5
 2a2:	fef671e3          	bgeu	a2,a5,284 <atoi+0x1e>
  return n;
}
 2a6:	60a2                	ld	ra,8(sp)
 2a8:	6402                	ld	s0,0(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret
  n = 0;
 2ae:	4501                	li	a0,0
 2b0:	bfdd                	j	2a6 <atoi+0x40>

00000000000002b2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2b2:	1141                	addi	sp,sp,-16
 2b4:	e406                	sd	ra,8(sp)
 2b6:	e022                	sd	s0,0(sp)
 2b8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2ba:	02b57563          	bgeu	a0,a1,2e4 <memmove+0x32>
    while(n-- > 0)
 2be:	00c05f63          	blez	a2,2dc <memmove+0x2a>
 2c2:	1602                	slli	a2,a2,0x20
 2c4:	9201                	srli	a2,a2,0x20
 2c6:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2ca:	872a                	mv	a4,a0
      *dst++ = *src++;
 2cc:	0585                	addi	a1,a1,1
 2ce:	0705                	addi	a4,a4,1
 2d0:	fff5c683          	lbu	a3,-1(a1)
 2d4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2d8:	fee79ae3          	bne	a5,a4,2cc <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2dc:	60a2                	ld	ra,8(sp)
 2de:	6402                	ld	s0,0(sp)
 2e0:	0141                	addi	sp,sp,16
 2e2:	8082                	ret
    while(n-- > 0)
 2e4:	fec05ce3          	blez	a2,2dc <memmove+0x2a>
    dst += n;
 2e8:	00c50733          	add	a4,a0,a2
    src += n;
 2ec:	95b2                	add	a1,a1,a2
 2ee:	fff6079b          	addiw	a5,a2,-1
 2f2:	1782                	slli	a5,a5,0x20
 2f4:	9381                	srli	a5,a5,0x20
 2f6:	fff7c793          	not	a5,a5
 2fa:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2fc:	15fd                	addi	a1,a1,-1
 2fe:	177d                	addi	a4,a4,-1
 300:	0005c683          	lbu	a3,0(a1)
 304:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 308:	fef71ae3          	bne	a4,a5,2fc <memmove+0x4a>
 30c:	bfc1                	j	2dc <memmove+0x2a>

000000000000030e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 30e:	1141                	addi	sp,sp,-16
 310:	e406                	sd	ra,8(sp)
 312:	e022                	sd	s0,0(sp)
 314:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 316:	ce19                	beqz	a2,334 <memcmp+0x26>
 318:	1602                	slli	a2,a2,0x20
 31a:	9201                	srli	a2,a2,0x20
 31c:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 320:	00054783          	lbu	a5,0(a0)
 324:	0005c703          	lbu	a4,0(a1)
 328:	00e79b63          	bne	a5,a4,33e <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 32c:	0505                	addi	a0,a0,1
    p2++;
 32e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 330:	fed518e3          	bne	a0,a3,320 <memcmp+0x12>
  }
  return 0;
 334:	4501                	li	a0,0
}
 336:	60a2                	ld	ra,8(sp)
 338:	6402                	ld	s0,0(sp)
 33a:	0141                	addi	sp,sp,16
 33c:	8082                	ret
      return *p1 - *p2;
 33e:	40e7853b          	subw	a0,a5,a4
 342:	bfd5                	j	336 <memcmp+0x28>

0000000000000344 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 344:	1141                	addi	sp,sp,-16
 346:	e406                	sd	ra,8(sp)
 348:	e022                	sd	s0,0(sp)
 34a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 34c:	f67ff0ef          	jal	2b2 <memmove>
}
 350:	60a2                	ld	ra,8(sp)
 352:	6402                	ld	s0,0(sp)
 354:	0141                	addi	sp,sp,16
 356:	8082                	ret

0000000000000358 <sbrk>:

char *
sbrk(int n) {
 358:	1141                	addi	sp,sp,-16
 35a:	e406                	sd	ra,8(sp)
 35c:	e022                	sd	s0,0(sp)
 35e:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 360:	4585                	li	a1,1
 362:	0b2000ef          	jal	414 <sys_sbrk>
}
 366:	60a2                	ld	ra,8(sp)
 368:	6402                	ld	s0,0(sp)
 36a:	0141                	addi	sp,sp,16
 36c:	8082                	ret

000000000000036e <sbrklazy>:

char *
sbrklazy(int n) {
 36e:	1141                	addi	sp,sp,-16
 370:	e406                	sd	ra,8(sp)
 372:	e022                	sd	s0,0(sp)
 374:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 376:	4589                	li	a1,2
 378:	09c000ef          	jal	414 <sys_sbrk>
}
 37c:	60a2                	ld	ra,8(sp)
 37e:	6402                	ld	s0,0(sp)
 380:	0141                	addi	sp,sp,16
 382:	8082                	ret

0000000000000384 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 384:	4885                	li	a7,1
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <exit>:
.global exit
exit:
 li a7, SYS_exit
 38c:	4889                	li	a7,2
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <wait>:
.global wait
wait:
 li a7, SYS_wait
 394:	488d                	li	a7,3
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 39c:	4891                	li	a7,4
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <read>:
.global read
read:
 li a7, SYS_read
 3a4:	4895                	li	a7,5
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <write>:
.global write
write:
 li a7, SYS_write
 3ac:	48c1                	li	a7,16
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <close>:
.global close
close:
 li a7, SYS_close
 3b4:	48d5                	li	a7,21
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <kill>:
.global kill
kill:
 li a7, SYS_kill
 3bc:	4899                	li	a7,6
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3c4:	489d                	li	a7,7
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <open>:
.global open
open:
 li a7, SYS_open
 3cc:	48bd                	li	a7,15
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3d4:	48c5                	li	a7,17
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3dc:	48c9                	li	a7,18
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3e4:	48a1                	li	a7,8
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <link>:
.global link
link:
 li a7, SYS_link
 3ec:	48cd                	li	a7,19
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3f4:	48d1                	li	a7,20
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3fc:	48a5                	li	a7,9
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <dup>:
.global dup
dup:
 li a7, SYS_dup
 404:	48a9                	li	a7,10
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 40c:	48ad                	li	a7,11
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 414:	48b1                	li	a7,12
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <pause>:
.global pause
pause:
 li a7, SYS_pause
 41c:	48b5                	li	a7,13
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 424:	48b9                	li	a7,14
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret
