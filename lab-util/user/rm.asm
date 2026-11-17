
user/_rm:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
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
    fprintf(2, "Usage: rm files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  26:	6088                	ld	a0,0(s1)
  28:	346000ef          	jal	36e <unlink>
  2c:	02054463          	bltz	a0,54 <main+0x54>
  for(i = 1; i < argc; i++){
  30:	04a1                	addi	s1,s1,8
  32:	ff249ae3          	bne	s1,s2,26 <main+0x26>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit(0);
  36:	4501                	li	a0,0
  38:	2e6000ef          	jal	31e <exit>
  3c:	e426                	sd	s1,8(sp)
  3e:	e04a                	sd	s2,0(sp)
    fprintf(2, "Usage: rm files...\n");
  40:	00001597          	auipc	a1,0x1
  44:	8f058593          	addi	a1,a1,-1808 # 930 <malloc+0xf8>
  48:	4509                	li	a0,2
  4a:	708000ef          	jal	752 <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	2ce000ef          	jal	31e <exit>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  54:	6090                	ld	a2,0(s1)
  56:	00001597          	auipc	a1,0x1
  5a:	8f258593          	addi	a1,a1,-1806 # 948 <malloc+0x110>
  5e:	4509                	li	a0,2
  60:	6f2000ef          	jal	752 <fprintf>
      break;
  64:	bfc9                	j	36 <main+0x36>

0000000000000066 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  66:	1141                	addi	sp,sp,-16
  68:	e406                	sd	ra,8(sp)
  6a:	e022                	sd	s0,0(sp)
  6c:	0800                	addi	s0,sp,16
  extern int main();
  main();
  6e:	f93ff0ef          	jal	0 <main>
  exit(0);
  72:	4501                	li	a0,0
  74:	2aa000ef          	jal	31e <exit>

0000000000000078 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  78:	1141                	addi	sp,sp,-16
  7a:	e406                	sd	ra,8(sp)
  7c:	e022                	sd	s0,0(sp)
  7e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  80:	87aa                	mv	a5,a0
  82:	0585                	addi	a1,a1,1
  84:	0785                	addi	a5,a5,1
  86:	fff5c703          	lbu	a4,-1(a1)
  8a:	fee78fa3          	sb	a4,-1(a5)
  8e:	fb75                	bnez	a4,82 <strcpy+0xa>
    ;
  return os;
}
  90:	60a2                	ld	ra,8(sp)
  92:	6402                	ld	s0,0(sp)
  94:	0141                	addi	sp,sp,16
  96:	8082                	ret

0000000000000098 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  98:	1141                	addi	sp,sp,-16
  9a:	e406                	sd	ra,8(sp)
  9c:	e022                	sd	s0,0(sp)
  9e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  a0:	00054783          	lbu	a5,0(a0)
  a4:	cb91                	beqz	a5,b8 <strcmp+0x20>
  a6:	0005c703          	lbu	a4,0(a1)
  aa:	00f71763          	bne	a4,a5,b8 <strcmp+0x20>
    p++, q++;
  ae:	0505                	addi	a0,a0,1
  b0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  b2:	00054783          	lbu	a5,0(a0)
  b6:	fbe5                	bnez	a5,a6 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  b8:	0005c503          	lbu	a0,0(a1)
}
  bc:	40a7853b          	subw	a0,a5,a0
  c0:	60a2                	ld	ra,8(sp)
  c2:	6402                	ld	s0,0(sp)
  c4:	0141                	addi	sp,sp,16
  c6:	8082                	ret

00000000000000c8 <strlen>:

uint
strlen(const char *s)
{
  c8:	1141                	addi	sp,sp,-16
  ca:	e406                	sd	ra,8(sp)
  cc:	e022                	sd	s0,0(sp)
  ce:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  d0:	00054783          	lbu	a5,0(a0)
  d4:	cf91                	beqz	a5,f0 <strlen+0x28>
  d6:	00150793          	addi	a5,a0,1
  da:	86be                	mv	a3,a5
  dc:	0785                	addi	a5,a5,1
  de:	fff7c703          	lbu	a4,-1(a5)
  e2:	ff65                	bnez	a4,da <strlen+0x12>
  e4:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  e8:	60a2                	ld	ra,8(sp)
  ea:	6402                	ld	s0,0(sp)
  ec:	0141                	addi	sp,sp,16
  ee:	8082                	ret
  for(n = 0; s[n]; n++)
  f0:	4501                	li	a0,0
  f2:	bfdd                	j	e8 <strlen+0x20>

00000000000000f4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f4:	1141                	addi	sp,sp,-16
  f6:	e406                	sd	ra,8(sp)
  f8:	e022                	sd	s0,0(sp)
  fa:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  fc:	ca19                	beqz	a2,112 <memset+0x1e>
  fe:	87aa                	mv	a5,a0
 100:	1602                	slli	a2,a2,0x20
 102:	9201                	srli	a2,a2,0x20
 104:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 108:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 10c:	0785                	addi	a5,a5,1
 10e:	fee79de3          	bne	a5,a4,108 <memset+0x14>
  }
  return dst;
}
 112:	60a2                	ld	ra,8(sp)
 114:	6402                	ld	s0,0(sp)
 116:	0141                	addi	sp,sp,16
 118:	8082                	ret

000000000000011a <strchr>:

char*
strchr(const char *s, char c)
{
 11a:	1141                	addi	sp,sp,-16
 11c:	e406                	sd	ra,8(sp)
 11e:	e022                	sd	s0,0(sp)
 120:	0800                	addi	s0,sp,16
  for(; *s; s++)
 122:	00054783          	lbu	a5,0(a0)
 126:	c799                	beqz	a5,134 <strchr+0x1a>
    if(*s == c)
 128:	00f58763          	beq	a1,a5,136 <strchr+0x1c>
  for(; *s; s++)
 12c:	0505                	addi	a0,a0,1
 12e:	00054783          	lbu	a5,0(a0)
 132:	fbfd                	bnez	a5,128 <strchr+0xe>
      return (char*)s;
  return 0;
 134:	4501                	li	a0,0
}
 136:	60a2                	ld	ra,8(sp)
 138:	6402                	ld	s0,0(sp)
 13a:	0141                	addi	sp,sp,16
 13c:	8082                	ret

000000000000013e <gets>:

char*
gets(char *buf, int max)
{
 13e:	711d                	addi	sp,sp,-96
 140:	ec86                	sd	ra,88(sp)
 142:	e8a2                	sd	s0,80(sp)
 144:	e4a6                	sd	s1,72(sp)
 146:	e0ca                	sd	s2,64(sp)
 148:	fc4e                	sd	s3,56(sp)
 14a:	f852                	sd	s4,48(sp)
 14c:	f456                	sd	s5,40(sp)
 14e:	f05a                	sd	s6,32(sp)
 150:	ec5e                	sd	s7,24(sp)
 152:	e862                	sd	s8,16(sp)
 154:	1080                	addi	s0,sp,96
 156:	8baa                	mv	s7,a0
 158:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 15a:	892a                	mv	s2,a0
 15c:	4481                	li	s1,0
    cc = read(0, &c, 1);
 15e:	faf40b13          	addi	s6,s0,-81
 162:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 164:	8c26                	mv	s8,s1
 166:	0014899b          	addiw	s3,s1,1
 16a:	84ce                	mv	s1,s3
 16c:	0349d863          	bge	s3,s4,19c <gets+0x5e>
    cc = read(0, &c, 1);
 170:	8656                	mv	a2,s5
 172:	85da                	mv	a1,s6
 174:	4501                	li	a0,0
 176:	1c0000ef          	jal	336 <read>
    if(cc < 1)
 17a:	02a05163          	blez	a0,19c <gets+0x5e>
      break;
    buf[i++] = c;
 17e:	faf44783          	lbu	a5,-81(s0)
 182:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 186:	0905                	addi	s2,s2,1
 188:	ff678713          	addi	a4,a5,-10
 18c:	00173713          	seqz	a4,a4
 190:	17cd                	addi	a5,a5,-13
 192:	0017b793          	seqz	a5,a5
 196:	8fd9                	or	a5,a5,a4
 198:	d7f1                	beqz	a5,164 <gets+0x26>
    buf[i++] = c;
 19a:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 19c:	9c5e                	add	s8,s8,s7
 19e:	000c0023          	sb	zero,0(s8)
  return buf;
}
 1a2:	855e                	mv	a0,s7
 1a4:	60e6                	ld	ra,88(sp)
 1a6:	6446                	ld	s0,80(sp)
 1a8:	64a6                	ld	s1,72(sp)
 1aa:	6906                	ld	s2,64(sp)
 1ac:	79e2                	ld	s3,56(sp)
 1ae:	7a42                	ld	s4,48(sp)
 1b0:	7aa2                	ld	s5,40(sp)
 1b2:	7b02                	ld	s6,32(sp)
 1b4:	6be2                	ld	s7,24(sp)
 1b6:	6c42                	ld	s8,16(sp)
 1b8:	6125                	addi	sp,sp,96
 1ba:	8082                	ret

00000000000001bc <stat>:

int
stat(const char *n, struct stat *st)
{
 1bc:	1101                	addi	sp,sp,-32
 1be:	ec06                	sd	ra,24(sp)
 1c0:	e822                	sd	s0,16(sp)
 1c2:	e04a                	sd	s2,0(sp)
 1c4:	1000                	addi	s0,sp,32
 1c6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c8:	4581                	li	a1,0
 1ca:	194000ef          	jal	35e <open>
  if(fd < 0)
 1ce:	02054263          	bltz	a0,1f2 <stat+0x36>
 1d2:	e426                	sd	s1,8(sp)
 1d4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1d6:	85ca                	mv	a1,s2
 1d8:	19e000ef          	jal	376 <fstat>
 1dc:	892a                	mv	s2,a0
  close(fd);
 1de:	8526                	mv	a0,s1
 1e0:	166000ef          	jal	346 <close>
  return r;
 1e4:	64a2                	ld	s1,8(sp)
}
 1e6:	854a                	mv	a0,s2
 1e8:	60e2                	ld	ra,24(sp)
 1ea:	6442                	ld	s0,16(sp)
 1ec:	6902                	ld	s2,0(sp)
 1ee:	6105                	addi	sp,sp,32
 1f0:	8082                	ret
    return -1;
 1f2:	57fd                	li	a5,-1
 1f4:	893e                	mv	s2,a5
 1f6:	bfc5                	j	1e6 <stat+0x2a>

00000000000001f8 <atoi>:

int
atoi(const char *s)
{
 1f8:	1141                	addi	sp,sp,-16
 1fa:	e406                	sd	ra,8(sp)
 1fc:	e022                	sd	s0,0(sp)
 1fe:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 200:	00054683          	lbu	a3,0(a0)
 204:	fd06879b          	addiw	a5,a3,-48
 208:	0ff7f793          	zext.b	a5,a5
 20c:	4625                	li	a2,9
 20e:	02f66963          	bltu	a2,a5,240 <atoi+0x48>
 212:	872a                	mv	a4,a0
  n = 0;
 214:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 216:	0705                	addi	a4,a4,1
 218:	0025179b          	slliw	a5,a0,0x2
 21c:	9fa9                	addw	a5,a5,a0
 21e:	0017979b          	slliw	a5,a5,0x1
 222:	9fb5                	addw	a5,a5,a3
 224:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 228:	00074683          	lbu	a3,0(a4)
 22c:	fd06879b          	addiw	a5,a3,-48
 230:	0ff7f793          	zext.b	a5,a5
 234:	fef671e3          	bgeu	a2,a5,216 <atoi+0x1e>
  return n;
}
 238:	60a2                	ld	ra,8(sp)
 23a:	6402                	ld	s0,0(sp)
 23c:	0141                	addi	sp,sp,16
 23e:	8082                	ret
  n = 0;
 240:	4501                	li	a0,0
 242:	bfdd                	j	238 <atoi+0x40>

0000000000000244 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 244:	1141                	addi	sp,sp,-16
 246:	e406                	sd	ra,8(sp)
 248:	e022                	sd	s0,0(sp)
 24a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 24c:	02b57563          	bgeu	a0,a1,276 <memmove+0x32>
    while(n-- > 0)
 250:	00c05f63          	blez	a2,26e <memmove+0x2a>
 254:	1602                	slli	a2,a2,0x20
 256:	9201                	srli	a2,a2,0x20
 258:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 25c:	872a                	mv	a4,a0
      *dst++ = *src++;
 25e:	0585                	addi	a1,a1,1
 260:	0705                	addi	a4,a4,1
 262:	fff5c683          	lbu	a3,-1(a1)
 266:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 26a:	fee79ae3          	bne	a5,a4,25e <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 26e:	60a2                	ld	ra,8(sp)
 270:	6402                	ld	s0,0(sp)
 272:	0141                	addi	sp,sp,16
 274:	8082                	ret
    while(n-- > 0)
 276:	fec05ce3          	blez	a2,26e <memmove+0x2a>
    dst += n;
 27a:	00c50733          	add	a4,a0,a2
    src += n;
 27e:	95b2                	add	a1,a1,a2
 280:	fff6079b          	addiw	a5,a2,-1
 284:	1782                	slli	a5,a5,0x20
 286:	9381                	srli	a5,a5,0x20
 288:	fff7c793          	not	a5,a5
 28c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 28e:	15fd                	addi	a1,a1,-1
 290:	177d                	addi	a4,a4,-1
 292:	0005c683          	lbu	a3,0(a1)
 296:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 29a:	fef71ae3          	bne	a4,a5,28e <memmove+0x4a>
 29e:	bfc1                	j	26e <memmove+0x2a>

00000000000002a0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2a0:	1141                	addi	sp,sp,-16
 2a2:	e406                	sd	ra,8(sp)
 2a4:	e022                	sd	s0,0(sp)
 2a6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2a8:	ce19                	beqz	a2,2c6 <memcmp+0x26>
 2aa:	1602                	slli	a2,a2,0x20
 2ac:	9201                	srli	a2,a2,0x20
 2ae:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 2b2:	00054783          	lbu	a5,0(a0)
 2b6:	0005c703          	lbu	a4,0(a1)
 2ba:	00e79b63          	bne	a5,a4,2d0 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 2be:	0505                	addi	a0,a0,1
    p2++;
 2c0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2c2:	fed518e3          	bne	a0,a3,2b2 <memcmp+0x12>
  }
  return 0;
 2c6:	4501                	li	a0,0
}
 2c8:	60a2                	ld	ra,8(sp)
 2ca:	6402                	ld	s0,0(sp)
 2cc:	0141                	addi	sp,sp,16
 2ce:	8082                	ret
      return *p1 - *p2;
 2d0:	40e7853b          	subw	a0,a5,a4
 2d4:	bfd5                	j	2c8 <memcmp+0x28>

00000000000002d6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e406                	sd	ra,8(sp)
 2da:	e022                	sd	s0,0(sp)
 2dc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2de:	f67ff0ef          	jal	244 <memmove>
}
 2e2:	60a2                	ld	ra,8(sp)
 2e4:	6402                	ld	s0,0(sp)
 2e6:	0141                	addi	sp,sp,16
 2e8:	8082                	ret

00000000000002ea <sbrk>:

char *
sbrk(int n) {
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e406                	sd	ra,8(sp)
 2ee:	e022                	sd	s0,0(sp)
 2f0:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2f2:	4585                	li	a1,1
 2f4:	0b2000ef          	jal	3a6 <sys_sbrk>
}
 2f8:	60a2                	ld	ra,8(sp)
 2fa:	6402                	ld	s0,0(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret

0000000000000300 <sbrklazy>:

char *
sbrklazy(int n) {
 300:	1141                	addi	sp,sp,-16
 302:	e406                	sd	ra,8(sp)
 304:	e022                	sd	s0,0(sp)
 306:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 308:	4589                	li	a1,2
 30a:	09c000ef          	jal	3a6 <sys_sbrk>
}
 30e:	60a2                	ld	ra,8(sp)
 310:	6402                	ld	s0,0(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret

0000000000000316 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 316:	4885                	li	a7,1
 ecall
 318:	00000073          	ecall
 ret
 31c:	8082                	ret

000000000000031e <exit>:
.global exit
exit:
 li a7, SYS_exit
 31e:	4889                	li	a7,2
 ecall
 320:	00000073          	ecall
 ret
 324:	8082                	ret

0000000000000326 <wait>:
.global wait
wait:
 li a7, SYS_wait
 326:	488d                	li	a7,3
 ecall
 328:	00000073          	ecall
 ret
 32c:	8082                	ret

000000000000032e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 32e:	4891                	li	a7,4
 ecall
 330:	00000073          	ecall
 ret
 334:	8082                	ret

0000000000000336 <read>:
.global read
read:
 li a7, SYS_read
 336:	4895                	li	a7,5
 ecall
 338:	00000073          	ecall
 ret
 33c:	8082                	ret

000000000000033e <write>:
.global write
write:
 li a7, SYS_write
 33e:	48c1                	li	a7,16
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <close>:
.global close
close:
 li a7, SYS_close
 346:	48d5                	li	a7,21
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <kill>:
.global kill
kill:
 li a7, SYS_kill
 34e:	4899                	li	a7,6
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <exec>:
.global exec
exec:
 li a7, SYS_exec
 356:	489d                	li	a7,7
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <open>:
.global open
open:
 li a7, SYS_open
 35e:	48bd                	li	a7,15
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 366:	48c5                	li	a7,17
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 36e:	48c9                	li	a7,18
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 376:	48a1                	li	a7,8
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <link>:
.global link
link:
 li a7, SYS_link
 37e:	48cd                	li	a7,19
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 386:	48d1                	li	a7,20
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 38e:	48a5                	li	a7,9
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <dup>:
.global dup
dup:
 li a7, SYS_dup
 396:	48a9                	li	a7,10
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 39e:	48ad                	li	a7,11
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3a6:	48b1                	li	a7,12
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <pause>:
.global pause
pause:
 li a7, SYS_pause
 3ae:	48b5                	li	a7,13
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3b6:	48b9                	li	a7,14
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3be:	1101                	addi	sp,sp,-32
 3c0:	ec06                	sd	ra,24(sp)
 3c2:	e822                	sd	s0,16(sp)
 3c4:	1000                	addi	s0,sp,32
 3c6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3ca:	4605                	li	a2,1
 3cc:	fef40593          	addi	a1,s0,-17
 3d0:	f6fff0ef          	jal	33e <write>
}
 3d4:	60e2                	ld	ra,24(sp)
 3d6:	6442                	ld	s0,16(sp)
 3d8:	6105                	addi	sp,sp,32
 3da:	8082                	ret

00000000000003dc <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 3dc:	715d                	addi	sp,sp,-80
 3de:	e486                	sd	ra,72(sp)
 3e0:	e0a2                	sd	s0,64(sp)
 3e2:	f84a                	sd	s2,48(sp)
 3e4:	f44e                	sd	s3,40(sp)
 3e6:	0880                	addi	s0,sp,80
 3e8:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3ea:	00d036b3          	snez	a3,a3
 3ee:	03f5d793          	srli	a5,a1,0x3f
 3f2:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3f4:	0005871b          	sext.w	a4,a1
  neg = 0;
 3f8:	4301                	li	t1,0
  if(sgn && xx < 0){
 3fa:	c681                	beqz	a3,402 <printint+0x26>
    x = -xx;
 3fc:	40b0073b          	negw	a4,a1
    neg = 1;
 400:	4305                	li	t1,1
  }

  i = 0;
 402:	fb840993          	addi	s3,s0,-72
  neg = 0;
 406:	85ce                	mv	a1,s3
  i = 0;
 408:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 40a:	00000817          	auipc	a6,0x0
 40e:	56680813          	addi	a6,a6,1382 # 970 <digits>
 412:	88b6                	mv	a7,a3
 414:	0016851b          	addiw	a0,a3,1
 418:	86aa                	mv	a3,a0
 41a:	02c777bb          	remuw	a5,a4,a2
 41e:	1782                	slli	a5,a5,0x20
 420:	9381                	srli	a5,a5,0x20
 422:	97c2                	add	a5,a5,a6
 424:	0007c783          	lbu	a5,0(a5)
 428:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 42c:	87ba                	mv	a5,a4
 42e:	02c7573b          	divuw	a4,a4,a2
 432:	0585                	addi	a1,a1,1
 434:	fcc7ffe3          	bgeu	a5,a2,412 <printint+0x36>
  if(neg)
 438:	00030b63          	beqz	t1,44e <printint+0x72>
    buf[i++] = '-';
 43c:	fd040793          	addi	a5,s0,-48
 440:	953e                	add	a0,a0,a5
 442:	02d00793          	li	a5,45
 446:	fef50423          	sb	a5,-24(a0)
 44a:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 44e:	02d05563          	blez	a3,478 <printint+0x9c>
 452:	fc26                	sd	s1,56(sp)
 454:	36fd                	addiw	a3,a3,-1
 456:	00d984b3          	add	s1,s3,a3
 45a:	19fd                	addi	s3,s3,-1
 45c:	99b6                	add	s3,s3,a3
 45e:	1682                	slli	a3,a3,0x20
 460:	9281                	srli	a3,a3,0x20
 462:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 466:	0004c583          	lbu	a1,0(s1)
 46a:	854a                	mv	a0,s2
 46c:	f53ff0ef          	jal	3be <putc>
  while(--i >= 0)
 470:	14fd                	addi	s1,s1,-1
 472:	ff349ae3          	bne	s1,s3,466 <printint+0x8a>
 476:	74e2                	ld	s1,56(sp)
}
 478:	60a6                	ld	ra,72(sp)
 47a:	6406                	ld	s0,64(sp)
 47c:	7942                	ld	s2,48(sp)
 47e:	79a2                	ld	s3,40(sp)
 480:	6161                	addi	sp,sp,80
 482:	8082                	ret

