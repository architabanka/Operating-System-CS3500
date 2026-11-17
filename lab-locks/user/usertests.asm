
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	711d                	addi	sp,sp,-96
       2:	ec86                	sd	ra,88(sp)
       4:	e8a2                	sd	s0,80(sp)
       6:	e4a6                	sd	s1,72(sp)
       8:	e0ca                	sd	s2,64(sp)
       a:	fc4e                	sd	s3,56(sp)
       c:	f852                	sd	s4,48(sp)
       e:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
      10:	00008797          	auipc	a5,0x8
      14:	a6078793          	addi	a5,a5,-1440 # 7a70 <statistics+0x2526>
      18:	638c                	ld	a1,0(a5)
      1a:	6790                	ld	a2,8(a5)
      1c:	6b94                	ld	a3,16(a5)
      1e:	6f98                	ld	a4,24(a5)
      20:	fab43423          	sd	a1,-88(s0)
      24:	fac43823          	sd	a2,-80(s0)
      28:	fad43c23          	sd	a3,-72(s0)
      2c:	fce43023          	sd	a4,-64(s0)
      30:	739c                	ld	a5,32(a5)
      32:	fcf43423          	sd	a5,-56(s0)
                     0xffffffffffffffff };

  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
      36:	fa840493          	addi	s1,s0,-88
      3a:	fd040a13          	addi	s4,s0,-48
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      3e:	20100993          	li	s3,513
      42:	0004b903          	ld	s2,0(s1)
      46:	85ce                	mv	a1,s3
      48:	854a                	mv	a0,s2
      4a:	6f3040ef          	jal	4f3c <open>
    if(fd >= 0){
      4e:	00055d63          	bgez	a0,68 <copyinstr1+0x68>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
      52:	04a1                	addi	s1,s1,8
      54:	ff4497e3          	bne	s1,s4,42 <copyinstr1+0x42>
      printf("open(%p) returned %d, not -1\n", (void*)addr, fd);
      exit(1);
    }
  }
}
      58:	60e6                	ld	ra,88(sp)
      5a:	6446                	ld	s0,80(sp)
      5c:	64a6                	ld	s1,72(sp)
      5e:	6906                	ld	s2,64(sp)
      60:	79e2                	ld	s3,56(sp)
      62:	7a42                	ld	s4,48(sp)
      64:	6125                	addi	sp,sp,96
      66:	8082                	ret
      printf("open(%p) returned %d, not -1\n", (void*)addr, fd);
      68:	862a                	mv	a2,a0
      6a:	85ca                	mv	a1,s2
      6c:	00005517          	auipc	a0,0x5
      70:	55450513          	addi	a0,a0,1364 # 55c0 <statistics+0x76>
      74:	328050ef          	jal	539c <printf>
      exit(1);
      78:	4505                	li	a0,1
      7a:	683040ef          	jal	4efc <exit>

000000000000007e <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      7e:	00009797          	auipc	a5,0x9
      82:	51a78793          	addi	a5,a5,1306 # 9598 <uninit>
      86:	0000c697          	auipc	a3,0xc
      8a:	c2268693          	addi	a3,a3,-990 # bca8 <buf>
    if(uninit[i] != '\0'){
      8e:	0007c703          	lbu	a4,0(a5)
      92:	e709                	bnez	a4,9c <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      94:	0785                	addi	a5,a5,1
      96:	fed79ce3          	bne	a5,a3,8e <bsstest+0x10>
      9a:	8082                	ret
{
      9c:	1141                	addi	sp,sp,-16
      9e:	e406                	sd	ra,8(sp)
      a0:	e022                	sd	s0,0(sp)
      a2:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      a4:	85aa                	mv	a1,a0
      a6:	00005517          	auipc	a0,0x5
      aa:	53a50513          	addi	a0,a0,1338 # 55e0 <statistics+0x96>
      ae:	2ee050ef          	jal	539c <printf>
      exit(1);
      b2:	4505                	li	a0,1
      b4:	649040ef          	jal	4efc <exit>

00000000000000b8 <opentest>:
{
      b8:	1101                	addi	sp,sp,-32
      ba:	ec06                	sd	ra,24(sp)
      bc:	e822                	sd	s0,16(sp)
      be:	e426                	sd	s1,8(sp)
      c0:	1000                	addi	s0,sp,32
      c2:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      c4:	4581                	li	a1,0
      c6:	00005517          	auipc	a0,0x5
      ca:	53250513          	addi	a0,a0,1330 # 55f8 <statistics+0xae>
      ce:	66f040ef          	jal	4f3c <open>
  if(fd < 0){
      d2:	02054263          	bltz	a0,f6 <opentest+0x3e>
  close(fd);
      d6:	64f040ef          	jal	4f24 <close>
  fd = open("doesnotexist", 0);
      da:	4581                	li	a1,0
      dc:	00005517          	auipc	a0,0x5
      e0:	53c50513          	addi	a0,a0,1340 # 5618 <statistics+0xce>
      e4:	659040ef          	jal	4f3c <open>
  if(fd >= 0){
      e8:	02055163          	bgez	a0,10a <opentest+0x52>
}
      ec:	60e2                	ld	ra,24(sp)
      ee:	6442                	ld	s0,16(sp)
      f0:	64a2                	ld	s1,8(sp)
      f2:	6105                	addi	sp,sp,32
      f4:	8082                	ret
    printf("%s: open echo failed!\n", s);
      f6:	85a6                	mv	a1,s1
      f8:	00005517          	auipc	a0,0x5
      fc:	50850513          	addi	a0,a0,1288 # 5600 <statistics+0xb6>
     100:	29c050ef          	jal	539c <printf>
    exit(1);
     104:	4505                	li	a0,1
     106:	5f7040ef          	jal	4efc <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     10a:	85a6                	mv	a1,s1
     10c:	00005517          	auipc	a0,0x5
     110:	51c50513          	addi	a0,a0,1308 # 5628 <statistics+0xde>
     114:	288050ef          	jal	539c <printf>
    exit(1);
     118:	4505                	li	a0,1
     11a:	5e3040ef          	jal	4efc <exit>

000000000000011e <truncate2>:
{
     11e:	7179                	addi	sp,sp,-48
     120:	f406                	sd	ra,40(sp)
     122:	f022                	sd	s0,32(sp)
     124:	ec26                	sd	s1,24(sp)
     126:	e84a                	sd	s2,16(sp)
     128:	e44e                	sd	s3,8(sp)
     12a:	1800                	addi	s0,sp,48
     12c:	89aa                	mv	s3,a0
  unlink("truncfile");
     12e:	00005517          	auipc	a0,0x5
     132:	52250513          	addi	a0,a0,1314 # 5650 <statistics+0x106>
     136:	617040ef          	jal	4f4c <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     13a:	60100593          	li	a1,1537
     13e:	00005517          	auipc	a0,0x5
     142:	51250513          	addi	a0,a0,1298 # 5650 <statistics+0x106>
     146:	5f7040ef          	jal	4f3c <open>
     14a:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     14c:	4611                	li	a2,4
     14e:	00005597          	auipc	a1,0x5
     152:	51258593          	addi	a1,a1,1298 # 5660 <statistics+0x116>
     156:	5c7040ef          	jal	4f1c <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     15a:	40100593          	li	a1,1025
     15e:	00005517          	auipc	a0,0x5
     162:	4f250513          	addi	a0,a0,1266 # 5650 <statistics+0x106>
     166:	5d7040ef          	jal	4f3c <open>
     16a:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     16c:	4605                	li	a2,1
     16e:	00005597          	auipc	a1,0x5
     172:	4fa58593          	addi	a1,a1,1274 # 5668 <statistics+0x11e>
     176:	8526                	mv	a0,s1
     178:	5a5040ef          	jal	4f1c <write>
  if(n != -1){
     17c:	57fd                	li	a5,-1
     17e:	02f51563          	bne	a0,a5,1a8 <truncate2+0x8a>
  unlink("truncfile");
     182:	00005517          	auipc	a0,0x5
     186:	4ce50513          	addi	a0,a0,1230 # 5650 <statistics+0x106>
     18a:	5c3040ef          	jal	4f4c <unlink>
  close(fd1);
     18e:	8526                	mv	a0,s1
     190:	595040ef          	jal	4f24 <close>
  close(fd2);
     194:	854a                	mv	a0,s2
     196:	58f040ef          	jal	4f24 <close>
}
     19a:	70a2                	ld	ra,40(sp)
     19c:	7402                	ld	s0,32(sp)
     19e:	64e2                	ld	s1,24(sp)
     1a0:	6942                	ld	s2,16(sp)
     1a2:	69a2                	ld	s3,8(sp)
     1a4:	6145                	addi	sp,sp,48
     1a6:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1a8:	862a                	mv	a2,a0
     1aa:	85ce                	mv	a1,s3
     1ac:	00005517          	auipc	a0,0x5
     1b0:	4c450513          	addi	a0,a0,1220 # 5670 <statistics+0x126>
     1b4:	1e8050ef          	jal	539c <printf>
    exit(1);
     1b8:	4505                	li	a0,1
     1ba:	543040ef          	jal	4efc <exit>

00000000000001be <createtest>:
{
     1be:	7139                	addi	sp,sp,-64
     1c0:	fc06                	sd	ra,56(sp)
     1c2:	f822                	sd	s0,48(sp)
     1c4:	f426                	sd	s1,40(sp)
     1c6:	f04a                	sd	s2,32(sp)
     1c8:	ec4e                	sd	s3,24(sp)
     1ca:	e852                	sd	s4,16(sp)
     1cc:	0080                	addi	s0,sp,64
  name[0] = 'a';
     1ce:	06100793          	li	a5,97
     1d2:	fcf40423          	sb	a5,-56(s0)
  name[2] = '\0';
     1d6:	fc040523          	sb	zero,-54(s0)
     1da:	03000493          	li	s1,48
    fd = open(name, O_CREATE|O_RDWR);
     1de:	fc840a13          	addi	s4,s0,-56
     1e2:	20200993          	li	s3,514
  for(i = 0; i < N; i++){
     1e6:	06400913          	li	s2,100
    name[1] = '0' + i;
     1ea:	fc9404a3          	sb	s1,-55(s0)
    fd = open(name, O_CREATE|O_RDWR);
     1ee:	85ce                	mv	a1,s3
     1f0:	8552                	mv	a0,s4
     1f2:	54b040ef          	jal	4f3c <open>
    close(fd);
     1f6:	52f040ef          	jal	4f24 <close>
  for(i = 0; i < N; i++){
     1fa:	2485                	addiw	s1,s1,1
     1fc:	0ff4f493          	zext.b	s1,s1
     200:	ff2495e3          	bne	s1,s2,1ea <createtest+0x2c>
  name[0] = 'a';
     204:	06100793          	li	a5,97
     208:	fcf40423          	sb	a5,-56(s0)
  name[2] = '\0';
     20c:	fc040523          	sb	zero,-54(s0)
     210:	03000493          	li	s1,48
    unlink(name);
     214:	fc840993          	addi	s3,s0,-56
  for(i = 0; i < N; i++){
     218:	06400913          	li	s2,100
    name[1] = '0' + i;
     21c:	fc9404a3          	sb	s1,-55(s0)
    unlink(name);
     220:	854e                	mv	a0,s3
     222:	52b040ef          	jal	4f4c <unlink>
  for(i = 0; i < N; i++){
     226:	2485                	addiw	s1,s1,1
     228:	0ff4f493          	zext.b	s1,s1
     22c:	ff2498e3          	bne	s1,s2,21c <createtest+0x5e>
}
     230:	70e2                	ld	ra,56(sp)
     232:	7442                	ld	s0,48(sp)
     234:	74a2                	ld	s1,40(sp)
     236:	7902                	ld	s2,32(sp)
     238:	69e2                	ld	s3,24(sp)
     23a:	6a42                	ld	s4,16(sp)
     23c:	6121                	addi	sp,sp,64
     23e:	8082                	ret

0000000000000240 <bigwrite>:
{
     240:	711d                	addi	sp,sp,-96
     242:	ec86                	sd	ra,88(sp)
     244:	e8a2                	sd	s0,80(sp)
     246:	e4a6                	sd	s1,72(sp)
     248:	e0ca                	sd	s2,64(sp)
     24a:	fc4e                	sd	s3,56(sp)
     24c:	f852                	sd	s4,48(sp)
     24e:	f456                	sd	s5,40(sp)
     250:	f05a                	sd	s6,32(sp)
     252:	ec5e                	sd	s7,24(sp)
     254:	e862                	sd	s8,16(sp)
     256:	e466                	sd	s9,8(sp)
     258:	1080                	addi	s0,sp,96
     25a:	8caa                	mv	s9,a0
  unlink("bigwrite");
     25c:	00005517          	auipc	a0,0x5
     260:	43c50513          	addi	a0,a0,1084 # 5698 <statistics+0x14e>
     264:	4e9040ef          	jal	4f4c <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     268:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     26c:	20200b93          	li	s7,514
     270:	00005a17          	auipc	s4,0x5
     274:	428a0a13          	addi	s4,s4,1064 # 5698 <statistics+0x14e>
    if(fd < 0){
     278:	4b09                	li	s6,2
      int cc = write(fd, buf, sz);
     27a:	0000c997          	auipc	s3,0xc
     27e:	a2e98993          	addi	s3,s3,-1490 # bca8 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     282:	6a8d                	lui	s5,0x3
     284:	1c9a8a93          	addi	s5,s5,457 # 31c9 <subdir+0x4cd>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     288:	85de                	mv	a1,s7
     28a:	8552                	mv	a0,s4
     28c:	4b1040ef          	jal	4f3c <open>
     290:	892a                	mv	s2,a0
    if(fd < 0){
     292:	04054463          	bltz	a0,2da <bigwrite+0x9a>
     296:	8c5a                	mv	s8,s6
      int cc = write(fd, buf, sz);
     298:	8626                	mv	a2,s1
     29a:	85ce                	mv	a1,s3
     29c:	854a                	mv	a0,s2
     29e:	47f040ef          	jal	4f1c <write>
      if(cc != sz){
     2a2:	04951663          	bne	a0,s1,2ee <bigwrite+0xae>
    for(i = 0; i < 2; i++){
     2a6:	3c7d                	addiw	s8,s8,-1
     2a8:	fe0c18e3          	bnez	s8,298 <bigwrite+0x58>
    close(fd);
     2ac:	854a                	mv	a0,s2
     2ae:	477040ef          	jal	4f24 <close>
    unlink("bigwrite");
     2b2:	8552                	mv	a0,s4
     2b4:	499040ef          	jal	4f4c <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2b8:	1d74849b          	addiw	s1,s1,471
     2bc:	fd5496e3          	bne	s1,s5,288 <bigwrite+0x48>
}
     2c0:	60e6                	ld	ra,88(sp)
     2c2:	6446                	ld	s0,80(sp)
     2c4:	64a6                	ld	s1,72(sp)
     2c6:	6906                	ld	s2,64(sp)
     2c8:	79e2                	ld	s3,56(sp)
     2ca:	7a42                	ld	s4,48(sp)
     2cc:	7aa2                	ld	s5,40(sp)
     2ce:	7b02                	ld	s6,32(sp)
     2d0:	6be2                	ld	s7,24(sp)
     2d2:	6c42                	ld	s8,16(sp)
     2d4:	6ca2                	ld	s9,8(sp)
     2d6:	6125                	addi	sp,sp,96
     2d8:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     2da:	85e6                	mv	a1,s9
     2dc:	00005517          	auipc	a0,0x5
     2e0:	3cc50513          	addi	a0,a0,972 # 56a8 <statistics+0x15e>
     2e4:	0b8050ef          	jal	539c <printf>
      exit(1);
     2e8:	4505                	li	a0,1
     2ea:	413040ef          	jal	4efc <exit>
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     2ee:	86aa                	mv	a3,a0
     2f0:	8626                	mv	a2,s1
     2f2:	85e6                	mv	a1,s9
     2f4:	00005517          	auipc	a0,0x5
     2f8:	3d450513          	addi	a0,a0,980 # 56c8 <statistics+0x17e>
     2fc:	0a0050ef          	jal	539c <printf>
        exit(1);
     300:	4505                	li	a0,1
     302:	3fb040ef          	jal	4efc <exit>

0000000000000306 <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     306:	7139                	addi	sp,sp,-64
     308:	fc06                	sd	ra,56(sp)
     30a:	f822                	sd	s0,48(sp)
     30c:	f426                	sd	s1,40(sp)
     30e:	f04a                	sd	s2,32(sp)
     310:	ec4e                	sd	s3,24(sp)
     312:	e852                	sd	s4,16(sp)
     314:	e456                	sd	s5,8(sp)
     316:	e05a                	sd	s6,0(sp)
     318:	0080                	addi	s0,sp,64
  int assumed_free = 600;
  
  unlink("junk");
     31a:	00005517          	auipc	a0,0x5
     31e:	3c650513          	addi	a0,a0,966 # 56e0 <statistics+0x196>
     322:	42b040ef          	jal	4f4c <unlink>
     326:	25800913          	li	s2,600
  for(int i = 0; i < assumed_free; i++){
    int fd = open("junk", O_CREATE|O_WRONLY);
     32a:	20100a93          	li	s5,513
     32e:	00005997          	auipc	s3,0x5
     332:	3b298993          	addi	s3,s3,946 # 56e0 <statistics+0x196>
    if(fd < 0){
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char*)0xffffffffffL, 1);
     336:	4b05                	li	s6,1
     338:	5a7d                	li	s4,-1
     33a:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
     33e:	85d6                	mv	a1,s5
     340:	854e                	mv	a0,s3
     342:	3fb040ef          	jal	4f3c <open>
     346:	84aa                	mv	s1,a0
    if(fd < 0){
     348:	04054d63          	bltz	a0,3a2 <badwrite+0x9c>
    write(fd, (char*)0xffffffffffL, 1);
     34c:	865a                	mv	a2,s6
     34e:	85d2                	mv	a1,s4
     350:	3cd040ef          	jal	4f1c <write>
    close(fd);
     354:	8526                	mv	a0,s1
     356:	3cf040ef          	jal	4f24 <close>
    unlink("junk");
     35a:	854e                	mv	a0,s3
     35c:	3f1040ef          	jal	4f4c <unlink>
  for(int i = 0; i < assumed_free; i++){
     360:	397d                	addiw	s2,s2,-1
     362:	fc091ee3          	bnez	s2,33e <badwrite+0x38>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
     366:	20100593          	li	a1,513
     36a:	00005517          	auipc	a0,0x5
     36e:	37650513          	addi	a0,a0,886 # 56e0 <statistics+0x196>
     372:	3cb040ef          	jal	4f3c <open>
     376:	84aa                	mv	s1,a0
  if(fd < 0){
     378:	02054e63          	bltz	a0,3b4 <badwrite+0xae>
    printf("open junk failed\n");
    exit(1);
  }
  if(write(fd, "x", 1) != 1){
     37c:	4605                	li	a2,1
     37e:	00005597          	auipc	a1,0x5
     382:	2ea58593          	addi	a1,a1,746 # 5668 <statistics+0x11e>
     386:	397040ef          	jal	4f1c <write>
     38a:	4785                	li	a5,1
     38c:	02f50d63          	beq	a0,a5,3c6 <badwrite+0xc0>
    printf("write failed\n");
     390:	00005517          	auipc	a0,0x5
     394:	37050513          	addi	a0,a0,880 # 5700 <statistics+0x1b6>
     398:	004050ef          	jal	539c <printf>
    exit(1);
     39c:	4505                	li	a0,1
     39e:	35f040ef          	jal	4efc <exit>
      printf("open junk failed\n");
     3a2:	00005517          	auipc	a0,0x5
     3a6:	34650513          	addi	a0,a0,838 # 56e8 <statistics+0x19e>
     3aa:	7f3040ef          	jal	539c <printf>
      exit(1);
     3ae:	4505                	li	a0,1
     3b0:	34d040ef          	jal	4efc <exit>
    printf("open junk failed\n");
     3b4:	00005517          	auipc	a0,0x5
     3b8:	33450513          	addi	a0,a0,820 # 56e8 <statistics+0x19e>
     3bc:	7e1040ef          	jal	539c <printf>
    exit(1);
     3c0:	4505                	li	a0,1
     3c2:	33b040ef          	jal	4efc <exit>
  }
  close(fd);
     3c6:	8526                	mv	a0,s1
     3c8:	35d040ef          	jal	4f24 <close>
  unlink("junk");
     3cc:	00005517          	auipc	a0,0x5
     3d0:	31450513          	addi	a0,a0,788 # 56e0 <statistics+0x196>
     3d4:	379040ef          	jal	4f4c <unlink>

  exit(0);
     3d8:	4501                	li	a0,0
     3da:	323040ef          	jal	4efc <exit>

00000000000003de <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     3de:	711d                	addi	sp,sp,-96
     3e0:	ec86                	sd	ra,88(sp)
     3e2:	e8a2                	sd	s0,80(sp)
     3e4:	e4a6                	sd	s1,72(sp)
     3e6:	e0ca                	sd	s2,64(sp)
     3e8:	fc4e                	sd	s3,56(sp)
     3ea:	f852                	sd	s4,48(sp)
     3ec:	f456                	sd	s5,40(sp)
     3ee:	1080                	addi	s0,sp,96
  int nzz = 32*32;
  for(int i = 0; i < nzz; i++){
     3f0:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     3f2:	07a00993          	li	s3,122
    name[1] = 'z';
    name[2] = '0' + (i / 32);
    name[3] = '0' + (i % 32);
    name[4] = '\0';
    unlink(name);
     3f6:	fa040913          	addi	s2,s0,-96
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     3fa:	60200a13          	li	s4,1538
  for(int i = 0; i < nzz; i++){
     3fe:	40000a93          	li	s5,1024
    name[0] = 'z';
     402:	fb340023          	sb	s3,-96(s0)
    name[1] = 'z';
     406:	fb3400a3          	sb	s3,-95(s0)
    name[2] = '0' + (i / 32);
     40a:	41f4d71b          	sraiw	a4,s1,0x1f
     40e:	01b7571b          	srliw	a4,a4,0x1b
     412:	009707bb          	addw	a5,a4,s1
     416:	4057d69b          	sraiw	a3,a5,0x5
     41a:	0306869b          	addiw	a3,a3,48
     41e:	fad40123          	sb	a3,-94(s0)
    name[3] = '0' + (i % 32);
     422:	8bfd                	andi	a5,a5,31
     424:	9f99                	subw	a5,a5,a4
     426:	0307879b          	addiw	a5,a5,48
     42a:	faf401a3          	sb	a5,-93(s0)
    name[4] = '\0';
     42e:	fa040223          	sb	zero,-92(s0)
    unlink(name);
     432:	854a                	mv	a0,s2
     434:	319040ef          	jal	4f4c <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     438:	85d2                	mv	a1,s4
     43a:	854a                	mv	a0,s2
     43c:	301040ef          	jal	4f3c <open>
    if(fd < 0){
     440:	00054763          	bltz	a0,44e <outofinodes+0x70>
      // failure is eventually expected.
      break;
    }
    close(fd);
     444:	2e1040ef          	jal	4f24 <close>
  for(int i = 0; i < nzz; i++){
     448:	2485                	addiw	s1,s1,1
     44a:	fb549ce3          	bne	s1,s5,402 <outofinodes+0x24>
  }

  for(int i = 0; i < nzz; i++){
     44e:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     450:	07a00913          	li	s2,122
    name[1] = 'z';
    name[2] = '0' + (i / 32);
    name[3] = '0' + (i % 32);
    name[4] = '\0';
    unlink(name);
     454:	fa040a13          	addi	s4,s0,-96
  for(int i = 0; i < nzz; i++){
     458:	40000993          	li	s3,1024
    name[0] = 'z';
     45c:	fb240023          	sb	s2,-96(s0)
    name[1] = 'z';
     460:	fb2400a3          	sb	s2,-95(s0)
    name[2] = '0' + (i / 32);
     464:	41f4d71b          	sraiw	a4,s1,0x1f
     468:	01b7571b          	srliw	a4,a4,0x1b
     46c:	009707bb          	addw	a5,a4,s1
     470:	4057d69b          	sraiw	a3,a5,0x5
     474:	0306869b          	addiw	a3,a3,48
     478:	fad40123          	sb	a3,-94(s0)
    name[3] = '0' + (i % 32);
     47c:	8bfd                	andi	a5,a5,31
     47e:	9f99                	subw	a5,a5,a4
     480:	0307879b          	addiw	a5,a5,48
     484:	faf401a3          	sb	a5,-93(s0)
    name[4] = '\0';
     488:	fa040223          	sb	zero,-92(s0)
    unlink(name);
     48c:	8552                	mv	a0,s4
     48e:	2bf040ef          	jal	4f4c <unlink>
  for(int i = 0; i < nzz; i++){
     492:	2485                	addiw	s1,s1,1
     494:	fd3494e3          	bne	s1,s3,45c <outofinodes+0x7e>
  }
}
     498:	60e6                	ld	ra,88(sp)
     49a:	6446                	ld	s0,80(sp)
     49c:	64a6                	ld	s1,72(sp)
     49e:	6906                	ld	s2,64(sp)
     4a0:	79e2                	ld	s3,56(sp)
     4a2:	7a42                	ld	s4,48(sp)
     4a4:	7aa2                	ld	s5,40(sp)
     4a6:	6125                	addi	sp,sp,96
     4a8:	8082                	ret

00000000000004aa <copyin>:
{
     4aa:	7175                	addi	sp,sp,-144
     4ac:	e506                	sd	ra,136(sp)
     4ae:	e122                	sd	s0,128(sp)
     4b0:	fca6                	sd	s1,120(sp)
     4b2:	f8ca                	sd	s2,112(sp)
     4b4:	f4ce                	sd	s3,104(sp)
     4b6:	f0d2                	sd	s4,96(sp)
     4b8:	ecd6                	sd	s5,88(sp)
     4ba:	e8da                	sd	s6,80(sp)
     4bc:	e4de                	sd	s7,72(sp)
     4be:	e0e2                	sd	s8,64(sp)
     4c0:	fc66                	sd	s9,56(sp)
     4c2:	0900                	addi	s0,sp,144
  uint64 addrs[] = { 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     4c4:	00007797          	auipc	a5,0x7
     4c8:	5ac78793          	addi	a5,a5,1452 # 7a70 <statistics+0x2526>
     4cc:	638c                	ld	a1,0(a5)
     4ce:	6790                	ld	a2,8(a5)
     4d0:	6b94                	ld	a3,16(a5)
     4d2:	6f98                	ld	a4,24(a5)
     4d4:	f6b43c23          	sd	a1,-136(s0)
     4d8:	f8c43023          	sd	a2,-128(s0)
     4dc:	f8d43423          	sd	a3,-120(s0)
     4e0:	f8e43823          	sd	a4,-112(s0)
     4e4:	739c                	ld	a5,32(a5)
     4e6:	f8f43c23          	sd	a5,-104(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     4ea:	f7840913          	addi	s2,s0,-136
     4ee:	fa040c93          	addi	s9,s0,-96
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     4f2:	20100b13          	li	s6,513
     4f6:	00005a97          	auipc	s5,0x5
     4fa:	21aa8a93          	addi	s5,s5,538 # 5710 <statistics+0x1c6>
    int n = write(fd, (void*)addr, 8192);
     4fe:	6a09                	lui	s4,0x2
    n = write(1, (char*)addr, 8192);
     500:	4c05                	li	s8,1
    if(pipe(fds) < 0){
     502:	f7040b93          	addi	s7,s0,-144
    uint64 addr = addrs[ai];
     506:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     50a:	85da                	mv	a1,s6
     50c:	8556                	mv	a0,s5
     50e:	22f040ef          	jal	4f3c <open>
     512:	84aa                	mv	s1,a0
    if(fd < 0){
     514:	06054a63          	bltz	a0,588 <copyin+0xde>
    int n = write(fd, (void*)addr, 8192);
     518:	8652                	mv	a2,s4
     51a:	85ce                	mv	a1,s3
     51c:	201040ef          	jal	4f1c <write>
    if(n >= 0){
     520:	06055d63          	bgez	a0,59a <copyin+0xf0>
    close(fd);
     524:	8526                	mv	a0,s1
     526:	1ff040ef          	jal	4f24 <close>
    unlink("copyin1");
     52a:	8556                	mv	a0,s5
     52c:	221040ef          	jal	4f4c <unlink>
    n = write(1, (char*)addr, 8192);
     530:	8652                	mv	a2,s4
     532:	85ce                	mv	a1,s3
     534:	8562                	mv	a0,s8
     536:	1e7040ef          	jal	4f1c <write>
    if(n > 0){
     53a:	06a04b63          	bgtz	a0,5b0 <copyin+0x106>
    if(pipe(fds) < 0){
     53e:	855e                	mv	a0,s7
     540:	1cd040ef          	jal	4f0c <pipe>
     544:	08054163          	bltz	a0,5c6 <copyin+0x11c>
    n = write(fds[1], (char*)addr, 8192);
     548:	8652                	mv	a2,s4
     54a:	85ce                	mv	a1,s3
     54c:	f7442503          	lw	a0,-140(s0)
     550:	1cd040ef          	jal	4f1c <write>
    if(n > 0){
     554:	08a04263          	bgtz	a0,5d8 <copyin+0x12e>
    close(fds[0]);
     558:	f7042503          	lw	a0,-144(s0)
     55c:	1c9040ef          	jal	4f24 <close>
    close(fds[1]);
     560:	f7442503          	lw	a0,-140(s0)
     564:	1c1040ef          	jal	4f24 <close>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     568:	0921                	addi	s2,s2,8
     56a:	f9991ee3          	bne	s2,s9,506 <copyin+0x5c>
}
     56e:	60aa                	ld	ra,136(sp)
     570:	640a                	ld	s0,128(sp)
     572:	74e6                	ld	s1,120(sp)
     574:	7946                	ld	s2,112(sp)
     576:	79a6                	ld	s3,104(sp)
     578:	7a06                	ld	s4,96(sp)
     57a:	6ae6                	ld	s5,88(sp)
     57c:	6b46                	ld	s6,80(sp)
     57e:	6ba6                	ld	s7,72(sp)
     580:	6c06                	ld	s8,64(sp)
     582:	7ce2                	ld	s9,56(sp)
     584:	6149                	addi	sp,sp,144
     586:	8082                	ret
      printf("open(copyin1) failed\n");
     588:	00005517          	auipc	a0,0x5
     58c:	19050513          	addi	a0,a0,400 # 5718 <statistics+0x1ce>
     590:	60d040ef          	jal	539c <printf>
      exit(1);
     594:	4505                	li	a0,1
     596:	167040ef          	jal	4efc <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", (void*)addr, n);
     59a:	862a                	mv	a2,a0
     59c:	85ce                	mv	a1,s3
     59e:	00005517          	auipc	a0,0x5
     5a2:	19250513          	addi	a0,a0,402 # 5730 <statistics+0x1e6>
     5a6:	5f7040ef          	jal	539c <printf>
      exit(1);
     5aa:	4505                	li	a0,1
     5ac:	151040ef          	jal	4efc <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     5b0:	862a                	mv	a2,a0
     5b2:	85ce                	mv	a1,s3
     5b4:	00005517          	auipc	a0,0x5
     5b8:	1ac50513          	addi	a0,a0,428 # 5760 <statistics+0x216>
     5bc:	5e1040ef          	jal	539c <printf>
      exit(1);
     5c0:	4505                	li	a0,1
     5c2:	13b040ef          	jal	4efc <exit>
      printf("pipe() failed\n");
     5c6:	00005517          	auipc	a0,0x5
     5ca:	1ca50513          	addi	a0,a0,458 # 5790 <statistics+0x246>
     5ce:	5cf040ef          	jal	539c <printf>
      exit(1);
     5d2:	4505                	li	a0,1
     5d4:	129040ef          	jal	4efc <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     5d8:	862a                	mv	a2,a0
     5da:	85ce                	mv	a1,s3
     5dc:	00005517          	auipc	a0,0x5
     5e0:	1c450513          	addi	a0,a0,452 # 57a0 <statistics+0x256>
     5e4:	5b9040ef          	jal	539c <printf>
      exit(1);
     5e8:	4505                	li	a0,1
     5ea:	113040ef          	jal	4efc <exit>

00000000000005ee <copyout>:
{
     5ee:	7135                	addi	sp,sp,-160
     5f0:	ed06                	sd	ra,152(sp)
     5f2:	e922                	sd	s0,144(sp)
     5f4:	e526                	sd	s1,136(sp)
     5f6:	e14a                	sd	s2,128(sp)
     5f8:	fcce                	sd	s3,120(sp)
     5fa:	f8d2                	sd	s4,112(sp)
     5fc:	f4d6                	sd	s5,104(sp)
     5fe:	f0da                	sd	s6,96(sp)
     600:	ecde                	sd	s7,88(sp)
     602:	e8e2                	sd	s8,80(sp)
     604:	e4e6                	sd	s9,72(sp)
     606:	1100                	addi	s0,sp,160
  uint64 addrs[] = { 0LL, 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     608:	00007797          	auipc	a5,0x7
     60c:	46878793          	addi	a5,a5,1128 # 7a70 <statistics+0x2526>
     610:	7788                	ld	a0,40(a5)
     612:	7b8c                	ld	a1,48(a5)
     614:	7f90                	ld	a2,56(a5)
     616:	63b4                	ld	a3,64(a5)
     618:	67b8                	ld	a4,72(a5)
     61a:	f6a43823          	sd	a0,-144(s0)
     61e:	f6b43c23          	sd	a1,-136(s0)
     622:	f8c43023          	sd	a2,-128(s0)
     626:	f8d43423          	sd	a3,-120(s0)
     62a:	f8e43823          	sd	a4,-112(s0)
     62e:	6bbc                	ld	a5,80(a5)
     630:	f8f43c23          	sd	a5,-104(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     634:	f7040913          	addi	s2,s0,-144
     638:	fa040c93          	addi	s9,s0,-96
    int fd = open("README", 0);
     63c:	00005b17          	auipc	s6,0x5
     640:	194b0b13          	addi	s6,s6,404 # 57d0 <statistics+0x286>
    int n = read(fd, (void*)addr, 8192);
     644:	6a89                	lui	s5,0x2
    if(pipe(fds) < 0){
     646:	f6840c13          	addi	s8,s0,-152
    n = write(fds[1], "x", 1);
     64a:	4a05                	li	s4,1
     64c:	00005b97          	auipc	s7,0x5
     650:	01cb8b93          	addi	s7,s7,28 # 5668 <statistics+0x11e>
    uint64 addr = addrs[ai];
     654:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     658:	4581                	li	a1,0
     65a:	855a                	mv	a0,s6
     65c:	0e1040ef          	jal	4f3c <open>
     660:	84aa                	mv	s1,a0
    if(fd < 0){
     662:	06054863          	bltz	a0,6d2 <copyout+0xe4>
    int n = read(fd, (void*)addr, 8192);
     666:	8656                	mv	a2,s5
     668:	85ce                	mv	a1,s3
     66a:	0ab040ef          	jal	4f14 <read>
    if(n > 0){
     66e:	06a04b63          	bgtz	a0,6e4 <copyout+0xf6>
    close(fd);
     672:	8526                	mv	a0,s1
     674:	0b1040ef          	jal	4f24 <close>
    if(pipe(fds) < 0){
     678:	8562                	mv	a0,s8
     67a:	093040ef          	jal	4f0c <pipe>
     67e:	06054e63          	bltz	a0,6fa <copyout+0x10c>
    n = write(fds[1], "x", 1);
     682:	8652                	mv	a2,s4
     684:	85de                	mv	a1,s7
     686:	f6c42503          	lw	a0,-148(s0)
     68a:	093040ef          	jal	4f1c <write>
    if(n != 1){
     68e:	07451f63          	bne	a0,s4,70c <copyout+0x11e>
    n = read(fds[0], (void*)addr, 8192);
     692:	8656                	mv	a2,s5
     694:	85ce                	mv	a1,s3
     696:	f6842503          	lw	a0,-152(s0)
     69a:	07b040ef          	jal	4f14 <read>
    if(n > 0){
     69e:	08a04063          	bgtz	a0,71e <copyout+0x130>
    close(fds[0]);
     6a2:	f6842503          	lw	a0,-152(s0)
     6a6:	07f040ef          	jal	4f24 <close>
    close(fds[1]);
     6aa:	f6c42503          	lw	a0,-148(s0)
     6ae:	077040ef          	jal	4f24 <close>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     6b2:	0921                	addi	s2,s2,8
     6b4:	fb9910e3          	bne	s2,s9,654 <copyout+0x66>
}
     6b8:	60ea                	ld	ra,152(sp)
     6ba:	644a                	ld	s0,144(sp)
     6bc:	64aa                	ld	s1,136(sp)
     6be:	690a                	ld	s2,128(sp)
     6c0:	79e6                	ld	s3,120(sp)
     6c2:	7a46                	ld	s4,112(sp)
     6c4:	7aa6                	ld	s5,104(sp)
     6c6:	7b06                	ld	s6,96(sp)
     6c8:	6be6                	ld	s7,88(sp)
     6ca:	6c46                	ld	s8,80(sp)
     6cc:	6ca6                	ld	s9,72(sp)
     6ce:	610d                	addi	sp,sp,160
     6d0:	8082                	ret
      printf("open(README) failed\n");
     6d2:	00005517          	auipc	a0,0x5
     6d6:	10650513          	addi	a0,a0,262 # 57d8 <statistics+0x28e>
     6da:	4c3040ef          	jal	539c <printf>
      exit(1);
     6de:	4505                	li	a0,1
     6e0:	01d040ef          	jal	4efc <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     6e4:	862a                	mv	a2,a0
     6e6:	85ce                	mv	a1,s3
     6e8:	00005517          	auipc	a0,0x5
     6ec:	10850513          	addi	a0,a0,264 # 57f0 <statistics+0x2a6>
     6f0:	4ad040ef          	jal	539c <printf>
      exit(1);
     6f4:	4505                	li	a0,1
     6f6:	007040ef          	jal	4efc <exit>
      printf("pipe() failed\n");
     6fa:	00005517          	auipc	a0,0x5
     6fe:	09650513          	addi	a0,a0,150 # 5790 <statistics+0x246>
     702:	49b040ef          	jal	539c <printf>
      exit(1);
     706:	4505                	li	a0,1
     708:	7f4040ef          	jal	4efc <exit>
      printf("pipe write failed\n");
     70c:	00005517          	auipc	a0,0x5
     710:	11450513          	addi	a0,a0,276 # 5820 <statistics+0x2d6>
     714:	489040ef          	jal	539c <printf>
      exit(1);
     718:	4505                	li	a0,1
     71a:	7e2040ef          	jal	4efc <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     71e:	862a                	mv	a2,a0
     720:	85ce                	mv	a1,s3
     722:	00005517          	auipc	a0,0x5
     726:	11650513          	addi	a0,a0,278 # 5838 <statistics+0x2ee>
     72a:	473040ef          	jal	539c <printf>
      exit(1);
     72e:	4505                	li	a0,1
     730:	7cc040ef          	jal	4efc <exit>

0000000000000734 <truncate1>:
{
     734:	711d                	addi	sp,sp,-96
     736:	ec86                	sd	ra,88(sp)
     738:	e8a2                	sd	s0,80(sp)
     73a:	e4a6                	sd	s1,72(sp)
     73c:	e0ca                	sd	s2,64(sp)
     73e:	fc4e                	sd	s3,56(sp)
     740:	f852                	sd	s4,48(sp)
     742:	f456                	sd	s5,40(sp)
     744:	1080                	addi	s0,sp,96
     746:	8a2a                	mv	s4,a0
  unlink("truncfile");
     748:	00005517          	auipc	a0,0x5
     74c:	f0850513          	addi	a0,a0,-248 # 5650 <statistics+0x106>
     750:	7fc040ef          	jal	4f4c <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     754:	60100593          	li	a1,1537
     758:	00005517          	auipc	a0,0x5
     75c:	ef850513          	addi	a0,a0,-264 # 5650 <statistics+0x106>
     760:	7dc040ef          	jal	4f3c <open>
     764:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     766:	4611                	li	a2,4
     768:	00005597          	auipc	a1,0x5
     76c:	ef858593          	addi	a1,a1,-264 # 5660 <statistics+0x116>
     770:	7ac040ef          	jal	4f1c <write>
  close(fd1);
     774:	8526                	mv	a0,s1
     776:	7ae040ef          	jal	4f24 <close>
  int fd2 = open("truncfile", O_RDONLY);
     77a:	4581                	li	a1,0
     77c:	00005517          	auipc	a0,0x5
     780:	ed450513          	addi	a0,a0,-300 # 5650 <statistics+0x106>
     784:	7b8040ef          	jal	4f3c <open>
     788:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     78a:	02000613          	li	a2,32
     78e:	fa040593          	addi	a1,s0,-96
     792:	782040ef          	jal	4f14 <read>
  if(n != 4){
     796:	4791                	li	a5,4
     798:	0af51863          	bne	a0,a5,848 <truncate1+0x114>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     79c:	40100593          	li	a1,1025
     7a0:	00005517          	auipc	a0,0x5
     7a4:	eb050513          	addi	a0,a0,-336 # 5650 <statistics+0x106>
     7a8:	794040ef          	jal	4f3c <open>
     7ac:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     7ae:	4581                	li	a1,0
     7b0:	00005517          	auipc	a0,0x5
     7b4:	ea050513          	addi	a0,a0,-352 # 5650 <statistics+0x106>
     7b8:	784040ef          	jal	4f3c <open>
     7bc:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     7be:	02000613          	li	a2,32
     7c2:	fa040593          	addi	a1,s0,-96
     7c6:	74e040ef          	jal	4f14 <read>
     7ca:	8aaa                	mv	s5,a0
  if(n != 0){
     7cc:	e949                	bnez	a0,85e <truncate1+0x12a>
  n = read(fd2, buf, sizeof(buf));
     7ce:	02000613          	li	a2,32
     7d2:	fa040593          	addi	a1,s0,-96
     7d6:	8526                	mv	a0,s1
     7d8:	73c040ef          	jal	4f14 <read>
     7dc:	8aaa                	mv	s5,a0
  if(n != 0){
     7de:	e155                	bnez	a0,882 <truncate1+0x14e>
  write(fd1, "abcdef", 6);
     7e0:	4619                	li	a2,6
     7e2:	00005597          	auipc	a1,0x5
     7e6:	0e658593          	addi	a1,a1,230 # 58c8 <statistics+0x37e>
     7ea:	854e                	mv	a0,s3
     7ec:	730040ef          	jal	4f1c <write>
  n = read(fd3, buf, sizeof(buf));
     7f0:	02000613          	li	a2,32
     7f4:	fa040593          	addi	a1,s0,-96
     7f8:	854a                	mv	a0,s2
     7fa:	71a040ef          	jal	4f14 <read>
  if(n != 6){
     7fe:	4799                	li	a5,6
     800:	0af51363          	bne	a0,a5,8a6 <truncate1+0x172>
  n = read(fd2, buf, sizeof(buf));
     804:	02000613          	li	a2,32
     808:	fa040593          	addi	a1,s0,-96
     80c:	8526                	mv	a0,s1
     80e:	706040ef          	jal	4f14 <read>
  if(n != 2){
     812:	4789                	li	a5,2
     814:	0af51463          	bne	a0,a5,8bc <truncate1+0x188>
  unlink("truncfile");
     818:	00005517          	auipc	a0,0x5
     81c:	e3850513          	addi	a0,a0,-456 # 5650 <statistics+0x106>
     820:	72c040ef          	jal	4f4c <unlink>
  close(fd1);
     824:	854e                	mv	a0,s3
     826:	6fe040ef          	jal	4f24 <close>
  close(fd2);
     82a:	8526                	mv	a0,s1
     82c:	6f8040ef          	jal	4f24 <close>
  close(fd3);
     830:	854a                	mv	a0,s2
     832:	6f2040ef          	jal	4f24 <close>
}
     836:	60e6                	ld	ra,88(sp)
     838:	6446                	ld	s0,80(sp)
     83a:	64a6                	ld	s1,72(sp)
     83c:	6906                	ld	s2,64(sp)
     83e:	79e2                	ld	s3,56(sp)
     840:	7a42                	ld	s4,48(sp)
     842:	7aa2                	ld	s5,40(sp)
     844:	6125                	addi	sp,sp,96
     846:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     848:	862a                	mv	a2,a0
     84a:	85d2                	mv	a1,s4
     84c:	00005517          	auipc	a0,0x5
     850:	01c50513          	addi	a0,a0,28 # 5868 <statistics+0x31e>
     854:	349040ef          	jal	539c <printf>
    exit(1);
     858:	4505                	li	a0,1
     85a:	6a2040ef          	jal	4efc <exit>
    printf("aaa fd3=%d\n", fd3);
     85e:	85ca                	mv	a1,s2
     860:	00005517          	auipc	a0,0x5
     864:	02850513          	addi	a0,a0,40 # 5888 <statistics+0x33e>
     868:	335040ef          	jal	539c <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     86c:	8656                	mv	a2,s5
     86e:	85d2                	mv	a1,s4
     870:	00005517          	auipc	a0,0x5
     874:	02850513          	addi	a0,a0,40 # 5898 <statistics+0x34e>
     878:	325040ef          	jal	539c <printf>
    exit(1);
     87c:	4505                	li	a0,1
     87e:	67e040ef          	jal	4efc <exit>
    printf("bbb fd2=%d\n", fd2);
     882:	85a6                	mv	a1,s1
     884:	00005517          	auipc	a0,0x5
     888:	03450513          	addi	a0,a0,52 # 58b8 <statistics+0x36e>
     88c:	311040ef          	jal	539c <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     890:	8656                	mv	a2,s5
     892:	85d2                	mv	a1,s4
     894:	00005517          	auipc	a0,0x5
     898:	00450513          	addi	a0,a0,4 # 5898 <statistics+0x34e>
     89c:	301040ef          	jal	539c <printf>
    exit(1);
     8a0:	4505                	li	a0,1
     8a2:	65a040ef          	jal	4efc <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     8a6:	862a                	mv	a2,a0
     8a8:	85d2                	mv	a1,s4
     8aa:	00005517          	auipc	a0,0x5
     8ae:	02650513          	addi	a0,a0,38 # 58d0 <statistics+0x386>
     8b2:	2eb040ef          	jal	539c <printf>
    exit(1);
     8b6:	4505                	li	a0,1
     8b8:	644040ef          	jal	4efc <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     8bc:	862a                	mv	a2,a0
     8be:	85d2                	mv	a1,s4
     8c0:	00005517          	auipc	a0,0x5
     8c4:	03050513          	addi	a0,a0,48 # 58f0 <statistics+0x3a6>
     8c8:	2d5040ef          	jal	539c <printf>
    exit(1);
     8cc:	4505                	li	a0,1
     8ce:	62e040ef          	jal	4efc <exit>

00000000000008d2 <writetest>:
{
     8d2:	715d                	addi	sp,sp,-80
     8d4:	e486                	sd	ra,72(sp)
     8d6:	e0a2                	sd	s0,64(sp)
     8d8:	fc26                	sd	s1,56(sp)
     8da:	f84a                	sd	s2,48(sp)
     8dc:	f44e                	sd	s3,40(sp)
     8de:	f052                	sd	s4,32(sp)
     8e0:	ec56                	sd	s5,24(sp)
     8e2:	e85a                	sd	s6,16(sp)
     8e4:	e45e                	sd	s7,8(sp)
     8e6:	0880                	addi	s0,sp,80
     8e8:	8baa                	mv	s7,a0
  fd = open("small", O_CREATE|O_RDWR);
     8ea:	20200593          	li	a1,514
     8ee:	00005517          	auipc	a0,0x5
     8f2:	02250513          	addi	a0,a0,34 # 5910 <statistics+0x3c6>
     8f6:	646040ef          	jal	4f3c <open>
  if(fd < 0){
     8fa:	08054f63          	bltz	a0,998 <writetest+0xc6>
     8fe:	89aa                	mv	s3,a0
     900:	4901                	li	s2,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     902:	44a9                	li	s1,10
     904:	00005a17          	auipc	s4,0x5
     908:	034a0a13          	addi	s4,s4,52 # 5938 <statistics+0x3ee>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     90c:	00005b17          	auipc	s6,0x5
     910:	064b0b13          	addi	s6,s6,100 # 5970 <statistics+0x426>
  for(i = 0; i < N; i++){
     914:	06400a93          	li	s5,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     918:	8626                	mv	a2,s1
     91a:	85d2                	mv	a1,s4
     91c:	854e                	mv	a0,s3
     91e:	5fe040ef          	jal	4f1c <write>
     922:	08951563          	bne	a0,s1,9ac <writetest+0xda>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     926:	8626                	mv	a2,s1
     928:	85da                	mv	a1,s6
     92a:	854e                	mv	a0,s3
     92c:	5f0040ef          	jal	4f1c <write>
     930:	08951963          	bne	a0,s1,9c2 <writetest+0xf0>
  for(i = 0; i < N; i++){
     934:	2905                	addiw	s2,s2,1
     936:	ff5911e3          	bne	s2,s5,918 <writetest+0x46>
  close(fd);
     93a:	854e                	mv	a0,s3
     93c:	5e8040ef          	jal	4f24 <close>
  fd = open("small", O_RDONLY);
     940:	4581                	li	a1,0
     942:	00005517          	auipc	a0,0x5
     946:	fce50513          	addi	a0,a0,-50 # 5910 <statistics+0x3c6>
     94a:	5f2040ef          	jal	4f3c <open>
     94e:	84aa                	mv	s1,a0
  if(fd < 0){
     950:	08054463          	bltz	a0,9d8 <writetest+0x106>
  i = read(fd, buf, N*SZ*2);
     954:	7d000613          	li	a2,2000
     958:	0000b597          	auipc	a1,0xb
     95c:	35058593          	addi	a1,a1,848 # bca8 <buf>
     960:	5b4040ef          	jal	4f14 <read>
  if(i != N*SZ*2){
     964:	7d000793          	li	a5,2000
     968:	08f51263          	bne	a0,a5,9ec <writetest+0x11a>
  close(fd);
     96c:	8526                	mv	a0,s1
     96e:	5b6040ef          	jal	4f24 <close>
  if(unlink("small") < 0){
     972:	00005517          	auipc	a0,0x5
     976:	f9e50513          	addi	a0,a0,-98 # 5910 <statistics+0x3c6>
     97a:	5d2040ef          	jal	4f4c <unlink>
     97e:	08054163          	bltz	a0,a00 <writetest+0x12e>
}
     982:	60a6                	ld	ra,72(sp)
     984:	6406                	ld	s0,64(sp)
     986:	74e2                	ld	s1,56(sp)
     988:	7942                	ld	s2,48(sp)
     98a:	79a2                	ld	s3,40(sp)
     98c:	7a02                	ld	s4,32(sp)
     98e:	6ae2                	ld	s5,24(sp)
     990:	6b42                	ld	s6,16(sp)
     992:	6ba2                	ld	s7,8(sp)
     994:	6161                	addi	sp,sp,80
     996:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     998:	85de                	mv	a1,s7
     99a:	00005517          	auipc	a0,0x5
     99e:	f7e50513          	addi	a0,a0,-130 # 5918 <statistics+0x3ce>
     9a2:	1fb040ef          	jal	539c <printf>
    exit(1);
     9a6:	4505                	li	a0,1
     9a8:	554040ef          	jal	4efc <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     9ac:	864a                	mv	a2,s2
     9ae:	85de                	mv	a1,s7
     9b0:	00005517          	auipc	a0,0x5
     9b4:	f9850513          	addi	a0,a0,-104 # 5948 <statistics+0x3fe>
     9b8:	1e5040ef          	jal	539c <printf>
      exit(1);
     9bc:	4505                	li	a0,1
     9be:	53e040ef          	jal	4efc <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     9c2:	864a                	mv	a2,s2
     9c4:	85de                	mv	a1,s7
     9c6:	00005517          	auipc	a0,0x5
     9ca:	fba50513          	addi	a0,a0,-70 # 5980 <statistics+0x436>
     9ce:	1cf040ef          	jal	539c <printf>
      exit(1);
     9d2:	4505                	li	a0,1
     9d4:	528040ef          	jal	4efc <exit>
    printf("%s: error: open small failed!\n", s);
     9d8:	85de                	mv	a1,s7
     9da:	00005517          	auipc	a0,0x5
     9de:	fce50513          	addi	a0,a0,-50 # 59a8 <statistics+0x45e>
     9e2:	1bb040ef          	jal	539c <printf>
    exit(1);
     9e6:	4505                	li	a0,1
     9e8:	514040ef          	jal	4efc <exit>
    printf("%s: read failed\n", s);
     9ec:	85de                	mv	a1,s7
     9ee:	00005517          	auipc	a0,0x5
     9f2:	fda50513          	addi	a0,a0,-38 # 59c8 <statistics+0x47e>
     9f6:	1a7040ef          	jal	539c <printf>
    exit(1);
     9fa:	4505                	li	a0,1
     9fc:	500040ef          	jal	4efc <exit>
    printf("%s: unlink small failed\n", s);
     a00:	85de                	mv	a1,s7
     a02:	00005517          	auipc	a0,0x5
     a06:	fde50513          	addi	a0,a0,-34 # 59e0 <statistics+0x496>
     a0a:	193040ef          	jal	539c <printf>
    exit(1);
     a0e:	4505                	li	a0,1
     a10:	4ec040ef          	jal	4efc <exit>

0000000000000a14 <writebig>:
{
     a14:	7139                	addi	sp,sp,-64
     a16:	fc06                	sd	ra,56(sp)
     a18:	f822                	sd	s0,48(sp)
     a1a:	f426                	sd	s1,40(sp)
     a1c:	f04a                	sd	s2,32(sp)
     a1e:	ec4e                	sd	s3,24(sp)
     a20:	e852                	sd	s4,16(sp)
     a22:	e456                	sd	s5,8(sp)
     a24:	e05a                	sd	s6,0(sp)
     a26:	0080                	addi	s0,sp,64
     a28:	8b2a                	mv	s6,a0
  fd = open("big", O_CREATE|O_RDWR);
     a2a:	20200593          	li	a1,514
     a2e:	00005517          	auipc	a0,0x5
     a32:	fd250513          	addi	a0,a0,-46 # 5a00 <statistics+0x4b6>
     a36:	506040ef          	jal	4f3c <open>
  if(fd < 0){
     a3a:	06054a63          	bltz	a0,aae <writebig+0x9a>
     a3e:	8a2a                	mv	s4,a0
     a40:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     a42:	0000b997          	auipc	s3,0xb
     a46:	26698993          	addi	s3,s3,614 # bca8 <buf>
    if(write(fd, buf, BSIZE) != BSIZE){
     a4a:	40000913          	li	s2,1024
  for(i = 0; i < MAXFILE; i++){
     a4e:	10c00a93          	li	s5,268
    ((int*)buf)[0] = i;
     a52:	0099a023          	sw	s1,0(s3)
    if(write(fd, buf, BSIZE) != BSIZE){
     a56:	864a                	mv	a2,s2
     a58:	85ce                	mv	a1,s3
     a5a:	8552                	mv	a0,s4
     a5c:	4c0040ef          	jal	4f1c <write>
     a60:	07251163          	bne	a0,s2,ac2 <writebig+0xae>
  for(i = 0; i < MAXFILE; i++){
     a64:	2485                	addiw	s1,s1,1
     a66:	ff5496e3          	bne	s1,s5,a52 <writebig+0x3e>
  close(fd);
     a6a:	8552                	mv	a0,s4
     a6c:	4b8040ef          	jal	4f24 <close>
  fd = open("big", O_RDONLY);
     a70:	4581                	li	a1,0
     a72:	00005517          	auipc	a0,0x5
     a76:	f8e50513          	addi	a0,a0,-114 # 5a00 <statistics+0x4b6>
     a7a:	4c2040ef          	jal	4f3c <open>
     a7e:	8a2a                	mv	s4,a0
  n = 0;
     a80:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     a82:	40000993          	li	s3,1024
     a86:	0000b917          	auipc	s2,0xb
     a8a:	22290913          	addi	s2,s2,546 # bca8 <buf>
  if(fd < 0){
     a8e:	04054563          	bltz	a0,ad8 <writebig+0xc4>
    i = read(fd, buf, BSIZE);
     a92:	864e                	mv	a2,s3
     a94:	85ca                	mv	a1,s2
     a96:	8552                	mv	a0,s4
     a98:	47c040ef          	jal	4f14 <read>
    if(i == 0){
     a9c:	c921                	beqz	a0,aec <writebig+0xd8>
    } else if(i != BSIZE){
     a9e:	09351b63          	bne	a0,s3,b34 <writebig+0x120>
    if(((int*)buf)[0] != n){
     aa2:	00092683          	lw	a3,0(s2)
     aa6:	0a969263          	bne	a3,s1,b4a <writebig+0x136>
    n++;
     aaa:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     aac:	b7dd                	j	a92 <writebig+0x7e>
    printf("%s: error: creat big failed!\n", s);
     aae:	85da                	mv	a1,s6
     ab0:	00005517          	auipc	a0,0x5
     ab4:	f5850513          	addi	a0,a0,-168 # 5a08 <statistics+0x4be>
     ab8:	0e5040ef          	jal	539c <printf>
    exit(1);
     abc:	4505                	li	a0,1
     abe:	43e040ef          	jal	4efc <exit>
      printf("%s: error: write big file failed i=%d\n", s, i);
     ac2:	8626                	mv	a2,s1
     ac4:	85da                	mv	a1,s6
     ac6:	00005517          	auipc	a0,0x5
     aca:	f6250513          	addi	a0,a0,-158 # 5a28 <statistics+0x4de>
     ace:	0cf040ef          	jal	539c <printf>
      exit(1);
     ad2:	4505                	li	a0,1
     ad4:	428040ef          	jal	4efc <exit>
    printf("%s: error: open big failed!\n", s);
     ad8:	85da                	mv	a1,s6
     ada:	00005517          	auipc	a0,0x5
     ade:	f7650513          	addi	a0,a0,-138 # 5a50 <statistics+0x506>
     ae2:	0bb040ef          	jal	539c <printf>
    exit(1);
     ae6:	4505                	li	a0,1
     ae8:	414040ef          	jal	4efc <exit>
      if(n != MAXFILE){
     aec:	10c00793          	li	a5,268
     af0:	02f49763          	bne	s1,a5,b1e <writebig+0x10a>
  close(fd);
     af4:	8552                	mv	a0,s4
     af6:	42e040ef          	jal	4f24 <close>
  if(unlink("big") < 0){
     afa:	00005517          	auipc	a0,0x5
     afe:	f0650513          	addi	a0,a0,-250 # 5a00 <statistics+0x4b6>
     b02:	44a040ef          	jal	4f4c <unlink>
     b06:	04054d63          	bltz	a0,b60 <writebig+0x14c>
}
     b0a:	70e2                	ld	ra,56(sp)
     b0c:	7442                	ld	s0,48(sp)
     b0e:	74a2                	ld	s1,40(sp)
     b10:	7902                	ld	s2,32(sp)
     b12:	69e2                	ld	s3,24(sp)
     b14:	6a42                	ld	s4,16(sp)
     b16:	6aa2                	ld	s5,8(sp)
     b18:	6b02                	ld	s6,0(sp)
     b1a:	6121                	addi	sp,sp,64
     b1c:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     b1e:	8626                	mv	a2,s1
     b20:	85da                	mv	a1,s6
     b22:	00005517          	auipc	a0,0x5
     b26:	f4e50513          	addi	a0,a0,-178 # 5a70 <statistics+0x526>
     b2a:	073040ef          	jal	539c <printf>
        exit(1);
     b2e:	4505                	li	a0,1
     b30:	3cc040ef          	jal	4efc <exit>
      printf("%s: read failed %d\n", s, i);
     b34:	862a                	mv	a2,a0
     b36:	85da                	mv	a1,s6
     b38:	00005517          	auipc	a0,0x5
     b3c:	f6050513          	addi	a0,a0,-160 # 5a98 <statistics+0x54e>
     b40:	05d040ef          	jal	539c <printf>
      exit(1);
     b44:	4505                	li	a0,1
     b46:	3b6040ef          	jal	4efc <exit>
      printf("%s: read content of block %d is %d\n", s,
     b4a:	8626                	mv	a2,s1
     b4c:	85da                	mv	a1,s6
     b4e:	00005517          	auipc	a0,0x5
     b52:	f6250513          	addi	a0,a0,-158 # 5ab0 <statistics+0x566>
     b56:	047040ef          	jal	539c <printf>
      exit(1);
     b5a:	4505                	li	a0,1
     b5c:	3a0040ef          	jal	4efc <exit>
    printf("%s: unlink big failed\n", s);
     b60:	85da                	mv	a1,s6
     b62:	00005517          	auipc	a0,0x5
     b66:	f7650513          	addi	a0,a0,-138 # 5ad8 <statistics+0x58e>
     b6a:	033040ef          	jal	539c <printf>
    exit(1);
     b6e:	4505                	li	a0,1
     b70:	38c040ef          	jal	4efc <exit>

0000000000000b74 <unlinkread>:
{
     b74:	7179                	addi	sp,sp,-48
     b76:	f406                	sd	ra,40(sp)
     b78:	f022                	sd	s0,32(sp)
     b7a:	ec26                	sd	s1,24(sp)
     b7c:	e84a                	sd	s2,16(sp)
     b7e:	e44e                	sd	s3,8(sp)
     b80:	1800                	addi	s0,sp,48
     b82:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     b84:	20200593          	li	a1,514
     b88:	00005517          	auipc	a0,0x5
     b8c:	f6850513          	addi	a0,a0,-152 # 5af0 <statistics+0x5a6>
     b90:	3ac040ef          	jal	4f3c <open>
  if(fd < 0){
     b94:	0a054f63          	bltz	a0,c52 <unlinkread+0xde>
     b98:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     b9a:	4615                	li	a2,5
     b9c:	00005597          	auipc	a1,0x5
     ba0:	f8458593          	addi	a1,a1,-124 # 5b20 <statistics+0x5d6>
     ba4:	378040ef          	jal	4f1c <write>
  close(fd);
     ba8:	8526                	mv	a0,s1
     baa:	37a040ef          	jal	4f24 <close>
  fd = open("unlinkread", O_RDWR);
     bae:	4589                	li	a1,2
     bb0:	00005517          	auipc	a0,0x5
     bb4:	f4050513          	addi	a0,a0,-192 # 5af0 <statistics+0x5a6>
     bb8:	384040ef          	jal	4f3c <open>
     bbc:	84aa                	mv	s1,a0
  if(fd < 0){
     bbe:	0a054463          	bltz	a0,c66 <unlinkread+0xf2>
  if(unlink("unlinkread") != 0){
     bc2:	00005517          	auipc	a0,0x5
     bc6:	f2e50513          	addi	a0,a0,-210 # 5af0 <statistics+0x5a6>
     bca:	382040ef          	jal	4f4c <unlink>
     bce:	e555                	bnez	a0,c7a <unlinkread+0x106>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     bd0:	20200593          	li	a1,514
     bd4:	00005517          	auipc	a0,0x5
     bd8:	f1c50513          	addi	a0,a0,-228 # 5af0 <statistics+0x5a6>
     bdc:	360040ef          	jal	4f3c <open>
     be0:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     be2:	460d                	li	a2,3
     be4:	00005597          	auipc	a1,0x5
     be8:	f8458593          	addi	a1,a1,-124 # 5b68 <statistics+0x61e>
     bec:	330040ef          	jal	4f1c <write>
  close(fd1);
     bf0:	854a                	mv	a0,s2
     bf2:	332040ef          	jal	4f24 <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     bf6:	660d                	lui	a2,0x3
     bf8:	0000b597          	auipc	a1,0xb
     bfc:	0b058593          	addi	a1,a1,176 # bca8 <buf>
     c00:	8526                	mv	a0,s1
     c02:	312040ef          	jal	4f14 <read>
     c06:	4795                	li	a5,5
     c08:	08f51363          	bne	a0,a5,c8e <unlinkread+0x11a>
  if(buf[0] != 'h'){
     c0c:	0000b717          	auipc	a4,0xb
     c10:	09c74703          	lbu	a4,156(a4) # bca8 <buf>
     c14:	06800793          	li	a5,104
     c18:	08f71563          	bne	a4,a5,ca2 <unlinkread+0x12e>
  if(write(fd, buf, 10) != 10){
     c1c:	4629                	li	a2,10
     c1e:	0000b597          	auipc	a1,0xb
     c22:	08a58593          	addi	a1,a1,138 # bca8 <buf>
     c26:	8526                	mv	a0,s1
     c28:	2f4040ef          	jal	4f1c <write>
     c2c:	47a9                	li	a5,10
     c2e:	08f51463          	bne	a0,a5,cb6 <unlinkread+0x142>
  close(fd);
     c32:	8526                	mv	a0,s1
     c34:	2f0040ef          	jal	4f24 <close>
  unlink("unlinkread");
     c38:	00005517          	auipc	a0,0x5
     c3c:	eb850513          	addi	a0,a0,-328 # 5af0 <statistics+0x5a6>
     c40:	30c040ef          	jal	4f4c <unlink>
}
     c44:	70a2                	ld	ra,40(sp)
     c46:	7402                	ld	s0,32(sp)
     c48:	64e2                	ld	s1,24(sp)
     c4a:	6942                	ld	s2,16(sp)
     c4c:	69a2                	ld	s3,8(sp)
     c4e:	6145                	addi	sp,sp,48
     c50:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     c52:	85ce                	mv	a1,s3
     c54:	00005517          	auipc	a0,0x5
     c58:	eac50513          	addi	a0,a0,-340 # 5b00 <statistics+0x5b6>
     c5c:	740040ef          	jal	539c <printf>
    exit(1);
     c60:	4505                	li	a0,1
     c62:	29a040ef          	jal	4efc <exit>
    printf("%s: open unlinkread failed\n", s);
     c66:	85ce                	mv	a1,s3
     c68:	00005517          	auipc	a0,0x5
     c6c:	ec050513          	addi	a0,a0,-320 # 5b28 <statistics+0x5de>
     c70:	72c040ef          	jal	539c <printf>
    exit(1);
     c74:	4505                	li	a0,1
     c76:	286040ef          	jal	4efc <exit>
    printf("%s: unlink unlinkread failed\n", s);
     c7a:	85ce                	mv	a1,s3
     c7c:	00005517          	auipc	a0,0x5
     c80:	ecc50513          	addi	a0,a0,-308 # 5b48 <statistics+0x5fe>
     c84:	718040ef          	jal	539c <printf>
    exit(1);
     c88:	4505                	li	a0,1
     c8a:	272040ef          	jal	4efc <exit>
    printf("%s: unlinkread read failed", s);
     c8e:	85ce                	mv	a1,s3
     c90:	00005517          	auipc	a0,0x5
     c94:	ee050513          	addi	a0,a0,-288 # 5b70 <statistics+0x626>
     c98:	704040ef          	jal	539c <printf>
    exit(1);
     c9c:	4505                	li	a0,1
     c9e:	25e040ef          	jal	4efc <exit>
    printf("%s: unlinkread wrong data\n", s);
     ca2:	85ce                	mv	a1,s3
     ca4:	00005517          	auipc	a0,0x5
     ca8:	eec50513          	addi	a0,a0,-276 # 5b90 <statistics+0x646>
     cac:	6f0040ef          	jal	539c <printf>
    exit(1);
     cb0:	4505                	li	a0,1
     cb2:	24a040ef          	jal	4efc <exit>
    printf("%s: unlinkread write failed\n", s);
     cb6:	85ce                	mv	a1,s3
     cb8:	00005517          	auipc	a0,0x5
     cbc:	ef850513          	addi	a0,a0,-264 # 5bb0 <statistics+0x666>
     cc0:	6dc040ef          	jal	539c <printf>
    exit(1);
     cc4:	4505                	li	a0,1
     cc6:	236040ef          	jal	4efc <exit>

0000000000000cca <linktest>:
{
     cca:	1101                	addi	sp,sp,-32
     ccc:	ec06                	sd	ra,24(sp)
     cce:	e822                	sd	s0,16(sp)
     cd0:	e426                	sd	s1,8(sp)
     cd2:	e04a                	sd	s2,0(sp)
     cd4:	1000                	addi	s0,sp,32
     cd6:	892a                	mv	s2,a0
  unlink("lf1");
     cd8:	00005517          	auipc	a0,0x5
     cdc:	ef850513          	addi	a0,a0,-264 # 5bd0 <statistics+0x686>
     ce0:	26c040ef          	jal	4f4c <unlink>
  unlink("lf2");
     ce4:	00005517          	auipc	a0,0x5
     ce8:	ef450513          	addi	a0,a0,-268 # 5bd8 <statistics+0x68e>
     cec:	260040ef          	jal	4f4c <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     cf0:	20200593          	li	a1,514
     cf4:	00005517          	auipc	a0,0x5
     cf8:	edc50513          	addi	a0,a0,-292 # 5bd0 <statistics+0x686>
     cfc:	240040ef          	jal	4f3c <open>
  if(fd < 0){
     d00:	0c054f63          	bltz	a0,dde <linktest+0x114>
     d04:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     d06:	4615                	li	a2,5
     d08:	00005597          	auipc	a1,0x5
     d0c:	e1858593          	addi	a1,a1,-488 # 5b20 <statistics+0x5d6>
     d10:	20c040ef          	jal	4f1c <write>
     d14:	4795                	li	a5,5
     d16:	0cf51e63          	bne	a0,a5,df2 <linktest+0x128>
  close(fd);
     d1a:	8526                	mv	a0,s1
     d1c:	208040ef          	jal	4f24 <close>
  if(link("lf1", "lf2") < 0){
     d20:	00005597          	auipc	a1,0x5
     d24:	eb858593          	addi	a1,a1,-328 # 5bd8 <statistics+0x68e>
     d28:	00005517          	auipc	a0,0x5
     d2c:	ea850513          	addi	a0,a0,-344 # 5bd0 <statistics+0x686>
     d30:	22c040ef          	jal	4f5c <link>
     d34:	0c054963          	bltz	a0,e06 <linktest+0x13c>
  unlink("lf1");
     d38:	00005517          	auipc	a0,0x5
     d3c:	e9850513          	addi	a0,a0,-360 # 5bd0 <statistics+0x686>
     d40:	20c040ef          	jal	4f4c <unlink>
  if(open("lf1", 0) >= 0){
     d44:	4581                	li	a1,0
     d46:	00005517          	auipc	a0,0x5
     d4a:	e8a50513          	addi	a0,a0,-374 # 5bd0 <statistics+0x686>
     d4e:	1ee040ef          	jal	4f3c <open>
     d52:	0c055463          	bgez	a0,e1a <linktest+0x150>
  fd = open("lf2", 0);
     d56:	4581                	li	a1,0
     d58:	00005517          	auipc	a0,0x5
     d5c:	e8050513          	addi	a0,a0,-384 # 5bd8 <statistics+0x68e>
     d60:	1dc040ef          	jal	4f3c <open>
     d64:	84aa                	mv	s1,a0
  if(fd < 0){
     d66:	0c054463          	bltz	a0,e2e <linktest+0x164>
  if(read(fd, buf, sizeof(buf)) != SZ){
     d6a:	660d                	lui	a2,0x3
     d6c:	0000b597          	auipc	a1,0xb
     d70:	f3c58593          	addi	a1,a1,-196 # bca8 <buf>
     d74:	1a0040ef          	jal	4f14 <read>
     d78:	4795                	li	a5,5
     d7a:	0cf51463          	bne	a0,a5,e42 <linktest+0x178>
  close(fd);
     d7e:	8526                	mv	a0,s1
     d80:	1a4040ef          	jal	4f24 <close>
  if(link("lf2", "lf2") >= 0){
     d84:	00005597          	auipc	a1,0x5
     d88:	e5458593          	addi	a1,a1,-428 # 5bd8 <statistics+0x68e>
     d8c:	852e                	mv	a0,a1
     d8e:	1ce040ef          	jal	4f5c <link>
     d92:	0c055263          	bgez	a0,e56 <linktest+0x18c>
  unlink("lf2");
     d96:	00005517          	auipc	a0,0x5
     d9a:	e4250513          	addi	a0,a0,-446 # 5bd8 <statistics+0x68e>
     d9e:	1ae040ef          	jal	4f4c <unlink>
  if(link("lf2", "lf1") >= 0){
     da2:	00005597          	auipc	a1,0x5
     da6:	e2e58593          	addi	a1,a1,-466 # 5bd0 <statistics+0x686>
     daa:	00005517          	auipc	a0,0x5
     dae:	e2e50513          	addi	a0,a0,-466 # 5bd8 <statistics+0x68e>
     db2:	1aa040ef          	jal	4f5c <link>
     db6:	0a055a63          	bgez	a0,e6a <linktest+0x1a0>
  if(link(".", "lf1") >= 0){
     dba:	00005597          	auipc	a1,0x5
     dbe:	e1658593          	addi	a1,a1,-490 # 5bd0 <statistics+0x686>
     dc2:	00005517          	auipc	a0,0x5
     dc6:	f1e50513          	addi	a0,a0,-226 # 5ce0 <statistics+0x796>
     dca:	192040ef          	jal	4f5c <link>
     dce:	0a055863          	bgez	a0,e7e <linktest+0x1b4>
}
     dd2:	60e2                	ld	ra,24(sp)
     dd4:	6442                	ld	s0,16(sp)
     dd6:	64a2                	ld	s1,8(sp)
     dd8:	6902                	ld	s2,0(sp)
     dda:	6105                	addi	sp,sp,32
     ddc:	8082                	ret
    printf("%s: create lf1 failed\n", s);
     dde:	85ca                	mv	a1,s2
     de0:	00005517          	auipc	a0,0x5
     de4:	e0050513          	addi	a0,a0,-512 # 5be0 <statistics+0x696>
     de8:	5b4040ef          	jal	539c <printf>
    exit(1);
     dec:	4505                	li	a0,1
     dee:	10e040ef          	jal	4efc <exit>
    printf("%s: write lf1 failed\n", s);
     df2:	85ca                	mv	a1,s2
     df4:	00005517          	auipc	a0,0x5
     df8:	e0450513          	addi	a0,a0,-508 # 5bf8 <statistics+0x6ae>
     dfc:	5a0040ef          	jal	539c <printf>
    exit(1);
     e00:	4505                	li	a0,1
     e02:	0fa040ef          	jal	4efc <exit>
    printf("%s: link lf1 lf2 failed\n", s);
     e06:	85ca                	mv	a1,s2
     e08:	00005517          	auipc	a0,0x5
     e0c:	e0850513          	addi	a0,a0,-504 # 5c10 <statistics+0x6c6>
     e10:	58c040ef          	jal	539c <printf>
    exit(1);
     e14:	4505                	li	a0,1
     e16:	0e6040ef          	jal	4efc <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
     e1a:	85ca                	mv	a1,s2
     e1c:	00005517          	auipc	a0,0x5
     e20:	e1450513          	addi	a0,a0,-492 # 5c30 <statistics+0x6e6>
     e24:	578040ef          	jal	539c <printf>
    exit(1);
     e28:	4505                	li	a0,1
     e2a:	0d2040ef          	jal	4efc <exit>
    printf("%s: open lf2 failed\n", s);
     e2e:	85ca                	mv	a1,s2
     e30:	00005517          	auipc	a0,0x5
     e34:	e3050513          	addi	a0,a0,-464 # 5c60 <statistics+0x716>
     e38:	564040ef          	jal	539c <printf>
    exit(1);
     e3c:	4505                	li	a0,1
     e3e:	0be040ef          	jal	4efc <exit>
    printf("%s: read lf2 failed\n", s);
     e42:	85ca                	mv	a1,s2
     e44:	00005517          	auipc	a0,0x5
     e48:	e3450513          	addi	a0,a0,-460 # 5c78 <statistics+0x72e>
     e4c:	550040ef          	jal	539c <printf>
    exit(1);
     e50:	4505                	li	a0,1
     e52:	0aa040ef          	jal	4efc <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
     e56:	85ca                	mv	a1,s2
     e58:	00005517          	auipc	a0,0x5
     e5c:	e3850513          	addi	a0,a0,-456 # 5c90 <statistics+0x746>
     e60:	53c040ef          	jal	539c <printf>
    exit(1);
     e64:	4505                	li	a0,1
     e66:	096040ef          	jal	4efc <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
     e6a:	85ca                	mv	a1,s2
     e6c:	00005517          	auipc	a0,0x5
     e70:	e4c50513          	addi	a0,a0,-436 # 5cb8 <statistics+0x76e>
     e74:	528040ef          	jal	539c <printf>
    exit(1);
     e78:	4505                	li	a0,1
     e7a:	082040ef          	jal	4efc <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
     e7e:	85ca                	mv	a1,s2
     e80:	00005517          	auipc	a0,0x5
     e84:	e6850513          	addi	a0,a0,-408 # 5ce8 <statistics+0x79e>
     e88:	514040ef          	jal	539c <printf>
    exit(1);
     e8c:	4505                	li	a0,1
     e8e:	06e040ef          	jal	4efc <exit>

0000000000000e92 <validatetest>:
{
     e92:	7139                	addi	sp,sp,-64
     e94:	fc06                	sd	ra,56(sp)
     e96:	f822                	sd	s0,48(sp)
     e98:	f426                	sd	s1,40(sp)
     e9a:	f04a                	sd	s2,32(sp)
     e9c:	ec4e                	sd	s3,24(sp)
     e9e:	e852                	sd	s4,16(sp)
     ea0:	e456                	sd	s5,8(sp)
     ea2:	e05a                	sd	s6,0(sp)
     ea4:	0080                	addi	s0,sp,64
     ea6:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     ea8:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
     eaa:	00005997          	auipc	s3,0x5
     eae:	e5e98993          	addi	s3,s3,-418 # 5d08 <statistics+0x7be>
     eb2:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     eb4:	6a85                	lui	s5,0x1
     eb6:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
     eba:	85a6                	mv	a1,s1
     ebc:	854e                	mv	a0,s3
     ebe:	09e040ef          	jal	4f5c <link>
     ec2:	01251f63          	bne	a0,s2,ee0 <validatetest+0x4e>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     ec6:	94d6                	add	s1,s1,s5
     ec8:	ff4499e3          	bne	s1,s4,eba <validatetest+0x28>
}
     ecc:	70e2                	ld	ra,56(sp)
     ece:	7442                	ld	s0,48(sp)
     ed0:	74a2                	ld	s1,40(sp)
     ed2:	7902                	ld	s2,32(sp)
     ed4:	69e2                	ld	s3,24(sp)
     ed6:	6a42                	ld	s4,16(sp)
     ed8:	6aa2                	ld	s5,8(sp)
     eda:	6b02                	ld	s6,0(sp)
     edc:	6121                	addi	sp,sp,64
     ede:	8082                	ret
      printf("%s: link should not succeed\n", s);
     ee0:	85da                	mv	a1,s6
     ee2:	00005517          	auipc	a0,0x5
     ee6:	e3650513          	addi	a0,a0,-458 # 5d18 <statistics+0x7ce>
     eea:	4b2040ef          	jal	539c <printf>
      exit(1);
     eee:	4505                	li	a0,1
     ef0:	00c040ef          	jal	4efc <exit>

0000000000000ef4 <bigdir>:
{
     ef4:	711d                	addi	sp,sp,-96
     ef6:	ec86                	sd	ra,88(sp)
     ef8:	e8a2                	sd	s0,80(sp)
     efa:	e4a6                	sd	s1,72(sp)
     efc:	e0ca                	sd	s2,64(sp)
     efe:	fc4e                	sd	s3,56(sp)
     f00:	f852                	sd	s4,48(sp)
     f02:	f456                	sd	s5,40(sp)
     f04:	f05a                	sd	s6,32(sp)
     f06:	ec5e                	sd	s7,24(sp)
     f08:	1080                	addi	s0,sp,96
     f0a:	8baa                	mv	s7,a0
  unlink("bd");
     f0c:	00005517          	auipc	a0,0x5
     f10:	e2c50513          	addi	a0,a0,-468 # 5d38 <statistics+0x7ee>
     f14:	038040ef          	jal	4f4c <unlink>
  fd = open("bd", O_CREATE);
     f18:	20000593          	li	a1,512
     f1c:	00005517          	auipc	a0,0x5
     f20:	e1c50513          	addi	a0,a0,-484 # 5d38 <statistics+0x7ee>
     f24:	018040ef          	jal	4f3c <open>
  if(fd < 0){
     f28:	0c054463          	bltz	a0,ff0 <bigdir+0xfc>
  close(fd);
     f2c:	7f9030ef          	jal	4f24 <close>
  for(i = 0; i < N; i++){
     f30:	4901                	li	s2,0
    name[0] = 'x';
     f32:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
     f36:	fa040a13          	addi	s4,s0,-96
     f3a:	00005997          	auipc	s3,0x5
     f3e:	dfe98993          	addi	s3,s3,-514 # 5d38 <statistics+0x7ee>
  for(i = 0; i < N; i++){
     f42:	1f400b13          	li	s6,500
    name[0] = 'x';
     f46:	fb540023          	sb	s5,-96(s0)
    name[1] = '0' + (i / 64);
     f4a:	41f9571b          	sraiw	a4,s2,0x1f
     f4e:	01a7571b          	srliw	a4,a4,0x1a
     f52:	012707bb          	addw	a5,a4,s2
     f56:	4067d69b          	sraiw	a3,a5,0x6
     f5a:	0306869b          	addiw	a3,a3,48
     f5e:	fad400a3          	sb	a3,-95(s0)
    name[2] = '0' + (i % 64);
     f62:	03f7f793          	andi	a5,a5,63
     f66:	9f99                	subw	a5,a5,a4
     f68:	0307879b          	addiw	a5,a5,48
     f6c:	faf40123          	sb	a5,-94(s0)
    name[3] = '\0';
     f70:	fa0401a3          	sb	zero,-93(s0)
    if(link("bd", name) != 0){
     f74:	85d2                	mv	a1,s4
     f76:	854e                	mv	a0,s3
     f78:	7e5030ef          	jal	4f5c <link>
     f7c:	84aa                	mv	s1,a0
     f7e:	e159                	bnez	a0,1004 <bigdir+0x110>
  for(i = 0; i < N; i++){
     f80:	2905                	addiw	s2,s2,1
     f82:	fd6912e3          	bne	s2,s6,f46 <bigdir+0x52>
  unlink("bd");
     f86:	00005517          	auipc	a0,0x5
     f8a:	db250513          	addi	a0,a0,-590 # 5d38 <statistics+0x7ee>
     f8e:	7bf030ef          	jal	4f4c <unlink>
    name[0] = 'x';
     f92:	07800993          	li	s3,120
    if(unlink(name) != 0){
     f96:	fa040913          	addi	s2,s0,-96
  for(i = 0; i < N; i++){
     f9a:	1f400a13          	li	s4,500
    name[0] = 'x';
     f9e:	fb340023          	sb	s3,-96(s0)
    name[1] = '0' + (i / 64);
     fa2:	41f4d71b          	sraiw	a4,s1,0x1f
     fa6:	01a7571b          	srliw	a4,a4,0x1a
     faa:	009707bb          	addw	a5,a4,s1
     fae:	4067d69b          	sraiw	a3,a5,0x6
     fb2:	0306869b          	addiw	a3,a3,48
     fb6:	fad400a3          	sb	a3,-95(s0)
    name[2] = '0' + (i % 64);
     fba:	03f7f793          	andi	a5,a5,63
     fbe:	9f99                	subw	a5,a5,a4
     fc0:	0307879b          	addiw	a5,a5,48
     fc4:	faf40123          	sb	a5,-94(s0)
    name[3] = '\0';
     fc8:	fa0401a3          	sb	zero,-93(s0)
    if(unlink(name) != 0){
     fcc:	854a                	mv	a0,s2
     fce:	77f030ef          	jal	4f4c <unlink>
     fd2:	e531                	bnez	a0,101e <bigdir+0x12a>
  for(i = 0; i < N; i++){
     fd4:	2485                	addiw	s1,s1,1
     fd6:	fd4494e3          	bne	s1,s4,f9e <bigdir+0xaa>
}
     fda:	60e6                	ld	ra,88(sp)
     fdc:	6446                	ld	s0,80(sp)
     fde:	64a6                	ld	s1,72(sp)
     fe0:	6906                	ld	s2,64(sp)
     fe2:	79e2                	ld	s3,56(sp)
     fe4:	7a42                	ld	s4,48(sp)
     fe6:	7aa2                	ld	s5,40(sp)
     fe8:	7b02                	ld	s6,32(sp)
     fea:	6be2                	ld	s7,24(sp)
     fec:	6125                	addi	sp,sp,96
     fee:	8082                	ret
    printf("%s: bigdir create failed\n", s);
     ff0:	85de                	mv	a1,s7
     ff2:	00005517          	auipc	a0,0x5
     ff6:	d4e50513          	addi	a0,a0,-690 # 5d40 <statistics+0x7f6>
     ffa:	3a2040ef          	jal	539c <printf>
    exit(1);
     ffe:	4505                	li	a0,1
    1000:	6fd030ef          	jal	4efc <exit>
      printf("%s: bigdir i=%d link(bd, %s) failed\n", s, i, name);
    1004:	fa040693          	addi	a3,s0,-96
    1008:	864a                	mv	a2,s2
    100a:	85de                	mv	a1,s7
    100c:	00005517          	auipc	a0,0x5
    1010:	d5450513          	addi	a0,a0,-684 # 5d60 <statistics+0x816>
    1014:	388040ef          	jal	539c <printf>
      exit(1);
    1018:	4505                	li	a0,1
    101a:	6e3030ef          	jal	4efc <exit>
      printf("%s: bigdir unlink failed", s);
    101e:	85de                	mv	a1,s7
    1020:	00005517          	auipc	a0,0x5
    1024:	d6850513          	addi	a0,a0,-664 # 5d88 <statistics+0x83e>
    1028:	374040ef          	jal	539c <printf>
      exit(1);
    102c:	4505                	li	a0,1
    102e:	6cf030ef          	jal	4efc <exit>

0000000000001032 <pgbug>:
{
    1032:	7179                	addi	sp,sp,-48
    1034:	f406                	sd	ra,40(sp)
    1036:	f022                	sd	s0,32(sp)
    1038:	ec26                	sd	s1,24(sp)
    103a:	1800                	addi	s0,sp,48
  argv[0] = 0;
    103c:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
    1040:	00007497          	auipc	s1,0x7
    1044:	fc048493          	addi	s1,s1,-64 # 8000 <big>
    1048:	fd840593          	addi	a1,s0,-40
    104c:	6088                	ld	a0,0(s1)
    104e:	6e7030ef          	jal	4f34 <exec>
  pipe(big);
    1052:	6088                	ld	a0,0(s1)
    1054:	6b9030ef          	jal	4f0c <pipe>
  exit(0);
    1058:	4501                	li	a0,0
    105a:	6a3030ef          	jal	4efc <exit>

000000000000105e <badarg>:
{
    105e:	7139                	addi	sp,sp,-64
    1060:	fc06                	sd	ra,56(sp)
    1062:	f822                	sd	s0,48(sp)
    1064:	f426                	sd	s1,40(sp)
    1066:	f04a                	sd	s2,32(sp)
    1068:	ec4e                	sd	s3,24(sp)
    106a:	e852                	sd	s4,16(sp)
    106c:	0080                	addi	s0,sp,64
    106e:	64b1                	lui	s1,0xc
    1070:	35048493          	addi	s1,s1,848 # c350 <buf+0x6a8>
    argv[0] = (char*)0xffffffff;
    1074:	597d                	li	s2,-1
    1076:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    107a:	fc040a13          	addi	s4,s0,-64
    107e:	00004997          	auipc	s3,0x4
    1082:	57a98993          	addi	s3,s3,1402 # 55f8 <statistics+0xae>
    argv[0] = (char*)0xffffffff;
    1086:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    108a:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    108e:	85d2                	mv	a1,s4
    1090:	854e                	mv	a0,s3
    1092:	6a3030ef          	jal	4f34 <exec>
  for(int i = 0; i < 50000; i++){
    1096:	34fd                	addiw	s1,s1,-1
    1098:	f4fd                	bnez	s1,1086 <badarg+0x28>
  exit(0);
    109a:	4501                	li	a0,0
    109c:	661030ef          	jal	4efc <exit>

00000000000010a0 <copyinstr2>:
{
    10a0:	7155                	addi	sp,sp,-208
    10a2:	e586                	sd	ra,200(sp)
    10a4:	e1a2                	sd	s0,192(sp)
    10a6:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    10a8:	f6840793          	addi	a5,s0,-152
    10ac:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    10b0:	07800713          	li	a4,120
    10b4:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    10b8:	0785                	addi	a5,a5,1
    10ba:	fed79de3          	bne	a5,a3,10b4 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    10be:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    10c2:	f6840513          	addi	a0,s0,-152
    10c6:	687030ef          	jal	4f4c <unlink>
  if(ret != -1){
    10ca:	57fd                	li	a5,-1
    10cc:	0cf51263          	bne	a0,a5,1190 <copyinstr2+0xf0>
  int fd = open(b, O_CREATE | O_WRONLY);
    10d0:	20100593          	li	a1,513
    10d4:	f6840513          	addi	a0,s0,-152
    10d8:	665030ef          	jal	4f3c <open>
  if(fd != -1){
    10dc:	57fd                	li	a5,-1
    10de:	0cf51563          	bne	a0,a5,11a8 <copyinstr2+0x108>
  ret = link(b, b);
    10e2:	f6840513          	addi	a0,s0,-152
    10e6:	85aa                	mv	a1,a0
    10e8:	675030ef          	jal	4f5c <link>
  if(ret != -1){
    10ec:	57fd                	li	a5,-1
    10ee:	0cf51963          	bne	a0,a5,11c0 <copyinstr2+0x120>
  char *args[] = { "xx", 0 };
    10f2:	00006797          	auipc	a5,0x6
    10f6:	de678793          	addi	a5,a5,-538 # 6ed8 <statistics+0x198e>
    10fa:	f4f43c23          	sd	a5,-168(s0)
    10fe:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    1102:	f5840593          	addi	a1,s0,-168
    1106:	f6840513          	addi	a0,s0,-152
    110a:	62b030ef          	jal	4f34 <exec>
  if(ret != -1){
    110e:	57fd                	li	a5,-1
    1110:	0cf51563          	bne	a0,a5,11da <copyinstr2+0x13a>
  int pid = fork();
    1114:	5e1030ef          	jal	4ef4 <fork>
  if(pid < 0){
    1118:	0c054d63          	bltz	a0,11f2 <copyinstr2+0x152>
  if(pid == 0){
    111c:	0e051863          	bnez	a0,120c <copyinstr2+0x16c>
    1120:	00007797          	auipc	a5,0x7
    1124:	47078793          	addi	a5,a5,1136 # 8590 <big.0>
    1128:	00008697          	auipc	a3,0x8
    112c:	46868693          	addi	a3,a3,1128 # 9590 <big.0+0x1000>
      big[i] = 'x';
    1130:	07800713          	li	a4,120
    1134:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    1138:	0785                	addi	a5,a5,1
    113a:	fed79de3          	bne	a5,a3,1134 <copyinstr2+0x94>
    big[PGSIZE] = '\0';
    113e:	00008797          	auipc	a5,0x8
    1142:	44078923          	sb	zero,1106(a5) # 9590 <big.0+0x1000>
    char *args2[] = { big, big, big, 0 };
    1146:	00007797          	auipc	a5,0x7
    114a:	92a78793          	addi	a5,a5,-1750 # 7a70 <statistics+0x2526>
    114e:	6fb0                	ld	a2,88(a5)
    1150:	73b4                	ld	a3,96(a5)
    1152:	77b8                	ld	a4,104(a5)
    1154:	f2c43823          	sd	a2,-208(s0)
    1158:	f2d43c23          	sd	a3,-200(s0)
    115c:	f4e43023          	sd	a4,-192(s0)
    1160:	7bbc                	ld	a5,112(a5)
    1162:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    1166:	f3040593          	addi	a1,s0,-208
    116a:	00004517          	auipc	a0,0x4
    116e:	48e50513          	addi	a0,a0,1166 # 55f8 <statistics+0xae>
    1172:	5c3030ef          	jal	4f34 <exec>
    if(ret != -1){
    1176:	57fd                	li	a5,-1
    1178:	08f50663          	beq	a0,a5,1204 <copyinstr2+0x164>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    117c:	85be                	mv	a1,a5
    117e:	00005517          	auipc	a0,0x5
    1182:	cb250513          	addi	a0,a0,-846 # 5e30 <statistics+0x8e6>
    1186:	216040ef          	jal	539c <printf>
      exit(1);
    118a:	4505                	li	a0,1
    118c:	571030ef          	jal	4efc <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    1190:	862a                	mv	a2,a0
    1192:	f6840593          	addi	a1,s0,-152
    1196:	00005517          	auipc	a0,0x5
    119a:	c1250513          	addi	a0,a0,-1006 # 5da8 <statistics+0x85e>
    119e:	1fe040ef          	jal	539c <printf>
    exit(1);
    11a2:	4505                	li	a0,1
    11a4:	559030ef          	jal	4efc <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    11a8:	862a                	mv	a2,a0
    11aa:	f6840593          	addi	a1,s0,-152
    11ae:	00005517          	auipc	a0,0x5
    11b2:	c1a50513          	addi	a0,a0,-998 # 5dc8 <statistics+0x87e>
    11b6:	1e6040ef          	jal	539c <printf>
    exit(1);
    11ba:	4505                	li	a0,1
    11bc:	541030ef          	jal	4efc <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    11c0:	f6840593          	addi	a1,s0,-152
    11c4:	86aa                	mv	a3,a0
    11c6:	862e                	mv	a2,a1
    11c8:	00005517          	auipc	a0,0x5
    11cc:	c2050513          	addi	a0,a0,-992 # 5de8 <statistics+0x89e>
    11d0:	1cc040ef          	jal	539c <printf>
    exit(1);
    11d4:	4505                	li	a0,1
    11d6:	527030ef          	jal	4efc <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    11da:	863e                	mv	a2,a5
    11dc:	f6840593          	addi	a1,s0,-152
    11e0:	00005517          	auipc	a0,0x5
    11e4:	c3050513          	addi	a0,a0,-976 # 5e10 <statistics+0x8c6>
    11e8:	1b4040ef          	jal	539c <printf>
    exit(1);
    11ec:	4505                	li	a0,1
    11ee:	50f030ef          	jal	4efc <exit>
    printf("fork failed\n");
    11f2:	00006517          	auipc	a0,0x6
    11f6:	23e50513          	addi	a0,a0,574 # 7430 <statistics+0x1ee6>
    11fa:	1a2040ef          	jal	539c <printf>
    exit(1);
    11fe:	4505                	li	a0,1
    1200:	4fd030ef          	jal	4efc <exit>
    exit(747); // OK
    1204:	2eb00513          	li	a0,747
    1208:	4f5030ef          	jal	4efc <exit>
  int st = 0;
    120c:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    1210:	f5440513          	addi	a0,s0,-172
    1214:	4f1030ef          	jal	4f04 <wait>
  if(st != 747){
    1218:	f5442703          	lw	a4,-172(s0)
    121c:	2eb00793          	li	a5,747
    1220:	00f71663          	bne	a4,a5,122c <copyinstr2+0x18c>
}
    1224:	60ae                	ld	ra,200(sp)
    1226:	640e                	ld	s0,192(sp)
    1228:	6169                	addi	sp,sp,208
    122a:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    122c:	00005517          	auipc	a0,0x5
    1230:	c2c50513          	addi	a0,a0,-980 # 5e58 <statistics+0x90e>
    1234:	168040ef          	jal	539c <printf>
    exit(1);
    1238:	4505                	li	a0,1
    123a:	4c3030ef          	jal	4efc <exit>

000000000000123e <truncate3>:
{
    123e:	7175                	addi	sp,sp,-144
    1240:	e506                	sd	ra,136(sp)
    1242:	e122                	sd	s0,128(sp)
    1244:	fc66                	sd	s9,56(sp)
    1246:	0900                	addi	s0,sp,144
    1248:	8caa                	mv	s9,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    124a:	60100593          	li	a1,1537
    124e:	00004517          	auipc	a0,0x4
    1252:	40250513          	addi	a0,a0,1026 # 5650 <statistics+0x106>
    1256:	4e7030ef          	jal	4f3c <open>
    125a:	4cb030ef          	jal	4f24 <close>
  pid = fork();
    125e:	497030ef          	jal	4ef4 <fork>
  if(pid < 0){
    1262:	06054d63          	bltz	a0,12dc <truncate3+0x9e>
  if(pid == 0){
    1266:	e171                	bnez	a0,132a <truncate3+0xec>
    1268:	fca6                	sd	s1,120(sp)
    126a:	f8ca                	sd	s2,112(sp)
    126c:	f4ce                	sd	s3,104(sp)
    126e:	f0d2                	sd	s4,96(sp)
    1270:	ecd6                	sd	s5,88(sp)
    1272:	e8da                	sd	s6,80(sp)
    1274:	e4de                	sd	s7,72(sp)
    1276:	e0e2                	sd	s8,64(sp)
    1278:	06400913          	li	s2,100
      int fd = open("truncfile", O_WRONLY);
    127c:	4a85                	li	s5,1
    127e:	00004997          	auipc	s3,0x4
    1282:	3d298993          	addi	s3,s3,978 # 5650 <statistics+0x106>
      int n = write(fd, "1234567890", 10);
    1286:	4a29                	li	s4,10
    1288:	00005b17          	auipc	s6,0x5
    128c:	c30b0b13          	addi	s6,s6,-976 # 5eb8 <statistics+0x96e>
      read(fd, buf, sizeof(buf));
    1290:	f7840c13          	addi	s8,s0,-136
    1294:	02000b93          	li	s7,32
      int fd = open("truncfile", O_WRONLY);
    1298:	85d6                	mv	a1,s5
    129a:	854e                	mv	a0,s3
    129c:	4a1030ef          	jal	4f3c <open>
    12a0:	84aa                	mv	s1,a0
      if(fd < 0){
    12a2:	04054f63          	bltz	a0,1300 <truncate3+0xc2>
      int n = write(fd, "1234567890", 10);
    12a6:	8652                	mv	a2,s4
    12a8:	85da                	mv	a1,s6
    12aa:	473030ef          	jal	4f1c <write>
      if(n != 10){
    12ae:	07451363          	bne	a0,s4,1314 <truncate3+0xd6>
      close(fd);
    12b2:	8526                	mv	a0,s1
    12b4:	471030ef          	jal	4f24 <close>
      fd = open("truncfile", O_RDONLY);
    12b8:	4581                	li	a1,0
    12ba:	854e                	mv	a0,s3
    12bc:	481030ef          	jal	4f3c <open>
    12c0:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    12c2:	865e                	mv	a2,s7
    12c4:	85e2                	mv	a1,s8
    12c6:	44f030ef          	jal	4f14 <read>
      close(fd);
    12ca:	8526                	mv	a0,s1
    12cc:	459030ef          	jal	4f24 <close>
    for(int i = 0; i < 100; i++){
    12d0:	397d                	addiw	s2,s2,-1
    12d2:	fc0913e3          	bnez	s2,1298 <truncate3+0x5a>
    exit(0);
    12d6:	4501                	li	a0,0
    12d8:	425030ef          	jal	4efc <exit>
    12dc:	fca6                	sd	s1,120(sp)
    12de:	f8ca                	sd	s2,112(sp)
    12e0:	f4ce                	sd	s3,104(sp)
    12e2:	f0d2                	sd	s4,96(sp)
    12e4:	ecd6                	sd	s5,88(sp)
    12e6:	e8da                	sd	s6,80(sp)
    12e8:	e4de                	sd	s7,72(sp)
    12ea:	e0e2                	sd	s8,64(sp)
    printf("%s: fork failed\n", s);
    12ec:	85e6                	mv	a1,s9
    12ee:	00005517          	auipc	a0,0x5
    12f2:	b9a50513          	addi	a0,a0,-1126 # 5e88 <statistics+0x93e>
    12f6:	0a6040ef          	jal	539c <printf>
    exit(1);
    12fa:	4505                	li	a0,1
    12fc:	401030ef          	jal	4efc <exit>
        printf("%s: open failed\n", s);
    1300:	85e6                	mv	a1,s9
    1302:	00005517          	auipc	a0,0x5
    1306:	b9e50513          	addi	a0,a0,-1122 # 5ea0 <statistics+0x956>
    130a:	092040ef          	jal	539c <printf>
        exit(1);
    130e:	4505                	li	a0,1
    1310:	3ed030ef          	jal	4efc <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1314:	862a                	mv	a2,a0
    1316:	85e6                	mv	a1,s9
    1318:	00005517          	auipc	a0,0x5
    131c:	bb050513          	addi	a0,a0,-1104 # 5ec8 <statistics+0x97e>
    1320:	07c040ef          	jal	539c <printf>
        exit(1);
    1324:	4505                	li	a0,1
    1326:	3d7030ef          	jal	4efc <exit>
    132a:	fca6                	sd	s1,120(sp)
    132c:	f8ca                	sd	s2,112(sp)
    132e:	f4ce                	sd	s3,104(sp)
    1330:	f0d2                	sd	s4,96(sp)
    1332:	ecd6                	sd	s5,88(sp)
    1334:	e8da                	sd	s6,80(sp)
  if(pid == 0){
    1336:	09600913          	li	s2,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    133a:	60100a93          	li	s5,1537
    133e:	00004a17          	auipc	s4,0x4
    1342:	312a0a13          	addi	s4,s4,786 # 5650 <statistics+0x106>
    int n = write(fd, "xxx", 3);
    1346:	498d                	li	s3,3
    1348:	00005b17          	auipc	s6,0x5
    134c:	ba0b0b13          	addi	s6,s6,-1120 # 5ee8 <statistics+0x99e>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    1350:	85d6                	mv	a1,s5
    1352:	8552                	mv	a0,s4
    1354:	3e9030ef          	jal	4f3c <open>
    1358:	84aa                	mv	s1,a0
    if(fd < 0){
    135a:	02054e63          	bltz	a0,1396 <truncate3+0x158>
    int n = write(fd, "xxx", 3);
    135e:	864e                	mv	a2,s3
    1360:	85da                	mv	a1,s6
    1362:	3bb030ef          	jal	4f1c <write>
    if(n != 3){
    1366:	05351463          	bne	a0,s3,13ae <truncate3+0x170>
    close(fd);
    136a:	8526                	mv	a0,s1
    136c:	3b9030ef          	jal	4f24 <close>
  for(int i = 0; i < 150; i++){
    1370:	397d                	addiw	s2,s2,-1
    1372:	fc091fe3          	bnez	s2,1350 <truncate3+0x112>
    1376:	e4de                	sd	s7,72(sp)
    1378:	e0e2                	sd	s8,64(sp)
  wait(&xstatus);
    137a:	f9c40513          	addi	a0,s0,-100
    137e:	387030ef          	jal	4f04 <wait>
  unlink("truncfile");
    1382:	00004517          	auipc	a0,0x4
    1386:	2ce50513          	addi	a0,a0,718 # 5650 <statistics+0x106>
    138a:	3c3030ef          	jal	4f4c <unlink>
  exit(xstatus);
    138e:	f9c42503          	lw	a0,-100(s0)
    1392:	36b030ef          	jal	4efc <exit>
    1396:	e4de                	sd	s7,72(sp)
    1398:	e0e2                	sd	s8,64(sp)
      printf("%s: open failed\n", s);
    139a:	85e6                	mv	a1,s9
    139c:	00005517          	auipc	a0,0x5
    13a0:	b0450513          	addi	a0,a0,-1276 # 5ea0 <statistics+0x956>
    13a4:	7f9030ef          	jal	539c <printf>
      exit(1);
    13a8:	4505                	li	a0,1
    13aa:	353030ef          	jal	4efc <exit>
    13ae:	e4de                	sd	s7,72(sp)
    13b0:	e0e2                	sd	s8,64(sp)
      printf("%s: write got %d, expected 3\n", s, n);
    13b2:	862a                	mv	a2,a0
    13b4:	85e6                	mv	a1,s9
    13b6:	00005517          	auipc	a0,0x5
    13ba:	b3a50513          	addi	a0,a0,-1222 # 5ef0 <statistics+0x9a6>
    13be:	7df030ef          	jal	539c <printf>
      exit(1);
    13c2:	4505                	li	a0,1
    13c4:	339030ef          	jal	4efc <exit>

00000000000013c8 <exectest>:
{
    13c8:	715d                	addi	sp,sp,-80
    13ca:	e486                	sd	ra,72(sp)
    13cc:	e0a2                	sd	s0,64(sp)
    13ce:	f84a                	sd	s2,48(sp)
    13d0:	0880                	addi	s0,sp,80
    13d2:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    13d4:	00004797          	auipc	a5,0x4
    13d8:	22478793          	addi	a5,a5,548 # 55f8 <statistics+0xae>
    13dc:	fcf43023          	sd	a5,-64(s0)
    13e0:	00005797          	auipc	a5,0x5
    13e4:	b3078793          	addi	a5,a5,-1232 # 5f10 <statistics+0x9c6>
    13e8:	fcf43423          	sd	a5,-56(s0)
    13ec:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    13f0:	00005517          	auipc	a0,0x5
    13f4:	b2850513          	addi	a0,a0,-1240 # 5f18 <statistics+0x9ce>
    13f8:	355030ef          	jal	4f4c <unlink>
  pid = fork();
    13fc:	2f9030ef          	jal	4ef4 <fork>
  if(pid < 0) {
    1400:	02054f63          	bltz	a0,143e <exectest+0x76>
    1404:	fc26                	sd	s1,56(sp)
    1406:	84aa                	mv	s1,a0
  if(pid == 0) {
    1408:	e935                	bnez	a0,147c <exectest+0xb4>
    close(1);
    140a:	4505                	li	a0,1
    140c:	319030ef          	jal	4f24 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1410:	20100593          	li	a1,513
    1414:	00005517          	auipc	a0,0x5
    1418:	b0450513          	addi	a0,a0,-1276 # 5f18 <statistics+0x9ce>
    141c:	321030ef          	jal	4f3c <open>
    if(fd < 0) {
    1420:	02054a63          	bltz	a0,1454 <exectest+0x8c>
    if(fd != 1) {
    1424:	4785                	li	a5,1
    1426:	04f50163          	beq	a0,a5,1468 <exectest+0xa0>
      printf("%s: wrong fd\n", s);
    142a:	85ca                	mv	a1,s2
    142c:	00005517          	auipc	a0,0x5
    1430:	b0c50513          	addi	a0,a0,-1268 # 5f38 <statistics+0x9ee>
    1434:	769030ef          	jal	539c <printf>
      exit(1);
    1438:	4505                	li	a0,1
    143a:	2c3030ef          	jal	4efc <exit>
    143e:	fc26                	sd	s1,56(sp)
     printf("%s: fork failed\n", s);
    1440:	85ca                	mv	a1,s2
    1442:	00005517          	auipc	a0,0x5
    1446:	a4650513          	addi	a0,a0,-1466 # 5e88 <statistics+0x93e>
    144a:	753030ef          	jal	539c <printf>
     exit(1);
    144e:	4505                	li	a0,1
    1450:	2ad030ef          	jal	4efc <exit>
      printf("%s: create failed\n", s);
    1454:	85ca                	mv	a1,s2
    1456:	00005517          	auipc	a0,0x5
    145a:	aca50513          	addi	a0,a0,-1334 # 5f20 <statistics+0x9d6>
    145e:	73f030ef          	jal	539c <printf>
      exit(1);
    1462:	4505                	li	a0,1
    1464:	299030ef          	jal	4efc <exit>
    if(exec("echo", echoargv) < 0){
    1468:	fc040593          	addi	a1,s0,-64
    146c:	00004517          	auipc	a0,0x4
    1470:	18c50513          	addi	a0,a0,396 # 55f8 <statistics+0xae>
    1474:	2c1030ef          	jal	4f34 <exec>
    1478:	00054d63          	bltz	a0,1492 <exectest+0xca>
  if (wait(&xstatus) != pid) {
    147c:	fdc40513          	addi	a0,s0,-36
    1480:	285030ef          	jal	4f04 <wait>
    1484:	02951163          	bne	a0,s1,14a6 <exectest+0xde>
  if(xstatus != 0)
    1488:	fdc42503          	lw	a0,-36(s0)
    148c:	c50d                	beqz	a0,14b6 <exectest+0xee>
    exit(xstatus);
    148e:	26f030ef          	jal	4efc <exit>
      printf("%s: exec echo failed\n", s);
    1492:	85ca                	mv	a1,s2
    1494:	00005517          	auipc	a0,0x5
    1498:	ab450513          	addi	a0,a0,-1356 # 5f48 <statistics+0x9fe>
    149c:	701030ef          	jal	539c <printf>
      exit(1);
    14a0:	4505                	li	a0,1
    14a2:	25b030ef          	jal	4efc <exit>
    printf("%s: wait failed!\n", s);
    14a6:	85ca                	mv	a1,s2
    14a8:	00005517          	auipc	a0,0x5
    14ac:	ab850513          	addi	a0,a0,-1352 # 5f60 <statistics+0xa16>
    14b0:	6ed030ef          	jal	539c <printf>
    14b4:	bfd1                	j	1488 <exectest+0xc0>
  fd = open("echo-ok", O_RDONLY);
    14b6:	4581                	li	a1,0
    14b8:	00005517          	auipc	a0,0x5
    14bc:	a6050513          	addi	a0,a0,-1440 # 5f18 <statistics+0x9ce>
    14c0:	27d030ef          	jal	4f3c <open>
  if(fd < 0) {
    14c4:	02054463          	bltz	a0,14ec <exectest+0x124>
  if (read(fd, buf, 2) != 2) {
    14c8:	4609                	li	a2,2
    14ca:	fb840593          	addi	a1,s0,-72
    14ce:	247030ef          	jal	4f14 <read>
    14d2:	4789                	li	a5,2
    14d4:	02f50663          	beq	a0,a5,1500 <exectest+0x138>
    printf("%s: read failed\n", s);
    14d8:	85ca                	mv	a1,s2
    14da:	00004517          	auipc	a0,0x4
    14de:	4ee50513          	addi	a0,a0,1262 # 59c8 <statistics+0x47e>
    14e2:	6bb030ef          	jal	539c <printf>
    exit(1);
    14e6:	4505                	li	a0,1
    14e8:	215030ef          	jal	4efc <exit>
    printf("%s: open failed\n", s);
    14ec:	85ca                	mv	a1,s2
    14ee:	00005517          	auipc	a0,0x5
    14f2:	9b250513          	addi	a0,a0,-1614 # 5ea0 <statistics+0x956>
    14f6:	6a7030ef          	jal	539c <printf>
    exit(1);
    14fa:	4505                	li	a0,1
    14fc:	201030ef          	jal	4efc <exit>
  unlink("echo-ok");
    1500:	00005517          	auipc	a0,0x5
    1504:	a1850513          	addi	a0,a0,-1512 # 5f18 <statistics+0x9ce>
    1508:	245030ef          	jal	4f4c <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    150c:	fb844703          	lbu	a4,-72(s0)
    1510:	04f00793          	li	a5,79
    1514:	00f71863          	bne	a4,a5,1524 <exectest+0x15c>
    1518:	fb944703          	lbu	a4,-71(s0)
    151c:	04b00793          	li	a5,75
    1520:	00f70c63          	beq	a4,a5,1538 <exectest+0x170>
    printf("%s: wrong output\n", s);
    1524:	85ca                	mv	a1,s2
    1526:	00005517          	auipc	a0,0x5
    152a:	a5250513          	addi	a0,a0,-1454 # 5f78 <statistics+0xa2e>
    152e:	66f030ef          	jal	539c <printf>
    exit(1);
    1532:	4505                	li	a0,1
    1534:	1c9030ef          	jal	4efc <exit>
    exit(0);
    1538:	4501                	li	a0,0
    153a:	1c3030ef          	jal	4efc <exit>

000000000000153e <pipe1>:
{
    153e:	711d                	addi	sp,sp,-96
    1540:	ec86                	sd	ra,88(sp)
    1542:	e8a2                	sd	s0,80(sp)
    1544:	e862                	sd	s8,16(sp)
    1546:	1080                	addi	s0,sp,96
    1548:	8c2a                	mv	s8,a0
  if(pipe(fds) != 0){
    154a:	fa840513          	addi	a0,s0,-88
    154e:	1bf030ef          	jal	4f0c <pipe>
    1552:	e925                	bnez	a0,15c2 <pipe1+0x84>
    1554:	e4a6                	sd	s1,72(sp)
    1556:	fc4e                	sd	s3,56(sp)
    1558:	84aa                	mv	s1,a0
  pid = fork();
    155a:	19b030ef          	jal	4ef4 <fork>
    155e:	89aa                	mv	s3,a0
  if(pid == 0){
    1560:	c151                	beqz	a0,15e4 <pipe1+0xa6>
  } else if(pid > 0){
    1562:	16a05063          	blez	a0,16c2 <pipe1+0x184>
    1566:	e0ca                	sd	s2,64(sp)
    1568:	f852                	sd	s4,48(sp)
    close(fds[1]);
    156a:	fac42503          	lw	a0,-84(s0)
    156e:	1b7030ef          	jal	4f24 <close>
    total = 0;
    1572:	89a6                	mv	s3,s1
    cc = 1;
    1574:	4905                	li	s2,1
    while((n = read(fds[0], buf, cc)) > 0){
    1576:	0000aa17          	auipc	s4,0xa
    157a:	732a0a13          	addi	s4,s4,1842 # bca8 <buf>
    157e:	864a                	mv	a2,s2
    1580:	85d2                	mv	a1,s4
    1582:	fa842503          	lw	a0,-88(s0)
    1586:	18f030ef          	jal	4f14 <read>
    158a:	85aa                	mv	a1,a0
    158c:	0ea05963          	blez	a0,167e <pipe1+0x140>
    1590:	0000a797          	auipc	a5,0xa
    1594:	71878793          	addi	a5,a5,1816 # bca8 <buf>
    1598:	00b4863b          	addw	a2,s1,a1
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    159c:	0007c683          	lbu	a3,0(a5)
    15a0:	0ff4f713          	zext.b	a4,s1
    15a4:	0ae69d63          	bne	a3,a4,165e <pipe1+0x120>
    15a8:	2485                	addiw	s1,s1,1
      for(i = 0; i < n; i++){
    15aa:	0785                	addi	a5,a5,1
    15ac:	fec498e3          	bne	s1,a2,159c <pipe1+0x5e>
      total += n;
    15b0:	00b989bb          	addw	s3,s3,a1
      cc = cc * 2;
    15b4:	0019191b          	slliw	s2,s2,0x1
      if(cc > sizeof(buf))
    15b8:	678d                	lui	a5,0x3
    15ba:	fd27f2e3          	bgeu	a5,s2,157e <pipe1+0x40>
        cc = sizeof(buf);
    15be:	893e                	mv	s2,a5
    15c0:	bf7d                	j	157e <pipe1+0x40>
    15c2:	e4a6                	sd	s1,72(sp)
    15c4:	e0ca                	sd	s2,64(sp)
    15c6:	fc4e                	sd	s3,56(sp)
    15c8:	f852                	sd	s4,48(sp)
    15ca:	f456                	sd	s5,40(sp)
    15cc:	f05a                	sd	s6,32(sp)
    15ce:	ec5e                	sd	s7,24(sp)
    printf("%s: pipe() failed\n", s);
    15d0:	85e2                	mv	a1,s8
    15d2:	00005517          	auipc	a0,0x5
    15d6:	9be50513          	addi	a0,a0,-1602 # 5f90 <statistics+0xa46>
    15da:	5c3030ef          	jal	539c <printf>
    exit(1);
    15de:	4505                	li	a0,1
    15e0:	11d030ef          	jal	4efc <exit>
    15e4:	e0ca                	sd	s2,64(sp)
    15e6:	f852                	sd	s4,48(sp)
    15e8:	f456                	sd	s5,40(sp)
    15ea:	f05a                	sd	s6,32(sp)
    15ec:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    15ee:	fa842503          	lw	a0,-88(s0)
    15f2:	133030ef          	jal	4f24 <close>
    for(n = 0; n < N; n++){
    15f6:	0000ab17          	auipc	s6,0xa
    15fa:	6b2b0b13          	addi	s6,s6,1714 # bca8 <buf>
    15fe:	416004bb          	negw	s1,s6
    1602:	0ff4f493          	zext.b	s1,s1
    1606:	409b0913          	addi	s2,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    160a:	40900a13          	li	s4,1033
    160e:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    1610:	6a85                	lui	s5,0x1
    1612:	42da8a93          	addi	s5,s5,1069 # 142d <exectest+0x65>
{
    1616:	87da                	mv	a5,s6
        buf[i] = seq++;
    1618:	0097873b          	addw	a4,a5,s1
    161c:	00e78023          	sb	a4,0(a5) # 3000 <subdir+0x304>
      for(i = 0; i < SZ; i++)
    1620:	0785                	addi	a5,a5,1
    1622:	ff279be3          	bne	a5,s2,1618 <pipe1+0xda>
      if(write(fds[1], buf, SZ) != SZ){
    1626:	8652                	mv	a2,s4
    1628:	85de                	mv	a1,s7
    162a:	fac42503          	lw	a0,-84(s0)
    162e:	0ef030ef          	jal	4f1c <write>
    1632:	01451c63          	bne	a0,s4,164a <pipe1+0x10c>
    1636:	4099899b          	addiw	s3,s3,1033
    for(n = 0; n < N; n++){
    163a:	24a5                	addiw	s1,s1,9
    163c:	0ff4f493          	zext.b	s1,s1
    1640:	fd599be3          	bne	s3,s5,1616 <pipe1+0xd8>
    exit(0);
    1644:	4501                	li	a0,0
    1646:	0b7030ef          	jal	4efc <exit>
        printf("%s: pipe1 oops 1\n", s);
    164a:	85e2                	mv	a1,s8
    164c:	00005517          	auipc	a0,0x5
    1650:	95c50513          	addi	a0,a0,-1700 # 5fa8 <statistics+0xa5e>
    1654:	549030ef          	jal	539c <printf>
        exit(1);
    1658:	4505                	li	a0,1
    165a:	0a3030ef          	jal	4efc <exit>
          printf("%s: pipe1 oops 2\n", s);
    165e:	85e2                	mv	a1,s8
    1660:	00005517          	auipc	a0,0x5
    1664:	96050513          	addi	a0,a0,-1696 # 5fc0 <statistics+0xa76>
    1668:	535030ef          	jal	539c <printf>
          return;
    166c:	64a6                	ld	s1,72(sp)
    166e:	6906                	ld	s2,64(sp)
    1670:	79e2                	ld	s3,56(sp)
    1672:	7a42                	ld	s4,48(sp)
}
    1674:	60e6                	ld	ra,88(sp)
    1676:	6446                	ld	s0,80(sp)
    1678:	6c42                	ld	s8,16(sp)
    167a:	6125                	addi	sp,sp,96
    167c:	8082                	ret
    if(total != N * SZ){
    167e:	6785                	lui	a5,0x1
    1680:	42d78793          	addi	a5,a5,1069 # 142d <exectest+0x65>
    1684:	02f98063          	beq	s3,a5,16a4 <pipe1+0x166>
    1688:	f456                	sd	s5,40(sp)
    168a:	f05a                	sd	s6,32(sp)
    168c:	ec5e                	sd	s7,24(sp)
      printf("%s: pipe1 oops 3 total %d\n", s, total);
    168e:	864e                	mv	a2,s3
    1690:	85e2                	mv	a1,s8
    1692:	00005517          	auipc	a0,0x5
    1696:	94650513          	addi	a0,a0,-1722 # 5fd8 <statistics+0xa8e>
    169a:	503030ef          	jal	539c <printf>
      exit(1);
    169e:	4505                	li	a0,1
    16a0:	05d030ef          	jal	4efc <exit>
    16a4:	f456                	sd	s5,40(sp)
    16a6:	f05a                	sd	s6,32(sp)
    16a8:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    16aa:	fa842503          	lw	a0,-88(s0)
    16ae:	077030ef          	jal	4f24 <close>
    wait(&xstatus);
    16b2:	fa440513          	addi	a0,s0,-92
    16b6:	04f030ef          	jal	4f04 <wait>
    exit(xstatus);
    16ba:	fa442503          	lw	a0,-92(s0)
    16be:	03f030ef          	jal	4efc <exit>
    16c2:	e0ca                	sd	s2,64(sp)
    16c4:	f852                	sd	s4,48(sp)
    16c6:	f456                	sd	s5,40(sp)
    16c8:	f05a                	sd	s6,32(sp)
    16ca:	ec5e                	sd	s7,24(sp)
    printf("%s: fork() failed\n", s);
    16cc:	85e2                	mv	a1,s8
    16ce:	00005517          	auipc	a0,0x5
    16d2:	92a50513          	addi	a0,a0,-1750 # 5ff8 <statistics+0xaae>
    16d6:	4c7030ef          	jal	539c <printf>
    exit(1);
    16da:	4505                	li	a0,1
    16dc:	021030ef          	jal	4efc <exit>

00000000000016e0 <exitwait>:
{
    16e0:	715d                	addi	sp,sp,-80
    16e2:	e486                	sd	ra,72(sp)
    16e4:	e0a2                	sd	s0,64(sp)
    16e6:	fc26                	sd	s1,56(sp)
    16e8:	f84a                	sd	s2,48(sp)
    16ea:	f44e                	sd	s3,40(sp)
    16ec:	f052                	sd	s4,32(sp)
    16ee:	ec56                	sd	s5,24(sp)
    16f0:	0880                	addi	s0,sp,80
    16f2:	8aaa                	mv	s5,a0
  for(i = 0; i < 100; i++){
    16f4:	4901                	li	s2,0
      if(wait(&xstate) != pid){
    16f6:	fbc40993          	addi	s3,s0,-68
  for(i = 0; i < 100; i++){
    16fa:	06400a13          	li	s4,100
    pid = fork();
    16fe:	7f6030ef          	jal	4ef4 <fork>
    1702:	84aa                	mv	s1,a0
    if(pid < 0){
    1704:	02054863          	bltz	a0,1734 <exitwait+0x54>
    if(pid){
    1708:	c525                	beqz	a0,1770 <exitwait+0x90>
      if(wait(&xstate) != pid){
    170a:	854e                	mv	a0,s3
    170c:	7f8030ef          	jal	4f04 <wait>
    1710:	02951c63          	bne	a0,s1,1748 <exitwait+0x68>
      if(i != xstate) {
    1714:	fbc42783          	lw	a5,-68(s0)
    1718:	05279263          	bne	a5,s2,175c <exitwait+0x7c>
  for(i = 0; i < 100; i++){
    171c:	2905                	addiw	s2,s2,1
    171e:	ff4910e3          	bne	s2,s4,16fe <exitwait+0x1e>
}
    1722:	60a6                	ld	ra,72(sp)
    1724:	6406                	ld	s0,64(sp)
    1726:	74e2                	ld	s1,56(sp)
    1728:	7942                	ld	s2,48(sp)
    172a:	79a2                	ld	s3,40(sp)
    172c:	7a02                	ld	s4,32(sp)
    172e:	6ae2                	ld	s5,24(sp)
    1730:	6161                	addi	sp,sp,80
    1732:	8082                	ret
      printf("%s: fork failed\n", s);
    1734:	85d6                	mv	a1,s5
    1736:	00004517          	auipc	a0,0x4
    173a:	75250513          	addi	a0,a0,1874 # 5e88 <statistics+0x93e>
    173e:	45f030ef          	jal	539c <printf>
      exit(1);
    1742:	4505                	li	a0,1
    1744:	7b8030ef          	jal	4efc <exit>
        printf("%s: wait wrong pid\n", s);
    1748:	85d6                	mv	a1,s5
    174a:	00005517          	auipc	a0,0x5
    174e:	8c650513          	addi	a0,a0,-1850 # 6010 <statistics+0xac6>
    1752:	44b030ef          	jal	539c <printf>
        exit(1);
    1756:	4505                	li	a0,1
    1758:	7a4030ef          	jal	4efc <exit>
        printf("%s: wait wrong exit status\n", s);
    175c:	85d6                	mv	a1,s5
    175e:	00005517          	auipc	a0,0x5
    1762:	8ca50513          	addi	a0,a0,-1846 # 6028 <statistics+0xade>
    1766:	437030ef          	jal	539c <printf>
        exit(1);
    176a:	4505                	li	a0,1
    176c:	790030ef          	jal	4efc <exit>
      exit(i);
    1770:	854a                	mv	a0,s2
    1772:	78a030ef          	jal	4efc <exit>

0000000000001776 <twochildren>:
{
    1776:	1101                	addi	sp,sp,-32
    1778:	ec06                	sd	ra,24(sp)
    177a:	e822                	sd	s0,16(sp)
    177c:	e426                	sd	s1,8(sp)
    177e:	e04a                	sd	s2,0(sp)
    1780:	1000                	addi	s0,sp,32
    1782:	892a                	mv	s2,a0
    1784:	3e800493          	li	s1,1000
    int pid1 = fork();
    1788:	76c030ef          	jal	4ef4 <fork>
    if(pid1 < 0){
    178c:	02054663          	bltz	a0,17b8 <twochildren+0x42>
    if(pid1 == 0){
    1790:	cd15                	beqz	a0,17cc <twochildren+0x56>
      int pid2 = fork();
    1792:	762030ef          	jal	4ef4 <fork>
      if(pid2 < 0){
    1796:	02054d63          	bltz	a0,17d0 <twochildren+0x5a>
      if(pid2 == 0){
    179a:	c529                	beqz	a0,17e4 <twochildren+0x6e>
        wait(0);
    179c:	4501                	li	a0,0
    179e:	766030ef          	jal	4f04 <wait>
        wait(0);
    17a2:	4501                	li	a0,0
    17a4:	760030ef          	jal	4f04 <wait>
  for(int i = 0; i < 1000; i++){
    17a8:	34fd                	addiw	s1,s1,-1
    17aa:	fcf9                	bnez	s1,1788 <twochildren+0x12>
}
    17ac:	60e2                	ld	ra,24(sp)
    17ae:	6442                	ld	s0,16(sp)
    17b0:	64a2                	ld	s1,8(sp)
    17b2:	6902                	ld	s2,0(sp)
    17b4:	6105                	addi	sp,sp,32
    17b6:	8082                	ret
      printf("%s: fork failed\n", s);
    17b8:	85ca                	mv	a1,s2
    17ba:	00004517          	auipc	a0,0x4
    17be:	6ce50513          	addi	a0,a0,1742 # 5e88 <statistics+0x93e>
    17c2:	3db030ef          	jal	539c <printf>
      exit(1);
    17c6:	4505                	li	a0,1
    17c8:	734030ef          	jal	4efc <exit>
      exit(0);
    17cc:	730030ef          	jal	4efc <exit>
        printf("%s: fork failed\n", s);
    17d0:	85ca                	mv	a1,s2
    17d2:	00004517          	auipc	a0,0x4
    17d6:	6b650513          	addi	a0,a0,1718 # 5e88 <statistics+0x93e>
    17da:	3c3030ef          	jal	539c <printf>
        exit(1);
    17de:	4505                	li	a0,1
    17e0:	71c030ef          	jal	4efc <exit>
        exit(0);
    17e4:	718030ef          	jal	4efc <exit>

00000000000017e8 <forkfork>:
{
    17e8:	7179                	addi	sp,sp,-48
    17ea:	f406                	sd	ra,40(sp)
    17ec:	f022                	sd	s0,32(sp)
    17ee:	ec26                	sd	s1,24(sp)
    17f0:	1800                	addi	s0,sp,48
    17f2:	84aa                	mv	s1,a0
    int pid = fork();
    17f4:	700030ef          	jal	4ef4 <fork>
    if(pid < 0){
    17f8:	02054b63          	bltz	a0,182e <forkfork+0x46>
    if(pid == 0){
    17fc:	c139                	beqz	a0,1842 <forkfork+0x5a>
    int pid = fork();
    17fe:	6f6030ef          	jal	4ef4 <fork>
    if(pid < 0){
    1802:	02054663          	bltz	a0,182e <forkfork+0x46>
    if(pid == 0){
    1806:	cd15                	beqz	a0,1842 <forkfork+0x5a>
    wait(&xstatus);
    1808:	fdc40513          	addi	a0,s0,-36
    180c:	6f8030ef          	jal	4f04 <wait>
    if(xstatus != 0) {
    1810:	fdc42783          	lw	a5,-36(s0)
    1814:	ebb9                	bnez	a5,186a <forkfork+0x82>
    wait(&xstatus);
    1816:	fdc40513          	addi	a0,s0,-36
    181a:	6ea030ef          	jal	4f04 <wait>
    if(xstatus != 0) {
    181e:	fdc42783          	lw	a5,-36(s0)
    1822:	e7a1                	bnez	a5,186a <forkfork+0x82>
}
    1824:	70a2                	ld	ra,40(sp)
    1826:	7402                	ld	s0,32(sp)
    1828:	64e2                	ld	s1,24(sp)
    182a:	6145                	addi	sp,sp,48
    182c:	8082                	ret
      printf("%s: fork failed", s);
    182e:	85a6                	mv	a1,s1
    1830:	00005517          	auipc	a0,0x5
    1834:	81850513          	addi	a0,a0,-2024 # 6048 <statistics+0xafe>
    1838:	365030ef          	jal	539c <printf>
      exit(1);
    183c:	4505                	li	a0,1
    183e:	6be030ef          	jal	4efc <exit>
{
    1842:	0c800493          	li	s1,200
        int pid1 = fork();
    1846:	6ae030ef          	jal	4ef4 <fork>
        if(pid1 < 0){
    184a:	00054b63          	bltz	a0,1860 <forkfork+0x78>
        if(pid1 == 0){
    184e:	cd01                	beqz	a0,1866 <forkfork+0x7e>
        wait(0);
    1850:	4501                	li	a0,0
    1852:	6b2030ef          	jal	4f04 <wait>
      for(int j = 0; j < 200; j++){
    1856:	34fd                	addiw	s1,s1,-1
    1858:	f4fd                	bnez	s1,1846 <forkfork+0x5e>
      exit(0);
    185a:	4501                	li	a0,0
    185c:	6a0030ef          	jal	4efc <exit>
          exit(1);
    1860:	4505                	li	a0,1
    1862:	69a030ef          	jal	4efc <exit>
          exit(0);
    1866:	696030ef          	jal	4efc <exit>
      printf("%s: fork in child failed", s);
    186a:	85a6                	mv	a1,s1
    186c:	00004517          	auipc	a0,0x4
    1870:	7ec50513          	addi	a0,a0,2028 # 6058 <statistics+0xb0e>
    1874:	329030ef          	jal	539c <printf>
      exit(1);
    1878:	4505                	li	a0,1
    187a:	682030ef          	jal	4efc <exit>

000000000000187e <reparent2>:
{
    187e:	1101                	addi	sp,sp,-32
    1880:	ec06                	sd	ra,24(sp)
    1882:	e822                	sd	s0,16(sp)
    1884:	e426                	sd	s1,8(sp)
    1886:	1000                	addi	s0,sp,32
    1888:	32000493          	li	s1,800
    int pid1 = fork();
    188c:	668030ef          	jal	4ef4 <fork>
    if(pid1 < 0){
    1890:	00054b63          	bltz	a0,18a6 <reparent2+0x28>
    if(pid1 == 0){
    1894:	c115                	beqz	a0,18b8 <reparent2+0x3a>
    wait(0);
    1896:	4501                	li	a0,0
    1898:	66c030ef          	jal	4f04 <wait>
  for(int i = 0; i < 800; i++){
    189c:	34fd                	addiw	s1,s1,-1
    189e:	f4fd                	bnez	s1,188c <reparent2+0xe>
  exit(0);
    18a0:	4501                	li	a0,0
    18a2:	65a030ef          	jal	4efc <exit>
      printf("fork failed\n");
    18a6:	00006517          	auipc	a0,0x6
    18aa:	b8a50513          	addi	a0,a0,-1142 # 7430 <statistics+0x1ee6>
    18ae:	2ef030ef          	jal	539c <printf>
      exit(1);
    18b2:	4505                	li	a0,1
    18b4:	648030ef          	jal	4efc <exit>
      fork();
    18b8:	63c030ef          	jal	4ef4 <fork>
      fork();
    18bc:	638030ef          	jal	4ef4 <fork>
      exit(0);
    18c0:	4501                	li	a0,0
    18c2:	63a030ef          	jal	4efc <exit>

00000000000018c6 <createdelete>:
{
    18c6:	7135                	addi	sp,sp,-160
    18c8:	ed06                	sd	ra,152(sp)
    18ca:	e922                	sd	s0,144(sp)
    18cc:	e526                	sd	s1,136(sp)
    18ce:	e14a                	sd	s2,128(sp)
    18d0:	fcce                	sd	s3,120(sp)
    18d2:	f8d2                	sd	s4,112(sp)
    18d4:	f4d6                	sd	s5,104(sp)
    18d6:	f0da                	sd	s6,96(sp)
    18d8:	ecde                	sd	s7,88(sp)
    18da:	e8e2                	sd	s8,80(sp)
    18dc:	e4e6                	sd	s9,72(sp)
    18de:	e0ea                	sd	s10,64(sp)
    18e0:	fc6e                	sd	s11,56(sp)
    18e2:	1100                	addi	s0,sp,160
    18e4:	8daa                	mv	s11,a0
  for(pi = 0; pi < NCHILD; pi++){
    18e6:	4901                	li	s2,0
    18e8:	4991                	li	s3,4
    pid = fork();
    18ea:	60a030ef          	jal	4ef4 <fork>
    18ee:	84aa                	mv	s1,a0
    if(pid < 0){
    18f0:	04054063          	bltz	a0,1930 <createdelete+0x6a>
    if(pid == 0){
    18f4:	c921                	beqz	a0,1944 <createdelete+0x7e>
  for(pi = 0; pi < NCHILD; pi++){
    18f6:	2905                	addiw	s2,s2,1
    18f8:	ff3919e3          	bne	s2,s3,18ea <createdelete+0x24>
    18fc:	4491                	li	s1,4
    wait(&xstatus);
    18fe:	f6c40913          	addi	s2,s0,-148
    1902:	854a                	mv	a0,s2
    1904:	600030ef          	jal	4f04 <wait>
    if(xstatus != 0)
    1908:	f6c42a83          	lw	s5,-148(s0)
    190c:	0c0a9263          	bnez	s5,19d0 <createdelete+0x10a>
  for(pi = 0; pi < NCHILD; pi++){
    1910:	34fd                	addiw	s1,s1,-1
    1912:	f8e5                	bnez	s1,1902 <createdelete+0x3c>
  name[0] = name[1] = name[2] = 0;
    1914:	f6040923          	sb	zero,-142(s0)
    1918:	03000993          	li	s3,48
    191c:	5a7d                	li	s4,-1
      if((i == 0 || i >= N/2) && fd < 0){
    191e:	4d25                	li	s10,9
    1920:	07000c93          	li	s9,112
      fd = open(name, 0);
    1924:	f7040c13          	addi	s8,s0,-144
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1928:	4ba1                	li	s7,8
    for(pi = 0; pi < NCHILD; pi++){
    192a:	07400b13          	li	s6,116
    192e:	aa39                	j	1a4c <createdelete+0x186>
      printf("%s: fork failed\n", s);
    1930:	85ee                	mv	a1,s11
    1932:	00004517          	auipc	a0,0x4
    1936:	55650513          	addi	a0,a0,1366 # 5e88 <statistics+0x93e>
    193a:	263030ef          	jal	539c <printf>
      exit(1);
    193e:	4505                	li	a0,1
    1940:	5bc030ef          	jal	4efc <exit>
      name[0] = 'p' + pi;
    1944:	0709091b          	addiw	s2,s2,112
    1948:	f7240823          	sb	s2,-144(s0)
      name[2] = '\0';
    194c:	f6040923          	sb	zero,-142(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1950:	f7040913          	addi	s2,s0,-144
    1954:	20200993          	li	s3,514
      for(i = 0; i < N; i++){
    1958:	4a51                	li	s4,20
    195a:	a815                	j	198e <createdelete+0xc8>
          printf("%s: create failed\n", s);
    195c:	85ee                	mv	a1,s11
    195e:	00004517          	auipc	a0,0x4
    1962:	5c250513          	addi	a0,a0,1474 # 5f20 <statistics+0x9d6>
    1966:	237030ef          	jal	539c <printf>
          exit(1);
    196a:	4505                	li	a0,1
    196c:	590030ef          	jal	4efc <exit>
          name[1] = '0' + (i / 2);
    1970:	01f4d79b          	srliw	a5,s1,0x1f
    1974:	9fa5                	addw	a5,a5,s1
    1976:	4017d79b          	sraiw	a5,a5,0x1
    197a:	0307879b          	addiw	a5,a5,48
    197e:	f6f408a3          	sb	a5,-143(s0)
          if(unlink(name) < 0){
    1982:	854a                	mv	a0,s2
    1984:	5c8030ef          	jal	4f4c <unlink>
    1988:	02054a63          	bltz	a0,19bc <createdelete+0xf6>
      for(i = 0; i < N; i++){
    198c:	2485                	addiw	s1,s1,1
        name[1] = '0' + i;
    198e:	0304879b          	addiw	a5,s1,48
    1992:	f6f408a3          	sb	a5,-143(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1996:	85ce                	mv	a1,s3
    1998:	854a                	mv	a0,s2
    199a:	5a2030ef          	jal	4f3c <open>
        if(fd < 0){
    199e:	fa054fe3          	bltz	a0,195c <createdelete+0x96>
        close(fd);
    19a2:	582030ef          	jal	4f24 <close>
        if(i > 0 && (i % 2 ) == 0){
    19a6:	fe9053e3          	blez	s1,198c <createdelete+0xc6>
    19aa:	0014f793          	andi	a5,s1,1
    19ae:	d3e9                	beqz	a5,1970 <createdelete+0xaa>
      for(i = 0; i < N; i++){
    19b0:	2485                	addiw	s1,s1,1
    19b2:	fd449ee3          	bne	s1,s4,198e <createdelete+0xc8>
      exit(0);
    19b6:	4501                	li	a0,0
    19b8:	544030ef          	jal	4efc <exit>
            printf("%s: unlink failed\n", s);
    19bc:	85ee                	mv	a1,s11
    19be:	00004517          	auipc	a0,0x4
    19c2:	6ba50513          	addi	a0,a0,1722 # 6078 <statistics+0xb2e>
    19c6:	1d7030ef          	jal	539c <printf>
            exit(1);
    19ca:	4505                	li	a0,1
    19cc:	530030ef          	jal	4efc <exit>
      exit(1);
    19d0:	4505                	li	a0,1
    19d2:	52a030ef          	jal	4efc <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    19d6:	f7040613          	addi	a2,s0,-144
    19da:	85ee                	mv	a1,s11
    19dc:	00004517          	auipc	a0,0x4
    19e0:	6b450513          	addi	a0,a0,1716 # 6090 <statistics+0xb46>
    19e4:	1b9030ef          	jal	539c <printf>
        exit(1);
    19e8:	4505                	li	a0,1
    19ea:	512030ef          	jal	4efc <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    19ee:	02054063          	bltz	a0,1a0e <createdelete+0x148>
        printf("%s: oops createdelete %s did exist\n", s, name);
    19f2:	f7040613          	addi	a2,s0,-144
    19f6:	85ee                	mv	a1,s11
    19f8:	00004517          	auipc	a0,0x4
    19fc:	6c050513          	addi	a0,a0,1728 # 60b8 <statistics+0xb6e>
    1a00:	19d030ef          	jal	539c <printf>
        exit(1);
    1a04:	4505                	li	a0,1
    1a06:	4f6030ef          	jal	4efc <exit>
        close(fd);
    1a0a:	51a030ef          	jal	4f24 <close>
    for(pi = 0; pi < NCHILD; pi++){
    1a0e:	2485                	addiw	s1,s1,1
    1a10:	0ff4f493          	zext.b	s1,s1
    1a14:	03648463          	beq	s1,s6,1a3c <createdelete+0x176>
      name[0] = 'p' + pi;
    1a18:	f6940823          	sb	s1,-144(s0)
      name[1] = '0' + i;
    1a1c:	f73408a3          	sb	s3,-143(s0)
      fd = open(name, 0);
    1a20:	4581                	li	a1,0
    1a22:	8562                	mv	a0,s8
    1a24:	518030ef          	jal	4f3c <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1a28:	01f5579b          	srliw	a5,a0,0x1f
    1a2c:	00f977b3          	and	a5,s2,a5
    1a30:	f3dd                	bnez	a5,19d6 <createdelete+0x110>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1a32:	fb4bfee3          	bgeu	s7,s4,19ee <createdelete+0x128>
      if(fd >= 0)
    1a36:	fc054ce3          	bltz	a0,1a0e <createdelete+0x148>
    1a3a:	bfc1                	j	1a0a <createdelete+0x144>
  for(i = 0; i < N; i++){
    1a3c:	2a85                	addiw	s5,s5,1
    1a3e:	2a05                	addiw	s4,s4,1
    1a40:	2985                	addiw	s3,s3,1
    1a42:	0ff9f993          	zext.b	s3,s3
    1a46:	47d1                	li	a5,20
    1a48:	00fa8a63          	beq	s5,a5,1a5c <createdelete+0x196>
      if((i == 0 || i >= N/2) && fd < 0){
    1a4c:	001ab913          	seqz	s2,s5
    1a50:	015d27b3          	slt	a5,s10,s5
    1a54:	00f96933          	or	s2,s2,a5
    1a58:	84e6                	mv	s1,s9
    1a5a:	bf7d                	j	1a18 <createdelete+0x152>
  for(i = 0; i < N; i++){
    1a5c:	03000913          	li	s2,48
  name[0] = name[1] = name[2] = 0;
    1a60:	07000b13          	li	s6,112
      unlink(name);
    1a64:	f7040a13          	addi	s4,s0,-144
    for(pi = 0; pi < NCHILD; pi++){
    1a68:	07400993          	li	s3,116
  for(i = 0; i < N; i++){
    1a6c:	04400a93          	li	s5,68
  name[0] = name[1] = name[2] = 0;
    1a70:	84da                	mv	s1,s6
      name[0] = 'p' + pi;
    1a72:	f6940823          	sb	s1,-144(s0)
      name[1] = '0' + i;
    1a76:	f72408a3          	sb	s2,-143(s0)
      unlink(name);
    1a7a:	8552                	mv	a0,s4
    1a7c:	4d0030ef          	jal	4f4c <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1a80:	2485                	addiw	s1,s1,1
    1a82:	0ff4f493          	zext.b	s1,s1
    1a86:	ff3496e3          	bne	s1,s3,1a72 <createdelete+0x1ac>
  for(i = 0; i < N; i++){
    1a8a:	2905                	addiw	s2,s2,1
    1a8c:	0ff97913          	zext.b	s2,s2
    1a90:	ff5910e3          	bne	s2,s5,1a70 <createdelete+0x1aa>
}
    1a94:	60ea                	ld	ra,152(sp)
    1a96:	644a                	ld	s0,144(sp)
    1a98:	64aa                	ld	s1,136(sp)
    1a9a:	690a                	ld	s2,128(sp)
    1a9c:	79e6                	ld	s3,120(sp)
    1a9e:	7a46                	ld	s4,112(sp)
    1aa0:	7aa6                	ld	s5,104(sp)
    1aa2:	7b06                	ld	s6,96(sp)
    1aa4:	6be6                	ld	s7,88(sp)
    1aa6:	6c46                	ld	s8,80(sp)
    1aa8:	6ca6                	ld	s9,72(sp)
    1aaa:	6d06                	ld	s10,64(sp)
    1aac:	7de2                	ld	s11,56(sp)
    1aae:	610d                	addi	sp,sp,160
    1ab0:	8082                	ret

0000000000001ab2 <linkunlink>:
{
    1ab2:	711d                	addi	sp,sp,-96
    1ab4:	ec86                	sd	ra,88(sp)
    1ab6:	e8a2                	sd	s0,80(sp)
    1ab8:	e4a6                	sd	s1,72(sp)
    1aba:	e0ca                	sd	s2,64(sp)
    1abc:	fc4e                	sd	s3,56(sp)
    1abe:	f852                	sd	s4,48(sp)
    1ac0:	f456                	sd	s5,40(sp)
    1ac2:	f05a                	sd	s6,32(sp)
    1ac4:	ec5e                	sd	s7,24(sp)
    1ac6:	e862                	sd	s8,16(sp)
    1ac8:	e466                	sd	s9,8(sp)
    1aca:	e06a                	sd	s10,0(sp)
    1acc:	1080                	addi	s0,sp,96
    1ace:	84aa                	mv	s1,a0
  unlink("x");
    1ad0:	00004517          	auipc	a0,0x4
    1ad4:	b9850513          	addi	a0,a0,-1128 # 5668 <statistics+0x11e>
    1ad8:	474030ef          	jal	4f4c <unlink>
  pid = fork();
    1adc:	418030ef          	jal	4ef4 <fork>
  if(pid < 0){
    1ae0:	04054663          	bltz	a0,1b2c <linkunlink+0x7a>
    1ae4:	8d2a                	mv	s10,a0
  unsigned int x = (pid ? 1 : 97);
    1ae6:	00153913          	seqz	s2,a0
    1aea:	41200933          	neg	s2,s2
    1aee:	06097913          	andi	s2,s2,96
    1af2:	0905                	addi	s2,s2,1
    1af4:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1af8:	41c65ab7          	lui	s5,0x41c65
    1afc:	e6da8a9b          	addiw	s5,s5,-403 # 41c64e6d <base+0x41c561c5>
    1b00:	6a0d                	lui	s4,0x3
    1b02:	039a0a1b          	addiw	s4,s4,57 # 3039 <subdir+0x33d>
    if((x % 3) == 0){
    1b06:	000ab9b7          	lui	s3,0xab
    1b0a:	aab98993          	addi	s3,s3,-1365 # aaaab <base+0x9be03>
    1b0e:	09b2                	slli	s3,s3,0xc
    1b10:	aab98993          	addi	s3,s3,-1365
    } else if((x % 3) == 1){
    1b14:	4b85                	li	s7,1
      unlink("x");
    1b16:	00004b17          	auipc	s6,0x4
    1b1a:	b52b0b13          	addi	s6,s6,-1198 # 5668 <statistics+0x11e>
      link("cat", "x");
    1b1e:	00004c97          	auipc	s9,0x4
    1b22:	5c2c8c93          	addi	s9,s9,1474 # 60e0 <statistics+0xb96>
      close(open("x", O_RDWR | O_CREATE));
    1b26:	20200c13          	li	s8,514
    1b2a:	a03d                	j	1b58 <linkunlink+0xa6>
    printf("%s: fork failed\n", s);
    1b2c:	85a6                	mv	a1,s1
    1b2e:	00004517          	auipc	a0,0x4
    1b32:	35a50513          	addi	a0,a0,858 # 5e88 <statistics+0x93e>
    1b36:	067030ef          	jal	539c <printf>
    exit(1);
    1b3a:	4505                	li	a0,1
    1b3c:	3c0030ef          	jal	4efc <exit>
      close(open("x", O_RDWR | O_CREATE));
    1b40:	85e2                	mv	a1,s8
    1b42:	855a                	mv	a0,s6
    1b44:	3f8030ef          	jal	4f3c <open>
    1b48:	3dc030ef          	jal	4f24 <close>
    1b4c:	a021                	j	1b54 <linkunlink+0xa2>
      unlink("x");
    1b4e:	855a                	mv	a0,s6
    1b50:	3fc030ef          	jal	4f4c <unlink>
  for(i = 0; i < 100; i++){
    1b54:	34fd                	addiw	s1,s1,-1
    1b56:	c885                	beqz	s1,1b86 <linkunlink+0xd4>
    x = x * 1103515245 + 12345;
    1b58:	035907bb          	mulw	a5,s2,s5
    1b5c:	00fa07bb          	addw	a5,s4,a5
    1b60:	893e                	mv	s2,a5
    if((x % 3) == 0){
    1b62:	02079713          	slli	a4,a5,0x20
    1b66:	9301                	srli	a4,a4,0x20
    1b68:	03370733          	mul	a4,a4,s3
    1b6c:	9305                	srli	a4,a4,0x21
    1b6e:	0017169b          	slliw	a3,a4,0x1
    1b72:	9f35                	addw	a4,a4,a3
    1b74:	9f99                	subw	a5,a5,a4
    1b76:	d7e9                	beqz	a5,1b40 <linkunlink+0x8e>
    } else if((x % 3) == 1){
    1b78:	fd779be3          	bne	a5,s7,1b4e <linkunlink+0x9c>
      link("cat", "x");
    1b7c:	85da                	mv	a1,s6
    1b7e:	8566                	mv	a0,s9
    1b80:	3dc030ef          	jal	4f5c <link>
    1b84:	bfc1                	j	1b54 <linkunlink+0xa2>
  if(pid)
    1b86:	020d0363          	beqz	s10,1bac <linkunlink+0xfa>
    wait(0);
    1b8a:	4501                	li	a0,0
    1b8c:	378030ef          	jal	4f04 <wait>
}
    1b90:	60e6                	ld	ra,88(sp)
    1b92:	6446                	ld	s0,80(sp)
    1b94:	64a6                	ld	s1,72(sp)
    1b96:	6906                	ld	s2,64(sp)
    1b98:	79e2                	ld	s3,56(sp)
    1b9a:	7a42                	ld	s4,48(sp)
    1b9c:	7aa2                	ld	s5,40(sp)
    1b9e:	7b02                	ld	s6,32(sp)
    1ba0:	6be2                	ld	s7,24(sp)
    1ba2:	6c42                	ld	s8,16(sp)
    1ba4:	6ca2                	ld	s9,8(sp)
    1ba6:	6d02                	ld	s10,0(sp)
    1ba8:	6125                	addi	sp,sp,96
    1baa:	8082                	ret
    exit(0);
    1bac:	4501                	li	a0,0
    1bae:	34e030ef          	jal	4efc <exit>

0000000000001bb2 <forktest>:
{
    1bb2:	7179                	addi	sp,sp,-48
    1bb4:	f406                	sd	ra,40(sp)
    1bb6:	f022                	sd	s0,32(sp)
    1bb8:	ec26                	sd	s1,24(sp)
    1bba:	e84a                	sd	s2,16(sp)
    1bbc:	e44e                	sd	s3,8(sp)
    1bbe:	1800                	addi	s0,sp,48
    1bc0:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    1bc2:	4481                	li	s1,0
    1bc4:	3e800913          	li	s2,1000
    pid = fork();
    1bc8:	32c030ef          	jal	4ef4 <fork>
    if(pid < 0)
    1bcc:	06054063          	bltz	a0,1c2c <forktest+0x7a>
    if(pid == 0)
    1bd0:	cd11                	beqz	a0,1bec <forktest+0x3a>
  for(n=0; n<N; n++){
    1bd2:	2485                	addiw	s1,s1,1
    1bd4:	ff249ae3          	bne	s1,s2,1bc8 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    1bd8:	85ce                	mv	a1,s3
    1bda:	00004517          	auipc	a0,0x4
    1bde:	55650513          	addi	a0,a0,1366 # 6130 <statistics+0xbe6>
    1be2:	7ba030ef          	jal	539c <printf>
    exit(1);
    1be6:	4505                	li	a0,1
    1be8:	314030ef          	jal	4efc <exit>
      exit(0);
    1bec:	310030ef          	jal	4efc <exit>
    printf("%s: no fork at all!\n", s);
    1bf0:	85ce                	mv	a1,s3
    1bf2:	00004517          	auipc	a0,0x4
    1bf6:	4f650513          	addi	a0,a0,1270 # 60e8 <statistics+0xb9e>
    1bfa:	7a2030ef          	jal	539c <printf>
    exit(1);
    1bfe:	4505                	li	a0,1
    1c00:	2fc030ef          	jal	4efc <exit>
      printf("%s: wait stopped early\n", s);
    1c04:	85ce                	mv	a1,s3
    1c06:	00004517          	auipc	a0,0x4
    1c0a:	4fa50513          	addi	a0,a0,1274 # 6100 <statistics+0xbb6>
    1c0e:	78e030ef          	jal	539c <printf>
      exit(1);
    1c12:	4505                	li	a0,1
    1c14:	2e8030ef          	jal	4efc <exit>
    printf("%s: wait got too many\n", s);
    1c18:	85ce                	mv	a1,s3
    1c1a:	00004517          	auipc	a0,0x4
    1c1e:	4fe50513          	addi	a0,a0,1278 # 6118 <statistics+0xbce>
    1c22:	77a030ef          	jal	539c <printf>
    exit(1);
    1c26:	4505                	li	a0,1
    1c28:	2d4030ef          	jal	4efc <exit>
  if (n == 0) {
    1c2c:	d0f1                	beqz	s1,1bf0 <forktest+0x3e>
  for(; n > 0; n--){
    1c2e:	00905963          	blez	s1,1c40 <forktest+0x8e>
    if(wait(0) < 0){
    1c32:	4501                	li	a0,0
    1c34:	2d0030ef          	jal	4f04 <wait>
    1c38:	fc0546e3          	bltz	a0,1c04 <forktest+0x52>
  for(; n > 0; n--){
    1c3c:	34fd                	addiw	s1,s1,-1
    1c3e:	f8f5                	bnez	s1,1c32 <forktest+0x80>
  if(wait(0) != -1){
    1c40:	4501                	li	a0,0
    1c42:	2c2030ef          	jal	4f04 <wait>
    1c46:	57fd                	li	a5,-1
    1c48:	fcf518e3          	bne	a0,a5,1c18 <forktest+0x66>
}
    1c4c:	70a2                	ld	ra,40(sp)
    1c4e:	7402                	ld	s0,32(sp)
    1c50:	64e2                	ld	s1,24(sp)
    1c52:	6942                	ld	s2,16(sp)
    1c54:	69a2                	ld	s3,8(sp)
    1c56:	6145                	addi	sp,sp,48
    1c58:	8082                	ret

0000000000001c5a <kernmem>:
{
    1c5a:	715d                	addi	sp,sp,-80
    1c5c:	e486                	sd	ra,72(sp)
    1c5e:	e0a2                	sd	s0,64(sp)
    1c60:	fc26                	sd	s1,56(sp)
    1c62:	f84a                	sd	s2,48(sp)
    1c64:	f44e                	sd	s3,40(sp)
    1c66:	f052                	sd	s4,32(sp)
    1c68:	ec56                	sd	s5,24(sp)
    1c6a:	e85a                	sd	s6,16(sp)
    1c6c:	0880                	addi	s0,sp,80
    1c6e:	8b2a                	mv	s6,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1c70:	4485                	li	s1,1
    1c72:	04fe                	slli	s1,s1,0x1f
    wait(&xstatus);
    1c74:	fbc40a93          	addi	s5,s0,-68
    if(xstatus != -1)  // did kernel kill child?
    1c78:	5a7d                	li	s4,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1c7a:	69b1                	lui	s3,0xc
    1c7c:	35098993          	addi	s3,s3,848 # c350 <buf+0x6a8>
    1c80:	1003d937          	lui	s2,0x1003d
    1c84:	090e                	slli	s2,s2,0x3
    1c86:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002e7d8>
    pid = fork();
    1c8a:	26a030ef          	jal	4ef4 <fork>
    if(pid < 0){
    1c8e:	02054763          	bltz	a0,1cbc <kernmem+0x62>
    if(pid == 0){
    1c92:	cd1d                	beqz	a0,1cd0 <kernmem+0x76>
    wait(&xstatus);
    1c94:	8556                	mv	a0,s5
    1c96:	26e030ef          	jal	4f04 <wait>
    if(xstatus != -1)  // did kernel kill child?
    1c9a:	fbc42783          	lw	a5,-68(s0)
    1c9e:	05479663          	bne	a5,s4,1cea <kernmem+0x90>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1ca2:	94ce                	add	s1,s1,s3
    1ca4:	ff2493e3          	bne	s1,s2,1c8a <kernmem+0x30>
}
    1ca8:	60a6                	ld	ra,72(sp)
    1caa:	6406                	ld	s0,64(sp)
    1cac:	74e2                	ld	s1,56(sp)
    1cae:	7942                	ld	s2,48(sp)
    1cb0:	79a2                	ld	s3,40(sp)
    1cb2:	7a02                	ld	s4,32(sp)
    1cb4:	6ae2                	ld	s5,24(sp)
    1cb6:	6b42                	ld	s6,16(sp)
    1cb8:	6161                	addi	sp,sp,80
    1cba:	8082                	ret
      printf("%s: fork failed\n", s);
    1cbc:	85da                	mv	a1,s6
    1cbe:	00004517          	auipc	a0,0x4
    1cc2:	1ca50513          	addi	a0,a0,458 # 5e88 <statistics+0x93e>
    1cc6:	6d6030ef          	jal	539c <printf>
      exit(1);
    1cca:	4505                	li	a0,1
    1ccc:	230030ef          	jal	4efc <exit>
      printf("%s: oops could read %p = %x\n", s, a, *a);
    1cd0:	0004c683          	lbu	a3,0(s1)
    1cd4:	8626                	mv	a2,s1
    1cd6:	85da                	mv	a1,s6
    1cd8:	00004517          	auipc	a0,0x4
    1cdc:	48050513          	addi	a0,a0,1152 # 6158 <statistics+0xc0e>
    1ce0:	6bc030ef          	jal	539c <printf>
      exit(1);
    1ce4:	4505                	li	a0,1
    1ce6:	216030ef          	jal	4efc <exit>
      exit(1);
    1cea:	4505                	li	a0,1
    1cec:	210030ef          	jal	4efc <exit>

0000000000001cf0 <MAXVAplus>:
{
    1cf0:	7139                	addi	sp,sp,-64
    1cf2:	fc06                	sd	ra,56(sp)
    1cf4:	f822                	sd	s0,48(sp)
    1cf6:	0080                	addi	s0,sp,64
  volatile uint64 a = MAXVA;
    1cf8:	4785                	li	a5,1
    1cfa:	179a                	slli	a5,a5,0x26
    1cfc:	fcf43423          	sd	a5,-56(s0)
  for( ; a != 0; a <<= 1){
    1d00:	fc843783          	ld	a5,-56(s0)
    1d04:	cf9d                	beqz	a5,1d42 <MAXVAplus+0x52>
    1d06:	f426                	sd	s1,40(sp)
    1d08:	f04a                	sd	s2,32(sp)
    1d0a:	ec4e                	sd	s3,24(sp)
    1d0c:	89aa                	mv	s3,a0
    wait(&xstatus);
    1d0e:	fc440913          	addi	s2,s0,-60
    if(xstatus != -1)  // did kernel kill child?
    1d12:	54fd                	li	s1,-1
    pid = fork();
    1d14:	1e0030ef          	jal	4ef4 <fork>
    if(pid < 0){
    1d18:	02054963          	bltz	a0,1d4a <MAXVAplus+0x5a>
    if(pid == 0){
    1d1c:	c129                	beqz	a0,1d5e <MAXVAplus+0x6e>
    wait(&xstatus);
    1d1e:	854a                	mv	a0,s2
    1d20:	1e4030ef          	jal	4f04 <wait>
    if(xstatus != -1)  // did kernel kill child?
    1d24:	fc442783          	lw	a5,-60(s0)
    1d28:	04979d63          	bne	a5,s1,1d82 <MAXVAplus+0x92>
  for( ; a != 0; a <<= 1){
    1d2c:	fc843783          	ld	a5,-56(s0)
    1d30:	0786                	slli	a5,a5,0x1
    1d32:	fcf43423          	sd	a5,-56(s0)
    1d36:	fc843783          	ld	a5,-56(s0)
    1d3a:	ffe9                	bnez	a5,1d14 <MAXVAplus+0x24>
    1d3c:	74a2                	ld	s1,40(sp)
    1d3e:	7902                	ld	s2,32(sp)
    1d40:	69e2                	ld	s3,24(sp)
}
    1d42:	70e2                	ld	ra,56(sp)
    1d44:	7442                	ld	s0,48(sp)
    1d46:	6121                	addi	sp,sp,64
    1d48:	8082                	ret
      printf("%s: fork failed\n", s);
    1d4a:	85ce                	mv	a1,s3
    1d4c:	00004517          	auipc	a0,0x4
    1d50:	13c50513          	addi	a0,a0,316 # 5e88 <statistics+0x93e>
    1d54:	648030ef          	jal	539c <printf>
      exit(1);
    1d58:	4505                	li	a0,1
    1d5a:	1a2030ef          	jal	4efc <exit>
      *(char*)a = 99;
    1d5e:	fc843783          	ld	a5,-56(s0)
    1d62:	06300713          	li	a4,99
    1d66:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %p\n", s, (void*)a);
    1d6a:	fc843603          	ld	a2,-56(s0)
    1d6e:	85ce                	mv	a1,s3
    1d70:	00004517          	auipc	a0,0x4
    1d74:	40850513          	addi	a0,a0,1032 # 6178 <statistics+0xc2e>
    1d78:	624030ef          	jal	539c <printf>
      exit(1);
    1d7c:	4505                	li	a0,1
    1d7e:	17e030ef          	jal	4efc <exit>
      exit(1);
    1d82:	4505                	li	a0,1
    1d84:	178030ef          	jal	4efc <exit>

0000000000001d88 <stacktest>:
{
    1d88:	7179                	addi	sp,sp,-48
    1d8a:	f406                	sd	ra,40(sp)
    1d8c:	f022                	sd	s0,32(sp)
    1d8e:	ec26                	sd	s1,24(sp)
    1d90:	1800                	addi	s0,sp,48
    1d92:	84aa                	mv	s1,a0
  pid = fork();
    1d94:	160030ef          	jal	4ef4 <fork>
  if(pid == 0) {
    1d98:	cd11                	beqz	a0,1db4 <stacktest+0x2c>
  } else if(pid < 0){
    1d9a:	02054c63          	bltz	a0,1dd2 <stacktest+0x4a>
  wait(&xstatus);
    1d9e:	fdc40513          	addi	a0,s0,-36
    1da2:	162030ef          	jal	4f04 <wait>
  if(xstatus == -1)  // kernel killed child?
    1da6:	fdc42503          	lw	a0,-36(s0)
    1daa:	57fd                	li	a5,-1
    1dac:	02f50d63          	beq	a0,a5,1de6 <stacktest+0x5e>
    exit(xstatus);
    1db0:	14c030ef          	jal	4efc <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    1db4:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %d\n", s, *sp);
    1db6:	77fd                	lui	a5,0xfffff
    1db8:	97ba                	add	a5,a5,a4
    1dba:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xffffffffffff0358>
    1dbe:	85a6                	mv	a1,s1
    1dc0:	00004517          	auipc	a0,0x4
    1dc4:	3d050513          	addi	a0,a0,976 # 6190 <statistics+0xc46>
    1dc8:	5d4030ef          	jal	539c <printf>
    exit(1);
    1dcc:	4505                	li	a0,1
    1dce:	12e030ef          	jal	4efc <exit>
    printf("%s: fork failed\n", s);
    1dd2:	85a6                	mv	a1,s1
    1dd4:	00004517          	auipc	a0,0x4
    1dd8:	0b450513          	addi	a0,a0,180 # 5e88 <statistics+0x93e>
    1ddc:	5c0030ef          	jal	539c <printf>
    exit(1);
    1de0:	4505                	li	a0,1
    1de2:	11a030ef          	jal	4efc <exit>
    exit(0);
    1de6:	4501                	li	a0,0
    1de8:	114030ef          	jal	4efc <exit>

0000000000001dec <nowrite>:
{
    1dec:	7159                	addi	sp,sp,-112
    1dee:	f486                	sd	ra,104(sp)
    1df0:	f0a2                	sd	s0,96(sp)
    1df2:	eca6                	sd	s1,88(sp)
    1df4:	e8ca                	sd	s2,80(sp)
    1df6:	e4ce                	sd	s3,72(sp)
    1df8:	e0d2                	sd	s4,64(sp)
    1dfa:	1880                	addi	s0,sp,112
    1dfc:	8a2a                	mv	s4,a0
  uint64 addrs[] = { 0, 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
    1dfe:	00006797          	auipc	a5,0x6
    1e02:	c7278793          	addi	a5,a5,-910 # 7a70 <statistics+0x2526>
    1e06:	7788                	ld	a0,40(a5)
    1e08:	7b8c                	ld	a1,48(a5)
    1e0a:	7f90                	ld	a2,56(a5)
    1e0c:	63b4                	ld	a3,64(a5)
    1e0e:	67b8                	ld	a4,72(a5)
    1e10:	f8a43c23          	sd	a0,-104(s0)
    1e14:	fab43023          	sd	a1,-96(s0)
    1e18:	fac43423          	sd	a2,-88(s0)
    1e1c:	fad43823          	sd	a3,-80(s0)
    1e20:	fae43c23          	sd	a4,-72(s0)
    1e24:	6bbc                	ld	a5,80(a5)
    1e26:	fcf43023          	sd	a5,-64(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    1e2a:	4481                	li	s1,0
    wait(&xstatus);
    1e2c:	fcc40913          	addi	s2,s0,-52
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    1e30:	4999                	li	s3,6
    pid = fork();
    1e32:	0c2030ef          	jal	4ef4 <fork>
    if(pid == 0) {
    1e36:	cd19                	beqz	a0,1e54 <nowrite+0x68>
    } else if(pid < 0){
    1e38:	04054063          	bltz	a0,1e78 <nowrite+0x8c>
    wait(&xstatus);
    1e3c:	854a                	mv	a0,s2
    1e3e:	0c6030ef          	jal	4f04 <wait>
    if(xstatus == 0){
    1e42:	fcc42783          	lw	a5,-52(s0)
    1e46:	c3b9                	beqz	a5,1e8c <nowrite+0xa0>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    1e48:	2485                	addiw	s1,s1,1
    1e4a:	ff3494e3          	bne	s1,s3,1e32 <nowrite+0x46>
  exit(0);
    1e4e:	4501                	li	a0,0
    1e50:	0ac030ef          	jal	4efc <exit>
      volatile int *addr = (int *) addrs[ai];
    1e54:	048e                	slli	s1,s1,0x3
    1e56:	fd040793          	addi	a5,s0,-48
    1e5a:	94be                	add	s1,s1,a5
    1e5c:	fc84b603          	ld	a2,-56(s1)
      *addr = 10;
    1e60:	47a9                	li	a5,10
    1e62:	c21c                	sw	a5,0(a2)
      printf("%s: write to %p did not fail!\n", s, addr);
    1e64:	85d2                	mv	a1,s4
    1e66:	00004517          	auipc	a0,0x4
    1e6a:	35250513          	addi	a0,a0,850 # 61b8 <statistics+0xc6e>
    1e6e:	52e030ef          	jal	539c <printf>
      exit(0);
    1e72:	4501                	li	a0,0
    1e74:	088030ef          	jal	4efc <exit>
      printf("%s: fork failed\n", s);
    1e78:	85d2                	mv	a1,s4
    1e7a:	00004517          	auipc	a0,0x4
    1e7e:	00e50513          	addi	a0,a0,14 # 5e88 <statistics+0x93e>
    1e82:	51a030ef          	jal	539c <printf>
      exit(1);
    1e86:	4505                	li	a0,1
    1e88:	074030ef          	jal	4efc <exit>
      exit(1);
    1e8c:	4505                	li	a0,1
    1e8e:	06e030ef          	jal	4efc <exit>

0000000000001e92 <manywrites>:
{
    1e92:	7159                	addi	sp,sp,-112
    1e94:	f486                	sd	ra,104(sp)
    1e96:	f0a2                	sd	s0,96(sp)
    1e98:	eca6                	sd	s1,88(sp)
    1e9a:	e8ca                	sd	s2,80(sp)
    1e9c:	e4ce                	sd	s3,72(sp)
    1e9e:	ec66                	sd	s9,24(sp)
    1ea0:	1880                	addi	s0,sp,112
    1ea2:	8caa                	mv	s9,a0
  for(int ci = 0; ci < nchildren; ci++){
    1ea4:	4901                	li	s2,0
    1ea6:	4991                	li	s3,4
    int pid = fork();
    1ea8:	04c030ef          	jal	4ef4 <fork>
    1eac:	84aa                	mv	s1,a0
    if(pid < 0){
    1eae:	02054c63          	bltz	a0,1ee6 <manywrites+0x54>
    if(pid == 0){
    1eb2:	c929                	beqz	a0,1f04 <manywrites+0x72>
  for(int ci = 0; ci < nchildren; ci++){
    1eb4:	2905                	addiw	s2,s2,1
    1eb6:	ff3919e3          	bne	s2,s3,1ea8 <manywrites+0x16>
    1eba:	4491                	li	s1,4
    wait(&st);
    1ebc:	f9840913          	addi	s2,s0,-104
    int st = 0;
    1ec0:	f8042c23          	sw	zero,-104(s0)
    wait(&st);
    1ec4:	854a                	mv	a0,s2
    1ec6:	03e030ef          	jal	4f04 <wait>
    if(st != 0)
    1eca:	f9842503          	lw	a0,-104(s0)
    1ece:	0e051763          	bnez	a0,1fbc <manywrites+0x12a>
  for(int ci = 0; ci < nchildren; ci++){
    1ed2:	34fd                	addiw	s1,s1,-1
    1ed4:	f4f5                	bnez	s1,1ec0 <manywrites+0x2e>
    1ed6:	e0d2                	sd	s4,64(sp)
    1ed8:	fc56                	sd	s5,56(sp)
    1eda:	f85a                	sd	s6,48(sp)
    1edc:	f45e                	sd	s7,40(sp)
    1ede:	f062                	sd	s8,32(sp)
    1ee0:	e86a                	sd	s10,16(sp)
  exit(0);
    1ee2:	01a030ef          	jal	4efc <exit>
    1ee6:	e0d2                	sd	s4,64(sp)
    1ee8:	fc56                	sd	s5,56(sp)
    1eea:	f85a                	sd	s6,48(sp)
    1eec:	f45e                	sd	s7,40(sp)
    1eee:	f062                	sd	s8,32(sp)
    1ef0:	e86a                	sd	s10,16(sp)
      printf("fork failed\n");
    1ef2:	00005517          	auipc	a0,0x5
    1ef6:	53e50513          	addi	a0,a0,1342 # 7430 <statistics+0x1ee6>
    1efa:	4a2030ef          	jal	539c <printf>
      exit(1);
    1efe:	4505                	li	a0,1
    1f00:	7fd020ef          	jal	4efc <exit>
    1f04:	e0d2                	sd	s4,64(sp)
    1f06:	fc56                	sd	s5,56(sp)
    1f08:	f85a                	sd	s6,48(sp)
    1f0a:	f45e                	sd	s7,40(sp)
    1f0c:	f062                	sd	s8,32(sp)
    1f0e:	e86a                	sd	s10,16(sp)
      name[0] = 'b';
    1f10:	06200793          	li	a5,98
    1f14:	f8f40c23          	sb	a5,-104(s0)
      name[1] = 'a' + ci;
    1f18:	0619079b          	addiw	a5,s2,97
    1f1c:	f8f40ca3          	sb	a5,-103(s0)
      name[2] = '\0';
    1f20:	f8040d23          	sb	zero,-102(s0)
      unlink(name);
    1f24:	f9840513          	addi	a0,s0,-104
    1f28:	024030ef          	jal	4f4c <unlink>
    1f2c:	47f9                	li	a5,30
    1f2e:	8d3e                	mv	s10,a5
          int fd = open(name, O_CREATE | O_RDWR);
    1f30:	f9840b93          	addi	s7,s0,-104
    1f34:	20200b13          	li	s6,514
          int cc = write(fd, buf, sz);
    1f38:	6a8d                	lui	s5,0x3
    1f3a:	0000ac17          	auipc	s8,0xa
    1f3e:	d6ec0c13          	addi	s8,s8,-658 # bca8 <buf>
        for(int i = 0; i < ci+1; i++){
    1f42:	8a26                	mv	s4,s1
    1f44:	02094563          	bltz	s2,1f6e <manywrites+0xdc>
          int fd = open(name, O_CREATE | O_RDWR);
    1f48:	85da                	mv	a1,s6
    1f4a:	855e                	mv	a0,s7
    1f4c:	7f1020ef          	jal	4f3c <open>
    1f50:	89aa                	mv	s3,a0
          if(fd < 0){
    1f52:	02054d63          	bltz	a0,1f8c <manywrites+0xfa>
          int cc = write(fd, buf, sz);
    1f56:	8656                	mv	a2,s5
    1f58:	85e2                	mv	a1,s8
    1f5a:	7c3020ef          	jal	4f1c <write>
          if(cc != sz){
    1f5e:	05551363          	bne	a0,s5,1fa4 <manywrites+0x112>
          close(fd);
    1f62:	854e                	mv	a0,s3
    1f64:	7c1020ef          	jal	4f24 <close>
        for(int i = 0; i < ci+1; i++){
    1f68:	2a05                	addiw	s4,s4,1
    1f6a:	fd495fe3          	bge	s2,s4,1f48 <manywrites+0xb6>
        unlink(name);
    1f6e:	f9840513          	addi	a0,s0,-104
    1f72:	7db020ef          	jal	4f4c <unlink>
      for(int iters = 0; iters < howmany; iters++){
    1f76:	fffd079b          	addiw	a5,s10,-1
    1f7a:	8d3e                	mv	s10,a5
    1f7c:	f3f9                	bnez	a5,1f42 <manywrites+0xb0>
      unlink(name);
    1f7e:	f9840513          	addi	a0,s0,-104
    1f82:	7cb020ef          	jal	4f4c <unlink>
      exit(0);
    1f86:	4501                	li	a0,0
    1f88:	775020ef          	jal	4efc <exit>
            printf("%s: cannot create %s\n", s, name);
    1f8c:	f9840613          	addi	a2,s0,-104
    1f90:	85e6                	mv	a1,s9
    1f92:	00004517          	auipc	a0,0x4
    1f96:	24650513          	addi	a0,a0,582 # 61d8 <statistics+0xc8e>
    1f9a:	402030ef          	jal	539c <printf>
            exit(1);
    1f9e:	4505                	li	a0,1
    1fa0:	75d020ef          	jal	4efc <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    1fa4:	86aa                	mv	a3,a0
    1fa6:	660d                	lui	a2,0x3
    1fa8:	85e6                	mv	a1,s9
    1faa:	00003517          	auipc	a0,0x3
    1fae:	71e50513          	addi	a0,a0,1822 # 56c8 <statistics+0x17e>
    1fb2:	3ea030ef          	jal	539c <printf>
            exit(1);
    1fb6:	4505                	li	a0,1
    1fb8:	745020ef          	jal	4efc <exit>
    1fbc:	e0d2                	sd	s4,64(sp)
    1fbe:	fc56                	sd	s5,56(sp)
    1fc0:	f85a                	sd	s6,48(sp)
    1fc2:	f45e                	sd	s7,40(sp)
    1fc4:	f062                	sd	s8,32(sp)
    1fc6:	e86a                	sd	s10,16(sp)
      exit(st);
    1fc8:	735020ef          	jal	4efc <exit>

0000000000001fcc <copyinstr3>:
{
    1fcc:	7179                	addi	sp,sp,-48
    1fce:	f406                	sd	ra,40(sp)
    1fd0:	f022                	sd	s0,32(sp)
    1fd2:	ec26                	sd	s1,24(sp)
    1fd4:	1800                	addi	s0,sp,48
  sbrk(8192);
    1fd6:	6509                	lui	a0,0x2
    1fd8:	6f1020ef          	jal	4ec8 <sbrk>
  uint64 top = (uint64) sbrk(0);
    1fdc:	4501                	li	a0,0
    1fde:	6eb020ef          	jal	4ec8 <sbrk>
  if((top % PGSIZE) != 0){
    1fe2:	03451793          	slli	a5,a0,0x34
    1fe6:	e7bd                	bnez	a5,2054 <copyinstr3+0x88>
  top = (uint64) sbrk(0);
    1fe8:	4501                	li	a0,0
    1fea:	6df020ef          	jal	4ec8 <sbrk>
  if(top % PGSIZE){
    1fee:	03451793          	slli	a5,a0,0x34
    1ff2:	ebad                	bnez	a5,2064 <copyinstr3+0x98>
  char *b = (char *) (top - 1);
    1ff4:	fff50493          	addi	s1,a0,-1 # 1fff <copyinstr3+0x33>
  *b = 'x';
    1ff8:	07800793          	li	a5,120
    1ffc:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    2000:	8526                	mv	a0,s1
    2002:	74b020ef          	jal	4f4c <unlink>
  if(ret != -1){
    2006:	57fd                	li	a5,-1
    2008:	06f51763          	bne	a0,a5,2076 <copyinstr3+0xaa>
  int fd = open(b, O_CREATE | O_WRONLY);
    200c:	20100593          	li	a1,513
    2010:	8526                	mv	a0,s1
    2012:	72b020ef          	jal	4f3c <open>
  if(fd != -1){
    2016:	57fd                	li	a5,-1
    2018:	06f51a63          	bne	a0,a5,208c <copyinstr3+0xc0>
  ret = link(b, b);
    201c:	85a6                	mv	a1,s1
    201e:	8526                	mv	a0,s1
    2020:	73d020ef          	jal	4f5c <link>
  if(ret != -1){
    2024:	57fd                	li	a5,-1
    2026:	06f51e63          	bne	a0,a5,20a2 <copyinstr3+0xd6>
  char *args[] = { "xx", 0 };
    202a:	00005797          	auipc	a5,0x5
    202e:	eae78793          	addi	a5,a5,-338 # 6ed8 <statistics+0x198e>
    2032:	fcf43823          	sd	a5,-48(s0)
    2036:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    203a:	fd040593          	addi	a1,s0,-48
    203e:	8526                	mv	a0,s1
    2040:	6f5020ef          	jal	4f34 <exec>
  if(ret != -1){
    2044:	57fd                	li	a5,-1
    2046:	06f51a63          	bne	a0,a5,20ba <copyinstr3+0xee>
}
    204a:	70a2                	ld	ra,40(sp)
    204c:	7402                	ld	s0,32(sp)
    204e:	64e2                	ld	s1,24(sp)
    2050:	6145                	addi	sp,sp,48
    2052:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    2054:	0347d513          	srli	a0,a5,0x34
    2058:	6785                	lui	a5,0x1
    205a:	40a7853b          	subw	a0,a5,a0
    205e:	66b020ef          	jal	4ec8 <sbrk>
    2062:	b759                	j	1fe8 <copyinstr3+0x1c>
    printf("oops\n");
    2064:	00004517          	auipc	a0,0x4
    2068:	18c50513          	addi	a0,a0,396 # 61f0 <statistics+0xca6>
    206c:	330030ef          	jal	539c <printf>
    exit(1);
    2070:	4505                	li	a0,1
    2072:	68b020ef          	jal	4efc <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    2076:	862a                	mv	a2,a0
    2078:	85a6                	mv	a1,s1
    207a:	00004517          	auipc	a0,0x4
    207e:	d2e50513          	addi	a0,a0,-722 # 5da8 <statistics+0x85e>
    2082:	31a030ef          	jal	539c <printf>
    exit(1);
    2086:	4505                	li	a0,1
    2088:	675020ef          	jal	4efc <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    208c:	862a                	mv	a2,a0
    208e:	85a6                	mv	a1,s1
    2090:	00004517          	auipc	a0,0x4
    2094:	d3850513          	addi	a0,a0,-712 # 5dc8 <statistics+0x87e>
    2098:	304030ef          	jal	539c <printf>
    exit(1);
    209c:	4505                	li	a0,1
    209e:	65f020ef          	jal	4efc <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    20a2:	86aa                	mv	a3,a0
    20a4:	8626                	mv	a2,s1
    20a6:	85a6                	mv	a1,s1
    20a8:	00004517          	auipc	a0,0x4
    20ac:	d4050513          	addi	a0,a0,-704 # 5de8 <statistics+0x89e>
    20b0:	2ec030ef          	jal	539c <printf>
    exit(1);
    20b4:	4505                	li	a0,1
    20b6:	647020ef          	jal	4efc <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    20ba:	863e                	mv	a2,a5
    20bc:	85a6                	mv	a1,s1
    20be:	00004517          	auipc	a0,0x4
    20c2:	d5250513          	addi	a0,a0,-686 # 5e10 <statistics+0x8c6>
    20c6:	2d6030ef          	jal	539c <printf>
    exit(1);
    20ca:	4505                	li	a0,1
    20cc:	631020ef          	jal	4efc <exit>

00000000000020d0 <rwsbrk>:
{
    20d0:	1101                	addi	sp,sp,-32
    20d2:	ec06                	sd	ra,24(sp)
    20d4:	e822                	sd	s0,16(sp)
    20d6:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    20d8:	6509                	lui	a0,0x2
    20da:	5ef020ef          	jal	4ec8 <sbrk>
  if(a == (uint64) SBRK_ERROR) {
    20de:	57fd                	li	a5,-1
    20e0:	04f50a63          	beq	a0,a5,2134 <rwsbrk+0x64>
    20e4:	e426                	sd	s1,8(sp)
    20e6:	84aa                	mv	s1,a0
  if (sbrk(-8192) == SBRK_ERROR) {
    20e8:	7579                	lui	a0,0xffffe
    20ea:	5df020ef          	jal	4ec8 <sbrk>
    20ee:	57fd                	li	a5,-1
    20f0:	04f50d63          	beq	a0,a5,214a <rwsbrk+0x7a>
    20f4:	e04a                	sd	s2,0(sp)
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    20f6:	20100593          	li	a1,513
    20fa:	00004517          	auipc	a0,0x4
    20fe:	13650513          	addi	a0,a0,310 # 6230 <statistics+0xce6>
    2102:	63b020ef          	jal	4f3c <open>
    2106:	892a                	mv	s2,a0
  if(fd < 0){
    2108:	04054b63          	bltz	a0,215e <rwsbrk+0x8e>
  n = write(fd, (void*)(a+PGSIZE), 1024);
    210c:	6785                	lui	a5,0x1
    210e:	94be                	add	s1,s1,a5
    2110:	40000613          	li	a2,1024
    2114:	85a6                	mv	a1,s1
    2116:	607020ef          	jal	4f1c <write>
    211a:	862a                	mv	a2,a0
  if(n >= 0){
    211c:	04054a63          	bltz	a0,2170 <rwsbrk+0xa0>
    printf("write(fd, %p, 1024) returned %d, not -1\n", (void*)a+PGSIZE, n);
    2120:	85a6                	mv	a1,s1
    2122:	00004517          	auipc	a0,0x4
    2126:	12e50513          	addi	a0,a0,302 # 6250 <statistics+0xd06>
    212a:	272030ef          	jal	539c <printf>
    exit(1);
    212e:	4505                	li	a0,1
    2130:	5cd020ef          	jal	4efc <exit>
    2134:	e426                	sd	s1,8(sp)
    2136:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) failed\n");
    2138:	00004517          	auipc	a0,0x4
    213c:	0c050513          	addi	a0,a0,192 # 61f8 <statistics+0xcae>
    2140:	25c030ef          	jal	539c <printf>
    exit(1);
    2144:	4505                	li	a0,1
    2146:	5b7020ef          	jal	4efc <exit>
    214a:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) shrink failed\n");
    214c:	00004517          	auipc	a0,0x4
    2150:	0c450513          	addi	a0,a0,196 # 6210 <statistics+0xcc6>
    2154:	248030ef          	jal	539c <printf>
    exit(1);
    2158:	4505                	li	a0,1
    215a:	5a3020ef          	jal	4efc <exit>
    printf("open(rwsbrk) failed\n");
    215e:	00004517          	auipc	a0,0x4
    2162:	0da50513          	addi	a0,a0,218 # 6238 <statistics+0xcee>
    2166:	236030ef          	jal	539c <printf>
    exit(1);
    216a:	4505                	li	a0,1
    216c:	591020ef          	jal	4efc <exit>
  close(fd);
    2170:	854a                	mv	a0,s2
    2172:	5b3020ef          	jal	4f24 <close>
  unlink("rwsbrk");
    2176:	00004517          	auipc	a0,0x4
    217a:	0ba50513          	addi	a0,a0,186 # 6230 <statistics+0xce6>
    217e:	5cf020ef          	jal	4f4c <unlink>
  fd = open("README", O_RDONLY);
    2182:	4581                	li	a1,0
    2184:	00003517          	auipc	a0,0x3
    2188:	64c50513          	addi	a0,a0,1612 # 57d0 <statistics+0x286>
    218c:	5b1020ef          	jal	4f3c <open>
    2190:	892a                	mv	s2,a0
  if(fd < 0){
    2192:	02054363          	bltz	a0,21b8 <rwsbrk+0xe8>
  n = read(fd, (void*)(a+PGSIZE), 10);
    2196:	4629                	li	a2,10
    2198:	85a6                	mv	a1,s1
    219a:	57b020ef          	jal	4f14 <read>
    219e:	862a                	mv	a2,a0
  if(n >= 0){
    21a0:	02054563          	bltz	a0,21ca <rwsbrk+0xfa>
    printf("read(fd, %p, 10) returned %d, not -1\n", (void*)a+PGSIZE, n);
    21a4:	85a6                	mv	a1,s1
    21a6:	00004517          	auipc	a0,0x4
    21aa:	0da50513          	addi	a0,a0,218 # 6280 <statistics+0xd36>
    21ae:	1ee030ef          	jal	539c <printf>
    exit(1);
    21b2:	4505                	li	a0,1
    21b4:	549020ef          	jal	4efc <exit>
    printf("open(README) failed\n");
    21b8:	00003517          	auipc	a0,0x3
    21bc:	62050513          	addi	a0,a0,1568 # 57d8 <statistics+0x28e>
    21c0:	1dc030ef          	jal	539c <printf>
    exit(1);
    21c4:	4505                	li	a0,1
    21c6:	537020ef          	jal	4efc <exit>
  close(fd);
    21ca:	854a                	mv	a0,s2
    21cc:	559020ef          	jal	4f24 <close>
  exit(0);
    21d0:	4501                	li	a0,0
    21d2:	52b020ef          	jal	4efc <exit>

00000000000021d6 <sbrkbasic>:
{
    21d6:	715d                	addi	sp,sp,-80
    21d8:	e486                	sd	ra,72(sp)
    21da:	e0a2                	sd	s0,64(sp)
    21dc:	ec56                	sd	s5,24(sp)
    21de:	0880                	addi	s0,sp,80
    21e0:	8aaa                	mv	s5,a0
  pid = fork();
    21e2:	513020ef          	jal	4ef4 <fork>
  if(pid < 0){
    21e6:	02054c63          	bltz	a0,221e <sbrkbasic+0x48>
  if(pid == 0){
    21ea:	ed31                	bnez	a0,2246 <sbrkbasic+0x70>
    a = sbrk(TOOMUCH);
    21ec:	40000537          	lui	a0,0x40000
    21f0:	4d9020ef          	jal	4ec8 <sbrk>
    if(a == (char*)SBRK_ERROR){
    21f4:	57fd                	li	a5,-1
    21f6:	04f50163          	beq	a0,a5,2238 <sbrkbasic+0x62>
    21fa:	fc26                	sd	s1,56(sp)
    21fc:	f84a                	sd	s2,48(sp)
    21fe:	f44e                	sd	s3,40(sp)
    2200:	f052                	sd	s4,32(sp)
    for(b = a; b < a+TOOMUCH; b += PGSIZE){
    2202:	400007b7          	lui	a5,0x40000
    2206:	97aa                	add	a5,a5,a0
      *b = 99;
    2208:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += PGSIZE){
    220c:	6705                	lui	a4,0x1
      *b = 99;
    220e:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3fff1358>
    for(b = a; b < a+TOOMUCH; b += PGSIZE){
    2212:	953a                	add	a0,a0,a4
    2214:	fef51de3          	bne	a0,a5,220e <sbrkbasic+0x38>
    exit(1);
    2218:	4505                	li	a0,1
    221a:	4e3020ef          	jal	4efc <exit>
    221e:	fc26                	sd	s1,56(sp)
    2220:	f84a                	sd	s2,48(sp)
    2222:	f44e                	sd	s3,40(sp)
    2224:	f052                	sd	s4,32(sp)
    printf("fork failed in sbrkbasic\n");
    2226:	00004517          	auipc	a0,0x4
    222a:	08250513          	addi	a0,a0,130 # 62a8 <statistics+0xd5e>
    222e:	16e030ef          	jal	539c <printf>
    exit(1);
    2232:	4505                	li	a0,1
    2234:	4c9020ef          	jal	4efc <exit>
    2238:	fc26                	sd	s1,56(sp)
    223a:	f84a                	sd	s2,48(sp)
    223c:	f44e                	sd	s3,40(sp)
    223e:	f052                	sd	s4,32(sp)
      exit(0);
    2240:	4501                	li	a0,0
    2242:	4bb020ef          	jal	4efc <exit>
  wait(&xstatus);
    2246:	fbc40513          	addi	a0,s0,-68
    224a:	4bb020ef          	jal	4f04 <wait>
  if(xstatus == 1){
    224e:	fbc42703          	lw	a4,-68(s0)
    2252:	4785                	li	a5,1
    2254:	02f70063          	beq	a4,a5,2274 <sbrkbasic+0x9e>
    2258:	fc26                	sd	s1,56(sp)
    225a:	f84a                	sd	s2,48(sp)
    225c:	f44e                	sd	s3,40(sp)
    225e:	f052                	sd	s4,32(sp)
  a = sbrk(0);
    2260:	4501                	li	a0,0
    2262:	467020ef          	jal	4ec8 <sbrk>
    2266:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    2268:	4901                	li	s2,0
    b = sbrk(1);
    226a:	4985                	li	s3,1
  for(i = 0; i < 5000; i++){
    226c:	6a05                	lui	s4,0x1
    226e:	388a0a13          	addi	s4,s4,904 # 1388 <truncate3+0x14a>
    2272:	a005                	j	2292 <sbrkbasic+0xbc>
    2274:	fc26                	sd	s1,56(sp)
    2276:	f84a                	sd	s2,48(sp)
    2278:	f44e                	sd	s3,40(sp)
    227a:	f052                	sd	s4,32(sp)
    printf("%s: too much memory allocated!\n", s);
    227c:	85d6                	mv	a1,s5
    227e:	00004517          	auipc	a0,0x4
    2282:	04a50513          	addi	a0,a0,74 # 62c8 <statistics+0xd7e>
    2286:	116030ef          	jal	539c <printf>
    exit(1);
    228a:	4505                	li	a0,1
    228c:	471020ef          	jal	4efc <exit>
  for(i = 0; i < 5000; i++){
    2290:	84be                	mv	s1,a5
    b = sbrk(1);
    2292:	854e                	mv	a0,s3
    2294:	435020ef          	jal	4ec8 <sbrk>
    if(b != a){
    2298:	04951163          	bne	a0,s1,22da <sbrkbasic+0x104>
    *b = 1;
    229c:	01348023          	sb	s3,0(s1)
    a = b + 1;
    22a0:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    22a4:	2905                	addiw	s2,s2,1
    22a6:	ff4915e3          	bne	s2,s4,2290 <sbrkbasic+0xba>
  pid = fork();
    22aa:	44b020ef          	jal	4ef4 <fork>
    22ae:	892a                	mv	s2,a0
  if(pid < 0){
    22b0:	04054263          	bltz	a0,22f4 <sbrkbasic+0x11e>
  c = sbrk(1);
    22b4:	4505                	li	a0,1
    22b6:	413020ef          	jal	4ec8 <sbrk>
  c = sbrk(1);
    22ba:	4505                	li	a0,1
    22bc:	40d020ef          	jal	4ec8 <sbrk>
  if(c != a + 1){
    22c0:	0489                	addi	s1,s1,2
    22c2:	04950363          	beq	a0,s1,2308 <sbrkbasic+0x132>
    printf("%s: sbrk test failed post-fork\n", s);
    22c6:	85d6                	mv	a1,s5
    22c8:	00004517          	auipc	a0,0x4
    22cc:	06050513          	addi	a0,a0,96 # 6328 <statistics+0xdde>
    22d0:	0cc030ef          	jal	539c <printf>
    exit(1);
    22d4:	4505                	li	a0,1
    22d6:	427020ef          	jal	4efc <exit>
      printf("%s: sbrk test failed %d %p %p\n", s, i, a, b);
    22da:	872a                	mv	a4,a0
    22dc:	86a6                	mv	a3,s1
    22de:	864a                	mv	a2,s2
    22e0:	85d6                	mv	a1,s5
    22e2:	00004517          	auipc	a0,0x4
    22e6:	00650513          	addi	a0,a0,6 # 62e8 <statistics+0xd9e>
    22ea:	0b2030ef          	jal	539c <printf>
      exit(1);
    22ee:	4505                	li	a0,1
    22f0:	40d020ef          	jal	4efc <exit>
    printf("%s: sbrk test fork failed\n", s);
    22f4:	85d6                	mv	a1,s5
    22f6:	00004517          	auipc	a0,0x4
    22fa:	01250513          	addi	a0,a0,18 # 6308 <statistics+0xdbe>
    22fe:	09e030ef          	jal	539c <printf>
    exit(1);
    2302:	4505                	li	a0,1
    2304:	3f9020ef          	jal	4efc <exit>
  if(pid == 0)
    2308:	00091563          	bnez	s2,2312 <sbrkbasic+0x13c>
    exit(0);
    230c:	4501                	li	a0,0
    230e:	3ef020ef          	jal	4efc <exit>
  wait(&xstatus);
    2312:	fbc40513          	addi	a0,s0,-68
    2316:	3ef020ef          	jal	4f04 <wait>
  exit(xstatus);
    231a:	fbc42503          	lw	a0,-68(s0)
    231e:	3df020ef          	jal	4efc <exit>

0000000000002322 <sbrkmuch>:
{
    2322:	7179                	addi	sp,sp,-48
    2324:	f406                	sd	ra,40(sp)
    2326:	f022                	sd	s0,32(sp)
    2328:	ec26                	sd	s1,24(sp)
    232a:	e84a                	sd	s2,16(sp)
    232c:	e44e                	sd	s3,8(sp)
    232e:	e052                	sd	s4,0(sp)
    2330:	1800                	addi	s0,sp,48
    2332:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2334:	4501                	li	a0,0
    2336:	393020ef          	jal	4ec8 <sbrk>
    233a:	892a                	mv	s2,a0
  a = sbrk(0);
    233c:	4501                	li	a0,0
    233e:	38b020ef          	jal	4ec8 <sbrk>
    2342:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2344:	06400537          	lui	a0,0x6400
    2348:	9d05                	subw	a0,a0,s1
    234a:	37f020ef          	jal	4ec8 <sbrk>
  if (p != a) {
    234e:	08a49763          	bne	s1,a0,23dc <sbrkmuch+0xba>
  *lastaddr = 99;
    2352:	064007b7          	lui	a5,0x6400
    2356:	06300713          	li	a4,99
    235a:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63f1357>
  a = sbrk(0);
    235e:	4501                	li	a0,0
    2360:	369020ef          	jal	4ec8 <sbrk>
    2364:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2366:	757d                	lui	a0,0xfffff
    2368:	361020ef          	jal	4ec8 <sbrk>
  if(c == (char*)SBRK_ERROR){
    236c:	57fd                	li	a5,-1
    236e:	08f50163          	beq	a0,a5,23f0 <sbrkmuch+0xce>
  c = sbrk(0);
    2372:	4501                	li	a0,0
    2374:	355020ef          	jal	4ec8 <sbrk>
  if(c != a - PGSIZE){
    2378:	77fd                	lui	a5,0xfffff
    237a:	97a6                	add	a5,a5,s1
    237c:	08f51463          	bne	a0,a5,2404 <sbrkmuch+0xe2>
  a = sbrk(0);
    2380:	4501                	li	a0,0
    2382:	347020ef          	jal	4ec8 <sbrk>
    2386:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2388:	6505                	lui	a0,0x1
    238a:	33f020ef          	jal	4ec8 <sbrk>
    238e:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2390:	08a49663          	bne	s1,a0,241c <sbrkmuch+0xfa>
    2394:	4501                	li	a0,0
    2396:	333020ef          	jal	4ec8 <sbrk>
    239a:	6785                	lui	a5,0x1
    239c:	97a6                	add	a5,a5,s1
    239e:	06f51f63          	bne	a0,a5,241c <sbrkmuch+0xfa>
  if(*lastaddr == 99){
    23a2:	064007b7          	lui	a5,0x6400
    23a6:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63f1357>
    23aa:	06300793          	li	a5,99
    23ae:	08f70363          	beq	a4,a5,2434 <sbrkmuch+0x112>
  a = sbrk(0);
    23b2:	4501                	li	a0,0
    23b4:	315020ef          	jal	4ec8 <sbrk>
    23b8:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    23ba:	4501                	li	a0,0
    23bc:	30d020ef          	jal	4ec8 <sbrk>
    23c0:	40a9053b          	subw	a0,s2,a0
    23c4:	305020ef          	jal	4ec8 <sbrk>
  if(c != a){
    23c8:	08a49063          	bne	s1,a0,2448 <sbrkmuch+0x126>
}
    23cc:	70a2                	ld	ra,40(sp)
    23ce:	7402                	ld	s0,32(sp)
    23d0:	64e2                	ld	s1,24(sp)
    23d2:	6942                	ld	s2,16(sp)
    23d4:	69a2                	ld	s3,8(sp)
    23d6:	6a02                	ld	s4,0(sp)
    23d8:	6145                	addi	sp,sp,48
    23da:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    23dc:	85ce                	mv	a1,s3
    23de:	00004517          	auipc	a0,0x4
    23e2:	f6a50513          	addi	a0,a0,-150 # 6348 <statistics+0xdfe>
    23e6:	7b7020ef          	jal	539c <printf>
    exit(1);
    23ea:	4505                	li	a0,1
    23ec:	311020ef          	jal	4efc <exit>
    printf("%s: sbrk could not deallocate\n", s);
    23f0:	85ce                	mv	a1,s3
    23f2:	00004517          	auipc	a0,0x4
    23f6:	f9e50513          	addi	a0,a0,-98 # 6390 <statistics+0xe46>
    23fa:	7a3020ef          	jal	539c <printf>
    exit(1);
    23fe:	4505                	li	a0,1
    2400:	2fd020ef          	jal	4efc <exit>
    printf("%s: sbrk deallocation produced wrong address, a %p c %p\n", s, a, c);
    2404:	86aa                	mv	a3,a0
    2406:	8626                	mv	a2,s1
    2408:	85ce                	mv	a1,s3
    240a:	00004517          	auipc	a0,0x4
    240e:	fa650513          	addi	a0,a0,-90 # 63b0 <statistics+0xe66>
    2412:	78b020ef          	jal	539c <printf>
    exit(1);
    2416:	4505                	li	a0,1
    2418:	2e5020ef          	jal	4efc <exit>
    printf("%s: sbrk re-allocation failed, a %p c %p\n", s, a, c);
    241c:	86d2                	mv	a3,s4
    241e:	8626                	mv	a2,s1
    2420:	85ce                	mv	a1,s3
    2422:	00004517          	auipc	a0,0x4
    2426:	fce50513          	addi	a0,a0,-50 # 63f0 <statistics+0xea6>
    242a:	773020ef          	jal	539c <printf>
    exit(1);
    242e:	4505                	li	a0,1
    2430:	2cd020ef          	jal	4efc <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2434:	85ce                	mv	a1,s3
    2436:	00004517          	auipc	a0,0x4
    243a:	fea50513          	addi	a0,a0,-22 # 6420 <statistics+0xed6>
    243e:	75f020ef          	jal	539c <printf>
    exit(1);
    2442:	4505                	li	a0,1
    2444:	2b9020ef          	jal	4efc <exit>
    printf("%s: sbrk downsize failed, a %p c %p\n", s, a, c);
    2448:	86aa                	mv	a3,a0
    244a:	8626                	mv	a2,s1
    244c:	85ce                	mv	a1,s3
    244e:	00004517          	auipc	a0,0x4
    2452:	00a50513          	addi	a0,a0,10 # 6458 <statistics+0xf0e>
    2456:	747020ef          	jal	539c <printf>
    exit(1);
    245a:	4505                	li	a0,1
    245c:	2a1020ef          	jal	4efc <exit>

0000000000002460 <sbrkarg>:
{
    2460:	7179                	addi	sp,sp,-48
    2462:	f406                	sd	ra,40(sp)
    2464:	f022                	sd	s0,32(sp)
    2466:	ec26                	sd	s1,24(sp)
    2468:	e84a                	sd	s2,16(sp)
    246a:	e44e                	sd	s3,8(sp)
    246c:	1800                	addi	s0,sp,48
    246e:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2470:	6505                	lui	a0,0x1
    2472:	257020ef          	jal	4ec8 <sbrk>
    2476:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    2478:	20100593          	li	a1,513
    247c:	00004517          	auipc	a0,0x4
    2480:	00450513          	addi	a0,a0,4 # 6480 <statistics+0xf36>
    2484:	2b9020ef          	jal	4f3c <open>
    2488:	84aa                	mv	s1,a0
  unlink("sbrk");
    248a:	00004517          	auipc	a0,0x4
    248e:	ff650513          	addi	a0,a0,-10 # 6480 <statistics+0xf36>
    2492:	2bb020ef          	jal	4f4c <unlink>
  if(fd < 0)  {
    2496:	0204c963          	bltz	s1,24c8 <sbrkarg+0x68>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    249a:	6605                	lui	a2,0x1
    249c:	85ca                	mv	a1,s2
    249e:	8526                	mv	a0,s1
    24a0:	27d020ef          	jal	4f1c <write>
    24a4:	02054c63          	bltz	a0,24dc <sbrkarg+0x7c>
  close(fd);
    24a8:	8526                	mv	a0,s1
    24aa:	27b020ef          	jal	4f24 <close>
  a = sbrk(PGSIZE);
    24ae:	6505                	lui	a0,0x1
    24b0:	219020ef          	jal	4ec8 <sbrk>
  if(pipe((int *) a) != 0){
    24b4:	259020ef          	jal	4f0c <pipe>
    24b8:	ed05                	bnez	a0,24f0 <sbrkarg+0x90>
}
    24ba:	70a2                	ld	ra,40(sp)
    24bc:	7402                	ld	s0,32(sp)
    24be:	64e2                	ld	s1,24(sp)
    24c0:	6942                	ld	s2,16(sp)
    24c2:	69a2                	ld	s3,8(sp)
    24c4:	6145                	addi	sp,sp,48
    24c6:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    24c8:	85ce                	mv	a1,s3
    24ca:	00004517          	auipc	a0,0x4
    24ce:	fbe50513          	addi	a0,a0,-66 # 6488 <statistics+0xf3e>
    24d2:	6cb020ef          	jal	539c <printf>
    exit(1);
    24d6:	4505                	li	a0,1
    24d8:	225020ef          	jal	4efc <exit>
    printf("%s: write sbrk failed\n", s);
    24dc:	85ce                	mv	a1,s3
    24de:	00004517          	auipc	a0,0x4
    24e2:	fc250513          	addi	a0,a0,-62 # 64a0 <statistics+0xf56>
    24e6:	6b7020ef          	jal	539c <printf>
    exit(1);
    24ea:	4505                	li	a0,1
    24ec:	211020ef          	jal	4efc <exit>
    printf("%s: pipe() failed\n", s);
    24f0:	85ce                	mv	a1,s3
    24f2:	00004517          	auipc	a0,0x4
    24f6:	a9e50513          	addi	a0,a0,-1378 # 5f90 <statistics+0xa46>
    24fa:	6a3020ef          	jal	539c <printf>
    exit(1);
    24fe:	4505                	li	a0,1
    2500:	1fd020ef          	jal	4efc <exit>

0000000000002504 <argptest>:
{
    2504:	1101                	addi	sp,sp,-32
    2506:	ec06                	sd	ra,24(sp)
    2508:	e822                	sd	s0,16(sp)
    250a:	e426                	sd	s1,8(sp)
    250c:	e04a                	sd	s2,0(sp)
    250e:	1000                	addi	s0,sp,32
    2510:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2512:	4581                	li	a1,0
    2514:	00004517          	auipc	a0,0x4
    2518:	fa450513          	addi	a0,a0,-92 # 64b8 <statistics+0xf6e>
    251c:	221020ef          	jal	4f3c <open>
  if (fd < 0) {
    2520:	02054563          	bltz	a0,254a <argptest+0x46>
    2524:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2526:	4501                	li	a0,0
    2528:	1a1020ef          	jal	4ec8 <sbrk>
    252c:	567d                	li	a2,-1
    252e:	00c505b3          	add	a1,a0,a2
    2532:	8526                	mv	a0,s1
    2534:	1e1020ef          	jal	4f14 <read>
  close(fd);
    2538:	8526                	mv	a0,s1
    253a:	1eb020ef          	jal	4f24 <close>
}
    253e:	60e2                	ld	ra,24(sp)
    2540:	6442                	ld	s0,16(sp)
    2542:	64a2                	ld	s1,8(sp)
    2544:	6902                	ld	s2,0(sp)
    2546:	6105                	addi	sp,sp,32
    2548:	8082                	ret
    printf("%s: open failed\n", s);
    254a:	85ca                	mv	a1,s2
    254c:	00004517          	auipc	a0,0x4
    2550:	95450513          	addi	a0,a0,-1708 # 5ea0 <statistics+0x956>
    2554:	649020ef          	jal	539c <printf>
    exit(1);
    2558:	4505                	li	a0,1
    255a:	1a3020ef          	jal	4efc <exit>

000000000000255e <sbrkbugs>:
{
    255e:	1141                	addi	sp,sp,-16
    2560:	e406                	sd	ra,8(sp)
    2562:	e022                	sd	s0,0(sp)
    2564:	0800                	addi	s0,sp,16
  int pid = fork();
    2566:	18f020ef          	jal	4ef4 <fork>
  if(pid < 0){
    256a:	00054c63          	bltz	a0,2582 <sbrkbugs+0x24>
  if(pid == 0){
    256e:	e11d                	bnez	a0,2594 <sbrkbugs+0x36>
    int sz = (uint64) sbrk(0);
    2570:	159020ef          	jal	4ec8 <sbrk>
    sbrk(-sz);
    2574:	40a0053b          	negw	a0,a0
    2578:	151020ef          	jal	4ec8 <sbrk>
    exit(0);
    257c:	4501                	li	a0,0
    257e:	17f020ef          	jal	4efc <exit>
    printf("fork failed\n");
    2582:	00005517          	auipc	a0,0x5
    2586:	eae50513          	addi	a0,a0,-338 # 7430 <statistics+0x1ee6>
    258a:	613020ef          	jal	539c <printf>
    exit(1);
    258e:	4505                	li	a0,1
    2590:	16d020ef          	jal	4efc <exit>
  wait(0);
    2594:	4501                	li	a0,0
    2596:	16f020ef          	jal	4f04 <wait>
  pid = fork();
    259a:	15b020ef          	jal	4ef4 <fork>
  if(pid < 0){
    259e:	00054f63          	bltz	a0,25bc <sbrkbugs+0x5e>
  if(pid == 0){
    25a2:	e515                	bnez	a0,25ce <sbrkbugs+0x70>
    int sz = (uint64) sbrk(0);
    25a4:	125020ef          	jal	4ec8 <sbrk>
    sbrk(-(sz - 3500));
    25a8:	6785                	lui	a5,0x1
    25aa:	dac7879b          	addiw	a5,a5,-596 # dac <linktest+0xe2>
    25ae:	40a7853b          	subw	a0,a5,a0
    25b2:	117020ef          	jal	4ec8 <sbrk>
    exit(0);
    25b6:	4501                	li	a0,0
    25b8:	145020ef          	jal	4efc <exit>
    printf("fork failed\n");
    25bc:	00005517          	auipc	a0,0x5
    25c0:	e7450513          	addi	a0,a0,-396 # 7430 <statistics+0x1ee6>
    25c4:	5d9020ef          	jal	539c <printf>
    exit(1);
    25c8:	4505                	li	a0,1
    25ca:	133020ef          	jal	4efc <exit>
  wait(0);
    25ce:	4501                	li	a0,0
    25d0:	135020ef          	jal	4f04 <wait>
  pid = fork();
    25d4:	121020ef          	jal	4ef4 <fork>
  if(pid < 0){
    25d8:	02054263          	bltz	a0,25fc <sbrkbugs+0x9e>
  if(pid == 0){
    25dc:	e90d                	bnez	a0,260e <sbrkbugs+0xb0>
    sbrk((10*PGSIZE + 2048) - (uint64)sbrk(0));
    25de:	0eb020ef          	jal	4ec8 <sbrk>
    25e2:	67ad                	lui	a5,0xb
    25e4:	8007879b          	addiw	a5,a5,-2048 # a800 <uninit+0x1268>
    25e8:	40a7853b          	subw	a0,a5,a0
    25ec:	0dd020ef          	jal	4ec8 <sbrk>
    sbrk(-10);
    25f0:	5559                	li	a0,-10
    25f2:	0d7020ef          	jal	4ec8 <sbrk>
    exit(0);
    25f6:	4501                	li	a0,0
    25f8:	105020ef          	jal	4efc <exit>
    printf("fork failed\n");
    25fc:	00005517          	auipc	a0,0x5
    2600:	e3450513          	addi	a0,a0,-460 # 7430 <statistics+0x1ee6>
    2604:	599020ef          	jal	539c <printf>
    exit(1);
    2608:	4505                	li	a0,1
    260a:	0f3020ef          	jal	4efc <exit>
  wait(0);
    260e:	4501                	li	a0,0
    2610:	0f5020ef          	jal	4f04 <wait>
  exit(0);
    2614:	4501                	li	a0,0
    2616:	0e7020ef          	jal	4efc <exit>

000000000000261a <sbrklast>:
{
    261a:	7179                	addi	sp,sp,-48
    261c:	f406                	sd	ra,40(sp)
    261e:	f022                	sd	s0,32(sp)
    2620:	ec26                	sd	s1,24(sp)
    2622:	e84a                	sd	s2,16(sp)
    2624:	e44e                	sd	s3,8(sp)
    2626:	e052                	sd	s4,0(sp)
    2628:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    262a:	4501                	li	a0,0
    262c:	09d020ef          	jal	4ec8 <sbrk>
  if((top % PGSIZE) != 0)
    2630:	03451793          	slli	a5,a0,0x34
    2634:	ebad                	bnez	a5,26a6 <sbrklast+0x8c>
  sbrk(PGSIZE);
    2636:	6505                	lui	a0,0x1
    2638:	091020ef          	jal	4ec8 <sbrk>
  sbrk(10);
    263c:	4529                	li	a0,10
    263e:	08b020ef          	jal	4ec8 <sbrk>
  sbrk(-20);
    2642:	5531                	li	a0,-20
    2644:	085020ef          	jal	4ec8 <sbrk>
  top = (uint64) sbrk(0);
    2648:	4501                	li	a0,0
    264a:	07f020ef          	jal	4ec8 <sbrk>
    264e:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    2650:	fc050913          	addi	s2,a0,-64 # fc0 <bigdir+0xcc>
  p[0] = 'x';
    2654:	07800993          	li	s3,120
    2658:	fd350023          	sb	s3,-64(a0)
  p[1] = '\0';
    265c:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2660:	20200593          	li	a1,514
    2664:	854a                	mv	a0,s2
    2666:	0d7020ef          	jal	4f3c <open>
    266a:	8a2a                	mv	s4,a0
  write(fd, p, 1);
    266c:	4605                	li	a2,1
    266e:	85ca                	mv	a1,s2
    2670:	0ad020ef          	jal	4f1c <write>
  close(fd);
    2674:	8552                	mv	a0,s4
    2676:	0af020ef          	jal	4f24 <close>
  fd = open(p, O_RDWR);
    267a:	4589                	li	a1,2
    267c:	854a                	mv	a0,s2
    267e:	0bf020ef          	jal	4f3c <open>
  p[0] = '\0';
    2682:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2686:	4605                	li	a2,1
    2688:	85ca                	mv	a1,s2
    268a:	08b020ef          	jal	4f14 <read>
  if(p[0] != 'x')
    268e:	fc04c783          	lbu	a5,-64(s1)
    2692:	03379263          	bne	a5,s3,26b6 <sbrklast+0x9c>
}
    2696:	70a2                	ld	ra,40(sp)
    2698:	7402                	ld	s0,32(sp)
    269a:	64e2                	ld	s1,24(sp)
    269c:	6942                	ld	s2,16(sp)
    269e:	69a2                	ld	s3,8(sp)
    26a0:	6a02                	ld	s4,0(sp)
    26a2:	6145                	addi	sp,sp,48
    26a4:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    26a6:	0347d513          	srli	a0,a5,0x34
    26aa:	6785                	lui	a5,0x1
    26ac:	40a7853b          	subw	a0,a5,a0
    26b0:	019020ef          	jal	4ec8 <sbrk>
    26b4:	b749                	j	2636 <sbrklast+0x1c>
    exit(1);
    26b6:	4505                	li	a0,1
    26b8:	045020ef          	jal	4efc <exit>

00000000000026bc <sbrk8000>:
{
    26bc:	1141                	addi	sp,sp,-16
    26be:	e406                	sd	ra,8(sp)
    26c0:	e022                	sd	s0,0(sp)
    26c2:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    26c4:	80000537          	lui	a0,0x80000
    26c8:	0511                	addi	a0,a0,4 # ffffffff80000004 <base+0xffffffff7fff135c>
    26ca:	7fe020ef          	jal	4ec8 <sbrk>
  volatile char *top = sbrk(0);
    26ce:	4501                	li	a0,0
    26d0:	7f8020ef          	jal	4ec8 <sbrk>
  *(top-1) = *(top-1) + 1;
    26d4:	fff54783          	lbu	a5,-1(a0)
    26d8:	2785                	addiw	a5,a5,1 # 1001 <bigdir+0x10d>
    26da:	fef50fa3          	sb	a5,-1(a0)
}
    26de:	60a2                	ld	ra,8(sp)
    26e0:	6402                	ld	s0,0(sp)
    26e2:	0141                	addi	sp,sp,16
    26e4:	8082                	ret

00000000000026e6 <execout>:
{
    26e6:	711d                	addi	sp,sp,-96
    26e8:	ec86                	sd	ra,88(sp)
    26ea:	e8a2                	sd	s0,80(sp)
    26ec:	e4a6                	sd	s1,72(sp)
    26ee:	e0ca                	sd	s2,64(sp)
    26f0:	fc4e                	sd	s3,56(sp)
    26f2:	1080                	addi	s0,sp,96
  for(int avail = 0; avail < 15; avail++){
    26f4:	4901                	li	s2,0
    26f6:	49bd                	li	s3,15
    int pid = fork();
    26f8:	7fc020ef          	jal	4ef4 <fork>
    26fc:	84aa                	mv	s1,a0
    if(pid < 0){
    26fe:	00054e63          	bltz	a0,271a <execout+0x34>
    } else if(pid == 0){
    2702:	c51d                	beqz	a0,2730 <execout+0x4a>
      wait((int*)0);
    2704:	4501                	li	a0,0
    2706:	7fe020ef          	jal	4f04 <wait>
  for(int avail = 0; avail < 15; avail++){
    270a:	2905                	addiw	s2,s2,1
    270c:	ff3916e3          	bne	s2,s3,26f8 <execout+0x12>
    2710:	f852                	sd	s4,48(sp)
    2712:	f456                	sd	s5,40(sp)
  exit(0);
    2714:	4501                	li	a0,0
    2716:	7e6020ef          	jal	4efc <exit>
    271a:	f852                	sd	s4,48(sp)
    271c:	f456                	sd	s5,40(sp)
      printf("fork failed\n");
    271e:	00005517          	auipc	a0,0x5
    2722:	d1250513          	addi	a0,a0,-750 # 7430 <statistics+0x1ee6>
    2726:	477020ef          	jal	539c <printf>
      exit(1);
    272a:	4505                	li	a0,1
    272c:	7d0020ef          	jal	4efc <exit>
    2730:	f852                	sd	s4,48(sp)
    2732:	f456                	sd	s5,40(sp)
        char *a = sbrk(PGSIZE);
    2734:	6985                	lui	s3,0x1
        if(a == SBRK_ERROR)
    2736:	5a7d                	li	s4,-1
        *(a + PGSIZE - 1) = 1;
    2738:	4a85                	li	s5,1
        char *a = sbrk(PGSIZE);
    273a:	854e                	mv	a0,s3
    273c:	78c020ef          	jal	4ec8 <sbrk>
        if(a == SBRK_ERROR)
    2740:	01450663          	beq	a0,s4,274c <execout+0x66>
        *(a + PGSIZE - 1) = 1;
    2744:	954e                	add	a0,a0,s3
    2746:	ff550fa3          	sb	s5,-1(a0)
      while(1){
    274a:	bfc5                	j	273a <execout+0x54>
        sbrk(-PGSIZE);
    274c:	79fd                	lui	s3,0xfffff
      for(int i = 0; i < avail; i++)
    274e:	01205863          	blez	s2,275e <execout+0x78>
        sbrk(-PGSIZE);
    2752:	854e                	mv	a0,s3
    2754:	774020ef          	jal	4ec8 <sbrk>
      for(int i = 0; i < avail; i++)
    2758:	2485                	addiw	s1,s1,1
    275a:	ff249ce3          	bne	s1,s2,2752 <execout+0x6c>
      close(1);
    275e:	4505                	li	a0,1
    2760:	7c4020ef          	jal	4f24 <close>
      char *args[] = { "echo", "x", 0 };
    2764:	00003797          	auipc	a5,0x3
    2768:	e9478793          	addi	a5,a5,-364 # 55f8 <statistics+0xae>
    276c:	faf43423          	sd	a5,-88(s0)
    2770:	00003797          	auipc	a5,0x3
    2774:	ef878793          	addi	a5,a5,-264 # 5668 <statistics+0x11e>
    2778:	faf43823          	sd	a5,-80(s0)
    277c:	fa043c23          	sd	zero,-72(s0)
      exec("echo", args);
    2780:	fa840593          	addi	a1,s0,-88
    2784:	00003517          	auipc	a0,0x3
    2788:	e7450513          	addi	a0,a0,-396 # 55f8 <statistics+0xae>
    278c:	7a8020ef          	jal	4f34 <exec>
      exit(0);
    2790:	4501                	li	a0,0
    2792:	76a020ef          	jal	4efc <exit>

0000000000002796 <fourteen>:
{
    2796:	1101                	addi	sp,sp,-32
    2798:	ec06                	sd	ra,24(sp)
    279a:	e822                	sd	s0,16(sp)
    279c:	e426                	sd	s1,8(sp)
    279e:	1000                	addi	s0,sp,32
    27a0:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    27a2:	00004517          	auipc	a0,0x4
    27a6:	eee50513          	addi	a0,a0,-274 # 6690 <statistics+0x1146>
    27aa:	7ba020ef          	jal	4f64 <mkdir>
    27ae:	e555                	bnez	a0,285a <fourteen+0xc4>
  if(mkdir("12345678901234/123456789012345") != 0){
    27b0:	00004517          	auipc	a0,0x4
    27b4:	d3850513          	addi	a0,a0,-712 # 64e8 <statistics+0xf9e>
    27b8:	7ac020ef          	jal	4f64 <mkdir>
    27bc:	e94d                	bnez	a0,286e <fourteen+0xd8>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    27be:	20000593          	li	a1,512
    27c2:	00004517          	auipc	a0,0x4
    27c6:	d7e50513          	addi	a0,a0,-642 # 6540 <statistics+0xff6>
    27ca:	772020ef          	jal	4f3c <open>
  if(fd < 0){
    27ce:	0a054a63          	bltz	a0,2882 <fourteen+0xec>
  close(fd);
    27d2:	752020ef          	jal	4f24 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    27d6:	4581                	li	a1,0
    27d8:	00004517          	auipc	a0,0x4
    27dc:	de050513          	addi	a0,a0,-544 # 65b8 <statistics+0x106e>
    27e0:	75c020ef          	jal	4f3c <open>
  if(fd < 0){
    27e4:	0a054963          	bltz	a0,2896 <fourteen+0x100>
  close(fd);
    27e8:	73c020ef          	jal	4f24 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    27ec:	00004517          	auipc	a0,0x4
    27f0:	e3c50513          	addi	a0,a0,-452 # 6628 <statistics+0x10de>
    27f4:	770020ef          	jal	4f64 <mkdir>
    27f8:	c94d                	beqz	a0,28aa <fourteen+0x114>
  if(mkdir("123456789012345/12345678901234") == 0){
    27fa:	00004517          	auipc	a0,0x4
    27fe:	e8650513          	addi	a0,a0,-378 # 6680 <statistics+0x1136>
    2802:	762020ef          	jal	4f64 <mkdir>
    2806:	cd45                	beqz	a0,28be <fourteen+0x128>
  unlink("123456789012345/12345678901234");
    2808:	00004517          	auipc	a0,0x4
    280c:	e7850513          	addi	a0,a0,-392 # 6680 <statistics+0x1136>
    2810:	73c020ef          	jal	4f4c <unlink>
  unlink("12345678901234/12345678901234");
    2814:	00004517          	auipc	a0,0x4
    2818:	e1450513          	addi	a0,a0,-492 # 6628 <statistics+0x10de>
    281c:	730020ef          	jal	4f4c <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    2820:	00004517          	auipc	a0,0x4
    2824:	d9850513          	addi	a0,a0,-616 # 65b8 <statistics+0x106e>
    2828:	724020ef          	jal	4f4c <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    282c:	00004517          	auipc	a0,0x4
    2830:	d1450513          	addi	a0,a0,-748 # 6540 <statistics+0xff6>
    2834:	718020ef          	jal	4f4c <unlink>
  unlink("12345678901234/123456789012345");
    2838:	00004517          	auipc	a0,0x4
    283c:	cb050513          	addi	a0,a0,-848 # 64e8 <statistics+0xf9e>
    2840:	70c020ef          	jal	4f4c <unlink>
  unlink("12345678901234");
    2844:	00004517          	auipc	a0,0x4
    2848:	e4c50513          	addi	a0,a0,-436 # 6690 <statistics+0x1146>
    284c:	700020ef          	jal	4f4c <unlink>
}
    2850:	60e2                	ld	ra,24(sp)
    2852:	6442                	ld	s0,16(sp)
    2854:	64a2                	ld	s1,8(sp)
    2856:	6105                	addi	sp,sp,32
    2858:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    285a:	85a6                	mv	a1,s1
    285c:	00004517          	auipc	a0,0x4
    2860:	c6450513          	addi	a0,a0,-924 # 64c0 <statistics+0xf76>
    2864:	339020ef          	jal	539c <printf>
    exit(1);
    2868:	4505                	li	a0,1
    286a:	692020ef          	jal	4efc <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    286e:	85a6                	mv	a1,s1
    2870:	00004517          	auipc	a0,0x4
    2874:	c9850513          	addi	a0,a0,-872 # 6508 <statistics+0xfbe>
    2878:	325020ef          	jal	539c <printf>
    exit(1);
    287c:	4505                	li	a0,1
    287e:	67e020ef          	jal	4efc <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    2882:	85a6                	mv	a1,s1
    2884:	00004517          	auipc	a0,0x4
    2888:	cec50513          	addi	a0,a0,-788 # 6570 <statistics+0x1026>
    288c:	311020ef          	jal	539c <printf>
    exit(1);
    2890:	4505                	li	a0,1
    2892:	66a020ef          	jal	4efc <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    2896:	85a6                	mv	a1,s1
    2898:	00004517          	auipc	a0,0x4
    289c:	d5050513          	addi	a0,a0,-688 # 65e8 <statistics+0x109e>
    28a0:	2fd020ef          	jal	539c <printf>
    exit(1);
    28a4:	4505                	li	a0,1
    28a6:	656020ef          	jal	4efc <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    28aa:	85a6                	mv	a1,s1
    28ac:	00004517          	auipc	a0,0x4
    28b0:	d9c50513          	addi	a0,a0,-612 # 6648 <statistics+0x10fe>
    28b4:	2e9020ef          	jal	539c <printf>
    exit(1);
    28b8:	4505                	li	a0,1
    28ba:	642020ef          	jal	4efc <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    28be:	85a6                	mv	a1,s1
    28c0:	00004517          	auipc	a0,0x4
    28c4:	de050513          	addi	a0,a0,-544 # 66a0 <statistics+0x1156>
    28c8:	2d5020ef          	jal	539c <printf>
    exit(1);
    28cc:	4505                	li	a0,1
    28ce:	62e020ef          	jal	4efc <exit>

00000000000028d2 <diskfull>:
{
    28d2:	b6010113          	addi	sp,sp,-1184
    28d6:	48113c23          	sd	ra,1176(sp)
    28da:	48813823          	sd	s0,1168(sp)
    28de:	48913423          	sd	s1,1160(sp)
    28e2:	49213023          	sd	s2,1152(sp)
    28e6:	47313c23          	sd	s3,1144(sp)
    28ea:	47413823          	sd	s4,1136(sp)
    28ee:	47513423          	sd	s5,1128(sp)
    28f2:	47613023          	sd	s6,1120(sp)
    28f6:	45713c23          	sd	s7,1112(sp)
    28fa:	45813823          	sd	s8,1104(sp)
    28fe:	45913423          	sd	s9,1096(sp)
    2902:	45a13023          	sd	s10,1088(sp)
    2906:	43b13c23          	sd	s11,1080(sp)
    290a:	4a010413          	addi	s0,sp,1184
    290e:	b6a43423          	sd	a0,-1176(s0)
  unlink("diskfulldir");
    2912:	00004517          	auipc	a0,0x4
    2916:	dc650513          	addi	a0,a0,-570 # 66d8 <statistics+0x118e>
    291a:	632020ef          	jal	4f4c <unlink>
    291e:	03000a93          	li	s5,48
    name[0] = 'b';
    2922:	06200d13          	li	s10,98
    name[1] = 'i';
    2926:	06900c93          	li	s9,105
    name[2] = 'g';
    292a:	06700c13          	li	s8,103
    unlink(name);
    292e:	b7040b13          	addi	s6,s0,-1168
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    2932:	60200b93          	li	s7,1538
    if(fd < 0){
    2936:	10c00d93          	li	s11,268
      if(write(fd, buf, BSIZE) != BSIZE){
    293a:	b9040a13          	addi	s4,s0,-1136
    293e:	aa8d                	j	2ab0 <diskfull+0x1de>
      printf("%s: could not create file %s\n", s, name);
    2940:	b7040613          	addi	a2,s0,-1168
    2944:	b6843583          	ld	a1,-1176(s0)
    2948:	00004517          	auipc	a0,0x4
    294c:	da050513          	addi	a0,a0,-608 # 66e8 <statistics+0x119e>
    2950:	24d020ef          	jal	539c <printf>
      break;
    2954:	a039                	j	2962 <diskfull+0x90>
        close(fd);
    2956:	854e                	mv	a0,s3
    2958:	5cc020ef          	jal	4f24 <close>
    close(fd);
    295c:	854e                	mv	a0,s3
    295e:	5c6020ef          	jal	4f24 <close>
  for(int i = 0; i < nzz; i++){
    2962:	4481                	li	s1,0
    name[0] = 'z';
    2964:	07a00993          	li	s3,122
    unlink(name);
    2968:	b9040913          	addi	s2,s0,-1136
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    296c:	60200a13          	li	s4,1538
  for(int i = 0; i < nzz; i++){
    2970:	08000a93          	li	s5,128
    name[0] = 'z';
    2974:	b9340823          	sb	s3,-1136(s0)
    name[1] = 'z';
    2978:	b93408a3          	sb	s3,-1135(s0)
    name[2] = '0' + (i / 32);
    297c:	41f4d71b          	sraiw	a4,s1,0x1f
    2980:	01b7571b          	srliw	a4,a4,0x1b
    2984:	009707bb          	addw	a5,a4,s1
    2988:	4057d69b          	sraiw	a3,a5,0x5
    298c:	0306869b          	addiw	a3,a3,48
    2990:	b8d40923          	sb	a3,-1134(s0)
    name[3] = '0' + (i % 32);
    2994:	8bfd                	andi	a5,a5,31
    2996:	9f99                	subw	a5,a5,a4
    2998:	0307879b          	addiw	a5,a5,48
    299c:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    29a0:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    29a4:	854a                	mv	a0,s2
    29a6:	5a6020ef          	jal	4f4c <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    29aa:	85d2                	mv	a1,s4
    29ac:	854a                	mv	a0,s2
    29ae:	58e020ef          	jal	4f3c <open>
    if(fd < 0)
    29b2:	00054763          	bltz	a0,29c0 <diskfull+0xee>
    close(fd);
    29b6:	56e020ef          	jal	4f24 <close>
  for(int i = 0; i < nzz; i++){
    29ba:	2485                	addiw	s1,s1,1
    29bc:	fb549ce3          	bne	s1,s5,2974 <diskfull+0xa2>
  if(mkdir("diskfulldir") == 0)
    29c0:	00004517          	auipc	a0,0x4
    29c4:	d1850513          	addi	a0,a0,-744 # 66d8 <statistics+0x118e>
    29c8:	59c020ef          	jal	4f64 <mkdir>
    29cc:	12050363          	beqz	a0,2af2 <diskfull+0x220>
  unlink("diskfulldir");
    29d0:	00004517          	auipc	a0,0x4
    29d4:	d0850513          	addi	a0,a0,-760 # 66d8 <statistics+0x118e>
    29d8:	574020ef          	jal	4f4c <unlink>
  for(int i = 0; i < nzz; i++){
    29dc:	4481                	li	s1,0
    name[0] = 'z';
    29de:	07a00913          	li	s2,122
    unlink(name);
    29e2:	b9040a13          	addi	s4,s0,-1136
  for(int i = 0; i < nzz; i++){
    29e6:	08000993          	li	s3,128
    name[0] = 'z';
    29ea:	b9240823          	sb	s2,-1136(s0)
    name[1] = 'z';
    29ee:	b92408a3          	sb	s2,-1135(s0)
    name[2] = '0' + (i / 32);
    29f2:	41f4d71b          	sraiw	a4,s1,0x1f
    29f6:	01b7571b          	srliw	a4,a4,0x1b
    29fa:	009707bb          	addw	a5,a4,s1
    29fe:	4057d69b          	sraiw	a3,a5,0x5
    2a02:	0306869b          	addiw	a3,a3,48
    2a06:	b8d40923          	sb	a3,-1134(s0)
    name[3] = '0' + (i % 32);
    2a0a:	8bfd                	andi	a5,a5,31
    2a0c:	9f99                	subw	a5,a5,a4
    2a0e:	0307879b          	addiw	a5,a5,48
    2a12:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    2a16:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    2a1a:	8552                	mv	a0,s4
    2a1c:	530020ef          	jal	4f4c <unlink>
  for(int i = 0; i < nzz; i++){
    2a20:	2485                	addiw	s1,s1,1
    2a22:	fd3494e3          	bne	s1,s3,29ea <diskfull+0x118>
    2a26:	03000493          	li	s1,48
    name[0] = 'b';
    2a2a:	06200b13          	li	s6,98
    name[1] = 'i';
    2a2e:	06900a93          	li	s5,105
    name[2] = 'g';
    2a32:	06700a13          	li	s4,103
    unlink(name);
    2a36:	b9040993          	addi	s3,s0,-1136
  for(int i = 0; '0' + i < 0177; i++){
    2a3a:	07f00913          	li	s2,127
    name[0] = 'b';
    2a3e:	b9640823          	sb	s6,-1136(s0)
    name[1] = 'i';
    2a42:	b95408a3          	sb	s5,-1135(s0)
    name[2] = 'g';
    2a46:	b9440923          	sb	s4,-1134(s0)
    name[3] = '0' + i;
    2a4a:	b89409a3          	sb	s1,-1133(s0)
    name[4] = '\0';
    2a4e:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    2a52:	854e                	mv	a0,s3
    2a54:	4f8020ef          	jal	4f4c <unlink>
  for(int i = 0; '0' + i < 0177; i++){
    2a58:	2485                	addiw	s1,s1,1
    2a5a:	0ff4f493          	zext.b	s1,s1
    2a5e:	ff2490e3          	bne	s1,s2,2a3e <diskfull+0x16c>
}
    2a62:	49813083          	ld	ra,1176(sp)
    2a66:	49013403          	ld	s0,1168(sp)
    2a6a:	48813483          	ld	s1,1160(sp)
    2a6e:	48013903          	ld	s2,1152(sp)
    2a72:	47813983          	ld	s3,1144(sp)
    2a76:	47013a03          	ld	s4,1136(sp)
    2a7a:	46813a83          	ld	s5,1128(sp)
    2a7e:	46013b03          	ld	s6,1120(sp)
    2a82:	45813b83          	ld	s7,1112(sp)
    2a86:	45013c03          	ld	s8,1104(sp)
    2a8a:	44813c83          	ld	s9,1096(sp)
    2a8e:	44013d03          	ld	s10,1088(sp)
    2a92:	43813d83          	ld	s11,1080(sp)
    2a96:	4a010113          	addi	sp,sp,1184
    2a9a:	8082                	ret
    close(fd);
    2a9c:	854e                	mv	a0,s3
    2a9e:	486020ef          	jal	4f24 <close>
  for(fi = 0; done == 0 && '0' + fi < 0177; fi++){
    2aa2:	2a85                	addiw	s5,s5,1 # 3001 <subdir+0x305>
    2aa4:	0ffafa93          	zext.b	s5,s5
    2aa8:	07f00793          	li	a5,127
    2aac:	eafa8be3          	beq	s5,a5,2962 <diskfull+0x90>
    name[0] = 'b';
    2ab0:	b7a40823          	sb	s10,-1168(s0)
    name[1] = 'i';
    2ab4:	b79408a3          	sb	s9,-1167(s0)
    name[2] = 'g';
    2ab8:	b7840923          	sb	s8,-1166(s0)
    name[3] = '0' + fi;
    2abc:	b75409a3          	sb	s5,-1165(s0)
    name[4] = '\0';
    2ac0:	b6040a23          	sb	zero,-1164(s0)
    unlink(name);
    2ac4:	855a                	mv	a0,s6
    2ac6:	486020ef          	jal	4f4c <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    2aca:	85de                	mv	a1,s7
    2acc:	855a                	mv	a0,s6
    2ace:	46e020ef          	jal	4f3c <open>
    2ad2:	89aa                	mv	s3,a0
    if(fd < 0){
    2ad4:	e60546e3          	bltz	a0,2940 <diskfull+0x6e>
    2ad8:	84ee                	mv	s1,s11
      if(write(fd, buf, BSIZE) != BSIZE){
    2ada:	40000913          	li	s2,1024
    2ade:	864a                	mv	a2,s2
    2ae0:	85d2                	mv	a1,s4
    2ae2:	854e                	mv	a0,s3
    2ae4:	438020ef          	jal	4f1c <write>
    2ae8:	e72517e3          	bne	a0,s2,2956 <diskfull+0x84>
    for(int i = 0; i < MAXFILE; i++){
    2aec:	34fd                	addiw	s1,s1,-1
    2aee:	f8e5                	bnez	s1,2ade <diskfull+0x20c>
    2af0:	b775                	j	2a9c <diskfull+0x1ca>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n", s);
    2af2:	b6843583          	ld	a1,-1176(s0)
    2af6:	00004517          	auipc	a0,0x4
    2afa:	c1250513          	addi	a0,a0,-1006 # 6708 <statistics+0x11be>
    2afe:	09f020ef          	jal	539c <printf>
    2b02:	b5f9                	j	29d0 <diskfull+0xfe>

0000000000002b04 <iputtest>:
{
    2b04:	1101                	addi	sp,sp,-32
    2b06:	ec06                	sd	ra,24(sp)
    2b08:	e822                	sd	s0,16(sp)
    2b0a:	e426                	sd	s1,8(sp)
    2b0c:	1000                	addi	s0,sp,32
    2b0e:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    2b10:	00004517          	auipc	a0,0x4
    2b14:	c2850513          	addi	a0,a0,-984 # 6738 <statistics+0x11ee>
    2b18:	44c020ef          	jal	4f64 <mkdir>
    2b1c:	02054f63          	bltz	a0,2b5a <iputtest+0x56>
  if(chdir("iputdir") < 0){
    2b20:	00004517          	auipc	a0,0x4
    2b24:	c1850513          	addi	a0,a0,-1000 # 6738 <statistics+0x11ee>
    2b28:	444020ef          	jal	4f6c <chdir>
    2b2c:	04054163          	bltz	a0,2b6e <iputtest+0x6a>
  if(unlink("../iputdir") < 0){
    2b30:	00004517          	auipc	a0,0x4
    2b34:	c4850513          	addi	a0,a0,-952 # 6778 <statistics+0x122e>
    2b38:	414020ef          	jal	4f4c <unlink>
    2b3c:	04054363          	bltz	a0,2b82 <iputtest+0x7e>
  if(chdir("/") < 0){
    2b40:	00004517          	auipc	a0,0x4
    2b44:	c6850513          	addi	a0,a0,-920 # 67a8 <statistics+0x125e>
    2b48:	424020ef          	jal	4f6c <chdir>
    2b4c:	04054563          	bltz	a0,2b96 <iputtest+0x92>
}
    2b50:	60e2                	ld	ra,24(sp)
    2b52:	6442                	ld	s0,16(sp)
    2b54:	64a2                	ld	s1,8(sp)
    2b56:	6105                	addi	sp,sp,32
    2b58:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2b5a:	85a6                	mv	a1,s1
    2b5c:	00004517          	auipc	a0,0x4
    2b60:	be450513          	addi	a0,a0,-1052 # 6740 <statistics+0x11f6>
    2b64:	039020ef          	jal	539c <printf>
    exit(1);
    2b68:	4505                	li	a0,1
    2b6a:	392020ef          	jal	4efc <exit>
    printf("%s: chdir iputdir failed\n", s);
    2b6e:	85a6                	mv	a1,s1
    2b70:	00004517          	auipc	a0,0x4
    2b74:	be850513          	addi	a0,a0,-1048 # 6758 <statistics+0x120e>
    2b78:	025020ef          	jal	539c <printf>
    exit(1);
    2b7c:	4505                	li	a0,1
    2b7e:	37e020ef          	jal	4efc <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    2b82:	85a6                	mv	a1,s1
    2b84:	00004517          	auipc	a0,0x4
    2b88:	c0450513          	addi	a0,a0,-1020 # 6788 <statistics+0x123e>
    2b8c:	011020ef          	jal	539c <printf>
    exit(1);
    2b90:	4505                	li	a0,1
    2b92:	36a020ef          	jal	4efc <exit>
    printf("%s: chdir / failed\n", s);
    2b96:	85a6                	mv	a1,s1
    2b98:	00004517          	auipc	a0,0x4
    2b9c:	c1850513          	addi	a0,a0,-1000 # 67b0 <statistics+0x1266>
    2ba0:	7fc020ef          	jal	539c <printf>
    exit(1);
    2ba4:	4505                	li	a0,1
    2ba6:	356020ef          	jal	4efc <exit>

0000000000002baa <exitiputtest>:
{
    2baa:	7179                	addi	sp,sp,-48
    2bac:	f406                	sd	ra,40(sp)
    2bae:	f022                	sd	s0,32(sp)
    2bb0:	ec26                	sd	s1,24(sp)
    2bb2:	1800                	addi	s0,sp,48
    2bb4:	84aa                	mv	s1,a0
  pid = fork();
    2bb6:	33e020ef          	jal	4ef4 <fork>
  if(pid < 0){
    2bba:	02054e63          	bltz	a0,2bf6 <exitiputtest+0x4c>
  if(pid == 0){
    2bbe:	e541                	bnez	a0,2c46 <exitiputtest+0x9c>
    if(mkdir("iputdir") < 0){
    2bc0:	00004517          	auipc	a0,0x4
    2bc4:	b7850513          	addi	a0,a0,-1160 # 6738 <statistics+0x11ee>
    2bc8:	39c020ef          	jal	4f64 <mkdir>
    2bcc:	02054f63          	bltz	a0,2c0a <exitiputtest+0x60>
    if(chdir("iputdir") < 0){
    2bd0:	00004517          	auipc	a0,0x4
    2bd4:	b6850513          	addi	a0,a0,-1176 # 6738 <statistics+0x11ee>
    2bd8:	394020ef          	jal	4f6c <chdir>
    2bdc:	04054163          	bltz	a0,2c1e <exitiputtest+0x74>
    if(unlink("../iputdir") < 0){
    2be0:	00004517          	auipc	a0,0x4
    2be4:	b9850513          	addi	a0,a0,-1128 # 6778 <statistics+0x122e>
    2be8:	364020ef          	jal	4f4c <unlink>
    2bec:	04054363          	bltz	a0,2c32 <exitiputtest+0x88>
    exit(0);
    2bf0:	4501                	li	a0,0
    2bf2:	30a020ef          	jal	4efc <exit>
    printf("%s: fork failed\n", s);
    2bf6:	85a6                	mv	a1,s1
    2bf8:	00003517          	auipc	a0,0x3
    2bfc:	29050513          	addi	a0,a0,656 # 5e88 <statistics+0x93e>
    2c00:	79c020ef          	jal	539c <printf>
    exit(1);
    2c04:	4505                	li	a0,1
    2c06:	2f6020ef          	jal	4efc <exit>
      printf("%s: mkdir failed\n", s);
    2c0a:	85a6                	mv	a1,s1
    2c0c:	00004517          	auipc	a0,0x4
    2c10:	b3450513          	addi	a0,a0,-1228 # 6740 <statistics+0x11f6>
    2c14:	788020ef          	jal	539c <printf>
      exit(1);
    2c18:	4505                	li	a0,1
    2c1a:	2e2020ef          	jal	4efc <exit>
      printf("%s: child chdir failed\n", s);
    2c1e:	85a6                	mv	a1,s1
    2c20:	00004517          	auipc	a0,0x4
    2c24:	ba850513          	addi	a0,a0,-1112 # 67c8 <statistics+0x127e>
    2c28:	774020ef          	jal	539c <printf>
      exit(1);
    2c2c:	4505                	li	a0,1
    2c2e:	2ce020ef          	jal	4efc <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    2c32:	85a6                	mv	a1,s1
    2c34:	00004517          	auipc	a0,0x4
    2c38:	b5450513          	addi	a0,a0,-1196 # 6788 <statistics+0x123e>
    2c3c:	760020ef          	jal	539c <printf>
      exit(1);
    2c40:	4505                	li	a0,1
    2c42:	2ba020ef          	jal	4efc <exit>
  wait(&xstatus);
    2c46:	fdc40513          	addi	a0,s0,-36
    2c4a:	2ba020ef          	jal	4f04 <wait>
  exit(xstatus);
    2c4e:	fdc42503          	lw	a0,-36(s0)
    2c52:	2aa020ef          	jal	4efc <exit>

0000000000002c56 <dirtest>:
{
    2c56:	1101                	addi	sp,sp,-32
    2c58:	ec06                	sd	ra,24(sp)
    2c5a:	e822                	sd	s0,16(sp)
    2c5c:	e426                	sd	s1,8(sp)
    2c5e:	1000                	addi	s0,sp,32
    2c60:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    2c62:	00004517          	auipc	a0,0x4
    2c66:	b7e50513          	addi	a0,a0,-1154 # 67e0 <statistics+0x1296>
    2c6a:	2fa020ef          	jal	4f64 <mkdir>
    2c6e:	02054f63          	bltz	a0,2cac <dirtest+0x56>
  if(chdir("dir0") < 0){
    2c72:	00004517          	auipc	a0,0x4
    2c76:	b6e50513          	addi	a0,a0,-1170 # 67e0 <statistics+0x1296>
    2c7a:	2f2020ef          	jal	4f6c <chdir>
    2c7e:	04054163          	bltz	a0,2cc0 <dirtest+0x6a>
  if(chdir("..") < 0){
    2c82:	00004517          	auipc	a0,0x4
    2c86:	b7e50513          	addi	a0,a0,-1154 # 6800 <statistics+0x12b6>
    2c8a:	2e2020ef          	jal	4f6c <chdir>
    2c8e:	04054363          	bltz	a0,2cd4 <dirtest+0x7e>
  if(unlink("dir0") < 0){
    2c92:	00004517          	auipc	a0,0x4
    2c96:	b4e50513          	addi	a0,a0,-1202 # 67e0 <statistics+0x1296>
    2c9a:	2b2020ef          	jal	4f4c <unlink>
    2c9e:	04054563          	bltz	a0,2ce8 <dirtest+0x92>
}
    2ca2:	60e2                	ld	ra,24(sp)
    2ca4:	6442                	ld	s0,16(sp)
    2ca6:	64a2                	ld	s1,8(sp)
    2ca8:	6105                	addi	sp,sp,32
    2caa:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2cac:	85a6                	mv	a1,s1
    2cae:	00004517          	auipc	a0,0x4
    2cb2:	a9250513          	addi	a0,a0,-1390 # 6740 <statistics+0x11f6>
    2cb6:	6e6020ef          	jal	539c <printf>
    exit(1);
    2cba:	4505                	li	a0,1
    2cbc:	240020ef          	jal	4efc <exit>
    printf("%s: chdir dir0 failed\n", s);
    2cc0:	85a6                	mv	a1,s1
    2cc2:	00004517          	auipc	a0,0x4
    2cc6:	b2650513          	addi	a0,a0,-1242 # 67e8 <statistics+0x129e>
    2cca:	6d2020ef          	jal	539c <printf>
    exit(1);
    2cce:	4505                	li	a0,1
    2cd0:	22c020ef          	jal	4efc <exit>
    printf("%s: chdir .. failed\n", s);
    2cd4:	85a6                	mv	a1,s1
    2cd6:	00004517          	auipc	a0,0x4
    2cda:	b3250513          	addi	a0,a0,-1230 # 6808 <statistics+0x12be>
    2cde:	6be020ef          	jal	539c <printf>
    exit(1);
    2ce2:	4505                	li	a0,1
    2ce4:	218020ef          	jal	4efc <exit>
    printf("%s: unlink dir0 failed\n", s);
    2ce8:	85a6                	mv	a1,s1
    2cea:	00004517          	auipc	a0,0x4
    2cee:	b3650513          	addi	a0,a0,-1226 # 6820 <statistics+0x12d6>
    2cf2:	6aa020ef          	jal	539c <printf>
    exit(1);
    2cf6:	4505                	li	a0,1
    2cf8:	204020ef          	jal	4efc <exit>

0000000000002cfc <subdir>:
{
    2cfc:	1101                	addi	sp,sp,-32
    2cfe:	ec06                	sd	ra,24(sp)
    2d00:	e822                	sd	s0,16(sp)
    2d02:	e426                	sd	s1,8(sp)
    2d04:	e04a                	sd	s2,0(sp)
    2d06:	1000                	addi	s0,sp,32
    2d08:	892a                	mv	s2,a0
  unlink("ff");
    2d0a:	00004517          	auipc	a0,0x4
    2d0e:	c5e50513          	addi	a0,a0,-930 # 6968 <statistics+0x141e>
    2d12:	23a020ef          	jal	4f4c <unlink>
  if(mkdir("dd") != 0){
    2d16:	00004517          	auipc	a0,0x4
    2d1a:	b2250513          	addi	a0,a0,-1246 # 6838 <statistics+0x12ee>
    2d1e:	246020ef          	jal	4f64 <mkdir>
    2d22:	2e051263          	bnez	a0,3006 <subdir+0x30a>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    2d26:	20200593          	li	a1,514
    2d2a:	00004517          	auipc	a0,0x4
    2d2e:	b2e50513          	addi	a0,a0,-1234 # 6858 <statistics+0x130e>
    2d32:	20a020ef          	jal	4f3c <open>
    2d36:	84aa                	mv	s1,a0
  if(fd < 0){
    2d38:	2e054163          	bltz	a0,301a <subdir+0x31e>
  write(fd, "ff", 2);
    2d3c:	4609                	li	a2,2
    2d3e:	00004597          	auipc	a1,0x4
    2d42:	c2a58593          	addi	a1,a1,-982 # 6968 <statistics+0x141e>
    2d46:	1d6020ef          	jal	4f1c <write>
  close(fd);
    2d4a:	8526                	mv	a0,s1
    2d4c:	1d8020ef          	jal	4f24 <close>
  if(unlink("dd") >= 0){
    2d50:	00004517          	auipc	a0,0x4
    2d54:	ae850513          	addi	a0,a0,-1304 # 6838 <statistics+0x12ee>
    2d58:	1f4020ef          	jal	4f4c <unlink>
    2d5c:	2c055963          	bgez	a0,302e <subdir+0x332>
  if(mkdir("/dd/dd") != 0){
    2d60:	00004517          	auipc	a0,0x4
    2d64:	b5050513          	addi	a0,a0,-1200 # 68b0 <statistics+0x1366>
    2d68:	1fc020ef          	jal	4f64 <mkdir>
    2d6c:	2c051b63          	bnez	a0,3042 <subdir+0x346>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2d70:	20200593          	li	a1,514
    2d74:	00004517          	auipc	a0,0x4
    2d78:	b6450513          	addi	a0,a0,-1180 # 68d8 <statistics+0x138e>
    2d7c:	1c0020ef          	jal	4f3c <open>
    2d80:	84aa                	mv	s1,a0
  if(fd < 0){
    2d82:	2c054a63          	bltz	a0,3056 <subdir+0x35a>
  write(fd, "FF", 2);
    2d86:	4609                	li	a2,2
    2d88:	00004597          	auipc	a1,0x4
    2d8c:	b8058593          	addi	a1,a1,-1152 # 6908 <statistics+0x13be>
    2d90:	18c020ef          	jal	4f1c <write>
  close(fd);
    2d94:	8526                	mv	a0,s1
    2d96:	18e020ef          	jal	4f24 <close>
  fd = open("dd/dd/../ff", 0);
    2d9a:	4581                	li	a1,0
    2d9c:	00004517          	auipc	a0,0x4
    2da0:	b7450513          	addi	a0,a0,-1164 # 6910 <statistics+0x13c6>
    2da4:	198020ef          	jal	4f3c <open>
    2da8:	84aa                	mv	s1,a0
  if(fd < 0){
    2daa:	2c054063          	bltz	a0,306a <subdir+0x36e>
  cc = read(fd, buf, sizeof(buf));
    2dae:	660d                	lui	a2,0x3
    2db0:	00009597          	auipc	a1,0x9
    2db4:	ef858593          	addi	a1,a1,-264 # bca8 <buf>
    2db8:	15c020ef          	jal	4f14 <read>
  if(cc != 2 || buf[0] != 'f'){
    2dbc:	4789                	li	a5,2
    2dbe:	2cf51063          	bne	a0,a5,307e <subdir+0x382>
    2dc2:	00009717          	auipc	a4,0x9
    2dc6:	ee674703          	lbu	a4,-282(a4) # bca8 <buf>
    2dca:	06600793          	li	a5,102
    2dce:	2af71863          	bne	a4,a5,307e <subdir+0x382>
  close(fd);
    2dd2:	8526                	mv	a0,s1
    2dd4:	150020ef          	jal	4f24 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    2dd8:	00004597          	auipc	a1,0x4
    2ddc:	b8858593          	addi	a1,a1,-1144 # 6960 <statistics+0x1416>
    2de0:	00004517          	auipc	a0,0x4
    2de4:	af850513          	addi	a0,a0,-1288 # 68d8 <statistics+0x138e>
    2de8:	174020ef          	jal	4f5c <link>
    2dec:	2a051363          	bnez	a0,3092 <subdir+0x396>
  if(unlink("dd/dd/ff") != 0){
    2df0:	00004517          	auipc	a0,0x4
    2df4:	ae850513          	addi	a0,a0,-1304 # 68d8 <statistics+0x138e>
    2df8:	154020ef          	jal	4f4c <unlink>
    2dfc:	2a051563          	bnez	a0,30a6 <subdir+0x3aa>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2e00:	4581                	li	a1,0
    2e02:	00004517          	auipc	a0,0x4
    2e06:	ad650513          	addi	a0,a0,-1322 # 68d8 <statistics+0x138e>
    2e0a:	132020ef          	jal	4f3c <open>
    2e0e:	2a055663          	bgez	a0,30ba <subdir+0x3be>
  if(chdir("dd") != 0){
    2e12:	00004517          	auipc	a0,0x4
    2e16:	a2650513          	addi	a0,a0,-1498 # 6838 <statistics+0x12ee>
    2e1a:	152020ef          	jal	4f6c <chdir>
    2e1e:	2a051863          	bnez	a0,30ce <subdir+0x3d2>
  if(chdir("dd/../../dd") != 0){
    2e22:	00004517          	auipc	a0,0x4
    2e26:	bd650513          	addi	a0,a0,-1066 # 69f8 <statistics+0x14ae>
    2e2a:	142020ef          	jal	4f6c <chdir>
    2e2e:	2a051a63          	bnez	a0,30e2 <subdir+0x3e6>
  if(chdir("dd/../../../dd") != 0){
    2e32:	00004517          	auipc	a0,0x4
    2e36:	bf650513          	addi	a0,a0,-1034 # 6a28 <statistics+0x14de>
    2e3a:	132020ef          	jal	4f6c <chdir>
    2e3e:	2a051c63          	bnez	a0,30f6 <subdir+0x3fa>
  if(chdir("./..") != 0){
    2e42:	00004517          	auipc	a0,0x4
    2e46:	c1e50513          	addi	a0,a0,-994 # 6a60 <statistics+0x1516>
    2e4a:	122020ef          	jal	4f6c <chdir>
    2e4e:	2a051e63          	bnez	a0,310a <subdir+0x40e>
  fd = open("dd/dd/ffff", 0);
    2e52:	4581                	li	a1,0
    2e54:	00004517          	auipc	a0,0x4
    2e58:	b0c50513          	addi	a0,a0,-1268 # 6960 <statistics+0x1416>
    2e5c:	0e0020ef          	jal	4f3c <open>
    2e60:	84aa                	mv	s1,a0
  if(fd < 0){
    2e62:	2a054e63          	bltz	a0,311e <subdir+0x422>
  if(read(fd, buf, sizeof(buf)) != 2){
    2e66:	660d                	lui	a2,0x3
    2e68:	00009597          	auipc	a1,0x9
    2e6c:	e4058593          	addi	a1,a1,-448 # bca8 <buf>
    2e70:	0a4020ef          	jal	4f14 <read>
    2e74:	4789                	li	a5,2
    2e76:	2af51e63          	bne	a0,a5,3132 <subdir+0x436>
  close(fd);
    2e7a:	8526                	mv	a0,s1
    2e7c:	0a8020ef          	jal	4f24 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2e80:	4581                	li	a1,0
    2e82:	00004517          	auipc	a0,0x4
    2e86:	a5650513          	addi	a0,a0,-1450 # 68d8 <statistics+0x138e>
    2e8a:	0b2020ef          	jal	4f3c <open>
    2e8e:	2a055c63          	bgez	a0,3146 <subdir+0x44a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2e92:	20200593          	li	a1,514
    2e96:	00004517          	auipc	a0,0x4
    2e9a:	c5a50513          	addi	a0,a0,-934 # 6af0 <statistics+0x15a6>
    2e9e:	09e020ef          	jal	4f3c <open>
    2ea2:	2a055c63          	bgez	a0,315a <subdir+0x45e>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    2ea6:	20200593          	li	a1,514
    2eaa:	00004517          	auipc	a0,0x4
    2eae:	c7650513          	addi	a0,a0,-906 # 6b20 <statistics+0x15d6>
    2eb2:	08a020ef          	jal	4f3c <open>
    2eb6:	2a055c63          	bgez	a0,316e <subdir+0x472>
  if(open("dd", O_CREATE) >= 0){
    2eba:	20000593          	li	a1,512
    2ebe:	00004517          	auipc	a0,0x4
    2ec2:	97a50513          	addi	a0,a0,-1670 # 6838 <statistics+0x12ee>
    2ec6:	076020ef          	jal	4f3c <open>
    2eca:	2a055c63          	bgez	a0,3182 <subdir+0x486>
  if(open("dd", O_RDWR) >= 0){
    2ece:	4589                	li	a1,2
    2ed0:	00004517          	auipc	a0,0x4
    2ed4:	96850513          	addi	a0,a0,-1688 # 6838 <statistics+0x12ee>
    2ed8:	064020ef          	jal	4f3c <open>
    2edc:	2a055d63          	bgez	a0,3196 <subdir+0x49a>
  if(open("dd", O_WRONLY) >= 0){
    2ee0:	4585                	li	a1,1
    2ee2:	00004517          	auipc	a0,0x4
    2ee6:	95650513          	addi	a0,a0,-1706 # 6838 <statistics+0x12ee>
    2eea:	052020ef          	jal	4f3c <open>
    2eee:	2a055e63          	bgez	a0,31aa <subdir+0x4ae>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2ef2:	00004597          	auipc	a1,0x4
    2ef6:	cbe58593          	addi	a1,a1,-834 # 6bb0 <statistics+0x1666>
    2efa:	00004517          	auipc	a0,0x4
    2efe:	bf650513          	addi	a0,a0,-1034 # 6af0 <statistics+0x15a6>
    2f02:	05a020ef          	jal	4f5c <link>
    2f06:	2a050c63          	beqz	a0,31be <subdir+0x4c2>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2f0a:	00004597          	auipc	a1,0x4
    2f0e:	ca658593          	addi	a1,a1,-858 # 6bb0 <statistics+0x1666>
    2f12:	00004517          	auipc	a0,0x4
    2f16:	c0e50513          	addi	a0,a0,-1010 # 6b20 <statistics+0x15d6>
    2f1a:	042020ef          	jal	4f5c <link>
    2f1e:	2a050a63          	beqz	a0,31d2 <subdir+0x4d6>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2f22:	00004597          	auipc	a1,0x4
    2f26:	a3e58593          	addi	a1,a1,-1474 # 6960 <statistics+0x1416>
    2f2a:	00004517          	auipc	a0,0x4
    2f2e:	92e50513          	addi	a0,a0,-1746 # 6858 <statistics+0x130e>
    2f32:	02a020ef          	jal	4f5c <link>
    2f36:	2a050863          	beqz	a0,31e6 <subdir+0x4ea>
  if(mkdir("dd/ff/ff") == 0){
    2f3a:	00004517          	auipc	a0,0x4
    2f3e:	bb650513          	addi	a0,a0,-1098 # 6af0 <statistics+0x15a6>
    2f42:	022020ef          	jal	4f64 <mkdir>
    2f46:	2a050a63          	beqz	a0,31fa <subdir+0x4fe>
  if(mkdir("dd/xx/ff") == 0){
    2f4a:	00004517          	auipc	a0,0x4
    2f4e:	bd650513          	addi	a0,a0,-1066 # 6b20 <statistics+0x15d6>
    2f52:	012020ef          	jal	4f64 <mkdir>
    2f56:	2a050c63          	beqz	a0,320e <subdir+0x512>
  if(mkdir("dd/dd/ffff") == 0){
    2f5a:	00004517          	auipc	a0,0x4
    2f5e:	a0650513          	addi	a0,a0,-1530 # 6960 <statistics+0x1416>
    2f62:	002020ef          	jal	4f64 <mkdir>
    2f66:	2a050e63          	beqz	a0,3222 <subdir+0x526>
  if(unlink("dd/xx/ff") == 0){
    2f6a:	00004517          	auipc	a0,0x4
    2f6e:	bb650513          	addi	a0,a0,-1098 # 6b20 <statistics+0x15d6>
    2f72:	7db010ef          	jal	4f4c <unlink>
    2f76:	2c050063          	beqz	a0,3236 <subdir+0x53a>
  if(unlink("dd/ff/ff") == 0){
    2f7a:	00004517          	auipc	a0,0x4
    2f7e:	b7650513          	addi	a0,a0,-1162 # 6af0 <statistics+0x15a6>
    2f82:	7cb010ef          	jal	4f4c <unlink>
    2f86:	2c050263          	beqz	a0,324a <subdir+0x54e>
  if(chdir("dd/ff") == 0){
    2f8a:	00004517          	auipc	a0,0x4
    2f8e:	8ce50513          	addi	a0,a0,-1842 # 6858 <statistics+0x130e>
    2f92:	7db010ef          	jal	4f6c <chdir>
    2f96:	2c050463          	beqz	a0,325e <subdir+0x562>
  if(chdir("dd/xx") == 0){
    2f9a:	00004517          	auipc	a0,0x4
    2f9e:	d6650513          	addi	a0,a0,-666 # 6d00 <statistics+0x17b6>
    2fa2:	7cb010ef          	jal	4f6c <chdir>
    2fa6:	2c050663          	beqz	a0,3272 <subdir+0x576>
  if(unlink("dd/dd/ffff") != 0){
    2faa:	00004517          	auipc	a0,0x4
    2fae:	9b650513          	addi	a0,a0,-1610 # 6960 <statistics+0x1416>
    2fb2:	79b010ef          	jal	4f4c <unlink>
    2fb6:	2c051863          	bnez	a0,3286 <subdir+0x58a>
  if(unlink("dd/ff") != 0){
    2fba:	00004517          	auipc	a0,0x4
    2fbe:	89e50513          	addi	a0,a0,-1890 # 6858 <statistics+0x130e>
    2fc2:	78b010ef          	jal	4f4c <unlink>
    2fc6:	2c051a63          	bnez	a0,329a <subdir+0x59e>
  if(unlink("dd") == 0){
    2fca:	00004517          	auipc	a0,0x4
    2fce:	86e50513          	addi	a0,a0,-1938 # 6838 <statistics+0x12ee>
    2fd2:	77b010ef          	jal	4f4c <unlink>
    2fd6:	2c050c63          	beqz	a0,32ae <subdir+0x5b2>
  if(unlink("dd/dd") < 0){
    2fda:	00004517          	auipc	a0,0x4
    2fde:	d9650513          	addi	a0,a0,-618 # 6d70 <statistics+0x1826>
    2fe2:	76b010ef          	jal	4f4c <unlink>
    2fe6:	2c054e63          	bltz	a0,32c2 <subdir+0x5c6>
  if(unlink("dd") < 0){
    2fea:	00004517          	auipc	a0,0x4
    2fee:	84e50513          	addi	a0,a0,-1970 # 6838 <statistics+0x12ee>
    2ff2:	75b010ef          	jal	4f4c <unlink>
    2ff6:	2e054063          	bltz	a0,32d6 <subdir+0x5da>
}
    2ffa:	60e2                	ld	ra,24(sp)
    2ffc:	6442                	ld	s0,16(sp)
    2ffe:	64a2                	ld	s1,8(sp)
    3000:	6902                	ld	s2,0(sp)
    3002:	6105                	addi	sp,sp,32
    3004:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    3006:	85ca                	mv	a1,s2
    3008:	00004517          	auipc	a0,0x4
    300c:	83850513          	addi	a0,a0,-1992 # 6840 <statistics+0x12f6>
    3010:	38c020ef          	jal	539c <printf>
    exit(1);
    3014:	4505                	li	a0,1
    3016:	6e7010ef          	jal	4efc <exit>
    printf("%s: create dd/ff failed\n", s);
    301a:	85ca                	mv	a1,s2
    301c:	00004517          	auipc	a0,0x4
    3020:	84450513          	addi	a0,a0,-1980 # 6860 <statistics+0x1316>
    3024:	378020ef          	jal	539c <printf>
    exit(1);
    3028:	4505                	li	a0,1
    302a:	6d3010ef          	jal	4efc <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    302e:	85ca                	mv	a1,s2
    3030:	00004517          	auipc	a0,0x4
    3034:	85050513          	addi	a0,a0,-1968 # 6880 <statistics+0x1336>
    3038:	364020ef          	jal	539c <printf>
    exit(1);
    303c:	4505                	li	a0,1
    303e:	6bf010ef          	jal	4efc <exit>
    printf("%s: subdir mkdir dd/dd failed\n", s);
    3042:	85ca                	mv	a1,s2
    3044:	00004517          	auipc	a0,0x4
    3048:	87450513          	addi	a0,a0,-1932 # 68b8 <statistics+0x136e>
    304c:	350020ef          	jal	539c <printf>
    exit(1);
    3050:	4505                	li	a0,1
    3052:	6ab010ef          	jal	4efc <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    3056:	85ca                	mv	a1,s2
    3058:	00004517          	auipc	a0,0x4
    305c:	89050513          	addi	a0,a0,-1904 # 68e8 <statistics+0x139e>
    3060:	33c020ef          	jal	539c <printf>
    exit(1);
    3064:	4505                	li	a0,1
    3066:	697010ef          	jal	4efc <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    306a:	85ca                	mv	a1,s2
    306c:	00004517          	auipc	a0,0x4
    3070:	8b450513          	addi	a0,a0,-1868 # 6920 <statistics+0x13d6>
    3074:	328020ef          	jal	539c <printf>
    exit(1);
    3078:	4505                	li	a0,1
    307a:	683010ef          	jal	4efc <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    307e:	85ca                	mv	a1,s2
    3080:	00004517          	auipc	a0,0x4
    3084:	8c050513          	addi	a0,a0,-1856 # 6940 <statistics+0x13f6>
    3088:	314020ef          	jal	539c <printf>
    exit(1);
    308c:	4505                	li	a0,1
    308e:	66f010ef          	jal	4efc <exit>
    printf("%s: link dd/dd/ff dd/dd/ffff failed\n", s);
    3092:	85ca                	mv	a1,s2
    3094:	00004517          	auipc	a0,0x4
    3098:	8dc50513          	addi	a0,a0,-1828 # 6970 <statistics+0x1426>
    309c:	300020ef          	jal	539c <printf>
    exit(1);
    30a0:	4505                	li	a0,1
    30a2:	65b010ef          	jal	4efc <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    30a6:	85ca                	mv	a1,s2
    30a8:	00004517          	auipc	a0,0x4
    30ac:	8f050513          	addi	a0,a0,-1808 # 6998 <statistics+0x144e>
    30b0:	2ec020ef          	jal	539c <printf>
    exit(1);
    30b4:	4505                	li	a0,1
    30b6:	647010ef          	jal	4efc <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    30ba:	85ca                	mv	a1,s2
    30bc:	00004517          	auipc	a0,0x4
    30c0:	8fc50513          	addi	a0,a0,-1796 # 69b8 <statistics+0x146e>
    30c4:	2d8020ef          	jal	539c <printf>
    exit(1);
    30c8:	4505                	li	a0,1
    30ca:	633010ef          	jal	4efc <exit>
    printf("%s: chdir dd failed\n", s);
    30ce:	85ca                	mv	a1,s2
    30d0:	00004517          	auipc	a0,0x4
    30d4:	91050513          	addi	a0,a0,-1776 # 69e0 <statistics+0x1496>
    30d8:	2c4020ef          	jal	539c <printf>
    exit(1);
    30dc:	4505                	li	a0,1
    30de:	61f010ef          	jal	4efc <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    30e2:	85ca                	mv	a1,s2
    30e4:	00004517          	auipc	a0,0x4
    30e8:	92450513          	addi	a0,a0,-1756 # 6a08 <statistics+0x14be>
    30ec:	2b0020ef          	jal	539c <printf>
    exit(1);
    30f0:	4505                	li	a0,1
    30f2:	60b010ef          	jal	4efc <exit>
    printf("%s: chdir dd/../../../dd failed\n", s);
    30f6:	85ca                	mv	a1,s2
    30f8:	00004517          	auipc	a0,0x4
    30fc:	94050513          	addi	a0,a0,-1728 # 6a38 <statistics+0x14ee>
    3100:	29c020ef          	jal	539c <printf>
    exit(1);
    3104:	4505                	li	a0,1
    3106:	5f7010ef          	jal	4efc <exit>
    printf("%s: chdir ./.. failed\n", s);
    310a:	85ca                	mv	a1,s2
    310c:	00004517          	auipc	a0,0x4
    3110:	95c50513          	addi	a0,a0,-1700 # 6a68 <statistics+0x151e>
    3114:	288020ef          	jal	539c <printf>
    exit(1);
    3118:	4505                	li	a0,1
    311a:	5e3010ef          	jal	4efc <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    311e:	85ca                	mv	a1,s2
    3120:	00004517          	auipc	a0,0x4
    3124:	96050513          	addi	a0,a0,-1696 # 6a80 <statistics+0x1536>
    3128:	274020ef          	jal	539c <printf>
    exit(1);
    312c:	4505                	li	a0,1
    312e:	5cf010ef          	jal	4efc <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3132:	85ca                	mv	a1,s2
    3134:	00004517          	auipc	a0,0x4
    3138:	96c50513          	addi	a0,a0,-1684 # 6aa0 <statistics+0x1556>
    313c:	260020ef          	jal	539c <printf>
    exit(1);
    3140:	4505                	li	a0,1
    3142:	5bb010ef          	jal	4efc <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3146:	85ca                	mv	a1,s2
    3148:	00004517          	auipc	a0,0x4
    314c:	97850513          	addi	a0,a0,-1672 # 6ac0 <statistics+0x1576>
    3150:	24c020ef          	jal	539c <printf>
    exit(1);
    3154:	4505                	li	a0,1
    3156:	5a7010ef          	jal	4efc <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    315a:	85ca                	mv	a1,s2
    315c:	00004517          	auipc	a0,0x4
    3160:	9a450513          	addi	a0,a0,-1628 # 6b00 <statistics+0x15b6>
    3164:	238020ef          	jal	539c <printf>
    exit(1);
    3168:	4505                	li	a0,1
    316a:	593010ef          	jal	4efc <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    316e:	85ca                	mv	a1,s2
    3170:	00004517          	auipc	a0,0x4
    3174:	9c050513          	addi	a0,a0,-1600 # 6b30 <statistics+0x15e6>
    3178:	224020ef          	jal	539c <printf>
    exit(1);
    317c:	4505                	li	a0,1
    317e:	57f010ef          	jal	4efc <exit>
    printf("%s: create dd succeeded!\n", s);
    3182:	85ca                	mv	a1,s2
    3184:	00004517          	auipc	a0,0x4
    3188:	9cc50513          	addi	a0,a0,-1588 # 6b50 <statistics+0x1606>
    318c:	210020ef          	jal	539c <printf>
    exit(1);
    3190:	4505                	li	a0,1
    3192:	56b010ef          	jal	4efc <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3196:	85ca                	mv	a1,s2
    3198:	00004517          	auipc	a0,0x4
    319c:	9d850513          	addi	a0,a0,-1576 # 6b70 <statistics+0x1626>
    31a0:	1fc020ef          	jal	539c <printf>
    exit(1);
    31a4:	4505                	li	a0,1
    31a6:	557010ef          	jal	4efc <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    31aa:	85ca                	mv	a1,s2
    31ac:	00004517          	auipc	a0,0x4
    31b0:	9e450513          	addi	a0,a0,-1564 # 6b90 <statistics+0x1646>
    31b4:	1e8020ef          	jal	539c <printf>
    exit(1);
    31b8:	4505                	li	a0,1
    31ba:	543010ef          	jal	4efc <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    31be:	85ca                	mv	a1,s2
    31c0:	00004517          	auipc	a0,0x4
    31c4:	a0050513          	addi	a0,a0,-1536 # 6bc0 <statistics+0x1676>
    31c8:	1d4020ef          	jal	539c <printf>
    exit(1);
    31cc:	4505                	li	a0,1
    31ce:	52f010ef          	jal	4efc <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    31d2:	85ca                	mv	a1,s2
    31d4:	00004517          	auipc	a0,0x4
    31d8:	a1450513          	addi	a0,a0,-1516 # 6be8 <statistics+0x169e>
    31dc:	1c0020ef          	jal	539c <printf>
    exit(1);
    31e0:	4505                	li	a0,1
    31e2:	51b010ef          	jal	4efc <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    31e6:	85ca                	mv	a1,s2
    31e8:	00004517          	auipc	a0,0x4
    31ec:	a2850513          	addi	a0,a0,-1496 # 6c10 <statistics+0x16c6>
    31f0:	1ac020ef          	jal	539c <printf>
    exit(1);
    31f4:	4505                	li	a0,1
    31f6:	507010ef          	jal	4efc <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    31fa:	85ca                	mv	a1,s2
    31fc:	00004517          	auipc	a0,0x4
    3200:	a3c50513          	addi	a0,a0,-1476 # 6c38 <statistics+0x16ee>
    3204:	198020ef          	jal	539c <printf>
    exit(1);
    3208:	4505                	li	a0,1
    320a:	4f3010ef          	jal	4efc <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    320e:	85ca                	mv	a1,s2
    3210:	00004517          	auipc	a0,0x4
    3214:	a4850513          	addi	a0,a0,-1464 # 6c58 <statistics+0x170e>
    3218:	184020ef          	jal	539c <printf>
    exit(1);
    321c:	4505                	li	a0,1
    321e:	4df010ef          	jal	4efc <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3222:	85ca                	mv	a1,s2
    3224:	00004517          	auipc	a0,0x4
    3228:	a5450513          	addi	a0,a0,-1452 # 6c78 <statistics+0x172e>
    322c:	170020ef          	jal	539c <printf>
    exit(1);
    3230:	4505                	li	a0,1
    3232:	4cb010ef          	jal	4efc <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3236:	85ca                	mv	a1,s2
    3238:	00004517          	auipc	a0,0x4
    323c:	a6850513          	addi	a0,a0,-1432 # 6ca0 <statistics+0x1756>
    3240:	15c020ef          	jal	539c <printf>
    exit(1);
    3244:	4505                	li	a0,1
    3246:	4b7010ef          	jal	4efc <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    324a:	85ca                	mv	a1,s2
    324c:	00004517          	auipc	a0,0x4
    3250:	a7450513          	addi	a0,a0,-1420 # 6cc0 <statistics+0x1776>
    3254:	148020ef          	jal	539c <printf>
    exit(1);
    3258:	4505                	li	a0,1
    325a:	4a3010ef          	jal	4efc <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    325e:	85ca                	mv	a1,s2
    3260:	00004517          	auipc	a0,0x4
    3264:	a8050513          	addi	a0,a0,-1408 # 6ce0 <statistics+0x1796>
    3268:	134020ef          	jal	539c <printf>
    exit(1);
    326c:	4505                	li	a0,1
    326e:	48f010ef          	jal	4efc <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3272:	85ca                	mv	a1,s2
    3274:	00004517          	auipc	a0,0x4
    3278:	a9450513          	addi	a0,a0,-1388 # 6d08 <statistics+0x17be>
    327c:	120020ef          	jal	539c <printf>
    exit(1);
    3280:	4505                	li	a0,1
    3282:	47b010ef          	jal	4efc <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3286:	85ca                	mv	a1,s2
    3288:	00003517          	auipc	a0,0x3
    328c:	71050513          	addi	a0,a0,1808 # 6998 <statistics+0x144e>
    3290:	10c020ef          	jal	539c <printf>
    exit(1);
    3294:	4505                	li	a0,1
    3296:	467010ef          	jal	4efc <exit>
    printf("%s: unlink dd/ff failed\n", s);
    329a:	85ca                	mv	a1,s2
    329c:	00004517          	auipc	a0,0x4
    32a0:	a8c50513          	addi	a0,a0,-1396 # 6d28 <statistics+0x17de>
    32a4:	0f8020ef          	jal	539c <printf>
    exit(1);
    32a8:	4505                	li	a0,1
    32aa:	453010ef          	jal	4efc <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    32ae:	85ca                	mv	a1,s2
    32b0:	00004517          	auipc	a0,0x4
    32b4:	a9850513          	addi	a0,a0,-1384 # 6d48 <statistics+0x17fe>
    32b8:	0e4020ef          	jal	539c <printf>
    exit(1);
    32bc:	4505                	li	a0,1
    32be:	43f010ef          	jal	4efc <exit>
    printf("%s: unlink dd/dd failed\n", s);
    32c2:	85ca                	mv	a1,s2
    32c4:	00004517          	auipc	a0,0x4
    32c8:	ab450513          	addi	a0,a0,-1356 # 6d78 <statistics+0x182e>
    32cc:	0d0020ef          	jal	539c <printf>
    exit(1);
    32d0:	4505                	li	a0,1
    32d2:	42b010ef          	jal	4efc <exit>
    printf("%s: unlink dd failed\n", s);
    32d6:	85ca                	mv	a1,s2
    32d8:	00004517          	auipc	a0,0x4
    32dc:	ac050513          	addi	a0,a0,-1344 # 6d98 <statistics+0x184e>
    32e0:	0bc020ef          	jal	539c <printf>
    exit(1);
    32e4:	4505                	li	a0,1
    32e6:	417010ef          	jal	4efc <exit>

00000000000032ea <rmdot>:
{
    32ea:	1101                	addi	sp,sp,-32
    32ec:	ec06                	sd	ra,24(sp)
    32ee:	e822                	sd	s0,16(sp)
    32f0:	e426                	sd	s1,8(sp)
    32f2:	1000                	addi	s0,sp,32
    32f4:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    32f6:	00004517          	auipc	a0,0x4
    32fa:	aba50513          	addi	a0,a0,-1350 # 6db0 <statistics+0x1866>
    32fe:	467010ef          	jal	4f64 <mkdir>
    3302:	e53d                	bnez	a0,3370 <rmdot+0x86>
  if(chdir("dots") != 0){
    3304:	00004517          	auipc	a0,0x4
    3308:	aac50513          	addi	a0,a0,-1364 # 6db0 <statistics+0x1866>
    330c:	461010ef          	jal	4f6c <chdir>
    3310:	e935                	bnez	a0,3384 <rmdot+0x9a>
  if(unlink(".") == 0){
    3312:	00003517          	auipc	a0,0x3
    3316:	9ce50513          	addi	a0,a0,-1586 # 5ce0 <statistics+0x796>
    331a:	433010ef          	jal	4f4c <unlink>
    331e:	cd2d                	beqz	a0,3398 <rmdot+0xae>
  if(unlink("..") == 0){
    3320:	00003517          	auipc	a0,0x3
    3324:	4e050513          	addi	a0,a0,1248 # 6800 <statistics+0x12b6>
    3328:	425010ef          	jal	4f4c <unlink>
    332c:	c141                	beqz	a0,33ac <rmdot+0xc2>
  if(chdir("/") != 0){
    332e:	00003517          	auipc	a0,0x3
    3332:	47a50513          	addi	a0,a0,1146 # 67a8 <statistics+0x125e>
    3336:	437010ef          	jal	4f6c <chdir>
    333a:	e159                	bnez	a0,33c0 <rmdot+0xd6>
  if(unlink("dots/.") == 0){
    333c:	00004517          	auipc	a0,0x4
    3340:	adc50513          	addi	a0,a0,-1316 # 6e18 <statistics+0x18ce>
    3344:	409010ef          	jal	4f4c <unlink>
    3348:	c551                	beqz	a0,33d4 <rmdot+0xea>
  if(unlink("dots/..") == 0){
    334a:	00004517          	auipc	a0,0x4
    334e:	af650513          	addi	a0,a0,-1290 # 6e40 <statistics+0x18f6>
    3352:	3fb010ef          	jal	4f4c <unlink>
    3356:	c949                	beqz	a0,33e8 <rmdot+0xfe>
  if(unlink("dots") != 0){
    3358:	00004517          	auipc	a0,0x4
    335c:	a5850513          	addi	a0,a0,-1448 # 6db0 <statistics+0x1866>
    3360:	3ed010ef          	jal	4f4c <unlink>
    3364:	ed41                	bnez	a0,33fc <rmdot+0x112>
}
    3366:	60e2                	ld	ra,24(sp)
    3368:	6442                	ld	s0,16(sp)
    336a:	64a2                	ld	s1,8(sp)
    336c:	6105                	addi	sp,sp,32
    336e:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3370:	85a6                	mv	a1,s1
    3372:	00004517          	auipc	a0,0x4
    3376:	a4650513          	addi	a0,a0,-1466 # 6db8 <statistics+0x186e>
    337a:	022020ef          	jal	539c <printf>
    exit(1);
    337e:	4505                	li	a0,1
    3380:	37d010ef          	jal	4efc <exit>
    printf("%s: chdir dots failed\n", s);
    3384:	85a6                	mv	a1,s1
    3386:	00004517          	auipc	a0,0x4
    338a:	a4a50513          	addi	a0,a0,-1462 # 6dd0 <statistics+0x1886>
    338e:	00e020ef          	jal	539c <printf>
    exit(1);
    3392:	4505                	li	a0,1
    3394:	369010ef          	jal	4efc <exit>
    printf("%s: rm . worked!\n", s);
    3398:	85a6                	mv	a1,s1
    339a:	00004517          	auipc	a0,0x4
    339e:	a4e50513          	addi	a0,a0,-1458 # 6de8 <statistics+0x189e>
    33a2:	7fb010ef          	jal	539c <printf>
    exit(1);
    33a6:	4505                	li	a0,1
    33a8:	355010ef          	jal	4efc <exit>
    printf("%s: rm .. worked!\n", s);
    33ac:	85a6                	mv	a1,s1
    33ae:	00004517          	auipc	a0,0x4
    33b2:	a5250513          	addi	a0,a0,-1454 # 6e00 <statistics+0x18b6>
    33b6:	7e7010ef          	jal	539c <printf>
    exit(1);
    33ba:	4505                	li	a0,1
    33bc:	341010ef          	jal	4efc <exit>
    printf("%s: chdir / failed\n", s);
    33c0:	85a6                	mv	a1,s1
    33c2:	00003517          	auipc	a0,0x3
    33c6:	3ee50513          	addi	a0,a0,1006 # 67b0 <statistics+0x1266>
    33ca:	7d3010ef          	jal	539c <printf>
    exit(1);
    33ce:	4505                	li	a0,1
    33d0:	32d010ef          	jal	4efc <exit>
    printf("%s: unlink dots/. worked!\n", s);
    33d4:	85a6                	mv	a1,s1
    33d6:	00004517          	auipc	a0,0x4
    33da:	a4a50513          	addi	a0,a0,-1462 # 6e20 <statistics+0x18d6>
    33de:	7bf010ef          	jal	539c <printf>
    exit(1);
    33e2:	4505                	li	a0,1
    33e4:	319010ef          	jal	4efc <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    33e8:	85a6                	mv	a1,s1
    33ea:	00004517          	auipc	a0,0x4
    33ee:	a5e50513          	addi	a0,a0,-1442 # 6e48 <statistics+0x18fe>
    33f2:	7ab010ef          	jal	539c <printf>
    exit(1);
    33f6:	4505                	li	a0,1
    33f8:	305010ef          	jal	4efc <exit>
    printf("%s: unlink dots failed!\n", s);
    33fc:	85a6                	mv	a1,s1
    33fe:	00004517          	auipc	a0,0x4
    3402:	a6a50513          	addi	a0,a0,-1430 # 6e68 <statistics+0x191e>
    3406:	797010ef          	jal	539c <printf>
    exit(1);
    340a:	4505                	li	a0,1
    340c:	2f1010ef          	jal	4efc <exit>

0000000000003410 <dirfile>:
{
    3410:	1101                	addi	sp,sp,-32
    3412:	ec06                	sd	ra,24(sp)
    3414:	e822                	sd	s0,16(sp)
    3416:	e426                	sd	s1,8(sp)
    3418:	e04a                	sd	s2,0(sp)
    341a:	1000                	addi	s0,sp,32
    341c:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    341e:	20000593          	li	a1,512
    3422:	00004517          	auipc	a0,0x4
    3426:	a6650513          	addi	a0,a0,-1434 # 6e88 <statistics+0x193e>
    342a:	313010ef          	jal	4f3c <open>
  if(fd < 0){
    342e:	0c054563          	bltz	a0,34f8 <dirfile+0xe8>
  close(fd);
    3432:	2f3010ef          	jal	4f24 <close>
  if(chdir("dirfile") == 0){
    3436:	00004517          	auipc	a0,0x4
    343a:	a5250513          	addi	a0,a0,-1454 # 6e88 <statistics+0x193e>
    343e:	32f010ef          	jal	4f6c <chdir>
    3442:	c569                	beqz	a0,350c <dirfile+0xfc>
  fd = open("dirfile/xx", 0);
    3444:	4581                	li	a1,0
    3446:	00004517          	auipc	a0,0x4
    344a:	a8a50513          	addi	a0,a0,-1398 # 6ed0 <statistics+0x1986>
    344e:	2ef010ef          	jal	4f3c <open>
  if(fd >= 0){
    3452:	0c055763          	bgez	a0,3520 <dirfile+0x110>
  fd = open("dirfile/xx", O_CREATE);
    3456:	20000593          	li	a1,512
    345a:	00004517          	auipc	a0,0x4
    345e:	a7650513          	addi	a0,a0,-1418 # 6ed0 <statistics+0x1986>
    3462:	2db010ef          	jal	4f3c <open>
  if(fd >= 0){
    3466:	0c055763          	bgez	a0,3534 <dirfile+0x124>
  if(mkdir("dirfile/xx") == 0){
    346a:	00004517          	auipc	a0,0x4
    346e:	a6650513          	addi	a0,a0,-1434 # 6ed0 <statistics+0x1986>
    3472:	2f3010ef          	jal	4f64 <mkdir>
    3476:	0c050963          	beqz	a0,3548 <dirfile+0x138>
  if(unlink("dirfile/xx") == 0){
    347a:	00004517          	auipc	a0,0x4
    347e:	a5650513          	addi	a0,a0,-1450 # 6ed0 <statistics+0x1986>
    3482:	2cb010ef          	jal	4f4c <unlink>
    3486:	0c050b63          	beqz	a0,355c <dirfile+0x14c>
  if(link("README", "dirfile/xx") == 0){
    348a:	00004597          	auipc	a1,0x4
    348e:	a4658593          	addi	a1,a1,-1466 # 6ed0 <statistics+0x1986>
    3492:	00002517          	auipc	a0,0x2
    3496:	33e50513          	addi	a0,a0,830 # 57d0 <statistics+0x286>
    349a:	2c3010ef          	jal	4f5c <link>
    349e:	0c050963          	beqz	a0,3570 <dirfile+0x160>
  if(unlink("dirfile") != 0){
    34a2:	00004517          	auipc	a0,0x4
    34a6:	9e650513          	addi	a0,a0,-1562 # 6e88 <statistics+0x193e>
    34aa:	2a3010ef          	jal	4f4c <unlink>
    34ae:	0c051b63          	bnez	a0,3584 <dirfile+0x174>
  fd = open(".", O_RDWR);
    34b2:	4589                	li	a1,2
    34b4:	00003517          	auipc	a0,0x3
    34b8:	82c50513          	addi	a0,a0,-2004 # 5ce0 <statistics+0x796>
    34bc:	281010ef          	jal	4f3c <open>
  if(fd >= 0){
    34c0:	0c055c63          	bgez	a0,3598 <dirfile+0x188>
  fd = open(".", 0);
    34c4:	4581                	li	a1,0
    34c6:	00003517          	auipc	a0,0x3
    34ca:	81a50513          	addi	a0,a0,-2022 # 5ce0 <statistics+0x796>
    34ce:	26f010ef          	jal	4f3c <open>
    34d2:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    34d4:	4605                	li	a2,1
    34d6:	00002597          	auipc	a1,0x2
    34da:	19258593          	addi	a1,a1,402 # 5668 <statistics+0x11e>
    34de:	23f010ef          	jal	4f1c <write>
    34e2:	0ca04563          	bgtz	a0,35ac <dirfile+0x19c>
  close(fd);
    34e6:	8526                	mv	a0,s1
    34e8:	23d010ef          	jal	4f24 <close>
}
    34ec:	60e2                	ld	ra,24(sp)
    34ee:	6442                	ld	s0,16(sp)
    34f0:	64a2                	ld	s1,8(sp)
    34f2:	6902                	ld	s2,0(sp)
    34f4:	6105                	addi	sp,sp,32
    34f6:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    34f8:	85ca                	mv	a1,s2
    34fa:	00004517          	auipc	a0,0x4
    34fe:	99650513          	addi	a0,a0,-1642 # 6e90 <statistics+0x1946>
    3502:	69b010ef          	jal	539c <printf>
    exit(1);
    3506:	4505                	li	a0,1
    3508:	1f5010ef          	jal	4efc <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    350c:	85ca                	mv	a1,s2
    350e:	00004517          	auipc	a0,0x4
    3512:	9a250513          	addi	a0,a0,-1630 # 6eb0 <statistics+0x1966>
    3516:	687010ef          	jal	539c <printf>
    exit(1);
    351a:	4505                	li	a0,1
    351c:	1e1010ef          	jal	4efc <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3520:	85ca                	mv	a1,s2
    3522:	00004517          	auipc	a0,0x4
    3526:	9be50513          	addi	a0,a0,-1602 # 6ee0 <statistics+0x1996>
    352a:	673010ef          	jal	539c <printf>
    exit(1);
    352e:	4505                	li	a0,1
    3530:	1cd010ef          	jal	4efc <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3534:	85ca                	mv	a1,s2
    3536:	00004517          	auipc	a0,0x4
    353a:	9aa50513          	addi	a0,a0,-1622 # 6ee0 <statistics+0x1996>
    353e:	65f010ef          	jal	539c <printf>
    exit(1);
    3542:	4505                	li	a0,1
    3544:	1b9010ef          	jal	4efc <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    3548:	85ca                	mv	a1,s2
    354a:	00004517          	auipc	a0,0x4
    354e:	9be50513          	addi	a0,a0,-1602 # 6f08 <statistics+0x19be>
    3552:	64b010ef          	jal	539c <printf>
    exit(1);
    3556:	4505                	li	a0,1
    3558:	1a5010ef          	jal	4efc <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    355c:	85ca                	mv	a1,s2
    355e:	00004517          	auipc	a0,0x4
    3562:	9d250513          	addi	a0,a0,-1582 # 6f30 <statistics+0x19e6>
    3566:	637010ef          	jal	539c <printf>
    exit(1);
    356a:	4505                	li	a0,1
    356c:	191010ef          	jal	4efc <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    3570:	85ca                	mv	a1,s2
    3572:	00004517          	auipc	a0,0x4
    3576:	9e650513          	addi	a0,a0,-1562 # 6f58 <statistics+0x1a0e>
    357a:	623010ef          	jal	539c <printf>
    exit(1);
    357e:	4505                	li	a0,1
    3580:	17d010ef          	jal	4efc <exit>
    printf("%s: unlink dirfile failed!\n", s);
    3584:	85ca                	mv	a1,s2
    3586:	00004517          	auipc	a0,0x4
    358a:	9fa50513          	addi	a0,a0,-1542 # 6f80 <statistics+0x1a36>
    358e:	60f010ef          	jal	539c <printf>
    exit(1);
    3592:	4505                	li	a0,1
    3594:	169010ef          	jal	4efc <exit>
    printf("%s: open . for writing succeeded!\n", s);
    3598:	85ca                	mv	a1,s2
    359a:	00004517          	auipc	a0,0x4
    359e:	a0650513          	addi	a0,a0,-1530 # 6fa0 <statistics+0x1a56>
    35a2:	5fb010ef          	jal	539c <printf>
    exit(1);
    35a6:	4505                	li	a0,1
    35a8:	155010ef          	jal	4efc <exit>
    printf("%s: write . succeeded!\n", s);
    35ac:	85ca                	mv	a1,s2
    35ae:	00004517          	auipc	a0,0x4
    35b2:	a1a50513          	addi	a0,a0,-1510 # 6fc8 <statistics+0x1a7e>
    35b6:	5e7010ef          	jal	539c <printf>
    exit(1);
    35ba:	4505                	li	a0,1
    35bc:	141010ef          	jal	4efc <exit>

00000000000035c0 <iref>:
{
    35c0:	715d                	addi	sp,sp,-80
    35c2:	e486                	sd	ra,72(sp)
    35c4:	e0a2                	sd	s0,64(sp)
    35c6:	fc26                	sd	s1,56(sp)
    35c8:	f84a                	sd	s2,48(sp)
    35ca:	f44e                	sd	s3,40(sp)
    35cc:	f052                	sd	s4,32(sp)
    35ce:	ec56                	sd	s5,24(sp)
    35d0:	e85a                	sd	s6,16(sp)
    35d2:	e45e                	sd	s7,8(sp)
    35d4:	0880                	addi	s0,sp,80
    35d6:	8baa                	mv	s7,a0
    35d8:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    35dc:	00004a97          	auipc	s5,0x4
    35e0:	a04a8a93          	addi	s5,s5,-1532 # 6fe0 <statistics+0x1a96>
    mkdir("");
    35e4:	00003497          	auipc	s1,0x3
    35e8:	50448493          	addi	s1,s1,1284 # 6ae8 <statistics+0x159e>
    link("README", "");
    35ec:	00002b17          	auipc	s6,0x2
    35f0:	1e4b0b13          	addi	s6,s6,484 # 57d0 <statistics+0x286>
    fd = open("", O_CREATE);
    35f4:	20000a13          	li	s4,512
    fd = open("xx", O_CREATE);
    35f8:	00004997          	auipc	s3,0x4
    35fc:	8e098993          	addi	s3,s3,-1824 # 6ed8 <statistics+0x198e>
    3600:	a835                	j	363c <iref+0x7c>
      printf("%s: mkdir irefd failed\n", s);
    3602:	85de                	mv	a1,s7
    3604:	00004517          	auipc	a0,0x4
    3608:	9e450513          	addi	a0,a0,-1564 # 6fe8 <statistics+0x1a9e>
    360c:	591010ef          	jal	539c <printf>
      exit(1);
    3610:	4505                	li	a0,1
    3612:	0eb010ef          	jal	4efc <exit>
      printf("%s: chdir irefd failed\n", s);
    3616:	85de                	mv	a1,s7
    3618:	00004517          	auipc	a0,0x4
    361c:	9e850513          	addi	a0,a0,-1560 # 7000 <statistics+0x1ab6>
    3620:	57d010ef          	jal	539c <printf>
      exit(1);
    3624:	4505                	li	a0,1
    3626:	0d7010ef          	jal	4efc <exit>
      close(fd);
    362a:	0fb010ef          	jal	4f24 <close>
    362e:	a825                	j	3666 <iref+0xa6>
    unlink("xx");
    3630:	854e                	mv	a0,s3
    3632:	11b010ef          	jal	4f4c <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3636:	397d                	addiw	s2,s2,-1
    3638:	04090063          	beqz	s2,3678 <iref+0xb8>
    if(mkdir("irefd") != 0){
    363c:	8556                	mv	a0,s5
    363e:	127010ef          	jal	4f64 <mkdir>
    3642:	f161                	bnez	a0,3602 <iref+0x42>
    if(chdir("irefd") != 0){
    3644:	8556                	mv	a0,s5
    3646:	127010ef          	jal	4f6c <chdir>
    364a:	f571                	bnez	a0,3616 <iref+0x56>
    mkdir("");
    364c:	8526                	mv	a0,s1
    364e:	117010ef          	jal	4f64 <mkdir>
    link("README", "");
    3652:	85a6                	mv	a1,s1
    3654:	855a                	mv	a0,s6
    3656:	107010ef          	jal	4f5c <link>
    fd = open("", O_CREATE);
    365a:	85d2                	mv	a1,s4
    365c:	8526                	mv	a0,s1
    365e:	0df010ef          	jal	4f3c <open>
    if(fd >= 0)
    3662:	fc0554e3          	bgez	a0,362a <iref+0x6a>
    fd = open("xx", O_CREATE);
    3666:	85d2                	mv	a1,s4
    3668:	854e                	mv	a0,s3
    366a:	0d3010ef          	jal	4f3c <open>
    if(fd >= 0)
    366e:	fc0541e3          	bltz	a0,3630 <iref+0x70>
      close(fd);
    3672:	0b3010ef          	jal	4f24 <close>
    3676:	bf6d                	j	3630 <iref+0x70>
  for(i = 0; i < NINODE + 1; i++){
    3678:	03300493          	li	s1,51
    chdir("..");
    367c:	00003997          	auipc	s3,0x3
    3680:	18498993          	addi	s3,s3,388 # 6800 <statistics+0x12b6>
    unlink("irefd");
    3684:	00004917          	auipc	s2,0x4
    3688:	95c90913          	addi	s2,s2,-1700 # 6fe0 <statistics+0x1a96>
    chdir("..");
    368c:	854e                	mv	a0,s3
    368e:	0df010ef          	jal	4f6c <chdir>
    unlink("irefd");
    3692:	854a                	mv	a0,s2
    3694:	0b9010ef          	jal	4f4c <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3698:	34fd                	addiw	s1,s1,-1
    369a:	f8ed                	bnez	s1,368c <iref+0xcc>
  chdir("/");
    369c:	00003517          	auipc	a0,0x3
    36a0:	10c50513          	addi	a0,a0,268 # 67a8 <statistics+0x125e>
    36a4:	0c9010ef          	jal	4f6c <chdir>
}
    36a8:	60a6                	ld	ra,72(sp)
    36aa:	6406                	ld	s0,64(sp)
    36ac:	74e2                	ld	s1,56(sp)
    36ae:	7942                	ld	s2,48(sp)
    36b0:	79a2                	ld	s3,40(sp)
    36b2:	7a02                	ld	s4,32(sp)
    36b4:	6ae2                	ld	s5,24(sp)
    36b6:	6b42                	ld	s6,16(sp)
    36b8:	6ba2                	ld	s7,8(sp)
    36ba:	6161                	addi	sp,sp,80
    36bc:	8082                	ret

00000000000036be <openiputtest>:
{
    36be:	7179                	addi	sp,sp,-48
    36c0:	f406                	sd	ra,40(sp)
    36c2:	f022                	sd	s0,32(sp)
    36c4:	ec26                	sd	s1,24(sp)
    36c6:	1800                	addi	s0,sp,48
    36c8:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    36ca:	00004517          	auipc	a0,0x4
    36ce:	94e50513          	addi	a0,a0,-1714 # 7018 <statistics+0x1ace>
    36d2:	093010ef          	jal	4f64 <mkdir>
    36d6:	02054a63          	bltz	a0,370a <openiputtest+0x4c>
  pid = fork();
    36da:	01b010ef          	jal	4ef4 <fork>
  if(pid < 0){
    36de:	04054063          	bltz	a0,371e <openiputtest+0x60>
  if(pid == 0){
    36e2:	e939                	bnez	a0,3738 <openiputtest+0x7a>
    int fd = open("oidir", O_RDWR);
    36e4:	4589                	li	a1,2
    36e6:	00004517          	auipc	a0,0x4
    36ea:	93250513          	addi	a0,a0,-1742 # 7018 <statistics+0x1ace>
    36ee:	04f010ef          	jal	4f3c <open>
    if(fd >= 0){
    36f2:	04054063          	bltz	a0,3732 <openiputtest+0x74>
      printf("%s: open directory for write succeeded\n", s);
    36f6:	85a6                	mv	a1,s1
    36f8:	00004517          	auipc	a0,0x4
    36fc:	94050513          	addi	a0,a0,-1728 # 7038 <statistics+0x1aee>
    3700:	49d010ef          	jal	539c <printf>
      exit(1);
    3704:	4505                	li	a0,1
    3706:	7f6010ef          	jal	4efc <exit>
    printf("%s: mkdir oidir failed\n", s);
    370a:	85a6                	mv	a1,s1
    370c:	00004517          	auipc	a0,0x4
    3710:	91450513          	addi	a0,a0,-1772 # 7020 <statistics+0x1ad6>
    3714:	489010ef          	jal	539c <printf>
    exit(1);
    3718:	4505                	li	a0,1
    371a:	7e2010ef          	jal	4efc <exit>
    printf("%s: fork failed\n", s);
    371e:	85a6                	mv	a1,s1
    3720:	00002517          	auipc	a0,0x2
    3724:	76850513          	addi	a0,a0,1896 # 5e88 <statistics+0x93e>
    3728:	475010ef          	jal	539c <printf>
    exit(1);
    372c:	4505                	li	a0,1
    372e:	7ce010ef          	jal	4efc <exit>
    exit(0);
    3732:	4501                	li	a0,0
    3734:	7c8010ef          	jal	4efc <exit>
  pause(1);
    3738:	4505                	li	a0,1
    373a:	053010ef          	jal	4f8c <pause>
  if(unlink("oidir") != 0){
    373e:	00004517          	auipc	a0,0x4
    3742:	8da50513          	addi	a0,a0,-1830 # 7018 <statistics+0x1ace>
    3746:	007010ef          	jal	4f4c <unlink>
    374a:	c919                	beqz	a0,3760 <openiputtest+0xa2>
    printf("%s: unlink failed\n", s);
    374c:	85a6                	mv	a1,s1
    374e:	00003517          	auipc	a0,0x3
    3752:	92a50513          	addi	a0,a0,-1750 # 6078 <statistics+0xb2e>
    3756:	447010ef          	jal	539c <printf>
    exit(1);
    375a:	4505                	li	a0,1
    375c:	7a0010ef          	jal	4efc <exit>
  wait(&xstatus);
    3760:	fdc40513          	addi	a0,s0,-36
    3764:	7a0010ef          	jal	4f04 <wait>
  exit(xstatus);
    3768:	fdc42503          	lw	a0,-36(s0)
    376c:	790010ef          	jal	4efc <exit>

0000000000003770 <forkforkfork>:
{
    3770:	1101                	addi	sp,sp,-32
    3772:	ec06                	sd	ra,24(sp)
    3774:	e822                	sd	s0,16(sp)
    3776:	e426                	sd	s1,8(sp)
    3778:	1000                	addi	s0,sp,32
    377a:	84aa                	mv	s1,a0
  unlink("stopforking");
    377c:	00004517          	auipc	a0,0x4
    3780:	8e450513          	addi	a0,a0,-1820 # 7060 <statistics+0x1b16>
    3784:	7c8010ef          	jal	4f4c <unlink>
  int pid = fork();
    3788:	76c010ef          	jal	4ef4 <fork>
  if(pid < 0){
    378c:	02054b63          	bltz	a0,37c2 <forkforkfork+0x52>
  if(pid == 0){
    3790:	c125                	beqz	a0,37f0 <forkforkfork+0x80>
  pause(20); // two seconds
    3792:	4551                	li	a0,20
    3794:	7f8010ef          	jal	4f8c <pause>
  close(open("stopforking", O_CREATE|O_RDWR));
    3798:	20200593          	li	a1,514
    379c:	00004517          	auipc	a0,0x4
    37a0:	8c450513          	addi	a0,a0,-1852 # 7060 <statistics+0x1b16>
    37a4:	798010ef          	jal	4f3c <open>
    37a8:	77c010ef          	jal	4f24 <close>
  wait(0);
    37ac:	4501                	li	a0,0
    37ae:	756010ef          	jal	4f04 <wait>
  pause(10); // one second
    37b2:	4529                	li	a0,10
    37b4:	7d8010ef          	jal	4f8c <pause>
}
    37b8:	60e2                	ld	ra,24(sp)
    37ba:	6442                	ld	s0,16(sp)
    37bc:	64a2                	ld	s1,8(sp)
    37be:	6105                	addi	sp,sp,32
    37c0:	8082                	ret
    printf("%s: fork failed", s);
    37c2:	85a6                	mv	a1,s1
    37c4:	00003517          	auipc	a0,0x3
    37c8:	88450513          	addi	a0,a0,-1916 # 6048 <statistics+0xafe>
    37cc:	3d1010ef          	jal	539c <printf>
    exit(1);
    37d0:	4505                	li	a0,1
    37d2:	72a010ef          	jal	4efc <exit>
        exit(0);
    37d6:	4501                	li	a0,0
    37d8:	724010ef          	jal	4efc <exit>
        close(open("stopforking", O_CREATE|O_RDWR));
    37dc:	20200593          	li	a1,514
    37e0:	00004517          	auipc	a0,0x4
    37e4:	88050513          	addi	a0,a0,-1920 # 7060 <statistics+0x1b16>
    37e8:	754010ef          	jal	4f3c <open>
    37ec:	738010ef          	jal	4f24 <close>
      int fd = open("stopforking", 0);
    37f0:	4581                	li	a1,0
    37f2:	00004517          	auipc	a0,0x4
    37f6:	86e50513          	addi	a0,a0,-1938 # 7060 <statistics+0x1b16>
    37fa:	742010ef          	jal	4f3c <open>
      if(fd >= 0){
    37fe:	fc055ce3          	bgez	a0,37d6 <forkforkfork+0x66>
      if(fork() < 0){
    3802:	6f2010ef          	jal	4ef4 <fork>
    3806:	fe0555e3          	bgez	a0,37f0 <forkforkfork+0x80>
    380a:	bfc9                	j	37dc <forkforkfork+0x6c>

000000000000380c <killstatus>:
{
    380c:	715d                	addi	sp,sp,-80
    380e:	e486                	sd	ra,72(sp)
    3810:	e0a2                	sd	s0,64(sp)
    3812:	fc26                	sd	s1,56(sp)
    3814:	f84a                	sd	s2,48(sp)
    3816:	f44e                	sd	s3,40(sp)
    3818:	f052                	sd	s4,32(sp)
    381a:	ec56                	sd	s5,24(sp)
    381c:	e85a                	sd	s6,16(sp)
    381e:	0880                	addi	s0,sp,80
    3820:	8b2a                	mv	s6,a0
    3822:	06400913          	li	s2,100
    pause(1);
    3826:	4a85                	li	s5,1
    wait(&xst);
    3828:	fbc40a13          	addi	s4,s0,-68
    if(xst != -1) {
    382c:	59fd                	li	s3,-1
    int pid1 = fork();
    382e:	6c6010ef          	jal	4ef4 <fork>
    3832:	84aa                	mv	s1,a0
    if(pid1 < 0){
    3834:	02054663          	bltz	a0,3860 <killstatus+0x54>
    if(pid1 == 0){
    3838:	cd15                	beqz	a0,3874 <killstatus+0x68>
    pause(1);
    383a:	8556                	mv	a0,s5
    383c:	750010ef          	jal	4f8c <pause>
    kill(pid1);
    3840:	8526                	mv	a0,s1
    3842:	6ea010ef          	jal	4f2c <kill>
    wait(&xst);
    3846:	8552                	mv	a0,s4
    3848:	6bc010ef          	jal	4f04 <wait>
    if(xst != -1) {
    384c:	fbc42783          	lw	a5,-68(s0)
    3850:	03379563          	bne	a5,s3,387a <killstatus+0x6e>
  for(int i = 0; i < 100; i++){
    3854:	397d                	addiw	s2,s2,-1
    3856:	fc091ce3          	bnez	s2,382e <killstatus+0x22>
  exit(0);
    385a:	4501                	li	a0,0
    385c:	6a0010ef          	jal	4efc <exit>
      printf("%s: fork failed\n", s);
    3860:	85da                	mv	a1,s6
    3862:	00002517          	auipc	a0,0x2
    3866:	62650513          	addi	a0,a0,1574 # 5e88 <statistics+0x93e>
    386a:	333010ef          	jal	539c <printf>
      exit(1);
    386e:	4505                	li	a0,1
    3870:	68c010ef          	jal	4efc <exit>
        getpid();
    3874:	708010ef          	jal	4f7c <getpid>
      while(1) {
    3878:	bff5                	j	3874 <killstatus+0x68>
       printf("%s: status should be -1\n", s);
    387a:	85da                	mv	a1,s6
    387c:	00003517          	auipc	a0,0x3
    3880:	7f450513          	addi	a0,a0,2036 # 7070 <statistics+0x1b26>
    3884:	319010ef          	jal	539c <printf>
       exit(1);
    3888:	4505                	li	a0,1
    388a:	672010ef          	jal	4efc <exit>

000000000000388e <preempt>:
{
    388e:	7139                	addi	sp,sp,-64
    3890:	fc06                	sd	ra,56(sp)
    3892:	f822                	sd	s0,48(sp)
    3894:	f426                	sd	s1,40(sp)
    3896:	f04a                	sd	s2,32(sp)
    3898:	ec4e                	sd	s3,24(sp)
    389a:	e852                	sd	s4,16(sp)
    389c:	0080                	addi	s0,sp,64
    389e:	892a                	mv	s2,a0
  pid1 = fork();
    38a0:	654010ef          	jal	4ef4 <fork>
  if(pid1 < 0) {
    38a4:	00054563          	bltz	a0,38ae <preempt+0x20>
    38a8:	84aa                	mv	s1,a0
  if(pid1 == 0)
    38aa:	ed01                	bnez	a0,38c2 <preempt+0x34>
    for(;;)
    38ac:	a001                	j	38ac <preempt+0x1e>
    printf("%s: fork failed", s);
    38ae:	85ca                	mv	a1,s2
    38b0:	00002517          	auipc	a0,0x2
    38b4:	79850513          	addi	a0,a0,1944 # 6048 <statistics+0xafe>
    38b8:	2e5010ef          	jal	539c <printf>
    exit(1);
    38bc:	4505                	li	a0,1
    38be:	63e010ef          	jal	4efc <exit>
  pid2 = fork();
    38c2:	632010ef          	jal	4ef4 <fork>
    38c6:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    38c8:	00054463          	bltz	a0,38d0 <preempt+0x42>
  if(pid2 == 0)
    38cc:	ed01                	bnez	a0,38e4 <preempt+0x56>
    for(;;)
    38ce:	a001                	j	38ce <preempt+0x40>
    printf("%s: fork failed\n", s);
    38d0:	85ca                	mv	a1,s2
    38d2:	00002517          	auipc	a0,0x2
    38d6:	5b650513          	addi	a0,a0,1462 # 5e88 <statistics+0x93e>
    38da:	2c3010ef          	jal	539c <printf>
    exit(1);
    38de:	4505                	li	a0,1
    38e0:	61c010ef          	jal	4efc <exit>
  pipe(pfds);
    38e4:	fc840513          	addi	a0,s0,-56
    38e8:	624010ef          	jal	4f0c <pipe>
  pid3 = fork();
    38ec:	608010ef          	jal	4ef4 <fork>
    38f0:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    38f2:	02054863          	bltz	a0,3922 <preempt+0x94>
  if(pid3 == 0){
    38f6:	e921                	bnez	a0,3946 <preempt+0xb8>
    close(pfds[0]);
    38f8:	fc842503          	lw	a0,-56(s0)
    38fc:	628010ef          	jal	4f24 <close>
    if(write(pfds[1], "x", 1) != 1)
    3900:	4605                	li	a2,1
    3902:	00002597          	auipc	a1,0x2
    3906:	d6658593          	addi	a1,a1,-666 # 5668 <statistics+0x11e>
    390a:	fcc42503          	lw	a0,-52(s0)
    390e:	60e010ef          	jal	4f1c <write>
    3912:	4785                	li	a5,1
    3914:	02f51163          	bne	a0,a5,3936 <preempt+0xa8>
    close(pfds[1]);
    3918:	fcc42503          	lw	a0,-52(s0)
    391c:	608010ef          	jal	4f24 <close>
    for(;;)
    3920:	a001                	j	3920 <preempt+0x92>
     printf("%s: fork failed\n", s);
    3922:	85ca                	mv	a1,s2
    3924:	00002517          	auipc	a0,0x2
    3928:	56450513          	addi	a0,a0,1380 # 5e88 <statistics+0x93e>
    392c:	271010ef          	jal	539c <printf>
     exit(1);
    3930:	4505                	li	a0,1
    3932:	5ca010ef          	jal	4efc <exit>
      printf("%s: preempt write error", s);
    3936:	85ca                	mv	a1,s2
    3938:	00003517          	auipc	a0,0x3
    393c:	75850513          	addi	a0,a0,1880 # 7090 <statistics+0x1b46>
    3940:	25d010ef          	jal	539c <printf>
    3944:	bfd1                	j	3918 <preempt+0x8a>
  close(pfds[1]);
    3946:	fcc42503          	lw	a0,-52(s0)
    394a:	5da010ef          	jal	4f24 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    394e:	660d                	lui	a2,0x3
    3950:	00008597          	auipc	a1,0x8
    3954:	35858593          	addi	a1,a1,856 # bca8 <buf>
    3958:	fc842503          	lw	a0,-56(s0)
    395c:	5b8010ef          	jal	4f14 <read>
    3960:	4785                	li	a5,1
    3962:	00f50a63          	beq	a0,a5,3976 <preempt+0xe8>
    printf("%s: preempt read error", s);
    3966:	85ca                	mv	a1,s2
    3968:	00003517          	auipc	a0,0x3
    396c:	74050513          	addi	a0,a0,1856 # 70a8 <statistics+0x1b5e>
    3970:	22d010ef          	jal	539c <printf>
    return;
    3974:	a099                	j	39ba <preempt+0x12c>
  close(pfds[0]);
    3976:	fc842503          	lw	a0,-56(s0)
    397a:	5aa010ef          	jal	4f24 <close>
  printf("kill... ");
    397e:	00003517          	auipc	a0,0x3
    3982:	74250513          	addi	a0,a0,1858 # 70c0 <statistics+0x1b76>
    3986:	217010ef          	jal	539c <printf>
  kill(pid1);
    398a:	8526                	mv	a0,s1
    398c:	5a0010ef          	jal	4f2c <kill>
  kill(pid2);
    3990:	854e                	mv	a0,s3
    3992:	59a010ef          	jal	4f2c <kill>
  kill(pid3);
    3996:	8552                	mv	a0,s4
    3998:	594010ef          	jal	4f2c <kill>
  printf("wait... ");
    399c:	00003517          	auipc	a0,0x3
    39a0:	73450513          	addi	a0,a0,1844 # 70d0 <statistics+0x1b86>
    39a4:	1f9010ef          	jal	539c <printf>
  wait(0);
    39a8:	4501                	li	a0,0
    39aa:	55a010ef          	jal	4f04 <wait>
  wait(0);
    39ae:	4501                	li	a0,0
    39b0:	554010ef          	jal	4f04 <wait>
  wait(0);
    39b4:	4501                	li	a0,0
    39b6:	54e010ef          	jal	4f04 <wait>
}
    39ba:	70e2                	ld	ra,56(sp)
    39bc:	7442                	ld	s0,48(sp)
    39be:	74a2                	ld	s1,40(sp)
    39c0:	7902                	ld	s2,32(sp)
    39c2:	69e2                	ld	s3,24(sp)
    39c4:	6a42                	ld	s4,16(sp)
    39c6:	6121                	addi	sp,sp,64
    39c8:	8082                	ret

00000000000039ca <reparent>:
{
    39ca:	7179                	addi	sp,sp,-48
    39cc:	f406                	sd	ra,40(sp)
    39ce:	f022                	sd	s0,32(sp)
    39d0:	ec26                	sd	s1,24(sp)
    39d2:	e84a                	sd	s2,16(sp)
    39d4:	e44e                	sd	s3,8(sp)
    39d6:	e052                	sd	s4,0(sp)
    39d8:	1800                	addi	s0,sp,48
    39da:	89aa                	mv	s3,a0
  int master_pid = getpid();
    39dc:	5a0010ef          	jal	4f7c <getpid>
    39e0:	8a2a                	mv	s4,a0
    39e2:	0c800913          	li	s2,200
    int pid = fork();
    39e6:	50e010ef          	jal	4ef4 <fork>
    39ea:	84aa                	mv	s1,a0
    if(pid < 0){
    39ec:	00054e63          	bltz	a0,3a08 <reparent+0x3e>
    if(pid){
    39f0:	c121                	beqz	a0,3a30 <reparent+0x66>
      if(wait(0) != pid){
    39f2:	4501                	li	a0,0
    39f4:	510010ef          	jal	4f04 <wait>
    39f8:	02951263          	bne	a0,s1,3a1c <reparent+0x52>
  for(int i = 0; i < 200; i++){
    39fc:	397d                	addiw	s2,s2,-1
    39fe:	fe0914e3          	bnez	s2,39e6 <reparent+0x1c>
  exit(0);
    3a02:	4501                	li	a0,0
    3a04:	4f8010ef          	jal	4efc <exit>
      printf("%s: fork failed\n", s);
    3a08:	85ce                	mv	a1,s3
    3a0a:	00002517          	auipc	a0,0x2
    3a0e:	47e50513          	addi	a0,a0,1150 # 5e88 <statistics+0x93e>
    3a12:	18b010ef          	jal	539c <printf>
      exit(1);
    3a16:	4505                	li	a0,1
    3a18:	4e4010ef          	jal	4efc <exit>
        printf("%s: wait wrong pid\n", s);
    3a1c:	85ce                	mv	a1,s3
    3a1e:	00002517          	auipc	a0,0x2
    3a22:	5f250513          	addi	a0,a0,1522 # 6010 <statistics+0xac6>
    3a26:	177010ef          	jal	539c <printf>
        exit(1);
    3a2a:	4505                	li	a0,1
    3a2c:	4d0010ef          	jal	4efc <exit>
      int pid2 = fork();
    3a30:	4c4010ef          	jal	4ef4 <fork>
      if(pid2 < 0){
    3a34:	00054563          	bltz	a0,3a3e <reparent+0x74>
      exit(0);
    3a38:	4501                	li	a0,0
    3a3a:	4c2010ef          	jal	4efc <exit>
        kill(master_pid);
    3a3e:	8552                	mv	a0,s4
    3a40:	4ec010ef          	jal	4f2c <kill>
        exit(1);
    3a44:	4505                	li	a0,1
    3a46:	4b6010ef          	jal	4efc <exit>

0000000000003a4a <sbrkfail>:
{
    3a4a:	7175                	addi	sp,sp,-144
    3a4c:	e506                	sd	ra,136(sp)
    3a4e:	e122                	sd	s0,128(sp)
    3a50:	fca6                	sd	s1,120(sp)
    3a52:	f8ca                	sd	s2,112(sp)
    3a54:	f4ce                	sd	s3,104(sp)
    3a56:	f0d2                	sd	s4,96(sp)
    3a58:	ecd6                	sd	s5,88(sp)
    3a5a:	e8da                	sd	s6,80(sp)
    3a5c:	e4de                	sd	s7,72(sp)
    3a5e:	e0e2                	sd	s8,64(sp)
    3a60:	0900                	addi	s0,sp,144
    3a62:	8c2a                	mv	s8,a0
  if(pipe(fds) != 0){
    3a64:	fa040513          	addi	a0,s0,-96
    3a68:	4a4010ef          	jal	4f0c <pipe>
    3a6c:	ed01                	bnez	a0,3a84 <sbrkfail+0x3a>
    3a6e:	8baa                	mv	s7,a0
    3a70:	f7040493          	addi	s1,s0,-144
    3a74:	f9840993          	addi	s3,s0,-104
    3a78:	8926                	mv	s2,s1
    if(pids[i] != -1) {
    3a7a:	5a7d                	li	s4,-1
      read(fds[0], &scratch, 1);
    3a7c:	f9f40b13          	addi	s6,s0,-97
    3a80:	4a85                	li	s5,1
    3a82:	a095                	j	3ae6 <sbrkfail+0x9c>
    printf("%s: pipe() failed\n", s);
    3a84:	85e2                	mv	a1,s8
    3a86:	00002517          	auipc	a0,0x2
    3a8a:	50a50513          	addi	a0,a0,1290 # 5f90 <statistics+0xa46>
    3a8e:	10f010ef          	jal	539c <printf>
    exit(1);
    3a92:	4505                	li	a0,1
    3a94:	468010ef          	jal	4efc <exit>
      if (sbrk(BIG - (uint64)sbrk(0)) ==  (char*)SBRK_ERROR)
    3a98:	430010ef          	jal	4ec8 <sbrk>
    3a9c:	064007b7          	lui	a5,0x6400
    3aa0:	40a7853b          	subw	a0,a5,a0
    3aa4:	424010ef          	jal	4ec8 <sbrk>
    3aa8:	57fd                	li	a5,-1
    3aaa:	02f50163          	beq	a0,a5,3acc <sbrkfail+0x82>
        write(fds[1], "1", 1);
    3aae:	4605                	li	a2,1
    3ab0:	00004597          	auipc	a1,0x4
    3ab4:	cc058593          	addi	a1,a1,-832 # 7770 <statistics+0x2226>
    3ab8:	fa442503          	lw	a0,-92(s0)
    3abc:	460010ef          	jal	4f1c <write>
      for(;;) pause(1000);
    3ac0:	3e800493          	li	s1,1000
    3ac4:	8526                	mv	a0,s1
    3ac6:	4c6010ef          	jal	4f8c <pause>
    3aca:	bfed                	j	3ac4 <sbrkfail+0x7a>
        write(fds[1], "0", 1);
    3acc:	4605                	li	a2,1
    3ace:	00003597          	auipc	a1,0x3
    3ad2:	61258593          	addi	a1,a1,1554 # 70e0 <statistics+0x1b96>
    3ad6:	fa442503          	lw	a0,-92(s0)
    3ada:	442010ef          	jal	4f1c <write>
    3ade:	b7cd                	j	3ac0 <sbrkfail+0x76>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3ae0:	0911                	addi	s2,s2,4
    3ae2:	03390a63          	beq	s2,s3,3b16 <sbrkfail+0xcc>
    if((pids[i] = fork()) == 0){
    3ae6:	40e010ef          	jal	4ef4 <fork>
    3aea:	00a92023          	sw	a0,0(s2)
    3aee:	d54d                	beqz	a0,3a98 <sbrkfail+0x4e>
    if(pids[i] != -1) {
    3af0:	ff4508e3          	beq	a0,s4,3ae0 <sbrkfail+0x96>
      read(fds[0], &scratch, 1);
    3af4:	8656                	mv	a2,s5
    3af6:	85da                	mv	a1,s6
    3af8:	fa042503          	lw	a0,-96(s0)
    3afc:	418010ef          	jal	4f14 <read>
      if(scratch == '0')
    3b00:	f9f44783          	lbu	a5,-97(s0)
    3b04:	fd078793          	addi	a5,a5,-48 # 63fffd0 <base+0x63f1328>
    3b08:	0017b793          	seqz	a5,a5
    3b0c:	00fbe7b3          	or	a5,s7,a5
    3b10:	00078b9b          	sext.w	s7,a5
    3b14:	b7f1                	j	3ae0 <sbrkfail+0x96>
  if(!failed) {
    3b16:	000b8863          	beqz	s7,3b26 <sbrkfail+0xdc>
  c = sbrk(PGSIZE);
    3b1a:	6505                	lui	a0,0x1
    3b1c:	3ac010ef          	jal	4ec8 <sbrk>
    3b20:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    3b22:	597d                	li	s2,-1
    3b24:	a821                	j	3b3c <sbrkfail+0xf2>
    printf("%s: no allocation failed; allocate more?\n", s);
    3b26:	85e2                	mv	a1,s8
    3b28:	00003517          	auipc	a0,0x3
    3b2c:	5c050513          	addi	a0,a0,1472 # 70e8 <statistics+0x1b9e>
    3b30:	06d010ef          	jal	539c <printf>
    3b34:	b7dd                	j	3b1a <sbrkfail+0xd0>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3b36:	0491                	addi	s1,s1,4
    3b38:	01348b63          	beq	s1,s3,3b4e <sbrkfail+0x104>
    if(pids[i] == -1)
    3b3c:	4088                	lw	a0,0(s1)
    3b3e:	ff250ce3          	beq	a0,s2,3b36 <sbrkfail+0xec>
    kill(pids[i]);
    3b42:	3ea010ef          	jal	4f2c <kill>
    wait(0);
    3b46:	4501                	li	a0,0
    3b48:	3bc010ef          	jal	4f04 <wait>
    3b4c:	b7ed                	j	3b36 <sbrkfail+0xec>
  if(c == (char*)SBRK_ERROR){
    3b4e:	57fd                	li	a5,-1
    3b50:	02fa0a63          	beq	s4,a5,3b84 <sbrkfail+0x13a>
  pid = fork();
    3b54:	3a0010ef          	jal	4ef4 <fork>
  if(pid < 0){
    3b58:	04054063          	bltz	a0,3b98 <sbrkfail+0x14e>
  if(pid == 0){
    3b5c:	e939                	bnez	a0,3bb2 <sbrkfail+0x168>
    a = sbrk(10*BIG);
    3b5e:	3e800537          	lui	a0,0x3e800
    3b62:	366010ef          	jal	4ec8 <sbrk>
    if(a == (char*)SBRK_ERROR){
    3b66:	57fd                	li	a5,-1
    3b68:	04f50263          	beq	a0,a5,3bac <sbrkfail+0x162>
    printf("%s: allocate a lot of memory succeeded %d\n", s, 10*BIG);
    3b6c:	3e800637          	lui	a2,0x3e800
    3b70:	85e2                	mv	a1,s8
    3b72:	00003517          	auipc	a0,0x3
    3b76:	5c650513          	addi	a0,a0,1478 # 7138 <statistics+0x1bee>
    3b7a:	023010ef          	jal	539c <printf>
    exit(1);
    3b7e:	4505                	li	a0,1
    3b80:	37c010ef          	jal	4efc <exit>
    printf("%s: failed sbrk leaked memory\n", s);
    3b84:	85e2                	mv	a1,s8
    3b86:	00003517          	auipc	a0,0x3
    3b8a:	59250513          	addi	a0,a0,1426 # 7118 <statistics+0x1bce>
    3b8e:	00f010ef          	jal	539c <printf>
    exit(1);
    3b92:	4505                	li	a0,1
    3b94:	368010ef          	jal	4efc <exit>
    printf("%s: fork failed\n", s);
    3b98:	85e2                	mv	a1,s8
    3b9a:	00002517          	auipc	a0,0x2
    3b9e:	2ee50513          	addi	a0,a0,750 # 5e88 <statistics+0x93e>
    3ba2:	7fa010ef          	jal	539c <printf>
    exit(1);
    3ba6:	4505                	li	a0,1
    3ba8:	354010ef          	jal	4efc <exit>
      exit(0);
    3bac:	4501                	li	a0,0
    3bae:	34e010ef          	jal	4efc <exit>
  wait(&xstatus);
    3bb2:	fac40513          	addi	a0,s0,-84
    3bb6:	34e010ef          	jal	4f04 <wait>
  if(xstatus != 0)
    3bba:	fac42783          	lw	a5,-84(s0)
    3bbe:	ef89                	bnez	a5,3bd8 <sbrkfail+0x18e>
}
    3bc0:	60aa                	ld	ra,136(sp)
    3bc2:	640a                	ld	s0,128(sp)
    3bc4:	74e6                	ld	s1,120(sp)
    3bc6:	7946                	ld	s2,112(sp)
    3bc8:	79a6                	ld	s3,104(sp)
    3bca:	7a06                	ld	s4,96(sp)
    3bcc:	6ae6                	ld	s5,88(sp)
    3bce:	6b46                	ld	s6,80(sp)
    3bd0:	6ba6                	ld	s7,72(sp)
    3bd2:	6c06                	ld	s8,64(sp)
    3bd4:	6149                	addi	sp,sp,144
    3bd6:	8082                	ret
    exit(1);
    3bd8:	4505                	li	a0,1
    3bda:	322010ef          	jal	4efc <exit>

0000000000003bde <mem>:
{
    3bde:	7139                	addi	sp,sp,-64
    3be0:	fc06                	sd	ra,56(sp)
    3be2:	f822                	sd	s0,48(sp)
    3be4:	f426                	sd	s1,40(sp)
    3be6:	f04a                	sd	s2,32(sp)
    3be8:	ec4e                	sd	s3,24(sp)
    3bea:	0080                	addi	s0,sp,64
    3bec:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    3bee:	306010ef          	jal	4ef4 <fork>
    m1 = 0;
    3bf2:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    3bf4:	6909                	lui	s2,0x2
    3bf6:	71190913          	addi	s2,s2,1809 # 2711 <execout+0x2b>
  if((pid = fork()) == 0){
    3bfa:	cd11                	beqz	a0,3c16 <mem+0x38>
    wait(&xstatus);
    3bfc:	fcc40513          	addi	a0,s0,-52
    3c00:	304010ef          	jal	4f04 <wait>
    if(xstatus == -1){
    3c04:	fcc42503          	lw	a0,-52(s0)
    3c08:	57fd                	li	a5,-1
    3c0a:	04f50363          	beq	a0,a5,3c50 <mem+0x72>
    exit(xstatus);
    3c0e:	2ee010ef          	jal	4efc <exit>
      *(char**)m2 = m1;
    3c12:	e104                	sd	s1,0(a0)
      m1 = m2;
    3c14:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    3c16:	854a                	mv	a0,s2
    3c18:	041010ef          	jal	5458 <malloc>
    3c1c:	f97d                	bnez	a0,3c12 <mem+0x34>
    while(m1){
    3c1e:	c491                	beqz	s1,3c2a <mem+0x4c>
      m2 = *(char**)m1;
    3c20:	8526                	mv	a0,s1
    3c22:	6084                	ld	s1,0(s1)
      free(m1);
    3c24:	7aa010ef          	jal	53ce <free>
    while(m1){
    3c28:	fce5                	bnez	s1,3c20 <mem+0x42>
    m1 = malloc(1024*20);
    3c2a:	6515                	lui	a0,0x5
    3c2c:	02d010ef          	jal	5458 <malloc>
    if(m1 == 0){
    3c30:	c511                	beqz	a0,3c3c <mem+0x5e>
    free(m1);
    3c32:	79c010ef          	jal	53ce <free>
    exit(0);
    3c36:	4501                	li	a0,0
    3c38:	2c4010ef          	jal	4efc <exit>
      printf("%s: couldn't allocate mem?!!\n", s);
    3c3c:	85ce                	mv	a1,s3
    3c3e:	00003517          	auipc	a0,0x3
    3c42:	52a50513          	addi	a0,a0,1322 # 7168 <statistics+0x1c1e>
    3c46:	756010ef          	jal	539c <printf>
      exit(1);
    3c4a:	4505                	li	a0,1
    3c4c:	2b0010ef          	jal	4efc <exit>
      exit(0);
    3c50:	4501                	li	a0,0
    3c52:	2aa010ef          	jal	4efc <exit>

0000000000003c56 <sharedfd>:
{
    3c56:	7159                	addi	sp,sp,-112
    3c58:	f486                	sd	ra,104(sp)
    3c5a:	f0a2                	sd	s0,96(sp)
    3c5c:	eca6                	sd	s1,88(sp)
    3c5e:	f85a                	sd	s6,48(sp)
    3c60:	1880                	addi	s0,sp,112
    3c62:	84aa                	mv	s1,a0
    3c64:	8b2a                	mv	s6,a0
  unlink("sharedfd");
    3c66:	00003517          	auipc	a0,0x3
    3c6a:	52250513          	addi	a0,a0,1314 # 7188 <statistics+0x1c3e>
    3c6e:	2de010ef          	jal	4f4c <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    3c72:	20200593          	li	a1,514
    3c76:	00003517          	auipc	a0,0x3
    3c7a:	51250513          	addi	a0,a0,1298 # 7188 <statistics+0x1c3e>
    3c7e:	2be010ef          	jal	4f3c <open>
  if(fd < 0){
    3c82:	04054863          	bltz	a0,3cd2 <sharedfd+0x7c>
    3c86:	e8ca                	sd	s2,80(sp)
    3c88:	e4ce                	sd	s3,72(sp)
    3c8a:	e0d2                	sd	s4,64(sp)
    3c8c:	fc56                	sd	s5,56(sp)
    3c8e:	89aa                	mv	s3,a0
  pid = fork();
    3c90:	264010ef          	jal	4ef4 <fork>
    3c94:	8aaa                	mv	s5,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    3c96:	07000593          	li	a1,112
    3c9a:	e119                	bnez	a0,3ca0 <sharedfd+0x4a>
    3c9c:	06300593          	li	a1,99
    3ca0:	4629                	li	a2,10
    3ca2:	fa040513          	addi	a0,s0,-96
    3ca6:	02c010ef          	jal	4cd2 <memset>
    3caa:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    3cae:	fa040a13          	addi	s4,s0,-96
    3cb2:	4929                	li	s2,10
    3cb4:	864a                	mv	a2,s2
    3cb6:	85d2                	mv	a1,s4
    3cb8:	854e                	mv	a0,s3
    3cba:	262010ef          	jal	4f1c <write>
    3cbe:	03251963          	bne	a0,s2,3cf0 <sharedfd+0x9a>
  for(i = 0; i < N; i++){
    3cc2:	34fd                	addiw	s1,s1,-1
    3cc4:	f8e5                	bnez	s1,3cb4 <sharedfd+0x5e>
  if(pid == 0) {
    3cc6:	040a9063          	bnez	s5,3d06 <sharedfd+0xb0>
    3cca:	f45e                	sd	s7,40(sp)
    exit(0);
    3ccc:	4501                	li	a0,0
    3cce:	22e010ef          	jal	4efc <exit>
    3cd2:	e8ca                	sd	s2,80(sp)
    3cd4:	e4ce                	sd	s3,72(sp)
    3cd6:	e0d2                	sd	s4,64(sp)
    3cd8:	fc56                	sd	s5,56(sp)
    3cda:	f45e                	sd	s7,40(sp)
    printf("%s: cannot open sharedfd for writing", s);
    3cdc:	85a6                	mv	a1,s1
    3cde:	00003517          	auipc	a0,0x3
    3ce2:	4ba50513          	addi	a0,a0,1210 # 7198 <statistics+0x1c4e>
    3ce6:	6b6010ef          	jal	539c <printf>
    exit(1);
    3cea:	4505                	li	a0,1
    3cec:	210010ef          	jal	4efc <exit>
    3cf0:	f45e                	sd	s7,40(sp)
      printf("%s: write sharedfd failed\n", s);
    3cf2:	85da                	mv	a1,s6
    3cf4:	00003517          	auipc	a0,0x3
    3cf8:	4cc50513          	addi	a0,a0,1228 # 71c0 <statistics+0x1c76>
    3cfc:	6a0010ef          	jal	539c <printf>
      exit(1);
    3d00:	4505                	li	a0,1
    3d02:	1fa010ef          	jal	4efc <exit>
    wait(&xstatus);
    3d06:	f9c40513          	addi	a0,s0,-100
    3d0a:	1fa010ef          	jal	4f04 <wait>
    if(xstatus != 0)
    3d0e:	f9c42a03          	lw	s4,-100(s0)
    3d12:	000a0663          	beqz	s4,3d1e <sharedfd+0xc8>
    3d16:	f45e                	sd	s7,40(sp)
      exit(xstatus);
    3d18:	8552                	mv	a0,s4
    3d1a:	1e2010ef          	jal	4efc <exit>
    3d1e:	f45e                	sd	s7,40(sp)
  close(fd);
    3d20:	854e                	mv	a0,s3
    3d22:	202010ef          	jal	4f24 <close>
  fd = open("sharedfd", 0);
    3d26:	4581                	li	a1,0
    3d28:	00003517          	auipc	a0,0x3
    3d2c:	46050513          	addi	a0,a0,1120 # 7188 <statistics+0x1c3e>
    3d30:	20c010ef          	jal	4f3c <open>
    3d34:	8baa                	mv	s7,a0
  nc = np = 0;
    3d36:	89d2                	mv	s3,s4
  if(fd < 0){
    3d38:	02054363          	bltz	a0,3d5e <sharedfd+0x108>
    3d3c:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    3d40:	06300493          	li	s1,99
      if(buf[i] == 'p')
    3d44:	07000a93          	li	s5,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    3d48:	4629                	li	a2,10
    3d4a:	fa040593          	addi	a1,s0,-96
    3d4e:	855e                	mv	a0,s7
    3d50:	1c4010ef          	jal	4f14 <read>
    3d54:	02a05b63          	blez	a0,3d8a <sharedfd+0x134>
    3d58:	fa040793          	addi	a5,s0,-96
    3d5c:	a839                	j	3d7a <sharedfd+0x124>
    printf("%s: cannot open sharedfd for reading\n", s);
    3d5e:	85da                	mv	a1,s6
    3d60:	00003517          	auipc	a0,0x3
    3d64:	48050513          	addi	a0,a0,1152 # 71e0 <statistics+0x1c96>
    3d68:	634010ef          	jal	539c <printf>
    exit(1);
    3d6c:	4505                	li	a0,1
    3d6e:	18e010ef          	jal	4efc <exit>
        nc++;
    3d72:	2a05                	addiw	s4,s4,1
    for(i = 0; i < sizeof(buf); i++){
    3d74:	0785                	addi	a5,a5,1
    3d76:	fd2789e3          	beq	a5,s2,3d48 <sharedfd+0xf2>
      if(buf[i] == 'c')
    3d7a:	0007c703          	lbu	a4,0(a5)
    3d7e:	fe970ae3          	beq	a4,s1,3d72 <sharedfd+0x11c>
      if(buf[i] == 'p')
    3d82:	ff5719e3          	bne	a4,s5,3d74 <sharedfd+0x11e>
        np++;
    3d86:	2985                	addiw	s3,s3,1
    3d88:	b7f5                	j	3d74 <sharedfd+0x11e>
  close(fd);
    3d8a:	855e                	mv	a0,s7
    3d8c:	198010ef          	jal	4f24 <close>
  unlink("sharedfd");
    3d90:	00003517          	auipc	a0,0x3
    3d94:	3f850513          	addi	a0,a0,1016 # 7188 <statistics+0x1c3e>
    3d98:	1b4010ef          	jal	4f4c <unlink>
  if(nc == N*SZ && np == N*SZ){
    3d9c:	6789                	lui	a5,0x2
    3d9e:	71078793          	addi	a5,a5,1808 # 2710 <execout+0x2a>
    3da2:	00fa1763          	bne	s4,a5,3db0 <sharedfd+0x15a>
    3da6:	01499563          	bne	s3,s4,3db0 <sharedfd+0x15a>
    exit(0);
    3daa:	4501                	li	a0,0
    3dac:	150010ef          	jal	4efc <exit>
    printf("%s: nc/np test fails\n", s);
    3db0:	85da                	mv	a1,s6
    3db2:	00003517          	auipc	a0,0x3
    3db6:	45650513          	addi	a0,a0,1110 # 7208 <statistics+0x1cbe>
    3dba:	5e2010ef          	jal	539c <printf>
    exit(1);
    3dbe:	4505                	li	a0,1
    3dc0:	13c010ef          	jal	4efc <exit>

0000000000003dc4 <fourfiles>:
{
    3dc4:	7135                	addi	sp,sp,-160
    3dc6:	ed06                	sd	ra,152(sp)
    3dc8:	e922                	sd	s0,144(sp)
    3dca:	e526                	sd	s1,136(sp)
    3dcc:	e14a                	sd	s2,128(sp)
    3dce:	fcce                	sd	s3,120(sp)
    3dd0:	f8d2                	sd	s4,112(sp)
    3dd2:	f4d6                	sd	s5,104(sp)
    3dd4:	f0da                	sd	s6,96(sp)
    3dd6:	ecde                	sd	s7,88(sp)
    3dd8:	e8e2                	sd	s8,80(sp)
    3dda:	e4e6                	sd	s9,72(sp)
    3ddc:	e0ea                	sd	s10,64(sp)
    3dde:	fc6e                	sd	s11,56(sp)
    3de0:	1100                	addi	s0,sp,160
    3de2:	8caa                	mv	s9,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    3de4:	00003797          	auipc	a5,0x3
    3de8:	43c78793          	addi	a5,a5,1084 # 7220 <statistics+0x1cd6>
    3dec:	f6f43823          	sd	a5,-144(s0)
    3df0:	00003797          	auipc	a5,0x3
    3df4:	43878793          	addi	a5,a5,1080 # 7228 <statistics+0x1cde>
    3df8:	f6f43c23          	sd	a5,-136(s0)
    3dfc:	00003797          	auipc	a5,0x3
    3e00:	43478793          	addi	a5,a5,1076 # 7230 <statistics+0x1ce6>
    3e04:	f8f43023          	sd	a5,-128(s0)
    3e08:	00003797          	auipc	a5,0x3
    3e0c:	43078793          	addi	a5,a5,1072 # 7238 <statistics+0x1cee>
    3e10:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    3e14:	f7040b93          	addi	s7,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    3e18:	895e                	mv	s2,s7
  for(pi = 0; pi < NCHILD; pi++){
    3e1a:	4481                	li	s1,0
    3e1c:	4a11                	li	s4,4
    fname = names[pi];
    3e1e:	00093983          	ld	s3,0(s2)
    unlink(fname);
    3e22:	854e                	mv	a0,s3
    3e24:	128010ef          	jal	4f4c <unlink>
    pid = fork();
    3e28:	0cc010ef          	jal	4ef4 <fork>
    if(pid < 0){
    3e2c:	04054063          	bltz	a0,3e6c <fourfiles+0xa8>
    if(pid == 0){
    3e30:	c921                	beqz	a0,3e80 <fourfiles+0xbc>
  for(pi = 0; pi < NCHILD; pi++){
    3e32:	2485                	addiw	s1,s1,1
    3e34:	0921                	addi	s2,s2,8
    3e36:	ff4494e3          	bne	s1,s4,3e1e <fourfiles+0x5a>
    3e3a:	4491                	li	s1,4
    wait(&xstatus);
    3e3c:	f6c40913          	addi	s2,s0,-148
    3e40:	854a                	mv	a0,s2
    3e42:	0c2010ef          	jal	4f04 <wait>
    if(xstatus != 0)
    3e46:	f6c42b03          	lw	s6,-148(s0)
    3e4a:	0a0b1463          	bnez	s6,3ef2 <fourfiles+0x12e>
  for(pi = 0; pi < NCHILD; pi++){
    3e4e:	34fd                	addiw	s1,s1,-1
    3e50:	f8e5                	bnez	s1,3e40 <fourfiles+0x7c>
    3e52:	03000493          	li	s1,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3e56:	6a8d                	lui	s5,0x3
    3e58:	00008a17          	auipc	s4,0x8
    3e5c:	e50a0a13          	addi	s4,s4,-432 # bca8 <buf>
    if(total != N*SZ){
    3e60:	6d05                	lui	s10,0x1
    3e62:	770d0d13          	addi	s10,s10,1904 # 1770 <exitwait+0x90>
  for(i = 0; i < NCHILD; i++){
    3e66:	03400d93          	li	s11,52
    3e6a:	a86d                	j	3f24 <fourfiles+0x160>
      printf("%s: fork failed\n", s);
    3e6c:	85e6                	mv	a1,s9
    3e6e:	00002517          	auipc	a0,0x2
    3e72:	01a50513          	addi	a0,a0,26 # 5e88 <statistics+0x93e>
    3e76:	526010ef          	jal	539c <printf>
      exit(1);
    3e7a:	4505                	li	a0,1
    3e7c:	080010ef          	jal	4efc <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    3e80:	20200593          	li	a1,514
    3e84:	854e                	mv	a0,s3
    3e86:	0b6010ef          	jal	4f3c <open>
    3e8a:	892a                	mv	s2,a0
      if(fd < 0){
    3e8c:	04054063          	bltz	a0,3ecc <fourfiles+0x108>
      memset(buf, '0'+pi, SZ);
    3e90:	1f400613          	li	a2,500
    3e94:	0304859b          	addiw	a1,s1,48
    3e98:	00008517          	auipc	a0,0x8
    3e9c:	e1050513          	addi	a0,a0,-496 # bca8 <buf>
    3ea0:	633000ef          	jal	4cd2 <memset>
    3ea4:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    3ea6:	1f400993          	li	s3,500
    3eaa:	00008a17          	auipc	s4,0x8
    3eae:	dfea0a13          	addi	s4,s4,-514 # bca8 <buf>
    3eb2:	864e                	mv	a2,s3
    3eb4:	85d2                	mv	a1,s4
    3eb6:	854a                	mv	a0,s2
    3eb8:	064010ef          	jal	4f1c <write>
    3ebc:	85aa                	mv	a1,a0
    3ebe:	03351163          	bne	a0,s3,3ee0 <fourfiles+0x11c>
      for(i = 0; i < N; i++){
    3ec2:	34fd                	addiw	s1,s1,-1
    3ec4:	f4fd                	bnez	s1,3eb2 <fourfiles+0xee>
      exit(0);
    3ec6:	4501                	li	a0,0
    3ec8:	034010ef          	jal	4efc <exit>
        printf("%s: create failed\n", s);
    3ecc:	85e6                	mv	a1,s9
    3ece:	00002517          	auipc	a0,0x2
    3ed2:	05250513          	addi	a0,a0,82 # 5f20 <statistics+0x9d6>
    3ed6:	4c6010ef          	jal	539c <printf>
        exit(1);
    3eda:	4505                	li	a0,1
    3edc:	020010ef          	jal	4efc <exit>
          printf("write failed %d\n", n);
    3ee0:	00003517          	auipc	a0,0x3
    3ee4:	36050513          	addi	a0,a0,864 # 7240 <statistics+0x1cf6>
    3ee8:	4b4010ef          	jal	539c <printf>
          exit(1);
    3eec:	4505                	li	a0,1
    3eee:	00e010ef          	jal	4efc <exit>
      exit(xstatus);
    3ef2:	855a                	mv	a0,s6
    3ef4:	008010ef          	jal	4efc <exit>
          printf("%s: wrong char\n", s);
    3ef8:	85e6                	mv	a1,s9
    3efa:	00003517          	auipc	a0,0x3
    3efe:	35e50513          	addi	a0,a0,862 # 7258 <statistics+0x1d0e>
    3f02:	49a010ef          	jal	539c <printf>
          exit(1);
    3f06:	4505                	li	a0,1
    3f08:	7f5000ef          	jal	4efc <exit>
    close(fd);
    3f0c:	854e                	mv	a0,s3
    3f0e:	016010ef          	jal	4f24 <close>
    if(total != N*SZ){
    3f12:	05a91863          	bne	s2,s10,3f62 <fourfiles+0x19e>
    unlink(fname);
    3f16:	8562                	mv	a0,s8
    3f18:	034010ef          	jal	4f4c <unlink>
  for(i = 0; i < NCHILD; i++){
    3f1c:	0ba1                	addi	s7,s7,8
    3f1e:	2485                	addiw	s1,s1,1
    3f20:	05b48b63          	beq	s1,s11,3f76 <fourfiles+0x1b2>
    fname = names[i];
    3f24:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    3f28:	4581                	li	a1,0
    3f2a:	8562                	mv	a0,s8
    3f2c:	010010ef          	jal	4f3c <open>
    3f30:	89aa                	mv	s3,a0
    total = 0;
    3f32:	895a                	mv	s2,s6
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3f34:	8656                	mv	a2,s5
    3f36:	85d2                	mv	a1,s4
    3f38:	854e                	mv	a0,s3
    3f3a:	7db000ef          	jal	4f14 <read>
    3f3e:	fca057e3          	blez	a0,3f0c <fourfiles+0x148>
    3f42:	00008797          	auipc	a5,0x8
    3f46:	d6678793          	addi	a5,a5,-666 # bca8 <buf>
    3f4a:	00f506b3          	add	a3,a0,a5
        if(buf[j] != '0'+i){
    3f4e:	0007c703          	lbu	a4,0(a5)
    3f52:	fa9713e3          	bne	a4,s1,3ef8 <fourfiles+0x134>
      for(j = 0; j < n; j++){
    3f56:	0785                	addi	a5,a5,1
    3f58:	fed79be3          	bne	a5,a3,3f4e <fourfiles+0x18a>
      total += n;
    3f5c:	00a9093b          	addw	s2,s2,a0
    3f60:	bfd1                	j	3f34 <fourfiles+0x170>
      printf("wrong length %d\n", total);
    3f62:	85ca                	mv	a1,s2
    3f64:	00003517          	auipc	a0,0x3
    3f68:	30450513          	addi	a0,a0,772 # 7268 <statistics+0x1d1e>
    3f6c:	430010ef          	jal	539c <printf>
      exit(1);
    3f70:	4505                	li	a0,1
    3f72:	78b000ef          	jal	4efc <exit>
}
    3f76:	60ea                	ld	ra,152(sp)
    3f78:	644a                	ld	s0,144(sp)
    3f7a:	64aa                	ld	s1,136(sp)
    3f7c:	690a                	ld	s2,128(sp)
    3f7e:	79e6                	ld	s3,120(sp)
    3f80:	7a46                	ld	s4,112(sp)
    3f82:	7aa6                	ld	s5,104(sp)
    3f84:	7b06                	ld	s6,96(sp)
    3f86:	6be6                	ld	s7,88(sp)
    3f88:	6c46                	ld	s8,80(sp)
    3f8a:	6ca6                	ld	s9,72(sp)
    3f8c:	6d06                	ld	s10,64(sp)
    3f8e:	7de2                	ld	s11,56(sp)
    3f90:	610d                	addi	sp,sp,160
    3f92:	8082                	ret

0000000000003f94 <concreate>:
{
    3f94:	7171                	addi	sp,sp,-176
    3f96:	f506                	sd	ra,168(sp)
    3f98:	f122                	sd	s0,160(sp)
    3f9a:	ed26                	sd	s1,152(sp)
    3f9c:	e94a                	sd	s2,144(sp)
    3f9e:	e54e                	sd	s3,136(sp)
    3fa0:	e152                	sd	s4,128(sp)
    3fa2:	fcd6                	sd	s5,120(sp)
    3fa4:	f8da                	sd	s6,112(sp)
    3fa6:	f4de                	sd	s7,104(sp)
    3fa8:	f0e2                	sd	s8,96(sp)
    3faa:	ece6                	sd	s9,88(sp)
    3fac:	e8ea                	sd	s10,80(sp)
    3fae:	1900                	addi	s0,sp,176
    3fb0:	8d2a                	mv	s10,a0
  file[0] = 'C';
    3fb2:	04300793          	li	a5,67
    3fb6:	f8f40c23          	sb	a5,-104(s0)
  file[2] = '\0';
    3fba:	f8040d23          	sb	zero,-102(s0)
  for(i = 0; i < N; i++){
    3fbe:	4901                	li	s2,0
    unlink(file);
    3fc0:	f9840993          	addi	s3,s0,-104
    if(pid && (i % 3) == 1){
    3fc4:	55555b37          	lui	s6,0x55555
    3fc8:	556b0b13          	addi	s6,s6,1366 # 55555556 <base+0x555468ae>
    3fcc:	4b85                	li	s7,1
      fd = open(file, O_CREATE | O_RDWR);
    3fce:	20200c13          	li	s8,514
      link("C0", file);
    3fd2:	00003c97          	auipc	s9,0x3
    3fd6:	2aec8c93          	addi	s9,s9,686 # 7280 <statistics+0x1d36>
      wait(&xstatus);
    3fda:	f5c40a93          	addi	s5,s0,-164
  for(i = 0; i < N; i++){
    3fde:	02800a13          	li	s4,40
    3fe2:	a481                	j	4222 <concreate+0x28e>
      link("C0", file);
    3fe4:	85ce                	mv	a1,s3
    3fe6:	8566                	mv	a0,s9
    3fe8:	775000ef          	jal	4f5c <link>
    if(pid == 0) {
    3fec:	a40d                	j	420e <concreate+0x27a>
    } else if(pid == 0 && (i % 5) == 1){
    3fee:	666667b7          	lui	a5,0x66666
    3ff2:	66778793          	addi	a5,a5,1639 # 66666667 <base+0x666579bf>
    3ff6:	02f907b3          	mul	a5,s2,a5
    3ffa:	9785                	srai	a5,a5,0x21
    3ffc:	41f9571b          	sraiw	a4,s2,0x1f
    4000:	9f99                	subw	a5,a5,a4
    4002:	0027971b          	slliw	a4,a5,0x2
    4006:	9fb9                	addw	a5,a5,a4
    4008:	40f9093b          	subw	s2,s2,a5
    400c:	4785                	li	a5,1
    400e:	02f90563          	beq	s2,a5,4038 <concreate+0xa4>
      fd = open(file, O_CREATE | O_RDWR);
    4012:	20200593          	li	a1,514
    4016:	f9840513          	addi	a0,s0,-104
    401a:	723000ef          	jal	4f3c <open>
      if(fd < 0){
    401e:	1e055363          	bgez	a0,4204 <concreate+0x270>
        printf("concreate create %s failed\n", file);
    4022:	f9840593          	addi	a1,s0,-104
    4026:	00003517          	auipc	a0,0x3
    402a:	26250513          	addi	a0,a0,610 # 7288 <statistics+0x1d3e>
    402e:	36e010ef          	jal	539c <printf>
        exit(1);
    4032:	4505                	li	a0,1
    4034:	6c9000ef          	jal	4efc <exit>
      link("C0", file);
    4038:	f9840593          	addi	a1,s0,-104
    403c:	00003517          	auipc	a0,0x3
    4040:	24450513          	addi	a0,a0,580 # 7280 <statistics+0x1d36>
    4044:	719000ef          	jal	4f5c <link>
      exit(0);
    4048:	4501                	li	a0,0
    404a:	6b3000ef          	jal	4efc <exit>
        exit(1);
    404e:	4505                	li	a0,1
    4050:	6ad000ef          	jal	4efc <exit>
  memset(fa, 0, sizeof(fa));
    4054:	02800613          	li	a2,40
    4058:	4581                	li	a1,0
    405a:	f7040513          	addi	a0,s0,-144
    405e:	475000ef          	jal	4cd2 <memset>
  fd = open(".", 0);
    4062:	4581                	li	a1,0
    4064:	00002517          	auipc	a0,0x2
    4068:	c7c50513          	addi	a0,a0,-900 # 5ce0 <statistics+0x796>
    406c:	6d1000ef          	jal	4f3c <open>
    4070:	892a                	mv	s2,a0
  n = 0;
    4072:	8b26                	mv	s6,s1
  while(read(fd, &de, sizeof(de)) > 0){
    4074:	f6040a13          	addi	s4,s0,-160
    4078:	49c1                	li	s3,16
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    407a:	04300a93          	li	s5,67
      if(i < 0 || i >= sizeof(fa)){
    407e:	02700b93          	li	s7,39
      fa[i] = 1;
    4082:	4c05                	li	s8,1
  while(read(fd, &de, sizeof(de)) > 0){
    4084:	864e                	mv	a2,s3
    4086:	85d2                	mv	a1,s4
    4088:	854a                	mv	a0,s2
    408a:	68b000ef          	jal	4f14 <read>
    408e:	06a05763          	blez	a0,40fc <concreate+0x168>
    if(de.inum == 0)
    4092:	f6045783          	lhu	a5,-160(s0)
    4096:	d7fd                	beqz	a5,4084 <concreate+0xf0>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4098:	f6244783          	lbu	a5,-158(s0)
    409c:	ff5794e3          	bne	a5,s5,4084 <concreate+0xf0>
    40a0:	f6444783          	lbu	a5,-156(s0)
    40a4:	f3e5                	bnez	a5,4084 <concreate+0xf0>
      i = de.name[1] - '0';
    40a6:	f6344783          	lbu	a5,-157(s0)
    40aa:	fd07879b          	addiw	a5,a5,-48
      if(i < 0 || i >= sizeof(fa)){
    40ae:	00fbef63          	bltu	s7,a5,40cc <concreate+0x138>
      if(fa[i]){
    40b2:	fa040713          	addi	a4,s0,-96
    40b6:	973e                	add	a4,a4,a5
    40b8:	fd074703          	lbu	a4,-48(a4)
    40bc:	e705                	bnez	a4,40e4 <concreate+0x150>
      fa[i] = 1;
    40be:	fa040713          	addi	a4,s0,-96
    40c2:	97ba                	add	a5,a5,a4
    40c4:	fd878823          	sb	s8,-48(a5)
      n++;
    40c8:	2b05                	addiw	s6,s6,1
    40ca:	bf6d                	j	4084 <concreate+0xf0>
        printf("%s: concreate weird file %s\n", s, de.name);
    40cc:	f6240613          	addi	a2,s0,-158
    40d0:	85ea                	mv	a1,s10
    40d2:	00003517          	auipc	a0,0x3
    40d6:	1d650513          	addi	a0,a0,470 # 72a8 <statistics+0x1d5e>
    40da:	2c2010ef          	jal	539c <printf>
        exit(1);
    40de:	4505                	li	a0,1
    40e0:	61d000ef          	jal	4efc <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    40e4:	f6240613          	addi	a2,s0,-158
    40e8:	85ea                	mv	a1,s10
    40ea:	00003517          	auipc	a0,0x3
    40ee:	1de50513          	addi	a0,a0,478 # 72c8 <statistics+0x1d7e>
    40f2:	2aa010ef          	jal	539c <printf>
        exit(1);
    40f6:	4505                	li	a0,1
    40f8:	605000ef          	jal	4efc <exit>
  close(fd);
    40fc:	854a                	mv	a0,s2
    40fe:	627000ef          	jal	4f24 <close>
  if(n != N){
    4102:	02800793          	li	a5,40
    4106:	00fb1a63          	bne	s6,a5,411a <concreate+0x186>
    if(((i % 3) == 0 && pid == 0) ||
    410a:	55555a37          	lui	s4,0x55555
    410e:	556a0a13          	addi	s4,s4,1366 # 55555556 <base+0x555468ae>
      close(open(file, 0));
    4112:	f9840993          	addi	s3,s0,-104
  for(i = 0; i < N; i++){
    4116:	8ada                	mv	s5,s6
    4118:	a049                	j	419a <concreate+0x206>
    printf("%s: concreate not enough files in directory listing\n", s);
    411a:	85ea                	mv	a1,s10
    411c:	00003517          	auipc	a0,0x3
    4120:	1d450513          	addi	a0,a0,468 # 72f0 <statistics+0x1da6>
    4124:	278010ef          	jal	539c <printf>
    exit(1);
    4128:	4505                	li	a0,1
    412a:	5d3000ef          	jal	4efc <exit>
      printf("%s: fork failed\n", s);
    412e:	85ea                	mv	a1,s10
    4130:	00002517          	auipc	a0,0x2
    4134:	d5850513          	addi	a0,a0,-680 # 5e88 <statistics+0x93e>
    4138:	264010ef          	jal	539c <printf>
      exit(1);
    413c:	4505                	li	a0,1
    413e:	5bf000ef          	jal	4efc <exit>
      close(open(file, 0));
    4142:	4581                	li	a1,0
    4144:	854e                	mv	a0,s3
    4146:	5f7000ef          	jal	4f3c <open>
    414a:	5db000ef          	jal	4f24 <close>
      close(open(file, 0));
    414e:	4581                	li	a1,0
    4150:	854e                	mv	a0,s3
    4152:	5eb000ef          	jal	4f3c <open>
    4156:	5cf000ef          	jal	4f24 <close>
      close(open(file, 0));
    415a:	4581                	li	a1,0
    415c:	854e                	mv	a0,s3
    415e:	5df000ef          	jal	4f3c <open>
    4162:	5c3000ef          	jal	4f24 <close>
      close(open(file, 0));
    4166:	4581                	li	a1,0
    4168:	854e                	mv	a0,s3
    416a:	5d3000ef          	jal	4f3c <open>
    416e:	5b7000ef          	jal	4f24 <close>
      close(open(file, 0));
    4172:	4581                	li	a1,0
    4174:	854e                	mv	a0,s3
    4176:	5c7000ef          	jal	4f3c <open>
    417a:	5ab000ef          	jal	4f24 <close>
      close(open(file, 0));
    417e:	4581                	li	a1,0
    4180:	854e                	mv	a0,s3
    4182:	5bb000ef          	jal	4f3c <open>
    4186:	59f000ef          	jal	4f24 <close>
    if(pid == 0)
    418a:	06090a63          	beqz	s2,41fe <concreate+0x26a>
      wait(0);
    418e:	4501                	li	a0,0
    4190:	575000ef          	jal	4f04 <wait>
  for(i = 0; i < N; i++){
    4194:	2485                	addiw	s1,s1,1
    4196:	0d548563          	beq	s1,s5,4260 <concreate+0x2cc>
    file[1] = '0' + i;
    419a:	0304879b          	addiw	a5,s1,48
    419e:	f8f40ca3          	sb	a5,-103(s0)
    pid = fork();
    41a2:	553000ef          	jal	4ef4 <fork>
    41a6:	892a                	mv	s2,a0
    if(pid < 0){
    41a8:	f80543e3          	bltz	a0,412e <concreate+0x19a>
    if(((i % 3) == 0 && pid == 0) ||
    41ac:	03448733          	mul	a4,s1,s4
    41b0:	9301                	srli	a4,a4,0x20
    41b2:	41f4d79b          	sraiw	a5,s1,0x1f
    41b6:	9f1d                	subw	a4,a4,a5
    41b8:	0017179b          	slliw	a5,a4,0x1
    41bc:	9fb9                	addw	a5,a5,a4
    41be:	40f487bb          	subw	a5,s1,a5
    41c2:	00a7e733          	or	a4,a5,a0
    41c6:	2701                	sext.w	a4,a4
    41c8:	df2d                	beqz	a4,4142 <concreate+0x1ae>
       ((i % 3) == 1 && pid != 0)){
    41ca:	00a03733          	snez	a4,a0
    if(((i % 3) == 0 && pid == 0) ||
    41ce:	17fd                	addi	a5,a5,-1
    41d0:	0017b793          	seqz	a5,a5
       ((i % 3) == 1 && pid != 0)){
    41d4:	8ff9                	and	a5,a5,a4
    41d6:	f7b5                	bnez	a5,4142 <concreate+0x1ae>
      unlink(file);
    41d8:	854e                	mv	a0,s3
    41da:	573000ef          	jal	4f4c <unlink>
      unlink(file);
    41de:	854e                	mv	a0,s3
    41e0:	56d000ef          	jal	4f4c <unlink>
      unlink(file);
    41e4:	854e                	mv	a0,s3
    41e6:	567000ef          	jal	4f4c <unlink>
      unlink(file);
    41ea:	854e                	mv	a0,s3
    41ec:	561000ef          	jal	4f4c <unlink>
      unlink(file);
    41f0:	854e                	mv	a0,s3
    41f2:	55b000ef          	jal	4f4c <unlink>
      unlink(file);
    41f6:	854e                	mv	a0,s3
    41f8:	555000ef          	jal	4f4c <unlink>
    41fc:	b779                	j	418a <concreate+0x1f6>
      exit(0);
    41fe:	4501                	li	a0,0
    4200:	4fd000ef          	jal	4efc <exit>
      close(fd);
    4204:	521000ef          	jal	4f24 <close>
    if(pid == 0) {
    4208:	b581                	j	4048 <concreate+0xb4>
      close(fd);
    420a:	51b000ef          	jal	4f24 <close>
      wait(&xstatus);
    420e:	8556                	mv	a0,s5
    4210:	4f5000ef          	jal	4f04 <wait>
      if(xstatus != 0)
    4214:	f5c42483          	lw	s1,-164(s0)
    4218:	e2049be3          	bnez	s1,404e <concreate+0xba>
  for(i = 0; i < N; i++){
    421c:	2905                	addiw	s2,s2,1
    421e:	e3490be3          	beq	s2,s4,4054 <concreate+0xc0>
    file[1] = '0' + i;
    4222:	0309079b          	addiw	a5,s2,48
    4226:	f8f40ca3          	sb	a5,-103(s0)
    unlink(file);
    422a:	854e                	mv	a0,s3
    422c:	521000ef          	jal	4f4c <unlink>
    pid = fork();
    4230:	4c5000ef          	jal	4ef4 <fork>
    if(pid && (i % 3) == 1){
    4234:	da050de3          	beqz	a0,3fee <concreate+0x5a>
    4238:	036907b3          	mul	a5,s2,s6
    423c:	9381                	srli	a5,a5,0x20
    423e:	41f9571b          	sraiw	a4,s2,0x1f
    4242:	9f99                	subw	a5,a5,a4
    4244:	0017971b          	slliw	a4,a5,0x1
    4248:	9fb9                	addw	a5,a5,a4
    424a:	40f907bb          	subw	a5,s2,a5
    424e:	d9778be3          	beq	a5,s7,3fe4 <concreate+0x50>
      fd = open(file, O_CREATE | O_RDWR);
    4252:	85e2                	mv	a1,s8
    4254:	854e                	mv	a0,s3
    4256:	4e7000ef          	jal	4f3c <open>
      if(fd < 0){
    425a:	fa0558e3          	bgez	a0,420a <concreate+0x276>
    425e:	b3d1                	j	4022 <concreate+0x8e>
}
    4260:	70aa                	ld	ra,168(sp)
    4262:	740a                	ld	s0,160(sp)
    4264:	64ea                	ld	s1,152(sp)
    4266:	694a                	ld	s2,144(sp)
    4268:	69aa                	ld	s3,136(sp)
    426a:	6a0a                	ld	s4,128(sp)
    426c:	7ae6                	ld	s5,120(sp)
    426e:	7b46                	ld	s6,112(sp)
    4270:	7ba6                	ld	s7,104(sp)
    4272:	7c06                	ld	s8,96(sp)
    4274:	6ce6                	ld	s9,88(sp)
    4276:	6d46                	ld	s10,80(sp)
    4278:	614d                	addi	sp,sp,176
    427a:	8082                	ret

000000000000427c <bigfile>:
{
    427c:	7139                	addi	sp,sp,-64
    427e:	fc06                	sd	ra,56(sp)
    4280:	f822                	sd	s0,48(sp)
    4282:	f426                	sd	s1,40(sp)
    4284:	f04a                	sd	s2,32(sp)
    4286:	ec4e                	sd	s3,24(sp)
    4288:	e852                	sd	s4,16(sp)
    428a:	e456                	sd	s5,8(sp)
    428c:	e05a                	sd	s6,0(sp)
    428e:	0080                	addi	s0,sp,64
    4290:	8b2a                	mv	s6,a0
  unlink("bigfile.dat");
    4292:	00003517          	auipc	a0,0x3
    4296:	09650513          	addi	a0,a0,150 # 7328 <statistics+0x1dde>
    429a:	4b3000ef          	jal	4f4c <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    429e:	20200593          	li	a1,514
    42a2:	00003517          	auipc	a0,0x3
    42a6:	08650513          	addi	a0,a0,134 # 7328 <statistics+0x1dde>
    42aa:	493000ef          	jal	4f3c <open>
  if(fd < 0){
    42ae:	08054a63          	bltz	a0,4342 <bigfile+0xc6>
    42b2:	8a2a                	mv	s4,a0
    42b4:	4481                	li	s1,0
    memset(buf, i, SZ);
    42b6:	25800913          	li	s2,600
    42ba:	00008997          	auipc	s3,0x8
    42be:	9ee98993          	addi	s3,s3,-1554 # bca8 <buf>
  for(i = 0; i < N; i++){
    42c2:	4ad1                	li	s5,20
    memset(buf, i, SZ);
    42c4:	864a                	mv	a2,s2
    42c6:	85a6                	mv	a1,s1
    42c8:	854e                	mv	a0,s3
    42ca:	209000ef          	jal	4cd2 <memset>
    if(write(fd, buf, SZ) != SZ){
    42ce:	864a                	mv	a2,s2
    42d0:	85ce                	mv	a1,s3
    42d2:	8552                	mv	a0,s4
    42d4:	449000ef          	jal	4f1c <write>
    42d8:	07251f63          	bne	a0,s2,4356 <bigfile+0xda>
  for(i = 0; i < N; i++){
    42dc:	2485                	addiw	s1,s1,1
    42de:	ff5493e3          	bne	s1,s5,42c4 <bigfile+0x48>
  close(fd);
    42e2:	8552                	mv	a0,s4
    42e4:	441000ef          	jal	4f24 <close>
  fd = open("bigfile.dat", 0);
    42e8:	4581                	li	a1,0
    42ea:	00003517          	auipc	a0,0x3
    42ee:	03e50513          	addi	a0,a0,62 # 7328 <statistics+0x1dde>
    42f2:	44b000ef          	jal	4f3c <open>
    42f6:	8aaa                	mv	s5,a0
  total = 0;
    42f8:	4a01                	li	s4,0
  for(i = 0; ; i++){
    42fa:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    42fc:	12c00993          	li	s3,300
    4300:	00008917          	auipc	s2,0x8
    4304:	9a890913          	addi	s2,s2,-1624 # bca8 <buf>
  if(fd < 0){
    4308:	06054163          	bltz	a0,436a <bigfile+0xee>
    cc = read(fd, buf, SZ/2);
    430c:	864e                	mv	a2,s3
    430e:	85ca                	mv	a1,s2
    4310:	8556                	mv	a0,s5
    4312:	403000ef          	jal	4f14 <read>
    if(cc < 0){
    4316:	06054463          	bltz	a0,437e <bigfile+0x102>
    if(cc == 0)
    431a:	c145                	beqz	a0,43ba <bigfile+0x13e>
    if(cc != SZ/2){
    431c:	07351b63          	bne	a0,s3,4392 <bigfile+0x116>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    4320:	01f4d79b          	srliw	a5,s1,0x1f
    4324:	9fa5                	addw	a5,a5,s1
    4326:	4017d79b          	sraiw	a5,a5,0x1
    432a:	00094703          	lbu	a4,0(s2)
    432e:	06f71c63          	bne	a4,a5,43a6 <bigfile+0x12a>
    4332:	12b94703          	lbu	a4,299(s2)
    4336:	06f71863          	bne	a4,a5,43a6 <bigfile+0x12a>
    total += cc;
    433a:	12ca0a1b          	addiw	s4,s4,300
  for(i = 0; ; i++){
    433e:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    4340:	b7f1                	j	430c <bigfile+0x90>
    printf("%s: cannot create bigfile", s);
    4342:	85da                	mv	a1,s6
    4344:	00003517          	auipc	a0,0x3
    4348:	ff450513          	addi	a0,a0,-12 # 7338 <statistics+0x1dee>
    434c:	050010ef          	jal	539c <printf>
    exit(1);
    4350:	4505                	li	a0,1
    4352:	3ab000ef          	jal	4efc <exit>
      printf("%s: write bigfile failed\n", s);
    4356:	85da                	mv	a1,s6
    4358:	00003517          	auipc	a0,0x3
    435c:	00050513          	mv	a0,a0
    4360:	03c010ef          	jal	539c <printf>
      exit(1);
    4364:	4505                	li	a0,1
    4366:	397000ef          	jal	4efc <exit>
    printf("%s: cannot open bigfile\n", s);
    436a:	85da                	mv	a1,s6
    436c:	00003517          	auipc	a0,0x3
    4370:	00c50513          	addi	a0,a0,12 # 7378 <statistics+0x1e2e>
    4374:	028010ef          	jal	539c <printf>
    exit(1);
    4378:	4505                	li	a0,1
    437a:	383000ef          	jal	4efc <exit>
      printf("%s: read bigfile failed\n", s);
    437e:	85da                	mv	a1,s6
    4380:	00003517          	auipc	a0,0x3
    4384:	01850513          	addi	a0,a0,24 # 7398 <statistics+0x1e4e>
    4388:	014010ef          	jal	539c <printf>
      exit(1);
    438c:	4505                	li	a0,1
    438e:	36f000ef          	jal	4efc <exit>
      printf("%s: short read bigfile\n", s);
    4392:	85da                	mv	a1,s6
    4394:	00003517          	auipc	a0,0x3
    4398:	02450513          	addi	a0,a0,36 # 73b8 <statistics+0x1e6e>
    439c:	000010ef          	jal	539c <printf>
      exit(1);
    43a0:	4505                	li	a0,1
    43a2:	35b000ef          	jal	4efc <exit>
      printf("%s: read bigfile wrong data\n", s);
    43a6:	85da                	mv	a1,s6
    43a8:	00003517          	auipc	a0,0x3
    43ac:	02850513          	addi	a0,a0,40 # 73d0 <statistics+0x1e86>
    43b0:	7ed000ef          	jal	539c <printf>
      exit(1);
    43b4:	4505                	li	a0,1
    43b6:	347000ef          	jal	4efc <exit>
  close(fd);
    43ba:	8556                	mv	a0,s5
    43bc:	369000ef          	jal	4f24 <close>
  if(total != N*SZ){
    43c0:	678d                	lui	a5,0x3
    43c2:	ee078793          	addi	a5,a5,-288 # 2ee0 <subdir+0x1e4>
    43c6:	02fa1263          	bne	s4,a5,43ea <bigfile+0x16e>
  unlink("bigfile.dat");
    43ca:	00003517          	auipc	a0,0x3
    43ce:	f5e50513          	addi	a0,a0,-162 # 7328 <statistics+0x1dde>
    43d2:	37b000ef          	jal	4f4c <unlink>
}
    43d6:	70e2                	ld	ra,56(sp)
    43d8:	7442                	ld	s0,48(sp)
    43da:	74a2                	ld	s1,40(sp)
    43dc:	7902                	ld	s2,32(sp)
    43de:	69e2                	ld	s3,24(sp)
    43e0:	6a42                	ld	s4,16(sp)
    43e2:	6aa2                	ld	s5,8(sp)
    43e4:	6b02                	ld	s6,0(sp)
    43e6:	6121                	addi	sp,sp,64
    43e8:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    43ea:	85da                	mv	a1,s6
    43ec:	00003517          	auipc	a0,0x3
    43f0:	00450513          	addi	a0,a0,4 # 73f0 <statistics+0x1ea6>
    43f4:	7a9000ef          	jal	539c <printf>
    exit(1);
    43f8:	4505                	li	a0,1
    43fa:	303000ef          	jal	4efc <exit>

00000000000043fe <bigargtest>:
{
    43fe:	7121                	addi	sp,sp,-448
    4400:	ff06                	sd	ra,440(sp)
    4402:	fb22                	sd	s0,432(sp)
    4404:	f726                	sd	s1,424(sp)
    4406:	0380                	addi	s0,sp,448
    4408:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    440a:	00003517          	auipc	a0,0x3
    440e:	00650513          	addi	a0,a0,6 # 7410 <statistics+0x1ec6>
    4412:	33b000ef          	jal	4f4c <unlink>
  pid = fork();
    4416:	2df000ef          	jal	4ef4 <fork>
  if(pid == 0){
    441a:	c915                	beqz	a0,444e <bigargtest+0x50>
  } else if(pid < 0){
    441c:	08054c63          	bltz	a0,44b4 <bigargtest+0xb6>
  wait(&xstatus);
    4420:	fdc40513          	addi	a0,s0,-36
    4424:	2e1000ef          	jal	4f04 <wait>
  if(xstatus != 0)
    4428:	fdc42503          	lw	a0,-36(s0)
    442c:	ed51                	bnez	a0,44c8 <bigargtest+0xca>
  fd = open("bigarg-ok", 0);
    442e:	4581                	li	a1,0
    4430:	00003517          	auipc	a0,0x3
    4434:	fe050513          	addi	a0,a0,-32 # 7410 <statistics+0x1ec6>
    4438:	305000ef          	jal	4f3c <open>
  if(fd < 0){
    443c:	08054863          	bltz	a0,44cc <bigargtest+0xce>
  close(fd);
    4440:	2e5000ef          	jal	4f24 <close>
}
    4444:	70fa                	ld	ra,440(sp)
    4446:	745a                	ld	s0,432(sp)
    4448:	74ba                	ld	s1,424(sp)
    444a:	6139                	addi	sp,sp,448
    444c:	8082                	ret
    memset(big, ' ', sizeof(big));
    444e:	19000613          	li	a2,400
    4452:	02000593          	li	a1,32
    4456:	e4840513          	addi	a0,s0,-440
    445a:	079000ef          	jal	4cd2 <memset>
    big[sizeof(big)-1] = '\0';
    445e:	fc040ba3          	sb	zero,-41(s0)
    for(i = 0; i < MAXARG-1; i++)
    4462:	00004797          	auipc	a5,0x4
    4466:	02e78793          	addi	a5,a5,46 # 8490 <args.1>
    446a:	00004697          	auipc	a3,0x4
    446e:	11e68693          	addi	a3,a3,286 # 8588 <args.1+0xf8>
      args[i] = big;
    4472:	e4840713          	addi	a4,s0,-440
    4476:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    4478:	07a1                	addi	a5,a5,8
    447a:	fed79ee3          	bne	a5,a3,4476 <bigargtest+0x78>
    args[MAXARG-1] = 0;
    447e:	00004797          	auipc	a5,0x4
    4482:	1007b523          	sd	zero,266(a5) # 8588 <args.1+0xf8>
    exec("echo", args);
    4486:	00004597          	auipc	a1,0x4
    448a:	00a58593          	addi	a1,a1,10 # 8490 <args.1>
    448e:	00001517          	auipc	a0,0x1
    4492:	16a50513          	addi	a0,a0,362 # 55f8 <statistics+0xae>
    4496:	29f000ef          	jal	4f34 <exec>
    fd = open("bigarg-ok", O_CREATE);
    449a:	20000593          	li	a1,512
    449e:	00003517          	auipc	a0,0x3
    44a2:	f7250513          	addi	a0,a0,-142 # 7410 <statistics+0x1ec6>
    44a6:	297000ef          	jal	4f3c <open>
    close(fd);
    44aa:	27b000ef          	jal	4f24 <close>
    exit(0);
    44ae:	4501                	li	a0,0
    44b0:	24d000ef          	jal	4efc <exit>
    printf("%s: bigargtest: fork failed\n", s);
    44b4:	85a6                	mv	a1,s1
    44b6:	00003517          	auipc	a0,0x3
    44ba:	f6a50513          	addi	a0,a0,-150 # 7420 <statistics+0x1ed6>
    44be:	6df000ef          	jal	539c <printf>
    exit(1);
    44c2:	4505                	li	a0,1
    44c4:	239000ef          	jal	4efc <exit>
    exit(xstatus);
    44c8:	235000ef          	jal	4efc <exit>
    printf("%s: bigarg test failed!\n", s);
    44cc:	85a6                	mv	a1,s1
    44ce:	00003517          	auipc	a0,0x3
    44d2:	f7250513          	addi	a0,a0,-142 # 7440 <statistics+0x1ef6>
    44d6:	6c7000ef          	jal	539c <printf>
    exit(1);
    44da:	4505                	li	a0,1
    44dc:	221000ef          	jal	4efc <exit>

00000000000044e0 <lazy_alloc>:
{
    44e0:	1141                	addi	sp,sp,-16
    44e2:	e406                	sd	ra,8(sp)
    44e4:	e022                	sd	s0,0(sp)
    44e6:	0800                	addi	s0,sp,16
  prev_end = sbrklazy(REGION_SZ);
    44e8:	40000537          	lui	a0,0x40000
    44ec:	1f3000ef          	jal	4ede <sbrklazy>
  if (prev_end == (char *) SBRK_ERROR) {
    44f0:	57fd                	li	a5,-1
    44f2:	02f50a63          	beq	a0,a5,4526 <lazy_alloc+0x46>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE)
    44f6:	6605                	lui	a2,0x1
    44f8:	962a                	add	a2,a2,a0
    44fa:	400017b7          	lui	a5,0x40001
    44fe:	00f50733          	add	a4,a0,a5
    4502:	87b2                	mv	a5,a2
    4504:	000406b7          	lui	a3,0x40
    *(char **)i = i;
    4508:	e39c                	sd	a5,0(a5)
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE)
    450a:	97b6                	add	a5,a5,a3
    450c:	fee79ee3          	bne	a5,a4,4508 <lazy_alloc+0x28>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE) {
    4510:	000406b7          	lui	a3,0x40
    if (*(char **)i != i) {
    4514:	621c                	ld	a5,0(a2)
    4516:	02c79163          	bne	a5,a2,4538 <lazy_alloc+0x58>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE) {
    451a:	9636                	add	a2,a2,a3
    451c:	fee61ce3          	bne	a2,a4,4514 <lazy_alloc+0x34>
  exit(0);
    4520:	4501                	li	a0,0
    4522:	1db000ef          	jal	4efc <exit>
    printf("sbrklazy() failed\n");
    4526:	00003517          	auipc	a0,0x3
    452a:	f3a50513          	addi	a0,a0,-198 # 7460 <statistics+0x1f16>
    452e:	66f000ef          	jal	539c <printf>
    exit(1);
    4532:	4505                	li	a0,1
    4534:	1c9000ef          	jal	4efc <exit>
      printf("failed to read value from memory\n");
    4538:	00003517          	auipc	a0,0x3
    453c:	f4050513          	addi	a0,a0,-192 # 7478 <statistics+0x1f2e>
    4540:	65d000ef          	jal	539c <printf>
      exit(1);
    4544:	4505                	li	a0,1
    4546:	1b7000ef          	jal	4efc <exit>

000000000000454a <lazy_unmap>:
{
    454a:	7139                	addi	sp,sp,-64
    454c:	fc06                	sd	ra,56(sp)
    454e:	f822                	sd	s0,48(sp)
    4550:	0080                	addi	s0,sp,64
  prev_end = sbrklazy(REGION_SZ);
    4552:	40000537          	lui	a0,0x40000
    4556:	189000ef          	jal	4ede <sbrklazy>
  if (prev_end == (char*)SBRK_ERROR) {
    455a:	57fd                	li	a5,-1
    455c:	04f50863          	beq	a0,a5,45ac <lazy_unmap+0x62>
    4560:	f426                	sd	s1,40(sp)
    4562:	f04a                	sd	s2,32(sp)
    4564:	ec4e                	sd	s3,24(sp)
    4566:	e852                	sd	s4,16(sp)
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE)
    4568:	6905                	lui	s2,0x1
    456a:	992a                	add	s2,s2,a0
    456c:	400017b7          	lui	a5,0x40001
    4570:	00f504b3          	add	s1,a0,a5
    4574:	87ca                	mv	a5,s2
    4576:	01000737          	lui	a4,0x1000
    *(char **)i = i;
    457a:	e39c                	sd	a5,0(a5)
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE)
    457c:	97ba                	add	a5,a5,a4
    457e:	fe979ee3          	bne	a5,s1,457a <lazy_unmap+0x30>
      wait(&status);
    4582:	fcc40993          	addi	s3,s0,-52
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE) {
    4586:	01000a37          	lui	s4,0x1000
    pid = fork();
    458a:	16b000ef          	jal	4ef4 <fork>
    if (pid < 0) {
    458e:	02054c63          	bltz	a0,45c6 <lazy_unmap+0x7c>
    } else if (pid == 0) {
    4592:	c139                	beqz	a0,45d8 <lazy_unmap+0x8e>
      wait(&status);
    4594:	854e                	mv	a0,s3
    4596:	16f000ef          	jal	4f04 <wait>
      if (status == 0) {
    459a:	fcc42783          	lw	a5,-52(s0)
    459e:	c7b1                	beqz	a5,45ea <lazy_unmap+0xa0>
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE) {
    45a0:	9952                	add	s2,s2,s4
    45a2:	fe9914e3          	bne	s2,s1,458a <lazy_unmap+0x40>
  exit(0);
    45a6:	4501                	li	a0,0
    45a8:	155000ef          	jal	4efc <exit>
    45ac:	f426                	sd	s1,40(sp)
    45ae:	f04a                	sd	s2,32(sp)
    45b0:	ec4e                	sd	s3,24(sp)
    45b2:	e852                	sd	s4,16(sp)
    printf("sbrklazy() failed\n");
    45b4:	00003517          	auipc	a0,0x3
    45b8:	eac50513          	addi	a0,a0,-340 # 7460 <statistics+0x1f16>
    45bc:	5e1000ef          	jal	539c <printf>
    exit(1);
    45c0:	4505                	li	a0,1
    45c2:	13b000ef          	jal	4efc <exit>
      printf("error forking\n");
    45c6:	00003517          	auipc	a0,0x3
    45ca:	eda50513          	addi	a0,a0,-294 # 74a0 <statistics+0x1f56>
    45ce:	5cf000ef          	jal	539c <printf>
      exit(1);
    45d2:	4505                	li	a0,1
    45d4:	129000ef          	jal	4efc <exit>
      sbrklazy(-1L * REGION_SZ);
    45d8:	c0000537          	lui	a0,0xc0000
    45dc:	103000ef          	jal	4ede <sbrklazy>
      *(char **)i = i;
    45e0:	01293023          	sd	s2,0(s2) # 1000 <bigdir+0x10c>
      exit(0);
    45e4:	4501                	li	a0,0
    45e6:	117000ef          	jal	4efc <exit>
        printf("memory not unmapped\n");
    45ea:	00003517          	auipc	a0,0x3
    45ee:	ec650513          	addi	a0,a0,-314 # 74b0 <statistics+0x1f66>
    45f2:	5ab000ef          	jal	539c <printf>
        exit(1);
    45f6:	4505                	li	a0,1
    45f8:	105000ef          	jal	4efc <exit>

00000000000045fc <lazy_copy>:
{
    45fc:	7119                	addi	sp,sp,-128
    45fe:	fc86                	sd	ra,120(sp)
    4600:	f8a2                	sd	s0,112(sp)
    4602:	f4a6                	sd	s1,104(sp)
    4604:	f0ca                	sd	s2,96(sp)
    4606:	ecce                	sd	s3,88(sp)
    4608:	e8d2                	sd	s4,80(sp)
    460a:	e4d6                	sd	s5,72(sp)
    460c:	e0da                	sd	s6,64(sp)
    460e:	fc5e                	sd	s7,56(sp)
    4610:	0100                	addi	s0,sp,128
    char *p = sbrk(0);
    4612:	4501                	li	a0,0
    4614:	0b5000ef          	jal	4ec8 <sbrk>
    4618:	84aa                	mv	s1,a0
    sbrklazy(4*PGSIZE);
    461a:	6511                	lui	a0,0x4
    461c:	0c3000ef          	jal	4ede <sbrklazy>
    open(p + 8192, 0);
    4620:	4581                	li	a1,0
    4622:	6509                	lui	a0,0x2
    4624:	9526                	add	a0,a0,s1
    4626:	117000ef          	jal	4f3c <open>
    void *xx = sbrk(0);
    462a:	4501                	li	a0,0
    462c:	09d000ef          	jal	4ec8 <sbrk>
    4630:	84aa                	mv	s1,a0
    void *ret = sbrk(-(((uint64) xx)+1));
    4632:	fff54513          	not	a0,a0
    4636:	2501                	sext.w	a0,a0
    4638:	091000ef          	jal	4ec8 <sbrk>
    if(ret != xx){
    463c:	00a48c63          	beq	s1,a0,4654 <lazy_copy+0x58>
    4640:	85aa                	mv	a1,a0
      printf("sbrk(sbrk(0)+1) returned %p, not old sz\n", ret);
    4642:	00003517          	auipc	a0,0x3
    4646:	e8650513          	addi	a0,a0,-378 # 74c8 <statistics+0x1f7e>
    464a:	553000ef          	jal	539c <printf>
      exit(1);
    464e:	4505                	li	a0,1
    4650:	0ad000ef          	jal	4efc <exit>
  unsigned long bad[] = {
    4654:	00003797          	auipc	a5,0x3
    4658:	41c78793          	addi	a5,a5,1052 # 7a70 <statistics+0x2526>
    465c:	7fa8                	ld	a0,120(a5)
    465e:	63cc                	ld	a1,128(a5)
    4660:	67d0                	ld	a2,136(a5)
    4662:	6bd4                	ld	a3,144(a5)
    4664:	6fd8                	ld	a4,152(a5)
    4666:	f8a43023          	sd	a0,-128(s0)
    466a:	f8b43423          	sd	a1,-120(s0)
    466e:	f8c43823          	sd	a2,-112(s0)
    4672:	f8d43c23          	sd	a3,-104(s0)
    4676:	fae43023          	sd	a4,-96(s0)
    467a:	73dc                	ld	a5,160(a5)
    467c:	faf43423          	sd	a5,-88(s0)
  for(int i = 0; i < sizeof(bad)/sizeof(bad[0]); i++){
    4680:	f8040913          	addi	s2,s0,-128
    int fd = open("README", 0);
    4684:	00001a97          	auipc	s5,0x1
    4688:	14ca8a93          	addi	s5,s5,332 # 57d0 <statistics+0x286>
    if(read(fd, (char*)bad[i], 512) >= 0) { printf("read succeeded\n");  exit(1); }
    468c:	20000a13          	li	s4,512
    fd = open("junk", O_CREATE|O_RDWR|O_TRUNC);
    4690:	60200b93          	li	s7,1538
    4694:	00001b17          	auipc	s6,0x1
    4698:	04cb0b13          	addi	s6,s6,76 # 56e0 <statistics+0x196>
    int fd = open("README", 0);
    469c:	4581                	li	a1,0
    469e:	8556                	mv	a0,s5
    46a0:	09d000ef          	jal	4f3c <open>
    46a4:	84aa                	mv	s1,a0
    if(fd < 0) { printf("cannot open README\n"); exit(1); }
    46a6:	04054563          	bltz	a0,46f0 <lazy_copy+0xf4>
    if(read(fd, (char*)bad[i], 512) >= 0) { printf("read succeeded\n");  exit(1); }
    46aa:	00093983          	ld	s3,0(s2)
    46ae:	8652                	mv	a2,s4
    46b0:	85ce                	mv	a1,s3
    46b2:	063000ef          	jal	4f14 <read>
    46b6:	04055663          	bgez	a0,4702 <lazy_copy+0x106>
    close(fd);
    46ba:	8526                	mv	a0,s1
    46bc:	069000ef          	jal	4f24 <close>
    fd = open("junk", O_CREATE|O_RDWR|O_TRUNC);
    46c0:	85de                	mv	a1,s7
    46c2:	855a                	mv	a0,s6
    46c4:	079000ef          	jal	4f3c <open>
    46c8:	84aa                	mv	s1,a0
    if(fd < 0) { printf("cannot open junk\n"); exit(1); }
    46ca:	04054563          	bltz	a0,4714 <lazy_copy+0x118>
    if(write(fd, (char*)bad[i], 512) >= 0) { printf("write succeeded\n"); exit(1); }
    46ce:	8652                	mv	a2,s4
    46d0:	85ce                	mv	a1,s3
    46d2:	04b000ef          	jal	4f1c <write>
    46d6:	04055863          	bgez	a0,4726 <lazy_copy+0x12a>
    close(fd);
    46da:	8526                	mv	a0,s1
    46dc:	049000ef          	jal	4f24 <close>
  for(int i = 0; i < sizeof(bad)/sizeof(bad[0]); i++){
    46e0:	0921                	addi	s2,s2,8
    46e2:	fb040793          	addi	a5,s0,-80
    46e6:	faf91be3          	bne	s2,a5,469c <lazy_copy+0xa0>
  exit(0);
    46ea:	4501                	li	a0,0
    46ec:	011000ef          	jal	4efc <exit>
    if(fd < 0) { printf("cannot open README\n"); exit(1); }
    46f0:	00003517          	auipc	a0,0x3
    46f4:	e0850513          	addi	a0,a0,-504 # 74f8 <statistics+0x1fae>
    46f8:	4a5000ef          	jal	539c <printf>
    46fc:	4505                	li	a0,1
    46fe:	7fe000ef          	jal	4efc <exit>
    if(read(fd, (char*)bad[i], 512) >= 0) { printf("read succeeded\n");  exit(1); }
    4702:	00003517          	auipc	a0,0x3
    4706:	e0e50513          	addi	a0,a0,-498 # 7510 <statistics+0x1fc6>
    470a:	493000ef          	jal	539c <printf>
    470e:	4505                	li	a0,1
    4710:	7ec000ef          	jal	4efc <exit>
    if(fd < 0) { printf("cannot open junk\n"); exit(1); }
    4714:	00003517          	auipc	a0,0x3
    4718:	e0c50513          	addi	a0,a0,-500 # 7520 <statistics+0x1fd6>
    471c:	481000ef          	jal	539c <printf>
    4720:	4505                	li	a0,1
    4722:	7da000ef          	jal	4efc <exit>
    if(write(fd, (char*)bad[i], 512) >= 0) { printf("write succeeded\n"); exit(1); }
    4726:	00003517          	auipc	a0,0x3
    472a:	e1250513          	addi	a0,a0,-494 # 7538 <statistics+0x1fee>
    472e:	46f000ef          	jal	539c <printf>
    4732:	4505                	li	a0,1
    4734:	7c8000ef          	jal	4efc <exit>

0000000000004738 <fsfull>:
{
    4738:	7171                	addi	sp,sp,-176
    473a:	f506                	sd	ra,168(sp)
    473c:	f122                	sd	s0,160(sp)
    473e:	ed26                	sd	s1,152(sp)
    4740:	e94a                	sd	s2,144(sp)
    4742:	e54e                	sd	s3,136(sp)
    4744:	e152                	sd	s4,128(sp)
    4746:	fcd6                	sd	s5,120(sp)
    4748:	f8da                	sd	s6,112(sp)
    474a:	f4de                	sd	s7,104(sp)
    474c:	f0e2                	sd	s8,96(sp)
    474e:	ece6                	sd	s9,88(sp)
    4750:	e8ea                	sd	s10,80(sp)
    4752:	e4ee                	sd	s11,72(sp)
    4754:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    4756:	00003517          	auipc	a0,0x3
    475a:	dfa50513          	addi	a0,a0,-518 # 7550 <statistics+0x2006>
    475e:	43f000ef          	jal	539c <printf>
  for(nfiles = 0; ; nfiles++){
    4762:	4481                	li	s1,0
    name[0] = 'f';
    4764:	06600d93          	li	s11,102
    name[1] = '0' + nfiles / 1000;
    4768:	10625cb7          	lui	s9,0x10625
    476c:	dd3c8c93          	addi	s9,s9,-557 # 10624dd3 <base+0x1061612b>
    name[2] = '0' + (nfiles % 1000) / 100;
    4770:	51eb8ab7          	lui	s5,0x51eb8
    4774:	51fa8a93          	addi	s5,s5,1311 # 51eb851f <base+0x51ea9877>
    name[3] = '0' + (nfiles % 100) / 10;
    4778:	66666a37          	lui	s4,0x66666
    477c:	667a0a13          	addi	s4,s4,1639 # 66666667 <base+0x666579bf>
    printf("writing %s\n", name);
    4780:	f5040d13          	addi	s10,s0,-176
    name[0] = 'f';
    4784:	f5b40823          	sb	s11,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4788:	039487b3          	mul	a5,s1,s9
    478c:	9799                	srai	a5,a5,0x26
    478e:	41f4d69b          	sraiw	a3,s1,0x1f
    4792:	9f95                	subw	a5,a5,a3
    4794:	0307871b          	addiw	a4,a5,48
    4798:	f4e408a3          	sb	a4,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    479c:	3e800713          	li	a4,1000
    47a0:	02f707bb          	mulw	a5,a4,a5
    47a4:	40f487bb          	subw	a5,s1,a5
    47a8:	03578733          	mul	a4,a5,s5
    47ac:	9715                	srai	a4,a4,0x25
    47ae:	41f7d79b          	sraiw	a5,a5,0x1f
    47b2:	40f707bb          	subw	a5,a4,a5
    47b6:	0307879b          	addiw	a5,a5,48
    47ba:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    47be:	035487b3          	mul	a5,s1,s5
    47c2:	9795                	srai	a5,a5,0x25
    47c4:	9f95                	subw	a5,a5,a3
    47c6:	06400713          	li	a4,100
    47ca:	02f707bb          	mulw	a5,a4,a5
    47ce:	40f487bb          	subw	a5,s1,a5
    47d2:	03478733          	mul	a4,a5,s4
    47d6:	9709                	srai	a4,a4,0x22
    47d8:	41f7d79b          	sraiw	a5,a5,0x1f
    47dc:	40f707bb          	subw	a5,a4,a5
    47e0:	0307879b          	addiw	a5,a5,48
    47e4:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    47e8:	03448733          	mul	a4,s1,s4
    47ec:	9709                	srai	a4,a4,0x22
    47ee:	9f15                	subw	a4,a4,a3
    47f0:	0027179b          	slliw	a5,a4,0x2
    47f4:	9fb9                	addw	a5,a5,a4
    47f6:	0017979b          	slliw	a5,a5,0x1
    47fa:	40f487bb          	subw	a5,s1,a5
    47fe:	0307879b          	addiw	a5,a5,48
    4802:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    4806:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    480a:	85ea                	mv	a1,s10
    480c:	00003517          	auipc	a0,0x3
    4810:	d5450513          	addi	a0,a0,-684 # 7560 <statistics+0x2016>
    4814:	389000ef          	jal	539c <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    4818:	20200593          	li	a1,514
    481c:	856a                	mv	a0,s10
    481e:	71e000ef          	jal	4f3c <open>
    4822:	892a                	mv	s2,a0
    if(fd < 0){
    4824:	0e055b63          	bgez	a0,491a <fsfull+0x1e2>
      printf("open %s failed\n", name);
    4828:	f5040593          	addi	a1,s0,-176
    482c:	00003517          	auipc	a0,0x3
    4830:	d4450513          	addi	a0,a0,-700 # 7570 <statistics+0x2026>
    4834:	369000ef          	jal	539c <printf>
  while(nfiles >= 0){
    4838:	0a04cc63          	bltz	s1,48f0 <fsfull+0x1b8>
    name[0] = 'f';
    483c:	06600c13          	li	s8,102
    name[1] = '0' + nfiles / 1000;
    4840:	10625a37          	lui	s4,0x10625
    4844:	dd3a0a13          	addi	s4,s4,-557 # 10624dd3 <base+0x1061612b>
    name[2] = '0' + (nfiles % 1000) / 100;
    4848:	3e800b93          	li	s7,1000
    484c:	51eb89b7          	lui	s3,0x51eb8
    4850:	51f98993          	addi	s3,s3,1311 # 51eb851f <base+0x51ea9877>
    name[3] = '0' + (nfiles % 100) / 10;
    4854:	06400b13          	li	s6,100
    4858:	66666937          	lui	s2,0x66666
    485c:	66790913          	addi	s2,s2,1639 # 66666667 <base+0x666579bf>
    unlink(name);
    4860:	f5040a93          	addi	s5,s0,-176
    name[0] = 'f';
    4864:	f5840823          	sb	s8,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4868:	034487b3          	mul	a5,s1,s4
    486c:	9799                	srai	a5,a5,0x26
    486e:	41f4d69b          	sraiw	a3,s1,0x1f
    4872:	9f95                	subw	a5,a5,a3
    4874:	0307871b          	addiw	a4,a5,48
    4878:	f4e408a3          	sb	a4,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    487c:	02fb87bb          	mulw	a5,s7,a5
    4880:	40f487bb          	subw	a5,s1,a5
    4884:	03378733          	mul	a4,a5,s3
    4888:	9715                	srai	a4,a4,0x25
    488a:	41f7d79b          	sraiw	a5,a5,0x1f
    488e:	40f707bb          	subw	a5,a4,a5
    4892:	0307879b          	addiw	a5,a5,48
    4896:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    489a:	033487b3          	mul	a5,s1,s3
    489e:	9795                	srai	a5,a5,0x25
    48a0:	9f95                	subw	a5,a5,a3
    48a2:	02fb07bb          	mulw	a5,s6,a5
    48a6:	40f487bb          	subw	a5,s1,a5
    48aa:	03278733          	mul	a4,a5,s2
    48ae:	9709                	srai	a4,a4,0x22
    48b0:	41f7d79b          	sraiw	a5,a5,0x1f
    48b4:	40f707bb          	subw	a5,a4,a5
    48b8:	0307879b          	addiw	a5,a5,48
    48bc:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    48c0:	03248733          	mul	a4,s1,s2
    48c4:	9709                	srai	a4,a4,0x22
    48c6:	9f15                	subw	a4,a4,a3
    48c8:	0027179b          	slliw	a5,a4,0x2
    48cc:	9fb9                	addw	a5,a5,a4
    48ce:	0017979b          	slliw	a5,a5,0x1
    48d2:	40f487bb          	subw	a5,s1,a5
    48d6:	0307879b          	addiw	a5,a5,48
    48da:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    48de:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    48e2:	8556                	mv	a0,s5
    48e4:	668000ef          	jal	4f4c <unlink>
    nfiles--;
    48e8:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    48ea:	57fd                	li	a5,-1
    48ec:	f6f49ce3          	bne	s1,a5,4864 <fsfull+0x12c>
  printf("fsfull test finished\n");
    48f0:	00003517          	auipc	a0,0x3
    48f4:	ca050513          	addi	a0,a0,-864 # 7590 <statistics+0x2046>
    48f8:	2a5000ef          	jal	539c <printf>
}
    48fc:	70aa                	ld	ra,168(sp)
    48fe:	740a                	ld	s0,160(sp)
    4900:	64ea                	ld	s1,152(sp)
    4902:	694a                	ld	s2,144(sp)
    4904:	69aa                	ld	s3,136(sp)
    4906:	6a0a                	ld	s4,128(sp)
    4908:	7ae6                	ld	s5,120(sp)
    490a:	7b46                	ld	s6,112(sp)
    490c:	7ba6                	ld	s7,104(sp)
    490e:	7c06                	ld	s8,96(sp)
    4910:	6ce6                	ld	s9,88(sp)
    4912:	6d46                	ld	s10,80(sp)
    4914:	6da6                	ld	s11,72(sp)
    4916:	614d                	addi	sp,sp,176
    4918:	8082                	ret
    int total = 0;
    491a:	4981                	li	s3,0
      int cc = write(fd, buf, BSIZE);
    491c:	40000c13          	li	s8,1024
    4920:	00007b97          	auipc	s7,0x7
    4924:	388b8b93          	addi	s7,s7,904 # bca8 <buf>
      if(cc < BSIZE)
    4928:	3ff00b13          	li	s6,1023
      int cc = write(fd, buf, BSIZE);
    492c:	8662                	mv	a2,s8
    492e:	85de                	mv	a1,s7
    4930:	854a                	mv	a0,s2
    4932:	5ea000ef          	jal	4f1c <write>
      if(cc < BSIZE)
    4936:	00ab5563          	bge	s6,a0,4940 <fsfull+0x208>
      total += cc;
    493a:	00a989bb          	addw	s3,s3,a0
    while(1){
    493e:	b7fd                	j	492c <fsfull+0x1f4>
    printf("wrote %d bytes\n", total);
    4940:	85ce                	mv	a1,s3
    4942:	00003517          	auipc	a0,0x3
    4946:	c3e50513          	addi	a0,a0,-962 # 7580 <statistics+0x2036>
    494a:	253000ef          	jal	539c <printf>
    close(fd);
    494e:	854a                	mv	a0,s2
    4950:	5d4000ef          	jal	4f24 <close>
    if(total == 0)
    4954:	ee0982e3          	beqz	s3,4838 <fsfull+0x100>
  for(nfiles = 0; ; nfiles++){
    4958:	2485                	addiw	s1,s1,1
    495a:	b52d                	j	4784 <fsfull+0x4c>

000000000000495c <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    495c:	7179                	addi	sp,sp,-48
    495e:	f406                	sd	ra,40(sp)
    4960:	f022                	sd	s0,32(sp)
    4962:	ec26                	sd	s1,24(sp)
    4964:	e84a                	sd	s2,16(sp)
    4966:	1800                	addi	s0,sp,48
    4968:	84aa                	mv	s1,a0
    496a:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    496c:	00003517          	auipc	a0,0x3
    4970:	c3c50513          	addi	a0,a0,-964 # 75a8 <statistics+0x205e>
    4974:	229000ef          	jal	539c <printf>
  if((pid = fork()) < 0) {
    4978:	57c000ef          	jal	4ef4 <fork>
    497c:	02054a63          	bltz	a0,49b0 <run+0x54>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    4980:	c129                	beqz	a0,49c2 <run+0x66>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    4982:	fdc40513          	addi	a0,s0,-36
    4986:	57e000ef          	jal	4f04 <wait>
    if(xstatus != 0) 
    498a:	fdc42783          	lw	a5,-36(s0)
    498e:	cf9d                	beqz	a5,49cc <run+0x70>
      printf("FAILED\n");
    4990:	00003517          	auipc	a0,0x3
    4994:	c4050513          	addi	a0,a0,-960 # 75d0 <statistics+0x2086>
    4998:	205000ef          	jal	539c <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    499c:	fdc42503          	lw	a0,-36(s0)
  }
}
    49a0:	00153513          	seqz	a0,a0
    49a4:	70a2                	ld	ra,40(sp)
    49a6:	7402                	ld	s0,32(sp)
    49a8:	64e2                	ld	s1,24(sp)
    49aa:	6942                	ld	s2,16(sp)
    49ac:	6145                	addi	sp,sp,48
    49ae:	8082                	ret
    printf("runtest: fork error\n");
    49b0:	00003517          	auipc	a0,0x3
    49b4:	c0850513          	addi	a0,a0,-1016 # 75b8 <statistics+0x206e>
    49b8:	1e5000ef          	jal	539c <printf>
    exit(1);
    49bc:	4505                	li	a0,1
    49be:	53e000ef          	jal	4efc <exit>
    f(s);
    49c2:	854a                	mv	a0,s2
    49c4:	9482                	jalr	s1
    exit(0);
    49c6:	4501                	li	a0,0
    49c8:	534000ef          	jal	4efc <exit>
      printf("OK\n");
    49cc:	00003517          	auipc	a0,0x3
    49d0:	c0c50513          	addi	a0,a0,-1012 # 75d8 <statistics+0x208e>
    49d4:	1c9000ef          	jal	539c <printf>
    49d8:	b7d1                	j	499c <run+0x40>

00000000000049da <runtests>:

int
runtests(struct test *tests, char *justone, int continuous) {
    49da:	7179                	addi	sp,sp,-48
    49dc:	f406                	sd	ra,40(sp)
    49de:	f022                	sd	s0,32(sp)
    49e0:	ec26                	sd	s1,24(sp)
    49e2:	e44e                	sd	s3,8(sp)
    49e4:	1800                	addi	s0,sp,48
    49e6:	84aa                	mv	s1,a0
  int ntests = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    49e8:	6508                	ld	a0,8(a0)
    49ea:	c125                	beqz	a0,4a4a <runtests+0x70>
    49ec:	e84a                	sd	s2,16(sp)
    49ee:	e052                	sd	s4,0(sp)
    49f0:	892e                	mv	s2,a1
    if((justone == 0) || strcmp(t->s, justone) == 0) {
      ntests++;
      if(!run(t->f, t->s)){
        if(continuous != 2){
    49f2:	1679                	addi	a2,a2,-2 # ffe <bigdir+0x10a>
    49f4:	00c03a33          	snez	s4,a2
  int ntests = 0;
    49f8:	4981                	li	s3,0
    49fa:	a831                	j	4a16 <runtests+0x3c>
      if(!run(t->f, t->s)){
    49fc:	648c                	ld	a1,8(s1)
    49fe:	6088                	ld	a0,0(s1)
    4a00:	f5dff0ef          	jal	495c <run>
    4a04:	00153513          	seqz	a0,a0
        if(continuous != 2){
    4a08:	00aa7533          	and	a0,s4,a0
    4a0c:	ed01                	bnez	a0,4a24 <runtests+0x4a>
      ntests++;
    4a0e:	2985                	addiw	s3,s3,1
  for (struct test *t = tests; t->s != 0; t++) {
    4a10:	04c1                	addi	s1,s1,16
    4a12:	6488                	ld	a0,8(s1)
    4a14:	c115                	beqz	a0,4a38 <runtests+0x5e>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    4a16:	fe0903e3          	beqz	s2,49fc <runtests+0x22>
    4a1a:	85ca                	mv	a1,s2
    4a1c:	25a000ef          	jal	4c76 <strcmp>
    4a20:	f965                	bnez	a0,4a10 <runtests+0x36>
    4a22:	bfe9                	j	49fc <runtests+0x22>
          printf("SOME TESTS FAILED\n");
    4a24:	00003517          	auipc	a0,0x3
    4a28:	bbc50513          	addi	a0,a0,-1092 # 75e0 <statistics+0x2096>
    4a2c:	171000ef          	jal	539c <printf>
          return -1;
    4a30:	59fd                	li	s3,-1
    4a32:	6942                	ld	s2,16(sp)
    4a34:	6a02                	ld	s4,0(sp)
    4a36:	a019                	j	4a3c <runtests+0x62>
    4a38:	6942                	ld	s2,16(sp)
    4a3a:	6a02                	ld	s4,0(sp)
        }
      }
    }
  }
  return ntests;
}
    4a3c:	854e                	mv	a0,s3
    4a3e:	70a2                	ld	ra,40(sp)
    4a40:	7402                	ld	s0,32(sp)
    4a42:	64e2                	ld	s1,24(sp)
    4a44:	69a2                	ld	s3,8(sp)
    4a46:	6145                	addi	sp,sp,48
    4a48:	8082                	ret
  return ntests;
    4a4a:	4981                	li	s3,0
    4a4c:	bfc5                	j	4a3c <runtests+0x62>

0000000000004a4e <countfree>:


// use sbrk() to count how many free physical memory pages there are.
int
countfree()
{
    4a4e:	7179                	addi	sp,sp,-48
    4a50:	f406                	sd	ra,40(sp)
    4a52:	f022                	sd	s0,32(sp)
    4a54:	ec26                	sd	s1,24(sp)
    4a56:	e84a                	sd	s2,16(sp)
    4a58:	e44e                	sd	s3,8(sp)
    4a5a:	e052                	sd	s4,0(sp)
    4a5c:	1800                	addi	s0,sp,48
  int n = 0;
  uint64 sz0 = (uint64)sbrk(0);
    4a5e:	4501                	li	a0,0
    4a60:	468000ef          	jal	4ec8 <sbrk>
    4a64:	8a2a                	mv	s4,a0
  int n = 0;
    4a66:	4481                	li	s1,0
  while(1){
    char *a = sbrk(PGSIZE);
    4a68:	6985                	lui	s3,0x1
    if(a == SBRK_ERROR){
    4a6a:	597d                	li	s2,-1
    char *a = sbrk(PGSIZE);
    4a6c:	854e                	mv	a0,s3
    4a6e:	45a000ef          	jal	4ec8 <sbrk>
    if(a == SBRK_ERROR){
    4a72:	01250463          	beq	a0,s2,4a7a <countfree+0x2c>
      break;
    }
    n += 1;
    4a76:	2485                	addiw	s1,s1,1
  while(1){
    4a78:	bfd5                	j	4a6c <countfree+0x1e>
  }
  sbrk(-((uint64)sbrk(0) - sz0));  
    4a7a:	4501                	li	a0,0
    4a7c:	44c000ef          	jal	4ec8 <sbrk>
    4a80:	40aa053b          	subw	a0,s4,a0
    4a84:	444000ef          	jal	4ec8 <sbrk>
  return n;
}
    4a88:	8526                	mv	a0,s1
    4a8a:	70a2                	ld	ra,40(sp)
    4a8c:	7402                	ld	s0,32(sp)
    4a8e:	64e2                	ld	s1,24(sp)
    4a90:	6942                	ld	s2,16(sp)
    4a92:	69a2                	ld	s3,8(sp)
    4a94:	6a02                	ld	s4,0(sp)
    4a96:	6145                	addi	sp,sp,48
    4a98:	8082                	ret

0000000000004a9a <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    4a9a:	7159                	addi	sp,sp,-112
    4a9c:	f486                	sd	ra,104(sp)
    4a9e:	f0a2                	sd	s0,96(sp)
    4aa0:	eca6                	sd	s1,88(sp)
    4aa2:	e8ca                	sd	s2,80(sp)
    4aa4:	e4ce                	sd	s3,72(sp)
    4aa6:	e0d2                	sd	s4,64(sp)
    4aa8:	fc56                	sd	s5,56(sp)
    4aaa:	f85a                	sd	s6,48(sp)
    4aac:	f45e                	sd	s7,40(sp)
    4aae:	f062                	sd	s8,32(sp)
    4ab0:	ec66                	sd	s9,24(sp)
    4ab2:	e86a                	sd	s10,16(sp)
    4ab4:	e46e                	sd	s11,8(sp)
    4ab6:	1880                	addi	s0,sp,112
    4ab8:	8aaa                	mv	s5,a0
    4aba:	89ae                	mv	s3,a1
    4abc:	8a32                	mv	s4,a2
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
      if(continuous != 2) {
        return 1;
      }
    }
    if (justone != 0 && ntests == 0) {
    4abe:	00c03cb3          	snez	s9,a2
    printf("usertests starting\n");
    4ac2:	00003c17          	auipc	s8,0x3
    4ac6:	b36c0c13          	addi	s8,s8,-1226 # 75f8 <statistics+0x20ae>
    n = runtests(quicktests, justone, continuous);
    4aca:	00003b97          	auipc	s7,0x3
    4ace:	546b8b93          	addi	s7,s7,1350 # 8010 <quicktests>
      if(continuous != 2) {
    4ad2:	4b09                	li	s6,2
      n = runtests(slowtests, justone, continuous);
    4ad4:	00004d17          	auipc	s10,0x4
    4ad8:	93cd0d13          	addi	s10,s10,-1732 # 8410 <slowtests>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    4adc:	00003d97          	auipc	s11,0x3
    4ae0:	b54d8d93          	addi	s11,s11,-1196 # 7630 <statistics+0x20e6>
    4ae4:	a80d                	j	4b16 <drivetests+0x7c>
      if(continuous != 2) {
    4ae6:	09699563          	bne	s3,s6,4b70 <drivetests+0xd6>
    int ntests = 0;
    4aea:	4481                	li	s1,0
    4aec:	a099                	j	4b32 <drivetests+0x98>
        printf("usertests slow tests starting\n");
    4aee:	00003517          	auipc	a0,0x3
    4af2:	b2250513          	addi	a0,a0,-1246 # 7610 <statistics+0x20c6>
    4af6:	0a7000ef          	jal	539c <printf>
    4afa:	a081                	j	4b3a <drivetests+0xa0>
        if(continuous != 2) {
    4afc:	07699a63          	bne	s3,s6,4b70 <drivetests+0xd6>
    if((free1 = countfree()) < free0) {
    4b00:	f4fff0ef          	jal	4a4e <countfree>
    4b04:	05254463          	blt	a0,s2,4b4c <drivetests+0xb2>
    if (justone != 0 && ntests == 0) {
    4b08:	0014b493          	seqz	s1,s1
    4b0c:	009cf4b3          	and	s1,s9,s1
    4b10:	e8b1                	bnez	s1,4b64 <drivetests+0xca>
      printf("NO TESTS EXECUTED\n");
      return 1;
    }
  } while(continuous);
    4b12:	06098f63          	beqz	s3,4b90 <drivetests+0xf6>
    printf("usertests starting\n");
    4b16:	8562                	mv	a0,s8
    4b18:	085000ef          	jal	539c <printf>
    int free0 = countfree();
    4b1c:	f33ff0ef          	jal	4a4e <countfree>
    4b20:	892a                	mv	s2,a0
    n = runtests(quicktests, justone, continuous);
    4b22:	864e                	mv	a2,s3
    4b24:	85d2                	mv	a1,s4
    4b26:	855e                	mv	a0,s7
    4b28:	eb3ff0ef          	jal	49da <runtests>
    4b2c:	84aa                	mv	s1,a0
    if (n < 0) {
    4b2e:	fa054ce3          	bltz	a0,4ae6 <drivetests+0x4c>
    if(!quick) {
    4b32:	fc0a97e3          	bnez	s5,4b00 <drivetests+0x66>
      if (justone == 0)
    4b36:	fa0a0ce3          	beqz	s4,4aee <drivetests+0x54>
      n = runtests(slowtests, justone, continuous);
    4b3a:	864e                	mv	a2,s3
    4b3c:	85d2                	mv	a1,s4
    4b3e:	856a                	mv	a0,s10
    4b40:	e9bff0ef          	jal	49da <runtests>
      if (n < 0) {
    4b44:	fa054ce3          	bltz	a0,4afc <drivetests+0x62>
        ntests += n;
    4b48:	9ca9                	addw	s1,s1,a0
    4b4a:	bf5d                	j	4b00 <drivetests+0x66>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    4b4c:	864a                	mv	a2,s2
    4b4e:	85aa                	mv	a1,a0
    4b50:	856e                	mv	a0,s11
    4b52:	04b000ef          	jal	539c <printf>
      if(continuous != 2) {
    4b56:	01699d63          	bne	s3,s6,4b70 <drivetests+0xd6>
    if (justone != 0 && ntests == 0) {
    4b5a:	0014b493          	seqz	s1,s1
    4b5e:	009cf4b3          	and	s1,s9,s1
    4b62:	d8d5                	beqz	s1,4b16 <drivetests+0x7c>
      printf("NO TESTS EXECUTED\n");
    4b64:	00003517          	auipc	a0,0x3
    4b68:	afc50513          	addi	a0,a0,-1284 # 7660 <statistics+0x2116>
    4b6c:	031000ef          	jal	539c <printf>
        return 1;
    4b70:	4505                	li	a0,1
  return 0;
}
    4b72:	70a6                	ld	ra,104(sp)
    4b74:	7406                	ld	s0,96(sp)
    4b76:	64e6                	ld	s1,88(sp)
    4b78:	6946                	ld	s2,80(sp)
    4b7a:	69a6                	ld	s3,72(sp)
    4b7c:	6a06                	ld	s4,64(sp)
    4b7e:	7ae2                	ld	s5,56(sp)
    4b80:	7b42                	ld	s6,48(sp)
    4b82:	7ba2                	ld	s7,40(sp)
    4b84:	7c02                	ld	s8,32(sp)
    4b86:	6ce2                	ld	s9,24(sp)
    4b88:	6d42                	ld	s10,16(sp)
    4b8a:	6da2                	ld	s11,8(sp)
    4b8c:	6165                	addi	sp,sp,112
    4b8e:	8082                	ret
  return 0;
    4b90:	854e                	mv	a0,s3
    4b92:	b7c5                	j	4b72 <drivetests+0xd8>

0000000000004b94 <main>:

int
main(int argc, char *argv[])
{
    4b94:	1101                	addi	sp,sp,-32
    4b96:	ec06                	sd	ra,24(sp)
    4b98:	e822                	sd	s0,16(sp)
    4b9a:	e426                	sd	s1,8(sp)
    4b9c:	e04a                	sd	s2,0(sp)
    4b9e:	1000                	addi	s0,sp,32
    4ba0:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    4ba2:	4789                	li	a5,2
    4ba4:	00f50e63          	beq	a0,a5,4bc0 <main+0x2c>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    4ba8:	4785                	li	a5,1
    4baa:	06a7c663          	blt	a5,a0,4c16 <main+0x82>
  char *justone = 0;
    4bae:	4601                	li	a2,0
  int quick = 0;
    4bb0:	4501                	li	a0,0
  int continuous = 0;
    4bb2:	4581                	li	a1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    4bb4:	ee7ff0ef          	jal	4a9a <drivetests>
    4bb8:	cd35                	beqz	a0,4c34 <main+0xa0>
    exit(1);
    4bba:	4505                	li	a0,1
    4bbc:	340000ef          	jal	4efc <exit>
    4bc0:	892e                	mv	s2,a1
  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    4bc2:	00003597          	auipc	a1,0x3
    4bc6:	ab658593          	addi	a1,a1,-1354 # 7678 <statistics+0x212e>
    4bca:	00893503          	ld	a0,8(s2)
    4bce:	0a8000ef          	jal	4c76 <strcmp>
    4bd2:	85aa                	mv	a1,a0
    4bd4:	e501                	bnez	a0,4bdc <main+0x48>
  char *justone = 0;
    4bd6:	4601                	li	a2,0
    quick = 1;
    4bd8:	4505                	li	a0,1
    4bda:	bfe9                	j	4bb4 <main+0x20>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    4bdc:	00003597          	auipc	a1,0x3
    4be0:	aa458593          	addi	a1,a1,-1372 # 7680 <statistics+0x2136>
    4be4:	00893503          	ld	a0,8(s2)
    4be8:	08e000ef          	jal	4c76 <strcmp>
    4bec:	cd15                	beqz	a0,4c28 <main+0x94>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    4bee:	00003597          	auipc	a1,0x3
    4bf2:	ae258593          	addi	a1,a1,-1310 # 76d0 <statistics+0x2186>
    4bf6:	00893503          	ld	a0,8(s2)
    4bfa:	07c000ef          	jal	4c76 <strcmp>
    4bfe:	c905                	beqz	a0,4c2e <main+0x9a>
  } else if(argc == 2 && argv[1][0] != '-'){
    4c00:	00893603          	ld	a2,8(s2)
    4c04:	00064703          	lbu	a4,0(a2)
    4c08:	02d00793          	li	a5,45
    4c0c:	00f70563          	beq	a4,a5,4c16 <main+0x82>
  int quick = 0;
    4c10:	4501                	li	a0,0
  int continuous = 0;
    4c12:	4581                	li	a1,0
    4c14:	b745                	j	4bb4 <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    4c16:	00003517          	auipc	a0,0x3
    4c1a:	a7250513          	addi	a0,a0,-1422 # 7688 <statistics+0x213e>
    4c1e:	77e000ef          	jal	539c <printf>
    exit(1);
    4c22:	4505                	li	a0,1
    4c24:	2d8000ef          	jal	4efc <exit>
  char *justone = 0;
    4c28:	4601                	li	a2,0
    continuous = 1;
    4c2a:	4585                	li	a1,1
    4c2c:	b761                	j	4bb4 <main+0x20>
    continuous = 2;
    4c2e:	85a6                	mv	a1,s1
  char *justone = 0;
    4c30:	4601                	li	a2,0
    4c32:	b749                	j	4bb4 <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    4c34:	00003517          	auipc	a0,0x3
    4c38:	a8450513          	addi	a0,a0,-1404 # 76b8 <statistics+0x216e>
    4c3c:	760000ef          	jal	539c <printf>
  exit(0);
    4c40:	4501                	li	a0,0
    4c42:	2ba000ef          	jal	4efc <exit>

0000000000004c46 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
    4c46:	1141                	addi	sp,sp,-16
    4c48:	e406                	sd	ra,8(sp)
    4c4a:	e022                	sd	s0,0(sp)
    4c4c:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
    4c4e:	f47ff0ef          	jal	4b94 <main>
  exit(r);
    4c52:	2aa000ef          	jal	4efc <exit>

0000000000004c56 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    4c56:	1141                	addi	sp,sp,-16
    4c58:	e406                	sd	ra,8(sp)
    4c5a:	e022                	sd	s0,0(sp)
    4c5c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    4c5e:	87aa                	mv	a5,a0
    4c60:	0585                	addi	a1,a1,1
    4c62:	0785                	addi	a5,a5,1
    4c64:	fff5c703          	lbu	a4,-1(a1)
    4c68:	fee78fa3          	sb	a4,-1(a5)
    4c6c:	fb75                	bnez	a4,4c60 <strcpy+0xa>
    ;
  return os;
}
    4c6e:	60a2                	ld	ra,8(sp)
    4c70:	6402                	ld	s0,0(sp)
    4c72:	0141                	addi	sp,sp,16
    4c74:	8082                	ret

0000000000004c76 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    4c76:	1141                	addi	sp,sp,-16
    4c78:	e406                	sd	ra,8(sp)
    4c7a:	e022                	sd	s0,0(sp)
    4c7c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    4c7e:	00054783          	lbu	a5,0(a0)
    4c82:	cb91                	beqz	a5,4c96 <strcmp+0x20>
    4c84:	0005c703          	lbu	a4,0(a1)
    4c88:	00f71763          	bne	a4,a5,4c96 <strcmp+0x20>
    p++, q++;
    4c8c:	0505                	addi	a0,a0,1
    4c8e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    4c90:	00054783          	lbu	a5,0(a0)
    4c94:	fbe5                	bnez	a5,4c84 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
    4c96:	0005c503          	lbu	a0,0(a1)
}
    4c9a:	40a7853b          	subw	a0,a5,a0
    4c9e:	60a2                	ld	ra,8(sp)
    4ca0:	6402                	ld	s0,0(sp)
    4ca2:	0141                	addi	sp,sp,16
    4ca4:	8082                	ret

0000000000004ca6 <strlen>:

uint
strlen(const char *s)
{
    4ca6:	1141                	addi	sp,sp,-16
    4ca8:	e406                	sd	ra,8(sp)
    4caa:	e022                	sd	s0,0(sp)
    4cac:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    4cae:	00054783          	lbu	a5,0(a0)
    4cb2:	cf91                	beqz	a5,4cce <strlen+0x28>
    4cb4:	00150793          	addi	a5,a0,1
    4cb8:	86be                	mv	a3,a5
    4cba:	0785                	addi	a5,a5,1
    4cbc:	fff7c703          	lbu	a4,-1(a5)
    4cc0:	ff65                	bnez	a4,4cb8 <strlen+0x12>
    4cc2:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
    4cc6:	60a2                	ld	ra,8(sp)
    4cc8:	6402                	ld	s0,0(sp)
    4cca:	0141                	addi	sp,sp,16
    4ccc:	8082                	ret
  for(n = 0; s[n]; n++)
    4cce:	4501                	li	a0,0
    4cd0:	bfdd                	j	4cc6 <strlen+0x20>

0000000000004cd2 <memset>:

void*
memset(void *dst, int c, uint n)
{
    4cd2:	1141                	addi	sp,sp,-16
    4cd4:	e406                	sd	ra,8(sp)
    4cd6:	e022                	sd	s0,0(sp)
    4cd8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    4cda:	ca19                	beqz	a2,4cf0 <memset+0x1e>
    4cdc:	87aa                	mv	a5,a0
    4cde:	1602                	slli	a2,a2,0x20
    4ce0:	9201                	srli	a2,a2,0x20
    4ce2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    4ce6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    4cea:	0785                	addi	a5,a5,1
    4cec:	fee79de3          	bne	a5,a4,4ce6 <memset+0x14>
  }
  return dst;
}
    4cf0:	60a2                	ld	ra,8(sp)
    4cf2:	6402                	ld	s0,0(sp)
    4cf4:	0141                	addi	sp,sp,16
    4cf6:	8082                	ret

0000000000004cf8 <strchr>:

char*
strchr(const char *s, char c)
{
    4cf8:	1141                	addi	sp,sp,-16
    4cfa:	e406                	sd	ra,8(sp)
    4cfc:	e022                	sd	s0,0(sp)
    4cfe:	0800                	addi	s0,sp,16
  for(; *s; s++)
    4d00:	00054783          	lbu	a5,0(a0)
    4d04:	c799                	beqz	a5,4d12 <strchr+0x1a>
    if(*s == c)
    4d06:	00f58763          	beq	a1,a5,4d14 <strchr+0x1c>
  for(; *s; s++)
    4d0a:	0505                	addi	a0,a0,1
    4d0c:	00054783          	lbu	a5,0(a0)
    4d10:	fbfd                	bnez	a5,4d06 <strchr+0xe>
      return (char*)s;
  return 0;
    4d12:	4501                	li	a0,0
}
    4d14:	60a2                	ld	ra,8(sp)
    4d16:	6402                	ld	s0,0(sp)
    4d18:	0141                	addi	sp,sp,16
    4d1a:	8082                	ret

0000000000004d1c <gets>:

char*
gets(char *buf, int max)
{
    4d1c:	711d                	addi	sp,sp,-96
    4d1e:	ec86                	sd	ra,88(sp)
    4d20:	e8a2                	sd	s0,80(sp)
    4d22:	e4a6                	sd	s1,72(sp)
    4d24:	e0ca                	sd	s2,64(sp)
    4d26:	fc4e                	sd	s3,56(sp)
    4d28:	f852                	sd	s4,48(sp)
    4d2a:	f456                	sd	s5,40(sp)
    4d2c:	f05a                	sd	s6,32(sp)
    4d2e:	ec5e                	sd	s7,24(sp)
    4d30:	e862                	sd	s8,16(sp)
    4d32:	1080                	addi	s0,sp,96
    4d34:	8baa                	mv	s7,a0
    4d36:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    4d38:	892a                	mv	s2,a0
    4d3a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    4d3c:	faf40b13          	addi	s6,s0,-81
    4d40:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
    4d42:	8c26                	mv	s8,s1
    4d44:	0014899b          	addiw	s3,s1,1
    4d48:	84ce                	mv	s1,s3
    4d4a:	0349d863          	bge	s3,s4,4d7a <gets+0x5e>
    cc = read(0, &c, 1);
    4d4e:	8656                	mv	a2,s5
    4d50:	85da                	mv	a1,s6
    4d52:	4501                	li	a0,0
    4d54:	1c0000ef          	jal	4f14 <read>
    if(cc < 1)
    4d58:	02a05163          	blez	a0,4d7a <gets+0x5e>
      break;
    buf[i++] = c;
    4d5c:	faf44783          	lbu	a5,-81(s0)
    4d60:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    4d64:	0905                	addi	s2,s2,1
    4d66:	ff678713          	addi	a4,a5,-10
    4d6a:	00173713          	seqz	a4,a4
    4d6e:	17cd                	addi	a5,a5,-13
    4d70:	0017b793          	seqz	a5,a5
    4d74:	8fd9                	or	a5,a5,a4
    4d76:	d7f1                	beqz	a5,4d42 <gets+0x26>
    buf[i++] = c;
    4d78:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
    4d7a:	9c5e                	add	s8,s8,s7
    4d7c:	000c0023          	sb	zero,0(s8)
  return buf;
}
    4d80:	855e                	mv	a0,s7
    4d82:	60e6                	ld	ra,88(sp)
    4d84:	6446                	ld	s0,80(sp)
    4d86:	64a6                	ld	s1,72(sp)
    4d88:	6906                	ld	s2,64(sp)
    4d8a:	79e2                	ld	s3,56(sp)
    4d8c:	7a42                	ld	s4,48(sp)
    4d8e:	7aa2                	ld	s5,40(sp)
    4d90:	7b02                	ld	s6,32(sp)
    4d92:	6be2                	ld	s7,24(sp)
    4d94:	6c42                	ld	s8,16(sp)
    4d96:	6125                	addi	sp,sp,96
    4d98:	8082                	ret

0000000000004d9a <stat>:

int
stat(const char *n, struct stat *st)
{
    4d9a:	1101                	addi	sp,sp,-32
    4d9c:	ec06                	sd	ra,24(sp)
    4d9e:	e822                	sd	s0,16(sp)
    4da0:	e04a                	sd	s2,0(sp)
    4da2:	1000                	addi	s0,sp,32
    4da4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    4da6:	4581                	li	a1,0
    4da8:	194000ef          	jal	4f3c <open>
  if(fd < 0)
    4dac:	02054263          	bltz	a0,4dd0 <stat+0x36>
    4db0:	e426                	sd	s1,8(sp)
    4db2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    4db4:	85ca                	mv	a1,s2
    4db6:	19e000ef          	jal	4f54 <fstat>
    4dba:	892a                	mv	s2,a0
  close(fd);
    4dbc:	8526                	mv	a0,s1
    4dbe:	166000ef          	jal	4f24 <close>
  return r;
    4dc2:	64a2                	ld	s1,8(sp)
}
    4dc4:	854a                	mv	a0,s2
    4dc6:	60e2                	ld	ra,24(sp)
    4dc8:	6442                	ld	s0,16(sp)
    4dca:	6902                	ld	s2,0(sp)
    4dcc:	6105                	addi	sp,sp,32
    4dce:	8082                	ret
    return -1;
    4dd0:	57fd                	li	a5,-1
    4dd2:	893e                	mv	s2,a5
    4dd4:	bfc5                	j	4dc4 <stat+0x2a>

0000000000004dd6 <atoi>:

int
atoi(const char *s)
{
    4dd6:	1141                	addi	sp,sp,-16
    4dd8:	e406                	sd	ra,8(sp)
    4dda:	e022                	sd	s0,0(sp)
    4ddc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    4dde:	00054683          	lbu	a3,0(a0)
    4de2:	fd06879b          	addiw	a5,a3,-48 # 3ffd0 <base+0x31328>
    4de6:	0ff7f793          	zext.b	a5,a5
    4dea:	4625                	li	a2,9
    4dec:	02f66963          	bltu	a2,a5,4e1e <atoi+0x48>
    4df0:	872a                	mv	a4,a0
  n = 0;
    4df2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    4df4:	0705                	addi	a4,a4,1 # 1000001 <base+0xff1359>
    4df6:	0025179b          	slliw	a5,a0,0x2
    4dfa:	9fa9                	addw	a5,a5,a0
    4dfc:	0017979b          	slliw	a5,a5,0x1
    4e00:	9fb5                	addw	a5,a5,a3
    4e02:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    4e06:	00074683          	lbu	a3,0(a4)
    4e0a:	fd06879b          	addiw	a5,a3,-48
    4e0e:	0ff7f793          	zext.b	a5,a5
    4e12:	fef671e3          	bgeu	a2,a5,4df4 <atoi+0x1e>
  return n;
}
    4e16:	60a2                	ld	ra,8(sp)
    4e18:	6402                	ld	s0,0(sp)
    4e1a:	0141                	addi	sp,sp,16
    4e1c:	8082                	ret
  n = 0;
    4e1e:	4501                	li	a0,0
    4e20:	bfdd                	j	4e16 <atoi+0x40>

0000000000004e22 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    4e22:	1141                	addi	sp,sp,-16
    4e24:	e406                	sd	ra,8(sp)
    4e26:	e022                	sd	s0,0(sp)
    4e28:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    4e2a:	02b57563          	bgeu	a0,a1,4e54 <memmove+0x32>
    while(n-- > 0)
    4e2e:	00c05f63          	blez	a2,4e4c <memmove+0x2a>
    4e32:	1602                	slli	a2,a2,0x20
    4e34:	9201                	srli	a2,a2,0x20
    4e36:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    4e3a:	872a                	mv	a4,a0
      *dst++ = *src++;
    4e3c:	0585                	addi	a1,a1,1
    4e3e:	0705                	addi	a4,a4,1
    4e40:	fff5c683          	lbu	a3,-1(a1)
    4e44:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    4e48:	fee79ae3          	bne	a5,a4,4e3c <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    4e4c:	60a2                	ld	ra,8(sp)
    4e4e:	6402                	ld	s0,0(sp)
    4e50:	0141                	addi	sp,sp,16
    4e52:	8082                	ret
    while(n-- > 0)
    4e54:	fec05ce3          	blez	a2,4e4c <memmove+0x2a>
    dst += n;
    4e58:	00c50733          	add	a4,a0,a2
    src += n;
    4e5c:	95b2                	add	a1,a1,a2
    4e5e:	fff6079b          	addiw	a5,a2,-1
    4e62:	1782                	slli	a5,a5,0x20
    4e64:	9381                	srli	a5,a5,0x20
    4e66:	fff7c793          	not	a5,a5
    4e6a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    4e6c:	15fd                	addi	a1,a1,-1
    4e6e:	177d                	addi	a4,a4,-1
    4e70:	0005c683          	lbu	a3,0(a1)
    4e74:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    4e78:	fef71ae3          	bne	a4,a5,4e6c <memmove+0x4a>
    4e7c:	bfc1                	j	4e4c <memmove+0x2a>

0000000000004e7e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    4e7e:	1141                	addi	sp,sp,-16
    4e80:	e406                	sd	ra,8(sp)
    4e82:	e022                	sd	s0,0(sp)
    4e84:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    4e86:	ce19                	beqz	a2,4ea4 <memcmp+0x26>
    4e88:	1602                	slli	a2,a2,0x20
    4e8a:	9201                	srli	a2,a2,0x20
    4e8c:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
    4e90:	00054783          	lbu	a5,0(a0)
    4e94:	0005c703          	lbu	a4,0(a1)
    4e98:	00e79b63          	bne	a5,a4,4eae <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
    4e9c:	0505                	addi	a0,a0,1
    p2++;
    4e9e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    4ea0:	fed518e3          	bne	a0,a3,4e90 <memcmp+0x12>
  }
  return 0;
    4ea4:	4501                	li	a0,0
}
    4ea6:	60a2                	ld	ra,8(sp)
    4ea8:	6402                	ld	s0,0(sp)
    4eaa:	0141                	addi	sp,sp,16
    4eac:	8082                	ret
      return *p1 - *p2;
    4eae:	40e7853b          	subw	a0,a5,a4
    4eb2:	bfd5                	j	4ea6 <memcmp+0x28>

0000000000004eb4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    4eb4:	1141                	addi	sp,sp,-16
    4eb6:	e406                	sd	ra,8(sp)
    4eb8:	e022                	sd	s0,0(sp)
    4eba:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    4ebc:	f67ff0ef          	jal	4e22 <memmove>
}
    4ec0:	60a2                	ld	ra,8(sp)
    4ec2:	6402                	ld	s0,0(sp)
    4ec4:	0141                	addi	sp,sp,16
    4ec6:	8082                	ret

0000000000004ec8 <sbrk>:

char *
sbrk(int n) {
    4ec8:	1141                	addi	sp,sp,-16
    4eca:	e406                	sd	ra,8(sp)
    4ecc:	e022                	sd	s0,0(sp)
    4ece:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
    4ed0:	4585                	li	a1,1
    4ed2:	0b2000ef          	jal	4f84 <sys_sbrk>
}
    4ed6:	60a2                	ld	ra,8(sp)
    4ed8:	6402                	ld	s0,0(sp)
    4eda:	0141                	addi	sp,sp,16
    4edc:	8082                	ret

0000000000004ede <sbrklazy>:

char *
sbrklazy(int n) {
    4ede:	1141                	addi	sp,sp,-16
    4ee0:	e406                	sd	ra,8(sp)
    4ee2:	e022                	sd	s0,0(sp)
    4ee4:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
    4ee6:	4589                	li	a1,2
    4ee8:	09c000ef          	jal	4f84 <sys_sbrk>
}
    4eec:	60a2                	ld	ra,8(sp)
    4eee:	6402                	ld	s0,0(sp)
    4ef0:	0141                	addi	sp,sp,16
    4ef2:	8082                	ret

0000000000004ef4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    4ef4:	4885                	li	a7,1
 ecall
    4ef6:	00000073          	ecall
 ret
    4efa:	8082                	ret

0000000000004efc <exit>:
.global exit
exit:
 li a7, SYS_exit
    4efc:	4889                	li	a7,2
 ecall
    4efe:	00000073          	ecall
 ret
    4f02:	8082                	ret

0000000000004f04 <wait>:
.global wait
wait:
 li a7, SYS_wait
    4f04:	488d                	li	a7,3
 ecall
    4f06:	00000073          	ecall
 ret
    4f0a:	8082                	ret

0000000000004f0c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    4f0c:	4891                	li	a7,4
 ecall
    4f0e:	00000073          	ecall
 ret
    4f12:	8082                	ret

0000000000004f14 <read>:
.global read
read:
 li a7, SYS_read
    4f14:	4895                	li	a7,5
 ecall
    4f16:	00000073          	ecall
 ret
    4f1a:	8082                	ret

0000000000004f1c <write>:
.global write
write:
 li a7, SYS_write
    4f1c:	48c1                	li	a7,16
 ecall
    4f1e:	00000073          	ecall
 ret
    4f22:	8082                	ret

0000000000004f24 <close>:
.global close
close:
 li a7, SYS_close
    4f24:	48d5                	li	a7,21
 ecall
    4f26:	00000073          	ecall
 ret
    4f2a:	8082                	ret

0000000000004f2c <kill>:
.global kill
kill:
 li a7, SYS_kill
    4f2c:	4899                	li	a7,6
 ecall
    4f2e:	00000073          	ecall
 ret
    4f32:	8082                	ret

0000000000004f34 <exec>:
.global exec
exec:
 li a7, SYS_exec
    4f34:	489d                	li	a7,7
 ecall
    4f36:	00000073          	ecall
 ret
    4f3a:	8082                	ret

0000000000004f3c <open>:
.global open
open:
 li a7, SYS_open
    4f3c:	48bd                	li	a7,15
 ecall
    4f3e:	00000073          	ecall
 ret
    4f42:	8082                	ret

0000000000004f44 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    4f44:	48c5                	li	a7,17
 ecall
    4f46:	00000073          	ecall
 ret
    4f4a:	8082                	ret

0000000000004f4c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    4f4c:	48c9                	li	a7,18
 ecall
    4f4e:	00000073          	ecall
 ret
    4f52:	8082                	ret

0000000000004f54 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    4f54:	48a1                	li	a7,8
 ecall
    4f56:	00000073          	ecall
 ret
    4f5a:	8082                	ret

0000000000004f5c <link>:
.global link
link:
 li a7, SYS_link
    4f5c:	48cd                	li	a7,19
 ecall
    4f5e:	00000073          	ecall
 ret
    4f62:	8082                	ret

0000000000004f64 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    4f64:	48d1                	li	a7,20
 ecall
    4f66:	00000073          	ecall
 ret
    4f6a:	8082                	ret

0000000000004f6c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    4f6c:	48a5                	li	a7,9
 ecall
    4f6e:	00000073          	ecall
 ret
    4f72:	8082                	ret

0000000000004f74 <dup>:
.global dup
dup:
 li a7, SYS_dup
    4f74:	48a9                	li	a7,10
 ecall
    4f76:	00000073          	ecall
 ret
    4f7a:	8082                	ret

0000000000004f7c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    4f7c:	48ad                	li	a7,11
 ecall
    4f7e:	00000073          	ecall
 ret
    4f82:	8082                	ret

0000000000004f84 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
    4f84:	48b1                	li	a7,12
 ecall
    4f86:	00000073          	ecall
 ret
    4f8a:	8082                	ret

0000000000004f8c <pause>:
.global pause
pause:
 li a7, SYS_pause
    4f8c:	48b5                	li	a7,13
 ecall
    4f8e:	00000073          	ecall
 ret
    4f92:	8082                	ret

0000000000004f94 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    4f94:	48b9                	li	a7,14
 ecall
    4f96:	00000073          	ecall
 ret
    4f9a:	8082                	ret

0000000000004f9c <bind>:
.global bind
bind:
 li a7, SYS_bind
    4f9c:	48f5                	li	a7,29
 ecall
    4f9e:	00000073          	ecall
 ret
    4fa2:	8082                	ret

0000000000004fa4 <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
    4fa4:	48f9                	li	a7,30
 ecall
    4fa6:	00000073          	ecall
 ret
    4faa:	8082                	ret

0000000000004fac <send>:
.global send
send:
 li a7, SYS_send
    4fac:	48fd                	li	a7,31
 ecall
    4fae:	00000073          	ecall
 ret
    4fb2:	8082                	ret

0000000000004fb4 <recv>:
.global recv
recv:
 li a7, SYS_recv
    4fb4:	02000893          	li	a7,32
 ecall
    4fb8:	00000073          	ecall
 ret
    4fbc:	8082                	ret

0000000000004fbe <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
    4fbe:	02100893          	li	a7,33
 ecall
    4fc2:	00000073          	ecall
 ret
    4fc6:	8082                	ret

0000000000004fc8 <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
    4fc8:	02200893          	li	a7,34
 ecall
    4fcc:	00000073          	ecall
 ret
    4fd0:	8082                	ret

0000000000004fd2 <rwlktest>:
.global rwlktest
rwlktest:
 li a7, SYS_rwlktest
    4fd2:	02300893          	li	a7,35
 ecall
    4fd6:	00000073          	ecall
 ret
    4fda:	8082                	ret

0000000000004fdc <cpupin>:
.global cpupin
cpupin:
 li a7, SYS_cpupin
    4fdc:	02400893          	li	a7,36
 ecall
    4fe0:	00000073          	ecall
 ret
    4fe4:	8082                	ret

0000000000004fe6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    4fe6:	1101                	addi	sp,sp,-32
    4fe8:	ec06                	sd	ra,24(sp)
    4fea:	e822                	sd	s0,16(sp)
    4fec:	1000                	addi	s0,sp,32
    4fee:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    4ff2:	4605                	li	a2,1
    4ff4:	fef40593          	addi	a1,s0,-17
    4ff8:	f25ff0ef          	jal	4f1c <write>
}
    4ffc:	60e2                	ld	ra,24(sp)
    4ffe:	6442                	ld	s0,16(sp)
    5000:	6105                	addi	sp,sp,32
    5002:	8082                	ret

0000000000005004 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
    5004:	715d                	addi	sp,sp,-80
    5006:	e486                	sd	ra,72(sp)
    5008:	e0a2                	sd	s0,64(sp)
    500a:	f84a                	sd	s2,48(sp)
    500c:	f44e                	sd	s3,40(sp)
    500e:	0880                	addi	s0,sp,80
    5010:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
    5012:	00d036b3          	snez	a3,a3
    5016:	03f5d793          	srli	a5,a1,0x3f
    501a:	8efd                	and	a3,a3,a5
  neg = 0;
    501c:	4301                	li	t1,0
  if(sgn && xx < 0){
    501e:	c681                	beqz	a3,5026 <printint+0x22>
    neg = 1;
    x = -xx;
    5020:	40b005b3          	neg	a1,a1
    neg = 1;
    5024:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
    5026:	fb840993          	addi	s3,s0,-72
  neg = 0;
    502a:	86ce                	mv	a3,s3
  i = 0;
    502c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    502e:	00003817          	auipc	a6,0x3
    5032:	aea80813          	addi	a6,a6,-1302 # 7b18 <digits>
    5036:	88ba                	mv	a7,a4
    5038:	0017051b          	addiw	a0,a4,1
    503c:	872a                	mv	a4,a0
    503e:	02c5f7b3          	remu	a5,a1,a2
    5042:	97c2                	add	a5,a5,a6
    5044:	0007c783          	lbu	a5,0(a5)
    5048:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    504c:	87ae                	mv	a5,a1
    504e:	02c5d5b3          	divu	a1,a1,a2
    5052:	0685                	addi	a3,a3,1
    5054:	fec7f1e3          	bgeu	a5,a2,5036 <printint+0x32>
  if(neg)
    5058:	00030b63          	beqz	t1,506e <printint+0x6a>
    buf[i++] = '-';
    505c:	fd040793          	addi	a5,s0,-48
    5060:	953e                	add	a0,a0,a5
    5062:	02d00793          	li	a5,45
    5066:	fef50423          	sb	a5,-24(a0)
    506a:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
    506e:	02e05563          	blez	a4,5098 <printint+0x94>
    5072:	fc26                	sd	s1,56(sp)
    5074:	377d                	addiw	a4,a4,-1
    5076:	00e984b3          	add	s1,s3,a4
    507a:	19fd                	addi	s3,s3,-1 # fff <bigdir+0x10b>
    507c:	99ba                	add	s3,s3,a4
    507e:	1702                	slli	a4,a4,0x20
    5080:	9301                	srli	a4,a4,0x20
    5082:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    5086:	0004c583          	lbu	a1,0(s1)
    508a:	854a                	mv	a0,s2
    508c:	f5bff0ef          	jal	4fe6 <putc>
  while(--i >= 0)
    5090:	14fd                	addi	s1,s1,-1
    5092:	ff349ae3          	bne	s1,s3,5086 <printint+0x82>
    5096:	74e2                	ld	s1,56(sp)
}
    5098:	60a6                	ld	ra,72(sp)
    509a:	6406                	ld	s0,64(sp)
    509c:	7942                	ld	s2,48(sp)
    509e:	79a2                	ld	s3,40(sp)
    50a0:	6161                	addi	sp,sp,80
    50a2:	8082                	ret

00000000000050a4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    50a4:	711d                	addi	sp,sp,-96
    50a6:	ec86                	sd	ra,88(sp)
    50a8:	e8a2                	sd	s0,80(sp)
    50aa:	e4a6                	sd	s1,72(sp)
    50ac:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    50ae:	0005c483          	lbu	s1,0(a1)
    50b2:	2a048063          	beqz	s1,5352 <vprintf+0x2ae>
    50b6:	e0ca                	sd	s2,64(sp)
    50b8:	fc4e                	sd	s3,56(sp)
    50ba:	f852                	sd	s4,48(sp)
    50bc:	f456                	sd	s5,40(sp)
    50be:	f05a                	sd	s6,32(sp)
    50c0:	ec5e                	sd	s7,24(sp)
    50c2:	e862                	sd	s8,16(sp)
    50c4:	8b2a                	mv	s6,a0
    50c6:	8a2e                	mv	s4,a1
    50c8:	8bb2                	mv	s7,a2
  state = 0;
    50ca:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
    50cc:	4901                	li	s2,0
    50ce:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
    50d0:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
    50d4:	06400c13          	li	s8,100
    50d8:	a00d                	j	50fa <vprintf+0x56>
        putc(fd, c0);
    50da:	85a6                	mv	a1,s1
    50dc:	855a                	mv	a0,s6
    50de:	f09ff0ef          	jal	4fe6 <putc>
    50e2:	a019                	j	50e8 <vprintf+0x44>
    } else if(state == '%'){
    50e4:	03598363          	beq	s3,s5,510a <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
    50e8:	0019079b          	addiw	a5,s2,1
    50ec:	893e                	mv	s2,a5
    50ee:	873e                	mv	a4,a5
    50f0:	97d2                	add	a5,a5,s4
    50f2:	0007c483          	lbu	s1,0(a5)
    50f6:	24048763          	beqz	s1,5344 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
    50fa:	0004879b          	sext.w	a5,s1
    if(state == 0){
    50fe:	fe0993e3          	bnez	s3,50e4 <vprintf+0x40>
      if(c0 == '%'){
    5102:	fd579ce3          	bne	a5,s5,50da <vprintf+0x36>
        state = '%';
    5106:	89be                	mv	s3,a5
    5108:	b7c5                	j	50e8 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
    510a:	00ea06b3          	add	a3,s4,a4
    510e:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
    5112:	24060563          	beqz	a2,535c <vprintf+0x2b8>
      if(c0 == 'd'){
    5116:	0b878763          	beq	a5,s8,51c4 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
    511a:	f9478693          	addi	a3,a5,-108
    511e:	0016b693          	seqz	a3,a3
    5122:	f9c60593          	addi	a1,a2,-100
    5126:	0015b593          	seqz	a1,a1
    512a:	8df5                	and	a1,a1,a3
    512c:	e9c5                	bnez	a1,51dc <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
    512e:	9752                	add	a4,a4,s4
    5130:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    5134:	f9460713          	addi	a4,a2,-108
    5138:	00173713          	seqz	a4,a4
    513c:	8f75                	and	a4,a4,a3
    513e:	f9c50593          	addi	a1,a0,-100
    5142:	0015b593          	seqz	a1,a1
    5146:	8df9                	and	a1,a1,a4
    5148:	e5dd                	bnez	a1,51f6 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
    514a:	07500593          	li	a1,117
    514e:	0cb78163          	beq	a5,a1,5210 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
    5152:	f8b60593          	addi	a1,a2,-117
    5156:	0015b593          	seqz	a1,a1
    515a:	8df5                	and	a1,a1,a3
    515c:	e5f1                	bnez	a1,5228 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    515e:	f8b50593          	addi	a1,a0,-117
    5162:	0015b593          	seqz	a1,a1
    5166:	8df9                	and	a1,a1,a4
    5168:	ede9                	bnez	a1,5242 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
    516a:	07800593          	li	a1,120
    516e:	0eb78763          	beq	a5,a1,525c <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
    5172:	f8860613          	addi	a2,a2,-120
    5176:	00163613          	seqz	a2,a2
    517a:	8ef1                	and	a3,a3,a2
    517c:	0e069c63          	bnez	a3,5274 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    5180:	f8850513          	addi	a0,a0,-120
    5184:	00153513          	seqz	a0,a0
    5188:	8f69                	and	a4,a4,a0
    518a:	10071263          	bnez	a4,528e <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
    518e:	07000713          	li	a4,112
    5192:	10e78a63          	beq	a5,a4,52a6 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
    5196:	06300713          	li	a4,99
    519a:	14e78a63          	beq	a5,a4,52ee <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
    519e:	07300713          	li	a4,115
    51a2:	16e78063          	beq	a5,a4,5302 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
    51a6:	02500713          	li	a4,37
    51aa:	18e78863          	beq	a5,a4,533a <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    51ae:	02500593          	li	a1,37
    51b2:	855a                	mv	a0,s6
    51b4:	e33ff0ef          	jal	4fe6 <putc>
        putc(fd, c0);
    51b8:	85a6                	mv	a1,s1
    51ba:	855a                	mv	a0,s6
    51bc:	e2bff0ef          	jal	4fe6 <putc>
      }

      state = 0;
    51c0:	4981                	li	s3,0
    51c2:	b71d                	j	50e8 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
    51c4:	008b8493          	addi	s1,s7,8
    51c8:	4685                	li	a3,1
    51ca:	4629                	li	a2,10
    51cc:	000ba583          	lw	a1,0(s7)
    51d0:	855a                	mv	a0,s6
    51d2:	e33ff0ef          	jal	5004 <printint>
    51d6:	8ba6                	mv	s7,s1
      state = 0;
    51d8:	4981                	li	s3,0
    51da:	b739                	j	50e8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
    51dc:	008b8493          	addi	s1,s7,8
    51e0:	4685                	li	a3,1
    51e2:	4629                	li	a2,10
    51e4:	000bb583          	ld	a1,0(s7)
    51e8:	855a                	mv	a0,s6
    51ea:	e1bff0ef          	jal	5004 <printint>
        i += 1;
    51ee:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    51f0:	8ba6                	mv	s7,s1
      state = 0;
    51f2:	4981                	li	s3,0
    51f4:	bdd5                	j	50e8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
    51f6:	008b8493          	addi	s1,s7,8
    51fa:	4685                	li	a3,1
    51fc:	4629                	li	a2,10
    51fe:	000bb583          	ld	a1,0(s7)
    5202:	855a                	mv	a0,s6
    5204:	e01ff0ef          	jal	5004 <printint>
        i += 2;
    5208:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    520a:	8ba6                	mv	s7,s1
      state = 0;
    520c:	4981                	li	s3,0
        i += 2;
    520e:	bde9                	j	50e8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
    5210:	008b8493          	addi	s1,s7,8
    5214:	4681                	li	a3,0
    5216:	4629                	li	a2,10
    5218:	000be583          	lwu	a1,0(s7)
    521c:	855a                	mv	a0,s6
    521e:	de7ff0ef          	jal	5004 <printint>
    5222:	8ba6                	mv	s7,s1
      state = 0;
    5224:	4981                	li	s3,0
    5226:	b5c9                	j	50e8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5228:	008b8493          	addi	s1,s7,8
    522c:	4681                	li	a3,0
    522e:	4629                	li	a2,10
    5230:	000bb583          	ld	a1,0(s7)
    5234:	855a                	mv	a0,s6
    5236:	dcfff0ef          	jal	5004 <printint>
        i += 1;
    523a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    523c:	8ba6                	mv	s7,s1
      state = 0;
    523e:	4981                	li	s3,0
    5240:	b565                	j	50e8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5242:	008b8493          	addi	s1,s7,8
    5246:	4681                	li	a3,0
    5248:	4629                	li	a2,10
    524a:	000bb583          	ld	a1,0(s7)
    524e:	855a                	mv	a0,s6
    5250:	db5ff0ef          	jal	5004 <printint>
        i += 2;
    5254:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    5256:	8ba6                	mv	s7,s1
      state = 0;
    5258:	4981                	li	s3,0
        i += 2;
    525a:	b579                	j	50e8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
    525c:	008b8493          	addi	s1,s7,8
    5260:	4681                	li	a3,0
    5262:	4641                	li	a2,16
    5264:	000be583          	lwu	a1,0(s7)
    5268:	855a                	mv	a0,s6
    526a:	d9bff0ef          	jal	5004 <printint>
    526e:	8ba6                	mv	s7,s1
      state = 0;
    5270:	4981                	li	s3,0
    5272:	bd9d                	j	50e8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
    5274:	008b8493          	addi	s1,s7,8
    5278:	4681                	li	a3,0
    527a:	4641                	li	a2,16
    527c:	000bb583          	ld	a1,0(s7)
    5280:	855a                	mv	a0,s6
    5282:	d83ff0ef          	jal	5004 <printint>
        i += 1;
    5286:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    5288:	8ba6                	mv	s7,s1
      state = 0;
    528a:	4981                	li	s3,0
    528c:	bdb1                	j	50e8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
    528e:	008b8493          	addi	s1,s7,8
    5292:	4641                	li	a2,16
    5294:	000bb583          	ld	a1,0(s7)
    5298:	855a                	mv	a0,s6
    529a:	d6bff0ef          	jal	5004 <printint>
        i += 2;
    529e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    52a0:	8ba6                	mv	s7,s1
      state = 0;
    52a2:	4981                	li	s3,0
        i += 2;
    52a4:	b591                	j	50e8 <vprintf+0x44>
    52a6:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
    52a8:	008b8793          	addi	a5,s7,8
    52ac:	8cbe                	mv	s9,a5
    52ae:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    52b2:	03000593          	li	a1,48
    52b6:	855a                	mv	a0,s6
    52b8:	d2fff0ef          	jal	4fe6 <putc>
  putc(fd, 'x');
    52bc:	07800593          	li	a1,120
    52c0:	855a                	mv	a0,s6
    52c2:	d25ff0ef          	jal	4fe6 <putc>
    52c6:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    52c8:	00003b97          	auipc	s7,0x3
    52cc:	850b8b93          	addi	s7,s7,-1968 # 7b18 <digits>
    52d0:	03c9d793          	srli	a5,s3,0x3c
    52d4:	97de                	add	a5,a5,s7
    52d6:	0007c583          	lbu	a1,0(a5)
    52da:	855a                	mv	a0,s6
    52dc:	d0bff0ef          	jal	4fe6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    52e0:	0992                	slli	s3,s3,0x4
    52e2:	34fd                	addiw	s1,s1,-1
    52e4:	f4f5                	bnez	s1,52d0 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
    52e6:	8be6                	mv	s7,s9
      state = 0;
    52e8:	4981                	li	s3,0
    52ea:	6ca2                	ld	s9,8(sp)
    52ec:	bbf5                	j	50e8 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
    52ee:	008b8493          	addi	s1,s7,8
    52f2:	000bc583          	lbu	a1,0(s7)
    52f6:	855a                	mv	a0,s6
    52f8:	cefff0ef          	jal	4fe6 <putc>
    52fc:	8ba6                	mv	s7,s1
      state = 0;
    52fe:	4981                	li	s3,0
    5300:	b3e5                	j	50e8 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
    5302:	008b8993          	addi	s3,s7,8
    5306:	000bb483          	ld	s1,0(s7)
    530a:	cc91                	beqz	s1,5326 <vprintf+0x282>
        for(; *s; s++)
    530c:	0004c583          	lbu	a1,0(s1)
    5310:	c195                	beqz	a1,5334 <vprintf+0x290>
          putc(fd, *s);
    5312:	855a                	mv	a0,s6
    5314:	cd3ff0ef          	jal	4fe6 <putc>
        for(; *s; s++)
    5318:	0485                	addi	s1,s1,1
    531a:	0004c583          	lbu	a1,0(s1)
    531e:	f9f5                	bnez	a1,5312 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
    5320:	8bce                	mv	s7,s3
      state = 0;
    5322:	4981                	li	s3,0
    5324:	b3d1                	j	50e8 <vprintf+0x44>
          s = "(null)";
    5326:	00002497          	auipc	s1,0x2
    532a:	71a48493          	addi	s1,s1,1818 # 7a40 <statistics+0x24f6>
        for(; *s; s++)
    532e:	02800593          	li	a1,40
    5332:	b7c5                	j	5312 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
    5334:	8bce                	mv	s7,s3
      state = 0;
    5336:	4981                	li	s3,0
    5338:	bb45                	j	50e8 <vprintf+0x44>
        putc(fd, '%');
    533a:	85be                	mv	a1,a5
    533c:	855a                	mv	a0,s6
    533e:	ca9ff0ef          	jal	4fe6 <putc>
    5342:	bdbd                	j	51c0 <vprintf+0x11c>
    5344:	6906                	ld	s2,64(sp)
    5346:	79e2                	ld	s3,56(sp)
    5348:	7a42                	ld	s4,48(sp)
    534a:	7aa2                	ld	s5,40(sp)
    534c:	7b02                	ld	s6,32(sp)
    534e:	6be2                	ld	s7,24(sp)
    5350:	6c42                	ld	s8,16(sp)
    }
  }
}
    5352:	60e6                	ld	ra,88(sp)
    5354:	6446                	ld	s0,80(sp)
    5356:	64a6                	ld	s1,72(sp)
    5358:	6125                	addi	sp,sp,96
    535a:	8082                	ret
      if(c0 == 'd'){
    535c:	06400713          	li	a4,100
    5360:	e6e782e3          	beq	a5,a4,51c4 <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
    5364:	f9478693          	addi	a3,a5,-108
    5368:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
    536c:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    536e:	4701                	li	a4,0
    5370:	bbe9                	j	514a <vprintf+0xa6>

0000000000005372 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    5372:	715d                	addi	sp,sp,-80
    5374:	ec06                	sd	ra,24(sp)
    5376:	e822                	sd	s0,16(sp)
    5378:	1000                	addi	s0,sp,32
    537a:	e010                	sd	a2,0(s0)
    537c:	e414                	sd	a3,8(s0)
    537e:	e818                	sd	a4,16(s0)
    5380:	ec1c                	sd	a5,24(s0)
    5382:	03043023          	sd	a6,32(s0)
    5386:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    538a:	8622                	mv	a2,s0
    538c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5390:	d15ff0ef          	jal	50a4 <vprintf>
}
    5394:	60e2                	ld	ra,24(sp)
    5396:	6442                	ld	s0,16(sp)
    5398:	6161                	addi	sp,sp,80
    539a:	8082                	ret

000000000000539c <printf>:

void
printf(const char *fmt, ...)
{
    539c:	711d                	addi	sp,sp,-96
    539e:	ec06                	sd	ra,24(sp)
    53a0:	e822                	sd	s0,16(sp)
    53a2:	1000                	addi	s0,sp,32
    53a4:	e40c                	sd	a1,8(s0)
    53a6:	e810                	sd	a2,16(s0)
    53a8:	ec14                	sd	a3,24(s0)
    53aa:	f018                	sd	a4,32(s0)
    53ac:	f41c                	sd	a5,40(s0)
    53ae:	03043823          	sd	a6,48(s0)
    53b2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    53b6:	00840613          	addi	a2,s0,8
    53ba:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    53be:	85aa                	mv	a1,a0
    53c0:	4505                	li	a0,1
    53c2:	ce3ff0ef          	jal	50a4 <vprintf>
}
    53c6:	60e2                	ld	ra,24(sp)
    53c8:	6442                	ld	s0,16(sp)
    53ca:	6125                	addi	sp,sp,96
    53cc:	8082                	ret

00000000000053ce <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    53ce:	1141                	addi	sp,sp,-16
    53d0:	e406                	sd	ra,8(sp)
    53d2:	e022                	sd	s0,0(sp)
    53d4:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    53d6:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    53da:	00003797          	auipc	a5,0x3
    53de:	0a67b783          	ld	a5,166(a5) # 8480 <freep>
    53e2:	a095                	j	5446 <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    53e4:	ff852583          	lw	a1,-8(a0)
    53e8:	6390                	ld	a2,0(a5)
    53ea:	02059813          	slli	a6,a1,0x20
    53ee:	01c85693          	srli	a3,a6,0x1c
    53f2:	96ba                	add	a3,a3,a4
    53f4:	02d60563          	beq	a2,a3,541e <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    53f8:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    53fc:	4790                	lw	a2,8(a5)
    53fe:	02061593          	slli	a1,a2,0x20
    5402:	01c5d693          	srli	a3,a1,0x1c
    5406:	96be                	add	a3,a3,a5
    5408:	02d70263          	beq	a4,a3,542c <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    540c:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    540e:	00003717          	auipc	a4,0x3
    5412:	06f73923          	sd	a5,114(a4) # 8480 <freep>
}
    5416:	60a2                	ld	ra,8(sp)
    5418:	6402                	ld	s0,0(sp)
    541a:	0141                	addi	sp,sp,16
    541c:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
    541e:	4614                	lw	a3,8(a2)
    5420:	9ead                	addw	a3,a3,a1
    5422:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    5426:	6394                	ld	a3,0(a5)
    5428:	6290                	ld	a2,0(a3)
    542a:	b7f9                	j	53f8 <free+0x2a>
    p->s.size += bp->s.size;
    542c:	ff852703          	lw	a4,-8(a0)
    5430:	9f31                	addw	a4,a4,a2
    5432:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    5434:	ff053703          	ld	a4,-16(a0)
    5438:	bfd1                	j	540c <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    543a:	6394                	ld	a3,0(a5)
    543c:	00d7e463          	bltu	a5,a3,5444 <free+0x76>
    5440:	fad762e3          	bltu	a4,a3,53e4 <free+0x16>
    5444:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5446:	fee7fae3          	bgeu	a5,a4,543a <free+0x6c>
    544a:	6394                	ld	a3,0(a5)
    544c:	f8d76ce3          	bltu	a4,a3,53e4 <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5450:	f8d7fae3          	bgeu	a5,a3,53e4 <free+0x16>
    5454:	87b6                	mv	a5,a3
    5456:	bfc5                	j	5446 <free+0x78>

0000000000005458 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    5458:	7139                	addi	sp,sp,-64
    545a:	fc06                	sd	ra,56(sp)
    545c:	f822                	sd	s0,48(sp)
    545e:	f04a                	sd	s2,32(sp)
    5460:	ec4e                	sd	s3,24(sp)
    5462:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    5464:	02051993          	slli	s3,a0,0x20
    5468:	0209d993          	srli	s3,s3,0x20
    546c:	09bd                	addi	s3,s3,15
    546e:	0049d993          	srli	s3,s3,0x4
    5472:	2985                	addiw	s3,s3,1
    5474:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
    5476:	00003517          	auipc	a0,0x3
    547a:	00a53503          	ld	a0,10(a0) # 8480 <freep>
    547e:	c905                	beqz	a0,54ae <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5480:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    5482:	4798                	lw	a4,8(a5)
    5484:	09377663          	bgeu	a4,s3,5510 <malloc+0xb8>
    5488:	f426                	sd	s1,40(sp)
    548a:	e852                	sd	s4,16(sp)
    548c:	e456                	sd	s5,8(sp)
    548e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    5490:	8a4e                	mv	s4,s3
    5492:	6705                	lui	a4,0x1
    5494:	00e9f363          	bgeu	s3,a4,549a <malloc+0x42>
    5498:	6a05                	lui	s4,0x1
    549a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    549e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    54a2:	00003497          	auipc	s1,0x3
    54a6:	fde48493          	addi	s1,s1,-34 # 8480 <freep>
  if(p == SBRK_ERROR)
    54aa:	5afd                	li	s5,-1
    54ac:	a83d                	j	54ea <malloc+0x92>
    54ae:	f426                	sd	s1,40(sp)
    54b0:	e852                	sd	s4,16(sp)
    54b2:	e456                	sd	s5,8(sp)
    54b4:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    54b6:	00009797          	auipc	a5,0x9
    54ba:	7f278793          	addi	a5,a5,2034 # eca8 <base>
    54be:	00003717          	auipc	a4,0x3
    54c2:	fcf73123          	sd	a5,-62(a4) # 8480 <freep>
    54c6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    54c8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    54cc:	b7d1                	j	5490 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    54ce:	6398                	ld	a4,0(a5)
    54d0:	e118                	sd	a4,0(a0)
    54d2:	a899                	j	5528 <malloc+0xd0>
  hp->s.size = nu;
    54d4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    54d8:	0541                	addi	a0,a0,16
    54da:	ef5ff0ef          	jal	53ce <free>
  return freep;
    54de:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    54e0:	c125                	beqz	a0,5540 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    54e2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    54e4:	4798                	lw	a4,8(a5)
    54e6:	03277163          	bgeu	a4,s2,5508 <malloc+0xb0>
    if(p == freep)
    54ea:	6098                	ld	a4,0(s1)
    54ec:	853e                	mv	a0,a5
    54ee:	fef71ae3          	bne	a4,a5,54e2 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
    54f2:	8552                	mv	a0,s4
    54f4:	9d5ff0ef          	jal	4ec8 <sbrk>
  if(p == SBRK_ERROR)
    54f8:	fd551ee3          	bne	a0,s5,54d4 <malloc+0x7c>
        return 0;
    54fc:	4501                	li	a0,0
    54fe:	74a2                	ld	s1,40(sp)
    5500:	6a42                	ld	s4,16(sp)
    5502:	6aa2                	ld	s5,8(sp)
    5504:	6b02                	ld	s6,0(sp)
    5506:	a03d                	j	5534 <malloc+0xdc>
    5508:	74a2                	ld	s1,40(sp)
    550a:	6a42                	ld	s4,16(sp)
    550c:	6aa2                	ld	s5,8(sp)
    550e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    5510:	fae90fe3          	beq	s2,a4,54ce <malloc+0x76>
        p->s.size -= nunits;
    5514:	4137073b          	subw	a4,a4,s3
    5518:	c798                	sw	a4,8(a5)
        p += p->s.size;
    551a:	02071693          	slli	a3,a4,0x20
    551e:	01c6d713          	srli	a4,a3,0x1c
    5522:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    5524:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    5528:	00003717          	auipc	a4,0x3
    552c:	f4a73c23          	sd	a0,-168(a4) # 8480 <freep>
      return (void*)(p + 1);
    5530:	01078513          	addi	a0,a5,16
  }
}
    5534:	70e2                	ld	ra,56(sp)
    5536:	7442                	ld	s0,48(sp)
    5538:	7902                	ld	s2,32(sp)
    553a:	69e2                	ld	s3,24(sp)
    553c:	6121                	addi	sp,sp,64
    553e:	8082                	ret
    5540:	74a2                	ld	s1,40(sp)
    5542:	6a42                	ld	s4,16(sp)
    5544:	6aa2                	ld	s5,8(sp)
    5546:	6b02                	ld	s6,0(sp)
    5548:	b7f5                	j	5534 <malloc+0xdc>

000000000000554a <statistics>:
#include "kernel/fcntl.h"
#include "user/user.h"

int
statistics(void *buf, int sz)
{
    554a:	7179                	addi	sp,sp,-48
    554c:	f406                	sd	ra,40(sp)
    554e:	f022                	sd	s0,32(sp)
    5550:	ec26                	sd	s1,24(sp)
    5552:	e84a                	sd	s2,16(sp)
    5554:	e44e                	sd	s3,8(sp)
    5556:	e052                	sd	s4,0(sp)
    5558:	1800                	addi	s0,sp,48
    555a:	8a2a                	mv	s4,a0
    555c:	892e                	mv	s2,a1
  int fd, i, n;
  
  fd = open("statistics", O_RDONLY);
    555e:	4581                	li	a1,0
    5560:	00002517          	auipc	a0,0x2
    5564:	4e850513          	addi	a0,a0,1256 # 7a48 <statistics+0x24fe>
    5568:	9d5ff0ef          	jal	4f3c <open>
  if(fd < 0) {
    556c:	02054e63          	bltz	a0,55a8 <statistics+0x5e>
    5570:	89aa                	mv	s3,a0
      fprintf(2, "stats: open failed\n");
      exit(1);
  }
  for (i = 0; i < sz; ) {
    5572:	4481                	li	s1,0
    5574:	01205e63          	blez	s2,5590 <statistics+0x46>
    if ((n = read(fd, buf+i, sz-i)) < 0) {
    5578:	4099063b          	subw	a2,s2,s1
    557c:	009a05b3          	add	a1,s4,s1
    5580:	854e                	mv	a0,s3
    5582:	993ff0ef          	jal	4f14 <read>
    5586:	00054563          	bltz	a0,5590 <statistics+0x46>
      break;
    }
    i += n;
    558a:	9ca9                	addw	s1,s1,a0
  for (i = 0; i < sz; ) {
    558c:	ff24c6e3          	blt	s1,s2,5578 <statistics+0x2e>
  }
  close(fd);
    5590:	854e                	mv	a0,s3
    5592:	993ff0ef          	jal	4f24 <close>
  return i;
}
    5596:	8526                	mv	a0,s1
    5598:	70a2                	ld	ra,40(sp)
    559a:	7402                	ld	s0,32(sp)
    559c:	64e2                	ld	s1,24(sp)
    559e:	6942                	ld	s2,16(sp)
    55a0:	69a2                	ld	s3,8(sp)
    55a2:	6a02                	ld	s4,0(sp)
    55a4:	6145                	addi	sp,sp,48
    55a6:	8082                	ret
      fprintf(2, "stats: open failed\n");
    55a8:	00002597          	auipc	a1,0x2
    55ac:	4b058593          	addi	a1,a1,1200 # 7a58 <statistics+0x250e>
    55b0:	4509                	li	a0,2
    55b2:	dc1ff0ef          	jal	5372 <fprintf>
      exit(1);
    55b6:	4505                	li	a0,1
    55b8:	945ff0ef          	jal	4efc <exit>
