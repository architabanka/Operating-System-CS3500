
user/_dorphan:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char buf[BUFSZ];

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
  char *s = argv[0];
   a:	6184                	ld	s1,0(a1)

  if(mkdir("dd") != 0){
   c:	00001517          	auipc	a0,0x1
  10:	94450513          	addi	a0,a0,-1724 # 950 <malloc+0xf2>
  14:	398000ef          	jal	3ac <mkdir>
  18:	c919                	beqz	a0,2e <main+0x2e>
    printf("%s: mkdir dd failed\n", s);
  1a:	85a6                	mv	a1,s1
  1c:	00001517          	auipc	a0,0x1
  20:	93c50513          	addi	a0,a0,-1732 # 958 <malloc+0xfa>
  24:	77e000ef          	jal	7a2 <printf>
    exit(1);
  28:	4505                	li	a0,1
  2a:	31a000ef          	jal	344 <exit>
  }

  if(chdir("dd") != 0){
  2e:	00001517          	auipc	a0,0x1
  32:	92250513          	addi	a0,a0,-1758 # 950 <malloc+0xf2>
  36:	37e000ef          	jal	3b4 <chdir>
  3a:	c919                	beqz	a0,50 <main+0x50>
    printf("%s: chdir dd failed\n", s);
  3c:	85a6                	mv	a1,s1
  3e:	00001517          	auipc	a0,0x1
  42:	93250513          	addi	a0,a0,-1742 # 970 <malloc+0x112>
  46:	75c000ef          	jal	7a2 <printf>
    exit(1);
  4a:	4505                	li	a0,1
  4c:	2f8000ef          	jal	344 <exit>
  }

  if (unlink("../dd") < 0) {
  50:	00001517          	auipc	a0,0x1
  54:	93850513          	addi	a0,a0,-1736 # 988 <malloc+0x12a>
  58:	33c000ef          	jal	394 <unlink>
  5c:	00054e63          	bltz	a0,78 <main+0x78>
    printf("%s: unlink failed\n", s);
    exit(1);
  }
  printf("wait for kill and reclaim\n");
  60:	00001517          	auipc	a0,0x1
  64:	94850513          	addi	a0,a0,-1720 # 9a8 <malloc+0x14a>
  68:	73a000ef          	jal	7a2 <printf>
  // sit around until killed
  for(;;) pause(1000);
  6c:	3e800493          	li	s1,1000
  70:	8526                	mv	a0,s1
  72:	362000ef          	jal	3d4 <pause>
  76:	bfed                	j	70 <main+0x70>
    printf("%s: unlink failed\n", s);
  78:	85a6                	mv	a1,s1
  7a:	00001517          	auipc	a0,0x1
  7e:	91650513          	addi	a0,a0,-1770 # 990 <malloc+0x132>
  82:	720000ef          	jal	7a2 <printf>
    exit(1);
  86:	4505                	li	a0,1
  88:	2bc000ef          	jal	344 <exit>

000000000000008c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  8c:	1141                	addi	sp,sp,-16
  8e:	e406                	sd	ra,8(sp)
  90:	e022                	sd	s0,0(sp)
  92:	0800                	addi	s0,sp,16
  extern int main();
  main();
  94:	f6dff0ef          	jal	0 <main>
  exit(0);
  98:	4501                	li	a0,0
  9a:	2aa000ef          	jal	344 <exit>

000000000000009e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  9e:	1141                	addi	sp,sp,-16
  a0:	e406                	sd	ra,8(sp)
  a2:	e022                	sd	s0,0(sp)
  a4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a6:	87aa                	mv	a5,a0
  a8:	0585                	addi	a1,a1,1
  aa:	0785                	addi	a5,a5,1
  ac:	fff5c703          	lbu	a4,-1(a1)
  b0:	fee78fa3          	sb	a4,-1(a5)
  b4:	fb75                	bnez	a4,a8 <strcpy+0xa>
    ;
  return os;
}
  b6:	60a2                	ld	ra,8(sp)
  b8:	6402                	ld	s0,0(sp)
  ba:	0141                	addi	sp,sp,16
  bc:	8082                	ret

00000000000000be <strcmp>:

int
strcmp(const char *p, const char *q)
{
  be:	1141                	addi	sp,sp,-16
  c0:	e406                	sd	ra,8(sp)
  c2:	e022                	sd	s0,0(sp)
  c4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  c6:	00054783          	lbu	a5,0(a0)
  ca:	cb91                	beqz	a5,de <strcmp+0x20>
  cc:	0005c703          	lbu	a4,0(a1)
  d0:	00f71763          	bne	a4,a5,de <strcmp+0x20>
    p++, q++;
  d4:	0505                	addi	a0,a0,1
  d6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  d8:	00054783          	lbu	a5,0(a0)
  dc:	fbe5                	bnez	a5,cc <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  de:	0005c503          	lbu	a0,0(a1)
}
  e2:	40a7853b          	subw	a0,a5,a0
  e6:	60a2                	ld	ra,8(sp)
  e8:	6402                	ld	s0,0(sp)
  ea:	0141                	addi	sp,sp,16
  ec:	8082                	ret

00000000000000ee <strlen>:

