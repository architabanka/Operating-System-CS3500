
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	0080                	addi	s0,sp,64
  12:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  14:	20000a13          	li	s4,512
  18:	00001917          	auipc	s2,0x1
  1c:	ff890913          	addi	s2,s2,-8 # 1010 <buf>
    if (write(1, buf, n) != n) {
  20:	4a85                	li	s5,1
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  22:	8652                	mv	a2,s4
  24:	85ca                	mv	a1,s2
  26:	854e                	mv	a0,s3
  28:	39e000ef          	jal	3c6 <read>
  2c:	84aa                	mv	s1,a0
  2e:	02a05363          	blez	a0,54 <cat+0x54>
    if (write(1, buf, n) != n) {
  32:	8626                	mv	a2,s1
  34:	85ca                	mv	a1,s2
  36:	8556                	mv	a0,s5
  38:	396000ef          	jal	3ce <write>
  3c:	fe9503e3          	beq	a0,s1,22 <cat+0x22>
      fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	98058593          	addi	a1,a1,-1664 # 9c0 <malloc+0xf8>
  48:	4509                	li	a0,2
  4a:	798000ef          	jal	7e2 <fprintf>
      exit(1);
  4e:	4505                	li	a0,1
  50:	35e000ef          	jal	3ae <exit>
    }
  }
  if(n < 0){
  54:	00054b63          	bltz	a0,6a <cat+0x6a>
    fprintf(2, "cat: read error\n");
    exit(1);
  }
}
  58:	70e2                	ld	ra,56(sp)
  5a:	7442                	ld	s0,48(sp)
  5c:	74a2                	ld	s1,40(sp)
  5e:	7902                	ld	s2,32(sp)
  60:	69e2                	ld	s3,24(sp)
  62:	6a42                	ld	s4,16(sp)
  64:	6aa2                	ld	s5,8(sp)
  66:	6121                	addi	sp,sp,64
  68:	8082                	ret
    fprintf(2, "cat: read error\n");
  6a:	00001597          	auipc	a1,0x1
  6e:	96e58593          	addi	a1,a1,-1682 # 9d8 <malloc+0x110>
  72:	4509                	li	a0,2
  74:	76e000ef          	jal	7e2 <fprintf>
    exit(1);
  78:	4505                	li	a0,1
  7a:	334000ef          	jal	3ae <exit>

000000000000007e <main>:

int
main(int argc, char *argv[])
{
  7e:	7179                	addi	sp,sp,-48
  80:	f406                	sd	ra,40(sp)
  82:	f022                	sd	s0,32(sp)
  84:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  86:	4785                	li	a5,1
  88:	04a7d263          	bge	a5,a0,cc <main+0x4e>
  8c:	ec26                	sd	s1,24(sp)
  8e:	e84a                	sd	s2,16(sp)
  90:	e44e                	sd	s3,8(sp)
  92:	00858913          	addi	s2,a1,8
  96:	ffe5099b          	addiw	s3,a0,-2
  9a:	02099793          	slli	a5,s3,0x20
  9e:	01d7d993          	srli	s3,a5,0x1d
  a2:	05c1                	addi	a1,a1,16
  a4:	99ae                	add	s3,s3,a1
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], O_RDONLY)) < 0){
  a6:	4581                	li	a1,0
  a8:	00093503          	ld	a0,0(s2)
  ac:	342000ef          	jal	3ee <open>
  b0:	84aa                	mv	s1,a0
  b2:	02054663          	bltz	a0,de <main+0x60>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  b6:	f4bff0ef          	jal	0 <cat>
    close(fd);
  ba:	8526                	mv	a0,s1
  bc:	31a000ef          	jal	3d6 <close>
  for(i = 1; i < argc; i++){
  c0:	0921                	addi	s2,s2,8
  c2:	ff3912e3          	bne	s2,s3,a6 <main+0x28>
  }
  exit(0);
  c6:	4501                	li	a0,0
  c8:	2e6000ef          	jal	3ae <exit>
  cc:	ec26                	sd	s1,24(sp)
  ce:	e84a                	sd	s2,16(sp)
  d0:	e44e                	sd	s3,8(sp)
    cat(0);
  d2:	4501                	li	a0,0
  d4:	f2dff0ef          	jal	0 <cat>
    exit(0);
  d8:	4501                	li	a0,0
  da:	2d4000ef          	jal	3ae <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
  de:	00093603          	ld	a2,0(s2)
  e2:	00001597          	auipc	a1,0x1
  e6:	90e58593          	addi	a1,a1,-1778 # 9f0 <malloc+0x128>
  ea:	4509                	li	a0,2
  ec:	6f6000ef          	jal	7e2 <fprintf>
      exit(1);
  f0:	4505                	li	a0,1
  f2:	2bc000ef          	jal	3ae <exit>

00000000000000f6 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  f6:	1141                	addi	sp,sp,-16
  f8:	e406                	sd	ra,8(sp)
  fa:	e022                	sd	s0,0(sp)
  fc:	0800                	addi	s0,sp,16
  extern int main();
  main();
  fe:	f81ff0ef          	jal	7e <main>
  exit(0);
 102:	4501                	li	a0,0
 104:	2aa000ef          	jal	3ae <exit>

0000000000000108 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 108:	1141                	addi	sp,sp,-16
 10a:	e406                	sd	ra,8(sp)
 10c:	e022                	sd	s0,0(sp)
 10e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 110:	87aa                	mv	a5,a0
 112:	0585                	addi	a1,a1,1
 114:	0785                	addi	a5,a5,1
 116:	fff5c703          	lbu	a4,-1(a1)
 11a:	fee78fa3          	sb	a4,-1(a5)
 11e:	fb75                	bnez	a4,112 <strcpy+0xa>
    ;
  return os;
}
 120:	60a2                	ld	ra,8(sp)
 122:	6402                	ld	s0,0(sp)
 124:	0141                	addi	sp,sp,16
 126:	8082                	ret

