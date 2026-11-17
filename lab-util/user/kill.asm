
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	02a7d963          	bge	a5,a0,3c <main+0x3c>
   e:	e426                	sd	s1,8(sp)
  10:	e04a                	sd	s2,0(sp)
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	02091793          	slli	a5,s2,0x20
  1e:	01d7d913          	srli	s2,a5,0x1d
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	1be000ef          	jal	1e6 <atoi>
  2c:	310000ef          	jal	33c <kill>
  for(i=1; i<argc; i++)
  30:	04a1                	addi	s1,s1,8
  32:	ff249ae3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  36:	4501                	li	a0,0
  38:	2d4000ef          	jal	30c <exit>
  3c:	e426                	sd	s1,8(sp)
  3e:	e04a                	sd	s2,0(sp)
    fprintf(2, "usage: kill pid...\n");
  40:	00001597          	auipc	a1,0x1
  44:	8e058593          	addi	a1,a1,-1824 # 920 <malloc+0xfa>
  48:	4509                	li	a0,2
  4a:	6f6000ef          	jal	740 <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	2bc000ef          	jal	30c <exit>

0000000000000054 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  extern int main();
  main();
  5c:	fa5ff0ef          	jal	0 <main>
  exit(0);
  60:	4501                	li	a0,0
  62:	2aa000ef          	jal	30c <exit>

0000000000000066 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  66:	1141                	addi	sp,sp,-16
  68:	e406                	sd	ra,8(sp)
  6a:	e022                	sd	s0,0(sp)
  6c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6e:	87aa                	mv	a5,a0
  70:	0585                	addi	a1,a1,1
  72:	0785                	addi	a5,a5,1
  74:	fff5c703          	lbu	a4,-1(a1)
  78:	fee78fa3          	sb	a4,-1(a5)
  7c:	fb75                	bnez	a4,70 <strcpy+0xa>
    ;
  return os;
}
  7e:	60a2                	ld	ra,8(sp)
  80:	6402                	ld	s0,0(sp)
  82:	0141                	addi	sp,sp,16
  84:	8082                	ret

0000000000000086 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  86:	1141                	addi	sp,sp,-16
  88:	e406                	sd	ra,8(sp)
  8a:	e022                	sd	s0,0(sp)
  8c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  8e:	00054783          	lbu	a5,0(a0)
  92:	cb91                	beqz	a5,a6 <strcmp+0x20>
  94:	0005c703          	lbu	a4,0(a1)
  98:	00f71763          	bne	a4,a5,a6 <strcmp+0x20>
    p++, q++;
  9c:	0505                	addi	a0,a0,1
  9e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  a0:	00054783          	lbu	a5,0(a0)
  a4:	fbe5                	bnez	a5,94 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  a6:	0005c503          	lbu	a0,0(a1)
}
  aa:	40a7853b          	subw	a0,a5,a0
  ae:	60a2                	ld	ra,8(sp)
  b0:	6402                	ld	s0,0(sp)
  b2:	0141                	addi	sp,sp,16
  b4:	8082                	ret

00000000000000b6 <strlen>:

uint
strlen(const char *s)
{
  b6:	1141                	addi	sp,sp,-16
  b8:	e406                	sd	ra,8(sp)
  ba:	e022                	sd	s0,0(sp)
  bc:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  be:	00054783          	lbu	a5,0(a0)
  c2:	cf91                	beqz	a5,de <strlen+0x28>
  c4:	00150793          	addi	a5,a0,1
  c8:	86be                	mv	a3,a5
  ca:	0785                	addi	a5,a5,1
  cc:	fff7c703          	lbu	a4,-1(a5)
  d0:	ff65                	bnez	a4,c8 <strlen+0x12>
  d2:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  d6:	60a2                	ld	ra,8(sp)
  d8:	6402                	ld	s0,0(sp)
  da:	0141                	addi	sp,sp,16
  dc:	8082                	ret
  for(n = 0; s[n]; n++)
  de:	4501                	li	a0,0
  e0:	bfdd                	j	d6 <strlen+0x20>

00000000000000e2 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e2:	1141                	addi	sp,sp,-16
  e4:	e406                	sd	ra,8(sp)
  e6:	e022                	sd	s0,0(sp)
  e8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  ea:	ca19                	beqz	a2,100 <memset+0x1e>
  ec:	87aa                	mv	a5,a0
  ee:	1602                	slli	a2,a2,0x20
  f0:	9201                	srli	a2,a2,0x20
  f2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  f6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  fa:	0785                	addi	a5,a5,1
  fc:	fee79de3          	bne	a5,a4,f6 <memset+0x14>
  }
  return dst;
}
 100:	60a2                	ld	ra,8(sp)
 102:	6402                	ld	s0,0(sp)
 104:	0141                	addi	sp,sp,16
 106:	8082                	ret

0000000000000108 <strchr>:

char*
strchr(const char *s, char c)
{
 108:	1141                	addi	sp,sp,-16
 10a:	e406                	sd	ra,8(sp)
 10c:	e022                	sd	s0,0(sp)
 10e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 110:	00054783          	lbu	a5,0(a0)
 114:	c799                	beqz	a5,122 <strchr+0x1a>
    if(*s == c)
 116:	00f58763          	beq	a1,a5,124 <strchr+0x1c>
  for(; *s; s++)
 11a:	0505                	addi	a0,a0,1
 11c:	00054783          	lbu	a5,0(a0)
 120:	fbfd                	bnez	a5,116 <strchr+0xe>
      return (char*)s;
  return 0;
 122:	4501                	li	a0,0
}
 124:	60a2                	ld	ra,8(sp)
 126:	6402                	ld	s0,0(sp)
 128:	0141                	addi	sp,sp,16
 12a:	8082                	ret