0000000000000484 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 484:	711d                	addi	sp,sp,-96
 486:	ec86                	sd	ra,88(sp)
 488:	e8a2                	sd	s0,80(sp)
 48a:	e4a6                	sd	s1,72(sp)
 48c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 48e:	0005c483          	lbu	s1,0(a1)
 492:	2a048063          	beqz	s1,732 <vprintf+0x2ae>
 496:	e0ca                	sd	s2,64(sp)
 498:	fc4e                	sd	s3,56(sp)
 49a:	f852                	sd	s4,48(sp)
 49c:	f456                	sd	s5,40(sp)
 49e:	f05a                	sd	s6,32(sp)
 4a0:	ec5e                	sd	s7,24(sp)
 4a2:	e862                	sd	s8,16(sp)
 4a4:	8b2a                	mv	s6,a0
 4a6:	8a2e                	mv	s4,a1
 4a8:	8bb2                	mv	s7,a2
  state = 0;
 4aa:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 4ac:	4901                	li	s2,0
 4ae:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 4b0:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4b4:	06400c13          	li	s8,100
 4b8:	a00d                	j	4da <vprintf+0x56>
        putc(fd, c0);
 4ba:	85a6                	mv	a1,s1
 4bc:	855a                	mv	a0,s6
 4be:	f01ff0ef          	jal	3be <putc>
 4c2:	a019                	j	4c8 <vprintf+0x44>
    } else if(state == '%'){
 4c4:	03598363          	beq	s3,s5,4ea <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 4c8:	0019079b          	addiw	a5,s2,1
 4cc:	893e                	mv	s2,a5
 4ce:	873e                	mv	a4,a5
 4d0:	97d2                	add	a5,a5,s4
 4d2:	0007c483          	lbu	s1,0(a5)
 4d6:	24048763          	beqz	s1,724 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 4da:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4de:	fe0993e3          	bnez	s3,4c4 <vprintf+0x40>
      if(c0 == '%'){
 4e2:	fd579ce3          	bne	a5,s5,4ba <vprintf+0x36>
        state = '%';
 4e6:	89be                	mv	s3,a5
 4e8:	b7c5                	j	4c8 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 4ea:	00ea06b3          	add	a3,s4,a4
 4ee:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 4f2:	24060563          	beqz	a2,73c <vprintf+0x2b8>
      if(c0 == 'd'){
 4f6:	0b878763          	beq	a5,s8,5a4 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4fa:	f9478693          	addi	a3,a5,-108
 4fe:	0016b693          	seqz	a3,a3
 502:	f9c60593          	addi	a1,a2,-100
 506:	0015b593          	seqz	a1,a1
 50a:	8df5                	and	a1,a1,a3
 50c:	e9c5                	bnez	a1,5bc <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 50e:	9752                	add	a4,a4,s4
 510:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 514:	f9460713          	addi	a4,a2,-108
 518:	00173713          	seqz	a4,a4
 51c:	8f75                	and	a4,a4,a3
 51e:	f9c50593          	addi	a1,a0,-100
 522:	0015b593          	seqz	a1,a1
 526:	8df9                	and	a1,a1,a4
 528:	e5dd                	bnez	a1,5d6 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 52a:	07500593          	li	a1,117
 52e:	0cb78163          	beq	a5,a1,5f0 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 532:	f8b60593          	addi	a1,a2,-117
 536:	0015b593          	seqz	a1,a1
 53a:	8df5                	and	a1,a1,a3
 53c:	e5f1                	bnez	a1,608 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 53e:	f8b50593          	addi	a1,a0,-117
 542:	0015b593          	seqz	a1,a1
 546:	8df9                	and	a1,a1,a4
 548:	ede9                	bnez	a1,622 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 54a:	07800593          	li	a1,120
 54e:	0eb78763          	beq	a5,a1,63c <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 552:	f8860613          	addi	a2,a2,-120
 556:	00163613          	seqz	a2,a2
 55a:	8ef1                	and	a3,a3,a2
 55c:	0e069c63          	bnez	a3,654 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 560:	f8850513          	addi	a0,a0,-120
 564:	00153513          	seqz	a0,a0
 568:	8f69                	and	a4,a4,a0
 56a:	10071263          	bnez	a4,66e <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 56e:	07000713          	li	a4,112
 572:	10e78a63          	beq	a5,a4,686 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 576:	06300713          	li	a4,99
 57a:	14e78a63          	beq	a5,a4,6ce <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 57e:	07300713          	li	a4,115
 582:	16e78063          	beq	a5,a4,6e2 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 586:	02500713          	li	a4,37
 58a:	18e78863          	beq	a5,a4,71a <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 58e:	02500593          	li	a1,37
 592:	855a                	mv	a0,s6
 594:	e2bff0ef          	jal	3be <putc>
        putc(fd, c0);
 598:	85a6                	mv	a1,s1
 59a:	855a                	mv	a0,s6
 59c:	e23ff0ef          	jal	3be <putc>
      }

      state = 0;
 5a0:	4981                	li	s3,0
 5a2:	b71d                	j	4c8 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 5a4:	008b8493          	addi	s1,s7,8
 5a8:	4685                	li	a3,1
 5aa:	4629                	li	a2,10
 5ac:	000ba583          	lw	a1,0(s7)
 5b0:	855a                	mv	a0,s6
 5b2:	e2bff0ef          	jal	3dc <printint>
 5b6:	8ba6                	mv	s7,s1
      state = 0;
 5b8:	4981                	li	s3,0
 5ba:	b739                	j	4c8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5bc:	008b8493          	addi	s1,s7,8
 5c0:	4685                	li	a3,1
 5c2:	4629                	li	a2,10
 5c4:	000bb583          	ld	a1,0(s7)
 5c8:	855a                	mv	a0,s6
 5ca:	e13ff0ef          	jal	3dc <printint>
        i += 1;
 5ce:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d0:	8ba6                	mv	s7,s1
      state = 0;
 5d2:	4981                	li	s3,0
 5d4:	bdd5                	j	4c8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d6:	008b8493          	addi	s1,s7,8
 5da:	4685                	li	a3,1
 5dc:	4629                	li	a2,10
 5de:	000bb583          	ld	a1,0(s7)
 5e2:	855a                	mv	a0,s6
 5e4:	df9ff0ef          	jal	3dc <printint>
        i += 2;
 5e8:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5ea:	8ba6                	mv	s7,s1
      state = 0;
 5ec:	4981                	li	s3,0
        i += 2;
 5ee:	bde9                	j	4c8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 5f0:	008b8493          	addi	s1,s7,8
 5f4:	4681                	li	a3,0
 5f6:	4629                	li	a2,10
 5f8:	000be583          	lwu	a1,0(s7)
 5fc:	855a                	mv	a0,s6
 5fe:	ddfff0ef          	jal	3dc <printint>
 602:	8ba6                	mv	s7,s1
      state = 0;
 604:	4981                	li	s3,0
 606:	b5c9                	j	4c8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 608:	008b8493          	addi	s1,s7,8
 60c:	4681                	li	a3,0
 60e:	4629                	li	a2,10
 610:	000bb583          	ld	a1,0(s7)
 614:	855a                	mv	a0,s6
 616:	dc7ff0ef          	jal	3dc <printint>
        i += 1;
 61a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 61c:	8ba6                	mv	s7,s1
      state = 0;
 61e:	4981                	li	s3,0
 620:	b565                	j	4c8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 622:	008b8493          	addi	s1,s7,8
 626:	4681                	li	a3,0
 628:	4629                	li	a2,10
 62a:	000bb583          	ld	a1,0(s7)
 62e:	855a                	mv	a0,s6
 630:	dadff0ef          	jal	3dc <printint>
        i += 2;
 634:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 636:	8ba6                	mv	s7,s1
      state = 0;
 638:	4981                	li	s3,0
        i += 2;
 63a:	b579                	j	4c8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 63c:	008b8493          	addi	s1,s7,8
 640:	4681                	li	a3,0
 642:	4641                	li	a2,16
 644:	000be583          	lwu	a1,0(s7)
 648:	855a                	mv	a0,s6
 64a:	d93ff0ef          	jal	3dc <printint>
 64e:	8ba6                	mv	s7,s1
      state = 0;
 650:	4981                	li	s3,0
 652:	bd9d                	j	4c8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 654:	008b8493          	addi	s1,s7,8
 658:	4681                	li	a3,0
 65a:	4641                	li	a2,16
 65c:	000bb583          	ld	a1,0(s7)
 660:	855a                	mv	a0,s6
 662:	d7bff0ef          	jal	3dc <printint>
        i += 1;
 666:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 668:	8ba6                	mv	s7,s1
      state = 0;
 66a:	4981                	li	s3,0
 66c:	bdb1                	j	4c8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 66e:	008b8493          	addi	s1,s7,8
 672:	4641                	li	a2,16
 674:	000bb583          	ld	a1,0(s7)
 678:	855a                	mv	a0,s6
 67a:	d63ff0ef          	jal	3dc <printint>
        i += 2;
 67e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 680:	8ba6                	mv	s7,s1
      state = 0;
 682:	4981                	li	s3,0
        i += 2;
 684:	b591                	j	4c8 <vprintf+0x44>
 686:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 688:	008b8793          	addi	a5,s7,8
 68c:	8cbe                	mv	s9,a5
 68e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 692:	03000593          	li	a1,48
 696:	855a                	mv	a0,s6
 698:	d27ff0ef          	jal	3be <putc>
  putc(fd, 'x');
 69c:	07800593          	li	a1,120
 6a0:	855a                	mv	a0,s6
 6a2:	d1dff0ef          	jal	3be <putc>
 6a6:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6a8:	00000b97          	auipc	s7,0x0
 6ac:	2c8b8b93          	addi	s7,s7,712 # 970 <digits>
 6b0:	03c9d793          	srli	a5,s3,0x3c
 6b4:	97de                	add	a5,a5,s7
 6b6:	0007c583          	lbu	a1,0(a5)
 6ba:	855a                	mv	a0,s6
 6bc:	d03ff0ef          	jal	3be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6c0:	0992                	slli	s3,s3,0x4
 6c2:	34fd                	addiw	s1,s1,-1
 6c4:	f4f5                	bnez	s1,6b0 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 6c6:	8be6                	mv	s7,s9
      state = 0;
 6c8:	4981                	li	s3,0
 6ca:	6ca2                	ld	s9,8(sp)
 6cc:	bbf5                	j	4c8 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 6ce:	008b8493          	addi	s1,s7,8
 6d2:	000bc583          	lbu	a1,0(s7)
 6d6:	855a                	mv	a0,s6
 6d8:	ce7ff0ef          	jal	3be <putc>
 6dc:	8ba6                	mv	s7,s1
      state = 0;
 6de:	4981                	li	s3,0
 6e0:	b3e5                	j	4c8 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 6e2:	008b8993          	addi	s3,s7,8
 6e6:	000bb483          	ld	s1,0(s7)
 6ea:	cc91                	beqz	s1,706 <vprintf+0x282>
        for(; *s; s++)
 6ec:	0004c583          	lbu	a1,0(s1)
 6f0:	c195                	beqz	a1,714 <vprintf+0x290>
          putc(fd, *s);
 6f2:	855a                	mv	a0,s6
 6f4:	ccbff0ef          	jal	3be <putc>
        for(; *s; s++)
 6f8:	0485                	addi	s1,s1,1
 6fa:	0004c583          	lbu	a1,0(s1)
 6fe:	f9f5                	bnez	a1,6f2 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 700:	8bce                	mv	s7,s3
      state = 0;
 702:	4981                	li	s3,0
 704:	b3d1                	j	4c8 <vprintf+0x44>
          s = "(null)";
 706:	00000497          	auipc	s1,0x0
 70a:	26248493          	addi	s1,s1,610 # 968 <malloc+0x130>
        for(; *s; s++)
 70e:	02800593          	li	a1,40
 712:	b7c5                	j	6f2 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 714:	8bce                	mv	s7,s3
      state = 0;
 716:	4981                	li	s3,0
 718:	bb45                	j	4c8 <vprintf+0x44>
        putc(fd, '%');
 71a:	85be                	mv	a1,a5
 71c:	855a                	mv	a0,s6
 71e:	ca1ff0ef          	jal	3be <putc>
 722:	bdbd                	j	5a0 <vprintf+0x11c>
 724:	6906                	ld	s2,64(sp)
 726:	79e2                	ld	s3,56(sp)
 728:	7a42                	ld	s4,48(sp)
 72a:	7aa2                	ld	s5,40(sp)
 72c:	7b02                	ld	s6,32(sp)
 72e:	6be2                	ld	s7,24(sp)
 730:	6c42                	ld	s8,16(sp)
    }
  }
}
 732:	60e6                	ld	ra,88(sp)
 734:	6446                	ld	s0,80(sp)
 736:	64a6                	ld	s1,72(sp)
 738:	6125                	addi	sp,sp,96
 73a:	8082                	ret
      if(c0 == 'd'){
 73c:	06400713          	li	a4,100
 740:	e6e782e3          	beq	a5,a4,5a4 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 744:	f9478693          	addi	a3,a5,-108
 748:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 74c:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 74e:	4701                	li	a4,0
 750:	bbe9                	j	52a <vprintf+0xa6>

0000000000000752 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 752:	715d                	addi	sp,sp,-80
 754:	ec06                	sd	ra,24(sp)
 756:	e822                	sd	s0,16(sp)
 758:	1000                	addi	s0,sp,32
 75a:	e010                	sd	a2,0(s0)
 75c:	e414                	sd	a3,8(s0)
 75e:	e818                	sd	a4,16(s0)
 760:	ec1c                	sd	a5,24(s0)
 762:	03043023          	sd	a6,32(s0)
 766:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 76a:	8622                	mv	a2,s0
 76c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 770:	d15ff0ef          	jal	484 <vprintf>
}
 774:	60e2                	ld	ra,24(sp)
 776:	6442                	ld	s0,16(sp)
 778:	6161                	addi	sp,sp,80
 77a:	8082                	ret