uint
strlen(const char *s)
{
  ee:	1141                	addi	sp,sp,-16
  f0:	e406                	sd	ra,8(sp)
  f2:	e022                	sd	s0,0(sp)
  f4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  f6:	00054783          	lbu	a5,0(a0)
  fa:	cf91                	beqz	a5,116 <strlen+0x28>
  fc:	00150793          	addi	a5,a0,1
 100:	86be                	mv	a3,a5
 102:	0785                	addi	a5,a5,1
 104:	fff7c703          	lbu	a4,-1(a5)
 108:	ff65                	bnez	a4,100 <strlen+0x12>
 10a:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 10e:	60a2                	ld	ra,8(sp)
 110:	6402                	ld	s0,0(sp)
 112:	0141                	addi	sp,sp,16
 114:	8082                	ret
  for(n = 0; s[n]; n++)
 116:	4501                	li	a0,0
 118:	bfdd                	j	10e <strlen+0x20>

000000000000011a <memset>:

void*
memset(void *dst, int c, uint n)
{
 11a:	1141                	addi	sp,sp,-16
 11c:	e406                	sd	ra,8(sp)
 11e:	e022                	sd	s0,0(sp)
 120:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 122:	ca19                	beqz	a2,138 <memset+0x1e>
 124:	87aa                	mv	a5,a0
 126:	1602                	slli	a2,a2,0x20
 128:	9201                	srli	a2,a2,0x20
 12a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 12e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 132:	0785                	addi	a5,a5,1
 134:	fee79de3          	bne	a5,a4,12e <memset+0x14>
  }
  return dst;
}
 138:	60a2                	ld	ra,8(sp)
 13a:	6402                	ld	s0,0(sp)
 13c:	0141                	addi	sp,sp,16
 13e:	8082                	ret

0000000000000140 <strchr>:

char*
strchr(const char *s, char c)
{
 140:	1141                	addi	sp,sp,-16
 142:	e406                	sd	ra,8(sp)
 144:	e022                	sd	s0,0(sp)
 146:	0800                	addi	s0,sp,16
  for(; *s; s++)
 148:	00054783          	lbu	a5,0(a0)
 14c:	c799                	beqz	a5,15a <strchr+0x1a>
    if(*s == c)
 14e:	00f58763          	beq	a1,a5,15c <strchr+0x1c>
  for(; *s; s++)
 152:	0505                	addi	a0,a0,1
 154:	00054783          	lbu	a5,0(a0)
 158:	fbfd                	bnez	a5,14e <strchr+0xe>
      return (char*)s;
  return 0;
 15a:	4501                	li	a0,0
}
 15c:	60a2                	ld	ra,8(sp)
 15e:	6402                	ld	s0,0(sp)
 160:	0141                	addi	sp,sp,16
 162:	8082                	ret

0000000000000164 <gets>:

char*
gets(char *buf, int max)
{
 164:	711d                	addi	sp,sp,-96
 166:	ec86                	sd	ra,88(sp)
 168:	e8a2                	sd	s0,80(sp)
 16a:	e4a6                	sd	s1,72(sp)
 16c:	e0ca                	sd	s2,64(sp)
 16e:	fc4e                	sd	s3,56(sp)
 170:	f852                	sd	s4,48(sp)
 172:	f456                	sd	s5,40(sp)
 174:	f05a                	sd	s6,32(sp)
 176:	ec5e                	sd	s7,24(sp)
 178:	e862                	sd	s8,16(sp)
 17a:	1080                	addi	s0,sp,96
 17c:	8baa                	mv	s7,a0
 17e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 180:	892a                	mv	s2,a0
 182:	4481                	li	s1,0
    cc = read(0, &c, 1);
 184:	faf40b13          	addi	s6,s0,-81
 188:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 18a:	8c26                	mv	s8,s1
 18c:	0014899b          	addiw	s3,s1,1
 190:	84ce                	mv	s1,s3
 192:	0349d863          	bge	s3,s4,1c2 <gets+0x5e>
    cc = read(0, &c, 1);
 196:	8656                	mv	a2,s5
 198:	85da                	mv	a1,s6
 19a:	4501                	li	a0,0
 19c:	1c0000ef          	jal	35c <read>
    if(cc < 1)
 1a0:	02a05163          	blez	a0,1c2 <gets+0x5e>
      break;
    buf[i++] = c;
 1a4:	faf44783          	lbu	a5,-81(s0)
 1a8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1ac:	0905                	addi	s2,s2,1
 1ae:	ff678713          	addi	a4,a5,-10
 1b2:	00173713          	seqz	a4,a4
 1b6:	17cd                	addi	a5,a5,-13
 1b8:	0017b793          	seqz	a5,a5
 1bc:	8fd9                	or	a5,a5,a4
 1be:	d7f1                	beqz	a5,18a <gets+0x26>
    buf[i++] = c;
 1c0:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 1c2:	9c5e                	add	s8,s8,s7
 1c4:	000c0023          	sb	zero,0(s8)
  return buf;
}
 1c8:	855e                	mv	a0,s7
 1ca:	60e6                	ld	ra,88(sp)
 1cc:	6446                	ld	s0,80(sp)
 1ce:	64a6                	ld	s1,72(sp)
 1d0:	6906                	ld	s2,64(sp)
 1d2:	79e2                	ld	s3,56(sp)
 1d4:	7a42                	ld	s4,48(sp)
 1d6:	7aa2                	ld	s5,40(sp)
 1d8:	7b02                	ld	s6,32(sp)
 1da:	6be2                	ld	s7,24(sp)
 1dc:	6c42                	ld	s8,16(sp)
 1de:	6125                	addi	sp,sp,96
 1e0:	8082                	ret

00000000000001e2 <stat>:

int
stat(const char *n, struct stat *st)
{
 1e2:	1101                	addi	sp,sp,-32
 1e4:	ec06                	sd	ra,24(sp)
 1e6:	e822                	sd	s0,16(sp)
 1e8:	e04a                	sd	s2,0(sp)
 1ea:	1000                	addi	s0,sp,32
 1ec:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ee:	4581                	li	a1,0
 1f0:	194000ef          	jal	384 <open>
  if(fd < 0)
 1f4:	02054263          	bltz	a0,218 <stat+0x36>
 1f8:	e426                	sd	s1,8(sp)
 1fa:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1fc:	85ca                	mv	a1,s2
 1fe:	19e000ef          	jal	39c <fstat>
 202:	892a                	mv	s2,a0
  close(fd);
 204:	8526                	mv	a0,s1
 206:	166000ef          	jal	36c <close>
  return r;
 20a:	64a2                	ld	s1,8(sp)
}
 20c:	854a                	mv	a0,s2
 20e:	60e2                	ld	ra,24(sp)
 210:	6442                	ld	s0,16(sp)
 212:	6902                	ld	s2,0(sp)
 214:	6105                	addi	sp,sp,32
 216:	8082                	ret
    return -1;
 218:	57fd                	li	a5,-1
 21a:	893e                	mv	s2,a5
 21c:	bfc5                	j	20c <stat+0x2a>

000000000000021e <atoi>:

int
atoi(const char *s)
{
 21e:	1141                	addi	sp,sp,-16
 220:	e406                	sd	ra,8(sp)
 222:	e022                	sd	s0,0(sp)
 224:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 226:	00054683          	lbu	a3,0(a0)
 22a:	fd06879b          	addiw	a5,a3,-48
 22e:	0ff7f793          	zext.b	a5,a5
 232:	4625                	li	a2,9
 234:	02f66963          	bltu	a2,a5,266 <atoi+0x48>
 238:	872a                	mv	a4,a0
  n = 0;
 23a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 23c:	0705                	addi	a4,a4,1
 23e:	0025179b          	slliw	a5,a0,0x2
 242:	9fa9                	addw	a5,a5,a0
 244:	0017979b          	slliw	a5,a5,0x1
 248:	9fb5                	addw	a5,a5,a3
 24a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 24e:	00074683          	lbu	a3,0(a4)
 252:	fd06879b          	addiw	a5,a3,-48
 256:	0ff7f793          	zext.b	a5,a5
 25a:	fef671e3          	bgeu	a2,a5,23c <atoi+0x1e>
  return n;
}
 25e:	60a2                	ld	ra,8(sp)
 260:	6402                	ld	s0,0(sp)
 262:	0141                	addi	sp,sp,16
 264:	8082                	ret
  n = 0;
 266:	4501                	li	a0,0
 268:	bfdd                	j	25e <atoi+0x40>

000000000000026a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 26a:	1141                	addi	sp,sp,-16
 26c:	e406                	sd	ra,8(sp)
 26e:	e022                	sd	s0,0(sp)
 270:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 272:	02b57563          	bgeu	a0,a1,29c <memmove+0x32>
    while(n-- > 0)
 276:	00c05f63          	blez	a2,294 <memmove+0x2a>
 27a:	1602                	slli	a2,a2,0x20
 27c:	9201                	srli	a2,a2,0x20
 27e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 282:	872a                	mv	a4,a0
      *dst++ = *src++;
 284:	0585                	addi	a1,a1,1
 286:	0705                	addi	a4,a4,1
 288:	fff5c683          	lbu	a3,-1(a1)
 28c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 290:	fee79ae3          	bne	a5,a4,284 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 294:	60a2                	ld	ra,8(sp)
 296:	6402                	ld	s0,0(sp)
 298:	0141                	addi	sp,sp,16
 29a:	8082                	ret
    while(n-- > 0)
 29c:	fec05ce3          	blez	a2,294 <memmove+0x2a>
    dst += n;
 2a0:	00c50733          	add	a4,a0,a2
    src += n;
 2a4:	95b2                	add	a1,a1,a2
 2a6:	fff6079b          	addiw	a5,a2,-1
 2aa:	1782                	slli	a5,a5,0x20
 2ac:	9381                	srli	a5,a5,0x20
 2ae:	fff7c793          	not	a5,a5
 2b2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2b4:	15fd                	addi	a1,a1,-1
 2b6:	177d                	addi	a4,a4,-1
 2b8:	0005c683          	lbu	a3,0(a1)
 2bc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2c0:	fef71ae3          	bne	a4,a5,2b4 <memmove+0x4a>
 2c4:	bfc1                	j	294 <memmove+0x2a>

