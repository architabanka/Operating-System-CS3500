
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
   c:	2ae000ef          	jal	2ba <strlen>
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
  34:	286000ef          	jal	2ba <strlen>
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
  4e:	26c000ef          	jal	2ba <strlen>
  52:	862a                	mv	a2,a0
  54:	85a6                	mv	a1,s1
  56:	00001517          	auipc	a0,0x1
  5a:	fba50513          	addi	a0,a0,-70 # 1010 <buf.0>
  5e:	3d8000ef          	jal	436 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  62:	8526                	mv	a0,s1
  64:	256000ef          	jal	2ba <strlen>
  68:	892a                	mv	s2,a0
  6a:	8526                	mv	a0,s1
  6c:	24e000ef          	jal	2ba <strlen>
  70:	02091793          	slli	a5,s2,0x20
  74:	9381                	srli	a5,a5,0x20
  76:	4639                	li	a2,14
  78:	9e09                	subw	a2,a2,a0
  7a:	02000593          	li	a1,32
  7e:	00001717          	auipc	a4,0x1
  82:	f9270713          	addi	a4,a4,-110 # 1010 <buf.0>
  86:	84ba                	mv	s1,a4
  88:	00f70533          	add	a0,a4,a5
  8c:	25a000ef          	jal	2e6 <memset>
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
  ae:	4a2000ef          	jal	550 <open>
  b2:	06054363          	bltz	a0,118 <ls+0x80>
  b6:	24913423          	sd	s1,584(sp)
  ba:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  bc:	da840593          	addi	a1,s0,-600
  c0:	4a8000ef          	jal	568 <fstat>
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
  f4:	a6050513          	addi	a0,a0,-1440 # b50 <malloc+0x126>
  f8:	077000ef          	jal	96e <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
    }
    break;
  }
  close(fd);
  fc:	8526                	mv	a0,s1
  fe:	43a000ef          	jal	538 <close>
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
 11e:	a0658593          	addi	a1,a1,-1530 # b20 <malloc+0xf6>
 122:	4509                	li	a0,2
 124:	021000ef          	jal	944 <fprintf>
    return;
 128:	bff9                	j	106 <ls+0x6e>
    fprintf(2, "ls: cannot stat %s\n", path);
 12a:	864a                	mv	a2,s2
 12c:	00001597          	auipc	a1,0x1
 130:	a0c58593          	addi	a1,a1,-1524 # b38 <malloc+0x10e>
 134:	4509                	li	a0,2
 136:	00f000ef          	jal	944 <fprintf>
    close(fd);
 13a:	8526                	mv	a0,s1
 13c:	3fc000ef          	jal	538 <close>
    return;
 140:	24813483          	ld	s1,584(sp)
 144:	b7c9                	j	106 <ls+0x6e>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 146:	854a                	mv	a0,s2
 148:	172000ef          	jal	2ba <strlen>
 14c:	2541                	addiw	a0,a0,16
 14e:	20000793          	li	a5,512
 152:	00a7f963          	bgeu	a5,a0,164 <ls+0xcc>
      printf("ls: path too long\n");
 156:	00001517          	auipc	a0,0x1
 15a:	a0a50513          	addi	a0,a0,-1526 # b60 <malloc+0x136>
 15e:	011000ef          	jal	96e <printf>
      break;
 162:	bf69                	j	fc <ls+0x64>
 164:	23313c23          	sd	s3,568(sp)
    strcpy(buf, path);
 168:	85ca                	mv	a1,s2
 16a:	dd040513          	addi	a0,s0,-560
 16e:	0fc000ef          	jal	26a <strcpy>
    p = buf+strlen(buf);
 172:	dd040513          	addi	a0,s0,-560
 176:	144000ef          	jal	2ba <strlen>
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
 1a0:	99c50513          	addi	a0,a0,-1636 # b38 <malloc+0x10e>
 1a4:	7ca000ef          	jal	96e <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1a8:	4641                	li	a2,16
 1aa:	dc040593          	addi	a1,s0,-576
 1ae:	8526                	mv	a0,s1
 1b0:	378000ef          	jal	528 <read>
 1b4:	47c1                	li	a5,16
 1b6:	04f51763          	bne	a0,a5,204 <ls+0x16c>
      if(de.inum == 0)
 1ba:	dc045783          	lhu	a5,-576(s0)
 1be:	d7ed                	beqz	a5,1a8 <ls+0x110>
      memmove(p, de.name, DIRSIZ);
 1c0:	4639                	li	a2,14
 1c2:	dc240593          	addi	a1,s0,-574
 1c6:	854e                	mv	a0,s3
 1c8:	26e000ef          	jal	436 <memmove>
      p[DIRSIZ] = 0;
 1cc:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 1d0:	da840593          	addi	a1,s0,-600
 1d4:	dd040513          	addi	a0,s0,-560
 1d8:	1d6000ef          	jal	3ae <stat>
 1dc:	fa054ee3          	bltz	a0,198 <ls+0x100>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 1e0:	dd040513          	addi	a0,s0,-560
 1e4:	e1dff0ef          	jal	0 <fmtname>
 1e8:	85aa                	mv	a1,a0
 1ea:	db842703          	lw	a4,-584(s0)
 1ee:	dac42683          	lw	a3,-596(s0)
 1f2:	db041603          	lh	a2,-592(s0)
 1f6:	00001517          	auipc	a0,0x1
 1fa:	95a50513          	addi	a0,a0,-1702 # b50 <malloc+0x126>
 1fe:	770000ef          	jal	96e <printf>
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
 23e:	2d2000ef          	jal	510 <exit>
 242:	e426                	sd	s1,8(sp)
 244:	e04a                	sd	s2,0(sp)
    ls(".");
 246:	00001517          	auipc	a0,0x1
 24a:	93250513          	addi	a0,a0,-1742 # b78 <malloc+0x14e>
 24e:	e4bff0ef          	jal	98 <ls>
    exit(0);
 252:	4501                	li	a0,0
 254:	2bc000ef          	jal	510 <exit>

