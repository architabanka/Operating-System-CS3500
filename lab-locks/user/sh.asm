
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
      16:	33e58593          	addi	a1,a1,830 # 1350 <statistics+0x7e>
      1a:	8532                	mv	a0,a2
      1c:	489000ef          	jal	ca4 <write>
  memset(buf, 0, nbuf);
      20:	864a                	mv	a2,s2
      22:	4581                	li	a1,0
      24:	8526                	mv	a0,s1
      26:	235000ef          	jal	a5a <memset>
  gets(buf, nbuf);
      2a:	85ca                	mv	a1,s2
      2c:	8526                	mv	a0,s1
      2e:	277000ef          	jal	aa4 <gets>
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
      58:	30c58593          	addi	a1,a1,780 # 1360 <statistics+0x8e>
      5c:	4509                	li	a0,2
      5e:	09c010ef          	jal	10fa <fprintf>
  exit(1);
      62:	4505                	li	a0,1
      64:	421000ef          	jal	c84 <exit>

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
      70:	40d000ef          	jal	c7c <fork>
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
      86:	2e650513          	addi	a0,a0,742 # 1368 <statistics+0x96>
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
      ae:	3e270713          	addi	a4,a4,994 # 148c <statistics+0x1ba>
      b2:	97ba                	add	a5,a5,a4
      b4:	439c                	lw	a5,0(a5)
      b6:	97ba                	add	a5,a5,a4
      b8:	8782                	jr	a5
      ba:	ec26                	sd	s1,24(sp)
    exit(1);
      bc:	4505                	li	a0,1
      be:	3c7000ef          	jal	c84 <exit>
    panic("runcmd");
      c2:	00001517          	auipc	a0,0x1
      c6:	2ae50513          	addi	a0,a0,686 # 1370 <statistics+0x9e>
      ca:	f81ff0ef          	jal	4a <panic>
    if(ecmd->argv[0] == 0)
      ce:	6508                	ld	a0,8(a0)
      d0:	c105                	beqz	a0,f0 <runcmd+0x62>
    exec(ecmd->argv[0], ecmd->argv);
      d2:	00848593          	addi	a1,s1,8
      d6:	3e7000ef          	jal	cbc <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
      da:	6490                	ld	a2,8(s1)
      dc:	00001597          	auipc	a1,0x1
      e0:	29c58593          	addi	a1,a1,668 # 1378 <statistics+0xa6>
      e4:	4509                	li	a0,2
      e6:	014010ef          	jal	10fa <fprintf>
  exit(0);
      ea:	4501                	li	a0,0
      ec:	399000ef          	jal	c84 <exit>
      exit(1);
      f0:	4505                	li	a0,1
      f2:	393000ef          	jal	c84 <exit>
    close(rcmd->fd);
      f6:	5148                	lw	a0,36(a0)
      f8:	3b5000ef          	jal	cac <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      fc:	508c                	lw	a1,32(s1)
      fe:	6888                	ld	a0,16(s1)
     100:	3c5000ef          	jal	cc4 <open>
     104:	00054563          	bltz	a0,10e <runcmd+0x80>
    runcmd(rcmd->cmd);
     108:	6488                	ld	a0,8(s1)
     10a:	f85ff0ef          	jal	8e <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     10e:	6890                	ld	a2,16(s1)
     110:	00001597          	auipc	a1,0x1
     114:	27858593          	addi	a1,a1,632 # 1388 <statistics+0xb6>
     118:	4509                	li	a0,2
     11a:	7e1000ef          	jal	10fa <fprintf>
      exit(1);
     11e:	4505                	li	a0,1
     120:	365000ef          	jal	c84 <exit>
    if(fork1() == 0)
     124:	f45ff0ef          	jal	68 <fork1>
     128:	e501                	bnez	a0,130 <runcmd+0xa2>
      runcmd(lcmd->left);
     12a:	6488                	ld	a0,8(s1)
     12c:	f63ff0ef          	jal	8e <runcmd>
    wait(0);
     130:	4501                	li	a0,0
     132:	35b000ef          	jal	c8c <wait>
    runcmd(lcmd->right);
     136:	6888                	ld	a0,16(s1)
     138:	f57ff0ef          	jal	8e <runcmd>
    if(pipe(p) < 0)
     13c:	fd840513          	addi	a0,s0,-40
     140:	355000ef          	jal	c94 <pipe>
     144:	02054763          	bltz	a0,172 <runcmd+0xe4>
    if(fork1() == 0){
     148:	f21ff0ef          	jal	68 <fork1>
     14c:	e90d                	bnez	a0,17e <runcmd+0xf0>
      close(1);
     14e:	4505                	li	a0,1
     150:	35d000ef          	jal	cac <close>
      dup(p[1]);
     154:	fdc42503          	lw	a0,-36(s0)
     158:	3a5000ef          	jal	cfc <dup>
      close(p[0]);
     15c:	fd842503          	lw	a0,-40(s0)
     160:	34d000ef          	jal	cac <close>
      close(p[1]);
     164:	fdc42503          	lw	a0,-36(s0)
     168:	345000ef          	jal	cac <close>
      runcmd(pcmd->left);
     16c:	6488                	ld	a0,8(s1)
     16e:	f21ff0ef          	jal	8e <runcmd>
      panic("pipe");
     172:	00001517          	auipc	a0,0x1
     176:	22650513          	addi	a0,a0,550 # 1398 <statistics+0xc6>
     17a:	ed1ff0ef          	jal	4a <panic>
    if(fork1() == 0){
     17e:	eebff0ef          	jal	68 <fork1>
     182:	e115                	bnez	a0,1a6 <runcmd+0x118>
      close(0);
     184:	329000ef          	jal	cac <close>
      dup(p[0]);
     188:	fd842503          	lw	a0,-40(s0)
     18c:	371000ef          	jal	cfc <dup>
      close(p[0]);
     190:	fd842503          	lw	a0,-40(s0)
     194:	319000ef          	jal	cac <close>
      close(p[1]);
     198:	fdc42503          	lw	a0,-36(s0)
     19c:	311000ef          	jal	cac <close>
      runcmd(pcmd->right);
     1a0:	6888                	ld	a0,16(s1)
     1a2:	eedff0ef          	jal	8e <runcmd>
    close(p[0]);
     1a6:	fd842503          	lw	a0,-40(s0)
     1aa:	303000ef          	jal	cac <close>
    close(p[1]);
     1ae:	fdc42503          	lw	a0,-36(s0)
     1b2:	2fb000ef          	jal	cac <close>
    wait(0);
     1b6:	4501                	li	a0,0
     1b8:	2d5000ef          	jal	c8c <wait>
    wait(0);
     1bc:	4501                	li	a0,0
     1be:	2cf000ef          	jal	c8c <wait>
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
     1e0:	000010ef          	jal	11e0 <malloc>
     1e4:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     1e6:	0a800613          	li	a2,168
     1ea:	4581                	li	a1,0
     1ec:	06f000ef          	jal	a5a <memset>
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
     222:	7bf000ef          	jal	11e0 <malloc>
     226:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     228:	02800613          	li	a2,40
     22c:	4581                	li	a1,0
     22e:	02d000ef          	jal	a5a <memset>
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
     274:	76d000ef          	jal	11e0 <malloc>
     278:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     27a:	4661                	li	a2,24
     27c:	4581                	li	a1,0
     27e:	7dc000ef          	jal	a5a <memset>
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
     2b2:	72f000ef          	jal	11e0 <malloc>
     2b6:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2b8:	4661                	li	a2,24
     2ba:	4581                	li	a1,0
     2bc:	79e000ef          	jal	a5a <memset>
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
     2ec:	6f5000ef          	jal	11e0 <malloc>
     2f0:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2f2:	4641                	li	a2,16
     2f4:	4581                	li	a1,0
     2f6:	764000ef          	jal	a5a <memset>
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
     340:	740000ef          	jal	a80 <strchr>
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
     38a:	6f6000ef          	jal	a80 <strchr>
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
     3da:	6a6000ef          	jal	a80 <strchr>
     3de:	e539                	bnez	a0,42c <gettoken+0x11c>
     3e0:	0004c583          	lbu	a1,0(s1)
     3e4:	8556                	mv	a0,s5
     3e6:	69a000ef          	jal	a80 <strchr>
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
     468:	618000ef          	jal	a80 <strchr>
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
     496:	5ea000ef          	jal	a80 <strchr>
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
     4c4:	f00b0b13          	addi	s6,s6,-256 # 13c0 <statistics+0xee>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     4c8:	f9040c93          	addi	s9,s0,-112
     4cc:	f9840c13          	addi	s8,s0,-104
     4d0:	06100b93          	li	s7,97
  while(peek(ps, es, "<>")){
     4d4:	a889                	j	526 <parseredirs+0x86>
      panic("missing file for redirection");
     4d6:	00001517          	auipc	a0,0x1
     4da:	eca50513          	addi	a0,a0,-310 # 13a0 <statistics+0xce>
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
     59c:	e3060613          	addi	a2,a2,-464 # 13c8 <statistics+0xf6>
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
     5d0:	e1cb0b13          	addi	s6,s6,-484 # 13e8 <statistics+0x116>
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
     602:	dd250513          	addi	a0,a0,-558 # 13d0 <statistics+0xfe>
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
     650:	d8c50513          	addi	a0,a0,-628 # 13d8 <statistics+0x106>
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
     698:	d5c60613          	addi	a2,a2,-676 # 13f0 <statistics+0x11e>
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
     6f6:	d06a0a13          	addi	s4,s4,-762 # 13f8 <statistics+0x126>
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
     720:	ce460613          	addi	a2,a2,-796 # 1400 <statistics+0x12e>
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
     776:	c5660613          	addi	a2,a2,-938 # 13c8 <statistics+0xf6>
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
     79a:	c8260613          	addi	a2,a2,-894 # 1418 <statistics+0x146>
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
     7d0:	c3c50513          	addi	a0,a0,-964 # 1408 <statistics+0x136>
     7d4:	877ff0ef          	jal	4a <panic>
    panic("syntax - missing )");
     7d8:	00001517          	auipc	a0,0x1
     7dc:	c4850513          	addi	a0,a0,-952 # 1420 <statistics+0x14e>
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
     804:	ca470713          	addi	a4,a4,-860 # 14a4 <statistics+0x1d2>
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
     878:	1b6000ef          	jal	a2e <strlen>
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
     894:	ac860613          	addi	a2,a2,-1336 # 1358 <statistics+0x86>
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
     8c2:	b7a58593          	addi	a1,a1,-1158 # 1438 <statistics+0x166>
     8c6:	4509                	li	a0,2
     8c8:	033000ef          	jal	10fa <fprintf>
    panic("syntax");
     8cc:	00001517          	auipc	a0,0x1
     8d0:	b0450513          	addi	a0,a0,-1276 # 13d0 <statistics+0xfe>
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
     8f2:	b5a90913          	addi	s2,s2,-1190 # 1448 <statistics+0x176>
     8f6:	85a6                	mv	a1,s1
     8f8:	854a                	mv	a0,s2
     8fa:	3ca000ef          	jal	cc4 <open>
     8fe:	00054663          	bltz	a0,90a <main+0x32>
    if(fd >= 3){
     902:	fea4dae3          	bge	s1,a0,8f6 <main+0x1e>
      close(fd);
     906:	3a6000ef          	jal	cac <close>
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
     92a:	362000ef          	jal	c8c <wait>
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
     98e:	0a0000ef          	jal	a2e <strlen>
     992:	fff5079b          	addiw	a5,a0,-1
     996:	1782                	slli	a5,a5,0x20
     998:	9381                	srli	a5,a5,0x20
     99a:	97a6                	add	a5,a5,s1
     99c:	00078023          	sb	zero,0(a5)
      if(chdir(cmd+3) < 0)
     9a0:	048d                	addi	s1,s1,3
     9a2:	8526                	mv	a0,s1
     9a4:	350000ef          	jal	cf4 <chdir>
     9a8:	f80553e3          	bgez	a0,92e <main+0x56>
        fprintf(2, "cannot cd %s\n", cmd+3);
     9ac:	8626                	mv	a2,s1
     9ae:	00001597          	auipc	a1,0x1
     9b2:	aa258593          	addi	a1,a1,-1374 # 1450 <statistics+0x17e>
     9b6:	4509                	li	a0,2
     9b8:	742000ef          	jal	10fa <fprintf>
     9bc:	bf8d                	j	92e <main+0x56>
        runcmd(parsecmd(cmd));
     9be:	8526                	mv	a0,s1
     9c0:	ea5ff0ef          	jal	864 <parsecmd>
     9c4:	ecaff0ef          	jal	8e <runcmd>
  exit(0);
     9c8:	4501                	li	a0,0
     9ca:	2ba000ef          	jal	c84 <exit>

00000000000009ce <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     9ce:	1141                	addi	sp,sp,-16
     9d0:	e406                	sd	ra,8(sp)
     9d2:	e022                	sd	s0,0(sp)
     9d4:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     9d6:	f03ff0ef          	jal	8d8 <main>
  exit(r);
     9da:	2aa000ef          	jal	c84 <exit>

00000000000009de <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     9de:	1141                	addi	sp,sp,-16
     9e0:	e406                	sd	ra,8(sp)
     9e2:	e022                	sd	s0,0(sp)
     9e4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     9e6:	87aa                	mv	a5,a0
     9e8:	0585                	addi	a1,a1,1
     9ea:	0785                	addi	a5,a5,1
     9ec:	fff5c703          	lbu	a4,-1(a1)
     9f0:	fee78fa3          	sb	a4,-1(a5)
     9f4:	fb75                	bnez	a4,9e8 <strcpy+0xa>
    ;
  return os;
}
     9f6:	60a2                	ld	ra,8(sp)
     9f8:	6402                	ld	s0,0(sp)
     9fa:	0141                	addi	sp,sp,16
     9fc:	8082                	ret

00000000000009fe <strcmp>:

int
strcmp(const char *p, const char *q)
{
     9fe:	1141                	addi	sp,sp,-16
     a00:	e406                	sd	ra,8(sp)
     a02:	e022                	sd	s0,0(sp)
     a04:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     a06:	00054783          	lbu	a5,0(a0)
     a0a:	cb91                	beqz	a5,a1e <strcmp+0x20>
     a0c:	0005c703          	lbu	a4,0(a1)
     a10:	00f71763          	bne	a4,a5,a1e <strcmp+0x20>
    p++, q++;
     a14:	0505                	addi	a0,a0,1
     a16:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     a18:	00054783          	lbu	a5,0(a0)
     a1c:	fbe5                	bnez	a5,a0c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
     a1e:	0005c503          	lbu	a0,0(a1)
}
     a22:	40a7853b          	subw	a0,a5,a0
     a26:	60a2                	ld	ra,8(sp)
     a28:	6402                	ld	s0,0(sp)
     a2a:	0141                	addi	sp,sp,16
     a2c:	8082                	ret

0000000000000a2e <strlen>:

uint
strlen(const char *s)
{
     a2e:	1141                	addi	sp,sp,-16
     a30:	e406                	sd	ra,8(sp)
     a32:	e022                	sd	s0,0(sp)
     a34:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     a36:	00054783          	lbu	a5,0(a0)
     a3a:	cf91                	beqz	a5,a56 <strlen+0x28>
     a3c:	00150793          	addi	a5,a0,1
     a40:	86be                	mv	a3,a5
     a42:	0785                	addi	a5,a5,1
     a44:	fff7c703          	lbu	a4,-1(a5)
     a48:	ff65                	bnez	a4,a40 <strlen+0x12>
     a4a:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
     a4e:	60a2                	ld	ra,8(sp)
     a50:	6402                	ld	s0,0(sp)
     a52:	0141                	addi	sp,sp,16
     a54:	8082                	ret
  for(n = 0; s[n]; n++)
     a56:	4501                	li	a0,0
     a58:	bfdd                	j	a4e <strlen+0x20>

0000000000000a5a <memset>:

void*
memset(void *dst, int c, uint n)
{
     a5a:	1141                	addi	sp,sp,-16
     a5c:	e406                	sd	ra,8(sp)
     a5e:	e022                	sd	s0,0(sp)
     a60:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     a62:	ca19                	beqz	a2,a78 <memset+0x1e>
     a64:	87aa                	mv	a5,a0
     a66:	1602                	slli	a2,a2,0x20
     a68:	9201                	srli	a2,a2,0x20
     a6a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     a6e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     a72:	0785                	addi	a5,a5,1
     a74:	fee79de3          	bne	a5,a4,a6e <memset+0x14>
  }
  return dst;
}
     a78:	60a2                	ld	ra,8(sp)
     a7a:	6402                	ld	s0,0(sp)
     a7c:	0141                	addi	sp,sp,16
     a7e:	8082                	ret

0000000000000a80 <strchr>:

char*
strchr(const char *s, char c)
{
     a80:	1141                	addi	sp,sp,-16
     a82:	e406                	sd	ra,8(sp)
     a84:	e022                	sd	s0,0(sp)
     a86:	0800                	addi	s0,sp,16
  for(; *s; s++)
     a88:	00054783          	lbu	a5,0(a0)
     a8c:	c799                	beqz	a5,a9a <strchr+0x1a>
    if(*s == c)
     a8e:	00f58763          	beq	a1,a5,a9c <strchr+0x1c>
  for(; *s; s++)
     a92:	0505                	addi	a0,a0,1
     a94:	00054783          	lbu	a5,0(a0)
     a98:	fbfd                	bnez	a5,a8e <strchr+0xe>
      return (char*)s;
  return 0;
     a9a:	4501                	li	a0,0
}
     a9c:	60a2                	ld	ra,8(sp)
     a9e:	6402                	ld	s0,0(sp)
     aa0:	0141                	addi	sp,sp,16
     aa2:	8082                	ret

0000000000000aa4 <gets>:

char*
gets(char *buf, int max)
{
     aa4:	711d                	addi	sp,sp,-96
     aa6:	ec86                	sd	ra,88(sp)
     aa8:	e8a2                	sd	s0,80(sp)
     aaa:	e4a6                	sd	s1,72(sp)
     aac:	e0ca                	sd	s2,64(sp)
     aae:	fc4e                	sd	s3,56(sp)
     ab0:	f852                	sd	s4,48(sp)
     ab2:	f456                	sd	s5,40(sp)
     ab4:	f05a                	sd	s6,32(sp)
     ab6:	ec5e                	sd	s7,24(sp)
     ab8:	e862                	sd	s8,16(sp)
     aba:	1080                	addi	s0,sp,96
     abc:	8baa                	mv	s7,a0
     abe:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ac0:	892a                	mv	s2,a0
     ac2:	4481                	li	s1,0
    cc = read(0, &c, 1);
     ac4:	faf40b13          	addi	s6,s0,-81
     ac8:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
     aca:	8c26                	mv	s8,s1
     acc:	0014899b          	addiw	s3,s1,1
     ad0:	84ce                	mv	s1,s3
     ad2:	0349d863          	bge	s3,s4,b02 <gets+0x5e>
    cc = read(0, &c, 1);
     ad6:	8656                	mv	a2,s5
     ad8:	85da                	mv	a1,s6
     ada:	4501                	li	a0,0
     adc:	1c0000ef          	jal	c9c <read>
    if(cc < 1)
     ae0:	02a05163          	blez	a0,b02 <gets+0x5e>
      break;
    buf[i++] = c;
     ae4:	faf44783          	lbu	a5,-81(s0)
     ae8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     aec:	0905                	addi	s2,s2,1
     aee:	ff678713          	addi	a4,a5,-10
     af2:	00173713          	seqz	a4,a4
     af6:	17cd                	addi	a5,a5,-13
     af8:	0017b793          	seqz	a5,a5
     afc:	8fd9                	or	a5,a5,a4
     afe:	d7f1                	beqz	a5,aca <gets+0x26>
    buf[i++] = c;
     b00:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
     b02:	9c5e                	add	s8,s8,s7
     b04:	000c0023          	sb	zero,0(s8)
  return buf;
}
     b08:	855e                	mv	a0,s7
     b0a:	60e6                	ld	ra,88(sp)
     b0c:	6446                	ld	s0,80(sp)
     b0e:	64a6                	ld	s1,72(sp)
     b10:	6906                	ld	s2,64(sp)
     b12:	79e2                	ld	s3,56(sp)
     b14:	7a42                	ld	s4,48(sp)
     b16:	7aa2                	ld	s5,40(sp)
     b18:	7b02                	ld	s6,32(sp)
     b1a:	6be2                	ld	s7,24(sp)
     b1c:	6c42                	ld	s8,16(sp)
     b1e:	6125                	addi	sp,sp,96
     b20:	8082                	ret

0000000000000b22 <stat>:

int
stat(const char *n, struct stat *st)
{
     b22:	1101                	addi	sp,sp,-32
     b24:	ec06                	sd	ra,24(sp)
     b26:	e822                	sd	s0,16(sp)
     b28:	e04a                	sd	s2,0(sp)
     b2a:	1000                	addi	s0,sp,32
     b2c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     b2e:	4581                	li	a1,0
     b30:	194000ef          	jal	cc4 <open>
  if(fd < 0)
     b34:	02054263          	bltz	a0,b58 <stat+0x36>
     b38:	e426                	sd	s1,8(sp)
     b3a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     b3c:	85ca                	mv	a1,s2
     b3e:	19e000ef          	jal	cdc <fstat>
     b42:	892a                	mv	s2,a0
  close(fd);
     b44:	8526                	mv	a0,s1
     b46:	166000ef          	jal	cac <close>
  return r;
     b4a:	64a2                	ld	s1,8(sp)
}
     b4c:	854a                	mv	a0,s2
     b4e:	60e2                	ld	ra,24(sp)
     b50:	6442                	ld	s0,16(sp)
     b52:	6902                	ld	s2,0(sp)
     b54:	6105                	addi	sp,sp,32
     b56:	8082                	ret
    return -1;
     b58:	57fd                	li	a5,-1
     b5a:	893e                	mv	s2,a5
     b5c:	bfc5                	j	b4c <stat+0x2a>

0000000000000b5e <atoi>:

int
atoi(const char *s)
{
     b5e:	1141                	addi	sp,sp,-16
     b60:	e406                	sd	ra,8(sp)
     b62:	e022                	sd	s0,0(sp)
     b64:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     b66:	00054683          	lbu	a3,0(a0)
     b6a:	fd06879b          	addiw	a5,a3,-48
     b6e:	0ff7f793          	zext.b	a5,a5
     b72:	4625                	li	a2,9
     b74:	02f66963          	bltu	a2,a5,ba6 <atoi+0x48>
     b78:	872a                	mv	a4,a0
  n = 0;
     b7a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     b7c:	0705                	addi	a4,a4,1
     b7e:	0025179b          	slliw	a5,a0,0x2
     b82:	9fa9                	addw	a5,a5,a0
     b84:	0017979b          	slliw	a5,a5,0x1
     b88:	9fb5                	addw	a5,a5,a3
     b8a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     b8e:	00074683          	lbu	a3,0(a4)
     b92:	fd06879b          	addiw	a5,a3,-48
     b96:	0ff7f793          	zext.b	a5,a5
     b9a:	fef671e3          	bgeu	a2,a5,b7c <atoi+0x1e>
  return n;
}
     b9e:	60a2                	ld	ra,8(sp)
     ba0:	6402                	ld	s0,0(sp)
     ba2:	0141                	addi	sp,sp,16
     ba4:	8082                	ret
  n = 0;
     ba6:	4501                	li	a0,0
     ba8:	bfdd                	j	b9e <atoi+0x40>

0000000000000baa <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     baa:	1141                	addi	sp,sp,-16
     bac:	e406                	sd	ra,8(sp)
     bae:	e022                	sd	s0,0(sp)
     bb0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     bb2:	02b57563          	bgeu	a0,a1,bdc <memmove+0x32>
    while(n-- > 0)
     bb6:	00c05f63          	blez	a2,bd4 <memmove+0x2a>
     bba:	1602                	slli	a2,a2,0x20
     bbc:	9201                	srli	a2,a2,0x20
     bbe:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     bc2:	872a                	mv	a4,a0
      *dst++ = *src++;
     bc4:	0585                	addi	a1,a1,1
     bc6:	0705                	addi	a4,a4,1
     bc8:	fff5c683          	lbu	a3,-1(a1)
     bcc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     bd0:	fee79ae3          	bne	a5,a4,bc4 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     bd4:	60a2                	ld	ra,8(sp)
     bd6:	6402                	ld	s0,0(sp)
     bd8:	0141                	addi	sp,sp,16
     bda:	8082                	ret
    while(n-- > 0)
     bdc:	fec05ce3          	blez	a2,bd4 <memmove+0x2a>
    dst += n;
     be0:	00c50733          	add	a4,a0,a2
    src += n;
     be4:	95b2                	add	a1,a1,a2
     be6:	fff6079b          	addiw	a5,a2,-1
     bea:	1782                	slli	a5,a5,0x20
     bec:	9381                	srli	a5,a5,0x20
     bee:	fff7c793          	not	a5,a5
     bf2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     bf4:	15fd                	addi	a1,a1,-1
     bf6:	177d                	addi	a4,a4,-1
     bf8:	0005c683          	lbu	a3,0(a1)
     bfc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     c00:	fef71ae3          	bne	a4,a5,bf4 <memmove+0x4a>
     c04:	bfc1                	j	bd4 <memmove+0x2a>

0000000000000c06 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     c06:	1141                	addi	sp,sp,-16
     c08:	e406                	sd	ra,8(sp)
     c0a:	e022                	sd	s0,0(sp)
     c0c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     c0e:	ce19                	beqz	a2,c2c <memcmp+0x26>
     c10:	1602                	slli	a2,a2,0x20
     c12:	9201                	srli	a2,a2,0x20
     c14:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
     c18:	00054783          	lbu	a5,0(a0)
     c1c:	0005c703          	lbu	a4,0(a1)
     c20:	00e79b63          	bne	a5,a4,c36 <memcmp+0x30>
      return *p1 - *p2;
    }
    p1++;
     c24:	0505                	addi	a0,a0,1
    p2++;
     c26:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     c28:	fed518e3          	bne	a0,a3,c18 <memcmp+0x12>
  }
  return 0;
     c2c:	4501                	li	a0,0
}
     c2e:	60a2                	ld	ra,8(sp)
     c30:	6402                	ld	s0,0(sp)
     c32:	0141                	addi	sp,sp,16
     c34:	8082                	ret
      return *p1 - *p2;
     c36:	40e7853b          	subw	a0,a5,a4
     c3a:	bfd5                	j	c2e <memcmp+0x28>