00000000000002c6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e406                	sd	ra,8(sp)
 2ca:	e022                	sd	s0,0(sp)
 2cc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2ce:	ce19                	beqz	a2,2ec <memcmp+0x26>
 2d0:	1602                	slli	a2,a2,0x20
 2d2:	9201                	srli	a2,a2,0x20
 2d4:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 2d8:	00054783          	lbu	a5,0(a0)
 2dc:	0005c703          	lbu	a4,0(a1)
 2e0:	00e79b63          	bne	a5,a4,2f6 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 2e4:	0505                	addi	a0,a0,1
    p2++;
 2e6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2e8:	fed518e3          	bne	a0,a3,2d8 <memcmp+0x12>
  }
  return 0;
 2ec:	4501                	li	a0,0
}
 2ee:	60a2                	ld	ra,8(sp)
 2f0:	6402                	ld	s0,0(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret
      return *p1 - *p2;
 2f6:	40e7853b          	subw	a0,a5,a4
 2fa:	bfd5                	j	2ee <memcmp+0x28>

00000000000002fc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2fc:	1141                	addi	sp,sp,-16
 2fe:	e406                	sd	ra,8(sp)
 300:	e022                	sd	s0,0(sp)
 302:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 304:	f67ff0ef          	jal	26a <memmove>
}
 308:	60a2                	ld	ra,8(sp)
 30a:	6402                	ld	s0,0(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret

0000000000000310 <sbrk>:

char *
sbrk(int n) {
 310:	1141                	addi	sp,sp,-16
 312:	e406                	sd	ra,8(sp)
 314:	e022                	sd	s0,0(sp)
 316:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 318:	4585                	li	a1,1
 31a:	0b2000ef          	jal	3cc <sys_sbrk>
}
 31e:	60a2                	ld	ra,8(sp)
 320:	6402                	ld	s0,0(sp)
 322:	0141                	addi	sp,sp,16
 324:	8082                	ret

0000000000000326 <sbrklazy>:

char *
sbrklazy(int n) {
 326:	1141                	addi	sp,sp,-16
 328:	e406                	sd	ra,8(sp)
 32a:	e022                	sd	s0,0(sp)
 32c:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 32e:	4589                	li	a1,2
 330:	09c000ef          	jal	3cc <sys_sbrk>
}
 334:	60a2                	ld	ra,8(sp)
 336:	6402                	ld	s0,0(sp)
 338:	0141                	addi	sp,sp,16
 33a:	8082                	ret

000000000000033c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 33c:	4885                	li	a7,1
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <exit>:
.global exit
exit:
 li a7, SYS_exit
 344:	4889                	li	a7,2
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <wait>:
.global wait
wait:
 li a7, SYS_wait
 34c:	488d                	li	a7,3
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 354:	4891                	li	a7,4
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <read>:
.global read
read:
 li a7, SYS_read
 35c:	4895                	li	a7,5
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <write>:
.global write
write:
 li a7, SYS_write
 364:	48c1                	li	a7,16
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <close>:
.global close
close:
 li a7, SYS_close
 36c:	48d5                	li	a7,21
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <kill>:
.global kill
kill:
 li a7, SYS_kill
 374:	4899                	li	a7,6
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <exec>:
.global exec
exec:
 li a7, SYS_exec
 37c:	489d                	li	a7,7
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <open>:
.global open
open:
 li a7, SYS_open
 384:	48bd                	li	a7,15
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 38c:	48c5                	li	a7,17
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 394:	48c9                	li	a7,18
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 39c:	48a1                	li	a7,8
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <link>:
.global link
link:
 li a7, SYS_link
 3a4:	48cd                	li	a7,19
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3ac:	48d1                	li	a7,20
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3b4:	48a5                	li	a7,9
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <dup>:
.global dup
dup:
 li a7, SYS_dup
 3bc:	48a9                	li	a7,10
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3c4:	48ad                	li	a7,11
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3cc:	48b1                	li	a7,12
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <pause>:
.global pause
pause:
 li a7, SYS_pause
 3d4:	48b5                	li	a7,13
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3dc:	48b9                	li	a7,14
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3e4:	1101                	addi	sp,sp,-32
 3e6:	ec06                	sd	ra,24(sp)
 3e8:	e822                	sd	s0,16(sp)
 3ea:	1000                	addi	s0,sp,32
 3ec:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3f0:	4605                	li	a2,1
 3f2:	fef40593          	addi	a1,s0,-17
 3f6:	f6fff0ef          	jal	364 <write>
}
 3fa:	60e2                	ld	ra,24(sp)
 3fc:	6442                	ld	s0,16(sp)
 3fe:	6105                	addi	sp,sp,32
 400:	8082                	ret

0000000000000402 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 402:	715d                	addi	sp,sp,-80
 404:	e486                	sd	ra,72(sp)
 406:	e0a2                	sd	s0,64(sp)
 408:	f84a                	sd	s2,48(sp)
 40a:	f44e                	sd	s3,40(sp)
 40c:	0880                	addi	s0,sp,80
 40e:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 410:	00d036b3          	snez	a3,a3
 414:	03f5d793          	srli	a5,a1,0x3f
 418:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 41a:	0005871b          	sext.w	a4,a1
  neg = 0;
 41e:	4301                	li	t1,0
  if(sgn && xx < 0){
 420:	c681                	beqz	a3,428 <printint+0x26>
    x = -xx;
 422:	40b0073b          	negw	a4,a1
    neg = 1;
 426:	4305                	li	t1,1
  }

  i = 0;
 428:	fb840993          	addi	s3,s0,-72
  neg = 0;
 42c:	85ce                	mv	a1,s3
  i = 0;
 42e:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 430:	00000817          	auipc	a6,0x0
 434:	5a080813          	addi	a6,a6,1440 # 9d0 <digits>
 438:	88b6                	mv	a7,a3
 43a:	0016851b          	addiw	a0,a3,1
 43e:	86aa                	mv	a3,a0
 440:	02c777bb          	remuw	a5,a4,a2
 444:	1782                	slli	a5,a5,0x20
 446:	9381                	srli	a5,a5,0x20
 448:	97c2                	add	a5,a5,a6
 44a:	0007c783          	lbu	a5,0(a5)
 44e:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 452:	87ba                	mv	a5,a4
 454:	02c7573b          	divuw	a4,a4,a2
 458:	0585                	addi	a1,a1,1
 45a:	fcc7ffe3          	bgeu	a5,a2,438 <printint+0x36>
  if(neg)
 45e:	00030b63          	beqz	t1,474 <printint+0x72>
    buf[i++] = '-';
 462:	fd040793          	addi	a5,s0,-48
 466:	953e                	add	a0,a0,a5
 468:	02d00793          	li	a5,45
 46c:	fef50423          	sb	a5,-24(a0)
 470:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 474:	02d05563          	blez	a3,49e <printint+0x9c>
 478:	fc26                	sd	s1,56(sp)
 47a:	36fd                	addiw	a3,a3,-1
 47c:	00d984b3          	add	s1,s3,a3
 480:	19fd                	addi	s3,s3,-1
 482:	99b6                	add	s3,s3,a3
 484:	1682                	slli	a3,a3,0x20
 486:	9281                	srli	a3,a3,0x20
 488:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 48c:	0004c583          	lbu	a1,0(s1)
 490:	854a                	mv	a0,s2
 492:	f53ff0ef          	jal	3e4 <putc>
  while(--i >= 0)
 496:	14fd                	addi	s1,s1,-1
 498:	ff349ae3          	bne	s1,s3,48c <printint+0x8a>
 49c:	74e2                	ld	s1,56(sp)
}
 49e:	60a6                	ld	ra,72(sp)
 4a0:	6406                	ld	s0,64(sp)
 4a2:	7942                	ld	s2,48(sp)
 4a4:	79a2                	ld	s3,40(sp)
 4a6:	6161                	addi	sp,sp,80
 4a8:	8082                	ret