0000000000000258 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 258:	1141                	addi	sp,sp,-16
 25a:	e406                	sd	ra,8(sp)
 25c:	e022                	sd	s0,0(sp)
 25e:	0800                	addi	s0,sp,16
  extern int main();
  main();
 260:	fabff0ef          	jal	20a <main>
  exit(0);
 264:	4501                	li	a0,0
 266:	2aa000ef          	jal	510 <exit>

000000000000026a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 26a:	1141                	addi	sp,sp,-16
 26c:	e406                	sd	ra,8(sp)
 26e:	e022                	sd	s0,0(sp)
 270:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 272:	87aa                	mv	a5,a0
 274:	0585                	addi	a1,a1,1
 276:	0785                	addi	a5,a5,1
 278:	fff5c703          	lbu	a4,-1(a1)
 27c:	fee78fa3          	sb	a4,-1(a5)
 280:	fb75                	bnez	a4,274 <strcpy+0xa>
    ;
  return os;
}
 282:	60a2                	ld	ra,8(sp)
 284:	6402                	ld	s0,0(sp)
 286:	0141                	addi	sp,sp,16
 288:	8082                	ret

000000000000028a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 28a:	1141                	addi	sp,sp,-16
 28c:	e406                	sd	ra,8(sp)
 28e:	e022                	sd	s0,0(sp)
 290:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 292:	00054783          	lbu	a5,0(a0)
 296:	cb91                	beqz	a5,2aa <strcmp+0x20>
 298:	0005c703          	lbu	a4,0(a1)
 29c:	00f71763          	bne	a4,a5,2aa <strcmp+0x20>
    p++, q++;
 2a0:	0505                	addi	a0,a0,1
 2a2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2a4:	00054783          	lbu	a5,0(a0)
 2a8:	fbe5                	bnez	a5,298 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 2aa:	0005c503          	lbu	a0,0(a1)
}
 2ae:	40a7853b          	subw	a0,a5,a0
 2b2:	60a2                	ld	ra,8(sp)
 2b4:	6402                	ld	s0,0(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret

00000000000002ba <strlen>:

uint
strlen(const char *s)
{
 2ba:	1141                	addi	sp,sp,-16
 2bc:	e406                	sd	ra,8(sp)
 2be:	e022                	sd	s0,0(sp)
 2c0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2c2:	00054783          	lbu	a5,0(a0)
 2c6:	cf91                	beqz	a5,2e2 <strlen+0x28>
 2c8:	00150793          	addi	a5,a0,1
 2cc:	86be                	mv	a3,a5
 2ce:	0785                	addi	a5,a5,1
 2d0:	fff7c703          	lbu	a4,-1(a5)
 2d4:	ff65                	bnez	a4,2cc <strlen+0x12>
 2d6:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 2da:	60a2                	ld	ra,8(sp)
 2dc:	6402                	ld	s0,0(sp)
 2de:	0141                	addi	sp,sp,16
 2e0:	8082                	ret
  for(n = 0; s[n]; n++)
 2e2:	4501                	li	a0,0
 2e4:	bfdd                	j	2da <strlen+0x20>

00000000000002e6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2e6:	1141                	addi	sp,sp,-16
 2e8:	e406                	sd	ra,8(sp)
 2ea:	e022                	sd	s0,0(sp)
 2ec:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2ee:	ca19                	beqz	a2,304 <memset+0x1e>
 2f0:	87aa                	mv	a5,a0
 2f2:	1602                	slli	a2,a2,0x20
 2f4:	9201                	srli	a2,a2,0x20
 2f6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2fa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2fe:	0785                	addi	a5,a5,1
 300:	fee79de3          	bne	a5,a4,2fa <memset+0x14>
  }
  return dst;
}
 304:	60a2                	ld	ra,8(sp)
 306:	6402                	ld	s0,0(sp)
 308:	0141                	addi	sp,sp,16
 30a:	8082                	ret

000000000000030c <strchr>:

char*
strchr(const char *s, char c)
{
 30c:	1141                	addi	sp,sp,-16
 30e:	e406                	sd	ra,8(sp)
 310:	e022                	sd	s0,0(sp)
 312:	0800                	addi	s0,sp,16
  for(; *s; s++)
 314:	00054783          	lbu	a5,0(a0)
 318:	c799                	beqz	a5,326 <strchr+0x1a>
    if(*s == c)
 31a:	00f58763          	beq	a1,a5,328 <strchr+0x1c>
  for(; *s; s++)
 31e:	0505                	addi	a0,a0,1
 320:	00054783          	lbu	a5,0(a0)
 324:	fbfd                	bnez	a5,31a <strchr+0xe>
      return (char*)s;
  return 0;
 326:	4501                	li	a0,0
}
 328:	60a2                	ld	ra,8(sp)
 32a:	6402                	ld	s0,0(sp)
 32c:	0141                	addi	sp,sp,16
 32e:	8082                	ret

0000000000000330 <gets>:

char*
gets(char *buf, int max)
{
 330:	711d                	addi	sp,sp,-96
 332:	ec86                	sd	ra,88(sp)
 334:	e8a2                	sd	s0,80(sp)
 336:	e4a6                	sd	s1,72(sp)
 338:	e0ca                	sd	s2,64(sp)
 33a:	fc4e                	sd	s3,56(sp)
 33c:	f852                	sd	s4,48(sp)
 33e:	f456                	sd	s5,40(sp)
 340:	f05a                	sd	s6,32(sp)
 342:	ec5e                	sd	s7,24(sp)
 344:	e862                	sd	s8,16(sp)
 346:	1080                	addi	s0,sp,96
 348:	8baa                	mv	s7,a0
 34a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 34c:	892a                	mv	s2,a0
 34e:	4481                	li	s1,0
    cc = read(0, &c, 1);
 350:	faf40b13          	addi	s6,s0,-81
 354:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 356:	8c26                	mv	s8,s1
 358:	0014899b          	addiw	s3,s1,1
 35c:	84ce                	mv	s1,s3
 35e:	0349d863          	bge	s3,s4,38e <gets+0x5e>
    cc = read(0, &c, 1);
 362:	8656                	mv	a2,s5
 364:	85da                	mv	a1,s6
 366:	4501                	li	a0,0
 368:	1c0000ef          	jal	528 <read>
    if(cc < 1)
 36c:	02a05163          	blez	a0,38e <gets+0x5e>
      break;
    buf[i++] = c;
 370:	faf44783          	lbu	a5,-81(s0)
 374:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 378:	0905                	addi	s2,s2,1
 37a:	ff678713          	addi	a4,a5,-10
 37e:	00173713          	seqz	a4,a4
 382:	17cd                	addi	a5,a5,-13
 384:	0017b793          	seqz	a5,a5
 388:	8fd9                	or	a5,a5,a4
 38a:	d7f1                	beqz	a5,356 <gets+0x26>
    buf[i++] = c;
 38c:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 38e:	9c5e                	add	s8,s8,s7
 390:	000c0023          	sb	zero,0(s8)
  return buf;
}
 394:	855e                	mv	a0,s7
 396:	60e6                	ld	ra,88(sp)
 398:	6446                	ld	s0,80(sp)
 39a:	64a6                	ld	s1,72(sp)
 39c:	6906                	ld	s2,64(sp)
 39e:	79e2                	ld	s3,56(sp)
 3a0:	7a42                	ld	s4,48(sp)
 3a2:	7aa2                	ld	s5,40(sp)
 3a4:	7b02                	ld	s6,32(sp)
 3a6:	6be2                	ld	s7,24(sp)
 3a8:	6c42                	ld	s8,16(sp)
 3aa:	6125                	addi	sp,sp,96
 3ac:	8082                	ret