000000000000012c <gets>:

char*
gets(char *buf, int max)
{
 12c:	711d                	addi	sp,sp,-96
 12e:	ec86                	sd	ra,88(sp)
 130:	e8a2                	sd	s0,80(sp)
 132:	e4a6                	sd	s1,72(sp)
 134:	e0ca                	sd	s2,64(sp)
 136:	fc4e                	sd	s3,56(sp)
 138:	f852                	sd	s4,48(sp)
 13a:	f456                	sd	s5,40(sp)
 13c:	f05a                	sd	s6,32(sp)
 13e:	ec5e                	sd	s7,24(sp)
 140:	e862                	sd	s8,16(sp)
 142:	1080                	addi	s0,sp,96
 144:	8baa                	mv	s7,a0
 146:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 148:	892a                	mv	s2,a0
 14a:	4481                	li	s1,0
    cc = read(0, &c, 1);
 14c:	faf40b13          	addi	s6,s0,-81
 150:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 152:	8c26                	mv	s8,s1
 154:	0014899b          	addiw	s3,s1,1
 158:	84ce                	mv	s1,s3
 15a:	0349d863          	bge	s3,s4,18a <gets+0x5e>
    cc = read(0, &c, 1);
 15e:	8656                	mv	a2,s5
 160:	85da                	mv	a1,s6
 162:	4501                	li	a0,0
 164:	1c0000ef          	jal	324 <read>
    if(cc < 1)
 168:	02a05163          	blez	a0,18a <gets+0x5e>
      break;
    buf[i++] = c;
 16c:	faf44783          	lbu	a5,-81(s0)
 170:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 174:	0905                	addi	s2,s2,1
 176:	ff678713          	addi	a4,a5,-10
 17a:	00173713          	seqz	a4,a4
 17e:	17cd                	addi	a5,a5,-13
 180:	0017b793          	seqz	a5,a5
 184:	8fd9                	or	a5,a5,a4
 186:	d7f1                	beqz	a5,152 <gets+0x26>
    buf[i++] = c;
 188:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 18a:	9c5e                	add	s8,s8,s7
 18c:	000c0023          	sb	zero,0(s8)
  return buf;
}
 190:	855e                	mv	a0,s7
 192:	60e6                	ld	ra,88(sp)
 194:	6446                	ld	s0,80(sp)
 196:	64a6                	ld	s1,72(sp)
 198:	6906                	ld	s2,64(sp)
 19a:	79e2                	ld	s3,56(sp)
 19c:	7a42                	ld	s4,48(sp)
 19e:	7aa2                	ld	s5,40(sp)
 1a0:	7b02                	ld	s6,32(sp)
 1a2:	6be2                	ld	s7,24(sp)
 1a4:	6c42                	ld	s8,16(sp)
 1a6:	6125                	addi	sp,sp,96
 1a8:	8082                	ret

00000000000001aa <stat>:

int
stat(const char *n, struct stat *st)
{
 1aa:	1101                	addi	sp,sp,-32
 1ac:	ec06                	sd	ra,24(sp)
 1ae:	e822                	sd	s0,16(sp)
 1b0:	e04a                	sd	s2,0(sp)
 1b2:	1000                	addi	s0,sp,32
 1b4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b6:	4581                	li	a1,0
 1b8:	194000ef          	jal	34c <open>
  if(fd < 0)
 1bc:	02054263          	bltz	a0,1e0 <stat+0x36>
 1c0:	e426                	sd	s1,8(sp)
 1c2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1c4:	85ca                	mv	a1,s2
 1c6:	19e000ef          	jal	364 <fstat>
 1ca:	892a                	mv	s2,a0
  close(fd);
 1cc:	8526                	mv	a0,s1
 1ce:	166000ef          	jal	334 <close>
  return r;
 1d2:	64a2                	ld	s1,8(sp)
}
 1d4:	854a                	mv	a0,s2
 1d6:	60e2                	ld	ra,24(sp)
 1d8:	6442                	ld	s0,16(sp)
 1da:	6902                	ld	s2,0(sp)
 1dc:	6105                	addi	sp,sp,32
 1de:	8082                	ret
    return -1;
 1e0:	57fd                	li	a5,-1
 1e2:	893e                	mv	s2,a5
 1e4:	bfc5                	j	1d4 <stat+0x2a>

00000000000001e6 <atoi>:

int
atoi(const char *s)
{
 1e6:	1141                	addi	sp,sp,-16
 1e8:	e406                	sd	ra,8(sp)
 1ea:	e022                	sd	s0,0(sp)
 1ec:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ee:	00054683          	lbu	a3,0(a0)
 1f2:	fd06879b          	addiw	a5,a3,-48
 1f6:	0ff7f793          	zext.b	a5,a5
 1fa:	4625                	li	a2,9
 1fc:	02f66963          	bltu	a2,a5,22e <atoi+0x48>
 200:	872a                	mv	a4,a0
  n = 0;
 202:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 204:	0705                	addi	a4,a4,1
 206:	0025179b          	slliw	a5,a0,0x2
 20a:	9fa9                	addw	a5,a5,a0
 20c:	0017979b          	slliw	a5,a5,0x1
 210:	9fb5                	addw	a5,a5,a3
 212:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 216:	00074683          	lbu	a3,0(a4)
 21a:	fd06879b          	addiw	a5,a3,-48
 21e:	0ff7f793          	zext.b	a5,a5
 222:	fef671e3          	bgeu	a2,a5,204 <atoi+0x1e>
  return n;
}
 226:	60a2                	ld	ra,8(sp)
 228:	6402                	ld	s0,0(sp)
 22a:	0141                	addi	sp,sp,16
 22c:	8082                	ret
  n = 0;
 22e:	4501                	li	a0,0
 230:	bfdd                	j	226 <atoi+0x40>