0000000000000c3c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     c3c:	1141                	addi	sp,sp,-16
     c3e:	e406                	sd	ra,8(sp)
     c40:	e022                	sd	s0,0(sp)
     c42:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     c44:	f67ff0ef          	jal	baa <memmove>
}
     c48:	60a2                	ld	ra,8(sp)
     c4a:	6402                	ld	s0,0(sp)
     c4c:	0141                	addi	sp,sp,16
     c4e:	8082                	ret

0000000000000c50 <sbrk>:

char *
sbrk(int n) {
     c50:	1141                	addi	sp,sp,-16
     c52:	e406                	sd	ra,8(sp)
     c54:	e022                	sd	s0,0(sp)
     c56:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
     c58:	4585                	li	a1,1
     c5a:	0b2000ef          	jal	d0c <sys_sbrk>
}
     c5e:	60a2                	ld	ra,8(sp)
     c60:	6402                	ld	s0,0(sp)
     c62:	0141                	addi	sp,sp,16
     c64:	8082                	ret

0000000000000c66 <sbrklazy>:

char *
sbrklazy(int n) {
     c66:	1141                	addi	sp,sp,-16
     c68:	e406                	sd	ra,8(sp)
     c6a:	e022                	sd	s0,0(sp)
     c6c:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
     c6e:	4589                	li	a1,2
     c70:	09c000ef          	jal	d0c <sys_sbrk>
}
     c74:	60a2                	ld	ra,8(sp)
     c76:	6402                	ld	s0,0(sp)
     c78:	0141                	addi	sp,sp,16
     c7a:	8082                	ret

