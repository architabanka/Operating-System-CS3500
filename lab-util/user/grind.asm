
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       8:	611c                	ld	a5,0(a0)
       a:	0017d693          	srli	a3,a5,0x1
       e:	c0000737          	lui	a4,0xc0000
      12:	0705                	addi	a4,a4,1 # ffffffffc0000001 <base+0xffffffffbfffdbf9>
      14:	1706                	slli	a4,a4,0x21
      16:	0725                	addi	a4,a4,9
      18:	02e6b733          	mulhu	a4,a3,a4
      1c:	8375                	srli	a4,a4,0x1d
      1e:	01e71693          	slli	a3,a4,0x1e
      22:	40e68733          	sub	a4,a3,a4
      26:	0706                	slli	a4,a4,0x1
      28:	8f99                	sub	a5,a5,a4
      2a:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      2c:	1fe406b7          	lui	a3,0x1fe40
      30:	b7968693          	addi	a3,a3,-1159 # 1fe3fb79 <base+0x1fe3d771>
      34:	41a70737          	lui	a4,0x41a70
      38:	5af70713          	addi	a4,a4,1455 # 41a705af <base+0x41a6e1a7>
      3c:	1702                	slli	a4,a4,0x20
      3e:	9736                	add	a4,a4,a3
      40:	02e79733          	mulh	a4,a5,a4
      44:	873d                	srai	a4,a4,0xf
      46:	43f7d693          	srai	a3,a5,0x3f
      4a:	8f15                	sub	a4,a4,a3
      4c:	66fd                	lui	a3,0x1f
      4e:	31d68693          	addi	a3,a3,797 # 1f31d <base+0x1cf15>
      52:	02d706b3          	mul	a3,a4,a3
      56:	8f95                	sub	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      58:	6691                	lui	a3,0x4
      5a:	1a768693          	addi	a3,a3,423 # 41a7 <base+0x1d9f>
      5e:	02d787b3          	mul	a5,a5,a3
      62:	76fd                	lui	a3,0xfffff
      64:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
      68:	02d70733          	mul	a4,a4,a3
      6c:	97ba                	add	a5,a5,a4
    if (x < 0)
      6e:	0007ca63          	bltz	a5,82 <do_rand+0x82>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      72:	17fd                	addi	a5,a5,-1
    *ctx = x;
      74:	e11c                	sd	a5,0(a0)
    return (x);
}
      76:	0007851b          	sext.w	a0,a5
      7a:	60a2                	ld	ra,8(sp)
      7c:	6402                	ld	s0,0(sp)
      7e:	0141                	addi	sp,sp,16
      80:	8082                	ret
        x += 0x7fffffff;
      82:	80000737          	lui	a4,0x80000
      86:	fff74713          	not	a4,a4
      8a:	97ba                	add	a5,a5,a4
      8c:	b7dd                	j	72 <do_rand+0x72>

000000000000008e <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      8e:	1141                	addi	sp,sp,-16
      90:	e406                	sd	ra,8(sp)
      92:	e022                	sd	s0,0(sp)
      94:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      96:	00002517          	auipc	a0,0x2
      9a:	f6a50513          	addi	a0,a0,-150 # 2000 <rand_next>
      9e:	f63ff0ef          	jal	0 <do_rand>
}
      a2:	60a2                	ld	ra,8(sp)
      a4:	6402                	ld	s0,0(sp)
      a6:	0141                	addi	sp,sp,16
      a8:	8082                	ret

00000000000000aa <go>:

void
go(int which_child)
{
      aa:	7171                	addi	sp,sp,-176
      ac:	f506                	sd	ra,168(sp)
      ae:	f122                	sd	s0,160(sp)
      b0:	ed26                	sd	s1,152(sp)
      b2:	1900                	addi	s0,sp,176
      b4:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      b6:	4501                	li	a0,0
      b8:	349000ef          	jal	c00 <sbrk>
      bc:	f4a43c23          	sd	a0,-168(s0)
  uint64 iters = 0;

  mkdir("grindir");
      c0:	00001517          	auipc	a0,0x1
      c4:	18050513          	addi	a0,a0,384 # 1240 <malloc+0xf2>
      c8:	3d5000ef          	jal	c9c <mkdir>
  if(chdir("grindir") != 0){
      cc:	00001517          	auipc	a0,0x1
      d0:	17450513          	addi	a0,a0,372 # 1240 <malloc+0xf2>
      d4:	3d1000ef          	jal	ca4 <chdir>
      d8:	c505                	beqz	a0,100 <go+0x56>
      da:	e94a                	sd	s2,144(sp)
      dc:	e54e                	sd	s3,136(sp)
      de:	e152                	sd	s4,128(sp)
      e0:	fcd6                	sd	s5,120(sp)
      e2:	f8da                	sd	s6,112(sp)
      e4:	f4de                	sd	s7,104(sp)
      e6:	f0e2                	sd	s8,96(sp)
      e8:	ece6                	sd	s9,88(sp)
      ea:	e8ea                	sd	s10,80(sp)
      ec:	e4ee                	sd	s11,72(sp)
    printf("grind: chdir grindir failed\n");
      ee:	00001517          	auipc	a0,0x1
      f2:	15a50513          	addi	a0,a0,346 # 1248 <malloc+0xfa>
      f6:	79d000ef          	jal	1092 <printf>
    exit(1);
      fa:	4505                	li	a0,1
      fc:	339000ef          	jal	c34 <exit>
     100:	e94a                	sd	s2,144(sp)
     102:	e54e                	sd	s3,136(sp)
     104:	e152                	sd	s4,128(sp)
     106:	fcd6                	sd	s5,120(sp)
     108:	f8da                	sd	s6,112(sp)
     10a:	f4de                	sd	s7,104(sp)
     10c:	f0e2                	sd	s8,96(sp)
     10e:	ece6                	sd	s9,88(sp)
     110:	e8ea                	sd	s10,80(sp)
     112:	e4ee                	sd	s11,72(sp)
  }
  chdir("/");
     114:	00001517          	auipc	a0,0x1
     118:	15c50513          	addi	a0,a0,348 # 1270 <malloc+0x122>
     11c:	389000ef          	jal	ca4 <chdir>
     120:	00001c17          	auipc	s8,0x1
     124:	160c0c13          	addi	s8,s8,352 # 1280 <malloc+0x132>
     128:	c489                	beqz	s1,132 <go+0x88>
     12a:	00001c17          	auipc	s8,0x1
     12e:	14ec0c13          	addi	s8,s8,334 # 1278 <malloc+0x12a>
  uint64 iters = 0;
     132:	4481                	li	s1,0
  int fd = -1;
     134:	5cfd                	li	s9,-1
  
  while(1){
    iters++;
    if((iters % 500) == 0)
     136:	106259b7          	lui	s3,0x10625
     13a:	dd398993          	addi	s3,s3,-557 # 10624dd3 <base+0x106229cb>
     13e:	09be                	slli	s3,s3,0xf
     140:	8d598993          	addi	s3,s3,-1835
     144:	09ca                	slli	s3,s3,0x12
     146:	80098993          	addi	s3,s3,-2048
     14a:	fcf98993          	addi	s3,s3,-49
     14e:	1f400b93          	li	s7,500
      write(1, which_child?"B":"A", 1);
     152:	4a05                	li	s4,1
    int what = rand() % 23;
     154:	b2164ab7          	lui	s5,0xb2164
     158:	2c9a8a93          	addi	s5,s5,713 # ffffffffb21642c9 <base+0xffffffffb2161ec1>
     15c:	4b59                	li	s6,22
     15e:	00001917          	auipc	s2,0x1
     162:	3f290913          	addi	s2,s2,1010 # 1550 <malloc+0x402>
      close(fd1);
      unlink("c");
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     166:	f6840d93          	addi	s11,s0,-152
     16a:	a819                	j	180 <go+0xd6>
      close(open("grindir/../a", O_CREATE|O_RDWR));
     16c:	20200593          	li	a1,514
     170:	00001517          	auipc	a0,0x1
     174:	11850513          	addi	a0,a0,280 # 1288 <malloc+0x13a>
     178:	2fd000ef          	jal	c74 <open>
     17c:	2e1000ef          	jal	c5c <close>
    iters++;
     180:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
     182:	0024d793          	srli	a5,s1,0x2
     186:	0337b7b3          	mulhu	a5,a5,s3
     18a:	8391                	srli	a5,a5,0x4
     18c:	037787b3          	mul	a5,a5,s7
     190:	00f49763          	bne	s1,a5,19e <go+0xf4>
      write(1, which_child?"B":"A", 1);
     194:	8652                	mv	a2,s4
     196:	85e2                	mv	a1,s8
     198:	8552                	mv	a0,s4
     19a:	2bb000ef          	jal	c54 <write>
    int what = rand() % 23;
     19e:	ef1ff0ef          	jal	8e <rand>
     1a2:	035507b3          	mul	a5,a0,s5
     1a6:	9381                	srli	a5,a5,0x20
     1a8:	9fa9                	addw	a5,a5,a0
     1aa:	4047d79b          	sraiw	a5,a5,0x4
     1ae:	41f5571b          	sraiw	a4,a0,0x1f
     1b2:	9f99                	subw	a5,a5,a4
     1b4:	0017971b          	slliw	a4,a5,0x1
     1b8:	9f3d                	addw	a4,a4,a5
     1ba:	0037171b          	slliw	a4,a4,0x3
     1be:	40f707bb          	subw	a5,a4,a5
     1c2:	9d1d                	subw	a0,a0,a5
     1c4:	faab6ee3          	bltu	s6,a0,180 <go+0xd6>
     1c8:	02051793          	slli	a5,a0,0x20
     1cc:	01e7d513          	srli	a0,a5,0x1e
     1d0:	954a                	add	a0,a0,s2
     1d2:	411c                	lw	a5,0(a0)
     1d4:	97ca                	add	a5,a5,s2
     1d6:	8782                	jr	a5
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     1d8:	20200593          	li	a1,514
     1dc:	00001517          	auipc	a0,0x1
     1e0:	0bc50513          	addi	a0,a0,188 # 1298 <malloc+0x14a>
     1e4:	291000ef          	jal	c74 <open>
     1e8:	275000ef          	jal	c5c <close>
     1ec:	bf51                	j	180 <go+0xd6>
      unlink("grindir/../a");
     1ee:	00001517          	auipc	a0,0x1
     1f2:	09a50513          	addi	a0,a0,154 # 1288 <malloc+0x13a>
     1f6:	28f000ef          	jal	c84 <unlink>
     1fa:	b759                	j	180 <go+0xd6>
      if(chdir("grindir") != 0){
     1fc:	00001517          	auipc	a0,0x1
     200:	04450513          	addi	a0,a0,68 # 1240 <malloc+0xf2>
     204:	2a1000ef          	jal	ca4 <chdir>
     208:	ed11                	bnez	a0,224 <go+0x17a>
      unlink("../b");
     20a:	00001517          	auipc	a0,0x1
     20e:	0a650513          	addi	a0,a0,166 # 12b0 <malloc+0x162>
     212:	273000ef          	jal	c84 <unlink>
      chdir("/");
     216:	00001517          	auipc	a0,0x1
     21a:	05a50513          	addi	a0,a0,90 # 1270 <malloc+0x122>
     21e:	287000ef          	jal	ca4 <chdir>
     222:	bfb9                	j	180 <go+0xd6>
        printf("grind: chdir grindir failed\n");
     224:	00001517          	auipc	a0,0x1
     228:	02450513          	addi	a0,a0,36 # 1248 <malloc+0xfa>
     22c:	667000ef          	jal	1092 <printf>
        exit(1);
     230:	4505                	li	a0,1
     232:	203000ef          	jal	c34 <exit>
      close(fd);
     236:	8566                	mv	a0,s9
     238:	225000ef          	jal	c5c <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     23c:	20200593          	li	a1,514
     240:	00001517          	auipc	a0,0x1
     244:	07850513          	addi	a0,a0,120 # 12b8 <malloc+0x16a>
     248:	22d000ef          	jal	c74 <open>
     24c:	8caa                	mv	s9,a0
     24e:	bf0d                	j	180 <go+0xd6>
      close(fd);
     250:	8566                	mv	a0,s9
     252:	20b000ef          	jal	c5c <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     256:	20200593          	li	a1,514
     25a:	00001517          	auipc	a0,0x1
     25e:	06e50513          	addi	a0,a0,110 # 12c8 <malloc+0x17a>
     262:	213000ef          	jal	c74 <open>
     266:	8caa                	mv	s9,a0
     268:	bf21                	j	180 <go+0xd6>
      write(fd, buf, sizeof(buf));
     26a:	3e700613          	li	a2,999
     26e:	00002597          	auipc	a1,0x2
     272:	db258593          	addi	a1,a1,-590 # 2020 <buf.0>
     276:	8566                	mv	a0,s9
     278:	1dd000ef          	jal	c54 <write>
     27c:	b711                	j	180 <go+0xd6>
      read(fd, buf, sizeof(buf));
     27e:	3e700613          	li	a2,999
     282:	00002597          	auipc	a1,0x2
     286:	d9e58593          	addi	a1,a1,-610 # 2020 <buf.0>
     28a:	8566                	mv	a0,s9
     28c:	1c1000ef          	jal	c4c <read>
     290:	bdc5                	j	180 <go+0xd6>
      mkdir("grindir/../a");
     292:	00001517          	auipc	a0,0x1
     296:	ff650513          	addi	a0,a0,-10 # 1288 <malloc+0x13a>
     29a:	203000ef          	jal	c9c <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     29e:	20200593          	li	a1,514
     2a2:	00001517          	auipc	a0,0x1
     2a6:	03e50513          	addi	a0,a0,62 # 12e0 <malloc+0x192>
     2aa:	1cb000ef          	jal	c74 <open>
     2ae:	1af000ef          	jal	c5c <close>
      unlink("a/a");
     2b2:	00001517          	auipc	a0,0x1
     2b6:	03e50513          	addi	a0,a0,62 # 12f0 <malloc+0x1a2>
     2ba:	1cb000ef          	jal	c84 <unlink>
     2be:	b5c9                	j	180 <go+0xd6>
      mkdir("/../b");
     2c0:	00001517          	auipc	a0,0x1
     2c4:	03850513          	addi	a0,a0,56 # 12f8 <malloc+0x1aa>
     2c8:	1d5000ef          	jal	c9c <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     2cc:	20200593          	li	a1,514
     2d0:	00001517          	auipc	a0,0x1
     2d4:	03050513          	addi	a0,a0,48 # 1300 <malloc+0x1b2>
     2d8:	19d000ef          	jal	c74 <open>
     2dc:	181000ef          	jal	c5c <close>
      unlink("b/b");
     2e0:	00001517          	auipc	a0,0x1
     2e4:	03050513          	addi	a0,a0,48 # 1310 <malloc+0x1c2>
     2e8:	19d000ef          	jal	c84 <unlink>
     2ec:	bd51                	j	180 <go+0xd6>
      unlink("b");
     2ee:	00001517          	auipc	a0,0x1
     2f2:	02a50513          	addi	a0,a0,42 # 1318 <malloc+0x1ca>
     2f6:	18f000ef          	jal	c84 <unlink>
      link("../grindir/./../a", "../b");
     2fa:	00001597          	auipc	a1,0x1
     2fe:	fb658593          	addi	a1,a1,-74 # 12b0 <malloc+0x162>
     302:	00001517          	auipc	a0,0x1
     306:	01e50513          	addi	a0,a0,30 # 1320 <malloc+0x1d2>
     30a:	18b000ef          	jal	c94 <link>
     30e:	bd8d                	j	180 <go+0xd6>
      unlink("../grindir/../a");
     310:	00001517          	auipc	a0,0x1
     314:	02850513          	addi	a0,a0,40 # 1338 <malloc+0x1ea>
     318:	16d000ef          	jal	c84 <unlink>
      link(".././b", "/grindir/../a");
     31c:	00001597          	auipc	a1,0x1
     320:	f9c58593          	addi	a1,a1,-100 # 12b8 <malloc+0x16a>
     324:	00001517          	auipc	a0,0x1
     328:	02450513          	addi	a0,a0,36 # 1348 <malloc+0x1fa>
     32c:	169000ef          	jal	c94 <link>
     330:	bd81                	j	180 <go+0xd6>
      int pid = fork();
     332:	0fb000ef          	jal	c2c <fork>
      if(pid == 0){
     336:	c519                	beqz	a0,344 <go+0x29a>
      } else if(pid < 0){
     338:	00054863          	bltz	a0,348 <go+0x29e>
      wait(0);
     33c:	4501                	li	a0,0
     33e:	0ff000ef          	jal	c3c <wait>
     342:	bd3d                	j	180 <go+0xd6>
        exit(0);
     344:	0f1000ef          	jal	c34 <exit>
        printf("grind: fork failed\n");
     348:	00001517          	auipc	a0,0x1
     34c:	00850513          	addi	a0,a0,8 # 1350 <malloc+0x202>
     350:	543000ef          	jal	1092 <printf>
        exit(1);
     354:	4505                	li	a0,1
     356:	0df000ef          	jal	c34 <exit>
      int pid = fork();
     35a:	0d3000ef          	jal	c2c <fork>
      if(pid == 0){
     35e:	c519                	beqz	a0,36c <go+0x2c2>
      } else if(pid < 0){
     360:	00054d63          	bltz	a0,37a <go+0x2d0>
      wait(0);
     364:	4501                	li	a0,0
     366:	0d7000ef          	jal	c3c <wait>
     36a:	bd19                	j	180 <go+0xd6>
        fork();
     36c:	0c1000ef          	jal	c2c <fork>
        fork();
     370:	0bd000ef          	jal	c2c <fork>
        exit(0);
     374:	4501                	li	a0,0
     376:	0bf000ef          	jal	c34 <exit>
        printf("grind: fork failed\n");
     37a:	00001517          	auipc	a0,0x1
     37e:	fd650513          	addi	a0,a0,-42 # 1350 <malloc+0x202>
     382:	511000ef          	jal	1092 <printf>
        exit(1);
     386:	4505                	li	a0,1
     388:	0ad000ef          	jal	c34 <exit>
      sbrk(6011);
     38c:	6505                	lui	a0,0x1
     38e:	77b50513          	addi	a0,a0,1915 # 177b <digits+0x1cb>
     392:	06f000ef          	jal	c00 <sbrk>
     396:	b3ed                	j	180 <go+0xd6>
      if(sbrk(0) > break0)
     398:	4501                	li	a0,0
     39a:	067000ef          	jal	c00 <sbrk>
     39e:	f5843783          	ld	a5,-168(s0)
     3a2:	dca7ffe3          	bgeu	a5,a0,180 <go+0xd6>
        sbrk(-(sbrk(0) - break0));
     3a6:	4501                	li	a0,0
     3a8:	059000ef          	jal	c00 <sbrk>
     3ac:	f5843783          	ld	a5,-168(s0)
     3b0:	40a7853b          	subw	a0,a5,a0
     3b4:	04d000ef          	jal	c00 <sbrk>
     3b8:	b3e1                	j	180 <go+0xd6>
      int pid = fork();
     3ba:	073000ef          	jal	c2c <fork>
     3be:	8d2a                	mv	s10,a0
      if(pid == 0){
     3c0:	c10d                	beqz	a0,3e2 <go+0x338>
      } else if(pid < 0){
     3c2:	02054d63          	bltz	a0,3fc <go+0x352>
      if(chdir("../grindir/..") != 0){
     3c6:	00001517          	auipc	a0,0x1
     3ca:	faa50513          	addi	a0,a0,-86 # 1370 <malloc+0x222>
     3ce:	0d7000ef          	jal	ca4 <chdir>
     3d2:	ed15                	bnez	a0,40e <go+0x364>
      kill(pid);
     3d4:	856a                	mv	a0,s10
     3d6:	08f000ef          	jal	c64 <kill>
      wait(0);
     3da:	4501                	li	a0,0
     3dc:	061000ef          	jal	c3c <wait>
     3e0:	b345                	j	180 <go+0xd6>
        close(open("a", O_CREATE|O_RDWR));
     3e2:	20200593          	li	a1,514
     3e6:	00001517          	auipc	a0,0x1
     3ea:	f8250513          	addi	a0,a0,-126 # 1368 <malloc+0x21a>
     3ee:	087000ef          	jal	c74 <open>
     3f2:	06b000ef          	jal	c5c <close>
        exit(0);
     3f6:	4501                	li	a0,0
     3f8:	03d000ef          	jal	c34 <exit>
        printf("grind: fork failed\n");
     3fc:	00001517          	auipc	a0,0x1
     400:	f5450513          	addi	a0,a0,-172 # 1350 <malloc+0x202>
     404:	48f000ef          	jal	1092 <printf>
        exit(1);
     408:	4505                	li	a0,1
     40a:	02b000ef          	jal	c34 <exit>
        printf("grind: chdir failed\n");
     40e:	00001517          	auipc	a0,0x1
     412:	f7250513          	addi	a0,a0,-142 # 1380 <malloc+0x232>
     416:	47d000ef          	jal	1092 <printf>
        exit(1);
     41a:	4505                	li	a0,1
     41c:	019000ef          	jal	c34 <exit>
      int pid = fork();
     420:	00d000ef          	jal	c2c <fork>
      if(pid == 0){
     424:	c519                	beqz	a0,432 <go+0x388>
      } else if(pid < 0){
     426:	00054d63          	bltz	a0,440 <go+0x396>
      wait(0);
     42a:	4501                	li	a0,0
     42c:	011000ef          	jal	c3c <wait>
     430:	bb81                	j	180 <go+0xd6>
        kill(getpid());
     432:	083000ef          	jal	cb4 <getpid>
     436:	02f000ef          	jal	c64 <kill>
        exit(0);
     43a:	4501                	li	a0,0
     43c:	7f8000ef          	jal	c34 <exit>
        printf("grind: fork failed\n");
     440:	00001517          	auipc	a0,0x1
     444:	f1050513          	addi	a0,a0,-240 # 1350 <malloc+0x202>
     448:	44b000ef          	jal	1092 <printf>
        exit(1);
     44c:	4505                	li	a0,1
     44e:	7e6000ef          	jal	c34 <exit>
      if(pipe(fds) < 0){
     452:	f7840513          	addi	a0,s0,-136
     456:	7ee000ef          	jal	c44 <pipe>
     45a:	02054363          	bltz	a0,480 <go+0x3d6>
      int pid = fork();
     45e:	7ce000ef          	jal	c2c <fork>
      if(pid == 0){
     462:	c905                	beqz	a0,492 <go+0x3e8>
      } else if(pid < 0){
     464:	08054263          	bltz	a0,4e8 <go+0x43e>
      close(fds[0]);
     468:	f7842503          	lw	a0,-136(s0)
     46c:	7f0000ef          	jal	c5c <close>
      close(fds[1]);
     470:	f7c42503          	lw	a0,-132(s0)
     474:	7e8000ef          	jal	c5c <close>
      wait(0);
     478:	4501                	li	a0,0
     47a:	7c2000ef          	jal	c3c <wait>
     47e:	b309                	j	180 <go+0xd6>
        printf("grind: pipe failed\n");
     480:	00001517          	auipc	a0,0x1
     484:	f1850513          	addi	a0,a0,-232 # 1398 <malloc+0x24a>
     488:	40b000ef          	jal	1092 <printf>
        exit(1);
     48c:	4505                	li	a0,1
     48e:	7a6000ef          	jal	c34 <exit>
        fork();
     492:	79a000ef          	jal	c2c <fork>
        fork();
     496:	796000ef          	jal	c2c <fork>
        if(write(fds[1], "x", 1) != 1)
     49a:	4605                	li	a2,1
     49c:	00001597          	auipc	a1,0x1
     4a0:	f1458593          	addi	a1,a1,-236 # 13b0 <malloc+0x262>
     4a4:	f7c42503          	lw	a0,-132(s0)
     4a8:	7ac000ef          	jal	c54 <write>
     4ac:	4785                	li	a5,1
     4ae:	00f51f63          	bne	a0,a5,4cc <go+0x422>
        if(read(fds[0], &c, 1) != 1)
     4b2:	4605                	li	a2,1
     4b4:	f7040593          	addi	a1,s0,-144
     4b8:	f7842503          	lw	a0,-136(s0)
     4bc:	790000ef          	jal	c4c <read>
     4c0:	4785                	li	a5,1
     4c2:	00f51c63          	bne	a0,a5,4da <go+0x430>
        exit(0);
     4c6:	4501                	li	a0,0
     4c8:	76c000ef          	jal	c34 <exit>
          printf("grind: pipe write failed\n");
     4cc:	00001517          	auipc	a0,0x1
     4d0:	eec50513          	addi	a0,a0,-276 # 13b8 <malloc+0x26a>
     4d4:	3bf000ef          	jal	1092 <printf>
     4d8:	bfe9                	j	4b2 <go+0x408>
          printf("grind: pipe read failed\n");
     4da:	00001517          	auipc	a0,0x1
     4de:	efe50513          	addi	a0,a0,-258 # 13d8 <malloc+0x28a>
     4e2:	3b1000ef          	jal	1092 <printf>
     4e6:	b7c5                	j	4c6 <go+0x41c>
        printf("grind: fork failed\n");
     4e8:	00001517          	auipc	a0,0x1
     4ec:	e6850513          	addi	a0,a0,-408 # 1350 <malloc+0x202>
     4f0:	3a3000ef          	jal	1092 <printf>
        exit(1);
     4f4:	4505                	li	a0,1
     4f6:	73e000ef          	jal	c34 <exit>
      int pid = fork();
     4fa:	732000ef          	jal	c2c <fork>
      if(pid == 0){
     4fe:	c519                	beqz	a0,50c <go+0x462>
      } else if(pid < 0){
     500:	04054f63          	bltz	a0,55e <go+0x4b4>
      wait(0);
     504:	4501                	li	a0,0
     506:	736000ef          	jal	c3c <wait>
     50a:	b99d                	j	180 <go+0xd6>
        unlink("a");
     50c:	00001517          	auipc	a0,0x1
     510:	e5c50513          	addi	a0,a0,-420 # 1368 <malloc+0x21a>
     514:	770000ef          	jal	c84 <unlink>
        mkdir("a");
     518:	00001517          	auipc	a0,0x1
     51c:	e5050513          	addi	a0,a0,-432 # 1368 <malloc+0x21a>
     520:	77c000ef          	jal	c9c <mkdir>
        chdir("a");
     524:	00001517          	auipc	a0,0x1
     528:	e4450513          	addi	a0,a0,-444 # 1368 <malloc+0x21a>
     52c:	778000ef          	jal	ca4 <chdir>
        unlink("../a");
     530:	00001517          	auipc	a0,0x1
     534:	ec850513          	addi	a0,a0,-312 # 13f8 <malloc+0x2aa>
     538:	74c000ef          	jal	c84 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     53c:	20200593          	li	a1,514
     540:	00001517          	auipc	a0,0x1
     544:	e7050513          	addi	a0,a0,-400 # 13b0 <malloc+0x262>
     548:	72c000ef          	jal	c74 <open>
        unlink("x");
     54c:	00001517          	auipc	a0,0x1
     550:	e6450513          	addi	a0,a0,-412 # 13b0 <malloc+0x262>
     554:	730000ef          	jal	c84 <unlink>
        exit(0);
     558:	4501                	li	a0,0
     55a:	6da000ef          	jal	c34 <exit>
        printf("grind: fork failed\n");
     55e:	00001517          	auipc	a0,0x1
     562:	df250513          	addi	a0,a0,-526 # 1350 <malloc+0x202>
     566:	32d000ef          	jal	1092 <printf>
        exit(1);
     56a:	4505                	li	a0,1
     56c:	6c8000ef          	jal	c34 <exit>
      unlink("c");
     570:	00001517          	auipc	a0,0x1
     574:	e9050513          	addi	a0,a0,-368 # 1400 <malloc+0x2b2>
     578:	70c000ef          	jal	c84 <unlink>
      int fd1 = open("c", O_CREATE|O_RDWR);
     57c:	20200593          	li	a1,514
     580:	00001517          	auipc	a0,0x1
     584:	e8050513          	addi	a0,a0,-384 # 1400 <malloc+0x2b2>
     588:	6ec000ef          	jal	c74 <open>
     58c:	8d2a                	mv	s10,a0
      if(fd1 < 0){
     58e:	04054563          	bltz	a0,5d8 <go+0x52e>
      if(write(fd1, "x", 1) != 1){
     592:	8652                	mv	a2,s4
     594:	00001597          	auipc	a1,0x1
     598:	e1c58593          	addi	a1,a1,-484 # 13b0 <malloc+0x262>
     59c:	6b8000ef          	jal	c54 <write>
     5a0:	05451563          	bne	a0,s4,5ea <go+0x540>
      if(fstat(fd1, &st) != 0){
     5a4:	f7840593          	addi	a1,s0,-136
     5a8:	856a                	mv	a0,s10
     5aa:	6e2000ef          	jal	c8c <fstat>
     5ae:	e539                	bnez	a0,5fc <go+0x552>
      if(st.size != 1){
     5b0:	f8843583          	ld	a1,-120(s0)
     5b4:	05459d63          	bne	a1,s4,60e <go+0x564>
      if(st.ino > 200){
     5b8:	f7c42583          	lw	a1,-132(s0)
     5bc:	0c800793          	li	a5,200
     5c0:	06b7e163          	bltu	a5,a1,622 <go+0x578>
      close(fd1);
     5c4:	856a                	mv	a0,s10
     5c6:	696000ef          	jal	c5c <close>
      unlink("c");
     5ca:	00001517          	auipc	a0,0x1
     5ce:	e3650513          	addi	a0,a0,-458 # 1400 <malloc+0x2b2>
     5d2:	6b2000ef          	jal	c84 <unlink>
     5d6:	b66d                	j	180 <go+0xd6>
        printf("grind: create c failed\n");
     5d8:	00001517          	auipc	a0,0x1
     5dc:	e3050513          	addi	a0,a0,-464 # 1408 <malloc+0x2ba>
     5e0:	2b3000ef          	jal	1092 <printf>
        exit(1);
     5e4:	4505                	li	a0,1
     5e6:	64e000ef          	jal	c34 <exit>
        printf("grind: write c failed\n");
     5ea:	00001517          	auipc	a0,0x1
     5ee:	e3650513          	addi	a0,a0,-458 # 1420 <malloc+0x2d2>
     5f2:	2a1000ef          	jal	1092 <printf>
        exit(1);
     5f6:	4505                	li	a0,1
     5f8:	63c000ef          	jal	c34 <exit>
        printf("grind: fstat failed\n");
     5fc:	00001517          	auipc	a0,0x1
     600:	e3c50513          	addi	a0,a0,-452 # 1438 <malloc+0x2ea>
     604:	28f000ef          	jal	1092 <printf>
        exit(1);
     608:	4505                	li	a0,1
     60a:	62a000ef          	jal	c34 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     60e:	2581                	sext.w	a1,a1
     610:	00001517          	auipc	a0,0x1
     614:	e4050513          	addi	a0,a0,-448 # 1450 <malloc+0x302>
     618:	27b000ef          	jal	1092 <printf>
        exit(1);
     61c:	4505                	li	a0,1
     61e:	616000ef          	jal	c34 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     622:	00001517          	auipc	a0,0x1
     626:	e5650513          	addi	a0,a0,-426 # 1478 <malloc+0x32a>
     62a:	269000ef          	jal	1092 <printf>
        exit(1);
     62e:	4505                	li	a0,1
     630:	604000ef          	jal	c34 <exit>
      if(pipe(aa) < 0){
     634:	856e                	mv	a0,s11
     636:	60e000ef          	jal	c44 <pipe>
     63a:	0c054263          	bltz	a0,6fe <go+0x654>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     63e:	f7040513          	addi	a0,s0,-144
     642:	602000ef          	jal	c44 <pipe>
     646:	0c054663          	bltz	a0,712 <go+0x668>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     64a:	5e2000ef          	jal	c2c <fork>
      if(pid1 == 0){
     64e:	0c050c63          	beqz	a0,726 <go+0x67c>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     652:	14054e63          	bltz	a0,7ae <go+0x704>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     656:	5d6000ef          	jal	c2c <fork>
      if(pid2 == 0){
     65a:	16050463          	beqz	a0,7c2 <go+0x718>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     65e:	20054263          	bltz	a0,862 <go+0x7b8>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     662:	f6842503          	lw	a0,-152(s0)
     666:	5f6000ef          	jal	c5c <close>
      close(aa[1]);
     66a:	f6c42503          	lw	a0,-148(s0)
     66e:	5ee000ef          	jal	c5c <close>
      close(bb[1]);
     672:	f7442503          	lw	a0,-140(s0)
     676:	5e6000ef          	jal	c5c <close>
      char buf[4] = { 0, 0, 0, 0 };
     67a:	f6042023          	sw	zero,-160(s0)
      read(bb[0], buf+0, 1);
     67e:	8652                	mv	a2,s4
     680:	f6040593          	addi	a1,s0,-160
     684:	f7042503          	lw	a0,-144(s0)
     688:	5c4000ef          	jal	c4c <read>
      read(bb[0], buf+1, 1);
     68c:	8652                	mv	a2,s4
     68e:	f6140593          	addi	a1,s0,-159
     692:	f7042503          	lw	a0,-144(s0)
     696:	5b6000ef          	jal	c4c <read>
      read(bb[0], buf+2, 1);
     69a:	8652                	mv	a2,s4
     69c:	f6240593          	addi	a1,s0,-158
     6a0:	f7042503          	lw	a0,-144(s0)
     6a4:	5a8000ef          	jal	c4c <read>
      close(bb[0]);
     6a8:	f7042503          	lw	a0,-144(s0)
     6ac:	5b0000ef          	jal	c5c <close>
      int st1, st2;
      wait(&st1);
     6b0:	f6440513          	addi	a0,s0,-156
     6b4:	588000ef          	jal	c3c <wait>
      wait(&st2);
     6b8:	f7840513          	addi	a0,s0,-136
     6bc:	580000ef          	jal	c3c <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     6c0:	f6442783          	lw	a5,-156(s0)
     6c4:	f7842703          	lw	a4,-136(s0)
     6c8:	8fd9                	or	a5,a5,a4
     6ca:	eb99                	bnez	a5,6e0 <go+0x636>
     6cc:	00001597          	auipc	a1,0x1
     6d0:	e4c58593          	addi	a1,a1,-436 # 1518 <malloc+0x3ca>
     6d4:	f6040513          	addi	a0,s0,-160
     6d8:	2d6000ef          	jal	9ae <strcmp>
     6dc:	aa0502e3          	beqz	a0,180 <go+0xd6>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     6e0:	f6040693          	addi	a3,s0,-160
     6e4:	f7842603          	lw	a2,-136(s0)
     6e8:	f6442583          	lw	a1,-156(s0)
     6ec:	00001517          	auipc	a0,0x1
     6f0:	e3450513          	addi	a0,a0,-460 # 1520 <malloc+0x3d2>
     6f4:	19f000ef          	jal	1092 <printf>
        exit(1);
     6f8:	4505                	li	a0,1
     6fa:	53a000ef          	jal	c34 <exit>
        fprintf(2, "grind: pipe failed\n");
     6fe:	00001597          	auipc	a1,0x1
     702:	c9a58593          	addi	a1,a1,-870 # 1398 <malloc+0x24a>
     706:	4509                	li	a0,2
     708:	161000ef          	jal	1068 <fprintf>
        exit(1);
     70c:	4505                	li	a0,1
     70e:	526000ef          	jal	c34 <exit>
        fprintf(2, "grind: pipe failed\n");
     712:	00001597          	auipc	a1,0x1
     716:	c8658593          	addi	a1,a1,-890 # 1398 <malloc+0x24a>
     71a:	4509                	li	a0,2
     71c:	14d000ef          	jal	1068 <fprintf>
        exit(1);
     720:	4505                	li	a0,1
     722:	512000ef          	jal	c34 <exit>
        close(bb[0]);
     726:	f7042503          	lw	a0,-144(s0)
     72a:	532000ef          	jal	c5c <close>
        close(bb[1]);
     72e:	f7442503          	lw	a0,-140(s0)
     732:	52a000ef          	jal	c5c <close>
        close(aa[0]);
     736:	f6842503          	lw	a0,-152(s0)
     73a:	522000ef          	jal	c5c <close>
        close(1);
     73e:	4505                	li	a0,1
     740:	51c000ef          	jal	c5c <close>
        if(dup(aa[1]) != 1){
     744:	f6c42503          	lw	a0,-148(s0)
     748:	564000ef          	jal	cac <dup>
     74c:	4785                	li	a5,1
     74e:	00f50c63          	beq	a0,a5,766 <go+0x6bc>
          fprintf(2, "grind: dup failed\n");
     752:	00001597          	auipc	a1,0x1
     756:	d4e58593          	addi	a1,a1,-690 # 14a0 <malloc+0x352>
     75a:	4509                	li	a0,2
     75c:	10d000ef          	jal	1068 <fprintf>
          exit(1);
     760:	4505                	li	a0,1
     762:	4d2000ef          	jal	c34 <exit>
        close(aa[1]);
     766:	f6c42503          	lw	a0,-148(s0)
     76a:	4f2000ef          	jal	c5c <close>
        char *args[3] = { "echo", "hi", 0 };
     76e:	00001797          	auipc	a5,0x1
     772:	d4a78793          	addi	a5,a5,-694 # 14b8 <malloc+0x36a>
     776:	f6f43c23          	sd	a5,-136(s0)
     77a:	00001797          	auipc	a5,0x1
     77e:	d4678793          	addi	a5,a5,-698 # 14c0 <malloc+0x372>
     782:	f8f43023          	sd	a5,-128(s0)
     786:	f8043423          	sd	zero,-120(s0)
        exec("grindir/../echo", args);
     78a:	f7840593          	addi	a1,s0,-136
     78e:	00001517          	auipc	a0,0x1
     792:	d3a50513          	addi	a0,a0,-710 # 14c8 <malloc+0x37a>
     796:	4d6000ef          	jal	c6c <exec>
        fprintf(2, "grind: echo: not found\n");
     79a:	00001597          	auipc	a1,0x1
     79e:	d3e58593          	addi	a1,a1,-706 # 14d8 <malloc+0x38a>
     7a2:	4509                	li	a0,2
     7a4:	0c5000ef          	jal	1068 <fprintf>
        exit(2);
     7a8:	4509                	li	a0,2
     7aa:	48a000ef          	jal	c34 <exit>
        fprintf(2, "grind: fork failed\n");
     7ae:	00001597          	auipc	a1,0x1
     7b2:	ba258593          	addi	a1,a1,-1118 # 1350 <malloc+0x202>
     7b6:	4509                	li	a0,2
     7b8:	0b1000ef          	jal	1068 <fprintf>
        exit(3);
     7bc:	450d                	li	a0,3
     7be:	476000ef          	jal	c34 <exit>
        close(aa[1]);
     7c2:	f6c42503          	lw	a0,-148(s0)
     7c6:	496000ef          	jal	c5c <close>
        close(bb[0]);
     7ca:	f7042503          	lw	a0,-144(s0)
     7ce:	48e000ef          	jal	c5c <close>
        close(0);
     7d2:	4501                	li	a0,0
     7d4:	488000ef          	jal	c5c <close>
        if(dup(aa[0]) != 0){
     7d8:	f6842503          	lw	a0,-152(s0)
     7dc:	4d0000ef          	jal	cac <dup>
     7e0:	c919                	beqz	a0,7f6 <go+0x74c>
          fprintf(2, "grind: dup failed\n");
     7e2:	00001597          	auipc	a1,0x1
     7e6:	cbe58593          	addi	a1,a1,-834 # 14a0 <malloc+0x352>
     7ea:	4509                	li	a0,2
     7ec:	07d000ef          	jal	1068 <fprintf>
          exit(4);
     7f0:	4511                	li	a0,4
     7f2:	442000ef          	jal	c34 <exit>
        close(aa[0]);
     7f6:	f6842503          	lw	a0,-152(s0)
     7fa:	462000ef          	jal	c5c <close>
        close(1);
     7fe:	4505                	li	a0,1
     800:	45c000ef          	jal	c5c <close>
        if(dup(bb[1]) != 1){
     804:	f7442503          	lw	a0,-140(s0)
     808:	4a4000ef          	jal	cac <dup>
     80c:	4785                	li	a5,1
     80e:	00f50c63          	beq	a0,a5,826 <go+0x77c>
          fprintf(2, "grind: dup failed\n");
     812:	00001597          	auipc	a1,0x1
     816:	c8e58593          	addi	a1,a1,-882 # 14a0 <malloc+0x352>
     81a:	4509                	li	a0,2
     81c:	04d000ef          	jal	1068 <fprintf>
          exit(5);
     820:	4515                	li	a0,5
     822:	412000ef          	jal	c34 <exit>
        close(bb[1]);
     826:	f7442503          	lw	a0,-140(s0)
     82a:	432000ef          	jal	c5c <close>
        char *args[2] = { "cat", 0 };
     82e:	00001797          	auipc	a5,0x1
     832:	cc278793          	addi	a5,a5,-830 # 14f0 <malloc+0x3a2>
     836:	f6f43c23          	sd	a5,-136(s0)
     83a:	f8043023          	sd	zero,-128(s0)
        exec("/cat", args);
     83e:	f7840593          	addi	a1,s0,-136
     842:	00001517          	auipc	a0,0x1
     846:	cb650513          	addi	a0,a0,-842 # 14f8 <malloc+0x3aa>
     84a:	422000ef          	jal	c6c <exec>
        fprintf(2, "grind: cat: not found\n");
     84e:	00001597          	auipc	a1,0x1
     852:	cb258593          	addi	a1,a1,-846 # 1500 <malloc+0x3b2>
     856:	4509                	li	a0,2
     858:	011000ef          	jal	1068 <fprintf>
        exit(6);
     85c:	4519                	li	a0,6
     85e:	3d6000ef          	jal	c34 <exit>
        fprintf(2, "grind: fork failed\n");
     862:	00001597          	auipc	a1,0x1
     866:	aee58593          	addi	a1,a1,-1298 # 1350 <malloc+0x202>
     86a:	4509                	li	a0,2
     86c:	7fc000ef          	jal	1068 <fprintf>
        exit(7);
     870:	451d                	li	a0,7
     872:	3c2000ef          	jal	c34 <exit>

0000000000000876 <iter>:
  }
}

void
iter()
{
     876:	7179                	addi	sp,sp,-48
     878:	f406                	sd	ra,40(sp)
     87a:	f022                	sd	s0,32(sp)
     87c:	1800                	addi	s0,sp,48
  unlink("a");
     87e:	00001517          	auipc	a0,0x1
     882:	aea50513          	addi	a0,a0,-1302 # 1368 <malloc+0x21a>
     886:	3fe000ef          	jal	c84 <unlink>
  unlink("b");
     88a:	00001517          	auipc	a0,0x1
     88e:	a8e50513          	addi	a0,a0,-1394 # 1318 <malloc+0x1ca>
     892:	3f2000ef          	jal	c84 <unlink>
  
  int pid1 = fork();
     896:	396000ef          	jal	c2c <fork>
  if(pid1 < 0){
     89a:	02054163          	bltz	a0,8bc <iter+0x46>
     89e:	ec26                	sd	s1,24(sp)
     8a0:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     8a2:	e905                	bnez	a0,8d2 <iter+0x5c>
     8a4:	e84a                	sd	s2,16(sp)
    rand_next ^= 31;
     8a6:	00001717          	auipc	a4,0x1
     8aa:	75a70713          	addi	a4,a4,1882 # 2000 <rand_next>
     8ae:	631c                	ld	a5,0(a4)
     8b0:	01f7c793          	xori	a5,a5,31
     8b4:	e31c                	sd	a5,0(a4)
    go(0);
     8b6:	4501                	li	a0,0
     8b8:	ff2ff0ef          	jal	aa <go>
     8bc:	ec26                	sd	s1,24(sp)
     8be:	e84a                	sd	s2,16(sp)
    printf("grind: fork failed\n");
     8c0:	00001517          	auipc	a0,0x1
     8c4:	a9050513          	addi	a0,a0,-1392 # 1350 <malloc+0x202>
     8c8:	7ca000ef          	jal	1092 <printf>
    exit(1);
     8cc:	4505                	li	a0,1
     8ce:	366000ef          	jal	c34 <exit>
     8d2:	e84a                	sd	s2,16(sp)
    exit(0);
  }

  int pid2 = fork();
     8d4:	358000ef          	jal	c2c <fork>
     8d8:	892a                	mv	s2,a0
  if(pid2 < 0){
     8da:	02054063          	bltz	a0,8fa <iter+0x84>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     8de:	e51d                	bnez	a0,90c <iter+0x96>
    rand_next ^= 7177;
     8e0:	00001697          	auipc	a3,0x1
     8e4:	72068693          	addi	a3,a3,1824 # 2000 <rand_next>
     8e8:	629c                	ld	a5,0(a3)
     8ea:	6709                	lui	a4,0x2
     8ec:	c0970713          	addi	a4,a4,-1015 # 1c09 <digits+0x659>
     8f0:	8fb9                	xor	a5,a5,a4
     8f2:	e29c                	sd	a5,0(a3)
    go(1);
     8f4:	4505                	li	a0,1
     8f6:	fb4ff0ef          	jal	aa <go>
    printf("grind: fork failed\n");
     8fa:	00001517          	auipc	a0,0x1
     8fe:	a5650513          	addi	a0,a0,-1450 # 1350 <malloc+0x202>
     902:	790000ef          	jal	1092 <printf>
    exit(1);
     906:	4505                	li	a0,1
     908:	32c000ef          	jal	c34 <exit>
    exit(0);
  }

  int st1 = -1;
     90c:	57fd                	li	a5,-1
     90e:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     912:	fdc40513          	addi	a0,s0,-36
     916:	326000ef          	jal	c3c <wait>
  if(st1 != 0){
     91a:	fdc42783          	lw	a5,-36(s0)
     91e:	eb99                	bnez	a5,934 <iter+0xbe>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     920:	57fd                	li	a5,-1
     922:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     926:	fd840513          	addi	a0,s0,-40
     92a:	312000ef          	jal	c3c <wait>

  exit(0);
     92e:	4501                	li	a0,0
     930:	304000ef          	jal	c34 <exit>
    kill(pid1);
     934:	8526                	mv	a0,s1
     936:	32e000ef          	jal	c64 <kill>
    kill(pid2);
     93a:	854a                	mv	a0,s2
     93c:	328000ef          	jal	c64 <kill>
     940:	b7c5                	j	920 <iter+0xaa>

0000000000000942 <main>:
}

int
main()
{
     942:	1101                	addi	sp,sp,-32
     944:	ec06                	sd	ra,24(sp)
     946:	e822                	sd	s0,16(sp)
     948:	e426                	sd	s1,8(sp)
     94a:	e04a                	sd	s2,0(sp)
     94c:	1000                	addi	s0,sp,32
      exit(0);
    }
    if(pid > 0){
      wait(0);
    }
    pause(20);
     94e:	4951                	li	s2,20
    rand_next += 1;
     950:	00001497          	auipc	s1,0x1
     954:	6b048493          	addi	s1,s1,1712 # 2000 <rand_next>
     958:	a809                	j	96a <main+0x28>
      iter();
     95a:	f1dff0ef          	jal	876 <iter>
    pause(20);
     95e:	854a                	mv	a0,s2
     960:	364000ef          	jal	cc4 <pause>
    rand_next += 1;
     964:	609c                	ld	a5,0(s1)
     966:	0785                	addi	a5,a5,1
     968:	e09c                	sd	a5,0(s1)
    int pid = fork();
     96a:	2c2000ef          	jal	c2c <fork>
    if(pid == 0){
     96e:	d575                	beqz	a0,95a <main+0x18>
    if(pid > 0){
     970:	fea057e3          	blez	a0,95e <main+0x1c>
      wait(0);
     974:	4501                	li	a0,0
     976:	2c6000ef          	jal	c3c <wait>
     97a:	b7d5                	j	95e <main+0x1c>

000000000000097c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
     97c:	1141                	addi	sp,sp,-16
     97e:	e406                	sd	ra,8(sp)
     980:	e022                	sd	s0,0(sp)
     982:	0800                	addi	s0,sp,16
  extern int main();
  main();
     984:	fbfff0ef          	jal	942 <main>
  exit(0);
     988:	4501                	li	a0,0
     98a:	2aa000ef          	jal	c34 <exit>

000000000000098e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     98e:	1141                	addi	sp,sp,-16
     990:	e406                	sd	ra,8(sp)
     992:	e022                	sd	s0,0(sp)
     994:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     996:	87aa                	mv	a5,a0
     998:	0585                	addi	a1,a1,1
     99a:	0785                	addi	a5,a5,1
     99c:	fff5c703          	lbu	a4,-1(a1)
     9a0:	fee78fa3          	sb	a4,-1(a5)
     9a4:	fb75                	bnez	a4,998 <strcpy+0xa>
    ;
  return os;
}
     9a6:	60a2                	ld	ra,8(sp)
     9a8:	6402                	ld	s0,0(sp)
     9aa:	0141                	addi	sp,sp,16
     9ac:	8082                	ret

00000000000009ae <strcmp>:

int
strcmp(const char *p, const char *q)
{
     9ae:	1141                	addi	sp,sp,-16
     9b0:	e406                	sd	ra,8(sp)
     9b2:	e022                	sd	s0,0(sp)
     9b4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     9b6:	00054783          	lbu	a5,0(a0)
     9ba:	cb91                	beqz	a5,9ce <strcmp+0x20>
     9bc:	0005c703          	lbu	a4,0(a1)
     9c0:	00f71763          	bne	a4,a5,9ce <strcmp+0x20>
    p++, q++;
     9c4:	0505                	addi	a0,a0,1
     9c6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     9c8:	00054783          	lbu	a5,0(a0)
     9cc:	fbe5                	bnez	a5,9bc <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
     9ce:	0005c503          	lbu	a0,0(a1)
}
     9d2:	40a7853b          	subw	a0,a5,a0
     9d6:	60a2                	ld	ra,8(sp)
     9d8:	6402                	ld	s0,0(sp)
     9da:	0141                	addi	sp,sp,16
     9dc:	8082                	ret

00000000000009de <strlen>:

uint
strlen(const char *s)
{
     9de:	1141                	addi	sp,sp,-16
     9e0:	e406                	sd	ra,8(sp)
     9e2:	e022                	sd	s0,0(sp)
     9e4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     9e6:	00054783          	lbu	a5,0(a0)
     9ea:	cf91                	beqz	a5,a06 <strlen+0x28>
     9ec:	00150793          	addi	a5,a0,1
     9f0:	86be                	mv	a3,a5
     9f2:	0785                	addi	a5,a5,1
     9f4:	fff7c703          	lbu	a4,-1(a5)
     9f8:	ff65                	bnez	a4,9f0 <strlen+0x12>
     9fa:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
     9fe:	60a2                	ld	ra,8(sp)
     a00:	6402                	ld	s0,0(sp)
     a02:	0141                	addi	sp,sp,16
     a04:	8082                	ret
  for(n = 0; s[n]; n++)
     a06:	4501                	li	a0,0
     a08:	bfdd                	j	9fe <strlen+0x20>

0000000000000a0a <memset>:

void*
memset(void *dst, int c, uint n)
{
     a0a:	1141                	addi	sp,sp,-16
     a0c:	e406                	sd	ra,8(sp)
     a0e:	e022                	sd	s0,0(sp)
     a10:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     a12:	ca19                	beqz	a2,a28 <memset+0x1e>
     a14:	87aa                	mv	a5,a0
     a16:	1602                	slli	a2,a2,0x20
     a18:	9201                	srli	a2,a2,0x20
     a1a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     a1e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     a22:	0785                	addi	a5,a5,1
     a24:	fee79de3          	bne	a5,a4,a1e <memset+0x14>
  }
  return dst;
}
     a28:	60a2                	ld	ra,8(sp)
     a2a:	6402                	ld	s0,0(sp)
     a2c:	0141                	addi	sp,sp,16
     a2e:	8082                	ret

0000000000000a30 <strchr>:

char*
strchr(const char *s, char c)
{
     a30:	1141                	addi	sp,sp,-16
     a32:	e406                	sd	ra,8(sp)
     a34:	e022                	sd	s0,0(sp)
     a36:	0800                	addi	s0,sp,16
  for(; *s; s++)
     a38:	00054783          	lbu	a5,0(a0)
     a3c:	c799                	beqz	a5,a4a <strchr+0x1a>
    if(*s == c)
     a3e:	00f58763          	beq	a1,a5,a4c <strchr+0x1c>
  for(; *s; s++)
     a42:	0505                	addi	a0,a0,1
     a44:	00054783          	lbu	a5,0(a0)
     a48:	fbfd                	bnez	a5,a3e <strchr+0xe>
      return (char*)s;
  return 0;
     a4a:	4501                	li	a0,0
}
     a4c:	60a2                	ld	ra,8(sp)
     a4e:	6402                	ld	s0,0(sp)
     a50:	0141                	addi	sp,sp,16
     a52:	8082                	ret

0000000000000a54 <gets>:

char*
gets(char *buf, int max)
{
     a54:	711d                	addi	sp,sp,-96
     a56:	ec86                	sd	ra,88(sp)
     a58:	e8a2                	sd	s0,80(sp)
     a5a:	e4a6                	sd	s1,72(sp)
     a5c:	e0ca                	sd	s2,64(sp)
     a5e:	fc4e                	sd	s3,56(sp)
     a60:	f852                	sd	s4,48(sp)
     a62:	f456                	sd	s5,40(sp)
     a64:	f05a                	sd	s6,32(sp)
     a66:	ec5e                	sd	s7,24(sp)
     a68:	e862                	sd	s8,16(sp)
     a6a:	1080                	addi	s0,sp,96
     a6c:	8baa                	mv	s7,a0
     a6e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     a70:	892a                	mv	s2,a0
     a72:	4481                	li	s1,0
    cc = read(0, &c, 1);
     a74:	faf40b13          	addi	s6,s0,-81
     a78:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
     a7a:	8c26                	mv	s8,s1
     a7c:	0014899b          	addiw	s3,s1,1
     a80:	84ce                	mv	s1,s3
     a82:	0349d863          	bge	s3,s4,ab2 <gets+0x5e>
    cc = read(0, &c, 1);
     a86:	8656                	mv	a2,s5
     a88:	85da                	mv	a1,s6
     a8a:	4501                	li	a0,0
     a8c:	1c0000ef          	jal	c4c <read>
    if(cc < 1)
     a90:	02a05163          	blez	a0,ab2 <gets+0x5e>
      break;
    buf[i++] = c;
     a94:	faf44783          	lbu	a5,-81(s0)
     a98:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     a9c:	0905                	addi	s2,s2,1
     a9e:	ff678713          	addi	a4,a5,-10
     aa2:	00173713          	seqz	a4,a4
     aa6:	17cd                	addi	a5,a5,-13
     aa8:	0017b793          	seqz	a5,a5
     aac:	8fd9                	or	a5,a5,a4
     aae:	d7f1                	beqz	a5,a7a <gets+0x26>
    buf[i++] = c;
     ab0:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
     ab2:	9c5e                	add	s8,s8,s7
     ab4:	000c0023          	sb	zero,0(s8)
  return buf;
}
     ab8:	855e                	mv	a0,s7
     aba:	60e6                	ld	ra,88(sp)
     abc:	6446                	ld	s0,80(sp)
     abe:	64a6                	ld	s1,72(sp)
     ac0:	6906                	ld	s2,64(sp)
     ac2:	79e2                	ld	s3,56(sp)
     ac4:	7a42                	ld	s4,48(sp)
     ac6:	7aa2                	ld	s5,40(sp)
     ac8:	7b02                	ld	s6,32(sp)
     aca:	6be2                	ld	s7,24(sp)
     acc:	6c42                	ld	s8,16(sp)
     ace:	6125                	addi	sp,sp,96
     ad0:	8082                	ret

0000000000000ad2 <stat>:

int
stat(const char *n, struct stat *st)
{
     ad2:	1101                	addi	sp,sp,-32
     ad4:	ec06                	sd	ra,24(sp)
     ad6:	e822                	sd	s0,16(sp)
     ad8:	e04a                	sd	s2,0(sp)
     ada:	1000                	addi	s0,sp,32
     adc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     ade:	4581                	li	a1,0
     ae0:	194000ef          	jal	c74 <open>
  if(fd < 0)
     ae4:	02054263          	bltz	a0,b08 <stat+0x36>
     ae8:	e426                	sd	s1,8(sp)
     aea:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     aec:	85ca                	mv	a1,s2
     aee:	19e000ef          	jal	c8c <fstat>
     af2:	892a                	mv	s2,a0
  close(fd);
     af4:	8526                	mv	a0,s1
     af6:	166000ef          	jal	c5c <close>
  return r;
     afa:	64a2                	ld	s1,8(sp)
}
     afc:	854a                	mv	a0,s2
     afe:	60e2                	ld	ra,24(sp)
     b00:	6442                	ld	s0,16(sp)
     b02:	6902                	ld	s2,0(sp)
     b04:	6105                	addi	sp,sp,32
     b06:	8082                	ret
    return -1;
     b08:	57fd                	li	a5,-1
     b0a:	893e                	mv	s2,a5
     b0c:	bfc5                	j	afc <stat+0x2a>

0000000000000b0e <atoi>:

int
atoi(const char *s)
{
     b0e:	1141                	addi	sp,sp,-16
     b10:	e406                	sd	ra,8(sp)
     b12:	e022                	sd	s0,0(sp)
     b14:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     b16:	00054683          	lbu	a3,0(a0)
     b1a:	fd06879b          	addiw	a5,a3,-48
     b1e:	0ff7f793          	zext.b	a5,a5
     b22:	4625                	li	a2,9
     b24:	02f66963          	bltu	a2,a5,b56 <atoi+0x48>
     b28:	872a                	mv	a4,a0
  n = 0;
     b2a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     b2c:	0705                	addi	a4,a4,1
     b2e:	0025179b          	slliw	a5,a0,0x2
     b32:	9fa9                	addw	a5,a5,a0
     b34:	0017979b          	slliw	a5,a5,0x1
     b38:	9fb5                	addw	a5,a5,a3
     b3a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     b3e:	00074683          	lbu	a3,0(a4)
     b42:	fd06879b          	addiw	a5,a3,-48
     b46:	0ff7f793          	zext.b	a5,a5
     b4a:	fef671e3          	bgeu	a2,a5,b2c <atoi+0x1e>
  return n;
}
     b4e:	60a2                	ld	ra,8(sp)
     b50:	6402                	ld	s0,0(sp)
     b52:	0141                	addi	sp,sp,16
     b54:	8082                	ret
  n = 0;
     b56:	4501                	li	a0,0
     b58:	bfdd                	j	b4e <atoi+0x40>

0000000000000b5a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     b5a:	1141                	addi	sp,sp,-16
     b5c:	e406                	sd	ra,8(sp)
     b5e:	e022                	sd	s0,0(sp)
     b60:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     b62:	02b57563          	bgeu	a0,a1,b8c <memmove+0x32>
    while(n-- > 0)
     b66:	00c05f63          	blez	a2,b84 <memmove+0x2a>
     b6a:	1602                	slli	a2,a2,0x20
     b6c:	9201                	srli	a2,a2,0x20
     b6e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     b72:	872a                	mv	a4,a0
      *dst++ = *src++;
     b74:	0585                	addi	a1,a1,1
     b76:	0705                	addi	a4,a4,1
     b78:	fff5c683          	lbu	a3,-1(a1)
     b7c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     b80:	fee79ae3          	bne	a5,a4,b74 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     b84:	60a2                	ld	ra,8(sp)
     b86:	6402                	ld	s0,0(sp)
     b88:	0141                	addi	sp,sp,16
     b8a:	8082                	ret
    while(n-- > 0)
     b8c:	fec05ce3          	blez	a2,b84 <memmove+0x2a>
    dst += n;
     b90:	00c50733          	add	a4,a0,a2
    src += n;
     b94:	95b2                	add	a1,a1,a2
     b96:	fff6079b          	addiw	a5,a2,-1
     b9a:	1782                	slli	a5,a5,0x20
     b9c:	9381                	srli	a5,a5,0x20
     b9e:	fff7c793          	not	a5,a5
     ba2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     ba4:	15fd                	addi	a1,a1,-1
     ba6:	177d                	addi	a4,a4,-1
     ba8:	0005c683          	lbu	a3,0(a1)
     bac:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     bb0:	fef71ae3          	bne	a4,a5,ba4 <memmove+0x4a>
     bb4:	bfc1                	j	b84 <memmove+0x2a>

0000000000000bb6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     bb6:	1141                	addi	sp,sp,-16
     bb8:	e406                	sd	ra,8(sp)
     bba:	e022                	sd	s0,0(sp)
     bbc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     bbe:	ce19                	beqz	a2,bdc <memcmp+0x26>
     bc0:	1602                	slli	a2,a2,0x20
     bc2:	9201                	srli	a2,a2,0x20
     bc4:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
     bc8:	00054783          	lbu	a5,0(a0)
     bcc:	0005c703          	lbu	a4,0(a1)
     bd0:	00e79b63          	bne	a5,a4,be6 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
     bd4:	0505                	addi	a0,a0,1
    p2++;
     bd6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     bd8:	fed518e3          	bne	a0,a3,bc8 <memcmp+0x12>
  }
  return 0;
     bdc:	4501                	li	a0,0
}
     bde:	60a2                	ld	ra,8(sp)
     be0:	6402                	ld	s0,0(sp)
     be2:	0141                	addi	sp,sp,16
     be4:	8082                	ret
      return *p1 - *p2;
     be6:	40e7853b          	subw	a0,a5,a4
     bea:	bfd5                	j	bde <memcmp+0x28>

0000000000000bec <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     bec:	1141                	addi	sp,sp,-16
     bee:	e406                	sd	ra,8(sp)
     bf0:	e022                	sd	s0,0(sp)
     bf2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     bf4:	f67ff0ef          	jal	b5a <memmove>
}
     bf8:	60a2                	ld	ra,8(sp)
     bfa:	6402                	ld	s0,0(sp)
     bfc:	0141                	addi	sp,sp,16
     bfe:	8082                	ret

0000000000000c00 <sbrk>:

char *
sbrk(int n) {
     c00:	1141                	addi	sp,sp,-16
     c02:	e406                	sd	ra,8(sp)
     c04:	e022                	sd	s0,0(sp)
     c06:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
     c08:	4585                	li	a1,1
     c0a:	0b2000ef          	jal	cbc <sys_sbrk>
}
     c0e:	60a2                	ld	ra,8(sp)
     c10:	6402                	ld	s0,0(sp)
     c12:	0141                	addi	sp,sp,16
     c14:	8082                	ret

0000000000000c16 <sbrklazy>:

char *
sbrklazy(int n) {
     c16:	1141                	addi	sp,sp,-16
     c18:	e406                	sd	ra,8(sp)
     c1a:	e022                	sd	s0,0(sp)
     c1c:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
     c1e:	4589                	li	a1,2
     c20:	09c000ef          	jal	cbc <sys_sbrk>
}
     c24:	60a2                	ld	ra,8(sp)
     c26:	6402                	ld	s0,0(sp)
     c28:	0141                	addi	sp,sp,16
     c2a:	8082                	ret

0000000000000c2c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     c2c:	4885                	li	a7,1
 ecall
     c2e:	00000073          	ecall
 ret
     c32:	8082                	ret

0000000000000c34 <exit>:
.global exit
exit:
 li a7, SYS_exit
     c34:	4889                	li	a7,2
 ecall
     c36:	00000073          	ecall
 ret
     c3a:	8082                	ret

0000000000000c3c <wait>:
.global wait
wait:
 li a7, SYS_wait
     c3c:	488d                	li	a7,3
 ecall
     c3e:	00000073          	ecall
 ret
     c42:	8082                	ret

0000000000000c44 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     c44:	4891                	li	a7,4
 ecall
     c46:	00000073          	ecall
 ret
     c4a:	8082                	ret

0000000000000c4c <read>:
.global read
read:
 li a7, SYS_read
     c4c:	4895                	li	a7,5
 ecall
     c4e:	00000073          	ecall
 ret
     c52:	8082                	ret

0000000000000c54 <write>:
.global write
write:
 li a7, SYS_write
     c54:	48c1                	li	a7,16
 ecall
     c56:	00000073          	ecall
 ret
     c5a:	8082                	ret

0000000000000c5c <close>:
.global close
close:
 li a7, SYS_close
     c5c:	48d5                	li	a7,21
 ecall
     c5e:	00000073          	ecall
 ret
     c62:	8082                	ret

0000000000000c64 <kill>:
.global kill
kill:
 li a7, SYS_kill
     c64:	4899                	li	a7,6
 ecall
     c66:	00000073          	ecall
 ret
     c6a:	8082                	ret

0000000000000c6c <exec>:
.global exec
exec:
 li a7, SYS_exec
     c6c:	489d                	li	a7,7
 ecall
     c6e:	00000073          	ecall
 ret
     c72:	8082                	ret

0000000000000c74 <open>:
.global open
open:
 li a7, SYS_open
     c74:	48bd                	li	a7,15
 ecall
     c76:	00000073          	ecall
 ret
     c7a:	8082                	ret

0000000000000c7c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     c7c:	48c5                	li	a7,17
 ecall
     c7e:	00000073          	ecall
 ret
     c82:	8082                	ret

0000000000000c84 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     c84:	48c9                	li	a7,18
 ecall
     c86:	00000073          	ecall
 ret
     c8a:	8082                	ret

0000000000000c8c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     c8c:	48a1                	li	a7,8
 ecall
     c8e:	00000073          	ecall
 ret
     c92:	8082                	ret

0000000000000c94 <link>:
.global link
link:
 li a7, SYS_link
     c94:	48cd                	li	a7,19
 ecall
     c96:	00000073          	ecall
 ret
     c9a:	8082                	ret

0000000000000c9c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     c9c:	48d1                	li	a7,20
 ecall
     c9e:	00000073          	ecall
 ret
     ca2:	8082                	ret

0000000000000ca4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     ca4:	48a5                	li	a7,9
 ecall
     ca6:	00000073          	ecall
 ret
     caa:	8082                	ret

0000000000000cac <dup>:
.global dup
dup:
 li a7, SYS_dup
     cac:	48a9                	li	a7,10
 ecall
     cae:	00000073          	ecall
 ret
     cb2:	8082                	ret

0000000000000cb4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     cb4:	48ad                	li	a7,11
 ecall
     cb6:	00000073          	ecall
 ret
     cba:	8082                	ret

0000000000000cbc <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     cbc:	48b1                	li	a7,12
 ecall
     cbe:	00000073          	ecall
 ret
     cc2:	8082                	ret

0000000000000cc4 <pause>:
.global pause
pause:
 li a7, SYS_pause
     cc4:	48b5                	li	a7,13
 ecall
     cc6:	00000073          	ecall
 ret
     cca:	8082                	ret

0000000000000ccc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     ccc:	48b9                	li	a7,14
 ecall
     cce:	00000073          	ecall
 ret
     cd2:	8082                	ret

0000000000000cd4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     cd4:	1101                	addi	sp,sp,-32
     cd6:	ec06                	sd	ra,24(sp)
     cd8:	e822                	sd	s0,16(sp)
     cda:	1000                	addi	s0,sp,32
     cdc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     ce0:	4605                	li	a2,1
     ce2:	fef40593          	addi	a1,s0,-17
     ce6:	f6fff0ef          	jal	c54 <write>
}
     cea:	60e2                	ld	ra,24(sp)
     cec:	6442                	ld	s0,16(sp)
     cee:	6105                	addi	sp,sp,32
     cf0:	8082                	ret

0000000000000cf2 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     cf2:	715d                	addi	sp,sp,-80
     cf4:	e486                	sd	ra,72(sp)
     cf6:	e0a2                	sd	s0,64(sp)
     cf8:	f84a                	sd	s2,48(sp)
     cfa:	f44e                	sd	s3,40(sp)
     cfc:	0880                	addi	s0,sp,80
     cfe:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     d00:	00d036b3          	snez	a3,a3
     d04:	03f5d793          	srli	a5,a1,0x3f
     d08:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     d0a:	0005871b          	sext.w	a4,a1
  neg = 0;
     d0e:	4301                	li	t1,0
  if(sgn && xx < 0){
     d10:	c681                	beqz	a3,d18 <printint+0x26>
    x = -xx;
     d12:	40b0073b          	negw	a4,a1
    neg = 1;
     d16:	4305                	li	t1,1
  }

  i = 0;
     d18:	fb840993          	addi	s3,s0,-72
  neg = 0;
     d1c:	85ce                	mv	a1,s3
  i = 0;
     d1e:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
     d20:	00001817          	auipc	a6,0x1
     d24:	89080813          	addi	a6,a6,-1904 # 15b0 <digits>
     d28:	88b6                	mv	a7,a3
     d2a:	0016851b          	addiw	a0,a3,1
     d2e:	86aa                	mv	a3,a0
     d30:	02c777bb          	remuw	a5,a4,a2
     d34:	1782                	slli	a5,a5,0x20
     d36:	9381                	srli	a5,a5,0x20
     d38:	97c2                	add	a5,a5,a6
     d3a:	0007c783          	lbu	a5,0(a5)
     d3e:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
     d42:	87ba                	mv	a5,a4
     d44:	02c7573b          	divuw	a4,a4,a2
     d48:	0585                	addi	a1,a1,1
     d4a:	fcc7ffe3          	bgeu	a5,a2,d28 <printint+0x36>
  if(neg)
     d4e:	00030b63          	beqz	t1,d64 <printint+0x72>
    buf[i++] = '-';
     d52:	fd040793          	addi	a5,s0,-48
     d56:	953e                	add	a0,a0,a5
     d58:	02d00793          	li	a5,45
     d5c:	fef50423          	sb	a5,-24(a0)
     d60:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
     d64:	02d05563          	blez	a3,d8e <printint+0x9c>
     d68:	fc26                	sd	s1,56(sp)
     d6a:	36fd                	addiw	a3,a3,-1
     d6c:	00d984b3          	add	s1,s3,a3
     d70:	19fd                	addi	s3,s3,-1
     d72:	99b6                	add	s3,s3,a3
     d74:	1682                	slli	a3,a3,0x20
     d76:	9281                	srli	a3,a3,0x20
     d78:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
     d7c:	0004c583          	lbu	a1,0(s1)
     d80:	854a                	mv	a0,s2
     d82:	f53ff0ef          	jal	cd4 <putc>
  while(--i >= 0)
     d86:	14fd                	addi	s1,s1,-1
     d88:	ff349ae3          	bne	s1,s3,d7c <printint+0x8a>
     d8c:	74e2                	ld	s1,56(sp)
}
     d8e:	60a6                	ld	ra,72(sp)
     d90:	6406                	ld	s0,64(sp)
     d92:	7942                	ld	s2,48(sp)
     d94:	79a2                	ld	s3,40(sp)
     d96:	6161                	addi	sp,sp,80
     d98:	8082                	ret

0000000000000d9a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     d9a:	711d                	addi	sp,sp,-96
     d9c:	ec86                	sd	ra,88(sp)
     d9e:	e8a2                	sd	s0,80(sp)
     da0:	e4a6                	sd	s1,72(sp)
     da2:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     da4:	0005c483          	lbu	s1,0(a1)
     da8:	2a048063          	beqz	s1,1048 <vprintf+0x2ae>
     dac:	e0ca                	sd	s2,64(sp)
     dae:	fc4e                	sd	s3,56(sp)
     db0:	f852                	sd	s4,48(sp)
     db2:	f456                	sd	s5,40(sp)
     db4:	f05a                	sd	s6,32(sp)
     db6:	ec5e                	sd	s7,24(sp)
     db8:	e862                	sd	s8,16(sp)
     dba:	8b2a                	mv	s6,a0
     dbc:	8a2e                	mv	s4,a1
     dbe:	8bb2                	mv	s7,a2
  state = 0;
     dc0:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     dc2:	4901                	li	s2,0
     dc4:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     dc6:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     dca:	06400c13          	li	s8,100
     dce:	a00d                	j	df0 <vprintf+0x56>
        putc(fd, c0);
     dd0:	85a6                	mv	a1,s1
     dd2:	855a                	mv	a0,s6
     dd4:	f01ff0ef          	jal	cd4 <putc>
     dd8:	a019                	j	dde <vprintf+0x44>
    } else if(state == '%'){
     dda:	03598363          	beq	s3,s5,e00 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
     dde:	0019079b          	addiw	a5,s2,1
     de2:	893e                	mv	s2,a5
     de4:	873e                	mv	a4,a5
     de6:	97d2                	add	a5,a5,s4
     de8:	0007c483          	lbu	s1,0(a5)
     dec:	24048763          	beqz	s1,103a <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
     df0:	0004879b          	sext.w	a5,s1
    if(state == 0){
     df4:	fe0993e3          	bnez	s3,dda <vprintf+0x40>
      if(c0 == '%'){
     df8:	fd579ce3          	bne	a5,s5,dd0 <vprintf+0x36>
        state = '%';
     dfc:	89be                	mv	s3,a5
     dfe:	b7c5                	j	dde <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
     e00:	00ea06b3          	add	a3,s4,a4
     e04:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
     e08:	24060563          	beqz	a2,1052 <vprintf+0x2b8>
      if(c0 == 'd'){
     e0c:	0b878763          	beq	a5,s8,eba <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     e10:	f9478693          	addi	a3,a5,-108
     e14:	0016b693          	seqz	a3,a3
     e18:	f9c60593          	addi	a1,a2,-100
     e1c:	0015b593          	seqz	a1,a1
     e20:	8df5                	and	a1,a1,a3
     e22:	e9c5                	bnez	a1,ed2 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
     e24:	9752                	add	a4,a4,s4
     e26:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     e2a:	f9460713          	addi	a4,a2,-108
     e2e:	00173713          	seqz	a4,a4
     e32:	8f75                	and	a4,a4,a3
     e34:	f9c50593          	addi	a1,a0,-100
     e38:	0015b593          	seqz	a1,a1
     e3c:	8df9                	and	a1,a1,a4
     e3e:	e5dd                	bnez	a1,eec <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     e40:	07500593          	li	a1,117
     e44:	0cb78163          	beq	a5,a1,f06 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
     e48:	f8b60593          	addi	a1,a2,-117
     e4c:	0015b593          	seqz	a1,a1
     e50:	8df5                	and	a1,a1,a3
     e52:	e5f1                	bnez	a1,f1e <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     e54:	f8b50593          	addi	a1,a0,-117
     e58:	0015b593          	seqz	a1,a1
     e5c:	8df9                	and	a1,a1,a4
     e5e:	ede9                	bnez	a1,f38 <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     e60:	07800593          	li	a1,120
     e64:	0eb78763          	beq	a5,a1,f52 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
     e68:	f8860613          	addi	a2,a2,-120
     e6c:	00163613          	seqz	a2,a2
     e70:	8ef1                	and	a3,a3,a2
     e72:	0e069c63          	bnez	a3,f6a <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     e76:	f8850513          	addi	a0,a0,-120
     e7a:	00153513          	seqz	a0,a0
     e7e:	8f69                	and	a4,a4,a0
     e80:	10071263          	bnez	a4,f84 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     e84:	07000713          	li	a4,112
     e88:	10e78a63          	beq	a5,a4,f9c <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
     e8c:	06300713          	li	a4,99
     e90:	14e78a63          	beq	a5,a4,fe4 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
     e94:	07300713          	li	a4,115
     e98:	16e78063          	beq	a5,a4,ff8 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     e9c:	02500713          	li	a4,37
     ea0:	18e78863          	beq	a5,a4,1030 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     ea4:	02500593          	li	a1,37
     ea8:	855a                	mv	a0,s6
     eaa:	e2bff0ef          	jal	cd4 <putc>
        putc(fd, c0);
     eae:	85a6                	mv	a1,s1
     eb0:	855a                	mv	a0,s6
     eb2:	e23ff0ef          	jal	cd4 <putc>
      }

      state = 0;
     eb6:	4981                	li	s3,0
     eb8:	b71d                	j	dde <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
     eba:	008b8493          	addi	s1,s7,8
     ebe:	4685                	li	a3,1
     ec0:	4629                	li	a2,10
     ec2:	000ba583          	lw	a1,0(s7)
     ec6:	855a                	mv	a0,s6
     ec8:	e2bff0ef          	jal	cf2 <printint>
     ecc:	8ba6                	mv	s7,s1
      state = 0;
     ece:	4981                	li	s3,0
     ed0:	b739                	j	dde <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
     ed2:	008b8493          	addi	s1,s7,8
     ed6:	4685                	li	a3,1
     ed8:	4629                	li	a2,10
     eda:	000bb583          	ld	a1,0(s7)
     ede:	855a                	mv	a0,s6
     ee0:	e13ff0ef          	jal	cf2 <printint>
        i += 1;
     ee4:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     ee6:	8ba6                	mv	s7,s1
      state = 0;
     ee8:	4981                	li	s3,0
     eea:	bdd5                	j	dde <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
     eec:	008b8493          	addi	s1,s7,8
     ef0:	4685                	li	a3,1
     ef2:	4629                	li	a2,10
     ef4:	000bb583          	ld	a1,0(s7)
     ef8:	855a                	mv	a0,s6
     efa:	df9ff0ef          	jal	cf2 <printint>
        i += 2;
     efe:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     f00:	8ba6                	mv	s7,s1
      state = 0;
     f02:	4981                	li	s3,0
        i += 2;
     f04:	bde9                	j	dde <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
     f06:	008b8493          	addi	s1,s7,8
     f0a:	4681                	li	a3,0
     f0c:	4629                	li	a2,10
     f0e:	000be583          	lwu	a1,0(s7)
     f12:	855a                	mv	a0,s6
     f14:	ddfff0ef          	jal	cf2 <printint>
     f18:	8ba6                	mv	s7,s1
      state = 0;
     f1a:	4981                	li	s3,0
     f1c:	b5c9                	j	dde <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
     f1e:	008b8493          	addi	s1,s7,8
     f22:	4681                	li	a3,0
     f24:	4629                	li	a2,10
     f26:	000bb583          	ld	a1,0(s7)
     f2a:	855a                	mv	a0,s6
     f2c:	dc7ff0ef          	jal	cf2 <printint>
        i += 1;
     f30:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     f32:	8ba6                	mv	s7,s1
      state = 0;
     f34:	4981                	li	s3,0
     f36:	b565                	j	dde <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
     f38:	008b8493          	addi	s1,s7,8
     f3c:	4681                	li	a3,0
     f3e:	4629                	li	a2,10
     f40:	000bb583          	ld	a1,0(s7)
     f44:	855a                	mv	a0,s6
     f46:	dadff0ef          	jal	cf2 <printint>
        i += 2;
     f4a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
     f4c:	8ba6                	mv	s7,s1
      state = 0;
     f4e:	4981                	li	s3,0
        i += 2;
     f50:	b579                	j	dde <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
     f52:	008b8493          	addi	s1,s7,8
     f56:	4681                	li	a3,0
     f58:	4641                	li	a2,16
     f5a:	000be583          	lwu	a1,0(s7)
     f5e:	855a                	mv	a0,s6
     f60:	d93ff0ef          	jal	cf2 <printint>
     f64:	8ba6                	mv	s7,s1
      state = 0;
     f66:	4981                	li	s3,0
     f68:	bd9d                	j	dde <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
     f6a:	008b8493          	addi	s1,s7,8
     f6e:	4681                	li	a3,0
     f70:	4641                	li	a2,16
     f72:	000bb583          	ld	a1,0(s7)
     f76:	855a                	mv	a0,s6
     f78:	d7bff0ef          	jal	cf2 <printint>
        i += 1;
     f7c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
     f7e:	8ba6                	mv	s7,s1
      state = 0;
     f80:	4981                	li	s3,0
     f82:	bdb1                	j	dde <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
     f84:	008b8493          	addi	s1,s7,8
     f88:	4641                	li	a2,16
     f8a:	000bb583          	ld	a1,0(s7)
     f8e:	855a                	mv	a0,s6
     f90:	d63ff0ef          	jal	cf2 <printint>
        i += 2;
     f94:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     f96:	8ba6                	mv	s7,s1
      state = 0;
     f98:	4981                	li	s3,0
        i += 2;
     f9a:	b591                	j	dde <vprintf+0x44>
     f9c:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
     f9e:	008b8793          	addi	a5,s7,8
     fa2:	8cbe                	mv	s9,a5
     fa4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     fa8:	03000593          	li	a1,48
     fac:	855a                	mv	a0,s6
     fae:	d27ff0ef          	jal	cd4 <putc>
  putc(fd, 'x');
     fb2:	07800593          	li	a1,120
     fb6:	855a                	mv	a0,s6
     fb8:	d1dff0ef          	jal	cd4 <putc>
     fbc:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     fbe:	00000b97          	auipc	s7,0x0
     fc2:	5f2b8b93          	addi	s7,s7,1522 # 15b0 <digits>
     fc6:	03c9d793          	srli	a5,s3,0x3c
     fca:	97de                	add	a5,a5,s7
     fcc:	0007c583          	lbu	a1,0(a5)
     fd0:	855a                	mv	a0,s6
     fd2:	d03ff0ef          	jal	cd4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     fd6:	0992                	slli	s3,s3,0x4
     fd8:	34fd                	addiw	s1,s1,-1
     fda:	f4f5                	bnez	s1,fc6 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
     fdc:	8be6                	mv	s7,s9
      state = 0;
     fde:	4981                	li	s3,0
     fe0:	6ca2                	ld	s9,8(sp)
     fe2:	bbf5                	j	dde <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
     fe4:	008b8493          	addi	s1,s7,8
     fe8:	000bc583          	lbu	a1,0(s7)
     fec:	855a                	mv	a0,s6
     fee:	ce7ff0ef          	jal	cd4 <putc>
     ff2:	8ba6                	mv	s7,s1
      state = 0;
     ff4:	4981                	li	s3,0
     ff6:	b3e5                	j	dde <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
     ff8:	008b8993          	addi	s3,s7,8
     ffc:	000bb483          	ld	s1,0(s7)
    1000:	cc91                	beqz	s1,101c <vprintf+0x282>
        for(; *s; s++)
    1002:	0004c583          	lbu	a1,0(s1)
    1006:	c195                	beqz	a1,102a <vprintf+0x290>
          putc(fd, *s);
    1008:	855a                	mv	a0,s6
    100a:	ccbff0ef          	jal	cd4 <putc>
        for(; *s; s++)
    100e:	0485                	addi	s1,s1,1
    1010:	0004c583          	lbu	a1,0(s1)
    1014:	f9f5                	bnez	a1,1008 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
    1016:	8bce                	mv	s7,s3
      state = 0;
    1018:	4981                	li	s3,0
    101a:	b3d1                	j	dde <vprintf+0x44>
          s = "(null)";
    101c:	00000497          	auipc	s1,0x0
    1020:	52c48493          	addi	s1,s1,1324 # 1548 <malloc+0x3fa>
        for(; *s; s++)
    1024:	02800593          	li	a1,40
    1028:	b7c5                	j	1008 <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
    102a:	8bce                	mv	s7,s3
      state = 0;
    102c:	4981                	li	s3,0
    102e:	bb45                	j	dde <vprintf+0x44>
        putc(fd, '%');
    1030:	85be                	mv	a1,a5
    1032:	855a                	mv	a0,s6
    1034:	ca1ff0ef          	jal	cd4 <putc>
    1038:	bdbd                	j	eb6 <vprintf+0x11c>
    103a:	6906                	ld	s2,64(sp)
    103c:	79e2                	ld	s3,56(sp)
    103e:	7a42                	ld	s4,48(sp)
    1040:	7aa2                	ld	s5,40(sp)
    1042:	7b02                	ld	s6,32(sp)
    1044:	6be2                	ld	s7,24(sp)
    1046:	6c42                	ld	s8,16(sp)
    }
  }
}
    1048:	60e6                	ld	ra,88(sp)
    104a:	6446                	ld	s0,80(sp)
    104c:	64a6                	ld	s1,72(sp)
    104e:	6125                	addi	sp,sp,96
    1050:	8082                	ret
      if(c0 == 'd'){
    1052:	06400713          	li	a4,100
    1056:	e6e782e3          	beq	a5,a4,eba <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
    105a:	f9478693          	addi	a3,a5,-108
    105e:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
    1062:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    1064:	4701                	li	a4,0
    1066:	bbe9                	j	e40 <vprintf+0xa6>

0000000000001068 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1068:	715d                	addi	sp,sp,-80
    106a:	ec06                	sd	ra,24(sp)
    106c:	e822                	sd	s0,16(sp)
    106e:	1000                	addi	s0,sp,32
    1070:	e010                	sd	a2,0(s0)
    1072:	e414                	sd	a3,8(s0)
    1074:	e818                	sd	a4,16(s0)
    1076:	ec1c                	sd	a5,24(s0)
    1078:	03043023          	sd	a6,32(s0)
    107c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1080:	8622                	mv	a2,s0
    1082:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1086:	d15ff0ef          	jal	d9a <vprintf>
}
    108a:	60e2                	ld	ra,24(sp)
    108c:	6442                	ld	s0,16(sp)
    108e:	6161                	addi	sp,sp,80
    1090:	8082                	ret

0000000000001092 <printf>:

void
printf(const char *fmt, ...)
{
    1092:	711d                	addi	sp,sp,-96
    1094:	ec06                	sd	ra,24(sp)
    1096:	e822                	sd	s0,16(sp)
    1098:	1000                	addi	s0,sp,32
    109a:	e40c                	sd	a1,8(s0)
    109c:	e810                	sd	a2,16(s0)
    109e:	ec14                	sd	a3,24(s0)
    10a0:	f018                	sd	a4,32(s0)
    10a2:	f41c                	sd	a5,40(s0)
    10a4:	03043823          	sd	a6,48(s0)
    10a8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    10ac:	00840613          	addi	a2,s0,8
    10b0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    10b4:	85aa                	mv	a1,a0
    10b6:	4505                	li	a0,1
    10b8:	ce3ff0ef          	jal	d9a <vprintf>
}
    10bc:	60e2                	ld	ra,24(sp)
    10be:	6442                	ld	s0,16(sp)
    10c0:	6125                	addi	sp,sp,96
    10c2:	8082                	ret

00000000000010c4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    10c4:	1141                	addi	sp,sp,-16
    10c6:	e406                	sd	ra,8(sp)
    10c8:	e022                	sd	s0,0(sp)
    10ca:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    10cc:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10d0:	00001797          	auipc	a5,0x1
    10d4:	f407b783          	ld	a5,-192(a5) # 2010 <freep>
    10d8:	a095                	j	113c <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    10da:	ff852583          	lw	a1,-8(a0)
    10de:	6390                	ld	a2,0(a5)
    10e0:	02059813          	slli	a6,a1,0x20
    10e4:	01c85693          	srli	a3,a6,0x1c
    10e8:	96ba                	add	a3,a3,a4
    10ea:	02d60563          	beq	a2,a3,1114 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    10ee:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    10f2:	4790                	lw	a2,8(a5)
    10f4:	02061593          	slli	a1,a2,0x20
    10f8:	01c5d693          	srli	a3,a1,0x1c
    10fc:	96be                	add	a3,a3,a5
    10fe:	02d70263          	beq	a4,a3,1122 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    1102:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1104:	00001717          	auipc	a4,0x1
    1108:	f0f73623          	sd	a5,-244(a4) # 2010 <freep>
}
    110c:	60a2                	ld	ra,8(sp)
    110e:	6402                	ld	s0,0(sp)
    1110:	0141                	addi	sp,sp,16
    1112:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
    1114:	4614                	lw	a3,8(a2)
    1116:	9ead                	addw	a3,a3,a1
    1118:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    111c:	6394                	ld	a3,0(a5)
    111e:	6290                	ld	a2,0(a3)
    1120:	b7f9                	j	10ee <free+0x2a>
    p->s.size += bp->s.size;
    1122:	ff852703          	lw	a4,-8(a0)
    1126:	9f31                	addw	a4,a4,a2
    1128:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    112a:	ff053703          	ld	a4,-16(a0)
    112e:	bfd1                	j	1102 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1130:	6394                	ld	a3,0(a5)
    1132:	00d7e463          	bltu	a5,a3,113a <free+0x76>
    1136:	fad762e3          	bltu	a4,a3,10da <free+0x16>
    113a:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    113c:	fee7fae3          	bgeu	a5,a4,1130 <free+0x6c>
    1140:	6394                	ld	a3,0(a5)
    1142:	f8d76ce3          	bltu	a4,a3,10da <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1146:	f8d7fae3          	bgeu	a5,a3,10da <free+0x16>
    114a:	87b6                	mv	a5,a3
    114c:	bfc5                	j	113c <free+0x78>

000000000000114e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    114e:	7139                	addi	sp,sp,-64
    1150:	fc06                	sd	ra,56(sp)
    1152:	f822                	sd	s0,48(sp)
    1154:	f04a                	sd	s2,32(sp)
    1156:	ec4e                	sd	s3,24(sp)
    1158:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    115a:	02051993          	slli	s3,a0,0x20
    115e:	0209d993          	srli	s3,s3,0x20
    1162:	09bd                	addi	s3,s3,15
    1164:	0049d993          	srli	s3,s3,0x4
    1168:	2985                	addiw	s3,s3,1
    116a:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
    116c:	00001517          	auipc	a0,0x1
    1170:	ea453503          	ld	a0,-348(a0) # 2010 <freep>
    1174:	c905                	beqz	a0,11a4 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1176:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1178:	4798                	lw	a4,8(a5)
    117a:	09377663          	bgeu	a4,s3,1206 <malloc+0xb8>
    117e:	f426                	sd	s1,40(sp)
    1180:	e852                	sd	s4,16(sp)
    1182:	e456                	sd	s5,8(sp)
    1184:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    1186:	8a4e                	mv	s4,s3
    1188:	6705                	lui	a4,0x1
    118a:	00e9f363          	bgeu	s3,a4,1190 <malloc+0x42>
    118e:	6a05                	lui	s4,0x1
    1190:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1194:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1198:	00001497          	auipc	s1,0x1
    119c:	e7848493          	addi	s1,s1,-392 # 2010 <freep>
  if(p == SBRK_ERROR)
    11a0:	5afd                	li	s5,-1
    11a2:	a83d                	j	11e0 <malloc+0x92>
    11a4:	f426                	sd	s1,40(sp)
    11a6:	e852                	sd	s4,16(sp)
    11a8:	e456                	sd	s5,8(sp)
    11aa:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    11ac:	00001797          	auipc	a5,0x1
    11b0:	25c78793          	addi	a5,a5,604 # 2408 <base>
    11b4:	00001717          	auipc	a4,0x1
    11b8:	e4f73e23          	sd	a5,-420(a4) # 2010 <freep>
    11bc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    11be:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    11c2:	b7d1                	j	1186 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    11c4:	6398                	ld	a4,0(a5)
    11c6:	e118                	sd	a4,0(a0)
    11c8:	a899                	j	121e <malloc+0xd0>
  hp->s.size = nu;
    11ca:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    11ce:	0541                	addi	a0,a0,16
    11d0:	ef5ff0ef          	jal	10c4 <free>
  return freep;
    11d4:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    11d6:	c125                	beqz	a0,1236 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11d8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    11da:	4798                	lw	a4,8(a5)
    11dc:	03277163          	bgeu	a4,s2,11fe <malloc+0xb0>
    if(p == freep)
    11e0:	6098                	ld	a4,0(s1)
    11e2:	853e                	mv	a0,a5
    11e4:	fef71ae3          	bne	a4,a5,11d8 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
    11e8:	8552                	mv	a0,s4
    11ea:	a17ff0ef          	jal	c00 <sbrk>
  if(p == SBRK_ERROR)
    11ee:	fd551ee3          	bne	a0,s5,11ca <malloc+0x7c>
        return 0;
    11f2:	4501                	li	a0,0
    11f4:	74a2                	ld	s1,40(sp)
    11f6:	6a42                	ld	s4,16(sp)
    11f8:	6aa2                	ld	s5,8(sp)
    11fa:	6b02                	ld	s6,0(sp)
    11fc:	a03d                	j	122a <malloc+0xdc>
    11fe:	74a2                	ld	s1,40(sp)
    1200:	6a42                	ld	s4,16(sp)
    1202:	6aa2                	ld	s5,8(sp)
    1204:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    1206:	fae90fe3          	beq	s2,a4,11c4 <malloc+0x76>
        p->s.size -= nunits;
    120a:	4137073b          	subw	a4,a4,s3
    120e:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1210:	02071693          	slli	a3,a4,0x20
    1214:	01c6d713          	srli	a4,a3,0x1c
    1218:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    121a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    121e:	00001717          	auipc	a4,0x1
    1222:	dea73923          	sd	a0,-526(a4) # 2010 <freep>
      return (void*)(p + 1);
    1226:	01078513          	addi	a0,a5,16
  }
}
    122a:	70e2                	ld	ra,56(sp)
    122c:	7442                	ld	s0,48(sp)
    122e:	7902                	ld	s2,32(sp)
    1230:	69e2                	ld	s3,24(sp)
    1232:	6121                	addi	sp,sp,64
    1234:	8082                	ret
    1236:	74a2                	ld	s1,40(sp)
    1238:	6a42                	ld	s4,16(sp)
    123a:	6aa2                	ld	s5,8(sp)
    123c:	6b02                	ld	s6,0(sp)
    123e:	b7f5                	j	122a <malloc+0xdc>