0000000000000232 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 232:	1141                	addi	sp,sp,-16
 234:	e406                	sd	ra,8(sp)
 236:	e022                	sd	s0,0(sp)
 238:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 23a:	02b57563          	bgeu	a0,a1,264 <memmove+0x32>
    while(n-- > 0)
 23e:	00c05f63          	blez	a2,25c <memmove+0x2a>
 242:	1602                	slli	a2,a2,0x20
 244:	9201                	srli	a2,a2,0x20
 246:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 24a:	872a                	mv	a4,a0
      *dst++ = *src++;
 24c:	0585                	addi	a1,a1,1
 24e:	0705                	addi	a4,a4,1
 250:	fff5c683          	lbu	a3,-1(a1)
 254:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 258:	fee79ae3          	bne	a5,a4,24c <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 25c:	60a2                	ld	ra,8(sp)
 25e:	6402                	ld	s0,0(sp)
 260:	0141                	addi	sp,sp,16
 262:	8082                	ret
    while(n-- > 0)
 264:	fec05ce3          	blez	a2,25c <memmove+0x2a>
    dst += n;
 268:	00c50733          	add	a4,a0,a2
    src += n;
 26c:	95b2                	add	a1,a1,a2
 26e:	fff6079b          	addiw	a5,a2,-1
 272:	1782                	slli	a5,a5,0x20
 274:	9381                	srli	a5,a5,0x20
 276:	fff7c793          	not	a5,a5
 27a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 27c:	15fd                	addi	a1,a1,-1
 27e:	177d                	addi	a4,a4,-1
 280:	0005c683          	lbu	a3,0(a1)
 284:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 288:	fef71ae3          	bne	a4,a5,27c <memmove+0x4a>
 28c:	bfc1                	j	25c <memmove+0x2a>

000000000000028e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 28e:	1141                	addi	sp,sp,-16
 290:	e406                	sd	ra,8(sp)
 292:	e022                	sd	s0,0(sp)
 294:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 296:	ce19                	beqz	a2,2b4 <memcmp+0x26>
 298:	1602                	slli	a2,a2,0x20
 29a:	9201                	srli	a2,a2,0x20
 29c:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 2a0:	00054783          	lbu	a5,0(a0)
 2a4:	0005c703          	lbu	a4,0(a1)
 2a8:	00e79b63          	bne	a5,a4,2be <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 2ac:	0505                	addi	a0,a0,1
    p2++;
 2ae:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2b0:	fed518e3          	bne	a0,a3,2a0 <memcmp+0x12>
  }
  return 0;
 2b4:	4501                	li	a0,0
}
 2b6:	60a2                	ld	ra,8(sp)
 2b8:	6402                	ld	s0,0(sp)
 2ba:	0141                	addi	sp,sp,16
 2bc:	8082                	ret
      return *p1 - *p2;
 2be:	40e7853b          	subw	a0,a5,a4
 2c2:	bfd5                	j	2b6 <memcmp+0x28>

00000000000002c4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2c4:	1141                	addi	sp,sp,-16
 2c6:	e406                	sd	ra,8(sp)
 2c8:	e022                	sd	s0,0(sp)
 2ca:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2cc:	f67ff0ef          	jal	232 <memmove>
}
 2d0:	60a2                	ld	ra,8(sp)
 2d2:	6402                	ld	s0,0(sp)
 2d4:	0141                	addi	sp,sp,16
 2d6:	8082                	ret

00000000000002d8 <sbrk>:

char *
sbrk(int n) {
 2d8:	1141                	addi	sp,sp,-16
 2da:	e406                	sd	ra,8(sp)
 2dc:	e022                	sd	s0,0(sp)
 2de:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2e0:	4585                	li	a1,1
 2e2:	0b2000ef          	jal	394 <sys_sbrk>
}
 2e6:	60a2                	ld	ra,8(sp)
 2e8:	6402                	ld	s0,0(sp)
 2ea:	0141                	addi	sp,sp,16
 2ec:	8082                	ret

00000000000002ee <sbrklazy>:

char *
sbrklazy(int n) {
 2ee:	1141                	addi	sp,sp,-16
 2f0:	e406                	sd	ra,8(sp)
 2f2:	e022                	sd	s0,0(sp)
 2f4:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 2f6:	4589                	li	a1,2
 2f8:	09c000ef          	jal	394 <sys_sbrk>
}
 2fc:	60a2                	ld	ra,8(sp)
 2fe:	6402                	ld	s0,0(sp)
 300:	0141                	addi	sp,sp,16
 302:	8082                	ret

