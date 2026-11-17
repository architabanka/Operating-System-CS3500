
user/_uptime:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int 
main(int argc, char *argv[]){
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    if(argc!=1){
   8:	4785                	li	a5,1
   a:	00f50c63          	beq	a0,a5,22 <main+0x22>
        fprintf(2,"Usage : uptime\n");
   e:	00001597          	auipc	a1,0x1
  12:	8f258593          	addi	a1,a1,-1806 # 900 <malloc+0xf4>
  16:	4509                	li	a0,2
  18:	70e000ef          	jal	726 <fprintf>
        exit(1);
  1c:	4505                	li	a0,1
  1e:	2d4000ef          	jal	2f2 <exit>
    }
    printf("Uptime : %d ticks\n",uptime());
  22:	368000ef          	jal	38a <uptime>
  26:	85aa                	mv	a1,a0
  28:	00001517          	auipc	a0,0x1
  2c:	8e850513          	addi	a0,a0,-1816 # 910 <malloc+0x104>
  30:	720000ef          	jal	750 <printf>
    exit(0);
  34:	4501                	li	a0,0
  36:	2bc000ef          	jal	2f2 <exit>

000000000000003a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  3a:	1141                	addi	sp,sp,-16
  3c:	e406                	sd	ra,8(sp)
  3e:	e022                	sd	s0,0(sp)
  40:	0800                	addi	s0,sp,16
  extern int main();
  main();
  42:	fbfff0ef          	jal	0 <main>
  exit(0);
  46:	4501                	li	a0,0
  48:	2aa000ef          	jal	2f2 <exit>

000000000000004c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  4c:	1141                	addi	sp,sp,-16
  4e:	e406                	sd	ra,8(sp)
  50:	e022                	sd	s0,0(sp)
  52:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  54:	87aa                	mv	a5,a0
  56:	0585                	addi	a1,a1,1
  58:	0785                	addi	a5,a5,1
  5a:	fff5c703          	lbu	a4,-1(a1)
  5e:	fee78fa3          	sb	a4,-1(a5)
  62:	fb75                	bnez	a4,56 <strcpy+0xa>
    ;
  return os;
}
  64:	60a2                	ld	ra,8(sp)
  66:	6402                	ld	s0,0(sp)
  68:	0141                	addi	sp,sp,16
  6a:	8082                	ret

000000000000006c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  6c:	1141                	addi	sp,sp,-16
  6e:	e406                	sd	ra,8(sp)
  70:	e022                	sd	s0,0(sp)
  72:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  74:	00054783          	lbu	a5,0(a0)
  78:	cb91                	beqz	a5,8c <strcmp+0x20>
  7a:	0005c703          	lbu	a4,0(a1)
  7e:	00f71763          	bne	a4,a5,8c <strcmp+0x20>
    p++, q++;
  82:	0505                	addi	a0,a0,1
  84:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  86:	00054783          	lbu	a5,0(a0)
  8a:	fbe5                	bnez	a5,7a <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  8c:	0005c503          	lbu	a0,0(a1)
}
  90:	40a7853b          	subw	a0,a5,a0
  94:	60a2                	ld	ra,8(sp)
  96:	6402                	ld	s0,0(sp)
  98:	0141                	addi	sp,sp,16
  9a:	8082                	ret

000000000000009c <strlen>:

uint
strlen(const char *s)
{
  9c:	1141                	addi	sp,sp,-16
  9e:	e406                	sd	ra,8(sp)
  a0:	e022                	sd	s0,0(sp)
  a2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  a4:	00054783          	lbu	a5,0(a0)
  a8:	cf91                	beqz	a5,c4 <strlen+0x28>
  aa:	00150793          	addi	a5,a0,1
  ae:	86be                	mv	a3,a5
  b0:	0785                	addi	a5,a5,1
  b2:	fff7c703          	lbu	a4,-1(a5)
  b6:	ff65                	bnez	a4,ae <strlen+0x12>
  b8:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  bc:	60a2                	ld	ra,8(sp)
  be:	6402                	ld	s0,0(sp)
  c0:	0141                	addi	sp,sp,16
  c2:	8082                	ret
  for(n = 0; s[n]; n++)
  c4:	4501                	li	a0,0
  c6:	bfdd                	j	bc <strlen+0x20>

00000000000000c8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  c8:	1141                	addi	sp,sp,-16
  ca:	e406                	sd	ra,8(sp)
  cc:	e022                	sd	s0,0(sp)
  ce:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  d0:	ca19                	beqz	a2,e6 <memset+0x1e>
  d2:	87aa                	mv	a5,a0
  d4:	1602                	slli	a2,a2,0x20
  d6:	9201                	srli	a2,a2,0x20
  d8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  dc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  e0:	0785                	addi	a5,a5,1
  e2:	fee79de3          	bne	a5,a4,dc <memset+0x14>
  }
  return dst;
}
  e6:	60a2                	ld	ra,8(sp)
  e8:	6402                	ld	s0,0(sp)
  ea:	0141                	addi	sp,sp,16
  ec:	8082                	ret

00000000000000ee <strchr>:

char*
strchr(const char *s, char c)
{
  ee:	1141                	addi	sp,sp,-16
  f0:	e406                	sd	ra,8(sp)
  f2:	e022                	sd	s0,0(sp)
  f4:	0800                	addi	s0,sp,16
  for(; *s; s++)
  f6:	00054783          	lbu	a5,0(a0)
  fa:	c799                	beqz	a5,108 <strchr+0x1a>
    if(*s == c)
  fc:	00f58763          	beq	a1,a5,10a <strchr+0x1c>
  for(; *s; s++)
 100:	0505                	addi	a0,a0,1
 102:	00054783          	lbu	a5,0(a0)
 106:	fbfd                	bnez	a5,fc <strchr+0xe>
      return (char*)s;
  return 0;
 108:	4501                	li	a0,0
}
 10a:	60a2                	ld	ra,8(sp)
 10c:	6402                	ld	s0,0(sp)
 10e:	0141                	addi	sp,sp,16
 110:	8082                	ret

