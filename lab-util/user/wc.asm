
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	addi	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4901                	li	s2,0
  l = w = c = 0;
  28:	4c81                	li	s9,0
  2a:	4c01                	li	s8,0
  2c:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2e:	20000d93          	li	s11,512
  32:	00001d17          	auipc	s10,0x1
  36:	fded0d13          	addi	s10,s10,-34 # 1010 <buf>
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  3a:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  3c:	00001a17          	auipc	s4,0x1
  40:	9e4a0a13          	addi	s4,s4,-1564 # a20 <malloc+0xf2>
  while((n = read(fd, buf, sizeof(buf))) > 0){
  44:	a035                	j	70 <wc+0x70>
      if(strchr(" \r\t\n\v", buf[i]))
  46:	8552                	mv	a0,s4
  48:	1c8000ef          	jal	210 <strchr>
  4c:	c919                	beqz	a0,62 <wc+0x62>
        inword = 0;
  4e:	4901                	li	s2,0
    for(i=0; i<n; i++){
  50:	0485                	addi	s1,s1,1
  52:	01348d63          	beq	s1,s3,6c <wc+0x6c>
      if(buf[i] == '\n')
  56:	0004c583          	lbu	a1,0(s1)
  5a:	ff5596e3          	bne	a1,s5,46 <wc+0x46>
        l++;
  5e:	2b85                	addiw	s7,s7,1
  60:	b7dd                	j	46 <wc+0x46>
      else if(!inword){
  62:	fe0917e3          	bnez	s2,50 <wc+0x50>
        w++;
  66:	2c05                	addiw	s8,s8,1
        inword = 1;
  68:	4905                	li	s2,1
  6a:	b7dd                	j	50 <wc+0x50>
  6c:	019b0cbb          	addw	s9,s6,s9
  while((n = read(fd, buf, sizeof(buf))) > 0){
  70:	866e                	mv	a2,s11
  72:	85ea                	mv	a1,s10
  74:	f8843503          	ld	a0,-120(s0)
  78:	3b4000ef          	jal	42c <read>
  7c:	8b2a                	mv	s6,a0
  7e:	00a05963          	blez	a0,90 <wc+0x90>
  82:	00001497          	auipc	s1,0x1
  86:	f8e48493          	addi	s1,s1,-114 # 1010 <buf>
  8a:	009b09b3          	add	s3,s6,s1
  8e:	b7e1                	j	56 <wc+0x56>
      }
    }
  }
  if(n < 0){
  90:	02054c63          	bltz	a0,c8 <wc+0xc8>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  94:	f8043703          	ld	a4,-128(s0)
  98:	86e6                	mv	a3,s9
  9a:	8662                	mv	a2,s8
  9c:	85de                	mv	a1,s7
  9e:	00001517          	auipc	a0,0x1
  a2:	9a250513          	addi	a0,a0,-1630 # a40 <malloc+0x112>
  a6:	7cc000ef          	jal	872 <printf>
}
  aa:	70e6                	ld	ra,120(sp)
  ac:	7446                	ld	s0,112(sp)
  ae:	74a6                	ld	s1,104(sp)
  b0:	7906                	ld	s2,96(sp)
  b2:	69e6                	ld	s3,88(sp)
  b4:	6a46                	ld	s4,80(sp)
  b6:	6aa6                	ld	s5,72(sp)
  b8:	6b06                	ld	s6,64(sp)
  ba:	7be2                	ld	s7,56(sp)
  bc:	7c42                	ld	s8,48(sp)
  be:	7ca2                	ld	s9,40(sp)
  c0:	7d02                	ld	s10,32(sp)
  c2:	6de2                	ld	s11,24(sp)
  c4:	6109                	addi	sp,sp,128
  c6:	8082                	ret
    printf("wc: read error\n");
  c8:	00001517          	auipc	a0,0x1
  cc:	96850513          	addi	a0,a0,-1688 # a30 <malloc+0x102>
  d0:	7a2000ef          	jal	872 <printf>
    exit(1);
  d4:	4505                	li	a0,1
  d6:	33e000ef          	jal	414 <exit>

00000000000000da <main>:

int
main(int argc, char *argv[])
{
  da:	7179                	addi	sp,sp,-48
  dc:	f406                	sd	ra,40(sp)
  de:	f022                	sd	s0,32(sp)
  e0:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  e2:	4785                	li	a5,1
  e4:	04a7d463          	bge	a5,a0,12c <main+0x52>
  e8:	ec26                	sd	s1,24(sp)
  ea:	e84a                	sd	s2,16(sp)
  ec:	e44e                	sd	s3,8(sp)
  ee:	00858913          	addi	s2,a1,8
  f2:	ffe5099b          	addiw	s3,a0,-2
  f6:	02099793          	slli	a5,s3,0x20
  fa:	01d7d993          	srli	s3,a5,0x1d
  fe:	05c1                	addi	a1,a1,16
 100:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], O_RDONLY)) < 0){
 102:	4581                	li	a1,0
 104:	00093503          	ld	a0,0(s2)
 108:	34c000ef          	jal	454 <open>
 10c:	84aa                	mv	s1,a0
 10e:	02054c63          	bltz	a0,146 <main+0x6c>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 112:	00093583          	ld	a1,0(s2)
 116:	eebff0ef          	jal	0 <wc>
    close(fd);
 11a:	8526                	mv	a0,s1
 11c:	320000ef          	jal	43c <close>
  for(i = 1; i < argc; i++){
 120:	0921                	addi	s2,s2,8
 122:	ff3910e3          	bne	s2,s3,102 <main+0x28>
  }
  exit(0);
 126:	4501                	li	a0,0
 128:	2ec000ef          	jal	414 <exit>
 12c:	ec26                	sd	s1,24(sp)
 12e:	e84a                	sd	s2,16(sp)
 130:	e44e                	sd	s3,8(sp)
    wc(0, "");
 132:	00001597          	auipc	a1,0x1
 136:	8f658593          	addi	a1,a1,-1802 # a28 <malloc+0xfa>
 13a:	4501                	li	a0,0
 13c:	ec5ff0ef          	jal	0 <wc>
    exit(0);
 140:	4501                	li	a0,0
 142:	2d2000ef          	jal	414 <exit>
      printf("wc: cannot open %s\n", argv[i]);
 146:	00093583          	ld	a1,0(s2)
 14a:	00001517          	auipc	a0,0x1
 14e:	90650513          	addi	a0,a0,-1786 # a50 <malloc+0x122>
 152:	720000ef          	jal	872 <printf>
      exit(1);
 156:	4505                	li	a0,1
 158:	2bc000ef          	jal	414 <exit>

000000000000015c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 15c:	1141                	addi	sp,sp,-16
 15e:	e406                	sd	ra,8(sp)
 160:	e022                	sd	s0,0(sp)
 162:	0800                	addi	s0,sp,16
  extern int main();
  main();
 164:	f77ff0ef          	jal	da <main>
  exit(0);
 168:	4501                	li	a0,0
 16a:	2aa000ef          	jal	414 <exit>

000000000000016e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 16e:	1141                	addi	sp,sp,-16
 170:	e406                	sd	ra,8(sp)
 172:	e022                	sd	s0,0(sp)
 174:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 176:	87aa                	mv	a5,a0
 178:	0585                	addi	a1,a1,1
 17a:	0785                	addi	a5,a5,1
 17c:	fff5c703          	lbu	a4,-1(a1)
 180:	fee78fa3          	sb	a4,-1(a5)
 184:	fb75                	bnez	a4,178 <strcpy+0xa>
    ;
  return os;
}
 186:	60a2                	ld	ra,8(sp)
 188:	6402                	ld	s0,0(sp)
 18a:	0141                	addi	sp,sp,16
 18c:	8082                	ret

