
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
  uint64 addrs[] = {0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
      10:	00008797          	auipc	a5,0x8
      14:	6d078793          	addi	a5,a5,1744 # 86e0 <malloc+0x2a2e>
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
                    0xffffffffffffffff};

  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
      36:	fa840493          	addi	s1,s0,-88
      3a:	fd040a13          	addi	s4,s0,-48
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE | O_WRONLY);
      3e:	20100993          	li	s3,513
      42:	0004b903          	ld	s2,0(s1)
      46:	85ce                	mv	a1,s3
      48:	854a                	mv	a0,s2
      4a:	776050ef          	jal	57c0 <open>
    if (fd >= 0) {
      4e:	00055d63          	bgez	a0,68 <copyinstr1+0x68>
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
      52:	04a1                	addi	s1,s1,8
      54:	ff4497e3          	bne	s1,s4,42 <copyinstr1+0x42>
      printf("open(%p) returned %d, not -1\n", (void *)addr, fd);
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
      printf("open(%p) returned %d, not -1\n", (void *)addr, fd);
      68:	862a                	mv	a2,a0
      6a:	85ca                	mv	a1,s2
      6c:	00006517          	auipc	a0,0x6
      70:	d4450513          	addi	a0,a0,-700 # 5db0 <malloc+0xfe>
      74:	383050ef          	jal	5bf6 <printf>
      exit(1);
      78:	4505                	li	a0,1
      7a:	706050ef          	jal	5780 <exit>

000000000000007e <bsstest>:
void
bsstest(char *s)
{
  int i;

  for (i = 0; i < sizeof(uninit); i++) {
      7e:	0000a797          	auipc	a5,0xa
      82:	56a78793          	addi	a5,a5,1386 # a5e8 <uninit>
      86:	0000d697          	auipc	a3,0xd
      8a:	c7268693          	addi	a3,a3,-910 # ccf8 <buf>
    if (uninit[i] != '\0') {
      8e:	0007c703          	lbu	a4,0(a5)
      92:	e709                	bnez	a4,9c <bsstest+0x1e>
  for (i = 0; i < sizeof(uninit); i++) {
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
      a6:	00006517          	auipc	a0,0x6
      aa:	d2a50513          	addi	a0,a0,-726 # 5dd0 <malloc+0x11e>
      ae:	349050ef          	jal	5bf6 <printf>
      exit(1);
      b2:	4505                	li	a0,1
      b4:	6cc050ef          	jal	5780 <exit>

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
      c6:	00006517          	auipc	a0,0x6
      ca:	d2250513          	addi	a0,a0,-734 # 5de8 <malloc+0x136>
      ce:	6f2050ef          	jal	57c0 <open>
  if (fd < 0) {
      d2:	02054263          	bltz	a0,f6 <opentest+0x3e>
  close(fd);
      d6:	6d2050ef          	jal	57a8 <close>
  fd = open("doesnotexist", 0);
      da:	4581                	li	a1,0
      dc:	00006517          	auipc	a0,0x6
      e0:	d2c50513          	addi	a0,a0,-724 # 5e08 <malloc+0x156>
      e4:	6dc050ef          	jal	57c0 <open>
  if (fd >= 0) {
      e8:	02055163          	bgez	a0,10a <opentest+0x52>
}
      ec:	60e2                	ld	ra,24(sp)
      ee:	6442                	ld	s0,16(sp)
      f0:	64a2                	ld	s1,8(sp)
      f2:	6105                	addi	sp,sp,32
      f4:	8082                	ret
    printf("%s: open echo failed!\n", s);
      f6:	85a6                	mv	a1,s1
      f8:	00006517          	auipc	a0,0x6
      fc:	cf850513          	addi	a0,a0,-776 # 5df0 <malloc+0x13e>
     100:	2f7050ef          	jal	5bf6 <printf>
    exit(1);
     104:	4505                	li	a0,1
     106:	67a050ef          	jal	5780 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     10a:	85a6                	mv	a1,s1
     10c:	00006517          	auipc	a0,0x6
     110:	d0c50513          	addi	a0,a0,-756 # 5e18 <malloc+0x166>
     114:	2e3050ef          	jal	5bf6 <printf>
    exit(1);
     118:	4505                	li	a0,1
     11a:	666050ef          	jal	5780 <exit>

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
     12e:	00006517          	auipc	a0,0x6
     132:	d1250513          	addi	a0,a0,-750 # 5e40 <malloc+0x18e>
     136:	69a050ef          	jal	57d0 <unlink>
  int fd1 = open("truncfile", O_CREATE | O_TRUNC | O_WRONLY);
     13a:	60100593          	li	a1,1537
     13e:	00006517          	auipc	a0,0x6
     142:	d0250513          	addi	a0,a0,-766 # 5e40 <malloc+0x18e>
     146:	67a050ef          	jal	57c0 <open>
     14a:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     14c:	4611                	li	a2,4
     14e:	00006597          	auipc	a1,0x6
     152:	d0258593          	addi	a1,a1,-766 # 5e50 <malloc+0x19e>
     156:	64a050ef          	jal	57a0 <write>
  int fd2 = open("truncfile", O_TRUNC | O_WRONLY);
     15a:	40100593          	li	a1,1025
     15e:	00006517          	auipc	a0,0x6
     162:	ce250513          	addi	a0,a0,-798 # 5e40 <malloc+0x18e>
     166:	65a050ef          	jal	57c0 <open>
     16a:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     16c:	4605                	li	a2,1
     16e:	00006597          	auipc	a1,0x6
     172:	cea58593          	addi	a1,a1,-790 # 5e58 <malloc+0x1a6>
     176:	8526                	mv	a0,s1
     178:	628050ef          	jal	57a0 <write>
  if (n != -1) {
     17c:	57fd                	li	a5,-1
     17e:	02f51563          	bne	a0,a5,1a8 <truncate2+0x8a>
  unlink("truncfile");
     182:	00006517          	auipc	a0,0x6
     186:	cbe50513          	addi	a0,a0,-834 # 5e40 <malloc+0x18e>
     18a:	646050ef          	jal	57d0 <unlink>
  close(fd1);
     18e:	8526                	mv	a0,s1
     190:	618050ef          	jal	57a8 <close>
  close(fd2);
     194:	854a                	mv	a0,s2
     196:	612050ef          	jal	57a8 <close>
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
     1ac:	00006517          	auipc	a0,0x6
     1b0:	cb450513          	addi	a0,a0,-844 # 5e60 <malloc+0x1ae>
     1b4:	243050ef          	jal	5bf6 <printf>
    exit(1);
     1b8:	4505                	li	a0,1
     1ba:	5c6050ef          	jal	5780 <exit>

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
    fd = open(name, O_CREATE | O_RDWR);
     1de:	fc840a13          	addi	s4,s0,-56
     1e2:	20200993          	li	s3,514
  for (i = 0; i < N; i++) {
     1e6:	06400913          	li	s2,100
    name[1] = '0' + i;
     1ea:	fc9404a3          	sb	s1,-55(s0)
    fd = open(name, O_CREATE | O_RDWR);
     1ee:	85ce                	mv	a1,s3
     1f0:	8552                	mv	a0,s4
     1f2:	5ce050ef          	jal	57c0 <open>
    close(fd);
     1f6:	5b2050ef          	jal	57a8 <close>
  for (i = 0; i < N; i++) {
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
  for (i = 0; i < N; i++) {
     218:	06400913          	li	s2,100
    name[1] = '0' + i;
     21c:	fc9404a3          	sb	s1,-55(s0)
    unlink(name);
     220:	854e                	mv	a0,s3
     222:	5ae050ef          	jal	57d0 <unlink>
  for (i = 0; i < N; i++) {
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
     25c:	00006517          	auipc	a0,0x6
     260:	c2c50513          	addi	a0,a0,-980 # 5e88 <malloc+0x1d6>
     264:	56c050ef          	jal	57d0 <unlink>
  for (sz = 499; sz < (MAXOPBLOCKS + 2) * BSIZE; sz += 471) {
     268:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     26c:	20200b93          	li	s7,514
     270:	00006a17          	auipc	s4,0x6
     274:	c18a0a13          	addi	s4,s4,-1000 # 5e88 <malloc+0x1d6>
    if (fd < 0) {
     278:	4b09                	li	s6,2
      int cc = write(fd, buf, sz);
     27a:	0000d997          	auipc	s3,0xd
     27e:	a7e98993          	addi	s3,s3,-1410 # ccf8 <buf>
  for (sz = 499; sz < (MAXOPBLOCKS + 2) * BSIZE; sz += 471) {
     282:	6ad5                	lui	s5,0x15
     284:	971a8a93          	addi	s5,s5,-1679 # 14971 <buf+0x7c79>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     288:	85de                	mv	a1,s7
     28a:	8552                	mv	a0,s4
     28c:	534050ef          	jal	57c0 <open>
     290:	892a                	mv	s2,a0
    if (fd < 0) {
     292:	04054463          	bltz	a0,2da <bigwrite+0x9a>
     296:	8c5a                	mv	s8,s6
      int cc = write(fd, buf, sz);
     298:	8626                	mv	a2,s1
     29a:	85ce                	mv	a1,s3
     29c:	854a                	mv	a0,s2
     29e:	502050ef          	jal	57a0 <write>
      if (cc != sz) {
     2a2:	04951663          	bne	a0,s1,2ee <bigwrite+0xae>
    for (i = 0; i < 2; i++) {
     2a6:	3c7d                	addiw	s8,s8,-1
     2a8:	fe0c18e3          	bnez	s8,298 <bigwrite+0x58>
    close(fd);
     2ac:	854a                	mv	a0,s2
     2ae:	4fa050ef          	jal	57a8 <close>
    unlink("bigwrite");
     2b2:	8552                	mv	a0,s4
     2b4:	51c050ef          	jal	57d0 <unlink>
  for (sz = 499; sz < (MAXOPBLOCKS + 2) * BSIZE; sz += 471) {
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
     2dc:	00006517          	auipc	a0,0x6
     2e0:	bbc50513          	addi	a0,a0,-1092 # 5e98 <malloc+0x1e6>
     2e4:	113050ef          	jal	5bf6 <printf>
      exit(1);
     2e8:	4505                	li	a0,1
     2ea:	496050ef          	jal	5780 <exit>
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     2ee:	86aa                	mv	a3,a0
     2f0:	8626                	mv	a2,s1
     2f2:	85e6                	mv	a1,s9
     2f4:	00006517          	auipc	a0,0x6
     2f8:	bc450513          	addi	a0,a0,-1084 # 5eb8 <malloc+0x206>
     2fc:	0fb050ef          	jal	5bf6 <printf>
        exit(1);
     300:	4505                	li	a0,1
     302:	47e050ef          	jal	5780 <exit>

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
     31a:	00006517          	auipc	a0,0x6
     31e:	bb650513          	addi	a0,a0,-1098 # 5ed0 <malloc+0x21e>
     322:	4ae050ef          	jal	57d0 <unlink>
     326:	25800913          	li	s2,600
  for (int i = 0; i < assumed_free; i++) {
    int fd = open("junk", O_CREATE | O_WRONLY);
     32a:	20100a93          	li	s5,513
     32e:	00006997          	auipc	s3,0x6
     332:	ba298993          	addi	s3,s3,-1118 # 5ed0 <malloc+0x21e>
    if (fd < 0) {
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char *)0xffffffffffL, 1);
     336:	4b05                	li	s6,1
     338:	5a7d                	li	s4,-1
     33a:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE | O_WRONLY);
     33e:	85d6                	mv	a1,s5
     340:	854e                	mv	a0,s3
     342:	47e050ef          	jal	57c0 <open>
     346:	84aa                	mv	s1,a0
    if (fd < 0) {
     348:	04054d63          	bltz	a0,3a2 <badwrite+0x9c>
    write(fd, (char *)0xffffffffffL, 1);
     34c:	865a                	mv	a2,s6
     34e:	85d2                	mv	a1,s4
     350:	450050ef          	jal	57a0 <write>
    close(fd);
     354:	8526                	mv	a0,s1
     356:	452050ef          	jal	57a8 <close>
    unlink("junk");
     35a:	854e                	mv	a0,s3
     35c:	474050ef          	jal	57d0 <unlink>
  for (int i = 0; i < assumed_free; i++) {
     360:	397d                	addiw	s2,s2,-1
     362:	fc091ee3          	bnez	s2,33e <badwrite+0x38>
  }

  int fd = open("junk", O_CREATE | O_WRONLY);
     366:	20100593          	li	a1,513
     36a:	00006517          	auipc	a0,0x6
     36e:	b6650513          	addi	a0,a0,-1178 # 5ed0 <malloc+0x21e>
     372:	44e050ef          	jal	57c0 <open>
     376:	84aa                	mv	s1,a0
  if (fd < 0) {
     378:	02054e63          	bltz	a0,3b4 <badwrite+0xae>
    printf("open junk failed\n");
    exit(1);
  }
  if (write(fd, "x", 1) != 1) {
     37c:	4605                	li	a2,1
     37e:	00006597          	auipc	a1,0x6
     382:	ada58593          	addi	a1,a1,-1318 # 5e58 <malloc+0x1a6>
     386:	41a050ef          	jal	57a0 <write>
     38a:	4785                	li	a5,1
     38c:	02f50d63          	beq	a0,a5,3c6 <badwrite+0xc0>
    printf("write failed\n");
     390:	00006517          	auipc	a0,0x6
     394:	b6050513          	addi	a0,a0,-1184 # 5ef0 <malloc+0x23e>
     398:	05f050ef          	jal	5bf6 <printf>
    exit(1);
     39c:	4505                	li	a0,1
     39e:	3e2050ef          	jal	5780 <exit>
      printf("open junk failed\n");
     3a2:	00006517          	auipc	a0,0x6
     3a6:	b3650513          	addi	a0,a0,-1226 # 5ed8 <malloc+0x226>
     3aa:	04d050ef          	jal	5bf6 <printf>
      exit(1);
     3ae:	4505                	li	a0,1
     3b0:	3d0050ef          	jal	5780 <exit>
    printf("open junk failed\n");
     3b4:	00006517          	auipc	a0,0x6
     3b8:	b2450513          	addi	a0,a0,-1244 # 5ed8 <malloc+0x226>
     3bc:	03b050ef          	jal	5bf6 <printf>
    exit(1);
     3c0:	4505                	li	a0,1
     3c2:	3be050ef          	jal	5780 <exit>
  }
  close(fd);
     3c6:	8526                	mv	a0,s1
     3c8:	3e0050ef          	jal	57a8 <close>
  unlink("junk");
     3cc:	00006517          	auipc	a0,0x6
     3d0:	b0450513          	addi	a0,a0,-1276 # 5ed0 <malloc+0x21e>
     3d4:	3fc050ef          	jal	57d0 <unlink>

  exit(0);
     3d8:	4501                	li	a0,0
     3da:	3a6050ef          	jal	5780 <exit>

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
  int nzz = 32 * 32;
  for (int i = 0; i < nzz; i++) {
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
    int fd = open(name, O_CREATE | O_RDWR | O_TRUNC);
     3fa:	60200a13          	li	s4,1538
  for (int i = 0; i < nzz; i++) {
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
     434:	39c050ef          	jal	57d0 <unlink>
    int fd = open(name, O_CREATE | O_RDWR | O_TRUNC);
     438:	85d2                	mv	a1,s4
     43a:	854a                	mv	a0,s2
     43c:	384050ef          	jal	57c0 <open>
    if (fd < 0) {
     440:	00054763          	bltz	a0,44e <outofinodes+0x70>
      // failure is eventually expected.
      break;
    }
    close(fd);
     444:	364050ef          	jal	57a8 <close>
  for (int i = 0; i < nzz; i++) {
     448:	2485                	addiw	s1,s1,1
     44a:	fb549ce3          	bne	s1,s5,402 <outofinodes+0x24>
  }

  for (int i = 0; i < nzz; i++) {
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
  for (int i = 0; i < nzz; i++) {
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
     48e:	342050ef          	jal	57d0 <unlink>
  for (int i = 0; i < nzz; i++) {
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
  uint64 addrs[] = {0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     4c4:	00008797          	auipc	a5,0x8
     4c8:	21c78793          	addi	a5,a5,540 # 86e0 <malloc+0x2a2e>
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
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
     4ea:	f7840913          	addi	s2,s0,-136
     4ee:	fa040c93          	addi	s9,s0,-96
    int fd = open("copyin1", O_CREATE | O_WRONLY);
     4f2:	20100b13          	li	s6,513
     4f6:	00006a97          	auipc	s5,0x6
     4fa:	a0aa8a93          	addi	s5,s5,-1526 # 5f00 <malloc+0x24e>
    int n = write(fd, (void *)addr, 8192);
     4fe:	6a09                	lui	s4,0x2
    n = write(1, (char *)addr, 8192);
     500:	4c05                	li	s8,1
    if (pipe(fds) < 0) {
     502:	f7040b93          	addi	s7,s0,-144
    uint64 addr = addrs[ai];
     506:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE | O_WRONLY);
     50a:	85da                	mv	a1,s6
     50c:	8556                	mv	a0,s5
     50e:	2b2050ef          	jal	57c0 <open>
     512:	84aa                	mv	s1,a0
    if (fd < 0) {
     514:	06054a63          	bltz	a0,588 <copyin+0xde>
    int n = write(fd, (void *)addr, 8192);
     518:	8652                	mv	a2,s4
     51a:	85ce                	mv	a1,s3
     51c:	284050ef          	jal	57a0 <write>
    if (n >= 0) {
     520:	06055d63          	bgez	a0,59a <copyin+0xf0>
    close(fd);
     524:	8526                	mv	a0,s1
     526:	282050ef          	jal	57a8 <close>
    unlink("copyin1");
     52a:	8556                	mv	a0,s5
     52c:	2a4050ef          	jal	57d0 <unlink>
    n = write(1, (char *)addr, 8192);
     530:	8652                	mv	a2,s4
     532:	85ce                	mv	a1,s3
     534:	8562                	mv	a0,s8
     536:	26a050ef          	jal	57a0 <write>
    if (n > 0) {
     53a:	06a04b63          	bgtz	a0,5b0 <copyin+0x106>
    if (pipe(fds) < 0) {
     53e:	855e                	mv	a0,s7
     540:	250050ef          	jal	5790 <pipe>
     544:	08054163          	bltz	a0,5c6 <copyin+0x11c>
    n = write(fds[1], (char *)addr, 8192);
     548:	8652                	mv	a2,s4
     54a:	85ce                	mv	a1,s3
     54c:	f7442503          	lw	a0,-140(s0)
     550:	250050ef          	jal	57a0 <write>
    if (n > 0) {
     554:	08a04263          	bgtz	a0,5d8 <copyin+0x12e>
    close(fds[0]);
     558:	f7042503          	lw	a0,-144(s0)
     55c:	24c050ef          	jal	57a8 <close>
    close(fds[1]);
     560:	f7442503          	lw	a0,-140(s0)
     564:	244050ef          	jal	57a8 <close>
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
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
     588:	00006517          	auipc	a0,0x6
     58c:	98050513          	addi	a0,a0,-1664 # 5f08 <malloc+0x256>
     590:	666050ef          	jal	5bf6 <printf>
      exit(1);
     594:	4505                	li	a0,1
     596:	1ea050ef          	jal	5780 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", (void *)addr, n);
     59a:	862a                	mv	a2,a0
     59c:	85ce                	mv	a1,s3
     59e:	00006517          	auipc	a0,0x6
     5a2:	98250513          	addi	a0,a0,-1662 # 5f20 <malloc+0x26e>
     5a6:	650050ef          	jal	5bf6 <printf>
      exit(1);
     5aa:	4505                	li	a0,1
     5ac:	1d4050ef          	jal	5780 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", (void *)addr, n);
     5b0:	862a                	mv	a2,a0
     5b2:	85ce                	mv	a1,s3
     5b4:	00006517          	auipc	a0,0x6
     5b8:	99c50513          	addi	a0,a0,-1636 # 5f50 <malloc+0x29e>
     5bc:	63a050ef          	jal	5bf6 <printf>
      exit(1);
     5c0:	4505                	li	a0,1
     5c2:	1be050ef          	jal	5780 <exit>
      printf("pipe() failed\n");
     5c6:	00006517          	auipc	a0,0x6
     5ca:	9ba50513          	addi	a0,a0,-1606 # 5f80 <malloc+0x2ce>
     5ce:	628050ef          	jal	5bf6 <printf>
      exit(1);
     5d2:	4505                	li	a0,1
     5d4:	1ac050ef          	jal	5780 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", (void *)addr,
     5d8:	862a                	mv	a2,a0
     5da:	85ce                	mv	a1,s3
     5dc:	00006517          	auipc	a0,0x6
     5e0:	9b450513          	addi	a0,a0,-1612 # 5f90 <malloc+0x2de>
     5e4:	612050ef          	jal	5bf6 <printf>
      exit(1);
     5e8:	4505                	li	a0,1
     5ea:	196050ef          	jal	5780 <exit>

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
  uint64 addrs[] = {0LL,          0x80000000LL, 0x3fffffe000,
     608:	00008797          	auipc	a5,0x8
     60c:	0d878793          	addi	a5,a5,216 # 86e0 <malloc+0x2a2e>
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
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
     634:	f7040913          	addi	s2,s0,-144
     638:	fa040c93          	addi	s9,s0,-96
    int fd = open("README", 0);
     63c:	00006b17          	auipc	s6,0x6
     640:	984b0b13          	addi	s6,s6,-1660 # 5fc0 <malloc+0x30e>
    int n = read(fd, (void *)addr, 8192);
     644:	6a89                	lui	s5,0x2
    if (pipe(fds) < 0) {
     646:	f6840c13          	addi	s8,s0,-152
    n = write(fds[1], "x", 1);
     64a:	4a05                	li	s4,1
     64c:	00006b97          	auipc	s7,0x6
     650:	80cb8b93          	addi	s7,s7,-2036 # 5e58 <malloc+0x1a6>
    uint64 addr = addrs[ai];
     654:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     658:	4581                	li	a1,0
     65a:	855a                	mv	a0,s6
     65c:	164050ef          	jal	57c0 <open>
     660:	84aa                	mv	s1,a0
    if (fd < 0) {
     662:	06054863          	bltz	a0,6d2 <copyout+0xe4>
    int n = read(fd, (void *)addr, 8192);
     666:	8656                	mv	a2,s5
     668:	85ce                	mv	a1,s3
     66a:	12e050ef          	jal	5798 <read>
    if (n > 0) {
     66e:	06a04b63          	bgtz	a0,6e4 <copyout+0xf6>
    close(fd);
     672:	8526                	mv	a0,s1
     674:	134050ef          	jal	57a8 <close>
    if (pipe(fds) < 0) {
     678:	8562                	mv	a0,s8
     67a:	116050ef          	jal	5790 <pipe>
     67e:	06054e63          	bltz	a0,6fa <copyout+0x10c>
    n = write(fds[1], "x", 1);
     682:	8652                	mv	a2,s4
     684:	85de                	mv	a1,s7
     686:	f6c42503          	lw	a0,-148(s0)
     68a:	116050ef          	jal	57a0 <write>
    if (n != 1) {
     68e:	07451f63          	bne	a0,s4,70c <copyout+0x11e>
    n = read(fds[0], (void *)addr, 8192);
     692:	8656                	mv	a2,s5
     694:	85ce                	mv	a1,s3
     696:	f6842503          	lw	a0,-152(s0)
     69a:	0fe050ef          	jal	5798 <read>
    if (n > 0) {
     69e:	08a04063          	bgtz	a0,71e <copyout+0x130>
    close(fds[0]);
     6a2:	f6842503          	lw	a0,-152(s0)
     6a6:	102050ef          	jal	57a8 <close>
    close(fds[1]);
     6aa:	f6c42503          	lw	a0,-148(s0)
     6ae:	0fa050ef          	jal	57a8 <close>
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
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
     6d2:	00006517          	auipc	a0,0x6
     6d6:	8f650513          	addi	a0,a0,-1802 # 5fc8 <malloc+0x316>
     6da:	51c050ef          	jal	5bf6 <printf>
      exit(1);
     6de:	4505                	li	a0,1
     6e0:	0a0050ef          	jal	5780 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", (void *)addr, n);
     6e4:	862a                	mv	a2,a0
     6e6:	85ce                	mv	a1,s3
     6e8:	00006517          	auipc	a0,0x6
     6ec:	8f850513          	addi	a0,a0,-1800 # 5fe0 <malloc+0x32e>
     6f0:	506050ef          	jal	5bf6 <printf>
      exit(1);
     6f4:	4505                	li	a0,1
     6f6:	08a050ef          	jal	5780 <exit>
      printf("pipe() failed\n");
     6fa:	00006517          	auipc	a0,0x6
     6fe:	88650513          	addi	a0,a0,-1914 # 5f80 <malloc+0x2ce>
     702:	4f4050ef          	jal	5bf6 <printf>
      exit(1);
     706:	4505                	li	a0,1
     708:	078050ef          	jal	5780 <exit>
      printf("pipe write failed\n");
     70c:	00006517          	auipc	a0,0x6
     710:	90450513          	addi	a0,a0,-1788 # 6010 <malloc+0x35e>
     714:	4e2050ef          	jal	5bf6 <printf>
      exit(1);
     718:	4505                	li	a0,1
     71a:	066050ef          	jal	5780 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", (void *)addr,
     71e:	862a                	mv	a2,a0
     720:	85ce                	mv	a1,s3
     722:	00006517          	auipc	a0,0x6
     726:	90650513          	addi	a0,a0,-1786 # 6028 <malloc+0x376>
     72a:	4cc050ef          	jal	5bf6 <printf>
      exit(1);
     72e:	4505                	li	a0,1
     730:	050050ef          	jal	5780 <exit>

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
     74c:	6f850513          	addi	a0,a0,1784 # 5e40 <malloc+0x18e>
     750:	080050ef          	jal	57d0 <unlink>
  int fd1 = open("truncfile", O_CREATE | O_WRONLY | O_TRUNC);
     754:	60100593          	li	a1,1537
     758:	00005517          	auipc	a0,0x5
     75c:	6e850513          	addi	a0,a0,1768 # 5e40 <malloc+0x18e>
     760:	060050ef          	jal	57c0 <open>
     764:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     766:	4611                	li	a2,4
     768:	00005597          	auipc	a1,0x5
     76c:	6e858593          	addi	a1,a1,1768 # 5e50 <malloc+0x19e>
     770:	030050ef          	jal	57a0 <write>
  close(fd1);
     774:	8526                	mv	a0,s1
     776:	032050ef          	jal	57a8 <close>
  int fd2 = open("truncfile", O_RDONLY);
     77a:	4581                	li	a1,0
     77c:	00005517          	auipc	a0,0x5
     780:	6c450513          	addi	a0,a0,1732 # 5e40 <malloc+0x18e>
     784:	03c050ef          	jal	57c0 <open>
     788:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     78a:	02000613          	li	a2,32
     78e:	fa040593          	addi	a1,s0,-96
     792:	006050ef          	jal	5798 <read>
  if (n != 4) {
     796:	4791                	li	a5,4
     798:	0af51863          	bne	a0,a5,848 <truncate1+0x114>
  fd1 = open("truncfile", O_WRONLY | O_TRUNC);
     79c:	40100593          	li	a1,1025
     7a0:	00005517          	auipc	a0,0x5
     7a4:	6a050513          	addi	a0,a0,1696 # 5e40 <malloc+0x18e>
     7a8:	018050ef          	jal	57c0 <open>
     7ac:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     7ae:	4581                	li	a1,0
     7b0:	00005517          	auipc	a0,0x5
     7b4:	69050513          	addi	a0,a0,1680 # 5e40 <malloc+0x18e>
     7b8:	008050ef          	jal	57c0 <open>
     7bc:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     7be:	02000613          	li	a2,32
     7c2:	fa040593          	addi	a1,s0,-96
     7c6:	7d3040ef          	jal	5798 <read>
     7ca:	8aaa                	mv	s5,a0
  if (n != 0) {
     7cc:	e949                	bnez	a0,85e <truncate1+0x12a>
  n = read(fd2, buf, sizeof(buf));
     7ce:	02000613          	li	a2,32
     7d2:	fa040593          	addi	a1,s0,-96
     7d6:	8526                	mv	a0,s1
     7d8:	7c1040ef          	jal	5798 <read>
     7dc:	8aaa                	mv	s5,a0
  if (n != 0) {
     7de:	e155                	bnez	a0,882 <truncate1+0x14e>
  write(fd1, "abcdef", 6);
     7e0:	4619                	li	a2,6
     7e2:	00006597          	auipc	a1,0x6
     7e6:	8d658593          	addi	a1,a1,-1834 # 60b8 <malloc+0x406>
     7ea:	854e                	mv	a0,s3
     7ec:	7b5040ef          	jal	57a0 <write>
  n = read(fd3, buf, sizeof(buf));
     7f0:	02000613          	li	a2,32
     7f4:	fa040593          	addi	a1,s0,-96
     7f8:	854a                	mv	a0,s2
     7fa:	79f040ef          	jal	5798 <read>
  if (n != 6) {
     7fe:	4799                	li	a5,6
     800:	0af51363          	bne	a0,a5,8a6 <truncate1+0x172>
  n = read(fd2, buf, sizeof(buf));
     804:	02000613          	li	a2,32
     808:	fa040593          	addi	a1,s0,-96
     80c:	8526                	mv	a0,s1
     80e:	78b040ef          	jal	5798 <read>
  if (n != 2) {
     812:	4789                	li	a5,2
     814:	0af51463          	bne	a0,a5,8bc <truncate1+0x188>
  unlink("truncfile");
     818:	00005517          	auipc	a0,0x5
     81c:	62850513          	addi	a0,a0,1576 # 5e40 <malloc+0x18e>
     820:	7b1040ef          	jal	57d0 <unlink>
  close(fd1);
     824:	854e                	mv	a0,s3
     826:	783040ef          	jal	57a8 <close>
  close(fd2);
     82a:	8526                	mv	a0,s1
     82c:	77d040ef          	jal	57a8 <close>
  close(fd3);
     830:	854a                	mv	a0,s2
     832:	777040ef          	jal	57a8 <close>
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
     84c:	00006517          	auipc	a0,0x6
     850:	80c50513          	addi	a0,a0,-2036 # 6058 <malloc+0x3a6>
     854:	3a2050ef          	jal	5bf6 <printf>
    exit(1);
     858:	4505                	li	a0,1
     85a:	727040ef          	jal	5780 <exit>
    printf("aaa fd3=%d\n", fd3);
     85e:	85ca                	mv	a1,s2
     860:	00006517          	auipc	a0,0x6
     864:	81850513          	addi	a0,a0,-2024 # 6078 <malloc+0x3c6>
     868:	38e050ef          	jal	5bf6 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     86c:	8656                	mv	a2,s5
     86e:	85d2                	mv	a1,s4
     870:	00006517          	auipc	a0,0x6
     874:	81850513          	addi	a0,a0,-2024 # 6088 <malloc+0x3d6>
     878:	37e050ef          	jal	5bf6 <printf>
    exit(1);
     87c:	4505                	li	a0,1
     87e:	703040ef          	jal	5780 <exit>
    printf("bbb fd2=%d\n", fd2);
     882:	85a6                	mv	a1,s1
     884:	00006517          	auipc	a0,0x6
     888:	82450513          	addi	a0,a0,-2012 # 60a8 <malloc+0x3f6>
     88c:	36a050ef          	jal	5bf6 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     890:	8656                	mv	a2,s5
     892:	85d2                	mv	a1,s4
     894:	00005517          	auipc	a0,0x5
     898:	7f450513          	addi	a0,a0,2036 # 6088 <malloc+0x3d6>
     89c:	35a050ef          	jal	5bf6 <printf>
    exit(1);
     8a0:	4505                	li	a0,1
     8a2:	6df040ef          	jal	5780 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     8a6:	862a                	mv	a2,a0
     8a8:	85d2                	mv	a1,s4
     8aa:	00006517          	auipc	a0,0x6
     8ae:	81650513          	addi	a0,a0,-2026 # 60c0 <malloc+0x40e>
     8b2:	344050ef          	jal	5bf6 <printf>
    exit(1);
     8b6:	4505                	li	a0,1
     8b8:	6c9040ef          	jal	5780 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     8bc:	862a                	mv	a2,a0
     8be:	85d2                	mv	a1,s4
     8c0:	00006517          	auipc	a0,0x6
     8c4:	82050513          	addi	a0,a0,-2016 # 60e0 <malloc+0x42e>
     8c8:	32e050ef          	jal	5bf6 <printf>
    exit(1);
     8cc:	4505                	li	a0,1
     8ce:	6b3040ef          	jal	5780 <exit>

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
  fd = open("small", O_CREATE | O_RDWR);
     8ea:	20200593          	li	a1,514
     8ee:	00006517          	auipc	a0,0x6
     8f2:	81250513          	addi	a0,a0,-2030 # 6100 <malloc+0x44e>
     8f6:	6cb040ef          	jal	57c0 <open>
  if (fd < 0) {
     8fa:	08054f63          	bltz	a0,998 <writetest+0xc6>
     8fe:	89aa                	mv	s3,a0
     900:	4901                	li	s2,0
    if (write(fd, "aaaaaaaaaa", SZ) != SZ) {
     902:	44a9                	li	s1,10
     904:	00006a17          	auipc	s4,0x6
     908:	824a0a13          	addi	s4,s4,-2012 # 6128 <malloc+0x476>
    if (write(fd, "bbbbbbbbbb", SZ) != SZ) {
     90c:	00006b17          	auipc	s6,0x6
     910:	854b0b13          	addi	s6,s6,-1964 # 6160 <malloc+0x4ae>
  for (i = 0; i < N; i++) {
     914:	06400a93          	li	s5,100
    if (write(fd, "aaaaaaaaaa", SZ) != SZ) {
     918:	8626                	mv	a2,s1
     91a:	85d2                	mv	a1,s4
     91c:	854e                	mv	a0,s3
     91e:	683040ef          	jal	57a0 <write>
     922:	08951563          	bne	a0,s1,9ac <writetest+0xda>
    if (write(fd, "bbbbbbbbbb", SZ) != SZ) {
     926:	8626                	mv	a2,s1
     928:	85da                	mv	a1,s6
     92a:	854e                	mv	a0,s3
     92c:	675040ef          	jal	57a0 <write>
     930:	08951963          	bne	a0,s1,9c2 <writetest+0xf0>
  for (i = 0; i < N; i++) {
     934:	2905                	addiw	s2,s2,1
     936:	ff5911e3          	bne	s2,s5,918 <writetest+0x46>
  close(fd);
     93a:	854e                	mv	a0,s3
     93c:	66d040ef          	jal	57a8 <close>
  fd = open("small", O_RDONLY);
     940:	4581                	li	a1,0
     942:	00005517          	auipc	a0,0x5
     946:	7be50513          	addi	a0,a0,1982 # 6100 <malloc+0x44e>
     94a:	677040ef          	jal	57c0 <open>
     94e:	84aa                	mv	s1,a0
  if (fd < 0) {
     950:	08054463          	bltz	a0,9d8 <writetest+0x106>
  i = read(fd, buf, N * SZ * 2);
     954:	7d000613          	li	a2,2000
     958:	0000c597          	auipc	a1,0xc
     95c:	3a058593          	addi	a1,a1,928 # ccf8 <buf>
     960:	639040ef          	jal	5798 <read>
  if (i != N * SZ * 2) {
     964:	7d000793          	li	a5,2000
     968:	08f51263          	bne	a0,a5,9ec <writetest+0x11a>
  close(fd);
     96c:	8526                	mv	a0,s1
     96e:	63b040ef          	jal	57a8 <close>
  if (unlink("small") < 0) {
     972:	00005517          	auipc	a0,0x5
     976:	78e50513          	addi	a0,a0,1934 # 6100 <malloc+0x44e>
     97a:	657040ef          	jal	57d0 <unlink>
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
     99e:	76e50513          	addi	a0,a0,1902 # 6108 <malloc+0x456>
     9a2:	254050ef          	jal	5bf6 <printf>
    exit(1);
     9a6:	4505                	li	a0,1
     9a8:	5d9040ef          	jal	5780 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     9ac:	864a                	mv	a2,s2
     9ae:	85de                	mv	a1,s7
     9b0:	00005517          	auipc	a0,0x5
     9b4:	78850513          	addi	a0,a0,1928 # 6138 <malloc+0x486>
     9b8:	23e050ef          	jal	5bf6 <printf>
      exit(1);
     9bc:	4505                	li	a0,1
     9be:	5c3040ef          	jal	5780 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     9c2:	864a                	mv	a2,s2
     9c4:	85de                	mv	a1,s7
     9c6:	00005517          	auipc	a0,0x5
     9ca:	7aa50513          	addi	a0,a0,1962 # 6170 <malloc+0x4be>
     9ce:	228050ef          	jal	5bf6 <printf>
      exit(1);
     9d2:	4505                	li	a0,1
     9d4:	5ad040ef          	jal	5780 <exit>
    printf("%s: error: open small failed!\n", s);
     9d8:	85de                	mv	a1,s7
     9da:	00005517          	auipc	a0,0x5
     9de:	7be50513          	addi	a0,a0,1982 # 6198 <malloc+0x4e6>
     9e2:	214050ef          	jal	5bf6 <printf>
    exit(1);
     9e6:	4505                	li	a0,1
     9e8:	599040ef          	jal	5780 <exit>
    printf("%s: read failed\n", s);
     9ec:	85de                	mv	a1,s7
     9ee:	00005517          	auipc	a0,0x5
     9f2:	7ca50513          	addi	a0,a0,1994 # 61b8 <malloc+0x506>
     9f6:	200050ef          	jal	5bf6 <printf>
    exit(1);
     9fa:	4505                	li	a0,1
     9fc:	585040ef          	jal	5780 <exit>
    printf("%s: unlink small failed\n", s);
     a00:	85de                	mv	a1,s7
     a02:	00005517          	auipc	a0,0x5
     a06:	7ce50513          	addi	a0,a0,1998 # 61d0 <malloc+0x51e>
     a0a:	1ec050ef          	jal	5bf6 <printf>
    exit(1);
     a0e:	4505                	li	a0,1
     a10:	571040ef          	jal	5780 <exit>

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
  fd = open("big", O_CREATE | O_RDWR);
     a2a:	20200593          	li	a1,514
     a2e:	00005517          	auipc	a0,0x5
     a32:	7c250513          	addi	a0,a0,1986 # 61f0 <malloc+0x53e>
     a36:	58b040ef          	jal	57c0 <open>
  if (fd < 0) {
     a3a:	06054b63          	bltz	a0,ab0 <writebig+0x9c>
     a3e:	8a2a                	mv	s4,a0
     a40:	4481                	li	s1,0
    ((int *)buf)[0] = i;
     a42:	0000c997          	auipc	s3,0xc
     a46:	2b698993          	addi	s3,s3,694 # ccf8 <buf>
    if (write(fd, buf, BSIZE) != BSIZE) {
     a4a:	40000913          	li	s2,1024
  for (i = 0; i < MAXFILE; i++) {
     a4e:	6ac1                	lui	s5,0x10
     a50:	10ba8a93          	addi	s5,s5,267 # 1010b <buf+0x3413>
    ((int *)buf)[0] = i;
     a54:	0099a023          	sw	s1,0(s3)
    if (write(fd, buf, BSIZE) != BSIZE) {
     a58:	864a                	mv	a2,s2
     a5a:	85ce                	mv	a1,s3
     a5c:	8552                	mv	a0,s4
     a5e:	543040ef          	jal	57a0 <write>
     a62:	07251163          	bne	a0,s2,ac4 <writebig+0xb0>
  for (i = 0; i < MAXFILE; i++) {
     a66:	2485                	addiw	s1,s1,1
     a68:	ff5496e3          	bne	s1,s5,a54 <writebig+0x40>
  close(fd);
     a6c:	8552                	mv	a0,s4
     a6e:	53b040ef          	jal	57a8 <close>
  fd = open("big", O_RDONLY);
     a72:	4581                	li	a1,0
     a74:	00005517          	auipc	a0,0x5
     a78:	77c50513          	addi	a0,a0,1916 # 61f0 <malloc+0x53e>
     a7c:	545040ef          	jal	57c0 <open>
     a80:	8a2a                	mv	s4,a0
  n = 0;
     a82:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     a84:	40000993          	li	s3,1024
     a88:	0000c917          	auipc	s2,0xc
     a8c:	27090913          	addi	s2,s2,624 # ccf8 <buf>
  if (fd < 0) {
     a90:	04054563          	bltz	a0,ada <writebig+0xc6>
    i = read(fd, buf, BSIZE);
     a94:	864e                	mv	a2,s3
     a96:	85ca                	mv	a1,s2
     a98:	8552                	mv	a0,s4
     a9a:	4ff040ef          	jal	5798 <read>
    if (i == 0) {
     a9e:	c921                	beqz	a0,aee <writebig+0xda>
    } else if (i != BSIZE) {
     aa0:	09351c63          	bne	a0,s3,b38 <writebig+0x124>
    if (((int *)buf)[0] != n) {
     aa4:	00092683          	lw	a3,0(s2)
     aa8:	0a969363          	bne	a3,s1,b4e <writebig+0x13a>
    n++;
     aac:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     aae:	b7dd                	j	a94 <writebig+0x80>
    printf("%s: error: creat big failed!\n", s);
     ab0:	85da                	mv	a1,s6
     ab2:	00005517          	auipc	a0,0x5
     ab6:	74650513          	addi	a0,a0,1862 # 61f8 <malloc+0x546>
     aba:	13c050ef          	jal	5bf6 <printf>
    exit(1);
     abe:	4505                	li	a0,1
     ac0:	4c1040ef          	jal	5780 <exit>
      printf("%s: error: write big file failed i=%d\n", s, i);
     ac4:	8626                	mv	a2,s1
     ac6:	85da                	mv	a1,s6
     ac8:	00005517          	auipc	a0,0x5
     acc:	75050513          	addi	a0,a0,1872 # 6218 <malloc+0x566>
     ad0:	126050ef          	jal	5bf6 <printf>
      exit(1);
     ad4:	4505                	li	a0,1
     ad6:	4ab040ef          	jal	5780 <exit>
    printf("%s: error: open big failed!\n", s);
     ada:	85da                	mv	a1,s6
     adc:	00005517          	auipc	a0,0x5
     ae0:	76450513          	addi	a0,a0,1892 # 6240 <malloc+0x58e>
     ae4:	112050ef          	jal	5bf6 <printf>
    exit(1);
     ae8:	4505                	li	a0,1
     aea:	497040ef          	jal	5780 <exit>
      if (n != MAXFILE) {
     aee:	67c1                	lui	a5,0x10
     af0:	10b78793          	addi	a5,a5,267 # 1010b <buf+0x3413>
     af4:	02f49763          	bne	s1,a5,b22 <writebig+0x10e>
  close(fd);
     af8:	8552                	mv	a0,s4
     afa:	4af040ef          	jal	57a8 <close>
  if (unlink("big") < 0) {
     afe:	00005517          	auipc	a0,0x5
     b02:	6f250513          	addi	a0,a0,1778 # 61f0 <malloc+0x53e>
     b06:	4cb040ef          	jal	57d0 <unlink>
     b0a:	04054d63          	bltz	a0,b64 <writebig+0x150>
}
     b0e:	70e2                	ld	ra,56(sp)
     b10:	7442                	ld	s0,48(sp)
     b12:	74a2                	ld	s1,40(sp)
     b14:	7902                	ld	s2,32(sp)
     b16:	69e2                	ld	s3,24(sp)
     b18:	6a42                	ld	s4,16(sp)
     b1a:	6aa2                	ld	s5,8(sp)
     b1c:	6b02                	ld	s6,0(sp)
     b1e:	6121                	addi	sp,sp,64
     b20:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     b22:	8626                	mv	a2,s1
     b24:	85da                	mv	a1,s6
     b26:	00005517          	auipc	a0,0x5
     b2a:	73a50513          	addi	a0,a0,1850 # 6260 <malloc+0x5ae>
     b2e:	0c8050ef          	jal	5bf6 <printf>
        exit(1);
     b32:	4505                	li	a0,1
     b34:	44d040ef          	jal	5780 <exit>
      printf("%s: read failed %d\n", s, i);
     b38:	862a                	mv	a2,a0
     b3a:	85da                	mv	a1,s6
     b3c:	00005517          	auipc	a0,0x5
     b40:	74c50513          	addi	a0,a0,1868 # 6288 <malloc+0x5d6>
     b44:	0b2050ef          	jal	5bf6 <printf>
      exit(1);
     b48:	4505                	li	a0,1
     b4a:	437040ef          	jal	5780 <exit>
      printf("%s: read content of block %d is %d\n", s, n, ((int *)buf)[0]);
     b4e:	8626                	mv	a2,s1
     b50:	85da                	mv	a1,s6
     b52:	00005517          	auipc	a0,0x5
     b56:	74e50513          	addi	a0,a0,1870 # 62a0 <malloc+0x5ee>
     b5a:	09c050ef          	jal	5bf6 <printf>
      exit(1);
     b5e:	4505                	li	a0,1
     b60:	421040ef          	jal	5780 <exit>
    printf("%s: unlink big failed\n", s);
     b64:	85da                	mv	a1,s6
     b66:	00005517          	auipc	a0,0x5
     b6a:	76250513          	addi	a0,a0,1890 # 62c8 <malloc+0x616>
     b6e:	088050ef          	jal	5bf6 <printf>
    exit(1);
     b72:	4505                	li	a0,1
     b74:	40d040ef          	jal	5780 <exit>

0000000000000b78 <unlinkread>:
{
     b78:	7179                	addi	sp,sp,-48
     b7a:	f406                	sd	ra,40(sp)
     b7c:	f022                	sd	s0,32(sp)
     b7e:	ec26                	sd	s1,24(sp)
     b80:	e84a                	sd	s2,16(sp)
     b82:	e44e                	sd	s3,8(sp)
     b84:	1800                	addi	s0,sp,48
     b86:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     b88:	20200593          	li	a1,514
     b8c:	00005517          	auipc	a0,0x5
     b90:	75450513          	addi	a0,a0,1876 # 62e0 <malloc+0x62e>
     b94:	42d040ef          	jal	57c0 <open>
  if (fd < 0) {
     b98:	0c054163          	bltz	a0,c5a <unlinkread+0xe2>
     b9c:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     b9e:	4615                	li	a2,5
     ba0:	00005597          	auipc	a1,0x5
     ba4:	77058593          	addi	a1,a1,1904 # 6310 <malloc+0x65e>
     ba8:	3f9040ef          	jal	57a0 <write>
  close(fd);
     bac:	8526                	mv	a0,s1
     bae:	3fb040ef          	jal	57a8 <close>
  fd = open("unlinkread", O_RDWR);
     bb2:	4589                	li	a1,2
     bb4:	00005517          	auipc	a0,0x5
     bb8:	72c50513          	addi	a0,a0,1836 # 62e0 <malloc+0x62e>
     bbc:	405040ef          	jal	57c0 <open>
     bc0:	84aa                	mv	s1,a0
  if (fd < 0) {
     bc2:	0a054663          	bltz	a0,c6e <unlinkread+0xf6>
  if (unlink("unlinkread") != 0) {
     bc6:	00005517          	auipc	a0,0x5
     bca:	71a50513          	addi	a0,a0,1818 # 62e0 <malloc+0x62e>
     bce:	403040ef          	jal	57d0 <unlink>
     bd2:	e945                	bnez	a0,c82 <unlinkread+0x10a>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     bd4:	20200593          	li	a1,514
     bd8:	00005517          	auipc	a0,0x5
     bdc:	70850513          	addi	a0,a0,1800 # 62e0 <malloc+0x62e>
     be0:	3e1040ef          	jal	57c0 <open>
     be4:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     be6:	460d                	li	a2,3
     be8:	00005597          	auipc	a1,0x5
     bec:	77058593          	addi	a1,a1,1904 # 6358 <malloc+0x6a6>
     bf0:	3b1040ef          	jal	57a0 <write>
  close(fd1);
     bf4:	854a                	mv	a0,s2
     bf6:	3b3040ef          	jal	57a8 <close>
  if (read(fd, buf, sizeof(buf)) != SZ) {
     bfa:	6655                	lui	a2,0x15
     bfc:	80060613          	addi	a2,a2,-2048 # 14800 <buf+0x7b08>
     c00:	0000c597          	auipc	a1,0xc
     c04:	0f858593          	addi	a1,a1,248 # ccf8 <buf>
     c08:	8526                	mv	a0,s1
     c0a:	38f040ef          	jal	5798 <read>
     c0e:	4795                	li	a5,5
     c10:	08f51363          	bne	a0,a5,c96 <unlinkread+0x11e>
  if (buf[0] != 'h') {
     c14:	0000c717          	auipc	a4,0xc
     c18:	0e474703          	lbu	a4,228(a4) # ccf8 <buf>
     c1c:	06800793          	li	a5,104
     c20:	08f71563          	bne	a4,a5,caa <unlinkread+0x132>
  if (write(fd, buf, 10) != 10) {
     c24:	4629                	li	a2,10
     c26:	0000c597          	auipc	a1,0xc
     c2a:	0d258593          	addi	a1,a1,210 # ccf8 <buf>
     c2e:	8526                	mv	a0,s1
     c30:	371040ef          	jal	57a0 <write>
     c34:	47a9                	li	a5,10
     c36:	08f51463          	bne	a0,a5,cbe <unlinkread+0x146>
  close(fd);
     c3a:	8526                	mv	a0,s1
     c3c:	36d040ef          	jal	57a8 <close>
  unlink("unlinkread");
     c40:	00005517          	auipc	a0,0x5
     c44:	6a050513          	addi	a0,a0,1696 # 62e0 <malloc+0x62e>
     c48:	389040ef          	jal	57d0 <unlink>
}
     c4c:	70a2                	ld	ra,40(sp)
     c4e:	7402                	ld	s0,32(sp)
     c50:	64e2                	ld	s1,24(sp)
     c52:	6942                	ld	s2,16(sp)
     c54:	69a2                	ld	s3,8(sp)
     c56:	6145                	addi	sp,sp,48
     c58:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     c5a:	85ce                	mv	a1,s3
     c5c:	00005517          	auipc	a0,0x5
     c60:	69450513          	addi	a0,a0,1684 # 62f0 <malloc+0x63e>
     c64:	793040ef          	jal	5bf6 <printf>
    exit(1);
     c68:	4505                	li	a0,1
     c6a:	317040ef          	jal	5780 <exit>
    printf("%s: open unlinkread failed\n", s);
     c6e:	85ce                	mv	a1,s3
     c70:	00005517          	auipc	a0,0x5
     c74:	6a850513          	addi	a0,a0,1704 # 6318 <malloc+0x666>
     c78:	77f040ef          	jal	5bf6 <printf>
    exit(1);
     c7c:	4505                	li	a0,1
     c7e:	303040ef          	jal	5780 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     c82:	85ce                	mv	a1,s3
     c84:	00005517          	auipc	a0,0x5
     c88:	6b450513          	addi	a0,a0,1716 # 6338 <malloc+0x686>
     c8c:	76b040ef          	jal	5bf6 <printf>
    exit(1);
     c90:	4505                	li	a0,1
     c92:	2ef040ef          	jal	5780 <exit>
    printf("%s: unlinkread read failed", s);
     c96:	85ce                	mv	a1,s3
     c98:	00005517          	auipc	a0,0x5
     c9c:	6c850513          	addi	a0,a0,1736 # 6360 <malloc+0x6ae>
     ca0:	757040ef          	jal	5bf6 <printf>
    exit(1);
     ca4:	4505                	li	a0,1
     ca6:	2db040ef          	jal	5780 <exit>
    printf("%s: unlinkread wrong data\n", s);
     caa:	85ce                	mv	a1,s3
     cac:	00005517          	auipc	a0,0x5
     cb0:	6d450513          	addi	a0,a0,1748 # 6380 <malloc+0x6ce>
     cb4:	743040ef          	jal	5bf6 <printf>
    exit(1);
     cb8:	4505                	li	a0,1
     cba:	2c7040ef          	jal	5780 <exit>
    printf("%s: unlinkread write failed\n", s);
     cbe:	85ce                	mv	a1,s3
     cc0:	00005517          	auipc	a0,0x5
     cc4:	6e050513          	addi	a0,a0,1760 # 63a0 <malloc+0x6ee>
     cc8:	72f040ef          	jal	5bf6 <printf>
    exit(1);
     ccc:	4505                	li	a0,1
     cce:	2b3040ef          	jal	5780 <exit>

0000000000000cd2 <linktest>:
{
     cd2:	1101                	addi	sp,sp,-32
     cd4:	ec06                	sd	ra,24(sp)
     cd6:	e822                	sd	s0,16(sp)
     cd8:	e426                	sd	s1,8(sp)
     cda:	e04a                	sd	s2,0(sp)
     cdc:	1000                	addi	s0,sp,32
     cde:	892a                	mv	s2,a0
  unlink("lf1");
     ce0:	00005517          	auipc	a0,0x5
     ce4:	6e050513          	addi	a0,a0,1760 # 63c0 <malloc+0x70e>
     ce8:	2e9040ef          	jal	57d0 <unlink>
  unlink("lf2");
     cec:	00005517          	auipc	a0,0x5
     cf0:	6dc50513          	addi	a0,a0,1756 # 63c8 <malloc+0x716>
     cf4:	2dd040ef          	jal	57d0 <unlink>
  fd = open("lf1", O_CREATE | O_RDWR);
     cf8:	20200593          	li	a1,514
     cfc:	00005517          	auipc	a0,0x5
     d00:	6c450513          	addi	a0,a0,1732 # 63c0 <malloc+0x70e>
     d04:	2bd040ef          	jal	57c0 <open>
  if (fd < 0) {
     d08:	0e054163          	bltz	a0,dea <linktest+0x118>
     d0c:	84aa                	mv	s1,a0
  if (write(fd, "hello", SZ) != SZ) {
     d0e:	4615                	li	a2,5
     d10:	00005597          	auipc	a1,0x5
     d14:	60058593          	addi	a1,a1,1536 # 6310 <malloc+0x65e>
     d18:	289040ef          	jal	57a0 <write>
     d1c:	4795                	li	a5,5
     d1e:	0ef51063          	bne	a0,a5,dfe <linktest+0x12c>
  close(fd);
     d22:	8526                	mv	a0,s1
     d24:	285040ef          	jal	57a8 <close>
  if (link("lf1", "lf2") < 0) {
     d28:	00005597          	auipc	a1,0x5
     d2c:	6a058593          	addi	a1,a1,1696 # 63c8 <malloc+0x716>
     d30:	00005517          	auipc	a0,0x5
     d34:	69050513          	addi	a0,a0,1680 # 63c0 <malloc+0x70e>
     d38:	2a9040ef          	jal	57e0 <link>
     d3c:	0c054b63          	bltz	a0,e12 <linktest+0x140>
  unlink("lf1");
     d40:	00005517          	auipc	a0,0x5
     d44:	68050513          	addi	a0,a0,1664 # 63c0 <malloc+0x70e>
     d48:	289040ef          	jal	57d0 <unlink>
  if (open("lf1", 0) >= 0) {
     d4c:	4581                	li	a1,0
     d4e:	00005517          	auipc	a0,0x5
     d52:	67250513          	addi	a0,a0,1650 # 63c0 <malloc+0x70e>
     d56:	26b040ef          	jal	57c0 <open>
     d5a:	0c055663          	bgez	a0,e26 <linktest+0x154>
  fd = open("lf2", 0);
     d5e:	4581                	li	a1,0
     d60:	00005517          	auipc	a0,0x5
     d64:	66850513          	addi	a0,a0,1640 # 63c8 <malloc+0x716>
     d68:	259040ef          	jal	57c0 <open>
     d6c:	84aa                	mv	s1,a0
  if (fd < 0) {
     d6e:	0c054663          	bltz	a0,e3a <linktest+0x168>
  if (read(fd, buf, sizeof(buf)) != SZ) {
     d72:	6655                	lui	a2,0x15
     d74:	80060613          	addi	a2,a2,-2048 # 14800 <buf+0x7b08>
     d78:	0000c597          	auipc	a1,0xc
     d7c:	f8058593          	addi	a1,a1,-128 # ccf8 <buf>
     d80:	219040ef          	jal	5798 <read>
     d84:	4795                	li	a5,5
     d86:	0cf51463          	bne	a0,a5,e4e <linktest+0x17c>
  close(fd);
     d8a:	8526                	mv	a0,s1
     d8c:	21d040ef          	jal	57a8 <close>
  if (link("lf2", "lf2") >= 0) {
     d90:	00005597          	auipc	a1,0x5
     d94:	63858593          	addi	a1,a1,1592 # 63c8 <malloc+0x716>
     d98:	852e                	mv	a0,a1
     d9a:	247040ef          	jal	57e0 <link>
     d9e:	0c055263          	bgez	a0,e62 <linktest+0x190>
  unlink("lf2");
     da2:	00005517          	auipc	a0,0x5
     da6:	62650513          	addi	a0,a0,1574 # 63c8 <malloc+0x716>
     daa:	227040ef          	jal	57d0 <unlink>
  if (link("lf2", "lf1") >= 0) {
     dae:	00005597          	auipc	a1,0x5
     db2:	61258593          	addi	a1,a1,1554 # 63c0 <malloc+0x70e>
     db6:	00005517          	auipc	a0,0x5
     dba:	61250513          	addi	a0,a0,1554 # 63c8 <malloc+0x716>
     dbe:	223040ef          	jal	57e0 <link>
     dc2:	0a055a63          	bgez	a0,e76 <linktest+0x1a4>
  if (link(".", "lf1") >= 0) {
     dc6:	00005597          	auipc	a1,0x5
     dca:	5fa58593          	addi	a1,a1,1530 # 63c0 <malloc+0x70e>
     dce:	00005517          	auipc	a0,0x5
     dd2:	70250513          	addi	a0,a0,1794 # 64d0 <malloc+0x81e>
     dd6:	20b040ef          	jal	57e0 <link>
     dda:	0a055863          	bgez	a0,e8a <linktest+0x1b8>
}
     dde:	60e2                	ld	ra,24(sp)
     de0:	6442                	ld	s0,16(sp)
     de2:	64a2                	ld	s1,8(sp)
     de4:	6902                	ld	s2,0(sp)
     de6:	6105                	addi	sp,sp,32
     de8:	8082                	ret
    printf("%s: create lf1 failed\n", s);
     dea:	85ca                	mv	a1,s2
     dec:	00005517          	auipc	a0,0x5
     df0:	5e450513          	addi	a0,a0,1508 # 63d0 <malloc+0x71e>
     df4:	603040ef          	jal	5bf6 <printf>
    exit(1);
     df8:	4505                	li	a0,1
     dfa:	187040ef          	jal	5780 <exit>
    printf("%s: write lf1 failed\n", s);
     dfe:	85ca                	mv	a1,s2
     e00:	00005517          	auipc	a0,0x5
     e04:	5e850513          	addi	a0,a0,1512 # 63e8 <malloc+0x736>
     e08:	5ef040ef          	jal	5bf6 <printf>
    exit(1);
     e0c:	4505                	li	a0,1
     e0e:	173040ef          	jal	5780 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
     e12:	85ca                	mv	a1,s2
     e14:	00005517          	auipc	a0,0x5
     e18:	5ec50513          	addi	a0,a0,1516 # 6400 <malloc+0x74e>
     e1c:	5db040ef          	jal	5bf6 <printf>
    exit(1);
     e20:	4505                	li	a0,1
     e22:	15f040ef          	jal	5780 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
     e26:	85ca                	mv	a1,s2
     e28:	00005517          	auipc	a0,0x5
     e2c:	5f850513          	addi	a0,a0,1528 # 6420 <malloc+0x76e>
     e30:	5c7040ef          	jal	5bf6 <printf>
    exit(1);
     e34:	4505                	li	a0,1
     e36:	14b040ef          	jal	5780 <exit>
    printf("%s: open lf2 failed\n", s);
     e3a:	85ca                	mv	a1,s2
     e3c:	00005517          	auipc	a0,0x5
     e40:	61450513          	addi	a0,a0,1556 # 6450 <malloc+0x79e>
     e44:	5b3040ef          	jal	5bf6 <printf>
    exit(1);
     e48:	4505                	li	a0,1
     e4a:	137040ef          	jal	5780 <exit>
    printf("%s: read lf2 failed\n", s);
     e4e:	85ca                	mv	a1,s2
     e50:	00005517          	auipc	a0,0x5
     e54:	61850513          	addi	a0,a0,1560 # 6468 <malloc+0x7b6>
     e58:	59f040ef          	jal	5bf6 <printf>
    exit(1);
     e5c:	4505                	li	a0,1
     e5e:	123040ef          	jal	5780 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
     e62:	85ca                	mv	a1,s2
     e64:	00005517          	auipc	a0,0x5
     e68:	61c50513          	addi	a0,a0,1564 # 6480 <malloc+0x7ce>
     e6c:	58b040ef          	jal	5bf6 <printf>
    exit(1);
     e70:	4505                	li	a0,1
     e72:	10f040ef          	jal	5780 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
     e76:	85ca                	mv	a1,s2
     e78:	00005517          	auipc	a0,0x5
     e7c:	63050513          	addi	a0,a0,1584 # 64a8 <malloc+0x7f6>
     e80:	577040ef          	jal	5bf6 <printf>
    exit(1);
     e84:	4505                	li	a0,1
     e86:	0fb040ef          	jal	5780 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
     e8a:	85ca                	mv	a1,s2
     e8c:	00005517          	auipc	a0,0x5
     e90:	64c50513          	addi	a0,a0,1612 # 64d8 <malloc+0x826>
     e94:	563040ef          	jal	5bf6 <printf>
    exit(1);
     e98:	4505                	li	a0,1
     e9a:	0e7040ef          	jal	5780 <exit>

0000000000000e9e <validatetest>:
{
     e9e:	7139                	addi	sp,sp,-64
     ea0:	fc06                	sd	ra,56(sp)
     ea2:	f822                	sd	s0,48(sp)
     ea4:	f426                	sd	s1,40(sp)
     ea6:	f04a                	sd	s2,32(sp)
     ea8:	ec4e                	sd	s3,24(sp)
     eaa:	e852                	sd	s4,16(sp)
     eac:	e456                	sd	s5,8(sp)
     eae:	e05a                	sd	s6,0(sp)
     eb0:	0080                	addi	s0,sp,64
     eb2:	8b2a                	mv	s6,a0
  for (p = 0; p <= (uint)hi; p += PGSIZE) {
     eb4:	4481                	li	s1,0
    if (link("nosuchfile", (char *)p) != -1) {
     eb6:	00005997          	auipc	s3,0x5
     eba:	64298993          	addi	s3,s3,1602 # 64f8 <malloc+0x846>
     ebe:	597d                	li	s2,-1
  for (p = 0; p <= (uint)hi; p += PGSIZE) {
     ec0:	6a85                	lui	s5,0x1
     ec2:	00114a37          	lui	s4,0x114
    if (link("nosuchfile", (char *)p) != -1) {
     ec6:	85a6                	mv	a1,s1
     ec8:	854e                	mv	a0,s3
     eca:	117040ef          	jal	57e0 <link>
     ece:	01251f63          	bne	a0,s2,eec <validatetest+0x4e>
  for (p = 0; p <= (uint)hi; p += PGSIZE) {
     ed2:	94d6                	add	s1,s1,s5
     ed4:	ff4499e3          	bne	s1,s4,ec6 <validatetest+0x28>
}
     ed8:	70e2                	ld	ra,56(sp)
     eda:	7442                	ld	s0,48(sp)
     edc:	74a2                	ld	s1,40(sp)
     ede:	7902                	ld	s2,32(sp)
     ee0:	69e2                	ld	s3,24(sp)
     ee2:	6a42                	ld	s4,16(sp)
     ee4:	6aa2                	ld	s5,8(sp)
     ee6:	6b02                	ld	s6,0(sp)
     ee8:	6121                	addi	sp,sp,64
     eea:	8082                	ret
      printf("%s: link should not succeed\n", s);
     eec:	85da                	mv	a1,s6
     eee:	00005517          	auipc	a0,0x5
     ef2:	61a50513          	addi	a0,a0,1562 # 6508 <malloc+0x856>
     ef6:	501040ef          	jal	5bf6 <printf>
      exit(1);
     efa:	4505                	li	a0,1
     efc:	085040ef          	jal	5780 <exit>

0000000000000f00 <bigdir>:
{
     f00:	711d                	addi	sp,sp,-96
     f02:	ec86                	sd	ra,88(sp)
     f04:	e8a2                	sd	s0,80(sp)
     f06:	e4a6                	sd	s1,72(sp)
     f08:	e0ca                	sd	s2,64(sp)
     f0a:	fc4e                	sd	s3,56(sp)
     f0c:	f852                	sd	s4,48(sp)
     f0e:	f456                	sd	s5,40(sp)
     f10:	f05a                	sd	s6,32(sp)
     f12:	ec5e                	sd	s7,24(sp)
     f14:	1080                	addi	s0,sp,96
     f16:	8baa                	mv	s7,a0
  unlink("bd");
     f18:	00005517          	auipc	a0,0x5
     f1c:	61050513          	addi	a0,a0,1552 # 6528 <malloc+0x876>
     f20:	0b1040ef          	jal	57d0 <unlink>
  fd = open("bd", O_CREATE);
     f24:	20000593          	li	a1,512
     f28:	00005517          	auipc	a0,0x5
     f2c:	60050513          	addi	a0,a0,1536 # 6528 <malloc+0x876>
     f30:	091040ef          	jal	57c0 <open>
  if (fd < 0) {
     f34:	0c054463          	bltz	a0,ffc <bigdir+0xfc>
  close(fd);
     f38:	071040ef          	jal	57a8 <close>
  for (i = 0; i < N; i++) {
     f3c:	4901                	li	s2,0
    name[0] = 'x';
     f3e:	07800a93          	li	s5,120
    if (link("bd", name) != 0) {
     f42:	fa040a13          	addi	s4,s0,-96
     f46:	00005997          	auipc	s3,0x5
     f4a:	5e298993          	addi	s3,s3,1506 # 6528 <malloc+0x876>
  for (i = 0; i < N; i++) {
     f4e:	1f400b13          	li	s6,500
    name[0] = 'x';
     f52:	fb540023          	sb	s5,-96(s0)
    name[1] = '0' + (i / 64);
     f56:	41f9571b          	sraiw	a4,s2,0x1f
     f5a:	01a7571b          	srliw	a4,a4,0x1a
     f5e:	012707bb          	addw	a5,a4,s2
     f62:	4067d69b          	sraiw	a3,a5,0x6
     f66:	0306869b          	addiw	a3,a3,48
     f6a:	fad400a3          	sb	a3,-95(s0)
    name[2] = '0' + (i % 64);
     f6e:	03f7f793          	andi	a5,a5,63
     f72:	9f99                	subw	a5,a5,a4
     f74:	0307879b          	addiw	a5,a5,48
     f78:	faf40123          	sb	a5,-94(s0)
    name[3] = '\0';
     f7c:	fa0401a3          	sb	zero,-93(s0)
    if (link("bd", name) != 0) {
     f80:	85d2                	mv	a1,s4
     f82:	854e                	mv	a0,s3
     f84:	05d040ef          	jal	57e0 <link>
     f88:	84aa                	mv	s1,a0
     f8a:	e159                	bnez	a0,1010 <bigdir+0x110>
  for (i = 0; i < N; i++) {
     f8c:	2905                	addiw	s2,s2,1
     f8e:	fd6912e3          	bne	s2,s6,f52 <bigdir+0x52>
  unlink("bd");
     f92:	00005517          	auipc	a0,0x5
     f96:	59650513          	addi	a0,a0,1430 # 6528 <malloc+0x876>
     f9a:	037040ef          	jal	57d0 <unlink>
    name[0] = 'x';
     f9e:	07800993          	li	s3,120
    if (unlink(name) != 0) {
     fa2:	fa040913          	addi	s2,s0,-96
  for (i = 0; i < N; i++) {
     fa6:	1f400a13          	li	s4,500
    name[0] = 'x';
     faa:	fb340023          	sb	s3,-96(s0)
    name[1] = '0' + (i / 64);
     fae:	41f4d71b          	sraiw	a4,s1,0x1f
     fb2:	01a7571b          	srliw	a4,a4,0x1a
     fb6:	009707bb          	addw	a5,a4,s1
     fba:	4067d69b          	sraiw	a3,a5,0x6
     fbe:	0306869b          	addiw	a3,a3,48
     fc2:	fad400a3          	sb	a3,-95(s0)
    name[2] = '0' + (i % 64);
     fc6:	03f7f793          	andi	a5,a5,63
     fca:	9f99                	subw	a5,a5,a4
     fcc:	0307879b          	addiw	a5,a5,48
     fd0:	faf40123          	sb	a5,-94(s0)
    name[3] = '\0';
     fd4:	fa0401a3          	sb	zero,-93(s0)
    if (unlink(name) != 0) {
     fd8:	854a                	mv	a0,s2
     fda:	7f6040ef          	jal	57d0 <unlink>
     fde:	e531                	bnez	a0,102a <bigdir+0x12a>
  for (i = 0; i < N; i++) {
     fe0:	2485                	addiw	s1,s1,1
     fe2:	fd4494e3          	bne	s1,s4,faa <bigdir+0xaa>
}
     fe6:	60e6                	ld	ra,88(sp)
     fe8:	6446                	ld	s0,80(sp)
     fea:	64a6                	ld	s1,72(sp)
     fec:	6906                	ld	s2,64(sp)
     fee:	79e2                	ld	s3,56(sp)
     ff0:	7a42                	ld	s4,48(sp)
     ff2:	7aa2                	ld	s5,40(sp)
     ff4:	7b02                	ld	s6,32(sp)
     ff6:	6be2                	ld	s7,24(sp)
     ff8:	6125                	addi	sp,sp,96
     ffa:	8082                	ret
    printf("%s: bigdir create failed\n", s);
     ffc:	85de                	mv	a1,s7
     ffe:	00005517          	auipc	a0,0x5
    1002:	53250513          	addi	a0,a0,1330 # 6530 <malloc+0x87e>
    1006:	3f1040ef          	jal	5bf6 <printf>
    exit(1);
    100a:	4505                	li	a0,1
    100c:	774040ef          	jal	5780 <exit>
      printf("%s: bigdir i=%d link(bd, %s) failed\n", s, i, name);
    1010:	fa040693          	addi	a3,s0,-96
    1014:	864a                	mv	a2,s2
    1016:	85de                	mv	a1,s7
    1018:	00005517          	auipc	a0,0x5
    101c:	53850513          	addi	a0,a0,1336 # 6550 <malloc+0x89e>
    1020:	3d7040ef          	jal	5bf6 <printf>
      exit(1);
    1024:	4505                	li	a0,1
    1026:	75a040ef          	jal	5780 <exit>
      printf("%s: bigdir unlink failed", s);
    102a:	85de                	mv	a1,s7
    102c:	00005517          	auipc	a0,0x5
    1030:	54c50513          	addi	a0,a0,1356 # 6578 <malloc+0x8c6>
    1034:	3c3040ef          	jal	5bf6 <printf>
      exit(1);
    1038:	4505                	li	a0,1
    103a:	746040ef          	jal	5780 <exit>

000000000000103e <pgbug>:
{
    103e:	7179                	addi	sp,sp,-48
    1040:	f406                	sd	ra,40(sp)
    1042:	f022                	sd	s0,32(sp)
    1044:	ec26                	sd	s1,24(sp)
    1046:	1800                	addi	s0,sp,48
  argv[0] = 0;
    1048:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
    104c:	00008497          	auipc	s1,0x8
    1050:	fb448493          	addi	s1,s1,-76 # 9000 <big>
    1054:	fd840593          	addi	a1,s0,-40
    1058:	6088                	ld	a0,0(s1)
    105a:	75e040ef          	jal	57b8 <exec>
  pipe(big);
    105e:	6088                	ld	a0,0(s1)
    1060:	730040ef          	jal	5790 <pipe>
  exit(0);
    1064:	4501                	li	a0,0
    1066:	71a040ef          	jal	5780 <exit>

000000000000106a <badarg>:
{
    106a:	7139                	addi	sp,sp,-64
    106c:	fc06                	sd	ra,56(sp)
    106e:	f822                	sd	s0,48(sp)
    1070:	f426                	sd	s1,40(sp)
    1072:	f04a                	sd	s2,32(sp)
    1074:	ec4e                	sd	s3,24(sp)
    1076:	e852                	sd	s4,16(sp)
    1078:	0080                	addi	s0,sp,64
    107a:	64b1                	lui	s1,0xc
    107c:	35048493          	addi	s1,s1,848 # c350 <uninit+0x1d68>
    argv[0] = (char *)0xffffffff;
    1080:	597d                	li	s2,-1
    1082:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    1086:	fc040a13          	addi	s4,s0,-64
    108a:	00005997          	auipc	s3,0x5
    108e:	d5e98993          	addi	s3,s3,-674 # 5de8 <malloc+0x136>
    argv[0] = (char *)0xffffffff;
    1092:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1096:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    109a:	85d2                	mv	a1,s4
    109c:	854e                	mv	a0,s3
    109e:	71a040ef          	jal	57b8 <exec>
  for (int i = 0; i < 50000; i++) {
    10a2:	34fd                	addiw	s1,s1,-1
    10a4:	f4fd                	bnez	s1,1092 <badarg+0x28>
  exit(0);
    10a6:	4501                	li	a0,0
    10a8:	6d8040ef          	jal	5780 <exit>

00000000000010ac <copyinstr2>:
{
    10ac:	7155                	addi	sp,sp,-208
    10ae:	e586                	sd	ra,200(sp)
    10b0:	e1a2                	sd	s0,192(sp)
    10b2:	0980                	addi	s0,sp,208
  for (int i = 0; i < MAXPATH; i++)
    10b4:	f6840793          	addi	a5,s0,-152
    10b8:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    10bc:	07800713          	li	a4,120
    10c0:	00e78023          	sb	a4,0(a5)
  for (int i = 0; i < MAXPATH; i++)
    10c4:	0785                	addi	a5,a5,1
    10c6:	fed79de3          	bne	a5,a3,10c0 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    10ca:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    10ce:	f6840513          	addi	a0,s0,-152
    10d2:	6fe040ef          	jal	57d0 <unlink>
  if (ret != -1) {
    10d6:	57fd                	li	a5,-1
    10d8:	0cf51263          	bne	a0,a5,119c <copyinstr2+0xf0>
  int fd = open(b, O_CREATE | O_WRONLY);
    10dc:	20100593          	li	a1,513
    10e0:	f6840513          	addi	a0,s0,-152
    10e4:	6dc040ef          	jal	57c0 <open>
  if (fd != -1) {
    10e8:	57fd                	li	a5,-1
    10ea:	0cf51563          	bne	a0,a5,11b4 <copyinstr2+0x108>
  ret = link(b, b);
    10ee:	f6840513          	addi	a0,s0,-152
    10f2:	85aa                	mv	a1,a0
    10f4:	6ec040ef          	jal	57e0 <link>
  if (ret != -1) {
    10f8:	57fd                	li	a5,-1
    10fa:	0cf51963          	bne	a0,a5,11cc <copyinstr2+0x120>
  char *args[] = {"xx", 0};
    10fe:	00006797          	auipc	a5,0x6
    1102:	56278793          	addi	a5,a5,1378 # 7660 <malloc+0x19ae>
    1106:	f4f43c23          	sd	a5,-168(s0)
    110a:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    110e:	f5840593          	addi	a1,s0,-168
    1112:	f6840513          	addi	a0,s0,-152
    1116:	6a2040ef          	jal	57b8 <exec>
  if (ret != -1) {
    111a:	57fd                	li	a5,-1
    111c:	0cf51563          	bne	a0,a5,11e6 <copyinstr2+0x13a>
  int pid = fork();
    1120:	658040ef          	jal	5778 <fork>
  if (pid < 0) {
    1124:	0c054d63          	bltz	a0,11fe <copyinstr2+0x152>
  if (pid == 0) {
    1128:	0e051863          	bnez	a0,1218 <copyinstr2+0x16c>
    112c:	00008797          	auipc	a5,0x8
    1130:	4b478793          	addi	a5,a5,1204 # 95e0 <big.0>
    1134:	00009697          	auipc	a3,0x9
    1138:	4ac68693          	addi	a3,a3,1196 # a5e0 <big.0+0x1000>
      big[i] = 'x';
    113c:	07800713          	li	a4,120
    1140:	00e78023          	sb	a4,0(a5)
    for (int i = 0; i < PGSIZE; i++)
    1144:	0785                	addi	a5,a5,1
    1146:	fed79de3          	bne	a5,a3,1140 <copyinstr2+0x94>
    big[PGSIZE] = '\0';
    114a:	00009797          	auipc	a5,0x9
    114e:	48078b23          	sb	zero,1174(a5) # a5e0 <big.0+0x1000>
    char *args2[] = {big, big, big, 0};
    1152:	00007797          	auipc	a5,0x7
    1156:	58e78793          	addi	a5,a5,1422 # 86e0 <malloc+0x2a2e>
    115a:	6fb0                	ld	a2,88(a5)
    115c:	73b4                	ld	a3,96(a5)
    115e:	77b8                	ld	a4,104(a5)
    1160:	f2c43823          	sd	a2,-208(s0)
    1164:	f2d43c23          	sd	a3,-200(s0)
    1168:	f4e43023          	sd	a4,-192(s0)
    116c:	7bbc                	ld	a5,112(a5)
    116e:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    1172:	f3040593          	addi	a1,s0,-208
    1176:	00005517          	auipc	a0,0x5
    117a:	c7250513          	addi	a0,a0,-910 # 5de8 <malloc+0x136>
    117e:	63a040ef          	jal	57b8 <exec>
    if (ret != -1) {
    1182:	57fd                	li	a5,-1
    1184:	08f50663          	beq	a0,a5,1210 <copyinstr2+0x164>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    1188:	85be                	mv	a1,a5
    118a:	00005517          	auipc	a0,0x5
    118e:	49650513          	addi	a0,a0,1174 # 6620 <malloc+0x96e>
    1192:	265040ef          	jal	5bf6 <printf>
      exit(1);
    1196:	4505                	li	a0,1
    1198:	5e8040ef          	jal	5780 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    119c:	862a                	mv	a2,a0
    119e:	f6840593          	addi	a1,s0,-152
    11a2:	00005517          	auipc	a0,0x5
    11a6:	3f650513          	addi	a0,a0,1014 # 6598 <malloc+0x8e6>
    11aa:	24d040ef          	jal	5bf6 <printf>
    exit(1);
    11ae:	4505                	li	a0,1
    11b0:	5d0040ef          	jal	5780 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    11b4:	862a                	mv	a2,a0
    11b6:	f6840593          	addi	a1,s0,-152
    11ba:	00005517          	auipc	a0,0x5
    11be:	3fe50513          	addi	a0,a0,1022 # 65b8 <malloc+0x906>
    11c2:	235040ef          	jal	5bf6 <printf>
    exit(1);
    11c6:	4505                	li	a0,1
    11c8:	5b8040ef          	jal	5780 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    11cc:	f6840593          	addi	a1,s0,-152
    11d0:	86aa                	mv	a3,a0
    11d2:	862e                	mv	a2,a1
    11d4:	00005517          	auipc	a0,0x5
    11d8:	40450513          	addi	a0,a0,1028 # 65d8 <malloc+0x926>
    11dc:	21b040ef          	jal	5bf6 <printf>
    exit(1);
    11e0:	4505                	li	a0,1
    11e2:	59e040ef          	jal	5780 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    11e6:	863e                	mv	a2,a5
    11e8:	f6840593          	addi	a1,s0,-152
    11ec:	00005517          	auipc	a0,0x5
    11f0:	41450513          	addi	a0,a0,1044 # 6600 <malloc+0x94e>
    11f4:	203040ef          	jal	5bf6 <printf>
    exit(1);
    11f8:	4505                	li	a0,1
    11fa:	586040ef          	jal	5780 <exit>
    printf("fork failed\n");
    11fe:	00007517          	auipc	a0,0x7
    1202:	b6a50513          	addi	a0,a0,-1174 # 7d68 <malloc+0x20b6>
    1206:	1f1040ef          	jal	5bf6 <printf>
    exit(1);
    120a:	4505                	li	a0,1
    120c:	574040ef          	jal	5780 <exit>
    exit(747); // OK
    1210:	2eb00513          	li	a0,747
    1214:	56c040ef          	jal	5780 <exit>
  int st = 0;
    1218:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    121c:	f5440513          	addi	a0,s0,-172
    1220:	568040ef          	jal	5788 <wait>
  if (st != 747) {
    1224:	f5442703          	lw	a4,-172(s0)
    1228:	2eb00793          	li	a5,747
    122c:	00f71663          	bne	a4,a5,1238 <copyinstr2+0x18c>
}
    1230:	60ae                	ld	ra,200(sp)
    1232:	640e                	ld	s0,192(sp)
    1234:	6169                	addi	sp,sp,208
    1236:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    1238:	00005517          	auipc	a0,0x5
    123c:	41050513          	addi	a0,a0,1040 # 6648 <malloc+0x996>
    1240:	1b7040ef          	jal	5bf6 <printf>
    exit(1);
    1244:	4505                	li	a0,1
    1246:	53a040ef          	jal	5780 <exit>

000000000000124a <truncate3>:
{
    124a:	7175                	addi	sp,sp,-144
    124c:	e506                	sd	ra,136(sp)
    124e:	e122                	sd	s0,128(sp)
    1250:	fc66                	sd	s9,56(sp)
    1252:	0900                	addi	s0,sp,144
    1254:	8caa                	mv	s9,a0
  close(open("truncfile", O_CREATE | O_TRUNC | O_WRONLY));
    1256:	60100593          	li	a1,1537
    125a:	00005517          	auipc	a0,0x5
    125e:	be650513          	addi	a0,a0,-1050 # 5e40 <malloc+0x18e>
    1262:	55e040ef          	jal	57c0 <open>
    1266:	542040ef          	jal	57a8 <close>
  pid = fork();
    126a:	50e040ef          	jal	5778 <fork>
  if (pid < 0) {
    126e:	06054d63          	bltz	a0,12e8 <truncate3+0x9e>
  if (pid == 0) {
    1272:	e171                	bnez	a0,1336 <truncate3+0xec>
    1274:	fca6                	sd	s1,120(sp)
    1276:	f8ca                	sd	s2,112(sp)
    1278:	f4ce                	sd	s3,104(sp)
    127a:	f0d2                	sd	s4,96(sp)
    127c:	ecd6                	sd	s5,88(sp)
    127e:	e8da                	sd	s6,80(sp)
    1280:	e4de                	sd	s7,72(sp)
    1282:	e0e2                	sd	s8,64(sp)
    1284:	06400913          	li	s2,100
      int fd = open("truncfile", O_WRONLY);
    1288:	4a85                	li	s5,1
    128a:	00005997          	auipc	s3,0x5
    128e:	bb698993          	addi	s3,s3,-1098 # 5e40 <malloc+0x18e>
      int n = write(fd, "1234567890", 10);
    1292:	4a29                	li	s4,10
    1294:	00005b17          	auipc	s6,0x5
    1298:	414b0b13          	addi	s6,s6,1044 # 66a8 <malloc+0x9f6>
      read(fd, buf, sizeof(buf));
    129c:	f7840c13          	addi	s8,s0,-136
    12a0:	02000b93          	li	s7,32
      int fd = open("truncfile", O_WRONLY);
    12a4:	85d6                	mv	a1,s5
    12a6:	854e                	mv	a0,s3
    12a8:	518040ef          	jal	57c0 <open>
    12ac:	84aa                	mv	s1,a0
      if (fd < 0) {
    12ae:	04054f63          	bltz	a0,130c <truncate3+0xc2>
      int n = write(fd, "1234567890", 10);
    12b2:	8652                	mv	a2,s4
    12b4:	85da                	mv	a1,s6
    12b6:	4ea040ef          	jal	57a0 <write>
      if (n != 10) {
    12ba:	07451363          	bne	a0,s4,1320 <truncate3+0xd6>
      close(fd);
    12be:	8526                	mv	a0,s1
    12c0:	4e8040ef          	jal	57a8 <close>
      fd = open("truncfile", O_RDONLY);
    12c4:	4581                	li	a1,0
    12c6:	854e                	mv	a0,s3
    12c8:	4f8040ef          	jal	57c0 <open>
    12cc:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    12ce:	865e                	mv	a2,s7
    12d0:	85e2                	mv	a1,s8
    12d2:	4c6040ef          	jal	5798 <read>
      close(fd);
    12d6:	8526                	mv	a0,s1
    12d8:	4d0040ef          	jal	57a8 <close>
    for (int i = 0; i < 100; i++) {
    12dc:	397d                	addiw	s2,s2,-1
    12de:	fc0913e3          	bnez	s2,12a4 <truncate3+0x5a>
    exit(0);
    12e2:	4501                	li	a0,0
    12e4:	49c040ef          	jal	5780 <exit>
    12e8:	fca6                	sd	s1,120(sp)
    12ea:	f8ca                	sd	s2,112(sp)
    12ec:	f4ce                	sd	s3,104(sp)
    12ee:	f0d2                	sd	s4,96(sp)
    12f0:	ecd6                	sd	s5,88(sp)
    12f2:	e8da                	sd	s6,80(sp)
    12f4:	e4de                	sd	s7,72(sp)
    12f6:	e0e2                	sd	s8,64(sp)
    printf("%s: fork failed\n", s);
    12f8:	85e6                	mv	a1,s9
    12fa:	00005517          	auipc	a0,0x5
    12fe:	37e50513          	addi	a0,a0,894 # 6678 <malloc+0x9c6>
    1302:	0f5040ef          	jal	5bf6 <printf>
    exit(1);
    1306:	4505                	li	a0,1
    1308:	478040ef          	jal	5780 <exit>
        printf("%s: open failed\n", s);
    130c:	85e6                	mv	a1,s9
    130e:	00005517          	auipc	a0,0x5
    1312:	38250513          	addi	a0,a0,898 # 6690 <malloc+0x9de>
    1316:	0e1040ef          	jal	5bf6 <printf>
        exit(1);
    131a:	4505                	li	a0,1
    131c:	464040ef          	jal	5780 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1320:	862a                	mv	a2,a0
    1322:	85e6                	mv	a1,s9
    1324:	00005517          	auipc	a0,0x5
    1328:	39450513          	addi	a0,a0,916 # 66b8 <malloc+0xa06>
    132c:	0cb040ef          	jal	5bf6 <printf>
        exit(1);
    1330:	4505                	li	a0,1
    1332:	44e040ef          	jal	5780 <exit>
    1336:	fca6                	sd	s1,120(sp)
    1338:	f8ca                	sd	s2,112(sp)
    133a:	f4ce                	sd	s3,104(sp)
    133c:	f0d2                	sd	s4,96(sp)
    133e:	ecd6                	sd	s5,88(sp)
    1340:	e8da                	sd	s6,80(sp)
  if (pid == 0) {
    1342:	09600913          	li	s2,150
    int fd = open("truncfile", O_CREATE | O_WRONLY | O_TRUNC);
    1346:	60100a93          	li	s5,1537
    134a:	00005a17          	auipc	s4,0x5
    134e:	af6a0a13          	addi	s4,s4,-1290 # 5e40 <malloc+0x18e>
    int n = write(fd, "xxx", 3);
    1352:	498d                	li	s3,3
    1354:	00005b17          	auipc	s6,0x5
    1358:	384b0b13          	addi	s6,s6,900 # 66d8 <malloc+0xa26>
    int fd = open("truncfile", O_CREATE | O_WRONLY | O_TRUNC);
    135c:	85d6                	mv	a1,s5
    135e:	8552                	mv	a0,s4
    1360:	460040ef          	jal	57c0 <open>
    1364:	84aa                	mv	s1,a0
    if (fd < 0) {
    1366:	02054e63          	bltz	a0,13a2 <truncate3+0x158>
    int n = write(fd, "xxx", 3);
    136a:	864e                	mv	a2,s3
    136c:	85da                	mv	a1,s6
    136e:	432040ef          	jal	57a0 <write>
    if (n != 3) {
    1372:	05351463          	bne	a0,s3,13ba <truncate3+0x170>
    close(fd);
    1376:	8526                	mv	a0,s1
    1378:	430040ef          	jal	57a8 <close>
  for (int i = 0; i < 150; i++) {
    137c:	397d                	addiw	s2,s2,-1
    137e:	fc091fe3          	bnez	s2,135c <truncate3+0x112>
    1382:	e4de                	sd	s7,72(sp)
    1384:	e0e2                	sd	s8,64(sp)
  wait(&xstatus);
    1386:	f9c40513          	addi	a0,s0,-100
    138a:	3fe040ef          	jal	5788 <wait>
  unlink("truncfile");
    138e:	00005517          	auipc	a0,0x5
    1392:	ab250513          	addi	a0,a0,-1358 # 5e40 <malloc+0x18e>
    1396:	43a040ef          	jal	57d0 <unlink>
  exit(xstatus);
    139a:	f9c42503          	lw	a0,-100(s0)
    139e:	3e2040ef          	jal	5780 <exit>
    13a2:	e4de                	sd	s7,72(sp)
    13a4:	e0e2                	sd	s8,64(sp)
      printf("%s: open failed\n", s);
    13a6:	85e6                	mv	a1,s9
    13a8:	00005517          	auipc	a0,0x5
    13ac:	2e850513          	addi	a0,a0,744 # 6690 <malloc+0x9de>
    13b0:	047040ef          	jal	5bf6 <printf>
      exit(1);
    13b4:	4505                	li	a0,1
    13b6:	3ca040ef          	jal	5780 <exit>
    13ba:	e4de                	sd	s7,72(sp)
    13bc:	e0e2                	sd	s8,64(sp)
      printf("%s: write got %d, expected 3\n", s, n);
    13be:	862a                	mv	a2,a0
    13c0:	85e6                	mv	a1,s9
    13c2:	00005517          	auipc	a0,0x5
    13c6:	31e50513          	addi	a0,a0,798 # 66e0 <malloc+0xa2e>
    13ca:	02d040ef          	jal	5bf6 <printf>
      exit(1);
    13ce:	4505                	li	a0,1
    13d0:	3b0040ef          	jal	5780 <exit>

00000000000013d4 <pipe1>:
{
    13d4:	711d                	addi	sp,sp,-96
    13d6:	ec86                	sd	ra,88(sp)
    13d8:	e8a2                	sd	s0,80(sp)
    13da:	e862                	sd	s8,16(sp)
    13dc:	1080                	addi	s0,sp,96
    13de:	8c2a                	mv	s8,a0
  if (pipe(fds) != 0) {
    13e0:	fa840513          	addi	a0,s0,-88
    13e4:	3ac040ef          	jal	5790 <pipe>
    13e8:	e935                	bnez	a0,145c <pipe1+0x88>
    13ea:	e4a6                	sd	s1,72(sp)
    13ec:	fc4e                	sd	s3,56(sp)
    13ee:	84aa                	mv	s1,a0
  pid = fork();
    13f0:	388040ef          	jal	5778 <fork>
    13f4:	89aa                	mv	s3,a0
  if (pid == 0) {
    13f6:	c541                	beqz	a0,147e <pipe1+0xaa>
  } else if (pid > 0) {
    13f8:	16a05263          	blez	a0,155c <pipe1+0x188>
    13fc:	e0ca                	sd	s2,64(sp)
    13fe:	f852                	sd	s4,48(sp)
    close(fds[1]);
    1400:	fac42503          	lw	a0,-84(s0)
    1404:	3a4040ef          	jal	57a8 <close>
    total = 0;
    1408:	89a6                	mv	s3,s1
    cc = 1;
    140a:	4905                	li	s2,1
    while ((n = read(fds[0], buf, cc)) > 0) {
    140c:	0000ca17          	auipc	s4,0xc
    1410:	8eca0a13          	addi	s4,s4,-1812 # ccf8 <buf>
    1414:	864a                	mv	a2,s2
    1416:	85d2                	mv	a1,s4
    1418:	fa842503          	lw	a0,-88(s0)
    141c:	37c040ef          	jal	5798 <read>
    1420:	85aa                	mv	a1,a0
    1422:	0ea05b63          	blez	a0,1518 <pipe1+0x144>
    1426:	0000c797          	auipc	a5,0xc
    142a:	8d278793          	addi	a5,a5,-1838 # ccf8 <buf>
    142e:	00b4863b          	addw	a2,s1,a1
        if ((buf[i] & 0xff) != (seq++ & 0xff)) {
    1432:	0007c683          	lbu	a3,0(a5)
    1436:	0ff4f713          	zext.b	a4,s1
    143a:	0ae69f63          	bne	a3,a4,14f8 <pipe1+0x124>
    143e:	2485                	addiw	s1,s1,1
      for (i = 0; i < n; i++) {
    1440:	0785                	addi	a5,a5,1
    1442:	fec498e3          	bne	s1,a2,1432 <pipe1+0x5e>
      total += n;
    1446:	00b989bb          	addw	s3,s3,a1
      cc = cc * 2;
    144a:	0019191b          	slliw	s2,s2,0x1
      if (cc > sizeof(buf))
    144e:	67d5                	lui	a5,0x15
    1450:	80078793          	addi	a5,a5,-2048 # 14800 <buf+0x7b08>
    1454:	fd27f0e3          	bgeu	a5,s2,1414 <pipe1+0x40>
        cc = sizeof(buf);
    1458:	893e                	mv	s2,a5
    145a:	bf6d                	j	1414 <pipe1+0x40>
    145c:	e4a6                	sd	s1,72(sp)
    145e:	e0ca                	sd	s2,64(sp)
    1460:	fc4e                	sd	s3,56(sp)
    1462:	f852                	sd	s4,48(sp)
    1464:	f456                	sd	s5,40(sp)
    1466:	f05a                	sd	s6,32(sp)
    1468:	ec5e                	sd	s7,24(sp)
    printf("%s: pipe() failed\n", s);
    146a:	85e2                	mv	a1,s8
    146c:	00005517          	auipc	a0,0x5
    1470:	29450513          	addi	a0,a0,660 # 6700 <malloc+0xa4e>
    1474:	782040ef          	jal	5bf6 <printf>
    exit(1);
    1478:	4505                	li	a0,1
    147a:	306040ef          	jal	5780 <exit>
    147e:	e0ca                	sd	s2,64(sp)
    1480:	f852                	sd	s4,48(sp)
    1482:	f456                	sd	s5,40(sp)
    1484:	f05a                	sd	s6,32(sp)
    1486:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    1488:	fa842503          	lw	a0,-88(s0)
    148c:	31c040ef          	jal	57a8 <close>
    for (n = 0; n < N; n++) {
    1490:	0000cb17          	auipc	s6,0xc
    1494:	868b0b13          	addi	s6,s6,-1944 # ccf8 <buf>
    1498:	416004bb          	negw	s1,s6
    149c:	0ff4f493          	zext.b	s1,s1
    14a0:	409b0913          	addi	s2,s6,1033
      if (write(fds[1], buf, SZ) != SZ) {
    14a4:	40900a13          	li	s4,1033
    14a8:	8bda                	mv	s7,s6
    for (n = 0; n < N; n++) {
    14aa:	6a85                	lui	s5,0x1
    14ac:	42da8a93          	addi	s5,s5,1069 # 142d <pipe1+0x59>
{
    14b0:	87da                	mv	a5,s6
        buf[i] = seq++;
    14b2:	0097873b          	addw	a4,a5,s1
    14b6:	00e78023          	sb	a4,0(a5)
      for (i = 0; i < SZ; i++)
    14ba:	0785                	addi	a5,a5,1
    14bc:	ff279be3          	bne	a5,s2,14b2 <pipe1+0xde>
      if (write(fds[1], buf, SZ) != SZ) {
    14c0:	8652                	mv	a2,s4
    14c2:	85de                	mv	a1,s7
    14c4:	fac42503          	lw	a0,-84(s0)
    14c8:	2d8040ef          	jal	57a0 <write>
    14cc:	01451c63          	bne	a0,s4,14e4 <pipe1+0x110>
    14d0:	4099899b          	addiw	s3,s3,1033
    for (n = 0; n < N; n++) {
    14d4:	24a5                	addiw	s1,s1,9
    14d6:	0ff4f493          	zext.b	s1,s1
    14da:	fd599be3          	bne	s3,s5,14b0 <pipe1+0xdc>
    exit(0);
    14de:	4501                	li	a0,0
    14e0:	2a0040ef          	jal	5780 <exit>
        printf("%s: pipe1 oops 1\n", s);
    14e4:	85e2                	mv	a1,s8
    14e6:	00005517          	auipc	a0,0x5
    14ea:	23250513          	addi	a0,a0,562 # 6718 <malloc+0xa66>
    14ee:	708040ef          	jal	5bf6 <printf>
        exit(1);
    14f2:	4505                	li	a0,1
    14f4:	28c040ef          	jal	5780 <exit>
          printf("%s: pipe1 oops 2\n", s);
    14f8:	85e2                	mv	a1,s8
    14fa:	00005517          	auipc	a0,0x5
    14fe:	23650513          	addi	a0,a0,566 # 6730 <malloc+0xa7e>
    1502:	6f4040ef          	jal	5bf6 <printf>
          return;
    1506:	64a6                	ld	s1,72(sp)
    1508:	6906                	ld	s2,64(sp)
    150a:	79e2                	ld	s3,56(sp)
    150c:	7a42                	ld	s4,48(sp)
}
    150e:	60e6                	ld	ra,88(sp)
    1510:	6446                	ld	s0,80(sp)
    1512:	6c42                	ld	s8,16(sp)
    1514:	6125                	addi	sp,sp,96
    1516:	8082                	ret
    if (total != N * SZ) {
    1518:	6785                	lui	a5,0x1
    151a:	42d78793          	addi	a5,a5,1069 # 142d <pipe1+0x59>
    151e:	02f98063          	beq	s3,a5,153e <pipe1+0x16a>
    1522:	f456                	sd	s5,40(sp)
    1524:	f05a                	sd	s6,32(sp)
    1526:	ec5e                	sd	s7,24(sp)
      printf("%s: pipe1 oops 3 total %d\n", s, total);
    1528:	864e                	mv	a2,s3
    152a:	85e2                	mv	a1,s8
    152c:	00005517          	auipc	a0,0x5
    1530:	21c50513          	addi	a0,a0,540 # 6748 <malloc+0xa96>
    1534:	6c2040ef          	jal	5bf6 <printf>
      exit(1);
    1538:	4505                	li	a0,1
    153a:	246040ef          	jal	5780 <exit>
    153e:	f456                	sd	s5,40(sp)
    1540:	f05a                	sd	s6,32(sp)
    1542:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    1544:	fa842503          	lw	a0,-88(s0)
    1548:	260040ef          	jal	57a8 <close>
    wait(&xstatus);
    154c:	fa440513          	addi	a0,s0,-92
    1550:	238040ef          	jal	5788 <wait>
    exit(xstatus);
    1554:	fa442503          	lw	a0,-92(s0)
    1558:	228040ef          	jal	5780 <exit>
    155c:	e0ca                	sd	s2,64(sp)
    155e:	f852                	sd	s4,48(sp)
    1560:	f456                	sd	s5,40(sp)
    1562:	f05a                	sd	s6,32(sp)
    1564:	ec5e                	sd	s7,24(sp)
    printf("%s: fork() failed\n", s);
    1566:	85e2                	mv	a1,s8
    1568:	00005517          	auipc	a0,0x5
    156c:	20050513          	addi	a0,a0,512 # 6768 <malloc+0xab6>
    1570:	686040ef          	jal	5bf6 <printf>
    exit(1);
    1574:	4505                	li	a0,1
    1576:	20a040ef          	jal	5780 <exit>

000000000000157a <exitwait>:
{
    157a:	715d                	addi	sp,sp,-80
    157c:	e486                	sd	ra,72(sp)
    157e:	e0a2                	sd	s0,64(sp)
    1580:	fc26                	sd	s1,56(sp)
    1582:	f84a                	sd	s2,48(sp)
    1584:	f44e                	sd	s3,40(sp)
    1586:	f052                	sd	s4,32(sp)
    1588:	ec56                	sd	s5,24(sp)
    158a:	0880                	addi	s0,sp,80
    158c:	8aaa                	mv	s5,a0
  for (i = 0; i < 100; i++) {
    158e:	4901                	li	s2,0
      if (wait(&xstate) != pid) {
    1590:	fbc40993          	addi	s3,s0,-68
  for (i = 0; i < 100; i++) {
    1594:	06400a13          	li	s4,100
    pid = fork();
    1598:	1e0040ef          	jal	5778 <fork>
    159c:	84aa                	mv	s1,a0
    if (pid < 0) {
    159e:	02054863          	bltz	a0,15ce <exitwait+0x54>
    if (pid) {
    15a2:	c525                	beqz	a0,160a <exitwait+0x90>
      if (wait(&xstate) != pid) {
    15a4:	854e                	mv	a0,s3
    15a6:	1e2040ef          	jal	5788 <wait>
    15aa:	02951c63          	bne	a0,s1,15e2 <exitwait+0x68>
      if (i != xstate) {
    15ae:	fbc42783          	lw	a5,-68(s0)
    15b2:	05279263          	bne	a5,s2,15f6 <exitwait+0x7c>
  for (i = 0; i < 100; i++) {
    15b6:	2905                	addiw	s2,s2,1
    15b8:	ff4910e3          	bne	s2,s4,1598 <exitwait+0x1e>
}
    15bc:	60a6                	ld	ra,72(sp)
    15be:	6406                	ld	s0,64(sp)
    15c0:	74e2                	ld	s1,56(sp)
    15c2:	7942                	ld	s2,48(sp)
    15c4:	79a2                	ld	s3,40(sp)
    15c6:	7a02                	ld	s4,32(sp)
    15c8:	6ae2                	ld	s5,24(sp)
    15ca:	6161                	addi	sp,sp,80
    15cc:	8082                	ret
      printf("%s: fork failed\n", s);
    15ce:	85d6                	mv	a1,s5
    15d0:	00005517          	auipc	a0,0x5
    15d4:	0a850513          	addi	a0,a0,168 # 6678 <malloc+0x9c6>
    15d8:	61e040ef          	jal	5bf6 <printf>
      exit(1);
    15dc:	4505                	li	a0,1
    15de:	1a2040ef          	jal	5780 <exit>
        printf("%s: wait wrong pid\n", s);
    15e2:	85d6                	mv	a1,s5
    15e4:	00005517          	auipc	a0,0x5
    15e8:	19c50513          	addi	a0,a0,412 # 6780 <malloc+0xace>
    15ec:	60a040ef          	jal	5bf6 <printf>
        exit(1);
    15f0:	4505                	li	a0,1
    15f2:	18e040ef          	jal	5780 <exit>
        printf("%s: wait wrong exit status\n", s);
    15f6:	85d6                	mv	a1,s5
    15f8:	00005517          	auipc	a0,0x5
    15fc:	1a050513          	addi	a0,a0,416 # 6798 <malloc+0xae6>
    1600:	5f6040ef          	jal	5bf6 <printf>
        exit(1);
    1604:	4505                	li	a0,1
    1606:	17a040ef          	jal	5780 <exit>
      exit(i);
    160a:	854a                	mv	a0,s2
    160c:	174040ef          	jal	5780 <exit>

0000000000001610 <twochildren>:
{
    1610:	1101                	addi	sp,sp,-32
    1612:	ec06                	sd	ra,24(sp)
    1614:	e822                	sd	s0,16(sp)
    1616:	e426                	sd	s1,8(sp)
    1618:	e04a                	sd	s2,0(sp)
    161a:	1000                	addi	s0,sp,32
    161c:	892a                	mv	s2,a0
    161e:	3e800493          	li	s1,1000
    int pid1 = fork();
    1622:	156040ef          	jal	5778 <fork>
    if (pid1 < 0) {
    1626:	02054663          	bltz	a0,1652 <twochildren+0x42>
    if (pid1 == 0) {
    162a:	cd15                	beqz	a0,1666 <twochildren+0x56>
      int pid2 = fork();
    162c:	14c040ef          	jal	5778 <fork>
      if (pid2 < 0) {
    1630:	02054d63          	bltz	a0,166a <twochildren+0x5a>
      if (pid2 == 0) {
    1634:	c529                	beqz	a0,167e <twochildren+0x6e>
        wait(0);
    1636:	4501                	li	a0,0
    1638:	150040ef          	jal	5788 <wait>
        wait(0);
    163c:	4501                	li	a0,0
    163e:	14a040ef          	jal	5788 <wait>
  for (int i = 0; i < 1000; i++) {
    1642:	34fd                	addiw	s1,s1,-1
    1644:	fcf9                	bnez	s1,1622 <twochildren+0x12>
}
    1646:	60e2                	ld	ra,24(sp)
    1648:	6442                	ld	s0,16(sp)
    164a:	64a2                	ld	s1,8(sp)
    164c:	6902                	ld	s2,0(sp)
    164e:	6105                	addi	sp,sp,32
    1650:	8082                	ret
      printf("%s: fork failed\n", s);
    1652:	85ca                	mv	a1,s2
    1654:	00005517          	auipc	a0,0x5
    1658:	02450513          	addi	a0,a0,36 # 6678 <malloc+0x9c6>
    165c:	59a040ef          	jal	5bf6 <printf>
      exit(1);
    1660:	4505                	li	a0,1
    1662:	11e040ef          	jal	5780 <exit>
      exit(0);
    1666:	11a040ef          	jal	5780 <exit>
        printf("%s: fork failed\n", s);
    166a:	85ca                	mv	a1,s2
    166c:	00005517          	auipc	a0,0x5
    1670:	00c50513          	addi	a0,a0,12 # 6678 <malloc+0x9c6>
    1674:	582040ef          	jal	5bf6 <printf>
        exit(1);
    1678:	4505                	li	a0,1
    167a:	106040ef          	jal	5780 <exit>
        exit(0);
    167e:	102040ef          	jal	5780 <exit>

0000000000001682 <forkfork>:
{
    1682:	7179                	addi	sp,sp,-48
    1684:	f406                	sd	ra,40(sp)
    1686:	f022                	sd	s0,32(sp)
    1688:	ec26                	sd	s1,24(sp)
    168a:	1800                	addi	s0,sp,48
    168c:	84aa                	mv	s1,a0
    int pid = fork();
    168e:	0ea040ef          	jal	5778 <fork>
    if (pid < 0) {
    1692:	02054b63          	bltz	a0,16c8 <forkfork+0x46>
    if (pid == 0) {
    1696:	c139                	beqz	a0,16dc <forkfork+0x5a>
    int pid = fork();
    1698:	0e0040ef          	jal	5778 <fork>
    if (pid < 0) {
    169c:	02054663          	bltz	a0,16c8 <forkfork+0x46>
    if (pid == 0) {
    16a0:	cd15                	beqz	a0,16dc <forkfork+0x5a>
    wait(&xstatus);
    16a2:	fdc40513          	addi	a0,s0,-36
    16a6:	0e2040ef          	jal	5788 <wait>
    if (xstatus != 0) {
    16aa:	fdc42783          	lw	a5,-36(s0)
    16ae:	ebb9                	bnez	a5,1704 <forkfork+0x82>
    wait(&xstatus);
    16b0:	fdc40513          	addi	a0,s0,-36
    16b4:	0d4040ef          	jal	5788 <wait>
    if (xstatus != 0) {
    16b8:	fdc42783          	lw	a5,-36(s0)
    16bc:	e7a1                	bnez	a5,1704 <forkfork+0x82>
}
    16be:	70a2                	ld	ra,40(sp)
    16c0:	7402                	ld	s0,32(sp)
    16c2:	64e2                	ld	s1,24(sp)
    16c4:	6145                	addi	sp,sp,48
    16c6:	8082                	ret
      printf("%s: fork failed", s);
    16c8:	85a6                	mv	a1,s1
    16ca:	00005517          	auipc	a0,0x5
    16ce:	0ee50513          	addi	a0,a0,238 # 67b8 <malloc+0xb06>
    16d2:	524040ef          	jal	5bf6 <printf>
      exit(1);
    16d6:	4505                	li	a0,1
    16d8:	0a8040ef          	jal	5780 <exit>
{
    16dc:	0c800493          	li	s1,200
        int pid1 = fork();
    16e0:	098040ef          	jal	5778 <fork>
        if (pid1 < 0) {
    16e4:	00054b63          	bltz	a0,16fa <forkfork+0x78>
        if (pid1 == 0) {
    16e8:	cd01                	beqz	a0,1700 <forkfork+0x7e>
        wait(0);
    16ea:	4501                	li	a0,0
    16ec:	09c040ef          	jal	5788 <wait>
      for (int j = 0; j < 200; j++) {
    16f0:	34fd                	addiw	s1,s1,-1
    16f2:	f4fd                	bnez	s1,16e0 <forkfork+0x5e>
      exit(0);
    16f4:	4501                	li	a0,0
    16f6:	08a040ef          	jal	5780 <exit>
          exit(1);
    16fa:	4505                	li	a0,1
    16fc:	084040ef          	jal	5780 <exit>
          exit(0);
    1700:	080040ef          	jal	5780 <exit>
      printf("%s: fork in child failed", s);
    1704:	85a6                	mv	a1,s1
    1706:	00005517          	auipc	a0,0x5
    170a:	0c250513          	addi	a0,a0,194 # 67c8 <malloc+0xb16>
    170e:	4e8040ef          	jal	5bf6 <printf>
      exit(1);
    1712:	4505                	li	a0,1
    1714:	06c040ef          	jal	5780 <exit>

0000000000001718 <reparent2>:
{
    1718:	1101                	addi	sp,sp,-32
    171a:	ec06                	sd	ra,24(sp)
    171c:	e822                	sd	s0,16(sp)
    171e:	e426                	sd	s1,8(sp)
    1720:	1000                	addi	s0,sp,32
    1722:	32000493          	li	s1,800
    int pid1 = fork();
    1726:	052040ef          	jal	5778 <fork>
    if (pid1 < 0) {
    172a:	00054b63          	bltz	a0,1740 <reparent2+0x28>
    if (pid1 == 0) {
    172e:	c115                	beqz	a0,1752 <reparent2+0x3a>
    wait(0);
    1730:	4501                	li	a0,0
    1732:	056040ef          	jal	5788 <wait>
  for (int i = 0; i < 800; i++) {
    1736:	34fd                	addiw	s1,s1,-1
    1738:	f4fd                	bnez	s1,1726 <reparent2+0xe>
  exit(0);
    173a:	4501                	li	a0,0
    173c:	044040ef          	jal	5780 <exit>
      printf("fork failed\n");
    1740:	00006517          	auipc	a0,0x6
    1744:	62850513          	addi	a0,a0,1576 # 7d68 <malloc+0x20b6>
    1748:	4ae040ef          	jal	5bf6 <printf>
      exit(1);
    174c:	4505                	li	a0,1
    174e:	032040ef          	jal	5780 <exit>
      fork();
    1752:	026040ef          	jal	5778 <fork>
      fork();
    1756:	022040ef          	jal	5778 <fork>
      exit(0);
    175a:	4501                	li	a0,0
    175c:	024040ef          	jal	5780 <exit>

0000000000001760 <createdelete>:
{
    1760:	7135                	addi	sp,sp,-160
    1762:	ed06                	sd	ra,152(sp)
    1764:	e922                	sd	s0,144(sp)
    1766:	e526                	sd	s1,136(sp)
    1768:	e14a                	sd	s2,128(sp)
    176a:	fcce                	sd	s3,120(sp)
    176c:	f8d2                	sd	s4,112(sp)
    176e:	f4d6                	sd	s5,104(sp)
    1770:	f0da                	sd	s6,96(sp)
    1772:	ecde                	sd	s7,88(sp)
    1774:	e8e2                	sd	s8,80(sp)
    1776:	e4e6                	sd	s9,72(sp)
    1778:	e0ea                	sd	s10,64(sp)
    177a:	fc6e                	sd	s11,56(sp)
    177c:	1100                	addi	s0,sp,160
    177e:	8daa                	mv	s11,a0
  for (pi = 0; pi < NCHILD; pi++) {
    1780:	4901                	li	s2,0
    1782:	4991                	li	s3,4
    pid = fork();
    1784:	7f5030ef          	jal	5778 <fork>
    1788:	84aa                	mv	s1,a0
    if (pid < 0) {
    178a:	04054063          	bltz	a0,17ca <createdelete+0x6a>
    if (pid == 0) {
    178e:	c921                	beqz	a0,17de <createdelete+0x7e>
  for (pi = 0; pi < NCHILD; pi++) {
    1790:	2905                	addiw	s2,s2,1
    1792:	ff3919e3          	bne	s2,s3,1784 <createdelete+0x24>
    1796:	4491                	li	s1,4
    wait(&xstatus);
    1798:	f6c40913          	addi	s2,s0,-148
    179c:	854a                	mv	a0,s2
    179e:	7eb030ef          	jal	5788 <wait>
    if (xstatus != 0)
    17a2:	f6c42a83          	lw	s5,-148(s0)
    17a6:	0c0a9263          	bnez	s5,186a <createdelete+0x10a>
  for (pi = 0; pi < NCHILD; pi++) {
    17aa:	34fd                	addiw	s1,s1,-1
    17ac:	f8e5                	bnez	s1,179c <createdelete+0x3c>
  name[0] = name[1] = name[2] = 0;
    17ae:	f6040923          	sb	zero,-142(s0)
    17b2:	03000993          	li	s3,48
    17b6:	5a7d                	li	s4,-1
      if ((i == 0 || i >= N / 2) && fd < 0) {
    17b8:	4d25                	li	s10,9
    17ba:	07000c93          	li	s9,112
      fd = open(name, 0);
    17be:	f7040c13          	addi	s8,s0,-144
      } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    17c2:	4ba1                	li	s7,8
    for (pi = 0; pi < NCHILD; pi++) {
    17c4:	07400b13          	li	s6,116
    17c8:	aa39                	j	18e6 <createdelete+0x186>
      printf("%s: fork failed\n", s);
    17ca:	85ee                	mv	a1,s11
    17cc:	00005517          	auipc	a0,0x5
    17d0:	eac50513          	addi	a0,a0,-340 # 6678 <malloc+0x9c6>
    17d4:	422040ef          	jal	5bf6 <printf>
      exit(1);
    17d8:	4505                	li	a0,1
    17da:	7a7030ef          	jal	5780 <exit>
      name[0] = 'p' + pi;
    17de:	0709091b          	addiw	s2,s2,112
    17e2:	f7240823          	sb	s2,-144(s0)
      name[2] = '\0';
    17e6:	f6040923          	sb	zero,-142(s0)
        fd = open(name, O_CREATE | O_RDWR);
    17ea:	f7040913          	addi	s2,s0,-144
    17ee:	20200993          	li	s3,514
      for (i = 0; i < N; i++) {
    17f2:	4a51                	li	s4,20
    17f4:	a815                	j	1828 <createdelete+0xc8>
          printf("%s: create failed\n", s);
    17f6:	85ee                	mv	a1,s11
    17f8:	00005517          	auipc	a0,0x5
    17fc:	ff050513          	addi	a0,a0,-16 # 67e8 <malloc+0xb36>
    1800:	3f6040ef          	jal	5bf6 <printf>
          exit(1);
    1804:	4505                	li	a0,1
    1806:	77b030ef          	jal	5780 <exit>
          name[1] = '0' + (i / 2);
    180a:	01f4d79b          	srliw	a5,s1,0x1f
    180e:	9fa5                	addw	a5,a5,s1
    1810:	4017d79b          	sraiw	a5,a5,0x1
    1814:	0307879b          	addiw	a5,a5,48
    1818:	f6f408a3          	sb	a5,-143(s0)
          if (unlink(name) < 0) {
    181c:	854a                	mv	a0,s2
    181e:	7b3030ef          	jal	57d0 <unlink>
    1822:	02054a63          	bltz	a0,1856 <createdelete+0xf6>
      for (i = 0; i < N; i++) {
    1826:	2485                	addiw	s1,s1,1
        name[1] = '0' + i;
    1828:	0304879b          	addiw	a5,s1,48
    182c:	f6f408a3          	sb	a5,-143(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1830:	85ce                	mv	a1,s3
    1832:	854a                	mv	a0,s2
    1834:	78d030ef          	jal	57c0 <open>
        if (fd < 0) {
    1838:	fa054fe3          	bltz	a0,17f6 <createdelete+0x96>
        close(fd);
    183c:	76d030ef          	jal	57a8 <close>
        if (i > 0 && (i % 2) == 0) {
    1840:	fe9053e3          	blez	s1,1826 <createdelete+0xc6>
    1844:	0014f793          	andi	a5,s1,1
    1848:	d3e9                	beqz	a5,180a <createdelete+0xaa>
      for (i = 0; i < N; i++) {
    184a:	2485                	addiw	s1,s1,1
    184c:	fd449ee3          	bne	s1,s4,1828 <createdelete+0xc8>
      exit(0);
    1850:	4501                	li	a0,0
    1852:	72f030ef          	jal	5780 <exit>
            printf("%s: unlink failed\n", s);
    1856:	85ee                	mv	a1,s11
    1858:	00005517          	auipc	a0,0x5
    185c:	fa850513          	addi	a0,a0,-88 # 6800 <malloc+0xb4e>
    1860:	396040ef          	jal	5bf6 <printf>
            exit(1);
    1864:	4505                	li	a0,1
    1866:	71b030ef          	jal	5780 <exit>
      exit(1);
    186a:	4505                	li	a0,1
    186c:	715030ef          	jal	5780 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1870:	f7040613          	addi	a2,s0,-144
    1874:	85ee                	mv	a1,s11
    1876:	00005517          	auipc	a0,0x5
    187a:	fa250513          	addi	a0,a0,-94 # 6818 <malloc+0xb66>
    187e:	378040ef          	jal	5bf6 <printf>
        exit(1);
    1882:	4505                	li	a0,1
    1884:	6fd030ef          	jal	5780 <exit>
      } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    1888:	02054063          	bltz	a0,18a8 <createdelete+0x148>
        printf("%s: oops createdelete %s did exist\n", s, name);
    188c:	f7040613          	addi	a2,s0,-144
    1890:	85ee                	mv	a1,s11
    1892:	00005517          	auipc	a0,0x5
    1896:	fae50513          	addi	a0,a0,-82 # 6840 <malloc+0xb8e>
    189a:	35c040ef          	jal	5bf6 <printf>
        exit(1);
    189e:	4505                	li	a0,1
    18a0:	6e1030ef          	jal	5780 <exit>
        close(fd);
    18a4:	705030ef          	jal	57a8 <close>
    for (pi = 0; pi < NCHILD; pi++) {
    18a8:	2485                	addiw	s1,s1,1
    18aa:	0ff4f493          	zext.b	s1,s1
    18ae:	03648463          	beq	s1,s6,18d6 <createdelete+0x176>
      name[0] = 'p' + pi;
    18b2:	f6940823          	sb	s1,-144(s0)
      name[1] = '0' + i;
    18b6:	f73408a3          	sb	s3,-143(s0)
      fd = open(name, 0);
    18ba:	4581                	li	a1,0
    18bc:	8562                	mv	a0,s8
    18be:	703030ef          	jal	57c0 <open>
      if ((i == 0 || i >= N / 2) && fd < 0) {
    18c2:	01f5579b          	srliw	a5,a0,0x1f
    18c6:	00f977b3          	and	a5,s2,a5
    18ca:	f3dd                	bnez	a5,1870 <createdelete+0x110>
      } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    18cc:	fb4bfee3          	bgeu	s7,s4,1888 <createdelete+0x128>
      if (fd >= 0)
    18d0:	fc054ce3          	bltz	a0,18a8 <createdelete+0x148>
    18d4:	bfc1                	j	18a4 <createdelete+0x144>
  for (i = 0; i < N; i++) {
    18d6:	2a85                	addiw	s5,s5,1
    18d8:	2a05                	addiw	s4,s4,1
    18da:	2985                	addiw	s3,s3,1
    18dc:	0ff9f993          	zext.b	s3,s3
    18e0:	47d1                	li	a5,20
    18e2:	00fa8a63          	beq	s5,a5,18f6 <createdelete+0x196>
      if ((i == 0 || i >= N / 2) && fd < 0) {
    18e6:	001ab913          	seqz	s2,s5
    18ea:	015d27b3          	slt	a5,s10,s5
    18ee:	00f96933          	or	s2,s2,a5
    18f2:	84e6                	mv	s1,s9
    18f4:	bf7d                	j	18b2 <createdelete+0x152>
  for (i = 0; i < N; i++) {
    18f6:	03000913          	li	s2,48
  name[0] = name[1] = name[2] = 0;
    18fa:	07000b13          	li	s6,112
      unlink(name);
    18fe:	f7040a13          	addi	s4,s0,-144
    for (pi = 0; pi < NCHILD; pi++) {
    1902:	07400993          	li	s3,116
  for (i = 0; i < N; i++) {
    1906:	04400a93          	li	s5,68
  name[0] = name[1] = name[2] = 0;
    190a:	84da                	mv	s1,s6
      name[0] = 'p' + pi;
    190c:	f6940823          	sb	s1,-144(s0)
      name[1] = '0' + i;
    1910:	f72408a3          	sb	s2,-143(s0)
      unlink(name);
    1914:	8552                	mv	a0,s4
    1916:	6bb030ef          	jal	57d0 <unlink>
    for (pi = 0; pi < NCHILD; pi++) {
    191a:	2485                	addiw	s1,s1,1
    191c:	0ff4f493          	zext.b	s1,s1
    1920:	ff3496e3          	bne	s1,s3,190c <createdelete+0x1ac>
  for (i = 0; i < N; i++) {
    1924:	2905                	addiw	s2,s2,1
    1926:	0ff97913          	zext.b	s2,s2
    192a:	ff5910e3          	bne	s2,s5,190a <createdelete+0x1aa>
}
    192e:	60ea                	ld	ra,152(sp)
    1930:	644a                	ld	s0,144(sp)
    1932:	64aa                	ld	s1,136(sp)
    1934:	690a                	ld	s2,128(sp)
    1936:	79e6                	ld	s3,120(sp)
    1938:	7a46                	ld	s4,112(sp)
    193a:	7aa6                	ld	s5,104(sp)
    193c:	7b06                	ld	s6,96(sp)
    193e:	6be6                	ld	s7,88(sp)
    1940:	6c46                	ld	s8,80(sp)
    1942:	6ca6                	ld	s9,72(sp)
    1944:	6d06                	ld	s10,64(sp)
    1946:	7de2                	ld	s11,56(sp)
    1948:	610d                	addi	sp,sp,160
    194a:	8082                	ret

000000000000194c <linkunlink>:
{
    194c:	711d                	addi	sp,sp,-96
    194e:	ec86                	sd	ra,88(sp)
    1950:	e8a2                	sd	s0,80(sp)
    1952:	e4a6                	sd	s1,72(sp)
    1954:	e0ca                	sd	s2,64(sp)
    1956:	fc4e                	sd	s3,56(sp)
    1958:	f852                	sd	s4,48(sp)
    195a:	f456                	sd	s5,40(sp)
    195c:	f05a                	sd	s6,32(sp)
    195e:	ec5e                	sd	s7,24(sp)
    1960:	e862                	sd	s8,16(sp)
    1962:	e466                	sd	s9,8(sp)
    1964:	e06a                	sd	s10,0(sp)
    1966:	1080                	addi	s0,sp,96
    1968:	84aa                	mv	s1,a0
  unlink("x");
    196a:	00004517          	auipc	a0,0x4
    196e:	4ee50513          	addi	a0,a0,1262 # 5e58 <malloc+0x1a6>
    1972:	65f030ef          	jal	57d0 <unlink>
  pid = fork();
    1976:	603030ef          	jal	5778 <fork>
  if (pid < 0) {
    197a:	04054663          	bltz	a0,19c6 <linkunlink+0x7a>
    197e:	8d2a                	mv	s10,a0
  unsigned int x = (pid ? 1 : 97);
    1980:	00153913          	seqz	s2,a0
    1984:	41200933          	neg	s2,s2
    1988:	06097913          	andi	s2,s2,96
    198c:	0905                	addi	s2,s2,1
    198e:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1992:	41c65ab7          	lui	s5,0x41c65
    1996:	e6da8a9b          	addiw	s5,s5,-403 # 41c64e6d <base+0x41c43975>
    199a:	6a0d                	lui	s4,0x3
    199c:	039a0a1b          	addiw	s4,s4,57 # 3039 <subdir+0x499>
    if ((x % 3) == 0) {
    19a0:	000ab9b7          	lui	s3,0xab
    19a4:	aab98993          	addi	s3,s3,-1365 # aaaab <base+0x895b3>
    19a8:	09b2                	slli	s3,s3,0xc
    19aa:	aab98993          	addi	s3,s3,-1365
    } else if ((x % 3) == 1) {
    19ae:	4b85                	li	s7,1
      unlink("x");
    19b0:	00004b17          	auipc	s6,0x4
    19b4:	4a8b0b13          	addi	s6,s6,1192 # 5e58 <malloc+0x1a6>
      link("cat", "x");
    19b8:	00005c97          	auipc	s9,0x5
    19bc:	eb0c8c93          	addi	s9,s9,-336 # 6868 <malloc+0xbb6>
      close(open("x", O_RDWR | O_CREATE));
    19c0:	20200c13          	li	s8,514
    19c4:	a03d                	j	19f2 <linkunlink+0xa6>
    printf("%s: fork failed\n", s);
    19c6:	85a6                	mv	a1,s1
    19c8:	00005517          	auipc	a0,0x5
    19cc:	cb050513          	addi	a0,a0,-848 # 6678 <malloc+0x9c6>
    19d0:	226040ef          	jal	5bf6 <printf>
    exit(1);
    19d4:	4505                	li	a0,1
    19d6:	5ab030ef          	jal	5780 <exit>
      close(open("x", O_RDWR | O_CREATE));
    19da:	85e2                	mv	a1,s8
    19dc:	855a                	mv	a0,s6
    19de:	5e3030ef          	jal	57c0 <open>
    19e2:	5c7030ef          	jal	57a8 <close>
    19e6:	a021                	j	19ee <linkunlink+0xa2>
      unlink("x");
    19e8:	855a                	mv	a0,s6
    19ea:	5e7030ef          	jal	57d0 <unlink>
  for (i = 0; i < 100; i++) {
    19ee:	34fd                	addiw	s1,s1,-1
    19f0:	c885                	beqz	s1,1a20 <linkunlink+0xd4>
    x = x * 1103515245 + 12345;
    19f2:	035907bb          	mulw	a5,s2,s5
    19f6:	00fa07bb          	addw	a5,s4,a5
    19fa:	893e                	mv	s2,a5
    if ((x % 3) == 0) {
    19fc:	02079713          	slli	a4,a5,0x20
    1a00:	9301                	srli	a4,a4,0x20
    1a02:	03370733          	mul	a4,a4,s3
    1a06:	9305                	srli	a4,a4,0x21
    1a08:	0017169b          	slliw	a3,a4,0x1
    1a0c:	9f35                	addw	a4,a4,a3
    1a0e:	9f99                	subw	a5,a5,a4
    1a10:	d7e9                	beqz	a5,19da <linkunlink+0x8e>
    } else if ((x % 3) == 1) {
    1a12:	fd779be3          	bne	a5,s7,19e8 <linkunlink+0x9c>
      link("cat", "x");
    1a16:	85da                	mv	a1,s6
    1a18:	8566                	mv	a0,s9
    1a1a:	5c7030ef          	jal	57e0 <link>
    1a1e:	bfc1                	j	19ee <linkunlink+0xa2>
  if (pid)
    1a20:	020d0363          	beqz	s10,1a46 <linkunlink+0xfa>
    wait(0);
    1a24:	4501                	li	a0,0
    1a26:	563030ef          	jal	5788 <wait>
}
    1a2a:	60e6                	ld	ra,88(sp)
    1a2c:	6446                	ld	s0,80(sp)
    1a2e:	64a6                	ld	s1,72(sp)
    1a30:	6906                	ld	s2,64(sp)
    1a32:	79e2                	ld	s3,56(sp)
    1a34:	7a42                	ld	s4,48(sp)
    1a36:	7aa2                	ld	s5,40(sp)
    1a38:	7b02                	ld	s6,32(sp)
    1a3a:	6be2                	ld	s7,24(sp)
    1a3c:	6c42                	ld	s8,16(sp)
    1a3e:	6ca2                	ld	s9,8(sp)
    1a40:	6d02                	ld	s10,0(sp)
    1a42:	6125                	addi	sp,sp,96
    1a44:	8082                	ret
    exit(0);
    1a46:	4501                	li	a0,0
    1a48:	539030ef          	jal	5780 <exit>

0000000000001a4c <forktest>:
{
    1a4c:	7179                	addi	sp,sp,-48
    1a4e:	f406                	sd	ra,40(sp)
    1a50:	f022                	sd	s0,32(sp)
    1a52:	ec26                	sd	s1,24(sp)
    1a54:	e84a                	sd	s2,16(sp)
    1a56:	e44e                	sd	s3,8(sp)
    1a58:	1800                	addi	s0,sp,48
    1a5a:	89aa                	mv	s3,a0
  for (n = 0; n < N; n++) {
    1a5c:	4481                	li	s1,0
    1a5e:	3e800913          	li	s2,1000
    pid = fork();
    1a62:	517030ef          	jal	5778 <fork>
    if (pid < 0)
    1a66:	06054063          	bltz	a0,1ac6 <forktest+0x7a>
    if (pid == 0)
    1a6a:	cd11                	beqz	a0,1a86 <forktest+0x3a>
  for (n = 0; n < N; n++) {
    1a6c:	2485                	addiw	s1,s1,1
    1a6e:	ff249ae3          	bne	s1,s2,1a62 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    1a72:	85ce                	mv	a1,s3
    1a74:	00005517          	auipc	a0,0x5
    1a78:	e4450513          	addi	a0,a0,-444 # 68b8 <malloc+0xc06>
    1a7c:	17a040ef          	jal	5bf6 <printf>
    exit(1);
    1a80:	4505                	li	a0,1
    1a82:	4ff030ef          	jal	5780 <exit>
      exit(0);
    1a86:	4fb030ef          	jal	5780 <exit>
    printf("%s: no fork at all!\n", s);
    1a8a:	85ce                	mv	a1,s3
    1a8c:	00005517          	auipc	a0,0x5
    1a90:	de450513          	addi	a0,a0,-540 # 6870 <malloc+0xbbe>
    1a94:	162040ef          	jal	5bf6 <printf>
    exit(1);
    1a98:	4505                	li	a0,1
    1a9a:	4e7030ef          	jal	5780 <exit>
      printf("%s: wait stopped early\n", s);
    1a9e:	85ce                	mv	a1,s3
    1aa0:	00005517          	auipc	a0,0x5
    1aa4:	de850513          	addi	a0,a0,-536 # 6888 <malloc+0xbd6>
    1aa8:	14e040ef          	jal	5bf6 <printf>
      exit(1);
    1aac:	4505                	li	a0,1
    1aae:	4d3030ef          	jal	5780 <exit>
    printf("%s: wait got too many\n", s);
    1ab2:	85ce                	mv	a1,s3
    1ab4:	00005517          	auipc	a0,0x5
    1ab8:	dec50513          	addi	a0,a0,-532 # 68a0 <malloc+0xbee>
    1abc:	13a040ef          	jal	5bf6 <printf>
    exit(1);
    1ac0:	4505                	li	a0,1
    1ac2:	4bf030ef          	jal	5780 <exit>
  if (n == 0) {
    1ac6:	d0f1                	beqz	s1,1a8a <forktest+0x3e>
  for (; n > 0; n--) {
    1ac8:	00905963          	blez	s1,1ada <forktest+0x8e>
    if (wait(0) < 0) {
    1acc:	4501                	li	a0,0
    1ace:	4bb030ef          	jal	5788 <wait>
    1ad2:	fc0546e3          	bltz	a0,1a9e <forktest+0x52>
  for (; n > 0; n--) {
    1ad6:	34fd                	addiw	s1,s1,-1
    1ad8:	f8f5                	bnez	s1,1acc <forktest+0x80>
  if (wait(0) != -1) {
    1ada:	4501                	li	a0,0
    1adc:	4ad030ef          	jal	5788 <wait>
    1ae0:	57fd                	li	a5,-1
    1ae2:	fcf518e3          	bne	a0,a5,1ab2 <forktest+0x66>
}
    1ae6:	70a2                	ld	ra,40(sp)
    1ae8:	7402                	ld	s0,32(sp)
    1aea:	64e2                	ld	s1,24(sp)
    1aec:	6942                	ld	s2,16(sp)
    1aee:	69a2                	ld	s3,8(sp)
    1af0:	6145                	addi	sp,sp,48
    1af2:	8082                	ret

0000000000001af4 <kernmem>:
{
    1af4:	715d                	addi	sp,sp,-80
    1af6:	e486                	sd	ra,72(sp)
    1af8:	e0a2                	sd	s0,64(sp)
    1afa:	fc26                	sd	s1,56(sp)
    1afc:	f84a                	sd	s2,48(sp)
    1afe:	f44e                	sd	s3,40(sp)
    1b00:	f052                	sd	s4,32(sp)
    1b02:	ec56                	sd	s5,24(sp)
    1b04:	e85a                	sd	s6,16(sp)
    1b06:	0880                	addi	s0,sp,80
    1b08:	8b2a                	mv	s6,a0
  for (a = (char *)(KERNBASE); a < (char *)(KERNBASE + 2000000); a += 50000) {
    1b0a:	4485                	li	s1,1
    1b0c:	04fe                	slli	s1,s1,0x1f
    wait(&xstatus);
    1b0e:	fbc40a93          	addi	s5,s0,-68
    if (xstatus != -1) // did kernel kill child?
    1b12:	5a7d                	li	s4,-1
  for (a = (char *)(KERNBASE); a < (char *)(KERNBASE + 2000000); a += 50000) {
    1b14:	69b1                	lui	s3,0xc
    1b16:	35098993          	addi	s3,s3,848 # c350 <uninit+0x1d68>
    1b1a:	1003d937          	lui	s2,0x1003d
    1b1e:	090e                	slli	s2,s2,0x3
    1b20:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1001bf88>
    pid = fork();
    1b24:	455030ef          	jal	5778 <fork>
    if (pid < 0) {
    1b28:	02054763          	bltz	a0,1b56 <kernmem+0x62>
    if (pid == 0) {
    1b2c:	cd1d                	beqz	a0,1b6a <kernmem+0x76>
    wait(&xstatus);
    1b2e:	8556                	mv	a0,s5
    1b30:	459030ef          	jal	5788 <wait>
    if (xstatus != -1) // did kernel kill child?
    1b34:	fbc42783          	lw	a5,-68(s0)
    1b38:	05479663          	bne	a5,s4,1b84 <kernmem+0x90>
  for (a = (char *)(KERNBASE); a < (char *)(KERNBASE + 2000000); a += 50000) {
    1b3c:	94ce                	add	s1,s1,s3
    1b3e:	ff2493e3          	bne	s1,s2,1b24 <kernmem+0x30>
}
    1b42:	60a6                	ld	ra,72(sp)
    1b44:	6406                	ld	s0,64(sp)
    1b46:	74e2                	ld	s1,56(sp)
    1b48:	7942                	ld	s2,48(sp)
    1b4a:	79a2                	ld	s3,40(sp)
    1b4c:	7a02                	ld	s4,32(sp)
    1b4e:	6ae2                	ld	s5,24(sp)
    1b50:	6b42                	ld	s6,16(sp)
    1b52:	6161                	addi	sp,sp,80
    1b54:	8082                	ret
      printf("%s: fork failed\n", s);
    1b56:	85da                	mv	a1,s6
    1b58:	00005517          	auipc	a0,0x5
    1b5c:	b2050513          	addi	a0,a0,-1248 # 6678 <malloc+0x9c6>
    1b60:	096040ef          	jal	5bf6 <printf>
      exit(1);
    1b64:	4505                	li	a0,1
    1b66:	41b030ef          	jal	5780 <exit>
      printf("%s: oops could read %p = %x\n", s, a, *a);
    1b6a:	0004c683          	lbu	a3,0(s1)
    1b6e:	8626                	mv	a2,s1
    1b70:	85da                	mv	a1,s6
    1b72:	00005517          	auipc	a0,0x5
    1b76:	d6e50513          	addi	a0,a0,-658 # 68e0 <malloc+0xc2e>
    1b7a:	07c040ef          	jal	5bf6 <printf>
      exit(1);
    1b7e:	4505                	li	a0,1
    1b80:	401030ef          	jal	5780 <exit>
      exit(1);
    1b84:	4505                	li	a0,1
    1b86:	3fb030ef          	jal	5780 <exit>

0000000000001b8a <MAXVAplus>:
{
    1b8a:	7139                	addi	sp,sp,-64
    1b8c:	fc06                	sd	ra,56(sp)
    1b8e:	f822                	sd	s0,48(sp)
    1b90:	0080                	addi	s0,sp,64
  volatile uint64 a = MAXVA;
    1b92:	4785                	li	a5,1
    1b94:	179a                	slli	a5,a5,0x26
    1b96:	fcf43423          	sd	a5,-56(s0)
  for (; a != 0; a <<= 1) {
    1b9a:	fc843783          	ld	a5,-56(s0)
    1b9e:	cf9d                	beqz	a5,1bdc <MAXVAplus+0x52>
    1ba0:	f426                	sd	s1,40(sp)
    1ba2:	f04a                	sd	s2,32(sp)
    1ba4:	ec4e                	sd	s3,24(sp)
    1ba6:	89aa                	mv	s3,a0
    wait(&xstatus);
    1ba8:	fc440913          	addi	s2,s0,-60
    if (xstatus != -1) // did kernel kill child?
    1bac:	54fd                	li	s1,-1
    pid = fork();
    1bae:	3cb030ef          	jal	5778 <fork>
    if (pid < 0) {
    1bb2:	02054963          	bltz	a0,1be4 <MAXVAplus+0x5a>
    if (pid == 0) {
    1bb6:	c129                	beqz	a0,1bf8 <MAXVAplus+0x6e>
    wait(&xstatus);
    1bb8:	854a                	mv	a0,s2
    1bba:	3cf030ef          	jal	5788 <wait>
    if (xstatus != -1) // did kernel kill child?
    1bbe:	fc442783          	lw	a5,-60(s0)
    1bc2:	04979d63          	bne	a5,s1,1c1c <MAXVAplus+0x92>
  for (; a != 0; a <<= 1) {
    1bc6:	fc843783          	ld	a5,-56(s0)
    1bca:	0786                	slli	a5,a5,0x1
    1bcc:	fcf43423          	sd	a5,-56(s0)
    1bd0:	fc843783          	ld	a5,-56(s0)
    1bd4:	ffe9                	bnez	a5,1bae <MAXVAplus+0x24>
    1bd6:	74a2                	ld	s1,40(sp)
    1bd8:	7902                	ld	s2,32(sp)
    1bda:	69e2                	ld	s3,24(sp)
}
    1bdc:	70e2                	ld	ra,56(sp)
    1bde:	7442                	ld	s0,48(sp)
    1be0:	6121                	addi	sp,sp,64
    1be2:	8082                	ret
      printf("%s: fork failed\n", s);
    1be4:	85ce                	mv	a1,s3
    1be6:	00005517          	auipc	a0,0x5
    1bea:	a9250513          	addi	a0,a0,-1390 # 6678 <malloc+0x9c6>
    1bee:	008040ef          	jal	5bf6 <printf>
      exit(1);
    1bf2:	4505                	li	a0,1
    1bf4:	38d030ef          	jal	5780 <exit>
      *(char *)a = 99;
    1bf8:	fc843783          	ld	a5,-56(s0)
    1bfc:	06300713          	li	a4,99
    1c00:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %p\n", s, (void *)a);
    1c04:	fc843603          	ld	a2,-56(s0)
    1c08:	85ce                	mv	a1,s3
    1c0a:	00005517          	auipc	a0,0x5
    1c0e:	cf650513          	addi	a0,a0,-778 # 6900 <malloc+0xc4e>
    1c12:	7e5030ef          	jal	5bf6 <printf>
      exit(1);
    1c16:	4505                	li	a0,1
    1c18:	369030ef          	jal	5780 <exit>
      exit(1);
    1c1c:	4505                	li	a0,1
    1c1e:	363030ef          	jal	5780 <exit>

0000000000001c22 <stacktest>:
{
    1c22:	7179                	addi	sp,sp,-48
    1c24:	f406                	sd	ra,40(sp)
    1c26:	f022                	sd	s0,32(sp)
    1c28:	ec26                	sd	s1,24(sp)
    1c2a:	1800                	addi	s0,sp,48
    1c2c:	84aa                	mv	s1,a0
  pid = fork();
    1c2e:	34b030ef          	jal	5778 <fork>
  if (pid == 0) {
    1c32:	cd11                	beqz	a0,1c4e <stacktest+0x2c>
  } else if (pid < 0) {
    1c34:	02054c63          	bltz	a0,1c6c <stacktest+0x4a>
  wait(&xstatus);
    1c38:	fdc40513          	addi	a0,s0,-36
    1c3c:	34d030ef          	jal	5788 <wait>
  if (xstatus == -1) // kernel killed child?
    1c40:	fdc42503          	lw	a0,-36(s0)
    1c44:	57fd                	li	a5,-1
    1c46:	02f50d63          	beq	a0,a5,1c80 <stacktest+0x5e>
    exit(xstatus);
    1c4a:	337030ef          	jal	5780 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r"(x));
    1c4e:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %d\n", s, *sp);
    1c50:	77fd                	lui	a5,0xfffff
    1c52:	97ba                	add	a5,a5,a4
    1c54:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xfffffffffffddb08>
    1c58:	85a6                	mv	a1,s1
    1c5a:	00005517          	auipc	a0,0x5
    1c5e:	cbe50513          	addi	a0,a0,-834 # 6918 <malloc+0xc66>
    1c62:	795030ef          	jal	5bf6 <printf>
    exit(1);
    1c66:	4505                	li	a0,1
    1c68:	319030ef          	jal	5780 <exit>
    printf("%s: fork failed\n", s);
    1c6c:	85a6                	mv	a1,s1
    1c6e:	00005517          	auipc	a0,0x5
    1c72:	a0a50513          	addi	a0,a0,-1526 # 6678 <malloc+0x9c6>
    1c76:	781030ef          	jal	5bf6 <printf>
    exit(1);
    1c7a:	4505                	li	a0,1
    1c7c:	305030ef          	jal	5780 <exit>
    exit(0);
    1c80:	4501                	li	a0,0
    1c82:	2ff030ef          	jal	5780 <exit>

0000000000001c86 <nowrite>:
{
    1c86:	7159                	addi	sp,sp,-112
    1c88:	f486                	sd	ra,104(sp)
    1c8a:	f0a2                	sd	s0,96(sp)
    1c8c:	eca6                	sd	s1,88(sp)
    1c8e:	e8ca                	sd	s2,80(sp)
    1c90:	e4ce                	sd	s3,72(sp)
    1c92:	e0d2                	sd	s4,64(sp)
    1c94:	1880                	addi	s0,sp,112
    1c96:	8a2a                	mv	s4,a0
  uint64 addrs[] = {0,
    1c98:	00007797          	auipc	a5,0x7
    1c9c:	a4878793          	addi	a5,a5,-1464 # 86e0 <malloc+0x2a2e>
    1ca0:	7788                	ld	a0,40(a5)
    1ca2:	7b8c                	ld	a1,48(a5)
    1ca4:	7f90                	ld	a2,56(a5)
    1ca6:	63b4                	ld	a3,64(a5)
    1ca8:	67b8                	ld	a4,72(a5)
    1caa:	f8a43c23          	sd	a0,-104(s0)
    1cae:	fab43023          	sd	a1,-96(s0)
    1cb2:	fac43423          	sd	a2,-88(s0)
    1cb6:	fad43823          	sd	a3,-80(s0)
    1cba:	fae43c23          	sd	a4,-72(s0)
    1cbe:	6bbc                	ld	a5,80(a5)
    1cc0:	fcf43023          	sd	a5,-64(s0)
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
    1cc4:	4481                	li	s1,0
    wait(&xstatus);
    1cc6:	fcc40913          	addi	s2,s0,-52
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
    1cca:	4999                	li	s3,6
    pid = fork();
    1ccc:	2ad030ef          	jal	5778 <fork>
    if (pid == 0) {
    1cd0:	cd19                	beqz	a0,1cee <nowrite+0x68>
    } else if (pid < 0) {
    1cd2:	04054063          	bltz	a0,1d12 <nowrite+0x8c>
    wait(&xstatus);
    1cd6:	854a                	mv	a0,s2
    1cd8:	2b1030ef          	jal	5788 <wait>
    if (xstatus == 0) {
    1cdc:	fcc42783          	lw	a5,-52(s0)
    1ce0:	c3b9                	beqz	a5,1d26 <nowrite+0xa0>
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
    1ce2:	2485                	addiw	s1,s1,1
    1ce4:	ff3494e3          	bne	s1,s3,1ccc <nowrite+0x46>
  exit(0);
    1ce8:	4501                	li	a0,0
    1cea:	297030ef          	jal	5780 <exit>
      volatile int *addr = (int *)addrs[ai];
    1cee:	048e                	slli	s1,s1,0x3
    1cf0:	fd040793          	addi	a5,s0,-48
    1cf4:	94be                	add	s1,s1,a5
    1cf6:	fc84b603          	ld	a2,-56(s1)
      *addr = 10;
    1cfa:	47a9                	li	a5,10
    1cfc:	c21c                	sw	a5,0(a2)
      printf("%s: write to %p did not fail!\n", s, addr);
    1cfe:	85d2                	mv	a1,s4
    1d00:	00005517          	auipc	a0,0x5
    1d04:	c4050513          	addi	a0,a0,-960 # 6940 <malloc+0xc8e>
    1d08:	6ef030ef          	jal	5bf6 <printf>
      exit(0);
    1d0c:	4501                	li	a0,0
    1d0e:	273030ef          	jal	5780 <exit>
      printf("%s: fork failed\n", s);
    1d12:	85d2                	mv	a1,s4
    1d14:	00005517          	auipc	a0,0x5
    1d18:	96450513          	addi	a0,a0,-1692 # 6678 <malloc+0x9c6>
    1d1c:	6db030ef          	jal	5bf6 <printf>
      exit(1);
    1d20:	4505                	li	a0,1
    1d22:	25f030ef          	jal	5780 <exit>
      exit(1);
    1d26:	4505                	li	a0,1
    1d28:	259030ef          	jal	5780 <exit>

0000000000001d2c <manywrites>:
{
    1d2c:	7159                	addi	sp,sp,-112
    1d2e:	f486                	sd	ra,104(sp)
    1d30:	f0a2                	sd	s0,96(sp)
    1d32:	eca6                	sd	s1,88(sp)
    1d34:	e8ca                	sd	s2,80(sp)
    1d36:	e4ce                	sd	s3,72(sp)
    1d38:	ec66                	sd	s9,24(sp)
    1d3a:	1880                	addi	s0,sp,112
    1d3c:	8caa                	mv	s9,a0
  for (int ci = 0; ci < nchildren; ci++) {
    1d3e:	4901                	li	s2,0
    1d40:	4991                	li	s3,4
    int pid = fork();
    1d42:	237030ef          	jal	5778 <fork>
    1d46:	84aa                	mv	s1,a0
    if (pid < 0) {
    1d48:	02054c63          	bltz	a0,1d80 <manywrites+0x54>
    if (pid == 0) {
    1d4c:	c929                	beqz	a0,1d9e <manywrites+0x72>
  for (int ci = 0; ci < nchildren; ci++) {
    1d4e:	2905                	addiw	s2,s2,1
    1d50:	ff3919e3          	bne	s2,s3,1d42 <manywrites+0x16>
    1d54:	4491                	li	s1,4
    wait(&st);
    1d56:	f9840913          	addi	s2,s0,-104
    int st = 0;
    1d5a:	f8042c23          	sw	zero,-104(s0)
    wait(&st);
    1d5e:	854a                	mv	a0,s2
    1d60:	229030ef          	jal	5788 <wait>
    if (st != 0)
    1d64:	f9842503          	lw	a0,-104(s0)
    1d68:	0e051b63          	bnez	a0,1e5e <manywrites+0x132>
  for (int ci = 0; ci < nchildren; ci++) {
    1d6c:	34fd                	addiw	s1,s1,-1
    1d6e:	f4f5                	bnez	s1,1d5a <manywrites+0x2e>
    1d70:	e0d2                	sd	s4,64(sp)
    1d72:	fc56                	sd	s5,56(sp)
    1d74:	f85a                	sd	s6,48(sp)
    1d76:	f45e                	sd	s7,40(sp)
    1d78:	f062                	sd	s8,32(sp)
    1d7a:	e86a                	sd	s10,16(sp)
  exit(0);
    1d7c:	205030ef          	jal	5780 <exit>
    1d80:	e0d2                	sd	s4,64(sp)
    1d82:	fc56                	sd	s5,56(sp)
    1d84:	f85a                	sd	s6,48(sp)
    1d86:	f45e                	sd	s7,40(sp)
    1d88:	f062                	sd	s8,32(sp)
    1d8a:	e86a                	sd	s10,16(sp)
      printf("fork failed\n");
    1d8c:	00006517          	auipc	a0,0x6
    1d90:	fdc50513          	addi	a0,a0,-36 # 7d68 <malloc+0x20b6>
    1d94:	663030ef          	jal	5bf6 <printf>
      exit(1);
    1d98:	4505                	li	a0,1
    1d9a:	1e7030ef          	jal	5780 <exit>
    1d9e:	e0d2                	sd	s4,64(sp)
    1da0:	fc56                	sd	s5,56(sp)
    1da2:	f85a                	sd	s6,48(sp)
    1da4:	f45e                	sd	s7,40(sp)
    1da6:	f062                	sd	s8,32(sp)
    1da8:	e86a                	sd	s10,16(sp)
      name[0] = 'b';
    1daa:	06200793          	li	a5,98
    1dae:	f8f40c23          	sb	a5,-104(s0)
      name[1] = 'a' + ci;
    1db2:	0619079b          	addiw	a5,s2,97
    1db6:	f8f40ca3          	sb	a5,-103(s0)
      name[2] = '\0';
    1dba:	f8040d23          	sb	zero,-102(s0)
      unlink(name);
    1dbe:	f9840513          	addi	a0,s0,-104
    1dc2:	20f030ef          	jal	57d0 <unlink>
    1dc6:	47f9                	li	a5,30
    1dc8:	8d3e                	mv	s10,a5
          int fd = open(name, O_CREATE | O_RDWR);
    1dca:	f9840b93          	addi	s7,s0,-104
    1dce:	20200b13          	li	s6,514
          int cc = write(fd, buf, sz);
    1dd2:	6ad5                	lui	s5,0x15
    1dd4:	800a8a93          	addi	s5,s5,-2048 # 14800 <buf+0x7b08>
    1dd8:	0000bc17          	auipc	s8,0xb
    1ddc:	f20c0c13          	addi	s8,s8,-224 # ccf8 <buf>
        for (int i = 0; i < ci + 1; i++) {
    1de0:	8a26                	mv	s4,s1
    1de2:	02094563          	bltz	s2,1e0c <manywrites+0xe0>
          int fd = open(name, O_CREATE | O_RDWR);
    1de6:	85da                	mv	a1,s6
    1de8:	855e                	mv	a0,s7
    1dea:	1d7030ef          	jal	57c0 <open>
    1dee:	89aa                	mv	s3,a0
          if (fd < 0) {
    1df0:	02054d63          	bltz	a0,1e2a <manywrites+0xfe>
          int cc = write(fd, buf, sz);
    1df4:	8656                	mv	a2,s5
    1df6:	85e2                	mv	a1,s8
    1df8:	1a9030ef          	jal	57a0 <write>
          if (cc != sz) {
    1dfc:	05551363          	bne	a0,s5,1e42 <manywrites+0x116>
          close(fd);
    1e00:	854e                	mv	a0,s3
    1e02:	1a7030ef          	jal	57a8 <close>
        for (int i = 0; i < ci + 1; i++) {
    1e06:	2a05                	addiw	s4,s4,1
    1e08:	fd495fe3          	bge	s2,s4,1de6 <manywrites+0xba>
        unlink(name);
    1e0c:	f9840513          	addi	a0,s0,-104
    1e10:	1c1030ef          	jal	57d0 <unlink>
      for (int iters = 0; iters < howmany; iters++) {
    1e14:	fffd079b          	addiw	a5,s10,-1
    1e18:	8d3e                	mv	s10,a5
    1e1a:	f3f9                	bnez	a5,1de0 <manywrites+0xb4>
      unlink(name);
    1e1c:	f9840513          	addi	a0,s0,-104
    1e20:	1b1030ef          	jal	57d0 <unlink>
      exit(0);
    1e24:	4501                	li	a0,0
    1e26:	15b030ef          	jal	5780 <exit>
            printf("%s: cannot create %s\n", s, name);
    1e2a:	f9840613          	addi	a2,s0,-104
    1e2e:	85e6                	mv	a1,s9
    1e30:	00005517          	auipc	a0,0x5
    1e34:	b3050513          	addi	a0,a0,-1232 # 6960 <malloc+0xcae>
    1e38:	5bf030ef          	jal	5bf6 <printf>
            exit(1);
    1e3c:	4505                	li	a0,1
    1e3e:	143030ef          	jal	5780 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    1e42:	86aa                	mv	a3,a0
    1e44:	6655                	lui	a2,0x15
    1e46:	80060613          	addi	a2,a2,-2048 # 14800 <buf+0x7b08>
    1e4a:	85e6                	mv	a1,s9
    1e4c:	00004517          	auipc	a0,0x4
    1e50:	06c50513          	addi	a0,a0,108 # 5eb8 <malloc+0x206>
    1e54:	5a3030ef          	jal	5bf6 <printf>
            exit(1);
    1e58:	4505                	li	a0,1
    1e5a:	127030ef          	jal	5780 <exit>
    1e5e:	e0d2                	sd	s4,64(sp)
    1e60:	fc56                	sd	s5,56(sp)
    1e62:	f85a                	sd	s6,48(sp)
    1e64:	f45e                	sd	s7,40(sp)
    1e66:	f062                	sd	s8,32(sp)
    1e68:	e86a                	sd	s10,16(sp)
      exit(st);
    1e6a:	117030ef          	jal	5780 <exit>

0000000000001e6e <copyinstr3>:
{
    1e6e:	7179                	addi	sp,sp,-48
    1e70:	f406                	sd	ra,40(sp)
    1e72:	f022                	sd	s0,32(sp)
    1e74:	ec26                	sd	s1,24(sp)
    1e76:	1800                	addi	s0,sp,48
  sbrk(8192);
    1e78:	6509                	lui	a0,0x2
    1e7a:	0d3030ef          	jal	574c <sbrk>
  uint64 top = (uint64)sbrk(0);
    1e7e:	4501                	li	a0,0
    1e80:	0cd030ef          	jal	574c <sbrk>
  if ((top % PGSIZE) != 0) {
    1e84:	03451793          	slli	a5,a0,0x34
    1e88:	e7bd                	bnez	a5,1ef6 <copyinstr3+0x88>
  top = (uint64)sbrk(0);
    1e8a:	4501                	li	a0,0
    1e8c:	0c1030ef          	jal	574c <sbrk>
  if (top % PGSIZE) {
    1e90:	03451793          	slli	a5,a0,0x34
    1e94:	ebad                	bnez	a5,1f06 <copyinstr3+0x98>
  char *b = (char *)(top - 1);
    1e96:	fff50493          	addi	s1,a0,-1 # 1fff <rwsbrk+0x8d>
  *b = 'x';
    1e9a:	07800793          	li	a5,120
    1e9e:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    1ea2:	8526                	mv	a0,s1
    1ea4:	12d030ef          	jal	57d0 <unlink>
  if (ret != -1) {
    1ea8:	57fd                	li	a5,-1
    1eaa:	06f51763          	bne	a0,a5,1f18 <copyinstr3+0xaa>
  int fd = open(b, O_CREATE | O_WRONLY);
    1eae:	20100593          	li	a1,513
    1eb2:	8526                	mv	a0,s1
    1eb4:	10d030ef          	jal	57c0 <open>
  if (fd != -1) {
    1eb8:	57fd                	li	a5,-1
    1eba:	06f51a63          	bne	a0,a5,1f2e <copyinstr3+0xc0>
  ret = link(b, b);
    1ebe:	85a6                	mv	a1,s1
    1ec0:	8526                	mv	a0,s1
    1ec2:	11f030ef          	jal	57e0 <link>
  if (ret != -1) {
    1ec6:	57fd                	li	a5,-1
    1ec8:	06f51e63          	bne	a0,a5,1f44 <copyinstr3+0xd6>
  char *args[] = {"xx", 0};
    1ecc:	00005797          	auipc	a5,0x5
    1ed0:	79478793          	addi	a5,a5,1940 # 7660 <malloc+0x19ae>
    1ed4:	fcf43823          	sd	a5,-48(s0)
    1ed8:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    1edc:	fd040593          	addi	a1,s0,-48
    1ee0:	8526                	mv	a0,s1
    1ee2:	0d7030ef          	jal	57b8 <exec>
  if (ret != -1) {
    1ee6:	57fd                	li	a5,-1
    1ee8:	06f51a63          	bne	a0,a5,1f5c <copyinstr3+0xee>
}
    1eec:	70a2                	ld	ra,40(sp)
    1eee:	7402                	ld	s0,32(sp)
    1ef0:	64e2                	ld	s1,24(sp)
    1ef2:	6145                	addi	sp,sp,48
    1ef4:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    1ef6:	0347d513          	srli	a0,a5,0x34
    1efa:	6785                	lui	a5,0x1
    1efc:	40a7853b          	subw	a0,a5,a0
    1f00:	04d030ef          	jal	574c <sbrk>
    1f04:	b759                	j	1e8a <copyinstr3+0x1c>
    printf("oops\n");
    1f06:	00005517          	auipc	a0,0x5
    1f0a:	a7250513          	addi	a0,a0,-1422 # 6978 <malloc+0xcc6>
    1f0e:	4e9030ef          	jal	5bf6 <printf>
    exit(1);
    1f12:	4505                	li	a0,1
    1f14:	06d030ef          	jal	5780 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    1f18:	862a                	mv	a2,a0
    1f1a:	85a6                	mv	a1,s1
    1f1c:	00004517          	auipc	a0,0x4
    1f20:	67c50513          	addi	a0,a0,1660 # 6598 <malloc+0x8e6>
    1f24:	4d3030ef          	jal	5bf6 <printf>
    exit(1);
    1f28:	4505                	li	a0,1
    1f2a:	057030ef          	jal	5780 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    1f2e:	862a                	mv	a2,a0
    1f30:	85a6                	mv	a1,s1
    1f32:	00004517          	auipc	a0,0x4
    1f36:	68650513          	addi	a0,a0,1670 # 65b8 <malloc+0x906>
    1f3a:	4bd030ef          	jal	5bf6 <printf>
    exit(1);
    1f3e:	4505                	li	a0,1
    1f40:	041030ef          	jal	5780 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    1f44:	86aa                	mv	a3,a0
    1f46:	8626                	mv	a2,s1
    1f48:	85a6                	mv	a1,s1
    1f4a:	00004517          	auipc	a0,0x4
    1f4e:	68e50513          	addi	a0,a0,1678 # 65d8 <malloc+0x926>
    1f52:	4a5030ef          	jal	5bf6 <printf>
    exit(1);
    1f56:	4505                	li	a0,1
    1f58:	029030ef          	jal	5780 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1f5c:	863e                	mv	a2,a5
    1f5e:	85a6                	mv	a1,s1
    1f60:	00004517          	auipc	a0,0x4
    1f64:	6a050513          	addi	a0,a0,1696 # 6600 <malloc+0x94e>
    1f68:	48f030ef          	jal	5bf6 <printf>
    exit(1);
    1f6c:	4505                	li	a0,1
    1f6e:	013030ef          	jal	5780 <exit>

0000000000001f72 <rwsbrk>:
{
    1f72:	1101                	addi	sp,sp,-32
    1f74:	ec06                	sd	ra,24(sp)
    1f76:	e822                	sd	s0,16(sp)
    1f78:	1000                	addi	s0,sp,32
  uint64 a = (uint64)sbrk(8192);
    1f7a:	6509                	lui	a0,0x2
    1f7c:	7d0030ef          	jal	574c <sbrk>
  if (a == (uint64)SBRK_ERROR) {
    1f80:	57fd                	li	a5,-1
    1f82:	04f50a63          	beq	a0,a5,1fd6 <rwsbrk+0x64>
    1f86:	e426                	sd	s1,8(sp)
    1f88:	84aa                	mv	s1,a0
  if (sbrk(-8192) == SBRK_ERROR) {
    1f8a:	7579                	lui	a0,0xffffe
    1f8c:	7c0030ef          	jal	574c <sbrk>
    1f90:	57fd                	li	a5,-1
    1f92:	04f50d63          	beq	a0,a5,1fec <rwsbrk+0x7a>
    1f96:	e04a                	sd	s2,0(sp)
  fd = open("rwsbrk", O_CREATE | O_WRONLY);
    1f98:	20100593          	li	a1,513
    1f9c:	00005517          	auipc	a0,0x5
    1fa0:	a1c50513          	addi	a0,a0,-1508 # 69b8 <malloc+0xd06>
    1fa4:	01d030ef          	jal	57c0 <open>
    1fa8:	892a                	mv	s2,a0
  if (fd < 0) {
    1faa:	04054b63          	bltz	a0,2000 <rwsbrk+0x8e>
  n = write(fd, (void *)(a + PGSIZE), 1024);
    1fae:	6785                	lui	a5,0x1
    1fb0:	94be                	add	s1,s1,a5
    1fb2:	40000613          	li	a2,1024
    1fb6:	85a6                	mv	a1,s1
    1fb8:	7e8030ef          	jal	57a0 <write>
    1fbc:	862a                	mv	a2,a0
  if (n >= 0) {
    1fbe:	04054a63          	bltz	a0,2012 <rwsbrk+0xa0>
    printf("write(fd, %p, 1024) returned %d, not -1\n", (void *)a + PGSIZE, n);
    1fc2:	85a6                	mv	a1,s1
    1fc4:	00005517          	auipc	a0,0x5
    1fc8:	a1450513          	addi	a0,a0,-1516 # 69d8 <malloc+0xd26>
    1fcc:	42b030ef          	jal	5bf6 <printf>
    exit(1);
    1fd0:	4505                	li	a0,1
    1fd2:	7ae030ef          	jal	5780 <exit>
    1fd6:	e426                	sd	s1,8(sp)
    1fd8:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) failed\n");
    1fda:	00005517          	auipc	a0,0x5
    1fde:	9a650513          	addi	a0,a0,-1626 # 6980 <malloc+0xcce>
    1fe2:	415030ef          	jal	5bf6 <printf>
    exit(1);
    1fe6:	4505                	li	a0,1
    1fe8:	798030ef          	jal	5780 <exit>
    1fec:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) shrink failed\n");
    1fee:	00005517          	auipc	a0,0x5
    1ff2:	9aa50513          	addi	a0,a0,-1622 # 6998 <malloc+0xce6>
    1ff6:	401030ef          	jal	5bf6 <printf>
    exit(1);
    1ffa:	4505                	li	a0,1
    1ffc:	784030ef          	jal	5780 <exit>
    printf("open(rwsbrk) failed\n");
    2000:	00005517          	auipc	a0,0x5
    2004:	9c050513          	addi	a0,a0,-1600 # 69c0 <malloc+0xd0e>
    2008:	3ef030ef          	jal	5bf6 <printf>
    exit(1);
    200c:	4505                	li	a0,1
    200e:	772030ef          	jal	5780 <exit>
  close(fd);
    2012:	854a                	mv	a0,s2
    2014:	794030ef          	jal	57a8 <close>
  unlink("rwsbrk");
    2018:	00005517          	auipc	a0,0x5
    201c:	9a050513          	addi	a0,a0,-1632 # 69b8 <malloc+0xd06>
    2020:	7b0030ef          	jal	57d0 <unlink>
  fd = open("README", O_RDONLY);
    2024:	4581                	li	a1,0
    2026:	00004517          	auipc	a0,0x4
    202a:	f9a50513          	addi	a0,a0,-102 # 5fc0 <malloc+0x30e>
    202e:	792030ef          	jal	57c0 <open>
    2032:	892a                	mv	s2,a0
  if (fd < 0) {
    2034:	02054363          	bltz	a0,205a <rwsbrk+0xe8>
  n = read(fd, (void *)(a + PGSIZE), 10);
    2038:	4629                	li	a2,10
    203a:	85a6                	mv	a1,s1
    203c:	75c030ef          	jal	5798 <read>
    2040:	862a                	mv	a2,a0
  if (n >= 0) {
    2042:	02054563          	bltz	a0,206c <rwsbrk+0xfa>
    printf("read(fd, %p, 10) returned %d, not -1\n", (void *)a + PGSIZE, n);
    2046:	85a6                	mv	a1,s1
    2048:	00005517          	auipc	a0,0x5
    204c:	9c050513          	addi	a0,a0,-1600 # 6a08 <malloc+0xd56>
    2050:	3a7030ef          	jal	5bf6 <printf>
    exit(1);
    2054:	4505                	li	a0,1
    2056:	72a030ef          	jal	5780 <exit>
    printf("open(README) failed\n");
    205a:	00004517          	auipc	a0,0x4
    205e:	f6e50513          	addi	a0,a0,-146 # 5fc8 <malloc+0x316>
    2062:	395030ef          	jal	5bf6 <printf>
    exit(1);
    2066:	4505                	li	a0,1
    2068:	718030ef          	jal	5780 <exit>
  close(fd);
    206c:	854a                	mv	a0,s2
    206e:	73a030ef          	jal	57a8 <close>
  exit(0);
    2072:	4501                	li	a0,0
    2074:	70c030ef          	jal	5780 <exit>

0000000000002078 <sbrkbasic>:
{
    2078:	715d                	addi	sp,sp,-80
    207a:	e486                	sd	ra,72(sp)
    207c:	e0a2                	sd	s0,64(sp)
    207e:	ec56                	sd	s5,24(sp)
    2080:	0880                	addi	s0,sp,80
    2082:	8aaa                	mv	s5,a0
  pid = fork();
    2084:	6f4030ef          	jal	5778 <fork>
  if (pid < 0) {
    2088:	02054c63          	bltz	a0,20c0 <sbrkbasic+0x48>
  if (pid == 0) {
    208c:	ed31                	bnez	a0,20e8 <sbrkbasic+0x70>
    a = sbrk(TOOMUCH);
    208e:	40000537          	lui	a0,0x40000
    2092:	6ba030ef          	jal	574c <sbrk>
    if (a == (char *)SBRK_ERROR) {
    2096:	57fd                	li	a5,-1
    2098:	04f50163          	beq	a0,a5,20da <sbrkbasic+0x62>
    209c:	fc26                	sd	s1,56(sp)
    209e:	f84a                	sd	s2,48(sp)
    20a0:	f44e                	sd	s3,40(sp)
    20a2:	f052                	sd	s4,32(sp)
    for (b = a; b < a + TOOMUCH; b += PGSIZE) {
    20a4:	400007b7          	lui	a5,0x40000
    20a8:	97aa                	add	a5,a5,a0
      *b = 99;
    20aa:	06300693          	li	a3,99
    for (b = a; b < a + TOOMUCH; b += PGSIZE) {
    20ae:	6705                	lui	a4,0x1
      *b = 99;
    20b0:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3ffdeb08>
    for (b = a; b < a + TOOMUCH; b += PGSIZE) {
    20b4:	953a                	add	a0,a0,a4
    20b6:	fef51de3          	bne	a0,a5,20b0 <sbrkbasic+0x38>
    exit(1);
    20ba:	4505                	li	a0,1
    20bc:	6c4030ef          	jal	5780 <exit>
    20c0:	fc26                	sd	s1,56(sp)
    20c2:	f84a                	sd	s2,48(sp)
    20c4:	f44e                	sd	s3,40(sp)
    20c6:	f052                	sd	s4,32(sp)
    printf("fork failed in sbrkbasic\n");
    20c8:	00005517          	auipc	a0,0x5
    20cc:	96850513          	addi	a0,a0,-1688 # 6a30 <malloc+0xd7e>
    20d0:	327030ef          	jal	5bf6 <printf>
    exit(1);
    20d4:	4505                	li	a0,1
    20d6:	6aa030ef          	jal	5780 <exit>
    20da:	fc26                	sd	s1,56(sp)
    20dc:	f84a                	sd	s2,48(sp)
    20de:	f44e                	sd	s3,40(sp)
    20e0:	f052                	sd	s4,32(sp)
      exit(0);
    20e2:	4501                	li	a0,0
    20e4:	69c030ef          	jal	5780 <exit>
  wait(&xstatus);
    20e8:	fbc40513          	addi	a0,s0,-68
    20ec:	69c030ef          	jal	5788 <wait>
  if (xstatus == 1) {
    20f0:	fbc42703          	lw	a4,-68(s0)
    20f4:	4785                	li	a5,1
    20f6:	02f70063          	beq	a4,a5,2116 <sbrkbasic+0x9e>
    20fa:	fc26                	sd	s1,56(sp)
    20fc:	f84a                	sd	s2,48(sp)
    20fe:	f44e                	sd	s3,40(sp)
    2100:	f052                	sd	s4,32(sp)
  a = sbrk(0);
    2102:	4501                	li	a0,0
    2104:	648030ef          	jal	574c <sbrk>
    2108:	84aa                	mv	s1,a0
  for (i = 0; i < 5000; i++) {
    210a:	4901                	li	s2,0
    b = sbrk(1);
    210c:	4985                	li	s3,1
  for (i = 0; i < 5000; i++) {
    210e:	6a05                	lui	s4,0x1
    2110:	388a0a13          	addi	s4,s4,904 # 1388 <truncate3+0x13e>
    2114:	a005                	j	2134 <sbrkbasic+0xbc>
    2116:	fc26                	sd	s1,56(sp)
    2118:	f84a                	sd	s2,48(sp)
    211a:	f44e                	sd	s3,40(sp)
    211c:	f052                	sd	s4,32(sp)
    printf("%s: too much memory allocated!\n", s);
    211e:	85d6                	mv	a1,s5
    2120:	00005517          	auipc	a0,0x5
    2124:	93050513          	addi	a0,a0,-1744 # 6a50 <malloc+0xd9e>
    2128:	2cf030ef          	jal	5bf6 <printf>
    exit(1);
    212c:	4505                	li	a0,1
    212e:	652030ef          	jal	5780 <exit>
  for (i = 0; i < 5000; i++) {
    2132:	84be                	mv	s1,a5
    b = sbrk(1);
    2134:	854e                	mv	a0,s3
    2136:	616030ef          	jal	574c <sbrk>
    if (b != a) {
    213a:	04951163          	bne	a0,s1,217c <sbrkbasic+0x104>
    *b = 1;
    213e:	01348023          	sb	s3,0(s1)
    a = b + 1;
    2142:	00148793          	addi	a5,s1,1
  for (i = 0; i < 5000; i++) {
    2146:	2905                	addiw	s2,s2,1
    2148:	ff4915e3          	bne	s2,s4,2132 <sbrkbasic+0xba>
  pid = fork();
    214c:	62c030ef          	jal	5778 <fork>
    2150:	892a                	mv	s2,a0
  if (pid < 0) {
    2152:	04054263          	bltz	a0,2196 <sbrkbasic+0x11e>
  c = sbrk(1);
    2156:	4505                	li	a0,1
    2158:	5f4030ef          	jal	574c <sbrk>
  c = sbrk(1);
    215c:	4505                	li	a0,1
    215e:	5ee030ef          	jal	574c <sbrk>
  if (c != a + 1) {
    2162:	0489                	addi	s1,s1,2
    2164:	04950363          	beq	a0,s1,21aa <sbrkbasic+0x132>
    printf("%s: sbrk test failed post-fork\n", s);
    2168:	85d6                	mv	a1,s5
    216a:	00005517          	auipc	a0,0x5
    216e:	94650513          	addi	a0,a0,-1722 # 6ab0 <malloc+0xdfe>
    2172:	285030ef          	jal	5bf6 <printf>
    exit(1);
    2176:	4505                	li	a0,1
    2178:	608030ef          	jal	5780 <exit>
      printf("%s: sbrk test failed %d %p %p\n", s, i, a, b);
    217c:	872a                	mv	a4,a0
    217e:	86a6                	mv	a3,s1
    2180:	864a                	mv	a2,s2
    2182:	85d6                	mv	a1,s5
    2184:	00005517          	auipc	a0,0x5
    2188:	8ec50513          	addi	a0,a0,-1812 # 6a70 <malloc+0xdbe>
    218c:	26b030ef          	jal	5bf6 <printf>
      exit(1);
    2190:	4505                	li	a0,1
    2192:	5ee030ef          	jal	5780 <exit>
    printf("%s: sbrk test fork failed\n", s);
    2196:	85d6                	mv	a1,s5
    2198:	00005517          	auipc	a0,0x5
    219c:	8f850513          	addi	a0,a0,-1800 # 6a90 <malloc+0xdde>
    21a0:	257030ef          	jal	5bf6 <printf>
    exit(1);
    21a4:	4505                	li	a0,1
    21a6:	5da030ef          	jal	5780 <exit>
  if (pid == 0)
    21aa:	00091563          	bnez	s2,21b4 <sbrkbasic+0x13c>
    exit(0);
    21ae:	4501                	li	a0,0
    21b0:	5d0030ef          	jal	5780 <exit>
  wait(&xstatus);
    21b4:	fbc40513          	addi	a0,s0,-68
    21b8:	5d0030ef          	jal	5788 <wait>
  exit(xstatus);
    21bc:	fbc42503          	lw	a0,-68(s0)
    21c0:	5c0030ef          	jal	5780 <exit>

00000000000021c4 <sbrkmuch>:
{
    21c4:	7179                	addi	sp,sp,-48
    21c6:	f406                	sd	ra,40(sp)
    21c8:	f022                	sd	s0,32(sp)
    21ca:	ec26                	sd	s1,24(sp)
    21cc:	e84a                	sd	s2,16(sp)
    21ce:	e44e                	sd	s3,8(sp)
    21d0:	e052                	sd	s4,0(sp)
    21d2:	1800                	addi	s0,sp,48
    21d4:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    21d6:	4501                	li	a0,0
    21d8:	574030ef          	jal	574c <sbrk>
    21dc:	892a                	mv	s2,a0
  a = sbrk(0);
    21de:	4501                	li	a0,0
    21e0:	56c030ef          	jal	574c <sbrk>
    21e4:	84aa                	mv	s1,a0
  p = sbrk(amt);
    21e6:	06400537          	lui	a0,0x6400
    21ea:	9d05                	subw	a0,a0,s1
    21ec:	560030ef          	jal	574c <sbrk>
  if (p != a) {
    21f0:	08a49763          	bne	s1,a0,227e <sbrkmuch+0xba>
  *lastaddr = 99;
    21f4:	064007b7          	lui	a5,0x6400
    21f8:	06300713          	li	a4,99
    21fc:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63deb07>
  a = sbrk(0);
    2200:	4501                	li	a0,0
    2202:	54a030ef          	jal	574c <sbrk>
    2206:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2208:	757d                	lui	a0,0xfffff
    220a:	542030ef          	jal	574c <sbrk>
  if (c == (char *)SBRK_ERROR) {
    220e:	57fd                	li	a5,-1
    2210:	08f50163          	beq	a0,a5,2292 <sbrkmuch+0xce>
  c = sbrk(0);
    2214:	4501                	li	a0,0
    2216:	536030ef          	jal	574c <sbrk>
  if (c != a - PGSIZE) {
    221a:	77fd                	lui	a5,0xfffff
    221c:	97a6                	add	a5,a5,s1
    221e:	08f51463          	bne	a0,a5,22a6 <sbrkmuch+0xe2>
  a = sbrk(0);
    2222:	4501                	li	a0,0
    2224:	528030ef          	jal	574c <sbrk>
    2228:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    222a:	6505                	lui	a0,0x1
    222c:	520030ef          	jal	574c <sbrk>
    2230:	8a2a                	mv	s4,a0
  if (c != a || sbrk(0) != a + PGSIZE) {
    2232:	08a49663          	bne	s1,a0,22be <sbrkmuch+0xfa>
    2236:	4501                	li	a0,0
    2238:	514030ef          	jal	574c <sbrk>
    223c:	6785                	lui	a5,0x1
    223e:	97a6                	add	a5,a5,s1
    2240:	06f51f63          	bne	a0,a5,22be <sbrkmuch+0xfa>
  if (*lastaddr == 99) {
    2244:	064007b7          	lui	a5,0x6400
    2248:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63deb07>
    224c:	06300793          	li	a5,99
    2250:	08f70363          	beq	a4,a5,22d6 <sbrkmuch+0x112>
  a = sbrk(0);
    2254:	4501                	li	a0,0
    2256:	4f6030ef          	jal	574c <sbrk>
    225a:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    225c:	4501                	li	a0,0
    225e:	4ee030ef          	jal	574c <sbrk>
    2262:	40a9053b          	subw	a0,s2,a0
    2266:	4e6030ef          	jal	574c <sbrk>
  if (c != a) {
    226a:	08a49063          	bne	s1,a0,22ea <sbrkmuch+0x126>
}
    226e:	70a2                	ld	ra,40(sp)
    2270:	7402                	ld	s0,32(sp)
    2272:	64e2                	ld	s1,24(sp)
    2274:	6942                	ld	s2,16(sp)
    2276:	69a2                	ld	s3,8(sp)
    2278:	6a02                	ld	s4,0(sp)
    227a:	6145                	addi	sp,sp,48
    227c:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n",
    227e:	85ce                	mv	a1,s3
    2280:	00005517          	auipc	a0,0x5
    2284:	85050513          	addi	a0,a0,-1968 # 6ad0 <malloc+0xe1e>
    2288:	16f030ef          	jal	5bf6 <printf>
    exit(1);
    228c:	4505                	li	a0,1
    228e:	4f2030ef          	jal	5780 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    2292:	85ce                	mv	a1,s3
    2294:	00005517          	auipc	a0,0x5
    2298:	88450513          	addi	a0,a0,-1916 # 6b18 <malloc+0xe66>
    229c:	15b030ef          	jal	5bf6 <printf>
    exit(1);
    22a0:	4505                	li	a0,1
    22a2:	4de030ef          	jal	5780 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %p c %p\n", s, a,
    22a6:	86aa                	mv	a3,a0
    22a8:	8626                	mv	a2,s1
    22aa:	85ce                	mv	a1,s3
    22ac:	00005517          	auipc	a0,0x5
    22b0:	88c50513          	addi	a0,a0,-1908 # 6b38 <malloc+0xe86>
    22b4:	143030ef          	jal	5bf6 <printf>
    exit(1);
    22b8:	4505                	li	a0,1
    22ba:	4c6030ef          	jal	5780 <exit>
    printf("%s: sbrk re-allocation failed, a %p c %p\n", s, a, c);
    22be:	86d2                	mv	a3,s4
    22c0:	8626                	mv	a2,s1
    22c2:	85ce                	mv	a1,s3
    22c4:	00005517          	auipc	a0,0x5
    22c8:	8b450513          	addi	a0,a0,-1868 # 6b78 <malloc+0xec6>
    22cc:	12b030ef          	jal	5bf6 <printf>
    exit(1);
    22d0:	4505                	li	a0,1
    22d2:	4ae030ef          	jal	5780 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    22d6:	85ce                	mv	a1,s3
    22d8:	00005517          	auipc	a0,0x5
    22dc:	8d050513          	addi	a0,a0,-1840 # 6ba8 <malloc+0xef6>
    22e0:	117030ef          	jal	5bf6 <printf>
    exit(1);
    22e4:	4505                	li	a0,1
    22e6:	49a030ef          	jal	5780 <exit>
    printf("%s: sbrk downsize failed, a %p c %p\n", s, a, c);
    22ea:	86aa                	mv	a3,a0
    22ec:	8626                	mv	a2,s1
    22ee:	85ce                	mv	a1,s3
    22f0:	00005517          	auipc	a0,0x5
    22f4:	8f050513          	addi	a0,a0,-1808 # 6be0 <malloc+0xf2e>
    22f8:	0ff030ef          	jal	5bf6 <printf>
    exit(1);
    22fc:	4505                	li	a0,1
    22fe:	482030ef          	jal	5780 <exit>

0000000000002302 <sbrkarg>:
{
    2302:	7179                	addi	sp,sp,-48
    2304:	f406                	sd	ra,40(sp)
    2306:	f022                	sd	s0,32(sp)
    2308:	ec26                	sd	s1,24(sp)
    230a:	e84a                	sd	s2,16(sp)
    230c:	e44e                	sd	s3,8(sp)
    230e:	1800                	addi	s0,sp,48
    2310:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2312:	6505                	lui	a0,0x1
    2314:	438030ef          	jal	574c <sbrk>
    2318:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE | O_WRONLY);
    231a:	20100593          	li	a1,513
    231e:	00005517          	auipc	a0,0x5
    2322:	8ea50513          	addi	a0,a0,-1814 # 6c08 <malloc+0xf56>
    2326:	49a030ef          	jal	57c0 <open>
    232a:	84aa                	mv	s1,a0
  unlink("sbrk");
    232c:	00005517          	auipc	a0,0x5
    2330:	8dc50513          	addi	a0,a0,-1828 # 6c08 <malloc+0xf56>
    2334:	49c030ef          	jal	57d0 <unlink>
  if (fd < 0) {
    2338:	0204c963          	bltz	s1,236a <sbrkarg+0x68>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    233c:	6605                	lui	a2,0x1
    233e:	85ca                	mv	a1,s2
    2340:	8526                	mv	a0,s1
    2342:	45e030ef          	jal	57a0 <write>
    2346:	02054c63          	bltz	a0,237e <sbrkarg+0x7c>
  close(fd);
    234a:	8526                	mv	a0,s1
    234c:	45c030ef          	jal	57a8 <close>
  a = sbrk(PGSIZE);
    2350:	6505                	lui	a0,0x1
    2352:	3fa030ef          	jal	574c <sbrk>
  if (pipe((int *)a) != 0) {
    2356:	43a030ef          	jal	5790 <pipe>
    235a:	ed05                	bnez	a0,2392 <sbrkarg+0x90>
}
    235c:	70a2                	ld	ra,40(sp)
    235e:	7402                	ld	s0,32(sp)
    2360:	64e2                	ld	s1,24(sp)
    2362:	6942                	ld	s2,16(sp)
    2364:	69a2                	ld	s3,8(sp)
    2366:	6145                	addi	sp,sp,48
    2368:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    236a:	85ce                	mv	a1,s3
    236c:	00005517          	auipc	a0,0x5
    2370:	8a450513          	addi	a0,a0,-1884 # 6c10 <malloc+0xf5e>
    2374:	083030ef          	jal	5bf6 <printf>
    exit(1);
    2378:	4505                	li	a0,1
    237a:	406030ef          	jal	5780 <exit>
    printf("%s: write sbrk failed\n", s);
    237e:	85ce                	mv	a1,s3
    2380:	00005517          	auipc	a0,0x5
    2384:	8a850513          	addi	a0,a0,-1880 # 6c28 <malloc+0xf76>
    2388:	06f030ef          	jal	5bf6 <printf>
    exit(1);
    238c:	4505                	li	a0,1
    238e:	3f2030ef          	jal	5780 <exit>
    printf("%s: pipe() failed\n", s);
    2392:	85ce                	mv	a1,s3
    2394:	00004517          	auipc	a0,0x4
    2398:	36c50513          	addi	a0,a0,876 # 6700 <malloc+0xa4e>
    239c:	05b030ef          	jal	5bf6 <printf>
    exit(1);
    23a0:	4505                	li	a0,1
    23a2:	3de030ef          	jal	5780 <exit>

00000000000023a6 <argptest>:
{
    23a6:	1101                	addi	sp,sp,-32
    23a8:	ec06                	sd	ra,24(sp)
    23aa:	e822                	sd	s0,16(sp)
    23ac:	e426                	sd	s1,8(sp)
    23ae:	e04a                	sd	s2,0(sp)
    23b0:	1000                	addi	s0,sp,32
    23b2:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    23b4:	4581                	li	a1,0
    23b6:	00005517          	auipc	a0,0x5
    23ba:	88a50513          	addi	a0,a0,-1910 # 6c40 <malloc+0xf8e>
    23be:	402030ef          	jal	57c0 <open>
  if (fd < 0) {
    23c2:	02054563          	bltz	a0,23ec <argptest+0x46>
    23c6:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    23c8:	4501                	li	a0,0
    23ca:	382030ef          	jal	574c <sbrk>
    23ce:	567d                	li	a2,-1
    23d0:	00c505b3          	add	a1,a0,a2
    23d4:	8526                	mv	a0,s1
    23d6:	3c2030ef          	jal	5798 <read>
  close(fd);
    23da:	8526                	mv	a0,s1
    23dc:	3cc030ef          	jal	57a8 <close>
}
    23e0:	60e2                	ld	ra,24(sp)
    23e2:	6442                	ld	s0,16(sp)
    23e4:	64a2                	ld	s1,8(sp)
    23e6:	6902                	ld	s2,0(sp)
    23e8:	6105                	addi	sp,sp,32
    23ea:	8082                	ret
    printf("%s: open failed\n", s);
    23ec:	85ca                	mv	a1,s2
    23ee:	00004517          	auipc	a0,0x4
    23f2:	2a250513          	addi	a0,a0,674 # 6690 <malloc+0x9de>
    23f6:	001030ef          	jal	5bf6 <printf>
    exit(1);
    23fa:	4505                	li	a0,1
    23fc:	384030ef          	jal	5780 <exit>

0000000000002400 <sbrkbugs>:
{
    2400:	1141                	addi	sp,sp,-16
    2402:	e406                	sd	ra,8(sp)
    2404:	e022                	sd	s0,0(sp)
    2406:	0800                	addi	s0,sp,16
  int pid = fork();
    2408:	370030ef          	jal	5778 <fork>
  if (pid < 0) {
    240c:	00054c63          	bltz	a0,2424 <sbrkbugs+0x24>
  if (pid == 0) {
    2410:	e11d                	bnez	a0,2436 <sbrkbugs+0x36>
    int sz = (uint64)sbrk(0);
    2412:	33a030ef          	jal	574c <sbrk>
    sbrk(-sz);
    2416:	40a0053b          	negw	a0,a0
    241a:	332030ef          	jal	574c <sbrk>
    exit(0);
    241e:	4501                	li	a0,0
    2420:	360030ef          	jal	5780 <exit>
    printf("fork failed\n");
    2424:	00006517          	auipc	a0,0x6
    2428:	94450513          	addi	a0,a0,-1724 # 7d68 <malloc+0x20b6>
    242c:	7ca030ef          	jal	5bf6 <printf>
    exit(1);
    2430:	4505                	li	a0,1
    2432:	34e030ef          	jal	5780 <exit>
  wait(0);
    2436:	4501                	li	a0,0
    2438:	350030ef          	jal	5788 <wait>
  pid = fork();
    243c:	33c030ef          	jal	5778 <fork>
  if (pid < 0) {
    2440:	00054f63          	bltz	a0,245e <sbrkbugs+0x5e>
  if (pid == 0) {
    2444:	e515                	bnez	a0,2470 <sbrkbugs+0x70>
    int sz = (uint64)sbrk(0);
    2446:	306030ef          	jal	574c <sbrk>
    sbrk(-(sz - 3500));
    244a:	6785                	lui	a5,0x1
    244c:	dac7879b          	addiw	a5,a5,-596 # dac <linktest+0xda>
    2450:	40a7853b          	subw	a0,a5,a0
    2454:	2f8030ef          	jal	574c <sbrk>
    exit(0);
    2458:	4501                	li	a0,0
    245a:	326030ef          	jal	5780 <exit>
    printf("fork failed\n");
    245e:	00006517          	auipc	a0,0x6
    2462:	90a50513          	addi	a0,a0,-1782 # 7d68 <malloc+0x20b6>
    2466:	790030ef          	jal	5bf6 <printf>
    exit(1);
    246a:	4505                	li	a0,1
    246c:	314030ef          	jal	5780 <exit>
  wait(0);
    2470:	4501                	li	a0,0
    2472:	316030ef          	jal	5788 <wait>
  pid = fork();
    2476:	302030ef          	jal	5778 <fork>
  if (pid < 0) {
    247a:	02054263          	bltz	a0,249e <sbrkbugs+0x9e>
  if (pid == 0) {
    247e:	e90d                	bnez	a0,24b0 <sbrkbugs+0xb0>
    sbrk((10 * PGSIZE + 2048) - (uint64)sbrk(0));
    2480:	2cc030ef          	jal	574c <sbrk>
    2484:	67ad                	lui	a5,0xb
    2486:	8007879b          	addiw	a5,a5,-2048 # a800 <uninit+0x218>
    248a:	40a7853b          	subw	a0,a5,a0
    248e:	2be030ef          	jal	574c <sbrk>
    sbrk(-10);
    2492:	5559                	li	a0,-10
    2494:	2b8030ef          	jal	574c <sbrk>
    exit(0);
    2498:	4501                	li	a0,0
    249a:	2e6030ef          	jal	5780 <exit>
    printf("fork failed\n");
    249e:	00006517          	auipc	a0,0x6
    24a2:	8ca50513          	addi	a0,a0,-1846 # 7d68 <malloc+0x20b6>
    24a6:	750030ef          	jal	5bf6 <printf>
    exit(1);
    24aa:	4505                	li	a0,1
    24ac:	2d4030ef          	jal	5780 <exit>
  wait(0);
    24b0:	4501                	li	a0,0
    24b2:	2d6030ef          	jal	5788 <wait>
  exit(0);
    24b6:	4501                	li	a0,0
    24b8:	2c8030ef          	jal	5780 <exit>

00000000000024bc <sbrklast>:
{
    24bc:	7179                	addi	sp,sp,-48
    24be:	f406                	sd	ra,40(sp)
    24c0:	f022                	sd	s0,32(sp)
    24c2:	ec26                	sd	s1,24(sp)
    24c4:	e84a                	sd	s2,16(sp)
    24c6:	e44e                	sd	s3,8(sp)
    24c8:	e052                	sd	s4,0(sp)
    24ca:	1800                	addi	s0,sp,48
  uint64 top = (uint64)sbrk(0);
    24cc:	4501                	li	a0,0
    24ce:	27e030ef          	jal	574c <sbrk>
  if ((top % PGSIZE) != 0)
    24d2:	03451793          	slli	a5,a0,0x34
    24d6:	ebad                	bnez	a5,2548 <sbrklast+0x8c>
  sbrk(PGSIZE);
    24d8:	6505                	lui	a0,0x1
    24da:	272030ef          	jal	574c <sbrk>
  sbrk(10);
    24de:	4529                	li	a0,10
    24e0:	26c030ef          	jal	574c <sbrk>
  sbrk(-20);
    24e4:	5531                	li	a0,-20
    24e6:	266030ef          	jal	574c <sbrk>
  top = (uint64)sbrk(0);
    24ea:	4501                	li	a0,0
    24ec:	260030ef          	jal	574c <sbrk>
    24f0:	84aa                	mv	s1,a0
  char *p = (char *)(top - 64);
    24f2:	fc050913          	addi	s2,a0,-64 # fc0 <bigdir+0xc0>
  p[0] = 'x';
    24f6:	07800993          	li	s3,120
    24fa:	fd350023          	sb	s3,-64(a0)
  p[1] = '\0';
    24fe:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR | O_CREATE);
    2502:	20200593          	li	a1,514
    2506:	854a                	mv	a0,s2
    2508:	2b8030ef          	jal	57c0 <open>
    250c:	8a2a                	mv	s4,a0
  write(fd, p, 1);
    250e:	4605                	li	a2,1
    2510:	85ca                	mv	a1,s2
    2512:	28e030ef          	jal	57a0 <write>
  close(fd);
    2516:	8552                	mv	a0,s4
    2518:	290030ef          	jal	57a8 <close>
  fd = open(p, O_RDWR);
    251c:	4589                	li	a1,2
    251e:	854a                	mv	a0,s2
    2520:	2a0030ef          	jal	57c0 <open>
  p[0] = '\0';
    2524:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2528:	4605                	li	a2,1
    252a:	85ca                	mv	a1,s2
    252c:	26c030ef          	jal	5798 <read>
  if (p[0] != 'x')
    2530:	fc04c783          	lbu	a5,-64(s1)
    2534:	03379263          	bne	a5,s3,2558 <sbrklast+0x9c>
}
    2538:	70a2                	ld	ra,40(sp)
    253a:	7402                	ld	s0,32(sp)
    253c:	64e2                	ld	s1,24(sp)
    253e:	6942                	ld	s2,16(sp)
    2540:	69a2                	ld	s3,8(sp)
    2542:	6a02                	ld	s4,0(sp)
    2544:	6145                	addi	sp,sp,48
    2546:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    2548:	0347d513          	srli	a0,a5,0x34
    254c:	6785                	lui	a5,0x1
    254e:	40a7853b          	subw	a0,a5,a0
    2552:	1fa030ef          	jal	574c <sbrk>
    2556:	b749                	j	24d8 <sbrklast+0x1c>
    exit(1);
    2558:	4505                	li	a0,1
    255a:	226030ef          	jal	5780 <exit>

000000000000255e <sbrk8000>:
{
    255e:	1141                	addi	sp,sp,-16
    2560:	e406                	sd	ra,8(sp)
    2562:	e022                	sd	s0,0(sp)
    2564:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    2566:	80000537          	lui	a0,0x80000
    256a:	0511                	addi	a0,a0,4 # ffffffff80000004 <base+0xffffffff7ffdeb0c>
    256c:	1e0030ef          	jal	574c <sbrk>
  volatile char *top = sbrk(0);
    2570:	4501                	li	a0,0
    2572:	1da030ef          	jal	574c <sbrk>
  *(top - 1) = *(top - 1) + 1;
    2576:	fff54783          	lbu	a5,-1(a0)
    257a:	2785                	addiw	a5,a5,1 # 1001 <bigdir+0x101>
    257c:	fef50fa3          	sb	a5,-1(a0)
}
    2580:	60a2                	ld	ra,8(sp)
    2582:	6402                	ld	s0,0(sp)
    2584:	0141                	addi	sp,sp,16
    2586:	8082                	ret

0000000000002588 <execout>:
{
    2588:	711d                	addi	sp,sp,-96
    258a:	ec86                	sd	ra,88(sp)
    258c:	e8a2                	sd	s0,80(sp)
    258e:	e4a6                	sd	s1,72(sp)
    2590:	e0ca                	sd	s2,64(sp)
    2592:	fc4e                	sd	s3,56(sp)
    2594:	1080                	addi	s0,sp,96
  for (int avail = 0; avail < 15; avail++) {
    2596:	4901                	li	s2,0
    2598:	49bd                	li	s3,15
    int pid = fork();
    259a:	1de030ef          	jal	5778 <fork>
    259e:	84aa                	mv	s1,a0
    if (pid < 0) {
    25a0:	00054e63          	bltz	a0,25bc <execout+0x34>
    } else if (pid == 0) {
    25a4:	c51d                	beqz	a0,25d2 <execout+0x4a>
      wait((int *)0);
    25a6:	4501                	li	a0,0
    25a8:	1e0030ef          	jal	5788 <wait>
  for (int avail = 0; avail < 15; avail++) {
    25ac:	2905                	addiw	s2,s2,1
    25ae:	ff3916e3          	bne	s2,s3,259a <execout+0x12>
    25b2:	f852                	sd	s4,48(sp)
    25b4:	f456                	sd	s5,40(sp)
  exit(0);
    25b6:	4501                	li	a0,0
    25b8:	1c8030ef          	jal	5780 <exit>
    25bc:	f852                	sd	s4,48(sp)
    25be:	f456                	sd	s5,40(sp)
      printf("fork failed\n");
    25c0:	00005517          	auipc	a0,0x5
    25c4:	7a850513          	addi	a0,a0,1960 # 7d68 <malloc+0x20b6>
    25c8:	62e030ef          	jal	5bf6 <printf>
      exit(1);
    25cc:	4505                	li	a0,1
    25ce:	1b2030ef          	jal	5780 <exit>
    25d2:	f852                	sd	s4,48(sp)
    25d4:	f456                	sd	s5,40(sp)
        char *a = sbrk(PGSIZE);
    25d6:	6985                	lui	s3,0x1
        if (a == SBRK_ERROR)
    25d8:	5a7d                	li	s4,-1
        *(a + PGSIZE - 1) = 1;
    25da:	4a85                	li	s5,1
        char *a = sbrk(PGSIZE);
    25dc:	854e                	mv	a0,s3
    25de:	16e030ef          	jal	574c <sbrk>
        if (a == SBRK_ERROR)
    25e2:	01450663          	beq	a0,s4,25ee <execout+0x66>
        *(a + PGSIZE - 1) = 1;
    25e6:	954e                	add	a0,a0,s3
    25e8:	ff550fa3          	sb	s5,-1(a0)
      while (1) {
    25ec:	bfc5                	j	25dc <execout+0x54>
        sbrk(-PGSIZE);
    25ee:	79fd                	lui	s3,0xfffff
      for (int i = 0; i < avail; i++)
    25f0:	01205863          	blez	s2,2600 <execout+0x78>
        sbrk(-PGSIZE);
    25f4:	854e                	mv	a0,s3
    25f6:	156030ef          	jal	574c <sbrk>
      for (int i = 0; i < avail; i++)
    25fa:	2485                	addiw	s1,s1,1
    25fc:	ff249ce3          	bne	s1,s2,25f4 <execout+0x6c>
      close(1);
    2600:	4505                	li	a0,1
    2602:	1a6030ef          	jal	57a8 <close>
      char *args[] = {"echo", "x", 0};
    2606:	00003797          	auipc	a5,0x3
    260a:	7e278793          	addi	a5,a5,2018 # 5de8 <malloc+0x136>
    260e:	faf43423          	sd	a5,-88(s0)
    2612:	00004797          	auipc	a5,0x4
    2616:	84678793          	addi	a5,a5,-1978 # 5e58 <malloc+0x1a6>
    261a:	faf43823          	sd	a5,-80(s0)
    261e:	fa043c23          	sd	zero,-72(s0)
      exec("echo", args);
    2622:	fa840593          	addi	a1,s0,-88
    2626:	00003517          	auipc	a0,0x3
    262a:	7c250513          	addi	a0,a0,1986 # 5de8 <malloc+0x136>
    262e:	18a030ef          	jal	57b8 <exec>
      exit(0);
    2632:	4501                	li	a0,0
    2634:	14c030ef          	jal	5780 <exit>

0000000000002638 <fourteen>:
{
    2638:	1101                	addi	sp,sp,-32
    263a:	ec06                	sd	ra,24(sp)
    263c:	e822                	sd	s0,16(sp)
    263e:	e426                	sd	s1,8(sp)
    2640:	1000                	addi	s0,sp,32
    2642:	84aa                	mv	s1,a0
  if (mkdir("12345678901234") != 0) {
    2644:	00004517          	auipc	a0,0x4
    2648:	7d450513          	addi	a0,a0,2004 # 6e18 <malloc+0x1166>
    264c:	19c030ef          	jal	57e8 <mkdir>
    2650:	e555                	bnez	a0,26fc <fourteen+0xc4>
  if (mkdir("12345678901234/123456789012345") != 0) {
    2652:	00004517          	auipc	a0,0x4
    2656:	61e50513          	addi	a0,a0,1566 # 6c70 <malloc+0xfbe>
    265a:	18e030ef          	jal	57e8 <mkdir>
    265e:	e94d                	bnez	a0,2710 <fourteen+0xd8>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2660:	20000593          	li	a1,512
    2664:	00004517          	auipc	a0,0x4
    2668:	66450513          	addi	a0,a0,1636 # 6cc8 <malloc+0x1016>
    266c:	154030ef          	jal	57c0 <open>
  if (fd < 0) {
    2670:	0a054a63          	bltz	a0,2724 <fourteen+0xec>
  close(fd);
    2674:	134030ef          	jal	57a8 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2678:	4581                	li	a1,0
    267a:	00004517          	auipc	a0,0x4
    267e:	6c650513          	addi	a0,a0,1734 # 6d40 <malloc+0x108e>
    2682:	13e030ef          	jal	57c0 <open>
  if (fd < 0) {
    2686:	0a054963          	bltz	a0,2738 <fourteen+0x100>
  close(fd);
    268a:	11e030ef          	jal	57a8 <close>
  if (mkdir("12345678901234/12345678901234") == 0) {
    268e:	00004517          	auipc	a0,0x4
    2692:	72250513          	addi	a0,a0,1826 # 6db0 <malloc+0x10fe>
    2696:	152030ef          	jal	57e8 <mkdir>
    269a:	c94d                	beqz	a0,274c <fourteen+0x114>
  if (mkdir("123456789012345/12345678901234") == 0) {
    269c:	00004517          	auipc	a0,0x4
    26a0:	76c50513          	addi	a0,a0,1900 # 6e08 <malloc+0x1156>
    26a4:	144030ef          	jal	57e8 <mkdir>
    26a8:	cd45                	beqz	a0,2760 <fourteen+0x128>
  unlink("123456789012345/12345678901234");
    26aa:	00004517          	auipc	a0,0x4
    26ae:	75e50513          	addi	a0,a0,1886 # 6e08 <malloc+0x1156>
    26b2:	11e030ef          	jal	57d0 <unlink>
  unlink("12345678901234/12345678901234");
    26b6:	00004517          	auipc	a0,0x4
    26ba:	6fa50513          	addi	a0,a0,1786 # 6db0 <malloc+0x10fe>
    26be:	112030ef          	jal	57d0 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    26c2:	00004517          	auipc	a0,0x4
    26c6:	67e50513          	addi	a0,a0,1662 # 6d40 <malloc+0x108e>
    26ca:	106030ef          	jal	57d0 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    26ce:	00004517          	auipc	a0,0x4
    26d2:	5fa50513          	addi	a0,a0,1530 # 6cc8 <malloc+0x1016>
    26d6:	0fa030ef          	jal	57d0 <unlink>
  unlink("12345678901234/123456789012345");
    26da:	00004517          	auipc	a0,0x4
    26de:	59650513          	addi	a0,a0,1430 # 6c70 <malloc+0xfbe>
    26e2:	0ee030ef          	jal	57d0 <unlink>
  unlink("12345678901234");
    26e6:	00004517          	auipc	a0,0x4
    26ea:	73250513          	addi	a0,a0,1842 # 6e18 <malloc+0x1166>
    26ee:	0e2030ef          	jal	57d0 <unlink>
}
    26f2:	60e2                	ld	ra,24(sp)
    26f4:	6442                	ld	s0,16(sp)
    26f6:	64a2                	ld	s1,8(sp)
    26f8:	6105                	addi	sp,sp,32
    26fa:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    26fc:	85a6                	mv	a1,s1
    26fe:	00004517          	auipc	a0,0x4
    2702:	54a50513          	addi	a0,a0,1354 # 6c48 <malloc+0xf96>
    2706:	4f0030ef          	jal	5bf6 <printf>
    exit(1);
    270a:	4505                	li	a0,1
    270c:	074030ef          	jal	5780 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    2710:	85a6                	mv	a1,s1
    2712:	00004517          	auipc	a0,0x4
    2716:	57e50513          	addi	a0,a0,1406 # 6c90 <malloc+0xfde>
    271a:	4dc030ef          	jal	5bf6 <printf>
    exit(1);
    271e:	4505                	li	a0,1
    2720:	060030ef          	jal	5780 <exit>
    printf(
    2724:	85a6                	mv	a1,s1
    2726:	00004517          	auipc	a0,0x4
    272a:	5d250513          	addi	a0,a0,1490 # 6cf8 <malloc+0x1046>
    272e:	4c8030ef          	jal	5bf6 <printf>
    exit(1);
    2732:	4505                	li	a0,1
    2734:	04c030ef          	jal	5780 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    2738:	85a6                	mv	a1,s1
    273a:	00004517          	auipc	a0,0x4
    273e:	63650513          	addi	a0,a0,1590 # 6d70 <malloc+0x10be>
    2742:	4b4030ef          	jal	5bf6 <printf>
    exit(1);
    2746:	4505                	li	a0,1
    2748:	038030ef          	jal	5780 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    274c:	85a6                	mv	a1,s1
    274e:	00004517          	auipc	a0,0x4
    2752:	68250513          	addi	a0,a0,1666 # 6dd0 <malloc+0x111e>
    2756:	4a0030ef          	jal	5bf6 <printf>
    exit(1);
    275a:	4505                	li	a0,1
    275c:	024030ef          	jal	5780 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    2760:	85a6                	mv	a1,s1
    2762:	00004517          	auipc	a0,0x4
    2766:	6c650513          	addi	a0,a0,1734 # 6e28 <malloc+0x1176>
    276a:	48c030ef          	jal	5bf6 <printf>
    exit(1);
    276e:	4505                	li	a0,1
    2770:	010030ef          	jal	5780 <exit>

0000000000002774 <diskfull>:
{
    2774:	b6010113          	addi	sp,sp,-1184
    2778:	48113c23          	sd	ra,1176(sp)
    277c:	48813823          	sd	s0,1168(sp)
    2780:	48913423          	sd	s1,1160(sp)
    2784:	49213023          	sd	s2,1152(sp)
    2788:	47313c23          	sd	s3,1144(sp)
    278c:	47413823          	sd	s4,1136(sp)
    2790:	47513423          	sd	s5,1128(sp)
    2794:	47613023          	sd	s6,1120(sp)
    2798:	45713c23          	sd	s7,1112(sp)
    279c:	45813823          	sd	s8,1104(sp)
    27a0:	45913423          	sd	s9,1096(sp)
    27a4:	45a13023          	sd	s10,1088(sp)
    27a8:	43b13c23          	sd	s11,1080(sp)
    27ac:	4a010413          	addi	s0,sp,1184
    27b0:	b6a43423          	sd	a0,-1176(s0)
  unlink("diskfulldir");
    27b4:	00004517          	auipc	a0,0x4
    27b8:	6ac50513          	addi	a0,a0,1708 # 6e60 <malloc+0x11ae>
    27bc:	014030ef          	jal	57d0 <unlink>
    27c0:	03000a93          	li	s5,48
    name[0] = 'b';
    27c4:	06200d93          	li	s11,98
    name[1] = 'i';
    27c8:	06900d13          	li	s10,105
    name[2] = 'g';
    27cc:	06700c93          	li	s9,103
    unlink(name);
    27d0:	b7040b13          	addi	s6,s0,-1168
    int fd = open(name, O_CREATE | O_RDWR | O_TRUNC);
    27d4:	60200c13          	li	s8,1538
    if (fd < 0) {
    27d8:	6bc1                	lui	s7,0x10
    27da:	10bb8b93          	addi	s7,s7,267 # 1010b <buf+0x3413>
      if (write(fd, buf, BSIZE) != BSIZE) {
    27de:	b9040a13          	addi	s4,s0,-1136
    27e2:	aa8d                	j	2954 <diskfull+0x1e0>
      printf("%s: could not create file %s\n", s, name);
    27e4:	b7040613          	addi	a2,s0,-1168
    27e8:	b6843583          	ld	a1,-1176(s0)
    27ec:	00004517          	auipc	a0,0x4
    27f0:	68450513          	addi	a0,a0,1668 # 6e70 <malloc+0x11be>
    27f4:	402030ef          	jal	5bf6 <printf>
      break;
    27f8:	a039                	j	2806 <diskfull+0x92>
        close(fd);
    27fa:	854e                	mv	a0,s3
    27fc:	7ad020ef          	jal	57a8 <close>
    close(fd);
    2800:	854e                	mv	a0,s3
    2802:	7a7020ef          	jal	57a8 <close>
  for (int i = 0; i < nzz; i++) {
    2806:	4481                	li	s1,0
    name[0] = 'z';
    2808:	07a00993          	li	s3,122
    unlink(name);
    280c:	b9040913          	addi	s2,s0,-1136
    int fd = open(name, O_CREATE | O_RDWR | O_TRUNC);
    2810:	60200a13          	li	s4,1538
  for (int i = 0; i < nzz; i++) {
    2814:	08000a93          	li	s5,128
    name[0] = 'z';
    2818:	b9340823          	sb	s3,-1136(s0)
    name[1] = 'z';
    281c:	b93408a3          	sb	s3,-1135(s0)
    name[2] = '0' + (i / 32);
    2820:	41f4d71b          	sraiw	a4,s1,0x1f
    2824:	01b7571b          	srliw	a4,a4,0x1b
    2828:	009707bb          	addw	a5,a4,s1
    282c:	4057d69b          	sraiw	a3,a5,0x5
    2830:	0306869b          	addiw	a3,a3,48
    2834:	b8d40923          	sb	a3,-1134(s0)
    name[3] = '0' + (i % 32);
    2838:	8bfd                	andi	a5,a5,31
    283a:	9f99                	subw	a5,a5,a4
    283c:	0307879b          	addiw	a5,a5,48
    2840:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    2844:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    2848:	854a                	mv	a0,s2
    284a:	787020ef          	jal	57d0 <unlink>
    int fd = open(name, O_CREATE | O_RDWR | O_TRUNC);
    284e:	85d2                	mv	a1,s4
    2850:	854a                	mv	a0,s2
    2852:	76f020ef          	jal	57c0 <open>
    if (fd < 0)
    2856:	00054763          	bltz	a0,2864 <diskfull+0xf0>
    close(fd);
    285a:	74f020ef          	jal	57a8 <close>
  for (int i = 0; i < nzz; i++) {
    285e:	2485                	addiw	s1,s1,1
    2860:	fb549ce3          	bne	s1,s5,2818 <diskfull+0xa4>
  if (mkdir("diskfulldir") == 0)
    2864:	00004517          	auipc	a0,0x4
    2868:	5fc50513          	addi	a0,a0,1532 # 6e60 <malloc+0x11ae>
    286c:	77d020ef          	jal	57e8 <mkdir>
    2870:	12050363          	beqz	a0,2996 <diskfull+0x222>
  unlink("diskfulldir");
    2874:	00004517          	auipc	a0,0x4
    2878:	5ec50513          	addi	a0,a0,1516 # 6e60 <malloc+0x11ae>
    287c:	755020ef          	jal	57d0 <unlink>
  for (int i = 0; i < nzz; i++) {
    2880:	4481                	li	s1,0
    name[0] = 'z';
    2882:	07a00913          	li	s2,122
    unlink(name);
    2886:	b9040a13          	addi	s4,s0,-1136
  for (int i = 0; i < nzz; i++) {
    288a:	08000993          	li	s3,128
    name[0] = 'z';
    288e:	b9240823          	sb	s2,-1136(s0)
    name[1] = 'z';
    2892:	b92408a3          	sb	s2,-1135(s0)
    name[2] = '0' + (i / 32);
    2896:	41f4d71b          	sraiw	a4,s1,0x1f
    289a:	01b7571b          	srliw	a4,a4,0x1b
    289e:	009707bb          	addw	a5,a4,s1
    28a2:	4057d69b          	sraiw	a3,a5,0x5
    28a6:	0306869b          	addiw	a3,a3,48
    28aa:	b8d40923          	sb	a3,-1134(s0)
    name[3] = '0' + (i % 32);
    28ae:	8bfd                	andi	a5,a5,31
    28b0:	9f99                	subw	a5,a5,a4
    28b2:	0307879b          	addiw	a5,a5,48
    28b6:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    28ba:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    28be:	8552                	mv	a0,s4
    28c0:	711020ef          	jal	57d0 <unlink>
  for (int i = 0; i < nzz; i++) {
    28c4:	2485                	addiw	s1,s1,1
    28c6:	fd3494e3          	bne	s1,s3,288e <diskfull+0x11a>
    28ca:	03000493          	li	s1,48
    name[0] = 'b';
    28ce:	06200b13          	li	s6,98
    name[1] = 'i';
    28d2:	06900a93          	li	s5,105
    name[2] = 'g';
    28d6:	06700a13          	li	s4,103
    unlink(name);
    28da:	b9040993          	addi	s3,s0,-1136
  for (int i = 0; '0' + i < 0177; i++) {
    28de:	07f00913          	li	s2,127
    name[0] = 'b';
    28e2:	b9640823          	sb	s6,-1136(s0)
    name[1] = 'i';
    28e6:	b95408a3          	sb	s5,-1135(s0)
    name[2] = 'g';
    28ea:	b9440923          	sb	s4,-1134(s0)
    name[3] = '0' + i;
    28ee:	b89409a3          	sb	s1,-1133(s0)
    name[4] = '\0';
    28f2:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    28f6:	854e                	mv	a0,s3
    28f8:	6d9020ef          	jal	57d0 <unlink>
  for (int i = 0; '0' + i < 0177; i++) {
    28fc:	2485                	addiw	s1,s1,1
    28fe:	0ff4f493          	zext.b	s1,s1
    2902:	ff2490e3          	bne	s1,s2,28e2 <diskfull+0x16e>
}
    2906:	49813083          	ld	ra,1176(sp)
    290a:	49013403          	ld	s0,1168(sp)
    290e:	48813483          	ld	s1,1160(sp)
    2912:	48013903          	ld	s2,1152(sp)
    2916:	47813983          	ld	s3,1144(sp)
    291a:	47013a03          	ld	s4,1136(sp)
    291e:	46813a83          	ld	s5,1128(sp)
    2922:	46013b03          	ld	s6,1120(sp)
    2926:	45813b83          	ld	s7,1112(sp)
    292a:	45013c03          	ld	s8,1104(sp)
    292e:	44813c83          	ld	s9,1096(sp)
    2932:	44013d03          	ld	s10,1088(sp)
    2936:	43813d83          	ld	s11,1080(sp)
    293a:	4a010113          	addi	sp,sp,1184
    293e:	8082                	ret
    close(fd);
    2940:	854e                	mv	a0,s3
    2942:	667020ef          	jal	57a8 <close>
  for (fi = 0; done == 0 && '0' + fi < 0177; fi++) {
    2946:	2a85                	addiw	s5,s5,1
    2948:	0ffafa93          	zext.b	s5,s5
    294c:	07f00793          	li	a5,127
    2950:	eafa8be3          	beq	s5,a5,2806 <diskfull+0x92>
    name[0] = 'b';
    2954:	b7b40823          	sb	s11,-1168(s0)
    name[1] = 'i';
    2958:	b7a408a3          	sb	s10,-1167(s0)
    name[2] = 'g';
    295c:	b7940923          	sb	s9,-1166(s0)
    name[3] = '0' + fi;
    2960:	b75409a3          	sb	s5,-1165(s0)
    name[4] = '\0';
    2964:	b6040a23          	sb	zero,-1164(s0)
    unlink(name);
    2968:	855a                	mv	a0,s6
    296a:	667020ef          	jal	57d0 <unlink>
    int fd = open(name, O_CREATE | O_RDWR | O_TRUNC);
    296e:	85e2                	mv	a1,s8
    2970:	855a                	mv	a0,s6
    2972:	64f020ef          	jal	57c0 <open>
    2976:	89aa                	mv	s3,a0
    if (fd < 0) {
    2978:	e60546e3          	bltz	a0,27e4 <diskfull+0x70>
    297c:	84de                	mv	s1,s7
      if (write(fd, buf, BSIZE) != BSIZE) {
    297e:	40000913          	li	s2,1024
    2982:	864a                	mv	a2,s2
    2984:	85d2                	mv	a1,s4
    2986:	854e                	mv	a0,s3
    2988:	619020ef          	jal	57a0 <write>
    298c:	e72517e3          	bne	a0,s2,27fa <diskfull+0x86>
    for (int i = 0; i < MAXFILE; i++) {
    2990:	34fd                	addiw	s1,s1,-1
    2992:	f8e5                	bnez	s1,2982 <diskfull+0x20e>
    2994:	b775                	j	2940 <diskfull+0x1cc>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n", s);
    2996:	b6843583          	ld	a1,-1176(s0)
    299a:	00004517          	auipc	a0,0x4
    299e:	4f650513          	addi	a0,a0,1270 # 6e90 <malloc+0x11de>
    29a2:	254030ef          	jal	5bf6 <printf>
    29a6:	b5f9                	j	2874 <diskfull+0x100>

00000000000029a8 <iputtest>:
{
    29a8:	1101                	addi	sp,sp,-32
    29aa:	ec06                	sd	ra,24(sp)
    29ac:	e822                	sd	s0,16(sp)
    29ae:	e426                	sd	s1,8(sp)
    29b0:	1000                	addi	s0,sp,32
    29b2:	84aa                	mv	s1,a0
  if (mkdir("iputdir") < 0) {
    29b4:	00004517          	auipc	a0,0x4
    29b8:	50c50513          	addi	a0,a0,1292 # 6ec0 <malloc+0x120e>
    29bc:	62d020ef          	jal	57e8 <mkdir>
    29c0:	02054f63          	bltz	a0,29fe <iputtest+0x56>
  if (chdir("iputdir") < 0) {
    29c4:	00004517          	auipc	a0,0x4
    29c8:	4fc50513          	addi	a0,a0,1276 # 6ec0 <malloc+0x120e>
    29cc:	625020ef          	jal	57f0 <chdir>
    29d0:	04054163          	bltz	a0,2a12 <iputtest+0x6a>
  if (unlink("../iputdir") < 0) {
    29d4:	00004517          	auipc	a0,0x4
    29d8:	52c50513          	addi	a0,a0,1324 # 6f00 <malloc+0x124e>
    29dc:	5f5020ef          	jal	57d0 <unlink>
    29e0:	04054363          	bltz	a0,2a26 <iputtest+0x7e>
  if (chdir("/") < 0) {
    29e4:	00004517          	auipc	a0,0x4
    29e8:	54c50513          	addi	a0,a0,1356 # 6f30 <malloc+0x127e>
    29ec:	605020ef          	jal	57f0 <chdir>
    29f0:	04054563          	bltz	a0,2a3a <iputtest+0x92>
}
    29f4:	60e2                	ld	ra,24(sp)
    29f6:	6442                	ld	s0,16(sp)
    29f8:	64a2                	ld	s1,8(sp)
    29fa:	6105                	addi	sp,sp,32
    29fc:	8082                	ret
    printf("%s: mkdir failed\n", s);
    29fe:	85a6                	mv	a1,s1
    2a00:	00004517          	auipc	a0,0x4
    2a04:	4c850513          	addi	a0,a0,1224 # 6ec8 <malloc+0x1216>
    2a08:	1ee030ef          	jal	5bf6 <printf>
    exit(1);
    2a0c:	4505                	li	a0,1
    2a0e:	573020ef          	jal	5780 <exit>
    printf("%s: chdir iputdir failed\n", s);
    2a12:	85a6                	mv	a1,s1
    2a14:	00004517          	auipc	a0,0x4
    2a18:	4cc50513          	addi	a0,a0,1228 # 6ee0 <malloc+0x122e>
    2a1c:	1da030ef          	jal	5bf6 <printf>
    exit(1);
    2a20:	4505                	li	a0,1
    2a22:	55f020ef          	jal	5780 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    2a26:	85a6                	mv	a1,s1
    2a28:	00004517          	auipc	a0,0x4
    2a2c:	4e850513          	addi	a0,a0,1256 # 6f10 <malloc+0x125e>
    2a30:	1c6030ef          	jal	5bf6 <printf>
    exit(1);
    2a34:	4505                	li	a0,1
    2a36:	54b020ef          	jal	5780 <exit>
    printf("%s: chdir / failed\n", s);
    2a3a:	85a6                	mv	a1,s1
    2a3c:	00004517          	auipc	a0,0x4
    2a40:	4fc50513          	addi	a0,a0,1276 # 6f38 <malloc+0x1286>
    2a44:	1b2030ef          	jal	5bf6 <printf>
    exit(1);
    2a48:	4505                	li	a0,1
    2a4a:	537020ef          	jal	5780 <exit>

0000000000002a4e <exitiputtest>:
{
    2a4e:	7179                	addi	sp,sp,-48
    2a50:	f406                	sd	ra,40(sp)
    2a52:	f022                	sd	s0,32(sp)
    2a54:	ec26                	sd	s1,24(sp)
    2a56:	1800                	addi	s0,sp,48
    2a58:	84aa                	mv	s1,a0
  pid = fork();
    2a5a:	51f020ef          	jal	5778 <fork>
  if (pid < 0) {
    2a5e:	02054e63          	bltz	a0,2a9a <exitiputtest+0x4c>
  if (pid == 0) {
    2a62:	e541                	bnez	a0,2aea <exitiputtest+0x9c>
    if (mkdir("iputdir") < 0) {
    2a64:	00004517          	auipc	a0,0x4
    2a68:	45c50513          	addi	a0,a0,1116 # 6ec0 <malloc+0x120e>
    2a6c:	57d020ef          	jal	57e8 <mkdir>
    2a70:	02054f63          	bltz	a0,2aae <exitiputtest+0x60>
    if (chdir("iputdir") < 0) {
    2a74:	00004517          	auipc	a0,0x4
    2a78:	44c50513          	addi	a0,a0,1100 # 6ec0 <malloc+0x120e>
    2a7c:	575020ef          	jal	57f0 <chdir>
    2a80:	04054163          	bltz	a0,2ac2 <exitiputtest+0x74>
    if (unlink("../iputdir") < 0) {
    2a84:	00004517          	auipc	a0,0x4
    2a88:	47c50513          	addi	a0,a0,1148 # 6f00 <malloc+0x124e>
    2a8c:	545020ef          	jal	57d0 <unlink>
    2a90:	04054363          	bltz	a0,2ad6 <exitiputtest+0x88>
    exit(0);
    2a94:	4501                	li	a0,0
    2a96:	4eb020ef          	jal	5780 <exit>
    printf("%s: fork failed\n", s);
    2a9a:	85a6                	mv	a1,s1
    2a9c:	00004517          	auipc	a0,0x4
    2aa0:	bdc50513          	addi	a0,a0,-1060 # 6678 <malloc+0x9c6>
    2aa4:	152030ef          	jal	5bf6 <printf>
    exit(1);
    2aa8:	4505                	li	a0,1
    2aaa:	4d7020ef          	jal	5780 <exit>
      printf("%s: mkdir failed\n", s);
    2aae:	85a6                	mv	a1,s1
    2ab0:	00004517          	auipc	a0,0x4
    2ab4:	41850513          	addi	a0,a0,1048 # 6ec8 <malloc+0x1216>
    2ab8:	13e030ef          	jal	5bf6 <printf>
      exit(1);
    2abc:	4505                	li	a0,1
    2abe:	4c3020ef          	jal	5780 <exit>
      printf("%s: child chdir failed\n", s);
    2ac2:	85a6                	mv	a1,s1
    2ac4:	00004517          	auipc	a0,0x4
    2ac8:	48c50513          	addi	a0,a0,1164 # 6f50 <malloc+0x129e>
    2acc:	12a030ef          	jal	5bf6 <printf>
      exit(1);
    2ad0:	4505                	li	a0,1
    2ad2:	4af020ef          	jal	5780 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    2ad6:	85a6                	mv	a1,s1
    2ad8:	00004517          	auipc	a0,0x4
    2adc:	43850513          	addi	a0,a0,1080 # 6f10 <malloc+0x125e>
    2ae0:	116030ef          	jal	5bf6 <printf>
      exit(1);
    2ae4:	4505                	li	a0,1
    2ae6:	49b020ef          	jal	5780 <exit>
  wait(&xstatus);
    2aea:	fdc40513          	addi	a0,s0,-36
    2aee:	49b020ef          	jal	5788 <wait>
  exit(xstatus);
    2af2:	fdc42503          	lw	a0,-36(s0)
    2af6:	48b020ef          	jal	5780 <exit>

0000000000002afa <dirtest>:
{
    2afa:	1101                	addi	sp,sp,-32
    2afc:	ec06                	sd	ra,24(sp)
    2afe:	e822                	sd	s0,16(sp)
    2b00:	e426                	sd	s1,8(sp)
    2b02:	1000                	addi	s0,sp,32
    2b04:	84aa                	mv	s1,a0
  if (mkdir("dir0") < 0) {
    2b06:	00004517          	auipc	a0,0x4
    2b0a:	46250513          	addi	a0,a0,1122 # 6f68 <malloc+0x12b6>
    2b0e:	4db020ef          	jal	57e8 <mkdir>
    2b12:	02054f63          	bltz	a0,2b50 <dirtest+0x56>
  if (chdir("dir0") < 0) {
    2b16:	00004517          	auipc	a0,0x4
    2b1a:	45250513          	addi	a0,a0,1106 # 6f68 <malloc+0x12b6>
    2b1e:	4d3020ef          	jal	57f0 <chdir>
    2b22:	04054163          	bltz	a0,2b64 <dirtest+0x6a>
  if (chdir("..") < 0) {
    2b26:	00004517          	auipc	a0,0x4
    2b2a:	46250513          	addi	a0,a0,1122 # 6f88 <malloc+0x12d6>
    2b2e:	4c3020ef          	jal	57f0 <chdir>
    2b32:	04054363          	bltz	a0,2b78 <dirtest+0x7e>
  if (unlink("dir0") < 0) {
    2b36:	00004517          	auipc	a0,0x4
    2b3a:	43250513          	addi	a0,a0,1074 # 6f68 <malloc+0x12b6>
    2b3e:	493020ef          	jal	57d0 <unlink>
    2b42:	04054563          	bltz	a0,2b8c <dirtest+0x92>
}
    2b46:	60e2                	ld	ra,24(sp)
    2b48:	6442                	ld	s0,16(sp)
    2b4a:	64a2                	ld	s1,8(sp)
    2b4c:	6105                	addi	sp,sp,32
    2b4e:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2b50:	85a6                	mv	a1,s1
    2b52:	00004517          	auipc	a0,0x4
    2b56:	37650513          	addi	a0,a0,886 # 6ec8 <malloc+0x1216>
    2b5a:	09c030ef          	jal	5bf6 <printf>
    exit(1);
    2b5e:	4505                	li	a0,1
    2b60:	421020ef          	jal	5780 <exit>
    printf("%s: chdir dir0 failed\n", s);
    2b64:	85a6                	mv	a1,s1
    2b66:	00004517          	auipc	a0,0x4
    2b6a:	40a50513          	addi	a0,a0,1034 # 6f70 <malloc+0x12be>
    2b6e:	088030ef          	jal	5bf6 <printf>
    exit(1);
    2b72:	4505                	li	a0,1
    2b74:	40d020ef          	jal	5780 <exit>
    printf("%s: chdir .. failed\n", s);
    2b78:	85a6                	mv	a1,s1
    2b7a:	00004517          	auipc	a0,0x4
    2b7e:	41650513          	addi	a0,a0,1046 # 6f90 <malloc+0x12de>
    2b82:	074030ef          	jal	5bf6 <printf>
    exit(1);
    2b86:	4505                	li	a0,1
    2b88:	3f9020ef          	jal	5780 <exit>
    printf("%s: unlink dir0 failed\n", s);
    2b8c:	85a6                	mv	a1,s1
    2b8e:	00004517          	auipc	a0,0x4
    2b92:	41a50513          	addi	a0,a0,1050 # 6fa8 <malloc+0x12f6>
    2b96:	060030ef          	jal	5bf6 <printf>
    exit(1);
    2b9a:	4505                	li	a0,1
    2b9c:	3e5020ef          	jal	5780 <exit>

0000000000002ba0 <subdir>:
{
    2ba0:	1101                	addi	sp,sp,-32
    2ba2:	ec06                	sd	ra,24(sp)
    2ba4:	e822                	sd	s0,16(sp)
    2ba6:	e426                	sd	s1,8(sp)
    2ba8:	e04a                	sd	s2,0(sp)
    2baa:	1000                	addi	s0,sp,32
    2bac:	892a                	mv	s2,a0
  unlink("ff");
    2bae:	00004517          	auipc	a0,0x4
    2bb2:	54250513          	addi	a0,a0,1346 # 70f0 <malloc+0x143e>
    2bb6:	41b020ef          	jal	57d0 <unlink>
  if (mkdir("dd") != 0) {
    2bba:	00004517          	auipc	a0,0x4
    2bbe:	40650513          	addi	a0,a0,1030 # 6fc0 <malloc+0x130e>
    2bc2:	427020ef          	jal	57e8 <mkdir>
    2bc6:	2e051663          	bnez	a0,2eb2 <subdir+0x312>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    2bca:	20200593          	li	a1,514
    2bce:	00004517          	auipc	a0,0x4
    2bd2:	41250513          	addi	a0,a0,1042 # 6fe0 <malloc+0x132e>
    2bd6:	3eb020ef          	jal	57c0 <open>
    2bda:	84aa                	mv	s1,a0
  if (fd < 0) {
    2bdc:	2e054563          	bltz	a0,2ec6 <subdir+0x326>
  write(fd, "ff", 2);
    2be0:	4609                	li	a2,2
    2be2:	00004597          	auipc	a1,0x4
    2be6:	50e58593          	addi	a1,a1,1294 # 70f0 <malloc+0x143e>
    2bea:	3b7020ef          	jal	57a0 <write>
  close(fd);
    2bee:	8526                	mv	a0,s1
    2bf0:	3b9020ef          	jal	57a8 <close>
  if (unlink("dd") >= 0) {
    2bf4:	00004517          	auipc	a0,0x4
    2bf8:	3cc50513          	addi	a0,a0,972 # 6fc0 <malloc+0x130e>
    2bfc:	3d5020ef          	jal	57d0 <unlink>
    2c00:	2c055d63          	bgez	a0,2eda <subdir+0x33a>
  if (mkdir("/dd/dd") != 0) {
    2c04:	00004517          	auipc	a0,0x4
    2c08:	43450513          	addi	a0,a0,1076 # 7038 <malloc+0x1386>
    2c0c:	3dd020ef          	jal	57e8 <mkdir>
    2c10:	2c051f63          	bnez	a0,2eee <subdir+0x34e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2c14:	20200593          	li	a1,514
    2c18:	00004517          	auipc	a0,0x4
    2c1c:	44850513          	addi	a0,a0,1096 # 7060 <malloc+0x13ae>
    2c20:	3a1020ef          	jal	57c0 <open>
    2c24:	84aa                	mv	s1,a0
  if (fd < 0) {
    2c26:	2c054e63          	bltz	a0,2f02 <subdir+0x362>
  write(fd, "FF", 2);
    2c2a:	4609                	li	a2,2
    2c2c:	00004597          	auipc	a1,0x4
    2c30:	46458593          	addi	a1,a1,1124 # 7090 <malloc+0x13de>
    2c34:	36d020ef          	jal	57a0 <write>
  close(fd);
    2c38:	8526                	mv	a0,s1
    2c3a:	36f020ef          	jal	57a8 <close>
  fd = open("dd/dd/../ff", 0);
    2c3e:	4581                	li	a1,0
    2c40:	00004517          	auipc	a0,0x4
    2c44:	45850513          	addi	a0,a0,1112 # 7098 <malloc+0x13e6>
    2c48:	379020ef          	jal	57c0 <open>
    2c4c:	84aa                	mv	s1,a0
  if (fd < 0) {
    2c4e:	2c054463          	bltz	a0,2f16 <subdir+0x376>
  cc = read(fd, buf, sizeof(buf));
    2c52:	6655                	lui	a2,0x15
    2c54:	80060613          	addi	a2,a2,-2048 # 14800 <buf+0x7b08>
    2c58:	0000a597          	auipc	a1,0xa
    2c5c:	0a058593          	addi	a1,a1,160 # ccf8 <buf>
    2c60:	339020ef          	jal	5798 <read>
  if (cc != 2 || buf[0] != 'f') {
    2c64:	4789                	li	a5,2
    2c66:	2cf51263          	bne	a0,a5,2f2a <subdir+0x38a>
    2c6a:	0000a717          	auipc	a4,0xa
    2c6e:	08e74703          	lbu	a4,142(a4) # ccf8 <buf>
    2c72:	06600793          	li	a5,102
    2c76:	2af71a63          	bne	a4,a5,2f2a <subdir+0x38a>
  close(fd);
    2c7a:	8526                	mv	a0,s1
    2c7c:	32d020ef          	jal	57a8 <close>
  if (link("dd/dd/ff", "dd/dd/ffff") != 0) {
    2c80:	00004597          	auipc	a1,0x4
    2c84:	46858593          	addi	a1,a1,1128 # 70e8 <malloc+0x1436>
    2c88:	00004517          	auipc	a0,0x4
    2c8c:	3d850513          	addi	a0,a0,984 # 7060 <malloc+0x13ae>
    2c90:	351020ef          	jal	57e0 <link>
    2c94:	2a051563          	bnez	a0,2f3e <subdir+0x39e>
  if (unlink("dd/dd/ff") != 0) {
    2c98:	00004517          	auipc	a0,0x4
    2c9c:	3c850513          	addi	a0,a0,968 # 7060 <malloc+0x13ae>
    2ca0:	331020ef          	jal	57d0 <unlink>
    2ca4:	2a051763          	bnez	a0,2f52 <subdir+0x3b2>
  if (open("dd/dd/ff", O_RDONLY) >= 0) {
    2ca8:	4581                	li	a1,0
    2caa:	00004517          	auipc	a0,0x4
    2cae:	3b650513          	addi	a0,a0,950 # 7060 <malloc+0x13ae>
    2cb2:	30f020ef          	jal	57c0 <open>
    2cb6:	2a055863          	bgez	a0,2f66 <subdir+0x3c6>
  if (chdir("dd") != 0) {
    2cba:	00004517          	auipc	a0,0x4
    2cbe:	30650513          	addi	a0,a0,774 # 6fc0 <malloc+0x130e>
    2cc2:	32f020ef          	jal	57f0 <chdir>
    2cc6:	2a051a63          	bnez	a0,2f7a <subdir+0x3da>
  if (chdir("dd/../../dd") != 0) {
    2cca:	00004517          	auipc	a0,0x4
    2cce:	4b650513          	addi	a0,a0,1206 # 7180 <malloc+0x14ce>
    2cd2:	31f020ef          	jal	57f0 <chdir>
    2cd6:	2a051c63          	bnez	a0,2f8e <subdir+0x3ee>
  if (chdir("dd/../../../dd") != 0) {
    2cda:	00004517          	auipc	a0,0x4
    2cde:	4d650513          	addi	a0,a0,1238 # 71b0 <malloc+0x14fe>
    2ce2:	30f020ef          	jal	57f0 <chdir>
    2ce6:	2a051e63          	bnez	a0,2fa2 <subdir+0x402>
  if (chdir("./..") != 0) {
    2cea:	00004517          	auipc	a0,0x4
    2cee:	4fe50513          	addi	a0,a0,1278 # 71e8 <malloc+0x1536>
    2cf2:	2ff020ef          	jal	57f0 <chdir>
    2cf6:	2c051063          	bnez	a0,2fb6 <subdir+0x416>
  fd = open("dd/dd/ffff", 0);
    2cfa:	4581                	li	a1,0
    2cfc:	00004517          	auipc	a0,0x4
    2d00:	3ec50513          	addi	a0,a0,1004 # 70e8 <malloc+0x1436>
    2d04:	2bd020ef          	jal	57c0 <open>
    2d08:	84aa                	mv	s1,a0
  if (fd < 0) {
    2d0a:	2c054063          	bltz	a0,2fca <subdir+0x42a>
  if (read(fd, buf, sizeof(buf)) != 2) {
    2d0e:	6655                	lui	a2,0x15
    2d10:	80060613          	addi	a2,a2,-2048 # 14800 <buf+0x7b08>
    2d14:	0000a597          	auipc	a1,0xa
    2d18:	fe458593          	addi	a1,a1,-28 # ccf8 <buf>
    2d1c:	27d020ef          	jal	5798 <read>
    2d20:	4789                	li	a5,2
    2d22:	2af51e63          	bne	a0,a5,2fde <subdir+0x43e>
  close(fd);
    2d26:	8526                	mv	a0,s1
    2d28:	281020ef          	jal	57a8 <close>
  if (open("dd/dd/ff", O_RDONLY) >= 0) {
    2d2c:	4581                	li	a1,0
    2d2e:	00004517          	auipc	a0,0x4
    2d32:	33250513          	addi	a0,a0,818 # 7060 <malloc+0x13ae>
    2d36:	28b020ef          	jal	57c0 <open>
    2d3a:	2a055c63          	bgez	a0,2ff2 <subdir+0x452>
  if (open("dd/ff/ff", O_CREATE | O_RDWR) >= 0) {
    2d3e:	20200593          	li	a1,514
    2d42:	00004517          	auipc	a0,0x4
    2d46:	53650513          	addi	a0,a0,1334 # 7278 <malloc+0x15c6>
    2d4a:	277020ef          	jal	57c0 <open>
    2d4e:	2a055c63          	bgez	a0,3006 <subdir+0x466>
  if (open("dd/xx/ff", O_CREATE | O_RDWR) >= 0) {
    2d52:	20200593          	li	a1,514
    2d56:	00004517          	auipc	a0,0x4
    2d5a:	55250513          	addi	a0,a0,1362 # 72a8 <malloc+0x15f6>
    2d5e:	263020ef          	jal	57c0 <open>
    2d62:	2a055c63          	bgez	a0,301a <subdir+0x47a>
  if (open("dd", O_CREATE) >= 0) {
    2d66:	20000593          	li	a1,512
    2d6a:	00004517          	auipc	a0,0x4
    2d6e:	25650513          	addi	a0,a0,598 # 6fc0 <malloc+0x130e>
    2d72:	24f020ef          	jal	57c0 <open>
    2d76:	2a055c63          	bgez	a0,302e <subdir+0x48e>
  if (open("dd", O_RDWR) >= 0) {
    2d7a:	4589                	li	a1,2
    2d7c:	00004517          	auipc	a0,0x4
    2d80:	24450513          	addi	a0,a0,580 # 6fc0 <malloc+0x130e>
    2d84:	23d020ef          	jal	57c0 <open>
    2d88:	2a055d63          	bgez	a0,3042 <subdir+0x4a2>
  if (open("dd", O_WRONLY) >= 0) {
    2d8c:	4585                	li	a1,1
    2d8e:	00004517          	auipc	a0,0x4
    2d92:	23250513          	addi	a0,a0,562 # 6fc0 <malloc+0x130e>
    2d96:	22b020ef          	jal	57c0 <open>
    2d9a:	2a055e63          	bgez	a0,3056 <subdir+0x4b6>
  if (link("dd/ff/ff", "dd/dd/xx") == 0) {
    2d9e:	00004597          	auipc	a1,0x4
    2da2:	59a58593          	addi	a1,a1,1434 # 7338 <malloc+0x1686>
    2da6:	00004517          	auipc	a0,0x4
    2daa:	4d250513          	addi	a0,a0,1234 # 7278 <malloc+0x15c6>
    2dae:	233020ef          	jal	57e0 <link>
    2db2:	2a050c63          	beqz	a0,306a <subdir+0x4ca>
  if (link("dd/xx/ff", "dd/dd/xx") == 0) {
    2db6:	00004597          	auipc	a1,0x4
    2dba:	58258593          	addi	a1,a1,1410 # 7338 <malloc+0x1686>
    2dbe:	00004517          	auipc	a0,0x4
    2dc2:	4ea50513          	addi	a0,a0,1258 # 72a8 <malloc+0x15f6>
    2dc6:	21b020ef          	jal	57e0 <link>
    2dca:	2a050a63          	beqz	a0,307e <subdir+0x4de>
  if (link("dd/ff", "dd/dd/ffff") == 0) {
    2dce:	00004597          	auipc	a1,0x4
    2dd2:	31a58593          	addi	a1,a1,794 # 70e8 <malloc+0x1436>
    2dd6:	00004517          	auipc	a0,0x4
    2dda:	20a50513          	addi	a0,a0,522 # 6fe0 <malloc+0x132e>
    2dde:	203020ef          	jal	57e0 <link>
    2de2:	2a050863          	beqz	a0,3092 <subdir+0x4f2>
  if (mkdir("dd/ff/ff") == 0) {
    2de6:	00004517          	auipc	a0,0x4
    2dea:	49250513          	addi	a0,a0,1170 # 7278 <malloc+0x15c6>
    2dee:	1fb020ef          	jal	57e8 <mkdir>
    2df2:	2a050a63          	beqz	a0,30a6 <subdir+0x506>
  if (mkdir("dd/xx/ff") == 0) {
    2df6:	00004517          	auipc	a0,0x4
    2dfa:	4b250513          	addi	a0,a0,1202 # 72a8 <malloc+0x15f6>
    2dfe:	1eb020ef          	jal	57e8 <mkdir>
    2e02:	2a050c63          	beqz	a0,30ba <subdir+0x51a>
  if (mkdir("dd/dd/ffff") == 0) {
    2e06:	00004517          	auipc	a0,0x4
    2e0a:	2e250513          	addi	a0,a0,738 # 70e8 <malloc+0x1436>
    2e0e:	1db020ef          	jal	57e8 <mkdir>
    2e12:	2a050e63          	beqz	a0,30ce <subdir+0x52e>
  if (unlink("dd/xx/ff") == 0) {
    2e16:	00004517          	auipc	a0,0x4
    2e1a:	49250513          	addi	a0,a0,1170 # 72a8 <malloc+0x15f6>
    2e1e:	1b3020ef          	jal	57d0 <unlink>
    2e22:	2c050063          	beqz	a0,30e2 <subdir+0x542>
  if (unlink("dd/ff/ff") == 0) {
    2e26:	00004517          	auipc	a0,0x4
    2e2a:	45250513          	addi	a0,a0,1106 # 7278 <malloc+0x15c6>
    2e2e:	1a3020ef          	jal	57d0 <unlink>
    2e32:	2c050263          	beqz	a0,30f6 <subdir+0x556>
  if (chdir("dd/ff") == 0) {
    2e36:	00004517          	auipc	a0,0x4
    2e3a:	1aa50513          	addi	a0,a0,426 # 6fe0 <malloc+0x132e>
    2e3e:	1b3020ef          	jal	57f0 <chdir>
    2e42:	2c050463          	beqz	a0,310a <subdir+0x56a>
  if (chdir("dd/xx") == 0) {
    2e46:	00004517          	auipc	a0,0x4
    2e4a:	64250513          	addi	a0,a0,1602 # 7488 <malloc+0x17d6>
    2e4e:	1a3020ef          	jal	57f0 <chdir>
    2e52:	2c050663          	beqz	a0,311e <subdir+0x57e>
  if (unlink("dd/dd/ffff") != 0) {
    2e56:	00004517          	auipc	a0,0x4
    2e5a:	29250513          	addi	a0,a0,658 # 70e8 <malloc+0x1436>
    2e5e:	173020ef          	jal	57d0 <unlink>
    2e62:	2c051863          	bnez	a0,3132 <subdir+0x592>
  if (unlink("dd/ff") != 0) {
    2e66:	00004517          	auipc	a0,0x4
    2e6a:	17a50513          	addi	a0,a0,378 # 6fe0 <malloc+0x132e>
    2e6e:	163020ef          	jal	57d0 <unlink>
    2e72:	2c051a63          	bnez	a0,3146 <subdir+0x5a6>
  if (unlink("dd") == 0) {
    2e76:	00004517          	auipc	a0,0x4
    2e7a:	14a50513          	addi	a0,a0,330 # 6fc0 <malloc+0x130e>
    2e7e:	153020ef          	jal	57d0 <unlink>
    2e82:	2c050c63          	beqz	a0,315a <subdir+0x5ba>
  if (unlink("dd/dd") < 0) {
    2e86:	00004517          	auipc	a0,0x4
    2e8a:	67250513          	addi	a0,a0,1650 # 74f8 <malloc+0x1846>
    2e8e:	143020ef          	jal	57d0 <unlink>
    2e92:	2c054e63          	bltz	a0,316e <subdir+0x5ce>
  if (unlink("dd") < 0) {
    2e96:	00004517          	auipc	a0,0x4
    2e9a:	12a50513          	addi	a0,a0,298 # 6fc0 <malloc+0x130e>
    2e9e:	133020ef          	jal	57d0 <unlink>
    2ea2:	2e054063          	bltz	a0,3182 <subdir+0x5e2>
}
    2ea6:	60e2                	ld	ra,24(sp)
    2ea8:	6442                	ld	s0,16(sp)
    2eaa:	64a2                	ld	s1,8(sp)
    2eac:	6902                	ld	s2,0(sp)
    2eae:	6105                	addi	sp,sp,32
    2eb0:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    2eb2:	85ca                	mv	a1,s2
    2eb4:	00004517          	auipc	a0,0x4
    2eb8:	11450513          	addi	a0,a0,276 # 6fc8 <malloc+0x1316>
    2ebc:	53b020ef          	jal	5bf6 <printf>
    exit(1);
    2ec0:	4505                	li	a0,1
    2ec2:	0bf020ef          	jal	5780 <exit>
    printf("%s: create dd/ff failed\n", s);
    2ec6:	85ca                	mv	a1,s2
    2ec8:	00004517          	auipc	a0,0x4
    2ecc:	12050513          	addi	a0,a0,288 # 6fe8 <malloc+0x1336>
    2ed0:	527020ef          	jal	5bf6 <printf>
    exit(1);
    2ed4:	4505                	li	a0,1
    2ed6:	0ab020ef          	jal	5780 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    2eda:	85ca                	mv	a1,s2
    2edc:	00004517          	auipc	a0,0x4
    2ee0:	12c50513          	addi	a0,a0,300 # 7008 <malloc+0x1356>
    2ee4:	513020ef          	jal	5bf6 <printf>
    exit(1);
    2ee8:	4505                	li	a0,1
    2eea:	097020ef          	jal	5780 <exit>
    printf("%s: subdir mkdir dd/dd failed\n", s);
    2eee:	85ca                	mv	a1,s2
    2ef0:	00004517          	auipc	a0,0x4
    2ef4:	15050513          	addi	a0,a0,336 # 7040 <malloc+0x138e>
    2ef8:	4ff020ef          	jal	5bf6 <printf>
    exit(1);
    2efc:	4505                	li	a0,1
    2efe:	083020ef          	jal	5780 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    2f02:	85ca                	mv	a1,s2
    2f04:	00004517          	auipc	a0,0x4
    2f08:	16c50513          	addi	a0,a0,364 # 7070 <malloc+0x13be>
    2f0c:	4eb020ef          	jal	5bf6 <printf>
    exit(1);
    2f10:	4505                	li	a0,1
    2f12:	06f020ef          	jal	5780 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    2f16:	85ca                	mv	a1,s2
    2f18:	00004517          	auipc	a0,0x4
    2f1c:	19050513          	addi	a0,a0,400 # 70a8 <malloc+0x13f6>
    2f20:	4d7020ef          	jal	5bf6 <printf>
    exit(1);
    2f24:	4505                	li	a0,1
    2f26:	05b020ef          	jal	5780 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    2f2a:	85ca                	mv	a1,s2
    2f2c:	00004517          	auipc	a0,0x4
    2f30:	19c50513          	addi	a0,a0,412 # 70c8 <malloc+0x1416>
    2f34:	4c3020ef          	jal	5bf6 <printf>
    exit(1);
    2f38:	4505                	li	a0,1
    2f3a:	047020ef          	jal	5780 <exit>
    printf("%s: link dd/dd/ff dd/dd/ffff failed\n", s);
    2f3e:	85ca                	mv	a1,s2
    2f40:	00004517          	auipc	a0,0x4
    2f44:	1b850513          	addi	a0,a0,440 # 70f8 <malloc+0x1446>
    2f48:	4af020ef          	jal	5bf6 <printf>
    exit(1);
    2f4c:	4505                	li	a0,1
    2f4e:	033020ef          	jal	5780 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    2f52:	85ca                	mv	a1,s2
    2f54:	00004517          	auipc	a0,0x4
    2f58:	1cc50513          	addi	a0,a0,460 # 7120 <malloc+0x146e>
    2f5c:	49b020ef          	jal	5bf6 <printf>
    exit(1);
    2f60:	4505                	li	a0,1
    2f62:	01f020ef          	jal	5780 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    2f66:	85ca                	mv	a1,s2
    2f68:	00004517          	auipc	a0,0x4
    2f6c:	1d850513          	addi	a0,a0,472 # 7140 <malloc+0x148e>
    2f70:	487020ef          	jal	5bf6 <printf>
    exit(1);
    2f74:	4505                	li	a0,1
    2f76:	00b020ef          	jal	5780 <exit>
    printf("%s: chdir dd failed\n", s);
    2f7a:	85ca                	mv	a1,s2
    2f7c:	00004517          	auipc	a0,0x4
    2f80:	1ec50513          	addi	a0,a0,492 # 7168 <malloc+0x14b6>
    2f84:	473020ef          	jal	5bf6 <printf>
    exit(1);
    2f88:	4505                	li	a0,1
    2f8a:	7f6020ef          	jal	5780 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    2f8e:	85ca                	mv	a1,s2
    2f90:	00004517          	auipc	a0,0x4
    2f94:	20050513          	addi	a0,a0,512 # 7190 <malloc+0x14de>
    2f98:	45f020ef          	jal	5bf6 <printf>
    exit(1);
    2f9c:	4505                	li	a0,1
    2f9e:	7e2020ef          	jal	5780 <exit>
    printf("%s: chdir dd/../../../dd failed\n", s);
    2fa2:	85ca                	mv	a1,s2
    2fa4:	00004517          	auipc	a0,0x4
    2fa8:	21c50513          	addi	a0,a0,540 # 71c0 <malloc+0x150e>
    2fac:	44b020ef          	jal	5bf6 <printf>
    exit(1);
    2fb0:	4505                	li	a0,1
    2fb2:	7ce020ef          	jal	5780 <exit>
    printf("%s: chdir ./.. failed\n", s);
    2fb6:	85ca                	mv	a1,s2
    2fb8:	00004517          	auipc	a0,0x4
    2fbc:	23850513          	addi	a0,a0,568 # 71f0 <malloc+0x153e>
    2fc0:	437020ef          	jal	5bf6 <printf>
    exit(1);
    2fc4:	4505                	li	a0,1
    2fc6:	7ba020ef          	jal	5780 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    2fca:	85ca                	mv	a1,s2
    2fcc:	00004517          	auipc	a0,0x4
    2fd0:	23c50513          	addi	a0,a0,572 # 7208 <malloc+0x1556>
    2fd4:	423020ef          	jal	5bf6 <printf>
    exit(1);
    2fd8:	4505                	li	a0,1
    2fda:	7a6020ef          	jal	5780 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    2fde:	85ca                	mv	a1,s2
    2fe0:	00004517          	auipc	a0,0x4
    2fe4:	24850513          	addi	a0,a0,584 # 7228 <malloc+0x1576>
    2fe8:	40f020ef          	jal	5bf6 <printf>
    exit(1);
    2fec:	4505                	li	a0,1
    2fee:	792020ef          	jal	5780 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    2ff2:	85ca                	mv	a1,s2
    2ff4:	00004517          	auipc	a0,0x4
    2ff8:	25450513          	addi	a0,a0,596 # 7248 <malloc+0x1596>
    2ffc:	3fb020ef          	jal	5bf6 <printf>
    exit(1);
    3000:	4505                	li	a0,1
    3002:	77e020ef          	jal	5780 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3006:	85ca                	mv	a1,s2
    3008:	00004517          	auipc	a0,0x4
    300c:	28050513          	addi	a0,a0,640 # 7288 <malloc+0x15d6>
    3010:	3e7020ef          	jal	5bf6 <printf>
    exit(1);
    3014:	4505                	li	a0,1
    3016:	76a020ef          	jal	5780 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    301a:	85ca                	mv	a1,s2
    301c:	00004517          	auipc	a0,0x4
    3020:	29c50513          	addi	a0,a0,668 # 72b8 <malloc+0x1606>
    3024:	3d3020ef          	jal	5bf6 <printf>
    exit(1);
    3028:	4505                	li	a0,1
    302a:	756020ef          	jal	5780 <exit>
    printf("%s: create dd succeeded!\n", s);
    302e:	85ca                	mv	a1,s2
    3030:	00004517          	auipc	a0,0x4
    3034:	2a850513          	addi	a0,a0,680 # 72d8 <malloc+0x1626>
    3038:	3bf020ef          	jal	5bf6 <printf>
    exit(1);
    303c:	4505                	li	a0,1
    303e:	742020ef          	jal	5780 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3042:	85ca                	mv	a1,s2
    3044:	00004517          	auipc	a0,0x4
    3048:	2b450513          	addi	a0,a0,692 # 72f8 <malloc+0x1646>
    304c:	3ab020ef          	jal	5bf6 <printf>
    exit(1);
    3050:	4505                	li	a0,1
    3052:	72e020ef          	jal	5780 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3056:	85ca                	mv	a1,s2
    3058:	00004517          	auipc	a0,0x4
    305c:	2c050513          	addi	a0,a0,704 # 7318 <malloc+0x1666>
    3060:	397020ef          	jal	5bf6 <printf>
    exit(1);
    3064:	4505                	li	a0,1
    3066:	71a020ef          	jal	5780 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    306a:	85ca                	mv	a1,s2
    306c:	00004517          	auipc	a0,0x4
    3070:	2dc50513          	addi	a0,a0,732 # 7348 <malloc+0x1696>
    3074:	383020ef          	jal	5bf6 <printf>
    exit(1);
    3078:	4505                	li	a0,1
    307a:	706020ef          	jal	5780 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    307e:	85ca                	mv	a1,s2
    3080:	00004517          	auipc	a0,0x4
    3084:	2f050513          	addi	a0,a0,752 # 7370 <malloc+0x16be>
    3088:	36f020ef          	jal	5bf6 <printf>
    exit(1);
    308c:	4505                	li	a0,1
    308e:	6f2020ef          	jal	5780 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    3092:	85ca                	mv	a1,s2
    3094:	00004517          	auipc	a0,0x4
    3098:	30450513          	addi	a0,a0,772 # 7398 <malloc+0x16e6>
    309c:	35b020ef          	jal	5bf6 <printf>
    exit(1);
    30a0:	4505                	li	a0,1
    30a2:	6de020ef          	jal	5780 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    30a6:	85ca                	mv	a1,s2
    30a8:	00004517          	auipc	a0,0x4
    30ac:	31850513          	addi	a0,a0,792 # 73c0 <malloc+0x170e>
    30b0:	347020ef          	jal	5bf6 <printf>
    exit(1);
    30b4:	4505                	li	a0,1
    30b6:	6ca020ef          	jal	5780 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    30ba:	85ca                	mv	a1,s2
    30bc:	00004517          	auipc	a0,0x4
    30c0:	32450513          	addi	a0,a0,804 # 73e0 <malloc+0x172e>
    30c4:	333020ef          	jal	5bf6 <printf>
    exit(1);
    30c8:	4505                	li	a0,1
    30ca:	6b6020ef          	jal	5780 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    30ce:	85ca                	mv	a1,s2
    30d0:	00004517          	auipc	a0,0x4
    30d4:	33050513          	addi	a0,a0,816 # 7400 <malloc+0x174e>
    30d8:	31f020ef          	jal	5bf6 <printf>
    exit(1);
    30dc:	4505                	li	a0,1
    30de:	6a2020ef          	jal	5780 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    30e2:	85ca                	mv	a1,s2
    30e4:	00004517          	auipc	a0,0x4
    30e8:	34450513          	addi	a0,a0,836 # 7428 <malloc+0x1776>
    30ec:	30b020ef          	jal	5bf6 <printf>
    exit(1);
    30f0:	4505                	li	a0,1
    30f2:	68e020ef          	jal	5780 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    30f6:	85ca                	mv	a1,s2
    30f8:	00004517          	auipc	a0,0x4
    30fc:	35050513          	addi	a0,a0,848 # 7448 <malloc+0x1796>
    3100:	2f7020ef          	jal	5bf6 <printf>
    exit(1);
    3104:	4505                	li	a0,1
    3106:	67a020ef          	jal	5780 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    310a:	85ca                	mv	a1,s2
    310c:	00004517          	auipc	a0,0x4
    3110:	35c50513          	addi	a0,a0,860 # 7468 <malloc+0x17b6>
    3114:	2e3020ef          	jal	5bf6 <printf>
    exit(1);
    3118:	4505                	li	a0,1
    311a:	666020ef          	jal	5780 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    311e:	85ca                	mv	a1,s2
    3120:	00004517          	auipc	a0,0x4
    3124:	37050513          	addi	a0,a0,880 # 7490 <malloc+0x17de>
    3128:	2cf020ef          	jal	5bf6 <printf>
    exit(1);
    312c:	4505                	li	a0,1
    312e:	652020ef          	jal	5780 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3132:	85ca                	mv	a1,s2
    3134:	00004517          	auipc	a0,0x4
    3138:	fec50513          	addi	a0,a0,-20 # 7120 <malloc+0x146e>
    313c:	2bb020ef          	jal	5bf6 <printf>
    exit(1);
    3140:	4505                	li	a0,1
    3142:	63e020ef          	jal	5780 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    3146:	85ca                	mv	a1,s2
    3148:	00004517          	auipc	a0,0x4
    314c:	36850513          	addi	a0,a0,872 # 74b0 <malloc+0x17fe>
    3150:	2a7020ef          	jal	5bf6 <printf>
    exit(1);
    3154:	4505                	li	a0,1
    3156:	62a020ef          	jal	5780 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    315a:	85ca                	mv	a1,s2
    315c:	00004517          	auipc	a0,0x4
    3160:	37450513          	addi	a0,a0,884 # 74d0 <malloc+0x181e>
    3164:	293020ef          	jal	5bf6 <printf>
    exit(1);
    3168:	4505                	li	a0,1
    316a:	616020ef          	jal	5780 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    316e:	85ca                	mv	a1,s2
    3170:	00004517          	auipc	a0,0x4
    3174:	39050513          	addi	a0,a0,912 # 7500 <malloc+0x184e>
    3178:	27f020ef          	jal	5bf6 <printf>
    exit(1);
    317c:	4505                	li	a0,1
    317e:	602020ef          	jal	5780 <exit>
    printf("%s: unlink dd failed\n", s);
    3182:	85ca                	mv	a1,s2
    3184:	00004517          	auipc	a0,0x4
    3188:	39c50513          	addi	a0,a0,924 # 7520 <malloc+0x186e>
    318c:	26b020ef          	jal	5bf6 <printf>
    exit(1);
    3190:	4505                	li	a0,1
    3192:	5ee020ef          	jal	5780 <exit>

0000000000003196 <rmdot>:
{
    3196:	1101                	addi	sp,sp,-32
    3198:	ec06                	sd	ra,24(sp)
    319a:	e822                	sd	s0,16(sp)
    319c:	e426                	sd	s1,8(sp)
    319e:	1000                	addi	s0,sp,32
    31a0:	84aa                	mv	s1,a0
  if (mkdir("dots") != 0) {
    31a2:	00004517          	auipc	a0,0x4
    31a6:	39650513          	addi	a0,a0,918 # 7538 <malloc+0x1886>
    31aa:	63e020ef          	jal	57e8 <mkdir>
    31ae:	e53d                	bnez	a0,321c <rmdot+0x86>
  if (chdir("dots") != 0) {
    31b0:	00004517          	auipc	a0,0x4
    31b4:	38850513          	addi	a0,a0,904 # 7538 <malloc+0x1886>
    31b8:	638020ef          	jal	57f0 <chdir>
    31bc:	e935                	bnez	a0,3230 <rmdot+0x9a>
  if (unlink(".") == 0) {
    31be:	00003517          	auipc	a0,0x3
    31c2:	31250513          	addi	a0,a0,786 # 64d0 <malloc+0x81e>
    31c6:	60a020ef          	jal	57d0 <unlink>
    31ca:	cd2d                	beqz	a0,3244 <rmdot+0xae>
  if (unlink("..") == 0) {
    31cc:	00004517          	auipc	a0,0x4
    31d0:	dbc50513          	addi	a0,a0,-580 # 6f88 <malloc+0x12d6>
    31d4:	5fc020ef          	jal	57d0 <unlink>
    31d8:	c141                	beqz	a0,3258 <rmdot+0xc2>
  if (chdir("/") != 0) {
    31da:	00004517          	auipc	a0,0x4
    31de:	d5650513          	addi	a0,a0,-682 # 6f30 <malloc+0x127e>
    31e2:	60e020ef          	jal	57f0 <chdir>
    31e6:	e159                	bnez	a0,326c <rmdot+0xd6>
  if (unlink("dots/.") == 0) {
    31e8:	00004517          	auipc	a0,0x4
    31ec:	3b850513          	addi	a0,a0,952 # 75a0 <malloc+0x18ee>
    31f0:	5e0020ef          	jal	57d0 <unlink>
    31f4:	c551                	beqz	a0,3280 <rmdot+0xea>
  if (unlink("dots/..") == 0) {
    31f6:	00004517          	auipc	a0,0x4
    31fa:	3d250513          	addi	a0,a0,978 # 75c8 <malloc+0x1916>
    31fe:	5d2020ef          	jal	57d0 <unlink>
    3202:	c949                	beqz	a0,3294 <rmdot+0xfe>
  if (unlink("dots") != 0) {
    3204:	00004517          	auipc	a0,0x4
    3208:	33450513          	addi	a0,a0,820 # 7538 <malloc+0x1886>
    320c:	5c4020ef          	jal	57d0 <unlink>
    3210:	ed41                	bnez	a0,32a8 <rmdot+0x112>
}
    3212:	60e2                	ld	ra,24(sp)
    3214:	6442                	ld	s0,16(sp)
    3216:	64a2                	ld	s1,8(sp)
    3218:	6105                	addi	sp,sp,32
    321a:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    321c:	85a6                	mv	a1,s1
    321e:	00004517          	auipc	a0,0x4
    3222:	32250513          	addi	a0,a0,802 # 7540 <malloc+0x188e>
    3226:	1d1020ef          	jal	5bf6 <printf>
    exit(1);
    322a:	4505                	li	a0,1
    322c:	554020ef          	jal	5780 <exit>
    printf("%s: chdir dots failed\n", s);
    3230:	85a6                	mv	a1,s1
    3232:	00004517          	auipc	a0,0x4
    3236:	32650513          	addi	a0,a0,806 # 7558 <malloc+0x18a6>
    323a:	1bd020ef          	jal	5bf6 <printf>
    exit(1);
    323e:	4505                	li	a0,1
    3240:	540020ef          	jal	5780 <exit>
    printf("%s: rm . worked!\n", s);
    3244:	85a6                	mv	a1,s1
    3246:	00004517          	auipc	a0,0x4
    324a:	32a50513          	addi	a0,a0,810 # 7570 <malloc+0x18be>
    324e:	1a9020ef          	jal	5bf6 <printf>
    exit(1);
    3252:	4505                	li	a0,1
    3254:	52c020ef          	jal	5780 <exit>
    printf("%s: rm .. worked!\n", s);
    3258:	85a6                	mv	a1,s1
    325a:	00004517          	auipc	a0,0x4
    325e:	32e50513          	addi	a0,a0,814 # 7588 <malloc+0x18d6>
    3262:	195020ef          	jal	5bf6 <printf>
    exit(1);
    3266:	4505                	li	a0,1
    3268:	518020ef          	jal	5780 <exit>
    printf("%s: chdir / failed\n", s);
    326c:	85a6                	mv	a1,s1
    326e:	00004517          	auipc	a0,0x4
    3272:	cca50513          	addi	a0,a0,-822 # 6f38 <malloc+0x1286>
    3276:	181020ef          	jal	5bf6 <printf>
    exit(1);
    327a:	4505                	li	a0,1
    327c:	504020ef          	jal	5780 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    3280:	85a6                	mv	a1,s1
    3282:	00004517          	auipc	a0,0x4
    3286:	32650513          	addi	a0,a0,806 # 75a8 <malloc+0x18f6>
    328a:	16d020ef          	jal	5bf6 <printf>
    exit(1);
    328e:	4505                	li	a0,1
    3290:	4f0020ef          	jal	5780 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3294:	85a6                	mv	a1,s1
    3296:	00004517          	auipc	a0,0x4
    329a:	33a50513          	addi	a0,a0,826 # 75d0 <malloc+0x191e>
    329e:	159020ef          	jal	5bf6 <printf>
    exit(1);
    32a2:	4505                	li	a0,1
    32a4:	4dc020ef          	jal	5780 <exit>
    printf("%s: unlink dots failed!\n", s);
    32a8:	85a6                	mv	a1,s1
    32aa:	00004517          	auipc	a0,0x4
    32ae:	34650513          	addi	a0,a0,838 # 75f0 <malloc+0x193e>
    32b2:	145020ef          	jal	5bf6 <printf>
    exit(1);
    32b6:	4505                	li	a0,1
    32b8:	4c8020ef          	jal	5780 <exit>

00000000000032bc <dirfile>:
{
    32bc:	1101                	addi	sp,sp,-32
    32be:	ec06                	sd	ra,24(sp)
    32c0:	e822                	sd	s0,16(sp)
    32c2:	e426                	sd	s1,8(sp)
    32c4:	e04a                	sd	s2,0(sp)
    32c6:	1000                	addi	s0,sp,32
    32c8:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    32ca:	20000593          	li	a1,512
    32ce:	00004517          	auipc	a0,0x4
    32d2:	34250513          	addi	a0,a0,834 # 7610 <malloc+0x195e>
    32d6:	4ea020ef          	jal	57c0 <open>
  if (fd < 0) {
    32da:	0c054563          	bltz	a0,33a4 <dirfile+0xe8>
  close(fd);
    32de:	4ca020ef          	jal	57a8 <close>
  if (chdir("dirfile") == 0) {
    32e2:	00004517          	auipc	a0,0x4
    32e6:	32e50513          	addi	a0,a0,814 # 7610 <malloc+0x195e>
    32ea:	506020ef          	jal	57f0 <chdir>
    32ee:	c569                	beqz	a0,33b8 <dirfile+0xfc>
  fd = open("dirfile/xx", 0);
    32f0:	4581                	li	a1,0
    32f2:	00004517          	auipc	a0,0x4
    32f6:	36650513          	addi	a0,a0,870 # 7658 <malloc+0x19a6>
    32fa:	4c6020ef          	jal	57c0 <open>
  if (fd >= 0) {
    32fe:	0c055763          	bgez	a0,33cc <dirfile+0x110>
  fd = open("dirfile/xx", O_CREATE);
    3302:	20000593          	li	a1,512
    3306:	00004517          	auipc	a0,0x4
    330a:	35250513          	addi	a0,a0,850 # 7658 <malloc+0x19a6>
    330e:	4b2020ef          	jal	57c0 <open>
  if (fd >= 0) {
    3312:	0c055763          	bgez	a0,33e0 <dirfile+0x124>
  if (mkdir("dirfile/xx") == 0) {
    3316:	00004517          	auipc	a0,0x4
    331a:	34250513          	addi	a0,a0,834 # 7658 <malloc+0x19a6>
    331e:	4ca020ef          	jal	57e8 <mkdir>
    3322:	0c050963          	beqz	a0,33f4 <dirfile+0x138>
  if (unlink("dirfile/xx") == 0) {
    3326:	00004517          	auipc	a0,0x4
    332a:	33250513          	addi	a0,a0,818 # 7658 <malloc+0x19a6>
    332e:	4a2020ef          	jal	57d0 <unlink>
    3332:	0c050b63          	beqz	a0,3408 <dirfile+0x14c>
  if (link("README", "dirfile/xx") == 0) {
    3336:	00004597          	auipc	a1,0x4
    333a:	32258593          	addi	a1,a1,802 # 7658 <malloc+0x19a6>
    333e:	00003517          	auipc	a0,0x3
    3342:	c8250513          	addi	a0,a0,-894 # 5fc0 <malloc+0x30e>
    3346:	49a020ef          	jal	57e0 <link>
    334a:	0c050963          	beqz	a0,341c <dirfile+0x160>
  if (unlink("dirfile") != 0) {
    334e:	00004517          	auipc	a0,0x4
    3352:	2c250513          	addi	a0,a0,706 # 7610 <malloc+0x195e>
    3356:	47a020ef          	jal	57d0 <unlink>
    335a:	0c051b63          	bnez	a0,3430 <dirfile+0x174>
  fd = open(".", O_RDWR);
    335e:	4589                	li	a1,2
    3360:	00003517          	auipc	a0,0x3
    3364:	17050513          	addi	a0,a0,368 # 64d0 <malloc+0x81e>
    3368:	458020ef          	jal	57c0 <open>
  if (fd >= 0) {
    336c:	0c055c63          	bgez	a0,3444 <dirfile+0x188>
  fd = open(".", 0);
    3370:	4581                	li	a1,0
    3372:	00003517          	auipc	a0,0x3
    3376:	15e50513          	addi	a0,a0,350 # 64d0 <malloc+0x81e>
    337a:	446020ef          	jal	57c0 <open>
    337e:	84aa                	mv	s1,a0
  if (write(fd, "x", 1) > 0) {
    3380:	4605                	li	a2,1
    3382:	00003597          	auipc	a1,0x3
    3386:	ad658593          	addi	a1,a1,-1322 # 5e58 <malloc+0x1a6>
    338a:	416020ef          	jal	57a0 <write>
    338e:	0ca04563          	bgtz	a0,3458 <dirfile+0x19c>
  close(fd);
    3392:	8526                	mv	a0,s1
    3394:	414020ef          	jal	57a8 <close>
}
    3398:	60e2                	ld	ra,24(sp)
    339a:	6442                	ld	s0,16(sp)
    339c:	64a2                	ld	s1,8(sp)
    339e:	6902                	ld	s2,0(sp)
    33a0:	6105                	addi	sp,sp,32
    33a2:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    33a4:	85ca                	mv	a1,s2
    33a6:	00004517          	auipc	a0,0x4
    33aa:	27250513          	addi	a0,a0,626 # 7618 <malloc+0x1966>
    33ae:	049020ef          	jal	5bf6 <printf>
    exit(1);
    33b2:	4505                	li	a0,1
    33b4:	3cc020ef          	jal	5780 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    33b8:	85ca                	mv	a1,s2
    33ba:	00004517          	auipc	a0,0x4
    33be:	27e50513          	addi	a0,a0,638 # 7638 <malloc+0x1986>
    33c2:	035020ef          	jal	5bf6 <printf>
    exit(1);
    33c6:	4505                	li	a0,1
    33c8:	3b8020ef          	jal	5780 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    33cc:	85ca                	mv	a1,s2
    33ce:	00004517          	auipc	a0,0x4
    33d2:	29a50513          	addi	a0,a0,666 # 7668 <malloc+0x19b6>
    33d6:	021020ef          	jal	5bf6 <printf>
    exit(1);
    33da:	4505                	li	a0,1
    33dc:	3a4020ef          	jal	5780 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    33e0:	85ca                	mv	a1,s2
    33e2:	00004517          	auipc	a0,0x4
    33e6:	28650513          	addi	a0,a0,646 # 7668 <malloc+0x19b6>
    33ea:	00d020ef          	jal	5bf6 <printf>
    exit(1);
    33ee:	4505                	li	a0,1
    33f0:	390020ef          	jal	5780 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    33f4:	85ca                	mv	a1,s2
    33f6:	00004517          	auipc	a0,0x4
    33fa:	29a50513          	addi	a0,a0,666 # 7690 <malloc+0x19de>
    33fe:	7f8020ef          	jal	5bf6 <printf>
    exit(1);
    3402:	4505                	li	a0,1
    3404:	37c020ef          	jal	5780 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    3408:	85ca                	mv	a1,s2
    340a:	00004517          	auipc	a0,0x4
    340e:	2ae50513          	addi	a0,a0,686 # 76b8 <malloc+0x1a06>
    3412:	7e4020ef          	jal	5bf6 <printf>
    exit(1);
    3416:	4505                	li	a0,1
    3418:	368020ef          	jal	5780 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    341c:	85ca                	mv	a1,s2
    341e:	00004517          	auipc	a0,0x4
    3422:	2c250513          	addi	a0,a0,706 # 76e0 <malloc+0x1a2e>
    3426:	7d0020ef          	jal	5bf6 <printf>
    exit(1);
    342a:	4505                	li	a0,1
    342c:	354020ef          	jal	5780 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    3430:	85ca                	mv	a1,s2
    3432:	00004517          	auipc	a0,0x4
    3436:	2d650513          	addi	a0,a0,726 # 7708 <malloc+0x1a56>
    343a:	7bc020ef          	jal	5bf6 <printf>
    exit(1);
    343e:	4505                	li	a0,1
    3440:	340020ef          	jal	5780 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    3444:	85ca                	mv	a1,s2
    3446:	00004517          	auipc	a0,0x4
    344a:	2e250513          	addi	a0,a0,738 # 7728 <malloc+0x1a76>
    344e:	7a8020ef          	jal	5bf6 <printf>
    exit(1);
    3452:	4505                	li	a0,1
    3454:	32c020ef          	jal	5780 <exit>
    printf("%s: write . succeeded!\n", s);
    3458:	85ca                	mv	a1,s2
    345a:	00004517          	auipc	a0,0x4
    345e:	2f650513          	addi	a0,a0,758 # 7750 <malloc+0x1a9e>
    3462:	794020ef          	jal	5bf6 <printf>
    exit(1);
    3466:	4505                	li	a0,1
    3468:	318020ef          	jal	5780 <exit>

000000000000346c <iref>:
{
    346c:	715d                	addi	sp,sp,-80
    346e:	e486                	sd	ra,72(sp)
    3470:	e0a2                	sd	s0,64(sp)
    3472:	fc26                	sd	s1,56(sp)
    3474:	f84a                	sd	s2,48(sp)
    3476:	f44e                	sd	s3,40(sp)
    3478:	f052                	sd	s4,32(sp)
    347a:	ec56                	sd	s5,24(sp)
    347c:	e85a                	sd	s6,16(sp)
    347e:	e45e                	sd	s7,8(sp)
    3480:	0880                	addi	s0,sp,80
    3482:	8baa                	mv	s7,a0
    3484:	03300913          	li	s2,51
    if (mkdir("irefd") != 0) {
    3488:	00004a97          	auipc	s5,0x4
    348c:	2e0a8a93          	addi	s5,s5,736 # 7768 <malloc+0x1ab6>
    mkdir("");
    3490:	00004497          	auipc	s1,0x4
    3494:	de048493          	addi	s1,s1,-544 # 7270 <malloc+0x15be>
    link("README", "");
    3498:	00003b17          	auipc	s6,0x3
    349c:	b28b0b13          	addi	s6,s6,-1240 # 5fc0 <malloc+0x30e>
    fd = open("", O_CREATE);
    34a0:	20000a13          	li	s4,512
    fd = open("xx", O_CREATE);
    34a4:	00004997          	auipc	s3,0x4
    34a8:	1bc98993          	addi	s3,s3,444 # 7660 <malloc+0x19ae>
    34ac:	a835                	j	34e8 <iref+0x7c>
      printf("%s: mkdir irefd failed\n", s);
    34ae:	85de                	mv	a1,s7
    34b0:	00004517          	auipc	a0,0x4
    34b4:	2c050513          	addi	a0,a0,704 # 7770 <malloc+0x1abe>
    34b8:	73e020ef          	jal	5bf6 <printf>
      exit(1);
    34bc:	4505                	li	a0,1
    34be:	2c2020ef          	jal	5780 <exit>
      printf("%s: chdir irefd failed\n", s);
    34c2:	85de                	mv	a1,s7
    34c4:	00004517          	auipc	a0,0x4
    34c8:	2c450513          	addi	a0,a0,708 # 7788 <malloc+0x1ad6>
    34cc:	72a020ef          	jal	5bf6 <printf>
      exit(1);
    34d0:	4505                	li	a0,1
    34d2:	2ae020ef          	jal	5780 <exit>
      close(fd);
    34d6:	2d2020ef          	jal	57a8 <close>
    34da:	a825                	j	3512 <iref+0xa6>
    unlink("xx");
    34dc:	854e                	mv	a0,s3
    34de:	2f2020ef          	jal	57d0 <unlink>
  for (i = 0; i < NINODE + 1; i++) {
    34e2:	397d                	addiw	s2,s2,-1
    34e4:	04090063          	beqz	s2,3524 <iref+0xb8>
    if (mkdir("irefd") != 0) {
    34e8:	8556                	mv	a0,s5
    34ea:	2fe020ef          	jal	57e8 <mkdir>
    34ee:	f161                	bnez	a0,34ae <iref+0x42>
    if (chdir("irefd") != 0) {
    34f0:	8556                	mv	a0,s5
    34f2:	2fe020ef          	jal	57f0 <chdir>
    34f6:	f571                	bnez	a0,34c2 <iref+0x56>
    mkdir("");
    34f8:	8526                	mv	a0,s1
    34fa:	2ee020ef          	jal	57e8 <mkdir>
    link("README", "");
    34fe:	85a6                	mv	a1,s1
    3500:	855a                	mv	a0,s6
    3502:	2de020ef          	jal	57e0 <link>
    fd = open("", O_CREATE);
    3506:	85d2                	mv	a1,s4
    3508:	8526                	mv	a0,s1
    350a:	2b6020ef          	jal	57c0 <open>
    if (fd >= 0)
    350e:	fc0554e3          	bgez	a0,34d6 <iref+0x6a>
    fd = open("xx", O_CREATE);
    3512:	85d2                	mv	a1,s4
    3514:	854e                	mv	a0,s3
    3516:	2aa020ef          	jal	57c0 <open>
    if (fd >= 0)
    351a:	fc0541e3          	bltz	a0,34dc <iref+0x70>
      close(fd);
    351e:	28a020ef          	jal	57a8 <close>
    3522:	bf6d                	j	34dc <iref+0x70>
  for (i = 0; i < NINODE + 1; i++) {
    3524:	03300493          	li	s1,51
    chdir("..");
    3528:	00004997          	auipc	s3,0x4
    352c:	a6098993          	addi	s3,s3,-1440 # 6f88 <malloc+0x12d6>
    unlink("irefd");
    3530:	00004917          	auipc	s2,0x4
    3534:	23890913          	addi	s2,s2,568 # 7768 <malloc+0x1ab6>
    chdir("..");
    3538:	854e                	mv	a0,s3
    353a:	2b6020ef          	jal	57f0 <chdir>
    unlink("irefd");
    353e:	854a                	mv	a0,s2
    3540:	290020ef          	jal	57d0 <unlink>
  for (i = 0; i < NINODE + 1; i++) {
    3544:	34fd                	addiw	s1,s1,-1
    3546:	f8ed                	bnez	s1,3538 <iref+0xcc>
  chdir("/");
    3548:	00004517          	auipc	a0,0x4
    354c:	9e850513          	addi	a0,a0,-1560 # 6f30 <malloc+0x127e>
    3550:	2a0020ef          	jal	57f0 <chdir>
}
    3554:	60a6                	ld	ra,72(sp)
    3556:	6406                	ld	s0,64(sp)
    3558:	74e2                	ld	s1,56(sp)
    355a:	7942                	ld	s2,48(sp)
    355c:	79a2                	ld	s3,40(sp)
    355e:	7a02                	ld	s4,32(sp)
    3560:	6ae2                	ld	s5,24(sp)
    3562:	6b42                	ld	s6,16(sp)
    3564:	6ba2                	ld	s7,8(sp)
    3566:	6161                	addi	sp,sp,80
    3568:	8082                	ret

000000000000356a <unlinkcwd>:
{
    356a:	1101                	addi	sp,sp,-32
    356c:	ec06                	sd	ra,24(sp)
    356e:	e822                	sd	s0,16(sp)
    3570:	e426                	sd	s1,8(sp)
    3572:	1000                	addi	s0,sp,32
    3574:	84aa                	mv	s1,a0
  if (mkdir("/a") < 0) {
    3576:	00004517          	auipc	a0,0x4
    357a:	22a50513          	addi	a0,a0,554 # 77a0 <malloc+0x1aee>
    357e:	26a020ef          	jal	57e8 <mkdir>
    3582:	06054a63          	bltz	a0,35f6 <unlinkcwd+0x8c>
  if (mkdir("/a/b") < 0) {
    3586:	00004517          	auipc	a0,0x4
    358a:	23a50513          	addi	a0,a0,570 # 77c0 <malloc+0x1b0e>
    358e:	25a020ef          	jal	57e8 <mkdir>
    3592:	06054c63          	bltz	a0,360a <unlinkcwd+0xa0>
  if (chdir("/a/b") < 0) {
    3596:	00004517          	auipc	a0,0x4
    359a:	22a50513          	addi	a0,a0,554 # 77c0 <malloc+0x1b0e>
    359e:	252020ef          	jal	57f0 <chdir>
    35a2:	06054e63          	bltz	a0,361e <unlinkcwd+0xb4>
  if (unlink("/a/b") < 0) {
    35a6:	00004517          	auipc	a0,0x4
    35aa:	21a50513          	addi	a0,a0,538 # 77c0 <malloc+0x1b0e>
    35ae:	222020ef          	jal	57d0 <unlink>
    35b2:	08054063          	bltz	a0,3632 <unlinkcwd+0xc8>
  if (unlink("/a") < 0) {
    35b6:	00004517          	auipc	a0,0x4
    35ba:	1ea50513          	addi	a0,a0,490 # 77a0 <malloc+0x1aee>
    35be:	212020ef          	jal	57d0 <unlink>
    35c2:	08054263          	bltz	a0,3646 <unlinkcwd+0xdc>
  if (open("../", O_RDONLY) > 0) {
    35c6:	4581                	li	a1,0
    35c8:	00004517          	auipc	a0,0x4
    35cc:	26050513          	addi	a0,a0,608 # 7828 <malloc+0x1b76>
    35d0:	1f0020ef          	jal	57c0 <open>
    35d4:	08a04363          	bgtz	a0,365a <unlinkcwd+0xf0>
  if (open("../c", O_CREATE) > 0) {
    35d8:	20000593          	li	a1,512
    35dc:	00004517          	auipc	a0,0x4
    35e0:	27c50513          	addi	a0,a0,636 # 7858 <malloc+0x1ba6>
    35e4:	1dc020ef          	jal	57c0 <open>
    35e8:	08a04163          	bgtz	a0,366a <unlinkcwd+0x100>
}
    35ec:	60e2                	ld	ra,24(sp)
    35ee:	6442                	ld	s0,16(sp)
    35f0:	64a2                	ld	s1,8(sp)
    35f2:	6105                	addi	sp,sp,32
    35f4:	8082                	ret
    printf("%s: mkdir /a failed\n", s);
    35f6:	85a6                	mv	a1,s1
    35f8:	00004517          	auipc	a0,0x4
    35fc:	1b050513          	addi	a0,a0,432 # 77a8 <malloc+0x1af6>
    3600:	5f6020ef          	jal	5bf6 <printf>
    exit(1);
    3604:	4505                	li	a0,1
    3606:	17a020ef          	jal	5780 <exit>
    printf("%s: mkdir /a/b failed\n", s);
    360a:	85a6                	mv	a1,s1
    360c:	00004517          	auipc	a0,0x4
    3610:	1bc50513          	addi	a0,a0,444 # 77c8 <malloc+0x1b16>
    3614:	5e2020ef          	jal	5bf6 <printf>
    exit(1);
    3618:	4505                	li	a0,1
    361a:	166020ef          	jal	5780 <exit>
    printf("%s: chdir failed\n", s);
    361e:	85a6                	mv	a1,s1
    3620:	00004517          	auipc	a0,0x4
    3624:	1c050513          	addi	a0,a0,448 # 77e0 <malloc+0x1b2e>
    3628:	5ce020ef          	jal	5bf6 <printf>
    exit(1);
    362c:	4505                	li	a0,1
    362e:	152020ef          	jal	5780 <exit>
    printf("%s: unlink /a/b failed\n", s);
    3632:	85a6                	mv	a1,s1
    3634:	00004517          	auipc	a0,0x4
    3638:	1c450513          	addi	a0,a0,452 # 77f8 <malloc+0x1b46>
    363c:	5ba020ef          	jal	5bf6 <printf>
    exit(1);
    3640:	4505                	li	a0,1
    3642:	13e020ef          	jal	5780 <exit>
    printf("%s: unlink /a failed\n", s);
    3646:	85a6                	mv	a1,s1
    3648:	00004517          	auipc	a0,0x4
    364c:	1c850513          	addi	a0,a0,456 # 7810 <malloc+0x1b5e>
    3650:	5a6020ef          	jal	5bf6 <printf>
    exit(1);
    3654:	4505                	li	a0,1
    3656:	12a020ef          	jal	5780 <exit>
    printf("%s: open ../ non-existing directory\n", s);
    365a:	85a6                	mv	a1,s1
    365c:	00004517          	auipc	a0,0x4
    3660:	1d450513          	addi	a0,a0,468 # 7830 <malloc+0x1b7e>
    3664:	592020ef          	jal	5bf6 <printf>
    3668:	bf85                	j	35d8 <unlinkcwd+0x6e>
    printf("%s: create ../c non-existing file\n", s);
    366a:	85a6                	mv	a1,s1
    366c:	00004517          	auipc	a0,0x4
    3670:	1f450513          	addi	a0,a0,500 # 7860 <malloc+0x1bae>
    3674:	582020ef          	jal	5bf6 <printf>
}
    3678:	bf95                	j	35ec <unlinkcwd+0x82>

000000000000367a <openiputtest>:
{
    367a:	7179                	addi	sp,sp,-48
    367c:	f406                	sd	ra,40(sp)
    367e:	f022                	sd	s0,32(sp)
    3680:	ec26                	sd	s1,24(sp)
    3682:	1800                	addi	s0,sp,48
    3684:	84aa                	mv	s1,a0
  if (mkdir("oidir") < 0) {
    3686:	00004517          	auipc	a0,0x4
    368a:	20250513          	addi	a0,a0,514 # 7888 <malloc+0x1bd6>
    368e:	15a020ef          	jal	57e8 <mkdir>
    3692:	02054a63          	bltz	a0,36c6 <openiputtest+0x4c>
  pid = fork();
    3696:	0e2020ef          	jal	5778 <fork>
  if (pid < 0) {
    369a:	04054063          	bltz	a0,36da <openiputtest+0x60>
  if (pid == 0) {
    369e:	e939                	bnez	a0,36f4 <openiputtest+0x7a>
    int fd = open("oidir", O_RDWR);
    36a0:	4589                	li	a1,2
    36a2:	00004517          	auipc	a0,0x4
    36a6:	1e650513          	addi	a0,a0,486 # 7888 <malloc+0x1bd6>
    36aa:	116020ef          	jal	57c0 <open>
    if (fd >= 0) {
    36ae:	04054063          	bltz	a0,36ee <openiputtest+0x74>
      printf("%s: open directory for write succeeded\n", s);
    36b2:	85a6                	mv	a1,s1
    36b4:	00004517          	auipc	a0,0x4
    36b8:	1f450513          	addi	a0,a0,500 # 78a8 <malloc+0x1bf6>
    36bc:	53a020ef          	jal	5bf6 <printf>
      exit(1);
    36c0:	4505                	li	a0,1
    36c2:	0be020ef          	jal	5780 <exit>
    printf("%s: mkdir oidir failed\n", s);
    36c6:	85a6                	mv	a1,s1
    36c8:	00004517          	auipc	a0,0x4
    36cc:	1c850513          	addi	a0,a0,456 # 7890 <malloc+0x1bde>
    36d0:	526020ef          	jal	5bf6 <printf>
    exit(1);
    36d4:	4505                	li	a0,1
    36d6:	0aa020ef          	jal	5780 <exit>
    printf("%s: fork failed\n", s);
    36da:	85a6                	mv	a1,s1
    36dc:	00003517          	auipc	a0,0x3
    36e0:	f9c50513          	addi	a0,a0,-100 # 6678 <malloc+0x9c6>
    36e4:	512020ef          	jal	5bf6 <printf>
    exit(1);
    36e8:	4505                	li	a0,1
    36ea:	096020ef          	jal	5780 <exit>
    exit(0);
    36ee:	4501                	li	a0,0
    36f0:	090020ef          	jal	5780 <exit>
  pause(1);
    36f4:	4505                	li	a0,1
    36f6:	11a020ef          	jal	5810 <pause>
  if (unlink("oidir") != 0) {
    36fa:	00004517          	auipc	a0,0x4
    36fe:	18e50513          	addi	a0,a0,398 # 7888 <malloc+0x1bd6>
    3702:	0ce020ef          	jal	57d0 <unlink>
    3706:	c919                	beqz	a0,371c <openiputtest+0xa2>
    printf("%s: unlink failed\n", s);
    3708:	85a6                	mv	a1,s1
    370a:	00003517          	auipc	a0,0x3
    370e:	0f650513          	addi	a0,a0,246 # 6800 <malloc+0xb4e>
    3712:	4e4020ef          	jal	5bf6 <printf>
    exit(1);
    3716:	4505                	li	a0,1
    3718:	068020ef          	jal	5780 <exit>
  wait(&xstatus);
    371c:	fdc40513          	addi	a0,s0,-36
    3720:	068020ef          	jal	5788 <wait>
  exit(xstatus);
    3724:	fdc42503          	lw	a0,-36(s0)
    3728:	058020ef          	jal	5780 <exit>

000000000000372c <forkforkfork>:
{
    372c:	1101                	addi	sp,sp,-32
    372e:	ec06                	sd	ra,24(sp)
    3730:	e822                	sd	s0,16(sp)
    3732:	e426                	sd	s1,8(sp)
    3734:	1000                	addi	s0,sp,32
    3736:	84aa                	mv	s1,a0
  unlink("stopforking");
    3738:	00004517          	auipc	a0,0x4
    373c:	19850513          	addi	a0,a0,408 # 78d0 <malloc+0x1c1e>
    3740:	090020ef          	jal	57d0 <unlink>
  int pid = fork();
    3744:	034020ef          	jal	5778 <fork>
  if (pid < 0) {
    3748:	02054b63          	bltz	a0,377e <forkforkfork+0x52>
  if (pid == 0) {
    374c:	c125                	beqz	a0,37ac <forkforkfork+0x80>
  pause(20); // two seconds
    374e:	4551                	li	a0,20
    3750:	0c0020ef          	jal	5810 <pause>
  close(open("stopforking", O_CREATE | O_RDWR));
    3754:	20200593          	li	a1,514
    3758:	00004517          	auipc	a0,0x4
    375c:	17850513          	addi	a0,a0,376 # 78d0 <malloc+0x1c1e>
    3760:	060020ef          	jal	57c0 <open>
    3764:	044020ef          	jal	57a8 <close>
  wait(0);
    3768:	4501                	li	a0,0
    376a:	01e020ef          	jal	5788 <wait>
  pause(10); // one second
    376e:	4529                	li	a0,10
    3770:	0a0020ef          	jal	5810 <pause>
}
    3774:	60e2                	ld	ra,24(sp)
    3776:	6442                	ld	s0,16(sp)
    3778:	64a2                	ld	s1,8(sp)
    377a:	6105                	addi	sp,sp,32
    377c:	8082                	ret
    printf("%s: fork failed", s);
    377e:	85a6                	mv	a1,s1
    3780:	00003517          	auipc	a0,0x3
    3784:	03850513          	addi	a0,a0,56 # 67b8 <malloc+0xb06>
    3788:	46e020ef          	jal	5bf6 <printf>
    exit(1);
    378c:	4505                	li	a0,1
    378e:	7f3010ef          	jal	5780 <exit>
        exit(0);
    3792:	4501                	li	a0,0
    3794:	7ed010ef          	jal	5780 <exit>
        close(open("stopforking", O_CREATE | O_RDWR));
    3798:	20200593          	li	a1,514
    379c:	00004517          	auipc	a0,0x4
    37a0:	13450513          	addi	a0,a0,308 # 78d0 <malloc+0x1c1e>
    37a4:	01c020ef          	jal	57c0 <open>
    37a8:	000020ef          	jal	57a8 <close>
      int fd = open("stopforking", 0);
    37ac:	4581                	li	a1,0
    37ae:	00004517          	auipc	a0,0x4
    37b2:	12250513          	addi	a0,a0,290 # 78d0 <malloc+0x1c1e>
    37b6:	00a020ef          	jal	57c0 <open>
      if (fd >= 0) {
    37ba:	fc055ce3          	bgez	a0,3792 <forkforkfork+0x66>
      if (fork() < 0) {
    37be:	7bb010ef          	jal	5778 <fork>
    37c2:	fe0555e3          	bgez	a0,37ac <forkforkfork+0x80>
    37c6:	bfc9                	j	3798 <forkforkfork+0x6c>

00000000000037c8 <exectest>:
{
    37c8:	711d                	addi	sp,sp,-96
    37ca:	ec86                	sd	ra,88(sp)
    37cc:	e8a2                	sd	s0,80(sp)
    37ce:	e0ca                	sd	s2,64(sp)
    37d0:	1080                	addi	s0,sp,96
    37d2:	892a                	mv	s2,a0
  char *echoargv[] = {"echo", "OK", 0};
    37d4:	00002797          	auipc	a5,0x2
    37d8:	61478793          	addi	a5,a5,1556 # 5de8 <malloc+0x136>
    37dc:	faf43823          	sd	a5,-80(s0)
    37e0:	00004797          	auipc	a5,0x4
    37e4:	10078793          	addi	a5,a5,256 # 78e0 <malloc+0x1c2e>
    37e8:	faf43c23          	sd	a5,-72(s0)
    37ec:	fc043023          	sd	zero,-64(s0)
  unlink("echo-ok");
    37f0:	00004517          	auipc	a0,0x4
    37f4:	0f850513          	addi	a0,a0,248 # 78e8 <malloc+0x1c36>
    37f8:	7d9010ef          	jal	57d0 <unlink>
  pid = fork();
    37fc:	77d010ef          	jal	5778 <fork>
  if (pid < 0) {
    3800:	04054763          	bltz	a0,384e <exectest+0x86>
    3804:	e4a6                	sd	s1,72(sp)
    3806:	fc4e                	sd	s3,56(sp)
    3808:	84aa                	mv	s1,a0
  if (pid == 0) {
    380a:	ed49                	bnez	a0,38a4 <exectest+0xdc>
    int errfd = dup(1);
    380c:	4505                	li	a0,1
    380e:	7eb010ef          	jal	57f8 <dup>
    3812:	89aa                	mv	s3,a0
    if (errfd < 0) {
    3814:	04054963          	bltz	a0,3866 <exectest+0x9e>
    close(1);
    3818:	4505                	li	a0,1
    381a:	78f010ef          	jal	57a8 <close>
    fd = open("echo-ok", O_CREATE | O_WRONLY);
    381e:	20100593          	li	a1,513
    3822:	00004517          	auipc	a0,0x4
    3826:	0c650513          	addi	a0,a0,198 # 78e8 <malloc+0x1c36>
    382a:	797010ef          	jal	57c0 <open>
    if (fd < 0) {
    382e:	04054663          	bltz	a0,387a <exectest+0xb2>
    if (fd != 1) {
    3832:	4785                	li	a5,1
    3834:	04f50e63          	beq	a0,a5,3890 <exectest+0xc8>
      fprintf(errfd, "%s: wrong fd\n", s);
    3838:	864a                	mv	a2,s2
    383a:	00004597          	auipc	a1,0x4
    383e:	0c658593          	addi	a1,a1,198 # 7900 <malloc+0x1c4e>
    3842:	854e                	mv	a0,s3
    3844:	388020ef          	jal	5bcc <fprintf>
      exit(1);
    3848:	4505                	li	a0,1
    384a:	737010ef          	jal	5780 <exit>
    384e:	e4a6                	sd	s1,72(sp)
    3850:	fc4e                	sd	s3,56(sp)
    printf("%s: fork failed\n", s);
    3852:	85ca                	mv	a1,s2
    3854:	00003517          	auipc	a0,0x3
    3858:	e2450513          	addi	a0,a0,-476 # 6678 <malloc+0x9c6>
    385c:	39a020ef          	jal	5bf6 <printf>
    exit(1);
    3860:	4505                	li	a0,1
    3862:	71f010ef          	jal	5780 <exit>
      printf("%s: dup failed\n", s);
    3866:	85ca                	mv	a1,s2
    3868:	00004517          	auipc	a0,0x4
    386c:	08850513          	addi	a0,a0,136 # 78f0 <malloc+0x1c3e>
    3870:	386020ef          	jal	5bf6 <printf>
      exit(1);
    3874:	4505                	li	a0,1
    3876:	70b010ef          	jal	5780 <exit>
      fprintf(errfd, "%s: create failed\n", s);
    387a:	864a                	mv	a2,s2
    387c:	00003597          	auipc	a1,0x3
    3880:	f6c58593          	addi	a1,a1,-148 # 67e8 <malloc+0xb36>
    3884:	854e                	mv	a0,s3
    3886:	346020ef          	jal	5bcc <fprintf>
      exit(1);
    388a:	4505                	li	a0,1
    388c:	6f5010ef          	jal	5780 <exit>
    if (exec("echo", echoargv) < 0) {
    3890:	fb040593          	addi	a1,s0,-80
    3894:	00002517          	auipc	a0,0x2
    3898:	55450513          	addi	a0,a0,1364 # 5de8 <malloc+0x136>
    389c:	71d010ef          	jal	57b8 <exec>
    38a0:	02054563          	bltz	a0,38ca <exectest+0x102>
  if (wait(&xstatus) != pid) {
    38a4:	fcc40513          	addi	a0,s0,-52
    38a8:	6e1010ef          	jal	5788 <wait>
    38ac:	02951a63          	bne	a0,s1,38e0 <exectest+0x118>
  if (xstatus != 0) {
    38b0:	fcc42603          	lw	a2,-52(s0)
    38b4:	ce15                	beqz	a2,38f0 <exectest+0x128>
    printf("%s: nonzero wait status %d\n", s, xstatus);
    38b6:	85ca                	mv	a1,s2
    38b8:	00004517          	auipc	a0,0x4
    38bc:	08850513          	addi	a0,a0,136 # 7940 <malloc+0x1c8e>
    38c0:	336020ef          	jal	5bf6 <printf>
    exit(1);
    38c4:	4505                	li	a0,1
    38c6:	6bb010ef          	jal	5780 <exit>
      fprintf(errfd, "%s: exec echo failed\n", s);
    38ca:	864a                	mv	a2,s2
    38cc:	00004597          	auipc	a1,0x4
    38d0:	04458593          	addi	a1,a1,68 # 7910 <malloc+0x1c5e>
    38d4:	854e                	mv	a0,s3
    38d6:	2f6020ef          	jal	5bcc <fprintf>
      exit(1);
    38da:	4505                	li	a0,1
    38dc:	6a5010ef          	jal	5780 <exit>
    printf("%s: wait failed!\n", s);
    38e0:	85ca                	mv	a1,s2
    38e2:	00004517          	auipc	a0,0x4
    38e6:	04650513          	addi	a0,a0,70 # 7928 <malloc+0x1c76>
    38ea:	30c020ef          	jal	5bf6 <printf>
    38ee:	b7c9                	j	38b0 <exectest+0xe8>
  fd = open("echo-ok", O_RDONLY);
    38f0:	4581                	li	a1,0
    38f2:	00004517          	auipc	a0,0x4
    38f6:	ff650513          	addi	a0,a0,-10 # 78e8 <malloc+0x1c36>
    38fa:	6c7010ef          	jal	57c0 <open>
  if (fd < 0) {
    38fe:	02054463          	bltz	a0,3926 <exectest+0x15e>
  if (read(fd, buf, 2) != 2) {
    3902:	4609                	li	a2,2
    3904:	fa840593          	addi	a1,s0,-88
    3908:	691010ef          	jal	5798 <read>
    390c:	4789                	li	a5,2
    390e:	02f50663          	beq	a0,a5,393a <exectest+0x172>
    printf("%s: read failed\n", s);
    3912:	85ca                	mv	a1,s2
    3914:	00003517          	auipc	a0,0x3
    3918:	8a450513          	addi	a0,a0,-1884 # 61b8 <malloc+0x506>
    391c:	2da020ef          	jal	5bf6 <printf>
    exit(1);
    3920:	4505                	li	a0,1
    3922:	65f010ef          	jal	5780 <exit>
    printf("%s: open failed\n", s);
    3926:	85ca                	mv	a1,s2
    3928:	00003517          	auipc	a0,0x3
    392c:	d6850513          	addi	a0,a0,-664 # 6690 <malloc+0x9de>
    3930:	2c6020ef          	jal	5bf6 <printf>
    exit(1);
    3934:	4505                	li	a0,1
    3936:	64b010ef          	jal	5780 <exit>
  unlink("echo-ok");
    393a:	00004517          	auipc	a0,0x4
    393e:	fae50513          	addi	a0,a0,-82 # 78e8 <malloc+0x1c36>
    3942:	68f010ef          	jal	57d0 <unlink>
  if (buf[0] == 'O' && buf[1] == 'K')
    3946:	fa844703          	lbu	a4,-88(s0)
    394a:	04f00793          	li	a5,79
    394e:	00f71863          	bne	a4,a5,395e <exectest+0x196>
    3952:	fa944703          	lbu	a4,-87(s0)
    3956:	04b00793          	li	a5,75
    395a:	00f70c63          	beq	a4,a5,3972 <exectest+0x1aa>
    printf("%s: wrong output\n", s);
    395e:	85ca                	mv	a1,s2
    3960:	00004517          	auipc	a0,0x4
    3964:	00050513          	mv	a0,a0
    3968:	28e020ef          	jal	5bf6 <printf>
    exit(1);
    396c:	4505                	li	a0,1
    396e:	613010ef          	jal	5780 <exit>
    exit(0);
    3972:	4501                	li	a0,0
    3974:	60d010ef          	jal	5780 <exit>

0000000000003978 <killstatus>:
{
    3978:	715d                	addi	sp,sp,-80
    397a:	e486                	sd	ra,72(sp)
    397c:	e0a2                	sd	s0,64(sp)
    397e:	fc26                	sd	s1,56(sp)
    3980:	f84a                	sd	s2,48(sp)
    3982:	f44e                	sd	s3,40(sp)
    3984:	f052                	sd	s4,32(sp)
    3986:	ec56                	sd	s5,24(sp)
    3988:	e85a                	sd	s6,16(sp)
    398a:	0880                	addi	s0,sp,80
    398c:	8b2a                	mv	s6,a0
    398e:	06400913          	li	s2,100
    pause(1);
    3992:	4a85                	li	s5,1
    wait(&xst);
    3994:	fbc40a13          	addi	s4,s0,-68
    if (xst != -1) {
    3998:	59fd                	li	s3,-1
    int pid1 = fork();
    399a:	5df010ef          	jal	5778 <fork>
    399e:	84aa                	mv	s1,a0
    if (pid1 < 0) {
    39a0:	02054663          	bltz	a0,39cc <killstatus+0x54>
    if (pid1 == 0) {
    39a4:	cd15                	beqz	a0,39e0 <killstatus+0x68>
    pause(1);
    39a6:	8556                	mv	a0,s5
    39a8:	669010ef          	jal	5810 <pause>
    kill(pid1);
    39ac:	8526                	mv	a0,s1
    39ae:	603010ef          	jal	57b0 <kill>
    wait(&xst);
    39b2:	8552                	mv	a0,s4
    39b4:	5d5010ef          	jal	5788 <wait>
    if (xst != -1) {
    39b8:	fbc42783          	lw	a5,-68(s0)
    39bc:	03379563          	bne	a5,s3,39e6 <killstatus+0x6e>
  for (int i = 0; i < 100; i++) {
    39c0:	397d                	addiw	s2,s2,-1
    39c2:	fc091ce3          	bnez	s2,399a <killstatus+0x22>
  exit(0);
    39c6:	4501                	li	a0,0
    39c8:	5b9010ef          	jal	5780 <exit>
      printf("%s: fork failed\n", s);
    39cc:	85da                	mv	a1,s6
    39ce:	00003517          	auipc	a0,0x3
    39d2:	caa50513          	addi	a0,a0,-854 # 6678 <malloc+0x9c6>
    39d6:	220020ef          	jal	5bf6 <printf>
      exit(1);
    39da:	4505                	li	a0,1
    39dc:	5a5010ef          	jal	5780 <exit>
        getpid();
    39e0:	621010ef          	jal	5800 <getpid>
      while (1) {
    39e4:	bff5                	j	39e0 <killstatus+0x68>
      printf("%s: status should be -1\n", s);
    39e6:	85da                	mv	a1,s6
    39e8:	00004517          	auipc	a0,0x4
    39ec:	f9050513          	addi	a0,a0,-112 # 7978 <malloc+0x1cc6>
    39f0:	206020ef          	jal	5bf6 <printf>
      exit(1);
    39f4:	4505                	li	a0,1
    39f6:	58b010ef          	jal	5780 <exit>

00000000000039fa <killzero>:
{
    39fa:	7179                	addi	sp,sp,-48
    39fc:	f406                	sd	ra,40(sp)
    39fe:	f022                	sd	s0,32(sp)
    3a00:	e84a                	sd	s2,16(sp)
    3a02:	1800                	addi	s0,sp,48
    3a04:	892a                	mv	s2,a0
  kill(0);
    3a06:	4501                	li	a0,0
    3a08:	5a9010ef          	jal	57b0 <kill>
  pid = fork();
    3a0c:	56d010ef          	jal	5778 <fork>
  if (pid < 0) {
    3a10:	00054863          	bltz	a0,3a20 <killzero+0x26>
    3a14:	ec26                	sd	s1,24(sp)
    3a16:	84aa                	mv	s1,a0
  if (pid == 0) {
    3a18:	ed19                	bnez	a0,3a36 <killzero+0x3c>
    exit(7);
    3a1a:	451d                	li	a0,7
    3a1c:	565010ef          	jal	5780 <exit>
    3a20:	ec26                	sd	s1,24(sp)
    printf("%s: fork failed\n", s);
    3a22:	85ca                	mv	a1,s2
    3a24:	00003517          	auipc	a0,0x3
    3a28:	c5450513          	addi	a0,a0,-940 # 6678 <malloc+0x9c6>
    3a2c:	1ca020ef          	jal	5bf6 <printf>
    exit(1);
    3a30:	4505                	li	a0,1
    3a32:	54f010ef          	jal	5780 <exit>
  if (wait(&xst) != pid) {
    3a36:	fdc40513          	addi	a0,s0,-36
    3a3a:	54f010ef          	jal	5788 <wait>
    3a3e:	02951163          	bne	a0,s1,3a60 <killzero+0x66>
  if (xst != 7) {
    3a42:	fdc42603          	lw	a2,-36(s0)
    3a46:	479d                	li	a5,7
    3a48:	02f60663          	beq	a2,a5,3a74 <killzero+0x7a>
    printf("%s: child exited with status %d, expected 7\n", s, xst);
    3a4c:	85ca                	mv	a1,s2
    3a4e:	00004517          	auipc	a0,0x4
    3a52:	f4a50513          	addi	a0,a0,-182 # 7998 <malloc+0x1ce6>
    3a56:	1a0020ef          	jal	5bf6 <printf>
    exit(1);
    3a5a:	4505                	li	a0,1
    3a5c:	525010ef          	jal	5780 <exit>
    printf("%s: wait wrong pid\n", s);
    3a60:	85ca                	mv	a1,s2
    3a62:	00003517          	auipc	a0,0x3
    3a66:	d1e50513          	addi	a0,a0,-738 # 6780 <malloc+0xace>
    3a6a:	18c020ef          	jal	5bf6 <printf>
    exit(1);
    3a6e:	4505                	li	a0,1
    3a70:	511010ef          	jal	5780 <exit>
  exit(0);
    3a74:	4501                	li	a0,0
    3a76:	50b010ef          	jal	5780 <exit>

0000000000003a7a <preempt>:
{
    3a7a:	7139                	addi	sp,sp,-64
    3a7c:	fc06                	sd	ra,56(sp)
    3a7e:	f822                	sd	s0,48(sp)
    3a80:	f426                	sd	s1,40(sp)
    3a82:	f04a                	sd	s2,32(sp)
    3a84:	ec4e                	sd	s3,24(sp)
    3a86:	e852                	sd	s4,16(sp)
    3a88:	0080                	addi	s0,sp,64
    3a8a:	892a                	mv	s2,a0
  pid1 = fork();
    3a8c:	4ed010ef          	jal	5778 <fork>
  if (pid1 < 0) {
    3a90:	00054563          	bltz	a0,3a9a <preempt+0x20>
    3a94:	84aa                	mv	s1,a0
  if (pid1 == 0)
    3a96:	ed01                	bnez	a0,3aae <preempt+0x34>
    for (;;)
    3a98:	a001                	j	3a98 <preempt+0x1e>
    printf("%s: fork failed", s);
    3a9a:	85ca                	mv	a1,s2
    3a9c:	00003517          	auipc	a0,0x3
    3aa0:	d1c50513          	addi	a0,a0,-740 # 67b8 <malloc+0xb06>
    3aa4:	152020ef          	jal	5bf6 <printf>
    exit(1);
    3aa8:	4505                	li	a0,1
    3aaa:	4d7010ef          	jal	5780 <exit>
  pid2 = fork();
    3aae:	4cb010ef          	jal	5778 <fork>
    3ab2:	89aa                	mv	s3,a0
  if (pid2 < 0) {
    3ab4:	00054463          	bltz	a0,3abc <preempt+0x42>
  if (pid2 == 0)
    3ab8:	ed01                	bnez	a0,3ad0 <preempt+0x56>
    for (;;)
    3aba:	a001                	j	3aba <preempt+0x40>
    printf("%s: fork failed\n", s);
    3abc:	85ca                	mv	a1,s2
    3abe:	00003517          	auipc	a0,0x3
    3ac2:	bba50513          	addi	a0,a0,-1094 # 6678 <malloc+0x9c6>
    3ac6:	130020ef          	jal	5bf6 <printf>
    exit(1);
    3aca:	4505                	li	a0,1
    3acc:	4b5010ef          	jal	5780 <exit>
  pipe(pfds);
    3ad0:	fc840513          	addi	a0,s0,-56
    3ad4:	4bd010ef          	jal	5790 <pipe>
  pid3 = fork();
    3ad8:	4a1010ef          	jal	5778 <fork>
    3adc:	8a2a                	mv	s4,a0
  if (pid3 < 0) {
    3ade:	02054863          	bltz	a0,3b0e <preempt+0x94>
  if (pid3 == 0) {
    3ae2:	e921                	bnez	a0,3b32 <preempt+0xb8>
    close(pfds[0]);
    3ae4:	fc842503          	lw	a0,-56(s0)
    3ae8:	4c1010ef          	jal	57a8 <close>
    if (write(pfds[1], "x", 1) != 1)
    3aec:	4605                	li	a2,1
    3aee:	00002597          	auipc	a1,0x2
    3af2:	36a58593          	addi	a1,a1,874 # 5e58 <malloc+0x1a6>
    3af6:	fcc42503          	lw	a0,-52(s0)
    3afa:	4a7010ef          	jal	57a0 <write>
    3afe:	4785                	li	a5,1
    3b00:	02f51163          	bne	a0,a5,3b22 <preempt+0xa8>
    close(pfds[1]);
    3b04:	fcc42503          	lw	a0,-52(s0)
    3b08:	4a1010ef          	jal	57a8 <close>
    for (;;)
    3b0c:	a001                	j	3b0c <preempt+0x92>
    printf("%s: fork failed\n", s);
    3b0e:	85ca                	mv	a1,s2
    3b10:	00003517          	auipc	a0,0x3
    3b14:	b6850513          	addi	a0,a0,-1176 # 6678 <malloc+0x9c6>
    3b18:	0de020ef          	jal	5bf6 <printf>
    exit(1);
    3b1c:	4505                	li	a0,1
    3b1e:	463010ef          	jal	5780 <exit>
      printf("%s: preempt write error", s);
    3b22:	85ca                	mv	a1,s2
    3b24:	00004517          	auipc	a0,0x4
    3b28:	ea450513          	addi	a0,a0,-348 # 79c8 <malloc+0x1d16>
    3b2c:	0ca020ef          	jal	5bf6 <printf>
    3b30:	bfd1                	j	3b04 <preempt+0x8a>
  close(pfds[1]);
    3b32:	fcc42503          	lw	a0,-52(s0)
    3b36:	473010ef          	jal	57a8 <close>
  if (read(pfds[0], buf, sizeof(buf)) != 1) {
    3b3a:	6655                	lui	a2,0x15
    3b3c:	80060613          	addi	a2,a2,-2048 # 14800 <buf+0x7b08>
    3b40:	00009597          	auipc	a1,0x9
    3b44:	1b858593          	addi	a1,a1,440 # ccf8 <buf>
    3b48:	fc842503          	lw	a0,-56(s0)
    3b4c:	44d010ef          	jal	5798 <read>
    3b50:	4785                	li	a5,1
    3b52:	00f50a63          	beq	a0,a5,3b66 <preempt+0xec>
    printf("%s: preempt read error", s);
    3b56:	85ca                	mv	a1,s2
    3b58:	00004517          	auipc	a0,0x4
    3b5c:	e8850513          	addi	a0,a0,-376 # 79e0 <malloc+0x1d2e>
    3b60:	096020ef          	jal	5bf6 <printf>
    return;
    3b64:	a099                	j	3baa <preempt+0x130>
  close(pfds[0]);
    3b66:	fc842503          	lw	a0,-56(s0)
    3b6a:	43f010ef          	jal	57a8 <close>
  printf("kill... ");
    3b6e:	00004517          	auipc	a0,0x4
    3b72:	e8a50513          	addi	a0,a0,-374 # 79f8 <malloc+0x1d46>
    3b76:	080020ef          	jal	5bf6 <printf>
  kill(pid1);
    3b7a:	8526                	mv	a0,s1
    3b7c:	435010ef          	jal	57b0 <kill>
  kill(pid2);
    3b80:	854e                	mv	a0,s3
    3b82:	42f010ef          	jal	57b0 <kill>
  kill(pid3);
    3b86:	8552                	mv	a0,s4
    3b88:	429010ef          	jal	57b0 <kill>
  printf("wait... ");
    3b8c:	00004517          	auipc	a0,0x4
    3b90:	e7c50513          	addi	a0,a0,-388 # 7a08 <malloc+0x1d56>
    3b94:	062020ef          	jal	5bf6 <printf>
  wait(0);
    3b98:	4501                	li	a0,0
    3b9a:	3ef010ef          	jal	5788 <wait>
  wait(0);
    3b9e:	4501                	li	a0,0
    3ba0:	3e9010ef          	jal	5788 <wait>
  wait(0);
    3ba4:	4501                	li	a0,0
    3ba6:	3e3010ef          	jal	5788 <wait>
}
    3baa:	70e2                	ld	ra,56(sp)
    3bac:	7442                	ld	s0,48(sp)
    3bae:	74a2                	ld	s1,40(sp)
    3bb0:	7902                	ld	s2,32(sp)
    3bb2:	69e2                	ld	s3,24(sp)
    3bb4:	6a42                	ld	s4,16(sp)
    3bb6:	6121                	addi	sp,sp,64
    3bb8:	8082                	ret

0000000000003bba <reparent>:
{
    3bba:	7179                	addi	sp,sp,-48
    3bbc:	f406                	sd	ra,40(sp)
    3bbe:	f022                	sd	s0,32(sp)
    3bc0:	ec26                	sd	s1,24(sp)
    3bc2:	e84a                	sd	s2,16(sp)
    3bc4:	e44e                	sd	s3,8(sp)
    3bc6:	e052                	sd	s4,0(sp)
    3bc8:	1800                	addi	s0,sp,48
    3bca:	89aa                	mv	s3,a0
  int master_pid = getpid();
    3bcc:	435010ef          	jal	5800 <getpid>
    3bd0:	8a2a                	mv	s4,a0
    3bd2:	0c800913          	li	s2,200
    int pid = fork();
    3bd6:	3a3010ef          	jal	5778 <fork>
    3bda:	84aa                	mv	s1,a0
    if (pid < 0) {
    3bdc:	00054e63          	bltz	a0,3bf8 <reparent+0x3e>
    if (pid) {
    3be0:	c121                	beqz	a0,3c20 <reparent+0x66>
      if (wait(0) != pid) {
    3be2:	4501                	li	a0,0
    3be4:	3a5010ef          	jal	5788 <wait>
    3be8:	02951263          	bne	a0,s1,3c0c <reparent+0x52>
  for (int i = 0; i < 200; i++) {
    3bec:	397d                	addiw	s2,s2,-1
    3bee:	fe0914e3          	bnez	s2,3bd6 <reparent+0x1c>
  exit(0);
    3bf2:	4501                	li	a0,0
    3bf4:	38d010ef          	jal	5780 <exit>
      printf("%s: fork failed\n", s);
    3bf8:	85ce                	mv	a1,s3
    3bfa:	00003517          	auipc	a0,0x3
    3bfe:	a7e50513          	addi	a0,a0,-1410 # 6678 <malloc+0x9c6>
    3c02:	7f5010ef          	jal	5bf6 <printf>
      exit(1);
    3c06:	4505                	li	a0,1
    3c08:	379010ef          	jal	5780 <exit>
        printf("%s: wait wrong pid\n", s);
    3c0c:	85ce                	mv	a1,s3
    3c0e:	00003517          	auipc	a0,0x3
    3c12:	b7250513          	addi	a0,a0,-1166 # 6780 <malloc+0xace>
    3c16:	7e1010ef          	jal	5bf6 <printf>
        exit(1);
    3c1a:	4505                	li	a0,1
    3c1c:	365010ef          	jal	5780 <exit>
      int pid2 = fork();
    3c20:	359010ef          	jal	5778 <fork>
      if (pid2 < 0) {
    3c24:	00054563          	bltz	a0,3c2e <reparent+0x74>
      exit(0);
    3c28:	4501                	li	a0,0
    3c2a:	357010ef          	jal	5780 <exit>
        kill(master_pid);
    3c2e:	8552                	mv	a0,s4
    3c30:	381010ef          	jal	57b0 <kill>
        exit(1);
    3c34:	4505                	li	a0,1
    3c36:	34b010ef          	jal	5780 <exit>

0000000000003c3a <sbrkfail>:
{
    3c3a:	7175                	addi	sp,sp,-144
    3c3c:	e506                	sd	ra,136(sp)
    3c3e:	e122                	sd	s0,128(sp)
    3c40:	fca6                	sd	s1,120(sp)
    3c42:	f8ca                	sd	s2,112(sp)
    3c44:	f4ce                	sd	s3,104(sp)
    3c46:	f0d2                	sd	s4,96(sp)
    3c48:	ecd6                	sd	s5,88(sp)
    3c4a:	e8da                	sd	s6,80(sp)
    3c4c:	e4de                	sd	s7,72(sp)
    3c4e:	e0e2                	sd	s8,64(sp)
    3c50:	0900                	addi	s0,sp,144
    3c52:	8c2a                	mv	s8,a0
  if (pipe(fds) != 0) {
    3c54:	fa040513          	addi	a0,s0,-96
    3c58:	339010ef          	jal	5790 <pipe>
    3c5c:	ed01                	bnez	a0,3c74 <sbrkfail+0x3a>
    3c5e:	8baa                	mv	s7,a0
    3c60:	f7040493          	addi	s1,s0,-144
    3c64:	f9840993          	addi	s3,s0,-104
    3c68:	8926                	mv	s2,s1
    if (pids[i] != -1) {
    3c6a:	5a7d                	li	s4,-1
      read(fds[0], &scratch, 1);
    3c6c:	f9f40b13          	addi	s6,s0,-97
    3c70:	4a85                	li	s5,1
    3c72:	a095                	j	3cd6 <sbrkfail+0x9c>
    printf("%s: pipe() failed\n", s);
    3c74:	85e2                	mv	a1,s8
    3c76:	00003517          	auipc	a0,0x3
    3c7a:	a8a50513          	addi	a0,a0,-1398 # 6700 <malloc+0xa4e>
    3c7e:	779010ef          	jal	5bf6 <printf>
    exit(1);
    3c82:	4505                	li	a0,1
    3c84:	2fd010ef          	jal	5780 <exit>
      if (sbrk(BIG - (uint64)sbrk(0)) == (char *)SBRK_ERROR)
    3c88:	2c5010ef          	jal	574c <sbrk>
    3c8c:	064007b7          	lui	a5,0x6400
    3c90:	40a7853b          	subw	a0,a5,a0
    3c94:	2b9010ef          	jal	574c <sbrk>
    3c98:	57fd                	li	a5,-1
    3c9a:	02f50163          	beq	a0,a5,3cbc <sbrkfail+0x82>
        write(fds[1], "1", 1);
    3c9e:	4605                	li	a2,1
    3ca0:	00004597          	auipc	a1,0x4
    3ca4:	72058593          	addi	a1,a1,1824 # 83c0 <malloc+0x270e>
    3ca8:	fa442503          	lw	a0,-92(s0)
    3cac:	2f5010ef          	jal	57a0 <write>
        pause(1000);
    3cb0:	3e800493          	li	s1,1000
    3cb4:	8526                	mv	a0,s1
    3cb6:	35b010ef          	jal	5810 <pause>
      for (;;)
    3cba:	bfed                	j	3cb4 <sbrkfail+0x7a>
        write(fds[1], "0", 1);
    3cbc:	4605                	li	a2,1
    3cbe:	00004597          	auipc	a1,0x4
    3cc2:	d5a58593          	addi	a1,a1,-678 # 7a18 <malloc+0x1d66>
    3cc6:	fa442503          	lw	a0,-92(s0)
    3cca:	2d7010ef          	jal	57a0 <write>
    3cce:	b7cd                	j	3cb0 <sbrkfail+0x76>
  for (i = 0; i < sizeof(pids) / sizeof(pids[0]); i++) {
    3cd0:	0911                	addi	s2,s2,4
    3cd2:	03390a63          	beq	s2,s3,3d06 <sbrkfail+0xcc>
    if ((pids[i] = fork()) == 0) {
    3cd6:	2a3010ef          	jal	5778 <fork>
    3cda:	00a92023          	sw	a0,0(s2)
    3cde:	d54d                	beqz	a0,3c88 <sbrkfail+0x4e>
    if (pids[i] != -1) {
    3ce0:	ff4508e3          	beq	a0,s4,3cd0 <sbrkfail+0x96>
      read(fds[0], &scratch, 1);
    3ce4:	8656                	mv	a2,s5
    3ce6:	85da                	mv	a1,s6
    3ce8:	fa042503          	lw	a0,-96(s0)
    3cec:	2ad010ef          	jal	5798 <read>
      if (scratch == '0')
    3cf0:	f9f44783          	lbu	a5,-97(s0)
    3cf4:	fd078793          	addi	a5,a5,-48 # 63fffd0 <base+0x63dead8>
    3cf8:	0017b793          	seqz	a5,a5
    3cfc:	00fbe7b3          	or	a5,s7,a5
    3d00:	00078b9b          	sext.w	s7,a5
    3d04:	b7f1                	j	3cd0 <sbrkfail+0x96>
  if (!failed) {
    3d06:	000b8863          	beqz	s7,3d16 <sbrkfail+0xdc>
  c = sbrk(PGSIZE);
    3d0a:	6505                	lui	a0,0x1
    3d0c:	241010ef          	jal	574c <sbrk>
    3d10:	8a2a                	mv	s4,a0
    if (pids[i] == -1)
    3d12:	597d                	li	s2,-1
    3d14:	a821                	j	3d2c <sbrkfail+0xf2>
    printf("%s: no allocation failed; allocate more?\n", s);
    3d16:	85e2                	mv	a1,s8
    3d18:	00004517          	auipc	a0,0x4
    3d1c:	d0850513          	addi	a0,a0,-760 # 7a20 <malloc+0x1d6e>
    3d20:	6d7010ef          	jal	5bf6 <printf>
    3d24:	b7dd                	j	3d0a <sbrkfail+0xd0>
  for (i = 0; i < sizeof(pids) / sizeof(pids[0]); i++) {
    3d26:	0491                	addi	s1,s1,4
    3d28:	01348b63          	beq	s1,s3,3d3e <sbrkfail+0x104>
    if (pids[i] == -1)
    3d2c:	4088                	lw	a0,0(s1)
    3d2e:	ff250ce3          	beq	a0,s2,3d26 <sbrkfail+0xec>
    kill(pids[i]);
    3d32:	27f010ef          	jal	57b0 <kill>
    wait(0);
    3d36:	4501                	li	a0,0
    3d38:	251010ef          	jal	5788 <wait>
    3d3c:	b7ed                	j	3d26 <sbrkfail+0xec>
  if (c == (char *)SBRK_ERROR) {
    3d3e:	57fd                	li	a5,-1
    3d40:	02fa0a63          	beq	s4,a5,3d74 <sbrkfail+0x13a>
  pid = fork();
    3d44:	235010ef          	jal	5778 <fork>
  if (pid < 0) {
    3d48:	04054063          	bltz	a0,3d88 <sbrkfail+0x14e>
  if (pid == 0) {
    3d4c:	e939                	bnez	a0,3da2 <sbrkfail+0x168>
    a = sbrk(10 * BIG);
    3d4e:	3e800537          	lui	a0,0x3e800
    3d52:	1fb010ef          	jal	574c <sbrk>
    if (a == (char *)SBRK_ERROR) {
    3d56:	57fd                	li	a5,-1
    3d58:	04f50263          	beq	a0,a5,3d9c <sbrkfail+0x162>
    printf("%s: allocate a lot of memory succeeded %d\n", s, 10 * BIG);
    3d5c:	3e800637          	lui	a2,0x3e800
    3d60:	85e2                	mv	a1,s8
    3d62:	00004517          	auipc	a0,0x4
    3d66:	d0e50513          	addi	a0,a0,-754 # 7a70 <malloc+0x1dbe>
    3d6a:	68d010ef          	jal	5bf6 <printf>
    exit(1);
    3d6e:	4505                	li	a0,1
    3d70:	211010ef          	jal	5780 <exit>
    printf("%s: failed sbrk leaked memory\n", s);
    3d74:	85e2                	mv	a1,s8
    3d76:	00004517          	auipc	a0,0x4
    3d7a:	cda50513          	addi	a0,a0,-806 # 7a50 <malloc+0x1d9e>
    3d7e:	679010ef          	jal	5bf6 <printf>
    exit(1);
    3d82:	4505                	li	a0,1
    3d84:	1fd010ef          	jal	5780 <exit>
    printf("%s: fork failed\n", s);
    3d88:	85e2                	mv	a1,s8
    3d8a:	00003517          	auipc	a0,0x3
    3d8e:	8ee50513          	addi	a0,a0,-1810 # 6678 <malloc+0x9c6>
    3d92:	665010ef          	jal	5bf6 <printf>
    exit(1);
    3d96:	4505                	li	a0,1
    3d98:	1e9010ef          	jal	5780 <exit>
      exit(0);
    3d9c:	4501                	li	a0,0
    3d9e:	1e3010ef          	jal	5780 <exit>
  wait(&xstatus);
    3da2:	fac40513          	addi	a0,s0,-84
    3da6:	1e3010ef          	jal	5788 <wait>
  if (xstatus != 0)
    3daa:	fac42783          	lw	a5,-84(s0)
    3dae:	ef89                	bnez	a5,3dc8 <sbrkfail+0x18e>
}
    3db0:	60aa                	ld	ra,136(sp)
    3db2:	640a                	ld	s0,128(sp)
    3db4:	74e6                	ld	s1,120(sp)
    3db6:	7946                	ld	s2,112(sp)
    3db8:	79a6                	ld	s3,104(sp)
    3dba:	7a06                	ld	s4,96(sp)
    3dbc:	6ae6                	ld	s5,88(sp)
    3dbe:	6b46                	ld	s6,80(sp)
    3dc0:	6ba6                	ld	s7,72(sp)
    3dc2:	6c06                	ld	s8,64(sp)
    3dc4:	6149                	addi	sp,sp,144
    3dc6:	8082                	ret
    exit(1);
    3dc8:	4505                	li	a0,1
    3dca:	1b7010ef          	jal	5780 <exit>

0000000000003dce <mem>:
{
    3dce:	7139                	addi	sp,sp,-64
    3dd0:	fc06                	sd	ra,56(sp)
    3dd2:	f822                	sd	s0,48(sp)
    3dd4:	f426                	sd	s1,40(sp)
    3dd6:	f04a                	sd	s2,32(sp)
    3dd8:	ec4e                	sd	s3,24(sp)
    3dda:	0080                	addi	s0,sp,64
    3ddc:	89aa                	mv	s3,a0
  if ((pid = fork()) == 0) {
    3dde:	19b010ef          	jal	5778 <fork>
    m1 = 0;
    3de2:	4481                	li	s1,0
    while ((m2 = malloc(10001)) != 0) {
    3de4:	6909                	lui	s2,0x2
    3de6:	71190913          	addi	s2,s2,1809 # 2711 <fourteen+0xd9>
  if ((pid = fork()) == 0) {
    3dea:	cd11                	beqz	a0,3e06 <mem+0x38>
    wait(&xstatus);
    3dec:	fcc40513          	addi	a0,s0,-52
    3df0:	199010ef          	jal	5788 <wait>
    if (xstatus == -1) {
    3df4:	fcc42503          	lw	a0,-52(s0)
    3df8:	57fd                	li	a5,-1
    3dfa:	04f50363          	beq	a0,a5,3e40 <mem+0x72>
    exit(xstatus);
    3dfe:	183010ef          	jal	5780 <exit>
      *(char **)m2 = m1;
    3e02:	e104                	sd	s1,0(a0)
      m1 = m2;
    3e04:	84aa                	mv	s1,a0
    while ((m2 = malloc(10001)) != 0) {
    3e06:	854a                	mv	a0,s2
    3e08:	6ab010ef          	jal	5cb2 <malloc>
    3e0c:	f97d                	bnez	a0,3e02 <mem+0x34>
    while (m1) {
    3e0e:	c491                	beqz	s1,3e1a <mem+0x4c>
      m2 = *(char **)m1;
    3e10:	8526                	mv	a0,s1
    3e12:	6084                	ld	s1,0(s1)
      free(m1);
    3e14:	615010ef          	jal	5c28 <free>
    while (m1) {
    3e18:	fce5                	bnez	s1,3e10 <mem+0x42>
    m1 = malloc(1024 * 20);
    3e1a:	6515                	lui	a0,0x5
    3e1c:	697010ef          	jal	5cb2 <malloc>
    if (m1 == 0) {
    3e20:	c511                	beqz	a0,3e2c <mem+0x5e>
    free(m1);
    3e22:	607010ef          	jal	5c28 <free>
    exit(0);
    3e26:	4501                	li	a0,0
    3e28:	159010ef          	jal	5780 <exit>
      printf("%s: couldn't allocate mem?!!\n", s);
    3e2c:	85ce                	mv	a1,s3
    3e2e:	00004517          	auipc	a0,0x4
    3e32:	c7250513          	addi	a0,a0,-910 # 7aa0 <malloc+0x1dee>
    3e36:	5c1010ef          	jal	5bf6 <printf>
      exit(1);
    3e3a:	4505                	li	a0,1
    3e3c:	145010ef          	jal	5780 <exit>
      exit(0);
    3e40:	4501                	li	a0,0
    3e42:	13f010ef          	jal	5780 <exit>

0000000000003e46 <sharedfd>:
{
    3e46:	7159                	addi	sp,sp,-112
    3e48:	f486                	sd	ra,104(sp)
    3e4a:	f0a2                	sd	s0,96(sp)
    3e4c:	eca6                	sd	s1,88(sp)
    3e4e:	f85a                	sd	s6,48(sp)
    3e50:	1880                	addi	s0,sp,112
    3e52:	84aa                	mv	s1,a0
    3e54:	8b2a                	mv	s6,a0
  unlink("sharedfd");
    3e56:	00004517          	auipc	a0,0x4
    3e5a:	c6a50513          	addi	a0,a0,-918 # 7ac0 <malloc+0x1e0e>
    3e5e:	173010ef          	jal	57d0 <unlink>
  fd = open("sharedfd", O_CREATE | O_RDWR);
    3e62:	20200593          	li	a1,514
    3e66:	00004517          	auipc	a0,0x4
    3e6a:	c5a50513          	addi	a0,a0,-934 # 7ac0 <malloc+0x1e0e>
    3e6e:	153010ef          	jal	57c0 <open>
  if (fd < 0) {
    3e72:	04054863          	bltz	a0,3ec2 <sharedfd+0x7c>
    3e76:	e8ca                	sd	s2,80(sp)
    3e78:	e4ce                	sd	s3,72(sp)
    3e7a:	e0d2                	sd	s4,64(sp)
    3e7c:	fc56                	sd	s5,56(sp)
    3e7e:	89aa                	mv	s3,a0
  pid = fork();
    3e80:	0f9010ef          	jal	5778 <fork>
    3e84:	8aaa                	mv	s5,a0
  memset(buf, pid == 0 ? 'c' : 'p', sizeof(buf));
    3e86:	07000593          	li	a1,112
    3e8a:	e119                	bnez	a0,3e90 <sharedfd+0x4a>
    3e8c:	06300593          	li	a1,99
    3e90:	4629                	li	a2,10
    3e92:	fa040513          	addi	a0,s0,-96
    3e96:	6c0010ef          	jal	5556 <memset>
    3e9a:	3e800493          	li	s1,1000
    if (write(fd, buf, sizeof(buf)) != sizeof(buf)) {
    3e9e:	fa040a13          	addi	s4,s0,-96
    3ea2:	4929                	li	s2,10
    3ea4:	864a                	mv	a2,s2
    3ea6:	85d2                	mv	a1,s4
    3ea8:	854e                	mv	a0,s3
    3eaa:	0f7010ef          	jal	57a0 <write>
    3eae:	03251963          	bne	a0,s2,3ee0 <sharedfd+0x9a>
  for (i = 0; i < N; i++) {
    3eb2:	34fd                	addiw	s1,s1,-1
    3eb4:	f8e5                	bnez	s1,3ea4 <sharedfd+0x5e>
  if (pid == 0) {
    3eb6:	040a9063          	bnez	s5,3ef6 <sharedfd+0xb0>
    3eba:	f45e                	sd	s7,40(sp)
    exit(0);
    3ebc:	4501                	li	a0,0
    3ebe:	0c3010ef          	jal	5780 <exit>
    3ec2:	e8ca                	sd	s2,80(sp)
    3ec4:	e4ce                	sd	s3,72(sp)
    3ec6:	e0d2                	sd	s4,64(sp)
    3ec8:	fc56                	sd	s5,56(sp)
    3eca:	f45e                	sd	s7,40(sp)
    printf("%s: cannot open sharedfd for writing", s);
    3ecc:	85a6                	mv	a1,s1
    3ece:	00004517          	auipc	a0,0x4
    3ed2:	c0250513          	addi	a0,a0,-1022 # 7ad0 <malloc+0x1e1e>
    3ed6:	521010ef          	jal	5bf6 <printf>
    exit(1);
    3eda:	4505                	li	a0,1
    3edc:	0a5010ef          	jal	5780 <exit>
    3ee0:	f45e                	sd	s7,40(sp)
      printf("%s: write sharedfd failed\n", s);
    3ee2:	85da                	mv	a1,s6
    3ee4:	00004517          	auipc	a0,0x4
    3ee8:	c1450513          	addi	a0,a0,-1004 # 7af8 <malloc+0x1e46>
    3eec:	50b010ef          	jal	5bf6 <printf>
      exit(1);
    3ef0:	4505                	li	a0,1
    3ef2:	08f010ef          	jal	5780 <exit>
    wait(&xstatus);
    3ef6:	f9c40513          	addi	a0,s0,-100
    3efa:	08f010ef          	jal	5788 <wait>
    if (xstatus != 0)
    3efe:	f9c42a03          	lw	s4,-100(s0)
    3f02:	000a0663          	beqz	s4,3f0e <sharedfd+0xc8>
    3f06:	f45e                	sd	s7,40(sp)
      exit(xstatus);
    3f08:	8552                	mv	a0,s4
    3f0a:	077010ef          	jal	5780 <exit>
    3f0e:	f45e                	sd	s7,40(sp)
  close(fd);
    3f10:	854e                	mv	a0,s3
    3f12:	097010ef          	jal	57a8 <close>
  fd = open("sharedfd", 0);
    3f16:	4581                	li	a1,0
    3f18:	00004517          	auipc	a0,0x4
    3f1c:	ba850513          	addi	a0,a0,-1112 # 7ac0 <malloc+0x1e0e>
    3f20:	0a1010ef          	jal	57c0 <open>
    3f24:	8baa                	mv	s7,a0
  nc = np = 0;
    3f26:	89d2                	mv	s3,s4
  if (fd < 0) {
    3f28:	02054363          	bltz	a0,3f4e <sharedfd+0x108>
    3f2c:	faa40913          	addi	s2,s0,-86
      if (buf[i] == 'c')
    3f30:	06300493          	li	s1,99
      if (buf[i] == 'p')
    3f34:	07000a93          	li	s5,112
  while ((n = read(fd, buf, sizeof(buf))) > 0) {
    3f38:	4629                	li	a2,10
    3f3a:	fa040593          	addi	a1,s0,-96
    3f3e:	855e                	mv	a0,s7
    3f40:	059010ef          	jal	5798 <read>
    3f44:	02a05b63          	blez	a0,3f7a <sharedfd+0x134>
    3f48:	fa040793          	addi	a5,s0,-96
    3f4c:	a839                	j	3f6a <sharedfd+0x124>
    printf("%s: cannot open sharedfd for reading\n", s);
    3f4e:	85da                	mv	a1,s6
    3f50:	00004517          	auipc	a0,0x4
    3f54:	bc850513          	addi	a0,a0,-1080 # 7b18 <malloc+0x1e66>
    3f58:	49f010ef          	jal	5bf6 <printf>
    exit(1);
    3f5c:	4505                	li	a0,1
    3f5e:	023010ef          	jal	5780 <exit>
        nc++;
    3f62:	2a05                	addiw	s4,s4,1
    for (i = 0; i < sizeof(buf); i++) {
    3f64:	0785                	addi	a5,a5,1
    3f66:	fd2789e3          	beq	a5,s2,3f38 <sharedfd+0xf2>
      if (buf[i] == 'c')
    3f6a:	0007c703          	lbu	a4,0(a5)
    3f6e:	fe970ae3          	beq	a4,s1,3f62 <sharedfd+0x11c>
      if (buf[i] == 'p')
    3f72:	ff5719e3          	bne	a4,s5,3f64 <sharedfd+0x11e>
        np++;
    3f76:	2985                	addiw	s3,s3,1
    3f78:	b7f5                	j	3f64 <sharedfd+0x11e>
  close(fd);
    3f7a:	855e                	mv	a0,s7
    3f7c:	02d010ef          	jal	57a8 <close>
  unlink("sharedfd");
    3f80:	00004517          	auipc	a0,0x4
    3f84:	b4050513          	addi	a0,a0,-1216 # 7ac0 <malloc+0x1e0e>
    3f88:	049010ef          	jal	57d0 <unlink>
  if (nc == N * SZ && np == N * SZ) {
    3f8c:	6789                	lui	a5,0x2
    3f8e:	71078793          	addi	a5,a5,1808 # 2710 <fourteen+0xd8>
    3f92:	00fa1763          	bne	s4,a5,3fa0 <sharedfd+0x15a>
    3f96:	01499563          	bne	s3,s4,3fa0 <sharedfd+0x15a>
    exit(0);
    3f9a:	4501                	li	a0,0
    3f9c:	7e4010ef          	jal	5780 <exit>
    printf("%s: nc/np test fails\n", s);
    3fa0:	85da                	mv	a1,s6
    3fa2:	00004517          	auipc	a0,0x4
    3fa6:	b9e50513          	addi	a0,a0,-1122 # 7b40 <malloc+0x1e8e>
    3faa:	44d010ef          	jal	5bf6 <printf>
    exit(1);
    3fae:	4505                	li	a0,1
    3fb0:	7d0010ef          	jal	5780 <exit>

0000000000003fb4 <fourfiles>:
{
    3fb4:	7135                	addi	sp,sp,-160
    3fb6:	ed06                	sd	ra,152(sp)
    3fb8:	e922                	sd	s0,144(sp)
    3fba:	e526                	sd	s1,136(sp)
    3fbc:	e14a                	sd	s2,128(sp)
    3fbe:	fcce                	sd	s3,120(sp)
    3fc0:	f8d2                	sd	s4,112(sp)
    3fc2:	f4d6                	sd	s5,104(sp)
    3fc4:	f0da                	sd	s6,96(sp)
    3fc6:	ecde                	sd	s7,88(sp)
    3fc8:	e8e2                	sd	s8,80(sp)
    3fca:	e4e6                	sd	s9,72(sp)
    3fcc:	e0ea                	sd	s10,64(sp)
    3fce:	fc6e                	sd	s11,56(sp)
    3fd0:	1100                	addi	s0,sp,160
    3fd2:	8caa                	mv	s9,a0
  char *names[] = {"f0", "f1", "f2", "f3"};
    3fd4:	00004797          	auipc	a5,0x4
    3fd8:	b8478793          	addi	a5,a5,-1148 # 7b58 <malloc+0x1ea6>
    3fdc:	f6f43823          	sd	a5,-144(s0)
    3fe0:	00004797          	auipc	a5,0x4
    3fe4:	b8078793          	addi	a5,a5,-1152 # 7b60 <malloc+0x1eae>
    3fe8:	f6f43c23          	sd	a5,-136(s0)
    3fec:	00004797          	auipc	a5,0x4
    3ff0:	b7c78793          	addi	a5,a5,-1156 # 7b68 <malloc+0x1eb6>
    3ff4:	f8f43023          	sd	a5,-128(s0)
    3ff8:	00004797          	auipc	a5,0x4
    3ffc:	b7878793          	addi	a5,a5,-1160 # 7b70 <malloc+0x1ebe>
    4000:	f8f43423          	sd	a5,-120(s0)
  for (pi = 0; pi < NCHILD; pi++) {
    4004:	f7040b93          	addi	s7,s0,-144
  char *names[] = {"f0", "f1", "f2", "f3"};
    4008:	895e                	mv	s2,s7
  for (pi = 0; pi < NCHILD; pi++) {
    400a:	4481                	li	s1,0
    400c:	4a11                	li	s4,4
    fname = names[pi];
    400e:	00093983          	ld	s3,0(s2)
    unlink(fname);
    4012:	854e                	mv	a0,s3
    4014:	7bc010ef          	jal	57d0 <unlink>
    pid = fork();
    4018:	760010ef          	jal	5778 <fork>
    if (pid < 0) {
    401c:	04054263          	bltz	a0,4060 <fourfiles+0xac>
    if (pid == 0) {
    4020:	c931                	beqz	a0,4074 <fourfiles+0xc0>
  for (pi = 0; pi < NCHILD; pi++) {
    4022:	2485                	addiw	s1,s1,1
    4024:	0921                	addi	s2,s2,8
    4026:	ff4494e3          	bne	s1,s4,400e <fourfiles+0x5a>
    402a:	4491                	li	s1,4
    wait(&xstatus);
    402c:	f6c40913          	addi	s2,s0,-148
    4030:	854a                	mv	a0,s2
    4032:	756010ef          	jal	5788 <wait>
    if (xstatus != 0)
    4036:	f6c42b03          	lw	s6,-148(s0)
    403a:	0a0b1663          	bnez	s6,40e6 <fourfiles+0x132>
  for (pi = 0; pi < NCHILD; pi++) {
    403e:	34fd                	addiw	s1,s1,-1
    4040:	f8e5                	bnez	s1,4030 <fourfiles+0x7c>
    4042:	03000493          	li	s1,48
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    4046:	6a55                	lui	s4,0x15
    4048:	800a0a13          	addi	s4,s4,-2048 # 14800 <buf+0x7b08>
    404c:	00009a97          	auipc	s5,0x9
    4050:	caca8a93          	addi	s5,s5,-852 # ccf8 <buf>
    if (total != N * SZ) {
    4054:	6d05                	lui	s10,0x1
    4056:	770d0d13          	addi	s10,s10,1904 # 1770 <createdelete+0x10>
  for (i = 0; i < NCHILD; i++) {
    405a:	03400d93          	li	s11,52
    405e:	a86d                	j	4118 <fourfiles+0x164>
      printf("%s: fork failed\n", s);
    4060:	85e6                	mv	a1,s9
    4062:	00002517          	auipc	a0,0x2
    4066:	61650513          	addi	a0,a0,1558 # 6678 <malloc+0x9c6>
    406a:	38d010ef          	jal	5bf6 <printf>
      exit(1);
    406e:	4505                	li	a0,1
    4070:	710010ef          	jal	5780 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    4074:	20200593          	li	a1,514
    4078:	854e                	mv	a0,s3
    407a:	746010ef          	jal	57c0 <open>
    407e:	892a                	mv	s2,a0
      if (fd < 0) {
    4080:	04054063          	bltz	a0,40c0 <fourfiles+0x10c>
      memset(buf, '0' + pi, SZ);
    4084:	1f400613          	li	a2,500
    4088:	0304859b          	addiw	a1,s1,48
    408c:	00009517          	auipc	a0,0x9
    4090:	c6c50513          	addi	a0,a0,-916 # ccf8 <buf>
    4094:	4c2010ef          	jal	5556 <memset>
    4098:	44b1                	li	s1,12
        if ((n = write(fd, buf, SZ)) != SZ) {
    409a:	1f400993          	li	s3,500
    409e:	00009a17          	auipc	s4,0x9
    40a2:	c5aa0a13          	addi	s4,s4,-934 # ccf8 <buf>
    40a6:	864e                	mv	a2,s3
    40a8:	85d2                	mv	a1,s4
    40aa:	854a                	mv	a0,s2
    40ac:	6f4010ef          	jal	57a0 <write>
    40b0:	85aa                	mv	a1,a0
    40b2:	03351163          	bne	a0,s3,40d4 <fourfiles+0x120>
      for (i = 0; i < N; i++) {
    40b6:	34fd                	addiw	s1,s1,-1
    40b8:	f4fd                	bnez	s1,40a6 <fourfiles+0xf2>
      exit(0);
    40ba:	4501                	li	a0,0
    40bc:	6c4010ef          	jal	5780 <exit>
        printf("%s: create failed\n", s);
    40c0:	85e6                	mv	a1,s9
    40c2:	00002517          	auipc	a0,0x2
    40c6:	72650513          	addi	a0,a0,1830 # 67e8 <malloc+0xb36>
    40ca:	32d010ef          	jal	5bf6 <printf>
        exit(1);
    40ce:	4505                	li	a0,1
    40d0:	6b0010ef          	jal	5780 <exit>
          printf("write failed %d\n", n);
    40d4:	00004517          	auipc	a0,0x4
    40d8:	aa450513          	addi	a0,a0,-1372 # 7b78 <malloc+0x1ec6>
    40dc:	31b010ef          	jal	5bf6 <printf>
          exit(1);
    40e0:	4505                	li	a0,1
    40e2:	69e010ef          	jal	5780 <exit>
      exit(xstatus);
    40e6:	855a                	mv	a0,s6
    40e8:	698010ef          	jal	5780 <exit>
          printf("%s: wrong char\n", s);
    40ec:	85e6                	mv	a1,s9
    40ee:	00004517          	auipc	a0,0x4
    40f2:	aa250513          	addi	a0,a0,-1374 # 7b90 <malloc+0x1ede>
    40f6:	301010ef          	jal	5bf6 <printf>
          exit(1);
    40fa:	4505                	li	a0,1
    40fc:	684010ef          	jal	5780 <exit>
    close(fd);
    4100:	854e                	mv	a0,s3
    4102:	6a6010ef          	jal	57a8 <close>
    if (total != N * SZ) {
    4106:	05a91863          	bne	s2,s10,4156 <fourfiles+0x1a2>
    unlink(fname);
    410a:	8562                	mv	a0,s8
    410c:	6c4010ef          	jal	57d0 <unlink>
  for (i = 0; i < NCHILD; i++) {
    4110:	0ba1                	addi	s7,s7,8
    4112:	2485                	addiw	s1,s1,1
    4114:	05b48b63          	beq	s1,s11,416a <fourfiles+0x1b6>
    fname = names[i];
    4118:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    411c:	4581                	li	a1,0
    411e:	8562                	mv	a0,s8
    4120:	6a0010ef          	jal	57c0 <open>
    4124:	89aa                	mv	s3,a0
    total = 0;
    4126:	895a                	mv	s2,s6
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    4128:	8652                	mv	a2,s4
    412a:	85d6                	mv	a1,s5
    412c:	854e                	mv	a0,s3
    412e:	66a010ef          	jal	5798 <read>
    4132:	fca057e3          	blez	a0,4100 <fourfiles+0x14c>
    4136:	00009797          	auipc	a5,0x9
    413a:	bc278793          	addi	a5,a5,-1086 # ccf8 <buf>
    413e:	00f506b3          	add	a3,a0,a5
        if (buf[j] != '0' + i) {
    4142:	0007c703          	lbu	a4,0(a5)
    4146:	fa9713e3          	bne	a4,s1,40ec <fourfiles+0x138>
      for (j = 0; j < n; j++) {
    414a:	0785                	addi	a5,a5,1
    414c:	fed79be3          	bne	a5,a3,4142 <fourfiles+0x18e>
      total += n;
    4150:	00a9093b          	addw	s2,s2,a0
    4154:	bfd1                	j	4128 <fourfiles+0x174>
      printf("wrong length %d\n", total);
    4156:	85ca                	mv	a1,s2
    4158:	00004517          	auipc	a0,0x4
    415c:	a4850513          	addi	a0,a0,-1464 # 7ba0 <malloc+0x1eee>
    4160:	297010ef          	jal	5bf6 <printf>
      exit(1);
    4164:	4505                	li	a0,1
    4166:	61a010ef          	jal	5780 <exit>
}
    416a:	60ea                	ld	ra,152(sp)
    416c:	644a                	ld	s0,144(sp)
    416e:	64aa                	ld	s1,136(sp)
    4170:	690a                	ld	s2,128(sp)
    4172:	79e6                	ld	s3,120(sp)
    4174:	7a46                	ld	s4,112(sp)
    4176:	7aa6                	ld	s5,104(sp)
    4178:	7b06                	ld	s6,96(sp)
    417a:	6be6                	ld	s7,88(sp)
    417c:	6c46                	ld	s8,80(sp)
    417e:	6ca6                	ld	s9,72(sp)
    4180:	6d06                	ld	s10,64(sp)
    4182:	7de2                	ld	s11,56(sp)
    4184:	610d                	addi	sp,sp,160
    4186:	8082                	ret

0000000000004188 <concreate>:
{
    4188:	7171                	addi	sp,sp,-176
    418a:	f506                	sd	ra,168(sp)
    418c:	f122                	sd	s0,160(sp)
    418e:	ed26                	sd	s1,152(sp)
    4190:	e94a                	sd	s2,144(sp)
    4192:	e54e                	sd	s3,136(sp)
    4194:	e152                	sd	s4,128(sp)
    4196:	fcd6                	sd	s5,120(sp)
    4198:	f8da                	sd	s6,112(sp)
    419a:	f4de                	sd	s7,104(sp)
    419c:	f0e2                	sd	s8,96(sp)
    419e:	ece6                	sd	s9,88(sp)
    41a0:	e8ea                	sd	s10,80(sp)
    41a2:	1900                	addi	s0,sp,176
    41a4:	8d2a                	mv	s10,a0
  file[0] = 'C';
    41a6:	04300793          	li	a5,67
    41aa:	f8f40c23          	sb	a5,-104(s0)
  file[2] = '\0';
    41ae:	f8040d23          	sb	zero,-102(s0)
  for (i = 0; i < N; i++) {
    41b2:	4901                	li	s2,0
    unlink(file);
    41b4:	f9840993          	addi	s3,s0,-104
    if (pid && (i % 3) == 1) {
    41b8:	55555b37          	lui	s6,0x55555
    41bc:	556b0b13          	addi	s6,s6,1366 # 55555556 <base+0x5553405e>
    41c0:	4b85                	li	s7,1
      fd = open(file, O_CREATE | O_RDWR);
    41c2:	20200c13          	li	s8,514
      link("C0", file);
    41c6:	00004c97          	auipc	s9,0x4
    41ca:	9f2c8c93          	addi	s9,s9,-1550 # 7bb8 <malloc+0x1f06>
      wait(&xstatus);
    41ce:	f5c40a93          	addi	s5,s0,-164
  for (i = 0; i < N; i++) {
    41d2:	02800a13          	li	s4,40
    41d6:	a481                	j	4416 <concreate+0x28e>
      link("C0", file);
    41d8:	85ce                	mv	a1,s3
    41da:	8566                	mv	a0,s9
    41dc:	604010ef          	jal	57e0 <link>
    if (pid == 0) {
    41e0:	a40d                	j	4402 <concreate+0x27a>
    } else if (pid == 0 && (i % 5) == 1) {
    41e2:	666667b7          	lui	a5,0x66666
    41e6:	66778793          	addi	a5,a5,1639 # 66666667 <base+0x6664516f>
    41ea:	02f907b3          	mul	a5,s2,a5
    41ee:	9785                	srai	a5,a5,0x21
    41f0:	41f9571b          	sraiw	a4,s2,0x1f
    41f4:	9f99                	subw	a5,a5,a4
    41f6:	0027971b          	slliw	a4,a5,0x2
    41fa:	9fb9                	addw	a5,a5,a4
    41fc:	40f9093b          	subw	s2,s2,a5
    4200:	4785                	li	a5,1
    4202:	02f90563          	beq	s2,a5,422c <concreate+0xa4>
      fd = open(file, O_CREATE | O_RDWR);
    4206:	20200593          	li	a1,514
    420a:	f9840513          	addi	a0,s0,-104
    420e:	5b2010ef          	jal	57c0 <open>
      if (fd < 0) {
    4212:	1e055363          	bgez	a0,43f8 <concreate+0x270>
        printf("concreate create %s failed\n", file);
    4216:	f9840593          	addi	a1,s0,-104
    421a:	00004517          	auipc	a0,0x4
    421e:	9a650513          	addi	a0,a0,-1626 # 7bc0 <malloc+0x1f0e>
    4222:	1d5010ef          	jal	5bf6 <printf>
        exit(1);
    4226:	4505                	li	a0,1
    4228:	558010ef          	jal	5780 <exit>
      link("C0", file);
    422c:	f9840593          	addi	a1,s0,-104
    4230:	00004517          	auipc	a0,0x4
    4234:	98850513          	addi	a0,a0,-1656 # 7bb8 <malloc+0x1f06>
    4238:	5a8010ef          	jal	57e0 <link>
      exit(0);
    423c:	4501                	li	a0,0
    423e:	542010ef          	jal	5780 <exit>
        exit(1);
    4242:	4505                	li	a0,1
    4244:	53c010ef          	jal	5780 <exit>
  memset(fa, 0, sizeof(fa));
    4248:	02800613          	li	a2,40
    424c:	4581                	li	a1,0
    424e:	f7040513          	addi	a0,s0,-144
    4252:	304010ef          	jal	5556 <memset>
  fd = open(".", 0);
    4256:	4581                	li	a1,0
    4258:	00002517          	auipc	a0,0x2
    425c:	27850513          	addi	a0,a0,632 # 64d0 <malloc+0x81e>
    4260:	560010ef          	jal	57c0 <open>
    4264:	892a                	mv	s2,a0
  n = 0;
    4266:	8b26                	mv	s6,s1
  while (read(fd, &de, sizeof(de)) > 0) {
    4268:	f6040a13          	addi	s4,s0,-160
    426c:	49c1                	li	s3,16
    if (de.name[0] == 'C' && de.name[2] == '\0') {
    426e:	04300a93          	li	s5,67
      if (i < 0 || i >= sizeof(fa)) {
    4272:	02700b93          	li	s7,39
      fa[i] = 1;
    4276:	4c05                	li	s8,1
  while (read(fd, &de, sizeof(de)) > 0) {
    4278:	864e                	mv	a2,s3
    427a:	85d2                	mv	a1,s4
    427c:	854a                	mv	a0,s2
    427e:	51a010ef          	jal	5798 <read>
    4282:	06a05763          	blez	a0,42f0 <concreate+0x168>
    if (de.inum == 0)
    4286:	f6045783          	lhu	a5,-160(s0)
    428a:	d7fd                	beqz	a5,4278 <concreate+0xf0>
    if (de.name[0] == 'C' && de.name[2] == '\0') {
    428c:	f6244783          	lbu	a5,-158(s0)
    4290:	ff5794e3          	bne	a5,s5,4278 <concreate+0xf0>
    4294:	f6444783          	lbu	a5,-156(s0)
    4298:	f3e5                	bnez	a5,4278 <concreate+0xf0>
      i = de.name[1] - '0';
    429a:	f6344783          	lbu	a5,-157(s0)
    429e:	fd07879b          	addiw	a5,a5,-48
      if (i < 0 || i >= sizeof(fa)) {
    42a2:	00fbef63          	bltu	s7,a5,42c0 <concreate+0x138>
      if (fa[i]) {
    42a6:	fa040713          	addi	a4,s0,-96
    42aa:	973e                	add	a4,a4,a5
    42ac:	fd074703          	lbu	a4,-48(a4)
    42b0:	e705                	bnez	a4,42d8 <concreate+0x150>
      fa[i] = 1;
    42b2:	fa040713          	addi	a4,s0,-96
    42b6:	97ba                	add	a5,a5,a4
    42b8:	fd878823          	sb	s8,-48(a5)
      n++;
    42bc:	2b05                	addiw	s6,s6,1
    42be:	bf6d                	j	4278 <concreate+0xf0>
        printf("%s: concreate weird file %s\n", s, de.name);
    42c0:	f6240613          	addi	a2,s0,-158
    42c4:	85ea                	mv	a1,s10
    42c6:	00004517          	auipc	a0,0x4
    42ca:	91a50513          	addi	a0,a0,-1766 # 7be0 <malloc+0x1f2e>
    42ce:	129010ef          	jal	5bf6 <printf>
        exit(1);
    42d2:	4505                	li	a0,1
    42d4:	4ac010ef          	jal	5780 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    42d8:	f6240613          	addi	a2,s0,-158
    42dc:	85ea                	mv	a1,s10
    42de:	00004517          	auipc	a0,0x4
    42e2:	92250513          	addi	a0,a0,-1758 # 7c00 <malloc+0x1f4e>
    42e6:	111010ef          	jal	5bf6 <printf>
        exit(1);
    42ea:	4505                	li	a0,1
    42ec:	494010ef          	jal	5780 <exit>
  close(fd);
    42f0:	854a                	mv	a0,s2
    42f2:	4b6010ef          	jal	57a8 <close>
  if (n != N) {
    42f6:	02800793          	li	a5,40
    42fa:	00fb1a63          	bne	s6,a5,430e <concreate+0x186>
    if (((i % 3) == 0 && pid == 0) || ((i % 3) == 1 && pid != 0)) {
    42fe:	55555a37          	lui	s4,0x55555
    4302:	556a0a13          	addi	s4,s4,1366 # 55555556 <base+0x5553405e>
      close(open(file, 0));
    4306:	f9840993          	addi	s3,s0,-104
  for (i = 0; i < N; i++) {
    430a:	8ada                	mv	s5,s6
    430c:	a049                	j	438e <concreate+0x206>
    printf("%s: concreate not enough files in directory listing\n", s);
    430e:	85ea                	mv	a1,s10
    4310:	00004517          	auipc	a0,0x4
    4314:	91850513          	addi	a0,a0,-1768 # 7c28 <malloc+0x1f76>
    4318:	0df010ef          	jal	5bf6 <printf>
    exit(1);
    431c:	4505                	li	a0,1
    431e:	462010ef          	jal	5780 <exit>
      printf("%s: fork failed\n", s);
    4322:	85ea                	mv	a1,s10
    4324:	00002517          	auipc	a0,0x2
    4328:	35450513          	addi	a0,a0,852 # 6678 <malloc+0x9c6>
    432c:	0cb010ef          	jal	5bf6 <printf>
      exit(1);
    4330:	4505                	li	a0,1
    4332:	44e010ef          	jal	5780 <exit>
      close(open(file, 0));
    4336:	4581                	li	a1,0
    4338:	854e                	mv	a0,s3
    433a:	486010ef          	jal	57c0 <open>
    433e:	46a010ef          	jal	57a8 <close>
      close(open(file, 0));
    4342:	4581                	li	a1,0
    4344:	854e                	mv	a0,s3
    4346:	47a010ef          	jal	57c0 <open>
    434a:	45e010ef          	jal	57a8 <close>
      close(open(file, 0));
    434e:	4581                	li	a1,0
    4350:	854e                	mv	a0,s3
    4352:	46e010ef          	jal	57c0 <open>
    4356:	452010ef          	jal	57a8 <close>
      close(open(file, 0));
    435a:	4581                	li	a1,0
    435c:	854e                	mv	a0,s3
    435e:	462010ef          	jal	57c0 <open>
    4362:	446010ef          	jal	57a8 <close>
      close(open(file, 0));
    4366:	4581                	li	a1,0
    4368:	854e                	mv	a0,s3
    436a:	456010ef          	jal	57c0 <open>
    436e:	43a010ef          	jal	57a8 <close>
      close(open(file, 0));
    4372:	4581                	li	a1,0
    4374:	854e                	mv	a0,s3
    4376:	44a010ef          	jal	57c0 <open>
    437a:	42e010ef          	jal	57a8 <close>
    if (pid == 0)
    437e:	06090a63          	beqz	s2,43f2 <concreate+0x26a>
      wait(0);
    4382:	4501                	li	a0,0
    4384:	404010ef          	jal	5788 <wait>
  for (i = 0; i < N; i++) {
    4388:	2485                	addiw	s1,s1,1
    438a:	0d548563          	beq	s1,s5,4454 <concreate+0x2cc>
    file[1] = '0' + i;
    438e:	0304879b          	addiw	a5,s1,48
    4392:	f8f40ca3          	sb	a5,-103(s0)
    pid = fork();
    4396:	3e2010ef          	jal	5778 <fork>
    439a:	892a                	mv	s2,a0
    if (pid < 0) {
    439c:	f80543e3          	bltz	a0,4322 <concreate+0x19a>
    if (((i % 3) == 0 && pid == 0) || ((i % 3) == 1 && pid != 0)) {
    43a0:	03448733          	mul	a4,s1,s4
    43a4:	9301                	srli	a4,a4,0x20
    43a6:	41f4d79b          	sraiw	a5,s1,0x1f
    43aa:	9f1d                	subw	a4,a4,a5
    43ac:	0017179b          	slliw	a5,a4,0x1
    43b0:	9fb9                	addw	a5,a5,a4
    43b2:	40f487bb          	subw	a5,s1,a5
    43b6:	00a7e733          	or	a4,a5,a0
    43ba:	2701                	sext.w	a4,a4
    43bc:	df2d                	beqz	a4,4336 <concreate+0x1ae>
    43be:	00a03733          	snez	a4,a0
    43c2:	17fd                	addi	a5,a5,-1
    43c4:	0017b793          	seqz	a5,a5
    43c8:	8ff9                	and	a5,a5,a4
    43ca:	f7b5                	bnez	a5,4336 <concreate+0x1ae>
      unlink(file);
    43cc:	854e                	mv	a0,s3
    43ce:	402010ef          	jal	57d0 <unlink>
      unlink(file);
    43d2:	854e                	mv	a0,s3
    43d4:	3fc010ef          	jal	57d0 <unlink>
      unlink(file);
    43d8:	854e                	mv	a0,s3
    43da:	3f6010ef          	jal	57d0 <unlink>
      unlink(file);
    43de:	854e                	mv	a0,s3
    43e0:	3f0010ef          	jal	57d0 <unlink>
      unlink(file);
    43e4:	854e                	mv	a0,s3
    43e6:	3ea010ef          	jal	57d0 <unlink>
      unlink(file);
    43ea:	854e                	mv	a0,s3
    43ec:	3e4010ef          	jal	57d0 <unlink>
    43f0:	b779                	j	437e <concreate+0x1f6>
      exit(0);
    43f2:	4501                	li	a0,0
    43f4:	38c010ef          	jal	5780 <exit>
      close(fd);
    43f8:	3b0010ef          	jal	57a8 <close>
    if (pid == 0) {
    43fc:	b581                	j	423c <concreate+0xb4>
      close(fd);
    43fe:	3aa010ef          	jal	57a8 <close>
      wait(&xstatus);
    4402:	8556                	mv	a0,s5
    4404:	384010ef          	jal	5788 <wait>
      if (xstatus != 0)
    4408:	f5c42483          	lw	s1,-164(s0)
    440c:	e2049be3          	bnez	s1,4242 <concreate+0xba>
  for (i = 0; i < N; i++) {
    4410:	2905                	addiw	s2,s2,1
    4412:	e3490be3          	beq	s2,s4,4248 <concreate+0xc0>
    file[1] = '0' + i;
    4416:	0309079b          	addiw	a5,s2,48
    441a:	f8f40ca3          	sb	a5,-103(s0)
    unlink(file);
    441e:	854e                	mv	a0,s3
    4420:	3b0010ef          	jal	57d0 <unlink>
    pid = fork();
    4424:	354010ef          	jal	5778 <fork>
    if (pid && (i % 3) == 1) {
    4428:	da050de3          	beqz	a0,41e2 <concreate+0x5a>
    442c:	036907b3          	mul	a5,s2,s6
    4430:	9381                	srli	a5,a5,0x20
    4432:	41f9571b          	sraiw	a4,s2,0x1f
    4436:	9f99                	subw	a5,a5,a4
    4438:	0017971b          	slliw	a4,a5,0x1
    443c:	9fb9                	addw	a5,a5,a4
    443e:	40f907bb          	subw	a5,s2,a5
    4442:	d9778be3          	beq	a5,s7,41d8 <concreate+0x50>
      fd = open(file, O_CREATE | O_RDWR);
    4446:	85e2                	mv	a1,s8
    4448:	854e                	mv	a0,s3
    444a:	376010ef          	jal	57c0 <open>
      if (fd < 0) {
    444e:	fa0558e3          	bgez	a0,43fe <concreate+0x276>
    4452:	b3d1                	j	4216 <concreate+0x8e>
}
    4454:	70aa                	ld	ra,168(sp)
    4456:	740a                	ld	s0,160(sp)
    4458:	64ea                	ld	s1,152(sp)
    445a:	694a                	ld	s2,144(sp)
    445c:	69aa                	ld	s3,136(sp)
    445e:	6a0a                	ld	s4,128(sp)
    4460:	7ae6                	ld	s5,120(sp)
    4462:	7b46                	ld	s6,112(sp)
    4464:	7ba6                	ld	s7,104(sp)
    4466:	7c06                	ld	s8,96(sp)
    4468:	6ce6                	ld	s9,88(sp)
    446a:	6d46                	ld	s10,80(sp)
    446c:	614d                	addi	sp,sp,176
    446e:	8082                	ret

0000000000004470 <bigfile>:
{
    4470:	7139                	addi	sp,sp,-64
    4472:	fc06                	sd	ra,56(sp)
    4474:	f822                	sd	s0,48(sp)
    4476:	f426                	sd	s1,40(sp)
    4478:	f04a                	sd	s2,32(sp)
    447a:	ec4e                	sd	s3,24(sp)
    447c:	e852                	sd	s4,16(sp)
    447e:	e456                	sd	s5,8(sp)
    4480:	e05a                	sd	s6,0(sp)
    4482:	0080                	addi	s0,sp,64
    4484:	8b2a                	mv	s6,a0
  unlink("bigfile.dat");
    4486:	00003517          	auipc	a0,0x3
    448a:	7da50513          	addi	a0,a0,2010 # 7c60 <malloc+0x1fae>
    448e:	342010ef          	jal	57d0 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    4492:	20200593          	li	a1,514
    4496:	00003517          	auipc	a0,0x3
    449a:	7ca50513          	addi	a0,a0,1994 # 7c60 <malloc+0x1fae>
    449e:	322010ef          	jal	57c0 <open>
  if (fd < 0) {
    44a2:	08054a63          	bltz	a0,4536 <bigfile+0xc6>
    44a6:	8a2a                	mv	s4,a0
    44a8:	4481                	li	s1,0
    memset(buf, i, SZ);
    44aa:	25800913          	li	s2,600
    44ae:	00009997          	auipc	s3,0x9
    44b2:	84a98993          	addi	s3,s3,-1974 # ccf8 <buf>
  for (i = 0; i < N; i++) {
    44b6:	4ad1                	li	s5,20
    memset(buf, i, SZ);
    44b8:	864a                	mv	a2,s2
    44ba:	85a6                	mv	a1,s1
    44bc:	854e                	mv	a0,s3
    44be:	098010ef          	jal	5556 <memset>
    if (write(fd, buf, SZ) != SZ) {
    44c2:	864a                	mv	a2,s2
    44c4:	85ce                	mv	a1,s3
    44c6:	8552                	mv	a0,s4
    44c8:	2d8010ef          	jal	57a0 <write>
    44cc:	07251f63          	bne	a0,s2,454a <bigfile+0xda>
  for (i = 0; i < N; i++) {
    44d0:	2485                	addiw	s1,s1,1
    44d2:	ff5493e3          	bne	s1,s5,44b8 <bigfile+0x48>
  close(fd);
    44d6:	8552                	mv	a0,s4
    44d8:	2d0010ef          	jal	57a8 <close>
  fd = open("bigfile.dat", 0);
    44dc:	4581                	li	a1,0
    44de:	00003517          	auipc	a0,0x3
    44e2:	78250513          	addi	a0,a0,1922 # 7c60 <malloc+0x1fae>
    44e6:	2da010ef          	jal	57c0 <open>
    44ea:	8aaa                	mv	s5,a0
  total = 0;
    44ec:	4a01                	li	s4,0
  for (i = 0;; i++) {
    44ee:	4481                	li	s1,0
    cc = read(fd, buf, SZ / 2);
    44f0:	12c00993          	li	s3,300
    44f4:	00009917          	auipc	s2,0x9
    44f8:	80490913          	addi	s2,s2,-2044 # ccf8 <buf>
  if (fd < 0) {
    44fc:	06054163          	bltz	a0,455e <bigfile+0xee>
    cc = read(fd, buf, SZ / 2);
    4500:	864e                	mv	a2,s3
    4502:	85ca                	mv	a1,s2
    4504:	8556                	mv	a0,s5
    4506:	292010ef          	jal	5798 <read>
    if (cc < 0) {
    450a:	06054463          	bltz	a0,4572 <bigfile+0x102>
    if (cc == 0)
    450e:	c145                	beqz	a0,45ae <bigfile+0x13e>
    if (cc != SZ / 2) {
    4510:	07351b63          	bne	a0,s3,4586 <bigfile+0x116>
    if (buf[0] != i / 2 || buf[SZ / 2 - 1] != i / 2) {
    4514:	01f4d79b          	srliw	a5,s1,0x1f
    4518:	9fa5                	addw	a5,a5,s1
    451a:	4017d79b          	sraiw	a5,a5,0x1
    451e:	00094703          	lbu	a4,0(s2)
    4522:	06f71c63          	bne	a4,a5,459a <bigfile+0x12a>
    4526:	12b94703          	lbu	a4,299(s2)
    452a:	06f71863          	bne	a4,a5,459a <bigfile+0x12a>
    total += cc;
    452e:	12ca0a1b          	addiw	s4,s4,300
  for (i = 0;; i++) {
    4532:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ / 2);
    4534:	b7f1                	j	4500 <bigfile+0x90>
    printf("%s: cannot create bigfile", s);
    4536:	85da                	mv	a1,s6
    4538:	00003517          	auipc	a0,0x3
    453c:	73850513          	addi	a0,a0,1848 # 7c70 <malloc+0x1fbe>
    4540:	6b6010ef          	jal	5bf6 <printf>
    exit(1);
    4544:	4505                	li	a0,1
    4546:	23a010ef          	jal	5780 <exit>
      printf("%s: write bigfile failed\n", s);
    454a:	85da                	mv	a1,s6
    454c:	00003517          	auipc	a0,0x3
    4550:	74450513          	addi	a0,a0,1860 # 7c90 <malloc+0x1fde>
    4554:	6a2010ef          	jal	5bf6 <printf>
      exit(1);
    4558:	4505                	li	a0,1
    455a:	226010ef          	jal	5780 <exit>
    printf("%s: cannot open bigfile\n", s);
    455e:	85da                	mv	a1,s6
    4560:	00003517          	auipc	a0,0x3
    4564:	75050513          	addi	a0,a0,1872 # 7cb0 <malloc+0x1ffe>
    4568:	68e010ef          	jal	5bf6 <printf>
    exit(1);
    456c:	4505                	li	a0,1
    456e:	212010ef          	jal	5780 <exit>
      printf("%s: read bigfile failed\n", s);
    4572:	85da                	mv	a1,s6
    4574:	00003517          	auipc	a0,0x3
    4578:	75c50513          	addi	a0,a0,1884 # 7cd0 <malloc+0x201e>
    457c:	67a010ef          	jal	5bf6 <printf>
      exit(1);
    4580:	4505                	li	a0,1
    4582:	1fe010ef          	jal	5780 <exit>
      printf("%s: short read bigfile\n", s);
    4586:	85da                	mv	a1,s6
    4588:	00003517          	auipc	a0,0x3
    458c:	76850513          	addi	a0,a0,1896 # 7cf0 <malloc+0x203e>
    4590:	666010ef          	jal	5bf6 <printf>
      exit(1);
    4594:	4505                	li	a0,1
    4596:	1ea010ef          	jal	5780 <exit>
      printf("%s: read bigfile wrong data\n", s);
    459a:	85da                	mv	a1,s6
    459c:	00003517          	auipc	a0,0x3
    45a0:	76c50513          	addi	a0,a0,1900 # 7d08 <malloc+0x2056>
    45a4:	652010ef          	jal	5bf6 <printf>
      exit(1);
    45a8:	4505                	li	a0,1
    45aa:	1d6010ef          	jal	5780 <exit>
  close(fd);
    45ae:	8556                	mv	a0,s5
    45b0:	1f8010ef          	jal	57a8 <close>
  if (total != N * SZ) {
    45b4:	678d                	lui	a5,0x3
    45b6:	ee078793          	addi	a5,a5,-288 # 2ee0 <subdir+0x340>
    45ba:	02fa1263          	bne	s4,a5,45de <bigfile+0x16e>
  unlink("bigfile.dat");
    45be:	00003517          	auipc	a0,0x3
    45c2:	6a250513          	addi	a0,a0,1698 # 7c60 <malloc+0x1fae>
    45c6:	20a010ef          	jal	57d0 <unlink>
}
    45ca:	70e2                	ld	ra,56(sp)
    45cc:	7442                	ld	s0,48(sp)
    45ce:	74a2                	ld	s1,40(sp)
    45d0:	7902                	ld	s2,32(sp)
    45d2:	69e2                	ld	s3,24(sp)
    45d4:	6a42                	ld	s4,16(sp)
    45d6:	6aa2                	ld	s5,8(sp)
    45d8:	6b02                	ld	s6,0(sp)
    45da:	6121                	addi	sp,sp,64
    45dc:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    45de:	85da                	mv	a1,s6
    45e0:	00003517          	auipc	a0,0x3
    45e4:	74850513          	addi	a0,a0,1864 # 7d28 <malloc+0x2076>
    45e8:	60e010ef          	jal	5bf6 <printf>
    exit(1);
    45ec:	4505                	li	a0,1
    45ee:	192010ef          	jal	5780 <exit>

00000000000045f2 <bigargtest>:
{
    45f2:	7121                	addi	sp,sp,-448
    45f4:	ff06                	sd	ra,440(sp)
    45f6:	fb22                	sd	s0,432(sp)
    45f8:	f726                	sd	s1,424(sp)
    45fa:	0380                	addi	s0,sp,448
    45fc:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    45fe:	00003517          	auipc	a0,0x3
    4602:	74a50513          	addi	a0,a0,1866 # 7d48 <malloc+0x2096>
    4606:	1ca010ef          	jal	57d0 <unlink>
  pid = fork();
    460a:	16e010ef          	jal	5778 <fork>
  if (pid == 0) {
    460e:	c915                	beqz	a0,4642 <bigargtest+0x50>
  } else if (pid < 0) {
    4610:	08054c63          	bltz	a0,46a8 <bigargtest+0xb6>
  wait(&xstatus);
    4614:	fdc40513          	addi	a0,s0,-36
    4618:	170010ef          	jal	5788 <wait>
  if (xstatus != 0)
    461c:	fdc42503          	lw	a0,-36(s0)
    4620:	ed51                	bnez	a0,46bc <bigargtest+0xca>
  fd = open("bigarg-ok", 0);
    4622:	4581                	li	a1,0
    4624:	00003517          	auipc	a0,0x3
    4628:	72450513          	addi	a0,a0,1828 # 7d48 <malloc+0x2096>
    462c:	194010ef          	jal	57c0 <open>
  if (fd < 0) {
    4630:	08054863          	bltz	a0,46c0 <bigargtest+0xce>
  close(fd);
    4634:	174010ef          	jal	57a8 <close>
}
    4638:	70fa                	ld	ra,440(sp)
    463a:	745a                	ld	s0,432(sp)
    463c:	74ba                	ld	s1,424(sp)
    463e:	6139                	addi	sp,sp,448
    4640:	8082                	ret
    memset(big, ' ', sizeof(big));
    4642:	19000613          	li	a2,400
    4646:	02000593          	li	a1,32
    464a:	e4840513          	addi	a0,s0,-440
    464e:	709000ef          	jal	5556 <memset>
    big[sizeof(big) - 1] = '\0';
    4652:	fc040ba3          	sb	zero,-41(s0)
    for (i = 0; i < MAXARG - 1; i++)
    4656:	00005797          	auipc	a5,0x5
    465a:	e8a78793          	addi	a5,a5,-374 # 94e0 <args.1>
    465e:	00005697          	auipc	a3,0x5
    4662:	f7a68693          	addi	a3,a3,-134 # 95d8 <args.1+0xf8>
      args[i] = big;
    4666:	e4840713          	addi	a4,s0,-440
    466a:	e398                	sd	a4,0(a5)
    for (i = 0; i < MAXARG - 1; i++)
    466c:	07a1                	addi	a5,a5,8
    466e:	fed79ee3          	bne	a5,a3,466a <bigargtest+0x78>
    args[MAXARG - 1] = 0;
    4672:	00005797          	auipc	a5,0x5
    4676:	f607b323          	sd	zero,-154(a5) # 95d8 <args.1+0xf8>
    exec("echo", args);
    467a:	00005597          	auipc	a1,0x5
    467e:	e6658593          	addi	a1,a1,-410 # 94e0 <args.1>
    4682:	00001517          	auipc	a0,0x1
    4686:	76650513          	addi	a0,a0,1894 # 5de8 <malloc+0x136>
    468a:	12e010ef          	jal	57b8 <exec>
    fd = open("bigarg-ok", O_CREATE);
    468e:	20000593          	li	a1,512
    4692:	00003517          	auipc	a0,0x3
    4696:	6b650513          	addi	a0,a0,1718 # 7d48 <malloc+0x2096>
    469a:	126010ef          	jal	57c0 <open>
    close(fd);
    469e:	10a010ef          	jal	57a8 <close>
    exit(0);
    46a2:	4501                	li	a0,0
    46a4:	0dc010ef          	jal	5780 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    46a8:	85a6                	mv	a1,s1
    46aa:	00003517          	auipc	a0,0x3
    46ae:	6ae50513          	addi	a0,a0,1710 # 7d58 <malloc+0x20a6>
    46b2:	544010ef          	jal	5bf6 <printf>
    exit(1);
    46b6:	4505                	li	a0,1
    46b8:	0c8010ef          	jal	5780 <exit>
    exit(xstatus);
    46bc:	0c4010ef          	jal	5780 <exit>
    printf("%s: bigarg test failed!\n", s);
    46c0:	85a6                	mv	a1,s1
    46c2:	00003517          	auipc	a0,0x3
    46c6:	6b650513          	addi	a0,a0,1718 # 7d78 <malloc+0x20c6>
    46ca:	52c010ef          	jal	5bf6 <printf>
    exit(1);
    46ce:	4505                	li	a0,1
    46d0:	0b0010ef          	jal	5780 <exit>

00000000000046d4 <partial_write>:
{
    46d4:	bb010113          	addi	sp,sp,-1104
    46d8:	44113423          	sd	ra,1096(sp)
    46dc:	44813023          	sd	s0,1088(sp)
    46e0:	42913c23          	sd	s1,1080(sp)
    46e4:	43213823          	sd	s2,1072(sp)
    46e8:	43313423          	sd	s3,1064(sp)
    46ec:	43413023          	sd	s4,1056(sp)
    46f0:	41513c23          	sd	s5,1048(sp)
    46f4:	45010413          	addi	s0,sp,1104
    46f8:	8aaa                	mv	s5,a0
  unlink("testfile");
    46fa:	00003517          	auipc	a0,0x3
    46fe:	69e50513          	addi	a0,a0,1694 # 7d98 <malloc+0x20e6>
    4702:	0ce010ef          	jal	57d0 <unlink>
  int fd = open("testfile", O_CREATE | O_RDWR);
    4706:	20200593          	li	a1,514
    470a:	00003517          	auipc	a0,0x3
    470e:	68e50513          	addi	a0,a0,1678 # 7d98 <malloc+0x20e6>
    4712:	0ae010ef          	jal	57c0 <open>
  if (fd < 0) {
    4716:	14054f63          	bltz	a0,4874 <partial_write+0x1a0>
    471a:	84aa                	mv	s1,a0
  int cc = write(fd, "A", 1);
    471c:	4605                	li	a2,1
    471e:	00003597          	auipc	a1,0x3
    4722:	6aa58593          	addi	a1,a1,1706 # 7dc8 <malloc+0x2116>
    4726:	07a010ef          	jal	57a0 <write>
  if (cc != 1) {
    472a:	4785                	li	a5,1
    472c:	14f51e63          	bne	a0,a5,4888 <partial_write+0x1b4>
  close(fd);
    4730:	8526                	mv	a0,s1
    4732:	076010ef          	jal	57a8 <close>
  fd = open("testfile", O_RDWR);
    4736:	4589                	li	a1,2
    4738:	00003517          	auipc	a0,0x3
    473c:	66050513          	addi	a0,a0,1632 # 7d98 <malloc+0x20e6>
    4740:	080010ef          	jal	57c0 <open>
    4744:	84aa                	mv	s1,a0
  if (fd < 0) {
    4746:	14054b63          	bltz	a0,489c <partial_write+0x1c8>
  char *p = sbrk(0);
    474a:	4501                	li	a0,0
    474c:	000010ef          	jal	574c <sbrk>
  sbrk(PGSIZE - ((uint64)p % PGSIZE));
    4750:	03451793          	slli	a5,a0,0x34
    4754:	93d1                	srli	a5,a5,0x34
    4756:	6505                	lui	a0,0x1
    4758:	9d1d                	subw	a0,a0,a5
    475a:	7f3000ef          	jal	574c <sbrk>
  p = sbrk(0);
    475e:	4501                	li	a0,0
    4760:	7ed000ef          	jal	574c <sbrk>
  if ((uint64)p % PGSIZE != 0) {
    4764:	03451793          	slli	a5,a0,0x34
    4768:	14079463          	bnez	a5,48b0 <partial_write+0x1dc>
  p[-1] = 'X';
    476c:	05800793          	li	a5,88
    4770:	fef50fa3          	sb	a5,-1(a0) # fff <bigdir+0xff>
  cc = write(fd, p - 1, 2);
    4774:	4609                	li	a2,2
    4776:	fff50593          	addi	a1,a0,-1
    477a:	8526                	mv	a0,s1
    477c:	024010ef          	jal	57a0 <write>
  if (cc != -1) {
    4780:	57fd                	li	a5,-1
    4782:	14f51163          	bne	a0,a5,48c4 <partial_write+0x1f0>
  close(fd);
    4786:	8526                	mv	a0,s1
    4788:	020010ef          	jal	57a8 <close>
  fd = open("testfile", O_RDONLY);
    478c:	4581                	li	a1,0
    478e:	00003517          	auipc	a0,0x3
    4792:	60a50513          	addi	a0,a0,1546 # 7d98 <malloc+0x20e6>
    4796:	02a010ef          	jal	57c0 <open>
    479a:	84aa                	mv	s1,a0
  if (fd < 0) {
    479c:	12054e63          	bltz	a0,48d8 <partial_write+0x204>
  cc = read(fd, &b, 1);
    47a0:	4605                	li	a2,1
    47a2:	fbf40593          	addi	a1,s0,-65
    47a6:	7f3000ef          	jal	5798 <read>
  if (cc != 1) {
    47aa:	4785                	li	a5,1
    47ac:	14f51063          	bne	a0,a5,48ec <partial_write+0x218>
  close(fd);
    47b0:	8526                	mv	a0,s1
    47b2:	7f7000ef          	jal	57a8 <close>
  if (b != 'X') {
    47b6:	fbf44603          	lbu	a2,-65(s0)
    47ba:	05800793          	li	a5,88
    47be:	14f61163          	bne	a2,a5,4900 <partial_write+0x22c>
  fd = open("bigfile", O_CREATE | O_RDWR);
    47c2:	20200593          	li	a1,514
    47c6:	00003517          	auipc	a0,0x3
    47ca:	6d250513          	addi	a0,a0,1746 # 7e98 <malloc+0x21e6>
    47ce:	7f3000ef          	jal	57c0 <open>
    47d2:	8a2a                	mv	s4,a0
    47d4:	04000913          	li	s2,64
    memset(buf, 0, sizeof(buf));
    47d8:	bb840993          	addi	s3,s0,-1096
    47dc:	40000493          	li	s1,1024
    47e0:	8626                	mv	a2,s1
    47e2:	4581                	li	a1,0
    47e4:	854e                	mv	a0,s3
    47e6:	571000ef          	jal	5556 <memset>
    cc = write(fd, buf, sizeof(buf));
    47ea:	8626                	mv	a2,s1
    47ec:	85ce                	mv	a1,s3
    47ee:	8552                	mv	a0,s4
    47f0:	7b1000ef          	jal	57a0 <write>
    if (cc != sizeof(buf)) {
    47f4:	12951063          	bne	a0,s1,4914 <partial_write+0x240>
  for (int i = 0; i < 64; i++) {
    47f8:	397d                	addiw	s2,s2,-1
    47fa:	fe0913e3          	bnez	s2,47e0 <partial_write+0x10c>
  close(fd);
    47fe:	8552                	mv	a0,s4
    4800:	7a9000ef          	jal	57a8 <close>
  unlink("bigfile");
    4804:	00003517          	auipc	a0,0x3
    4808:	69450513          	addi	a0,a0,1684 # 7e98 <malloc+0x21e6>
    480c:	7c5000ef          	jal	57d0 <unlink>
  fd = open("testfile", O_RDONLY);
    4810:	4581                	li	a1,0
    4812:	00003517          	auipc	a0,0x3
    4816:	58650513          	addi	a0,a0,1414 # 7d98 <malloc+0x20e6>
    481a:	7a7000ef          	jal	57c0 <open>
    481e:	84aa                	mv	s1,a0
  if (fd < 0) {
    4820:	10054463          	bltz	a0,4928 <partial_write+0x254>
  cc = read(fd, &b, 1);
    4824:	4605                	li	a2,1
    4826:	fbf40593          	addi	a1,s0,-65
    482a:	76f000ef          	jal	5798 <read>
  if (cc != 1) {
    482e:	4785                	li	a5,1
    4830:	10f51663          	bne	a0,a5,493c <partial_write+0x268>
  close(fd);
    4834:	8526                	mv	a0,s1
    4836:	773000ef          	jal	57a8 <close>
  if (b != 'X') {
    483a:	fbf44603          	lbu	a2,-65(s0)
    483e:	05800793          	li	a5,88
    4842:	10f61763          	bne	a2,a5,4950 <partial_write+0x27c>
  unlink("testfile");
    4846:	00003517          	auipc	a0,0x3
    484a:	55250513          	addi	a0,a0,1362 # 7d98 <malloc+0x20e6>
    484e:	783000ef          	jal	57d0 <unlink>
}
    4852:	44813083          	ld	ra,1096(sp)
    4856:	44013403          	ld	s0,1088(sp)
    485a:	43813483          	ld	s1,1080(sp)
    485e:	43013903          	ld	s2,1072(sp)
    4862:	42813983          	ld	s3,1064(sp)
    4866:	42013a03          	ld	s4,1056(sp)
    486a:	41813a83          	ld	s5,1048(sp)
    486e:	45010113          	addi	sp,sp,1104
    4872:	8082                	ret
    printf("%s: cannot create testfile\n", s);
    4874:	85d6                	mv	a1,s5
    4876:	00003517          	auipc	a0,0x3
    487a:	53250513          	addi	a0,a0,1330 # 7da8 <malloc+0x20f6>
    487e:	378010ef          	jal	5bf6 <printf>
    exit(1);
    4882:	4505                	li	a0,1
    4884:	6fd000ef          	jal	5780 <exit>
    printf("%s: could not write A\n", s);
    4888:	85d6                	mv	a1,s5
    488a:	00003517          	auipc	a0,0x3
    488e:	54650513          	addi	a0,a0,1350 # 7dd0 <malloc+0x211e>
    4892:	364010ef          	jal	5bf6 <printf>
    exit(1);
    4896:	4505                	li	a0,1
    4898:	6e9000ef          	jal	5780 <exit>
    printf("%s: cannot re-open testfile\n", s);
    489c:	85d6                	mv	a1,s5
    489e:	00003517          	auipc	a0,0x3
    48a2:	54a50513          	addi	a0,a0,1354 # 7de8 <malloc+0x2136>
    48a6:	350010ef          	jal	5bf6 <printf>
    exit(1);
    48aa:	4505                	li	a0,1
    48ac:	6d5000ef          	jal	5780 <exit>
    printf("%s: sbrk did not align\n", s);
    48b0:	85d6                	mv	a1,s5
    48b2:	00003517          	auipc	a0,0x3
    48b6:	55650513          	addi	a0,a0,1366 # 7e08 <malloc+0x2156>
    48ba:	33c010ef          	jal	5bf6 <printf>
    exit(1);
    48be:	4505                	li	a0,1
    48c0:	6c1000ef          	jal	5780 <exit>
    printf("%s: write succeeded, should have failed\n", s);
    48c4:	85d6                	mv	a1,s5
    48c6:	00003517          	auipc	a0,0x3
    48ca:	55a50513          	addi	a0,a0,1370 # 7e20 <malloc+0x216e>
    48ce:	328010ef          	jal	5bf6 <printf>
    exit(1);
    48d2:	4505                	li	a0,1
    48d4:	6ad000ef          	jal	5780 <exit>
    printf("%s: cannot re-open testfile\n", s);
    48d8:	85d6                	mv	a1,s5
    48da:	00003517          	auipc	a0,0x3
    48de:	50e50513          	addi	a0,a0,1294 # 7de8 <malloc+0x2136>
    48e2:	314010ef          	jal	5bf6 <printf>
    exit(1);
    48e6:	4505                	li	a0,1
    48e8:	699000ef          	jal	5780 <exit>
    printf("%s: cannot read testfile\n", s);
    48ec:	85d6                	mv	a1,s5
    48ee:	00003517          	auipc	a0,0x3
    48f2:	56250513          	addi	a0,a0,1378 # 7e50 <malloc+0x219e>
    48f6:	300010ef          	jal	5bf6 <printf>
    exit(1);
    48fa:	4505                	li	a0,1
    48fc:	685000ef          	jal	5780 <exit>
    printf("%s: read returned %c, expected X\n", s, b);
    4900:	85d6                	mv	a1,s5
    4902:	00003517          	auipc	a0,0x3
    4906:	56e50513          	addi	a0,a0,1390 # 7e70 <malloc+0x21be>
    490a:	2ec010ef          	jal	5bf6 <printf>
    exit(1);
    490e:	4505                	li	a0,1
    4910:	671000ef          	jal	5780 <exit>
      printf("%s: could not write to bigfile\n", s);
    4914:	85d6                	mv	a1,s5
    4916:	00003517          	auipc	a0,0x3
    491a:	58a50513          	addi	a0,a0,1418 # 7ea0 <malloc+0x21ee>
    491e:	2d8010ef          	jal	5bf6 <printf>
      exit(-1);
    4922:	557d                	li	a0,-1
    4924:	65d000ef          	jal	5780 <exit>
    printf("%s: cannot re-open testfile\n", s);
    4928:	85d6                	mv	a1,s5
    492a:	00003517          	auipc	a0,0x3
    492e:	4be50513          	addi	a0,a0,1214 # 7de8 <malloc+0x2136>
    4932:	2c4010ef          	jal	5bf6 <printf>
    exit(1);
    4936:	4505                	li	a0,1
    4938:	649000ef          	jal	5780 <exit>
    printf("%s: cannot read testfile\n", s);
    493c:	85d6                	mv	a1,s5
    493e:	00003517          	auipc	a0,0x3
    4942:	51250513          	addi	a0,a0,1298 # 7e50 <malloc+0x219e>
    4946:	2b0010ef          	jal	5bf6 <printf>
    exit(1);
    494a:	4505                	li	a0,1
    494c:	635000ef          	jal	5780 <exit>
    printf("%s: read returned %c, expected X\n", s, b);
    4950:	85d6                	mv	a1,s5
    4952:	00003517          	auipc	a0,0x3
    4956:	51e50513          	addi	a0,a0,1310 # 7e70 <malloc+0x21be>
    495a:	29c010ef          	jal	5bf6 <printf>
    exit(1);
    495e:	4505                	li	a0,1
    4960:	621000ef          	jal	5780 <exit>

0000000000004964 <lazy_alloc>:
{
    4964:	1141                	addi	sp,sp,-16
    4966:	e406                	sd	ra,8(sp)
    4968:	e022                	sd	s0,0(sp)
    496a:	0800                	addi	s0,sp,16
  prev_end = sbrklazy(REGION_SZ);
    496c:	40000537          	lui	a0,0x40000
    4970:	5f3000ef          	jal	5762 <sbrklazy>
  if (prev_end == (char *)SBRK_ERROR) {
    4974:	57fd                	li	a5,-1
    4976:	02f50a63          	beq	a0,a5,49aa <lazy_alloc+0x46>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE)
    497a:	6605                	lui	a2,0x1
    497c:	962a                	add	a2,a2,a0
    497e:	400017b7          	lui	a5,0x40001
    4982:	00f50733          	add	a4,a0,a5
    4986:	87b2                	mv	a5,a2
    4988:	000406b7          	lui	a3,0x40
    *(char **)i = i;
    498c:	e39c                	sd	a5,0(a5)
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE)
    498e:	97b6                	add	a5,a5,a3
    4990:	fee79ee3          	bne	a5,a4,498c <lazy_alloc+0x28>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE) {
    4994:	000406b7          	lui	a3,0x40
    if (*(char **)i != i) {
    4998:	621c                	ld	a5,0(a2)
    499a:	02c79163          	bne	a5,a2,49bc <lazy_alloc+0x58>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE) {
    499e:	9636                	add	a2,a2,a3
    49a0:	fee61ce3          	bne	a2,a4,4998 <lazy_alloc+0x34>
  exit(0);
    49a4:	4501                	li	a0,0
    49a6:	5db000ef          	jal	5780 <exit>
    printf("sbrklazy() failed\n");
    49aa:	00003517          	auipc	a0,0x3
    49ae:	51650513          	addi	a0,a0,1302 # 7ec0 <malloc+0x220e>
    49b2:	244010ef          	jal	5bf6 <printf>
    exit(1);
    49b6:	4505                	li	a0,1
    49b8:	5c9000ef          	jal	5780 <exit>
      printf("failed to read value from memory\n");
    49bc:	00003517          	auipc	a0,0x3
    49c0:	51c50513          	addi	a0,a0,1308 # 7ed8 <malloc+0x2226>
    49c4:	232010ef          	jal	5bf6 <printf>
      exit(1);
    49c8:	4505                	li	a0,1
    49ca:	5b7000ef          	jal	5780 <exit>

00000000000049ce <lazy_unmap>:
{
    49ce:	7139                	addi	sp,sp,-64
    49d0:	fc06                	sd	ra,56(sp)
    49d2:	f822                	sd	s0,48(sp)
    49d4:	0080                	addi	s0,sp,64
  prev_end = sbrklazy(REGION_SZ);
    49d6:	40000537          	lui	a0,0x40000
    49da:	589000ef          	jal	5762 <sbrklazy>
  if (prev_end == (char *)SBRK_ERROR) {
    49de:	57fd                	li	a5,-1
    49e0:	04f50863          	beq	a0,a5,4a30 <lazy_unmap+0x62>
    49e4:	f426                	sd	s1,40(sp)
    49e6:	f04a                	sd	s2,32(sp)
    49e8:	ec4e                	sd	s3,24(sp)
    49ea:	e852                	sd	s4,16(sp)
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE)
    49ec:	6905                	lui	s2,0x1
    49ee:	992a                	add	s2,s2,a0
    49f0:	400017b7          	lui	a5,0x40001
    49f4:	00f504b3          	add	s1,a0,a5
    49f8:	87ca                	mv	a5,s2
    49fa:	01000737          	lui	a4,0x1000
    *(char **)i = i;
    49fe:	e39c                	sd	a5,0(a5)
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE)
    4a00:	97ba                	add	a5,a5,a4
    4a02:	fe979ee3          	bne	a5,s1,49fe <lazy_unmap+0x30>
      wait(&status);
    4a06:	fcc40993          	addi	s3,s0,-52
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE) {
    4a0a:	01000a37          	lui	s4,0x1000
    pid = fork();
    4a0e:	56b000ef          	jal	5778 <fork>
    if (pid < 0) {
    4a12:	02054c63          	bltz	a0,4a4a <lazy_unmap+0x7c>
    } else if (pid == 0) {
    4a16:	c139                	beqz	a0,4a5c <lazy_unmap+0x8e>
      wait(&status);
    4a18:	854e                	mv	a0,s3
    4a1a:	56f000ef          	jal	5788 <wait>
      if (status == 0) {
    4a1e:	fcc42783          	lw	a5,-52(s0)
    4a22:	c7b1                	beqz	a5,4a6e <lazy_unmap+0xa0>
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE) {
    4a24:	9952                	add	s2,s2,s4
    4a26:	fe9914e3          	bne	s2,s1,4a0e <lazy_unmap+0x40>
  exit(0);
    4a2a:	4501                	li	a0,0
    4a2c:	555000ef          	jal	5780 <exit>
    4a30:	f426                	sd	s1,40(sp)
    4a32:	f04a                	sd	s2,32(sp)
    4a34:	ec4e                	sd	s3,24(sp)
    4a36:	e852                	sd	s4,16(sp)
    printf("sbrklazy() failed\n");
    4a38:	00003517          	auipc	a0,0x3
    4a3c:	48850513          	addi	a0,a0,1160 # 7ec0 <malloc+0x220e>
    4a40:	1b6010ef          	jal	5bf6 <printf>
    exit(1);
    4a44:	4505                	li	a0,1
    4a46:	53b000ef          	jal	5780 <exit>
      printf("error forking\n");
    4a4a:	00003517          	auipc	a0,0x3
    4a4e:	4b650513          	addi	a0,a0,1206 # 7f00 <malloc+0x224e>
    4a52:	1a4010ef          	jal	5bf6 <printf>
      exit(1);
    4a56:	4505                	li	a0,1
    4a58:	529000ef          	jal	5780 <exit>
      sbrklazy(-1L * REGION_SZ);
    4a5c:	c0000537          	lui	a0,0xc0000
    4a60:	503000ef          	jal	5762 <sbrklazy>
      *(char **)i = i;
    4a64:	01293023          	sd	s2,0(s2) # 1000 <bigdir+0x100>
      exit(0);
    4a68:	4501                	li	a0,0
    4a6a:	517000ef          	jal	5780 <exit>
        printf("memory not unmapped\n");
    4a6e:	00003517          	auipc	a0,0x3
    4a72:	4a250513          	addi	a0,a0,1186 # 7f10 <malloc+0x225e>
    4a76:	180010ef          	jal	5bf6 <printf>
        exit(1);
    4a7a:	4505                	li	a0,1
    4a7c:	505000ef          	jal	5780 <exit>

0000000000004a80 <lazy_copy>:
{
    4a80:	7119                	addi	sp,sp,-128
    4a82:	fc86                	sd	ra,120(sp)
    4a84:	f8a2                	sd	s0,112(sp)
    4a86:	f4a6                	sd	s1,104(sp)
    4a88:	f0ca                	sd	s2,96(sp)
    4a8a:	ecce                	sd	s3,88(sp)
    4a8c:	e8d2                	sd	s4,80(sp)
    4a8e:	e4d6                	sd	s5,72(sp)
    4a90:	e0da                	sd	s6,64(sp)
    4a92:	fc5e                	sd	s7,56(sp)
    4a94:	0100                	addi	s0,sp,128
    char *p = sbrk(0);
    4a96:	4501                	li	a0,0
    4a98:	4b5000ef          	jal	574c <sbrk>
    4a9c:	84aa                	mv	s1,a0
    sbrklazy(4 * PGSIZE);
    4a9e:	6511                	lui	a0,0x4
    4aa0:	4c3000ef          	jal	5762 <sbrklazy>
    open(p + 8192, 0);
    4aa4:	4581                	li	a1,0
    4aa6:	6509                	lui	a0,0x2
    4aa8:	9526                	add	a0,a0,s1
    4aaa:	517000ef          	jal	57c0 <open>
    void *xx = sbrk(0);
    4aae:	4501                	li	a0,0
    4ab0:	49d000ef          	jal	574c <sbrk>
    4ab4:	84aa                	mv	s1,a0
    void *ret = sbrk(-(((uint64)xx) + 1));
    4ab6:	fff54513          	not	a0,a0
    4aba:	2501                	sext.w	a0,a0
    4abc:	491000ef          	jal	574c <sbrk>
    if (ret != xx) {
    4ac0:	00a48c63          	beq	s1,a0,4ad8 <lazy_copy+0x58>
    4ac4:	85aa                	mv	a1,a0
      printf("sbrk(sbrk(0)+1) returned %p, not old sz\n", ret);
    4ac6:	00003517          	auipc	a0,0x3
    4aca:	46250513          	addi	a0,a0,1122 # 7f28 <malloc+0x2276>
    4ace:	128010ef          	jal	5bf6 <printf>
      exit(1);
    4ad2:	4505                	li	a0,1
    4ad4:	4ad000ef          	jal	5780 <exit>
  unsigned long bad[] = {
    4ad8:	00004797          	auipc	a5,0x4
    4adc:	c0878793          	addi	a5,a5,-1016 # 86e0 <malloc+0x2a2e>
    4ae0:	7fa8                	ld	a0,120(a5)
    4ae2:	63cc                	ld	a1,128(a5)
    4ae4:	67d0                	ld	a2,136(a5)
    4ae6:	6bd4                	ld	a3,144(a5)
    4ae8:	6fd8                	ld	a4,152(a5)
    4aea:	f8a43023          	sd	a0,-128(s0)
    4aee:	f8b43423          	sd	a1,-120(s0)
    4af2:	f8c43823          	sd	a2,-112(s0)
    4af6:	f8d43c23          	sd	a3,-104(s0)
    4afa:	fae43023          	sd	a4,-96(s0)
    4afe:	73dc                	ld	a5,160(a5)
    4b00:	faf43423          	sd	a5,-88(s0)
  for (int i = 0; i < sizeof(bad) / sizeof(bad[0]); i++) {
    4b04:	f8040913          	addi	s2,s0,-128
    int fd = open("README", 0);
    4b08:	00001a97          	auipc	s5,0x1
    4b0c:	4b8a8a93          	addi	s5,s5,1208 # 5fc0 <malloc+0x30e>
    if (read(fd, (char *)bad[i], 512) >= 0) {
    4b10:	20000a13          	li	s4,512
    fd = open("junk", O_CREATE | O_RDWR | O_TRUNC);
    4b14:	60200b93          	li	s7,1538
    4b18:	00001b17          	auipc	s6,0x1
    4b1c:	3b8b0b13          	addi	s6,s6,952 # 5ed0 <malloc+0x21e>
    int fd = open("README", 0);
    4b20:	4581                	li	a1,0
    4b22:	8556                	mv	a0,s5
    4b24:	49d000ef          	jal	57c0 <open>
    4b28:	84aa                	mv	s1,a0
    if (fd < 0) {
    4b2a:	04054563          	bltz	a0,4b74 <lazy_copy+0xf4>
    if (read(fd, (char *)bad[i], 512) >= 0) {
    4b2e:	00093983          	ld	s3,0(s2)
    4b32:	8652                	mv	a2,s4
    4b34:	85ce                	mv	a1,s3
    4b36:	463000ef          	jal	5798 <read>
    4b3a:	04055663          	bgez	a0,4b86 <lazy_copy+0x106>
    close(fd);
    4b3e:	8526                	mv	a0,s1
    4b40:	469000ef          	jal	57a8 <close>
    fd = open("junk", O_CREATE | O_RDWR | O_TRUNC);
    4b44:	85de                	mv	a1,s7
    4b46:	855a                	mv	a0,s6
    4b48:	479000ef          	jal	57c0 <open>
    4b4c:	84aa                	mv	s1,a0
    if (fd < 0) {
    4b4e:	04054563          	bltz	a0,4b98 <lazy_copy+0x118>
    if (write(fd, (char *)bad[i], 512) >= 0) {
    4b52:	8652                	mv	a2,s4
    4b54:	85ce                	mv	a1,s3
    4b56:	44b000ef          	jal	57a0 <write>
    4b5a:	04055863          	bgez	a0,4baa <lazy_copy+0x12a>
    close(fd);
    4b5e:	8526                	mv	a0,s1
    4b60:	449000ef          	jal	57a8 <close>
  for (int i = 0; i < sizeof(bad) / sizeof(bad[0]); i++) {
    4b64:	0921                	addi	s2,s2,8
    4b66:	fb040793          	addi	a5,s0,-80
    4b6a:	faf91be3          	bne	s2,a5,4b20 <lazy_copy+0xa0>
  exit(0);
    4b6e:	4501                	li	a0,0
    4b70:	411000ef          	jal	5780 <exit>
      printf("cannot open README\n");
    4b74:	00003517          	auipc	a0,0x3
    4b78:	3e450513          	addi	a0,a0,996 # 7f58 <malloc+0x22a6>
    4b7c:	07a010ef          	jal	5bf6 <printf>
      exit(1);
    4b80:	4505                	li	a0,1
    4b82:	3ff000ef          	jal	5780 <exit>
      printf("read succeeded\n");
    4b86:	00003517          	auipc	a0,0x3
    4b8a:	3ea50513          	addi	a0,a0,1002 # 7f70 <malloc+0x22be>
    4b8e:	068010ef          	jal	5bf6 <printf>
      exit(1);
    4b92:	4505                	li	a0,1
    4b94:	3ed000ef          	jal	5780 <exit>
      printf("cannot open junk\n");
    4b98:	00003517          	auipc	a0,0x3
    4b9c:	3e850513          	addi	a0,a0,1000 # 7f80 <malloc+0x22ce>
    4ba0:	056010ef          	jal	5bf6 <printf>
      exit(1);
    4ba4:	4505                	li	a0,1
    4ba6:	3db000ef          	jal	5780 <exit>
      printf("write succeeded\n");
    4baa:	00003517          	auipc	a0,0x3
    4bae:	3ee50513          	addi	a0,a0,1006 # 7f98 <malloc+0x22e6>
    4bb2:	044010ef          	jal	5bf6 <printf>
      exit(1);
    4bb6:	4505                	li	a0,1
    4bb8:	3c9000ef          	jal	5780 <exit>

0000000000004bbc <lazy_sbrk>:
{
    4bbc:	7179                	addi	sp,sp,-48
    4bbe:	f406                	sd	ra,40(sp)
    4bc0:	f022                	sd	s0,32(sp)
    4bc2:	ec26                	sd	s1,24(sp)
    4bc4:	e84a                	sd	s2,16(sp)
    4bc6:	e44e                	sd	s3,8(sp)
    4bc8:	1800                	addi	s0,sp,48
  char *p = sbrk(0);
    4bca:	4501                	li	a0,0
    4bcc:	381000ef          	jal	574c <sbrk>
    4bd0:	84aa                	mv	s1,a0
  while ((uint64)p < MAXVA - (1 << 30)) {
    4bd2:	0ff00793          	li	a5,255
    4bd6:	07fa                	slli	a5,a5,0x1e
    4bd8:	00f57e63          	bgeu	a0,a5,4bf4 <lazy_sbrk+0x38>
    p = sbrklazy(1 << 30);
    4bdc:	400009b7          	lui	s3,0x40000
  while ((uint64)p < MAXVA - (1 << 30)) {
    4be0:	893e                	mv	s2,a5
    p = sbrklazy(1 << 30);
    4be2:	854e                	mv	a0,s3
    4be4:	37f000ef          	jal	5762 <sbrklazy>
    p = sbrklazy(0);
    4be8:	4501                	li	a0,0
    4bea:	379000ef          	jal	5762 <sbrklazy>
    4bee:	84aa                	mv	s1,a0
  while ((uint64)p < MAXVA - (1 << 30)) {
    4bf0:	ff2569e3          	bltu	a0,s2,4be2 <lazy_sbrk+0x26>
  int n = TRAPFRAME - PGSIZE - (uint64)p;
    4bf4:	7975                	lui	s2,0xffffd
    4bf6:	4099093b          	subw	s2,s2,s1
  char *p1 = sbrklazy(n);
    4bfa:	854a                	mv	a0,s2
    4bfc:	367000ef          	jal	5762 <sbrklazy>
    4c00:	862a                	mv	a2,a0
  if (p1 < 0 || p1 != p) {
    4c02:	00950d63          	beq	a0,s1,4c1c <lazy_sbrk+0x60>
    printf("sbrklazy(%d) returned %p, not expected %p\n", n, p1, p);
    4c06:	86a6                	mv	a3,s1
    4c08:	85ca                	mv	a1,s2
    4c0a:	00003517          	auipc	a0,0x3
    4c0e:	3a650513          	addi	a0,a0,934 # 7fb0 <malloc+0x22fe>
    4c12:	7e5000ef          	jal	5bf6 <printf>
    exit(1);
    4c16:	4505                	li	a0,1
    4c18:	369000ef          	jal	5780 <exit>
  p = sbrk(PGSIZE);
    4c1c:	6505                	lui	a0,0x1
    4c1e:	32f000ef          	jal	574c <sbrk>
    4c22:	862a                	mv	a2,a0
  if (p < 0 || (uint64)p != TRAPFRAME - PGSIZE) {
    4c24:	040007b7          	lui	a5,0x4000
    4c28:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3fdeb05>
    4c2a:	07b2                	slli	a5,a5,0xc
    4c2c:	00f50c63          	beq	a0,a5,4c44 <lazy_sbrk+0x88>
    printf("sbrk(%d) returned %p, not expected TRAPFRAME-PGSIZE\n", PGSIZE, p);
    4c30:	6585                	lui	a1,0x1
    4c32:	00003517          	auipc	a0,0x3
    4c36:	3ae50513          	addi	a0,a0,942 # 7fe0 <malloc+0x232e>
    4c3a:	7bd000ef          	jal	5bf6 <printf>
    exit(1);
    4c3e:	4505                	li	a0,1
    4c40:	341000ef          	jal	5780 <exit>
  p[0] = 1;
    4c44:	040007b7          	lui	a5,0x4000
    4c48:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3fdeb05>
    4c4a:	07b2                	slli	a5,a5,0xc
    4c4c:	4705                	li	a4,1
    4c4e:	00e78023          	sb	a4,0(a5)
  if (p[1] != 0) {
    4c52:	0017c783          	lbu	a5,1(a5)
    4c56:	cb91                	beqz	a5,4c6a <lazy_sbrk+0xae>
    printf("sbrk() returned non-zero-filled memory\n");
    4c58:	00003517          	auipc	a0,0x3
    4c5c:	3c050513          	addi	a0,a0,960 # 8018 <malloc+0x2366>
    4c60:	797000ef          	jal	5bf6 <printf>
    exit(1);
    4c64:	4505                	li	a0,1
    4c66:	31b000ef          	jal	5780 <exit>
  p = sbrk(1);
    4c6a:	4505                	li	a0,1
    4c6c:	2e1000ef          	jal	574c <sbrk>
    4c70:	85aa                	mv	a1,a0
  if ((uint64)p != -1) {
    4c72:	57fd                	li	a5,-1
    4c74:	00f50b63          	beq	a0,a5,4c8a <lazy_sbrk+0xce>
    printf("sbrk(1) returned %p, expected error\n", p);
    4c78:	00003517          	auipc	a0,0x3
    4c7c:	3c850513          	addi	a0,a0,968 # 8040 <malloc+0x238e>
    4c80:	777000ef          	jal	5bf6 <printf>
    exit(1);
    4c84:	4505                	li	a0,1
    4c86:	2fb000ef          	jal	5780 <exit>
  p = sbrklazy(1);
    4c8a:	4505                	li	a0,1
    4c8c:	2d7000ef          	jal	5762 <sbrklazy>
    4c90:	85aa                	mv	a1,a0
  if ((uint64)p != -1) {
    4c92:	57fd                	li	a5,-1
    4c94:	00f50b63          	beq	a0,a5,4caa <lazy_sbrk+0xee>
    printf("sbrklazy(1) returned %p, expected error\n", p);
    4c98:	00003517          	auipc	a0,0x3
    4c9c:	3d050513          	addi	a0,a0,976 # 8068 <malloc+0x23b6>
    4ca0:	757000ef          	jal	5bf6 <printf>
    exit(1);
    4ca4:	4505                	li	a0,1
    4ca6:	2db000ef          	jal	5780 <exit>
  exit(0);
    4caa:	4501                	li	a0,0
    4cac:	2d5000ef          	jal	5780 <exit>

0000000000004cb0 <lazy_copyinstr>:
{
    4cb0:	7139                	addi	sp,sp,-64
    4cb2:	fc06                	sd	ra,56(sp)
    4cb4:	f822                	sd	s0,48(sp)
    4cb6:	f426                	sd	s1,40(sp)
    4cb8:	f04a                	sd	s2,32(sp)
    4cba:	0080                	addi	s0,sp,64
    4cbc:	892a                	mv	s2,a0
  char *p = sbrk(0);
    4cbe:	4501                	li	a0,0
    4cc0:	28d000ef          	jal	574c <sbrk>
  sbrk(PGSIZE - ((uint64)p % PGSIZE));
    4cc4:	03451793          	slli	a5,a0,0x34
    4cc8:	93d1                	srli	a5,a5,0x34
    4cca:	6505                	lui	a0,0x1
    4ccc:	9d1d                	subw	a0,a0,a5
    4cce:	27f000ef          	jal	574c <sbrk>
  p = sbrk(0);
    4cd2:	4501                	li	a0,0
    4cd4:	279000ef          	jal	574c <sbrk>
  if ((uint64)p % PGSIZE != 0) {
    4cd8:	03451793          	slli	a5,a0,0x34
    4cdc:	eba1                	bnez	a5,4d2c <lazy_copyinstr+0x7c>
    4cde:	84aa                	mv	s1,a0
  sbrklazy(2 * PGSIZE);
    4ce0:	6509                	lui	a0,0x2
    4ce2:	281000ef          	jal	5762 <sbrklazy>
  p[4095] = '/';
    4ce6:	6505                	lui	a0,0x1
    4ce8:	00a487b3          	add	a5,s1,a0
    4cec:	02f00713          	li	a4,47
    4cf0:	fee78fa3          	sb	a4,-1(a5)
  int fd = open(&p[4095], O_RDONLY);
    4cf4:	157d                	addi	a0,a0,-1 # fff <bigdir+0xff>
    4cf6:	4581                	li	a1,0
    4cf8:	9526                	add	a0,a0,s1
    4cfa:	2c7000ef          	jal	57c0 <open>
    4cfe:	84aa                	mv	s1,a0
  if (fd < 0) {
    4d00:	04054063          	bltz	a0,4d40 <lazy_copyinstr+0x90>
  int r = fstat(fd, &st);
    4d04:	fc840593          	addi	a1,s0,-56
    4d08:	2d1000ef          	jal	57d8 <fstat>
  if (r < 0) {
    4d0c:	04054363          	bltz	a0,4d52 <lazy_copyinstr+0xa2>
  if (st.type != T_DIR) {
    4d10:	fd041703          	lh	a4,-48(s0)
    4d14:	4785                	li	a5,1
    4d16:	04f71763          	bne	a4,a5,4d64 <lazy_copyinstr+0xb4>
  close(fd);
    4d1a:	8526                	mv	a0,s1
    4d1c:	28d000ef          	jal	57a8 <close>
}
    4d20:	70e2                	ld	ra,56(sp)
    4d22:	7442                	ld	s0,48(sp)
    4d24:	74a2                	ld	s1,40(sp)
    4d26:	7902                	ld	s2,32(sp)
    4d28:	6121                	addi	sp,sp,64
    4d2a:	8082                	ret
    printf("%s: sbrk did not align\n", s);
    4d2c:	85ca                	mv	a1,s2
    4d2e:	00003517          	auipc	a0,0x3
    4d32:	0da50513          	addi	a0,a0,218 # 7e08 <malloc+0x2156>
    4d36:	6c1000ef          	jal	5bf6 <printf>
    exit(1);
    4d3a:	4505                	li	a0,1
    4d3c:	245000ef          	jal	5780 <exit>
    printf("could not open /");
    4d40:	00003517          	auipc	a0,0x3
    4d44:	35850513          	addi	a0,a0,856 # 8098 <malloc+0x23e6>
    4d48:	6af000ef          	jal	5bf6 <printf>
    exit(1);
    4d4c:	4505                	li	a0,1
    4d4e:	233000ef          	jal	5780 <exit>
    printf("could not stat /");
    4d52:	00003517          	auipc	a0,0x3
    4d56:	35e50513          	addi	a0,a0,862 # 80b0 <malloc+0x23fe>
    4d5a:	69d000ef          	jal	5bf6 <printf>
    exit(1);
    4d5e:	4505                	li	a0,1
    4d60:	221000ef          	jal	5780 <exit>
    printf("/ is not T_DIR");
    4d64:	00003517          	auipc	a0,0x3
    4d68:	36450513          	addi	a0,a0,868 # 80c8 <malloc+0x2416>
    4d6c:	68b000ef          	jal	5bf6 <printf>
    exit(1);
    4d70:	4505                	li	a0,1
    4d72:	20f000ef          	jal	5780 <exit>

0000000000004d76 <fsfull>:
{
    4d76:	7131                	addi	sp,sp,-192
    4d78:	fd06                	sd	ra,184(sp)
    4d7a:	f922                	sd	s0,176(sp)
    4d7c:	f526                	sd	s1,168(sp)
    4d7e:	f14a                	sd	s2,160(sp)
    4d80:	ed4e                	sd	s3,152(sp)
    4d82:	e952                	sd	s4,144(sp)
    4d84:	e556                	sd	s5,136(sp)
    4d86:	e15a                	sd	s6,128(sp)
    4d88:	fcde                	sd	s7,120(sp)
    4d8a:	f8e2                	sd	s8,112(sp)
    4d8c:	f4e6                	sd	s9,104(sp)
    4d8e:	f0ea                	sd	s10,96(sp)
    4d90:	ecee                	sd	s11,88(sp)
    4d92:	0180                	addi	s0,sp,192
  printf("fsfull test\n");
    4d94:	00003517          	auipc	a0,0x3
    4d98:	34450513          	addi	a0,a0,836 # 80d8 <malloc+0x2426>
    4d9c:	65b000ef          	jal	5bf6 <printf>
  int fsblocks = 0;
    4da0:	4981                	li	s3,0
  for (nfiles = 0;; nfiles++) {
    4da2:	4481                	li	s1,0
    name[0] = 'f';
    4da4:	06600d93          	li	s11,102
    name[1] = '0' + nfiles / 1000;
    4da8:	106257b7          	lui	a5,0x10625
    4dac:	dd378793          	addi	a5,a5,-557 # 10624dd3 <base+0x106038db>
    4db0:	f4f43423          	sd	a5,-184(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4db4:	51eb8b37          	lui	s6,0x51eb8
    4db8:	51fb0b13          	addi	s6,s6,1311 # 51eb851f <base+0x51e97027>
    name[3] = '0' + (nfiles % 100) / 10;
    4dbc:	66666ab7          	lui	s5,0x66666
    4dc0:	667a8a93          	addi	s5,s5,1639 # 66666667 <base+0x6664516f>
    printf("writing %s\n", name);
    4dc4:	f5040d13          	addi	s10,s0,-176
    name[0] = 'f';
    4dc8:	f5b40823          	sb	s11,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4dcc:	f4843783          	ld	a5,-184(s0)
    4dd0:	02f487b3          	mul	a5,s1,a5
    4dd4:	9799                	srai	a5,a5,0x26
    4dd6:	41f4d69b          	sraiw	a3,s1,0x1f
    4dda:	9f95                	subw	a5,a5,a3
    4ddc:	0307871b          	addiw	a4,a5,48
    4de0:	f4e408a3          	sb	a4,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4de4:	3e800713          	li	a4,1000
    4de8:	02f707bb          	mulw	a5,a4,a5
    4dec:	40f487bb          	subw	a5,s1,a5
    4df0:	03678733          	mul	a4,a5,s6
    4df4:	9715                	srai	a4,a4,0x25
    4df6:	41f7d79b          	sraiw	a5,a5,0x1f
    4dfa:	40f707bb          	subw	a5,a4,a5
    4dfe:	0307879b          	addiw	a5,a5,48
    4e02:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4e06:	036487b3          	mul	a5,s1,s6
    4e0a:	9795                	srai	a5,a5,0x25
    4e0c:	9f95                	subw	a5,a5,a3
    4e0e:	06400713          	li	a4,100
    4e12:	02f707bb          	mulw	a5,a4,a5
    4e16:	40f487bb          	subw	a5,s1,a5
    4e1a:	03578733          	mul	a4,a5,s5
    4e1e:	9709                	srai	a4,a4,0x22
    4e20:	41f7d79b          	sraiw	a5,a5,0x1f
    4e24:	40f707bb          	subw	a5,a4,a5
    4e28:	0307879b          	addiw	a5,a5,48
    4e2c:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    4e30:	03548733          	mul	a4,s1,s5
    4e34:	9709                	srai	a4,a4,0x22
    4e36:	9f15                	subw	a4,a4,a3
    4e38:	0027179b          	slliw	a5,a4,0x2
    4e3c:	9fb9                	addw	a5,a5,a4
    4e3e:	0017979b          	slliw	a5,a5,0x1
    4e42:	40f487bb          	subw	a5,s1,a5
    4e46:	0307879b          	addiw	a5,a5,48
    4e4a:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    4e4e:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    4e52:	85ea                	mv	a1,s10
    4e54:	00003517          	auipc	a0,0x3
    4e58:	29450513          	addi	a0,a0,660 # 80e8 <malloc+0x2436>
    4e5c:	59b000ef          	jal	5bf6 <printf>
    int fd = open(name, O_CREATE | O_RDWR);
    4e60:	20200593          	li	a1,514
    4e64:	856a                	mv	a0,s10
    4e66:	15b000ef          	jal	57c0 <open>
    4e6a:	892a                	mv	s2,a0
    if (fd < 0) {
    4e6c:	0e055c63          	bgez	a0,4f64 <fsfull+0x1ee>
      printf("open %s failed\n", name);
    4e70:	f5040593          	addi	a1,s0,-176
    4e74:	00003517          	auipc	a0,0x3
    4e78:	28450513          	addi	a0,a0,644 # 80f8 <malloc+0x2446>
    4e7c:	57b000ef          	jal	5bf6 <printf>
  while (nfiles >= 0) {
    4e80:	0a04cc63          	bltz	s1,4f38 <fsfull+0x1c2>
    name[0] = 'f';
    4e84:	06600c93          	li	s9,102
    name[1] = '0' + nfiles / 1000;
    4e88:	10625ab7          	lui	s5,0x10625
    4e8c:	dd3a8a93          	addi	s5,s5,-557 # 10624dd3 <base+0x106038db>
    name[2] = '0' + (nfiles % 1000) / 100;
    4e90:	3e800c13          	li	s8,1000
    4e94:	51eb8a37          	lui	s4,0x51eb8
    4e98:	51fa0a13          	addi	s4,s4,1311 # 51eb851f <base+0x51e97027>
    name[3] = '0' + (nfiles % 100) / 10;
    4e9c:	06400b93          	li	s7,100
    4ea0:	66666937          	lui	s2,0x66666
    4ea4:	66790913          	addi	s2,s2,1639 # 66666667 <base+0x6664516f>
    unlink(name);
    4ea8:	f5040b13          	addi	s6,s0,-176
    name[0] = 'f';
    4eac:	f5940823          	sb	s9,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4eb0:	035487b3          	mul	a5,s1,s5
    4eb4:	9799                	srai	a5,a5,0x26
    4eb6:	41f4d69b          	sraiw	a3,s1,0x1f
    4eba:	9f95                	subw	a5,a5,a3
    4ebc:	0307871b          	addiw	a4,a5,48
    4ec0:	f4e408a3          	sb	a4,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4ec4:	02fc07bb          	mulw	a5,s8,a5
    4ec8:	40f487bb          	subw	a5,s1,a5
    4ecc:	03478733          	mul	a4,a5,s4
    4ed0:	9715                	srai	a4,a4,0x25
    4ed2:	41f7d79b          	sraiw	a5,a5,0x1f
    4ed6:	40f707bb          	subw	a5,a4,a5
    4eda:	0307879b          	addiw	a5,a5,48
    4ede:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4ee2:	034487b3          	mul	a5,s1,s4
    4ee6:	9795                	srai	a5,a5,0x25
    4ee8:	9f95                	subw	a5,a5,a3
    4eea:	02fb87bb          	mulw	a5,s7,a5
    4eee:	40f487bb          	subw	a5,s1,a5
    4ef2:	03278733          	mul	a4,a5,s2
    4ef6:	9709                	srai	a4,a4,0x22
    4ef8:	41f7d79b          	sraiw	a5,a5,0x1f
    4efc:	40f707bb          	subw	a5,a4,a5
    4f00:	0307879b          	addiw	a5,a5,48
    4f04:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    4f08:	03248733          	mul	a4,s1,s2
    4f0c:	9709                	srai	a4,a4,0x22
    4f0e:	9f15                	subw	a4,a4,a3
    4f10:	0027179b          	slliw	a5,a4,0x2
    4f14:	9fb9                	addw	a5,a5,a4
    4f16:	0017979b          	slliw	a5,a5,0x1
    4f1a:	40f487bb          	subw	a5,s1,a5
    4f1e:	0307879b          	addiw	a5,a5,48
    4f22:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    4f26:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    4f2a:	855a                	mv	a0,s6
    4f2c:	0a5000ef          	jal	57d0 <unlink>
    nfiles--;
    4f30:	34fd                	addiw	s1,s1,-1
  while (nfiles >= 0) {
    4f32:	57fd                	li	a5,-1
    4f34:	f6f49ce3          	bne	s1,a5,4eac <fsfull+0x136>
  printf("fsfull test finished, %d blocks\n", fsblocks);
    4f38:	85ce                	mv	a1,s3
    4f3a:	00003517          	auipc	a0,0x3
    4f3e:	1de50513          	addi	a0,a0,478 # 8118 <malloc+0x2466>
    4f42:	4b5000ef          	jal	5bf6 <printf>
}
    4f46:	70ea                	ld	ra,184(sp)
    4f48:	744a                	ld	s0,176(sp)
    4f4a:	74aa                	ld	s1,168(sp)
    4f4c:	790a                	ld	s2,160(sp)
    4f4e:	69ea                	ld	s3,152(sp)
    4f50:	6a4a                	ld	s4,144(sp)
    4f52:	6aaa                	ld	s5,136(sp)
    4f54:	6b0a                	ld	s6,128(sp)
    4f56:	7be6                	ld	s7,120(sp)
    4f58:	7c46                	ld	s8,112(sp)
    4f5a:	7ca6                	ld	s9,104(sp)
    4f5c:	7d06                	ld	s10,96(sp)
    4f5e:	6de6                	ld	s11,88(sp)
    4f60:	6129                	addi	sp,sp,192
    4f62:	8082                	ret
    int total = 0;
    4f64:	4a01                	li	s4,0
      int cc = write(fd, buf, BSIZE);
    4f66:	40000c93          	li	s9,1024
    4f6a:	00008c17          	auipc	s8,0x8
    4f6e:	d8ec0c13          	addi	s8,s8,-626 # ccf8 <buf>
      if (cc < BSIZE)
    4f72:	3ff00b93          	li	s7,1023
      int cc = write(fd, buf, BSIZE);
    4f76:	8666                	mv	a2,s9
    4f78:	85e2                	mv	a1,s8
    4f7a:	854a                	mv	a0,s2
    4f7c:	025000ef          	jal	57a0 <write>
      if (cc < BSIZE)
    4f80:	00abd663          	bge	s7,a0,4f8c <fsfull+0x216>
      total += cc;
    4f84:	00aa0a3b          	addw	s4,s4,a0
      fsblocks++;
    4f88:	2985                	addiw	s3,s3,1 # 40000001 <base+0x3ffdeb09>
    while (1) {
    4f8a:	b7f5                	j	4f76 <fsfull+0x200>
    printf("wrote %d bytes\n", total);
    4f8c:	85d2                	mv	a1,s4
    4f8e:	00003517          	auipc	a0,0x3
    4f92:	17a50513          	addi	a0,a0,378 # 8108 <malloc+0x2456>
    4f96:	461000ef          	jal	5bf6 <printf>
    close(fd);
    4f9a:	854a                	mv	a0,s2
    4f9c:	00d000ef          	jal	57a8 <close>
    if (total == 0)
    4fa0:	ee0a00e3          	beqz	s4,4e80 <fsfull+0x10a>
  for (nfiles = 0;; nfiles++) {
    4fa4:	2485                	addiw	s1,s1,1
    4fa6:	b50d                	j	4dc8 <fsfull+0x52>

0000000000004fa8 <linkoverflow>:

void
linkoverflow(char *s)
{
    4fa8:	7175                	addi	sp,sp,-144
    4faa:	e506                	sd	ra,136(sp)
    4fac:	e122                	sd	s0,128(sp)
    4fae:	fca6                	sd	s1,120(sp)
    4fb0:	f8ca                	sd	s2,112(sp)
    4fb2:	f4ce                	sd	s3,104(sp)
    4fb4:	f0d2                	sd	s4,96(sp)
    4fb6:	ecd6                	sd	s5,88(sp)
    4fb8:	e8da                	sd	s6,80(sp)
    4fba:	e4de                	sd	s7,72(sp)
    4fbc:	e0e2                	sd	s8,64(sp)
    4fbe:	fc66                	sd	s9,56(sp)
    4fc0:	f86a                	sd	s10,48(sp)
    4fc2:	0900                	addi	s0,sp,144
    4fc4:	8d2a                	mv	s10,a0
  enum { TARGET = 32768 };
  enum { DIRS = 64 };
  struct stat st;
  int i;

  unlink("/lof");
    4fc6:	00003517          	auipc	a0,0x3
    4fca:	17a50513          	addi	a0,a0,378 # 8140 <malloc+0x248e>
    4fce:	003000ef          	jal	57d0 <unlink>
  int fd = open("/lof", O_CREATE | O_RDWR);
    4fd2:	20200593          	li	a1,514
    4fd6:	00003517          	auipc	a0,0x3
    4fda:	16a50513          	addi	a0,a0,362 # 8140 <malloc+0x248e>
    4fde:	7e2000ef          	jal	57c0 <open>
  if (fd < 0) {
    4fe2:	02054863          	bltz	a0,5012 <linkoverflow+0x6a>
    printf("%s: cannot create /lof\n", s);
    exit(1);
  }
  close(fd);
    4fe6:	7c2000ef          	jal	57a8 <close>

  for (i = 0; i < TARGET; i++) {
    4fea:	4901                	li	s2,0
    int d = i % DIRS;
    int f = i / DIRS;

    char pn[16];
    pn[0] = '/';
    4fec:	02f00993          	li	s3,47
    pn[1] = 'd';
    4ff0:	06400b93          	li	s7,100
    pn[2] = '_';
    4ff4:	05f00b13          	li	s6,95
    pn[3] = 'a' + (d / 16);
    pn[4] = 'a' + (d % 16);
    pn[5] = '\0';
    if (f == 0 && mkdir(pn) < 0) {
    4ff8:	f7840a13          	addi	s4,s0,-136
      printf("%s: mkdir(%s) failed\n", s, pn);
      exit(1);
    }

    pn[5] = '/';
    pn[6] = 'l';
    4ffc:	06c00c93          	li	s9,108
    pn[7] = 'a' + (f / 256);
    pn[8] = 'a' + ((f / 16) % 16);
    pn[9] = 'a' + (f % 16);
    pn[10] = '\0';

    if (link("/lof", pn) < 0) {
    5000:	00003c17          	auipc	s8,0x3
    5004:	140c0c13          	addi	s8,s8,320 # 8140 <malloc+0x248e>
      }
      printf("%s: link failed after %d links (nlink=%d)\n", s, i, st.nlink);
      exit(1);
    }

    if (i % 100 == 0) {
    5008:	51eb8ab7          	lui	s5,0x51eb8
    500c:	51fa8a93          	addi	s5,s5,1311 # 51eb851f <base+0x51e97027>
    5010:	a869                	j	50aa <linkoverflow+0x102>
    printf("%s: cannot create /lof\n", s);
    5012:	85ea                	mv	a1,s10
    5014:	00003517          	auipc	a0,0x3
    5018:	13450513          	addi	a0,a0,308 # 8148 <malloc+0x2496>
    501c:	3db000ef          	jal	5bf6 <printf>
    exit(1);
    5020:	4505                	li	a0,1
    5022:	75e000ef          	jal	5780 <exit>
    pn[5] = '/';
    5026:	f7340ea3          	sb	s3,-131(s0)
    pn[6] = 'l';
    502a:	f7940f23          	sb	s9,-130(s0)
    pn[7] = 'a' + (f / 256);
    502e:	41f9579b          	sraiw	a5,s2,0x1f
    5032:	0127d79b          	srliw	a5,a5,0x12
    5036:	012787bb          	addw	a5,a5,s2
    503a:	40e7d79b          	sraiw	a5,a5,0xe
    503e:	0617879b          	addiw	a5,a5,97
    5042:	f6f40fa3          	sb	a5,-129(s0)
    pn[8] = 'a' + ((f / 16) % 16);
    5046:	41f4d71b          	sraiw	a4,s1,0x1f
    504a:	01c7571b          	srliw	a4,a4,0x1c
    504e:	9cb9                	addw	s1,s1,a4
    5050:	4044d79b          	sraiw	a5,s1,0x4
    5054:	41f7d69b          	sraiw	a3,a5,0x1f
    5058:	01c6d69b          	srliw	a3,a3,0x1c
    505c:	9fb5                	addw	a5,a5,a3
    505e:	8bbd                	andi	a5,a5,15
    5060:	9f95                	subw	a5,a5,a3
    5062:	0617879b          	addiw	a5,a5,97
    5066:	f8f40023          	sb	a5,-128(s0)
    pn[9] = 'a' + (f % 16);
    506a:	88bd                	andi	s1,s1,15
    506c:	9c99                	subw	s1,s1,a4
    506e:	0614849b          	addiw	s1,s1,97
    5072:	f89400a3          	sb	s1,-127(s0)
    pn[10] = '\0';
    5076:	f8040123          	sb	zero,-126(s0)
    if (link("/lof", pn) < 0) {
    507a:	85d2                	mv	a1,s4
    507c:	8562                	mv	a0,s8
    507e:	762000ef          	jal	57e0 <link>
    5082:	08054a63          	bltz	a0,5116 <linkoverflow+0x16e>
    if (i % 100 == 0) {
    5086:	03590733          	mul	a4,s2,s5
    508a:	9715                	srai	a4,a4,0x25
    508c:	41f9579b          	sraiw	a5,s2,0x1f
    5090:	9f1d                	subw	a4,a4,a5
    5092:	06400793          	li	a5,100
    5096:	02e787bb          	mulw	a5,a5,a4
    509a:	40f907bb          	subw	a5,s2,a5
    509e:	10078363          	beqz	a5,51a4 <linkoverflow+0x1fc>
  for (i = 0; i < TARGET; i++) {
    50a2:	2905                	addiw	s2,s2,1
    50a4:	67a1                	lui	a5,0x8
    50a6:	08f90863          	beq	s2,a5,5136 <linkoverflow+0x18e>
    int d = i % DIRS;
    50aa:	41f9571b          	sraiw	a4,s2,0x1f
    50ae:	01a7571b          	srliw	a4,a4,0x1a
    50b2:	012704bb          	addw	s1,a4,s2
    50b6:	03f4f793          	andi	a5,s1,63
    50ba:	9f99                	subw	a5,a5,a4
    int f = i / DIRS;
    50bc:	4064d49b          	sraiw	s1,s1,0x6
    pn[0] = '/';
    50c0:	f7340c23          	sb	s3,-136(s0)
    pn[1] = 'd';
    50c4:	f7740ca3          	sb	s7,-135(s0)
    pn[2] = '_';
    50c8:	f7640d23          	sb	s6,-134(s0)
    pn[3] = 'a' + (d / 16);
    50cc:	41f7d71b          	sraiw	a4,a5,0x1f
    50d0:	01c7571b          	srliw	a4,a4,0x1c
    50d4:	9fb9                	addw	a5,a5,a4
    50d6:	4047d69b          	sraiw	a3,a5,0x4
    50da:	0616869b          	addiw	a3,a3,97 # 40061 <base+0x1eb69>
    50de:	f6d40da3          	sb	a3,-133(s0)
    pn[4] = 'a' + (d % 16);
    50e2:	8bbd                	andi	a5,a5,15
    50e4:	9f99                	subw	a5,a5,a4
    50e6:	0617879b          	addiw	a5,a5,97 # 8061 <malloc+0x23af>
    50ea:	f6f40e23          	sb	a5,-132(s0)
    pn[5] = '\0';
    50ee:	f6040ea3          	sb	zero,-131(s0)
    if (f == 0 && mkdir(pn) < 0) {
    50f2:	f895                	bnez	s1,5026 <linkoverflow+0x7e>
    50f4:	8552                	mv	a0,s4
    50f6:	6f2000ef          	jal	57e8 <mkdir>
    50fa:	f20556e3          	bgez	a0,5026 <linkoverflow+0x7e>
      printf("%s: mkdir(%s) failed\n", s, pn);
    50fe:	f7840613          	addi	a2,s0,-136
    5102:	85ea                	mv	a1,s10
    5104:	00003517          	auipc	a0,0x3
    5108:	05c50513          	addi	a0,a0,92 # 8160 <malloc+0x24ae>
    510c:	2eb000ef          	jal	5bf6 <printf>
      exit(1);
    5110:	4505                	li	a0,1
    5112:	66e000ef          	jal	5780 <exit>
      if (stat("/lof", &st) < 0) {
    5116:	f8840593          	addi	a1,s0,-120
    511a:	00003517          	auipc	a0,0x3
    511e:	02650513          	addi	a0,a0,38 # 8140 <malloc+0x248e>
    5122:	4fc000ef          	jal	561e <stat>
    5126:	04054a63          	bltz	a0,517a <linkoverflow+0x1d2>
      if (st.nlink >= 32767) {
    512a:	f9241683          	lh	a3,-110(s0)
    512e:	67a1                	lui	a5,0x8
    5130:	17fd                	addi	a5,a5,-1 # 7fff <malloc+0x234d>
    5132:	04f69e63          	bne	a3,a5,518e <linkoverflow+0x1e6>
      printf("%s: i=%d, pn=%s\n", s, i, pn);
    }
  }

  if (stat("/lof", &st) < 0) {
    5136:	f8840593          	addi	a1,s0,-120
    513a:	00003517          	auipc	a0,0x3
    513e:	00650513          	addi	a0,a0,6 # 8140 <malloc+0x248e>
    5142:	4dc000ef          	jal	561e <stat>
    5146:	06054963          	bltz	a0,51b8 <linkoverflow+0x210>
    printf("%s: stat(/lof) failed\n", s);
    exit(1);
  }

  unlink("/lof");
    514a:	00003517          	auipc	a0,0x3
    514e:	ff650513          	addi	a0,a0,-10 # 8140 <malloc+0x248e>
    5152:	67e000ef          	jal	57d0 <unlink>

  if (st.nlink < 0) {
    5156:	f9241603          	lh	a2,-110(s0)
    515a:	06064963          	bltz	a2,51cc <linkoverflow+0x224>
    printf("%s: negative link count: %d\n", s, st.nlink);
    exit(1);
  }
}
    515e:	60aa                	ld	ra,136(sp)
    5160:	640a                	ld	s0,128(sp)
    5162:	74e6                	ld	s1,120(sp)
    5164:	7946                	ld	s2,112(sp)
    5166:	79a6                	ld	s3,104(sp)
    5168:	7a06                	ld	s4,96(sp)
    516a:	6ae6                	ld	s5,88(sp)
    516c:	6b46                	ld	s6,80(sp)
    516e:	6ba6                	ld	s7,72(sp)
    5170:	6c06                	ld	s8,64(sp)
    5172:	7ce2                	ld	s9,56(sp)
    5174:	7d42                	ld	s10,48(sp)
    5176:	6149                	addi	sp,sp,144
    5178:	8082                	ret
        printf("%s: stat(/lof) failed\n", s);
    517a:	85ea                	mv	a1,s10
    517c:	00003517          	auipc	a0,0x3
    5180:	ffc50513          	addi	a0,a0,-4 # 8178 <malloc+0x24c6>
    5184:	273000ef          	jal	5bf6 <printf>
        exit(1);
    5188:	4505                	li	a0,1
    518a:	5f6000ef          	jal	5780 <exit>
      printf("%s: link failed after %d links (nlink=%d)\n", s, i, st.nlink);
    518e:	864a                	mv	a2,s2
    5190:	85ea                	mv	a1,s10
    5192:	00003517          	auipc	a0,0x3
    5196:	ffe50513          	addi	a0,a0,-2 # 8190 <malloc+0x24de>
    519a:	25d000ef          	jal	5bf6 <printf>
      exit(1);
    519e:	4505                	li	a0,1
    51a0:	5e0000ef          	jal	5780 <exit>
      printf("%s: i=%d, pn=%s\n", s, i, pn);
    51a4:	86d2                	mv	a3,s4
    51a6:	864a                	mv	a2,s2
    51a8:	85ea                	mv	a1,s10
    51aa:	00003517          	auipc	a0,0x3
    51ae:	01650513          	addi	a0,a0,22 # 81c0 <malloc+0x250e>
    51b2:	245000ef          	jal	5bf6 <printf>
    51b6:	b5f5                	j	50a2 <linkoverflow+0xfa>
    printf("%s: stat(/lof) failed\n", s);
    51b8:	85ea                	mv	a1,s10
    51ba:	00003517          	auipc	a0,0x3
    51be:	fbe50513          	addi	a0,a0,-66 # 8178 <malloc+0x24c6>
    51c2:	235000ef          	jal	5bf6 <printf>
    exit(1);
    51c6:	4505                	li	a0,1
    51c8:	5b8000ef          	jal	5780 <exit>
    printf("%s: negative link count: %d\n", s, st.nlink);
    51cc:	85ea                	mv	a1,s10
    51ce:	00003517          	auipc	a0,0x3
    51d2:	00a50513          	addi	a0,a0,10 # 81d8 <malloc+0x2526>
    51d6:	221000ef          	jal	5bf6 <printf>
    exit(1);
    51da:	4505                	li	a0,1
    51dc:	5a4000ef          	jal	5780 <exit>

00000000000051e0 <run>:

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s)
{
    51e0:	7179                	addi	sp,sp,-48
    51e2:	f406                	sd	ra,40(sp)
    51e4:	f022                	sd	s0,32(sp)
    51e6:	ec26                	sd	s1,24(sp)
    51e8:	e84a                	sd	s2,16(sp)
    51ea:	1800                	addi	s0,sp,48
    51ec:	84aa                	mv	s1,a0
    51ee:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    51f0:	00003517          	auipc	a0,0x3
    51f4:	00850513          	addi	a0,a0,8 # 81f8 <malloc+0x2546>
    51f8:	1ff000ef          	jal	5bf6 <printf>
  if ((pid = fork()) < 0) {
    51fc:	57c000ef          	jal	5778 <fork>
    5200:	02054a63          	bltz	a0,5234 <run+0x54>
    printf("runtest: fork error\n");
    exit(1);
  }
  if (pid == 0) {
    5204:	c129                	beqz	a0,5246 <run+0x66>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    5206:	fdc40513          	addi	a0,s0,-36
    520a:	57e000ef          	jal	5788 <wait>
    if (xstatus != 0)
    520e:	fdc42783          	lw	a5,-36(s0)
    5212:	cf9d                	beqz	a5,5250 <run+0x70>
      printf("FAILED\n");
    5214:	00003517          	auipc	a0,0x3
    5218:	00c50513          	addi	a0,a0,12 # 8220 <malloc+0x256e>
    521c:	1db000ef          	jal	5bf6 <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    5220:	fdc42503          	lw	a0,-36(s0)
  }
}
    5224:	00153513          	seqz	a0,a0
    5228:	70a2                	ld	ra,40(sp)
    522a:	7402                	ld	s0,32(sp)
    522c:	64e2                	ld	s1,24(sp)
    522e:	6942                	ld	s2,16(sp)
    5230:	6145                	addi	sp,sp,48
    5232:	8082                	ret
    printf("runtest: fork error\n");
    5234:	00003517          	auipc	a0,0x3
    5238:	fd450513          	addi	a0,a0,-44 # 8208 <malloc+0x2556>
    523c:	1bb000ef          	jal	5bf6 <printf>
    exit(1);
    5240:	4505                	li	a0,1
    5242:	53e000ef          	jal	5780 <exit>
    f(s);
    5246:	854a                	mv	a0,s2
    5248:	9482                	jalr	s1
    exit(0);
    524a:	4501                	li	a0,0
    524c:	534000ef          	jal	5780 <exit>
      printf("OK\n");
    5250:	00003517          	auipc	a0,0x3
    5254:	fd850513          	addi	a0,a0,-40 # 8228 <malloc+0x2576>
    5258:	19f000ef          	jal	5bf6 <printf>
    525c:	b7d1                	j	5220 <run+0x40>

000000000000525e <runtests>:

int
runtests(struct test *tests, char *justone, int continuous)
{
    525e:	7179                	addi	sp,sp,-48
    5260:	f406                	sd	ra,40(sp)
    5262:	f022                	sd	s0,32(sp)
    5264:	ec26                	sd	s1,24(sp)
    5266:	e44e                	sd	s3,8(sp)
    5268:	1800                	addi	s0,sp,48
    526a:	84aa                	mv	s1,a0
  int ntests = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    526c:	6508                	ld	a0,8(a0)
    526e:	c125                	beqz	a0,52ce <runtests+0x70>
    5270:	e84a                	sd	s2,16(sp)
    5272:	e052                	sd	s4,0(sp)
    5274:	892e                	mv	s2,a1
    if ((justone == 0) || strcmp(t->s, justone) == 0) {
      ntests++;
      if (!run(t->f, t->s)) {
        if (continuous != 2) {
    5276:	1679                	addi	a2,a2,-2 # ffe <bigdir+0xfe>
    5278:	00c03a33          	snez	s4,a2
  int ntests = 0;
    527c:	4981                	li	s3,0
    527e:	a831                	j	529a <runtests+0x3c>
      if (!run(t->f, t->s)) {
    5280:	648c                	ld	a1,8(s1)
    5282:	6088                	ld	a0,0(s1)
    5284:	f5dff0ef          	jal	51e0 <run>
    5288:	00153513          	seqz	a0,a0
        if (continuous != 2) {
    528c:	00aa7533          	and	a0,s4,a0
    5290:	ed01                	bnez	a0,52a8 <runtests+0x4a>
      ntests++;
    5292:	2985                	addiw	s3,s3,1
  for (struct test *t = tests; t->s != 0; t++) {
    5294:	04c1                	addi	s1,s1,16
    5296:	6488                	ld	a0,8(s1)
    5298:	c115                	beqz	a0,52bc <runtests+0x5e>
    if ((justone == 0) || strcmp(t->s, justone) == 0) {
    529a:	fe0903e3          	beqz	s2,5280 <runtests+0x22>
    529e:	85ca                	mv	a1,s2
    52a0:	25a000ef          	jal	54fa <strcmp>
    52a4:	f965                	bnez	a0,5294 <runtests+0x36>
    52a6:	bfe9                	j	5280 <runtests+0x22>
          printf("SOME TESTS FAILED\n");
    52a8:	00003517          	auipc	a0,0x3
    52ac:	f8850513          	addi	a0,a0,-120 # 8230 <malloc+0x257e>
    52b0:	147000ef          	jal	5bf6 <printf>
          return -1;
    52b4:	59fd                	li	s3,-1
    52b6:	6942                	ld	s2,16(sp)
    52b8:	6a02                	ld	s4,0(sp)
    52ba:	a019                	j	52c0 <runtests+0x62>
    52bc:	6942                	ld	s2,16(sp)
    52be:	6a02                	ld	s4,0(sp)
        }
      }
    }
  }
  return ntests;
}
    52c0:	854e                	mv	a0,s3
    52c2:	70a2                	ld	ra,40(sp)
    52c4:	7402                	ld	s0,32(sp)
    52c6:	64e2                	ld	s1,24(sp)
    52c8:	69a2                	ld	s3,8(sp)
    52ca:	6145                	addi	sp,sp,48
    52cc:	8082                	ret
  return ntests;
    52ce:	4981                	li	s3,0
    52d0:	bfc5                	j	52c0 <runtests+0x62>

00000000000052d2 <countfree>:

// use sbrk() to count how many free physical memory pages there are.
int
countfree()
{
    52d2:	7179                	addi	sp,sp,-48
    52d4:	f406                	sd	ra,40(sp)
    52d6:	f022                	sd	s0,32(sp)
    52d8:	ec26                	sd	s1,24(sp)
    52da:	e84a                	sd	s2,16(sp)
    52dc:	e44e                	sd	s3,8(sp)
    52de:	e052                	sd	s4,0(sp)
    52e0:	1800                	addi	s0,sp,48
  int n = 0;
  uint64 sz0 = (uint64)sbrk(0);
    52e2:	4501                	li	a0,0
    52e4:	468000ef          	jal	574c <sbrk>
    52e8:	8a2a                	mv	s4,a0
  int n = 0;
    52ea:	4481                	li	s1,0
  while (1) {
    char *a = sbrk(PGSIZE);
    52ec:	6985                	lui	s3,0x1
    if (a == SBRK_ERROR) {
    52ee:	597d                	li	s2,-1
    char *a = sbrk(PGSIZE);
    52f0:	854e                	mv	a0,s3
    52f2:	45a000ef          	jal	574c <sbrk>
    if (a == SBRK_ERROR) {
    52f6:	01250463          	beq	a0,s2,52fe <countfree+0x2c>
      break;
    }
    n += 1;
    52fa:	2485                	addiw	s1,s1,1
  while (1) {
    52fc:	bfd5                	j	52f0 <countfree+0x1e>
  }
  sbrk(-((uint64)sbrk(0) - sz0));
    52fe:	4501                	li	a0,0
    5300:	44c000ef          	jal	574c <sbrk>
    5304:	40aa053b          	subw	a0,s4,a0
    5308:	444000ef          	jal	574c <sbrk>
  return n;
}
    530c:	8526                	mv	a0,s1
    530e:	70a2                	ld	ra,40(sp)
    5310:	7402                	ld	s0,32(sp)
    5312:	64e2                	ld	s1,24(sp)
    5314:	6942                	ld	s2,16(sp)
    5316:	69a2                	ld	s3,8(sp)
    5318:	6a02                	ld	s4,0(sp)
    531a:	6145                	addi	sp,sp,48
    531c:	8082                	ret

000000000000531e <drivetests>:

int
drivetests(int quick, int continuous, char *justone)
{
    531e:	7159                	addi	sp,sp,-112
    5320:	f486                	sd	ra,104(sp)
    5322:	f0a2                	sd	s0,96(sp)
    5324:	eca6                	sd	s1,88(sp)
    5326:	e8ca                	sd	s2,80(sp)
    5328:	e4ce                	sd	s3,72(sp)
    532a:	e0d2                	sd	s4,64(sp)
    532c:	fc56                	sd	s5,56(sp)
    532e:	f85a                	sd	s6,48(sp)
    5330:	f45e                	sd	s7,40(sp)
    5332:	f062                	sd	s8,32(sp)
    5334:	ec66                	sd	s9,24(sp)
    5336:	e86a                	sd	s10,16(sp)
    5338:	e46e                	sd	s11,8(sp)
    533a:	1880                	addi	s0,sp,112
    533c:	8aaa                	mv	s5,a0
    533e:	89ae                	mv	s3,a1
    5340:	8a32                	mv	s4,a2
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
      if (continuous != 2) {
        return 1;
      }
    }
    if (justone != 0 && ntests == 0) {
    5342:	00c03cb3          	snez	s9,a2
    printf("usertests starting\n");
    5346:	00003c17          	auipc	s8,0x3
    534a:	f02c0c13          	addi	s8,s8,-254 # 8248 <malloc+0x2596>
    n = runtests(quicktests, justone, continuous);
    534e:	00004b97          	auipc	s7,0x4
    5352:	cc2b8b93          	addi	s7,s7,-830 # 9010 <quicktests>
      if (continuous != 2) {
    5356:	4b09                	li	s6,2
      n = runtests(slowtests, justone, continuous);
    5358:	00004d17          	auipc	s10,0x4
    535c:	108d0d13          	addi	s10,s10,264 # 9460 <slowtests>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5360:	00003d97          	auipc	s11,0x3
    5364:	f20d8d93          	addi	s11,s11,-224 # 8280 <malloc+0x25ce>
    5368:	a80d                	j	539a <drivetests+0x7c>
      if (continuous != 2) {
    536a:	09699563          	bne	s3,s6,53f4 <drivetests+0xd6>
    int ntests = 0;
    536e:	4481                	li	s1,0
    5370:	a099                	j	53b6 <drivetests+0x98>
        printf("usertests slow tests starting\n");
    5372:	00003517          	auipc	a0,0x3
    5376:	eee50513          	addi	a0,a0,-274 # 8260 <malloc+0x25ae>
    537a:	07d000ef          	jal	5bf6 <printf>
    537e:	a081                	j	53be <drivetests+0xa0>
        if (continuous != 2) {
    5380:	07699a63          	bne	s3,s6,53f4 <drivetests+0xd6>
    if ((free1 = countfree()) < free0) {
    5384:	f4fff0ef          	jal	52d2 <countfree>
    5388:	05254463          	blt	a0,s2,53d0 <drivetests+0xb2>
    if (justone != 0 && ntests == 0) {
    538c:	0014b493          	seqz	s1,s1
    5390:	009cf4b3          	and	s1,s9,s1
    5394:	e8b1                	bnez	s1,53e8 <drivetests+0xca>
      printf("NO TESTS EXECUTED\n");
      return 1;
    }
  } while (continuous);
    5396:	06098f63          	beqz	s3,5414 <drivetests+0xf6>
    printf("usertests starting\n");
    539a:	8562                	mv	a0,s8
    539c:	05b000ef          	jal	5bf6 <printf>
    int free0 = countfree();
    53a0:	f33ff0ef          	jal	52d2 <countfree>
    53a4:	892a                	mv	s2,a0
    n = runtests(quicktests, justone, continuous);
    53a6:	864e                	mv	a2,s3
    53a8:	85d2                	mv	a1,s4
    53aa:	855e                	mv	a0,s7
    53ac:	eb3ff0ef          	jal	525e <runtests>
    53b0:	84aa                	mv	s1,a0
    if (n < 0) {
    53b2:	fa054ce3          	bltz	a0,536a <drivetests+0x4c>
    if (!quick) {
    53b6:	fc0a97e3          	bnez	s5,5384 <drivetests+0x66>
      if (justone == 0)
    53ba:	fa0a0ce3          	beqz	s4,5372 <drivetests+0x54>
      n = runtests(slowtests, justone, continuous);
    53be:	864e                	mv	a2,s3
    53c0:	85d2                	mv	a1,s4
    53c2:	856a                	mv	a0,s10
    53c4:	e9bff0ef          	jal	525e <runtests>
      if (n < 0) {
    53c8:	fa054ce3          	bltz	a0,5380 <drivetests+0x62>
        ntests += n;
    53cc:	9ca9                	addw	s1,s1,a0
    53ce:	bf5d                	j	5384 <drivetests+0x66>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    53d0:	864a                	mv	a2,s2
    53d2:	85aa                	mv	a1,a0
    53d4:	856e                	mv	a0,s11
    53d6:	021000ef          	jal	5bf6 <printf>
      if (continuous != 2) {
    53da:	01699d63          	bne	s3,s6,53f4 <drivetests+0xd6>
    if (justone != 0 && ntests == 0) {
    53de:	0014b493          	seqz	s1,s1
    53e2:	009cf4b3          	and	s1,s9,s1
    53e6:	d8d5                	beqz	s1,539a <drivetests+0x7c>
      printf("NO TESTS EXECUTED\n");
    53e8:	00003517          	auipc	a0,0x3
    53ec:	ec850513          	addi	a0,a0,-312 # 82b0 <malloc+0x25fe>
    53f0:	007000ef          	jal	5bf6 <printf>
        return 1;
    53f4:	4505                	li	a0,1
  return 0;
}
    53f6:	70a6                	ld	ra,104(sp)
    53f8:	7406                	ld	s0,96(sp)
    53fa:	64e6                	ld	s1,88(sp)
    53fc:	6946                	ld	s2,80(sp)
    53fe:	69a6                	ld	s3,72(sp)
    5400:	6a06                	ld	s4,64(sp)
    5402:	7ae2                	ld	s5,56(sp)
    5404:	7b42                	ld	s6,48(sp)
    5406:	7ba2                	ld	s7,40(sp)
    5408:	7c02                	ld	s8,32(sp)
    540a:	6ce2                	ld	s9,24(sp)
    540c:	6d42                	ld	s10,16(sp)
    540e:	6da2                	ld	s11,8(sp)
    5410:	6165                	addi	sp,sp,112
    5412:	8082                	ret
  return 0;
    5414:	854e                	mv	a0,s3
    5416:	b7c5                	j	53f6 <drivetests+0xd8>

0000000000005418 <main>:

int
main(int argc, char *argv[])
{
    5418:	1101                	addi	sp,sp,-32
    541a:	ec06                	sd	ra,24(sp)
    541c:	e822                	sd	s0,16(sp)
    541e:	e426                	sd	s1,8(sp)
    5420:	e04a                	sd	s2,0(sp)
    5422:	1000                	addi	s0,sp,32
    5424:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if (argc == 2 && strcmp(argv[1], "-q") == 0) {
    5426:	4789                	li	a5,2
    5428:	00f50e63          	beq	a0,a5,5444 <main+0x2c>
    continuous = 1;
  } else if (argc == 2 && strcmp(argv[1], "-C") == 0) {
    continuous = 2;
  } else if (argc == 2 && argv[1][0] != '-') {
    justone = argv[1];
  } else if (argc > 1) {
    542c:	4785                	li	a5,1
    542e:	06a7c663          	blt	a5,a0,549a <main+0x82>
  char *justone = 0;
    5432:	4601                	li	a2,0
  int quick = 0;
    5434:	4501                	li	a0,0
  int continuous = 0;
    5436:	4581                	li	a1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    5438:	ee7ff0ef          	jal	531e <drivetests>
    543c:	cd35                	beqz	a0,54b8 <main+0xa0>
    exit(1);
    543e:	4505                	li	a0,1
    5440:	340000ef          	jal	5780 <exit>
    5444:	892e                	mv	s2,a1
  if (argc == 2 && strcmp(argv[1], "-q") == 0) {
    5446:	00003597          	auipc	a1,0x3
    544a:	e8258593          	addi	a1,a1,-382 # 82c8 <malloc+0x2616>
    544e:	00893503          	ld	a0,8(s2)
    5452:	0a8000ef          	jal	54fa <strcmp>
    5456:	85aa                	mv	a1,a0
    5458:	e501                	bnez	a0,5460 <main+0x48>
  char *justone = 0;
    545a:	4601                	li	a2,0
    quick = 1;
    545c:	4505                	li	a0,1
    545e:	bfe9                	j	5438 <main+0x20>
  } else if (argc == 2 && strcmp(argv[1], "-c") == 0) {
    5460:	00003597          	auipc	a1,0x3
    5464:	e7058593          	addi	a1,a1,-400 # 82d0 <malloc+0x261e>
    5468:	00893503          	ld	a0,8(s2)
    546c:	08e000ef          	jal	54fa <strcmp>
    5470:	cd15                	beqz	a0,54ac <main+0x94>
  } else if (argc == 2 && strcmp(argv[1], "-C") == 0) {
    5472:	00003597          	auipc	a1,0x3
    5476:	eae58593          	addi	a1,a1,-338 # 8320 <malloc+0x266e>
    547a:	00893503          	ld	a0,8(s2)
    547e:	07c000ef          	jal	54fa <strcmp>
    5482:	c905                	beqz	a0,54b2 <main+0x9a>
  } else if (argc == 2 && argv[1][0] != '-') {
    5484:	00893603          	ld	a2,8(s2)
    5488:	00064703          	lbu	a4,0(a2)
    548c:	02d00793          	li	a5,45
    5490:	00f70563          	beq	a4,a5,549a <main+0x82>
  int quick = 0;
    5494:	4501                	li	a0,0
  int continuous = 0;
    5496:	4581                	li	a1,0
    5498:	b745                	j	5438 <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    549a:	00003517          	auipc	a0,0x3
    549e:	e3e50513          	addi	a0,a0,-450 # 82d8 <malloc+0x2626>
    54a2:	754000ef          	jal	5bf6 <printf>
    exit(1);
    54a6:	4505                	li	a0,1
    54a8:	2d8000ef          	jal	5780 <exit>
  char *justone = 0;
    54ac:	4601                	li	a2,0
    continuous = 1;
    54ae:	4585                	li	a1,1
    54b0:	b761                	j	5438 <main+0x20>
    continuous = 2;
    54b2:	85a6                	mv	a1,s1
  char *justone = 0;
    54b4:	4601                	li	a2,0
    54b6:	b749                	j	5438 <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    54b8:	00003517          	auipc	a0,0x3
    54bc:	e5050513          	addi	a0,a0,-432 # 8308 <malloc+0x2656>
    54c0:	736000ef          	jal	5bf6 <printf>
  exit(0);
    54c4:	4501                	li	a0,0
    54c6:	2ba000ef          	jal	5780 <exit>

00000000000054ca <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
    54ca:	1141                	addi	sp,sp,-16
    54cc:	e406                	sd	ra,8(sp)
    54ce:	e022                	sd	s0,0(sp)
    54d0:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
    54d2:	f47ff0ef          	jal	5418 <main>
  exit(r);
    54d6:	2aa000ef          	jal	5780 <exit>

00000000000054da <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
    54da:	1141                	addi	sp,sp,-16
    54dc:	e406                	sd	ra,8(sp)
    54de:	e022                	sd	s0,0(sp)
    54e0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
    54e2:	87aa                	mv	a5,a0
    54e4:	0585                	addi	a1,a1,1
    54e6:	0785                	addi	a5,a5,1
    54e8:	fff5c703          	lbu	a4,-1(a1)
    54ec:	fee78fa3          	sb	a4,-1(a5)
    54f0:	fb75                	bnez	a4,54e4 <strcpy+0xa>
    ;
  return os;
}
    54f2:	60a2                	ld	ra,8(sp)
    54f4:	6402                	ld	s0,0(sp)
    54f6:	0141                	addi	sp,sp,16
    54f8:	8082                	ret

00000000000054fa <strcmp>:

int
strcmp(const char *p, const char *q)
{
    54fa:	1141                	addi	sp,sp,-16
    54fc:	e406                	sd	ra,8(sp)
    54fe:	e022                	sd	s0,0(sp)
    5500:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
    5502:	00054783          	lbu	a5,0(a0)
    5506:	cb91                	beqz	a5,551a <strcmp+0x20>
    5508:	0005c703          	lbu	a4,0(a1)
    550c:	00f71763          	bne	a4,a5,551a <strcmp+0x20>
    p++, q++;
    5510:	0505                	addi	a0,a0,1
    5512:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
    5514:	00054783          	lbu	a5,0(a0)
    5518:	fbe5                	bnez	a5,5508 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
    551a:	0005c503          	lbu	a0,0(a1)
}
    551e:	40a7853b          	subw	a0,a5,a0
    5522:	60a2                	ld	ra,8(sp)
    5524:	6402                	ld	s0,0(sp)
    5526:	0141                	addi	sp,sp,16
    5528:	8082                	ret

000000000000552a <strlen>:

uint
strlen(const char *s)
{
    552a:	1141                	addi	sp,sp,-16
    552c:	e406                	sd	ra,8(sp)
    552e:	e022                	sd	s0,0(sp)
    5530:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
    5532:	00054783          	lbu	a5,0(a0)
    5536:	cf91                	beqz	a5,5552 <strlen+0x28>
    5538:	00150793          	addi	a5,a0,1
    553c:	86be                	mv	a3,a5
    553e:	0785                	addi	a5,a5,1
    5540:	fff7c703          	lbu	a4,-1(a5)
    5544:	ff65                	bnez	a4,553c <strlen+0x12>
    5546:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
    554a:	60a2                	ld	ra,8(sp)
    554c:	6402                	ld	s0,0(sp)
    554e:	0141                	addi	sp,sp,16
    5550:	8082                	ret
  for (n = 0; s[n]; n++)
    5552:	4501                	li	a0,0
    5554:	bfdd                	j	554a <strlen+0x20>

0000000000005556 <memset>:

void *
memset(void *dst, int c, uint n)
{
    5556:	1141                	addi	sp,sp,-16
    5558:	e406                	sd	ra,8(sp)
    555a:	e022                	sd	s0,0(sp)
    555c:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
    555e:	ca19                	beqz	a2,5574 <memset+0x1e>
    5560:	87aa                	mv	a5,a0
    5562:	1602                	slli	a2,a2,0x20
    5564:	9201                	srli	a2,a2,0x20
    5566:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    556a:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
    556e:	0785                	addi	a5,a5,1
    5570:	fee79de3          	bne	a5,a4,556a <memset+0x14>
  }
  return dst;
}
    5574:	60a2                	ld	ra,8(sp)
    5576:	6402                	ld	s0,0(sp)
    5578:	0141                	addi	sp,sp,16
    557a:	8082                	ret

000000000000557c <strchr>:

char *
strchr(const char *s, char c)
{
    557c:	1141                	addi	sp,sp,-16
    557e:	e406                	sd	ra,8(sp)
    5580:	e022                	sd	s0,0(sp)
    5582:	0800                	addi	s0,sp,16
  for (; *s; s++)
    5584:	00054783          	lbu	a5,0(a0)
    5588:	c799                	beqz	a5,5596 <strchr+0x1a>
    if (*s == c)
    558a:	00f58763          	beq	a1,a5,5598 <strchr+0x1c>
  for (; *s; s++)
    558e:	0505                	addi	a0,a0,1
    5590:	00054783          	lbu	a5,0(a0)
    5594:	fbfd                	bnez	a5,558a <strchr+0xe>
      return (char *)s;
  return 0;
    5596:	4501                	li	a0,0
}
    5598:	60a2                	ld	ra,8(sp)
    559a:	6402                	ld	s0,0(sp)
    559c:	0141                	addi	sp,sp,16
    559e:	8082                	ret

00000000000055a0 <gets>:

char *
gets(char *buf, int max)
{
    55a0:	711d                	addi	sp,sp,-96
    55a2:	ec86                	sd	ra,88(sp)
    55a4:	e8a2                	sd	s0,80(sp)
    55a6:	e4a6                	sd	s1,72(sp)
    55a8:	e0ca                	sd	s2,64(sp)
    55aa:	fc4e                	sd	s3,56(sp)
    55ac:	f852                	sd	s4,48(sp)
    55ae:	f456                	sd	s5,40(sp)
    55b0:	f05a                	sd	s6,32(sp)
    55b2:	ec5e                	sd	s7,24(sp)
    55b4:	e862                	sd	s8,16(sp)
    55b6:	1080                	addi	s0,sp,96
    55b8:	8baa                	mv	s7,a0
    55ba:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
    55bc:	892a                	mv	s2,a0
    55be:	4481                	li	s1,0
    cc = read(0, &c, 1);
    55c0:	faf40b13          	addi	s6,s0,-81
    55c4:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;) {
    55c6:	8c26                	mv	s8,s1
    55c8:	0014899b          	addiw	s3,s1,1
    55cc:	84ce                	mv	s1,s3
    55ce:	0349d863          	bge	s3,s4,55fe <gets+0x5e>
    cc = read(0, &c, 1);
    55d2:	8656                	mv	a2,s5
    55d4:	85da                	mv	a1,s6
    55d6:	4501                	li	a0,0
    55d8:	1c0000ef          	jal	5798 <read>
    if (cc < 1)
    55dc:	02a05163          	blez	a0,55fe <gets+0x5e>
      break;
    buf[i++] = c;
    55e0:	faf44783          	lbu	a5,-81(s0)
    55e4:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
    55e8:	0905                	addi	s2,s2,1
    55ea:	ff678713          	addi	a4,a5,-10
    55ee:	00173713          	seqz	a4,a4
    55f2:	17cd                	addi	a5,a5,-13
    55f4:	0017b793          	seqz	a5,a5
    55f8:	8fd9                	or	a5,a5,a4
    55fa:	d7f1                	beqz	a5,55c6 <gets+0x26>
    buf[i++] = c;
    55fc:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
    55fe:	9c5e                	add	s8,s8,s7
    5600:	000c0023          	sb	zero,0(s8)
  return buf;
}
    5604:	855e                	mv	a0,s7
    5606:	60e6                	ld	ra,88(sp)
    5608:	6446                	ld	s0,80(sp)
    560a:	64a6                	ld	s1,72(sp)
    560c:	6906                	ld	s2,64(sp)
    560e:	79e2                	ld	s3,56(sp)
    5610:	7a42                	ld	s4,48(sp)
    5612:	7aa2                	ld	s5,40(sp)
    5614:	7b02                	ld	s6,32(sp)
    5616:	6be2                	ld	s7,24(sp)
    5618:	6c42                	ld	s8,16(sp)
    561a:	6125                	addi	sp,sp,96
    561c:	8082                	ret

000000000000561e <stat>:

int
stat(const char *n, struct stat *st)
{
    561e:	1101                	addi	sp,sp,-32
    5620:	ec06                	sd	ra,24(sp)
    5622:	e822                	sd	s0,16(sp)
    5624:	e04a                	sd	s2,0(sp)
    5626:	1000                	addi	s0,sp,32
    5628:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    562a:	4581                	li	a1,0
    562c:	194000ef          	jal	57c0 <open>
  if (fd < 0)
    5630:	02054263          	bltz	a0,5654 <stat+0x36>
    5634:	e426                	sd	s1,8(sp)
    5636:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    5638:	85ca                	mv	a1,s2
    563a:	19e000ef          	jal	57d8 <fstat>
    563e:	892a                	mv	s2,a0
  close(fd);
    5640:	8526                	mv	a0,s1
    5642:	166000ef          	jal	57a8 <close>
  return r;
    5646:	64a2                	ld	s1,8(sp)
}
    5648:	854a                	mv	a0,s2
    564a:	60e2                	ld	ra,24(sp)
    564c:	6442                	ld	s0,16(sp)
    564e:	6902                	ld	s2,0(sp)
    5650:	6105                	addi	sp,sp,32
    5652:	8082                	ret
    return -1;
    5654:	57fd                	li	a5,-1
    5656:	893e                	mv	s2,a5
    5658:	bfc5                	j	5648 <stat+0x2a>

000000000000565a <atoi>:

int
atoi(const char *s)
{
    565a:	1141                	addi	sp,sp,-16
    565c:	e406                	sd	ra,8(sp)
    565e:	e022                	sd	s0,0(sp)
    5660:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
    5662:	00054683          	lbu	a3,0(a0)
    5666:	fd06879b          	addiw	a5,a3,-48
    566a:	0ff7f793          	zext.b	a5,a5
    566e:	4625                	li	a2,9
    5670:	02f66963          	bltu	a2,a5,56a2 <atoi+0x48>
    5674:	872a                	mv	a4,a0
  n = 0;
    5676:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
    5678:	0705                	addi	a4,a4,1 # 1000001 <base+0xfdeb09>
    567a:	0025179b          	slliw	a5,a0,0x2
    567e:	9fa9                	addw	a5,a5,a0
    5680:	0017979b          	slliw	a5,a5,0x1
    5684:	9fb5                	addw	a5,a5,a3
    5686:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
    568a:	00074683          	lbu	a3,0(a4)
    568e:	fd06879b          	addiw	a5,a3,-48
    5692:	0ff7f793          	zext.b	a5,a5
    5696:	fef671e3          	bgeu	a2,a5,5678 <atoi+0x1e>
  return n;
}
    569a:	60a2                	ld	ra,8(sp)
    569c:	6402                	ld	s0,0(sp)
    569e:	0141                	addi	sp,sp,16
    56a0:	8082                	ret
  n = 0;
    56a2:	4501                	li	a0,0
    56a4:	bfdd                	j	569a <atoi+0x40>

00000000000056a6 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
    56a6:	1141                	addi	sp,sp,-16
    56a8:	e406                	sd	ra,8(sp)
    56aa:	e022                	sd	s0,0(sp)
    56ac:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    56ae:	02b57563          	bgeu	a0,a1,56d8 <memmove+0x32>
    while (n-- > 0)
    56b2:	00c05f63          	blez	a2,56d0 <memmove+0x2a>
    56b6:	1602                	slli	a2,a2,0x20
    56b8:	9201                	srli	a2,a2,0x20
    56ba:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    56be:	872a                	mv	a4,a0
      *dst++ = *src++;
    56c0:	0585                	addi	a1,a1,1
    56c2:	0705                	addi	a4,a4,1
    56c4:	fff5c683          	lbu	a3,-1(a1)
    56c8:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
    56cc:	fee79ae3          	bne	a5,a4,56c0 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    56d0:	60a2                	ld	ra,8(sp)
    56d2:	6402                	ld	s0,0(sp)
    56d4:	0141                	addi	sp,sp,16
    56d6:	8082                	ret
    while (n-- > 0)
    56d8:	fec05ce3          	blez	a2,56d0 <memmove+0x2a>
    dst += n;
    56dc:	00c50733          	add	a4,a0,a2
    src += n;
    56e0:	95b2                	add	a1,a1,a2
    56e2:	fff6079b          	addiw	a5,a2,-1
    56e6:	1782                	slli	a5,a5,0x20
    56e8:	9381                	srli	a5,a5,0x20
    56ea:	fff7c793          	not	a5,a5
    56ee:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    56f0:	15fd                	addi	a1,a1,-1
    56f2:	177d                	addi	a4,a4,-1
    56f4:	0005c683          	lbu	a3,0(a1)
    56f8:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
    56fc:	fef71ae3          	bne	a4,a5,56f0 <memmove+0x4a>
    5700:	bfc1                	j	56d0 <memmove+0x2a>

0000000000005702 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    5702:	1141                	addi	sp,sp,-16
    5704:	e406                	sd	ra,8(sp)
    5706:	e022                	sd	s0,0(sp)
    5708:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    570a:	ce19                	beqz	a2,5728 <memcmp+0x26>
    570c:	1602                	slli	a2,a2,0x20
    570e:	9201                	srli	a2,a2,0x20
    5710:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
    5714:	00054783          	lbu	a5,0(a0)
    5718:	0005c703          	lbu	a4,0(a1)
    571c:	00e79b63          	bne	a5,a4,5732 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
    5720:	0505                	addi	a0,a0,1
    p2++;
    5722:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    5724:	fed518e3          	bne	a0,a3,5714 <memcmp+0x12>
  }
  return 0;
    5728:	4501                	li	a0,0
}
    572a:	60a2                	ld	ra,8(sp)
    572c:	6402                	ld	s0,0(sp)
    572e:	0141                	addi	sp,sp,16
    5730:	8082                	ret
      return *p1 - *p2;
    5732:	40e7853b          	subw	a0,a5,a4
    5736:	bfd5                	j	572a <memcmp+0x28>

0000000000005738 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    5738:	1141                	addi	sp,sp,-16
    573a:	e406                	sd	ra,8(sp)
    573c:	e022                	sd	s0,0(sp)
    573e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    5740:	f67ff0ef          	jal	56a6 <memmove>
}
    5744:	60a2                	ld	ra,8(sp)
    5746:	6402                	ld	s0,0(sp)
    5748:	0141                	addi	sp,sp,16
    574a:	8082                	ret

000000000000574c <sbrk>:

char *
sbrk(int n)
{
    574c:	1141                	addi	sp,sp,-16
    574e:	e406                	sd	ra,8(sp)
    5750:	e022                	sd	s0,0(sp)
    5752:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
    5754:	4585                	li	a1,1
    5756:	0b2000ef          	jal	5808 <sys_sbrk>
}
    575a:	60a2                	ld	ra,8(sp)
    575c:	6402                	ld	s0,0(sp)
    575e:	0141                	addi	sp,sp,16
    5760:	8082                	ret

0000000000005762 <sbrklazy>:

char *
sbrklazy(int n)
{
    5762:	1141                	addi	sp,sp,-16
    5764:	e406                	sd	ra,8(sp)
    5766:	e022                	sd	s0,0(sp)
    5768:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
    576a:	4589                	li	a1,2
    576c:	09c000ef          	jal	5808 <sys_sbrk>
}
    5770:	60a2                	ld	ra,8(sp)
    5772:	6402                	ld	s0,0(sp)
    5774:	0141                	addi	sp,sp,16
    5776:	8082                	ret

0000000000005778 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    5778:	4885                	li	a7,1
 ecall
    577a:	00000073          	ecall
 ret
    577e:	8082                	ret

0000000000005780 <exit>:
.global exit
exit:
 li a7, SYS_exit
    5780:	4889                	li	a7,2
 ecall
    5782:	00000073          	ecall
 ret
    5786:	8082                	ret

0000000000005788 <wait>:
.global wait
wait:
 li a7, SYS_wait
    5788:	488d                	li	a7,3
 ecall
    578a:	00000073          	ecall
 ret
    578e:	8082                	ret

0000000000005790 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5790:	4891                	li	a7,4
 ecall
    5792:	00000073          	ecall
 ret
    5796:	8082                	ret

0000000000005798 <read>:
.global read
read:
 li a7, SYS_read
    5798:	4895                	li	a7,5
 ecall
    579a:	00000073          	ecall
 ret
    579e:	8082                	ret

00000000000057a0 <write>:
.global write
write:
 li a7, SYS_write
    57a0:	48c1                	li	a7,16
 ecall
    57a2:	00000073          	ecall
 ret
    57a6:	8082                	ret

00000000000057a8 <close>:
.global close
close:
 li a7, SYS_close
    57a8:	48d5                	li	a7,21
 ecall
    57aa:	00000073          	ecall
 ret
    57ae:	8082                	ret

00000000000057b0 <kill>:
.global kill
kill:
 li a7, SYS_kill
    57b0:	4899                	li	a7,6
 ecall
    57b2:	00000073          	ecall
 ret
    57b6:	8082                	ret

00000000000057b8 <exec>:
.global exec
exec:
 li a7, SYS_exec
    57b8:	489d                	li	a7,7
 ecall
    57ba:	00000073          	ecall
 ret
    57be:	8082                	ret

00000000000057c0 <open>:
.global open
open:
 li a7, SYS_open
    57c0:	48bd                	li	a7,15
 ecall
    57c2:	00000073          	ecall
 ret
    57c6:	8082                	ret

00000000000057c8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    57c8:	48c5                	li	a7,17
 ecall
    57ca:	00000073          	ecall
 ret
    57ce:	8082                	ret

00000000000057d0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    57d0:	48c9                	li	a7,18
 ecall
    57d2:	00000073          	ecall
 ret
    57d6:	8082                	ret

00000000000057d8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    57d8:	48a1                	li	a7,8
 ecall
    57da:	00000073          	ecall
 ret
    57de:	8082                	ret

00000000000057e0 <link>:
.global link
link:
 li a7, SYS_link
    57e0:	48cd                	li	a7,19
 ecall
    57e2:	00000073          	ecall
 ret
    57e6:	8082                	ret

00000000000057e8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    57e8:	48d1                	li	a7,20
 ecall
    57ea:	00000073          	ecall
 ret
    57ee:	8082                	ret

00000000000057f0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    57f0:	48a5                	li	a7,9
 ecall
    57f2:	00000073          	ecall
 ret
    57f6:	8082                	ret

00000000000057f8 <dup>:
.global dup
dup:
 li a7, SYS_dup
    57f8:	48a9                	li	a7,10
 ecall
    57fa:	00000073          	ecall
 ret
    57fe:	8082                	ret

0000000000005800 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    5800:	48ad                	li	a7,11
 ecall
    5802:	00000073          	ecall
 ret
    5806:	8082                	ret

0000000000005808 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
    5808:	48b1                	li	a7,12
 ecall
    580a:	00000073          	ecall
 ret
    580e:	8082                	ret

0000000000005810 <pause>:
.global pause
pause:
 li a7, SYS_pause
    5810:	48b5                	li	a7,13
 ecall
    5812:	00000073          	ecall
 ret
    5816:	8082                	ret

0000000000005818 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    5818:	48b9                	li	a7,14
 ecall
    581a:	00000073          	ecall
 ret
    581e:	8082                	ret

0000000000005820 <sync>:
.global sync
sync:
 li a7, SYS_sync
    5820:	48d9                	li	a7,22
 ecall
    5822:	00000073          	ecall
 ret
    5826:	8082                	ret

0000000000005828 <istat>:
.global istat
istat:
 li a7, SYS_istat
    5828:	48dd                	li	a7,23
 ecall
    582a:	00000073          	ecall
 ret
    582e:	8082                	ret

0000000000005830 <iprint>:
.global iprint
iprint:
 li a7, SYS_iprint
    5830:	48e1                	li	a7,24
 ecall
    5832:	00000073          	ecall
 ret
    5836:	8082                	ret

0000000000005838 <symlink>:
.global symlink
symlink:
 li a7, SYS_symlink
    5838:	48e5                	li	a7,25
 ecall
    583a:	00000073          	ecall
 ret
    583e:	8082                	ret

0000000000005840 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    5840:	1101                	addi	sp,sp,-32
    5842:	ec06                	sd	ra,24(sp)
    5844:	e822                	sd	s0,16(sp)
    5846:	1000                	addi	s0,sp,32
    5848:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    584c:	4605                	li	a2,1
    584e:	fef40593          	addi	a1,s0,-17
    5852:	f4fff0ef          	jal	57a0 <write>
}
    5856:	60e2                	ld	ra,24(sp)
    5858:	6442                	ld	s0,16(sp)
    585a:	6105                	addi	sp,sp,32
    585c:	8082                	ret

000000000000585e <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
    585e:	715d                	addi	sp,sp,-80
    5860:	e486                	sd	ra,72(sp)
    5862:	e0a2                	sd	s0,64(sp)
    5864:	f84a                	sd	s2,48(sp)
    5866:	f44e                	sd	s3,40(sp)
    5868:	0880                	addi	s0,sp,80
    586a:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
    586c:	00d036b3          	snez	a3,a3
    5870:	03f5d793          	srli	a5,a1,0x3f
    5874:	8efd                	and	a3,a3,a5
  neg = 0;
    5876:	4301                	li	t1,0
  if (sgn && xx < 0) {
    5878:	c681                	beqz	a3,5880 <printint+0x22>
    neg = 1;
    x = -xx;
    587a:	40b005b3          	neg	a1,a1
    neg = 1;
    587e:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
    5880:	fb840993          	addi	s3,s0,-72
  neg = 0;
    5884:	86ce                	mv	a3,s3
  i = 0;
    5886:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    5888:	00003817          	auipc	a6,0x3
    588c:	f0080813          	addi	a6,a6,-256 # 8788 <digits>
    5890:	88ba                	mv	a7,a4
    5892:	0017051b          	addiw	a0,a4,1
    5896:	872a                	mv	a4,a0
    5898:	02c5f7b3          	remu	a5,a1,a2
    589c:	97c2                	add	a5,a5,a6
    589e:	0007c783          	lbu	a5,0(a5)
    58a2:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
    58a6:	87ae                	mv	a5,a1
    58a8:	02c5d5b3          	divu	a1,a1,a2
    58ac:	0685                	addi	a3,a3,1
    58ae:	fec7f1e3          	bgeu	a5,a2,5890 <printint+0x32>
  if (neg)
    58b2:	00030b63          	beqz	t1,58c8 <printint+0x6a>
    buf[i++] = '-';
    58b6:	fd040793          	addi	a5,s0,-48
    58ba:	953e                	add	a0,a0,a5
    58bc:	02d00793          	li	a5,45
    58c0:	fef50423          	sb	a5,-24(a0)
    58c4:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
    58c8:	02e05563          	blez	a4,58f2 <printint+0x94>
    58cc:	fc26                	sd	s1,56(sp)
    58ce:	377d                	addiw	a4,a4,-1
    58d0:	00e984b3          	add	s1,s3,a4
    58d4:	19fd                	addi	s3,s3,-1 # fff <bigdir+0xff>
    58d6:	99ba                	add	s3,s3,a4
    58d8:	1702                	slli	a4,a4,0x20
    58da:	9301                	srli	a4,a4,0x20
    58dc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    58e0:	0004c583          	lbu	a1,0(s1)
    58e4:	854a                	mv	a0,s2
    58e6:	f5bff0ef          	jal	5840 <putc>
  while (--i >= 0)
    58ea:	14fd                	addi	s1,s1,-1
    58ec:	ff349ae3          	bne	s1,s3,58e0 <printint+0x82>
    58f0:	74e2                	ld	s1,56(sp)
}
    58f2:	60a6                	ld	ra,72(sp)
    58f4:	6406                	ld	s0,64(sp)
    58f6:	7942                	ld	s2,48(sp)
    58f8:	79a2                	ld	s3,40(sp)
    58fa:	6161                	addi	sp,sp,80
    58fc:	8082                	ret

00000000000058fe <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    58fe:	711d                	addi	sp,sp,-96
    5900:	ec86                	sd	ra,88(sp)
    5902:	e8a2                	sd	s0,80(sp)
    5904:	e4a6                	sd	s1,72(sp)
    5906:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
    5908:	0005c483          	lbu	s1,0(a1)
    590c:	2a048063          	beqz	s1,5bac <vprintf+0x2ae>
    5910:	e0ca                	sd	s2,64(sp)
    5912:	fc4e                	sd	s3,56(sp)
    5914:	f852                	sd	s4,48(sp)
    5916:	f456                	sd	s5,40(sp)
    5918:	f05a                	sd	s6,32(sp)
    591a:	ec5e                	sd	s7,24(sp)
    591c:	e862                	sd	s8,16(sp)
    591e:	8b2a                	mv	s6,a0
    5920:	8a2e                	mv	s4,a1
    5922:	8bb2                	mv	s7,a2
  state = 0;
    5924:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
    5926:	4901                	li	s2,0
    5928:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
    592a:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
    592e:	06400c13          	li	s8,100
    5932:	a00d                	j	5954 <vprintf+0x56>
        putc(fd, c0);
    5934:	85a6                	mv	a1,s1
    5936:	855a                	mv	a0,s6
    5938:	f09ff0ef          	jal	5840 <putc>
    593c:	a019                	j	5942 <vprintf+0x44>
    } else if (state == '%') {
    593e:	03598363          	beq	s3,s5,5964 <vprintf+0x66>
  for (i = 0; fmt[i]; i++) {
    5942:	0019079b          	addiw	a5,s2,1
    5946:	893e                	mv	s2,a5
    5948:	873e                	mv	a4,a5
    594a:	97d2                	add	a5,a5,s4
    594c:	0007c483          	lbu	s1,0(a5)
    5950:	24048763          	beqz	s1,5b9e <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
    5954:	0004879b          	sext.w	a5,s1
    if (state == 0) {
    5958:	fe0993e3          	bnez	s3,593e <vprintf+0x40>
      if (c0 == '%') {
    595c:	fd579ce3          	bne	a5,s5,5934 <vprintf+0x36>
        state = '%';
    5960:	89be                	mv	s3,a5
    5962:	b7c5                	j	5942 <vprintf+0x44>
        c1 = fmt[i + 1] & 0xff;
    5964:	00ea06b3          	add	a3,s4,a4
    5968:	0016c603          	lbu	a2,1(a3)
      if (c1)
    596c:	24060563          	beqz	a2,5bb6 <vprintf+0x2b8>
      if (c0 == 'd') {
    5970:	0b878763          	beq	a5,s8,5a1e <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
    5974:	f9478693          	addi	a3,a5,-108
    5978:	0016b693          	seqz	a3,a3
    597c:	f9c60593          	addi	a1,a2,-100
    5980:	0015b593          	seqz	a1,a1
    5984:	8df5                	and	a1,a1,a3
    5986:	e9c5                	bnez	a1,5a36 <vprintf+0x138>
        c2 = fmt[i + 2] & 0xff;
    5988:	9752                	add	a4,a4,s4
    598a:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
    598e:	f9460713          	addi	a4,a2,-108
    5992:	00173713          	seqz	a4,a4
    5996:	8f75                	and	a4,a4,a3
    5998:	f9c50593          	addi	a1,a0,-100
    599c:	0015b593          	seqz	a1,a1
    59a0:	8df9                	and	a1,a1,a4
    59a2:	e5dd                	bnez	a1,5a50 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
    59a4:	07500593          	li	a1,117
    59a8:	0cb78163          	beq	a5,a1,5a6a <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if (c0 == 'l' && c1 == 'u') {
    59ac:	f8b60593          	addi	a1,a2,-117
    59b0:	0015b593          	seqz	a1,a1
    59b4:	8df5                	and	a1,a1,a3
    59b6:	e5f1                	bnez	a1,5a82 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
    59b8:	f8b50593          	addi	a1,a0,-117
    59bc:	0015b593          	seqz	a1,a1
    59c0:	8df9                	and	a1,a1,a4
    59c2:	ede9                	bnez	a1,5a9c <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
    59c4:	07800593          	li	a1,120
    59c8:	0eb78763          	beq	a5,a1,5ab6 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if (c0 == 'l' && c1 == 'x') {
    59cc:	f8860613          	addi	a2,a2,-120
    59d0:	00163613          	seqz	a2,a2
    59d4:	8ef1                	and	a3,a3,a2
    59d6:	0e069c63          	bnez	a3,5ace <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
    59da:	f8850513          	addi	a0,a0,-120
    59de:	00153513          	seqz	a0,a0
    59e2:	8f69                	and	a4,a4,a0
    59e4:	10071263          	bnez	a4,5ae8 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
    59e8:	07000713          	li	a4,112
    59ec:	10e78a63          	beq	a5,a4,5b00 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
    59f0:	06300713          	li	a4,99
    59f4:	14e78a63          	beq	a5,a4,5b48 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
    59f8:	07300713          	li	a4,115
    59fc:	16e78063          	beq	a5,a4,5b5c <vprintf+0x25e>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
    5a00:	02500713          	li	a4,37
    5a04:	18e78863          	beq	a5,a4,5b94 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    5a08:	02500593          	li	a1,37
    5a0c:	855a                	mv	a0,s6
    5a0e:	e33ff0ef          	jal	5840 <putc>
        putc(fd, c0);
    5a12:	85a6                	mv	a1,s1
    5a14:	855a                	mv	a0,s6
    5a16:	e2bff0ef          	jal	5840 <putc>
      }

      state = 0;
    5a1a:	4981                	li	s3,0
    5a1c:	b71d                	j	5942 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
    5a1e:	008b8493          	addi	s1,s7,8
    5a22:	4685                	li	a3,1
    5a24:	4629                	li	a2,10
    5a26:	000ba583          	lw	a1,0(s7)
    5a2a:	855a                	mv	a0,s6
    5a2c:	e33ff0ef          	jal	585e <printint>
    5a30:	8ba6                	mv	s7,s1
      state = 0;
    5a32:	4981                	li	s3,0
    5a34:	b739                	j	5942 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
    5a36:	008b8493          	addi	s1,s7,8
    5a3a:	4685                	li	a3,1
    5a3c:	4629                	li	a2,10
    5a3e:	000bb583          	ld	a1,0(s7)
    5a42:	855a                	mv	a0,s6
    5a44:	e1bff0ef          	jal	585e <printint>
        i += 1;
    5a48:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    5a4a:	8ba6                	mv	s7,s1
      state = 0;
    5a4c:	4981                	li	s3,0
    5a4e:	bdd5                	j	5942 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
    5a50:	008b8493          	addi	s1,s7,8
    5a54:	4685                	li	a3,1
    5a56:	4629                	li	a2,10
    5a58:	000bb583          	ld	a1,0(s7)
    5a5c:	855a                	mv	a0,s6
    5a5e:	e01ff0ef          	jal	585e <printint>
        i += 2;
    5a62:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    5a64:	8ba6                	mv	s7,s1
      state = 0;
    5a66:	4981                	li	s3,0
        i += 2;
    5a68:	bde9                	j	5942 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
    5a6a:	008b8493          	addi	s1,s7,8
    5a6e:	4681                	li	a3,0
    5a70:	4629                	li	a2,10
    5a72:	000be583          	lwu	a1,0(s7)
    5a76:	855a                	mv	a0,s6
    5a78:	de7ff0ef          	jal	585e <printint>
    5a7c:	8ba6                	mv	s7,s1
      state = 0;
    5a7e:	4981                	li	s3,0
    5a80:	b5c9                	j	5942 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5a82:	008b8493          	addi	s1,s7,8
    5a86:	4681                	li	a3,0
    5a88:	4629                	li	a2,10
    5a8a:	000bb583          	ld	a1,0(s7)
    5a8e:	855a                	mv	a0,s6
    5a90:	dcfff0ef          	jal	585e <printint>
        i += 1;
    5a94:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    5a96:	8ba6                	mv	s7,s1
      state = 0;
    5a98:	4981                	li	s3,0
    5a9a:	b565                	j	5942 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5a9c:	008b8493          	addi	s1,s7,8
    5aa0:	4681                	li	a3,0
    5aa2:	4629                	li	a2,10
    5aa4:	000bb583          	ld	a1,0(s7)
    5aa8:	855a                	mv	a0,s6
    5aaa:	db5ff0ef          	jal	585e <printint>
        i += 2;
    5aae:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    5ab0:	8ba6                	mv	s7,s1
      state = 0;
    5ab2:	4981                	li	s3,0
        i += 2;
    5ab4:	b579                	j	5942 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
    5ab6:	008b8493          	addi	s1,s7,8
    5aba:	4681                	li	a3,0
    5abc:	4641                	li	a2,16
    5abe:	000be583          	lwu	a1,0(s7)
    5ac2:	855a                	mv	a0,s6
    5ac4:	d9bff0ef          	jal	585e <printint>
    5ac8:	8ba6                	mv	s7,s1
      state = 0;
    5aca:	4981                	li	s3,0
    5acc:	bd9d                	j	5942 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
    5ace:	008b8493          	addi	s1,s7,8
    5ad2:	4681                	li	a3,0
    5ad4:	4641                	li	a2,16
    5ad6:	000bb583          	ld	a1,0(s7)
    5ada:	855a                	mv	a0,s6
    5adc:	d83ff0ef          	jal	585e <printint>
        i += 1;
    5ae0:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    5ae2:	8ba6                	mv	s7,s1
      state = 0;
    5ae4:	4981                	li	s3,0
    5ae6:	bdb1                	j	5942 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
    5ae8:	008b8493          	addi	s1,s7,8
    5aec:	4641                	li	a2,16
    5aee:	000bb583          	ld	a1,0(s7)
    5af2:	855a                	mv	a0,s6
    5af4:	d6bff0ef          	jal	585e <printint>
        i += 2;
    5af8:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    5afa:	8ba6                	mv	s7,s1
      state = 0;
    5afc:	4981                	li	s3,0
        i += 2;
    5afe:	b591                	j	5942 <vprintf+0x44>
    5b00:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
    5b02:	008b8793          	addi	a5,s7,8
    5b06:	8cbe                	mv	s9,a5
    5b08:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    5b0c:	03000593          	li	a1,48
    5b10:	855a                	mv	a0,s6
    5b12:	d2fff0ef          	jal	5840 <putc>
  putc(fd, 'x');
    5b16:	07800593          	li	a1,120
    5b1a:	855a                	mv	a0,s6
    5b1c:	d25ff0ef          	jal	5840 <putc>
    5b20:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5b22:	00003b97          	auipc	s7,0x3
    5b26:	c66b8b93          	addi	s7,s7,-922 # 8788 <digits>
    5b2a:	03c9d793          	srli	a5,s3,0x3c
    5b2e:	97de                	add	a5,a5,s7
    5b30:	0007c583          	lbu	a1,0(a5)
    5b34:	855a                	mv	a0,s6
    5b36:	d0bff0ef          	jal	5840 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5b3a:	0992                	slli	s3,s3,0x4
    5b3c:	34fd                	addiw	s1,s1,-1
    5b3e:	f4f5                	bnez	s1,5b2a <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
    5b40:	8be6                	mv	s7,s9
      state = 0;
    5b42:	4981                	li	s3,0
    5b44:	6ca2                	ld	s9,8(sp)
    5b46:	bbf5                	j	5942 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
    5b48:	008b8493          	addi	s1,s7,8
    5b4c:	000bc583          	lbu	a1,0(s7)
    5b50:	855a                	mv	a0,s6
    5b52:	cefff0ef          	jal	5840 <putc>
    5b56:	8ba6                	mv	s7,s1
      state = 0;
    5b58:	4981                	li	s3,0
    5b5a:	b3e5                	j	5942 <vprintf+0x44>
        if ((s = va_arg(ap, char *)) == 0)
    5b5c:	008b8993          	addi	s3,s7,8
    5b60:	000bb483          	ld	s1,0(s7)
    5b64:	cc91                	beqz	s1,5b80 <vprintf+0x282>
        for (; *s; s++)
    5b66:	0004c583          	lbu	a1,0(s1)
    5b6a:	c195                	beqz	a1,5b8e <vprintf+0x290>
          putc(fd, *s);
    5b6c:	855a                	mv	a0,s6
    5b6e:	cd3ff0ef          	jal	5840 <putc>
        for (; *s; s++)
    5b72:	0485                	addi	s1,s1,1
    5b74:	0004c583          	lbu	a1,0(s1)
    5b78:	f9f5                	bnez	a1,5b6c <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
    5b7a:	8bce                	mv	s7,s3
      state = 0;
    5b7c:	4981                	li	s3,0
    5b7e:	b3d1                	j	5942 <vprintf+0x44>
          s = "(null)";
    5b80:	00003497          	auipc	s1,0x3
    5b84:	b5848493          	addi	s1,s1,-1192 # 86d8 <malloc+0x2a26>
        for (; *s; s++)
    5b88:	02800593          	li	a1,40
    5b8c:	b7c5                	j	5b6c <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
    5b8e:	8bce                	mv	s7,s3
      state = 0;
    5b90:	4981                	li	s3,0
    5b92:	bb45                	j	5942 <vprintf+0x44>
        putc(fd, '%');
    5b94:	85be                	mv	a1,a5
    5b96:	855a                	mv	a0,s6
    5b98:	ca9ff0ef          	jal	5840 <putc>
    5b9c:	bdbd                	j	5a1a <vprintf+0x11c>
    5b9e:	6906                	ld	s2,64(sp)
    5ba0:	79e2                	ld	s3,56(sp)
    5ba2:	7a42                	ld	s4,48(sp)
    5ba4:	7aa2                	ld	s5,40(sp)
    5ba6:	7b02                	ld	s6,32(sp)
    5ba8:	6be2                	ld	s7,24(sp)
    5baa:	6c42                	ld	s8,16(sp)
    }
  }
}
    5bac:	60e6                	ld	ra,88(sp)
    5bae:	6446                	ld	s0,80(sp)
    5bb0:	64a6                	ld	s1,72(sp)
    5bb2:	6125                	addi	sp,sp,96
    5bb4:	8082                	ret
      if (c0 == 'd') {
    5bb6:	06400713          	li	a4,100
    5bba:	e6e782e3          	beq	a5,a4,5a1e <vprintf+0x120>
      } else if (c0 == 'l' && c1 == 'd') {
    5bbe:	f9478693          	addi	a3,a5,-108
    5bc2:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
    5bc6:	8532                	mv	a0,a2
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
    5bc8:	4701                	li	a4,0
    5bca:	bbe9                	j	59a4 <vprintf+0xa6>

0000000000005bcc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    5bcc:	715d                	addi	sp,sp,-80
    5bce:	ec06                	sd	ra,24(sp)
    5bd0:	e822                	sd	s0,16(sp)
    5bd2:	1000                	addi	s0,sp,32
    5bd4:	e010                	sd	a2,0(s0)
    5bd6:	e414                	sd	a3,8(s0)
    5bd8:	e818                	sd	a4,16(s0)
    5bda:	ec1c                	sd	a5,24(s0)
    5bdc:	03043023          	sd	a6,32(s0)
    5be0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    5be4:	8622                	mv	a2,s0
    5be6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5bea:	d15ff0ef          	jal	58fe <vprintf>
}
    5bee:	60e2                	ld	ra,24(sp)
    5bf0:	6442                	ld	s0,16(sp)
    5bf2:	6161                	addi	sp,sp,80
    5bf4:	8082                	ret

0000000000005bf6 <printf>:

void
printf(const char *fmt, ...)
{
    5bf6:	711d                	addi	sp,sp,-96
    5bf8:	ec06                	sd	ra,24(sp)
    5bfa:	e822                	sd	s0,16(sp)
    5bfc:	1000                	addi	s0,sp,32
    5bfe:	e40c                	sd	a1,8(s0)
    5c00:	e810                	sd	a2,16(s0)
    5c02:	ec14                	sd	a3,24(s0)
    5c04:	f018                	sd	a4,32(s0)
    5c06:	f41c                	sd	a5,40(s0)
    5c08:	03043823          	sd	a6,48(s0)
    5c0c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    5c10:	00840613          	addi	a2,s0,8
    5c14:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5c18:	85aa                	mv	a1,a0
    5c1a:	4505                	li	a0,1
    5c1c:	ce3ff0ef          	jal	58fe <vprintf>
}
    5c20:	60e2                	ld	ra,24(sp)
    5c22:	6442                	ld	s0,16(sp)
    5c24:	6125                	addi	sp,sp,96
    5c26:	8082                	ret

0000000000005c28 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5c28:	1141                	addi	sp,sp,-16
    5c2a:	e406                	sd	ra,8(sp)
    5c2c:	e022                	sd	s0,0(sp)
    5c2e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
    5c30:	ff050713          	addi	a4,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5c34:	00004797          	auipc	a5,0x4
    5c38:	89c7b783          	ld	a5,-1892(a5) # 94d0 <freep>
    5c3c:	a095                	j	5ca0 <free+0x78>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
    5c3e:	ff852583          	lw	a1,-8(a0)
    5c42:	6390                	ld	a2,0(a5)
    5c44:	02059813          	slli	a6,a1,0x20
    5c48:	01c85693          	srli	a3,a6,0x1c
    5c4c:	96ba                	add	a3,a3,a4
    5c4e:	02d60563          	beq	a2,a3,5c78 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    5c52:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
    5c56:	4790                	lw	a2,8(a5)
    5c58:	02061593          	slli	a1,a2,0x20
    5c5c:	01c5d693          	srli	a3,a1,0x1c
    5c60:	96be                	add	a3,a3,a5
    5c62:	02d70263          	beq	a4,a3,5c86 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    5c66:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    5c68:	00004717          	auipc	a4,0x4
    5c6c:	86f73423          	sd	a5,-1944(a4) # 94d0 <freep>
}
    5c70:	60a2                	ld	ra,8(sp)
    5c72:	6402                	ld	s0,0(sp)
    5c74:	0141                	addi	sp,sp,16
    5c76:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
    5c78:	4614                	lw	a3,8(a2)
    5c7a:	9ead                	addw	a3,a3,a1
    5c7c:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    5c80:	6394                	ld	a3,0(a5)
    5c82:	6290                	ld	a2,0(a3)
    5c84:	b7f9                	j	5c52 <free+0x2a>
    p->s.size += bp->s.size;
    5c86:	ff852703          	lw	a4,-8(a0)
    5c8a:	9f31                	addw	a4,a4,a2
    5c8c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    5c8e:	ff053703          	ld	a4,-16(a0)
    5c92:	bfd1                	j	5c66 <free+0x3e>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5c94:	6394                	ld	a3,0(a5)
    5c96:	00d7e463          	bltu	a5,a3,5c9e <free+0x76>
    5c9a:	fad762e3          	bltu	a4,a3,5c3e <free+0x16>
    5c9e:	87b6                	mv	a5,a3
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5ca0:	fee7fae3          	bgeu	a5,a4,5c94 <free+0x6c>
    5ca4:	6394                	ld	a3,0(a5)
    5ca6:	f8d76ce3          	bltu	a4,a3,5c3e <free+0x16>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5caa:	f8d7fae3          	bgeu	a5,a3,5c3e <free+0x16>
    5cae:	87b6                	mv	a5,a3
    5cb0:	bfc5                	j	5ca0 <free+0x78>

0000000000005cb2 <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
    5cb2:	7139                	addi	sp,sp,-64
    5cb4:	fc06                	sd	ra,56(sp)
    5cb6:	f822                	sd	s0,48(sp)
    5cb8:	f04a                	sd	s2,32(sp)
    5cba:	ec4e                	sd	s3,24(sp)
    5cbc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    5cbe:	02051993          	slli	s3,a0,0x20
    5cc2:	0209d993          	srli	s3,s3,0x20
    5cc6:	09bd                	addi	s3,s3,15
    5cc8:	0049d993          	srli	s3,s3,0x4
    5ccc:	2985                	addiw	s3,s3,1
    5cce:	894e                	mv	s2,s3
  if ((prevp = freep) == 0) {
    5cd0:	00004517          	auipc	a0,0x4
    5cd4:	80053503          	ld	a0,-2048(a0) # 94d0 <freep>
    5cd8:	c905                	beqz	a0,5d08 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    5cda:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
    5cdc:	4798                	lw	a4,8(a5)
    5cde:	09377663          	bgeu	a4,s3,5d6a <malloc+0xb8>
    5ce2:	f426                	sd	s1,40(sp)
    5ce4:	e852                	sd	s4,16(sp)
    5ce6:	e456                	sd	s5,8(sp)
    5ce8:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
    5cea:	8a4e                	mv	s4,s3
    5cec:	6705                	lui	a4,0x1
    5cee:	00e9f363          	bgeu	s3,a4,5cf4 <malloc+0x42>
    5cf2:	6a05                	lui	s4,0x1
    5cf4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    5cf8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
    5cfc:	00003497          	auipc	s1,0x3
    5d00:	7d448493          	addi	s1,s1,2004 # 94d0 <freep>
  if (p == SBRK_ERROR)
    5d04:	5afd                	li	s5,-1
    5d06:	a83d                	j	5d44 <malloc+0x92>
    5d08:	f426                	sd	s1,40(sp)
    5d0a:	e852                	sd	s4,16(sp)
    5d0c:	e456                	sd	s5,8(sp)
    5d0e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    5d10:	0001b797          	auipc	a5,0x1b
    5d14:	7e878793          	addi	a5,a5,2024 # 214f8 <base>
    5d18:	00003717          	auipc	a4,0x3
    5d1c:	7af73c23          	sd	a5,1976(a4) # 94d0 <freep>
    5d20:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    5d22:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
    5d26:	b7d1                	j	5cea <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    5d28:	6398                	ld	a4,0(a5)
    5d2a:	e118                	sd	a4,0(a0)
    5d2c:	a899                	j	5d82 <malloc+0xd0>
  hp->s.size = nu;
    5d2e:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
    5d32:	0541                	addi	a0,a0,16
    5d34:	ef5ff0ef          	jal	5c28 <free>
  return freep;
    5d38:	6088                	ld	a0,0(s1)
      if ((p = morecore(nunits)) == 0)
    5d3a:	c125                	beqz	a0,5d9a <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    5d3c:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
    5d3e:	4798                	lw	a4,8(a5)
    5d40:	03277163          	bgeu	a4,s2,5d62 <malloc+0xb0>
    if (p == freep)
    5d44:	6098                	ld	a4,0(s1)
    5d46:	853e                	mv	a0,a5
    5d48:	fef71ae3          	bne	a4,a5,5d3c <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
    5d4c:	8552                	mv	a0,s4
    5d4e:	9ffff0ef          	jal	574c <sbrk>
  if (p == SBRK_ERROR)
    5d52:	fd551ee3          	bne	a0,s5,5d2e <malloc+0x7c>
        return 0;
    5d56:	4501                	li	a0,0
    5d58:	74a2                	ld	s1,40(sp)
    5d5a:	6a42                	ld	s4,16(sp)
    5d5c:	6aa2                	ld	s5,8(sp)
    5d5e:	6b02                	ld	s6,0(sp)
    5d60:	a03d                	j	5d8e <malloc+0xdc>
    5d62:	74a2                	ld	s1,40(sp)
    5d64:	6a42                	ld	s4,16(sp)
    5d66:	6aa2                	ld	s5,8(sp)
    5d68:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
    5d6a:	fae90fe3          	beq	s2,a4,5d28 <malloc+0x76>
        p->s.size -= nunits;
    5d6e:	4137073b          	subw	a4,a4,s3
    5d72:	c798                	sw	a4,8(a5)
        p += p->s.size;
    5d74:	02071693          	slli	a3,a4,0x20
    5d78:	01c6d713          	srli	a4,a3,0x1c
    5d7c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    5d7e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    5d82:	00003717          	auipc	a4,0x3
    5d86:	74a73723          	sd	a0,1870(a4) # 94d0 <freep>
      return (void *)(p + 1);
    5d8a:	01078513          	addi	a0,a5,16
  }
}
    5d8e:	70e2                	ld	ra,56(sp)
    5d90:	7442                	ld	s0,48(sp)
    5d92:	7902                	ld	s2,32(sp)
    5d94:	69e2                	ld	s3,24(sp)
    5d96:	6121                	addi	sp,sp,64
    5d98:	8082                	ret
    5d9a:	74a2                	ld	s1,40(sp)
    5d9c:	6a42                	ld	s4,16(sp)
    5d9e:	6aa2                	ld	s5,8(sp)
    5da0:	6b02                	ld	s6,0(sp)
    5da2:	b7f5                	j	5d8e <malloc+0xdc>