00000000000003ae <stat>:

int
stat(const char *n, struct stat *st)
{
 3ae:	1101                	addi	sp,sp,-32
 3b0:	ec06                	sd	ra,24(sp)
 3b2:	e822                	sd	s0,16(sp)
 3b4:	e04a                	sd	s2,0(sp)
 3b6:	1000                	addi	s0,sp,32
 3b8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3ba:	4581                	li	a1,0
 3bc:	194000ef          	jal	550 <open>
  if(fd < 0)
 3c0:	02054263          	bltz	a0,3e4 <stat+0x36>
 3c4:	e426                	sd	s1,8(sp)
 3c6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3c8:	85ca                	mv	a1,s2
 3ca:	19e000ef          	jal	568 <fstat>
 3ce:	892a                	mv	s2,a0
  close(fd);
 3d0:	8526                	mv	a0,s1
 3d2:	166000ef          	jal	538 <close>
  return r;
 3d6:	64a2                	ld	s1,8(sp)
}
 3d8:	854a                	mv	a0,s2
 3da:	60e2                	ld	ra,24(sp)
 3dc:	6442                	ld	s0,16(sp)
 3de:	6902                	ld	s2,0(sp)
 3e0:	6105                	addi	sp,sp,32
 3e2:	8082                	ret
    return -1;
 3e4:	57fd                	li	a5,-1
 3e6:	893e                	mv	s2,a5
 3e8:	bfc5                	j	3d8 <stat+0x2a>

00000000000003ea <atoi>:

int
atoi(const char *s)
{
 3ea:	1141                	addi	sp,sp,-16
 3ec:	e406                	sd	ra,8(sp)
 3ee:	e022                	sd	s0,0(sp)
 3f0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3f2:	00054683          	lbu	a3,0(a0)
 3f6:	fd06879b          	addiw	a5,a3,-48
 3fa:	0ff7f793          	zext.b	a5,a5
 3fe:	4625                	li	a2,9
 400:	02f66963          	bltu	a2,a5,432 <atoi+0x48>
 404:	872a                	mv	a4,a0
  n = 0;
 406:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 408:	0705                	addi	a4,a4,1
 40a:	0025179b          	slliw	a5,a0,0x2
 40e:	9fa9                	addw	a5,a5,a0
 410:	0017979b          	slliw	a5,a5,0x1
 414:	9fb5                	addw	a5,a5,a3
 416:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 41a:	00074683          	lbu	a3,0(a4)
 41e:	fd06879b          	addiw	a5,a3,-48
 422:	0ff7f793          	zext.b	a5,a5
 426:	fef671e3          	bgeu	a2,a5,408 <atoi+0x1e>
  return n;
}
 42a:	60a2                	ld	ra,8(sp)
 42c:	6402                	ld	s0,0(sp)
 42e:	0141                	addi	sp,sp,16
 430:	8082                	ret
  n = 0;
 432:	4501                	li	a0,0
 434:	bfdd                	j	42a <atoi+0x40>

0000000000000436 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 436:	1141                	addi	sp,sp,-16
 438:	e406                	sd	ra,8(sp)
 43a:	e022                	sd	s0,0(sp)
 43c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 43e:	02b57563          	bgeu	a0,a1,468 <memmove+0x32>
    while(n-- > 0)
 442:	00c05f63          	blez	a2,460 <memmove+0x2a>
 446:	1602                	slli	a2,a2,0x20
 448:	9201                	srli	a2,a2,0x20
 44a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 44e:	872a                	mv	a4,a0
      *dst++ = *src++;
 450:	0585                	addi	a1,a1,1
 452:	0705                	addi	a4,a4,1
 454:	fff5c683          	lbu	a3,-1(a1)
 458:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 45c:	fee79ae3          	bne	a5,a4,450 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 460:	60a2                	ld	ra,8(sp)
 462:	6402                	ld	s0,0(sp)
 464:	0141                	addi	sp,sp,16
 466:	8082                	ret
    while(n-- > 0)
 468:	fec05ce3          	blez	a2,460 <memmove+0x2a>
    dst += n;
 46c:	00c50733          	add	a4,a0,a2
    src += n;
 470:	95b2                	add	a1,a1,a2
 472:	fff6079b          	addiw	a5,a2,-1
 476:	1782                	slli	a5,a5,0x20
 478:	9381                	srli	a5,a5,0x20
 47a:	fff7c793          	not	a5,a5
 47e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 480:	15fd                	addi	a1,a1,-1
 482:	177d                	addi	a4,a4,-1
 484:	0005c683          	lbu	a3,0(a1)
 488:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 48c:	fef71ae3          	bne	a4,a5,480 <memmove+0x4a>
 490:	bfc1                	j	460 <memmove+0x2a>