0000000000000112 <gets>:

char*
gets(char *buf, int max)
{
 112:	711d                	addi	sp,sp,-96
 114:	ec86                	sd	ra,88(sp)
 116:	e8a2                	sd	s0,80(sp)
 118:	e4a6                	sd	s1,72(sp)
 11a:	e0ca                	sd	s2,64(sp)
 11c:	fc4e                	sd	s3,56(sp)
 11e:	f852                	sd	s4,48(sp)
 120:	f456                	sd	s5,40(sp)
 122:	f05a                	sd	s6,32(sp)
 124:	ec5e                	sd	s7,24(sp)
 126:	e862                	sd	s8,16(sp)
 128:	1080                	addi	s0,sp,96
 12a:	8baa                	mv	s7,a0
 12c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 12e:	892a                	mv	s2,a0
 130:	4481                	li	s1,0
    cc = read(0, &c, 1);
 132:	faf40b13          	addi	s6,s0,-81
 136:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 138:	8c26                	mv	s8,s1
 13a:	0014899b          	addiw	s3,s1,1
 13e:	84ce                	mv	s1,s3
 140:	0349d863          	bge	s3,s4,170 <gets+0x5e>
    cc = read(0, &c, 1);
 144:	8656                	mv	a2,s5
 146:	85da                	mv	a1,s6
 148:	4501                	li	a0,0
 14a:	1c0000ef          	jal	30a <read>
    if(cc < 1)
 14e:	02a05163          	blez	a0,170 <gets+0x5e>
      break;
    buf[i++] = c;
 152:	faf44783          	lbu	a5,-81(s0)
 156:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 15a:	0905                	addi	s2,s2,1
 15c:	ff678713          	addi	a4,a5,-10
 160:	00173713          	seqz	a4,a4
 164:	17cd                	addi	a5,a5,-13
 166:	0017b793          	seqz	a5,a5
 16a:	8fd9                	or	a5,a5,a4
 16c:	d7f1                	beqz	a5,138 <gets+0x26>
    buf[i++] = c;
 16e:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 170:	9c5e                	add	s8,s8,s7
 172:	000c0023          	sb	zero,0(s8)
  return buf;
}
 176:	855e                	mv	a0,s7
 178:	60e6                	ld	ra,88(sp)
 17a:	6446                	ld	s0,80(sp)
 17c:	64a6                	ld	s1,72(sp)
 17e:	6906                	ld	s2,64(sp)
 180:	79e2                	ld	s3,56(sp)
 182:	7a42                	ld	s4,48(sp)
 184:	7aa2                	ld	s5,40(sp)
 186:	7b02                	ld	s6,32(sp)
 188:	6be2                	ld	s7,24(sp)
 18a:	6c42                	ld	s8,16(sp)
 18c:	6125                	addi	sp,sp,96
 18e:	8082                	ret

0000000000000190 <stat>:

int
stat(const char *n, struct stat *st)
{
 190:	1101                	addi	sp,sp,-32
 192:	ec06                	sd	ra,24(sp)
 194:	e822                	sd	s0,16(sp)
 196:	e04a                	sd	s2,0(sp)
 198:	1000                	addi	s0,sp,32
 19a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 19c:	4581                	li	a1,0
 19e:	194000ef          	jal	332 <open>
  if(fd < 0)
 1a2:	02054263          	bltz	a0,1c6 <stat+0x36>
 1a6:	e426                	sd	s1,8(sp)
 1a8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1aa:	85ca                	mv	a1,s2
 1ac:	19e000ef          	jal	34a <fstat>
 1b0:	892a                	mv	s2,a0
  close(fd);
 1b2:	8526                	mv	a0,s1
 1b4:	166000ef          	jal	31a <close>
  return r;
 1b8:	64a2                	ld	s1,8(sp)
}
 1ba:	854a                	mv	a0,s2
 1bc:	60e2                	ld	ra,24(sp)
 1be:	6442                	ld	s0,16(sp)
 1c0:	6902                	ld	s2,0(sp)
 1c2:	6105                	addi	sp,sp,32
 1c4:	8082                	ret
    return -1;
 1c6:	57fd                	li	a5,-1
 1c8:	893e                	mv	s2,a5
 1ca:	bfc5                	j	1ba <stat+0x2a>

00000000000001cc <atoi>:

int
atoi(const char *s)
{
 1cc:	1141                	addi	sp,sp,-16
 1ce:	e406                	sd	ra,8(sp)
 1d0:	e022                	sd	s0,0(sp)
 1d2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d4:	00054683          	lbu	a3,0(a0)
 1d8:	fd06879b          	addiw	a5,a3,-48
 1dc:	0ff7f793          	zext.b	a5,a5
 1e0:	4625                	li	a2,9
 1e2:	02f66963          	bltu	a2,a5,214 <atoi+0x48>
 1e6:	872a                	mv	a4,a0
  n = 0;
 1e8:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1ea:	0705                	addi	a4,a4,1
 1ec:	0025179b          	slliw	a5,a0,0x2
 1f0:	9fa9                	addw	a5,a5,a0
 1f2:	0017979b          	slliw	a5,a5,0x1
 1f6:	9fb5                	addw	a5,a5,a3
 1f8:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1fc:	00074683          	lbu	a3,0(a4)
 200:	fd06879b          	addiw	a5,a3,-48
 204:	0ff7f793          	zext.b	a5,a5
 208:	fef671e3          	bgeu	a2,a5,1ea <atoi+0x1e>
  return n;
}
 20c:	60a2                	ld	ra,8(sp)
 20e:	6402                	ld	s0,0(sp)
 210:	0141                	addi	sp,sp,16
 212:	8082                	ret
  n = 0;
 214:	4501                	li	a0,0
 216:	bfdd                	j	20c <atoi+0x40>

