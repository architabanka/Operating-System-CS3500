
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
 148:	1da000ef          	jal	322 <strchr>
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
 16e:	3d8000ef          	jal	546 <write>
 172:	b7f9                	j	140 <grep+0x34>
    if(m > 0){
 174:	03604463          	bgtz	s6,19c <grep+0x90>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 178:	416d063b          	subw	a2,s10,s6
 17c:	016b85b3          	add	a1,s7,s6
 180:	8566                	mv	a0,s9
 182:	3bc000ef          	jal	53e <read>
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
 1b8:	294000ef          	jal	44c <memmove>
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
 214:	352000ef          	jal	566 <open>
 218:	84aa                	mv	s1,a0
 21a:	04054063          	bltz	a0,25a <main+0x80>
    grep(pattern, fd);
 21e:	85aa                	mv	a1,a0
 220:	8552                	mv	a0,s4
 222:	eebff0ef          	jal	10c <grep>
    close(fd);
 226:	8526                	mv	a0,s1
 228:	326000ef          	jal	54e <close>
  for(i = 2; i < argc; i++){
 22c:	0921                	addi	s2,s2,8
 22e:	ff3910e3          	bne	s2,s3,20e <main+0x34>
  exit(0);
 232:	4501                	li	a0,0
 234:	2f2000ef          	jal	526 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 238:	00001597          	auipc	a1,0x1
 23c:	9b858593          	addi	a1,a1,-1608 # bf0 <statistics+0x7c>
 240:	4509                	li	a0,2
 242:	75a000ef          	jal	99c <fprintf>
    exit(1);
 246:	4505                	li	a0,1
 248:	2de000ef          	jal	526 <exit>
    grep(pattern, 0);
 24c:	4581                	li	a1,0
 24e:	8552                	mv	a0,s4
 250:	ebdff0ef          	jal	10c <grep>
    exit(0);
 254:	4501                	li	a0,0
 256:	2d0000ef          	jal	526 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 25a:	00093583          	ld	a1,0(s2)
 25e:	00001517          	auipc	a0,0x1
 262:	9b250513          	addi	a0,a0,-1614 # c10 <statistics+0x9c>
 266:	760000ef          	jal	9c6 <printf>
      exit(1);
 26a:	4505                	li	a0,1
 26c:	2ba000ef          	jal	526 <exit>

0000000000000270 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 270:	1141                	addi	sp,sp,-16
 272:	e406                	sd	ra,8(sp)
 274:	e022                	sd	s0,0(sp)
 276:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 278:	f63ff0ef          	jal	1da <main>
  exit(r);
 27c:	2aa000ef          	jal	526 <exit>

0000000000000280 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 280:	1141                	addi	sp,sp,-16
 282:	e406                	sd	ra,8(sp)
 284:	e022                	sd	s0,0(sp)
 286:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 288:	87aa                	mv	a5,a0
 28a:	0585                	addi	a1,a1,1
 28c:	0785                	addi	a5,a5,1
 28e:	fff5c703          	lbu	a4,-1(a1)
 292:	fee78fa3          	sb	a4,-1(a5)
 296:	fb75                	bnez	a4,28a <strcpy+0xa>
    ;
  return os;
}
 298:	60a2                	ld	ra,8(sp)
 29a:	6402                	ld	s0,0(sp)
 29c:	0141                	addi	sp,sp,16
 29e:	8082                	ret

00000000000002a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2a0:	1141                	addi	sp,sp,-16
 2a2:	e406                	sd	ra,8(sp)
 2a4:	e022                	sd	s0,0(sp)
 2a6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2a8:	00054783          	lbu	a5,0(a0)
 2ac:	cb91                	beqz	a5,2c0 <strcmp+0x20>
 2ae:	0005c703          	lbu	a4,0(a1)
 2b2:	00f71763          	bne	a4,a5,2c0 <strcmp+0x20>
    p++, q++;
 2b6:	0505                	addi	a0,a0,1
 2b8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2ba:	00054783          	lbu	a5,0(a0)
 2be:	fbe5                	bnez	a5,2ae <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 2c0:	0005c503          	lbu	a0,0(a1)
}
 2c4:	40a7853b          	subw	a0,a5,a0
 2c8:	60a2                	ld	ra,8(sp)
 2ca:	6402                	ld	s0,0(sp)
 2cc:	0141                	addi	sp,sp,16
 2ce:	8082                	ret

00000000000002d0 <strlen>:

uint
strlen(const char *s)
{
 2d0:	1141                	addi	sp,sp,-16
 2d2:	e406                	sd	ra,8(sp)
 2d4:	e022                	sd	s0,0(sp)
 2d6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2d8:	00054783          	lbu	a5,0(a0)
 2dc:	cf91                	beqz	a5,2f8 <strlen+0x28>
 2de:	00150793          	addi	a5,a0,1
 2e2:	86be                	mv	a3,a5
 2e4:	0785                	addi	a5,a5,1
 2e6:	fff7c703          	lbu	a4,-1(a5)
 2ea:	ff65                	bnez	a4,2e2 <strlen+0x12>
 2ec:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 2f0:	60a2                	ld	ra,8(sp)
 2f2:	6402                	ld	s0,0(sp)
 2f4:	0141                	addi	sp,sp,16
 2f6:	8082                	ret
  for(n = 0; s[n]; n++)
 2f8:	4501                	li	a0,0
 2fa:	bfdd                	j	2f0 <strlen+0x20>

00000000000002fc <memset>:

void*
memset(void *dst, int c, uint n)
{
 2fc:	1141                	addi	sp,sp,-16
 2fe:	e406                	sd	ra,8(sp)
 300:	e022                	sd	s0,0(sp)
 302:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 304:	ca19                	beqz	a2,31a <memset+0x1e>
 306:	87aa                	mv	a5,a0
 308:	1602                	slli	a2,a2,0x20
 30a:	9201                	srli	a2,a2,0x20
 30c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 310:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 314:	0785                	addi	a5,a5,1
 316:	fee79de3          	bne	a5,a4,310 <memset+0x14>
  }
  return dst;
}
 31a:	60a2                	ld	ra,8(sp)
 31c:	6402                	ld	s0,0(sp)
 31e:	0141                	addi	sp,sp,16
 320:	8082                	ret