000000000000018e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 18e:	1141                	addi	sp,sp,-16
 190:	e406                	sd	ra,8(sp)
 192:	e022                	sd	s0,0(sp)
 194:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 196:	00054783          	lbu	a5,0(a0)
 19a:	cb91                	beqz	a5,1ae <strcmp+0x20>
 19c:	0005c703          	lbu	a4,0(a1)
 1a0:	00f71763          	bne	a4,a5,1ae <strcmp+0x20>
    p++, q++;
 1a4:	0505                	addi	a0,a0,1
 1a6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1a8:	00054783          	lbu	a5,0(a0)
 1ac:	fbe5                	bnez	a5,19c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 1ae:	0005c503          	lbu	a0,0(a1)
}
 1b2:	40a7853b          	subw	a0,a5,a0
 1b6:	60a2                	ld	ra,8(sp)
 1b8:	6402                	ld	s0,0(sp)
 1ba:	0141                	addi	sp,sp,16
 1bc:	8082                	ret

00000000000001be <strlen>:

uint
strlen(const char *s)
{
 1be:	1141                	addi	sp,sp,-16
 1c0:	e406                	sd	ra,8(sp)
 1c2:	e022                	sd	s0,0(sp)
 1c4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1c6:	00054783          	lbu	a5,0(a0)
 1ca:	cf91                	beqz	a5,1e6 <strlen+0x28>
 1cc:	00150793          	addi	a5,a0,1
 1d0:	86be                	mv	a3,a5
 1d2:	0785                	addi	a5,a5,1
 1d4:	fff7c703          	lbu	a4,-1(a5)
 1d8:	ff65                	bnez	a4,1d0 <strlen+0x12>
 1da:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 1de:	60a2                	ld	ra,8(sp)
 1e0:	6402                	ld	s0,0(sp)
 1e2:	0141                	addi	sp,sp,16
 1e4:	8082                	ret
  for(n = 0; s[n]; n++)
 1e6:	4501                	li	a0,0
 1e8:	bfdd                	j	1de <strlen+0x20>

00000000000001ea <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ea:	1141                	addi	sp,sp,-16
 1ec:	e406                	sd	ra,8(sp)
 1ee:	e022                	sd	s0,0(sp)
 1f0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1f2:	ca19                	beqz	a2,208 <memset+0x1e>
 1f4:	87aa                	mv	a5,a0
 1f6:	1602                	slli	a2,a2,0x20
 1f8:	9201                	srli	a2,a2,0x20
 1fa:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1fe:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 202:	0785                	addi	a5,a5,1
 204:	fee79de3          	bne	a5,a4,1fe <memset+0x14>
  }
  return dst;
}
 208:	60a2                	ld	ra,8(sp)
 20a:	6402                	ld	s0,0(sp)
 20c:	0141                	addi	sp,sp,16
 20e:	8082                	ret

0000000000000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	1141                	addi	sp,sp,-16
 212:	e406                	sd	ra,8(sp)
 214:	e022                	sd	s0,0(sp)
 216:	0800                	addi	s0,sp,16
  for(; *s; s++)
 218:	00054783          	lbu	a5,0(a0)
 21c:	c799                	beqz	a5,22a <strchr+0x1a>
    if(*s == c)
 21e:	00f58763          	beq	a1,a5,22c <strchr+0x1c>
  for(; *s; s++)
 222:	0505                	addi	a0,a0,1
 224:	00054783          	lbu	a5,0(a0)
 228:	fbfd                	bnez	a5,21e <strchr+0xe>
      return (char*)s;
  return 0;
 22a:	4501                	li	a0,0
}
 22c:	60a2                	ld	ra,8(sp)
 22e:	6402                	ld	s0,0(sp)
 230:	0141                	addi	sp,sp,16
 232:	8082                	ret

0000000000000234 <gets>:

char*
gets(char *buf, int max)
{
 234:	711d                	addi	sp,sp,-96
 236:	ec86                	sd	ra,88(sp)
 238:	e8a2                	sd	s0,80(sp)
 23a:	e4a6                	sd	s1,72(sp)
 23c:	e0ca                	sd	s2,64(sp)
 23e:	fc4e                	sd	s3,56(sp)
 240:	f852                	sd	s4,48(sp)
 242:	f456                	sd	s5,40(sp)
 244:	f05a                	sd	s6,32(sp)
 246:	ec5e                	sd	s7,24(sp)
 248:	e862                	sd	s8,16(sp)
 24a:	1080                	addi	s0,sp,96
 24c:	8baa                	mv	s7,a0
 24e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 250:	892a                	mv	s2,a0
 252:	4481                	li	s1,0
    cc = read(0, &c, 1);
 254:	faf40b13          	addi	s6,s0,-81
 258:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 25a:	8c26                	mv	s8,s1
 25c:	0014899b          	addiw	s3,s1,1
 260:	84ce                	mv	s1,s3
 262:	0349d863          	bge	s3,s4,292 <gets+0x5e>
    cc = read(0, &c, 1);
 266:	8656                	mv	a2,s5
 268:	85da                	mv	a1,s6
 26a:	4501                	li	a0,0
 26c:	1c0000ef          	jal	42c <read>
    if(cc < 1)
 270:	02a05163          	blez	a0,292 <gets+0x5e>
      break;
    buf[i++] = c;
 274:	faf44783          	lbu	a5,-81(s0)
 278:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 27c:	0905                	addi	s2,s2,1
 27e:	ff678713          	addi	a4,a5,-10
 282:	00173713          	seqz	a4,a4
 286:	17cd                	addi	a5,a5,-13
 288:	0017b793          	seqz	a5,a5
 28c:	8fd9                	or	a5,a5,a4
 28e:	d7f1                	beqz	a5,25a <gets+0x26>
    buf[i++] = c;
 290:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 292:	9c5e                	add	s8,s8,s7
 294:	000c0023          	sb	zero,0(s8)
  return buf;
}
 298:	855e                	mv	a0,s7
 29a:	60e6                	ld	ra,88(sp)
 29c:	6446                	ld	s0,80(sp)
 29e:	64a6                	ld	s1,72(sp)
 2a0:	6906                	ld	s2,64(sp)
 2a2:	79e2                	ld	s3,56(sp)
 2a4:	7a42                	ld	s4,48(sp)
 2a6:	7aa2                	ld	s5,40(sp)
 2a8:	7b02                	ld	s6,32(sp)
 2aa:	6be2                	ld	s7,24(sp)
 2ac:	6c42                	ld	s8,16(sp)
 2ae:	6125                	addi	sp,sp,96
 2b0:	8082                	ret

00000000000002b2 <stat>:

int
stat(const char *n, struct stat *st)
{
 2b2:	1101                	addi	sp,sp,-32
 2b4:	ec06                	sd	ra,24(sp)
 2b6:	e822                	sd	s0,16(sp)
 2b8:	e04a                	sd	s2,0(sp)
 2ba:	1000                	addi	s0,sp,32
 2bc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2be:	4581                	li	a1,0
 2c0:	194000ef          	jal	454 <open>
  if(fd < 0)
 2c4:	02054263          	bltz	a0,2e8 <stat+0x36>
 2c8:	e426                	sd	s1,8(sp)
 2ca:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2cc:	85ca                	mv	a1,s2
 2ce:	19e000ef          	jal	46c <fstat>
 2d2:	892a                	mv	s2,a0
  close(fd);
 2d4:	8526                	mv	a0,s1
 2d6:	166000ef          	jal	43c <close>
  return r;
 2da:	64a2                	ld	s1,8(sp)
}
 2dc:	854a                	mv	a0,s2
 2de:	60e2                	ld	ra,24(sp)
 2e0:	6442                	ld	s0,16(sp)
 2e2:	6902                	ld	s2,0(sp)
 2e4:	6105                	addi	sp,sp,32
 2e6:	8082                	ret
    return -1;
 2e8:	57fd                	li	a5,-1
 2ea:	893e                	mv	s2,a5
 2ec:	bfc5                	j	2dc <stat+0x2a>

00000000000002ee <atoi>:

int
atoi(const char *s)
{
 2ee:	1141                	addi	sp,sp,-16
 2f0:	e406                	sd	ra,8(sp)
 2f2:	e022                	sd	s0,0(sp)
 2f4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f6:	00054683          	lbu	a3,0(a0)
 2fa:	fd06879b          	addiw	a5,a3,-48
 2fe:	0ff7f793          	zext.b	a5,a5
 302:	4625                	li	a2,9
 304:	02f66963          	bltu	a2,a5,336 <atoi+0x48>
 308:	872a                	mv	a4,a0
  n = 0;
 30a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 30c:	0705                	addi	a4,a4,1
 30e:	0025179b          	slliw	a5,a0,0x2
 312:	9fa9                	addw	a5,a5,a0
 314:	0017979b          	slliw	a5,a5,0x1
 318:	9fb5                	addw	a5,a5,a3
 31a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 31e:	00074683          	lbu	a3,0(a4)
 322:	fd06879b          	addiw	a5,a3,-48
 326:	0ff7f793          	zext.b	a5,a5
 32a:	fef671e3          	bgeu	a2,a5,30c <atoi+0x1e>
  return n;
}
 32e:	60a2                	ld	ra,8(sp)
 330:	6402                	ld	s0,0(sp)
 332:	0141                	addi	sp,sp,16
 334:	8082                	ret
  n = 0;
 336:	4501                	li	a0,0
 338:	bfdd                	j	32e <atoi+0x40>

000000000000033a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 33a:	1141                	addi	sp,sp,-16
 33c:	e406                	sd	ra,8(sp)
 33e:	e022                	sd	s0,0(sp)
 340:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 342:	02b57563          	bgeu	a0,a1,36c <memmove+0x32>
    while(n-- > 0)
 346:	00c05f63          	blez	a2,364 <memmove+0x2a>
 34a:	1602                	slli	a2,a2,0x20
 34c:	9201                	srli	a2,a2,0x20
 34e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 352:	872a                	mv	a4,a0
      *dst++ = *src++;
 354:	0585                	addi	a1,a1,1
 356:	0705                	addi	a4,a4,1
 358:	fff5c683          	lbu	a3,-1(a1)
 35c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 360:	fee79ae3          	bne	a5,a4,354 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 364:	60a2                	ld	ra,8(sp)
 366:	6402                	ld	s0,0(sp)
 368:	0141                	addi	sp,sp,16
 36a:	8082                	ret
    while(n-- > 0)
 36c:	fec05ce3          	blez	a2,364 <memmove+0x2a>
    dst += n;
 370:	00c50733          	add	a4,a0,a2
    src += n;
 374:	95b2                	add	a1,a1,a2
 376:	fff6079b          	addiw	a5,a2,-1
 37a:	1782                	slli	a5,a5,0x20
 37c:	9381                	srli	a5,a5,0x20
 37e:	fff7c793          	not	a5,a5
 382:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 384:	15fd                	addi	a1,a1,-1
 386:	177d                	addi	a4,a4,-1
 388:	0005c683          	lbu	a3,0(a1)
 38c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 390:	fef71ae3          	bne	a4,a5,384 <memmove+0x4a>
 394:	bfc1                	j	364 <memmove+0x2a>