0000000000000492 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 492:	1141                	addi	sp,sp,-16
 494:	e406                	sd	ra,8(sp)
 496:	e022                	sd	s0,0(sp)
 498:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 49a:	ce19                	beqz	a2,4b8 <memcmp+0x26>
 49c:	1602                	slli	a2,a2,0x20
 49e:	9201                	srli	a2,a2,0x20
 4a0:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 4a4:	00054783          	lbu	a5,0(a0)
 4a8:	0005c703          	lbu	a4,0(a1)
 4ac:	00e79b63          	bne	a5,a4,4c2 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 4b0:	0505                	addi	a0,a0,1
    p2++;
 4b2:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4b4:	fed518e3          	bne	a0,a3,4a4 <memcmp+0x12>
  }
  return 0;
 4b8:	4501                	li	a0,0
}
 4ba:	60a2                	ld	ra,8(sp)
 4bc:	6402                	ld	s0,0(sp)
 4be:	0141                	addi	sp,sp,16
 4c0:	8082                	ret
      return *p1 - *p2;
 4c2:	40e7853b          	subw	a0,a5,a4
 4c6:	bfd5                	j	4ba <memcmp+0x28>

00000000000004c8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4c8:	1141                	addi	sp,sp,-16
 4ca:	e406                	sd	ra,8(sp)
 4cc:	e022                	sd	s0,0(sp)
 4ce:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4d0:	f67ff0ef          	jal	436 <memmove>
}
 4d4:	60a2                	ld	ra,8(sp)
 4d6:	6402                	ld	s0,0(sp)
 4d8:	0141                	addi	sp,sp,16
 4da:	8082                	ret

00000000000004dc <sbrk>:

char *
sbrk(int n) {
 4dc:	1141                	addi	sp,sp,-16
 4de:	e406                	sd	ra,8(sp)
 4e0:	e022                	sd	s0,0(sp)
 4e2:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 4e4:	4585                	li	a1,1
 4e6:	0b2000ef          	jal	598 <sys_sbrk>
}
 4ea:	60a2                	ld	ra,8(sp)
 4ec:	6402                	ld	s0,0(sp)
 4ee:	0141                	addi	sp,sp,16
 4f0:	8082                	ret

00000000000004f2 <sbrklazy>:

char *
sbrklazy(int n) {
 4f2:	1141                	addi	sp,sp,-16
 4f4:	e406                	sd	ra,8(sp)
 4f6:	e022                	sd	s0,0(sp)
 4f8:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 4fa:	4589                	li	a1,2
 4fc:	09c000ef          	jal	598 <sys_sbrk>
}
 500:	60a2                	ld	ra,8(sp)
 502:	6402                	ld	s0,0(sp)
 504:	0141                	addi	sp,sp,16
 506:	8082                	ret

0000000000000508 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 508:	4885                	li	a7,1
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <exit>:
.global exit
exit:
 li a7, SYS_exit
 510:	4889                	li	a7,2
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <wait>:
.global wait
wait:
 li a7, SYS_wait
 518:	488d                	li	a7,3
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 520:	4891                	li	a7,4
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <read>:
.global read
read:
 li a7, SYS_read
 528:	4895                	li	a7,5
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <write>:
.global write
write:
 li a7, SYS_write
 530:	48c1                	li	a7,16
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <close>:
.global close
close:
 li a7, SYS_close
 538:	48d5                	li	a7,21
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <kill>:
.global kill
kill:
 li a7, SYS_kill
 540:	4899                	li	a7,6
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <exec>:
.global exec
exec:
 li a7, SYS_exec
 548:	489d                	li	a7,7
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <open>:
.global open
open:
 li a7, SYS_open
 550:	48bd                	li	a7,15
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 558:	48c5                	li	a7,17
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 560:	48c9                	li	a7,18
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 568:	48a1                	li	a7,8
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <link>:
.global link
link:
 li a7, SYS_link
 570:	48cd                	li	a7,19
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 578:	48d1                	li	a7,20
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 580:	48a5                	li	a7,9
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <dup>:
.global dup
dup:
 li a7, SYS_dup
 588:	48a9                	li	a7,10
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 590:	48ad                	li	a7,11
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 598:	48b1                	li	a7,12
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <pause>:
.global pause
pause:
 li a7, SYS_pause
 5a0:	48b5                	li	a7,13
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5a8:	48b9                	li	a7,14
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5b0:	1101                	addi	sp,sp,-32
 5b2:	ec06                	sd	ra,24(sp)
 5b4:	e822                	sd	s0,16(sp)
 5b6:	1000                	addi	s0,sp,32
 5b8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5bc:	4605                	li	a2,1
 5be:	fef40593          	addi	a1,s0,-17
 5c2:	f6fff0ef          	jal	530 <write>
}
 5c6:	60e2                	ld	ra,24(sp)
 5c8:	6442                	ld	s0,16(sp)
 5ca:	6105                	addi	sp,sp,32
 5cc:	8082                	ret