0000000000000304 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 304:	4885                	li	a7,1
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <exit>:
.global exit
exit:
 li a7, SYS_exit
 30c:	4889                	li	a7,2
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <wait>:
.global wait
wait:
 li a7, SYS_wait
 314:	488d                	li	a7,3
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 31c:	4891                	li	a7,4
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <read>:
.global read
read:
 li a7, SYS_read
 324:	4895                	li	a7,5
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <write>:
.global write
write:
 li a7, SYS_write
 32c:	48c1                	li	a7,16
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <close>:
.global close
close:
 li a7, SYS_close
 334:	48d5                	li	a7,21
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <kill>:
.global kill
kill:
 li a7, SYS_kill
 33c:	4899                	li	a7,6
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <exec>:
.global exec
exec:
 li a7, SYS_exec
 344:	489d                	li	a7,7
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <open>:
.global open
open:
 li a7, SYS_open
 34c:	48bd                	li	a7,15
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 354:	48c5                	li	a7,17
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 35c:	48c9                	li	a7,18
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 364:	48a1                	li	a7,8
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <link>:
.global link
link:
 li a7, SYS_link
 36c:	48cd                	li	a7,19
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 374:	48d1                	li	a7,20
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 37c:	48a5                	li	a7,9
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <dup>:
.global dup
dup:
 li a7, SYS_dup
 384:	48a9                	li	a7,10
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 38c:	48ad                	li	a7,11
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 394:	48b1                	li	a7,12
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <pause>:
.global pause
pause:
 li a7, SYS_pause
 39c:	48b5                	li	a7,13
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3a4:	48b9                	li	a7,14
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3ac:	1101                	addi	sp,sp,-32
 3ae:	ec06                	sd	ra,24(sp)
 3b0:	e822                	sd	s0,16(sp)
 3b2:	1000                	addi	s0,sp,32
 3b4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3b8:	4605                	li	a2,1
 3ba:	fef40593          	addi	a1,s0,-17
 3be:	f6fff0ef          	jal	32c <write>
}
 3c2:	60e2                	ld	ra,24(sp)
 3c4:	6442                	ld	s0,16(sp)
 3c6:	6105                	addi	sp,sp,32
 3c8:	8082                	ret

00000000000003ca <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 3ca:	715d                	addi	sp,sp,-80
 3cc:	e486                	sd	ra,72(sp)
 3ce:	e0a2                	sd	s0,64(sp)
 3d0:	f84a                	sd	s2,48(sp)
 3d2:	f44e                	sd	s3,40(sp)
 3d4:	0880                	addi	s0,sp,80
 3d6:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3d8:	00d036b3          	snez	a3,a3
 3dc:	03f5d793          	srli	a5,a1,0x3f
 3e0:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3e2:	0005871b          	sext.w	a4,a1
  neg = 0;
 3e6:	4301                	li	t1,0
  if(sgn && xx < 0){
 3e8:	c681                	beqz	a3,3f0 <printint+0x26>
    x = -xx;
 3ea:	40b0073b          	negw	a4,a1
    neg = 1;
 3ee:	4305                	li	t1,1
  }

  i = 0;
 3f0:	fb840993          	addi	s3,s0,-72
  neg = 0;
 3f4:	85ce                	mv	a1,s3
  i = 0;
 3f6:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 3f8:	00000817          	auipc	a6,0x0
 3fc:	54880813          	addi	a6,a6,1352 # 940 <digits>
 400:	88b6                	mv	a7,a3
 402:	0016851b          	addiw	a0,a3,1
 406:	86aa                	mv	a3,a0
 408:	02c777bb          	remuw	a5,a4,a2
 40c:	1782                	slli	a5,a5,0x20
 40e:	9381                	srli	a5,a5,0x20
 410:	97c2                	add	a5,a5,a6
 412:	0007c783          	lbu	a5,0(a5)
 416:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 41a:	87ba                	mv	a5,a4
 41c:	02c7573b          	divuw	a4,a4,a2
 420:	0585                	addi	a1,a1,1
 422:	fcc7ffe3          	bgeu	a5,a2,400 <printint+0x36>
  if(neg)
 426:	00030b63          	beqz	t1,43c <printint+0x72>
    buf[i++] = '-';
 42a:	fd040793          	addi	a5,s0,-48
 42e:	953e                	add	a0,a0,a5
 430:	02d00793          	li	a5,45
 434:	fef50423          	sb	a5,-24(a0)
 438:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 43c:	02d05563          	blez	a3,466 <printint+0x9c>
 440:	fc26                	sd	s1,56(sp)
 442:	36fd                	addiw	a3,a3,-1
 444:	00d984b3          	add	s1,s3,a3
 448:	19fd                	addi	s3,s3,-1
 44a:	99b6                	add	s3,s3,a3
 44c:	1682                	slli	a3,a3,0x20
 44e:	9281                	srli	a3,a3,0x20
 450:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 454:	0004c583          	lbu	a1,0(s1)
 458:	854a                	mv	a0,s2
 45a:	f53ff0ef          	jal	3ac <putc>
  while(--i >= 0)
 45e:	14fd                	addi	s1,s1,-1
 460:	ff349ae3          	bne	s1,s3,454 <printint+0x8a>
 464:	74e2                	ld	s1,56(sp)
}
 466:	60a6                	ld	ra,72(sp)
 468:	6406                	ld	s0,64(sp)
 46a:	7942                	ld	s2,48(sp)
 46c:	79a2                	ld	s3,40(sp)
 46e:	6161                	addi	sp,sp,80
 470:	8082                	ret

