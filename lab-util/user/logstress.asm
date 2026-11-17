
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
  20:	392000ef          	jal	3b2 <fork>
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
  42:	99250513          	addi	a0,a0,-1646 # 9d0 <malloc+0xfc>
  46:	7d2000ef          	jal	818 <printf>
      exit(1);
  4a:	4505                	li	a0,1
  4c:	36e000ef          	jal	3ba <exit>
      fd = open(argv[i], O_CREATE | O_RDWR);
  50:	00349913          	slli	s2,s1,0x3
  54:	9952                	add	s2,s2,s4
  56:	20200593          	li	a1,514
  5a:	00093503          	ld	a0,0(s2)
  5e:	39c000ef          	jal	3fa <open>
  62:	89aa                	mv	s3,a0
      if(fd < 0){
  64:	04054063          	bltz	a0,a4 <main+0xa4>
      memset(buf, '0'+i, SZ);
  68:	7d000613          	li	a2,2000
  6c:	0304859b          	addiw	a1,s1,48
  70:	00001517          	auipc	a0,0x1
  74:	fa050513          	addi	a0,a0,-96 # 1010 <buf>
  78:	118000ef          	jal	190 <memset>
  7c:	0fa00493          	li	s1,250
        if((n = write(fd, buf, SZ)) != SZ){
  80:	7d000913          	li	s2,2000
  84:	00001a17          	auipc	s4,0x1
  88:	f8ca0a13          	addi	s4,s4,-116 # 1010 <buf>
  8c:	864a                	mv	a2,s2
  8e:	85d2                	mv	a1,s4
  90:	854e                	mv	a0,s3
  92:	348000ef          	jal	3da <write>
  96:	03251463          	bne	a0,s2,be <main+0xbe>
      for(i = 0; i < N; i++){
  9a:	34fd                	addiw	s1,s1,-1
  9c:	f8e5                	bnez	s1,8c <main+0x8c>
      exit(0);
  9e:	4501                	li	a0,0
  a0:	31a000ef          	jal	3ba <exit>
        printf("%s: create %s failed\n", argv[0], argv[i]);
  a4:	00093603          	ld	a2,0(s2)
  a8:	000a3583          	ld	a1,0(s4)
  ac:	00001517          	auipc	a0,0x1
  b0:	93c50513          	addi	a0,a0,-1732 # 9e8 <malloc+0x114>
  b4:	764000ef          	jal	818 <printf>
        exit(1);
  b8:	4505                	li	a0,1
  ba:	300000ef          	jal	3ba <exit>
          printf("write failed %d\n", n);
  be:	85aa                	mv	a1,a0
  c0:	00001517          	auipc	a0,0x1
  c4:	94050513          	addi	a0,a0,-1728 # a00 <malloc+0x12c>
  c8:	750000ef          	jal	818 <printf>
          exit(1);
  cc:	4505                	li	a0,1
  ce:	2ec000ef          	jal	3ba <exit>
  for(int i = 1; i < argc; i++){
  d2:	893e                	mv	s2,a5
    wait(&xstatus);
  d4:	854e                	mv	a0,s3
  d6:	2ec000ef          	jal	3c2 <wait>
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
  fa:	2c0000ef          	jal	3ba <exit>
}
  fe:	4501                	li	a0,0
 100:	8082                	ret

0000000000000102 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 102:	1141                	addi	sp,sp,-16
 104:	e406                	sd	ra,8(sp)
 106:	e022                	sd	s0,0(sp)
 108:	0800                	addi	s0,sp,16
  extern int main();
  main();
 10a:	ef7ff0ef          	jal	0 <main>
  exit(0);
 10e:	4501                	li	a0,0
 110:	2aa000ef          	jal	3ba <exit>

0000000000000114 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 114:	1141                	addi	sp,sp,-16
 116:	e406                	sd	ra,8(sp)
 118:	e022                	sd	s0,0(sp)
 11a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11c:	87aa                	mv	a5,a0
 11e:	0585                	addi	a1,a1,1
 120:	0785                	addi	a5,a5,1
 122:	fff5c703          	lbu	a4,-1(a1)
 126:	fee78fa3          	sb	a4,-1(a5)
 12a:	fb75                	bnez	a4,11e <strcpy+0xa>
    ;
  return os;
}
 12c:	60a2                	ld	ra,8(sp)
 12e:	6402                	ld	s0,0(sp)
 130:	0141                	addi	sp,sp,16
 132:	8082                	ret

0000000000000134 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 134:	1141                	addi	sp,sp,-16
 136:	e406                	sd	ra,8(sp)
 138:	e022                	sd	s0,0(sp)
 13a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 13c:	00054783          	lbu	a5,0(a0)
 140:	cb91                	beqz	a5,154 <strcmp+0x20>
 142:	0005c703          	lbu	a4,0(a1)
 146:	00f71763          	bne	a4,a5,154 <strcmp+0x20>
    p++, q++;
 14a:	0505                	addi	a0,a0,1
 14c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 14e:	00054783          	lbu	a5,0(a0)
 152:	fbe5                	bnez	a5,142 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 154:	0005c503          	lbu	a0,0(a1)
}
 158:	40a7853b          	subw	a0,a5,a0
 15c:	60a2                	ld	ra,8(sp)
 15e:	6402                	ld	s0,0(sp)
 160:	0141                	addi	sp,sp,16
 162:	8082                	ret

0000000000000164 <strlen>:

uint
strlen(const char *s)
{
 164:	1141                	addi	sp,sp,-16
 166:	e406                	sd	ra,8(sp)
 168:	e022                	sd	s0,0(sp)
 16a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 16c:	00054783          	lbu	a5,0(a0)
 170:	cf91                	beqz	a5,18c <strlen+0x28>
 172:	00150793          	addi	a5,a0,1
 176:	86be                	mv	a3,a5
 178:	0785                	addi	a5,a5,1
 17a:	fff7c703          	lbu	a4,-1(a5)
 17e:	ff65                	bnez	a4,176 <strlen+0x12>
 180:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 184:	60a2                	ld	ra,8(sp)
 186:	6402                	ld	s0,0(sp)
 188:	0141                	addi	sp,sp,16
 18a:	8082                	ret
  for(n = 0; s[n]; n++)
 18c:	4501                	li	a0,0
 18e:	bfdd                	j	184 <strlen+0x20>

0000000000000190 <memset>:

void*
memset(void *dst, int c, uint n)
{
 190:	1141                	addi	sp,sp,-16
 192:	e406                	sd	ra,8(sp)
 194:	e022                	sd	s0,0(sp)
 196:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 198:	ca19                	beqz	a2,1ae <memset+0x1e>
 19a:	87aa                	mv	a5,a0
 19c:	1602                	slli	a2,a2,0x20
 19e:	9201                	srli	a2,a2,0x20
 1a0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1a4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1a8:	0785                	addi	a5,a5,1
 1aa:	fee79de3          	bne	a5,a4,1a4 <memset+0x14>
  }
  return dst;
}
 1ae:	60a2                	ld	ra,8(sp)
 1b0:	6402                	ld	s0,0(sp)
 1b2:	0141                	addi	sp,sp,16
 1b4:	8082                	ret

00000000000001b6 <strchr>:

char*
strchr(const char *s, char c)
{
 1b6:	1141                	addi	sp,sp,-16
 1b8:	e406                	sd	ra,8(sp)
 1ba:	e022                	sd	s0,0(sp)
 1bc:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1be:	00054783          	lbu	a5,0(a0)
 1c2:	c799                	beqz	a5,1d0 <strchr+0x1a>
    if(*s == c)
 1c4:	00f58763          	beq	a1,a5,1d2 <strchr+0x1c>
  for(; *s; s++)
 1c8:	0505                	addi	a0,a0,1
 1ca:	00054783          	lbu	a5,0(a0)
 1ce:	fbfd                	bnez	a5,1c4 <strchr+0xe>
      return (char*)s;
  return 0;
 1d0:	4501                	li	a0,0
}
 1d2:	60a2                	ld	ra,8(sp)
 1d4:	6402                	ld	s0,0(sp)
 1d6:	0141                	addi	sp,sp,16
 1d8:	8082                	ret

00000000000001da <gets>:

char*
gets(char *buf, int max)
{
 1da:	711d                	addi	sp,sp,-96
 1dc:	ec86                	sd	ra,88(sp)
 1de:	e8a2                	sd	s0,80(sp)
 1e0:	e4a6                	sd	s1,72(sp)
 1e2:	e0ca                	sd	s2,64(sp)
 1e4:	fc4e                	sd	s3,56(sp)
 1e6:	f852                	sd	s4,48(sp)
 1e8:	f456                	sd	s5,40(sp)
 1ea:	f05a                	sd	s6,32(sp)
 1ec:	ec5e                	sd	s7,24(sp)
 1ee:	e862                	sd	s8,16(sp)
 1f0:	1080                	addi	s0,sp,96
 1f2:	8baa                	mv	s7,a0
 1f4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f6:	892a                	mv	s2,a0
 1f8:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1fa:	faf40b13          	addi	s6,s0,-81
 1fe:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 200:	8c26                	mv	s8,s1
 202:	0014899b          	addiw	s3,s1,1
 206:	84ce                	mv	s1,s3
 208:	0349d863          	bge	s3,s4,238 <gets+0x5e>
    cc = read(0, &c, 1);
 20c:	8656                	mv	a2,s5
 20e:	85da                	mv	a1,s6
 210:	4501                	li	a0,0
 212:	1c0000ef          	jal	3d2 <read>
    if(cc < 1)
 216:	02a05163          	blez	a0,238 <gets+0x5e>
      break;
    buf[i++] = c;
 21a:	faf44783          	lbu	a5,-81(s0)
 21e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 222:	0905                	addi	s2,s2,1
 224:	ff678713          	addi	a4,a5,-10
 228:	00173713          	seqz	a4,a4
 22c:	17cd                	addi	a5,a5,-13
 22e:	0017b793          	seqz	a5,a5
 232:	8fd9                	or	a5,a5,a4
 234:	d7f1                	beqz	a5,200 <gets+0x26>
    buf[i++] = c;
 236:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 238:	9c5e                	add	s8,s8,s7
 23a:	000c0023          	sb	zero,0(s8)
  return buf;
}
 23e:	855e                	mv	a0,s7
 240:	60e6                	ld	ra,88(sp)
 242:	6446                	ld	s0,80(sp)
 244:	64a6                	ld	s1,72(sp)
 246:	6906                	ld	s2,64(sp)
 248:	79e2                	ld	s3,56(sp)
 24a:	7a42                	ld	s4,48(sp)
 24c:	7aa2                	ld	s5,40(sp)
 24e:	7b02                	ld	s6,32(sp)
 250:	6be2                	ld	s7,24(sp)
 252:	6c42                	ld	s8,16(sp)
 254:	6125                	addi	sp,sp,96
 256:	8082                	ret

0000000000000258 <stat>:

int
stat(const char *n, struct stat *st)
{
 258:	1101                	addi	sp,sp,-32
 25a:	ec06                	sd	ra,24(sp)
 25c:	e822                	sd	s0,16(sp)
 25e:	e04a                	sd	s2,0(sp)
 260:	1000                	addi	s0,sp,32
 262:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 264:	4581                	li	a1,0
 266:	194000ef          	jal	3fa <open>
  if(fd < 0)
 26a:	02054263          	bltz	a0,28e <stat+0x36>
 26e:	e426                	sd	s1,8(sp)
 270:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 272:	85ca                	mv	a1,s2
 274:	19e000ef          	jal	412 <fstat>
 278:	892a                	mv	s2,a0
  close(fd);
 27a:	8526                	mv	a0,s1
 27c:	166000ef          	jal	3e2 <close>
  return r;
 280:	64a2                	ld	s1,8(sp)
}
 282:	854a                	mv	a0,s2
 284:	60e2                	ld	ra,24(sp)
 286:	6442                	ld	s0,16(sp)
 288:	6902                	ld	s2,0(sp)
 28a:	6105                	addi	sp,sp,32
 28c:	8082                	ret
    return -1;
 28e:	57fd                	li	a5,-1
 290:	893e                	mv	s2,a5
 292:	bfc5                	j	282 <stat+0x2a>

0000000000000294 <atoi>:

int
atoi(const char *s)
{
 294:	1141                	addi	sp,sp,-16
 296:	e406                	sd	ra,8(sp)
 298:	e022                	sd	s0,0(sp)
 29a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29c:	00054683          	lbu	a3,0(a0)
 2a0:	fd06879b          	addiw	a5,a3,-48
 2a4:	0ff7f793          	zext.b	a5,a5
 2a8:	4625                	li	a2,9
 2aa:	02f66963          	bltu	a2,a5,2dc <atoi+0x48>
 2ae:	872a                	mv	a4,a0
  n = 0;
 2b0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2b2:	0705                	addi	a4,a4,1
 2b4:	0025179b          	slliw	a5,a0,0x2
 2b8:	9fa9                	addw	a5,a5,a0
 2ba:	0017979b          	slliw	a5,a5,0x1
 2be:	9fb5                	addw	a5,a5,a3
 2c0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2c4:	00074683          	lbu	a3,0(a4)
 2c8:	fd06879b          	addiw	a5,a3,-48
 2cc:	0ff7f793          	zext.b	a5,a5
 2d0:	fef671e3          	bgeu	a2,a5,2b2 <atoi+0x1e>
  return n;
}
 2d4:	60a2                	ld	ra,8(sp)
 2d6:	6402                	ld	s0,0(sp)
 2d8:	0141                	addi	sp,sp,16
 2da:	8082                	ret
  n = 0;
 2dc:	4501                	li	a0,0
 2de:	bfdd                	j	2d4 <atoi+0x40>

00000000000002e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2e0:	1141                	addi	sp,sp,-16
 2e2:	e406                	sd	ra,8(sp)
 2e4:	e022                	sd	s0,0(sp)
 2e6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2e8:	02b57563          	bgeu	a0,a1,312 <memmove+0x32>
    while(n-- > 0)
 2ec:	00c05f63          	blez	a2,30a <memmove+0x2a>
 2f0:	1602                	slli	a2,a2,0x20
 2f2:	9201                	srli	a2,a2,0x20
 2f4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2f8:	872a                	mv	a4,a0
      *dst++ = *src++;
 2fa:	0585                	addi	a1,a1,1
 2fc:	0705                	addi	a4,a4,1
 2fe:	fff5c683          	lbu	a3,-1(a1)
 302:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 306:	fee79ae3          	bne	a5,a4,2fa <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 30a:	60a2                	ld	ra,8(sp)
 30c:	6402                	ld	s0,0(sp)
 30e:	0141                	addi	sp,sp,16
 310:	8082                	ret
    while(n-- > 0)
 312:	fec05ce3          	blez	a2,30a <memmove+0x2a>
    dst += n;
 316:	00c50733          	add	a4,a0,a2
    src += n;
 31a:	95b2                	add	a1,a1,a2
 31c:	fff6079b          	addiw	a5,a2,-1
 320:	1782                	slli	a5,a5,0x20
 322:	9381                	srli	a5,a5,0x20
 324:	fff7c793          	not	a5,a5
 328:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 32a:	15fd                	addi	a1,a1,-1
 32c:	177d                	addi	a4,a4,-1
 32e:	0005c683          	lbu	a3,0(a1)
 332:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 336:	fef71ae3          	bne	a4,a5,32a <memmove+0x4a>
 33a:	bfc1                	j	30a <memmove+0x2a>

000000000000033c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 33c:	1141                	addi	sp,sp,-16
 33e:	e406                	sd	ra,8(sp)
 340:	e022                	sd	s0,0(sp)
 342:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 344:	ce19                	beqz	a2,362 <memcmp+0x26>
 346:	1602                	slli	a2,a2,0x20
 348:	9201                	srli	a2,a2,0x20
 34a:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 34e:	00054783          	lbu	a5,0(a0)
 352:	0005c703          	lbu	a4,0(a1)
 356:	00e79b63          	bne	a5,a4,36c <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 35a:	0505                	addi	a0,a0,1
    p2++;
 35c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 35e:	fed518e3          	bne	a0,a3,34e <memcmp+0x12>
  }
  return 0;
 362:	4501                	li	a0,0
}
 364:	60a2                	ld	ra,8(sp)
 366:	6402                	ld	s0,0(sp)
 368:	0141                	addi	sp,sp,16
 36a:	8082                	ret
      return *p1 - *p2;
 36c:	40e7853b          	subw	a0,a5,a4
 370:	bfd5                	j	364 <memcmp+0x28>

