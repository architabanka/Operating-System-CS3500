
user/_trunctest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/fs_test.h"
int
main(void)
{
       0:	7135                	addi	sp,sp,-160
       2:	ed06                	sd	ra,152(sp)
       4:	e922                	sd	s0,144(sp)
       6:	e14a                	sd	s2,128(sp)
       8:	f4d6                	sd	s5,104(sp)
       a:	f0da                	sd	s6,96(sp)
       c:	ecde                	sd	s7,88(sp)
       e:	fc6e                	sd	s11,56(sp)
      10:	1100                	addi	s0,sp,160
      12:	03a00a93          	li	s5,58
  for (int i = 0; i < 4; i++) {
      16:	4b01                	li	s6,0
  unlink(name);
  int fd = open(name, O_CREATE | O_WRONLY | O_TRUNC);
  check(fd >= 0, "create test file");
  for (uint first = 0; first < blocks;) {
    uint n = blocks - first;
    if (n > 8)
      18:	4ba1                	li	s7,8
      n = 8;
    for (uint b = 0; b < n; b++)
      for (uint j = 0; j < BSIZE; j++)
      1a:	40000913          	li	s2,1024
  unlink(name);
      1e:	00001517          	auipc	a0,0x1
      22:	0b250513          	addi	a0,a0,178 # 10d0 <malloc+0xf6>
      26:	2d3000ef          	jal	af8 <unlink>
  int fd = open(name, O_CREATE | O_WRONLY | O_TRUNC);
      2a:	60100593          	li	a1,1537
      2e:	00001517          	auipc	a0,0x1
      32:	0a250513          	addi	a0,a0,162 # 10d0 <malloc+0xf6>
      36:	2b3000ef          	jal	ae8 <open>
      3a:	8daa                	mv	s11,a0
  if (!ok) {
      3c:	04054163          	bltz	a0,7e <main+0x7e>
      40:	e526                	sd	s1,136(sp)
      42:	fcce                	sd	s3,120(sp)
      44:	f8d2                	sd	s4,112(sp)
      46:	e8e2                	sd	s8,80(sp)
      48:	e4e6                	sd	s9,72(sp)
      4a:	e0ea                	sd	s10,64(sp)
    makefile("fst_trunc.tmp", 525, i + 1);
      4c:	001b079b          	addiw	a5,s6,1
      50:	f6f43023          	sd	a5,-160(s0)
      54:	8b3e                	mv	s6,a5
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
      56:	fe3a8d1b          	addiw	s10,s5,-29
      5a:	0ffd7d13          	zext.b	s10,s10
  for (uint first = 0; first < blocks;) {
      5e:	4c01                	li	s8,0
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
      60:	00002497          	auipc	s1,0x2
      64:	fb048493          	addi	s1,s1,-80 # 2010 <fs_buffer>
  if (byte == 4)
      68:	4991                	li	s3,4
      6a:	0ff7fa13          	zext.b	s4,a5
      6e:	a0f1                	j	13a <main+0x13a>
      70:	64aa                	ld	s1,136(sp)
      72:	79e6                	ld	s3,120(sp)
      74:	7a46                	ld	s4,112(sp)
      76:	6c46                	ld	s8,80(sp)
      78:	6ca6                	ld	s9,72(sp)
      7a:	6d06                	ld	s10,64(sp)
      7c:	b74d                	j	1e <main+0x1e>
      7e:	e526                	sd	s1,136(sp)
      80:	fcce                	sd	s3,120(sp)
      82:	f8d2                	sd	s4,112(sp)
      84:	e8e2                	sd	s8,80(sp)
      86:	e4e6                	sd	s9,72(sp)
      88:	e0ea                	sd	s10,64(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
      8a:	00001617          	auipc	a2,0x1
      8e:	05e60613          	addi	a2,a2,94 # 10e8 <malloc+0x10e>
      92:	00001597          	auipc	a1,0x1
      96:	06e58593          	addi	a1,a1,110 # 1100 <malloc+0x126>
      9a:	4509                	li	a0,2
      9c:	659000ef          	jal	ef4 <fprintf>
    exit(1);
      a0:	4505                	li	a0,1
      a2:	207000ef          	jal	aa8 <exit>
      for (uint j = 0; j < BSIZE; j++)
      a6:	26c5                	addiw	a3,a3,17
      a8:	0ff6f693          	zext.b	a3,a3
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
      ac:	00b707bb          	addw	a5,a4,a1
  if (byte < 4)
      b0:	04e57363          	bgeu	a0,a4,f6 <main+0xf6>
  if (byte == 4)
      b4:	8652                	mv	a2,s4
      b6:	05370663          	beq	a4,s3,102 <main+0x102>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
      ba:	1782                	slli	a5,a5,0x20
      bc:	9381                	srli	a5,a5,0x20
      be:	97a6                	add	a5,a5,s1
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
      c0:	0106c633          	xor	a2,a3,a6
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
      c4:	00c78023          	sb	a2,0(a5)
      for (uint j = 0; j < BSIZE; j++)
      c8:	2705                	addiw	a4,a4,1
      ca:	fd271ee3          	bne	a4,s2,a6 <main+0xa6>
    for (uint b = 0; b < n; b++)
      ce:	2e05                	addiw	t3,t3,1
      d0:	f833031b          	addiw	t1,t1,-125
      d4:	0ff37313          	zext.b	t1,t1
      d8:	4005859b          	addiw	a1,a1,1024
      dc:	039e7d63          	bgeu	t3,s9,116 <main+0x116>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
      e0:	01cc08bb          	addw	a7,s8,t3
      e4:	006d4833          	xor	a6,s10,t1
      e8:	4681                	li	a3,0
      for (uint j = 0; j < BSIZE; j++)
      ea:	4701                	li	a4,0
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
      ec:	0088d79b          	srliw	a5,a7,0x8
      f0:	00f84833          	xor	a6,a6,a5
      f4:	bf65                	j	ac <main+0xac>
    return (block >> (8 * byte)) & 255;
      f6:	0037161b          	slliw	a2,a4,0x3
      fa:	00c8d63b          	srlw	a2,a7,a2
      fe:	0ff67613          	zext.b	a2,a2
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     102:	1782                	slli	a5,a5,0x20
     104:	9381                	srli	a5,a5,0x20
     106:	97a6                	add	a5,a5,s1
     108:	00c78023          	sb	a2,0(a5)
      for (uint j = 0; j < BSIZE; j++)
     10c:	2705                	addiw	a4,a4,1
     10e:	26c5                	addiw	a3,a3,17
     110:	0ff6f693          	zext.b	a3,a3
     114:	bf61                	j	ac <main+0xac>
    check(write(fd, fs_buffer, n * BSIZE) == n * BSIZE, "write full test data");
     116:	00ac961b          	slliw	a2,s9,0xa
     11a:	f6c43423          	sd	a2,-152(s0)
     11e:	85a6                	mv	a1,s1
     120:	856e                	mv	a0,s11
     122:	1a7000ef          	jal	ac8 <write>
  if (!ok) {
     126:	f6843783          	ld	a5,-152(s0)
     12a:	02a79f63          	bne	a5,a0,168 <main+0x168>
    first += n;
     12e:	019c0c3b          	addw	s8,s8,s9
  for (uint first = 0; first < blocks;) {
     132:	20c00793          	li	a5,524
     136:	0587e763          	bltu	a5,s8,184 <main+0x184>
    uint n = blocks - first;
     13a:	20d00793          	li	a5,525
     13e:	418787bb          	subw	a5,a5,s8
     142:	8cbe                	mv	s9,a5
    if (n > 8)
     144:	00fbf363          	bgeu	s7,a5,14a <main+0x14a>
     148:	4ca1                	li	s9,8
     14a:	2c81                	sext.w	s9,s9
    for (uint b = 0; b < n; b++)
     14c:	006c131b          	slliw	t1,s8,0x6
     150:	406c033b          	subw	t1,s8,t1
     154:	0013131b          	slliw	t1,t1,0x1
     158:	0183033b          	addw	t1,t1,s8
     15c:	0ff37313          	zext.b	t1,t1
    if (n > 8)
     160:	4581                	li	a1,0
    for (uint b = 0; b < n; b++)
     162:	4e01                	li	t3,0
  if (byte < 4)
     164:	450d                	li	a0,3
     166:	bfad                	j	e0 <main+0xe0>
    fprintf(2, "TEST FAILURE: %s\n", why);
     168:	00001617          	auipc	a2,0x1
     16c:	fb060613          	addi	a2,a2,-80 # 1118 <malloc+0x13e>
     170:	00001597          	auipc	a1,0x1
     174:	f9058593          	addi	a1,a1,-112 # 1100 <malloc+0x126>
     178:	4509                	li	a0,2
     17a:	57b000ef          	jal	ef4 <fprintf>
    exit(1);
     17e:	4505                	li	a0,1
     180:	129000ef          	jal	aa8 <exit>
  }
  check(close(fd) == 0, "close written file");
     184:	856e                	mv	a0,s11
     186:	14b000ef          	jal	ad0 <close>
  if (!ok) {
     18a:	e531                	bnez	a0,1d6 <main+0x1d6>

static inline void
verify(const char *name, uint blocks, uint seed, const struct patch *patches,
       int np)
{
  int fd = open(name, O_RDONLY);
     18c:	4581                	li	a1,0
     18e:	00001517          	auipc	a0,0x1
     192:	f4250513          	addi	a0,a0,-190 # 10d0 <malloc+0xf6>
     196:	153000ef          	jal	ae8 <open>
     19a:	8caa                	mv	s9,a0
  if (!ok) {
     19c:	04054b63          	bltz	a0,1f2 <main+0x1f2>
  check(fstat(fd, &st) == 0 && st.size == (uint64)blocks * BSIZE,
     1a0:	f7840593          	addi	a1,s0,-136
     1a4:	15d000ef          	jal	b00 <fstat>
     1a8:	e13d                	bnez	a0,20e <main+0x20e>
  if (!ok) {
     1aa:	f8843703          	ld	a4,-120(s0)
     1ae:	000837b7          	lui	a5,0x83
     1b2:	40078793          	addi	a5,a5,1024 # 83400 <base+0x7f3f0>
     1b6:	04f71c63          	bne	a4,a5,20e <main+0x20e>
     1ba:	f6044a03          	lbu	s4,-160(s0)
     1be:	4d75                	li	s10,29
     1c0:	03aa0d3b          	mulw	s10,s4,s10
     1c4:	0ffd7d13          	zext.b	s10,s10
  for (uint first = 0; first < blocks;) {
     1c8:	4c01                	li	s8,0
    check(read(fd, fs_buffer, n * BSIZE) == n * BSIZE, "read full test data");
     1ca:	00002497          	auipc	s1,0x2
     1ce:	e4648493          	addi	s1,s1,-442 # 2010 <fs_buffer>
  if (byte == 4)
     1d2:	4991                	li	s3,4
     1d4:	aa21                	j	2ec <main+0x2ec>
    fprintf(2, "TEST FAILURE: %s\n", why);
     1d6:	00001617          	auipc	a2,0x1
     1da:	f5a60613          	addi	a2,a2,-166 # 1130 <malloc+0x156>
     1de:	00001597          	auipc	a1,0x1
     1e2:	f2258593          	addi	a1,a1,-222 # 1100 <malloc+0x126>
     1e6:	4509                	li	a0,2
     1e8:	50d000ef          	jal	ef4 <fprintf>
    exit(1);
     1ec:	4505                	li	a0,1
     1ee:	0bb000ef          	jal	aa8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     1f2:	00001617          	auipc	a2,0x1
     1f6:	f5660613          	addi	a2,a2,-170 # 1148 <malloc+0x16e>
     1fa:	00001597          	auipc	a1,0x1
     1fe:	f0658593          	addi	a1,a1,-250 # 1100 <malloc+0x126>
     202:	4509                	li	a0,2
     204:	4f1000ef          	jal	ef4 <fprintf>
    exit(1);
     208:	4505                	li	a0,1
     20a:	09f000ef          	jal	aa8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     20e:	00001617          	auipc	a2,0x1
     212:	f5260613          	addi	a2,a2,-174 # 1160 <malloc+0x186>
     216:	00001597          	auipc	a1,0x1
     21a:	eea58593          	addi	a1,a1,-278 # 1100 <malloc+0x126>
     21e:	4509                	li	a0,2
     220:	4d5000ef          	jal	ef4 <fprintf>
    exit(1);
     224:	4505                	li	a0,1
     226:	083000ef          	jal	aa8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     22a:	00001617          	auipc	a2,0x1
     22e:	f4660613          	addi	a2,a2,-186 # 1170 <malloc+0x196>
     232:	00001597          	auipc	a1,0x1
     236:	ece58593          	addi	a1,a1,-306 # 1100 <malloc+0x126>
     23a:	4509                	li	a0,2
     23c:	4b9000ef          	jal	ef4 <fprintf>
    exit(1);
     240:	4505                	li	a0,1
     242:	067000ef          	jal	aa8 <exit>
      for (uint j = 0; j < BSIZE; j++) {
     246:	2745                	addiw	a4,a4,17
     248:	0ff77713          	zext.b	a4,a4
  if (byte < 4)
     24c:	04f57863          	bgeu	a0,a5,29c <main+0x29c>
  if (byte == 4)
     250:	59378f63          	beq	a5,s3,7ee <main+0x7ee>
        check((uchar)fs_buffer[b * BSIZE + j] == want, "file contents differ");
     254:	00b7863b          	addw	a2,a5,a1
     258:	1602                	slli	a2,a2,0x20
     25a:	9201                	srli	a2,a2,0x20
     25c:	9626                	add	a2,a2,s1
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
     25e:	010746b3          	xor	a3,a4,a6
  if (!ok) {
     262:	00064603          	lbu	a2,0(a2)
     266:	0ff6f693          	zext.b	a3,a3
     26a:	04d61d63          	bne	a2,a3,2c4 <main+0x2c4>
      for (uint j = 0; j < BSIZE; j++) {
     26e:	2785                	addiw	a5,a5,1
     270:	fd279be3          	bne	a5,s2,246 <main+0x246>
    for (uint b = 0; b < n; b++) {
     274:	2e05                	addiw	t3,t3,1
     276:	f833031b          	addiw	t1,t1,-125
     27a:	0ff37313          	zext.b	t1,t1
     27e:	4005859b          	addiw	a1,a1,1024
     282:	05be7f63          	bgeu	t3,s11,2e0 <main+0x2e0>
        uint off = (first + b) * BSIZE + j;
     286:	018e08bb          	addw	a7,t3,s8
     28a:	01a34833          	xor	a6,t1,s10
     28e:	4701                	li	a4,0
      for (uint j = 0; j < BSIZE; j++) {
     290:	4781                	li	a5,0
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
     292:	0088d69b          	srliw	a3,a7,0x8
     296:	00d84833          	xor	a6,a6,a3
     29a:	bf4d                	j	24c <main+0x24c>
    return (block >> (8 * byte)) & 255;
     29c:	0037961b          	slliw	a2,a5,0x3
     2a0:	00c8d63b          	srlw	a2,a7,a2
     2a4:	0ff67613          	zext.b	a2,a2
        check((uchar)fs_buffer[b * BSIZE + j] == want, "file contents differ");
     2a8:	00b786bb          	addw	a3,a5,a1
     2ac:	1682                	slli	a3,a3,0x20
     2ae:	9281                	srli	a3,a3,0x20
     2b0:	96a6                	add	a3,a3,s1
  if (!ok) {
     2b2:	0006c683          	lbu	a3,0(a3)
     2b6:	00c69763          	bne	a3,a2,2c4 <main+0x2c4>
      for (uint j = 0; j < BSIZE; j++) {
     2ba:	2785                	addiw	a5,a5,1
     2bc:	2745                	addiw	a4,a4,17
     2be:	0ff77713          	zext.b	a4,a4
     2c2:	b769                	j	24c <main+0x24c>
    fprintf(2, "TEST FAILURE: %s\n", why);
     2c4:	00001617          	auipc	a2,0x1
     2c8:	ec460613          	addi	a2,a2,-316 # 1188 <malloc+0x1ae>
     2cc:	00001597          	auipc	a1,0x1
     2d0:	e3458593          	addi	a1,a1,-460 # 1100 <malloc+0x126>
     2d4:	4509                	li	a0,2
     2d6:	41f000ef          	jal	ef4 <fprintf>
    exit(1);
     2da:	4505                	li	a0,1
     2dc:	7cc000ef          	jal	aa8 <exit>
    first += n;
     2e0:	01bc0c3b          	addw	s8,s8,s11
  for (uint first = 0; first < blocks;) {
     2e4:	20c00793          	li	a5,524
     2e8:	0587e663          	bltu	a5,s8,334 <main+0x334>
    uint n = blocks - first;
     2ec:	20d00793          	li	a5,525
     2f0:	4187873b          	subw	a4,a5,s8
     2f4:	87ba                	mv	a5,a4
    if (n > 8)
     2f6:	00ebf363          	bgeu	s7,a4,2fc <main+0x2fc>
     2fa:	47a1                	li	a5,8
     2fc:	00078d9b          	sext.w	s11,a5
    check(read(fd, fs_buffer, n * BSIZE) == n * BSIZE, "read full test data");
     300:	00a7961b          	slliw	a2,a5,0xa
     304:	f6c43423          	sd	a2,-152(s0)
     308:	85a6                	mv	a1,s1
     30a:	8566                	mv	a0,s9
     30c:	7b4000ef          	jal	ac0 <read>
  if (!ok) {
     310:	f6843783          	ld	a5,-152(s0)
     314:	f0a79be3          	bne	a5,a0,22a <main+0x22a>
     318:	006c131b          	slliw	t1,s8,0x6
     31c:	406c033b          	subw	t1,s8,t1
     320:	0013131b          	slliw	t1,t1,0x1
     324:	0183033b          	addw	t1,t1,s8
     328:	0ff37313          	zext.b	t1,t1
     32c:	4581                	li	a1,0
    for (uint b = 0; b < n; b++) {
     32e:	4e01                	li	t3,0
  if (byte < 4)
     330:	450d                	li	a0,3
     332:	bf91                	j	286 <main+0x286>
  check(read(fd, fs_buffer, 1) == 0, "EOF after exact file size");
     334:	4605                	li	a2,1
     336:	00002597          	auipc	a1,0x2
     33a:	cda58593          	addi	a1,a1,-806 # 2010 <fs_buffer>
     33e:	8566                	mv	a0,s9
     340:	780000ef          	jal	ac0 <read>
  if (!ok) {
     344:	e155                	bnez	a0,3e8 <main+0x3e8>
  check(fd >= 0, "open for verification");
  verifyfd(fd, blocks, seed, patches, np);
  check(close(fd) == 0, "close verified file");
     346:	8566                	mv	a0,s9
     348:	788000ef          	jal	ad0 <close>
  if (!ok) {
     34c:	ed45                	bnez	a0,404 <main+0x404>
    verify("fst_trunc.tmp", 525, i + 1, 0, 0);
    int fd = open("fst_trunc.tmp", O_WRONLY | O_TRUNC);
     34e:	40100593          	li	a1,1025
     352:	00001517          	auipc	a0,0x1
     356:	d7e50513          	addi	a0,a0,-642 # 10d0 <malloc+0xf6>
     35a:	78e000ef          	jal	ae8 <open>
     35e:	0c054163          	bltz	a0,420 <main+0x420>
    check(fd >= 0, "truncate existing file");
    check(close(fd) == 0, "close truncated file");
     362:	76e000ef          	jal	ad0 <close>
     366:	0c051b63          	bnez	a0,43c <main+0x43c>
  int fd = open(name, O_RDONLY);
     36a:	4581                	li	a1,0
     36c:	00001517          	auipc	a0,0x1
     370:	d6450513          	addi	a0,a0,-668 # 10d0 <malloc+0xf6>
     374:	774000ef          	jal	ae8 <open>
     378:	84aa                	mv	s1,a0
  if (!ok) {
     37a:	0c054f63          	bltz	a0,458 <main+0x458>
  check(fstat(fd, &st) == 0 && st.size == (uint64)blocks * BSIZE,
     37e:	f7840593          	addi	a1,s0,-136
     382:	77e000ef          	jal	b00 <fstat>
     386:	0e051763          	bnez	a0,474 <main+0x474>
  if (!ok) {
     38a:	f8843783          	ld	a5,-120(s0)
     38e:	0e079363          	bnez	a5,474 <main+0x474>
  check(read(fd, fs_buffer, 1) == 0, "EOF after exact file size");
     392:	4605                	li	a2,1
     394:	00002597          	auipc	a1,0x2
     398:	c7c58593          	addi	a1,a1,-900 # 2010 <fs_buffer>
     39c:	8526                	mv	a0,s1
     39e:	722000ef          	jal	ac0 <read>
  if (!ok) {
     3a2:	0e051763          	bnez	a0,490 <main+0x490>
  check(close(fd) == 0, "close verified file");
     3a6:	8526                	mv	a0,s1
     3a8:	728000ef          	jal	ad0 <close>
  if (!ok) {
     3ac:	10051063          	bnez	a0,4ac <main+0x4ac>
  unlink(name);
     3b0:	00001517          	auipc	a0,0x1
     3b4:	d2050513          	addi	a0,a0,-736 # 10d0 <malloc+0xf6>
     3b8:	740000ef          	jal	af8 <unlink>
  int fd = open(name, O_CREATE | O_WRONLY | O_TRUNC);
     3bc:	60100593          	li	a1,1537
     3c0:	00001517          	auipc	a0,0x1
     3c4:	d1050513          	addi	a0,a0,-752 # 10d0 <malloc+0xf6>
     3c8:	720000ef          	jal	ae8 <open>
     3cc:	8daa                	mv	s11,a0
  if (!ok) {
     3ce:	0e054d63          	bltz	a0,4c8 <main+0x4c8>
  for (uint first = 0; first < blocks;) {
     3d2:	4c81                	li	s9,0
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     3d4:	00002497          	auipc	s1,0x2
     3d8:	c3c48493          	addi	s1,s1,-964 # 2010 <fs_buffer>
  if (byte == 4)
     3dc:	4991                	li	s3,4
     3de:	001a0c1b          	addiw	s8,s4,1
     3e2:	0ffc7c13          	zext.b	s8,s8
     3e6:	aa49                	j	578 <main+0x578>
    fprintf(2, "TEST FAILURE: %s\n", why);
     3e8:	00001617          	auipc	a2,0x1
     3ec:	db860613          	addi	a2,a2,-584 # 11a0 <malloc+0x1c6>
     3f0:	00001597          	auipc	a1,0x1
     3f4:	d1058593          	addi	a1,a1,-752 # 1100 <malloc+0x126>
     3f8:	4509                	li	a0,2
     3fa:	2fb000ef          	jal	ef4 <fprintf>
    exit(1);
     3fe:	4505                	li	a0,1
     400:	6a8000ef          	jal	aa8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     404:	00001617          	auipc	a2,0x1
     408:	dbc60613          	addi	a2,a2,-580 # 11c0 <malloc+0x1e6>
     40c:	00001597          	auipc	a1,0x1
     410:	cf458593          	addi	a1,a1,-780 # 1100 <malloc+0x126>
     414:	4509                	li	a0,2
     416:	2df000ef          	jal	ef4 <fprintf>
    exit(1);
     41a:	4505                	li	a0,1
     41c:	68c000ef          	jal	aa8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     420:	00001617          	auipc	a2,0x1
     424:	db860613          	addi	a2,a2,-584 # 11d8 <malloc+0x1fe>
     428:	00001597          	auipc	a1,0x1
     42c:	cd858593          	addi	a1,a1,-808 # 1100 <malloc+0x126>
     430:	4509                	li	a0,2
     432:	2c3000ef          	jal	ef4 <fprintf>
    exit(1);
     436:	4505                	li	a0,1
     438:	670000ef          	jal	aa8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     43c:	00001617          	auipc	a2,0x1
     440:	db460613          	addi	a2,a2,-588 # 11f0 <malloc+0x216>
     444:	00001597          	auipc	a1,0x1
     448:	cbc58593          	addi	a1,a1,-836 # 1100 <malloc+0x126>
     44c:	4509                	li	a0,2
     44e:	2a7000ef          	jal	ef4 <fprintf>
    exit(1);
     452:	4505                	li	a0,1
     454:	654000ef          	jal	aa8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     458:	00001617          	auipc	a2,0x1
     45c:	cf060613          	addi	a2,a2,-784 # 1148 <malloc+0x16e>
     460:	00001597          	auipc	a1,0x1
     464:	ca058593          	addi	a1,a1,-864 # 1100 <malloc+0x126>
     468:	4509                	li	a0,2
     46a:	28b000ef          	jal	ef4 <fprintf>
    exit(1);
     46e:	4505                	li	a0,1
     470:	638000ef          	jal	aa8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     474:	00001617          	auipc	a2,0x1
     478:	cec60613          	addi	a2,a2,-788 # 1160 <malloc+0x186>
     47c:	00001597          	auipc	a1,0x1
     480:	c8458593          	addi	a1,a1,-892 # 1100 <malloc+0x126>
     484:	4509                	li	a0,2
     486:	26f000ef          	jal	ef4 <fprintf>
    exit(1);
     48a:	4505                	li	a0,1
     48c:	61c000ef          	jal	aa8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     490:	00001617          	auipc	a2,0x1
     494:	d1060613          	addi	a2,a2,-752 # 11a0 <malloc+0x1c6>
     498:	00001597          	auipc	a1,0x1
     49c:	c6858593          	addi	a1,a1,-920 # 1100 <malloc+0x126>
     4a0:	4509                	li	a0,2
     4a2:	253000ef          	jal	ef4 <fprintf>
    exit(1);
     4a6:	4505                	li	a0,1
     4a8:	600000ef          	jal	aa8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     4ac:	00001617          	auipc	a2,0x1
     4b0:	d1460613          	addi	a2,a2,-748 # 11c0 <malloc+0x1e6>
     4b4:	00001597          	auipc	a1,0x1
     4b8:	c4c58593          	addi	a1,a1,-948 # 1100 <malloc+0x126>
     4bc:	4509                	li	a0,2
     4be:	237000ef          	jal	ef4 <fprintf>
    exit(1);
     4c2:	4505                	li	a0,1
     4c4:	5e4000ef          	jal	aa8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     4c8:	00001617          	auipc	a2,0x1
     4cc:	c2060613          	addi	a2,a2,-992 # 10e8 <malloc+0x10e>
     4d0:	00001597          	auipc	a1,0x1
     4d4:	c3058593          	addi	a1,a1,-976 # 1100 <malloc+0x126>
     4d8:	4509                	li	a0,2
     4da:	21b000ef          	jal	ef4 <fprintf>
    exit(1);
     4de:	4505                	li	a0,1
     4e0:	5c8000ef          	jal	aa8 <exit>
    return (block >> (8 * byte)) & 255;
     4e4:	0037161b          	slliw	a2,a4,0x3
     4e8:	00c8d63b          	srlw	a2,a7,a2
     4ec:	0ff67613          	zext.b	a2,a2
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     4f0:	1782                	slli	a5,a5,0x20
     4f2:	9381                	srli	a5,a5,0x20
     4f4:	97a6                	add	a5,a5,s1
     4f6:	00c78023          	sb	a2,0(a5)
      for (uint j = 0; j < BSIZE; j++)
     4fa:	2705                	addiw	a4,a4,1
     4fc:	26c5                	addiw	a3,a3,17
     4fe:	0ff6f693          	zext.b	a3,a3
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     502:	00b707bb          	addw	a5,a4,a1
  if (byte < 4)
     506:	fce57fe3          	bgeu	a0,a4,4e4 <main+0x4e4>
  if (byte == 4)
     50a:	8662                	mv	a2,s8
     50c:	ff3702e3          	beq	a4,s3,4f0 <main+0x4f0>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     510:	1782                	slli	a5,a5,0x20
     512:	9381                	srli	a5,a5,0x20
     514:	97a6                	add	a5,a5,s1
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
     516:	0106c633          	xor	a2,a3,a6
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     51a:	00c78023          	sb	a2,0(a5)
      for (uint j = 0; j < BSIZE; j++)
     51e:	2705                	addiw	a4,a4,1
     520:	01270663          	beq	a4,s2,52c <main+0x52c>
     524:	26c5                	addiw	a3,a3,17
     526:	0ff6f693          	zext.b	a3,a3
     52a:	bfe1                	j	502 <main+0x502>
    for (uint b = 0; b < n; b++)
     52c:	2e05                	addiw	t3,t3,1
     52e:	f833031b          	addiw	t1,t1,-125
     532:	0ff37313          	zext.b	t1,t1
     536:	4005859b          	addiw	a1,a1,1024
     53a:	01ae7d63          	bgeu	t3,s10,554 <main+0x554>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     53e:	019e08bb          	addw	a7,t3,s9
     542:	006ac833          	xor	a6,s5,t1
     546:	4681                	li	a3,0
      for (uint j = 0; j < BSIZE; j++)
     548:	4701                	li	a4,0
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
     54a:	0088d79b          	srliw	a5,a7,0x8
     54e:	00f84833          	xor	a6,a6,a5
     552:	bf45                	j	502 <main+0x502>
    check(write(fd, fs_buffer, n * BSIZE) == n * BSIZE, "write full test data");
     554:	00ad161b          	slliw	a2,s10,0xa
     558:	f6c43423          	sd	a2,-152(s0)
     55c:	85a6                	mv	a1,s1
     55e:	856e                	mv	a0,s11
     560:	568000ef          	jal	ac8 <write>
  if (!ok) {
     564:	f6843783          	ld	a5,-152(s0)
     568:	02a79f63          	bne	a5,a0,5a6 <main+0x5a6>
    first += n;
     56c:	019d0cbb          	addw	s9,s10,s9
  for (uint first = 0; first < blocks;) {
     570:	20c00793          	li	a5,524
     574:	0597e763          	bltu	a5,s9,5c2 <main+0x5c2>
    uint n = blocks - first;
     578:	20d00793          	li	a5,525
     57c:	419787bb          	subw	a5,a5,s9
     580:	8d3e                	mv	s10,a5
    if (n > 8)
     582:	00fbf363          	bgeu	s7,a5,588 <main+0x588>
     586:	4d21                	li	s10,8
     588:	2d01                	sext.w	s10,s10
    for (uint b = 0; b < n; b++)
     58a:	006c931b          	slliw	t1,s9,0x6
     58e:	406c833b          	subw	t1,s9,t1
     592:	0013131b          	slliw	t1,t1,0x1
     596:	0193033b          	addw	t1,t1,s9
     59a:	0ff37313          	zext.b	t1,t1
    if (n > 8)
     59e:	4581                	li	a1,0
    for (uint b = 0; b < n; b++)
     5a0:	4e01                	li	t3,0
  if (byte < 4)
     5a2:	450d                	li	a0,3
     5a4:	bf69                	j	53e <main+0x53e>
    fprintf(2, "TEST FAILURE: %s\n", why);
     5a6:	00001617          	auipc	a2,0x1
     5aa:	b7260613          	addi	a2,a2,-1166 # 1118 <malloc+0x13e>
     5ae:	00001597          	auipc	a1,0x1
     5b2:	b5258593          	addi	a1,a1,-1198 # 1100 <malloc+0x126>
     5b6:	4509                	li	a0,2
     5b8:	13d000ef          	jal	ef4 <fprintf>
    exit(1);
     5bc:	4505                	li	a0,1
     5be:	4ea000ef          	jal	aa8 <exit>
  check(close(fd) == 0, "close written file");
     5c2:	856e                	mv	a0,s11
     5c4:	50c000ef          	jal	ad0 <close>
  if (!ok) {
     5c8:	e90d                	bnez	a0,5fa <main+0x5fa>
    verify("fst_trunc.tmp", 0, i + 1, 0, 0);
    makefile("fst_trunc.tmp", 525, i + 2);
    fd = open("fst_trunc.tmp", O_RDONLY);
     5ca:	4581                	li	a1,0
     5cc:	00001517          	auipc	a0,0x1
     5d0:	b0450513          	addi	a0,a0,-1276 # 10d0 <malloc+0xf6>
     5d4:	514000ef          	jal	ae8 <open>
     5d8:	8caa                	mv	s9,a0
    check(fd >= 0 && unlink("fst_trunc.tmp") == 0, "unlink open file");
     5da:	02055e63          	bgez	a0,616 <main+0x616>
    fprintf(2, "TEST FAILURE: %s\n", why);
     5de:	00001617          	auipc	a2,0x1
     5e2:	c2a60613          	addi	a2,a2,-982 # 1208 <malloc+0x22e>
     5e6:	00001597          	auipc	a1,0x1
     5ea:	b1a58593          	addi	a1,a1,-1254 # 1100 <malloc+0x126>
     5ee:	4509                	li	a0,2
     5f0:	105000ef          	jal	ef4 <fprintf>
    exit(1);
     5f4:	4505                	li	a0,1
     5f6:	4b2000ef          	jal	aa8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     5fa:	00001617          	auipc	a2,0x1
     5fe:	b3660613          	addi	a2,a2,-1226 # 1130 <malloc+0x156>
     602:	00001597          	auipc	a1,0x1
     606:	afe58593          	addi	a1,a1,-1282 # 1100 <malloc+0x126>
     60a:	4509                	li	a0,2
     60c:	0e9000ef          	jal	ef4 <fprintf>
    exit(1);
     610:	4505                	li	a0,1
     612:	496000ef          	jal	aa8 <exit>
     616:	00001517          	auipc	a0,0x1
     61a:	aba50513          	addi	a0,a0,-1350 # 10d0 <malloc+0xf6>
     61e:	4da000ef          	jal	af8 <unlink>
  if (!ok) {
     622:	fd55                	bnez	a0,5de <main+0x5de>
  check(fstat(fd, &st) == 0 && st.size == (uint64)blocks * BSIZE,
     624:	f7840593          	addi	a1,s0,-136
     628:	8566                	mv	a0,s9
     62a:	4d6000ef          	jal	b00 <fstat>
     62e:	e11d                	bnez	a0,654 <main+0x654>
  if (!ok) {
     630:	f8843703          	ld	a4,-120(s0)
     634:	000837b7          	lui	a5,0x83
     638:	40078793          	addi	a5,a5,1024 # 83400 <base+0x7f3f0>
     63c:	00f71c63          	bne	a4,a5,654 <main+0x654>
  for (uint first = 0; first < blocks;) {
     640:	4c01                	li	s8,0
    check(read(fd, fs_buffer, n * BSIZE) == n * BSIZE, "read full test data");
     642:	00002497          	auipc	s1,0x2
     646:	9ce48493          	addi	s1,s1,-1586 # 2010 <fs_buffer>
     64a:	001a099b          	addiw	s3,s4,1
     64e:	0ff9f993          	zext.b	s3,s3
     652:	a0cd                	j	734 <main+0x734>
    fprintf(2, "TEST FAILURE: %s\n", why);
     654:	00001617          	auipc	a2,0x1
     658:	b0c60613          	addi	a2,a2,-1268 # 1160 <malloc+0x186>
     65c:	00001597          	auipc	a1,0x1
     660:	aa458593          	addi	a1,a1,-1372 # 1100 <malloc+0x126>
     664:	4509                	li	a0,2
     666:	08f000ef          	jal	ef4 <fprintf>
    exit(1);
     66a:	4505                	li	a0,1
     66c:	43c000ef          	jal	aa8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     670:	00001617          	auipc	a2,0x1
     674:	b0060613          	addi	a2,a2,-1280 # 1170 <malloc+0x196>
     678:	00001597          	auipc	a1,0x1
     67c:	a8858593          	addi	a1,a1,-1400 # 1100 <malloc+0x126>
     680:	4509                	li	a0,2
     682:	073000ef          	jal	ef4 <fprintf>
    exit(1);
     686:	4505                	li	a0,1
     688:	420000ef          	jal	aa8 <exit>
    return (block >> (8 * byte)) & 255;
     68c:	0037961b          	slliw	a2,a5,0x3
     690:	00ce563b          	srlw	a2,t3,a2
     694:	0ff67613          	zext.b	a2,a2
        check((uchar)fs_buffer[b * BSIZE + j] == want, "file contents differ");
     698:	00b786bb          	addw	a3,a5,a1
     69c:	1682                	slli	a3,a3,0x20
     69e:	9281                	srli	a3,a3,0x20
     6a0:	96a6                	add	a3,a3,s1
  if (!ok) {
     6a2:	0006c683          	lbu	a3,0(a3)
     6a6:	02c69f63          	bne	a3,a2,6e4 <main+0x6e4>
      for (uint j = 0; j < BSIZE; j++) {
     6aa:	2785                	addiw	a5,a5,1
     6ac:	2745                	addiw	a4,a4,17
     6ae:	0ff77713          	zext.b	a4,a4
  if (byte < 4)
     6b2:	fcf57de3          	bgeu	a0,a5,68c <main+0x68c>
  if (byte == 4)
     6b6:	864e                	mv	a2,s3
     6b8:	ff0780e3          	beq	a5,a6,698 <main+0x698>
        check((uchar)fs_buffer[b * BSIZE + j] == want, "file contents differ");
     6bc:	00b7863b          	addw	a2,a5,a1
     6c0:	1602                	slli	a2,a2,0x20
     6c2:	9201                	srli	a2,a2,0x20
     6c4:	9626                	add	a2,a2,s1
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
     6c6:	011746b3          	xor	a3,a4,a7
  if (!ok) {
     6ca:	00064603          	lbu	a2,0(a2)
     6ce:	0ff6f693          	zext.b	a3,a3
     6d2:	00d61963          	bne	a2,a3,6e4 <main+0x6e4>
      for (uint j = 0; j < BSIZE; j++) {
     6d6:	2785                	addiw	a5,a5,1
     6d8:	02678463          	beq	a5,t1,700 <main+0x700>
     6dc:	2745                	addiw	a4,a4,17
     6de:	0ff77713          	zext.b	a4,a4
     6e2:	bfc1                	j	6b2 <main+0x6b2>
    fprintf(2, "TEST FAILURE: %s\n", why);
     6e4:	00001617          	auipc	a2,0x1
     6e8:	aa460613          	addi	a2,a2,-1372 # 1188 <malloc+0x1ae>
     6ec:	00001597          	auipc	a1,0x1
     6f0:	a1458593          	addi	a1,a1,-1516 # 1100 <malloc+0x126>
     6f4:	4509                	li	a0,2
     6f6:	7fe000ef          	jal	ef4 <fprintf>
    exit(1);
     6fa:	4505                	li	a0,1
     6fc:	3ac000ef          	jal	aa8 <exit>
    for (uint b = 0; b < n; b++) {
     700:	2f05                	addiw	t5,t5,1
     702:	f83e8e9b          	addiw	t4,t4,-125
     706:	0ffefe93          	zext.b	t4,t4
     70a:	4005859b          	addiw	a1,a1,1024
     70e:	014f7d63          	bgeu	t5,s4,728 <main+0x728>
        uint off = (first + b) * BSIZE + j;
     712:	018f0e3b          	addw	t3,t5,s8
     716:	015ec8b3          	xor	a7,t4,s5
     71a:	4701                	li	a4,0
      for (uint j = 0; j < BSIZE; j++) {
     71c:	4781                	li	a5,0
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
     71e:	008e569b          	srliw	a3,t3,0x8
     722:	00d8c8b3          	xor	a7,a7,a3
     726:	b771                	j	6b2 <main+0x6b2>
    first += n;
     728:	014c0c3b          	addw	s8,s8,s4
  for (uint first = 0; first < blocks;) {
     72c:	20c00793          	li	a5,524
     730:	0587e763          	bltu	a5,s8,77e <main+0x77e>
    uint n = blocks - first;
     734:	20d00713          	li	a4,525
     738:	4187073b          	subw	a4,a4,s8
     73c:	87ba                	mv	a5,a4
    if (n > 8)
     73e:	46a1                	li	a3,8
     740:	00e6f363          	bgeu	a3,a4,746 <main+0x746>
     744:	47a1                	li	a5,8
     746:	00078a1b          	sext.w	s4,a5
    check(read(fd, fs_buffer, n * BSIZE) == n * BSIZE, "read full test data");
     74a:	00a7961b          	slliw	a2,a5,0xa
     74e:	8d32                	mv	s10,a2
     750:	85a6                	mv	a1,s1
     752:	8566                	mv	a0,s9
     754:	36c000ef          	jal	ac0 <read>
  if (!ok) {
     758:	f0ad1ce3          	bne	s10,a0,670 <main+0x670>
     75c:	006c1e9b          	slliw	t4,s8,0x6
     760:	41dc0ebb          	subw	t4,s8,t4
     764:	001e9e9b          	slliw	t4,t4,0x1
     768:	018e8ebb          	addw	t4,t4,s8
     76c:	0ffefe93          	zext.b	t4,t4
     770:	4581                	li	a1,0
    for (uint b = 0; b < n; b++) {
     772:	4f01                	li	t5,0
  if (byte < 4)
     774:	450d                	li	a0,3
  if (byte == 4)
     776:	4811                	li	a6,4
      for (uint j = 0; j < BSIZE; j++) {
     778:	40000313          	li	t1,1024
     77c:	bf59                	j	712 <main+0x712>
  check(read(fd, fs_buffer, 1) == 0, "EOF after exact file size");
     77e:	4605                	li	a2,1
     780:	00002597          	auipc	a1,0x2
     784:	89058593          	addi	a1,a1,-1904 # 2010 <fs_buffer>
     788:	8566                	mv	a0,s9
     78a:	336000ef          	jal	ac0 <read>
  if (!ok) {
     78e:	e505                	bnez	a0,7b6 <main+0x7b6>
    verifyfd(fd, 525, i + 2, 0, 0);
    check(close(fd) == 0, "last close reclaims unlinked file");
     790:	8566                	mv	a0,s9
     792:	33e000ef          	jal	ad0 <close>
     796:	ed15                	bnez	a0,7d2 <main+0x7d2>
  for (int i = 0; i < 4; i++) {
     798:	2af5                	addiw	s5,s5,29
     79a:	0ffafa93          	zext.b	s5,s5
     79e:	4791                	li	a5,4
     7a0:	8cfb18e3          	bne	s6,a5,70 <main+0x70>
  }
  printf("trunctest: passed\n");
     7a4:	00001517          	auipc	a0,0x1
     7a8:	aa450513          	addi	a0,a0,-1372 # 1248 <malloc+0x26e>
     7ac:	772000ef          	jal	f1e <printf>
  exit(0);
     7b0:	4501                	li	a0,0
     7b2:	2f6000ef          	jal	aa8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     7b6:	00001617          	auipc	a2,0x1
     7ba:	9ea60613          	addi	a2,a2,-1558 # 11a0 <malloc+0x1c6>
     7be:	00001597          	auipc	a1,0x1
     7c2:	94258593          	addi	a1,a1,-1726 # 1100 <malloc+0x126>
     7c6:	4509                	li	a0,2
     7c8:	72c000ef          	jal	ef4 <fprintf>
    exit(1);
     7cc:	4505                	li	a0,1
     7ce:	2da000ef          	jal	aa8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     7d2:	00001617          	auipc	a2,0x1
     7d6:	a4e60613          	addi	a2,a2,-1458 # 1220 <malloc+0x246>
     7da:	00001597          	auipc	a1,0x1
     7de:	92658593          	addi	a1,a1,-1754 # 1100 <malloc+0x126>
     7e2:	4509                	li	a0,2
     7e4:	710000ef          	jal	ef4 <fprintf>
    exit(1);
     7e8:	4505                	li	a0,1
     7ea:	2be000ef          	jal	aa8 <exit>
    return seed;
     7ee:	8652                	mv	a2,s4
     7f0:	bc65                	j	2a8 <main+0x2a8>

00000000000007f2 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     7f2:	1141                	addi	sp,sp,-16
     7f4:	e406                	sd	ra,8(sp)
     7f6:	e022                	sd	s0,0(sp)
     7f8:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     7fa:	807ff0ef          	jal	0 <main>
  exit(r);
     7fe:	2aa000ef          	jal	aa8 <exit>

0000000000000802 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
     802:	1141                	addi	sp,sp,-16
     804:	e406                	sd	ra,8(sp)
     806:	e022                	sd	s0,0(sp)
     808:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
     80a:	87aa                	mv	a5,a0
     80c:	0585                	addi	a1,a1,1
     80e:	0785                	addi	a5,a5,1
     810:	fff5c703          	lbu	a4,-1(a1)
     814:	fee78fa3          	sb	a4,-1(a5)
     818:	fb75                	bnez	a4,80c <strcpy+0xa>
    ;
  return os;
}
     81a:	60a2                	ld	ra,8(sp)
     81c:	6402                	ld	s0,0(sp)
     81e:	0141                	addi	sp,sp,16
     820:	8082                	ret

0000000000000822 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     822:	1141                	addi	sp,sp,-16
     824:	e406                	sd	ra,8(sp)
     826:	e022                	sd	s0,0(sp)
     828:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
     82a:	00054783          	lbu	a5,0(a0)
     82e:	cb91                	beqz	a5,842 <strcmp+0x20>
     830:	0005c703          	lbu	a4,0(a1)
     834:	00f71763          	bne	a4,a5,842 <strcmp+0x20>
    p++, q++;
     838:	0505                	addi	a0,a0,1
     83a:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
     83c:	00054783          	lbu	a5,0(a0)
     840:	fbe5                	bnez	a5,830 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
     842:	0005c503          	lbu	a0,0(a1)
}
     846:	40a7853b          	subw	a0,a5,a0
     84a:	60a2                	ld	ra,8(sp)
     84c:	6402                	ld	s0,0(sp)
     84e:	0141                	addi	sp,sp,16
     850:	8082                	ret

0000000000000852 <strlen>:

uint
strlen(const char *s)
{
     852:	1141                	addi	sp,sp,-16
     854:	e406                	sd	ra,8(sp)
     856:	e022                	sd	s0,0(sp)
     858:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
     85a:	00054783          	lbu	a5,0(a0)
     85e:	cf91                	beqz	a5,87a <strlen+0x28>
     860:	00150793          	addi	a5,a0,1
     864:	86be                	mv	a3,a5
     866:	0785                	addi	a5,a5,1
     868:	fff7c703          	lbu	a4,-1(a5)
     86c:	ff65                	bnez	a4,864 <strlen+0x12>
     86e:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
     872:	60a2                	ld	ra,8(sp)
     874:	6402                	ld	s0,0(sp)
     876:	0141                	addi	sp,sp,16
     878:	8082                	ret
  for (n = 0; s[n]; n++)
     87a:	4501                	li	a0,0
     87c:	bfdd                	j	872 <strlen+0x20>

000000000000087e <memset>:

void *
memset(void *dst, int c, uint n)
{
     87e:	1141                	addi	sp,sp,-16
     880:	e406                	sd	ra,8(sp)
     882:	e022                	sd	s0,0(sp)
     884:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
     886:	ca19                	beqz	a2,89c <memset+0x1e>
     888:	87aa                	mv	a5,a0
     88a:	1602                	slli	a2,a2,0x20
     88c:	9201                	srli	a2,a2,0x20
     88e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     892:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
     896:	0785                	addi	a5,a5,1
     898:	fee79de3          	bne	a5,a4,892 <memset+0x14>
  }
  return dst;
}
     89c:	60a2                	ld	ra,8(sp)
     89e:	6402                	ld	s0,0(sp)
     8a0:	0141                	addi	sp,sp,16
     8a2:	8082                	ret

00000000000008a4 <strchr>:

char *
strchr(const char *s, char c)
{
     8a4:	1141                	addi	sp,sp,-16
     8a6:	e406                	sd	ra,8(sp)
     8a8:	e022                	sd	s0,0(sp)
     8aa:	0800                	addi	s0,sp,16
  for (; *s; s++)
     8ac:	00054783          	lbu	a5,0(a0)
     8b0:	c799                	beqz	a5,8be <strchr+0x1a>
    if (*s == c)
     8b2:	00f58763          	beq	a1,a5,8c0 <strchr+0x1c>
  for (; *s; s++)
     8b6:	0505                	addi	a0,a0,1
     8b8:	00054783          	lbu	a5,0(a0)
     8bc:	fbfd                	bnez	a5,8b2 <strchr+0xe>
      return (char *)s;
  return 0;
     8be:	4501                	li	a0,0
}
     8c0:	60a2                	ld	ra,8(sp)
     8c2:	6402                	ld	s0,0(sp)
     8c4:	0141                	addi	sp,sp,16
     8c6:	8082                	ret

00000000000008c8 <gets>:

char *
gets(char *buf, int max)
{
     8c8:	711d                	addi	sp,sp,-96
     8ca:	ec86                	sd	ra,88(sp)
     8cc:	e8a2                	sd	s0,80(sp)
     8ce:	e4a6                	sd	s1,72(sp)
     8d0:	e0ca                	sd	s2,64(sp)
     8d2:	fc4e                	sd	s3,56(sp)
     8d4:	f852                	sd	s4,48(sp)
     8d6:	f456                	sd	s5,40(sp)
     8d8:	f05a                	sd	s6,32(sp)
     8da:	ec5e                	sd	s7,24(sp)
     8dc:	e862                	sd	s8,16(sp)
     8de:	1080                	addi	s0,sp,96
     8e0:	8baa                	mv	s7,a0
     8e2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
     8e4:	892a                	mv	s2,a0
     8e6:	4481                	li	s1,0
    cc = read(0, &c, 1);
     8e8:	faf40b13          	addi	s6,s0,-81
     8ec:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;) {
     8ee:	8c26                	mv	s8,s1
     8f0:	0014899b          	addiw	s3,s1,1
     8f4:	84ce                	mv	s1,s3
     8f6:	0349d863          	bge	s3,s4,926 <gets+0x5e>
    cc = read(0, &c, 1);
     8fa:	8656                	mv	a2,s5
     8fc:	85da                	mv	a1,s6
     8fe:	4501                	li	a0,0
     900:	1c0000ef          	jal	ac0 <read>
    if (cc < 1)
     904:	02a05163          	blez	a0,926 <gets+0x5e>
      break;
    buf[i++] = c;
     908:	faf44783          	lbu	a5,-81(s0)
     90c:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
     910:	0905                	addi	s2,s2,1
     912:	ff678713          	addi	a4,a5,-10
     916:	00173713          	seqz	a4,a4
     91a:	17cd                	addi	a5,a5,-13
     91c:	0017b793          	seqz	a5,a5
     920:	8fd9                	or	a5,a5,a4
     922:	d7f1                	beqz	a5,8ee <gets+0x26>
    buf[i++] = c;
     924:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
     926:	9c5e                	add	s8,s8,s7
     928:	000c0023          	sb	zero,0(s8)
  return buf;
}
     92c:	855e                	mv	a0,s7
     92e:	60e6                	ld	ra,88(sp)
     930:	6446                	ld	s0,80(sp)
     932:	64a6                	ld	s1,72(sp)
     934:	6906                	ld	s2,64(sp)
     936:	79e2                	ld	s3,56(sp)
     938:	7a42                	ld	s4,48(sp)
     93a:	7aa2                	ld	s5,40(sp)
     93c:	7b02                	ld	s6,32(sp)
     93e:	6be2                	ld	s7,24(sp)
     940:	6c42                	ld	s8,16(sp)
     942:	6125                	addi	sp,sp,96
     944:	8082                	ret

0000000000000946 <stat>:

int
stat(const char *n, struct stat *st)
{
     946:	1101                	addi	sp,sp,-32
     948:	ec06                	sd	ra,24(sp)
     94a:	e822                	sd	s0,16(sp)
     94c:	e04a                	sd	s2,0(sp)
     94e:	1000                	addi	s0,sp,32
     950:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     952:	4581                	li	a1,0
     954:	194000ef          	jal	ae8 <open>
  if (fd < 0)
     958:	02054263          	bltz	a0,97c <stat+0x36>
     95c:	e426                	sd	s1,8(sp)
     95e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     960:	85ca                	mv	a1,s2
     962:	19e000ef          	jal	b00 <fstat>
     966:	892a                	mv	s2,a0
  close(fd);
     968:	8526                	mv	a0,s1
     96a:	166000ef          	jal	ad0 <close>
  return r;
     96e:	64a2                	ld	s1,8(sp)
}
     970:	854a                	mv	a0,s2
     972:	60e2                	ld	ra,24(sp)
     974:	6442                	ld	s0,16(sp)
     976:	6902                	ld	s2,0(sp)
     978:	6105                	addi	sp,sp,32
     97a:	8082                	ret
    return -1;
     97c:	57fd                	li	a5,-1
     97e:	893e                	mv	s2,a5
     980:	bfc5                	j	970 <stat+0x2a>

0000000000000982 <atoi>:

int
atoi(const char *s)
{
     982:	1141                	addi	sp,sp,-16
     984:	e406                	sd	ra,8(sp)
     986:	e022                	sd	s0,0(sp)
     988:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
     98a:	00054683          	lbu	a3,0(a0)
     98e:	fd06879b          	addiw	a5,a3,-48
     992:	0ff7f793          	zext.b	a5,a5
     996:	4625                	li	a2,9
     998:	02f66963          	bltu	a2,a5,9ca <atoi+0x48>
     99c:	872a                	mv	a4,a0
  n = 0;
     99e:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
     9a0:	0705                	addi	a4,a4,1
     9a2:	0025179b          	slliw	a5,a0,0x2
     9a6:	9fa9                	addw	a5,a5,a0
     9a8:	0017979b          	slliw	a5,a5,0x1
     9ac:	9fb5                	addw	a5,a5,a3
     9ae:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
     9b2:	00074683          	lbu	a3,0(a4)
     9b6:	fd06879b          	addiw	a5,a3,-48
     9ba:	0ff7f793          	zext.b	a5,a5
     9be:	fef671e3          	bgeu	a2,a5,9a0 <atoi+0x1e>
  return n;
}
     9c2:	60a2                	ld	ra,8(sp)
     9c4:	6402                	ld	s0,0(sp)
     9c6:	0141                	addi	sp,sp,16
     9c8:	8082                	ret
  n = 0;
     9ca:	4501                	li	a0,0
     9cc:	bfdd                	j	9c2 <atoi+0x40>

00000000000009ce <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
     9ce:	1141                	addi	sp,sp,-16
     9d0:	e406                	sd	ra,8(sp)
     9d2:	e022                	sd	s0,0(sp)
     9d4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     9d6:	02b57563          	bgeu	a0,a1,a00 <memmove+0x32>
    while (n-- > 0)
     9da:	00c05f63          	blez	a2,9f8 <memmove+0x2a>
     9de:	1602                	slli	a2,a2,0x20
     9e0:	9201                	srli	a2,a2,0x20
     9e2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     9e6:	872a                	mv	a4,a0
      *dst++ = *src++;
     9e8:	0585                	addi	a1,a1,1
     9ea:	0705                	addi	a4,a4,1
     9ec:	fff5c683          	lbu	a3,-1(a1)
     9f0:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
     9f4:	fee79ae3          	bne	a5,a4,9e8 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     9f8:	60a2                	ld	ra,8(sp)
     9fa:	6402                	ld	s0,0(sp)
     9fc:	0141                	addi	sp,sp,16
     9fe:	8082                	ret
    while (n-- > 0)
     a00:	fec05ce3          	blez	a2,9f8 <memmove+0x2a>
    dst += n;
     a04:	00c50733          	add	a4,a0,a2
    src += n;
     a08:	95b2                	add	a1,a1,a2
     a0a:	fff6079b          	addiw	a5,a2,-1
     a0e:	1782                	slli	a5,a5,0x20
     a10:	9381                	srli	a5,a5,0x20
     a12:	fff7c793          	not	a5,a5
     a16:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     a18:	15fd                	addi	a1,a1,-1
     a1a:	177d                	addi	a4,a4,-1
     a1c:	0005c683          	lbu	a3,0(a1)
     a20:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
     a24:	fef71ae3          	bne	a4,a5,a18 <memmove+0x4a>
     a28:	bfc1                	j	9f8 <memmove+0x2a>

0000000000000a2a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     a2a:	1141                	addi	sp,sp,-16
     a2c:	e406                	sd	ra,8(sp)
     a2e:	e022                	sd	s0,0(sp)
     a30:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     a32:	ce19                	beqz	a2,a50 <memcmp+0x26>
     a34:	1602                	slli	a2,a2,0x20
     a36:	9201                	srli	a2,a2,0x20
     a38:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
     a3c:	00054783          	lbu	a5,0(a0)
     a40:	0005c703          	lbu	a4,0(a1)
     a44:	00e79b63          	bne	a5,a4,a5a <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
     a48:	0505                	addi	a0,a0,1
    p2++;
     a4a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     a4c:	fed518e3          	bne	a0,a3,a3c <memcmp+0x12>
  }
  return 0;
     a50:	4501                	li	a0,0
}
     a52:	60a2                	ld	ra,8(sp)
     a54:	6402                	ld	s0,0(sp)
     a56:	0141                	addi	sp,sp,16
     a58:	8082                	ret
      return *p1 - *p2;
     a5a:	40e7853b          	subw	a0,a5,a4
     a5e:	bfd5                	j	a52 <memcmp+0x28>

0000000000000a60 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     a60:	1141                	addi	sp,sp,-16
     a62:	e406                	sd	ra,8(sp)
     a64:	e022                	sd	s0,0(sp)
     a66:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     a68:	f67ff0ef          	jal	9ce <memmove>
}
     a6c:	60a2                	ld	ra,8(sp)
     a6e:	6402                	ld	s0,0(sp)
     a70:	0141                	addi	sp,sp,16
     a72:	8082                	ret

0000000000000a74 <sbrk>:

char *
sbrk(int n)
{
     a74:	1141                	addi	sp,sp,-16
     a76:	e406                	sd	ra,8(sp)
     a78:	e022                	sd	s0,0(sp)
     a7a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
     a7c:	4585                	li	a1,1
     a7e:	0b2000ef          	jal	b30 <sys_sbrk>
}
     a82:	60a2                	ld	ra,8(sp)
     a84:	6402                	ld	s0,0(sp)
     a86:	0141                	addi	sp,sp,16
     a88:	8082                	ret

0000000000000a8a <sbrklazy>:

char *
sbrklazy(int n)
{
     a8a:	1141                	addi	sp,sp,-16
     a8c:	e406                	sd	ra,8(sp)
     a8e:	e022                	sd	s0,0(sp)
     a90:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
     a92:	4589                	li	a1,2
     a94:	09c000ef          	jal	b30 <sys_sbrk>
}
     a98:	60a2                	ld	ra,8(sp)
     a9a:	6402                	ld	s0,0(sp)
     a9c:	0141                	addi	sp,sp,16
     a9e:	8082                	ret

0000000000000aa0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     aa0:	4885                	li	a7,1
 ecall
     aa2:	00000073          	ecall
 ret
     aa6:	8082                	ret

0000000000000aa8 <exit>:
.global exit
exit:
 li a7, SYS_exit
     aa8:	4889                	li	a7,2
 ecall
     aaa:	00000073          	ecall
 ret
     aae:	8082                	ret

0000000000000ab0 <wait>:
.global wait
wait:
 li a7, SYS_wait
     ab0:	488d                	li	a7,3
 ecall
     ab2:	00000073          	ecall
 ret
     ab6:	8082                	ret

0000000000000ab8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     ab8:	4891                	li	a7,4
 ecall
     aba:	00000073          	ecall
 ret
     abe:	8082                	ret

0000000000000ac0 <read>:
.global read
read:
 li a7, SYS_read
     ac0:	4895                	li	a7,5
 ecall
     ac2:	00000073          	ecall
 ret
     ac6:	8082                	ret

0000000000000ac8 <write>:
.global write
write:
 li a7, SYS_write
     ac8:	48c1                	li	a7,16
 ecall
     aca:	00000073          	ecall
 ret
     ace:	8082                	ret

0000000000000ad0 <close>:
.global close
close:
 li a7, SYS_close
     ad0:	48d5                	li	a7,21
 ecall
     ad2:	00000073          	ecall
 ret
     ad6:	8082                	ret

0000000000000ad8 <kill>:
.global kill
kill:
 li a7, SYS_kill
     ad8:	4899                	li	a7,6
 ecall
     ada:	00000073          	ecall
 ret
     ade:	8082                	ret

0000000000000ae0 <exec>:
.global exec
exec:
 li a7, SYS_exec
     ae0:	489d                	li	a7,7
 ecall
     ae2:	00000073          	ecall
 ret
     ae6:	8082                	ret

0000000000000ae8 <open>:
.global open
open:
 li a7, SYS_open
     ae8:	48bd                	li	a7,15
 ecall
     aea:	00000073          	ecall
 ret
     aee:	8082                	ret

0000000000000af0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     af0:	48c5                	li	a7,17
 ecall
     af2:	00000073          	ecall
 ret
     af6:	8082                	ret

0000000000000af8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     af8:	48c9                	li	a7,18
 ecall
     afa:	00000073          	ecall
 ret
     afe:	8082                	ret

0000000000000b00 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     b00:	48a1                	li	a7,8
 ecall
     b02:	00000073          	ecall
 ret
     b06:	8082                	ret

0000000000000b08 <link>:
.global link
link:
 li a7, SYS_link
     b08:	48cd                	li	a7,19
 ecall
     b0a:	00000073          	ecall
 ret
     b0e:	8082                	ret

0000000000000b10 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     b10:	48d1                	li	a7,20
 ecall
     b12:	00000073          	ecall
 ret
     b16:	8082                	ret

0000000000000b18 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     b18:	48a5                	li	a7,9
 ecall
     b1a:	00000073          	ecall
 ret
     b1e:	8082                	ret

0000000000000b20 <dup>:
.global dup
dup:
 li a7, SYS_dup
     b20:	48a9                	li	a7,10
 ecall
     b22:	00000073          	ecall
 ret
     b26:	8082                	ret

0000000000000b28 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     b28:	48ad                	li	a7,11
 ecall
     b2a:	00000073          	ecall
 ret
     b2e:	8082                	ret

0000000000000b30 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     b30:	48b1                	li	a7,12
 ecall
     b32:	00000073          	ecall
 ret
     b36:	8082                	ret

0000000000000b38 <pause>:
.global pause
pause:
 li a7, SYS_pause
     b38:	48b5                	li	a7,13
 ecall
     b3a:	00000073          	ecall
 ret
     b3e:	8082                	ret

0000000000000b40 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     b40:	48b9                	li	a7,14
 ecall
     b42:	00000073          	ecall
 ret
     b46:	8082                	ret

0000000000000b48 <sync>:
.global sync
sync:
 li a7, SYS_sync
     b48:	48d9                	li	a7,22
 ecall
     b4a:	00000073          	ecall
 ret
     b4e:	8082                	ret

0000000000000b50 <istat>:
.global istat
istat:
 li a7, SYS_istat
     b50:	48dd                	li	a7,23
 ecall
     b52:	00000073          	ecall
 ret
     b56:	8082                	ret

0000000000000b58 <iprint>:
.global iprint
iprint:
 li a7, SYS_iprint
     b58:	48e1                	li	a7,24
 ecall
     b5a:	00000073          	ecall
 ret
     b5e:	8082                	ret

0000000000000b60 <symlink>:
.global symlink
symlink:
 li a7, SYS_symlink
     b60:	48e5                	li	a7,25
 ecall
     b62:	00000073          	ecall
 ret
     b66:	8082                	ret

0000000000000b68 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     b68:	1101                	addi	sp,sp,-32
     b6a:	ec06                	sd	ra,24(sp)
     b6c:	e822                	sd	s0,16(sp)
     b6e:	1000                	addi	s0,sp,32
     b70:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     b74:	4605                	li	a2,1
     b76:	fef40593          	addi	a1,s0,-17
     b7a:	f4fff0ef          	jal	ac8 <write>
}
     b7e:	60e2                	ld	ra,24(sp)
     b80:	6442                	ld	s0,16(sp)
     b82:	6105                	addi	sp,sp,32
     b84:	8082                	ret

0000000000000b86 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     b86:	715d                	addi	sp,sp,-80
     b88:	e486                	sd	ra,72(sp)
     b8a:	e0a2                	sd	s0,64(sp)
     b8c:	f84a                	sd	s2,48(sp)
     b8e:	f44e                	sd	s3,40(sp)
     b90:	0880                	addi	s0,sp,80
     b92:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
     b94:	00d036b3          	snez	a3,a3
     b98:	03f5d793          	srli	a5,a1,0x3f
     b9c:	8efd                	and	a3,a3,a5
  neg = 0;
     b9e:	4301                	li	t1,0
  if (sgn && xx < 0) {
     ba0:	c681                	beqz	a3,ba8 <printint+0x22>
    neg = 1;
    x = -xx;
     ba2:	40b005b3          	neg	a1,a1
    neg = 1;
     ba6:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
     ba8:	fb840993          	addi	s3,s0,-72
  neg = 0;
     bac:	86ce                	mv	a3,s3
  i = 0;
     bae:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
     bb0:	00000817          	auipc	a6,0x0
     bb4:	6b880813          	addi	a6,a6,1720 # 1268 <digits>
     bb8:	88ba                	mv	a7,a4
     bba:	0017051b          	addiw	a0,a4,1
     bbe:	872a                	mv	a4,a0
     bc0:	02c5f7b3          	remu	a5,a1,a2
     bc4:	97c2                	add	a5,a5,a6
     bc6:	0007c783          	lbu	a5,0(a5)
     bca:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
     bce:	87ae                	mv	a5,a1
     bd0:	02c5d5b3          	divu	a1,a1,a2
     bd4:	0685                	addi	a3,a3,1
     bd6:	fec7f1e3          	bgeu	a5,a2,bb8 <printint+0x32>
  if (neg)
     bda:	00030b63          	beqz	t1,bf0 <printint+0x6a>
    buf[i++] = '-';
     bde:	fd040793          	addi	a5,s0,-48
     be2:	953e                	add	a0,a0,a5
     be4:	02d00793          	li	a5,45
     be8:	fef50423          	sb	a5,-24(a0)
     bec:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
     bf0:	02e05563          	blez	a4,c1a <printint+0x94>
     bf4:	fc26                	sd	s1,56(sp)
     bf6:	377d                	addiw	a4,a4,-1
     bf8:	00e984b3          	add	s1,s3,a4
     bfc:	19fd                	addi	s3,s3,-1
     bfe:	99ba                	add	s3,s3,a4
     c00:	1702                	slli	a4,a4,0x20
     c02:	9301                	srli	a4,a4,0x20
     c04:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     c08:	0004c583          	lbu	a1,0(s1)
     c0c:	854a                	mv	a0,s2
     c0e:	f5bff0ef          	jal	b68 <putc>
  while (--i >= 0)
     c12:	14fd                	addi	s1,s1,-1
     c14:	ff349ae3          	bne	s1,s3,c08 <printint+0x82>
     c18:	74e2                	ld	s1,56(sp)
}
     c1a:	60a6                	ld	ra,72(sp)
     c1c:	6406                	ld	s0,64(sp)
     c1e:	7942                	ld	s2,48(sp)
     c20:	79a2                	ld	s3,40(sp)
     c22:	6161                	addi	sp,sp,80
     c24:	8082                	ret

0000000000000c26 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     c26:	711d                	addi	sp,sp,-96
     c28:	ec86                	sd	ra,88(sp)
     c2a:	e8a2                	sd	s0,80(sp)
     c2c:	e4a6                	sd	s1,72(sp)
     c2e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
     c30:	0005c483          	lbu	s1,0(a1)
     c34:	2a048063          	beqz	s1,ed4 <vprintf+0x2ae>
     c38:	e0ca                	sd	s2,64(sp)
     c3a:	fc4e                	sd	s3,56(sp)
     c3c:	f852                	sd	s4,48(sp)
     c3e:	f456                	sd	s5,40(sp)
     c40:	f05a                	sd	s6,32(sp)
     c42:	ec5e                	sd	s7,24(sp)
     c44:	e862                	sd	s8,16(sp)
     c46:	8b2a                	mv	s6,a0
     c48:	8a2e                	mv	s4,a1
     c4a:	8bb2                	mv	s7,a2
  state = 0;
     c4c:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
     c4e:	4901                	li	s2,0
     c50:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
     c52:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
     c56:	06400c13          	li	s8,100
     c5a:	a00d                	j	c7c <vprintf+0x56>
        putc(fd, c0);
     c5c:	85a6                	mv	a1,s1
     c5e:	855a                	mv	a0,s6
     c60:	f09ff0ef          	jal	b68 <putc>
     c64:	a019                	j	c6a <vprintf+0x44>
    } else if (state == '%') {
     c66:	03598363          	beq	s3,s5,c8c <vprintf+0x66>
  for (i = 0; fmt[i]; i++) {
     c6a:	0019079b          	addiw	a5,s2,1
     c6e:	893e                	mv	s2,a5
     c70:	873e                	mv	a4,a5
     c72:	97d2                	add	a5,a5,s4
     c74:	0007c483          	lbu	s1,0(a5)
     c78:	24048763          	beqz	s1,ec6 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
     c7c:	0004879b          	sext.w	a5,s1
    if (state == 0) {
     c80:	fe0993e3          	bnez	s3,c66 <vprintf+0x40>
      if (c0 == '%') {
     c84:	fd579ce3          	bne	a5,s5,c5c <vprintf+0x36>
        state = '%';
     c88:	89be                	mv	s3,a5
     c8a:	b7c5                	j	c6a <vprintf+0x44>
        c1 = fmt[i + 1] & 0xff;
     c8c:	00ea06b3          	add	a3,s4,a4
     c90:	0016c603          	lbu	a2,1(a3)
      if (c1)
     c94:	24060563          	beqz	a2,ede <vprintf+0x2b8>
      if (c0 == 'd') {
     c98:	0b878763          	beq	a5,s8,d46 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
     c9c:	f9478693          	addi	a3,a5,-108
     ca0:	0016b693          	seqz	a3,a3
     ca4:	f9c60593          	addi	a1,a2,-100
     ca8:	0015b593          	seqz	a1,a1
     cac:	8df5                	and	a1,a1,a3
     cae:	e9c5                	bnez	a1,d5e <vprintf+0x138>
        c2 = fmt[i + 2] & 0xff;
     cb0:	9752                	add	a4,a4,s4
     cb2:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
     cb6:	f9460713          	addi	a4,a2,-108
     cba:	00173713          	seqz	a4,a4
     cbe:	8f75                	and	a4,a4,a3
     cc0:	f9c50593          	addi	a1,a0,-100
     cc4:	0015b593          	seqz	a1,a1
     cc8:	8df9                	and	a1,a1,a4
     cca:	e5dd                	bnez	a1,d78 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
     ccc:	07500593          	li	a1,117
     cd0:	0cb78163          	beq	a5,a1,d92 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if (c0 == 'l' && c1 == 'u') {
     cd4:	f8b60593          	addi	a1,a2,-117
     cd8:	0015b593          	seqz	a1,a1
     cdc:	8df5                	and	a1,a1,a3
     cde:	e5f1                	bnez	a1,daa <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
     ce0:	f8b50593          	addi	a1,a0,-117
     ce4:	0015b593          	seqz	a1,a1
     ce8:	8df9                	and	a1,a1,a4
     cea:	ede9                	bnez	a1,dc4 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
     cec:	07800593          	li	a1,120
     cf0:	0eb78763          	beq	a5,a1,dde <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if (c0 == 'l' && c1 == 'x') {
     cf4:	f8860613          	addi	a2,a2,-120
     cf8:	00163613          	seqz	a2,a2
     cfc:	8ef1                	and	a3,a3,a2
     cfe:	0e069c63          	bnez	a3,df6 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
     d02:	f8850513          	addi	a0,a0,-120
     d06:	00153513          	seqz	a0,a0
     d0a:	8f69                	and	a4,a4,a0
     d0c:	10071263          	bnez	a4,e10 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
     d10:	07000713          	li	a4,112
     d14:	10e78a63          	beq	a5,a4,e28 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
     d18:	06300713          	li	a4,99
     d1c:	14e78a63          	beq	a5,a4,e70 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
     d20:	07300713          	li	a4,115
     d24:	16e78063          	beq	a5,a4,e84 <vprintf+0x25e>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
     d28:	02500713          	li	a4,37
     d2c:	18e78863          	beq	a5,a4,ebc <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     d30:	02500593          	li	a1,37
     d34:	855a                	mv	a0,s6
     d36:	e33ff0ef          	jal	b68 <putc>
        putc(fd, c0);
     d3a:	85a6                	mv	a1,s1
     d3c:	855a                	mv	a0,s6
     d3e:	e2bff0ef          	jal	b68 <putc>
      }

      state = 0;
     d42:	4981                	li	s3,0
     d44:	b71d                	j	c6a <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
     d46:	008b8493          	addi	s1,s7,8
     d4a:	4685                	li	a3,1
     d4c:	4629                	li	a2,10
     d4e:	000ba583          	lw	a1,0(s7)
     d52:	855a                	mv	a0,s6
     d54:	e33ff0ef          	jal	b86 <printint>
     d58:	8ba6                	mv	s7,s1
      state = 0;
     d5a:	4981                	li	s3,0
     d5c:	b739                	j	c6a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
     d5e:	008b8493          	addi	s1,s7,8
     d62:	4685                	li	a3,1
     d64:	4629                	li	a2,10
     d66:	000bb583          	ld	a1,0(s7)
     d6a:	855a                	mv	a0,s6
     d6c:	e1bff0ef          	jal	b86 <printint>
        i += 1;
     d70:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     d72:	8ba6                	mv	s7,s1
      state = 0;
     d74:	4981                	li	s3,0
     d76:	bdd5                	j	c6a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
     d78:	008b8493          	addi	s1,s7,8
     d7c:	4685                	li	a3,1
     d7e:	4629                	li	a2,10
     d80:	000bb583          	ld	a1,0(s7)
     d84:	855a                	mv	a0,s6
     d86:	e01ff0ef          	jal	b86 <printint>
        i += 2;
     d8a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     d8c:	8ba6                	mv	s7,s1
      state = 0;
     d8e:	4981                	li	s3,0
        i += 2;
     d90:	bde9                	j	c6a <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
     d92:	008b8493          	addi	s1,s7,8
     d96:	4681                	li	a3,0
     d98:	4629                	li	a2,10
     d9a:	000be583          	lwu	a1,0(s7)
     d9e:	855a                	mv	a0,s6
     da0:	de7ff0ef          	jal	b86 <printint>
     da4:	8ba6                	mv	s7,s1
      state = 0;
     da6:	4981                	li	s3,0
     da8:	b5c9                	j	c6a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
     daa:	008b8493          	addi	s1,s7,8
     dae:	4681                	li	a3,0
     db0:	4629                	li	a2,10
     db2:	000bb583          	ld	a1,0(s7)
     db6:	855a                	mv	a0,s6
     db8:	dcfff0ef          	jal	b86 <printint>
        i += 1;
     dbc:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     dbe:	8ba6                	mv	s7,s1
      state = 0;
     dc0:	4981                	li	s3,0
     dc2:	b565                	j	c6a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
     dc4:	008b8493          	addi	s1,s7,8
     dc8:	4681                	li	a3,0
     dca:	4629                	li	a2,10
     dcc:	000bb583          	ld	a1,0(s7)
     dd0:	855a                	mv	a0,s6
     dd2:	db5ff0ef          	jal	b86 <printint>
        i += 2;
     dd6:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
     dd8:	8ba6                	mv	s7,s1
      state = 0;
     dda:	4981                	li	s3,0
        i += 2;
     ddc:	b579                	j	c6a <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
     dde:	008b8493          	addi	s1,s7,8
     de2:	4681                	li	a3,0
     de4:	4641                	li	a2,16
     de6:	000be583          	lwu	a1,0(s7)
     dea:	855a                	mv	a0,s6
     dec:	d9bff0ef          	jal	b86 <printint>
     df0:	8ba6                	mv	s7,s1
      state = 0;
     df2:	4981                	li	s3,0
     df4:	bd9d                	j	c6a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
     df6:	008b8493          	addi	s1,s7,8
     dfa:	4681                	li	a3,0
     dfc:	4641                	li	a2,16
     dfe:	000bb583          	ld	a1,0(s7)
     e02:	855a                	mv	a0,s6
     e04:	d83ff0ef          	jal	b86 <printint>
        i += 1;
     e08:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
     e0a:	8ba6                	mv	s7,s1
      state = 0;
     e0c:	4981                	li	s3,0
     e0e:	bdb1                	j	c6a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
     e10:	008b8493          	addi	s1,s7,8
     e14:	4641                	li	a2,16
     e16:	000bb583          	ld	a1,0(s7)
     e1a:	855a                	mv	a0,s6
     e1c:	d6bff0ef          	jal	b86 <printint>
        i += 2;
     e20:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     e22:	8ba6                	mv	s7,s1
      state = 0;
     e24:	4981                	li	s3,0
        i += 2;
     e26:	b591                	j	c6a <vprintf+0x44>
     e28:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
     e2a:	008b8793          	addi	a5,s7,8
     e2e:	8cbe                	mv	s9,a5
     e30:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     e34:	03000593          	li	a1,48
     e38:	855a                	mv	a0,s6
     e3a:	d2fff0ef          	jal	b68 <putc>
  putc(fd, 'x');
     e3e:	07800593          	li	a1,120
     e42:	855a                	mv	a0,s6
     e44:	d25ff0ef          	jal	b68 <putc>
     e48:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     e4a:	00000b97          	auipc	s7,0x0
     e4e:	41eb8b93          	addi	s7,s7,1054 # 1268 <digits>
     e52:	03c9d793          	srli	a5,s3,0x3c
     e56:	97de                	add	a5,a5,s7
     e58:	0007c583          	lbu	a1,0(a5)
     e5c:	855a                	mv	a0,s6
     e5e:	d0bff0ef          	jal	b68 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     e62:	0992                	slli	s3,s3,0x4
     e64:	34fd                	addiw	s1,s1,-1
     e66:	f4f5                	bnez	s1,e52 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
     e68:	8be6                	mv	s7,s9
      state = 0;
     e6a:	4981                	li	s3,0
     e6c:	6ca2                	ld	s9,8(sp)
     e6e:	bbf5                	j	c6a <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
     e70:	008b8493          	addi	s1,s7,8
     e74:	000bc583          	lbu	a1,0(s7)
     e78:	855a                	mv	a0,s6
     e7a:	cefff0ef          	jal	b68 <putc>
     e7e:	8ba6                	mv	s7,s1
      state = 0;
     e80:	4981                	li	s3,0
     e82:	b3e5                	j	c6a <vprintf+0x44>
        if ((s = va_arg(ap, char *)) == 0)
     e84:	008b8993          	addi	s3,s7,8
     e88:	000bb483          	ld	s1,0(s7)
     e8c:	cc91                	beqz	s1,ea8 <vprintf+0x282>
        for (; *s; s++)
     e8e:	0004c583          	lbu	a1,0(s1)
     e92:	c195                	beqz	a1,eb6 <vprintf+0x290>
          putc(fd, *s);
     e94:	855a                	mv	a0,s6
     e96:	cd3ff0ef          	jal	b68 <putc>
        for (; *s; s++)
     e9a:	0485                	addi	s1,s1,1
     e9c:	0004c583          	lbu	a1,0(s1)
     ea0:	f9f5                	bnez	a1,e94 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
     ea2:	8bce                	mv	s7,s3
      state = 0;
     ea4:	4981                	li	s3,0
     ea6:	b3d1                	j	c6a <vprintf+0x44>
          s = "(null)";
     ea8:	00000497          	auipc	s1,0x0
     eac:	3b848493          	addi	s1,s1,952 # 1260 <malloc+0x286>
        for (; *s; s++)
     eb0:	02800593          	li	a1,40
     eb4:	b7c5                	j	e94 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
     eb6:	8bce                	mv	s7,s3
      state = 0;
     eb8:	4981                	li	s3,0
     eba:	bb45                	j	c6a <vprintf+0x44>
        putc(fd, '%');
     ebc:	85be                	mv	a1,a5
     ebe:	855a                	mv	a0,s6
     ec0:	ca9ff0ef          	jal	b68 <putc>
     ec4:	bdbd                	j	d42 <vprintf+0x11c>
     ec6:	6906                	ld	s2,64(sp)
     ec8:	79e2                	ld	s3,56(sp)
     eca:	7a42                	ld	s4,48(sp)
     ecc:	7aa2                	ld	s5,40(sp)
     ece:	7b02                	ld	s6,32(sp)
     ed0:	6be2                	ld	s7,24(sp)
     ed2:	6c42                	ld	s8,16(sp)
    }
  }
}
     ed4:	60e6                	ld	ra,88(sp)
     ed6:	6446                	ld	s0,80(sp)
     ed8:	64a6                	ld	s1,72(sp)
     eda:	6125                	addi	sp,sp,96
     edc:	8082                	ret
      if (c0 == 'd') {
     ede:	06400713          	li	a4,100
     ee2:	e6e782e3          	beq	a5,a4,d46 <vprintf+0x120>
      } else if (c0 == 'l' && c1 == 'd') {
     ee6:	f9478693          	addi	a3,a5,-108
     eea:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
     eee:	8532                	mv	a0,a2
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
     ef0:	4701                	li	a4,0
     ef2:	bbe9                	j	ccc <vprintf+0xa6>

0000000000000ef4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     ef4:	715d                	addi	sp,sp,-80
     ef6:	ec06                	sd	ra,24(sp)
     ef8:	e822                	sd	s0,16(sp)
     efa:	1000                	addi	s0,sp,32
     efc:	e010                	sd	a2,0(s0)
     efe:	e414                	sd	a3,8(s0)
     f00:	e818                	sd	a4,16(s0)
     f02:	ec1c                	sd	a5,24(s0)
     f04:	03043023          	sd	a6,32(s0)
     f08:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
     f0c:	8622                	mv	a2,s0
     f0e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
     f12:	d15ff0ef          	jal	c26 <vprintf>
}
     f16:	60e2                	ld	ra,24(sp)
     f18:	6442                	ld	s0,16(sp)
     f1a:	6161                	addi	sp,sp,80
     f1c:	8082                	ret

0000000000000f1e <printf>:

void
printf(const char *fmt, ...)
{
     f1e:	711d                	addi	sp,sp,-96
     f20:	ec06                	sd	ra,24(sp)
     f22:	e822                	sd	s0,16(sp)
     f24:	1000                	addi	s0,sp,32
     f26:	e40c                	sd	a1,8(s0)
     f28:	e810                	sd	a2,16(s0)
     f2a:	ec14                	sd	a3,24(s0)
     f2c:	f018                	sd	a4,32(s0)
     f2e:	f41c                	sd	a5,40(s0)
     f30:	03043823          	sd	a6,48(s0)
     f34:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     f38:	00840613          	addi	a2,s0,8
     f3c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
     f40:	85aa                	mv	a1,a0
     f42:	4505                	li	a0,1
     f44:	ce3ff0ef          	jal	c26 <vprintf>
}
     f48:	60e2                	ld	ra,24(sp)
     f4a:	6442                	ld	s0,16(sp)
     f4c:	6125                	addi	sp,sp,96
     f4e:	8082                	ret

0000000000000f50 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     f50:	1141                	addi	sp,sp,-16
     f52:	e406                	sd	ra,8(sp)
     f54:	e022                	sd	s0,0(sp)
     f56:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
     f58:	ff050713          	addi	a4,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f5c:	00001797          	auipc	a5,0x1
     f60:	0a47b783          	ld	a5,164(a5) # 2000 <freep>
     f64:	a095                	j	fc8 <free+0x78>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
     f66:	ff852583          	lw	a1,-8(a0)
     f6a:	6390                	ld	a2,0(a5)
     f6c:	02059813          	slli	a6,a1,0x20
     f70:	01c85693          	srli	a3,a6,0x1c
     f74:	96ba                	add	a3,a3,a4
     f76:	02d60563          	beq	a2,a3,fa0 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
     f7a:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
     f7e:	4790                	lw	a2,8(a5)
     f80:	02061593          	slli	a1,a2,0x20
     f84:	01c5d693          	srli	a3,a1,0x1c
     f88:	96be                	add	a3,a3,a5
     f8a:	02d70263          	beq	a4,a3,fae <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
     f8e:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
     f90:	00001717          	auipc	a4,0x1
     f94:	06f73823          	sd	a5,112(a4) # 2000 <freep>
}
     f98:	60a2                	ld	ra,8(sp)
     f9a:	6402                	ld	s0,0(sp)
     f9c:	0141                	addi	sp,sp,16
     f9e:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
     fa0:	4614                	lw	a3,8(a2)
     fa2:	9ead                	addw	a3,a3,a1
     fa4:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
     fa8:	6394                	ld	a3,0(a5)
     faa:	6290                	ld	a2,0(a3)
     fac:	b7f9                	j	f7a <free+0x2a>
    p->s.size += bp->s.size;
     fae:	ff852703          	lw	a4,-8(a0)
     fb2:	9f31                	addw	a4,a4,a2
     fb4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     fb6:	ff053703          	ld	a4,-16(a0)
     fba:	bfd1                	j	f8e <free+0x3e>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fbc:	6394                	ld	a3,0(a5)
     fbe:	00d7e463          	bltu	a5,a3,fc6 <free+0x76>
     fc2:	fad762e3          	bltu	a4,a3,f66 <free+0x16>
     fc6:	87b6                	mv	a5,a3
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fc8:	fee7fae3          	bgeu	a5,a4,fbc <free+0x6c>
     fcc:	6394                	ld	a3,0(a5)
     fce:	f8d76ce3          	bltu	a4,a3,f66 <free+0x16>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fd2:	f8d7fae3          	bgeu	a5,a3,f66 <free+0x16>
     fd6:	87b6                	mv	a5,a3
     fd8:	bfc5                	j	fc8 <free+0x78>

0000000000000fda <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
     fda:	7139                	addi	sp,sp,-64
     fdc:	fc06                	sd	ra,56(sp)
     fde:	f822                	sd	s0,48(sp)
     fe0:	f04a                	sd	s2,32(sp)
     fe2:	ec4e                	sd	s3,24(sp)
     fe4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
     fe6:	02051993          	slli	s3,a0,0x20
     fea:	0209d993          	srli	s3,s3,0x20
     fee:	09bd                	addi	s3,s3,15
     ff0:	0049d993          	srli	s3,s3,0x4
     ff4:	2985                	addiw	s3,s3,1
     ff6:	894e                	mv	s2,s3
  if ((prevp = freep) == 0) {
     ff8:	00001517          	auipc	a0,0x1
     ffc:	00853503          	ld	a0,8(a0) # 2000 <freep>
    1000:	c905                	beqz	a0,1030 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    1002:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
    1004:	4798                	lw	a4,8(a5)
    1006:	09377663          	bgeu	a4,s3,1092 <malloc+0xb8>
    100a:	f426                	sd	s1,40(sp)
    100c:	e852                	sd	s4,16(sp)
    100e:	e456                	sd	s5,8(sp)
    1010:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
    1012:	8a4e                	mv	s4,s3
    1014:	6705                	lui	a4,0x1
    1016:	00e9f363          	bgeu	s3,a4,101c <malloc+0x42>
    101a:	6a05                	lui	s4,0x1
    101c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1020:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
    1024:	00001497          	auipc	s1,0x1
    1028:	fdc48493          	addi	s1,s1,-36 # 2000 <freep>
  if (p == SBRK_ERROR)
    102c:	5afd                	li	s5,-1
    102e:	a83d                	j	106c <malloc+0x92>
    1030:	f426                	sd	s1,40(sp)
    1032:	e852                	sd	s4,16(sp)
    1034:	e456                	sd	s5,8(sp)
    1036:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    1038:	00003797          	auipc	a5,0x3
    103c:	fd878793          	addi	a5,a5,-40 # 4010 <base>
    1040:	00001717          	auipc	a4,0x1
    1044:	fcf73023          	sd	a5,-64(a4) # 2000 <freep>
    1048:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    104a:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
    104e:	b7d1                	j	1012 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    1050:	6398                	ld	a4,0(a5)
    1052:	e118                	sd	a4,0(a0)
    1054:	a899                	j	10aa <malloc+0xd0>
  hp->s.size = nu;
    1056:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
    105a:	0541                	addi	a0,a0,16
    105c:	ef5ff0ef          	jal	f50 <free>
  return freep;
    1060:	6088                	ld	a0,0(s1)
      if ((p = morecore(nunits)) == 0)
    1062:	c125                	beqz	a0,10c2 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    1064:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
    1066:	4798                	lw	a4,8(a5)
    1068:	03277163          	bgeu	a4,s2,108a <malloc+0xb0>
    if (p == freep)
    106c:	6098                	ld	a4,0(s1)
    106e:	853e                	mv	a0,a5
    1070:	fef71ae3          	bne	a4,a5,1064 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
    1074:	8552                	mv	a0,s4
    1076:	9ffff0ef          	jal	a74 <sbrk>
  if (p == SBRK_ERROR)
    107a:	fd551ee3          	bne	a0,s5,1056 <malloc+0x7c>
        return 0;
    107e:	4501                	li	a0,0
    1080:	74a2                	ld	s1,40(sp)
    1082:	6a42                	ld	s4,16(sp)
    1084:	6aa2                	ld	s5,8(sp)
    1086:	6b02                	ld	s6,0(sp)
    1088:	a03d                	j	10b6 <malloc+0xdc>
    108a:	74a2                	ld	s1,40(sp)
    108c:	6a42                	ld	s4,16(sp)
    108e:	6aa2                	ld	s5,8(sp)
    1090:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
    1092:	fae90fe3          	beq	s2,a4,1050 <malloc+0x76>
        p->s.size -= nunits;
    1096:	4137073b          	subw	a4,a4,s3
    109a:	c798                	sw	a4,8(a5)
        p += p->s.size;
    109c:	02071693          	slli	a3,a4,0x20
    10a0:	01c6d713          	srli	a4,a3,0x1c
    10a4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    10a6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    10aa:	00001717          	auipc	a4,0x1
    10ae:	f4a73b23          	sd	a0,-170(a4) # 2000 <freep>
      return (void *)(p + 1);
    10b2:	01078513          	addi	a0,a5,16
  }
}
    10b6:	70e2                	ld	ra,56(sp)
    10b8:	7442                	ld	s0,48(sp)
    10ba:	7902                	ld	s2,32(sp)
    10bc:	69e2                	ld	s3,24(sp)
    10be:	6121                	addi	sp,sp,64
    10c0:	8082                	ret
    10c2:	74a2                	ld	s1,40(sp)
    10c4:	6a42                	ld	s4,16(sp)
    10c6:	6aa2                	ld	s5,8(sp)
    10c8:	6b02                	ld	s6,0(sp)
    10ca:	b7f5                	j	10b6 <malloc+0xdc>