0000000000000c7c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     c7c:	4885                	li	a7,1
 ecall
     c7e:	00000073          	ecall
 ret
     c82:	8082                	ret

0000000000000c84 <exit>:
.global exit
exit:
 li a7, SYS_exit
     c84:	4889                	li	a7,2
 ecall
     c86:	00000073          	ecall
 ret
     c8a:	8082                	ret

0000000000000c8c <wait>:
.global wait
wait:
 li a7, SYS_wait
     c8c:	488d                	li	a7,3
 ecall
     c8e:	00000073          	ecall
 ret
     c92:	8082                	ret

0000000000000c94 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     c94:	4891                	li	a7,4
 ecall
     c96:	00000073          	ecall
 ret
     c9a:	8082                	ret

0000000000000c9c <read>:
.global read
read:
 li a7, SYS_read
     c9c:	4895                	li	a7,5
 ecall
     c9e:	00000073          	ecall
 ret
     ca2:	8082                	ret

0000000000000ca4 <write>:
.global write
write:
 li a7, SYS_write
     ca4:	48c1                	li	a7,16
 ecall
     ca6:	00000073          	ecall
 ret
     caa:	8082                	ret

0000000000000cac <close>:
.global close
close:
 li a7, SYS_close
     cac:	48d5                	li	a7,21
 ecall
     cae:	00000073          	ecall
 ret
     cb2:	8082                	ret