000000000000077c <printf>:

void
printf(const char *fmt, ...)
{
 77c:	711d                	addi	sp,sp,-96
 77e:	ec06                	sd	ra,24(sp)
 780:	e822                	sd	s0,16(sp)
 782:	1000                	addi	s0,sp,32
 784:	e40c                	sd	a1,8(s0)
 786:	e810                	sd	a2,16(s0)
 788:	ec14                	sd	a3,24(s0)
 78a:	f018                	sd	a4,32(s0)
 78c:	f41c                	sd	a5,40(s0)
 78e:	03043823          	sd	a6,48(s0)
 792:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 796:	00840613          	addi	a2,s0,8
 79a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 79e:	85aa                	mv	a1,a0
 7a0:	4505                	li	a0,1
 7a2:	ce3ff0ef          	jal	484 <vprintf>
}
 7a6:	60e2                	ld	ra,24(sp)
 7a8:	6442                	ld	s0,16(sp)
 7aa:	6125                	addi	sp,sp,96
 7ac:	8082                	ret

00000000000007ae <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7ae:	1141                	addi	sp,sp,-16
 7b0:	e406                	sd	ra,8(sp)
 7b2:	e022                	sd	s0,0(sp)
 7b4:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7b6:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ba:	00001797          	auipc	a5,0x1
 7be:	8467b783          	ld	a5,-1978(a5) # 1000 <freep>
 7c2:	a095                	j	826 <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7c4:	ff852583          	lw	a1,-8(a0)
 7c8:	6390                	ld	a2,0(a5)
 7ca:	02059813          	slli	a6,a1,0x20
 7ce:	01c85693          	srli	a3,a6,0x1c
 7d2:	96ba                	add	a3,a3,a4
 7d4:	02d60563          	beq	a2,a3,7fe <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7d8:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7dc:	4790                	lw	a2,8(a5)
 7de:	02061593          	slli	a1,a2,0x20
 7e2:	01c5d693          	srli	a3,a1,0x1c
 7e6:	96be                	add	a3,a3,a5
 7e8:	02d70263          	beq	a4,a3,80c <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7ec:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7ee:	00001717          	auipc	a4,0x1
 7f2:	80f73923          	sd	a5,-2030(a4) # 1000 <freep>
}
 7f6:	60a2                	ld	ra,8(sp)
 7f8:	6402                	ld	s0,0(sp)
 7fa:	0141                	addi	sp,sp,16
 7fc:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 7fe:	4614                	lw	a3,8(a2)
 800:	9ead                	addw	a3,a3,a1
 802:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 806:	6394                	ld	a3,0(a5)
 808:	6290                	ld	a2,0(a3)
 80a:	b7f9                	j	7d8 <free+0x2a>
    p->s.size += bp->s.size;
 80c:	ff852703          	lw	a4,-8(a0)
 810:	9f31                	addw	a4,a4,a2
 812:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 814:	ff053703          	ld	a4,-16(a0)
 818:	bfd1                	j	7ec <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 81a:	6394                	ld	a3,0(a5)
 81c:	00d7e463          	bltu	a5,a3,824 <free+0x76>
 820:	fad762e3          	bltu	a4,a3,7c4 <free+0x16>
 824:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 826:	fee7fae3          	bgeu	a5,a4,81a <free+0x6c>
 82a:	6394                	ld	a3,0(a5)
 82c:	f8d76ce3          	bltu	a4,a3,7c4 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 830:	f8d7fae3          	bgeu	a5,a3,7c4 <free+0x16>
 834:	87b6                	mv	a5,a3
 836:	bfc5                	j	826 <free+0x78>

