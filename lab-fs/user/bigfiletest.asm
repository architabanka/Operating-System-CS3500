
user/_bigfiletest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/fs_test.h"
int
main(void)
{
   0:	7159                	addi	sp,sp,-112
   2:	f486                	sd	ra,104(sp)
   4:	f0a2                	sd	s0,96(sp)
   6:	1880                	addi	s0,sp,112
}

static inline void
makefile(const char *name, uint blocks, uint seed)
{
  unlink(name);
   8:	00001517          	auipc	a0,0x1
   c:	c6850513          	addi	a0,a0,-920 # c70 <malloc+0xfc>
  10:	682000ef          	jal	692 <unlink>
  int fd = open(name, O_CREATE | O_WRONLY | O_TRUNC);
  14:	60100593          	li	a1,1537
  18:	00001517          	auipc	a0,0x1
  1c:	c5850513          	addi	a0,a0,-936 # c70 <malloc+0xfc>
  20:	662000ef          	jal	682 <open>
  if (!ok) {
  24:	02054563          	bltz	a0,4e <main+0x4e>
  28:	eca6                	sd	s1,88(sp)
  2a:	e8ca                	sd	s2,80(sp)
  2c:	e4ce                	sd	s3,72(sp)
  2e:	e0d2                	sd	s4,64(sp)
  30:	fc56                	sd	s5,56(sp)
  32:	f85a                	sd	s6,48(sp)
  34:	f45e                	sd	s7,40(sp)
  36:	f062                	sd	s8,32(sp)
  38:	8b2a                	mv	s6,a0
  3a:	4a01                	li	s4,0
  check(fd >= 0, "create test file");
  for (uint first = 0; first < blocks;) {
    uint n = blocks - first;
  3c:	20d00b93          	li	s7,525
    if (n > 8)
      n = 8;
    for (uint b = 0; b < n; b++)
      for (uint j = 0; j < BSIZE; j++)
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
  40:	00001497          	auipc	s1,0x1
  44:	fd048493          	addi	s1,s1,-48 # 1010 <fs_buffer>
  if (byte == 4)
  48:	4911                	li	s2,4
    return seed;
  4a:	499d                	li	s3,7
  4c:	a86d                	j	106 <main+0x106>
  4e:	eca6                	sd	s1,88(sp)
  50:	e8ca                	sd	s2,80(sp)
  52:	e4ce                	sd	s3,72(sp)
  54:	e0d2                	sd	s4,64(sp)
  56:	fc56                	sd	s5,56(sp)
  58:	f85a                	sd	s6,48(sp)
  5a:	f45e                	sd	s7,40(sp)
  5c:	f062                	sd	s8,32(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
  5e:	00001617          	auipc	a2,0x1
  62:	c2260613          	addi	a2,a2,-990 # c80 <malloc+0x10c>
  66:	00001597          	auipc	a1,0x1
  6a:	c3258593          	addi	a1,a1,-974 # c98 <malloc+0x124>
  6e:	4509                	li	a0,2
  70:	21f000ef          	jal	a8e <fprintf>
    exit(1);
  74:	4505                	li	a0,1
  76:	5cc000ef          	jal	642 <exit>
      for (uint j = 0; j < BSIZE; j++)
  7a:	26c5                	addiw	a3,a3,17
  7c:	0ff6f693          	zext.b	a3,a3
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
  80:	00b707bb          	addw	a5,a4,a1
  if (byte < 4)
  84:	04e57263          	bgeu	a0,a4,c8 <main+0xc8>
  if (byte == 4)
  88:	31270063          	beq	a4,s2,388 <main+0x388>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
  8c:	1782                	slli	a5,a5,0x20
  8e:	9381                	srli	a5,a5,0x20
  90:	97a6                	add	a5,a5,s1
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
  92:	0106c633          	xor	a2,a3,a6
  96:	01164633          	xor	a2,a2,a7
  9a:	fcb64613          	xori	a2,a2,-53
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
  9e:	00c78023          	sb	a2,0(a5)
      for (uint j = 0; j < BSIZE; j++)
  a2:	2705                	addiw	a4,a4,1
  a4:	fc671be3          	bne	a4,t1,7a <main+0x7a>
    for (uint b = 0; b < n; b++)
  a8:	2e85                	addiw	t4,t4,1
  aa:	f838081b          	addiw	a6,a6,-125
  ae:	0ff87813          	zext.b	a6,a6
  b2:	4005859b          	addiw	a1,a1,1024
  b6:	035ef963          	bgeu	t4,s5,e8 <main+0xe8>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
  ba:	01da0e3b          	addw	t3,s4,t4
  be:	4681                	li	a3,0
      for (uint j = 0; j < BSIZE; j++)
  c0:	4701                	li	a4,0
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
  c2:	008e589b          	srliw	a7,t3,0x8
  c6:	bf6d                	j	80 <main+0x80>
    return (block >> (8 * byte)) & 255;
  c8:	0037161b          	slliw	a2,a4,0x3
  cc:	00ce563b          	srlw	a2,t3,a2
  d0:	0ff67613          	zext.b	a2,a2
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
  d4:	1782                	slli	a5,a5,0x20
  d6:	9381                	srli	a5,a5,0x20
  d8:	97a6                	add	a5,a5,s1
  da:	00c78023          	sb	a2,0(a5)
      for (uint j = 0; j < BSIZE; j++)
  de:	2705                	addiw	a4,a4,1
  e0:	26c5                	addiw	a3,a3,17
  e2:	0ff6f693          	zext.b	a3,a3
  e6:	bf69                	j	80 <main+0x80>
    check(write(fd, fs_buffer, n * BSIZE) == n * BSIZE, "write full test data");
  e8:	00aa961b          	slliw	a2,s5,0xa
  ec:	8c32                	mv	s8,a2
  ee:	85a6                	mv	a1,s1
  f0:	855a                	mv	a0,s6
  f2:	570000ef          	jal	662 <write>
  if (!ok) {
  f6:	04ac1063          	bne	s8,a0,136 <main+0x136>
    first += n;
  fa:	015a0a3b          	addw	s4,s4,s5
  for (uint first = 0; first < blocks;) {
  fe:	20c00793          	li	a5,524
 102:	0547e863          	bltu	a5,s4,152 <main+0x152>
    uint n = blocks - first;
 106:	414b87bb          	subw	a5,s7,s4
 10a:	8abe                	mv	s5,a5
    if (n > 8)
 10c:	4721                	li	a4,8
 10e:	00f77363          	bgeu	a4,a5,114 <main+0x114>
 112:	4aa1                	li	s5,8
 114:	2a81                	sext.w	s5,s5
    for (uint b = 0; b < n; b++)
 116:	006a181b          	slliw	a6,s4,0x6
 11a:	410a083b          	subw	a6,s4,a6
 11e:	0018181b          	slliw	a6,a6,0x1
 122:	0148083b          	addw	a6,a6,s4
 126:	0ff87813          	zext.b	a6,a6
    if (n > 8)
 12a:	4581                	li	a1,0
    for (uint b = 0; b < n; b++)
 12c:	4e81                	li	t4,0
  if (byte < 4)
 12e:	450d                	li	a0,3
      for (uint j = 0; j < BSIZE; j++)
 130:	40000313          	li	t1,1024
 134:	b759                	j	ba <main+0xba>
    fprintf(2, "TEST FAILURE: %s\n", why);
 136:	00001617          	auipc	a2,0x1
 13a:	b7a60613          	addi	a2,a2,-1158 # cb0 <malloc+0x13c>
 13e:	00001597          	auipc	a1,0x1
 142:	b5a58593          	addi	a1,a1,-1190 # c98 <malloc+0x124>
 146:	4509                	li	a0,2
 148:	147000ef          	jal	a8e <fprintf>
    exit(1);
 14c:	4505                	li	a0,1
 14e:	4f4000ef          	jal	642 <exit>
  }
  check(close(fd) == 0, "close written file");
 152:	855a                	mv	a0,s6
 154:	516000ef          	jal	66a <close>
  if (!ok) {
 158:	e129                	bnez	a0,19a <main+0x19a>

static inline void
verify(const char *name, uint blocks, uint seed, const struct patch *patches,
       int np)
{
  int fd = open(name, O_RDONLY);
 15a:	4581                	li	a1,0
 15c:	00001517          	auipc	a0,0x1
 160:	b1450513          	addi	a0,a0,-1260 # c70 <malloc+0xfc>
 164:	51e000ef          	jal	682 <open>
 168:	8a2a                	mv	s4,a0
  if (!ok) {
 16a:	04054663          	bltz	a0,1b6 <main+0x1b6>
  check(fstat(fd, &st) == 0 && st.size == (uint64)blocks * BSIZE,
 16e:	f9840593          	addi	a1,s0,-104
 172:	528000ef          	jal	69a <fstat>
 176:	ed31                	bnez	a0,1d2 <main+0x1d2>
  if (!ok) {
 178:	fa843703          	ld	a4,-88(s0)
 17c:	000837b7          	lui	a5,0x83
 180:	40078793          	addi	a5,a5,1024 # 83400 <base+0x803f0>
  for (uint first = 0; first < blocks;) {
 184:	4981                	li	s3,0
  if (!ok) {
 186:	04f71663          	bne	a4,a5,1d2 <main+0x1d2>
    uint n = blocks - first;
 18a:	20d00b13          	li	s6,525
    check(read(fd, fs_buffer, n * BSIZE) == n * BSIZE, "read full test data");
 18e:	00001497          	auipc	s1,0x1
 192:	e8248493          	addi	s1,s1,-382 # 1010 <fs_buffer>
  if (byte == 4)
 196:	4911                	li	s2,4
 198:	aa21                	j	2b0 <main+0x2b0>
    fprintf(2, "TEST FAILURE: %s\n", why);
 19a:	00001617          	auipc	a2,0x1
 19e:	b2e60613          	addi	a2,a2,-1234 # cc8 <malloc+0x154>
 1a2:	00001597          	auipc	a1,0x1
 1a6:	af658593          	addi	a1,a1,-1290 # c98 <malloc+0x124>
 1aa:	4509                	li	a0,2
 1ac:	0e3000ef          	jal	a8e <fprintf>
    exit(1);
 1b0:	4505                	li	a0,1
 1b2:	490000ef          	jal	642 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 1b6:	00001617          	auipc	a2,0x1
 1ba:	b2a60613          	addi	a2,a2,-1238 # ce0 <malloc+0x16c>
 1be:	00001597          	auipc	a1,0x1
 1c2:	ada58593          	addi	a1,a1,-1318 # c98 <malloc+0x124>
 1c6:	4509                	li	a0,2
 1c8:	0c7000ef          	jal	a8e <fprintf>
    exit(1);
 1cc:	4505                	li	a0,1
 1ce:	474000ef          	jal	642 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 1d2:	00001617          	auipc	a2,0x1
 1d6:	b2660613          	addi	a2,a2,-1242 # cf8 <malloc+0x184>
 1da:	00001597          	auipc	a1,0x1
 1de:	abe58593          	addi	a1,a1,-1346 # c98 <malloc+0x124>
 1e2:	4509                	li	a0,2
 1e4:	0ab000ef          	jal	a8e <fprintf>
    exit(1);
 1e8:	4505                	li	a0,1
 1ea:	458000ef          	jal	642 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 1ee:	00001617          	auipc	a2,0x1
 1f2:	b1a60613          	addi	a2,a2,-1254 # d08 <malloc+0x194>
 1f6:	00001597          	auipc	a1,0x1
 1fa:	aa258593          	addi	a1,a1,-1374 # c98 <malloc+0x124>
 1fe:	4509                	li	a0,2
 200:	08f000ef          	jal	a8e <fprintf>
    exit(1);
 204:	4505                	li	a0,1
 206:	43c000ef          	jal	642 <exit>
      for (uint j = 0; j < BSIZE; j++) {
 20a:	2745                	addiw	a4,a4,17
 20c:	0ff77713          	zext.b	a4,a4
  if (byte < 4)
 210:	04f57863          	bgeu	a0,a5,260 <main+0x260>
  if (byte == 4)
 214:	17278863          	beq	a5,s2,384 <main+0x384>
        check((uchar)fs_buffer[b * BSIZE + j] == want, "file contents differ");
 218:	00b7863b          	addw	a2,a5,a1
 21c:	1602                	slli	a2,a2,0x20
 21e:	9201                	srli	a2,a2,0x20
 220:	9626                	add	a2,a2,s1
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
 222:	00e846b3          	xor	a3,a6,a4
 226:	0116c6b3          	xor	a3,a3,a7
 22a:	fcb6c693          	xori	a3,a3,-53
  if (!ok) {
 22e:	00064603          	lbu	a2,0(a2)
 232:	0ff6f693          	zext.b	a3,a3
 236:	04d61963          	bne	a2,a3,288 <main+0x288>
      for (uint j = 0; j < BSIZE; j++) {
 23a:	2785                	addiw	a5,a5,1
 23c:	fc6797e3          	bne	a5,t1,20a <main+0x20a>
    for (uint b = 0; b < n; b++) {
 240:	2f05                	addiw	t5,t5,1
 242:	4005859b          	addiw	a1,a1,1024
 246:	f838081b          	addiw	a6,a6,-125
 24a:	0ff87813          	zext.b	a6,a6
 24e:	055f7b63          	bgeu	t5,s5,2a4 <main+0x2a4>
        uint off = (first + b) * BSIZE + j;
 252:	013f0e3b          	addw	t3,t5,s3
 256:	4701                	li	a4,0
      for (uint j = 0; j < BSIZE; j++) {
 258:	4781                	li	a5,0
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
 25a:	008e589b          	srliw	a7,t3,0x8
 25e:	bf4d                	j	210 <main+0x210>
    return (block >> (8 * byte)) & 255;
 260:	0037961b          	slliw	a2,a5,0x3
 264:	00ce563b          	srlw	a2,t3,a2
 268:	0ff67613          	zext.b	a2,a2
        check((uchar)fs_buffer[b * BSIZE + j] == want, "file contents differ");
 26c:	00b786bb          	addw	a3,a5,a1
 270:	1682                	slli	a3,a3,0x20
 272:	9281                	srli	a3,a3,0x20
 274:	96a6                	add	a3,a3,s1
  if (!ok) {
 276:	0006c683          	lbu	a3,0(a3)
 27a:	00c69763          	bne	a3,a2,288 <main+0x288>
      for (uint j = 0; j < BSIZE; j++) {
 27e:	2785                	addiw	a5,a5,1
 280:	2745                	addiw	a4,a4,17
 282:	0ff77713          	zext.b	a4,a4
 286:	b769                	j	210 <main+0x210>
    fprintf(2, "TEST FAILURE: %s\n", why);
 288:	00001617          	auipc	a2,0x1
 28c:	a9860613          	addi	a2,a2,-1384 # d20 <malloc+0x1ac>
 290:	00001597          	auipc	a1,0x1
 294:	a0858593          	addi	a1,a1,-1528 # c98 <malloc+0x124>
 298:	4509                	li	a0,2
 29a:	7f4000ef          	jal	a8e <fprintf>
    exit(1);
 29e:	4505                	li	a0,1
 2a0:	3a2000ef          	jal	642 <exit>
    first += n;
 2a4:	015989bb          	addw	s3,s3,s5
  for (uint first = 0; first < blocks;) {
 2a8:	20c00793          	li	a5,524
 2ac:	0537e563          	bltu	a5,s3,2f6 <main+0x2f6>
    uint n = blocks - first;
 2b0:	413b073b          	subw	a4,s6,s3
 2b4:	87ba                	mv	a5,a4
    if (n > 8)
 2b6:	46a1                	li	a3,8
 2b8:	00e6f363          	bgeu	a3,a4,2be <main+0x2be>
 2bc:	47a1                	li	a5,8
 2be:	00078a9b          	sext.w	s5,a5
    check(read(fd, fs_buffer, n * BSIZE) == n * BSIZE, "read full test data");
 2c2:	00a7961b          	slliw	a2,a5,0xa
 2c6:	8bb2                	mv	s7,a2
 2c8:	85a6                	mv	a1,s1
 2ca:	8552                	mv	a0,s4
 2cc:	38e000ef          	jal	65a <read>
  if (!ok) {
 2d0:	f0ab9fe3          	bne	s7,a0,1ee <main+0x1ee>
 2d4:	0069981b          	slliw	a6,s3,0x6
 2d8:	4109883b          	subw	a6,s3,a6
 2dc:	0018181b          	slliw	a6,a6,0x1
 2e0:	0138083b          	addw	a6,a6,s3
 2e4:	0ff87813          	zext.b	a6,a6
 2e8:	4581                	li	a1,0
    for (uint b = 0; b < n; b++) {
 2ea:	4f01                	li	t5,0
  if (byte < 4)
 2ec:	450d                	li	a0,3
    return seed;
 2ee:	4e9d                	li	t4,7
      for (uint j = 0; j < BSIZE; j++) {
 2f0:	40000313          	li	t1,1024
 2f4:	bfb9                	j	252 <main+0x252>
  check(read(fd, fs_buffer, 1) == 0, "EOF after exact file size");
 2f6:	4605                	li	a2,1
 2f8:	00001597          	auipc	a1,0x1
 2fc:	d1858593          	addi	a1,a1,-744 # 1010 <fs_buffer>
 300:	8552                	mv	a0,s4
 302:	358000ef          	jal	65a <read>
  if (!ok) {
 306:	e50d                	bnez	a0,330 <main+0x330>
  check(fd >= 0, "open for verification");
  verifyfd(fd, blocks, seed, patches, np);
  check(close(fd) == 0, "close verified file");
 308:	8552                	mv	a0,s4
 30a:	360000ef          	jal	66a <close>
  if (!ok) {
 30e:	ed1d                	bnez	a0,34c <main+0x34c>
  makefile("fst_small.tmp", 525, 7);
  verify("fst_small.tmp", 525, 7, 0, 0);
  check(unlink("fst_small.tmp") == 0, "remove test file");
 310:	00001517          	auipc	a0,0x1
 314:	96050513          	addi	a0,a0,-1696 # c70 <malloc+0xfc>
 318:	37a000ef          	jal	692 <unlink>
 31c:	e531                	bnez	a0,368 <main+0x368>
  printf("bigfiletest: passed\n");
 31e:	00001517          	auipc	a0,0x1
 322:	a6a50513          	addi	a0,a0,-1430 # d88 <malloc+0x214>
 326:	792000ef          	jal	ab8 <printf>
  exit(0);
 32a:	4501                	li	a0,0
 32c:	316000ef          	jal	642 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 330:	00001617          	auipc	a2,0x1
 334:	a0860613          	addi	a2,a2,-1528 # d38 <malloc+0x1c4>
 338:	00001597          	auipc	a1,0x1
 33c:	96058593          	addi	a1,a1,-1696 # c98 <malloc+0x124>
 340:	4509                	li	a0,2
 342:	74c000ef          	jal	a8e <fprintf>
    exit(1);
 346:	4505                	li	a0,1
 348:	2fa000ef          	jal	642 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 34c:	00001617          	auipc	a2,0x1
 350:	a0c60613          	addi	a2,a2,-1524 # d58 <malloc+0x1e4>
 354:	00001597          	auipc	a1,0x1
 358:	94458593          	addi	a1,a1,-1724 # c98 <malloc+0x124>
 35c:	4509                	li	a0,2
 35e:	730000ef          	jal	a8e <fprintf>
    exit(1);
 362:	4505                	li	a0,1
 364:	2de000ef          	jal	642 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 368:	00001617          	auipc	a2,0x1
 36c:	a0860613          	addi	a2,a2,-1528 # d70 <malloc+0x1fc>
 370:	00001597          	auipc	a1,0x1
 374:	92858593          	addi	a1,a1,-1752 # c98 <malloc+0x124>
 378:	4509                	li	a0,2
 37a:	714000ef          	jal	a8e <fprintf>
    exit(1);
 37e:	4505                	li	a0,1
 380:	2c2000ef          	jal	642 <exit>
    return seed;
 384:	8676                	mv	a2,t4
 386:	b5dd                	j	26c <main+0x26c>
 388:	864e                	mv	a2,s3
 38a:	b3a9                	j	d4 <main+0xd4>

000000000000038c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 38c:	1141                	addi	sp,sp,-16
 38e:	e406                	sd	ra,8(sp)
 390:	e022                	sd	s0,0(sp)
 392:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 394:	c6dff0ef          	jal	0 <main>
  exit(r);
 398:	2aa000ef          	jal	642 <exit>

000000000000039c <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 39c:	1141                	addi	sp,sp,-16
 39e:	e406                	sd	ra,8(sp)
 3a0:	e022                	sd	s0,0(sp)
 3a2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 3a4:	87aa                	mv	a5,a0
 3a6:	0585                	addi	a1,a1,1
 3a8:	0785                	addi	a5,a5,1
 3aa:	fff5c703          	lbu	a4,-1(a1)
 3ae:	fee78fa3          	sb	a4,-1(a5)
 3b2:	fb75                	bnez	a4,3a6 <strcpy+0xa>
    ;
  return os;
}
 3b4:	60a2                	ld	ra,8(sp)
 3b6:	6402                	ld	s0,0(sp)
 3b8:	0141                	addi	sp,sp,16
 3ba:	8082                	ret

00000000000003bc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3bc:	1141                	addi	sp,sp,-16
 3be:	e406                	sd	ra,8(sp)
 3c0:	e022                	sd	s0,0(sp)
 3c2:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 3c4:	00054783          	lbu	a5,0(a0)
 3c8:	cb91                	beqz	a5,3dc <strcmp+0x20>
 3ca:	0005c703          	lbu	a4,0(a1)
 3ce:	00f71763          	bne	a4,a5,3dc <strcmp+0x20>
    p++, q++;
 3d2:	0505                	addi	a0,a0,1
 3d4:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 3d6:	00054783          	lbu	a5,0(a0)
 3da:	fbe5                	bnez	a5,3ca <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 3dc:	0005c503          	lbu	a0,0(a1)
}
 3e0:	40a7853b          	subw	a0,a5,a0
 3e4:	60a2                	ld	ra,8(sp)
 3e6:	6402                	ld	s0,0(sp)
 3e8:	0141                	addi	sp,sp,16
 3ea:	8082                	ret

00000000000003ec <strlen>:

uint
strlen(const char *s)
{
 3ec:	1141                	addi	sp,sp,-16
 3ee:	e406                	sd	ra,8(sp)
 3f0:	e022                	sd	s0,0(sp)
 3f2:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 3f4:	00054783          	lbu	a5,0(a0)
 3f8:	cf91                	beqz	a5,414 <strlen+0x28>
 3fa:	00150793          	addi	a5,a0,1
 3fe:	86be                	mv	a3,a5
 400:	0785                	addi	a5,a5,1
 402:	fff7c703          	lbu	a4,-1(a5)
 406:	ff65                	bnez	a4,3fe <strlen+0x12>
 408:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 40c:	60a2                	ld	ra,8(sp)
 40e:	6402                	ld	s0,0(sp)
 410:	0141                	addi	sp,sp,16
 412:	8082                	ret
  for (n = 0; s[n]; n++)
 414:	4501                	li	a0,0
 416:	bfdd                	j	40c <strlen+0x20>

0000000000000418 <memset>:

void *
memset(void *dst, int c, uint n)
{
 418:	1141                	addi	sp,sp,-16
 41a:	e406                	sd	ra,8(sp)
 41c:	e022                	sd	s0,0(sp)
 41e:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 420:	ca19                	beqz	a2,436 <memset+0x1e>
 422:	87aa                	mv	a5,a0
 424:	1602                	slli	a2,a2,0x20
 426:	9201                	srli	a2,a2,0x20
 428:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 42c:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 430:	0785                	addi	a5,a5,1
 432:	fee79de3          	bne	a5,a4,42c <memset+0x14>
  }
  return dst;
}
 436:	60a2                	ld	ra,8(sp)
 438:	6402                	ld	s0,0(sp)
 43a:	0141                	addi	sp,sp,16
 43c:	8082                	ret

000000000000043e <strchr>:

char *
strchr(const char *s, char c)
{
 43e:	1141                	addi	sp,sp,-16
 440:	e406                	sd	ra,8(sp)
 442:	e022                	sd	s0,0(sp)
 444:	0800                	addi	s0,sp,16
  for (; *s; s++)
 446:	00054783          	lbu	a5,0(a0)
 44a:	c799                	beqz	a5,458 <strchr+0x1a>
    if (*s == c)
 44c:	00f58763          	beq	a1,a5,45a <strchr+0x1c>
  for (; *s; s++)
 450:	0505                	addi	a0,a0,1
 452:	00054783          	lbu	a5,0(a0)
 456:	fbfd                	bnez	a5,44c <strchr+0xe>
      return (char *)s;
  return 0;
 458:	4501                	li	a0,0
}
 45a:	60a2                	ld	ra,8(sp)
 45c:	6402                	ld	s0,0(sp)
 45e:	0141                	addi	sp,sp,16
 460:	8082                	ret

0000000000000462 <gets>:

char *
gets(char *buf, int max)
{
 462:	711d                	addi	sp,sp,-96
 464:	ec86                	sd	ra,88(sp)
 466:	e8a2                	sd	s0,80(sp)
 468:	e4a6                	sd	s1,72(sp)
 46a:	e0ca                	sd	s2,64(sp)
 46c:	fc4e                	sd	s3,56(sp)
 46e:	f852                	sd	s4,48(sp)
 470:	f456                	sd	s5,40(sp)
 472:	f05a                	sd	s6,32(sp)
 474:	ec5e                	sd	s7,24(sp)
 476:	e862                	sd	s8,16(sp)
 478:	1080                	addi	s0,sp,96
 47a:	8baa                	mv	s7,a0
 47c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 47e:	892a                	mv	s2,a0
 480:	4481                	li	s1,0
    cc = read(0, &c, 1);
 482:	faf40b13          	addi	s6,s0,-81
 486:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;) {
 488:	8c26                	mv	s8,s1
 48a:	0014899b          	addiw	s3,s1,1
 48e:	84ce                	mv	s1,s3
 490:	0349d863          	bge	s3,s4,4c0 <gets+0x5e>
    cc = read(0, &c, 1);
 494:	8656                	mv	a2,s5
 496:	85da                	mv	a1,s6
 498:	4501                	li	a0,0
 49a:	1c0000ef          	jal	65a <read>
    if (cc < 1)
 49e:	02a05163          	blez	a0,4c0 <gets+0x5e>
      break;
    buf[i++] = c;
 4a2:	faf44783          	lbu	a5,-81(s0)
 4a6:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 4aa:	0905                	addi	s2,s2,1
 4ac:	ff678713          	addi	a4,a5,-10
 4b0:	00173713          	seqz	a4,a4
 4b4:	17cd                	addi	a5,a5,-13
 4b6:	0017b793          	seqz	a5,a5
 4ba:	8fd9                	or	a5,a5,a4
 4bc:	d7f1                	beqz	a5,488 <gets+0x26>
    buf[i++] = c;
 4be:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 4c0:	9c5e                	add	s8,s8,s7
 4c2:	000c0023          	sb	zero,0(s8)
  return buf;
}
 4c6:	855e                	mv	a0,s7
 4c8:	60e6                	ld	ra,88(sp)
 4ca:	6446                	ld	s0,80(sp)
 4cc:	64a6                	ld	s1,72(sp)
 4ce:	6906                	ld	s2,64(sp)
 4d0:	79e2                	ld	s3,56(sp)
 4d2:	7a42                	ld	s4,48(sp)
 4d4:	7aa2                	ld	s5,40(sp)
 4d6:	7b02                	ld	s6,32(sp)
 4d8:	6be2                	ld	s7,24(sp)
 4da:	6c42                	ld	s8,16(sp)
 4dc:	6125                	addi	sp,sp,96
 4de:	8082                	ret

00000000000004e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4e0:	1101                	addi	sp,sp,-32
 4e2:	ec06                	sd	ra,24(sp)
 4e4:	e822                	sd	s0,16(sp)
 4e6:	e04a                	sd	s2,0(sp)
 4e8:	1000                	addi	s0,sp,32
 4ea:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4ec:	4581                	li	a1,0
 4ee:	194000ef          	jal	682 <open>
  if (fd < 0)
 4f2:	02054263          	bltz	a0,516 <stat+0x36>
 4f6:	e426                	sd	s1,8(sp)
 4f8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4fa:	85ca                	mv	a1,s2
 4fc:	19e000ef          	jal	69a <fstat>
 500:	892a                	mv	s2,a0
  close(fd);
 502:	8526                	mv	a0,s1
 504:	166000ef          	jal	66a <close>
  return r;
 508:	64a2                	ld	s1,8(sp)
}
 50a:	854a                	mv	a0,s2
 50c:	60e2                	ld	ra,24(sp)
 50e:	6442                	ld	s0,16(sp)
 510:	6902                	ld	s2,0(sp)
 512:	6105                	addi	sp,sp,32
 514:	8082                	ret
    return -1;
 516:	57fd                	li	a5,-1
 518:	893e                	mv	s2,a5
 51a:	bfc5                	j	50a <stat+0x2a>

000000000000051c <atoi>:

int
atoi(const char *s)
{
 51c:	1141                	addi	sp,sp,-16
 51e:	e406                	sd	ra,8(sp)
 520:	e022                	sd	s0,0(sp)
 522:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 524:	00054683          	lbu	a3,0(a0)
 528:	fd06879b          	addiw	a5,a3,-48
 52c:	0ff7f793          	zext.b	a5,a5
 530:	4625                	li	a2,9
 532:	02f66963          	bltu	a2,a5,564 <atoi+0x48>
 536:	872a                	mv	a4,a0
  n = 0;
 538:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 53a:	0705                	addi	a4,a4,1
 53c:	0025179b          	slliw	a5,a0,0x2
 540:	9fa9                	addw	a5,a5,a0
 542:	0017979b          	slliw	a5,a5,0x1
 546:	9fb5                	addw	a5,a5,a3
 548:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 54c:	00074683          	lbu	a3,0(a4)
 550:	fd06879b          	addiw	a5,a3,-48
 554:	0ff7f793          	zext.b	a5,a5
 558:	fef671e3          	bgeu	a2,a5,53a <atoi+0x1e>
  return n;
}
 55c:	60a2                	ld	ra,8(sp)
 55e:	6402                	ld	s0,0(sp)
 560:	0141                	addi	sp,sp,16
 562:	8082                	ret
  n = 0;
 564:	4501                	li	a0,0
 566:	bfdd                	j	55c <atoi+0x40>

0000000000000568 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 568:	1141                	addi	sp,sp,-16
 56a:	e406                	sd	ra,8(sp)
 56c:	e022                	sd	s0,0(sp)
 56e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 570:	02b57563          	bgeu	a0,a1,59a <memmove+0x32>
    while (n-- > 0)
 574:	00c05f63          	blez	a2,592 <memmove+0x2a>
 578:	1602                	slli	a2,a2,0x20
 57a:	9201                	srli	a2,a2,0x20
 57c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 580:	872a                	mv	a4,a0
      *dst++ = *src++;
 582:	0585                	addi	a1,a1,1
 584:	0705                	addi	a4,a4,1
 586:	fff5c683          	lbu	a3,-1(a1)
 58a:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 58e:	fee79ae3          	bne	a5,a4,582 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 592:	60a2                	ld	ra,8(sp)
 594:	6402                	ld	s0,0(sp)
 596:	0141                	addi	sp,sp,16
 598:	8082                	ret
    while (n-- > 0)
 59a:	fec05ce3          	blez	a2,592 <memmove+0x2a>
    dst += n;
 59e:	00c50733          	add	a4,a0,a2
    src += n;
 5a2:	95b2                	add	a1,a1,a2
 5a4:	fff6079b          	addiw	a5,a2,-1
 5a8:	1782                	slli	a5,a5,0x20
 5aa:	9381                	srli	a5,a5,0x20
 5ac:	fff7c793          	not	a5,a5
 5b0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 5b2:	15fd                	addi	a1,a1,-1
 5b4:	177d                	addi	a4,a4,-1
 5b6:	0005c683          	lbu	a3,0(a1)
 5ba:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 5be:	fef71ae3          	bne	a4,a5,5b2 <memmove+0x4a>
 5c2:	bfc1                	j	592 <memmove+0x2a>

00000000000005c4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 5c4:	1141                	addi	sp,sp,-16
 5c6:	e406                	sd	ra,8(sp)
 5c8:	e022                	sd	s0,0(sp)
 5ca:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 5cc:	ce19                	beqz	a2,5ea <memcmp+0x26>
 5ce:	1602                	slli	a2,a2,0x20
 5d0:	9201                	srli	a2,a2,0x20
 5d2:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 5d6:	00054783          	lbu	a5,0(a0)
 5da:	0005c703          	lbu	a4,0(a1)
 5de:	00e79b63          	bne	a5,a4,5f4 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 5e2:	0505                	addi	a0,a0,1
    p2++;
 5e4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 5e6:	fed518e3          	bne	a0,a3,5d6 <memcmp+0x12>
  }
  return 0;
 5ea:	4501                	li	a0,0
}
 5ec:	60a2                	ld	ra,8(sp)
 5ee:	6402                	ld	s0,0(sp)
 5f0:	0141                	addi	sp,sp,16
 5f2:	8082                	ret
      return *p1 - *p2;
 5f4:	40e7853b          	subw	a0,a5,a4
 5f8:	bfd5                	j	5ec <memcmp+0x28>

00000000000005fa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5fa:	1141                	addi	sp,sp,-16
 5fc:	e406                	sd	ra,8(sp)
 5fe:	e022                	sd	s0,0(sp)
 600:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 602:	f67ff0ef          	jal	568 <memmove>
}
 606:	60a2                	ld	ra,8(sp)
 608:	6402                	ld	s0,0(sp)
 60a:	0141                	addi	sp,sp,16
 60c:	8082                	ret

000000000000060e <sbrk>:

char *
sbrk(int n)
{
 60e:	1141                	addi	sp,sp,-16
 610:	e406                	sd	ra,8(sp)
 612:	e022                	sd	s0,0(sp)
 614:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 616:	4585                	li	a1,1
 618:	0b2000ef          	jal	6ca <sys_sbrk>
}
 61c:	60a2                	ld	ra,8(sp)
 61e:	6402                	ld	s0,0(sp)
 620:	0141                	addi	sp,sp,16
 622:	8082                	ret

0000000000000624 <sbrklazy>:

char *
sbrklazy(int n)
{
 624:	1141                	addi	sp,sp,-16
 626:	e406                	sd	ra,8(sp)
 628:	e022                	sd	s0,0(sp)
 62a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 62c:	4589                	li	a1,2
 62e:	09c000ef          	jal	6ca <sys_sbrk>
}
 632:	60a2                	ld	ra,8(sp)
 634:	6402                	ld	s0,0(sp)
 636:	0141                	addi	sp,sp,16
 638:	8082                	ret

000000000000063a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 63a:	4885                	li	a7,1
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <exit>:
.global exit
exit:
 li a7, SYS_exit
 642:	4889                	li	a7,2
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <wait>:
.global wait
wait:
 li a7, SYS_wait
 64a:	488d                	li	a7,3
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 652:	4891                	li	a7,4
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <read>:
.global read
read:
 li a7, SYS_read
 65a:	4895                	li	a7,5
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <write>:
.global write
write:
 li a7, SYS_write
 662:	48c1                	li	a7,16
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <close>:
.global close
close:
 li a7, SYS_close
 66a:	48d5                	li	a7,21
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <kill>:
.global kill
kill:
 li a7, SYS_kill
 672:	4899                	li	a7,6
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <exec>:
.global exec
exec:
 li a7, SYS_exec
 67a:	489d                	li	a7,7
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <open>:
.global open
open:
 li a7, SYS_open
 682:	48bd                	li	a7,15
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 68a:	48c5                	li	a7,17
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 692:	48c9                	li	a7,18
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 69a:	48a1                	li	a7,8
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <link>:
.global link
link:
 li a7, SYS_link
 6a2:	48cd                	li	a7,19
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6aa:	48d1                	li	a7,20
 ecall
 6ac:	00000073          	ecall
 ret
 6b0:	8082                	ret

00000000000006b2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6b2:	48a5                	li	a7,9
 ecall
 6b4:	00000073          	ecall
 ret
 6b8:	8082                	ret

00000000000006ba <dup>:
.global dup
dup:
 li a7, SYS_dup
 6ba:	48a9                	li	a7,10
 ecall
 6bc:	00000073          	ecall
 ret
 6c0:	8082                	ret

00000000000006c2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6c2:	48ad                	li	a7,11
 ecall
 6c4:	00000073          	ecall
 ret
 6c8:	8082                	ret

00000000000006ca <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 6ca:	48b1                	li	a7,12
 ecall
 6cc:	00000073          	ecall
 ret
 6d0:	8082                	ret

00000000000006d2 <pause>:
.global pause
pause:
 li a7, SYS_pause
 6d2:	48b5                	li	a7,13
 ecall
 6d4:	00000073          	ecall
 ret
 6d8:	8082                	ret

00000000000006da <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6da:	48b9                	li	a7,14
 ecall
 6dc:	00000073          	ecall
 ret
 6e0:	8082                	ret

00000000000006e2 <sync>:
.global sync
sync:
 li a7, SYS_sync
 6e2:	48d9                	li	a7,22
 ecall
 6e4:	00000073          	ecall
 ret
 6e8:	8082                	ret

00000000000006ea <istat>:
.global istat
istat:
 li a7, SYS_istat
 6ea:	48dd                	li	a7,23
 ecall
 6ec:	00000073          	ecall
 ret
 6f0:	8082                	ret

00000000000006f2 <iprint>:
.global iprint
iprint:
 li a7, SYS_iprint
 6f2:	48e1                	li	a7,24
 ecall
 6f4:	00000073          	ecall
 ret
 6f8:	8082                	ret

00000000000006fa <symlink>:
.global symlink
symlink:
 li a7, SYS_symlink
 6fa:	48e5                	li	a7,25
 ecall
 6fc:	00000073          	ecall
 ret
 700:	8082                	ret

0000000000000702 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 702:	1101                	addi	sp,sp,-32
 704:	ec06                	sd	ra,24(sp)
 706:	e822                	sd	s0,16(sp)
 708:	1000                	addi	s0,sp,32
 70a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 70e:	4605                	li	a2,1
 710:	fef40593          	addi	a1,s0,-17
 714:	f4fff0ef          	jal	662 <write>
}
 718:	60e2                	ld	ra,24(sp)
 71a:	6442                	ld	s0,16(sp)
 71c:	6105                	addi	sp,sp,32
 71e:	8082                	ret

0000000000000720 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 720:	715d                	addi	sp,sp,-80
 722:	e486                	sd	ra,72(sp)
 724:	e0a2                	sd	s0,64(sp)
 726:	f84a                	sd	s2,48(sp)
 728:	f44e                	sd	s3,40(sp)
 72a:	0880                	addi	s0,sp,80
 72c:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 72e:	00d036b3          	snez	a3,a3
 732:	03f5d793          	srli	a5,a1,0x3f
 736:	8efd                	and	a3,a3,a5
  neg = 0;
 738:	4301                	li	t1,0
  if (sgn && xx < 0) {
 73a:	c681                	beqz	a3,742 <printint+0x22>
    neg = 1;
    x = -xx;
 73c:	40b005b3          	neg	a1,a1
    neg = 1;
 740:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 742:	fb840993          	addi	s3,s0,-72
  neg = 0;
 746:	86ce                	mv	a3,s3
  i = 0;
 748:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
 74a:	00000817          	auipc	a6,0x0
 74e:	65e80813          	addi	a6,a6,1630 # da8 <digits>
 752:	88ba                	mv	a7,a4
 754:	0017051b          	addiw	a0,a4,1
 758:	872a                	mv	a4,a0
 75a:	02c5f7b3          	remu	a5,a1,a2
 75e:	97c2                	add	a5,a5,a6
 760:	0007c783          	lbu	a5,0(a5)
 764:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
 768:	87ae                	mv	a5,a1
 76a:	02c5d5b3          	divu	a1,a1,a2
 76e:	0685                	addi	a3,a3,1
 770:	fec7f1e3          	bgeu	a5,a2,752 <printint+0x32>
  if (neg)
 774:	00030b63          	beqz	t1,78a <printint+0x6a>
    buf[i++] = '-';
 778:	fd040793          	addi	a5,s0,-48
 77c:	953e                	add	a0,a0,a5
 77e:	02d00793          	li	a5,45
 782:	fef50423          	sb	a5,-24(a0)
 786:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
 78a:	02e05563          	blez	a4,7b4 <printint+0x94>
 78e:	fc26                	sd	s1,56(sp)
 790:	377d                	addiw	a4,a4,-1
 792:	00e984b3          	add	s1,s3,a4
 796:	19fd                	addi	s3,s3,-1
 798:	99ba                	add	s3,s3,a4
 79a:	1702                	slli	a4,a4,0x20
 79c:	9301                	srli	a4,a4,0x20
 79e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7a2:	0004c583          	lbu	a1,0(s1)
 7a6:	854a                	mv	a0,s2
 7a8:	f5bff0ef          	jal	702 <putc>
  while (--i >= 0)
 7ac:	14fd                	addi	s1,s1,-1
 7ae:	ff349ae3          	bne	s1,s3,7a2 <printint+0x82>
 7b2:	74e2                	ld	s1,56(sp)
}
 7b4:	60a6                	ld	ra,72(sp)
 7b6:	6406                	ld	s0,64(sp)
 7b8:	7942                	ld	s2,48(sp)
 7ba:	79a2                	ld	s3,40(sp)
 7bc:	6161                	addi	sp,sp,80
 7be:	8082                	ret

00000000000007c0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7c0:	711d                	addi	sp,sp,-96
 7c2:	ec86                	sd	ra,88(sp)
 7c4:	e8a2                	sd	s0,80(sp)
 7c6:	e4a6                	sd	s1,72(sp)
 7c8:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 7ca:	0005c483          	lbu	s1,0(a1)
 7ce:	2a048063          	beqz	s1,a6e <vprintf+0x2ae>
 7d2:	e0ca                	sd	s2,64(sp)
 7d4:	fc4e                	sd	s3,56(sp)
 7d6:	f852                	sd	s4,48(sp)
 7d8:	f456                	sd	s5,40(sp)
 7da:	f05a                	sd	s6,32(sp)
 7dc:	ec5e                	sd	s7,24(sp)
 7de:	e862                	sd	s8,16(sp)
 7e0:	8b2a                	mv	s6,a0
 7e2:	8a2e                	mv	s4,a1
 7e4:	8bb2                	mv	s7,a2
  state = 0;
 7e6:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 7e8:	4901                	li	s2,0
 7ea:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 7ec:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 7f0:	06400c13          	li	s8,100
 7f4:	a00d                	j	816 <vprintf+0x56>
        putc(fd, c0);
 7f6:	85a6                	mv	a1,s1
 7f8:	855a                	mv	a0,s6
 7fa:	f09ff0ef          	jal	702 <putc>
 7fe:	a019                	j	804 <vprintf+0x44>
    } else if (state == '%') {
 800:	03598363          	beq	s3,s5,826 <vprintf+0x66>
  for (i = 0; fmt[i]; i++) {
 804:	0019079b          	addiw	a5,s2,1
 808:	893e                	mv	s2,a5
 80a:	873e                	mv	a4,a5
 80c:	97d2                	add	a5,a5,s4
 80e:	0007c483          	lbu	s1,0(a5)
 812:	24048763          	beqz	s1,a60 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 816:	0004879b          	sext.w	a5,s1
    if (state == 0) {
 81a:	fe0993e3          	bnez	s3,800 <vprintf+0x40>
      if (c0 == '%') {
 81e:	fd579ce3          	bne	a5,s5,7f6 <vprintf+0x36>
        state = '%';
 822:	89be                	mv	s3,a5
 824:	b7c5                	j	804 <vprintf+0x44>
        c1 = fmt[i + 1] & 0xff;
 826:	00ea06b3          	add	a3,s4,a4
 82a:	0016c603          	lbu	a2,1(a3)
      if (c1)
 82e:	24060563          	beqz	a2,a78 <vprintf+0x2b8>
      if (c0 == 'd') {
 832:	0b878763          	beq	a5,s8,8e0 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 836:	f9478693          	addi	a3,a5,-108
 83a:	0016b693          	seqz	a3,a3
 83e:	f9c60593          	addi	a1,a2,-100
 842:	0015b593          	seqz	a1,a1
 846:	8df5                	and	a1,a1,a3
 848:	e9c5                	bnez	a1,8f8 <vprintf+0x138>
        c2 = fmt[i + 2] & 0xff;
 84a:	9752                	add	a4,a4,s4
 84c:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 850:	f9460713          	addi	a4,a2,-108
 854:	00173713          	seqz	a4,a4
 858:	8f75                	and	a4,a4,a3
 85a:	f9c50593          	addi	a1,a0,-100
 85e:	0015b593          	seqz	a1,a1
 862:	8df9                	and	a1,a1,a4
 864:	e5dd                	bnez	a1,912 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 866:	07500593          	li	a1,117
 86a:	0cb78163          	beq	a5,a1,92c <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if (c0 == 'l' && c1 == 'u') {
 86e:	f8b60593          	addi	a1,a2,-117
 872:	0015b593          	seqz	a1,a1
 876:	8df5                	and	a1,a1,a3
 878:	e5f1                	bnez	a1,944 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 87a:	f8b50593          	addi	a1,a0,-117
 87e:	0015b593          	seqz	a1,a1
 882:	8df9                	and	a1,a1,a4
 884:	ede9                	bnez	a1,95e <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 886:	07800593          	li	a1,120
 88a:	0eb78763          	beq	a5,a1,978 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if (c0 == 'l' && c1 == 'x') {
 88e:	f8860613          	addi	a2,a2,-120
 892:	00163613          	seqz	a2,a2
 896:	8ef1                	and	a3,a3,a2
 898:	0e069c63          	bnez	a3,990 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 89c:	f8850513          	addi	a0,a0,-120
 8a0:	00153513          	seqz	a0,a0
 8a4:	8f69                	and	a4,a4,a0
 8a6:	10071263          	bnez	a4,9aa <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 8aa:	07000713          	li	a4,112
 8ae:	10e78a63          	beq	a5,a4,9c2 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 8b2:	06300713          	li	a4,99
 8b6:	14e78a63          	beq	a5,a4,a0a <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 8ba:	07300713          	li	a4,115
 8be:	16e78063          	beq	a5,a4,a1e <vprintf+0x25e>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 8c2:	02500713          	li	a4,37
 8c6:	18e78863          	beq	a5,a4,a56 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8ca:	02500593          	li	a1,37
 8ce:	855a                	mv	a0,s6
 8d0:	e33ff0ef          	jal	702 <putc>
        putc(fd, c0);
 8d4:	85a6                	mv	a1,s1
 8d6:	855a                	mv	a0,s6
 8d8:	e2bff0ef          	jal	702 <putc>
      }

      state = 0;
 8dc:	4981                	li	s3,0
 8de:	b71d                	j	804 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 8e0:	008b8493          	addi	s1,s7,8
 8e4:	4685                	li	a3,1
 8e6:	4629                	li	a2,10
 8e8:	000ba583          	lw	a1,0(s7)
 8ec:	855a                	mv	a0,s6
 8ee:	e33ff0ef          	jal	720 <printint>
 8f2:	8ba6                	mv	s7,s1
      state = 0;
 8f4:	4981                	li	s3,0
 8f6:	b739                	j	804 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8f8:	008b8493          	addi	s1,s7,8
 8fc:	4685                	li	a3,1
 8fe:	4629                	li	a2,10
 900:	000bb583          	ld	a1,0(s7)
 904:	855a                	mv	a0,s6
 906:	e1bff0ef          	jal	720 <printint>
        i += 1;
 90a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 90c:	8ba6                	mv	s7,s1
      state = 0;
 90e:	4981                	li	s3,0
 910:	bdd5                	j	804 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 912:	008b8493          	addi	s1,s7,8
 916:	4685                	li	a3,1
 918:	4629                	li	a2,10
 91a:	000bb583          	ld	a1,0(s7)
 91e:	855a                	mv	a0,s6
 920:	e01ff0ef          	jal	720 <printint>
        i += 2;
 924:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 926:	8ba6                	mv	s7,s1
      state = 0;
 928:	4981                	li	s3,0
        i += 2;
 92a:	bde9                	j	804 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 92c:	008b8493          	addi	s1,s7,8
 930:	4681                	li	a3,0
 932:	4629                	li	a2,10
 934:	000be583          	lwu	a1,0(s7)
 938:	855a                	mv	a0,s6
 93a:	de7ff0ef          	jal	720 <printint>
 93e:	8ba6                	mv	s7,s1
      state = 0;
 940:	4981                	li	s3,0
 942:	b5c9                	j	804 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 944:	008b8493          	addi	s1,s7,8
 948:	4681                	li	a3,0
 94a:	4629                	li	a2,10
 94c:	000bb583          	ld	a1,0(s7)
 950:	855a                	mv	a0,s6
 952:	dcfff0ef          	jal	720 <printint>
        i += 1;
 956:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 958:	8ba6                	mv	s7,s1
      state = 0;
 95a:	4981                	li	s3,0
 95c:	b565                	j	804 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 95e:	008b8493          	addi	s1,s7,8
 962:	4681                	li	a3,0
 964:	4629                	li	a2,10
 966:	000bb583          	ld	a1,0(s7)
 96a:	855a                	mv	a0,s6
 96c:	db5ff0ef          	jal	720 <printint>
        i += 2;
 970:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 972:	8ba6                	mv	s7,s1
      state = 0;
 974:	4981                	li	s3,0
        i += 2;
 976:	b579                	j	804 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 978:	008b8493          	addi	s1,s7,8
 97c:	4681                	li	a3,0
 97e:	4641                	li	a2,16
 980:	000be583          	lwu	a1,0(s7)
 984:	855a                	mv	a0,s6
 986:	d9bff0ef          	jal	720 <printint>
 98a:	8ba6                	mv	s7,s1
      state = 0;
 98c:	4981                	li	s3,0
 98e:	bd9d                	j	804 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 990:	008b8493          	addi	s1,s7,8
 994:	4681                	li	a3,0
 996:	4641                	li	a2,16
 998:	000bb583          	ld	a1,0(s7)
 99c:	855a                	mv	a0,s6
 99e:	d83ff0ef          	jal	720 <printint>
        i += 1;
 9a2:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 9a4:	8ba6                	mv	s7,s1
      state = 0;
 9a6:	4981                	li	s3,0
 9a8:	bdb1                	j	804 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 9aa:	008b8493          	addi	s1,s7,8
 9ae:	4641                	li	a2,16
 9b0:	000bb583          	ld	a1,0(s7)
 9b4:	855a                	mv	a0,s6
 9b6:	d6bff0ef          	jal	720 <printint>
        i += 2;
 9ba:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 9bc:	8ba6                	mv	s7,s1
      state = 0;
 9be:	4981                	li	s3,0
        i += 2;
 9c0:	b591                	j	804 <vprintf+0x44>
 9c2:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 9c4:	008b8793          	addi	a5,s7,8
 9c8:	8cbe                	mv	s9,a5
 9ca:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9ce:	03000593          	li	a1,48
 9d2:	855a                	mv	a0,s6
 9d4:	d2fff0ef          	jal	702 <putc>
  putc(fd, 'x');
 9d8:	07800593          	li	a1,120
 9dc:	855a                	mv	a0,s6
 9de:	d25ff0ef          	jal	702 <putc>
 9e2:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9e4:	00000b97          	auipc	s7,0x0
 9e8:	3c4b8b93          	addi	s7,s7,964 # da8 <digits>
 9ec:	03c9d793          	srli	a5,s3,0x3c
 9f0:	97de                	add	a5,a5,s7
 9f2:	0007c583          	lbu	a1,0(a5)
 9f6:	855a                	mv	a0,s6
 9f8:	d0bff0ef          	jal	702 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9fc:	0992                	slli	s3,s3,0x4
 9fe:	34fd                	addiw	s1,s1,-1
 a00:	f4f5                	bnez	s1,9ec <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 a02:	8be6                	mv	s7,s9
      state = 0;
 a04:	4981                	li	s3,0
 a06:	6ca2                	ld	s9,8(sp)
 a08:	bbf5                	j	804 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 a0a:	008b8493          	addi	s1,s7,8
 a0e:	000bc583          	lbu	a1,0(s7)
 a12:	855a                	mv	a0,s6
 a14:	cefff0ef          	jal	702 <putc>
 a18:	8ba6                	mv	s7,s1
      state = 0;
 a1a:	4981                	li	s3,0
 a1c:	b3e5                	j	804 <vprintf+0x44>
        if ((s = va_arg(ap, char *)) == 0)
 a1e:	008b8993          	addi	s3,s7,8
 a22:	000bb483          	ld	s1,0(s7)
 a26:	cc91                	beqz	s1,a42 <vprintf+0x282>
        for (; *s; s++)
 a28:	0004c583          	lbu	a1,0(s1)
 a2c:	c195                	beqz	a1,a50 <vprintf+0x290>
          putc(fd, *s);
 a2e:	855a                	mv	a0,s6
 a30:	cd3ff0ef          	jal	702 <putc>
        for (; *s; s++)
 a34:	0485                	addi	s1,s1,1
 a36:	0004c583          	lbu	a1,0(s1)
 a3a:	f9f5                	bnez	a1,a2e <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 a3c:	8bce                	mv	s7,s3
      state = 0;
 a3e:	4981                	li	s3,0
 a40:	b3d1                	j	804 <vprintf+0x44>
          s = "(null)";
 a42:	00000497          	auipc	s1,0x0
 a46:	35e48493          	addi	s1,s1,862 # da0 <malloc+0x22c>
        for (; *s; s++)
 a4a:	02800593          	li	a1,40
 a4e:	b7c5                	j	a2e <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 a50:	8bce                	mv	s7,s3
      state = 0;
 a52:	4981                	li	s3,0
 a54:	bb45                	j	804 <vprintf+0x44>
        putc(fd, '%');
 a56:	85be                	mv	a1,a5
 a58:	855a                	mv	a0,s6
 a5a:	ca9ff0ef          	jal	702 <putc>
 a5e:	bdbd                	j	8dc <vprintf+0x11c>
 a60:	6906                	ld	s2,64(sp)
 a62:	79e2                	ld	s3,56(sp)
 a64:	7a42                	ld	s4,48(sp)
 a66:	7aa2                	ld	s5,40(sp)
 a68:	7b02                	ld	s6,32(sp)
 a6a:	6be2                	ld	s7,24(sp)
 a6c:	6c42                	ld	s8,16(sp)
    }
  }
}
 a6e:	60e6                	ld	ra,88(sp)
 a70:	6446                	ld	s0,80(sp)
 a72:	64a6                	ld	s1,72(sp)
 a74:	6125                	addi	sp,sp,96
 a76:	8082                	ret
      if (c0 == 'd') {
 a78:	06400713          	li	a4,100
 a7c:	e6e782e3          	beq	a5,a4,8e0 <vprintf+0x120>
      } else if (c0 == 'l' && c1 == 'd') {
 a80:	f9478693          	addi	a3,a5,-108
 a84:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 a88:	8532                	mv	a0,a2
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 a8a:	4701                	li	a4,0
 a8c:	bbe9                	j	866 <vprintf+0xa6>

0000000000000a8e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a8e:	715d                	addi	sp,sp,-80
 a90:	ec06                	sd	ra,24(sp)
 a92:	e822                	sd	s0,16(sp)
 a94:	1000                	addi	s0,sp,32
 a96:	e010                	sd	a2,0(s0)
 a98:	e414                	sd	a3,8(s0)
 a9a:	e818                	sd	a4,16(s0)
 a9c:	ec1c                	sd	a5,24(s0)
 a9e:	03043023          	sd	a6,32(s0)
 aa2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 aa6:	8622                	mv	a2,s0
 aa8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 aac:	d15ff0ef          	jal	7c0 <vprintf>
}
 ab0:	60e2                	ld	ra,24(sp)
 ab2:	6442                	ld	s0,16(sp)
 ab4:	6161                	addi	sp,sp,80
 ab6:	8082                	ret

0000000000000ab8 <printf>:

void
printf(const char *fmt, ...)
{
 ab8:	711d                	addi	sp,sp,-96
 aba:	ec06                	sd	ra,24(sp)
 abc:	e822                	sd	s0,16(sp)
 abe:	1000                	addi	s0,sp,32
 ac0:	e40c                	sd	a1,8(s0)
 ac2:	e810                	sd	a2,16(s0)
 ac4:	ec14                	sd	a3,24(s0)
 ac6:	f018                	sd	a4,32(s0)
 ac8:	f41c                	sd	a5,40(s0)
 aca:	03043823          	sd	a6,48(s0)
 ace:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ad2:	00840613          	addi	a2,s0,8
 ad6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 ada:	85aa                	mv	a1,a0
 adc:	4505                	li	a0,1
 ade:	ce3ff0ef          	jal	7c0 <vprintf>
}
 ae2:	60e2                	ld	ra,24(sp)
 ae4:	6442                	ld	s0,16(sp)
 ae6:	6125                	addi	sp,sp,96
 ae8:	8082                	ret

0000000000000aea <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 aea:	1141                	addi	sp,sp,-16
 aec:	e406                	sd	ra,8(sp)
 aee:	e022                	sd	s0,0(sp)
 af0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 af2:	ff050713          	addi	a4,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af6:	00000797          	auipc	a5,0x0
 afa:	50a7b783          	ld	a5,1290(a5) # 1000 <freep>
 afe:	a095                	j	b62 <free+0x78>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
 b00:	ff852583          	lw	a1,-8(a0)
 b04:	6390                	ld	a2,0(a5)
 b06:	02059813          	slli	a6,a1,0x20
 b0a:	01c85693          	srli	a3,a6,0x1c
 b0e:	96ba                	add	a3,a3,a4
 b10:	02d60563          	beq	a2,a3,b3a <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 b14:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
 b18:	4790                	lw	a2,8(a5)
 b1a:	02061593          	slli	a1,a2,0x20
 b1e:	01c5d693          	srli	a3,a1,0x1c
 b22:	96be                	add	a3,a3,a5
 b24:	02d70263          	beq	a4,a3,b48 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 b28:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b2a:	00000717          	auipc	a4,0x0
 b2e:	4cf73b23          	sd	a5,1238(a4) # 1000 <freep>
}
 b32:	60a2                	ld	ra,8(sp)
 b34:	6402                	ld	s0,0(sp)
 b36:	0141                	addi	sp,sp,16
 b38:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 b3a:	4614                	lw	a3,8(a2)
 b3c:	9ead                	addw	a3,a3,a1
 b3e:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b42:	6394                	ld	a3,0(a5)
 b44:	6290                	ld	a2,0(a3)
 b46:	b7f9                	j	b14 <free+0x2a>
    p->s.size += bp->s.size;
 b48:	ff852703          	lw	a4,-8(a0)
 b4c:	9f31                	addw	a4,a4,a2
 b4e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b50:	ff053703          	ld	a4,-16(a0)
 b54:	bfd1                	j	b28 <free+0x3e>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b56:	6394                	ld	a3,0(a5)
 b58:	00d7e463          	bltu	a5,a3,b60 <free+0x76>
 b5c:	fad762e3          	bltu	a4,a3,b00 <free+0x16>
 b60:	87b6                	mv	a5,a3
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b62:	fee7fae3          	bgeu	a5,a4,b56 <free+0x6c>
 b66:	6394                	ld	a3,0(a5)
 b68:	f8d76ce3          	bltu	a4,a3,b00 <free+0x16>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b6c:	f8d7fae3          	bgeu	a5,a3,b00 <free+0x16>
 b70:	87b6                	mv	a5,a3
 b72:	bfc5                	j	b62 <free+0x78>

0000000000000b74 <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
 b74:	7139                	addi	sp,sp,-64
 b76:	fc06                	sd	ra,56(sp)
 b78:	f822                	sd	s0,48(sp)
 b7a:	f04a                	sd	s2,32(sp)
 b7c:	ec4e                	sd	s3,24(sp)
 b7e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b80:	02051993          	slli	s3,a0,0x20
 b84:	0209d993          	srli	s3,s3,0x20
 b88:	09bd                	addi	s3,s3,15
 b8a:	0049d993          	srli	s3,s3,0x4
 b8e:	2985                	addiw	s3,s3,1
 b90:	894e                	mv	s2,s3
  if ((prevp = freep) == 0) {
 b92:	00000517          	auipc	a0,0x0
 b96:	46e53503          	ld	a0,1134(a0) # 1000 <freep>
 b9a:	c905                	beqz	a0,bca <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 b9c:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 b9e:	4798                	lw	a4,8(a5)
 ba0:	09377663          	bgeu	a4,s3,c2c <malloc+0xb8>
 ba4:	f426                	sd	s1,40(sp)
 ba6:	e852                	sd	s4,16(sp)
 ba8:	e456                	sd	s5,8(sp)
 baa:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 bac:	8a4e                	mv	s4,s3
 bae:	6705                	lui	a4,0x1
 bb0:	00e9f363          	bgeu	s3,a4,bb6 <malloc+0x42>
 bb4:	6a05                	lui	s4,0x1
 bb6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 bba:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 bbe:	00000497          	auipc	s1,0x0
 bc2:	44248493          	addi	s1,s1,1090 # 1000 <freep>
  if (p == SBRK_ERROR)
 bc6:	5afd                	li	s5,-1
 bc8:	a83d                	j	c06 <malloc+0x92>
 bca:	f426                	sd	s1,40(sp)
 bcc:	e852                	sd	s4,16(sp)
 bce:	e456                	sd	s5,8(sp)
 bd0:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 bd2:	00002797          	auipc	a5,0x2
 bd6:	43e78793          	addi	a5,a5,1086 # 3010 <base>
 bda:	00000717          	auipc	a4,0x0
 bde:	42f73323          	sd	a5,1062(a4) # 1000 <freep>
 be2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 be4:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 be8:	b7d1                	j	bac <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 bea:	6398                	ld	a4,0(a5)
 bec:	e118                	sd	a4,0(a0)
 bee:	a899                	j	c44 <malloc+0xd0>
  hp->s.size = nu;
 bf0:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 bf4:	0541                	addi	a0,a0,16
 bf6:	ef5ff0ef          	jal	aea <free>
  return freep;
 bfa:	6088                	ld	a0,0(s1)
      if ((p = morecore(nunits)) == 0)
 bfc:	c125                	beqz	a0,c5c <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 bfe:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 c00:	4798                	lw	a4,8(a5)
 c02:	03277163          	bgeu	a4,s2,c24 <malloc+0xb0>
    if (p == freep)
 c06:	6098                	ld	a4,0(s1)
 c08:	853e                	mv	a0,a5
 c0a:	fef71ae3          	bne	a4,a5,bfe <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 c0e:	8552                	mv	a0,s4
 c10:	9ffff0ef          	jal	60e <sbrk>
  if (p == SBRK_ERROR)
 c14:	fd551ee3          	bne	a0,s5,bf0 <malloc+0x7c>
        return 0;
 c18:	4501                	li	a0,0
 c1a:	74a2                	ld	s1,40(sp)
 c1c:	6a42                	ld	s4,16(sp)
 c1e:	6aa2                	ld	s5,8(sp)
 c20:	6b02                	ld	s6,0(sp)
 c22:	a03d                	j	c50 <malloc+0xdc>
 c24:	74a2                	ld	s1,40(sp)
 c26:	6a42                	ld	s4,16(sp)
 c28:	6aa2                	ld	s5,8(sp)
 c2a:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
 c2c:	fae90fe3          	beq	s2,a4,bea <malloc+0x76>
        p->s.size -= nunits;
 c30:	4137073b          	subw	a4,a4,s3
 c34:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c36:	02071693          	slli	a3,a4,0x20
 c3a:	01c6d713          	srli	a4,a3,0x1c
 c3e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c40:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c44:	00000717          	auipc	a4,0x0
 c48:	3aa73e23          	sd	a0,956(a4) # 1000 <freep>
      return (void *)(p + 1);
 c4c:	01078513          	addi	a0,a5,16
  }
}
 c50:	70e2                	ld	ra,56(sp)
 c52:	7442                	ld	s0,48(sp)
 c54:	7902                	ld	s2,32(sp)
 c56:	69e2                	ld	s3,24(sp)
 c58:	6121                	addi	sp,sp,64
 c5a:	8082                	ret
 c5c:	74a2                	ld	s1,40(sp)
 c5e:	6a42                	ld	s4,16(sp)
 c60:	6aa2                	ld	s5,8(sp)
 c62:	6b02                	ld	s6,0(sp)
 c64:	b7f5                	j	c50 <malloc+0xdc>
