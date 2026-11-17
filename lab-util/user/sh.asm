
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	e04a                	sd	s2,0(sp)
       a:	1000                	addi	s0,sp,32
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
  write(2, "$ ", 2);
      10:	4609                	li	a2,2
      12:	00001597          	auipc	a1,0x1
      16:	28e58593          	addi	a1,a1,654 # 12a0 <malloc+0x100>
      1a:	8532                	mv	a0,a2
      1c:	48b000ef          	jal	ca6 <write>
  memset(buf, 0, nbuf);
      20:	864a                	mv	a2,s2
      22:	4581                	li	a1,0
      24:	8526                	mv	a0,s1
      26:	237000ef          	jal	a5c <memset>
  gets(buf, nbuf);
      2a:	85ca                	mv	a1,s2
      2c:	8526                	mv	a0,s1
      2e:	279000ef          	jal	aa6 <gets>
  if(buf[0] == 0) // EOF
      32:	0004c503          	lbu	a0,0(s1)
      36:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
      3a:	40a0053b          	negw	a0,a0
      3e:	60e2                	ld	ra,24(sp)
      40:	6442                	ld	s0,16(sp)
      42:	64a2                	ld	s1,8(sp)
      44:	6902                	ld	s2,0(sp)
      46:	6105                	addi	sp,sp,32
      48:	8082                	ret

000000000000004a <panic>:
  exit(0);
}

void
panic(char *s)
{
      4a:	1141                	addi	sp,sp,-16
      4c:	e406                	sd	ra,8(sp)
      4e:	e022                	sd	s0,0(sp)
      50:	0800                	addi	s0,sp,16
      52:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
      54:	00001597          	auipc	a1,0x1
      58:	25c58593          	addi	a1,a1,604 # 12b0 <malloc+0x110>
      5c:	4509                	li	a0,2
      5e:	05c010ef          	jal	10ba <fprintf>
  exit(1);
      62:	4505                	li	a0,1
      64:	423000ef          	jal	c86 <exit>

0000000000000068 <fork1>:
}

int
fork1(void)
{
      68:	1141                	addi	sp,sp,-16
      6a:	e406                	sd	ra,8(sp)
      6c:	e022                	sd	s0,0(sp)
      6e:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
      70:	40f000ef          	jal	c7e <fork>
  if(pid == -1)
      74:	57fd                	li	a5,-1
      76:	00f50663          	beq	a0,a5,82 <fork1+0x1a>
    panic("fork");
  return pid;
}
      7a:	60a2                	ld	ra,8(sp)
      7c:	6402                	ld	s0,0(sp)
      7e:	0141                	addi	sp,sp,16
      80:	8082                	ret
    panic("fork");
      82:	00001517          	auipc	a0,0x1
      86:	23650513          	addi	a0,a0,566 # 12b8 <malloc+0x118>
      8a:	fc1ff0ef          	jal	4a <panic>