00000000000004aa <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4aa:	711d                	addi	sp,sp,-96
 4ac:	ec86                	sd	ra,88(sp)
 4ae:	e8a2                	sd	s0,80(sp)
 4b0:	e4a6                	sd	s1,72(sp)
 4b2:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4b4:	0005c483          	lbu	s1,0(a1)
 4b8:	2a048063          	beqz	s1,758 <vprintf+0x2ae>
 4bc:	e0ca                	sd	s2,64(sp)
 4be:	fc4e                	sd	s3,56(sp)
 4c0:	f852                	sd	s4,48(sp)
 4c2:	f456                	sd	s5,40(sp)
 4c4:	f05a                	sd	s6,32(sp)
 4c6:	ec5e                	sd	s7,24(sp)
 4c8:	e862                	sd	s8,16(sp)
 4ca:	8b2a                	mv	s6,a0
 4cc:	8a2e                	mv	s4,a1
 4ce:	8bb2                	mv	s7,a2
  state = 0;
 4d0:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 4d2:	4901                	li	s2,0
 4d4:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 4d6:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4da:	06400c13          	li	s8,100
 4de:	a00d                	j	500 <vprintf+0x56>
        putc(fd, c0);
 4e0:	85a6                	mv	a1,s1
 4e2:	855a                	mv	a0,s6
 4e4:	f01ff0ef          	jal	3e4 <putc>
 4e8:	a019                	j	4ee <vprintf+0x44>
    } else if(state == '%'){
 4ea:	03598363          	beq	s3,s5,510 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 4ee:	0019079b          	addiw	a5,s2,1
 4f2:	893e                	mv	s2,a5
 4f4:	873e                	mv	a4,a5
 4f6:	97d2                	add	a5,a5,s4
 4f8:	0007c483          	lbu	s1,0(a5)
 4fc:	24048763          	beqz	s1,74a <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 500:	0004879b          	sext.w	a5,s1
    if(state == 0){
 504:	fe0993e3          	bnez	s3,4ea <vprintf+0x40>
      if(c0 == '%'){
 508:	fd579ce3          	bne	a5,s5,4e0 <vprintf+0x36>
        state = '%';
 50c:	89be                	mv	s3,a5
 50e:	b7c5                	j	4ee <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 510:	00ea06b3          	add	a3,s4,a4
 514:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 518:	24060563          	beqz	a2,762 <vprintf+0x2b8>
      if(c0 == 'd'){
 51c:	0b878763          	beq	a5,s8,5ca <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 520:	f9478693          	addi	a3,a5,-108
 524:	0016b693          	seqz	a3,a3
 528:	f9c60593          	addi	a1,a2,-100
 52c:	0015b593          	seqz	a1,a1
 530:	8df5                	and	a1,a1,a3
 532:	e9c5                	bnez	a1,5e2 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 534:	9752                	add	a4,a4,s4
 536:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 53a:	f9460713          	addi	a4,a2,-108
 53e:	00173713          	seqz	a4,a4
 542:	8f75                	and	a4,a4,a3
 544:	f9c50593          	addi	a1,a0,-100
 548:	0015b593          	seqz	a1,a1
 54c:	8df9                	and	a1,a1,a4
 54e:	e5dd                	bnez	a1,5fc <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 550:	07500593          	li	a1,117
 554:	0cb78163          	beq	a5,a1,616 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 558:	f8b60593          	addi	a1,a2,-117
 55c:	0015b593          	seqz	a1,a1
 560:	8df5                	and	a1,a1,a3
 562:	e5f1                	bnez	a1,62e <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 564:	f8b50593          	addi	a1,a0,-117
 568:	0015b593          	seqz	a1,a1
 56c:	8df9                	and	a1,a1,a4
 56e:	ede9                	bnez	a1,648 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 570:	07800593          	li	a1,120
 574:	0eb78763          	beq	a5,a1,662 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 578:	f8860613          	addi	a2,a2,-120
 57c:	00163613          	seqz	a2,a2
 580:	8ef1                	and	a3,a3,a2
 582:	0e069c63          	bnez	a3,67a <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 586:	f8850513          	addi	a0,a0,-120
 58a:	00153513          	seqz	a0,a0
 58e:	8f69                	and	a4,a4,a0
 590:	10071263          	bnez	a4,694 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 594:	07000713          	li	a4,112
 598:	10e78a63          	beq	a5,a4,6ac <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 59c:	06300713          	li	a4,99
 5a0:	14e78a63          	beq	a5,a4,6f4 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5a4:	07300713          	li	a4,115
 5a8:	16e78063          	beq	a5,a4,708 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5ac:	02500713          	li	a4,37
 5b0:	18e78863          	beq	a5,a4,740 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5b4:	02500593          	li	a1,37
 5b8:	855a                	mv	a0,s6
 5ba:	e2bff0ef          	jal	3e4 <putc>
        putc(fd, c0);
 5be:	85a6                	mv	a1,s1
 5c0:	855a                	mv	a0,s6
 5c2:	e23ff0ef          	jal	3e4 <putc>
      }

      state = 0;
 5c6:	4981                	li	s3,0
 5c8:	b71d                	j	4ee <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 5ca:	008b8493          	addi	s1,s7,8
 5ce:	4685                	li	a3,1
 5d0:	4629                	li	a2,10
 5d2:	000ba583          	lw	a1,0(s7)
 5d6:	855a                	mv	a0,s6
 5d8:	e2bff0ef          	jal	402 <printint>
 5dc:	8ba6                	mv	s7,s1
      state = 0;
 5de:	4981                	li	s3,0
 5e0:	b739                	j	4ee <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5e2:	008b8493          	addi	s1,s7,8
 5e6:	4685                	li	a3,1
 5e8:	4629                	li	a2,10
 5ea:	000bb583          	ld	a1,0(s7)
 5ee:	855a                	mv	a0,s6
 5f0:	e13ff0ef          	jal	402 <printint>
        i += 1;
 5f4:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5f6:	8ba6                	mv	s7,s1
      state = 0;
 5f8:	4981                	li	s3,0
 5fa:	bdd5                	j	4ee <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5fc:	008b8493          	addi	s1,s7,8
 600:	4685                	li	a3,1
 602:	4629                	li	a2,10
 604:	000bb583          	ld	a1,0(s7)
 608:	855a                	mv	a0,s6
 60a:	df9ff0ef          	jal	402 <printint>
        i += 2;
 60e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 610:	8ba6                	mv	s7,s1
      state = 0;
 612:	4981                	li	s3,0
        i += 2;
 614:	bde9                	j	4ee <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 616:	008b8493          	addi	s1,s7,8
 61a:	4681                	li	a3,0
 61c:	4629                	li	a2,10
 61e:	000be583          	lwu	a1,0(s7)
 622:	855a                	mv	a0,s6
 624:	ddfff0ef          	jal	402 <printint>
 628:	8ba6                	mv	s7,s1
      state = 0;
 62a:	4981                	li	s3,0
 62c:	b5c9                	j	4ee <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 62e:	008b8493          	addi	s1,s7,8
 632:	4681                	li	a3,0
 634:	4629                	li	a2,10
 636:	000bb583          	ld	a1,0(s7)
 63a:	855a                	mv	a0,s6
 63c:	dc7ff0ef          	jal	402 <printint>
        i += 1;
 640:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 642:	8ba6                	mv	s7,s1
      state = 0;
 644:	4981                	li	s3,0
 646:	b565                	j	4ee <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 648:	008b8493          	addi	s1,s7,8
 64c:	4681                	li	a3,0
 64e:	4629                	li	a2,10
 650:	000bb583          	ld	a1,0(s7)
 654:	855a                	mv	a0,s6
 656:	dadff0ef          	jal	402 <printint>
        i += 2;
 65a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 65c:	8ba6                	mv	s7,s1
      state = 0;
 65e:	4981                	li	s3,0
        i += 2;
 660:	b579                	j	4ee <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 662:	008b8493          	addi	s1,s7,8
 666:	4681                	li	a3,0
 668:	4641                	li	a2,16
 66a:	000be583          	lwu	a1,0(s7)
 66e:	855a                	mv	a0,s6
 670:	d93ff0ef          	jal	402 <printint>
 674:	8ba6                	mv	s7,s1
      state = 0;
 676:	4981                	li	s3,0
 678:	bd9d                	j	4ee <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 67a:	008b8493          	addi	s1,s7,8
 67e:	4681                	li	a3,0
 680:	4641                	li	a2,16
 682:	000bb583          	ld	a1,0(s7)
 686:	855a                	mv	a0,s6
 688:	d7bff0ef          	jal	402 <printint>
        i += 1;
 68c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 68e:	8ba6                	mv	s7,s1
      state = 0;
 690:	4981                	li	s3,0
 692:	bdb1                	j	4ee <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 694:	008b8493          	addi	s1,s7,8
 698:	4641                	li	a2,16
 69a:	000bb583          	ld	a1,0(s7)
 69e:	855a                	mv	a0,s6
 6a0:	d63ff0ef          	jal	402 <printint>
        i += 2;
 6a4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6a6:	8ba6                	mv	s7,s1
      state = 0;
 6a8:	4981                	li	s3,0
        i += 2;
 6aa:	b591                	j	4ee <vprintf+0x44>
 6ac:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 6ae:	008b8793          	addi	a5,s7,8
 6b2:	8cbe                	mv	s9,a5
 6b4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6b8:	03000593          	li	a1,48
 6bc:	855a                	mv	a0,s6
 6be:	d27ff0ef          	jal	3e4 <putc>
  putc(fd, 'x');
 6c2:	07800593          	li	a1,120
 6c6:	855a                	mv	a0,s6
 6c8:	d1dff0ef          	jal	3e4 <putc>
 6cc:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6ce:	00000b97          	auipc	s7,0x0
 6d2:	302b8b93          	addi	s7,s7,770 # 9d0 <digits>
 6d6:	03c9d793          	srli	a5,s3,0x3c
 6da:	97de                	add	a5,a5,s7
 6dc:	0007c583          	lbu	a1,0(a5)
 6e0:	855a                	mv	a0,s6
 6e2:	d03ff0ef          	jal	3e4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6e6:	0992                	slli	s3,s3,0x4
 6e8:	34fd                	addiw	s1,s1,-1
 6ea:	f4f5                	bnez	s1,6d6 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 6ec:	8be6                	mv	s7,s9
      state = 0;
 6ee:	4981                	li	s3,0
 6f0:	6ca2                	ld	s9,8(sp)
 6f2:	bbf5                	j	4ee <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 6f4:	008b8493          	addi	s1,s7,8
 6f8:	000bc583          	lbu	a1,0(s7)
 6fc:	855a                	mv	a0,s6
 6fe:	ce7ff0ef          	jal	3e4 <putc>
 702:	8ba6                	mv	s7,s1
      state = 0;
 704:	4981                	li	s3,0
 706:	b3e5                	j	4ee <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 708:	008b8993          	addi	s3,s7,8
 70c:	000bb483          	ld	s1,0(s7)
 710:	cc91                	beqz	s1,72c <vprintf+0x282>
        for(; *s; s++)
 712:	0004c583          	lbu	a1,0(s1)
 716:	c195                	beqz	a1,73a <vprintf+0x290>
          putc(fd, *s);
 718:	855a                	mv	a0,s6
 71a:	ccbff0ef          	jal	3e4 <putc>
        for(; *s; s++)
 71e:	0485                	addi	s1,s1,1
 720:	0004c583          	lbu	a1,0(s1)
 724:	f9f5                	bnez	a1,718 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 726:	8bce                	mv	s7,s3
      state = 0;
 728:	4981                	li	s3,0
 72a:	b3d1                	j	4ee <vprintf+0x44>
          s = "(null)";
 72c:	00000497          	auipc	s1,0x0
 730:	29c48493          	addi	s1,s1,668 # 9c8 <malloc+0x16a>
        for(; *s; s++)
 734:	02800593          	li	a1,40
 738:	b7c5                	j	718 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 73a:	8bce                	mv	s7,s3
      state = 0;
 73c:	4981                	li	s3,0
 73e:	bb45                	j	4ee <vprintf+0x44>
        putc(fd, '%');
 740:	85be                	mv	a1,a5
 742:	855a                	mv	a0,s6
 744:	ca1ff0ef          	jal	3e4 <putc>
 748:	bdbd                	j	5c6 <vprintf+0x11c>
 74a:	6906                	ld	s2,64(sp)
 74c:	79e2                	ld	s3,56(sp)
 74e:	7a42                	ld	s4,48(sp)
 750:	7aa2                	ld	s5,40(sp)
 752:	7b02                	ld	s6,32(sp)
 754:	6be2                	ld	s7,24(sp)
 756:	6c42                	ld	s8,16(sp)
    }
  }
}
 758:	60e6                	ld	ra,88(sp)
 75a:	6446                	ld	s0,80(sp)
 75c:	64a6                	ld	s1,72(sp)
 75e:	6125                	addi	sp,sp,96
 760:	8082                	ret
      if(c0 == 'd'){
 762:	06400713          	li	a4,100
 766:	e6e782e3          	beq	a5,a4,5ca <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 76a:	f9478693          	addi	a3,a5,-108
 76e:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 772:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 774:	4701                	li	a4,0
 776:	bbe9                	j	550 <vprintf+0xa6>

0000000000000778 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 778:	715d                	addi	sp,sp,-80
 77a:	ec06                	sd	ra,24(sp)
 77c:	e822                	sd	s0,16(sp)
 77e:	1000                	addi	s0,sp,32
 780:	e010                	sd	a2,0(s0)
 782:	e414                	sd	a3,8(s0)
 784:	e818                	sd	a4,16(s0)
 786:	ec1c                	sd	a5,24(s0)
 788:	03043023          	sd	a6,32(s0)
 78c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 790:	8622                	mv	a2,s0
 792:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 796:	d15ff0ef          	jal	4aa <vprintf>
}
 79a:	60e2                	ld	ra,24(sp)
 79c:	6442                	ld	s0,16(sp)
 79e:	6161                	addi	sp,sp,80
 7a0:	8082                	ret