0000000000000cb4 <kill>:
.global kill
kill:
 li a7, SYS_kill
     cb4:	4899                	li	a7,6
 ecall
     cb6:	00000073          	ecall
 ret
     cba:	8082                	ret

0000000000000cbc <exec>:
.global exec
exec:
 li a7, SYS_exec
     cbc:	489d                	li	a7,7
 ecall
     cbe:	00000073          	ecall
 ret
     cc2:	8082                	ret

0000000000000cc4 <open>:
.global open
open:
 li a7, SYS_open
     cc4:	48bd                	li	a7,15
 ecall
     cc6:	00000073          	ecall
 ret
     cca:	8082                	ret

0000000000000ccc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     ccc:	48c5                	li	a7,17
 ecall
     cce:	00000073          	ecall
 ret
     cd2:	8082                	ret

0000000000000cd4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     cd4:	48c9                	li	a7,18
 ecall
     cd6:	00000073          	ecall
 ret
     cda:	8082                	ret

0000000000000cdc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     cdc:	48a1                	li	a7,8
 ecall
     cde:	00000073          	ecall
 ret
     ce2:	8082                	ret

0000000000000ce4 <link>:
.global link
link:
 li a7, SYS_link
     ce4:	48cd                	li	a7,19
 ecall
     ce6:	00000073          	ecall
 ret
     cea:	8082                	ret

0000000000000cec <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     cec:	48d1                	li	a7,20
 ecall
     cee:	00000073          	ecall
 ret
     cf2:	8082                	ret

0000000000000cf4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     cf4:	48a5                	li	a7,9
 ecall
     cf6:	00000073          	ecall
 ret
     cfa:	8082                	ret

0000000000000cfc <dup>:
.global dup
dup:
 li a7, SYS_dup
     cfc:	48a9                	li	a7,10
 ecall
     cfe:	00000073          	ecall
 ret
     d02:	8082                	ret

0000000000000d04 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     d04:	48ad                	li	a7,11
 ecall
     d06:	00000073          	ecall
 ret
     d0a:	8082                	ret

0000000000000d0c <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     d0c:	48b1                	li	a7,12
 ecall
     d0e:	00000073          	ecall
 ret
     d12:	8082                	ret

0000000000000d14 <pause>:
.global pause
pause:
 li a7, SYS_pause
     d14:	48b5                	li	a7,13
 ecall
     d16:	00000073          	ecall
 ret
     d1a:	8082                	ret

0000000000000d1c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     d1c:	48b9                	li	a7,14
 ecall
     d1e:	00000073          	ecall
 ret
     d22:	8082                	ret

0000000000000d24 <bind>:
.global bind
bind:
 li a7, SYS_bind
     d24:	48f5                	li	a7,29
 ecall
     d26:	00000073          	ecall
 ret
     d2a:	8082                	ret

