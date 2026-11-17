
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

char*
fmtname(char *path)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   c:	2ac000ef          	jal	2b8 <strlen>
  10:	02051793          	slli	a5,a0,0x20
  14:	9381                	srli	a5,a5,0x20
  16:	97a6                	add	a5,a5,s1
  18:	02f00693          	li	a3,47
  1c:	0097e963          	bltu	a5,s1,2e <fmtname+0x2e>
  20:	0007c703          	lbu	a4,0(a5)
  24:	00d70563          	beq	a4,a3,2e <fmtname+0x2e>
  28:	17fd                	addi	a5,a5,-1
  2a:	fe97fbe3          	bgeu	a5,s1,20 <fmtname+0x20>
    ;
  p++;
  2e:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  32:	8526                	mv	a0,s1
  34:	284000ef          	jal	2b8 <strlen>
  38:	47b5                	li	a5,13
  3a:	00a7f863          	bgeu	a5,a0,4a <fmtname+0x4a>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  buf[sizeof(buf)-1] = '\0';
  return buf;
}
  3e:	8526                	mv	a0,s1
  40:	60e2                	ld	ra,24(sp)
  42:	6442                	ld	s0,16(sp)
  44:	64a2                	ld	s1,8(sp)
  46:	6105                	addi	sp,sp,32
  48:	8082                	ret
  4a:	e04a                	sd	s2,0(sp)
  memmove(buf, p, strlen(p));
  4c:	8526                	mv	a0,s1
  4e:	26a000ef          	jal	2b8 <strlen>
  52:	862a                	mv	a2,a0
  54:	85a6                	mv	a1,s1
  56:	00001517          	auipc	a0,0x1
  5a:	fba50513          	addi	a0,a0,-70 # 1010 <buf.0>
  5e:	3d6000ef          	jal	434 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  62:	8526                	mv	a0,s1
  64:	254000ef          	jal	2b8 <strlen>
  68:	892a                	mv	s2,a0
  6a:	8526                	mv	a0,s1
  6c:	24c000ef          	jal	2b8 <strlen>
  70:	02091793          	slli	a5,s2,0x20
  74:	9381                	srli	a5,a5,0x20
  76:	4639                	li	a2,14
  78:	9e09                	subw	a2,a2,a0
  7a:	02000593          	li	a1,32
  7e:	00001717          	auipc	a4,0x1
  82:	f9270713          	addi	a4,a4,-110 # 1010 <buf.0>
  86:	84ba                	mv	s1,a4
  88:	00f70533          	add	a0,a4,a5
  8c:	258000ef          	jal	2e4 <memset>
  buf[sizeof(buf)-1] = '\0';
  90:	00048723          	sb	zero,14(s1)
  return buf;
  94:	6902                	ld	s2,0(sp)
  96:	b765                	j	3e <fmtname+0x3e>

0000000000000098 <ls>:

void
ls(char *path)
{
  98:	da010113          	addi	sp,sp,-608
  9c:	24113c23          	sd	ra,600(sp)
  a0:	24813823          	sd	s0,592(sp)
  a4:	25213023          	sd	s2,576(sp)
  a8:	1480                	addi	s0,sp,608
  aa:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, O_RDONLY)) < 0){
  ac:	4581                	li	a1,0
  ae:	4a0000ef          	jal	54e <open>
  b2:	06054363          	bltz	a0,118 <ls+0x80>
  b6:	24913423          	sd	s1,584(sp)
  ba:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  bc:	da840593          	addi	a1,s0,-600
  c0:	4a6000ef          	jal	566 <fstat>
  c4:	06054363          	bltz	a0,12a <ls+0x92>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  c8:	db041783          	lh	a5,-592(s0)
  cc:	4705                	li	a4,1
  ce:	06e78c63          	beq	a5,a4,146 <ls+0xae>
  d2:	37f9                	addiw	a5,a5,-2
  d4:	17c2                	slli	a5,a5,0x30
  d6:	93c1                	srli	a5,a5,0x30
  d8:	02f76263          	bltu	a4,a5,fc <ls+0x64>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %d\n", fmtname(path), st.type, st.ino, (int) st.size);
  dc:	854a                	mv	a0,s2
  de:	f23ff0ef          	jal	0 <fmtname>
  e2:	85aa                	mv	a1,a0
  e4:	db842703          	lw	a4,-584(s0)
  e8:	dac42683          	lw	a3,-596(s0)
  ec:	db041603          	lh	a2,-592(s0)
  f0:	00001517          	auipc	a0,0x1
  f4:	b1050513          	addi	a0,a0,-1264 # c00 <statistics+0xa4>
  f8:	0b7000ef          	jal	9ae <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
    }
    break;
  }
  close(fd);
  fc:	8526                	mv	a0,s1
  fe:	438000ef          	jal	536 <close>
 102:	24813483          	ld	s1,584(sp)
}
 106:	25813083          	ld	ra,600(sp)
 10a:	25013403          	ld	s0,592(sp)
 10e:	24013903          	ld	s2,576(sp)
 112:	26010113          	addi	sp,sp,608
 116:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 118:	864a                	mv	a2,s2
 11a:	00001597          	auipc	a1,0x1
 11e:	ab658593          	addi	a1,a1,-1354 # bd0 <statistics+0x74>
 122:	4509                	li	a0,2
 124:	061000ef          	jal	984 <fprintf>
    return;
 128:	bff9                	j	106 <ls+0x6e>
    fprintf(2, "ls: cannot stat %s\n", path);
 12a:	864a                	mv	a2,s2
 12c:	00001597          	auipc	a1,0x1
 130:	abc58593          	addi	a1,a1,-1348 # be8 <statistics+0x8c>
 134:	4509                	li	a0,2
 136:	04f000ef          	jal	984 <fprintf>
    close(fd);
 13a:	8526                	mv	a0,s1
 13c:	3fa000ef          	jal	536 <close>
    return;
 140:	24813483          	ld	s1,584(sp)
 144:	b7c9                	j	106 <ls+0x6e>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 146:	854a                	mv	a0,s2
 148:	170000ef          	jal	2b8 <strlen>
 14c:	2541                	addiw	a0,a0,16
 14e:	20000793          	li	a5,512
 152:	00a7f963          	bgeu	a5,a0,164 <ls+0xcc>
      printf("ls: path too long\n");
 156:	00001517          	auipc	a0,0x1
 15a:	aba50513          	addi	a0,a0,-1350 # c10 <statistics+0xb4>
 15e:	051000ef          	jal	9ae <printf>
      break;
 162:	bf69                	j	fc <ls+0x64>
 164:	23313c23          	sd	s3,568(sp)
    strcpy(buf, path);
 168:	85ca                	mv	a1,s2
 16a:	dd040513          	addi	a0,s0,-560
 16e:	0fa000ef          	jal	268 <strcpy>
    p = buf+strlen(buf);
 172:	dd040513          	addi	a0,s0,-560
 176:	142000ef          	jal	2b8 <strlen>
 17a:	1502                	slli	a0,a0,0x20
 17c:	9101                	srli	a0,a0,0x20
 17e:	dd040793          	addi	a5,s0,-560
 182:	00a78733          	add	a4,a5,a0
 186:	893a                	mv	s2,a4
    *p++ = '/';
 188:	00170793          	addi	a5,a4,1
 18c:	89be                	mv	s3,a5
 18e:	02f00793          	li	a5,47
 192:	00f70023          	sb	a5,0(a4)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 196:	a809                	j	1a8 <ls+0x110>
        printf("ls: cannot stat %s\n", buf);
 198:	dd040593          	addi	a1,s0,-560
 19c:	00001517          	auipc	a0,0x1
 1a0:	a4c50513          	addi	a0,a0,-1460 # be8 <statistics+0x8c>
 1a4:	00b000ef          	jal	9ae <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1a8:	4641                	li	a2,16
 1aa:	dc040593          	addi	a1,s0,-576
 1ae:	8526                	mv	a0,s1
 1b0:	376000ef          	jal	526 <read>
 1b4:	47c1                	li	a5,16
 1b6:	04f51763          	bne	a0,a5,204 <ls+0x16c>
      if(de.inum == 0)
 1ba:	dc045783          	lhu	a5,-576(s0)
 1be:	d7ed                	beqz	a5,1a8 <ls+0x110>
      memmove(p, de.name, DIRSIZ);
 1c0:	4639                	li	a2,14
 1c2:	dc240593          	addi	a1,s0,-574
 1c6:	854e                	mv	a0,s3
 1c8:	26c000ef          	jal	434 <memmove>
      p[DIRSIZ] = 0;
 1cc:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 1d0:	da840593          	addi	a1,s0,-600
 1d4:	dd040513          	addi	a0,s0,-560
 1d8:	1d4000ef          	jal	3ac <stat>
 1dc:	fa054ee3          	bltz	a0,198 <ls+0x100>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 1e0:	dd040513          	addi	a0,s0,-560
 1e4:	e1dff0ef          	jal	0 <fmtname>
 1e8:	85aa                	mv	a1,a0
 1ea:	db842703          	lw	a4,-584(s0)
 1ee:	dac42683          	lw	a3,-596(s0)
 1f2:	db041603          	lh	a2,-592(s0)
 1f6:	00001517          	auipc	a0,0x1
 1fa:	a0a50513          	addi	a0,a0,-1526 # c00 <statistics+0xa4>
 1fe:	7b0000ef          	jal	9ae <printf>
 202:	b75d                	j	1a8 <ls+0x110>
 204:	23813983          	ld	s3,568(sp)
 208:	bdd5                	j	fc <ls+0x64>