00000000000005ce <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 5ce:	715d                	addi	sp,sp,-80
 5d0:	e486                	sd	ra,72(sp)
 5d2:	e0a2                	sd	s0,64(sp)
 5d4:	f84a                	sd	s2,48(sp)
 5d6:	f44e                	sd	s3,40(sp)
 5d8:	0880                	addi	s0,sp,80
 5da:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5dc:	00d036b3          	snez	a3,a3
 5e0:	03f5d793          	srli	a5,a1,0x3f
 5e4:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5e6:	0005871b          	sext.w	a4,a1
  neg = 0;
 5ea:	4301                	li	t1,0
  if(sgn && xx < 0){
 5ec:	c681                	beqz	a3,5f4 <printint+0x26>
    x = -xx;
 5ee:	40b0073b          	negw	a4,a1
    neg = 1;
 5f2:	4305                	li	t1,1
  }

  i = 0;
 5f4:	fb840993          	addi	s3,s0,-72
  neg = 0;
 5f8:	85ce                	mv	a1,s3
  i = 0;
 5fa:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 5fc:	00000817          	auipc	a6,0x0
 600:	58c80813          	addi	a6,a6,1420 # b88 <digits>
 604:	88b6                	mv	a7,a3
 606:	0016851b          	addiw	a0,a3,1
 60a:	86aa                	mv	a3,a0
 60c:	02c777bb          	remuw	a5,a4,a2
 610:	1782                	slli	a5,a5,0x20
 612:	9381                	srli	a5,a5,0x20
 614:	97c2                	add	a5,a5,a6
 616:	0007c783          	lbu	a5,0(a5)
 61a:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 61e:	87ba                	mv	a5,a4
 620:	02c7573b          	divuw	a4,a4,a2
 624:	0585                	addi	a1,a1,1
 626:	fcc7ffe3          	bgeu	a5,a2,604 <printint+0x36>
  if(neg)
 62a:	00030b63          	beqz	t1,640 <printint+0x72>
    buf[i++] = '-';
 62e:	fd040793          	addi	a5,s0,-48
 632:	953e                	add	a0,a0,a5
 634:	02d00793          	li	a5,45
 638:	fef50423          	sb	a5,-24(a0)
 63c:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 640:	02d05563          	blez	a3,66a <printint+0x9c>
 644:	fc26                	sd	s1,56(sp)
 646:	36fd                	addiw	a3,a3,-1
 648:	00d984b3          	add	s1,s3,a3
 64c:	19fd                	addi	s3,s3,-1
 64e:	99b6                	add	s3,s3,a3
 650:	1682                	slli	a3,a3,0x20
 652:	9281                	srli	a3,a3,0x20
 654:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 658:	0004c583          	lbu	a1,0(s1)
 65c:	854a                	mv	a0,s2
 65e:	f53ff0ef          	jal	5b0 <putc>
  while(--i >= 0)
 662:	14fd                	addi	s1,s1,-1
 664:	ff349ae3          	bne	s1,s3,658 <printint+0x8a>
 668:	74e2                	ld	s1,56(sp)
}
 66a:	60a6                	ld	ra,72(sp)
 66c:	6406                	ld	s0,64(sp)
 66e:	7942                	ld	s2,48(sp)
 670:	79a2                	ld	s3,40(sp)
 672:	6161                	addi	sp,sp,80
 674:	8082                	ret

