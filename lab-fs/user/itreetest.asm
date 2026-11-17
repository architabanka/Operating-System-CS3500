
user/_itreetest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/fs_test.h"
int
main(int argc, char **argv)
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	0100                	addi	s0,sp,128
static char fs_buffer[8 * BSIZE];

static inline void
check(int ok, const char *why)
{
  if (!ok) {
   8:	4709                	li	a4,2
   a:	04e51f63          	bne	a0,a4,68 <main+0x68>
   e:	e4d6                	sd	s5,72(sp)
  10:	fc5e                	sd	s7,56(sp)
  check(argc == 2, "itreetest requires block count");
  int n = atoi(argv[1]);
  12:	6588                	ld	a0,8(a1)
  14:	5ac000ef          	jal	5c0 <atoi>
  18:	8baa                	mv	s7,a0
  check(n >= 0 && n <= 779, "supported tree fixture size");
  1a:	8aaa                	mv	s5,a0
  1c:	30b00793          	li	a5,779
  20:	06a7eb63          	bltu	a5,a0,96 <main+0x96>
  24:	e0da                	sd	s6,64(sp)
}

static inline void
makefile(const char *name, uint blocks, uint seed)
{
  unlink(name);
  26:	00001517          	auipc	a0,0x1
  2a:	d4a50513          	addi	a0,a0,-694 # d70 <malloc+0x158>
  2e:	708000ef          	jal	736 <unlink>
  int fd = open(name, O_CREATE | O_WRONLY | O_TRUNC);
  32:	60100593          	li	a1,1537
  36:	00001517          	auipc	a0,0x1
  3a:	d3a50513          	addi	a0,a0,-710 # d70 <malloc+0x158>
  3e:	6e8000ef          	jal	726 <open>
  42:	8b2a                	mv	s6,a0
  if (!ok) {
  44:	06054e63          	bltz	a0,c0 <main+0xc0>
  48:	f4a6                	sd	s1,104(sp)
  4a:	f0ca                	sd	s2,96(sp)
  4c:	ecce                	sd	s3,88(sp)
  4e:	e8d2                	sd	s4,80(sp)
  50:	f862                	sd	s8,48(sp)
  check(fd >= 0, "create test file");
  for (uint first = 0; first < blocks;) {
  52:	4981                	li	s3,0
    uint n = blocks - first;
    if (n > 8)
  54:	4c21                	li	s8,8
      n = 8;
    for (uint b = 0; b < n; b++)
      for (uint j = 0; j < BSIZE; j++)
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
  56:	00001497          	auipc	s1,0x1
  5a:	fba48493          	addi	s1,s1,-70 # 1010 <fs_buffer>
    return seed;
  5e:	492d                	li	s2,11
  for (uint first = 0; first < blocks;) {
  60:	320b8a63          	beqz	s7,394 <main+0x394>
  64:	f466                	sd	s9,40(sp)
  66:	a229                	j	170 <main+0x170>
  68:	f4a6                	sd	s1,104(sp)
  6a:	f0ca                	sd	s2,96(sp)
  6c:	ecce                	sd	s3,88(sp)
  6e:	e8d2                	sd	s4,80(sp)
  70:	e4d6                	sd	s5,72(sp)
  72:	e0da                	sd	s6,64(sp)
  74:	fc5e                	sd	s7,56(sp)
  76:	f862                	sd	s8,48(sp)
  78:	f466                	sd	s9,40(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
  7a:	00001617          	auipc	a2,0x1
  7e:	c9660613          	addi	a2,a2,-874 # d10 <malloc+0xf8>
  82:	00001597          	auipc	a1,0x1
  86:	cb658593          	addi	a1,a1,-842 # d38 <malloc+0x120>
  8a:	853a                	mv	a0,a4
  8c:	2a7000ef          	jal	b32 <fprintf>
    exit(1);
  90:	4505                	li	a0,1
  92:	654000ef          	jal	6e6 <exit>
  96:	f4a6                	sd	s1,104(sp)
  98:	f0ca                	sd	s2,96(sp)
  9a:	ecce                	sd	s3,88(sp)
  9c:	e8d2                	sd	s4,80(sp)
  9e:	e0da                	sd	s6,64(sp)
  a0:	f862                	sd	s8,48(sp)
  a2:	f466                	sd	s9,40(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
  a4:	00001617          	auipc	a2,0x1
  a8:	cac60613          	addi	a2,a2,-852 # d50 <malloc+0x138>
  ac:	00001597          	auipc	a1,0x1
  b0:	c8c58593          	addi	a1,a1,-884 # d38 <malloc+0x120>
  b4:	4509                	li	a0,2
  b6:	27d000ef          	jal	b32 <fprintf>
    exit(1);
  ba:	4505                	li	a0,1
  bc:	62a000ef          	jal	6e6 <exit>
  c0:	f4a6                	sd	s1,104(sp)
  c2:	f0ca                	sd	s2,96(sp)
  c4:	ecce                	sd	s3,88(sp)
  c6:	e8d2                	sd	s4,80(sp)
  c8:	f862                	sd	s8,48(sp)
  ca:	f466                	sd	s9,40(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
  cc:	00001617          	auipc	a2,0x1
  d0:	cb460613          	addi	a2,a2,-844 # d80 <malloc+0x168>
  d4:	00001597          	auipc	a1,0x1
  d8:	c6458593          	addi	a1,a1,-924 # d38 <malloc+0x120>
  dc:	4509                	li	a0,2
  de:	255000ef          	jal	b32 <fprintf>
    exit(1);
  e2:	4505                	li	a0,1
  e4:	602000ef          	jal	6e6 <exit>
      for (uint j = 0; j < BSIZE; j++)
  e8:	26c5                	addiw	a3,a3,17
  ea:	0ff6f693          	zext.b	a3,a3
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
  ee:	00b707bb          	addw	a5,a4,a1
  if (byte < 4)
  f2:	04e57263          	bgeu	a0,a4,136 <main+0x136>
  if (byte == 4)
  f6:	33070b63          	beq	a4,a6,42c <main+0x42c>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
  fa:	1782                	slli	a5,a5,0x20
  fc:	9381                	srli	a5,a5,0x20
  fe:	97a6                	add	a5,a5,s1
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
 100:	00d8c633          	xor	a2,a7,a3
 104:	00664633          	xor	a2,a2,t1
 108:	03f64613          	xori	a2,a2,63
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
 10c:	00c78023          	sb	a2,0(a5)
      for (uint j = 0; j < BSIZE; j++)
 110:	2705                	addiw	a4,a4,1
 112:	fdc71be3          	bne	a4,t3,e8 <main+0xe8>
    for (uint b = 0; b < n; b++)
 116:	2f05                	addiw	t5,t5,1
 118:	f838889b          	addiw	a7,a7,-125
 11c:	0ff8f893          	zext.b	a7,a7
 120:	4005859b          	addiw	a1,a1,1024
 124:	034f7963          	bgeu	t5,s4,156 <main+0x156>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
 128:	01e98ebb          	addw	t4,s3,t5
 12c:	4681                	li	a3,0
      for (uint j = 0; j < BSIZE; j++)
 12e:	4701                	li	a4,0
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
 130:	008ed31b          	srliw	t1,t4,0x8
 134:	bf6d                	j	ee <main+0xee>
    return (block >> (8 * byte)) & 255;
 136:	0037161b          	slliw	a2,a4,0x3
 13a:	00ced63b          	srlw	a2,t4,a2
 13e:	0ff67613          	zext.b	a2,a2
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
 142:	1782                	slli	a5,a5,0x20
 144:	9381                	srli	a5,a5,0x20
 146:	97a6                	add	a5,a5,s1
 148:	00c78023          	sb	a2,0(a5)
      for (uint j = 0; j < BSIZE; j++)
 14c:	2705                	addiw	a4,a4,1
 14e:	26c5                	addiw	a3,a3,17
 150:	0ff6f693          	zext.b	a3,a3
 154:	bf69                	j	ee <main+0xee>
    check(write(fd, fs_buffer, n * BSIZE) == n * BSIZE, "write full test data");
 156:	00aa161b          	slliw	a2,s4,0xa
 15a:	8cb2                	mv	s9,a2
 15c:	85a6                	mv	a1,s1
 15e:	855a                	mv	a0,s6
 160:	5a6000ef          	jal	706 <write>
  if (!ok) {
 164:	04ac9163          	bne	s9,a0,1a6 <main+0x1a6>
    first += n;
 168:	014989bb          	addw	s3,s3,s4
  for (uint first = 0; first < blocks;) {
 16c:	0559fb63          	bgeu	s3,s5,1c2 <main+0x1c2>
    uint n = blocks - first;
 170:	413b873b          	subw	a4,s7,s3
 174:	87ba                	mv	a5,a4
    if (n > 8)
 176:	00ec7363          	bgeu	s8,a4,17c <main+0x17c>
 17a:	47a1                	li	a5,8
 17c:	00078a1b          	sext.w	s4,a5
    for (uint b = 0; b < n; b++)
 180:	1f3a8d63          	beq	s5,s3,37a <main+0x37a>
 184:	0069989b          	slliw	a7,s3,0x6
 188:	411988bb          	subw	a7,s3,a7
 18c:	0018989b          	slliw	a7,a7,0x1
 190:	013888bb          	addw	a7,a7,s3
 194:	0ff8f893          	zext.b	a7,a7
 198:	4581                	li	a1,0
 19a:	4f01                	li	t5,0
  if (byte < 4)
 19c:	450d                	li	a0,3
  if (byte == 4)
 19e:	4811                	li	a6,4
      for (uint j = 0; j < BSIZE; j++)
 1a0:	40000e13          	li	t3,1024
 1a4:	b751                	j	128 <main+0x128>
    fprintf(2, "TEST FAILURE: %s\n", why);
 1a6:	00001617          	auipc	a2,0x1
 1aa:	bf260613          	addi	a2,a2,-1038 # d98 <malloc+0x180>
 1ae:	00001597          	auipc	a1,0x1
 1b2:	b8a58593          	addi	a1,a1,-1142 # d38 <malloc+0x120>
 1b6:	4509                	li	a0,2
 1b8:	17b000ef          	jal	b32 <fprintf>
    exit(1);
 1bc:	4505                	li	a0,1
 1be:	528000ef          	jal	6e6 <exit>
 1c2:	7ca2                	ld	s9,40(sp)
 1c4:	aac1                	j	394 <main+0x394>
 1c6:	f466                	sd	s9,40(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
 1c8:	00001617          	auipc	a2,0x1
 1cc:	be860613          	addi	a2,a2,-1048 # db0 <malloc+0x198>
 1d0:	00001597          	auipc	a1,0x1
 1d4:	b6858593          	addi	a1,a1,-1176 # d38 <malloc+0x120>
 1d8:	4509                	li	a0,2
 1da:	159000ef          	jal	b32 <fprintf>
    exit(1);
 1de:	4505                	li	a0,1
 1e0:	506000ef          	jal	6e6 <exit>
 1e4:	f466                	sd	s9,40(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
 1e6:	00001617          	auipc	a2,0x1
 1ea:	be260613          	addi	a2,a2,-1054 # dc8 <malloc+0x1b0>
 1ee:	00001597          	auipc	a1,0x1
 1f2:	b4a58593          	addi	a1,a1,-1206 # d38 <malloc+0x120>
 1f6:	4509                	li	a0,2
 1f8:	13b000ef          	jal	b32 <fprintf>
    exit(1);
 1fc:	4505                	li	a0,1
 1fe:	4e8000ef          	jal	6e6 <exit>
 202:	f466                	sd	s9,40(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
 204:	00001617          	auipc	a2,0x1
 208:	bdc60613          	addi	a2,a2,-1060 # de0 <malloc+0x1c8>
 20c:	00001597          	auipc	a1,0x1
 210:	b2c58593          	addi	a1,a1,-1236 # d38 <malloc+0x120>
 214:	4509                	li	a0,2
 216:	11d000ef          	jal	b32 <fprintf>
    exit(1);
 21a:	4505                	li	a0,1
 21c:	4ca000ef          	jal	6e6 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 220:	00001617          	auipc	a2,0x1
 224:	bd060613          	addi	a2,a2,-1072 # df0 <malloc+0x1d8>
 228:	00001597          	auipc	a1,0x1
 22c:	b1058593          	addi	a1,a1,-1264 # d38 <malloc+0x120>
 230:	4509                	li	a0,2
 232:	101000ef          	jal	b32 <fprintf>
    exit(1);
 236:	4505                	li	a0,1
 238:	4ae000ef          	jal	6e6 <exit>
    uint n = blocks - first;
    if (n > 8)
      n = 8;
    check(read(fd, fs_buffer, n * BSIZE) == n * BSIZE, "read full test data");
    for (uint b = 0; b < n; b++) {
      for (uint j = 0; j < BSIZE; j++) {
 23c:	2745                	addiw	a4,a4,17
 23e:	0ff77713          	zext.b	a4,a4
  if (byte < 4)
 242:	04f57863          	bgeu	a0,a5,292 <main+0x292>
  if (byte == 4)
 246:	1f278163          	beq	a5,s2,428 <main+0x428>
        uint off = (first + b) * BSIZE + j;
        uchar want = pattern(first + b, j, seed);
        for (int k = 0; k < np; k++)
          if (patches[k].offset == off)
            want = patches[k].value;
        check((uchar)fs_buffer[b * BSIZE + j] == want, "file contents differ");
 24a:	00b7863b          	addw	a2,a5,a1
 24e:	1602                	slli	a2,a2,0x20
 250:	9201                	srli	a2,a2,0x20
 252:	9626                	add	a2,a2,s1
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
 254:	010746b3          	xor	a3,a4,a6
 258:	0116c6b3          	xor	a3,a3,a7
 25c:	03f6c693          	xori	a3,a3,63
  if (!ok) {
 260:	00064603          	lbu	a2,0(a2)
 264:	0ff6f693          	zext.b	a3,a3
 268:	04d61963          	bne	a2,a3,2ba <main+0x2ba>
      for (uint j = 0; j < BSIZE; j++) {
 26c:	2785                	addiw	a5,a5,1
 26e:	fc6797e3          	bne	a5,t1,23c <main+0x23c>
    for (uint b = 0; b < n; b++) {
 272:	2f05                	addiw	t5,t5,1
 274:	4005859b          	addiw	a1,a1,1024
 278:	f838081b          	addiw	a6,a6,-125
 27c:	0ff87813          	zext.b	a6,a6
 280:	056f7b63          	bgeu	t5,s6,2d6 <main+0x2d6>
        uint off = (first + b) * BSIZE + j;
 284:	013f0e3b          	addw	t3,t5,s3
 288:	4701                	li	a4,0
      for (uint j = 0; j < BSIZE; j++) {
 28a:	4781                	li	a5,0
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
 28c:	008e589b          	srliw	a7,t3,0x8
 290:	bf4d                	j	242 <main+0x242>
    return (block >> (8 * byte)) & 255;
 292:	0037961b          	slliw	a2,a5,0x3
 296:	00ce563b          	srlw	a2,t3,a2
 29a:	0ff67613          	zext.b	a2,a2
        check((uchar)fs_buffer[b * BSIZE + j] == want, "file contents differ");
 29e:	00b786bb          	addw	a3,a5,a1
 2a2:	1682                	slli	a3,a3,0x20
 2a4:	9281                	srli	a3,a3,0x20
 2a6:	96a6                	add	a3,a3,s1
  if (!ok) {
 2a8:	0006c683          	lbu	a3,0(a3)
 2ac:	00c69763          	bne	a3,a2,2ba <main+0x2ba>
      for (uint j = 0; j < BSIZE; j++) {
 2b0:	2785                	addiw	a5,a5,1
 2b2:	2745                	addiw	a4,a4,17
 2b4:	0ff77713          	zext.b	a4,a4
 2b8:	b769                	j	242 <main+0x242>
    fprintf(2, "TEST FAILURE: %s\n", why);
 2ba:	00001617          	auipc	a2,0x1
 2be:	b4e60613          	addi	a2,a2,-1202 # e08 <malloc+0x1f0>
 2c2:	00001597          	auipc	a1,0x1
 2c6:	a7658593          	addi	a1,a1,-1418 # d38 <malloc+0x120>
 2ca:	4509                	li	a0,2
 2cc:	067000ef          	jal	b32 <fprintf>
    exit(1);
 2d0:	4505                	li	a0,1
 2d2:	414000ef          	jal	6e6 <exit>
      }
    }
    first += n;
 2d6:	016989bb          	addw	s3,s3,s6
  for (uint first = 0; first < blocks;) {
 2da:	1159f463          	bgeu	s3,s5,3e2 <main+0x3e2>
    uint n = blocks - first;
 2de:	413b873b          	subw	a4,s7,s3
 2e2:	87ba                	mv	a5,a4
    if (n > 8)
 2e4:	00ec7363          	bgeu	s8,a4,2ea <main+0x2ea>
 2e8:	47a1                	li	a5,8
 2ea:	00078b1b          	sext.w	s6,a5
    check(read(fd, fs_buffer, n * BSIZE) == n * BSIZE, "read full test data");
 2ee:	00a7961b          	slliw	a2,a5,0xa
 2f2:	8cb2                	mv	s9,a2
 2f4:	85a6                	mv	a1,s1
 2f6:	8552                	mv	a0,s4
 2f8:	406000ef          	jal	6fe <read>
  if (!ok) {
 2fc:	f2ac92e3          	bne	s9,a0,220 <main+0x220>
    for (uint b = 0; b < n; b++) {
 300:	0f3a8163          	beq	s5,s3,3e2 <main+0x3e2>
 304:	0069981b          	slliw	a6,s3,0x6
 308:	4109883b          	subw	a6,s3,a6
 30c:	0018181b          	slliw	a6,a6,0x1
 310:	0138083b          	addw	a6,a6,s3
 314:	0ff87813          	zext.b	a6,a6
 318:	4581                	li	a1,0
 31a:	4f01                	li	t5,0
  if (byte < 4)
 31c:	450d                	li	a0,3
    return seed;
 31e:	4ead                	li	t4,11
      for (uint j = 0; j < BSIZE; j++) {
 320:	40000313          	li	t1,1024
 324:	b785                	j	284 <main+0x284>
    fprintf(2, "TEST FAILURE: %s\n", why);
 326:	00001617          	auipc	a2,0x1
 32a:	afa60613          	addi	a2,a2,-1286 # e20 <malloc+0x208>
 32e:	00001597          	auipc	a1,0x1
 332:	a0a58593          	addi	a1,a1,-1526 # d38 <malloc+0x120>
 336:	4509                	li	a0,2
 338:	7fa000ef          	jal	b32 <fprintf>
    exit(1);
 33c:	4505                	li	a0,1
 33e:	3a8000ef          	jal	6e6 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 342:	00001617          	auipc	a2,0x1
 346:	afe60613          	addi	a2,a2,-1282 # e40 <malloc+0x228>
 34a:	00001597          	auipc	a1,0x1
 34e:	9ee58593          	addi	a1,a1,-1554 # d38 <malloc+0x120>
 352:	4509                	li	a0,2
 354:	7de000ef          	jal	b32 <fprintf>
    exit(1);
 358:	4505                	li	a0,1
 35a:	38c000ef          	jal	6e6 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 35e:	00001617          	auipc	a2,0x1
 362:	b0a60613          	addi	a2,a2,-1270 # e68 <malloc+0x250>
 366:	00001597          	auipc	a1,0x1
 36a:	9d258593          	addi	a1,a1,-1582 # d38 <malloc+0x120>
 36e:	4509                	li	a0,2
 370:	7c2000ef          	jal	b32 <fprintf>
    exit(1);
 374:	4505                	li	a0,1
 376:	370000ef          	jal	6e6 <exit>
    check(write(fd, fs_buffer, n * BSIZE) == n * BSIZE, "write full test data");
 37a:	00a7961b          	slliw	a2,a5,0xa
 37e:	84b2                	mv	s1,a2
 380:	00001597          	auipc	a1,0x1
 384:	c9058593          	addi	a1,a1,-880 # 1010 <fs_buffer>
 388:	855a                	mv	a0,s6
 38a:	37c000ef          	jal	706 <write>
  if (!ok) {
 38e:	e0951ce3          	bne	a0,s1,1a6 <main+0x1a6>
 392:	7ca2                	ld	s9,40(sp)
  check(close(fd) == 0, "close written file");
 394:	855a                	mv	a0,s6
 396:	378000ef          	jal	70e <close>
  if (!ok) {
 39a:	e20516e3          	bnez	a0,1c6 <main+0x1c6>

static inline void
verify(const char *name, uint blocks, uint seed, const struct patch *patches,
       int np)
{
  int fd = open(name, O_RDONLY);
 39e:	4581                	li	a1,0
 3a0:	00001517          	auipc	a0,0x1
 3a4:	9d050513          	addi	a0,a0,-1584 # d70 <malloc+0x158>
 3a8:	37e000ef          	jal	726 <open>
 3ac:	8a2a                	mv	s4,a0
  if (!ok) {
 3ae:	e2054be3          	bltz	a0,1e4 <main+0x1e4>
  check(fstat(fd, &st) == 0 && st.size == (uint64)blocks * BSIZE,
 3b2:	f8840593          	addi	a1,s0,-120
 3b6:	388000ef          	jal	73e <fstat>
 3ba:	e40514e3          	bnez	a0,202 <main+0x202>
 3be:	f466                	sd	s9,40(sp)
 3c0:	020b9713          	slli	a4,s7,0x20
 3c4:	01675793          	srli	a5,a4,0x16
  if (!ok) {
 3c8:	f9843703          	ld	a4,-104(s0)
 3cc:	e2f71ce3          	bne	a4,a5,204 <main+0x204>
  for (uint first = 0; first < blocks;) {
 3d0:	4981                	li	s3,0
    if (n > 8)
 3d2:	4c21                	li	s8,8
    check(read(fd, fs_buffer, n * BSIZE) == n * BSIZE, "read full test data");
 3d4:	00001497          	auipc	s1,0x1
 3d8:	c3c48493          	addi	s1,s1,-964 # 1010 <fs_buffer>
  if (byte == 4)
 3dc:	4911                	li	s2,4
  for (uint first = 0; first < blocks;) {
 3de:	f00a90e3          	bnez	s5,2de <main+0x2de>
  check(read(fd, fs_buffer, 1) == 0, "EOF after exact file size");
 3e2:	4605                	li	a2,1
 3e4:	00001597          	auipc	a1,0x1
 3e8:	c2c58593          	addi	a1,a1,-980 # 1010 <fs_buffer>
 3ec:	8552                	mv	a0,s4
 3ee:	310000ef          	jal	6fe <read>
  if (!ok) {
 3f2:	f915                	bnez	a0,326 <main+0x326>
  check(fd >= 0, "open for verification");
  verifyfd(fd, blocks, seed, patches, np);
  check(close(fd) == 0, "close verified file");
 3f4:	8552                	mv	a0,s4
 3f6:	318000ef          	jal	70e <close>
  if (!ok) {
 3fa:	f521                	bnez	a0,342 <main+0x342>
  makefile("fst_tree.tmp", n, 11);
  verify("fst_tree.tmp", n, 11, 0, 0);
  printf("\nTREE_BEGIN\n");
 3fc:	00001517          	auipc	a0,0x1
 400:	a5c50513          	addi	a0,a0,-1444 # e58 <malloc+0x240>
 404:	758000ef          	jal	b5c <printf>
  check(iprint("fst_tree.tmp") == 0, "iprint succeeds");
 408:	00001517          	auipc	a0,0x1
 40c:	96850513          	addi	a0,a0,-1688 # d70 <malloc+0x158>
 410:	386000ef          	jal	796 <iprint>
 414:	f529                	bnez	a0,35e <main+0x35e>
  printf("TREE_END\n");
 416:	00001517          	auipc	a0,0x1
 41a:	a6250513          	addi	a0,a0,-1438 # e78 <malloc+0x260>
 41e:	73e000ef          	jal	b5c <printf>
  // Retain fixture for independent host inspection.
  exit(0);
 422:	4501                	li	a0,0
 424:	2c2000ef          	jal	6e6 <exit>
    return seed;
 428:	8676                	mv	a2,t4
 42a:	bd95                	j	29e <main+0x29e>
 42c:	864a                	mv	a2,s2
 42e:	bb11                	j	142 <main+0x142>

0000000000000430 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 430:	1141                	addi	sp,sp,-16
 432:	e406                	sd	ra,8(sp)
 434:	e022                	sd	s0,0(sp)
 436:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 438:	bc9ff0ef          	jal	0 <main>
  exit(r);
 43c:	2aa000ef          	jal	6e6 <exit>

0000000000000440 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 440:	1141                	addi	sp,sp,-16
 442:	e406                	sd	ra,8(sp)
 444:	e022                	sd	s0,0(sp)
 446:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 448:	87aa                	mv	a5,a0
 44a:	0585                	addi	a1,a1,1
 44c:	0785                	addi	a5,a5,1
 44e:	fff5c703          	lbu	a4,-1(a1)
 452:	fee78fa3          	sb	a4,-1(a5)
 456:	fb75                	bnez	a4,44a <strcpy+0xa>
    ;
  return os;
}
 458:	60a2                	ld	ra,8(sp)
 45a:	6402                	ld	s0,0(sp)
 45c:	0141                	addi	sp,sp,16
 45e:	8082                	ret

0000000000000460 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 460:	1141                	addi	sp,sp,-16
 462:	e406                	sd	ra,8(sp)
 464:	e022                	sd	s0,0(sp)
 466:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 468:	00054783          	lbu	a5,0(a0)
 46c:	cb91                	beqz	a5,480 <strcmp+0x20>
 46e:	0005c703          	lbu	a4,0(a1)
 472:	00f71763          	bne	a4,a5,480 <strcmp+0x20>
    p++, q++;
 476:	0505                	addi	a0,a0,1
 478:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 47a:	00054783          	lbu	a5,0(a0)
 47e:	fbe5                	bnez	a5,46e <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 480:	0005c503          	lbu	a0,0(a1)
}
 484:	40a7853b          	subw	a0,a5,a0
 488:	60a2                	ld	ra,8(sp)
 48a:	6402                	ld	s0,0(sp)
 48c:	0141                	addi	sp,sp,16
 48e:	8082                	ret

0000000000000490 <strlen>:

uint
strlen(const char *s)
{
 490:	1141                	addi	sp,sp,-16
 492:	e406                	sd	ra,8(sp)
 494:	e022                	sd	s0,0(sp)
 496:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 498:	00054783          	lbu	a5,0(a0)
 49c:	cf91                	beqz	a5,4b8 <strlen+0x28>
 49e:	00150793          	addi	a5,a0,1
 4a2:	86be                	mv	a3,a5
 4a4:	0785                	addi	a5,a5,1
 4a6:	fff7c703          	lbu	a4,-1(a5)
 4aa:	ff65                	bnez	a4,4a2 <strlen+0x12>
 4ac:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 4b0:	60a2                	ld	ra,8(sp)
 4b2:	6402                	ld	s0,0(sp)
 4b4:	0141                	addi	sp,sp,16
 4b6:	8082                	ret
  for (n = 0; s[n]; n++)
 4b8:	4501                	li	a0,0
 4ba:	bfdd                	j	4b0 <strlen+0x20>

00000000000004bc <memset>:

void *
memset(void *dst, int c, uint n)
{
 4bc:	1141                	addi	sp,sp,-16
 4be:	e406                	sd	ra,8(sp)
 4c0:	e022                	sd	s0,0(sp)
 4c2:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 4c4:	ca19                	beqz	a2,4da <memset+0x1e>
 4c6:	87aa                	mv	a5,a0
 4c8:	1602                	slli	a2,a2,0x20
 4ca:	9201                	srli	a2,a2,0x20
 4cc:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 4d0:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 4d4:	0785                	addi	a5,a5,1
 4d6:	fee79de3          	bne	a5,a4,4d0 <memset+0x14>
  }
  return dst;
}
 4da:	60a2                	ld	ra,8(sp)
 4dc:	6402                	ld	s0,0(sp)
 4de:	0141                	addi	sp,sp,16
 4e0:	8082                	ret

00000000000004e2 <strchr>:

char *
strchr(const char *s, char c)
{
 4e2:	1141                	addi	sp,sp,-16
 4e4:	e406                	sd	ra,8(sp)
 4e6:	e022                	sd	s0,0(sp)
 4e8:	0800                	addi	s0,sp,16
  for (; *s; s++)
 4ea:	00054783          	lbu	a5,0(a0)
 4ee:	c799                	beqz	a5,4fc <strchr+0x1a>
    if (*s == c)
 4f0:	00f58763          	beq	a1,a5,4fe <strchr+0x1c>
  for (; *s; s++)
 4f4:	0505                	addi	a0,a0,1
 4f6:	00054783          	lbu	a5,0(a0)
 4fa:	fbfd                	bnez	a5,4f0 <strchr+0xe>
      return (char *)s;
  return 0;
 4fc:	4501                	li	a0,0
}
 4fe:	60a2                	ld	ra,8(sp)
 500:	6402                	ld	s0,0(sp)
 502:	0141                	addi	sp,sp,16
 504:	8082                	ret

0000000000000506 <gets>:

char *
gets(char *buf, int max)
{
 506:	711d                	addi	sp,sp,-96
 508:	ec86                	sd	ra,88(sp)
 50a:	e8a2                	sd	s0,80(sp)
 50c:	e4a6                	sd	s1,72(sp)
 50e:	e0ca                	sd	s2,64(sp)
 510:	fc4e                	sd	s3,56(sp)
 512:	f852                	sd	s4,48(sp)
 514:	f456                	sd	s5,40(sp)
 516:	f05a                	sd	s6,32(sp)
 518:	ec5e                	sd	s7,24(sp)
 51a:	e862                	sd	s8,16(sp)
 51c:	1080                	addi	s0,sp,96
 51e:	8baa                	mv	s7,a0
 520:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 522:	892a                	mv	s2,a0
 524:	4481                	li	s1,0
    cc = read(0, &c, 1);
 526:	faf40b13          	addi	s6,s0,-81
 52a:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;) {
 52c:	8c26                	mv	s8,s1
 52e:	0014899b          	addiw	s3,s1,1
 532:	84ce                	mv	s1,s3
 534:	0349d863          	bge	s3,s4,564 <gets+0x5e>
    cc = read(0, &c, 1);
 538:	8656                	mv	a2,s5
 53a:	85da                	mv	a1,s6
 53c:	4501                	li	a0,0
 53e:	1c0000ef          	jal	6fe <read>
    if (cc < 1)
 542:	02a05163          	blez	a0,564 <gets+0x5e>
      break;
    buf[i++] = c;
 546:	faf44783          	lbu	a5,-81(s0)
 54a:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 54e:	0905                	addi	s2,s2,1
 550:	ff678713          	addi	a4,a5,-10
 554:	00173713          	seqz	a4,a4
 558:	17cd                	addi	a5,a5,-13
 55a:	0017b793          	seqz	a5,a5
 55e:	8fd9                	or	a5,a5,a4
 560:	d7f1                	beqz	a5,52c <gets+0x26>
    buf[i++] = c;
 562:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 564:	9c5e                	add	s8,s8,s7
 566:	000c0023          	sb	zero,0(s8)
  return buf;
}
 56a:	855e                	mv	a0,s7
 56c:	60e6                	ld	ra,88(sp)
 56e:	6446                	ld	s0,80(sp)
 570:	64a6                	ld	s1,72(sp)
 572:	6906                	ld	s2,64(sp)
 574:	79e2                	ld	s3,56(sp)
 576:	7a42                	ld	s4,48(sp)
 578:	7aa2                	ld	s5,40(sp)
 57a:	7b02                	ld	s6,32(sp)
 57c:	6be2                	ld	s7,24(sp)
 57e:	6c42                	ld	s8,16(sp)
 580:	6125                	addi	sp,sp,96
 582:	8082                	ret

0000000000000584 <stat>:

int
stat(const char *n, struct stat *st)
{
 584:	1101                	addi	sp,sp,-32
 586:	ec06                	sd	ra,24(sp)
 588:	e822                	sd	s0,16(sp)
 58a:	e04a                	sd	s2,0(sp)
 58c:	1000                	addi	s0,sp,32
 58e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 590:	4581                	li	a1,0
 592:	194000ef          	jal	726 <open>
  if (fd < 0)
 596:	02054263          	bltz	a0,5ba <stat+0x36>
 59a:	e426                	sd	s1,8(sp)
 59c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 59e:	85ca                	mv	a1,s2
 5a0:	19e000ef          	jal	73e <fstat>
 5a4:	892a                	mv	s2,a0
  close(fd);
 5a6:	8526                	mv	a0,s1
 5a8:	166000ef          	jal	70e <close>
  return r;
 5ac:	64a2                	ld	s1,8(sp)
}
 5ae:	854a                	mv	a0,s2
 5b0:	60e2                	ld	ra,24(sp)
 5b2:	6442                	ld	s0,16(sp)
 5b4:	6902                	ld	s2,0(sp)
 5b6:	6105                	addi	sp,sp,32
 5b8:	8082                	ret
    return -1;
 5ba:	57fd                	li	a5,-1
 5bc:	893e                	mv	s2,a5
 5be:	bfc5                	j	5ae <stat+0x2a>

00000000000005c0 <atoi>:

int
atoi(const char *s)
{
 5c0:	1141                	addi	sp,sp,-16
 5c2:	e406                	sd	ra,8(sp)
 5c4:	e022                	sd	s0,0(sp)
 5c6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 5c8:	00054683          	lbu	a3,0(a0)
 5cc:	fd06879b          	addiw	a5,a3,-48
 5d0:	0ff7f793          	zext.b	a5,a5
 5d4:	4625                	li	a2,9
 5d6:	02f66963          	bltu	a2,a5,608 <atoi+0x48>
 5da:	872a                	mv	a4,a0
  n = 0;
 5dc:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 5de:	0705                	addi	a4,a4,1
 5e0:	0025179b          	slliw	a5,a0,0x2
 5e4:	9fa9                	addw	a5,a5,a0
 5e6:	0017979b          	slliw	a5,a5,0x1
 5ea:	9fb5                	addw	a5,a5,a3
 5ec:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 5f0:	00074683          	lbu	a3,0(a4)
 5f4:	fd06879b          	addiw	a5,a3,-48
 5f8:	0ff7f793          	zext.b	a5,a5
 5fc:	fef671e3          	bgeu	a2,a5,5de <atoi+0x1e>
  return n;
}
 600:	60a2                	ld	ra,8(sp)
 602:	6402                	ld	s0,0(sp)
 604:	0141                	addi	sp,sp,16
 606:	8082                	ret
  n = 0;
 608:	4501                	li	a0,0
 60a:	bfdd                	j	600 <atoi+0x40>

000000000000060c <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 60c:	1141                	addi	sp,sp,-16
 60e:	e406                	sd	ra,8(sp)
 610:	e022                	sd	s0,0(sp)
 612:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 614:	02b57563          	bgeu	a0,a1,63e <memmove+0x32>
    while (n-- > 0)
 618:	00c05f63          	blez	a2,636 <memmove+0x2a>
 61c:	1602                	slli	a2,a2,0x20
 61e:	9201                	srli	a2,a2,0x20
 620:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 624:	872a                	mv	a4,a0
      *dst++ = *src++;
 626:	0585                	addi	a1,a1,1
 628:	0705                	addi	a4,a4,1
 62a:	fff5c683          	lbu	a3,-1(a1)
 62e:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 632:	fee79ae3          	bne	a5,a4,626 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 636:	60a2                	ld	ra,8(sp)
 638:	6402                	ld	s0,0(sp)
 63a:	0141                	addi	sp,sp,16
 63c:	8082                	ret
    while (n-- > 0)
 63e:	fec05ce3          	blez	a2,636 <memmove+0x2a>
    dst += n;
 642:	00c50733          	add	a4,a0,a2
    src += n;
 646:	95b2                	add	a1,a1,a2
 648:	fff6079b          	addiw	a5,a2,-1
 64c:	1782                	slli	a5,a5,0x20
 64e:	9381                	srli	a5,a5,0x20
 650:	fff7c793          	not	a5,a5
 654:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 656:	15fd                	addi	a1,a1,-1
 658:	177d                	addi	a4,a4,-1
 65a:	0005c683          	lbu	a3,0(a1)
 65e:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 662:	fef71ae3          	bne	a4,a5,656 <memmove+0x4a>
 666:	bfc1                	j	636 <memmove+0x2a>

0000000000000668 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 668:	1141                	addi	sp,sp,-16
 66a:	e406                	sd	ra,8(sp)
 66c:	e022                	sd	s0,0(sp)
 66e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 670:	ce19                	beqz	a2,68e <memcmp+0x26>
 672:	1602                	slli	a2,a2,0x20
 674:	9201                	srli	a2,a2,0x20
 676:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 67a:	00054783          	lbu	a5,0(a0)
 67e:	0005c703          	lbu	a4,0(a1)
 682:	00e79b63          	bne	a5,a4,698 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 686:	0505                	addi	a0,a0,1
    p2++;
 688:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 68a:	fed518e3          	bne	a0,a3,67a <memcmp+0x12>
  }
  return 0;
 68e:	4501                	li	a0,0
}
 690:	60a2                	ld	ra,8(sp)
 692:	6402                	ld	s0,0(sp)
 694:	0141                	addi	sp,sp,16
 696:	8082                	ret
      return *p1 - *p2;
 698:	40e7853b          	subw	a0,a5,a4
 69c:	bfd5                	j	690 <memcmp+0x28>

000000000000069e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 69e:	1141                	addi	sp,sp,-16
 6a0:	e406                	sd	ra,8(sp)
 6a2:	e022                	sd	s0,0(sp)
 6a4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 6a6:	f67ff0ef          	jal	60c <memmove>
}
 6aa:	60a2                	ld	ra,8(sp)
 6ac:	6402                	ld	s0,0(sp)
 6ae:	0141                	addi	sp,sp,16
 6b0:	8082                	ret

00000000000006b2 <sbrk>:

char *
sbrk(int n)
{
 6b2:	1141                	addi	sp,sp,-16
 6b4:	e406                	sd	ra,8(sp)
 6b6:	e022                	sd	s0,0(sp)
 6b8:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 6ba:	4585                	li	a1,1
 6bc:	0b2000ef          	jal	76e <sys_sbrk>
}
 6c0:	60a2                	ld	ra,8(sp)
 6c2:	6402                	ld	s0,0(sp)
 6c4:	0141                	addi	sp,sp,16
 6c6:	8082                	ret

00000000000006c8 <sbrklazy>:

char *
sbrklazy(int n)
{
 6c8:	1141                	addi	sp,sp,-16
 6ca:	e406                	sd	ra,8(sp)
 6cc:	e022                	sd	s0,0(sp)
 6ce:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 6d0:	4589                	li	a1,2
 6d2:	09c000ef          	jal	76e <sys_sbrk>
}
 6d6:	60a2                	ld	ra,8(sp)
 6d8:	6402                	ld	s0,0(sp)
 6da:	0141                	addi	sp,sp,16
 6dc:	8082                	ret

00000000000006de <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6de:	4885                	li	a7,1
 ecall
 6e0:	00000073          	ecall
 ret
 6e4:	8082                	ret

00000000000006e6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 6e6:	4889                	li	a7,2
 ecall
 6e8:	00000073          	ecall
 ret
 6ec:	8082                	ret

00000000000006ee <wait>:
.global wait
wait:
 li a7, SYS_wait
 6ee:	488d                	li	a7,3
 ecall
 6f0:	00000073          	ecall
 ret
 6f4:	8082                	ret

00000000000006f6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6f6:	4891                	li	a7,4
 ecall
 6f8:	00000073          	ecall
 ret
 6fc:	8082                	ret

00000000000006fe <read>:
.global read
read:
 li a7, SYS_read
 6fe:	4895                	li	a7,5
 ecall
 700:	00000073          	ecall
 ret
 704:	8082                	ret

0000000000000706 <write>:
.global write
write:
 li a7, SYS_write
 706:	48c1                	li	a7,16
 ecall
 708:	00000073          	ecall
 ret
 70c:	8082                	ret

000000000000070e <close>:
.global close
close:
 li a7, SYS_close
 70e:	48d5                	li	a7,21
 ecall
 710:	00000073          	ecall
 ret
 714:	8082                	ret

0000000000000716 <kill>:
.global kill
kill:
 li a7, SYS_kill
 716:	4899                	li	a7,6
 ecall
 718:	00000073          	ecall
 ret
 71c:	8082                	ret

000000000000071e <exec>:
.global exec
exec:
 li a7, SYS_exec
 71e:	489d                	li	a7,7
 ecall
 720:	00000073          	ecall
 ret
 724:	8082                	ret

0000000000000726 <open>:
.global open
open:
 li a7, SYS_open
 726:	48bd                	li	a7,15
 ecall
 728:	00000073          	ecall
 ret
 72c:	8082                	ret

000000000000072e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 72e:	48c5                	li	a7,17
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 736:	48c9                	li	a7,18
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 73e:	48a1                	li	a7,8
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <link>:
.global link
link:
 li a7, SYS_link
 746:	48cd                	li	a7,19
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 74e:	48d1                	li	a7,20
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 756:	48a5                	li	a7,9
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <dup>:
.global dup
dup:
 li a7, SYS_dup
 75e:	48a9                	li	a7,10
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 766:	48ad                	li	a7,11
 ecall
 768:	00000073          	ecall
 ret
 76c:	8082                	ret

000000000000076e <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 76e:	48b1                	li	a7,12
 ecall
 770:	00000073          	ecall
 ret
 774:	8082                	ret

0000000000000776 <pause>:
.global pause
pause:
 li a7, SYS_pause
 776:	48b5                	li	a7,13
 ecall
 778:	00000073          	ecall
 ret
 77c:	8082                	ret

000000000000077e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 77e:	48b9                	li	a7,14
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <sync>:
.global sync
sync:
 li a7, SYS_sync
 786:	48d9                	li	a7,22
 ecall
 788:	00000073          	ecall
 ret
 78c:	8082                	ret

000000000000078e <istat>:
.global istat
istat:
 li a7, SYS_istat
 78e:	48dd                	li	a7,23
 ecall
 790:	00000073          	ecall
 ret
 794:	8082                	ret

0000000000000796 <iprint>:
.global iprint
iprint:
 li a7, SYS_iprint
 796:	48e1                	li	a7,24
 ecall
 798:	00000073          	ecall
 ret
 79c:	8082                	ret

000000000000079e <symlink>:
.global symlink
symlink:
 li a7, SYS_symlink
 79e:	48e5                	li	a7,25
 ecall
 7a0:	00000073          	ecall
 ret
 7a4:	8082                	ret

00000000000007a6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7a6:	1101                	addi	sp,sp,-32
 7a8:	ec06                	sd	ra,24(sp)
 7aa:	e822                	sd	s0,16(sp)
 7ac:	1000                	addi	s0,sp,32
 7ae:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7b2:	4605                	li	a2,1
 7b4:	fef40593          	addi	a1,s0,-17
 7b8:	f4fff0ef          	jal	706 <write>
}
 7bc:	60e2                	ld	ra,24(sp)
 7be:	6442                	ld	s0,16(sp)
 7c0:	6105                	addi	sp,sp,32
 7c2:	8082                	ret

00000000000007c4 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 7c4:	715d                	addi	sp,sp,-80
 7c6:	e486                	sd	ra,72(sp)
 7c8:	e0a2                	sd	s0,64(sp)
 7ca:	f84a                	sd	s2,48(sp)
 7cc:	f44e                	sd	s3,40(sp)
 7ce:	0880                	addi	s0,sp,80
 7d0:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 7d2:	00d036b3          	snez	a3,a3
 7d6:	03f5d793          	srli	a5,a1,0x3f
 7da:	8efd                	and	a3,a3,a5
  neg = 0;
 7dc:	4301                	li	t1,0
  if (sgn && xx < 0) {
 7de:	c681                	beqz	a3,7e6 <printint+0x22>
    neg = 1;
    x = -xx;
 7e0:	40b005b3          	neg	a1,a1
    neg = 1;
 7e4:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 7e6:	fb840993          	addi	s3,s0,-72
  neg = 0;
 7ea:	86ce                	mv	a3,s3
  i = 0;
 7ec:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
 7ee:	00000817          	auipc	a6,0x0
 7f2:	6a280813          	addi	a6,a6,1698 # e90 <digits>
 7f6:	88ba                	mv	a7,a4
 7f8:	0017051b          	addiw	a0,a4,1
 7fc:	872a                	mv	a4,a0
 7fe:	02c5f7b3          	remu	a5,a1,a2
 802:	97c2                	add	a5,a5,a6
 804:	0007c783          	lbu	a5,0(a5)
 808:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
 80c:	87ae                	mv	a5,a1
 80e:	02c5d5b3          	divu	a1,a1,a2
 812:	0685                	addi	a3,a3,1
 814:	fec7f1e3          	bgeu	a5,a2,7f6 <printint+0x32>
  if (neg)
 818:	00030b63          	beqz	t1,82e <printint+0x6a>
    buf[i++] = '-';
 81c:	fd040793          	addi	a5,s0,-48
 820:	953e                	add	a0,a0,a5
 822:	02d00793          	li	a5,45
 826:	fef50423          	sb	a5,-24(a0)
 82a:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
 82e:	02e05563          	blez	a4,858 <printint+0x94>
 832:	fc26                	sd	s1,56(sp)
 834:	377d                	addiw	a4,a4,-1
 836:	00e984b3          	add	s1,s3,a4
 83a:	19fd                	addi	s3,s3,-1
 83c:	99ba                	add	s3,s3,a4
 83e:	1702                	slli	a4,a4,0x20
 840:	9301                	srli	a4,a4,0x20
 842:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 846:	0004c583          	lbu	a1,0(s1)
 84a:	854a                	mv	a0,s2
 84c:	f5bff0ef          	jal	7a6 <putc>
  while (--i >= 0)
 850:	14fd                	addi	s1,s1,-1
 852:	ff349ae3          	bne	s1,s3,846 <printint+0x82>
 856:	74e2                	ld	s1,56(sp)
}
 858:	60a6                	ld	ra,72(sp)
 85a:	6406                	ld	s0,64(sp)
 85c:	7942                	ld	s2,48(sp)
 85e:	79a2                	ld	s3,40(sp)
 860:	6161                	addi	sp,sp,80
 862:	8082                	ret

0000000000000864 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 864:	711d                	addi	sp,sp,-96
 866:	ec86                	sd	ra,88(sp)
 868:	e8a2                	sd	s0,80(sp)
 86a:	e4a6                	sd	s1,72(sp)
 86c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 86e:	0005c483          	lbu	s1,0(a1)
 872:	2a048063          	beqz	s1,b12 <vprintf+0x2ae>
 876:	e0ca                	sd	s2,64(sp)
 878:	fc4e                	sd	s3,56(sp)
 87a:	f852                	sd	s4,48(sp)
 87c:	f456                	sd	s5,40(sp)
 87e:	f05a                	sd	s6,32(sp)
 880:	ec5e                	sd	s7,24(sp)
 882:	e862                	sd	s8,16(sp)
 884:	8b2a                	mv	s6,a0
 886:	8a2e                	mv	s4,a1
 888:	8bb2                	mv	s7,a2
  state = 0;
 88a:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 88c:	4901                	li	s2,0
 88e:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 890:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 894:	06400c13          	li	s8,100
 898:	a00d                	j	8ba <vprintf+0x56>
        putc(fd, c0);
 89a:	85a6                	mv	a1,s1
 89c:	855a                	mv	a0,s6
 89e:	f09ff0ef          	jal	7a6 <putc>
 8a2:	a019                	j	8a8 <vprintf+0x44>
    } else if (state == '%') {
 8a4:	03598363          	beq	s3,s5,8ca <vprintf+0x66>
  for (i = 0; fmt[i]; i++) {
 8a8:	0019079b          	addiw	a5,s2,1
 8ac:	893e                	mv	s2,a5
 8ae:	873e                	mv	a4,a5
 8b0:	97d2                	add	a5,a5,s4
 8b2:	0007c483          	lbu	s1,0(a5)
 8b6:	24048763          	beqz	s1,b04 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 8ba:	0004879b          	sext.w	a5,s1
    if (state == 0) {
 8be:	fe0993e3          	bnez	s3,8a4 <vprintf+0x40>
      if (c0 == '%') {
 8c2:	fd579ce3          	bne	a5,s5,89a <vprintf+0x36>
        state = '%';
 8c6:	89be                	mv	s3,a5
 8c8:	b7c5                	j	8a8 <vprintf+0x44>
        c1 = fmt[i + 1] & 0xff;
 8ca:	00ea06b3          	add	a3,s4,a4
 8ce:	0016c603          	lbu	a2,1(a3)
      if (c1)
 8d2:	24060563          	beqz	a2,b1c <vprintf+0x2b8>
      if (c0 == 'd') {
 8d6:	0b878763          	beq	a5,s8,984 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 8da:	f9478693          	addi	a3,a5,-108
 8de:	0016b693          	seqz	a3,a3
 8e2:	f9c60593          	addi	a1,a2,-100
 8e6:	0015b593          	seqz	a1,a1
 8ea:	8df5                	and	a1,a1,a3
 8ec:	e9c5                	bnez	a1,99c <vprintf+0x138>
        c2 = fmt[i + 2] & 0xff;
 8ee:	9752                	add	a4,a4,s4
 8f0:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 8f4:	f9460713          	addi	a4,a2,-108
 8f8:	00173713          	seqz	a4,a4
 8fc:	8f75                	and	a4,a4,a3
 8fe:	f9c50593          	addi	a1,a0,-100
 902:	0015b593          	seqz	a1,a1
 906:	8df9                	and	a1,a1,a4
 908:	e5dd                	bnez	a1,9b6 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 90a:	07500593          	li	a1,117
 90e:	0cb78163          	beq	a5,a1,9d0 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if (c0 == 'l' && c1 == 'u') {
 912:	f8b60593          	addi	a1,a2,-117
 916:	0015b593          	seqz	a1,a1
 91a:	8df5                	and	a1,a1,a3
 91c:	e5f1                	bnez	a1,9e8 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 91e:	f8b50593          	addi	a1,a0,-117
 922:	0015b593          	seqz	a1,a1
 926:	8df9                	and	a1,a1,a4
 928:	ede9                	bnez	a1,a02 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 92a:	07800593          	li	a1,120
 92e:	0eb78763          	beq	a5,a1,a1c <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if (c0 == 'l' && c1 == 'x') {
 932:	f8860613          	addi	a2,a2,-120
 936:	00163613          	seqz	a2,a2
 93a:	8ef1                	and	a3,a3,a2
 93c:	0e069c63          	bnez	a3,a34 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 940:	f8850513          	addi	a0,a0,-120
 944:	00153513          	seqz	a0,a0
 948:	8f69                	and	a4,a4,a0
 94a:	10071263          	bnez	a4,a4e <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 94e:	07000713          	li	a4,112
 952:	10e78a63          	beq	a5,a4,a66 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 956:	06300713          	li	a4,99
 95a:	14e78a63          	beq	a5,a4,aae <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 95e:	07300713          	li	a4,115
 962:	16e78063          	beq	a5,a4,ac2 <vprintf+0x25e>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 966:	02500713          	li	a4,37
 96a:	18e78863          	beq	a5,a4,afa <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 96e:	02500593          	li	a1,37
 972:	855a                	mv	a0,s6
 974:	e33ff0ef          	jal	7a6 <putc>
        putc(fd, c0);
 978:	85a6                	mv	a1,s1
 97a:	855a                	mv	a0,s6
 97c:	e2bff0ef          	jal	7a6 <putc>
      }

      state = 0;
 980:	4981                	li	s3,0
 982:	b71d                	j	8a8 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 984:	008b8493          	addi	s1,s7,8
 988:	4685                	li	a3,1
 98a:	4629                	li	a2,10
 98c:	000ba583          	lw	a1,0(s7)
 990:	855a                	mv	a0,s6
 992:	e33ff0ef          	jal	7c4 <printint>
 996:	8ba6                	mv	s7,s1
      state = 0;
 998:	4981                	li	s3,0
 99a:	b739                	j	8a8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 99c:	008b8493          	addi	s1,s7,8
 9a0:	4685                	li	a3,1
 9a2:	4629                	li	a2,10
 9a4:	000bb583          	ld	a1,0(s7)
 9a8:	855a                	mv	a0,s6
 9aa:	e1bff0ef          	jal	7c4 <printint>
        i += 1;
 9ae:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 9b0:	8ba6                	mv	s7,s1
      state = 0;
 9b2:	4981                	li	s3,0
 9b4:	bdd5                	j	8a8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 9b6:	008b8493          	addi	s1,s7,8
 9ba:	4685                	li	a3,1
 9bc:	4629                	li	a2,10
 9be:	000bb583          	ld	a1,0(s7)
 9c2:	855a                	mv	a0,s6
 9c4:	e01ff0ef          	jal	7c4 <printint>
        i += 2;
 9c8:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 9ca:	8ba6                	mv	s7,s1
      state = 0;
 9cc:	4981                	li	s3,0
        i += 2;
 9ce:	bde9                	j	8a8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 9d0:	008b8493          	addi	s1,s7,8
 9d4:	4681                	li	a3,0
 9d6:	4629                	li	a2,10
 9d8:	000be583          	lwu	a1,0(s7)
 9dc:	855a                	mv	a0,s6
 9de:	de7ff0ef          	jal	7c4 <printint>
 9e2:	8ba6                	mv	s7,s1
      state = 0;
 9e4:	4981                	li	s3,0
 9e6:	b5c9                	j	8a8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9e8:	008b8493          	addi	s1,s7,8
 9ec:	4681                	li	a3,0
 9ee:	4629                	li	a2,10
 9f0:	000bb583          	ld	a1,0(s7)
 9f4:	855a                	mv	a0,s6
 9f6:	dcfff0ef          	jal	7c4 <printint>
        i += 1;
 9fa:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 9fc:	8ba6                	mv	s7,s1
      state = 0;
 9fe:	4981                	li	s3,0
 a00:	b565                	j	8a8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a02:	008b8493          	addi	s1,s7,8
 a06:	4681                	li	a3,0
 a08:	4629                	li	a2,10
 a0a:	000bb583          	ld	a1,0(s7)
 a0e:	855a                	mv	a0,s6
 a10:	db5ff0ef          	jal	7c4 <printint>
        i += 2;
 a14:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 a16:	8ba6                	mv	s7,s1
      state = 0;
 a18:	4981                	li	s3,0
        i += 2;
 a1a:	b579                	j	8a8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 a1c:	008b8493          	addi	s1,s7,8
 a20:	4681                	li	a3,0
 a22:	4641                	li	a2,16
 a24:	000be583          	lwu	a1,0(s7)
 a28:	855a                	mv	a0,s6
 a2a:	d9bff0ef          	jal	7c4 <printint>
 a2e:	8ba6                	mv	s7,s1
      state = 0;
 a30:	4981                	li	s3,0
 a32:	bd9d                	j	8a8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a34:	008b8493          	addi	s1,s7,8
 a38:	4681                	li	a3,0
 a3a:	4641                	li	a2,16
 a3c:	000bb583          	ld	a1,0(s7)
 a40:	855a                	mv	a0,s6
 a42:	d83ff0ef          	jal	7c4 <printint>
        i += 1;
 a46:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 a48:	8ba6                	mv	s7,s1
      state = 0;
 a4a:	4981                	li	s3,0
 a4c:	bdb1                	j	8a8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a4e:	008b8493          	addi	s1,s7,8
 a52:	4641                	li	a2,16
 a54:	000bb583          	ld	a1,0(s7)
 a58:	855a                	mv	a0,s6
 a5a:	d6bff0ef          	jal	7c4 <printint>
        i += 2;
 a5e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 a60:	8ba6                	mv	s7,s1
      state = 0;
 a62:	4981                	li	s3,0
        i += 2;
 a64:	b591                	j	8a8 <vprintf+0x44>
 a66:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 a68:	008b8793          	addi	a5,s7,8
 a6c:	8cbe                	mv	s9,a5
 a6e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a72:	03000593          	li	a1,48
 a76:	855a                	mv	a0,s6
 a78:	d2fff0ef          	jal	7a6 <putc>
  putc(fd, 'x');
 a7c:	07800593          	li	a1,120
 a80:	855a                	mv	a0,s6
 a82:	d25ff0ef          	jal	7a6 <putc>
 a86:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a88:	00000b97          	auipc	s7,0x0
 a8c:	408b8b93          	addi	s7,s7,1032 # e90 <digits>
 a90:	03c9d793          	srli	a5,s3,0x3c
 a94:	97de                	add	a5,a5,s7
 a96:	0007c583          	lbu	a1,0(a5)
 a9a:	855a                	mv	a0,s6
 a9c:	d0bff0ef          	jal	7a6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 aa0:	0992                	slli	s3,s3,0x4
 aa2:	34fd                	addiw	s1,s1,-1
 aa4:	f4f5                	bnez	s1,a90 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 aa6:	8be6                	mv	s7,s9
      state = 0;
 aa8:	4981                	li	s3,0
 aaa:	6ca2                	ld	s9,8(sp)
 aac:	bbf5                	j	8a8 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 aae:	008b8493          	addi	s1,s7,8
 ab2:	000bc583          	lbu	a1,0(s7)
 ab6:	855a                	mv	a0,s6
 ab8:	cefff0ef          	jal	7a6 <putc>
 abc:	8ba6                	mv	s7,s1
      state = 0;
 abe:	4981                	li	s3,0
 ac0:	b3e5                	j	8a8 <vprintf+0x44>
        if ((s = va_arg(ap, char *)) == 0)
 ac2:	008b8993          	addi	s3,s7,8
 ac6:	000bb483          	ld	s1,0(s7)
 aca:	cc91                	beqz	s1,ae6 <vprintf+0x282>
        for (; *s; s++)
 acc:	0004c583          	lbu	a1,0(s1)
 ad0:	c195                	beqz	a1,af4 <vprintf+0x290>
          putc(fd, *s);
 ad2:	855a                	mv	a0,s6
 ad4:	cd3ff0ef          	jal	7a6 <putc>
        for (; *s; s++)
 ad8:	0485                	addi	s1,s1,1
 ada:	0004c583          	lbu	a1,0(s1)
 ade:	f9f5                	bnez	a1,ad2 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 ae0:	8bce                	mv	s7,s3
      state = 0;
 ae2:	4981                	li	s3,0
 ae4:	b3d1                	j	8a8 <vprintf+0x44>
          s = "(null)";
 ae6:	00000497          	auipc	s1,0x0
 aea:	3a248493          	addi	s1,s1,930 # e88 <malloc+0x270>
        for (; *s; s++)
 aee:	02800593          	li	a1,40
 af2:	b7c5                	j	ad2 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 af4:	8bce                	mv	s7,s3
      state = 0;
 af6:	4981                	li	s3,0
 af8:	bb45                	j	8a8 <vprintf+0x44>
        putc(fd, '%');
 afa:	85be                	mv	a1,a5
 afc:	855a                	mv	a0,s6
 afe:	ca9ff0ef          	jal	7a6 <putc>
 b02:	bdbd                	j	980 <vprintf+0x11c>
 b04:	6906                	ld	s2,64(sp)
 b06:	79e2                	ld	s3,56(sp)
 b08:	7a42                	ld	s4,48(sp)
 b0a:	7aa2                	ld	s5,40(sp)
 b0c:	7b02                	ld	s6,32(sp)
 b0e:	6be2                	ld	s7,24(sp)
 b10:	6c42                	ld	s8,16(sp)
    }
  }
}
 b12:	60e6                	ld	ra,88(sp)
 b14:	6446                	ld	s0,80(sp)
 b16:	64a6                	ld	s1,72(sp)
 b18:	6125                	addi	sp,sp,96
 b1a:	8082                	ret
      if (c0 == 'd') {
 b1c:	06400713          	li	a4,100
 b20:	e6e782e3          	beq	a5,a4,984 <vprintf+0x120>
      } else if (c0 == 'l' && c1 == 'd') {
 b24:	f9478693          	addi	a3,a5,-108
 b28:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 b2c:	8532                	mv	a0,a2
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 b2e:	4701                	li	a4,0
 b30:	bbe9                	j	90a <vprintf+0xa6>

0000000000000b32 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b32:	715d                	addi	sp,sp,-80
 b34:	ec06                	sd	ra,24(sp)
 b36:	e822                	sd	s0,16(sp)
 b38:	1000                	addi	s0,sp,32
 b3a:	e010                	sd	a2,0(s0)
 b3c:	e414                	sd	a3,8(s0)
 b3e:	e818                	sd	a4,16(s0)
 b40:	ec1c                	sd	a5,24(s0)
 b42:	03043023          	sd	a6,32(s0)
 b46:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b4a:	8622                	mv	a2,s0
 b4c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b50:	d15ff0ef          	jal	864 <vprintf>
}
 b54:	60e2                	ld	ra,24(sp)
 b56:	6442                	ld	s0,16(sp)
 b58:	6161                	addi	sp,sp,80
 b5a:	8082                	ret

0000000000000b5c <printf>:

void
printf(const char *fmt, ...)
{
 b5c:	711d                	addi	sp,sp,-96
 b5e:	ec06                	sd	ra,24(sp)
 b60:	e822                	sd	s0,16(sp)
 b62:	1000                	addi	s0,sp,32
 b64:	e40c                	sd	a1,8(s0)
 b66:	e810                	sd	a2,16(s0)
 b68:	ec14                	sd	a3,24(s0)
 b6a:	f018                	sd	a4,32(s0)
 b6c:	f41c                	sd	a5,40(s0)
 b6e:	03043823          	sd	a6,48(s0)
 b72:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b76:	00840613          	addi	a2,s0,8
 b7a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b7e:	85aa                	mv	a1,a0
 b80:	4505                	li	a0,1
 b82:	ce3ff0ef          	jal	864 <vprintf>
}
 b86:	60e2                	ld	ra,24(sp)
 b88:	6442                	ld	s0,16(sp)
 b8a:	6125                	addi	sp,sp,96
 b8c:	8082                	ret

0000000000000b8e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b8e:	1141                	addi	sp,sp,-16
 b90:	e406                	sd	ra,8(sp)
 b92:	e022                	sd	s0,0(sp)
 b94:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 b96:	ff050713          	addi	a4,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b9a:	00000797          	auipc	a5,0x0
 b9e:	4667b783          	ld	a5,1126(a5) # 1000 <freep>
 ba2:	a095                	j	c06 <free+0x78>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
 ba4:	ff852583          	lw	a1,-8(a0)
 ba8:	6390                	ld	a2,0(a5)
 baa:	02059813          	slli	a6,a1,0x20
 bae:	01c85693          	srli	a3,a6,0x1c
 bb2:	96ba                	add	a3,a3,a4
 bb4:	02d60563          	beq	a2,a3,bde <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 bb8:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
 bbc:	4790                	lw	a2,8(a5)
 bbe:	02061593          	slli	a1,a2,0x20
 bc2:	01c5d693          	srli	a3,a1,0x1c
 bc6:	96be                	add	a3,a3,a5
 bc8:	02d70263          	beq	a4,a3,bec <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 bcc:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 bce:	00000717          	auipc	a4,0x0
 bd2:	42f73923          	sd	a5,1074(a4) # 1000 <freep>
}
 bd6:	60a2                	ld	ra,8(sp)
 bd8:	6402                	ld	s0,0(sp)
 bda:	0141                	addi	sp,sp,16
 bdc:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 bde:	4614                	lw	a3,8(a2)
 be0:	9ead                	addw	a3,a3,a1
 be2:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 be6:	6394                	ld	a3,0(a5)
 be8:	6290                	ld	a2,0(a3)
 bea:	b7f9                	j	bb8 <free+0x2a>
    p->s.size += bp->s.size;
 bec:	ff852703          	lw	a4,-8(a0)
 bf0:	9f31                	addw	a4,a4,a2
 bf2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bf4:	ff053703          	ld	a4,-16(a0)
 bf8:	bfd1                	j	bcc <free+0x3e>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bfa:	6394                	ld	a3,0(a5)
 bfc:	00d7e463          	bltu	a5,a3,c04 <free+0x76>
 c00:	fad762e3          	bltu	a4,a3,ba4 <free+0x16>
 c04:	87b6                	mv	a5,a3
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c06:	fee7fae3          	bgeu	a5,a4,bfa <free+0x6c>
 c0a:	6394                	ld	a3,0(a5)
 c0c:	f8d76ce3          	bltu	a4,a3,ba4 <free+0x16>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c10:	f8d7fae3          	bgeu	a5,a3,ba4 <free+0x16>
 c14:	87b6                	mv	a5,a3
 c16:	bfc5                	j	c06 <free+0x78>

0000000000000c18 <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
 c18:	7139                	addi	sp,sp,-64
 c1a:	fc06                	sd	ra,56(sp)
 c1c:	f822                	sd	s0,48(sp)
 c1e:	f04a                	sd	s2,32(sp)
 c20:	ec4e                	sd	s3,24(sp)
 c22:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 c24:	02051993          	slli	s3,a0,0x20
 c28:	0209d993          	srli	s3,s3,0x20
 c2c:	09bd                	addi	s3,s3,15
 c2e:	0049d993          	srli	s3,s3,0x4
 c32:	2985                	addiw	s3,s3,1
 c34:	894e                	mv	s2,s3
  if ((prevp = freep) == 0) {
 c36:	00000517          	auipc	a0,0x0
 c3a:	3ca53503          	ld	a0,970(a0) # 1000 <freep>
 c3e:	c905                	beqz	a0,c6e <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 c40:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 c42:	4798                	lw	a4,8(a5)
 c44:	09377663          	bgeu	a4,s3,cd0 <malloc+0xb8>
 c48:	f426                	sd	s1,40(sp)
 c4a:	e852                	sd	s4,16(sp)
 c4c:	e456                	sd	s5,8(sp)
 c4e:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 c50:	8a4e                	mv	s4,s3
 c52:	6705                	lui	a4,0x1
 c54:	00e9f363          	bgeu	s3,a4,c5a <malloc+0x42>
 c58:	6a05                	lui	s4,0x1
 c5a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c5e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 c62:	00000497          	auipc	s1,0x0
 c66:	39e48493          	addi	s1,s1,926 # 1000 <freep>
  if (p == SBRK_ERROR)
 c6a:	5afd                	li	s5,-1
 c6c:	a83d                	j	caa <malloc+0x92>
 c6e:	f426                	sd	s1,40(sp)
 c70:	e852                	sd	s4,16(sp)
 c72:	e456                	sd	s5,8(sp)
 c74:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 c76:	00002797          	auipc	a5,0x2
 c7a:	39a78793          	addi	a5,a5,922 # 3010 <base>
 c7e:	00000717          	auipc	a4,0x0
 c82:	38f73123          	sd	a5,898(a4) # 1000 <freep>
 c86:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c88:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 c8c:	b7d1                	j	c50 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 c8e:	6398                	ld	a4,0(a5)
 c90:	e118                	sd	a4,0(a0)
 c92:	a899                	j	ce8 <malloc+0xd0>
  hp->s.size = nu;
 c94:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 c98:	0541                	addi	a0,a0,16
 c9a:	ef5ff0ef          	jal	b8e <free>
  return freep;
 c9e:	6088                	ld	a0,0(s1)
      if ((p = morecore(nunits)) == 0)
 ca0:	c125                	beqz	a0,d00 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 ca2:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 ca4:	4798                	lw	a4,8(a5)
 ca6:	03277163          	bgeu	a4,s2,cc8 <malloc+0xb0>
    if (p == freep)
 caa:	6098                	ld	a4,0(s1)
 cac:	853e                	mv	a0,a5
 cae:	fef71ae3          	bne	a4,a5,ca2 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 cb2:	8552                	mv	a0,s4
 cb4:	9ffff0ef          	jal	6b2 <sbrk>
  if (p == SBRK_ERROR)
 cb8:	fd551ee3          	bne	a0,s5,c94 <malloc+0x7c>
        return 0;
 cbc:	4501                	li	a0,0
 cbe:	74a2                	ld	s1,40(sp)
 cc0:	6a42                	ld	s4,16(sp)
 cc2:	6aa2                	ld	s5,8(sp)
 cc4:	6b02                	ld	s6,0(sp)
 cc6:	a03d                	j	cf4 <malloc+0xdc>
 cc8:	74a2                	ld	s1,40(sp)
 cca:	6a42                	ld	s4,16(sp)
 ccc:	6aa2                	ld	s5,8(sp)
 cce:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
 cd0:	fae90fe3          	beq	s2,a4,c8e <malloc+0x76>
        p->s.size -= nunits;
 cd4:	4137073b          	subw	a4,a4,s3
 cd8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 cda:	02071693          	slli	a3,a4,0x20
 cde:	01c6d713          	srli	a4,a3,0x1c
 ce2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 ce4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 ce8:	00000717          	auipc	a4,0x0
 cec:	30a73c23          	sd	a0,792(a4) # 1000 <freep>
      return (void *)(p + 1);
 cf0:	01078513          	addi	a0,a5,16
  }
}
 cf4:	70e2                	ld	ra,56(sp)
 cf6:	7442                	ld	s0,48(sp)
 cf8:	7902                	ld	s2,32(sp)
 cfa:	69e2                	ld	s3,24(sp)
 cfc:	6121                	addi	sp,sp,64
 cfe:	8082                	ret
 d00:	74a2                	ld	s1,40(sp)
 d02:	6a42                	ld	s4,16(sp)
 d04:	6aa2                	ld	s5,8(sp)
 d06:	6b02                	ld	s6,0(sp)
 d08:	b7f5                	j	cf4 <malloc+0xdc>