0000000000000322 <strchr>:

char*
strchr(const char *s, char c)
{
 322:	1141                	addi	sp,sp,-16
 324:	e406                	sd	ra,8(sp)
 326:	e022                	sd	s0,0(sp)
 328:	0800                	addi	s0,sp,16
  for(; *s; s++)
 32a:	00054783          	lbu	a5,0(a0)
 32e:	c799                	beqz	a5,33c <strchr+0x1a>
    if(*s == c)
 330:	00f58763          	beq	a1,a5,33e <strchr+0x1c>
  for(; *s; s++)
 334:	0505                	addi	a0,a0,1
 336:	00054783          	lbu	a5,0(a0)
 33a:	fbfd                	bnez	a5,330 <strchr+0xe>
      return (char*)s;
  return 0;
 33c:	4501                	li	a0,0
}
 33e:	60a2                	ld	ra,8(sp)
 340:	6402                	ld	s0,0(sp)
 342:	0141                	addi	sp,sp,16
 344:	8082                	ret

0000000000000346 <gets>:

char*
gets(char *buf, int max)
{
 346:	711d                	addi	sp,sp,-96
 348:	ec86                	sd	ra,88(sp)
 34a:	e8a2                	sd	s0,80(sp)
 34c:	e4a6                	sd	s1,72(sp)
 34e:	e0ca                	sd	s2,64(sp)
 350:	fc4e                	sd	s3,56(sp)
 352:	f852                	sd	s4,48(sp)
 354:	f456                	sd	s5,40(sp)
 356:	f05a                	sd	s6,32(sp)
 358:	ec5e                	sd	s7,24(sp)
 35a:	e862                	sd	s8,16(sp)
 35c:	1080                	addi	s0,sp,96
 35e:	8baa                	mv	s7,a0
 360:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 362:	892a                	mv	s2,a0
 364:	4481                	li	s1,0
    cc = read(0, &c, 1);
 366:	faf40b13          	addi	s6,s0,-81
 36a:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 36c:	8c26                	mv	s8,s1
 36e:	0014899b          	addiw	s3,s1,1
 372:	84ce                	mv	s1,s3
 374:	0349d863          	bge	s3,s4,3a4 <gets+0x5e>
    cc = read(0, &c, 1);
 378:	8656                	mv	a2,s5
 37a:	85da                	mv	a1,s6
 37c:	4501                	li	a0,0
 37e:	1c0000ef          	jal	53e <read>
    if(cc < 1)
 382:	02a05163          	blez	a0,3a4 <gets+0x5e>
      break;
    buf[i++] = c;
 386:	faf44783          	lbu	a5,-81(s0)
 38a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 38e:	0905                	addi	s2,s2,1
 390:	ff678713          	addi	a4,a5,-10
 394:	00173713          	seqz	a4,a4
 398:	17cd                	addi	a5,a5,-13
 39a:	0017b793          	seqz	a5,a5
 39e:	8fd9                	or	a5,a5,a4
 3a0:	d7f1                	beqz	a5,36c <gets+0x26>
    buf[i++] = c;
 3a2:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 3a4:	9c5e                	add	s8,s8,s7
 3a6:	000c0023          	sb	zero,0(s8)
  return buf;
}
 3aa:	855e                	mv	a0,s7
 3ac:	60e6                	ld	ra,88(sp)
 3ae:	6446                	ld	s0,80(sp)
 3b0:	64a6                	ld	s1,72(sp)
 3b2:	6906                	ld	s2,64(sp)
 3b4:	79e2                	ld	s3,56(sp)
 3b6:	7a42                	ld	s4,48(sp)
 3b8:	7aa2                	ld	s5,40(sp)
 3ba:	7b02                	ld	s6,32(sp)
 3bc:	6be2                	ld	s7,24(sp)
 3be:	6c42                	ld	s8,16(sp)
 3c0:	6125                	addi	sp,sp,96
 3c2:	8082                	ret

00000000000003c4 <stat>:

int
stat(const char *n, struct stat *st)
{
 3c4:	1101                	addi	sp,sp,-32
 3c6:	ec06                	sd	ra,24(sp)
 3c8:	e822                	sd	s0,16(sp)
 3ca:	e04a                	sd	s2,0(sp)
 3cc:	1000                	addi	s0,sp,32
 3ce:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3d0:	4581                	li	a1,0
 3d2:	194000ef          	jal	566 <open>
  if(fd < 0)
 3d6:	02054263          	bltz	a0,3fa <stat+0x36>
 3da:	e426                	sd	s1,8(sp)
 3dc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3de:	85ca                	mv	a1,s2
 3e0:	19e000ef          	jal	57e <fstat>
 3e4:	892a                	mv	s2,a0
  close(fd);
 3e6:	8526                	mv	a0,s1
 3e8:	166000ef          	jal	54e <close>
  return r;
 3ec:	64a2                	ld	s1,8(sp)
}
 3ee:	854a                	mv	a0,s2
 3f0:	60e2                	ld	ra,24(sp)
 3f2:	6442                	ld	s0,16(sp)
 3f4:	6902                	ld	s2,0(sp)
 3f6:	6105                	addi	sp,sp,32
 3f8:	8082                	ret
    return -1;
 3fa:	57fd                	li	a5,-1
 3fc:	893e                	mv	s2,a5
 3fe:	bfc5                	j	3ee <stat+0x2a>

0000000000000400 <atoi>:

int
atoi(const char *s)
{
 400:	1141                	addi	sp,sp,-16
 402:	e406                	sd	ra,8(sp)
 404:	e022                	sd	s0,0(sp)
 406:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 408:	00054683          	lbu	a3,0(a0)
 40c:	fd06879b          	addiw	a5,a3,-48
 410:	0ff7f793          	zext.b	a5,a5
 414:	4625                	li	a2,9
 416:	02f66963          	bltu	a2,a5,448 <atoi+0x48>
 41a:	872a                	mv	a4,a0
  n = 0;
 41c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 41e:	0705                	addi	a4,a4,1
 420:	0025179b          	slliw	a5,a0,0x2
 424:	9fa9                	addw	a5,a5,a0
 426:	0017979b          	slliw	a5,a5,0x1
 42a:	9fb5                	addw	a5,a5,a3
 42c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 430:	00074683          	lbu	a3,0(a4)
 434:	fd06879b          	addiw	a5,a3,-48
 438:	0ff7f793          	zext.b	a5,a5
 43c:	fef671e3          	bgeu	a2,a5,41e <atoi+0x1e>
  return n;
}
 440:	60a2                	ld	ra,8(sp)
 442:	6402                	ld	s0,0(sp)
 444:	0141                	addi	sp,sp,16
 446:	8082                	ret
  n = 0;
 448:	4501                	li	a0,0
 44a:	bfdd                	j	440 <atoi+0x40>

000000000000044c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 44c:	1141                	addi	sp,sp,-16
 44e:	e406                	sd	ra,8(sp)
 450:	e022                	sd	s0,0(sp)
 452:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 454:	02b57563          	bgeu	a0,a1,47e <memmove+0x32>
    while(n-- > 0)
 458:	00c05f63          	blez	a2,476 <memmove+0x2a>
 45c:	1602                	slli	a2,a2,0x20
 45e:	9201                	srli	a2,a2,0x20
 460:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 464:	872a                	mv	a4,a0
      *dst++ = *src++;
 466:	0585                	addi	a1,a1,1
 468:	0705                	addi	a4,a4,1
 46a:	fff5c683          	lbu	a3,-1(a1)
 46e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 472:	fee79ae3          	bne	a5,a4,466 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 476:	60a2                	ld	ra,8(sp)
 478:	6402                	ld	s0,0(sp)
 47a:	0141                	addi	sp,sp,16
 47c:	8082                	ret
    while(n-- > 0)
 47e:	fec05ce3          	blez	a2,476 <memmove+0x2a>
    dst += n;
 482:	00c50733          	add	a4,a0,a2
    src += n;
 486:	95b2                	add	a1,a1,a2
 488:	fff6079b          	addiw	a5,a2,-1
 48c:	1782                	slli	a5,a5,0x20
 48e:	9381                	srli	a5,a5,0x20
 490:	fff7c793          	not	a5,a5
 494:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 496:	15fd                	addi	a1,a1,-1
 498:	177d                	addi	a4,a4,-1
 49a:	0005c683          	lbu	a3,0(a1)
 49e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4a2:	fef71ae3          	bne	a4,a5,496 <memmove+0x4a>
 4a6:	bfc1                	j	476 <memmove+0x2a>

00000000000004a8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4a8:	1141                	addi	sp,sp,-16
 4aa:	e406                	sd	ra,8(sp)
 4ac:	e022                	sd	s0,0(sp)
 4ae:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4b0:	ce19                	beqz	a2,4ce <memcmp+0x26>
 4b2:	1602                	slli	a2,a2,0x20
 4b4:	9201                	srli	a2,a2,0x20
 4b6:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 4ba:	00054783          	lbu	a5,0(a0)
 4be:	0005c703          	lbu	a4,0(a1)
 4c2:	00e79b63          	bne	a5,a4,4d8 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 4c6:	0505                	addi	a0,a0,1
    p2++;
 4c8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4ca:	fed518e3          	bne	a0,a3,4ba <memcmp+0x12>
  }
  return 0;
 4ce:	4501                	li	a0,0
}
 4d0:	60a2                	ld	ra,8(sp)
 4d2:	6402                	ld	s0,0(sp)
 4d4:	0141                	addi	sp,sp,16
 4d6:	8082                	ret
      return *p1 - *p2;
 4d8:	40e7853b          	subw	a0,a5,a4
 4dc:	bfd5                	j	4d0 <memcmp+0x28>

00000000000004de <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4de:	1141                	addi	sp,sp,-16
 4e0:	e406                	sd	ra,8(sp)
 4e2:	e022                	sd	s0,0(sp)
 4e4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4e6:	f67ff0ef          	jal	44c <memmove>
}
 4ea:	60a2                	ld	ra,8(sp)
 4ec:	6402                	ld	s0,0(sp)
 4ee:	0141                	addi	sp,sp,16
 4f0:	8082                	ret

00000000000004f2 <sbrk>:

char *
sbrk(int n) {
 4f2:	1141                	addi	sp,sp,-16
 4f4:	e406                	sd	ra,8(sp)
 4f6:	e022                	sd	s0,0(sp)
 4f8:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 4fa:	4585                	li	a1,1
 4fc:	0b2000ef          	jal	5ae <sys_sbrk>
}
 500:	60a2                	ld	ra,8(sp)
 502:	6402                	ld	s0,0(sp)
 504:	0141                	addi	sp,sp,16
 506:	8082                	ret

0000000000000508 <sbrklazy>:

char *
sbrklazy(int n) {
 508:	1141                	addi	sp,sp,-16
 50a:	e406                	sd	ra,8(sp)
 50c:	e022                	sd	s0,0(sp)
 50e:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 510:	4589                	li	a1,2
 512:	09c000ef          	jal	5ae <sys_sbrk>
}
 516:	60a2                	ld	ra,8(sp)
 518:	6402                	ld	s0,0(sp)
 51a:	0141                	addi	sp,sp,16
 51c:	8082                	ret