0000000000000218 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 218:	1141                	addi	sp,sp,-16
 21a:	e406                	sd	ra,8(sp)
 21c:	e022                	sd	s0,0(sp)
 21e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 220:	02b57563          	bgeu	a0,a1,24a <memmove+0x32>
    while(n-- > 0)
 224:	00c05f63          	blez	a2,242 <memmove+0x2a>
 228:	1602                	slli	a2,a2,0x20
 22a:	9201                	srli	a2,a2,0x20
 22c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 230:	872a                	mv	a4,a0
      *dst++ = *src++;
 232:	0585                	addi	a1,a1,1
 234:	0705                	addi	a4,a4,1
 236:	fff5c683          	lbu	a3,-1(a1)
 23a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 23e:	fee79ae3          	bne	a5,a4,232 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 242:	60a2                	ld	ra,8(sp)
 244:	6402                	ld	s0,0(sp)
 246:	0141                	addi	sp,sp,16
 248:	8082                	ret
    while(n-- > 0)
 24a:	fec05ce3          	blez	a2,242 <memmove+0x2a>
    dst += n;
 24e:	00c50733          	add	a4,a0,a2
    src += n;
 252:	95b2                	add	a1,a1,a2
 254:	fff6079b          	addiw	a5,a2,-1
 258:	1782                	slli	a5,a5,0x20
 25a:	9381                	srli	a5,a5,0x20
 25c:	fff7c793          	not	a5,a5
 260:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 262:	15fd                	addi	a1,a1,-1
 264:	177d                	addi	a4,a4,-1
 266:	0005c683          	lbu	a3,0(a1)
 26a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 26e:	fef71ae3          	bne	a4,a5,262 <memmove+0x4a>
 272:	bfc1                	j	242 <memmove+0x2a>

0000000000000274 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 274:	1141                	addi	sp,sp,-16
 276:	e406                	sd	ra,8(sp)
 278:	e022                	sd	s0,0(sp)
 27a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 27c:	ce19                	beqz	a2,29a <memcmp+0x26>
 27e:	1602                	slli	a2,a2,0x20
 280:	9201                	srli	a2,a2,0x20
 282:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 286:	00054783          	lbu	a5,0(a0)
 28a:	0005c703          	lbu	a4,0(a1)
 28e:	00e79b63          	bne	a5,a4,2a4 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 292:	0505                	addi	a0,a0,1
    p2++;
 294:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 296:	fed518e3          	bne	a0,a3,286 <memcmp+0x12>
  }
  return 0;
 29a:	4501                	li	a0,0
}
 29c:	60a2                	ld	ra,8(sp)
 29e:	6402                	ld	s0,0(sp)
 2a0:	0141                	addi	sp,sp,16
 2a2:	8082                	ret
      return *p1 - *p2;
 2a4:	40e7853b          	subw	a0,a5,a4
 2a8:	bfd5                	j	29c <memcmp+0x28>

00000000000002aa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e406                	sd	ra,8(sp)
 2ae:	e022                	sd	s0,0(sp)
 2b0:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2b2:	f67ff0ef          	jal	218 <memmove>
}
 2b6:	60a2                	ld	ra,8(sp)
 2b8:	6402                	ld	s0,0(sp)
 2ba:	0141                	addi	sp,sp,16
 2bc:	8082                	ret

00000000000002be <sbrk>:

char *
sbrk(int n) {
 2be:	1141                	addi	sp,sp,-16
 2c0:	e406                	sd	ra,8(sp)
 2c2:	e022                	sd	s0,0(sp)
 2c4:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2c6:	4585                	li	a1,1
 2c8:	0b2000ef          	jal	37a <sys_sbrk>
}
 2cc:	60a2                	ld	ra,8(sp)
 2ce:	6402                	ld	s0,0(sp)
 2d0:	0141                	addi	sp,sp,16
 2d2:	8082                	ret

00000000000002d4 <sbrklazy>:

char *
sbrklazy(int n) {
 2d4:	1141                	addi	sp,sp,-16
 2d6:	e406                	sd	ra,8(sp)
 2d8:	e022                	sd	s0,0(sp)
 2da:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 2dc:	4589                	li	a1,2
 2de:	09c000ef          	jal	37a <sys_sbrk>
}
 2e2:	60a2                	ld	ra,8(sp)
 2e4:	6402                	ld	s0,0(sp)
 2e6:	0141                	addi	sp,sp,16
 2e8:	8082                	ret

00000000000002ea <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2ea:	4885                	li	a7,1
 ecall
 2ec:	00000073          	ecall
 ret
 2f0:	8082                	ret

00000000000002f2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2f2:	4889                	li	a7,2
 ecall
 2f4:	00000073          	ecall
 ret
 2f8:	8082                	ret

00000000000002fa <wait>:
.global wait
wait:
 li a7, SYS_wait
 2fa:	488d                	li	a7,3
 ecall
 2fc:	00000073          	ecall
 ret
 300:	8082                	ret

