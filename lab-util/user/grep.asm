
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	fd250a13          	addi	s4,a0,-46
  1a:	001a3a13          	seqz	s4,s4
    if(matchhere(re, text))
  1e:	85a6                	mv	a1,s1
  20:	854e                	mv	a0,s3
  22:	030000ef          	jal	52 <matchhere>
  26:	ed09                	bnez	a0,40 <matchstar+0x40>
  }while(*text!='\0' && (*text++==c || c=='.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb99                	beqz	a5,42 <matchstar+0x42>
  2e:	0485                	addi	s1,s1,1
  30:	412787b3          	sub	a5,a5,s2
  34:	0017b793          	seqz	a5,a5
  38:	00fa67b3          	or	a5,s4,a5
  3c:	f3ed                	bnez	a5,1e <matchstar+0x1e>
  3e:	a011                	j	42 <matchstar+0x42>
      return 1;
  40:	4505                	li	a0,1
  return 0;
}
  42:	70a2                	ld	ra,40(sp)
  44:	7402                	ld	s0,32(sp)
  46:	64e2                	ld	s1,24(sp)
  48:	6942                	ld	s2,16(sp)
  4a:	69a2                	ld	s3,8(sp)
  4c:	6a02                	ld	s4,0(sp)
  4e:	6145                	addi	sp,sp,48
  50:	8082                	ret

0000000000000052 <matchhere>:
  if(re[0] == '\0')
  52:	00054703          	lbu	a4,0(a0)
  56:	c735                	beqz	a4,c2 <matchhere+0x70>
{
  58:	1141                	addi	sp,sp,-16
  5a:	e406                	sd	ra,8(sp)
  5c:	e022                	sd	s0,0(sp)
  5e:	0800                	addi	s0,sp,16
  if(re[1] == '*')
  60:	00154783          	lbu	a5,1(a0)
  64:	02a00693          	li	a3,42
  68:	02d78c63          	beq	a5,a3,a0 <matchhere+0x4e>
  if(re[0] == '$' && re[1] == '\0')
  6c:	0017b793          	seqz	a5,a5
  70:	fdc70693          	addi	a3,a4,-36
  74:	0016b693          	seqz	a3,a3
  78:	8ff5                	and	a5,a5,a3
  7a:	eb95                	bnez	a5,ae <matchhere+0x5c>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  7c:	0005c783          	lbu	a5,0(a1)
  80:	cb99                	beqz	a5,96 <matchhere+0x44>
  82:	40f707b3          	sub	a5,a4,a5
  86:	0017b793          	seqz	a5,a5
  8a:	fd270713          	addi	a4,a4,-46
  8e:	00173713          	seqz	a4,a4
  92:	8fd9                	or	a5,a5,a4
  94:	e395                	bnez	a5,b8 <matchhere+0x66>
  return 0;
  96:	4501                	li	a0,0
}
  98:	60a2                	ld	ra,8(sp)
  9a:	6402                	ld	s0,0(sp)
  9c:	0141                	addi	sp,sp,16
  9e:	8082                	ret
    return matchstar(re[0], re+2, text);
  a0:	862e                	mv	a2,a1
  a2:	00250593          	addi	a1,a0,2
  a6:	853a                	mv	a0,a4
  a8:	f59ff0ef          	jal	0 <matchstar>
  ac:	b7f5                	j	98 <matchhere+0x46>
    return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	b7cd                	j	98 <matchhere+0x46>
    return matchhere(re+1, text+1);
  b8:	0585                	addi	a1,a1,1
  ba:	0505                	addi	a0,a0,1
  bc:	f97ff0ef          	jal	52 <matchhere>
  c0:	bfe1                	j	98 <matchhere+0x46>
    return 1;
  c2:	4505                	li	a0,1
}
  c4:	8082                	ret

00000000000000c6 <match>:
{
  c6:	1101                	addi	sp,sp,-32
  c8:	ec06                	sd	ra,24(sp)
  ca:	e822                	sd	s0,16(sp)
  cc:	e426                	sd	s1,8(sp)
  ce:	e04a                	sd	s2,0(sp)
  d0:	1000                	addi	s0,sp,32
  d2:	892a                	mv	s2,a0
  d4:	84ae                	mv	s1,a1
  if(re[0] == '^')
  d6:	00054703          	lbu	a4,0(a0)
  da:	05e00793          	li	a5,94
  de:	00f70c63          	beq	a4,a5,f6 <match+0x30>
    if(matchhere(re, text))
  e2:	85a6                	mv	a1,s1
  e4:	854a                	mv	a0,s2
  e6:	f6dff0ef          	jal	52 <matchhere>
  ea:	e911                	bnez	a0,fe <match+0x38>
  }while(*text++ != '\0');
  ec:	0485                	addi	s1,s1,1
  ee:	fff4c783          	lbu	a5,-1(s1)
  f2:	fbe5                	bnez	a5,e2 <match+0x1c>
  f4:	a031                	j	100 <match+0x3a>
    return matchhere(re+1, text);
  f6:	0505                	addi	a0,a0,1
  f8:	f5bff0ef          	jal	52 <matchhere>
  fc:	a011                	j	100 <match+0x3a>
      return 1;
  fe:	4505                	li	a0,1
}
 100:	60e2                	ld	ra,24(sp)
 102:	6442                	ld	s0,16(sp)
 104:	64a2                	ld	s1,8(sp)
 106:	6902                	ld	s2,0(sp)
 108:	6105                	addi	sp,sp,32
 10a:	8082                	ret