000000000000051e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 51e:	4885                	li	a7,1
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <exit>:
.global exit
exit:
 li a7, SYS_exit
 526:	4889                	li	a7,2
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <wait>:
.global wait
wait:
 li a7, SYS_wait
 52e:	488d                	li	a7,3
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 536:	4891                	li	a7,4
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <read>:
.global read
read:
 li a7, SYS_read
 53e:	4895                	li	a7,5
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <write>:
.global write
write:
 li a7, SYS_write
 546:	48c1                	li	a7,16
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <close>:
.global close
close:
 li a7, SYS_close
 54e:	48d5                	li	a7,21
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <kill>:
.global kill
kill:
 li a7, SYS_kill
 556:	4899                	li	a7,6
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <exec>:
.global exec
exec:
 li a7, SYS_exec
 55e:	489d                	li	a7,7
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <open>:
.global open
open:
 li a7, SYS_open
 566:	48bd                	li	a7,15
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 56e:	48c5                	li	a7,17
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 576:	48c9                	li	a7,18
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 57e:	48a1                	li	a7,8
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <link>:
.global link
link:
 li a7, SYS_link
 586:	48cd                	li	a7,19
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 58e:	48d1                	li	a7,20
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 596:	48a5                	li	a7,9
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <dup>:
.global dup
dup:
 li a7, SYS_dup
 59e:	48a9                	li	a7,10
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5a6:	48ad                	li	a7,11
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 5ae:	48b1                	li	a7,12
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <pause>:
.global pause
pause:
 li a7, SYS_pause
 5b6:	48b5                	li	a7,13
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5be:	48b9                	li	a7,14
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <bind>:
.global bind
bind:
 li a7, SYS_bind
 5c6:	48f5                	li	a7,29
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 5ce:	48f9                	li	a7,30
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <send>:
.global send
send:
 li a7, SYS_send
 5d6:	48fd                	li	a7,31
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <recv>:
.global recv
recv:
 li a7, SYS_recv
 5de:	02000893          	li	a7,32
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 5e8:	02100893          	li	a7,33
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 5f2:	02200893          	li	a7,34
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <rwlktest>:
.global rwlktest
rwlktest:
 li a7, SYS_rwlktest
 5fc:	02300893          	li	a7,35
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <cpupin>:
.global cpupin
cpupin:
 li a7, SYS_cpupin
 606:	02400893          	li	a7,36
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 610:	1101                	addi	sp,sp,-32
 612:	ec06                	sd	ra,24(sp)
 614:	e822                	sd	s0,16(sp)
 616:	1000                	addi	s0,sp,32
 618:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 61c:	4605                	li	a2,1
 61e:	fef40593          	addi	a1,s0,-17
 622:	f25ff0ef          	jal	546 <write>
}
 626:	60e2                	ld	ra,24(sp)
 628:	6442                	ld	s0,16(sp)
 62a:	6105                	addi	sp,sp,32
 62c:	8082                	ret

000000000000062e <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 62e:	715d                	addi	sp,sp,-80
 630:	e486                	sd	ra,72(sp)
 632:	e0a2                	sd	s0,64(sp)
 634:	f84a                	sd	s2,48(sp)
 636:	f44e                	sd	s3,40(sp)
 638:	0880                	addi	s0,sp,80
 63a:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 63c:	00d036b3          	snez	a3,a3
 640:	03f5d793          	srli	a5,a1,0x3f
 644:	8efd                	and	a3,a3,a5
  neg = 0;
 646:	4301                	li	t1,0
  if(sgn && xx < 0){
 648:	c681                	beqz	a3,650 <printint+0x22>
    neg = 1;
    x = -xx;
 64a:	40b005b3          	neg	a1,a1
    neg = 1;
 64e:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 650:	fb840993          	addi	s3,s0,-72
  neg = 0;
 654:	86ce                	mv	a3,s3
  i = 0;
 656:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 658:	00000817          	auipc	a6,0x0
 65c:	60080813          	addi	a6,a6,1536 # c58 <digits>
 660:	88ba                	mv	a7,a4
 662:	0017051b          	addiw	a0,a4,1
 666:	872a                	mv	a4,a0
 668:	02c5f7b3          	remu	a5,a1,a2
 66c:	97c2                	add	a5,a5,a6
 66e:	0007c783          	lbu	a5,0(a5)
 672:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 676:	87ae                	mv	a5,a1
 678:	02c5d5b3          	divu	a1,a1,a2
 67c:	0685                	addi	a3,a3,1
 67e:	fec7f1e3          	bgeu	a5,a2,660 <printint+0x32>
  if(neg)
 682:	00030b63          	beqz	t1,698 <printint+0x6a>
    buf[i++] = '-';
 686:	fd040793          	addi	a5,s0,-48
 68a:	953e                	add	a0,a0,a5
 68c:	02d00793          	li	a5,45
 690:	fef50423          	sb	a5,-24(a0)
 694:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 698:	02e05563          	blez	a4,6c2 <printint+0x94>
 69c:	fc26                	sd	s1,56(sp)
 69e:	377d                	addiw	a4,a4,-1
 6a0:	00e984b3          	add	s1,s3,a4
 6a4:	19fd                	addi	s3,s3,-1
 6a6:	99ba                	add	s3,s3,a4
 6a8:	1702                	slli	a4,a4,0x20
 6aa:	9301                	srli	a4,a4,0x20
 6ac:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6b0:	0004c583          	lbu	a1,0(s1)
 6b4:	854a                	mv	a0,s2
 6b6:	f5bff0ef          	jal	610 <putc>
  while(--i >= 0)
 6ba:	14fd                	addi	s1,s1,-1
 6bc:	ff349ae3          	bne	s1,s3,6b0 <printint+0x82>
 6c0:	74e2                	ld	s1,56(sp)
}
 6c2:	60a6                	ld	ra,72(sp)
 6c4:	6406                	ld	s0,64(sp)
 6c6:	7942                	ld	s2,48(sp)
 6c8:	79a2                	ld	s3,40(sp)
 6ca:	6161                	addi	sp,sp,80
 6cc:	8082                	ret