000000000000020a <main>:

int
main(int argc, char *argv[])
{
 20a:	1101                	addi	sp,sp,-32
 20c:	ec06                	sd	ra,24(sp)
 20e:	e822                	sd	s0,16(sp)
 210:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 212:	4785                	li	a5,1
 214:	02a7d763          	bge	a5,a0,242 <main+0x38>
 218:	e426                	sd	s1,8(sp)
 21a:	e04a                	sd	s2,0(sp)
 21c:	00858493          	addi	s1,a1,8
 220:	ffe5091b          	addiw	s2,a0,-2
 224:	02091793          	slli	a5,s2,0x20
 228:	01d7d913          	srli	s2,a5,0x1d
 22c:	05c1                	addi	a1,a1,16
 22e:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 230:	6088                	ld	a0,0(s1)
 232:	e67ff0ef          	jal	98 <ls>
  for(i=1; i<argc; i++)
 236:	04a1                	addi	s1,s1,8
 238:	ff249ce3          	bne	s1,s2,230 <main+0x26>
  exit(0);
 23c:	4501                	li	a0,0
 23e:	2d0000ef          	jal	50e <exit>
 242:	e426                	sd	s1,8(sp)
 244:	e04a                	sd	s2,0(sp)
    ls(".");
 246:	00001517          	auipc	a0,0x1
 24a:	9e250513          	addi	a0,a0,-1566 # c28 <statistics+0xcc>
 24e:	e4bff0ef          	jal	98 <ls>
    exit(0);
 252:	4501                	li	a0,0
 254:	2ba000ef          	jal	50e <exit>

0000000000000258 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 258:	1141                	addi	sp,sp,-16
 25a:	e406                	sd	ra,8(sp)
 25c:	e022                	sd	s0,0(sp)
 25e:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 260:	fabff0ef          	jal	20a <main>
  exit(r);
 264:	2aa000ef          	jal	50e <exit>

0000000000000268 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 268:	1141                	addi	sp,sp,-16
 26a:	e406                	sd	ra,8(sp)
 26c:	e022                	sd	s0,0(sp)
 26e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 270:	87aa                	mv	a5,a0
 272:	0585                	addi	a1,a1,1
 274:	0785                	addi	a5,a5,1
 276:	fff5c703          	lbu	a4,-1(a1)
 27a:	fee78fa3          	sb	a4,-1(a5)
 27e:	fb75                	bnez	a4,272 <strcpy+0xa>
    ;
  return os;
}
 280:	60a2                	ld	ra,8(sp)
 282:	6402                	ld	s0,0(sp)
 284:	0141                	addi	sp,sp,16
 286:	8082                	ret

0000000000000288 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 288:	1141                	addi	sp,sp,-16
 28a:	e406                	sd	ra,8(sp)
 28c:	e022                	sd	s0,0(sp)
 28e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 290:	00054783          	lbu	a5,0(a0)
 294:	cb91                	beqz	a5,2a8 <strcmp+0x20>
 296:	0005c703          	lbu	a4,0(a1)
 29a:	00f71763          	bne	a4,a5,2a8 <strcmp+0x20>
    p++, q++;
 29e:	0505                	addi	a0,a0,1
 2a0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2a2:	00054783          	lbu	a5,0(a0)
 2a6:	fbe5                	bnez	a5,296 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 2a8:	0005c503          	lbu	a0,0(a1)
}
 2ac:	40a7853b          	subw	a0,a5,a0
 2b0:	60a2                	ld	ra,8(sp)
 2b2:	6402                	ld	s0,0(sp)
 2b4:	0141                	addi	sp,sp,16
 2b6:	8082                	ret

00000000000002b8 <strlen>:

uint
strlen(const char *s)
{
 2b8:	1141                	addi	sp,sp,-16
 2ba:	e406                	sd	ra,8(sp)
 2bc:	e022                	sd	s0,0(sp)
 2be:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2c0:	00054783          	lbu	a5,0(a0)
 2c4:	cf91                	beqz	a5,2e0 <strlen+0x28>
 2c6:	00150793          	addi	a5,a0,1
 2ca:	86be                	mv	a3,a5
 2cc:	0785                	addi	a5,a5,1
 2ce:	fff7c703          	lbu	a4,-1(a5)
 2d2:	ff65                	bnez	a4,2ca <strlen+0x12>
 2d4:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 2d8:	60a2                	ld	ra,8(sp)
 2da:	6402                	ld	s0,0(sp)
 2dc:	0141                	addi	sp,sp,16
 2de:	8082                	ret
  for(n = 0; s[n]; n++)
 2e0:	4501                	li	a0,0
 2e2:	bfdd                	j	2d8 <strlen+0x20>

00000000000002e4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2e4:	1141                	addi	sp,sp,-16
 2e6:	e406                	sd	ra,8(sp)
 2e8:	e022                	sd	s0,0(sp)
 2ea:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2ec:	ca19                	beqz	a2,302 <memset+0x1e>
 2ee:	87aa                	mv	a5,a0
 2f0:	1602                	slli	a2,a2,0x20
 2f2:	9201                	srli	a2,a2,0x20
 2f4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2f8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2fc:	0785                	addi	a5,a5,1
 2fe:	fee79de3          	bne	a5,a4,2f8 <memset+0x14>
  }
  return dst;
}
 302:	60a2                	ld	ra,8(sp)
 304:	6402                	ld	s0,0(sp)
 306:	0141                	addi	sp,sp,16
 308:	8082                	ret