0000000000000128 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 128:	1141                	addi	sp,sp,-16
 12a:	e406                	sd	ra,8(sp)
 12c:	e022                	sd	s0,0(sp)
 12e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 130:	00054783          	lbu	a5,0(a0)
 134:	cb91                	beqz	a5,148 <strcmp+0x20>
 136:	0005c703          	lbu	a4,0(a1)
 13a:	00f71763          	bne	a4,a5,148 <strcmp+0x20>
    p++, q++;
 13e:	0505                	addi	a0,a0,1
 140:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 142:	00054783          	lbu	a5,0(a0)
 146:	fbe5                	bnez	a5,136 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 148:	0005c503          	lbu	a0,0(a1)
}
 14c:	40a7853b          	subw	a0,a5,a0
 150:	60a2                	ld	ra,8(sp)
 152:	6402                	ld	s0,0(sp)
 154:	0141                	addi	sp,sp,16
 156:	8082                	ret

0000000000000158 <strlen>:

uint
strlen(const char *s)
{
 158:	1141                	addi	sp,sp,-16
 15a:	e406                	sd	ra,8(sp)
 15c:	e022                	sd	s0,0(sp)
 15e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 160:	00054783          	lbu	a5,0(a0)
 164:	cf91                	beqz	a5,180 <strlen+0x28>
 166:	00150793          	addi	a5,a0,1
 16a:	86be                	mv	a3,a5
 16c:	0785                	addi	a5,a5,1
 16e:	fff7c703          	lbu	a4,-1(a5)
 172:	ff65                	bnez	a4,16a <strlen+0x12>
 174:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 178:	60a2                	ld	ra,8(sp)
 17a:	6402                	ld	s0,0(sp)
 17c:	0141                	addi	sp,sp,16
 17e:	8082                	ret
  for(n = 0; s[n]; n++)
 180:	4501                	li	a0,0
 182:	bfdd                	j	178 <strlen+0x20>

0000000000000184 <memset>:

void*
memset(void *dst, int c, uint n)
{
 184:	1141                	addi	sp,sp,-16
 186:	e406                	sd	ra,8(sp)
 188:	e022                	sd	s0,0(sp)
 18a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 18c:	ca19                	beqz	a2,1a2 <memset+0x1e>
 18e:	87aa                	mv	a5,a0
 190:	1602                	slli	a2,a2,0x20
 192:	9201                	srli	a2,a2,0x20
 194:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 198:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 19c:	0785                	addi	a5,a5,1
 19e:	fee79de3          	bne	a5,a4,198 <memset+0x14>
  }
  return dst;
}
 1a2:	60a2                	ld	ra,8(sp)
 1a4:	6402                	ld	s0,0(sp)
 1a6:	0141                	addi	sp,sp,16
 1a8:	8082                	ret

00000000000001aa <strchr>:

char*
strchr(const char *s, char c)
{
 1aa:	1141                	addi	sp,sp,-16
 1ac:	e406                	sd	ra,8(sp)
 1ae:	e022                	sd	s0,0(sp)
 1b0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1b2:	00054783          	lbu	a5,0(a0)
 1b6:	c799                	beqz	a5,1c4 <strchr+0x1a>
    if(*s == c)
 1b8:	00f58763          	beq	a1,a5,1c6 <strchr+0x1c>
  for(; *s; s++)
 1bc:	0505                	addi	a0,a0,1
 1be:	00054783          	lbu	a5,0(a0)
 1c2:	fbfd                	bnez	a5,1b8 <strchr+0xe>
      return (char*)s;
  return 0;
 1c4:	4501                	li	a0,0
}
 1c6:	60a2                	ld	ra,8(sp)
 1c8:	6402                	ld	s0,0(sp)
 1ca:	0141                	addi	sp,sp,16
 1cc:	8082                	ret

00000000000001ce <gets>:

char*
gets(char *buf, int max)
{
 1ce:	711d                	addi	sp,sp,-96
 1d0:	ec86                	sd	ra,88(sp)
 1d2:	e8a2                	sd	s0,80(sp)
 1d4:	e4a6                	sd	s1,72(sp)
 1d6:	e0ca                	sd	s2,64(sp)
 1d8:	fc4e                	sd	s3,56(sp)
 1da:	f852                	sd	s4,48(sp)
 1dc:	f456                	sd	s5,40(sp)
 1de:	f05a                	sd	s6,32(sp)
 1e0:	ec5e                	sd	s7,24(sp)
 1e2:	e862                	sd	s8,16(sp)
 1e4:	1080                	addi	s0,sp,96
 1e6:	8baa                	mv	s7,a0
 1e8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ea:	892a                	mv	s2,a0
 1ec:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1ee:	faf40b13          	addi	s6,s0,-81
 1f2:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 1f4:	8c26                	mv	s8,s1
 1f6:	0014899b          	addiw	s3,s1,1
 1fa:	84ce                	mv	s1,s3
 1fc:	0349d863          	bge	s3,s4,22c <gets+0x5e>
    cc = read(0, &c, 1);
 200:	8656                	mv	a2,s5
 202:	85da                	mv	a1,s6
 204:	4501                	li	a0,0
 206:	1c0000ef          	jal	3c6 <read>
    if(cc < 1)
 20a:	02a05163          	blez	a0,22c <gets+0x5e>
      break;
    buf[i++] = c;
 20e:	faf44783          	lbu	a5,-81(s0)
 212:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 216:	0905                	addi	s2,s2,1
 218:	ff678713          	addi	a4,a5,-10
 21c:	00173713          	seqz	a4,a4
 220:	17cd                	addi	a5,a5,-13
 222:	0017b793          	seqz	a5,a5
 226:	8fd9                	or	a5,a5,a4
 228:	d7f1                	beqz	a5,1f4 <gets+0x26>
    buf[i++] = c;
 22a:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 22c:	9c5e                	add	s8,s8,s7
 22e:	000c0023          	sb	zero,0(s8)
  return buf;
}
 232:	855e                	mv	a0,s7
 234:	60e6                	ld	ra,88(sp)
 236:	6446                	ld	s0,80(sp)
 238:	64a6                	ld	s1,72(sp)
 23a:	6906                	ld	s2,64(sp)
 23c:	79e2                	ld	s3,56(sp)
 23e:	7a42                	ld	s4,48(sp)
 240:	7aa2                	ld	s5,40(sp)
 242:	7b02                	ld	s6,32(sp)
 244:	6be2                	ld	s7,24(sp)
 246:	6c42                	ld	s8,16(sp)
 248:	6125                	addi	sp,sp,96
 24a:	8082                	ret