0000000000000396 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 396:	1141                	addi	sp,sp,-16
 398:	e406                	sd	ra,8(sp)
 39a:	e022                	sd	s0,0(sp)
 39c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 39e:	ce19                	beqz	a2,3bc <memcmp+0x26>
 3a0:	1602                	slli	a2,a2,0x20
 3a2:	9201                	srli	a2,a2,0x20
 3a4:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 3a8:	00054783          	lbu	a5,0(a0)
 3ac:	0005c703          	lbu	a4,0(a1)
 3b0:	00e79b63          	bne	a5,a4,3c6 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 3b4:	0505                	addi	a0,a0,1
    p2++;
 3b6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3b8:	fed518e3          	bne	a0,a3,3a8 <memcmp+0x12>
  }
  return 0;
 3bc:	4501                	li	a0,0
}
 3be:	60a2                	ld	ra,8(sp)
 3c0:	6402                	ld	s0,0(sp)
 3c2:	0141                	addi	sp,sp,16
 3c4:	8082                	ret
      return *p1 - *p2;
 3c6:	40e7853b          	subw	a0,a5,a4
 3ca:	bfd5                	j	3be <memcmp+0x28>

00000000000003cc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3cc:	1141                	addi	sp,sp,-16
 3ce:	e406                	sd	ra,8(sp)
 3d0:	e022                	sd	s0,0(sp)
 3d2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3d4:	f67ff0ef          	jal	33a <memmove>
}
 3d8:	60a2                	ld	ra,8(sp)
 3da:	6402                	ld	s0,0(sp)
 3dc:	0141                	addi	sp,sp,16
 3de:	8082                	ret

00000000000003e0 <sbrk>:

char *
sbrk(int n) {
 3e0:	1141                	addi	sp,sp,-16
 3e2:	e406                	sd	ra,8(sp)
 3e4:	e022                	sd	s0,0(sp)
 3e6:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 3e8:	4585                	li	a1,1
 3ea:	0b2000ef          	jal	49c <sys_sbrk>
}
 3ee:	60a2                	ld	ra,8(sp)
 3f0:	6402                	ld	s0,0(sp)
 3f2:	0141                	addi	sp,sp,16
 3f4:	8082                	ret

00000000000003f6 <sbrklazy>:

char *
sbrklazy(int n) {
 3f6:	1141                	addi	sp,sp,-16
 3f8:	e406                	sd	ra,8(sp)
 3fa:	e022                	sd	s0,0(sp)
 3fc:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 3fe:	4589                	li	a1,2
 400:	09c000ef          	jal	49c <sys_sbrk>
}
 404:	60a2                	ld	ra,8(sp)
 406:	6402                	ld	s0,0(sp)
 408:	0141                	addi	sp,sp,16
 40a:	8082                	ret

000000000000040c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 40c:	4885                	li	a7,1
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <exit>:
.global exit
exit:
 li a7, SYS_exit
 414:	4889                	li	a7,2
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <wait>:
.global wait
wait:
 li a7, SYS_wait
 41c:	488d                	li	a7,3
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 424:	4891                	li	a7,4
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <read>:
.global read
read:
 li a7, SYS_read
 42c:	4895                	li	a7,5
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <write>:
.global write
write:
 li a7, SYS_write
 434:	48c1                	li	a7,16
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <close>:
.global close
close:
 li a7, SYS_close
 43c:	48d5                	li	a7,21
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <kill>:
.global kill
kill:
 li a7, SYS_kill
 444:	4899                	li	a7,6
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <exec>:
.global exec
exec:
 li a7, SYS_exec
 44c:	489d                	li	a7,7
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <open>:
.global open
open:
 li a7, SYS_open
 454:	48bd                	li	a7,15
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 45c:	48c5                	li	a7,17
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 464:	48c9                	li	a7,18
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 46c:	48a1                	li	a7,8
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <link>:
.global link
link:
 li a7, SYS_link
 474:	48cd                	li	a7,19
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 47c:	48d1                	li	a7,20
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 484:	48a5                	li	a7,9
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <dup>:
.global dup
dup:
 li a7, SYS_dup
 48c:	48a9                	li	a7,10
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 494:	48ad                	li	a7,11
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 49c:	48b1                	li	a7,12
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <pause>:
.global pause
pause:
 li a7, SYS_pause
 4a4:	48b5                	li	a7,13
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4ac:	48b9                	li	a7,14
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4b4:	1101                	addi	sp,sp,-32
 4b6:	ec06                	sd	ra,24(sp)
 4b8:	e822                	sd	s0,16(sp)
 4ba:	1000                	addi	s0,sp,32
 4bc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4c0:	4605                	li	a2,1
 4c2:	fef40593          	addi	a1,s0,-17
 4c6:	f6fff0ef          	jal	434 <write>
}
 4ca:	60e2                	ld	ra,24(sp)
 4cc:	6442                	ld	s0,16(sp)
 4ce:	6105                	addi	sp,sp,32
 4d0:	8082                	ret