000000000000010c <grep>:
{
 10c:	711d                	addi	sp,sp,-96
 10e:	ec86                	sd	ra,88(sp)
 110:	e8a2                	sd	s0,80(sp)
 112:	e4a6                	sd	s1,72(sp)
 114:	e0ca                	sd	s2,64(sp)
 116:	fc4e                	sd	s3,56(sp)
 118:	f852                	sd	s4,48(sp)
 11a:	f456                	sd	s5,40(sp)
 11c:	f05a                	sd	s6,32(sp)
 11e:	ec5e                	sd	s7,24(sp)
 120:	e862                	sd	s8,16(sp)
 122:	e466                	sd	s9,8(sp)
 124:	e06a                	sd	s10,0(sp)
 126:	1080                	addi	s0,sp,96
 128:	8aaa                	mv	s5,a0
 12a:	8cae                	mv	s9,a1
  m = 0;
 12c:	4b01                	li	s6,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 12e:	3ff00d13          	li	s10,1023
 132:	00001b97          	auipc	s7,0x1
 136:	edeb8b93          	addi	s7,s7,-290 # 1010 <buf>
    while((q = strchr(p, '\n')) != 0){
 13a:	49a9                	li	s3,10
        write(1, p, q+1 - p);
 13c:	4c05                	li	s8,1
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 13e:	a82d                	j	178 <grep+0x6c>
      p = q+1;
 140:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 144:	85ce                	mv	a1,s3
 146:	854a                	mv	a0,s2
 148:	1dc000ef          	jal	324 <strchr>
 14c:	84aa                	mv	s1,a0
 14e:	c11d                	beqz	a0,174 <grep+0x68>
      *q = 0;
 150:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 154:	85ca                	mv	a1,s2
 156:	8556                	mv	a0,s5
 158:	f6fff0ef          	jal	c6 <match>
 15c:	d175                	beqz	a0,140 <grep+0x34>
        *q = '\n';
 15e:	01348023          	sb	s3,0(s1)
        write(1, p, q+1 - p);
 162:	00148613          	addi	a2,s1,1
 166:	4126063b          	subw	a2,a2,s2
 16a:	85ca                	mv	a1,s2
 16c:	8562                	mv	a0,s8
 16e:	3da000ef          	jal	548 <write>
 172:	b7f9                	j	140 <grep+0x34>
    if(m > 0){
 174:	03604463          	bgtz	s6,19c <grep+0x90>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 178:	416d063b          	subw	a2,s10,s6
 17c:	016b85b3          	add	a1,s7,s6
 180:	8566                	mv	a0,s9
 182:	3be000ef          	jal	540 <read>
 186:	02a05c63          	blez	a0,1be <grep+0xb2>
    m += n;
 18a:	00ab0a3b          	addw	s4,s6,a0
 18e:	8b52                	mv	s6,s4
    buf[m] = '\0';
 190:	014b87b3          	add	a5,s7,s4
 194:	00078023          	sb	zero,0(a5)
    p = buf;
 198:	895e                	mv	s2,s7
    while((q = strchr(p, '\n')) != 0){
 19a:	b76d                	j	144 <grep+0x38>
      m -= p - buf;
 19c:	00001797          	auipc	a5,0x1
 1a0:	e7478793          	addi	a5,a5,-396 # 1010 <buf>
 1a4:	40f907b3          	sub	a5,s2,a5
 1a8:	40fa063b          	subw	a2,s4,a5
 1ac:	8b32                	mv	s6,a2
      memmove(buf, p, m);
 1ae:	85ca                	mv	a1,s2
 1b0:	00001517          	auipc	a0,0x1
 1b4:	e6050513          	addi	a0,a0,-416 # 1010 <buf>
 1b8:	296000ef          	jal	44e <memmove>
 1bc:	bf75                	j	178 <grep+0x6c>
}
 1be:	60e6                	ld	ra,88(sp)
 1c0:	6446                	ld	s0,80(sp)
 1c2:	64a6                	ld	s1,72(sp)
 1c4:	6906                	ld	s2,64(sp)
 1c6:	79e2                	ld	s3,56(sp)
 1c8:	7a42                	ld	s4,48(sp)
 1ca:	7aa2                	ld	s5,40(sp)
 1cc:	7b02                	ld	s6,32(sp)
 1ce:	6be2                	ld	s7,24(sp)
 1d0:	6c42                	ld	s8,16(sp)
 1d2:	6ca2                	ld	s9,8(sp)
 1d4:	6d02                	ld	s10,0(sp)
 1d6:	6125                	addi	sp,sp,96
 1d8:	8082                	ret

00000000000001da <main>:
{
 1da:	7179                	addi	sp,sp,-48
 1dc:	f406                	sd	ra,40(sp)
 1de:	f022                	sd	s0,32(sp)
 1e0:	ec26                	sd	s1,24(sp)
 1e2:	e84a                	sd	s2,16(sp)
 1e4:	e44e                	sd	s3,8(sp)
 1e6:	e052                	sd	s4,0(sp)
 1e8:	1800                	addi	s0,sp,48
  if(argc <= 1){
 1ea:	4785                	li	a5,1
 1ec:	04a7d663          	bge	a5,a0,238 <main+0x5e>
  pattern = argv[1];
 1f0:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 1f4:	4789                	li	a5,2
 1f6:	04a7db63          	bge	a5,a0,24c <main+0x72>
 1fa:	01058913          	addi	s2,a1,16
 1fe:	ffd5099b          	addiw	s3,a0,-3
 202:	02099793          	slli	a5,s3,0x20
 206:	01d7d993          	srli	s3,a5,0x1d
 20a:	05e1                	addi	a1,a1,24
 20c:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], O_RDONLY)) < 0){
 20e:	4581                	li	a1,0
 210:	00093503          	ld	a0,0(s2)
 214:	354000ef          	jal	568 <open>
 218:	84aa                	mv	s1,a0
 21a:	04054063          	bltz	a0,25a <main+0x80>
    grep(pattern, fd);
 21e:	85aa                	mv	a1,a0
 220:	8552                	mv	a0,s4
 222:	eebff0ef          	jal	10c <grep>
    close(fd);
 226:	8526                	mv	a0,s1
 228:	328000ef          	jal	550 <close>
  for(i = 2; i < argc; i++){
 22c:	0921                	addi	s2,s2,8
 22e:	ff3910e3          	bne	s2,s3,20e <main+0x34>
  exit(0);
 232:	4501                	li	a0,0
 234:	2f4000ef          	jal	528 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 238:	00001597          	auipc	a1,0x1
 23c:	90858593          	addi	a1,a1,-1784 # b40 <malloc+0xfe>
 240:	4509                	li	a0,2
 242:	71a000ef          	jal	95c <fprintf>
    exit(1);
 246:	4505                	li	a0,1
 248:	2e0000ef          	jal	528 <exit>
    grep(pattern, 0);
 24c:	4581                	li	a1,0
 24e:	8552                	mv	a0,s4
 250:	ebdff0ef          	jal	10c <grep>
    exit(0);
 254:	4501                	li	a0,0
 256:	2d2000ef          	jal	528 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 25a:	00093583          	ld	a1,0(s2)
 25e:	00001517          	auipc	a0,0x1
 262:	90250513          	addi	a0,a0,-1790 # b60 <malloc+0x11e>
 266:	720000ef          	jal	986 <printf>
      exit(1);
 26a:	4505                	li	a0,1
 26c:	2bc000ef          	jal	528 <exit>

0000000000000270 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 270:	1141                	addi	sp,sp,-16
 272:	e406                	sd	ra,8(sp)
 274:	e022                	sd	s0,0(sp)
 276:	0800                	addi	s0,sp,16
  extern int main();
  main();
 278:	f63ff0ef          	jal	1da <main>
  exit(0);
 27c:	4501                	li	a0,0
 27e:	2aa000ef          	jal	528 <exit>

0000000000000282 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 282:	1141                	addi	sp,sp,-16
 284:	e406                	sd	ra,8(sp)
 286:	e022                	sd	s0,0(sp)
 288:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 28a:	87aa                	mv	a5,a0
 28c:	0585                	addi	a1,a1,1
 28e:	0785                	addi	a5,a5,1
 290:	fff5c703          	lbu	a4,-1(a1)
 294:	fee78fa3          	sb	a4,-1(a5)
 298:	fb75                	bnez	a4,28c <strcpy+0xa>
    ;
  return os;
}
 29a:	60a2                	ld	ra,8(sp)
 29c:	6402                	ld	s0,0(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret

00000000000002a2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2a2:	1141                	addi	sp,sp,-16
 2a4:	e406                	sd	ra,8(sp)
 2a6:	e022                	sd	s0,0(sp)
 2a8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2aa:	00054783          	lbu	a5,0(a0)
 2ae:	cb91                	beqz	a5,2c2 <strcmp+0x20>
 2b0:	0005c703          	lbu	a4,0(a1)
 2b4:	00f71763          	bne	a4,a5,2c2 <strcmp+0x20>
    p++, q++;
 2b8:	0505                	addi	a0,a0,1
 2ba:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2bc:	00054783          	lbu	a5,0(a0)
 2c0:	fbe5                	bnez	a5,2b0 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 2c2:	0005c503          	lbu	a0,0(a1)
}
 2c6:	40a7853b          	subw	a0,a5,a0
 2ca:	60a2                	ld	ra,8(sp)
 2cc:	6402                	ld	s0,0(sp)
 2ce:	0141                	addi	sp,sp,16
 2d0:	8082                	ret

00000000000002d2 <strlen>:

uint
strlen(const char *s)
{
 2d2:	1141                	addi	sp,sp,-16
 2d4:	e406                	sd	ra,8(sp)
 2d6:	e022                	sd	s0,0(sp)
 2d8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2da:	00054783          	lbu	a5,0(a0)
 2de:	cf91                	beqz	a5,2fa <strlen+0x28>
 2e0:	00150793          	addi	a5,a0,1
 2e4:	86be                	mv	a3,a5
 2e6:	0785                	addi	a5,a5,1
 2e8:	fff7c703          	lbu	a4,-1(a5)
 2ec:	ff65                	bnez	a4,2e4 <strlen+0x12>
 2ee:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 2f2:	60a2                	ld	ra,8(sp)
 2f4:	6402                	ld	s0,0(sp)
 2f6:	0141                	addi	sp,sp,16
 2f8:	8082                	ret
  for(n = 0; s[n]; n++)
 2fa:	4501                	li	a0,0
 2fc:	bfdd                	j	2f2 <strlen+0x20>

00000000000002fe <memset>:

void*
memset(void *dst, int c, uint n)
{
 2fe:	1141                	addi	sp,sp,-16
 300:	e406                	sd	ra,8(sp)
 302:	e022                	sd	s0,0(sp)
 304:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 306:	ca19                	beqz	a2,31c <memset+0x1e>
 308:	87aa                	mv	a5,a0
 30a:	1602                	slli	a2,a2,0x20
 30c:	9201                	srli	a2,a2,0x20
 30e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 312:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 316:	0785                	addi	a5,a5,1
 318:	fee79de3          	bne	a5,a4,312 <memset+0x14>
  }
  return dst;
}
 31c:	60a2                	ld	ra,8(sp)
 31e:	6402                	ld	s0,0(sp)
 320:	0141                	addi	sp,sp,16
 322:	8082                	ret

0000000000000324 <strchr>:

char*
strchr(const char *s, char c)
{
 324:	1141                	addi	sp,sp,-16
 326:	e406                	sd	ra,8(sp)
 328:	e022                	sd	s0,0(sp)
 32a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 32c:	00054783          	lbu	a5,0(a0)
 330:	c799                	beqz	a5,33e <strchr+0x1a>
    if(*s == c)
 332:	00f58763          	beq	a1,a5,340 <strchr+0x1c>
  for(; *s; s++)
 336:	0505                	addi	a0,a0,1
 338:	00054783          	lbu	a5,0(a0)
 33c:	fbfd                	bnez	a5,332 <strchr+0xe>
      return (char*)s;
  return 0;
 33e:	4501                	li	a0,0
}
 340:	60a2                	ld	ra,8(sp)
 342:	6402                	ld	s0,0(sp)
 344:	0141                	addi	sp,sp,16
 346:	8082                	ret

0000000000000348 <gets>:

char*
gets(char *buf, int max)
{
 348:	711d                	addi	sp,sp,-96
 34a:	ec86                	sd	ra,88(sp)
 34c:	e8a2                	sd	s0,80(sp)
 34e:	e4a6                	sd	s1,72(sp)
 350:	e0ca                	sd	s2,64(sp)
 352:	fc4e                	sd	s3,56(sp)
 354:	f852                	sd	s4,48(sp)
 356:	f456                	sd	s5,40(sp)
 358:	f05a                	sd	s6,32(sp)
 35a:	ec5e                	sd	s7,24(sp)
 35c:	e862                	sd	s8,16(sp)
 35e:	1080                	addi	s0,sp,96
 360:	8baa                	mv	s7,a0
 362:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 364:	892a                	mv	s2,a0
 366:	4481                	li	s1,0
    cc = read(0, &c, 1);
 368:	faf40b13          	addi	s6,s0,-81
 36c:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 36e:	8c26                	mv	s8,s1
 370:	0014899b          	addiw	s3,s1,1
 374:	84ce                	mv	s1,s3
 376:	0349d863          	bge	s3,s4,3a6 <gets+0x5e>
    cc = read(0, &c, 1);
 37a:	8656                	mv	a2,s5
 37c:	85da                	mv	a1,s6
 37e:	4501                	li	a0,0
 380:	1c0000ef          	jal	540 <read>
    if(cc < 1)
 384:	02a05163          	blez	a0,3a6 <gets+0x5e>
      break;
    buf[i++] = c;
 388:	faf44783          	lbu	a5,-81(s0)
 38c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 390:	0905                	addi	s2,s2,1
 392:	ff678713          	addi	a4,a5,-10
 396:	00173713          	seqz	a4,a4
 39a:	17cd                	addi	a5,a5,-13
 39c:	0017b793          	seqz	a5,a5
 3a0:	8fd9                	or	a5,a5,a4
 3a2:	d7f1                	beqz	a5,36e <gets+0x26>
    buf[i++] = c;
 3a4:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 3a6:	9c5e                	add	s8,s8,s7
 3a8:	000c0023          	sb	zero,0(s8)
  return buf;
}
 3ac:	855e                	mv	a0,s7
 3ae:	60e6                	ld	ra,88(sp)
 3b0:	6446                	ld	s0,80(sp)
 3b2:	64a6                	ld	s1,72(sp)
 3b4:	6906                	ld	s2,64(sp)
 3b6:	79e2                	ld	s3,56(sp)
 3b8:	7a42                	ld	s4,48(sp)
 3ba:	7aa2                	ld	s5,40(sp)
 3bc:	7b02                	ld	s6,32(sp)
 3be:	6be2                	ld	s7,24(sp)
 3c0:	6c42                	ld	s8,16(sp)
 3c2:	6125                	addi	sp,sp,96
 3c4:	8082                	ret

00000000000003c6 <stat>:

int
stat(const char *n, struct stat *st)
{
 3c6:	1101                	addi	sp,sp,-32
 3c8:	ec06                	sd	ra,24(sp)
 3ca:	e822                	sd	s0,16(sp)
 3cc:	e04a                	sd	s2,0(sp)
 3ce:	1000                	addi	s0,sp,32
 3d0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3d2:	4581                	li	a1,0
 3d4:	194000ef          	jal	568 <open>
  if(fd < 0)
 3d8:	02054263          	bltz	a0,3fc <stat+0x36>
 3dc:	e426                	sd	s1,8(sp)
 3de:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3e0:	85ca                	mv	a1,s2
 3e2:	19e000ef          	jal	580 <fstat>
 3e6:	892a                	mv	s2,a0
  close(fd);
 3e8:	8526                	mv	a0,s1
 3ea:	166000ef          	jal	550 <close>
  return r;
 3ee:	64a2                	ld	s1,8(sp)
}
 3f0:	854a                	mv	a0,s2
 3f2:	60e2                	ld	ra,24(sp)
 3f4:	6442                	ld	s0,16(sp)
 3f6:	6902                	ld	s2,0(sp)
 3f8:	6105                	addi	sp,sp,32
 3fa:	8082                	ret
    return -1;
 3fc:	57fd                	li	a5,-1
 3fe:	893e                	mv	s2,a5
 400:	bfc5                	j	3f0 <stat+0x2a>

0000000000000402 <atoi>:

int
atoi(const char *s)
{
 402:	1141                	addi	sp,sp,-16
 404:	e406                	sd	ra,8(sp)
 406:	e022                	sd	s0,0(sp)
 408:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 40a:	00054683          	lbu	a3,0(a0)
 40e:	fd06879b          	addiw	a5,a3,-48
 412:	0ff7f793          	zext.b	a5,a5
 416:	4625                	li	a2,9
 418:	02f66963          	bltu	a2,a5,44a <atoi+0x48>
 41c:	872a                	mv	a4,a0
  n = 0;
 41e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 420:	0705                	addi	a4,a4,1
 422:	0025179b          	slliw	a5,a0,0x2
 426:	9fa9                	addw	a5,a5,a0
 428:	0017979b          	slliw	a5,a5,0x1
 42c:	9fb5                	addw	a5,a5,a3
 42e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 432:	00074683          	lbu	a3,0(a4)
 436:	fd06879b          	addiw	a5,a3,-48
 43a:	0ff7f793          	zext.b	a5,a5
 43e:	fef671e3          	bgeu	a2,a5,420 <atoi+0x1e>
  return n;
}
 442:	60a2                	ld	ra,8(sp)
 444:	6402                	ld	s0,0(sp)
 446:	0141                	addi	sp,sp,16
 448:	8082                	ret
  n = 0;
 44a:	4501                	li	a0,0
 44c:	bfdd                	j	442 <atoi+0x40>

000000000000044e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 44e:	1141                	addi	sp,sp,-16
 450:	e406                	sd	ra,8(sp)
 452:	e022                	sd	s0,0(sp)
 454:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 456:	02b57563          	bgeu	a0,a1,480 <memmove+0x32>
    while(n-- > 0)
 45a:	00c05f63          	blez	a2,478 <memmove+0x2a>
 45e:	1602                	slli	a2,a2,0x20
 460:	9201                	srli	a2,a2,0x20
 462:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 466:	872a                	mv	a4,a0
      *dst++ = *src++;
 468:	0585                	addi	a1,a1,1
 46a:	0705                	addi	a4,a4,1
 46c:	fff5c683          	lbu	a3,-1(a1)
 470:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 474:	fee79ae3          	bne	a5,a4,468 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 478:	60a2                	ld	ra,8(sp)
 47a:	6402                	ld	s0,0(sp)
 47c:	0141                	addi	sp,sp,16
 47e:	8082                	ret
    while(n-- > 0)
 480:	fec05ce3          	blez	a2,478 <memmove+0x2a>
    dst += n;
 484:	00c50733          	add	a4,a0,a2
    src += n;
 488:	95b2                	add	a1,a1,a2
 48a:	fff6079b          	addiw	a5,a2,-1
 48e:	1782                	slli	a5,a5,0x20
 490:	9381                	srli	a5,a5,0x20
 492:	fff7c793          	not	a5,a5
 496:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 498:	15fd                	addi	a1,a1,-1
 49a:	177d                	addi	a4,a4,-1
 49c:	0005c683          	lbu	a3,0(a1)
 4a0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4a4:	fef71ae3          	bne	a4,a5,498 <memmove+0x4a>
 4a8:	bfc1                	j	478 <memmove+0x2a>

00000000000004aa <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4aa:	1141                	addi	sp,sp,-16
 4ac:	e406                	sd	ra,8(sp)
 4ae:	e022                	sd	s0,0(sp)
 4b0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4b2:	ce19                	beqz	a2,4d0 <memcmp+0x26>
 4b4:	1602                	slli	a2,a2,0x20
 4b6:	9201                	srli	a2,a2,0x20
 4b8:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 4bc:	00054783          	lbu	a5,0(a0)
 4c0:	0005c703          	lbu	a4,0(a1)
 4c4:	00e79b63          	bne	a5,a4,4da <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 4c8:	0505                	addi	a0,a0,1
    p2++;
 4ca:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4cc:	fed518e3          	bne	a0,a3,4bc <memcmp+0x12>
  }
  return 0;
 4d0:	4501                	li	a0,0
}
 4d2:	60a2                	ld	ra,8(sp)
 4d4:	6402                	ld	s0,0(sp)
 4d6:	0141                	addi	sp,sp,16
 4d8:	8082                	ret
      return *p1 - *p2;
 4da:	40e7853b          	subw	a0,a5,a4
 4de:	bfd5                	j	4d2 <memcmp+0x28>