0000000000000302 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 302:	4891                	li	a7,4
 ecall
 304:	00000073          	ecall
 ret
 308:	8082                	ret

000000000000030a <read>:
.global read
read:
 li a7, SYS_read
 30a:	4895                	li	a7,5
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <write>:
.global write
write:
 li a7, SYS_write
 312:	48c1                	li	a7,16
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <close>:
.global close
close:
 li a7, SYS_close
 31a:	48d5                	li	a7,21
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <kill>:
.global kill
kill:
 li a7, SYS_kill
 322:	4899                	li	a7,6
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <exec>:
.global exec
exec:
 li a7, SYS_exec
 32a:	489d                	li	a7,7
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <open>:
.global open
open:
 li a7, SYS_open
 332:	48bd                	li	a7,15
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 33a:	48c5                	li	a7,17
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 342:	48c9                	li	a7,18
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 34a:	48a1                	li	a7,8
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <link>:
.global link
link:
 li a7, SYS_link
 352:	48cd                	li	a7,19
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 35a:	48d1                	li	a7,20
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 362:	48a5                	li	a7,9
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <dup>:
.global dup
dup:
 li a7, SYS_dup
 36a:	48a9                	li	a7,10
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 372:	48ad                	li	a7,11
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 37a:	48b1                	li	a7,12
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <pause>:
.global pause
pause:
 li a7, SYS_pause
 382:	48b5                	li	a7,13
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 38a:	48b9                	li	a7,14
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 392:	1101                	addi	sp,sp,-32
 394:	ec06                	sd	ra,24(sp)
 396:	e822                	sd	s0,16(sp)
 398:	1000                	addi	s0,sp,32
 39a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 39e:	4605                	li	a2,1
 3a0:	fef40593          	addi	a1,s0,-17
 3a4:	f6fff0ef          	jal	312 <write>
}
 3a8:	60e2                	ld	ra,24(sp)
 3aa:	6442                	ld	s0,16(sp)
 3ac:	6105                	addi	sp,sp,32
 3ae:	8082                	ret

00000000000003b0 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 3b0:	715d                	addi	sp,sp,-80
 3b2:	e486                	sd	ra,72(sp)
 3b4:	e0a2                	sd	s0,64(sp)
 3b6:	f84a                	sd	s2,48(sp)
 3b8:	f44e                	sd	s3,40(sp)
 3ba:	0880                	addi	s0,sp,80
 3bc:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3be:	00d036b3          	snez	a3,a3
 3c2:	03f5d793          	srli	a5,a1,0x3f
 3c6:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3c8:	0005871b          	sext.w	a4,a1
  neg = 0;
 3cc:	4301                	li	t1,0
  if(sgn && xx < 0){
 3ce:	c681                	beqz	a3,3d6 <printint+0x26>
    x = -xx;
 3d0:	40b0073b          	negw	a4,a1
    neg = 1;
 3d4:	4305                	li	t1,1
  }

  i = 0;
 3d6:	fb840993          	addi	s3,s0,-72
  neg = 0;
 3da:	85ce                	mv	a1,s3
  i = 0;
 3dc:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 3de:	00000817          	auipc	a6,0x0
 3e2:	55280813          	addi	a6,a6,1362 # 930 <digits>
 3e6:	88b6                	mv	a7,a3
 3e8:	0016851b          	addiw	a0,a3,1
 3ec:	86aa                	mv	a3,a0
 3ee:	02c777bb          	remuw	a5,a4,a2
 3f2:	1782                	slli	a5,a5,0x20
 3f4:	9381                	srli	a5,a5,0x20
 3f6:	97c2                	add	a5,a5,a6
 3f8:	0007c783          	lbu	a5,0(a5)
 3fc:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 400:	87ba                	mv	a5,a4
 402:	02c7573b          	divuw	a4,a4,a2
 406:	0585                	addi	a1,a1,1
 408:	fcc7ffe3          	bgeu	a5,a2,3e6 <printint+0x36>
  if(neg)
 40c:	00030b63          	beqz	t1,422 <printint+0x72>
    buf[i++] = '-';
 410:	fd040793          	addi	a5,s0,-48
 414:	953e                	add	a0,a0,a5
 416:	02d00793          	li	a5,45
 41a:	fef50423          	sb	a5,-24(a0)
 41e:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 422:	02d05563          	blez	a3,44c <printint+0x9c>
 426:	fc26                	sd	s1,56(sp)
 428:	36fd                	addiw	a3,a3,-1
 42a:	00d984b3          	add	s1,s3,a3
 42e:	19fd                	addi	s3,s3,-1
 430:	99b6                	add	s3,s3,a3
 432:	1682                	slli	a3,a3,0x20
 434:	9281                	srli	a3,a3,0x20
 436:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 43a:	0004c583          	lbu	a1,0(s1)
 43e:	854a                	mv	a0,s2
 440:	f53ff0ef          	jal	392 <putc>
  while(--i >= 0)
 444:	14fd                	addi	s1,s1,-1
 446:	ff349ae3          	bne	s1,s3,43a <printint+0x8a>
 44a:	74e2                	ld	s1,56(sp)
}
 44c:	60a6                	ld	ra,72(sp)
 44e:	6406                	ld	s0,64(sp)
 450:	7942                	ld	s2,48(sp)
 452:	79a2                	ld	s3,40(sp)
 454:	6161                	addi	sp,sp,80
 456:	8082                	ret