0000000000000372 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 372:	1141                	addi	sp,sp,-16
 374:	e406                	sd	ra,8(sp)
 376:	e022                	sd	s0,0(sp)
 378:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 37a:	f67ff0ef          	jal	2e0 <memmove>
}
 37e:	60a2                	ld	ra,8(sp)
 380:	6402                	ld	s0,0(sp)
 382:	0141                	addi	sp,sp,16
 384:	8082                	ret

0000000000000386 <sbrk>:

char *
sbrk(int n) {
 386:	1141                	addi	sp,sp,-16
 388:	e406                	sd	ra,8(sp)
 38a:	e022                	sd	s0,0(sp)
 38c:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 38e:	4585                	li	a1,1
 390:	0b2000ef          	jal	442 <sys_sbrk>
}
 394:	60a2                	ld	ra,8(sp)
 396:	6402                	ld	s0,0(sp)
 398:	0141                	addi	sp,sp,16
 39a:	8082                	ret

000000000000039c <sbrklazy>:

char *
sbrklazy(int n) {
 39c:	1141                	addi	sp,sp,-16
 39e:	e406                	sd	ra,8(sp)
 3a0:	e022                	sd	s0,0(sp)
 3a2:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 3a4:	4589                	li	a1,2
 3a6:	09c000ef          	jal	442 <sys_sbrk>
}
 3aa:	60a2                	ld	ra,8(sp)
 3ac:	6402                	ld	s0,0(sp)
 3ae:	0141                	addi	sp,sp,16
 3b0:	8082                	ret