000000000000024c <stat>:

int
stat(const char *n, struct stat *st)
{
 24c:	1101                	addi	sp,sp,-32
 24e:	ec06                	sd	ra,24(sp)
 250:	e822                	sd	s0,16(sp)
 252:	e04a                	sd	s2,0(sp)
 254:	1000                	addi	s0,sp,32
 256:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 258:	4581                	li	a1,0
 25a:	194000ef          	jal	3ee <open>
  if(fd < 0)
 25e:	02054263          	bltz	a0,282 <stat+0x36>
 262:	e426                	sd	s1,8(sp)
 264:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 266:	85ca                	mv	a1,s2
 268:	19e000ef          	jal	406 <fstat>
 26c:	892a                	mv	s2,a0
  close(fd);
 26e:	8526                	mv	a0,s1
 270:	166000ef          	jal	3d6 <close>
  return r;
 274:	64a2                	ld	s1,8(sp)
}
 276:	854a                	mv	a0,s2
 278:	60e2                	ld	ra,24(sp)
 27a:	6442                	ld	s0,16(sp)
 27c:	6902                	ld	s2,0(sp)
 27e:	6105                	addi	sp,sp,32
 280:	8082                	ret
    return -1;
 282:	57fd                	li	a5,-1
 284:	893e                	mv	s2,a5
 286:	bfc5                	j	276 <stat+0x2a>

0000000000000288 <atoi>:

int
atoi(const char *s)
{
 288:	1141                	addi	sp,sp,-16
 28a:	e406                	sd	ra,8(sp)
 28c:	e022                	sd	s0,0(sp)
 28e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 290:	00054683          	lbu	a3,0(a0)
 294:	fd06879b          	addiw	a5,a3,-48
 298:	0ff7f793          	zext.b	a5,a5
 29c:	4625                	li	a2,9
 29e:	02f66963          	bltu	a2,a5,2d0 <atoi+0x48>
 2a2:	872a                	mv	a4,a0
  n = 0;
 2a4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2a6:	0705                	addi	a4,a4,1
 2a8:	0025179b          	slliw	a5,a0,0x2
 2ac:	9fa9                	addw	a5,a5,a0
 2ae:	0017979b          	slliw	a5,a5,0x1
 2b2:	9fb5                	addw	a5,a5,a3
 2b4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2b8:	00074683          	lbu	a3,0(a4)
 2bc:	fd06879b          	addiw	a5,a3,-48
 2c0:	0ff7f793          	zext.b	a5,a5
 2c4:	fef671e3          	bgeu	a2,a5,2a6 <atoi+0x1e>
  return n;
}
 2c8:	60a2                	ld	ra,8(sp)
 2ca:	6402                	ld	s0,0(sp)
 2cc:	0141                	addi	sp,sp,16
 2ce:	8082                	ret
  n = 0;
 2d0:	4501                	li	a0,0
 2d2:	bfdd                	j	2c8 <atoi+0x40>

00000000000002d4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2d4:	1141                	addi	sp,sp,-16
 2d6:	e406                	sd	ra,8(sp)
 2d8:	e022                	sd	s0,0(sp)
 2da:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2dc:	02b57563          	bgeu	a0,a1,306 <memmove+0x32>
    while(n-- > 0)
 2e0:	00c05f63          	blez	a2,2fe <memmove+0x2a>
 2e4:	1602                	slli	a2,a2,0x20
 2e6:	9201                	srli	a2,a2,0x20
 2e8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2ec:	872a                	mv	a4,a0
      *dst++ = *src++;
 2ee:	0585                	addi	a1,a1,1
 2f0:	0705                	addi	a4,a4,1
 2f2:	fff5c683          	lbu	a3,-1(a1)
 2f6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2fa:	fee79ae3          	bne	a5,a4,2ee <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2fe:	60a2                	ld	ra,8(sp)
 300:	6402                	ld	s0,0(sp)
 302:	0141                	addi	sp,sp,16
 304:	8082                	ret
    while(n-- > 0)
 306:	fec05ce3          	blez	a2,2fe <memmove+0x2a>
    dst += n;
 30a:	00c50733          	add	a4,a0,a2
    src += n;
 30e:	95b2                	add	a1,a1,a2
 310:	fff6079b          	addiw	a5,a2,-1
 314:	1782                	slli	a5,a5,0x20
 316:	9381                	srli	a5,a5,0x20
 318:	fff7c793          	not	a5,a5
 31c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 31e:	15fd                	addi	a1,a1,-1
 320:	177d                	addi	a4,a4,-1
 322:	0005c683          	lbu	a3,0(a1)
 326:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 32a:	fef71ae3          	bne	a4,a5,31e <memmove+0x4a>
 32e:	bfc1                	j	2fe <memmove+0x2a>

0000000000000330 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 330:	1141                	addi	sp,sp,-16
 332:	e406                	sd	ra,8(sp)
 334:	e022                	sd	s0,0(sp)
 336:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 338:	ce19                	beqz	a2,356 <memcmp+0x26>
 33a:	1602                	slli	a2,a2,0x20
 33c:	9201                	srli	a2,a2,0x20
 33e:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 342:	00054783          	lbu	a5,0(a0)
 346:	0005c703          	lbu	a4,0(a1)
 34a:	00e79b63          	bne	a5,a4,360 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 34e:	0505                	addi	a0,a0,1
    p2++;
 350:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 352:	fed518e3          	bne	a0,a3,342 <memcmp+0x12>
  }
  return 0;
 356:	4501                	li	a0,0
}
 358:	60a2                	ld	ra,8(sp)
 35a:	6402                	ld	s0,0(sp)
 35c:	0141                	addi	sp,sp,16
 35e:	8082                	ret
      return *p1 - *p2;
 360:	40e7853b          	subw	a0,a5,a4
 364:	bfd5                	j	358 <memcmp+0x28>