00000000000004d2 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4d2:	715d                	addi	sp,sp,-80
 4d4:	e486                	sd	ra,72(sp)
 4d6:	e0a2                	sd	s0,64(sp)
 4d8:	f84a                	sd	s2,48(sp)
 4da:	f44e                	sd	s3,40(sp)
 4dc:	0880                	addi	s0,sp,80
 4de:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4e0:	00d036b3          	snez	a3,a3
 4e4:	03f5d793          	srli	a5,a1,0x3f
 4e8:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4ea:	0005871b          	sext.w	a4,a1
  neg = 0;
 4ee:	4301                	li	t1,0
  if(sgn && xx < 0){
 4f0:	c681                	beqz	a3,4f8 <printint+0x26>
    x = -xx;
 4f2:	40b0073b          	negw	a4,a1
    neg = 1;
 4f6:	4305                	li	t1,1
  }

  i = 0;
 4f8:	fb840993          	addi	s3,s0,-72
  neg = 0;
 4fc:	85ce                	mv	a1,s3
  i = 0;
 4fe:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 500:	00000817          	auipc	a6,0x0
 504:	57080813          	addi	a6,a6,1392 # a70 <digits>
 508:	88b6                	mv	a7,a3
 50a:	0016851b          	addiw	a0,a3,1
 50e:	86aa                	mv	a3,a0
 510:	02c777bb          	remuw	a5,a4,a2
 514:	1782                	slli	a5,a5,0x20
 516:	9381                	srli	a5,a5,0x20
 518:	97c2                	add	a5,a5,a6
 51a:	0007c783          	lbu	a5,0(a5)
 51e:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 522:	87ba                	mv	a5,a4
 524:	02c7573b          	divuw	a4,a4,a2
 528:	0585                	addi	a1,a1,1
 52a:	fcc7ffe3          	bgeu	a5,a2,508 <printint+0x36>
  if(neg)
 52e:	00030b63          	beqz	t1,544 <printint+0x72>
    buf[i++] = '-';
 532:	fd040793          	addi	a5,s0,-48
 536:	953e                	add	a0,a0,a5
 538:	02d00793          	li	a5,45
 53c:	fef50423          	sb	a5,-24(a0)
 540:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 544:	02d05563          	blez	a3,56e <printint+0x9c>
 548:	fc26                	sd	s1,56(sp)
 54a:	36fd                	addiw	a3,a3,-1
 54c:	00d984b3          	add	s1,s3,a3
 550:	19fd                	addi	s3,s3,-1
 552:	99b6                	add	s3,s3,a3
 554:	1682                	slli	a3,a3,0x20
 556:	9281                	srli	a3,a3,0x20
 558:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 55c:	0004c583          	lbu	a1,0(s1)
 560:	854a                	mv	a0,s2
 562:	f53ff0ef          	jal	4b4 <putc>
  while(--i >= 0)
 566:	14fd                	addi	s1,s1,-1
 568:	ff349ae3          	bne	s1,s3,55c <printint+0x8a>
 56c:	74e2                	ld	s1,56(sp)
}
 56e:	60a6                	ld	ra,72(sp)
 570:	6406                	ld	s0,64(sp)
 572:	7942                	ld	s2,48(sp)
 574:	79a2                	ld	s3,40(sp)
 576:	6161                	addi	sp,sp,80
 578:	8082                	ret