00000000000006ce <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6ce:	711d                	addi	sp,sp,-96
 6d0:	ec86                	sd	ra,88(sp)
 6d2:	e8a2                	sd	s0,80(sp)
 6d4:	e4a6                	sd	s1,72(sp)
 6d6:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6d8:	0005c483          	lbu	s1,0(a1)
 6dc:	2a048063          	beqz	s1,97c <vprintf+0x2ae>
 6e0:	e0ca                	sd	s2,64(sp)
 6e2:	fc4e                	sd	s3,56(sp)
 6e4:	f852                	sd	s4,48(sp)
 6e6:	f456                	sd	s5,40(sp)
 6e8:	f05a                	sd	s6,32(sp)
 6ea:	ec5e                	sd	s7,24(sp)
 6ec:	e862                	sd	s8,16(sp)
 6ee:	8b2a                	mv	s6,a0
 6f0:	8a2e                	mv	s4,a1
 6f2:	8bb2                	mv	s7,a2
  state = 0;
 6f4:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 6f6:	4901                	li	s2,0
 6f8:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 6fa:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 6fe:	06400c13          	li	s8,100
 702:	a00d                	j	724 <vprintf+0x56>
        putc(fd, c0);
 704:	85a6                	mv	a1,s1
 706:	855a                	mv	a0,s6
 708:	f09ff0ef          	jal	610 <putc>
 70c:	a019                	j	712 <vprintf+0x44>
    } else if(state == '%'){
 70e:	03598363          	beq	s3,s5,734 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 712:	0019079b          	addiw	a5,s2,1
 716:	893e                	mv	s2,a5
 718:	873e                	mv	a4,a5
 71a:	97d2                	add	a5,a5,s4
 71c:	0007c483          	lbu	s1,0(a5)
 720:	24048763          	beqz	s1,96e <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 724:	0004879b          	sext.w	a5,s1
    if(state == 0){
 728:	fe0993e3          	bnez	s3,70e <vprintf+0x40>
      if(c0 == '%'){
 72c:	fd579ce3          	bne	a5,s5,704 <vprintf+0x36>
        state = '%';
 730:	89be                	mv	s3,a5
 732:	b7c5                	j	712 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 734:	00ea06b3          	add	a3,s4,a4
 738:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 73c:	24060563          	beqz	a2,986 <vprintf+0x2b8>
      if(c0 == 'd'){
 740:	0b878763          	beq	a5,s8,7ee <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 744:	f9478693          	addi	a3,a5,-108
 748:	0016b693          	seqz	a3,a3
 74c:	f9c60593          	addi	a1,a2,-100
 750:	0015b593          	seqz	a1,a1
 754:	8df5                	and	a1,a1,a3
 756:	e9c5                	bnez	a1,806 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 758:	9752                	add	a4,a4,s4
 75a:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 75e:	f9460713          	addi	a4,a2,-108
 762:	00173713          	seqz	a4,a4
 766:	8f75                	and	a4,a4,a3
 768:	f9c50593          	addi	a1,a0,-100
 76c:	0015b593          	seqz	a1,a1
 770:	8df9                	and	a1,a1,a4
 772:	e5dd                	bnez	a1,820 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 774:	07500593          	li	a1,117
 778:	0cb78163          	beq	a5,a1,83a <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 77c:	f8b60593          	addi	a1,a2,-117
 780:	0015b593          	seqz	a1,a1
 784:	8df5                	and	a1,a1,a3
 786:	e5f1                	bnez	a1,852 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 788:	f8b50593          	addi	a1,a0,-117
 78c:	0015b593          	seqz	a1,a1
 790:	8df9                	and	a1,a1,a4
 792:	ede9                	bnez	a1,86c <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 794:	07800593          	li	a1,120
 798:	0eb78763          	beq	a5,a1,886 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 79c:	f8860613          	addi	a2,a2,-120
 7a0:	00163613          	seqz	a2,a2
 7a4:	8ef1                	and	a3,a3,a2
 7a6:	0e069c63          	bnez	a3,89e <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 7aa:	f8850513          	addi	a0,a0,-120
 7ae:	00153513          	seqz	a0,a0
 7b2:	8f69                	and	a4,a4,a0
 7b4:	10071263          	bnez	a4,8b8 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 7b8:	07000713          	li	a4,112
 7bc:	10e78a63          	beq	a5,a4,8d0 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 7c0:	06300713          	li	a4,99
 7c4:	14e78a63          	beq	a5,a4,918 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 7c8:	07300713          	li	a4,115
 7cc:	16e78063          	beq	a5,a4,92c <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 7d0:	02500713          	li	a4,37
 7d4:	18e78863          	beq	a5,a4,964 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7d8:	02500593          	li	a1,37
 7dc:	855a                	mv	a0,s6
 7de:	e33ff0ef          	jal	610 <putc>
        putc(fd, c0);
 7e2:	85a6                	mv	a1,s1
 7e4:	855a                	mv	a0,s6
 7e6:	e2bff0ef          	jal	610 <putc>
      }

      state = 0;
 7ea:	4981                	li	s3,0
 7ec:	b71d                	j	712 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 7ee:	008b8493          	addi	s1,s7,8
 7f2:	4685                	li	a3,1
 7f4:	4629                	li	a2,10
 7f6:	000ba583          	lw	a1,0(s7)
 7fa:	855a                	mv	a0,s6
 7fc:	e33ff0ef          	jal	62e <printint>
 800:	8ba6                	mv	s7,s1
      state = 0;
 802:	4981                	li	s3,0
 804:	b739                	j	712 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 806:	008b8493          	addi	s1,s7,8
 80a:	4685                	li	a3,1
 80c:	4629                	li	a2,10
 80e:	000bb583          	ld	a1,0(s7)
 812:	855a                	mv	a0,s6
 814:	e1bff0ef          	jal	62e <printint>
        i += 1;
 818:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 81a:	8ba6                	mv	s7,s1
      state = 0;
 81c:	4981                	li	s3,0
 81e:	bdd5                	j	712 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 820:	008b8493          	addi	s1,s7,8
 824:	4685                	li	a3,1
 826:	4629                	li	a2,10
 828:	000bb583          	ld	a1,0(s7)
 82c:	855a                	mv	a0,s6
 82e:	e01ff0ef          	jal	62e <printint>
        i += 2;
 832:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 834:	8ba6                	mv	s7,s1
      state = 0;
 836:	4981                	li	s3,0
        i += 2;
 838:	bde9                	j	712 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 83a:	008b8493          	addi	s1,s7,8
 83e:	4681                	li	a3,0
 840:	4629                	li	a2,10
 842:	000be583          	lwu	a1,0(s7)
 846:	855a                	mv	a0,s6
 848:	de7ff0ef          	jal	62e <printint>
 84c:	8ba6                	mv	s7,s1
      state = 0;
 84e:	4981                	li	s3,0
 850:	b5c9                	j	712 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 852:	008b8493          	addi	s1,s7,8
 856:	4681                	li	a3,0
 858:	4629                	li	a2,10
 85a:	000bb583          	ld	a1,0(s7)
 85e:	855a                	mv	a0,s6
 860:	dcfff0ef          	jal	62e <printint>
        i += 1;
 864:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 866:	8ba6                	mv	s7,s1
      state = 0;
 868:	4981                	li	s3,0
 86a:	b565                	j	712 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 86c:	008b8493          	addi	s1,s7,8
 870:	4681                	li	a3,0
 872:	4629                	li	a2,10
 874:	000bb583          	ld	a1,0(s7)
 878:	855a                	mv	a0,s6
 87a:	db5ff0ef          	jal	62e <printint>
        i += 2;
 87e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 880:	8ba6                	mv	s7,s1
      state = 0;
 882:	4981                	li	s3,0
        i += 2;
 884:	b579                	j	712 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 886:	008b8493          	addi	s1,s7,8
 88a:	4681                	li	a3,0
 88c:	4641                	li	a2,16
 88e:	000be583          	lwu	a1,0(s7)
 892:	855a                	mv	a0,s6
 894:	d9bff0ef          	jal	62e <printint>
 898:	8ba6                	mv	s7,s1
      state = 0;
 89a:	4981                	li	s3,0
 89c:	bd9d                	j	712 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 89e:	008b8493          	addi	s1,s7,8
 8a2:	4681                	li	a3,0
 8a4:	4641                	li	a2,16
 8a6:	000bb583          	ld	a1,0(s7)
 8aa:	855a                	mv	a0,s6
 8ac:	d83ff0ef          	jal	62e <printint>
        i += 1;
 8b0:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 8b2:	8ba6                	mv	s7,s1
      state = 0;
 8b4:	4981                	li	s3,0
 8b6:	bdb1                	j	712 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8b8:	008b8493          	addi	s1,s7,8
 8bc:	4641                	li	a2,16
 8be:	000bb583          	ld	a1,0(s7)
 8c2:	855a                	mv	a0,s6
 8c4:	d6bff0ef          	jal	62e <printint>
        i += 2;
 8c8:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 8ca:	8ba6                	mv	s7,s1
      state = 0;
 8cc:	4981                	li	s3,0
        i += 2;
 8ce:	b591                	j	712 <vprintf+0x44>
 8d0:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 8d2:	008b8793          	addi	a5,s7,8
 8d6:	8cbe                	mv	s9,a5
 8d8:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8dc:	03000593          	li	a1,48
 8e0:	855a                	mv	a0,s6
 8e2:	d2fff0ef          	jal	610 <putc>
  putc(fd, 'x');
 8e6:	07800593          	li	a1,120
 8ea:	855a                	mv	a0,s6
 8ec:	d25ff0ef          	jal	610 <putc>
 8f0:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8f2:	00000b97          	auipc	s7,0x0
 8f6:	366b8b93          	addi	s7,s7,870 # c58 <digits>
 8fa:	03c9d793          	srli	a5,s3,0x3c
 8fe:	97de                	add	a5,a5,s7
 900:	0007c583          	lbu	a1,0(a5)
 904:	855a                	mv	a0,s6
 906:	d0bff0ef          	jal	610 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 90a:	0992                	slli	s3,s3,0x4
 90c:	34fd                	addiw	s1,s1,-1
 90e:	f4f5                	bnez	s1,8fa <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 910:	8be6                	mv	s7,s9
      state = 0;
 912:	4981                	li	s3,0
 914:	6ca2                	ld	s9,8(sp)
 916:	bbf5                	j	712 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 918:	008b8493          	addi	s1,s7,8
 91c:	000bc583          	lbu	a1,0(s7)
 920:	855a                	mv	a0,s6
 922:	cefff0ef          	jal	610 <putc>
 926:	8ba6                	mv	s7,s1
      state = 0;
 928:	4981                	li	s3,0
 92a:	b3e5                	j	712 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 92c:	008b8993          	addi	s3,s7,8
 930:	000bb483          	ld	s1,0(s7)
 934:	cc91                	beqz	s1,950 <vprintf+0x282>
        for(; *s; s++)
 936:	0004c583          	lbu	a1,0(s1)
 93a:	c195                	beqz	a1,95e <vprintf+0x290>
          putc(fd, *s);
 93c:	855a                	mv	a0,s6
 93e:	cd3ff0ef          	jal	610 <putc>
        for(; *s; s++)
 942:	0485                	addi	s1,s1,1
 944:	0004c583          	lbu	a1,0(s1)
 948:	f9f5                	bnez	a1,93c <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 94a:	8bce                	mv	s7,s3
      state = 0;
 94c:	4981                	li	s3,0
 94e:	b3d1                	j	712 <vprintf+0x44>
          s = "(null)";
 950:	00000497          	auipc	s1,0x0
 954:	2d848493          	addi	s1,s1,728 # c28 <statistics+0xb4>
        for(; *s; s++)
 958:	02800593          	li	a1,40
 95c:	b7c5                	j	93c <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 95e:	8bce                	mv	s7,s3
      state = 0;
 960:	4981                	li	s3,0
 962:	bb45                	j	712 <vprintf+0x44>
        putc(fd, '%');
 964:	85be                	mv	a1,a5
 966:	855a                	mv	a0,s6
 968:	ca9ff0ef          	jal	610 <putc>
 96c:	bdbd                	j	7ea <vprintf+0x11c>
 96e:	6906                	ld	s2,64(sp)
 970:	79e2                	ld	s3,56(sp)
 972:	7a42                	ld	s4,48(sp)
 974:	7aa2                	ld	s5,40(sp)
 976:	7b02                	ld	s6,32(sp)
 978:	6be2                	ld	s7,24(sp)
 97a:	6c42                	ld	s8,16(sp)
    }
  }
}
 97c:	60e6                	ld	ra,88(sp)
 97e:	6446                	ld	s0,80(sp)
 980:	64a6                	ld	s1,72(sp)
 982:	6125                	addi	sp,sp,96
 984:	8082                	ret
      if(c0 == 'd'){
 986:	06400713          	li	a4,100
 98a:	e6e782e3          	beq	a5,a4,7ee <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 98e:	f9478693          	addi	a3,a5,-108
 992:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 996:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 998:	4701                	li	a4,0
 99a:	bbe9                	j	774 <vprintf+0xa6>

000000000000099c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 99c:	715d                	addi	sp,sp,-80
 99e:	ec06                	sd	ra,24(sp)
 9a0:	e822                	sd	s0,16(sp)
 9a2:	1000                	addi	s0,sp,32
 9a4:	e010                	sd	a2,0(s0)
 9a6:	e414                	sd	a3,8(s0)
 9a8:	e818                	sd	a4,16(s0)
 9aa:	ec1c                	sd	a5,24(s0)
 9ac:	03043023          	sd	a6,32(s0)
 9b0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9b4:	8622                	mv	a2,s0
 9b6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9ba:	d15ff0ef          	jal	6ce <vprintf>
}
 9be:	60e2                	ld	ra,24(sp)
 9c0:	6442                	ld	s0,16(sp)
 9c2:	6161                	addi	sp,sp,80
 9c4:	8082                	ret