000000000000030a <strchr>:

char*
strchr(const char *s, char c)
{
 30a:	1141                	addi	sp,sp,-16
 30c:	e406                	sd	ra,8(sp)
 30e:	e022                	sd	s0,0(sp)
 310:	0800                	addi	s0,sp,16
  for(; *s; s++)
 312:	00054783          	lbu	a5,0(a0)
 316:	c799                	beqz	a5,324 <strchr+0x1a>
    if(*s == c)
 318:	00f58763          	beq	a1,a5,326 <strchr+0x1c>
  for(; *s; s++)
 31c:	0505                	addi	a0,a0,1
 31e:	00054783          	lbu	a5,0(a0)
 322:	fbfd                	bnez	a5,318 <strchr+0xe>
      return (char*)s;
  return 0;
 324:	4501                	li	a0,0
}
 326:	60a2                	ld	ra,8(sp)
 328:	6402                	ld	s0,0(sp)
 32a:	0141                	addi	sp,sp,16
 32c:	8082                	ret

000000000000032e <gets>:

char*
gets(char *buf, int max)
{
 32e:	711d                	addi	sp,sp,-96
 330:	ec86                	sd	ra,88(sp)
 332:	e8a2                	sd	s0,80(sp)
 334:	e4a6                	sd	s1,72(sp)
 336:	e0ca                	sd	s2,64(sp)
 338:	fc4e                	sd	s3,56(sp)
 33a:	f852                	sd	s4,48(sp)
 33c:	f456                	sd	s5,40(sp)
 33e:	f05a                	sd	s6,32(sp)
 340:	ec5e                	sd	s7,24(sp)
 342:	e862                	sd	s8,16(sp)
 344:	1080                	addi	s0,sp,96
 346:	8baa                	mv	s7,a0
 348:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 34a:	892a                	mv	s2,a0
 34c:	4481                	li	s1,0
    cc = read(0, &c, 1);
 34e:	faf40b13          	addi	s6,s0,-81
 352:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 354:	8c26                	mv	s8,s1
 356:	0014899b          	addiw	s3,s1,1
 35a:	84ce                	mv	s1,s3
 35c:	0349d863          	bge	s3,s4,38c <gets+0x5e>
    cc = read(0, &c, 1);
 360:	8656                	mv	a2,s5
 362:	85da                	mv	a1,s6
 364:	4501                	li	a0,0
 366:	1c0000ef          	jal	526 <read>
    if(cc < 1)
 36a:	02a05163          	blez	a0,38c <gets+0x5e>
      break;
    buf[i++] = c;
 36e:	faf44783          	lbu	a5,-81(s0)
 372:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 376:	0905                	addi	s2,s2,1
 378:	ff678713          	addi	a4,a5,-10
 37c:	00173713          	seqz	a4,a4
 380:	17cd                	addi	a5,a5,-13
 382:	0017b793          	seqz	a5,a5
 386:	8fd9                	or	a5,a5,a4
 388:	d7f1                	beqz	a5,354 <gets+0x26>
    buf[i++] = c;
 38a:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 38c:	9c5e                	add	s8,s8,s7
 38e:	000c0023          	sb	zero,0(s8)
  return buf;
}
 392:	855e                	mv	a0,s7
 394:	60e6                	ld	ra,88(sp)
 396:	6446                	ld	s0,80(sp)
 398:	64a6                	ld	s1,72(sp)
 39a:	6906                	ld	s2,64(sp)
 39c:	79e2                	ld	s3,56(sp)
 39e:	7a42                	ld	s4,48(sp)
 3a0:	7aa2                	ld	s5,40(sp)
 3a2:	7b02                	ld	s6,32(sp)
 3a4:	6be2                	ld	s7,24(sp)
 3a6:	6c42                	ld	s8,16(sp)
 3a8:	6125                	addi	sp,sp,96
 3aa:	8082                	ret

00000000000003ac <stat>:

int
stat(const char *n, struct stat *st)
{
 3ac:	1101                	addi	sp,sp,-32
 3ae:	ec06                	sd	ra,24(sp)
 3b0:	e822                	sd	s0,16(sp)
 3b2:	e04a                	sd	s2,0(sp)
 3b4:	1000                	addi	s0,sp,32
 3b6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3b8:	4581                	li	a1,0
 3ba:	194000ef          	jal	54e <open>
  if(fd < 0)
 3be:	02054263          	bltz	a0,3e2 <stat+0x36>
 3c2:	e426                	sd	s1,8(sp)
 3c4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3c6:	85ca                	mv	a1,s2
 3c8:	19e000ef          	jal	566 <fstat>
 3cc:	892a                	mv	s2,a0
  close(fd);
 3ce:	8526                	mv	a0,s1
 3d0:	166000ef          	jal	536 <close>
  return r;
 3d4:	64a2                	ld	s1,8(sp)
}
 3d6:	854a                	mv	a0,s2
 3d8:	60e2                	ld	ra,24(sp)
 3da:	6442                	ld	s0,16(sp)
 3dc:	6902                	ld	s2,0(sp)
 3de:	6105                	addi	sp,sp,32
 3e0:	8082                	ret
    return -1;
 3e2:	57fd                	li	a5,-1
 3e4:	893e                	mv	s2,a5
 3e6:	bfc5                	j	3d6 <stat+0x2a>

00000000000003e8 <atoi>:

int
atoi(const char *s)
{
 3e8:	1141                	addi	sp,sp,-16
 3ea:	e406                	sd	ra,8(sp)
 3ec:	e022                	sd	s0,0(sp)
 3ee:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3f0:	00054683          	lbu	a3,0(a0)
 3f4:	fd06879b          	addiw	a5,a3,-48
 3f8:	0ff7f793          	zext.b	a5,a5
 3fc:	4625                	li	a2,9
 3fe:	02f66963          	bltu	a2,a5,430 <atoi+0x48>
 402:	872a                	mv	a4,a0
  n = 0;
 404:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 406:	0705                	addi	a4,a4,1
 408:	0025179b          	slliw	a5,a0,0x2
 40c:	9fa9                	addw	a5,a5,a0
 40e:	0017979b          	slliw	a5,a5,0x1
 412:	9fb5                	addw	a5,a5,a3
 414:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 418:	00074683          	lbu	a3,0(a4)
 41c:	fd06879b          	addiw	a5,a3,-48
 420:	0ff7f793          	zext.b	a5,a5
 424:	fef671e3          	bgeu	a2,a5,406 <atoi+0x1e>
  return n;
}
 428:	60a2                	ld	ra,8(sp)
 42a:	6402                	ld	s0,0(sp)
 42c:	0141                	addi	sp,sp,16
 42e:	8082                	ret
  n = 0;
 430:	4501                	li	a0,0
 432:	bfdd                	j	428 <atoi+0x40>

