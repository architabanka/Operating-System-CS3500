
user/_kalloctest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <ntas>:
  test4();
  exit(0);
}

int ntas(int print)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
   c:	892a                	mv	s2,a0
  int n;
  char *c;

  if (statistics(buf, SZ) <= 0) {
   e:	6585                	lui	a1,0x1
  10:	00002517          	auipc	a0,0x2
  14:	00050513          	mv	a0,a0
  18:	71b000ef          	jal	f32 <statistics>
  1c:	02a05763          	blez	a0,4a <ntas+0x4a>
    fprintf(2, "ntas: no stats\n");
  }
  c = strchr(buf, '=');
  20:	03d00593          	li	a1,61
  24:	00002517          	auipc	a0,0x2
  28:	fec50513          	addi	a0,a0,-20 # 2010 <buf>
  2c:	6b4000ef          	jal	6e0 <strchr>
  n = atoi(c+2);
  30:	0509                	addi	a0,a0,2
  32:	78c000ef          	jal	7be <atoi>
  36:	84aa                	mv	s1,a0
  if(print)
  38:	02091163          	bnez	s2,5a <ntas+0x5a>
    printf("%s", buf);
  return n;
}
  3c:	8526                	mv	a0,s1
  3e:	60e2                	ld	ra,24(sp)
  40:	6442                	ld	s0,16(sp)
  42:	64a2                	ld	s1,8(sp)
  44:	6902                	ld	s2,0(sp)
  46:	6105                	addi	sp,sp,32
  48:	8082                	ret
    fprintf(2, "ntas: no stats\n");
  4a:	00001597          	auipc	a1,0x1
  4e:	f6658593          	addi	a1,a1,-154 # fb0 <statistics+0x7e>
  52:	4509                	li	a0,2
  54:	507000ef          	jal	d5a <fprintf>
  58:	b7e1                	j	20 <ntas+0x20>
    printf("%s", buf);
  5a:	00002597          	auipc	a1,0x2
  5e:	fb658593          	addi	a1,a1,-74 # 2010 <buf>
  62:	00001517          	auipc	a0,0x1
  66:	f5e50513          	addi	a0,a0,-162 # fc0 <statistics+0x8e>
  6a:	51b000ef          	jal	d84 <printf>
  6e:	b7f9                	j	3c <ntas+0x3c>

0000000000000070 <test1>:

// Test concurrent kallocs and kfrees
void test1(void)
{
  70:	715d                	addi	sp,sp,-80
  72:	e486                	sd	ra,72(sp)
  74:	e0a2                	sd	s0,64(sp)
  76:	fc26                	sd	s1,56(sp)
  78:	0880                	addi	s0,sp,80
  void *a, *a1;
  int n, m;

  printf("start test1\n");  
  7a:	00001517          	auipc	a0,0x1
  7e:	f4e50513          	addi	a0,a0,-178 # fc8 <statistics+0x96>
  82:	503000ef          	jal	d84 <printf>
  m = ntas(0);
  86:	4501                	li	a0,0
  88:	f79ff0ef          	jal	0 <ntas>
  8c:	84aa                	mv	s1,a0
  for(int i = 0; i < NCHILD; i++){
    int pid = fork();
  8e:	04f000ef          	jal	8dc <fork>
    if(pid < 0){
  92:	04054c63          	bltz	a0,ea <test1+0x7a>
      printf("fork failed");
      exit(-1);
    }
    if(pid == 0){
  96:	c53d                	beqz	a0,104 <test1+0x94>
    int pid = fork();
  98:	045000ef          	jal	8dc <fork>
    if(pid < 0){
  9c:	04054763          	bltz	a0,ea <test1+0x7a>
    if(pid == 0){
  a0:	c135                	beqz	a0,104 <test1+0x94>
        }
      }
      exit(0);
    }
  }
  int status = 0;
  a2:	fa042e23          	sw	zero,-68(s0)
  for(int i = 0; i < NCHILD; i++){
    wait(&status);
  a6:	fbc40513          	addi	a0,s0,-68
  aa:	043000ef          	jal	8ec <wait>
    if (status != 0) {
  ae:	fbc42783          	lw	a5,-68(s0)
  b2:	efd1                	bnez	a5,14e <test1+0xde>
    wait(&status);
  b4:	fbc40513          	addi	a0,s0,-68
  b8:	035000ef          	jal	8ec <wait>
    if (status != 0) {
  bc:	fbc42783          	lw	a5,-68(s0)
  c0:	e7d9                	bnez	a5,14e <test1+0xde>
      printf("FAIL: a child failed\n");
      exit(1);
    }
  }
  printf("test1 results:\n");
  c2:	00001517          	auipc	a0,0x1
  c6:	f5650513          	addi	a0,a0,-170 # 1018 <statistics+0xe6>
  ca:	4bb000ef          	jal	d84 <printf>
  n = ntas(1);
  ce:	4505                	li	a0,1
  d0:	f31ff0ef          	jal	0 <ntas>
  if(n-m < 10) 
  d4:	9d05                	subw	a0,a0,s1
  d6:	47a5                	li	a5,9
  d8:	08a7c863          	blt	a5,a0,168 <test1+0xf8>
    printf("test1 OK\n");
  dc:	00001517          	auipc	a0,0x1
  e0:	f4c50513          	addi	a0,a0,-180 # 1028 <statistics+0xf6>
  e4:	4a1000ef          	jal	d84 <printf>
  e8:	a071                	j	174 <test1+0x104>
  ea:	f84a                	sd	s2,48(sp)
  ec:	f44e                	sd	s3,40(sp)
  ee:	f052                	sd	s4,32(sp)
  f0:	ec56                	sd	s5,24(sp)
      printf("fork failed");
  f2:	00001517          	auipc	a0,0x1
  f6:	ee650513          	addi	a0,a0,-282 # fd8 <statistics+0xa6>
  fa:	48b000ef          	jal	d84 <printf>
      exit(-1);
  fe:	557d                	li	a0,-1
 100:	7e4000ef          	jal	8e4 <exit>
 104:	f84a                	sd	s2,48(sp)
 106:	f44e                	sd	s3,40(sp)
 108:	f052                	sd	s4,32(sp)
 10a:	ec56                	sd	s5,24(sp)
{
 10c:	6961                	lui	s2,0x18
 10e:	6a090913          	addi	s2,s2,1696 # 186a0 <base+0x15690>
        a = sbrk(4096);
 112:	6985                	lui	s3,0x1
        *(int *)(a+4) = 1;
 114:	4a85                	li	s5,1
        a1 = sbrk(-4096);
 116:	7a7d                	lui	s4,0xfffff
        a = sbrk(4096);
 118:	854e                	mv	a0,s3
 11a:	796000ef          	jal	8b0 <sbrk>
 11e:	84aa                	mv	s1,a0
        *(int *)(a+4) = 1;
 120:	01552223          	sw	s5,4(a0)
        a1 = sbrk(-4096);
 124:	8552                	mv	a0,s4
 126:	78a000ef          	jal	8b0 <sbrk>
        if (a1 != a + 4096) {
 12a:	94ce                	add	s1,s1,s3
 12c:	00951863          	bne	a0,s1,13c <test1+0xcc>
      for(i = 0; i < N1; i++) {
 130:	397d                	addiw	s2,s2,-1
 132:	fe0913e3          	bnez	s2,118 <test1+0xa8>
      exit(0);
 136:	4501                	li	a0,0
 138:	7ac000ef          	jal	8e4 <exit>
          printf("test1: FAIL wrong sbrk\n");
 13c:	00001517          	auipc	a0,0x1
 140:	eac50513          	addi	a0,a0,-340 # fe8 <statistics+0xb6>
 144:	441000ef          	jal	d84 <printf>
          exit(1);
 148:	4505                	li	a0,1
 14a:	79a000ef          	jal	8e4 <exit>
 14e:	f84a                	sd	s2,48(sp)
 150:	f44e                	sd	s3,40(sp)
 152:	f052                	sd	s4,32(sp)
 154:	ec56                	sd	s5,24(sp)
      printf("FAIL: a child failed\n");
 156:	00001517          	auipc	a0,0x1
 15a:	eaa50513          	addi	a0,a0,-342 # 1000 <statistics+0xce>
 15e:	427000ef          	jal	d84 <printf>
      exit(1);
 162:	4505                	li	a0,1
 164:	780000ef          	jal	8e4 <exit>
  else
    printf("test1 FAIL\n");
 168:	00001517          	auipc	a0,0x1
 16c:	ed050513          	addi	a0,a0,-304 # 1038 <statistics+0x106>
 170:	415000ef          	jal	d84 <printf>
}
 174:	60a6                	ld	ra,72(sp)
 176:	6406                	ld	s0,64(sp)
 178:	74e2                	ld	s1,56(sp)
 17a:	6161                	addi	sp,sp,80
 17c:	8082                	ret

000000000000017e <countfree>:


// use sbrk() to count how many free physical memory pages there are.
int
countfree()
{
 17e:	7179                	addi	sp,sp,-48
 180:	f406                	sd	ra,40(sp)
 182:	f022                	sd	s0,32(sp)
 184:	ec26                	sd	s1,24(sp)
 186:	e84a                	sd	s2,16(sp)
 188:	e44e                	sd	s3,8(sp)
 18a:	e052                	sd	s4,0(sp)
 18c:	1800                	addi	s0,sp,48
  int n = 0;
  uint64 sz0 = (uint64)sbrk(0);
 18e:	4501                	li	a0,0
 190:	720000ef          	jal	8b0 <sbrk>
 194:	8a2a                	mv	s4,a0
  int n = 0;
 196:	4481                	li	s1,0
  while(1){
    char *a = sbrk(PGSIZE);
 198:	6985                	lui	s3,0x1
    if(a == SBRK_ERROR){
 19a:	597d                	li	s2,-1
    char *a = sbrk(PGSIZE);
 19c:	854e                	mv	a0,s3
 19e:	712000ef          	jal	8b0 <sbrk>
    if(a == SBRK_ERROR){
 1a2:	01250463          	beq	a0,s2,1aa <countfree+0x2c>
      break;
    }
    n += 1;
 1a6:	2485                	addiw	s1,s1,1
  while(1){
 1a8:	bfd5                	j	19c <countfree+0x1e>
  }
  sbrk(-((uint64)sbrk(0) - sz0));
 1aa:	4501                	li	a0,0
 1ac:	704000ef          	jal	8b0 <sbrk>
 1b0:	40aa053b          	subw	a0,s4,a0
 1b4:	6fc000ef          	jal	8b0 <sbrk>
  return n;
}
 1b8:	8526                	mv	a0,s1
 1ba:	70a2                	ld	ra,40(sp)
 1bc:	7402                	ld	s0,32(sp)
 1be:	64e2                	ld	s1,24(sp)
 1c0:	6942                	ld	s2,16(sp)
 1c2:	69a2                	ld	s3,8(sp)
 1c4:	6a02                	ld	s4,0(sp)
 1c6:	6145                	addi	sp,sp,48
 1c8:	8082                	ret

00000000000001ca <test2>:
void test2() {
 1ca:	715d                	addi	sp,sp,-80
 1cc:	e486                	sd	ra,72(sp)
 1ce:	e0a2                	sd	s0,64(sp)
 1d0:	fc26                	sd	s1,56(sp)
 1d2:	f84a                	sd	s2,48(sp)
 1d4:	f44e                	sd	s3,40(sp)
 1d6:	f052                	sd	s4,32(sp)
 1d8:	ec56                	sd	s5,24(sp)
 1da:	e85a                	sd	s6,16(sp)
 1dc:	e45e                	sd	s7,8(sp)
 1de:	e062                	sd	s8,0(sp)
 1e0:	0880                	addi	s0,sp,80
  int free0 = countfree();
 1e2:	f9dff0ef          	jal	17e <countfree>
 1e6:	84aa                	mv	s1,a0
  printf("start test2\n");  
 1e8:	00001517          	auipc	a0,0x1
 1ec:	e6050513          	addi	a0,a0,-416 # 1048 <statistics+0x116>
 1f0:	395000ef          	jal	d84 <printf>
  printf("total free number of pages: %d (out of %d)\n", free0, n);
 1f4:	6621                	lui	a2,0x8
 1f6:	85a6                	mv	a1,s1
 1f8:	00001517          	auipc	a0,0x1
 1fc:	e6050513          	addi	a0,a0,-416 # 1058 <statistics+0x126>
 200:	385000ef          	jal	d84 <printf>
  if (free0 < NPAGES2) {
 204:	07f00793          	li	a5,127
 208:	0297dd63          	bge	a5,s1,242 <test2+0x78>
  uint64 sz0 = (uint64) sbrk((free0 - NPAGES2) * PGSIZE);
 20c:	00c49513          	slli	a0,s1,0xc
 210:	fff807b7          	lui	a5,0xfff80
 214:	9d3d                	addw	a0,a0,a5
 216:	69a000ef          	jal	8b0 <sbrk>
 21a:	8c2a                	mv	s8,a0
  if (sz0 == (uint64) SBRK_ERROR) {
 21c:	57fd                	li	a5,-1
  for (int i = 0; i < N2; i++) {
 21e:	4901                	li	s2,0
  if (sz0 == (uint64) SBRK_ERROR) {
 220:	02f50a63          	beq	a0,a5,254 <test2+0x8a>
    if((i+1) % 100 == 0)
 224:	51eb89b7          	lui	s3,0x51eb8
 228:	51f98993          	addi	s3,s3,1311 # 51eb851f <base+0x51eb550f>
 22c:	06400a93          	li	s5,100
      printf(".");
 230:	00001b97          	auipc	s7,0x1
 234:	ea8b8b93          	addi	s7,s7,-344 # 10d8 <statistics+0x1a6>
    if(free1 != free0) {
 238:	08000a13          	li	s4,128
  for (int i = 0; i < N2; i++) {
 23c:	3e800b13          	li	s6,1000
 240:	a03d                	j	26e <test2+0xa4>
    printf("test2 FAILED: not enough free memory");
 242:	00001517          	auipc	a0,0x1
 246:	e4650513          	addi	a0,a0,-442 # 1088 <statistics+0x156>
 24a:	33b000ef          	jal	d84 <printf>
    exit(1);
 24e:	4505                	li	a0,1
 250:	694000ef          	jal	8e4 <exit>
    printf("test2 FAILED: cannot allocate memory");
 254:	00001517          	auipc	a0,0x1
 258:	e5c50513          	addi	a0,a0,-420 # 10b0 <statistics+0x17e>
 25c:	329000ef          	jal	d84 <printf>
    exit(1);
 260:	4505                	li	a0,1
 262:	682000ef          	jal	8e4 <exit>
    if(free1 != free0) {
 266:	03449863          	bne	s1,s4,296 <test2+0xcc>
  for (int i = 0; i < N2; i++) {
 26a:	05690263          	beq	s2,s6,2ae <test2+0xe4>
    free1 = countfree();
 26e:	f11ff0ef          	jal	17e <countfree>
 272:	84aa                	mv	s1,a0
    if((i+1) % 100 == 0)
 274:	0019071b          	addiw	a4,s2,1
 278:	893a                	mv	s2,a4
 27a:	033707b3          	mul	a5,a4,s3
 27e:	9795                	srai	a5,a5,0x25
 280:	41f7569b          	sraiw	a3,a4,0x1f
 284:	9f95                	subw	a5,a5,a3
 286:	02fa87bb          	mulw	a5,s5,a5
 28a:	9f1d                	subw	a4,a4,a5
 28c:	ff69                	bnez	a4,266 <test2+0x9c>
      printf(".");
 28e:	855e                	mv	a0,s7
 290:	2f5000ef          	jal	d84 <printf>
 294:	bfc9                	j	266 <test2+0x9c>
      printf("test2 FAIL: losing pages %d %d\n", free0, free1);
 296:	8626                	mv	a2,s1
 298:	08000593          	li	a1,128
 29c:	00001517          	auipc	a0,0x1
 2a0:	e4450513          	addi	a0,a0,-444 # 10e0 <statistics+0x1ae>
 2a4:	2e1000ef          	jal	d84 <printf>
      exit(1);
 2a8:	4505                	li	a0,1
 2aa:	63a000ef          	jal	8e4 <exit>
  sbrk(-((uint64)sbrk(0) - sz0));
 2ae:	4501                	li	a0,0
 2b0:	600000ef          	jal	8b0 <sbrk>
 2b4:	40ac053b          	subw	a0,s8,a0
 2b8:	5f8000ef          	jal	8b0 <sbrk>
  printf("\ntest2 OK\n");  
 2bc:	00001517          	auipc	a0,0x1
 2c0:	e4450513          	addi	a0,a0,-444 # 1100 <statistics+0x1ce>
 2c4:	2c1000ef          	jal	d84 <printf>
}
 2c8:	60a6                	ld	ra,72(sp)
 2ca:	6406                	ld	s0,64(sp)
 2cc:	74e2                	ld	s1,56(sp)
 2ce:	7942                	ld	s2,48(sp)
 2d0:	79a2                	ld	s3,40(sp)
 2d2:	7a02                	ld	s4,32(sp)
 2d4:	6ae2                	ld	s5,24(sp)
 2d6:	6b42                	ld	s6,16(sp)
 2d8:	6ba2                	ld	s7,8(sp)
 2da:	6c02                	ld	s8,0(sp)
 2dc:	6161                	addi	sp,sp,80
 2de:	8082                	ret

00000000000002e0 <test3>:
{
 2e0:	7139                	addi	sp,sp,-64
 2e2:	fc06                	sd	ra,56(sp)
 2e4:	f822                	sd	s0,48(sp)
 2e6:	f426                	sd	s1,40(sp)
 2e8:	f04a                	sd	s2,32(sp)
 2ea:	0080                	addi	s0,sp,64
  printf("start test3\n");
 2ec:	00001517          	auipc	a0,0x1
 2f0:	e2450513          	addi	a0,a0,-476 # 1110 <statistics+0x1de>
 2f4:	291000ef          	jal	d84 <printf>
  int free0 = countfree();
 2f8:	e87ff0ef          	jal	17e <countfree>
 2fc:	892a                	mv	s2,a0
    pid = fork();
 2fe:	5de000ef          	jal	8dc <fork>
    if(pid < 0){
 302:	04054b63          	bltz	a0,358 <test3+0x78>
    if(pid == 0){
 306:	c525                	beqz	a0,36e <test3+0x8e>
    pid = fork();
 308:	5d4000ef          	jal	8dc <fork>
 30c:	84aa                	mv	s1,a0
    if(pid < 0){
 30e:	04054563          	bltz	a0,358 <test3+0x78>
    if(pid == 0){
 312:	0c050d63          	beqz	a0,3ec <test3+0x10c>
  int status = 0;
 316:	fc042623          	sw	zero,-52(s0)
    wait(&status);
 31a:	fcc40513          	addi	a0,s0,-52
 31e:	5ce000ef          	jal	8ec <wait>
    if (status != 0) {
 322:	fcc42783          	lw	a5,-52(s0)
 326:	0c079663          	bnez	a5,3f2 <test3+0x112>
  kill(pid);
 32a:	8526                	mv	a0,s1
 32c:	5e8000ef          	jal	914 <kill>
  wait(&status);
 330:	fcc40513          	addi	a0,s0,-52
 334:	5b8000ef          	jal	8ec <wait>
  int free1 = countfree();
 338:	e47ff0ef          	jal	17e <countfree>
  if (free0 != free1) {
 33c:	0ca91663          	bne	s2,a0,408 <test3+0x128>
  printf("\ntest3 OK\n");
 340:	00001517          	auipc	a0,0x1
 344:	e2050513          	addi	a0,a0,-480 # 1160 <statistics+0x22e>
 348:	23d000ef          	jal	d84 <printf>
}
 34c:	70e2                	ld	ra,56(sp)
 34e:	7442                	ld	s0,48(sp)
 350:	74a2                	ld	s1,40(sp)
 352:	7902                	ld	s2,32(sp)
 354:	6121                	addi	sp,sp,64
 356:	8082                	ret
 358:	ec4e                	sd	s3,24(sp)
 35a:	e852                	sd	s4,16(sp)
      printf("fork failed");
 35c:	00001517          	auipc	a0,0x1
 360:	c7c50513          	addi	a0,a0,-900 # fd8 <statistics+0xa6>
 364:	221000ef          	jal	d84 <printf>
      exit(-1);
 368:	557d                	li	a0,-1
 36a:	57a000ef          	jal	8e4 <exit>
 36e:	ec4e                	sd	s3,24(sp)
 370:	e852                	sd	s4,16(sp)
    if(pid == 0){
 372:	4485                	li	s1,1
          if ((i + 1) % 1000 == 0) {
 374:	106259b7          	lui	s3,0x10625
 378:	dd398993          	addi	s3,s3,-557 # 10624dd3 <base+0x10621dc3>
 37c:	3e800a13          	li	s4,1000
        for(i = 0; i < N3; i++) {
 380:	6909                	lui	s2,0x2
 382:	71190913          	addi	s2,s2,1809 # 2711 <buf+0x701>
 386:	a811                	j	39a <test3+0xba>
            sbrk(4096);
 388:	6505                	lui	a0,0x1
 38a:	526000ef          	jal	8b0 <sbrk>
            exit(0);
 38e:	4501                	li	a0,0
 390:	554000ef          	jal	8e4 <exit>
        for(i = 0; i < N3; i++) {
 394:	2485                	addiw	s1,s1,1
 396:	03248f63          	beq	s1,s2,3d4 <test3+0xf4>
          int cpid = fork();
 39a:	542000ef          	jal	8dc <fork>
          if (cpid < 0) {
 39e:	fe054be3          	bltz	a0,394 <test3+0xb4>
          if (cpid == 0) {
 3a2:	d17d                	beqz	a0,388 <test3+0xa8>
          int status = 0;
 3a4:	fc042423          	sw	zero,-56(s0)
          wait(&status);
 3a8:	fc840513          	addi	a0,s0,-56
 3ac:	540000ef          	jal	8ec <wait>
          if ((i + 1) % 1000 == 0) {
 3b0:	033487b3          	mul	a5,s1,s3
 3b4:	9799                	srai	a5,a5,0x26
 3b6:	41f4d71b          	sraiw	a4,s1,0x1f
 3ba:	9f99                	subw	a5,a5,a4
 3bc:	02fa07bb          	mulw	a5,s4,a5
 3c0:	40f487bb          	subw	a5,s1,a5
 3c4:	fbe1                	bnez	a5,394 <test3+0xb4>
            printf(".");
 3c6:	00001517          	auipc	a0,0x1
 3ca:	d1250513          	addi	a0,a0,-750 # 10d8 <statistics+0x1a6>
 3ce:	1b7000ef          	jal	d84 <printf>
 3d2:	b7c9                	j	394 <test3+0xb4>
        printf("child done %d\n", i);
 3d4:	6589                	lui	a1,0x2
 3d6:	71058593          	addi	a1,a1,1808 # 2710 <buf+0x700>
 3da:	00001517          	auipc	a0,0x1
 3de:	d4650513          	addi	a0,a0,-698 # 1120 <statistics+0x1ee>
 3e2:	1a3000ef          	jal	d84 <printf>
        exit(0);
 3e6:	4501                	li	a0,0
 3e8:	4fc000ef          	jal	8e4 <exit>
          countfree();
 3ec:	d93ff0ef          	jal	17e <countfree>
        while (1) {
 3f0:	bff5                	j	3ec <test3+0x10c>
 3f2:	ec4e                	sd	s3,24(sp)
 3f4:	e852                	sd	s4,16(sp)
      printf("a child failed\n");
 3f6:	00001517          	auipc	a0,0x1
 3fa:	d3a50513          	addi	a0,a0,-710 # 1130 <statistics+0x1fe>
 3fe:	187000ef          	jal	d84 <printf>
      exit(1);
 402:	4505                	li	a0,1
 404:	4e0000ef          	jal	8e4 <exit>
 408:	ec4e                	sd	s3,24(sp)
 40a:	e852                	sd	s4,16(sp)
    printf("test3 FAIL: losing pages %d %d\n", free0, free1);
 40c:	862a                	mv	a2,a0
 40e:	85ca                	mv	a1,s2
 410:	00001517          	auipc	a0,0x1
 414:	d3050513          	addi	a0,a0,-720 # 1140 <statistics+0x20e>
 418:	16d000ef          	jal	d84 <printf>
    exit(1);
 41c:	4505                	li	a0,1
 41e:	4c6000ef          	jal	8e4 <exit>

0000000000000422 <test4>:
{
 422:	7159                	addi	sp,sp,-112
 424:	f486                	sd	ra,104(sp)
 426:	f0a2                	sd	s0,96(sp)
 428:	e8ca                	sd	s2,80(sp)
 42a:	e4ce                	sd	s3,72(sp)
 42c:	e0d2                	sd	s4,64(sp)
 42e:	fc56                	sd	s5,56(sp)
 430:	1880                	addi	s0,sp,112
  m = ntas(0);
 432:	4501                	li	a0,0
 434:	bcdff0ef          	jal	0 <ntas>
 438:	8a2a                	mv	s4,a0
  printf("start test4\n");
 43a:	00001517          	auipc	a0,0x1
 43e:	d3650513          	addi	a0,a0,-714 # 1170 <statistics+0x23e>
 442:	143000ef          	jal	d84 <printf>
  int npages = countfree();
 446:	d39ff0ef          	jal	17e <countfree>
 44a:	8aaa                	mv	s5,a0
  if (npages < 100) {
 44c:	06300793          	li	a5,99
  for(int i = 0; i < NCHILD4; i++){
 450:	4901                	li	s2,0
 452:	4991                	li	s3,4
  if (npages < 100) {
 454:	06a7d463          	bge	a5,a0,4bc <test4+0x9a>
 458:	eca6                	sd	s1,88(sp)
    pid = fork();
 45a:	482000ef          	jal	8dc <fork>
 45e:	84aa                	mv	s1,a0
    if(pid < 0){
 460:	06054d63          	bltz	a0,4da <test4+0xb8>
    if(pid == 0){
 464:	c941                	beqz	a0,4f4 <test4+0xd2>
  for(int i = 0; i < NCHILD4; i++){
 466:	2905                	addiw	s2,s2,1
 468:	ff3919e3          	bne	s2,s3,45a <test4+0x38>
  int status = 0;
 46c:	f8042e23          	sw	zero,-100(s0)
 470:	490d                	li	s2,3
    wait(&status);
 472:	f9c40993          	addi	s3,s0,-100
 476:	854e                	mv	a0,s3
 478:	474000ef          	jal	8ec <wait>
    if (status != 0) {
 47c:	f9c42783          	lw	a5,-100(s0)
 480:	14079b63          	bnez	a5,5d6 <test4+0x1b4>
  for(int i = 0; i < NCHILD4-1; i++){
 484:	397d                	addiw	s2,s2,-1
 486:	fe0918e3          	bnez	s2,476 <test4+0x54>
  kill(pid);
 48a:	8526                	mv	a0,s1
 48c:	488000ef          	jal	914 <kill>
  wait(&status);
 490:	f9c40513          	addi	a0,s0,-100
 494:	458000ef          	jal	8ec <wait>
  n = ntas(1);
 498:	4505                	li	a0,1
 49a:	b67ff0ef          	jal	0 <ntas>
 49e:	862a                	mv	a2,a0
  if(n-m < (NCHILD4-1)*10000)
 4a0:	4145073b          	subw	a4,a0,s4
 4a4:	679d                	lui	a5,0x7
 4a6:	52f78793          	addi	a5,a5,1327 # 752f <base+0x451f>
 4aa:	14e7c363          	blt	a5,a4,5f0 <test4+0x1ce>
    printf("\ntest4 OK\n");
 4ae:	00001517          	auipc	a0,0x1
 4b2:	d2a50513          	addi	a0,a0,-726 # 11d8 <statistics+0x2a6>
 4b6:	0cf000ef          	jal	d84 <printf>
 4ba:	a291                	j	5fe <test4+0x1dc>
 4bc:	eca6                	sd	s1,88(sp)
 4be:	f85a                	sd	s6,48(sp)
 4c0:	f45e                	sd	s7,40(sp)
 4c2:	f062                	sd	s8,32(sp)
 4c4:	ec66                	sd	s9,24(sp)
    printf("too few pages: %d\n", npages);
 4c6:	85aa                	mv	a1,a0
 4c8:	00001517          	auipc	a0,0x1
 4cc:	cb850513          	addi	a0,a0,-840 # 1180 <statistics+0x24e>
 4d0:	0b5000ef          	jal	d84 <printf>
    exit(-1);
 4d4:	557d                	li	a0,-1
 4d6:	40e000ef          	jal	8e4 <exit>
 4da:	f85a                	sd	s6,48(sp)
 4dc:	f45e                	sd	s7,40(sp)
 4de:	f062                	sd	s8,32(sp)
 4e0:	ec66                	sd	s9,24(sp)
      printf("fork failed");
 4e2:	00001517          	auipc	a0,0x1
 4e6:	af650513          	addi	a0,a0,-1290 # fd8 <statistics+0xa6>
 4ea:	09b000ef          	jal	d84 <printf>
      exit(-1);
 4ee:	557d                	li	a0,-1
 4f0:	3f4000ef          	jal	8e4 <exit>
      cpupin(i);
 4f4:	854a                	mv	a0,s2
 4f6:	4ce000ef          	jal	9c4 <cpupin>
      if (i < NCHILD4-1) {
 4fa:	4789                	li	a5,2
 4fc:	4485                	li	s1,1
 4fe:	0327c663          	blt	a5,s2,52a <test4+0x108>
 502:	f85a                	sd	s6,48(sp)
 504:	f45e                	sd	s7,40(sp)
 506:	f062                	sd	s8,32(sp)
 508:	ec66                	sd	s9,24(sp)
          a = (uint64) sbrk(4096);
 50a:	6905                	lui	s2,0x1
          if(a == 0xffffffffffffffff){
 50c:	59fd                	li	s3,-1
          *(int *)(a+4) = 1;
 50e:	8ba6                	mv	s7,s1
          a1 = (uint64) sbrk(-4096);
 510:	7b7d                	lui	s6,0xfffff
          if ((i + 1) % 10000 == 0) {
 512:	68db9ab7          	lui	s5,0x68db9
 516:	bada8a93          	addi	s5,s5,-1107 # 68db8bad <base+0x68db5b9d>
 51a:	6a09                	lui	s4,0x2
 51c:	710a0a1b          	addiw	s4,s4,1808 # 2710 <buf+0x700>
            printf(".");
 520:	00001c17          	auipc	s8,0x1
 524:	bb8c0c13          	addi	s8,s8,-1096 # 10d8 <statistics+0x1a6>
 528:	a825                	j	560 <test4+0x13e>
 52a:	f85a                	sd	s6,48(sp)
 52c:	f45e                	sd	s7,40(sp)
 52e:	f062                	sd	s8,32(sp)
 530:	ec66                	sd	s9,24(sp)
  npages -= (NCHILD4-1)*100;
 532:	ed4a8a9b          	addiw	s5,s5,-300
          a = (uint64) sbrk(npages*4096);
 536:	00ca949b          	slliw	s1,s5,0xc
 53a:	409009bb          	negw	s3,s1
          if(a == 0xffffffffffffffff){
 53e:	597d                	li	s2,-1
 540:	a8a5                	j	5b8 <test4+0x196>
            printf("test3 FAIL: wrong sbrk\n");
 542:	00001517          	auipc	a0,0x1
 546:	c5650513          	addi	a0,a0,-938 # 1198 <statistics+0x266>
 54a:	03b000ef          	jal	d84 <printf>
            exit(1);
 54e:	4505                	li	a0,1
 550:	394000ef          	jal	8e4 <exit>
        for(i = 0; i < N4; i++) {
 554:	2485                	addiw	s1,s1,1
 556:	67e1                	lui	a5,0x18
 558:	6a178793          	addi	a5,a5,1697 # 186a1 <base+0x15691>
 55c:	02f48f63          	beq	s1,a5,59a <test4+0x178>
          a = (uint64) sbrk(4096);
 560:	854a                	mv	a0,s2
 562:	34e000ef          	jal	8b0 <sbrk>
 566:	8caa                	mv	s9,a0
          if(a == 0xffffffffffffffff){
 568:	ff3506e3          	beq	a0,s3,554 <test4+0x132>
          *(int *)(a+4) = 1;
 56c:	01752223          	sw	s7,4(a0)
          a1 = (uint64) sbrk(-4096);
 570:	855a                	mv	a0,s6
 572:	33e000ef          	jal	8b0 <sbrk>
          if (a1 != a + 4096) {
 576:	9cca                	add	s9,s9,s2
 578:	fd9515e3          	bne	a0,s9,542 <test4+0x120>
          if ((i + 1) % 10000 == 0) {
 57c:	035487b3          	mul	a5,s1,s5
 580:	97b1                	srai	a5,a5,0x2c
 582:	41f4d71b          	sraiw	a4,s1,0x1f
 586:	9f99                	subw	a5,a5,a4
 588:	02fa07bb          	mulw	a5,s4,a5
 58c:	40f487bb          	subw	a5,s1,a5
 590:	f3f1                	bnez	a5,554 <test4+0x132>
            printf(".");
 592:	8562                	mv	a0,s8
 594:	7f0000ef          	jal	d84 <printf>
 598:	bf75                	j	554 <test4+0x132>
        printf("child done %d\n", i);
 59a:	65e1                	lui	a1,0x18
 59c:	6a058593          	addi	a1,a1,1696 # 186a0 <base+0x15690>
 5a0:	00001517          	auipc	a0,0x1
 5a4:	b8050513          	addi	a0,a0,-1152 # 1120 <statistics+0x1ee>
 5a8:	7dc000ef          	jal	d84 <printf>
        exit(0);
 5ac:	4501                	li	a0,0
 5ae:	336000ef          	jal	8e4 <exit>
          sbrk(-npages*4096);
 5b2:	854e                	mv	a0,s3
 5b4:	2fc000ef          	jal	8b0 <sbrk>
          a = (uint64) sbrk(npages*4096);
 5b8:	8526                	mv	a0,s1
 5ba:	2f6000ef          	jal	8b0 <sbrk>
          if(a == 0xffffffffffffffff){
 5be:	ff251ae3          	bne	a0,s2,5b2 <test4+0x190>
            printf("test4 FAIL: cannot allocate %d pages\n", npages);
 5c2:	85d6                	mv	a1,s5
 5c4:	00001517          	auipc	a0,0x1
 5c8:	bec50513          	addi	a0,a0,-1044 # 11b0 <statistics+0x27e>
 5cc:	7b8000ef          	jal	d84 <printf>
            exit(1);
 5d0:	4505                	li	a0,1
 5d2:	312000ef          	jal	8e4 <exit>
 5d6:	f85a                	sd	s6,48(sp)
 5d8:	f45e                	sd	s7,40(sp)
 5da:	f062                	sd	s8,32(sp)
 5dc:	ec66                	sd	s9,24(sp)
      printf("a child failed\n");
 5de:	00001517          	auipc	a0,0x1
 5e2:	b5250513          	addi	a0,a0,-1198 # 1130 <statistics+0x1fe>
 5e6:	79e000ef          	jal	d84 <printf>
      exit(1);
 5ea:	4505                	li	a0,1
 5ec:	2f8000ef          	jal	8e4 <exit>
    printf("test4 FAIL m %d n %d\n", m, n);
 5f0:	85d2                	mv	a1,s4
 5f2:	00001517          	auipc	a0,0x1
 5f6:	bf650513          	addi	a0,a0,-1034 # 11e8 <statistics+0x2b6>
 5fa:	78a000ef          	jal	d84 <printf>
 5fe:	64e6                	ld	s1,88(sp)
}
 600:	70a6                	ld	ra,104(sp)
 602:	7406                	ld	s0,96(sp)
 604:	6946                	ld	s2,80(sp)
 606:	69a6                	ld	s3,72(sp)
 608:	6a06                	ld	s4,64(sp)
 60a:	7ae2                	ld	s5,56(sp)
 60c:	6165                	addi	sp,sp,112
 60e:	8082                	ret

0000000000000610 <main>:
{
 610:	1141                	addi	sp,sp,-16
 612:	e406                	sd	ra,8(sp)
 614:	e022                	sd	s0,0(sp)
 616:	0800                	addi	s0,sp,16
  test1();
 618:	a59ff0ef          	jal	70 <test1>
  test2();
 61c:	bafff0ef          	jal	1ca <test2>
  test3();
 620:	cc1ff0ef          	jal	2e0 <test3>
  test4();
 624:	dffff0ef          	jal	422 <test4>
  exit(0);
 628:	4501                	li	a0,0
 62a:	2ba000ef          	jal	8e4 <exit>

000000000000062e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 62e:	1141                	addi	sp,sp,-16
 630:	e406                	sd	ra,8(sp)
 632:	e022                	sd	s0,0(sp)
 634:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 636:	fdbff0ef          	jal	610 <main>
  exit(r);
 63a:	2aa000ef          	jal	8e4 <exit>

000000000000063e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 63e:	1141                	addi	sp,sp,-16
 640:	e406                	sd	ra,8(sp)
 642:	e022                	sd	s0,0(sp)
 644:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 646:	87aa                	mv	a5,a0
 648:	0585                	addi	a1,a1,1
 64a:	0785                	addi	a5,a5,1
 64c:	fff5c703          	lbu	a4,-1(a1)
 650:	fee78fa3          	sb	a4,-1(a5)
 654:	fb75                	bnez	a4,648 <strcpy+0xa>
    ;
  return os;
}
 656:	60a2                	ld	ra,8(sp)
 658:	6402                	ld	s0,0(sp)
 65a:	0141                	addi	sp,sp,16
 65c:	8082                	ret

000000000000065e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 65e:	1141                	addi	sp,sp,-16
 660:	e406                	sd	ra,8(sp)
 662:	e022                	sd	s0,0(sp)
 664:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 666:	00054783          	lbu	a5,0(a0)
 66a:	cb91                	beqz	a5,67e <strcmp+0x20>
 66c:	0005c703          	lbu	a4,0(a1)
 670:	00f71763          	bne	a4,a5,67e <strcmp+0x20>
    p++, q++;
 674:	0505                	addi	a0,a0,1
 676:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 678:	00054783          	lbu	a5,0(a0)
 67c:	fbe5                	bnez	a5,66c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 67e:	0005c503          	lbu	a0,0(a1)
}
 682:	40a7853b          	subw	a0,a5,a0
 686:	60a2                	ld	ra,8(sp)
 688:	6402                	ld	s0,0(sp)
 68a:	0141                	addi	sp,sp,16
 68c:	8082                	ret

000000000000068e <strlen>:

uint
strlen(const char *s)
{
 68e:	1141                	addi	sp,sp,-16
 690:	e406                	sd	ra,8(sp)
 692:	e022                	sd	s0,0(sp)
 694:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 696:	00054783          	lbu	a5,0(a0)
 69a:	cf91                	beqz	a5,6b6 <strlen+0x28>
 69c:	00150793          	addi	a5,a0,1
 6a0:	86be                	mv	a3,a5
 6a2:	0785                	addi	a5,a5,1
 6a4:	fff7c703          	lbu	a4,-1(a5)
 6a8:	ff65                	bnez	a4,6a0 <strlen+0x12>
 6aa:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 6ae:	60a2                	ld	ra,8(sp)
 6b0:	6402                	ld	s0,0(sp)
 6b2:	0141                	addi	sp,sp,16
 6b4:	8082                	ret
  for(n = 0; s[n]; n++)
 6b6:	4501                	li	a0,0
 6b8:	bfdd                	j	6ae <strlen+0x20>

00000000000006ba <memset>:

void*
memset(void *dst, int c, uint n)
{
 6ba:	1141                	addi	sp,sp,-16
 6bc:	e406                	sd	ra,8(sp)
 6be:	e022                	sd	s0,0(sp)
 6c0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 6c2:	ca19                	beqz	a2,6d8 <memset+0x1e>
 6c4:	87aa                	mv	a5,a0
 6c6:	1602                	slli	a2,a2,0x20
 6c8:	9201                	srli	a2,a2,0x20
 6ca:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 6ce:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 6d2:	0785                	addi	a5,a5,1
 6d4:	fee79de3          	bne	a5,a4,6ce <memset+0x14>
  }
  return dst;
}
 6d8:	60a2                	ld	ra,8(sp)
 6da:	6402                	ld	s0,0(sp)
 6dc:	0141                	addi	sp,sp,16
 6de:	8082                	ret

00000000000006e0 <strchr>:

char*
strchr(const char *s, char c)
{
 6e0:	1141                	addi	sp,sp,-16
 6e2:	e406                	sd	ra,8(sp)
 6e4:	e022                	sd	s0,0(sp)
 6e6:	0800                	addi	s0,sp,16
  for(; *s; s++)
 6e8:	00054783          	lbu	a5,0(a0)
 6ec:	c799                	beqz	a5,6fa <strchr+0x1a>
    if(*s == c)
 6ee:	00f58763          	beq	a1,a5,6fc <strchr+0x1c>
  for(; *s; s++)
 6f2:	0505                	addi	a0,a0,1
 6f4:	00054783          	lbu	a5,0(a0)
 6f8:	fbfd                	bnez	a5,6ee <strchr+0xe>
      return (char*)s;
  return 0;
 6fa:	4501                	li	a0,0
}
 6fc:	60a2                	ld	ra,8(sp)
 6fe:	6402                	ld	s0,0(sp)
 700:	0141                	addi	sp,sp,16
 702:	8082                	ret

0000000000000704 <gets>:

char*
gets(char *buf, int max)
{
 704:	711d                	addi	sp,sp,-96
 706:	ec86                	sd	ra,88(sp)
 708:	e8a2                	sd	s0,80(sp)
 70a:	e4a6                	sd	s1,72(sp)
 70c:	e0ca                	sd	s2,64(sp)
 70e:	fc4e                	sd	s3,56(sp)
 710:	f852                	sd	s4,48(sp)
 712:	f456                	sd	s5,40(sp)
 714:	f05a                	sd	s6,32(sp)
 716:	ec5e                	sd	s7,24(sp)
 718:	e862                	sd	s8,16(sp)
 71a:	1080                	addi	s0,sp,96
 71c:	8baa                	mv	s7,a0
 71e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 720:	892a                	mv	s2,a0
 722:	4481                	li	s1,0
    cc = read(0, &c, 1);
 724:	faf40b13          	addi	s6,s0,-81
 728:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 72a:	8c26                	mv	s8,s1
 72c:	0014899b          	addiw	s3,s1,1
 730:	84ce                	mv	s1,s3
 732:	0349d863          	bge	s3,s4,762 <gets+0x5e>
    cc = read(0, &c, 1);
 736:	8656                	mv	a2,s5
 738:	85da                	mv	a1,s6
 73a:	4501                	li	a0,0
 73c:	1c0000ef          	jal	8fc <read>
    if(cc < 1)
 740:	02a05163          	blez	a0,762 <gets+0x5e>
      break;
    buf[i++] = c;
 744:	faf44783          	lbu	a5,-81(s0)
 748:	00f90023          	sb	a5,0(s2) # 1000 <statistics+0xce>
    if(c == '\n' || c == '\r')
 74c:	0905                	addi	s2,s2,1
 74e:	ff678713          	addi	a4,a5,-10
 752:	00173713          	seqz	a4,a4
 756:	17cd                	addi	a5,a5,-13
 758:	0017b793          	seqz	a5,a5
 75c:	8fd9                	or	a5,a5,a4
 75e:	d7f1                	beqz	a5,72a <gets+0x26>
    buf[i++] = c;
 760:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 762:	9c5e                	add	s8,s8,s7
 764:	000c0023          	sb	zero,0(s8)
  return buf;
}
 768:	855e                	mv	a0,s7
 76a:	60e6                	ld	ra,88(sp)
 76c:	6446                	ld	s0,80(sp)
 76e:	64a6                	ld	s1,72(sp)
 770:	6906                	ld	s2,64(sp)
 772:	79e2                	ld	s3,56(sp)
 774:	7a42                	ld	s4,48(sp)
 776:	7aa2                	ld	s5,40(sp)
 778:	7b02                	ld	s6,32(sp)
 77a:	6be2                	ld	s7,24(sp)
 77c:	6c42                	ld	s8,16(sp)
 77e:	6125                	addi	sp,sp,96
 780:	8082                	ret

0000000000000782 <stat>:

int
stat(const char *n, struct stat *st)
{
 782:	1101                	addi	sp,sp,-32
 784:	ec06                	sd	ra,24(sp)
 786:	e822                	sd	s0,16(sp)
 788:	e04a                	sd	s2,0(sp)
 78a:	1000                	addi	s0,sp,32
 78c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 78e:	4581                	li	a1,0
 790:	194000ef          	jal	924 <open>
  if(fd < 0)
 794:	02054263          	bltz	a0,7b8 <stat+0x36>
 798:	e426                	sd	s1,8(sp)
 79a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 79c:	85ca                	mv	a1,s2
 79e:	19e000ef          	jal	93c <fstat>
 7a2:	892a                	mv	s2,a0
  close(fd);
 7a4:	8526                	mv	a0,s1
 7a6:	166000ef          	jal	90c <close>
  return r;
 7aa:	64a2                	ld	s1,8(sp)
}
 7ac:	854a                	mv	a0,s2
 7ae:	60e2                	ld	ra,24(sp)
 7b0:	6442                	ld	s0,16(sp)
 7b2:	6902                	ld	s2,0(sp)
 7b4:	6105                	addi	sp,sp,32
 7b6:	8082                	ret
    return -1;
 7b8:	57fd                	li	a5,-1
 7ba:	893e                	mv	s2,a5
 7bc:	bfc5                	j	7ac <stat+0x2a>

00000000000007be <atoi>:

int
atoi(const char *s)
{
 7be:	1141                	addi	sp,sp,-16
 7c0:	e406                	sd	ra,8(sp)
 7c2:	e022                	sd	s0,0(sp)
 7c4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 7c6:	00054683          	lbu	a3,0(a0)
 7ca:	fd06879b          	addiw	a5,a3,-48
 7ce:	0ff7f793          	zext.b	a5,a5
 7d2:	4625                	li	a2,9
 7d4:	02f66963          	bltu	a2,a5,806 <atoi+0x48>
 7d8:	872a                	mv	a4,a0
  n = 0;
 7da:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 7dc:	0705                	addi	a4,a4,1
 7de:	0025179b          	slliw	a5,a0,0x2
 7e2:	9fa9                	addw	a5,a5,a0
 7e4:	0017979b          	slliw	a5,a5,0x1
 7e8:	9fb5                	addw	a5,a5,a3
 7ea:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 7ee:	00074683          	lbu	a3,0(a4)
 7f2:	fd06879b          	addiw	a5,a3,-48
 7f6:	0ff7f793          	zext.b	a5,a5
 7fa:	fef671e3          	bgeu	a2,a5,7dc <atoi+0x1e>
  return n;
}
 7fe:	60a2                	ld	ra,8(sp)
 800:	6402                	ld	s0,0(sp)
 802:	0141                	addi	sp,sp,16
 804:	8082                	ret
  n = 0;
 806:	4501                	li	a0,0
 808:	bfdd                	j	7fe <atoi+0x40>

000000000000080a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 80a:	1141                	addi	sp,sp,-16
 80c:	e406                	sd	ra,8(sp)
 80e:	e022                	sd	s0,0(sp)
 810:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 812:	02b57563          	bgeu	a0,a1,83c <memmove+0x32>
    while(n-- > 0)
 816:	00c05f63          	blez	a2,834 <memmove+0x2a>
 81a:	1602                	slli	a2,a2,0x20
 81c:	9201                	srli	a2,a2,0x20
 81e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 822:	872a                	mv	a4,a0
      *dst++ = *src++;
 824:	0585                	addi	a1,a1,1
 826:	0705                	addi	a4,a4,1
 828:	fff5c683          	lbu	a3,-1(a1)
 82c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 830:	fee79ae3          	bne	a5,a4,824 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 834:	60a2                	ld	ra,8(sp)
 836:	6402                	ld	s0,0(sp)
 838:	0141                	addi	sp,sp,16
 83a:	8082                	ret
    while(n-- > 0)
 83c:	fec05ce3          	blez	a2,834 <memmove+0x2a>
    dst += n;
 840:	00c50733          	add	a4,a0,a2
    src += n;
 844:	95b2                	add	a1,a1,a2
 846:	fff6079b          	addiw	a5,a2,-1 # 7fff <base+0x4fef>
 84a:	1782                	slli	a5,a5,0x20
 84c:	9381                	srli	a5,a5,0x20
 84e:	fff7c793          	not	a5,a5
 852:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 854:	15fd                	addi	a1,a1,-1
 856:	177d                	addi	a4,a4,-1
 858:	0005c683          	lbu	a3,0(a1)
 85c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 860:	fef71ae3          	bne	a4,a5,854 <memmove+0x4a>
 864:	bfc1                	j	834 <memmove+0x2a>

0000000000000866 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 866:	1141                	addi	sp,sp,-16
 868:	e406                	sd	ra,8(sp)
 86a:	e022                	sd	s0,0(sp)
 86c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 86e:	ce19                	beqz	a2,88c <memcmp+0x26>
 870:	1602                	slli	a2,a2,0x20
 872:	9201                	srli	a2,a2,0x20
 874:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 878:	00054783          	lbu	a5,0(a0)
 87c:	0005c703          	lbu	a4,0(a1)
 880:	00e79b63          	bne	a5,a4,896 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 884:	0505                	addi	a0,a0,1
    p2++;
 886:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 888:	fed518e3          	bne	a0,a3,878 <memcmp+0x12>
  }
  return 0;
 88c:	4501                	li	a0,0
}
 88e:	60a2                	ld	ra,8(sp)
 890:	6402                	ld	s0,0(sp)
 892:	0141                	addi	sp,sp,16
 894:	8082                	ret
      return *p1 - *p2;
 896:	40e7853b          	subw	a0,a5,a4
 89a:	bfd5                	j	88e <memcmp+0x28>

000000000000089c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 89c:	1141                	addi	sp,sp,-16
 89e:	e406                	sd	ra,8(sp)
 8a0:	e022                	sd	s0,0(sp)
 8a2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 8a4:	f67ff0ef          	jal	80a <memmove>
}
 8a8:	60a2                	ld	ra,8(sp)
 8aa:	6402                	ld	s0,0(sp)
 8ac:	0141                	addi	sp,sp,16
 8ae:	8082                	ret

00000000000008b0 <sbrk>:

char *
sbrk(int n) {
 8b0:	1141                	addi	sp,sp,-16
 8b2:	e406                	sd	ra,8(sp)
 8b4:	e022                	sd	s0,0(sp)
 8b6:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 8b8:	4585                	li	a1,1
 8ba:	0b2000ef          	jal	96c <sys_sbrk>
}
 8be:	60a2                	ld	ra,8(sp)
 8c0:	6402                	ld	s0,0(sp)
 8c2:	0141                	addi	sp,sp,16
 8c4:	8082                	ret

00000000000008c6 <sbrklazy>:

char *
sbrklazy(int n) {
 8c6:	1141                	addi	sp,sp,-16
 8c8:	e406                	sd	ra,8(sp)
 8ca:	e022                	sd	s0,0(sp)
 8cc:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 8ce:	4589                	li	a1,2
 8d0:	09c000ef          	jal	96c <sys_sbrk>
}
 8d4:	60a2                	ld	ra,8(sp)
 8d6:	6402                	ld	s0,0(sp)
 8d8:	0141                	addi	sp,sp,16
 8da:	8082                	ret

00000000000008dc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 8dc:	4885                	li	a7,1
 ecall
 8de:	00000073          	ecall
 ret
 8e2:	8082                	ret

00000000000008e4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 8e4:	4889                	li	a7,2
 ecall
 8e6:	00000073          	ecall
 ret
 8ea:	8082                	ret

00000000000008ec <wait>:
.global wait
wait:
 li a7, SYS_wait
 8ec:	488d                	li	a7,3
 ecall
 8ee:	00000073          	ecall
 ret
 8f2:	8082                	ret

00000000000008f4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 8f4:	4891                	li	a7,4
 ecall
 8f6:	00000073          	ecall
 ret
 8fa:	8082                	ret

00000000000008fc <read>:
.global read
read:
 li a7, SYS_read
 8fc:	4895                	li	a7,5
 ecall
 8fe:	00000073          	ecall
 ret
 902:	8082                	ret

0000000000000904 <write>:
.global write
write:
 li a7, SYS_write
 904:	48c1                	li	a7,16
 ecall
 906:	00000073          	ecall
 ret
 90a:	8082                	ret

000000000000090c <close>:
.global close
close:
 li a7, SYS_close
 90c:	48d5                	li	a7,21
 ecall
 90e:	00000073          	ecall
 ret
 912:	8082                	ret

0000000000000914 <kill>:
.global kill
kill:
 li a7, SYS_kill
 914:	4899                	li	a7,6
 ecall
 916:	00000073          	ecall
 ret
 91a:	8082                	ret

000000000000091c <exec>:
.global exec
exec:
 li a7, SYS_exec
 91c:	489d                	li	a7,7
 ecall
 91e:	00000073          	ecall
 ret
 922:	8082                	ret

0000000000000924 <open>:
.global open
open:
 li a7, SYS_open
 924:	48bd                	li	a7,15
 ecall
 926:	00000073          	ecall
 ret
 92a:	8082                	ret

000000000000092c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 92c:	48c5                	li	a7,17
 ecall
 92e:	00000073          	ecall
 ret
 932:	8082                	ret

0000000000000934 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 934:	48c9                	li	a7,18
 ecall
 936:	00000073          	ecall
 ret
 93a:	8082                	ret

000000000000093c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 93c:	48a1                	li	a7,8
 ecall
 93e:	00000073          	ecall
 ret
 942:	8082                	ret

0000000000000944 <link>:
.global link
link:
 li a7, SYS_link
 944:	48cd                	li	a7,19
 ecall
 946:	00000073          	ecall
 ret
 94a:	8082                	ret

000000000000094c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 94c:	48d1                	li	a7,20
 ecall
 94e:	00000073          	ecall
 ret
 952:	8082                	ret

0000000000000954 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 954:	48a5                	li	a7,9
 ecall
 956:	00000073          	ecall
 ret
 95a:	8082                	ret

000000000000095c <dup>:
.global dup
dup:
 li a7, SYS_dup
 95c:	48a9                	li	a7,10
 ecall
 95e:	00000073          	ecall
 ret
 962:	8082                	ret

0000000000000964 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 964:	48ad                	li	a7,11
 ecall
 966:	00000073          	ecall
 ret
 96a:	8082                	ret

000000000000096c <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 96c:	48b1                	li	a7,12
 ecall
 96e:	00000073          	ecall
 ret
 972:	8082                	ret

0000000000000974 <pause>:
.global pause
pause:
 li a7, SYS_pause
 974:	48b5                	li	a7,13
 ecall
 976:	00000073          	ecall
 ret
 97a:	8082                	ret

000000000000097c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 97c:	48b9                	li	a7,14
 ecall
 97e:	00000073          	ecall
 ret
 982:	8082                	ret

0000000000000984 <bind>:
.global bind
bind:
 li a7, SYS_bind
 984:	48f5                	li	a7,29
 ecall
 986:	00000073          	ecall
 ret
 98a:	8082                	ret

000000000000098c <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 98c:	48f9                	li	a7,30
 ecall
 98e:	00000073          	ecall
 ret
 992:	8082                	ret

0000000000000994 <send>:
.global send
send:
 li a7, SYS_send
 994:	48fd                	li	a7,31
 ecall
 996:	00000073          	ecall
 ret
 99a:	8082                	ret

000000000000099c <recv>:
.global recv
recv:
 li a7, SYS_recv
 99c:	02000893          	li	a7,32
 ecall
 9a0:	00000073          	ecall
 ret
 9a4:	8082                	ret

00000000000009a6 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 9a6:	02100893          	li	a7,33
 ecall
 9aa:	00000073          	ecall
 ret
 9ae:	8082                	ret

00000000000009b0 <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 9b0:	02200893          	li	a7,34
 ecall
 9b4:	00000073          	ecall
 ret
 9b8:	8082                	ret

00000000000009ba <rwlktest>:
.global rwlktest
rwlktest:
 li a7, SYS_rwlktest
 9ba:	02300893          	li	a7,35
 ecall
 9be:	00000073          	ecall
 ret
 9c2:	8082                	ret

00000000000009c4 <cpupin>:
.global cpupin
cpupin:
 li a7, SYS_cpupin
 9c4:	02400893          	li	a7,36
 ecall
 9c8:	00000073          	ecall
 ret
 9cc:	8082                	ret

00000000000009ce <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 9ce:	1101                	addi	sp,sp,-32
 9d0:	ec06                	sd	ra,24(sp)
 9d2:	e822                	sd	s0,16(sp)
 9d4:	1000                	addi	s0,sp,32
 9d6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 9da:	4605                	li	a2,1
 9dc:	fef40593          	addi	a1,s0,-17
 9e0:	f25ff0ef          	jal	904 <write>
}
 9e4:	60e2                	ld	ra,24(sp)
 9e6:	6442                	ld	s0,16(sp)
 9e8:	6105                	addi	sp,sp,32
 9ea:	8082                	ret

00000000000009ec <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 9ec:	715d                	addi	sp,sp,-80
 9ee:	e486                	sd	ra,72(sp)
 9f0:	e0a2                	sd	s0,64(sp)
 9f2:	f84a                	sd	s2,48(sp)
 9f4:	f44e                	sd	s3,40(sp)
 9f6:	0880                	addi	s0,sp,80
 9f8:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 9fa:	00d036b3          	snez	a3,a3
 9fe:	03f5d793          	srli	a5,a1,0x3f
 a02:	8efd                	and	a3,a3,a5
  neg = 0;
 a04:	4301                	li	t1,0
  if(sgn && xx < 0){
 a06:	c681                	beqz	a3,a0e <printint+0x22>
    neg = 1;
    x = -xx;
 a08:	40b005b3          	neg	a1,a1
    neg = 1;
 a0c:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 a0e:	fb840993          	addi	s3,s0,-72
  neg = 0;
 a12:	86ce                	mv	a3,s3
  i = 0;
 a14:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 a16:	00001817          	auipc	a6,0x1
 a1a:	81a80813          	addi	a6,a6,-2022 # 1230 <digits>
 a1e:	88ba                	mv	a7,a4
 a20:	0017051b          	addiw	a0,a4,1
 a24:	872a                	mv	a4,a0
 a26:	02c5f7b3          	remu	a5,a1,a2
 a2a:	97c2                	add	a5,a5,a6
 a2c:	0007c783          	lbu	a5,0(a5)
 a30:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 a34:	87ae                	mv	a5,a1
 a36:	02c5d5b3          	divu	a1,a1,a2
 a3a:	0685                	addi	a3,a3,1
 a3c:	fec7f1e3          	bgeu	a5,a2,a1e <printint+0x32>
  if(neg)
 a40:	00030b63          	beqz	t1,a56 <printint+0x6a>
    buf[i++] = '-';
 a44:	fd040793          	addi	a5,s0,-48
 a48:	953e                	add	a0,a0,a5
 a4a:	02d00793          	li	a5,45
 a4e:	fef50423          	sb	a5,-24(a0)
 a52:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 a56:	02e05563          	blez	a4,a80 <printint+0x94>
 a5a:	fc26                	sd	s1,56(sp)
 a5c:	377d                	addiw	a4,a4,-1
 a5e:	00e984b3          	add	s1,s3,a4
 a62:	19fd                	addi	s3,s3,-1
 a64:	99ba                	add	s3,s3,a4
 a66:	1702                	slli	a4,a4,0x20
 a68:	9301                	srli	a4,a4,0x20
 a6a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 a6e:	0004c583          	lbu	a1,0(s1)
 a72:	854a                	mv	a0,s2
 a74:	f5bff0ef          	jal	9ce <putc>
  while(--i >= 0)
 a78:	14fd                	addi	s1,s1,-1
 a7a:	ff349ae3          	bne	s1,s3,a6e <printint+0x82>
 a7e:	74e2                	ld	s1,56(sp)
}
 a80:	60a6                	ld	ra,72(sp)
 a82:	6406                	ld	s0,64(sp)
 a84:	7942                	ld	s2,48(sp)
 a86:	79a2                	ld	s3,40(sp)
 a88:	6161                	addi	sp,sp,80
 a8a:	8082                	ret

0000000000000a8c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 a8c:	711d                	addi	sp,sp,-96
 a8e:	ec86                	sd	ra,88(sp)
 a90:	e8a2                	sd	s0,80(sp)
 a92:	e4a6                	sd	s1,72(sp)
 a94:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 a96:	0005c483          	lbu	s1,0(a1)
 a9a:	2a048063          	beqz	s1,d3a <vprintf+0x2ae>
 a9e:	e0ca                	sd	s2,64(sp)
 aa0:	fc4e                	sd	s3,56(sp)
 aa2:	f852                	sd	s4,48(sp)
 aa4:	f456                	sd	s5,40(sp)
 aa6:	f05a                	sd	s6,32(sp)
 aa8:	ec5e                	sd	s7,24(sp)
 aaa:	e862                	sd	s8,16(sp)
 aac:	8b2a                	mv	s6,a0
 aae:	8a2e                	mv	s4,a1
 ab0:	8bb2                	mv	s7,a2
  state = 0;
 ab2:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 ab4:	4901                	li	s2,0
 ab6:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 ab8:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 abc:	06400c13          	li	s8,100
 ac0:	a00d                	j	ae2 <vprintf+0x56>
        putc(fd, c0);
 ac2:	85a6                	mv	a1,s1
 ac4:	855a                	mv	a0,s6
 ac6:	f09ff0ef          	jal	9ce <putc>
 aca:	a019                	j	ad0 <vprintf+0x44>
    } else if(state == '%'){
 acc:	03598363          	beq	s3,s5,af2 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 ad0:	0019079b          	addiw	a5,s2,1
 ad4:	893e                	mv	s2,a5
 ad6:	873e                	mv	a4,a5
 ad8:	97d2                	add	a5,a5,s4
 ada:	0007c483          	lbu	s1,0(a5)
 ade:	24048763          	beqz	s1,d2c <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 ae2:	0004879b          	sext.w	a5,s1
    if(state == 0){
 ae6:	fe0993e3          	bnez	s3,acc <vprintf+0x40>
      if(c0 == '%'){
 aea:	fd579ce3          	bne	a5,s5,ac2 <vprintf+0x36>
        state = '%';
 aee:	89be                	mv	s3,a5
 af0:	b7c5                	j	ad0 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 af2:	00ea06b3          	add	a3,s4,a4
 af6:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 afa:	24060563          	beqz	a2,d44 <vprintf+0x2b8>
      if(c0 == 'd'){
 afe:	0b878763          	beq	a5,s8,bac <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 b02:	f9478693          	addi	a3,a5,-108
 b06:	0016b693          	seqz	a3,a3
 b0a:	f9c60593          	addi	a1,a2,-100
 b0e:	0015b593          	seqz	a1,a1
 b12:	8df5                	and	a1,a1,a3
 b14:	e9c5                	bnez	a1,bc4 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
 b16:	9752                	add	a4,a4,s4
 b18:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 b1c:	f9460713          	addi	a4,a2,-108
 b20:	00173713          	seqz	a4,a4
 b24:	8f75                	and	a4,a4,a3
 b26:	f9c50593          	addi	a1,a0,-100
 b2a:	0015b593          	seqz	a1,a1
 b2e:	8df9                	and	a1,a1,a4
 b30:	e5dd                	bnez	a1,bde <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 b32:	07500593          	li	a1,117
 b36:	0cb78163          	beq	a5,a1,bf8 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
 b3a:	f8b60593          	addi	a1,a2,-117
 b3e:	0015b593          	seqz	a1,a1
 b42:	8df5                	and	a1,a1,a3
 b44:	e5f1                	bnez	a1,c10 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 b46:	f8b50593          	addi	a1,a0,-117
 b4a:	0015b593          	seqz	a1,a1
 b4e:	8df9                	and	a1,a1,a4
 b50:	ede9                	bnez	a1,c2a <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 b52:	07800593          	li	a1,120
 b56:	0eb78763          	beq	a5,a1,c44 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
 b5a:	f8860613          	addi	a2,a2,-120
 b5e:	00163613          	seqz	a2,a2
 b62:	8ef1                	and	a3,a3,a2
 b64:	0e069c63          	bnez	a3,c5c <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 b68:	f8850513          	addi	a0,a0,-120
 b6c:	00153513          	seqz	a0,a0
 b70:	8f69                	and	a4,a4,a0
 b72:	10071263          	bnez	a4,c76 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 b76:	07000713          	li	a4,112
 b7a:	10e78a63          	beq	a5,a4,c8e <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 b7e:	06300713          	li	a4,99
 b82:	14e78a63          	beq	a5,a4,cd6 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 b86:	07300713          	li	a4,115
 b8a:	16e78063          	beq	a5,a4,cea <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 b8e:	02500713          	li	a4,37
 b92:	18e78863          	beq	a5,a4,d22 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 b96:	02500593          	li	a1,37
 b9a:	855a                	mv	a0,s6
 b9c:	e33ff0ef          	jal	9ce <putc>
        putc(fd, c0);
 ba0:	85a6                	mv	a1,s1
 ba2:	855a                	mv	a0,s6
 ba4:	e2bff0ef          	jal	9ce <putc>
      }

      state = 0;
 ba8:	4981                	li	s3,0
 baa:	b71d                	j	ad0 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 bac:	008b8493          	addi	s1,s7,8
 bb0:	4685                	li	a3,1
 bb2:	4629                	li	a2,10
 bb4:	000ba583          	lw	a1,0(s7)
 bb8:	855a                	mv	a0,s6
 bba:	e33ff0ef          	jal	9ec <printint>
 bbe:	8ba6                	mv	s7,s1
      state = 0;
 bc0:	4981                	li	s3,0
 bc2:	b739                	j	ad0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 bc4:	008b8493          	addi	s1,s7,8
 bc8:	4685                	li	a3,1
 bca:	4629                	li	a2,10
 bcc:	000bb583          	ld	a1,0(s7)
 bd0:	855a                	mv	a0,s6
 bd2:	e1bff0ef          	jal	9ec <printint>
        i += 1;
 bd6:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 bd8:	8ba6                	mv	s7,s1
      state = 0;
 bda:	4981                	li	s3,0
 bdc:	bdd5                	j	ad0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 bde:	008b8493          	addi	s1,s7,8
 be2:	4685                	li	a3,1
 be4:	4629                	li	a2,10
 be6:	000bb583          	ld	a1,0(s7)
 bea:	855a                	mv	a0,s6
 bec:	e01ff0ef          	jal	9ec <printint>
        i += 2;
 bf0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 bf2:	8ba6                	mv	s7,s1
      state = 0;
 bf4:	4981                	li	s3,0
        i += 2;
 bf6:	bde9                	j	ad0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 bf8:	008b8493          	addi	s1,s7,8
 bfc:	4681                	li	a3,0
 bfe:	4629                	li	a2,10
 c00:	000be583          	lwu	a1,0(s7)
 c04:	855a                	mv	a0,s6
 c06:	de7ff0ef          	jal	9ec <printint>
 c0a:	8ba6                	mv	s7,s1
      state = 0;
 c0c:	4981                	li	s3,0
 c0e:	b5c9                	j	ad0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 c10:	008b8493          	addi	s1,s7,8
 c14:	4681                	li	a3,0
 c16:	4629                	li	a2,10
 c18:	000bb583          	ld	a1,0(s7)
 c1c:	855a                	mv	a0,s6
 c1e:	dcfff0ef          	jal	9ec <printint>
        i += 1;
 c22:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 c24:	8ba6                	mv	s7,s1
      state = 0;
 c26:	4981                	li	s3,0
 c28:	b565                	j	ad0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 c2a:	008b8493          	addi	s1,s7,8
 c2e:	4681                	li	a3,0
 c30:	4629                	li	a2,10
 c32:	000bb583          	ld	a1,0(s7)
 c36:	855a                	mv	a0,s6
 c38:	db5ff0ef          	jal	9ec <printint>
        i += 2;
 c3c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 c3e:	8ba6                	mv	s7,s1
      state = 0;
 c40:	4981                	li	s3,0
        i += 2;
 c42:	b579                	j	ad0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 c44:	008b8493          	addi	s1,s7,8
 c48:	4681                	li	a3,0
 c4a:	4641                	li	a2,16
 c4c:	000be583          	lwu	a1,0(s7)
 c50:	855a                	mv	a0,s6
 c52:	d9bff0ef          	jal	9ec <printint>
 c56:	8ba6                	mv	s7,s1
      state = 0;
 c58:	4981                	li	s3,0
 c5a:	bd9d                	j	ad0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 c5c:	008b8493          	addi	s1,s7,8
 c60:	4681                	li	a3,0
 c62:	4641                	li	a2,16
 c64:	000bb583          	ld	a1,0(s7)
 c68:	855a                	mv	a0,s6
 c6a:	d83ff0ef          	jal	9ec <printint>
        i += 1;
 c6e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 c70:	8ba6                	mv	s7,s1
      state = 0;
 c72:	4981                	li	s3,0
 c74:	bdb1                	j	ad0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 c76:	008b8493          	addi	s1,s7,8
 c7a:	4641                	li	a2,16
 c7c:	000bb583          	ld	a1,0(s7)
 c80:	855a                	mv	a0,s6
 c82:	d6bff0ef          	jal	9ec <printint>
        i += 2;
 c86:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 c88:	8ba6                	mv	s7,s1
      state = 0;
 c8a:	4981                	li	s3,0
        i += 2;
 c8c:	b591                	j	ad0 <vprintf+0x44>
 c8e:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 c90:	008b8793          	addi	a5,s7,8
 c94:	8cbe                	mv	s9,a5
 c96:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 c9a:	03000593          	li	a1,48
 c9e:	855a                	mv	a0,s6
 ca0:	d2fff0ef          	jal	9ce <putc>
  putc(fd, 'x');
 ca4:	07800593          	li	a1,120
 ca8:	855a                	mv	a0,s6
 caa:	d25ff0ef          	jal	9ce <putc>
 cae:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 cb0:	00000b97          	auipc	s7,0x0
 cb4:	580b8b93          	addi	s7,s7,1408 # 1230 <digits>
 cb8:	03c9d793          	srli	a5,s3,0x3c
 cbc:	97de                	add	a5,a5,s7
 cbe:	0007c583          	lbu	a1,0(a5)
 cc2:	855a                	mv	a0,s6
 cc4:	d0bff0ef          	jal	9ce <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 cc8:	0992                	slli	s3,s3,0x4
 cca:	34fd                	addiw	s1,s1,-1
 ccc:	f4f5                	bnez	s1,cb8 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 cce:	8be6                	mv	s7,s9
      state = 0;
 cd0:	4981                	li	s3,0
 cd2:	6ca2                	ld	s9,8(sp)
 cd4:	bbf5                	j	ad0 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 cd6:	008b8493          	addi	s1,s7,8
 cda:	000bc583          	lbu	a1,0(s7)
 cde:	855a                	mv	a0,s6
 ce0:	cefff0ef          	jal	9ce <putc>
 ce4:	8ba6                	mv	s7,s1
      state = 0;
 ce6:	4981                	li	s3,0
 ce8:	b3e5                	j	ad0 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 cea:	008b8993          	addi	s3,s7,8
 cee:	000bb483          	ld	s1,0(s7)
 cf2:	cc91                	beqz	s1,d0e <vprintf+0x282>
        for(; *s; s++)
 cf4:	0004c583          	lbu	a1,0(s1)
 cf8:	c195                	beqz	a1,d1c <vprintf+0x290>
          putc(fd, *s);
 cfa:	855a                	mv	a0,s6
 cfc:	cd3ff0ef          	jal	9ce <putc>
        for(; *s; s++)
 d00:	0485                	addi	s1,s1,1
 d02:	0004c583          	lbu	a1,0(s1)
 d06:	f9f5                	bnez	a1,cfa <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 d08:	8bce                	mv	s7,s3
      state = 0;
 d0a:	4981                	li	s3,0
 d0c:	b3d1                	j	ad0 <vprintf+0x44>
          s = "(null)";
 d0e:	00000497          	auipc	s1,0x0
 d12:	4f248493          	addi	s1,s1,1266 # 1200 <statistics+0x2ce>
        for(; *s; s++)
 d16:	02800593          	li	a1,40
 d1a:	b7c5                	j	cfa <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
 d1c:	8bce                	mv	s7,s3
      state = 0;
 d1e:	4981                	li	s3,0
 d20:	bb45                	j	ad0 <vprintf+0x44>
        putc(fd, '%');
 d22:	85be                	mv	a1,a5
 d24:	855a                	mv	a0,s6
 d26:	ca9ff0ef          	jal	9ce <putc>
 d2a:	bdbd                	j	ba8 <vprintf+0x11c>
 d2c:	6906                	ld	s2,64(sp)
 d2e:	79e2                	ld	s3,56(sp)
 d30:	7a42                	ld	s4,48(sp)
 d32:	7aa2                	ld	s5,40(sp)
 d34:	7b02                	ld	s6,32(sp)
 d36:	6be2                	ld	s7,24(sp)
 d38:	6c42                	ld	s8,16(sp)
    }
  }
}
 d3a:	60e6                	ld	ra,88(sp)
 d3c:	6446                	ld	s0,80(sp)
 d3e:	64a6                	ld	s1,72(sp)
 d40:	6125                	addi	sp,sp,96
 d42:	8082                	ret
      if(c0 == 'd'){
 d44:	06400713          	li	a4,100
 d48:	e6e782e3          	beq	a5,a4,bac <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
 d4c:	f9478693          	addi	a3,a5,-108
 d50:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 d54:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 d56:	4701                	li	a4,0
 d58:	bbe9                	j	b32 <vprintf+0xa6>

0000000000000d5a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 d5a:	715d                	addi	sp,sp,-80
 d5c:	ec06                	sd	ra,24(sp)
 d5e:	e822                	sd	s0,16(sp)
 d60:	1000                	addi	s0,sp,32
 d62:	e010                	sd	a2,0(s0)
 d64:	e414                	sd	a3,8(s0)
 d66:	e818                	sd	a4,16(s0)
 d68:	ec1c                	sd	a5,24(s0)
 d6a:	03043023          	sd	a6,32(s0)
 d6e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 d72:	8622                	mv	a2,s0
 d74:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 d78:	d15ff0ef          	jal	a8c <vprintf>
}
 d7c:	60e2                	ld	ra,24(sp)
 d7e:	6442                	ld	s0,16(sp)
 d80:	6161                	addi	sp,sp,80
 d82:	8082                	ret

0000000000000d84 <printf>:

void
printf(const char *fmt, ...)
{
 d84:	711d                	addi	sp,sp,-96
 d86:	ec06                	sd	ra,24(sp)
 d88:	e822                	sd	s0,16(sp)
 d8a:	1000                	addi	s0,sp,32
 d8c:	e40c                	sd	a1,8(s0)
 d8e:	e810                	sd	a2,16(s0)
 d90:	ec14                	sd	a3,24(s0)
 d92:	f018                	sd	a4,32(s0)
 d94:	f41c                	sd	a5,40(s0)
 d96:	03043823          	sd	a6,48(s0)
 d9a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 d9e:	00840613          	addi	a2,s0,8
 da2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 da6:	85aa                	mv	a1,a0
 da8:	4505                	li	a0,1
 daa:	ce3ff0ef          	jal	a8c <vprintf>
}
 dae:	60e2                	ld	ra,24(sp)
 db0:	6442                	ld	s0,16(sp)
 db2:	6125                	addi	sp,sp,96
 db4:	8082                	ret

0000000000000db6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 db6:	1141                	addi	sp,sp,-16
 db8:	e406                	sd	ra,8(sp)
 dba:	e022                	sd	s0,0(sp)
 dbc:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 dbe:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 dc2:	00001797          	auipc	a5,0x1
 dc6:	23e7b783          	ld	a5,574(a5) # 2000 <freep>
 dca:	a095                	j	e2e <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 dcc:	ff852583          	lw	a1,-8(a0)
 dd0:	6390                	ld	a2,0(a5)
 dd2:	02059813          	slli	a6,a1,0x20
 dd6:	01c85693          	srli	a3,a6,0x1c
 dda:	96ba                	add	a3,a3,a4
 ddc:	02d60563          	beq	a2,a3,e06 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 de0:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 de4:	4790                	lw	a2,8(a5)
 de6:	02061593          	slli	a1,a2,0x20
 dea:	01c5d693          	srli	a3,a1,0x1c
 dee:	96be                	add	a3,a3,a5
 df0:	02d70263          	beq	a4,a3,e14 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 df4:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 df6:	00001717          	auipc	a4,0x1
 dfa:	20f73523          	sd	a5,522(a4) # 2000 <freep>
}
 dfe:	60a2                	ld	ra,8(sp)
 e00:	6402                	ld	s0,0(sp)
 e02:	0141                	addi	sp,sp,16
 e04:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 e06:	4614                	lw	a3,8(a2)
 e08:	9ead                	addw	a3,a3,a1
 e0a:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 e0e:	6394                	ld	a3,0(a5)
 e10:	6290                	ld	a2,0(a3)
 e12:	b7f9                	j	de0 <free+0x2a>
    p->s.size += bp->s.size;
 e14:	ff852703          	lw	a4,-8(a0)
 e18:	9f31                	addw	a4,a4,a2
 e1a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 e1c:	ff053703          	ld	a4,-16(a0)
 e20:	bfd1                	j	df4 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e22:	6394                	ld	a3,0(a5)
 e24:	00d7e463          	bltu	a5,a3,e2c <free+0x76>
 e28:	fad762e3          	bltu	a4,a3,dcc <free+0x16>
 e2c:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e2e:	fee7fae3          	bgeu	a5,a4,e22 <free+0x6c>
 e32:	6394                	ld	a3,0(a5)
 e34:	f8d76ce3          	bltu	a4,a3,dcc <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e38:	f8d7fae3          	bgeu	a5,a3,dcc <free+0x16>
 e3c:	87b6                	mv	a5,a3
 e3e:	bfc5                	j	e2e <free+0x78>

0000000000000e40 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 e40:	7139                	addi	sp,sp,-64
 e42:	fc06                	sd	ra,56(sp)
 e44:	f822                	sd	s0,48(sp)
 e46:	f04a                	sd	s2,32(sp)
 e48:	ec4e                	sd	s3,24(sp)
 e4a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e4c:	02051993          	slli	s3,a0,0x20
 e50:	0209d993          	srli	s3,s3,0x20
 e54:	09bd                	addi	s3,s3,15
 e56:	0049d993          	srli	s3,s3,0x4
 e5a:	2985                	addiw	s3,s3,1
 e5c:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 e5e:	00001517          	auipc	a0,0x1
 e62:	1a253503          	ld	a0,418(a0) # 2000 <freep>
 e66:	c905                	beqz	a0,e96 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e68:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 e6a:	4798                	lw	a4,8(a5)
 e6c:	09377663          	bgeu	a4,s3,ef8 <malloc+0xb8>
 e70:	f426                	sd	s1,40(sp)
 e72:	e852                	sd	s4,16(sp)
 e74:	e456                	sd	s5,8(sp)
 e76:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 e78:	8a4e                	mv	s4,s3
 e7a:	6705                	lui	a4,0x1
 e7c:	00e9f363          	bgeu	s3,a4,e82 <malloc+0x42>
 e80:	6a05                	lui	s4,0x1
 e82:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 e86:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 e8a:	00001497          	auipc	s1,0x1
 e8e:	17648493          	addi	s1,s1,374 # 2000 <freep>
  if(p == SBRK_ERROR)
 e92:	5afd                	li	s5,-1
 e94:	a83d                	j	ed2 <malloc+0x92>
 e96:	f426                	sd	s1,40(sp)
 e98:	e852                	sd	s4,16(sp)
 e9a:	e456                	sd	s5,8(sp)
 e9c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 e9e:	00002797          	auipc	a5,0x2
 ea2:	17278793          	addi	a5,a5,370 # 3010 <base>
 ea6:	00001717          	auipc	a4,0x1
 eaa:	14f73d23          	sd	a5,346(a4) # 2000 <freep>
 eae:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 eb0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 eb4:	b7d1                	j	e78 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 eb6:	6398                	ld	a4,0(a5)
 eb8:	e118                	sd	a4,0(a0)
 eba:	a899                	j	f10 <malloc+0xd0>
  hp->s.size = nu;
 ebc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ec0:	0541                	addi	a0,a0,16
 ec2:	ef5ff0ef          	jal	db6 <free>
  return freep;
 ec6:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 ec8:	c125                	beqz	a0,f28 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 eca:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ecc:	4798                	lw	a4,8(a5)
 ece:	03277163          	bgeu	a4,s2,ef0 <malloc+0xb0>
    if(p == freep)
 ed2:	6098                	ld	a4,0(s1)
 ed4:	853e                	mv	a0,a5
 ed6:	fef71ae3          	bne	a4,a5,eca <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 eda:	8552                	mv	a0,s4
 edc:	9d5ff0ef          	jal	8b0 <sbrk>
  if(p == SBRK_ERROR)
 ee0:	fd551ee3          	bne	a0,s5,ebc <malloc+0x7c>
        return 0;
 ee4:	4501                	li	a0,0
 ee6:	74a2                	ld	s1,40(sp)
 ee8:	6a42                	ld	s4,16(sp)
 eea:	6aa2                	ld	s5,8(sp)
 eec:	6b02                	ld	s6,0(sp)
 eee:	a03d                	j	f1c <malloc+0xdc>
 ef0:	74a2                	ld	s1,40(sp)
 ef2:	6a42                	ld	s4,16(sp)
 ef4:	6aa2                	ld	s5,8(sp)
 ef6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 ef8:	fae90fe3          	beq	s2,a4,eb6 <malloc+0x76>
        p->s.size -= nunits;
 efc:	4137073b          	subw	a4,a4,s3
 f00:	c798                	sw	a4,8(a5)
        p += p->s.size;
 f02:	02071693          	slli	a3,a4,0x20
 f06:	01c6d713          	srli	a4,a3,0x1c
 f0a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 f0c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 f10:	00001717          	auipc	a4,0x1
 f14:	0ea73823          	sd	a0,240(a4) # 2000 <freep>
      return (void*)(p + 1);
 f18:	01078513          	addi	a0,a5,16
  }
}
 f1c:	70e2                	ld	ra,56(sp)
 f1e:	7442                	ld	s0,48(sp)
 f20:	7902                	ld	s2,32(sp)
 f22:	69e2                	ld	s3,24(sp)
 f24:	6121                	addi	sp,sp,64
 f26:	8082                	ret
 f28:	74a2                	ld	s1,40(sp)
 f2a:	6a42                	ld	s4,16(sp)
 f2c:	6aa2                	ld	s5,8(sp)
 f2e:	6b02                	ld	s6,0(sp)
 f30:	b7f5                	j	f1c <malloc+0xdc>

0000000000000f32 <statistics>:
#include "kernel/fcntl.h"
#include "user/user.h"

int
statistics(void *buf, int sz)
{
 f32:	7179                	addi	sp,sp,-48
 f34:	f406                	sd	ra,40(sp)
 f36:	f022                	sd	s0,32(sp)
 f38:	ec26                	sd	s1,24(sp)
 f3a:	e84a                	sd	s2,16(sp)
 f3c:	e44e                	sd	s3,8(sp)
 f3e:	e052                	sd	s4,0(sp)
 f40:	1800                	addi	s0,sp,48
 f42:	8a2a                	mv	s4,a0
 f44:	892e                	mv	s2,a1
  int fd, i, n;
  
  fd = open("statistics", O_RDONLY);
 f46:	4581                	li	a1,0
 f48:	00000517          	auipc	a0,0x0
 f4c:	2c050513          	addi	a0,a0,704 # 1208 <statistics+0x2d6>
 f50:	9d5ff0ef          	jal	924 <open>
  if(fd < 0) {
 f54:	02054e63          	bltz	a0,f90 <statistics+0x5e>
 f58:	89aa                	mv	s3,a0
      fprintf(2, "stats: open failed\n");
      exit(1);
  }
  for (i = 0; i < sz; ) {
 f5a:	4481                	li	s1,0
 f5c:	01205e63          	blez	s2,f78 <statistics+0x46>
    if ((n = read(fd, buf+i, sz-i)) < 0) {
 f60:	4099063b          	subw	a2,s2,s1
 f64:	009a05b3          	add	a1,s4,s1
 f68:	854e                	mv	a0,s3
 f6a:	993ff0ef          	jal	8fc <read>
 f6e:	00054563          	bltz	a0,f78 <statistics+0x46>
      break;
    }
    i += n;
 f72:	9ca9                	addw	s1,s1,a0
  for (i = 0; i < sz; ) {
 f74:	ff24c6e3          	blt	s1,s2,f60 <statistics+0x2e>
  }
  close(fd);
 f78:	854e                	mv	a0,s3
 f7a:	993ff0ef          	jal	90c <close>
  return i;
}
 f7e:	8526                	mv	a0,s1
 f80:	70a2                	ld	ra,40(sp)
 f82:	7402                	ld	s0,32(sp)
 f84:	64e2                	ld	s1,24(sp)
 f86:	6942                	ld	s2,16(sp)
 f88:	69a2                	ld	s3,8(sp)
 f8a:	6a02                	ld	s4,0(sp)
 f8c:	6145                	addi	sp,sp,48
 f8e:	8082                	ret
      fprintf(2, "stats: open failed\n");
 f90:	00000597          	auipc	a1,0x0
 f94:	28858593          	addi	a1,a1,648 # 1218 <statistics+0x2e6>
 f98:	4509                	li	a0,2
 f9a:	dc1ff0ef          	jal	d5a <fprintf>
      exit(1);
 f9e:	4505                	li	a0,1
 fa0:	945ff0ef          	jal	8e4 <exit>