0000000000000676 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 676:	711d                	addi	sp,sp,-96
 678:	ec86                	sd	ra,88(sp)
 67a:	e8a2                	sd	s0,80(sp)
 67c:	e4a6                	sd	s1,72(sp)
 67e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 680:	0005c483          	lbu	s1,0(a1)
 684:	2a048063          	beqz	s1,924 <vprintf+0x2ae>
 688:	e0ca                	sd	s2,64(sp)
 68a:	fc4e                	sd	s3,56(sp)
 68c:	f852                	sd	s4,48(sp)
 68e:	f456                	sd	s5,40(sp)
 690:	f05a                	sd	s6,32(sp)
 692:	ec5e                	sd	s7,24(sp)
 694:	e862                	sd	s8,16(sp)
 696:	8b2a                	mv	s6,a0
 698:	8a2e                	mv	s4,a1
 69a:	8bb2                	mv	s7,a2
  state = 0;
 69c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 69e:	4901                	li	s2,0
 6a0:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 6a2:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 6a6:	06400c13          	li	s8,100
 6aa:	a00d                	j	6cc <vprintf+0x56>
        putc(fd, c0);
 6ac:	85a6                	mv	a1,s1
 6ae:	855a                	mv	a0,s6
 6b0:	f01ff0ef          	jal	5b0 <putc>
 6b4:	a019                	j	6ba <vprintf+0x44>
    } else if(state == '%'){
 6b6:	03598363          	beq	s3,s5,6dc <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 6ba:	0019079b          	addiw	a5,s2,1
 6be:	893e                	mv	s2,a5
 6c0:	873e                	mv	a4,a5
 6c2:	97d2                	add	a5,a5,s4
 6c4:	0007c483          	lbu	s1,0(a5)
 6c8:	24048763          	beqz	s1,916 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 6cc:	0004879b          	sext.w	a5,s1
    if(state == 0){
 6d0:	fe0993e3          	bnez	s3,6b6 <vprintf+0x40>
      if(c0 == '%'){
 6d4:	fd579ce3          	bne	a5,s5,6ac <vprintf+0x36>
        state = '%';
 6d8:	89be                	mv	s3,a5
 6da:	b7c5                	j	6ba <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 6dc:	00ea06b3          	add	a3,s4,a4
 6e0:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 6e4:	24060563          	beqz	a2,92e <vprintf+0x2b8>
      if(c0 == 'd'){
 6e8:	0b878763          	beq	a5,s8,796 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 6ec:	f9478693          	addi	a3,a5,-108
 6f0:	0016b693          	seqz	a3,a3
 6f4:	f9c60593          	addi	a1,a2,-100
 6f8:	0015b593          	seqz	a1,a1
 6fc:	8df5                	and	a1,a1,a3
 6fe:	e9c5                	bnez	a1,7ae <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 700:	9752                	add	a4,a4,s4
 702:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 706:	f9460713          	addi	a4,a2,-108
 70a:	00173713          	seqz	a4,a4
 70e:	8f75                	and	a4,a4,a3
 710:	f9c50593          	addi	a1,a0,-100
 714:	0015b593          	seqz	a1,a1
 718:	8df9                	and	a1,a1,a4
 71a:	e5dd                	bnez	a1,7c8 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 71c:	07500593          	li	a1,117
 720:	0cb78163          	beq	a5,a1,7e2 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 724:	f8b60593          	addi	a1,a2,-117
 728:	0015b593          	seqz	a1,a1
 72c:	8df5                	and	a1,a1,a3
 72e:	e5f1                	bnez	a1,7fa <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 730:	f8b50593          	addi	a1,a0,-117
 734:	0015b593          	seqz	a1,a1
 738:	8df9                	and	a1,a1,a4
 73a:	ede9                	bnez	a1,814 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 73c:	07800593          	li	a1,120
 740:	0eb78763          	beq	a5,a1,82e <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 744:	f8860613          	addi	a2,a2,-120
 748:	00163613          	seqz	a2,a2
 74c:	8ef1                	and	a3,a3,a2
 74e:	0e069c63          	bnez	a3,846 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 752:	f8850513          	addi	a0,a0,-120
 756:	00153513          	seqz	a0,a0
 75a:	8f69                	and	a4,a4,a0
 75c:	10071263          	bnez	a4,860 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 760:	07000713          	li	a4,112
 764:	10e78a63          	beq	a5,a4,878 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 768:	06300713          	li	a4,99
 76c:	14e78a63          	beq	a5,a4,8c0 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 770:	07300713          	li	a4,115
 774:	16e78063          	beq	a5,a4,8d4 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 778:	02500713          	li	a4,37
 77c:	18e78863          	beq	a5,a4,90c <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 780:	02500593          	li	a1,37
 784:	855a                	mv	a0,s6
 786:	e2bff0ef          	jal	5b0 <putc>
        putc(fd, c0);
 78a:	85a6                	mv	a1,s1
 78c:	855a                	mv	a0,s6
 78e:	e23ff0ef          	jal	5b0 <putc>
      }

      state = 0;
 792:	4981                	li	s3,0
 794:	b71d                	j	6ba <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 796:	008b8493          	addi	s1,s7,8
 79a:	4685                	li	a3,1
 79c:	4629                	li	a2,10
 79e:	000ba583          	lw	a1,0(s7)
 7a2:	855a                	mv	a0,s6
 7a4:	e2bff0ef          	jal	5ce <printint>
 7a8:	8ba6                	mv	s7,s1
      state = 0;
 7aa:	4981                	li	s3,0
 7ac:	b739                	j	6ba <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7ae:	008b8493          	addi	s1,s7,8
 7b2:	4685                	li	a3,1
 7b4:	4629                	li	a2,10
 7b6:	000bb583          	ld	a1,0(s7)
 7ba:	855a                	mv	a0,s6
 7bc:	e13ff0ef          	jal	5ce <printint>
        i += 1;
 7c0:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 7c2:	8ba6                	mv	s7,s1
      state = 0;
 7c4:	4981                	li	s3,0
 7c6:	bdd5                	j	6ba <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7c8:	008b8493          	addi	s1,s7,8
 7cc:	4685                	li	a3,1
 7ce:	4629                	li	a2,10
 7d0:	000bb583          	ld	a1,0(s7)
 7d4:	855a                	mv	a0,s6
 7d6:	df9ff0ef          	jal	5ce <printint>
        i += 2;
 7da:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 7dc:	8ba6                	mv	s7,s1
      state = 0;
 7de:	4981                	li	s3,0
        i += 2;
 7e0:	bde9                	j	6ba <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 7e2:	008b8493          	addi	s1,s7,8
 7e6:	4681                	li	a3,0
 7e8:	4629                	li	a2,10
 7ea:	000be583          	lwu	a1,0(s7)
 7ee:	855a                	mv	a0,s6
 7f0:	ddfff0ef          	jal	5ce <printint>
 7f4:	8ba6                	mv	s7,s1
      state = 0;
 7f6:	4981                	li	s3,0
 7f8:	b5c9                	j	6ba <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7fa:	008b8493          	addi	s1,s7,8
 7fe:	4681                	li	a3,0
 800:	4629                	li	a2,10
 802:	000bb583          	ld	a1,0(s7)
 806:	855a                	mv	a0,s6
 808:	dc7ff0ef          	jal	5ce <printint>
        i += 1;
 80c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 80e:	8ba6                	mv	s7,s1
      state = 0;
 810:	4981                	li	s3,0
 812:	b565                	j	6ba <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 814:	008b8493          	addi	s1,s7,8
 818:	4681                	li	a3,0
 81a:	4629                	li	a2,10
 81c:	000bb583          	ld	a1,0(s7)
 820:	855a                	mv	a0,s6
 822:	dadff0ef          	jal	5ce <printint>
        i += 2;
 826:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 828:	8ba6                	mv	s7,s1
      state = 0;
 82a:	4981                	li	s3,0
        i += 2;
 82c:	b579                	j	6ba <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 82e:	008b8493          	addi	s1,s7,8
 832:	4681                	li	a3,0
 834:	4641                	li	a2,16
 836:	000be583          	lwu	a1,0(s7)
 83a:	855a                	mv	a0,s6
 83c:	d93ff0ef          	jal	5ce <printint>
 840:	8ba6                	mv	s7,s1
      state = 0;
 842:	4981                	li	s3,0
 844:	bd9d                	j	6ba <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 846:	008b8493          	addi	s1,s7,8
 84a:	4681                	li	a3,0
 84c:	4641                	li	a2,16
 84e:	000bb583          	ld	a1,0(s7)
 852:	855a                	mv	a0,s6
 854:	d7bff0ef          	jal	5ce <printint>
        i += 1;
 858:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 85a:	8ba6                	mv	s7,s1
      state = 0;
 85c:	4981                	li	s3,0
 85e:	bdb1                	j	6ba <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 860:	008b8493          	addi	s1,s7,8
 864:	4641                	li	a2,16
 866:	000bb583          	ld	a1,0(s7)
 86a:	855a                	mv	a0,s6
 86c:	d63ff0ef          	jal	5ce <printint>
        i += 2;
 870:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 872:	8ba6                	mv	s7,s1
      state = 0;
 874:	4981                	li	s3,0
        i += 2;
 876:	b591                	j	6ba <vprintf+0x44>
 878:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 87a:	008b8793          	addi	a5,s7,8
 87e:	8cbe                	mv	s9,a5
 880:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 884:	03000593          	li	a1,48
 888:	855a                	mv	a0,s6
 88a:	d27ff0ef          	jal	5b0 <putc>
  putc(fd, 'x');
 88e:	07800593          	li	a1,120
 892:	855a                	mv	a0,s6
 894:	d1dff0ef          	jal	5b0 <putc>
 898:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 89a:	00000b97          	auipc	s7,0x0
 89e:	2eeb8b93          	addi	s7,s7,750 # b88 <digits>
 8a2:	03c9d793          	srli	a5,s3,0x3c
 8a6:	97de                	add	a5,a5,s7
 8a8:	0007c583          	lbu	a1,0(a5)
 8ac:	855a                	mv	a0,s6
 8ae:	d03ff0ef          	jal	5b0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8b2:	0992                	slli	s3,s3,0x4
 8b4:	34fd                	addiw	s1,s1,-1
 8b6:	f4f5                	bnez	s1,8a2 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 8b8:	8be6                	mv	s7,s9
      state = 0;
 8ba:	4981                	li	s3,0
 8bc:	6ca2                	ld	s9,8(sp)
 8be:	bbf5                	j	6ba <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 8c0:	008b8493          	addi	s1,s7,8
 8c4:	000bc583          	lbu	a1,0(s7)
 8c8:	855a                	mv	a0,s6
 8ca:	ce7ff0ef          	jal	5b0 <putc>
 8ce:	8ba6                	mv	s7,s1
      state = 0;
 8d0:	4981                	li	s3,0
 8d2:	b3e5                	j	6ba <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 8d4:	008b8993          	addi	s3,s7,8
 8d8:	000bb483          	ld	s1,0(s7)
 8dc:	cc91                	beqz	s1,8f8 <vprintf+0x282>
        for(; *s; s++)
 8de:	0004c583          	lbu	a1,0(s1)
 8e2:	c195                	beqz	a1,906 <vprintf+0x290>
          putc(fd, *s);
 8e4:	855a                	mv	a0,s6
 8e6:	ccbff0ef          	jal	5b0 <putc>
        for(; *s; s++)
 8ea:	0485                	addi	s1,s1,1
 8ec:	0004c583          	lbu	a1,0(s1)
 8f0:	f9f5                	bnez	a1,8e4 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 8f2:	8bce                	mv	s7,s3
      state = 0;
 8f4:	4981                	li	s3,0
 8f6:	b3d1                	j	6ba <vprintf+0x44>
          s = "(null)";
 8f8:	00000497          	auipc	s1,0x0
 8fc:	28848493          	addi	s1,s1,648 # b80 <malloc+0x156>
        for(; *s; s++)
 900:	02800593          	li	a1,40
 904:	b7c5                	j	8e4 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 906:	8bce                	mv	s7,s3
      state = 0;
 908:	4981                	li	s3,0
 90a:	bb45                	j	6ba <vprintf+0x44>
        putc(fd, '%');
 90c:	85be                	mv	a1,a5
 90e:	855a                	mv	a0,s6
 910:	ca1ff0ef          	jal	5b0 <putc>
 914:	bdbd                	j	792 <vprintf+0x11c>
 916:	6906                	ld	s2,64(sp)
 918:	79e2                	ld	s3,56(sp)
 91a:	7a42                	ld	s4,48(sp)
 91c:	7aa2                	ld	s5,40(sp)
 91e:	7b02                	ld	s6,32(sp)
 920:	6be2                	ld	s7,24(sp)
 922:	6c42                	ld	s8,16(sp)
    }
  }
}
 924:	60e6                	ld	ra,88(sp)
 926:	6446                	ld	s0,80(sp)
 928:	64a6                	ld	s1,72(sp)
 92a:	6125                	addi	sp,sp,96
 92c:	8082                	ret
      if(c0 == 'd'){
 92e:	06400713          	li	a4,100
 932:	e6e782e3          	beq	a5,a4,796 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 936:	f9478693          	addi	a3,a5,-108
 93a:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 93e:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 940:	4701                	li	a4,0
 942:	bbe9                	j	71c <vprintf+0xa6>

0000000000000944 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 944:	715d                	addi	sp,sp,-80
 946:	ec06                	sd	ra,24(sp)
 948:	e822                	sd	s0,16(sp)
 94a:	1000                	addi	s0,sp,32
 94c:	e010                	sd	a2,0(s0)
 94e:	e414                	sd	a3,8(s0)
 950:	e818                	sd	a4,16(s0)
 952:	ec1c                	sd	a5,24(s0)
 954:	03043023          	sd	a6,32(s0)
 958:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 95c:	8622                	mv	a2,s0
 95e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 962:	d15ff0ef          	jal	676 <vprintf>
}
 966:	60e2                	ld	ra,24(sp)
 968:	6442                	ld	s0,16(sp)
 96a:	6161                	addi	sp,sp,80
 96c:	8082                	ret