0000000000000d2c <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
     d2c:	48f9                	li	a7,30
 ecall
     d2e:	00000073          	ecall
 ret
     d32:	8082                	ret

0000000000000d34 <send>:
.global send
send:
 li a7, SYS_send
     d34:	48fd                	li	a7,31
 ecall
     d36:	00000073          	ecall
 ret
     d3a:	8082                	ret

0000000000000d3c <recv>:
.global recv
recv:
 li a7, SYS_recv
     d3c:	02000893          	li	a7,32
 ecall
     d40:	00000073          	ecall
 ret
     d44:	8082                	ret

0000000000000d46 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
     d46:	02100893          	li	a7,33
 ecall
     d4a:	00000073          	ecall
 ret
     d4e:	8082                	ret

0000000000000d50 <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
     d50:	02200893          	li	a7,34
 ecall
     d54:	00000073          	ecall
 ret
     d58:	8082                	ret

0000000000000d5a <rwlktest>:
.global rwlktest
rwlktest:
 li a7, SYS_rwlktest
     d5a:	02300893          	li	a7,35
 ecall
     d5e:	00000073          	ecall
 ret
     d62:	8082                	ret

0000000000000d64 <cpupin>:
.global cpupin
cpupin:
 li a7, SYS_cpupin
     d64:	02400893          	li	a7,36
 ecall
     d68:	00000073          	ecall
 ret
     d6c:	8082                	ret

0000000000000d6e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     d6e:	1101                	addi	sp,sp,-32
     d70:	ec06                	sd	ra,24(sp)
     d72:	e822                	sd	s0,16(sp)
     d74:	1000                	addi	s0,sp,32
     d76:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     d7a:	4605                	li	a2,1
     d7c:	fef40593          	addi	a1,s0,-17
     d80:	f25ff0ef          	jal	ca4 <write>
}
     d84:	60e2                	ld	ra,24(sp)
     d86:	6442                	ld	s0,16(sp)
     d88:	6105                	addi	sp,sp,32
     d8a:	8082                	ret

0000000000000d8c <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     d8c:	715d                	addi	sp,sp,-80
     d8e:	e486                	sd	ra,72(sp)
     d90:	e0a2                	sd	s0,64(sp)
     d92:	f84a                	sd	s2,48(sp)
     d94:	f44e                	sd	s3,40(sp)
     d96:	0880                	addi	s0,sp,80
     d98:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
     d9a:	00d036b3          	snez	a3,a3
     d9e:	03f5d793          	srli	a5,a1,0x3f
     da2:	8efd                	and	a3,a3,a5
  neg = 0;
     da4:	4301                	li	t1,0
  if(sgn && xx < 0){
     da6:	c681                	beqz	a3,dae <printint+0x22>
    neg = 1;
    x = -xx;
     da8:	40b005b3          	neg	a1,a1
    neg = 1;
     dac:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
     dae:	fb840993          	addi	s3,s0,-72
  neg = 0;
     db2:	86ce                	mv	a3,s3
  i = 0;
     db4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     db6:	00000817          	auipc	a6,0x0
     dba:	70a80813          	addi	a6,a6,1802 # 14c0 <digits>
     dbe:	88ba                	mv	a7,a4
     dc0:	0017051b          	addiw	a0,a4,1
     dc4:	872a                	mv	a4,a0
     dc6:	02c5f7b3          	remu	a5,a1,a2
     dca:	97c2                	add	a5,a5,a6
     dcc:	0007c783          	lbu	a5,0(a5)
     dd0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     dd4:	87ae                	mv	a5,a1
     dd6:	02c5d5b3          	divu	a1,a1,a2
     dda:	0685                	addi	a3,a3,1
     ddc:	fec7f1e3          	bgeu	a5,a2,dbe <printint+0x32>
  if(neg)
     de0:	00030b63          	beqz	t1,df6 <printint+0x6a>
    buf[i++] = '-';
     de4:	fd040793          	addi	a5,s0,-48
     de8:	953e                	add	a0,a0,a5
     dea:	02d00793          	li	a5,45
     dee:	fef50423          	sb	a5,-24(a0)
     df2:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
     df6:	02e05563          	blez	a4,e20 <printint+0x94>
     dfa:	fc26                	sd	s1,56(sp)
     dfc:	377d                	addiw	a4,a4,-1
     dfe:	00e984b3          	add	s1,s3,a4
     e02:	19fd                	addi	s3,s3,-1
     e04:	99ba                	add	s3,s3,a4
     e06:	1702                	slli	a4,a4,0x20
     e08:	9301                	srli	a4,a4,0x20
     e0a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     e0e:	0004c583          	lbu	a1,0(s1)
     e12:	854a                	mv	a0,s2
     e14:	f5bff0ef          	jal	d6e <putc>
  while(--i >= 0)
     e18:	14fd                	addi	s1,s1,-1
     e1a:	ff349ae3          	bne	s1,s3,e0e <printint+0x82>
     e1e:	74e2                	ld	s1,56(sp)
}
     e20:	60a6                	ld	ra,72(sp)
     e22:	6406                	ld	s0,64(sp)
     e24:	7942                	ld	s2,48(sp)
     e26:	79a2                	ld	s3,40(sp)
     e28:	6161                	addi	sp,sp,80
     e2a:	8082                	ret