0000000000000434 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 434:	1141                	addi	sp,sp,-16
 436:	e406                	sd	ra,8(sp)
 438:	e022                	sd	s0,0(sp)
 43a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 43c:	02b57563          	bgeu	a0,a1,466 <memmove+0x32>
    while(n-- > 0)
 440:	00c05f63          	blez	a2,45e <memmove+0x2a>
 444:	1602                	slli	a2,a2,0x20
 446:	9201                	srli	a2,a2,0x20
 448:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 44c:	872a                	mv	a4,a0
      *dst++ = *src++;
 44e:	0585                	addi	a1,a1,1
 450:	0705                	addi	a4,a4,1
 452:	fff5c683          	lbu	a3,-1(a1)
 456:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 45a:	fee79ae3          	bne	a5,a4,44e <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 45e:	60a2                	ld	ra,8(sp)
 460:	6402                	ld	s0,0(sp)
 462:	0141                	addi	sp,sp,16
 464:	8082                	ret
    while(n-- > 0)
 466:	fec05ce3          	blez	a2,45e <memmove+0x2a>
    dst += n;
 46a:	00c50733          	add	a4,a0,a2
    src += n;
 46e:	95b2                	add	a1,a1,a2
 470:	fff6079b          	addiw	a5,a2,-1
 474:	1782                	slli	a5,a5,0x20
 476:	9381                	srli	a5,a5,0x20
 478:	fff7c793          	not	a5,a5
 47c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 47e:	15fd                	addi	a1,a1,-1
 480:	177d                	addi	a4,a4,-1
 482:	0005c683          	lbu	a3,0(a1)
 486:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 48a:	fef71ae3          	bne	a4,a5,47e <memmove+0x4a>
 48e:	bfc1                	j	45e <memmove+0x2a>

0000000000000490 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 490:	1141                	addi	sp,sp,-16
 492:	e406                	sd	ra,8(sp)
 494:	e022                	sd	s0,0(sp)
 496:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 498:	ce19                	beqz	a2,4b6 <memcmp+0x26>
 49a:	1602                	slli	a2,a2,0x20
 49c:	9201                	srli	a2,a2,0x20
 49e:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 4a2:	00054783          	lbu	a5,0(a0)
 4a6:	0005c703          	lbu	a4,0(a1)
 4aa:	00e79b63          	bne	a5,a4,4c0 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 4ae:	0505                	addi	a0,a0,1
    p2++;
 4b0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4b2:	fed518e3          	bne	a0,a3,4a2 <memcmp+0x12>
  }
  return 0;
 4b6:	4501                	li	a0,0
}
 4b8:	60a2                	ld	ra,8(sp)
 4ba:	6402                	ld	s0,0(sp)
 4bc:	0141                	addi	sp,sp,16
 4be:	8082                	ret
      return *p1 - *p2;
 4c0:	40e7853b          	subw	a0,a5,a4
 4c4:	bfd5                	j	4b8 <memcmp+0x28>

00000000000004c6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4c6:	1141                	addi	sp,sp,-16
 4c8:	e406                	sd	ra,8(sp)
 4ca:	e022                	sd	s0,0(sp)
 4cc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4ce:	f67ff0ef          	jal	434 <memmove>
}
 4d2:	60a2                	ld	ra,8(sp)
 4d4:	6402                	ld	s0,0(sp)
 4d6:	0141                	addi	sp,sp,16
 4d8:	8082                	ret

00000000000004da <sbrk>:

char *
sbrk(int n) {
 4da:	1141                	addi	sp,sp,-16
 4dc:	e406                	sd	ra,8(sp)
 4de:	e022                	sd	s0,0(sp)
 4e0:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 4e2:	4585                	li	a1,1
 4e4:	0b2000ef          	jal	596 <sys_sbrk>
}
 4e8:	60a2                	ld	ra,8(sp)
 4ea:	6402                	ld	s0,0(sp)
 4ec:	0141                	addi	sp,sp,16
 4ee:	8082                	ret

00000000000004f0 <sbrklazy>:

char *
sbrklazy(int n) {
 4f0:	1141                	addi	sp,sp,-16
 4f2:	e406                	sd	ra,8(sp)
 4f4:	e022                	sd	s0,0(sp)
 4f6:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 4f8:	4589                	li	a1,2
 4fa:	09c000ef          	jal	596 <sys_sbrk>
}
 4fe:	60a2                	ld	ra,8(sp)
 500:	6402                	ld	s0,0(sp)
 502:	0141                	addi	sp,sp,16
 504:	8082                	ret

0000000000000506 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 506:	4885                	li	a7,1
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <exit>:
.global exit
exit:
 li a7, SYS_exit
 50e:	4889                	li	a7,2
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <wait>:
.global wait
wait:
 li a7, SYS_wait
 516:	488d                	li	a7,3
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 51e:	4891                	li	a7,4
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <read>:
.global read
read:
 li a7, SYS_read
 526:	4895                	li	a7,5
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <write>:
.global write
write:
 li a7, SYS_write
 52e:	48c1                	li	a7,16
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <close>:
.global close
close:
 li a7, SYS_close
 536:	48d5                	li	a7,21
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <kill>:
.global kill
kill:
 li a7, SYS_kill
 53e:	4899                	li	a7,6
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <exec>:
.global exec
exec:
 li a7, SYS_exec
 546:	489d                	li	a7,7
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <open>:
.global open
open:
 li a7, SYS_open
 54e:	48bd                	li	a7,15
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 556:	48c5                	li	a7,17
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 55e:	48c9                	li	a7,18
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 566:	48a1                	li	a7,8
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <link>:
.global link
link:
 li a7, SYS_link
 56e:	48cd                	li	a7,19
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 576:	48d1                	li	a7,20
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 57e:	48a5                	li	a7,9
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <dup>:
.global dup
dup:
 li a7, SYS_dup
 586:	48a9                	li	a7,10
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 58e:	48ad                	li	a7,11
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 596:	48b1                	li	a7,12
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <pause>:
.global pause
pause:
 li a7, SYS_pause
 59e:	48b5                	li	a7,13
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5a6:	48b9                	li	a7,14
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <bind>:
.global bind
bind:
 li a7, SYS_bind
 5ae:	48f5                	li	a7,29
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 5b6:	48f9                	li	a7,30
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <send>:
.global send
send:
 li a7, SYS_send
 5be:	48fd                	li	a7,31
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <recv>:
.global recv
recv:
 li a7, SYS_recv
 5c6:	02000893          	li	a7,32
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 5d0:	02100893          	li	a7,33
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 5da:	02200893          	li	a7,34
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <rwlktest>:
.global rwlktest
rwlktest:
 li a7, SYS_rwlktest
 5e4:	02300893          	li	a7,35
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <cpupin>:
.global cpupin
cpupin:
 li a7, SYS_cpupin
 5ee:	02400893          	li	a7,36
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5f8:	1101                	addi	sp,sp,-32
 5fa:	ec06                	sd	ra,24(sp)
 5fc:	e822                	sd	s0,16(sp)
 5fe:	1000                	addi	s0,sp,32
 600:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 604:	4605                	li	a2,1
 606:	fef40593          	addi	a1,s0,-17
 60a:	f25ff0ef          	jal	52e <write>
}
 60e:	60e2                	ld	ra,24(sp)
 610:	6442                	ld	s0,16(sp)
 612:	6105                	addi	sp,sp,32
 614:	8082                	ret