00000000000007a2 <printf>:

void
printf(const char *fmt, ...)
{
 7a2:	711d                	addi	sp,sp,-96
 7a4:	ec06                	sd	ra,24(sp)
 7a6:	e822                	sd	s0,16(sp)
 7a8:	1000                	addi	s0,sp,32
 7aa:	e40c                	sd	a1,8(s0)
 7ac:	e810                	sd	a2,16(s0)
 7ae:	ec14                	sd	a3,24(s0)
 7b0:	f018                	sd	a4,32(s0)
 7b2:	f41c                	sd	a5,40(s0)
 7b4:	03043823          	sd	a6,48(s0)
 7b8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7bc:	00840613          	addi	a2,s0,8
 7c0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7c4:	85aa                	mv	a1,a0
 7c6:	4505                	li	a0,1
 7c8:	ce3ff0ef          	jal	4aa <vprintf>
}
 7cc:	60e2                	ld	ra,24(sp)
 7ce:	6442                	ld	s0,16(sp)
 7d0:	6125                	addi	sp,sp,96
 7d2:	8082                	ret

00000000000007d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7d4:	1141                	addi	sp,sp,-16
 7d6:	e406                	sd	ra,8(sp)
 7d8:	e022                	sd	s0,0(sp)
 7da:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7dc:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e0:	00001797          	auipc	a5,0x1
 7e4:	8207b783          	ld	a5,-2016(a5) # 1000 <freep>
 7e8:	a095                	j	84c <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7ea:	ff852583          	lw	a1,-8(a0)
 7ee:	6390                	ld	a2,0(a5)
 7f0:	02059813          	slli	a6,a1,0x20
 7f4:	01c85693          	srli	a3,a6,0x1c
 7f8:	96ba                	add	a3,a3,a4
 7fa:	02d60563          	beq	a2,a3,824 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7fe:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 802:	4790                	lw	a2,8(a5)
 804:	02061593          	slli	a1,a2,0x20
 808:	01c5d693          	srli	a3,a1,0x1c
 80c:	96be                	add	a3,a3,a5
 80e:	02d70263          	beq	a4,a3,832 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 812:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 814:	00000717          	auipc	a4,0x0
 818:	7ef73623          	sd	a5,2028(a4) # 1000 <freep>
}
 81c:	60a2                	ld	ra,8(sp)
 81e:	6402                	ld	s0,0(sp)
 820:	0141                	addi	sp,sp,16
 822:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 824:	4614                	lw	a3,8(a2)
 826:	9ead                	addw	a3,a3,a1
 828:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 82c:	6394                	ld	a3,0(a5)
 82e:	6290                	ld	a2,0(a3)
 830:	b7f9                	j	7fe <free+0x2a>
    p->s.size += bp->s.size;
 832:	ff852703          	lw	a4,-8(a0)
 836:	9f31                	addw	a4,a4,a2
 838:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 83a:	ff053703          	ld	a4,-16(a0)
 83e:	bfd1                	j	812 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 840:	6394                	ld	a3,0(a5)
 842:	00d7e463          	bltu	a5,a3,84a <free+0x76>
 846:	fad762e3          	bltu	a4,a3,7ea <free+0x16>
 84a:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 84c:	fee7fae3          	bgeu	a5,a4,840 <free+0x6c>
 850:	6394                	ld	a3,0(a5)
 852:	f8d76ce3          	bltu	a4,a3,7ea <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 856:	f8d7fae3          	bgeu	a5,a3,7ea <free+0x16>
 85a:	87b6                	mv	a5,a3
 85c:	bfc5                	j	84c <free+0x78>