00000000000004e0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4e0:	1141                	addi	sp,sp,-16
 4e2:	e406                	sd	ra,8(sp)
 4e4:	e022                	sd	s0,0(sp)
 4e6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4e8:	f67ff0ef          	jal	44e <memmove>
}
 4ec:	60a2                	ld	ra,8(sp)
 4ee:	6402                	ld	s0,0(sp)
 4f0:	0141                	addi	sp,sp,16
 4f2:	8082                	ret

00000000000004f4 <sbrk>:

char *
sbrk(int n) {
 4f4:	1141                	addi	sp,sp,-16
 4f6:	e406                	sd	ra,8(sp)
 4f8:	e022                	sd	s0,0(sp)
 4fa:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 4fc:	4585                	li	a1,1
 4fe:	0b2000ef          	jal	5b0 <sys_sbrk>
}
 502:	60a2                	ld	ra,8(sp)
 504:	6402                	ld	s0,0(sp)
 506:	0141                	addi	sp,sp,16
 508:	8082                	ret

000000000000050a <sbrklazy>:

char *
sbrklazy(int n) {
 50a:	1141                	addi	sp,sp,-16
 50c:	e406                	sd	ra,8(sp)
 50e:	e022                	sd	s0,0(sp)
 510:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 512:	4589                	li	a1,2
 514:	09c000ef          	jal	5b0 <sys_sbrk>
}
 518:	60a2                	ld	ra,8(sp)
 51a:	6402                	ld	s0,0(sp)
 51c:	0141                	addi	sp,sp,16
 51e:	8082                	ret