000000000000057a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 57a:	711d                	addi	sp,sp,-96
 57c:	ec86                	sd	ra,88(sp)
 57e:	e8a2                	sd	s0,80(sp)
 580:	e4a6                	sd	s1,72(sp)
 582:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 584:	0005c483          	lbu	s1,0(a1)
 588:	2a048063          	beqz	s1,828 <vprintf+0x2ae>
 58c:	e0ca                	sd	s2,64(sp)
 58e:	fc4e                	sd	s3,56(sp)
 590:	f852                	sd	s4,48(sp)
 592:	f456                	sd	s5,40(sp)
 594:	f05a                	sd	s6,32(sp)
 596:	ec5e                	sd	s7,24(sp)
 598:	e862                	sd	s8,16(sp)
 59a:	8b2a                	mv	s6,a0
 59c:	8a2e                	mv	s4,a1
 59e:	8bb2                	mv	s7,a2
  state = 0;
 5a0:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5a2:	4901                	li	s2,0
 5a4:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5a6:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5aa:	06400c13          	li	s8,100
 5ae:	a00d                	j	5d0 <vprintf+0x56>
        putc(fd, c0);
 5b0:	85a6                	mv	a1,s1
 5b2:	855a                	mv	a0,s6
 5b4:	f01ff0ef          	jal	4b4 <putc>
 5b8:	a019                	j	5be <vprintf+0x44>
    } else if(state == '%'){
 5ba:	03598363          	beq	s3,s5,5e0 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 5be:	0019079b          	addiw	a5,s2,1
 5c2:	893e                	mv	s2,a5
 5c4:	873e                	mv	a4,a5
 5c6:	97d2                	add	a5,a5,s4
 5c8:	0007c483          	lbu	s1,0(a5)
 5cc:	24048763          	beqz	s1,81a <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 5d0:	0004879b          	sext.w	a5,s1
    if(state == 0){
 5d4:	fe0993e3          	bnez	s3,5ba <vprintf+0x40>
      if(c0 == '%'){
 5d8:	fd579ce3          	bne	a5,s5,5b0 <vprintf+0x36>
        state = '%';
 5dc:	89be                	mv	s3,a5
 5de:	b7c5                	j	5be <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 5e0:	00ea06b3          	add	a3,s4,a4
 5e4:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 5e8:	24060563          	beqz	a2,832 <vprintf+0x2b8>
      if(c0 == 'd'){
 5ec:	0b878763          	beq	a5,s8,69a <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5f0:	f9478693          	addi	a3,a5,-108
 5f4:	0016b693          	seqz	a3,a3
 5f8:	f9c60593          	addi	a1,a2,-100
 5fc:	0015b593          	seqz	a1,a1
 600:	8df5                	and	a1,a1,a3
 602:	e9c5                	bnez	a1,6b2 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 604:	9752                	add	a4,a4,s4
 606:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 60a:	f9460713          	addi	a4,a2,-108
 60e:	00173713          	seqz	a4,a4
 612:	8f75                	and	a4,a4,a3
 614:	f9c50593          	addi	a1,a0,-100
 618:	0015b593          	seqz	a1,a1
 61c:	8df9                	and	a1,a1,a4
 61e:	e5dd                	bnez	a1,6cc <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 620:	07500593          	li	a1,117
 624:	0cb78163          	beq	a5,a1,6e6 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 628:	f8b60593          	addi	a1,a2,-117
 62c:	0015b593          	seqz	a1,a1
 630:	8df5                	and	a1,a1,a3
 632:	e5f1                	bnez	a1,6fe <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 634:	f8b50593          	addi	a1,a0,-117
 638:	0015b593          	seqz	a1,a1
 63c:	8df9                	and	a1,a1,a4
 63e:	ede9                	bnez	a1,718 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 640:	07800593          	li	a1,120
 644:	0eb78763          	beq	a5,a1,732 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 648:	f8860613          	addi	a2,a2,-120
 64c:	00163613          	seqz	a2,a2
 650:	8ef1                	and	a3,a3,a2
 652:	0e069c63          	bnez	a3,74a <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 656:	f8850513          	addi	a0,a0,-120
 65a:	00153513          	seqz	a0,a0
 65e:	8f69                	and	a4,a4,a0
 660:	10071263          	bnez	a4,764 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 664:	07000713          	li	a4,112
 668:	10e78a63          	beq	a5,a4,77c <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 66c:	06300713          	li	a4,99
 670:	14e78a63          	beq	a5,a4,7c4 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 674:	07300713          	li	a4,115
 678:	16e78063          	beq	a5,a4,7d8 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 67c:	02500713          	li	a4,37
 680:	18e78863          	beq	a5,a4,810 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 684:	02500593          	li	a1,37
 688:	855a                	mv	a0,s6
 68a:	e2bff0ef          	jal	4b4 <putc>
        putc(fd, c0);
 68e:	85a6                	mv	a1,s1
 690:	855a                	mv	a0,s6
 692:	e23ff0ef          	jal	4b4 <putc>
      }

      state = 0;
 696:	4981                	li	s3,0
 698:	b71d                	j	5be <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 69a:	008b8493          	addi	s1,s7,8
 69e:	4685                	li	a3,1
 6a0:	4629                	li	a2,10
 6a2:	000ba583          	lw	a1,0(s7)
 6a6:	855a                	mv	a0,s6
 6a8:	e2bff0ef          	jal	4d2 <printint>
 6ac:	8ba6                	mv	s7,s1
      state = 0;
 6ae:	4981                	li	s3,0
 6b0:	b739                	j	5be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6b2:	008b8493          	addi	s1,s7,8
 6b6:	4685                	li	a3,1
 6b8:	4629                	li	a2,10
 6ba:	000bb583          	ld	a1,0(s7)
 6be:	855a                	mv	a0,s6
 6c0:	e13ff0ef          	jal	4d2 <printint>
        i += 1;
 6c4:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6c6:	8ba6                	mv	s7,s1
      state = 0;
 6c8:	4981                	li	s3,0
 6ca:	bdd5                	j	5be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6cc:	008b8493          	addi	s1,s7,8
 6d0:	4685                	li	a3,1
 6d2:	4629                	li	a2,10
 6d4:	000bb583          	ld	a1,0(s7)
 6d8:	855a                	mv	a0,s6
 6da:	df9ff0ef          	jal	4d2 <printint>
        i += 2;
 6de:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6e0:	8ba6                	mv	s7,s1
      state = 0;
 6e2:	4981                	li	s3,0
        i += 2;
 6e4:	bde9                	j	5be <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6e6:	008b8493          	addi	s1,s7,8
 6ea:	4681                	li	a3,0
 6ec:	4629                	li	a2,10
 6ee:	000be583          	lwu	a1,0(s7)
 6f2:	855a                	mv	a0,s6
 6f4:	ddfff0ef          	jal	4d2 <printint>
 6f8:	8ba6                	mv	s7,s1
      state = 0;
 6fa:	4981                	li	s3,0
 6fc:	b5c9                	j	5be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6fe:	008b8493          	addi	s1,s7,8
 702:	4681                	li	a3,0
 704:	4629                	li	a2,10
 706:	000bb583          	ld	a1,0(s7)
 70a:	855a                	mv	a0,s6
 70c:	dc7ff0ef          	jal	4d2 <printint>
        i += 1;
 710:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 712:	8ba6                	mv	s7,s1
      state = 0;
 714:	4981                	li	s3,0
 716:	b565                	j	5be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 718:	008b8493          	addi	s1,s7,8
 71c:	4681                	li	a3,0
 71e:	4629                	li	a2,10
 720:	000bb583          	ld	a1,0(s7)
 724:	855a                	mv	a0,s6
 726:	dadff0ef          	jal	4d2 <printint>
        i += 2;
 72a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 72c:	8ba6                	mv	s7,s1
      state = 0;
 72e:	4981                	li	s3,0
        i += 2;
 730:	b579                	j	5be <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 732:	008b8493          	addi	s1,s7,8
 736:	4681                	li	a3,0
 738:	4641                	li	a2,16
 73a:	000be583          	lwu	a1,0(s7)
 73e:	855a                	mv	a0,s6
 740:	d93ff0ef          	jal	4d2 <printint>
 744:	8ba6                	mv	s7,s1
      state = 0;
 746:	4981                	li	s3,0
 748:	bd9d                	j	5be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 74a:	008b8493          	addi	s1,s7,8
 74e:	4681                	li	a3,0
 750:	4641                	li	a2,16
 752:	000bb583          	ld	a1,0(s7)
 756:	855a                	mv	a0,s6
 758:	d7bff0ef          	jal	4d2 <printint>
        i += 1;
 75c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 75e:	8ba6                	mv	s7,s1
      state = 0;
 760:	4981                	li	s3,0
 762:	bdb1                	j	5be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 764:	008b8493          	addi	s1,s7,8
 768:	4641                	li	a2,16
 76a:	000bb583          	ld	a1,0(s7)
 76e:	855a                	mv	a0,s6
 770:	d63ff0ef          	jal	4d2 <printint>
        i += 2;
 774:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 776:	8ba6                	mv	s7,s1
      state = 0;
 778:	4981                	li	s3,0
        i += 2;
 77a:	b591                	j	5be <vprintf+0x44>
 77c:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 77e:	008b8793          	addi	a5,s7,8
 782:	8cbe                	mv	s9,a5
 784:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 788:	03000593          	li	a1,48
 78c:	855a                	mv	a0,s6
 78e:	d27ff0ef          	jal	4b4 <putc>
  putc(fd, 'x');
 792:	07800593          	li	a1,120
 796:	855a                	mv	a0,s6
 798:	d1dff0ef          	jal	4b4 <putc>
 79c:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 79e:	00000b97          	auipc	s7,0x0
 7a2:	2d2b8b93          	addi	s7,s7,722 # a70 <digits>
 7a6:	03c9d793          	srli	a5,s3,0x3c
 7aa:	97de                	add	a5,a5,s7
 7ac:	0007c583          	lbu	a1,0(a5)
 7b0:	855a                	mv	a0,s6
 7b2:	d03ff0ef          	jal	4b4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7b6:	0992                	slli	s3,s3,0x4
 7b8:	34fd                	addiw	s1,s1,-1
 7ba:	f4f5                	bnez	s1,7a6 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 7bc:	8be6                	mv	s7,s9
      state = 0;
 7be:	4981                	li	s3,0
 7c0:	6ca2                	ld	s9,8(sp)
 7c2:	bbf5                	j	5be <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 7c4:	008b8493          	addi	s1,s7,8
 7c8:	000bc583          	lbu	a1,0(s7)
 7cc:	855a                	mv	a0,s6
 7ce:	ce7ff0ef          	jal	4b4 <putc>
 7d2:	8ba6                	mv	s7,s1
      state = 0;
 7d4:	4981                	li	s3,0
 7d6:	b3e5                	j	5be <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 7d8:	008b8993          	addi	s3,s7,8
 7dc:	000bb483          	ld	s1,0(s7)
 7e0:	cc91                	beqz	s1,7fc <vprintf+0x282>
        for(; *s; s++)
 7e2:	0004c583          	lbu	a1,0(s1)
 7e6:	c195                	beqz	a1,80a <vprintf+0x290>
          putc(fd, *s);
 7e8:	855a                	mv	a0,s6
 7ea:	ccbff0ef          	jal	4b4 <putc>
        for(; *s; s++)
 7ee:	0485                	addi	s1,s1,1
 7f0:	0004c583          	lbu	a1,0(s1)
 7f4:	f9f5                	bnez	a1,7e8 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 7f6:	8bce                	mv	s7,s3
      state = 0;
 7f8:	4981                	li	s3,0
 7fa:	b3d1                	j	5be <vprintf+0x44>
          s = "(null)";
 7fc:	00000497          	auipc	s1,0x0
 800:	26c48493          	addi	s1,s1,620 # a68 <malloc+0x13a>
        for(; *s; s++)
 804:	02800593          	li	a1,40
 808:	b7c5                	j	7e8 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 80a:	8bce                	mv	s7,s3
      state = 0;
 80c:	4981                	li	s3,0
 80e:	bb45                	j	5be <vprintf+0x44>
        putc(fd, '%');
 810:	85be                	mv	a1,a5
 812:	855a                	mv	a0,s6
 814:	ca1ff0ef          	jal	4b4 <putc>
 818:	bdbd                	j	696 <vprintf+0x11c>
 81a:	6906                	ld	s2,64(sp)
 81c:	79e2                	ld	s3,56(sp)
 81e:	7a42                	ld	s4,48(sp)
 820:	7aa2                	ld	s5,40(sp)
 822:	7b02                	ld	s6,32(sp)
 824:	6be2                	ld	s7,24(sp)
 826:	6c42                	ld	s8,16(sp)
    }
  }
}
 828:	60e6                	ld	ra,88(sp)
 82a:	6446                	ld	s0,80(sp)
 82c:	64a6                	ld	s1,72(sp)
 82e:	6125                	addi	sp,sp,96
 830:	8082                	ret
      if(c0 == 'd'){
 832:	06400713          	li	a4,100
 836:	e6e782e3          	beq	a5,a4,69a <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 83a:	f9478693          	addi	a3,a5,-108
 83e:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 842:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 844:	4701                	li	a4,0
 846:	bbe9                	j	620 <vprintf+0xa6>

0000000000000848 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 848:	715d                	addi	sp,sp,-80
 84a:	ec06                	sd	ra,24(sp)
 84c:	e822                	sd	s0,16(sp)
 84e:	1000                	addi	s0,sp,32
 850:	e010                	sd	a2,0(s0)
 852:	e414                	sd	a3,8(s0)
 854:	e818                	sd	a4,16(s0)
 856:	ec1c                	sd	a5,24(s0)
 858:	03043023          	sd	a6,32(s0)
 85c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 860:	8622                	mv	a2,s0
 862:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 866:	d15ff0ef          	jal	57a <vprintf>
}
 86a:	60e2                	ld	ra,24(sp)
 86c:	6442                	ld	s0,16(sp)
 86e:	6161                	addi	sp,sp,80
 870:	8082                	ret