00000000000009c6 <printf>:

void
printf(const char *fmt, ...)
{
 9c6:	711d                	addi	sp,sp,-96
 9c8:	ec06                	sd	ra,24(sp)
 9ca:	e822                	sd	s0,16(sp)
 9cc:	1000                	addi	s0,sp,32
 9ce:	e40c                	sd	a1,8(s0)
 9d0:	e810                	sd	a2,16(s0)
 9d2:	ec14                	sd	a3,24(s0)
 9d4:	f018                	sd	a4,32(s0)
 9d6:	f41c                	sd	a5,40(s0)
 9d8:	03043823          	sd	a6,48(s0)
 9dc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9e0:	00840613          	addi	a2,s0,8
 9e4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9e8:	85aa                	mv	a1,a0
 9ea:	4505                	li	a0,1
 9ec:	ce3ff0ef          	jal	6ce <vprintf>
}
 9f0:	60e2                	ld	ra,24(sp)
 9f2:	6442                	ld	s0,16(sp)
 9f4:	6125                	addi	sp,sp,96
 9f6:	8082                	ret

00000000000009f8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9f8:	1141                	addi	sp,sp,-16
 9fa:	e406                	sd	ra,8(sp)
 9fc:	e022                	sd	s0,0(sp)
 9fe:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a00:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a04:	00000797          	auipc	a5,0x0
 a08:	5fc7b783          	ld	a5,1532(a5) # 1000 <freep>
 a0c:	a095                	j	a70 <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 a0e:	ff852583          	lw	a1,-8(a0)
 a12:	6390                	ld	a2,0(a5)
 a14:	02059813          	slli	a6,a1,0x20
 a18:	01c85693          	srli	a3,a6,0x1c
 a1c:	96ba                	add	a3,a3,a4
 a1e:	02d60563          	beq	a2,a3,a48 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 a22:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a26:	4790                	lw	a2,8(a5)
 a28:	02061593          	slli	a1,a2,0x20
 a2c:	01c5d693          	srli	a3,a1,0x1c
 a30:	96be                	add	a3,a3,a5
 a32:	02d70263          	beq	a4,a3,a56 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 a36:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a38:	00000717          	auipc	a4,0x0
 a3c:	5cf73423          	sd	a5,1480(a4) # 1000 <freep>
}
 a40:	60a2                	ld	ra,8(sp)
 a42:	6402                	ld	s0,0(sp)
 a44:	0141                	addi	sp,sp,16
 a46:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 a48:	4614                	lw	a3,8(a2)
 a4a:	9ead                	addw	a3,a3,a1
 a4c:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a50:	6394                	ld	a3,0(a5)
 a52:	6290                	ld	a2,0(a3)
 a54:	b7f9                	j	a22 <free+0x2a>
    p->s.size += bp->s.size;
 a56:	ff852703          	lw	a4,-8(a0)
 a5a:	9f31                	addw	a4,a4,a2
 a5c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a5e:	ff053703          	ld	a4,-16(a0)
 a62:	bfd1                	j	a36 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a64:	6394                	ld	a3,0(a5)
 a66:	00d7e463          	bltu	a5,a3,a6e <free+0x76>
 a6a:	fad762e3          	bltu	a4,a3,a0e <free+0x16>
 a6e:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a70:	fee7fae3          	bgeu	a5,a4,a64 <free+0x6c>
 a74:	6394                	ld	a3,0(a5)
 a76:	f8d76ce3          	bltu	a4,a3,a0e <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a7a:	f8d7fae3          	bgeu	a5,a3,a0e <free+0x16>
 a7e:	87b6                	mv	a5,a3
 a80:	bfc5                	j	a70 <free+0x78>