0000000000000472 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 472:	711d                	addi	sp,sp,-96
 474:	ec86                	sd	ra,88(sp)
 476:	e8a2                	sd	s0,80(sp)
 478:	e4a6                	sd	s1,72(sp)
 47a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 47c:	0005c483          	lbu	s1,0(a1)
 480:	2a048063          	beqz	s1,720 <vprintf+0x2ae>
 484:	e0ca                	sd	s2,64(sp)
 486:	fc4e                	sd	s3,56(sp)
 488:	f852                	sd	s4,48(sp)
 48a:	f456                	sd	s5,40(sp)
 48c:	f05a                	sd	s6,32(sp)
 48e:	ec5e                	sd	s7,24(sp)
 490:	e862                	sd	s8,16(sp)
 492:	8b2a                	mv	s6,a0
 494:	8a2e                	mv	s4,a1
 496:	8bb2                	mv	s7,a2
  state = 0;
 498:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 49a:	4901                	li	s2,0
 49c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 49e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4a2:	06400c13          	li	s8,100
 4a6:	a00d                	j	4c8 <vprintf+0x56>
        putc(fd, c0);
 4a8:	85a6                	mv	a1,s1
 4aa:	855a                	mv	a0,s6
 4ac:	f01ff0ef          	jal	3ac <putc>
 4b0:	a019                	j	4b6 <vprintf+0x44>
    } else if(state == '%'){
 4b2:	03598363          	beq	s3,s5,4d8 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 4b6:	0019079b          	addiw	a5,s2,1
 4ba:	893e                	mv	s2,a5
 4bc:	873e                	mv	a4,a5
 4be:	97d2                	add	a5,a5,s4
 4c0:	0007c483          	lbu	s1,0(a5)
 4c4:	24048763          	beqz	s1,712 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 4c8:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4cc:	fe0993e3          	bnez	s3,4b2 <vprintf+0x40>
      if(c0 == '%'){
 4d0:	fd579ce3          	bne	a5,s5,4a8 <vprintf+0x36>
        state = '%';
 4d4:	89be                	mv	s3,a5
 4d6:	b7c5                	j	4b6 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 4d8:	00ea06b3          	add	a3,s4,a4
 4dc:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 4e0:	24060563          	beqz	a2,72a <vprintf+0x2b8>
      if(c0 == 'd'){
 4e4:	0b878763          	beq	a5,s8,592 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4e8:	f9478693          	addi	a3,a5,-108
 4ec:	0016b693          	seqz	a3,a3
 4f0:	f9c60593          	addi	a1,a2,-100
 4f4:	0015b593          	seqz	a1,a1
 4f8:	8df5                	and	a1,a1,a3
 4fa:	e9c5                	bnez	a1,5aa <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 4fc:	9752                	add	a4,a4,s4
 4fe:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 502:	f9460713          	addi	a4,a2,-108
 506:	00173713          	seqz	a4,a4
 50a:	8f75                	and	a4,a4,a3
 50c:	f9c50593          	addi	a1,a0,-100
 510:	0015b593          	seqz	a1,a1
 514:	8df9                	and	a1,a1,a4
 516:	e5dd                	bnez	a1,5c4 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 518:	07500593          	li	a1,117
 51c:	0cb78163          	beq	a5,a1,5de <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 520:	f8b60593          	addi	a1,a2,-117
 524:	0015b593          	seqz	a1,a1
 528:	8df5                	and	a1,a1,a3
 52a:	e5f1                	bnez	a1,5f6 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 52c:	f8b50593          	addi	a1,a0,-117
 530:	0015b593          	seqz	a1,a1
 534:	8df9                	and	a1,a1,a4
 536:	ede9                	bnez	a1,610 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 538:	07800593          	li	a1,120
 53c:	0eb78763          	beq	a5,a1,62a <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 540:	f8860613          	addi	a2,a2,-120
 544:	00163613          	seqz	a2,a2
 548:	8ef1                	and	a3,a3,a2
 54a:	0e069c63          	bnez	a3,642 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 54e:	f8850513          	addi	a0,a0,-120
 552:	00153513          	seqz	a0,a0
 556:	8f69                	and	a4,a4,a0
 558:	10071263          	bnez	a4,65c <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 55c:	07000713          	li	a4,112
 560:	10e78a63          	beq	a5,a4,674 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 564:	06300713          	li	a4,99
 568:	14e78a63          	beq	a5,a4,6bc <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 56c:	07300713          	li	a4,115
 570:	16e78063          	beq	a5,a4,6d0 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 574:	02500713          	li	a4,37
 578:	18e78863          	beq	a5,a4,708 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 57c:	02500593          	li	a1,37
 580:	855a                	mv	a0,s6
 582:	e2bff0ef          	jal	3ac <putc>
        putc(fd, c0);
 586:	85a6                	mv	a1,s1
 588:	855a                	mv	a0,s6
 58a:	e23ff0ef          	jal	3ac <putc>
      }

      state = 0;
 58e:	4981                	li	s3,0
 590:	b71d                	j	4b6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 592:	008b8493          	addi	s1,s7,8
 596:	4685                	li	a3,1
 598:	4629                	li	a2,10
 59a:	000ba583          	lw	a1,0(s7)
 59e:	855a                	mv	a0,s6
 5a0:	e2bff0ef          	jal	3ca <printint>
 5a4:	8ba6                	mv	s7,s1
      state = 0;
 5a6:	4981                	li	s3,0
 5a8:	b739                	j	4b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5aa:	008b8493          	addi	s1,s7,8
 5ae:	4685                	li	a3,1
 5b0:	4629                	li	a2,10
 5b2:	000bb583          	ld	a1,0(s7)
 5b6:	855a                	mv	a0,s6
 5b8:	e13ff0ef          	jal	3ca <printint>
        i += 1;
 5bc:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5be:	8ba6                	mv	s7,s1
      state = 0;
 5c0:	4981                	li	s3,0
 5c2:	bdd5                	j	4b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5c4:	008b8493          	addi	s1,s7,8
 5c8:	4685                	li	a3,1
 5ca:	4629                	li	a2,10
 5cc:	000bb583          	ld	a1,0(s7)
 5d0:	855a                	mv	a0,s6
 5d2:	df9ff0ef          	jal	3ca <printint>
        i += 2;
 5d6:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d8:	8ba6                	mv	s7,s1
      state = 0;
 5da:	4981                	li	s3,0
        i += 2;
 5dc:	bde9                	j	4b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 5de:	008b8493          	addi	s1,s7,8
 5e2:	4681                	li	a3,0
 5e4:	4629                	li	a2,10
 5e6:	000be583          	lwu	a1,0(s7)
 5ea:	855a                	mv	a0,s6
 5ec:	ddfff0ef          	jal	3ca <printint>
 5f0:	8ba6                	mv	s7,s1
      state = 0;
 5f2:	4981                	li	s3,0
 5f4:	b5c9                	j	4b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5f6:	008b8493          	addi	s1,s7,8
 5fa:	4681                	li	a3,0
 5fc:	4629                	li	a2,10
 5fe:	000bb583          	ld	a1,0(s7)
 602:	855a                	mv	a0,s6
 604:	dc7ff0ef          	jal	3ca <printint>
        i += 1;
 608:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 60a:	8ba6                	mv	s7,s1
      state = 0;
 60c:	4981                	li	s3,0
 60e:	b565                	j	4b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 610:	008b8493          	addi	s1,s7,8
 614:	4681                	li	a3,0
 616:	4629                	li	a2,10
 618:	000bb583          	ld	a1,0(s7)
 61c:	855a                	mv	a0,s6
 61e:	dadff0ef          	jal	3ca <printint>
        i += 2;
 622:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 624:	8ba6                	mv	s7,s1
      state = 0;
 626:	4981                	li	s3,0
        i += 2;
 628:	b579                	j	4b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 62a:	008b8493          	addi	s1,s7,8
 62e:	4681                	li	a3,0
 630:	4641                	li	a2,16
 632:	000be583          	lwu	a1,0(s7)
 636:	855a                	mv	a0,s6
 638:	d93ff0ef          	jal	3ca <printint>
 63c:	8ba6                	mv	s7,s1
      state = 0;
 63e:	4981                	li	s3,0
 640:	bd9d                	j	4b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 642:	008b8493          	addi	s1,s7,8
 646:	4681                	li	a3,0
 648:	4641                	li	a2,16
 64a:	000bb583          	ld	a1,0(s7)
 64e:	855a                	mv	a0,s6
 650:	d7bff0ef          	jal	3ca <printint>
        i += 1;
 654:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 656:	8ba6                	mv	s7,s1
      state = 0;
 658:	4981                	li	s3,0
 65a:	bdb1                	j	4b6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 65c:	008b8493          	addi	s1,s7,8
 660:	4641                	li	a2,16
 662:	000bb583          	ld	a1,0(s7)
 666:	855a                	mv	a0,s6
 668:	d63ff0ef          	jal	3ca <printint>
        i += 2;
 66c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 66e:	8ba6                	mv	s7,s1
      state = 0;
 670:	4981                	li	s3,0
        i += 2;
 672:	b591                	j	4b6 <vprintf+0x44>
 674:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 676:	008b8793          	addi	a5,s7,8
 67a:	8cbe                	mv	s9,a5
 67c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 680:	03000593          	li	a1,48
 684:	855a                	mv	a0,s6
 686:	d27ff0ef          	jal	3ac <putc>
  putc(fd, 'x');
 68a:	07800593          	li	a1,120
 68e:	855a                	mv	a0,s6
 690:	d1dff0ef          	jal	3ac <putc>
 694:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 696:	00000b97          	auipc	s7,0x0
 69a:	2aab8b93          	addi	s7,s7,682 # 940 <digits>
 69e:	03c9d793          	srli	a5,s3,0x3c
 6a2:	97de                	add	a5,a5,s7
 6a4:	0007c583          	lbu	a1,0(a5)
 6a8:	855a                	mv	a0,s6
 6aa:	d03ff0ef          	jal	3ac <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6ae:	0992                	slli	s3,s3,0x4
 6b0:	34fd                	addiw	s1,s1,-1
 6b2:	f4f5                	bnez	s1,69e <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 6b4:	8be6                	mv	s7,s9
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	6ca2                	ld	s9,8(sp)
 6ba:	bbf5                	j	4b6 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 6bc:	008b8493          	addi	s1,s7,8
 6c0:	000bc583          	lbu	a1,0(s7)
 6c4:	855a                	mv	a0,s6
 6c6:	ce7ff0ef          	jal	3ac <putc>
 6ca:	8ba6                	mv	s7,s1
      state = 0;
 6cc:	4981                	li	s3,0
 6ce:	b3e5                	j	4b6 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 6d0:	008b8993          	addi	s3,s7,8
 6d4:	000bb483          	ld	s1,0(s7)
 6d8:	cc91                	beqz	s1,6f4 <vprintf+0x282>
        for(; *s; s++)
 6da:	0004c583          	lbu	a1,0(s1)
 6de:	c195                	beqz	a1,702 <vprintf+0x290>
          putc(fd, *s);
 6e0:	855a                	mv	a0,s6
 6e2:	ccbff0ef          	jal	3ac <putc>
        for(; *s; s++)
 6e6:	0485                	addi	s1,s1,1
 6e8:	0004c583          	lbu	a1,0(s1)
 6ec:	f9f5                	bnez	a1,6e0 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 6ee:	8bce                	mv	s7,s3
      state = 0;
 6f0:	4981                	li	s3,0
 6f2:	b3d1                	j	4b6 <vprintf+0x44>
          s = "(null)";
 6f4:	00000497          	auipc	s1,0x0
 6f8:	24448493          	addi	s1,s1,580 # 938 <malloc+0x112>
        for(; *s; s++)
 6fc:	02800593          	li	a1,40
 700:	b7c5                	j	6e0 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 702:	8bce                	mv	s7,s3
      state = 0;
 704:	4981                	li	s3,0
 706:	bb45                	j	4b6 <vprintf+0x44>
        putc(fd, '%');
 708:	85be                	mv	a1,a5
 70a:	855a                	mv	a0,s6
 70c:	ca1ff0ef          	jal	3ac <putc>
 710:	bdbd                	j	58e <vprintf+0x11c>
 712:	6906                	ld	s2,64(sp)
 714:	79e2                	ld	s3,56(sp)
 716:	7a42                	ld	s4,48(sp)
 718:	7aa2                	ld	s5,40(sp)
 71a:	7b02                	ld	s6,32(sp)
 71c:	6be2                	ld	s7,24(sp)
 71e:	6c42                	ld	s8,16(sp)
    }
  }
}
 720:	60e6                	ld	ra,88(sp)
 722:	6446                	ld	s0,80(sp)
 724:	64a6                	ld	s1,72(sp)
 726:	6125                	addi	sp,sp,96
 728:	8082                	ret
      if(c0 == 'd'){
 72a:	06400713          	li	a4,100
 72e:	e6e782e3          	beq	a5,a4,592 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 732:	f9478693          	addi	a3,a5,-108
 736:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 73a:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 73c:	4701                	li	a4,0
 73e:	bbe9                	j	518 <vprintf+0xa6>

0000000000000740 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 740:	715d                	addi	sp,sp,-80
 742:	ec06                	sd	ra,24(sp)
 744:	e822                	sd	s0,16(sp)
 746:	1000                	addi	s0,sp,32
 748:	e010                	sd	a2,0(s0)
 74a:	e414                	sd	a3,8(s0)
 74c:	e818                	sd	a4,16(s0)
 74e:	ec1c                	sd	a5,24(s0)
 750:	03043023          	sd	a6,32(s0)
 754:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 758:	8622                	mv	a2,s0
 75a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 75e:	d15ff0ef          	jal	472 <vprintf>
}
 762:	60e2                	ld	ra,24(sp)
 764:	6442                	ld	s0,16(sp)
 766:	6161                	addi	sp,sp,80
 768:	8082                	ret