000000000000008e <runcmd>:
{
      8e:	7179                	addi	sp,sp,-48
      90:	f406                	sd	ra,40(sp)
      92:	f022                	sd	s0,32(sp)
      94:	1800                	addi	s0,sp,48
  if(cmd == 0)
      96:	c115                	beqz	a0,ba <runcmd+0x2c>
      98:	ec26                	sd	s1,24(sp)
      9a:	84aa                	mv	s1,a0
  switch(cmd->type){
      9c:	4118                	lw	a4,0(a0)
      9e:	4795                	li	a5,5
      a0:	02e7e163          	bltu	a5,a4,c2 <runcmd+0x34>
      a4:	00056783          	lwu	a5,0(a0)
      a8:	078a                	slli	a5,a5,0x2
      aa:	00001717          	auipc	a4,0x1
      ae:	30e70713          	addi	a4,a4,782 # 13b8 <malloc+0x218>
      b2:	97ba                	add	a5,a5,a4
      b4:	439c                	lw	a5,0(a5)
      b6:	97ba                	add	a5,a5,a4
      b8:	8782                	jr	a5
      ba:	ec26                	sd	s1,24(sp)
    exit(1);
      bc:	4505                	li	a0,1
      be:	3c9000ef          	jal	c86 <exit>
    panic("runcmd");
      c2:	00001517          	auipc	a0,0x1
      c6:	1fe50513          	addi	a0,a0,510 # 12c0 <malloc+0x120>
      ca:	f81ff0ef          	jal	4a <panic>
    if(ecmd->argv[0] == 0)
      ce:	6508                	ld	a0,8(a0)
      d0:	c105                	beqz	a0,f0 <runcmd+0x62>
    exec(ecmd->argv[0], ecmd->argv);
      d2:	00848593          	addi	a1,s1,8
      d6:	3e9000ef          	jal	cbe <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
      da:	6490                	ld	a2,8(s1)
      dc:	00001597          	auipc	a1,0x1
      e0:	1ec58593          	addi	a1,a1,492 # 12c8 <malloc+0x128>
      e4:	4509                	li	a0,2
      e6:	7d5000ef          	jal	10ba <fprintf>
  exit(0);
      ea:	4501                	li	a0,0
      ec:	39b000ef          	jal	c86 <exit>
      exit(1);
      f0:	4505                	li	a0,1
      f2:	395000ef          	jal	c86 <exit>
    close(rcmd->fd);
      f6:	5148                	lw	a0,36(a0)
      f8:	3b7000ef          	jal	cae <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      fc:	508c                	lw	a1,32(s1)
      fe:	6888                	ld	a0,16(s1)
     100:	3c7000ef          	jal	cc6 <open>
     104:	00054563          	bltz	a0,10e <runcmd+0x80>
    runcmd(rcmd->cmd);
     108:	6488                	ld	a0,8(s1)
     10a:	f85ff0ef          	jal	8e <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     10e:	6890                	ld	a2,16(s1)
     110:	00001597          	auipc	a1,0x1
     114:	1c858593          	addi	a1,a1,456 # 12d8 <malloc+0x138>
     118:	4509                	li	a0,2
     11a:	7a1000ef          	jal	10ba <fprintf>
      exit(1);
     11e:	4505                	li	a0,1
     120:	367000ef          	jal	c86 <exit>
    if(fork1() == 0)
     124:	f45ff0ef          	jal	68 <fork1>
     128:	e501                	bnez	a0,130 <runcmd+0xa2>
      runcmd(lcmd->left);
     12a:	6488                	ld	a0,8(s1)
     12c:	f63ff0ef          	jal	8e <runcmd>
    wait(0);
     130:	4501                	li	a0,0
     132:	35d000ef          	jal	c8e <wait>
    runcmd(lcmd->right);
     136:	6888                	ld	a0,16(s1)
     138:	f57ff0ef          	jal	8e <runcmd>
    if(pipe(p) < 0)
     13c:	fd840513          	addi	a0,s0,-40
     140:	357000ef          	jal	c96 <pipe>
     144:	02054763          	bltz	a0,172 <runcmd+0xe4>
    if(fork1() == 0){
     148:	f21ff0ef          	jal	68 <fork1>
     14c:	e90d                	bnez	a0,17e <runcmd+0xf0>
      close(1);
     14e:	4505                	li	a0,1
     150:	35f000ef          	jal	cae <close>
      dup(p[1]);
     154:	fdc42503          	lw	a0,-36(s0)
     158:	3a7000ef          	jal	cfe <dup>
      close(p[0]);
     15c:	fd842503          	lw	a0,-40(s0)
     160:	34f000ef          	jal	cae <close>
      close(p[1]);
     164:	fdc42503          	lw	a0,-36(s0)
     168:	347000ef          	jal	cae <close>
      runcmd(pcmd->left);
     16c:	6488                	ld	a0,8(s1)
     16e:	f21ff0ef          	jal	8e <runcmd>
      panic("pipe");
     172:	00001517          	auipc	a0,0x1
     176:	17650513          	addi	a0,a0,374 # 12e8 <malloc+0x148>
     17a:	ed1ff0ef          	jal	4a <panic>
    if(fork1() == 0){
     17e:	eebff0ef          	jal	68 <fork1>
     182:	e115                	bnez	a0,1a6 <runcmd+0x118>
      close(0);
     184:	32b000ef          	jal	cae <close>
      dup(p[0]);
     188:	fd842503          	lw	a0,-40(s0)
     18c:	373000ef          	jal	cfe <dup>
      close(p[0]);
     190:	fd842503          	lw	a0,-40(s0)
     194:	31b000ef          	jal	cae <close>
      close(p[1]);
     198:	fdc42503          	lw	a0,-36(s0)
     19c:	313000ef          	jal	cae <close>
      runcmd(pcmd->right);
     1a0:	6888                	ld	a0,16(s1)
     1a2:	eedff0ef          	jal	8e <runcmd>
    close(p[0]);
     1a6:	fd842503          	lw	a0,-40(s0)
     1aa:	305000ef          	jal	cae <close>
    close(p[1]);
     1ae:	fdc42503          	lw	a0,-36(s0)
     1b2:	2fd000ef          	jal	cae <close>
    wait(0);
     1b6:	4501                	li	a0,0
     1b8:	2d7000ef          	jal	c8e <wait>
    wait(0);
     1bc:	4501                	li	a0,0
     1be:	2d1000ef          	jal	c8e <wait>
    break;
     1c2:	b725                	j	ea <runcmd+0x5c>
    if(fork1() == 0)
     1c4:	ea5ff0ef          	jal	68 <fork1>
     1c8:	f20511e3          	bnez	a0,ea <runcmd+0x5c>
      runcmd(bcmd->cmd);
     1cc:	6488                	ld	a0,8(s1)
     1ce:	ec1ff0ef          	jal	8e <runcmd>

00000000000001d2 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     1d2:	1101                	addi	sp,sp,-32
     1d4:	ec06                	sd	ra,24(sp)
     1d6:	e822                	sd	s0,16(sp)
     1d8:	e426                	sd	s1,8(sp)
     1da:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     1dc:	0a800513          	li	a0,168
     1e0:	7c1000ef          	jal	11a0 <malloc>
     1e4:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     1e6:	0a800613          	li	a2,168
     1ea:	4581                	li	a1,0
     1ec:	071000ef          	jal	a5c <memset>
  cmd->type = EXEC;
     1f0:	4785                	li	a5,1
     1f2:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     1f4:	8526                	mv	a0,s1
     1f6:	60e2                	ld	ra,24(sp)
     1f8:	6442                	ld	s0,16(sp)
     1fa:	64a2                	ld	s1,8(sp)
     1fc:	6105                	addi	sp,sp,32
     1fe:	8082                	ret

0000000000000200 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     200:	7139                	addi	sp,sp,-64
     202:	fc06                	sd	ra,56(sp)
     204:	f822                	sd	s0,48(sp)
     206:	f426                	sd	s1,40(sp)
     208:	f04a                	sd	s2,32(sp)
     20a:	ec4e                	sd	s3,24(sp)
     20c:	e852                	sd	s4,16(sp)
     20e:	e456                	sd	s5,8(sp)
     210:	e05a                	sd	s6,0(sp)
     212:	0080                	addi	s0,sp,64
     214:	892a                	mv	s2,a0
     216:	89ae                	mv	s3,a1
     218:	8a32                	mv	s4,a2
     21a:	8ab6                	mv	s5,a3
     21c:	8b3a                	mv	s6,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     21e:	02800513          	li	a0,40
     222:	77f000ef          	jal	11a0 <malloc>
     226:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     228:	02800613          	li	a2,40
     22c:	4581                	li	a1,0
     22e:	02f000ef          	jal	a5c <memset>
  cmd->type = REDIR;
     232:	4789                	li	a5,2
     234:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     236:	0124b423          	sd	s2,8(s1)
  cmd->file = file;
     23a:	0134b823          	sd	s3,16(s1)
  cmd->efile = efile;
     23e:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     242:	0354a023          	sw	s5,32(s1)
  cmd->fd = fd;
     246:	0364a223          	sw	s6,36(s1)
  return (struct cmd*)cmd;
}
     24a:	8526                	mv	a0,s1
     24c:	70e2                	ld	ra,56(sp)
     24e:	7442                	ld	s0,48(sp)
     250:	74a2                	ld	s1,40(sp)
     252:	7902                	ld	s2,32(sp)
     254:	69e2                	ld	s3,24(sp)
     256:	6a42                	ld	s4,16(sp)
     258:	6aa2                	ld	s5,8(sp)
     25a:	6b02                	ld	s6,0(sp)
     25c:	6121                	addi	sp,sp,64
     25e:	8082                	ret

0000000000000260 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     260:	7179                	addi	sp,sp,-48
     262:	f406                	sd	ra,40(sp)
     264:	f022                	sd	s0,32(sp)
     266:	ec26                	sd	s1,24(sp)
     268:	e84a                	sd	s2,16(sp)
     26a:	e44e                	sd	s3,8(sp)
     26c:	1800                	addi	s0,sp,48
     26e:	892a                	mv	s2,a0
     270:	89ae                	mv	s3,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     272:	4561                	li	a0,24
     274:	72d000ef          	jal	11a0 <malloc>
     278:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     27a:	4661                	li	a2,24
     27c:	4581                	li	a1,0
     27e:	7de000ef          	jal	a5c <memset>
  cmd->type = PIPE;
     282:	478d                	li	a5,3
     284:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     286:	0124b423          	sd	s2,8(s1)
  cmd->right = right;
     28a:	0134b823          	sd	s3,16(s1)
  return (struct cmd*)cmd;
}
     28e:	8526                	mv	a0,s1
     290:	70a2                	ld	ra,40(sp)
     292:	7402                	ld	s0,32(sp)
     294:	64e2                	ld	s1,24(sp)
     296:	6942                	ld	s2,16(sp)
     298:	69a2                	ld	s3,8(sp)
     29a:	6145                	addi	sp,sp,48
     29c:	8082                	ret

000000000000029e <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     29e:	7179                	addi	sp,sp,-48
     2a0:	f406                	sd	ra,40(sp)
     2a2:	f022                	sd	s0,32(sp)
     2a4:	ec26                	sd	s1,24(sp)
     2a6:	e84a                	sd	s2,16(sp)
     2a8:	e44e                	sd	s3,8(sp)
     2aa:	1800                	addi	s0,sp,48
     2ac:	892a                	mv	s2,a0
     2ae:	89ae                	mv	s3,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2b0:	4561                	li	a0,24
     2b2:	6ef000ef          	jal	11a0 <malloc>
     2b6:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2b8:	4661                	li	a2,24
     2ba:	4581                	li	a1,0
     2bc:	7a0000ef          	jal	a5c <memset>
  cmd->type = LIST;
     2c0:	4791                	li	a5,4
     2c2:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     2c4:	0124b423          	sd	s2,8(s1)
  cmd->right = right;
     2c8:	0134b823          	sd	s3,16(s1)
  return (struct cmd*)cmd;
}
     2cc:	8526                	mv	a0,s1
     2ce:	70a2                	ld	ra,40(sp)
     2d0:	7402                	ld	s0,32(sp)
     2d2:	64e2                	ld	s1,24(sp)
     2d4:	6942                	ld	s2,16(sp)
     2d6:	69a2                	ld	s3,8(sp)
     2d8:	6145                	addi	sp,sp,48
     2da:	8082                	ret

00000000000002dc <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     2dc:	1101                	addi	sp,sp,-32
     2de:	ec06                	sd	ra,24(sp)
     2e0:	e822                	sd	s0,16(sp)
     2e2:	e426                	sd	s1,8(sp)
     2e4:	e04a                	sd	s2,0(sp)
     2e6:	1000                	addi	s0,sp,32
     2e8:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2ea:	4541                	li	a0,16
     2ec:	6b5000ef          	jal	11a0 <malloc>
     2f0:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2f2:	4641                	li	a2,16
     2f4:	4581                	li	a1,0
     2f6:	766000ef          	jal	a5c <memset>
  cmd->type = BACK;
     2fa:	4795                	li	a5,5
     2fc:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     2fe:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     302:	8526                	mv	a0,s1
     304:	60e2                	ld	ra,24(sp)
     306:	6442                	ld	s0,16(sp)
     308:	64a2                	ld	s1,8(sp)
     30a:	6902                	ld	s2,0(sp)
     30c:	6105                	addi	sp,sp,32
     30e:	8082                	ret

0000000000000310 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     310:	7139                	addi	sp,sp,-64
     312:	fc06                	sd	ra,56(sp)
     314:	f822                	sd	s0,48(sp)
     316:	f426                	sd	s1,40(sp)
     318:	f04a                	sd	s2,32(sp)
     31a:	ec4e                	sd	s3,24(sp)
     31c:	e852                	sd	s4,16(sp)
     31e:	e456                	sd	s5,8(sp)
     320:	e05a                	sd	s6,0(sp)
     322:	0080                	addi	s0,sp,64
     324:	8a2a                	mv	s4,a0
     326:	892e                	mv	s2,a1
     328:	8ab2                	mv	s5,a2
     32a:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     32c:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     32e:	00002997          	auipc	s3,0x2
     332:	cda98993          	addi	s3,s3,-806 # 2008 <whitespace>
     336:	00b4fc63          	bgeu	s1,a1,34e <gettoken+0x3e>
     33a:	0004c583          	lbu	a1,0(s1)
     33e:	854e                	mv	a0,s3
     340:	742000ef          	jal	a82 <strchr>
     344:	c509                	beqz	a0,34e <gettoken+0x3e>
    s++;
     346:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     348:	fe9919e3          	bne	s2,s1,33a <gettoken+0x2a>
     34c:	84ca                	mv	s1,s2
  if(q)
     34e:	000a8463          	beqz	s5,356 <gettoken+0x46>
    *q = s;
     352:	009ab023          	sd	s1,0(s5)
  ret = *s;
     356:	0004c783          	lbu	a5,0(s1)
     35a:	00078a9b          	sext.w	s5,a5
  switch(*s){
     35e:	03c00713          	li	a4,60
     362:	08f76e63          	bltu	a4,a5,3fe <gettoken+0xee>
     366:	02500713          	li	a4,37
     36a:	04f76363          	bltu	a4,a5,3b0 <gettoken+0xa0>
     36e:	eba9                	bnez	a5,3c0 <gettoken+0xb0>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     370:	000b0463          	beqz	s6,378 <gettoken+0x68>
    *eq = s;
     374:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     378:	0124ff63          	bgeu	s1,s2,396 <gettoken+0x86>
     37c:	00002997          	auipc	s3,0x2
     380:	c8c98993          	addi	s3,s3,-884 # 2008 <whitespace>
     384:	0004c583          	lbu	a1,0(s1)
     388:	854e                	mv	a0,s3
     38a:	6f8000ef          	jal	a82 <strchr>
     38e:	c501                	beqz	a0,396 <gettoken+0x86>
    s++;
     390:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     392:	fe9919e3          	bne	s2,s1,384 <gettoken+0x74>
  *ps = s;
     396:	009a3023          	sd	s1,0(s4)
  return ret;
}
     39a:	8556                	mv	a0,s5
     39c:	70e2                	ld	ra,56(sp)
     39e:	7442                	ld	s0,48(sp)
     3a0:	74a2                	ld	s1,40(sp)
     3a2:	7902                	ld	s2,32(sp)
     3a4:	69e2                	ld	s3,24(sp)
     3a6:	6a42                	ld	s4,16(sp)
     3a8:	6aa2                	ld	s5,8(sp)
     3aa:	6b02                	ld	s6,0(sp)
     3ac:	6121                	addi	sp,sp,64
     3ae:	8082                	ret
  switch(*s){
     3b0:	00600737          	lui	a4,0x600
     3b4:	0735                	addi	a4,a4,13 # 60000d <base+0x5fdf85>
     3b6:	171a                	slli	a4,a4,0x26
     3b8:	00f757b3          	srl	a5,a4,a5
     3bc:	8b85                	andi	a5,a5,1
     3be:	e3ad                	bnez	a5,420 <gettoken+0x110>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     3c0:	00002997          	auipc	s3,0x2
     3c4:	c4898993          	addi	s3,s3,-952 # 2008 <whitespace>
     3c8:	00002a97          	auipc	s5,0x2
     3cc:	c38a8a93          	addi	s5,s5,-968 # 2000 <symbols>
     3d0:	0724f163          	bgeu	s1,s2,432 <gettoken+0x122>
     3d4:	0004c583          	lbu	a1,0(s1)
     3d8:	854e                	mv	a0,s3
     3da:	6a8000ef          	jal	a82 <strchr>
     3de:	e539                	bnez	a0,42c <gettoken+0x11c>
     3e0:	0004c583          	lbu	a1,0(s1)
     3e4:	8556                	mv	a0,s5
     3e6:	69c000ef          	jal	a82 <strchr>
     3ea:	e129                	bnez	a0,42c <gettoken+0x11c>
      s++;
     3ec:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     3ee:	fe9913e3          	bne	s2,s1,3d4 <gettoken+0xc4>
  if(eq)
     3f2:	84ca                	mv	s1,s2
    ret = 'a';
     3f4:	06100a93          	li	s5,97
  if(eq)
     3f8:	f60b1ee3          	bnez	s6,374 <gettoken+0x64>
     3fc:	bf69                	j	396 <gettoken+0x86>
  switch(*s){
     3fe:	03e00713          	li	a4,62
     402:	00e79b63          	bne	a5,a4,418 <gettoken+0x108>
    if(*s == '>'){
     406:	0014c703          	lbu	a4,1(s1)
     40a:	03e00793          	li	a5,62
     40e:	00f70b63          	beq	a4,a5,424 <gettoken+0x114>
    s++;
     412:	0485                	addi	s1,s1,1
  ret = *s;
     414:	8abe                	mv	s5,a5
     416:	bfa9                	j	370 <gettoken+0x60>
  switch(*s){
     418:	07c00713          	li	a4,124
     41c:	fae792e3          	bne	a5,a4,3c0 <gettoken+0xb0>
    s++;
     420:	0485                	addi	s1,s1,1
    break;
     422:	b7b9                	j	370 <gettoken+0x60>
      s++;
     424:	0489                	addi	s1,s1,2
      ret = '+';
     426:	02b00a93          	li	s5,43
     42a:	b799                	j	370 <gettoken+0x60>
    ret = 'a';
     42c:	06100a93          	li	s5,97
     430:	b781                	j	370 <gettoken+0x60>
     432:	06100a93          	li	s5,97
  if(eq)
     436:	f20b1fe3          	bnez	s6,374 <gettoken+0x64>
     43a:	bfb1                	j	396 <gettoken+0x86>

000000000000043c <peek>:

int
peek(char **ps, char *es, char *toks)
{
     43c:	7139                	addi	sp,sp,-64
     43e:	fc06                	sd	ra,56(sp)
     440:	f822                	sd	s0,48(sp)
     442:	f426                	sd	s1,40(sp)
     444:	f04a                	sd	s2,32(sp)
     446:	ec4e                	sd	s3,24(sp)
     448:	e852                	sd	s4,16(sp)
     44a:	e456                	sd	s5,8(sp)
     44c:	0080                	addi	s0,sp,64
     44e:	8a2a                	mv	s4,a0
     450:	892e                	mv	s2,a1
     452:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     454:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     456:	00002997          	auipc	s3,0x2
     45a:	bb298993          	addi	s3,s3,-1102 # 2008 <whitespace>
     45e:	00b4fc63          	bgeu	s1,a1,476 <peek+0x3a>
     462:	0004c583          	lbu	a1,0(s1)
     466:	854e                	mv	a0,s3
     468:	61a000ef          	jal	a82 <strchr>
     46c:	c509                	beqz	a0,476 <peek+0x3a>
    s++;
     46e:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     470:	fe9919e3          	bne	s2,s1,462 <peek+0x26>
     474:	84ca                	mv	s1,s2
  *ps = s;
     476:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     47a:	0004c583          	lbu	a1,0(s1)
     47e:	4501                	li	a0,0
     480:	e991                	bnez	a1,494 <peek+0x58>
}
     482:	70e2                	ld	ra,56(sp)
     484:	7442                	ld	s0,48(sp)
     486:	74a2                	ld	s1,40(sp)
     488:	7902                	ld	s2,32(sp)
     48a:	69e2                	ld	s3,24(sp)
     48c:	6a42                	ld	s4,16(sp)
     48e:	6aa2                	ld	s5,8(sp)
     490:	6121                	addi	sp,sp,64
     492:	8082                	ret
  return *s && strchr(toks, *s);
     494:	8556                	mv	a0,s5
     496:	5ec000ef          	jal	a82 <strchr>
     49a:	00a03533          	snez	a0,a0
     49e:	b7d5                	j	482 <peek+0x46>

00000000000004a0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     4a0:	7159                	addi	sp,sp,-112
     4a2:	f486                	sd	ra,104(sp)
     4a4:	f0a2                	sd	s0,96(sp)
     4a6:	eca6                	sd	s1,88(sp)
     4a8:	e8ca                	sd	s2,80(sp)
     4aa:	e4ce                	sd	s3,72(sp)
     4ac:	e0d2                	sd	s4,64(sp)
     4ae:	fc56                	sd	s5,56(sp)
     4b0:	f85a                	sd	s6,48(sp)
     4b2:	f45e                	sd	s7,40(sp)
     4b4:	f062                	sd	s8,32(sp)
     4b6:	ec66                	sd	s9,24(sp)
     4b8:	1880                	addi	s0,sp,112
     4ba:	8a2a                	mv	s4,a0
     4bc:	89ae                	mv	s3,a1
     4be:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     4c0:	00001b17          	auipc	s6,0x1
     4c4:	e50b0b13          	addi	s6,s6,-432 # 1310 <malloc+0x170>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     4c8:	f9040c93          	addi	s9,s0,-112
     4cc:	f9840c13          	addi	s8,s0,-104
     4d0:	06100b93          	li	s7,97
  while(peek(ps, es, "<>")){
     4d4:	a889                	j	526 <parseredirs+0x86>
      panic("missing file for redirection");
     4d6:	00001517          	auipc	a0,0x1
     4da:	e1a50513          	addi	a0,a0,-486 # 12f0 <malloc+0x150>
     4de:	b6dff0ef          	jal	4a <panic>
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     4e2:	4701                	li	a4,0
     4e4:	4681                	li	a3,0
     4e6:	f9043603          	ld	a2,-112(s0)
     4ea:	f9843583          	ld	a1,-104(s0)
     4ee:	8552                	mv	a0,s4
     4f0:	d11ff0ef          	jal	200 <redircmd>
     4f4:	8a2a                	mv	s4,a0
      break;
     4f6:	a805                	j	526 <parseredirs+0x86>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     4f8:	4705                	li	a4,1
     4fa:	60100693          	li	a3,1537
     4fe:	f9043603          	ld	a2,-112(s0)
     502:	f9843583          	ld	a1,-104(s0)
     506:	8552                	mv	a0,s4
     508:	cf9ff0ef          	jal	200 <redircmd>
     50c:	8a2a                	mv	s4,a0
      break;
     50e:	a821                	j	526 <parseredirs+0x86>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     510:	4705                	li	a4,1
     512:	20100693          	li	a3,513
     516:	f9043603          	ld	a2,-112(s0)
     51a:	f9843583          	ld	a1,-104(s0)
     51e:	8552                	mv	a0,s4
     520:	ce1ff0ef          	jal	200 <redircmd>
     524:	8a2a                	mv	s4,a0
    switch(tok){
     526:	03c00a93          	li	s5,60
  while(peek(ps, es, "<>")){
     52a:	865a                	mv	a2,s6
     52c:	85ca                	mv	a1,s2
     52e:	854e                	mv	a0,s3
     530:	f0dff0ef          	jal	43c <peek>
     534:	c91d                	beqz	a0,56a <parseredirs+0xca>
    tok = gettoken(ps, es, 0, 0);
     536:	4681                	li	a3,0
     538:	4601                	li	a2,0
     53a:	85ca                	mv	a1,s2
     53c:	854e                	mv	a0,s3
     53e:	dd3ff0ef          	jal	310 <gettoken>
     542:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     544:	86e6                	mv	a3,s9
     546:	8662                	mv	a2,s8
     548:	85ca                	mv	a1,s2
     54a:	854e                	mv	a0,s3
     54c:	dc5ff0ef          	jal	310 <gettoken>
     550:	f97513e3          	bne	a0,s7,4d6 <parseredirs+0x36>
    switch(tok){
     554:	f95487e3          	beq	s1,s5,4e2 <parseredirs+0x42>
     558:	03e00793          	li	a5,62
     55c:	f8f48ee3          	beq	s1,a5,4f8 <parseredirs+0x58>
     560:	02b00793          	li	a5,43
     564:	faf486e3          	beq	s1,a5,510 <parseredirs+0x70>
     568:	b7c9                	j	52a <parseredirs+0x8a>
      break;
    }
  }
  return cmd;
}
     56a:	8552                	mv	a0,s4
     56c:	70a6                	ld	ra,104(sp)
     56e:	7406                	ld	s0,96(sp)
     570:	64e6                	ld	s1,88(sp)
     572:	6946                	ld	s2,80(sp)
     574:	69a6                	ld	s3,72(sp)
     576:	6a06                	ld	s4,64(sp)
     578:	7ae2                	ld	s5,56(sp)
     57a:	7b42                	ld	s6,48(sp)
     57c:	7ba2                	ld	s7,40(sp)
     57e:	7c02                	ld	s8,32(sp)
     580:	6ce2                	ld	s9,24(sp)
     582:	6165                	addi	sp,sp,112
     584:	8082                	ret

0000000000000586 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     586:	7119                	addi	sp,sp,-128
     588:	fc86                	sd	ra,120(sp)
     58a:	f8a2                	sd	s0,112(sp)
     58c:	f4a6                	sd	s1,104(sp)
     58e:	e8d2                	sd	s4,80(sp)
     590:	e4d6                	sd	s5,72(sp)
     592:	0100                	addi	s0,sp,128
     594:	8a2a                	mv	s4,a0
     596:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     598:	00001617          	auipc	a2,0x1
     59c:	d8060613          	addi	a2,a2,-640 # 1318 <malloc+0x178>
     5a0:	e9dff0ef          	jal	43c <peek>
     5a4:	e121                	bnez	a0,5e4 <parseexec+0x5e>
     5a6:	f0ca                	sd	s2,96(sp)
     5a8:	ecce                	sd	s3,88(sp)
     5aa:	e0da                	sd	s6,64(sp)
     5ac:	fc5e                	sd	s7,56(sp)
     5ae:	f862                	sd	s8,48(sp)
     5b0:	f466                	sd	s9,40(sp)
     5b2:	f06a                	sd	s10,32(sp)
     5b4:	ec6e                	sd	s11,24(sp)
     5b6:	892a                	mv	s2,a0
    return parseblock(ps, es);

  ret = execcmd();
     5b8:	c1bff0ef          	jal	1d2 <execcmd>
     5bc:	89aa                	mv	s3,a0
     5be:	8daa                	mv	s11,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     5c0:	8656                	mv	a2,s5
     5c2:	85d2                	mv	a1,s4
     5c4:	eddff0ef          	jal	4a0 <parseredirs>
     5c8:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     5ca:	09a1                	addi	s3,s3,8
     5cc:	00001b17          	auipc	s6,0x1
     5d0:	d6cb0b13          	addi	s6,s6,-660 # 1338 <malloc+0x198>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     5d4:	f8040c13          	addi	s8,s0,-128
     5d8:	f8840b93          	addi	s7,s0,-120
      break;
    if(tok != 'a')
     5dc:	06100d13          	li	s10,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     5e0:	4ca9                	li	s9,10
  while(!peek(ps, es, "|)&;")){
     5e2:	a81d                	j	618 <parseexec+0x92>
    return parseblock(ps, es);
     5e4:	85d6                	mv	a1,s5
     5e6:	8552                	mv	a0,s4
     5e8:	178000ef          	jal	760 <parseblock>
     5ec:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     5ee:	8526                	mv	a0,s1
     5f0:	70e6                	ld	ra,120(sp)
     5f2:	7446                	ld	s0,112(sp)
     5f4:	74a6                	ld	s1,104(sp)
     5f6:	6a46                	ld	s4,80(sp)
     5f8:	6aa6                	ld	s5,72(sp)
     5fa:	6109                	addi	sp,sp,128
     5fc:	8082                	ret
      panic("syntax");
     5fe:	00001517          	auipc	a0,0x1
     602:	d2250513          	addi	a0,a0,-734 # 1320 <malloc+0x180>
     606:	a45ff0ef          	jal	4a <panic>
    if(argc >= MAXARGS)
     60a:	09a1                	addi	s3,s3,8
    ret = parseredirs(ret, ps, es);
     60c:	8656                	mv	a2,s5
     60e:	85d2                	mv	a1,s4
     610:	8526                	mv	a0,s1
     612:	e8fff0ef          	jal	4a0 <parseredirs>
     616:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     618:	865a                	mv	a2,s6
     61a:	85d6                	mv	a1,s5
     61c:	8552                	mv	a0,s4
     61e:	e1fff0ef          	jal	43c <peek>
     622:	e91d                	bnez	a0,658 <parseexec+0xd2>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     624:	86e2                	mv	a3,s8
     626:	865e                	mv	a2,s7
     628:	85d6                	mv	a1,s5
     62a:	8552                	mv	a0,s4
     62c:	ce5ff0ef          	jal	310 <gettoken>
     630:	c505                	beqz	a0,658 <parseexec+0xd2>
    if(tok != 'a')
     632:	fda516e3          	bne	a0,s10,5fe <parseexec+0x78>
    cmd->argv[argc] = q;
     636:	f8843783          	ld	a5,-120(s0)
     63a:	00f9b023          	sd	a5,0(s3)
    cmd->eargv[argc] = eq;
     63e:	f8043783          	ld	a5,-128(s0)
     642:	04f9b823          	sd	a5,80(s3)
    argc++;
     646:	2905                	addiw	s2,s2,1
    if(argc >= MAXARGS)
     648:	fd9911e3          	bne	s2,s9,60a <parseexec+0x84>
      panic("too many args");
     64c:	00001517          	auipc	a0,0x1
     650:	cdc50513          	addi	a0,a0,-804 # 1328 <malloc+0x188>
     654:	9f7ff0ef          	jal	4a <panic>
  cmd->argv[argc] = 0;
     658:	090e                	slli	s2,s2,0x3
     65a:	012d87b3          	add	a5,s11,s2
     65e:	0007b423          	sd	zero,8(a5)
  cmd->eargv[argc] = 0;
     662:	0407bc23          	sd	zero,88(a5)
     666:	7906                	ld	s2,96(sp)
     668:	69e6                	ld	s3,88(sp)
     66a:	6b06                	ld	s6,64(sp)
     66c:	7be2                	ld	s7,56(sp)
     66e:	7c42                	ld	s8,48(sp)
     670:	7ca2                	ld	s9,40(sp)
     672:	7d02                	ld	s10,32(sp)
     674:	6de2                	ld	s11,24(sp)
  return ret;
     676:	bfa5                	j	5ee <parseexec+0x68>

0000000000000678 <parsepipe>:
{
     678:	7179                	addi	sp,sp,-48
     67a:	f406                	sd	ra,40(sp)
     67c:	f022                	sd	s0,32(sp)
     67e:	ec26                	sd	s1,24(sp)
     680:	e84a                	sd	s2,16(sp)
     682:	e44e                	sd	s3,8(sp)
     684:	e052                	sd	s4,0(sp)
     686:	1800                	addi	s0,sp,48
     688:	892a                	mv	s2,a0
     68a:	8a2a                	mv	s4,a0
     68c:	84ae                	mv	s1,a1
  cmd = parseexec(ps, es);
     68e:	ef9ff0ef          	jal	586 <parseexec>
     692:	89aa                	mv	s3,a0
  if(peek(ps, es, "|")){
     694:	00001617          	auipc	a2,0x1
     698:	cac60613          	addi	a2,a2,-852 # 1340 <malloc+0x1a0>
     69c:	85a6                	mv	a1,s1
     69e:	854a                	mv	a0,s2
     6a0:	d9dff0ef          	jal	43c <peek>
     6a4:	e911                	bnez	a0,6b8 <parsepipe+0x40>
}
     6a6:	854e                	mv	a0,s3
     6a8:	70a2                	ld	ra,40(sp)
     6aa:	7402                	ld	s0,32(sp)
     6ac:	64e2                	ld	s1,24(sp)
     6ae:	6942                	ld	s2,16(sp)
     6b0:	69a2                	ld	s3,8(sp)
     6b2:	6a02                	ld	s4,0(sp)
     6b4:	6145                	addi	sp,sp,48
     6b6:	8082                	ret
    gettoken(ps, es, 0, 0);
     6b8:	4681                	li	a3,0
     6ba:	4601                	li	a2,0
     6bc:	85a6                	mv	a1,s1
     6be:	8552                	mv	a0,s4
     6c0:	c51ff0ef          	jal	310 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     6c4:	85a6                	mv	a1,s1
     6c6:	8552                	mv	a0,s4
     6c8:	fb1ff0ef          	jal	678 <parsepipe>
     6cc:	85aa                	mv	a1,a0
     6ce:	854e                	mv	a0,s3
     6d0:	b91ff0ef          	jal	260 <pipecmd>
     6d4:	89aa                	mv	s3,a0
  return cmd;
     6d6:	bfc1                	j	6a6 <parsepipe+0x2e>

00000000000006d8 <parseline>:
{
     6d8:	7179                	addi	sp,sp,-48
     6da:	f406                	sd	ra,40(sp)
     6dc:	f022                	sd	s0,32(sp)
     6de:	ec26                	sd	s1,24(sp)
     6e0:	e84a                	sd	s2,16(sp)
     6e2:	e44e                	sd	s3,8(sp)
     6e4:	e052                	sd	s4,0(sp)
     6e6:	1800                	addi	s0,sp,48
     6e8:	892a                	mv	s2,a0
     6ea:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     6ec:	f8dff0ef          	jal	678 <parsepipe>
     6f0:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     6f2:	00001a17          	auipc	s4,0x1
     6f6:	c56a0a13          	addi	s4,s4,-938 # 1348 <malloc+0x1a8>
     6fa:	a819                	j	710 <parseline+0x38>
    gettoken(ps, es, 0, 0);
     6fc:	4681                	li	a3,0
     6fe:	4601                	li	a2,0
     700:	85ce                	mv	a1,s3
     702:	854a                	mv	a0,s2
     704:	c0dff0ef          	jal	310 <gettoken>
    cmd = backcmd(cmd);
     708:	8526                	mv	a0,s1
     70a:	bd3ff0ef          	jal	2dc <backcmd>
     70e:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     710:	8652                	mv	a2,s4
     712:	85ce                	mv	a1,s3
     714:	854a                	mv	a0,s2
     716:	d27ff0ef          	jal	43c <peek>
     71a:	f16d                	bnez	a0,6fc <parseline+0x24>
  if(peek(ps, es, ";")){
     71c:	00001617          	auipc	a2,0x1
     720:	c3460613          	addi	a2,a2,-972 # 1350 <malloc+0x1b0>
     724:	85ce                	mv	a1,s3
     726:	854a                	mv	a0,s2
     728:	d15ff0ef          	jal	43c <peek>
     72c:	e911                	bnez	a0,740 <parseline+0x68>
}
     72e:	8526                	mv	a0,s1
     730:	70a2                	ld	ra,40(sp)
     732:	7402                	ld	s0,32(sp)
     734:	64e2                	ld	s1,24(sp)
     736:	6942                	ld	s2,16(sp)
     738:	69a2                	ld	s3,8(sp)
     73a:	6a02                	ld	s4,0(sp)
     73c:	6145                	addi	sp,sp,48
     73e:	8082                	ret
    gettoken(ps, es, 0, 0);
     740:	4681                	li	a3,0
     742:	4601                	li	a2,0
     744:	85ce                	mv	a1,s3
     746:	854a                	mv	a0,s2
     748:	bc9ff0ef          	jal	310 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     74c:	85ce                	mv	a1,s3
     74e:	854a                	mv	a0,s2
     750:	f89ff0ef          	jal	6d8 <parseline>
     754:	85aa                	mv	a1,a0
     756:	8526                	mv	a0,s1
     758:	b47ff0ef          	jal	29e <listcmd>
     75c:	84aa                	mv	s1,a0
  return cmd;
     75e:	bfc1                	j	72e <parseline+0x56>

0000000000000760 <parseblock>:
{
     760:	7179                	addi	sp,sp,-48
     762:	f406                	sd	ra,40(sp)
     764:	f022                	sd	s0,32(sp)
     766:	ec26                	sd	s1,24(sp)
     768:	e84a                	sd	s2,16(sp)
     76a:	e44e                	sd	s3,8(sp)
     76c:	1800                	addi	s0,sp,48
     76e:	84aa                	mv	s1,a0
     770:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     772:	00001617          	auipc	a2,0x1
     776:	ba660613          	addi	a2,a2,-1114 # 1318 <malloc+0x178>
     77a:	cc3ff0ef          	jal	43c <peek>
     77e:	c539                	beqz	a0,7cc <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     780:	4681                	li	a3,0
     782:	4601                	li	a2,0
     784:	85ca                	mv	a1,s2
     786:	8526                	mv	a0,s1
     788:	b89ff0ef          	jal	310 <gettoken>
  cmd = parseline(ps, es);
     78c:	85ca                	mv	a1,s2
     78e:	8526                	mv	a0,s1
     790:	f49ff0ef          	jal	6d8 <parseline>
     794:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     796:	00001617          	auipc	a2,0x1
     79a:	bd260613          	addi	a2,a2,-1070 # 1368 <malloc+0x1c8>
     79e:	85ca                	mv	a1,s2
     7a0:	8526                	mv	a0,s1
     7a2:	c9bff0ef          	jal	43c <peek>
     7a6:	c90d                	beqz	a0,7d8 <parseblock+0x78>
  gettoken(ps, es, 0, 0);
     7a8:	4681                	li	a3,0
     7aa:	4601                	li	a2,0
     7ac:	85ca                	mv	a1,s2
     7ae:	8526                	mv	a0,s1
     7b0:	b61ff0ef          	jal	310 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     7b4:	864a                	mv	a2,s2
     7b6:	85a6                	mv	a1,s1
     7b8:	854e                	mv	a0,s3
     7ba:	ce7ff0ef          	jal	4a0 <parseredirs>
}
     7be:	70a2                	ld	ra,40(sp)
     7c0:	7402                	ld	s0,32(sp)
     7c2:	64e2                	ld	s1,24(sp)
     7c4:	6942                	ld	s2,16(sp)
     7c6:	69a2                	ld	s3,8(sp)
     7c8:	6145                	addi	sp,sp,48
     7ca:	8082                	ret
    panic("parseblock");
     7cc:	00001517          	auipc	a0,0x1
     7d0:	b8c50513          	addi	a0,a0,-1140 # 1358 <malloc+0x1b8>
     7d4:	877ff0ef          	jal	4a <panic>
    panic("syntax - missing )");
     7d8:	00001517          	auipc	a0,0x1
     7dc:	b9850513          	addi	a0,a0,-1128 # 1370 <malloc+0x1d0>
     7e0:	86bff0ef          	jal	4a <panic>

00000000000007e4 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     7e4:	1101                	addi	sp,sp,-32
     7e6:	ec06                	sd	ra,24(sp)
     7e8:	e822                	sd	s0,16(sp)
     7ea:	e426                	sd	s1,8(sp)
     7ec:	1000                	addi	s0,sp,32
     7ee:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     7f0:	c131                	beqz	a0,834 <nulterminate+0x50>
    return 0;

  switch(cmd->type){
     7f2:	4118                	lw	a4,0(a0)
     7f4:	4795                	li	a5,5
     7f6:	02e7ef63          	bltu	a5,a4,834 <nulterminate+0x50>
     7fa:	00056783          	lwu	a5,0(a0)
     7fe:	078a                	slli	a5,a5,0x2
     800:	00001717          	auipc	a4,0x1
     804:	bd070713          	addi	a4,a4,-1072 # 13d0 <malloc+0x230>
     808:	97ba                	add	a5,a5,a4
     80a:	439c                	lw	a5,0(a5)
     80c:	97ba                	add	a5,a5,a4
     80e:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     810:	651c                	ld	a5,8(a0)
     812:	c38d                	beqz	a5,834 <nulterminate+0x50>
     814:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     818:	67b8                	ld	a4,72(a5)
     81a:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     81e:	07a1                	addi	a5,a5,8
     820:	ff87b703          	ld	a4,-8(a5)
     824:	fb75                	bnez	a4,818 <nulterminate+0x34>
     826:	a039                	j	834 <nulterminate+0x50>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     828:	6508                	ld	a0,8(a0)
     82a:	fbbff0ef          	jal	7e4 <nulterminate>
    *rcmd->efile = 0;
     82e:	6c9c                	ld	a5,24(s1)
     830:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     834:	8526                	mv	a0,s1
     836:	60e2                	ld	ra,24(sp)
     838:	6442                	ld	s0,16(sp)
     83a:	64a2                	ld	s1,8(sp)
     83c:	6105                	addi	sp,sp,32
     83e:	8082                	ret
    nulterminate(pcmd->left);
     840:	6508                	ld	a0,8(a0)
     842:	fa3ff0ef          	jal	7e4 <nulterminate>
    nulterminate(pcmd->right);
     846:	6888                	ld	a0,16(s1)
     848:	f9dff0ef          	jal	7e4 <nulterminate>
    break;
     84c:	b7e5                	j	834 <nulterminate+0x50>
    nulterminate(lcmd->left);
     84e:	6508                	ld	a0,8(a0)
     850:	f95ff0ef          	jal	7e4 <nulterminate>
    nulterminate(lcmd->right);
     854:	6888                	ld	a0,16(s1)
     856:	f8fff0ef          	jal	7e4 <nulterminate>
    break;
     85a:	bfe9                	j	834 <nulterminate+0x50>
    nulterminate(bcmd->cmd);
     85c:	6508                	ld	a0,8(a0)
     85e:	f87ff0ef          	jal	7e4 <nulterminate>
    break;
     862:	bfc9                	j	834 <nulterminate+0x50>

0000000000000864 <parsecmd>:
{
     864:	7139                	addi	sp,sp,-64
     866:	fc06                	sd	ra,56(sp)
     868:	f822                	sd	s0,48(sp)
     86a:	f426                	sd	s1,40(sp)
     86c:	f04a                	sd	s2,32(sp)
     86e:	ec4e                	sd	s3,24(sp)
     870:	0080                	addi	s0,sp,64
     872:	fca43423          	sd	a0,-56(s0)
  es = s + strlen(s);
     876:	84aa                	mv	s1,a0
     878:	1b8000ef          	jal	a30 <strlen>
     87c:	1502                	slli	a0,a0,0x20
     87e:	9101                	srli	a0,a0,0x20
     880:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     882:	fc840913          	addi	s2,s0,-56
     886:	85a6                	mv	a1,s1
     888:	854a                	mv	a0,s2
     88a:	e4fff0ef          	jal	6d8 <parseline>
     88e:	89aa                	mv	s3,a0
  peek(&s, es, "");
     890:	00001617          	auipc	a2,0x1
     894:	a1860613          	addi	a2,a2,-1512 # 12a8 <malloc+0x108>
     898:	85a6                	mv	a1,s1
     89a:	854a                	mv	a0,s2
     89c:	ba1ff0ef          	jal	43c <peek>
  if(s != es){
     8a0:	fc843603          	ld	a2,-56(s0)
     8a4:	00961d63          	bne	a2,s1,8be <parsecmd+0x5a>
  nulterminate(cmd);
     8a8:	854e                	mv	a0,s3
     8aa:	f3bff0ef          	jal	7e4 <nulterminate>
}
     8ae:	854e                	mv	a0,s3
     8b0:	70e2                	ld	ra,56(sp)
     8b2:	7442                	ld	s0,48(sp)
     8b4:	74a2                	ld	s1,40(sp)
     8b6:	7902                	ld	s2,32(sp)
     8b8:	69e2                	ld	s3,24(sp)
     8ba:	6121                	addi	sp,sp,64
     8bc:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     8be:	00001597          	auipc	a1,0x1
     8c2:	aca58593          	addi	a1,a1,-1334 # 1388 <malloc+0x1e8>
     8c6:	4509                	li	a0,2
     8c8:	7f2000ef          	jal	10ba <fprintf>
    panic("syntax");
     8cc:	00001517          	auipc	a0,0x1
     8d0:	a5450513          	addi	a0,a0,-1452 # 1320 <malloc+0x180>
     8d4:	f76ff0ef          	jal	4a <panic>

00000000000008d8 <main>:
{
     8d8:	7139                	addi	sp,sp,-64
     8da:	fc06                	sd	ra,56(sp)
     8dc:	f822                	sd	s0,48(sp)
     8de:	f426                	sd	s1,40(sp)
     8e0:	f04a                	sd	s2,32(sp)
     8e2:	ec4e                	sd	s3,24(sp)
     8e4:	e852                	sd	s4,16(sp)
     8e6:	e456                	sd	s5,8(sp)
     8e8:	e05a                	sd	s6,0(sp)
     8ea:	0080                	addi	s0,sp,64
  while((fd = open("console", O_RDWR)) >= 0){
     8ec:	4489                	li	s1,2
     8ee:	00001917          	auipc	s2,0x1
     8f2:	aaa90913          	addi	s2,s2,-1366 # 1398 <malloc+0x1f8>
     8f6:	85a6                	mv	a1,s1
     8f8:	854a                	mv	a0,s2
     8fa:	3cc000ef          	jal	cc6 <open>
     8fe:	00054663          	bltz	a0,90a <main+0x32>
    if(fd >= 3){
     902:	fea4dae3          	bge	s1,a0,8f6 <main+0x1e>
      close(fd);
     906:	3a8000ef          	jal	cae <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     90a:	06400993          	li	s3,100
     90e:	00001917          	auipc	s2,0x1
     912:	71290913          	addi	s2,s2,1810 # 2020 <buf.0>
    if (*cmd == '\n') // is a blank command
     916:	4a29                	li	s4,10
    if(cmd[0] == 'c' && cmd[1] == 'd' && cmd[2] == ' '){
     918:	06300a93          	li	s5,99
     91c:	02000b13          	li	s6,32
     920:	a039                	j	92e <main+0x56>
      if(fork1() == 0)
     922:	f46ff0ef          	jal	68 <fork1>
     926:	cd41                	beqz	a0,9be <main+0xe6>
      wait(0);
     928:	4501                	li	a0,0
     92a:	364000ef          	jal	c8e <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     92e:	85ce                	mv	a1,s3
     930:	854a                	mv	a0,s2
     932:	eceff0ef          	jal	0 <getcmd>
     936:	08054963          	bltz	a0,9c8 <main+0xf0>
    while (*cmd == ' ' || *cmd == '\t')
     93a:	00094683          	lbu	a3,0(s2)
     93e:	fe068793          	addi	a5,a3,-32
     942:	0017b793          	seqz	a5,a5
     946:	ff768713          	addi	a4,a3,-9
     94a:	00173713          	seqz	a4,a4
     94e:	8fd9                	or	a5,a5,a4
    char *cmd = buf;
     950:	00001497          	auipc	s1,0x1
     954:	6d048493          	addi	s1,s1,1744 # 2020 <buf.0>
    while (*cmd == ' ' || *cmd == '\t')
     958:	cf91                	beqz	a5,974 <main+0x9c>
      cmd++;
     95a:	0485                	addi	s1,s1,1
    while (*cmd == ' ' || *cmd == '\t')
     95c:	0004c683          	lbu	a3,0(s1)
     960:	fe068793          	addi	a5,a3,-32
     964:	0017b793          	seqz	a5,a5
     968:	ff768713          	addi	a4,a3,-9
     96c:	00173713          	seqz	a4,a4
     970:	8fd9                	or	a5,a5,a4
     972:	f7e5                	bnez	a5,95a <main+0x82>
    if (*cmd == '\n') // is a blank command
     974:	fb468de3          	beq	a3,s4,92e <main+0x56>
    if(cmd[0] == 'c' && cmd[1] == 'd' && cmd[2] == ' '){
     978:	fb5695e3          	bne	a3,s5,922 <main+0x4a>
     97c:	0014c783          	lbu	a5,1(s1)
     980:	fb3791e3          	bne	a5,s3,922 <main+0x4a>
     984:	0024c783          	lbu	a5,2(s1)
     988:	f9679de3          	bne	a5,s6,922 <main+0x4a>
      cmd[strlen(cmd)-1] = 0;  // chop \n
     98c:	8526                	mv	a0,s1
     98e:	0a2000ef          	jal	a30 <strlen>
     992:	fff5079b          	addiw	a5,a0,-1
     996:	1782                	slli	a5,a5,0x20
     998:	9381                	srli	a5,a5,0x20
     99a:	97a6                	add	a5,a5,s1
     99c:	00078023          	sb	zero,0(a5)
      if(chdir(cmd+3) < 0)
     9a0:	048d                	addi	s1,s1,3
     9a2:	8526                	mv	a0,s1
     9a4:	352000ef          	jal	cf6 <chdir>
     9a8:	f80553e3          	bgez	a0,92e <main+0x56>
        fprintf(2, "cannot cd %s\n", cmd+3);
     9ac:	8626                	mv	a2,s1
     9ae:	00001597          	auipc	a1,0x1
     9b2:	9f258593          	addi	a1,a1,-1550 # 13a0 <malloc+0x200>
     9b6:	4509                	li	a0,2
     9b8:	702000ef          	jal	10ba <fprintf>
     9bc:	bf8d                	j	92e <main+0x56>
        runcmd(parsecmd(cmd));
     9be:	8526                	mv	a0,s1
     9c0:	ea5ff0ef          	jal	864 <parsecmd>
     9c4:	ecaff0ef          	jal	8e <runcmd>
  exit(0);
     9c8:	4501                	li	a0,0
     9ca:	2bc000ef          	jal	c86 <exit>

00000000000009ce <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
     9ce:	1141                	addi	sp,sp,-16
     9d0:	e406                	sd	ra,8(sp)
     9d2:	e022                	sd	s0,0(sp)
     9d4:	0800                	addi	s0,sp,16
  extern int main();
  main();
     9d6:	f03ff0ef          	jal	8d8 <main>
  exit(0);
     9da:	4501                	li	a0,0
     9dc:	2aa000ef          	jal	c86 <exit>

00000000000009e0 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     9e0:	1141                	addi	sp,sp,-16
     9e2:	e406                	sd	ra,8(sp)
     9e4:	e022                	sd	s0,0(sp)
     9e6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     9e8:	87aa                	mv	a5,a0
     9ea:	0585                	addi	a1,a1,1
     9ec:	0785                	addi	a5,a5,1
     9ee:	fff5c703          	lbu	a4,-1(a1)
     9f2:	fee78fa3          	sb	a4,-1(a5)
     9f6:	fb75                	bnez	a4,9ea <strcpy+0xa>
    ;
  return os;
}
     9f8:	60a2                	ld	ra,8(sp)
     9fa:	6402                	ld	s0,0(sp)
     9fc:	0141                	addi	sp,sp,16
     9fe:	8082                	ret

0000000000000a00 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     a00:	1141                	addi	sp,sp,-16
     a02:	e406                	sd	ra,8(sp)
     a04:	e022                	sd	s0,0(sp)
     a06:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     a08:	00054783          	lbu	a5,0(a0)
     a0c:	cb91                	beqz	a5,a20 <strcmp+0x20>
     a0e:	0005c703          	lbu	a4,0(a1)
     a12:	00f71763          	bne	a4,a5,a20 <strcmp+0x20>
    p++, q++;
     a16:	0505                	addi	a0,a0,1
     a18:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     a1a:	00054783          	lbu	a5,0(a0)
     a1e:	fbe5                	bnez	a5,a0e <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
     a20:	0005c503          	lbu	a0,0(a1)
}
     a24:	40a7853b          	subw	a0,a5,a0
     a28:	60a2                	ld	ra,8(sp)
     a2a:	6402                	ld	s0,0(sp)
     a2c:	0141                	addi	sp,sp,16
     a2e:	8082                	ret

0000000000000a30 <strlen>:

uint
strlen(const char *s)
{
     a30:	1141                	addi	sp,sp,-16
     a32:	e406                	sd	ra,8(sp)
     a34:	e022                	sd	s0,0(sp)
     a36:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     a38:	00054783          	lbu	a5,0(a0)
     a3c:	cf91                	beqz	a5,a58 <strlen+0x28>
     a3e:	00150793          	addi	a5,a0,1
     a42:	86be                	mv	a3,a5
     a44:	0785                	addi	a5,a5,1
     a46:	fff7c703          	lbu	a4,-1(a5)
     a4a:	ff65                	bnez	a4,a42 <strlen+0x12>
     a4c:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
     a50:	60a2                	ld	ra,8(sp)
     a52:	6402                	ld	s0,0(sp)
     a54:	0141                	addi	sp,sp,16
     a56:	8082                	ret
  for(n = 0; s[n]; n++)
     a58:	4501                	li	a0,0
     a5a:	bfdd                	j	a50 <strlen+0x20>

0000000000000a5c <memset>:

void*
memset(void *dst, int c, uint n)
{
     a5c:	1141                	addi	sp,sp,-16
     a5e:	e406                	sd	ra,8(sp)
     a60:	e022                	sd	s0,0(sp)
     a62:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     a64:	ca19                	beqz	a2,a7a <memset+0x1e>
     a66:	87aa                	mv	a5,a0
     a68:	1602                	slli	a2,a2,0x20
     a6a:	9201                	srli	a2,a2,0x20
     a6c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     a70:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     a74:	0785                	addi	a5,a5,1
     a76:	fee79de3          	bne	a5,a4,a70 <memset+0x14>
  }
  return dst;
}
     a7a:	60a2                	ld	ra,8(sp)
     a7c:	6402                	ld	s0,0(sp)
     a7e:	0141                	addi	sp,sp,16
     a80:	8082                	ret

0000000000000a82 <strchr>:

char*
strchr(const char *s, char c)
{
     a82:	1141                	addi	sp,sp,-16
     a84:	e406                	sd	ra,8(sp)
     a86:	e022                	sd	s0,0(sp)
     a88:	0800                	addi	s0,sp,16
  for(; *s; s++)
     a8a:	00054783          	lbu	a5,0(a0)
     a8e:	c799                	beqz	a5,a9c <strchr+0x1a>
    if(*s == c)
     a90:	00f58763          	beq	a1,a5,a9e <strchr+0x1c>
  for(; *s; s++)
     a94:	0505                	addi	a0,a0,1
     a96:	00054783          	lbu	a5,0(a0)
     a9a:	fbfd                	bnez	a5,a90 <strchr+0xe>
      return (char*)s;
  return 0;
     a9c:	4501                	li	a0,0
}
     a9e:	60a2                	ld	ra,8(sp)
     aa0:	6402                	ld	s0,0(sp)
     aa2:	0141                	addi	sp,sp,16
     aa4:	8082                	ret

0000000000000aa6 <gets>:

char*
gets(char *buf, int max)
{
     aa6:	711d                	addi	sp,sp,-96
     aa8:	ec86                	sd	ra,88(sp)
     aaa:	e8a2                	sd	s0,80(sp)
     aac:	e4a6                	sd	s1,72(sp)
     aae:	e0ca                	sd	s2,64(sp)
     ab0:	fc4e                	sd	s3,56(sp)
     ab2:	f852                	sd	s4,48(sp)
     ab4:	f456                	sd	s5,40(sp)
     ab6:	f05a                	sd	s6,32(sp)
     ab8:	ec5e                	sd	s7,24(sp)
     aba:	e862                	sd	s8,16(sp)
     abc:	1080                	addi	s0,sp,96
     abe:	8baa                	mv	s7,a0
     ac0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ac2:	892a                	mv	s2,a0
     ac4:	4481                	li	s1,0
    cc = read(0, &c, 1);
     ac6:	faf40b13          	addi	s6,s0,-81
     aca:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
     acc:	8c26                	mv	s8,s1
     ace:	0014899b          	addiw	s3,s1,1
     ad2:	84ce                	mv	s1,s3
     ad4:	0349d863          	bge	s3,s4,b04 <gets+0x5e>
    cc = read(0, &c, 1);
     ad8:	8656                	mv	a2,s5
     ada:	85da                	mv	a1,s6
     adc:	4501                	li	a0,0
     ade:	1c0000ef          	jal	c9e <read>
    if(cc < 1)
     ae2:	02a05163          	blez	a0,b04 <gets+0x5e>
      break;
    buf[i++] = c;
     ae6:	faf44783          	lbu	a5,-81(s0)
     aea:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     aee:	0905                	addi	s2,s2,1
     af0:	ff678713          	addi	a4,a5,-10
     af4:	00173713          	seqz	a4,a4
     af8:	17cd                	addi	a5,a5,-13
     afa:	0017b793          	seqz	a5,a5
     afe:	8fd9                	or	a5,a5,a4
     b00:	d7f1                	beqz	a5,acc <gets+0x26>
    buf[i++] = c;
     b02:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
     b04:	9c5e                	add	s8,s8,s7
     b06:	000c0023          	sb	zero,0(s8)
  return buf;
}
     b0a:	855e                	mv	a0,s7
     b0c:	60e6                	ld	ra,88(sp)
     b0e:	6446                	ld	s0,80(sp)
     b10:	64a6                	ld	s1,72(sp)
     b12:	6906                	ld	s2,64(sp)
     b14:	79e2                	ld	s3,56(sp)
     b16:	7a42                	ld	s4,48(sp)
     b18:	7aa2                	ld	s5,40(sp)
     b1a:	7b02                	ld	s6,32(sp)
     b1c:	6be2                	ld	s7,24(sp)
     b1e:	6c42                	ld	s8,16(sp)
     b20:	6125                	addi	sp,sp,96
     b22:	8082                	ret

0000000000000b24 <stat>:

int
stat(const char *n, struct stat *st)
{
     b24:	1101                	addi	sp,sp,-32
     b26:	ec06                	sd	ra,24(sp)
     b28:	e822                	sd	s0,16(sp)
     b2a:	e04a                	sd	s2,0(sp)
     b2c:	1000                	addi	s0,sp,32
     b2e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     b30:	4581                	li	a1,0
     b32:	194000ef          	jal	cc6 <open>
  if(fd < 0)
     b36:	02054263          	bltz	a0,b5a <stat+0x36>
     b3a:	e426                	sd	s1,8(sp)
     b3c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     b3e:	85ca                	mv	a1,s2
     b40:	19e000ef          	jal	cde <fstat>
     b44:	892a                	mv	s2,a0
  close(fd);
     b46:	8526                	mv	a0,s1
     b48:	166000ef          	jal	cae <close>
  return r;
     b4c:	64a2                	ld	s1,8(sp)
}
     b4e:	854a                	mv	a0,s2
     b50:	60e2                	ld	ra,24(sp)
     b52:	6442                	ld	s0,16(sp)
     b54:	6902                	ld	s2,0(sp)
     b56:	6105                	addi	sp,sp,32
     b58:	8082                	ret
    return -1;
     b5a:	57fd                	li	a5,-1
     b5c:	893e                	mv	s2,a5
     b5e:	bfc5                	j	b4e <stat+0x2a>

0000000000000b60 <atoi>:

int
atoi(const char *s)
{
     b60:	1141                	addi	sp,sp,-16
     b62:	e406                	sd	ra,8(sp)
     b64:	e022                	sd	s0,0(sp)
     b66:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     b68:	00054683          	lbu	a3,0(a0)
     b6c:	fd06879b          	addiw	a5,a3,-48
     b70:	0ff7f793          	zext.b	a5,a5
     b74:	4625                	li	a2,9
     b76:	02f66963          	bltu	a2,a5,ba8 <atoi+0x48>
     b7a:	872a                	mv	a4,a0
  n = 0;
     b7c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     b7e:	0705                	addi	a4,a4,1
     b80:	0025179b          	slliw	a5,a0,0x2
     b84:	9fa9                	addw	a5,a5,a0
     b86:	0017979b          	slliw	a5,a5,0x1
     b8a:	9fb5                	addw	a5,a5,a3
     b8c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     b90:	00074683          	lbu	a3,0(a4)
     b94:	fd06879b          	addiw	a5,a3,-48
     b98:	0ff7f793          	zext.b	a5,a5
     b9c:	fef671e3          	bgeu	a2,a5,b7e <atoi+0x1e>
  return n;
}
     ba0:	60a2                	ld	ra,8(sp)
     ba2:	6402                	ld	s0,0(sp)
     ba4:	0141                	addi	sp,sp,16
     ba6:	8082                	ret
  n = 0;
     ba8:	4501                	li	a0,0
     baa:	bfdd                	j	ba0 <atoi+0x40>

0000000000000bac <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     bac:	1141                	addi	sp,sp,-16
     bae:	e406                	sd	ra,8(sp)
     bb0:	e022                	sd	s0,0(sp)
     bb2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     bb4:	02b57563          	bgeu	a0,a1,bde <memmove+0x32>
    while(n-- > 0)
     bb8:	00c05f63          	blez	a2,bd6 <memmove+0x2a>
     bbc:	1602                	slli	a2,a2,0x20
     bbe:	9201                	srli	a2,a2,0x20
     bc0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     bc4:	872a                	mv	a4,a0
      *dst++ = *src++;
     bc6:	0585                	addi	a1,a1,1
     bc8:	0705                	addi	a4,a4,1
     bca:	fff5c683          	lbu	a3,-1(a1)
     bce:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     bd2:	fee79ae3          	bne	a5,a4,bc6 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     bd6:	60a2                	ld	ra,8(sp)
     bd8:	6402                	ld	s0,0(sp)
     bda:	0141                	addi	sp,sp,16
     bdc:	8082                	ret
    while(n-- > 0)
     bde:	fec05ce3          	blez	a2,bd6 <memmove+0x2a>
    dst += n;
     be2:	00c50733          	add	a4,a0,a2
    src += n;
     be6:	95b2                	add	a1,a1,a2
     be8:	fff6079b          	addiw	a5,a2,-1
     bec:	1782                	slli	a5,a5,0x20
     bee:	9381                	srli	a5,a5,0x20
     bf0:	fff7c793          	not	a5,a5
     bf4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     bf6:	15fd                	addi	a1,a1,-1
     bf8:	177d                	addi	a4,a4,-1
     bfa:	0005c683          	lbu	a3,0(a1)
     bfe:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     c02:	fef71ae3          	bne	a4,a5,bf6 <memmove+0x4a>
     c06:	bfc1                	j	bd6 <memmove+0x2a>

0000000000000c08 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     c08:	1141                	addi	sp,sp,-16
     c0a:	e406                	sd	ra,8(sp)
     c0c:	e022                	sd	s0,0(sp)
     c0e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     c10:	ce19                	beqz	a2,c2e <memcmp+0x26>
     c12:	1602                	slli	a2,a2,0x20
     c14:	9201                	srli	a2,a2,0x20
     c16:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
     c1a:	00054783          	lbu	a5,0(a0)
     c1e:	0005c703          	lbu	a4,0(a1)
     c22:	00e79b63          	bne	a5,a4,c38 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
     c26:	0505                	addi	a0,a0,1
    p2++;
     c28:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     c2a:	fed518e3          	bne	a0,a3,c1a <memcmp+0x12>
  }
  return 0;
     c2e:	4501                	li	a0,0
}
     c30:	60a2                	ld	ra,8(sp)
     c32:	6402                	ld	s0,0(sp)
     c34:	0141                	addi	sp,sp,16
     c36:	8082                	ret
      return *p1 - *p2;
     c38:	40e7853b          	subw	a0,a5,a4
     c3c:	bfd5                	j	c30 <memcmp+0x28>

0000000000000c3e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     c3e:	1141                	addi	sp,sp,-16
     c40:	e406                	sd	ra,8(sp)
     c42:	e022                	sd	s0,0(sp)
     c44:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     c46:	f67ff0ef          	jal	bac <memmove>
}
     c4a:	60a2                	ld	ra,8(sp)
     c4c:	6402                	ld	s0,0(sp)
     c4e:	0141                	addi	sp,sp,16
     c50:	8082                	ret

0000000000000c52 <sbrk>:

char *
sbrk(int n) {
     c52:	1141                	addi	sp,sp,-16
     c54:	e406                	sd	ra,8(sp)
     c56:	e022                	sd	s0,0(sp)
     c58:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
     c5a:	4585                	li	a1,1
     c5c:	0b2000ef          	jal	d0e <sys_sbrk>
}
     c60:	60a2                	ld	ra,8(sp)
     c62:	6402                	ld	s0,0(sp)
     c64:	0141                	addi	sp,sp,16
     c66:	8082                	ret

0000000000000c68 <sbrklazy>:

char *
sbrklazy(int n) {
     c68:	1141                	addi	sp,sp,-16
     c6a:	e406                	sd	ra,8(sp)
     c6c:	e022                	sd	s0,0(sp)
     c6e:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
     c70:	4589                	li	a1,2
     c72:	09c000ef          	jal	d0e <sys_sbrk>
}
     c76:	60a2                	ld	ra,8(sp)
     c78:	6402                	ld	s0,0(sp)
     c7a:	0141                	addi	sp,sp,16
     c7c:	8082                	ret

0000000000000c7e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     c7e:	4885                	li	a7,1
 ecall
     c80:	00000073          	ecall
 ret
     c84:	8082                	ret

0000000000000c86 <exit>:
.global exit
exit:
 li a7, SYS_exit
     c86:	4889                	li	a7,2
 ecall
     c88:	00000073          	ecall
 ret
     c8c:	8082                	ret

0000000000000c8e <wait>:
.global wait
wait:
 li a7, SYS_wait
     c8e:	488d                	li	a7,3
 ecall
     c90:	00000073          	ecall
 ret
     c94:	8082                	ret

0000000000000c96 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     c96:	4891                	li	a7,4
 ecall
     c98:	00000073          	ecall
 ret
     c9c:	8082                	ret

0000000000000c9e <read>:
.global read
read:
 li a7, SYS_read
     c9e:	4895                	li	a7,5
 ecall
     ca0:	00000073          	ecall
 ret
     ca4:	8082                	ret

0000000000000ca6 <write>:
.global write
write:
 li a7, SYS_write
     ca6:	48c1                	li	a7,16
 ecall
     ca8:	00000073          	ecall
 ret
     cac:	8082                	ret

0000000000000cae <close>:
.global close
close:
 li a7, SYS_close
     cae:	48d5                	li	a7,21
 ecall
     cb0:	00000073          	ecall
 ret
     cb4:	8082                	ret

0000000000000cb6 <kill>:
.global kill
kill:
 li a7, SYS_kill
     cb6:	4899                	li	a7,6
 ecall
     cb8:	00000073          	ecall
 ret
     cbc:	8082                	ret

0000000000000cbe <exec>:
.global exec
exec:
 li a7, SYS_exec
     cbe:	489d                	li	a7,7
 ecall
     cc0:	00000073          	ecall
 ret
     cc4:	8082                	ret

0000000000000cc6 <open>:
.global open
open:
 li a7, SYS_open
     cc6:	48bd                	li	a7,15
 ecall
     cc8:	00000073          	ecall
 ret
     ccc:	8082                	ret

0000000000000cce <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     cce:	48c5                	li	a7,17
 ecall
     cd0:	00000073          	ecall
 ret
     cd4:	8082                	ret

0000000000000cd6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     cd6:	48c9                	li	a7,18
 ecall
     cd8:	00000073          	ecall
 ret
     cdc:	8082                	ret

0000000000000cde <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     cde:	48a1                	li	a7,8
 ecall
     ce0:	00000073          	ecall
 ret
     ce4:	8082                	ret

0000000000000ce6 <link>:
.global link
link:
 li a7, SYS_link
     ce6:	48cd                	li	a7,19
 ecall
     ce8:	00000073          	ecall
 ret
     cec:	8082                	ret

0000000000000cee <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     cee:	48d1                	li	a7,20
 ecall
     cf0:	00000073          	ecall
 ret
     cf4:	8082                	ret

0000000000000cf6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     cf6:	48a5                	li	a7,9
 ecall
     cf8:	00000073          	ecall
 ret
     cfc:	8082                	ret

0000000000000cfe <dup>:
.global dup
dup:
 li a7, SYS_dup
     cfe:	48a9                	li	a7,10
 ecall
     d00:	00000073          	ecall
 ret
     d04:	8082                	ret

0000000000000d06 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     d06:	48ad                	li	a7,11
 ecall
     d08:	00000073          	ecall
 ret
     d0c:	8082                	ret

0000000000000d0e <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     d0e:	48b1                	li	a7,12
 ecall
     d10:	00000073          	ecall
 ret
     d14:	8082                	ret

0000000000000d16 <pause>:
.global pause
pause:
 li a7, SYS_pause
     d16:	48b5                	li	a7,13
 ecall
     d18:	00000073          	ecall
 ret
     d1c:	8082                	ret

0000000000000d1e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     d1e:	48b9                	li	a7,14
 ecall
     d20:	00000073          	ecall
 ret
     d24:	8082                	ret

0000000000000d26 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     d26:	1101                	addi	sp,sp,-32
     d28:	ec06                	sd	ra,24(sp)
     d2a:	e822                	sd	s0,16(sp)
     d2c:	1000                	addi	s0,sp,32
     d2e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     d32:	4605                	li	a2,1
     d34:	fef40593          	addi	a1,s0,-17
     d38:	f6fff0ef          	jal	ca6 <write>
}
     d3c:	60e2                	ld	ra,24(sp)
     d3e:	6442                	ld	s0,16(sp)
     d40:	6105                	addi	sp,sp,32
     d42:	8082                	ret

0000000000000d44 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     d44:	715d                	addi	sp,sp,-80
     d46:	e486                	sd	ra,72(sp)
     d48:	e0a2                	sd	s0,64(sp)
     d4a:	f84a                	sd	s2,48(sp)
     d4c:	f44e                	sd	s3,40(sp)
     d4e:	0880                	addi	s0,sp,80
     d50:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     d52:	00d036b3          	snez	a3,a3
     d56:	03f5d793          	srli	a5,a1,0x3f
     d5a:	8efd                	and	a3,a3,a5
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     d5c:	0005871b          	sext.w	a4,a1
  neg = 0;
     d60:	4301                	li	t1,0
  if(sgn && xx < 0){
     d62:	c681                	beqz	a3,d6a <printint+0x26>
    x = -xx;
     d64:	40b0073b          	negw	a4,a1
    neg = 1;
     d68:	4305                	li	t1,1
  }

  i = 0;
     d6a:	fb840993          	addi	s3,s0,-72
  neg = 0;
     d6e:	85ce                	mv	a1,s3
  i = 0;
     d70:	4681                	li	a3,0
  do{
    buf[i++] = digits[x % base];
     d72:	00000817          	auipc	a6,0x0
     d76:	67680813          	addi	a6,a6,1654 # 13e8 <digits>
     d7a:	88b6                	mv	a7,a3
     d7c:	0016851b          	addiw	a0,a3,1
     d80:	86aa                	mv	a3,a0
     d82:	02c777bb          	remuw	a5,a4,a2
     d86:	1782                	slli	a5,a5,0x20
     d88:	9381                	srli	a5,a5,0x20
     d8a:	97c2                	add	a5,a5,a6
     d8c:	0007c783          	lbu	a5,0(a5)
     d90:	00f58023          	sb	a5,0(a1)
  }while((x /= base) != 0);
     d94:	87ba                	mv	a5,a4
     d96:	02c7573b          	divuw	a4,a4,a2
     d9a:	0585                	addi	a1,a1,1
     d9c:	fcc7ffe3          	bgeu	a5,a2,d7a <printint+0x36>
  if(neg)
     da0:	00030b63          	beqz	t1,db6 <printint+0x72>
    buf[i++] = '-';
     da4:	fd040793          	addi	a5,s0,-48
     da8:	953e                	add	a0,a0,a5
     daa:	02d00793          	li	a5,45
     dae:	fef50423          	sb	a5,-24(a0)
     db2:	0028869b          	addiw	a3,a7,2

  while(--i >= 0)
     db6:	02d05563          	blez	a3,de0 <printint+0x9c>
     dba:	fc26                	sd	s1,56(sp)
     dbc:	36fd                	addiw	a3,a3,-1
     dbe:	00d984b3          	add	s1,s3,a3
     dc2:	19fd                	addi	s3,s3,-1
     dc4:	99b6                	add	s3,s3,a3
     dc6:	1682                	slli	a3,a3,0x20
     dc8:	9281                	srli	a3,a3,0x20
     dca:	40d989b3          	sub	s3,s3,a3
    putc(fd, buf[i]);
     dce:	0004c583          	lbu	a1,0(s1)
     dd2:	854a                	mv	a0,s2
     dd4:	f53ff0ef          	jal	d26 <putc>
  while(--i >= 0)
     dd8:	14fd                	addi	s1,s1,-1
     dda:	ff349ae3          	bne	s1,s3,dce <printint+0x8a>
     dde:	74e2                	ld	s1,56(sp)
}
     de0:	60a6                	ld	ra,72(sp)
     de2:	6406                	ld	s0,64(sp)
     de4:	7942                	ld	s2,48(sp)
     de6:	79a2                	ld	s3,40(sp)
     de8:	6161                	addi	sp,sp,80
     dea:	8082                	ret

0000000000000dec <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     dec:	711d                	addi	sp,sp,-96
     dee:	ec86                	sd	ra,88(sp)
     df0:	e8a2                	sd	s0,80(sp)
     df2:	e4a6                	sd	s1,72(sp)
     df4:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     df6:	0005c483          	lbu	s1,0(a1)
     dfa:	2a048063          	beqz	s1,109a <vprintf+0x2ae>
     dfe:	e0ca                	sd	s2,64(sp)
     e00:	fc4e                	sd	s3,56(sp)
     e02:	f852                	sd	s4,48(sp)
     e04:	f456                	sd	s5,40(sp)
     e06:	f05a                	sd	s6,32(sp)
     e08:	ec5e                	sd	s7,24(sp)
     e0a:	e862                	sd	s8,16(sp)
     e0c:	8b2a                	mv	s6,a0
     e0e:	8a2e                	mv	s4,a1
     e10:	8bb2                	mv	s7,a2
  state = 0;
     e12:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     e14:	4901                	li	s2,0
     e16:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     e18:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     e1c:	06400c13          	li	s8,100
     e20:	a00d                	j	e42 <vprintf+0x56>
        putc(fd, c0);
     e22:	85a6                	mv	a1,s1
     e24:	855a                	mv	a0,s6
     e26:	f01ff0ef          	jal	d26 <putc>
     e2a:	a019                	j	e30 <vprintf+0x44>
    } else if(state == '%'){
     e2c:	03598363          	beq	s3,s5,e52 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
     e30:	0019079b          	addiw	a5,s2,1
     e34:	893e                	mv	s2,a5
     e36:	873e                	mv	a4,a5
     e38:	97d2                	add	a5,a5,s4
     e3a:	0007c483          	lbu	s1,0(a5)
     e3e:	24048763          	beqz	s1,108c <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
     e42:	0004879b          	sext.w	a5,s1
    if(state == 0){
     e46:	fe0993e3          	bnez	s3,e2c <vprintf+0x40>
      if(c0 == '%'){
     e4a:	fd579ce3          	bne	a5,s5,e22 <vprintf+0x36>
        state = '%';
     e4e:	89be                	mv	s3,a5
     e50:	b7c5                	j	e30 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
     e52:	00ea06b3          	add	a3,s4,a4
     e56:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
     e5a:	24060563          	beqz	a2,10a4 <vprintf+0x2b8>
      if(c0 == 'd'){
     e5e:	0b878763          	beq	a5,s8,f0c <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     e62:	f9478693          	addi	a3,a5,-108
     e66:	0016b693          	seqz	a3,a3
     e6a:	f9c60593          	addi	a1,a2,-100
     e6e:	0015b593          	seqz	a1,a1
     e72:	8df5                	and	a1,a1,a3
     e74:	e9c5                	bnez	a1,f24 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
     e76:	9752                	add	a4,a4,s4
     e78:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     e7c:	f9460713          	addi	a4,a2,-108
     e80:	00173713          	seqz	a4,a4
     e84:	8f75                	and	a4,a4,a3
     e86:	f9c50593          	addi	a1,a0,-100
     e8a:	0015b593          	seqz	a1,a1
     e8e:	8df9                	and	a1,a1,a4
     e90:	e5dd                	bnez	a1,f3e <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     e92:	07500593          	li	a1,117
     e96:	0cb78163          	beq	a5,a1,f58 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
     e9a:	f8b60593          	addi	a1,a2,-117
     e9e:	0015b593          	seqz	a1,a1
     ea2:	8df5                	and	a1,a1,a3
     ea4:	e5f1                	bnez	a1,f70 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     ea6:	f8b50593          	addi	a1,a0,-117
     eaa:	0015b593          	seqz	a1,a1
     eae:	8df9                	and	a1,a1,a4
     eb0:	ede9                	bnez	a1,f8a <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     eb2:	07800593          	li	a1,120
     eb6:	0eb78763          	beq	a5,a1,fa4 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
     eba:	f8860613          	addi	a2,a2,-120
     ebe:	00163613          	seqz	a2,a2
     ec2:	8ef1                	and	a3,a3,a2
     ec4:	0e069c63          	bnez	a3,fbc <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     ec8:	f8850513          	addi	a0,a0,-120
     ecc:	00153513          	seqz	a0,a0
     ed0:	8f69                	and	a4,a4,a0
     ed2:	10071263          	bnez	a4,fd6 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     ed6:	07000713          	li	a4,112
     eda:	10e78a63          	beq	a5,a4,fee <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
     ede:	06300713          	li	a4,99
     ee2:	14e78a63          	beq	a5,a4,1036 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
     ee6:	07300713          	li	a4,115
     eea:	16e78063          	beq	a5,a4,104a <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     eee:	02500713          	li	a4,37
     ef2:	18e78863          	beq	a5,a4,1082 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     ef6:	02500593          	li	a1,37
     efa:	855a                	mv	a0,s6
     efc:	e2bff0ef          	jal	d26 <putc>
        putc(fd, c0);
     f00:	85a6                	mv	a1,s1
     f02:	855a                	mv	a0,s6
     f04:	e23ff0ef          	jal	d26 <putc>
      }

      state = 0;
     f08:	4981                	li	s3,0
     f0a:	b71d                	j	e30 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
     f0c:	008b8493          	addi	s1,s7,8
     f10:	4685                	li	a3,1
     f12:	4629                	li	a2,10
     f14:	000ba583          	lw	a1,0(s7)
     f18:	855a                	mv	a0,s6
     f1a:	e2bff0ef          	jal	d44 <printint>
     f1e:	8ba6                	mv	s7,s1
      state = 0;
     f20:	4981                	li	s3,0
     f22:	b739                	j	e30 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
     f24:	008b8493          	addi	s1,s7,8
     f28:	4685                	li	a3,1
     f2a:	4629                	li	a2,10
     f2c:	000bb583          	ld	a1,0(s7)
     f30:	855a                	mv	a0,s6
     f32:	e13ff0ef          	jal	d44 <printint>
        i += 1;
     f36:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     f38:	8ba6                	mv	s7,s1
      state = 0;
     f3a:	4981                	li	s3,0
     f3c:	bdd5                	j	e30 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
     f3e:	008b8493          	addi	s1,s7,8
     f42:	4685                	li	a3,1
     f44:	4629                	li	a2,10
     f46:	000bb583          	ld	a1,0(s7)
     f4a:	855a                	mv	a0,s6
     f4c:	df9ff0ef          	jal	d44 <printint>
        i += 2;
     f50:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     f52:	8ba6                	mv	s7,s1
      state = 0;
     f54:	4981                	li	s3,0
        i += 2;
     f56:	bde9                	j	e30 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
     f58:	008b8493          	addi	s1,s7,8
     f5c:	4681                	li	a3,0
     f5e:	4629                	li	a2,10
     f60:	000be583          	lwu	a1,0(s7)
     f64:	855a                	mv	a0,s6
     f66:	ddfff0ef          	jal	d44 <printint>
     f6a:	8ba6                	mv	s7,s1
      state = 0;
     f6c:	4981                	li	s3,0
     f6e:	b5c9                	j	e30 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
     f70:	008b8493          	addi	s1,s7,8
     f74:	4681                	li	a3,0
     f76:	4629                	li	a2,10
     f78:	000bb583          	ld	a1,0(s7)
     f7c:	855a                	mv	a0,s6
     f7e:	dc7ff0ef          	jal	d44 <printint>
        i += 1;
     f82:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     f84:	8ba6                	mv	s7,s1
      state = 0;
     f86:	4981                	li	s3,0
     f88:	b565                	j	e30 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
     f8a:	008b8493          	addi	s1,s7,8
     f8e:	4681                	li	a3,0
     f90:	4629                	li	a2,10
     f92:	000bb583          	ld	a1,0(s7)
     f96:	855a                	mv	a0,s6
     f98:	dadff0ef          	jal	d44 <printint>
        i += 2;
     f9c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
     f9e:	8ba6                	mv	s7,s1
      state = 0;
     fa0:	4981                	li	s3,0
        i += 2;
     fa2:	b579                	j	e30 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
     fa4:	008b8493          	addi	s1,s7,8
     fa8:	4681                	li	a3,0
     faa:	4641                	li	a2,16
     fac:	000be583          	lwu	a1,0(s7)
     fb0:	855a                	mv	a0,s6
     fb2:	d93ff0ef          	jal	d44 <printint>
     fb6:	8ba6                	mv	s7,s1
      state = 0;
     fb8:	4981                	li	s3,0
     fba:	bd9d                	j	e30 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
     fbc:	008b8493          	addi	s1,s7,8
     fc0:	4681                	li	a3,0
     fc2:	4641                	li	a2,16
     fc4:	000bb583          	ld	a1,0(s7)
     fc8:	855a                	mv	a0,s6
     fca:	d7bff0ef          	jal	d44 <printint>
        i += 1;
     fce:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
     fd0:	8ba6                	mv	s7,s1
      state = 0;
     fd2:	4981                	li	s3,0
     fd4:	bdb1                	j	e30 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
     fd6:	008b8493          	addi	s1,s7,8
     fda:	4641                	li	a2,16
     fdc:	000bb583          	ld	a1,0(s7)
     fe0:	855a                	mv	a0,s6
     fe2:	d63ff0ef          	jal	d44 <printint>
        i += 2;
     fe6:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     fe8:	8ba6                	mv	s7,s1
      state = 0;
     fea:	4981                	li	s3,0
        i += 2;
     fec:	b591                	j	e30 <vprintf+0x44>
     fee:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
     ff0:	008b8793          	addi	a5,s7,8
     ff4:	8cbe                	mv	s9,a5
     ff6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     ffa:	03000593          	li	a1,48
     ffe:	855a                	mv	a0,s6
    1000:	d27ff0ef          	jal	d26 <putc>
  putc(fd, 'x');
    1004:	07800593          	li	a1,120
    1008:	855a                	mv	a0,s6
    100a:	d1dff0ef          	jal	d26 <putc>
    100e:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1010:	00000b97          	auipc	s7,0x0
    1014:	3d8b8b93          	addi	s7,s7,984 # 13e8 <digits>
    1018:	03c9d793          	srli	a5,s3,0x3c
    101c:	97de                	add	a5,a5,s7
    101e:	0007c583          	lbu	a1,0(a5)
    1022:	855a                	mv	a0,s6
    1024:	d03ff0ef          	jal	d26 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1028:	0992                	slli	s3,s3,0x4
    102a:	34fd                	addiw	s1,s1,-1
    102c:	f4f5                	bnez	s1,1018 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
    102e:	8be6                	mv	s7,s9
      state = 0;
    1030:	4981                	li	s3,0
    1032:	6ca2                	ld	s9,8(sp)
    1034:	bbf5                	j	e30 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
    1036:	008b8493          	addi	s1,s7,8
    103a:	000bc583          	lbu	a1,0(s7)
    103e:	855a                	mv	a0,s6
    1040:	ce7ff0ef          	jal	d26 <putc>
    1044:	8ba6                	mv	s7,s1
      state = 0;
    1046:	4981                	li	s3,0
    1048:	b3e5                	j	e30 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
    104a:	008b8993          	addi	s3,s7,8
    104e:	000bb483          	ld	s1,0(s7)
    1052:	cc91                	beqz	s1,106e <vprintf+0x282>
        for(; *s; s++)
    1054:	0004c583          	lbu	a1,0(s1)
    1058:	c195                	beqz	a1,107c <vprintf+0x290>
          putc(fd, *s);
    105a:	855a                	mv	a0,s6
    105c:	ccbff0ef          	jal	d26 <putc>
        for(; *s; s++)
    1060:	0485                	addi	s1,s1,1
    1062:	0004c583          	lbu	a1,0(s1)
    1066:	f9f5                	bnez	a1,105a <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
    1068:	8bce                	mv	s7,s3
      state = 0;
    106a:	4981                	li	s3,0
    106c:	b3d1                	j	e30 <vprintf+0x44>
          s = "(null)";
    106e:	00000497          	auipc	s1,0x0
    1072:	34248493          	addi	s1,s1,834 # 13b0 <malloc+0x210>
        for(; *s; s++)
    1076:	02800593          	li	a1,40
    107a:	b7c5                	j	105a <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
    107c:	8bce                	mv	s7,s3
      state = 0;
    107e:	4981                	li	s3,0
    1080:	bb45                	j	e30 <vprintf+0x44>
        putc(fd, '%');
    1082:	85be                	mv	a1,a5
    1084:	855a                	mv	a0,s6
    1086:	ca1ff0ef          	jal	d26 <putc>
    108a:	bdbd                	j	f08 <vprintf+0x11c>
    108c:	6906                	ld	s2,64(sp)
    108e:	79e2                	ld	s3,56(sp)
    1090:	7a42                	ld	s4,48(sp)
    1092:	7aa2                	ld	s5,40(sp)
    1094:	7b02                	ld	s6,32(sp)
    1096:	6be2                	ld	s7,24(sp)
    1098:	6c42                	ld	s8,16(sp)
    }
  }
}
    109a:	60e6                	ld	ra,88(sp)
    109c:	6446                	ld	s0,80(sp)
    109e:	64a6                	ld	s1,72(sp)
    10a0:	6125                	addi	sp,sp,96
    10a2:	8082                	ret
      if(c0 == 'd'){
    10a4:	06400713          	li	a4,100
    10a8:	e6e782e3          	beq	a5,a4,f0c <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
    10ac:	f9478693          	addi	a3,a5,-108
    10b0:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
    10b4:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    10b6:	4701                	li	a4,0
    10b8:	bbe9                	j	e92 <vprintf+0xa6>

00000000000010ba <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    10ba:	715d                	addi	sp,sp,-80
    10bc:	ec06                	sd	ra,24(sp)
    10be:	e822                	sd	s0,16(sp)
    10c0:	1000                	addi	s0,sp,32
    10c2:	e010                	sd	a2,0(s0)
    10c4:	e414                	sd	a3,8(s0)
    10c6:	e818                	sd	a4,16(s0)
    10c8:	ec1c                	sd	a5,24(s0)
    10ca:	03043023          	sd	a6,32(s0)
    10ce:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    10d2:	8622                	mv	a2,s0
    10d4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    10d8:	d15ff0ef          	jal	dec <vprintf>
}
    10dc:	60e2                	ld	ra,24(sp)
    10de:	6442                	ld	s0,16(sp)
    10e0:	6161                	addi	sp,sp,80
    10e2:	8082                	ret

00000000000010e4 <printf>:

void
printf(const char *fmt, ...)
{
    10e4:	711d                	addi	sp,sp,-96
    10e6:	ec06                	sd	ra,24(sp)
    10e8:	e822                	sd	s0,16(sp)
    10ea:	1000                	addi	s0,sp,32
    10ec:	e40c                	sd	a1,8(s0)
    10ee:	e810                	sd	a2,16(s0)
    10f0:	ec14                	sd	a3,24(s0)
    10f2:	f018                	sd	a4,32(s0)
    10f4:	f41c                	sd	a5,40(s0)
    10f6:	03043823          	sd	a6,48(s0)
    10fa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    10fe:	00840613          	addi	a2,s0,8
    1102:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1106:	85aa                	mv	a1,a0
    1108:	4505                	li	a0,1
    110a:	ce3ff0ef          	jal	dec <vprintf>
}
    110e:	60e2                	ld	ra,24(sp)
    1110:	6442                	ld	s0,16(sp)
    1112:	6125                	addi	sp,sp,96
    1114:	8082                	ret

0000000000001116 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1116:	1141                	addi	sp,sp,-16
    1118:	e406                	sd	ra,8(sp)
    111a:	e022                	sd	s0,0(sp)
    111c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    111e:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1122:	00001797          	auipc	a5,0x1
    1126:	eee7b783          	ld	a5,-274(a5) # 2010 <freep>
    112a:	a095                	j	118e <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    112c:	ff852583          	lw	a1,-8(a0)
    1130:	6390                	ld	a2,0(a5)
    1132:	02059813          	slli	a6,a1,0x20
    1136:	01c85693          	srli	a3,a6,0x1c
    113a:	96ba                	add	a3,a3,a4
    113c:	02d60563          	beq	a2,a3,1166 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    1140:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1144:	4790                	lw	a2,8(a5)
    1146:	02061593          	slli	a1,a2,0x20
    114a:	01c5d693          	srli	a3,a1,0x1c
    114e:	96be                	add	a3,a3,a5
    1150:	02d70263          	beq	a4,a3,1174 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    1154:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1156:	00001717          	auipc	a4,0x1
    115a:	eaf73d23          	sd	a5,-326(a4) # 2010 <freep>
}
    115e:	60a2                	ld	ra,8(sp)
    1160:	6402                	ld	s0,0(sp)
    1162:	0141                	addi	sp,sp,16
    1164:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
    1166:	4614                	lw	a3,8(a2)
    1168:	9ead                	addw	a3,a3,a1
    116a:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    116e:	6394                	ld	a3,0(a5)
    1170:	6290                	ld	a2,0(a3)
    1172:	b7f9                	j	1140 <free+0x2a>
    p->s.size += bp->s.size;
    1174:	ff852703          	lw	a4,-8(a0)
    1178:	9f31                	addw	a4,a4,a2
    117a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    117c:	ff053703          	ld	a4,-16(a0)
    1180:	bfd1                	j	1154 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1182:	6394                	ld	a3,0(a5)
    1184:	00d7e463          	bltu	a5,a3,118c <free+0x76>
    1188:	fad762e3          	bltu	a4,a3,112c <free+0x16>
    118c:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    118e:	fee7fae3          	bgeu	a5,a4,1182 <free+0x6c>
    1192:	6394                	ld	a3,0(a5)
    1194:	f8d76ce3          	bltu	a4,a3,112c <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1198:	f8d7fae3          	bgeu	a5,a3,112c <free+0x16>
    119c:	87b6                	mv	a5,a3
    119e:	bfc5                	j	118e <free+0x78>

00000000000011a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    11a0:	7139                	addi	sp,sp,-64
    11a2:	fc06                	sd	ra,56(sp)
    11a4:	f822                	sd	s0,48(sp)
    11a6:	f04a                	sd	s2,32(sp)
    11a8:	ec4e                	sd	s3,24(sp)
    11aa:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11ac:	02051993          	slli	s3,a0,0x20
    11b0:	0209d993          	srli	s3,s3,0x20
    11b4:	09bd                	addi	s3,s3,15
    11b6:	0049d993          	srli	s3,s3,0x4
    11ba:	2985                	addiw	s3,s3,1
    11bc:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
    11be:	00001517          	auipc	a0,0x1
    11c2:	e5253503          	ld	a0,-430(a0) # 2010 <freep>
    11c6:	c905                	beqz	a0,11f6 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11c8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    11ca:	4798                	lw	a4,8(a5)
    11cc:	09377663          	bgeu	a4,s3,1258 <malloc+0xb8>
    11d0:	f426                	sd	s1,40(sp)
    11d2:	e852                	sd	s4,16(sp)
    11d4:	e456                	sd	s5,8(sp)
    11d6:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    11d8:	8a4e                	mv	s4,s3
    11da:	6705                	lui	a4,0x1
    11dc:	00e9f363          	bgeu	s3,a4,11e2 <malloc+0x42>
    11e0:	6a05                	lui	s4,0x1
    11e2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    11e6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    11ea:	00001497          	auipc	s1,0x1
    11ee:	e2648493          	addi	s1,s1,-474 # 2010 <freep>
  if(p == SBRK_ERROR)
    11f2:	5afd                	li	s5,-1
    11f4:	a83d                	j	1232 <malloc+0x92>
    11f6:	f426                	sd	s1,40(sp)
    11f8:	e852                	sd	s4,16(sp)
    11fa:	e456                	sd	s5,8(sp)
    11fc:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    11fe:	00001797          	auipc	a5,0x1
    1202:	e8a78793          	addi	a5,a5,-374 # 2088 <base>
    1206:	00001717          	auipc	a4,0x1
    120a:	e0f73523          	sd	a5,-502(a4) # 2010 <freep>
    120e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1210:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1214:	b7d1                	j	11d8 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    1216:	6398                	ld	a4,0(a5)
    1218:	e118                	sd	a4,0(a0)
    121a:	a899                	j	1270 <malloc+0xd0>
  hp->s.size = nu;
    121c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1220:	0541                	addi	a0,a0,16
    1222:	ef5ff0ef          	jal	1116 <free>
  return freep;
    1226:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    1228:	c125                	beqz	a0,1288 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    122a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    122c:	4798                	lw	a4,8(a5)
    122e:	03277163          	bgeu	a4,s2,1250 <malloc+0xb0>
    if(p == freep)
    1232:	6098                	ld	a4,0(s1)
    1234:	853e                	mv	a0,a5
    1236:	fef71ae3          	bne	a4,a5,122a <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
    123a:	8552                	mv	a0,s4
    123c:	a17ff0ef          	jal	c52 <sbrk>
  if(p == SBRK_ERROR)
    1240:	fd551ee3          	bne	a0,s5,121c <malloc+0x7c>
        return 0;
    1244:	4501                	li	a0,0
    1246:	74a2                	ld	s1,40(sp)
    1248:	6a42                	ld	s4,16(sp)
    124a:	6aa2                	ld	s5,8(sp)
    124c:	6b02                	ld	s6,0(sp)
    124e:	a03d                	j	127c <malloc+0xdc>
    1250:	74a2                	ld	s1,40(sp)
    1252:	6a42                	ld	s4,16(sp)
    1254:	6aa2                	ld	s5,8(sp)
    1256:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    1258:	fae90fe3          	beq	s2,a4,1216 <malloc+0x76>
        p->s.size -= nunits;
    125c:	4137073b          	subw	a4,a4,s3
    1260:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1262:	02071693          	slli	a3,a4,0x20
    1266:	01c6d713          	srli	a4,a3,0x1c
    126a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    126c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    1270:	00001717          	auipc	a4,0x1
    1274:	daa73023          	sd	a0,-608(a4) # 2010 <freep>
      return (void*)(p + 1);
    1278:	01078513          	addi	a0,a5,16
  }
}
    127c:	70e2                	ld	ra,56(sp)
    127e:	7442                	ld	s0,48(sp)
    1280:	7902                	ld	s2,32(sp)
    1282:	69e2                	ld	s3,24(sp)
    1284:	6121                	addi	sp,sp,64
    1286:	8082                	ret
    1288:	74a2                	ld	s1,40(sp)
    128a:	6a42                	ld	s4,16(sp)
    128c:	6aa2                	ld	s5,8(sp)
    128e:	6b02                	ld	s6,0(sp)
    1290:	b7f5                	j	127c <malloc+0xdc>