00000000000003b2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3b2:	4885                	li	a7,1
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ba:	4889                	li	a7,2
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3c2:	488d                	li	a7,3
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3ca:	4891                	li	a7,4
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <read>:
.global read
read:
 li a7, SYS_read
 3d2:	4895                	li	a7,5
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <write>:
.global write
write:
 li a7, SYS_write
 3da:	48c1                	li	a7,16
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <close>:
.global close
close:
 li a7, SYS_close
 3e2:	48d5                	li	a7,21
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <kill>:
.global kill
kill:
 li a7, SYS_kill
 3ea:	4899                	li	a7,6
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3f2:	489d                	li	a7,7
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <open>:
.global open
open:
 li a7, SYS_open
 3fa:	48bd                	li	a7,15
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 402:	48c5                	li	a7,17
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 40a:	48c9                	li	a7,18
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 412:	48a1                	li	a7,8
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <link>:
.global link
link:
 li a7, SYS_link
 41a:	48cd                	li	a7,19
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 422:	48d1                	li	a7,20
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 42a:	48a5                	li	a7,9
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <dup>:
.global dup
dup:
 li a7, SYS_dup
 432:	48a9                	li	a7,10
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 43a:	48ad                	li	a7,11
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 442:	48b1                	li	a7,12
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <pause>:
.global pause
pause:
 li a7, SYS_pause
 44a:	48b5                	li	a7,13
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 452:	48b9                	li	a7,14
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 45a:	1101                	addi	sp,sp,-32
 45c:	ec06                	sd	ra,24(sp)
 45e:	e822                	sd	s0,16(sp)
 460:	1000                	addi	s0,sp,32
 462:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 466:	4605                	li	a2,1
 468:	fef40593          	addi	a1,s0,-17
 46c:	f6fff0ef          	jal	3da <write>
}
 470:	60e2                	ld	ra,24(sp)
 472:	6442                	ld	s0,16(sp)
 474:	6105                	addi	sp,sp,32
 476:	8082                	ret