0000000000000616 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 616:	715d                	addi	sp,sp,-80
 618:	e486                	sd	ra,72(sp)
 61a:	e0a2                	sd	s0,64(sp)
 61c:	f84a                	sd	s2,48(sp)
 61e:	f44e                	sd	s3,40(sp)
 620:	0880                	addi	s0,sp,80
 622:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 624:	00d036b3          	snez	a3,a3
 628:	03f5d793          	srli	a5,a1,0x3f
 62c:	8efd                	and	a3,a3,a5
  neg = 0;
 62e:	4301                	li	t1,0
  if(sgn && xx < 0){
 630:	c681                	beqz	a3,638 <printint+0x22>
    neg = 1;
    x = -xx;
 632:	40b005b3          	neg	a1,a1
    neg = 1;
 636:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 638:	fb840993          	addi	s3,s0,-72
  neg = 0;
 63c:	86ce                	mv	a3,s3
  i = 0;
 63e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 640:	00000817          	auipc	a6,0x0
 644:	62080813          	addi	a6,a6,1568 # c60 <digits>
 648:	88ba                	mv	a7,a4
 64a:	0017051b          	addiw	a0,a4,1
 64e:	872a                	mv	a4,a0
 650:	02c5f7b3          	remu	a5,a1,a2
 654:	97c2                	add	a5,a5,a6
 656:	0007c783          	lbu	a5,0(a5)
 65a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 65e:	87ae                	mv	a5,a1
 660:	02c5d5b3          	divu	a1,a1,a2
 664:	0685                	addi	a3,a3,1
 666:	fec7f1e3          	bgeu	a5,a2,648 <printint+0x32>
  if(neg)
 66a:	00030b63          	beqz	t1,680 <printint+0x6a>
    buf[i++] = '-';
 66e:	fd040793          	addi	a5,s0,-48
 672:	953e                	add	a0,a0,a5
 674:	02d00793          	li	a5,45
 678:	fef50423          	sb	a5,-24(a0)
 67c:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 680:	02e05563          	blez	a4,6aa <printint+0x94>
 684:	fc26                	sd	s1,56(sp)
 686:	377d                	addiw	a4,a4,-1
 688:	00e984b3          	add	s1,s3,a4
 68c:	19fd                	addi	s3,s3,-1
 68e:	99ba                	add	s3,s3,a4
 690:	1702                	slli	a4,a4,0x20
 692:	9301                	srli	a4,a4,0x20
 694:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 698:	0004c583          	lbu	a1,0(s1)
 69c:	854a                	mv	a0,s2
 69e:	f5bff0ef          	jal	5f8 <putc>
  while(--i >= 0)
 6a2:	14fd                	addi	s1,s1,-1
 6a4:	ff349ae3          	bne	s1,s3,698 <printint+0x82>
 6a8:	74e2                	ld	s1,56(sp)
}
 6aa:	60a6                	ld	ra,72(sp)
 6ac:	6406                	ld	s0,64(sp)
 6ae:	7942                	ld	s2,48(sp)
 6b0:	79a2                	ld	s3,40(sp)
 6b2:	6161                	addi	sp,sp,80
 6b4:	8082                	ret