0000000000000a82 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a82:	7139                	addi	sp,sp,-64
 a84:	fc06                	sd	ra,56(sp)
 a86:	f822                	sd	s0,48(sp)
 a88:	f04a                	sd	s2,32(sp)
 a8a:	ec4e                	sd	s3,24(sp)
 a8c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a8e:	02051993          	slli	s3,a0,0x20
 a92:	0209d993          	srli	s3,s3,0x20
 a96:	09bd                	addi	s3,s3,15
 a98:	0049d993          	srli	s3,s3,0x4
 a9c:	2985                	addiw	s3,s3,1
 a9e:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 aa0:	00000517          	auipc	a0,0x0
 aa4:	56053503          	ld	a0,1376(a0) # 1000 <freep>
 aa8:	c905                	beqz	a0,ad8 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aaa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 aac:	4798                	lw	a4,8(a5)
 aae:	09377663          	bgeu	a4,s3,b3a <malloc+0xb8>
 ab2:	f426                	sd	s1,40(sp)
 ab4:	e852                	sd	s4,16(sp)
 ab6:	e456                	sd	s5,8(sp)
 ab8:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 aba:	8a4e                	mv	s4,s3
 abc:	6705                	lui	a4,0x1
 abe:	00e9f363          	bgeu	s3,a4,ac4 <malloc+0x42>
 ac2:	6a05                	lui	s4,0x1
 ac4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 ac8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 acc:	00000497          	auipc	s1,0x0
 ad0:	53448493          	addi	s1,s1,1332 # 1000 <freep>
  if(p == SBRK_ERROR)
 ad4:	5afd                	li	s5,-1
 ad6:	a83d                	j	b14 <malloc+0x92>
 ad8:	f426                	sd	s1,40(sp)
 ada:	e852                	sd	s4,16(sp)
 adc:	e456                	sd	s5,8(sp)
 ade:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 ae0:	00001797          	auipc	a5,0x1
 ae4:	93078793          	addi	a5,a5,-1744 # 1410 <base>
 ae8:	00000717          	auipc	a4,0x0
 aec:	50f73c23          	sd	a5,1304(a4) # 1000 <freep>
 af0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 af2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 af6:	b7d1                	j	aba <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 af8:	6398                	ld	a4,0(a5)
 afa:	e118                	sd	a4,0(a0)
 afc:	a899                	j	b52 <malloc+0xd0>
  hp->s.size = nu;
 afe:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b02:	0541                	addi	a0,a0,16
 b04:	ef5ff0ef          	jal	9f8 <free>
  return freep;
 b08:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 b0a:	c125                	beqz	a0,b6a <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b0c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b0e:	4798                	lw	a4,8(a5)
 b10:	03277163          	bgeu	a4,s2,b32 <malloc+0xb0>
    if(p == freep)
 b14:	6098                	ld	a4,0(s1)
 b16:	853e                	mv	a0,a5
 b18:	fef71ae3          	bne	a4,a5,b0c <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 b1c:	8552                	mv	a0,s4
 b1e:	9d5ff0ef          	jal	4f2 <sbrk>
  if(p == SBRK_ERROR)
 b22:	fd551ee3          	bne	a0,s5,afe <malloc+0x7c>
        return 0;
 b26:	4501                	li	a0,0
 b28:	74a2                	ld	s1,40(sp)
 b2a:	6a42                	ld	s4,16(sp)
 b2c:	6aa2                	ld	s5,8(sp)
 b2e:	6b02                	ld	s6,0(sp)
 b30:	a03d                	j	b5e <malloc+0xdc>
 b32:	74a2                	ld	s1,40(sp)
 b34:	6a42                	ld	s4,16(sp)
 b36:	6aa2                	ld	s5,8(sp)
 b38:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b3a:	fae90fe3          	beq	s2,a4,af8 <malloc+0x76>
        p->s.size -= nunits;
 b3e:	4137073b          	subw	a4,a4,s3
 b42:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b44:	02071693          	slli	a3,a4,0x20
 b48:	01c6d713          	srli	a4,a3,0x1c
 b4c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b4e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b52:	00000717          	auipc	a4,0x0
 b56:	4aa73723          	sd	a0,1198(a4) # 1000 <freep>
      return (void*)(p + 1);
 b5a:	01078513          	addi	a0,a5,16
  }
}
 b5e:	70e2                	ld	ra,56(sp)
 b60:	7442                	ld	s0,48(sp)
 b62:	7902                	ld	s2,32(sp)
 b64:	69e2                	ld	s3,24(sp)
 b66:	6121                	addi	sp,sp,64
 b68:	8082                	ret
 b6a:	74a2                	ld	s1,40(sp)
 b6c:	6a42                	ld	s4,16(sp)
 b6e:	6aa2                	ld	s5,8(sp)
 b70:	6b02                	ld	s6,0(sp)
 b72:	b7f5                	j	b5e <malloc+0xdc>

