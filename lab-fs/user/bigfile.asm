
user/_bigfile:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <verify>:
}

static inline void
verify(const char *name, uint blocks, uint seed, const struct patch *patches,
       int np)
{
   0:	7135                	addi	sp,sp,-160
   2:	ed06                	sd	ra,152(sp)
   4:	e922                	sd	s0,144(sp)
   6:	e526                	sd	s1,136(sp)
   8:	e14a                	sd	s2,128(sp)
   a:	fcce                	sd	s3,120(sp)
   c:	f8d2                	sd	s4,112(sp)
   e:	f4d6                	sd	s5,104(sp)
  10:	f0da                	sd	s6,96(sp)
  12:	ecde                	sd	s7,88(sp)
  14:	e8e2                	sd	s8,80(sp)
  16:	e4e6                	sd	s9,72(sp)
  18:	e0ea                	sd	s10,64(sp)
  1a:	fc6e                	sd	s11,56(sp)
  1c:	1100                	addi	s0,sp,160
  1e:	8d2e                	mv	s10,a1
  20:	8ab2                	mv	s5,a2
  22:	8a36                	mv	s4,a3
  24:	893a                	mv	s2,a4
  int fd = open(name, O_RDONLY);
  26:	4581                	li	a1,0
  28:	7f8000ef          	jal	820 <open>
  if (!ok) {
  2c:	04054663          	bltz	a0,78 <verify+0x78>
  30:	8caa                	mv	s9,a0
  check(fstat(fd, &st) == 0 && st.size == (uint64)blocks * BSIZE,
  32:	f7840593          	addi	a1,s0,-136
  36:	003000ef          	jal	838 <fstat>
  3a:	ed29                	bnez	a0,94 <verify+0x94>
  3c:	020d1713          	slli	a4,s10,0x20
  40:	01675793          	srli	a5,a4,0x16
  if (!ok) {
  44:	f8843703          	ld	a4,-120(s0)
  48:	04f71663          	bne	a4,a5,94 <verify+0x94>
  for (uint first = 0; first < blocks;) {
  4c:	180d0463          	beqz	s10,1d4 <verify+0x1d4>
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
  50:	0ffafa93          	zext.b	s5,s5
  54:	003a9c1b          	slliw	s8,s5,0x3
  58:	415c0c3b          	subw	s8,s8,s5
  5c:	002c1c1b          	slliw	s8,s8,0x2
  60:	015c0c3b          	addw	s8,s8,s5
  64:	0ffc7c13          	zext.b	s8,s8
  68:	00391493          	slli	s1,s2,0x3
  6c:	94d2                	add	s1,s1,s4
  for (uint first = 0; first < blocks;) {
  6e:	4b81                	li	s7,0
  if (byte == 4)
  70:	4b11                	li	s6,4
      for (uint j = 0; j < BSIZE; j++) {
  72:	40000993          	li	s3,1024
  76:	a209                	j	178 <verify+0x178>
    fprintf(2, "TEST FAILURE: %s\n", why);
  78:	00001617          	auipc	a2,0x1
  7c:	d9860613          	addi	a2,a2,-616 # e10 <malloc+0xfe>
  80:	00001597          	auipc	a1,0x1
  84:	db058593          	addi	a1,a1,-592 # e30 <malloc+0x11e>
  88:	4509                	li	a0,2
  8a:	3a3000ef          	jal	c2c <fprintf>
    exit(1);
  8e:	4505                	li	a0,1
  90:	750000ef          	jal	7e0 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
  94:	00001617          	auipc	a2,0x1
  98:	db460613          	addi	a2,a2,-588 # e48 <malloc+0x136>
  9c:	00001597          	auipc	a1,0x1
  a0:	d9458593          	addi	a1,a1,-620 # e30 <malloc+0x11e>
  a4:	4509                	li	a0,2
  a6:	387000ef          	jal	c2c <fprintf>
    exit(1);
  aa:	4505                	li	a0,1
  ac:	734000ef          	jal	7e0 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
  b0:	00001617          	auipc	a2,0x1
  b4:	da860613          	addi	a2,a2,-600 # e58 <malloc+0x146>
  b8:	00001597          	auipc	a1,0x1
  bc:	d7858593          	addi	a1,a1,-648 # e30 <malloc+0x11e>
  c0:	4509                	li	a0,2
  c2:	36b000ef          	jal	c2c <fprintf>
    exit(1);
  c6:	4505                	li	a0,1
  c8:	718000ef          	jal	7e0 <exit>
    return (block >> (8 * byte)) & 255;
  cc:	0035961b          	slliw	a2,a1,0x3
  d0:	00ced63b          	srlw	a2,t4,a2
  d4:	0ff67613          	zext.b	a2,a2
  d8:	a099                	j	11e <verify+0x11e>
            want = patches[k].value;
  da:	0047c603          	lbu	a2,4(a5)
        for (int k = 0; k < np; k++)
  de:	07a1                	addi	a5,a5,8
  e0:	00f48663          	beq	s1,a5,ec <verify+0xec>
          if (patches[k].offset == off)
  e4:	4398                	lw	a4,0(a5)
  e6:	fed71ce3          	bne	a4,a3,de <verify+0xde>
  ea:	bfc5                	j	da <verify+0xda>
        check((uchar)fs_buffer[b * BSIZE + j] == want, "file contents differ");
  ec:	010587bb          	addw	a5,a1,a6
  f0:	1782                	slli	a5,a5,0x20
  f2:	9381                	srli	a5,a5,0x20
  f4:	97c6                	add	a5,a5,a7
  if (!ok) {
  f6:	0007c783          	lbu	a5,0(a5)
  fa:	02c79663          	bne	a5,a2,126 <verify+0x126>
      for (uint j = 0; j < BSIZE; j++) {
  fe:	2585                	addiw	a1,a1,1
 100:	2545                	addiw	a0,a0,17
 102:	0ff57513          	zext.b	a0,a0
 106:	2685                	addiw	a3,a3,1
 108:	03358d63          	beq	a1,s3,142 <verify+0x142>
  if (byte < 4)
 10c:	fcb370e3          	bgeu	t1,a1,cc <verify+0xcc>
    return seed;
 110:	8656                	mv	a2,s5
  if (byte == 4)
 112:	01658663          	beq	a1,s6,11e <verify+0x11e>
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
 116:	01c54633          	xor	a2,a0,t3
 11a:	0ff67613          	zext.b	a2,a2
        for (int k = 0; k < np; k++)
 11e:	fd2057e3          	blez	s2,ec <verify+0xec>
 122:	87d2                	mv	a5,s4
 124:	b7c1                	j	e4 <verify+0xe4>
    fprintf(2, "TEST FAILURE: %s\n", why);
 126:	00001617          	auipc	a2,0x1
 12a:	d4a60613          	addi	a2,a2,-694 # e70 <malloc+0x15e>
 12e:	00001597          	auipc	a1,0x1
 132:	d0258593          	addi	a1,a1,-766 # e30 <malloc+0x11e>
 136:	4509                	li	a0,2
 138:	2f5000ef          	jal	c2c <fprintf>
    exit(1);
 13c:	4505                	li	a0,1
 13e:	6a2000ef          	jal	7e0 <exit>
    for (uint b = 0; b < n; b++) {
 142:	2f85                	addiw	t6,t6,1
 144:	f83f0f1b          	addiw	t5,t5,-125
 148:	0fff7f13          	zext.b	t5,t5
 14c:	4008081b          	addiw	a6,a6,1024
 150:	4002829b          	addiw	t0,t0,1024
 154:	01bffe63          	bgeu	t6,s11,170 <verify+0x170>
        uint off = (first + b) * BSIZE + j;
 158:	01fb8ebb          	addw	t4,s7,t6
 15c:	01ec4e33          	xor	t3,s8,t5
 160:	8696                	mv	a3,t0
 162:	4501                	li	a0,0
      for (uint j = 0; j < BSIZE; j++) {
 164:	4581                	li	a1,0
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
 166:	008ed79b          	srliw	a5,t4,0x8
 16a:	00fe4e33          	xor	t3,t3,a5
 16e:	bf79                	j	10c <verify+0x10c>
    first += n;
 170:	01bb8bbb          	addw	s7,s7,s11
  for (uint first = 0; first < blocks;) {
 174:	07abf063          	bgeu	s7,s10,1d4 <verify+0x1d4>
    uint n = blocks - first;
 178:	417d073b          	subw	a4,s10,s7
 17c:	87ba                	mv	a5,a4
    if (n > 8)
 17e:	46a1                	li	a3,8
 180:	00e6f363          	bgeu	a3,a4,186 <verify+0x186>
 184:	47a1                	li	a5,8
 186:	00078d9b          	sext.w	s11,a5
    check(read(fd, fs_buffer, n * BSIZE) == n * BSIZE, "read full test data");
 18a:	00a7961b          	slliw	a2,a5,0xa
 18e:	f6c43423          	sd	a2,-152(s0)
 192:	00002597          	auipc	a1,0x2
 196:	e7e58593          	addi	a1,a1,-386 # 2010 <fs_buffer>
 19a:	8566                	mv	a0,s9
 19c:	65c000ef          	jal	7f8 <read>
  if (!ok) {
 1a0:	f6843783          	ld	a5,-152(s0)
 1a4:	f0a796e3          	bne	a5,a0,b0 <verify+0xb0>
    for (uint b = 0; b < n; b++) {
 1a8:	fdab84e3          	beq	s7,s10,170 <verify+0x170>
 1ac:	006b9f1b          	slliw	t5,s7,0x6
 1b0:	41eb8f3b          	subw	t5,s7,t5
 1b4:	001f1f1b          	slliw	t5,t5,0x1
 1b8:	017f0f3b          	addw	t5,t5,s7
 1bc:	0fff7f13          	zext.b	t5,t5
 1c0:	00ab929b          	slliw	t0,s7,0xa
 1c4:	4801                	li	a6,0
 1c6:	4f81                	li	t6,0
  if (byte < 4)
 1c8:	430d                	li	t1,3
        check((uchar)fs_buffer[b * BSIZE + j] == want, "file contents differ");
 1ca:	00002897          	auipc	a7,0x2
 1ce:	e4688893          	addi	a7,a7,-442 # 2010 <fs_buffer>
 1d2:	b759                	j	158 <verify+0x158>
  check(read(fd, fs_buffer, 1) == 0, "EOF after exact file size");
 1d4:	4605                	li	a2,1
 1d6:	00002597          	auipc	a1,0x2
 1da:	e3a58593          	addi	a1,a1,-454 # 2010 <fs_buffer>
 1de:	8566                	mv	a0,s9
 1e0:	618000ef          	jal	7f8 <read>
  if (!ok) {
 1e4:	e505                	bnez	a0,20c <verify+0x20c>
  check(fd >= 0, "open for verification");
  verifyfd(fd, blocks, seed, patches, np);
  check(close(fd) == 0, "close verified file");
 1e6:	8566                	mv	a0,s9
 1e8:	620000ef          	jal	808 <close>
  if (!ok) {
 1ec:	ed15                	bnez	a0,228 <verify+0x228>
}
 1ee:	60ea                	ld	ra,152(sp)
 1f0:	644a                	ld	s0,144(sp)
 1f2:	64aa                	ld	s1,136(sp)
 1f4:	690a                	ld	s2,128(sp)
 1f6:	79e6                	ld	s3,120(sp)
 1f8:	7a46                	ld	s4,112(sp)
 1fa:	7aa6                	ld	s5,104(sp)
 1fc:	7b06                	ld	s6,96(sp)
 1fe:	6be6                	ld	s7,88(sp)
 200:	6c46                	ld	s8,80(sp)
 202:	6ca6                	ld	s9,72(sp)
 204:	6d06                	ld	s10,64(sp)
 206:	7de2                	ld	s11,56(sp)
 208:	610d                	addi	sp,sp,160
 20a:	8082                	ret
    fprintf(2, "TEST FAILURE: %s\n", why);
 20c:	00001617          	auipc	a2,0x1
 210:	c7c60613          	addi	a2,a2,-900 # e88 <malloc+0x176>
 214:	00001597          	auipc	a1,0x1
 218:	c1c58593          	addi	a1,a1,-996 # e30 <malloc+0x11e>
 21c:	4509                	li	a0,2
 21e:	20f000ef          	jal	c2c <fprintf>
    exit(1);
 222:	4505                	li	a0,1
 224:	5bc000ef          	jal	7e0 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 228:	00001617          	auipc	a2,0x1
 22c:	c8060613          	addi	a2,a2,-896 # ea8 <malloc+0x196>
 230:	00001597          	auipc	a1,0x1
 234:	c0058593          	addi	a1,a1,-1024 # e30 <malloc+0x11e>
 238:	4509                	li	a0,2
 23a:	1f3000ef          	jal	c2c <fprintf>
    exit(1);
 23e:	4505                	li	a0,1
 240:	5a0000ef          	jal	7e0 <exit>

0000000000000244 <main>:
#include "user/fs_test.h"
int
main(void)
{
 244:	715d                	addi	sp,sp,-80
 246:	e486                	sd	ra,72(sp)
 248:	e0a2                	sd	s0,64(sp)
 24a:	0880                	addi	s0,sp,80
  unlink(name);
 24c:	00001517          	auipc	a0,0x1
 250:	c7450513          	addi	a0,a0,-908 # ec0 <malloc+0x1ae>
 254:	5dc000ef          	jal	830 <unlink>
  int fd = open(name, O_CREATE | O_WRONLY | O_TRUNC);
 258:	60100593          	li	a1,1537
 25c:	00001517          	auipc	a0,0x1
 260:	c6450513          	addi	a0,a0,-924 # ec0 <malloc+0x1ae>
 264:	5bc000ef          	jal	820 <open>
  if (!ok) {
 268:	02054663          	bltz	a0,294 <main+0x50>
 26c:	fc26                	sd	s1,56(sp)
 26e:	f84a                	sd	s2,48(sp)
 270:	f44e                	sd	s3,40(sp)
 272:	f052                	sd	s4,32(sp)
 274:	ec56                	sd	s5,24(sp)
 276:	e85a                	sd	s6,16(sp)
 278:	e45e                	sd	s7,8(sp)
 27a:	e062                	sd	s8,0(sp)
 27c:	8b2a                	mv	s6,a0
 27e:	4a01                	li	s4,0
    uint n = blocks - first;
 280:	6bc1                	lui	s7,0x10
 282:	10bb8b9b          	addiw	s7,s7,267 # 1010b <base+0xc0fb>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
 286:	00002497          	auipc	s1,0x2
 28a:	d8a48493          	addi	s1,s1,-630 # 2010 <fs_buffer>
  if (byte == 4)
 28e:	4911                	li	s2,4
    return seed;
 290:	49cd                	li	s3,19
 292:	a875                	j	34e <main+0x10a>
 294:	fc26                	sd	s1,56(sp)
 296:	f84a                	sd	s2,48(sp)
 298:	f44e                	sd	s3,40(sp)
 29a:	f052                	sd	s4,32(sp)
 29c:	ec56                	sd	s5,24(sp)
 29e:	e85a                	sd	s6,16(sp)
 2a0:	e45e                	sd	s7,8(sp)
 2a2:	e062                	sd	s8,0(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
 2a4:	00001617          	auipc	a2,0x1
 2a8:	c2c60613          	addi	a2,a2,-980 # ed0 <malloc+0x1be>
 2ac:	00001597          	auipc	a1,0x1
 2b0:	b8458593          	addi	a1,a1,-1148 # e30 <malloc+0x11e>
 2b4:	4509                	li	a0,2
 2b6:	177000ef          	jal	c2c <fprintf>
    exit(1);
 2ba:	4505                	li	a0,1
 2bc:	524000ef          	jal	7e0 <exit>
      for (uint j = 0; j < BSIZE; j++)
 2c0:	26c5                	addiw	a3,a3,17
 2c2:	0ff6f693          	zext.b	a3,a3
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
 2c6:	00b707bb          	addw	a5,a4,a1
  if (byte < 4)
 2ca:	04e57263          	bgeu	a0,a4,30e <main+0xca>
  if (byte == 4)
 2ce:	25270c63          	beq	a4,s2,526 <main+0x2e2>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
 2d2:	1782                	slli	a5,a5,0x20
 2d4:	9381                	srli	a5,a5,0x20
 2d6:	97a6                	add	a5,a5,s1
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
 2d8:	0106c633          	xor	a2,a3,a6
 2dc:	01164633          	xor	a2,a2,a7
 2e0:	02764613          	xori	a2,a2,39
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
 2e4:	00c78023          	sb	a2,0(a5)
      for (uint j = 0; j < BSIZE; j++)
 2e8:	2705                	addiw	a4,a4,1
 2ea:	fc671be3          	bne	a4,t1,2c0 <main+0x7c>
    for (uint b = 0; b < n; b++)
 2ee:	2e85                	addiw	t4,t4,1
 2f0:	f838081b          	addiw	a6,a6,-125
 2f4:	0ff87813          	zext.b	a6,a6
 2f8:	4005859b          	addiw	a1,a1,1024
 2fc:	035ef963          	bgeu	t4,s5,32e <main+0xea>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
 300:	014e8e3b          	addw	t3,t4,s4
 304:	4681                	li	a3,0
      for (uint j = 0; j < BSIZE; j++)
 306:	4701                	li	a4,0
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
 308:	008e589b          	srliw	a7,t3,0x8
 30c:	bf6d                	j	2c6 <main+0x82>
    return (block >> (8 * byte)) & 255;
 30e:	0037161b          	slliw	a2,a4,0x3
 312:	00ce563b          	srlw	a2,t3,a2
 316:	0ff67613          	zext.b	a2,a2
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
 31a:	1782                	slli	a5,a5,0x20
 31c:	9381                	srli	a5,a5,0x20
 31e:	97a6                	add	a5,a5,s1
 320:	00c78023          	sb	a2,0(a5)
      for (uint j = 0; j < BSIZE; j++)
 324:	2705                	addiw	a4,a4,1
 326:	26c5                	addiw	a3,a3,17
 328:	0ff6f693          	zext.b	a3,a3
 32c:	bf69                	j	2c6 <main+0x82>
    check(write(fd, fs_buffer, n * BSIZE) == n * BSIZE, "write full test data");
 32e:	00aa961b          	slliw	a2,s5,0xa
 332:	8c32                	mv	s8,a2
 334:	85a6                	mv	a1,s1
 336:	855a                	mv	a0,s6
 338:	4c8000ef          	jal	800 <write>
  if (!ok) {
 33c:	04ac1163          	bne	s8,a0,37e <main+0x13a>
    first += n;
 340:	015a0a3b          	addw	s4,s4,s5
  for (uint first = 0; first < blocks;) {
 344:	67c1                	lui	a5,0x10
 346:	10a78793          	addi	a5,a5,266 # 1010a <base+0xc0fa>
 34a:	0547e863          	bltu	a5,s4,39a <main+0x156>
    uint n = blocks - first;
 34e:	414b87bb          	subw	a5,s7,s4
 352:	8abe                	mv	s5,a5
    if (n > 8)
 354:	4721                	li	a4,8
 356:	00f77363          	bgeu	a4,a5,35c <main+0x118>
 35a:	4aa1                	li	s5,8
 35c:	2a81                	sext.w	s5,s5
    for (uint b = 0; b < n; b++)
 35e:	006a181b          	slliw	a6,s4,0x6
 362:	410a083b          	subw	a6,s4,a6
 366:	0018181b          	slliw	a6,a6,0x1
 36a:	0148083b          	addw	a6,a6,s4
 36e:	0ff87813          	zext.b	a6,a6
    if (n > 8)
 372:	4581                	li	a1,0
    for (uint b = 0; b < n; b++)
 374:	4e81                	li	t4,0
  if (byte < 4)
 376:	450d                	li	a0,3
      for (uint j = 0; j < BSIZE; j++)
 378:	40000313          	li	t1,1024
 37c:	b751                	j	300 <main+0xbc>
    fprintf(2, "TEST FAILURE: %s\n", why);
 37e:	00001617          	auipc	a2,0x1
 382:	b6a60613          	addi	a2,a2,-1174 # ee8 <malloc+0x1d6>
 386:	00001597          	auipc	a1,0x1
 38a:	aaa58593          	addi	a1,a1,-1366 # e30 <malloc+0x11e>
 38e:	4509                	li	a0,2
 390:	09d000ef          	jal	c2c <fprintf>
    exit(1);
 394:	4505                	li	a0,1
 396:	44a000ef          	jal	7e0 <exit>
  check(close(fd) == 0, "close written file");
 39a:	855a                	mv	a0,s6
 39c:	46c000ef          	jal	808 <close>
  if (!ok) {
 3a0:	ed31                	bnez	a0,3fc <main+0x1b8>
  makefile("fst_max.tmp", 65803, 19);
  printf("FS_STAGE max_write\n");
 3a2:	00001517          	auipc	a0,0x1
 3a6:	b7650513          	addi	a0,a0,-1162 # f18 <malloc+0x206>
 3aa:	0ad000ef          	jal	c56 <printf>
  verify("fst_max.tmp", 65803, 19, 0, 0);
 3ae:	4701                	li	a4,0
 3b0:	4681                	li	a3,0
 3b2:	464d                	li	a2,19
 3b4:	65c1                	lui	a1,0x10
 3b6:	10b58593          	addi	a1,a1,267 # 1010b <base+0xc0fb>
 3ba:	00001517          	auipc	a0,0x1
 3be:	b0650513          	addi	a0,a0,-1274 # ec0 <malloc+0x1ae>
 3c2:	c3fff0ef          	jal	0 <verify>
  printf("FS_STAGE max_read\n");
 3c6:	00001517          	auipc	a0,0x1
 3ca:	b6a50513          	addi	a0,a0,-1174 # f30 <malloc+0x21e>
 3ce:	089000ef          	jal	c56 <printf>
  int fd = open("fst_max.tmp", O_RDWR);
 3d2:	4589                	li	a1,2
 3d4:	00001517          	auipc	a0,0x1
 3d8:	aec50513          	addi	a0,a0,-1300 # ec0 <malloc+0x1ae>
 3dc:	444000ef          	jal	820 <open>
 3e0:	892a                	mv	s2,a0
  check(fd >= 0, "open maximum file");
  uint left = 65803U * BSIZE;
 3e2:	040434b7          	lui	s1,0x4043
 3e6:	c0048493          	addi	s1,s1,-1024 # 4042c00 <base+0x403ebf0>
 3ea:	02054763          	bltz	a0,418 <main+0x1d4>
  while (left) {
    uint n = left > sizeof(fs_buffer) ? sizeof(fs_buffer) : left;
 3ee:	6b89                	lui	s7,0x2
 3f0:	6b09                	lui	s6,0x2
    check(read(fd, fs_buffer, n) == n, "advance to maximum EOF");
 3f2:	00002a97          	auipc	s5,0x2
 3f6:	c1ea8a93          	addi	s5,s5,-994 # 2010 <fs_buffer>
 3fa:	a889                	j	44c <main+0x208>
    fprintf(2, "TEST FAILURE: %s\n", why);
 3fc:	00001617          	auipc	a2,0x1
 400:	b0460613          	addi	a2,a2,-1276 # f00 <malloc+0x1ee>
 404:	00001597          	auipc	a1,0x1
 408:	a2c58593          	addi	a1,a1,-1492 # e30 <malloc+0x11e>
 40c:	4509                	li	a0,2
 40e:	01f000ef          	jal	c2c <fprintf>
    exit(1);
 412:	4505                	li	a0,1
 414:	3cc000ef          	jal	7e0 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 418:	00001617          	auipc	a2,0x1
 41c:	b3060613          	addi	a2,a2,-1232 # f48 <malloc+0x236>
 420:	00001597          	auipc	a1,0x1
 424:	a1058593          	addi	a1,a1,-1520 # e30 <malloc+0x11e>
 428:	4509                	li	a0,2
 42a:	003000ef          	jal	c2c <fprintf>
    exit(1);
 42e:	4505                	li	a0,1
 430:	3b0000ef          	jal	7e0 <exit>
    uint n = left > sizeof(fs_buffer) ? sizeof(fs_buffer) : left;
 434:	00098a1b          	sext.w	s4,s3
    check(read(fd, fs_buffer, n) == n, "advance to maximum EOF");
 438:	8652                	mv	a2,s4
 43a:	85d6                	mv	a1,s5
 43c:	854a                	mv	a0,s2
 43e:	3ba000ef          	jal	7f8 <read>
  if (!ok) {
 442:	01451a63          	bne	a0,s4,456 <main+0x212>
    left -= n;
 446:	413484bb          	subw	s1,s1,s3
  while (left) {
 44a:	c485                	beqz	s1,472 <main+0x22e>
    uint n = left > sizeof(fs_buffer) ? sizeof(fs_buffer) : left;
 44c:	89a6                	mv	s3,s1
 44e:	fe9bf3e3          	bgeu	s7,s1,434 <main+0x1f0>
 452:	89da                	mv	s3,s6
 454:	b7c5                	j	434 <main+0x1f0>
    fprintf(2, "TEST FAILURE: %s\n", why);
 456:	00001617          	auipc	a2,0x1
 45a:	b0a60613          	addi	a2,a2,-1270 # f60 <malloc+0x24e>
 45e:	00001597          	auipc	a1,0x1
 462:	9d258593          	addi	a1,a1,-1582 # e30 <malloc+0x11e>
 466:	4509                	li	a0,2
 468:	7c4000ef          	jal	c2c <fprintf>
    exit(1);
 46c:	4505                	li	a0,1
 46e:	372000ef          	jal	7e0 <exit>
  }
  check(write(fd, fs_buffer, 1) < 1, "reject write past MAXFILE");
 472:	4605                	li	a2,1
 474:	00002597          	auipc	a1,0x2
 478:	b9c58593          	addi	a1,a1,-1124 # 2010 <fs_buffer>
 47c:	854a                	mv	a0,s2
 47e:	382000ef          	jal	800 <write>
  if (!ok) {
 482:	04a04863          	bgtz	a0,4d2 <main+0x28e>
  check(close(fd) == 0, "close maximum file");
 486:	854a                	mv	a0,s2
 488:	380000ef          	jal	808 <close>
 48c:	e12d                	bnez	a0,4ee <main+0x2aa>
  verify("fst_max.tmp", 65803, 19, 0, 0);
 48e:	4701                	li	a4,0
 490:	4681                	li	a3,0
 492:	464d                	li	a2,19
 494:	65c1                	lui	a1,0x10
 496:	10b58593          	addi	a1,a1,267 # 1010b <base+0xc0fb>
 49a:	00001517          	auipc	a0,0x1
 49e:	a2650513          	addi	a0,a0,-1498 # ec0 <malloc+0x1ae>
 4a2:	b5fff0ef          	jal	0 <verify>
  printf("FS_STAGE max_limit\n");
 4a6:	00001517          	auipc	a0,0x1
 4aa:	b0a50513          	addi	a0,a0,-1270 # fb0 <malloc+0x29e>
 4ae:	7a8000ef          	jal	c56 <printf>
  check(unlink("fst_max.tmp") == 0, "reclaim maximum file");
 4b2:	00001517          	auipc	a0,0x1
 4b6:	a0e50513          	addi	a0,a0,-1522 # ec0 <malloc+0x1ae>
 4ba:	376000ef          	jal	830 <unlink>
 4be:	e531                	bnez	a0,50a <main+0x2c6>
  printf("bigfile: passed\n");
 4c0:	00001517          	auipc	a0,0x1
 4c4:	b2050513          	addi	a0,a0,-1248 # fe0 <malloc+0x2ce>
 4c8:	78e000ef          	jal	c56 <printf>
  exit(0);
 4cc:	4501                	li	a0,0
 4ce:	312000ef          	jal	7e0 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 4d2:	00001617          	auipc	a2,0x1
 4d6:	aa660613          	addi	a2,a2,-1370 # f78 <malloc+0x266>
 4da:	00001597          	auipc	a1,0x1
 4de:	95658593          	addi	a1,a1,-1706 # e30 <malloc+0x11e>
 4e2:	4509                	li	a0,2
 4e4:	748000ef          	jal	c2c <fprintf>
    exit(1);
 4e8:	4505                	li	a0,1
 4ea:	2f6000ef          	jal	7e0 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 4ee:	00001617          	auipc	a2,0x1
 4f2:	aaa60613          	addi	a2,a2,-1366 # f98 <malloc+0x286>
 4f6:	00001597          	auipc	a1,0x1
 4fa:	93a58593          	addi	a1,a1,-1734 # e30 <malloc+0x11e>
 4fe:	4509                	li	a0,2
 500:	72c000ef          	jal	c2c <fprintf>
    exit(1);
 504:	4505                	li	a0,1
 506:	2da000ef          	jal	7e0 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 50a:	00001617          	auipc	a2,0x1
 50e:	abe60613          	addi	a2,a2,-1346 # fc8 <malloc+0x2b6>
 512:	00001597          	auipc	a1,0x1
 516:	91e58593          	addi	a1,a1,-1762 # e30 <malloc+0x11e>
 51a:	4509                	li	a0,2
 51c:	710000ef          	jal	c2c <fprintf>
    exit(1);
 520:	4505                	li	a0,1
 522:	2be000ef          	jal	7e0 <exit>
    return seed;
 526:	864e                	mv	a2,s3
 528:	bbcd                	j	31a <main+0xd6>

000000000000052a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 52a:	1141                	addi	sp,sp,-16
 52c:	e406                	sd	ra,8(sp)
 52e:	e022                	sd	s0,0(sp)
 530:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 532:	d13ff0ef          	jal	244 <main>
  exit(r);
 536:	2aa000ef          	jal	7e0 <exit>

000000000000053a <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 53a:	1141                	addi	sp,sp,-16
 53c:	e406                	sd	ra,8(sp)
 53e:	e022                	sd	s0,0(sp)
 540:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 542:	87aa                	mv	a5,a0
 544:	0585                	addi	a1,a1,1
 546:	0785                	addi	a5,a5,1
 548:	fff5c703          	lbu	a4,-1(a1)
 54c:	fee78fa3          	sb	a4,-1(a5)
 550:	fb75                	bnez	a4,544 <strcpy+0xa>
    ;
  return os;
}
 552:	60a2                	ld	ra,8(sp)
 554:	6402                	ld	s0,0(sp)
 556:	0141                	addi	sp,sp,16
 558:	8082                	ret

000000000000055a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 55a:	1141                	addi	sp,sp,-16
 55c:	e406                	sd	ra,8(sp)
 55e:	e022                	sd	s0,0(sp)
 560:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 562:	00054783          	lbu	a5,0(a0)
 566:	cb91                	beqz	a5,57a <strcmp+0x20>
 568:	0005c703          	lbu	a4,0(a1)
 56c:	00f71763          	bne	a4,a5,57a <strcmp+0x20>
    p++, q++;
 570:	0505                	addi	a0,a0,1
 572:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 574:	00054783          	lbu	a5,0(a0)
 578:	fbe5                	bnez	a5,568 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 57a:	0005c503          	lbu	a0,0(a1)
}
 57e:	40a7853b          	subw	a0,a5,a0
 582:	60a2                	ld	ra,8(sp)
 584:	6402                	ld	s0,0(sp)
 586:	0141                	addi	sp,sp,16
 588:	8082                	ret

000000000000058a <strlen>:

uint
strlen(const char *s)
{
 58a:	1141                	addi	sp,sp,-16
 58c:	e406                	sd	ra,8(sp)
 58e:	e022                	sd	s0,0(sp)
 590:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 592:	00054783          	lbu	a5,0(a0)
 596:	cf91                	beqz	a5,5b2 <strlen+0x28>
 598:	00150793          	addi	a5,a0,1
 59c:	86be                	mv	a3,a5
 59e:	0785                	addi	a5,a5,1
 5a0:	fff7c703          	lbu	a4,-1(a5)
 5a4:	ff65                	bnez	a4,59c <strlen+0x12>
 5a6:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 5aa:	60a2                	ld	ra,8(sp)
 5ac:	6402                	ld	s0,0(sp)
 5ae:	0141                	addi	sp,sp,16
 5b0:	8082                	ret
  for (n = 0; s[n]; n++)
 5b2:	4501                	li	a0,0
 5b4:	bfdd                	j	5aa <strlen+0x20>

00000000000005b6 <memset>:

void *
memset(void *dst, int c, uint n)
{
 5b6:	1141                	addi	sp,sp,-16
 5b8:	e406                	sd	ra,8(sp)
 5ba:	e022                	sd	s0,0(sp)
 5bc:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 5be:	ca19                	beqz	a2,5d4 <memset+0x1e>
 5c0:	87aa                	mv	a5,a0
 5c2:	1602                	slli	a2,a2,0x20
 5c4:	9201                	srli	a2,a2,0x20
 5c6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 5ca:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 5ce:	0785                	addi	a5,a5,1
 5d0:	fee79de3          	bne	a5,a4,5ca <memset+0x14>
  }
  return dst;
}
 5d4:	60a2                	ld	ra,8(sp)
 5d6:	6402                	ld	s0,0(sp)
 5d8:	0141                	addi	sp,sp,16
 5da:	8082                	ret

00000000000005dc <strchr>:

char *
strchr(const char *s, char c)
{
 5dc:	1141                	addi	sp,sp,-16
 5de:	e406                	sd	ra,8(sp)
 5e0:	e022                	sd	s0,0(sp)
 5e2:	0800                	addi	s0,sp,16
  for (; *s; s++)
 5e4:	00054783          	lbu	a5,0(a0)
 5e8:	c799                	beqz	a5,5f6 <strchr+0x1a>
    if (*s == c)
 5ea:	00f58763          	beq	a1,a5,5f8 <strchr+0x1c>
  for (; *s; s++)
 5ee:	0505                	addi	a0,a0,1
 5f0:	00054783          	lbu	a5,0(a0)
 5f4:	fbfd                	bnez	a5,5ea <strchr+0xe>
      return (char *)s;
  return 0;
 5f6:	4501                	li	a0,0
}
 5f8:	60a2                	ld	ra,8(sp)
 5fa:	6402                	ld	s0,0(sp)
 5fc:	0141                	addi	sp,sp,16
 5fe:	8082                	ret

0000000000000600 <gets>:

char *
gets(char *buf, int max)
{
 600:	711d                	addi	sp,sp,-96
 602:	ec86                	sd	ra,88(sp)
 604:	e8a2                	sd	s0,80(sp)
 606:	e4a6                	sd	s1,72(sp)
 608:	e0ca                	sd	s2,64(sp)
 60a:	fc4e                	sd	s3,56(sp)
 60c:	f852                	sd	s4,48(sp)
 60e:	f456                	sd	s5,40(sp)
 610:	f05a                	sd	s6,32(sp)
 612:	ec5e                	sd	s7,24(sp)
 614:	e862                	sd	s8,16(sp)
 616:	1080                	addi	s0,sp,96
 618:	8baa                	mv	s7,a0
 61a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 61c:	892a                	mv	s2,a0
 61e:	4481                	li	s1,0
    cc = read(0, &c, 1);
 620:	faf40b13          	addi	s6,s0,-81
 624:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;) {
 626:	8c26                	mv	s8,s1
 628:	0014899b          	addiw	s3,s1,1
 62c:	84ce                	mv	s1,s3
 62e:	0349d863          	bge	s3,s4,65e <gets+0x5e>
    cc = read(0, &c, 1);
 632:	8656                	mv	a2,s5
 634:	85da                	mv	a1,s6
 636:	4501                	li	a0,0
 638:	1c0000ef          	jal	7f8 <read>
    if (cc < 1)
 63c:	02a05163          	blez	a0,65e <gets+0x5e>
      break;
    buf[i++] = c;
 640:	faf44783          	lbu	a5,-81(s0)
 644:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 648:	0905                	addi	s2,s2,1
 64a:	ff678713          	addi	a4,a5,-10
 64e:	00173713          	seqz	a4,a4
 652:	17cd                	addi	a5,a5,-13
 654:	0017b793          	seqz	a5,a5
 658:	8fd9                	or	a5,a5,a4
 65a:	d7f1                	beqz	a5,626 <gets+0x26>
    buf[i++] = c;
 65c:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 65e:	9c5e                	add	s8,s8,s7
 660:	000c0023          	sb	zero,0(s8)
  return buf;
}
 664:	855e                	mv	a0,s7
 666:	60e6                	ld	ra,88(sp)
 668:	6446                	ld	s0,80(sp)
 66a:	64a6                	ld	s1,72(sp)
 66c:	6906                	ld	s2,64(sp)
 66e:	79e2                	ld	s3,56(sp)
 670:	7a42                	ld	s4,48(sp)
 672:	7aa2                	ld	s5,40(sp)
 674:	7b02                	ld	s6,32(sp)
 676:	6be2                	ld	s7,24(sp)
 678:	6c42                	ld	s8,16(sp)
 67a:	6125                	addi	sp,sp,96
 67c:	8082                	ret

000000000000067e <stat>:

int
stat(const char *n, struct stat *st)
{
 67e:	1101                	addi	sp,sp,-32
 680:	ec06                	sd	ra,24(sp)
 682:	e822                	sd	s0,16(sp)
 684:	e04a                	sd	s2,0(sp)
 686:	1000                	addi	s0,sp,32
 688:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 68a:	4581                	li	a1,0
 68c:	194000ef          	jal	820 <open>
  if (fd < 0)
 690:	02054263          	bltz	a0,6b4 <stat+0x36>
 694:	e426                	sd	s1,8(sp)
 696:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 698:	85ca                	mv	a1,s2
 69a:	19e000ef          	jal	838 <fstat>
 69e:	892a                	mv	s2,a0
  close(fd);
 6a0:	8526                	mv	a0,s1
 6a2:	166000ef          	jal	808 <close>
  return r;
 6a6:	64a2                	ld	s1,8(sp)
}
 6a8:	854a                	mv	a0,s2
 6aa:	60e2                	ld	ra,24(sp)
 6ac:	6442                	ld	s0,16(sp)
 6ae:	6902                	ld	s2,0(sp)
 6b0:	6105                	addi	sp,sp,32
 6b2:	8082                	ret
    return -1;
 6b4:	57fd                	li	a5,-1
 6b6:	893e                	mv	s2,a5
 6b8:	bfc5                	j	6a8 <stat+0x2a>

00000000000006ba <atoi>:

int
atoi(const char *s)
{
 6ba:	1141                	addi	sp,sp,-16
 6bc:	e406                	sd	ra,8(sp)
 6be:	e022                	sd	s0,0(sp)
 6c0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 6c2:	00054683          	lbu	a3,0(a0)
 6c6:	fd06879b          	addiw	a5,a3,-48
 6ca:	0ff7f793          	zext.b	a5,a5
 6ce:	4625                	li	a2,9
 6d0:	02f66963          	bltu	a2,a5,702 <atoi+0x48>
 6d4:	872a                	mv	a4,a0
  n = 0;
 6d6:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 6d8:	0705                	addi	a4,a4,1
 6da:	0025179b          	slliw	a5,a0,0x2
 6de:	9fa9                	addw	a5,a5,a0
 6e0:	0017979b          	slliw	a5,a5,0x1
 6e4:	9fb5                	addw	a5,a5,a3
 6e6:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 6ea:	00074683          	lbu	a3,0(a4)
 6ee:	fd06879b          	addiw	a5,a3,-48
 6f2:	0ff7f793          	zext.b	a5,a5
 6f6:	fef671e3          	bgeu	a2,a5,6d8 <atoi+0x1e>
  return n;
}
 6fa:	60a2                	ld	ra,8(sp)
 6fc:	6402                	ld	s0,0(sp)
 6fe:	0141                	addi	sp,sp,16
 700:	8082                	ret
  n = 0;
 702:	4501                	li	a0,0
 704:	bfdd                	j	6fa <atoi+0x40>

0000000000000706 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 706:	1141                	addi	sp,sp,-16
 708:	e406                	sd	ra,8(sp)
 70a:	e022                	sd	s0,0(sp)
 70c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 70e:	02b57563          	bgeu	a0,a1,738 <memmove+0x32>
    while (n-- > 0)
 712:	00c05f63          	blez	a2,730 <memmove+0x2a>
 716:	1602                	slli	a2,a2,0x20
 718:	9201                	srli	a2,a2,0x20
 71a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 71e:	872a                	mv	a4,a0
      *dst++ = *src++;
 720:	0585                	addi	a1,a1,1
 722:	0705                	addi	a4,a4,1
 724:	fff5c683          	lbu	a3,-1(a1)
 728:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 72c:	fee79ae3          	bne	a5,a4,720 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 730:	60a2                	ld	ra,8(sp)
 732:	6402                	ld	s0,0(sp)
 734:	0141                	addi	sp,sp,16
 736:	8082                	ret
    while (n-- > 0)
 738:	fec05ce3          	blez	a2,730 <memmove+0x2a>
    dst += n;
 73c:	00c50733          	add	a4,a0,a2
    src += n;
 740:	95b2                	add	a1,a1,a2
 742:	fff6079b          	addiw	a5,a2,-1
 746:	1782                	slli	a5,a5,0x20
 748:	9381                	srli	a5,a5,0x20
 74a:	fff7c793          	not	a5,a5
 74e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 750:	15fd                	addi	a1,a1,-1
 752:	177d                	addi	a4,a4,-1
 754:	0005c683          	lbu	a3,0(a1)
 758:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 75c:	fef71ae3          	bne	a4,a5,750 <memmove+0x4a>
 760:	bfc1                	j	730 <memmove+0x2a>

0000000000000762 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 762:	1141                	addi	sp,sp,-16
 764:	e406                	sd	ra,8(sp)
 766:	e022                	sd	s0,0(sp)
 768:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 76a:	ce19                	beqz	a2,788 <memcmp+0x26>
 76c:	1602                	slli	a2,a2,0x20
 76e:	9201                	srli	a2,a2,0x20
 770:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 774:	00054783          	lbu	a5,0(a0)
 778:	0005c703          	lbu	a4,0(a1)
 77c:	00e79b63          	bne	a5,a4,792 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 780:	0505                	addi	a0,a0,1
    p2++;
 782:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 784:	fed518e3          	bne	a0,a3,774 <memcmp+0x12>
  }
  return 0;
 788:	4501                	li	a0,0
}
 78a:	60a2                	ld	ra,8(sp)
 78c:	6402                	ld	s0,0(sp)
 78e:	0141                	addi	sp,sp,16
 790:	8082                	ret
      return *p1 - *p2;
 792:	40e7853b          	subw	a0,a5,a4
 796:	bfd5                	j	78a <memcmp+0x28>

0000000000000798 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 798:	1141                	addi	sp,sp,-16
 79a:	e406                	sd	ra,8(sp)
 79c:	e022                	sd	s0,0(sp)
 79e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 7a0:	f67ff0ef          	jal	706 <memmove>
}
 7a4:	60a2                	ld	ra,8(sp)
 7a6:	6402                	ld	s0,0(sp)
 7a8:	0141                	addi	sp,sp,16
 7aa:	8082                	ret

00000000000007ac <sbrk>:

char *
sbrk(int n)
{
 7ac:	1141                	addi	sp,sp,-16
 7ae:	e406                	sd	ra,8(sp)
 7b0:	e022                	sd	s0,0(sp)
 7b2:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 7b4:	4585                	li	a1,1
 7b6:	0b2000ef          	jal	868 <sys_sbrk>
}
 7ba:	60a2                	ld	ra,8(sp)
 7bc:	6402                	ld	s0,0(sp)
 7be:	0141                	addi	sp,sp,16
 7c0:	8082                	ret

00000000000007c2 <sbrklazy>:

char *
sbrklazy(int n)
{
 7c2:	1141                	addi	sp,sp,-16
 7c4:	e406                	sd	ra,8(sp)
 7c6:	e022                	sd	s0,0(sp)
 7c8:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 7ca:	4589                	li	a1,2
 7cc:	09c000ef          	jal	868 <sys_sbrk>
}
 7d0:	60a2                	ld	ra,8(sp)
 7d2:	6402                	ld	s0,0(sp)
 7d4:	0141                	addi	sp,sp,16
 7d6:	8082                	ret

00000000000007d8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 7d8:	4885                	li	a7,1
 ecall
 7da:	00000073          	ecall
 ret
 7de:	8082                	ret

00000000000007e0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 7e0:	4889                	li	a7,2
 ecall
 7e2:	00000073          	ecall
 ret
 7e6:	8082                	ret

00000000000007e8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 7e8:	488d                	li	a7,3
 ecall
 7ea:	00000073          	ecall
 ret
 7ee:	8082                	ret

00000000000007f0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 7f0:	4891                	li	a7,4
 ecall
 7f2:	00000073          	ecall
 ret
 7f6:	8082                	ret

00000000000007f8 <read>:
.global read
read:
 li a7, SYS_read
 7f8:	4895                	li	a7,5
 ecall
 7fa:	00000073          	ecall
 ret
 7fe:	8082                	ret

0000000000000800 <write>:
.global write
write:
 li a7, SYS_write
 800:	48c1                	li	a7,16
 ecall
 802:	00000073          	ecall
 ret
 806:	8082                	ret

0000000000000808 <close>:
.global close
close:
 li a7, SYS_close
 808:	48d5                	li	a7,21
 ecall
 80a:	00000073          	ecall
 ret
 80e:	8082                	ret

0000000000000810 <kill>:
.global kill
kill:
 li a7, SYS_kill
 810:	4899                	li	a7,6
 ecall
 812:	00000073          	ecall
 ret
 816:	8082                	ret

0000000000000818 <exec>:
.global exec
exec:
 li a7, SYS_exec
 818:	489d                	li	a7,7
 ecall
 81a:	00000073          	ecall
 ret
 81e:	8082                	ret

0000000000000820 <open>:
.global open
open:
 li a7, SYS_open
 820:	48bd                	li	a7,15
 ecall
 822:	00000073          	ecall
 ret
 826:	8082                	ret

0000000000000828 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 828:	48c5                	li	a7,17
 ecall
 82a:	00000073          	ecall
 ret
 82e:	8082                	ret

0000000000000830 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 830:	48c9                	li	a7,18
 ecall
 832:	00000073          	ecall
 ret
 836:	8082                	ret

0000000000000838 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 838:	48a1                	li	a7,8
 ecall
 83a:	00000073          	ecall
 ret
 83e:	8082                	ret

0000000000000840 <link>:
.global link
link:
 li a7, SYS_link
 840:	48cd                	li	a7,19
 ecall
 842:	00000073          	ecall
 ret
 846:	8082                	ret

0000000000000848 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 848:	48d1                	li	a7,20
 ecall
 84a:	00000073          	ecall
 ret
 84e:	8082                	ret

0000000000000850 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 850:	48a5                	li	a7,9
 ecall
 852:	00000073          	ecall
 ret
 856:	8082                	ret

0000000000000858 <dup>:
.global dup
dup:
 li a7, SYS_dup
 858:	48a9                	li	a7,10
 ecall
 85a:	00000073          	ecall
 ret
 85e:	8082                	ret

0000000000000860 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 860:	48ad                	li	a7,11
 ecall
 862:	00000073          	ecall
 ret
 866:	8082                	ret

0000000000000868 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 868:	48b1                	li	a7,12
 ecall
 86a:	00000073          	ecall
 ret
 86e:	8082                	ret

0000000000000870 <pause>:
.global pause
pause:
 li a7, SYS_pause
 870:	48b5                	li	a7,13
 ecall
 872:	00000073          	ecall
 ret
 876:	8082                	ret

0000000000000878 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 878:	48b9                	li	a7,14
 ecall
 87a:	00000073          	ecall
 ret
 87e:	8082                	ret

0000000000000880 <sync>:
.global sync
sync:
 li a7, SYS_sync
 880:	48d9                	li	a7,22
 ecall
 882:	00000073          	ecall
 ret
 886:	8082                	ret

0000000000000888 <istat>:
.global istat
istat:
 li a7, SYS_istat
 888:	48dd                	li	a7,23
 ecall
 88a:	00000073          	ecall
 ret
 88e:	8082                	ret

0000000000000890 <iprint>:
.global iprint
iprint:
 li a7, SYS_iprint
 890:	48e1                	li	a7,24
 ecall
 892:	00000073          	ecall
 ret
 896:	8082                	ret

0000000000000898 <symlink>:
.global symlink
symlink:
 li a7, SYS_symlink
 898:	48e5                	li	a7,25
 ecall
 89a:	00000073          	ecall
 ret
 89e:	8082                	ret

00000000000008a0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 8a0:	1101                	addi	sp,sp,-32
 8a2:	ec06                	sd	ra,24(sp)
 8a4:	e822                	sd	s0,16(sp)
 8a6:	1000                	addi	s0,sp,32
 8a8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 8ac:	4605                	li	a2,1
 8ae:	fef40593          	addi	a1,s0,-17
 8b2:	f4fff0ef          	jal	800 <write>
}
 8b6:	60e2                	ld	ra,24(sp)
 8b8:	6442                	ld	s0,16(sp)
 8ba:	6105                	addi	sp,sp,32
 8bc:	8082                	ret

00000000000008be <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 8be:	715d                	addi	sp,sp,-80
 8c0:	e486                	sd	ra,72(sp)
 8c2:	e0a2                	sd	s0,64(sp)
 8c4:	f84a                	sd	s2,48(sp)
 8c6:	f44e                	sd	s3,40(sp)
 8c8:	0880                	addi	s0,sp,80
 8ca:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 8cc:	00d036b3          	snez	a3,a3
 8d0:	03f5d793          	srli	a5,a1,0x3f
 8d4:	8efd                	and	a3,a3,a5
  neg = 0;
 8d6:	4301                	li	t1,0
  if (sgn && xx < 0) {
 8d8:	c681                	beqz	a3,8e0 <printint+0x22>
    neg = 1;
    x = -xx;
 8da:	40b005b3          	neg	a1,a1
    neg = 1;
 8de:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 8e0:	fb840993          	addi	s3,s0,-72
  neg = 0;
 8e4:	86ce                	mv	a3,s3
  i = 0;
 8e6:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
 8e8:	00000817          	auipc	a6,0x0
 8ec:	71880813          	addi	a6,a6,1816 # 1000 <digits>
 8f0:	88ba                	mv	a7,a4
 8f2:	0017051b          	addiw	a0,a4,1
 8f6:	872a                	mv	a4,a0
 8f8:	02c5f7b3          	remu	a5,a1,a2
 8fc:	97c2                	add	a5,a5,a6
 8fe:	0007c783          	lbu	a5,0(a5)
 902:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
 906:	87ae                	mv	a5,a1
 908:	02c5d5b3          	divu	a1,a1,a2
 90c:	0685                	addi	a3,a3,1
 90e:	fec7f1e3          	bgeu	a5,a2,8f0 <printint+0x32>
  if (neg)
 912:	00030b63          	beqz	t1,928 <printint+0x6a>
    buf[i++] = '-';
 916:	fd040793          	addi	a5,s0,-48
 91a:	953e                	add	a0,a0,a5
 91c:	02d00793          	li	a5,45
 920:	fef50423          	sb	a5,-24(a0)
 924:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
 928:	02e05563          	blez	a4,952 <printint+0x94>
 92c:	fc26                	sd	s1,56(sp)
 92e:	377d                	addiw	a4,a4,-1
 930:	00e984b3          	add	s1,s3,a4
 934:	19fd                	addi	s3,s3,-1
 936:	99ba                	add	s3,s3,a4
 938:	1702                	slli	a4,a4,0x20
 93a:	9301                	srli	a4,a4,0x20
 93c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 940:	0004c583          	lbu	a1,0(s1)
 944:	854a                	mv	a0,s2
 946:	f5bff0ef          	jal	8a0 <putc>
  while (--i >= 0)
 94a:	14fd                	addi	s1,s1,-1
 94c:	ff349ae3          	bne	s1,s3,940 <printint+0x82>
 950:	74e2                	ld	s1,56(sp)
}
 952:	60a6                	ld	ra,72(sp)
 954:	6406                	ld	s0,64(sp)
 956:	7942                	ld	s2,48(sp)
 958:	79a2                	ld	s3,40(sp)
 95a:	6161                	addi	sp,sp,80
 95c:	8082                	ret

000000000000095e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 95e:	711d                	addi	sp,sp,-96
 960:	ec86                	sd	ra,88(sp)
 962:	e8a2                	sd	s0,80(sp)
 964:	e4a6                	sd	s1,72(sp)
 966:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 968:	0005c483          	lbu	s1,0(a1)
 96c:	2a048063          	beqz	s1,c0c <vprintf+0x2ae>
 970:	e0ca                	sd	s2,64(sp)
 972:	fc4e                	sd	s3,56(sp)
 974:	f852                	sd	s4,48(sp)
 976:	f456                	sd	s5,40(sp)
 978:	f05a                	sd	s6,32(sp)
 97a:	ec5e                	sd	s7,24(sp)
 97c:	e862                	sd	s8,16(sp)
 97e:	8b2a                	mv	s6,a0
 980:	8a2e                	mv	s4,a1
 982:	8bb2                	mv	s7,a2
  state = 0;
 984:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 986:	4901                	li	s2,0
 988:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 98a:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 98e:	06400c13          	li	s8,100
 992:	a00d                	j	9b4 <vprintf+0x56>
        putc(fd, c0);
 994:	85a6                	mv	a1,s1
 996:	855a                	mv	a0,s6
 998:	f09ff0ef          	jal	8a0 <putc>
 99c:	a019                	j	9a2 <vprintf+0x44>
    } else if (state == '%') {
 99e:	03598363          	beq	s3,s5,9c4 <vprintf+0x66>
  for (i = 0; fmt[i]; i++) {
 9a2:	0019079b          	addiw	a5,s2,1
 9a6:	893e                	mv	s2,a5
 9a8:	873e                	mv	a4,a5
 9aa:	97d2                	add	a5,a5,s4
 9ac:	0007c483          	lbu	s1,0(a5)
 9b0:	24048763          	beqz	s1,bfe <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 9b4:	0004879b          	sext.w	a5,s1
    if (state == 0) {
 9b8:	fe0993e3          	bnez	s3,99e <vprintf+0x40>
      if (c0 == '%') {
 9bc:	fd579ce3          	bne	a5,s5,994 <vprintf+0x36>
        state = '%';
 9c0:	89be                	mv	s3,a5
 9c2:	b7c5                	j	9a2 <vprintf+0x44>
        c1 = fmt[i + 1] & 0xff;
 9c4:	00ea06b3          	add	a3,s4,a4
 9c8:	0016c603          	lbu	a2,1(a3)
      if (c1)
 9cc:	24060563          	beqz	a2,c16 <vprintf+0x2b8>
      if (c0 == 'd') {
 9d0:	0b878763          	beq	a5,s8,a7e <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 9d4:	f9478693          	addi	a3,a5,-108
 9d8:	0016b693          	seqz	a3,a3
 9dc:	f9c60593          	addi	a1,a2,-100
 9e0:	0015b593          	seqz	a1,a1
 9e4:	8df5                	and	a1,a1,a3
 9e6:	e9c5                	bnez	a1,a96 <vprintf+0x138>
        c2 = fmt[i + 2] & 0xff;
 9e8:	9752                	add	a4,a4,s4
 9ea:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 9ee:	f9460713          	addi	a4,a2,-108
 9f2:	00173713          	seqz	a4,a4
 9f6:	8f75                	and	a4,a4,a3
 9f8:	f9c50593          	addi	a1,a0,-100
 9fc:	0015b593          	seqz	a1,a1
 a00:	8df9                	and	a1,a1,a4
 a02:	e5dd                	bnez	a1,ab0 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 a04:	07500593          	li	a1,117
 a08:	0cb78163          	beq	a5,a1,aca <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if (c0 == 'l' && c1 == 'u') {
 a0c:	f8b60593          	addi	a1,a2,-117
 a10:	0015b593          	seqz	a1,a1
 a14:	8df5                	and	a1,a1,a3
 a16:	e5f1                	bnez	a1,ae2 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 a18:	f8b50593          	addi	a1,a0,-117
 a1c:	0015b593          	seqz	a1,a1
 a20:	8df9                	and	a1,a1,a4
 a22:	ede9                	bnez	a1,afc <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 a24:	07800593          	li	a1,120
 a28:	0eb78763          	beq	a5,a1,b16 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if (c0 == 'l' && c1 == 'x') {
 a2c:	f8860613          	addi	a2,a2,-120
 a30:	00163613          	seqz	a2,a2
 a34:	8ef1                	and	a3,a3,a2
 a36:	0e069c63          	bnez	a3,b2e <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 a3a:	f8850513          	addi	a0,a0,-120
 a3e:	00153513          	seqz	a0,a0
 a42:	8f69                	and	a4,a4,a0
 a44:	10071263          	bnez	a4,b48 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 a48:	07000713          	li	a4,112
 a4c:	10e78a63          	beq	a5,a4,b60 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 a50:	06300713          	li	a4,99
 a54:	14e78a63          	beq	a5,a4,ba8 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 a58:	07300713          	li	a4,115
 a5c:	16e78063          	beq	a5,a4,bbc <vprintf+0x25e>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 a60:	02500713          	li	a4,37
 a64:	18e78863          	beq	a5,a4,bf4 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 a68:	02500593          	li	a1,37
 a6c:	855a                	mv	a0,s6
 a6e:	e33ff0ef          	jal	8a0 <putc>
        putc(fd, c0);
 a72:	85a6                	mv	a1,s1
 a74:	855a                	mv	a0,s6
 a76:	e2bff0ef          	jal	8a0 <putc>
      }

      state = 0;
 a7a:	4981                	li	s3,0
 a7c:	b71d                	j	9a2 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 a7e:	008b8493          	addi	s1,s7,8 # 2008 <freep+0x8>
 a82:	4685                	li	a3,1
 a84:	4629                	li	a2,10
 a86:	000ba583          	lw	a1,0(s7)
 a8a:	855a                	mv	a0,s6
 a8c:	e33ff0ef          	jal	8be <printint>
 a90:	8ba6                	mv	s7,s1
      state = 0;
 a92:	4981                	li	s3,0
 a94:	b739                	j	9a2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 a96:	008b8493          	addi	s1,s7,8
 a9a:	4685                	li	a3,1
 a9c:	4629                	li	a2,10
 a9e:	000bb583          	ld	a1,0(s7)
 aa2:	855a                	mv	a0,s6
 aa4:	e1bff0ef          	jal	8be <printint>
        i += 1;
 aa8:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 aaa:	8ba6                	mv	s7,s1
      state = 0;
 aac:	4981                	li	s3,0
 aae:	bdd5                	j	9a2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 ab0:	008b8493          	addi	s1,s7,8
 ab4:	4685                	li	a3,1
 ab6:	4629                	li	a2,10
 ab8:	000bb583          	ld	a1,0(s7)
 abc:	855a                	mv	a0,s6
 abe:	e01ff0ef          	jal	8be <printint>
        i += 2;
 ac2:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 ac4:	8ba6                	mv	s7,s1
      state = 0;
 ac6:	4981                	li	s3,0
        i += 2;
 ac8:	bde9                	j	9a2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 aca:	008b8493          	addi	s1,s7,8
 ace:	4681                	li	a3,0
 ad0:	4629                	li	a2,10
 ad2:	000be583          	lwu	a1,0(s7)
 ad6:	855a                	mv	a0,s6
 ad8:	de7ff0ef          	jal	8be <printint>
 adc:	8ba6                	mv	s7,s1
      state = 0;
 ade:	4981                	li	s3,0
 ae0:	b5c9                	j	9a2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 ae2:	008b8493          	addi	s1,s7,8
 ae6:	4681                	li	a3,0
 ae8:	4629                	li	a2,10
 aea:	000bb583          	ld	a1,0(s7)
 aee:	855a                	mv	a0,s6
 af0:	dcfff0ef          	jal	8be <printint>
        i += 1;
 af4:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 af6:	8ba6                	mv	s7,s1
      state = 0;
 af8:	4981                	li	s3,0
 afa:	b565                	j	9a2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 afc:	008b8493          	addi	s1,s7,8
 b00:	4681                	li	a3,0
 b02:	4629                	li	a2,10
 b04:	000bb583          	ld	a1,0(s7)
 b08:	855a                	mv	a0,s6
 b0a:	db5ff0ef          	jal	8be <printint>
        i += 2;
 b0e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 b10:	8ba6                	mv	s7,s1
      state = 0;
 b12:	4981                	li	s3,0
        i += 2;
 b14:	b579                	j	9a2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 b16:	008b8493          	addi	s1,s7,8
 b1a:	4681                	li	a3,0
 b1c:	4641                	li	a2,16
 b1e:	000be583          	lwu	a1,0(s7)
 b22:	855a                	mv	a0,s6
 b24:	d9bff0ef          	jal	8be <printint>
 b28:	8ba6                	mv	s7,s1
      state = 0;
 b2a:	4981                	li	s3,0
 b2c:	bd9d                	j	9a2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 b2e:	008b8493          	addi	s1,s7,8
 b32:	4681                	li	a3,0
 b34:	4641                	li	a2,16
 b36:	000bb583          	ld	a1,0(s7)
 b3a:	855a                	mv	a0,s6
 b3c:	d83ff0ef          	jal	8be <printint>
        i += 1;
 b40:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 b42:	8ba6                	mv	s7,s1
      state = 0;
 b44:	4981                	li	s3,0
 b46:	bdb1                	j	9a2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 b48:	008b8493          	addi	s1,s7,8
 b4c:	4641                	li	a2,16
 b4e:	000bb583          	ld	a1,0(s7)
 b52:	855a                	mv	a0,s6
 b54:	d6bff0ef          	jal	8be <printint>
        i += 2;
 b58:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 b5a:	8ba6                	mv	s7,s1
      state = 0;
 b5c:	4981                	li	s3,0
        i += 2;
 b5e:	b591                	j	9a2 <vprintf+0x44>
 b60:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 b62:	008b8793          	addi	a5,s7,8
 b66:	8cbe                	mv	s9,a5
 b68:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 b6c:	03000593          	li	a1,48
 b70:	855a                	mv	a0,s6
 b72:	d2fff0ef          	jal	8a0 <putc>
  putc(fd, 'x');
 b76:	07800593          	li	a1,120
 b7a:	855a                	mv	a0,s6
 b7c:	d25ff0ef          	jal	8a0 <putc>
 b80:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 b82:	00000b97          	auipc	s7,0x0
 b86:	47eb8b93          	addi	s7,s7,1150 # 1000 <digits>
 b8a:	03c9d793          	srli	a5,s3,0x3c
 b8e:	97de                	add	a5,a5,s7
 b90:	0007c583          	lbu	a1,0(a5)
 b94:	855a                	mv	a0,s6
 b96:	d0bff0ef          	jal	8a0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 b9a:	0992                	slli	s3,s3,0x4
 b9c:	34fd                	addiw	s1,s1,-1
 b9e:	f4f5                	bnez	s1,b8a <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 ba0:	8be6                	mv	s7,s9
      state = 0;
 ba2:	4981                	li	s3,0
 ba4:	6ca2                	ld	s9,8(sp)
 ba6:	bbf5                	j	9a2 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 ba8:	008b8493          	addi	s1,s7,8
 bac:	000bc583          	lbu	a1,0(s7)
 bb0:	855a                	mv	a0,s6
 bb2:	cefff0ef          	jal	8a0 <putc>
 bb6:	8ba6                	mv	s7,s1
      state = 0;
 bb8:	4981                	li	s3,0
 bba:	b3e5                	j	9a2 <vprintf+0x44>
        if ((s = va_arg(ap, char *)) == 0)
 bbc:	008b8993          	addi	s3,s7,8
 bc0:	000bb483          	ld	s1,0(s7)
 bc4:	cc91                	beqz	s1,be0 <vprintf+0x282>
        for (; *s; s++)
 bc6:	0004c583          	lbu	a1,0(s1)
 bca:	c195                	beqz	a1,bee <vprintf+0x290>
          putc(fd, *s);
 bcc:	855a                	mv	a0,s6
 bce:	cd3ff0ef          	jal	8a0 <putc>
        for (; *s; s++)
 bd2:	0485                	addi	s1,s1,1
 bd4:	0004c583          	lbu	a1,0(s1)
 bd8:	f9f5                	bnez	a1,bcc <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 bda:	8bce                	mv	s7,s3
      state = 0;
 bdc:	4981                	li	s3,0
 bde:	b3d1                	j	9a2 <vprintf+0x44>
          s = "(null)";
 be0:	00000497          	auipc	s1,0x0
 be4:	41848493          	addi	s1,s1,1048 # ff8 <malloc+0x2e6>
        for (; *s; s++)
 be8:	02800593          	li	a1,40
 bec:	b7c5                	j	bcc <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 bee:	8bce                	mv	s7,s3
      state = 0;
 bf0:	4981                	li	s3,0
 bf2:	bb45                	j	9a2 <vprintf+0x44>
        putc(fd, '%');
 bf4:	85be                	mv	a1,a5
 bf6:	855a                	mv	a0,s6
 bf8:	ca9ff0ef          	jal	8a0 <putc>
 bfc:	bdbd                	j	a7a <vprintf+0x11c>
 bfe:	6906                	ld	s2,64(sp)
 c00:	79e2                	ld	s3,56(sp)
 c02:	7a42                	ld	s4,48(sp)
 c04:	7aa2                	ld	s5,40(sp)
 c06:	7b02                	ld	s6,32(sp)
 c08:	6be2                	ld	s7,24(sp)
 c0a:	6c42                	ld	s8,16(sp)
    }
  }
}
 c0c:	60e6                	ld	ra,88(sp)
 c0e:	6446                	ld	s0,80(sp)
 c10:	64a6                	ld	s1,72(sp)
 c12:	6125                	addi	sp,sp,96
 c14:	8082                	ret
      if (c0 == 'd') {
 c16:	06400713          	li	a4,100
 c1a:	e6e782e3          	beq	a5,a4,a7e <vprintf+0x120>
      } else if (c0 == 'l' && c1 == 'd') {
 c1e:	f9478693          	addi	a3,a5,-108
 c22:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 c26:	8532                	mv	a0,a2
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 c28:	4701                	li	a4,0
 c2a:	bbe9                	j	a04 <vprintf+0xa6>

0000000000000c2c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c2c:	715d                	addi	sp,sp,-80
 c2e:	ec06                	sd	ra,24(sp)
 c30:	e822                	sd	s0,16(sp)
 c32:	1000                	addi	s0,sp,32
 c34:	e010                	sd	a2,0(s0)
 c36:	e414                	sd	a3,8(s0)
 c38:	e818                	sd	a4,16(s0)
 c3a:	ec1c                	sd	a5,24(s0)
 c3c:	03043023          	sd	a6,32(s0)
 c40:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 c44:	8622                	mv	a2,s0
 c46:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 c4a:	d15ff0ef          	jal	95e <vprintf>
}
 c4e:	60e2                	ld	ra,24(sp)
 c50:	6442                	ld	s0,16(sp)
 c52:	6161                	addi	sp,sp,80
 c54:	8082                	ret

0000000000000c56 <printf>:

void
printf(const char *fmt, ...)
{
 c56:	711d                	addi	sp,sp,-96
 c58:	ec06                	sd	ra,24(sp)
 c5a:	e822                	sd	s0,16(sp)
 c5c:	1000                	addi	s0,sp,32
 c5e:	e40c                	sd	a1,8(s0)
 c60:	e810                	sd	a2,16(s0)
 c62:	ec14                	sd	a3,24(s0)
 c64:	f018                	sd	a4,32(s0)
 c66:	f41c                	sd	a5,40(s0)
 c68:	03043823          	sd	a6,48(s0)
 c6c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 c70:	00840613          	addi	a2,s0,8
 c74:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 c78:	85aa                	mv	a1,a0
 c7a:	4505                	li	a0,1
 c7c:	ce3ff0ef          	jal	95e <vprintf>
}
 c80:	60e2                	ld	ra,24(sp)
 c82:	6442                	ld	s0,16(sp)
 c84:	6125                	addi	sp,sp,96
 c86:	8082                	ret

0000000000000c88 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c88:	1141                	addi	sp,sp,-16
 c8a:	e406                	sd	ra,8(sp)
 c8c:	e022                	sd	s0,0(sp)
 c8e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 c90:	ff050713          	addi	a4,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c94:	00001797          	auipc	a5,0x1
 c98:	36c7b783          	ld	a5,876(a5) # 2000 <freep>
 c9c:	a095                	j	d00 <free+0x78>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
 c9e:	ff852583          	lw	a1,-8(a0)
 ca2:	6390                	ld	a2,0(a5)
 ca4:	02059813          	slli	a6,a1,0x20
 ca8:	01c85693          	srli	a3,a6,0x1c
 cac:	96ba                	add	a3,a3,a4
 cae:	02d60563          	beq	a2,a3,cd8 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 cb2:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
 cb6:	4790                	lw	a2,8(a5)
 cb8:	02061593          	slli	a1,a2,0x20
 cbc:	01c5d693          	srli	a3,a1,0x1c
 cc0:	96be                	add	a3,a3,a5
 cc2:	02d70263          	beq	a4,a3,ce6 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 cc6:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 cc8:	00001717          	auipc	a4,0x1
 ccc:	32f73c23          	sd	a5,824(a4) # 2000 <freep>
}
 cd0:	60a2                	ld	ra,8(sp)
 cd2:	6402                	ld	s0,0(sp)
 cd4:	0141                	addi	sp,sp,16
 cd6:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 cd8:	4614                	lw	a3,8(a2)
 cda:	9ead                	addw	a3,a3,a1
 cdc:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 ce0:	6394                	ld	a3,0(a5)
 ce2:	6290                	ld	a2,0(a3)
 ce4:	b7f9                	j	cb2 <free+0x2a>
    p->s.size += bp->s.size;
 ce6:	ff852703          	lw	a4,-8(a0)
 cea:	9f31                	addw	a4,a4,a2
 cec:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 cee:	ff053703          	ld	a4,-16(a0)
 cf2:	bfd1                	j	cc6 <free+0x3e>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cf4:	6394                	ld	a3,0(a5)
 cf6:	00d7e463          	bltu	a5,a3,cfe <free+0x76>
 cfa:	fad762e3          	bltu	a4,a3,c9e <free+0x16>
 cfe:	87b6                	mv	a5,a3
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d00:	fee7fae3          	bgeu	a5,a4,cf4 <free+0x6c>
 d04:	6394                	ld	a3,0(a5)
 d06:	f8d76ce3          	bltu	a4,a3,c9e <free+0x16>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d0a:	f8d7fae3          	bgeu	a5,a3,c9e <free+0x16>
 d0e:	87b6                	mv	a5,a3
 d10:	bfc5                	j	d00 <free+0x78>

0000000000000d12 <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
 d12:	7139                	addi	sp,sp,-64
 d14:	fc06                	sd	ra,56(sp)
 d16:	f822                	sd	s0,48(sp)
 d18:	f04a                	sd	s2,32(sp)
 d1a:	ec4e                	sd	s3,24(sp)
 d1c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 d1e:	02051993          	slli	s3,a0,0x20
 d22:	0209d993          	srli	s3,s3,0x20
 d26:	09bd                	addi	s3,s3,15
 d28:	0049d993          	srli	s3,s3,0x4
 d2c:	2985                	addiw	s3,s3,1
 d2e:	894e                	mv	s2,s3
  if ((prevp = freep) == 0) {
 d30:	00001517          	auipc	a0,0x1
 d34:	2d053503          	ld	a0,720(a0) # 2000 <freep>
 d38:	c905                	beqz	a0,d68 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 d3a:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 d3c:	4798                	lw	a4,8(a5)
 d3e:	09377663          	bgeu	a4,s3,dca <malloc+0xb8>
 d42:	f426                	sd	s1,40(sp)
 d44:	e852                	sd	s4,16(sp)
 d46:	e456                	sd	s5,8(sp)
 d48:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 d4a:	8a4e                	mv	s4,s3
 d4c:	6705                	lui	a4,0x1
 d4e:	00e9f363          	bgeu	s3,a4,d54 <malloc+0x42>
 d52:	6a05                	lui	s4,0x1
 d54:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 d58:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 d5c:	00001497          	auipc	s1,0x1
 d60:	2a448493          	addi	s1,s1,676 # 2000 <freep>
  if (p == SBRK_ERROR)
 d64:	5afd                	li	s5,-1
 d66:	a83d                	j	da4 <malloc+0x92>
 d68:	f426                	sd	s1,40(sp)
 d6a:	e852                	sd	s4,16(sp)
 d6c:	e456                	sd	s5,8(sp)
 d6e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 d70:	00003797          	auipc	a5,0x3
 d74:	2a078793          	addi	a5,a5,672 # 4010 <base>
 d78:	00001717          	auipc	a4,0x1
 d7c:	28f73423          	sd	a5,648(a4) # 2000 <freep>
 d80:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 d82:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 d86:	b7d1                	j	d4a <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 d88:	6398                	ld	a4,0(a5)
 d8a:	e118                	sd	a4,0(a0)
 d8c:	a899                	j	de2 <malloc+0xd0>
  hp->s.size = nu;
 d8e:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 d92:	0541                	addi	a0,a0,16
 d94:	ef5ff0ef          	jal	c88 <free>
  return freep;
 d98:	6088                	ld	a0,0(s1)
      if ((p = morecore(nunits)) == 0)
 d9a:	c125                	beqz	a0,dfa <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 d9c:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 d9e:	4798                	lw	a4,8(a5)
 da0:	03277163          	bgeu	a4,s2,dc2 <malloc+0xb0>
    if (p == freep)
 da4:	6098                	ld	a4,0(s1)
 da6:	853e                	mv	a0,a5
 da8:	fef71ae3          	bne	a4,a5,d9c <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 dac:	8552                	mv	a0,s4
 dae:	9ffff0ef          	jal	7ac <sbrk>
  if (p == SBRK_ERROR)
 db2:	fd551ee3          	bne	a0,s5,d8e <malloc+0x7c>
        return 0;
 db6:	4501                	li	a0,0
 db8:	74a2                	ld	s1,40(sp)
 dba:	6a42                	ld	s4,16(sp)
 dbc:	6aa2                	ld	s5,8(sp)
 dbe:	6b02                	ld	s6,0(sp)
 dc0:	a03d                	j	dee <malloc+0xdc>
 dc2:	74a2                	ld	s1,40(sp)
 dc4:	6a42                	ld	s4,16(sp)
 dc6:	6aa2                	ld	s5,8(sp)
 dc8:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
 dca:	fae90fe3          	beq	s2,a4,d88 <malloc+0x76>
        p->s.size -= nunits;
 dce:	4137073b          	subw	a4,a4,s3
 dd2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 dd4:	02071693          	slli	a3,a4,0x20
 dd8:	01c6d713          	srli	a4,a3,0x1c
 ddc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 dde:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 de2:	00001717          	auipc	a4,0x1
 de6:	20a73f23          	sd	a0,542(a4) # 2000 <freep>
      return (void *)(p + 1);
 dea:	01078513          	addi	a0,a5,16
  }
}
 dee:	70e2                	ld	ra,56(sp)
 df0:	7442                	ld	s0,48(sp)
 df2:	7902                	ld	s2,32(sp)
 df4:	69e2                	ld	s3,24(sp)
 df6:	6121                	addi	sp,sp,64
 df8:	8082                	ret
 dfa:	74a2                	ld	s1,40(sp)
 dfc:	6a42                	ld	s4,16(sp)
 dfe:	6aa2                	ld	s5,8(sp)
 e00:	6b02                	ld	s6,0(sp)
 e02:	b7f5                	j	dee <malloc+0xdc>