0000000000000520 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 520:	4885                	li	a7,1
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <exit>:
.global exit
exit:
 li a7, SYS_exit
 528:	4889                	li	a7,2
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <wait>:
.global wait
wait:
 li a7, SYS_wait
 530:	488d                	li	a7,3
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 538:	4891                	li	a7,4
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <read>:
.global read
read:
 li a7, SYS_read
 540:	4895                	li	a7,5
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <write>:
.global write
write:
 li a7, SYS_write
 548:	48c1                	li	a7,16
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <close>:
.global close
close:
 li a7, SYS_close
 550:	48d5                	li	a7,21
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <kill>:
.global kill
kill:
 li a7, SYS_kill
 558:	4899                	li	a7,6
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <exec>:
.global exec
exec:
 li a7, SYS_exec
 560:	489d                	li	a7,7
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <open>:
.global open
open:
 li a7, SYS_open
 568:	48bd                	li	a7,15
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 570:	48c5                	li	a7,17
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 578:	48c9                	li	a7,18
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 580:	48a1                	li	a7,8
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <link>:
.global link
link:
 li a7, SYS_link
 588:	48cd                	li	a7,19
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 590:	48d1                	li	a7,20
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 598:	48a5                	li	a7,9
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5a0:	48a9                	li	a7,10
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5a8:	48ad                	li	a7,11
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 5b0:	48b1                	li	a7,12
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <pause>:
.global pause
pause:
 li a7, SYS_pause
 5b8:	48b5                	li	a7,13
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5c0:	48b9                	li	a7,14
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5c8:	1101                	addi	sp,sp,-32
 5ca:	ec06                	sd	ra,24(sp)
 5cc:	e822                	sd	s0,16(sp)
 5ce:	1000                	addi	s0,sp,32
 5d0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5d4:	4605                	li	a2,1
 5d6:	fef40593          	addi	a1,s0,-17
 5da:	f6fff0ef          	jal	548 <write>
}
 5de:	60e2                	ld	ra,24(sp)
 5e0:	6442                	ld	s0,16(sp)
 5e2:	6105                	addi	sp,sp,32
 5e4:	8082                	ret