0000000000000366 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 366:	1141                	addi	sp,sp,-16
 368:	e406                	sd	ra,8(sp)
 36a:	e022                	sd	s0,0(sp)
 36c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 36e:	f67ff0ef          	jal	2d4 <memmove>
}
 372:	60a2                	ld	ra,8(sp)
 374:	6402                	ld	s0,0(sp)
 376:	0141                	addi	sp,sp,16
 378:	8082                	ret

000000000000037a <sbrk>:

char *
sbrk(int n) {
 37a:	1141                	addi	sp,sp,-16
 37c:	e406                	sd	ra,8(sp)
 37e:	e022                	sd	s0,0(sp)
 380:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 382:	4585                	li	a1,1
 384:	0b2000ef          	jal	436 <sys_sbrk>
}
 388:	60a2                	ld	ra,8(sp)
 38a:	6402                	ld	s0,0(sp)
 38c:	0141                	addi	sp,sp,16
 38e:	8082                	ret

0000000000000390 <sbrklazy>:

char *
sbrklazy(int n) {
 390:	1141                	addi	sp,sp,-16
 392:	e406                	sd	ra,8(sp)
 394:	e022                	sd	s0,0(sp)
 396:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 398:	4589                	li	a1,2
 39a:	09c000ef          	jal	436 <sys_sbrk>
}
 39e:	60a2                	ld	ra,8(sp)
 3a0:	6402                	ld	s0,0(sp)
 3a2:	0141                	addi	sp,sp,16
 3a4:	8082                	ret

00000000000003a6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3a6:	4885                	li	a7,1
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ae:	4889                	li	a7,2
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3b6:	488d                	li	a7,3
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3be:	4891                	li	a7,4
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <read>:
.global read
read:
 li a7, SYS_read
 3c6:	4895                	li	a7,5
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <write>:
.global write
write:
 li a7, SYS_write
 3ce:	48c1                	li	a7,16
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <close>:
.global close
close:
 li a7, SYS_close
 3d6:	48d5                	li	a7,21
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <kill>:
.global kill
kill:
 li a7, SYS_kill
 3de:	4899                	li	a7,6
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3e6:	489d                	li	a7,7
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <open>:
.global open
open:
 li a7, SYS_open
 3ee:	48bd                	li	a7,15
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3f6:	48c5                	li	a7,17
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3fe:	48c9                	li	a7,18
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 406:	48a1                	li	a7,8
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <link>:
.global link
link:
 li a7, SYS_link
 40e:	48cd                	li	a7,19
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 416:	48d1                	li	a7,20
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 41e:	48a5                	li	a7,9
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <dup>:
.global dup
dup:
 li a7, SYS_dup
 426:	48a9                	li	a7,10
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 42e:	48ad                	li	a7,11
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 436:	48b1                	li	a7,12
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <pause>:
.global pause
pause:
 li a7, SYS_pause
 43e:	48b5                	li	a7,13
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 446:	48b9                	li	a7,14
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 44e:	1101                	addi	sp,sp,-32
 450:	ec06                	sd	ra,24(sp)
 452:	e822                	sd	s0,16(sp)
 454:	1000                	addi	s0,sp,32
 456:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 45a:	4605                	li	a2,1
 45c:	fef40593          	addi	a1,s0,-17
 460:	f6fff0ef          	jal	3ce <write>
}
 464:	60e2                	ld	ra,24(sp)
 466:	6442                	ld	s0,16(sp)
 468:	6105                	addi	sp,sp,32
 46a:	8082                	ret

000000000000046c <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 46c:	715d                	addi	sp,sp,-80
 46e:	e486                	sd	ra,72(sp)
 470:	e0a2                	sd	s0,64(sp)
 472:	f84a                	sd	s2,48(sp)
 474:	f44e                	sd	s3,40(sp)
 476:	0880                	addi	s0,sp,80
 478:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 47a:	00d036b3          	snez	a3,a3
 47e:	03f5d793          	srli	a5,a1,0x3f
 482:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 484:	0005871b          	sext.w	a4,a1
  neg = 0;
 488:	4301                	li	t1,0
  if(sgn && xx < 0){
 48a:	c681                	beqz	a3,492 <printint+0x26>
    x = -xx;
 48c:	40b0073b          	negw	a4,a1
    neg = 1;
 490:	4305                	li	t1,1
  }

  i = 0;
 492:	fb840993          	addi	s3,s0,-72
  neg = 0;
 496:	85ce                	mv	a1,s3
  i = 0;
 498:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 49a:	00000817          	auipc	a6,0x0
 49e:	57680813          	addi	a6,a6,1398 # a10 <digits>
 4a2:	88b6                	mv	a7,a3
 4a4:	0016851b          	addiw	a0,a3,1
 4a8:	86aa                	mv	a3,a0
 4aa:	02c777bb          	remuw	a5,a4,a2
 4ae:	1782                	slli	a5,a5,0x20
 4b0:	9381                	srli	a5,a5,0x20
 4b2:	97c2                	add	a5,a5,a6
 4b4:	0007c783          	lbu	a5,0(a5)
 4b8:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 4bc:	87ba                	mv	a5,a4
 4be:	02c7573b          	divuw	a4,a4,a2
 4c2:	0585                	addi	a1,a1,1
 4c4:	fcc7ffe3          	bgeu	a5,a2,4a2 <printint+0x36>
  if(neg)
 4c8:	00030b63          	beqz	t1,4de <printint+0x72>
    buf[i++] = '-';
 4cc:	fd040793          	addi	a5,s0,-48
 4d0:	953e                	add	a0,a0,a5
 4d2:	02d00793          	li	a5,45
 4d6:	fef50423          	sb	a5,-24(a0)
 4da:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 4de:	02d05563          	blez	a3,508 <printint+0x9c>
 4e2:	fc26                	sd	s1,56(sp)
 4e4:	36fd                	addiw	a3,a3,-1
 4e6:	00d984b3          	add	s1,s3,a3
 4ea:	19fd                	addi	s3,s3,-1
 4ec:	99b6                	add	s3,s3,a3
 4ee:	1682                	slli	a3,a3,0x20
 4f0:	9281                	srli	a3,a3,0x20
 4f2:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 4f6:	0004c583          	lbu	a1,0(s1)
 4fa:	854a                	mv	a0,s2
 4fc:	f53ff0ef          	jal	44e <putc>
  while(--i >= 0)
 500:	14fd                	addi	s1,s1,-1
 502:	ff349ae3          	bne	s1,s3,4f6 <printint+0x8a>
 506:	74e2                	ld	s1,56(sp)
}
 508:	60a6                	ld	ra,72(sp)
 50a:	6406                	ld	s0,64(sp)
 50c:	7942                	ld	s2,48(sp)
 50e:	79a2                	ld	s3,40(sp)
 510:	6161                	addi	sp,sp,80
 512:	8082                	ret