0000000000000478 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 478:	715d                	addi	sp,sp,-80
 47a:	e486                	sd	ra,72(sp)
 47c:	e0a2                	sd	s0,64(sp)
 47e:	f84a                	sd	s2,48(sp)
 480:	f44e                	sd	s3,40(sp)
 482:	0880                	addi	s0,sp,80
 484:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 486:	00d036b3          	snez	a3,a3
 48a:	03f5d793          	srli	a5,a1,0x3f
 48e:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 490:	0005871b          	sext.w	a4,a1
  neg = 0;
 494:	4301                	li	t1,0
  if(sgn && xx < 0){
 496:	c681                	beqz	a3,49e <printint+0x26>
    x = -xx;
 498:	40b0073b          	negw	a4,a1
    neg = 1;
 49c:	4305                	li	t1,1
  }

  i = 0;
 49e:	fb840993          	addi	s3,s0,-72
  neg = 0;
 4a2:	85ce                	mv	a1,s3
  i = 0;
 4a4:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 4a6:	00000817          	auipc	a6,0x0
 4aa:	57a80813          	addi	a6,a6,1402 # a20 <digits>
 4ae:	88b6                	mv	a7,a3
 4b0:	0016851b          	addiw	a0,a3,1
 4b4:	86aa                	mv	a3,a0
 4b6:	02c777bb          	remuw	a5,a4,a2
 4ba:	1782                	slli	a5,a5,0x20
 4bc:	9381                	srli	a5,a5,0x20
 4be:	97c2                	add	a5,a5,a6
 4c0:	0007c783          	lbu	a5,0(a5)
 4c4:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 4c8:	87ba                	mv	a5,a4
 4ca:	02c7573b          	divuw	a4,a4,a2
 4ce:	0585                	addi	a1,a1,1
 4d0:	fcc7ffe3          	bgeu	a5,a2,4ae <printint+0x36>
  if(neg)
 4d4:	00030b63          	beqz	t1,4ea <printint+0x72>
    buf[i++] = '-';
 4d8:	fd040793          	addi	a5,s0,-48
 4dc:	953e                	add	a0,a0,a5
 4de:	02d00793          	li	a5,45
 4e2:	fef50423          	sb	a5,-24(a0)
 4e6:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 4ea:	02d05563          	blez	a3,514 <printint+0x9c>
 4ee:	fc26                	sd	s1,56(sp)
 4f0:	36fd                	addiw	a3,a3,-1
 4f2:	00d984b3          	add	s1,s3,a3
 4f6:	19fd                	addi	s3,s3,-1
 4f8:	99b6                	add	s3,s3,a3
 4fa:	1682                	slli	a3,a3,0x20
 4fc:	9281                	srli	a3,a3,0x20
 4fe:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 502:	0004c583          	lbu	a1,0(s1)
 506:	854a                	mv	a0,s2
 508:	f53ff0ef          	jal	45a <putc>
  while(--i >= 0)
 50c:	14fd                	addi	s1,s1,-1
 50e:	ff349ae3          	bne	s1,s3,502 <printint+0x8a>
 512:	74e2                	ld	s1,56(sp)
}
 514:	60a6                	ld	ra,72(sp)
 516:	6406                	ld	s0,64(sp)
 518:	7942                	ld	s2,48(sp)
 51a:	79a2                	ld	s3,40(sp)
 51c:	6161                	addi	sp,sp,80
 51e:	8082                	ret