00000000000006b6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6b6:	711d                	addi	sp,sp,-96
 6b8:	ec86                	sd	ra,88(sp)
 6ba:	e8a2                	sd	s0,80(sp)
 6bc:	e4a6                	sd	s1,72(sp)
 6be:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6c0:	0005c483          	lbu	s1,0(a1)
 6c4:	2a048063          	beqz	s1,964 <vprintf+0x2ae>
 6c8:	e0ca                	sd	s2,64(sp)
 6ca:	fc4e                	sd	s3,56(sp)
 6cc:	f852                	sd	s4,48(sp)
 6ce:	f456                	sd	s5,40(sp)
 6d0:	f05a                	sd	s6,32(sp)
 6d2:	ec5e                	sd	s7,24(sp)
 6d4:	e862                	sd	s8,16(sp)
 6d6:	8b2a                	mv	s6,a0
 6d8:	8a2e                	mv	s4,a1
 6da:	8bb2                	mv	s7,a2
  state = 0;
 6dc:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 6de:	4901                	li	s2,0
 6e0:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 6e2:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 6e6:	06400c13          	li	s8,100
 6ea:	a00d                	j	70c <vprintf+0x56>
        putc(fd, c0);
 6ec:	85a6                	mv	a1,s1
 6ee:	855a                	mv	a0,s6
 6f0:	f09ff0ef          	jal	5f8 <putc>
 6f4:	a019                	j	6fa <vprintf+0x44>
    } else if(state == '%'){
 6f6:	03598363          	beq	s3,s5,71c <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 6fa:	0019079b          	addiw	a5,s2,1
 6fe:	893e                	mv	s2,a5
 700:	873e                	mv	a4,a5
 702:	97d2                	add	a5,a5,s4
 704:	0007c483          	lbu	s1,0(a5)
 708:	24048763          	beqz	s1,956 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 70c:	0004879b          	sext.w	a5,s1
    if(state == 0){
 710:	fe0993e3          	bnez	s3,6f6 <vprintf+0x40>
      if(c0 == '%'){
 714:	fd579ce3          	bne	a5,s5,6ec <vprintf+0x36>
        state = '%';
 718:	89be                	mv	s3,a5
 71a:	b7c5                	j	6fa <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 71c:	00ea06b3          	add	a3,s4,a4
 720:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 724:	24060563          	beqz	a2,96e <vprintf+0x2b8>
      if(c0 == 'd'){
 728:	0b878763          	beq	a5,s8,7d6 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 72c:	f9478693          	addi	a3,a5,-108
 730:	0016b693          	seqz	a3,a3
 734:	f9c60593          	addi	a1,a2,-100
 738:	0015b593          	seqz	a1,a1
 73c:	8df5                	and	a1,a1,a3
 73e:	e9c5                	bnez	a1,7ee <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 740:	9752                	add	a4,a4,s4
 742:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 746:	f9460713          	addi	a4,a2,-108
 74a:	00173713          	seqz	a4,a4
 74e:	8f75                	and	a4,a4,a3
 750:	f9c50593          	addi	a1,a0,-100
 754:	0015b593          	seqz	a1,a1
 758:	8df9                	and	a1,a1,a4
 75a:	e5dd                	bnez	a1,808 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 75c:	07500593          	li	a1,117
 760:	0cb78163          	beq	a5,a1,822 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 764:	f8b60593          	addi	a1,a2,-117
 768:	0015b593          	seqz	a1,a1
 76c:	8df5                	and	a1,a1,a3
 76e:	e5f1                	bnez	a1,83a <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 770:	f8b50593          	addi	a1,a0,-117
 774:	0015b593          	seqz	a1,a1
 778:	8df9                	and	a1,a1,a4
 77a:	ede9                	bnez	a1,854 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 77c:	07800593          	li	a1,120
 780:	0eb78763          	beq	a5,a1,86e <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 784:	f8860613          	addi	a2,a2,-120
 788:	00163613          	seqz	a2,a2
 78c:	8ef1                	and	a3,a3,a2
 78e:	0e069c63          	bnez	a3,886 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 792:	f8850513          	addi	a0,a0,-120
 796:	00153513          	seqz	a0,a0
 79a:	8f69                	and	a4,a4,a0
 79c:	10071263          	bnez	a4,8a0 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 7a0:	07000713          	li	a4,112
 7a4:	10e78a63          	beq	a5,a4,8b8 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 7a8:	06300713          	li	a4,99
 7ac:	14e78a63          	beq	a5,a4,900 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 7b0:	07300713          	li	a4,115
 7b4:	16e78063          	beq	a5,a4,914 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 7b8:	02500713          	li	a4,37
 7bc:	18e78863          	beq	a5,a4,94c <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7c0:	02500593          	li	a1,37
 7c4:	855a                	mv	a0,s6
 7c6:	e33ff0ef          	jal	5f8 <putc>
        putc(fd, c0);
 7ca:	85a6                	mv	a1,s1
 7cc:	855a                	mv	a0,s6
 7ce:	e2bff0ef          	jal	5f8 <putc>
      }

      state = 0;
 7d2:	4981                	li	s3,0
 7d4:	b71d                	j	6fa <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 7d6:	008b8493          	addi	s1,s7,8
 7da:	4685                	li	a3,1
 7dc:	4629                	li	a2,10
 7de:	000ba583          	lw	a1,0(s7)
 7e2:	855a                	mv	a0,s6
 7e4:	e33ff0ef          	jal	616 <printint>
 7e8:	8ba6                	mv	s7,s1
      state = 0;
 7ea:	4981                	li	s3,0
 7ec:	b739                	j	6fa <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7ee:	008b8493          	addi	s1,s7,8
 7f2:	4685                	li	a3,1
 7f4:	4629                	li	a2,10
 7f6:	000bb583          	ld	a1,0(s7)
 7fa:	855a                	mv	a0,s6
 7fc:	e1bff0ef          	jal	616 <printint>
        i += 1;
 800:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 802:	8ba6                	mv	s7,s1
      state = 0;
 804:	4981                	li	s3,0
 806:	bdd5                	j	6fa <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 808:	008b8493          	addi	s1,s7,8
 80c:	4685                	li	a3,1
 80e:	4629                	li	a2,10
 810:	000bb583          	ld	a1,0(s7)
 814:	855a                	mv	a0,s6
 816:	e01ff0ef          	jal	616 <printint>
        i += 2;
 81a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 81c:	8ba6                	mv	s7,s1
      state = 0;
 81e:	4981                	li	s3,0
        i += 2;
 820:	bde9                	j	6fa <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 822:	008b8493          	addi	s1,s7,8
 826:	4681                	li	a3,0
 828:	4629                	li	a2,10
 82a:	000be583          	lwu	a1,0(s7)
 82e:	855a                	mv	a0,s6
 830:	de7ff0ef          	jal	616 <printint>
 834:	8ba6                	mv	s7,s1
      state = 0;
 836:	4981                	li	s3,0
 838:	b5c9                	j	6fa <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 83a:	008b8493          	addi	s1,s7,8
 83e:	4681                	li	a3,0
 840:	4629                	li	a2,10
 842:	000bb583          	ld	a1,0(s7)
 846:	855a                	mv	a0,s6
 848:	dcfff0ef          	jal	616 <printint>
        i += 1;
 84c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 84e:	8ba6                	mv	s7,s1
      state = 0;
 850:	4981                	li	s3,0
 852:	b565                	j	6fa <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 854:	008b8493          	addi	s1,s7,8
 858:	4681                	li	a3,0
 85a:	4629                	li	a2,10
 85c:	000bb583          	ld	a1,0(s7)
 860:	855a                	mv	a0,s6
 862:	db5ff0ef          	jal	616 <printint>
        i += 2;
 866:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 868:	8ba6                	mv	s7,s1
      state = 0;
 86a:	4981                	li	s3,0
        i += 2;
 86c:	b579                	j	6fa <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 86e:	008b8493          	addi	s1,s7,8
 872:	4681                	li	a3,0
 874:	4641                	li	a2,16
 876:	000be583          	lwu	a1,0(s7)
 87a:	855a                	mv	a0,s6
 87c:	d9bff0ef          	jal	616 <printint>
 880:	8ba6                	mv	s7,s1
      state = 0;
 882:	4981                	li	s3,0
 884:	bd9d                	j	6fa <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 886:	008b8493          	addi	s1,s7,8
 88a:	4681                	li	a3,0
 88c:	4641                	li	a2,16
 88e:	000bb583          	ld	a1,0(s7)
 892:	855a                	mv	a0,s6
 894:	d83ff0ef          	jal	616 <printint>
        i += 1;
 898:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 89a:	8ba6                	mv	s7,s1
      state = 0;
 89c:	4981                	li	s3,0
 89e:	bdb1                	j	6fa <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8a0:	008b8493          	addi	s1,s7,8
 8a4:	4641                	li	a2,16
 8a6:	000bb583          	ld	a1,0(s7)
 8aa:	855a                	mv	a0,s6
 8ac:	d6bff0ef          	jal	616 <printint>
        i += 2;
 8b0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 8b2:	8ba6                	mv	s7,s1
      state = 0;
 8b4:	4981                	li	s3,0
        i += 2;
 8b6:	b591                	j	6fa <vprintf+0x44>
 8b8:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 8ba:	008b8793          	addi	a5,s7,8
 8be:	8cbe                	mv	s9,a5
 8c0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8c4:	03000593          	li	a1,48
 8c8:	855a                	mv	a0,s6
 8ca:	d2fff0ef          	jal	5f8 <putc>
  putc(fd, 'x');
 8ce:	07800593          	li	a1,120
 8d2:	855a                	mv	a0,s6
 8d4:	d25ff0ef          	jal	5f8 <putc>
 8d8:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8da:	00000b97          	auipc	s7,0x0
 8de:	386b8b93          	addi	s7,s7,902 # c60 <digits>
 8e2:	03c9d793          	srli	a5,s3,0x3c
 8e6:	97de                	add	a5,a5,s7
 8e8:	0007c583          	lbu	a1,0(a5)
 8ec:	855a                	mv	a0,s6
 8ee:	d0bff0ef          	jal	5f8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8f2:	0992                	slli	s3,s3,0x4
 8f4:	34fd                	addiw	s1,s1,-1
 8f6:	f4f5                	bnez	s1,8e2 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 8f8:	8be6                	mv	s7,s9
      state = 0;
 8fa:	4981                	li	s3,0
 8fc:	6ca2                	ld	s9,8(sp)
 8fe:	bbf5                	j	6fa <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 900:	008b8493          	addi	s1,s7,8
 904:	000bc583          	lbu	a1,0(s7)
 908:	855a                	mv	a0,s6
 90a:	cefff0ef          	jal	5f8 <putc>
 90e:	8ba6                	mv	s7,s1
      state = 0;
 910:	4981                	li	s3,0
 912:	b3e5                	j	6fa <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 914:	008b8993          	addi	s3,s7,8
 918:	000bb483          	ld	s1,0(s7)
 91c:	cc91                	beqz	s1,938 <vprintf+0x282>
        for(; *s; s++)
 91e:	0004c583          	lbu	a1,0(s1)
 922:	c195                	beqz	a1,946 <vprintf+0x290>
          putc(fd, *s);
 924:	855a                	mv	a0,s6
 926:	cd3ff0ef          	jal	5f8 <putc>
        for(; *s; s++)
 92a:	0485                	addi	s1,s1,1
 92c:	0004c583          	lbu	a1,0(s1)
 930:	f9f5                	bnez	a1,924 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 932:	8bce                	mv	s7,s3
      state = 0;
 934:	4981                	li	s3,0
 936:	b3d1                	j	6fa <vprintf+0x44>
          s = "(null)";
 938:	00000497          	auipc	s1,0x0
 93c:	2f848493          	addi	s1,s1,760 # c30 <statistics+0xd4>
        for(; *s; s++)
 940:	02800593          	li	a1,40
 944:	b7c5                	j	924 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 946:	8bce                	mv	s7,s3
      state = 0;
 948:	4981                	li	s3,0
 94a:	bb45                	j	6fa <vprintf+0x44>
        putc(fd, '%');
 94c:	85be                	mv	a1,a5
 94e:	855a                	mv	a0,s6
 950:	ca9ff0ef          	jal	5f8 <putc>
 954:	bdbd                	j	7d2 <vprintf+0x11c>
 956:	6906                	ld	s2,64(sp)
 958:	79e2                	ld	s3,56(sp)
 95a:	7a42                	ld	s4,48(sp)
 95c:	7aa2                	ld	s5,40(sp)
 95e:	7b02                	ld	s6,32(sp)
 960:	6be2                	ld	s7,24(sp)
 962:	6c42                	ld	s8,16(sp)
    }
  }
}
 964:	60e6                	ld	ra,88(sp)
 966:	6446                	ld	s0,80(sp)
 968:	64a6                	ld	s1,72(sp)
 96a:	6125                	addi	sp,sp,96
 96c:	8082                	ret
      if(c0 == 'd'){
 96e:	06400713          	li	a4,100
 972:	e6e782e3          	beq	a5,a4,7d6 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 976:	f9478693          	addi	a3,a5,-108
 97a:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 97e:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 980:	4701                	li	a4,0
 982:	bbe9                	j	75c <vprintf+0xa6>

0000000000000984 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 984:	715d                	addi	sp,sp,-80
 986:	ec06                	sd	ra,24(sp)
 988:	e822                	sd	s0,16(sp)
 98a:	1000                	addi	s0,sp,32
 98c:	e010                	sd	a2,0(s0)
 98e:	e414                	sd	a3,8(s0)
 990:	e818                	sd	a4,16(s0)
 992:	ec1c                	sd	a5,24(s0)
 994:	03043023          	sd	a6,32(s0)
 998:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 99c:	8622                	mv	a2,s0
 99e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9a2:	d15ff0ef          	jal	6b6 <vprintf>
}
 9a6:	60e2                	ld	ra,24(sp)
 9a8:	6442                	ld	s0,16(sp)
 9aa:	6161                	addi	sp,sp,80
 9ac:	8082                	ret