0000000000000872 <printf>:

void
printf(const char *fmt, ...)
{
 872:	711d                	addi	sp,sp,-96
 874:	ec06                	sd	ra,24(sp)
 876:	e822                	sd	s0,16(sp)
 878:	1000                	addi	s0,sp,32
 87a:	e40c                	sd	a1,8(s0)
 87c:	e810                	sd	a2,16(s0)
 87e:	ec14                	sd	a3,24(s0)
 880:	f018                	sd	a4,32(s0)
 882:	f41c                	sd	a5,40(s0)
 884:	03043823          	sd	a6,48(s0)
 888:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 88c:	00840613          	addi	a2,s0,8
 890:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 894:	85aa                	mv	a1,a0
 896:	4505                	li	a0,1
 898:	ce3ff0ef          	jal	57a <vprintf>
}
 89c:	60e2                	ld	ra,24(sp)
 89e:	6442                	ld	s0,16(sp)
 8a0:	6125                	addi	sp,sp,96
 8a2:	8082                	ret

00000000000008a4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8a4:	1141                	addi	sp,sp,-16
 8a6:	e406                	sd	ra,8(sp)
 8a8:	e022                	sd	s0,0(sp)
 8aa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8ac:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b0:	00000797          	auipc	a5,0x0
 8b4:	7507b783          	ld	a5,1872(a5) # 1000 <freep>
 8b8:	a095                	j	91c <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 8ba:	ff852583          	lw	a1,-8(a0)
 8be:	6390                	ld	a2,0(a5)
 8c0:	02059813          	slli	a6,a1,0x20
 8c4:	01c85693          	srli	a3,a6,0x1c
 8c8:	96ba                	add	a3,a3,a4
 8ca:	02d60563          	beq	a2,a3,8f4 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 8ce:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 8d2:	4790                	lw	a2,8(a5)
 8d4:	02061593          	slli	a1,a2,0x20
 8d8:	01c5d693          	srli	a3,a1,0x1c
 8dc:	96be                	add	a3,a3,a5
 8de:	02d70263          	beq	a4,a3,902 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 8e2:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8e4:	00000717          	auipc	a4,0x0
 8e8:	70f73e23          	sd	a5,1820(a4) # 1000 <freep>
}
 8ec:	60a2                	ld	ra,8(sp)
 8ee:	6402                	ld	s0,0(sp)
 8f0:	0141                	addi	sp,sp,16
 8f2:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 8f4:	4614                	lw	a3,8(a2)
 8f6:	9ead                	addw	a3,a3,a1
 8f8:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8fc:	6394                	ld	a3,0(a5)
 8fe:	6290                	ld	a2,0(a3)
 900:	b7f9                	j	8ce <free+0x2a>
    p->s.size += bp->s.size;
 902:	ff852703          	lw	a4,-8(a0)
 906:	9f31                	addw	a4,a4,a2
 908:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 90a:	ff053703          	ld	a4,-16(a0)
 90e:	bfd1                	j	8e2 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 910:	6394                	ld	a3,0(a5)
 912:	00d7e463          	bltu	a5,a3,91a <free+0x76>
 916:	fad762e3          	bltu	a4,a3,8ba <free+0x16>
 91a:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 91c:	fee7fae3          	bgeu	a5,a4,910 <free+0x6c>
 920:	6394                	ld	a3,0(a5)
 922:	f8d76ce3          	bltu	a4,a3,8ba <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 926:	f8d7fae3          	bgeu	a5,a3,8ba <free+0x16>
 92a:	87b6                	mv	a5,a3
 92c:	bfc5                	j	91c <free+0x78>