0000000000000e2c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     e2c:	711d                	addi	sp,sp,-96
     e2e:	ec86                	sd	ra,88(sp)
     e30:	e8a2                	sd	s0,80(sp)
     e32:	e4a6                	sd	s1,72(sp)
     e34:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     e36:	0005c483          	lbu	s1,0(a1)
     e3a:	2a048063          	beqz	s1,10da <vprintf+0x2ae>
     e3e:	e0ca                	sd	s2,64(sp)
     e40:	fc4e                	sd	s3,56(sp)
     e42:	f852                	sd	s4,48(sp)
     e44:	f456                	sd	s5,40(sp)
     e46:	f05a                	sd	s6,32(sp)
     e48:	ec5e                	sd	s7,24(sp)
     e4a:	e862                	sd	s8,16(sp)
     e4c:	8b2a                	mv	s6,a0
     e4e:	8a2e                	mv	s4,a1
     e50:	8bb2                	mv	s7,a2
  state = 0;
     e52:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     e54:	4901                	li	s2,0
     e56:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     e58:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     e5c:	06400c13          	li	s8,100
     e60:	a00d                	j	e82 <vprintf+0x56>
        putc(fd, c0);
     e62:	85a6                	mv	a1,s1
     e64:	855a                	mv	a0,s6
     e66:	f09ff0ef          	jal	d6e <putc>
     e6a:	a019                	j	e70 <vprintf+0x44>
    } else if(state == '%'){
     e6c:	03598363          	beq	s3,s5,e92 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
     e70:	0019079b          	addiw	a5,s2,1
     e74:	893e                	mv	s2,a5
     e76:	873e                	mv	a4,a5
     e78:	97d2                	add	a5,a5,s4
     e7a:	0007c483          	lbu	s1,0(a5)
     e7e:	24048763          	beqz	s1,10cc <vprintf+0x2a0>
    c0 = fmt[i] & 0xff;
     e82:	0004879b          	sext.w	a5,s1
    if(state == 0){
     e86:	fe0993e3          	bnez	s3,e6c <vprintf+0x40>
      if(c0 == '%'){
     e8a:	fd579ce3          	bne	a5,s5,e62 <vprintf+0x36>
        state = '%';
     e8e:	89be                	mv	s3,a5
     e90:	b7c5                	j	e70 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
     e92:	00ea06b3          	add	a3,s4,a4
     e96:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
     e9a:	24060563          	beqz	a2,10e4 <vprintf+0x2b8>
      if(c0 == 'd'){
     e9e:	0b878763          	beq	a5,s8,f4c <vprintf+0x120>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     ea2:	f9478693          	addi	a3,a5,-108
     ea6:	0016b693          	seqz	a3,a3
     eaa:	f9c60593          	addi	a1,a2,-100
     eae:	0015b593          	seqz	a1,a1
     eb2:	8df5                	and	a1,a1,a3
     eb4:	e9c5                	bnez	a1,f64 <vprintf+0x138>
      if(c1) c2 = fmt[i+2] & 0xff;
     eb6:	9752                	add	a4,a4,s4
     eb8:	00274503          	lbu	a0,2(a4)
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     ebc:	f9460713          	addi	a4,a2,-108
     ec0:	00173713          	seqz	a4,a4
     ec4:	8f75                	and	a4,a4,a3
     ec6:	f9c50593          	addi	a1,a0,-100
     eca:	0015b593          	seqz	a1,a1
     ece:	8df9                	and	a1,a1,a4
     ed0:	e5dd                	bnez	a1,f7e <vprintf+0x152>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     ed2:	07500593          	li	a1,117
     ed6:	0cb78163          	beq	a5,a1,f98 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint32), 10, 0);
      } else if(c0 == 'l' && c1 == 'u'){
     eda:	f8b60593          	addi	a1,a2,-117
     ede:	0015b593          	seqz	a1,a1
     ee2:	8df5                	and	a1,a1,a3
     ee4:	e5f1                	bnez	a1,fb0 <vprintf+0x184>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     ee6:	f8b50593          	addi	a1,a0,-117
     eea:	0015b593          	seqz	a1,a1
     eee:	8df9                	and	a1,a1,a4
     ef0:	ede9                	bnez	a1,fca <vprintf+0x19e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     ef2:	07800593          	li	a1,120
     ef6:	0eb78763          	beq	a5,a1,fe4 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint32), 16, 0);
      } else if(c0 == 'l' && c1 == 'x'){
     efa:	f8860613          	addi	a2,a2,-120
     efe:	00163613          	seqz	a2,a2
     f02:	8ef1                	and	a3,a3,a2
     f04:	0e069c63          	bnez	a3,ffc <vprintf+0x1d0>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     f08:	f8850513          	addi	a0,a0,-120
     f0c:	00153513          	seqz	a0,a0
     f10:	8f69                	and	a4,a4,a0
     f12:	10071263          	bnez	a4,1016 <vprintf+0x1ea>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     f16:	07000713          	li	a4,112
     f1a:	10e78a63          	beq	a5,a4,102e <vprintf+0x202>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
     f1e:	06300713          	li	a4,99
     f22:	14e78a63          	beq	a5,a4,1076 <vprintf+0x24a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
     f26:	07300713          	li	a4,115
     f2a:	16e78063          	beq	a5,a4,108a <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     f2e:	02500713          	li	a4,37
     f32:	18e78863          	beq	a5,a4,10c2 <vprintf+0x296>
        putc(fd, '%');
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     f36:	02500593          	li	a1,37
     f3a:	855a                	mv	a0,s6
     f3c:	e33ff0ef          	jal	d6e <putc>
        putc(fd, c0);
     f40:	85a6                	mv	a1,s1
     f42:	855a                	mv	a0,s6
     f44:	e2bff0ef          	jal	d6e <putc>
      }

      state = 0;
     f48:	4981                	li	s3,0
     f4a:	b71d                	j	e70 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
     f4c:	008b8493          	addi	s1,s7,8
     f50:	4685                	li	a3,1
     f52:	4629                	li	a2,10
     f54:	000ba583          	lw	a1,0(s7)
     f58:	855a                	mv	a0,s6
     f5a:	e33ff0ef          	jal	d8c <printint>
     f5e:	8ba6                	mv	s7,s1
      state = 0;
     f60:	4981                	li	s3,0
     f62:	b739                	j	e70 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
     f64:	008b8493          	addi	s1,s7,8
     f68:	4685                	li	a3,1
     f6a:	4629                	li	a2,10
     f6c:	000bb583          	ld	a1,0(s7)
     f70:	855a                	mv	a0,s6
     f72:	e1bff0ef          	jal	d8c <printint>
        i += 1;
     f76:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     f78:	8ba6                	mv	s7,s1
      state = 0;
     f7a:	4981                	li	s3,0
     f7c:	bdd5                	j	e70 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 1);
     f7e:	008b8493          	addi	s1,s7,8
     f82:	4685                	li	a3,1
     f84:	4629                	li	a2,10
     f86:	000bb583          	ld	a1,0(s7)
     f8a:	855a                	mv	a0,s6
     f8c:	e01ff0ef          	jal	d8c <printint>
        i += 2;
     f90:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     f92:	8ba6                	mv	s7,s1
      state = 0;
     f94:	4981                	li	s3,0
        i += 2;
     f96:	bde9                	j	e70 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 10, 0);
     f98:	008b8493          	addi	s1,s7,8
     f9c:	4681                	li	a3,0
     f9e:	4629                	li	a2,10
     fa0:	000be583          	lwu	a1,0(s7)
     fa4:	855a                	mv	a0,s6
     fa6:	de7ff0ef          	jal	d8c <printint>
     faa:	8ba6                	mv	s7,s1
      state = 0;
     fac:	4981                	li	s3,0
     fae:	b5c9                	j	e70 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
     fb0:	008b8493          	addi	s1,s7,8
     fb4:	4681                	li	a3,0
     fb6:	4629                	li	a2,10
     fb8:	000bb583          	ld	a1,0(s7)
     fbc:	855a                	mv	a0,s6
     fbe:	dcfff0ef          	jal	d8c <printint>
        i += 1;
     fc2:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     fc4:	8ba6                	mv	s7,s1
      state = 0;
     fc6:	4981                	li	s3,0
     fc8:	b565                	j	e70 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
     fca:	008b8493          	addi	s1,s7,8
     fce:	4681                	li	a3,0
     fd0:	4629                	li	a2,10
     fd2:	000bb583          	ld	a1,0(s7)
     fd6:	855a                	mv	a0,s6
     fd8:	db5ff0ef          	jal	d8c <printint>
        i += 2;
     fdc:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
     fde:	8ba6                	mv	s7,s1
      state = 0;
     fe0:	4981                	li	s3,0
        i += 2;
     fe2:	b579                	j	e70 <vprintf+0x44>
        printint(fd, va_arg(ap, uint32), 16, 0);
     fe4:	008b8493          	addi	s1,s7,8
     fe8:	4681                	li	a3,0
     fea:	4641                	li	a2,16
     fec:	000be583          	lwu	a1,0(s7)
     ff0:	855a                	mv	a0,s6
     ff2:	d9bff0ef          	jal	d8c <printint>
     ff6:	8ba6                	mv	s7,s1
      state = 0;
     ff8:	4981                	li	s3,0
     ffa:	bd9d                	j	e70 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
     ffc:	008b8493          	addi	s1,s7,8
    1000:	4681                	li	a3,0
    1002:	4641                	li	a2,16
    1004:	000bb583          	ld	a1,0(s7)
    1008:	855a                	mv	a0,s6
    100a:	d83ff0ef          	jal	d8c <printint>
        i += 1;
    100e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    1010:	8ba6                	mv	s7,s1
      state = 0;
    1012:	4981                	li	s3,0
    1014:	bdb1                	j	e70 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
    1016:	008b8493          	addi	s1,s7,8
    101a:	4641                	li	a2,16
    101c:	000bb583          	ld	a1,0(s7)
    1020:	855a                	mv	a0,s6
    1022:	d6bff0ef          	jal	d8c <printint>
        i += 2;
    1026:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    1028:	8ba6                	mv	s7,s1
      state = 0;
    102a:	4981                	li	s3,0
        i += 2;
    102c:	b591                	j	e70 <vprintf+0x44>
    102e:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
    1030:	008b8793          	addi	a5,s7,8
    1034:	8cbe                	mv	s9,a5
    1036:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    103a:	03000593          	li	a1,48
    103e:	855a                	mv	a0,s6
    1040:	d2fff0ef          	jal	d6e <putc>
  putc(fd, 'x');
    1044:	07800593          	li	a1,120
    1048:	855a                	mv	a0,s6
    104a:	d25ff0ef          	jal	d6e <putc>
    104e:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1050:	00000b97          	auipc	s7,0x0
    1054:	470b8b93          	addi	s7,s7,1136 # 14c0 <digits>
    1058:	03c9d793          	srli	a5,s3,0x3c
    105c:	97de                	add	a5,a5,s7
    105e:	0007c583          	lbu	a1,0(a5)
    1062:	855a                	mv	a0,s6
    1064:	d0bff0ef          	jal	d6e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1068:	0992                	slli	s3,s3,0x4
    106a:	34fd                	addiw	s1,s1,-1
    106c:	f4f5                	bnez	s1,1058 <vprintf+0x22c>
        printptr(fd, va_arg(ap, uint64));
    106e:	8be6                	mv	s7,s9
      state = 0;
    1070:	4981                	li	s3,0
    1072:	6ca2                	ld	s9,8(sp)
    1074:	bbf5                	j	e70 <vprintf+0x44>
        putc(fd, va_arg(ap, uint32));
    1076:	008b8493          	addi	s1,s7,8
    107a:	000bc583          	lbu	a1,0(s7)
    107e:	855a                	mv	a0,s6
    1080:	cefff0ef          	jal	d6e <putc>
    1084:	8ba6                	mv	s7,s1
      state = 0;
    1086:	4981                	li	s3,0
    1088:	b3e5                	j	e70 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
    108a:	008b8993          	addi	s3,s7,8
    108e:	000bb483          	ld	s1,0(s7)
    1092:	cc91                	beqz	s1,10ae <vprintf+0x282>
        for(; *s; s++)
    1094:	0004c583          	lbu	a1,0(s1)
    1098:	c195                	beqz	a1,10bc <vprintf+0x290>
          putc(fd, *s);
    109a:	855a                	mv	a0,s6
    109c:	cd3ff0ef          	jal	d6e <putc>
        for(; *s; s++)
    10a0:	0485                	addi	s1,s1,1
    10a2:	0004c583          	lbu	a1,0(s1)
    10a6:	f9f5                	bnez	a1,109a <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
    10a8:	8bce                	mv	s7,s3
      state = 0;
    10aa:	4981                	li	s3,0
    10ac:	b3d1                	j	e70 <vprintf+0x44>
          s = "(null)";
    10ae:	00000497          	auipc	s1,0x0
    10b2:	3b248493          	addi	s1,s1,946 # 1460 <statistics+0x18e>
        for(; *s; s++)
    10b6:	02800593          	li	a1,40
    10ba:	b7c5                	j	109a <vprintf+0x26e>
        if((s = va_arg(ap, char*)) == 0)
    10bc:	8bce                	mv	s7,s3
      state = 0;
    10be:	4981                	li	s3,0
    10c0:	bb45                	j	e70 <vprintf+0x44>
        putc(fd, '%');
    10c2:	85be                	mv	a1,a5
    10c4:	855a                	mv	a0,s6
    10c6:	ca9ff0ef          	jal	d6e <putc>
    10ca:	bdbd                	j	f48 <vprintf+0x11c>
    10cc:	6906                	ld	s2,64(sp)
    10ce:	79e2                	ld	s3,56(sp)
    10d0:	7a42                	ld	s4,48(sp)
    10d2:	7aa2                	ld	s5,40(sp)
    10d4:	7b02                	ld	s6,32(sp)
    10d6:	6be2                	ld	s7,24(sp)
    10d8:	6c42                	ld	s8,16(sp)
    }
  }
}
    10da:	60e6                	ld	ra,88(sp)
    10dc:	6446                	ld	s0,80(sp)
    10de:	64a6                	ld	s1,72(sp)
    10e0:	6125                	addi	sp,sp,96
    10e2:	8082                	ret
      if(c0 == 'd'){
    10e4:	06400713          	li	a4,100
    10e8:	e6e782e3          	beq	a5,a4,f4c <vprintf+0x120>
      } else if(c0 == 'l' && c1 == 'd'){
    10ec:	f9478693          	addi	a3,a5,-108
    10f0:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
    10f4:	8532                	mv	a0,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    10f6:	4701                	li	a4,0
    10f8:	bbe9                	j	ed2 <vprintf+0xa6>

00000000000010fa <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    10fa:	715d                	addi	sp,sp,-80
    10fc:	ec06                	sd	ra,24(sp)
    10fe:	e822                	sd	s0,16(sp)
    1100:	1000                	addi	s0,sp,32
    1102:	e010                	sd	a2,0(s0)
    1104:	e414                	sd	a3,8(s0)
    1106:	e818                	sd	a4,16(s0)
    1108:	ec1c                	sd	a5,24(s0)
    110a:	03043023          	sd	a6,32(s0)
    110e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1112:	8622                	mv	a2,s0
    1114:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1118:	d15ff0ef          	jal	e2c <vprintf>
}
    111c:	60e2                	ld	ra,24(sp)
    111e:	6442                	ld	s0,16(sp)
    1120:	6161                	addi	sp,sp,80
    1122:	8082                	ret