0000000000000458 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 458:	711d                	addi	sp,sp,-96
 45a:	ec86                	sd	ra,88(sp)
 45c:	e8a2                	sd	s0,80(sp)
 45e:	e4a6                	sd	s1,72(sp)
 460:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 462:	0005c483          	lbu	s1,0(a1)
 466:	2a048063          	beqz	s1,706 <vprintf+0x2ae>
 46a:	e0ca                	sd	s2,64(sp)
 46c:	fc4e                	sd	s3,56(sp)
 46e:	f852                	sd	s4,48(sp)
 470:	f456                	sd	s5,40(sp)
 472:	f05a                	sd	s6,32(sp)
 474:	ec5e                	sd	s7,24(sp)
 476:	e862                	sd	s8,16(sp)
 478:	8b2a                	mv	s6,a0
 47a:	8a2e                	mv	s4,a1
 47c:	8bb2                	mv	s7,a2
  state = 0;
 47e:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 480:	4901                	li	s2,0
 482:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 484:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 488:	06400c13          	li	s8,100
 48c:	a00d                	j	4ae <vprintf+0x56>
        putc(fd, c0);
 48e:	85a6                	mv	a1,s1
 490:	855a                	mv	a0,s6
 492:	f01ff0ef          	jal	392 <putc>
 496:	a019                	j	49c <vprintf+0x44>
    } else if(state == '%'){
 498:	03598363          	beq	s3,s5,4be <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 49c:	0019079b          	addiw	a5,s2,1
 4a0:	893e                	mv	s2,a5
 4a2:	873e                	mv	a4,a5
 4a4:	97d2                	add	a5,a5,s4
 4a6:	0007c483          	lbu	s1,0(a5)
 4aa:	24048763          	beqz	s1,6f8 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 4ae:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4b2:	fe0993e3          	bnez	s3,498 <vprintf+0x40>
      if(c0 == '%'){
 4b6:	fd579ce3          	bne	a5,s5,48e <vprintf+0x36>
        state = '%';
 4ba:	89be                	mv	s3,a5
 4bc:	b7c5                	j	49c <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 4be:	00ea06b3          	add	a3,s4,a4
 4c2:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 4c6:	24060563          	beqz	a2,710 <vprintf+0x2b8>
      if(c0 == 'd'){
 4ca:	0b878763          	beq	a5,s8,578 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4ce:	f9478693          	addi	a3,a5,-108
 4d2:	0016b693          	seqz	a3,a3
 4d6:	f9c60593          	addi	a1,a2,-100
 4da:	0015b593          	seqz	a1,a1
 4de:	8df5                	and	a1,a1,a3
 4e0:	e9c5                	bnez	a1,590 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 4e2:	9752                	add	a4,a4,s4
 4e4:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 4e8:	f9460713          	addi	a4,a2,-108
 4ec:	00173713          	seqz	a4,a4
 4f0:	8f75                	and	a4,a4,a3
 4f2:	f9c50593          	addi	a1,a0,-100
 4f6:	0015b593          	seqz	a1,a1
 4fa:	8df9                	and	a1,a1,a4
 4fc:	e5dd                	bnez	a1,5aa <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 4fe:	07500593          	li	a1,117
 502:	0cb78163          	beq	a5,a1,5c4 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 506:	f8b60593          	addi	a1,a2,-117
 50a:	0015b593          	seqz	a1,a1
 50e:	8df5                	and	a1,a1,a3
 510:	e5f1                	bnez	a1,5dc <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 512:	f8b50593          	addi	a1,a0,-117
 516:	0015b593          	seqz	a1,a1
 51a:	8df9                	and	a1,a1,a4
 51c:	ede9                	bnez	a1,5f6 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 51e:	07800593          	li	a1,120
 522:	0eb78763          	beq	a5,a1,610 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 526:	f8860613          	addi	a2,a2,-120
 52a:	00163613          	seqz	a2,a2
 52e:	8ef1                	and	a3,a3,a2
 530:	0e069c63          	bnez	a3,628 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 534:	f8850513          	addi	a0,a0,-120
 538:	00153513          	seqz	a0,a0
 53c:	8f69                	and	a4,a4,a0
 53e:	10071263          	bnez	a4,642 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 542:	07000713          	li	a4,112
 546:	10e78a63          	beq	a5,a4,65a <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 54a:	06300713          	li	a4,99
 54e:	14e78a63          	beq	a5,a4,6a2 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 552:	07300713          	li	a4,115
 556:	16e78063          	beq	a5,a4,6b6 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 55a:	02500713          	li	a4,37
 55e:	18e78863          	beq	a5,a4,6ee <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 562:	02500593          	li	a1,37
 566:	855a                	mv	a0,s6
 568:	e2bff0ef          	jal	392 <putc>
        putc(fd, c0);
 56c:	85a6                	mv	a1,s1
 56e:	855a                	mv	a0,s6
 570:	e23ff0ef          	jal	392 <putc>
      }

      state = 0;
 574:	4981                	li	s3,0
 576:	b71d                	j	49c <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 578:	008b8493          	addi	s1,s7,8
 57c:	4685                	li	a3,1
 57e:	4629                	li	a2,10
 580:	000ba583          	lw	a1,0(s7)
 584:	855a                	mv	a0,s6
 586:	e2bff0ef          	jal	3b0 <printint>
 58a:	8ba6                	mv	s7,s1
      state = 0;
 58c:	4981                	li	s3,0
 58e:	b739                	j	49c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 590:	008b8493          	addi	s1,s7,8
 594:	4685                	li	a3,1
 596:	4629                	li	a2,10
 598:	000bb583          	ld	a1,0(s7)
 59c:	855a                	mv	a0,s6
 59e:	e13ff0ef          	jal	3b0 <printint>
        i += 1;
 5a2:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5a4:	8ba6                	mv	s7,s1
      state = 0;
 5a6:	4981                	li	s3,0
 5a8:	bdd5                	j	49c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5aa:	008b8493          	addi	s1,s7,8
 5ae:	4685                	li	a3,1
 5b0:	4629                	li	a2,10
 5b2:	000bb583          	ld	a1,0(s7)
 5b6:	855a                	mv	a0,s6
 5b8:	df9ff0ef          	jal	3b0 <printint>
        i += 2;
 5bc:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5be:	8ba6                	mv	s7,s1
      state = 0;
 5c0:	4981                	li	s3,0
        i += 2;
 5c2:	bde9                	j	49c <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 5c4:	008b8493          	addi	s1,s7,8
 5c8:	4681                	li	a3,0
 5ca:	4629                	li	a2,10
 5cc:	000be583          	lwu	a1,0(s7)
 5d0:	855a                	mv	a0,s6
 5d2:	ddfff0ef          	jal	3b0 <printint>
 5d6:	8ba6                	mv	s7,s1
      state = 0;
 5d8:	4981                	li	s3,0
 5da:	b5c9                	j	49c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5dc:	008b8493          	addi	s1,s7,8
 5e0:	4681                	li	a3,0
 5e2:	4629                	li	a2,10
 5e4:	000bb583          	ld	a1,0(s7)
 5e8:	855a                	mv	a0,s6
 5ea:	dc7ff0ef          	jal	3b0 <printint>
        i += 1;
 5ee:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 5f0:	8ba6                	mv	s7,s1
      state = 0;
 5f2:	4981                	li	s3,0
 5f4:	b565                	j	49c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5f6:	008b8493          	addi	s1,s7,8
 5fa:	4681                	li	a3,0
 5fc:	4629                	li	a2,10
 5fe:	000bb583          	ld	a1,0(s7)
 602:	855a                	mv	a0,s6
 604:	dadff0ef          	jal	3b0 <printint>
        i += 2;
 608:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 60a:	8ba6                	mv	s7,s1
      state = 0;
 60c:	4981                	li	s3,0
        i += 2;
 60e:	b579                	j	49c <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 610:	008b8493          	addi	s1,s7,8
 614:	4681                	li	a3,0
 616:	4641                	li	a2,16
 618:	000be583          	lwu	a1,0(s7)
 61c:	855a                	mv	a0,s6
 61e:	d93ff0ef          	jal	3b0 <printint>
 622:	8ba6                	mv	s7,s1
      state = 0;
 624:	4981                	li	s3,0
 626:	bd9d                	j	49c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 628:	008b8493          	addi	s1,s7,8
 62c:	4681                	li	a3,0
 62e:	4641                	li	a2,16
 630:	000bb583          	ld	a1,0(s7)
 634:	855a                	mv	a0,s6
 636:	d7bff0ef          	jal	3b0 <printint>
        i += 1;
 63a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 63c:	8ba6                	mv	s7,s1
      state = 0;
 63e:	4981                	li	s3,0
 640:	bdb1                	j	49c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 642:	008b8493          	addi	s1,s7,8
 646:	4641                	li	a2,16
 648:	000bb583          	ld	a1,0(s7)
 64c:	855a                	mv	a0,s6
 64e:	d63ff0ef          	jal	3b0 <printint>
        i += 2;
 652:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 654:	8ba6                	mv	s7,s1
      state = 0;
 656:	4981                	li	s3,0
        i += 2;
 658:	b591                	j	49c <vprintf+0x44>
 65a:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 65c:	008b8793          	addi	a5,s7,8
 660:	8cbe                	mv	s9,a5
 662:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 666:	03000593          	li	a1,48
 66a:	855a                	mv	a0,s6
 66c:	d27ff0ef          	jal	392 <putc>
  putc(fd, 'x');
 670:	07800593          	li	a1,120
 674:	855a                	mv	a0,s6
 676:	d1dff0ef          	jal	392 <putc>
 67a:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 67c:	00000b97          	auipc	s7,0x0
 680:	2b4b8b93          	addi	s7,s7,692 # 930 <digits>
 684:	03c9d793          	srli	a5,s3,0x3c
 688:	97de                	add	a5,a5,s7
 68a:	0007c583          	lbu	a1,0(a5)
 68e:	855a                	mv	a0,s6
 690:	d03ff0ef          	jal	392 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 694:	0992                	slli	s3,s3,0x4
 696:	34fd                	addiw	s1,s1,-1
 698:	f4f5                	bnez	s1,684 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 69a:	8be6                	mv	s7,s9
      state = 0;
 69c:	4981                	li	s3,0
 69e:	6ca2                	ld	s9,8(sp)
 6a0:	bbf5                	j	49c <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 6a2:	008b8493          	addi	s1,s7,8
 6a6:	000bc583          	lbu	a1,0(s7)
 6aa:	855a                	mv	a0,s6
 6ac:	ce7ff0ef          	jal	392 <putc>
 6b0:	8ba6                	mv	s7,s1
      state = 0;
 6b2:	4981                	li	s3,0
 6b4:	b3e5                	j	49c <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 6b6:	008b8993          	addi	s3,s7,8
 6ba:	000bb483          	ld	s1,0(s7)
 6be:	cc91                	beqz	s1,6da <vprintf+0x282>
        for(; *s; s++)
 6c0:	0004c583          	lbu	a1,0(s1)
 6c4:	c195                	beqz	a1,6e8 <vprintf+0x290>
          putc(fd, *s);
 6c6:	855a                	mv	a0,s6
 6c8:	ccbff0ef          	jal	392 <putc>
        for(; *s; s++)
 6cc:	0485                	addi	s1,s1,1
 6ce:	0004c583          	lbu	a1,0(s1)
 6d2:	f9f5                	bnez	a1,6c6 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 6d4:	8bce                	mv	s7,s3
      state = 0;
 6d6:	4981                	li	s3,0
 6d8:	b3d1                	j	49c <vprintf+0x44>
          s = "(null)";
 6da:	00000497          	auipc	s1,0x0
 6de:	24e48493          	addi	s1,s1,590 # 928 <malloc+0x11c>
        for(; *s; s++)
 6e2:	02800593          	li	a1,40
 6e6:	b7c5                	j	6c6 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 6e8:	8bce                	mv	s7,s3
      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	bb45                	j	49c <vprintf+0x44>
        putc(fd, '%');
 6ee:	85be                	mv	a1,a5
 6f0:	855a                	mv	a0,s6
 6f2:	ca1ff0ef          	jal	392 <putc>
 6f6:	bdbd                	j	574 <vprintf+0x11c>
 6f8:	6906                	ld	s2,64(sp)
 6fa:	79e2                	ld	s3,56(sp)
 6fc:	7a42                	ld	s4,48(sp)
 6fe:	7aa2                	ld	s5,40(sp)
 700:	7b02                	ld	s6,32(sp)
 702:	6be2                	ld	s7,24(sp)
 704:	6c42                	ld	s8,16(sp)
    }
  }
}
 706:	60e6                	ld	ra,88(sp)
 708:	6446                	ld	s0,80(sp)
 70a:	64a6                	ld	s1,72(sp)
 70c:	6125                	addi	sp,sp,96
 70e:	8082                	ret
      if(c0 == 'd'){
 710:	06400713          	li	a4,100
 714:	e6e782e3          	beq	a5,a4,578 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 718:	f9478693          	addi	a3,a5,-108
 71c:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 720:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 722:	4701                	li	a4,0
 724:	bbe9                	j	4fe <vprintf+0xa6>

0000000000000726 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 726:	715d                	addi	sp,sp,-80
 728:	ec06                	sd	ra,24(sp)
 72a:	e822                	sd	s0,16(sp)
 72c:	1000                	addi	s0,sp,32
 72e:	e010                	sd	a2,0(s0)
 730:	e414                	sd	a3,8(s0)
 732:	e818                	sd	a4,16(s0)
 734:	ec1c                	sd	a5,24(s0)
 736:	03043023          	sd	a6,32(s0)
 73a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 73e:	8622                	mv	a2,s0
 740:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 744:	d15ff0ef          	jal	458 <vprintf>
}
 748:	60e2                	ld	ra,24(sp)
 74a:	6442                	ld	s0,16(sp)
 74c:	6161                	addi	sp,sp,80
 74e:	8082                	ret