0000000000000514 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 514:	711d                	addi	sp,sp,-96
 516:	ec86                	sd	ra,88(sp)
 518:	e8a2                	sd	s0,80(sp)
 51a:	e4a6                	sd	s1,72(sp)
 51c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 51e:	0005c483          	lbu	s1,0(a1)
 522:	2a048063          	beqz	s1,7c2 <vprintf+0x2ae>
 526:	e0ca                	sd	s2,64(sp)
 528:	fc4e                	sd	s3,56(sp)
 52a:	f852                	sd	s4,48(sp)
 52c:	f456                	sd	s5,40(sp)
 52e:	f05a                	sd	s6,32(sp)
 530:	ec5e                	sd	s7,24(sp)
 532:	e862                	sd	s8,16(sp)
 534:	8b2a                	mv	s6,a0
 536:	8a2e                	mv	s4,a1
 538:	8bb2                	mv	s7,a2
  state = 0;
 53a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 53c:	4901                	li	s2,0
 53e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 540:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 544:	06400c13          	li	s8,100
 548:	a00d                	j	56a <vprintf+0x56>
        putc(fd, c0);
 54a:	85a6                	mv	a1,s1
 54c:	855a                	mv	a0,s6
 54e:	f01ff0ef          	jal	44e <putc>
 552:	a019                	j	558 <vprintf+0x44>
    } else if(state == '%'){
 554:	03598363          	beq	s3,s5,57a <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 558:	0019079b          	addiw	a5,s2,1
 55c:	893e                	mv	s2,a5
 55e:	873e                	mv	a4,a5
 560:	97d2                	add	a5,a5,s4
 562:	0007c483          	lbu	s1,0(a5)
 566:	24048763          	beqz	s1,7b4 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 56a:	0004879b          	sext.w	a5,s1
    if(state == 0){
 56e:	fe0993e3          	bnez	s3,554 <vprintf+0x40>
      if(c0 == '%'){
 572:	fd579ce3          	bne	a5,s5,54a <vprintf+0x36>
        state = '%';
 576:	89be                	mv	s3,a5
 578:	b7c5                	j	558 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 57a:	00ea06b3          	add	a3,s4,a4
 57e:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 582:	24060563          	beqz	a2,7cc <vprintf+0x2b8>
      if(c0 == 'd'){
 586:	0b878763          	beq	a5,s8,634 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 58a:	f9478693          	addi	a3,a5,-108
 58e:	0016b693          	seqz	a3,a3
 592:	f9c60593          	addi	a1,a2,-100
 596:	0015b593          	seqz	a1,a1
 59a:	8df5                	and	a1,a1,a3
 59c:	e9c5                	bnez	a1,64c <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 59e:	9752                	add	a4,a4,s4
 5a0:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5a4:	f9460713          	addi	a4,a2,-108
 5a8:	00173713          	seqz	a4,a4
 5ac:	8f75                	and	a4,a4,a3
 5ae:	f9c50593          	addi	a1,a0,-100
 5b2:	0015b593          	seqz	a1,a1
 5b6:	8df9                	and	a1,a1,a4
 5b8:	e5dd                	bnez	a1,666 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5ba:	07500593          	li	a1,117
 5be:	0cb78163          	beq	a5,a1,680 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 5c2:	f8b60593          	addi	a1,a2,-117
 5c6:	0015b593          	seqz	a1,a1
 5ca:	8df5                	and	a1,a1,a3
 5cc:	e5f1                	bnez	a1,698 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 5ce:	f8b50593          	addi	a1,a0,-117
 5d2:	0015b593          	seqz	a1,a1
 5d6:	8df9                	and	a1,a1,a4
 5d8:	ede9                	bnez	a1,6b2 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5da:	07800593          	li	a1,120
 5de:	0eb78763          	beq	a5,a1,6cc <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 5e2:	f8860613          	addi	a2,a2,-120
 5e6:	00163613          	seqz	a2,a2
 5ea:	8ef1                	and	a3,a3,a2
 5ec:	0e069c63          	bnez	a3,6e4 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5f0:	f8850513          	addi	a0,a0,-120
 5f4:	00153513          	seqz	a0,a0
 5f8:	8f69                	and	a4,a4,a0
 5fa:	10071263          	bnez	a4,6fe <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5fe:	07000713          	li	a4,112
 602:	10e78a63          	beq	a5,a4,716 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 606:	06300713          	li	a4,99
 60a:	14e78a63          	beq	a5,a4,75e <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 60e:	07300713          	li	a4,115
 612:	16e78063          	beq	a5,a4,772 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 616:	02500713          	li	a4,37
 61a:	18e78863          	beq	a5,a4,7aa <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 61e:	02500593          	li	a1,37
 622:	855a                	mv	a0,s6
 624:	e2bff0ef          	jal	44e <putc>
        putc(fd, c0);
 628:	85a6                	mv	a1,s1
 62a:	855a                	mv	a0,s6
 62c:	e23ff0ef          	jal	44e <putc>
      }

      state = 0;
 630:	4981                	li	s3,0
 632:	b71d                	j	558 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 634:	008b8493          	addi	s1,s7,8
 638:	4685                	li	a3,1
 63a:	4629                	li	a2,10
 63c:	000ba583          	lw	a1,0(s7)
 640:	855a                	mv	a0,s6
 642:	e2bff0ef          	jal	46c <printint>
 646:	8ba6                	mv	s7,s1
      state = 0;
 648:	4981                	li	s3,0
 64a:	b739                	j	558 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 64c:	008b8493          	addi	s1,s7,8
 650:	4685                	li	a3,1
 652:	4629                	li	a2,10
 654:	000bb583          	ld	a1,0(s7)
 658:	855a                	mv	a0,s6
 65a:	e13ff0ef          	jal	46c <printint>
        i += 1;
 65e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 660:	8ba6                	mv	s7,s1
      state = 0;
 662:	4981                	li	s3,0
 664:	bdd5                	j	558 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 666:	008b8493          	addi	s1,s7,8
 66a:	4685                	li	a3,1
 66c:	4629                	li	a2,10
 66e:	000bb583          	ld	a1,0(s7)
 672:	855a                	mv	a0,s6
 674:	df9ff0ef          	jal	46c <printint>
        i += 2;
 678:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 67a:	8ba6                	mv	s7,s1
      state = 0;
 67c:	4981                	li	s3,0
        i += 2;
 67e:	bde9                	j	558 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 680:	008b8493          	addi	s1,s7,8
 684:	4681                	li	a3,0
 686:	4629                	li	a2,10
 688:	000be583          	lwu	a1,0(s7)
 68c:	855a                	mv	a0,s6
 68e:	ddfff0ef          	jal	46c <printint>
 692:	8ba6                	mv	s7,s1
      state = 0;
 694:	4981                	li	s3,0
 696:	b5c9                	j	558 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 698:	008b8493          	addi	s1,s7,8
 69c:	4681                	li	a3,0
 69e:	4629                	li	a2,10
 6a0:	000bb583          	ld	a1,0(s7)
 6a4:	855a                	mv	a0,s6
 6a6:	dc7ff0ef          	jal	46c <printint>
        i += 1;
 6aa:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ac:	8ba6                	mv	s7,s1
      state = 0;
 6ae:	4981                	li	s3,0
 6b0:	b565                	j	558 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b2:	008b8493          	addi	s1,s7,8
 6b6:	4681                	li	a3,0
 6b8:	4629                	li	a2,10
 6ba:	000bb583          	ld	a1,0(s7)
 6be:	855a                	mv	a0,s6
 6c0:	dadff0ef          	jal	46c <printint>
        i += 2;
 6c4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6c6:	8ba6                	mv	s7,s1
      state = 0;
 6c8:	4981                	li	s3,0
        i += 2;
 6ca:	b579                	j	558 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6cc:	008b8493          	addi	s1,s7,8
 6d0:	4681                	li	a3,0
 6d2:	4641                	li	a2,16
 6d4:	000be583          	lwu	a1,0(s7)
 6d8:	855a                	mv	a0,s6
 6da:	d93ff0ef          	jal	46c <printint>
 6de:	8ba6                	mv	s7,s1
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	bd9d                	j	558 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6e4:	008b8493          	addi	s1,s7,8
 6e8:	4681                	li	a3,0
 6ea:	4641                	li	a2,16
 6ec:	000bb583          	ld	a1,0(s7)
 6f0:	855a                	mv	a0,s6
 6f2:	d7bff0ef          	jal	46c <printint>
        i += 1;
 6f6:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6f8:	8ba6                	mv	s7,s1
      state = 0;
 6fa:	4981                	li	s3,0
 6fc:	bdb1                	j	558 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6fe:	008b8493          	addi	s1,s7,8
 702:	4641                	li	a2,16
 704:	000bb583          	ld	a1,0(s7)
 708:	855a                	mv	a0,s6
 70a:	d63ff0ef          	jal	46c <printint>
        i += 2;
 70e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 710:	8ba6                	mv	s7,s1
      state = 0;
 712:	4981                	li	s3,0
        i += 2;
 714:	b591                	j	558 <vprintf+0x44>
 716:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 718:	008b8793          	addi	a5,s7,8
 71c:	8cbe                	mv	s9,a5
 71e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 722:	03000593          	li	a1,48
 726:	855a                	mv	a0,s6
 728:	d27ff0ef          	jal	44e <putc>
  putc(fd, 'x');
 72c:	07800593          	li	a1,120
 730:	855a                	mv	a0,s6
 732:	d1dff0ef          	jal	44e <putc>
 736:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 738:	00000b97          	auipc	s7,0x0
 73c:	2d8b8b93          	addi	s7,s7,728 # a10 <digits>
 740:	03c9d793          	srli	a5,s3,0x3c
 744:	97de                	add	a5,a5,s7
 746:	0007c583          	lbu	a1,0(a5)
 74a:	855a                	mv	a0,s6
 74c:	d03ff0ef          	jal	44e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 750:	0992                	slli	s3,s3,0x4
 752:	34fd                	addiw	s1,s1,-1
 754:	f4f5                	bnez	s1,740 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 756:	8be6                	mv	s7,s9
      state = 0;
 758:	4981                	li	s3,0
 75a:	6ca2                	ld	s9,8(sp)
 75c:	bbf5                	j	558 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 75e:	008b8493          	addi	s1,s7,8
 762:	000bc583          	lbu	a1,0(s7)
 766:	855a                	mv	a0,s6
 768:	ce7ff0ef          	jal	44e <putc>
 76c:	8ba6                	mv	s7,s1
      state = 0;
 76e:	4981                	li	s3,0
 770:	b3e5                	j	558 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 772:	008b8993          	addi	s3,s7,8
 776:	000bb483          	ld	s1,0(s7)
 77a:	cc91                	beqz	s1,796 <vprintf+0x282>
        for(; *s; s++)
 77c:	0004c583          	lbu	a1,0(s1)
 780:	c195                	beqz	a1,7a4 <vprintf+0x290>
          putc(fd, *s);
 782:	855a                	mv	a0,s6
 784:	ccbff0ef          	jal	44e <putc>
        for(; *s; s++)
 788:	0485                	addi	s1,s1,1
 78a:	0004c583          	lbu	a1,0(s1)
 78e:	f9f5                	bnez	a1,782 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 790:	8bce                	mv	s7,s3
      state = 0;
 792:	4981                	li	s3,0
 794:	b3d1                	j	558 <vprintf+0x44>
          s = "(null)";
 796:	00000497          	auipc	s1,0x0
 79a:	27248493          	addi	s1,s1,626 # a08 <malloc+0x140>
        for(; *s; s++)
 79e:	02800593          	li	a1,40
 7a2:	b7c5                	j	782 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 7a4:	8bce                	mv	s7,s3
      state = 0;
 7a6:	4981                	li	s3,0
 7a8:	bb45                	j	558 <vprintf+0x44>
        putc(fd, '%');
 7aa:	85be                	mv	a1,a5
 7ac:	855a                	mv	a0,s6
 7ae:	ca1ff0ef          	jal	44e <putc>
 7b2:	bdbd                	j	630 <vprintf+0x11c>
 7b4:	6906                	ld	s2,64(sp)
 7b6:	79e2                	ld	s3,56(sp)
 7b8:	7a42                	ld	s4,48(sp)
 7ba:	7aa2                	ld	s5,40(sp)
 7bc:	7b02                	ld	s6,32(sp)
 7be:	6be2                	ld	s7,24(sp)
 7c0:	6c42                	ld	s8,16(sp)
    }
  }
}
 7c2:	60e6                	ld	ra,88(sp)
 7c4:	6446                	ld	s0,80(sp)
 7c6:	64a6                	ld	s1,72(sp)
 7c8:	6125                	addi	sp,sp,96
 7ca:	8082                	ret
      if(c0 == 'd'){
 7cc:	06400713          	li	a4,100
 7d0:	e6e782e3          	beq	a5,a4,634 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 7d4:	f9478693          	addi	a3,a5,-108
 7d8:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 7dc:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7de:	4701                	li	a4,0
 7e0:	bbe9                	j	5ba <vprintf+0xa6>

00000000000007e2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7e2:	715d                	addi	sp,sp,-80
 7e4:	ec06                	sd	ra,24(sp)
 7e6:	e822                	sd	s0,16(sp)
 7e8:	1000                	addi	s0,sp,32
 7ea:	e010                	sd	a2,0(s0)
 7ec:	e414                	sd	a3,8(s0)
 7ee:	e818                	sd	a4,16(s0)
 7f0:	ec1c                	sd	a5,24(s0)
 7f2:	03043023          	sd	a6,32(s0)
 7f6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7fa:	8622                	mv	a2,s0
 7fc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 800:	d15ff0ef          	jal	514 <vprintf>
}
 804:	60e2                	ld	ra,24(sp)
 806:	6442                	ld	s0,16(sp)
 808:	6161                	addi	sp,sp,80
 80a:	8082                	ret