000000000000085e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 85e:	7139                	addi	sp,sp,-64
 860:	fc06                	sd	ra,56(sp)
 862:	f822                	sd	s0,48(sp)
 864:	f04a                	sd	s2,32(sp)
 866:	ec4e                	sd	s3,24(sp)
 868:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 86a:	02051993          	slli	s3,a0,0x20
 86e:	0209d993          	srli	s3,s3,0x20
 872:	09bd                	addi	s3,s3,15
 874:	0049d993          	srli	s3,s3,0x4
 878:	2985                	addiw	s3,s3,1
 87a:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 87c:	00000517          	auipc	a0,0x0
 880:	78453503          	ld	a0,1924(a0) # 1000 <freep>
 884:	c905                	beqz	a0,8b4 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 886:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 888:	4798                	lw	a4,8(a5)
 88a:	09377663          	bgeu	a4,s3,916 <malloc+0xb8>
 88e:	f426                	sd	s1,40(sp)
 890:	e852                	sd	s4,16(sp)
 892:	e456                	sd	s5,8(sp)
 894:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 896:	8a4e                	mv	s4,s3
 898:	6705                	lui	a4,0x1
 89a:	00e9f363          	bgeu	s3,a4,8a0 <malloc+0x42>
 89e:	6a05                	lui	s4,0x1
 8a0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8a4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8a8:	00000497          	auipc	s1,0x0
 8ac:	75848493          	addi	s1,s1,1880 # 1000 <freep>
  if(p == SBRK_ERROR)
 8b0:	5afd                	li	s5,-1
 8b2:	a83d                	j	8f0 <malloc+0x92>
 8b4:	f426                	sd	s1,40(sp)
 8b6:	e852                	sd	s4,16(sp)
 8b8:	e456                	sd	s5,8(sp)
 8ba:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8bc:	00001797          	auipc	a5,0x1
 8c0:	94c78793          	addi	a5,a5,-1716 # 1208 <base>
 8c4:	00000717          	auipc	a4,0x0
 8c8:	72f73e23          	sd	a5,1852(a4) # 1000 <freep>
 8cc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8ce:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8d2:	b7d1                	j	896 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8d4:	6398                	ld	a4,0(a5)
 8d6:	e118                	sd	a4,0(a0)
 8d8:	a899                	j	92e <malloc+0xd0>
  hp->s.size = nu;
 8da:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8de:	0541                	addi	a0,a0,16
 8e0:	ef5ff0ef          	jal	7d4 <free>
  return freep;
 8e4:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8e6:	c125                	beqz	a0,946 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ea:	4798                	lw	a4,8(a5)
 8ec:	03277163          	bgeu	a4,s2,90e <malloc+0xb0>
    if(p == freep)
 8f0:	6098                	ld	a4,0(s1)
 8f2:	853e                	mv	a0,a5
 8f4:	fef71ae3          	bne	a4,a5,8e8 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 8f8:	8552                	mv	a0,s4
 8fa:	a17ff0ef          	jal	310 <sbrk>
  if(p == SBRK_ERROR)
 8fe:	fd551ee3          	bne	a0,s5,8da <malloc+0x7c>
        return 0;
 902:	4501                	li	a0,0
 904:	74a2                	ld	s1,40(sp)
 906:	6a42                	ld	s4,16(sp)
 908:	6aa2                	ld	s5,8(sp)
 90a:	6b02                	ld	s6,0(sp)
 90c:	a03d                	j	93a <malloc+0xdc>
 90e:	74a2                	ld	s1,40(sp)
 910:	6a42                	ld	s4,16(sp)
 912:	6aa2                	ld	s5,8(sp)
 914:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 916:	fae90fe3          	beq	s2,a4,8d4 <malloc+0x76>
        p->s.size -= nunits;
 91a:	4137073b          	subw	a4,a4,s3
 91e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 920:	02071693          	slli	a3,a4,0x20
 924:	01c6d713          	srli	a4,a3,0x1c
 928:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 92a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 92e:	00000717          	auipc	a4,0x0
 932:	6ca73923          	sd	a0,1746(a4) # 1000 <freep>
      return (void*)(p + 1);
 936:	01078513          	addi	a0,a5,16
  }
}
 93a:	70e2                	ld	ra,56(sp)
 93c:	7442                	ld	s0,48(sp)
 93e:	7902                	ld	s2,32(sp)
 940:	69e2                	ld	s3,24(sp)
 942:	6121                	addi	sp,sp,64
 944:	8082                	ret
 946:	74a2                	ld	s1,40(sp)
 948:	6a42                	ld	s4,16(sp)
 94a:	6aa2                	ld	s5,8(sp)
 94c:	6b02                	ld	s6,0(sp)
 94e:	b7f5                	j	93a <malloc+0xdc>