000000000000076a <printf>:

void
printf(const char *fmt, ...)
{
 76a:	711d                	addi	sp,sp,-96
 76c:	ec06                	sd	ra,24(sp)
 76e:	e822                	sd	s0,16(sp)
 770:	1000                	addi	s0,sp,32
 772:	e40c                	sd	a1,8(s0)
 774:	e810                	sd	a2,16(s0)
 776:	ec14                	sd	a3,24(s0)
 778:	f018                	sd	a4,32(s0)
 77a:	f41c                	sd	a5,40(s0)
 77c:	03043823          	sd	a6,48(s0)
 780:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 784:	00840613          	addi	a2,s0,8
 788:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 78c:	85aa                	mv	a1,a0
 78e:	4505                	li	a0,1
 790:	ce3ff0ef          	jal	472 <vprintf>
}
 794:	60e2                	ld	ra,24(sp)
 796:	6442                	ld	s0,16(sp)
 798:	6125                	addi	sp,sp,96
 79a:	8082                	ret

000000000000079c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 79c:	1141                	addi	sp,sp,-16
 79e:	e406                	sd	ra,8(sp)
 7a0:	e022                	sd	s0,0(sp)
 7a2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7a4:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a8:	00001797          	auipc	a5,0x1
 7ac:	8587b783          	ld	a5,-1960(a5) # 1000 <freep>
 7b0:	a095                	j	814 <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7b2:	ff852583          	lw	a1,-8(a0)
 7b6:	6390                	ld	a2,0(a5)
 7b8:	02059813          	slli	a6,a1,0x20
 7bc:	01c85693          	srli	a3,a6,0x1c
 7c0:	96ba                	add	a3,a3,a4
 7c2:	02d60563          	beq	a2,a3,7ec <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7c6:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7ca:	4790                	lw	a2,8(a5)
 7cc:	02061593          	slli	a1,a2,0x20
 7d0:	01c5d693          	srli	a3,a1,0x1c
 7d4:	96be                	add	a3,a3,a5
 7d6:	02d70263          	beq	a4,a3,7fa <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7da:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7dc:	00001717          	auipc	a4,0x1
 7e0:	82f73223          	sd	a5,-2012(a4) # 1000 <freep>
}
 7e4:	60a2                	ld	ra,8(sp)
 7e6:	6402                	ld	s0,0(sp)
 7e8:	0141                	addi	sp,sp,16
 7ea:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 7ec:	4614                	lw	a3,8(a2)
 7ee:	9ead                	addw	a3,a3,a1
 7f0:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7f4:	6394                	ld	a3,0(a5)
 7f6:	6290                	ld	a2,0(a3)
 7f8:	b7f9                	j	7c6 <free+0x2a>
    p->s.size += bp->s.size;
 7fa:	ff852703          	lw	a4,-8(a0)
 7fe:	9f31                	addw	a4,a4,a2
 800:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 802:	ff053703          	ld	a4,-16(a0)
 806:	bfd1                	j	7da <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 808:	6394                	ld	a3,0(a5)
 80a:	00d7e463          	bltu	a5,a3,812 <free+0x76>
 80e:	fad762e3          	bltu	a4,a3,7b2 <free+0x16>
 812:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 814:	fee7fae3          	bgeu	a5,a4,808 <free+0x6c>
 818:	6394                	ld	a3,0(a5)
 81a:	f8d76ce3          	bltu	a4,a3,7b2 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 81e:	f8d7fae3          	bgeu	a5,a3,7b2 <free+0x16>
 822:	87b6                	mv	a5,a3
 824:	bfc5                	j	814 <free+0x78>