000000000000080c <printf>:

void
printf(const char *fmt, ...)
{
 80c:	711d                	addi	sp,sp,-96
 80e:	ec06                	sd	ra,24(sp)
 810:	e822                	sd	s0,16(sp)
 812:	1000                	addi	s0,sp,32
 814:	e40c                	sd	a1,8(s0)
 816:	e810                	sd	a2,16(s0)
 818:	ec14                	sd	a3,24(s0)
 81a:	f018                	sd	a4,32(s0)
 81c:	f41c                	sd	a5,40(s0)
 81e:	03043823          	sd	a6,48(s0)
 822:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 826:	00840613          	addi	a2,s0,8
 82a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 82e:	85aa                	mv	a1,a0
 830:	4505                	li	a0,1
 832:	ce3ff0ef          	jal	514 <vprintf>
}
 836:	60e2                	ld	ra,24(sp)
 838:	6442                	ld	s0,16(sp)
 83a:	6125                	addi	sp,sp,96
 83c:	8082                	ret

000000000000083e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 83e:	1141                	addi	sp,sp,-16
 840:	e406                	sd	ra,8(sp)
 842:	e022                	sd	s0,0(sp)
 844:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 846:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 84a:	00000797          	auipc	a5,0x0
 84e:	7b67b783          	ld	a5,1974(a5) # 1000 <freep>
 852:	a095                	j	8b6 <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 854:	ff852583          	lw	a1,-8(a0)
 858:	6390                	ld	a2,0(a5)
 85a:	02059813          	slli	a6,a1,0x20
 85e:	01c85693          	srli	a3,a6,0x1c
 862:	96ba                	add	a3,a3,a4
 864:	02d60563          	beq	a2,a3,88e <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 868:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 86c:	4790                	lw	a2,8(a5)
 86e:	02061593          	slli	a1,a2,0x20
 872:	01c5d693          	srli	a3,a1,0x1c
 876:	96be                	add	a3,a3,a5
 878:	02d70263          	beq	a4,a3,89c <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 87c:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 87e:	00000717          	auipc	a4,0x0
 882:	78f73123          	sd	a5,1922(a4) # 1000 <freep>
}
 886:	60a2                	ld	ra,8(sp)
 888:	6402                	ld	s0,0(sp)
 88a:	0141                	addi	sp,sp,16
 88c:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 88e:	4614                	lw	a3,8(a2)
 890:	9ead                	addw	a3,a3,a1
 892:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 896:	6394                	ld	a3,0(a5)
 898:	6290                	ld	a2,0(a3)
 89a:	b7f9                	j	868 <free+0x2a>
    p->s.size += bp->s.size;
 89c:	ff852703          	lw	a4,-8(a0)
 8a0:	9f31                	addw	a4,a4,a2
 8a2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8a4:	ff053703          	ld	a4,-16(a0)
 8a8:	bfd1                	j	87c <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8aa:	6394                	ld	a3,0(a5)
 8ac:	00d7e463          	bltu	a5,a3,8b4 <free+0x76>
 8b0:	fad762e3          	bltu	a4,a3,854 <free+0x16>
 8b4:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b6:	fee7fae3          	bgeu	a5,a4,8aa <free+0x6c>
 8ba:	6394                	ld	a3,0(a5)
 8bc:	f8d76ce3          	bltu	a4,a3,854 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c0:	f8d7fae3          	bgeu	a5,a3,854 <free+0x16>
 8c4:	87b6                	mv	a5,a3
 8c6:	bfc5                	j	8b6 <free+0x78>