0000000000000520 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 520:	711d                	addi	sp,sp,-96
 522:	ec86                	sd	ra,88(sp)
 524:	e8a2                	sd	s0,80(sp)
 526:	e4a6                	sd	s1,72(sp)
 528:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 52a:	0005c483          	lbu	s1,0(a1)
 52e:	2a048063          	beqz	s1,7ce <vprintf+0x2ae>
 532:	e0ca                	sd	s2,64(sp)
 534:	fc4e                	sd	s3,56(sp)
 536:	f852                	sd	s4,48(sp)
 538:	f456                	sd	s5,40(sp)
 53a:	f05a                	sd	s6,32(sp)
 53c:	ec5e                	sd	s7,24(sp)
 53e:	e862                	sd	s8,16(sp)
 540:	8b2a                	mv	s6,a0
 542:	8a2e                	mv	s4,a1
 544:	8bb2                	mv	s7,a2
  state = 0;
 546:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 548:	4901                	li	s2,0
 54a:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 54c:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 550:	06400c13          	li	s8,100
 554:	a00d                	j	576 <vprintf+0x56>
        putc(fd, c0);
 556:	85a6                	mv	a1,s1
 558:	855a                	mv	a0,s6
 55a:	f01ff0ef          	jal	45a <putc>
 55e:	a019                	j	564 <vprintf+0x44>
    } else if(state == '%'){
 560:	03598363          	beq	s3,s5,586 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 564:	0019079b          	addiw	a5,s2,1
 568:	893e                	mv	s2,a5
 56a:	873e                	mv	a4,a5
 56c:	97d2                	add	a5,a5,s4
 56e:	0007c483          	lbu	s1,0(a5)
 572:	24048763          	beqz	s1,7c0 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 576:	0004879b          	sext.w	a5,s1
    if(state == 0){
 57a:	fe0993e3          	bnez	s3,560 <vprintf+0x40>
      if(c0 == '%'){
 57e:	fd579ce3          	bne	a5,s5,556 <vprintf+0x36>
        state = '%';
 582:	89be                	mv	s3,a5
 584:	b7c5                	j	564 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 586:	00ea06b3          	add	a3,s4,a4
 58a:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 58e:	24060563          	beqz	a2,7d8 <vprintf+0x2b8>
      if(c0 == 'd'){
 592:	0b878763          	beq	a5,s8,640 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 596:	f9478693          	addi	a3,a5,-108
 59a:	0016b693          	seqz	a3,a3
 59e:	f9c60593          	addi	a1,a2,-100
 5a2:	0015b593          	seqz	a1,a1
 5a6:	8df5                	and	a1,a1,a3
 5a8:	e9c5                	bnez	a1,658 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 5aa:	9752                	add	a4,a4,s4
 5ac:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5b0:	f9460713          	addi	a4,a2,-108
 5b4:	00173713          	seqz	a4,a4
 5b8:	8f75                	and	a4,a4,a3
 5ba:	f9c50593          	addi	a1,a0,-100
 5be:	0015b593          	seqz	a1,a1
 5c2:	8df9                	and	a1,a1,a4
 5c4:	e5dd                	bnez	a1,672 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5c6:	07500593          	li	a1,117
 5ca:	0cb78163          	beq	a5,a1,68c <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 5ce:	f8b60593          	addi	a1,a2,-117
 5d2:	0015b593          	seqz	a1,a1
 5d6:	8df5                	and	a1,a1,a3
 5d8:	e5f1                	bnez	a1,6a4 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 5da:	f8b50593          	addi	a1,a0,-117
 5de:	0015b593          	seqz	a1,a1
 5e2:	8df9                	and	a1,a1,a4
 5e4:	ede9                	bnez	a1,6be <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5e6:	07800593          	li	a1,120
 5ea:	0eb78763          	beq	a5,a1,6d8 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 5ee:	f8860613          	addi	a2,a2,-120
 5f2:	00163613          	seqz	a2,a2
 5f6:	8ef1                	and	a3,a3,a2
 5f8:	0e069c63          	bnez	a3,6f0 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5fc:	f8850513          	addi	a0,a0,-120
 600:	00153513          	seqz	a0,a0
 604:	8f69                	and	a4,a4,a0
 606:	10071263          	bnez	a4,70a <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 60a:	07000713          	li	a4,112
 60e:	10e78a63          	beq	a5,a4,722 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 612:	06300713          	li	a4,99
 616:	14e78a63          	beq	a5,a4,76a <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 61a:	07300713          	li	a4,115
 61e:	16e78063          	beq	a5,a4,77e <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 622:	02500713          	li	a4,37
 626:	18e78863          	beq	a5,a4,7b6 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 62a:	02500593          	li	a1,37
 62e:	855a                	mv	a0,s6
 630:	e2bff0ef          	jal	45a <putc>
        putc(fd, c0);
 634:	85a6                	mv	a1,s1
 636:	855a                	mv	a0,s6
 638:	e23ff0ef          	jal	45a <putc>
      }

      state = 0;
 63c:	4981                	li	s3,0
 63e:	b71d                	j	564 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 640:	008b8493          	addi	s1,s7,8
 644:	4685                	li	a3,1
 646:	4629                	li	a2,10
 648:	000ba583          	lw	a1,0(s7)
 64c:	855a                	mv	a0,s6
 64e:	e2bff0ef          	jal	478 <printint>
 652:	8ba6                	mv	s7,s1
      state = 0;
 654:	4981                	li	s3,0
 656:	b739                	j	564 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 658:	008b8493          	addi	s1,s7,8
 65c:	4685                	li	a3,1
 65e:	4629                	li	a2,10
 660:	000bb583          	ld	a1,0(s7)
 664:	855a                	mv	a0,s6
 666:	e13ff0ef          	jal	478 <printint>
        i += 1;
 66a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 66c:	8ba6                	mv	s7,s1
      state = 0;
 66e:	4981                	li	s3,0
 670:	bdd5                	j	564 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 672:	008b8493          	addi	s1,s7,8
 676:	4685                	li	a3,1
 678:	4629                	li	a2,10
 67a:	000bb583          	ld	a1,0(s7)
 67e:	855a                	mv	a0,s6
 680:	df9ff0ef          	jal	478 <printint>
        i += 2;
 684:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 686:	8ba6                	mv	s7,s1
      state = 0;
 688:	4981                	li	s3,0
        i += 2;
 68a:	bde9                	j	564 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 68c:	008b8493          	addi	s1,s7,8
 690:	4681                	li	a3,0
 692:	4629                	li	a2,10
 694:	000be583          	lwu	a1,0(s7)
 698:	855a                	mv	a0,s6
 69a:	ddfff0ef          	jal	478 <printint>
 69e:	8ba6                	mv	s7,s1
      state = 0;
 6a0:	4981                	li	s3,0
 6a2:	b5c9                	j	564 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a4:	008b8493          	addi	s1,s7,8
 6a8:	4681                	li	a3,0
 6aa:	4629                	li	a2,10
 6ac:	000bb583          	ld	a1,0(s7)
 6b0:	855a                	mv	a0,s6
 6b2:	dc7ff0ef          	jal	478 <printint>
        i += 1;
 6b6:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b8:	8ba6                	mv	s7,s1
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	b565                	j	564 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6be:	008b8493          	addi	s1,s7,8
 6c2:	4681                	li	a3,0
 6c4:	4629                	li	a2,10
 6c6:	000bb583          	ld	a1,0(s7)
 6ca:	855a                	mv	a0,s6
 6cc:	dadff0ef          	jal	478 <printint>
        i += 2;
 6d0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d2:	8ba6                	mv	s7,s1
      state = 0;
 6d4:	4981                	li	s3,0
        i += 2;
 6d6:	b579                	j	564 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6d8:	008b8493          	addi	s1,s7,8
 6dc:	4681                	li	a3,0
 6de:	4641                	li	a2,16
 6e0:	000be583          	lwu	a1,0(s7)
 6e4:	855a                	mv	a0,s6
 6e6:	d93ff0ef          	jal	478 <printint>
 6ea:	8ba6                	mv	s7,s1
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	bd9d                	j	564 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6f0:	008b8493          	addi	s1,s7,8
 6f4:	4681                	li	a3,0
 6f6:	4641                	li	a2,16
 6f8:	000bb583          	ld	a1,0(s7)
 6fc:	855a                	mv	a0,s6
 6fe:	d7bff0ef          	jal	478 <printint>
        i += 1;
 702:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 704:	8ba6                	mv	s7,s1
      state = 0;
 706:	4981                	li	s3,0
 708:	bdb1                	j	564 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 70a:	008b8493          	addi	s1,s7,8
 70e:	4641                	li	a2,16
 710:	000bb583          	ld	a1,0(s7)
 714:	855a                	mv	a0,s6
 716:	d63ff0ef          	jal	478 <printint>
        i += 2;
 71a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 71c:	8ba6                	mv	s7,s1
      state = 0;
 71e:	4981                	li	s3,0
        i += 2;
 720:	b591                	j	564 <vprintf+0x44>
 722:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 724:	008b8793          	addi	a5,s7,8
 728:	8cbe                	mv	s9,a5
 72a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 72e:	03000593          	li	a1,48
 732:	855a                	mv	a0,s6
 734:	d27ff0ef          	jal	45a <putc>
  putc(fd, 'x');
 738:	07800593          	li	a1,120
 73c:	855a                	mv	a0,s6
 73e:	d1dff0ef          	jal	45a <putc>
 742:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 744:	00000b97          	auipc	s7,0x0
 748:	2dcb8b93          	addi	s7,s7,732 # a20 <digits>
 74c:	03c9d793          	srli	a5,s3,0x3c
 750:	97de                	add	a5,a5,s7
 752:	0007c583          	lbu	a1,0(a5)
 756:	855a                	mv	a0,s6
 758:	d03ff0ef          	jal	45a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 75c:	0992                	slli	s3,s3,0x4
 75e:	34fd                	addiw	s1,s1,-1
 760:	f4f5                	bnez	s1,74c <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 762:	8be6                	mv	s7,s9
      state = 0;
 764:	4981                	li	s3,0
 766:	6ca2                	ld	s9,8(sp)
 768:	bbf5                	j	564 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 76a:	008b8493          	addi	s1,s7,8
 76e:	000bc583          	lbu	a1,0(s7)
 772:	855a                	mv	a0,s6
 774:	ce7ff0ef          	jal	45a <putc>
 778:	8ba6                	mv	s7,s1
      state = 0;
 77a:	4981                	li	s3,0
 77c:	b3e5                	j	564 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 77e:	008b8993          	addi	s3,s7,8
 782:	000bb483          	ld	s1,0(s7)
 786:	cc91                	beqz	s1,7a2 <vprintf+0x282>
        for(; *s; s++)
 788:	0004c583          	lbu	a1,0(s1)
 78c:	c195                	beqz	a1,7b0 <vprintf+0x290>
          putc(fd, *s);
 78e:	855a                	mv	a0,s6
 790:	ccbff0ef          	jal	45a <putc>
        for(; *s; s++)
 794:	0485                	addi	s1,s1,1
 796:	0004c583          	lbu	a1,0(s1)
 79a:	f9f5                	bnez	a1,78e <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 79c:	8bce                	mv	s7,s3
      state = 0;
 79e:	4981                	li	s3,0
 7a0:	b3d1                	j	564 <vprintf+0x44>
          s = "(null)";
 7a2:	00000497          	auipc	s1,0x0
 7a6:	27648493          	addi	s1,s1,630 # a18 <malloc+0x144>
        for(; *s; s++)
 7aa:	02800593          	li	a1,40
 7ae:	b7c5                	j	78e <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 7b0:	8bce                	mv	s7,s3
      state = 0;
 7b2:	4981                	li	s3,0
 7b4:	bb45                	j	564 <vprintf+0x44>
        putc(fd, '%');
 7b6:	85be                	mv	a1,a5
 7b8:	855a                	mv	a0,s6
 7ba:	ca1ff0ef          	jal	45a <putc>
 7be:	bdbd                	j	63c <vprintf+0x11c>
 7c0:	6906                	ld	s2,64(sp)
 7c2:	79e2                	ld	s3,56(sp)
 7c4:	7a42                	ld	s4,48(sp)
 7c6:	7aa2                	ld	s5,40(sp)
 7c8:	7b02                	ld	s6,32(sp)
 7ca:	6be2                	ld	s7,24(sp)
 7cc:	6c42                	ld	s8,16(sp)
    }
  }
}
 7ce:	60e6                	ld	ra,88(sp)
 7d0:	6446                	ld	s0,80(sp)
 7d2:	64a6                	ld	s1,72(sp)
 7d4:	6125                	addi	sp,sp,96
 7d6:	8082                	ret
      if(c0 == 'd'){
 7d8:	06400713          	li	a4,100
 7dc:	e6e782e3          	beq	a5,a4,640 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 7e0:	f9478693          	addi	a3,a5,-108
 7e4:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 7e8:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7ea:	4701                	li	a4,0
 7ec:	bbe9                	j	5c6 <vprintf+0xa6>

00000000000007ee <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7ee:	715d                	addi	sp,sp,-80
 7f0:	ec06                	sd	ra,24(sp)
 7f2:	e822                	sd	s0,16(sp)
 7f4:	1000                	addi	s0,sp,32
 7f6:	e010                	sd	a2,0(s0)
 7f8:	e414                	sd	a3,8(s0)
 7fa:	e818                	sd	a4,16(s0)
 7fc:	ec1c                	sd	a5,24(s0)
 7fe:	03043023          	sd	a6,32(s0)
 802:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 806:	8622                	mv	a2,s0
 808:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 80c:	d15ff0ef          	jal	520 <vprintf>
}
 810:	60e2                	ld	ra,24(sp)
 812:	6442                	ld	s0,16(sp)
 814:	6161                	addi	sp,sp,80
 816:	8082                	ret