00000000000005e6 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 5e6:	715d                	addi	sp,sp,-80
 5e8:	e486                	sd	ra,72(sp)
 5ea:	e0a2                	sd	s0,64(sp)
 5ec:	f84a                	sd	s2,48(sp)
 5ee:	f44e                	sd	s3,40(sp)
 5f0:	0880                	addi	s0,sp,80
 5f2:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5f4:	00d036b3          	snez	a3,a3
 5f8:	03f5d793          	srli	a5,a1,0x3f
 5fc:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5fe:	0005871b          	sext.w	a4,a1
  neg = 0;
 602:	4301                	li	t1,0
  if(sgn && xx < 0){
 604:	c681                	beqz	a3,60c <printint+0x26>
    x = -xx;
 606:	40b0073b          	negw	a4,a1
    neg = 1;
 60a:	4305                	li	t1,1
  }

  i = 0;
 60c:	fb840993          	addi	s3,s0,-72
  neg = 0;
 610:	85ce                	mv	a1,s3
  i = 0;
 612:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 614:	00000817          	auipc	a6,0x0
 618:	56c80813          	addi	a6,a6,1388 # b80 <digits>
 61c:	88b6                	mv	a7,a3
 61e:	0016851b          	addiw	a0,a3,1
 622:	86aa                	mv	a3,a0
 624:	02c777bb          	remuw	a5,a4,a2
 628:	1782                	slli	a5,a5,0x20
 62a:	9381                	srli	a5,a5,0x20
 62c:	97c2                	add	a5,a5,a6
 62e:	0007c783          	lbu	a5,0(a5)
 632:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 636:	87ba                	mv	a5,a4
 638:	02c7573b          	divuw	a4,a4,a2
 63c:	0585                	addi	a1,a1,1
 63e:	fcc7ffe3          	bgeu	a5,a2,61c <printint+0x36>
  if(neg)
 642:	00030b63          	beqz	t1,658 <printint+0x72>
    buf[i++] = '-';
 646:	fd040793          	addi	a5,s0,-48
 64a:	953e                	add	a0,a0,a5
 64c:	02d00793          	li	a5,45
 650:	fef50423          	sb	a5,-24(a0)
 654:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 658:	02d05563          	blez	a3,682 <printint+0x9c>
 65c:	fc26                	sd	s1,56(sp)
 65e:	36fd                	addiw	a3,a3,-1
 660:	00d984b3          	add	s1,s3,a3
 664:	19fd                	addi	s3,s3,-1
 666:	99b6                	add	s3,s3,a3
 668:	1682                	slli	a3,a3,0x20
 66a:	9281                	srli	a3,a3,0x20
 66c:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 670:	0004c583          	lbu	a1,0(s1)
 674:	854a                	mv	a0,s2
 676:	f53ff0ef          	jal	5c8 <putc>
  while(--i >= 0)
 67a:	14fd                	addi	s1,s1,-1
 67c:	ff349ae3          	bne	s1,s3,670 <printint+0x8a>
 680:	74e2                	ld	s1,56(sp)
}
 682:	60a6                	ld	ra,72(sp)
 684:	6406                	ld	s0,64(sp)
 686:	7942                	ld	s2,48(sp)
 688:	79a2                	ld	s3,40(sp)
 68a:	6161                	addi	sp,sp,80
 68c:	8082                	ret

