
user/_symlinkfail:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/fs_test.h"

#if defined(SYS_symlink) && defined(O_NOFOLLOW) && defined(T_SYMLINK)
int
main(void)
{
   0:	7175                	addi	sp,sp,-144
   2:	e506                	sd	ra,136(sp)
   4:	e122                	sd	s0,128(sp)
   6:	0900                	addi	s0,sp,144
  check(mkdir("fst_fail.tmp") == 0 && chdir("fst_fail.tmp") == 0,
   8:	00001517          	auipc	a0,0x1
   c:	c2850513          	addi	a0,a0,-984 # c30 <malloc+0xfa>
  10:	65c000ef          	jal	66c <mkdir>
  14:	c51d                	beqz	a0,42 <main+0x42>
  16:	fca6                	sd	s1,120(sp)
  18:	f8ca                	sd	s2,112(sp)
  1a:	f4ce                	sd	s3,104(sp)
  1c:	f0d2                	sd	s4,96(sp)
  1e:	ecd6                	sd	s5,88(sp)
  20:	e8da                	sd	s6,80(sp)
  22:	e4de                	sd	s7,72(sp)
  24:	e0e2                	sd	s8,64(sp)

static inline void
check(int ok, const char *why)
{
  if (!ok) {
    fprintf(2, "TEST FAILURE: %s\n", why);
  26:	00001617          	auipc	a2,0x1
  2a:	c1a60613          	addi	a2,a2,-998 # c40 <malloc+0x10a>
  2e:	00001597          	auipc	a1,0x1
  32:	c3258593          	addi	a1,a1,-974 # c60 <malloc+0x12a>
  36:	4509                	li	a0,2
  38:	219000ef          	jal	a50 <fprintf>
    exit(1);
  3c:	4505                	li	a0,1
  3e:	5c6000ef          	jal	604 <exit>
  42:	fca6                	sd	s1,120(sp)
  44:	f8ca                	sd	s2,112(sp)
  46:	f4ce                	sd	s3,104(sp)
  48:	f0d2                	sd	s4,96(sp)
  4a:	ecd6                	sd	s5,88(sp)
  4c:	e8da                	sd	s6,80(sp)
  4e:	e4de                	sd	s7,72(sp)
  50:	e0e2                	sd	s8,64(sp)
  52:	00001517          	auipc	a0,0x1
  56:	bde50513          	addi	a0,a0,-1058 # c30 <malloc+0xfa>
  5a:	61a000ef          	jal	674 <chdir>
  5e:	8aaa                	mv	s5,a0
  if (!ok) {
  60:	f179                	bnez	a0,26 <main+0x26>
        "create failure-test directory");
  const char *files[] = {"fill0", "fill1", "fill2", "fill3"};
  62:	00001797          	auipc	a5,0x1
  66:	c1678793          	addi	a5,a5,-1002 # c78 <malloc+0x142>
  6a:	f8f43823          	sd	a5,-112(s0)
  6e:	00001797          	auipc	a5,0x1
  72:	c1278793          	addi	a5,a5,-1006 # c80 <malloc+0x14a>
  76:	f8f43c23          	sd	a5,-104(s0)
  7a:	00001797          	auipc	a5,0x1
  7e:	c0e78793          	addi	a5,a5,-1010 # c88 <malloc+0x152>
  82:	faf43023          	sd	a5,-96(s0)
  86:	00001797          	auipc	a5,0x1
  8a:	c0a78793          	addi	a5,a5,-1014 # c90 <malloc+0x15a>
  8e:	faf43423          	sd	a5,-88(s0)
  int count = 0;
  memset(fs_buffer, 'x', sizeof(fs_buffer));
  92:	6609                	lui	a2,0x2
  94:	07800593          	li	a1,120
  98:	00001517          	auipc	a0,0x1
  9c:	f7850513          	addi	a0,a0,-136 # 1010 <fs_buffer>
  a0:	33a000ef          	jal	3da <memset>
  for (int i = 0; i < 4; i++) {
  a4:	f9040a13          	addi	s4,s0,-112
  memset(fs_buffer, 'x', sizeof(fs_buffer));
  a8:	8b52                	mv	s6,s4
    int fd = open(files[i], O_CREATE | O_WRONLY);
  aa:	20100c13          	li	s8,513
    check(fd >= 0, "create disk-filling file");
    count++;
    while (write(fd, fs_buffer, sizeof(fs_buffer)) == sizeof(fs_buffer))
  ae:	6489                	lui	s1,0x2
  b0:	00001997          	auipc	s3,0x1
  b4:	f6098993          	addi	s3,s3,-160 # 1010 <fs_buffer>
  for (int i = 0; i < 4; i++) {
  b8:	4b91                	li	s7,4
    int fd = open(files[i], O_CREATE | O_WRONLY);
  ba:	85e2                	mv	a1,s8
  bc:	000b3503          	ld	a0,0(s6)
  c0:	584000ef          	jal	644 <open>
  c4:	892a                	mv	s2,a0
  c6:	0a054063          	bltz	a0,166 <main+0x166>
    while (write(fd, fs_buffer, sizeof(fs_buffer)) == sizeof(fs_buffer))
  ca:	8626                	mv	a2,s1
  cc:	85ce                	mv	a1,s3
  ce:	854a                	mv	a0,s2
  d0:	554000ef          	jal	624 <write>
  d4:	fe950be3          	beq	a0,s1,ca <main+0xca>
      ;
    check(close(fd) == 0, "close disk-filling file");
  d8:	854a                	mv	a0,s2
  da:	552000ef          	jal	62c <close>
  de:	e155                	bnez	a0,182 <main+0x182>
    count++;
  e0:	2a85                	addiw	s5,s5,1
  for (int i = 0; i < 4; i++) {
  e2:	0b21                	addi	s6,s6,8
  e4:	fd7a9be3          	bne	s5,s7,ba <main+0xba>
  }

  // A one-byte append consumes any space left at a chunk/size boundary.
  int fd = open("last", O_CREATE | O_RDWR);
  e8:	20200593          	li	a1,514
  ec:	00001517          	auipc	a0,0x1
  f0:	be450513          	addi	a0,a0,-1052 # cd0 <malloc+0x19a>
  f4:	550000ef          	jal	644 <open>
  f8:	892a                	mv	s2,a0
  check(fd >= 0, "create final disk-filling file");
  while (write(fd, fs_buffer, BSIZE) == BSIZE)
  fa:	40000493          	li	s1,1024
  fe:	00001997          	auipc	s3,0x1
 102:	f1298993          	addi	s3,s3,-238 # 1010 <fs_buffer>
 106:	08054c63          	bltz	a0,19e <main+0x19e>
 10a:	8626                	mv	a2,s1
 10c:	85ce                	mv	a1,s3
 10e:	854a                	mv	a0,s2
 110:	514000ef          	jal	624 <write>
 114:	fe950be3          	beq	a0,s1,10a <main+0x10a>
    ;
  struct stat st;
  check(fstat(fd, &st) == 0 && st.size < MAXFILE * BSIZE,
 118:	f7840593          	addi	a1,s0,-136
 11c:	854a                	mv	a0,s2
 11e:	53e000ef          	jal	65c <fstat>
 122:	ed41                	bnez	a0,1ba <main+0x1ba>
 124:	f8843703          	ld	a4,-120(s0)
 128:	040437b7          	lui	a5,0x4043
 12c:	bff78793          	addi	a5,a5,-1025 # 4042bff <base+0x403fbef>
 130:	08e7e563          	bltu	a5,a4,1ba <main+0x1ba>
        "failure comes from disk exhaustion rather than the file-size limit");
  check(write(fd, fs_buffer, 1) != 1 && close(fd) == 0,
 134:	4605                	li	a2,1
 136:	00001597          	auipc	a1,0x1
 13a:	eda58593          	addi	a1,a1,-294 # 1010 <fs_buffer>
 13e:	854a                	mv	a0,s2
 140:	4e4000ef          	jal	624 <write>
 144:	4785                	li	a5,1
 146:	08f51863          	bne	a0,a5,1d6 <main+0x1d6>
    fprintf(2, "TEST FAILURE: %s\n", why);
 14a:	00001617          	auipc	a2,0x1
 14e:	bf660613          	addi	a2,a2,-1034 # d40 <malloc+0x20a>
 152:	00001597          	auipc	a1,0x1
 156:	b0e58593          	addi	a1,a1,-1266 # c60 <malloc+0x12a>
 15a:	4509                	li	a0,2
 15c:	0f5000ef          	jal	a50 <fprintf>
    exit(1);
 160:	4505                	li	a0,1
 162:	4a2000ef          	jal	604 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 166:	00001617          	auipc	a2,0x1
 16a:	b3260613          	addi	a2,a2,-1230 # c98 <malloc+0x162>
 16e:	00001597          	auipc	a1,0x1
 172:	af258593          	addi	a1,a1,-1294 # c60 <malloc+0x12a>
 176:	4509                	li	a0,2
 178:	0d9000ef          	jal	a50 <fprintf>
    exit(1);
 17c:	4505                	li	a0,1
 17e:	486000ef          	jal	604 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 182:	00001617          	auipc	a2,0x1
 186:	b3660613          	addi	a2,a2,-1226 # cb8 <malloc+0x182>
 18a:	00001597          	auipc	a1,0x1
 18e:	ad658593          	addi	a1,a1,-1322 # c60 <malloc+0x12a>
 192:	4509                	li	a0,2
 194:	0bd000ef          	jal	a50 <fprintf>
    exit(1);
 198:	4505                	li	a0,1
 19a:	46a000ef          	jal	604 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 19e:	00001617          	auipc	a2,0x1
 1a2:	b3a60613          	addi	a2,a2,-1222 # cd8 <malloc+0x1a2>
 1a6:	00001597          	auipc	a1,0x1
 1aa:	aba58593          	addi	a1,a1,-1350 # c60 <malloc+0x12a>
 1ae:	4509                	li	a0,2
 1b0:	0a1000ef          	jal	a50 <fprintf>
    exit(1);
 1b4:	4505                	li	a0,1
 1b6:	44e000ef          	jal	604 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 1ba:	00001617          	auipc	a2,0x1
 1be:	b3e60613          	addi	a2,a2,-1218 # cf8 <malloc+0x1c2>
 1c2:	00001597          	auipc	a1,0x1
 1c6:	a9e58593          	addi	a1,a1,-1378 # c60 <malloc+0x12a>
 1ca:	4509                	li	a0,2
 1cc:	085000ef          	jal	a50 <fprintf>
    exit(1);
 1d0:	4505                	li	a0,1
 1d2:	432000ef          	jal	604 <exit>
 1d6:	854a                	mv	a0,s2
 1d8:	454000ef          	jal	62c <close>
 1dc:	8aaa                	mv	s5,a0
  if (!ok) {
 1de:	44a1                	li	s1,8
 1e0:	f52d                	bnez	a0,14a <main+0x14a>
        "disk has no data block available");

  for (int i = 0; i < 8; i++) {
    check(symlink("target", "failed") == -1,
 1e2:	00001917          	auipc	s2,0x1
 1e6:	b8690913          	addi	s2,s2,-1146 # d68 <malloc+0x232>
 1ea:	00001b97          	auipc	s7,0x1
 1ee:	b86b8b93          	addi	s7,s7,-1146 # d70 <malloc+0x23a>
 1f2:	59fd                	li	s3,-1
          "creation on a full disk must fail");
    fd = open("failed", O_RDONLY | O_NOFOLLOW);
 1f4:	6b05                	lui	s6,0x1
 1f6:	800b0b13          	addi	s6,s6,-2048 # 800 <vprintf+0x7e>
 1fa:	a01d                	j	220 <main+0x220>
    fprintf(2, "TEST FAILURE: %s\n", why);
 1fc:	00001617          	auipc	a2,0x1
 200:	b7c60613          	addi	a2,a2,-1156 # d78 <malloc+0x242>
 204:	00001597          	auipc	a1,0x1
 208:	a5c58593          	addi	a1,a1,-1444 # c60 <malloc+0x12a>
 20c:	4509                	li	a0,2
 20e:	043000ef          	jal	a50 <fprintf>
    exit(1);
 212:	4505                	li	a0,1
 214:	3f0000ef          	jal	604 <exit>
  if (!ok) {
 218:	03351263          	bne	a0,s3,23c <main+0x23c>
  for (int i = 0; i < 8; i++) {
 21c:	34fd                	addiw	s1,s1,-1 # 1fff <fs_buffer+0xfef>
 21e:	cc8d                	beqz	s1,258 <main+0x258>
    check(symlink("target", "failed") == -1,
 220:	85ca                	mv	a1,s2
 222:	855e                	mv	a0,s7
 224:	498000ef          	jal	6bc <symlink>
 228:	fd351ae3          	bne	a0,s3,1fc <main+0x1fc>
    fd = open("failed", O_RDONLY | O_NOFOLLOW);
 22c:	85da                	mv	a1,s6
 22e:	854a                	mv	a0,s2
 230:	414000ef          	jal	644 <open>
    if (fd >= 0)
 234:	fe0542e3          	bltz	a0,218 <main+0x218>
      close(fd);
 238:	3f4000ef          	jal	62c <close>
    fprintf(2, "TEST FAILURE: %s\n", why);
 23c:	00001617          	auipc	a2,0x1
 240:	b6460613          	addi	a2,a2,-1180 # da0 <malloc+0x26a>
 244:	00001597          	auipc	a1,0x1
 248:	a1c58593          	addi	a1,a1,-1508 # c60 <malloc+0x12a>
 24c:	4509                	li	a0,2
 24e:	003000ef          	jal	a50 <fprintf>
    exit(1);
 252:	4505                	li	a0,1
 254:	3b0000ef          	jal	604 <exit>
    check(fd == -1, "failed creation leaves no directory entry");
  }
  printf("FS_STAGE full_reject\n");
 258:	00001517          	auipc	a0,0x1
 25c:	b7850513          	addi	a0,a0,-1160 # dd0 <malloc+0x29a>
 260:	01b000ef          	jal	a7a <printf>
  for (int i = 0; i < count; i++)
 264:	4489                	li	s1,2
 266:	a011                	j	26a <main+0x26a>
 268:	8abe                	mv	s5,a5
    check(unlink(files[i]) == 0, "remove disk-filling file");
 26a:	000a3503          	ld	a0,0(s4)
 26e:	3e6000ef          	jal	654 <unlink>
  if (!ok) {
 272:	e531                	bnez	a0,2be <main+0x2be>
  for (int i = 0; i < count; i++)
 274:	001a879b          	addiw	a5,s5,1
 278:	0a21                	addi	s4,s4,8
 27a:	ff54d7e3          	bge	s1,s5,268 <main+0x268>
  check(unlink("last") == 0, "remove final filling file");
 27e:	00001517          	auipc	a0,0x1
 282:	a5250513          	addi	a0,a0,-1454 # cd0 <malloc+0x19a>
 286:	3ce000ef          	jal	654 <unlink>
 28a:	e921                	bnez	a0,2da <main+0x2da>
  check(symlink("target", "failed") == 0 && unlink("failed") == 0,
 28c:	00001597          	auipc	a1,0x1
 290:	adc58593          	addi	a1,a1,-1316 # d68 <malloc+0x232>
 294:	00001517          	auipc	a0,0x1
 298:	adc50513          	addi	a0,a0,-1316 # d70 <malloc+0x23a>
 29c:	420000ef          	jal	6bc <symlink>
 2a0:	c939                	beqz	a0,2f6 <main+0x2f6>
    fprintf(2, "TEST FAILURE: %s\n", why);
 2a2:	00001617          	auipc	a2,0x1
 2a6:	b8660613          	addi	a2,a2,-1146 # e28 <malloc+0x2f2>
 2aa:	00001597          	auipc	a1,0x1
 2ae:	9b658593          	addi	a1,a1,-1610 # c60 <malloc+0x12a>
 2b2:	4509                	li	a0,2
 2b4:	79c000ef          	jal	a50 <fprintf>
    exit(1);
 2b8:	4505                	li	a0,1
 2ba:	34a000ef          	jal	604 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 2be:	00001617          	auipc	a2,0x1
 2c2:	b2a60613          	addi	a2,a2,-1238 # de8 <malloc+0x2b2>
 2c6:	00001597          	auipc	a1,0x1
 2ca:	99a58593          	addi	a1,a1,-1638 # c60 <malloc+0x12a>
 2ce:	4509                	li	a0,2
 2d0:	780000ef          	jal	a50 <fprintf>
    exit(1);
 2d4:	4505                	li	a0,1
 2d6:	32e000ef          	jal	604 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
 2da:	00001617          	auipc	a2,0x1
 2de:	b2e60613          	addi	a2,a2,-1234 # e08 <malloc+0x2d2>
 2e2:	00001597          	auipc	a1,0x1
 2e6:	97e58593          	addi	a1,a1,-1666 # c60 <malloc+0x12a>
 2ea:	4509                	li	a0,2
 2ec:	764000ef          	jal	a50 <fprintf>
    exit(1);
 2f0:	4505                	li	a0,1
 2f2:	312000ef          	jal	604 <exit>
 2f6:	00001517          	auipc	a0,0x1
 2fa:	a7250513          	addi	a0,a0,-1422 # d68 <malloc+0x232>
 2fe:	356000ef          	jal	654 <unlink>
  if (!ok) {
 302:	f145                	bnez	a0,2a2 <main+0x2a2>
        "creation works again after freeing space");
  check(chdir("..") == 0 && unlink("fst_fail.tmp") == 0,
 304:	00001517          	auipc	a0,0x1
 308:	b5450513          	addi	a0,a0,-1196 # e58 <malloc+0x322>
 30c:	368000ef          	jal	674 <chdir>
 310:	cd19                	beqz	a0,32e <main+0x32e>
    fprintf(2, "TEST FAILURE: %s\n", why);
 312:	00001617          	auipc	a2,0x1
 316:	b4e60613          	addi	a2,a2,-1202 # e60 <malloc+0x32a>
 31a:	00001597          	auipc	a1,0x1
 31e:	94658593          	addi	a1,a1,-1722 # c60 <malloc+0x12a>
 322:	4509                	li	a0,2
 324:	72c000ef          	jal	a50 <fprintf>
    exit(1);
 328:	4505                	li	a0,1
 32a:	2da000ef          	jal	604 <exit>
 32e:	00001517          	auipc	a0,0x1
 332:	90250513          	addi	a0,a0,-1790 # c30 <malloc+0xfa>
 336:	31e000ef          	jal	654 <unlink>
  if (!ok) {
 33a:	fd61                	bnez	a0,312 <main+0x312>
        "remove failure-test directory");
  printf("symlinkfail: passed\n");
 33c:	00001517          	auipc	a0,0x1
 340:	b4450513          	addi	a0,a0,-1212 # e80 <malloc+0x34a>
 344:	736000ef          	jal	a7a <printf>
  exit(0);
 348:	4501                	li	a0,0
 34a:	2ba000ef          	jal	604 <exit>

000000000000034e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 34e:	1141                	addi	sp,sp,-16
 350:	e406                	sd	ra,8(sp)
 352:	e022                	sd	s0,0(sp)
 354:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 356:	cabff0ef          	jal	0 <main>
  exit(r);
 35a:	2aa000ef          	jal	604 <exit>

000000000000035e <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 35e:	1141                	addi	sp,sp,-16
 360:	e406                	sd	ra,8(sp)
 362:	e022                	sd	s0,0(sp)
 364:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 366:	87aa                	mv	a5,a0
 368:	0585                	addi	a1,a1,1
 36a:	0785                	addi	a5,a5,1
 36c:	fff5c703          	lbu	a4,-1(a1)
 370:	fee78fa3          	sb	a4,-1(a5)
 374:	fb75                	bnez	a4,368 <strcpy+0xa>
    ;
  return os;
}
 376:	60a2                	ld	ra,8(sp)
 378:	6402                	ld	s0,0(sp)
 37a:	0141                	addi	sp,sp,16
 37c:	8082                	ret

000000000000037e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 37e:	1141                	addi	sp,sp,-16
 380:	e406                	sd	ra,8(sp)
 382:	e022                	sd	s0,0(sp)
 384:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 386:	00054783          	lbu	a5,0(a0)
 38a:	cb91                	beqz	a5,39e <strcmp+0x20>
 38c:	0005c703          	lbu	a4,0(a1)
 390:	00f71763          	bne	a4,a5,39e <strcmp+0x20>
    p++, q++;
 394:	0505                	addi	a0,a0,1
 396:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 398:	00054783          	lbu	a5,0(a0)
 39c:	fbe5                	bnez	a5,38c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 39e:	0005c503          	lbu	a0,0(a1)
}
 3a2:	40a7853b          	subw	a0,a5,a0
 3a6:	60a2                	ld	ra,8(sp)
 3a8:	6402                	ld	s0,0(sp)
 3aa:	0141                	addi	sp,sp,16
 3ac:	8082                	ret

00000000000003ae <strlen>:

uint
strlen(const char *s)
{
 3ae:	1141                	addi	sp,sp,-16
 3b0:	e406                	sd	ra,8(sp)
 3b2:	e022                	sd	s0,0(sp)
 3b4:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 3b6:	00054783          	lbu	a5,0(a0)
 3ba:	cf91                	beqz	a5,3d6 <strlen+0x28>
 3bc:	00150793          	addi	a5,a0,1
 3c0:	86be                	mv	a3,a5
 3c2:	0785                	addi	a5,a5,1
 3c4:	fff7c703          	lbu	a4,-1(a5)
 3c8:	ff65                	bnez	a4,3c0 <strlen+0x12>
 3ca:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 3ce:	60a2                	ld	ra,8(sp)
 3d0:	6402                	ld	s0,0(sp)
 3d2:	0141                	addi	sp,sp,16
 3d4:	8082                	ret
  for (n = 0; s[n]; n++)
 3d6:	4501                	li	a0,0
 3d8:	bfdd                	j	3ce <strlen+0x20>

00000000000003da <memset>:

void *
memset(void *dst, int c, uint n)
{
 3da:	1141                	addi	sp,sp,-16
 3dc:	e406                	sd	ra,8(sp)
 3de:	e022                	sd	s0,0(sp)
 3e0:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 3e2:	ca19                	beqz	a2,3f8 <memset+0x1e>
 3e4:	87aa                	mv	a5,a0
 3e6:	1602                	slli	a2,a2,0x20
 3e8:	9201                	srli	a2,a2,0x20
 3ea:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3ee:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 3f2:	0785                	addi	a5,a5,1
 3f4:	fee79de3          	bne	a5,a4,3ee <memset+0x14>
  }
  return dst;
}
 3f8:	60a2                	ld	ra,8(sp)
 3fa:	6402                	ld	s0,0(sp)
 3fc:	0141                	addi	sp,sp,16
 3fe:	8082                	ret

0000000000000400 <strchr>:

char *
strchr(const char *s, char c)
{
 400:	1141                	addi	sp,sp,-16
 402:	e406                	sd	ra,8(sp)
 404:	e022                	sd	s0,0(sp)
 406:	0800                	addi	s0,sp,16
  for (; *s; s++)
 408:	00054783          	lbu	a5,0(a0)
 40c:	c799                	beqz	a5,41a <strchr+0x1a>
    if (*s == c)
 40e:	00f58763          	beq	a1,a5,41c <strchr+0x1c>
  for (; *s; s++)
 412:	0505                	addi	a0,a0,1
 414:	00054783          	lbu	a5,0(a0)
 418:	fbfd                	bnez	a5,40e <strchr+0xe>
      return (char *)s;
  return 0;
 41a:	4501                	li	a0,0
}
 41c:	60a2                	ld	ra,8(sp)
 41e:	6402                	ld	s0,0(sp)
 420:	0141                	addi	sp,sp,16
 422:	8082                	ret

0000000000000424 <gets>:

char *
gets(char *buf, int max)
{
 424:	711d                	addi	sp,sp,-96
 426:	ec86                	sd	ra,88(sp)
 428:	e8a2                	sd	s0,80(sp)
 42a:	e4a6                	sd	s1,72(sp)
 42c:	e0ca                	sd	s2,64(sp)
 42e:	fc4e                	sd	s3,56(sp)
 430:	f852                	sd	s4,48(sp)
 432:	f456                	sd	s5,40(sp)
 434:	f05a                	sd	s6,32(sp)
 436:	ec5e                	sd	s7,24(sp)
 438:	e862                	sd	s8,16(sp)
 43a:	1080                	addi	s0,sp,96
 43c:	8baa                	mv	s7,a0
 43e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 440:	892a                	mv	s2,a0
 442:	4481                	li	s1,0
    cc = read(0, &c, 1);
 444:	faf40b13          	addi	s6,s0,-81
 448:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;) {
 44a:	8c26                	mv	s8,s1
 44c:	0014899b          	addiw	s3,s1,1
 450:	84ce                	mv	s1,s3
 452:	0349d863          	bge	s3,s4,482 <gets+0x5e>
    cc = read(0, &c, 1);
 456:	8656                	mv	a2,s5
 458:	85da                	mv	a1,s6
 45a:	4501                	li	a0,0
 45c:	1c0000ef          	jal	61c <read>
    if (cc < 1)
 460:	02a05163          	blez	a0,482 <gets+0x5e>
      break;
    buf[i++] = c;
 464:	faf44783          	lbu	a5,-81(s0)
 468:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 46c:	0905                	addi	s2,s2,1
 46e:	ff678713          	addi	a4,a5,-10
 472:	00173713          	seqz	a4,a4
 476:	17cd                	addi	a5,a5,-13
 478:	0017b793          	seqz	a5,a5
 47c:	8fd9                	or	a5,a5,a4
 47e:	d7f1                	beqz	a5,44a <gets+0x26>
    buf[i++] = c;
 480:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 482:	9c5e                	add	s8,s8,s7
 484:	000c0023          	sb	zero,0(s8)
  return buf;
}
 488:	855e                	mv	a0,s7
 48a:	60e6                	ld	ra,88(sp)
 48c:	6446                	ld	s0,80(sp)
 48e:	64a6                	ld	s1,72(sp)
 490:	6906                	ld	s2,64(sp)
 492:	79e2                	ld	s3,56(sp)
 494:	7a42                	ld	s4,48(sp)
 496:	7aa2                	ld	s5,40(sp)
 498:	7b02                	ld	s6,32(sp)
 49a:	6be2                	ld	s7,24(sp)
 49c:	6c42                	ld	s8,16(sp)
 49e:	6125                	addi	sp,sp,96
 4a0:	8082                	ret

00000000000004a2 <stat>:

int
stat(const char *n, struct stat *st)
{
 4a2:	1101                	addi	sp,sp,-32
 4a4:	ec06                	sd	ra,24(sp)
 4a6:	e822                	sd	s0,16(sp)
 4a8:	e04a                	sd	s2,0(sp)
 4aa:	1000                	addi	s0,sp,32
 4ac:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4ae:	4581                	li	a1,0
 4b0:	194000ef          	jal	644 <open>
  if (fd < 0)
 4b4:	02054263          	bltz	a0,4d8 <stat+0x36>
 4b8:	e426                	sd	s1,8(sp)
 4ba:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4bc:	85ca                	mv	a1,s2
 4be:	19e000ef          	jal	65c <fstat>
 4c2:	892a                	mv	s2,a0
  close(fd);
 4c4:	8526                	mv	a0,s1
 4c6:	166000ef          	jal	62c <close>
  return r;
 4ca:	64a2                	ld	s1,8(sp)
}
 4cc:	854a                	mv	a0,s2
 4ce:	60e2                	ld	ra,24(sp)
 4d0:	6442                	ld	s0,16(sp)
 4d2:	6902                	ld	s2,0(sp)
 4d4:	6105                	addi	sp,sp,32
 4d6:	8082                	ret
    return -1;
 4d8:	57fd                	li	a5,-1
 4da:	893e                	mv	s2,a5
 4dc:	bfc5                	j	4cc <stat+0x2a>

00000000000004de <atoi>:

int
atoi(const char *s)
{
 4de:	1141                	addi	sp,sp,-16
 4e0:	e406                	sd	ra,8(sp)
 4e2:	e022                	sd	s0,0(sp)
 4e4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 4e6:	00054683          	lbu	a3,0(a0)
 4ea:	fd06879b          	addiw	a5,a3,-48
 4ee:	0ff7f793          	zext.b	a5,a5
 4f2:	4625                	li	a2,9
 4f4:	02f66963          	bltu	a2,a5,526 <atoi+0x48>
 4f8:	872a                	mv	a4,a0
  n = 0;
 4fa:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 4fc:	0705                	addi	a4,a4,1
 4fe:	0025179b          	slliw	a5,a0,0x2
 502:	9fa9                	addw	a5,a5,a0
 504:	0017979b          	slliw	a5,a5,0x1
 508:	9fb5                	addw	a5,a5,a3
 50a:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 50e:	00074683          	lbu	a3,0(a4)
 512:	fd06879b          	addiw	a5,a3,-48
 516:	0ff7f793          	zext.b	a5,a5
 51a:	fef671e3          	bgeu	a2,a5,4fc <atoi+0x1e>
  return n;
}
 51e:	60a2                	ld	ra,8(sp)
 520:	6402                	ld	s0,0(sp)
 522:	0141                	addi	sp,sp,16
 524:	8082                	ret
  n = 0;
 526:	4501                	li	a0,0
 528:	bfdd                	j	51e <atoi+0x40>

000000000000052a <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 52a:	1141                	addi	sp,sp,-16
 52c:	e406                	sd	ra,8(sp)
 52e:	e022                	sd	s0,0(sp)
 530:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 532:	02b57563          	bgeu	a0,a1,55c <memmove+0x32>
    while (n-- > 0)
 536:	00c05f63          	blez	a2,554 <memmove+0x2a>
 53a:	1602                	slli	a2,a2,0x20
 53c:	9201                	srli	a2,a2,0x20
 53e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 542:	872a                	mv	a4,a0
      *dst++ = *src++;
 544:	0585                	addi	a1,a1,1
 546:	0705                	addi	a4,a4,1
 548:	fff5c683          	lbu	a3,-1(a1)
 54c:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 550:	fee79ae3          	bne	a5,a4,544 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 554:	60a2                	ld	ra,8(sp)
 556:	6402                	ld	s0,0(sp)
 558:	0141                	addi	sp,sp,16
 55a:	8082                	ret
    while (n-- > 0)
 55c:	fec05ce3          	blez	a2,554 <memmove+0x2a>
    dst += n;
 560:	00c50733          	add	a4,a0,a2
    src += n;
 564:	95b2                	add	a1,a1,a2
 566:	fff6079b          	addiw	a5,a2,-1
 56a:	1782                	slli	a5,a5,0x20
 56c:	9381                	srli	a5,a5,0x20
 56e:	fff7c793          	not	a5,a5
 572:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 574:	15fd                	addi	a1,a1,-1
 576:	177d                	addi	a4,a4,-1
 578:	0005c683          	lbu	a3,0(a1)
 57c:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 580:	fef71ae3          	bne	a4,a5,574 <memmove+0x4a>
 584:	bfc1                	j	554 <memmove+0x2a>

0000000000000586 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 586:	1141                	addi	sp,sp,-16
 588:	e406                	sd	ra,8(sp)
 58a:	e022                	sd	s0,0(sp)
 58c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 58e:	ce19                	beqz	a2,5ac <memcmp+0x26>
 590:	1602                	slli	a2,a2,0x20
 592:	9201                	srli	a2,a2,0x20
 594:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 598:	00054783          	lbu	a5,0(a0)
 59c:	0005c703          	lbu	a4,0(a1)
 5a0:	00e79b63          	bne	a5,a4,5b6 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
 5a4:	0505                	addi	a0,a0,1
    p2++;
 5a6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 5a8:	fed518e3          	bne	a0,a3,598 <memcmp+0x12>
  }
  return 0;
 5ac:	4501                	li	a0,0
}
 5ae:	60a2                	ld	ra,8(sp)
 5b0:	6402                	ld	s0,0(sp)
 5b2:	0141                	addi	sp,sp,16
 5b4:	8082                	ret
      return *p1 - *p2;
 5b6:	40e7853b          	subw	a0,a5,a4
 5ba:	bfd5                	j	5ae <memcmp+0x28>

00000000000005bc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5bc:	1141                	addi	sp,sp,-16
 5be:	e406                	sd	ra,8(sp)
 5c0:	e022                	sd	s0,0(sp)
 5c2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5c4:	f67ff0ef          	jal	52a <memmove>
}
 5c8:	60a2                	ld	ra,8(sp)
 5ca:	6402                	ld	s0,0(sp)
 5cc:	0141                	addi	sp,sp,16
 5ce:	8082                	ret

00000000000005d0 <sbrk>:

char *
sbrk(int n)
{
 5d0:	1141                	addi	sp,sp,-16
 5d2:	e406                	sd	ra,8(sp)
 5d4:	e022                	sd	s0,0(sp)
 5d6:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 5d8:	4585                	li	a1,1
 5da:	0b2000ef          	jal	68c <sys_sbrk>
}
 5de:	60a2                	ld	ra,8(sp)
 5e0:	6402                	ld	s0,0(sp)
 5e2:	0141                	addi	sp,sp,16
 5e4:	8082                	ret

00000000000005e6 <sbrklazy>:

char *
sbrklazy(int n)
{
 5e6:	1141                	addi	sp,sp,-16
 5e8:	e406                	sd	ra,8(sp)
 5ea:	e022                	sd	s0,0(sp)
 5ec:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 5ee:	4589                	li	a1,2
 5f0:	09c000ef          	jal	68c <sys_sbrk>
}
 5f4:	60a2                	ld	ra,8(sp)
 5f6:	6402                	ld	s0,0(sp)
 5f8:	0141                	addi	sp,sp,16
 5fa:	8082                	ret

00000000000005fc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5fc:	4885                	li	a7,1
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <exit>:
.global exit
exit:
 li a7, SYS_exit
 604:	4889                	li	a7,2
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <wait>:
.global wait
wait:
 li a7, SYS_wait
 60c:	488d                	li	a7,3
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 614:	4891                	li	a7,4
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <read>:
.global read
read:
 li a7, SYS_read
 61c:	4895                	li	a7,5
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <write>:
.global write
write:
 li a7, SYS_write
 624:	48c1                	li	a7,16
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <close>:
.global close
close:
 li a7, SYS_close
 62c:	48d5                	li	a7,21
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <kill>:
.global kill
kill:
 li a7, SYS_kill
 634:	4899                	li	a7,6
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <exec>:
.global exec
exec:
 li a7, SYS_exec
 63c:	489d                	li	a7,7
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <open>:
.global open
open:
 li a7, SYS_open
 644:	48bd                	li	a7,15
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 64c:	48c5                	li	a7,17
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 654:	48c9                	li	a7,18
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 65c:	48a1                	li	a7,8
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <link>:
.global link
link:
 li a7, SYS_link
 664:	48cd                	li	a7,19
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 66c:	48d1                	li	a7,20
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 674:	48a5                	li	a7,9
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <dup>:
.global dup
dup:
 li a7, SYS_dup
 67c:	48a9                	li	a7,10
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 684:	48ad                	li	a7,11
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 68c:	48b1                	li	a7,12
 ecall
 68e:	00000073          	ecall
 ret
 692:	8082                	ret

0000000000000694 <pause>:
.global pause
pause:
 li a7, SYS_pause
 694:	48b5                	li	a7,13
 ecall
 696:	00000073          	ecall
 ret
 69a:	8082                	ret

000000000000069c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 69c:	48b9                	li	a7,14
 ecall
 69e:	00000073          	ecall
 ret
 6a2:	8082                	ret

00000000000006a4 <sync>:
.global sync
sync:
 li a7, SYS_sync
 6a4:	48d9                	li	a7,22
 ecall
 6a6:	00000073          	ecall
 ret
 6aa:	8082                	ret

00000000000006ac <istat>:
.global istat
istat:
 li a7, SYS_istat
 6ac:	48dd                	li	a7,23
 ecall
 6ae:	00000073          	ecall
 ret
 6b2:	8082                	ret

00000000000006b4 <iprint>:
.global iprint
iprint:
 li a7, SYS_iprint
 6b4:	48e1                	li	a7,24
 ecall
 6b6:	00000073          	ecall
 ret
 6ba:	8082                	ret

00000000000006bc <symlink>:
.global symlink
symlink:
 li a7, SYS_symlink
 6bc:	48e5                	li	a7,25
 ecall
 6be:	00000073          	ecall
 ret
 6c2:	8082                	ret

00000000000006c4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6c4:	1101                	addi	sp,sp,-32
 6c6:	ec06                	sd	ra,24(sp)
 6c8:	e822                	sd	s0,16(sp)
 6ca:	1000                	addi	s0,sp,32
 6cc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6d0:	4605                	li	a2,1
 6d2:	fef40593          	addi	a1,s0,-17
 6d6:	f4fff0ef          	jal	624 <write>
}
 6da:	60e2                	ld	ra,24(sp)
 6dc:	6442                	ld	s0,16(sp)
 6de:	6105                	addi	sp,sp,32
 6e0:	8082                	ret

00000000000006e2 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 6e2:	715d                	addi	sp,sp,-80
 6e4:	e486                	sd	ra,72(sp)
 6e6:	e0a2                	sd	s0,64(sp)
 6e8:	f84a                	sd	s2,48(sp)
 6ea:	f44e                	sd	s3,40(sp)
 6ec:	0880                	addi	s0,sp,80
 6ee:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 6f0:	00d036b3          	snez	a3,a3
 6f4:	03f5d793          	srli	a5,a1,0x3f
 6f8:	8efd                	and	a3,a3,a5
  neg = 0;
 6fa:	4301                	li	t1,0
  if (sgn && xx < 0) {
 6fc:	c681                	beqz	a3,704 <printint+0x22>
    neg = 1;
    x = -xx;
 6fe:	40b005b3          	neg	a1,a1
    neg = 1;
 702:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 704:	fb840993          	addi	s3,s0,-72
  neg = 0;
 708:	86ce                	mv	a3,s3
  i = 0;
 70a:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
 70c:	00000817          	auipc	a6,0x0
 710:	79480813          	addi	a6,a6,1940 # ea0 <digits>
 714:	88ba                	mv	a7,a4
 716:	0017051b          	addiw	a0,a4,1
 71a:	872a                	mv	a4,a0
 71c:	02c5f7b3          	remu	a5,a1,a2
 720:	97c2                	add	a5,a5,a6
 722:	0007c783          	lbu	a5,0(a5)
 726:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
 72a:	87ae                	mv	a5,a1
 72c:	02c5d5b3          	divu	a1,a1,a2
 730:	0685                	addi	a3,a3,1
 732:	fec7f1e3          	bgeu	a5,a2,714 <printint+0x32>
  if (neg)
 736:	00030b63          	beqz	t1,74c <printint+0x6a>
    buf[i++] = '-';
 73a:	fd040793          	addi	a5,s0,-48
 73e:	953e                	add	a0,a0,a5
 740:	02d00793          	li	a5,45
 744:	fef50423          	sb	a5,-24(a0)
 748:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
 74c:	02e05563          	blez	a4,776 <printint+0x94>
 750:	fc26                	sd	s1,56(sp)
 752:	377d                	addiw	a4,a4,-1
 754:	00e984b3          	add	s1,s3,a4
 758:	19fd                	addi	s3,s3,-1
 75a:	99ba                	add	s3,s3,a4
 75c:	1702                	slli	a4,a4,0x20
 75e:	9301                	srli	a4,a4,0x20
 760:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 764:	0004c583          	lbu	a1,0(s1)
 768:	854a                	mv	a0,s2
 76a:	f5bff0ef          	jal	6c4 <putc>
  while (--i >= 0)
 76e:	14fd                	addi	s1,s1,-1
 770:	ff349ae3          	bne	s1,s3,764 <printint+0x82>
 774:	74e2                	ld	s1,56(sp)
}
 776:	60a6                	ld	ra,72(sp)
 778:	6406                	ld	s0,64(sp)
 77a:	7942                	ld	s2,48(sp)
 77c:	79a2                	ld	s3,40(sp)
 77e:	6161                	addi	sp,sp,80
 780:	8082                	ret

0000000000000782 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 782:	711d                	addi	sp,sp,-96
 784:	ec86                	sd	ra,88(sp)
 786:	e8a2                	sd	s0,80(sp)
 788:	e4a6                	sd	s1,72(sp)
 78a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 78c:	0005c483          	lbu	s1,0(a1)
 790:	2a048063          	beqz	s1,a30 <vprintf+0x2ae>
 794:	e0ca                	sd	s2,64(sp)
 796:	fc4e                	sd	s3,56(sp)
 798:	f852                	sd	s4,48(sp)
 79a:	f456                	sd	s5,40(sp)
 79c:	f05a                	sd	s6,32(sp)
 79e:	ec5e                	sd	s7,24(sp)
 7a0:	e862                	sd	s8,16(sp)
 7a2:	8b2a                	mv	s6,a0
 7a4:	8a2e                	mv	s4,a1
 7a6:	8bb2                	mv	s7,a2
  state = 0;
 7a8:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 7aa:	4901                	li	s2,0
 7ac:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 7ae:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 7b2:	06400c13          	li	s8,100
 7b6:	a00d                	j	7d8 <vprintf+0x56>
        putc(fd, c0);
 7b8:	85a6                	mv	a1,s1
 7ba:	855a                	mv	a0,s6
 7bc:	f09ff0ef          	jal	6c4 <putc>
 7c0:	a019                	j	7c6 <vprintf+0x44>
    } else if (state == '%') {
 7c2:	03598363          	beq	s3,s5,7e8 <vprintf+0x66>
  for (i = 0; fmt[i]; i++) {
 7c6:	0019079b          	addiw	a5,s2,1
 7ca:	893e                	mv	s2,a5
 7cc:	873e                	mv	a4,a5
 7ce:	97d2                	add	a5,a5,s4
 7d0:	0007c483          	lbu	s1,0(a5)
 7d4:	24048763          	beqz	s1,a22 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
 7d8:	0004879b          	sext.w	a5,s1
    if (state == 0) {
 7dc:	fe0993e3          	bnez	s3,7c2 <vprintf+0x40>
      if (c0 == '%') {
 7e0:	fd579ce3          	bne	a5,s5,7b8 <vprintf+0x36>
        state = '%';
 7e4:	89be                	mv	s3,a5
 7e6:	b7c5                	j	7c6 <vprintf+0x44>
        c1 = fmt[i + 1] & 0xff;
 7e8:	00ea06b3          	add	a3,s4,a4
 7ec:	0016c603          	lbu	a2,1(a3)
      if (c1)
 7f0:	24060563          	beqz	a2,a3a <vprintf+0x2b8>
      if (c0 == 'd') {
 7f4:	0b878763          	beq	a5,s8,8a2 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 7f8:	f9478693          	addi	a3,a5,-108
 7fc:	0016b693          	seqz	a3,a3
 800:	f9c60593          	addi	a1,a2,-100
 804:	0015b593          	seqz	a1,a1
 808:	8df5                	and	a1,a1,a3
 80a:	e9c5                	bnez	a1,8ba <vprintf+0x138>
        c2 = fmt[i + 2] & 0xff;
 80c:	9752                	add	a4,a4,s4
 80e:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 812:	f9460713          	addi	a4,a2,-108
 816:	00173713          	seqz	a4,a4
 81a:	8f75                	and	a4,a4,a3
 81c:	f9c50593          	addi	a1,a0,-100
 820:	0015b593          	seqz	a1,a1
 824:	8df9                	and	a1,a1,a4
 826:	e5dd                	bnez	a1,8d4 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 828:	07500593          	li	a1,117
 82c:	0cb78163          	beq	a5,a1,8ee <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if (c0 == 'l' && c1 == 'u') {
 830:	f8b60593          	addi	a1,a2,-117
 834:	0015b593          	seqz	a1,a1
 838:	8df5                	and	a1,a1,a3
 83a:	e5f1                	bnez	a1,906 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 83c:	f8b50593          	addi	a1,a0,-117
 840:	0015b593          	seqz	a1,a1
 844:	8df9                	and	a1,a1,a4
 846:	ede9                	bnez	a1,920 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 848:	07800593          	li	a1,120
 84c:	0eb78763          	beq	a5,a1,93a <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if (c0 == 'l' && c1 == 'x') {
 850:	f8860613          	addi	a2,a2,-120
 854:	00163613          	seqz	a2,a2
 858:	8ef1                	and	a3,a3,a2
 85a:	0e069c63          	bnez	a3,952 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 85e:	f8850513          	addi	a0,a0,-120
 862:	00153513          	seqz	a0,a0
 866:	8f69                	and	a4,a4,a0
 868:	10071263          	bnez	a4,96c <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 86c:	07000713          	li	a4,112
 870:	10e78a63          	beq	a5,a4,984 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 874:	06300713          	li	a4,99
 878:	14e78a63          	beq	a5,a4,9cc <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 87c:	07300713          	li	a4,115
 880:	16e78063          	beq	a5,a4,9e0 <vprintf+0x25e>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 884:	02500713          	li	a4,37
 888:	18e78863          	beq	a5,a4,a18 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 88c:	02500593          	li	a1,37
 890:	855a                	mv	a0,s6
 892:	e33ff0ef          	jal	6c4 <putc>
        putc(fd, c0);
 896:	85a6                	mv	a1,s1
 898:	855a                	mv	a0,s6
 89a:	e2bff0ef          	jal	6c4 <putc>
      }

      state = 0;
 89e:	4981                	li	s3,0
 8a0:	b71d                	j	7c6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 8a2:	008b8493          	addi	s1,s7,8
 8a6:	4685                	li	a3,1
 8a8:	4629                	li	a2,10
 8aa:	000ba583          	lw	a1,0(s7)
 8ae:	855a                	mv	a0,s6
 8b0:	e33ff0ef          	jal	6e2 <printint>
 8b4:	8ba6                	mv	s7,s1
      state = 0;
 8b6:	4981                	li	s3,0
 8b8:	b739                	j	7c6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8ba:	008b8493          	addi	s1,s7,8
 8be:	4685                	li	a3,1
 8c0:	4629                	li	a2,10
 8c2:	000bb583          	ld	a1,0(s7)
 8c6:	855a                	mv	a0,s6
 8c8:	e1bff0ef          	jal	6e2 <printint>
        i += 1;
 8cc:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 8ce:	8ba6                	mv	s7,s1
      state = 0;
 8d0:	4981                	li	s3,0
 8d2:	bdd5                	j	7c6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8d4:	008b8493          	addi	s1,s7,8
 8d8:	4685                	li	a3,1
 8da:	4629                	li	a2,10
 8dc:	000bb583          	ld	a1,0(s7)
 8e0:	855a                	mv	a0,s6
 8e2:	e01ff0ef          	jal	6e2 <printint>
        i += 2;
 8e6:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 8e8:	8ba6                	mv	s7,s1
      state = 0;
 8ea:	4981                	li	s3,0
        i += 2;
 8ec:	bde9                	j	7c6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
 8ee:	008b8493          	addi	s1,s7,8
 8f2:	4681                	li	a3,0
 8f4:	4629                	li	a2,10
 8f6:	000be583          	lwu	a1,0(s7)
 8fa:	855a                	mv	a0,s6
 8fc:	de7ff0ef          	jal	6e2 <printint>
 900:	8ba6                	mv	s7,s1
      state = 0;
 902:	4981                	li	s3,0
 904:	b5c9                	j	7c6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 906:	008b8493          	addi	s1,s7,8
 90a:	4681                	li	a3,0
 90c:	4629                	li	a2,10
 90e:	000bb583          	ld	a1,0(s7)
 912:	855a                	mv	a0,s6
 914:	dcfff0ef          	jal	6e2 <printint>
        i += 1;
 918:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 91a:	8ba6                	mv	s7,s1
      state = 0;
 91c:	4981                	li	s3,0
 91e:	b565                	j	7c6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 920:	008b8493          	addi	s1,s7,8
 924:	4681                	li	a3,0
 926:	4629                	li	a2,10
 928:	000bb583          	ld	a1,0(s7)
 92c:	855a                	mv	a0,s6
 92e:	db5ff0ef          	jal	6e2 <printint>
        i += 2;
 932:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 934:	8ba6                	mv	s7,s1
      state = 0;
 936:	4981                	li	s3,0
        i += 2;
 938:	b579                	j	7c6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
 93a:	008b8493          	addi	s1,s7,8
 93e:	4681                	li	a3,0
 940:	4641                	li	a2,16
 942:	000be583          	lwu	a1,0(s7)
 946:	855a                	mv	a0,s6
 948:	d9bff0ef          	jal	6e2 <printint>
 94c:	8ba6                	mv	s7,s1
      state = 0;
 94e:	4981                	li	s3,0
 950:	bd9d                	j	7c6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 952:	008b8493          	addi	s1,s7,8
 956:	4681                	li	a3,0
 958:	4641                	li	a2,16
 95a:	000bb583          	ld	a1,0(s7)
 95e:	855a                	mv	a0,s6
 960:	d83ff0ef          	jal	6e2 <printint>
        i += 1;
 964:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 966:	8ba6                	mv	s7,s1
      state = 0;
 968:	4981                	li	s3,0
 96a:	bdb1                	j	7c6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 96c:	008b8493          	addi	s1,s7,8
 970:	4641                	li	a2,16
 972:	000bb583          	ld	a1,0(s7)
 976:	855a                	mv	a0,s6
 978:	d6bff0ef          	jal	6e2 <printint>
        i += 2;
 97c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 97e:	8ba6                	mv	s7,s1
      state = 0;
 980:	4981                	li	s3,0
        i += 2;
 982:	b591                	j	7c6 <vprintf+0x44>
 984:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 986:	008b8793          	addi	a5,s7,8
 98a:	8cbe                	mv	s9,a5
 98c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 990:	03000593          	li	a1,48
 994:	855a                	mv	a0,s6
 996:	d2fff0ef          	jal	6c4 <putc>
  putc(fd, 'x');
 99a:	07800593          	li	a1,120
 99e:	855a                	mv	a0,s6
 9a0:	d25ff0ef          	jal	6c4 <putc>
 9a4:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9a6:	00000b97          	auipc	s7,0x0
 9aa:	4fab8b93          	addi	s7,s7,1274 # ea0 <digits>
 9ae:	03c9d793          	srli	a5,s3,0x3c
 9b2:	97de                	add	a5,a5,s7
 9b4:	0007c583          	lbu	a1,0(a5)
 9b8:	855a                	mv	a0,s6
 9ba:	d0bff0ef          	jal	6c4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9be:	0992                	slli	s3,s3,0x4
 9c0:	34fd                	addiw	s1,s1,-1
 9c2:	f4f5                	bnez	s1,9ae <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
 9c4:	8be6                	mv	s7,s9
      state = 0;
 9c6:	4981                	li	s3,0
 9c8:	6ca2                	ld	s9,8(sp)
 9ca:	bbf5                	j	7c6 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
 9cc:	008b8493          	addi	s1,s7,8
 9d0:	000bc583          	lbu	a1,0(s7)
 9d4:	855a                	mv	a0,s6
 9d6:	cefff0ef          	jal	6c4 <putc>
 9da:	8ba6                	mv	s7,s1
      state = 0;
 9dc:	4981                	li	s3,0
 9de:	b3e5                	j	7c6 <vprintf+0x44>
        if ((s = va_arg(ap, char *)) == 0)
 9e0:	008b8993          	addi	s3,s7,8
 9e4:	000bb483          	ld	s1,0(s7)
 9e8:	cc91                	beqz	s1,a04 <vprintf+0x282>
        for (; *s; s++)
 9ea:	0004c583          	lbu	a1,0(s1)
 9ee:	c195                	beqz	a1,a12 <vprintf+0x290>
          putc(fd, *s);
 9f0:	855a                	mv	a0,s6
 9f2:	cd3ff0ef          	jal	6c4 <putc>
        for (; *s; s++)
 9f6:	0485                	addi	s1,s1,1
 9f8:	0004c583          	lbu	a1,0(s1)
 9fc:	f9f5                	bnez	a1,9f0 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 9fe:	8bce                	mv	s7,s3
      state = 0;
 a00:	4981                	li	s3,0
 a02:	b3d1                	j	7c6 <vprintf+0x44>
          s = "(null)";
 a04:	00000497          	auipc	s1,0x0
 a08:	49448493          	addi	s1,s1,1172 # e98 <malloc+0x362>
        for (; *s; s++)
 a0c:	02800593          	li	a1,40
 a10:	b7c5                	j	9f0 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
 a12:	8bce                	mv	s7,s3
      state = 0;
 a14:	4981                	li	s3,0
 a16:	bb45                	j	7c6 <vprintf+0x44>
        putc(fd, '%');
 a18:	85be                	mv	a1,a5
 a1a:	855a                	mv	a0,s6
 a1c:	ca9ff0ef          	jal	6c4 <putc>
 a20:	bdbd                	j	89e <vprintf+0x11c>
 a22:	6906                	ld	s2,64(sp)
 a24:	79e2                	ld	s3,56(sp)
 a26:	7a42                	ld	s4,48(sp)
 a28:	7aa2                	ld	s5,40(sp)
 a2a:	7b02                	ld	s6,32(sp)
 a2c:	6be2                	ld	s7,24(sp)
 a2e:	6c42                	ld	s8,16(sp)
    }
  }
}
 a30:	60e6                	ld	ra,88(sp)
 a32:	6446                	ld	s0,80(sp)
 a34:	64a6                	ld	s1,72(sp)
 a36:	6125                	addi	sp,sp,96
 a38:	8082                	ret
      if (c0 == 'd') {
 a3a:	06400713          	li	a4,100
 a3e:	e6e782e3          	beq	a5,a4,8a2 <vprintf+0x120>
      } else if (c0 == 'l' && c1 == 'd') {
 a42:	f9478693          	addi	a3,a5,-108
 a46:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 a4a:	8532                	mv	a0,a2
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 a4c:	4701                	li	a4,0
 a4e:	bbe9                	j	828 <vprintf+0xa6>

0000000000000a50 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a50:	715d                	addi	sp,sp,-80
 a52:	ec06                	sd	ra,24(sp)
 a54:	e822                	sd	s0,16(sp)
 a56:	1000                	addi	s0,sp,32
 a58:	e010                	sd	a2,0(s0)
 a5a:	e414                	sd	a3,8(s0)
 a5c:	e818                	sd	a4,16(s0)
 a5e:	ec1c                	sd	a5,24(s0)
 a60:	03043023          	sd	a6,32(s0)
 a64:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a68:	8622                	mv	a2,s0
 a6a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a6e:	d15ff0ef          	jal	782 <vprintf>
}
 a72:	60e2                	ld	ra,24(sp)
 a74:	6442                	ld	s0,16(sp)
 a76:	6161                	addi	sp,sp,80
 a78:	8082                	ret

0000000000000a7a <printf>:

void
printf(const char *fmt, ...)
{
 a7a:	711d                	addi	sp,sp,-96
 a7c:	ec06                	sd	ra,24(sp)
 a7e:	e822                	sd	s0,16(sp)
 a80:	1000                	addi	s0,sp,32
 a82:	e40c                	sd	a1,8(s0)
 a84:	e810                	sd	a2,16(s0)
 a86:	ec14                	sd	a3,24(s0)
 a88:	f018                	sd	a4,32(s0)
 a8a:	f41c                	sd	a5,40(s0)
 a8c:	03043823          	sd	a6,48(s0)
 a90:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a94:	00840613          	addi	a2,s0,8
 a98:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a9c:	85aa                	mv	a1,a0
 a9e:	4505                	li	a0,1
 aa0:	ce3ff0ef          	jal	782 <vprintf>
}
 aa4:	60e2                	ld	ra,24(sp)
 aa6:	6442                	ld	s0,16(sp)
 aa8:	6125                	addi	sp,sp,96
 aaa:	8082                	ret

0000000000000aac <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 aac:	1141                	addi	sp,sp,-16
 aae:	e406                	sd	ra,8(sp)
 ab0:	e022                	sd	s0,0(sp)
 ab2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 ab4:	ff050713          	addi	a4,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ab8:	00000797          	auipc	a5,0x0
 abc:	5487b783          	ld	a5,1352(a5) # 1000 <freep>
 ac0:	a095                	j	b24 <free+0x78>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
 ac2:	ff852583          	lw	a1,-8(a0)
 ac6:	6390                	ld	a2,0(a5)
 ac8:	02059813          	slli	a6,a1,0x20
 acc:	01c85693          	srli	a3,a6,0x1c
 ad0:	96ba                	add	a3,a3,a4
 ad2:	02d60563          	beq	a2,a3,afc <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 ad6:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
 ada:	4790                	lw	a2,8(a5)
 adc:	02061593          	slli	a1,a2,0x20
 ae0:	01c5d693          	srli	a3,a1,0x1c
 ae4:	96be                	add	a3,a3,a5
 ae6:	02d70263          	beq	a4,a3,b0a <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 aea:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 aec:	00000717          	auipc	a4,0x0
 af0:	50f73a23          	sd	a5,1300(a4) # 1000 <freep>
}
 af4:	60a2                	ld	ra,8(sp)
 af6:	6402                	ld	s0,0(sp)
 af8:	0141                	addi	sp,sp,16
 afa:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 afc:	4614                	lw	a3,8(a2)
 afe:	9ead                	addw	a3,a3,a1
 b00:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b04:	6394                	ld	a3,0(a5)
 b06:	6290                	ld	a2,0(a3)
 b08:	b7f9                	j	ad6 <free+0x2a>
    p->s.size += bp->s.size;
 b0a:	ff852703          	lw	a4,-8(a0)
 b0e:	9f31                	addw	a4,a4,a2
 b10:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b12:	ff053703          	ld	a4,-16(a0)
 b16:	bfd1                	j	aea <free+0x3e>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b18:	6394                	ld	a3,0(a5)
 b1a:	00d7e463          	bltu	a5,a3,b22 <free+0x76>
 b1e:	fad762e3          	bltu	a4,a3,ac2 <free+0x16>
 b22:	87b6                	mv	a5,a3
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b24:	fee7fae3          	bgeu	a5,a4,b18 <free+0x6c>
 b28:	6394                	ld	a3,0(a5)
 b2a:	f8d76ce3          	bltu	a4,a3,ac2 <free+0x16>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b2e:	f8d7fae3          	bgeu	a5,a3,ac2 <free+0x16>
 b32:	87b6                	mv	a5,a3
 b34:	bfc5                	j	b24 <free+0x78>

0000000000000b36 <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
 b36:	7139                	addi	sp,sp,-64
 b38:	fc06                	sd	ra,56(sp)
 b3a:	f822                	sd	s0,48(sp)
 b3c:	f04a                	sd	s2,32(sp)
 b3e:	ec4e                	sd	s3,24(sp)
 b40:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b42:	02051993          	slli	s3,a0,0x20
 b46:	0209d993          	srli	s3,s3,0x20
 b4a:	09bd                	addi	s3,s3,15
 b4c:	0049d993          	srli	s3,s3,0x4
 b50:	2985                	addiw	s3,s3,1
 b52:	894e                	mv	s2,s3
  if ((prevp = freep) == 0) {
 b54:	00000517          	auipc	a0,0x0
 b58:	4ac53503          	ld	a0,1196(a0) # 1000 <freep>
 b5c:	c905                	beqz	a0,b8c <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 b5e:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 b60:	4798                	lw	a4,8(a5)
 b62:	09377663          	bgeu	a4,s3,bee <malloc+0xb8>
 b66:	f426                	sd	s1,40(sp)
 b68:	e852                	sd	s4,16(sp)
 b6a:	e456                	sd	s5,8(sp)
 b6c:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 b6e:	8a4e                	mv	s4,s3
 b70:	6705                	lui	a4,0x1
 b72:	00e9f363          	bgeu	s3,a4,b78 <malloc+0x42>
 b76:	6a05                	lui	s4,0x1
 b78:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b7c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 b80:	00000497          	auipc	s1,0x0
 b84:	48048493          	addi	s1,s1,1152 # 1000 <freep>
  if (p == SBRK_ERROR)
 b88:	5afd                	li	s5,-1
 b8a:	a83d                	j	bc8 <malloc+0x92>
 b8c:	f426                	sd	s1,40(sp)
 b8e:	e852                	sd	s4,16(sp)
 b90:	e456                	sd	s5,8(sp)
 b92:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 b94:	00002797          	auipc	a5,0x2
 b98:	47c78793          	addi	a5,a5,1148 # 3010 <base>
 b9c:	00000717          	auipc	a4,0x0
 ba0:	46f73223          	sd	a5,1124(a4) # 1000 <freep>
 ba4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ba6:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 baa:	b7d1                	j	b6e <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 bac:	6398                	ld	a4,0(a5)
 bae:	e118                	sd	a4,0(a0)
 bb0:	a899                	j	c06 <malloc+0xd0>
  hp->s.size = nu;
 bb2:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 bb6:	0541                	addi	a0,a0,16
 bb8:	ef5ff0ef          	jal	aac <free>
  return freep;
 bbc:	6088                	ld	a0,0(s1)
      if ((p = morecore(nunits)) == 0)
 bbe:	c125                	beqz	a0,c1e <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 bc0:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 bc2:	4798                	lw	a4,8(a5)
 bc4:	03277163          	bgeu	a4,s2,be6 <malloc+0xb0>
    if (p == freep)
 bc8:	6098                	ld	a4,0(s1)
 bca:	853e                	mv	a0,a5
 bcc:	fef71ae3          	bne	a4,a5,bc0 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 bd0:	8552                	mv	a0,s4
 bd2:	9ffff0ef          	jal	5d0 <sbrk>
  if (p == SBRK_ERROR)
 bd6:	fd551ee3          	bne	a0,s5,bb2 <malloc+0x7c>
        return 0;
 bda:	4501                	li	a0,0
 bdc:	74a2                	ld	s1,40(sp)
 bde:	6a42                	ld	s4,16(sp)
 be0:	6aa2                	ld	s5,8(sp)
 be2:	6b02                	ld	s6,0(sp)
 be4:	a03d                	j	c12 <malloc+0xdc>
 be6:	74a2                	ld	s1,40(sp)
 be8:	6a42                	ld	s4,16(sp)
 bea:	6aa2                	ld	s5,8(sp)
 bec:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
 bee:	fae90fe3          	beq	s2,a4,bac <malloc+0x76>
        p->s.size -= nunits;
 bf2:	4137073b          	subw	a4,a4,s3
 bf6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 bf8:	02071693          	slli	a3,a4,0x20
 bfc:	01c6d713          	srli	a4,a3,0x1c
 c00:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c02:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c06:	00000717          	auipc	a4,0x0
 c0a:	3ea73d23          	sd	a0,1018(a4) # 1000 <freep>
      return (void *)(p + 1);
 c0e:	01078513          	addi	a0,a5,16
  }
}
 c12:	70e2                	ld	ra,56(sp)
 c14:	7442                	ld	s0,48(sp)
 c16:	7902                	ld	s2,32(sp)
 c18:	69e2                	ld	s3,24(sp)
 c1a:	6121                	addi	sp,sp,64
 c1c:	8082                	ret
 c1e:	74a2                	ld	s1,40(sp)
 c20:	6a42                	ld	s4,16(sp)
 c22:	6aa2                	ld	s5,8(sp)
 c24:	6b02                	ld	s6,0(sp)
 c26:	b7f5                	j	c12 <malloc+0xdc>