0000000000000818 <printf>:

void
printf(const char *fmt, ...)
{
 818:	711d                	addi	sp,sp,-96
 81a:	ec06                	sd	ra,24(sp)
 81c:	e822                	sd	s0,16(sp)
 81e:	1000                	addi	s0,sp,32
 820:	e40c                	sd	a1,8(s0)
 822:	e810                	sd	a2,16(s0)
 824:	ec14                	sd	a3,24(s0)
 826:	f018                	sd	a4,32(s0)
 828:	f41c                	sd	a5,40(s0)
 82a:	03043823          	sd	a6,48(s0)
 82e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 832:	00840613          	addi	a2,s0,8
 836:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 83a:	85aa                	mv	a1,a0
 83c:	4505                	li	a0,1
 83e:	ce3ff0ef          	jal	520 <vprintf>
}
 842:	60e2                	ld	ra,24(sp)
 844:	6442                	ld	s0,16(sp)
 846:	6125                	addi	sp,sp,96
 848:	8082                	ret

000000000000084a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 84a:	1141                	addi	sp,sp,-16
 84c:	e406                	sd	ra,8(sp)
 84e:	e022                	sd	s0,0(sp)
 850:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 852:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 856:	00000797          	auipc	a5,0x0
 85a:	7aa7b783          	ld	a5,1962(a5) # 1000 <freep>
 85e:	a095                	j	8c2 <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 860:	ff852583          	lw	a1,-8(a0)
 864:	6390                	ld	a2,0(a5)
 866:	02059813          	slli	a6,a1,0x20
 86a:	01c85693          	srli	a3,a6,0x1c
 86e:	96ba                	add	a3,a3,a4
 870:	02d60563          	beq	a2,a3,89a <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 874:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 878:	4790                	lw	a2,8(a5)
 87a:	02061593          	slli	a1,a2,0x20
 87e:	01c5d693          	srli	a3,a1,0x1c
 882:	96be                	add	a3,a3,a5
 884:	02d70263          	beq	a4,a3,8a8 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 888:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 88a:	00000717          	auipc	a4,0x0
 88e:	76f73b23          	sd	a5,1910(a4) # 1000 <freep>
}
 892:	60a2                	ld	ra,8(sp)
 894:	6402                	ld	s0,0(sp)
 896:	0141                	addi	sp,sp,16
 898:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 89a:	4614                	lw	a3,8(a2)
 89c:	9ead                	addw	a3,a3,a1
 89e:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8a2:	6394                	ld	a3,0(a5)
 8a4:	6290                	ld	a2,0(a3)
 8a6:	b7f9                	j	874 <free+0x2a>
    p->s.size += bp->s.size;
 8a8:	ff852703          	lw	a4,-8(a0)
 8ac:	9f31                	addw	a4,a4,a2
 8ae:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8b0:	ff053703          	ld	a4,-16(a0)
 8b4:	bfd1                	j	888 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b6:	6394                	ld	a3,0(a5)
 8b8:	00d7e463          	bltu	a5,a3,8c0 <free+0x76>
 8bc:	fad762e3          	bltu	a4,a3,860 <free+0x16>
 8c0:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c2:	fee7fae3          	bgeu	a5,a4,8b6 <free+0x6c>
 8c6:	6394                	ld	a3,0(a5)
 8c8:	f8d76ce3          	bltu	a4,a3,860 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8cc:	f8d7fae3          	bgeu	a5,a3,860 <free+0x16>
 8d0:	87b6                	mv	a5,a3
 8d2:	bfc5                	j	8c2 <free+0x78>