000000000000096e <printf>:

void
printf(const char *fmt, ...)
{
 96e:	711d                	addi	sp,sp,-96
 970:	ec06                	sd	ra,24(sp)
 972:	e822                	sd	s0,16(sp)
 974:	1000                	addi	s0,sp,32
 976:	e40c                	sd	a1,8(s0)
 978:	e810                	sd	a2,16(s0)
 97a:	ec14                	sd	a3,24(s0)
 97c:	f018                	sd	a4,32(s0)
 97e:	f41c                	sd	a5,40(s0)
 980:	03043823          	sd	a6,48(s0)
 984:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 988:	00840613          	addi	a2,s0,8
 98c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 990:	85aa                	mv	a1,a0
 992:	4505                	li	a0,1
 994:	ce3ff0ef          	jal	676 <vprintf>
}
 998:	60e2                	ld	ra,24(sp)
 99a:	6442                	ld	s0,16(sp)
 99c:	6125                	addi	sp,sp,96
 99e:	8082                	ret

00000000000009a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9a0:	1141                	addi	sp,sp,-16
 9a2:	e406                	sd	ra,8(sp)
 9a4:	e022                	sd	s0,0(sp)
 9a6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9a8:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ac:	00000797          	auipc	a5,0x0
 9b0:	6547b783          	ld	a5,1620(a5) # 1000 <freep>
 9b4:	a095                	j	a18 <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 9b6:	ff852583          	lw	a1,-8(a0)
 9ba:	6390                	ld	a2,0(a5)
 9bc:	02059813          	slli	a6,a1,0x20
 9c0:	01c85693          	srli	a3,a6,0x1c
 9c4:	96ba                	add	a3,a3,a4
 9c6:	02d60563          	beq	a2,a3,9f0 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 9ca:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 9ce:	4790                	lw	a2,8(a5)
 9d0:	02061593          	slli	a1,a2,0x20
 9d4:	01c5d693          	srli	a3,a1,0x1c
 9d8:	96be                	add	a3,a3,a5
 9da:	02d70263          	beq	a4,a3,9fe <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 9de:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9e0:	00000717          	auipc	a4,0x0
 9e4:	62f73023          	sd	a5,1568(a4) # 1000 <freep>
}
 9e8:	60a2                	ld	ra,8(sp)
 9ea:	6402                	ld	s0,0(sp)
 9ec:	0141                	addi	sp,sp,16
 9ee:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 9f0:	4614                	lw	a3,8(a2)
 9f2:	9ead                	addw	a3,a3,a1
 9f4:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9f8:	6394                	ld	a3,0(a5)
 9fa:	6290                	ld	a2,0(a3)
 9fc:	b7f9                	j	9ca <free+0x2a>
    p->s.size += bp->s.size;
 9fe:	ff852703          	lw	a4,-8(a0)
 a02:	9f31                	addw	a4,a4,a2
 a04:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a06:	ff053703          	ld	a4,-16(a0)
 a0a:	bfd1                	j	9de <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a0c:	6394                	ld	a3,0(a5)
 a0e:	00d7e463          	bltu	a5,a3,a16 <free+0x76>
 a12:	fad762e3          	bltu	a4,a3,9b6 <free+0x16>
 a16:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a18:	fee7fae3          	bgeu	a5,a4,a0c <free+0x6c>
 a1c:	6394                	ld	a3,0(a5)
 a1e:	f8d76ce3          	bltu	a4,a3,9b6 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a22:	f8d7fae3          	bgeu	a5,a3,9b6 <free+0x16>
 a26:	87b6                	mv	a5,a3
 a28:	bfc5                	j	a18 <free+0x78>

