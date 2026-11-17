
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find>:
#include "kernel/fcntl.h"
#include "kernel/param.h"

void
find(char *path, char *filename, char** exec_args)
{
   0:	d9010113          	addi	sp,sp,-624
   4:	26113423          	sd	ra,616(sp)
   8:	26813023          	sd	s0,608(sp)
   c:	25213823          	sd	s2,592(sp)
  10:	25313423          	sd	s3,584(sp)
  14:	25413023          	sd	s4,576(sp)
  18:	1c80                	addi	s0,sp,624
  1a:	892a                	mv	s2,a0
  1c:	89ae                	mv	s3,a1
  1e:	8a32                	mv	s4,a2
    int fd;
    fd=open(path, 0);
  20:	4581                	li	a1,0
  22:	532000ef          	jal	554 <open>
    if(fd<0){
  26:	04054563          	bltz	a0,70 <find+0x70>
  2a:	24913c23          	sd	s1,600(sp)
  2e:	84aa                	mv	s1,a0
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }
    struct stat st;
    int statt=fstat(fd, &st);
  30:	fa840593          	addi	a1,s0,-88
  34:	538000ef          	jal	56c <fstat>
    if(statt<0){
  38:	04054563          	bltz	a0,82 <find+0x82>
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }
    if(st.type==(short)2){ // T_FILE
  3c:	fb041783          	lh	a5,-80(s0)
  40:	4709                	li	a4,2
  42:	04e78e63          	beq	a5,a4,9e <find+0x9e>
                }
                wait(0);
            }
        }
    }
    else if(st.type==(short)1){ //T_DIR
  46:	4705                	li	a4,1
  48:	10e78063          	beq	a5,a4,148 <find+0x148>
            p[DIRSIZ] = 0;
            find(buf, filename, exec_args);
        }

    }
    close(fd);
  4c:	8526                	mv	a0,s1
  4e:	4ee000ef          	jal	53c <close>
  52:	25813483          	ld	s1,600(sp)
}
  56:	26813083          	ld	ra,616(sp)
  5a:	26013403          	ld	s0,608(sp)
  5e:	25013903          	ld	s2,592(sp)
  62:	24813983          	ld	s3,584(sp)
  66:	24013a03          	ld	s4,576(sp)
  6a:	27010113          	addi	sp,sp,624
  6e:	8082                	ret
        fprintf(2, "find: cannot open %s\n", path);
  70:	864a                	mv	a2,s2
  72:	00001597          	auipc	a1,0x1
  76:	aae58593          	addi	a1,a1,-1362 # b20 <malloc+0xf2>
  7a:	4509                	li	a0,2
  7c:	0cd000ef          	jal	948 <fprintf>
        return;
  80:	bfd9                	j	56 <find+0x56>
        fprintf(2, "find: cannot stat %s\n", path);
  82:	864a                	mv	a2,s2
  84:	00001597          	auipc	a1,0x1
  88:	abc58593          	addi	a1,a1,-1348 # b40 <malloc+0x112>
  8c:	4509                	li	a0,2
  8e:	0bb000ef          	jal	948 <fprintf>
        close(fd);
  92:	8526                	mv	a0,s1
  94:	4a8000ef          	jal	53c <close>
        return;
  98:	25813483          	ld	s1,600(sp)
  9c:	bf6d                	j	56 <find+0x56>
        while(*p){
  9e:	854a                	mv	a0,s2
  a0:	00094703          	lbu	a4,0(s2)
  a4:	cf19                	beqz	a4,c2 <find+0xc2>
  a6:	00190793          	addi	a5,s2,1
            if(*p=='/'){
  aa:	02f00613          	li	a2,47
  ae:	a029                	j	b8 <find+0xb8>
        while(*p){
  b0:	0006c703          	lbu	a4,0(a3)
  b4:	0785                	addi	a5,a5,1
  b6:	c711                	beqz	a4,c2 <find+0xc2>
            else p++;
  b8:	86be                	mv	a3,a5
            if(*p=='/'){
  ba:	fec71be3          	bne	a4,a2,b0 <find+0xb0>
                name=p+1;
  be:	853e                	mv	a0,a5
                p++;
  c0:	bfc5                	j	b0 <find+0xb0>
        if(strcmp(name,filename)==0){
  c2:	85ce                	mv	a1,s3
  c4:	1ca000ef          	jal	28e <strcmp>
  c8:	87aa                	mv	a5,a0
  ca:	f149                	bnez	a0,4c <find+0x4c>
            if(exec_args==0)printf("%s\n",path);
  cc:	040a0263          	beqz	s4,110 <find+0x110>
                while(exec_args[i]){
  d0:	000a3703          	ld	a4,0(s4)
  d4:	da840593          	addi	a1,s0,-600
  d8:	008a0693          	addi	a3,s4,8
  dc:	c719                	beqz	a4,ea <find+0xea>
                    argv[i]=exec_args[i];
  de:	e198                	sd	a4,0(a1)
                    i++;
  e0:	2785                	addiw	a5,a5,1
                while(exec_args[i]){
  e2:	6298                	ld	a4,0(a3)
  e4:	05a1                	addi	a1,a1,8
  e6:	06a1                	addi	a3,a3,8
  e8:	fb7d                	bnez	a4,de <find+0xde>
                argv[i]=path;
  ea:	da840693          	addi	a3,s0,-600
  ee:	00379713          	slli	a4,a5,0x3
  f2:	9736                	add	a4,a4,a3
  f4:	01273023          	sd	s2,0(a4)
                argv[i+1]=0;
  f8:	2785                	addiw	a5,a5,1
  fa:	078e                	slli	a5,a5,0x3
  fc:	97b6                	add	a5,a5,a3
  fe:	0007b023          	sd	zero,0(a5)
                if(fork()==0){
 102:	40a000ef          	jal	50c <fork>
 106:	cd09                	beqz	a0,120 <find+0x120>
                wait(0);
 108:	4501                	li	a0,0
 10a:	412000ef          	jal	51c <wait>
 10e:	bf3d                	j	4c <find+0x4c>
            if(exec_args==0)printf("%s\n",path);
 110:	85ca                	mv	a1,s2
 112:	00001517          	auipc	a0,0x1
 116:	a4650513          	addi	a0,a0,-1466 # b58 <malloc+0x12a>
 11a:	059000ef          	jal	972 <printf>
 11e:	b73d                	j	4c <find+0x4c>
 120:	23513c23          	sd	s5,568(sp)
                    exec(argv[0],argv);
 124:	da840593          	addi	a1,s0,-600
 128:	da843503          	ld	a0,-600(s0)
 12c:	420000ef          	jal	54c <exec>
                    fprintf(2,"exec %s failed\n",argv[0]);
 130:	da843603          	ld	a2,-600(s0)
 134:	00001597          	auipc	a1,0x1
 138:	a2c58593          	addi	a1,a1,-1492 # b60 <malloc+0x132>
 13c:	4509                	li	a0,2
 13e:	00b000ef          	jal	948 <fprintf>
                    exit(1);
 142:	4505                	li	a0,1
 144:	3d0000ef          	jal	514 <exit>
        if(strlen(path)+1+DIRSIZ+1>sizeof(buf)){
 148:	854a                	mv	a0,s2
 14a:	174000ef          	jal	2be <strlen>
 14e:	2541                	addiw	a0,a0,16
 150:	20000793          	li	a5,512
 154:	08a7e863          	bltu	a5,a0,1e4 <find+0x1e4>
 158:	23513c23          	sd	s5,568(sp)
        strcpy(buf, path);
 15c:	85ca                	mv	a1,s2
 15e:	da840513          	addi	a0,s0,-600
 162:	10c000ef          	jal	26e <strcpy>
        p=buf+strlen(buf);
 166:	da840513          	addi	a0,s0,-600
 16a:	154000ef          	jal	2be <strlen>
 16e:	1502                	slli	a0,a0,0x20
 170:	9101                	srli	a0,a0,0x20
 172:	da840793          	addi	a5,s0,-600
 176:	00a78733          	add	a4,a5,a0
 17a:	893a                	mv	s2,a4
        *p++='/';
 17c:	00170793          	addi	a5,a4,1
 180:	8abe                	mv	s5,a5
 182:	02f00793          	li	a5,47
 186:	00f70023          	sb	a5,0(a4)
        while(read(fd, &de, sizeof(de))==sizeof(de)){
 18a:	4641                	li	a2,16
 18c:	d9840593          	addi	a1,s0,-616
 190:	8526                	mv	a0,s1
 192:	39a000ef          	jal	52c <read>
 196:	47c1                	li	a5,16
 198:	06f51263          	bne	a0,a5,1fc <find+0x1fc>
            if(de.inum == 0)continue;
 19c:	d9845783          	lhu	a5,-616(s0)
 1a0:	d7ed                	beqz	a5,18a <find+0x18a>
            if(strcmp(de.name,".")==0|| strcmp(de.name,"..")==0) continue;
 1a2:	00001597          	auipc	a1,0x1
 1a6:	9e658593          	addi	a1,a1,-1562 # b88 <malloc+0x15a>
 1aa:	d9a40513          	addi	a0,s0,-614
 1ae:	0e0000ef          	jal	28e <strcmp>
 1b2:	dd61                	beqz	a0,18a <find+0x18a>
 1b4:	00001597          	auipc	a1,0x1
 1b8:	9dc58593          	addi	a1,a1,-1572 # b90 <malloc+0x162>
 1bc:	d9a40513          	addi	a0,s0,-614
 1c0:	0ce000ef          	jal	28e <strcmp>
 1c4:	d179                	beqz	a0,18a <find+0x18a>
            memmove(p,de.name,DIRSIZ);
 1c6:	4639                	li	a2,14
 1c8:	d9a40593          	addi	a1,s0,-614
 1cc:	8556                	mv	a0,s5
 1ce:	26c000ef          	jal	43a <memmove>
            p[DIRSIZ] = 0;
 1d2:	000907a3          	sb	zero,15(s2)
            find(buf, filename, exec_args);
 1d6:	8652                	mv	a2,s4
 1d8:	85ce                	mv	a1,s3
 1da:	da840513          	addi	a0,s0,-600
 1de:	e23ff0ef          	jal	0 <find>
 1e2:	b765                	j	18a <find+0x18a>
            close(fd);
 1e4:	8526                	mv	a0,s1
 1e6:	356000ef          	jal	53c <close>
            printf("find: path too long\n");
 1ea:	00001517          	auipc	a0,0x1
 1ee:	98650513          	addi	a0,a0,-1658 # b70 <malloc+0x142>
 1f2:	780000ef          	jal	972 <printf>
            return;
 1f6:	25813483          	ld	s1,600(sp)
 1fa:	bdb1                	j	56 <find+0x56>
 1fc:	23813a83          	ld	s5,568(sp)
 200:	b5b1                	j	4c <find+0x4c>

0000000000000202 <main>:

int main(int argc, char* argv[])
{
 202:	1101                	addi	sp,sp,-32
 204:	ec06                	sd	ra,24(sp)
 206:	e822                	sd	s0,16(sp)
 208:	e426                	sd	s1,8(sp)
 20a:	1000                	addi	s0,sp,32
 20c:	84ae                	mv	s1,a1
    char **exec_arg=0;
    if(argc==3){
 20e:	478d                	li	a5,3
 210:	02f50763          	beq	a0,a5,23e <main+0x3c>
        find(argv[1],argv[2], exec_arg);
    }
    else if(argc>=5 && strcmp(argv[3], "-exec")==0){
 214:	4791                	li	a5,4
 216:	00a7da63          	bge	a5,a0,22a <main+0x28>
 21a:	00001597          	auipc	a1,0x1
 21e:	97e58593          	addi	a1,a1,-1666 # b98 <malloc+0x16a>
 222:	6c88                	ld	a0,24(s1)
 224:	06a000ef          	jal	28e <strcmp>
 228:	c11d                	beqz	a0,24e <main+0x4c>
        exec_arg=&argv[4];
        find(argv[1],argv[2], exec_arg);
    }
    else{
        fprintf(2, "Usage: find <path> <filename> [-exec cmd args...]\n");
 22a:	00001597          	auipc	a1,0x1
 22e:	97658593          	addi	a1,a1,-1674 # ba0 <malloc+0x172>
 232:	4509                	li	a0,2
 234:	714000ef          	jal	948 <fprintf>
        exit(1);
 238:	4505                	li	a0,1
 23a:	2da000ef          	jal	514 <exit>
        find(argv[1],argv[2], exec_arg);
 23e:	4601                	li	a2,0
 240:	698c                	ld	a1,16(a1)
 242:	6488                	ld	a0,8(s1)
 244:	dbdff0ef          	jal	0 <find>
    }
    exit(0);
 248:	4501                	li	a0,0
 24a:	2ca000ef          	jal	514 <exit>
        find(argv[1],argv[2], exec_arg);
 24e:	02048613          	addi	a2,s1,32
 252:	688c                	ld	a1,16(s1)
 254:	6488                	ld	a0,8(s1)
 256:	dabff0ef          	jal	0 <find>
 25a:	b7fd                	j	248 <main+0x46>

000000000000025c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 25c:	1141                	addi	sp,sp,-16
 25e:	e406                	sd	ra,8(sp)
 260:	e022                	sd	s0,0(sp)
 262:	0800                	addi	s0,sp,16
  extern int main();
  main();
 264:	f9fff0ef          	jal	202 <main>
  exit(0);
 268:	4501                	li	a0,0
 26a:	2aa000ef          	jal	514 <exit>

000000000000026e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 26e:	1141                	addi	sp,sp,-16
 270:	e406                	sd	ra,8(sp)
 272:	e022                	sd	s0,0(sp)
 274:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 276:	87aa                	mv	a5,a0
 278:	0585                	addi	a1,a1,1
 27a:	0785                	addi	a5,a5,1
 27c:	fff5c703          	lbu	a4,-1(a1)
 280:	fee78fa3          	sb	a4,-1(a5)
 284:	fb75                	bnez	a4,278 <strcpy+0xa>
    ;
  return os;
}
 286:	60a2                	ld	ra,8(sp)
 288:	6402                	ld	s0,0(sp)
 28a:	0141                	addi	sp,sp,16
 28c:	8082                	ret

000000000000028e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 28e:	1141                	addi	sp,sp,-16
 290:	e406                	sd	ra,8(sp)
 292:	e022                	sd	s0,0(sp)
 294:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 296:	00054783          	lbu	a5,0(a0)
 29a:	cb91                	beqz	a5,2ae <strcmp+0x20>
 29c:	0005c703          	lbu	a4,0(a1)
 2a0:	00f71763          	bne	a4,a5,2ae <strcmp+0x20>
    p++, q++;
 2a4:	0505                	addi	a0,a0,1
 2a6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2a8:	00054783          	lbu	a5,0(a0)
 2ac:	fbe5                	bnez	a5,29c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 2ae:	0005c503          	lbu	a0,0(a1)
}
 2b2:	40a7853b          	subw	a0,a5,a0
 2b6:	60a2                	ld	ra,8(sp)
 2b8:	6402                	ld	s0,0(sp)
 2ba:	0141                	addi	sp,sp,16
 2bc:	8082                	ret

00000000000002be <strlen>:

uint
strlen(const char *s)
{
 2be:	1141                	addi	sp,sp,-16
 2c0:	e406                	sd	ra,8(sp)
 2c2:	e022                	sd	s0,0(sp)
 2c4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2c6:	00054783          	lbu	a5,0(a0)
 2ca:	cf91                	beqz	a5,2e6 <strlen+0x28>
 2cc:	00150793          	addi	a5,a0,1
 2d0:	86be                	mv	a3,a5
 2d2:	0785                	addi	a5,a5,1
 2d4:	fff7c703          	lbu	a4,-1(a5)
 2d8:	ff65                	bnez	a4,2d0 <strlen+0x12>
 2da:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 2de:	60a2                	ld	ra,8(sp)
 2e0:	6402                	ld	s0,0(sp)
 2e2:	0141                	addi	sp,sp,16
 2e4:	8082                	ret
  for(n = 0; s[n]; n++)
 2e6:	4501                	li	a0,0
 2e8:	bfdd                	j	2de <strlen+0x20>

00000000000002ea <memset>:

void*
memset(void *dst, int c, uint n)
{
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e406                	sd	ra,8(sp)
 2ee:	e022                	sd	s0,0(sp)
 2f0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2f2:	ca19                	beqz	a2,308 <memset+0x1e>
 2f4:	87aa                	mv	a5,a0
 2f6:	1602                	slli	a2,a2,0x20
 2f8:	9201                	srli	a2,a2,0x20
 2fa:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2fe:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 302:	0785                	addi	a5,a5,1
 304:	fee79de3          	bne	a5,a4,2fe <memset+0x14>
  }
  return dst;
}
 308:	60a2                	ld	ra,8(sp)
 30a:	6402                	ld	s0,0(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret

0000000000000310 <strchr>:

char*
strchr(const char *s, char c)
{
 310:	1141                	addi	sp,sp,-16
 312:	e406                	sd	ra,8(sp)
 314:	e022                	sd	s0,0(sp)
 316:	0800                	addi	s0,sp,16
  for(; *s; s++)
 318:	00054783          	lbu	a5,0(a0)
 31c:	c799                	beqz	a5,32a <strchr+0x1a>
    if(*s == c)
 31e:	00f58763          	beq	a1,a5,32c <strchr+0x1c>
  for(; *s; s++)
 322:	0505                	addi	a0,a0,1
 324:	00054783          	lbu	a5,0(a0)
 328:	fbfd                	bnez	a5,31e <strchr+0xe>
      return (char*)s;
  return 0;
 32a:	4501                	li	a0,0
}
 32c:	60a2                	ld	ra,8(sp)
 32e:	6402                	ld	s0,0(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret

0000000000000334 <gets>:

char*
gets(char *buf, int max)
{
 334:	711d                	addi	sp,sp,-96
 336:	ec86                	sd	ra,88(sp)
 338:	e8a2                	sd	s0,80(sp)
 33a:	e4a6                	sd	s1,72(sp)
 33c:	e0ca                	sd	s2,64(sp)
 33e:	fc4e                	sd	s3,56(sp)
 340:	f852                	sd	s4,48(sp)
 342:	f456                	sd	s5,40(sp)
 344:	f05a                	sd	s6,32(sp)
 346:	ec5e                	sd	s7,24(sp)
 348:	e862                	sd	s8,16(sp)
 34a:	1080                	addi	s0,sp,96
 34c:	8baa                	mv	s7,a0
 34e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 350:	892a                	mv	s2,a0
 352:	4481                	li	s1,0
    cc = read(0, &c, 1);
 354:	faf40b13          	addi	s6,s0,-81
 358:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 35a:	8c26                	mv	s8,s1
 35c:	0014899b          	addiw	s3,s1,1
 360:	84ce                	mv	s1,s3
 362:	0349d863          	bge	s3,s4,392 <gets+0x5e>
    cc = read(0, &c, 1);
 366:	8656                	mv	a2,s5
 368:	85da                	mv	a1,s6
 36a:	4501                	li	a0,0
 36c:	1c0000ef          	jal	52c <read>
    if(cc < 1)
 370:	02a05163          	blez	a0,392 <gets+0x5e>
      break;
    buf[i++] = c;
 374:	faf44783          	lbu	a5,-81(s0)
 378:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 37c:	0905                	addi	s2,s2,1
 37e:	ff678713          	addi	a4,a5,-10
 382:	00173713          	seqz	a4,a4
 386:	17cd                	addi	a5,a5,-13
 388:	0017b793          	seqz	a5,a5
 38c:	8fd9                	or	a5,a5,a4
 38e:	d7f1                	beqz	a5,35a <gets+0x26>
    buf[i++] = c;
 390:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 392:	9c5e                	add	s8,s8,s7
 394:	000c0023          	sb	zero,0(s8)
  return buf;
}
 398:	855e                	mv	a0,s7
 39a:	60e6                	ld	ra,88(sp)
 39c:	6446                	ld	s0,80(sp)
 39e:	64a6                	ld	s1,72(sp)
 3a0:	6906                	ld	s2,64(sp)
 3a2:	79e2                	ld	s3,56(sp)
 3a4:	7a42                	ld	s4,48(sp)
 3a6:	7aa2                	ld	s5,40(sp)
 3a8:	7b02                	ld	s6,32(sp)
 3aa:	6be2                	ld	s7,24(sp)
 3ac:	6c42                	ld	s8,16(sp)
 3ae:	6125                	addi	sp,sp,96
 3b0:	8082                	ret

00000000000003b2 <stat>:

int
stat(const char *n, struct stat *st)
{
 3b2:	1101                	addi	sp,sp,-32
 3b4:	ec06                	sd	ra,24(sp)
 3b6:	e822                	sd	s0,16(sp)
 3b8:	e04a                	sd	s2,0(sp)
 3ba:	1000                	addi	s0,sp,32
 3bc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3be:	4581                	li	a1,0
 3c0:	194000ef          	jal	554 <open>
  if(fd < 0)
 3c4:	02054263          	bltz	a0,3e8 <stat+0x36>
 3c8:	e426                	sd	s1,8(sp)
 3ca:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3cc:	85ca                	mv	a1,s2
 3ce:	19e000ef          	jal	56c <fstat>
 3d2:	892a                	mv	s2,a0
  close(fd);
 3d4:	8526                	mv	a0,s1
 3d6:	166000ef          	jal	53c <close>
  return r;
 3da:	64a2                	ld	s1,8(sp)
}
 3dc:	854a                	mv	a0,s2
 3de:	60e2                	ld	ra,24(sp)
 3e0:	6442                	ld	s0,16(sp)
 3e2:	6902                	ld	s2,0(sp)
 3e4:	6105                	addi	sp,sp,32
 3e6:	8082                	ret
    return -1;
 3e8:	57fd                	li	a5,-1
 3ea:	893e                	mv	s2,a5
 3ec:	bfc5                	j	3dc <stat+0x2a>

00000000000003ee <atoi>:

int
atoi(const char *s)
{
 3ee:	1141                	addi	sp,sp,-16
 3f0:	e406                	sd	ra,8(sp)
 3f2:	e022                	sd	s0,0(sp)
 3f4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3f6:	00054683          	lbu	a3,0(a0)
 3fa:	fd06879b          	addiw	a5,a3,-48
 3fe:	0ff7f793          	zext.b	a5,a5
 402:	4625                	li	a2,9
 404:	02f66963          	bltu	a2,a5,436 <atoi+0x48>
 408:	872a                	mv	a4,a0
  n = 0;
 40a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 40c:	0705                	addi	a4,a4,1
 40e:	0025179b          	slliw	a5,a0,0x2
 412:	9fa9                	addw	a5,a5,a0
 414:	0017979b          	slliw	a5,a5,0x1
 418:	9fb5                	addw	a5,a5,a3
 41a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 41e:	00074683          	lbu	a3,0(a4)
 422:	fd06879b          	addiw	a5,a3,-48
 426:	0ff7f793          	zext.b	a5,a5
 42a:	fef671e3          	bgeu	a2,a5,40c <atoi+0x1e>
  return n;
}
 42e:	60a2                	ld	ra,8(sp)
 430:	6402                	ld	s0,0(sp)
 432:	0141                	addi	sp,sp,16
 434:	8082                	ret
  n = 0;
 436:	4501                	li	a0,0
 438:	bfdd                	j	42e <atoi+0x40>

000000000000043a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 43a:	1141                	addi	sp,sp,-16
 43c:	e406                	sd	ra,8(sp)
 43e:	e022                	sd	s0,0(sp)
 440:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 442:	02b57563          	bgeu	a0,a1,46c <memmove+0x32>
    while(n-- > 0)
 446:	00c05f63          	blez	a2,464 <memmove+0x2a>
 44a:	1602                	slli	a2,a2,0x20
 44c:	9201                	srli	a2,a2,0x20
 44e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 452:	872a                	mv	a4,a0
      *dst++ = *src++;
 454:	0585                	addi	a1,a1,1
 456:	0705                	addi	a4,a4,1
 458:	fff5c683          	lbu	a3,-1(a1)
 45c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 460:	fee79ae3          	bne	a5,a4,454 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 464:	60a2                	ld	ra,8(sp)
 466:	6402                	ld	s0,0(sp)
 468:	0141                	addi	sp,sp,16
 46a:	8082                	ret
    while(n-- > 0)
 46c:	fec05ce3          	blez	a2,464 <memmove+0x2a>
    dst += n;
 470:	00c50733          	add	a4,a0,a2
    src += n;
 474:	95b2                	add	a1,a1,a2
 476:	fff6079b          	addiw	a5,a2,-1
 47a:	1782                	slli	a5,a5,0x20
 47c:	9381                	srli	a5,a5,0x20
 47e:	fff7c793          	not	a5,a5
 482:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 484:	15fd                	addi	a1,a1,-1
 486:	177d                	addi	a4,a4,-1
 488:	0005c683          	lbu	a3,0(a1)
 48c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 490:	fef71ae3          	bne	a4,a5,484 <memmove+0x4a>
 494:	bfc1                	j	464 <memmove+0x2a>

0000000000000496 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 496:	1141                	addi	sp,sp,-16
 498:	e406                	sd	ra,8(sp)
 49a:	e022                	sd	s0,0(sp)
 49c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 49e:	ce19                	beqz	a2,4bc <memcmp+0x26>
 4a0:	1602                	slli	a2,a2,0x20
 4a2:	9201                	srli	a2,a2,0x20
 4a4:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 4a8:	00054783          	lbu	a5,0(a0)
 4ac:	0005c703          	lbu	a4,0(a1)
 4b0:	00e79b63          	bne	a5,a4,4c6 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 4b4:	0505                	addi	a0,a0,1
    p2++;
 4b6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4b8:	fed518e3          	bne	a0,a3,4a8 <memcmp+0x12>
  }
  return 0;
 4bc:	4501                	li	a0,0
}
 4be:	60a2                	ld	ra,8(sp)
 4c0:	6402                	ld	s0,0(sp)
 4c2:	0141                	addi	sp,sp,16
 4c4:	8082                	ret
      return *p1 - *p2;
 4c6:	40e7853b          	subw	a0,a5,a4
 4ca:	bfd5                	j	4be <memcmp+0x28>

00000000000004cc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4cc:	1141                	addi	sp,sp,-16
 4ce:	e406                	sd	ra,8(sp)
 4d0:	e022                	sd	s0,0(sp)
 4d2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4d4:	f67ff0ef          	jal	43a <memmove>
}
 4d8:	60a2                	ld	ra,8(sp)
 4da:	6402                	ld	s0,0(sp)
 4dc:	0141                	addi	sp,sp,16
 4de:	8082                	ret

00000000000004e0 <sbrk>:

char *
sbrk(int n) {
 4e0:	1141                	addi	sp,sp,-16
 4e2:	e406                	sd	ra,8(sp)
 4e4:	e022                	sd	s0,0(sp)
 4e6:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 4e8:	4585                	li	a1,1
 4ea:	0b2000ef          	jal	59c <sys_sbrk>
}
 4ee:	60a2                	ld	ra,8(sp)
 4f0:	6402                	ld	s0,0(sp)
 4f2:	0141                	addi	sp,sp,16
 4f4:	8082                	ret

00000000000004f6 <sbrklazy>:

char *
sbrklazy(int n) {
 4f6:	1141                	addi	sp,sp,-16
 4f8:	e406                	sd	ra,8(sp)
 4fa:	e022                	sd	s0,0(sp)
 4fc:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 4fe:	4589                	li	a1,2
 500:	09c000ef          	jal	59c <sys_sbrk>
}
 504:	60a2                	ld	ra,8(sp)
 506:	6402                	ld	s0,0(sp)
 508:	0141                	addi	sp,sp,16
 50a:	8082                	ret

000000000000050c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 50c:	4885                	li	a7,1
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <exit>:
.global exit
exit:
 li a7, SYS_exit
 514:	4889                	li	a7,2
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <wait>:
.global wait
wait:
 li a7, SYS_wait
 51c:	488d                	li	a7,3
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 524:	4891                	li	a7,4
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <read>:
.global read
read:
 li a7, SYS_read
 52c:	4895                	li	a7,5
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <write>:
.global write
write:
 li a7, SYS_write
 534:	48c1                	li	a7,16
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <close>:
.global close
close:
 li a7, SYS_close
 53c:	48d5                	li	a7,21
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <kill>:
.global kill
kill:
 li a7, SYS_kill
 544:	4899                	li	a7,6
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <exec>:
.global exec
exec:
 li a7, SYS_exec
 54c:	489d                	li	a7,7
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <open>:
.global open
open:
 li a7, SYS_open
 554:	48bd                	li	a7,15
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 55c:	48c5                	li	a7,17
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 564:	48c9                	li	a7,18
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 56c:	48a1                	li	a7,8
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <link>:
.global link
link:
 li a7, SYS_link
 574:	48cd                	li	a7,19
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 57c:	48d1                	li	a7,20
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 584:	48a5                	li	a7,9
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <dup>:
.global dup
dup:
 li a7, SYS_dup
 58c:	48a9                	li	a7,10
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 594:	48ad                	li	a7,11
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 59c:	48b1                	li	a7,12
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <pause>:
.global pause
pause:
 li a7, SYS_pause
 5a4:	48b5                	li	a7,13
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5ac:	48b9                	li	a7,14
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5b4:	1101                	addi	sp,sp,-32
 5b6:	ec06                	sd	ra,24(sp)
 5b8:	e822                	sd	s0,16(sp)
 5ba:	1000                	addi	s0,sp,32
 5bc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5c0:	4605                	li	a2,1
 5c2:	fef40593          	addi	a1,s0,-17
 5c6:	f6fff0ef          	jal	534 <write>
}
 5ca:	60e2                	ld	ra,24(sp)
 5cc:	6442                	ld	s0,16(sp)
 5ce:	6105                	addi	sp,sp,32
 5d0:	8082                	ret

00000000000005d2 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 5d2:	715d                	addi	sp,sp,-80
 5d4:	e486                	sd	ra,72(sp)
 5d6:	e0a2                	sd	s0,64(sp)
 5d8:	f84a                	sd	s2,48(sp)
 5da:	f44e                	sd	s3,40(sp)
 5dc:	0880                	addi	s0,sp,80
 5de:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5e0:	00d036b3          	snez	a3,a3
 5e4:	03f5d793          	srli	a5,a1,0x3f
 5e8:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5ea:	0005871b          	sext.w	a4,a1
  neg = 0;
 5ee:	4301                	li	t1,0
  if(sgn && xx < 0){
 5f0:	c681                	beqz	a3,5f8 <printint+0x26>
    x = -xx;
 5f2:	40b0073b          	negw	a4,a1
    neg = 1;
 5f6:	4305                	li	t1,1
  }

  i = 0;
 5f8:	fb840993          	addi	s3,s0,-72
  neg = 0;
 5fc:	85ce                	mv	a1,s3
  i = 0;
 5fe:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 600:	00000817          	auipc	a6,0x0
 604:	5e080813          	addi	a6,a6,1504 # be0 <digits>
 608:	88b6                	mv	a7,a3
 60a:	0016851b          	addiw	a0,a3,1
 60e:	86aa                	mv	a3,a0
 610:	02c777bb          	remuw	a5,a4,a2
 614:	1782                	slli	a5,a5,0x20
 616:	9381                	srli	a5,a5,0x20
 618:	97c2                	add	a5,a5,a6
 61a:	0007c783          	lbu	a5,0(a5)
 61e:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 622:	87ba                	mv	a5,a4
 624:	02c7573b          	divuw	a4,a4,a2
 628:	0585                	addi	a1,a1,1
 62a:	fcc7ffe3          	bgeu	a5,a2,608 <printint+0x36>
  if(neg)
 62e:	00030b63          	beqz	t1,644 <printint+0x72>
    buf[i++] = '-';
 632:	fd040793          	addi	a5,s0,-48
 636:	953e                	add	a0,a0,a5
 638:	02d00793          	li	a5,45
 63c:	fef50423          	sb	a5,-24(a0)
 640:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 644:	02d05563          	blez	a3,66e <printint+0x9c>
 648:	fc26                	sd	s1,56(sp)
 64a:	36fd                	addiw	a3,a3,-1
 64c:	00d984b3          	add	s1,s3,a3
 650:	19fd                	addi	s3,s3,-1
 652:	99b6                	add	s3,s3,a3
 654:	1682                	slli	a3,a3,0x20
 656:	9281                	srli	a3,a3,0x20
 658:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 65c:	0004c583          	lbu	a1,0(s1)
 660:	854a                	mv	a0,s2
 662:	f53ff0ef          	jal	5b4 <putc>
  while(--i >= 0)
 666:	14fd                	addi	s1,s1,-1
 668:	ff349ae3          	bne	s1,s3,65c <printint+0x8a>
 66c:	74e2                	ld	s1,56(sp)
}
 66e:	60a6                	ld	ra,72(sp)
 670:	6406                	ld	s0,64(sp)
 672:	7942                	ld	s2,48(sp)
 674:	79a2                	ld	s3,40(sp)
 676:	6161                	addi	sp,sp,80
 678:	8082                	ret

000000000000067a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 67a:	711d                	addi	sp,sp,-96
 67c:	ec86                	sd	ra,88(sp)
 67e:	e8a2                	sd	s0,80(sp)
 680:	e4a6                	sd	s1,72(sp)
 682:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 684:	0005c483          	lbu	s1,0(a1)
 688:	2a048063          	beqz	s1,928 <vprintf+0x2ae>
 68c:	e0ca                	sd	s2,64(sp)
 68e:	fc4e                	sd	s3,56(sp)
 690:	f852                	sd	s4,48(sp)
 692:	f456                	sd	s5,40(sp)
 694:	f05a                	sd	s6,32(sp)
 696:	ec5e                	sd	s7,24(sp)
 698:	e862                	sd	s8,16(sp)
 69a:	8b2a                	mv	s6,a0
 69c:	8a2e                	mv	s4,a1
 69e:	8bb2                	mv	s7,a2
  state = 0;
 6a0:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 6a2:	4901                	li	s2,0
 6a4:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 6a6:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 6aa:	06400c13          	li	s8,100
 6ae:	a00d                	j	6d0 <vprintf+0x56>
        putc(fd, c0);
 6b0:	85a6                	mv	a1,s1
 6b2:	855a                	mv	a0,s6
 6b4:	f01ff0ef          	jal	5b4 <putc>
 6b8:	a019                	j	6be <vprintf+0x44>
    } else if(state == '%'){
 6ba:	03598363          	beq	s3,s5,6e0 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 6be:	0019079b          	addiw	a5,s2,1
 6c2:	893e                	mv	s2,a5
 6c4:	873e                	mv	a4,a5
 6c6:	97d2                	add	a5,a5,s4
 6c8:	0007c483          	lbu	s1,0(a5)
 6cc:	24048763          	beqz	s1,91a <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 6d0:	0004879b          	sext.w	a5,s1
    if(state == 0){
 6d4:	fe0993e3          	bnez	s3,6ba <vprintf+0x40>
      if(c0 == '%'){
 6d8:	fd579ce3          	bne	a5,s5,6b0 <vprintf+0x36>
        state = '%';
 6dc:	89be                	mv	s3,a5
 6de:	b7c5                	j	6be <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 6e0:	00ea06b3          	add	a3,s4,a4
 6e4:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 6e8:	24060563          	beqz	a2,932 <vprintf+0x2b8>
      if(c0 == 'd'){
 6ec:	0b878763          	beq	a5,s8,79a <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 6f0:	f9478693          	addi	a3,a5,-108
 6f4:	0016b693          	seqz	a3,a3
 6f8:	f9c60593          	addi	a1,a2,-100
 6fc:	0015b593          	seqz	a1,a1
 700:	8df5                	and	a1,a1,a3
 702:	e9c5                	bnez	a1,7b2 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 704:	9752                	add	a4,a4,s4
 706:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 70a:	f9460713          	addi	a4,a2,-108
 70e:	00173713          	seqz	a4,a4
 712:	8f75                	and	a4,a4,a3
 714:	f9c50593          	addi	a1,a0,-100
 718:	0015b593          	seqz	a1,a1
 71c:	8df9                	and	a1,a1,a4
 71e:	e5dd                	bnez	a1,7cc <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 720:	07500593          	li	a1,117
 724:	0cb78163          	beq	a5,a1,7e6 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 728:	f8b60593          	addi	a1,a2,-117
 72c:	0015b593          	seqz	a1,a1
 730:	8df5                	and	a1,a1,a3
 732:	e5f1                	bnez	a1,7fe <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 734:	f8b50593          	addi	a1,a0,-117
 738:	0015b593          	seqz	a1,a1
 73c:	8df9                	and	a1,a1,a4
 73e:	ede9                	bnez	a1,818 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 740:	07800593          	li	a1,120
 744:	0eb78763          	beq	a5,a1,832 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 748:	f8860613          	addi	a2,a2,-120
 74c:	00163613          	seqz	a2,a2
 750:	8ef1                	and	a3,a3,a2
 752:	0e069c63          	bnez	a3,84a <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 756:	f8850513          	addi	a0,a0,-120
 75a:	00153513          	seqz	a0,a0
 75e:	8f69                	and	a4,a4,a0
 760:	10071263          	bnez	a4,864 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 764:	07000713          	li	a4,112
 768:	10e78a63          	beq	a5,a4,87c <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 76c:	06300713          	li	a4,99
 770:	14e78a63          	beq	a5,a4,8c4 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 774:	07300713          	li	a4,115
 778:	16e78063          	beq	a5,a4,8d8 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 77c:	02500713          	li	a4,37
 780:	18e78863          	beq	a5,a4,910 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 784:	02500593          	li	a1,37
 788:	855a                	mv	a0,s6
 78a:	e2bff0ef          	jal	5b4 <putc>
        putc(fd, c0);
 78e:	85a6                	mv	a1,s1
 790:	855a                	mv	a0,s6
 792:	e23ff0ef          	jal	5b4 <putc>
      }

      state = 0;
 796:	4981                	li	s3,0
 798:	b71d                	j	6be <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 79a:	008b8493          	addi	s1,s7,8
 79e:	4685                	li	a3,1
 7a0:	4629                	li	a2,10
 7a2:	000ba583          	lw	a1,0(s7)
 7a6:	855a                	mv	a0,s6
 7a8:	e2bff0ef          	jal	5d2 <printint>
 7ac:	8ba6                	mv	s7,s1
      state = 0;
 7ae:	4981                	li	s3,0
 7b0:	b739                	j	6be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7b2:	008b8493          	addi	s1,s7,8
 7b6:	4685                	li	a3,1
 7b8:	4629                	li	a2,10
 7ba:	000bb583          	ld	a1,0(s7)
 7be:	855a                	mv	a0,s6
 7c0:	e13ff0ef          	jal	5d2 <printint>
        i += 1;
 7c4:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 7c6:	8ba6                	mv	s7,s1
      state = 0;
 7c8:	4981                	li	s3,0
 7ca:	bdd5                	j	6be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7cc:	008b8493          	addi	s1,s7,8
 7d0:	4685                	li	a3,1
 7d2:	4629                	li	a2,10
 7d4:	000bb583          	ld	a1,0(s7)
 7d8:	855a                	mv	a0,s6
 7da:	df9ff0ef          	jal	5d2 <printint>
        i += 2;
 7de:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 7e0:	8ba6                	mv	s7,s1
      state = 0;
 7e2:	4981                	li	s3,0
        i += 2;
 7e4:	bde9                	j	6be <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 7e6:	008b8493          	addi	s1,s7,8
 7ea:	4681                	li	a3,0
 7ec:	4629                	li	a2,10
 7ee:	000be583          	lwu	a1,0(s7)
 7f2:	855a                	mv	a0,s6
 7f4:	ddfff0ef          	jal	5d2 <printint>
 7f8:	8ba6                	mv	s7,s1
      state = 0;
 7fa:	4981                	li	s3,0
 7fc:	b5c9                	j	6be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7fe:	008b8493          	addi	s1,s7,8
 802:	4681                	li	a3,0
 804:	4629                	li	a2,10
 806:	000bb583          	ld	a1,0(s7)
 80a:	855a                	mv	a0,s6
 80c:	dc7ff0ef          	jal	5d2 <printint>
        i += 1;
 810:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 812:	8ba6                	mv	s7,s1
      state = 0;
 814:	4981                	li	s3,0
 816:	b565                	j	6be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 818:	008b8493          	addi	s1,s7,8
 81c:	4681                	li	a3,0
 81e:	4629                	li	a2,10
 820:	000bb583          	ld	a1,0(s7)
 824:	855a                	mv	a0,s6
 826:	dadff0ef          	jal	5d2 <printint>
        i += 2;
 82a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 82c:	8ba6                	mv	s7,s1
      state = 0;
 82e:	4981                	li	s3,0
        i += 2;
 830:	b579                	j	6be <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 832:	008b8493          	addi	s1,s7,8
 836:	4681                	li	a3,0
 838:	4641                	li	a2,16
 83a:	000be583          	lwu	a1,0(s7)
 83e:	855a                	mv	a0,s6
 840:	d93ff0ef          	jal	5d2 <printint>
 844:	8ba6                	mv	s7,s1
      state = 0;
 846:	4981                	li	s3,0
 848:	bd9d                	j	6be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 84a:	008b8493          	addi	s1,s7,8
 84e:	4681                	li	a3,0
 850:	4641                	li	a2,16
 852:	000bb583          	ld	a1,0(s7)
 856:	855a                	mv	a0,s6
 858:	d7bff0ef          	jal	5d2 <printint>
        i += 1;
 85c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 85e:	8ba6                	mv	s7,s1
      state = 0;
 860:	4981                	li	s3,0
 862:	bdb1                	j	6be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 864:	008b8493          	addi	s1,s7,8
 868:	4641                	li	a2,16
 86a:	000bb583          	ld	a1,0(s7)
 86e:	855a                	mv	a0,s6
 870:	d63ff0ef          	jal	5d2 <printint>
        i += 2;
 874:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 876:	8ba6                	mv	s7,s1
      state = 0;
 878:	4981                	li	s3,0
        i += 2;
 87a:	b591                	j	6be <vprintf+0x44>
 87c:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 87e:	008b8793          	addi	a5,s7,8
 882:	8cbe                	mv	s9,a5
 884:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 888:	03000593          	li	a1,48
 88c:	855a                	mv	a0,s6
 88e:	d27ff0ef          	jal	5b4 <putc>
  putc(fd, 'x');
 892:	07800593          	li	a1,120
 896:	855a                	mv	a0,s6
 898:	d1dff0ef          	jal	5b4 <putc>
 89c:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 89e:	00000b97          	auipc	s7,0x0
 8a2:	342b8b93          	addi	s7,s7,834 # be0 <digits>
 8a6:	03c9d793          	srli	a5,s3,0x3c
 8aa:	97de                	add	a5,a5,s7
 8ac:	0007c583          	lbu	a1,0(a5)
 8b0:	855a                	mv	a0,s6
 8b2:	d03ff0ef          	jal	5b4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8b6:	0992                	slli	s3,s3,0x4
 8b8:	34fd                	addiw	s1,s1,-1
 8ba:	f4f5                	bnez	s1,8a6 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 8bc:	8be6                	mv	s7,s9
      state = 0;
 8be:	4981                	li	s3,0
 8c0:	6ca2                	ld	s9,8(sp)
 8c2:	bbf5                	j	6be <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 8c4:	008b8493          	addi	s1,s7,8
 8c8:	000bc583          	lbu	a1,0(s7)
 8cc:	855a                	mv	a0,s6
 8ce:	ce7ff0ef          	jal	5b4 <putc>
 8d2:	8ba6                	mv	s7,s1
      state = 0;
 8d4:	4981                	li	s3,0
 8d6:	b3e5                	j	6be <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 8d8:	008b8993          	addi	s3,s7,8
 8dc:	000bb483          	ld	s1,0(s7)
 8e0:	cc91                	beqz	s1,8fc <vprintf+0x282>
        for(; *s; s++)
 8e2:	0004c583          	lbu	a1,0(s1)
 8e6:	c195                	beqz	a1,90a <vprintf+0x290>
          putc(fd, *s);
 8e8:	855a                	mv	a0,s6
 8ea:	ccbff0ef          	jal	5b4 <putc>
        for(; *s; s++)
 8ee:	0485                	addi	s1,s1,1
 8f0:	0004c583          	lbu	a1,0(s1)
 8f4:	f9f5                	bnez	a1,8e8 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 8f6:	8bce                	mv	s7,s3
      state = 0;
 8f8:	4981                	li	s3,0
 8fa:	b3d1                	j	6be <vprintf+0x44>
          s = "(null)";
 8fc:	00000497          	auipc	s1,0x0
 900:	2dc48493          	addi	s1,s1,732 # bd8 <malloc+0x1aa>
        for(; *s; s++)
 904:	02800593          	li	a1,40
 908:	b7c5                	j	8e8 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 90a:	8bce                	mv	s7,s3
      state = 0;
 90c:	4981                	li	s3,0
 90e:	bb45                	j	6be <vprintf+0x44>
        putc(fd, '%');
 910:	85be                	mv	a1,a5
 912:	855a                	mv	a0,s6
 914:	ca1ff0ef          	jal	5b4 <putc>
 918:	bdbd                	j	796 <vprintf+0x11c>
 91a:	6906                	ld	s2,64(sp)
 91c:	79e2                	ld	s3,56(sp)
 91e:	7a42                	ld	s4,48(sp)
 920:	7aa2                	ld	s5,40(sp)
 922:	7b02                	ld	s6,32(sp)
 924:	6be2                	ld	s7,24(sp)
 926:	6c42                	ld	s8,16(sp)
    }
  }
}
 928:	60e6                	ld	ra,88(sp)
 92a:	6446                	ld	s0,80(sp)
 92c:	64a6                	ld	s1,72(sp)
 92e:	6125                	addi	sp,sp,96
 930:	8082                	ret
      if(c0 == 'd'){
 932:	06400713          	li	a4,100
 936:	e6e782e3          	beq	a5,a4,79a <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 93a:	f9478693          	addi	a3,a5,-108
 93e:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 942:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 944:	4701                	li	a4,0
 946:	bbe9                	j	720 <vprintf+0xa6>

0000000000000948 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 948:	715d                	addi	sp,sp,-80
 94a:	ec06                	sd	ra,24(sp)
 94c:	e822                	sd	s0,16(sp)
 94e:	1000                	addi	s0,sp,32
 950:	e010                	sd	a2,0(s0)
 952:	e414                	sd	a3,8(s0)
 954:	e818                	sd	a4,16(s0)
 956:	ec1c                	sd	a5,24(s0)
 958:	03043023          	sd	a6,32(s0)
 95c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 960:	8622                	mv	a2,s0
 962:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 966:	d15ff0ef          	jal	67a <vprintf>
}
 96a:	60e2                	ld	ra,24(sp)
 96c:	6442                	ld	s0,16(sp)
 96e:	6161                	addi	sp,sp,80
 970:	8082                	ret

0000000000000972 <printf>:

void
printf(const char *fmt, ...)
{
 972:	711d                	addi	sp,sp,-96
 974:	ec06                	sd	ra,24(sp)
 976:	e822                	sd	s0,16(sp)
 978:	1000                	addi	s0,sp,32
 97a:	e40c                	sd	a1,8(s0)
 97c:	e810                	sd	a2,16(s0)
 97e:	ec14                	sd	a3,24(s0)
 980:	f018                	sd	a4,32(s0)
 982:	f41c                	sd	a5,40(s0)
 984:	03043823          	sd	a6,48(s0)
 988:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 98c:	00840613          	addi	a2,s0,8
 990:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 994:	85aa                	mv	a1,a0
 996:	4505                	li	a0,1
 998:	ce3ff0ef          	jal	67a <vprintf>
}
 99c:	60e2                	ld	ra,24(sp)
 99e:	6442                	ld	s0,16(sp)
 9a0:	6125                	addi	sp,sp,96
 9a2:	8082                	ret

00000000000009a4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9a4:	1141                	addi	sp,sp,-16
 9a6:	e406                	sd	ra,8(sp)
 9a8:	e022                	sd	s0,0(sp)
 9aa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9ac:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9b0:	00000797          	auipc	a5,0x0
 9b4:	6507b783          	ld	a5,1616(a5) # 1000 <freep>
 9b8:	a095                	j	a1c <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 9ba:	ff852583          	lw	a1,-8(a0)
 9be:	6390                	ld	a2,0(a5)
 9c0:	02059813          	slli	a6,a1,0x20
 9c4:	01c85693          	srli	a3,a6,0x1c
 9c8:	96ba                	add	a3,a3,a4
 9ca:	02d60563          	beq	a2,a3,9f4 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 9ce:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 9d2:	4790                	lw	a2,8(a5)
 9d4:	02061593          	slli	a1,a2,0x20
 9d8:	01c5d693          	srli	a3,a1,0x1c
 9dc:	96be                	add	a3,a3,a5
 9de:	02d70263          	beq	a4,a3,a02 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 9e2:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9e4:	00000717          	auipc	a4,0x0
 9e8:	60f73e23          	sd	a5,1564(a4) # 1000 <freep>
}
 9ec:	60a2                	ld	ra,8(sp)
 9ee:	6402                	ld	s0,0(sp)
 9f0:	0141                	addi	sp,sp,16
 9f2:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 9f4:	4614                	lw	a3,8(a2)
 9f6:	9ead                	addw	a3,a3,a1
 9f8:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9fc:	6394                	ld	a3,0(a5)
 9fe:	6290                	ld	a2,0(a3)
 a00:	b7f9                	j	9ce <free+0x2a>
    p->s.size += bp->s.size;
 a02:	ff852703          	lw	a4,-8(a0)
 a06:	9f31                	addw	a4,a4,a2
 a08:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a0a:	ff053703          	ld	a4,-16(a0)
 a0e:	bfd1                	j	9e2 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a10:	6394                	ld	a3,0(a5)
 a12:	00d7e463          	bltu	a5,a3,a1a <free+0x76>
 a16:	fad762e3          	bltu	a4,a3,9ba <free+0x16>
 a1a:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a1c:	fee7fae3          	bgeu	a5,a4,a10 <free+0x6c>
 a20:	6394                	ld	a3,0(a5)
 a22:	f8d76ce3          	bltu	a4,a3,9ba <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a26:	f8d7fae3          	bgeu	a5,a3,9ba <free+0x16>
 a2a:	87b6                	mv	a5,a3
 a2c:	bfc5                	j	a1c <free+0x78>

0000000000000a2e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a2e:	7139                	addi	sp,sp,-64
 a30:	fc06                	sd	ra,56(sp)
 a32:	f822                	sd	s0,48(sp)
 a34:	f04a                	sd	s2,32(sp)
 a36:	ec4e                	sd	s3,24(sp)
 a38:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a3a:	02051993          	slli	s3,a0,0x20
 a3e:	0209d993          	srli	s3,s3,0x20
 a42:	09bd                	addi	s3,s3,15
 a44:	0049d993          	srli	s3,s3,0x4
 a48:	2985                	addiw	s3,s3,1
 a4a:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 a4c:	00000517          	auipc	a0,0x0
 a50:	5b453503          	ld	a0,1460(a0) # 1000 <freep>
 a54:	c905                	beqz	a0,a84 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a56:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a58:	4798                	lw	a4,8(a5)
 a5a:	09377663          	bgeu	a4,s3,ae6 <malloc+0xb8>
 a5e:	f426                	sd	s1,40(sp)
 a60:	e852                	sd	s4,16(sp)
 a62:	e456                	sd	s5,8(sp)
 a64:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a66:	8a4e                	mv	s4,s3
 a68:	6705                	lui	a4,0x1
 a6a:	00e9f363          	bgeu	s3,a4,a70 <malloc+0x42>
 a6e:	6a05                	lui	s4,0x1
 a70:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a74:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a78:	00000497          	auipc	s1,0x0
 a7c:	58848493          	addi	s1,s1,1416 # 1000 <freep>
  if(p == SBRK_ERROR)
 a80:	5afd                	li	s5,-1
 a82:	a83d                	j	ac0 <malloc+0x92>
 a84:	f426                	sd	s1,40(sp)
 a86:	e852                	sd	s4,16(sp)
 a88:	e456                	sd	s5,8(sp)
 a8a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a8c:	00000797          	auipc	a5,0x0
 a90:	58478793          	addi	a5,a5,1412 # 1010 <base>
 a94:	00000717          	auipc	a4,0x0
 a98:	56f73623          	sd	a5,1388(a4) # 1000 <freep>
 a9c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a9e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 aa2:	b7d1                	j	a66 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 aa4:	6398                	ld	a4,0(a5)
 aa6:	e118                	sd	a4,0(a0)
 aa8:	a899                	j	afe <malloc+0xd0>
  hp->s.size = nu;
 aaa:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 aae:	0541                	addi	a0,a0,16
 ab0:	ef5ff0ef          	jal	9a4 <free>
  return freep;
 ab4:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 ab6:	c125                	beqz	a0,b16 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 aba:	4798                	lw	a4,8(a5)
 abc:	03277163          	bgeu	a4,s2,ade <malloc+0xb0>
    if(p == freep)
 ac0:	6098                	ld	a4,0(s1)
 ac2:	853e                	mv	a0,a5
 ac4:	fef71ae3          	bne	a4,a5,ab8 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 ac8:	8552                	mv	a0,s4
 aca:	a17ff0ef          	jal	4e0 <sbrk>
  if(p == SBRK_ERROR)
 ace:	fd551ee3          	bne	a0,s5,aaa <malloc+0x7c>
        return 0;
 ad2:	4501                	li	a0,0
 ad4:	74a2                	ld	s1,40(sp)
 ad6:	6a42                	ld	s4,16(sp)
 ad8:	6aa2                	ld	s5,8(sp)
 ada:	6b02                	ld	s6,0(sp)
 adc:	a03d                	j	b0a <malloc+0xdc>
 ade:	74a2                	ld	s1,40(sp)
 ae0:	6a42                	ld	s4,16(sp)
 ae2:	6aa2                	ld	s5,8(sp)
 ae4:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 ae6:	fae90fe3          	beq	s2,a4,aa4 <malloc+0x76>
        p->s.size -= nunits;
 aea:	4137073b          	subw	a4,a4,s3
 aee:	c798                	sw	a4,8(a5)
        p += p->s.size;
 af0:	02071693          	slli	a3,a4,0x20
 af4:	01c6d713          	srli	a4,a3,0x1c
 af8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 afa:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 afe:	00000717          	auipc	a4,0x0
 b02:	50a73123          	sd	a0,1282(a4) # 1000 <freep>
      return (void*)(p + 1);
 b06:	01078513          	addi	a0,a5,16
  }
}
 b0a:	70e2                	ld	ra,56(sp)
 b0c:	7442                	ld	s0,48(sp)
 b0e:	7902                	ld	s2,32(sp)
 b10:	69e2                	ld	s3,24(sp)
 b12:	6121                	addi	sp,sp,64
 b14:	8082                	ret
 b16:	74a2                	ld	s1,40(sp)
 b18:	6a42                	ld	s4,16(sp)
 b1a:	6aa2                	ld	s5,8(sp)
 b1c:	6b02                	ld	s6,0(sp)
 b1e:	b7f5                	j	b0a <malloc+0xdc>
