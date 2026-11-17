
user/_symlinktest:     file format elf64-littleriscv


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
      12:	ed258593          	addi	a1,a1,-302 # 1ee0 <malloc+0x100>
      16:	4509                	li	a0,2
      18:	4e3010ef          	jal	1cfa <fprintf>
    exit(1);
      1c:	4505                	li	a0,1
      1e:	091010ef          	jal	18ae <exit>

0000000000000022 <unavailable>:
#include "user/fs_test.h"
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
      2c:	0c3010ef          	jal	18ee <open>
  if (fd >= 0)
      30:	00055663          	bgez	a0,3c <unavailable+0x1a>
    close(fd);
  check(fd < 0, "dangling link, cycle, or excessive chain must fail");
}
      34:	60a2                	ld	ra,8(sp)
      36:	6402                	ld	s0,0(sp)
      38:	0141                	addi	sp,sp,16
      3a:	8082                	ret
    close(fd);
      3c:	09b010ef          	jal	18d6 <close>
    fprintf(2, "TEST FAILURE: %s\n", why);
      40:	00002617          	auipc	a2,0x2
      44:	eb860613          	addi	a2,a2,-328 # 1ef8 <malloc+0x118>
      48:	00002597          	auipc	a1,0x2
      4c:	e9858593          	addi	a1,a1,-360 # 1ee0 <malloc+0x100>
      50:	4509                	li	a0,2
      52:	4a9010ef          	jal	1cfa <fprintf>
    exit(1);
      56:	4505                	li	a0,1
      58:	057010ef          	jal	18ae <exit>

000000000000005c <main>:
        "exactly one creator owns the destination");
}