0000000000000750 <printf>:

void
printf(const char *fmt, ...)
{
 750:	711d                	addi	sp,sp,-96
 752:	ec06                	sd	ra,24(sp)
 754:	e822                	sd	s0,16(sp)
 756:	1000                	addi	s0,sp,32
 758:	e40c                	sd	a1,8(s0)
 75a:	e810                	sd	a2,16(s0)
 75c:	ec14                	sd	a3,24(s0)
 75e:	f018                	sd	a4,32(s0)
 760:	f41c                	sd	a5,40(s0)
 762:	03043823          	sd	a6,48(s0)
 766:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 76a:	00840613          	addi	a2,s0,8
 76e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 772:	85aa                	mv	a1,a0
 774:	4505                	li	a0,1
 776:	ce3ff0ef          	jal	458 <vprintf>
}
 77a:	60e2                	ld	ra,24(sp)
 77c:	6442                	ld	s0,16(sp)
 77e:	6125                	addi	sp,sp,96
 780:	8082                	ret

0000000000000782 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 782:	1141                	addi	sp,sp,-16
 784:	e406                	sd	ra,8(sp)
 786:	e022                	sd	s0,0(sp)
 788:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 78a:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 78e:	00001797          	auipc	a5,0x1
 792:	8727b783          	ld	a5,-1934(a5) # 1000 <freep>
 796:	a095                	j	7fa <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 798:	ff852583          	lw	a1,-8(a0)
 79c:	6390                	ld	a2,0(a5)
 79e:	02059813          	slli	a6,a1,0x20
 7a2:	01c85693          	srli	a3,a6,0x1c
 7a6:	96ba                	add	a3,a3,a4
 7a8:	02d60563          	beq	a2,a3,7d2 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7ac:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7b0:	4790                	lw	a2,8(a5)
 7b2:	02061593          	slli	a1,a2,0x20
 7b6:	01c5d693          	srli	a3,a1,0x1c
 7ba:	96be                	add	a3,a3,a5
 7bc:	02d70263          	beq	a4,a3,7e0 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7c0:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7c2:	00001717          	auipc	a4,0x1
 7c6:	82f73f23          	sd	a5,-1986(a4) # 1000 <freep>
}
 7ca:	60a2                	ld	ra,8(sp)
 7cc:	6402                	ld	s0,0(sp)
 7ce:	0141                	addi	sp,sp,16
 7d0:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 7d2:	4614                	lw	a3,8(a2)
 7d4:	9ead                	addw	a3,a3,a1
 7d6:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7da:	6394                	ld	a3,0(a5)
 7dc:	6290                	ld	a2,0(a3)
 7de:	b7f9                	j	7ac <free+0x2a>
    p->s.size += bp->s.size;
 7e0:	ff852703          	lw	a4,-8(a0)
 7e4:	9f31                	addw	a4,a4,a2
 7e6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7e8:	ff053703          	ld	a4,-16(a0)
 7ec:	bfd1                	j	7c0 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ee:	6394                	ld	a3,0(a5)
 7f0:	00d7e463          	bltu	a5,a3,7f8 <free+0x76>
 7f4:	fad762e3          	bltu	a4,a3,798 <free+0x16>
 7f8:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7fa:	fee7fae3          	bgeu	a5,a4,7ee <free+0x6c>
 7fe:	6394                	ld	a3,0(a5)
 800:	f8d76ce3          	bltu	a4,a3,798 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 804:	f8d7fae3          	bgeu	a5,a3,798 <free+0x16>
 808:	87b6                	mv	a5,a3
 80a:	bfc5                	j	7fa <free+0x78>