000000000000092e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 92e:	7139                	addi	sp,sp,-64
 930:	fc06                	sd	ra,56(sp)
 932:	f822                	sd	s0,48(sp)
 934:	f04a                	sd	s2,32(sp)
 936:	ec4e                	sd	s3,24(sp)
 938:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 93a:	02051993          	slli	s3,a0,0x20
 93e:	0209d993          	srli	s3,s3,0x20
 942:	09bd                	addi	s3,s3,15
 944:	0049d993          	srli	s3,s3,0x4
 948:	2985                	addiw	s3,s3,1
 94a:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 94c:	00000517          	auipc	a0,0x0
 950:	6b453503          	ld	a0,1716(a0) # 1000 <freep>
 954:	c905                	beqz	a0,984 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 956:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 958:	4798                	lw	a4,8(a5)
 95a:	09377663          	bgeu	a4,s3,9e6 <malloc+0xb8>
 95e:	f426                	sd	s1,40(sp)
 960:	e852                	sd	s4,16(sp)
 962:	e456                	sd	s5,8(sp)
 964:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 966:	8a4e                	mv	s4,s3
 968:	6705                	lui	a4,0x1
 96a:	00e9f363          	bgeu	s3,a4,970 <malloc+0x42>
 96e:	6a05                	lui	s4,0x1
 970:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 974:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 978:	00000497          	auipc	s1,0x0
 97c:	68848493          	addi	s1,s1,1672 # 1000 <freep>
  if(p == SBRK_ERROR)
 980:	5afd                	li	s5,-1
 982:	a83d                	j	9c0 <malloc+0x92>
 984:	f426                	sd	s1,40(sp)
 986:	e852                	sd	s4,16(sp)
 988:	e456                	sd	s5,8(sp)
 98a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 98c:	00001797          	auipc	a5,0x1
 990:	88478793          	addi	a5,a5,-1916 # 1210 <base>
 994:	00000717          	auipc	a4,0x0
 998:	66f73623          	sd	a5,1644(a4) # 1000 <freep>
 99c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 99e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9a2:	b7d1                	j	966 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 9a4:	6398                	ld	a4,0(a5)
 9a6:	e118                	sd	a4,0(a0)
 9a8:	a899                	j	9fe <malloc+0xd0>
  hp->s.size = nu;
 9aa:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9ae:	0541                	addi	a0,a0,16
 9b0:	ef5ff0ef          	jal	8a4 <free>
  return freep;
 9b4:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 9b6:	c125                	beqz	a0,a16 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ba:	4798                	lw	a4,8(a5)
 9bc:	03277163          	bgeu	a4,s2,9de <malloc+0xb0>
    if(p == freep)
 9c0:	6098                	ld	a4,0(s1)
 9c2:	853e                	mv	a0,a5
 9c4:	fef71ae3          	bne	a4,a5,9b8 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 9c8:	8552                	mv	a0,s4
 9ca:	a17ff0ef          	jal	3e0 <sbrk>
  if(p == SBRK_ERROR)
 9ce:	fd551ee3          	bne	a0,s5,9aa <malloc+0x7c>
        return 0;
 9d2:	4501                	li	a0,0
 9d4:	74a2                	ld	s1,40(sp)
 9d6:	6a42                	ld	s4,16(sp)
 9d8:	6aa2                	ld	s5,8(sp)
 9da:	6b02                	ld	s6,0(sp)
 9dc:	a03d                	j	a0a <malloc+0xdc>
 9de:	74a2                	ld	s1,40(sp)
 9e0:	6a42                	ld	s4,16(sp)
 9e2:	6aa2                	ld	s5,8(sp)
 9e4:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9e6:	fae90fe3          	beq	s2,a4,9a4 <malloc+0x76>
        p->s.size -= nunits;
 9ea:	4137073b          	subw	a4,a4,s3
 9ee:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9f0:	02071693          	slli	a3,a4,0x20
 9f4:	01c6d713          	srli	a4,a3,0x1c
 9f8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9fa:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9fe:	00000717          	auipc	a4,0x0
 a02:	60a73123          	sd	a0,1538(a4) # 1000 <freep>
      return (void*)(p + 1);
 a06:	01078513          	addi	a0,a5,16
  }
}
 a0a:	70e2                	ld	ra,56(sp)
 a0c:	7442                	ld	s0,48(sp)
 a0e:	7902                	ld	s2,32(sp)
 a10:	69e2                	ld	s3,24(sp)
 a12:	6121                	addi	sp,sp,64
 a14:	8082                	ret
 a16:	74a2                	ld	s1,40(sp)
 a18:	6a42                	ld	s4,16(sp)
 a1a:	6aa2                	ld	s5,8(sp)
 a1c:	6b02                	ld	s6,0(sp)
 a1e:	b7f5                	j	a0a <malloc+0xdc>