00000000000008c8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8c8:	7139                	addi	sp,sp,-64
 8ca:	fc06                	sd	ra,56(sp)
 8cc:	f822                	sd	s0,48(sp)
 8ce:	f04a                	sd	s2,32(sp)
 8d0:	ec4e                	sd	s3,24(sp)
 8d2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d4:	02051993          	slli	s3,a0,0x20
 8d8:	0209d993          	srli	s3,s3,0x20
 8dc:	09bd                	addi	s3,s3,15
 8de:	0049d993          	srli	s3,s3,0x4
 8e2:	2985                	addiw	s3,s3,1
 8e4:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8e6:	00000517          	auipc	a0,0x0
 8ea:	71a53503          	ld	a0,1818(a0) # 1000 <freep>
 8ee:	c905                	beqz	a0,91e <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8f2:	4798                	lw	a4,8(a5)
 8f4:	09377663          	bgeu	a4,s3,980 <malloc+0xb8>
 8f8:	f426                	sd	s1,40(sp)
 8fa:	e852                	sd	s4,16(sp)
 8fc:	e456                	sd	s5,8(sp)
 8fe:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 900:	8a4e                	mv	s4,s3
 902:	6705                	lui	a4,0x1
 904:	00e9f363          	bgeu	s3,a4,90a <malloc+0x42>
 908:	6a05                	lui	s4,0x1
 90a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 90e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 912:	00000497          	auipc	s1,0x0
 916:	6ee48493          	addi	s1,s1,1774 # 1000 <freep>
  if(p == SBRK_ERROR)
 91a:	5afd                	li	s5,-1
 91c:	a83d                	j	95a <malloc+0x92>
 91e:	f426                	sd	s1,40(sp)
 920:	e852                	sd	s4,16(sp)
 922:	e456                	sd	s5,8(sp)
 924:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 926:	00001797          	auipc	a5,0x1
 92a:	8ea78793          	addi	a5,a5,-1814 # 1210 <base>
 92e:	00000717          	auipc	a4,0x0
 932:	6cf73923          	sd	a5,1746(a4) # 1000 <freep>
 936:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 938:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 93c:	b7d1                	j	900 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 93e:	6398                	ld	a4,0(a5)
 940:	e118                	sd	a4,0(a0)
 942:	a899                	j	998 <malloc+0xd0>
  hp->s.size = nu;
 944:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 948:	0541                	addi	a0,a0,16
 94a:	ef5ff0ef          	jal	83e <free>
  return freep;
 94e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 950:	c125                	beqz	a0,9b0 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 952:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 954:	4798                	lw	a4,8(a5)
 956:	03277163          	bgeu	a4,s2,978 <malloc+0xb0>
    if(p == freep)
 95a:	6098                	ld	a4,0(s1)
 95c:	853e                	mv	a0,a5
 95e:	fef71ae3          	bne	a4,a5,952 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 962:	8552                	mv	a0,s4
 964:	a17ff0ef          	jal	37a <sbrk>
  if(p == SBRK_ERROR)
 968:	fd551ee3          	bne	a0,s5,944 <malloc+0x7c>
        return 0;
 96c:	4501                	li	a0,0
 96e:	74a2                	ld	s1,40(sp)
 970:	6a42                	ld	s4,16(sp)
 972:	6aa2                	ld	s5,8(sp)
 974:	6b02                	ld	s6,0(sp)
 976:	a03d                	j	9a4 <malloc+0xdc>
 978:	74a2                	ld	s1,40(sp)
 97a:	6a42                	ld	s4,16(sp)
 97c:	6aa2                	ld	s5,8(sp)
 97e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 980:	fae90fe3          	beq	s2,a4,93e <malloc+0x76>
        p->s.size -= nunits;
 984:	4137073b          	subw	a4,a4,s3
 988:	c798                	sw	a4,8(a5)
        p += p->s.size;
 98a:	02071693          	slli	a3,a4,0x20
 98e:	01c6d713          	srli	a4,a3,0x1c
 992:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 994:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 998:	00000717          	auipc	a4,0x0
 99c:	66a73423          	sd	a0,1640(a4) # 1000 <freep>
      return (void*)(p + 1);
 9a0:	01078513          	addi	a0,a5,16
  }
}
 9a4:	70e2                	ld	ra,56(sp)
 9a6:	7442                	ld	s0,48(sp)
 9a8:	7902                	ld	s2,32(sp)
 9aa:	69e2                	ld	s3,24(sp)
 9ac:	6121                	addi	sp,sp,64
 9ae:	8082                	ret
 9b0:	74a2                	ld	s1,40(sp)
 9b2:	6a42                	ld	s4,16(sp)
 9b4:	6aa2                	ld	s5,8(sp)
 9b6:	6b02                	ld	s6,0(sp)
 9b8:	b7f5                	j	9a4 <malloc+0xdc>