00000000000008d4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8d4:	7139                	addi	sp,sp,-64
 8d6:	fc06                	sd	ra,56(sp)
 8d8:	f822                	sd	s0,48(sp)
 8da:	f04a                	sd	s2,32(sp)
 8dc:	ec4e                	sd	s3,24(sp)
 8de:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8e0:	02051993          	slli	s3,a0,0x20
 8e4:	0209d993          	srli	s3,s3,0x20
 8e8:	09bd                	addi	s3,s3,15
 8ea:	0049d993          	srli	s3,s3,0x4
 8ee:	2985                	addiw	s3,s3,1
 8f0:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8f2:	00000517          	auipc	a0,0x0
 8f6:	70e53503          	ld	a0,1806(a0) # 1000 <freep>
 8fa:	c905                	beqz	a0,92a <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8fc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8fe:	4798                	lw	a4,8(a5)
 900:	09377663          	bgeu	a4,s3,98c <malloc+0xb8>
 904:	f426                	sd	s1,40(sp)
 906:	e852                	sd	s4,16(sp)
 908:	e456                	sd	s5,8(sp)
 90a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 90c:	8a4e                	mv	s4,s3
 90e:	6705                	lui	a4,0x1
 910:	00e9f363          	bgeu	s3,a4,916 <malloc+0x42>
 914:	6a05                	lui	s4,0x1
 916:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 91a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 91e:	00000497          	auipc	s1,0x0
 922:	6e248493          	addi	s1,s1,1762 # 1000 <freep>
  if(p == SBRK_ERROR)
 926:	5afd                	li	s5,-1
 928:	a83d                	j	966 <malloc+0x92>
 92a:	f426                	sd	s1,40(sp)
 92c:	e852                	sd	s4,16(sp)
 92e:	e456                	sd	s5,8(sp)
 930:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 932:	00001797          	auipc	a5,0x1
 936:	8d678793          	addi	a5,a5,-1834 # 1208 <base>
 93a:	00000717          	auipc	a4,0x0
 93e:	6cf73323          	sd	a5,1734(a4) # 1000 <freep>
 942:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 944:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 948:	b7d1                	j	90c <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 94a:	6398                	ld	a4,0(a5)
 94c:	e118                	sd	a4,0(a0)
 94e:	a899                	j	9a4 <malloc+0xd0>
  hp->s.size = nu;
 950:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 954:	0541                	addi	a0,a0,16
 956:	ef5ff0ef          	jal	84a <free>
  return freep;
 95a:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 95c:	c125                	beqz	a0,9bc <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 95e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 960:	4798                	lw	a4,8(a5)
 962:	03277163          	bgeu	a4,s2,984 <malloc+0xb0>
    if(p == freep)
 966:	6098                	ld	a4,0(s1)
 968:	853e                	mv	a0,a5
 96a:	fef71ae3          	bne	a4,a5,95e <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 96e:	8552                	mv	a0,s4
 970:	a17ff0ef          	jal	386 <sbrk>
  if(p == SBRK_ERROR)
 974:	fd551ee3          	bne	a0,s5,950 <malloc+0x7c>
        return 0;
 978:	4501                	li	a0,0
 97a:	74a2                	ld	s1,40(sp)
 97c:	6a42                	ld	s4,16(sp)
 97e:	6aa2                	ld	s5,8(sp)
 980:	6b02                	ld	s6,0(sp)
 982:	a03d                	j	9b0 <malloc+0xdc>
 984:	74a2                	ld	s1,40(sp)
 986:	6a42                	ld	s4,16(sp)
 988:	6aa2                	ld	s5,8(sp)
 98a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 98c:	fae90fe3          	beq	s2,a4,94a <malloc+0x76>
        p->s.size -= nunits;
 990:	4137073b          	subw	a4,a4,s3
 994:	c798                	sw	a4,8(a5)
        p += p->s.size;
 996:	02071693          	slli	a3,a4,0x20
 99a:	01c6d713          	srli	a4,a3,0x1c
 99e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9a0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9a4:	00000717          	auipc	a4,0x0
 9a8:	64a73e23          	sd	a0,1628(a4) # 1000 <freep>
      return (void*)(p + 1);
 9ac:	01078513          	addi	a0,a5,16
  }
}
 9b0:	70e2                	ld	ra,56(sp)
 9b2:	7442                	ld	s0,48(sp)
 9b4:	7902                	ld	s2,32(sp)
 9b6:	69e2                	ld	s3,24(sp)
 9b8:	6121                	addi	sp,sp,64
 9ba:	8082                	ret
 9bc:	74a2                	ld	s1,40(sp)
 9be:	6a42                	ld	s4,16(sp)
 9c0:	6aa2                	ld	s5,8(sp)
 9c2:	6b02                	ld	s6,0(sp)
 9c4:	b7f5                	j	9b0 <malloc+0xdc>