0000000000000a2a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a2a:	7139                	addi	sp,sp,-64
 a2c:	fc06                	sd	ra,56(sp)
 a2e:	f822                	sd	s0,48(sp)
 a30:	f04a                	sd	s2,32(sp)
 a32:	ec4e                	sd	s3,24(sp)
 a34:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a36:	02051993          	slli	s3,a0,0x20
 a3a:	0209d993          	srli	s3,s3,0x20
 a3e:	09bd                	addi	s3,s3,15
 a40:	0049d993          	srli	s3,s3,0x4
 a44:	2985                	addiw	s3,s3,1
 a46:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 a48:	00000517          	auipc	a0,0x0
 a4c:	5b853503          	ld	a0,1464(a0) # 1000 <freep>
 a50:	c905                	beqz	a0,a80 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a52:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a54:	4798                	lw	a4,8(a5)
 a56:	09377663          	bgeu	a4,s3,ae2 <malloc+0xb8>
 a5a:	f426                	sd	s1,40(sp)
 a5c:	e852                	sd	s4,16(sp)
 a5e:	e456                	sd	s5,8(sp)
 a60:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a62:	8a4e                	mv	s4,s3
 a64:	6705                	lui	a4,0x1
 a66:	00e9f363          	bgeu	s3,a4,a6c <malloc+0x42>
 a6a:	6a05                	lui	s4,0x1
 a6c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a70:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a74:	00000497          	auipc	s1,0x0
 a78:	58c48493          	addi	s1,s1,1420 # 1000 <freep>
  if(p == SBRK_ERROR)
 a7c:	5afd                	li	s5,-1
 a7e:	a83d                	j	abc <malloc+0x92>
 a80:	f426                	sd	s1,40(sp)
 a82:	e852                	sd	s4,16(sp)
 a84:	e456                	sd	s5,8(sp)
 a86:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a88:	00000797          	auipc	a5,0x0
 a8c:	59878793          	addi	a5,a5,1432 # 1020 <base>
 a90:	00000717          	auipc	a4,0x0
 a94:	56f73823          	sd	a5,1392(a4) # 1000 <freep>
 a98:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a9a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a9e:	b7d1                	j	a62 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 aa0:	6398                	ld	a4,0(a5)
 aa2:	e118                	sd	a4,0(a0)
 aa4:	a899                	j	afa <malloc+0xd0>
  hp->s.size = nu;
 aa6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 aaa:	0541                	addi	a0,a0,16
 aac:	ef5ff0ef          	jal	9a0 <free>
  return freep;
 ab0:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 ab2:	c125                	beqz	a0,b12 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ab6:	4798                	lw	a4,8(a5)
 ab8:	03277163          	bgeu	a4,s2,ada <malloc+0xb0>
    if(p == freep)
 abc:	6098                	ld	a4,0(s1)
 abe:	853e                	mv	a0,a5
 ac0:	fef71ae3          	bne	a4,a5,ab4 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 ac4:	8552                	mv	a0,s4
 ac6:	a17ff0ef          	jal	4dc <sbrk>
  if(p == SBRK_ERROR)
 aca:	fd551ee3          	bne	a0,s5,aa6 <malloc+0x7c>
        return 0;
 ace:	4501                	li	a0,0
 ad0:	74a2                	ld	s1,40(sp)
 ad2:	6a42                	ld	s4,16(sp)
 ad4:	6aa2                	ld	s5,8(sp)
 ad6:	6b02                	ld	s6,0(sp)
 ad8:	a03d                	j	b06 <malloc+0xdc>
 ada:	74a2                	ld	s1,40(sp)
 adc:	6a42                	ld	s4,16(sp)
 ade:	6aa2                	ld	s5,8(sp)
 ae0:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 ae2:	fae90fe3          	beq	s2,a4,aa0 <malloc+0x76>
        p->s.size -= nunits;
 ae6:	4137073b          	subw	a4,a4,s3
 aea:	c798                	sw	a4,8(a5)
        p += p->s.size;
 aec:	02071693          	slli	a3,a4,0x20
 af0:	01c6d713          	srli	a4,a3,0x1c
 af4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 af6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 afa:	00000717          	auipc	a4,0x0
 afe:	50a73323          	sd	a0,1286(a4) # 1000 <freep>
      return (void*)(p + 1);
 b02:	01078513          	addi	a0,a5,16
  }
}
 b06:	70e2                	ld	ra,56(sp)
 b08:	7442                	ld	s0,48(sp)
 b0a:	7902                	ld	s2,32(sp)
 b0c:	69e2                	ld	s3,24(sp)
 b0e:	6121                	addi	sp,sp,64
 b10:	8082                	ret
 b12:	74a2                	ld	s1,40(sp)
 b14:	6a42                	ld	s4,16(sp)
 b16:	6aa2                	ld	s5,8(sp)
 b18:	6b02                	ld	s6,0(sp)
 b1a:	b7f5                	j	b06 <malloc+0xdc>