000000000000068e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 68e:	711d                	addi	sp,sp,-96
 690:	ec86                	sd	ra,88(sp)
 692:	e8a2                	sd	s0,80(sp)
 694:	e4a6                	sd	s1,72(sp)
 696:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 698:	0005c483          	lbu	s1,0(a1)
 69c:	2a048063          	beqz	s1,93c <vprintf+0x2ae>
 6a0:	e0ca                	sd	s2,64(sp)
 6a2:	fc4e                	sd	s3,56(sp)
 6a4:	f852                	sd	s4,48(sp)
 6a6:	f456                	sd	s5,40(sp)
 6a8:	f05a                	sd	s6,32(sp)
 6aa:	ec5e                	sd	s7,24(sp)
 6ac:	e862                	sd	s8,16(sp)
 6ae:	8b2a                	mv	s6,a0
 6b0:	8a2e                	mv	s4,a1
 6b2:	8bb2                	mv	s7,a2
  state = 0;
 6b4:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 6b6:	4901                	li	s2,0
 6b8:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 6ba:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 6be:	06400c13          	li	s8,100
 6c2:	a00d                	j	6e4 <vprintf+0x56>
        putc(fd, c0);
 6c4:	85a6                	mv	a1,s1
 6c6:	855a                	mv	a0,s6
 6c8:	f01ff0ef          	jal	5c8 <putc>
 6cc:	a019                	j	6d2 <vprintf+0x44>
    } else if(state == '%'){
 6ce:	03598363          	beq	s3,s5,6f4 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 6d2:	0019079b          	addiw	a5,s2,1
 6d6:	893e                	mv	s2,a5
 6d8:	873e                	mv	a4,a5
 6da:	97d2                	add	a5,a5,s4
 6dc:	0007c483          	lbu	s1,0(a5)
 6e0:	24048763          	beqz	s1,92e <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 6e4:	0004879b          	sext.w	a5,s1
    if(state == 0){
 6e8:	fe0993e3          	bnez	s3,6ce <vprintf+0x40>
      if(c0 == '%'){
 6ec:	fd579ce3          	bne	a5,s5,6c4 <vprintf+0x36>
        state = '%';
 6f0:	89be                	mv	s3,a5
 6f2:	b7c5                	j	6d2 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 6f4:	00ea06b3          	add	a3,s4,a4
 6f8:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 6fc:	24060563          	beqz	a2,946 <vprintf+0x2b8>
      if(c0 == 'd'){
 700:	0b878763          	beq	a5,s8,7ae <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 704:	f9478693          	addi	a3,a5,-108
 708:	0016b693          	seqz	a3,a3
 70c:	f9c60593          	addi	a1,a2,-100
 710:	0015b593          	seqz	a1,a1
 714:	8df5                	and	a1,a1,a3
 716:	e9c5                	bnez	a1,7c6 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 718:	9752                	add	a4,a4,s4
 71a:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 71e:	f9460713          	addi	a4,a2,-108
 722:	00173713          	seqz	a4,a4
 726:	8f75                	and	a4,a4,a3
 728:	f9c50593          	addi	a1,a0,-100
 72c:	0015b593          	seqz	a1,a1
 730:	8df9                	and	a1,a1,a4
 732:	e5dd                	bnez	a1,7e0 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 734:	07500593          	li	a1,117
 738:	0cb78163          	beq	a5,a1,7fa <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 73c:	f8b60593          	addi	a1,a2,-117
 740:	0015b593          	seqz	a1,a1
 744:	8df5                	and	a1,a1,a3
 746:	e5f1                	bnez	a1,812 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 748:	f8b50593          	addi	a1,a0,-117
 74c:	0015b593          	seqz	a1,a1
 750:	8df9                	and	a1,a1,a4
 752:	ede9                	bnez	a1,82c <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 754:	07800593          	li	a1,120
 758:	0eb78763          	beq	a5,a1,846 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 75c:	f8860613          	addi	a2,a2,-120
 760:	00163613          	seqz	a2,a2
 764:	8ef1                	and	a3,a3,a2
 766:	0e069c63          	bnez	a3,85e <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 76a:	f8850513          	addi	a0,a0,-120
 76e:	00153513          	seqz	a0,a0
 772:	8f69                	and	a4,a4,a0
 774:	10071263          	bnez	a4,878 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 778:	07000713          	li	a4,112
 77c:	10e78a63          	beq	a5,a4,890 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 780:	06300713          	li	a4,99
 784:	14e78a63          	beq	a5,a4,8d8 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 788:	07300713          	li	a4,115
 78c:	16e78063          	beq	a5,a4,8ec <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 790:	02500713          	li	a4,37
 794:	18e78863          	beq	a5,a4,924 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 798:	02500593          	li	a1,37
 79c:	855a                	mv	a0,s6
 79e:	e2bff0ef          	jal	5c8 <putc>
        putc(fd, c0);
 7a2:	85a6                	mv	a1,s1
 7a4:	855a                	mv	a0,s6
 7a6:	e23ff0ef          	jal	5c8 <putc>
      }

      state = 0;
 7aa:	4981                	li	s3,0
 7ac:	b71d                	j	6d2 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 7ae:	008b8493          	addi	s1,s7,8
 7b2:	4685                	li	a3,1
 7b4:	4629                	li	a2,10
 7b6:	000ba583          	lw	a1,0(s7)
 7ba:	855a                	mv	a0,s6
 7bc:	e2bff0ef          	jal	5e6 <printint>
 7c0:	8ba6                	mv	s7,s1
      state = 0;
 7c2:	4981                	li	s3,0
 7c4:	b739                	j	6d2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7c6:	008b8493          	addi	s1,s7,8
 7ca:	4685                	li	a3,1
 7cc:	4629                	li	a2,10
 7ce:	000bb583          	ld	a1,0(s7)
 7d2:	855a                	mv	a0,s6
 7d4:	e13ff0ef          	jal	5e6 <printint>
        i += 1;
 7d8:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 7da:	8ba6                	mv	s7,s1
      state = 0;
 7dc:	4981                	li	s3,0
 7de:	bdd5                	j	6d2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7e0:	008b8493          	addi	s1,s7,8
 7e4:	4685                	li	a3,1
 7e6:	4629                	li	a2,10
 7e8:	000bb583          	ld	a1,0(s7)
 7ec:	855a                	mv	a0,s6
 7ee:	df9ff0ef          	jal	5e6 <printint>
        i += 2;
 7f2:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 7f4:	8ba6                	mv	s7,s1
      state = 0;
 7f6:	4981                	li	s3,0
        i += 2;
 7f8:	bde9                	j	6d2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 7fa:	008b8493          	addi	s1,s7,8
 7fe:	4681                	li	a3,0
 800:	4629                	li	a2,10
 802:	000be583          	lwu	a1,0(s7)
 806:	855a                	mv	a0,s6
 808:	ddfff0ef          	jal	5e6 <printint>
 80c:	8ba6                	mv	s7,s1
      state = 0;
 80e:	4981                	li	s3,0
 810:	b5c9                	j	6d2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 812:	008b8493          	addi	s1,s7,8
 816:	4681                	li	a3,0
 818:	4629                	li	a2,10
 81a:	000bb583          	ld	a1,0(s7)
 81e:	855a                	mv	a0,s6
 820:	dc7ff0ef          	jal	5e6 <printint>
        i += 1;
 824:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 826:	8ba6                	mv	s7,s1
      state = 0;
 828:	4981                	li	s3,0
 82a:	b565                	j	6d2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 82c:	008b8493          	addi	s1,s7,8
 830:	4681                	li	a3,0
 832:	4629                	li	a2,10
 834:	000bb583          	ld	a1,0(s7)
 838:	855a                	mv	a0,s6
 83a:	dadff0ef          	jal	5e6 <printint>
        i += 2;
 83e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 840:	8ba6                	mv	s7,s1
      state = 0;
 842:	4981                	li	s3,0
        i += 2;
 844:	b579                	j	6d2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 846:	008b8493          	addi	s1,s7,8
 84a:	4681                	li	a3,0
 84c:	4641                	li	a2,16
 84e:	000be583          	lwu	a1,0(s7)
 852:	855a                	mv	a0,s6
 854:	d93ff0ef          	jal	5e6 <printint>
 858:	8ba6                	mv	s7,s1
      state = 0;
 85a:	4981                	li	s3,0
 85c:	bd9d                	j	6d2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 85e:	008b8493          	addi	s1,s7,8
 862:	4681                	li	a3,0
 864:	4641                	li	a2,16
 866:	000bb583          	ld	a1,0(s7)
 86a:	855a                	mv	a0,s6
 86c:	d7bff0ef          	jal	5e6 <printint>
        i += 1;
 870:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 872:	8ba6                	mv	s7,s1
      state = 0;
 874:	4981                	li	s3,0
 876:	bdb1                	j	6d2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 878:	008b8493          	addi	s1,s7,8
 87c:	4641                	li	a2,16
 87e:	000bb583          	ld	a1,0(s7)
 882:	855a                	mv	a0,s6
 884:	d63ff0ef          	jal	5e6 <printint>
        i += 2;
 888:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 88a:	8ba6                	mv	s7,s1
      state = 0;
 88c:	4981                	li	s3,0
        i += 2;
 88e:	b591                	j	6d2 <vprintf+0x44>
 890:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 892:	008b8793          	addi	a5,s7,8
 896:	8cbe                	mv	s9,a5
 898:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 89c:	03000593          	li	a1,48
 8a0:	855a                	mv	a0,s6
 8a2:	d27ff0ef          	jal	5c8 <putc>
  putc(fd, 'x');
 8a6:	07800593          	li	a1,120
 8aa:	855a                	mv	a0,s6
 8ac:	d1dff0ef          	jal	5c8 <putc>
 8b0:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8b2:	00000b97          	auipc	s7,0x0
 8b6:	2ceb8b93          	addi	s7,s7,718 # b80 <digits>
 8ba:	03c9d793          	srli	a5,s3,0x3c
 8be:	97de                	add	a5,a5,s7
 8c0:	0007c583          	lbu	a1,0(a5)
 8c4:	855a                	mv	a0,s6
 8c6:	d03ff0ef          	jal	5c8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8ca:	0992                	slli	s3,s3,0x4
 8cc:	34fd                	addiw	s1,s1,-1
 8ce:	f4f5                	bnez	s1,8ba <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 8d0:	8be6                	mv	s7,s9
      state = 0;
 8d2:	4981                	li	s3,0
 8d4:	6ca2                	ld	s9,8(sp)
 8d6:	bbf5                	j	6d2 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 8d8:	008b8493          	addi	s1,s7,8
 8dc:	000bc583          	lbu	a1,0(s7)
 8e0:	855a                	mv	a0,s6
 8e2:	ce7ff0ef          	jal	5c8 <putc>
 8e6:	8ba6                	mv	s7,s1
      state = 0;
 8e8:	4981                	li	s3,0
 8ea:	b3e5                	j	6d2 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 8ec:	008b8993          	addi	s3,s7,8
 8f0:	000bb483          	ld	s1,0(s7)
 8f4:	cc91                	beqz	s1,910 <vprintf+0x282>
        for(; *s; s++)
 8f6:	0004c583          	lbu	a1,0(s1)
 8fa:	c195                	beqz	a1,91e <vprintf+0x290>
          putc(fd, *s);
 8fc:	855a                	mv	a0,s6
 8fe:	ccbff0ef          	jal	5c8 <putc>
        for(; *s; s++)
 902:	0485                	addi	s1,s1,1
 904:	0004c583          	lbu	a1,0(s1)
 908:	f9f5                	bnez	a1,8fc <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 90a:	8bce                	mv	s7,s3
      state = 0;
 90c:	4981                	li	s3,0
 90e:	b3d1                	j	6d2 <vprintf+0x44>
          s = "(null)";
 910:	00000497          	auipc	s1,0x0
 914:	26848493          	addi	s1,s1,616 # b78 <malloc+0x136>
        for(; *s; s++)
 918:	02800593          	li	a1,40
 91c:	b7c5                	j	8fc <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 91e:	8bce                	mv	s7,s3
      state = 0;
 920:	4981                	li	s3,0
 922:	bb45                	j	6d2 <vprintf+0x44>
        putc(fd, '%');
 924:	85be                	mv	a1,a5
 926:	855a                	mv	a0,s6
 928:	ca1ff0ef          	jal	5c8 <putc>
 92c:	bdbd                	j	7aa <vprintf+0x11c>
 92e:	6906                	ld	s2,64(sp)
 930:	79e2                	ld	s3,56(sp)
 932:	7a42                	ld	s4,48(sp)
 934:	7aa2                	ld	s5,40(sp)
 936:	7b02                	ld	s6,32(sp)
 938:	6be2                	ld	s7,24(sp)
 93a:	6c42                	ld	s8,16(sp)
    }
  }
}
 93c:	60e6                	ld	ra,88(sp)
 93e:	6446                	ld	s0,80(sp)
 940:	64a6                	ld	s1,72(sp)
 942:	6125                	addi	sp,sp,96
 944:	8082                	ret
      if(c0 == 'd'){
 946:	06400713          	li	a4,100
 94a:	e6e782e3          	beq	a5,a4,7ae <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 94e:	f9478693          	addi	a3,a5,-108
 952:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 956:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 958:	4701                	li	a4,0
 95a:	bbe9                	j	734 <vprintf+0xa6>

000000000000095c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 95c:	715d                	addi	sp,sp,-80
 95e:	ec06                	sd	ra,24(sp)
 960:	e822                	sd	s0,16(sp)
 962:	1000                	addi	s0,sp,32
 964:	e010                	sd	a2,0(s0)
 966:	e414                	sd	a3,8(s0)
 968:	e818                	sd	a4,16(s0)
 96a:	ec1c                	sd	a5,24(s0)
 96c:	03043023          	sd	a6,32(s0)
 970:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 974:	8622                	mv	a2,s0
 976:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 97a:	d15ff0ef          	jal	68e <vprintf>
}
 97e:	60e2                	ld	ra,24(sp)
 980:	6442                	ld	s0,16(sp)
 982:	6161                	addi	sp,sp,80
 984:	8082                	ret

