
user/_fssubtest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <check>:
static char fs_buffer[8 * BSIZE];

static inline void
check(int ok, const char *why)
{
  if (!ok) {
       0:	c111                	beqz	a0,4 <check+0x4>
       2:	8082                	ret
{
       4:	1141                	addi	sp,sp,-16
       6:	e406                	sd	ra,8(sp)
       8:	e022                	sd	s0,0(sp)
       a:	0800                	addi	s0,sp,16
    fprintf(2, "TEST FAILURE: %s\n", why);
       c:	862e                	mv	a2,a1
       e:	00002597          	auipc	a1,0x2
      12:	7f258593          	addi	a1,a1,2034 # 2800 <malloc+0xf6>
      16:	4509                	li	a0,2
      18:	60c020ef          	jal	2624 <fprintf>
    exit(1);
      1c:	4505                	li	a0,1
      1e:	1ba020ef          	jal	21d8 <exit>

0000000000000022 <unavailable>:
}

#if defined(SYS_symlink) && defined(O_NOFOLLOW) && defined(T_SYMLINK)
static void
unavailable(const char *path)
{
      22:	1141                	addi	sp,sp,-16
      24:	e406                	sd	ra,8(sp)
      26:	e022                	sd	s0,0(sp)
      28:	0800                	addi	s0,sp,16
  int fd = open(path, O_RDONLY);
      2a:	4581                	li	a1,0
      2c:	1ec020ef          	jal	2218 <open>
  if (fd >= 0)
      30:	00055963          	bgez	a0,42 <unavailable+0x20>
  if (!ok) {
      34:	57fd                	li	a5,-1
      36:	00f51863          	bne	a0,a5,46 <unavailable+0x24>
    close(fd);
  check(fd == -1, "unresolvable link must fail");
}
      3a:	60a2                	ld	ra,8(sp)
      3c:	6402                	ld	s0,0(sp)
      3e:	0141                	addi	sp,sp,16
      40:	8082                	ret
    close(fd);
      42:	1be020ef          	jal	2200 <close>
    fprintf(2, "TEST FAILURE: %s\n", why);
      46:	00002617          	auipc	a2,0x2
      4a:	7d260613          	addi	a2,a2,2002 # 2818 <malloc+0x10e>
      4e:	00002597          	auipc	a1,0x2
      52:	7b258593          	addi	a1,a1,1970 # 2800 <malloc+0xf6>
      56:	4509                	li	a0,2
      58:	5cc020ef          	jal	2624 <fprintf>
    exit(1);
      5c:	4505                	li	a0,1
      5e:	17a020ef          	jal	21d8 <exit>

0000000000000062 <put>:
static void
put(const char *path, char byte)
{
      62:	7179                	addi	sp,sp,-48
      64:	f406                	sd	ra,40(sp)
      66:	f022                	sd	s0,32(sp)
      68:	ec26                	sd	s1,24(sp)
      6a:	1800                	addi	s0,sp,48
      6c:	fcb40fa3          	sb	a1,-33(s0)
  int fd = open(path, O_CREATE | O_WRONLY | O_TRUNC);
      70:	60100593          	li	a1,1537
      74:	1a4020ef          	jal	2218 <open>
  check(fd >= 0 && write(fd, &byte, 1) == 1 && close(fd) == 0, "create target");
      78:	02055063          	bgez	a0,98 <put+0x36>
    fprintf(2, "TEST FAILURE: %s\n", why);
      7c:	00002617          	auipc	a2,0x2
      80:	7bc60613          	addi	a2,a2,1980 # 2838 <malloc+0x12e>
      84:	00002597          	auipc	a1,0x2
      88:	77c58593          	addi	a1,a1,1916 # 2800 <malloc+0xf6>
      8c:	4509                	li	a0,2
      8e:	596020ef          	jal	2624 <fprintf>
    exit(1);
      92:	4505                	li	a0,1
      94:	144020ef          	jal	21d8 <exit>
      98:	84aa                	mv	s1,a0
      9a:	4605                	li	a2,1
      9c:	fdf40593          	addi	a1,s0,-33
      a0:	158020ef          	jal	21f8 <write>
      a4:	4785                	li	a5,1
      a6:	fcf51be3          	bne	a0,a5,7c <put+0x1a>
      aa:	8526                	mv	a0,s1
      ac:	154020ef          	jal	2200 <close>
  if (!ok) {
      b0:	f571                	bnez	a0,7c <put+0x1a>
}
      b2:	70a2                	ld	ra,40(sp)
      b4:	7402                	ld	s0,32(sp)
      b6:	64e2                	ld	s1,24(sp)
      b8:	6145                	addi	sp,sp,48
      ba:	8082                	ret

00000000000000bc <get>:
static void
get(const char *path, char byte)
{
      bc:	7179                	addi	sp,sp,-48
      be:	f406                	sd	ra,40(sp)
      c0:	f022                	sd	s0,32(sp)
      c2:	ec26                	sd	s1,24(sp)
      c4:	e84a                	sd	s2,16(sp)
      c6:	1800                	addi	s0,sp,48
      c8:	84ae                	mv	s1,a1
  char actual;
  int fd = open(path, O_RDONLY);
      ca:	4581                	li	a1,0
      cc:	14c020ef          	jal	2218 <open>
  check(fd >= 0 && read(fd, &actual, 1) == 1 && actual == byte &&
      d0:	02055063          	bgez	a0,f0 <get+0x34>
    fprintf(2, "TEST FAILURE: %s\n", why);
      d4:	00002617          	auipc	a2,0x2
      d8:	77460613          	addi	a2,a2,1908 # 2848 <malloc+0x13e>
      dc:	00002597          	auipc	a1,0x2
      e0:	72458593          	addi	a1,a1,1828 # 2800 <malloc+0xf6>
      e4:	4509                	li	a0,2
      e6:	53e020ef          	jal	2624 <fprintf>
    exit(1);
      ea:	4505                	li	a0,1
      ec:	0ec020ef          	jal	21d8 <exit>
      f0:	892a                	mv	s2,a0
      f2:	4605                	li	a2,1
      f4:	fdf40593          	addi	a1,s0,-33
      f8:	0f8020ef          	jal	21f0 <read>
      fc:	4785                	li	a5,1
      fe:	fcf51be3          	bne	a0,a5,d4 <get+0x18>
     102:	fdf44783          	lbu	a5,-33(s0)
     106:	fc9797e3          	bne	a5,s1,d4 <get+0x18>
          read(fd, &actual, 1) == 0 && close(fd) == 0,
     10a:	862a                	mv	a2,a0
     10c:	fdf40593          	addi	a1,s0,-33
     110:	854a                	mv	a0,s2
     112:	0de020ef          	jal	21f0 <read>
  check(fd >= 0 && read(fd, &actual, 1) == 1 && actual == byte &&
     116:	fd5d                	bnez	a0,d4 <get+0x18>
          read(fd, &actual, 1) == 0 && close(fd) == 0,
     118:	854a                	mv	a0,s2
     11a:	0e6020ef          	jal	2200 <close>
  if (!ok) {
     11e:	f95d                	bnez	a0,d4 <get+0x18>
        "follow correct target");
}
     120:	70a2                	ld	ra,40(sp)
     122:	7402                	ld	s0,32(sp)
     124:	64e2                	ld	s1,24(sp)
     126:	6942                	ld	s2,16(sp)
     128:	6145                	addi	sp,sp,48
     12a:	8082                	ret

000000000000012c <validation>:
  check(unlink("edge_link") == 0 && unlink("edge_target") == 0,
        "remove access-mode fixtures");
}
static void
validation(void)
{
     12c:	7165                	addi	sp,sp,-400
     12e:	e706                	sd	ra,392(sp)
     130:	e322                	sd	s0,384(sp)
     132:	fea6                	sd	s1,376(sp)
     134:	faca                	sd	s2,368(sp)
     136:	f6ce                	sd	s3,360(sp)
     138:	f2d2                	sd	s4,352(sp)
     13a:	eed6                	sd	s5,344(sp)
     13c:	eada                	sd	s6,336(sp)
     13e:	e6de                	sd	s7,328(sp)
     140:	0b00                	addi	s0,sp,400
  int fd;
  put("target", 'a');
     142:	06100593          	li	a1,97
     146:	00003517          	auipc	a0,0x3
     14a:	e4250513          	addi	a0,a0,-446 # 2f88 <malloc+0x87e>
     14e:	f15ff0ef          	jal	62 <put>
  check(symlink("missing", "existing") == 0, "existing dangling destination");
     152:	00002597          	auipc	a1,0x2
     156:	70e58593          	addi	a1,a1,1806 # 2860 <malloc+0x156>
     15a:	00002517          	auipc	a0,0x2
     15e:	71650513          	addi	a0,a0,1814 # 2870 <malloc+0x166>
     162:	12e020ef          	jal	2290 <symlink>
     166:	ed05                	bnez	a0,19e <validation+0x72>
  check(symlink("other", "existing") == -1 && symlink("other", "target") == -1,
     168:	00002597          	auipc	a1,0x2
     16c:	6f858593          	addi	a1,a1,1784 # 2860 <malloc+0x156>
     170:	00002517          	auipc	a0,0x2
     174:	72850513          	addi	a0,a0,1832 # 2898 <malloc+0x18e>
     178:	118020ef          	jal	2290 <symlink>
     17c:	57fd                	li	a5,-1
     17e:	02f50e63          	beq	a0,a5,1ba <validation+0x8e>
    fprintf(2, "TEST FAILURE: %s\n", why);
     182:	00002617          	auipc	a2,0x2
     186:	71e60613          	addi	a2,a2,1822 # 28a0 <malloc+0x196>
     18a:	00002597          	auipc	a1,0x2
     18e:	67658593          	addi	a1,a1,1654 # 2800 <malloc+0xf6>
     192:	4509                	li	a0,2
     194:	490020ef          	jal	2624 <fprintf>
    exit(1);
     198:	4505                	li	a0,1
     19a:	03e020ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     19e:	00002617          	auipc	a2,0x2
     1a2:	6da60613          	addi	a2,a2,1754 # 2878 <malloc+0x16e>
     1a6:	00002597          	auipc	a1,0x2
     1aa:	65a58593          	addi	a1,a1,1626 # 2800 <malloc+0xf6>
     1ae:	4509                	li	a0,2
     1b0:	474020ef          	jal	2624 <fprintf>
    exit(1);
     1b4:	4505                	li	a0,1
     1b6:	022020ef          	jal	21d8 <exit>
     1ba:	00003597          	auipc	a1,0x3
     1be:	dce58593          	addi	a1,a1,-562 # 2f88 <malloc+0x87e>
     1c2:	00002517          	auipc	a0,0x2
     1c6:	6d650513          	addi	a0,a0,1750 # 2898 <malloc+0x18e>
     1ca:	0c6020ef          	jal	2290 <symlink>
  if (!ok) {
     1ce:	57fd                	li	a5,-1
     1d0:	faf519e3          	bne	a0,a5,182 <validation+0x56>
        "reject existing destinations");
  check(symlink("", "empty") == -1 && symlink("target", "") == -1,
     1d4:	00002597          	auipc	a1,0x2
     1d8:	6ec58593          	addi	a1,a1,1772 # 28c0 <malloc+0x1b6>
     1dc:	00002517          	auipc	a0,0x2
     1e0:	76c50513          	addi	a0,a0,1900 # 2948 <malloc+0x23e>
     1e4:	0ac020ef          	jal	2290 <symlink>
     1e8:	57fd                	li	a5,-1
     1ea:	02f50063          	beq	a0,a5,20a <validation+0xde>
    fprintf(2, "TEST FAILURE: %s\n", why);
     1ee:	00002617          	auipc	a2,0x2
     1f2:	6da60613          	addi	a2,a2,1754 # 28c8 <malloc+0x1be>
     1f6:	00002597          	auipc	a1,0x2
     1fa:	60a58593          	addi	a1,a1,1546 # 2800 <malloc+0xf6>
     1fe:	4509                	li	a0,2
     200:	424020ef          	jal	2624 <fprintf>
    exit(1);
     204:	4505                	li	a0,1
     206:	7d3010ef          	jal	21d8 <exit>
     20a:	00002597          	auipc	a1,0x2
     20e:	73e58593          	addi	a1,a1,1854 # 2948 <malloc+0x23e>
     212:	00003517          	auipc	a0,0x3
     216:	d7650513          	addi	a0,a0,-650 # 2f88 <malloc+0x87e>
     21a:	076020ef          	jal	2290 <symlink>
  if (!ok) {
     21e:	57fd                	li	a5,-1
     220:	fcf517e3          	bne	a0,a5,1ee <validation+0xc2>
        "empty arguments");
  char longpath[MAXPATH + 1];
  memset(longpath, 'x', sizeof(longpath));
     224:	f2840493          	addi	s1,s0,-216
     228:	08100613          	li	a2,129
     22c:	07800593          	li	a1,120
     230:	8526                	mv	a0,s1
     232:	57d010ef          	jal	1fae <memset>
  longpath[MAXPATH - 1] = 0;
     236:	fa0403a3          	sb	zero,-89(s0)
  check(symlink(longpath, "long") == 0 && unlink("long") == 0,
     23a:	00002597          	auipc	a1,0x2
     23e:	69e58593          	addi	a1,a1,1694 # 28d8 <malloc+0x1ce>
     242:	8526                	mv	a0,s1
     244:	04c020ef          	jal	2290 <symlink>
     248:	cd19                	beqz	a0,266 <validation+0x13a>
    fprintf(2, "TEST FAILURE: %s\n", why);
     24a:	00002617          	auipc	a2,0x2
     24e:	69660613          	addi	a2,a2,1686 # 28e0 <malloc+0x1d6>
     252:	00002597          	auipc	a1,0x2
     256:	5ae58593          	addi	a1,a1,1454 # 2800 <malloc+0xf6>
     25a:	4509                	li	a0,2
     25c:	3c8020ef          	jal	2624 <fprintf>
    exit(1);
     260:	4505                	li	a0,1
     262:	777010ef          	jal	21d8 <exit>
     266:	00002517          	auipc	a0,0x2
     26a:	67250513          	addi	a0,a0,1650 # 28d8 <malloc+0x1ce>
     26e:	7bb010ef          	jal	2228 <unlink>
  if (!ok) {
     272:	fd61                	bnez	a0,24a <validation+0x11e>
        "maximum target length");
  longpath[MAXPATH - 1] = 'x';
     274:	07800793          	li	a5,120
     278:	faf403a3          	sb	a5,-89(s0)
  longpath[MAXPATH] = 0;
     27c:	fa040423          	sb	zero,-88(s0)
  check(symlink(longpath, "long") == -1, "oversized target");
     280:	00002597          	auipc	a1,0x2
     284:	65858593          	addi	a1,a1,1624 # 28d8 <malloc+0x1ce>
     288:	f2840513          	addi	a0,s0,-216
     28c:	004020ef          	jal	2290 <symlink>
     290:	57fd                	li	a5,-1
     292:	02f51563          	bne	a0,a5,2bc <validation+0x190>
  const char *valid_names[] = {"abcdefg", "a"};
     296:	00002797          	auipc	a5,0x2
     29a:	67a78793          	addi	a5,a5,1658 # 2910 <malloc+0x206>
     29e:	f0f43c23          	sd	a5,-232(s0)
     2a2:	00002797          	auipc	a5,0x2
     2a6:	67678793          	addi	a5,a5,1654 # 2918 <malloc+0x20e>
     2aa:	f2f43023          	sd	a5,-224(s0)
  for (int i = 0; i < 2; i++) {
     2ae:	f1840493          	addi	s1,s0,-232
     2b2:	f2840993          	addi	s3,s0,-216
    fd = open(valid_names[i], O_CREATE | O_WRONLY);
     2b6:	20100913          	li	s2,513
     2ba:	a02d                	j	2e4 <validation+0x1b8>
    fprintf(2, "TEST FAILURE: %s\n", why);
     2bc:	00002617          	auipc	a2,0x2
     2c0:	63c60613          	addi	a2,a2,1596 # 28f8 <malloc+0x1ee>
     2c4:	00002597          	auipc	a1,0x2
     2c8:	53c58593          	addi	a1,a1,1340 # 2800 <malloc+0xf6>
     2cc:	4509                	li	a0,2
     2ce:	356020ef          	jal	2624 <fprintf>
    exit(1);
     2d2:	4505                	li	a0,1
     2d4:	705010ef          	jal	21d8 <exit>
    check(fd >= 0 && close(fd) == 0, "create malformed-target control");
     2d8:	729010ef          	jal	2200 <close>
  if (!ok) {
     2dc:	e911                	bnez	a0,2f0 <validation+0x1c4>
  for (int i = 0; i < 2; i++) {
     2de:	04a1                	addi	s1,s1,8
     2e0:	03348663          	beq	s1,s3,30c <validation+0x1e0>
    fd = open(valid_names[i], O_CREATE | O_WRONLY);
     2e4:	85ca                	mv	a1,s2
     2e6:	6088                	ld	a0,0(s1)
     2e8:	731010ef          	jal	2218 <open>
    check(fd >= 0 && close(fd) == 0, "create malformed-target control");
     2ec:	fe0556e3          	bgez	a0,2d8 <validation+0x1ac>
    fprintf(2, "TEST FAILURE: %s\n", why);
     2f0:	00002617          	auipc	a2,0x2
     2f4:	63060613          	addi	a2,a2,1584 # 2920 <malloc+0x216>
     2f8:	00002597          	auipc	a1,0x2
     2fc:	50858593          	addi	a1,a1,1288 # 2800 <malloc+0xf6>
     300:	4509                	li	a0,2
     302:	322020ef          	jal	2624 <fprintf>
    exit(1);
     306:	4505                	li	a0,1
     308:	6d1010ef          	jal	21d8 <exit>
  }
  // Change valid stored targets into malformed ones through NOFOLLOW.
  const char *bad[] = {"abcdefg", "a\0bcdef", "\0abcdef"};
     30c:	00002797          	auipc	a5,0x2
     310:	60478793          	addi	a5,a5,1540 # 2910 <malloc+0x206>
     314:	f0f43023          	sd	a5,-256(s0)
     318:	00003797          	auipc	a5,0x3
     31c:	fd078793          	addi	a5,a5,-48 # 32e8 <malloc+0xbde>
     320:	f0f43423          	sd	a5,-248(s0)
     324:	00003797          	auipc	a5,0x3
     328:	fcc78793          	addi	a5,a5,-52 # 32f0 <malloc+0xbe6>
     32c:	f0f43823          	sd	a5,-240(s0)
  for (int i = 0; i < 3; i++) {
     330:	f0040993          	addi	s3,s0,-256
     334:	f1840b13          	addi	s6,s0,-232
    check(symlink("target", "edge_bad") == 0, "create malformed fixture");
     338:	00002917          	auipc	s2,0x2
     33c:	60890913          	addi	s2,s2,1544 # 2940 <malloc+0x236>
     340:	00003a97          	auipc	s5,0x3
     344:	c48a8a93          	addi	s5,s5,-952 # 2f88 <malloc+0x87e>
    fd = open("edge_bad", O_WRONLY | O_NOFOLLOW);
     348:	6a05                	lui	s4,0x1
     34a:	801a0a13          	addi	s4,s4,-2047 # 801 <main+0x47>
    check(fd >= 0 && write(fd, bad[i], 7) == 7 && close(fd) == 0,
     34e:	4b9d                	li	s7,7
     350:	a0a1                	j	398 <validation+0x26c>
    fprintf(2, "TEST FAILURE: %s\n", why);
     352:	00002617          	auipc	a2,0x2
     356:	5fe60613          	addi	a2,a2,1534 # 2950 <malloc+0x246>
     35a:	00002597          	auipc	a1,0x2
     35e:	4a658593          	addi	a1,a1,1190 # 2800 <malloc+0xf6>
     362:	4509                	li	a0,2
     364:	2c0020ef          	jal	2624 <fprintf>
    exit(1);
     368:	4505                	li	a0,1
     36a:	66f010ef          	jal	21d8 <exit>
     36e:	865e                	mv	a2,s7
     370:	0009b583          	ld	a1,0(s3)
     374:	685010ef          	jal	21f8 <write>
     378:	03751c63          	bne	a0,s7,3b0 <validation+0x284>
     37c:	8526                	mv	a0,s1
     37e:	683010ef          	jal	2200 <close>
  if (!ok) {
     382:	e51d                	bnez	a0,3b0 <validation+0x284>
          "replace stored target bytes");
    unavailable("edge_bad");
     384:	854a                	mv	a0,s2
     386:	c9dff0ef          	jal	22 <unavailable>
    check(unlink("edge_bad") == 0, "remove malformed fixture");
     38a:	854a                	mv	a0,s2
     38c:	69d010ef          	jal	2228 <unlink>
     390:	ed15                	bnez	a0,3cc <validation+0x2a0>
  for (int i = 0; i < 3; i++) {
     392:	09a1                	addi	s3,s3,8
     394:	053b0a63          	beq	s6,s3,3e8 <validation+0x2bc>
    check(symlink("target", "edge_bad") == 0, "create malformed fixture");
     398:	85ca                	mv	a1,s2
     39a:	8556                	mv	a0,s5
     39c:	6f5010ef          	jal	2290 <symlink>
     3a0:	f94d                	bnez	a0,352 <validation+0x226>
    fd = open("edge_bad", O_WRONLY | O_NOFOLLOW);
     3a2:	85d2                	mv	a1,s4
     3a4:	854a                	mv	a0,s2
     3a6:	673010ef          	jal	2218 <open>
     3aa:	84aa                	mv	s1,a0
    check(fd >= 0 && write(fd, bad[i], 7) == 7 && close(fd) == 0,
     3ac:	fc0551e3          	bgez	a0,36e <validation+0x242>
    fprintf(2, "TEST FAILURE: %s\n", why);
     3b0:	00002617          	auipc	a2,0x2
     3b4:	5c060613          	addi	a2,a2,1472 # 2970 <malloc+0x266>
     3b8:	00002597          	auipc	a1,0x2
     3bc:	44858593          	addi	a1,a1,1096 # 2800 <malloc+0xf6>
     3c0:	4509                	li	a0,2
     3c2:	262020ef          	jal	2624 <fprintf>
    exit(1);
     3c6:	4505                	li	a0,1
     3c8:	611010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     3cc:	00002617          	auipc	a2,0x2
     3d0:	5c460613          	addi	a2,a2,1476 # 2990 <malloc+0x286>
     3d4:	00002597          	auipc	a1,0x2
     3d8:	42c58593          	addi	a1,a1,1068 # 2800 <malloc+0xf6>
     3dc:	4509                	li	a0,2
     3de:	246020ef          	jal	2624 <fprintf>
    exit(1);
     3e2:	4505                	li	a0,1
     3e4:	5f5010ef          	jal	21d8 <exit>
  }
  check(symlink("target", "edge_bad") == 0, "create oversized fixture");
     3e8:	00002597          	auipc	a1,0x2
     3ec:	55858593          	addi	a1,a1,1368 # 2940 <malloc+0x236>
     3f0:	00003517          	auipc	a0,0x3
     3f4:	b9850513          	addi	a0,a0,-1128 # 2f88 <malloc+0x87e>
     3f8:	699010ef          	jal	2290 <symlink>
  if (!ok) {
     3fc:	e12d                	bnez	a0,45e <validation+0x332>
  memset(fs_buffer, 'x', MAXPATH + 1);
     3fe:	08100613          	li	a2,129
     402:	07800593          	li	a1,120
     406:	00004517          	auipc	a0,0x4
     40a:	c0a50513          	addi	a0,a0,-1014 # 4010 <fs_buffer>
     40e:	3a1010ef          	jal	1fae <memset>
  fs_buffer[0] = 'a';
     412:	00004797          	auipc	a5,0x4
     416:	bfe78793          	addi	a5,a5,-1026 # 4010 <fs_buffer>
     41a:	06100713          	li	a4,97
     41e:	00e78023          	sb	a4,0(a5)
  fs_buffer[1] = 0;
     422:	000780a3          	sb	zero,1(a5)
  fs_buffer[MAXPATH] = 0;
     426:	08078023          	sb	zero,128(a5)
  fd = open("edge_bad", O_WRONLY | O_NOFOLLOW);
     42a:	6585                	lui	a1,0x1
     42c:	80158593          	addi	a1,a1,-2047 # 801 <main+0x47>
     430:	00002517          	auipc	a0,0x2
     434:	51050513          	addi	a0,a0,1296 # 2940 <malloc+0x236>
     438:	5e1010ef          	jal	2218 <open>
     43c:	84aa                	mv	s1,a0
  check(fd >= 0 && write(fd, fs_buffer, MAXPATH + 1) == MAXPATH + 1 &&
     43e:	02055e63          	bgez	a0,47a <validation+0x34e>
    fprintf(2, "TEST FAILURE: %s\n", why);
     442:	00002617          	auipc	a2,0x2
     446:	58e60613          	addi	a2,a2,1422 # 29d0 <malloc+0x2c6>
     44a:	00002597          	auipc	a1,0x2
     44e:	3b658593          	addi	a1,a1,950 # 2800 <malloc+0xf6>
     452:	4509                	li	a0,2
     454:	1d0020ef          	jal	2624 <fprintf>
    exit(1);
     458:	4505                	li	a0,1
     45a:	57f010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     45e:	00002617          	auipc	a2,0x2
     462:	55260613          	addi	a2,a2,1362 # 29b0 <malloc+0x2a6>
     466:	00002597          	auipc	a1,0x2
     46a:	39a58593          	addi	a1,a1,922 # 2800 <malloc+0xf6>
     46e:	4509                	li	a0,2
     470:	1b4020ef          	jal	2624 <fprintf>
    exit(1);
     474:	4505                	li	a0,1
     476:	563010ef          	jal	21d8 <exit>
     47a:	08100613          	li	a2,129
     47e:	00004597          	auipc	a1,0x4
     482:	b9258593          	addi	a1,a1,-1134 # 4010 <fs_buffer>
     486:	573010ef          	jal	21f8 <write>
     48a:	08100793          	li	a5,129
     48e:	faf51ae3          	bne	a0,a5,442 <validation+0x316>
          close(fd) == 0,
     492:	8526                	mv	a0,s1
     494:	56d010ef          	jal	2200 <close>
  if (!ok) {
     498:	f54d                	bnez	a0,442 <validation+0x316>
        "extend stored target beyond MAXPATH");
  unavailable("edge_bad");
     49a:	00002517          	auipc	a0,0x2
     49e:	4a650513          	addi	a0,a0,1190 # 2940 <malloc+0x236>
     4a2:	b81ff0ef          	jal	22 <unavailable>
  check(unlink("edge_bad") == 0, "remove oversized fixture");
     4a6:	00002517          	auipc	a0,0x2
     4aa:	49a50513          	addi	a0,a0,1178 # 2940 <malloc+0x236>
     4ae:	57b010ef          	jal	2228 <unlink>
     4b2:	ed31                	bnez	a0,50e <validation+0x3e2>
  for (int i = 0; i < 2; i++)
    check(unlink(valid_names[i]) == 0, "remove malformed-target control");
     4b4:	00002517          	auipc	a0,0x2
     4b8:	45c50513          	addi	a0,a0,1116 # 2910 <malloc+0x206>
     4bc:	56d010ef          	jal	2228 <unlink>
     4c0:	e52d                	bnez	a0,52a <validation+0x3fe>
     4c2:	00002517          	auipc	a0,0x2
     4c6:	45650513          	addi	a0,a0,1110 # 2918 <malloc+0x20e>
     4ca:	55f010ef          	jal	2228 <unlink>
     4ce:	ed31                	bnez	a0,52a <validation+0x3fe>

  check(mkdir("edge_dir") == 0, "create expansion directory");
     4d0:	00002517          	auipc	a0,0x2
     4d4:	56850513          	addi	a0,a0,1384 # 2a38 <malloc+0x32e>
     4d8:	569010ef          	jal	2240 <mkdir>
     4dc:	e52d                	bnez	a0,546 <validation+0x41a>
  fd = open("edge_dir/t", O_CREATE | O_WRONLY);
     4de:	20100593          	li	a1,513
     4e2:	00002517          	auipc	a0,0x2
     4e6:	58650513          	addi	a0,a0,1414 # 2a68 <malloc+0x35e>
     4ea:	52f010ef          	jal	2218 <open>
  check(fd >= 0 && close(fd) == 0, "create expansion target");
     4ee:	06055a63          	bgez	a0,562 <validation+0x436>
    fprintf(2, "TEST FAILURE: %s\n", why);
     4f2:	00002617          	auipc	a2,0x2
     4f6:	58660613          	addi	a2,a2,1414 # 2a78 <malloc+0x36e>
     4fa:	00002597          	auipc	a1,0x2
     4fe:	30658593          	addi	a1,a1,774 # 2800 <malloc+0xf6>
     502:	4509                	li	a0,2
     504:	120020ef          	jal	2624 <fprintf>
    exit(1);
     508:	4505                	li	a0,1
     50a:	4cf010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     50e:	00002617          	auipc	a2,0x2
     512:	4ea60613          	addi	a2,a2,1258 # 29f8 <malloc+0x2ee>
     516:	00002597          	auipc	a1,0x2
     51a:	2ea58593          	addi	a1,a1,746 # 2800 <malloc+0xf6>
     51e:	4509                	li	a0,2
     520:	104020ef          	jal	2624 <fprintf>
    exit(1);
     524:	4505                	li	a0,1
     526:	4b3010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     52a:	00002617          	auipc	a2,0x2
     52e:	4ee60613          	addi	a2,a2,1262 # 2a18 <malloc+0x30e>
     532:	00002597          	auipc	a1,0x2
     536:	2ce58593          	addi	a1,a1,718 # 2800 <malloc+0xf6>
     53a:	4509                	li	a0,2
     53c:	0e8020ef          	jal	2624 <fprintf>
    exit(1);
     540:	4505                	li	a0,1
     542:	497010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     546:	00002617          	auipc	a2,0x2
     54a:	50260613          	addi	a2,a2,1282 # 2a48 <malloc+0x33e>
     54e:	00002597          	auipc	a1,0x2
     552:	2b258593          	addi	a1,a1,690 # 2800 <malloc+0xf6>
     556:	4509                	li	a0,2
     558:	0cc020ef          	jal	2624 <fprintf>
    exit(1);
     55c:	4505                	li	a0,1
     55e:	47b010ef          	jal	21d8 <exit>
     562:	49f010ef          	jal	2200 <close>
  if (!ok) {
     566:	f551                	bnez	a0,4f2 <validation+0x3c6>
  char target[MAXPATH];
  memset(target, '/', sizeof(target));
     568:	e8040493          	addi	s1,s0,-384
     56c:	08000613          	li	a2,128
     570:	02f00593          	li	a1,47
     574:	8526                	mv	a0,s1
     576:	239010ef          	jal	1fae <memset>
  target[0] = '.';
     57a:	02e00793          	li	a5,46
     57e:	e8f40023          	sb	a5,-384(s0)
  target[MAXPATH - 2] = 't';
     582:	07400793          	li	a5,116
     586:	eef40f23          	sb	a5,-258(s0)
  target[MAXPATH - 1] = 0;
     58a:	ee040fa3          	sb	zero,-257(s0)
  check(symlink(target, "edge_dir/long") == 0,
     58e:	00002597          	auipc	a1,0x2
     592:	50258593          	addi	a1,a1,1282 # 2a90 <malloc+0x386>
     596:	8526                	mv	a0,s1
     598:	4f9010ef          	jal	2290 <symlink>
     59c:	ed05                	bnez	a0,5d4 <validation+0x4a8>
        "create link with a maximum-length relative target");
  unavailable("edge_dir/long");
     59e:	00002517          	auipc	a0,0x2
     5a2:	4f250513          	addi	a0,a0,1266 # 2a90 <malloc+0x386>
     5a6:	a7dff0ef          	jal	22 <unavailable>
  check(unlink("edge_dir/long") == 0 && unlink("edge_dir/t") == 0 &&
     5aa:	00002517          	auipc	a0,0x2
     5ae:	4e650513          	addi	a0,a0,1254 # 2a90 <malloc+0x386>
     5b2:	477010ef          	jal	2228 <unlink>
     5b6:	cd0d                	beqz	a0,5f0 <validation+0x4c4>
    fprintf(2, "TEST FAILURE: %s\n", why);
     5b8:	00002617          	auipc	a2,0x2
     5bc:	52060613          	addi	a2,a2,1312 # 2ad8 <malloc+0x3ce>
     5c0:	00002597          	auipc	a1,0x2
     5c4:	24058593          	addi	a1,a1,576 # 2800 <malloc+0xf6>
     5c8:	4509                	li	a0,2
     5ca:	05a020ef          	jal	2624 <fprintf>
    exit(1);
     5ce:	4505                	li	a0,1
     5d0:	409010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     5d4:	00002617          	auipc	a2,0x2
     5d8:	4cc60613          	addi	a2,a2,1228 # 2aa0 <malloc+0x396>
     5dc:	00002597          	auipc	a1,0x2
     5e0:	22458593          	addi	a1,a1,548 # 2800 <malloc+0xf6>
     5e4:	4509                	li	a0,2
     5e6:	03e020ef          	jal	2624 <fprintf>
    exit(1);
     5ea:	4505                	li	a0,1
     5ec:	3ed010ef          	jal	21d8 <exit>
     5f0:	00002517          	auipc	a0,0x2
     5f4:	47850513          	addi	a0,a0,1144 # 2a68 <malloc+0x35e>
     5f8:	431010ef          	jal	2228 <unlink>
     5fc:	fd55                	bnez	a0,5b8 <validation+0x48c>
          unlink("edge_dir") == 0,
     5fe:	00002517          	auipc	a0,0x2
     602:	43a50513          	addi	a0,a0,1082 # 2a38 <malloc+0x32e>
     606:	423010ef          	jal	2228 <unlink>
  if (!ok) {
     60a:	f55d                	bnez	a0,5b8 <validation+0x48c>
        "remove expansion fixtures");

  int gate[2];
  check(pipe(gate) == 0, "create concurrent-start pipe");
     60c:	e7840513          	addi	a0,s0,-392
     610:	3d9010ef          	jal	21e8 <pipe>
     614:	4491                	li	s1,4
     616:	e531                	bnez	a0,662 <validation+0x536>
  for (int i = 0; i < 4; i++) {
    int pid = fork();
     618:	3b9010ef          	jal	21d0 <fork>
     61c:	06054163          	bltz	a0,67e <validation+0x552>
    check(pid >= 0, "fork concurrent creator");
    if (pid == 0) {
     620:	cd2d                	beqz	a0,69a <validation+0x56e>
  for (int i = 0; i < 4; i++) {
     622:	34fd                	addiw	s1,s1,-1
     624:	f8f5                	bnez	s1,618 <validation+0x4ec>
      close(gate[0]);
      int result = symlink("target", "edge_race");
      exit(result == 0 ? 0 : result == -1 ? 1 : 2);
    }
  }
  close(gate[0]);
     626:	e7842503          	lw	a0,-392(s0)
     62a:	3d7010ef          	jal	2200 <close>
  check(write(gate[1], "go!!", 4) == 4 && close(gate[1]) == 0,
     62e:	4611                	li	a2,4
     630:	00002597          	auipc	a1,0x2
     634:	51058593          	addi	a1,a1,1296 # 2b40 <malloc+0x436>
     638:	e7c42503          	lw	a0,-388(s0)
     63c:	3bd010ef          	jal	21f8 <write>
     640:	4791                	li	a5,4
     642:	0af50563          	beq	a0,a5,6ec <validation+0x5c0>
    fprintf(2, "TEST FAILURE: %s\n", why);
     646:	00002617          	auipc	a2,0x2
     64a:	50260613          	addi	a2,a2,1282 # 2b48 <malloc+0x43e>
     64e:	00002597          	auipc	a1,0x2
     652:	1b258593          	addi	a1,a1,434 # 2800 <malloc+0xf6>
     656:	4509                	li	a0,2
     658:	7cd010ef          	jal	2624 <fprintf>
    exit(1);
     65c:	4505                	li	a0,1
     65e:	37b010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     662:	00002617          	auipc	a2,0x2
     666:	49660613          	addi	a2,a2,1174 # 2af8 <malloc+0x3ee>
     66a:	00002597          	auipc	a1,0x2
     66e:	19658593          	addi	a1,a1,406 # 2800 <malloc+0xf6>
     672:	4509                	li	a0,2
     674:	7b1010ef          	jal	2624 <fprintf>
    exit(1);
     678:	4505                	li	a0,1
     67a:	35f010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     67e:	00002617          	auipc	a2,0x2
     682:	49a60613          	addi	a2,a2,1178 # 2b18 <malloc+0x40e>
     686:	00002597          	auipc	a1,0x2
     68a:	17a58593          	addi	a1,a1,378 # 2800 <malloc+0xf6>
     68e:	4509                	li	a0,2
     690:	795010ef          	jal	2624 <fprintf>
    exit(1);
     694:	4505                	li	a0,1
     696:	343010ef          	jal	21d8 <exit>
      close(gate[1]);
     69a:	e7c42503          	lw	a0,-388(s0)
     69e:	363010ef          	jal	2200 <close>
      if (read(gate[0], &ready, 1) != 1)
     6a2:	4605                	li	a2,1
     6a4:	e7440593          	addi	a1,s0,-396
     6a8:	e7842503          	lw	a0,-392(s0)
     6ac:	345010ef          	jal	21f0 <read>
     6b0:	84aa                	mv	s1,a0
     6b2:	4785                	li	a5,1
     6b4:	00f50563          	beq	a0,a5,6be <validation+0x592>
        exit(2);
     6b8:	4509                	li	a0,2
     6ba:	31f010ef          	jal	21d8 <exit>
      close(gate[0]);
     6be:	e7842503          	lw	a0,-392(s0)
     6c2:	33f010ef          	jal	2200 <close>
      int result = symlink("target", "edge_race");
     6c6:	00002597          	auipc	a1,0x2
     6ca:	46a58593          	addi	a1,a1,1130 # 2b30 <malloc+0x426>
     6ce:	00003517          	auipc	a0,0x3
     6d2:	8ba50513          	addi	a0,a0,-1862 # 2f88 <malloc+0x87e>
     6d6:	3bb010ef          	jal	2290 <symlink>
      exit(result == 0 ? 0 : result == -1 ? 1 : 2);
     6da:	c509                	beqz	a0,6e4 <validation+0x5b8>
     6dc:	57fd                	li	a5,-1
     6de:	00f50563          	beq	a0,a5,6e8 <validation+0x5bc>
     6e2:	4509                	li	a0,2
     6e4:	2f5010ef          	jal	21d8 <exit>
     6e8:	8526                	mv	a0,s1
     6ea:	bfed                	j	6e4 <validation+0x5b8>
  check(write(gate[1], "go!!", 4) == 4 && close(gate[1]) == 0,
     6ec:	e7c42503          	lw	a0,-388(s0)
     6f0:	311010ef          	jal	2200 <close>
     6f4:	892a                	mv	s2,a0
  if (!ok) {
     6f6:	4491                	li	s1,4
        "release concurrent creators");
  int winners = 0;
  for (int i = 0; i < 4; i++) {
    int status;
    check(wait(&status) > 0 && (status == 0 || status == 1),
     6f8:	e7440993          	addi	s3,s0,-396
     6fc:	4a05                	li	s4,1
     6fe:	c901                	beqz	a0,70e <validation+0x5e2>
     700:	b799                	j	646 <validation+0x51a>
          "concurrent creation returns success or failure");
    winners += status == 0;
     702:	0017b793          	seqz	a5,a5
     706:	0127893b          	addw	s2,a5,s2
  for (int i = 0; i < 4; i++) {
     70a:	34fd                	addiw	s1,s1,-1
     70c:	c885                	beqz	s1,73c <validation+0x610>
    check(wait(&status) > 0 && (status == 0 || status == 1),
     70e:	854e                	mv	a0,s3
     710:	2d1010ef          	jal	21e0 <wait>
     714:	00a05663          	blez	a0,720 <validation+0x5f4>
     718:	e7442783          	lw	a5,-396(s0)
     71c:	fefa73e3          	bgeu	s4,a5,702 <validation+0x5d6>
    fprintf(2, "TEST FAILURE: %s\n", why);
     720:	00002617          	auipc	a2,0x2
     724:	44860613          	addi	a2,a2,1096 # 2b68 <malloc+0x45e>
     728:	00002597          	auipc	a1,0x2
     72c:	0d858593          	addi	a1,a1,216 # 2800 <malloc+0xf6>
     730:	4509                	li	a0,2
     732:	6f3010ef          	jal	2624 <fprintf>
    exit(1);
     736:	4505                	li	a0,1
     738:	2a1010ef          	jal	21d8 <exit>
  }
  check(winners == 1 && unlink("edge_race") == 0,
     73c:	4785                	li	a5,1
     73e:	02f90063          	beq	s2,a5,75e <validation+0x632>
    fprintf(2, "TEST FAILURE: %s\n", why);
     742:	00002617          	auipc	a2,0x2
     746:	45660613          	addi	a2,a2,1110 # 2b98 <malloc+0x48e>
     74a:	00002597          	auipc	a1,0x2
     74e:	0b658593          	addi	a1,a1,182 # 2800 <malloc+0xf6>
     752:	4509                	li	a0,2
     754:	6d1010ef          	jal	2624 <fprintf>
    exit(1);
     758:	4505                	li	a0,1
     75a:	27f010ef          	jal	21d8 <exit>
     75e:	00002517          	auipc	a0,0x2
     762:	3d250513          	addi	a0,a0,978 # 2b30 <malloc+0x426>
     766:	2c3010ef          	jal	2228 <unlink>
  if (!ok) {
     76a:	fd61                	bnez	a0,742 <validation+0x616>
        "exactly one creator owns the destination");
  check(unlink("existing") == 0 && unlink("target") == 0, "validation cleanup");
     76c:	00002517          	auipc	a0,0x2
     770:	0f450513          	addi	a0,a0,244 # 2860 <malloc+0x156>
     774:	2b5010ef          	jal	2228 <unlink>
     778:	cd19                	beqz	a0,796 <validation+0x66a>
    fprintf(2, "TEST FAILURE: %s\n", why);
     77a:	00002617          	auipc	a2,0x2
     77e:	44e60613          	addi	a2,a2,1102 # 2bc8 <malloc+0x4be>
     782:	00002597          	auipc	a1,0x2
     786:	07e58593          	addi	a1,a1,126 # 2800 <malloc+0xf6>
     78a:	4509                	li	a0,2
     78c:	699010ef          	jal	2624 <fprintf>
    exit(1);
     790:	4505                	li	a0,1
     792:	247010ef          	jal	21d8 <exit>
     796:	00002517          	auipc	a0,0x2
     79a:	7f250513          	addi	a0,a0,2034 # 2f88 <malloc+0x87e>
     79e:	28b010ef          	jal	2228 <unlink>
  if (!ok) {
     7a2:	fd61                	bnez	a0,77a <validation+0x64e>
}
     7a4:	60ba                	ld	ra,392(sp)
     7a6:	641a                	ld	s0,384(sp)
     7a8:	74f6                	ld	s1,376(sp)
     7aa:	7956                	ld	s2,368(sp)
     7ac:	79b6                	ld	s3,360(sp)
     7ae:	7a16                	ld	s4,352(sp)
     7b0:	6af6                	ld	s5,344(sp)
     7b2:	6b56                	ld	s6,336(sp)
     7b4:	6bb6                	ld	s7,328(sp)
     7b6:	6159                	addi	sp,sp,400
     7b8:	8082                	ret

00000000000007ba <main>:
#endif

int
main(int argc, char **argv)
{
     7ba:	712d                	addi	sp,sp,-288
     7bc:	ee06                	sd	ra,280(sp)
     7be:	ea22                	sd	s0,272(sp)
     7c0:	1200                	addi	s0,sp,288
     7c2:	4785                	li	a5,1
     7c4:	08a7d063          	bge	a5,a0,844 <main+0x8a>
     7c8:	e626                	sd	s1,264(sp)
     7ca:	e24a                	sd	s2,256(sp)
     7cc:	fdce                	sd	s3,248(sp)
     7ce:	f9d2                	sd	s4,240(sp)
     7d0:	f5d6                	sd	s5,232(sp)
     7d2:	f1da                	sd	s6,224(sp)
     7d4:	edde                	sd	s7,216(sp)
     7d6:	e9e2                	sd	s8,208(sp)
     7d8:	e5e6                	sd	s9,200(sp)
     7da:	892a                	mv	s2,a0
     7dc:	84ae                	mv	s1,a1
  check(argc >= 2, "subtest mode required");
  if (!strcmp(argv[1], "data")) {
     7de:	00002597          	auipc	a1,0x2
     7e2:	46a58593          	addi	a1,a1,1130 # 2c48 <malloc+0x53e>
     7e6:	6488                	ld	a0,8(s1)
     7e8:	76a010ef          	jal	1f52 <strcmp>
     7ec:	3c051b63          	bnez	a0,bc2 <main+0x408>
    check(argc == 3, "block count required");
     7f0:	ffd90513          	addi	a0,s2,-3
     7f4:	00002597          	auipc	a1,0x2
     7f8:	40458593          	addi	a1,a1,1028 # 2bf8 <malloc+0x4ee>
     7fc:	00153513          	seqz	a0,a0
     800:	801ff0ef          	jal	0 <check>
    data_test(atoi(argv[2]));
     804:	6888                	ld	a0,16(s1)
     806:	0ad010ef          	jal	20b2 <atoi>
     80a:	8aaa                	mv	s5,a0
}

static inline void
makefile(const char *name, uint blocks, uint seed)
{
  unlink(name);
     80c:	00002517          	auipc	a0,0x2
     810:	40450513          	addi	a0,a0,1028 # 2c10 <malloc+0x506>
     814:	215010ef          	jal	2228 <unlink>
  int fd = open(name, O_CREATE | O_WRONLY | O_TRUNC);
     818:	60100593          	li	a1,1537
     81c:	00002517          	auipc	a0,0x2
     820:	3f450513          	addi	a0,a0,1012 # 2c10 <malloc+0x506>
     824:	1f5010ef          	jal	2218 <open>
     828:	8baa                	mv	s7,a0
  if (!ok) {
     82a:	04054663          	bltz	a0,876 <main+0xbc>
  makefile("fst_part.tmp", blocks, 7);
     82e:	8b56                	mv	s6,s5
  check(fd >= 0, "create test file");
  for (uint first = 0; first < blocks;) {
     830:	4981                	li	s3,0
     832:	140a8263          	beqz	s5,976 <main+0x1bc>
    uint n = blocks - first;
    if (n > 8)
     836:	4c21                	li	s8,8
      n = 8;
    for (uint b = 0; b < n; b++)
      for (uint j = 0; j < BSIZE; j++)
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     838:	00003497          	auipc	s1,0x3
     83c:	7d848493          	addi	s1,s1,2008 # 4010 <fs_buffer>
    return seed;
     840:	491d                	li	s2,7
     842:	a0c5                	j	922 <main+0x168>
     844:	e626                	sd	s1,264(sp)
     846:	e24a                	sd	s2,256(sp)
     848:	fdce                	sd	s3,248(sp)
     84a:	f9d2                	sd	s4,240(sp)
     84c:	f5d6                	sd	s5,232(sp)
     84e:	f1da                	sd	s6,224(sp)
     850:	edde                	sd	s7,216(sp)
     852:	e9e2                	sd	s8,208(sp)
     854:	e5e6                	sd	s9,200(sp)
     856:	e1ea                	sd	s10,192(sp)
     858:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     85a:	00002617          	auipc	a2,0x2
     85e:	38660613          	addi	a2,a2,902 # 2be0 <malloc+0x4d6>
     862:	00002597          	auipc	a1,0x2
     866:	f9e58593          	addi	a1,a1,-98 # 2800 <malloc+0xf6>
     86a:	4509                	li	a0,2
     86c:	5b9010ef          	jal	2624 <fprintf>
    exit(1);
     870:	4505                	li	a0,1
     872:	167010ef          	jal	21d8 <exit>
     876:	e1ea                	sd	s10,192(sp)
     878:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     87a:	00002617          	auipc	a2,0x2
     87e:	3a660613          	addi	a2,a2,934 # 2c20 <malloc+0x516>
     882:	00002597          	auipc	a1,0x2
     886:	f7e58593          	addi	a1,a1,-130 # 2800 <malloc+0xf6>
     88a:	4509                	li	a0,2
     88c:	599010ef          	jal	2624 <fprintf>
    exit(1);
     890:	4505                	li	a0,1
     892:	147010ef          	jal	21d8 <exit>
      for (uint j = 0; j < BSIZE; j++)
     896:	26c5                	addiw	a3,a3,17
     898:	0ff6f693          	zext.b	a3,a3
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     89c:	00b707bb          	addw	a5,a4,a1
  if (byte < 4)
     8a0:	04e57463          	bgeu	a0,a4,8e8 <main+0x12e>
  if (byte == 4)
     8a4:	01071463          	bne	a4,a6,8ac <main+0xf2>
     8a8:	6740106f          	j	1f1c <main+0x1762>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     8ac:	1782                	slli	a5,a5,0x20
     8ae:	9381                	srli	a5,a5,0x20
     8b0:	97a6                	add	a5,a5,s1
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
     8b2:	0116c633          	xor	a2,a3,a7
     8b6:	00664633          	xor	a2,a2,t1
     8ba:	fcb64613          	xori	a2,a2,-53
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     8be:	00c78023          	sb	a2,0(a5)
      for (uint j = 0; j < BSIZE; j++)
     8c2:	2705                	addiw	a4,a4,1
     8c4:	fdc719e3          	bne	a4,t3,896 <main+0xdc>
    for (uint b = 0; b < n; b++)
     8c8:	2f05                	addiw	t5,t5,1
     8ca:	f838889b          	addiw	a7,a7,-125
     8ce:	0ff8f893          	zext.b	a7,a7
     8d2:	4005859b          	addiw	a1,a1,1024
     8d6:	034f7963          	bgeu	t5,s4,908 <main+0x14e>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     8da:	01e98ebb          	addw	t4,s3,t5
     8de:	4681                	li	a3,0
      for (uint j = 0; j < BSIZE; j++)
     8e0:	4701                	li	a4,0
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
     8e2:	008ed31b          	srliw	t1,t4,0x8
     8e6:	bf5d                	j	89c <main+0xe2>
    return (block >> (8 * byte)) & 255;
     8e8:	0037161b          	slliw	a2,a4,0x3
     8ec:	00ced63b          	srlw	a2,t4,a2
     8f0:	0ff67613          	zext.b	a2,a2
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     8f4:	1782                	slli	a5,a5,0x20
     8f6:	9381                	srli	a5,a5,0x20
     8f8:	97a6                	add	a5,a5,s1
     8fa:	00c78023          	sb	a2,0(a5)
      for (uint j = 0; j < BSIZE; j++)
     8fe:	2705                	addiw	a4,a4,1
     900:	26c5                	addiw	a3,a3,17
     902:	0ff6f693          	zext.b	a3,a3
     906:	bf59                	j	89c <main+0xe2>
    check(write(fd, fs_buffer, n * BSIZE) == n * BSIZE, "write full test data");
     908:	00aa161b          	slliw	a2,s4,0xa
     90c:	8cb2                	mv	s9,a2
     90e:	85a6                	mv	a1,s1
     910:	855e                	mv	a0,s7
     912:	0e7010ef          	jal	21f8 <write>
  if (!ok) {
     916:	04ac9063          	bne	s9,a0,956 <main+0x19c>
    first += n;
     91a:	014989bb          	addw	s3,s3,s4
  for (uint first = 0; first < blocks;) {
     91e:	0569fc63          	bgeu	s3,s6,976 <main+0x1bc>
    uint n = blocks - first;
     922:	413a87bb          	subw	a5,s5,s3
     926:	8a3e                	mv	s4,a5
    if (n > 8)
     928:	00fc7363          	bgeu	s8,a5,92e <main+0x174>
     92c:	4a21                	li	s4,8
     92e:	2a01                	sext.w	s4,s4
    for (uint b = 0; b < n; b++)
     930:	fd3b0ce3          	beq	s6,s3,908 <main+0x14e>
     934:	0069989b          	slliw	a7,s3,0x6
     938:	411988bb          	subw	a7,s3,a7
     93c:	0018989b          	slliw	a7,a7,0x1
     940:	013888bb          	addw	a7,a7,s3
     944:	0ff8f893          	zext.b	a7,a7
     948:	4581                	li	a1,0
     94a:	4f01                	li	t5,0
  if (byte < 4)
     94c:	450d                	li	a0,3
  if (byte == 4)
     94e:	4811                	li	a6,4
      for (uint j = 0; j < BSIZE; j++)
     950:	40000e13          	li	t3,1024
     954:	b759                	j	8da <main+0x120>
     956:	e1ea                	sd	s10,192(sp)
     958:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     95a:	00002617          	auipc	a2,0x2
     95e:	2de60613          	addi	a2,a2,734 # 2c38 <malloc+0x52e>
     962:	00002597          	auipc	a1,0x2
     966:	e9e58593          	addi	a1,a1,-354 # 2800 <malloc+0xf6>
     96a:	4509                	li	a0,2
     96c:	4b9010ef          	jal	2624 <fprintf>
    exit(1);
     970:	4505                	li	a0,1
     972:	067010ef          	jal	21d8 <exit>
  }
  check(close(fd) == 0, "close written file");
     976:	855e                	mv	a0,s7
     978:	089010ef          	jal	2200 <close>
  if (!ok) {
     97c:	e131                	bnez	a0,9c0 <main+0x206>

static inline void
verify(const char *name, uint blocks, uint seed, const struct patch *patches,
       int np)
{
  int fd = open(name, O_RDONLY);
     97e:	4581                	li	a1,0
     980:	00002517          	auipc	a0,0x2
     984:	29050513          	addi	a0,a0,656 # 2c10 <malloc+0x506>
     988:	091010ef          	jal	2218 <open>
     98c:	8a2a                	mv	s4,a0
  if (!ok) {
     98e:	04054963          	bltz	a0,9e0 <main+0x226>
  check(fstat(fd, &st) == 0 && st.size == (uint64)blocks * BSIZE,
     992:	f5040593          	addi	a1,s0,-176
     996:	09b010ef          	jal	2230 <fstat>
     99a:	e13d                	bnez	a0,a00 <main+0x246>
     99c:	020a9713          	slli	a4,s5,0x20
     9a0:	01675793          	srli	a5,a4,0x16
  if (!ok) {
     9a4:	f6043703          	ld	a4,-160(s0)
     9a8:	04f71c63          	bne	a4,a5,a00 <main+0x246>
  for (uint first = 0; first < blocks;) {
     9ac:	4981                	li	s3,0
     9ae:	180b0263          	beqz	s6,b32 <main+0x378>
    if (n > 8)
     9b2:	4c21                	li	s8,8
    check(read(fd, fs_buffer, n * BSIZE) == n * BSIZE, "read full test data");
     9b4:	00003497          	auipc	s1,0x3
     9b8:	65c48493          	addi	s1,s1,1628 # 4010 <fs_buffer>
  if (byte == 4)
     9bc:	4911                	li	s2,4
     9be:	a235                	j	aea <main+0x330>
     9c0:	e1ea                	sd	s10,192(sp)
     9c2:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     9c4:	00002617          	auipc	a2,0x2
     9c8:	28c60613          	addi	a2,a2,652 # 2c50 <malloc+0x546>
     9cc:	00002597          	auipc	a1,0x2
     9d0:	e3458593          	addi	a1,a1,-460 # 2800 <malloc+0xf6>
     9d4:	4509                	li	a0,2
     9d6:	44f010ef          	jal	2624 <fprintf>
    exit(1);
     9da:	4505                	li	a0,1
     9dc:	7fc010ef          	jal	21d8 <exit>
     9e0:	e1ea                	sd	s10,192(sp)
     9e2:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     9e4:	00002617          	auipc	a2,0x2
     9e8:	28460613          	addi	a2,a2,644 # 2c68 <malloc+0x55e>
     9ec:	00002597          	auipc	a1,0x2
     9f0:	e1458593          	addi	a1,a1,-492 # 2800 <malloc+0xf6>
     9f4:	4509                	li	a0,2
     9f6:	42f010ef          	jal	2624 <fprintf>
    exit(1);
     9fa:	4505                	li	a0,1
     9fc:	7dc010ef          	jal	21d8 <exit>
     a00:	e1ea                	sd	s10,192(sp)
     a02:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     a04:	00002617          	auipc	a2,0x2
     a08:	27c60613          	addi	a2,a2,636 # 2c80 <malloc+0x576>
     a0c:	00002597          	auipc	a1,0x2
     a10:	df458593          	addi	a1,a1,-524 # 2800 <malloc+0xf6>
     a14:	4509                	li	a0,2
     a16:	40f010ef          	jal	2624 <fprintf>
    exit(1);
     a1a:	4505                	li	a0,1
     a1c:	7bc010ef          	jal	21d8 <exit>
     a20:	e1ea                	sd	s10,192(sp)
     a22:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     a24:	00002617          	auipc	a2,0x2
     a28:	26c60613          	addi	a2,a2,620 # 2c90 <malloc+0x586>
     a2c:	00002597          	auipc	a1,0x2
     a30:	dd458593          	addi	a1,a1,-556 # 2800 <malloc+0xf6>
     a34:	4509                	li	a0,2
     a36:	3ef010ef          	jal	2624 <fprintf>
    exit(1);
     a3a:	4505                	li	a0,1
     a3c:	79c010ef          	jal	21d8 <exit>
      for (uint j = 0; j < BSIZE; j++) {
     a40:	2745                	addiw	a4,a4,17
     a42:	0ff77713          	zext.b	a4,a4
  if (byte < 4)
     a46:	04f57a63          	bgeu	a0,a5,a9a <main+0x2e0>
  if (byte == 4)
     a4a:	01279463          	bne	a5,s2,a52 <main+0x298>
     a4e:	4c80106f          	j	1f16 <main+0x175c>
        check((uchar)fs_buffer[b * BSIZE + j] == want, "file contents differ");
     a52:	00b7863b          	addw	a2,a5,a1
     a56:	1602                	slli	a2,a2,0x20
     a58:	9201                	srli	a2,a2,0x20
     a5a:	9626                	add	a2,a2,s1
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
     a5c:	010746b3          	xor	a3,a4,a6
     a60:	0116c6b3          	xor	a3,a3,a7
     a64:	fcb6c693          	xori	a3,a3,-53
  if (!ok) {
     a68:	00064603          	lbu	a2,0(a2)
     a6c:	0ff6f693          	zext.b	a3,a3
     a70:	04d61963          	bne	a2,a3,ac2 <main+0x308>
      for (uint j = 0; j < BSIZE; j++) {
     a74:	2785                	addiw	a5,a5,1
     a76:	fc6795e3          	bne	a5,t1,a40 <main+0x286>
    for (uint b = 0; b < n; b++) {
     a7a:	2f05                	addiw	t5,t5,1
     a7c:	4005859b          	addiw	a1,a1,1024
     a80:	f838081b          	addiw	a6,a6,-125
     a84:	0ff87813          	zext.b	a6,a6
     a88:	057f7d63          	bgeu	t5,s7,ae2 <main+0x328>
        uint off = (first + b) * BSIZE + j;
     a8c:	013f0e3b          	addw	t3,t5,s3
     a90:	4701                	li	a4,0
      for (uint j = 0; j < BSIZE; j++) {
     a92:	4781                	li	a5,0
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
     a94:	008e589b          	srliw	a7,t3,0x8
     a98:	b77d                	j	a46 <main+0x28c>
    return (block >> (8 * byte)) & 255;
     a9a:	0037961b          	slliw	a2,a5,0x3
     a9e:	00ce563b          	srlw	a2,t3,a2
     aa2:	0ff67613          	zext.b	a2,a2
        check((uchar)fs_buffer[b * BSIZE + j] == want, "file contents differ");
     aa6:	00b786bb          	addw	a3,a5,a1
     aaa:	1682                	slli	a3,a3,0x20
     aac:	9281                	srli	a3,a3,0x20
     aae:	96a6                	add	a3,a3,s1
  if (!ok) {
     ab0:	0006c683          	lbu	a3,0(a3)
     ab4:	00c69763          	bne	a3,a2,ac2 <main+0x308>
      for (uint j = 0; j < BSIZE; j++) {
     ab8:	2785                	addiw	a5,a5,1
     aba:	2745                	addiw	a4,a4,17
     abc:	0ff77713          	zext.b	a4,a4
     ac0:	b759                	j	a46 <main+0x28c>
     ac2:	e1ea                	sd	s10,192(sp)
     ac4:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     ac6:	00002617          	auipc	a2,0x2
     aca:	1e260613          	addi	a2,a2,482 # 2ca8 <malloc+0x59e>
     ace:	00002597          	auipc	a1,0x2
     ad2:	d3258593          	addi	a1,a1,-718 # 2800 <malloc+0xf6>
     ad6:	4509                	li	a0,2
     ad8:	34d010ef          	jal	2624 <fprintf>
    exit(1);
     adc:	4505                	li	a0,1
     ade:	6fa010ef          	jal	21d8 <exit>
    first += n;
     ae2:	017989bb          	addw	s3,s3,s7
  for (uint first = 0; first < blocks;) {
     ae6:	0569f663          	bgeu	s3,s6,b32 <main+0x378>
    uint n = blocks - first;
     aea:	413a873b          	subw	a4,s5,s3
     aee:	87ba                	mv	a5,a4
    if (n > 8)
     af0:	00ec7363          	bgeu	s8,a4,af6 <main+0x33c>
     af4:	47a1                	li	a5,8
     af6:	00078b9b          	sext.w	s7,a5
    check(read(fd, fs_buffer, n * BSIZE) == n * BSIZE, "read full test data");
     afa:	00a7961b          	slliw	a2,a5,0xa
     afe:	8cb2                	mv	s9,a2
     b00:	85a6                	mv	a1,s1
     b02:	8552                	mv	a0,s4
     b04:	6ec010ef          	jal	21f0 <read>
  if (!ok) {
     b08:	f0ac9ce3          	bne	s9,a0,a20 <main+0x266>
    for (uint b = 0; b < n; b++) {
     b0c:	fd3b0be3          	beq	s6,s3,ae2 <main+0x328>
     b10:	0069981b          	slliw	a6,s3,0x6
     b14:	4109883b          	subw	a6,s3,a6
     b18:	0018181b          	slliw	a6,a6,0x1
     b1c:	0138083b          	addw	a6,a6,s3
     b20:	0ff87813          	zext.b	a6,a6
     b24:	4581                	li	a1,0
     b26:	4f01                	li	t5,0
  if (byte < 4)
     b28:	450d                	li	a0,3
    return seed;
     b2a:	4e9d                	li	t4,7
      for (uint j = 0; j < BSIZE; j++) {
     b2c:	40000313          	li	t1,1024
     b30:	bfb1                	j	a8c <main+0x2d2>
  check(read(fd, fs_buffer, 1) == 0, "EOF after exact file size");
     b32:	4605                	li	a2,1
     b34:	00003597          	auipc	a1,0x3
     b38:	4dc58593          	addi	a1,a1,1244 # 4010 <fs_buffer>
     b3c:	8552                	mv	a0,s4
     b3e:	6b2010ef          	jal	21f0 <read>
  if (!ok) {
     b42:	e105                	bnez	a0,b62 <main+0x3a8>
  check(fd >= 0, "open for verification");
  verifyfd(fd, blocks, seed, patches, np);
  check(close(fd) == 0, "close verified file");
     b44:	8552                	mv	a0,s4
     b46:	6ba010ef          	jal	2200 <close>
  if (!ok) {
     b4a:	ed05                	bnez	a0,b82 <main+0x3c8>
  check(unlink("fst_part.tmp") == 0, "remove boundary fixture");
     b4c:	00002517          	auipc	a0,0x2
     b50:	0c450513          	addi	a0,a0,196 # 2c10 <malloc+0x506>
     b54:	6d4010ef          	jal	2228 <unlink>
     b58:	e529                	bnez	a0,ba2 <main+0x3e8>
     b5a:	e1ea                	sd	s10,192(sp)
     b5c:	fd6e                	sd	s11,184(sp)
     b5e:	1d50006f          	j	1532 <main+0xd78>
     b62:	e1ea                	sd	s10,192(sp)
     b64:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     b66:	00002617          	auipc	a2,0x2
     b6a:	15a60613          	addi	a2,a2,346 # 2cc0 <malloc+0x5b6>
     b6e:	00002597          	auipc	a1,0x2
     b72:	c9258593          	addi	a1,a1,-878 # 2800 <malloc+0xf6>
     b76:	4509                	li	a0,2
     b78:	2ad010ef          	jal	2624 <fprintf>
    exit(1);
     b7c:	4505                	li	a0,1
     b7e:	65a010ef          	jal	21d8 <exit>
     b82:	e1ea                	sd	s10,192(sp)
     b84:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     b86:	00002617          	auipc	a2,0x2
     b8a:	15a60613          	addi	a2,a2,346 # 2ce0 <malloc+0x5d6>
     b8e:	00002597          	auipc	a1,0x2
     b92:	c7258593          	addi	a1,a1,-910 # 2800 <malloc+0xf6>
     b96:	4509                	li	a0,2
     b98:	28d010ef          	jal	2624 <fprintf>
    exit(1);
     b9c:	4505                	li	a0,1
     b9e:	63a010ef          	jal	21d8 <exit>
     ba2:	e1ea                	sd	s10,192(sp)
     ba4:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     ba6:	00002617          	auipc	a2,0x2
     baa:	15260613          	addi	a2,a2,338 # 2cf8 <malloc+0x5ee>
     bae:	00002597          	auipc	a1,0x2
     bb2:	c5258593          	addi	a1,a1,-942 # 2800 <malloc+0xf6>
     bb6:	4509                	li	a0,2
     bb8:	26d010ef          	jal	2624 <fprintf>
    exit(1);
     bbc:	4505                	li	a0,1
     bbe:	61a010ef          	jal	21d8 <exit>
  } else if (!strcmp(argv[1], "trunc")) {
     bc2:	00002597          	auipc	a1,0x2
     bc6:	14e58593          	addi	a1,a1,334 # 2d10 <malloc+0x606>
     bca:	6488                	ld	a0,8(s1)
     bcc:	386010ef          	jal	1f52 <strcmp>
     bd0:	8baa                	mv	s7,a0
     bd2:	7e051063          	bnez	a0,13b2 <main+0xbf8>
     bd6:	e1ea                	sd	s10,192(sp)
    check(argc == 3, "truncation mode required");
     bd8:	ffd90513          	addi	a0,s2,-3
     bdc:	00002597          	auipc	a1,0x2
     be0:	13c58593          	addi	a1,a1,316 # 2d18 <malloc+0x60e>
     be4:	00153513          	seqz	a0,a0
     be8:	c18ff0ef          	jal	0 <check>
    trunc_test(atoi(argv[2]));
     bec:	6888                	ld	a0,16(s1)
     bee:	4c4010ef          	jal	20b2 <atoi>
     bf2:	8d2a                	mv	s10,a0
  for (int i = 0; i < (mode == 2 ? 4 : 1); i++) {
     bf4:	ffe50793          	addi	a5,a0,-2
     bf8:	00f037b3          	snez	a5,a5
     bfc:	40f007bb          	negw	a5,a5
     c00:	9bf5                	andi	a5,a5,-3
     c02:	2791                	addiw	a5,a5,4
     c04:	eef43823          	sd	a5,-272(s0)
    trunc_test(atoi(argv[2]));
     c08:	4b75                	li	s6,29
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     c0a:	00003497          	auipc	s1,0x3
     c0e:	40648493          	addi	s1,s1,1030 # 4010 <fs_buffer>
      for (uint j = 0; j < BSIZE; j++)
     c12:	40000913          	li	s2,1024
  unlink(name);
     c16:	00002517          	auipc	a0,0x2
     c1a:	ffa50513          	addi	a0,a0,-6 # 2c10 <malloc+0x506>
     c1e:	60a010ef          	jal	2228 <unlink>
  int fd = open(name, O_CREATE | O_WRONLY | O_TRUNC);
     c22:	60100593          	li	a1,1537
     c26:	00002517          	auipc	a0,0x2
     c2a:	fea50513          	addi	a0,a0,-22 # 2c10 <malloc+0x506>
     c2e:	5ea010ef          	jal	2218 <open>
     c32:	8caa                	mv	s9,a0
  if (!ok) {
     c34:	00054b63          	bltz	a0,c4a <main+0x490>
     c38:	fd6e                	sd	s11,184(sp)
    makefile("fst_part.tmp", 525, i + 1);
     c3a:	2b85                	addiw	s7,s7,1
  for (uint first = 0; first < blocks;) {
     c3c:	4a81                	li	s5,0
    uint n = blocks - first;
     c3e:	20d00d93          	li	s11,525
  if (byte == 4)
     c42:	4991                	li	s3,4
     c44:	0ffbfa13          	zext.b	s4,s7
     c48:	a855                	j	cfc <main+0x542>
     c4a:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     c4c:	00002617          	auipc	a2,0x2
     c50:	fd460613          	addi	a2,a2,-44 # 2c20 <malloc+0x516>
     c54:	00002597          	auipc	a1,0x2
     c58:	bac58593          	addi	a1,a1,-1108 # 2800 <malloc+0xf6>
     c5c:	4509                	li	a0,2
     c5e:	1c7010ef          	jal	2624 <fprintf>
    exit(1);
     c62:	4505                	li	a0,1
     c64:	574010ef          	jal	21d8 <exit>
    return (block >> (8 * byte)) & 255;
     c68:	0037161b          	slliw	a2,a4,0x3
     c6c:	00c8d63b          	srlw	a2,a7,a2
     c70:	0ff67613          	zext.b	a2,a2
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     c74:	1782                	slli	a5,a5,0x20
     c76:	9381                	srli	a5,a5,0x20
     c78:	97a6                	add	a5,a5,s1
     c7a:	00c78023          	sb	a2,0(a5)
      for (uint j = 0; j < BSIZE; j++)
     c7e:	2705                	addiw	a4,a4,1
     c80:	26c5                	addiw	a3,a3,17
     c82:	0ff6f693          	zext.b	a3,a3
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     c86:	00b707bb          	addw	a5,a4,a1
  if (byte < 4)
     c8a:	fce57fe3          	bgeu	a0,a4,c68 <main+0x4ae>
  if (byte == 4)
     c8e:	8652                	mv	a2,s4
     c90:	ff3702e3          	beq	a4,s3,c74 <main+0x4ba>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     c94:	1782                	slli	a5,a5,0x20
     c96:	9381                	srli	a5,a5,0x20
     c98:	97a6                	add	a5,a5,s1
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
     c9a:	0106c633          	xor	a2,a3,a6
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     c9e:	00c78023          	sb	a2,0(a5)
      for (uint j = 0; j < BSIZE; j++)
     ca2:	2705                	addiw	a4,a4,1
     ca4:	01270663          	beq	a4,s2,cb0 <main+0x4f6>
     ca8:	26c5                	addiw	a3,a3,17
     caa:	0ff6f693          	zext.b	a3,a3
     cae:	bfe1                	j	c86 <main+0x4cc>
    for (uint b = 0; b < n; b++)
     cb0:	2e05                	addiw	t3,t3,1
     cb2:	f833031b          	addiw	t1,t1,-125
     cb6:	0ff37313          	zext.b	t1,t1
     cba:	4005859b          	addiw	a1,a1,1024
     cbe:	018e7d63          	bgeu	t3,s8,cd8 <main+0x51e>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     cc2:	01ca88bb          	addw	a7,s5,t3
     cc6:	006b4833          	xor	a6,s6,t1
     cca:	4681                	li	a3,0
      for (uint j = 0; j < BSIZE; j++)
     ccc:	4701                	li	a4,0
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
     cce:	0088d79b          	srliw	a5,a7,0x8
     cd2:	00f84833          	xor	a6,a6,a5
     cd6:	bf45                	j	c86 <main+0x4cc>
    check(write(fd, fs_buffer, n * BSIZE) == n * BSIZE, "write full test data");
     cd8:	00ac161b          	slliw	a2,s8,0xa
     cdc:	eec43c23          	sd	a2,-264(s0)
     ce0:	85a6                	mv	a1,s1
     ce2:	8566                	mv	a0,s9
     ce4:	514010ef          	jal	21f8 <write>
  if (!ok) {
     ce8:	ef843783          	ld	a5,-264(s0)
     cec:	02a79e63          	bne	a5,a0,d28 <main+0x56e>
    first += n;
     cf0:	018a8abb          	addw	s5,s5,s8
  for (uint first = 0; first < blocks;) {
     cf4:	20c00793          	li	a5,524
     cf8:	0557e663          	bltu	a5,s5,d44 <main+0x58a>
    uint n = blocks - first;
     cfc:	415d87bb          	subw	a5,s11,s5
     d00:	8c3e                	mv	s8,a5
    if (n > 8)
     d02:	4721                	li	a4,8
     d04:	00f77363          	bgeu	a4,a5,d0a <main+0x550>
     d08:	4c21                	li	s8,8
     d0a:	2c01                	sext.w	s8,s8
    for (uint b = 0; b < n; b++)
     d0c:	006a931b          	slliw	t1,s5,0x6
     d10:	406a833b          	subw	t1,s5,t1
     d14:	0013131b          	slliw	t1,t1,0x1
     d18:	0153033b          	addw	t1,t1,s5
     d1c:	0ff37313          	zext.b	t1,t1
    if (n > 8)
     d20:	4581                	li	a1,0
    for (uint b = 0; b < n; b++)
     d22:	4e01                	li	t3,0
  if (byte < 4)
     d24:	450d                	li	a0,3
     d26:	bf71                	j	cc2 <main+0x508>
    fprintf(2, "TEST FAILURE: %s\n", why);
     d28:	00002617          	auipc	a2,0x2
     d2c:	f1060613          	addi	a2,a2,-240 # 2c38 <malloc+0x52e>
     d30:	00002597          	auipc	a1,0x2
     d34:	ad058593          	addi	a1,a1,-1328 # 2800 <malloc+0xf6>
     d38:	4509                	li	a0,2
     d3a:	0eb010ef          	jal	2624 <fprintf>
    exit(1);
     d3e:	4505                	li	a0,1
     d40:	498010ef          	jal	21d8 <exit>
  check(close(fd) == 0, "close written file");
     d44:	8566                	mv	a0,s9
     d46:	4ba010ef          	jal	2200 <close>
  if (!ok) {
     d4a:	e129                	bnez	a0,d8c <main+0x5d2>
  int fd = open(name, O_RDONLY);
     d4c:	4581                	li	a1,0
     d4e:	00002517          	auipc	a0,0x2
     d52:	ec250513          	addi	a0,a0,-318 # 2c10 <malloc+0x506>
     d56:	4c2010ef          	jal	2218 <open>
     d5a:	8c2a                	mv	s8,a0
  if (!ok) {
     d5c:	04054663          	bltz	a0,da8 <main+0x5ee>
  check(fstat(fd, &st) == 0 && st.size == (uint64)blocks * BSIZE,
     d60:	f5040593          	addi	a1,s0,-176
     d64:	4cc010ef          	jal	2230 <fstat>
     d68:	ed31                	bnez	a0,dc4 <main+0x60a>
  if (!ok) {
     d6a:	f6043703          	ld	a4,-160(s0)
     d6e:	000837b7          	lui	a5,0x83
     d72:	40078793          	addi	a5,a5,1024 # 83400 <base+0x7d3f0>
     d76:	04f71763          	bne	a4,a5,dc4 <main+0x60a>
  for (uint first = 0; first < blocks;) {
     d7a:	4a81                	li	s5,0
    uint n = blocks - first;
     d7c:	20d00d93          	li	s11,525
    check(read(fd, fs_buffer, n * BSIZE) == n * BSIZE, "read full test data");
     d80:	00003997          	auipc	s3,0x3
     d84:	29098993          	addi	s3,s3,656 # 4010 <fs_buffer>
  if (byte == 4)
     d88:	4a11                	li	s4,4
     d8a:	aa29                	j	ea4 <main+0x6ea>
    fprintf(2, "TEST FAILURE: %s\n", why);
     d8c:	00002617          	auipc	a2,0x2
     d90:	ec460613          	addi	a2,a2,-316 # 2c50 <malloc+0x546>
     d94:	00002597          	auipc	a1,0x2
     d98:	a6c58593          	addi	a1,a1,-1428 # 2800 <malloc+0xf6>
     d9c:	4509                	li	a0,2
     d9e:	087010ef          	jal	2624 <fprintf>
    exit(1);
     da2:	4505                	li	a0,1
     da4:	434010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     da8:	00002617          	auipc	a2,0x2
     dac:	ec060613          	addi	a2,a2,-320 # 2c68 <malloc+0x55e>
     db0:	00002597          	auipc	a1,0x2
     db4:	a5058593          	addi	a1,a1,-1456 # 2800 <malloc+0xf6>
     db8:	4509                	li	a0,2
     dba:	06b010ef          	jal	2624 <fprintf>
    exit(1);
     dbe:	4505                	li	a0,1
     dc0:	418010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     dc4:	00002617          	auipc	a2,0x2
     dc8:	ebc60613          	addi	a2,a2,-324 # 2c80 <malloc+0x576>
     dcc:	00002597          	auipc	a1,0x2
     dd0:	a3458593          	addi	a1,a1,-1484 # 2800 <malloc+0xf6>
     dd4:	4509                	li	a0,2
     dd6:	04f010ef          	jal	2624 <fprintf>
    exit(1);
     dda:	4505                	li	a0,1
     ddc:	3fc010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     de0:	00002617          	auipc	a2,0x2
     de4:	eb060613          	addi	a2,a2,-336 # 2c90 <malloc+0x586>
     de8:	00002597          	auipc	a1,0x2
     dec:	a1858593          	addi	a1,a1,-1512 # 2800 <malloc+0xf6>
     df0:	4509                	li	a0,2
     df2:	033010ef          	jal	2624 <fprintf>
    exit(1);
     df6:	4505                	li	a0,1
     df8:	3e0010ef          	jal	21d8 <exit>
    return (block >> (8 * byte)) & 255;
     dfc:	0037961b          	slliw	a2,a5,0x3
     e00:	00c8d63b          	srlw	a2,a7,a2
     e04:	0ff67613          	zext.b	a2,a2
        check((uchar)fs_buffer[b * BSIZE + j] == want, "file contents differ");
     e08:	00b786bb          	addw	a3,a5,a1
     e0c:	1682                	slli	a3,a3,0x20
     e0e:	9281                	srli	a3,a3,0x20
     e10:	96ce                	add	a3,a3,s3
  if (!ok) {
     e12:	0006c683          	lbu	a3,0(a3)
     e16:	02c69f63          	bne	a3,a2,e54 <main+0x69a>
      for (uint j = 0; j < BSIZE; j++) {
     e1a:	2785                	addiw	a5,a5,1
     e1c:	2745                	addiw	a4,a4,17
     e1e:	0ff77713          	zext.b	a4,a4
  if (byte < 4)
     e22:	fcf57de3          	bgeu	a0,a5,dfc <main+0x642>
  if (byte == 4)
     e26:	861a                	mv	a2,t1
     e28:	ff4780e3          	beq	a5,s4,e08 <main+0x64e>
        check((uchar)fs_buffer[b * BSIZE + j] == want, "file contents differ");
     e2c:	00b7863b          	addw	a2,a5,a1
     e30:	1602                	slli	a2,a2,0x20
     e32:	9201                	srli	a2,a2,0x20
     e34:	964e                	add	a2,a2,s3
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
     e36:	010746b3          	xor	a3,a4,a6
  if (!ok) {
     e3a:	00064603          	lbu	a2,0(a2)
     e3e:	0ff6f693          	zext.b	a3,a3
     e42:	00d61963          	bne	a2,a3,e54 <main+0x69a>
      for (uint j = 0; j < BSIZE; j++) {
     e46:	2785                	addiw	a5,a5,1
     e48:	03278463          	beq	a5,s2,e70 <main+0x6b6>
     e4c:	2745                	addiw	a4,a4,17
     e4e:	0ff77713          	zext.b	a4,a4
     e52:	bfc1                	j	e22 <main+0x668>
    fprintf(2, "TEST FAILURE: %s\n", why);
     e54:	00002617          	auipc	a2,0x2
     e58:	e5460613          	addi	a2,a2,-428 # 2ca8 <malloc+0x59e>
     e5c:	00002597          	auipc	a1,0x2
     e60:	9a458593          	addi	a1,a1,-1628 # 2800 <malloc+0xf6>
     e64:	4509                	li	a0,2
     e66:	7be010ef          	jal	2624 <fprintf>
    exit(1);
     e6a:	4505                	li	a0,1
     e6c:	36c010ef          	jal	21d8 <exit>
    for (uint b = 0; b < n; b++) {
     e70:	2e85                	addiw	t4,t4,1
     e72:	f83e0e1b          	addiw	t3,t3,-125
     e76:	0ffe7e13          	zext.b	t3,t3
     e7a:	4005859b          	addiw	a1,a1,1024
     e7e:	019efd63          	bgeu	t4,s9,e98 <main+0x6de>
        uint off = (first + b) * BSIZE + j;
     e82:	01da88bb          	addw	a7,s5,t4
     e86:	01cb4833          	xor	a6,s6,t3
     e8a:	4701                	li	a4,0
      for (uint j = 0; j < BSIZE; j++) {
     e8c:	4781                	li	a5,0
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
     e8e:	0088d69b          	srliw	a3,a7,0x8
     e92:	00d84833          	xor	a6,a6,a3
     e96:	b771                	j	e22 <main+0x668>
    first += n;
     e98:	015c8abb          	addw	s5,s9,s5
  for (uint first = 0; first < blocks;) {
     e9c:	20c00793          	li	a5,524
     ea0:	0557e763          	bltu	a5,s5,eee <main+0x734>
    uint n = blocks - first;
     ea4:	415d873b          	subw	a4,s11,s5
     ea8:	87ba                	mv	a5,a4
    if (n > 8)
     eaa:	46a1                	li	a3,8
     eac:	00e6f363          	bgeu	a3,a4,eb2 <main+0x6f8>
     eb0:	47a1                	li	a5,8
     eb2:	00078c9b          	sext.w	s9,a5
    check(read(fd, fs_buffer, n * BSIZE) == n * BSIZE, "read full test data");
     eb6:	00a7961b          	slliw	a2,a5,0xa
     eba:	eec43c23          	sd	a2,-264(s0)
     ebe:	85ce                	mv	a1,s3
     ec0:	8562                	mv	a0,s8
     ec2:	32e010ef          	jal	21f0 <read>
  if (!ok) {
     ec6:	ef843783          	ld	a5,-264(s0)
     eca:	f0a79be3          	bne	a5,a0,de0 <main+0x626>
     ece:	006a9e1b          	slliw	t3,s5,0x6
     ed2:	41ca8e3b          	subw	t3,s5,t3
     ed6:	001e1e1b          	slliw	t3,t3,0x1
     eda:	015e0e3b          	addw	t3,t3,s5
     ede:	0ffe7e13          	zext.b	t3,t3
     ee2:	4581                	li	a1,0
    for (uint b = 0; b < n; b++) {
     ee4:	4e81                	li	t4,0
  if (byte < 4)
     ee6:	450d                	li	a0,3
     ee8:	0ffbf313          	zext.b	t1,s7
     eec:	bf59                	j	e82 <main+0x6c8>
  check(read(fd, fs_buffer, 1) == 0, "EOF after exact file size");
     eee:	4605                	li	a2,1
     ef0:	00003597          	auipc	a1,0x3
     ef4:	12058593          	addi	a1,a1,288 # 4010 <fs_buffer>
     ef8:	8562                	mv	a0,s8
     efa:	2f6010ef          	jal	21f0 <read>
  if (!ok) {
     efe:	e121                	bnez	a0,f3e <main+0x784>
  check(close(fd) == 0, "close verified file");
     f00:	8562                	mv	a0,s8
     f02:	2fe010ef          	jal	2200 <close>
  if (!ok) {
     f06:	e931                	bnez	a0,f5a <main+0x7a0>
    if (mode != 1) {
     f08:	4785                	li	a5,1
     f0a:	0afd0a63          	beq	s10,a5,fbe <main+0x804>
      int fd = open("fst_part.tmp", O_WRONLY | O_TRUNC);
     f0e:	40100593          	li	a1,1025
     f12:	00002517          	auipc	a0,0x2
     f16:	cfe50513          	addi	a0,a0,-770 # 2c10 <malloc+0x506>
     f1a:	2fe010ef          	jal	2218 <open>
      check(fd >= 0 && close(fd) == 0, "truncate file");
     f1e:	04055c63          	bgez	a0,f76 <main+0x7bc>
    fprintf(2, "TEST FAILURE: %s\n", why);
     f22:	00002617          	auipc	a2,0x2
     f26:	e1660613          	addi	a2,a2,-490 # 2d38 <malloc+0x62e>
     f2a:	00002597          	auipc	a1,0x2
     f2e:	8d658593          	addi	a1,a1,-1834 # 2800 <malloc+0xf6>
     f32:	4509                	li	a0,2
     f34:	6f0010ef          	jal	2624 <fprintf>
    exit(1);
     f38:	4505                	li	a0,1
     f3a:	29e010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     f3e:	00002617          	auipc	a2,0x2
     f42:	d8260613          	addi	a2,a2,-638 # 2cc0 <malloc+0x5b6>
     f46:	00002597          	auipc	a1,0x2
     f4a:	8ba58593          	addi	a1,a1,-1862 # 2800 <malloc+0xf6>
     f4e:	4509                	li	a0,2
     f50:	6d4010ef          	jal	2624 <fprintf>
    exit(1);
     f54:	4505                	li	a0,1
     f56:	282010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     f5a:	00002617          	auipc	a2,0x2
     f5e:	d8660613          	addi	a2,a2,-634 # 2ce0 <malloc+0x5d6>
     f62:	00002597          	auipc	a1,0x2
     f66:	89e58593          	addi	a1,a1,-1890 # 2800 <malloc+0xf6>
     f6a:	4509                	li	a0,2
     f6c:	6b8010ef          	jal	2624 <fprintf>
    exit(1);
     f70:	4505                	li	a0,1
     f72:	266010ef          	jal	21d8 <exit>
     f76:	28a010ef          	jal	2200 <close>
  if (!ok) {
     f7a:	f545                	bnez	a0,f22 <main+0x768>
  int fd = open(name, O_RDONLY);
     f7c:	4581                	li	a1,0
     f7e:	00002517          	auipc	a0,0x2
     f82:	c9250513          	addi	a0,a0,-878 # 2c10 <malloc+0x506>
     f86:	292010ef          	jal	2218 <open>
     f8a:	89aa                	mv	s3,a0
  if (!ok) {
     f8c:	06054b63          	bltz	a0,1002 <main+0x848>
  check(fstat(fd, &st) == 0 && st.size == (uint64)blocks * BSIZE,
     f90:	f5040593          	addi	a1,s0,-176
     f94:	29c010ef          	jal	2230 <fstat>
     f98:	e159                	bnez	a0,101e <main+0x864>
  if (!ok) {
     f9a:	f6043783          	ld	a5,-160(s0)
     f9e:	e3c1                	bnez	a5,101e <main+0x864>
  check(read(fd, fs_buffer, 1) == 0, "EOF after exact file size");
     fa0:	4605                	li	a2,1
     fa2:	00003597          	auipc	a1,0x3
     fa6:	06e58593          	addi	a1,a1,110 # 4010 <fs_buffer>
     faa:	854e                	mv	a0,s3
     fac:	244010ef          	jal	21f0 <read>
  if (!ok) {
     fb0:	e549                	bnez	a0,103a <main+0x880>
  check(close(fd) == 0, "close verified file");
     fb2:	854e                	mv	a0,s3
     fb4:	24c010ef          	jal	2200 <close>
  if (!ok) {
     fb8:	ed59                	bnez	a0,1056 <main+0x89c>
    if (mode != 0) {
     fba:	3c0d0763          	beqz	s10,1388 <main+0xbce>
  unlink(name);
     fbe:	00002517          	auipc	a0,0x2
     fc2:	c5250513          	addi	a0,a0,-942 # 2c10 <malloc+0x506>
     fc6:	262010ef          	jal	2228 <unlink>
  int fd = open(name, O_CREATE | O_WRONLY | O_TRUNC);
     fca:	60100593          	li	a1,1537
     fce:	00002517          	auipc	a0,0x2
     fd2:	c4250513          	addi	a0,a0,-958 # 2c10 <malloc+0x506>
     fd6:	242010ef          	jal	2218 <open>
     fda:	8daa                	mv	s11,a0
  if (!ok) {
     fdc:	08054b63          	bltz	a0,1072 <main+0x8b8>
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
     fe0:	01db079b          	addiw	a5,s6,29
     fe4:	0ff7f793          	zext.b	a5,a5
     fe8:	eef43c23          	sd	a5,-264(s0)
  for (uint first = 0; first < blocks;) {
     fec:	4c01                	li	s8,0
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
     fee:	00003997          	auipc	s3,0x3
     ff2:	02298993          	addi	s3,s3,34 # 4010 <fs_buffer>
  if (byte == 4)
     ff6:	4a11                	li	s4,4
     ff8:	001b8a9b          	addiw	s5,s7,1
     ffc:	0ffafa93          	zext.b	s5,s5
    1000:	a21d                	j	1126 <main+0x96c>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1002:	00002617          	auipc	a2,0x2
    1006:	c6660613          	addi	a2,a2,-922 # 2c68 <malloc+0x55e>
    100a:	00001597          	auipc	a1,0x1
    100e:	7f658593          	addi	a1,a1,2038 # 2800 <malloc+0xf6>
    1012:	4509                	li	a0,2
    1014:	610010ef          	jal	2624 <fprintf>
    exit(1);
    1018:	4505                	li	a0,1
    101a:	1be010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
    101e:	00002617          	auipc	a2,0x2
    1022:	c6260613          	addi	a2,a2,-926 # 2c80 <malloc+0x576>
    1026:	00001597          	auipc	a1,0x1
    102a:	7da58593          	addi	a1,a1,2010 # 2800 <malloc+0xf6>
    102e:	4509                	li	a0,2
    1030:	5f4010ef          	jal	2624 <fprintf>
    exit(1);
    1034:	4505                	li	a0,1
    1036:	1a2010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
    103a:	00002617          	auipc	a2,0x2
    103e:	c8660613          	addi	a2,a2,-890 # 2cc0 <malloc+0x5b6>
    1042:	00001597          	auipc	a1,0x1
    1046:	7be58593          	addi	a1,a1,1982 # 2800 <malloc+0xf6>
    104a:	4509                	li	a0,2
    104c:	5d8010ef          	jal	2624 <fprintf>
    exit(1);
    1050:	4505                	li	a0,1
    1052:	186010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1056:	00002617          	auipc	a2,0x2
    105a:	c8a60613          	addi	a2,a2,-886 # 2ce0 <malloc+0x5d6>
    105e:	00001597          	auipc	a1,0x1
    1062:	7a258593          	addi	a1,a1,1954 # 2800 <malloc+0xf6>
    1066:	4509                	li	a0,2
    1068:	5bc010ef          	jal	2624 <fprintf>
    exit(1);
    106c:	4505                	li	a0,1
    106e:	16a010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1072:	00002617          	auipc	a2,0x2
    1076:	bae60613          	addi	a2,a2,-1106 # 2c20 <malloc+0x516>
    107a:	00001597          	auipc	a1,0x1
    107e:	78658593          	addi	a1,a1,1926 # 2800 <malloc+0xf6>
    1082:	4509                	li	a0,2
    1084:	5a0010ef          	jal	2624 <fprintf>
    exit(1);
    1088:	4505                	li	a0,1
    108a:	14e010ef          	jal	21d8 <exit>
    return (block >> (8 * byte)) & 255;
    108e:	0037161b          	slliw	a2,a4,0x3
    1092:	00c8d63b          	srlw	a2,a7,a2
    1096:	0ff67613          	zext.b	a2,a2
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
    109a:	1782                	slli	a5,a5,0x20
    109c:	9381                	srli	a5,a5,0x20
    109e:	97ce                	add	a5,a5,s3
    10a0:	00c78023          	sb	a2,0(a5)
      for (uint j = 0; j < BSIZE; j++)
    10a4:	2705                	addiw	a4,a4,1
    10a6:	26c5                	addiw	a3,a3,17
    10a8:	0ff6f693          	zext.b	a3,a3
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
    10ac:	00b707bb          	addw	a5,a4,a1
  if (byte < 4)
    10b0:	fce57fe3          	bgeu	a0,a4,108e <main+0x8d4>
  if (byte == 4)
    10b4:	8656                	mv	a2,s5
    10b6:	ff4702e3          	beq	a4,s4,109a <main+0x8e0>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
    10ba:	1782                	slli	a5,a5,0x20
    10bc:	9381                	srli	a5,a5,0x20
    10be:	97ce                	add	a5,a5,s3
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
    10c0:	0106c633          	xor	a2,a3,a6
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
    10c4:	00c78023          	sb	a2,0(a5)
      for (uint j = 0; j < BSIZE; j++)
    10c8:	2705                	addiw	a4,a4,1
    10ca:	01270663          	beq	a4,s2,10d6 <main+0x91c>
    10ce:	26c5                	addiw	a3,a3,17
    10d0:	0ff6f693          	zext.b	a3,a3
    10d4:	bfe1                	j	10ac <main+0x8f2>
    for (uint b = 0; b < n; b++)
    10d6:	2e05                	addiw	t3,t3,1
    10d8:	f833031b          	addiw	t1,t1,-125
    10dc:	0ff37313          	zext.b	t1,t1
    10e0:	4005859b          	addiw	a1,a1,1024
    10e4:	019e7f63          	bgeu	t3,s9,1102 <main+0x948>
        fs_buffer[b * BSIZE + j] = pattern(first + b, j, seed);
    10e8:	01cc08bb          	addw	a7,s8,t3
    10ec:	ef843783          	ld	a5,-264(s0)
    10f0:	00f34833          	xor	a6,t1,a5
    10f4:	4681                	li	a3,0
      for (uint j = 0; j < BSIZE; j++)
    10f6:	4701                	li	a4,0
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
    10f8:	0088d79b          	srliw	a5,a7,0x8
    10fc:	00f84833          	xor	a6,a6,a5
    1100:	b775                	j	10ac <main+0x8f2>
    check(write(fd, fs_buffer, n * BSIZE) == n * BSIZE, "write full test data");
    1102:	00ac961b          	slliw	a2,s9,0xa
    1106:	eec43423          	sd	a2,-280(s0)
    110a:	85ce                	mv	a1,s3
    110c:	856e                	mv	a0,s11
    110e:	0ea010ef          	jal	21f8 <write>
  if (!ok) {
    1112:	ee843783          	ld	a5,-280(s0)
    1116:	02a79c63          	bne	a5,a0,114e <main+0x994>
    first += n;
    111a:	019c0c3b          	addw	s8,s8,s9
  for (uint first = 0; first < blocks;) {
    111e:	20c00793          	li	a5,524
    1122:	0587e463          	bltu	a5,s8,116a <main+0x9b0>
    uint n = blocks - first;
    1126:	20d00793          	li	a5,525
    112a:	418787bb          	subw	a5,a5,s8
    112e:	8cbe                	mv	s9,a5
    if (n > 8)
    1130:	4721                	li	a4,8
    1132:	00f77363          	bgeu	a4,a5,1138 <main+0x97e>
    1136:	4ca1                	li	s9,8
    1138:	2c81                	sext.w	s9,s9
    for (uint b = 0; b < n; b++)
    113a:	f8300313          	li	t1,-125
    113e:	0383033b          	mulw	t1,t1,s8
    1142:	0ff37313          	zext.b	t1,t1
    if (n > 8)
    1146:	4581                	li	a1,0
    for (uint b = 0; b < n; b++)
    1148:	4e01                	li	t3,0
  if (byte < 4)
    114a:	450d                	li	a0,3
    114c:	bf71                	j	10e8 <main+0x92e>
    fprintf(2, "TEST FAILURE: %s\n", why);
    114e:	00002617          	auipc	a2,0x2
    1152:	aea60613          	addi	a2,a2,-1302 # 2c38 <malloc+0x52e>
    1156:	00001597          	auipc	a1,0x1
    115a:	6aa58593          	addi	a1,a1,1706 # 2800 <malloc+0xf6>
    115e:	4509                	li	a0,2
    1160:	4c4010ef          	jal	2624 <fprintf>
    exit(1);
    1164:	4505                	li	a0,1
    1166:	072010ef          	jal	21d8 <exit>
  check(close(fd) == 0, "close written file");
    116a:	856e                	mv	a0,s11
    116c:	094010ef          	jal	2200 <close>
  if (!ok) {
    1170:	e90d                	bnez	a0,11a2 <main+0x9e8>
      int fd = open("fst_part.tmp", O_RDONLY);
    1172:	4581                	li	a1,0
    1174:	00002517          	auipc	a0,0x2
    1178:	a9c50513          	addi	a0,a0,-1380 # 2c10 <malloc+0x506>
    117c:	09c010ef          	jal	2218 <open>
    1180:	8a2a                	mv	s4,a0
      check(fd >= 0 && unlink("fst_part.tmp") == 0, "unlink open file");
    1182:	02055e63          	bgez	a0,11be <main+0xa04>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1186:	00002617          	auipc	a2,0x2
    118a:	bc260613          	addi	a2,a2,-1086 # 2d48 <malloc+0x63e>
    118e:	00001597          	auipc	a1,0x1
    1192:	67258593          	addi	a1,a1,1650 # 2800 <malloc+0xf6>
    1196:	4509                	li	a0,2
    1198:	48c010ef          	jal	2624 <fprintf>
    exit(1);
    119c:	4505                	li	a0,1
    119e:	03a010ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
    11a2:	00002617          	auipc	a2,0x2
    11a6:	aae60613          	addi	a2,a2,-1362 # 2c50 <malloc+0x546>
    11aa:	00001597          	auipc	a1,0x1
    11ae:	65658593          	addi	a1,a1,1622 # 2800 <malloc+0xf6>
    11b2:	4509                	li	a0,2
    11b4:	470010ef          	jal	2624 <fprintf>
    exit(1);
    11b8:	4505                	li	a0,1
    11ba:	01e010ef          	jal	21d8 <exit>
    11be:	00002517          	auipc	a0,0x2
    11c2:	a5250513          	addi	a0,a0,-1454 # 2c10 <malloc+0x506>
    11c6:	062010ef          	jal	2228 <unlink>
  if (!ok) {
    11ca:	fd55                	bnez	a0,1186 <main+0x9cc>
  check(fstat(fd, &st) == 0 && st.size == (uint64)blocks * BSIZE,
    11cc:	f5040593          	addi	a1,s0,-176
    11d0:	8552                	mv	a0,s4
    11d2:	05e010ef          	jal	2230 <fstat>
    11d6:	e11d                	bnez	a0,11fc <main+0xa42>
  if (!ok) {
    11d8:	f6043703          	ld	a4,-160(s0)
    11dc:	000837b7          	lui	a5,0x83
    11e0:	40078793          	addi	a5,a5,1024 # 83400 <base+0x7d3f0>
    11e4:	00f71c63          	bne	a4,a5,11fc <main+0xa42>
  for (uint first = 0; first < blocks;) {
    11e8:	4a81                	li	s5,0
    check(read(fd, fs_buffer, n * BSIZE) == n * BSIZE, "read full test data");
    11ea:	00003997          	auipc	s3,0x3
    11ee:	e2698993          	addi	s3,s3,-474 # 4010 <fs_buffer>
    11f2:	001b879b          	addiw	a5,s7,1
    11f6:	0ff7fc93          	zext.b	s9,a5
    11fa:	a0dd                	j	12e0 <main+0xb26>
    fprintf(2, "TEST FAILURE: %s\n", why);
    11fc:	00002617          	auipc	a2,0x2
    1200:	a8460613          	addi	a2,a2,-1404 # 2c80 <malloc+0x576>
    1204:	00001597          	auipc	a1,0x1
    1208:	5fc58593          	addi	a1,a1,1532 # 2800 <malloc+0xf6>
    120c:	4509                	li	a0,2
    120e:	416010ef          	jal	2624 <fprintf>
    exit(1);
    1212:	4505                	li	a0,1
    1214:	7c5000ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1218:	00002617          	auipc	a2,0x2
    121c:	a7860613          	addi	a2,a2,-1416 # 2c90 <malloc+0x586>
    1220:	00001597          	auipc	a1,0x1
    1224:	5e058593          	addi	a1,a1,1504 # 2800 <malloc+0xf6>
    1228:	4509                	li	a0,2
    122a:	3fa010ef          	jal	2624 <fprintf>
    exit(1);
    122e:	4505                	li	a0,1
    1230:	7a9000ef          	jal	21d8 <exit>
    return (block >> (8 * byte)) & 255;
    1234:	0037961b          	slliw	a2,a5,0x3
    1238:	00ce563b          	srlw	a2,t3,a2
    123c:	0ff67613          	zext.b	a2,a2
        check((uchar)fs_buffer[b * BSIZE + j] == want, "file contents differ");
    1240:	00b786bb          	addw	a3,a5,a1
    1244:	1682                	slli	a3,a3,0x20
    1246:	9281                	srli	a3,a3,0x20
    1248:	96ce                	add	a3,a3,s3
  if (!ok) {
    124a:	0006c683          	lbu	a3,0(a3)
    124e:	02c69f63          	bne	a3,a2,128c <main+0xad2>
      for (uint j = 0; j < BSIZE; j++) {
    1252:	2785                	addiw	a5,a5,1
    1254:	2745                	addiw	a4,a4,17
    1256:	0ff77713          	zext.b	a4,a4
  if (byte < 4)
    125a:	fcf57de3          	bgeu	a0,a5,1234 <main+0xa7a>
  if (byte == 4)
    125e:	8666                	mv	a2,s9
    1260:	ff0780e3          	beq	a5,a6,1240 <main+0xa86>
        check((uchar)fs_buffer[b * BSIZE + j] == want, "file contents differ");
    1264:	00b7863b          	addw	a2,a5,a1
    1268:	1602                	slli	a2,a2,0x20
    126a:	9201                	srli	a2,a2,0x20
    126c:	964e                	add	a2,a2,s3
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
    126e:	011746b3          	xor	a3,a4,a7
  if (!ok) {
    1272:	00064603          	lbu	a2,0(a2)
    1276:	0ff6f693          	zext.b	a3,a3
    127a:	00d61963          	bne	a2,a3,128c <main+0xad2>
      for (uint j = 0; j < BSIZE; j++) {
    127e:	2785                	addiw	a5,a5,1
    1280:	02678463          	beq	a5,t1,12a8 <main+0xaee>
    1284:	2745                	addiw	a4,a4,17
    1286:	0ff77713          	zext.b	a4,a4
    128a:	bfc1                	j	125a <main+0xaa0>
    fprintf(2, "TEST FAILURE: %s\n", why);
    128c:	00002617          	auipc	a2,0x2
    1290:	a1c60613          	addi	a2,a2,-1508 # 2ca8 <malloc+0x59e>
    1294:	00001597          	auipc	a1,0x1
    1298:	56c58593          	addi	a1,a1,1388 # 2800 <malloc+0xf6>
    129c:	4509                	li	a0,2
    129e:	386010ef          	jal	2624 <fprintf>
    exit(1);
    12a2:	4505                	li	a0,1
    12a4:	735000ef          	jal	21d8 <exit>
    for (uint b = 0; b < n; b++) {
    12a8:	2f05                	addiw	t5,t5,1
    12aa:	f83e8e9b          	addiw	t4,t4,-125
    12ae:	0ffefe93          	zext.b	t4,t4
    12b2:	4005859b          	addiw	a1,a1,1024
    12b6:	018f7f63          	bgeu	t5,s8,12d4 <main+0xb1a>
        uint off = (first + b) * BSIZE + j;
    12ba:	015f0e3b          	addw	t3,t5,s5
    12be:	ef843783          	ld	a5,-264(s0)
    12c2:	00fec8b3          	xor	a7,t4,a5
    12c6:	4701                	li	a4,0
      for (uint j = 0; j < BSIZE; j++) {
    12c8:	4781                	li	a5,0
  return ((block * 131) ^ (byte * 17) ^ (seed * 29) ^ (block >> 8)) & 255;
    12ca:	008e569b          	srliw	a3,t3,0x8
    12ce:	00d8c8b3          	xor	a7,a7,a3
    12d2:	b761                	j	125a <main+0xaa0>
    first += n;
    12d4:	018a8abb          	addw	s5,s5,s8
  for (uint first = 0; first < blocks;) {
    12d8:	20c00793          	li	a5,524
    12dc:	0557e363          	bltu	a5,s5,1322 <main+0xb68>
    uint n = blocks - first;
    12e0:	20d00713          	li	a4,525
    12e4:	4157073b          	subw	a4,a4,s5
    12e8:	87ba                	mv	a5,a4
    if (n > 8)
    12ea:	46a1                	li	a3,8
    12ec:	00e6f363          	bgeu	a3,a4,12f2 <main+0xb38>
    12f0:	47a1                	li	a5,8
    12f2:	00078c1b          	sext.w	s8,a5
    check(read(fd, fs_buffer, n * BSIZE) == n * BSIZE, "read full test data");
    12f6:	00a7961b          	slliw	a2,a5,0xa
    12fa:	8db2                	mv	s11,a2
    12fc:	85ce                	mv	a1,s3
    12fe:	8552                	mv	a0,s4
    1300:	6f1000ef          	jal	21f0 <read>
  if (!ok) {
    1304:	f0ad9ae3          	bne	s11,a0,1218 <main+0xa5e>
    1308:	f8300e93          	li	t4,-125
    130c:	035e8ebb          	mulw	t4,t4,s5
    1310:	0ffefe93          	zext.b	t4,t4
    1314:	4581                	li	a1,0
    for (uint b = 0; b < n; b++) {
    1316:	4f01                	li	t5,0
  if (byte < 4)
    1318:	450d                	li	a0,3
  if (byte == 4)
    131a:	4811                	li	a6,4
      for (uint j = 0; j < BSIZE; j++) {
    131c:	40000313          	li	t1,1024
    1320:	bf69                	j	12ba <main+0xb00>
  check(read(fd, fs_buffer, 1) == 0, "EOF after exact file size");
    1322:	4605                	li	a2,1
    1324:	00003597          	auipc	a1,0x3
    1328:	cec58593          	addi	a1,a1,-788 # 4010 <fs_buffer>
    132c:	8552                	mv	a0,s4
    132e:	6c3000ef          	jal	21f0 <read>
  if (!ok) {
    1332:	ed19                	bnez	a0,1350 <main+0xb96>
      check(close(fd) == 0, "last close");
    1334:	8552                	mv	a0,s4
    1336:	6cb000ef          	jal	2200 <close>
    133a:	e90d                	bnez	a0,136c <main+0xbb2>
  for (int i = 0; i < (mode == 2 ? 4 : 1); i++) {
    133c:	2b75                	addiw	s6,s6,29
    133e:	0ffb7b13          	zext.b	s6,s6
    1342:	ef043783          	ld	a5,-272(s0)
    1346:	1efb8663          	beq	s7,a5,1532 <main+0xd78>
    134a:	7dea                	ld	s11,184(sp)
    134c:	8cbff06f          	j	c16 <main+0x45c>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1350:	00002617          	auipc	a2,0x2
    1354:	97060613          	addi	a2,a2,-1680 # 2cc0 <malloc+0x5b6>
    1358:	00001597          	auipc	a1,0x1
    135c:	4a858593          	addi	a1,a1,1192 # 2800 <malloc+0xf6>
    1360:	4509                	li	a0,2
    1362:	2c2010ef          	jal	2624 <fprintf>
    exit(1);
    1366:	4505                	li	a0,1
    1368:	671000ef          	jal	21d8 <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
    136c:	00002617          	auipc	a2,0x2
    1370:	9f460613          	addi	a2,a2,-1548 # 2d60 <malloc+0x656>
    1374:	00001597          	auipc	a1,0x1
    1378:	48c58593          	addi	a1,a1,1164 # 2800 <malloc+0xf6>
    137c:	4509                	li	a0,2
    137e:	2a6010ef          	jal	2624 <fprintf>
    exit(1);
    1382:	4505                	li	a0,1
    1384:	655000ef          	jal	21d8 <exit>
      check(unlink("fst_part.tmp") == 0, "remove truncated fixture");
    1388:	00002517          	auipc	a0,0x2
    138c:	88850513          	addi	a0,a0,-1912 # 2c10 <malloc+0x506>
    1390:	699000ef          	jal	2228 <unlink>
  if (!ok) {
    1394:	d545                	beqz	a0,133c <main+0xb82>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1396:	00002617          	auipc	a2,0x2
    139a:	9da60613          	addi	a2,a2,-1574 # 2d70 <malloc+0x666>
    139e:	00001597          	auipc	a1,0x1
    13a2:	46258593          	addi	a1,a1,1122 # 2800 <malloc+0xf6>
    13a6:	4509                	li	a0,2
    13a8:	27c010ef          	jal	2624 <fprintf>
    exit(1);
    13ac:	4505                	li	a0,1
    13ae:	62b000ef          	jal	21d8 <exit>
  }
#if defined(SYS_symlink) && defined(O_NOFOLLOW) && defined(T_SYMLINK)
  else {
    check(mkdir("fst_parts.tmp") == 0 && chdir("fst_parts.tmp") == 0,
    13b2:	00002517          	auipc	a0,0x2
    13b6:	9de50513          	addi	a0,a0,-1570 # 2d90 <malloc+0x686>
    13ba:	687000ef          	jal	2240 <mkdir>
    13be:	4781                	li	a5,0
    13c0:	18050263          	beqz	a0,1544 <main+0xd8a>
    13c4:	00002597          	auipc	a1,0x2
    13c8:	9dc58593          	addi	a1,a1,-1572 # 2da0 <malloc+0x696>
    13cc:	853e                	mv	a0,a5
    13ce:	c33fe0ef          	jal	0 <check>
          "isolate symlink subtest");
    if (!strcmp(argv[1], "basic"))
    13d2:	00002597          	auipc	a1,0x2
    13d6:	9e658593          	addi	a1,a1,-1562 # 2db8 <malloc+0x6ae>
    13da:	6488                	ld	a0,8(s1)
    13dc:	377000ef          	jal	1f52 <strcmp>
    13e0:	22051b63          	bnez	a0,1616 <main+0xe5c>
  put("target", 'a');
    13e4:	06100593          	li	a1,97
    13e8:	00002517          	auipc	a0,0x2
    13ec:	ba050513          	addi	a0,a0,-1120 # 2f88 <malloc+0x87e>
    13f0:	c73fe0ef          	jal	62 <put>
  check(symlink("target", "link") == 0, "create symlink");
    13f4:	00002597          	auipc	a1,0x2
    13f8:	9cc58593          	addi	a1,a1,-1588 # 2dc0 <malloc+0x6b6>
    13fc:	00002517          	auipc	a0,0x2
    1400:	b8c50513          	addi	a0,a0,-1140 # 2f88 <malloc+0x87e>
    1404:	68d000ef          	jal	2290 <symlink>
  if (!ok) {
    1408:	14051763          	bnez	a0,1556 <main+0xd9c>
  get("link", 'a');
    140c:	06100593          	li	a1,97
    1410:	00002517          	auipc	a0,0x2
    1414:	9b050513          	addi	a0,a0,-1616 # 2dc0 <malloc+0x6b6>
    1418:	ca5fe0ef          	jal	bc <get>
  check(symlink("/fst_parts.tmp/target", "absolute") == 0, "absolute symlink");
    141c:	00002597          	auipc	a1,0x2
    1420:	9bc58593          	addi	a1,a1,-1604 # 2dd8 <malloc+0x6ce>
    1424:	00002517          	auipc	a0,0x2
    1428:	9c450513          	addi	a0,a0,-1596 # 2de8 <malloc+0x6de>
    142c:	665000ef          	jal	2290 <symlink>
    1430:	14051363          	bnez	a0,1576 <main+0xdbc>
  get("absolute", 'a');
    1434:	06100593          	li	a1,97
    1438:	00002517          	auipc	a0,0x2
    143c:	9a050513          	addi	a0,a0,-1632 # 2dd8 <malloc+0x6ce>
    1440:	c7dfe0ef          	jal	bc <get>
  check(link("link", "hard") == 0, "hard-link symlink inode");
    1444:	00002597          	auipc	a1,0x2
    1448:	9d458593          	addi	a1,a1,-1580 # 2e18 <malloc+0x70e>
    144c:	00002517          	auipc	a0,0x2
    1450:	97450513          	addi	a0,a0,-1676 # 2dc0 <malloc+0x6b6>
    1454:	5e5000ef          	jal	2238 <link>
    1458:	12051f63          	bnez	a0,1596 <main+0xddc>
  get("hard", 'a');
    145c:	06100593          	li	a1,97
    1460:	00002517          	auipc	a0,0x2
    1464:	9b850513          	addi	a0,a0,-1608 # 2e18 <malloc+0x70e>
    1468:	c55fe0ef          	jal	bc <get>
  check(unlink("link") == 0, "unlink link");
    146c:	00002517          	auipc	a0,0x2
    1470:	95450513          	addi	a0,a0,-1708 # 2dc0 <malloc+0x6b6>
    1474:	5b5000ef          	jal	2228 <unlink>
    1478:	12051f63          	bnez	a0,15b6 <main+0xdfc>
  get("target", 'a');
    147c:	06100593          	li	a1,97
    1480:	00002517          	auipc	a0,0x2
    1484:	b0850513          	addi	a0,a0,-1272 # 2f88 <malloc+0x87e>
    1488:	c35fe0ef          	jal	bc <get>
  check(symlink("future", "dangling") == 0, "dangling target allowed");
    148c:	00002597          	auipc	a1,0x2
    1490:	9bc58593          	addi	a1,a1,-1604 # 2e48 <malloc+0x73e>
    1494:	00002517          	auipc	a0,0x2
    1498:	9c450513          	addi	a0,a0,-1596 # 2e58 <malloc+0x74e>
    149c:	5f5000ef          	jal	2290 <symlink>
    14a0:	12051b63          	bnez	a0,15d6 <main+0xe1c>
  unavailable("dangling");
    14a4:	00002517          	auipc	a0,0x2
    14a8:	9a450513          	addi	a0,a0,-1628 # 2e48 <malloc+0x73e>
    14ac:	b77fe0ef          	jal	22 <unavailable>
  put("future", 'b');
    14b0:	06200593          	li	a1,98
    14b4:	00002517          	auipc	a0,0x2
    14b8:	9a450513          	addi	a0,a0,-1628 # 2e58 <malloc+0x74e>
    14bc:	ba7fe0ef          	jal	62 <put>
  get("dangling", 'b');
    14c0:	06200593          	li	a1,98
    14c4:	00002517          	auipc	a0,0x2
    14c8:	98450513          	addi	a0,a0,-1660 # 2e48 <malloc+0x73e>
    14cc:	bf1fe0ef          	jal	bc <get>
  const char *names[] = {"target", "absolute", "hard", "dangling", "future"};
    14d0:	00002797          	auipc	a5,0x2
    14d4:	e1878793          	addi	a5,a5,-488 # 32e8 <malloc+0xbde>
    14d8:	6b8c                	ld	a1,16(a5)
    14da:	6f90                	ld	a2,24(a5)
    14dc:	7394                	ld	a3,32(a5)
    14de:	7798                	ld	a4,40(a5)
    14e0:	f4b43823          	sd	a1,-176(s0)
    14e4:	f4c43c23          	sd	a2,-168(s0)
    14e8:	f6d43023          	sd	a3,-160(s0)
    14ec:	f6e43423          	sd	a4,-152(s0)
    14f0:	7b9c                	ld	a5,48(a5)
    14f2:	f6f43823          	sd	a5,-144(s0)
  for (int i = 0; i < 5; i++)
    14f6:	f5040493          	addi	s1,s0,-176
    14fa:	f7840913          	addi	s2,s0,-136
    check(unlink(names[i]) == 0, "basic cleanup");
    14fe:	6088                	ld	a0,0(s1)
    1500:	529000ef          	jal	2228 <unlink>
    1504:	0e051963          	bnez	a0,15f6 <main+0xe3c>
  for (int i = 0; i < 5; i++)
    1508:	04a1                	addi	s1,s1,8
    150a:	fe991ae3          	bne	s2,s1,14fe <main+0xd44>
      flags();
    else if (!strcmp(argv[1], "validation"))
      validation();
    else
      check(0, "unknown symlink subtest");
    check(chdir("..") == 0 && unlink("fst_parts.tmp") == 0,
    150e:	00002517          	auipc	a0,0x2
    1512:	a8250513          	addi	a0,a0,-1406 # 2f90 <malloc+0x886>
    1516:	533000ef          	jal	2248 <chdir>
    151a:	4781                	li	a5,0
    151c:	1e0503e3          	beqz	a0,1f02 <main+0x1748>
    1520:	00002597          	auipc	a1,0x2
    1524:	d8058593          	addi	a1,a1,-640 # 32a0 <malloc+0xb96>
    1528:	853e                	mv	a0,a5
    152a:	ad7fe0ef          	jal	0 <check>
    152e:	e1ea                	sd	s10,192(sp)
    1530:	fd6e                	sd	s11,184(sp)
  }
#else
  else
    check(0, "symlink support missing");
#endif
  printf("fssubtest: passed\n");
    1532:	00002517          	auipc	a0,0x2
    1536:	d8e50513          	addi	a0,a0,-626 # 32c0 <malloc+0xbb6>
    153a:	114010ef          	jal	264e <printf>
  exit(0);
    153e:	4501                	li	a0,0
    1540:	499000ef          	jal	21d8 <exit>
    check(mkdir("fst_parts.tmp") == 0 && chdir("fst_parts.tmp") == 0,
    1544:	00002517          	auipc	a0,0x2
    1548:	84c50513          	addi	a0,a0,-1972 # 2d90 <malloc+0x686>
    154c:	4fd000ef          	jal	2248 <chdir>
    1550:	00153793          	seqz	a5,a0
    1554:	bd85                	j	13c4 <main+0xc0a>
    1556:	e1ea                	sd	s10,192(sp)
    1558:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    155a:	00002617          	auipc	a2,0x2
    155e:	86e60613          	addi	a2,a2,-1938 # 2dc8 <malloc+0x6be>
    1562:	00001597          	auipc	a1,0x1
    1566:	29e58593          	addi	a1,a1,670 # 2800 <malloc+0xf6>
    156a:	4509                	li	a0,2
    156c:	0b8010ef          	jal	2624 <fprintf>
    exit(1);
    1570:	4505                	li	a0,1
    1572:	467000ef          	jal	21d8 <exit>
    1576:	e1ea                	sd	s10,192(sp)
    1578:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    157a:	00002617          	auipc	a2,0x2
    157e:	88660613          	addi	a2,a2,-1914 # 2e00 <malloc+0x6f6>
    1582:	00001597          	auipc	a1,0x1
    1586:	27e58593          	addi	a1,a1,638 # 2800 <malloc+0xf6>
    158a:	4509                	li	a0,2
    158c:	098010ef          	jal	2624 <fprintf>
    exit(1);
    1590:	4505                	li	a0,1
    1592:	447000ef          	jal	21d8 <exit>
    1596:	e1ea                	sd	s10,192(sp)
    1598:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    159a:	00002617          	auipc	a2,0x2
    159e:	88660613          	addi	a2,a2,-1914 # 2e20 <malloc+0x716>
    15a2:	00001597          	auipc	a1,0x1
    15a6:	25e58593          	addi	a1,a1,606 # 2800 <malloc+0xf6>
    15aa:	4509                	li	a0,2
    15ac:	078010ef          	jal	2624 <fprintf>
    exit(1);
    15b0:	4505                	li	a0,1
    15b2:	427000ef          	jal	21d8 <exit>
    15b6:	e1ea                	sd	s10,192(sp)
    15b8:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    15ba:	00002617          	auipc	a2,0x2
    15be:	87e60613          	addi	a2,a2,-1922 # 2e38 <malloc+0x72e>
    15c2:	00001597          	auipc	a1,0x1
    15c6:	23e58593          	addi	a1,a1,574 # 2800 <malloc+0xf6>
    15ca:	4509                	li	a0,2
    15cc:	058010ef          	jal	2624 <fprintf>
    exit(1);
    15d0:	4505                	li	a0,1
    15d2:	407000ef          	jal	21d8 <exit>
    15d6:	e1ea                	sd	s10,192(sp)
    15d8:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    15da:	00002617          	auipc	a2,0x2
    15de:	88660613          	addi	a2,a2,-1914 # 2e60 <malloc+0x756>
    15e2:	00001597          	auipc	a1,0x1
    15e6:	21e58593          	addi	a1,a1,542 # 2800 <malloc+0xf6>
    15ea:	4509                	li	a0,2
    15ec:	038010ef          	jal	2624 <fprintf>
    exit(1);
    15f0:	4505                	li	a0,1
    15f2:	3e7000ef          	jal	21d8 <exit>
    15f6:	e1ea                	sd	s10,192(sp)
    15f8:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    15fa:	00002617          	auipc	a2,0x2
    15fe:	87e60613          	addi	a2,a2,-1922 # 2e78 <malloc+0x76e>
    1602:	00001597          	auipc	a1,0x1
    1606:	1fe58593          	addi	a1,a1,510 # 2800 <malloc+0xf6>
    160a:	4509                	li	a0,2
    160c:	018010ef          	jal	2624 <fprintf>
    exit(1);
    1610:	4505                	li	a0,1
    1612:	3c7000ef          	jal	21d8 <exit>
    else if (!strcmp(argv[1], "relative"))
    1616:	00002597          	auipc	a1,0x2
    161a:	87258593          	addi	a1,a1,-1934 # 2e88 <malloc+0x77e>
    161e:	6488                	ld	a0,8(s1)
    1620:	133000ef          	jal	1f52 <strcmp>
    1624:	26051e63          	bnez	a0,18a0 <main+0x10e6>
  check(mkdir("a") == 0 && mkdir("b") == 0, "relative directories");
    1628:	00001517          	auipc	a0,0x1
    162c:	2f050513          	addi	a0,a0,752 # 2918 <malloc+0x20e>
    1630:	411000ef          	jal	2240 <mkdir>
    1634:	c10d                	beqz	a0,1656 <main+0xe9c>
    1636:	e1ea                	sd	s10,192(sp)
    1638:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    163a:	00002617          	auipc	a2,0x2
    163e:	86660613          	addi	a2,a2,-1946 # 2ea0 <malloc+0x796>
    1642:	00001597          	auipc	a1,0x1
    1646:	1be58593          	addi	a1,a1,446 # 2800 <malloc+0xf6>
    164a:	4509                	li	a0,2
    164c:	7d9000ef          	jal	2624 <fprintf>
    exit(1);
    1650:	4505                	li	a0,1
    1652:	387000ef          	jal	21d8 <exit>
    1656:	00002517          	auipc	a0,0x2
    165a:	84250513          	addi	a0,a0,-1982 # 2e98 <malloc+0x78e>
    165e:	3e3000ef          	jal	2240 <mkdir>
  if (!ok) {
    1662:	f971                	bnez	a0,1636 <main+0xe7c>
  put("a/file", 'a');
    1664:	06100593          	li	a1,97
    1668:	00002517          	auipc	a0,0x2
    166c:	85050513          	addi	a0,a0,-1968 # 2eb8 <malloc+0x7ae>
    1670:	9f3fe0ef          	jal	62 <put>
  put("b/file", 'b');
    1674:	06200593          	li	a1,98
    1678:	00002517          	auipc	a0,0x2
    167c:	84850513          	addi	a0,a0,-1976 # 2ec0 <malloc+0x7b6>
    1680:	9e3fe0ef          	jal	62 <put>
  check(symlink("file", "a/link") == 0, "relative target");
    1684:	00002597          	auipc	a1,0x2
    1688:	84458593          	addi	a1,a1,-1980 # 2ec8 <malloc+0x7be>
    168c:	00002517          	auipc	a0,0x2
    1690:	84450513          	addi	a0,a0,-1980 # 2ed0 <malloc+0x7c6>
    1694:	3fd000ef          	jal	2290 <symlink>
    1698:	e53d                	bnez	a0,1706 <main+0xf4c>
  get("a/link", 'a');
    169a:	06100593          	li	a1,97
    169e:	00002517          	auipc	a0,0x2
    16a2:	82a50513          	addi	a0,a0,-2006 # 2ec8 <malloc+0x7be>
    16a6:	a17fe0ef          	jal	bc <get>
  check(link("a/link", "b/alias") == 0, "symlink entry alias");
    16aa:	00002597          	auipc	a1,0x2
    16ae:	83e58593          	addi	a1,a1,-1986 # 2ee8 <malloc+0x7de>
    16b2:	00002517          	auipc	a0,0x2
    16b6:	81650513          	addi	a0,a0,-2026 # 2ec8 <malloc+0x7be>
    16ba:	37f000ef          	jal	2238 <link>
    16be:	e525                	bnez	a0,1726 <main+0xf6c>
  get("b/alias", 'b');
    16c0:	06200593          	li	a1,98
    16c4:	00002517          	auipc	a0,0x2
    16c8:	82450513          	addi	a0,a0,-2012 # 2ee8 <malloc+0x7de>
    16cc:	9f1fe0ef          	jal	bc <get>
  check(symlink("file", "b/next") == 0 && symlink("../b/next", "a/cross") == 0,
    16d0:	00002597          	auipc	a1,0x2
    16d4:	83858593          	addi	a1,a1,-1992 # 2f08 <malloc+0x7fe>
    16d8:	00001517          	auipc	a0,0x1
    16dc:	7f850513          	addi	a0,a0,2040 # 2ed0 <malloc+0x7c6>
    16e0:	3b1000ef          	jal	2290 <symlink>
    16e4:	c12d                	beqz	a0,1746 <main+0xf8c>
    16e6:	e1ea                	sd	s10,192(sp)
    16e8:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    16ea:	00002617          	auipc	a2,0x2
    16ee:	83e60613          	addi	a2,a2,-1986 # 2f28 <malloc+0x81e>
    16f2:	00001597          	auipc	a1,0x1
    16f6:	10e58593          	addi	a1,a1,270 # 2800 <malloc+0xf6>
    16fa:	4509                	li	a0,2
    16fc:	729000ef          	jal	2624 <fprintf>
    exit(1);
    1700:	4505                	li	a0,1
    1702:	2d7000ef          	jal	21d8 <exit>
    1706:	e1ea                	sd	s10,192(sp)
    1708:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    170a:	00001617          	auipc	a2,0x1
    170e:	7ce60613          	addi	a2,a2,1998 # 2ed8 <malloc+0x7ce>
    1712:	00001597          	auipc	a1,0x1
    1716:	0ee58593          	addi	a1,a1,238 # 2800 <malloc+0xf6>
    171a:	4509                	li	a0,2
    171c:	709000ef          	jal	2624 <fprintf>
    exit(1);
    1720:	4505                	li	a0,1
    1722:	2b7000ef          	jal	21d8 <exit>
    1726:	e1ea                	sd	s10,192(sp)
    1728:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    172a:	00001617          	auipc	a2,0x1
    172e:	7c660613          	addi	a2,a2,1990 # 2ef0 <malloc+0x7e6>
    1732:	00001597          	auipc	a1,0x1
    1736:	0ce58593          	addi	a1,a1,206 # 2800 <malloc+0xf6>
    173a:	4509                	li	a0,2
    173c:	6e9000ef          	jal	2624 <fprintf>
    exit(1);
    1740:	4505                	li	a0,1
    1742:	297000ef          	jal	21d8 <exit>
    1746:	00001597          	auipc	a1,0x1
    174a:	7ca58593          	addi	a1,a1,1994 # 2f10 <malloc+0x806>
    174e:	00001517          	auipc	a0,0x1
    1752:	7ca50513          	addi	a0,a0,1994 # 2f18 <malloc+0x80e>
    1756:	33b000ef          	jal	2290 <symlink>
  if (!ok) {
    175a:	f551                	bnez	a0,16e6 <main+0xf2c>
  get("a/cross", 'b');
    175c:	06200593          	li	a1,98
    1760:	00001517          	auipc	a0,0x1
    1764:	7b050513          	addi	a0,a0,1968 # 2f10 <malloc+0x806>
    1768:	955fe0ef          	jal	bc <get>
  check(chdir("b") == 0, "different caller directory");
    176c:	00001517          	auipc	a0,0x1
    1770:	72c50513          	addi	a0,a0,1836 # 2e98 <malloc+0x78e>
    1774:	2d5000ef          	jal	2248 <chdir>
    1778:	e13d                	bnez	a0,17de <main+0x1024>
  get("../a/link", 'a');
    177a:	06100593          	li	a1,97
    177e:	00001517          	auipc	a0,0x1
    1782:	7e250513          	addi	a0,a0,2018 # 2f60 <malloc+0x856>
    1786:	937fe0ef          	jal	bc <get>
  check(symlink("../a/file", "up") == 0, "dot-dot target");
    178a:	00001597          	auipc	a1,0x1
    178e:	44e58593          	addi	a1,a1,1102 # 2bd8 <malloc+0x4ce>
    1792:	00001517          	auipc	a0,0x1
    1796:	7de50513          	addi	a0,a0,2014 # 2f70 <malloc+0x866>
    179a:	2f7000ef          	jal	2290 <symlink>
    179e:	e125                	bnez	a0,17fe <main+0x1044>
  get("up", 'a');
    17a0:	06100593          	li	a1,97
    17a4:	00001517          	auipc	a0,0x1
    17a8:	43450513          	addi	a0,a0,1076 # 2bd8 <malloc+0x4ce>
    17ac:	911fe0ef          	jal	bc <get>
  check(unlink("up") == 0 && chdir("..") == 0, "return to fixture directory");
    17b0:	00001517          	auipc	a0,0x1
    17b4:	42850513          	addi	a0,a0,1064 # 2bd8 <malloc+0x4ce>
    17b8:	271000ef          	jal	2228 <unlink>
    17bc:	c12d                	beqz	a0,181e <main+0x1064>
    17be:	e1ea                	sd	s10,192(sp)
    17c0:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    17c2:	00001617          	auipc	a2,0x1
    17c6:	7d660613          	addi	a2,a2,2006 # 2f98 <malloc+0x88e>
    17ca:	00001597          	auipc	a1,0x1
    17ce:	03658593          	addi	a1,a1,54 # 2800 <malloc+0xf6>
    17d2:	4509                	li	a0,2
    17d4:	651000ef          	jal	2624 <fprintf>
    exit(1);
    17d8:	4505                	li	a0,1
    17da:	1ff000ef          	jal	21d8 <exit>
    17de:	e1ea                	sd	s10,192(sp)
    17e0:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    17e2:	00001617          	auipc	a2,0x1
    17e6:	75e60613          	addi	a2,a2,1886 # 2f40 <malloc+0x836>
    17ea:	00001597          	auipc	a1,0x1
    17ee:	01658593          	addi	a1,a1,22 # 2800 <malloc+0xf6>
    17f2:	4509                	li	a0,2
    17f4:	631000ef          	jal	2624 <fprintf>
    exit(1);
    17f8:	4505                	li	a0,1
    17fa:	1df000ef          	jal	21d8 <exit>
    17fe:	e1ea                	sd	s10,192(sp)
    1800:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1802:	00001617          	auipc	a2,0x1
    1806:	77e60613          	addi	a2,a2,1918 # 2f80 <malloc+0x876>
    180a:	00001597          	auipc	a1,0x1
    180e:	ff658593          	addi	a1,a1,-10 # 2800 <malloc+0xf6>
    1812:	4509                	li	a0,2
    1814:	611000ef          	jal	2624 <fprintf>
    exit(1);
    1818:	4505                	li	a0,1
    181a:	1bf000ef          	jal	21d8 <exit>
    181e:	00001517          	auipc	a0,0x1
    1822:	77250513          	addi	a0,a0,1906 # 2f90 <malloc+0x886>
    1826:	223000ef          	jal	2248 <chdir>
  if (!ok) {
    182a:	f951                	bnez	a0,17be <main+0x1004>
  const char *names[] = {"a/link", "b/alias", "a/cross", "b/next",
    182c:	00002797          	auipc	a5,0x2
    1830:	abc78793          	addi	a5,a5,-1348 # 32e8 <malloc+0xbde>
    1834:	0387b883          	ld	a7,56(a5)
    1838:	0407b803          	ld	a6,64(a5)
    183c:	67a8                	ld	a0,72(a5)
    183e:	6bac                	ld	a1,80(a5)
    1840:	6fb0                	ld	a2,88(a5)
    1842:	73b4                	ld	a3,96(a5)
    1844:	77b8                	ld	a4,104(a5)
    1846:	f5143823          	sd	a7,-176(s0)
    184a:	f5043c23          	sd	a6,-168(s0)
    184e:	f6a43023          	sd	a0,-160(s0)
    1852:	f6b43423          	sd	a1,-152(s0)
    1856:	f6c43823          	sd	a2,-144(s0)
    185a:	f6d43c23          	sd	a3,-136(s0)
    185e:	f8e43023          	sd	a4,-128(s0)
    1862:	7bbc                	ld	a5,112(a5)
    1864:	f8f43423          	sd	a5,-120(s0)
  for (int i = 0; i < 8; i++)
    1868:	f5040493          	addi	s1,s0,-176
    check(unlink(names[i]) == 0, "relative cleanup");
    186c:	6088                	ld	a0,0(s1)
    186e:	1bb000ef          	jal	2228 <unlink>
    1872:	e519                	bnez	a0,1880 <main+0x10c6>
  for (int i = 0; i < 8; i++)
    1874:	04a1                	addi	s1,s1,8
    1876:	f9040793          	addi	a5,s0,-112
    187a:	fe9799e3          	bne	a5,s1,186c <main+0x10b2>
    187e:	b941                	j	150e <main+0xd54>
    1880:	e1ea                	sd	s10,192(sp)
    1882:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1884:	00001617          	auipc	a2,0x1
    1888:	73460613          	addi	a2,a2,1844 # 2fb8 <malloc+0x8ae>
    188c:	00001597          	auipc	a1,0x1
    1890:	f7458593          	addi	a1,a1,-140 # 2800 <malloc+0xf6>
    1894:	4509                	li	a0,2
    1896:	58f000ef          	jal	2624 <fprintf>
    exit(1);
    189a:	4505                	li	a0,1
    189c:	13d000ef          	jal	21d8 <exit>
    else if (!strcmp(argv[1], "chains"))
    18a0:	00001597          	auipc	a1,0x1
    18a4:	73058593          	addi	a1,a1,1840 # 2fd0 <malloc+0x8c6>
    18a8:	6488                	ld	a0,8(s1)
    18aa:	6a8000ef          	jal	1f52 <strcmp>
    18ae:	892a                	mv	s2,a0
    18b0:	20051163          	bnez	a0,1ab2 <main+0x12f8>
  put("target", 'a');
    18b4:	06100593          	li	a1,97
    18b8:	00001517          	auipc	a0,0x1
    18bc:	6d050513          	addi	a0,a0,1744 # 2f88 <malloc+0x87e>
    18c0:	fa2fe0ef          	jal	62 <put>
  char previous[14] = "target", name[] = "chain00";
    18c4:	00002797          	auipc	a5,0x2
    18c8:	a2478793          	addi	a5,a5,-1500 # 32e8 <malloc+0xbde>
    18cc:	5fb8                	lw	a4,120(a5)
    18ce:	f4e42823          	sw	a4,-176(s0)
    18d2:	07c7d703          	lhu	a4,124(a5)
    18d6:	f4e41a23          	sh	a4,-172(s0)
    18da:	07e7c783          	lbu	a5,126(a5)
    18de:	f4f40b23          	sb	a5,-170(s0)
    18e2:	461d                	li	a2,7
    18e4:	4581                	li	a1,0
    18e6:	f5740513          	addi	a0,s0,-169
    18ea:	6c4000ef          	jal	1fae <memset>
    18ee:	00002797          	auipc	a5,0x2
    18f2:	9ea7b783          	ld	a5,-1558(a5) # 32d8 <malloc+0xbce>
    18f6:	f2f43c23          	sd	a5,-200(s0)
    name[5] = '0' + i / 10;
    18fa:	4a29                	li	s4,10
    check(symlink(previous, name) == 0, "create chain");
    18fc:	f3840993          	addi	s3,s0,-200
    1900:	f5040493          	addi	s1,s0,-176
  for (int i = 0; i < 11; i++) {
    1904:	4aad                	li	s5,11
    name[5] = '0' + i / 10;
    1906:	034947bb          	divw	a5,s2,s4
    190a:	0307879b          	addiw	a5,a5,48
    190e:	f2f40ea3          	sb	a5,-195(s0)
    name[6] = '0' + i % 10;
    1912:	034967bb          	remw	a5,s2,s4
    1916:	0307879b          	addiw	a5,a5,48
    191a:	f2f40f23          	sb	a5,-194(s0)
    check(symlink(previous, name) == 0, "create chain");
    191e:	85ce                	mv	a1,s3
    1920:	8526                	mv	a0,s1
    1922:	16f000ef          	jal	2290 <symlink>
  if (!ok) {
    1926:	ed3d                	bnez	a0,19a4 <main+0x11ea>
    strcpy(previous, name);
    1928:	85ce                	mv	a1,s3
    192a:	8526                	mv	a0,s1
    192c:	606000ef          	jal	1f32 <strcpy>
  for (int i = 0; i < 11; i++) {
    1930:	2905                	addiw	s2,s2,1
    1932:	fd591ae3          	bne	s2,s5,1906 <main+0x114c>
  get("chain09", 'a');
    1936:	06100593          	li	a1,97
    193a:	00001517          	auipc	a0,0x1
    193e:	6ae50513          	addi	a0,a0,1710 # 2fe8 <malloc+0x8de>
    1942:	f7afe0ef          	jal	bc <get>
  unavailable("chain10");
    1946:	00001517          	auipc	a0,0x1
    194a:	6aa50513          	addi	a0,a0,1706 # 2ff0 <malloc+0x8e6>
    194e:	ed4fe0ef          	jal	22 <unavailable>
  check(symlink("self", "self") == 0, "self cycle");
    1952:	00001597          	auipc	a1,0x1
    1956:	6a658593          	addi	a1,a1,1702 # 2ff8 <malloc+0x8ee>
    195a:	852e                	mv	a0,a1
    195c:	135000ef          	jal	2290 <symlink>
    1960:	e135                	bnez	a0,19c4 <main+0x120a>
  unavailable("self");
    1962:	00001517          	auipc	a0,0x1
    1966:	69650513          	addi	a0,a0,1686 # 2ff8 <malloc+0x8ee>
    196a:	eb8fe0ef          	jal	22 <unavailable>
  check(symlink("loopb", "loopa") == 0 && symlink("loopa", "loopb") == 0,
    196e:	00001597          	auipc	a1,0x1
    1972:	6a258593          	addi	a1,a1,1698 # 3010 <malloc+0x906>
    1976:	00001517          	auipc	a0,0x1
    197a:	6a250513          	addi	a0,a0,1698 # 3018 <malloc+0x90e>
    197e:	113000ef          	jal	2290 <symlink>
    1982:	c12d                	beqz	a0,19e4 <main+0x122a>
    1984:	e1ea                	sd	s10,192(sp)
    1986:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1988:	00001617          	auipc	a2,0x1
    198c:	69860613          	addi	a2,a2,1688 # 3020 <malloc+0x916>
    1990:	00001597          	auipc	a1,0x1
    1994:	e7058593          	addi	a1,a1,-400 # 2800 <malloc+0xf6>
    1998:	4509                	li	a0,2
    199a:	48b000ef          	jal	2624 <fprintf>
    exit(1);
    199e:	4505                	li	a0,1
    19a0:	039000ef          	jal	21d8 <exit>
    19a4:	e1ea                	sd	s10,192(sp)
    19a6:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    19a8:	00001617          	auipc	a2,0x1
    19ac:	63060613          	addi	a2,a2,1584 # 2fd8 <malloc+0x8ce>
    19b0:	00001597          	auipc	a1,0x1
    19b4:	e5058593          	addi	a1,a1,-432 # 2800 <malloc+0xf6>
    19b8:	4509                	li	a0,2
    19ba:	46b000ef          	jal	2624 <fprintf>
    exit(1);
    19be:	4505                	li	a0,1
    19c0:	019000ef          	jal	21d8 <exit>
    19c4:	e1ea                	sd	s10,192(sp)
    19c6:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    19c8:	00001617          	auipc	a2,0x1
    19cc:	63860613          	addi	a2,a2,1592 # 3000 <malloc+0x8f6>
    19d0:	00001597          	auipc	a1,0x1
    19d4:	e3058593          	addi	a1,a1,-464 # 2800 <malloc+0xf6>
    19d8:	4509                	li	a0,2
    19da:	44b000ef          	jal	2624 <fprintf>
    exit(1);
    19de:	4505                	li	a0,1
    19e0:	7f8000ef          	jal	21d8 <exit>
    19e4:	00001597          	auipc	a1,0x1
    19e8:	63458593          	addi	a1,a1,1588 # 3018 <malloc+0x90e>
    19ec:	00001517          	auipc	a0,0x1
    19f0:	62450513          	addi	a0,a0,1572 # 3010 <malloc+0x906>
    19f4:	09d000ef          	jal	2290 <symlink>
    19f8:	84aa                	mv	s1,a0
  if (!ok) {
    19fa:	f549                	bnez	a0,1984 <main+0x11ca>
  unavailable("loopa");
    19fc:	00001517          	auipc	a0,0x1
    1a00:	61450513          	addi	a0,a0,1556 # 3010 <malloc+0x906>
    1a04:	e1efe0ef          	jal	22 <unavailable>
    name[5] = '0' + i / 10;
    1a08:	4929                	li	s2,10
    check(unlink(name) == 0, "chain cleanup");
    1a0a:	f3840a13          	addi	s4,s0,-200
  for (int i = 0; i < 11; i++) {
    1a0e:	49ad                	li	s3,11
    name[5] = '0' + i / 10;
    1a10:	0324c7bb          	divw	a5,s1,s2
    1a14:	0307879b          	addiw	a5,a5,48
    1a18:	f2f40ea3          	sb	a5,-195(s0)
    name[6] = '0' + i % 10;
    1a1c:	0324e7bb          	remw	a5,s1,s2
    1a20:	0307879b          	addiw	a5,a5,48
    1a24:	f2f40f23          	sb	a5,-194(s0)
    check(unlink(name) == 0, "chain cleanup");
    1a28:	8552                	mv	a0,s4
    1a2a:	7fe000ef          	jal	2228 <unlink>
    1a2e:	e91d                	bnez	a0,1a64 <main+0x12aa>
  for (int i = 0; i < 11; i++) {
    1a30:	2485                	addiw	s1,s1,1
    1a32:	fd349fe3          	bne	s1,s3,1a10 <main+0x1256>
  check(unlink("target") == 0 && unlink("self") == 0 && unlink("loopa") == 0 &&
    1a36:	00001517          	auipc	a0,0x1
    1a3a:	55250513          	addi	a0,a0,1362 # 2f88 <malloc+0x87e>
    1a3e:	7ea000ef          	jal	2228 <unlink>
    1a42:	c129                	beqz	a0,1a84 <main+0x12ca>
    1a44:	e1ea                	sd	s10,192(sp)
    1a46:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1a48:	00001617          	auipc	a2,0x1
    1a4c:	5f860613          	addi	a2,a2,1528 # 3040 <malloc+0x936>
    1a50:	00001597          	auipc	a1,0x1
    1a54:	db058593          	addi	a1,a1,-592 # 2800 <malloc+0xf6>
    1a58:	4509                	li	a0,2
    1a5a:	3cb000ef          	jal	2624 <fprintf>
    exit(1);
    1a5e:	4505                	li	a0,1
    1a60:	778000ef          	jal	21d8 <exit>
    1a64:	e1ea                	sd	s10,192(sp)
    1a66:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1a68:	00001617          	auipc	a2,0x1
    1a6c:	5c860613          	addi	a2,a2,1480 # 3030 <malloc+0x926>
    1a70:	00001597          	auipc	a1,0x1
    1a74:	d9058593          	addi	a1,a1,-624 # 2800 <malloc+0xf6>
    1a78:	4509                	li	a0,2
    1a7a:	3ab000ef          	jal	2624 <fprintf>
    exit(1);
    1a7e:	4505                	li	a0,1
    1a80:	758000ef          	jal	21d8 <exit>
    1a84:	00001517          	auipc	a0,0x1
    1a88:	57450513          	addi	a0,a0,1396 # 2ff8 <malloc+0x8ee>
    1a8c:	79c000ef          	jal	2228 <unlink>
    1a90:	f955                	bnez	a0,1a44 <main+0x128a>
    1a92:	00001517          	auipc	a0,0x1
    1a96:	57e50513          	addi	a0,a0,1406 # 3010 <malloc+0x906>
    1a9a:	78e000ef          	jal	2228 <unlink>
    1a9e:	f15d                	bnez	a0,1a44 <main+0x128a>
          unlink("loopb") == 0,
    1aa0:	00001517          	auipc	a0,0x1
    1aa4:	57850513          	addi	a0,a0,1400 # 3018 <malloc+0x90e>
    1aa8:	780000ef          	jal	2228 <unlink>
  if (!ok) {
    1aac:	a60501e3          	beqz	a0,150e <main+0xd54>
    1ab0:	bf51                	j	1a44 <main+0x128a>
    else if (!strcmp(argv[1], "flags"))
    1ab2:	00001597          	auipc	a1,0x1
    1ab6:	59e58593          	addi	a1,a1,1438 # 3050 <malloc+0x946>
    1aba:	6488                	ld	a0,8(s1)
    1abc:	496000ef          	jal	1f52 <strcmp>
    1ac0:	40051c63          	bnez	a0,1ed8 <main+0x171e>
  int fd = open("edge_target", O_CREATE | O_RDWR | O_TRUNC);
    1ac4:	60200593          	li	a1,1538
    1ac8:	00001517          	auipc	a0,0x1
    1acc:	59050513          	addi	a0,a0,1424 # 3058 <malloc+0x94e>
    1ad0:	748000ef          	jal	2218 <open>
    1ad4:	84aa                	mv	s1,a0
  check(fd >= 0 && write(fd, "hello", 5) == 5 && close(fd) == 0,
    1ad6:	02055263          	bgez	a0,1afa <main+0x1340>
    1ada:	e1ea                	sd	s10,192(sp)
    1adc:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1ade:	00001617          	auipc	a2,0x1
    1ae2:	59260613          	addi	a2,a2,1426 # 3070 <malloc+0x966>
    1ae6:	00001597          	auipc	a1,0x1
    1aea:	d1a58593          	addi	a1,a1,-742 # 2800 <malloc+0xf6>
    1aee:	4509                	li	a0,2
    1af0:	335000ef          	jal	2624 <fprintf>
    exit(1);
    1af4:	4505                	li	a0,1
    1af6:	6e2000ef          	jal	21d8 <exit>
    1afa:	4615                	li	a2,5
    1afc:	00001597          	auipc	a1,0x1
    1b00:	56c58593          	addi	a1,a1,1388 # 3068 <malloc+0x95e>
    1b04:	6f4000ef          	jal	21f8 <write>
    1b08:	4795                	li	a5,5
    1b0a:	fcf518e3          	bne	a0,a5,1ada <main+0x1320>
    1b0e:	8526                	mv	a0,s1
    1b10:	6f0000ef          	jal	2200 <close>
  if (!ok) {
    1b14:	f179                	bnez	a0,1ada <main+0x1320>
  check(symlink("edge_target", "edge_link") == 0, "create edge-case link");
    1b16:	00001597          	auipc	a1,0x1
    1b1a:	57258593          	addi	a1,a1,1394 # 3088 <malloc+0x97e>
    1b1e:	00001517          	auipc	a0,0x1
    1b22:	53a50513          	addi	a0,a0,1338 # 3058 <malloc+0x94e>
    1b26:	76a000ef          	jal	2290 <symlink>
    1b2a:	e915                	bnez	a0,1b5e <main+0x13a4>
  check(stat("edge_target", &targetstat) == 0 &&
    1b2c:	f3840593          	addi	a1,s0,-200
    1b30:	00001517          	auipc	a0,0x1
    1b34:	52850513          	addi	a0,a0,1320 # 3058 <malloc+0x94e>
    1b38:	53e000ef          	jal	2076 <stat>
    1b3c:	c129                	beqz	a0,1b7e <main+0x13c4>
    1b3e:	e1ea                	sd	s10,192(sp)
    1b40:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1b42:	00001617          	auipc	a2,0x1
    1b46:	2de60613          	addi	a2,a2,734 # 2e20 <malloc+0x716>
    1b4a:	00001597          	auipc	a1,0x1
    1b4e:	cb658593          	addi	a1,a1,-842 # 2800 <malloc+0xf6>
    1b52:	4509                	li	a0,2
    1b54:	2d1000ef          	jal	2624 <fprintf>
    exit(1);
    1b58:	4505                	li	a0,1
    1b5a:	67e000ef          	jal	21d8 <exit>
    1b5e:	e1ea                	sd	s10,192(sp)
    1b60:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1b62:	00001617          	auipc	a2,0x1
    1b66:	53660613          	addi	a2,a2,1334 # 3098 <malloc+0x98e>
    1b6a:	00001597          	auipc	a1,0x1
    1b6e:	c9658593          	addi	a1,a1,-874 # 2800 <malloc+0xf6>
    1b72:	4509                	li	a0,2
    1b74:	2b1000ef          	jal	2624 <fprintf>
    exit(1);
    1b78:	4505                	li	a0,1
    1b7a:	65e000ef          	jal	21d8 <exit>
          link("edge_link", "edge_hard") == 0,
    1b7e:	00001597          	auipc	a1,0x1
    1b82:	53258593          	addi	a1,a1,1330 # 30b0 <malloc+0x9a6>
    1b86:	00001517          	auipc	a0,0x1
    1b8a:	50250513          	addi	a0,a0,1282 # 3088 <malloc+0x97e>
    1b8e:	6aa000ef          	jal	2238 <link>
  if (!ok) {
    1b92:	f555                	bnez	a0,1b3e <main+0x1384>
  fd = open("edge_link", O_RDONLY | O_NOFOLLOW);
    1b94:	6485                	lui	s1,0x1
    1b96:	80048593          	addi	a1,s1,-2048 # 800 <main+0x46>
    1b9a:	00001517          	auipc	a0,0x1
    1b9e:	4ee50513          	addi	a0,a0,1262 # 3088 <malloc+0x97e>
    1ba2:	676000ef          	jal	2218 <open>
    1ba6:	892a                	mv	s2,a0
  int hardfd = open("edge_hard", O_RDONLY | O_NOFOLLOW);
    1ba8:	80048593          	addi	a1,s1,-2048
    1bac:	00001517          	auipc	a0,0x1
    1bb0:	50450513          	addi	a0,a0,1284 # 30b0 <malloc+0x9a6>
    1bb4:	664000ef          	jal	2218 <open>
    1bb8:	84aa                	mv	s1,a0
  check(fd >= 0 && hardfd >= 0 && fstat(fd, &linkstat) == 0 &&
    1bba:	00a967b3          	or	a5,s2,a0
    1bbe:	02079713          	slli	a4,a5,0x20
    1bc2:	02075263          	bgez	a4,1be6 <main+0x142c>
    1bc6:	e1ea                	sd	s10,192(sp)
    1bc8:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1bca:	00001617          	auipc	a2,0x1
    1bce:	4f660613          	addi	a2,a2,1270 # 30c0 <malloc+0x9b6>
    1bd2:	00001597          	auipc	a1,0x1
    1bd6:	c2e58593          	addi	a1,a1,-978 # 2800 <malloc+0xf6>
    1bda:	4509                	li	a0,2
    1bdc:	249000ef          	jal	2624 <fprintf>
    exit(1);
    1be0:	4505                	li	a0,1
    1be2:	5f6000ef          	jal	21d8 <exit>
    1be6:	f0840593          	addi	a1,s0,-248
    1bea:	854a                	mv	a0,s2
    1bec:	644000ef          	jal	2230 <fstat>
    1bf0:	f979                	bnez	a0,1bc6 <main+0x140c>
          fstat(hardfd, &hardstat) == 0 && linkstat.type == T_SYMLINK &&
    1bf2:	f2040593          	addi	a1,s0,-224
    1bf6:	8526                	mv	a0,s1
    1bf8:	638000ef          	jal	2230 <fstat>
  check(fd >= 0 && hardfd >= 0 && fstat(fd, &linkstat) == 0 &&
    1bfc:	f569                	bnez	a0,1bc6 <main+0x140c>
          fstat(hardfd, &hardstat) == 0 && linkstat.type == T_SYMLINK &&
    1bfe:	f1041703          	lh	a4,-240(s0)
    1c02:	4791                	li	a5,4
    1c04:	fcf711e3          	bne	a4,a5,1bc6 <main+0x140c>
          linkstat.ino != targetstat.ino && linkstat.ino == hardstat.ino,
    1c08:	f0c42783          	lw	a5,-244(s0)
          fstat(hardfd, &hardstat) == 0 && linkstat.type == T_SYMLINK &&
    1c0c:	f3c42703          	lw	a4,-196(s0)
    1c10:	faf70be3          	beq	a4,a5,1bc6 <main+0x140c>
  if (!ok) {
    1c14:	f2442703          	lw	a4,-220(s0)
    1c18:	faf717e3          	bne	a4,a5,1bc6 <main+0x140c>
  check(close(fd) == 0 && close(hardfd) == 0 && unlink("edge_hard") == 0,
    1c1c:	854a                	mv	a0,s2
    1c1e:	5e2000ef          	jal	2200 <close>
    1c22:	c10d                	beqz	a0,1c44 <main+0x148a>
    1c24:	e1ea                	sd	s10,192(sp)
    1c26:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1c28:	00001617          	auipc	a2,0x1
    1c2c:	4d860613          	addi	a2,a2,1240 # 3100 <malloc+0x9f6>
    1c30:	00001597          	auipc	a1,0x1
    1c34:	bd058593          	addi	a1,a1,-1072 # 2800 <malloc+0xf6>
    1c38:	4509                	li	a0,2
    1c3a:	1eb000ef          	jal	2624 <fprintf>
    exit(1);
    1c3e:	4505                	li	a0,1
    1c40:	598000ef          	jal	21d8 <exit>
    1c44:	8526                	mv	a0,s1
    1c46:	5ba000ef          	jal	2200 <close>
    1c4a:	fd69                	bnez	a0,1c24 <main+0x146a>
    1c4c:	00001517          	auipc	a0,0x1
    1c50:	46450513          	addi	a0,a0,1124 # 30b0 <malloc+0x9a6>
    1c54:	5d4000ef          	jal	2228 <unlink>
  if (!ok) {
    1c58:	f571                	bnez	a0,1c24 <main+0x146a>
  fd = open("edge_link", O_RDONLY | O_NOFOLLOW | O_TRUNC);
    1c5a:	6585                	lui	a1,0x1
    1c5c:	c0058593          	addi	a1,a1,-1024 # c00 <main+0x446>
    1c60:	00001517          	auipc	a0,0x1
    1c64:	42850513          	addi	a0,a0,1064 # 3088 <malloc+0x97e>
    1c68:	5b0000ef          	jal	2218 <open>
    1c6c:	84aa                	mv	s1,a0
  check(fd >= 0 && read(fd, fs_buffer, 32) == sizeof("edge_target") &&
    1c6e:	02055263          	bgez	a0,1c92 <main+0x14d8>
    1c72:	e1ea                	sd	s10,192(sp)
    1c74:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1c76:	00001617          	auipc	a2,0x1
    1c7a:	4a260613          	addi	a2,a2,1186 # 3118 <malloc+0xa0e>
    1c7e:	00001597          	auipc	a1,0x1
    1c82:	b8258593          	addi	a1,a1,-1150 # 2800 <malloc+0xf6>
    1c86:	4509                	li	a0,2
    1c88:	19d000ef          	jal	2624 <fprintf>
    exit(1);
    1c8c:	4505                	li	a0,1
    1c8e:	54a000ef          	jal	21d8 <exit>
    1c92:	02000613          	li	a2,32
    1c96:	00002597          	auipc	a1,0x2
    1c9a:	37a58593          	addi	a1,a1,890 # 4010 <fs_buffer>
    1c9e:	552000ef          	jal	21f0 <read>
    1ca2:	47b1                	li	a5,12
    1ca4:	fcf517e3          	bne	a0,a5,1c72 <main+0x14b8>
          memcmp(fs_buffer, "edge_target", sizeof("edge_target")) == 0 &&
    1ca8:	862a                	mv	a2,a0
    1caa:	00001597          	auipc	a1,0x1
    1cae:	3ae58593          	addi	a1,a1,942 # 3058 <malloc+0x94e>
    1cb2:	00002517          	auipc	a0,0x2
    1cb6:	35e50513          	addi	a0,a0,862 # 4010 <fs_buffer>
    1cba:	4a0000ef          	jal	215a <memcmp>
  check(fd >= 0 && read(fd, fs_buffer, 32) == sizeof("edge_target") &&
    1cbe:	f955                	bnez	a0,1c72 <main+0x14b8>
          close(fd) == 0,
    1cc0:	8526                	mv	a0,s1
    1cc2:	53e000ef          	jal	2200 <close>
  if (!ok) {
    1cc6:	f555                	bnez	a0,1c72 <main+0x14b8>
  fd = open("edge_link", O_WRONLY | O_NOFOLLOW);
    1cc8:	6585                	lui	a1,0x1
    1cca:	80158593          	addi	a1,a1,-2047 # 801 <main+0x47>
    1cce:	00001517          	auipc	a0,0x1
    1cd2:	3ba50513          	addi	a0,a0,954 # 3088 <malloc+0x97e>
    1cd6:	542000ef          	jal	2218 <open>
    1cda:	84aa                	mv	s1,a0
  check(fd >= 0 && read(fd, fs_buffer, 1) == -1 && close(fd) == 0,
    1cdc:	02055263          	bgez	a0,1d00 <main+0x1546>
    1ce0:	e1ea                	sd	s10,192(sp)
    1ce2:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1ce4:	00001617          	auipc	a2,0x1
    1ce8:	46460613          	addi	a2,a2,1124 # 3148 <malloc+0xa3e>
    1cec:	00001597          	auipc	a1,0x1
    1cf0:	b1458593          	addi	a1,a1,-1260 # 2800 <malloc+0xf6>
    1cf4:	4509                	li	a0,2
    1cf6:	12f000ef          	jal	2624 <fprintf>
    exit(1);
    1cfa:	4505                	li	a0,1
    1cfc:	4dc000ef          	jal	21d8 <exit>
    1d00:	4605                	li	a2,1
    1d02:	00002597          	auipc	a1,0x2
    1d06:	30e58593          	addi	a1,a1,782 # 4010 <fs_buffer>
    1d0a:	4e6000ef          	jal	21f0 <read>
    1d0e:	57fd                	li	a5,-1
    1d10:	fcf518e3          	bne	a0,a5,1ce0 <main+0x1526>
    1d14:	8526                	mv	a0,s1
    1d16:	4ea000ef          	jal	2200 <close>
  if (!ok) {
    1d1a:	f179                	bnez	a0,1ce0 <main+0x1526>
  fd = open("edge_link", O_RDONLY | O_NOFOLLOW);
    1d1c:	6585                	lui	a1,0x1
    1d1e:	80058593          	addi	a1,a1,-2048 # 800 <main+0x46>
    1d22:	00001517          	auipc	a0,0x1
    1d26:	36650513          	addi	a0,a0,870 # 3088 <malloc+0x97e>
    1d2a:	4ee000ef          	jal	2218 <open>
    1d2e:	84aa                	mv	s1,a0
  check(fd >= 0 && write(fd, "x", 1) == -1 && close(fd) == 0,
    1d30:	02055263          	bgez	a0,1d54 <main+0x159a>
    1d34:	e1ea                	sd	s10,192(sp)
    1d36:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1d38:	00001617          	auipc	a2,0x1
    1d3c:	44860613          	addi	a2,a2,1096 # 3180 <malloc+0xa76>
    1d40:	00001597          	auipc	a1,0x1
    1d44:	ac058593          	addi	a1,a1,-1344 # 2800 <malloc+0xf6>
    1d48:	4509                	li	a0,2
    1d4a:	0db000ef          	jal	2624 <fprintf>
    exit(1);
    1d4e:	4505                	li	a0,1
    1d50:	488000ef          	jal	21d8 <exit>
    1d54:	4605                	li	a2,1
    1d56:	00001597          	auipc	a1,0x1
    1d5a:	42258593          	addi	a1,a1,1058 # 3178 <malloc+0xa6e>
    1d5e:	49a000ef          	jal	21f8 <write>
    1d62:	57fd                	li	a5,-1
    1d64:	fcf518e3          	bne	a0,a5,1d34 <main+0x157a>
    1d68:	8526                	mv	a0,s1
    1d6a:	496000ef          	jal	2200 <close>
  if (!ok) {
    1d6e:	f179                	bnez	a0,1d34 <main+0x157a>
  fd = open("edge_link", O_WRONLY | O_TRUNC);
    1d70:	40100593          	li	a1,1025
    1d74:	00001517          	auipc	a0,0x1
    1d78:	31450513          	addi	a0,a0,788 # 3088 <malloc+0x97e>
    1d7c:	49c000ef          	jal	2218 <open>
  check(fd >= 0 && close(fd) == 0, "truncate followed regular file");
    1d80:	02055263          	bgez	a0,1da4 <main+0x15ea>
    1d84:	e1ea                	sd	s10,192(sp)
    1d86:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1d88:	00001617          	auipc	a2,0x1
    1d8c:	42860613          	addi	a2,a2,1064 # 31b0 <malloc+0xaa6>
    1d90:	00001597          	auipc	a1,0x1
    1d94:	a7058593          	addi	a1,a1,-1424 # 2800 <malloc+0xf6>
    1d98:	4509                	li	a0,2
    1d9a:	08b000ef          	jal	2624 <fprintf>
    exit(1);
    1d9e:	4505                	li	a0,1
    1da0:	438000ef          	jal	21d8 <exit>
    1da4:	45c000ef          	jal	2200 <close>
  if (!ok) {
    1da8:	fd71                	bnez	a0,1d84 <main+0x15ca>
  check(stat("edge_target", &st) == 0 && st.size == 0,
    1daa:	f5040593          	addi	a1,s0,-176
    1dae:	00001517          	auipc	a0,0x1
    1db2:	2aa50513          	addi	a0,a0,682 # 3058 <malloc+0x94e>
    1db6:	2c0000ef          	jal	2076 <stat>
    1dba:	e121                	bnez	a0,1dfa <main+0x1640>
    1dbc:	f6043783          	ld	a5,-160(s0)
    1dc0:	ef8d                	bnez	a5,1dfa <main+0x1640>
  fd = open("edge_link", O_RDONLY | O_NOFOLLOW);
    1dc2:	6585                	lui	a1,0x1
    1dc4:	80058593          	addi	a1,a1,-2048 # 800 <main+0x46>
    1dc8:	00001517          	auipc	a0,0x1
    1dcc:	2c050513          	addi	a0,a0,704 # 3088 <malloc+0x97e>
    1dd0:	448000ef          	jal	2218 <open>
    1dd4:	84aa                	mv	s1,a0
  check(fd >= 0 && read(fd, fs_buffer, 32) == sizeof("edge_target") &&
    1dd6:	04055263          	bgez	a0,1e1a <main+0x1660>
    1dda:	e1ea                	sd	s10,192(sp)
    1ddc:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1dde:	00001617          	auipc	a2,0x1
    1de2:	41a60613          	addi	a2,a2,1050 # 31f8 <malloc+0xaee>
    1de6:	00001597          	auipc	a1,0x1
    1dea:	a1a58593          	addi	a1,a1,-1510 # 2800 <malloc+0xf6>
    1dee:	4509                	li	a0,2
    1df0:	035000ef          	jal	2624 <fprintf>
    exit(1);
    1df4:	4505                	li	a0,1
    1df6:	3e2000ef          	jal	21d8 <exit>
    1dfa:	e1ea                	sd	s10,192(sp)
    1dfc:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1dfe:	00001617          	auipc	a2,0x1
    1e02:	3d260613          	addi	a2,a2,978 # 31d0 <malloc+0xac6>
    1e06:	00001597          	auipc	a1,0x1
    1e0a:	9fa58593          	addi	a1,a1,-1542 # 2800 <malloc+0xf6>
    1e0e:	4509                	li	a0,2
    1e10:	015000ef          	jal	2624 <fprintf>
    exit(1);
    1e14:	4505                	li	a0,1
    1e16:	3c2000ef          	jal	21d8 <exit>
    1e1a:	02000613          	li	a2,32
    1e1e:	00002597          	auipc	a1,0x2
    1e22:	1f258593          	addi	a1,a1,498 # 4010 <fs_buffer>
    1e26:	3ca000ef          	jal	21f0 <read>
    1e2a:	47b1                	li	a5,12
    1e2c:	faf517e3          	bne	a0,a5,1dda <main+0x1620>
          close(fd) == 0,
    1e30:	8526                	mv	a0,s1
    1e32:	3ce000ef          	jal	2200 <close>
  if (!ok) {
    1e36:	f155                	bnez	a0,1dda <main+0x1620>
  fd = open("edge_link", O_RDWR | O_NOFOLLOW);
    1e38:	6585                	lui	a1,0x1
    1e3a:	80258593          	addi	a1,a1,-2046 # 802 <main+0x48>
    1e3e:	00001517          	auipc	a0,0x1
    1e42:	24a50513          	addi	a0,a0,586 # 3088 <malloc+0x97e>
    1e46:	3d2000ef          	jal	2218 <open>
    1e4a:	84aa                	mv	s1,a0
  check(fd >= 0 && write(fd, "X", 1) == 1 && close(fd) == 0,
    1e4c:	02055263          	bgez	a0,1e70 <main+0x16b6>
    1e50:	e1ea                	sd	s10,192(sp)
    1e52:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1e54:	00001617          	auipc	a2,0x1
    1e58:	3d460613          	addi	a2,a2,980 # 3228 <malloc+0xb1e>
    1e5c:	00001597          	auipc	a1,0x1
    1e60:	9a458593          	addi	a1,a1,-1628 # 2800 <malloc+0xf6>
    1e64:	4509                	li	a0,2
    1e66:	7be000ef          	jal	2624 <fprintf>
    exit(1);
    1e6a:	4505                	li	a0,1
    1e6c:	36c000ef          	jal	21d8 <exit>
    1e70:	4605                	li	a2,1
    1e72:	00001597          	auipc	a1,0x1
    1e76:	3ae58593          	addi	a1,a1,942 # 3220 <malloc+0xb16>
    1e7a:	37e000ef          	jal	21f8 <write>
    1e7e:	4785                	li	a5,1
    1e80:	fcf518e3          	bne	a0,a5,1e50 <main+0x1696>
    1e84:	8526                	mv	a0,s1
    1e86:	37a000ef          	jal	2200 <close>
  if (!ok) {
    1e8a:	f179                	bnez	a0,1e50 <main+0x1696>
  unavailable("edge_link");
    1e8c:	00001517          	auipc	a0,0x1
    1e90:	1fc50513          	addi	a0,a0,508 # 3088 <malloc+0x97e>
    1e94:	98efe0ef          	jal	22 <unavailable>
  check(unlink("edge_link") == 0 && unlink("edge_target") == 0,
    1e98:	00001517          	auipc	a0,0x1
    1e9c:	1f050513          	addi	a0,a0,496 # 3088 <malloc+0x97e>
    1ea0:	388000ef          	jal	2228 <unlink>
    1ea4:	c10d                	beqz	a0,1ec6 <main+0x170c>
    1ea6:	e1ea                	sd	s10,192(sp)
    1ea8:	fd6e                	sd	s11,184(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
    1eaa:	00001617          	auipc	a2,0x1
    1eae:	3ae60613          	addi	a2,a2,942 # 3258 <malloc+0xb4e>
    1eb2:	00001597          	auipc	a1,0x1
    1eb6:	94e58593          	addi	a1,a1,-1714 # 2800 <malloc+0xf6>
    1eba:	4509                	li	a0,2
    1ebc:	768000ef          	jal	2624 <fprintf>
    exit(1);
    1ec0:	4505                	li	a0,1
    1ec2:	316000ef          	jal	21d8 <exit>
    1ec6:	00001517          	auipc	a0,0x1
    1eca:	19250513          	addi	a0,a0,402 # 3058 <malloc+0x94e>
    1ece:	35a000ef          	jal	2228 <unlink>
  if (!ok) {
    1ed2:	e2050e63          	beqz	a0,150e <main+0xd54>
    1ed6:	bfc1                	j	1ea6 <main+0x16ec>
    else if (!strcmp(argv[1], "validation"))
    1ed8:	00001597          	auipc	a1,0x1
    1edc:	3a058593          	addi	a1,a1,928 # 3278 <malloc+0xb6e>
    1ee0:	6488                	ld	a0,8(s1)
    1ee2:	070000ef          	jal	1f52 <strcmp>
    1ee6:	e509                	bnez	a0,1ef0 <main+0x1736>
      validation();
    1ee8:	a44fe0ef          	jal	12c <validation>
    1eec:	e22ff06f          	j	150e <main+0xd54>
      check(0, "unknown symlink subtest");
    1ef0:	00001597          	auipc	a1,0x1
    1ef4:	39858593          	addi	a1,a1,920 # 3288 <malloc+0xb7e>
    1ef8:	4501                	li	a0,0
    1efa:	906fe0ef          	jal	0 <check>
    1efe:	e10ff06f          	j	150e <main+0xd54>
    check(chdir("..") == 0 && unlink("fst_parts.tmp") == 0,
    1f02:	00001517          	auipc	a0,0x1
    1f06:	e8e50513          	addi	a0,a0,-370 # 2d90 <malloc+0x686>
    1f0a:	31e000ef          	jal	2228 <unlink>
    1f0e:	00153793          	seqz	a5,a0
    1f12:	e0eff06f          	j	1520 <main+0xd66>
    return seed;
    1f16:	8676                	mv	a2,t4
    1f18:	b8ffe06f          	j	aa6 <main+0x2ec>
    1f1c:	864a                	mv	a2,s2
    1f1e:	9d7fe06f          	j	8f4 <main+0x13a>

0000000000001f22 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
    1f22:	1141                	addi	sp,sp,-16
    1f24:	e406                	sd	ra,8(sp)
    1f26:	e022                	sd	s0,0(sp)
    1f28:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
    1f2a:	891fe0ef          	jal	7ba <main>
  exit(r);
    1f2e:	2aa000ef          	jal	21d8 <exit>

0000000000001f32 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
    1f32:	1141                	addi	sp,sp,-16
    1f34:	e406                	sd	ra,8(sp)
    1f36:	e022                	sd	s0,0(sp)
    1f38:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
    1f3a:	87aa                	mv	a5,a0
    1f3c:	0585                	addi	a1,a1,1
    1f3e:	0785                	addi	a5,a5,1
    1f40:	fff5c703          	lbu	a4,-1(a1)
    1f44:	fee78fa3          	sb	a4,-1(a5)
    1f48:	fb75                	bnez	a4,1f3c <strcpy+0xa>
    ;
  return os;
}
    1f4a:	60a2                	ld	ra,8(sp)
    1f4c:	6402                	ld	s0,0(sp)
    1f4e:	0141                	addi	sp,sp,16
    1f50:	8082                	ret

0000000000001f52 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1f52:	1141                	addi	sp,sp,-16
    1f54:	e406                	sd	ra,8(sp)
    1f56:	e022                	sd	s0,0(sp)
    1f58:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
    1f5a:	00054783          	lbu	a5,0(a0)
    1f5e:	cb91                	beqz	a5,1f72 <strcmp+0x20>
    1f60:	0005c703          	lbu	a4,0(a1)
    1f64:	00f71763          	bne	a4,a5,1f72 <strcmp+0x20>
    p++, q++;
    1f68:	0505                	addi	a0,a0,1
    1f6a:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
    1f6c:	00054783          	lbu	a5,0(a0)
    1f70:	fbe5                	bnez	a5,1f60 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
    1f72:	0005c503          	lbu	a0,0(a1)
}
    1f76:	40a7853b          	subw	a0,a5,a0
    1f7a:	60a2                	ld	ra,8(sp)
    1f7c:	6402                	ld	s0,0(sp)
    1f7e:	0141                	addi	sp,sp,16
    1f80:	8082                	ret

0000000000001f82 <strlen>:

uint
strlen(const char *s)
{
    1f82:	1141                	addi	sp,sp,-16
    1f84:	e406                	sd	ra,8(sp)
    1f86:	e022                	sd	s0,0(sp)
    1f88:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
    1f8a:	00054783          	lbu	a5,0(a0)
    1f8e:	cf91                	beqz	a5,1faa <strlen+0x28>
    1f90:	00150793          	addi	a5,a0,1
    1f94:	86be                	mv	a3,a5
    1f96:	0785                	addi	a5,a5,1
    1f98:	fff7c703          	lbu	a4,-1(a5)
    1f9c:	ff65                	bnez	a4,1f94 <strlen+0x12>
    1f9e:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
    1fa2:	60a2                	ld	ra,8(sp)
    1fa4:	6402                	ld	s0,0(sp)
    1fa6:	0141                	addi	sp,sp,16
    1fa8:	8082                	ret
  for (n = 0; s[n]; n++)
    1faa:	4501                	li	a0,0
    1fac:	bfdd                	j	1fa2 <strlen+0x20>

0000000000001fae <memset>:

void *
memset(void *dst, int c, uint n)
{
    1fae:	1141                	addi	sp,sp,-16
    1fb0:	e406                	sd	ra,8(sp)
    1fb2:	e022                	sd	s0,0(sp)
    1fb4:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
    1fb6:	ca19                	beqz	a2,1fcc <memset+0x1e>
    1fb8:	87aa                	mv	a5,a0
    1fba:	1602                	slli	a2,a2,0x20
    1fbc:	9201                	srli	a2,a2,0x20
    1fbe:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    1fc2:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
    1fc6:	0785                	addi	a5,a5,1
    1fc8:	fee79de3          	bne	a5,a4,1fc2 <memset+0x14>
  }
  return dst;
}
    1fcc:	60a2                	ld	ra,8(sp)
    1fce:	6402                	ld	s0,0(sp)
    1fd0:	0141                	addi	sp,sp,16
    1fd2:	8082                	ret

0000000000001fd4 <strchr>:

char *
strchr(const char *s, char c)
{
    1fd4:	1141                	addi	sp,sp,-16
    1fd6:	e406                	sd	ra,8(sp)
    1fd8:	e022                	sd	s0,0(sp)
    1fda:	0800                	addi	s0,sp,16
  for (; *s; s++)
    1fdc:	00054783          	lbu	a5,0(a0)
    1fe0:	c799                	beqz	a5,1fee <strchr+0x1a>
    if (*s == c)
    1fe2:	00f58763          	beq	a1,a5,1ff0 <strchr+0x1c>
  for (; *s; s++)
    1fe6:	0505                	addi	a0,a0,1
    1fe8:	00054783          	lbu	a5,0(a0)
    1fec:	fbfd                	bnez	a5,1fe2 <strchr+0xe>
      return (char *)s;
  return 0;
    1fee:	4501                	li	a0,0
}
    1ff0:	60a2                	ld	ra,8(sp)
    1ff2:	6402                	ld	s0,0(sp)
    1ff4:	0141                	addi	sp,sp,16
    1ff6:	8082                	ret

0000000000001ff8 <gets>:

char *
gets(char *buf, int max)
{
    1ff8:	711d                	addi	sp,sp,-96
    1ffa:	ec86                	sd	ra,88(sp)
    1ffc:	e8a2                	sd	s0,80(sp)
    1ffe:	e4a6                	sd	s1,72(sp)
    2000:	e0ca                	sd	s2,64(sp)
    2002:	fc4e                	sd	s3,56(sp)
    2004:	f852                	sd	s4,48(sp)
    2006:	f456                	sd	s5,40(sp)
    2008:	f05a                	sd	s6,32(sp)
    200a:	ec5e                	sd	s7,24(sp)
    200c:	e862                	sd	s8,16(sp)
    200e:	1080                	addi	s0,sp,96
    2010:	8baa                	mv	s7,a0
    2012:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
    2014:	892a                	mv	s2,a0
    2016:	4481                	li	s1,0
    cc = read(0, &c, 1);
    2018:	faf40b13          	addi	s6,s0,-81
    201c:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;) {
    201e:	8c26                	mv	s8,s1
    2020:	0014899b          	addiw	s3,s1,1
    2024:	84ce                	mv	s1,s3
    2026:	0349d863          	bge	s3,s4,2056 <gets+0x5e>
    cc = read(0, &c, 1);
    202a:	8656                	mv	a2,s5
    202c:	85da                	mv	a1,s6
    202e:	4501                	li	a0,0
    2030:	1c0000ef          	jal	21f0 <read>
    if (cc < 1)
    2034:	02a05163          	blez	a0,2056 <gets+0x5e>
      break;
    buf[i++] = c;
    2038:	faf44783          	lbu	a5,-81(s0)
    203c:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
    2040:	0905                	addi	s2,s2,1
    2042:	ff678713          	addi	a4,a5,-10
    2046:	00173713          	seqz	a4,a4
    204a:	17cd                	addi	a5,a5,-13
    204c:	0017b793          	seqz	a5,a5
    2050:	8fd9                	or	a5,a5,a4
    2052:	d7f1                	beqz	a5,201e <gets+0x26>
    buf[i++] = c;
    2054:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
    2056:	9c5e                	add	s8,s8,s7
    2058:	000c0023          	sb	zero,0(s8)
  return buf;
}
    205c:	855e                	mv	a0,s7
    205e:	60e6                	ld	ra,88(sp)
    2060:	6446                	ld	s0,80(sp)
    2062:	64a6                	ld	s1,72(sp)
    2064:	6906                	ld	s2,64(sp)
    2066:	79e2                	ld	s3,56(sp)
    2068:	7a42                	ld	s4,48(sp)
    206a:	7aa2                	ld	s5,40(sp)
    206c:	7b02                	ld	s6,32(sp)
    206e:	6be2                	ld	s7,24(sp)
    2070:	6c42                	ld	s8,16(sp)
    2072:	6125                	addi	sp,sp,96
    2074:	8082                	ret

0000000000002076 <stat>:

int
stat(const char *n, struct stat *st)
{
    2076:	1101                	addi	sp,sp,-32
    2078:	ec06                	sd	ra,24(sp)
    207a:	e822                	sd	s0,16(sp)
    207c:	e04a                	sd	s2,0(sp)
    207e:	1000                	addi	s0,sp,32
    2080:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    2082:	4581                	li	a1,0
    2084:	194000ef          	jal	2218 <open>
  if (fd < 0)
    2088:	02054263          	bltz	a0,20ac <stat+0x36>
    208c:	e426                	sd	s1,8(sp)
    208e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    2090:	85ca                	mv	a1,s2
    2092:	19e000ef          	jal	2230 <fstat>
    2096:	892a                	mv	s2,a0
  close(fd);
    2098:	8526                	mv	a0,s1
    209a:	166000ef          	jal	2200 <close>
  return r;
    209e:	64a2                	ld	s1,8(sp)
}
    20a0:	854a                	mv	a0,s2
    20a2:	60e2                	ld	ra,24(sp)
    20a4:	6442                	ld	s0,16(sp)
    20a6:	6902                	ld	s2,0(sp)
    20a8:	6105                	addi	sp,sp,32
    20aa:	8082                	ret
    return -1;
    20ac:	57fd                	li	a5,-1
    20ae:	893e                	mv	s2,a5
    20b0:	bfc5                	j	20a0 <stat+0x2a>

00000000000020b2 <atoi>:

int
atoi(const char *s)
{
    20b2:	1141                	addi	sp,sp,-16
    20b4:	e406                	sd	ra,8(sp)
    20b6:	e022                	sd	s0,0(sp)
    20b8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
    20ba:	00054683          	lbu	a3,0(a0)
    20be:	fd06879b          	addiw	a5,a3,-48
    20c2:	0ff7f793          	zext.b	a5,a5
    20c6:	4625                	li	a2,9
    20c8:	02f66963          	bltu	a2,a5,20fa <atoi+0x48>
    20cc:	872a                	mv	a4,a0
  n = 0;
    20ce:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
    20d0:	0705                	addi	a4,a4,1
    20d2:	0025179b          	slliw	a5,a0,0x2
    20d6:	9fa9                	addw	a5,a5,a0
    20d8:	0017979b          	slliw	a5,a5,0x1
    20dc:	9fb5                	addw	a5,a5,a3
    20de:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
    20e2:	00074683          	lbu	a3,0(a4)
    20e6:	fd06879b          	addiw	a5,a3,-48
    20ea:	0ff7f793          	zext.b	a5,a5
    20ee:	fef671e3          	bgeu	a2,a5,20d0 <atoi+0x1e>
  return n;
}
    20f2:	60a2                	ld	ra,8(sp)
    20f4:	6402                	ld	s0,0(sp)
    20f6:	0141                	addi	sp,sp,16
    20f8:	8082                	ret
  n = 0;
    20fa:	4501                	li	a0,0
    20fc:	bfdd                	j	20f2 <atoi+0x40>

00000000000020fe <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
    20fe:	1141                	addi	sp,sp,-16
    2100:	e406                	sd	ra,8(sp)
    2102:	e022                	sd	s0,0(sp)
    2104:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    2106:	02b57563          	bgeu	a0,a1,2130 <memmove+0x32>
    while (n-- > 0)
    210a:	00c05f63          	blez	a2,2128 <memmove+0x2a>
    210e:	1602                	slli	a2,a2,0x20
    2110:	9201                	srli	a2,a2,0x20
    2112:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    2116:	872a                	mv	a4,a0
      *dst++ = *src++;
    2118:	0585                	addi	a1,a1,1
    211a:	0705                	addi	a4,a4,1
    211c:	fff5c683          	lbu	a3,-1(a1)
    2120:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
    2124:	fee79ae3          	bne	a5,a4,2118 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    2128:	60a2                	ld	ra,8(sp)
    212a:	6402                	ld	s0,0(sp)
    212c:	0141                	addi	sp,sp,16
    212e:	8082                	ret
    while (n-- > 0)
    2130:	fec05ce3          	blez	a2,2128 <memmove+0x2a>
    dst += n;
    2134:	00c50733          	add	a4,a0,a2
    src += n;
    2138:	95b2                	add	a1,a1,a2
    213a:	fff6079b          	addiw	a5,a2,-1
    213e:	1782                	slli	a5,a5,0x20
    2140:	9381                	srli	a5,a5,0x20
    2142:	fff7c793          	not	a5,a5
    2146:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    2148:	15fd                	addi	a1,a1,-1
    214a:	177d                	addi	a4,a4,-1
    214c:	0005c683          	lbu	a3,0(a1)
    2150:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
    2154:	fef71ae3          	bne	a4,a5,2148 <memmove+0x4a>
    2158:	bfc1                	j	2128 <memmove+0x2a>

000000000000215a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    215a:	1141                	addi	sp,sp,-16
    215c:	e406                	sd	ra,8(sp)
    215e:	e022                	sd	s0,0(sp)
    2160:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    2162:	ce19                	beqz	a2,2180 <memcmp+0x26>
    2164:	1602                	slli	a2,a2,0x20
    2166:	9201                	srli	a2,a2,0x20
    2168:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
    216c:	00054783          	lbu	a5,0(a0)
    2170:	0005c703          	lbu	a4,0(a1)
    2174:	00e79b63          	bne	a5,a4,218a <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
    2178:	0505                	addi	a0,a0,1
    p2++;
    217a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    217c:	fed518e3          	bne	a0,a3,216c <memcmp+0x12>
  }
  return 0;
    2180:	4501                	li	a0,0
}
    2182:	60a2                	ld	ra,8(sp)
    2184:	6402                	ld	s0,0(sp)
    2186:	0141                	addi	sp,sp,16
    2188:	8082                	ret
      return *p1 - *p2;
    218a:	40e7853b          	subw	a0,a5,a4
    218e:	bfd5                	j	2182 <memcmp+0x28>

0000000000002190 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    2190:	1141                	addi	sp,sp,-16
    2192:	e406                	sd	ra,8(sp)
    2194:	e022                	sd	s0,0(sp)
    2196:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    2198:	f67ff0ef          	jal	20fe <memmove>
}
    219c:	60a2                	ld	ra,8(sp)
    219e:	6402                	ld	s0,0(sp)
    21a0:	0141                	addi	sp,sp,16
    21a2:	8082                	ret

00000000000021a4 <sbrk>:

char *
sbrk(int n)
{
    21a4:	1141                	addi	sp,sp,-16
    21a6:	e406                	sd	ra,8(sp)
    21a8:	e022                	sd	s0,0(sp)
    21aa:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
    21ac:	4585                	li	a1,1
    21ae:	0b2000ef          	jal	2260 <sys_sbrk>
}
    21b2:	60a2                	ld	ra,8(sp)
    21b4:	6402                	ld	s0,0(sp)
    21b6:	0141                	addi	sp,sp,16
    21b8:	8082                	ret

00000000000021ba <sbrklazy>:

char *
sbrklazy(int n)
{
    21ba:	1141                	addi	sp,sp,-16
    21bc:	e406                	sd	ra,8(sp)
    21be:	e022                	sd	s0,0(sp)
    21c0:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
    21c2:	4589                	li	a1,2
    21c4:	09c000ef          	jal	2260 <sys_sbrk>
}
    21c8:	60a2                	ld	ra,8(sp)
    21ca:	6402                	ld	s0,0(sp)
    21cc:	0141                	addi	sp,sp,16
    21ce:	8082                	ret

00000000000021d0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    21d0:	4885                	li	a7,1
 ecall
    21d2:	00000073          	ecall
 ret
    21d6:	8082                	ret

00000000000021d8 <exit>:
.global exit
exit:
 li a7, SYS_exit
    21d8:	4889                	li	a7,2
 ecall
    21da:	00000073          	ecall
 ret
    21de:	8082                	ret

00000000000021e0 <wait>:
.global wait
wait:
 li a7, SYS_wait
    21e0:	488d                	li	a7,3
 ecall
    21e2:	00000073          	ecall
 ret
    21e6:	8082                	ret

00000000000021e8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    21e8:	4891                	li	a7,4
 ecall
    21ea:	00000073          	ecall
 ret
    21ee:	8082                	ret

00000000000021f0 <read>:
.global read
read:
 li a7, SYS_read
    21f0:	4895                	li	a7,5
 ecall
    21f2:	00000073          	ecall
 ret
    21f6:	8082                	ret

00000000000021f8 <write>:
.global write
write:
 li a7, SYS_write
    21f8:	48c1                	li	a7,16
 ecall
    21fa:	00000073          	ecall
 ret
    21fe:	8082                	ret

0000000000002200 <close>:
.global close
close:
 li a7, SYS_close
    2200:	48d5                	li	a7,21
 ecall
    2202:	00000073          	ecall
 ret
    2206:	8082                	ret

0000000000002208 <kill>:
.global kill
kill:
 li a7, SYS_kill
    2208:	4899                	li	a7,6
 ecall
    220a:	00000073          	ecall
 ret
    220e:	8082                	ret

0000000000002210 <exec>:
.global exec
exec:
 li a7, SYS_exec
    2210:	489d                	li	a7,7
 ecall
    2212:	00000073          	ecall
 ret
    2216:	8082                	ret

0000000000002218 <open>:
.global open
open:
 li a7, SYS_open
    2218:	48bd                	li	a7,15
 ecall
    221a:	00000073          	ecall
 ret
    221e:	8082                	ret

0000000000002220 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    2220:	48c5                	li	a7,17
 ecall
    2222:	00000073          	ecall
 ret
    2226:	8082                	ret

0000000000002228 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    2228:	48c9                	li	a7,18
 ecall
    222a:	00000073          	ecall
 ret
    222e:	8082                	ret

0000000000002230 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    2230:	48a1                	li	a7,8
 ecall
    2232:	00000073          	ecall
 ret
    2236:	8082                	ret

0000000000002238 <link>:
.global link
link:
 li a7, SYS_link
    2238:	48cd                	li	a7,19
 ecall
    223a:	00000073          	ecall
 ret
    223e:	8082                	ret

0000000000002240 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    2240:	48d1                	li	a7,20
 ecall
    2242:	00000073          	ecall
 ret
    2246:	8082                	ret

0000000000002248 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    2248:	48a5                	li	a7,9
 ecall
    224a:	00000073          	ecall
 ret
    224e:	8082                	ret

0000000000002250 <dup>:
.global dup
dup:
 li a7, SYS_dup
    2250:	48a9                	li	a7,10
 ecall
    2252:	00000073          	ecall
 ret
    2256:	8082                	ret

0000000000002258 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    2258:	48ad                	li	a7,11
 ecall
    225a:	00000073          	ecall
 ret
    225e:	8082                	ret

0000000000002260 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
    2260:	48b1                	li	a7,12
 ecall
    2262:	00000073          	ecall
 ret
    2266:	8082                	ret

0000000000002268 <pause>:
.global pause
pause:
 li a7, SYS_pause
    2268:	48b5                	li	a7,13
 ecall
    226a:	00000073          	ecall
 ret
    226e:	8082                	ret

0000000000002270 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    2270:	48b9                	li	a7,14
 ecall
    2272:	00000073          	ecall
 ret
    2276:	8082                	ret

0000000000002278 <sync>:
.global sync
sync:
 li a7, SYS_sync
    2278:	48d9                	li	a7,22
 ecall
    227a:	00000073          	ecall
 ret
    227e:	8082                	ret

0000000000002280 <istat>:
.global istat
istat:
 li a7, SYS_istat
    2280:	48dd                	li	a7,23
 ecall
    2282:	00000073          	ecall
 ret
    2286:	8082                	ret

0000000000002288 <iprint>:
.global iprint
iprint:
 li a7, SYS_iprint
    2288:	48e1                	li	a7,24
 ecall
    228a:	00000073          	ecall
 ret
    228e:	8082                	ret

0000000000002290 <symlink>:
.global symlink
symlink:
 li a7, SYS_symlink
    2290:	48e5                	li	a7,25
 ecall
    2292:	00000073          	ecall
 ret
    2296:	8082                	ret

0000000000002298 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    2298:	1101                	addi	sp,sp,-32
    229a:	ec06                	sd	ra,24(sp)
    229c:	e822                	sd	s0,16(sp)
    229e:	1000                	addi	s0,sp,32
    22a0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    22a4:	4605                	li	a2,1
    22a6:	fef40593          	addi	a1,s0,-17
    22aa:	f4fff0ef          	jal	21f8 <write>
}
    22ae:	60e2                	ld	ra,24(sp)
    22b0:	6442                	ld	s0,16(sp)
    22b2:	6105                	addi	sp,sp,32
    22b4:	8082                	ret

00000000000022b6 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
    22b6:	715d                	addi	sp,sp,-80
    22b8:	e486                	sd	ra,72(sp)
    22ba:	e0a2                	sd	s0,64(sp)
    22bc:	f84a                	sd	s2,48(sp)
    22be:	f44e                	sd	s3,40(sp)
    22c0:	0880                	addi	s0,sp,80
    22c2:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
    22c4:	00d036b3          	snez	a3,a3
    22c8:	03f5d793          	srli	a5,a1,0x3f
    22cc:	8efd                	and	a3,a3,a5
  neg = 0;
    22ce:	4301                	li	t1,0
  if (sgn && xx < 0) {
    22d0:	c681                	beqz	a3,22d8 <printint+0x22>
    neg = 1;
    x = -xx;
    22d2:	40b005b3          	neg	a1,a1
    neg = 1;
    22d6:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
    22d8:	fb840993          	addi	s3,s0,-72
  neg = 0;
    22dc:	86ce                	mv	a3,s3
  i = 0;
    22de:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    22e0:	00001817          	auipc	a6,0x1
    22e4:	09080813          	addi	a6,a6,144 # 3370 <digits>
    22e8:	88ba                	mv	a7,a4
    22ea:	0017051b          	addiw	a0,a4,1
    22ee:	872a                	mv	a4,a0
    22f0:	02c5f7b3          	remu	a5,a1,a2
    22f4:	97c2                	add	a5,a5,a6
    22f6:	0007c783          	lbu	a5,0(a5)
    22fa:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
    22fe:	87ae                	mv	a5,a1
    2300:	02c5d5b3          	divu	a1,a1,a2
    2304:	0685                	addi	a3,a3,1
    2306:	fec7f1e3          	bgeu	a5,a2,22e8 <printint+0x32>
  if (neg)
    230a:	00030b63          	beqz	t1,2320 <printint+0x6a>
    buf[i++] = '-';
    230e:	fd040793          	addi	a5,s0,-48
    2312:	953e                	add	a0,a0,a5
    2314:	02d00793          	li	a5,45
    2318:	fef50423          	sb	a5,-24(a0)
    231c:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
    2320:	02e05563          	blez	a4,234a <printint+0x94>
    2324:	fc26                	sd	s1,56(sp)
    2326:	377d                	addiw	a4,a4,-1
    2328:	00e984b3          	add	s1,s3,a4
    232c:	19fd                	addi	s3,s3,-1
    232e:	99ba                	add	s3,s3,a4
    2330:	1702                	slli	a4,a4,0x20
    2332:	9301                	srli	a4,a4,0x20
    2334:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    2338:	0004c583          	lbu	a1,0(s1)
    233c:	854a                	mv	a0,s2
    233e:	f5bff0ef          	jal	2298 <putc>
  while (--i >= 0)
    2342:	14fd                	addi	s1,s1,-1
    2344:	ff349ae3          	bne	s1,s3,2338 <printint+0x82>
    2348:	74e2                	ld	s1,56(sp)
}
    234a:	60a6                	ld	ra,72(sp)
    234c:	6406                	ld	s0,64(sp)
    234e:	7942                	ld	s2,48(sp)
    2350:	79a2                	ld	s3,40(sp)
    2352:	6161                	addi	sp,sp,80
    2354:	8082                	ret

0000000000002356 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    2356:	711d                	addi	sp,sp,-96
    2358:	ec86                	sd	ra,88(sp)
    235a:	e8a2                	sd	s0,80(sp)
    235c:	e4a6                	sd	s1,72(sp)
    235e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
    2360:	0005c483          	lbu	s1,0(a1)
    2364:	2a048063          	beqz	s1,2604 <vprintf+0x2ae>
    2368:	e0ca                	sd	s2,64(sp)
    236a:	fc4e                	sd	s3,56(sp)
    236c:	f852                	sd	s4,48(sp)
    236e:	f456                	sd	s5,40(sp)
    2370:	f05a                	sd	s6,32(sp)
    2372:	ec5e                	sd	s7,24(sp)
    2374:	e862                	sd	s8,16(sp)
    2376:	8b2a                	mv	s6,a0
    2378:	8a2e                	mv	s4,a1
    237a:	8bb2                	mv	s7,a2
  state = 0;
    237c:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
    237e:	4901                	li	s2,0
    2380:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
    2382:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
    2386:	06400c13          	li	s8,100
    238a:	a00d                	j	23ac <vprintf+0x56>
        putc(fd, c0);
    238c:	85a6                	mv	a1,s1
    238e:	855a                	mv	a0,s6
    2390:	f09ff0ef          	jal	2298 <putc>
    2394:	a019                	j	239a <vprintf+0x44>
    } else if (state == '%') {
    2396:	03598363          	beq	s3,s5,23bc <vprintf+0x66>
  for (i = 0; fmt[i]; i++) {
    239a:	0019079b          	addiw	a5,s2,1
    239e:	893e                	mv	s2,a5
    23a0:	873e                	mv	a4,a5
    23a2:	97d2                	add	a5,a5,s4
    23a4:	0007c483          	lbu	s1,0(a5)
    23a8:	24048763          	beqz	s1,25f6 <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
    23ac:	0004879b          	sext.w	a5,s1
    if (state == 0) {
    23b0:	fe0993e3          	bnez	s3,2396 <vprintf+0x40>
      if (c0 == '%') {
    23b4:	fd579ce3          	bne	a5,s5,238c <vprintf+0x36>
        state = '%';
    23b8:	89be                	mv	s3,a5
    23ba:	b7c5                	j	239a <vprintf+0x44>
        c1 = fmt[i + 1] & 0xff;
    23bc:	00ea06b3          	add	a3,s4,a4
    23c0:	0016c603          	lbu	a2,1(a3)
      if (c1)
    23c4:	24060563          	beqz	a2,260e <vprintf+0x2b8>
      if (c0 == 'd') {
    23c8:	0b878763          	beq	a5,s8,2476 <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
    23cc:	f9478693          	addi	a3,a5,-108
    23d0:	0016b693          	seqz	a3,a3
    23d4:	f9c60593          	addi	a1,a2,-100
    23d8:	0015b593          	seqz	a1,a1
    23dc:	8df5                	and	a1,a1,a3
    23de:	e9c5                	bnez	a1,248e <vprintf+0x138>
        c2 = fmt[i + 2] & 0xff;
    23e0:	9752                	add	a4,a4,s4
    23e2:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
    23e6:	f9460713          	addi	a4,a2,-108
    23ea:	00173713          	seqz	a4,a4
    23ee:	8f75                	and	a4,a4,a3
    23f0:	f9c50593          	addi	a1,a0,-100
    23f4:	0015b593          	seqz	a1,a1
    23f8:	8df9                	and	a1,a1,a4
    23fa:	e5dd                	bnez	a1,24a8 <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
    23fc:	07500593          	li	a1,117
    2400:	0cb78163          	beq	a5,a1,24c2 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if (c0 == 'l' && c1 == 'u') {
    2404:	f8b60593          	addi	a1,a2,-117
    2408:	0015b593          	seqz	a1,a1
    240c:	8df5                	and	a1,a1,a3
    240e:	e5f1                	bnez	a1,24da <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
    2410:	f8b50593          	addi	a1,a0,-117
    2414:	0015b593          	seqz	a1,a1
    2418:	8df9                	and	a1,a1,a4
    241a:	ede9                	bnez	a1,24f4 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
    241c:	07800593          	li	a1,120
    2420:	0eb78763          	beq	a5,a1,250e <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if (c0 == 'l' && c1 == 'x') {
    2424:	f8860613          	addi	a2,a2,-120
    2428:	00163613          	seqz	a2,a2
    242c:	8ef1                	and	a3,a3,a2
    242e:	0e069c63          	bnez	a3,2526 <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
    2432:	f8850513          	addi	a0,a0,-120
    2436:	00153513          	seqz	a0,a0
    243a:	8f69                	and	a4,a4,a0
    243c:	10071263          	bnez	a4,2540 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
    2440:	07000713          	li	a4,112
    2444:	10e78a63          	beq	a5,a4,2558 <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
    2448:	06300713          	li	a4,99
    244c:	14e78a63          	beq	a5,a4,25a0 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
    2450:	07300713          	li	a4,115
    2454:	16e78063          	beq	a5,a4,25b4 <vprintf+0x25e>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
    2458:	02500713          	li	a4,37
    245c:	18e78863          	beq	a5,a4,25ec <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    2460:	02500593          	li	a1,37
    2464:	855a                	mv	a0,s6
    2466:	e33ff0ef          	jal	2298 <putc>
        putc(fd, c0);
    246a:	85a6                	mv	a1,s1
    246c:	855a                	mv	a0,s6
    246e:	e2bff0ef          	jal	2298 <putc>
      }

      state = 0;
    2472:	4981                	li	s3,0
    2474:	b71d                	j	239a <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
    2476:	008b8493          	addi	s1,s7,8
    247a:	4685                	li	a3,1
    247c:	4629                	li	a2,10
    247e:	000ba583          	lw	a1,0(s7)
    2482:	855a                	mv	a0,s6
    2484:	e33ff0ef          	jal	22b6 <printint>
    2488:	8ba6                	mv	s7,s1
      state = 0;
    248a:	4981                	li	s3,0
    248c:	b739                	j	239a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
    248e:	008b8493          	addi	s1,s7,8
    2492:	4685                	li	a3,1
    2494:	4629                	li	a2,10
    2496:	000bb583          	ld	a1,0(s7)
    249a:	855a                	mv	a0,s6
    249c:	e1bff0ef          	jal	22b6 <printint>
        i += 1;
    24a0:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    24a2:	8ba6                	mv	s7,s1
      state = 0;
    24a4:	4981                	li	s3,0
    24a6:	bdd5                	j	239a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
    24a8:	008b8493          	addi	s1,s7,8
    24ac:	4685                	li	a3,1
    24ae:	4629                	li	a2,10
    24b0:	000bb583          	ld	a1,0(s7)
    24b4:	855a                	mv	a0,s6
    24b6:	e01ff0ef          	jal	22b6 <printint>
        i += 2;
    24ba:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    24bc:	8ba6                	mv	s7,s1
      state = 0;
    24be:	4981                	li	s3,0
        i += 2;
    24c0:	bde9                	j	239a <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
    24c2:	008b8493          	addi	s1,s7,8
    24c6:	4681                	li	a3,0
    24c8:	4629                	li	a2,10
    24ca:	000be583          	lwu	a1,0(s7)
    24ce:	855a                	mv	a0,s6
    24d0:	de7ff0ef          	jal	22b6 <printint>
    24d4:	8ba6                	mv	s7,s1
      state = 0;
    24d6:	4981                	li	s3,0
    24d8:	b5c9                	j	239a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    24da:	008b8493          	addi	s1,s7,8
    24de:	4681                	li	a3,0
    24e0:	4629                	li	a2,10
    24e2:	000bb583          	ld	a1,0(s7)
    24e6:	855a                	mv	a0,s6
    24e8:	dcfff0ef          	jal	22b6 <printint>
        i += 1;
    24ec:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    24ee:	8ba6                	mv	s7,s1
      state = 0;
    24f0:	4981                	li	s3,0
    24f2:	b565                	j	239a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    24f4:	008b8493          	addi	s1,s7,8
    24f8:	4681                	li	a3,0
    24fa:	4629                	li	a2,10
    24fc:	000bb583          	ld	a1,0(s7)
    2500:	855a                	mv	a0,s6
    2502:	db5ff0ef          	jal	22b6 <printint>
        i += 2;
    2506:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    2508:	8ba6                	mv	s7,s1
      state = 0;
    250a:	4981                	li	s3,0
        i += 2;
    250c:	b579                	j	239a <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
    250e:	008b8493          	addi	s1,s7,8
    2512:	4681                	li	a3,0
    2514:	4641                	li	a2,16
    2516:	000be583          	lwu	a1,0(s7)
    251a:	855a                	mv	a0,s6
    251c:	d9bff0ef          	jal	22b6 <printint>
    2520:	8ba6                	mv	s7,s1
      state = 0;
    2522:	4981                	li	s3,0
    2524:	bd9d                	j	239a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
    2526:	008b8493          	addi	s1,s7,8
    252a:	4681                	li	a3,0
    252c:	4641                	li	a2,16
    252e:	000bb583          	ld	a1,0(s7)
    2532:	855a                	mv	a0,s6
    2534:	d83ff0ef          	jal	22b6 <printint>
        i += 1;
    2538:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    253a:	8ba6                	mv	s7,s1
      state = 0;
    253c:	4981                	li	s3,0
    253e:	bdb1                	j	239a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
    2540:	008b8493          	addi	s1,s7,8
    2544:	4641                	li	a2,16
    2546:	000bb583          	ld	a1,0(s7)
    254a:	855a                	mv	a0,s6
    254c:	d6bff0ef          	jal	22b6 <printint>
        i += 2;
    2550:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    2552:	8ba6                	mv	s7,s1
      state = 0;
    2554:	4981                	li	s3,0
        i += 2;
    2556:	b591                	j	239a <vprintf+0x44>
    2558:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
    255a:	008b8793          	addi	a5,s7,8
    255e:	8cbe                	mv	s9,a5
    2560:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    2564:	03000593          	li	a1,48
    2568:	855a                	mv	a0,s6
    256a:	d2fff0ef          	jal	2298 <putc>
  putc(fd, 'x');
    256e:	07800593          	li	a1,120
    2572:	855a                	mv	a0,s6
    2574:	d25ff0ef          	jal	2298 <putc>
    2578:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    257a:	00001b97          	auipc	s7,0x1
    257e:	df6b8b93          	addi	s7,s7,-522 # 3370 <digits>
    2582:	03c9d793          	srli	a5,s3,0x3c
    2586:	97de                	add	a5,a5,s7
    2588:	0007c583          	lbu	a1,0(a5)
    258c:	855a                	mv	a0,s6
    258e:	d0bff0ef          	jal	2298 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    2592:	0992                	slli	s3,s3,0x4
    2594:	34fd                	addiw	s1,s1,-1
    2596:	f4f5                	bnez	s1,2582 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
    2598:	8be6                	mv	s7,s9
      state = 0;
    259a:	4981                	li	s3,0
    259c:	6ca2                	ld	s9,8(sp)
    259e:	bbf5                	j	239a <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
    25a0:	008b8493          	addi	s1,s7,8
    25a4:	000bc583          	lbu	a1,0(s7)
    25a8:	855a                	mv	a0,s6
    25aa:	cefff0ef          	jal	2298 <putc>
    25ae:	8ba6                	mv	s7,s1
      state = 0;
    25b0:	4981                	li	s3,0
    25b2:	b3e5                	j	239a <vprintf+0x44>
        if ((s = va_arg(ap, char *)) == 0)
    25b4:	008b8993          	addi	s3,s7,8
    25b8:	000bb483          	ld	s1,0(s7)
    25bc:	cc91                	beqz	s1,25d8 <vprintf+0x282>
        for (; *s; s++)
    25be:	0004c583          	lbu	a1,0(s1)
    25c2:	c195                	beqz	a1,25e6 <vprintf+0x290>
          putc(fd, *s);
    25c4:	855a                	mv	a0,s6
    25c6:	cd3ff0ef          	jal	2298 <putc>
        for (; *s; s++)
    25ca:	0485                	addi	s1,s1,1
    25cc:	0004c583          	lbu	a1,0(s1)
    25d0:	f9f5                	bnez	a1,25c4 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
    25d2:	8bce                	mv	s7,s3
      state = 0;
    25d4:	4981                	li	s3,0
    25d6:	b3d1                	j	239a <vprintf+0x44>
          s = "(null)";
    25d8:	00001497          	auipc	s1,0x1
    25dc:	d0848493          	addi	s1,s1,-760 # 32e0 <malloc+0xbd6>
        for (; *s; s++)
    25e0:	02800593          	li	a1,40
    25e4:	b7c5                	j	25c4 <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
    25e6:	8bce                	mv	s7,s3
      state = 0;
    25e8:	4981                	li	s3,0
    25ea:	bb45                	j	239a <vprintf+0x44>
        putc(fd, '%');
    25ec:	85be                	mv	a1,a5
    25ee:	855a                	mv	a0,s6
    25f0:	ca9ff0ef          	jal	2298 <putc>
    25f4:	bdbd                	j	2472 <vprintf+0x11c>
    25f6:	6906                	ld	s2,64(sp)
    25f8:	79e2                	ld	s3,56(sp)
    25fa:	7a42                	ld	s4,48(sp)
    25fc:	7aa2                	ld	s5,40(sp)
    25fe:	7b02                	ld	s6,32(sp)
    2600:	6be2                	ld	s7,24(sp)
    2602:	6c42                	ld	s8,16(sp)
    }
  }
}
    2604:	60e6                	ld	ra,88(sp)
    2606:	6446                	ld	s0,80(sp)
    2608:	64a6                	ld	s1,72(sp)
    260a:	6125                	addi	sp,sp,96
    260c:	8082                	ret
      if (c0 == 'd') {
    260e:	06400713          	li	a4,100
    2612:	e6e782e3          	beq	a5,a4,2476 <vprintf+0x120>
      } else if (c0 == 'l' && c1 == 'd') {
    2616:	f9478693          	addi	a3,a5,-108
    261a:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
    261e:	8532                	mv	a0,a2
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
    2620:	4701                	li	a4,0
    2622:	bbe9                	j	23fc <vprintf+0xa6>

0000000000002624 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    2624:	715d                	addi	sp,sp,-80
    2626:	ec06                	sd	ra,24(sp)
    2628:	e822                	sd	s0,16(sp)
    262a:	1000                	addi	s0,sp,32
    262c:	e010                	sd	a2,0(s0)
    262e:	e414                	sd	a3,8(s0)
    2630:	e818                	sd	a4,16(s0)
    2632:	ec1c                	sd	a5,24(s0)
    2634:	03043023          	sd	a6,32(s0)
    2638:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    263c:	8622                	mv	a2,s0
    263e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    2642:	d15ff0ef          	jal	2356 <vprintf>
}
    2646:	60e2                	ld	ra,24(sp)
    2648:	6442                	ld	s0,16(sp)
    264a:	6161                	addi	sp,sp,80
    264c:	8082                	ret

000000000000264e <printf>:

void
printf(const char *fmt, ...)
{
    264e:	711d                	addi	sp,sp,-96
    2650:	ec06                	sd	ra,24(sp)
    2652:	e822                	sd	s0,16(sp)
    2654:	1000                	addi	s0,sp,32
    2656:	e40c                	sd	a1,8(s0)
    2658:	e810                	sd	a2,16(s0)
    265a:	ec14                	sd	a3,24(s0)
    265c:	f018                	sd	a4,32(s0)
    265e:	f41c                	sd	a5,40(s0)
    2660:	03043823          	sd	a6,48(s0)
    2664:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    2668:	00840613          	addi	a2,s0,8
    266c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    2670:	85aa                	mv	a1,a0
    2672:	4505                	li	a0,1
    2674:	ce3ff0ef          	jal	2356 <vprintf>
}
    2678:	60e2                	ld	ra,24(sp)
    267a:	6442                	ld	s0,16(sp)
    267c:	6125                	addi	sp,sp,96
    267e:	8082                	ret

0000000000002680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    2680:	1141                	addi	sp,sp,-16
    2682:	e406                	sd	ra,8(sp)
    2684:	e022                	sd	s0,0(sp)
    2686:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
    2688:	ff050713          	addi	a4,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    268c:	00002797          	auipc	a5,0x2
    2690:	9747b783          	ld	a5,-1676(a5) # 4000 <freep>
    2694:	a095                	j	26f8 <free+0x78>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
    2696:	ff852583          	lw	a1,-8(a0)
    269a:	6390                	ld	a2,0(a5)
    269c:	02059813          	slli	a6,a1,0x20
    26a0:	01c85693          	srli	a3,a6,0x1c
    26a4:	96ba                	add	a3,a3,a4
    26a6:	02d60563          	beq	a2,a3,26d0 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    26aa:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
    26ae:	4790                	lw	a2,8(a5)
    26b0:	02061593          	slli	a1,a2,0x20
    26b4:	01c5d693          	srli	a3,a1,0x1c
    26b8:	96be                	add	a3,a3,a5
    26ba:	02d70263          	beq	a4,a3,26de <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    26be:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    26c0:	00002717          	auipc	a4,0x2
    26c4:	94f73023          	sd	a5,-1728(a4) # 4000 <freep>
}
    26c8:	60a2                	ld	ra,8(sp)
    26ca:	6402                	ld	s0,0(sp)
    26cc:	0141                	addi	sp,sp,16
    26ce:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
    26d0:	4614                	lw	a3,8(a2)
    26d2:	9ead                	addw	a3,a3,a1
    26d4:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    26d8:	6394                	ld	a3,0(a5)
    26da:	6290                	ld	a2,0(a3)
    26dc:	b7f9                	j	26aa <free+0x2a>
    p->s.size += bp->s.size;
    26de:	ff852703          	lw	a4,-8(a0)
    26e2:	9f31                	addw	a4,a4,a2
    26e4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    26e6:	ff053703          	ld	a4,-16(a0)
    26ea:	bfd1                	j	26be <free+0x3e>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    26ec:	6394                	ld	a3,0(a5)
    26ee:	00d7e463          	bltu	a5,a3,26f6 <free+0x76>
    26f2:	fad762e3          	bltu	a4,a3,2696 <free+0x16>
    26f6:	87b6                	mv	a5,a3
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    26f8:	fee7fae3          	bgeu	a5,a4,26ec <free+0x6c>
    26fc:	6394                	ld	a3,0(a5)
    26fe:	f8d76ce3          	bltu	a4,a3,2696 <free+0x16>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    2702:	f8d7fae3          	bgeu	a5,a3,2696 <free+0x16>
    2706:	87b6                	mv	a5,a3
    2708:	bfc5                	j	26f8 <free+0x78>

000000000000270a <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
    270a:	7139                	addi	sp,sp,-64
    270c:	fc06                	sd	ra,56(sp)
    270e:	f822                	sd	s0,48(sp)
    2710:	f04a                	sd	s2,32(sp)
    2712:	ec4e                	sd	s3,24(sp)
    2714:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    2716:	02051993          	slli	s3,a0,0x20
    271a:	0209d993          	srli	s3,s3,0x20
    271e:	09bd                	addi	s3,s3,15
    2720:	0049d993          	srli	s3,s3,0x4
    2724:	2985                	addiw	s3,s3,1
    2726:	894e                	mv	s2,s3
  if ((prevp = freep) == 0) {
    2728:	00002517          	auipc	a0,0x2
    272c:	8d853503          	ld	a0,-1832(a0) # 4000 <freep>
    2730:	c905                	beqz	a0,2760 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    2732:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
    2734:	4798                	lw	a4,8(a5)
    2736:	09377663          	bgeu	a4,s3,27c2 <malloc+0xb8>
    273a:	f426                	sd	s1,40(sp)
    273c:	e852                	sd	s4,16(sp)
    273e:	e456                	sd	s5,8(sp)
    2740:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
    2742:	8a4e                	mv	s4,s3
    2744:	6705                	lui	a4,0x1
    2746:	00e9f363          	bgeu	s3,a4,274c <malloc+0x42>
    274a:	6a05                	lui	s4,0x1
    274c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    2750:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
    2754:	00002497          	auipc	s1,0x2
    2758:	8ac48493          	addi	s1,s1,-1876 # 4000 <freep>
  if (p == SBRK_ERROR)
    275c:	5afd                	li	s5,-1
    275e:	a83d                	j	279c <malloc+0x92>
    2760:	f426                	sd	s1,40(sp)
    2762:	e852                	sd	s4,16(sp)
    2764:	e456                	sd	s5,8(sp)
    2766:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    2768:	00004797          	auipc	a5,0x4
    276c:	8a878793          	addi	a5,a5,-1880 # 6010 <base>
    2770:	00002717          	auipc	a4,0x2
    2774:	88f73823          	sd	a5,-1904(a4) # 4000 <freep>
    2778:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    277a:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
    277e:	b7d1                	j	2742 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    2780:	6398                	ld	a4,0(a5)
    2782:	e118                	sd	a4,0(a0)
    2784:	a899                	j	27da <malloc+0xd0>
  hp->s.size = nu;
    2786:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
    278a:	0541                	addi	a0,a0,16
    278c:	ef5ff0ef          	jal	2680 <free>
  return freep;
    2790:	6088                	ld	a0,0(s1)
      if ((p = morecore(nunits)) == 0)
    2792:	c125                	beqz	a0,27f2 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    2794:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
    2796:	4798                	lw	a4,8(a5)
    2798:	03277163          	bgeu	a4,s2,27ba <malloc+0xb0>
    if (p == freep)
    279c:	6098                	ld	a4,0(s1)
    279e:	853e                	mv	a0,a5
    27a0:	fef71ae3          	bne	a4,a5,2794 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
    27a4:	8552                	mv	a0,s4
    27a6:	9ffff0ef          	jal	21a4 <sbrk>
  if (p == SBRK_ERROR)
    27aa:	fd551ee3          	bne	a0,s5,2786 <malloc+0x7c>
        return 0;
    27ae:	4501                	li	a0,0
    27b0:	74a2                	ld	s1,40(sp)
    27b2:	6a42                	ld	s4,16(sp)
    27b4:	6aa2                	ld	s5,8(sp)
    27b6:	6b02                	ld	s6,0(sp)
    27b8:	a03d                	j	27e6 <malloc+0xdc>
    27ba:	74a2                	ld	s1,40(sp)
    27bc:	6a42                	ld	s4,16(sp)
    27be:	6aa2                	ld	s5,8(sp)
    27c0:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
    27c2:	fae90fe3          	beq	s2,a4,2780 <malloc+0x76>
        p->s.size -= nunits;
    27c6:	4137073b          	subw	a4,a4,s3
    27ca:	c798                	sw	a4,8(a5)
        p += p->s.size;
    27cc:	02071693          	slli	a3,a4,0x20
    27d0:	01c6d713          	srli	a4,a3,0x1c
    27d4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    27d6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    27da:	00002717          	auipc	a4,0x2
    27de:	82a73323          	sd	a0,-2010(a4) # 4000 <freep>
      return (void *)(p + 1);
    27e2:	01078513          	addi	a0,a5,16
  }
}
    27e6:	70e2                	ld	ra,56(sp)
    27e8:	7442                	ld	s0,48(sp)
    27ea:	7902                	ld	s2,32(sp)
    27ec:	69e2                	ld	s3,24(sp)
    27ee:	6121                	addi	sp,sp,64
    27f0:	8082                	ret
    27f2:	74a2                	ld	s1,40(sp)
    27f4:	6a42                	ld	s4,16(sp)
    27f6:	6aa2                	ld	s5,8(sp)
    27f8:	6b02                	ld	s6,0(sp)
    27fa:	b7f5                	j	27e6 <malloc+0xdc>