000000000000080c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 80c:	7139                	addi	sp,sp,-64
 80e:	fc06                	sd	ra,56(sp)
 810:	f822                	sd	s0,48(sp)
 812:	f04a                	sd	s2,32(sp)
 814:	ec4e                	sd	s3,24(sp)
 816:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 818:	02051993          	slli	s3,a0,0x20
 81c:	0209d993          	srli	s3,s3,0x20
 820:	09bd                	addi	s3,s3,15
 822:	0049d993          	srli	s3,s3,0x4
 826:	2985                	addiw	s3,s3,1
 828:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 82a:	00000517          	auipc	a0,0x0
 82e:	7d653503          	ld	a0,2006(a0) # 1000 <freep>
 832:	c905                	beqz	a0,862 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 834:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 836:	4798                	lw	a4,8(a5)
 838:	09377663          	bgeu	a4,s3,8c4 <malloc+0xb8>
 83c:	f426                	sd	s1,40(sp)
 83e:	e852                	sd	s4,16(sp)
 840:	e456                	sd	s5,8(sp)
 842:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 844:	8a4e                	mv	s4,s3
 846:	6705                	lui	a4,0x1
 848:	00e9f363          	bgeu	s3,a4,84e <malloc+0x42>
 84c:	6a05                	lui	s4,0x1
 84e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 852:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 856:	00000497          	auipc	s1,0x0
 85a:	7aa48493          	addi	s1,s1,1962 # 1000 <freep>
  if(p == SBRK_ERROR)
 85e:	5afd                	li	s5,-1
 860:	a83d                	j	89e <malloc+0x92>
 862:	f426                	sd	s1,40(sp)
 864:	e852                	sd	s4,16(sp)
 866:	e456                	sd	s5,8(sp)
 868:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 86a:	00000797          	auipc	a5,0x0
 86e:	7a678793          	addi	a5,a5,1958 # 1010 <base>
 872:	00000717          	auipc	a4,0x0
 876:	78f73723          	sd	a5,1934(a4) # 1000 <freep>
 87a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 87c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 880:	b7d1                	j	844 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 882:	6398                	ld	a4,0(a5)
 884:	e118                	sd	a4,0(a0)
 886:	a899                	j	8dc <malloc+0xd0>
  hp->s.size = nu;
 888:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 88c:	0541                	addi	a0,a0,16
 88e:	ef5ff0ef          	jal	782 <free>
  return freep;
 892:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 894:	c125                	beqz	a0,8f4 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 896:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 898:	4798                	lw	a4,8(a5)
 89a:	03277163          	bgeu	a4,s2,8bc <malloc+0xb0>
    if(p == freep)
 89e:	6098                	ld	a4,0(s1)
 8a0:	853e                	mv	a0,a5
 8a2:	fef71ae3          	bne	a4,a5,896 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 8a6:	8552                	mv	a0,s4
 8a8:	a17ff0ef          	jal	2be <sbrk>
  if(p == SBRK_ERROR)
 8ac:	fd551ee3          	bne	a0,s5,888 <malloc+0x7c>
        return 0;
 8b0:	4501                	li	a0,0
 8b2:	74a2                	ld	s1,40(sp)
 8b4:	6a42                	ld	s4,16(sp)
 8b6:	6aa2                	ld	s5,8(sp)
 8b8:	6b02                	ld	s6,0(sp)
 8ba:	a03d                	j	8e8 <malloc+0xdc>
 8bc:	74a2                	ld	s1,40(sp)
 8be:	6a42                	ld	s4,16(sp)
 8c0:	6aa2                	ld	s5,8(sp)
 8c2:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8c4:	fae90fe3          	beq	s2,a4,882 <malloc+0x76>
        p->s.size -= nunits;
 8c8:	4137073b          	subw	a4,a4,s3
 8cc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8ce:	02071693          	slli	a3,a4,0x20
 8d2:	01c6d713          	srli	a4,a3,0x1c
 8d6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8d8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8dc:	00000717          	auipc	a4,0x0
 8e0:	72a73223          	sd	a0,1828(a4) # 1000 <freep>
      return (void*)(p + 1);
 8e4:	01078513          	addi	a0,a5,16
  }
}
 8e8:	70e2                	ld	ra,56(sp)
 8ea:	7442                	ld	s0,48(sp)
 8ec:	7902                	ld	s2,32(sp)
 8ee:	69e2                	ld	s3,24(sp)
 8f0:	6121                	addi	sp,sp,64
 8f2:	8082                	ret
 8f4:	74a2                	ld	s1,40(sp)
 8f6:	6a42                	ld	s4,16(sp)
 8f8:	6aa2                	ld	s5,8(sp)
 8fa:	6b02                	ld	s6,0(sp)
 8fc:	b7f5                	j	8e8 <malloc+0xdc>