0000000000000986 <printf>:

void
printf(const char *fmt, ...)
{
 986:	711d                	addi	sp,sp,-96
 988:	ec06                	sd	ra,24(sp)
 98a:	e822                	sd	s0,16(sp)
 98c:	1000                	addi	s0,sp,32
 98e:	e40c                	sd	a1,8(s0)
 990:	e810                	sd	a2,16(s0)
 992:	ec14                	sd	a3,24(s0)
 994:	f018                	sd	a4,32(s0)
 996:	f41c                	sd	a5,40(s0)
 998:	03043823          	sd	a6,48(s0)
 99c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9a0:	00840613          	addi	a2,s0,8
 9a4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9a8:	85aa                	mv	a1,a0
 9aa:	4505                	li	a0,1
 9ac:	ce3ff0ef          	jal	68e <vprintf>
}
 9b0:	60e2                	ld	ra,24(sp)
 9b2:	6442                	ld	s0,16(sp)
 9b4:	6125                	addi	sp,sp,96
 9b6:	8082                	ret

00000000000009b8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9b8:	1141                	addi	sp,sp,-16
 9ba:	e406                	sd	ra,8(sp)
 9bc:	e022                	sd	s0,0(sp)
 9be:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9c0:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9c4:	00000797          	auipc	a5,0x0
 9c8:	63c7b783          	ld	a5,1596(a5) # 1000 <freep>
 9cc:	a095                	j	a30 <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 9ce:	ff852583          	lw	a1,-8(a0)
 9d2:	6390                	ld	a2,0(a5)
 9d4:	02059813          	slli	a6,a1,0x20
 9d8:	01c85693          	srli	a3,a6,0x1c
 9dc:	96ba                	add	a3,a3,a4
 9de:	02d60563          	beq	a2,a3,a08 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 9e2:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 9e6:	4790                	lw	a2,8(a5)
 9e8:	02061593          	slli	a1,a2,0x20
 9ec:	01c5d693          	srli	a3,a1,0x1c
 9f0:	96be                	add	a3,a3,a5
 9f2:	02d70263          	beq	a4,a3,a16 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 9f6:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9f8:	00000717          	auipc	a4,0x0
 9fc:	60f73423          	sd	a5,1544(a4) # 1000 <freep>
}
 a00:	60a2                	ld	ra,8(sp)
 a02:	6402                	ld	s0,0(sp)
 a04:	0141                	addi	sp,sp,16
 a06:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 a08:	4614                	lw	a3,8(a2)
 a0a:	9ead                	addw	a3,a3,a1
 a0c:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a10:	6394                	ld	a3,0(a5)
 a12:	6290                	ld	a2,0(a3)
 a14:	b7f9                	j	9e2 <free+0x2a>
    p->s.size += bp->s.size;
 a16:	ff852703          	lw	a4,-8(a0)
 a1a:	9f31                	addw	a4,a4,a2
 a1c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a1e:	ff053703          	ld	a4,-16(a0)
 a22:	bfd1                	j	9f6 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a24:	6394                	ld	a3,0(a5)
 a26:	00d7e463          	bltu	a5,a3,a2e <free+0x76>
 a2a:	fad762e3          	bltu	a4,a3,9ce <free+0x16>
 a2e:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a30:	fee7fae3          	bgeu	a5,a4,a24 <free+0x6c>
 a34:	6394                	ld	a3,0(a5)
 a36:	f8d76ce3          	bltu	a4,a3,9ce <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a3a:	f8d7fae3          	bgeu	a5,a3,9ce <free+0x16>
 a3e:	87b6                	mv	a5,a3
 a40:	bfc5                	j	a30 <free+0x78>