00000000000009ae <printf>:

void
printf(const char *fmt, ...)
{
 9ae:	711d                	addi	sp,sp,-96
 9b0:	ec06                	sd	ra,24(sp)
 9b2:	e822                	sd	s0,16(sp)
 9b4:	1000                	addi	s0,sp,32
 9b6:	e40c                	sd	a1,8(s0)
 9b8:	e810                	sd	a2,16(s0)
 9ba:	ec14                	sd	a3,24(s0)
 9bc:	f018                	sd	a4,32(s0)
 9be:	f41c                	sd	a5,40(s0)
 9c0:	03043823          	sd	a6,48(s0)
 9c4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9c8:	00840613          	addi	a2,s0,8
 9cc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9d0:	85aa                	mv	a1,a0
 9d2:	4505                	li	a0,1
 9d4:	ce3ff0ef          	jal	6b6 <vprintf>
}
 9d8:	60e2                	ld	ra,24(sp)
 9da:	6442                	ld	s0,16(sp)
 9dc:	6125                	addi	sp,sp,96
 9de:	8082                	ret

00000000000009e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9e0:	1141                	addi	sp,sp,-16
 9e2:	e406                	sd	ra,8(sp)
 9e4:	e022                	sd	s0,0(sp)
 9e6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9e8:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ec:	00000797          	auipc	a5,0x0
 9f0:	6147b783          	ld	a5,1556(a5) # 1000 <freep>
 9f4:	a095                	j	a58 <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 9f6:	ff852583          	lw	a1,-8(a0)
 9fa:	6390                	ld	a2,0(a5)
 9fc:	02059813          	slli	a6,a1,0x20
 a00:	01c85693          	srli	a3,a6,0x1c
 a04:	96ba                	add	a3,a3,a4
 a06:	02d60563          	beq	a2,a3,a30 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 a0a:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a0e:	4790                	lw	a2,8(a5)
 a10:	02061593          	slli	a1,a2,0x20
 a14:	01c5d693          	srli	a3,a1,0x1c
 a18:	96be                	add	a3,a3,a5
 a1a:	02d70263          	beq	a4,a3,a3e <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 a1e:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a20:	00000717          	auipc	a4,0x0
 a24:	5ef73023          	sd	a5,1504(a4) # 1000 <freep>
}
 a28:	60a2                	ld	ra,8(sp)
 a2a:	6402                	ld	s0,0(sp)
 a2c:	0141                	addi	sp,sp,16
 a2e:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 a30:	4614                	lw	a3,8(a2)
 a32:	9ead                	addw	a3,a3,a1
 a34:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a38:	6394                	ld	a3,0(a5)
 a3a:	6290                	ld	a2,0(a3)
 a3c:	b7f9                	j	a0a <free+0x2a>
    p->s.size += bp->s.size;
 a3e:	ff852703          	lw	a4,-8(a0)
 a42:	9f31                	addw	a4,a4,a2
 a44:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a46:	ff053703          	ld	a4,-16(a0)
 a4a:	bfd1                	j	a1e <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a4c:	6394                	ld	a3,0(a5)
 a4e:	00d7e463          	bltu	a5,a3,a56 <free+0x76>
 a52:	fad762e3          	bltu	a4,a3,9f6 <free+0x16>
 a56:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a58:	fee7fae3          	bgeu	a5,a4,a4c <free+0x6c>
 a5c:	6394                	ld	a3,0(a5)
 a5e:	f8d76ce3          	bltu	a4,a3,9f6 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a62:	f8d7fae3          	bgeu	a5,a3,9f6 <free+0x16>
 a66:	87b6                	mv	a5,a3
 a68:	bfc5                	j	a58 <free+0x78>