0000000000000838 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 838:	7139                	addi	sp,sp,-64
 83a:	fc06                	sd	ra,56(sp)
 83c:	f822                	sd	s0,48(sp)
 83e:	f04a                	sd	s2,32(sp)
 840:	ec4e                	sd	s3,24(sp)
 842:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 844:	02051993          	slli	s3,a0,0x20
 848:	0209d993          	srli	s3,s3,0x20
 84c:	09bd                	addi	s3,s3,15
 84e:	0049d993          	srli	s3,s3,0x4
 852:	2985                	addiw	s3,s3,1
 854:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 856:	00000517          	auipc	a0,0x0
 85a:	7aa53503          	ld	a0,1962(a0) # 1000 <freep>
 85e:	c905                	beqz	a0,88e <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 860:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 862:	4798                	lw	a4,8(a5)
 864:	09377663          	bgeu	a4,s3,8f0 <malloc+0xb8>
 868:	f426                	sd	s1,40(sp)
 86a:	e852                	sd	s4,16(sp)
 86c:	e456                	sd	s5,8(sp)
 86e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 870:	8a4e                	mv	s4,s3
 872:	6705                	lui	a4,0x1
 874:	00e9f363          	bgeu	s3,a4,87a <malloc+0x42>
 878:	6a05                	lui	s4,0x1
 87a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 87e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 882:	00000497          	auipc	s1,0x0
 886:	77e48493          	addi	s1,s1,1918 # 1000 <freep>
  if(p == SBRK_ERROR)
 88a:	5afd                	li	s5,-1
 88c:	a83d                	j	8ca <malloc+0x92>
 88e:	f426                	sd	s1,40(sp)
 890:	e852                	sd	s4,16(sp)
 892:	e456                	sd	s5,8(sp)
 894:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 896:	00000797          	auipc	a5,0x0
 89a:	77a78793          	addi	a5,a5,1914 # 1010 <base>
 89e:	00000717          	auipc	a4,0x0
 8a2:	76f73123          	sd	a5,1890(a4) # 1000 <freep>
 8a6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8a8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8ac:	b7d1                	j	870 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8ae:	6398                	ld	a4,0(a5)
 8b0:	e118                	sd	a4,0(a0)
 8b2:	a899                	j	908 <malloc+0xd0>
  hp->s.size = nu;
 8b4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8b8:	0541                	addi	a0,a0,16
 8ba:	ef5ff0ef          	jal	7ae <free>
  return freep;
 8be:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8c0:	c125                	beqz	a0,920 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8c4:	4798                	lw	a4,8(a5)
 8c6:	03277163          	bgeu	a4,s2,8e8 <malloc+0xb0>
    if(p == freep)
 8ca:	6098                	ld	a4,0(s1)
 8cc:	853e                	mv	a0,a5
 8ce:	fef71ae3          	bne	a4,a5,8c2 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 8d2:	8552                	mv	a0,s4
 8d4:	a17ff0ef          	jal	2ea <sbrk>
  if(p == SBRK_ERROR)
 8d8:	fd551ee3          	bne	a0,s5,8b4 <malloc+0x7c>
        return 0;
 8dc:	4501                	li	a0,0
 8de:	74a2                	ld	s1,40(sp)
 8e0:	6a42                	ld	s4,16(sp)
 8e2:	6aa2                	ld	s5,8(sp)
 8e4:	6b02                	ld	s6,0(sp)
 8e6:	a03d                	j	914 <malloc+0xdc>
 8e8:	74a2                	ld	s1,40(sp)
 8ea:	6a42                	ld	s4,16(sp)
 8ec:	6aa2                	ld	s5,8(sp)
 8ee:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8f0:	fae90fe3          	beq	s2,a4,8ae <malloc+0x76>
        p->s.size -= nunits;
 8f4:	4137073b          	subw	a4,a4,s3
 8f8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8fa:	02071693          	slli	a3,a4,0x20
 8fe:	01c6d713          	srli	a4,a3,0x1c
 902:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 904:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 908:	00000717          	auipc	a4,0x0
 90c:	6ea73c23          	sd	a0,1784(a4) # 1000 <freep>
      return (void*)(p + 1);
 910:	01078513          	addi	a0,a5,16
  }
}
 914:	70e2                	ld	ra,56(sp)
 916:	7442                	ld	s0,48(sp)
 918:	7902                	ld	s2,32(sp)
 91a:	69e2                	ld	s3,24(sp)
 91c:	6121                	addi	sp,sp,64
 91e:	8082                	ret
 920:	74a2                	ld	s1,40(sp)
 922:	6a42                	ld	s4,16(sp)
 924:	6aa2                	ld	s5,8(sp)
 926:	6b02                	ld	s6,0(sp)
 928:	b7f5                	j	914 <malloc+0xdc>
