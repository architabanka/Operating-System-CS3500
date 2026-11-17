
user/_memdump:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <memdump>:
  exit(0);
}

void
memdump(char *fmt, char *data, int len)
{
   0:	7159                	addi	sp,sp,-112
   2:	f486                	sd	ra,104(sp)
   4:	f0a2                	sd	s0,96(sp)
   6:	e0d2                	sd	s4,64(sp)
   8:	1880                	addi	s0,sp,112
   a:	8a2e                	mv	s4,a1
  char *p=data;
  int rem=len;
  while(*fmt){
   c:	00054583          	lbu	a1,0(a0)
  10:	1c058963          	beqz	a1,1e2 <memdump+0x1e2>
  14:	eca6                	sd	s1,88(sp)
  16:	e8ca                	sd	s2,80(sp)
  18:	e4ce                	sd	s3,72(sp)
  1a:	fc56                	sd	s5,56(sp)
  1c:	f85a                	sd	s6,48(sp)
  1e:	f45e                	sd	s7,40(sp)
  20:	f062                	sd	s8,32(sp)
  22:	ec66                	sd	s9,24(sp)
  24:	e86a                	sd	s10,16(sp)
  26:	e46e                	sd	s11,8(sp)
  28:	892a                	mv	s2,a0
  2a:	89b2                	mv	s3,a2
  2c:	02000c13          	li	s8,32
        i++;
      }
      printf("\n");
    }
    else{
      printf("memdump: unknown format '%c'\n", *fmt);
  30:	00001d97          	auipc	s11,0x1
  34:	d18d8d93          	addi	s11,s11,-744 # d48 <malloc+0x1f2>
  38:	00001b97          	auipc	s7,0x1
  3c:	df8b8b93          	addi	s7,s7,-520 # e30 <malloc+0x2da>
      if(rem<8){
  40:	4c9d                	li	s9,7
      if(rem<2){
  42:	4d05                	li	s10,1
  44:	a835                	j	80 <memdump+0x80>
      while(i<rem&&p[i]!='\0'){
  46:	03305263          	blez	s3,6a <memdump+0x6a>
  4a:	84d2                	mv	s1,s4
  4c:	01498b33          	add	s6,s3,s4
        printf("%c", p[i]);
  50:	00001a97          	auipc	s5,0x1
  54:	ce8a8a93          	addi	s5,s5,-792 # d38 <malloc+0x1e2>
      while(i<rem&&p[i]!='\0'){
  58:	0004c583          	lbu	a1,0(s1)
  5c:	c599                	beqz	a1,6a <memdump+0x6a>
        printf("%c", p[i]);
  5e:	8556                	mv	a0,s5
  60:	23b000ef          	jal	a9a <printf>
      while(i<rem&&p[i]!='\0'){
  64:	0485                	addi	s1,s1,1
  66:	ff6499e3          	bne	s1,s6,58 <memdump+0x58>
      printf("\n");
  6a:	00001517          	auipc	a0,0x1
  6e:	cd650513          	addi	a0,a0,-810 # d40 <malloc+0x1ea>
  72:	229000ef          	jal	a9a <printf>
    }
    fmt++;
  76:	0905                	addi	s2,s2,1
  while(*fmt){
  78:	00094583          	lbu	a1,0(s2)
  7c:	14058963          	beqz	a1,1ce <memdump+0x1ce>
    if(*fmt=='i'){
  80:	fad5879b          	addiw	a5,a1,-83
  84:	0ff7f713          	zext.b	a4,a5
  88:	12ec6f63          	bltu	s8,a4,1c6 <memdump+0x1c6>
  8c:	00271793          	slli	a5,a4,0x2
  90:	97de                	add	a5,a5,s7
  92:	439c                	lw	a5,0(a5)
  94:	97de                	add	a5,a5,s7
  96:	8782                	jr	a5
      if(rem<4){
  98:	478d                	li	a5,3
  9a:	0137dd63          	bge	a5,s3,b4 <memdump+0xb4>
      printf("%d\n",*(int*)p);
  9e:	000a2583          	lw	a1,0(s4)
  a2:	00001517          	auipc	a0,0x1
  a6:	bd650513          	addi	a0,a0,-1066 # c78 <malloc+0x122>
  aa:	1f1000ef          	jal	a9a <printf>
      p+=4;
  ae:	0a11                	addi	s4,s4,4
      rem-=4;
  b0:	39f1                	addiw	s3,s3,-4
  b2:	b7d1                	j	76 <memdump+0x76>
        printf("memdump: not enough data for 'i'\n");
  b4:	00001517          	auipc	a0,0x1
  b8:	b9c50513          	addi	a0,a0,-1124 # c50 <malloc+0xfa>
  bc:	1df000ef          	jal	a9a <printf>
        return;
  c0:	64e6                	ld	s1,88(sp)
  c2:	6946                	ld	s2,80(sp)
  c4:	69a6                	ld	s3,72(sp)
  c6:	7ae2                	ld	s5,56(sp)
  c8:	7b42                	ld	s6,48(sp)
  ca:	7ba2                	ld	s7,40(sp)
  cc:	7c02                	ld	s8,32(sp)
  ce:	6ce2                	ld	s9,24(sp)
  d0:	6d42                	ld	s10,16(sp)
  d2:	6da2                	ld	s11,8(sp)
  d4:	a239                	j	1e2 <memdump+0x1e2>
      if(rem<8){
  d6:	013cdd63          	bge	s9,s3,f0 <memdump+0xf0>
      printf("%llx\n",*(unsigned long long*)p);
  da:	000a3583          	ld	a1,0(s4)
  de:	00001517          	auipc	a0,0x1
  e2:	bca50513          	addi	a0,a0,-1078 # ca8 <malloc+0x152>
  e6:	1b5000ef          	jal	a9a <printf>
      p+=8;
  ea:	0a21                	addi	s4,s4,8
      rem-=8;
  ec:	39e1                	addiw	s3,s3,-8
  ee:	b761                	j	76 <memdump+0x76>
        printf("memdump: not enough data for 'p'\n");
  f0:	00001517          	auipc	a0,0x1
  f4:	b9050513          	addi	a0,a0,-1136 # c80 <malloc+0x12a>
  f8:	1a3000ef          	jal	a9a <printf>
        return;
  fc:	64e6                	ld	s1,88(sp)
  fe:	6946                	ld	s2,80(sp)
 100:	69a6                	ld	s3,72(sp)
 102:	7ae2                	ld	s5,56(sp)
 104:	7b42                	ld	s6,48(sp)
 106:	7ba2                	ld	s7,40(sp)
 108:	7c02                	ld	s8,32(sp)
 10a:	6ce2                	ld	s9,24(sp)
 10c:	6d42                	ld	s10,16(sp)
 10e:	6da2                	ld	s11,8(sp)
 110:	a8c9                	j	1e2 <memdump+0x1e2>
      if(rem<2){
 112:	013d5d63          	bge	s10,s3,12c <memdump+0x12c>
      printf("%d\n",*(short*)p);
 116:	000a1583          	lh	a1,0(s4)
 11a:	00001517          	auipc	a0,0x1
 11e:	b5e50513          	addi	a0,a0,-1186 # c78 <malloc+0x122>
 122:	179000ef          	jal	a9a <printf>
      p+=2;
 126:	0a09                	addi	s4,s4,2
      rem-=2;
 128:	39f9                	addiw	s3,s3,-2
 12a:	b7b1                	j	76 <memdump+0x76>
        printf("memdump: not enough data for 'h'\n");
 12c:	00001517          	auipc	a0,0x1
 130:	b8450513          	addi	a0,a0,-1148 # cb0 <malloc+0x15a>
 134:	167000ef          	jal	a9a <printf>
        return;
 138:	64e6                	ld	s1,88(sp)
 13a:	6946                	ld	s2,80(sp)
 13c:	69a6                	ld	s3,72(sp)
 13e:	7ae2                	ld	s5,56(sp)
 140:	7b42                	ld	s6,48(sp)
 142:	7ba2                	ld	s7,40(sp)
 144:	7c02                	ld	s8,32(sp)
 146:	6ce2                	ld	s9,24(sp)
 148:	6d42                	ld	s10,16(sp)
 14a:	6da2                	ld	s11,8(sp)
 14c:	a859                	j	1e2 <memdump+0x1e2>
      if(rem<1){
 14e:	01305d63          	blez	s3,168 <memdump+0x168>
      printf("%c\n",*(char*)p);
 152:	000a4583          	lbu	a1,0(s4)
 156:	00001517          	auipc	a0,0x1
 15a:	baa50513          	addi	a0,a0,-1110 # d00 <malloc+0x1aa>
 15e:	13d000ef          	jal	a9a <printf>
      p+=1;
 162:	0a05                	addi	s4,s4,1
      rem-=1;
 164:	39fd                	addiw	s3,s3,-1
 166:	bf01                	j	76 <memdump+0x76>
        printf("memdump: not enough data for 'c'\n");
 168:	00001517          	auipc	a0,0x1
 16c:	b7050513          	addi	a0,a0,-1168 # cd8 <malloc+0x182>
 170:	12b000ef          	jal	a9a <printf>
        return;
 174:	64e6                	ld	s1,88(sp)
 176:	6946                	ld	s2,80(sp)
 178:	69a6                	ld	s3,72(sp)
 17a:	7ae2                	ld	s5,56(sp)
 17c:	7b42                	ld	s6,48(sp)
 17e:	7ba2                	ld	s7,40(sp)
 180:	7c02                	ld	s8,32(sp)
 182:	6ce2                	ld	s9,24(sp)
 184:	6d42                	ld	s10,16(sp)
 186:	6da2                	ld	s11,8(sp)
 188:	a8a9                	j	1e2 <memdump+0x1e2>
      if(rem<8){
 18a:	013cdd63          	bge	s9,s3,1a4 <memdump+0x1a4>
      printf("%s\n",*(char**)p);
 18e:	000a3583          	ld	a1,0(s4)
 192:	00001517          	auipc	a0,0x1
 196:	b9e50513          	addi	a0,a0,-1122 # d30 <malloc+0x1da>
 19a:	101000ef          	jal	a9a <printf>
      p+=8;
 19e:	0a21                	addi	s4,s4,8
      rem-=8;
 1a0:	39e1                	addiw	s3,s3,-8
 1a2:	bdd1                	j	76 <memdump+0x76>
        printf("memdump: not enough data for 's'\n");
 1a4:	00001517          	auipc	a0,0x1
 1a8:	b6450513          	addi	a0,a0,-1180 # d08 <malloc+0x1b2>
 1ac:	0ef000ef          	jal	a9a <printf>
        return;
 1b0:	64e6                	ld	s1,88(sp)
 1b2:	6946                	ld	s2,80(sp)
 1b4:	69a6                	ld	s3,72(sp)
 1b6:	7ae2                	ld	s5,56(sp)
 1b8:	7b42                	ld	s6,48(sp)
 1ba:	7ba2                	ld	s7,40(sp)
 1bc:	7c02                	ld	s8,32(sp)
 1be:	6ce2                	ld	s9,24(sp)
 1c0:	6d42                	ld	s10,16(sp)
 1c2:	6da2                	ld	s11,8(sp)
 1c4:	a839                	j	1e2 <memdump+0x1e2>
      printf("memdump: unknown format '%c'\n", *fmt);
 1c6:	856e                	mv	a0,s11
 1c8:	0d3000ef          	jal	a9a <printf>
 1cc:	b56d                	j	76 <memdump+0x76>
 1ce:	64e6                	ld	s1,88(sp)
 1d0:	6946                	ld	s2,80(sp)
 1d2:	69a6                	ld	s3,72(sp)
 1d4:	7ae2                	ld	s5,56(sp)
 1d6:	7b42                	ld	s6,48(sp)
 1d8:	7ba2                	ld	s7,40(sp)
 1da:	7c02                	ld	s8,32(sp)
 1dc:	6ce2                	ld	s9,24(sp)
 1de:	6d42                	ld	s10,16(sp)
 1e0:	6da2                	ld	s11,8(sp)
  }
}
 1e2:	70a6                	ld	ra,104(sp)
 1e4:	7406                	ld	s0,96(sp)
 1e6:	6a06                	ld	s4,64(sp)
 1e8:	6165                	addi	sp,sp,112
 1ea:	8082                	ret

00000000000001ec <main>:
{
 1ec:	db010113          	addi	sp,sp,-592
 1f0:	24113423          	sd	ra,584(sp)
 1f4:	24813023          	sd	s0,576(sp)
 1f8:	22913c23          	sd	s1,568(sp)
 1fc:	23213823          	sd	s2,560(sp)
 200:	23313423          	sd	s3,552(sp)
 204:	23413023          	sd	s4,544(sp)
 208:	21513c23          	sd	s5,536(sp)
 20c:	0c80                	addi	s0,sp,592
  if(argc == 1){
 20e:	4785                	li	a5,1
 210:	00f50f63          	beq	a0,a5,22e <main+0x42>
 214:	8aae                	mv	s5,a1
  } else if(argc == 2){
 216:	4789                	li	a5,2
 218:	10f50a63          	beq	a0,a5,32c <main+0x140>
    printf("Usage: memdump [format]\n");
 21c:	00001517          	auipc	a0,0x1
 220:	bec50513          	addi	a0,a0,-1044 # e08 <malloc+0x2b2>
 224:	077000ef          	jal	a9a <printf>
    exit(1);
 228:	4505                	li	a0,1
 22a:	412000ef          	jal	63c <exit>
    printf("Example 1:\n");
 22e:	00001517          	auipc	a0,0x1
 232:	b3a50513          	addi	a0,a0,-1222 # d68 <malloc+0x212>
 236:	065000ef          	jal	a9a <printf>
    int a[2] = { 61810, 2025 };
 23a:	67bd                	lui	a5,0xf
 23c:	17278793          	addi	a5,a5,370 # f172 <base+0xe162>
 240:	daf42823          	sw	a5,-592(s0)
 244:	7e900793          	li	a5,2025
 248:	daf42a23          	sw	a5,-588(s0)
    memdump("ii", (char*) a, sizeof(a));
 24c:	4621                	li	a2,8
 24e:	db040593          	addi	a1,s0,-592
 252:	00001517          	auipc	a0,0x1
 256:	b2650513          	addi	a0,a0,-1242 # d78 <malloc+0x222>
 25a:	da7ff0ef          	jal	0 <memdump>
    printf("Example 2:\n");
 25e:	00001517          	auipc	a0,0x1
 262:	b2250513          	addi	a0,a0,-1246 # d80 <malloc+0x22a>
 266:	035000ef          	jal	a9a <printf>
    memdump("S", t, strlen(t));
 26a:	00001517          	auipc	a0,0x1
 26e:	b2650513          	addi	a0,a0,-1242 # d90 <malloc+0x23a>
 272:	174000ef          	jal	3e6 <strlen>
 276:	862a                	mv	a2,a0
 278:	00001597          	auipc	a1,0x1
 27c:	b1858593          	addi	a1,a1,-1256 # d90 <malloc+0x23a>
 280:	00001517          	auipc	a0,0x1
 284:	b2050513          	addi	a0,a0,-1248 # da0 <malloc+0x24a>
 288:	d79ff0ef          	jal	0 <memdump>
    printf("Example 3:\n");
 28c:	00001517          	auipc	a0,0x1
 290:	b1c50513          	addi	a0,a0,-1252 # da8 <malloc+0x252>
 294:	007000ef          	jal	a9a <printf>
    char *s = "another";
 298:	00001797          	auipc	a5,0x1
 29c:	b2078793          	addi	a5,a5,-1248 # db8 <malloc+0x262>
 2a0:	daf43c23          	sd	a5,-584(s0)
    memdump("s", (char *) &s, sizeof(char *));
 2a4:	4621                	li	a2,8
 2a6:	db840593          	addi	a1,s0,-584
 2aa:	00001517          	auipc	a0,0x1
 2ae:	b1650513          	addi	a0,a0,-1258 # dc0 <malloc+0x26a>
 2b2:	d4fff0ef          	jal	0 <memdump>
    example.ptr = "hello";
 2b6:	00001797          	auipc	a5,0x1
 2ba:	b1278793          	addi	a5,a5,-1262 # dc8 <malloc+0x272>
 2be:	dcf43023          	sd	a5,-576(s0)
    example.num1 = 1819438967;
 2c2:	6c7277b7          	lui	a5,0x6c727
 2c6:	f7778793          	addi	a5,a5,-137 # 6c726f77 <base+0x6c725f67>
 2ca:	dcf42423          	sw	a5,-568(s0)
    example.num2 = 100;
 2ce:	06400793          	li	a5,100
 2d2:	dcf41623          	sh	a5,-564(s0)
    example.byte = 'z';
 2d6:	07a00793          	li	a5,122
 2da:	dcf40723          	sb	a5,-562(s0)
    strcpy(example.bytes, "xyzzy");
 2de:	dc040493          	addi	s1,s0,-576
 2e2:	00001597          	auipc	a1,0x1
 2e6:	aee58593          	addi	a1,a1,-1298 # dd0 <malloc+0x27a>
 2ea:	dcf40513          	addi	a0,s0,-561
 2ee:	0a8000ef          	jal	396 <strcpy>
    printf("Example 4:\n");
 2f2:	00001517          	auipc	a0,0x1
 2f6:	ae650513          	addi	a0,a0,-1306 # dd8 <malloc+0x282>
 2fa:	7a0000ef          	jal	a9a <printf>
    memdump("pihcS", (char*) &example, sizeof(example));
 2fe:	4661                	li	a2,24
 300:	85a6                	mv	a1,s1
 302:	00001517          	auipc	a0,0x1
 306:	ae650513          	addi	a0,a0,-1306 # de8 <malloc+0x292>
 30a:	cf7ff0ef          	jal	0 <memdump>
    printf("Example 5:\n");
 30e:	00001517          	auipc	a0,0x1
 312:	ae250513          	addi	a0,a0,-1310 # df0 <malloc+0x29a>
 316:	784000ef          	jal	a9a <printf>
    memdump("sccccc", (char*) &example, sizeof(example));
 31a:	4661                	li	a2,24
 31c:	85a6                	mv	a1,s1
 31e:	00001517          	auipc	a0,0x1
 322:	ae250513          	addi	a0,a0,-1310 # e00 <malloc+0x2aa>
 326:	cdbff0ef          	jal	0 <memdump>
 32a:	a891                	j	37e <main+0x192>
    memset(data, '\0', sizeof(data));
 32c:	20000613          	li	a2,512
 330:	4581                	li	a1,0
 332:	dc040513          	addi	a0,s0,-576
 336:	0dc000ef          	jal	412 <memset>
    int n = 0;
 33a:	4481                	li	s1,0
    while(n < sizeof(data)){
 33c:	4601                	li	a2,0
      int nn = read(0, data + n, sizeof(data) - n);
 33e:	20000993          	li	s3,512
 342:	dc040913          	addi	s2,s0,-576
    while(n < sizeof(data)){
 346:	1ff00a13          	li	s4,511
      int nn = read(0, data + n, sizeof(data) - n);
 34a:	40c9863b          	subw	a2,s3,a2
 34e:	009905b3          	add	a1,s2,s1
 352:	4501                	li	a0,0
 354:	300000ef          	jal	654 <read>
      if(nn <= 0)
 358:	00a05763          	blez	a0,366 <main+0x17a>
      n += nn;
 35c:	0095063b          	addw	a2,a0,s1
 360:	84b2                	mv	s1,a2
    while(n < sizeof(data)){
 362:	feca74e3          	bgeu	s4,a2,34a <main+0x15e>
    memdump(argv[1], data, strlen(data));
 366:	008ab903          	ld	s2,8(s5)
 36a:	dc040493          	addi	s1,s0,-576
 36e:	8526                	mv	a0,s1
 370:	076000ef          	jal	3e6 <strlen>
 374:	862a                	mv	a2,a0
 376:	85a6                	mv	a1,s1
 378:	854a                	mv	a0,s2
 37a:	c87ff0ef          	jal	0 <memdump>
  exit(0);
 37e:	4501                	li	a0,0
 380:	2bc000ef          	jal	63c <exit>

0000000000000384 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 384:	1141                	addi	sp,sp,-16
 386:	e406                	sd	ra,8(sp)
 388:	e022                	sd	s0,0(sp)
 38a:	0800                	addi	s0,sp,16
  extern int main();
  main();
 38c:	e61ff0ef          	jal	1ec <main>
  exit(0);
 390:	4501                	li	a0,0
 392:	2aa000ef          	jal	63c <exit>

0000000000000396 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 396:	1141                	addi	sp,sp,-16
 398:	e406                	sd	ra,8(sp)
 39a:	e022                	sd	s0,0(sp)
 39c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 39e:	87aa                	mv	a5,a0
 3a0:	0585                	addi	a1,a1,1
 3a2:	0785                	addi	a5,a5,1
 3a4:	fff5c703          	lbu	a4,-1(a1)
 3a8:	fee78fa3          	sb	a4,-1(a5)
 3ac:	fb75                	bnez	a4,3a0 <strcpy+0xa>
    ;
  return os;
}
 3ae:	60a2                	ld	ra,8(sp)
 3b0:	6402                	ld	s0,0(sp)
 3b2:	0141                	addi	sp,sp,16
 3b4:	8082                	ret

00000000000003b6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3b6:	1141                	addi	sp,sp,-16
 3b8:	e406                	sd	ra,8(sp)
 3ba:	e022                	sd	s0,0(sp)
 3bc:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 3be:	00054783          	lbu	a5,0(a0)
 3c2:	cb91                	beqz	a5,3d6 <strcmp+0x20>
 3c4:	0005c703          	lbu	a4,0(a1)
 3c8:	00f71763          	bne	a4,a5,3d6 <strcmp+0x20>
    p++, q++;
 3cc:	0505                	addi	a0,a0,1
 3ce:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 3d0:	00054783          	lbu	a5,0(a0)
 3d4:	fbe5                	bnez	a5,3c4 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 3d6:	0005c503          	lbu	a0,0(a1)
}
 3da:	40a7853b          	subw	a0,a5,a0
 3de:	60a2                	ld	ra,8(sp)
 3e0:	6402                	ld	s0,0(sp)
 3e2:	0141                	addi	sp,sp,16
 3e4:	8082                	ret

00000000000003e6 <strlen>:

uint
strlen(const char *s)
{
 3e6:	1141                	addi	sp,sp,-16
 3e8:	e406                	sd	ra,8(sp)
 3ea:	e022                	sd	s0,0(sp)
 3ec:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3ee:	00054783          	lbu	a5,0(a0)
 3f2:	cf91                	beqz	a5,40e <strlen+0x28>
 3f4:	00150793          	addi	a5,a0,1
 3f8:	86be                	mv	a3,a5
 3fa:	0785                	addi	a5,a5,1
 3fc:	fff7c703          	lbu	a4,-1(a5)
 400:	ff65                	bnez	a4,3f8 <strlen+0x12>
 402:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 406:	60a2                	ld	ra,8(sp)
 408:	6402                	ld	s0,0(sp)
 40a:	0141                	addi	sp,sp,16
 40c:	8082                	ret
  for(n = 0; s[n]; n++)
 40e:	4501                	li	a0,0
 410:	bfdd                	j	406 <strlen+0x20>

0000000000000412 <memset>:

void*
memset(void *dst, int c, uint n)
{
 412:	1141                	addi	sp,sp,-16
 414:	e406                	sd	ra,8(sp)
 416:	e022                	sd	s0,0(sp)
 418:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 41a:	ca19                	beqz	a2,430 <memset+0x1e>
 41c:	87aa                	mv	a5,a0
 41e:	1602                	slli	a2,a2,0x20
 420:	9201                	srli	a2,a2,0x20
 422:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 426:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 42a:	0785                	addi	a5,a5,1
 42c:	fee79de3          	bne	a5,a4,426 <memset+0x14>
  }
  return dst;
}
 430:	60a2                	ld	ra,8(sp)
 432:	6402                	ld	s0,0(sp)
 434:	0141                	addi	sp,sp,16
 436:	8082                	ret

0000000000000438 <strchr>:

char*
strchr(const char *s, char c)
{
 438:	1141                	addi	sp,sp,-16
 43a:	e406                	sd	ra,8(sp)
 43c:	e022                	sd	s0,0(sp)
 43e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 440:	00054783          	lbu	a5,0(a0)
 444:	c799                	beqz	a5,452 <strchr+0x1a>
    if(*s == c)
 446:	00f58763          	beq	a1,a5,454 <strchr+0x1c>
  for(; *s; s++)
 44a:	0505                	addi	a0,a0,1
 44c:	00054783          	lbu	a5,0(a0)
 450:	fbfd                	bnez	a5,446 <strchr+0xe>
      return (char*)s;
  return 0;
 452:	4501                	li	a0,0
}
 454:	60a2                	ld	ra,8(sp)
 456:	6402                	ld	s0,0(sp)
 458:	0141                	addi	sp,sp,16
 45a:	8082                	ret

000000000000045c <gets>:

char*
gets(char *buf, int max)
{
 45c:	711d                	addi	sp,sp,-96
 45e:	ec86                	sd	ra,88(sp)
 460:	e8a2                	sd	s0,80(sp)
 462:	e4a6                	sd	s1,72(sp)
 464:	e0ca                	sd	s2,64(sp)
 466:	fc4e                	sd	s3,56(sp)
 468:	f852                	sd	s4,48(sp)
 46a:	f456                	sd	s5,40(sp)
 46c:	f05a                	sd	s6,32(sp)
 46e:	ec5e                	sd	s7,24(sp)
 470:	e862                	sd	s8,16(sp)
 472:	1080                	addi	s0,sp,96
 474:	8baa                	mv	s7,a0
 476:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 478:	892a                	mv	s2,a0
 47a:	4481                	li	s1,0
    cc = read(0, &c, 1);
 47c:	faf40b13          	addi	s6,s0,-81
 480:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 482:	8c26                	mv	s8,s1
 484:	0014899b          	addiw	s3,s1,1
 488:	84ce                	mv	s1,s3
 48a:	0349d863          	bge	s3,s4,4ba <gets+0x5e>
    cc = read(0, &c, 1);
 48e:	8656                	mv	a2,s5
 490:	85da                	mv	a1,s6
 492:	4501                	li	a0,0
 494:	1c0000ef          	jal	654 <read>
    if(cc < 1)
 498:	02a05163          	blez	a0,4ba <gets+0x5e>
      break;
    buf[i++] = c;
 49c:	faf44783          	lbu	a5,-81(s0)
 4a0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 4a4:	0905                	addi	s2,s2,1
 4a6:	ff678713          	addi	a4,a5,-10
 4aa:	00173713          	seqz	a4,a4
 4ae:	17cd                	addi	a5,a5,-13
 4b0:	0017b793          	seqz	a5,a5
 4b4:	8fd9                	or	a5,a5,a4
 4b6:	d7f1                	beqz	a5,482 <gets+0x26>
    buf[i++] = c;
 4b8:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 4ba:	9c5e                	add	s8,s8,s7
 4bc:	000c0023          	sb	zero,0(s8)
  return buf;
}
 4c0:	855e                	mv	a0,s7
 4c2:	60e6                	ld	ra,88(sp)
 4c4:	6446                	ld	s0,80(sp)
 4c6:	64a6                	ld	s1,72(sp)
 4c8:	6906                	ld	s2,64(sp)
 4ca:	79e2                	ld	s3,56(sp)
 4cc:	7a42                	ld	s4,48(sp)
 4ce:	7aa2                	ld	s5,40(sp)
 4d0:	7b02                	ld	s6,32(sp)
 4d2:	6be2                	ld	s7,24(sp)
 4d4:	6c42                	ld	s8,16(sp)
 4d6:	6125                	addi	sp,sp,96
 4d8:	8082                	ret

00000000000004da <stat>:

int
stat(const char *n, struct stat *st)
{
 4da:	1101                	addi	sp,sp,-32
 4dc:	ec06                	sd	ra,24(sp)
 4de:	e822                	sd	s0,16(sp)
 4e0:	e04a                	sd	s2,0(sp)
 4e2:	1000                	addi	s0,sp,32
 4e4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4e6:	4581                	li	a1,0
 4e8:	194000ef          	jal	67c <open>
  if(fd < 0)
 4ec:	02054263          	bltz	a0,510 <stat+0x36>
 4f0:	e426                	sd	s1,8(sp)
 4f2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4f4:	85ca                	mv	a1,s2
 4f6:	19e000ef          	jal	694 <fstat>
 4fa:	892a                	mv	s2,a0
  close(fd);
 4fc:	8526                	mv	a0,s1
 4fe:	166000ef          	jal	664 <close>
  return r;
 502:	64a2                	ld	s1,8(sp)
}
 504:	854a                	mv	a0,s2
 506:	60e2                	ld	ra,24(sp)
 508:	6442                	ld	s0,16(sp)
 50a:	6902                	ld	s2,0(sp)
 50c:	6105                	addi	sp,sp,32
 50e:	8082                	ret
    return -1;
 510:	57fd                	li	a5,-1
 512:	893e                	mv	s2,a5
 514:	bfc5                	j	504 <stat+0x2a>

0000000000000516 <atoi>:

int
atoi(const char *s)
{
 516:	1141                	addi	sp,sp,-16
 518:	e406                	sd	ra,8(sp)
 51a:	e022                	sd	s0,0(sp)
 51c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 51e:	00054683          	lbu	a3,0(a0)
 522:	fd06879b          	addiw	a5,a3,-48
 526:	0ff7f793          	zext.b	a5,a5
 52a:	4625                	li	a2,9
 52c:	02f66963          	bltu	a2,a5,55e <atoi+0x48>
 530:	872a                	mv	a4,a0
  n = 0;
 532:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 534:	0705                	addi	a4,a4,1
 536:	0025179b          	slliw	a5,a0,0x2
 53a:	9fa9                	addw	a5,a5,a0
 53c:	0017979b          	slliw	a5,a5,0x1
 540:	9fb5                	addw	a5,a5,a3
 542:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 546:	00074683          	lbu	a3,0(a4)
 54a:	fd06879b          	addiw	a5,a3,-48
 54e:	0ff7f793          	zext.b	a5,a5
 552:	fef671e3          	bgeu	a2,a5,534 <atoi+0x1e>
  return n;
}
 556:	60a2                	ld	ra,8(sp)
 558:	6402                	ld	s0,0(sp)
 55a:	0141                	addi	sp,sp,16
 55c:	8082                	ret
  n = 0;
 55e:	4501                	li	a0,0
 560:	bfdd                	j	556 <atoi+0x40>

0000000000000562 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 562:	1141                	addi	sp,sp,-16
 564:	e406                	sd	ra,8(sp)
 566:	e022                	sd	s0,0(sp)
 568:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 56a:	02b57563          	bgeu	a0,a1,594 <memmove+0x32>
    while(n-- > 0)
 56e:	00c05f63          	blez	a2,58c <memmove+0x2a>
 572:	1602                	slli	a2,a2,0x20
 574:	9201                	srli	a2,a2,0x20
 576:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 57a:	872a                	mv	a4,a0
      *dst++ = *src++;
 57c:	0585                	addi	a1,a1,1
 57e:	0705                	addi	a4,a4,1
 580:	fff5c683          	lbu	a3,-1(a1)
 584:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 588:	fee79ae3          	bne	a5,a4,57c <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 58c:	60a2                	ld	ra,8(sp)
 58e:	6402                	ld	s0,0(sp)
 590:	0141                	addi	sp,sp,16
 592:	8082                	ret
    while(n-- > 0)
 594:	fec05ce3          	blez	a2,58c <memmove+0x2a>
    dst += n;
 598:	00c50733          	add	a4,a0,a2
    src += n;
 59c:	95b2                	add	a1,a1,a2
 59e:	fff6079b          	addiw	a5,a2,-1
 5a2:	1782                	slli	a5,a5,0x20
 5a4:	9381                	srli	a5,a5,0x20
 5a6:	fff7c793          	not	a5,a5
 5aa:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 5ac:	15fd                	addi	a1,a1,-1
 5ae:	177d                	addi	a4,a4,-1
 5b0:	0005c683          	lbu	a3,0(a1)
 5b4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 5b8:	fef71ae3          	bne	a4,a5,5ac <memmove+0x4a>
 5bc:	bfc1                	j	58c <memmove+0x2a>

00000000000005be <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 5be:	1141                	addi	sp,sp,-16
 5c0:	e406                	sd	ra,8(sp)
 5c2:	e022                	sd	s0,0(sp)
 5c4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 5c6:	ce19                	beqz	a2,5e4 <memcmp+0x26>
 5c8:	1602                	slli	a2,a2,0x20
 5ca:	9201                	srli	a2,a2,0x20
 5cc:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 5d0:	00054783          	lbu	a5,0(a0)
 5d4:	0005c703          	lbu	a4,0(a1)
 5d8:	00e79b63          	bne	a5,a4,5ee <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 5dc:	0505                	addi	a0,a0,1
    p2++;
 5de:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 5e0:	fed518e3          	bne	a0,a3,5d0 <memcmp+0x12>
  }
  return 0;
 5e4:	4501                	li	a0,0
}
 5e6:	60a2                	ld	ra,8(sp)
 5e8:	6402                	ld	s0,0(sp)
 5ea:	0141                	addi	sp,sp,16
 5ec:	8082                	ret
      return *p1 - *p2;
 5ee:	40e7853b          	subw	a0,a5,a4
 5f2:	bfd5                	j	5e6 <memcmp+0x28>

00000000000005f4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5f4:	1141                	addi	sp,sp,-16
 5f6:	e406                	sd	ra,8(sp)
 5f8:	e022                	sd	s0,0(sp)
 5fa:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5fc:	f67ff0ef          	jal	562 <memmove>
}
 600:	60a2                	ld	ra,8(sp)
 602:	6402                	ld	s0,0(sp)
 604:	0141                	addi	sp,sp,16
 606:	8082                	ret

0000000000000608 <sbrk>:

char *
sbrk(int n) {
 608:	1141                	addi	sp,sp,-16
 60a:	e406                	sd	ra,8(sp)
 60c:	e022                	sd	s0,0(sp)
 60e:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 610:	4585                	li	a1,1
 612:	0b2000ef          	jal	6c4 <sys_sbrk>
}
 616:	60a2                	ld	ra,8(sp)
 618:	6402                	ld	s0,0(sp)
 61a:	0141                	addi	sp,sp,16
 61c:	8082                	ret

000000000000061e <sbrklazy>:

char *
sbrklazy(int n) {
 61e:	1141                	addi	sp,sp,-16
 620:	e406                	sd	ra,8(sp)
 622:	e022                	sd	s0,0(sp)
 624:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 626:	4589                	li	a1,2
 628:	09c000ef          	jal	6c4 <sys_sbrk>
}
 62c:	60a2                	ld	ra,8(sp)
 62e:	6402                	ld	s0,0(sp)
 630:	0141                	addi	sp,sp,16
 632:	8082                	ret

0000000000000634 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 634:	4885                	li	a7,1
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <exit>:
.global exit
exit:
 li a7, SYS_exit
 63c:	4889                	li	a7,2
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <wait>:
.global wait
wait:
 li a7, SYS_wait
 644:	488d                	li	a7,3
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 64c:	4891                	li	a7,4
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <read>:
.global read
read:
 li a7, SYS_read
 654:	4895                	li	a7,5
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <write>:
.global write
write:
 li a7, SYS_write
 65c:	48c1                	li	a7,16
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <close>:
.global close
close:
 li a7, SYS_close
 664:	48d5                	li	a7,21
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <kill>:
.global kill
kill:
 li a7, SYS_kill
 66c:	4899                	li	a7,6
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <exec>:
.global exec
exec:
 li a7, SYS_exec
 674:	489d                	li	a7,7
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <open>:
.global open
open:
 li a7, SYS_open
 67c:	48bd                	li	a7,15
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 684:	48c5                	li	a7,17
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 68c:	48c9                	li	a7,18
 ecall
 68e:	00000073          	ecall
 ret
 692:	8082                	ret

0000000000000694 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 694:	48a1                	li	a7,8
 ecall
 696:	00000073          	ecall
 ret
 69a:	8082                	ret

000000000000069c <link>:
.global link
link:
 li a7, SYS_link
 69c:	48cd                	li	a7,19
 ecall
 69e:	00000073          	ecall
 ret
 6a2:	8082                	ret

00000000000006a4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6a4:	48d1                	li	a7,20
 ecall
 6a6:	00000073          	ecall
 ret
 6aa:	8082                	ret

00000000000006ac <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6ac:	48a5                	li	a7,9
 ecall
 6ae:	00000073          	ecall
 ret
 6b2:	8082                	ret

00000000000006b4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6b4:	48a9                	li	a7,10
 ecall
 6b6:	00000073          	ecall
 ret
 6ba:	8082                	ret

00000000000006bc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6bc:	48ad                	li	a7,11
 ecall
 6be:	00000073          	ecall
 ret
 6c2:	8082                	ret

00000000000006c4 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 6c4:	48b1                	li	a7,12
 ecall
 6c6:	00000073          	ecall
 ret
 6ca:	8082                	ret

00000000000006cc <pause>:
.global pause
pause:
 li a7, SYS_pause
 6cc:	48b5                	li	a7,13
 ecall
 6ce:	00000073          	ecall
 ret
 6d2:	8082                	ret

00000000000006d4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6d4:	48b9                	li	a7,14
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6dc:	1101                	addi	sp,sp,-32
 6de:	ec06                	sd	ra,24(sp)
 6e0:	e822                	sd	s0,16(sp)
 6e2:	1000                	addi	s0,sp,32
 6e4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6e8:	4605                	li	a2,1
 6ea:	fef40593          	addi	a1,s0,-17
 6ee:	f6fff0ef          	jal	65c <write>
}
 6f2:	60e2                	ld	ra,24(sp)
 6f4:	6442                	ld	s0,16(sp)
 6f6:	6105                	addi	sp,sp,32
 6f8:	8082                	ret

00000000000006fa <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 6fa:	715d                	addi	sp,sp,-80
 6fc:	e486                	sd	ra,72(sp)
 6fe:	e0a2                	sd	s0,64(sp)
 700:	f84a                	sd	s2,48(sp)
 702:	f44e                	sd	s3,40(sp)
 704:	0880                	addi	s0,sp,80
 706:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 708:	00d036b3          	snez	a3,a3
 70c:	03f5d793          	srli	a5,a1,0x3f
 710:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 712:	0005871b          	sext.w	a4,a1
  neg = 0;
 716:	4301                	li	t1,0
  if(sgn && xx < 0){
 718:	c681                	beqz	a3,720 <printint+0x26>
    x = -xx;
 71a:	40b0073b          	negw	a4,a1
    neg = 1;
 71e:	4305                	li	t1,1
  }

  i = 0;
 720:	fb840993          	addi	s3,s0,-72
  neg = 0;
 724:	85ce                	mv	a1,s3
  i = 0;
 726:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
 728:	00000817          	auipc	a6,0x0
 72c:	79080813          	addi	a6,a6,1936 # eb8 <digits>
 730:	88b6                	mv	a7,a3
 732:	0016851b          	addiw	a0,a3,1
 736:	86aa                	mv	a3,a0
 738:	02c777bb          	remuw	a5,a4,a2
 73c:	1782                	slli	a5,a5,0x20
 73e:	9381                	srli	a5,a5,0x20
 740:	97c2                	add	a5,a5,a6
 742:	0007c783          	lbu	a5,0(a5)
 746:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
 74a:	87ba                	mv	a5,a4
 74c:	02c7573b          	divuw	a4,a4,a2
 750:	0585                	addi	a1,a1,1
 752:	fcc7ffe3          	bgeu	a5,a2,730 <printint+0x36>
  if(neg)
 756:	00030b63          	beqz	t1,76c <printint+0x72>
    buf[i++] = '-';
 75a:	fd040793          	addi	a5,s0,-48
 75e:	953e                	add	a0,a0,a5
 760:	02d00793          	li	a5,45
 764:	fef50423          	sb	a5,-24(a0)
 768:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
 76c:	02d05563          	blez	a3,796 <printint+0x9c>
 770:	fc26                	sd	s1,56(sp)
 772:	36fd                	addiw	a3,a3,-1
 774:	00d984b3          	add	s1,s3,a3
 778:	19fd                	addi	s3,s3,-1
 77a:	99b6                	add	s3,s3,a3
 77c:	1682                	slli	a3,a3,0x20
 77e:	9281                	srli	a3,a3,0x20
 780:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
 784:	0004c583          	lbu	a1,0(s1)
 788:	854a                	mv	a0,s2
 78a:	f53ff0ef          	jal	6dc <putc>
  while(--i >= 0)
 78e:	14fd                	addi	s1,s1,-1
 790:	ff349ae3          	bne	s1,s3,784 <printint+0x8a>
 794:	74e2                	ld	s1,56(sp)
}
 796:	60a6                	ld	ra,72(sp)
 798:	6406                	ld	s0,64(sp)
 79a:	7942                	ld	s2,48(sp)
 79c:	79a2                	ld	s3,40(sp)
 79e:	6161                	addi	sp,sp,80
 7a0:	8082                	ret

00000000000007a2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7a2:	711d                	addi	sp,sp,-96
 7a4:	ec86                	sd	ra,88(sp)
 7a6:	e8a2                	sd	s0,80(sp)
 7a8:	e4a6                	sd	s1,72(sp)
 7aa:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7ac:	0005c483          	lbu	s1,0(a1)
 7b0:	2a048063          	beqz	s1,a50 <vprintf+0x2ae>
 7b4:	e0ca                	sd	s2,64(sp)
 7b6:	fc4e                	sd	s3,56(sp)
 7b8:	f852                	sd	s4,48(sp)
 7ba:	f456                	sd	s5,40(sp)
 7bc:	f05a                	sd	s6,32(sp)
 7be:	ec5e                	sd	s7,24(sp)
 7c0:	e862                	sd	s8,16(sp)
 7c2:	8b2a                	mv	s6,a0
 7c4:	8a2e                	mv	s4,a1
 7c6:	8bb2                	mv	s7,a2
  state = 0;
 7c8:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 7ca:	4901                	li	s2,0
 7cc:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 7ce:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 7d2:	06400c13          	li	s8,100
 7d6:	a00d                	j	7f8 <vprintf+0x56>
        putc(fd, c0);
 7d8:	85a6                	mv	a1,s1
 7da:	855a                	mv	a0,s6
 7dc:	f01ff0ef          	jal	6dc <putc>
 7e0:	a019                	j	7e6 <vprintf+0x44>
    } else if(state == '%'){
 7e2:	03598363          	beq	s3,s5,808 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 7e6:	0019079b          	addiw	a5,s2,1
 7ea:	893e                	mv	s2,a5
 7ec:	873e                	mv	a4,a5
 7ee:	97d2                	add	a5,a5,s4
 7f0:	0007c483          	lbu	s1,0(a5)
 7f4:	24048763          	beqz	s1,a42 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 7f8:	0004879b          	sext.w	a5,s1
    if(state == 0){
 7fc:	fe0993e3          	bnez	s3,7e2 <vprintf+0x40>
      if(c0 == '%'){
 800:	fd579ce3          	bne	a5,s5,7d8 <vprintf+0x36>
        state = '%';
 804:	89be                	mv	s3,a5
 806:	b7c5                	j	7e6 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 808:	00ea06b3          	add	a3,s4,a4
 80c:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 810:	24060563          	beqz	a2,a5a <vprintf+0x2b8>
      if(c0 == 'd'){
 814:	0b878763          	beq	a5,s8,8c2 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 818:	f9478693          	addi	a3,a5,-108
 81c:	0016b693          	seqz	a3,a3
 820:	f9c60593          	addi	a1,a2,-100
 824:	0015b593          	seqz	a1,a1
 828:	8df5                	and	a1,a1,a3
 82a:	e9c5                	bnez	a1,8da <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 82c:	9752                	add	a4,a4,s4
 82e:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 832:	f9460713          	addi	a4,a2,-108
 836:	00173713          	seqz	a4,a4
 83a:	8f75                	and	a4,a4,a3
 83c:	f9c50593          	addi	a1,a0,-100
 840:	0015b593          	seqz	a1,a1
 844:	8df9                	and	a1,a1,a4
 846:	e5dd                	bnez	a1,8f4 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 848:	07500593          	li	a1,117
 84c:	0cb78163          	beq	a5,a1,90e <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 850:	f8b60593          	addi	a1,a2,-117
 854:	0015b593          	seqz	a1,a1
 858:	8df5                	and	a1,a1,a3
 85a:	e5f1                	bnez	a1,926 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 85c:	f8b50593          	addi	a1,a0,-117
 860:	0015b593          	seqz	a1,a1
 864:	8df9                	and	a1,a1,a4
 866:	ede9                	bnez	a1,940 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 868:	07800593          	li	a1,120
 86c:	0eb78763          	beq	a5,a1,95a <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 870:	f8860613          	addi	a2,a2,-120
 874:	00163613          	seqz	a2,a2
 878:	8ef1                	and	a3,a3,a2
 87a:	0e069c63          	bnez	a3,972 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 87e:	f8850513          	addi	a0,a0,-120
 882:	00153513          	seqz	a0,a0
 886:	8f69                	and	a4,a4,a0
 888:	10071263          	bnez	a4,98c <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 88c:	07000713          	li	a4,112
 890:	10e78a63          	beq	a5,a4,9a4 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 894:	06300713          	li	a4,99
 898:	14e78a63          	beq	a5,a4,9ec <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 89c:	07300713          	li	a4,115
 8a0:	16e78063          	beq	a5,a4,a00 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 8a4:	02500713          	li	a4,37
 8a8:	18e78863          	beq	a5,a4,a38 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8ac:	02500593          	li	a1,37
 8b0:	855a                	mv	a0,s6
 8b2:	e2bff0ef          	jal	6dc <putc>
        putc(fd, c0);
 8b6:	85a6                	mv	a1,s1
 8b8:	855a                	mv	a0,s6
 8ba:	e23ff0ef          	jal	6dc <putc>
      }

      state = 0;
 8be:	4981                	li	s3,0
 8c0:	b71d                	j	7e6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 8c2:	008b8493          	addi	s1,s7,8
 8c6:	4685                	li	a3,1
 8c8:	4629                	li	a2,10
 8ca:	000ba583          	lw	a1,0(s7)
 8ce:	855a                	mv	a0,s6
 8d0:	e2bff0ef          	jal	6fa <printint>
 8d4:	8ba6                	mv	s7,s1
      state = 0;
 8d6:	4981                	li	s3,0
 8d8:	b739                	j	7e6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8da:	008b8493          	addi	s1,s7,8
 8de:	4685                	li	a3,1
 8e0:	4629                	li	a2,10
 8e2:	000bb583          	ld	a1,0(s7)
 8e6:	855a                	mv	a0,s6
 8e8:	e13ff0ef          	jal	6fa <printint>
        i += 1;
 8ec:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 8ee:	8ba6                	mv	s7,s1
      state = 0;
 8f0:	4981                	li	s3,0
 8f2:	bdd5                	j	7e6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8f4:	008b8493          	addi	s1,s7,8
 8f8:	4685                	li	a3,1
 8fa:	4629                	li	a2,10
 8fc:	000bb583          	ld	a1,0(s7)
 900:	855a                	mv	a0,s6
 902:	df9ff0ef          	jal	6fa <printint>
        i += 2;
 906:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 908:	8ba6                	mv	s7,s1
      state = 0;
 90a:	4981                	li	s3,0
        i += 2;
 90c:	bde9                	j	7e6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 90e:	008b8493          	addi	s1,s7,8
 912:	4681                	li	a3,0
 914:	4629                	li	a2,10
 916:	000be583          	lwu	a1,0(s7)
 91a:	855a                	mv	a0,s6
 91c:	ddfff0ef          	jal	6fa <printint>
 920:	8ba6                	mv	s7,s1
      state = 0;
 922:	4981                	li	s3,0
 924:	b5c9                	j	7e6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 926:	008b8493          	addi	s1,s7,8
 92a:	4681                	li	a3,0
 92c:	4629                	li	a2,10
 92e:	000bb583          	ld	a1,0(s7)
 932:	855a                	mv	a0,s6
 934:	dc7ff0ef          	jal	6fa <printint>
        i += 1;
 938:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 93a:	8ba6                	mv	s7,s1
      state = 0;
 93c:	4981                	li	s3,0
 93e:	b565                	j	7e6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 940:	008b8493          	addi	s1,s7,8
 944:	4681                	li	a3,0
 946:	4629                	li	a2,10
 948:	000bb583          	ld	a1,0(s7)
 94c:	855a                	mv	a0,s6
 94e:	dadff0ef          	jal	6fa <printint>
        i += 2;
 952:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 954:	8ba6                	mv	s7,s1
      state = 0;
 956:	4981                	li	s3,0
        i += 2;
 958:	b579                	j	7e6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 95a:	008b8493          	addi	s1,s7,8
 95e:	4681                	li	a3,0
 960:	4641                	li	a2,16
 962:	000be583          	lwu	a1,0(s7)
 966:	855a                	mv	a0,s6
 968:	d93ff0ef          	jal	6fa <printint>
 96c:	8ba6                	mv	s7,s1
      state = 0;
 96e:	4981                	li	s3,0
 970:	bd9d                	j	7e6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 972:	008b8493          	addi	s1,s7,8
 976:	4681                	li	a3,0
 978:	4641                	li	a2,16
 97a:	000bb583          	ld	a1,0(s7)
 97e:	855a                	mv	a0,s6
 980:	d7bff0ef          	jal	6fa <printint>
        i += 1;
 984:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 986:	8ba6                	mv	s7,s1
      state = 0;
 988:	4981                	li	s3,0
 98a:	bdb1                	j	7e6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 98c:	008b8493          	addi	s1,s7,8
 990:	4641                	li	a2,16
 992:	000bb583          	ld	a1,0(s7)
 996:	855a                	mv	a0,s6
 998:	d63ff0ef          	jal	6fa <printint>
        i += 2;
 99c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 99e:	8ba6                	mv	s7,s1
      state = 0;
 9a0:	4981                	li	s3,0
        i += 2;
 9a2:	b591                	j	7e6 <vprintf+0x44>
 9a4:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 9a6:	008b8793          	addi	a5,s7,8
 9aa:	8cbe                	mv	s9,a5
 9ac:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9b0:	03000593          	li	a1,48
 9b4:	855a                	mv	a0,s6
 9b6:	d27ff0ef          	jal	6dc <putc>
  putc(fd, 'x');
 9ba:	07800593          	li	a1,120
 9be:	855a                	mv	a0,s6
 9c0:	d1dff0ef          	jal	6dc <putc>
 9c4:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9c6:	00000b97          	auipc	s7,0x0
 9ca:	4f2b8b93          	addi	s7,s7,1266 # eb8 <digits>
 9ce:	03c9d793          	srli	a5,s3,0x3c
 9d2:	97de                	add	a5,a5,s7
 9d4:	0007c583          	lbu	a1,0(a5)
 9d8:	855a                	mv	a0,s6
 9da:	d03ff0ef          	jal	6dc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9de:	0992                	slli	s3,s3,0x4
 9e0:	34fd                	addiw	s1,s1,-1
 9e2:	f4f5                	bnez	s1,9ce <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 9e4:	8be6                	mv	s7,s9
      state = 0;
 9e6:	4981                	li	s3,0
 9e8:	6ca2                	ld	s9,8(sp)
 9ea:	bbf5                	j	7e6 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 9ec:	008b8493          	addi	s1,s7,8
 9f0:	000bc583          	lbu	a1,0(s7)
 9f4:	855a                	mv	a0,s6
 9f6:	ce7ff0ef          	jal	6dc <putc>
 9fa:	8ba6                	mv	s7,s1
      state = 0;
 9fc:	4981                	li	s3,0
 9fe:	b3e5                	j	7e6 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 a00:	008b8993          	addi	s3,s7,8
 a04:	000bb483          	ld	s1,0(s7)
 a08:	cc91                	beqz	s1,a24 <vprintf+0x282>
        for(; *s; s++)
 a0a:	0004c583          	lbu	a1,0(s1)
 a0e:	c195                	beqz	a1,a32 <vprintf+0x290>
          putc(fd, *s);
 a10:	855a                	mv	a0,s6
 a12:	ccbff0ef          	jal	6dc <putc>
        for(; *s; s++)
 a16:	0485                	addi	s1,s1,1
 a18:	0004c583          	lbu	a1,0(s1)
 a1c:	f9f5                	bnez	a1,a10 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 a1e:	8bce                	mv	s7,s3
      state = 0;
 a20:	4981                	li	s3,0
 a22:	b3d1                	j	7e6 <vprintf+0x44>
          s = "(null)";
 a24:	00000497          	auipc	s1,0x0
 a28:	40448493          	addi	s1,s1,1028 # e28 <malloc+0x2d2>
        for(; *s; s++)
 a2c:	02800593          	li	a1,40
 a30:	b7c5                	j	a10 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 a32:	8bce                	mv	s7,s3
      state = 0;
 a34:	4981                	li	s3,0
 a36:	bb45                	j	7e6 <vprintf+0x44>
        putc(fd, '%');
 a38:	85be                	mv	a1,a5
 a3a:	855a                	mv	a0,s6
 a3c:	ca1ff0ef          	jal	6dc <putc>
 a40:	bdbd                	j	8be <vprintf+0x11c>
 a42:	6906                	ld	s2,64(sp)
 a44:	79e2                	ld	s3,56(sp)
 a46:	7a42                	ld	s4,48(sp)
 a48:	7aa2                	ld	s5,40(sp)
 a4a:	7b02                	ld	s6,32(sp)
 a4c:	6be2                	ld	s7,24(sp)
 a4e:	6c42                	ld	s8,16(sp)
    }
  }
}
 a50:	60e6                	ld	ra,88(sp)
 a52:	6446                	ld	s0,80(sp)
 a54:	64a6                	ld	s1,72(sp)
 a56:	6125                	addi	sp,sp,96
 a58:	8082                	ret
      if(c0 == 'd'){
 a5a:	06400713          	li	a4,100
 a5e:	e6e782e3          	beq	a5,a4,8c2 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 a62:	f9478693          	addi	a3,a5,-108
 a66:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 a6a:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 a6c:	4701                	li	a4,0
 a6e:	bbe9                	j	848 <vprintf+0xa6>

0000000000000a70 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a70:	715d                	addi	sp,sp,-80
 a72:	ec06                	sd	ra,24(sp)
 a74:	e822                	sd	s0,16(sp)
 a76:	1000                	addi	s0,sp,32
 a78:	e010                	sd	a2,0(s0)
 a7a:	e414                	sd	a3,8(s0)
 a7c:	e818                	sd	a4,16(s0)
 a7e:	ec1c                	sd	a5,24(s0)
 a80:	03043023          	sd	a6,32(s0)
 a84:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a88:	8622                	mv	a2,s0
 a8a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a8e:	d15ff0ef          	jal	7a2 <vprintf>
}
 a92:	60e2                	ld	ra,24(sp)
 a94:	6442                	ld	s0,16(sp)
 a96:	6161                	addi	sp,sp,80
 a98:	8082                	ret

0000000000000a9a <printf>:

void
printf(const char *fmt, ...)
{
 a9a:	711d                	addi	sp,sp,-96
 a9c:	ec06                	sd	ra,24(sp)
 a9e:	e822                	sd	s0,16(sp)
 aa0:	1000                	addi	s0,sp,32
 aa2:	e40c                	sd	a1,8(s0)
 aa4:	e810                	sd	a2,16(s0)
 aa6:	ec14                	sd	a3,24(s0)
 aa8:	f018                	sd	a4,32(s0)
 aaa:	f41c                	sd	a5,40(s0)
 aac:	03043823          	sd	a6,48(s0)
 ab0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ab4:	00840613          	addi	a2,s0,8
 ab8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 abc:	85aa                	mv	a1,a0
 abe:	4505                	li	a0,1
 ac0:	ce3ff0ef          	jal	7a2 <vprintf>
}
 ac4:	60e2                	ld	ra,24(sp)
 ac6:	6442                	ld	s0,16(sp)
 ac8:	6125                	addi	sp,sp,96
 aca:	8082                	ret

0000000000000acc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 acc:	1141                	addi	sp,sp,-16
 ace:	e406                	sd	ra,8(sp)
 ad0:	e022                	sd	s0,0(sp)
 ad2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ad4:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ad8:	00000797          	auipc	a5,0x0
 adc:	5287b783          	ld	a5,1320(a5) # 1000 <freep>
 ae0:	a095                	j	b44 <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 ae2:	ff852583          	lw	a1,-8(a0)
 ae6:	6390                	ld	a2,0(a5)
 ae8:	02059813          	slli	a6,a1,0x20
 aec:	01c85693          	srli	a3,a6,0x1c
 af0:	96ba                	add	a3,a3,a4
 af2:	02d60563          	beq	a2,a3,b1c <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 af6:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 afa:	4790                	lw	a2,8(a5)
 afc:	02061593          	slli	a1,a2,0x20
 b00:	01c5d693          	srli	a3,a1,0x1c
 b04:	96be                	add	a3,a3,a5
 b06:	02d70263          	beq	a4,a3,b2a <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 b0a:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b0c:	00000717          	auipc	a4,0x0
 b10:	4ef73a23          	sd	a5,1268(a4) # 1000 <freep>
}
 b14:	60a2                	ld	ra,8(sp)
 b16:	6402                	ld	s0,0(sp)
 b18:	0141                	addi	sp,sp,16
 b1a:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 b1c:	4614                	lw	a3,8(a2)
 b1e:	9ead                	addw	a3,a3,a1
 b20:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b24:	6394                	ld	a3,0(a5)
 b26:	6290                	ld	a2,0(a3)
 b28:	b7f9                	j	af6 <free+0x2a>
    p->s.size += bp->s.size;
 b2a:	ff852703          	lw	a4,-8(a0)
 b2e:	9f31                	addw	a4,a4,a2
 b30:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b32:	ff053703          	ld	a4,-16(a0)
 b36:	bfd1                	j	b0a <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b38:	6394                	ld	a3,0(a5)
 b3a:	00d7e463          	bltu	a5,a3,b42 <free+0x76>
 b3e:	fad762e3          	bltu	a4,a3,ae2 <free+0x16>
 b42:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b44:	fee7fae3          	bgeu	a5,a4,b38 <free+0x6c>
 b48:	6394                	ld	a3,0(a5)
 b4a:	f8d76ce3          	bltu	a4,a3,ae2 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b4e:	f8d7fae3          	bgeu	a5,a3,ae2 <free+0x16>
 b52:	87b6                	mv	a5,a3
 b54:	bfc5                	j	b44 <free+0x78>

0000000000000b56 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b56:	7139                	addi	sp,sp,-64
 b58:	fc06                	sd	ra,56(sp)
 b5a:	f822                	sd	s0,48(sp)
 b5c:	f04a                	sd	s2,32(sp)
 b5e:	ec4e                	sd	s3,24(sp)
 b60:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b62:	02051993          	slli	s3,a0,0x20
 b66:	0209d993          	srli	s3,s3,0x20
 b6a:	09bd                	addi	s3,s3,15
 b6c:	0049d993          	srli	s3,s3,0x4
 b70:	2985                	addiw	s3,s3,1
 b72:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 b74:	00000517          	auipc	a0,0x0
 b78:	48c53503          	ld	a0,1164(a0) # 1000 <freep>
 b7c:	c905                	beqz	a0,bac <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b7e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b80:	4798                	lw	a4,8(a5)
 b82:	09377663          	bgeu	a4,s3,c0e <malloc+0xb8>
 b86:	f426                	sd	s1,40(sp)
 b88:	e852                	sd	s4,16(sp)
 b8a:	e456                	sd	s5,8(sp)
 b8c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 b8e:	8a4e                	mv	s4,s3
 b90:	6705                	lui	a4,0x1
 b92:	00e9f363          	bgeu	s3,a4,b98 <malloc+0x42>
 b96:	6a05                	lui	s4,0x1
 b98:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b9c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ba0:	00000497          	auipc	s1,0x0
 ba4:	46048493          	addi	s1,s1,1120 # 1000 <freep>
  if(p == SBRK_ERROR)
 ba8:	5afd                	li	s5,-1
 baa:	a83d                	j	be8 <malloc+0x92>
 bac:	f426                	sd	s1,40(sp)
 bae:	e852                	sd	s4,16(sp)
 bb0:	e456                	sd	s5,8(sp)
 bb2:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 bb4:	00000797          	auipc	a5,0x0
 bb8:	45c78793          	addi	a5,a5,1116 # 1010 <base>
 bbc:	00000717          	auipc	a4,0x0
 bc0:	44f73223          	sd	a5,1092(a4) # 1000 <freep>
 bc4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 bc6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 bca:	b7d1                	j	b8e <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 bcc:	6398                	ld	a4,0(a5)
 bce:	e118                	sd	a4,0(a0)
 bd0:	a899                	j	c26 <malloc+0xd0>
  hp->s.size = nu;
 bd2:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 bd6:	0541                	addi	a0,a0,16
 bd8:	ef5ff0ef          	jal	acc <free>
  return freep;
 bdc:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 bde:	c125                	beqz	a0,c3e <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 be0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 be2:	4798                	lw	a4,8(a5)
 be4:	03277163          	bgeu	a4,s2,c06 <malloc+0xb0>
    if(p == freep)
 be8:	6098                	ld	a4,0(s1)
 bea:	853e                	mv	a0,a5
 bec:	fef71ae3          	bne	a4,a5,be0 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 bf0:	8552                	mv	a0,s4
 bf2:	a17ff0ef          	jal	608 <sbrk>
  if(p == SBRK_ERROR)
 bf6:	fd551ee3          	bne	a0,s5,bd2 <malloc+0x7c>
        return 0;
 bfa:	4501                	li	a0,0
 bfc:	74a2                	ld	s1,40(sp)
 bfe:	6a42                	ld	s4,16(sp)
 c00:	6aa2                	ld	s5,8(sp)
 c02:	6b02                	ld	s6,0(sp)
 c04:	a03d                	j	c32 <malloc+0xdc>
 c06:	74a2                	ld	s1,40(sp)
 c08:	6a42                	ld	s4,16(sp)
 c0a:	6aa2                	ld	s5,8(sp)
 c0c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 c0e:	fae90fe3          	beq	s2,a4,bcc <malloc+0x76>
        p->s.size -= nunits;
 c12:	4137073b          	subw	a4,a4,s3
 c16:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c18:	02071693          	slli	a3,a4,0x20
 c1c:	01c6d713          	srli	a4,a3,0x1c
 c20:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c22:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c26:	00000717          	auipc	a4,0x0
 c2a:	3ca73d23          	sd	a0,986(a4) # 1000 <freep>
      return (void*)(p + 1);
 c2e:	01078513          	addi	a0,a5,16
  }
}
 c32:	70e2                	ld	ra,56(sp)
 c34:	7442                	ld	s0,48(sp)
 c36:	7902                	ld	s2,32(sp)
 c38:	69e2                	ld	s3,24(sp)
 c3a:	6121                	addi	sp,sp,64
 c3c:	8082                	ret
 c3e:	74a2                	ld	s1,40(sp)
 c40:	6a42                	ld	s4,16(sp)
 c42:	6aa2                	ld	s5,8(sp)
 c44:	6b02                	ld	s6,0(sp)
 c46:	b7f5                	j	c32 <malloc+0xdc>