0000000000000a6a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a6a:	7139                	addi	sp,sp,-64
 a6c:	fc06                	sd	ra,56(sp)
 a6e:	f822                	sd	s0,48(sp)
 a70:	f04a                	sd	s2,32(sp)
 a72:	ec4e                	sd	s3,24(sp)
 a74:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a76:	02051993          	slli	s3,a0,0x20
 a7a:	0209d993          	srli	s3,s3,0x20
 a7e:	09bd                	addi	s3,s3,15
 a80:	0049d993          	srli	s3,s3,0x4
 a84:	2985                	addiw	s3,s3,1
 a86:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 a88:	00000517          	auipc	a0,0x0
 a8c:	57853503          	ld	a0,1400(a0) # 1000 <freep>
 a90:	c905                	beqz	a0,ac0 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a92:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a94:	4798                	lw	a4,8(a5)
 a96:	09377663          	bgeu	a4,s3,b22 <malloc+0xb8>
 a9a:	f426                	sd	s1,40(sp)
 a9c:	e852                	sd	s4,16(sp)
 a9e:	e456                	sd	s5,8(sp)
 aa0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 aa2:	8a4e                	mv	s4,s3
 aa4:	6705                	lui	a4,0x1
 aa6:	00e9f363          	bgeu	s3,a4,aac <malloc+0x42>
 aaa:	6a05                	lui	s4,0x1
 aac:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 ab0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ab4:	00000497          	auipc	s1,0x0
 ab8:	54c48493          	addi	s1,s1,1356 # 1000 <freep>
  if(p == SBRK_ERROR)
 abc:	5afd                	li	s5,-1
 abe:	a83d                	j	afc <malloc+0x92>
 ac0:	f426                	sd	s1,40(sp)
 ac2:	e852                	sd	s4,16(sp)
 ac4:	e456                	sd	s5,8(sp)
 ac6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 ac8:	00000797          	auipc	a5,0x0
 acc:	55878793          	addi	a5,a5,1368 # 1020 <base>
 ad0:	00000717          	auipc	a4,0x0
 ad4:	52f73823          	sd	a5,1328(a4) # 1000 <freep>
 ad8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ada:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ade:	b7d1                	j	aa2 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 ae0:	6398                	ld	a4,0(a5)
 ae2:	e118                	sd	a4,0(a0)
 ae4:	a899                	j	b3a <malloc+0xd0>
  hp->s.size = nu;
 ae6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 aea:	0541                	addi	a0,a0,16
 aec:	ef5ff0ef          	jal	9e0 <free>
  return freep;
 af0:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 af2:	c125                	beqz	a0,b52 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 af4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 af6:	4798                	lw	a4,8(a5)
 af8:	03277163          	bgeu	a4,s2,b1a <malloc+0xb0>
    if(p == freep)
 afc:	6098                	ld	a4,0(s1)
 afe:	853e                	mv	a0,a5
 b00:	fef71ae3          	bne	a4,a5,af4 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 b04:	8552                	mv	a0,s4
 b06:	9d5ff0ef          	jal	4da <sbrk>
  if(p == SBRK_ERROR)
 b0a:	fd551ee3          	bne	a0,s5,ae6 <malloc+0x7c>
        return 0;
 b0e:	4501                	li	a0,0
 b10:	74a2                	ld	s1,40(sp)
 b12:	6a42                	ld	s4,16(sp)
 b14:	6aa2                	ld	s5,8(sp)
 b16:	6b02                	ld	s6,0(sp)
 b18:	a03d                	j	b46 <malloc+0xdc>
 b1a:	74a2                	ld	s1,40(sp)
 b1c:	6a42                	ld	s4,16(sp)
 b1e:	6aa2                	ld	s5,8(sp)
 b20:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b22:	fae90fe3          	beq	s2,a4,ae0 <malloc+0x76>
        p->s.size -= nunits;
 b26:	4137073b          	subw	a4,a4,s3
 b2a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b2c:	02071693          	slli	a3,a4,0x20
 b30:	01c6d713          	srli	a4,a3,0x1c
 b34:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b36:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b3a:	00000717          	auipc	a4,0x0
 b3e:	4ca73323          	sd	a0,1222(a4) # 1000 <freep>
      return (void*)(p + 1);
 b42:	01078513          	addi	a0,a5,16
  }
}
 b46:	70e2                	ld	ra,56(sp)
 b48:	7442                	ld	s0,48(sp)
 b4a:	7902                	ld	s2,32(sp)
 b4c:	69e2                	ld	s3,24(sp)
 b4e:	6121                	addi	sp,sp,64
 b50:	8082                	ret
 b52:	74a2                	ld	s1,40(sp)
 b54:	6a42                	ld	s4,16(sp)
 b56:	6aa2                	ld	s5,8(sp)
 b58:	6b02                	ld	s6,0(sp)
 b5a:	b7f5                	j	b46 <malloc+0xdc>

0000000000000b5c <statistics>:
#include "kernel/fcntl.h"
#include "user/user.h"

int
statistics(void *buf, int sz)
{
 b5c:	7179                	addi	sp,sp,-48
 b5e:	f406                	sd	ra,40(sp)
 b60:	f022                	sd	s0,32(sp)
 b62:	ec26                	sd	s1,24(sp)
 b64:	e84a                	sd	s2,16(sp)
 b66:	e44e                	sd	s3,8(sp)
 b68:	e052                	sd	s4,0(sp)
 b6a:	1800                	addi	s0,sp,48
 b6c:	8a2a                	mv	s4,a0
 b6e:	892e                	mv	s2,a1
  int fd, i, n;
  
  fd = open("statistics", O_RDONLY);
 b70:	4581                	li	a1,0
 b72:	00000517          	auipc	a0,0x0
 b76:	0c650513          	addi	a0,a0,198 # c38 <statistics+0xdc>
 b7a:	9d5ff0ef          	jal	54e <open>
  if(fd < 0) {
 b7e:	02054e63          	bltz	a0,bba <statistics+0x5e>
 b82:	89aa                	mv	s3,a0
      fprintf(2, "stats: open failed\n");
      exit(1);
  }
  for (i = 0; i < sz; ) {
 b84:	4481                	li	s1,0
 b86:	01205e63          	blez	s2,ba2 <statistics+0x46>
    if ((n = read(fd, buf+i, sz-i)) < 0) {
 b8a:	4099063b          	subw	a2,s2,s1
 b8e:	009a05b3          	add	a1,s4,s1
 b92:	854e                	mv	a0,s3
 b94:	993ff0ef          	jal	526 <read>
 b98:	00054563          	bltz	a0,ba2 <statistics+0x46>
      break;
    }
    i += n;
 b9c:	9ca9                	addw	s1,s1,a0
  for (i = 0; i < sz; ) {
 b9e:	ff24c6e3          	blt	s1,s2,b8a <statistics+0x2e>
  }
  close(fd);
 ba2:	854e                	mv	a0,s3
 ba4:	993ff0ef          	jal	536 <close>
  return i;
}
 ba8:	8526                	mv	a0,s1
 baa:	70a2                	ld	ra,40(sp)
 bac:	7402                	ld	s0,32(sp)
 bae:	64e2                	ld	s1,24(sp)
 bb0:	6942                	ld	s2,16(sp)
 bb2:	69a2                	ld	s3,8(sp)
 bb4:	6a02                	ld	s4,0(sp)
 bb6:	6145                	addi	sp,sp,48
 bb8:	8082                	ret
      fprintf(2, "stats: open failed\n");
 bba:	00000597          	auipc	a1,0x0
 bbe:	08e58593          	addi	a1,a1,142 # c48 <statistics+0xec>
 bc2:	4509                	li	a0,2
 bc4:	dc1ff0ef          	jal	984 <fprintf>
      exit(1);
 bc8:	4505                	li	a0,1
 bca:	945ff0ef          	jal	50e <exit>