0000000000000b74 <statistics>:
#include "kernel/fcntl.h"
#include "user/user.h"

int
statistics(void *buf, int sz)
{
 b74:	7179                	addi	sp,sp,-48
 b76:	f406                	sd	ra,40(sp)
 b78:	f022                	sd	s0,32(sp)
 b7a:	ec26                	sd	s1,24(sp)
 b7c:	e84a                	sd	s2,16(sp)
 b7e:	e44e                	sd	s3,8(sp)
 b80:	e052                	sd	s4,0(sp)
 b82:	1800                	addi	s0,sp,48
 b84:	8a2a                	mv	s4,a0
 b86:	892e                	mv	s2,a1
  int fd, i, n;
  
  fd = open("statistics", O_RDONLY);
 b88:	4581                	li	a1,0
 b8a:	00000517          	auipc	a0,0x0
 b8e:	0a650513          	addi	a0,a0,166 # c30 <statistics+0xbc>
 b92:	9d5ff0ef          	jal	566 <open>
  if(fd < 0) {
 b96:	02054e63          	bltz	a0,bd2 <statistics+0x5e>
 b9a:	89aa                	mv	s3,a0
      fprintf(2, "stats: open failed\n");
      exit(1);
  }
  for (i = 0; i < sz; ) {
 b9c:	4481                	li	s1,0
 b9e:	01205e63          	blez	s2,bba <statistics+0x46>
    if ((n = read(fd, buf+i, sz-i)) < 0) {
 ba2:	4099063b          	subw	a2,s2,s1
 ba6:	009a05b3          	add	a1,s4,s1
 baa:	854e                	mv	a0,s3
 bac:	993ff0ef          	jal	53e <read>
 bb0:	00054563          	bltz	a0,bba <statistics+0x46>
      break;
    }
    i += n;
 bb4:	9ca9                	addw	s1,s1,a0
  for (i = 0; i < sz; ) {
 bb6:	ff24c6e3          	blt	s1,s2,ba2 <statistics+0x2e>
  }
  close(fd);
 bba:	854e                	mv	a0,s3
 bbc:	993ff0ef          	jal	54e <close>
  return i;
}
 bc0:	8526                	mv	a0,s1
 bc2:	70a2                	ld	ra,40(sp)
 bc4:	7402                	ld	s0,32(sp)
 bc6:	64e2                	ld	s1,24(sp)
 bc8:	6942                	ld	s2,16(sp)
 bca:	69a2                	ld	s3,8(sp)
 bcc:	6a02                	ld	s4,0(sp)
 bce:	6145                	addi	sp,sp,48
 bd0:	8082                	ret
      fprintf(2, "stats: open failed\n");
 bd2:	00000597          	auipc	a1,0x0
 bd6:	06e58593          	addi	a1,a1,110 # c40 <statistics+0xcc>
 bda:	4509                	li	a0,2
 bdc:	dc1ff0ef          	jal	99c <fprintf>
      exit(1);
 be0:	4505                	li	a0,1
 be2:	945ff0ef          	jal	526 <exit>
