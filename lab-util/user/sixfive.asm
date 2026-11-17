
user/_sixfive:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fcntl.h"
#include "user/user.h"

int
main(int argc, char* argv[])
{
   0:	7175                	addi	sp,sp,-144
   2:	e506                	sd	ra,136(sp)
   4:	e122                	sd	s0,128(sp)
   6:	0900                	addi	s0,sp,144
    if(argc < 2){
   8:	4785                	li	a5,1
   a:	04a7d663          	bge	a5,a0,56 <main+0x56>
   e:	fca6                	sd	s1,120(sp)
  10:	f8ca                	sd	s2,112(sp)
  12:	f4ce                	sd	s3,104(sp)
  14:	f0d2                	sd	s4,96(sp)
  16:	ecd6                	sd	s5,88(sp)
  18:	e8da                	sd	s6,80(sp)
  1a:	e4de                	sd	s7,72(sp)
  1c:	e0e2                	sd	s8,64(sp)
  1e:	fc66                	sd	s9,56(sp)
  20:	f86a                	sd	s10,48(sp)
  22:	f46e                	sd	s11,40(sp)
  24:	00858c93          	addi	s9,a1,8
  28:	ffe5079b          	addiw	a5,a0,-2
  2c:	02079713          	slli	a4,a5,0x20
  30:	01d75793          	srli	a5,a4,0x1d
  34:	05c1                	addi	a1,a1,16
  36:	97ae                	add	a5,a5,a1
  38:	f6f43c23          	sd	a5,-136(s0)
        if(fd < 0){
            fprintf(2,"Invalid file.");
            exit(1);
        }
        char c;
        int num=0, valid=0, prevsep=1;
  3c:	4a05                	li	s4,1

        while (read(fd, &c, 1) == 1) {
  3e:	f8f40b93          	addi	s7,s0,-113
            if (c>='0'&&c<='9'){
  42:	4c25                	li	s8,9
                if(prevsep){
                    num=num*10+(c-'0');
                    valid=1;
                }
            }
            else if(strchr(" -\r\t\n./,", c)){
  44:	00001d17          	auipc	s10,0x1
  48:	a84d0d13          	addi	s10,s10,-1404 # ac8 <malloc+0x12c>
                if(valid&&prevsep) {
                    if((num%5==0) || (num%6==0)) 
  4c:	66666db7          	lui	s11,0x66666
  50:	667d8d93          	addi	s11,s11,1639 # 66666667 <base+0x66665657>
  54:	aaa1                	j	1ac <main+0x1ac>
  56:	fca6                	sd	s1,120(sp)
  58:	f8ca                	sd	s2,112(sp)
  5a:	f4ce                	sd	s3,104(sp)
  5c:	f0d2                	sd	s4,96(sp)
  5e:	ecd6                	sd	s5,88(sp)
  60:	e8da                	sd	s6,80(sp)
  62:	e4de                	sd	s7,72(sp)
  64:	e0e2                	sd	s8,64(sp)
  66:	fc66                	sd	s9,56(sp)
  68:	f86a                	sd	s10,48(sp)
  6a:	f46e                	sd	s11,40(sp)
        fprintf(2,"Incorrect Usage. Specify file name.");
  6c:	00001597          	auipc	a1,0x1
  70:	a2458593          	addi	a1,a1,-1500 # a90 <malloc+0xf4>
  74:	4509                	li	a0,2
  76:	041000ef          	jal	8b6 <fprintf>
        exit(1);
  7a:	4505                	li	a0,1
  7c:	406000ef          	jal	482 <exit>
            fprintf(2,"Invalid file.");
  80:	00001597          	auipc	a1,0x1
  84:	a3858593          	addi	a1,a1,-1480 # ab8 <malloc+0x11c>
  88:	4509                	li	a0,2
  8a:	02d000ef          	jal	8b6 <fprintf>
            exit(1);
  8e:	4505                	li	a0,1
  90:	3f2000ef          	jal	482 <exit>
            else if(strchr(" -\r\t\n./,", c)){
  94:	856a                	mv	a0,s10
  96:	1e8000ef          	jal	27e <strchr>
  9a:	cd51                	beqz	a0,136 <main+0x136>
                if(valid&&prevsep) {
  9c:	00197913          	andi	s2,s2,1
  a0:	012b7933          	and	s2,s6,s2
  a4:	04091363          	bnez	s2,ea <main+0xea>
                        printf("%d\n",num);
                }
                num=0;
                valid=0;
                prevsep=1;
  a8:	8926                	mv	s2,s1
                valid=0;
  aa:	4b01                	li	s6,0
                num=0;
  ac:	4981                	li	s3,0
        while (read(fd, &c, 1) == 1) {
  ae:	8652                	mv	a2,s4
  b0:	85de                	mv	a1,s7
  b2:	8556                	mv	a0,s5
  b4:	3e6000ef          	jal	49a <read>
  b8:	84aa                	mv	s1,a0
  ba:	09451663          	bne	a0,s4,146 <main+0x146>
            if (c>='0'&&c<='9'){
  be:	f8f44583          	lbu	a1,-113(s0)
  c2:	fd05879b          	addiw	a5,a1,-48
  c6:	0ff7f793          	zext.b	a5,a5
  ca:	fcfc65e3          	bltu	s8,a5,94 <main+0x94>
                if(prevsep){
  ce:	fe0900e3          	beqz	s2,ae <main+0xae>
                    num=num*10+(c-'0');
  d2:	0029979b          	slliw	a5,s3,0x2
  d6:	013787bb          	addw	a5,a5,s3
  da:	0017979b          	slliw	a5,a5,0x1
  de:	fd05859b          	addiw	a1,a1,-48
  e2:	00f589bb          	addw	s3,a1,a5
                    valid=1;
  e6:	8b4a                	mv	s6,s2
  e8:	b7d9                	j	ae <main+0xae>
                    if((num%5==0) || (num%6==0)) 
  ea:	03b987b3          	mul	a5,s3,s11
  ee:	9785                	srai	a5,a5,0x21
  f0:	41f9d71b          	sraiw	a4,s3,0x1f
  f4:	9f99                	subw	a5,a5,a4
  f6:	0027971b          	slliw	a4,a5,0x2
  fa:	9fb9                	addw	a5,a5,a4
  fc:	40f987bb          	subw	a5,s3,a5
 100:	c39d                	beqz	a5,126 <main+0x126>
 102:	2aaab7b7          	lui	a5,0x2aaab
 106:	aab78793          	addi	a5,a5,-1365 # 2aaaaaab <base+0x2aaa9a9b>
 10a:	02f987b3          	mul	a5,s3,a5
 10e:	9381                	srli	a5,a5,0x20
 110:	41f9d71b          	sraiw	a4,s3,0x1f
 114:	9f99                	subw	a5,a5,a4
 116:	0017971b          	slliw	a4,a5,0x1
 11a:	9fb9                	addw	a5,a5,a4
 11c:	0017979b          	slliw	a5,a5,0x1
 120:	40f987bb          	subw	a5,s3,a5
 124:	ef89                	bnez	a5,13e <main+0x13e>
                        printf("%d\n",num);
 126:	85ce                	mv	a1,s3
 128:	00001517          	auipc	a0,0x1
 12c:	9b050513          	addi	a0,a0,-1616 # ad8 <malloc+0x13c>
 130:	7b0000ef          	jal	8e0 <printf>
 134:	bf95                	j	a8 <main+0xa8>
            }
            else {
                valid=0;
                num=0;
                prevsep=0;
 136:	4901                	li	s2,0
                valid=0;
 138:	4b01                	li	s6,0
                num=0;
 13a:	4981                	li	s3,0
 13c:	bf8d                	j	ae <main+0xae>
                prevsep=1;
 13e:	8926                	mv	s2,s1
                valid=0;
 140:	4b01                	li	s6,0
                num=0;
 142:	4981                	li	s3,0
 144:	b7ad                	j	ae <main+0xae>
            }
        }
        if (prevsep && valid) {
 146:	001b7b13          	andi	s6,s6,1
 14a:	01697933          	and	s2,s2,s6
 14e:	04090763          	beqz	s2,19c <main+0x19c>
            if (num%5 == 0 || num%6 == 0)
 152:	03b987b3          	mul	a5,s3,s11
 156:	9785                	srai	a5,a5,0x21
 158:	41f9d71b          	sraiw	a4,s3,0x1f
 15c:	9f99                	subw	a5,a5,a4
 15e:	0027971b          	slliw	a4,a5,0x2
 162:	9fb9                	addw	a5,a5,a4
 164:	40f987bb          	subw	a5,s3,a5
 168:	c39d                	beqz	a5,18e <main+0x18e>
 16a:	2aaab7b7          	lui	a5,0x2aaab
 16e:	aab78793          	addi	a5,a5,-1365 # 2aaaaaab <base+0x2aaa9a9b>
 172:	02f987b3          	mul	a5,s3,a5
 176:	9381                	srli	a5,a5,0x20
 178:	41f9d71b          	sraiw	a4,s3,0x1f
 17c:	9f99                	subw	a5,a5,a4
 17e:	0017971b          	slliw	a4,a5,0x1
 182:	9fb9                	addw	a5,a5,a4
 184:	0017979b          	slliw	a5,a5,0x1
 188:	40f987bb          	subw	a5,s3,a5
 18c:	eb81                	bnez	a5,19c <main+0x19c>
                printf("%d\n", num);
 18e:	85ce                	mv	a1,s3
 190:	00001517          	auipc	a0,0x1
 194:	94850513          	addi	a0,a0,-1720 # ad8 <malloc+0x13c>
 198:	748000ef          	jal	8e0 <printf>
        }

        close (fd);
 19c:	8556                	mv	a0,s5
 19e:	30c000ef          	jal	4aa <close>
    for(int i=1;i<argc;i++){
 1a2:	0ca1                	addi	s9,s9,8
 1a4:	f7843783          	ld	a5,-136(s0)
 1a8:	00fc8e63          	beq	s9,a5,1c4 <main+0x1c4>
        int fd = open(argv[i],0);
 1ac:	4581                	li	a1,0
 1ae:	000cb503          	ld	a0,0(s9)
 1b2:	310000ef          	jal	4c2 <open>
 1b6:	8aaa                	mv	s5,a0
        if(fd < 0){
 1b8:	ec0544e3          	bltz	a0,80 <main+0x80>
        int num=0, valid=0, prevsep=1;
 1bc:	8952                	mv	s2,s4
 1be:	4b01                	li	s6,0
 1c0:	4981                	li	s3,0
 1c2:	b5f5                	j	ae <main+0xae>
    }
    exit (0);
 1c4:	4501                	li	a0,0
 1c6:	2bc000ef          	jal	482 <exit>

00000000000001ca <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 1ca:	1141                	addi	sp,sp,-16
 1cc:	e406                	sd	ra,8(sp)
 1ce:	e022                	sd	s0,0(sp)
 1d0:	0800                	addi	s0,sp,16
  extern int main();
  main();
 1d2:	e2fff0ef          	jal	0 <main>
  exit(0);
 1d6:	4501                	li	a0,0
 1d8:	2aa000ef          	jal	482 <exit>

00000000000001dc <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1dc:	1141                	addi	sp,sp,-16
 1de:	e406                	sd	ra,8(sp)
 1e0:	e022                	sd	s0,0(sp)
 1e2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1e4:	87aa                	mv	a5,a0
 1e6:	0585                	addi	a1,a1,1
 1e8:	0785                	addi	a5,a5,1
 1ea:	fff5c703          	lbu	a4,-1(a1)
 1ee:	fee78fa3          	sb	a4,-1(a5)
 1f2:	fb75                	bnez	a4,1e6 <strcpy+0xa>
    ;
  return os;
}
 1f4:	60a2                	ld	ra,8(sp)
 1f6:	6402                	ld	s0,0(sp)
 1f8:	0141                	addi	sp,sp,16
 1fa:	8082                	ret

00000000000001fc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1fc:	1141                	addi	sp,sp,-16
 1fe:	e406                	sd	ra,8(sp)
 200:	e022                	sd	s0,0(sp)
 202:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 204:	00054783          	lbu	a5,0(a0)
 208:	cb91                	beqz	a5,21c <strcmp+0x20>
 20a:	0005c703          	lbu	a4,0(a1)
 20e:	00f71763          	bne	a4,a5,21c <strcmp+0x20>
    p++, q++;
 212:	0505                	addi	a0,a0,1
 214:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 216:	00054783          	lbu	a5,0(a0)
 21a:	fbe5                	bnez	a5,20a <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 21c:	0005c503          	lbu	a0,0(a1)
}
 220:	40a7853b          	subw	a0,a5,a0
 224:	60a2                	ld	ra,8(sp)
 226:	6402                	ld	s0,0(sp)
 228:	0141                	addi	sp,sp,16
 22a:	8082                	ret

000000000000022c <strlen>:

uint
strlen(const char *s)
{
 22c:	1141                	addi	sp,sp,-16
 22e:	e406                	sd	ra,8(sp)
 230:	e022                	sd	s0,0(sp)
 232:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 234:	00054783          	lbu	a5,0(a0)
 238:	cf91                	beqz	a5,254 <strlen+0x28>
 23a:	00150793          	addi	a5,a0,1
 23e:	86be                	mv	a3,a5
 240:	0785                	addi	a5,a5,1
 242:	fff7c703          	lbu	a4,-1(a5)
 246:	ff65                	bnez	a4,23e <strlen+0x12>
 248:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 24c:	60a2                	ld	ra,8(sp)
 24e:	6402                	ld	s0,0(sp)
 250:	0141                	addi	sp,sp,16
 252:	8082                	ret
  for(n = 0; s[n]; n++)
 254:	4501                	li	a0,0
 256:	bfdd                	j	24c <strlen+0x20>

0000000000000258 <memset>:

void*
memset(void *dst, int c, uint n)
{
 258:	1141                	addi	sp,sp,-16
 25a:	e406                	sd	ra,8(sp)
 25c:	e022                	sd	s0,0(sp)
 25e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 260:	ca19                	beqz	a2,276 <memset+0x1e>
 262:	87aa                	mv	a5,a0
 264:	1602                	slli	a2,a2,0x20
 266:	9201                	srli	a2,a2,0x20
 268:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 26c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 270:	0785                	addi	a5,a5,1
 272:	fee79de3          	bne	a5,a4,26c <memset+0x14>
  }
  return dst;
}
 276:	60a2                	ld	ra,8(sp)
 278:	6402                	ld	s0,0(sp)
 27a:	0141                	addi	sp,sp,16
 27c:	8082                	ret

000000000000027e <strchr>:

char*
strchr(const char *s, char c)
{
 27e:	1141                	addi	sp,sp,-16
 280:	e406                	sd	ra,8(sp)
 282:	e022                	sd	s0,0(sp)
 284:	0800                	addi	s0,sp,16
  for(; *s; s++)
 286:	00054783          	lbu	a5,0(a0)
 28a:	c799                	beqz	a5,298 <strchr+0x1a>
    if(*s == c)
 28c:	00f58763          	beq	a1,a5,29a <strchr+0x1c>
  for(; *s; s++)
 290:	0505                	addi	a0,a0,1
 292:	00054783          	lbu	a5,0(a0)
 296:	fbfd                	bnez	a5,28c <strchr+0xe>
      return (char*)s;
  return 0;
 298:	4501                	li	a0,0
}
 29a:	60a2                	ld	ra,8(sp)
 29c:	6402                	ld	s0,0(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret

00000000000002a2 <gets>:

char*
gets(char *buf, int max)
{
 2a2:	711d                	addi	sp,sp,-96
 2a4:	ec86                	sd	ra,88(sp)
 2a6:	e8a2                	sd	s0,80(sp)
 2a8:	e4a6                	sd	s1,72(sp)
 2aa:	e0ca                	sd	s2,64(sp)
 2ac:	fc4e                	sd	s3,56(sp)
 2ae:	f852                	sd	s4,48(sp)
 2b0:	f456                	sd	s5,40(sp)
 2b2:	f05a                	sd	s6,32(sp)
 2b4:	ec5e                	sd	s7,24(sp)
 2b6:	e862                	sd	s8,16(sp)
 2b8:	1080                	addi	s0,sp,96
 2ba:	8baa                	mv	s7,a0
 2bc:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2be:	892a                	mv	s2,a0
 2c0:	4481                	li	s1,0
    cc = read(0, &c, 1);
 2c2:	faf40b13          	addi	s6,s0,-81
 2c6:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 2c8:	8c26                	mv	s8,s1
 2ca:	0014899b          	addiw	s3,s1,1
 2ce:	84ce                	mv	s1,s3
 2d0:	0349d863          	bge	s3,s4,300 <gets+0x5e>
    cc = read(0, &c, 1);
 2d4:	8656                	mv	a2,s5
 2d6:	85da                	mv	a1,s6
 2d8:	4501                	li	a0,0
 2da:	1c0000ef          	jal	49a <read>
    if(cc < 1)
 2de:	02a05163          	blez	a0,300 <gets+0x5e>
      break;
    buf[i++] = c;
 2e2:	faf44783          	lbu	a5,-81(s0)
 2e6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2ea:	0905                	addi	s2,s2,1
 2ec:	ff678713          	addi	a4,a5,-10
 2f0:	00173713          	seqz	a4,a4
 2f4:	17cd                	addi	a5,a5,-13
 2f6:	0017b793          	seqz	a5,a5
 2fa:	8fd9                	or	a5,a5,a4
 2fc:	d7f1                	beqz	a5,2c8 <gets+0x26>
    buf[i++] = c;
 2fe:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 300:	9c5e                	add	s8,s8,s7
 302:	000c0023          	sb	zero,0(s8)
  return buf;
}
 306:	855e                	mv	a0,s7
 308:	60e6                	ld	ra,88(sp)
 30a:	6446                	ld	s0,80(sp)
 30c:	64a6                	ld	s1,72(sp)
 30e:	6906                	ld	s2,64(sp)
 310:	79e2                	ld	s3,56(sp)
 312:	7a42                	ld	s4,48(sp)
 314:	7aa2                	ld	s5,40(sp)
 316:	7b02                	ld	s6,32(sp)
 318:	6be2                	ld	s7,24(sp)
 31a:	6c42                	ld	s8,16(sp)
 31c:	6125                	addi	sp,sp,96
 31e:	8082                	ret

0000000000000320 <stat>:

int
stat(const char *n, struct stat *st)
{
 320:	1101                	addi	sp,sp,-32
 322:	ec06                	sd	ra,24(sp)
 324:	e822                	sd	s0,16(sp)
 326:	e04a                	sd	s2,0(sp)
 328:	1000                	addi	s0,sp,32
 32a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 32c:	4581                	li	a1,0
 32e:	194000ef          	jal	4c2 <open>
  if(fd < 0)
 332:	02054263          	bltz	a0,356 <stat+0x36>
 336:	e426                	sd	s1,8(sp)
 338:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 33a:	85ca                	mv	a1,s2
 33c:	19e000ef          	jal	4da <fstat>
 340:	892a                	mv	s2,a0
  close(fd);
 342:	8526                	mv	a0,s1
 344:	166000ef          	jal	4aa <close>
  return r;
 348:	64a2                	ld	s1,8(sp)
}
 34a:	854a                	mv	a0,s2
 34c:	60e2                	ld	ra,24(sp)
 34e:	6442                	ld	s0,16(sp)
 350:	6902                	ld	s2,0(sp)
 352:	6105                	addi	sp,sp,32
 354:	8082                	ret
    return -1;
 356:	57fd                	li	a5,-1
 358:	893e                	mv	s2,a5
 35a:	bfc5                	j	34a <stat+0x2a>

000000000000035c <atoi>:

int
atoi(const char *s)
{
 35c:	1141                	addi	sp,sp,-16
 35e:	e406                	sd	ra,8(sp)
 360:	e022                	sd	s0,0(sp)
 362:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 364:	00054683          	lbu	a3,0(a0)
 368:	fd06879b          	addiw	a5,a3,-48
 36c:	0ff7f793          	zext.b	a5,a5
 370:	4625                	li	a2,9
 372:	02f66963          	bltu	a2,a5,3a4 <atoi+0x48>
 376:	872a                	mv	a4,a0
  n = 0;
 378:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 37a:	0705                	addi	a4,a4,1
 37c:	0025179b          	slliw	a5,a0,0x2
 380:	9fa9                	addw	a5,a5,a0
 382:	0017979b          	slliw	a5,a5,0x1
 386:	9fb5                	addw	a5,a5,a3
 388:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 38c:	00074683          	lbu	a3,0(a4)
 390:	fd06879b          	addiw	a5,a3,-48
 394:	0ff7f793          	zext.b	a5,a5
 398:	fef671e3          	bgeu	a2,a5,37a <atoi+0x1e>
  return n;
}
 39c:	60a2                	ld	ra,8(sp)
 39e:	6402                	ld	s0,0(sp)
 3a0:	0141                	addi	sp,sp,16
 3a2:	8082                	ret
  n = 0;
 3a4:	4501                	li	a0,0
 3a6:	bfdd                	j	39c <atoi+0x40>

00000000000003a8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3a8:	1141                	addi	sp,sp,-16
 3aa:	e406                	sd	ra,8(sp)
 3ac:	e022                	sd	s0,0(sp)
 3ae:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3b0:	02b57563          	bgeu	a0,a1,3da <memmove+0x32>
    while(n-- > 0)
 3b4:	00c05f63          	blez	a2,3d2 <memmove+0x2a>
 3b8:	1602                	slli	a2,a2,0x20
 3ba:	9201                	srli	a2,a2,0x20
 3bc:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3c0:	872a                	mv	a4,a0
      *dst++ = *src++;
 3c2:	0585                	addi	a1,a1,1
 3c4:	0705                	addi	a4,a4,1
 3c6:	fff5c683          	lbu	a3,-1(a1)
 3ca:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3ce:	fee79ae3          	bne	a5,a4,3c2 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3d2:	60a2                	ld	ra,8(sp)
 3d4:	6402                	ld	s0,0(sp)
 3d6:	0141                	addi	sp,sp,16
 3d8:	8082                	ret
    while(n-- > 0)
 3da:	fec05ce3          	blez	a2,3d2 <memmove+0x2a>
    dst += n;
 3de:	00c50733          	add	a4,a0,a2
    src += n;
 3e2:	95b2                	add	a1,a1,a2
 3e4:	fff6079b          	addiw	a5,a2,-1
 3e8:	1782                	slli	a5,a5,0x20
 3ea:	9381                	srli	a5,a5,0x20
 3ec:	fff7c793          	not	a5,a5
 3f0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3f2:	15fd                	addi	a1,a1,-1
 3f4:	177d                	addi	a4,a4,-1
 3f6:	0005c683          	lbu	a3,0(a1)
 3fa:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3fe:	fef71ae3          	bne	a4,a5,3f2 <memmove+0x4a>
 402:	bfc1                	j	3d2 <memmove+0x2a>

0000000000000404 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 404:	1141                	addi	sp,sp,-16
 406:	e406                	sd	ra,8(sp)
 408:	e022                	sd	s0,0(sp)
 40a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 40c:	ce19                	beqz	a2,42a <memcmp+0x26>
 40e:	1602                	slli	a2,a2,0x20
 410:	9201                	srli	a2,a2,0x20
 412:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 416:	00054783          	lbu	a5,0(a0)
 41a:	0005c703          	lbu	a4,0(a1)
 41e:	00e79b63          	bne	a5,a4,434 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 422:	0505                	addi	a0,a0,1
    p2++;
 424:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 426:	fed518e3          	bne	a0,a3,416 <memcmp+0x12>
  }
  return 0;
 42a:	4501                	li	a0,0
}
 42c:	60a2                	ld	ra,8(sp)
 42e:	6402                	ld	s0,0(sp)
 430:	0141                	addi	sp,sp,16
 432:	8082                	ret
      return *p1 - *p2;
 434:	40e7853b          	subw	a0,a5,a4
 438:	bfd5                	j	42c <memcmp+0x28>

000000000000043a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 43a:	1141                	addi	sp,sp,-16
 43c:	e406                	sd	ra,8(sp)
 43e:	e022                	sd	s0,0(sp)
 440:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 442:	f67ff0ef          	jal	3a8 <memmove>
}
 446:	60a2                	ld	ra,8(sp)
 448:	6402                	ld	s0,0(sp)
 44a:	0141                	addi	sp,sp,16
 44c:	8082                	ret

000000000000044e <sbrk>:

char *
sbrk(int n) {
 44e:	1141                	addi	sp,sp,-16
 450:	e406                	sd	ra,8(sp)
 452:	e022                	sd	s0,0(sp)
 454:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 456:	4585                	li	a1,1
 458:	0b2000ef          	jal	50a <sys_sbrk>
}
 45c:	60a2                	ld	ra,8(sp)
 45e:	6402                	ld	s0,0(sp)
 460:	0141                	addi	sp,sp,16
 462:	8082                	ret

0000000000000464 <sbrklazy>:

char *
sbrklazy(int n) {
 464:	1141                	addi	sp,sp,-16
 466:	e406                	sd	ra,8(sp)
 468:	e022                	sd	s0,0(sp)
 46a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 46c:	4589                	li	a1,2
 46e:	09c000ef          	jal	50a <sys_sbrk>
}
 472:	60a2                	ld	ra,8(sp)
 474:	6402                	ld	s0,0(sp)
 476:	0141                	addi	sp,sp,16
 478:	8082                	ret

000000000000047a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 47a:	4885                	li	a7,1
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <exit>:
.global exit
exit:
 li a7, SYS_exit
 482:	4889                	li	a7,2
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <wait>:
.global wait
wait:
 li a7, SYS_wait
 48a:	488d                	li	a7,3
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 492:	4891                	li	a7,4
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <read>:
.global read
read:
 li a7, SYS_read
 49a:	4895                	li	a7,5
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <write>:
.global write
write:
 li a7, SYS_write
 4a2:	48c1                	li	a7,16
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <close>:
.global close
close:
 li a7, SYS_close
 4aa:	48d5                	li	a7,21
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4b2:	4899                	li	a7,6
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <exec>:
.global exec
exec:
 li a7, SYS_exec
 4ba:	489d                	li	a7,7
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <open>:
.global open
open:
 li a7, SYS_open
 4c2:	48bd                	li	a7,15
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4ca:	48c5                	li	a7,17
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4d2:	48c9                	li	a7,18
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4da:	48a1                	li	a7,8
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <link>:
.global link
link:
 li a7, SYS_link
 4e2:	48cd                	li	a7,19
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4ea:	48d1                	li	a7,20
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4f2:	48a5                	li	a7,9
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <dup>:
.global dup
dup:
 li a7, SYS_dup
 4fa:	48a9                	li	a7,10
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 502:	48ad                	li	a7,11
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 50a:	48b1                	li	a7,12
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <pause>:
.global pause
pause:
 li a7, SYS_pause
 512:	48b5                	li	a7,13
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 51a:	48b9                	li	a7,14
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 522:	1101                	addi	sp,sp,-32
 524:	ec06                	sd	ra,24(sp)
 526:	e822                	sd	s0,16(sp)
 528:	1000                	addi	s0,sp,32
 52a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 52e:	4605                	li	a2,1
 530:	fef40593          	addi	a1,s0,-17
 534:	f6fff0ef          	jal	4a2 <write>
}
 538:	60e2                	ld	ra,24(sp)
 53a:	6442                	ld	s0,16(sp)
 53c:	6105                	addi	sp,sp,32
 53e:	8082                	ret

0000000000000540 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 540:	715d                	addi	sp,sp,-80
 542:	e486                	sd	ra,72(sp)
 544:	e0a2                	sd	s0,64(sp)
 546:	f84a                	sd	s2,48(sp)
 548:	f44e                	sd	s3,40(sp)
 54a:	0880                	addi	s0,sp,80
 54c:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 54e:	00d036b3          	snez	a3,a3
 552:	03f5d793          	srli	a5,a1,0x3f
 556:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 558:	0005871b          	sext.w	a4,a1
  neg = 0;
 55c:	4301                	li	t1,0
  if(sgn && xx < 0){
 55e:	c681                	beqz	a3,566 <printint+0x26>
    x = -xx;
 560:	40b0073b          	negw	a4,a1
    neg = 1;
 564:	4305                	li	t1,1
  }

  i = 0;
 566:	fb840993          	addi	s3,s0,-72
  neg = 0;
 56a:	85ce                	mv	a1,s3
  i = 0;
 56c:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 56e:	00000817          	auipc	a6,0x0
 572:	57a80813          	addi	a6,a6,1402 # ae8 <digits>
 576:	88b6                	mv	a7,a3
 578:	0016851b          	addiw	a0,a3,1
 57c:	86aa                	mv	a3,a0
 57e:	02c777bb          	remuw	a5,a4,a2
 582:	1782                	slli	a5,a5,0x20
 584:	9381                	srli	a5,a5,0x20
 586:	97c2                	add	a5,a5,a6
 588:	0007c783          	lbu	a5,0(a5)
 58c:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 590:	87ba                	mv	a5,a4
 592:	02c7573b          	divuw	a4,a4,a2
 596:	0585                	addi	a1,a1,1
 598:	fcc7ffe3          	bgeu	a5,a2,576 <printint+0x36>
  if(neg)
 59c:	00030b63          	beqz	t1,5b2 <printint+0x72>
    buf[i++] = '-';
 5a0:	fd040793          	addi	a5,s0,-48
 5a4:	953e                	add	a0,a0,a5
 5a6:	02d00793          	li	a5,45
 5aa:	fef50423          	sb	a5,-24(a0)
 5ae:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 5b2:	02d05563          	blez	a3,5dc <printint+0x9c>
 5b6:	fc26                	sd	s1,56(sp)
 5b8:	36fd                	addiw	a3,a3,-1
 5ba:	00d984b3          	add	s1,s3,a3
 5be:	19fd                	addi	s3,s3,-1
 5c0:	99b6                	add	s3,s3,a3
 5c2:	1682                	slli	a3,a3,0x20
 5c4:	9281                	srli	a3,a3,0x20
 5c6:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 5ca:	0004c583          	lbu	a1,0(s1)
 5ce:	854a                	mv	a0,s2
 5d0:	f53ff0ef          	jal	522 <putc>
  while(--i >= 0)
 5d4:	14fd                	addi	s1,s1,-1
 5d6:	ff349ae3          	bne	s1,s3,5ca <printint+0x8a>
 5da:	74e2                	ld	s1,56(sp)
}
 5dc:	60a6                	ld	ra,72(sp)
 5de:	6406                	ld	s0,64(sp)
 5e0:	7942                	ld	s2,48(sp)
 5e2:	79a2                	ld	s3,40(sp)
 5e4:	6161                	addi	sp,sp,80
 5e6:	8082                	ret

00000000000005e8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5e8:	711d                	addi	sp,sp,-96
 5ea:	ec86                	sd	ra,88(sp)
 5ec:	e8a2                	sd	s0,80(sp)
 5ee:	e4a6                	sd	s1,72(sp)
 5f0:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5f2:	0005c483          	lbu	s1,0(a1)
 5f6:	2a048063          	beqz	s1,896 <vprintf+0x2ae>
 5fa:	e0ca                	sd	s2,64(sp)
 5fc:	fc4e                	sd	s3,56(sp)
 5fe:	f852                	sd	s4,48(sp)
 600:	f456                	sd	s5,40(sp)
 602:	f05a                	sd	s6,32(sp)
 604:	ec5e                	sd	s7,24(sp)
 606:	e862                	sd	s8,16(sp)
 608:	8b2a                	mv	s6,a0
 60a:	8a2e                	mv	s4,a1
 60c:	8bb2                	mv	s7,a2
  state = 0;
 60e:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 610:	4901                	li	s2,0
 612:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 614:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 618:	06400c13          	li	s8,100
 61c:	a00d                	j	63e <vprintf+0x56>
        putc(fd, c0);
 61e:	85a6                	mv	a1,s1
 620:	855a                	mv	a0,s6
 622:	f01ff0ef          	jal	522 <putc>
 626:	a019                	j	62c <vprintf+0x44>
    } else if(state == '%'){
 628:	03598363          	beq	s3,s5,64e <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 62c:	0019079b          	addiw	a5,s2,1
 630:	893e                	mv	s2,a5
 632:	873e                	mv	a4,a5
 634:	97d2                	add	a5,a5,s4
 636:	0007c483          	lbu	s1,0(a5)
 63a:	24048763          	beqz	s1,888 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 63e:	0004879b          	sext.w	a5,s1
    if(state == 0){
 642:	fe0993e3          	bnez	s3,628 <vprintf+0x40>
      if(c0 == '%'){
 646:	fd579ce3          	bne	a5,s5,61e <vprintf+0x36>
        state = '%';
 64a:	89be                	mv	s3,a5
 64c:	b7c5                	j	62c <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 64e:	00ea06b3          	add	a3,s4,a4
 652:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 656:	24060563          	beqz	a2,8a0 <vprintf+0x2b8>
      if(c0 == 'd'){
 65a:	0b878763          	beq	a5,s8,708 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 65e:	f9478693          	addi	a3,a5,-108
 662:	0016b693          	seqz	a3,a3
 666:	f9c60593          	addi	a1,a2,-100
 66a:	0015b593          	seqz	a1,a1
 66e:	8df5                	and	a1,a1,a3
 670:	e9c5                	bnez	a1,720 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 672:	9752                	add	a4,a4,s4
 674:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 678:	f9460713          	addi	a4,a2,-108
 67c:	00173713          	seqz	a4,a4
 680:	8f75                	and	a4,a4,a3
 682:	f9c50593          	addi	a1,a0,-100
 686:	0015b593          	seqz	a1,a1
 68a:	8df9                	and	a1,a1,a4
 68c:	e5dd                	bnez	a1,73a <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 68e:	07500593          	li	a1,117
 692:	0cb78163          	beq	a5,a1,754 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 696:	f8b60593          	addi	a1,a2,-117
 69a:	0015b593          	seqz	a1,a1
 69e:	8df5                	and	a1,a1,a3
 6a0:	e5f1                	bnez	a1,76c <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6a2:	f8b50593          	addi	a1,a0,-117
 6a6:	0015b593          	seqz	a1,a1
 6aa:	8df9                	and	a1,a1,a4
 6ac:	ede9                	bnez	a1,786 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 6ae:	07800593          	li	a1,120
 6b2:	0eb78763          	beq	a5,a1,7a0 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 6b6:	f8860613          	addi	a2,a2,-120
 6ba:	00163613          	seqz	a2,a2
 6be:	8ef1                	and	a3,a3,a2
 6c0:	0e069c63          	bnez	a3,7b8 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6c4:	f8850513          	addi	a0,a0,-120
 6c8:	00153513          	seqz	a0,a0
 6cc:	8f69                	and	a4,a4,a0
 6ce:	10071263          	bnez	a4,7d2 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 6d2:	07000713          	li	a4,112
 6d6:	10e78a63          	beq	a5,a4,7ea <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 6da:	06300713          	li	a4,99
 6de:	14e78a63          	beq	a5,a4,832 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 6e2:	07300713          	li	a4,115
 6e6:	16e78063          	beq	a5,a4,846 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 6ea:	02500713          	li	a4,37
 6ee:	18e78863          	beq	a5,a4,87e <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6f2:	02500593          	li	a1,37
 6f6:	855a                	mv	a0,s6
 6f8:	e2bff0ef          	jal	522 <putc>
        putc(fd, c0);
 6fc:	85a6                	mv	a1,s1
 6fe:	855a                	mv	a0,s6
 700:	e23ff0ef          	jal	522 <putc>
      }

      state = 0;
 704:	4981                	li	s3,0
 706:	b71d                	j	62c <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 708:	008b8493          	addi	s1,s7,8
 70c:	4685                	li	a3,1
 70e:	4629                	li	a2,10
 710:	000ba583          	lw	a1,0(s7)
 714:	855a                	mv	a0,s6
 716:	e2bff0ef          	jal	540 <printint>
 71a:	8ba6                	mv	s7,s1
      state = 0;
 71c:	4981                	li	s3,0
 71e:	b739                	j	62c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 720:	008b8493          	addi	s1,s7,8
 724:	4685                	li	a3,1
 726:	4629                	li	a2,10
 728:	000bb583          	ld	a1,0(s7)
 72c:	855a                	mv	a0,s6
 72e:	e13ff0ef          	jal	540 <printint>
        i += 1;
 732:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 734:	8ba6                	mv	s7,s1
      state = 0;
 736:	4981                	li	s3,0
 738:	bdd5                	j	62c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 73a:	008b8493          	addi	s1,s7,8
 73e:	4685                	li	a3,1
 740:	4629                	li	a2,10
 742:	000bb583          	ld	a1,0(s7)
 746:	855a                	mv	a0,s6
 748:	df9ff0ef          	jal	540 <printint>
        i += 2;
 74c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 74e:	8ba6                	mv	s7,s1
      state = 0;
 750:	4981                	li	s3,0
        i += 2;
 752:	bde9                	j	62c <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 754:	008b8493          	addi	s1,s7,8
 758:	4681                	li	a3,0
 75a:	4629                	li	a2,10
 75c:	000be583          	lwu	a1,0(s7)
 760:	855a                	mv	a0,s6
 762:	ddfff0ef          	jal	540 <printint>
 766:	8ba6                	mv	s7,s1
      state = 0;
 768:	4981                	li	s3,0
 76a:	b5c9                	j	62c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 76c:	008b8493          	addi	s1,s7,8
 770:	4681                	li	a3,0
 772:	4629                	li	a2,10
 774:	000bb583          	ld	a1,0(s7)
 778:	855a                	mv	a0,s6
 77a:	dc7ff0ef          	jal	540 <printint>
        i += 1;
 77e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 780:	8ba6                	mv	s7,s1
      state = 0;
 782:	4981                	li	s3,0
 784:	b565                	j	62c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 786:	008b8493          	addi	s1,s7,8
 78a:	4681                	li	a3,0
 78c:	4629                	li	a2,10
 78e:	000bb583          	ld	a1,0(s7)
 792:	855a                	mv	a0,s6
 794:	dadff0ef          	jal	540 <printint>
        i += 2;
 798:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 79a:	8ba6                	mv	s7,s1
      state = 0;
 79c:	4981                	li	s3,0
        i += 2;
 79e:	b579                	j	62c <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 7a0:	008b8493          	addi	s1,s7,8
 7a4:	4681                	li	a3,0
 7a6:	4641                	li	a2,16
 7a8:	000be583          	lwu	a1,0(s7)
 7ac:	855a                	mv	a0,s6
 7ae:	d93ff0ef          	jal	540 <printint>
 7b2:	8ba6                	mv	s7,s1
      state = 0;
 7b4:	4981                	li	s3,0
 7b6:	bd9d                	j	62c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7b8:	008b8493          	addi	s1,s7,8
 7bc:	4681                	li	a3,0
 7be:	4641                	li	a2,16
 7c0:	000bb583          	ld	a1,0(s7)
 7c4:	855a                	mv	a0,s6
 7c6:	d7bff0ef          	jal	540 <printint>
        i += 1;
 7ca:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7cc:	8ba6                	mv	s7,s1
      state = 0;
 7ce:	4981                	li	s3,0
 7d0:	bdb1                	j	62c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7d2:	008b8493          	addi	s1,s7,8
 7d6:	4641                	li	a2,16
 7d8:	000bb583          	ld	a1,0(s7)
 7dc:	855a                	mv	a0,s6
 7de:	d63ff0ef          	jal	540 <printint>
        i += 2;
 7e2:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 7e4:	8ba6                	mv	s7,s1
      state = 0;
 7e6:	4981                	li	s3,0
        i += 2;
 7e8:	b591                	j	62c <vprintf+0x44>
 7ea:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 7ec:	008b8793          	addi	a5,s7,8
 7f0:	8cbe                	mv	s9,a5
 7f2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7f6:	03000593          	li	a1,48
 7fa:	855a                	mv	a0,s6
 7fc:	d27ff0ef          	jal	522 <putc>
  putc(fd, 'x');
 800:	07800593          	li	a1,120
 804:	855a                	mv	a0,s6
 806:	d1dff0ef          	jal	522 <putc>
 80a:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 80c:	00000b97          	auipc	s7,0x0
 810:	2dcb8b93          	addi	s7,s7,732 # ae8 <digits>
 814:	03c9d793          	srli	a5,s3,0x3c
 818:	97de                	add	a5,a5,s7
 81a:	0007c583          	lbu	a1,0(a5)
 81e:	855a                	mv	a0,s6
 820:	d03ff0ef          	jal	522 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 824:	0992                	slli	s3,s3,0x4
 826:	34fd                	addiw	s1,s1,-1
 828:	f4f5                	bnez	s1,814 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 82a:	8be6                	mv	s7,s9
      state = 0;
 82c:	4981                	li	s3,0
 82e:	6ca2                	ld	s9,8(sp)
 830:	bbf5                	j	62c <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 832:	008b8493          	addi	s1,s7,8
 836:	000bc583          	lbu	a1,0(s7)
 83a:	855a                	mv	a0,s6
 83c:	ce7ff0ef          	jal	522 <putc>
 840:	8ba6                	mv	s7,s1
      state = 0;
 842:	4981                	li	s3,0
 844:	b3e5                	j	62c <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 846:	008b8993          	addi	s3,s7,8
 84a:	000bb483          	ld	s1,0(s7)
 84e:	cc91                	beqz	s1,86a <vprintf+0x282>
        for(; *s; s++)
 850:	0004c583          	lbu	a1,0(s1)
 854:	c195                	beqz	a1,878 <vprintf+0x290>
          putc(fd, *s);
 856:	855a                	mv	a0,s6
 858:	ccbff0ef          	jal	522 <putc>
        for(; *s; s++)
 85c:	0485                	addi	s1,s1,1
 85e:	0004c583          	lbu	a1,0(s1)
 862:	f9f5                	bnez	a1,856 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 864:	8bce                	mv	s7,s3
      state = 0;
 866:	4981                	li	s3,0
 868:	b3d1                	j	62c <vprintf+0x44>
          s = "(null)";
 86a:	00000497          	auipc	s1,0x0
 86e:	27648493          	addi	s1,s1,630 # ae0 <malloc+0x144>
        for(; *s; s++)
 872:	02800593          	li	a1,40
 876:	b7c5                	j	856 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 878:	8bce                	mv	s7,s3
      state = 0;
 87a:	4981                	li	s3,0
 87c:	bb45                	j	62c <vprintf+0x44>
        putc(fd, '%');
 87e:	85be                	mv	a1,a5
 880:	855a                	mv	a0,s6
 882:	ca1ff0ef          	jal	522 <putc>
 886:	bdbd                	j	704 <vprintf+0x11c>
 888:	6906                	ld	s2,64(sp)
 88a:	79e2                	ld	s3,56(sp)
 88c:	7a42                	ld	s4,48(sp)
 88e:	7aa2                	ld	s5,40(sp)
 890:	7b02                	ld	s6,32(sp)
 892:	6be2                	ld	s7,24(sp)
 894:	6c42                	ld	s8,16(sp)
    }
  }
}
 896:	60e6                	ld	ra,88(sp)
 898:	6446                	ld	s0,80(sp)
 89a:	64a6                	ld	s1,72(sp)
 89c:	6125                	addi	sp,sp,96
 89e:	8082                	ret
      if(c0 == 'd'){
 8a0:	06400713          	li	a4,100
 8a4:	e6e782e3          	beq	a5,a4,708 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 8a8:	f9478693          	addi	a3,a5,-108
 8ac:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 8b0:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 8b2:	4701                	li	a4,0
 8b4:	bbe9                	j	68e <vprintf+0xa6>

00000000000008b6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8b6:	715d                	addi	sp,sp,-80
 8b8:	ec06                	sd	ra,24(sp)
 8ba:	e822                	sd	s0,16(sp)
 8bc:	1000                	addi	s0,sp,32
 8be:	e010                	sd	a2,0(s0)
 8c0:	e414                	sd	a3,8(s0)
 8c2:	e818                	sd	a4,16(s0)
 8c4:	ec1c                	sd	a5,24(s0)
 8c6:	03043023          	sd	a6,32(s0)
 8ca:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8ce:	8622                	mv	a2,s0
 8d0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8d4:	d15ff0ef          	jal	5e8 <vprintf>
}
 8d8:	60e2                	ld	ra,24(sp)
 8da:	6442                	ld	s0,16(sp)
 8dc:	6161                	addi	sp,sp,80
 8de:	8082                	ret

00000000000008e0 <printf>:

void
printf(const char *fmt, ...)
{
 8e0:	711d                	addi	sp,sp,-96
 8e2:	ec06                	sd	ra,24(sp)
 8e4:	e822                	sd	s0,16(sp)
 8e6:	1000                	addi	s0,sp,32
 8e8:	e40c                	sd	a1,8(s0)
 8ea:	e810                	sd	a2,16(s0)
 8ec:	ec14                	sd	a3,24(s0)
 8ee:	f018                	sd	a4,32(s0)
 8f0:	f41c                	sd	a5,40(s0)
 8f2:	03043823          	sd	a6,48(s0)
 8f6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8fa:	00840613          	addi	a2,s0,8
 8fe:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 902:	85aa                	mv	a1,a0
 904:	4505                	li	a0,1
 906:	ce3ff0ef          	jal	5e8 <vprintf>
}
 90a:	60e2                	ld	ra,24(sp)
 90c:	6442                	ld	s0,16(sp)
 90e:	6125                	addi	sp,sp,96
 910:	8082                	ret

0000000000000912 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 912:	1141                	addi	sp,sp,-16
 914:	e406                	sd	ra,8(sp)
 916:	e022                	sd	s0,0(sp)
 918:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 91a:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 91e:	00000797          	auipc	a5,0x0
 922:	6e27b783          	ld	a5,1762(a5) # 1000 <freep>
 926:	a095                	j	98a <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 928:	ff852583          	lw	a1,-8(a0)
 92c:	6390                	ld	a2,0(a5)
 92e:	02059813          	slli	a6,a1,0x20
 932:	01c85693          	srli	a3,a6,0x1c
 936:	96ba                	add	a3,a3,a4
 938:	02d60563          	beq	a2,a3,962 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 93c:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 940:	4790                	lw	a2,8(a5)
 942:	02061593          	slli	a1,a2,0x20
 946:	01c5d693          	srli	a3,a1,0x1c
 94a:	96be                	add	a3,a3,a5
 94c:	02d70263          	beq	a4,a3,970 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 950:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 952:	00000717          	auipc	a4,0x0
 956:	6af73723          	sd	a5,1710(a4) # 1000 <freep>
}
 95a:	60a2                	ld	ra,8(sp)
 95c:	6402                	ld	s0,0(sp)
 95e:	0141                	addi	sp,sp,16
 960:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 962:	4614                	lw	a3,8(a2)
 964:	9ead                	addw	a3,a3,a1
 966:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 96a:	6394                	ld	a3,0(a5)
 96c:	6290                	ld	a2,0(a3)
 96e:	b7f9                	j	93c <free+0x2a>
    p->s.size += bp->s.size;
 970:	ff852703          	lw	a4,-8(a0)
 974:	9f31                	addw	a4,a4,a2
 976:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 978:	ff053703          	ld	a4,-16(a0)
 97c:	bfd1                	j	950 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 97e:	6394                	ld	a3,0(a5)
 980:	00d7e463          	bltu	a5,a3,988 <free+0x76>
 984:	fad762e3          	bltu	a4,a3,928 <free+0x16>
 988:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 98a:	fee7fae3          	bgeu	a5,a4,97e <free+0x6c>
 98e:	6394                	ld	a3,0(a5)
 990:	f8d76ce3          	bltu	a4,a3,928 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 994:	f8d7fae3          	bgeu	a5,a3,928 <free+0x16>
 998:	87b6                	mv	a5,a3
 99a:	bfc5                	j	98a <free+0x78>