int
main(void)
{
      5c:	d5010113          	addi	sp,sp,-688
      60:	2a113423          	sd	ra,680(sp)
      64:	2a813023          	sd	s0,672(sp)
      68:	1d00                	addi	s0,sp,688
  check(mkdir("fst_syms.tmp") == 0 && chdir("fst_syms.tmp") == 0,
      6a:	00002517          	auipc	a0,0x2
      6e:	ec650513          	addi	a0,a0,-314 # 1f30 <malloc+0x150>
      72:	0a5010ef          	jal	1916 <mkdir>
      76:	cd0d                	beqz	a0,b0 <main+0x54>
      78:	28913c23          	sd	s1,664(sp)
      7c:	29213823          	sd	s2,656(sp)
      80:	29313423          	sd	s3,648(sp)
      84:	29413023          	sd	s4,640(sp)
      88:	27513c23          	sd	s5,632(sp)
      8c:	27613823          	sd	s6,624(sp)
      90:	27713423          	sd	s7,616(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
      94:	00002617          	auipc	a2,0x2
      98:	eac60613          	addi	a2,a2,-340 # 1f40 <malloc+0x160>
      9c:	00002597          	auipc	a1,0x2
      a0:	e4458593          	addi	a1,a1,-444 # 1ee0 <malloc+0x100>
      a4:	4509                	li	a0,2
      a6:	455010ef          	jal	1cfa <fprintf>
    exit(1);
      aa:	4505                	li	a0,1
      ac:	003010ef          	jal	18ae <exit>
      b0:	28913c23          	sd	s1,664(sp)
      b4:	00002517          	auipc	a0,0x2
      b8:	e7c50513          	addi	a0,a0,-388 # 1f30 <malloc+0x150>
      bc:	063010ef          	jal	191e <chdir>
  if (!ok) {
      c0:	fd55                	bnez	a0,7c <main+0x20>
        "create symlink test directory");
  struct stat st, target;
  const char text[] = "hello\n";
      c2:	6c6c67b7          	lui	a5,0x6c6c6
      c6:	56878793          	addi	a5,a5,1384 # 6c6c6568 <base+0x6c6c1558>
      ca:	f6f42c23          	sw	a5,-136(s0)
      ce:	6785                	lui	a5,0x1
      d0:	a6f78793          	addi	a5,a5,-1425 # a6f <main+0xa13>
      d4:	f6f41e23          	sh	a5,-132(s0)
      d8:	f6040f23          	sb	zero,-130(s0)
  int fd = open("sl_target", O_CREATE | O_WRONLY | O_TRUNC);
      dc:	60100593          	li	a1,1537
      e0:	00002517          	auipc	a0,0x2
      e4:	3a850513          	addi	a0,a0,936 # 2488 <malloc+0x6a8>
      e8:	007010ef          	jal	18ee <open>
      ec:	84aa                	mv	s1,a0
  check(fd >= 0 && write(fd, text, 6) == 6, "create symlink target");
      ee:	02055c63          	bgez	a0,126 <main+0xca>
      f2:	29213823          	sd	s2,656(sp)
      f6:	29313423          	sd	s3,648(sp)
      fa:	29413023          	sd	s4,640(sp)
      fe:	27513c23          	sd	s5,632(sp)
     102:	27613823          	sd	s6,624(sp)
     106:	27713423          	sd	s7,616(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     10a:	00002617          	auipc	a2,0x2
     10e:	e5660613          	addi	a2,a2,-426 # 1f60 <malloc+0x180>
     112:	00002597          	auipc	a1,0x2
     116:	dce58593          	addi	a1,a1,-562 # 1ee0 <malloc+0x100>
     11a:	4509                	li	a0,2
     11c:	3df010ef          	jal	1cfa <fprintf>
    exit(1);
     120:	4505                	li	a0,1
     122:	78c010ef          	jal	18ae <exit>
     126:	4619                	li	a2,6
     128:	f7840593          	addi	a1,s0,-136
     12c:	7a2010ef          	jal	18ce <write>
  if (!ok) {
     130:	4799                	li	a5,6
     132:	fcf510e3          	bne	a0,a5,f2 <main+0x96>
  check(close(fd) == 0, "close target");
     136:	8526                	mv	a0,s1
     138:	79e010ef          	jal	18d6 <close>
     13c:	e159                	bnez	a0,1c2 <main+0x166>
  check(stat("sl_target", &target) == 0, "stat target");
     13e:	f8040593          	addi	a1,s0,-128
     142:	00002517          	auipc	a0,0x2
     146:	34650513          	addi	a0,a0,838 # 2488 <malloc+0x6a8>
     14a:	602010ef          	jal	174c <stat>
     14e:	e545                	bnez	a0,1f6 <main+0x19a>
  check(symlink("sl_target", "sl_link") == 0, "create symlink");
     150:	00002597          	auipc	a1,0x2
     154:	e4858593          	addi	a1,a1,-440 # 1f98 <malloc+0x1b8>
     158:	00002517          	auipc	a0,0x2
     15c:	33050513          	addi	a0,a0,816 # 2488 <malloc+0x6a8>
     160:	007010ef          	jal	1966 <symlink>
     164:	e179                	bnez	a0,22a <main+0x1ce>
  fd = open("sl_link", O_RDONLY);
     166:	4581                	li	a1,0
     168:	00002517          	auipc	a0,0x2
     16c:	e3050513          	addi	a0,a0,-464 # 1f98 <malloc+0x1b8>
     170:	77e010ef          	jal	18ee <open>
     174:	84aa                	mv	s1,a0
     176:	0e054463          	bltz	a0,25e <main+0x202>
  check(fd >= 0, "follow symlink");
  check(read(fd, fs_buffer, 8) == 6 && memcmp(fs_buffer, text, 6) == 0,
     17a:	4621                	li	a2,8
     17c:	00003597          	auipc	a1,0x3
     180:	e9458593          	addi	a1,a1,-364 # 3010 <fs_buffer>
     184:	742010ef          	jal	18c6 <read>
     188:	4799                	li	a5,6
     18a:	10f50463          	beq	a0,a5,292 <main+0x236>
     18e:	29213823          	sd	s2,656(sp)
     192:	29313423          	sd	s3,648(sp)
     196:	29413023          	sd	s4,640(sp)
     19a:	27513c23          	sd	s5,632(sp)
     19e:	27613823          	sd	s6,624(sp)
     1a2:	27713423          	sd	s7,616(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     1a6:	00002617          	auipc	a2,0x2
     1aa:	e1a60613          	addi	a2,a2,-486 # 1fc0 <malloc+0x1e0>
     1ae:	00002597          	auipc	a1,0x2
     1b2:	d3258593          	addi	a1,a1,-718 # 1ee0 <malloc+0x100>
     1b6:	4509                	li	a0,2
     1b8:	343010ef          	jal	1cfa <fprintf>
    exit(1);
     1bc:	4505                	li	a0,1
     1be:	6f0010ef          	jal	18ae <exit>
     1c2:	29213823          	sd	s2,656(sp)
     1c6:	29313423          	sd	s3,648(sp)
     1ca:	29413023          	sd	s4,640(sp)
     1ce:	27513c23          	sd	s5,632(sp)
     1d2:	27613823          	sd	s6,624(sp)
     1d6:	27713423          	sd	s7,616(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     1da:	00002617          	auipc	a2,0x2
     1de:	d9e60613          	addi	a2,a2,-610 # 1f78 <malloc+0x198>
     1e2:	00002597          	auipc	a1,0x2
     1e6:	cfe58593          	addi	a1,a1,-770 # 1ee0 <malloc+0x100>
     1ea:	4509                	li	a0,2
     1ec:	30f010ef          	jal	1cfa <fprintf>
    exit(1);
     1f0:	4505                	li	a0,1
     1f2:	6bc010ef          	jal	18ae <exit>
     1f6:	29213823          	sd	s2,656(sp)
     1fa:	29313423          	sd	s3,648(sp)
     1fe:	29413023          	sd	s4,640(sp)
     202:	27513c23          	sd	s5,632(sp)
     206:	27613823          	sd	s6,624(sp)
     20a:	27713423          	sd	s7,616(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     20e:	00002617          	auipc	a2,0x2
     212:	d7a60613          	addi	a2,a2,-646 # 1f88 <malloc+0x1a8>
     216:	00002597          	auipc	a1,0x2
     21a:	cca58593          	addi	a1,a1,-822 # 1ee0 <malloc+0x100>
     21e:	4509                	li	a0,2
     220:	2db010ef          	jal	1cfa <fprintf>
    exit(1);
     224:	4505                	li	a0,1
     226:	688010ef          	jal	18ae <exit>
     22a:	29213823          	sd	s2,656(sp)
     22e:	29313423          	sd	s3,648(sp)
     232:	29413023          	sd	s4,640(sp)
     236:	27513c23          	sd	s5,632(sp)
     23a:	27613823          	sd	s6,624(sp)
     23e:	27713423          	sd	s7,616(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     242:	00002617          	auipc	a2,0x2
     246:	d5e60613          	addi	a2,a2,-674 # 1fa0 <malloc+0x1c0>
     24a:	00002597          	auipc	a1,0x2
     24e:	c9658593          	addi	a1,a1,-874 # 1ee0 <malloc+0x100>
     252:	4509                	li	a0,2
     254:	2a7010ef          	jal	1cfa <fprintf>
    exit(1);
     258:	4505                	li	a0,1
     25a:	654010ef          	jal	18ae <exit>
     25e:	29213823          	sd	s2,656(sp)
     262:	29313423          	sd	s3,648(sp)
     266:	29413023          	sd	s4,640(sp)
     26a:	27513c23          	sd	s5,632(sp)
     26e:	27613823          	sd	s6,624(sp)
     272:	27713423          	sd	s7,616(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     276:	00002617          	auipc	a2,0x2
     27a:	d3a60613          	addi	a2,a2,-710 # 1fb0 <malloc+0x1d0>
     27e:	00002597          	auipc	a1,0x2
     282:	c6258593          	addi	a1,a1,-926 # 1ee0 <malloc+0x100>
     286:	4509                	li	a0,2
     288:	273010ef          	jal	1cfa <fprintf>
    exit(1);
     28c:	4505                	li	a0,1
     28e:	620010ef          	jal	18ae <exit>
     292:	862a                	mv	a2,a0
     294:	f7840593          	addi	a1,s0,-136
     298:	00003517          	auipc	a0,0x3
     29c:	d7850513          	addi	a0,a0,-648 # 3010 <fs_buffer>
     2a0:	590010ef          	jal	1830 <memcmp>
  if (!ok) {
     2a4:	ee0515e3          	bnez	a0,18e <main+0x132>
        "exact target contents");
  check(close(fd) == 0, "close followed link");
     2a8:	8526                	mv	a0,s1
     2aa:	62c010ef          	jal	18d6 <close>
     2ae:	e539                	bnez	a0,2fc <main+0x2a0>
  fd = open("sl_link", O_RDONLY | O_NOFOLLOW);
     2b0:	6585                	lui	a1,0x1
     2b2:	80058593          	addi	a1,a1,-2048 # 800 <main+0x7a4>
     2b6:	00002517          	auipc	a0,0x2
     2ba:	ce250513          	addi	a0,a0,-798 # 1f98 <malloc+0x1b8>
     2be:	630010ef          	jal	18ee <open>
     2c2:	84aa                	mv	s1,a0
  check(fd >= 0 && fstat(fd, &st) == 0 && st.type == T_SYMLINK &&
     2c4:	06055663          	bgez	a0,330 <main+0x2d4>
     2c8:	29213823          	sd	s2,656(sp)
     2cc:	29313423          	sd	s3,648(sp)
     2d0:	29413023          	sd	s4,640(sp)
     2d4:	27513c23          	sd	s5,632(sp)
     2d8:	27613823          	sd	s6,624(sp)
     2dc:	27713423          	sd	s7,616(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     2e0:	00002617          	auipc	a2,0x2
     2e4:	d1060613          	addi	a2,a2,-752 # 1ff0 <malloc+0x210>
     2e8:	00002597          	auipc	a1,0x2
     2ec:	bf858593          	addi	a1,a1,-1032 # 1ee0 <malloc+0x100>
     2f0:	4509                	li	a0,2
     2f2:	209010ef          	jal	1cfa <fprintf>
    exit(1);
     2f6:	4505                	li	a0,1
     2f8:	5b6010ef          	jal	18ae <exit>
     2fc:	29213823          	sd	s2,656(sp)
     300:	29313423          	sd	s3,648(sp)
     304:	29413023          	sd	s4,640(sp)
     308:	27513c23          	sd	s5,632(sp)
     30c:	27613823          	sd	s6,624(sp)
     310:	27713423          	sd	s7,616(sp)
    fprintf(2, "TEST FAILURE: %s\n", why);
     314:	00002617          	auipc	a2,0x2
     318:	cc460613          	addi	a2,a2,-828 # 1fd8 <malloc+0x1f8>
     31c:	00002597          	auipc	a1,0x2
     320:	bc458593          	addi	a1,a1,-1084 # 1ee0 <malloc+0x100>
     324:	4509                	li	a0,2
     326:	1d5010ef          	jal	1cfa <fprintf>
    exit(1);
     32a:	4505                	li	a0,1
     32c:	582010ef          	jal	18ae <exit>
     330:	f9840593          	addi	a1,s0,-104
     334:	5d2010ef          	jal	1906 <fstat>
     338:	ed3d                	bnez	a0,3b6 <main+0x35a>
     33a:	fa041703          	lh	a4,-96(s0)
     33e:	4791                	li	a5,4
     340:	00f70f63          	beq	a4,a5,35e <main+0x302>
     344:	29213823          	sd	s2,656(sp)
     348:	29313423          	sd	s3,648(sp)
     34c:	29413023          	sd	s4,640(sp)
     350:	27513c23          	sd	s5,632(sp)
     354:	27613823          	sd	s6,624(sp)
     358:	27713423          	sd	s7,616(sp)
     35c:	b751                	j	2e0 <main+0x284>
     35e:	29213823          	sd	s2,656(sp)
     362:	29313423          	sd	s3,648(sp)
     366:	29413023          	sd	s4,640(sp)
     36a:	27513c23          	sd	s5,632(sp)
     36e:	27613823          	sd	s6,624(sp)
     372:	27713423          	sd	s7,616(sp)
  if (!ok) {
     376:	f9c42703          	lw	a4,-100(s0)
     37a:	f8442783          	lw	a5,-124(s0)
     37e:	f6f701e3          	beq	a4,a5,2e0 <main+0x284>
          st.ino != target.ino,
        "NOFOLLOW returns link inode");
  check(read(fd, fs_buffer, 32) == sizeof("sl_target") &&
     382:	02000613          	li	a2,32
     386:	00003597          	auipc	a1,0x3
     38a:	c8a58593          	addi	a1,a1,-886 # 3010 <fs_buffer>
     38e:	8526                	mv	a0,s1
     390:	536010ef          	jal	18c6 <read>
     394:	47a9                	li	a5,10
     396:	02f50d63          	beq	a0,a5,3d0 <main+0x374>
    fprintf(2, "TEST FAILURE: %s\n", why);
     39a:	00002617          	auipc	a2,0x2
     39e:	c7660613          	addi	a2,a2,-906 # 2010 <malloc+0x230>
     3a2:	00002597          	auipc	a1,0x2
     3a6:	b3e58593          	addi	a1,a1,-1218 # 1ee0 <malloc+0x100>
     3aa:	4509                	li	a0,2
     3ac:	14f010ef          	jal	1cfa <fprintf>
    exit(1);
     3b0:	4505                	li	a0,1
     3b2:	4fc010ef          	jal	18ae <exit>
     3b6:	29213823          	sd	s2,656(sp)
     3ba:	29313423          	sd	s3,648(sp)
     3be:	29413023          	sd	s4,640(sp)
     3c2:	27513c23          	sd	s5,632(sp)
     3c6:	27613823          	sd	s6,624(sp)
     3ca:	27713423          	sd	s7,616(sp)
     3ce:	bf09                	j	2e0 <main+0x284>
          memcmp(fs_buffer, "sl_target", sizeof("sl_target")) == 0,
     3d0:	862a                	mv	a2,a0
     3d2:	00002597          	auipc	a1,0x2
     3d6:	0b658593          	addi	a1,a1,182 # 2488 <malloc+0x6a8>
     3da:	00003517          	auipc	a0,0x3
     3de:	c3650513          	addi	a0,a0,-970 # 3010 <fs_buffer>
     3e2:	44e010ef          	jal	1830 <memcmp>
  if (!ok) {
     3e6:	f955                	bnez	a0,39a <main+0x33e>
        "NOFOLLOW returns terminated target pathname");
  check(close(fd) == 0, "close link inode");
     3e8:	8526                	mv	a0,s1
     3ea:	4ec010ef          	jal	18d6 <close>
     3ee:	e559                	bnez	a0,47c <main+0x420>
  check(symlink("missing", "sl_dang") == 0, "create dangling link");
     3f0:	00002597          	auipc	a1,0x2
     3f4:	c6858593          	addi	a1,a1,-920 # 2058 <malloc+0x278>
     3f8:	00002517          	auipc	a0,0x2
     3fc:	c6850513          	addi	a0,a0,-920 # 2060 <malloc+0x280>
     400:	566010ef          	jal	1966 <symlink>
     404:	e951                	bnez	a0,498 <main+0x43c>
  unavailable("sl_dang");
     406:	00002517          	auipc	a0,0x2
     40a:	c5250513          	addi	a0,a0,-942 # 2058 <malloc+0x278>
     40e:	c15ff0ef          	jal	22 <unavailable>
  check(symlink("other", "sl_dang") == -1,
     412:	00002597          	auipc	a1,0x2
     416:	c4658593          	addi	a1,a1,-954 # 2058 <malloc+0x278>
     41a:	00002517          	auipc	a0,0x2
     41e:	c6650513          	addi	a0,a0,-922 # 2080 <malloc+0x2a0>
     422:	544010ef          	jal	1966 <symlink>
     426:	57fd                	li	a5,-1
     428:	08f51663          	bne	a0,a5,4b4 <main+0x458>
        "reject existing dangling destination");
  check(symlink("other", "sl_target") == -1,
     42c:	00002597          	auipc	a1,0x2
     430:	05c58593          	addi	a1,a1,92 # 2488 <malloc+0x6a8>
     434:	00002517          	auipc	a0,0x2
     438:	c4c50513          	addi	a0,a0,-948 # 2080 <malloc+0x2a0>
     43c:	52a010ef          	jal	1966 <symlink>
     440:	57fd                	li	a5,-1
     442:	08f51763          	bne	a0,a5,4d0 <main+0x474>
        "reject existing regular destination");
  check(symlink("", "sl_empty") == -1 && symlink("sl_target", "") == -1,
     446:	00002597          	auipc	a1,0x2
     44a:	c9258593          	addi	a1,a1,-878 # 20d8 <malloc+0x2f8>
     44e:	00002517          	auipc	a0,0x2
     452:	d7250513          	addi	a0,a0,-654 # 21c0 <malloc+0x3e0>
     456:	510010ef          	jal	1966 <symlink>
     45a:	57fd                	li	a5,-1
     45c:	08f50863          	beq	a0,a5,4ec <main+0x490>
    fprintf(2, "TEST FAILURE: %s\n", why);
     460:	00002617          	auipc	a2,0x2
     464:	c8860613          	addi	a2,a2,-888 # 20e8 <malloc+0x308>
     468:	00002597          	auipc	a1,0x2
     46c:	a7858593          	addi	a1,a1,-1416 # 1ee0 <malloc+0x100>
     470:	4509                	li	a0,2
     472:	089010ef          	jal	1cfa <fprintf>
    exit(1);
     476:	4505                	li	a0,1
     478:	436010ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     47c:	00002617          	auipc	a2,0x2
     480:	bc460613          	addi	a2,a2,-1084 # 2040 <malloc+0x260>
     484:	00002597          	auipc	a1,0x2
     488:	a5c58593          	addi	a1,a1,-1444 # 1ee0 <malloc+0x100>
     48c:	4509                	li	a0,2
     48e:	06d010ef          	jal	1cfa <fprintf>
    exit(1);
     492:	4505                	li	a0,1
     494:	41a010ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     498:	00002617          	auipc	a2,0x2
     49c:	bd060613          	addi	a2,a2,-1072 # 2068 <malloc+0x288>
     4a0:	00002597          	auipc	a1,0x2
     4a4:	a4058593          	addi	a1,a1,-1472 # 1ee0 <malloc+0x100>
     4a8:	4509                	li	a0,2
     4aa:	051010ef          	jal	1cfa <fprintf>
    exit(1);
     4ae:	4505                	li	a0,1
     4b0:	3fe010ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     4b4:	00002617          	auipc	a2,0x2
     4b8:	bd460613          	addi	a2,a2,-1068 # 2088 <malloc+0x2a8>
     4bc:	00002597          	auipc	a1,0x2
     4c0:	a2458593          	addi	a1,a1,-1500 # 1ee0 <malloc+0x100>
     4c4:	4509                	li	a0,2
     4c6:	035010ef          	jal	1cfa <fprintf>
    exit(1);
     4ca:	4505                	li	a0,1
     4cc:	3e2010ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     4d0:	00002617          	auipc	a2,0x2
     4d4:	be060613          	addi	a2,a2,-1056 # 20b0 <malloc+0x2d0>
     4d8:	00002597          	auipc	a1,0x2
     4dc:	a0858593          	addi	a1,a1,-1528 # 1ee0 <malloc+0x100>
     4e0:	4509                	li	a0,2
     4e2:	019010ef          	jal	1cfa <fprintf>
    exit(1);
     4e6:	4505                	li	a0,1
     4e8:	3c6010ef          	jal	18ae <exit>
     4ec:	00002597          	auipc	a1,0x2
     4f0:	cd458593          	addi	a1,a1,-812 # 21c0 <malloc+0x3e0>
     4f4:	00002517          	auipc	a0,0x2
     4f8:	f9450513          	addi	a0,a0,-108 # 2488 <malloc+0x6a8>
     4fc:	46a010ef          	jal	1966 <symlink>
  if (!ok) {
     500:	57fd                	li	a5,-1
     502:	f4f51fe3          	bne	a0,a5,460 <main+0x404>
        "reject empty paths");
  char longpath[MAXPATH + 1];
  memset(longpath, 'x', sizeof(longpath));
     506:	ef040493          	addi	s1,s0,-272
     50a:	08100613          	li	a2,129
     50e:	07800593          	li	a1,120
     512:	8526                	mv	a0,s1
     514:	170010ef          	jal	1684 <memset>
  longpath[MAXPATH - 1] = 0;
     518:	f60407a3          	sb	zero,-145(s0)
  check(symlink(longpath, "sl_long") == 0, "accept MAXPATH-1 characters");
     51c:	00002597          	auipc	a1,0x2
     520:	be458593          	addi	a1,a1,-1052 # 2100 <malloc+0x320>
     524:	8526                	mv	a0,s1
     526:	440010ef          	jal	1966 <symlink>
     52a:	10051263          	bnez	a0,62e <main+0x5d2>
  check(unlink("sl_long") == 0, "remove maximum target");
     52e:	00002517          	auipc	a0,0x2
     532:	bd250513          	addi	a0,a0,-1070 # 2100 <malloc+0x320>
     536:	3c8010ef          	jal	18fe <unlink>
     53a:	84aa                	mv	s1,a0
     53c:	10051763          	bnez	a0,64a <main+0x5ee>
  longpath[MAXPATH - 1] = 'x';
     540:	07800793          	li	a5,120
     544:	f6f407a3          	sb	a5,-145(s0)
  longpath[MAXPATH] = 0;
     548:	f6040823          	sb	zero,-144(s0)
  check(symlink(longpath, "sl_long") == -1, "reject MAXPATH characters");
     54c:	00002597          	auipc	a1,0x2
     550:	bb458593          	addi	a1,a1,-1100 # 2100 <malloc+0x320>
     554:	ef040513          	addi	a0,s0,-272
     558:	40e010ef          	jal	1966 <symlink>
     55c:	57fd                	li	a5,-1
     55e:	10f51463          	bne	a0,a5,666 <main+0x60a>
  char prev[14] = "sl_target", name[14] = "sl_c00";
     562:	00002797          	auipc	a5,0x2
     566:	58e78793          	addi	a5,a5,1422 # 2af0 <malloc+0xd10>
     56a:	6398                	ld	a4,0(a5)
     56c:	eee43023          	sd	a4,-288(s0)
     570:	0087d703          	lhu	a4,8(a5)
     574:	eee41423          	sh	a4,-280(s0)
     578:	ee041523          	sh	zero,-278(s0)
     57c:	ee041623          	sh	zero,-276(s0)
     580:	4b98                	lw	a4,16(a5)
     582:	ece42823          	sw	a4,-304(s0)
     586:	0167c783          	lbu	a5,22(a5)
     58a:	ecf40b23          	sb	a5,-298(s0)
     58e:	ec040ba3          	sb	zero,-297(s0)
     592:	ec040c23          	sb	zero,-296(s0)
     596:	ec040ca3          	sb	zero,-295(s0)
     59a:	ec040d23          	sb	zero,-294(s0)
     59e:	ec040da3          	sb	zero,-293(s0)
     5a2:	ec040e23          	sb	zero,-292(s0)
     5a6:	ec040ea3          	sb	zero,-291(s0)
  for (int i = 0; i < 11; i++) {
    name[4] = '0' + i / 10;
     5aa:	66666a37          	lui	s4,0x66666
     5ae:	667a0a13          	addi	s4,s4,1639 # 66666667 <base+0x66661657>
    name[5] = '0' + i % 10;
    check(symlink(prev, name) == 0, "create link chain");
     5b2:	ed040993          	addi	s3,s0,-304
     5b6:	ee040913          	addi	s2,s0,-288
  for (int i = 0; i < 11; i++) {
     5ba:	4aad                	li	s5,11
    name[4] = '0' + i / 10;
     5bc:	03448733          	mul	a4,s1,s4
     5c0:	9709                	srai	a4,a4,0x22
     5c2:	41f4d79b          	sraiw	a5,s1,0x1f
     5c6:	9f1d                	subw	a4,a4,a5
     5c8:	0307079b          	addiw	a5,a4,48
     5cc:	ecf40a23          	sb	a5,-300(s0)
    name[5] = '0' + i % 10;
     5d0:	0027179b          	slliw	a5,a4,0x2
     5d4:	9fb9                	addw	a5,a5,a4
     5d6:	0017979b          	slliw	a5,a5,0x1
     5da:	40f487bb          	subw	a5,s1,a5
     5de:	0307879b          	addiw	a5,a5,48
     5e2:	ecf40aa3          	sb	a5,-299(s0)
    check(symlink(prev, name) == 0, "create link chain");
     5e6:	85ce                	mv	a1,s3
     5e8:	854a                	mv	a0,s2
     5ea:	37c010ef          	jal	1966 <symlink>
     5ee:	e951                	bnez	a0,682 <main+0x626>
    strcpy(prev, name);
     5f0:	85ce                	mv	a1,s3
     5f2:	854a                	mv	a0,s2
     5f4:	014010ef          	jal	1608 <strcpy>
  for (int i = 0; i < 11; i++) {
     5f8:	2485                	addiw	s1,s1,1
     5fa:	fd5491e3          	bne	s1,s5,5bc <main+0x560>
  }
  fd = open("sl_c09", O_RDONLY);
     5fe:	4581                	li	a1,0
     600:	00002517          	auipc	a0,0x2
     604:	b7850513          	addi	a0,a0,-1160 # 2178 <malloc+0x398>
     608:	2e6010ef          	jal	18ee <open>
     60c:	84aa                	mv	s1,a0
  check(fd >= 0 && read(fd, fs_buffer, 8) == 6 &&
     60e:	08055863          	bgez	a0,69e <main+0x642>
    fprintf(2, "TEST FAILURE: %s\n", why);
     612:	00002617          	auipc	a2,0x2
     616:	b6e60613          	addi	a2,a2,-1170 # 2180 <malloc+0x3a0>
     61a:	00002597          	auipc	a1,0x2
     61e:	8c658593          	addi	a1,a1,-1850 # 1ee0 <malloc+0x100>
     622:	4509                	li	a0,2
     624:	6d6010ef          	jal	1cfa <fprintf>
    exit(1);
     628:	4505                	li	a0,1
     62a:	284010ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     62e:	00002617          	auipc	a2,0x2
     632:	ada60613          	addi	a2,a2,-1318 # 2108 <malloc+0x328>
     636:	00002597          	auipc	a1,0x2
     63a:	8aa58593          	addi	a1,a1,-1878 # 1ee0 <malloc+0x100>
     63e:	4509                	li	a0,2
     640:	6ba010ef          	jal	1cfa <fprintf>
    exit(1);
     644:	4505                	li	a0,1
     646:	268010ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     64a:	00002617          	auipc	a2,0x2
     64e:	ade60613          	addi	a2,a2,-1314 # 2128 <malloc+0x348>
     652:	00002597          	auipc	a1,0x2
     656:	88e58593          	addi	a1,a1,-1906 # 1ee0 <malloc+0x100>
     65a:	4509                	li	a0,2
     65c:	69e010ef          	jal	1cfa <fprintf>
    exit(1);
     660:	4505                	li	a0,1
     662:	24c010ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     666:	00002617          	auipc	a2,0x2
     66a:	ada60613          	addi	a2,a2,-1318 # 2140 <malloc+0x360>
     66e:	00002597          	auipc	a1,0x2
     672:	87258593          	addi	a1,a1,-1934 # 1ee0 <malloc+0x100>
     676:	4509                	li	a0,2
     678:	682010ef          	jal	1cfa <fprintf>
    exit(1);
     67c:	4505                	li	a0,1
     67e:	230010ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     682:	00002617          	auipc	a2,0x2
     686:	ade60613          	addi	a2,a2,-1314 # 2160 <malloc+0x380>
     68a:	00002597          	auipc	a1,0x2
     68e:	85658593          	addi	a1,a1,-1962 # 1ee0 <malloc+0x100>
     692:	4509                	li	a0,2
     694:	666010ef          	jal	1cfa <fprintf>
    exit(1);
     698:	4505                	li	a0,1
     69a:	214010ef          	jal	18ae <exit>
     69e:	4621                	li	a2,8
     6a0:	00003597          	auipc	a1,0x3
     6a4:	97058593          	addi	a1,a1,-1680 # 3010 <fs_buffer>
     6a8:	21e010ef          	jal	18c6 <read>
     6ac:	4799                	li	a5,6
     6ae:	f6f512e3          	bne	a0,a5,612 <main+0x5b6>
          memcmp(fs_buffer, text, 6) == 0,
     6b2:	862a                	mv	a2,a0
     6b4:	f7840593          	addi	a1,s0,-136
     6b8:	00003517          	auipc	a0,0x3
     6bc:	95850513          	addi	a0,a0,-1704 # 3010 <fs_buffer>
     6c0:	170010ef          	jal	1830 <memcmp>
  if (!ok) {
     6c4:	f539                	bnez	a0,612 <main+0x5b6>
        "follow exactly ten links");
  check(close(fd) == 0, "close chain");
     6c6:	8526                	mv	a0,s1
     6c8:	20e010ef          	jal	18d6 <close>
     6cc:	e121                	bnez	a0,70c <main+0x6b0>
  unavailable("sl_c10");
     6ce:	00002517          	auipc	a0,0x2
     6d2:	ae250513          	addi	a0,a0,-1310 # 21b0 <malloc+0x3d0>
     6d6:	94dff0ef          	jal	22 <unavailable>
  check(symlink("sl_loopb", "sl_loopa") == 0 &&
     6da:	00002597          	auipc	a1,0x2
     6de:	ade58593          	addi	a1,a1,-1314 # 21b8 <malloc+0x3d8>
     6e2:	00002517          	auipc	a0,0x2
     6e6:	ae650513          	addi	a0,a0,-1306 # 21c8 <malloc+0x3e8>
     6ea:	27c010ef          	jal	1966 <symlink>
     6ee:	cd0d                	beqz	a0,728 <main+0x6cc>
    fprintf(2, "TEST FAILURE: %s\n", why);
     6f0:	00002617          	auipc	a2,0x2
     6f4:	ae860613          	addi	a2,a2,-1304 # 21d8 <malloc+0x3f8>
     6f8:	00001597          	auipc	a1,0x1
     6fc:	7e858593          	addi	a1,a1,2024 # 1ee0 <malloc+0x100>
     700:	4509                	li	a0,2
     702:	5f8010ef          	jal	1cfa <fprintf>
    exit(1);
     706:	4505                	li	a0,1
     708:	1a6010ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     70c:	00002617          	auipc	a2,0x2
     710:	a9460613          	addi	a2,a2,-1388 # 21a0 <malloc+0x3c0>
     714:	00001597          	auipc	a1,0x1
     718:	7cc58593          	addi	a1,a1,1996 # 1ee0 <malloc+0x100>
     71c:	4509                	li	a0,2
     71e:	5dc010ef          	jal	1cfa <fprintf>
    exit(1);
     722:	4505                	li	a0,1
     724:	18a010ef          	jal	18ae <exit>
          symlink("sl_loopa", "sl_loopb") == 0,
     728:	00002597          	auipc	a1,0x2
     72c:	aa058593          	addi	a1,a1,-1376 # 21c8 <malloc+0x3e8>
     730:	00002517          	auipc	a0,0x2
     734:	a8850513          	addi	a0,a0,-1400 # 21b8 <malloc+0x3d8>
     738:	22e010ef          	jal	1966 <symlink>
  if (!ok) {
     73c:	f955                	bnez	a0,6f0 <main+0x694>
        "create cycle");
  unavailable("sl_loopa");
     73e:	00002517          	auipc	a0,0x2
     742:	a7a50513          	addi	a0,a0,-1414 # 21b8 <malloc+0x3d8>
     746:	8ddff0ef          	jal	22 <unavailable>
  check(link("sl_link", "sl_hard") == 0, "hard-link the symlink");
     74a:	00002597          	auipc	a1,0x2
     74e:	a9e58593          	addi	a1,a1,-1378 # 21e8 <malloc+0x408>
     752:	00002517          	auipc	a0,0x2
     756:	84650513          	addi	a0,a0,-1978 # 1f98 <malloc+0x1b8>
     75a:	1b4010ef          	jal	190e <link>
     75e:	e91d                	bnez	a0,794 <main+0x738>
  fd = open("sl_hard", O_RDONLY | O_NOFOLLOW);
     760:	6585                	lui	a1,0x1
     762:	80058593          	addi	a1,a1,-2048 # 800 <main+0x7a4>
     766:	00002517          	auipc	a0,0x2
     76a:	a8250513          	addi	a0,a0,-1406 # 21e8 <malloc+0x408>
     76e:	180010ef          	jal	18ee <open>
     772:	84aa                	mv	s1,a0
  struct stat hard;
  check(fd >= 0 && fstat(fd, &hard) == 0 && hard.type == T_SYMLINK &&
     774:	02055e63          	bgez	a0,7b0 <main+0x754>
    fprintf(2, "TEST FAILURE: %s\n", why);
     778:	00002617          	auipc	a2,0x2
     77c:	a9060613          	addi	a2,a2,-1392 # 2208 <malloc+0x428>
     780:	00001597          	auipc	a1,0x1
     784:	76058593          	addi	a1,a1,1888 # 1ee0 <malloc+0x100>
     788:	4509                	li	a0,2
     78a:	570010ef          	jal	1cfa <fprintf>
    exit(1);
     78e:	4505                	li	a0,1
     790:	11e010ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     794:	00002617          	auipc	a2,0x2
     798:	a5c60613          	addi	a2,a2,-1444 # 21f0 <malloc+0x410>
     79c:	00001597          	auipc	a1,0x1
     7a0:	74458593          	addi	a1,a1,1860 # 1ee0 <malloc+0x100>
     7a4:	4509                	li	a0,2
     7a6:	554010ef          	jal	1cfa <fprintf>
    exit(1);
     7aa:	4505                	li	a0,1
     7ac:	102010ef          	jal	18ae <exit>
     7b0:	eb840593          	addi	a1,s0,-328
     7b4:	152010ef          	jal	1906 <fstat>
     7b8:	f161                	bnez	a0,778 <main+0x71c>
     7ba:	ec041703          	lh	a4,-320(s0)
     7be:	4791                	li	a5,4
     7c0:	faf71ce3          	bne	a4,a5,778 <main+0x71c>
  if (!ok) {
     7c4:	ebc42703          	lw	a4,-324(s0)
     7c8:	f9c42783          	lw	a5,-100(s0)
     7cc:	faf716e3          	bne	a4,a5,778 <main+0x71c>
          hard.ino == st.ino,
        "link must not follow symlink");
  check(close(fd) == 0 && unlink("sl_link") == 0, "unlink only the link");
     7d0:	8526                	mv	a0,s1
     7d2:	104010ef          	jal	18d6 <close>
     7d6:	cd19                	beqz	a0,7f4 <main+0x798>
    fprintf(2, "TEST FAILURE: %s\n", why);
     7d8:	00002617          	auipc	a2,0x2
     7dc:	a5060613          	addi	a2,a2,-1456 # 2228 <malloc+0x448>
     7e0:	00001597          	auipc	a1,0x1
     7e4:	70058593          	addi	a1,a1,1792 # 1ee0 <malloc+0x100>
     7e8:	4509                	li	a0,2
     7ea:	510010ef          	jal	1cfa <fprintf>
    exit(1);
     7ee:	4505                	li	a0,1
     7f0:	0be010ef          	jal	18ae <exit>
     7f4:	00001517          	auipc	a0,0x1
     7f8:	7a450513          	addi	a0,a0,1956 # 1f98 <malloc+0x1b8>
     7fc:	102010ef          	jal	18fe <unlink>
  if (!ok) {
     800:	fd61                	bnez	a0,7d8 <main+0x77c>
  fd = open("sl_target", O_RDONLY);
     802:	4581                	li	a1,0
     804:	00002517          	auipc	a0,0x2
     808:	c8450513          	addi	a0,a0,-892 # 2488 <malloc+0x6a8>
     80c:	0e2010ef          	jal	18ee <open>
     810:	84aa                	mv	s1,a0
  check(fd >= 0 && read(fd, fs_buffer, 8) == 6 &&
     812:	02055063          	bgez	a0,832 <main+0x7d6>
    fprintf(2, "TEST FAILURE: %s\n", why);
     816:	00002617          	auipc	a2,0x2
     81a:	a2a60613          	addi	a2,a2,-1494 # 2240 <malloc+0x460>
     81e:	00001597          	auipc	a1,0x1
     822:	6c258593          	addi	a1,a1,1730 # 1ee0 <malloc+0x100>
     826:	4509                	li	a0,2
     828:	4d2010ef          	jal	1cfa <fprintf>
    exit(1);
     82c:	4505                	li	a0,1
     82e:	080010ef          	jal	18ae <exit>
     832:	4621                	li	a2,8
     834:	00002597          	auipc	a1,0x2
     838:	7dc58593          	addi	a1,a1,2012 # 3010 <fs_buffer>
     83c:	08a010ef          	jal	18c6 <read>
     840:	4799                	li	a5,6
     842:	fcf51ae3          	bne	a0,a5,816 <main+0x7ba>
          memcmp(fs_buffer, text, 6) == 0,
     846:	862a                	mv	a2,a0
     848:	f7840593          	addi	a1,s0,-136
     84c:	00002517          	auipc	a0,0x2
     850:	7c450513          	addi	a0,a0,1988 # 3010 <fs_buffer>
     854:	7dd000ef          	jal	1830 <memcmp>
  if (!ok) {
     858:	fd5d                	bnez	a0,816 <main+0x7ba>
        "target survives link removal");
  check(close(fd) == 0, "close preserved target");
     85a:	8526                	mv	a0,s1
     85c:	07a010ef          	jal	18d6 <close>
     860:	ed05                	bnez	a0,898 <main+0x83c>
  const char inner[] = "inside\n";
     862:	00002797          	auipc	a5,0x2
     866:	2767b783          	ld	a5,630(a5) # 2ad8 <malloc+0xcf8>
     86a:	eaf43823          	sd	a5,-336(s0)
  check(mkdir("sl_dir") == 0 && mkdir("sl_else") == 0,
     86e:	00002517          	auipc	a0,0x2
     872:	a0a50513          	addi	a0,a0,-1526 # 2278 <malloc+0x498>
     876:	0a0010ef          	jal	1916 <mkdir>
     87a:	cd0d                	beqz	a0,8b4 <main+0x858>
    fprintf(2, "TEST FAILURE: %s\n", why);
     87c:	00002617          	auipc	a2,0x2
     880:	a0c60613          	addi	a2,a2,-1524 # 2288 <malloc+0x4a8>
     884:	00001597          	auipc	a1,0x1
     888:	65c58593          	addi	a1,a1,1628 # 1ee0 <malloc+0x100>
     88c:	4509                	li	a0,2
     88e:	46c010ef          	jal	1cfa <fprintf>
    exit(1);
     892:	4505                	li	a0,1
     894:	01a010ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     898:	00002617          	auipc	a2,0x2
     89c:	9c860613          	addi	a2,a2,-1592 # 2260 <malloc+0x480>
     8a0:	00001597          	auipc	a1,0x1
     8a4:	64058593          	addi	a1,a1,1600 # 1ee0 <malloc+0x100>
     8a8:	4509                	li	a0,2
     8aa:	450010ef          	jal	1cfa <fprintf>
    exit(1);
     8ae:	4505                	li	a0,1
     8b0:	7ff000ef          	jal	18ae <exit>
     8b4:	00002517          	auipc	a0,0x2
     8b8:	9cc50513          	addi	a0,a0,-1588 # 2280 <malloc+0x4a0>
     8bc:	05a010ef          	jal	1916 <mkdir>
  if (!ok) {
     8c0:	fd55                	bnez	a0,87c <main+0x820>
        "relative-target directories");
  fd = open("sl_dir/sl_target", O_CREATE | O_WRONLY | O_TRUNC);
     8c2:	60100593          	li	a1,1537
     8c6:	00002517          	auipc	a0,0x2
     8ca:	9e250513          	addi	a0,a0,-1566 # 22a8 <malloc+0x4c8>
     8ce:	020010ef          	jal	18ee <open>
     8d2:	84aa                	mv	s1,a0
  check(fd >= 0 && write(fd, inner, 7) == 7 && close(fd) == 0,
     8d4:	02055063          	bgez	a0,8f4 <main+0x898>
    fprintf(2, "TEST FAILURE: %s\n", why);
     8d8:	00002617          	auipc	a2,0x2
     8dc:	9e860613          	addi	a2,a2,-1560 # 22c0 <malloc+0x4e0>
     8e0:	00001597          	auipc	a1,0x1
     8e4:	60058593          	addi	a1,a1,1536 # 1ee0 <malloc+0x100>
     8e8:	4509                	li	a0,2
     8ea:	410010ef          	jal	1cfa <fprintf>
    exit(1);
     8ee:	4505                	li	a0,1
     8f0:	7bf000ef          	jal	18ae <exit>
     8f4:	461d                	li	a2,7
     8f6:	eb040593          	addi	a1,s0,-336
     8fa:	7d5000ef          	jal	18ce <write>
     8fe:	479d                	li	a5,7
     900:	fcf51ce3          	bne	a0,a5,8d8 <main+0x87c>
     904:	8526                	mv	a0,s1
     906:	7d1000ef          	jal	18d6 <close>
  if (!ok) {
     90a:	f579                	bnez	a0,8d8 <main+0x87c>
        "create target beside the link");
  check(symlink("sl_target", "sl_dir/rel") == 0, "create relative link");
     90c:	00002597          	auipc	a1,0x2
     910:	9d458593          	addi	a1,a1,-1580 # 22e0 <malloc+0x500>
     914:	00002517          	auipc	a0,0x2
     918:	b7450513          	addi	a0,a0,-1164 # 2488 <malloc+0x6a8>
     91c:	04a010ef          	jal	1966 <symlink>
     920:	e90d                	bnez	a0,952 <main+0x8f6>
  fd = open("sl_dir/rel", O_RDONLY);
     922:	4581                	li	a1,0
     924:	00002517          	auipc	a0,0x2
     928:	9bc50513          	addi	a0,a0,-1604 # 22e0 <malloc+0x500>
     92c:	7c3000ef          	jal	18ee <open>
     930:	84aa                	mv	s1,a0
  check(fd >= 0 && read(fd, fs_buffer, 8) == 7 &&
     932:	02055e63          	bgez	a0,96e <main+0x912>
    fprintf(2, "TEST FAILURE: %s\n", why);
     936:	00002617          	auipc	a2,0x2
     93a:	9d260613          	addi	a2,a2,-1582 # 2308 <malloc+0x528>
     93e:	00001597          	auipc	a1,0x1
     942:	5a258593          	addi	a1,a1,1442 # 1ee0 <malloc+0x100>
     946:	4509                	li	a0,2
     948:	3b2010ef          	jal	1cfa <fprintf>
    exit(1);
     94c:	4505                	li	a0,1
     94e:	761000ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     952:	00002617          	auipc	a2,0x2
     956:	99e60613          	addi	a2,a2,-1634 # 22f0 <malloc+0x510>
     95a:	00001597          	auipc	a1,0x1
     95e:	58658593          	addi	a1,a1,1414 # 1ee0 <malloc+0x100>
     962:	4509                	li	a0,2
     964:	396010ef          	jal	1cfa <fprintf>
    exit(1);
     968:	4505                	li	a0,1
     96a:	745000ef          	jal	18ae <exit>
     96e:	4621                	li	a2,8
     970:	00002597          	auipc	a1,0x2
     974:	6a058593          	addi	a1,a1,1696 # 3010 <fs_buffer>
     978:	74f000ef          	jal	18c6 <read>
     97c:	479d                	li	a5,7
     97e:	faf51ce3          	bne	a0,a5,936 <main+0x8da>
          memcmp(fs_buffer, inner, 7) == 0,
     982:	862a                	mv	a2,a0
     984:	eb040593          	addi	a1,s0,-336
     988:	00002517          	auipc	a0,0x2
     98c:	68850513          	addi	a0,a0,1672 # 3010 <fs_buffer>
     990:	6a1000ef          	jal	1830 <memcmp>
  if (!ok) {
     994:	f14d                	bnez	a0,936 <main+0x8da>
        "relative target uses link directory");
  check(close(fd) == 0, "close relative target");
     996:	8526                	mv	a0,s1
     998:	73f000ef          	jal	18d6 <close>
     99c:	84aa                	mv	s1,a0
     99e:	e531                	bnez	a0,9ea <main+0x98e>
  int child = fork();
     9a0:	707000ef          	jal	18a6 <fork>
     9a4:	892a                	mv	s2,a0
     9a6:	06054063          	bltz	a0,a06 <main+0x9aa>
  check(child >= 0, "fork for cwd-independent lookup");
  if (child == 0) {
     9aa:	e14d                	bnez	a0,a4c <main+0x9f0>
    if (chdir("sl_else") < 0)
     9ac:	00002517          	auipc	a0,0x2
     9b0:	8d450513          	addi	a0,a0,-1836 # 2280 <malloc+0x4a0>
     9b4:	76b000ef          	jal	191e <chdir>
     9b8:	06054563          	bltz	a0,a22 <main+0x9c6>
      exit(1);
    int otherfd = open("../sl_dir/rel", O_RDONLY);
     9bc:	4581                	li	a1,0
     9be:	00002517          	auipc	a0,0x2
     9c2:	9aa50513          	addi	a0,a0,-1622 # 2368 <malloc+0x588>
     9c6:	729000ef          	jal	18ee <open>
     9ca:	84aa                	mv	s1,a0
    if (otherfd < 0 || read(otherfd, fs_buffer, 8) != 7 ||
     9cc:	00054c63          	bltz	a0,9e4 <main+0x988>
     9d0:	4621                	li	a2,8
     9d2:	00002597          	auipc	a1,0x2
     9d6:	63e58593          	addi	a1,a1,1598 # 3010 <fs_buffer>
     9da:	6ed000ef          	jal	18c6 <read>
     9de:	479d                	li	a5,7
     9e0:	04f50463          	beq	a0,a5,a28 <main+0x9cc>
        memcmp(fs_buffer, inner, 7) != 0 || close(otherfd) < 0)
      exit(1);
     9e4:	4505                	li	a0,1
     9e6:	6c9000ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     9ea:	00002617          	auipc	a2,0x2
     9ee:	94660613          	addi	a2,a2,-1722 # 2330 <malloc+0x550>
     9f2:	00001597          	auipc	a1,0x1
     9f6:	4ee58593          	addi	a1,a1,1262 # 1ee0 <malloc+0x100>
     9fa:	4509                	li	a0,2
     9fc:	2fe010ef          	jal	1cfa <fprintf>
    exit(1);
     a00:	4505                	li	a0,1
     a02:	6ad000ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     a06:	00002617          	auipc	a2,0x2
     a0a:	94260613          	addi	a2,a2,-1726 # 2348 <malloc+0x568>
     a0e:	00001597          	auipc	a1,0x1
     a12:	4d258593          	addi	a1,a1,1234 # 1ee0 <malloc+0x100>
     a16:	4509                	li	a0,2
     a18:	2e2010ef          	jal	1cfa <fprintf>
    exit(1);
     a1c:	4505                	li	a0,1
     a1e:	691000ef          	jal	18ae <exit>
      exit(1);
     a22:	4505                	li	a0,1
     a24:	68b000ef          	jal	18ae <exit>
        memcmp(fs_buffer, inner, 7) != 0 || close(otherfd) < 0)
     a28:	862a                	mv	a2,a0
     a2a:	eb040593          	addi	a1,s0,-336
     a2e:	00002517          	auipc	a0,0x2
     a32:	5e250513          	addi	a0,a0,1506 # 3010 <fs_buffer>
     a36:	5fb000ef          	jal	1830 <memcmp>
    if (otherfd < 0 || read(otherfd, fs_buffer, 8) != 7 ||
     a3a:	f54d                	bnez	a0,9e4 <main+0x988>
        memcmp(fs_buffer, inner, 7) != 0 || close(otherfd) < 0)
     a3c:	8526                	mv	a0,s1
     a3e:	699000ef          	jal	18d6 <close>
     a42:	fa0541e3          	bltz	a0,9e4 <main+0x988>
    exit(0);
     a46:	4501                	li	a0,0
     a48:	667000ef          	jal	18ae <exit>
  }
  int status;
  check(wait(&status) == child && status == 0,
     a4c:	eac40513          	addi	a0,s0,-340
     a50:	667000ef          	jal	18b6 <wait>
     a54:	87a6                	mv	a5,s1
     a56:	29250763          	beq	a0,s2,ce4 <main+0xc88>
     a5a:	00002597          	auipc	a1,0x2
     a5e:	91e58593          	addi	a1,a1,-1762 # 2378 <malloc+0x598>
     a62:	853e                	mv	a0,a5
     a64:	d9cff0ef          	jal	0 <check>
        "relative target is independent of caller cwd");
  check(symlink("../sl_target", "sl_dir/up") == 0,
     a68:	00002597          	auipc	a1,0x2
     a6c:	94058593          	addi	a1,a1,-1728 # 23a8 <malloc+0x5c8>
     a70:	00002517          	auipc	a0,0x2
     a74:	94850513          	addi	a0,a0,-1720 # 23b8 <malloc+0x5d8>
     a78:	6ef000ef          	jal	1966 <symlink>
     a7c:	00002597          	auipc	a1,0x2
     a80:	94c58593          	addi	a1,a1,-1716 # 23c8 <malloc+0x5e8>
     a84:	00153513          	seqz	a0,a0
     a88:	d78ff0ef          	jal	0 <check>
        "create target with parent component");
  fd = open("sl_dir/up", O_RDONLY);
     a8c:	4581                	li	a1,0
     a8e:	00002517          	auipc	a0,0x2
     a92:	91a50513          	addi	a0,a0,-1766 # 23a8 <malloc+0x5c8>
     a96:	659000ef          	jal	18ee <open>
     a9a:	892a                	mv	s2,a0
  check(fd >= 0 && read(fd, fs_buffer, 8) == 6 &&
     a9c:	24055963          	bgez	a0,cee <main+0xc92>
     aa0:	8526                	mv	a0,s1
     aa2:	00002597          	auipc	a1,0x2
     aa6:	94e58593          	addi	a1,a1,-1714 # 23f0 <malloc+0x610>
     aaa:	d56ff0ef          	jal	0 <check>
          memcmp(fs_buffer, text, 6) == 0 && close(fd) == 0,
        "relative target with dot-dot");
  check(symlink("rel", "sl_dir/chain") == 0,
     aae:	00002597          	auipc	a1,0x2
     ab2:	96258593          	addi	a1,a1,-1694 # 2410 <malloc+0x630>
     ab6:	00002517          	auipc	a0,0x2
     aba:	96a50513          	addi	a0,a0,-1686 # 2420 <malloc+0x640>
     abe:	6a9000ef          	jal	1966 <symlink>
     ac2:	00002597          	auipc	a1,0x2
     ac6:	96658593          	addi	a1,a1,-1690 # 2428 <malloc+0x648>
     aca:	00153513          	seqz	a0,a0
     ace:	d32ff0ef          	jal	0 <check>
        "create link chain in subdirectory");
  fd = open("sl_dir/chain", O_RDONLY);
     ad2:	4581                	li	a1,0
     ad4:	00002517          	auipc	a0,0x2
     ad8:	93c50513          	addi	a0,a0,-1732 # 2410 <malloc+0x630>
     adc:	613000ef          	jal	18ee <open>
     ae0:	892a                	mv	s2,a0
  check(fd >= 0 && read(fd, fs_buffer, 8) == 7 &&
     ae2:	24055163          	bgez	a0,d24 <main+0xcc8>
     ae6:	8526                	mv	a0,s1
     ae8:	00002597          	auipc	a1,0x2
     aec:	96858593          	addi	a1,a1,-1688 # 2450 <malloc+0x670>
     af0:	d10ff0ef          	jal	0 <check>
          memcmp(fs_buffer, inner, 7) == 0 && close(fd) == 0,
        "each link resolves from its own directory");
  const char elsewhere[] = "other\n";
     af4:	00002797          	auipc	a5,0x2
     af8:	fec78793          	addi	a5,a5,-20 # 2ae0 <malloc+0xd00>
     afc:	4398                	lw	a4,0(a5)
     afe:	eae42023          	sw	a4,-352(s0)
     b02:	0047d703          	lhu	a4,4(a5)
     b06:	eae41223          	sh	a4,-348(s0)
     b0a:	0067c783          	lbu	a5,6(a5)
     b0e:	eaf40323          	sb	a5,-346(s0)
  fd = open("sl_else/sl_target", O_CREATE | O_WRONLY | O_TRUNC);
     b12:	60100593          	li	a1,1537
     b16:	00002517          	auipc	a0,0x2
     b1a:	96a50513          	addi	a0,a0,-1686 # 2480 <malloc+0x6a0>
     b1e:	5d1000ef          	jal	18ee <open>
     b22:	892a                	mv	s2,a0
  check(fd >= 0 && write(fd, elsewhere, 6) == 6 && close(fd) == 0,
     b24:	22055b63          	bgez	a0,d5a <main+0xcfe>
     b28:	8526                	mv	a0,s1
     b2a:	00002597          	auipc	a1,0x2
     b2e:	96e58593          	addi	a1,a1,-1682 # 2498 <malloc+0x6b8>
     b32:	cceff0ef          	jal	0 <check>
        "create target in second directory");
  check(symlink("sl_target", "sl_else/next") == 0 &&
     b36:	00002597          	auipc	a1,0x2
     b3a:	98a58593          	addi	a1,a1,-1654 # 24c0 <malloc+0x6e0>
     b3e:	00002517          	auipc	a0,0x2
     b42:	94a50513          	addi	a0,a0,-1718 # 2488 <malloc+0x6a8>
     b46:	621000ef          	jal	1966 <symlink>
     b4a:	87a6                	mv	a5,s1
     b4c:	22050563          	beqz	a0,d76 <main+0xd1a>
     b50:	00002597          	auipc	a1,0x2
     b54:	9a058593          	addi	a1,a1,-1632 # 24f0 <malloc+0x710>
     b58:	853e                	mv	a0,a5
     b5a:	ca6ff0ef          	jal	0 <check>
          symlink("../sl_else/next", "sl_dir/cross") == 0,
        "create chain across directories");
  fd = open("sl_dir/cross", O_RDONLY);
     b5e:	4581                	li	a1,0
     b60:	00002517          	auipc	a0,0x2
     b64:	97050513          	addi	a0,a0,-1680 # 24d0 <malloc+0x6f0>
     b68:	587000ef          	jal	18ee <open>
     b6c:	892a                	mv	s2,a0
  check(fd >= 0 && read(fd, fs_buffer, 8) == 6 &&
     b6e:	22055163          	bgez	a0,d90 <main+0xd34>
     b72:	8526                	mv	a0,s1
     b74:	00002597          	auipc	a1,0x2
     b78:	99c58593          	addi	a1,a1,-1636 # 2510 <malloc+0x730>
     b7c:	c84ff0ef          	jal	0 <check>
          memcmp(fs_buffer, elsewhere, 6) == 0 && close(fd) == 0,
        "second link uses its own directory");
  check(link("sl_dir/rel", "sl_else/alias") == 0,
     b80:	00002597          	auipc	a1,0x2
     b84:	9b858593          	addi	a1,a1,-1608 # 2538 <malloc+0x758>
     b88:	00001517          	auipc	a0,0x1
     b8c:	75850513          	addi	a0,a0,1880 # 22e0 <malloc+0x500>
     b90:	57f000ef          	jal	190e <link>
     b94:	00002597          	auipc	a1,0x2
     b98:	9b458593          	addi	a1,a1,-1612 # 2548 <malloc+0x768>
     b9c:	00153513          	seqz	a0,a0
     ba0:	c60ff0ef          	jal	0 <check>
        "hard-link a symlink into another directory");
  fd = open("sl_else/alias", O_RDONLY);
     ba4:	4581                	li	a1,0
     ba6:	00002517          	auipc	a0,0x2
     baa:	99250513          	addi	a0,a0,-1646 # 2538 <malloc+0x758>
     bae:	541000ef          	jal	18ee <open>
     bb2:	892a                	mv	s2,a0
  check(fd >= 0 && read(fd, fs_buffer, 8) == 6 &&
     bb4:	20055963          	bgez	a0,dc6 <main+0xd6a>
     bb8:	8526                	mv	a0,s1
     bba:	00002597          	auipc	a1,0x2
     bbe:	9be58593          	addi	a1,a1,-1602 # 2578 <malloc+0x798>
     bc2:	c3eff0ef          	jal	0 <check>
          memcmp(fs_buffer, elsewhere, 6) == 0 && close(fd) == 0,
        "hard-linked entry uses the directory traversed");
  check(symlink("/fst_syms.tmp/sl_target", "sl_abs") == 0, "absolute target");
     bc6:	00002597          	auipc	a1,0x2
     bca:	9e258593          	addi	a1,a1,-1566 # 25a8 <malloc+0x7c8>
     bce:	00002517          	auipc	a0,0x2
     bd2:	9e250513          	addi	a0,a0,-1566 # 25b0 <malloc+0x7d0>
     bd6:	591000ef          	jal	1966 <symlink>
     bda:	00002597          	auipc	a1,0x2
     bde:	9ee58593          	addi	a1,a1,-1554 # 25c8 <malloc+0x7e8>
     be2:	00153513          	seqz	a0,a0
     be6:	c1aff0ef          	jal	0 <check>
  fd = open("sl_abs", O_RDONLY);
     bea:	4581                	li	a1,0
     bec:	00002517          	auipc	a0,0x2
     bf0:	9bc50513          	addi	a0,a0,-1604 # 25a8 <malloc+0x7c8>
     bf4:	4fb000ef          	jal	18ee <open>
     bf8:	892a                	mv	s2,a0
  check(fd >= 0 && read(fd, fs_buffer, 8) == 6, "follow absolute target");
     bfa:	8526                	mv	a0,s1
     bfc:	20095063          	bgez	s2,dfc <main+0xda0>
     c00:	00002597          	auipc	a1,0x2
     c04:	9d858593          	addi	a1,a1,-1576 # 25d8 <malloc+0x7f8>
     c08:	bf8ff0ef          	jal	0 <check>
  check(close(fd) == 0, "close absolute target");
     c0c:	854a                	mv	a0,s2
     c0e:	4c9000ef          	jal	18d6 <close>
     c12:	00002597          	auipc	a1,0x2
     c16:	9de58593          	addi	a1,a1,-1570 # 25f0 <malloc+0x810>
     c1a:	00153513          	seqz	a0,a0
     c1e:	be2ff0ef          	jal	0 <check>
  for (int i = 0; i < 11; i++) {
    name[4] = '0' + i / 10;
     c22:	66666937          	lui	s2,0x66666
     c26:	66790913          	addi	s2,s2,1639 # 66666667 <base+0x66661657>
    name[5] = '0' + i % 10;
    check(unlink(name) == 0, "remove chain");
     c2a:	ed040993          	addi	s3,s0,-304
  for (int i = 0; i < 11; i++) {
     c2e:	4a2d                	li	s4,11
    name[4] = '0' + i / 10;
     c30:	03248733          	mul	a4,s1,s2
     c34:	9709                	srai	a4,a4,0x22
     c36:	41f4d79b          	sraiw	a5,s1,0x1f
     c3a:	9f1d                	subw	a4,a4,a5
     c3c:	0307079b          	addiw	a5,a4,48
     c40:	ecf40a23          	sb	a5,-300(s0)
    name[5] = '0' + i % 10;
     c44:	0027179b          	slliw	a5,a4,0x2
     c48:	9fb9                	addw	a5,a5,a4
     c4a:	0017979b          	slliw	a5,a5,0x1
     c4e:	40f487bb          	subw	a5,s1,a5
     c52:	0307879b          	addiw	a5,a5,48
     c56:	ecf40aa3          	sb	a5,-299(s0)
    check(unlink(name) == 0, "remove chain");
     c5a:	854e                	mv	a0,s3
     c5c:	4a3000ef          	jal	18fe <unlink>
  if (!ok) {
     c60:	1a051a63          	bnez	a0,e14 <main+0xdb8>
  for (int i = 0; i < 11; i++) {
     c64:	2485                	addiw	s1,s1,1
     c66:	fd4495e3          	bne	s1,s4,c30 <main+0xbd4>
  }
  const char *cleanup[] = {
     c6a:	00002797          	auipc	a5,0x2
     c6e:	ea678793          	addi	a5,a5,-346 # 2b10 <malloc+0xd30>
     c72:	e2040713          	addi	a4,s0,-480
     c76:	00002697          	auipc	a3,0x2
     c7a:	f1a68693          	addi	a3,a3,-230 # 2b90 <malloc+0xdb0>
     c7e:	6388                	ld	a0,0(a5)
     c80:	678c                	ld	a1,8(a5)
     c82:	6b90                	ld	a2,16(a5)
     c84:	e308                	sd	a0,0(a4)
     c86:	e70c                	sd	a1,8(a4)
     c88:	eb10                	sd	a2,16(a4)
     c8a:	6f90                	ld	a2,24(a5)
     c8c:	ef10                	sd	a2,24(a4)
     c8e:	02078793          	addi	a5,a5,32
     c92:	02070713          	addi	a4,a4,32
     c96:	fed794e3          	bne	a5,a3,c7e <main+0xc22>
    "sl_dang",       "sl_loopa",     "sl_loopb",         "sl_hard",
    "sl_else/alias", "sl_dir/cross", "sl_else/next",     "sl_dir/chain",
    "sl_dir/up",     "sl_dir/rel",   "sl_dir/sl_target", "sl_else/sl_target",
    "sl_dir",        "sl_else",      "sl_abs",           "sl_target"};
  for (uint i = 0; i < sizeof(cleanup) / sizeof(cleanup[0]); i++)
     c9a:	e2040493          	addi	s1,s0,-480
     c9e:	ea040913          	addi	s2,s0,-352
    check(unlink(cleanup[i]) == 0, "symlink cleanup");
     ca2:	6088                	ld	a0,0(s1)
     ca4:	45b000ef          	jal	18fe <unlink>
     ca8:	18051463          	bnez	a0,e30 <main+0xdd4>
  for (uint i = 0; i < sizeof(cleanup) / sizeof(cleanup[0]); i++)
     cac:	04a1                	addi	s1,s1,8
     cae:	fe991ae3          	bne	s2,s1,ca2 <main+0xc46>
  int fd = open("edge_target", O_CREATE | O_RDWR | O_TRUNC);
     cb2:	60200593          	li	a1,1538
     cb6:	00002517          	auipc	a0,0x2
     cba:	97250513          	addi	a0,a0,-1678 # 2628 <malloc+0x848>
     cbe:	431000ef          	jal	18ee <open>
     cc2:	84aa                	mv	s1,a0
  check(fd >= 0 && write(fd, "hello", 5) == 5 && close(fd) == 0,
     cc4:	18055463          	bgez	a0,e4c <main+0xdf0>
    fprintf(2, "TEST FAILURE: %s\n", why);
     cc8:	00002617          	auipc	a2,0x2
     ccc:	97860613          	addi	a2,a2,-1672 # 2640 <malloc+0x860>
     cd0:	00001597          	auipc	a1,0x1
     cd4:	21058593          	addi	a1,a1,528 # 1ee0 <malloc+0x100>
     cd8:	4509                	li	a0,2
     cda:	020010ef          	jal	1cfa <fprintf>
    exit(1);
     cde:	4505                	li	a0,1
     ce0:	3cf000ef          	jal	18ae <exit>
  check(wait(&status) == child && status == 0,
     ce4:	eac42783          	lw	a5,-340(s0)
     ce8:	0017b793          	seqz	a5,a5
     cec:	b3bd                	j	a5a <main+0x9fe>
  check(fd >= 0 && read(fd, fs_buffer, 8) == 6 &&
     cee:	4621                	li	a2,8
     cf0:	00002597          	auipc	a1,0x2
     cf4:	32058593          	addi	a1,a1,800 # 3010 <fs_buffer>
     cf8:	3cf000ef          	jal	18c6 <read>
     cfc:	4799                	li	a5,6
     cfe:	daf511e3          	bne	a0,a5,aa0 <main+0xa44>
          memcmp(fs_buffer, text, 6) == 0 && close(fd) == 0,
     d02:	4619                	li	a2,6
     d04:	f7840593          	addi	a1,s0,-136
     d08:	00002517          	auipc	a0,0x2
     d0c:	30850513          	addi	a0,a0,776 # 3010 <fs_buffer>
     d10:	321000ef          	jal	1830 <memcmp>
  check(fd >= 0 && read(fd, fs_buffer, 8) == 6 &&
     d14:	d80516e3          	bnez	a0,aa0 <main+0xa44>
          memcmp(fs_buffer, text, 6) == 0 && close(fd) == 0,
     d18:	854a                	mv	a0,s2
     d1a:	3bd000ef          	jal	18d6 <close>
  check(fd >= 0 && read(fd, fs_buffer, 8) == 6 &&
     d1e:	00153513          	seqz	a0,a0
     d22:	b341                	j	aa2 <main+0xa46>
  check(fd >= 0 && read(fd, fs_buffer, 8) == 7 &&
     d24:	4621                	li	a2,8
     d26:	00002597          	auipc	a1,0x2
     d2a:	2ea58593          	addi	a1,a1,746 # 3010 <fs_buffer>
     d2e:	399000ef          	jal	18c6 <read>
     d32:	479d                	li	a5,7
     d34:	daf519e3          	bne	a0,a5,ae6 <main+0xa8a>
          memcmp(fs_buffer, inner, 7) == 0 && close(fd) == 0,
     d38:	461d                	li	a2,7
     d3a:	eb040593          	addi	a1,s0,-336
     d3e:	00002517          	auipc	a0,0x2
     d42:	2d250513          	addi	a0,a0,722 # 3010 <fs_buffer>
     d46:	2eb000ef          	jal	1830 <memcmp>
  check(fd >= 0 && read(fd, fs_buffer, 8) == 7 &&
     d4a:	d8051ee3          	bnez	a0,ae6 <main+0xa8a>
          memcmp(fs_buffer, inner, 7) == 0 && close(fd) == 0,
     d4e:	854a                	mv	a0,s2
     d50:	387000ef          	jal	18d6 <close>
  check(fd >= 0 && read(fd, fs_buffer, 8) == 7 &&
     d54:	00153513          	seqz	a0,a0
     d58:	bb41                	j	ae8 <main+0xa8c>
  check(fd >= 0 && write(fd, elsewhere, 6) == 6 && close(fd) == 0,
     d5a:	4619                	li	a2,6
     d5c:	ea040593          	addi	a1,s0,-352
     d60:	36f000ef          	jal	18ce <write>
     d64:	4799                	li	a5,6
     d66:	dcf511e3          	bne	a0,a5,b28 <main+0xacc>
     d6a:	854a                	mv	a0,s2
     d6c:	36b000ef          	jal	18d6 <close>
     d70:	00153513          	seqz	a0,a0
     d74:	bb5d                	j	b2a <main+0xace>
          symlink("../sl_else/next", "sl_dir/cross") == 0,
     d76:	00001597          	auipc	a1,0x1
     d7a:	75a58593          	addi	a1,a1,1882 # 24d0 <malloc+0x6f0>
     d7e:	00001517          	auipc	a0,0x1
     d82:	76250513          	addi	a0,a0,1890 # 24e0 <malloc+0x700>
     d86:	3e1000ef          	jal	1966 <symlink>
  check(symlink("sl_target", "sl_else/next") == 0 &&
     d8a:	00153793          	seqz	a5,a0
     d8e:	b3c9                	j	b50 <main+0xaf4>
  check(fd >= 0 && read(fd, fs_buffer, 8) == 6 &&
     d90:	4621                	li	a2,8
     d92:	00002597          	auipc	a1,0x2
     d96:	27e58593          	addi	a1,a1,638 # 3010 <fs_buffer>
     d9a:	32d000ef          	jal	18c6 <read>
     d9e:	4799                	li	a5,6
     da0:	dcf519e3          	bne	a0,a5,b72 <main+0xb16>
          memcmp(fs_buffer, elsewhere, 6) == 0 && close(fd) == 0,
     da4:	4619                	li	a2,6
     da6:	ea040593          	addi	a1,s0,-352
     daa:	00002517          	auipc	a0,0x2
     dae:	26650513          	addi	a0,a0,614 # 3010 <fs_buffer>
     db2:	27f000ef          	jal	1830 <memcmp>
  check(fd >= 0 && read(fd, fs_buffer, 8) == 6 &&
     db6:	da051ee3          	bnez	a0,b72 <main+0xb16>
          memcmp(fs_buffer, elsewhere, 6) == 0 && close(fd) == 0,
     dba:	854a                	mv	a0,s2
     dbc:	31b000ef          	jal	18d6 <close>
  check(fd >= 0 && read(fd, fs_buffer, 8) == 6 &&
     dc0:	00153513          	seqz	a0,a0
     dc4:	bb45                	j	b74 <main+0xb18>
  check(fd >= 0 && read(fd, fs_buffer, 8) == 6 &&
     dc6:	4621                	li	a2,8
     dc8:	00002597          	auipc	a1,0x2
     dcc:	24858593          	addi	a1,a1,584 # 3010 <fs_buffer>
     dd0:	2f7000ef          	jal	18c6 <read>
     dd4:	4799                	li	a5,6
     dd6:	def511e3          	bne	a0,a5,bb8 <main+0xb5c>
          memcmp(fs_buffer, elsewhere, 6) == 0 && close(fd) == 0,
     dda:	4619                	li	a2,6
     ddc:	ea040593          	addi	a1,s0,-352
     de0:	00002517          	auipc	a0,0x2
     de4:	23050513          	addi	a0,a0,560 # 3010 <fs_buffer>
     de8:	249000ef          	jal	1830 <memcmp>
  check(fd >= 0 && read(fd, fs_buffer, 8) == 6 &&
     dec:	dc0516e3          	bnez	a0,bb8 <main+0xb5c>
          memcmp(fs_buffer, elsewhere, 6) == 0 && close(fd) == 0,
     df0:	854a                	mv	a0,s2
     df2:	2e5000ef          	jal	18d6 <close>
  check(fd >= 0 && read(fd, fs_buffer, 8) == 6 &&
     df6:	00153513          	seqz	a0,a0
     dfa:	b3c1                	j	bba <main+0xb5e>
  check(fd >= 0 && read(fd, fs_buffer, 8) == 6, "follow absolute target");
     dfc:	4621                	li	a2,8
     dfe:	00002597          	auipc	a1,0x2
     e02:	21258593          	addi	a1,a1,530 # 3010 <fs_buffer>
     e06:	854a                	mv	a0,s2
     e08:	2bf000ef          	jal	18c6 <read>
     e0c:	1569                	addi	a0,a0,-6
     e0e:	00153513          	seqz	a0,a0
     e12:	b3fd                	j	c00 <main+0xba4>
    fprintf(2, "TEST FAILURE: %s\n", why);
     e14:	00001617          	auipc	a2,0x1
     e18:	7f460613          	addi	a2,a2,2036 # 2608 <malloc+0x828>
     e1c:	00001597          	auipc	a1,0x1
     e20:	0c458593          	addi	a1,a1,196 # 1ee0 <malloc+0x100>
     e24:	4509                	li	a0,2
     e26:	6d5000ef          	jal	1cfa <fprintf>
    exit(1);
     e2a:	4505                	li	a0,1
     e2c:	283000ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     e30:	00001617          	auipc	a2,0x1
     e34:	7e860613          	addi	a2,a2,2024 # 2618 <malloc+0x838>
     e38:	00001597          	auipc	a1,0x1
     e3c:	0a858593          	addi	a1,a1,168 # 1ee0 <malloc+0x100>
     e40:	4509                	li	a0,2
     e42:	6b9000ef          	jal	1cfa <fprintf>
    exit(1);
     e46:	4505                	li	a0,1
     e48:	267000ef          	jal	18ae <exit>
  check(fd >= 0 && write(fd, "hello", 5) == 5 && close(fd) == 0,
     e4c:	4615                	li	a2,5
     e4e:	00001597          	auipc	a1,0x1
     e52:	7ea58593          	addi	a1,a1,2026 # 2638 <malloc+0x858>
     e56:	279000ef          	jal	18ce <write>
     e5a:	4795                	li	a5,5
     e5c:	e6f516e3          	bne	a0,a5,cc8 <main+0xc6c>
     e60:	8526                	mv	a0,s1
     e62:	275000ef          	jal	18d6 <close>
  if (!ok) {
     e66:	e60511e3          	bnez	a0,cc8 <main+0xc6c>
  check(symlink("edge_target", "edge_link") == 0, "create edge-case link");
     e6a:	00001597          	auipc	a1,0x1
     e6e:	7ee58593          	addi	a1,a1,2030 # 2658 <malloc+0x878>
     e72:	00001517          	auipc	a0,0x1
     e76:	7b650513          	addi	a0,a0,1974 # 2628 <malloc+0x848>
     e7a:	2ed000ef          	jal	1966 <symlink>
     e7e:	e91d                	bnez	a0,eb4 <main+0xe58>
  fd = open("edge_link", O_RDONLY | O_NOFOLLOW | O_TRUNC);
     e80:	6585                	lui	a1,0x1
     e82:	c0058593          	addi	a1,a1,-1024 # c00 <main+0xba4>
     e86:	00001517          	auipc	a0,0x1
     e8a:	7d250513          	addi	a0,a0,2002 # 2658 <malloc+0x878>
     e8e:	261000ef          	jal	18ee <open>
     e92:	84aa                	mv	s1,a0
  check(fd >= 0 && read(fd, fs_buffer, 32) == sizeof("edge_target") &&
     e94:	02055e63          	bgez	a0,ed0 <main+0xe74>
    fprintf(2, "TEST FAILURE: %s\n", why);
     e98:	00001617          	auipc	a2,0x1
     e9c:	7e860613          	addi	a2,a2,2024 # 2680 <malloc+0x8a0>
     ea0:	00001597          	auipc	a1,0x1
     ea4:	04058593          	addi	a1,a1,64 # 1ee0 <malloc+0x100>
     ea8:	4509                	li	a0,2
     eaa:	651000ef          	jal	1cfa <fprintf>
    exit(1);
     eae:	4505                	li	a0,1
     eb0:	1ff000ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
     eb4:	00001617          	auipc	a2,0x1
     eb8:	7b460613          	addi	a2,a2,1972 # 2668 <malloc+0x888>
     ebc:	00001597          	auipc	a1,0x1
     ec0:	02458593          	addi	a1,a1,36 # 1ee0 <malloc+0x100>
     ec4:	4509                	li	a0,2
     ec6:	635000ef          	jal	1cfa <fprintf>
    exit(1);
     eca:	4505                	li	a0,1
     ecc:	1e3000ef          	jal	18ae <exit>
     ed0:	02000613          	li	a2,32
     ed4:	00002597          	auipc	a1,0x2
     ed8:	13c58593          	addi	a1,a1,316 # 3010 <fs_buffer>
     edc:	1eb000ef          	jal	18c6 <read>
     ee0:	47b1                	li	a5,12
     ee2:	faf51be3          	bne	a0,a5,e98 <main+0xe3c>
          memcmp(fs_buffer, "edge_target", sizeof("edge_target")) == 0 &&
     ee6:	862a                	mv	a2,a0
     ee8:	00001597          	auipc	a1,0x1
     eec:	74058593          	addi	a1,a1,1856 # 2628 <malloc+0x848>
     ef0:	00002517          	auipc	a0,0x2
     ef4:	12050513          	addi	a0,a0,288 # 3010 <fs_buffer>
     ef8:	139000ef          	jal	1830 <memcmp>
  check(fd >= 0 && read(fd, fs_buffer, 32) == sizeof("edge_target") &&
     efc:	fd51                	bnez	a0,e98 <main+0xe3c>
          close(fd) == 0,
     efe:	8526                	mv	a0,s1
     f00:	1d7000ef          	jal	18d6 <close>
  if (!ok) {
     f04:	f951                	bnez	a0,e98 <main+0xe3c>
  fd = open("edge_link", O_WRONLY | O_NOFOLLOW);
     f06:	6585                	lui	a1,0x1
     f08:	80158593          	addi	a1,a1,-2047 # 801 <main+0x7a5>
     f0c:	00001517          	auipc	a0,0x1
     f10:	74c50513          	addi	a0,a0,1868 # 2658 <malloc+0x878>
     f14:	1db000ef          	jal	18ee <open>
     f18:	84aa                	mv	s1,a0
  check(fd >= 0 && read(fd, fs_buffer, 1) == -1 && close(fd) == 0,
     f1a:	02055063          	bgez	a0,f3a <main+0xede>
    fprintf(2, "TEST FAILURE: %s\n", why);
     f1e:	00001617          	auipc	a2,0x1
     f22:	79260613          	addi	a2,a2,1938 # 26b0 <malloc+0x8d0>
     f26:	00001597          	auipc	a1,0x1
     f2a:	fba58593          	addi	a1,a1,-70 # 1ee0 <malloc+0x100>
     f2e:	4509                	li	a0,2
     f30:	5cb000ef          	jal	1cfa <fprintf>
    exit(1);
     f34:	4505                	li	a0,1
     f36:	179000ef          	jal	18ae <exit>
     f3a:	4605                	li	a2,1
     f3c:	00002597          	auipc	a1,0x2
     f40:	0d458593          	addi	a1,a1,212 # 3010 <fs_buffer>
     f44:	183000ef          	jal	18c6 <read>
     f48:	57fd                	li	a5,-1
     f4a:	fcf51ae3          	bne	a0,a5,f1e <main+0xec2>
     f4e:	8526                	mv	a0,s1
     f50:	187000ef          	jal	18d6 <close>
  if (!ok) {
     f54:	f569                	bnez	a0,f1e <main+0xec2>
  fd = open("edge_link", O_RDONLY | O_NOFOLLOW);
     f56:	6585                	lui	a1,0x1
     f58:	80058593          	addi	a1,a1,-2048 # 800 <main+0x7a4>
     f5c:	00001517          	auipc	a0,0x1
     f60:	6fc50513          	addi	a0,a0,1788 # 2658 <malloc+0x878>
     f64:	18b000ef          	jal	18ee <open>
     f68:	84aa                	mv	s1,a0
  check(fd >= 0 && write(fd, "x", 1) == -1 && close(fd) == 0,
     f6a:	02055063          	bgez	a0,f8a <main+0xf2e>
    fprintf(2, "TEST FAILURE: %s\n", why);
     f6e:	00001617          	auipc	a2,0x1
     f72:	77a60613          	addi	a2,a2,1914 # 26e8 <malloc+0x908>
     f76:	00001597          	auipc	a1,0x1
     f7a:	f6a58593          	addi	a1,a1,-150 # 1ee0 <malloc+0x100>
     f7e:	4509                	li	a0,2
     f80:	57b000ef          	jal	1cfa <fprintf>
    exit(1);
     f84:	4505                	li	a0,1
     f86:	129000ef          	jal	18ae <exit>
     f8a:	4605                	li	a2,1
     f8c:	00001597          	auipc	a1,0x1
     f90:	75458593          	addi	a1,a1,1876 # 26e0 <malloc+0x900>
     f94:	13b000ef          	jal	18ce <write>
     f98:	57fd                	li	a5,-1
     f9a:	fcf51ae3          	bne	a0,a5,f6e <main+0xf12>
     f9e:	8526                	mv	a0,s1
     fa0:	137000ef          	jal	18d6 <close>
  if (!ok) {
     fa4:	f569                	bnez	a0,f6e <main+0xf12>
  fd = open("edge_link", O_WRONLY | O_TRUNC);
     fa6:	40100593          	li	a1,1025
     faa:	00001517          	auipc	a0,0x1
     fae:	6ae50513          	addi	a0,a0,1710 # 2658 <malloc+0x878>
     fb2:	13d000ef          	jal	18ee <open>
  check(fd >= 0 && close(fd) == 0, "truncate followed regular file");
     fb6:	02055063          	bgez	a0,fd6 <main+0xf7a>
    fprintf(2, "TEST FAILURE: %s\n", why);
     fba:	00001617          	auipc	a2,0x1
     fbe:	75e60613          	addi	a2,a2,1886 # 2718 <malloc+0x938>
     fc2:	00001597          	auipc	a1,0x1
     fc6:	f1e58593          	addi	a1,a1,-226 # 1ee0 <malloc+0x100>
     fca:	4509                	li	a0,2
     fcc:	52f000ef          	jal	1cfa <fprintf>
    exit(1);
     fd0:	4505                	li	a0,1
     fd2:	0dd000ef          	jal	18ae <exit>
     fd6:	101000ef          	jal	18d6 <close>
  if (!ok) {
     fda:	f165                	bnez	a0,fba <main+0xf5e>
  check(stat("edge_target", &st) == 0 && st.size == 0,
     fdc:	d7040593          	addi	a1,s0,-656
     fe0:	00001517          	auipc	a0,0x1
     fe4:	64850513          	addi	a0,a0,1608 # 2628 <malloc+0x848>
     fe8:	764000ef          	jal	174c <stat>
     fec:	ed15                	bnez	a0,1028 <main+0xfcc>
     fee:	d8043783          	ld	a5,-640(s0)
     ff2:	eb9d                	bnez	a5,1028 <main+0xfcc>
  fd = open("edge_link", O_RDONLY | O_NOFOLLOW);
     ff4:	6585                	lui	a1,0x1
     ff6:	80058593          	addi	a1,a1,-2048 # 800 <main+0x7a4>
     ffa:	00001517          	auipc	a0,0x1
     ffe:	65e50513          	addi	a0,a0,1630 # 2658 <malloc+0x878>
    1002:	0ed000ef          	jal	18ee <open>
    1006:	84aa                	mv	s1,a0
  check(fd >= 0 && read(fd, fs_buffer, 32) == sizeof("edge_target") &&
    1008:	02055e63          	bgez	a0,1044 <main+0xfe8>
    fprintf(2, "TEST FAILURE: %s\n", why);
    100c:	00001617          	auipc	a2,0x1
    1010:	75460613          	addi	a2,a2,1876 # 2760 <malloc+0x980>
    1014:	00001597          	auipc	a1,0x1
    1018:	ecc58593          	addi	a1,a1,-308 # 1ee0 <malloc+0x100>
    101c:	4509                	li	a0,2
    101e:	4dd000ef          	jal	1cfa <fprintf>
    exit(1);
    1022:	4505                	li	a0,1
    1024:	08b000ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1028:	00001617          	auipc	a2,0x1
    102c:	71060613          	addi	a2,a2,1808 # 2738 <malloc+0x958>
    1030:	00001597          	auipc	a1,0x1
    1034:	eb058593          	addi	a1,a1,-336 # 1ee0 <malloc+0x100>
    1038:	4509                	li	a0,2
    103a:	4c1000ef          	jal	1cfa <fprintf>
    exit(1);
    103e:	4505                	li	a0,1
    1040:	06f000ef          	jal	18ae <exit>
    1044:	02000613          	li	a2,32
    1048:	00002597          	auipc	a1,0x2
    104c:	fc858593          	addi	a1,a1,-56 # 3010 <fs_buffer>
    1050:	077000ef          	jal	18c6 <read>
    1054:	47b1                	li	a5,12
    1056:	faf51be3          	bne	a0,a5,100c <main+0xfb0>
          close(fd) == 0,
    105a:	8526                	mv	a0,s1
    105c:	07b000ef          	jal	18d6 <close>
  if (!ok) {
    1060:	f555                	bnez	a0,100c <main+0xfb0>
  fd = open("edge_link", O_RDWR | O_NOFOLLOW);
    1062:	6585                	lui	a1,0x1
    1064:	80258593          	addi	a1,a1,-2046 # 802 <main+0x7a6>
    1068:	00001517          	auipc	a0,0x1
    106c:	5f050513          	addi	a0,a0,1520 # 2658 <malloc+0x878>
    1070:	07f000ef          	jal	18ee <open>
    1074:	84aa                	mv	s1,a0
  check(fd >= 0 && write(fd, "X", 1) == 1 && close(fd) == 0,
    1076:	02055063          	bgez	a0,1096 <main+0x103a>
    fprintf(2, "TEST FAILURE: %s\n", why);
    107a:	00001617          	auipc	a2,0x1
    107e:	71660613          	addi	a2,a2,1814 # 2790 <malloc+0x9b0>
    1082:	00001597          	auipc	a1,0x1
    1086:	e5e58593          	addi	a1,a1,-418 # 1ee0 <malloc+0x100>
    108a:	4509                	li	a0,2
    108c:	46f000ef          	jal	1cfa <fprintf>
    exit(1);
    1090:	4505                	li	a0,1
    1092:	01d000ef          	jal	18ae <exit>
    1096:	4605                	li	a2,1
    1098:	00001597          	auipc	a1,0x1
    109c:	6f058593          	addi	a1,a1,1776 # 2788 <malloc+0x9a8>
    10a0:	02f000ef          	jal	18ce <write>
    10a4:	4785                	li	a5,1
    10a6:	fcf51ae3          	bne	a0,a5,107a <main+0x101e>
    10aa:	8526                	mv	a0,s1
    10ac:	02b000ef          	jal	18d6 <close>
  if (!ok) {
    10b0:	f569                	bnez	a0,107a <main+0x101e>
  unavailable("edge_link");
    10b2:	00001517          	auipc	a0,0x1
    10b6:	5a650513          	addi	a0,a0,1446 # 2658 <malloc+0x878>
    10ba:	f69fe0ef          	jal	22 <unavailable>
  check(unlink("edge_link") == 0 && unlink("edge_target") == 0,
    10be:	00001517          	auipc	a0,0x1
    10c2:	59a50513          	addi	a0,a0,1434 # 2658 <malloc+0x878>
    10c6:	039000ef          	jal	18fe <unlink>
    10ca:	cd19                	beqz	a0,10e8 <main+0x108c>
    fprintf(2, "TEST FAILURE: %s\n", why);
    10cc:	00001617          	auipc	a2,0x1
    10d0:	6f460613          	addi	a2,a2,1780 # 27c0 <malloc+0x9e0>
    10d4:	00001597          	auipc	a1,0x1
    10d8:	e0c58593          	addi	a1,a1,-500 # 1ee0 <malloc+0x100>
    10dc:	4509                	li	a0,2
    10de:	41d000ef          	jal	1cfa <fprintf>
    exit(1);
    10e2:	4505                	li	a0,1
    10e4:	7ca000ef          	jal	18ae <exit>
    10e8:	00001517          	auipc	a0,0x1
    10ec:	54050513          	addi	a0,a0,1344 # 2628 <malloc+0x848>
    10f0:	00f000ef          	jal	18fe <unlink>
  if (!ok) {
    10f4:	fd61                	bnez	a0,10cc <main+0x1070>
  const char *valid_names[] = {"abcdefg", "a"};
    10f6:	00001797          	auipc	a5,0x1
    10fa:	6ea78793          	addi	a5,a5,1770 # 27e0 <malloc+0xa00>
    10fe:	d6f43023          	sd	a5,-672(s0)
    1102:	00001797          	auipc	a5,0x1
    1106:	6e678793          	addi	a5,a5,1766 # 27e8 <malloc+0xa08>
    110a:	d6f43423          	sd	a5,-664(s0)
  for (int i = 0; i < 2; i++) {
    110e:	d6040493          	addi	s1,s0,-672
    1112:	d7040993          	addi	s3,s0,-656
    fd = open(valid_names[i], O_CREATE | O_WRONLY);
    1116:	20100913          	li	s2,513
    111a:	85ca                	mv	a1,s2
    111c:	6088                	ld	a0,0(s1)
    111e:	7d0000ef          	jal	18ee <open>
    check(fd >= 0 && close(fd) == 0, "create malformed-target control");
    1122:	02055063          	bgez	a0,1142 <main+0x10e6>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1126:	00001617          	auipc	a2,0x1
    112a:	6ca60613          	addi	a2,a2,1738 # 27f0 <malloc+0xa10>
    112e:	00001597          	auipc	a1,0x1
    1132:	db258593          	addi	a1,a1,-590 # 1ee0 <malloc+0x100>
    1136:	4509                	li	a0,2
    1138:	3c3000ef          	jal	1cfa <fprintf>
    exit(1);
    113c:	4505                	li	a0,1
    113e:	770000ef          	jal	18ae <exit>
    1142:	794000ef          	jal	18d6 <close>
  if (!ok) {
    1146:	f165                	bnez	a0,1126 <main+0x10ca>
  for (int i = 0; i < 2; i++) {
    1148:	04a1                	addi	s1,s1,8
    114a:	fc9998e3          	bne	s3,s1,111a <main+0x10be>
  const char *bad[] = {"abcdefg", "a\0bcdef", "\0abcdef"};
    114e:	00001797          	auipc	a5,0x1
    1152:	69278793          	addi	a5,a5,1682 # 27e0 <malloc+0xa00>
    1156:	d8f43423          	sd	a5,-632(s0)
    115a:	00002797          	auipc	a5,0x2
    115e:	a3678793          	addi	a5,a5,-1482 # 2b90 <malloc+0xdb0>
    1162:	d8f43823          	sd	a5,-624(s0)
    1166:	00002797          	auipc	a5,0x2
    116a:	a3278793          	addi	a5,a5,-1486 # 2b98 <malloc+0xdb8>
    116e:	d8f43c23          	sd	a5,-616(s0)
  for (int i = 0; i < 3; i++) {
    1172:	d8840993          	addi	s3,s0,-632
    1176:	da040b13          	addi	s6,s0,-608
    check(symlink("target", "edge_bad") == 0, "create malformed fixture");
    117a:	00001917          	auipc	s2,0x1
    117e:	69690913          	addi	s2,s2,1686 # 2810 <malloc+0xa30>
    1182:	00001a97          	auipc	s5,0x1
    1186:	0eea8a93          	addi	s5,s5,238 # 2270 <malloc+0x490>
    fd = open("edge_bad", O_WRONLY | O_NOFOLLOW);
    118a:	6a05                	lui	s4,0x1
    118c:	801a0a13          	addi	s4,s4,-2047 # 801 <main+0x7a5>
    check(fd >= 0 && write(fd, bad[i], 7) == 7 && close(fd) == 0,
    1190:	4b9d                	li	s7,7
    1192:	a0a1                	j	11da <main+0x117e>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1194:	00001617          	auipc	a2,0x1
    1198:	68c60613          	addi	a2,a2,1676 # 2820 <malloc+0xa40>
    119c:	00001597          	auipc	a1,0x1
    11a0:	d4458593          	addi	a1,a1,-700 # 1ee0 <malloc+0x100>
    11a4:	4509                	li	a0,2
    11a6:	355000ef          	jal	1cfa <fprintf>
    exit(1);
    11aa:	4505                	li	a0,1
    11ac:	702000ef          	jal	18ae <exit>
    11b0:	865e                	mv	a2,s7
    11b2:	0009b583          	ld	a1,0(s3)
    11b6:	718000ef          	jal	18ce <write>
    11ba:	03751c63          	bne	a0,s7,11f2 <main+0x1196>
    11be:	8526                	mv	a0,s1
    11c0:	716000ef          	jal	18d6 <close>
  if (!ok) {
    11c4:	e51d                	bnez	a0,11f2 <main+0x1196>
    unavailable("edge_bad");
    11c6:	854a                	mv	a0,s2
    11c8:	e5bfe0ef          	jal	22 <unavailable>
    check(unlink("edge_bad") == 0, "remove malformed fixture");
    11cc:	854a                	mv	a0,s2
    11ce:	730000ef          	jal	18fe <unlink>
    11d2:	ed15                	bnez	a0,120e <main+0x11b2>
  for (int i = 0; i < 3; i++) {
    11d4:	09a1                	addi	s3,s3,8
    11d6:	053b0a63          	beq	s6,s3,122a <main+0x11ce>
    check(symlink("target", "edge_bad") == 0, "create malformed fixture");
    11da:	85ca                	mv	a1,s2
    11dc:	8556                	mv	a0,s5
    11de:	788000ef          	jal	1966 <symlink>
    11e2:	f94d                	bnez	a0,1194 <main+0x1138>
    fd = open("edge_bad", O_WRONLY | O_NOFOLLOW);
    11e4:	85d2                	mv	a1,s4
    11e6:	854a                	mv	a0,s2
    11e8:	706000ef          	jal	18ee <open>
    11ec:	84aa                	mv	s1,a0
    check(fd >= 0 && write(fd, bad[i], 7) == 7 && close(fd) == 0,
    11ee:	fc0551e3          	bgez	a0,11b0 <main+0x1154>
    fprintf(2, "TEST FAILURE: %s\n", why);
    11f2:	00001617          	auipc	a2,0x1
    11f6:	64e60613          	addi	a2,a2,1614 # 2840 <malloc+0xa60>
    11fa:	00001597          	auipc	a1,0x1
    11fe:	ce658593          	addi	a1,a1,-794 # 1ee0 <malloc+0x100>
    1202:	4509                	li	a0,2
    1204:	2f7000ef          	jal	1cfa <fprintf>
    exit(1);
    1208:	4505                	li	a0,1
    120a:	6a4000ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
    120e:	00001617          	auipc	a2,0x1
    1212:	65260613          	addi	a2,a2,1618 # 2860 <malloc+0xa80>
    1216:	00001597          	auipc	a1,0x1
    121a:	cca58593          	addi	a1,a1,-822 # 1ee0 <malloc+0x100>
    121e:	4509                	li	a0,2
    1220:	2db000ef          	jal	1cfa <fprintf>
    exit(1);
    1224:	4505                	li	a0,1
    1226:	688000ef          	jal	18ae <exit>
  check(symlink("target", "edge_bad") == 0, "create oversized fixture");
    122a:	00001597          	auipc	a1,0x1
    122e:	5e658593          	addi	a1,a1,1510 # 2810 <malloc+0xa30>
    1232:	00001517          	auipc	a0,0x1
    1236:	03e50513          	addi	a0,a0,62 # 2270 <malloc+0x490>
    123a:	72c000ef          	jal	1966 <symlink>
  if (!ok) {
    123e:	e12d                	bnez	a0,12a0 <main+0x1244>
  memset(fs_buffer, 'x', MAXPATH + 1);
    1240:	08100613          	li	a2,129
    1244:	07800593          	li	a1,120
    1248:	00002517          	auipc	a0,0x2
    124c:	dc850513          	addi	a0,a0,-568 # 3010 <fs_buffer>
    1250:	434000ef          	jal	1684 <memset>
  fs_buffer[0] = 'a';
    1254:	00002797          	auipc	a5,0x2
    1258:	dbc78793          	addi	a5,a5,-580 # 3010 <fs_buffer>
    125c:	06100713          	li	a4,97
    1260:	00e78023          	sb	a4,0(a5)
  fs_buffer[1] = 0;
    1264:	000780a3          	sb	zero,1(a5)
  fs_buffer[MAXPATH] = 0;
    1268:	08078023          	sb	zero,128(a5)
  fd = open("edge_bad", O_WRONLY | O_NOFOLLOW);
    126c:	6585                	lui	a1,0x1
    126e:	80158593          	addi	a1,a1,-2047 # 801 <main+0x7a5>
    1272:	00001517          	auipc	a0,0x1
    1276:	59e50513          	addi	a0,a0,1438 # 2810 <malloc+0xa30>
    127a:	674000ef          	jal	18ee <open>
    127e:	84aa                	mv	s1,a0
  check(fd >= 0 && write(fd, fs_buffer, MAXPATH + 1) == MAXPATH + 1 &&
    1280:	02055e63          	bgez	a0,12bc <main+0x1260>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1284:	00001617          	auipc	a2,0x1
    1288:	61c60613          	addi	a2,a2,1564 # 28a0 <malloc+0xac0>
    128c:	00001597          	auipc	a1,0x1
    1290:	c5458593          	addi	a1,a1,-940 # 1ee0 <malloc+0x100>
    1294:	4509                	li	a0,2
    1296:	265000ef          	jal	1cfa <fprintf>
    exit(1);
    129a:	4505                	li	a0,1
    129c:	612000ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
    12a0:	00001617          	auipc	a2,0x1
    12a4:	5e060613          	addi	a2,a2,1504 # 2880 <malloc+0xaa0>
    12a8:	00001597          	auipc	a1,0x1
    12ac:	c3858593          	addi	a1,a1,-968 # 1ee0 <malloc+0x100>
    12b0:	4509                	li	a0,2
    12b2:	249000ef          	jal	1cfa <fprintf>
    exit(1);
    12b6:	4505                	li	a0,1
    12b8:	5f6000ef          	jal	18ae <exit>
    12bc:	08100613          	li	a2,129
    12c0:	00002597          	auipc	a1,0x2
    12c4:	d5058593          	addi	a1,a1,-688 # 3010 <fs_buffer>
    12c8:	606000ef          	jal	18ce <write>
    12cc:	08100793          	li	a5,129
    12d0:	faf51ae3          	bne	a0,a5,1284 <main+0x1228>
          close(fd) == 0,
    12d4:	8526                	mv	a0,s1
    12d6:	600000ef          	jal	18d6 <close>
  if (!ok) {
    12da:	f54d                	bnez	a0,1284 <main+0x1228>
  unavailable("edge_bad");
    12dc:	00001517          	auipc	a0,0x1
    12e0:	53450513          	addi	a0,a0,1332 # 2810 <malloc+0xa30>
    12e4:	d3ffe0ef          	jal	22 <unavailable>
  check(unlink("edge_bad") == 0, "remove oversized fixture");
    12e8:	00001517          	auipc	a0,0x1
    12ec:	52850513          	addi	a0,a0,1320 # 2810 <malloc+0xa30>
    12f0:	60e000ef          	jal	18fe <unlink>
    12f4:	ed31                	bnez	a0,1350 <main+0x12f4>
    check(unlink(valid_names[i]) == 0, "remove malformed-target control");
    12f6:	00001517          	auipc	a0,0x1
    12fa:	4ea50513          	addi	a0,a0,1258 # 27e0 <malloc+0xa00>
    12fe:	600000ef          	jal	18fe <unlink>
    1302:	e52d                	bnez	a0,136c <main+0x1310>
    1304:	00001517          	auipc	a0,0x1
    1308:	4e450513          	addi	a0,a0,1252 # 27e8 <malloc+0xa08>
    130c:	5f2000ef          	jal	18fe <unlink>
    1310:	ed31                	bnez	a0,136c <main+0x1310>
  check(mkdir("edge_dir") == 0, "create expansion directory");
    1312:	00001517          	auipc	a0,0x1
    1316:	5f650513          	addi	a0,a0,1526 # 2908 <malloc+0xb28>
    131a:	5fc000ef          	jal	1916 <mkdir>
    131e:	e52d                	bnez	a0,1388 <main+0x132c>
  fd = open("edge_dir/t", O_CREATE | O_WRONLY);
    1320:	20100593          	li	a1,513
    1324:	00001517          	auipc	a0,0x1
    1328:	61450513          	addi	a0,a0,1556 # 2938 <malloc+0xb58>
    132c:	5c2000ef          	jal	18ee <open>
  check(fd >= 0 && close(fd) == 0, "create expansion target");
    1330:	06055a63          	bgez	a0,13a4 <main+0x1348>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1334:	00001617          	auipc	a2,0x1
    1338:	61460613          	addi	a2,a2,1556 # 2948 <malloc+0xb68>
    133c:	00001597          	auipc	a1,0x1
    1340:	ba458593          	addi	a1,a1,-1116 # 1ee0 <malloc+0x100>
    1344:	4509                	li	a0,2
    1346:	1b5000ef          	jal	1cfa <fprintf>
    exit(1);
    134a:	4505                	li	a0,1
    134c:	562000ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1350:	00001617          	auipc	a2,0x1
    1354:	57860613          	addi	a2,a2,1400 # 28c8 <malloc+0xae8>
    1358:	00001597          	auipc	a1,0x1
    135c:	b8858593          	addi	a1,a1,-1144 # 1ee0 <malloc+0x100>
    1360:	4509                	li	a0,2
    1362:	199000ef          	jal	1cfa <fprintf>
    exit(1);
    1366:	4505                	li	a0,1
    1368:	546000ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
    136c:	00001617          	auipc	a2,0x1
    1370:	57c60613          	addi	a2,a2,1404 # 28e8 <malloc+0xb08>
    1374:	00001597          	auipc	a1,0x1
    1378:	b6c58593          	addi	a1,a1,-1172 # 1ee0 <malloc+0x100>
    137c:	4509                	li	a0,2
    137e:	17d000ef          	jal	1cfa <fprintf>
    exit(1);
    1382:	4505                	li	a0,1
    1384:	52a000ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1388:	00001617          	auipc	a2,0x1
    138c:	59060613          	addi	a2,a2,1424 # 2918 <malloc+0xb38>
    1390:	00001597          	auipc	a1,0x1
    1394:	b5058593          	addi	a1,a1,-1200 # 1ee0 <malloc+0x100>
    1398:	4509                	li	a0,2
    139a:	161000ef          	jal	1cfa <fprintf>
    exit(1);
    139e:	4505                	li	a0,1
    13a0:	50e000ef          	jal	18ae <exit>
    13a4:	532000ef          	jal	18d6 <close>
  if (!ok) {
    13a8:	f551                	bnez	a0,1334 <main+0x12d8>
  memset(target, '/', sizeof(target));
    13aa:	da040493          	addi	s1,s0,-608
    13ae:	08000613          	li	a2,128
    13b2:	02f00593          	li	a1,47
    13b6:	8526                	mv	a0,s1
    13b8:	2cc000ef          	jal	1684 <memset>
  target[0] = '.';
    13bc:	02e00793          	li	a5,46
    13c0:	daf40023          	sb	a5,-608(s0)
  target[MAXPATH - 2] = 't';
    13c4:	07400793          	li	a5,116
    13c8:	e0f40f23          	sb	a5,-482(s0)
  target[MAXPATH - 1] = 0;
    13cc:	e0040fa3          	sb	zero,-481(s0)
  check(symlink(target, "edge_dir/long") == 0,
    13d0:	00001597          	auipc	a1,0x1
    13d4:	59058593          	addi	a1,a1,1424 # 2960 <malloc+0xb80>
    13d8:	8526                	mv	a0,s1
    13da:	58c000ef          	jal	1966 <symlink>
    13de:	ed05                	bnez	a0,1416 <main+0x13ba>
  unavailable("edge_dir/long");
    13e0:	00001517          	auipc	a0,0x1
    13e4:	58050513          	addi	a0,a0,1408 # 2960 <malloc+0xb80>
    13e8:	c3bfe0ef          	jal	22 <unavailable>
  check(unlink("edge_dir/long") == 0 && unlink("edge_dir/t") == 0 &&
    13ec:	00001517          	auipc	a0,0x1
    13f0:	57450513          	addi	a0,a0,1396 # 2960 <malloc+0xb80>
    13f4:	50a000ef          	jal	18fe <unlink>
    13f8:	cd0d                	beqz	a0,1432 <main+0x13d6>
    fprintf(2, "TEST FAILURE: %s\n", why);
    13fa:	00001617          	auipc	a2,0x1
    13fe:	5ae60613          	addi	a2,a2,1454 # 29a8 <malloc+0xbc8>
    1402:	00001597          	auipc	a1,0x1
    1406:	ade58593          	addi	a1,a1,-1314 # 1ee0 <malloc+0x100>
    140a:	4509                	li	a0,2
    140c:	0ef000ef          	jal	1cfa <fprintf>
    exit(1);
    1410:	4505                	li	a0,1
    1412:	49c000ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1416:	00001617          	auipc	a2,0x1
    141a:	55a60613          	addi	a2,a2,1370 # 2970 <malloc+0xb90>
    141e:	00001597          	auipc	a1,0x1
    1422:	ac258593          	addi	a1,a1,-1342 # 1ee0 <malloc+0x100>
    1426:	4509                	li	a0,2
    1428:	0d3000ef          	jal	1cfa <fprintf>
    exit(1);
    142c:	4505                	li	a0,1
    142e:	480000ef          	jal	18ae <exit>
    1432:	00001517          	auipc	a0,0x1
    1436:	50650513          	addi	a0,a0,1286 # 2938 <malloc+0xb58>
    143a:	4c4000ef          	jal	18fe <unlink>
    143e:	fd55                	bnez	a0,13fa <main+0x139e>
          unlink("edge_dir") == 0,
    1440:	00001517          	auipc	a0,0x1
    1444:	4c850513          	addi	a0,a0,1224 # 2908 <malloc+0xb28>
    1448:	4b6000ef          	jal	18fe <unlink>
  if (!ok) {
    144c:	f55d                	bnez	a0,13fa <main+0x139e>
  check(pipe(gate) == 0, "create concurrent-start pipe");
    144e:	d5840513          	addi	a0,s0,-680
    1452:	46c000ef          	jal	18be <pipe>
    1456:	4491                	li	s1,4
    1458:	e531                	bnez	a0,14a4 <main+0x1448>
    int pid = fork();
    145a:	44c000ef          	jal	18a6 <fork>
    145e:	06054163          	bltz	a0,14c0 <main+0x1464>
    if (pid == 0) {
    1462:	cd2d                	beqz	a0,14dc <main+0x1480>
  for (int i = 0; i < 4; i++) {
    1464:	34fd                	addiw	s1,s1,-1
    1466:	f8f5                	bnez	s1,145a <main+0x13fe>
  close(gate[0]);
    1468:	d5842503          	lw	a0,-680(s0)
    146c:	46a000ef          	jal	18d6 <close>
  check(write(gate[1], "go!!", 4) == 4 && close(gate[1]) == 0,
    1470:	4611                	li	a2,4
    1472:	00001597          	auipc	a1,0x1
    1476:	59e58593          	addi	a1,a1,1438 # 2a10 <malloc+0xc30>
    147a:	d5c42503          	lw	a0,-676(s0)
    147e:	450000ef          	jal	18ce <write>
    1482:	4791                	li	a5,4
    1484:	0af50563          	beq	a0,a5,152e <main+0x14d2>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1488:	00001617          	auipc	a2,0x1
    148c:	59060613          	addi	a2,a2,1424 # 2a18 <malloc+0xc38>
    1490:	00001597          	auipc	a1,0x1
    1494:	a5058593          	addi	a1,a1,-1456 # 1ee0 <malloc+0x100>
    1498:	4509                	li	a0,2
    149a:	061000ef          	jal	1cfa <fprintf>
    exit(1);
    149e:	4505                	li	a0,1
    14a0:	40e000ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
    14a4:	00001617          	auipc	a2,0x1
    14a8:	52460613          	addi	a2,a2,1316 # 29c8 <malloc+0xbe8>
    14ac:	00001597          	auipc	a1,0x1
    14b0:	a3458593          	addi	a1,a1,-1484 # 1ee0 <malloc+0x100>
    14b4:	4509                	li	a0,2
    14b6:	045000ef          	jal	1cfa <fprintf>
    exit(1);
    14ba:	4505                	li	a0,1
    14bc:	3f2000ef          	jal	18ae <exit>
    fprintf(2, "TEST FAILURE: %s\n", why);
    14c0:	00001617          	auipc	a2,0x1
    14c4:	52860613          	addi	a2,a2,1320 # 29e8 <malloc+0xc08>
    14c8:	00001597          	auipc	a1,0x1
    14cc:	a1858593          	addi	a1,a1,-1512 # 1ee0 <malloc+0x100>
    14d0:	4509                	li	a0,2
    14d2:	029000ef          	jal	1cfa <fprintf>
    exit(1);
    14d6:	4505                	li	a0,1
    14d8:	3d6000ef          	jal	18ae <exit>
      close(gate[1]);
    14dc:	d5c42503          	lw	a0,-676(s0)
    14e0:	3f6000ef          	jal	18d6 <close>
      if (read(gate[0], &ready, 1) != 1)
    14e4:	4605                	li	a2,1
    14e6:	d5440593          	addi	a1,s0,-684
    14ea:	d5842503          	lw	a0,-680(s0)
    14ee:	3d8000ef          	jal	18c6 <read>
    14f2:	84aa                	mv	s1,a0
    14f4:	4785                	li	a5,1
    14f6:	00f50563          	beq	a0,a5,1500 <main+0x14a4>
        exit(2);
    14fa:	4509                	li	a0,2
    14fc:	3b2000ef          	jal	18ae <exit>
      close(gate[0]);
    1500:	d5842503          	lw	a0,-680(s0)
    1504:	3d2000ef          	jal	18d6 <close>
      int result = symlink("target", "edge_race");
    1508:	00001597          	auipc	a1,0x1
    150c:	4f858593          	addi	a1,a1,1272 # 2a00 <malloc+0xc20>
    1510:	00001517          	auipc	a0,0x1
    1514:	d6050513          	addi	a0,a0,-672 # 2270 <malloc+0x490>
    1518:	44e000ef          	jal	1966 <symlink>
      exit(result == 0 ? 0 : result == -1 ? 1 : 2);
    151c:	c509                	beqz	a0,1526 <main+0x14ca>
    151e:	57fd                	li	a5,-1
    1520:	00f50563          	beq	a0,a5,152a <main+0x14ce>
    1524:	4509                	li	a0,2
    1526:	388000ef          	jal	18ae <exit>
    152a:	8526                	mv	a0,s1
    152c:	bfed                	j	1526 <main+0x14ca>
  check(write(gate[1], "go!!", 4) == 4 && close(gate[1]) == 0,
    152e:	d5c42503          	lw	a0,-676(s0)
    1532:	3a4000ef          	jal	18d6 <close>
    1536:	89aa                	mv	s3,a0
  if (!ok) {
    1538:	4911                	li	s2,4
    check(wait(&status) > 0 && (status == 0 || status == 1),
    153a:	d5440a13          	addi	s4,s0,-684
    153e:	4a85                	li	s5,1
    1540:	cd11                	beqz	a0,155c <main+0x1500>
    1542:	b799                	j	1488 <main+0x142c>
    1544:	d5442783          	lw	a5,-684(s0)
    1548:	00faef63          	bltu	s5,a5,1566 <main+0x150a>
    winners += status == 0;
    154c:	0017b793          	seqz	a5,a5
    1550:	013784bb          	addw	s1,a5,s3
    1554:	89a6                	mv	s3,s1
  for (int i = 0; i < 4; i++) {
    1556:	397d                	addiw	s2,s2,-1
    1558:	02090563          	beqz	s2,1582 <main+0x1526>
    check(wait(&status) > 0 && (status == 0 || status == 1),
    155c:	8552                	mv	a0,s4
    155e:	358000ef          	jal	18b6 <wait>
    1562:	fea041e3          	bgtz	a0,1544 <main+0x14e8>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1566:	00001617          	auipc	a2,0x1
    156a:	4d260613          	addi	a2,a2,1234 # 2a38 <malloc+0xc58>
    156e:	00001597          	auipc	a1,0x1
    1572:	97258593          	addi	a1,a1,-1678 # 1ee0 <malloc+0x100>
    1576:	4509                	li	a0,2
    1578:	782000ef          	jal	1cfa <fprintf>
    exit(1);
    157c:	4505                	li	a0,1
    157e:	330000ef          	jal	18ae <exit>
  check(winners == 1 && unlink("edge_race") == 0,
    1582:	4785                	li	a5,1
    1584:	02f48063          	beq	s1,a5,15a4 <main+0x1548>
    fprintf(2, "TEST FAILURE: %s\n", why);
    1588:	00001617          	auipc	a2,0x1
    158c:	4e060613          	addi	a2,a2,1248 # 2a68 <malloc+0xc88>
    1590:	00001597          	auipc	a1,0x1
    1594:	95058593          	addi	a1,a1,-1712 # 1ee0 <malloc+0x100>
    1598:	4509                	li	a0,2
    159a:	760000ef          	jal	1cfa <fprintf>
    exit(1);
    159e:	4505                	li	a0,1
    15a0:	30e000ef          	jal	18ae <exit>
    15a4:	00001517          	auipc	a0,0x1
    15a8:	45c50513          	addi	a0,a0,1116 # 2a00 <malloc+0xc20>
    15ac:	352000ef          	jal	18fe <unlink>
    15b0:	89aa                	mv	s3,a0
  if (!ok) {
    15b2:	f979                	bnez	a0,1588 <main+0x152c>
  edge_tests();
  check(chdir("..") == 0 && unlink("fst_syms.tmp") == 0,
    15b4:	00001517          	auipc	a0,0x1
    15b8:	4e450513          	addi	a0,a0,1252 # 2a98 <malloc+0xcb8>
    15bc:	362000ef          	jal	191e <chdir>
    15c0:	892a                	mv	s2,a0
    15c2:	c115                	beqz	a0,15e6 <main+0x158a>
    15c4:	894e                	mv	s2,s3
    15c6:	00001597          	auipc	a1,0x1
    15ca:	4da58593          	addi	a1,a1,1242 # 2aa0 <malloc+0xcc0>
    15ce:	854a                	mv	a0,s2
    15d0:	a31fe0ef          	jal	0 <check>
        "remove symlink test directory");
  printf("symlinktest: passed\n");
    15d4:	00001517          	auipc	a0,0x1
    15d8:	4ec50513          	addi	a0,a0,1260 # 2ac0 <malloc+0xce0>
    15dc:	748000ef          	jal	1d24 <printf>
  exit(0);
    15e0:	4501                	li	a0,0
    15e2:	2cc000ef          	jal	18ae <exit>
  check(chdir("..") == 0 && unlink("fst_syms.tmp") == 0,
    15e6:	00001517          	auipc	a0,0x1
    15ea:	94a50513          	addi	a0,a0,-1718 # 1f30 <malloc+0x150>
    15ee:	310000ef          	jal	18fe <unlink>
    15f2:	f971                	bnez	a0,15c6 <main+0x156a>
    15f4:	8926                	mv	s2,s1
    15f6:	bfc1                	j	15c6 <main+0x156a>

00000000000015f8 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
    15f8:	1141                	addi	sp,sp,-16
    15fa:	e406                	sd	ra,8(sp)
    15fc:	e022                	sd	s0,0(sp)
    15fe:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
    1600:	a5dfe0ef          	jal	5c <main>
  exit(r);
    1604:	2aa000ef          	jal	18ae <exit>

0000000000001608 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
    1608:	1141                	addi	sp,sp,-16
    160a:	e406                	sd	ra,8(sp)
    160c:	e022                	sd	s0,0(sp)
    160e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
    1610:	87aa                	mv	a5,a0
    1612:	0585                	addi	a1,a1,1
    1614:	0785                	addi	a5,a5,1
    1616:	fff5c703          	lbu	a4,-1(a1)
    161a:	fee78fa3          	sb	a4,-1(a5)
    161e:	fb75                	bnez	a4,1612 <strcpy+0xa>
    ;
  return os;
}
    1620:	60a2                	ld	ra,8(sp)
    1622:	6402                	ld	s0,0(sp)
    1624:	0141                	addi	sp,sp,16
    1626:	8082                	ret

0000000000001628 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1628:	1141                	addi	sp,sp,-16
    162a:	e406                	sd	ra,8(sp)
    162c:	e022                	sd	s0,0(sp)
    162e:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
    1630:	00054783          	lbu	a5,0(a0)
    1634:	cb91                	beqz	a5,1648 <strcmp+0x20>
    1636:	0005c703          	lbu	a4,0(a1)
    163a:	00f71763          	bne	a4,a5,1648 <strcmp+0x20>
    p++, q++;
    163e:	0505                	addi	a0,a0,1
    1640:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
    1642:	00054783          	lbu	a5,0(a0)
    1646:	fbe5                	bnez	a5,1636 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
    1648:	0005c503          	lbu	a0,0(a1)
}
    164c:	40a7853b          	subw	a0,a5,a0
    1650:	60a2                	ld	ra,8(sp)
    1652:	6402                	ld	s0,0(sp)
    1654:	0141                	addi	sp,sp,16
    1656:	8082                	ret

0000000000001658 <strlen>:

uint
strlen(const char *s)
{
    1658:	1141                	addi	sp,sp,-16
    165a:	e406                	sd	ra,8(sp)
    165c:	e022                	sd	s0,0(sp)
    165e:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
    1660:	00054783          	lbu	a5,0(a0)
    1664:	cf91                	beqz	a5,1680 <strlen+0x28>
    1666:	00150793          	addi	a5,a0,1
    166a:	86be                	mv	a3,a5
    166c:	0785                	addi	a5,a5,1
    166e:	fff7c703          	lbu	a4,-1(a5)
    1672:	ff65                	bnez	a4,166a <strlen+0x12>
    1674:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
    1678:	60a2                	ld	ra,8(sp)
    167a:	6402                	ld	s0,0(sp)
    167c:	0141                	addi	sp,sp,16
    167e:	8082                	ret
  for (n = 0; s[n]; n++)
    1680:	4501                	li	a0,0
    1682:	bfdd                	j	1678 <strlen+0x20>

0000000000001684 <memset>:

void *
memset(void *dst, int c, uint n)
{
    1684:	1141                	addi	sp,sp,-16
    1686:	e406                	sd	ra,8(sp)
    1688:	e022                	sd	s0,0(sp)
    168a:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
    168c:	ca19                	beqz	a2,16a2 <memset+0x1e>
    168e:	87aa                	mv	a5,a0
    1690:	1602                	slli	a2,a2,0x20
    1692:	9201                	srli	a2,a2,0x20
    1694:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    1698:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
    169c:	0785                	addi	a5,a5,1
    169e:	fee79de3          	bne	a5,a4,1698 <memset+0x14>
  }
  return dst;
}
    16a2:	60a2                	ld	ra,8(sp)
    16a4:	6402                	ld	s0,0(sp)
    16a6:	0141                	addi	sp,sp,16
    16a8:	8082                	ret

00000000000016aa <strchr>:

char *
strchr(const char *s, char c)
{
    16aa:	1141                	addi	sp,sp,-16
    16ac:	e406                	sd	ra,8(sp)
    16ae:	e022                	sd	s0,0(sp)
    16b0:	0800                	addi	s0,sp,16
  for (; *s; s++)
    16b2:	00054783          	lbu	a5,0(a0)
    16b6:	c799                	beqz	a5,16c4 <strchr+0x1a>
    if (*s == c)
    16b8:	00f58763          	beq	a1,a5,16c6 <strchr+0x1c>
  for (; *s; s++)
    16bc:	0505                	addi	a0,a0,1
    16be:	00054783          	lbu	a5,0(a0)
    16c2:	fbfd                	bnez	a5,16b8 <strchr+0xe>
      return (char *)s;
  return 0;
    16c4:	4501                	li	a0,0
}
    16c6:	60a2                	ld	ra,8(sp)
    16c8:	6402                	ld	s0,0(sp)
    16ca:	0141                	addi	sp,sp,16
    16cc:	8082                	ret

00000000000016ce <gets>:

char *
gets(char *buf, int max)
{
    16ce:	711d                	addi	sp,sp,-96
    16d0:	ec86                	sd	ra,88(sp)
    16d2:	e8a2                	sd	s0,80(sp)
    16d4:	e4a6                	sd	s1,72(sp)
    16d6:	e0ca                	sd	s2,64(sp)
    16d8:	fc4e                	sd	s3,56(sp)
    16da:	f852                	sd	s4,48(sp)
    16dc:	f456                	sd	s5,40(sp)
    16de:	f05a                	sd	s6,32(sp)
    16e0:	ec5e                	sd	s7,24(sp)
    16e2:	e862                	sd	s8,16(sp)
    16e4:	1080                	addi	s0,sp,96
    16e6:	8baa                	mv	s7,a0
    16e8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
    16ea:	892a                	mv	s2,a0
    16ec:	4481                	li	s1,0
    cc = read(0, &c, 1);
    16ee:	faf40b13          	addi	s6,s0,-81
    16f2:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;) {
    16f4:	8c26                	mv	s8,s1
    16f6:	0014899b          	addiw	s3,s1,1
    16fa:	84ce                	mv	s1,s3
    16fc:	0349d863          	bge	s3,s4,172c <gets+0x5e>
    cc = read(0, &c, 1);
    1700:	8656                	mv	a2,s5
    1702:	85da                	mv	a1,s6
    1704:	4501                	li	a0,0
    1706:	1c0000ef          	jal	18c6 <read>
    if (cc < 1)
    170a:	02a05163          	blez	a0,172c <gets+0x5e>
      break;
    buf[i++] = c;
    170e:	faf44783          	lbu	a5,-81(s0)
    1712:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
    1716:	0905                	addi	s2,s2,1
    1718:	ff678713          	addi	a4,a5,-10
    171c:	00173713          	seqz	a4,a4
    1720:	17cd                	addi	a5,a5,-13
    1722:	0017b793          	seqz	a5,a5
    1726:	8fd9                	or	a5,a5,a4
    1728:	d7f1                	beqz	a5,16f4 <gets+0x26>
    buf[i++] = c;
    172a:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
    172c:	9c5e                	add	s8,s8,s7
    172e:	000c0023          	sb	zero,0(s8)
  return buf;
}
    1732:	855e                	mv	a0,s7
    1734:	60e6                	ld	ra,88(sp)
    1736:	6446                	ld	s0,80(sp)
    1738:	64a6                	ld	s1,72(sp)
    173a:	6906                	ld	s2,64(sp)
    173c:	79e2                	ld	s3,56(sp)
    173e:	7a42                	ld	s4,48(sp)
    1740:	7aa2                	ld	s5,40(sp)
    1742:	7b02                	ld	s6,32(sp)
    1744:	6be2                	ld	s7,24(sp)
    1746:	6c42                	ld	s8,16(sp)
    1748:	6125                	addi	sp,sp,96
    174a:	8082                	ret

000000000000174c <stat>:

int
stat(const char *n, struct stat *st)
{
    174c:	1101                	addi	sp,sp,-32
    174e:	ec06                	sd	ra,24(sp)
    1750:	e822                	sd	s0,16(sp)
    1752:	e04a                	sd	s2,0(sp)
    1754:	1000                	addi	s0,sp,32
    1756:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1758:	4581                	li	a1,0
    175a:	194000ef          	jal	18ee <open>
  if (fd < 0)
    175e:	02054263          	bltz	a0,1782 <stat+0x36>
    1762:	e426                	sd	s1,8(sp)
    1764:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    1766:	85ca                	mv	a1,s2
    1768:	19e000ef          	jal	1906 <fstat>
    176c:	892a                	mv	s2,a0
  close(fd);
    176e:	8526                	mv	a0,s1
    1770:	166000ef          	jal	18d6 <close>
  return r;
    1774:	64a2                	ld	s1,8(sp)
}
    1776:	854a                	mv	a0,s2
    1778:	60e2                	ld	ra,24(sp)
    177a:	6442                	ld	s0,16(sp)
    177c:	6902                	ld	s2,0(sp)
    177e:	6105                	addi	sp,sp,32
    1780:	8082                	ret
    return -1;
    1782:	57fd                	li	a5,-1
    1784:	893e                	mv	s2,a5
    1786:	bfc5                	j	1776 <stat+0x2a>

0000000000001788 <atoi>:

int
atoi(const char *s)
{
    1788:	1141                	addi	sp,sp,-16
    178a:	e406                	sd	ra,8(sp)
    178c:	e022                	sd	s0,0(sp)
    178e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
    1790:	00054683          	lbu	a3,0(a0)
    1794:	fd06879b          	addiw	a5,a3,-48
    1798:	0ff7f793          	zext.b	a5,a5
    179c:	4625                	li	a2,9
    179e:	02f66963          	bltu	a2,a5,17d0 <atoi+0x48>
    17a2:	872a                	mv	a4,a0
  n = 0;
    17a4:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
    17a6:	0705                	addi	a4,a4,1
    17a8:	0025179b          	slliw	a5,a0,0x2
    17ac:	9fa9                	addw	a5,a5,a0
    17ae:	0017979b          	slliw	a5,a5,0x1
    17b2:	9fb5                	addw	a5,a5,a3
    17b4:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
    17b8:	00074683          	lbu	a3,0(a4)
    17bc:	fd06879b          	addiw	a5,a3,-48
    17c0:	0ff7f793          	zext.b	a5,a5
    17c4:	fef671e3          	bgeu	a2,a5,17a6 <atoi+0x1e>
  return n;
}
    17c8:	60a2                	ld	ra,8(sp)
    17ca:	6402                	ld	s0,0(sp)
    17cc:	0141                	addi	sp,sp,16
    17ce:	8082                	ret
  n = 0;
    17d0:	4501                	li	a0,0
    17d2:	bfdd                	j	17c8 <atoi+0x40>

00000000000017d4 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
    17d4:	1141                	addi	sp,sp,-16
    17d6:	e406                	sd	ra,8(sp)
    17d8:	e022                	sd	s0,0(sp)
    17da:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    17dc:	02b57563          	bgeu	a0,a1,1806 <memmove+0x32>
    while (n-- > 0)
    17e0:	00c05f63          	blez	a2,17fe <memmove+0x2a>
    17e4:	1602                	slli	a2,a2,0x20
    17e6:	9201                	srli	a2,a2,0x20
    17e8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    17ec:	872a                	mv	a4,a0
      *dst++ = *src++;
    17ee:	0585                	addi	a1,a1,1
    17f0:	0705                	addi	a4,a4,1
    17f2:	fff5c683          	lbu	a3,-1(a1)
    17f6:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
    17fa:	fee79ae3          	bne	a5,a4,17ee <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    17fe:	60a2                	ld	ra,8(sp)
    1800:	6402                	ld	s0,0(sp)
    1802:	0141                	addi	sp,sp,16
    1804:	8082                	ret
    while (n-- > 0)
    1806:	fec05ce3          	blez	a2,17fe <memmove+0x2a>
    dst += n;
    180a:	00c50733          	add	a4,a0,a2
    src += n;
    180e:	95b2                	add	a1,a1,a2
    1810:	fff6079b          	addiw	a5,a2,-1
    1814:	1782                	slli	a5,a5,0x20
    1816:	9381                	srli	a5,a5,0x20
    1818:	fff7c793          	not	a5,a5
    181c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    181e:	15fd                	addi	a1,a1,-1
    1820:	177d                	addi	a4,a4,-1
    1822:	0005c683          	lbu	a3,0(a1)
    1826:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
    182a:	fef71ae3          	bne	a4,a5,181e <memmove+0x4a>
    182e:	bfc1                	j	17fe <memmove+0x2a>

0000000000001830 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    1830:	1141                	addi	sp,sp,-16
    1832:	e406                	sd	ra,8(sp)
    1834:	e022                	sd	s0,0(sp)
    1836:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    1838:	ce19                	beqz	a2,1856 <memcmp+0x26>
    183a:	1602                	slli	a2,a2,0x20
    183c:	9201                	srli	a2,a2,0x20
    183e:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
    1842:	00054783          	lbu	a5,0(a0)
    1846:	0005c703          	lbu	a4,0(a1)
    184a:	00e79b63          	bne	a5,a4,1860 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
    184e:	0505                	addi	a0,a0,1
    p2++;
    1850:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    1852:	fed518e3          	bne	a0,a3,1842 <memcmp+0x12>
  }
  return 0;
    1856:	4501                	li	a0,0
}
    1858:	60a2                	ld	ra,8(sp)
    185a:	6402                	ld	s0,0(sp)
    185c:	0141                	addi	sp,sp,16
    185e:	8082                	ret
      return *p1 - *p2;
    1860:	40e7853b          	subw	a0,a5,a4
    1864:	bfd5                	j	1858 <memcmp+0x28>

0000000000001866 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    1866:	1141                	addi	sp,sp,-16
    1868:	e406                	sd	ra,8(sp)
    186a:	e022                	sd	s0,0(sp)
    186c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    186e:	f67ff0ef          	jal	17d4 <memmove>
}
    1872:	60a2                	ld	ra,8(sp)
    1874:	6402                	ld	s0,0(sp)
    1876:	0141                	addi	sp,sp,16
    1878:	8082                	ret

000000000000187a <sbrk>:

char *
sbrk(int n)
{
    187a:	1141                	addi	sp,sp,-16
    187c:	e406                	sd	ra,8(sp)
    187e:	e022                	sd	s0,0(sp)
    1880:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
    1882:	4585                	li	a1,1
    1884:	0b2000ef          	jal	1936 <sys_sbrk>
}
    1888:	60a2                	ld	ra,8(sp)
    188a:	6402                	ld	s0,0(sp)
    188c:	0141                	addi	sp,sp,16
    188e:	8082                	ret

0000000000001890 <sbrklazy>:

char *
sbrklazy(int n)
{
    1890:	1141                	addi	sp,sp,-16
    1892:	e406                	sd	ra,8(sp)
    1894:	e022                	sd	s0,0(sp)
    1896:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
    1898:	4589                	li	a1,2
    189a:	09c000ef          	jal	1936 <sys_sbrk>
}
    189e:	60a2                	ld	ra,8(sp)
    18a0:	6402                	ld	s0,0(sp)
    18a2:	0141                	addi	sp,sp,16
    18a4:	8082                	ret

00000000000018a6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    18a6:	4885                	li	a7,1
 ecall
    18a8:	00000073          	ecall
 ret
    18ac:	8082                	ret

00000000000018ae <exit>:
.global exit
exit:
 li a7, SYS_exit
    18ae:	4889                	li	a7,2
 ecall
    18b0:	00000073          	ecall
 ret
    18b4:	8082                	ret

00000000000018b6 <wait>:
.global wait
wait:
 li a7, SYS_wait
    18b6:	488d                	li	a7,3
 ecall
    18b8:	00000073          	ecall
 ret
    18bc:	8082                	ret

00000000000018be <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    18be:	4891                	li	a7,4
 ecall
    18c0:	00000073          	ecall
 ret
    18c4:	8082                	ret

00000000000018c6 <read>:
.global read
read:
 li a7, SYS_read
    18c6:	4895                	li	a7,5
 ecall
    18c8:	00000073          	ecall
 ret
    18cc:	8082                	ret

00000000000018ce <write>:
.global write
write:
 li a7, SYS_write
    18ce:	48c1                	li	a7,16
 ecall
    18d0:	00000073          	ecall
 ret
    18d4:	8082                	ret

00000000000018d6 <close>:
.global close
close:
 li a7, SYS_close
    18d6:	48d5                	li	a7,21
 ecall
    18d8:	00000073          	ecall
 ret
    18dc:	8082                	ret

00000000000018de <kill>:
.global kill
kill:
 li a7, SYS_kill
    18de:	4899                	li	a7,6
 ecall
    18e0:	00000073          	ecall
 ret
    18e4:	8082                	ret

00000000000018e6 <exec>:
.global exec
exec:
 li a7, SYS_exec
    18e6:	489d                	li	a7,7
 ecall
    18e8:	00000073          	ecall
 ret
    18ec:	8082                	ret

00000000000018ee <open>:
.global open
open:
 li a7, SYS_open
    18ee:	48bd                	li	a7,15
 ecall
    18f0:	00000073          	ecall
 ret
    18f4:	8082                	ret

00000000000018f6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    18f6:	48c5                	li	a7,17
 ecall
    18f8:	00000073          	ecall
 ret
    18fc:	8082                	ret

00000000000018fe <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    18fe:	48c9                	li	a7,18
 ecall
    1900:	00000073          	ecall
 ret
    1904:	8082                	ret

0000000000001906 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    1906:	48a1                	li	a7,8
 ecall
    1908:	00000073          	ecall
 ret
    190c:	8082                	ret

000000000000190e <link>:
.global link
link:
 li a7, SYS_link
    190e:	48cd                	li	a7,19
 ecall
    1910:	00000073          	ecall
 ret
    1914:	8082                	ret

0000000000001916 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    1916:	48d1                	li	a7,20
 ecall
    1918:	00000073          	ecall
 ret
    191c:	8082                	ret

000000000000191e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    191e:	48a5                	li	a7,9
 ecall
    1920:	00000073          	ecall
 ret
    1924:	8082                	ret

0000000000001926 <dup>:
.global dup
dup:
 li a7, SYS_dup
    1926:	48a9                	li	a7,10
 ecall
    1928:	00000073          	ecall
 ret
    192c:	8082                	ret

000000000000192e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    192e:	48ad                	li	a7,11
 ecall
    1930:	00000073          	ecall
 ret
    1934:	8082                	ret

0000000000001936 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
    1936:	48b1                	li	a7,12
 ecall
    1938:	00000073          	ecall
 ret
    193c:	8082                	ret

000000000000193e <pause>:
.global pause
pause:
 li a7, SYS_pause
    193e:	48b5                	li	a7,13
 ecall
    1940:	00000073          	ecall
 ret
    1944:	8082                	ret

0000000000001946 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    1946:	48b9                	li	a7,14
 ecall
    1948:	00000073          	ecall
 ret
    194c:	8082                	ret

000000000000194e <sync>:
.global sync
sync:
 li a7, SYS_sync
    194e:	48d9                	li	a7,22
 ecall
    1950:	00000073          	ecall
 ret
    1954:	8082                	ret

0000000000001956 <istat>:
.global istat
istat:
 li a7, SYS_istat
    1956:	48dd                	li	a7,23
 ecall
    1958:	00000073          	ecall
 ret
    195c:	8082                	ret

000000000000195e <iprint>:
.global iprint
iprint:
 li a7, SYS_iprint
    195e:	48e1                	li	a7,24
 ecall
    1960:	00000073          	ecall
 ret
    1964:	8082                	ret

0000000000001966 <symlink>:
.global symlink
symlink:
 li a7, SYS_symlink
    1966:	48e5                	li	a7,25
 ecall
    1968:	00000073          	ecall
 ret
    196c:	8082                	ret

000000000000196e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    196e:	1101                	addi	sp,sp,-32
    1970:	ec06                	sd	ra,24(sp)
    1972:	e822                	sd	s0,16(sp)
    1974:	1000                	addi	s0,sp,32
    1976:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    197a:	4605                	li	a2,1
    197c:	fef40593          	addi	a1,s0,-17
    1980:	f4fff0ef          	jal	18ce <write>
}
    1984:	60e2                	ld	ra,24(sp)
    1986:	6442                	ld	s0,16(sp)
    1988:	6105                	addi	sp,sp,32
    198a:	8082                	ret

000000000000198c <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
    198c:	715d                	addi	sp,sp,-80
    198e:	e486                	sd	ra,72(sp)
    1990:	e0a2                	sd	s0,64(sp)
    1992:	f84a                	sd	s2,48(sp)
    1994:	f44e                	sd	s3,40(sp)
    1996:	0880                	addi	s0,sp,80
    1998:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
    199a:	00d036b3          	snez	a3,a3
    199e:	03f5d793          	srli	a5,a1,0x3f
    19a2:	8efd                	and	a3,a3,a5
  neg = 0;
    19a4:	4301                	li	t1,0
  if (sgn && xx < 0) {
    19a6:	c681                	beqz	a3,19ae <printint+0x22>
    neg = 1;
    x = -xx;
    19a8:	40b005b3          	neg	a1,a1
    neg = 1;
    19ac:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
    19ae:	fb840993          	addi	s3,s0,-72
  neg = 0;
    19b2:	86ce                	mv	a3,s3
  i = 0;
    19b4:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    19b6:	00001817          	auipc	a6,0x1
    19ba:	1ea80813          	addi	a6,a6,490 # 2ba0 <digits>
    19be:	88ba                	mv	a7,a4
    19c0:	0017051b          	addiw	a0,a4,1
    19c4:	872a                	mv	a4,a0
    19c6:	02c5f7b3          	remu	a5,a1,a2
    19ca:	97c2                	add	a5,a5,a6
    19cc:	0007c783          	lbu	a5,0(a5)
    19d0:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
    19d4:	87ae                	mv	a5,a1
    19d6:	02c5d5b3          	divu	a1,a1,a2
    19da:	0685                	addi	a3,a3,1
    19dc:	fec7f1e3          	bgeu	a5,a2,19be <printint+0x32>
  if (neg)
    19e0:	00030b63          	beqz	t1,19f6 <printint+0x6a>
    buf[i++] = '-';
    19e4:	fd040793          	addi	a5,s0,-48
    19e8:	953e                	add	a0,a0,a5
    19ea:	02d00793          	li	a5,45
    19ee:	fef50423          	sb	a5,-24(a0)
    19f2:	0028871b          	addiw	a4,a7,2

  while (--i >= 0)
    19f6:	02e05563          	blez	a4,1a20 <printint+0x94>
    19fa:	fc26                	sd	s1,56(sp)
    19fc:	377d                	addiw	a4,a4,-1
    19fe:	00e984b3          	add	s1,s3,a4
    1a02:	19fd                	addi	s3,s3,-1
    1a04:	99ba                	add	s3,s3,a4
    1a06:	1702                	slli	a4,a4,0x20
    1a08:	9301                	srli	a4,a4,0x20
    1a0a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    1a0e:	0004c583          	lbu	a1,0(s1)
    1a12:	854a                	mv	a0,s2
    1a14:	f5bff0ef          	jal	196e <putc>
  while (--i >= 0)
    1a18:	14fd                	addi	s1,s1,-1
    1a1a:	ff349ae3          	bne	s1,s3,1a0e <printint+0x82>
    1a1e:	74e2                	ld	s1,56(sp)
}
    1a20:	60a6                	ld	ra,72(sp)
    1a22:	6406                	ld	s0,64(sp)
    1a24:	7942                	ld	s2,48(sp)
    1a26:	79a2                	ld	s3,40(sp)
    1a28:	6161                	addi	sp,sp,80
    1a2a:	8082                	ret

0000000000001a2c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1a2c:	711d                	addi	sp,sp,-96
    1a2e:	ec86                	sd	ra,88(sp)
    1a30:	e8a2                	sd	s0,80(sp)
    1a32:	e4a6                	sd	s1,72(sp)
    1a34:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
    1a36:	0005c483          	lbu	s1,0(a1)
    1a3a:	2a048063          	beqz	s1,1cda <vprintf+0x2ae>
    1a3e:	e0ca                	sd	s2,64(sp)
    1a40:	fc4e                	sd	s3,56(sp)
    1a42:	f852                	sd	s4,48(sp)
    1a44:	f456                	sd	s5,40(sp)
    1a46:	f05a                	sd	s6,32(sp)
    1a48:	ec5e                	sd	s7,24(sp)
    1a4a:	e862                	sd	s8,16(sp)
    1a4c:	8b2a                	mv	s6,a0
    1a4e:	8a2e                	mv	s4,a1
    1a50:	8bb2                	mv	s7,a2
  state = 0;
    1a52:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
    1a54:	4901                	li	s2,0
    1a56:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
    1a58:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
    1a5c:	06400c13          	li	s8,100
    1a60:	a00d                	j	1a82 <vprintf+0x56>
        putc(fd, c0);
    1a62:	85a6                	mv	a1,s1
    1a64:	855a                	mv	a0,s6
    1a66:	f09ff0ef          	jal	196e <putc>
    1a6a:	a019                	j	1a70 <vprintf+0x44>
    } else if (state == '%') {
    1a6c:	03598363          	beq	s3,s5,1a92 <vprintf+0x66>
  for (i = 0; fmt[i]; i++) {
    1a70:	0019079b          	addiw	a5,s2,1
    1a74:	893e                	mv	s2,a5
    1a76:	873e                	mv	a4,a5
    1a78:	97d2                	add	a5,a5,s4
    1a7a:	0007c483          	lbu	s1,0(a5)
    1a7e:	24048763          	beqz	s1,1ccc <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
    1a82:	0004879b          	sext.w	a5,s1
    if (state == 0) {
    1a86:	fe0993e3          	bnez	s3,1a6c <vprintf+0x40>
      if (c0 == '%') {
    1a8a:	fd579ce3          	bne	a5,s5,1a62 <vprintf+0x36>
        state = '%';
    1a8e:	89be                	mv	s3,a5
    1a90:	b7c5                	j	1a70 <vprintf+0x44>
        c1 = fmt[i + 1] & 0xff;
    1a92:	00ea06b3          	add	a3,s4,a4
    1a96:	0016c603          	lbu	a2,1(a3)
      if (c1)
    1a9a:	24060563          	beqz	a2,1ce4 <vprintf+0x2b8>
      if (c0 == 'd') {
    1a9e:	0b878763          	beq	a5,s8,1b4c <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
    1aa2:	f9478693          	addi	a3,a5,-108
    1aa6:	0016b693          	seqz	a3,a3
    1aaa:	f9c60593          	addi	a1,a2,-100
    1aae:	0015b593          	seqz	a1,a1
    1ab2:	8df5                	and	a1,a1,a3
    1ab4:	e9c5                	bnez	a1,1b64 <vprintf+0x138>
        c2 = fmt[i + 2] & 0xff;
    1ab6:	9752                	add	a4,a4,s4
    1ab8:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
    1abc:	f9460713          	addi	a4,a2,-108
    1ac0:	00173713          	seqz	a4,a4
    1ac4:	8f75                	and	a4,a4,a3
    1ac6:	f9c50593          	addi	a1,a0,-100
    1aca:	0015b593          	seqz	a1,a1
    1ace:	8df9                	and	a1,a1,a4
    1ad0:	e5dd                	bnez	a1,1b7e <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
    1ad2:	07500593          	li	a1,117
    1ad6:	0cb78163          	beq	a5,a1,1b98 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if (c0 == 'l' && c1 == 'u') {
    1ada:	f8b60593          	addi	a1,a2,-117
    1ade:	0015b593          	seqz	a1,a1
    1ae2:	8df5                	and	a1,a1,a3
    1ae4:	e5f1                	bnez	a1,1bb0 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
    1ae6:	f8b50593          	addi	a1,a0,-117
    1aea:	0015b593          	seqz	a1,a1
    1aee:	8df9                	and	a1,a1,a4
    1af0:	ede9                	bnez	a1,1bca <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
    1af2:	07800593          	li	a1,120
    1af6:	0eb78763          	beq	a5,a1,1be4 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if (c0 == 'l' && c1 == 'x') {
    1afa:	f8860613          	addi	a2,a2,-120
    1afe:	00163613          	seqz	a2,a2
    1b02:	8ef1                	and	a3,a3,a2
    1b04:	0e069c63          	bnez	a3,1bfc <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
    1b08:	f8850513          	addi	a0,a0,-120
    1b0c:	00153513          	seqz	a0,a0
    1b10:	8f69                	and	a4,a4,a0
    1b12:	10071263          	bnez	a4,1c16 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
    1b16:	07000713          	li	a4,112
    1b1a:	10e78a63          	beq	a5,a4,1c2e <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
    1b1e:	06300713          	li	a4,99
    1b22:	14e78a63          	beq	a5,a4,1c76 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
    1b26:	07300713          	li	a4,115
    1b2a:	16e78063          	beq	a5,a4,1c8a <vprintf+0x25e>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
    1b2e:	02500713          	li	a4,37
    1b32:	18e78863          	beq	a5,a4,1cc2 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1b36:	02500593          	li	a1,37
    1b3a:	855a                	mv	a0,s6
    1b3c:	e33ff0ef          	jal	196e <putc>
        putc(fd, c0);
    1b40:	85a6                	mv	a1,s1
    1b42:	855a                	mv	a0,s6
    1b44:	e2bff0ef          	jal	196e <putc>
      }

      state = 0;
    1b48:	4981                	li	s3,0
    1b4a:	b71d                	j	1a70 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
    1b4c:	008b8493          	addi	s1,s7,8
    1b50:	4685                	li	a3,1
    1b52:	4629                	li	a2,10
    1b54:	000ba583          	lw	a1,0(s7)
    1b58:	855a                	mv	a0,s6
    1b5a:	e33ff0ef          	jal	198c <printint>
    1b5e:	8ba6                	mv	s7,s1
      state = 0;
    1b60:	4981                	li	s3,0
    1b62:	b739                	j	1a70 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
    1b64:	008b8493          	addi	s1,s7,8
    1b68:	4685                	li	a3,1
    1b6a:	4629                	li	a2,10
    1b6c:	000bb583          	ld	a1,0(s7)
    1b70:	855a                	mv	a0,s6
    1b72:	e1bff0ef          	jal	198c <printint>
        i += 1;
    1b76:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    1b78:	8ba6                	mv	s7,s1
      state = 0;
    1b7a:	4981                	li	s3,0
    1b7c:	bdd5                	j	1a70 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
    1b7e:	008b8493          	addi	s1,s7,8
    1b82:	4685                	li	a3,1
    1b84:	4629                	li	a2,10
    1b86:	000bb583          	ld	a1,0(s7)
    1b8a:	855a                	mv	a0,s6
    1b8c:	e01ff0ef          	jal	198c <printint>
        i += 2;
    1b90:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    1b92:	8ba6                	mv	s7,s1
      state = 0;
    1b94:	4981                	li	s3,0
        i += 2;
    1b96:	bde9                	j	1a70 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
    1b98:	008b8493          	addi	s1,s7,8
    1b9c:	4681                	li	a3,0
    1b9e:	4629                	li	a2,10
    1ba0:	000be583          	lwu	a1,0(s7)
    1ba4:	855a                	mv	a0,s6
    1ba6:	de7ff0ef          	jal	198c <printint>
    1baa:	8ba6                	mv	s7,s1
      state = 0;
    1bac:	4981                	li	s3,0
    1bae:	b5c9                	j	1a70 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1bb0:	008b8493          	addi	s1,s7,8
    1bb4:	4681                	li	a3,0
    1bb6:	4629                	li	a2,10
    1bb8:	000bb583          	ld	a1,0(s7)
    1bbc:	855a                	mv	a0,s6
    1bbe:	dcfff0ef          	jal	198c <printint>
        i += 1;
    1bc2:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    1bc4:	8ba6                	mv	s7,s1
      state = 0;
    1bc6:	4981                	li	s3,0
    1bc8:	b565                	j	1a70 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1bca:	008b8493          	addi	s1,s7,8
    1bce:	4681                	li	a3,0
    1bd0:	4629                	li	a2,10
    1bd2:	000bb583          	ld	a1,0(s7)
    1bd6:	855a                	mv	a0,s6
    1bd8:	db5ff0ef          	jal	198c <printint>
        i += 2;
    1bdc:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    1bde:	8ba6                	mv	s7,s1
      state = 0;
    1be0:	4981                	li	s3,0
        i += 2;
    1be2:	b579                	j	1a70 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
    1be4:	008b8493          	addi	s1,s7,8
    1be8:	4681                	li	a3,0
    1bea:	4641                	li	a2,16
    1bec:	000be583          	lwu	a1,0(s7)
    1bf0:	855a                	mv	a0,s6
    1bf2:	d9bff0ef          	jal	198c <printint>
    1bf6:	8ba6                	mv	s7,s1
      state = 0;
    1bf8:	4981                	li	s3,0
    1bfa:	bd9d                	j	1a70 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
    1bfc:	008b8493          	addi	s1,s7,8
    1c00:	4681                	li	a3,0
    1c02:	4641                	li	a2,16
    1c04:	000bb583          	ld	a1,0(s7)
    1c08:	855a                	mv	a0,s6
    1c0a:	d83ff0ef          	jal	198c <printint>
        i += 1;
    1c0e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    1c10:	8ba6                	mv	s7,s1
      state = 0;
    1c12:	4981                	li	s3,0
    1c14:	bdb1                	j	1a70 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
    1c16:	008b8493          	addi	s1,s7,8
    1c1a:	4641                	li	a2,16
    1c1c:	000bb583          	ld	a1,0(s7)
    1c20:	855a                	mv	a0,s6
    1c22:	d6bff0ef          	jal	198c <printint>
        i += 2;
    1c26:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    1c28:	8ba6                	mv	s7,s1
      state = 0;
    1c2a:	4981                	li	s3,0
        i += 2;
    1c2c:	b591                	j	1a70 <vprintf+0x44>
    1c2e:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
    1c30:	008b8793          	addi	a5,s7,8
    1c34:	8cbe                	mv	s9,a5
    1c36:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    1c3a:	03000593          	li	a1,48
    1c3e:	855a                	mv	a0,s6
    1c40:	d2fff0ef          	jal	196e <putc>
  putc(fd, 'x');
    1c44:	07800593          	li	a1,120
    1c48:	855a                	mv	a0,s6
    1c4a:	d25ff0ef          	jal	196e <putc>
    1c4e:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1c50:	00001b97          	auipc	s7,0x1
    1c54:	f50b8b93          	addi	s7,s7,-176 # 2ba0 <digits>
    1c58:	03c9d793          	srli	a5,s3,0x3c
    1c5c:	97de                	add	a5,a5,s7
    1c5e:	0007c583          	lbu	a1,0(a5)
    1c62:	855a                	mv	a0,s6
    1c64:	d0bff0ef          	jal	196e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1c68:	0992                	slli	s3,s3,0x4
    1c6a:	34fd                	addiw	s1,s1,-1
    1c6c:	f4f5                	bnez	s1,1c58 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
    1c6e:	8be6                	mv	s7,s9
      state = 0;
    1c70:	4981                	li	s3,0
    1c72:	6ca2                	ld	s9,8(sp)
    1c74:	bbf5                	j	1a70 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
    1c76:	008b8493          	addi	s1,s7,8
    1c7a:	000bc583          	lbu	a1,0(s7)
    1c7e:	855a                	mv	a0,s6
    1c80:	cefff0ef          	jal	196e <putc>
    1c84:	8ba6                	mv	s7,s1
      state = 0;
    1c86:	4981                	li	s3,0
    1c88:	b3e5                	j	1a70 <vprintf+0x44>
        if ((s = va_arg(ap, char *)) == 0)
    1c8a:	008b8993          	addi	s3,s7,8
    1c8e:	000bb483          	ld	s1,0(s7)
    1c92:	cc91                	beqz	s1,1cae <vprintf+0x282>
        for (; *s; s++)
    1c94:	0004c583          	lbu	a1,0(s1)
    1c98:	c195                	beqz	a1,1cbc <vprintf+0x290>
          putc(fd, *s);
    1c9a:	855a                	mv	a0,s6
    1c9c:	cd3ff0ef          	jal	196e <putc>
        for (; *s; s++)
    1ca0:	0485                	addi	s1,s1,1
    1ca2:	0004c583          	lbu	a1,0(s1)
    1ca6:	f9f5                	bnez	a1,1c9a <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
    1ca8:	8bce                	mv	s7,s3
      state = 0;
    1caa:	4981                	li	s3,0
    1cac:	b3d1                	j	1a70 <vprintf+0x44>
          s = "(null)";
    1cae:	00001497          	auipc	s1,0x1
    1cb2:	e3a48493          	addi	s1,s1,-454 # 2ae8 <malloc+0xd08>
        for (; *s; s++)
    1cb6:	02800593          	li	a1,40
    1cba:	b7c5                	j	1c9a <vprintf+0x26e>
        if ((s = va_arg(ap, char *)) == 0)
    1cbc:	8bce                	mv	s7,s3
      state = 0;
    1cbe:	4981                	li	s3,0
    1cc0:	bb45                	j	1a70 <vprintf+0x44>
        putc(fd, '%');
    1cc2:	85be                	mv	a1,a5
    1cc4:	855a                	mv	a0,s6
    1cc6:	ca9ff0ef          	jal	196e <putc>
    1cca:	bdbd                	j	1b48 <vprintf+0x11c>
    1ccc:	6906                	ld	s2,64(sp)
    1cce:	79e2                	ld	s3,56(sp)
    1cd0:	7a42                	ld	s4,48(sp)
    1cd2:	7aa2                	ld	s5,40(sp)
    1cd4:	7b02                	ld	s6,32(sp)
    1cd6:	6be2                	ld	s7,24(sp)
    1cd8:	6c42                	ld	s8,16(sp)
    }
  }
}
    1cda:	60e6                	ld	ra,88(sp)
    1cdc:	6446                	ld	s0,80(sp)
    1cde:	64a6                	ld	s1,72(sp)
    1ce0:	6125                	addi	sp,sp,96
    1ce2:	8082                	ret
      if (c0 == 'd') {
    1ce4:	06400713          	li	a4,100
    1ce8:	e6e782e3          	beq	a5,a4,1b4c <vprintf+0x120>
      } else if (c0 == 'l' && c1 == 'd') {
    1cec:	f9478693          	addi	a3,a5,-108
    1cf0:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
    1cf4:	8532                	mv	a0,a2
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
    1cf6:	4701                	li	a4,0
    1cf8:	bbe9                	j	1ad2 <vprintf+0xa6>

0000000000001cfa <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1cfa:	715d                	addi	sp,sp,-80
    1cfc:	ec06                	sd	ra,24(sp)
    1cfe:	e822                	sd	s0,16(sp)
    1d00:	1000                	addi	s0,sp,32
    1d02:	e010                	sd	a2,0(s0)
    1d04:	e414                	sd	a3,8(s0)
    1d06:	e818                	sd	a4,16(s0)
    1d08:	ec1c                	sd	a5,24(s0)
    1d0a:	03043023          	sd	a6,32(s0)
    1d0e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1d12:	8622                	mv	a2,s0
    1d14:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1d18:	d15ff0ef          	jal	1a2c <vprintf>
}
    1d1c:	60e2                	ld	ra,24(sp)
    1d1e:	6442                	ld	s0,16(sp)
    1d20:	6161                	addi	sp,sp,80
    1d22:	8082                	ret

0000000000001d24 <printf>:

void
printf(const char *fmt, ...)
{
    1d24:	711d                	addi	sp,sp,-96
    1d26:	ec06                	sd	ra,24(sp)
    1d28:	e822                	sd	s0,16(sp)
    1d2a:	1000                	addi	s0,sp,32
    1d2c:	e40c                	sd	a1,8(s0)
    1d2e:	e810                	sd	a2,16(s0)
    1d30:	ec14                	sd	a3,24(s0)
    1d32:	f018                	sd	a4,32(s0)
    1d34:	f41c                	sd	a5,40(s0)
    1d36:	03043823          	sd	a6,48(s0)
    1d3a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1d3e:	00840613          	addi	a2,s0,8
    1d42:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1d46:	85aa                	mv	a1,a0
    1d48:	4505                	li	a0,1
    1d4a:	ce3ff0ef          	jal	1a2c <vprintf>
}
    1d4e:	60e2                	ld	ra,24(sp)
    1d50:	6442                	ld	s0,16(sp)
    1d52:	6125                	addi	sp,sp,96
    1d54:	8082                	ret

0000000000001d56 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1d56:	1141                	addi	sp,sp,-16
    1d58:	e406                	sd	ra,8(sp)
    1d5a:	e022                	sd	s0,0(sp)
    1d5c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
    1d5e:	ff050713          	addi	a4,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1d62:	00001797          	auipc	a5,0x1
    1d66:	29e7b783          	ld	a5,670(a5) # 3000 <freep>
    1d6a:	a095                	j	1dce <free+0x78>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
    1d6c:	ff852583          	lw	a1,-8(a0)
    1d70:	6390                	ld	a2,0(a5)
    1d72:	02059813          	slli	a6,a1,0x20
    1d76:	01c85693          	srli	a3,a6,0x1c
    1d7a:	96ba                	add	a3,a3,a4
    1d7c:	02d60563          	beq	a2,a3,1da6 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    1d80:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
    1d84:	4790                	lw	a2,8(a5)
    1d86:	02061593          	slli	a1,a2,0x20
    1d8a:	01c5d693          	srli	a3,a1,0x1c
    1d8e:	96be                	add	a3,a3,a5
    1d90:	02d70263          	beq	a4,a3,1db4 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    1d94:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1d96:	00001717          	auipc	a4,0x1
    1d9a:	26f73523          	sd	a5,618(a4) # 3000 <freep>
}
    1d9e:	60a2                	ld	ra,8(sp)
    1da0:	6402                	ld	s0,0(sp)
    1da2:	0141                	addi	sp,sp,16
    1da4:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
    1da6:	4614                	lw	a3,8(a2)
    1da8:	9ead                	addw	a3,a3,a1
    1daa:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1dae:	6394                	ld	a3,0(a5)
    1db0:	6290                	ld	a2,0(a3)
    1db2:	b7f9                	j	1d80 <free+0x2a>
    p->s.size += bp->s.size;
    1db4:	ff852703          	lw	a4,-8(a0)
    1db8:	9f31                	addw	a4,a4,a2
    1dba:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1dbc:	ff053703          	ld	a4,-16(a0)
    1dc0:	bfd1                	j	1d94 <free+0x3e>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1dc2:	6394                	ld	a3,0(a5)
    1dc4:	00d7e463          	bltu	a5,a3,1dcc <free+0x76>
    1dc8:	fad762e3          	bltu	a4,a3,1d6c <free+0x16>
    1dcc:	87b6                	mv	a5,a3
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1dce:	fee7fae3          	bgeu	a5,a4,1dc2 <free+0x6c>
    1dd2:	6394                	ld	a3,0(a5)
    1dd4:	f8d76ce3          	bltu	a4,a3,1d6c <free+0x16>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1dd8:	f8d7fae3          	bgeu	a5,a3,1d6c <free+0x16>
    1ddc:	87b6                	mv	a5,a3
    1dde:	bfc5                	j	1dce <free+0x78>

0000000000001de0 <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
    1de0:	7139                	addi	sp,sp,-64
    1de2:	fc06                	sd	ra,56(sp)
    1de4:	f822                	sd	s0,48(sp)
    1de6:	f04a                	sd	s2,32(sp)
    1de8:	ec4e                	sd	s3,24(sp)
    1dea:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    1dec:	02051993          	slli	s3,a0,0x20
    1df0:	0209d993          	srli	s3,s3,0x20
    1df4:	09bd                	addi	s3,s3,15
    1df6:	0049d993          	srli	s3,s3,0x4
    1dfa:	2985                	addiw	s3,s3,1
    1dfc:	894e                	mv	s2,s3
  if ((prevp = freep) == 0) {
    1dfe:	00001517          	auipc	a0,0x1
    1e02:	20253503          	ld	a0,514(a0) # 3000 <freep>
    1e06:	c905                	beqz	a0,1e36 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    1e08:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
    1e0a:	4798                	lw	a4,8(a5)
    1e0c:	09377663          	bgeu	a4,s3,1e98 <malloc+0xb8>
    1e10:	f426                	sd	s1,40(sp)
    1e12:	e852                	sd	s4,16(sp)
    1e14:	e456                	sd	s5,8(sp)
    1e16:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
    1e18:	8a4e                	mv	s4,s3
    1e1a:	6705                	lui	a4,0x1
    1e1c:	00e9f363          	bgeu	s3,a4,1e22 <malloc+0x42>
    1e20:	6a05                	lui	s4,0x1
    1e22:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1e26:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
    1e2a:	00001497          	auipc	s1,0x1
    1e2e:	1d648493          	addi	s1,s1,470 # 3000 <freep>
  if (p == SBRK_ERROR)
    1e32:	5afd                	li	s5,-1
    1e34:	a83d                	j	1e72 <malloc+0x92>
    1e36:	f426                	sd	s1,40(sp)
    1e38:	e852                	sd	s4,16(sp)
    1e3a:	e456                	sd	s5,8(sp)
    1e3c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    1e3e:	00003797          	auipc	a5,0x3
    1e42:	1d278793          	addi	a5,a5,466 # 5010 <base>
    1e46:	00001717          	auipc	a4,0x1
    1e4a:	1af73d23          	sd	a5,442(a4) # 3000 <freep>
    1e4e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1e50:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
    1e54:	b7d1                	j	1e18 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    1e56:	6398                	ld	a4,0(a5)
    1e58:	e118                	sd	a4,0(a0)
    1e5a:	a899                	j	1eb0 <malloc+0xd0>
  hp->s.size = nu;
    1e5c:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
    1e60:	0541                	addi	a0,a0,16
    1e62:	ef5ff0ef          	jal	1d56 <free>
  return freep;
    1e66:	6088                	ld	a0,0(s1)
      if ((p = morecore(nunits)) == 0)
    1e68:	c125                	beqz	a0,1ec8 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    1e6a:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
    1e6c:	4798                	lw	a4,8(a5)
    1e6e:	03277163          	bgeu	a4,s2,1e90 <malloc+0xb0>
    if (p == freep)
    1e72:	6098                	ld	a4,0(s1)
    1e74:	853e                	mv	a0,a5
    1e76:	fef71ae3          	bne	a4,a5,1e6a <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
    1e7a:	8552                	mv	a0,s4
    1e7c:	9ffff0ef          	jal	187a <sbrk>
  if (p == SBRK_ERROR)
    1e80:	fd551ee3          	bne	a0,s5,1e5c <malloc+0x7c>
        return 0;
    1e84:	4501                	li	a0,0
    1e86:	74a2                	ld	s1,40(sp)
    1e88:	6a42                	ld	s4,16(sp)
    1e8a:	6aa2                	ld	s5,8(sp)
    1e8c:	6b02                	ld	s6,0(sp)
    1e8e:	a03d                	j	1ebc <malloc+0xdc>
    1e90:	74a2                	ld	s1,40(sp)
    1e92:	6a42                	ld	s4,16(sp)
    1e94:	6aa2                	ld	s5,8(sp)
    1e96:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
    1e98:	fae90fe3          	beq	s2,a4,1e56 <malloc+0x76>
        p->s.size -= nunits;
    1e9c:	4137073b          	subw	a4,a4,s3
    1ea0:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1ea2:	02071693          	slli	a3,a4,0x20
    1ea6:	01c6d713          	srli	a4,a3,0x1c
    1eaa:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1eac:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    1eb0:	00001717          	auipc	a4,0x1
    1eb4:	14a73823          	sd	a0,336(a4) # 3000 <freep>
      return (void *)(p + 1);
    1eb8:	01078513          	addi	a0,a5,16
  }
}
    1ebc:	70e2                	ld	ra,56(sp)
    1ebe:	7442                	ld	s0,48(sp)
    1ec0:	7902                	ld	s2,32(sp)
    1ec2:	69e2                	ld	s3,24(sp)
    1ec4:	6121                	addi	sp,sp,64
    1ec6:	8082                	ret
    1ec8:	74a2                	ld	s1,40(sp)
    1eca:	6a42                	ld	s4,16(sp)
    1ecc:	6aa2                	ld	s5,8(sp)
    1ece:	6b02                	ld	s6,0(sp)
    1ed0:	b7f5                	j	1ebc <malloc+0xdc>