0000000000000a42 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a42:	7139                	addi	sp,sp,-64
 a44:	fc06                	sd	ra,56(sp)
 a46:	f822                	sd	s0,48(sp)
 a48:	f04a                	sd	s2,32(sp)
 a4a:	ec4e                	sd	s3,24(sp)
 a4c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a4e:	02051993          	slli	s3,a0,0x20
 a52:	0209d993          	srli	s3,s3,0x20
 a56:	09bd                	addi	s3,s3,15
 a58:	0049d993          	srli	s3,s3,0x4
 a5c:	2985                	addiw	s3,s3,1
 a5e:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 a60:	00000517          	auipc	a0,0x0
 a64:	5a053503          	ld	a0,1440(a0) # 1000 <freep>
 a68:	c905                	beqz	a0,a98 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a6a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a6c:	4798                	lw	a4,8(a5)
 a6e:	09377663          	bgeu	a4,s3,afa <malloc+0xb8>
 a72:	f426                	sd	s1,40(sp)
 a74:	e852                	sd	s4,16(sp)
 a76:	e456                	sd	s5,8(sp)
 a78:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a7a:	8a4e                	mv	s4,s3
 a7c:	6705                	lui	a4,0x1
 a7e:	00e9f363          	bgeu	s3,a4,a84 <malloc+0x42>
 a82:	6a05                	lui	s4,0x1
 a84:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a88:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a8c:	00000497          	auipc	s1,0x0
 a90:	57448493          	addi	s1,s1,1396 # 1000 <freep>
  if(p == SBRK_ERROR)
 a94:	5afd                	li	s5,-1
 a96:	a83d                	j	ad4 <malloc+0x92>
 a98:	f426                	sd	s1,40(sp)
 a9a:	e852                	sd	s4,16(sp)
 a9c:	e456                	sd	s5,8(sp)
 a9e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 aa0:	00001797          	auipc	a5,0x1
 aa4:	97078793          	addi	a5,a5,-1680 # 1410 <base>
 aa8:	00000717          	auipc	a4,0x0
 aac:	54f73c23          	sd	a5,1368(a4) # 1000 <freep>
 ab0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ab2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ab6:	b7d1                	j	a7a <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 ab8:	6398                	ld	a4,0(a5)
 aba:	e118                	sd	a4,0(a0)
 abc:	a899                	j	b12 <malloc+0xd0>
  hp->s.size = nu;
 abe:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ac2:	0541                	addi	a0,a0,16
 ac4:	ef5ff0ef          	jal	9b8 <free>
  return freep;
 ac8:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 aca:	c125                	beqz	a0,b2a <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 acc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ace:	4798                	lw	a4,8(a5)
 ad0:	03277163          	bgeu	a4,s2,af2 <malloc+0xb0>
    if(p == freep)
 ad4:	6098                	ld	a4,0(s1)
 ad6:	853e                	mv	a0,a5
 ad8:	fef71ae3          	bne	a4,a5,acc <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 adc:	8552                	mv	a0,s4
 ade:	a17ff0ef          	jal	4f4 <sbrk>
  if(p == SBRK_ERROR)
 ae2:	fd551ee3          	bne	a0,s5,abe <malloc+0x7c>
        return 0;
 ae6:	4501                	li	a0,0
 ae8:	74a2                	ld	s1,40(sp)
 aea:	6a42                	ld	s4,16(sp)
 aec:	6aa2                	ld	s5,8(sp)
 aee:	6b02                	ld	s6,0(sp)
 af0:	a03d                	j	b1e <malloc+0xdc>
 af2:	74a2                	ld	s1,40(sp)
 af4:	6a42                	ld	s4,16(sp)
 af6:	6aa2                	ld	s5,8(sp)
 af8:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 afa:	fae90fe3          	beq	s2,a4,ab8 <malloc+0x76>
        p->s.size -= nunits;
 afe:	4137073b          	subw	a4,a4,s3
 b02:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b04:	02071693          	slli	a3,a4,0x20
 b08:	01c6d713          	srli	a4,a3,0x1c
 b0c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b0e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b12:	00000717          	auipc	a4,0x0
 b16:	4ea73723          	sd	a0,1262(a4) # 1000 <freep>
      return (void*)(p + 1);
 b1a:	01078513          	addi	a0,a5,16
  }
}
 b1e:	70e2                	ld	ra,56(sp)
 b20:	7442                	ld	s0,48(sp)
 b22:	7902                	ld	s2,32(sp)
 b24:	69e2                	ld	s3,24(sp)
 b26:	6121                	addi	sp,sp,64
 b28:	8082                	ret
 b2a:	74a2                	ld	s1,40(sp)
 b2c:	6a42                	ld	s4,16(sp)
 b2e:	6aa2                	ld	s5,8(sp)
 b30:	6b02                	ld	s6,0(sp)
 b32:	b7f5                	j	b1e <malloc+0xdc>