000000000000099c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 99c:	7139                	addi	sp,sp,-64
 99e:	fc06                	sd	ra,56(sp)
 9a0:	f822                	sd	s0,48(sp)
 9a2:	f04a                	sd	s2,32(sp)
 9a4:	ec4e                	sd	s3,24(sp)
 9a6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9a8:	02051993          	slli	s3,a0,0x20
 9ac:	0209d993          	srli	s3,s3,0x20
 9b0:	09bd                	addi	s3,s3,15
 9b2:	0049d993          	srli	s3,s3,0x4
 9b6:	2985                	addiw	s3,s3,1
 9b8:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 9ba:	00000517          	auipc	a0,0x0
 9be:	64653503          	ld	a0,1606(a0) # 1000 <freep>
 9c2:	c905                	beqz	a0,9f2 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9c4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9c6:	4798                	lw	a4,8(a5)
 9c8:	09377663          	bgeu	a4,s3,a54 <malloc+0xb8>
 9cc:	f426                	sd	s1,40(sp)
 9ce:	e852                	sd	s4,16(sp)
 9d0:	e456                	sd	s5,8(sp)
 9d2:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9d4:	8a4e                	mv	s4,s3
 9d6:	6705                	lui	a4,0x1
 9d8:	00e9f363          	bgeu	s3,a4,9de <malloc+0x42>
 9dc:	6a05                	lui	s4,0x1
 9de:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9e2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9e6:	00000497          	auipc	s1,0x0
 9ea:	61a48493          	addi	s1,s1,1562 # 1000 <freep>
  if(p == SBRK_ERROR)
 9ee:	5afd                	li	s5,-1
 9f0:	a83d                	j	a2e <malloc+0x92>
 9f2:	f426                	sd	s1,40(sp)
 9f4:	e852                	sd	s4,16(sp)
 9f6:	e456                	sd	s5,8(sp)
 9f8:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9fa:	00000797          	auipc	a5,0x0
 9fe:	61678793          	addi	a5,a5,1558 # 1010 <base>
 a02:	00000717          	auipc	a4,0x0
 a06:	5ef73f23          	sd	a5,1534(a4) # 1000 <freep>
 a0a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a0c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a10:	b7d1                	j	9d4 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 a12:	6398                	ld	a4,0(a5)
 a14:	e118                	sd	a4,0(a0)
 a16:	a899                	j	a6c <malloc+0xd0>
  hp->s.size = nu;
 a18:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a1c:	0541                	addi	a0,a0,16
 a1e:	ef5ff0ef          	jal	912 <free>
  return freep;
 a22:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 a24:	c125                	beqz	a0,a84 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a26:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a28:	4798                	lw	a4,8(a5)
 a2a:	03277163          	bgeu	a4,s2,a4c <malloc+0xb0>
    if(p == freep)
 a2e:	6098                	ld	a4,0(s1)
 a30:	853e                	mv	a0,a5
 a32:	fef71ae3          	bne	a4,a5,a26 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 a36:	8552                	mv	a0,s4
 a38:	a17ff0ef          	jal	44e <sbrk>
  if(p == SBRK_ERROR)
 a3c:	fd551ee3          	bne	a0,s5,a18 <malloc+0x7c>
        return 0;
 a40:	4501                	li	a0,0
 a42:	74a2                	ld	s1,40(sp)
 a44:	6a42                	ld	s4,16(sp)
 a46:	6aa2                	ld	s5,8(sp)
 a48:	6b02                	ld	s6,0(sp)
 a4a:	a03d                	j	a78 <malloc+0xdc>
 a4c:	74a2                	ld	s1,40(sp)
 a4e:	6a42                	ld	s4,16(sp)
 a50:	6aa2                	ld	s5,8(sp)
 a52:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a54:	fae90fe3          	beq	s2,a4,a12 <malloc+0x76>
        p->s.size -= nunits;
 a58:	4137073b          	subw	a4,a4,s3
 a5c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a5e:	02071693          	slli	a3,a4,0x20
 a62:	01c6d713          	srli	a4,a3,0x1c
 a66:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a68:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a6c:	00000717          	auipc	a4,0x0
 a70:	58a73a23          	sd	a0,1428(a4) # 1000 <freep>
      return (void*)(p + 1);
 a74:	01078513          	addi	a0,a5,16
  }
}
 a78:	70e2                	ld	ra,56(sp)
 a7a:	7442                	ld	s0,48(sp)
 a7c:	7902                	ld	s2,32(sp)
 a7e:	69e2                	ld	s3,24(sp)
 a80:	6121                	addi	sp,sp,64
 a82:	8082                	ret
 a84:	74a2                	ld	s1,40(sp)
 a86:	6a42                	ld	s4,16(sp)
 a88:	6aa2                	ld	s5,8(sp)
 a8a:	6b02                	ld	s6,0(sp)
 a8c:	b7f5                	j	a78 <malloc+0xdc>