0000000000001124 <printf>:

void
printf(const char *fmt, ...)
{
    1124:	711d                	addi	sp,sp,-96
    1126:	ec06                	sd	ra,24(sp)
    1128:	e822                	sd	s0,16(sp)
    112a:	1000                	addi	s0,sp,32
    112c:	e40c                	sd	a1,8(s0)
    112e:	e810                	sd	a2,16(s0)
    1130:	ec14                	sd	a3,24(s0)
    1132:	f018                	sd	a4,32(s0)
    1134:	f41c                	sd	a5,40(s0)
    1136:	03043823          	sd	a6,48(s0)
    113a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    113e:	00840613          	addi	a2,s0,8
    1142:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1146:	85aa                	mv	a1,a0
    1148:	4505                	li	a0,1
    114a:	ce3ff0ef          	jal	e2c <vprintf>
}
    114e:	60e2                	ld	ra,24(sp)
    1150:	6442                	ld	s0,16(sp)
    1152:	6125                	addi	sp,sp,96
    1154:	8082                	ret

0000000000001156 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1156:	1141                	addi	sp,sp,-16
    1158:	e406                	sd	ra,8(sp)
    115a:	e022                	sd	s0,0(sp)
    115c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    115e:	ff050713          	addi	a4,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1162:	00001797          	auipc	a5,0x1
    1166:	eae7b783          	ld	a5,-338(a5) # 2010 <freep>
    116a:	a095                	j	11ce <free+0x78>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    116c:	ff852583          	lw	a1,-8(a0)
    1170:	6390                	ld	a2,0(a5)
    1172:	02059813          	slli	a6,a1,0x20
    1176:	01c85693          	srli	a3,a6,0x1c
    117a:	96ba                	add	a3,a3,a4
    117c:	02d60563          	beq	a2,a3,11a6 <free+0x50>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    1180:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1184:	4790                	lw	a2,8(a5)
    1186:	02061593          	slli	a1,a2,0x20
    118a:	01c5d693          	srli	a3,a1,0x1c
    118e:	96be                	add	a3,a3,a5
    1190:	02d70263          	beq	a4,a3,11b4 <free+0x5e>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    1194:	e398                	sd	a4,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1196:	00001717          	auipc	a4,0x1
    119a:	e6f73d23          	sd	a5,-390(a4) # 2010 <freep>
}
    119e:	60a2                	ld	ra,8(sp)
    11a0:	6402                	ld	s0,0(sp)
    11a2:	0141                	addi	sp,sp,16
    11a4:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
    11a6:	4614                	lw	a3,8(a2)
    11a8:	9ead                	addw	a3,a3,a1
    11aa:	fed52c23          	sw	a3,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    11ae:	6394                	ld	a3,0(a5)
    11b0:	6290                	ld	a2,0(a3)
    11b2:	b7f9                	j	1180 <free+0x2a>
    p->s.size += bp->s.size;
    11b4:	ff852703          	lw	a4,-8(a0)
    11b8:	9f31                	addw	a4,a4,a2
    11ba:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    11bc:	ff053703          	ld	a4,-16(a0)
    11c0:	bfd1                	j	1194 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11c2:	6394                	ld	a3,0(a5)
    11c4:	00d7e463          	bltu	a5,a3,11cc <free+0x76>
    11c8:	fad762e3          	bltu	a4,a3,116c <free+0x16>
    11cc:	87b6                	mv	a5,a3
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11ce:	fee7fae3          	bgeu	a5,a4,11c2 <free+0x6c>
    11d2:	6394                	ld	a3,0(a5)
    11d4:	f8d76ce3          	bltu	a4,a3,116c <free+0x16>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11d8:	f8d7fae3          	bgeu	a5,a3,116c <free+0x16>
    11dc:	87b6                	mv	a5,a3
    11de:	bfc5                	j	11ce <free+0x78>