0000000000000826 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 826:	7139                	addi	sp,sp,-64
 828:	fc06                	sd	ra,56(sp)
 82a:	f822                	sd	s0,48(sp)
 82c:	f04a                	sd	s2,32(sp)
 82e:	ec4e                	sd	s3,24(sp)
 830:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 832:	02051993          	slli	s3,a0,0x20
 836:	0209d993          	srli	s3,s3,0x20
 83a:	09bd                	addi	s3,s3,15
 83c:	0049d993          	srli	s3,s3,0x4
 840:	2985                	addiw	s3,s3,1
 842:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 844:	00000517          	auipc	a0,0x0
 848:	7bc53503          	ld	a0,1980(a0) # 1000 <freep>
 84c:	c905                	beqz	a0,87c <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 84e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 850:	4798                	lw	a4,8(a5)
 852:	09377663          	bgeu	a4,s3,8de <malloc+0xb8>
 856:	f426                	sd	s1,40(sp)
 858:	e852                	sd	s4,16(sp)
 85a:	e456                	sd	s5,8(sp)
 85c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 85e:	8a4e                	mv	s4,s3
 860:	6705                	lui	a4,0x1
 862:	00e9f363          	bgeu	s3,a4,868 <malloc+0x42>
 866:	6a05                	lui	s4,0x1
 868:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 86c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 870:	00000497          	auipc	s1,0x0
 874:	79048493          	addi	s1,s1,1936 # 1000 <freep>
  if(p == SBRK_ERROR)
 878:	5afd                	li	s5,-1
 87a:	a83d                	j	8b8 <malloc+0x92>
 87c:	f426                	sd	s1,40(sp)
 87e:	e852                	sd	s4,16(sp)
 880:	e456                	sd	s5,8(sp)
 882:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 884:	00000797          	auipc	a5,0x0
 888:	78c78793          	addi	a5,a5,1932 # 1010 <base>
 88c:	00000717          	auipc	a4,0x0
 890:	76f73a23          	sd	a5,1908(a4) # 1000 <freep>
 894:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 896:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 89a:	b7d1                	j	85e <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 89c:	6398                	ld	a4,0(a5)
 89e:	e118                	sd	a4,0(a0)
 8a0:	a899                	j	8f6 <malloc+0xd0>
  hp->s.size = nu;
 8a2:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8a6:	0541                	addi	a0,a0,16
 8a8:	ef5ff0ef          	jal	79c <free>
  return freep;
 8ac:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8ae:	c125                	beqz	a0,90e <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8b2:	4798                	lw	a4,8(a5)
 8b4:	03277163          	bgeu	a4,s2,8d6 <malloc+0xb0>
    if(p == freep)
 8b8:	6098                	ld	a4,0(s1)
 8ba:	853e                	mv	a0,a5
 8bc:	fef71ae3          	bne	a4,a5,8b0 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 8c0:	8552                	mv	a0,s4
 8c2:	a17ff0ef          	jal	2d8 <sbrk>
  if(p == SBRK_ERROR)
 8c6:	fd551ee3          	bne	a0,s5,8a2 <malloc+0x7c>
        return 0;
 8ca:	4501                	li	a0,0
 8cc:	74a2                	ld	s1,40(sp)
 8ce:	6a42                	ld	s4,16(sp)
 8d0:	6aa2                	ld	s5,8(sp)
 8d2:	6b02                	ld	s6,0(sp)
 8d4:	a03d                	j	902 <malloc+0xdc>
 8d6:	74a2                	ld	s1,40(sp)
 8d8:	6a42                	ld	s4,16(sp)
 8da:	6aa2                	ld	s5,8(sp)
 8dc:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8de:	fae90fe3          	beq	s2,a4,89c <malloc+0x76>
        p->s.size -= nunits;
 8e2:	4137073b          	subw	a4,a4,s3
 8e6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8e8:	02071693          	slli	a3,a4,0x20
 8ec:	01c6d713          	srli	a4,a3,0x1c
 8f0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8f2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8f6:	00000717          	auipc	a4,0x0
 8fa:	70a73523          	sd	a0,1802(a4) # 1000 <freep>
      return (void*)(p + 1);
 8fe:	01078513          	addi	a0,a5,16
  }
}
 902:	70e2                	ld	ra,56(sp)
 904:	7442                	ld	s0,48(sp)
 906:	7902                	ld	s2,32(sp)
 908:	69e2                	ld	s3,24(sp)
 90a:	6121                	addi	sp,sp,64
 90c:	8082                	ret
 90e:	74a2                	ld	s1,40(sp)
 910:	6a42                	ld	s4,16(sp)
 912:	6aa2                	ld	s5,8(sp)
 914:	6b02                	ld	s6,0(sp)
 916:	b7f5                	j	902 <malloc+0xdc>