00000000000011e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    11e0:	7139                	addi	sp,sp,-64
    11e2:	fc06                	sd	ra,56(sp)
    11e4:	f822                	sd	s0,48(sp)
    11e6:	f04a                	sd	s2,32(sp)
    11e8:	ec4e                	sd	s3,24(sp)
    11ea:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11ec:	02051993          	slli	s3,a0,0x20
    11f0:	0209d993          	srli	s3,s3,0x20
    11f4:	09bd                	addi	s3,s3,15
    11f6:	0049d993          	srli	s3,s3,0x4
    11fa:	2985                	addiw	s3,s3,1
    11fc:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
    11fe:	00001517          	auipc	a0,0x1
    1202:	e1253503          	ld	a0,-494(a0) # 2010 <freep>
    1206:	c905                	beqz	a0,1236 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1208:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    120a:	4798                	lw	a4,8(a5)
    120c:	09377663          	bgeu	a4,s3,1298 <malloc+0xb8>
    1210:	f426                	sd	s1,40(sp)
    1212:	e852                	sd	s4,16(sp)
    1214:	e456                	sd	s5,8(sp)
    1216:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    1218:	8a4e                	mv	s4,s3
    121a:	6705                	lui	a4,0x1
    121c:	00e9f363          	bgeu	s3,a4,1222 <malloc+0x42>
    1220:	6a05                	lui	s4,0x1
    1222:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1226:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    122a:	00001497          	auipc	s1,0x1
    122e:	de648493          	addi	s1,s1,-538 # 2010 <freep>
  if(p == SBRK_ERROR)
    1232:	5afd                	li	s5,-1
    1234:	a83d                	j	1272 <malloc+0x92>
    1236:	f426                	sd	s1,40(sp)
    1238:	e852                	sd	s4,16(sp)
    123a:	e456                	sd	s5,8(sp)
    123c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    123e:	00001797          	auipc	a5,0x1
    1242:	e4a78793          	addi	a5,a5,-438 # 2088 <base>
    1246:	00001717          	auipc	a4,0x1
    124a:	dcf73523          	sd	a5,-566(a4) # 2010 <freep>
    124e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1250:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1254:	b7d1                	j	1218 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    1256:	6398                	ld	a4,0(a5)
    1258:	e118                	sd	a4,0(a0)
    125a:	a899                	j	12b0 <malloc+0xd0>
  hp->s.size = nu;
    125c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1260:	0541                	addi	a0,a0,16
    1262:	ef5ff0ef          	jal	1156 <free>
  return freep;
    1266:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    1268:	c125                	beqz	a0,12c8 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    126a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    126c:	4798                	lw	a4,8(a5)
    126e:	03277163          	bgeu	a4,s2,1290 <malloc+0xb0>
    if(p == freep)
    1272:	6098                	ld	a4,0(s1)
    1274:	853e                	mv	a0,a5
    1276:	fef71ae3          	bne	a4,a5,126a <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
    127a:	8552                	mv	a0,s4
    127c:	9d5ff0ef          	jal	c50 <sbrk>
  if(p == SBRK_ERROR)
    1280:	fd551ee3          	bne	a0,s5,125c <malloc+0x7c>
        return 0;
    1284:	4501                	li	a0,0
    1286:	74a2                	ld	s1,40(sp)
    1288:	6a42                	ld	s4,16(sp)
    128a:	6aa2                	ld	s5,8(sp)
    128c:	6b02                	ld	s6,0(sp)
    128e:	a03d                	j	12bc <malloc+0xdc>
    1290:	74a2                	ld	s1,40(sp)
    1292:	6a42                	ld	s4,16(sp)
    1294:	6aa2                	ld	s5,8(sp)
    1296:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    1298:	fae90fe3          	beq	s2,a4,1256 <malloc+0x76>
        p->s.size -= nunits;
    129c:	4137073b          	subw	a4,a4,s3
    12a0:	c798                	sw	a4,8(a5)
        p += p->s.size;
    12a2:	02071693          	slli	a3,a4,0x20
    12a6:	01c6d713          	srli	a4,a3,0x1c
    12aa:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    12ac:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    12b0:	00001717          	auipc	a4,0x1
    12b4:	d6a73023          	sd	a0,-672(a4) # 2010 <freep>
      return (void*)(p + 1);
    12b8:	01078513          	addi	a0,a5,16
  }
}
    12bc:	70e2                	ld	ra,56(sp)
    12be:	7442                	ld	s0,48(sp)
    12c0:	7902                	ld	s2,32(sp)
    12c2:	69e2                	ld	s3,24(sp)
    12c4:	6121                	addi	sp,sp,64
    12c6:	8082                	ret
    12c8:	74a2                	ld	s1,40(sp)
    12ca:	6a42                	ld	s4,16(sp)
    12cc:	6aa2                	ld	s5,8(sp)
    12ce:	6b02                	ld	s6,0(sp)
    12d0:	b7f5                	j	12bc <malloc+0xdc>

00000000000012d2 <statistics>:
#include "kernel/fcntl.h"
#include "user/user.h"

int
statistics(void *buf, int sz)
{
    12d2:	7179                	addi	sp,sp,-48
    12d4:	f406                	sd	ra,40(sp)
    12d6:	f022                	sd	s0,32(sp)
    12d8:	ec26                	sd	s1,24(sp)
    12da:	e84a                	sd	s2,16(sp)
    12dc:	e44e                	sd	s3,8(sp)
    12de:	e052                	sd	s4,0(sp)
    12e0:	1800                	addi	s0,sp,48
    12e2:	8a2a                	mv	s4,a0
    12e4:	892e                	mv	s2,a1
  int fd, i, n;
  
  fd = open("statistics", O_RDONLY);
    12e6:	4581                	li	a1,0
    12e8:	00000517          	auipc	a0,0x0
    12ec:	18050513          	addi	a0,a0,384 # 1468 <statistics+0x196>
    12f0:	9d5ff0ef          	jal	cc4 <open>
  if(fd < 0) {
    12f4:	02054e63          	bltz	a0,1330 <statistics+0x5e>
    12f8:	89aa                	mv	s3,a0
      fprintf(2, "stats: open failed\n");
      exit(1);
  }
  for (i = 0; i < sz; ) {
    12fa:	4481                	li	s1,0
    12fc:	01205e63          	blez	s2,1318 <statistics+0x46>
    if ((n = read(fd, buf+i, sz-i)) < 0) {
    1300:	4099063b          	subw	a2,s2,s1
    1304:	009a05b3          	add	a1,s4,s1
    1308:	854e                	mv	a0,s3
    130a:	993ff0ef          	jal	c9c <read>
    130e:	00054563          	bltz	a0,1318 <statistics+0x46>
      break;
    }
    i += n;
    1312:	9ca9                	addw	s1,s1,a0
  for (i = 0; i < sz; ) {
    1314:	ff24c6e3          	blt	s1,s2,1300 <statistics+0x2e>
  }
  close(fd);
    1318:	854e                	mv	a0,s3
    131a:	993ff0ef          	jal	cac <close>
  return i;
}
    131e:	8526                	mv	a0,s1
    1320:	70a2                	ld	ra,40(sp)
    1322:	7402                	ld	s0,32(sp)
    1324:	64e2                	ld	s1,24(sp)
    1326:	6942                	ld	s2,16(sp)
    1328:	69a2                	ld	s3,8(sp)
    132a:	6a02                	ld	s4,0(sp)
    132c:	6145                	addi	sp,sp,48
    132e:	8082                	ret
      fprintf(2, "stats: open failed\n");
    1330:	00000597          	auipc	a1,0x0
    1334:	14858593          	addi	a1,a1,328 # 1478 <statistics+0x1a6>
    1338:	4509                	li	a0,2
    133a:	dc1ff0ef          	jal	10fa <fprintf>
      exit(1);
    133e:	4505                	li	a0,1
    1340:	945ff0ef          	jal	c84 <exit>
