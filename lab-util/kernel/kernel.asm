
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
_entry:
        # set up a stack for C.
        # stack0 is declared in start.c,
        # with a 4096-byte stack per CPU.
        # sp = stack0 + ((hartid + 1) * 4096)
        la sp, stack0
    80000000:	00019117          	auipc	sp,0x19
    80000004:	a9010113          	addi	sp,sp,-1392 # 80018a90 <stack0>
        li a0, 1024*4
    80000008:	6505                	lui	a0,0x1
        csrr a1, mhartid
    8000000a:	f14025f3          	csrr	a1,mhartid
        addi a1, a1, 1
    8000000e:	0585                	addi	a1,a1,1
        mul a0, a0, a1
    80000010:	02b50533          	mul	a0,a0,a1
        add sp, sp, a0
    80000014:	912a                	add	sp,sp,a0
        # jump to start() in start.c
        call start
    80000016:	56b040ef          	jal	80004d80 <start>

000000008000001a <spin>:
spin:
        j spin
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	00021797          	auipc	a5,0x21
    8000002c:	b4078793          	addi	a5,a5,-1216 # 80020b68 <end>
    80000030:	00f53733          	sltu	a4,a0,a5
    80000034:	47c5                	li	a5,17
    80000036:	07ee                	slli	a5,a5,0x1b
    80000038:	17fd                	addi	a5,a5,-1
    8000003a:	00a7b7b3          	sltu	a5,a5,a0
    8000003e:	8fd9                	or	a5,a5,a4
    80000040:	03451713          	slli	a4,a0,0x34
    80000044:	8fd9                	or	a5,a5,a4
    80000046:	eb9d                	bnez	a5,8000007c <kfree+0x60>
    80000048:	84aa                	mv	s1,a0
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    8000004a:	6605                	lui	a2,0x1
    8000004c:	4585                	li	a1,1
    8000004e:	110000ef          	jal	8000015e <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000052:	00008917          	auipc	s2,0x8
    80000056:	80e90913          	addi	s2,s2,-2034 # 80007860 <kmem>
    8000005a:	854a                	mv	a0,s2
    8000005c:	7b6050ef          	jal	80005812 <acquire>
  r->next = kmem.freelist;
    80000060:	01893783          	ld	a5,24(s2)
    80000064:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000066:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006a:	854a                	mv	a0,s2
    8000006c:	037050ef          	jal	800058a2 <release>
}
    80000070:	60e2                	ld	ra,24(sp)
    80000072:	6442                	ld	s0,16(sp)
    80000074:	64a2                	ld	s1,8(sp)
    80000076:	6902                	ld	s2,0(sp)
    80000078:	6105                	addi	sp,sp,32
    8000007a:	8082                	ret
    panic("kfree");
    8000007c:	00007517          	auipc	a0,0x7
    80000080:	f8450513          	addi	a0,a0,-124 # 80007000 <etext>
    80000084:	4d0050ef          	jal	80005554 <panic>

0000000080000088 <freerange>:
{
    80000088:	7179                	addi	sp,sp,-48
    8000008a:	f406                	sd	ra,40(sp)
    8000008c:	f022                	sd	s0,32(sp)
    8000008e:	ec26                	sd	s1,24(sp)
    80000090:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    80000092:	6785                	lui	a5,0x1
    80000094:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    80000098:	00e504b3          	add	s1,a0,a4
    8000009c:	777d                	lui	a4,0xfffff
    8000009e:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000a0:	94be                	add	s1,s1,a5
    800000a2:	0295e263          	bltu	a1,s1,800000c6 <freerange+0x3e>
    800000a6:	e84a                	sd	s2,16(sp)
    800000a8:	e44e                	sd	s3,8(sp)
    800000aa:	e052                	sd	s4,0(sp)
    800000ac:	892e                	mv	s2,a1
    kfree(p);
    800000ae:	8a3a                	mv	s4,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000b0:	89be                	mv	s3,a5
    kfree(p);
    800000b2:	01448533          	add	a0,s1,s4
    800000b6:	f67ff0ef          	jal	8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ba:	94ce                	add	s1,s1,s3
    800000bc:	fe997be3          	bgeu	s2,s1,800000b2 <freerange+0x2a>
    800000c0:	6942                	ld	s2,16(sp)
    800000c2:	69a2                	ld	s3,8(sp)
    800000c4:	6a02                	ld	s4,0(sp)
}
    800000c6:	70a2                	ld	ra,40(sp)
    800000c8:	7402                	ld	s0,32(sp)
    800000ca:	64e2                	ld	s1,24(sp)
    800000cc:	6145                	addi	sp,sp,48
    800000ce:	8082                	ret

00000000800000d0 <kinit>:
{
    800000d0:	1141                	addi	sp,sp,-16
    800000d2:	e406                	sd	ra,8(sp)
    800000d4:	e022                	sd	s0,0(sp)
    800000d6:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000d8:	00007597          	auipc	a1,0x7
    800000dc:	f3858593          	addi	a1,a1,-200 # 80007010 <etext+0x10>
    800000e0:	00007517          	auipc	a0,0x7
    800000e4:	78050513          	addi	a0,a0,1920 # 80007860 <kmem>
    800000e8:	6a0050ef          	jal	80005788 <initlock>
  freerange(end, (void*)PHYSTOP);
    800000ec:	45c5                	li	a1,17
    800000ee:	05ee                	slli	a1,a1,0x1b
    800000f0:	00021517          	auipc	a0,0x21
    800000f4:	a7850513          	addi	a0,a0,-1416 # 80020b68 <end>
    800000f8:	f91ff0ef          	jal	80000088 <freerange>
}
    800000fc:	60a2                	ld	ra,8(sp)
    800000fe:	6402                	ld	s0,0(sp)
    80000100:	0141                	addi	sp,sp,16
    80000102:	8082                	ret

0000000080000104 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000104:	1101                	addi	sp,sp,-32
    80000106:	ec06                	sd	ra,24(sp)
    80000108:	e822                	sd	s0,16(sp)
    8000010a:	e426                	sd	s1,8(sp)
    8000010c:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    8000010e:	00007517          	auipc	a0,0x7
    80000112:	75250513          	addi	a0,a0,1874 # 80007860 <kmem>
    80000116:	6fc050ef          	jal	80005812 <acquire>
  r = kmem.freelist;
    8000011a:	00007497          	auipc	s1,0x7
    8000011e:	75e4b483          	ld	s1,1886(s1) # 80007878 <kmem+0x18>
  if(r)
    80000122:	c49d                	beqz	s1,80000150 <kalloc+0x4c>
    kmem.freelist = r->next;
    80000124:	609c                	ld	a5,0(s1)
    80000126:	00007717          	auipc	a4,0x7
    8000012a:	74f73923          	sd	a5,1874(a4) # 80007878 <kmem+0x18>
  release(&kmem.lock);
    8000012e:	00007517          	auipc	a0,0x7
    80000132:	73250513          	addi	a0,a0,1842 # 80007860 <kmem>
    80000136:	76c050ef          	jal	800058a2 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000013a:	6605                	lui	a2,0x1
    8000013c:	4595                	li	a1,5
    8000013e:	8526                	mv	a0,s1
    80000140:	01e000ef          	jal	8000015e <memset>
  return (void*)r;
}
    80000144:	8526                	mv	a0,s1
    80000146:	60e2                	ld	ra,24(sp)
    80000148:	6442                	ld	s0,16(sp)
    8000014a:	64a2                	ld	s1,8(sp)
    8000014c:	6105                	addi	sp,sp,32
    8000014e:	8082                	ret
  release(&kmem.lock);
    80000150:	00007517          	auipc	a0,0x7
    80000154:	71050513          	addi	a0,a0,1808 # 80007860 <kmem>
    80000158:	74a050ef          	jal	800058a2 <release>
  if(r)
    8000015c:	b7e5                	j	80000144 <kalloc+0x40>

000000008000015e <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    8000015e:	1141                	addi	sp,sp,-16
    80000160:	e406                	sd	ra,8(sp)
    80000162:	e022                	sd	s0,0(sp)
    80000164:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000166:	ca19                	beqz	a2,8000017c <memset+0x1e>
    80000168:	87aa                	mv	a5,a0
    8000016a:	1602                	slli	a2,a2,0x20
    8000016c:	9201                	srli	a2,a2,0x20
    8000016e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000172:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000176:	0785                	addi	a5,a5,1
    80000178:	fee79de3          	bne	a5,a4,80000172 <memset+0x14>
  }
  return dst;
}
    8000017c:	60a2                	ld	ra,8(sp)
    8000017e:	6402                	ld	s0,0(sp)
    80000180:	0141                	addi	sp,sp,16
    80000182:	8082                	ret

0000000080000184 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000184:	1141                	addi	sp,sp,-16
    80000186:	e406                	sd	ra,8(sp)
    80000188:	e022                	sd	s0,0(sp)
    8000018a:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    8000018c:	ce19                	beqz	a2,800001aa <memcmp+0x26>
    8000018e:	1602                	slli	a2,a2,0x20
    80000190:	9201                	srli	a2,a2,0x20
    80000192:	00c506b3          	add	a3,a0,a2
    if(*s1 != *s2)
    80000196:	00054783          	lbu	a5,0(a0)
    8000019a:	0005c703          	lbu	a4,0(a1)
    8000019e:	00e79b63          	bne	a5,a4,800001b4 <memcmp+0x30>
      return *s1 - *s2;
    s1++, s2++;
    800001a2:	0505                	addi	a0,a0,1
    800001a4:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800001a6:	fed518e3          	bne	a0,a3,80000196 <memcmp+0x12>
  }

  return 0;
    800001aa:	4501                	li	a0,0
}
    800001ac:	60a2                	ld	ra,8(sp)
    800001ae:	6402                	ld	s0,0(sp)
    800001b0:	0141                	addi	sp,sp,16
    800001b2:	8082                	ret
      return *s1 - *s2;
    800001b4:	40e7853b          	subw	a0,a5,a4
    800001b8:	bfd5                	j	800001ac <memcmp+0x28>

00000000800001ba <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001ba:	1141                	addi	sp,sp,-16
    800001bc:	e406                	sd	ra,8(sp)
    800001be:	e022                	sd	s0,0(sp)
    800001c0:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001c2:	c61d                	beqz	a2,800001f0 <memmove+0x36>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001c4:	00a5f963          	bgeu	a1,a0,800001d6 <memmove+0x1c>
    800001c8:	02061693          	slli	a3,a2,0x20
    800001cc:	9281                	srli	a3,a3,0x20
    800001ce:	00d58733          	add	a4,a1,a3
    800001d2:	02e56363          	bltu	a0,a4,800001f8 <memmove+0x3e>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001d6:	1602                	slli	a2,a2,0x20
    800001d8:	9201                	srli	a2,a2,0x20
    800001da:	00c587b3          	add	a5,a1,a2
{
    800001de:	872a                	mv	a4,a0
      *d++ = *s++;
    800001e0:	0585                	addi	a1,a1,1
    800001e2:	0705                	addi	a4,a4,1
    800001e4:	fff5c683          	lbu	a3,-1(a1)
    800001e8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    800001ec:	fef59ae3          	bne	a1,a5,800001e0 <memmove+0x26>

  return dst;
}
    800001f0:	60a2                	ld	ra,8(sp)
    800001f2:	6402                	ld	s0,0(sp)
    800001f4:	0141                	addi	sp,sp,16
    800001f6:	8082                	ret
    d += n;
    800001f8:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    800001fa:	fff6079b          	addiw	a5,a2,-1 # fff <_entry-0x7ffff001>
    800001fe:	1782                	slli	a5,a5,0x20
    80000200:	9381                	srli	a5,a5,0x20
    80000202:	fff7c793          	not	a5,a5
    80000206:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000208:	177d                	addi	a4,a4,-1
    8000020a:	16fd                	addi	a3,a3,-1
    8000020c:	00074603          	lbu	a2,0(a4)
    80000210:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000214:	fee79ae3          	bne	a5,a4,80000208 <memmove+0x4e>
    80000218:	bfe1                	j	800001f0 <memmove+0x36>

000000008000021a <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    8000021a:	1141                	addi	sp,sp,-16
    8000021c:	e406                	sd	ra,8(sp)
    8000021e:	e022                	sd	s0,0(sp)
    80000220:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000222:	f99ff0ef          	jal	800001ba <memmove>
}
    80000226:	60a2                	ld	ra,8(sp)
    80000228:	6402                	ld	s0,0(sp)
    8000022a:	0141                	addi	sp,sp,16
    8000022c:	8082                	ret

000000008000022e <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    8000022e:	1141                	addi	sp,sp,-16
    80000230:	e406                	sd	ra,8(sp)
    80000232:	e022                	sd	s0,0(sp)
    80000234:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000236:	ce01                	beqz	a2,8000024e <strncmp+0x20>
    80000238:	00054783          	lbu	a5,0(a0)
    8000023c:	cb99                	beqz	a5,80000252 <strncmp+0x24>
    8000023e:	0005c703          	lbu	a4,0(a1)
    80000242:	00f71863          	bne	a4,a5,80000252 <strncmp+0x24>
    n--, p++, q++;
    80000246:	367d                	addiw	a2,a2,-1
    80000248:	0505                	addi	a0,a0,1
    8000024a:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    8000024c:	f675                	bnez	a2,80000238 <strncmp+0xa>
  if(n == 0)
    return 0;
    8000024e:	4501                	li	a0,0
    80000250:	a031                	j	8000025c <strncmp+0x2e>
  return (uchar)*p - (uchar)*q;
    80000252:	00054503          	lbu	a0,0(a0)
    80000256:	0005c783          	lbu	a5,0(a1)
    8000025a:	9d1d                	subw	a0,a0,a5
}
    8000025c:	60a2                	ld	ra,8(sp)
    8000025e:	6402                	ld	s0,0(sp)
    80000260:	0141                	addi	sp,sp,16
    80000262:	8082                	ret

0000000080000264 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000264:	1141                	addi	sp,sp,-16
    80000266:	e406                	sd	ra,8(sp)
    80000268:	e022                	sd	s0,0(sp)
    8000026a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    8000026c:	87aa                	mv	a5,a0
    8000026e:	a011                	j	80000272 <strncpy+0xe>
    80000270:	8636                	mv	a2,a3
    80000272:	02c05763          	blez	a2,800002a0 <strncpy+0x3c>
    80000276:	fff6069b          	addiw	a3,a2,-1
    8000027a:	0785                	addi	a5,a5,1
    8000027c:	0005c703          	lbu	a4,0(a1)
    80000280:	fee78fa3          	sb	a4,-1(a5)
    80000284:	0585                	addi	a1,a1,1
    80000286:	f76d                	bnez	a4,80000270 <strncpy+0xc>
    ;
  while(n-- > 0)
    80000288:	873e                	mv	a4,a5
    8000028a:	00d05b63          	blez	a3,800002a0 <strncpy+0x3c>
    8000028e:	9fb1                	addw	a5,a5,a2
    80000290:	37fd                	addiw	a5,a5,-1
    *s++ = 0;
    80000292:	0705                	addi	a4,a4,1
    80000294:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    80000298:	40e786bb          	subw	a3,a5,a4
    8000029c:	fed04be3          	bgtz	a3,80000292 <strncpy+0x2e>
  return os;
}
    800002a0:	60a2                	ld	ra,8(sp)
    800002a2:	6402                	ld	s0,0(sp)
    800002a4:	0141                	addi	sp,sp,16
    800002a6:	8082                	ret

00000000800002a8 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800002a8:	1141                	addi	sp,sp,-16
    800002aa:	e406                	sd	ra,8(sp)
    800002ac:	e022                	sd	s0,0(sp)
    800002ae:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800002b0:	02c05363          	blez	a2,800002d6 <safestrcpy+0x2e>
    800002b4:	fff6069b          	addiw	a3,a2,-1
    800002b8:	1682                	slli	a3,a3,0x20
    800002ba:	9281                	srli	a3,a3,0x20
    800002bc:	96ae                	add	a3,a3,a1
    800002be:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002c0:	00d58963          	beq	a1,a3,800002d2 <safestrcpy+0x2a>
    800002c4:	0585                	addi	a1,a1,1
    800002c6:	0785                	addi	a5,a5,1
    800002c8:	fff5c703          	lbu	a4,-1(a1)
    800002cc:	fee78fa3          	sb	a4,-1(a5)
    800002d0:	fb65                	bnez	a4,800002c0 <safestrcpy+0x18>
    ;
  *s = 0;
    800002d2:	00078023          	sb	zero,0(a5)
  return os;
}
    800002d6:	60a2                	ld	ra,8(sp)
    800002d8:	6402                	ld	s0,0(sp)
    800002da:	0141                	addi	sp,sp,16
    800002dc:	8082                	ret

00000000800002de <strlen>:

int
strlen(const char *s)
{
    800002de:	1141                	addi	sp,sp,-16
    800002e0:	e406                	sd	ra,8(sp)
    800002e2:	e022                	sd	s0,0(sp)
    800002e4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    800002e6:	00054783          	lbu	a5,0(a0)
    800002ea:	cf91                	beqz	a5,80000306 <strlen+0x28>
    800002ec:	00150793          	addi	a5,a0,1
    800002f0:	86be                	mv	a3,a5
    800002f2:	0785                	addi	a5,a5,1
    800002f4:	fff7c703          	lbu	a4,-1(a5)
    800002f8:	ff65                	bnez	a4,800002f0 <strlen+0x12>
    800002fa:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
    800002fe:	60a2                	ld	ra,8(sp)
    80000300:	6402                	ld	s0,0(sp)
    80000302:	0141                	addi	sp,sp,16
    80000304:	8082                	ret
  for(n = 0; s[n]; n++)
    80000306:	4501                	li	a0,0
    80000308:	bfdd                	j	800002fe <strlen+0x20>

000000008000030a <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    8000030a:	1141                	addi	sp,sp,-16
    8000030c:	e406                	sd	ra,8(sp)
    8000030e:	e022                	sd	s0,0(sp)
    80000310:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80000312:	219000ef          	jal	80000d2a <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000316:	00007717          	auipc	a4,0x7
    8000031a:	51a70713          	addi	a4,a4,1306 # 80007830 <started>
  if(cpuid() == 0){
    8000031e:	c515                	beqz	a0,8000034a <main+0x40>
    while(started == 0)
    80000320:	431c                	lw	a5,0(a4)
    80000322:	dffd                	beqz	a5,80000320 <main+0x16>
      ;
    __sync_synchronize();
    80000324:	0330000f          	fence	rw,rw
    printf("hart %d starting\n", cpuid());
    80000328:	203000ef          	jal	80000d2a <cpuid>
    8000032c:	85aa                	mv	a1,a0
    8000032e:	00007517          	auipc	a0,0x7
    80000332:	d0a50513          	addi	a0,a0,-758 # 80007038 <etext+0x38>
    80000336:	6e7040ef          	jal	8000521c <printf>
    kvminithart();    // turn on paging
    8000033a:	080000ef          	jal	800003ba <kvminithart>
    trapinithart();   // install kernel trap vector
    8000033e:	524010ef          	jal	80001862 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000342:	496040ef          	jal	800047d8 <plicinithart>
  }

  scheduler();        
    80000346:	675000ef          	jal	800011ba <scheduler>
    consoleinit();
    8000034a:	5fb040ef          	jal	80005144 <consoleinit>
    printfinit();
    8000034e:	242050ef          	jal	80005590 <printfinit>
    printf("\n");
    80000352:	00007517          	auipc	a0,0x7
    80000356:	cc650513          	addi	a0,a0,-826 # 80007018 <etext+0x18>
    8000035a:	6c3040ef          	jal	8000521c <printf>
    printf("xv6 kernel is booting\n");
    8000035e:	00007517          	auipc	a0,0x7
    80000362:	cc250513          	addi	a0,a0,-830 # 80007020 <etext+0x20>
    80000366:	6b7040ef          	jal	8000521c <printf>
    printf("\n");
    8000036a:	00007517          	auipc	a0,0x7
    8000036e:	cae50513          	addi	a0,a0,-850 # 80007018 <etext+0x18>
    80000372:	6ab040ef          	jal	8000521c <printf>
    kinit();         // physical page allocator
    80000376:	d5bff0ef          	jal	800000d0 <kinit>
    kvminit();       // create kernel page table
    8000037a:	2c0000ef          	jal	8000063a <kvminit>
    kvminithart();   // turn on paging
    8000037e:	03c000ef          	jal	800003ba <kvminithart>
    procinit();      // process table
    80000382:	0f1000ef          	jal	80000c72 <procinit>
    trapinit();      // trap vectors
    80000386:	4b8010ef          	jal	8000183e <trapinit>
    trapinithart();  // install kernel trap vector
    8000038a:	4d8010ef          	jal	80001862 <trapinithart>
    plicinit();      // set up interrupt controller
    8000038e:	430040ef          	jal	800047be <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000392:	446040ef          	jal	800047d8 <plicinithart>
    binit();         // buffer cache
    80000396:	34d010ef          	jal	80001ee2 <binit>
    iinit();         // inode table
    8000039a:	0a6020ef          	jal	80002440 <iinit>
    fileinit();      // file table
    8000039e:	7d9020ef          	jal	80003376 <fileinit>
    virtio_disk_init(); // emulated hard disk
    800003a2:	526040ef          	jal	800048c8 <virtio_disk_init>
    userinit();      // first user process
    800003a6:	481000ef          	jal	80001026 <userinit>
    __sync_synchronize();
    800003aa:	0330000f          	fence	rw,rw
    started = 1;
    800003ae:	4785                	li	a5,1
    800003b0:	00007717          	auipc	a4,0x7
    800003b4:	48f72023          	sw	a5,1152(a4) # 80007830 <started>
    800003b8:	b779                	j	80000346 <main+0x3c>

00000000800003ba <kvminithart>:

// Switch the current CPU's h/w page table register to
// the kernel's page table, and enable paging.
void
kvminithart()
{
    800003ba:	1141                	addi	sp,sp,-16
    800003bc:	e406                	sd	ra,8(sp)
    800003be:	e022                	sd	s0,0(sp)
    800003c0:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    800003c2:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    800003c6:	00007797          	auipc	a5,0x7
    800003ca:	4727b783          	ld	a5,1138(a5) # 80007838 <kernel_pagetable>
    800003ce:	83b1                	srli	a5,a5,0xc
    800003d0:	577d                	li	a4,-1
    800003d2:	177e                	slli	a4,a4,0x3f
    800003d4:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    800003d6:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    800003da:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    800003de:	60a2                	ld	ra,8(sp)
    800003e0:	6402                	ld	s0,0(sp)
    800003e2:	0141                	addi	sp,sp,16
    800003e4:	8082                	ret

00000000800003e6 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    800003e6:	7139                	addi	sp,sp,-64
    800003e8:	fc06                	sd	ra,56(sp)
    800003ea:	f822                	sd	s0,48(sp)
    800003ec:	f426                	sd	s1,40(sp)
    800003ee:	f04a                	sd	s2,32(sp)
    800003f0:	ec4e                	sd	s3,24(sp)
    800003f2:	e852                	sd	s4,16(sp)
    800003f4:	e456                	sd	s5,8(sp)
    800003f6:	e05a                	sd	s6,0(sp)
    800003f8:	0080                	addi	s0,sp,64
    800003fa:	84aa                	mv	s1,a0
    800003fc:	89ae                	mv	s3,a1
    800003fe:	8b32                	mv	s6,a2
  if(va >= MAXVA)
    80000400:	57fd                	li	a5,-1
    80000402:	83e9                	srli	a5,a5,0x1a
    80000404:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000406:	4ab1                	li	s5,12
  if(va >= MAXVA)
    80000408:	06b7e363          	bltu	a5,a1,8000046e <walk+0x88>
    pte_t *pte = &pagetable[PX(level, va)];
    8000040c:	0149d933          	srl	s2,s3,s4
    80000410:	1ff97913          	andi	s2,s2,511
    80000414:	090e                	slli	s2,s2,0x3
    80000416:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    80000418:	00093483          	ld	s1,0(s2)
    8000041c:	0014f793          	andi	a5,s1,1
      pagetable = (pagetable_t)PTE2PA(*pte);
    80000420:	80a9                	srli	s1,s1,0xa
    80000422:	04b2                	slli	s1,s1,0xc
    if(*pte & PTE_V) {
    80000424:	e395                	bnez	a5,80000448 <walk+0x62>
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80000426:	040b0a63          	beqz	s6,8000047a <walk+0x94>
    8000042a:	cdbff0ef          	jal	80000104 <kalloc>
    8000042e:	84aa                	mv	s1,a0
    80000430:	c50d                	beqz	a0,8000045a <walk+0x74>
        return 0;
      memset(pagetable, 0, PGSIZE);
    80000432:	6605                	lui	a2,0x1
    80000434:	4581                	li	a1,0
    80000436:	d29ff0ef          	jal	8000015e <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    8000043a:	00c4d793          	srli	a5,s1,0xc
    8000043e:	07aa                	slli	a5,a5,0xa
    80000440:	0017e793          	ori	a5,a5,1
    80000444:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    80000448:	3a5d                	addiw	s4,s4,-9
    8000044a:	fd5a11e3          	bne	s4,s5,8000040c <walk+0x26>
    }
  }
  return &pagetable[PX(0, va)];
    8000044e:	00c9d513          	srli	a0,s3,0xc
    80000452:	1ff57513          	andi	a0,a0,511
    80000456:	050e                	slli	a0,a0,0x3
    80000458:	9526                	add	a0,a0,s1
}
    8000045a:	70e2                	ld	ra,56(sp)
    8000045c:	7442                	ld	s0,48(sp)
    8000045e:	74a2                	ld	s1,40(sp)
    80000460:	7902                	ld	s2,32(sp)
    80000462:	69e2                	ld	s3,24(sp)
    80000464:	6a42                	ld	s4,16(sp)
    80000466:	6aa2                	ld	s5,8(sp)
    80000468:	6b02                	ld	s6,0(sp)
    8000046a:	6121                	addi	sp,sp,64
    8000046c:	8082                	ret
    panic("walk");
    8000046e:	00007517          	auipc	a0,0x7
    80000472:	be250513          	addi	a0,a0,-1054 # 80007050 <etext+0x50>
    80000476:	0de050ef          	jal	80005554 <panic>
        return 0;
    8000047a:	4501                	li	a0,0
    8000047c:	bff9                	j	8000045a <walk+0x74>

000000008000047e <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    8000047e:	57fd                	li	a5,-1
    80000480:	83e9                	srli	a5,a5,0x1a
    80000482:	00b7f463          	bgeu	a5,a1,8000048a <walkaddr+0xc>
    return 0;
    80000486:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000488:	8082                	ret
{
    8000048a:	1141                	addi	sp,sp,-16
    8000048c:	e406                	sd	ra,8(sp)
    8000048e:	e022                	sd	s0,0(sp)
    80000490:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80000492:	4601                	li	a2,0
    80000494:	f53ff0ef          	jal	800003e6 <walk>
  if(pte == 0)
    80000498:	c519                	beqz	a0,800004a6 <walkaddr+0x28>
  if((*pte & PTE_V) == 0)
    8000049a:	6108                	ld	a0,0(a0)
  if((*pte & PTE_U) == 0)
    8000049c:	01157713          	andi	a4,a0,17
    800004a0:	47c5                	li	a5,17
    800004a2:	00f70763          	beq	a4,a5,800004b0 <walkaddr+0x32>
    return 0;
    800004a6:	4501                	li	a0,0
}
    800004a8:	60a2                	ld	ra,8(sp)
    800004aa:	6402                	ld	s0,0(sp)
    800004ac:	0141                	addi	sp,sp,16
    800004ae:	8082                	ret
  pa = PTE2PA(*pte);
    800004b0:	8129                	srli	a0,a0,0xa
    800004b2:	0532                	slli	a0,a0,0xc
  return pa;
    800004b4:	bfd5                	j	800004a8 <walkaddr+0x2a>

00000000800004b6 <mappages>:
// va and size MUST be page-aligned.
// Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    800004b6:	715d                	addi	sp,sp,-80
    800004b8:	e486                	sd	ra,72(sp)
    800004ba:	e0a2                	sd	s0,64(sp)
    800004bc:	fc26                	sd	s1,56(sp)
    800004be:	f84a                	sd	s2,48(sp)
    800004c0:	f44e                	sd	s3,40(sp)
    800004c2:	f052                	sd	s4,32(sp)
    800004c4:	ec56                	sd	s5,24(sp)
    800004c6:	e85a                	sd	s6,16(sp)
    800004c8:	e45e                	sd	s7,8(sp)
    800004ca:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    800004cc:	03459793          	slli	a5,a1,0x34
    800004d0:	e7b1                	bnez	a5,8000051c <mappages+0x66>
    800004d2:	8a2a                	mv	s4,a0
    800004d4:	8aba                	mv	s5,a4
    panic("mappages: va not aligned");

  if((size % PGSIZE) != 0)
    800004d6:	03461793          	slli	a5,a2,0x34
    800004da:	e7b9                	bnez	a5,80000528 <mappages+0x72>
    panic("mappages: size not aligned");

  if(size == 0)
    800004dc:	ce21                	beqz	a2,80000534 <mappages+0x7e>
    panic("mappages: size");
  
  a = va;
  last = va + size - PGSIZE;
    800004de:	77fd                	lui	a5,0xfffff
    800004e0:	963e                	add	a2,a2,a5
    800004e2:	00b60933          	add	s2,a2,a1
  a = va;
    800004e6:	84ae                	mv	s1,a1
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    800004e8:	4b05                	li	s6,1
    800004ea:	40b689b3          	sub	s3,a3,a1
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    800004ee:	6b85                	lui	s7,0x1
    if((pte = walk(pagetable, a, 1)) == 0)
    800004f0:	865a                	mv	a2,s6
    800004f2:	85a6                	mv	a1,s1
    800004f4:	8552                	mv	a0,s4
    800004f6:	ef1ff0ef          	jal	800003e6 <walk>
    800004fa:	c929                	beqz	a0,8000054c <mappages+0x96>
    if(*pte & PTE_V)
    800004fc:	611c                	ld	a5,0(a0)
    800004fe:	8b85                	andi	a5,a5,1
    80000500:	e3a1                	bnez	a5,80000540 <mappages+0x8a>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80000502:	013487b3          	add	a5,s1,s3
    80000506:	83b1                	srli	a5,a5,0xc
    80000508:	07aa                	slli	a5,a5,0xa
    8000050a:	0157e7b3          	or	a5,a5,s5
    8000050e:	0017e793          	ori	a5,a5,1
    80000512:	e11c                	sd	a5,0(a0)
    if(a == last)
    80000514:	05248863          	beq	s1,s2,80000564 <mappages+0xae>
    a += PGSIZE;
    80000518:	94de                	add	s1,s1,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    8000051a:	bfd9                	j	800004f0 <mappages+0x3a>
    panic("mappages: va not aligned");
    8000051c:	00007517          	auipc	a0,0x7
    80000520:	b3c50513          	addi	a0,a0,-1220 # 80007058 <etext+0x58>
    80000524:	030050ef          	jal	80005554 <panic>
    panic("mappages: size not aligned");
    80000528:	00007517          	auipc	a0,0x7
    8000052c:	b5050513          	addi	a0,a0,-1200 # 80007078 <etext+0x78>
    80000530:	024050ef          	jal	80005554 <panic>
    panic("mappages: size");
    80000534:	00007517          	auipc	a0,0x7
    80000538:	b6450513          	addi	a0,a0,-1180 # 80007098 <etext+0x98>
    8000053c:	018050ef          	jal	80005554 <panic>
      panic("mappages: remap");
    80000540:	00007517          	auipc	a0,0x7
    80000544:	b6850513          	addi	a0,a0,-1176 # 800070a8 <etext+0xa8>
    80000548:	00c050ef          	jal	80005554 <panic>
      return -1;
    8000054c:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    8000054e:	60a6                	ld	ra,72(sp)
    80000550:	6406                	ld	s0,64(sp)
    80000552:	74e2                	ld	s1,56(sp)
    80000554:	7942                	ld	s2,48(sp)
    80000556:	79a2                	ld	s3,40(sp)
    80000558:	7a02                	ld	s4,32(sp)
    8000055a:	6ae2                	ld	s5,24(sp)
    8000055c:	6b42                	ld	s6,16(sp)
    8000055e:	6ba2                	ld	s7,8(sp)
    80000560:	6161                	addi	sp,sp,80
    80000562:	8082                	ret
  return 0;
    80000564:	4501                	li	a0,0
    80000566:	b7e5                	j	8000054e <mappages+0x98>

0000000080000568 <kvmmap>:
{
    80000568:	1141                	addi	sp,sp,-16
    8000056a:	e406                	sd	ra,8(sp)
    8000056c:	e022                	sd	s0,0(sp)
    8000056e:	0800                	addi	s0,sp,16
    80000570:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80000572:	86b2                	mv	a3,a2
    80000574:	863e                	mv	a2,a5
    80000576:	f41ff0ef          	jal	800004b6 <mappages>
    8000057a:	e509                	bnez	a0,80000584 <kvmmap+0x1c>
}
    8000057c:	60a2                	ld	ra,8(sp)
    8000057e:	6402                	ld	s0,0(sp)
    80000580:	0141                	addi	sp,sp,16
    80000582:	8082                	ret
    panic("kvmmap");
    80000584:	00007517          	auipc	a0,0x7
    80000588:	b3450513          	addi	a0,a0,-1228 # 800070b8 <etext+0xb8>
    8000058c:	7c9040ef          	jal	80005554 <panic>

0000000080000590 <kvmmake>:
{
    80000590:	1101                	addi	sp,sp,-32
    80000592:	ec06                	sd	ra,24(sp)
    80000594:	e822                	sd	s0,16(sp)
    80000596:	e426                	sd	s1,8(sp)
    80000598:	e04a                	sd	s2,0(sp)
    8000059a:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    8000059c:	b69ff0ef          	jal	80000104 <kalloc>
    800005a0:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    800005a2:	6605                	lui	a2,0x1
    800005a4:	4581                	li	a1,0
    800005a6:	bb9ff0ef          	jal	8000015e <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    800005aa:	4719                	li	a4,6
    800005ac:	6685                	lui	a3,0x1
    800005ae:	10000637          	lui	a2,0x10000
    800005b2:	85b2                	mv	a1,a2
    800005b4:	8526                	mv	a0,s1
    800005b6:	fb3ff0ef          	jal	80000568 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    800005ba:	4719                	li	a4,6
    800005bc:	6685                	lui	a3,0x1
    800005be:	10001637          	lui	a2,0x10001
    800005c2:	85b2                	mv	a1,a2
    800005c4:	8526                	mv	a0,s1
    800005c6:	fa3ff0ef          	jal	80000568 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x4000000, PTE_R | PTE_W);
    800005ca:	4719                	li	a4,6
    800005cc:	040006b7          	lui	a3,0x4000
    800005d0:	0c000637          	lui	a2,0xc000
    800005d4:	85b2                	mv	a1,a2
    800005d6:	8526                	mv	a0,s1
    800005d8:	f91ff0ef          	jal	80000568 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800005dc:	00007917          	auipc	s2,0x7
    800005e0:	a2490913          	addi	s2,s2,-1500 # 80007000 <etext>
    800005e4:	4729                	li	a4,10
    800005e6:	800006b7          	lui	a3,0x80000
    800005ea:	96ca                	add	a3,a3,s2
    800005ec:	4605                	li	a2,1
    800005ee:	067e                	slli	a2,a2,0x1f
    800005f0:	85b2                	mv	a1,a2
    800005f2:	8526                	mv	a0,s1
    800005f4:	f75ff0ef          	jal	80000568 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800005f8:	4719                	li	a4,6
    800005fa:	46c5                	li	a3,17
    800005fc:	06ee                	slli	a3,a3,0x1b
    800005fe:	412686b3          	sub	a3,a3,s2
    80000602:	864a                	mv	a2,s2
    80000604:	85ca                	mv	a1,s2
    80000606:	8526                	mv	a0,s1
    80000608:	f61ff0ef          	jal	80000568 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    8000060c:	4729                	li	a4,10
    8000060e:	6685                	lui	a3,0x1
    80000610:	00006617          	auipc	a2,0x6
    80000614:	9f060613          	addi	a2,a2,-1552 # 80006000 <_trampoline>
    80000618:	040005b7          	lui	a1,0x4000
    8000061c:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    8000061e:	05b2                	slli	a1,a1,0xc
    80000620:	8526                	mv	a0,s1
    80000622:	f47ff0ef          	jal	80000568 <kvmmap>
  proc_mapstacks(kpgtbl);
    80000626:	8526                	mv	a0,s1
    80000628:	5b6000ef          	jal	80000bde <proc_mapstacks>
}
    8000062c:	8526                	mv	a0,s1
    8000062e:	60e2                	ld	ra,24(sp)
    80000630:	6442                	ld	s0,16(sp)
    80000632:	64a2                	ld	s1,8(sp)
    80000634:	6902                	ld	s2,0(sp)
    80000636:	6105                	addi	sp,sp,32
    80000638:	8082                	ret

000000008000063a <kvminit>:
{
    8000063a:	1141                	addi	sp,sp,-16
    8000063c:	e406                	sd	ra,8(sp)
    8000063e:	e022                	sd	s0,0(sp)
    80000640:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80000642:	f4fff0ef          	jal	80000590 <kvmmake>
    80000646:	00007797          	auipc	a5,0x7
    8000064a:	1ea7b923          	sd	a0,498(a5) # 80007838 <kernel_pagetable>
}
    8000064e:	60a2                	ld	ra,8(sp)
    80000650:	6402                	ld	s0,0(sp)
    80000652:	0141                	addi	sp,sp,16
    80000654:	8082                	ret

0000000080000656 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80000656:	1101                	addi	sp,sp,-32
    80000658:	ec06                	sd	ra,24(sp)
    8000065a:	e822                	sd	s0,16(sp)
    8000065c:	e426                	sd	s1,8(sp)
    8000065e:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80000660:	aa5ff0ef          	jal	80000104 <kalloc>
    80000664:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000666:	c509                	beqz	a0,80000670 <uvmcreate+0x1a>
    return 0;
  memset(pagetable, 0, PGSIZE);
    80000668:	6605                	lui	a2,0x1
    8000066a:	4581                	li	a1,0
    8000066c:	af3ff0ef          	jal	8000015e <memset>
  return pagetable;
}
    80000670:	8526                	mv	a0,s1
    80000672:	60e2                	ld	ra,24(sp)
    80000674:	6442                	ld	s0,16(sp)
    80000676:	64a2                	ld	s1,8(sp)
    80000678:	6105                	addi	sp,sp,32
    8000067a:	8082                	ret

000000008000067c <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. It's OK if the mappings don't exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    8000067c:	7139                	addi	sp,sp,-64
    8000067e:	fc06                	sd	ra,56(sp)
    80000680:	f822                	sd	s0,48(sp)
    80000682:	0080                	addi	s0,sp,64
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000684:	03459793          	slli	a5,a1,0x34
    80000688:	e38d                	bnez	a5,800006aa <uvmunmap+0x2e>
    8000068a:	f04a                	sd	s2,32(sp)
    8000068c:	ec4e                	sd	s3,24(sp)
    8000068e:	e852                	sd	s4,16(sp)
    80000690:	e456                	sd	s5,8(sp)
    80000692:	e05a                	sd	s6,0(sp)
    80000694:	8a2a                	mv	s4,a0
    80000696:	892e                	mv	s2,a1
    80000698:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000069a:	0632                	slli	a2,a2,0xc
    8000069c:	00b609b3          	add	s3,a2,a1
    800006a0:	6b05                	lui	s6,0x1
    800006a2:	0535f963          	bgeu	a1,s3,800006f4 <uvmunmap+0x78>
    800006a6:	f426                	sd	s1,40(sp)
    800006a8:	a015                	j	800006cc <uvmunmap+0x50>
    800006aa:	f426                	sd	s1,40(sp)
    800006ac:	f04a                	sd	s2,32(sp)
    800006ae:	ec4e                	sd	s3,24(sp)
    800006b0:	e852                	sd	s4,16(sp)
    800006b2:	e456                	sd	s5,8(sp)
    800006b4:	e05a                	sd	s6,0(sp)
    panic("uvmunmap: not aligned");
    800006b6:	00007517          	auipc	a0,0x7
    800006ba:	a0a50513          	addi	a0,a0,-1526 # 800070c0 <etext+0xc0>
    800006be:	697040ef          	jal	80005554 <panic>
      continue;
    if(do_free){
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
    800006c2:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800006c6:	995a                	add	s2,s2,s6
    800006c8:	03397563          	bgeu	s2,s3,800006f2 <uvmunmap+0x76>
    if((pte = walk(pagetable, a, 0)) == 0) // leaf page table entry allocated?
    800006cc:	4601                	li	a2,0
    800006ce:	85ca                	mv	a1,s2
    800006d0:	8552                	mv	a0,s4
    800006d2:	d15ff0ef          	jal	800003e6 <walk>
    800006d6:	84aa                	mv	s1,a0
    800006d8:	d57d                	beqz	a0,800006c6 <uvmunmap+0x4a>
    if((*pte & PTE_V) == 0)  // has physical page been allocated?
    800006da:	611c                	ld	a5,0(a0)
    800006dc:	0017f713          	andi	a4,a5,1
    800006e0:	d37d                	beqz	a4,800006c6 <uvmunmap+0x4a>
    if(do_free){
    800006e2:	fe0a80e3          	beqz	s5,800006c2 <uvmunmap+0x46>
      uint64 pa = PTE2PA(*pte);
    800006e6:	83a9                	srli	a5,a5,0xa
      kfree((void*)pa);
    800006e8:	00c79513          	slli	a0,a5,0xc
    800006ec:	931ff0ef          	jal	8000001c <kfree>
    800006f0:	bfc9                	j	800006c2 <uvmunmap+0x46>
    800006f2:	74a2                	ld	s1,40(sp)
    800006f4:	7902                	ld	s2,32(sp)
    800006f6:	69e2                	ld	s3,24(sp)
    800006f8:	6a42                	ld	s4,16(sp)
    800006fa:	6aa2                	ld	s5,8(sp)
    800006fc:	6b02                	ld	s6,0(sp)
  }
}
    800006fe:	70e2                	ld	ra,56(sp)
    80000700:	7442                	ld	s0,48(sp)
    80000702:	6121                	addi	sp,sp,64
    80000704:	8082                	ret

0000000080000706 <uvmdealloc>:
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
  if(newsz >= oldsz)
    80000706:	04b67163          	bgeu	a2,a1,80000748 <uvmdealloc+0x42>
{
    8000070a:	1101                	addi	sp,sp,-32
    8000070c:	ec06                	sd	ra,24(sp)
    8000070e:	e822                	sd	s0,16(sp)
    80000710:	e426                	sd	s1,8(sp)
    80000712:	1000                	addi	s0,sp,32
    80000714:	84b2                	mv	s1,a2
    return oldsz;

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80000716:	6785                	lui	a5,0x1
    80000718:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000071a:	00f60733          	add	a4,a2,a5
    8000071e:	76fd                	lui	a3,0xfffff
    80000720:	8f75                	and	a4,a4,a3
    80000722:	97ae                	add	a5,a5,a1
    80000724:	8ff5                	and	a5,a5,a3
    80000726:	00f76863          	bltu	a4,a5,80000736 <uvmdealloc+0x30>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
    8000072a:	8526                	mv	a0,s1
}
    8000072c:	60e2                	ld	ra,24(sp)
    8000072e:	6442                	ld	s0,16(sp)
    80000730:	64a2                	ld	s1,8(sp)
    80000732:	6105                	addi	sp,sp,32
    80000734:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80000736:	8f99                	sub	a5,a5,a4
    80000738:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    8000073a:	4685                	li	a3,1
    8000073c:	0007861b          	sext.w	a2,a5
    80000740:	85ba                	mv	a1,a4
    80000742:	f3bff0ef          	jal	8000067c <uvmunmap>
    80000746:	b7d5                	j	8000072a <uvmdealloc+0x24>
    return oldsz;
    80000748:	852e                	mv	a0,a1
}
    8000074a:	8082                	ret

000000008000074c <uvmalloc>:
  if(newsz < oldsz)
    8000074c:	08b66e63          	bltu	a2,a1,800007e8 <uvmalloc+0x9c>
{
    80000750:	715d                	addi	sp,sp,-80
    80000752:	e486                	sd	ra,72(sp)
    80000754:	e0a2                	sd	s0,64(sp)
    80000756:	f052                	sd	s4,32(sp)
    80000758:	ec56                	sd	s5,24(sp)
    8000075a:	e45e                	sd	s7,8(sp)
    8000075c:	0880                	addi	s0,sp,80
    8000075e:	8aaa                	mv	s5,a0
    80000760:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    80000762:	6785                	lui	a5,0x1
    80000764:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000766:	95be                	add	a1,a1,a5
    80000768:	77fd                	lui	a5,0xfffff
    8000076a:	8fed                	and	a5,a5,a1
    8000076c:	8bbe                	mv	s7,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000076e:	04c7f163          	bgeu	a5,a2,800007b0 <uvmalloc+0x64>
    80000772:	fc26                	sd	s1,56(sp)
    80000774:	f84a                	sd	s2,48(sp)
    80000776:	f44e                	sd	s3,40(sp)
    80000778:	e85a                	sd	s6,16(sp)
    8000077a:	893e                	mv	s2,a5
    memset(mem, 0, PGSIZE);
    8000077c:	6985                	lui	s3,0x1
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    8000077e:	0126eb13          	ori	s6,a3,18
    mem = kalloc();
    80000782:	983ff0ef          	jal	80000104 <kalloc>
    80000786:	84aa                	mv	s1,a0
    if(mem == 0){
    80000788:	c515                	beqz	a0,800007b4 <uvmalloc+0x68>
    memset(mem, 0, PGSIZE);
    8000078a:	864e                	mv	a2,s3
    8000078c:	4581                	li	a1,0
    8000078e:	9d1ff0ef          	jal	8000015e <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000792:	875a                	mv	a4,s6
    80000794:	86a6                	mv	a3,s1
    80000796:	864e                	mv	a2,s3
    80000798:	85ca                	mv	a1,s2
    8000079a:	8556                	mv	a0,s5
    8000079c:	d1bff0ef          	jal	800004b6 <mappages>
    800007a0:	e91d                	bnez	a0,800007d6 <uvmalloc+0x8a>
  for(a = oldsz; a < newsz; a += PGSIZE){
    800007a2:	994e                	add	s2,s2,s3
    800007a4:	fd496fe3          	bltu	s2,s4,80000782 <uvmalloc+0x36>
    800007a8:	74e2                	ld	s1,56(sp)
    800007aa:	7942                	ld	s2,48(sp)
    800007ac:	79a2                	ld	s3,40(sp)
    800007ae:	6b42                	ld	s6,16(sp)
  return newsz;
    800007b0:	8552                	mv	a0,s4
    800007b2:	a819                	j	800007c8 <uvmalloc+0x7c>
      uvmdealloc(pagetable, a, oldsz);
    800007b4:	865e                	mv	a2,s7
    800007b6:	85ca                	mv	a1,s2
    800007b8:	8556                	mv	a0,s5
    800007ba:	f4dff0ef          	jal	80000706 <uvmdealloc>
      return 0;
    800007be:	4501                	li	a0,0
    800007c0:	74e2                	ld	s1,56(sp)
    800007c2:	7942                	ld	s2,48(sp)
    800007c4:	79a2                	ld	s3,40(sp)
    800007c6:	6b42                	ld	s6,16(sp)
}
    800007c8:	60a6                	ld	ra,72(sp)
    800007ca:	6406                	ld	s0,64(sp)
    800007cc:	7a02                	ld	s4,32(sp)
    800007ce:	6ae2                	ld	s5,24(sp)
    800007d0:	6ba2                	ld	s7,8(sp)
    800007d2:	6161                	addi	sp,sp,80
    800007d4:	8082                	ret
      kfree(mem);
    800007d6:	8526                	mv	a0,s1
    800007d8:	845ff0ef          	jal	8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    800007dc:	865e                	mv	a2,s7
    800007de:	85ca                	mv	a1,s2
    800007e0:	8556                	mv	a0,s5
    800007e2:	f25ff0ef          	jal	80000706 <uvmdealloc>
      return 0;
    800007e6:	bfe1                	j	800007be <uvmalloc+0x72>
    return oldsz;
    800007e8:	852e                	mv	a0,a1
}
    800007ea:	8082                	ret

00000000800007ec <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    800007ec:	7179                	addi	sp,sp,-48
    800007ee:	f406                	sd	ra,40(sp)
    800007f0:	f022                	sd	s0,32(sp)
    800007f2:	ec26                	sd	s1,24(sp)
    800007f4:	e84a                	sd	s2,16(sp)
    800007f6:	e44e                	sd	s3,8(sp)
    800007f8:	1800                	addi	s0,sp,48
    800007fa:	89aa                	mv	s3,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800007fc:	84aa                	mv	s1,a0
    800007fe:	6905                	lui	s2,0x1
    80000800:	992a                	add	s2,s2,a0
    80000802:	a811                	j	80000816 <freewalk+0x2a>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
      freewalk((pagetable_t)child);
      pagetable[i] = 0;
    } else if(pte & PTE_V){
      panic("freewalk: leaf");
    80000804:	00007517          	auipc	a0,0x7
    80000808:	8d450513          	addi	a0,a0,-1836 # 800070d8 <etext+0xd8>
    8000080c:	549040ef          	jal	80005554 <panic>
  for(int i = 0; i < 512; i++){
    80000810:	04a1                	addi	s1,s1,8
    80000812:	03248163          	beq	s1,s2,80000834 <freewalk+0x48>
    pte_t pte = pagetable[i];
    80000816:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000818:	0017f713          	andi	a4,a5,1
    8000081c:	db75                	beqz	a4,80000810 <freewalk+0x24>
    8000081e:	00e7f713          	andi	a4,a5,14
    80000822:	f36d                	bnez	a4,80000804 <freewalk+0x18>
      uint64 child = PTE2PA(pte);
    80000824:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    80000826:	00c79513          	slli	a0,a5,0xc
    8000082a:	fc3ff0ef          	jal	800007ec <freewalk>
      pagetable[i] = 0;
    8000082e:	0004b023          	sd	zero,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000832:	bff9                	j	80000810 <freewalk+0x24>
    }
  }
  kfree((void*)pagetable);
    80000834:	854e                	mv	a0,s3
    80000836:	fe6ff0ef          	jal	8000001c <kfree>
}
    8000083a:	70a2                	ld	ra,40(sp)
    8000083c:	7402                	ld	s0,32(sp)
    8000083e:	64e2                	ld	s1,24(sp)
    80000840:	6942                	ld	s2,16(sp)
    80000842:	69a2                	ld	s3,8(sp)
    80000844:	6145                	addi	sp,sp,48
    80000846:	8082                	ret

0000000080000848 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80000848:	1101                	addi	sp,sp,-32
    8000084a:	ec06                	sd	ra,24(sp)
    8000084c:	e822                	sd	s0,16(sp)
    8000084e:	e426                	sd	s1,8(sp)
    80000850:	1000                	addi	s0,sp,32
    80000852:	84aa                	mv	s1,a0
  if(sz > 0)
    80000854:	e989                	bnez	a1,80000866 <uvmfree+0x1e>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000856:	8526                	mv	a0,s1
    80000858:	f95ff0ef          	jal	800007ec <freewalk>
}
    8000085c:	60e2                	ld	ra,24(sp)
    8000085e:	6442                	ld	s0,16(sp)
    80000860:	64a2                	ld	s1,8(sp)
    80000862:	6105                	addi	sp,sp,32
    80000864:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000866:	6785                	lui	a5,0x1
    80000868:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000086a:	95be                	add	a1,a1,a5
    8000086c:	4685                	li	a3,1
    8000086e:	00c5d613          	srli	a2,a1,0xc
    80000872:	4581                	li	a1,0
    80000874:	e09ff0ef          	jal	8000067c <uvmunmap>
    80000878:	bff9                	j	80000856 <uvmfree+0xe>

000000008000087a <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    8000087a:	ca59                	beqz	a2,80000910 <uvmcopy+0x96>
{
    8000087c:	715d                	addi	sp,sp,-80
    8000087e:	e486                	sd	ra,72(sp)
    80000880:	e0a2                	sd	s0,64(sp)
    80000882:	fc26                	sd	s1,56(sp)
    80000884:	f84a                	sd	s2,48(sp)
    80000886:	f44e                	sd	s3,40(sp)
    80000888:	f052                	sd	s4,32(sp)
    8000088a:	ec56                	sd	s5,24(sp)
    8000088c:	e85a                	sd	s6,16(sp)
    8000088e:	e45e                	sd	s7,8(sp)
    80000890:	0880                	addi	s0,sp,80
    80000892:	8b2a                	mv	s6,a0
    80000894:	8bae                	mv	s7,a1
    80000896:	8ab2                	mv	s5,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000898:	4481                	li	s1,0
      continue;   // physical page hasn't been allocated
    pa = PTE2PA(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    8000089a:	6a05                	lui	s4,0x1
    8000089c:	a021                	j	800008a4 <uvmcopy+0x2a>
  for(i = 0; i < sz; i += PGSIZE){
    8000089e:	94d2                	add	s1,s1,s4
    800008a0:	0554fc63          	bgeu	s1,s5,800008f8 <uvmcopy+0x7e>
    if((pte = walk(old, i, 0)) == 0)
    800008a4:	4601                	li	a2,0
    800008a6:	85a6                	mv	a1,s1
    800008a8:	855a                	mv	a0,s6
    800008aa:	b3dff0ef          	jal	800003e6 <walk>
    800008ae:	d965                	beqz	a0,8000089e <uvmcopy+0x24>
    if((*pte & PTE_V) == 0)
    800008b0:	00053983          	ld	s3,0(a0)
    800008b4:	0019f793          	andi	a5,s3,1
    800008b8:	d3fd                	beqz	a5,8000089e <uvmcopy+0x24>
    if((mem = kalloc()) == 0)
    800008ba:	84bff0ef          	jal	80000104 <kalloc>
    800008be:	892a                	mv	s2,a0
    800008c0:	c11d                	beqz	a0,800008e6 <uvmcopy+0x6c>
    pa = PTE2PA(*pte);
    800008c2:	00a9d593          	srli	a1,s3,0xa
    memmove(mem, (char*)pa, PGSIZE);
    800008c6:	8652                	mv	a2,s4
    800008c8:	05b2                	slli	a1,a1,0xc
    800008ca:	8f1ff0ef          	jal	800001ba <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    800008ce:	3ff9f713          	andi	a4,s3,1023
    800008d2:	86ca                	mv	a3,s2
    800008d4:	8652                	mv	a2,s4
    800008d6:	85a6                	mv	a1,s1
    800008d8:	855e                	mv	a0,s7
    800008da:	bddff0ef          	jal	800004b6 <mappages>
    800008de:	d161                	beqz	a0,8000089e <uvmcopy+0x24>
      kfree(mem);
    800008e0:	854a                	mv	a0,s2
    800008e2:	f3aff0ef          	jal	8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    800008e6:	4685                	li	a3,1
    800008e8:	00c4d613          	srli	a2,s1,0xc
    800008ec:	4581                	li	a1,0
    800008ee:	855e                	mv	a0,s7
    800008f0:	d8dff0ef          	jal	8000067c <uvmunmap>
  return -1;
    800008f4:	557d                	li	a0,-1
    800008f6:	a011                	j	800008fa <uvmcopy+0x80>
  return 0;
    800008f8:	4501                	li	a0,0
}
    800008fa:	60a6                	ld	ra,72(sp)
    800008fc:	6406                	ld	s0,64(sp)
    800008fe:	74e2                	ld	s1,56(sp)
    80000900:	7942                	ld	s2,48(sp)
    80000902:	79a2                	ld	s3,40(sp)
    80000904:	7a02                	ld	s4,32(sp)
    80000906:	6ae2                	ld	s5,24(sp)
    80000908:	6b42                	ld	s6,16(sp)
    8000090a:	6ba2                	ld	s7,8(sp)
    8000090c:	6161                	addi	sp,sp,80
    8000090e:	8082                	ret
  return 0;
    80000910:	4501                	li	a0,0
}
    80000912:	8082                	ret

0000000080000914 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000914:	1141                	addi	sp,sp,-16
    80000916:	e406                	sd	ra,8(sp)
    80000918:	e022                	sd	s0,0(sp)
    8000091a:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    8000091c:	4601                	li	a2,0
    8000091e:	ac9ff0ef          	jal	800003e6 <walk>
  if(pte == 0)
    80000922:	c901                	beqz	a0,80000932 <uvmclear+0x1e>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000924:	611c                	ld	a5,0(a0)
    80000926:	9bbd                	andi	a5,a5,-17
    80000928:	e11c                	sd	a5,0(a0)
}
    8000092a:	60a2                	ld	ra,8(sp)
    8000092c:	6402                	ld	s0,0(sp)
    8000092e:	0141                	addi	sp,sp,16
    80000930:	8082                	ret
    panic("uvmclear");
    80000932:	00006517          	auipc	a0,0x6
    80000936:	7b650513          	addi	a0,a0,1974 # 800070e8 <etext+0xe8>
    8000093a:	41b040ef          	jal	80005554 <panic>

000000008000093e <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    8000093e:	cac5                	beqz	a3,800009ee <copyinstr+0xb0>
{
    80000940:	715d                	addi	sp,sp,-80
    80000942:	e486                	sd	ra,72(sp)
    80000944:	e0a2                	sd	s0,64(sp)
    80000946:	fc26                	sd	s1,56(sp)
    80000948:	f84a                	sd	s2,48(sp)
    8000094a:	f44e                	sd	s3,40(sp)
    8000094c:	f052                	sd	s4,32(sp)
    8000094e:	ec56                	sd	s5,24(sp)
    80000950:	e85a                	sd	s6,16(sp)
    80000952:	e45e                	sd	s7,8(sp)
    80000954:	0880                	addi	s0,sp,80
    80000956:	8aaa                	mv	s5,a0
    80000958:	84ae                	mv	s1,a1
    8000095a:	8bb2                	mv	s7,a2
    8000095c:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    8000095e:	7b7d                	lui	s6,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000960:	6a05                	lui	s4,0x1
    80000962:	a82d                	j	8000099c <copyinstr+0x5e>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000964:	00078023          	sb	zero,0(a5)
        got_null = 1;
    80000968:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    8000096a:	0017c793          	xori	a5,a5,1
    8000096e:	40f0053b          	negw	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000972:	60a6                	ld	ra,72(sp)
    80000974:	6406                	ld	s0,64(sp)
    80000976:	74e2                	ld	s1,56(sp)
    80000978:	7942                	ld	s2,48(sp)
    8000097a:	79a2                	ld	s3,40(sp)
    8000097c:	7a02                	ld	s4,32(sp)
    8000097e:	6ae2                	ld	s5,24(sp)
    80000980:	6b42                	ld	s6,16(sp)
    80000982:	6ba2                	ld	s7,8(sp)
    80000984:	6161                	addi	sp,sp,80
    80000986:	8082                	ret
    80000988:	fff98713          	addi	a4,s3,-1 # fff <_entry-0x7ffff001>
    8000098c:	9726                	add	a4,a4,s1
      --max;
    8000098e:	40b709b3          	sub	s3,a4,a1
    srcva = va0 + PGSIZE;
    80000992:	01490bb3          	add	s7,s2,s4
  while(got_null == 0 && max > 0){
    80000996:	04e58463          	beq	a1,a4,800009de <copyinstr+0xa0>
{
    8000099a:	84be                	mv	s1,a5
    va0 = PGROUNDDOWN(srcva);
    8000099c:	016bf933          	and	s2,s7,s6
    pa0 = walkaddr(pagetable, va0);
    800009a0:	85ca                	mv	a1,s2
    800009a2:	8556                	mv	a0,s5
    800009a4:	adbff0ef          	jal	8000047e <walkaddr>
    if(pa0 == 0)
    800009a8:	cd0d                	beqz	a0,800009e2 <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    800009aa:	41790633          	sub	a2,s2,s7
    800009ae:	9652                	add	a2,a2,s4
    if(n > max)
    800009b0:	00c9f363          	bgeu	s3,a2,800009b6 <copyinstr+0x78>
    800009b4:	864e                	mv	a2,s3
    while(n > 0){
    800009b6:	ca05                	beqz	a2,800009e6 <copyinstr+0xa8>
    char *p = (char *) (pa0 + (srcva - va0));
    800009b8:	034b9693          	slli	a3,s7,0x34
    800009bc:	92d1                	srli	a3,a3,0x34
    800009be:	96aa                	add	a3,a3,a0
    800009c0:	87a6                	mv	a5,s1
      if(*p == '\0'){
    800009c2:	8e85                	sub	a3,a3,s1
    while(n > 0){
    800009c4:	9626                	add	a2,a2,s1
    800009c6:	85be                	mv	a1,a5
      if(*p == '\0'){
    800009c8:	00f68733          	add	a4,a3,a5
    800009cc:	00074703          	lbu	a4,0(a4)
    800009d0:	db51                	beqz	a4,80000964 <copyinstr+0x26>
        *dst = *p;
    800009d2:	00e78023          	sb	a4,0(a5)
      dst++;
    800009d6:	0785                	addi	a5,a5,1
    while(n > 0){
    800009d8:	fec797e3          	bne	a5,a2,800009c6 <copyinstr+0x88>
    800009dc:	b775                	j	80000988 <copyinstr+0x4a>
    srcva = va0 + PGSIZE;
    800009de:	4781                	li	a5,0
    800009e0:	b769                	j	8000096a <copyinstr+0x2c>
      return -1;
    800009e2:	557d                	li	a0,-1
    800009e4:	b779                	j	80000972 <copyinstr+0x34>
    srcva = va0 + PGSIZE;
    800009e6:	6b85                	lui	s7,0x1
    800009e8:	9bca                	add	s7,s7,s2
    800009ea:	87a6                	mv	a5,s1
    800009ec:	b77d                	j	8000099a <copyinstr+0x5c>
    800009ee:	4781                	li	a5,0
  if(got_null){
    800009f0:	0017c793          	xori	a5,a5,1
    800009f4:	40f0053b          	negw	a0,a5
}
    800009f8:	8082                	ret

00000000800009fa <ismapped>:
  return mem;
}

int
ismapped(pagetable_t pagetable, uint64 va)
{
    800009fa:	1141                	addi	sp,sp,-16
    800009fc:	e406                	sd	ra,8(sp)
    800009fe:	e022                	sd	s0,0(sp)
    80000a00:	0800                	addi	s0,sp,16
  pte_t *pte = walk(pagetable, va, 0);
    80000a02:	4601                	li	a2,0
    80000a04:	9e3ff0ef          	jal	800003e6 <walk>
  if (pte == 0) {
    80000a08:	c119                	beqz	a0,80000a0e <ismapped+0x14>
    return 0;
  }
  if (*pte & PTE_V){
    80000a0a:	6108                	ld	a0,0(a0)
    80000a0c:	8905                	andi	a0,a0,1
    return 1;
  }
  return 0;
}
    80000a0e:	60a2                	ld	ra,8(sp)
    80000a10:	6402                	ld	s0,0(sp)
    80000a12:	0141                	addi	sp,sp,16
    80000a14:	8082                	ret

0000000080000a16 <vmfault>:
{
    80000a16:	7179                	addi	sp,sp,-48
    80000a18:	f406                	sd	ra,40(sp)
    80000a1a:	f022                	sd	s0,32(sp)
    80000a1c:	e84a                	sd	s2,16(sp)
    80000a1e:	e052                	sd	s4,0(sp)
    80000a20:	1800                	addi	s0,sp,48
    80000a22:	8a2a                	mv	s4,a0
    80000a24:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80000a26:	338000ef          	jal	80000d5e <myproc>
  if (va >= p->sz)
    80000a2a:	653c                	ld	a5,72(a0)
    80000a2c:	00f96d63          	bltu	s2,a5,80000a46 <vmfault+0x30>
    return 0;
    80000a30:	4a01                	li	s4,0
}
    80000a32:	8552                	mv	a0,s4
    80000a34:	70a2                	ld	ra,40(sp)
    80000a36:	7402                	ld	s0,32(sp)
    80000a38:	6942                	ld	s2,16(sp)
    80000a3a:	6a02                	ld	s4,0(sp)
    80000a3c:	6145                	addi	sp,sp,48
    80000a3e:	8082                	ret
    80000a40:	64e2                	ld	s1,24(sp)
    80000a42:	69a2                	ld	s3,8(sp)
    80000a44:	b7f5                	j	80000a30 <vmfault+0x1a>
    80000a46:	ec26                	sd	s1,24(sp)
    80000a48:	e44e                	sd	s3,8(sp)
    80000a4a:	84aa                	mv	s1,a0
  va = PGROUNDDOWN(va);
    80000a4c:	77fd                	lui	a5,0xfffff
    80000a4e:	00f979b3          	and	s3,s2,a5
  if(ismapped(pagetable, va)) {
    80000a52:	85ce                	mv	a1,s3
    80000a54:	8552                	mv	a0,s4
    80000a56:	fa5ff0ef          	jal	800009fa <ismapped>
    80000a5a:	c501                	beqz	a0,80000a62 <vmfault+0x4c>
    80000a5c:	64e2                	ld	s1,24(sp)
    80000a5e:	69a2                	ld	s3,8(sp)
    80000a60:	bfc1                	j	80000a30 <vmfault+0x1a>
  mem = (uint64) kalloc();
    80000a62:	ea2ff0ef          	jal	80000104 <kalloc>
    80000a66:	892a                	mv	s2,a0
  if(mem == 0)
    80000a68:	dd61                	beqz	a0,80000a40 <vmfault+0x2a>
  mem = (uint64) kalloc();
    80000a6a:	8a2a                	mv	s4,a0
  memset((void *) mem, 0, PGSIZE);
    80000a6c:	6605                	lui	a2,0x1
    80000a6e:	4581                	li	a1,0
    80000a70:	eeeff0ef          	jal	8000015e <memset>
  if (mappages(p->pagetable, va, PGSIZE, mem, PTE_W|PTE_U|PTE_R) != 0) {
    80000a74:	4759                	li	a4,22
    80000a76:	86ca                	mv	a3,s2
    80000a78:	6605                	lui	a2,0x1
    80000a7a:	85ce                	mv	a1,s3
    80000a7c:	68a8                	ld	a0,80(s1)
    80000a7e:	a39ff0ef          	jal	800004b6 <mappages>
    80000a82:	e501                	bnez	a0,80000a8a <vmfault+0x74>
    80000a84:	64e2                	ld	s1,24(sp)
    80000a86:	69a2                	ld	s3,8(sp)
    80000a88:	b76d                	j	80000a32 <vmfault+0x1c>
    kfree((void *)mem);
    80000a8a:	854a                	mv	a0,s2
    80000a8c:	d90ff0ef          	jal	8000001c <kfree>
    return 0;
    80000a90:	64e2                	ld	s1,24(sp)
    80000a92:	69a2                	ld	s3,8(sp)
    80000a94:	bf71                	j	80000a30 <vmfault+0x1a>

0000000080000a96 <copyout>:
  while(len > 0){
    80000a96:	cad5                	beqz	a3,80000b4a <copyout+0xb4>
{
    80000a98:	711d                	addi	sp,sp,-96
    80000a9a:	ec86                	sd	ra,88(sp)
    80000a9c:	e8a2                	sd	s0,80(sp)
    80000a9e:	e4a6                	sd	s1,72(sp)
    80000aa0:	e0ca                	sd	s2,64(sp)
    80000aa2:	fc4e                	sd	s3,56(sp)
    80000aa4:	f852                	sd	s4,48(sp)
    80000aa6:	f456                	sd	s5,40(sp)
    80000aa8:	f05a                	sd	s6,32(sp)
    80000aaa:	ec5e                	sd	s7,24(sp)
    80000aac:	e862                	sd	s8,16(sp)
    80000aae:	e466                	sd	s9,8(sp)
    80000ab0:	e06a                	sd	s10,0(sp)
    80000ab2:	1080                	addi	s0,sp,96
    80000ab4:	8baa                	mv	s7,a0
    80000ab6:	84ae                	mv	s1,a1
    80000ab8:	8b32                	mv	s6,a2
    80000aba:	8ab6                	mv	s5,a3
    va0 = PGROUNDDOWN(dstva);
    80000abc:	7d7d                	lui	s10,0xfffff
    if(va0 >= MAXVA)
    80000abe:	5cfd                	li	s9,-1
    80000ac0:	01acdc93          	srli	s9,s9,0x1a
    n = PGSIZE - (dstva - va0);
    80000ac4:	6c05                	lui	s8,0x1
    80000ac6:	a081                	j	80000b06 <copyout+0x70>
      return -1;
    80000ac8:	557d                	li	a0,-1
}
    80000aca:	60e6                	ld	ra,88(sp)
    80000acc:	6446                	ld	s0,80(sp)
    80000ace:	64a6                	ld	s1,72(sp)
    80000ad0:	6906                	ld	s2,64(sp)
    80000ad2:	79e2                	ld	s3,56(sp)
    80000ad4:	7a42                	ld	s4,48(sp)
    80000ad6:	7aa2                	ld	s5,40(sp)
    80000ad8:	7b02                	ld	s6,32(sp)
    80000ada:	6be2                	ld	s7,24(sp)
    80000adc:	6c42                	ld	s8,16(sp)
    80000ade:	6ca2                	ld	s9,8(sp)
    80000ae0:	6d02                	ld	s10,0(sp)
    80000ae2:	6125                	addi	sp,sp,96
    80000ae4:	8082                	ret
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000ae6:	03449513          	slli	a0,s1,0x34
    80000aea:	9151                	srli	a0,a0,0x34
    80000aec:	0009061b          	sext.w	a2,s2
    80000af0:	85da                	mv	a1,s6
    80000af2:	954e                	add	a0,a0,s3
    80000af4:	ec6ff0ef          	jal	800001ba <memmove>
    len -= n;
    80000af8:	412a8ab3          	sub	s5,s5,s2
    src += n;
    80000afc:	9b4a                	add	s6,s6,s2
    dstva = va0 + PGSIZE;
    80000afe:	018a04b3          	add	s1,s4,s8
  while(len > 0){
    80000b02:	040a8263          	beqz	s5,80000b46 <copyout+0xb0>
    va0 = PGROUNDDOWN(dstva);
    80000b06:	01a4fa33          	and	s4,s1,s10
    if(va0 >= MAXVA)
    80000b0a:	fb4cefe3          	bltu	s9,s4,80000ac8 <copyout+0x32>
    pa0 = walkaddr(pagetable, va0);
    80000b0e:	85d2                	mv	a1,s4
    80000b10:	855e                	mv	a0,s7
    80000b12:	96dff0ef          	jal	8000047e <walkaddr>
    80000b16:	89aa                	mv	s3,a0
    if(pa0 == 0) {
    80000b18:	e901                	bnez	a0,80000b28 <copyout+0x92>
      if((pa0 = vmfault(pagetable, va0, 0)) == 0) {
    80000b1a:	4601                	li	a2,0
    80000b1c:	85d2                	mv	a1,s4
    80000b1e:	855e                	mv	a0,s7
    80000b20:	ef7ff0ef          	jal	80000a16 <vmfault>
    80000b24:	89aa                	mv	s3,a0
    80000b26:	d14d                	beqz	a0,80000ac8 <copyout+0x32>
    pte = walk(pagetable, va0, 0);
    80000b28:	4601                	li	a2,0
    80000b2a:	85d2                	mv	a1,s4
    80000b2c:	855e                	mv	a0,s7
    80000b2e:	8b9ff0ef          	jal	800003e6 <walk>
    if((*pte & PTE_W) == 0)
    80000b32:	611c                	ld	a5,0(a0)
    80000b34:	8b91                	andi	a5,a5,4
    80000b36:	dbc9                	beqz	a5,80000ac8 <copyout+0x32>
    n = PGSIZE - (dstva - va0);
    80000b38:	409a0933          	sub	s2,s4,s1
    80000b3c:	9962                	add	s2,s2,s8
    if(n > len)
    80000b3e:	fb2af4e3          	bgeu	s5,s2,80000ae6 <copyout+0x50>
    80000b42:	8956                	mv	s2,s5
    80000b44:	b74d                	j	80000ae6 <copyout+0x50>
  return 0;
    80000b46:	4501                	li	a0,0
    80000b48:	b749                	j	80000aca <copyout+0x34>
    80000b4a:	4501                	li	a0,0
}
    80000b4c:	8082                	ret

0000000080000b4e <copyin>:
  while(len > 0){
    80000b4e:	c6d1                	beqz	a3,80000bda <copyin+0x8c>
{
    80000b50:	715d                	addi	sp,sp,-80
    80000b52:	e486                	sd	ra,72(sp)
    80000b54:	e0a2                	sd	s0,64(sp)
    80000b56:	fc26                	sd	s1,56(sp)
    80000b58:	f84a                	sd	s2,48(sp)
    80000b5a:	f44e                	sd	s3,40(sp)
    80000b5c:	f052                	sd	s4,32(sp)
    80000b5e:	ec56                	sd	s5,24(sp)
    80000b60:	e85a                	sd	s6,16(sp)
    80000b62:	e45e                	sd	s7,8(sp)
    80000b64:	e062                	sd	s8,0(sp)
    80000b66:	0880                	addi	s0,sp,80
    80000b68:	8baa                	mv	s7,a0
    80000b6a:	8aae                	mv	s5,a1
    80000b6c:	84b2                	mv	s1,a2
    80000b6e:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000b70:	7c7d                	lui	s8,0xfffff
    n = PGSIZE - (srcva - va0);
    80000b72:	6b05                	lui	s6,0x1
    80000b74:	a03d                	j	80000ba2 <copyin+0x54>
    80000b76:	409a0933          	sub	s2,s4,s1
    80000b7a:	995a                	add	s2,s2,s6
    if(n > len)
    80000b7c:	0129f363          	bgeu	s3,s2,80000b82 <copyin+0x34>
    80000b80:	894e                	mv	s2,s3
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000b82:	03449593          	slli	a1,s1,0x34
    80000b86:	91d1                	srli	a1,a1,0x34
    80000b88:	0009061b          	sext.w	a2,s2
    80000b8c:	95aa                	add	a1,a1,a0
    80000b8e:	8556                	mv	a0,s5
    80000b90:	e2aff0ef          	jal	800001ba <memmove>
    len -= n;
    80000b94:	412989b3          	sub	s3,s3,s2
    dst += n;
    80000b98:	9aca                	add	s5,s5,s2
    srcva = va0 + PGSIZE;
    80000b9a:	016a04b3          	add	s1,s4,s6
  while(len > 0){
    80000b9e:	02098163          	beqz	s3,80000bc0 <copyin+0x72>
    va0 = PGROUNDDOWN(srcva);
    80000ba2:	0184fa33          	and	s4,s1,s8
    pa0 = walkaddr(pagetable, va0);
    80000ba6:	85d2                	mv	a1,s4
    80000ba8:	855e                	mv	a0,s7
    80000baa:	8d5ff0ef          	jal	8000047e <walkaddr>
    if(pa0 == 0) {
    80000bae:	f561                	bnez	a0,80000b76 <copyin+0x28>
      if((pa0 = vmfault(pagetable, va0, 0)) == 0) {
    80000bb0:	4601                	li	a2,0
    80000bb2:	85d2                	mv	a1,s4
    80000bb4:	855e                	mv	a0,s7
    80000bb6:	e61ff0ef          	jal	80000a16 <vmfault>
    80000bba:	fd55                	bnez	a0,80000b76 <copyin+0x28>
        return -1;
    80000bbc:	557d                	li	a0,-1
    80000bbe:	a011                	j	80000bc2 <copyin+0x74>
  return 0;
    80000bc0:	4501                	li	a0,0
}
    80000bc2:	60a6                	ld	ra,72(sp)
    80000bc4:	6406                	ld	s0,64(sp)
    80000bc6:	74e2                	ld	s1,56(sp)
    80000bc8:	7942                	ld	s2,48(sp)
    80000bca:	79a2                	ld	s3,40(sp)
    80000bcc:	7a02                	ld	s4,32(sp)
    80000bce:	6ae2                	ld	s5,24(sp)
    80000bd0:	6b42                	ld	s6,16(sp)
    80000bd2:	6ba2                	ld	s7,8(sp)
    80000bd4:	6c02                	ld	s8,0(sp)
    80000bd6:	6161                	addi	sp,sp,80
    80000bd8:	8082                	ret
  return 0;
    80000bda:	4501                	li	a0,0
}
    80000bdc:	8082                	ret

0000000080000bde <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80000bde:	715d                	addi	sp,sp,-80
    80000be0:	e486                	sd	ra,72(sp)
    80000be2:	e0a2                	sd	s0,64(sp)
    80000be4:	fc26                	sd	s1,56(sp)
    80000be6:	f84a                	sd	s2,48(sp)
    80000be8:	f44e                	sd	s3,40(sp)
    80000bea:	f052                	sd	s4,32(sp)
    80000bec:	ec56                	sd	s5,24(sp)
    80000bee:	e85a                	sd	s6,16(sp)
    80000bf0:	e45e                	sd	s7,8(sp)
    80000bf2:	0880                	addi	s0,sp,80
    80000bf4:	8aaa                	mv	s5,a0
    80000bf6:	4481                	li	s1,0
  
  for(p = proc; p < &proc[NPROC]; p++) {
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000bf8:	000a57b7          	lui	a5,0xa5
    80000bfc:	fa578793          	addi	a5,a5,-91 # a4fa5 <_entry-0x7ff5b05b>
    80000c00:	07b2                	slli	a5,a5,0xc
    80000c02:	fa578793          	addi	a5,a5,-91
    80000c06:	4fa50937          	lui	s2,0x4fa50
    80000c0a:	a4f90913          	addi	s2,s2,-1457 # 4fa4fa4f <_entry-0x305b05b1>
    80000c0e:	1902                	slli	s2,s2,0x20
    80000c10:	993e                	add	s2,s2,a5
    80000c12:	040009b7          	lui	s3,0x4000
    80000c16:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000c18:	09b2                	slli	s3,s3,0xc
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000c1a:	4b99                	li	s7,6
    80000c1c:	6b05                	lui	s6,0x1
  for(p = proc; p < &proc[NPROC]; p++) {
    80000c1e:	6a19                	lui	s4,0x6
    80000c20:	a00a0a13          	addi	s4,s4,-1536 # 5a00 <_entry-0x7fffa600>
    char *pa = kalloc();
    80000c24:	ce0ff0ef          	jal	80000104 <kalloc>
    80000c28:	862a                	mv	a2,a0
    if(pa == 0)
    80000c2a:	cd15                	beqz	a0,80000c66 <proc_mapstacks+0x88>
    uint64 va = KSTACK((int) (p - proc));
    80000c2c:	4034d593          	srai	a1,s1,0x3
    80000c30:	032585b3          	mul	a1,a1,s2
    80000c34:	05b6                	slli	a1,a1,0xd
    80000c36:	6789                	lui	a5,0x2
    80000c38:	9dbd                	addw	a1,a1,a5
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000c3a:	875e                	mv	a4,s7
    80000c3c:	86da                	mv	a3,s6
    80000c3e:	40b985b3          	sub	a1,s3,a1
    80000c42:	8556                	mv	a0,s5
    80000c44:	925ff0ef          	jal	80000568 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000c48:	16848493          	addi	s1,s1,360
    80000c4c:	fd449ce3          	bne	s1,s4,80000c24 <proc_mapstacks+0x46>
  }
}
    80000c50:	60a6                	ld	ra,72(sp)
    80000c52:	6406                	ld	s0,64(sp)
    80000c54:	74e2                	ld	s1,56(sp)
    80000c56:	7942                	ld	s2,48(sp)
    80000c58:	79a2                	ld	s3,40(sp)
    80000c5a:	7a02                	ld	s4,32(sp)
    80000c5c:	6ae2                	ld	s5,24(sp)
    80000c5e:	6b42                	ld	s6,16(sp)
    80000c60:	6ba2                	ld	s7,8(sp)
    80000c62:	6161                	addi	sp,sp,80
    80000c64:	8082                	ret
      panic("kalloc");
    80000c66:	00006517          	auipc	a0,0x6
    80000c6a:	49250513          	addi	a0,a0,1170 # 800070f8 <etext+0xf8>
    80000c6e:	0e7040ef          	jal	80005554 <panic>

0000000080000c72 <procinit>:

// initialize the proc table.
void
procinit(void)
{
    80000c72:	7139                	addi	sp,sp,-64
    80000c74:	fc06                	sd	ra,56(sp)
    80000c76:	f822                	sd	s0,48(sp)
    80000c78:	f426                	sd	s1,40(sp)
    80000c7a:	f04a                	sd	s2,32(sp)
    80000c7c:	ec4e                	sd	s3,24(sp)
    80000c7e:	e852                	sd	s4,16(sp)
    80000c80:	e456                	sd	s5,8(sp)
    80000c82:	e05a                	sd	s6,0(sp)
    80000c84:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000c86:	00006597          	auipc	a1,0x6
    80000c8a:	47a58593          	addi	a1,a1,1146 # 80007100 <etext+0x100>
    80000c8e:	00007517          	auipc	a0,0x7
    80000c92:	bf250513          	addi	a0,a0,-1038 # 80007880 <pid_lock>
    80000c96:	2f3040ef          	jal	80005788 <initlock>
  initlock(&wait_lock, "wait_lock");
    80000c9a:	00006597          	auipc	a1,0x6
    80000c9e:	46e58593          	addi	a1,a1,1134 # 80007108 <etext+0x108>
    80000ca2:	00007517          	auipc	a0,0x7
    80000ca6:	bf650513          	addi	a0,a0,-1034 # 80007898 <wait_lock>
    80000caa:	2df040ef          	jal	80005788 <initlock>
    80000cae:	4901                	li	s2,0
  for(p = proc; p < &proc[NPROC]; p++) {
    80000cb0:	00007497          	auipc	s1,0x7
    80000cb4:	00048493          	mv	s1,s1
      initlock(&p->lock, "proc");
    80000cb8:	00006a97          	auipc	s5,0x6
    80000cbc:	460a8a93          	addi	s5,s5,1120 # 80007118 <etext+0x118>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80000cc0:	000a57b7          	lui	a5,0xa5
    80000cc4:	fa578793          	addi	a5,a5,-91 # a4fa5 <_entry-0x7ff5b05b>
    80000cc8:	07b2                	slli	a5,a5,0xc
    80000cca:	fa578793          	addi	a5,a5,-91
    80000cce:	4fa509b7          	lui	s3,0x4fa50
    80000cd2:	a4f98993          	addi	s3,s3,-1457 # 4fa4fa4f <_entry-0x305b05b1>
    80000cd6:	1982                	slli	s3,s3,0x20
    80000cd8:	99be                	add	s3,s3,a5
    80000cda:	04000a37          	lui	s4,0x4000
    80000cde:	1a7d                	addi	s4,s4,-1 # 3ffffff <_entry-0x7c000001>
    80000ce0:	0a32                	slli	s4,s4,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000ce2:	0000db17          	auipc	s6,0xd
    80000ce6:	9ceb0b13          	addi	s6,s6,-1586 # 8000d6b0 <tickslock>
      initlock(&p->lock, "proc");
    80000cea:	85d6                	mv	a1,s5
    80000cec:	8526                	mv	a0,s1
    80000cee:	29b040ef          	jal	80005788 <initlock>
      p->state = UNUSED;
    80000cf2:	0004ac23          	sw	zero,24(s1) # 80007cc8 <proc+0x18>
      p->kstack = KSTACK((int) (p - proc));
    80000cf6:	40395793          	srai	a5,s2,0x3
    80000cfa:	033787b3          	mul	a5,a5,s3
    80000cfe:	07b6                	slli	a5,a5,0xd
    80000d00:	6709                	lui	a4,0x2
    80000d02:	9fb9                	addw	a5,a5,a4
    80000d04:	40fa07b3          	sub	a5,s4,a5
    80000d08:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d0a:	16848493          	addi	s1,s1,360
    80000d0e:	16890913          	addi	s2,s2,360
    80000d12:	fd649ce3          	bne	s1,s6,80000cea <procinit+0x78>
  }
}
    80000d16:	70e2                	ld	ra,56(sp)
    80000d18:	7442                	ld	s0,48(sp)
    80000d1a:	74a2                	ld	s1,40(sp)
    80000d1c:	7902                	ld	s2,32(sp)
    80000d1e:	69e2                	ld	s3,24(sp)
    80000d20:	6a42                	ld	s4,16(sp)
    80000d22:	6aa2                	ld	s5,8(sp)
    80000d24:	6b02                	ld	s6,0(sp)
    80000d26:	6121                	addi	sp,sp,64
    80000d28:	8082                	ret

0000000080000d2a <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000d2a:	1141                	addi	sp,sp,-16
    80000d2c:	e406                	sd	ra,8(sp)
    80000d2e:	e022                	sd	s0,0(sp)
    80000d30:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000d32:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000d34:	2501                	sext.w	a0,a0
    80000d36:	60a2                	ld	ra,8(sp)
    80000d38:	6402                	ld	s0,0(sp)
    80000d3a:	0141                	addi	sp,sp,16
    80000d3c:	8082                	ret

0000000080000d3e <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    80000d3e:	1141                	addi	sp,sp,-16
    80000d40:	e406                	sd	ra,8(sp)
    80000d42:	e022                	sd	s0,0(sp)
    80000d44:	0800                	addi	s0,sp,16
    80000d46:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000d48:	2781                	sext.w	a5,a5
    80000d4a:	079e                	slli	a5,a5,0x7
  return c;
}
    80000d4c:	00007517          	auipc	a0,0x7
    80000d50:	b6450513          	addi	a0,a0,-1180 # 800078b0 <cpus>
    80000d54:	953e                	add	a0,a0,a5
    80000d56:	60a2                	ld	ra,8(sp)
    80000d58:	6402                	ld	s0,0(sp)
    80000d5a:	0141                	addi	sp,sp,16
    80000d5c:	8082                	ret

0000000080000d5e <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80000d5e:	1101                	addi	sp,sp,-32
    80000d60:	ec06                	sd	ra,24(sp)
    80000d62:	e822                	sd	s0,16(sp)
    80000d64:	e426                	sd	s1,8(sp)
    80000d66:	1000                	addi	s0,sp,32
  push_off();
    80000d68:	267040ef          	jal	800057ce <push_off>
    80000d6c:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000d6e:	2781                	sext.w	a5,a5
    80000d70:	079e                	slli	a5,a5,0x7
    80000d72:	00007717          	auipc	a4,0x7
    80000d76:	b0e70713          	addi	a4,a4,-1266 # 80007880 <pid_lock>
    80000d7a:	97ba                	add	a5,a5,a4
    80000d7c:	7b9c                	ld	a5,48(a5)
    80000d7e:	84be                	mv	s1,a5
  pop_off();
    80000d80:	2d3040ef          	jal	80005852 <pop_off>
  return p;
}
    80000d84:	8526                	mv	a0,s1
    80000d86:	60e2                	ld	ra,24(sp)
    80000d88:	6442                	ld	s0,16(sp)
    80000d8a:	64a2                	ld	s1,8(sp)
    80000d8c:	6105                	addi	sp,sp,32
    80000d8e:	8082                	ret

0000000080000d90 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000d90:	7179                	addi	sp,sp,-48
    80000d92:	f406                	sd	ra,40(sp)
    80000d94:	f022                	sd	s0,32(sp)
    80000d96:	ec26                	sd	s1,24(sp)
    80000d98:	1800                	addi	s0,sp,48
  extern char userret[];
  static int first = 1;
  struct proc *p = myproc();
    80000d9a:	fc5ff0ef          	jal	80000d5e <myproc>
    80000d9e:	84aa                	mv	s1,a0

  // Still holding p->lock from scheduler.
  release(&p->lock);
    80000da0:	303040ef          	jal	800058a2 <release>

  if (first) {
    80000da4:	00007797          	auipc	a5,0x7
    80000da8:	a7c7a783          	lw	a5,-1412(a5) # 80007820 <first.1>
    80000dac:	cf95                	beqz	a5,80000de8 <forkret+0x58>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    fsinit(ROOTDEV);
    80000dae:	4505                	li	a0,1
    80000db0:	34d010ef          	jal	800028fc <fsinit>

    first = 0;
    80000db4:	00007797          	auipc	a5,0x7
    80000db8:	a607a623          	sw	zero,-1428(a5) # 80007820 <first.1>
    // ensure other cores see first=0.
    __sync_synchronize();
    80000dbc:	0330000f          	fence	rw,rw

    // We can invoke kexec() now that file system is initialized.
    // Put the return value (argc) of kexec into a0.
    p->trapframe->a0 = kexec("/init", (char *[]){ "/init", 0 });
    80000dc0:	00006797          	auipc	a5,0x6
    80000dc4:	36078793          	addi	a5,a5,864 # 80007120 <etext+0x120>
    80000dc8:	fcf43823          	sd	a5,-48(s0)
    80000dcc:	fc043c23          	sd	zero,-40(s0)
    80000dd0:	fd040593          	addi	a1,s0,-48
    80000dd4:	853e                	mv	a0,a5
    80000dd6:	499020ef          	jal	80003a6e <kexec>
    80000dda:	6cbc                	ld	a5,88(s1)
    80000ddc:	fba8                	sd	a0,112(a5)
    if (p->trapframe->a0 == -1) {
    80000dde:	6cbc                	ld	a5,88(s1)
    80000de0:	7bb8                	ld	a4,112(a5)
    80000de2:	57fd                	li	a5,-1
    80000de4:	02f70d63          	beq	a4,a5,80000e1e <forkret+0x8e>
      panic("exec");
    }
  }

  // return to user space, mimicing usertrap()'s return.
  prepare_return();
    80000de8:	297000ef          	jal	8000187e <prepare_return>
  uint64 satp = MAKE_SATP(p->pagetable);
    80000dec:	68a8                	ld	a0,80(s1)
    80000dee:	8131                	srli	a0,a0,0xc
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80000df0:	04000737          	lui	a4,0x4000
    80000df4:	177d                	addi	a4,a4,-1 # 3ffffff <_entry-0x7c000001>
    80000df6:	0732                	slli	a4,a4,0xc
    80000df8:	00005797          	auipc	a5,0x5
    80000dfc:	2a478793          	addi	a5,a5,676 # 8000609c <userret>
    80000e00:	00005697          	auipc	a3,0x5
    80000e04:	20068693          	addi	a3,a3,512 # 80006000 <_trampoline>
    80000e08:	8f95                	sub	a5,a5,a3
    80000e0a:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80000e0c:	577d                	li	a4,-1
    80000e0e:	177e                	slli	a4,a4,0x3f
    80000e10:	8d59                	or	a0,a0,a4
    80000e12:	9782                	jalr	a5
}
    80000e14:	70a2                	ld	ra,40(sp)
    80000e16:	7402                	ld	s0,32(sp)
    80000e18:	64e2                	ld	s1,24(sp)
    80000e1a:	6145                	addi	sp,sp,48
    80000e1c:	8082                	ret
      panic("exec");
    80000e1e:	00006517          	auipc	a0,0x6
    80000e22:	30a50513          	addi	a0,a0,778 # 80007128 <etext+0x128>
    80000e26:	72e040ef          	jal	80005554 <panic>

0000000080000e2a <allocpid>:
{
    80000e2a:	1101                	addi	sp,sp,-32
    80000e2c:	ec06                	sd	ra,24(sp)
    80000e2e:	e822                	sd	s0,16(sp)
    80000e30:	e426                	sd	s1,8(sp)
    80000e32:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000e34:	00007517          	auipc	a0,0x7
    80000e38:	a4c50513          	addi	a0,a0,-1460 # 80007880 <pid_lock>
    80000e3c:	1d7040ef          	jal	80005812 <acquire>
  pid = nextpid;
    80000e40:	00007797          	auipc	a5,0x7
    80000e44:	9e478793          	addi	a5,a5,-1564 # 80007824 <nextpid>
    80000e48:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000e4a:	0014871b          	addiw	a4,s1,1
    80000e4e:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000e50:	00007517          	auipc	a0,0x7
    80000e54:	a3050513          	addi	a0,a0,-1488 # 80007880 <pid_lock>
    80000e58:	24b040ef          	jal	800058a2 <release>
}
    80000e5c:	8526                	mv	a0,s1
    80000e5e:	60e2                	ld	ra,24(sp)
    80000e60:	6442                	ld	s0,16(sp)
    80000e62:	64a2                	ld	s1,8(sp)
    80000e64:	6105                	addi	sp,sp,32
    80000e66:	8082                	ret

0000000080000e68 <proc_pagetable>:
{
    80000e68:	1101                	addi	sp,sp,-32
    80000e6a:	ec06                	sd	ra,24(sp)
    80000e6c:	e822                	sd	s0,16(sp)
    80000e6e:	e426                	sd	s1,8(sp)
    80000e70:	e04a                	sd	s2,0(sp)
    80000e72:	1000                	addi	s0,sp,32
    80000e74:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000e76:	fe0ff0ef          	jal	80000656 <uvmcreate>
    80000e7a:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000e7c:	cd05                	beqz	a0,80000eb4 <proc_pagetable+0x4c>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80000e7e:	4729                	li	a4,10
    80000e80:	00005697          	auipc	a3,0x5
    80000e84:	18068693          	addi	a3,a3,384 # 80006000 <_trampoline>
    80000e88:	6605                	lui	a2,0x1
    80000e8a:	040005b7          	lui	a1,0x4000
    80000e8e:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000e90:	05b2                	slli	a1,a1,0xc
    80000e92:	e24ff0ef          	jal	800004b6 <mappages>
    80000e96:	02054663          	bltz	a0,80000ec2 <proc_pagetable+0x5a>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80000e9a:	4719                	li	a4,6
    80000e9c:	05893683          	ld	a3,88(s2)
    80000ea0:	6605                	lui	a2,0x1
    80000ea2:	020005b7          	lui	a1,0x2000
    80000ea6:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000ea8:	05b6                	slli	a1,a1,0xd
    80000eaa:	8526                	mv	a0,s1
    80000eac:	e0aff0ef          	jal	800004b6 <mappages>
    80000eb0:	00054f63          	bltz	a0,80000ece <proc_pagetable+0x66>
}
    80000eb4:	8526                	mv	a0,s1
    80000eb6:	60e2                	ld	ra,24(sp)
    80000eb8:	6442                	ld	s0,16(sp)
    80000eba:	64a2                	ld	s1,8(sp)
    80000ebc:	6902                	ld	s2,0(sp)
    80000ebe:	6105                	addi	sp,sp,32
    80000ec0:	8082                	ret
    uvmfree(pagetable, 0);
    80000ec2:	4581                	li	a1,0
    80000ec4:	8526                	mv	a0,s1
    80000ec6:	983ff0ef          	jal	80000848 <uvmfree>
    return 0;
    80000eca:	4481                	li	s1,0
    80000ecc:	b7e5                	j	80000eb4 <proc_pagetable+0x4c>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000ece:	4681                	li	a3,0
    80000ed0:	4605                	li	a2,1
    80000ed2:	040005b7          	lui	a1,0x4000
    80000ed6:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000ed8:	05b2                	slli	a1,a1,0xc
    80000eda:	8526                	mv	a0,s1
    80000edc:	fa0ff0ef          	jal	8000067c <uvmunmap>
    uvmfree(pagetable, 0);
    80000ee0:	4581                	li	a1,0
    80000ee2:	8526                	mv	a0,s1
    80000ee4:	965ff0ef          	jal	80000848 <uvmfree>
    return 0;
    80000ee8:	b7cd                	j	80000eca <proc_pagetable+0x62>

0000000080000eea <proc_freepagetable>:
{
    80000eea:	1101                	addi	sp,sp,-32
    80000eec:	ec06                	sd	ra,24(sp)
    80000eee:	e822                	sd	s0,16(sp)
    80000ef0:	e426                	sd	s1,8(sp)
    80000ef2:	e04a                	sd	s2,0(sp)
    80000ef4:	1000                	addi	s0,sp,32
    80000ef6:	84aa                	mv	s1,a0
    80000ef8:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000efa:	4681                	li	a3,0
    80000efc:	4605                	li	a2,1
    80000efe:	040005b7          	lui	a1,0x4000
    80000f02:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000f04:	05b2                	slli	a1,a1,0xc
    80000f06:	f76ff0ef          	jal	8000067c <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80000f0a:	4681                	li	a3,0
    80000f0c:	4605                	li	a2,1
    80000f0e:	020005b7          	lui	a1,0x2000
    80000f12:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000f14:	05b6                	slli	a1,a1,0xd
    80000f16:	8526                	mv	a0,s1
    80000f18:	f64ff0ef          	jal	8000067c <uvmunmap>
  uvmfree(pagetable, sz);
    80000f1c:	85ca                	mv	a1,s2
    80000f1e:	8526                	mv	a0,s1
    80000f20:	929ff0ef          	jal	80000848 <uvmfree>
}
    80000f24:	60e2                	ld	ra,24(sp)
    80000f26:	6442                	ld	s0,16(sp)
    80000f28:	64a2                	ld	s1,8(sp)
    80000f2a:	6902                	ld	s2,0(sp)
    80000f2c:	6105                	addi	sp,sp,32
    80000f2e:	8082                	ret

0000000080000f30 <freeproc>:
{
    80000f30:	1101                	addi	sp,sp,-32
    80000f32:	ec06                	sd	ra,24(sp)
    80000f34:	e822                	sd	s0,16(sp)
    80000f36:	e426                	sd	s1,8(sp)
    80000f38:	1000                	addi	s0,sp,32
    80000f3a:	84aa                	mv	s1,a0
  if(p->trapframe)
    80000f3c:	6d28                	ld	a0,88(a0)
    80000f3e:	c119                	beqz	a0,80000f44 <freeproc+0x14>
    kfree((void*)p->trapframe);
    80000f40:	8dcff0ef          	jal	8000001c <kfree>
  p->trapframe = 0;
    80000f44:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80000f48:	68a8                	ld	a0,80(s1)
    80000f4a:	c501                	beqz	a0,80000f52 <freeproc+0x22>
    proc_freepagetable(p->pagetable, p->sz);
    80000f4c:	64ac                	ld	a1,72(s1)
    80000f4e:	f9dff0ef          	jal	80000eea <proc_freepagetable>
  p->pagetable = 0;
    80000f52:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80000f56:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80000f5a:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80000f5e:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80000f62:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80000f66:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80000f6a:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80000f6e:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80000f72:	0004ac23          	sw	zero,24(s1)
}
    80000f76:	60e2                	ld	ra,24(sp)
    80000f78:	6442                	ld	s0,16(sp)
    80000f7a:	64a2                	ld	s1,8(sp)
    80000f7c:	6105                	addi	sp,sp,32
    80000f7e:	8082                	ret

0000000080000f80 <allocproc>:
{
    80000f80:	1101                	addi	sp,sp,-32
    80000f82:	ec06                	sd	ra,24(sp)
    80000f84:	e822                	sd	s0,16(sp)
    80000f86:	e426                	sd	s1,8(sp)
    80000f88:	e04a                	sd	s2,0(sp)
    80000f8a:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80000f8c:	00007497          	auipc	s1,0x7
    80000f90:	d2448493          	addi	s1,s1,-732 # 80007cb0 <proc>
    80000f94:	0000c917          	auipc	s2,0xc
    80000f98:	71c90913          	addi	s2,s2,1820 # 8000d6b0 <tickslock>
    acquire(&p->lock);
    80000f9c:	8526                	mv	a0,s1
    80000f9e:	075040ef          	jal	80005812 <acquire>
    if(p->state == UNUSED) {
    80000fa2:	4c9c                	lw	a5,24(s1)
    80000fa4:	cb91                	beqz	a5,80000fb8 <allocproc+0x38>
      release(&p->lock);
    80000fa6:	8526                	mv	a0,s1
    80000fa8:	0fb040ef          	jal	800058a2 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000fac:	16848493          	addi	s1,s1,360
    80000fb0:	ff2496e3          	bne	s1,s2,80000f9c <allocproc+0x1c>
  return 0;
    80000fb4:	4481                	li	s1,0
    80000fb6:	a089                	j	80000ff8 <allocproc+0x78>
  p->pid = allocpid();
    80000fb8:	e73ff0ef          	jal	80000e2a <allocpid>
    80000fbc:	d888                	sw	a0,48(s1)
  p->state = USED;
    80000fbe:	4785                	li	a5,1
    80000fc0:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80000fc2:	942ff0ef          	jal	80000104 <kalloc>
    80000fc6:	892a                	mv	s2,a0
    80000fc8:	eca8                	sd	a0,88(s1)
    80000fca:	cd15                	beqz	a0,80001006 <allocproc+0x86>
  p->pagetable = proc_pagetable(p);
    80000fcc:	8526                	mv	a0,s1
    80000fce:	e9bff0ef          	jal	80000e68 <proc_pagetable>
    80000fd2:	892a                	mv	s2,a0
    80000fd4:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    80000fd6:	c121                	beqz	a0,80001016 <allocproc+0x96>
  memset(&p->context, 0, sizeof(p->context));
    80000fd8:	07000613          	li	a2,112
    80000fdc:	4581                	li	a1,0
    80000fde:	06048513          	addi	a0,s1,96
    80000fe2:	97cff0ef          	jal	8000015e <memset>
  p->context.ra = (uint64)forkret;
    80000fe6:	00000797          	auipc	a5,0x0
    80000fea:	daa78793          	addi	a5,a5,-598 # 80000d90 <forkret>
    80000fee:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80000ff0:	60bc                	ld	a5,64(s1)
    80000ff2:	6705                	lui	a4,0x1
    80000ff4:	97ba                	add	a5,a5,a4
    80000ff6:	f4bc                	sd	a5,104(s1)
}
    80000ff8:	8526                	mv	a0,s1
    80000ffa:	60e2                	ld	ra,24(sp)
    80000ffc:	6442                	ld	s0,16(sp)
    80000ffe:	64a2                	ld	s1,8(sp)
    80001000:	6902                	ld	s2,0(sp)
    80001002:	6105                	addi	sp,sp,32
    80001004:	8082                	ret
    freeproc(p);
    80001006:	8526                	mv	a0,s1
    80001008:	f29ff0ef          	jal	80000f30 <freeproc>
    release(&p->lock);
    8000100c:	8526                	mv	a0,s1
    8000100e:	095040ef          	jal	800058a2 <release>
    return 0;
    80001012:	84ca                	mv	s1,s2
    80001014:	b7d5                	j	80000ff8 <allocproc+0x78>
    freeproc(p);
    80001016:	8526                	mv	a0,s1
    80001018:	f19ff0ef          	jal	80000f30 <freeproc>
    release(&p->lock);
    8000101c:	8526                	mv	a0,s1
    8000101e:	085040ef          	jal	800058a2 <release>
    return 0;
    80001022:	84ca                	mv	s1,s2
    80001024:	bfd1                	j	80000ff8 <allocproc+0x78>

0000000080001026 <userinit>:
{
    80001026:	1101                	addi	sp,sp,-32
    80001028:	ec06                	sd	ra,24(sp)
    8000102a:	e822                	sd	s0,16(sp)
    8000102c:	e426                	sd	s1,8(sp)
    8000102e:	1000                	addi	s0,sp,32
  p = allocproc();
    80001030:	f51ff0ef          	jal	80000f80 <allocproc>
    80001034:	84aa                	mv	s1,a0
  initproc = p;
    80001036:	00007797          	auipc	a5,0x7
    8000103a:	80a7b523          	sd	a0,-2038(a5) # 80007840 <initproc>
  p->cwd = namei("/");
    8000103e:	00006517          	auipc	a0,0x6
    80001042:	0f250513          	addi	a0,a0,242 # 80007130 <etext+0x130>
    80001046:	5fb010ef          	jal	80002e40 <namei>
    8000104a:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    8000104e:	478d                	li	a5,3
    80001050:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001052:	8526                	mv	a0,s1
    80001054:	04f040ef          	jal	800058a2 <release>
}
    80001058:	60e2                	ld	ra,24(sp)
    8000105a:	6442                	ld	s0,16(sp)
    8000105c:	64a2                	ld	s1,8(sp)
    8000105e:	6105                	addi	sp,sp,32
    80001060:	8082                	ret

0000000080001062 <growproc>:
{
    80001062:	1101                	addi	sp,sp,-32
    80001064:	ec06                	sd	ra,24(sp)
    80001066:	e822                	sd	s0,16(sp)
    80001068:	e426                	sd	s1,8(sp)
    8000106a:	e04a                	sd	s2,0(sp)
    8000106c:	1000                	addi	s0,sp,32
    8000106e:	892a                	mv	s2,a0
  struct proc *p = myproc();
    80001070:	cefff0ef          	jal	80000d5e <myproc>
    80001074:	84aa                	mv	s1,a0
  sz = p->sz;
    80001076:	652c                	ld	a1,72(a0)
  if(n > 0){
    80001078:	01204c63          	bgtz	s2,80001090 <growproc+0x2e>
  } else if(n < 0){
    8000107c:	02094463          	bltz	s2,800010a4 <growproc+0x42>
  p->sz = sz;
    80001080:	e4ac                	sd	a1,72(s1)
  return 0;
    80001082:	4501                	li	a0,0
}
    80001084:	60e2                	ld	ra,24(sp)
    80001086:	6442                	ld	s0,16(sp)
    80001088:	64a2                	ld	s1,8(sp)
    8000108a:	6902                	ld	s2,0(sp)
    8000108c:	6105                	addi	sp,sp,32
    8000108e:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80001090:	4691                	li	a3,4
    80001092:	00b90633          	add	a2,s2,a1
    80001096:	6928                	ld	a0,80(a0)
    80001098:	eb4ff0ef          	jal	8000074c <uvmalloc>
    8000109c:	85aa                	mv	a1,a0
    8000109e:	f16d                	bnez	a0,80001080 <growproc+0x1e>
      return -1;
    800010a0:	557d                	li	a0,-1
    800010a2:	b7cd                	j	80001084 <growproc+0x22>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    800010a4:	00b90633          	add	a2,s2,a1
    800010a8:	6928                	ld	a0,80(a0)
    800010aa:	e5cff0ef          	jal	80000706 <uvmdealloc>
    800010ae:	85aa                	mv	a1,a0
    800010b0:	bfc1                	j	80001080 <growproc+0x1e>

00000000800010b2 <kfork>:
{
    800010b2:	7139                	addi	sp,sp,-64
    800010b4:	fc06                	sd	ra,56(sp)
    800010b6:	f822                	sd	s0,48(sp)
    800010b8:	f426                	sd	s1,40(sp)
    800010ba:	e456                	sd	s5,8(sp)
    800010bc:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    800010be:	ca1ff0ef          	jal	80000d5e <myproc>
    800010c2:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    800010c4:	ebdff0ef          	jal	80000f80 <allocproc>
    800010c8:	c92d                	beqz	a0,8000113a <kfork+0x88>
    800010ca:	e852                	sd	s4,16(sp)
    800010cc:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    800010ce:	048ab603          	ld	a2,72(s5)
    800010d2:	692c                	ld	a1,80(a0)
    800010d4:	050ab503          	ld	a0,80(s5)
    800010d8:	fa2ff0ef          	jal	8000087a <uvmcopy>
    800010dc:	04054863          	bltz	a0,8000112c <kfork+0x7a>
    800010e0:	f04a                	sd	s2,32(sp)
    800010e2:	ec4e                	sd	s3,24(sp)
  np->sz = p->sz;
    800010e4:	048ab783          	ld	a5,72(s5)
    800010e8:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    800010ec:	058ab683          	ld	a3,88(s5)
    800010f0:	87b6                	mv	a5,a3
    800010f2:	058a3703          	ld	a4,88(s4)
    800010f6:	12068693          	addi	a3,a3,288
    800010fa:	6388                	ld	a0,0(a5)
    800010fc:	678c                	ld	a1,8(a5)
    800010fe:	6b90                	ld	a2,16(a5)
    80001100:	e308                	sd	a0,0(a4)
    80001102:	e70c                	sd	a1,8(a4)
    80001104:	eb10                	sd	a2,16(a4)
    80001106:	6f90                	ld	a2,24(a5)
    80001108:	ef10                	sd	a2,24(a4)
    8000110a:	02078793          	addi	a5,a5,32
    8000110e:	02070713          	addi	a4,a4,32 # 1020 <_entry-0x7fffefe0>
    80001112:	fed794e3          	bne	a5,a3,800010fa <kfork+0x48>
  np->trapframe->a0 = 0;
    80001116:	058a3783          	ld	a5,88(s4)
    8000111a:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    8000111e:	0d0a8493          	addi	s1,s5,208
    80001122:	0d0a0913          	addi	s2,s4,208
    80001126:	150a8993          	addi	s3,s5,336
    8000112a:	a831                	j	80001146 <kfork+0x94>
    freeproc(np);
    8000112c:	8552                	mv	a0,s4
    8000112e:	e03ff0ef          	jal	80000f30 <freeproc>
    release(&np->lock);
    80001132:	8552                	mv	a0,s4
    80001134:	76e040ef          	jal	800058a2 <release>
    return -1;
    80001138:	6a42                	ld	s4,16(sp)
    return -1;
    8000113a:	54fd                	li	s1,-1
    8000113c:	a885                	j	800011ac <kfork+0xfa>
  for(i = 0; i < NOFILE; i++)
    8000113e:	04a1                	addi	s1,s1,8
    80001140:	0921                	addi	s2,s2,8
    80001142:	01348963          	beq	s1,s3,80001154 <kfork+0xa2>
    if(p->ofile[i])
    80001146:	6088                	ld	a0,0(s1)
    80001148:	d97d                	beqz	a0,8000113e <kfork+0x8c>
      np->ofile[i] = filedup(p->ofile[i]);
    8000114a:	2ae020ef          	jal	800033f8 <filedup>
    8000114e:	00a93023          	sd	a0,0(s2)
    80001152:	b7f5                	j	8000113e <kfork+0x8c>
  np->cwd = idup(p->cwd);
    80001154:	150ab503          	ld	a0,336(s5)
    80001158:	47a010ef          	jal	800025d2 <idup>
    8000115c:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001160:	4641                	li	a2,16
    80001162:	158a8593          	addi	a1,s5,344
    80001166:	158a0513          	addi	a0,s4,344
    8000116a:	93eff0ef          	jal	800002a8 <safestrcpy>
  pid = np->pid;
    8000116e:	030a2483          	lw	s1,48(s4)
  release(&np->lock);
    80001172:	8552                	mv	a0,s4
    80001174:	72e040ef          	jal	800058a2 <release>
  acquire(&wait_lock);
    80001178:	00006517          	auipc	a0,0x6
    8000117c:	72050513          	addi	a0,a0,1824 # 80007898 <wait_lock>
    80001180:	692040ef          	jal	80005812 <acquire>
  np->parent = p;
    80001184:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    80001188:	00006517          	auipc	a0,0x6
    8000118c:	71050513          	addi	a0,a0,1808 # 80007898 <wait_lock>
    80001190:	712040ef          	jal	800058a2 <release>
  acquire(&np->lock);
    80001194:	8552                	mv	a0,s4
    80001196:	67c040ef          	jal	80005812 <acquire>
  np->state = RUNNABLE;
    8000119a:	478d                	li	a5,3
    8000119c:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    800011a0:	8552                	mv	a0,s4
    800011a2:	700040ef          	jal	800058a2 <release>
    800011a6:	7902                	ld	s2,32(sp)
    800011a8:	69e2                	ld	s3,24(sp)
    800011aa:	6a42                	ld	s4,16(sp)
}
    800011ac:	8526                	mv	a0,s1
    800011ae:	70e2                	ld	ra,56(sp)
    800011b0:	7442                	ld	s0,48(sp)
    800011b2:	74a2                	ld	s1,40(sp)
    800011b4:	6aa2                	ld	s5,8(sp)
    800011b6:	6121                	addi	sp,sp,64
    800011b8:	8082                	ret

00000000800011ba <scheduler>:
{
    800011ba:	715d                	addi	sp,sp,-80
    800011bc:	e486                	sd	ra,72(sp)
    800011be:	e0a2                	sd	s0,64(sp)
    800011c0:	fc26                	sd	s1,56(sp)
    800011c2:	f84a                	sd	s2,48(sp)
    800011c4:	f44e                	sd	s3,40(sp)
    800011c6:	f052                	sd	s4,32(sp)
    800011c8:	ec56                	sd	s5,24(sp)
    800011ca:	e85a                	sd	s6,16(sp)
    800011cc:	e45e                	sd	s7,8(sp)
    800011ce:	e062                	sd	s8,0(sp)
    800011d0:	0880                	addi	s0,sp,80
    800011d2:	8792                	mv	a5,tp
  int id = r_tp();
    800011d4:	2781                	sext.w	a5,a5
  c->proc = 0;
    800011d6:	00779693          	slli	a3,a5,0x7
    800011da:	00006717          	auipc	a4,0x6
    800011de:	6a670713          	addi	a4,a4,1702 # 80007880 <pid_lock>
    800011e2:	9736                	add	a4,a4,a3
    800011e4:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    800011e8:	00006b17          	auipc	s6,0x6
    800011ec:	6d0b0b13          	addi	s6,s6,1744 # 800078b8 <cpus+0x8>
    800011f0:	9b36                	add	s6,s6,a3
        p->state = RUNNING;
    800011f2:	4c11                	li	s8,4
        c->proc = p;
    800011f4:	8a3a                	mv	s4,a4
        found = 1;
    800011f6:	4b85                	li	s7,1
    800011f8:	a83d                	j	80001236 <scheduler+0x7c>
      release(&p->lock);
    800011fa:	8526                	mv	a0,s1
    800011fc:	6a6040ef          	jal	800058a2 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80001200:	16848493          	addi	s1,s1,360
    80001204:	03248563          	beq	s1,s2,8000122e <scheduler+0x74>
      acquire(&p->lock);
    80001208:	8526                	mv	a0,s1
    8000120a:	608040ef          	jal	80005812 <acquire>
      if(p->state == RUNNABLE) {
    8000120e:	4c9c                	lw	a5,24(s1)
    80001210:	ff3795e3          	bne	a5,s3,800011fa <scheduler+0x40>
        p->state = RUNNING;
    80001214:	0184ac23          	sw	s8,24(s1)
        c->proc = p;
    80001218:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    8000121c:	06048593          	addi	a1,s1,96
    80001220:	855a                	mv	a0,s6
    80001222:	5b2000ef          	jal	800017d4 <swtch>
        c->proc = 0;
    80001226:	020a3823          	sd	zero,48(s4)
        found = 1;
    8000122a:	8ade                	mv	s5,s7
    8000122c:	b7f9                	j	800011fa <scheduler+0x40>
    if(found == 0) {
    8000122e:	000a9463          	bnez	s5,80001236 <scheduler+0x7c>
      asm volatile("wfi");
    80001232:	10500073          	wfi
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001236:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000123a:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000123e:	10079073          	csrw	sstatus,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001242:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001246:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001248:	10079073          	csrw	sstatus,a5
    int found = 0;
    8000124c:	4a81                	li	s5,0
    for(p = proc; p < &proc[NPROC]; p++) {
    8000124e:	00007497          	auipc	s1,0x7
    80001252:	a6248493          	addi	s1,s1,-1438 # 80007cb0 <proc>
      if(p->state == RUNNABLE) {
    80001256:	498d                	li	s3,3
    for(p = proc; p < &proc[NPROC]; p++) {
    80001258:	0000c917          	auipc	s2,0xc
    8000125c:	45890913          	addi	s2,s2,1112 # 8000d6b0 <tickslock>
    80001260:	b765                	j	80001208 <scheduler+0x4e>

0000000080001262 <sched>:
{
    80001262:	7179                	addi	sp,sp,-48
    80001264:	f406                	sd	ra,40(sp)
    80001266:	f022                	sd	s0,32(sp)
    80001268:	ec26                	sd	s1,24(sp)
    8000126a:	e84a                	sd	s2,16(sp)
    8000126c:	e44e                	sd	s3,8(sp)
    8000126e:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001270:	aefff0ef          	jal	80000d5e <myproc>
    80001274:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001276:	52c040ef          	jal	800057a2 <holding>
    8000127a:	c92d                	beqz	a0,800012ec <sched+0x8a>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000127c:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    8000127e:	2781                	sext.w	a5,a5
    80001280:	079e                	slli	a5,a5,0x7
    80001282:	00006717          	auipc	a4,0x6
    80001286:	5fe70713          	addi	a4,a4,1534 # 80007880 <pid_lock>
    8000128a:	97ba                	add	a5,a5,a4
    8000128c:	0a87a703          	lw	a4,168(a5)
    80001290:	4785                	li	a5,1
    80001292:	06f71363          	bne	a4,a5,800012f8 <sched+0x96>
  if(p->state == RUNNING)
    80001296:	4c98                	lw	a4,24(s1)
    80001298:	4791                	li	a5,4
    8000129a:	06f70563          	beq	a4,a5,80001304 <sched+0xa2>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000129e:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800012a2:	8b89                	andi	a5,a5,2
  if(intr_get())
    800012a4:	e7b5                	bnez	a5,80001310 <sched+0xae>
  asm volatile("mv %0, tp" : "=r" (x) );
    800012a6:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    800012a8:	00006917          	auipc	s2,0x6
    800012ac:	5d890913          	addi	s2,s2,1496 # 80007880 <pid_lock>
    800012b0:	2781                	sext.w	a5,a5
    800012b2:	079e                	slli	a5,a5,0x7
    800012b4:	97ca                	add	a5,a5,s2
    800012b6:	0ac7a983          	lw	s3,172(a5)
    800012ba:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800012bc:	2781                	sext.w	a5,a5
    800012be:	079e                	slli	a5,a5,0x7
    800012c0:	00006597          	auipc	a1,0x6
    800012c4:	5f858593          	addi	a1,a1,1528 # 800078b8 <cpus+0x8>
    800012c8:	95be                	add	a1,a1,a5
    800012ca:	06048513          	addi	a0,s1,96
    800012ce:	506000ef          	jal	800017d4 <swtch>
    800012d2:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    800012d4:	2781                	sext.w	a5,a5
    800012d6:	079e                	slli	a5,a5,0x7
    800012d8:	993e                	add	s2,s2,a5
    800012da:	0b392623          	sw	s3,172(s2)
}
    800012de:	70a2                	ld	ra,40(sp)
    800012e0:	7402                	ld	s0,32(sp)
    800012e2:	64e2                	ld	s1,24(sp)
    800012e4:	6942                	ld	s2,16(sp)
    800012e6:	69a2                	ld	s3,8(sp)
    800012e8:	6145                	addi	sp,sp,48
    800012ea:	8082                	ret
    panic("sched p->lock");
    800012ec:	00006517          	auipc	a0,0x6
    800012f0:	e4c50513          	addi	a0,a0,-436 # 80007138 <etext+0x138>
    800012f4:	260040ef          	jal	80005554 <panic>
    panic("sched locks");
    800012f8:	00006517          	auipc	a0,0x6
    800012fc:	e5050513          	addi	a0,a0,-432 # 80007148 <etext+0x148>
    80001300:	254040ef          	jal	80005554 <panic>
    panic("sched RUNNING");
    80001304:	00006517          	auipc	a0,0x6
    80001308:	e5450513          	addi	a0,a0,-428 # 80007158 <etext+0x158>
    8000130c:	248040ef          	jal	80005554 <panic>
    panic("sched interruptible");
    80001310:	00006517          	auipc	a0,0x6
    80001314:	e5850513          	addi	a0,a0,-424 # 80007168 <etext+0x168>
    80001318:	23c040ef          	jal	80005554 <panic>

000000008000131c <yield>:
{
    8000131c:	1101                	addi	sp,sp,-32
    8000131e:	ec06                	sd	ra,24(sp)
    80001320:	e822                	sd	s0,16(sp)
    80001322:	e426                	sd	s1,8(sp)
    80001324:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80001326:	a39ff0ef          	jal	80000d5e <myproc>
    8000132a:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000132c:	4e6040ef          	jal	80005812 <acquire>
  p->state = RUNNABLE;
    80001330:	478d                	li	a5,3
    80001332:	cc9c                	sw	a5,24(s1)
  sched();
    80001334:	f2fff0ef          	jal	80001262 <sched>
  release(&p->lock);
    80001338:	8526                	mv	a0,s1
    8000133a:	568040ef          	jal	800058a2 <release>
}
    8000133e:	60e2                	ld	ra,24(sp)
    80001340:	6442                	ld	s0,16(sp)
    80001342:	64a2                	ld	s1,8(sp)
    80001344:	6105                	addi	sp,sp,32
    80001346:	8082                	ret

0000000080001348 <sleep>:

// Sleep on channel chan, releasing condition lock lk.
// Re-acquires lk when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80001348:	7179                	addi	sp,sp,-48
    8000134a:	f406                	sd	ra,40(sp)
    8000134c:	f022                	sd	s0,32(sp)
    8000134e:	ec26                	sd	s1,24(sp)
    80001350:	e84a                	sd	s2,16(sp)
    80001352:	e44e                	sd	s3,8(sp)
    80001354:	1800                	addi	s0,sp,48
    80001356:	89aa                	mv	s3,a0
    80001358:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000135a:	a05ff0ef          	jal	80000d5e <myproc>
    8000135e:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80001360:	4b2040ef          	jal	80005812 <acquire>
  release(lk);
    80001364:	854a                	mv	a0,s2
    80001366:	53c040ef          	jal	800058a2 <release>

  // Go to sleep.
  p->chan = chan;
    8000136a:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    8000136e:	4789                	li	a5,2
    80001370:	cc9c                	sw	a5,24(s1)

  sched();
    80001372:	ef1ff0ef          	jal	80001262 <sched>

  // Tidy up.
  p->chan = 0;
    80001376:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    8000137a:	8526                	mv	a0,s1
    8000137c:	526040ef          	jal	800058a2 <release>
  acquire(lk);
    80001380:	854a                	mv	a0,s2
    80001382:	490040ef          	jal	80005812 <acquire>
}
    80001386:	70a2                	ld	ra,40(sp)
    80001388:	7402                	ld	s0,32(sp)
    8000138a:	64e2                	ld	s1,24(sp)
    8000138c:	6942                	ld	s2,16(sp)
    8000138e:	69a2                	ld	s3,8(sp)
    80001390:	6145                	addi	sp,sp,48
    80001392:	8082                	ret

0000000080001394 <wakeup>:

// Wake up all processes sleeping on channel chan.
// Caller should hold the condition lock.
void
wakeup(void *chan)
{
    80001394:	7139                	addi	sp,sp,-64
    80001396:	fc06                	sd	ra,56(sp)
    80001398:	f822                	sd	s0,48(sp)
    8000139a:	f426                	sd	s1,40(sp)
    8000139c:	f04a                	sd	s2,32(sp)
    8000139e:	ec4e                	sd	s3,24(sp)
    800013a0:	e852                	sd	s4,16(sp)
    800013a2:	e456                	sd	s5,8(sp)
    800013a4:	0080                	addi	s0,sp,64
    800013a6:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800013a8:	00007497          	auipc	s1,0x7
    800013ac:	90848493          	addi	s1,s1,-1784 # 80007cb0 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    800013b0:	4989                	li	s3,2
        p->state = RUNNABLE;
    800013b2:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    800013b4:	0000c917          	auipc	s2,0xc
    800013b8:	2fc90913          	addi	s2,s2,764 # 8000d6b0 <tickslock>
    800013bc:	a801                	j	800013cc <wakeup+0x38>
      }
      release(&p->lock);
    800013be:	8526                	mv	a0,s1
    800013c0:	4e2040ef          	jal	800058a2 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800013c4:	16848493          	addi	s1,s1,360
    800013c8:	03248263          	beq	s1,s2,800013ec <wakeup+0x58>
    if(p != myproc()){
    800013cc:	993ff0ef          	jal	80000d5e <myproc>
    800013d0:	fe950ae3          	beq	a0,s1,800013c4 <wakeup+0x30>
      acquire(&p->lock);
    800013d4:	8526                	mv	a0,s1
    800013d6:	43c040ef          	jal	80005812 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800013da:	4c9c                	lw	a5,24(s1)
    800013dc:	ff3791e3          	bne	a5,s3,800013be <wakeup+0x2a>
    800013e0:	709c                	ld	a5,32(s1)
    800013e2:	fd479ee3          	bne	a5,s4,800013be <wakeup+0x2a>
        p->state = RUNNABLE;
    800013e6:	0154ac23          	sw	s5,24(s1)
    800013ea:	bfd1                	j	800013be <wakeup+0x2a>
    }
  }
}
    800013ec:	70e2                	ld	ra,56(sp)
    800013ee:	7442                	ld	s0,48(sp)
    800013f0:	74a2                	ld	s1,40(sp)
    800013f2:	7902                	ld	s2,32(sp)
    800013f4:	69e2                	ld	s3,24(sp)
    800013f6:	6a42                	ld	s4,16(sp)
    800013f8:	6aa2                	ld	s5,8(sp)
    800013fa:	6121                	addi	sp,sp,64
    800013fc:	8082                	ret

00000000800013fe <reparent>:
{
    800013fe:	7179                	addi	sp,sp,-48
    80001400:	f406                	sd	ra,40(sp)
    80001402:	f022                	sd	s0,32(sp)
    80001404:	ec26                	sd	s1,24(sp)
    80001406:	e84a                	sd	s2,16(sp)
    80001408:	e44e                	sd	s3,8(sp)
    8000140a:	e052                	sd	s4,0(sp)
    8000140c:	1800                	addi	s0,sp,48
    8000140e:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001410:	00007497          	auipc	s1,0x7
    80001414:	8a048493          	addi	s1,s1,-1888 # 80007cb0 <proc>
      pp->parent = initproc;
    80001418:	00006a17          	auipc	s4,0x6
    8000141c:	428a0a13          	addi	s4,s4,1064 # 80007840 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001420:	0000c997          	auipc	s3,0xc
    80001424:	29098993          	addi	s3,s3,656 # 8000d6b0 <tickslock>
    80001428:	a029                	j	80001432 <reparent+0x34>
    8000142a:	16848493          	addi	s1,s1,360
    8000142e:	01348b63          	beq	s1,s3,80001444 <reparent+0x46>
    if(pp->parent == p){
    80001432:	7c9c                	ld	a5,56(s1)
    80001434:	ff279be3          	bne	a5,s2,8000142a <reparent+0x2c>
      pp->parent = initproc;
    80001438:	000a3503          	ld	a0,0(s4)
    8000143c:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    8000143e:	f57ff0ef          	jal	80001394 <wakeup>
    80001442:	b7e5                	j	8000142a <reparent+0x2c>
}
    80001444:	70a2                	ld	ra,40(sp)
    80001446:	7402                	ld	s0,32(sp)
    80001448:	64e2                	ld	s1,24(sp)
    8000144a:	6942                	ld	s2,16(sp)
    8000144c:	69a2                	ld	s3,8(sp)
    8000144e:	6a02                	ld	s4,0(sp)
    80001450:	6145                	addi	sp,sp,48
    80001452:	8082                	ret

0000000080001454 <kexit>:
{
    80001454:	7179                	addi	sp,sp,-48
    80001456:	f406                	sd	ra,40(sp)
    80001458:	f022                	sd	s0,32(sp)
    8000145a:	ec26                	sd	s1,24(sp)
    8000145c:	e84a                	sd	s2,16(sp)
    8000145e:	e44e                	sd	s3,8(sp)
    80001460:	e052                	sd	s4,0(sp)
    80001462:	1800                	addi	s0,sp,48
    80001464:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80001466:	8f9ff0ef          	jal	80000d5e <myproc>
    8000146a:	89aa                	mv	s3,a0
  if(p == initproc)
    8000146c:	00006797          	auipc	a5,0x6
    80001470:	3d47b783          	ld	a5,980(a5) # 80007840 <initproc>
    80001474:	0d050493          	addi	s1,a0,208
    80001478:	15050913          	addi	s2,a0,336
    8000147c:	00a79b63          	bne	a5,a0,80001492 <kexit+0x3e>
    panic("init exiting");
    80001480:	00006517          	auipc	a0,0x6
    80001484:	d0050513          	addi	a0,a0,-768 # 80007180 <etext+0x180>
    80001488:	0cc040ef          	jal	80005554 <panic>
  for(int fd = 0; fd < NOFILE; fd++){
    8000148c:	04a1                	addi	s1,s1,8
    8000148e:	01248963          	beq	s1,s2,800014a0 <kexit+0x4c>
    if(p->ofile[fd]){
    80001492:	6088                	ld	a0,0(s1)
    80001494:	dd65                	beqz	a0,8000148c <kexit+0x38>
      fileclose(f);
    80001496:	7a9010ef          	jal	8000343e <fileclose>
      p->ofile[fd] = 0;
    8000149a:	0004b023          	sd	zero,0(s1)
    8000149e:	b7fd                	j	8000148c <kexit+0x38>
  begin_op();
    800014a0:	37f010ef          	jal	8000301e <begin_op>
  iput(p->cwd);
    800014a4:	1509b503          	ld	a0,336(s3)
    800014a8:	2e2010ef          	jal	8000278a <iput>
  end_op();
    800014ac:	3e3010ef          	jal	8000308e <end_op>
  p->cwd = 0;
    800014b0:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    800014b4:	00006517          	auipc	a0,0x6
    800014b8:	3e450513          	addi	a0,a0,996 # 80007898 <wait_lock>
    800014bc:	356040ef          	jal	80005812 <acquire>
  reparent(p);
    800014c0:	854e                	mv	a0,s3
    800014c2:	f3dff0ef          	jal	800013fe <reparent>
  wakeup(p->parent);
    800014c6:	0389b503          	ld	a0,56(s3)
    800014ca:	ecbff0ef          	jal	80001394 <wakeup>
  acquire(&p->lock);
    800014ce:	854e                	mv	a0,s3
    800014d0:	342040ef          	jal	80005812 <acquire>
  p->xstate = status;
    800014d4:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    800014d8:	4795                	li	a5,5
    800014da:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    800014de:	00006517          	auipc	a0,0x6
    800014e2:	3ba50513          	addi	a0,a0,954 # 80007898 <wait_lock>
    800014e6:	3bc040ef          	jal	800058a2 <release>
  sched();
    800014ea:	d79ff0ef          	jal	80001262 <sched>
  panic("zombie exit");
    800014ee:	00006517          	auipc	a0,0x6
    800014f2:	ca250513          	addi	a0,a0,-862 # 80007190 <etext+0x190>
    800014f6:	05e040ef          	jal	80005554 <panic>

00000000800014fa <kkill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kkill(int pid)
{
    800014fa:	7179                	addi	sp,sp,-48
    800014fc:	f406                	sd	ra,40(sp)
    800014fe:	f022                	sd	s0,32(sp)
    80001500:	ec26                	sd	s1,24(sp)
    80001502:	e84a                	sd	s2,16(sp)
    80001504:	e44e                	sd	s3,8(sp)
    80001506:	1800                	addi	s0,sp,48
    80001508:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    8000150a:	00006497          	auipc	s1,0x6
    8000150e:	7a648493          	addi	s1,s1,1958 # 80007cb0 <proc>
    80001512:	0000c997          	auipc	s3,0xc
    80001516:	19e98993          	addi	s3,s3,414 # 8000d6b0 <tickslock>
    acquire(&p->lock);
    8000151a:	8526                	mv	a0,s1
    8000151c:	2f6040ef          	jal	80005812 <acquire>
    if(p->pid == pid){
    80001520:	589c                	lw	a5,48(s1)
    80001522:	01278b63          	beq	a5,s2,80001538 <kkill+0x3e>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80001526:	8526                	mv	a0,s1
    80001528:	37a040ef          	jal	800058a2 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    8000152c:	16848493          	addi	s1,s1,360
    80001530:	ff3495e3          	bne	s1,s3,8000151a <kkill+0x20>
  }
  return -1;
    80001534:	557d                	li	a0,-1
    80001536:	a819                	j	8000154c <kkill+0x52>
      p->killed = 1;
    80001538:	4785                	li	a5,1
    8000153a:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    8000153c:	4c98                	lw	a4,24(s1)
    8000153e:	4789                	li	a5,2
    80001540:	00f70d63          	beq	a4,a5,8000155a <kkill+0x60>
      release(&p->lock);
    80001544:	8526                	mv	a0,s1
    80001546:	35c040ef          	jal	800058a2 <release>
      return 0;
    8000154a:	4501                	li	a0,0
}
    8000154c:	70a2                	ld	ra,40(sp)
    8000154e:	7402                	ld	s0,32(sp)
    80001550:	64e2                	ld	s1,24(sp)
    80001552:	6942                	ld	s2,16(sp)
    80001554:	69a2                	ld	s3,8(sp)
    80001556:	6145                	addi	sp,sp,48
    80001558:	8082                	ret
        p->state = RUNNABLE;
    8000155a:	478d                	li	a5,3
    8000155c:	cc9c                	sw	a5,24(s1)
    8000155e:	b7dd                	j	80001544 <kkill+0x4a>

0000000080001560 <setkilled>:

void
setkilled(struct proc *p)
{
    80001560:	1101                	addi	sp,sp,-32
    80001562:	ec06                	sd	ra,24(sp)
    80001564:	e822                	sd	s0,16(sp)
    80001566:	e426                	sd	s1,8(sp)
    80001568:	1000                	addi	s0,sp,32
    8000156a:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000156c:	2a6040ef          	jal	80005812 <acquire>
  p->killed = 1;
    80001570:	4785                	li	a5,1
    80001572:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    80001574:	8526                	mv	a0,s1
    80001576:	32c040ef          	jal	800058a2 <release>
}
    8000157a:	60e2                	ld	ra,24(sp)
    8000157c:	6442                	ld	s0,16(sp)
    8000157e:	64a2                	ld	s1,8(sp)
    80001580:	6105                	addi	sp,sp,32
    80001582:	8082                	ret

0000000080001584 <killed>:

int
killed(struct proc *p)
{
    80001584:	1101                	addi	sp,sp,-32
    80001586:	ec06                	sd	ra,24(sp)
    80001588:	e822                	sd	s0,16(sp)
    8000158a:	e426                	sd	s1,8(sp)
    8000158c:	e04a                	sd	s2,0(sp)
    8000158e:	1000                	addi	s0,sp,32
    80001590:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    80001592:	280040ef          	jal	80005812 <acquire>
  k = p->killed;
    80001596:	549c                	lw	a5,40(s1)
    80001598:	893e                	mv	s2,a5
  release(&p->lock);
    8000159a:	8526                	mv	a0,s1
    8000159c:	306040ef          	jal	800058a2 <release>
  return k;
}
    800015a0:	854a                	mv	a0,s2
    800015a2:	60e2                	ld	ra,24(sp)
    800015a4:	6442                	ld	s0,16(sp)
    800015a6:	64a2                	ld	s1,8(sp)
    800015a8:	6902                	ld	s2,0(sp)
    800015aa:	6105                	addi	sp,sp,32
    800015ac:	8082                	ret

00000000800015ae <kwait>:
{
    800015ae:	715d                	addi	sp,sp,-80
    800015b0:	e486                	sd	ra,72(sp)
    800015b2:	e0a2                	sd	s0,64(sp)
    800015b4:	fc26                	sd	s1,56(sp)
    800015b6:	f84a                	sd	s2,48(sp)
    800015b8:	f44e                	sd	s3,40(sp)
    800015ba:	f052                	sd	s4,32(sp)
    800015bc:	ec56                	sd	s5,24(sp)
    800015be:	e85a                	sd	s6,16(sp)
    800015c0:	e45e                	sd	s7,8(sp)
    800015c2:	0880                	addi	s0,sp,80
    800015c4:	8baa                	mv	s7,a0
  struct proc *p = myproc();
    800015c6:	f98ff0ef          	jal	80000d5e <myproc>
    800015ca:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800015cc:	00006517          	auipc	a0,0x6
    800015d0:	2cc50513          	addi	a0,a0,716 # 80007898 <wait_lock>
    800015d4:	23e040ef          	jal	80005812 <acquire>
        if(pp->state == ZOMBIE){
    800015d8:	4a15                	li	s4,5
        havekids = 1;
    800015da:	4a85                	li	s5,1
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800015dc:	0000c997          	auipc	s3,0xc
    800015e0:	0d498993          	addi	s3,s3,212 # 8000d6b0 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800015e4:	00006b17          	auipc	s6,0x6
    800015e8:	2b4b0b13          	addi	s6,s6,692 # 80007898 <wait_lock>
    800015ec:	a861                	j	80001684 <kwait+0xd6>
          pid = pp->pid;
    800015ee:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    800015f2:	000b8c63          	beqz	s7,8000160a <kwait+0x5c>
    800015f6:	4691                	li	a3,4
    800015f8:	02c48613          	addi	a2,s1,44
    800015fc:	85de                	mv	a1,s7
    800015fe:	05093503          	ld	a0,80(s2)
    80001602:	c94ff0ef          	jal	80000a96 <copyout>
    80001606:	02054a63          	bltz	a0,8000163a <kwait+0x8c>
          freeproc(pp);
    8000160a:	8526                	mv	a0,s1
    8000160c:	925ff0ef          	jal	80000f30 <freeproc>
          release(&pp->lock);
    80001610:	8526                	mv	a0,s1
    80001612:	290040ef          	jal	800058a2 <release>
          release(&wait_lock);
    80001616:	00006517          	auipc	a0,0x6
    8000161a:	28250513          	addi	a0,a0,642 # 80007898 <wait_lock>
    8000161e:	284040ef          	jal	800058a2 <release>
}
    80001622:	854e                	mv	a0,s3
    80001624:	60a6                	ld	ra,72(sp)
    80001626:	6406                	ld	s0,64(sp)
    80001628:	74e2                	ld	s1,56(sp)
    8000162a:	7942                	ld	s2,48(sp)
    8000162c:	79a2                	ld	s3,40(sp)
    8000162e:	7a02                	ld	s4,32(sp)
    80001630:	6ae2                	ld	s5,24(sp)
    80001632:	6b42                	ld	s6,16(sp)
    80001634:	6ba2                	ld	s7,8(sp)
    80001636:	6161                	addi	sp,sp,80
    80001638:	8082                	ret
            release(&pp->lock);
    8000163a:	8526                	mv	a0,s1
    8000163c:	266040ef          	jal	800058a2 <release>
            release(&wait_lock);
    80001640:	00006517          	auipc	a0,0x6
    80001644:	25850513          	addi	a0,a0,600 # 80007898 <wait_lock>
    80001648:	25a040ef          	jal	800058a2 <release>
            return -1;
    8000164c:	a881                	j	8000169c <kwait+0xee>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000164e:	16848493          	addi	s1,s1,360
    80001652:	03348063          	beq	s1,s3,80001672 <kwait+0xc4>
      if(pp->parent == p){
    80001656:	7c9c                	ld	a5,56(s1)
    80001658:	ff279be3          	bne	a5,s2,8000164e <kwait+0xa0>
        acquire(&pp->lock);
    8000165c:	8526                	mv	a0,s1
    8000165e:	1b4040ef          	jal	80005812 <acquire>
        if(pp->state == ZOMBIE){
    80001662:	4c9c                	lw	a5,24(s1)
    80001664:	f94785e3          	beq	a5,s4,800015ee <kwait+0x40>
        release(&pp->lock);
    80001668:	8526                	mv	a0,s1
    8000166a:	238040ef          	jal	800058a2 <release>
        havekids = 1;
    8000166e:	8756                	mv	a4,s5
    80001670:	bff9                	j	8000164e <kwait+0xa0>
    if(!havekids || killed(p)){
    80001672:	cf19                	beqz	a4,80001690 <kwait+0xe2>
    80001674:	854a                	mv	a0,s2
    80001676:	f0fff0ef          	jal	80001584 <killed>
    8000167a:	e919                	bnez	a0,80001690 <kwait+0xe2>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000167c:	85da                	mv	a1,s6
    8000167e:	854a                	mv	a0,s2
    80001680:	cc9ff0ef          	jal	80001348 <sleep>
    havekids = 0;
    80001684:	4701                	li	a4,0
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001686:	00006497          	auipc	s1,0x6
    8000168a:	62a48493          	addi	s1,s1,1578 # 80007cb0 <proc>
    8000168e:	b7e1                	j	80001656 <kwait+0xa8>
      release(&wait_lock);
    80001690:	00006517          	auipc	a0,0x6
    80001694:	20850513          	addi	a0,a0,520 # 80007898 <wait_lock>
    80001698:	20a040ef          	jal	800058a2 <release>
            return -1;
    8000169c:	59fd                	li	s3,-1
    8000169e:	b751                	j	80001622 <kwait+0x74>

00000000800016a0 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    800016a0:	7179                	addi	sp,sp,-48
    800016a2:	f406                	sd	ra,40(sp)
    800016a4:	f022                	sd	s0,32(sp)
    800016a6:	ec26                	sd	s1,24(sp)
    800016a8:	e84a                	sd	s2,16(sp)
    800016aa:	e44e                	sd	s3,8(sp)
    800016ac:	e052                	sd	s4,0(sp)
    800016ae:	1800                	addi	s0,sp,48
    800016b0:	84aa                	mv	s1,a0
    800016b2:	8a2e                	mv	s4,a1
    800016b4:	89b2                	mv	s3,a2
    800016b6:	8936                	mv	s2,a3
  struct proc *p = myproc();
    800016b8:	ea6ff0ef          	jal	80000d5e <myproc>
  if(user_dst){
    800016bc:	cc99                	beqz	s1,800016da <either_copyout+0x3a>
    return copyout(p->pagetable, dst, src, len);
    800016be:	86ca                	mv	a3,s2
    800016c0:	864e                	mv	a2,s3
    800016c2:	85d2                	mv	a1,s4
    800016c4:	6928                	ld	a0,80(a0)
    800016c6:	bd0ff0ef          	jal	80000a96 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800016ca:	70a2                	ld	ra,40(sp)
    800016cc:	7402                	ld	s0,32(sp)
    800016ce:	64e2                	ld	s1,24(sp)
    800016d0:	6942                	ld	s2,16(sp)
    800016d2:	69a2                	ld	s3,8(sp)
    800016d4:	6a02                	ld	s4,0(sp)
    800016d6:	6145                	addi	sp,sp,48
    800016d8:	8082                	ret
    memmove((char *)dst, src, len);
    800016da:	0009061b          	sext.w	a2,s2
    800016de:	85ce                	mv	a1,s3
    800016e0:	8552                	mv	a0,s4
    800016e2:	ad9fe0ef          	jal	800001ba <memmove>
    return 0;
    800016e6:	8526                	mv	a0,s1
    800016e8:	b7cd                	j	800016ca <either_copyout+0x2a>

00000000800016ea <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800016ea:	7179                	addi	sp,sp,-48
    800016ec:	f406                	sd	ra,40(sp)
    800016ee:	f022                	sd	s0,32(sp)
    800016f0:	ec26                	sd	s1,24(sp)
    800016f2:	e84a                	sd	s2,16(sp)
    800016f4:	e44e                	sd	s3,8(sp)
    800016f6:	e052                	sd	s4,0(sp)
    800016f8:	1800                	addi	s0,sp,48
    800016fa:	8a2a                	mv	s4,a0
    800016fc:	84ae                	mv	s1,a1
    800016fe:	89b2                	mv	s3,a2
    80001700:	8936                	mv	s2,a3
  struct proc *p = myproc();
    80001702:	e5cff0ef          	jal	80000d5e <myproc>
  if(user_src){
    80001706:	cc99                	beqz	s1,80001724 <either_copyin+0x3a>
    return copyin(p->pagetable, dst, src, len);
    80001708:	86ca                	mv	a3,s2
    8000170a:	864e                	mv	a2,s3
    8000170c:	85d2                	mv	a1,s4
    8000170e:	6928                	ld	a0,80(a0)
    80001710:	c3eff0ef          	jal	80000b4e <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001714:	70a2                	ld	ra,40(sp)
    80001716:	7402                	ld	s0,32(sp)
    80001718:	64e2                	ld	s1,24(sp)
    8000171a:	6942                	ld	s2,16(sp)
    8000171c:	69a2                	ld	s3,8(sp)
    8000171e:	6a02                	ld	s4,0(sp)
    80001720:	6145                	addi	sp,sp,48
    80001722:	8082                	ret
    memmove(dst, (char*)src, len);
    80001724:	0009061b          	sext.w	a2,s2
    80001728:	85ce                	mv	a1,s3
    8000172a:	8552                	mv	a0,s4
    8000172c:	a8ffe0ef          	jal	800001ba <memmove>
    return 0;
    80001730:	8526                	mv	a0,s1
    80001732:	b7cd                	j	80001714 <either_copyin+0x2a>

0000000080001734 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001734:	715d                	addi	sp,sp,-80
    80001736:	e486                	sd	ra,72(sp)
    80001738:	e0a2                	sd	s0,64(sp)
    8000173a:	fc26                	sd	s1,56(sp)
    8000173c:	f84a                	sd	s2,48(sp)
    8000173e:	f44e                	sd	s3,40(sp)
    80001740:	f052                	sd	s4,32(sp)
    80001742:	ec56                	sd	s5,24(sp)
    80001744:	e85a                	sd	s6,16(sp)
    80001746:	e45e                	sd	s7,8(sp)
    80001748:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    8000174a:	00006517          	auipc	a0,0x6
    8000174e:	8ce50513          	addi	a0,a0,-1842 # 80007018 <etext+0x18>
    80001752:	2cb030ef          	jal	8000521c <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001756:	00006497          	auipc	s1,0x6
    8000175a:	6b248493          	addi	s1,s1,1714 # 80007e08 <proc+0x158>
    8000175e:	0000c917          	auipc	s2,0xc
    80001762:	0aa90913          	addi	s2,s2,170 # 8000d808 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001766:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001768:	00006a97          	auipc	s5,0x6
    8000176c:	a38a8a93          	addi	s5,s5,-1480 # 800071a0 <etext+0x1a0>
    printf("%d %s %s", p->pid, state, p->name);
    80001770:	00006a17          	auipc	s4,0x6
    80001774:	a38a0a13          	addi	s4,s4,-1480 # 800071a8 <etext+0x1a8>
    printf("\n");
    80001778:	00006997          	auipc	s3,0x6
    8000177c:	8a098993          	addi	s3,s3,-1888 # 80007018 <etext+0x18>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001780:	00006b97          	auipc	s7,0x6
    80001784:	f90b8b93          	addi	s7,s7,-112 # 80007710 <states.0>
    80001788:	a829                	j	800017a2 <procdump+0x6e>
    printf("%d %s %s", p->pid, state, p->name);
    8000178a:	ed86a583          	lw	a1,-296(a3)
    8000178e:	8552                	mv	a0,s4
    80001790:	28d030ef          	jal	8000521c <printf>
    printf("\n");
    80001794:	854e                	mv	a0,s3
    80001796:	287030ef          	jal	8000521c <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    8000179a:	16848493          	addi	s1,s1,360
    8000179e:	03248063          	beq	s1,s2,800017be <procdump+0x8a>
    if(p->state == UNUSED)
    800017a2:	86a6                	mv	a3,s1
    800017a4:	ec04a783          	lw	a5,-320(s1)
    800017a8:	dbed                	beqz	a5,8000179a <procdump+0x66>
      state = "???";
    800017aa:	8656                	mv	a2,s5
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800017ac:	fcfb6fe3          	bltu	s6,a5,8000178a <procdump+0x56>
    800017b0:	02079713          	slli	a4,a5,0x20
    800017b4:	01d75793          	srli	a5,a4,0x1d
    800017b8:	97de                	add	a5,a5,s7
    800017ba:	6390                	ld	a2,0(a5)
      state = states[p->state];
    800017bc:	b7f9                	j	8000178a <procdump+0x56>
  }
}
    800017be:	60a6                	ld	ra,72(sp)
    800017c0:	6406                	ld	s0,64(sp)
    800017c2:	74e2                	ld	s1,56(sp)
    800017c4:	7942                	ld	s2,48(sp)
    800017c6:	79a2                	ld	s3,40(sp)
    800017c8:	7a02                	ld	s4,32(sp)
    800017ca:	6ae2                	ld	s5,24(sp)
    800017cc:	6b42                	ld	s6,16(sp)
    800017ce:	6ba2                	ld	s7,8(sp)
    800017d0:	6161                	addi	sp,sp,80
    800017d2:	8082                	ret

00000000800017d4 <swtch>:
# Save current registers in old. Load from new.	


.globl swtch
swtch:
        sd ra, 0(a0)
    800017d4:	00153023          	sd	ra,0(a0)
        sd sp, 8(a0)
    800017d8:	00253423          	sd	sp,8(a0)
        sd s0, 16(a0)
    800017dc:	e900                	sd	s0,16(a0)
        sd s1, 24(a0)
    800017de:	ed04                	sd	s1,24(a0)
        sd s2, 32(a0)
    800017e0:	03253023          	sd	s2,32(a0)
        sd s3, 40(a0)
    800017e4:	03353423          	sd	s3,40(a0)
        sd s4, 48(a0)
    800017e8:	03453823          	sd	s4,48(a0)
        sd s5, 56(a0)
    800017ec:	03553c23          	sd	s5,56(a0)
        sd s6, 64(a0)
    800017f0:	05653023          	sd	s6,64(a0)
        sd s7, 72(a0)
    800017f4:	05753423          	sd	s7,72(a0)
        sd s8, 80(a0)
    800017f8:	05853823          	sd	s8,80(a0)
        sd s9, 88(a0)
    800017fc:	05953c23          	sd	s9,88(a0)
        sd s10, 96(a0)
    80001800:	07a53023          	sd	s10,96(a0)
        sd s11, 104(a0)
    80001804:	07b53423          	sd	s11,104(a0)

        ld ra, 0(a1)
    80001808:	0005b083          	ld	ra,0(a1)
        ld sp, 8(a1)
    8000180c:	0085b103          	ld	sp,8(a1)
        ld s0, 16(a1)
    80001810:	6980                	ld	s0,16(a1)
        ld s1, 24(a1)
    80001812:	6d84                	ld	s1,24(a1)
        ld s2, 32(a1)
    80001814:	0205b903          	ld	s2,32(a1)
        ld s3, 40(a1)
    80001818:	0285b983          	ld	s3,40(a1)
        ld s4, 48(a1)
    8000181c:	0305ba03          	ld	s4,48(a1)
        ld s5, 56(a1)
    80001820:	0385ba83          	ld	s5,56(a1)
        ld s6, 64(a1)
    80001824:	0405bb03          	ld	s6,64(a1)
        ld s7, 72(a1)
    80001828:	0485bb83          	ld	s7,72(a1)
        ld s8, 80(a1)
    8000182c:	0505bc03          	ld	s8,80(a1)
        ld s9, 88(a1)
    80001830:	0585bc83          	ld	s9,88(a1)
        ld s10, 96(a1)
    80001834:	0605bd03          	ld	s10,96(a1)
        ld s11, 104(a1)
    80001838:	0685bd83          	ld	s11,104(a1)
        
        ret
    8000183c:	8082                	ret

000000008000183e <trapinit>:

extern int devintr();

void
trapinit(void)
{
    8000183e:	1141                	addi	sp,sp,-16
    80001840:	e406                	sd	ra,8(sp)
    80001842:	e022                	sd	s0,0(sp)
    80001844:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001846:	00006597          	auipc	a1,0x6
    8000184a:	9a258593          	addi	a1,a1,-1630 # 800071e8 <etext+0x1e8>
    8000184e:	0000c517          	auipc	a0,0xc
    80001852:	e6250513          	addi	a0,a0,-414 # 8000d6b0 <tickslock>
    80001856:	733030ef          	jal	80005788 <initlock>
}
    8000185a:	60a2                	ld	ra,8(sp)
    8000185c:	6402                	ld	s0,0(sp)
    8000185e:	0141                	addi	sp,sp,16
    80001860:	8082                	ret

0000000080001862 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001862:	1141                	addi	sp,sp,-16
    80001864:	e406                	sd	ra,8(sp)
    80001866:	e022                	sd	s0,0(sp)
    80001868:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    8000186a:	00003797          	auipc	a5,0x3
    8000186e:	ef678793          	addi	a5,a5,-266 # 80004760 <kernelvec>
    80001872:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001876:	60a2                	ld	ra,8(sp)
    80001878:	6402                	ld	s0,0(sp)
    8000187a:	0141                	addi	sp,sp,16
    8000187c:	8082                	ret

000000008000187e <prepare_return>:
//
// set up trapframe and control registers for a return to user space
//
void
prepare_return(void)
{
    8000187e:	1141                	addi	sp,sp,-16
    80001880:	e406                	sd	ra,8(sp)
    80001882:	e022                	sd	s0,0(sp)
    80001884:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001886:	cd8ff0ef          	jal	80000d5e <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000188a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    8000188e:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001890:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(). because a trap from kernel
  // code to usertrap would be a disaster, turn off interrupts.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80001894:	04000737          	lui	a4,0x4000
    80001898:	177d                	addi	a4,a4,-1 # 3ffffff <_entry-0x7c000001>
    8000189a:	0732                	slli	a4,a4,0xc
    8000189c:	00004797          	auipc	a5,0x4
    800018a0:	76478793          	addi	a5,a5,1892 # 80006000 <_trampoline>
    800018a4:	00004697          	auipc	a3,0x4
    800018a8:	75c68693          	addi	a3,a3,1884 # 80006000 <_trampoline>
    800018ac:	8f95                	sub	a5,a5,a3
    800018ae:	97ba                	add	a5,a5,a4
  asm volatile("csrw stvec, %0" : : "r" (x));
    800018b0:	10579073          	csrw	stvec,a5
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    800018b4:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    800018b6:	18002773          	csrr	a4,satp
    800018ba:	e398                	sd	a4,0(a5)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    800018bc:	6d38                	ld	a4,88(a0)
    800018be:	613c                	ld	a5,64(a0)
    800018c0:	6685                	lui	a3,0x1
    800018c2:	97b6                	add	a5,a5,a3
    800018c4:	e71c                	sd	a5,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    800018c6:	6d3c                	ld	a5,88(a0)
    800018c8:	00000717          	auipc	a4,0x0
    800018cc:	0f470713          	addi	a4,a4,244 # 800019bc <usertrap>
    800018d0:	eb98                	sd	a4,16(a5)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    800018d2:	6d3c                	ld	a5,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    800018d4:	8712                	mv	a4,tp
    800018d6:	f398                	sd	a4,32(a5)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800018d8:	100027f3          	csrr	a5,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800018dc:	eff7f793          	andi	a5,a5,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800018e0:	0207e793          	ori	a5,a5,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800018e4:	10079073          	csrw	sstatus,a5
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    800018e8:	6d3c                	ld	a5,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    800018ea:	6f9c                	ld	a5,24(a5)
    800018ec:	14179073          	csrw	sepc,a5
}
    800018f0:	60a2                	ld	ra,8(sp)
    800018f2:	6402                	ld	s0,0(sp)
    800018f4:	0141                	addi	sp,sp,16
    800018f6:	8082                	ret

00000000800018f8 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    800018f8:	1141                	addi	sp,sp,-16
    800018fa:	e406                	sd	ra,8(sp)
    800018fc:	e022                	sd	s0,0(sp)
    800018fe:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80001900:	c2aff0ef          	jal	80000d2a <cpuid>
    80001904:	cd11                	beqz	a0,80001920 <clockintr+0x28>
  asm volatile("csrr %0, time" : "=r" (x) );
    80001906:	c01027f3          	rdtime	a5
  }

  // ask for the next timer interrupt. this also clears
  // the interrupt request. 1000000 is about a tenth
  // of a second.
  w_stimecmp(r_time() + 1000000);
    8000190a:	000f4737          	lui	a4,0xf4
    8000190e:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    80001912:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    80001914:	14d79073          	csrw	stimecmp,a5
}
    80001918:	60a2                	ld	ra,8(sp)
    8000191a:	6402                	ld	s0,0(sp)
    8000191c:	0141                	addi	sp,sp,16
    8000191e:	8082                	ret
    acquire(&tickslock);
    80001920:	0000c517          	auipc	a0,0xc
    80001924:	d9050513          	addi	a0,a0,-624 # 8000d6b0 <tickslock>
    80001928:	6eb030ef          	jal	80005812 <acquire>
    ticks++;
    8000192c:	00006717          	auipc	a4,0x6
    80001930:	f1c70713          	addi	a4,a4,-228 # 80007848 <ticks>
    80001934:	431c                	lw	a5,0(a4)
    80001936:	2785                	addiw	a5,a5,1
    80001938:	c31c                	sw	a5,0(a4)
    wakeup(&ticks);
    8000193a:	853a                	mv	a0,a4
    8000193c:	a59ff0ef          	jal	80001394 <wakeup>
    release(&tickslock);
    80001940:	0000c517          	auipc	a0,0xc
    80001944:	d7050513          	addi	a0,a0,-656 # 8000d6b0 <tickslock>
    80001948:	75b030ef          	jal	800058a2 <release>
    8000194c:	bf6d                	j	80001906 <clockintr+0xe>

000000008000194e <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    8000194e:	1101                	addi	sp,sp,-32
    80001950:	ec06                	sd	ra,24(sp)
    80001952:	e822                	sd	s0,16(sp)
    80001954:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001956:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if(scause == 0x8000000000000009L){
    8000195a:	57fd                	li	a5,-1
    8000195c:	17fe                	slli	a5,a5,0x3f
    8000195e:	07a5                	addi	a5,a5,9
    80001960:	00f70c63          	beq	a4,a5,80001978 <devintr+0x2a>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000005L){
    80001964:	57fd                	li	a5,-1
    80001966:	17fe                	slli	a5,a5,0x3f
    80001968:	0795                	addi	a5,a5,5
    // timer interrupt.
    clockintr();
    return 2;
  } else {
    return 0;
    8000196a:	4501                	li	a0,0
  } else if(scause == 0x8000000000000005L){
    8000196c:	04f70463          	beq	a4,a5,800019b4 <devintr+0x66>
  }
}
    80001970:	60e2                	ld	ra,24(sp)
    80001972:	6442                	ld	s0,16(sp)
    80001974:	6105                	addi	sp,sp,32
    80001976:	8082                	ret
    80001978:	e426                	sd	s1,8(sp)
    int irq = plic_claim();
    8000197a:	693020ef          	jal	8000480c <plic_claim>
    8000197e:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001980:	47a9                	li	a5,10
    80001982:	02f50363          	beq	a0,a5,800019a8 <devintr+0x5a>
    } else if(irq == VIRTIO0_IRQ){
    80001986:	4785                	li	a5,1
    80001988:	02f50363          	beq	a0,a5,800019ae <devintr+0x60>
    } else if(irq){
    8000198c:	c919                	beqz	a0,800019a2 <devintr+0x54>
      printf("unexpected interrupt irq=%d\n", irq);
    8000198e:	85aa                	mv	a1,a0
    80001990:	00006517          	auipc	a0,0x6
    80001994:	86050513          	addi	a0,a0,-1952 # 800071f0 <etext+0x1f0>
    80001998:	085030ef          	jal	8000521c <printf>
      plic_complete(irq);
    8000199c:	8526                	mv	a0,s1
    8000199e:	68f020ef          	jal	8000482c <plic_complete>
    return 1;
    800019a2:	4505                	li	a0,1
    800019a4:	64a2                	ld	s1,8(sp)
    800019a6:	b7e9                	j	80001970 <devintr+0x22>
      uartintr();
    800019a8:	579030ef          	jal	80005720 <uartintr>
    if(irq)
    800019ac:	bfc5                	j	8000199c <devintr+0x4e>
      virtio_disk_intr();
    800019ae:	2e2030ef          	jal	80004c90 <virtio_disk_intr>
    if(irq)
    800019b2:	b7ed                	j	8000199c <devintr+0x4e>
    clockintr();
    800019b4:	f45ff0ef          	jal	800018f8 <clockintr>
    return 2;
    800019b8:	4509                	li	a0,2
    800019ba:	bf5d                	j	80001970 <devintr+0x22>

00000000800019bc <usertrap>:
{
    800019bc:	1101                	addi	sp,sp,-32
    800019be:	ec06                	sd	ra,24(sp)
    800019c0:	e822                	sd	s0,16(sp)
    800019c2:	e426                	sd	s1,8(sp)
    800019c4:	e04a                	sd	s2,0(sp)
    800019c6:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800019c8:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    800019cc:	1007f793          	andi	a5,a5,256
    800019d0:	eba5                	bnez	a5,80001a40 <usertrap+0x84>
  asm volatile("csrw stvec, %0" : : "r" (x));
    800019d2:	00003797          	auipc	a5,0x3
    800019d6:	d8e78793          	addi	a5,a5,-626 # 80004760 <kernelvec>
    800019da:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    800019de:	b80ff0ef          	jal	80000d5e <myproc>
    800019e2:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    800019e4:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800019e6:	14102773          	csrr	a4,sepc
    800019ea:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    800019ec:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    800019f0:	47a1                	li	a5,8
    800019f2:	04f70d63          	beq	a4,a5,80001a4c <usertrap+0x90>
  } else if((which_dev = devintr()) != 0){
    800019f6:	f59ff0ef          	jal	8000194e <devintr>
    800019fa:	892a                	mv	s2,a0
    800019fc:	e945                	bnez	a0,80001aac <usertrap+0xf0>
    800019fe:	14202773          	csrr	a4,scause
  } else if((r_scause() == 15 || r_scause() == 13) &&
    80001a02:	47bd                	li	a5,15
    80001a04:	08f70863          	beq	a4,a5,80001a94 <usertrap+0xd8>
    80001a08:	14202773          	csrr	a4,scause
    80001a0c:	47b5                	li	a5,13
    80001a0e:	08f70363          	beq	a4,a5,80001a94 <usertrap+0xd8>
    80001a12:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause 0x%lx pid=%d\n", r_scause(), p->pid);
    80001a16:	5890                	lw	a2,48(s1)
    80001a18:	00006517          	auipc	a0,0x6
    80001a1c:	81850513          	addi	a0,a0,-2024 # 80007230 <etext+0x230>
    80001a20:	7fc030ef          	jal	8000521c <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001a24:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001a28:	14302673          	csrr	a2,stval
    printf("            sepc=0x%lx stval=0x%lx\n", r_sepc(), r_stval());
    80001a2c:	00006517          	auipc	a0,0x6
    80001a30:	83450513          	addi	a0,a0,-1996 # 80007260 <etext+0x260>
    80001a34:	7e8030ef          	jal	8000521c <printf>
    setkilled(p);
    80001a38:	8526                	mv	a0,s1
    80001a3a:	b27ff0ef          	jal	80001560 <setkilled>
    80001a3e:	a035                	j	80001a6a <usertrap+0xae>
    panic("usertrap: not from user mode");
    80001a40:	00005517          	auipc	a0,0x5
    80001a44:	7d050513          	addi	a0,a0,2000 # 80007210 <etext+0x210>
    80001a48:	30d030ef          	jal	80005554 <panic>
    if(killed(p))
    80001a4c:	b39ff0ef          	jal	80001584 <killed>
    80001a50:	ed15                	bnez	a0,80001a8c <usertrap+0xd0>
    p->trapframe->epc += 4;
    80001a52:	6cb8                	ld	a4,88(s1)
    80001a54:	6f1c                	ld	a5,24(a4)
    80001a56:	0791                	addi	a5,a5,4
    80001a58:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001a5a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001a5e:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001a62:	10079073          	csrw	sstatus,a5
    syscall();
    80001a66:	23c000ef          	jal	80001ca2 <syscall>
  if(killed(p))
    80001a6a:	8526                	mv	a0,s1
    80001a6c:	b19ff0ef          	jal	80001584 <killed>
    80001a70:	e139                	bnez	a0,80001ab6 <usertrap+0xfa>
  prepare_return();
    80001a72:	e0dff0ef          	jal	8000187e <prepare_return>
  uint64 satp = MAKE_SATP(p->pagetable);
    80001a76:	68a8                	ld	a0,80(s1)
    80001a78:	8131                	srli	a0,a0,0xc
    80001a7a:	57fd                	li	a5,-1
    80001a7c:	17fe                	slli	a5,a5,0x3f
    80001a7e:	8d5d                	or	a0,a0,a5
}
    80001a80:	60e2                	ld	ra,24(sp)
    80001a82:	6442                	ld	s0,16(sp)
    80001a84:	64a2                	ld	s1,8(sp)
    80001a86:	6902                	ld	s2,0(sp)
    80001a88:	6105                	addi	sp,sp,32
    80001a8a:	8082                	ret
      kexit(-1);
    80001a8c:	557d                	li	a0,-1
    80001a8e:	9c7ff0ef          	jal	80001454 <kexit>
    80001a92:	b7c1                	j	80001a52 <usertrap+0x96>
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001a94:	143025f3          	csrr	a1,stval
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001a98:	14202673          	csrr	a2,scause
            vmfault(p->pagetable, r_stval(), (r_scause() == 13)? 1 : 0) != 0) {
    80001a9c:	164d                	addi	a2,a2,-13 # ff3 <_entry-0x7ffff00d>
    80001a9e:	00163613          	seqz	a2,a2
    80001aa2:	68a8                	ld	a0,80(s1)
    80001aa4:	f73fe0ef          	jal	80000a16 <vmfault>
  } else if((r_scause() == 15 || r_scause() == 13) &&
    80001aa8:	f169                	bnez	a0,80001a6a <usertrap+0xae>
    80001aaa:	b7a5                	j	80001a12 <usertrap+0x56>
  if(killed(p))
    80001aac:	8526                	mv	a0,s1
    80001aae:	ad7ff0ef          	jal	80001584 <killed>
    80001ab2:	c511                	beqz	a0,80001abe <usertrap+0x102>
    80001ab4:	a011                	j	80001ab8 <usertrap+0xfc>
    80001ab6:	4901                	li	s2,0
    kexit(-1);
    80001ab8:	557d                	li	a0,-1
    80001aba:	99bff0ef          	jal	80001454 <kexit>
  if(which_dev == 2)
    80001abe:	4789                	li	a5,2
    80001ac0:	faf919e3          	bne	s2,a5,80001a72 <usertrap+0xb6>
    yield();
    80001ac4:	859ff0ef          	jal	8000131c <yield>
    80001ac8:	b76d                	j	80001a72 <usertrap+0xb6>

0000000080001aca <kerneltrap>:
{
    80001aca:	7179                	addi	sp,sp,-48
    80001acc:	f406                	sd	ra,40(sp)
    80001ace:	f022                	sd	s0,32(sp)
    80001ad0:	ec26                	sd	s1,24(sp)
    80001ad2:	e84a                	sd	s2,16(sp)
    80001ad4:	e44e                	sd	s3,8(sp)
    80001ad6:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001ad8:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001adc:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001ae0:	142027f3          	csrr	a5,scause
    80001ae4:	89be                	mv	s3,a5
  if((sstatus & SSTATUS_SPP) == 0)
    80001ae6:	1004f793          	andi	a5,s1,256
    80001aea:	c795                	beqz	a5,80001b16 <kerneltrap+0x4c>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001aec:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001af0:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001af2:	eb85                	bnez	a5,80001b22 <kerneltrap+0x58>
  if((which_dev = devintr()) == 0){
    80001af4:	e5bff0ef          	jal	8000194e <devintr>
    80001af8:	c91d                	beqz	a0,80001b2e <kerneltrap+0x64>
  if(which_dev == 2 && myproc() != 0)
    80001afa:	4789                	li	a5,2
    80001afc:	04f50a63          	beq	a0,a5,80001b50 <kerneltrap+0x86>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001b00:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b04:	10049073          	csrw	sstatus,s1
}
    80001b08:	70a2                	ld	ra,40(sp)
    80001b0a:	7402                	ld	s0,32(sp)
    80001b0c:	64e2                	ld	s1,24(sp)
    80001b0e:	6942                	ld	s2,16(sp)
    80001b10:	69a2                	ld	s3,8(sp)
    80001b12:	6145                	addi	sp,sp,48
    80001b14:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001b16:	00005517          	auipc	a0,0x5
    80001b1a:	77250513          	addi	a0,a0,1906 # 80007288 <etext+0x288>
    80001b1e:	237030ef          	jal	80005554 <panic>
    panic("kerneltrap: interrupts enabled");
    80001b22:	00005517          	auipc	a0,0x5
    80001b26:	78e50513          	addi	a0,a0,1934 # 800072b0 <etext+0x2b0>
    80001b2a:	22b030ef          	jal	80005554 <panic>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001b2e:	14102673          	csrr	a2,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001b32:	143026f3          	csrr	a3,stval
    printf("scause=0x%lx sepc=0x%lx stval=0x%lx\n", scause, r_sepc(), r_stval());
    80001b36:	85ce                	mv	a1,s3
    80001b38:	00005517          	auipc	a0,0x5
    80001b3c:	79850513          	addi	a0,a0,1944 # 800072d0 <etext+0x2d0>
    80001b40:	6dc030ef          	jal	8000521c <printf>
    panic("kerneltrap");
    80001b44:	00005517          	auipc	a0,0x5
    80001b48:	7b450513          	addi	a0,a0,1972 # 800072f8 <etext+0x2f8>
    80001b4c:	209030ef          	jal	80005554 <panic>
  if(which_dev == 2 && myproc() != 0)
    80001b50:	a0eff0ef          	jal	80000d5e <myproc>
    80001b54:	d555                	beqz	a0,80001b00 <kerneltrap+0x36>
    yield();
    80001b56:	fc6ff0ef          	jal	8000131c <yield>
    80001b5a:	b75d                	j	80001b00 <kerneltrap+0x36>

0000000080001b5c <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001b5c:	1101                	addi	sp,sp,-32
    80001b5e:	ec06                	sd	ra,24(sp)
    80001b60:	e822                	sd	s0,16(sp)
    80001b62:	e426                	sd	s1,8(sp)
    80001b64:	1000                	addi	s0,sp,32
    80001b66:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001b68:	9f6ff0ef          	jal	80000d5e <myproc>
  switch (n) {
    80001b6c:	4795                	li	a5,5
    80001b6e:	0497e163          	bltu	a5,s1,80001bb0 <argraw+0x54>
    80001b72:	048a                	slli	s1,s1,0x2
    80001b74:	00006717          	auipc	a4,0x6
    80001b78:	bcc70713          	addi	a4,a4,-1076 # 80007740 <states.0+0x30>
    80001b7c:	94ba                	add	s1,s1,a4
    80001b7e:	409c                	lw	a5,0(s1)
    80001b80:	97ba                	add	a5,a5,a4
    80001b82:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001b84:	6d3c                	ld	a5,88(a0)
    80001b86:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001b88:	60e2                	ld	ra,24(sp)
    80001b8a:	6442                	ld	s0,16(sp)
    80001b8c:	64a2                	ld	s1,8(sp)
    80001b8e:	6105                	addi	sp,sp,32
    80001b90:	8082                	ret
    return p->trapframe->a1;
    80001b92:	6d3c                	ld	a5,88(a0)
    80001b94:	7fa8                	ld	a0,120(a5)
    80001b96:	bfcd                	j	80001b88 <argraw+0x2c>
    return p->trapframe->a2;
    80001b98:	6d3c                	ld	a5,88(a0)
    80001b9a:	63c8                	ld	a0,128(a5)
    80001b9c:	b7f5                	j	80001b88 <argraw+0x2c>
    return p->trapframe->a3;
    80001b9e:	6d3c                	ld	a5,88(a0)
    80001ba0:	67c8                	ld	a0,136(a5)
    80001ba2:	b7dd                	j	80001b88 <argraw+0x2c>
    return p->trapframe->a4;
    80001ba4:	6d3c                	ld	a5,88(a0)
    80001ba6:	6bc8                	ld	a0,144(a5)
    80001ba8:	b7c5                	j	80001b88 <argraw+0x2c>
    return p->trapframe->a5;
    80001baa:	6d3c                	ld	a5,88(a0)
    80001bac:	6fc8                	ld	a0,152(a5)
    80001bae:	bfe9                	j	80001b88 <argraw+0x2c>
  panic("argraw");
    80001bb0:	00005517          	auipc	a0,0x5
    80001bb4:	75850513          	addi	a0,a0,1880 # 80007308 <etext+0x308>
    80001bb8:	19d030ef          	jal	80005554 <panic>

0000000080001bbc <fetchaddr>:
{
    80001bbc:	1101                	addi	sp,sp,-32
    80001bbe:	ec06                	sd	ra,24(sp)
    80001bc0:	e822                	sd	s0,16(sp)
    80001bc2:	e426                	sd	s1,8(sp)
    80001bc4:	e04a                	sd	s2,0(sp)
    80001bc6:	1000                	addi	s0,sp,32
    80001bc8:	84aa                	mv	s1,a0
    80001bca:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001bcc:	992ff0ef          	jal	80000d5e <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80001bd0:	653c                	ld	a5,72(a0)
    80001bd2:	02f4f663          	bgeu	s1,a5,80001bfe <fetchaddr+0x42>
    80001bd6:	00848713          	addi	a4,s1,8
    80001bda:	02e7e263          	bltu	a5,a4,80001bfe <fetchaddr+0x42>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001bde:	46a1                	li	a3,8
    80001be0:	8626                	mv	a2,s1
    80001be2:	85ca                	mv	a1,s2
    80001be4:	6928                	ld	a0,80(a0)
    80001be6:	f69fe0ef          	jal	80000b4e <copyin>
    80001bea:	00a03533          	snez	a0,a0
    80001bee:	40a0053b          	negw	a0,a0
}
    80001bf2:	60e2                	ld	ra,24(sp)
    80001bf4:	6442                	ld	s0,16(sp)
    80001bf6:	64a2                	ld	s1,8(sp)
    80001bf8:	6902                	ld	s2,0(sp)
    80001bfa:	6105                	addi	sp,sp,32
    80001bfc:	8082                	ret
    return -1;
    80001bfe:	557d                	li	a0,-1
    80001c00:	bfcd                	j	80001bf2 <fetchaddr+0x36>

0000000080001c02 <fetchstr>:
{
    80001c02:	7179                	addi	sp,sp,-48
    80001c04:	f406                	sd	ra,40(sp)
    80001c06:	f022                	sd	s0,32(sp)
    80001c08:	ec26                	sd	s1,24(sp)
    80001c0a:	e84a                	sd	s2,16(sp)
    80001c0c:	e44e                	sd	s3,8(sp)
    80001c0e:	1800                	addi	s0,sp,48
    80001c10:	89aa                	mv	s3,a0
    80001c12:	84ae                	mv	s1,a1
    80001c14:	8932                	mv	s2,a2
  struct proc *p = myproc();
    80001c16:	948ff0ef          	jal	80000d5e <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    80001c1a:	86ca                	mv	a3,s2
    80001c1c:	864e                	mv	a2,s3
    80001c1e:	85a6                	mv	a1,s1
    80001c20:	6928                	ld	a0,80(a0)
    80001c22:	d1dfe0ef          	jal	8000093e <copyinstr>
    80001c26:	00054c63          	bltz	a0,80001c3e <fetchstr+0x3c>
  return strlen(buf);
    80001c2a:	8526                	mv	a0,s1
    80001c2c:	eb2fe0ef          	jal	800002de <strlen>
}
    80001c30:	70a2                	ld	ra,40(sp)
    80001c32:	7402                	ld	s0,32(sp)
    80001c34:	64e2                	ld	s1,24(sp)
    80001c36:	6942                	ld	s2,16(sp)
    80001c38:	69a2                	ld	s3,8(sp)
    80001c3a:	6145                	addi	sp,sp,48
    80001c3c:	8082                	ret
    return -1;
    80001c3e:	557d                	li	a0,-1
    80001c40:	bfc5                	j	80001c30 <fetchstr+0x2e>

0000000080001c42 <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    80001c42:	1101                	addi	sp,sp,-32
    80001c44:	ec06                	sd	ra,24(sp)
    80001c46:	e822                	sd	s0,16(sp)
    80001c48:	e426                	sd	s1,8(sp)
    80001c4a:	1000                	addi	s0,sp,32
    80001c4c:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001c4e:	f0fff0ef          	jal	80001b5c <argraw>
    80001c52:	c088                	sw	a0,0(s1)
}
    80001c54:	60e2                	ld	ra,24(sp)
    80001c56:	6442                	ld	s0,16(sp)
    80001c58:	64a2                	ld	s1,8(sp)
    80001c5a:	6105                	addi	sp,sp,32
    80001c5c:	8082                	ret

0000000080001c5e <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    80001c5e:	1101                	addi	sp,sp,-32
    80001c60:	ec06                	sd	ra,24(sp)
    80001c62:	e822                	sd	s0,16(sp)
    80001c64:	e426                	sd	s1,8(sp)
    80001c66:	1000                	addi	s0,sp,32
    80001c68:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001c6a:	ef3ff0ef          	jal	80001b5c <argraw>
    80001c6e:	e088                	sd	a0,0(s1)
}
    80001c70:	60e2                	ld	ra,24(sp)
    80001c72:	6442                	ld	s0,16(sp)
    80001c74:	64a2                	ld	s1,8(sp)
    80001c76:	6105                	addi	sp,sp,32
    80001c78:	8082                	ret

0000000080001c7a <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80001c7a:	1101                	addi	sp,sp,-32
    80001c7c:	ec06                	sd	ra,24(sp)
    80001c7e:	e822                	sd	s0,16(sp)
    80001c80:	e426                	sd	s1,8(sp)
    80001c82:	e04a                	sd	s2,0(sp)
    80001c84:	1000                	addi	s0,sp,32
    80001c86:	892e                	mv	s2,a1
    80001c88:	84b2                	mv	s1,a2
  *ip = argraw(n);
    80001c8a:	ed3ff0ef          	jal	80001b5c <argraw>
  uint64 addr;
  argaddr(n, &addr);
  return fetchstr(addr, buf, max);
    80001c8e:	8626                	mv	a2,s1
    80001c90:	85ca                	mv	a1,s2
    80001c92:	f71ff0ef          	jal	80001c02 <fetchstr>
}
    80001c96:	60e2                	ld	ra,24(sp)
    80001c98:	6442                	ld	s0,16(sp)
    80001c9a:	64a2                	ld	s1,8(sp)
    80001c9c:	6902                	ld	s2,0(sp)
    80001c9e:	6105                	addi	sp,sp,32
    80001ca0:	8082                	ret

0000000080001ca2 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
    80001ca2:	1101                	addi	sp,sp,-32
    80001ca4:	ec06                	sd	ra,24(sp)
    80001ca6:	e822                	sd	s0,16(sp)
    80001ca8:	e426                	sd	s1,8(sp)
    80001caa:	e04a                	sd	s2,0(sp)
    80001cac:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80001cae:	8b0ff0ef          	jal	80000d5e <myproc>
    80001cb2:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80001cb4:	05853903          	ld	s2,88(a0)
    80001cb8:	0a893783          	ld	a5,168(s2)
    80001cbc:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80001cc0:	37fd                	addiw	a5,a5,-1
    80001cc2:	4751                	li	a4,20
    80001cc4:	00f76f63          	bltu	a4,a5,80001ce2 <syscall+0x40>
    80001cc8:	00369713          	slli	a4,a3,0x3
    80001ccc:	00006797          	auipc	a5,0x6
    80001cd0:	a8c78793          	addi	a5,a5,-1396 # 80007758 <syscalls>
    80001cd4:	97ba                	add	a5,a5,a4
    80001cd6:	639c                	ld	a5,0(a5)
    80001cd8:	c789                	beqz	a5,80001ce2 <syscall+0x40>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    80001cda:	9782                	jalr	a5
    80001cdc:	06a93823          	sd	a0,112(s2)
    80001ce0:	a829                	j	80001cfa <syscall+0x58>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80001ce2:	15848613          	addi	a2,s1,344
    80001ce6:	588c                	lw	a1,48(s1)
    80001ce8:	00005517          	auipc	a0,0x5
    80001cec:	62850513          	addi	a0,a0,1576 # 80007310 <etext+0x310>
    80001cf0:	52c030ef          	jal	8000521c <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80001cf4:	6cbc                	ld	a5,88(s1)
    80001cf6:	577d                	li	a4,-1
    80001cf8:	fbb8                	sd	a4,112(a5)
  }
}
    80001cfa:	60e2                	ld	ra,24(sp)
    80001cfc:	6442                	ld	s0,16(sp)
    80001cfe:	64a2                	ld	s1,8(sp)
    80001d00:	6902                	ld	s2,0(sp)
    80001d02:	6105                	addi	sp,sp,32
    80001d04:	8082                	ret

0000000080001d06 <sys_exit>:
#include "proc.h"
#include "vm.h"

uint64
sys_exit(void)
{
    80001d06:	1101                	addi	sp,sp,-32
    80001d08:	ec06                	sd	ra,24(sp)
    80001d0a:	e822                	sd	s0,16(sp)
    80001d0c:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80001d0e:	fec40593          	addi	a1,s0,-20
    80001d12:	4501                	li	a0,0
    80001d14:	f2fff0ef          	jal	80001c42 <argint>
  kexit(n);
    80001d18:	fec42503          	lw	a0,-20(s0)
    80001d1c:	f38ff0ef          	jal	80001454 <kexit>
  return 0;  // not reached
}
    80001d20:	4501                	li	a0,0
    80001d22:	60e2                	ld	ra,24(sp)
    80001d24:	6442                	ld	s0,16(sp)
    80001d26:	6105                	addi	sp,sp,32
    80001d28:	8082                	ret

0000000080001d2a <sys_getpid>:

uint64
sys_getpid(void)
{
    80001d2a:	1141                	addi	sp,sp,-16
    80001d2c:	e406                	sd	ra,8(sp)
    80001d2e:	e022                	sd	s0,0(sp)
    80001d30:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80001d32:	82cff0ef          	jal	80000d5e <myproc>
}
    80001d36:	5908                	lw	a0,48(a0)
    80001d38:	60a2                	ld	ra,8(sp)
    80001d3a:	6402                	ld	s0,0(sp)
    80001d3c:	0141                	addi	sp,sp,16
    80001d3e:	8082                	ret

0000000080001d40 <sys_fork>:

uint64
sys_fork(void)
{
    80001d40:	1141                	addi	sp,sp,-16
    80001d42:	e406                	sd	ra,8(sp)
    80001d44:	e022                	sd	s0,0(sp)
    80001d46:	0800                	addi	s0,sp,16
  return kfork();
    80001d48:	b6aff0ef          	jal	800010b2 <kfork>
}
    80001d4c:	60a2                	ld	ra,8(sp)
    80001d4e:	6402                	ld	s0,0(sp)
    80001d50:	0141                	addi	sp,sp,16
    80001d52:	8082                	ret

0000000080001d54 <sys_wait>:

uint64
sys_wait(void)
{
    80001d54:	1101                	addi	sp,sp,-32
    80001d56:	ec06                	sd	ra,24(sp)
    80001d58:	e822                	sd	s0,16(sp)
    80001d5a:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80001d5c:	fe840593          	addi	a1,s0,-24
    80001d60:	4501                	li	a0,0
    80001d62:	efdff0ef          	jal	80001c5e <argaddr>
  return kwait(p);
    80001d66:	fe843503          	ld	a0,-24(s0)
    80001d6a:	845ff0ef          	jal	800015ae <kwait>
}
    80001d6e:	60e2                	ld	ra,24(sp)
    80001d70:	6442                	ld	s0,16(sp)
    80001d72:	6105                	addi	sp,sp,32
    80001d74:	8082                	ret

0000000080001d76 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80001d76:	7179                	addi	sp,sp,-48
    80001d78:	f406                	sd	ra,40(sp)
    80001d7a:	f022                	sd	s0,32(sp)
    80001d7c:	ec26                	sd	s1,24(sp)
    80001d7e:	1800                	addi	s0,sp,48
  uint64 addr;
  int t;
  int n;

  argint(0, &n);
    80001d80:	fd840593          	addi	a1,s0,-40
    80001d84:	4501                	li	a0,0
    80001d86:	ebdff0ef          	jal	80001c42 <argint>
  argint(1, &t);
    80001d8a:	fdc40593          	addi	a1,s0,-36
    80001d8e:	4505                	li	a0,1
    80001d90:	eb3ff0ef          	jal	80001c42 <argint>
  addr = myproc()->sz;
    80001d94:	fcbfe0ef          	jal	80000d5e <myproc>
    80001d98:	6524                	ld	s1,72(a0)

  if(t == SBRK_EAGER || n < 0) {
    80001d9a:	fdc42703          	lw	a4,-36(s0)
    80001d9e:	4785                	li	a5,1
    80001da0:	02f70163          	beq	a4,a5,80001dc2 <sys_sbrk+0x4c>
    80001da4:	fd842783          	lw	a5,-40(s0)
    80001da8:	0007cd63          	bltz	a5,80001dc2 <sys_sbrk+0x4c>
    }
  } else {
    // Lazily allocate memory for this process: increase its memory
    // size but don't allocate memory. If the processes uses the
    // memory, vmfault() will allocate it.
    if(addr + n < addr)
    80001dac:	97a6                	add	a5,a5,s1
    80001dae:	0297e863          	bltu	a5,s1,80001dde <sys_sbrk+0x68>
      return -1;
    myproc()->sz += n;
    80001db2:	fadfe0ef          	jal	80000d5e <myproc>
    80001db6:	fd842703          	lw	a4,-40(s0)
    80001dba:	653c                	ld	a5,72(a0)
    80001dbc:	97ba                	add	a5,a5,a4
    80001dbe:	e53c                	sd	a5,72(a0)
    80001dc0:	a039                	j	80001dce <sys_sbrk+0x58>
    if(growproc(n) < 0) {
    80001dc2:	fd842503          	lw	a0,-40(s0)
    80001dc6:	a9cff0ef          	jal	80001062 <growproc>
    80001dca:	00054863          	bltz	a0,80001dda <sys_sbrk+0x64>
  }
  return addr;
}
    80001dce:	8526                	mv	a0,s1
    80001dd0:	70a2                	ld	ra,40(sp)
    80001dd2:	7402                	ld	s0,32(sp)
    80001dd4:	64e2                	ld	s1,24(sp)
    80001dd6:	6145                	addi	sp,sp,48
    80001dd8:	8082                	ret
      return -1;
    80001dda:	54fd                	li	s1,-1
    80001ddc:	bfcd                	j	80001dce <sys_sbrk+0x58>
      return -1;
    80001dde:	54fd                	li	s1,-1
    80001de0:	b7fd                	j	80001dce <sys_sbrk+0x58>

0000000080001de2 <sys_pause>:

uint64
sys_pause(void)
{
    80001de2:	7139                	addi	sp,sp,-64
    80001de4:	fc06                	sd	ra,56(sp)
    80001de6:	f822                	sd	s0,48(sp)
    80001de8:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    80001dea:	fcc40593          	addi	a1,s0,-52
    80001dee:	4501                	li	a0,0
    80001df0:	e53ff0ef          	jal	80001c42 <argint>
  if(n < 0)
    80001df4:	fcc42783          	lw	a5,-52(s0)
    80001df8:	0607c863          	bltz	a5,80001e68 <sys_pause+0x86>
    n = 0;
  acquire(&tickslock);
    80001dfc:	0000c517          	auipc	a0,0xc
    80001e00:	8b450513          	addi	a0,a0,-1868 # 8000d6b0 <tickslock>
    80001e04:	20f030ef          	jal	80005812 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    80001e08:	fcc42783          	lw	a5,-52(s0)
    80001e0c:	c3b9                	beqz	a5,80001e52 <sys_pause+0x70>
    80001e0e:	f426                	sd	s1,40(sp)
    80001e10:	f04a                	sd	s2,32(sp)
    80001e12:	ec4e                	sd	s3,24(sp)
  ticks0 = ticks;
    80001e14:	00006997          	auipc	s3,0x6
    80001e18:	a349a983          	lw	s3,-1484(s3) # 80007848 <ticks>
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80001e1c:	0000c917          	auipc	s2,0xc
    80001e20:	89490913          	addi	s2,s2,-1900 # 8000d6b0 <tickslock>
    80001e24:	00006497          	auipc	s1,0x6
    80001e28:	a2448493          	addi	s1,s1,-1500 # 80007848 <ticks>
    if(killed(myproc())){
    80001e2c:	f33fe0ef          	jal	80000d5e <myproc>
    80001e30:	f54ff0ef          	jal	80001584 <killed>
    80001e34:	ed0d                	bnez	a0,80001e6e <sys_pause+0x8c>
    sleep(&ticks, &tickslock);
    80001e36:	85ca                	mv	a1,s2
    80001e38:	8526                	mv	a0,s1
    80001e3a:	d0eff0ef          	jal	80001348 <sleep>
  while(ticks - ticks0 < n){
    80001e3e:	409c                	lw	a5,0(s1)
    80001e40:	413787bb          	subw	a5,a5,s3
    80001e44:	fcc42703          	lw	a4,-52(s0)
    80001e48:	fee7e2e3          	bltu	a5,a4,80001e2c <sys_pause+0x4a>
    80001e4c:	74a2                	ld	s1,40(sp)
    80001e4e:	7902                	ld	s2,32(sp)
    80001e50:	69e2                	ld	s3,24(sp)
  }
  release(&tickslock);
    80001e52:	0000c517          	auipc	a0,0xc
    80001e56:	85e50513          	addi	a0,a0,-1954 # 8000d6b0 <tickslock>
    80001e5a:	249030ef          	jal	800058a2 <release>
  return 0;
    80001e5e:	4501                	li	a0,0
}
    80001e60:	70e2                	ld	ra,56(sp)
    80001e62:	7442                	ld	s0,48(sp)
    80001e64:	6121                	addi	sp,sp,64
    80001e66:	8082                	ret
    n = 0;
    80001e68:	fc042623          	sw	zero,-52(s0)
    80001e6c:	bf41                	j	80001dfc <sys_pause+0x1a>
      release(&tickslock);
    80001e6e:	0000c517          	auipc	a0,0xc
    80001e72:	84250513          	addi	a0,a0,-1982 # 8000d6b0 <tickslock>
    80001e76:	22d030ef          	jal	800058a2 <release>
      return -1;
    80001e7a:	557d                	li	a0,-1
    80001e7c:	74a2                	ld	s1,40(sp)
    80001e7e:	7902                	ld	s2,32(sp)
    80001e80:	69e2                	ld	s3,24(sp)
    80001e82:	bff9                	j	80001e60 <sys_pause+0x7e>

0000000080001e84 <sys_kill>:

uint64
sys_kill(void)
{
    80001e84:	1101                	addi	sp,sp,-32
    80001e86:	ec06                	sd	ra,24(sp)
    80001e88:	e822                	sd	s0,16(sp)
    80001e8a:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80001e8c:	fec40593          	addi	a1,s0,-20
    80001e90:	4501                	li	a0,0
    80001e92:	db1ff0ef          	jal	80001c42 <argint>
  return kkill(pid);
    80001e96:	fec42503          	lw	a0,-20(s0)
    80001e9a:	e60ff0ef          	jal	800014fa <kkill>
}
    80001e9e:	60e2                	ld	ra,24(sp)
    80001ea0:	6442                	ld	s0,16(sp)
    80001ea2:	6105                	addi	sp,sp,32
    80001ea4:	8082                	ret

0000000080001ea6 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80001ea6:	1101                	addi	sp,sp,-32
    80001ea8:	ec06                	sd	ra,24(sp)
    80001eaa:	e822                	sd	s0,16(sp)
    80001eac:	e426                	sd	s1,8(sp)
    80001eae:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80001eb0:	0000c517          	auipc	a0,0xc
    80001eb4:	80050513          	addi	a0,a0,-2048 # 8000d6b0 <tickslock>
    80001eb8:	15b030ef          	jal	80005812 <acquire>
  xticks = ticks;
    80001ebc:	00006797          	auipc	a5,0x6
    80001ec0:	98c7a783          	lw	a5,-1652(a5) # 80007848 <ticks>
    80001ec4:	84be                	mv	s1,a5
  release(&tickslock);
    80001ec6:	0000b517          	auipc	a0,0xb
    80001eca:	7ea50513          	addi	a0,a0,2026 # 8000d6b0 <tickslock>
    80001ece:	1d5030ef          	jal	800058a2 <release>
  return xticks;
}
    80001ed2:	02049513          	slli	a0,s1,0x20
    80001ed6:	9101                	srli	a0,a0,0x20
    80001ed8:	60e2                	ld	ra,24(sp)
    80001eda:	6442                	ld	s0,16(sp)
    80001edc:	64a2                	ld	s1,8(sp)
    80001ede:	6105                	addi	sp,sp,32
    80001ee0:	8082                	ret

0000000080001ee2 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80001ee2:	7179                	addi	sp,sp,-48
    80001ee4:	f406                	sd	ra,40(sp)
    80001ee6:	f022                	sd	s0,32(sp)
    80001ee8:	ec26                	sd	s1,24(sp)
    80001eea:	e84a                	sd	s2,16(sp)
    80001eec:	e44e                	sd	s3,8(sp)
    80001eee:	e052                	sd	s4,0(sp)
    80001ef0:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80001ef2:	00005597          	auipc	a1,0x5
    80001ef6:	43e58593          	addi	a1,a1,1086 # 80007330 <etext+0x330>
    80001efa:	0000b517          	auipc	a0,0xb
    80001efe:	7ce50513          	addi	a0,a0,1998 # 8000d6c8 <bcache>
    80001f02:	087030ef          	jal	80005788 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80001f06:	00013797          	auipc	a5,0x13
    80001f0a:	7c278793          	addi	a5,a5,1986 # 800156c8 <bcache+0x8000>
    80001f0e:	00014717          	auipc	a4,0x14
    80001f12:	a2270713          	addi	a4,a4,-1502 # 80015930 <bcache+0x8268>
    80001f16:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80001f1a:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80001f1e:	0000b497          	auipc	s1,0xb
    80001f22:	7c248493          	addi	s1,s1,1986 # 8000d6e0 <bcache+0x18>
    b->next = bcache.head.next;
    80001f26:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80001f28:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80001f2a:	00005a17          	auipc	s4,0x5
    80001f2e:	40ea0a13          	addi	s4,s4,1038 # 80007338 <etext+0x338>
    b->next = bcache.head.next;
    80001f32:	2b893783          	ld	a5,696(s2)
    80001f36:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80001f38:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80001f3c:	85d2                	mv	a1,s4
    80001f3e:	01048513          	addi	a0,s1,16
    80001f42:	336010ef          	jal	80003278 <initsleeplock>
    bcache.head.next->prev = b;
    80001f46:	2b893783          	ld	a5,696(s2)
    80001f4a:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80001f4c:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80001f50:	45848493          	addi	s1,s1,1112
    80001f54:	fd349fe3          	bne	s1,s3,80001f32 <binit+0x50>
  }
}
    80001f58:	70a2                	ld	ra,40(sp)
    80001f5a:	7402                	ld	s0,32(sp)
    80001f5c:	64e2                	ld	s1,24(sp)
    80001f5e:	6942                	ld	s2,16(sp)
    80001f60:	69a2                	ld	s3,8(sp)
    80001f62:	6a02                	ld	s4,0(sp)
    80001f64:	6145                	addi	sp,sp,48
    80001f66:	8082                	ret

0000000080001f68 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80001f68:	7179                	addi	sp,sp,-48
    80001f6a:	f406                	sd	ra,40(sp)
    80001f6c:	f022                	sd	s0,32(sp)
    80001f6e:	ec26                	sd	s1,24(sp)
    80001f70:	e84a                	sd	s2,16(sp)
    80001f72:	e44e                	sd	s3,8(sp)
    80001f74:	1800                	addi	s0,sp,48
    80001f76:	892a                	mv	s2,a0
    80001f78:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80001f7a:	0000b517          	auipc	a0,0xb
    80001f7e:	74e50513          	addi	a0,a0,1870 # 8000d6c8 <bcache>
    80001f82:	091030ef          	jal	80005812 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80001f86:	00014497          	auipc	s1,0x14
    80001f8a:	9fa4b483          	ld	s1,-1542(s1) # 80015980 <bcache+0x82b8>
    80001f8e:	00014797          	auipc	a5,0x14
    80001f92:	9a278793          	addi	a5,a5,-1630 # 80015930 <bcache+0x8268>
    80001f96:	02f48b63          	beq	s1,a5,80001fcc <bread+0x64>
    80001f9a:	873e                	mv	a4,a5
    80001f9c:	a021                	j	80001fa4 <bread+0x3c>
    80001f9e:	68a4                	ld	s1,80(s1)
    80001fa0:	02e48663          	beq	s1,a4,80001fcc <bread+0x64>
    if(b->dev == dev && b->blockno == blockno){
    80001fa4:	449c                	lw	a5,8(s1)
    80001fa6:	ff279ce3          	bne	a5,s2,80001f9e <bread+0x36>
    80001faa:	44dc                	lw	a5,12(s1)
    80001fac:	ff3799e3          	bne	a5,s3,80001f9e <bread+0x36>
      b->refcnt++;
    80001fb0:	40bc                	lw	a5,64(s1)
    80001fb2:	2785                	addiw	a5,a5,1
    80001fb4:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80001fb6:	0000b517          	auipc	a0,0xb
    80001fba:	71250513          	addi	a0,a0,1810 # 8000d6c8 <bcache>
    80001fbe:	0e5030ef          	jal	800058a2 <release>
      acquiresleep(&b->lock);
    80001fc2:	01048513          	addi	a0,s1,16
    80001fc6:	2e8010ef          	jal	800032ae <acquiresleep>
      return b;
    80001fca:	a889                	j	8000201c <bread+0xb4>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80001fcc:	00014497          	auipc	s1,0x14
    80001fd0:	9ac4b483          	ld	s1,-1620(s1) # 80015978 <bcache+0x82b0>
    80001fd4:	00014797          	auipc	a5,0x14
    80001fd8:	95c78793          	addi	a5,a5,-1700 # 80015930 <bcache+0x8268>
    80001fdc:	00f48863          	beq	s1,a5,80001fec <bread+0x84>
    80001fe0:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80001fe2:	40bc                	lw	a5,64(s1)
    80001fe4:	cb91                	beqz	a5,80001ff8 <bread+0x90>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80001fe6:	64a4                	ld	s1,72(s1)
    80001fe8:	fee49de3          	bne	s1,a4,80001fe2 <bread+0x7a>
  panic("bget: no buffers");
    80001fec:	00005517          	auipc	a0,0x5
    80001ff0:	35450513          	addi	a0,a0,852 # 80007340 <etext+0x340>
    80001ff4:	560030ef          	jal	80005554 <panic>
      b->dev = dev;
    80001ff8:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80001ffc:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80002000:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002004:	4785                	li	a5,1
    80002006:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002008:	0000b517          	auipc	a0,0xb
    8000200c:	6c050513          	addi	a0,a0,1728 # 8000d6c8 <bcache>
    80002010:	093030ef          	jal	800058a2 <release>
      acquiresleep(&b->lock);
    80002014:	01048513          	addi	a0,s1,16
    80002018:	296010ef          	jal	800032ae <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    8000201c:	409c                	lw	a5,0(s1)
    8000201e:	cb89                	beqz	a5,80002030 <bread+0xc8>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002020:	8526                	mv	a0,s1
    80002022:	70a2                	ld	ra,40(sp)
    80002024:	7402                	ld	s0,32(sp)
    80002026:	64e2                	ld	s1,24(sp)
    80002028:	6942                	ld	s2,16(sp)
    8000202a:	69a2                	ld	s3,8(sp)
    8000202c:	6145                	addi	sp,sp,48
    8000202e:	8082                	ret
    virtio_disk_rw(b, 0);
    80002030:	4581                	li	a1,0
    80002032:	8526                	mv	a0,s1
    80002034:	24f020ef          	jal	80004a82 <virtio_disk_rw>
    b->valid = 1;
    80002038:	4785                	li	a5,1
    8000203a:	c09c                	sw	a5,0(s1)
  return b;
    8000203c:	b7d5                	j	80002020 <bread+0xb8>

000000008000203e <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    8000203e:	1101                	addi	sp,sp,-32
    80002040:	ec06                	sd	ra,24(sp)
    80002042:	e822                	sd	s0,16(sp)
    80002044:	e426                	sd	s1,8(sp)
    80002046:	1000                	addi	s0,sp,32
    80002048:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000204a:	0541                	addi	a0,a0,16
    8000204c:	2e0010ef          	jal	8000332c <holdingsleep>
    80002050:	c911                	beqz	a0,80002064 <bwrite+0x26>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002052:	4585                	li	a1,1
    80002054:	8526                	mv	a0,s1
    80002056:	22d020ef          	jal	80004a82 <virtio_disk_rw>
}
    8000205a:	60e2                	ld	ra,24(sp)
    8000205c:	6442                	ld	s0,16(sp)
    8000205e:	64a2                	ld	s1,8(sp)
    80002060:	6105                	addi	sp,sp,32
    80002062:	8082                	ret
    panic("bwrite");
    80002064:	00005517          	auipc	a0,0x5
    80002068:	2f450513          	addi	a0,a0,756 # 80007358 <etext+0x358>
    8000206c:	4e8030ef          	jal	80005554 <panic>

0000000080002070 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80002070:	1101                	addi	sp,sp,-32
    80002072:	ec06                	sd	ra,24(sp)
    80002074:	e822                	sd	s0,16(sp)
    80002076:	e426                	sd	s1,8(sp)
    80002078:	e04a                	sd	s2,0(sp)
    8000207a:	1000                	addi	s0,sp,32
    8000207c:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000207e:	01050913          	addi	s2,a0,16
    80002082:	854a                	mv	a0,s2
    80002084:	2a8010ef          	jal	8000332c <holdingsleep>
    80002088:	c125                	beqz	a0,800020e8 <brelse+0x78>
    panic("brelse");

  releasesleep(&b->lock);
    8000208a:	854a                	mv	a0,s2
    8000208c:	268010ef          	jal	800032f4 <releasesleep>

  acquire(&bcache.lock);
    80002090:	0000b517          	auipc	a0,0xb
    80002094:	63850513          	addi	a0,a0,1592 # 8000d6c8 <bcache>
    80002098:	77a030ef          	jal	80005812 <acquire>
  b->refcnt--;
    8000209c:	40bc                	lw	a5,64(s1)
    8000209e:	37fd                	addiw	a5,a5,-1
    800020a0:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    800020a2:	e79d                	bnez	a5,800020d0 <brelse+0x60>
    // no one is waiting for it.
    b->next->prev = b->prev;
    800020a4:	68b8                	ld	a4,80(s1)
    800020a6:	64bc                	ld	a5,72(s1)
    800020a8:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    800020aa:	68b8                	ld	a4,80(s1)
    800020ac:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    800020ae:	00013797          	auipc	a5,0x13
    800020b2:	61a78793          	addi	a5,a5,1562 # 800156c8 <bcache+0x8000>
    800020b6:	2b87b703          	ld	a4,696(a5)
    800020ba:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    800020bc:	00014717          	auipc	a4,0x14
    800020c0:	87470713          	addi	a4,a4,-1932 # 80015930 <bcache+0x8268>
    800020c4:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    800020c6:	2b87b703          	ld	a4,696(a5)
    800020ca:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    800020cc:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    800020d0:	0000b517          	auipc	a0,0xb
    800020d4:	5f850513          	addi	a0,a0,1528 # 8000d6c8 <bcache>
    800020d8:	7ca030ef          	jal	800058a2 <release>
}
    800020dc:	60e2                	ld	ra,24(sp)
    800020de:	6442                	ld	s0,16(sp)
    800020e0:	64a2                	ld	s1,8(sp)
    800020e2:	6902                	ld	s2,0(sp)
    800020e4:	6105                	addi	sp,sp,32
    800020e6:	8082                	ret
    panic("brelse");
    800020e8:	00005517          	auipc	a0,0x5
    800020ec:	27850513          	addi	a0,a0,632 # 80007360 <etext+0x360>
    800020f0:	464030ef          	jal	80005554 <panic>

00000000800020f4 <bpin>:

void
bpin(struct buf *b) {
    800020f4:	1101                	addi	sp,sp,-32
    800020f6:	ec06                	sd	ra,24(sp)
    800020f8:	e822                	sd	s0,16(sp)
    800020fa:	e426                	sd	s1,8(sp)
    800020fc:	1000                	addi	s0,sp,32
    800020fe:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002100:	0000b517          	auipc	a0,0xb
    80002104:	5c850513          	addi	a0,a0,1480 # 8000d6c8 <bcache>
    80002108:	70a030ef          	jal	80005812 <acquire>
  b->refcnt++;
    8000210c:	40bc                	lw	a5,64(s1)
    8000210e:	2785                	addiw	a5,a5,1
    80002110:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002112:	0000b517          	auipc	a0,0xb
    80002116:	5b650513          	addi	a0,a0,1462 # 8000d6c8 <bcache>
    8000211a:	788030ef          	jal	800058a2 <release>
}
    8000211e:	60e2                	ld	ra,24(sp)
    80002120:	6442                	ld	s0,16(sp)
    80002122:	64a2                	ld	s1,8(sp)
    80002124:	6105                	addi	sp,sp,32
    80002126:	8082                	ret

0000000080002128 <bunpin>:

void
bunpin(struct buf *b) {
    80002128:	1101                	addi	sp,sp,-32
    8000212a:	ec06                	sd	ra,24(sp)
    8000212c:	e822                	sd	s0,16(sp)
    8000212e:	e426                	sd	s1,8(sp)
    80002130:	1000                	addi	s0,sp,32
    80002132:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002134:	0000b517          	auipc	a0,0xb
    80002138:	59450513          	addi	a0,a0,1428 # 8000d6c8 <bcache>
    8000213c:	6d6030ef          	jal	80005812 <acquire>
  b->refcnt--;
    80002140:	40bc                	lw	a5,64(s1)
    80002142:	37fd                	addiw	a5,a5,-1
    80002144:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002146:	0000b517          	auipc	a0,0xb
    8000214a:	58250513          	addi	a0,a0,1410 # 8000d6c8 <bcache>
    8000214e:	754030ef          	jal	800058a2 <release>
}
    80002152:	60e2                	ld	ra,24(sp)
    80002154:	6442                	ld	s0,16(sp)
    80002156:	64a2                	ld	s1,8(sp)
    80002158:	6105                	addi	sp,sp,32
    8000215a:	8082                	ret

000000008000215c <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    8000215c:	1101                	addi	sp,sp,-32
    8000215e:	ec06                	sd	ra,24(sp)
    80002160:	e822                	sd	s0,16(sp)
    80002162:	e426                	sd	s1,8(sp)
    80002164:	e04a                	sd	s2,0(sp)
    80002166:	1000                	addi	s0,sp,32
    80002168:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    8000216a:	00d5d79b          	srliw	a5,a1,0xd
    8000216e:	00014597          	auipc	a1,0x14
    80002172:	c365a583          	lw	a1,-970(a1) # 80015da4 <sb+0x1c>
    80002176:	9dbd                	addw	a1,a1,a5
    80002178:	df1ff0ef          	jal	80001f68 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    8000217c:	0074f713          	andi	a4,s1,7
    80002180:	4785                	li	a5,1
    80002182:	00e797bb          	sllw	a5,a5,a4
  bi = b % BPB;
    80002186:	14ce                	slli	s1,s1,0x33
  if((bp->data[bi/8] & m) == 0)
    80002188:	90d9                	srli	s1,s1,0x36
    8000218a:	00950733          	add	a4,a0,s1
    8000218e:	05874703          	lbu	a4,88(a4)
    80002192:	00e7f6b3          	and	a3,a5,a4
    80002196:	c29d                	beqz	a3,800021bc <bfree+0x60>
    80002198:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    8000219a:	94aa                	add	s1,s1,a0
    8000219c:	fff7c793          	not	a5,a5
    800021a0:	8f7d                	and	a4,a4,a5
    800021a2:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    800021a6:	012010ef          	jal	800031b8 <log_write>
  brelse(bp);
    800021aa:	854a                	mv	a0,s2
    800021ac:	ec5ff0ef          	jal	80002070 <brelse>
}
    800021b0:	60e2                	ld	ra,24(sp)
    800021b2:	6442                	ld	s0,16(sp)
    800021b4:	64a2                	ld	s1,8(sp)
    800021b6:	6902                	ld	s2,0(sp)
    800021b8:	6105                	addi	sp,sp,32
    800021ba:	8082                	ret
    panic("freeing free block");
    800021bc:	00005517          	auipc	a0,0x5
    800021c0:	1ac50513          	addi	a0,a0,428 # 80007368 <etext+0x368>
    800021c4:	390030ef          	jal	80005554 <panic>

00000000800021c8 <balloc>:
{
    800021c8:	715d                	addi	sp,sp,-80
    800021ca:	e486                	sd	ra,72(sp)
    800021cc:	e0a2                	sd	s0,64(sp)
    800021ce:	fc26                	sd	s1,56(sp)
    800021d0:	0880                	addi	s0,sp,80
  for(b = 0; b < sb.size; b += BPB){
    800021d2:	00014797          	auipc	a5,0x14
    800021d6:	bba7a783          	lw	a5,-1094(a5) # 80015d8c <sb+0x4>
    800021da:	0e078263          	beqz	a5,800022be <balloc+0xf6>
    800021de:	f84a                	sd	s2,48(sp)
    800021e0:	f44e                	sd	s3,40(sp)
    800021e2:	f052                	sd	s4,32(sp)
    800021e4:	ec56                	sd	s5,24(sp)
    800021e6:	e85a                	sd	s6,16(sp)
    800021e8:	e45e                	sd	s7,8(sp)
    800021ea:	e062                	sd	s8,0(sp)
    800021ec:	8baa                	mv	s7,a0
    800021ee:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    800021f0:	00014b17          	auipc	s6,0x14
    800021f4:	b98b0b13          	addi	s6,s6,-1128 # 80015d88 <sb>
      m = 1 << (bi % 8);
    800021f8:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800021fa:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    800021fc:	6c09                	lui	s8,0x2
    800021fe:	a09d                	j	80002264 <balloc+0x9c>
        bp->data[bi/8] |= m;  // Mark block in use.
    80002200:	97ca                	add	a5,a5,s2
    80002202:	8e55                	or	a2,a2,a3
    80002204:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    80002208:	854a                	mv	a0,s2
    8000220a:	7af000ef          	jal	800031b8 <log_write>
        brelse(bp);
    8000220e:	854a                	mv	a0,s2
    80002210:	e61ff0ef          	jal	80002070 <brelse>
  bp = bread(dev, bno);
    80002214:	85a6                	mv	a1,s1
    80002216:	855e                	mv	a0,s7
    80002218:	d51ff0ef          	jal	80001f68 <bread>
    8000221c:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    8000221e:	40000613          	li	a2,1024
    80002222:	4581                	li	a1,0
    80002224:	05850513          	addi	a0,a0,88
    80002228:	f37fd0ef          	jal	8000015e <memset>
  log_write(bp);
    8000222c:	854a                	mv	a0,s2
    8000222e:	78b000ef          	jal	800031b8 <log_write>
  brelse(bp);
    80002232:	854a                	mv	a0,s2
    80002234:	e3dff0ef          	jal	80002070 <brelse>
        return b + bi;
    80002238:	7942                	ld	s2,48(sp)
    8000223a:	79a2                	ld	s3,40(sp)
    8000223c:	7a02                	ld	s4,32(sp)
    8000223e:	6ae2                	ld	s5,24(sp)
    80002240:	6b42                	ld	s6,16(sp)
    80002242:	6ba2                	ld	s7,8(sp)
    80002244:	6c02                	ld	s8,0(sp)
}
    80002246:	8526                	mv	a0,s1
    80002248:	60a6                	ld	ra,72(sp)
    8000224a:	6406                	ld	s0,64(sp)
    8000224c:	74e2                	ld	s1,56(sp)
    8000224e:	6161                	addi	sp,sp,80
    80002250:	8082                	ret
    brelse(bp);
    80002252:	854a                	mv	a0,s2
    80002254:	e1dff0ef          	jal	80002070 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80002258:	015c0abb          	addw	s5,s8,s5
    8000225c:	004b2783          	lw	a5,4(s6)
    80002260:	04faf863          	bgeu	s5,a5,800022b0 <balloc+0xe8>
    bp = bread(dev, BBLOCK(b, sb));
    80002264:	40dad59b          	sraiw	a1,s5,0xd
    80002268:	01cb2783          	lw	a5,28(s6)
    8000226c:	9dbd                	addw	a1,a1,a5
    8000226e:	855e                	mv	a0,s7
    80002270:	cf9ff0ef          	jal	80001f68 <bread>
    80002274:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002276:	004b2503          	lw	a0,4(s6)
    8000227a:	84d6                	mv	s1,s5
    8000227c:	4701                	li	a4,0
    8000227e:	fca4fae3          	bgeu	s1,a0,80002252 <balloc+0x8a>
      m = 1 << (bi % 8);
    80002282:	00777693          	andi	a3,a4,7
    80002286:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    8000228a:	41f7579b          	sraiw	a5,a4,0x1f
    8000228e:	01d7d79b          	srliw	a5,a5,0x1d
    80002292:	9fb9                	addw	a5,a5,a4
    80002294:	4037d79b          	sraiw	a5,a5,0x3
    80002298:	00f90633          	add	a2,s2,a5
    8000229c:	05864603          	lbu	a2,88(a2)
    800022a0:	00c6f5b3          	and	a1,a3,a2
    800022a4:	ddb1                	beqz	a1,80002200 <balloc+0x38>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800022a6:	2705                	addiw	a4,a4,1
    800022a8:	2485                	addiw	s1,s1,1
    800022aa:	fd471ae3          	bne	a4,s4,8000227e <balloc+0xb6>
    800022ae:	b755                	j	80002252 <balloc+0x8a>
    800022b0:	7942                	ld	s2,48(sp)
    800022b2:	79a2                	ld	s3,40(sp)
    800022b4:	7a02                	ld	s4,32(sp)
    800022b6:	6ae2                	ld	s5,24(sp)
    800022b8:	6b42                	ld	s6,16(sp)
    800022ba:	6ba2                	ld	s7,8(sp)
    800022bc:	6c02                	ld	s8,0(sp)
  printf("balloc: out of blocks\n");
    800022be:	00005517          	auipc	a0,0x5
    800022c2:	0c250513          	addi	a0,a0,194 # 80007380 <etext+0x380>
    800022c6:	757020ef          	jal	8000521c <printf>
  return 0;
    800022ca:	4481                	li	s1,0
    800022cc:	bfad                	j	80002246 <balloc+0x7e>

00000000800022ce <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    800022ce:	7179                	addi	sp,sp,-48
    800022d0:	f406                	sd	ra,40(sp)
    800022d2:	f022                	sd	s0,32(sp)
    800022d4:	ec26                	sd	s1,24(sp)
    800022d6:	e84a                	sd	s2,16(sp)
    800022d8:	e44e                	sd	s3,8(sp)
    800022da:	1800                	addi	s0,sp,48
    800022dc:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800022de:	47ad                	li	a5,11
    800022e0:	02b7e363          	bltu	a5,a1,80002306 <bmap+0x38>
    if((addr = ip->addrs[bn]) == 0){
    800022e4:	02059793          	slli	a5,a1,0x20
    800022e8:	01e7d593          	srli	a1,a5,0x1e
    800022ec:	00b509b3          	add	s3,a0,a1
    800022f0:	0509a483          	lw	s1,80(s3)
    800022f4:	e0b5                	bnez	s1,80002358 <bmap+0x8a>
      addr = balloc(ip->dev);
    800022f6:	4108                	lw	a0,0(a0)
    800022f8:	ed1ff0ef          	jal	800021c8 <balloc>
    800022fc:	84aa                	mv	s1,a0
      if(addr == 0)
    800022fe:	cd29                	beqz	a0,80002358 <bmap+0x8a>
        return 0;
      ip->addrs[bn] = addr;
    80002300:	04a9a823          	sw	a0,80(s3)
    80002304:	a891                	j	80002358 <bmap+0x8a>
    }
    return addr;
  }
  bn -= NDIRECT;
    80002306:	ff45879b          	addiw	a5,a1,-12
    8000230a:	873e                	mv	a4,a5
    8000230c:	89be                	mv	s3,a5

  if(bn < NINDIRECT){
    8000230e:	0ff00793          	li	a5,255
    80002312:	06e7e763          	bltu	a5,a4,80002380 <bmap+0xb2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    80002316:	08052483          	lw	s1,128(a0)
    8000231a:	e891                	bnez	s1,8000232e <bmap+0x60>
      addr = balloc(ip->dev);
    8000231c:	4108                	lw	a0,0(a0)
    8000231e:	eabff0ef          	jal	800021c8 <balloc>
    80002322:	84aa                	mv	s1,a0
      if(addr == 0)
    80002324:	c915                	beqz	a0,80002358 <bmap+0x8a>
    80002326:	e052                	sd	s4,0(sp)
        return 0;
      ip->addrs[NDIRECT] = addr;
    80002328:	08a92023          	sw	a0,128(s2)
    8000232c:	a011                	j	80002330 <bmap+0x62>
    8000232e:	e052                	sd	s4,0(sp)
    }
    bp = bread(ip->dev, addr);
    80002330:	85a6                	mv	a1,s1
    80002332:	00092503          	lw	a0,0(s2)
    80002336:	c33ff0ef          	jal	80001f68 <bread>
    8000233a:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    8000233c:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80002340:	02099713          	slli	a4,s3,0x20
    80002344:	01e75593          	srli	a1,a4,0x1e
    80002348:	97ae                	add	a5,a5,a1
    8000234a:	89be                	mv	s3,a5
    8000234c:	4384                	lw	s1,0(a5)
    8000234e:	cc89                	beqz	s1,80002368 <bmap+0x9a>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    80002350:	8552                	mv	a0,s4
    80002352:	d1fff0ef          	jal	80002070 <brelse>
    return addr;
    80002356:	6a02                	ld	s4,0(sp)
  }

  panic("bmap: out of range");
}
    80002358:	8526                	mv	a0,s1
    8000235a:	70a2                	ld	ra,40(sp)
    8000235c:	7402                	ld	s0,32(sp)
    8000235e:	64e2                	ld	s1,24(sp)
    80002360:	6942                	ld	s2,16(sp)
    80002362:	69a2                	ld	s3,8(sp)
    80002364:	6145                	addi	sp,sp,48
    80002366:	8082                	ret
      addr = balloc(ip->dev);
    80002368:	00092503          	lw	a0,0(s2)
    8000236c:	e5dff0ef          	jal	800021c8 <balloc>
    80002370:	84aa                	mv	s1,a0
      if(addr){
    80002372:	dd79                	beqz	a0,80002350 <bmap+0x82>
        a[bn] = addr;
    80002374:	00a9a023          	sw	a0,0(s3)
        log_write(bp);
    80002378:	8552                	mv	a0,s4
    8000237a:	63f000ef          	jal	800031b8 <log_write>
    8000237e:	bfc9                	j	80002350 <bmap+0x82>
    80002380:	e052                	sd	s4,0(sp)
  panic("bmap: out of range");
    80002382:	00005517          	auipc	a0,0x5
    80002386:	01650513          	addi	a0,a0,22 # 80007398 <etext+0x398>
    8000238a:	1ca030ef          	jal	80005554 <panic>

000000008000238e <iget>:
{
    8000238e:	7179                	addi	sp,sp,-48
    80002390:	f406                	sd	ra,40(sp)
    80002392:	f022                	sd	s0,32(sp)
    80002394:	ec26                	sd	s1,24(sp)
    80002396:	e84a                	sd	s2,16(sp)
    80002398:	e44e                	sd	s3,8(sp)
    8000239a:	e052                	sd	s4,0(sp)
    8000239c:	1800                	addi	s0,sp,48
    8000239e:	89aa                	mv	s3,a0
    800023a0:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    800023a2:	00014517          	auipc	a0,0x14
    800023a6:	a0650513          	addi	a0,a0,-1530 # 80015da8 <itable>
    800023aa:	468030ef          	jal	80005812 <acquire>
  empty = 0;
    800023ae:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800023b0:	00014497          	auipc	s1,0x14
    800023b4:	a1048493          	addi	s1,s1,-1520 # 80015dc0 <itable+0x18>
    800023b8:	00015697          	auipc	a3,0x15
    800023bc:	49868693          	addi	a3,a3,1176 # 80017850 <log>
    800023c0:	a819                	j	800023d6 <iget+0x48>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800023c2:	0017b793          	seqz	a5,a5
    800023c6:	00193713          	seqz	a4,s2
    800023ca:	8ff9                	and	a5,a5,a4
    800023cc:	eb85                	bnez	a5,800023fc <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800023ce:	08848493          	addi	s1,s1,136
    800023d2:	02d48763          	beq	s1,a3,80002400 <iget+0x72>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    800023d6:	449c                	lw	a5,8(s1)
    800023d8:	fef055e3          	blez	a5,800023c2 <iget+0x34>
    800023dc:	4098                	lw	a4,0(s1)
    800023de:	ff3718e3          	bne	a4,s3,800023ce <iget+0x40>
    800023e2:	40d8                	lw	a4,4(s1)
    800023e4:	ff4715e3          	bne	a4,s4,800023ce <iget+0x40>
      ip->ref++;
    800023e8:	2785                	addiw	a5,a5,1
    800023ea:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    800023ec:	00014517          	auipc	a0,0x14
    800023f0:	9bc50513          	addi	a0,a0,-1604 # 80015da8 <itable>
    800023f4:	4ae030ef          	jal	800058a2 <release>
      return ip;
    800023f8:	8926                	mv	s2,s1
    800023fa:	a025                	j	80002422 <iget+0x94>
      empty = ip;
    800023fc:	8926                	mv	s2,s1
    800023fe:	bfc1                	j	800023ce <iget+0x40>
  if(empty == 0)
    80002400:	02090a63          	beqz	s2,80002434 <iget+0xa6>
  ip->dev = dev;
    80002404:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002408:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    8000240c:	4785                	li	a5,1
    8000240e:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002412:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80002416:	00014517          	auipc	a0,0x14
    8000241a:	99250513          	addi	a0,a0,-1646 # 80015da8 <itable>
    8000241e:	484030ef          	jal	800058a2 <release>
}
    80002422:	854a                	mv	a0,s2
    80002424:	70a2                	ld	ra,40(sp)
    80002426:	7402                	ld	s0,32(sp)
    80002428:	64e2                	ld	s1,24(sp)
    8000242a:	6942                	ld	s2,16(sp)
    8000242c:	69a2                	ld	s3,8(sp)
    8000242e:	6a02                	ld	s4,0(sp)
    80002430:	6145                	addi	sp,sp,48
    80002432:	8082                	ret
    panic("iget: no inodes");
    80002434:	00005517          	auipc	a0,0x5
    80002438:	f7c50513          	addi	a0,a0,-132 # 800073b0 <etext+0x3b0>
    8000243c:	118030ef          	jal	80005554 <panic>

0000000080002440 <iinit>:
{
    80002440:	7179                	addi	sp,sp,-48
    80002442:	f406                	sd	ra,40(sp)
    80002444:	f022                	sd	s0,32(sp)
    80002446:	ec26                	sd	s1,24(sp)
    80002448:	e84a                	sd	s2,16(sp)
    8000244a:	e44e                	sd	s3,8(sp)
    8000244c:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    8000244e:	00005597          	auipc	a1,0x5
    80002452:	f7258593          	addi	a1,a1,-142 # 800073c0 <etext+0x3c0>
    80002456:	00014517          	auipc	a0,0x14
    8000245a:	95250513          	addi	a0,a0,-1710 # 80015da8 <itable>
    8000245e:	32a030ef          	jal	80005788 <initlock>
  for(i = 0; i < NINODE; i++) {
    80002462:	00014497          	auipc	s1,0x14
    80002466:	96e48493          	addi	s1,s1,-1682 # 80015dd0 <itable+0x28>
    8000246a:	00015997          	auipc	s3,0x15
    8000246e:	3f698993          	addi	s3,s3,1014 # 80017860 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002472:	00005917          	auipc	s2,0x5
    80002476:	f5690913          	addi	s2,s2,-170 # 800073c8 <etext+0x3c8>
    8000247a:	85ca                	mv	a1,s2
    8000247c:	8526                	mv	a0,s1
    8000247e:	5fb000ef          	jal	80003278 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002482:	08848493          	addi	s1,s1,136
    80002486:	ff349ae3          	bne	s1,s3,8000247a <iinit+0x3a>
}
    8000248a:	70a2                	ld	ra,40(sp)
    8000248c:	7402                	ld	s0,32(sp)
    8000248e:	64e2                	ld	s1,24(sp)
    80002490:	6942                	ld	s2,16(sp)
    80002492:	69a2                	ld	s3,8(sp)
    80002494:	6145                	addi	sp,sp,48
    80002496:	8082                	ret

0000000080002498 <ialloc>:
{
    80002498:	7139                	addi	sp,sp,-64
    8000249a:	fc06                	sd	ra,56(sp)
    8000249c:	f822                	sd	s0,48(sp)
    8000249e:	0080                	addi	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    800024a0:	00014717          	auipc	a4,0x14
    800024a4:	8f472703          	lw	a4,-1804(a4) # 80015d94 <sb+0xc>
    800024a8:	4785                	li	a5,1
    800024aa:	06e7f063          	bgeu	a5,a4,8000250a <ialloc+0x72>
    800024ae:	f426                	sd	s1,40(sp)
    800024b0:	f04a                	sd	s2,32(sp)
    800024b2:	ec4e                	sd	s3,24(sp)
    800024b4:	e852                	sd	s4,16(sp)
    800024b6:	e456                	sd	s5,8(sp)
    800024b8:	e05a                	sd	s6,0(sp)
    800024ba:	8aaa                	mv	s5,a0
    800024bc:	8b2e                	mv	s6,a1
    800024be:	893e                	mv	s2,a5
    bp = bread(dev, IBLOCK(inum, sb));
    800024c0:	00014a17          	auipc	s4,0x14
    800024c4:	8c8a0a13          	addi	s4,s4,-1848 # 80015d88 <sb>
    800024c8:	00495593          	srli	a1,s2,0x4
    800024cc:	018a2783          	lw	a5,24(s4)
    800024d0:	9dbd                	addw	a1,a1,a5
    800024d2:	8556                	mv	a0,s5
    800024d4:	a95ff0ef          	jal	80001f68 <bread>
    800024d8:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    800024da:	05850993          	addi	s3,a0,88
    800024de:	00f97793          	andi	a5,s2,15
    800024e2:	079a                	slli	a5,a5,0x6
    800024e4:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    800024e6:	00099783          	lh	a5,0(s3)
    800024ea:	cb9d                	beqz	a5,80002520 <ialloc+0x88>
    brelse(bp);
    800024ec:	b85ff0ef          	jal	80002070 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    800024f0:	0905                	addi	s2,s2,1
    800024f2:	00ca2703          	lw	a4,12(s4)
    800024f6:	0009079b          	sext.w	a5,s2
    800024fa:	fce7e7e3          	bltu	a5,a4,800024c8 <ialloc+0x30>
    800024fe:	74a2                	ld	s1,40(sp)
    80002500:	7902                	ld	s2,32(sp)
    80002502:	69e2                	ld	s3,24(sp)
    80002504:	6a42                	ld	s4,16(sp)
    80002506:	6aa2                	ld	s5,8(sp)
    80002508:	6b02                	ld	s6,0(sp)
  printf("ialloc: no inodes\n");
    8000250a:	00005517          	auipc	a0,0x5
    8000250e:	ec650513          	addi	a0,a0,-314 # 800073d0 <etext+0x3d0>
    80002512:	50b020ef          	jal	8000521c <printf>
  return 0;
    80002516:	4501                	li	a0,0
}
    80002518:	70e2                	ld	ra,56(sp)
    8000251a:	7442                	ld	s0,48(sp)
    8000251c:	6121                	addi	sp,sp,64
    8000251e:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    80002520:	04000613          	li	a2,64
    80002524:	4581                	li	a1,0
    80002526:	854e                	mv	a0,s3
    80002528:	c37fd0ef          	jal	8000015e <memset>
      dip->type = type;
    8000252c:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80002530:	8526                	mv	a0,s1
    80002532:	487000ef          	jal	800031b8 <log_write>
      brelse(bp);
    80002536:	8526                	mv	a0,s1
    80002538:	b39ff0ef          	jal	80002070 <brelse>
      return iget(dev, inum);
    8000253c:	0009059b          	sext.w	a1,s2
    80002540:	8556                	mv	a0,s5
    80002542:	e4dff0ef          	jal	8000238e <iget>
    80002546:	74a2                	ld	s1,40(sp)
    80002548:	7902                	ld	s2,32(sp)
    8000254a:	69e2                	ld	s3,24(sp)
    8000254c:	6a42                	ld	s4,16(sp)
    8000254e:	6aa2                	ld	s5,8(sp)
    80002550:	6b02                	ld	s6,0(sp)
    80002552:	b7d9                	j	80002518 <ialloc+0x80>

0000000080002554 <iupdate>:
{
    80002554:	1101                	addi	sp,sp,-32
    80002556:	ec06                	sd	ra,24(sp)
    80002558:	e822                	sd	s0,16(sp)
    8000255a:	e426                	sd	s1,8(sp)
    8000255c:	e04a                	sd	s2,0(sp)
    8000255e:	1000                	addi	s0,sp,32
    80002560:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002562:	415c                	lw	a5,4(a0)
    80002564:	0047d79b          	srliw	a5,a5,0x4
    80002568:	00014597          	auipc	a1,0x14
    8000256c:	8385a583          	lw	a1,-1992(a1) # 80015da0 <sb+0x18>
    80002570:	9dbd                	addw	a1,a1,a5
    80002572:	4108                	lw	a0,0(a0)
    80002574:	9f5ff0ef          	jal	80001f68 <bread>
    80002578:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    8000257a:	05850793          	addi	a5,a0,88
    8000257e:	40d8                	lw	a4,4(s1)
    80002580:	8b3d                	andi	a4,a4,15
    80002582:	071a                	slli	a4,a4,0x6
    80002584:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80002586:	04449703          	lh	a4,68(s1)
    8000258a:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    8000258e:	04649703          	lh	a4,70(s1)
    80002592:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002596:	04849703          	lh	a4,72(s1)
    8000259a:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    8000259e:	04a49703          	lh	a4,74(s1)
    800025a2:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    800025a6:	44f8                	lw	a4,76(s1)
    800025a8:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    800025aa:	03400613          	li	a2,52
    800025ae:	05048593          	addi	a1,s1,80
    800025b2:	00c78513          	addi	a0,a5,12
    800025b6:	c05fd0ef          	jal	800001ba <memmove>
  log_write(bp);
    800025ba:	854a                	mv	a0,s2
    800025bc:	3fd000ef          	jal	800031b8 <log_write>
  brelse(bp);
    800025c0:	854a                	mv	a0,s2
    800025c2:	aafff0ef          	jal	80002070 <brelse>
}
    800025c6:	60e2                	ld	ra,24(sp)
    800025c8:	6442                	ld	s0,16(sp)
    800025ca:	64a2                	ld	s1,8(sp)
    800025cc:	6902                	ld	s2,0(sp)
    800025ce:	6105                	addi	sp,sp,32
    800025d0:	8082                	ret

00000000800025d2 <idup>:
{
    800025d2:	1101                	addi	sp,sp,-32
    800025d4:	ec06                	sd	ra,24(sp)
    800025d6:	e822                	sd	s0,16(sp)
    800025d8:	e426                	sd	s1,8(sp)
    800025da:	1000                	addi	s0,sp,32
    800025dc:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    800025de:	00013517          	auipc	a0,0x13
    800025e2:	7ca50513          	addi	a0,a0,1994 # 80015da8 <itable>
    800025e6:	22c030ef          	jal	80005812 <acquire>
  ip->ref++;
    800025ea:	449c                	lw	a5,8(s1)
    800025ec:	2785                	addiw	a5,a5,1
    800025ee:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    800025f0:	00013517          	auipc	a0,0x13
    800025f4:	7b850513          	addi	a0,a0,1976 # 80015da8 <itable>
    800025f8:	2aa030ef          	jal	800058a2 <release>
}
    800025fc:	8526                	mv	a0,s1
    800025fe:	60e2                	ld	ra,24(sp)
    80002600:	6442                	ld	s0,16(sp)
    80002602:	64a2                	ld	s1,8(sp)
    80002604:	6105                	addi	sp,sp,32
    80002606:	8082                	ret

0000000080002608 <ilock>:
{
    80002608:	1101                	addi	sp,sp,-32
    8000260a:	ec06                	sd	ra,24(sp)
    8000260c:	e822                	sd	s0,16(sp)
    8000260e:	e426                	sd	s1,8(sp)
    80002610:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002612:	cd19                	beqz	a0,80002630 <ilock+0x28>
    80002614:	84aa                	mv	s1,a0
    80002616:	451c                	lw	a5,8(a0)
    80002618:	00f05c63          	blez	a5,80002630 <ilock+0x28>
  acquiresleep(&ip->lock);
    8000261c:	0541                	addi	a0,a0,16
    8000261e:	491000ef          	jal	800032ae <acquiresleep>
  if(ip->valid == 0){
    80002622:	40bc                	lw	a5,64(s1)
    80002624:	cf89                	beqz	a5,8000263e <ilock+0x36>
}
    80002626:	60e2                	ld	ra,24(sp)
    80002628:	6442                	ld	s0,16(sp)
    8000262a:	64a2                	ld	s1,8(sp)
    8000262c:	6105                	addi	sp,sp,32
    8000262e:	8082                	ret
    80002630:	e04a                	sd	s2,0(sp)
    panic("ilock");
    80002632:	00005517          	auipc	a0,0x5
    80002636:	db650513          	addi	a0,a0,-586 # 800073e8 <etext+0x3e8>
    8000263a:	71b020ef          	jal	80005554 <panic>
    8000263e:	e04a                	sd	s2,0(sp)
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002640:	40dc                	lw	a5,4(s1)
    80002642:	0047d79b          	srliw	a5,a5,0x4
    80002646:	00013597          	auipc	a1,0x13
    8000264a:	75a5a583          	lw	a1,1882(a1) # 80015da0 <sb+0x18>
    8000264e:	9dbd                	addw	a1,a1,a5
    80002650:	4088                	lw	a0,0(s1)
    80002652:	917ff0ef          	jal	80001f68 <bread>
    80002656:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002658:	05850593          	addi	a1,a0,88
    8000265c:	40dc                	lw	a5,4(s1)
    8000265e:	8bbd                	andi	a5,a5,15
    80002660:	079a                	slli	a5,a5,0x6
    80002662:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002664:	00059783          	lh	a5,0(a1)
    80002668:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    8000266c:	00259783          	lh	a5,2(a1)
    80002670:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002674:	00459783          	lh	a5,4(a1)
    80002678:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    8000267c:	00659783          	lh	a5,6(a1)
    80002680:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002684:	459c                	lw	a5,8(a1)
    80002686:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002688:	03400613          	li	a2,52
    8000268c:	05b1                	addi	a1,a1,12
    8000268e:	05048513          	addi	a0,s1,80
    80002692:	b29fd0ef          	jal	800001ba <memmove>
    brelse(bp);
    80002696:	854a                	mv	a0,s2
    80002698:	9d9ff0ef          	jal	80002070 <brelse>
    ip->valid = 1;
    8000269c:	4785                	li	a5,1
    8000269e:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    800026a0:	04449783          	lh	a5,68(s1)
    800026a4:	c399                	beqz	a5,800026aa <ilock+0xa2>
    800026a6:	6902                	ld	s2,0(sp)
    800026a8:	bfbd                	j	80002626 <ilock+0x1e>
      panic("ilock: no type");
    800026aa:	00005517          	auipc	a0,0x5
    800026ae:	d4650513          	addi	a0,a0,-698 # 800073f0 <etext+0x3f0>
    800026b2:	6a3020ef          	jal	80005554 <panic>

00000000800026b6 <iunlock>:
{
    800026b6:	1101                	addi	sp,sp,-32
    800026b8:	ec06                	sd	ra,24(sp)
    800026ba:	e822                	sd	s0,16(sp)
    800026bc:	e426                	sd	s1,8(sp)
    800026be:	e04a                	sd	s2,0(sp)
    800026c0:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    800026c2:	c505                	beqz	a0,800026ea <iunlock+0x34>
    800026c4:	84aa                	mv	s1,a0
    800026c6:	01050913          	addi	s2,a0,16
    800026ca:	854a                	mv	a0,s2
    800026cc:	461000ef          	jal	8000332c <holdingsleep>
    800026d0:	cd09                	beqz	a0,800026ea <iunlock+0x34>
    800026d2:	449c                	lw	a5,8(s1)
    800026d4:	00f05b63          	blez	a5,800026ea <iunlock+0x34>
  releasesleep(&ip->lock);
    800026d8:	854a                	mv	a0,s2
    800026da:	41b000ef          	jal	800032f4 <releasesleep>
}
    800026de:	60e2                	ld	ra,24(sp)
    800026e0:	6442                	ld	s0,16(sp)
    800026e2:	64a2                	ld	s1,8(sp)
    800026e4:	6902                	ld	s2,0(sp)
    800026e6:	6105                	addi	sp,sp,32
    800026e8:	8082                	ret
    panic("iunlock");
    800026ea:	00005517          	auipc	a0,0x5
    800026ee:	d1650513          	addi	a0,a0,-746 # 80007400 <etext+0x400>
    800026f2:	663020ef          	jal	80005554 <panic>

00000000800026f6 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    800026f6:	7179                	addi	sp,sp,-48
    800026f8:	f406                	sd	ra,40(sp)
    800026fa:	f022                	sd	s0,32(sp)
    800026fc:	ec26                	sd	s1,24(sp)
    800026fe:	e84a                	sd	s2,16(sp)
    80002700:	e44e                	sd	s3,8(sp)
    80002702:	1800                	addi	s0,sp,48
    80002704:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002706:	05050493          	addi	s1,a0,80
    8000270a:	08050913          	addi	s2,a0,128
    8000270e:	a021                	j	80002716 <itrunc+0x20>
    80002710:	0491                	addi	s1,s1,4
    80002712:	01248b63          	beq	s1,s2,80002728 <itrunc+0x32>
    if(ip->addrs[i]){
    80002716:	408c                	lw	a1,0(s1)
    80002718:	dde5                	beqz	a1,80002710 <itrunc+0x1a>
      bfree(ip->dev, ip->addrs[i]);
    8000271a:	0009a503          	lw	a0,0(s3)
    8000271e:	a3fff0ef          	jal	8000215c <bfree>
      ip->addrs[i] = 0;
    80002722:	0004a023          	sw	zero,0(s1)
    80002726:	b7ed                	j	80002710 <itrunc+0x1a>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002728:	0809a583          	lw	a1,128(s3)
    8000272c:	ed89                	bnez	a1,80002746 <itrunc+0x50>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    8000272e:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002732:	854e                	mv	a0,s3
    80002734:	e21ff0ef          	jal	80002554 <iupdate>
}
    80002738:	70a2                	ld	ra,40(sp)
    8000273a:	7402                	ld	s0,32(sp)
    8000273c:	64e2                	ld	s1,24(sp)
    8000273e:	6942                	ld	s2,16(sp)
    80002740:	69a2                	ld	s3,8(sp)
    80002742:	6145                	addi	sp,sp,48
    80002744:	8082                	ret
    80002746:	e052                	sd	s4,0(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002748:	0009a503          	lw	a0,0(s3)
    8000274c:	81dff0ef          	jal	80001f68 <bread>
    80002750:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002752:	05850493          	addi	s1,a0,88
    80002756:	45850913          	addi	s2,a0,1112
    8000275a:	a021                	j	80002762 <itrunc+0x6c>
    8000275c:	0491                	addi	s1,s1,4
    8000275e:	01248963          	beq	s1,s2,80002770 <itrunc+0x7a>
      if(a[j])
    80002762:	408c                	lw	a1,0(s1)
    80002764:	dde5                	beqz	a1,8000275c <itrunc+0x66>
        bfree(ip->dev, a[j]);
    80002766:	0009a503          	lw	a0,0(s3)
    8000276a:	9f3ff0ef          	jal	8000215c <bfree>
    8000276e:	b7fd                	j	8000275c <itrunc+0x66>
    brelse(bp);
    80002770:	8552                	mv	a0,s4
    80002772:	8ffff0ef          	jal	80002070 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002776:	0809a583          	lw	a1,128(s3)
    8000277a:	0009a503          	lw	a0,0(s3)
    8000277e:	9dfff0ef          	jal	8000215c <bfree>
    ip->addrs[NDIRECT] = 0;
    80002782:	0809a023          	sw	zero,128(s3)
    80002786:	6a02                	ld	s4,0(sp)
    80002788:	b75d                	j	8000272e <itrunc+0x38>

000000008000278a <iput>:
{
    8000278a:	1101                	addi	sp,sp,-32
    8000278c:	ec06                	sd	ra,24(sp)
    8000278e:	e822                	sd	s0,16(sp)
    80002790:	e426                	sd	s1,8(sp)
    80002792:	1000                	addi	s0,sp,32
    80002794:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002796:	00013517          	auipc	a0,0x13
    8000279a:	61250513          	addi	a0,a0,1554 # 80015da8 <itable>
    8000279e:	074030ef          	jal	80005812 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    800027a2:	4498                	lw	a4,8(s1)
    800027a4:	4785                	li	a5,1
    800027a6:	02f70063          	beq	a4,a5,800027c6 <iput+0x3c>
  ip->ref--;
    800027aa:	449c                	lw	a5,8(s1)
    800027ac:	37fd                	addiw	a5,a5,-1
    800027ae:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    800027b0:	00013517          	auipc	a0,0x13
    800027b4:	5f850513          	addi	a0,a0,1528 # 80015da8 <itable>
    800027b8:	0ea030ef          	jal	800058a2 <release>
}
    800027bc:	60e2                	ld	ra,24(sp)
    800027be:	6442                	ld	s0,16(sp)
    800027c0:	64a2                	ld	s1,8(sp)
    800027c2:	6105                	addi	sp,sp,32
    800027c4:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    800027c6:	40bc                	lw	a5,64(s1)
    800027c8:	d3ed                	beqz	a5,800027aa <iput+0x20>
    800027ca:	04a49783          	lh	a5,74(s1)
    800027ce:	fff1                	bnez	a5,800027aa <iput+0x20>
    800027d0:	e04a                	sd	s2,0(sp)
    acquiresleep(&ip->lock);
    800027d2:	01048793          	addi	a5,s1,16
    800027d6:	893e                	mv	s2,a5
    800027d8:	853e                	mv	a0,a5
    800027da:	2d5000ef          	jal	800032ae <acquiresleep>
    release(&itable.lock);
    800027de:	00013517          	auipc	a0,0x13
    800027e2:	5ca50513          	addi	a0,a0,1482 # 80015da8 <itable>
    800027e6:	0bc030ef          	jal	800058a2 <release>
    itrunc(ip);
    800027ea:	8526                	mv	a0,s1
    800027ec:	f0bff0ef          	jal	800026f6 <itrunc>
    ip->type = 0;
    800027f0:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    800027f4:	8526                	mv	a0,s1
    800027f6:	d5fff0ef          	jal	80002554 <iupdate>
    ip->valid = 0;
    800027fa:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    800027fe:	854a                	mv	a0,s2
    80002800:	2f5000ef          	jal	800032f4 <releasesleep>
    acquire(&itable.lock);
    80002804:	00013517          	auipc	a0,0x13
    80002808:	5a450513          	addi	a0,a0,1444 # 80015da8 <itable>
    8000280c:	006030ef          	jal	80005812 <acquire>
    80002810:	6902                	ld	s2,0(sp)
    80002812:	bf61                	j	800027aa <iput+0x20>

0000000080002814 <iunlockput>:
{
    80002814:	1101                	addi	sp,sp,-32
    80002816:	ec06                	sd	ra,24(sp)
    80002818:	e822                	sd	s0,16(sp)
    8000281a:	e426                	sd	s1,8(sp)
    8000281c:	1000                	addi	s0,sp,32
    8000281e:	84aa                	mv	s1,a0
  iunlock(ip);
    80002820:	e97ff0ef          	jal	800026b6 <iunlock>
  iput(ip);
    80002824:	8526                	mv	a0,s1
    80002826:	f65ff0ef          	jal	8000278a <iput>
}
    8000282a:	60e2                	ld	ra,24(sp)
    8000282c:	6442                	ld	s0,16(sp)
    8000282e:	64a2                	ld	s1,8(sp)
    80002830:	6105                	addi	sp,sp,32
    80002832:	8082                	ret

0000000080002834 <ireclaim>:
  for (int inum = 1; inum < sb.ninodes; inum++) {
    80002834:	00013717          	auipc	a4,0x13
    80002838:	56072703          	lw	a4,1376(a4) # 80015d94 <sb+0xc>
    8000283c:	4785                	li	a5,1
    8000283e:	0ae7fe63          	bgeu	a5,a4,800028fa <ireclaim+0xc6>
{
    80002842:	7139                	addi	sp,sp,-64
    80002844:	fc06                	sd	ra,56(sp)
    80002846:	f822                	sd	s0,48(sp)
    80002848:	f426                	sd	s1,40(sp)
    8000284a:	f04a                	sd	s2,32(sp)
    8000284c:	ec4e                	sd	s3,24(sp)
    8000284e:	e852                	sd	s4,16(sp)
    80002850:	e456                	sd	s5,8(sp)
    80002852:	e05a                	sd	s6,0(sp)
    80002854:	0080                	addi	s0,sp,64
    80002856:	8aaa                	mv	s5,a0
  for (int inum = 1; inum < sb.ninodes; inum++) {
    80002858:	84be                	mv	s1,a5
    struct buf *bp = bread(dev, IBLOCK(inum, sb));
    8000285a:	00013a17          	auipc	s4,0x13
    8000285e:	52ea0a13          	addi	s4,s4,1326 # 80015d88 <sb>
      printf("ireclaim: orphaned inode %d\n", inum);
    80002862:	00005b17          	auipc	s6,0x5
    80002866:	ba6b0b13          	addi	s6,s6,-1114 # 80007408 <etext+0x408>
    8000286a:	a099                	j	800028b0 <ireclaim+0x7c>
    8000286c:	85ce                	mv	a1,s3
    8000286e:	855a                	mv	a0,s6
    80002870:	1ad020ef          	jal	8000521c <printf>
      ip = iget(dev, inum);
    80002874:	85ce                	mv	a1,s3
    80002876:	8556                	mv	a0,s5
    80002878:	b17ff0ef          	jal	8000238e <iget>
    8000287c:	89aa                	mv	s3,a0
    brelse(bp);
    8000287e:	854a                	mv	a0,s2
    80002880:	ff0ff0ef          	jal	80002070 <brelse>
    if (ip) {
    80002884:	00098f63          	beqz	s3,800028a2 <ireclaim+0x6e>
      begin_op();
    80002888:	796000ef          	jal	8000301e <begin_op>
      ilock(ip);
    8000288c:	854e                	mv	a0,s3
    8000288e:	d7bff0ef          	jal	80002608 <ilock>
      iunlock(ip);
    80002892:	854e                	mv	a0,s3
    80002894:	e23ff0ef          	jal	800026b6 <iunlock>
      iput(ip);
    80002898:	854e                	mv	a0,s3
    8000289a:	ef1ff0ef          	jal	8000278a <iput>
      end_op();
    8000289e:	7f0000ef          	jal	8000308e <end_op>
  for (int inum = 1; inum < sb.ninodes; inum++) {
    800028a2:	0485                	addi	s1,s1,1
    800028a4:	00ca2703          	lw	a4,12(s4)
    800028a8:	0004879b          	sext.w	a5,s1
    800028ac:	02e7fd63          	bgeu	a5,a4,800028e6 <ireclaim+0xb2>
    800028b0:	0004899b          	sext.w	s3,s1
    struct buf *bp = bread(dev, IBLOCK(inum, sb));
    800028b4:	0044d593          	srli	a1,s1,0x4
    800028b8:	018a2783          	lw	a5,24(s4)
    800028bc:	9dbd                	addw	a1,a1,a5
    800028be:	8556                	mv	a0,s5
    800028c0:	ea8ff0ef          	jal	80001f68 <bread>
    800028c4:	892a                	mv	s2,a0
    struct dinode *dip = (struct dinode *)bp->data + inum % IPB;
    800028c6:	05850793          	addi	a5,a0,88
    800028ca:	00f9f713          	andi	a4,s3,15
    800028ce:	071a                	slli	a4,a4,0x6
    800028d0:	97ba                	add	a5,a5,a4
    if (dip->type != 0 && dip->nlink == 0) {  // is an orphaned inode
    800028d2:	00079703          	lh	a4,0(a5)
    800028d6:	c701                	beqz	a4,800028de <ireclaim+0xaa>
    800028d8:	00679783          	lh	a5,6(a5)
    800028dc:	dbc1                	beqz	a5,8000286c <ireclaim+0x38>
    brelse(bp);
    800028de:	854a                	mv	a0,s2
    800028e0:	f90ff0ef          	jal	80002070 <brelse>
    if (ip) {
    800028e4:	bf7d                	j	800028a2 <ireclaim+0x6e>
}
    800028e6:	70e2                	ld	ra,56(sp)
    800028e8:	7442                	ld	s0,48(sp)
    800028ea:	74a2                	ld	s1,40(sp)
    800028ec:	7902                	ld	s2,32(sp)
    800028ee:	69e2                	ld	s3,24(sp)
    800028f0:	6a42                	ld	s4,16(sp)
    800028f2:	6aa2                	ld	s5,8(sp)
    800028f4:	6b02                	ld	s6,0(sp)
    800028f6:	6121                	addi	sp,sp,64
    800028f8:	8082                	ret
    800028fa:	8082                	ret

00000000800028fc <fsinit>:
fsinit(int dev) {
    800028fc:	1101                	addi	sp,sp,-32
    800028fe:	ec06                	sd	ra,24(sp)
    80002900:	e822                	sd	s0,16(sp)
    80002902:	e426                	sd	s1,8(sp)
    80002904:	e04a                	sd	s2,0(sp)
    80002906:	1000                	addi	s0,sp,32
    80002908:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    8000290a:	4585                	li	a1,1
    8000290c:	e5cff0ef          	jal	80001f68 <bread>
    80002910:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002912:	02000613          	li	a2,32
    80002916:	05850593          	addi	a1,a0,88
    8000291a:	00013517          	auipc	a0,0x13
    8000291e:	46e50513          	addi	a0,a0,1134 # 80015d88 <sb>
    80002922:	899fd0ef          	jal	800001ba <memmove>
  brelse(bp);
    80002926:	8526                	mv	a0,s1
    80002928:	f48ff0ef          	jal	80002070 <brelse>
  if(sb.magic != FSMAGIC)
    8000292c:	00013717          	auipc	a4,0x13
    80002930:	45c72703          	lw	a4,1116(a4) # 80015d88 <sb>
    80002934:	102037b7          	lui	a5,0x10203
    80002938:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    8000293c:	02f71263          	bne	a4,a5,80002960 <fsinit+0x64>
  initlog(dev, &sb);
    80002940:	00013597          	auipc	a1,0x13
    80002944:	44858593          	addi	a1,a1,1096 # 80015d88 <sb>
    80002948:	854a                	mv	a0,s2
    8000294a:	652000ef          	jal	80002f9c <initlog>
  ireclaim(dev);
    8000294e:	854a                	mv	a0,s2
    80002950:	ee5ff0ef          	jal	80002834 <ireclaim>
}
    80002954:	60e2                	ld	ra,24(sp)
    80002956:	6442                	ld	s0,16(sp)
    80002958:	64a2                	ld	s1,8(sp)
    8000295a:	6902                	ld	s2,0(sp)
    8000295c:	6105                	addi	sp,sp,32
    8000295e:	8082                	ret
    panic("invalid file system");
    80002960:	00005517          	auipc	a0,0x5
    80002964:	ac850513          	addi	a0,a0,-1336 # 80007428 <etext+0x428>
    80002968:	3ed020ef          	jal	80005554 <panic>

000000008000296c <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    8000296c:	1141                	addi	sp,sp,-16
    8000296e:	e406                	sd	ra,8(sp)
    80002970:	e022                	sd	s0,0(sp)
    80002972:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002974:	411c                	lw	a5,0(a0)
    80002976:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002978:	415c                	lw	a5,4(a0)
    8000297a:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    8000297c:	04451783          	lh	a5,68(a0)
    80002980:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002984:	04a51783          	lh	a5,74(a0)
    80002988:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    8000298c:	04c56783          	lwu	a5,76(a0)
    80002990:	e99c                	sd	a5,16(a1)
}
    80002992:	60a2                	ld	ra,8(sp)
    80002994:	6402                	ld	s0,0(sp)
    80002996:	0141                	addi	sp,sp,16
    80002998:	8082                	ret

000000008000299a <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    8000299a:	457c                	lw	a5,76(a0)
    8000299c:	0ed7e663          	bltu	a5,a3,80002a88 <readi+0xee>
{
    800029a0:	7159                	addi	sp,sp,-112
    800029a2:	f486                	sd	ra,104(sp)
    800029a4:	f0a2                	sd	s0,96(sp)
    800029a6:	eca6                	sd	s1,88(sp)
    800029a8:	e0d2                	sd	s4,64(sp)
    800029aa:	fc56                	sd	s5,56(sp)
    800029ac:	f85a                	sd	s6,48(sp)
    800029ae:	f45e                	sd	s7,40(sp)
    800029b0:	1880                	addi	s0,sp,112
    800029b2:	8b2a                	mv	s6,a0
    800029b4:	8bae                	mv	s7,a1
    800029b6:	8a32                	mv	s4,a2
    800029b8:	84b6                	mv	s1,a3
    800029ba:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    800029bc:	9f35                	addw	a4,a4,a3
    return 0;
    800029be:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    800029c0:	0ad76b63          	bltu	a4,a3,80002a76 <readi+0xdc>
    800029c4:	e4ce                	sd	s3,72(sp)
  if(off + n > ip->size)
    800029c6:	00e7f463          	bgeu	a5,a4,800029ce <readi+0x34>
    n = ip->size - off;
    800029ca:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800029ce:	080a8b63          	beqz	s5,80002a64 <readi+0xca>
    800029d2:	e8ca                	sd	s2,80(sp)
    800029d4:	f062                	sd	s8,32(sp)
    800029d6:	ec66                	sd	s9,24(sp)
    800029d8:	e86a                	sd	s10,16(sp)
    800029da:	e46e                	sd	s11,8(sp)
    800029dc:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    800029de:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    800029e2:	5c7d                	li	s8,-1
    800029e4:	a80d                	j	80002a16 <readi+0x7c>
    800029e6:	020d1d93          	slli	s11,s10,0x20
    800029ea:	020ddd93          	srli	s11,s11,0x20
    800029ee:	05890613          	addi	a2,s2,88
    800029f2:	86ee                	mv	a3,s11
    800029f4:	963e                	add	a2,a2,a5
    800029f6:	85d2                	mv	a1,s4
    800029f8:	855e                	mv	a0,s7
    800029fa:	ca7fe0ef          	jal	800016a0 <either_copyout>
    800029fe:	05850363          	beq	a0,s8,80002a44 <readi+0xaa>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002a02:	854a                	mv	a0,s2
    80002a04:	e6cff0ef          	jal	80002070 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002a08:	013d09bb          	addw	s3,s10,s3
    80002a0c:	009d04bb          	addw	s1,s10,s1
    80002a10:	9a6e                	add	s4,s4,s11
    80002a12:	0559f363          	bgeu	s3,s5,80002a58 <readi+0xbe>
    uint addr = bmap(ip, off/BSIZE);
    80002a16:	00a4d59b          	srliw	a1,s1,0xa
    80002a1a:	855a                	mv	a0,s6
    80002a1c:	8b3ff0ef          	jal	800022ce <bmap>
    80002a20:	85aa                	mv	a1,a0
    if(addr == 0)
    80002a22:	c139                	beqz	a0,80002a68 <readi+0xce>
    bp = bread(ip->dev, addr);
    80002a24:	000b2503          	lw	a0,0(s6)
    80002a28:	d40ff0ef          	jal	80001f68 <bread>
    80002a2c:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002a2e:	3ff4f793          	andi	a5,s1,1023
    80002a32:	40fc873b          	subw	a4,s9,a5
    80002a36:	413a86bb          	subw	a3,s5,s3
    80002a3a:	8d3a                	mv	s10,a4
    80002a3c:	fae6f5e3          	bgeu	a3,a4,800029e6 <readi+0x4c>
    80002a40:	8d36                	mv	s10,a3
    80002a42:	b755                	j	800029e6 <readi+0x4c>
      brelse(bp);
    80002a44:	854a                	mv	a0,s2
    80002a46:	e2aff0ef          	jal	80002070 <brelse>
      tot = -1;
    80002a4a:	59fd                	li	s3,-1
      break;
    80002a4c:	6946                	ld	s2,80(sp)
    80002a4e:	7c02                	ld	s8,32(sp)
    80002a50:	6ce2                	ld	s9,24(sp)
    80002a52:	6d42                	ld	s10,16(sp)
    80002a54:	6da2                	ld	s11,8(sp)
    80002a56:	a831                	j	80002a72 <readi+0xd8>
    80002a58:	6946                	ld	s2,80(sp)
    80002a5a:	7c02                	ld	s8,32(sp)
    80002a5c:	6ce2                	ld	s9,24(sp)
    80002a5e:	6d42                	ld	s10,16(sp)
    80002a60:	6da2                	ld	s11,8(sp)
    80002a62:	a801                	j	80002a72 <readi+0xd8>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002a64:	89d6                	mv	s3,s5
    80002a66:	a031                	j	80002a72 <readi+0xd8>
    80002a68:	6946                	ld	s2,80(sp)
    80002a6a:	7c02                	ld	s8,32(sp)
    80002a6c:	6ce2                	ld	s9,24(sp)
    80002a6e:	6d42                	ld	s10,16(sp)
    80002a70:	6da2                	ld	s11,8(sp)
  }
  return tot;
    80002a72:	854e                	mv	a0,s3
    80002a74:	69a6                	ld	s3,72(sp)
}
    80002a76:	70a6                	ld	ra,104(sp)
    80002a78:	7406                	ld	s0,96(sp)
    80002a7a:	64e6                	ld	s1,88(sp)
    80002a7c:	6a06                	ld	s4,64(sp)
    80002a7e:	7ae2                	ld	s5,56(sp)
    80002a80:	7b42                	ld	s6,48(sp)
    80002a82:	7ba2                	ld	s7,40(sp)
    80002a84:	6165                	addi	sp,sp,112
    80002a86:	8082                	ret
    return 0;
    80002a88:	4501                	li	a0,0
}
    80002a8a:	8082                	ret

0000000080002a8c <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002a8c:	457c                	lw	a5,76(a0)
    80002a8e:	0ed7ee63          	bltu	a5,a3,80002b8a <writei+0xfe>
{
    80002a92:	7159                	addi	sp,sp,-112
    80002a94:	f486                	sd	ra,104(sp)
    80002a96:	f0a2                	sd	s0,96(sp)
    80002a98:	e8ca                	sd	s2,80(sp)
    80002a9a:	e0d2                	sd	s4,64(sp)
    80002a9c:	fc56                	sd	s5,56(sp)
    80002a9e:	f85a                	sd	s6,48(sp)
    80002aa0:	f45e                	sd	s7,40(sp)
    80002aa2:	1880                	addi	s0,sp,112
    80002aa4:	8aaa                	mv	s5,a0
    80002aa6:	8bae                	mv	s7,a1
    80002aa8:	8a32                	mv	s4,a2
    80002aaa:	8936                	mv	s2,a3
    80002aac:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002aae:	9f35                	addw	a4,a4,a3
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80002ab0:	000437b7          	lui	a5,0x43
    80002ab4:	00e7b7b3          	sltu	a5,a5,a4
  if(off > ip->size || off + n < off)
    80002ab8:	00d73733          	sltu	a4,a4,a3
  if(off + n > MAXFILE*BSIZE)
    80002abc:	8fd9                	or	a5,a5,a4
    80002abe:	ef91                	bnez	a5,80002ada <writei+0x4e>
    80002ac0:	e4ce                	sd	s3,72(sp)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002ac2:	0a0b0c63          	beqz	s6,80002b7a <writei+0xee>
    80002ac6:	eca6                	sd	s1,88(sp)
    80002ac8:	f062                	sd	s8,32(sp)
    80002aca:	ec66                	sd	s9,24(sp)
    80002acc:	e86a                	sd	s10,16(sp)
    80002ace:	e46e                	sd	s11,8(sp)
    80002ad0:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002ad2:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002ad6:	5c7d                	li	s8,-1
    80002ad8:	a835                	j	80002b14 <writei+0x88>
    return -1;
    80002ada:	557d                	li	a0,-1
    80002adc:	a071                	j	80002b68 <writei+0xdc>
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002ade:	020d1d93          	slli	s11,s10,0x20
    80002ae2:	020ddd93          	srli	s11,s11,0x20
    80002ae6:	05848513          	addi	a0,s1,88
    80002aea:	86ee                	mv	a3,s11
    80002aec:	8652                	mv	a2,s4
    80002aee:	85de                	mv	a1,s7
    80002af0:	953e                	add	a0,a0,a5
    80002af2:	bf9fe0ef          	jal	800016ea <either_copyin>
    80002af6:	05850663          	beq	a0,s8,80002b42 <writei+0xb6>
      brelse(bp);
      break;
    }
    log_write(bp);
    80002afa:	8526                	mv	a0,s1
    80002afc:	6bc000ef          	jal	800031b8 <log_write>
    brelse(bp);
    80002b00:	8526                	mv	a0,s1
    80002b02:	d6eff0ef          	jal	80002070 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002b06:	013d09bb          	addw	s3,s10,s3
    80002b0a:	012d093b          	addw	s2,s10,s2
    80002b0e:	9a6e                	add	s4,s4,s11
    80002b10:	0369fc63          	bgeu	s3,s6,80002b48 <writei+0xbc>
    uint addr = bmap(ip, off/BSIZE);
    80002b14:	00a9559b          	srliw	a1,s2,0xa
    80002b18:	8556                	mv	a0,s5
    80002b1a:	fb4ff0ef          	jal	800022ce <bmap>
    80002b1e:	85aa                	mv	a1,a0
    if(addr == 0)
    80002b20:	c505                	beqz	a0,80002b48 <writei+0xbc>
    bp = bread(ip->dev, addr);
    80002b22:	000aa503          	lw	a0,0(s5)
    80002b26:	c42ff0ef          	jal	80001f68 <bread>
    80002b2a:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002b2c:	3ff97793          	andi	a5,s2,1023
    80002b30:	40fc873b          	subw	a4,s9,a5
    80002b34:	413b06bb          	subw	a3,s6,s3
    80002b38:	8d3a                	mv	s10,a4
    80002b3a:	fae6f2e3          	bgeu	a3,a4,80002ade <writei+0x52>
    80002b3e:	8d36                	mv	s10,a3
    80002b40:	bf79                	j	80002ade <writei+0x52>
      brelse(bp);
    80002b42:	8526                	mv	a0,s1
    80002b44:	d2cff0ef          	jal	80002070 <brelse>
  }

  if(off > ip->size)
    80002b48:	04caa783          	lw	a5,76(s5)
    80002b4c:	0327f963          	bgeu	a5,s2,80002b7e <writei+0xf2>
    ip->size = off;
    80002b50:	052aa623          	sw	s2,76(s5)
    80002b54:	64e6                	ld	s1,88(sp)
    80002b56:	7c02                	ld	s8,32(sp)
    80002b58:	6ce2                	ld	s9,24(sp)
    80002b5a:	6d42                	ld	s10,16(sp)
    80002b5c:	6da2                	ld	s11,8(sp)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80002b5e:	8556                	mv	a0,s5
    80002b60:	9f5ff0ef          	jal	80002554 <iupdate>

  return tot;
    80002b64:	854e                	mv	a0,s3
    80002b66:	69a6                	ld	s3,72(sp)
}
    80002b68:	70a6                	ld	ra,104(sp)
    80002b6a:	7406                	ld	s0,96(sp)
    80002b6c:	6946                	ld	s2,80(sp)
    80002b6e:	6a06                	ld	s4,64(sp)
    80002b70:	7ae2                	ld	s5,56(sp)
    80002b72:	7b42                	ld	s6,48(sp)
    80002b74:	7ba2                	ld	s7,40(sp)
    80002b76:	6165                	addi	sp,sp,112
    80002b78:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002b7a:	89da                	mv	s3,s6
    80002b7c:	b7cd                	j	80002b5e <writei+0xd2>
    80002b7e:	64e6                	ld	s1,88(sp)
    80002b80:	7c02                	ld	s8,32(sp)
    80002b82:	6ce2                	ld	s9,24(sp)
    80002b84:	6d42                	ld	s10,16(sp)
    80002b86:	6da2                	ld	s11,8(sp)
    80002b88:	bfd9                	j	80002b5e <writei+0xd2>
    return -1;
    80002b8a:	557d                	li	a0,-1
}
    80002b8c:	8082                	ret

0000000080002b8e <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80002b8e:	1141                	addi	sp,sp,-16
    80002b90:	e406                	sd	ra,8(sp)
    80002b92:	e022                	sd	s0,0(sp)
    80002b94:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80002b96:	4639                	li	a2,14
    80002b98:	e96fd0ef          	jal	8000022e <strncmp>
}
    80002b9c:	60a2                	ld	ra,8(sp)
    80002b9e:	6402                	ld	s0,0(sp)
    80002ba0:	0141                	addi	sp,sp,16
    80002ba2:	8082                	ret

0000000080002ba4 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80002ba4:	711d                	addi	sp,sp,-96
    80002ba6:	ec86                	sd	ra,88(sp)
    80002ba8:	e8a2                	sd	s0,80(sp)
    80002baa:	e4a6                	sd	s1,72(sp)
    80002bac:	e0ca                	sd	s2,64(sp)
    80002bae:	fc4e                	sd	s3,56(sp)
    80002bb0:	f852                	sd	s4,48(sp)
    80002bb2:	f456                	sd	s5,40(sp)
    80002bb4:	f05a                	sd	s6,32(sp)
    80002bb6:	ec5e                	sd	s7,24(sp)
    80002bb8:	1080                	addi	s0,sp,96
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80002bba:	04451703          	lh	a4,68(a0)
    80002bbe:	4785                	li	a5,1
    80002bc0:	02f71963          	bne	a4,a5,80002bf2 <dirlookup+0x4e>
    80002bc4:	892a                	mv	s2,a0
    80002bc6:	8aae                	mv	s5,a1
    80002bc8:	8bb2                	mv	s7,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80002bca:	457c                	lw	a5,76(a0)
    80002bcc:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002bce:	fa040a13          	addi	s4,s0,-96
    80002bd2:	49c1                	li	s3,16
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
    80002bd4:	fa240b13          	addi	s6,s0,-94
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002bd8:	ef95                	bnez	a5,80002c14 <dirlookup+0x70>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80002bda:	4501                	li	a0,0
}
    80002bdc:	60e6                	ld	ra,88(sp)
    80002bde:	6446                	ld	s0,80(sp)
    80002be0:	64a6                	ld	s1,72(sp)
    80002be2:	6906                	ld	s2,64(sp)
    80002be4:	79e2                	ld	s3,56(sp)
    80002be6:	7a42                	ld	s4,48(sp)
    80002be8:	7aa2                	ld	s5,40(sp)
    80002bea:	7b02                	ld	s6,32(sp)
    80002bec:	6be2                	ld	s7,24(sp)
    80002bee:	6125                	addi	sp,sp,96
    80002bf0:	8082                	ret
    panic("dirlookup not DIR");
    80002bf2:	00005517          	auipc	a0,0x5
    80002bf6:	84e50513          	addi	a0,a0,-1970 # 80007440 <etext+0x440>
    80002bfa:	15b020ef          	jal	80005554 <panic>
      panic("dirlookup read");
    80002bfe:	00005517          	auipc	a0,0x5
    80002c02:	85a50513          	addi	a0,a0,-1958 # 80007458 <etext+0x458>
    80002c06:	14f020ef          	jal	80005554 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002c0a:	24c1                	addiw	s1,s1,16
    80002c0c:	04c92783          	lw	a5,76(s2)
    80002c10:	fcf4f5e3          	bgeu	s1,a5,80002bda <dirlookup+0x36>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002c14:	874e                	mv	a4,s3
    80002c16:	86a6                	mv	a3,s1
    80002c18:	8652                	mv	a2,s4
    80002c1a:	4581                	li	a1,0
    80002c1c:	854a                	mv	a0,s2
    80002c1e:	d7dff0ef          	jal	8000299a <readi>
    80002c22:	fd351ee3          	bne	a0,s3,80002bfe <dirlookup+0x5a>
    if(de.inum == 0)
    80002c26:	fa045783          	lhu	a5,-96(s0)
    80002c2a:	d3e5                	beqz	a5,80002c0a <dirlookup+0x66>
    if(namecmp(name, de.name) == 0){
    80002c2c:	85da                	mv	a1,s6
    80002c2e:	8556                	mv	a0,s5
    80002c30:	f5fff0ef          	jal	80002b8e <namecmp>
    80002c34:	f979                	bnez	a0,80002c0a <dirlookup+0x66>
      if(poff)
    80002c36:	000b8463          	beqz	s7,80002c3e <dirlookup+0x9a>
        *poff = off;
    80002c3a:	009ba023          	sw	s1,0(s7)
      return iget(dp->dev, inum);
    80002c3e:	fa045583          	lhu	a1,-96(s0)
    80002c42:	00092503          	lw	a0,0(s2)
    80002c46:	f48ff0ef          	jal	8000238e <iget>
    80002c4a:	bf49                	j	80002bdc <dirlookup+0x38>

0000000080002c4c <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80002c4c:	711d                	addi	sp,sp,-96
    80002c4e:	ec86                	sd	ra,88(sp)
    80002c50:	e8a2                	sd	s0,80(sp)
    80002c52:	e4a6                	sd	s1,72(sp)
    80002c54:	e0ca                	sd	s2,64(sp)
    80002c56:	fc4e                	sd	s3,56(sp)
    80002c58:	f852                	sd	s4,48(sp)
    80002c5a:	f456                	sd	s5,40(sp)
    80002c5c:	f05a                	sd	s6,32(sp)
    80002c5e:	ec5e                	sd	s7,24(sp)
    80002c60:	e862                	sd	s8,16(sp)
    80002c62:	e466                	sd	s9,8(sp)
    80002c64:	e06a                	sd	s10,0(sp)
    80002c66:	1080                	addi	s0,sp,96
    80002c68:	84aa                	mv	s1,a0
    80002c6a:	8b2e                	mv	s6,a1
    80002c6c:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80002c6e:	00054703          	lbu	a4,0(a0)
    80002c72:	02f00793          	li	a5,47
    80002c76:	00f70f63          	beq	a4,a5,80002c94 <namex+0x48>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80002c7a:	8e4fe0ef          	jal	80000d5e <myproc>
    80002c7e:	15053503          	ld	a0,336(a0)
    80002c82:	951ff0ef          	jal	800025d2 <idup>
    80002c86:	8a2a                	mv	s4,a0
  while(*path == '/')
    80002c88:	02f00993          	li	s3,47
  if(len >= DIRSIZ)
    80002c8c:	4c35                	li	s8,13
    memmove(name, s, DIRSIZ);
    80002c8e:	4cb9                	li	s9,14

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80002c90:	4b85                	li	s7,1
    80002c92:	a879                	j	80002d30 <namex+0xe4>
    ip = iget(ROOTDEV, ROOTINO);
    80002c94:	4585                	li	a1,1
    80002c96:	852e                	mv	a0,a1
    80002c98:	ef6ff0ef          	jal	8000238e <iget>
    80002c9c:	8a2a                	mv	s4,a0
    80002c9e:	b7ed                	j	80002c88 <namex+0x3c>
      iunlockput(ip);
    80002ca0:	8552                	mv	a0,s4
    80002ca2:	b73ff0ef          	jal	80002814 <iunlockput>
      return 0;
    80002ca6:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80002ca8:	8552                	mv	a0,s4
    80002caa:	60e6                	ld	ra,88(sp)
    80002cac:	6446                	ld	s0,80(sp)
    80002cae:	64a6                	ld	s1,72(sp)
    80002cb0:	6906                	ld	s2,64(sp)
    80002cb2:	79e2                	ld	s3,56(sp)
    80002cb4:	7a42                	ld	s4,48(sp)
    80002cb6:	7aa2                	ld	s5,40(sp)
    80002cb8:	7b02                	ld	s6,32(sp)
    80002cba:	6be2                	ld	s7,24(sp)
    80002cbc:	6c42                	ld	s8,16(sp)
    80002cbe:	6ca2                	ld	s9,8(sp)
    80002cc0:	6d02                	ld	s10,0(sp)
    80002cc2:	6125                	addi	sp,sp,96
    80002cc4:	8082                	ret
      iunlock(ip);
    80002cc6:	8552                	mv	a0,s4
    80002cc8:	9efff0ef          	jal	800026b6 <iunlock>
      return ip;
    80002ccc:	bff1                	j	80002ca8 <namex+0x5c>
      iunlockput(ip);
    80002cce:	8552                	mv	a0,s4
    80002cd0:	b45ff0ef          	jal	80002814 <iunlockput>
      return 0;
    80002cd4:	8a4a                	mv	s4,s2
    80002cd6:	bfc9                	j	80002ca8 <namex+0x5c>
  while(*path != '/' && *path != 0)
    80002cd8:	8926                	mv	s2,s1
  len = path - s;
    80002cda:	4d01                	li	s10,0
    80002cdc:	4601                	li	a2,0
    memmove(name, s, len);
    80002cde:	2601                	sext.w	a2,a2
    80002ce0:	85a6                	mv	a1,s1
    80002ce2:	8556                	mv	a0,s5
    80002ce4:	cd6fd0ef          	jal	800001ba <memmove>
    name[len] = 0;
    80002ce8:	9d56                	add	s10,s10,s5
    80002cea:	000d0023          	sb	zero,0(s10) # fffffffffffff000 <end+0xffffffff7ffde498>
    80002cee:	84ca                	mv	s1,s2
  while(*path == '/')
    80002cf0:	0004c783          	lbu	a5,0(s1)
    80002cf4:	01379763          	bne	a5,s3,80002d02 <namex+0xb6>
    path++;
    80002cf8:	0485                	addi	s1,s1,1
  while(*path == '/')
    80002cfa:	0004c783          	lbu	a5,0(s1)
    80002cfe:	ff378de3          	beq	a5,s3,80002cf8 <namex+0xac>
    ilock(ip);
    80002d02:	8552                	mv	a0,s4
    80002d04:	905ff0ef          	jal	80002608 <ilock>
    if(ip->type != T_DIR){
    80002d08:	044a1783          	lh	a5,68(s4)
    80002d0c:	f9779ae3          	bne	a5,s7,80002ca0 <namex+0x54>
    if(nameiparent && *path == '\0'){
    80002d10:	000b0563          	beqz	s6,80002d1a <namex+0xce>
    80002d14:	0004c783          	lbu	a5,0(s1)
    80002d18:	d7dd                	beqz	a5,80002cc6 <namex+0x7a>
    if((next = dirlookup(ip, name, 0)) == 0){
    80002d1a:	4601                	li	a2,0
    80002d1c:	85d6                	mv	a1,s5
    80002d1e:	8552                	mv	a0,s4
    80002d20:	e85ff0ef          	jal	80002ba4 <dirlookup>
    80002d24:	892a                	mv	s2,a0
    80002d26:	d545                	beqz	a0,80002cce <namex+0x82>
    iunlockput(ip);
    80002d28:	8552                	mv	a0,s4
    80002d2a:	aebff0ef          	jal	80002814 <iunlockput>
    ip = next;
    80002d2e:	8a4a                	mv	s4,s2
  while(*path == '/')
    80002d30:	0004c783          	lbu	a5,0(s1)
    80002d34:	01379763          	bne	a5,s3,80002d42 <namex+0xf6>
    path++;
    80002d38:	0485                	addi	s1,s1,1
  while(*path == '/')
    80002d3a:	0004c783          	lbu	a5,0(s1)
    80002d3e:	ff378de3          	beq	a5,s3,80002d38 <namex+0xec>
  if(*path == 0)
    80002d42:	c7a1                	beqz	a5,80002d8a <namex+0x13e>
  while(*path != '/' && *path != 0)
    80002d44:	0004c703          	lbu	a4,0(s1)
    80002d48:	fd170793          	addi	a5,a4,-47
    80002d4c:	00f037b3          	snez	a5,a5
    80002d50:	00e03733          	snez	a4,a4
    80002d54:	8ff9                	and	a5,a5,a4
    80002d56:	d3c9                	beqz	a5,80002cd8 <namex+0x8c>
    80002d58:	8926                	mv	s2,s1
    path++;
    80002d5a:	0905                	addi	s2,s2,1
  while(*path != '/' && *path != 0)
    80002d5c:	00094703          	lbu	a4,0(s2)
    80002d60:	fd170793          	addi	a5,a4,-47
    80002d64:	00f037b3          	snez	a5,a5
    80002d68:	00e03733          	snez	a4,a4
    80002d6c:	8ff9                	and	a5,a5,a4
    80002d6e:	f7f5                	bnez	a5,80002d5a <namex+0x10e>
  len = path - s;
    80002d70:	40990633          	sub	a2,s2,s1
    80002d74:	00060d1b          	sext.w	s10,a2
  if(len >= DIRSIZ)
    80002d78:	f7ac53e3          	bge	s8,s10,80002cde <namex+0x92>
    memmove(name, s, DIRSIZ);
    80002d7c:	8666                	mv	a2,s9
    80002d7e:	85a6                	mv	a1,s1
    80002d80:	8556                	mv	a0,s5
    80002d82:	c38fd0ef          	jal	800001ba <memmove>
    80002d86:	84ca                	mv	s1,s2
    80002d88:	b7a5                	j	80002cf0 <namex+0xa4>
  if(nameiparent){
    80002d8a:	f00b0fe3          	beqz	s6,80002ca8 <namex+0x5c>
    iput(ip);
    80002d8e:	8552                	mv	a0,s4
    80002d90:	9fbff0ef          	jal	8000278a <iput>
    return 0;
    80002d94:	bf09                	j	80002ca6 <namex+0x5a>

0000000080002d96 <dirlink>:
{
    80002d96:	715d                	addi	sp,sp,-80
    80002d98:	e486                	sd	ra,72(sp)
    80002d9a:	e0a2                	sd	s0,64(sp)
    80002d9c:	f84a                	sd	s2,48(sp)
    80002d9e:	ec56                	sd	s5,24(sp)
    80002da0:	e85a                	sd	s6,16(sp)
    80002da2:	0880                	addi	s0,sp,80
    80002da4:	892a                	mv	s2,a0
    80002da6:	8aae                	mv	s5,a1
    80002da8:	8b32                	mv	s6,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80002daa:	4601                	li	a2,0
    80002dac:	df9ff0ef          	jal	80002ba4 <dirlookup>
    80002db0:	ed1d                	bnez	a0,80002dee <dirlink+0x58>
    80002db2:	fc26                	sd	s1,56(sp)
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002db4:	04c92483          	lw	s1,76(s2)
    80002db8:	c4b9                	beqz	s1,80002e06 <dirlink+0x70>
    80002dba:	f44e                	sd	s3,40(sp)
    80002dbc:	f052                	sd	s4,32(sp)
    80002dbe:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002dc0:	fb040a13          	addi	s4,s0,-80
    80002dc4:	49c1                	li	s3,16
    80002dc6:	874e                	mv	a4,s3
    80002dc8:	86a6                	mv	a3,s1
    80002dca:	8652                	mv	a2,s4
    80002dcc:	4581                	li	a1,0
    80002dce:	854a                	mv	a0,s2
    80002dd0:	bcbff0ef          	jal	8000299a <readi>
    80002dd4:	03351163          	bne	a0,s3,80002df6 <dirlink+0x60>
    if(de.inum == 0)
    80002dd8:	fb045783          	lhu	a5,-80(s0)
    80002ddc:	c39d                	beqz	a5,80002e02 <dirlink+0x6c>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002dde:	24c1                	addiw	s1,s1,16
    80002de0:	04c92783          	lw	a5,76(s2)
    80002de4:	fef4e1e3          	bltu	s1,a5,80002dc6 <dirlink+0x30>
    80002de8:	79a2                	ld	s3,40(sp)
    80002dea:	7a02                	ld	s4,32(sp)
    80002dec:	a829                	j	80002e06 <dirlink+0x70>
    iput(ip);
    80002dee:	99dff0ef          	jal	8000278a <iput>
    return -1;
    80002df2:	557d                	li	a0,-1
    80002df4:	a83d                	j	80002e32 <dirlink+0x9c>
      panic("dirlink read");
    80002df6:	00004517          	auipc	a0,0x4
    80002dfa:	67250513          	addi	a0,a0,1650 # 80007468 <etext+0x468>
    80002dfe:	756020ef          	jal	80005554 <panic>
    80002e02:	79a2                	ld	s3,40(sp)
    80002e04:	7a02                	ld	s4,32(sp)
  strncpy(de.name, name, DIRSIZ);
    80002e06:	4639                	li	a2,14
    80002e08:	85d6                	mv	a1,s5
    80002e0a:	fb240513          	addi	a0,s0,-78
    80002e0e:	c56fd0ef          	jal	80000264 <strncpy>
  de.inum = inum;
    80002e12:	fb641823          	sh	s6,-80(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002e16:	4741                	li	a4,16
    80002e18:	86a6                	mv	a3,s1
    80002e1a:	fb040613          	addi	a2,s0,-80
    80002e1e:	4581                	li	a1,0
    80002e20:	854a                	mv	a0,s2
    80002e22:	c6bff0ef          	jal	80002a8c <writei>
    80002e26:	1541                	addi	a0,a0,-16
    80002e28:	00a03533          	snez	a0,a0
    80002e2c:	40a0053b          	negw	a0,a0
    80002e30:	74e2                	ld	s1,56(sp)
}
    80002e32:	60a6                	ld	ra,72(sp)
    80002e34:	6406                	ld	s0,64(sp)
    80002e36:	7942                	ld	s2,48(sp)
    80002e38:	6ae2                	ld	s5,24(sp)
    80002e3a:	6b42                	ld	s6,16(sp)
    80002e3c:	6161                	addi	sp,sp,80
    80002e3e:	8082                	ret

0000000080002e40 <namei>:

struct inode*
namei(char *path)
{
    80002e40:	1101                	addi	sp,sp,-32
    80002e42:	ec06                	sd	ra,24(sp)
    80002e44:	e822                	sd	s0,16(sp)
    80002e46:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80002e48:	fe040613          	addi	a2,s0,-32
    80002e4c:	4581                	li	a1,0
    80002e4e:	dffff0ef          	jal	80002c4c <namex>
}
    80002e52:	60e2                	ld	ra,24(sp)
    80002e54:	6442                	ld	s0,16(sp)
    80002e56:	6105                	addi	sp,sp,32
    80002e58:	8082                	ret

0000000080002e5a <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80002e5a:	1141                	addi	sp,sp,-16
    80002e5c:	e406                	sd	ra,8(sp)
    80002e5e:	e022                	sd	s0,0(sp)
    80002e60:	0800                	addi	s0,sp,16
    80002e62:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80002e64:	4585                	li	a1,1
    80002e66:	de7ff0ef          	jal	80002c4c <namex>
}
    80002e6a:	60a2                	ld	ra,8(sp)
    80002e6c:	6402                	ld	s0,0(sp)
    80002e6e:	0141                	addi	sp,sp,16
    80002e70:	8082                	ret

0000000080002e72 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80002e72:	1101                	addi	sp,sp,-32
    80002e74:	ec06                	sd	ra,24(sp)
    80002e76:	e822                	sd	s0,16(sp)
    80002e78:	e426                	sd	s1,8(sp)
    80002e7a:	e04a                	sd	s2,0(sp)
    80002e7c:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80002e7e:	00015917          	auipc	s2,0x15
    80002e82:	9d290913          	addi	s2,s2,-1582 # 80017850 <log>
    80002e86:	01892583          	lw	a1,24(s2)
    80002e8a:	02492503          	lw	a0,36(s2)
    80002e8e:	8daff0ef          	jal	80001f68 <bread>
    80002e92:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80002e94:	02892603          	lw	a2,40(s2)
    80002e98:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80002e9a:	00c05f63          	blez	a2,80002eb8 <write_head+0x46>
    80002e9e:	00015717          	auipc	a4,0x15
    80002ea2:	9de70713          	addi	a4,a4,-1570 # 8001787c <log+0x2c>
    80002ea6:	87aa                	mv	a5,a0
    80002ea8:	060a                	slli	a2,a2,0x2
    80002eaa:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    80002eac:	4314                	lw	a3,0(a4)
    80002eae:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    80002eb0:	0711                	addi	a4,a4,4
    80002eb2:	0791                	addi	a5,a5,4 # 43004 <_entry-0x7ffbcffc>
    80002eb4:	fec79ce3          	bne	a5,a2,80002eac <write_head+0x3a>
  }
  bwrite(buf);
    80002eb8:	8526                	mv	a0,s1
    80002eba:	984ff0ef          	jal	8000203e <bwrite>
  brelse(buf);
    80002ebe:	8526                	mv	a0,s1
    80002ec0:	9b0ff0ef          	jal	80002070 <brelse>
}
    80002ec4:	60e2                	ld	ra,24(sp)
    80002ec6:	6442                	ld	s0,16(sp)
    80002ec8:	64a2                	ld	s1,8(sp)
    80002eca:	6902                	ld	s2,0(sp)
    80002ecc:	6105                	addi	sp,sp,32
    80002ece:	8082                	ret

0000000080002ed0 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80002ed0:	00015797          	auipc	a5,0x15
    80002ed4:	9a87a783          	lw	a5,-1624(a5) # 80017878 <log+0x28>
    80002ed8:	0cf05163          	blez	a5,80002f9a <install_trans+0xca>
{
    80002edc:	715d                	addi	sp,sp,-80
    80002ede:	e486                	sd	ra,72(sp)
    80002ee0:	e0a2                	sd	s0,64(sp)
    80002ee2:	fc26                	sd	s1,56(sp)
    80002ee4:	f84a                	sd	s2,48(sp)
    80002ee6:	f44e                	sd	s3,40(sp)
    80002ee8:	f052                	sd	s4,32(sp)
    80002eea:	ec56                	sd	s5,24(sp)
    80002eec:	e85a                	sd	s6,16(sp)
    80002eee:	e45e                	sd	s7,8(sp)
    80002ef0:	e062                	sd	s8,0(sp)
    80002ef2:	0880                	addi	s0,sp,80
    80002ef4:	8b2a                	mv	s6,a0
    80002ef6:	00015a97          	auipc	s5,0x15
    80002efa:	986a8a93          	addi	s5,s5,-1658 # 8001787c <log+0x2c>
  for (tail = 0; tail < log.lh.n; tail++) {
    80002efe:	4981                	li	s3,0
      printf("recovering tail %d dst %d\n", tail, log.lh.block[tail]);
    80002f00:	00004c17          	auipc	s8,0x4
    80002f04:	578c0c13          	addi	s8,s8,1400 # 80007478 <etext+0x478>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80002f08:	00015a17          	auipc	s4,0x15
    80002f0c:	948a0a13          	addi	s4,s4,-1720 # 80017850 <log>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80002f10:	40000b93          	li	s7,1024
    80002f14:	a025                	j	80002f3c <install_trans+0x6c>
      printf("recovering tail %d dst %d\n", tail, log.lh.block[tail]);
    80002f16:	000aa603          	lw	a2,0(s5)
    80002f1a:	85ce                	mv	a1,s3
    80002f1c:	8562                	mv	a0,s8
    80002f1e:	2fe020ef          	jal	8000521c <printf>
    80002f22:	a839                	j	80002f40 <install_trans+0x70>
    brelse(lbuf);
    80002f24:	854a                	mv	a0,s2
    80002f26:	94aff0ef          	jal	80002070 <brelse>
    brelse(dbuf);
    80002f2a:	8526                	mv	a0,s1
    80002f2c:	944ff0ef          	jal	80002070 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80002f30:	2985                	addiw	s3,s3,1
    80002f32:	0a91                	addi	s5,s5,4
    80002f34:	028a2783          	lw	a5,40(s4)
    80002f38:	04f9d563          	bge	s3,a5,80002f82 <install_trans+0xb2>
    if(recovering) {
    80002f3c:	fc0b1de3          	bnez	s6,80002f16 <install_trans+0x46>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80002f40:	018a2583          	lw	a1,24(s4)
    80002f44:	013585bb          	addw	a1,a1,s3
    80002f48:	2585                	addiw	a1,a1,1
    80002f4a:	024a2503          	lw	a0,36(s4)
    80002f4e:	81aff0ef          	jal	80001f68 <bread>
    80002f52:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80002f54:	000aa583          	lw	a1,0(s5)
    80002f58:	024a2503          	lw	a0,36(s4)
    80002f5c:	80cff0ef          	jal	80001f68 <bread>
    80002f60:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80002f62:	865e                	mv	a2,s7
    80002f64:	05890593          	addi	a1,s2,88
    80002f68:	05850513          	addi	a0,a0,88
    80002f6c:	a4efd0ef          	jal	800001ba <memmove>
    bwrite(dbuf);  // write dst to disk
    80002f70:	8526                	mv	a0,s1
    80002f72:	8ccff0ef          	jal	8000203e <bwrite>
    if(recovering == 0)
    80002f76:	fa0b17e3          	bnez	s6,80002f24 <install_trans+0x54>
      bunpin(dbuf);
    80002f7a:	8526                	mv	a0,s1
    80002f7c:	9acff0ef          	jal	80002128 <bunpin>
    80002f80:	b755                	j	80002f24 <install_trans+0x54>
}
    80002f82:	60a6                	ld	ra,72(sp)
    80002f84:	6406                	ld	s0,64(sp)
    80002f86:	74e2                	ld	s1,56(sp)
    80002f88:	7942                	ld	s2,48(sp)
    80002f8a:	79a2                	ld	s3,40(sp)
    80002f8c:	7a02                	ld	s4,32(sp)
    80002f8e:	6ae2                	ld	s5,24(sp)
    80002f90:	6b42                	ld	s6,16(sp)
    80002f92:	6ba2                	ld	s7,8(sp)
    80002f94:	6c02                	ld	s8,0(sp)
    80002f96:	6161                	addi	sp,sp,80
    80002f98:	8082                	ret
    80002f9a:	8082                	ret

0000000080002f9c <initlog>:
{
    80002f9c:	7179                	addi	sp,sp,-48
    80002f9e:	f406                	sd	ra,40(sp)
    80002fa0:	f022                	sd	s0,32(sp)
    80002fa2:	ec26                	sd	s1,24(sp)
    80002fa4:	e84a                	sd	s2,16(sp)
    80002fa6:	e44e                	sd	s3,8(sp)
    80002fa8:	1800                	addi	s0,sp,48
    80002faa:	84aa                	mv	s1,a0
    80002fac:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80002fae:	00015917          	auipc	s2,0x15
    80002fb2:	8a290913          	addi	s2,s2,-1886 # 80017850 <log>
    80002fb6:	00004597          	auipc	a1,0x4
    80002fba:	4e258593          	addi	a1,a1,1250 # 80007498 <etext+0x498>
    80002fbe:	854a                	mv	a0,s2
    80002fc0:	7c8020ef          	jal	80005788 <initlock>
  log.start = sb->logstart;
    80002fc4:	0149a583          	lw	a1,20(s3)
    80002fc8:	00b92c23          	sw	a1,24(s2)
  log.dev = dev;
    80002fcc:	02992223          	sw	s1,36(s2)
  struct buf *buf = bread(log.dev, log.start);
    80002fd0:	8526                	mv	a0,s1
    80002fd2:	f97fe0ef          	jal	80001f68 <bread>
  log.lh.n = lh->n;
    80002fd6:	4d30                	lw	a2,88(a0)
    80002fd8:	02c92423          	sw	a2,40(s2)
  for (i = 0; i < log.lh.n; i++) {
    80002fdc:	00c05f63          	blez	a2,80002ffa <initlog+0x5e>
    80002fe0:	87aa                	mv	a5,a0
    80002fe2:	00015717          	auipc	a4,0x15
    80002fe6:	89a70713          	addi	a4,a4,-1894 # 8001787c <log+0x2c>
    80002fea:	060a                	slli	a2,a2,0x2
    80002fec:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    80002fee:	4ff4                	lw	a3,92(a5)
    80002ff0:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80002ff2:	0791                	addi	a5,a5,4
    80002ff4:	0711                	addi	a4,a4,4
    80002ff6:	fec79ce3          	bne	a5,a2,80002fee <initlog+0x52>
  brelse(buf);
    80002ffa:	876ff0ef          	jal	80002070 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80002ffe:	4505                	li	a0,1
    80003000:	ed1ff0ef          	jal	80002ed0 <install_trans>
  log.lh.n = 0;
    80003004:	00015797          	auipc	a5,0x15
    80003008:	8607aa23          	sw	zero,-1932(a5) # 80017878 <log+0x28>
  write_head(); // clear the log
    8000300c:	e67ff0ef          	jal	80002e72 <write_head>
}
    80003010:	70a2                	ld	ra,40(sp)
    80003012:	7402                	ld	s0,32(sp)
    80003014:	64e2                	ld	s1,24(sp)
    80003016:	6942                	ld	s2,16(sp)
    80003018:	69a2                	ld	s3,8(sp)
    8000301a:	6145                	addi	sp,sp,48
    8000301c:	8082                	ret

000000008000301e <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    8000301e:	1101                	addi	sp,sp,-32
    80003020:	ec06                	sd	ra,24(sp)
    80003022:	e822                	sd	s0,16(sp)
    80003024:	e426                	sd	s1,8(sp)
    80003026:	e04a                	sd	s2,0(sp)
    80003028:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    8000302a:	00015517          	auipc	a0,0x15
    8000302e:	82650513          	addi	a0,a0,-2010 # 80017850 <log>
    80003032:	7e0020ef          	jal	80005812 <acquire>
  while(1){
    if(log.committing){
    80003036:	00015497          	auipc	s1,0x15
    8000303a:	81a48493          	addi	s1,s1,-2022 # 80017850 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGBLOCKS){
    8000303e:	4979                	li	s2,30
    80003040:	a029                	j	8000304a <begin_op+0x2c>
      sleep(&log, &log.lock);
    80003042:	85a6                	mv	a1,s1
    80003044:	8526                	mv	a0,s1
    80003046:	b02fe0ef          	jal	80001348 <sleep>
    if(log.committing){
    8000304a:	509c                	lw	a5,32(s1)
    8000304c:	fbfd                	bnez	a5,80003042 <begin_op+0x24>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGBLOCKS){
    8000304e:	4cd8                	lw	a4,28(s1)
    80003050:	2705                	addiw	a4,a4,1
    80003052:	0027179b          	slliw	a5,a4,0x2
    80003056:	9fb9                	addw	a5,a5,a4
    80003058:	0017979b          	slliw	a5,a5,0x1
    8000305c:	5494                	lw	a3,40(s1)
    8000305e:	9fb5                	addw	a5,a5,a3
    80003060:	00f95763          	bge	s2,a5,8000306e <begin_op+0x50>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80003064:	85a6                	mv	a1,s1
    80003066:	8526                	mv	a0,s1
    80003068:	ae0fe0ef          	jal	80001348 <sleep>
    8000306c:	bff9                	j	8000304a <begin_op+0x2c>
    } else {
      log.outstanding += 1;
    8000306e:	00014797          	auipc	a5,0x14
    80003072:	7ee7af23          	sw	a4,2046(a5) # 8001786c <log+0x1c>
      release(&log.lock);
    80003076:	00014517          	auipc	a0,0x14
    8000307a:	7da50513          	addi	a0,a0,2010 # 80017850 <log>
    8000307e:	025020ef          	jal	800058a2 <release>
      break;
    }
  }
}
    80003082:	60e2                	ld	ra,24(sp)
    80003084:	6442                	ld	s0,16(sp)
    80003086:	64a2                	ld	s1,8(sp)
    80003088:	6902                	ld	s2,0(sp)
    8000308a:	6105                	addi	sp,sp,32
    8000308c:	8082                	ret

000000008000308e <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    8000308e:	7139                	addi	sp,sp,-64
    80003090:	fc06                	sd	ra,56(sp)
    80003092:	f822                	sd	s0,48(sp)
    80003094:	f426                	sd	s1,40(sp)
    80003096:	f04a                	sd	s2,32(sp)
    80003098:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    8000309a:	00014497          	auipc	s1,0x14
    8000309e:	7b648493          	addi	s1,s1,1974 # 80017850 <log>
    800030a2:	8526                	mv	a0,s1
    800030a4:	76e020ef          	jal	80005812 <acquire>
  log.outstanding -= 1;
    800030a8:	4cdc                	lw	a5,28(s1)
    800030aa:	37fd                	addiw	a5,a5,-1
    800030ac:	893e                	mv	s2,a5
    800030ae:	ccdc                	sw	a5,28(s1)
  if(log.committing)
    800030b0:	509c                	lw	a5,32(s1)
    800030b2:	ebb9                	bnez	a5,80003108 <end_op+0x7a>
    panic("log.committing");
  if(log.outstanding == 0){
    800030b4:	06091363          	bnez	s2,8000311a <end_op+0x8c>
    do_commit = 1;
    log.committing = 1;
    800030b8:	00014497          	auipc	s1,0x14
    800030bc:	79848493          	addi	s1,s1,1944 # 80017850 <log>
    800030c0:	4785                	li	a5,1
    800030c2:	d09c                	sw	a5,32(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800030c4:	8526                	mv	a0,s1
    800030c6:	7dc020ef          	jal	800058a2 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    800030ca:	549c                	lw	a5,40(s1)
    800030cc:	06f04463          	bgtz	a5,80003134 <end_op+0xa6>
    acquire(&log.lock);
    800030d0:	00014517          	auipc	a0,0x14
    800030d4:	78050513          	addi	a0,a0,1920 # 80017850 <log>
    800030d8:	73a020ef          	jal	80005812 <acquire>
    log.committing = 0;
    800030dc:	00014797          	auipc	a5,0x14
    800030e0:	7807aa23          	sw	zero,1940(a5) # 80017870 <log+0x20>
    wakeup(&log);
    800030e4:	00014517          	auipc	a0,0x14
    800030e8:	76c50513          	addi	a0,a0,1900 # 80017850 <log>
    800030ec:	aa8fe0ef          	jal	80001394 <wakeup>
    release(&log.lock);
    800030f0:	00014517          	auipc	a0,0x14
    800030f4:	76050513          	addi	a0,a0,1888 # 80017850 <log>
    800030f8:	7aa020ef          	jal	800058a2 <release>
}
    800030fc:	70e2                	ld	ra,56(sp)
    800030fe:	7442                	ld	s0,48(sp)
    80003100:	74a2                	ld	s1,40(sp)
    80003102:	7902                	ld	s2,32(sp)
    80003104:	6121                	addi	sp,sp,64
    80003106:	8082                	ret
    80003108:	ec4e                	sd	s3,24(sp)
    8000310a:	e852                	sd	s4,16(sp)
    8000310c:	e456                	sd	s5,8(sp)
    panic("log.committing");
    8000310e:	00004517          	auipc	a0,0x4
    80003112:	39250513          	addi	a0,a0,914 # 800074a0 <etext+0x4a0>
    80003116:	43e020ef          	jal	80005554 <panic>
    wakeup(&log);
    8000311a:	00014517          	auipc	a0,0x14
    8000311e:	73650513          	addi	a0,a0,1846 # 80017850 <log>
    80003122:	a72fe0ef          	jal	80001394 <wakeup>
  release(&log.lock);
    80003126:	00014517          	auipc	a0,0x14
    8000312a:	72a50513          	addi	a0,a0,1834 # 80017850 <log>
    8000312e:	774020ef          	jal	800058a2 <release>
  if(do_commit){
    80003132:	b7e9                	j	800030fc <end_op+0x6e>
    80003134:	ec4e                	sd	s3,24(sp)
    80003136:	e852                	sd	s4,16(sp)
    80003138:	e456                	sd	s5,8(sp)
  for (tail = 0; tail < log.lh.n; tail++) {
    8000313a:	00014a97          	auipc	s5,0x14
    8000313e:	742a8a93          	addi	s5,s5,1858 # 8001787c <log+0x2c>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003142:	00014a17          	auipc	s4,0x14
    80003146:	70ea0a13          	addi	s4,s4,1806 # 80017850 <log>
    8000314a:	018a2583          	lw	a1,24(s4)
    8000314e:	012585bb          	addw	a1,a1,s2
    80003152:	2585                	addiw	a1,a1,1
    80003154:	024a2503          	lw	a0,36(s4)
    80003158:	e11fe0ef          	jal	80001f68 <bread>
    8000315c:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    8000315e:	000aa583          	lw	a1,0(s5)
    80003162:	024a2503          	lw	a0,36(s4)
    80003166:	e03fe0ef          	jal	80001f68 <bread>
    8000316a:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    8000316c:	40000613          	li	a2,1024
    80003170:	05850593          	addi	a1,a0,88
    80003174:	05848513          	addi	a0,s1,88
    80003178:	842fd0ef          	jal	800001ba <memmove>
    bwrite(to);  // write the log
    8000317c:	8526                	mv	a0,s1
    8000317e:	ec1fe0ef          	jal	8000203e <bwrite>
    brelse(from);
    80003182:	854e                	mv	a0,s3
    80003184:	eedfe0ef          	jal	80002070 <brelse>
    brelse(to);
    80003188:	8526                	mv	a0,s1
    8000318a:	ee7fe0ef          	jal	80002070 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000318e:	2905                	addiw	s2,s2,1
    80003190:	0a91                	addi	s5,s5,4
    80003192:	028a2783          	lw	a5,40(s4)
    80003196:	faf94ae3          	blt	s2,a5,8000314a <end_op+0xbc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    8000319a:	cd9ff0ef          	jal	80002e72 <write_head>
    install_trans(0); // Now install writes to home locations
    8000319e:	4501                	li	a0,0
    800031a0:	d31ff0ef          	jal	80002ed0 <install_trans>
    log.lh.n = 0;
    800031a4:	00014797          	auipc	a5,0x14
    800031a8:	6c07aa23          	sw	zero,1748(a5) # 80017878 <log+0x28>
    write_head();    // Erase the transaction from the log
    800031ac:	cc7ff0ef          	jal	80002e72 <write_head>
    800031b0:	69e2                	ld	s3,24(sp)
    800031b2:	6a42                	ld	s4,16(sp)
    800031b4:	6aa2                	ld	s5,8(sp)
    800031b6:	bf29                	j	800030d0 <end_op+0x42>

00000000800031b8 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800031b8:	1101                	addi	sp,sp,-32
    800031ba:	ec06                	sd	ra,24(sp)
    800031bc:	e822                	sd	s0,16(sp)
    800031be:	e426                	sd	s1,8(sp)
    800031c0:	1000                	addi	s0,sp,32
    800031c2:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    800031c4:	00014517          	auipc	a0,0x14
    800031c8:	68c50513          	addi	a0,a0,1676 # 80017850 <log>
    800031cc:	646020ef          	jal	80005812 <acquire>
  if (log.lh.n >= LOGBLOCKS)
    800031d0:	00014617          	auipc	a2,0x14
    800031d4:	6a862603          	lw	a2,1704(a2) # 80017878 <log+0x28>
    800031d8:	47f5                	li	a5,29
    800031da:	04c7cc63          	blt	a5,a2,80003232 <log_write+0x7a>
    panic("too big a transaction");
  if (log.outstanding < 1)
    800031de:	00014797          	auipc	a5,0x14
    800031e2:	68e7a783          	lw	a5,1678(a5) # 8001786c <log+0x1c>
    800031e6:	04f05c63          	blez	a5,8000323e <log_write+0x86>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    800031ea:	4781                	li	a5,0
    800031ec:	04c05f63          	blez	a2,8000324a <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorption
    800031f0:	44cc                	lw	a1,12(s1)
    800031f2:	00014717          	auipc	a4,0x14
    800031f6:	68a70713          	addi	a4,a4,1674 # 8001787c <log+0x2c>
  for (i = 0; i < log.lh.n; i++) {
    800031fa:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    800031fc:	4314                	lw	a3,0(a4)
    800031fe:	04b68663          	beq	a3,a1,8000324a <log_write+0x92>
  for (i = 0; i < log.lh.n; i++) {
    80003202:	2785                	addiw	a5,a5,1
    80003204:	0711                	addi	a4,a4,4
    80003206:	fef61be3          	bne	a2,a5,800031fc <log_write+0x44>
      break;
  }
  log.lh.block[i] = b->blockno;
    8000320a:	0621                	addi	a2,a2,8
    8000320c:	060a                	slli	a2,a2,0x2
    8000320e:	00014797          	auipc	a5,0x14
    80003212:	64278793          	addi	a5,a5,1602 # 80017850 <log>
    80003216:	97b2                	add	a5,a5,a2
    80003218:	44d8                	lw	a4,12(s1)
    8000321a:	c7d8                	sw	a4,12(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    8000321c:	8526                	mv	a0,s1
    8000321e:	ed7fe0ef          	jal	800020f4 <bpin>
    log.lh.n++;
    80003222:	00014717          	auipc	a4,0x14
    80003226:	62e70713          	addi	a4,a4,1582 # 80017850 <log>
    8000322a:	571c                	lw	a5,40(a4)
    8000322c:	2785                	addiw	a5,a5,1
    8000322e:	d71c                	sw	a5,40(a4)
    80003230:	a80d                	j	80003262 <log_write+0xaa>
    panic("too big a transaction");
    80003232:	00004517          	auipc	a0,0x4
    80003236:	27e50513          	addi	a0,a0,638 # 800074b0 <etext+0x4b0>
    8000323a:	31a020ef          	jal	80005554 <panic>
    panic("log_write outside of trans");
    8000323e:	00004517          	auipc	a0,0x4
    80003242:	28a50513          	addi	a0,a0,650 # 800074c8 <etext+0x4c8>
    80003246:	30e020ef          	jal	80005554 <panic>
  log.lh.block[i] = b->blockno;
    8000324a:	00878693          	addi	a3,a5,8
    8000324e:	068a                	slli	a3,a3,0x2
    80003250:	00014717          	auipc	a4,0x14
    80003254:	60070713          	addi	a4,a4,1536 # 80017850 <log>
    80003258:	9736                	add	a4,a4,a3
    8000325a:	44d4                	lw	a3,12(s1)
    8000325c:	c754                	sw	a3,12(a4)
  if (i == log.lh.n) {  // Add new block to log?
    8000325e:	faf60fe3          	beq	a2,a5,8000321c <log_write+0x64>
  }
  release(&log.lock);
    80003262:	00014517          	auipc	a0,0x14
    80003266:	5ee50513          	addi	a0,a0,1518 # 80017850 <log>
    8000326a:	638020ef          	jal	800058a2 <release>
}
    8000326e:	60e2                	ld	ra,24(sp)
    80003270:	6442                	ld	s0,16(sp)
    80003272:	64a2                	ld	s1,8(sp)
    80003274:	6105                	addi	sp,sp,32
    80003276:	8082                	ret

0000000080003278 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80003278:	1101                	addi	sp,sp,-32
    8000327a:	ec06                	sd	ra,24(sp)
    8000327c:	e822                	sd	s0,16(sp)
    8000327e:	e426                	sd	s1,8(sp)
    80003280:	e04a                	sd	s2,0(sp)
    80003282:	1000                	addi	s0,sp,32
    80003284:	84aa                	mv	s1,a0
    80003286:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80003288:	00004597          	auipc	a1,0x4
    8000328c:	26058593          	addi	a1,a1,608 # 800074e8 <etext+0x4e8>
    80003290:	0521                	addi	a0,a0,8
    80003292:	4f6020ef          	jal	80005788 <initlock>
  lk->name = name;
    80003296:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    8000329a:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8000329e:	0204a423          	sw	zero,40(s1)
}
    800032a2:	60e2                	ld	ra,24(sp)
    800032a4:	6442                	ld	s0,16(sp)
    800032a6:	64a2                	ld	s1,8(sp)
    800032a8:	6902                	ld	s2,0(sp)
    800032aa:	6105                	addi	sp,sp,32
    800032ac:	8082                	ret

00000000800032ae <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    800032ae:	1101                	addi	sp,sp,-32
    800032b0:	ec06                	sd	ra,24(sp)
    800032b2:	e822                	sd	s0,16(sp)
    800032b4:	e426                	sd	s1,8(sp)
    800032b6:	e04a                	sd	s2,0(sp)
    800032b8:	1000                	addi	s0,sp,32
    800032ba:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800032bc:	00850913          	addi	s2,a0,8
    800032c0:	854a                	mv	a0,s2
    800032c2:	550020ef          	jal	80005812 <acquire>
  while (lk->locked) {
    800032c6:	409c                	lw	a5,0(s1)
    800032c8:	c799                	beqz	a5,800032d6 <acquiresleep+0x28>
    sleep(lk, &lk->lk);
    800032ca:	85ca                	mv	a1,s2
    800032cc:	8526                	mv	a0,s1
    800032ce:	87afe0ef          	jal	80001348 <sleep>
  while (lk->locked) {
    800032d2:	409c                	lw	a5,0(s1)
    800032d4:	fbfd                	bnez	a5,800032ca <acquiresleep+0x1c>
  }
  lk->locked = 1;
    800032d6:	4785                	li	a5,1
    800032d8:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    800032da:	a85fd0ef          	jal	80000d5e <myproc>
    800032de:	591c                	lw	a5,48(a0)
    800032e0:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    800032e2:	854a                	mv	a0,s2
    800032e4:	5be020ef          	jal	800058a2 <release>
}
    800032e8:	60e2                	ld	ra,24(sp)
    800032ea:	6442                	ld	s0,16(sp)
    800032ec:	64a2                	ld	s1,8(sp)
    800032ee:	6902                	ld	s2,0(sp)
    800032f0:	6105                	addi	sp,sp,32
    800032f2:	8082                	ret

00000000800032f4 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800032f4:	1101                	addi	sp,sp,-32
    800032f6:	ec06                	sd	ra,24(sp)
    800032f8:	e822                	sd	s0,16(sp)
    800032fa:	e426                	sd	s1,8(sp)
    800032fc:	e04a                	sd	s2,0(sp)
    800032fe:	1000                	addi	s0,sp,32
    80003300:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003302:	00850913          	addi	s2,a0,8
    80003306:	854a                	mv	a0,s2
    80003308:	50a020ef          	jal	80005812 <acquire>
  lk->locked = 0;
    8000330c:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003310:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003314:	8526                	mv	a0,s1
    80003316:	87efe0ef          	jal	80001394 <wakeup>
  release(&lk->lk);
    8000331a:	854a                	mv	a0,s2
    8000331c:	586020ef          	jal	800058a2 <release>
}
    80003320:	60e2                	ld	ra,24(sp)
    80003322:	6442                	ld	s0,16(sp)
    80003324:	64a2                	ld	s1,8(sp)
    80003326:	6902                	ld	s2,0(sp)
    80003328:	6105                	addi	sp,sp,32
    8000332a:	8082                	ret

000000008000332c <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    8000332c:	7179                	addi	sp,sp,-48
    8000332e:	f406                	sd	ra,40(sp)
    80003330:	f022                	sd	s0,32(sp)
    80003332:	ec26                	sd	s1,24(sp)
    80003334:	e84a                	sd	s2,16(sp)
    80003336:	1800                	addi	s0,sp,48
    80003338:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    8000333a:	00850913          	addi	s2,a0,8
    8000333e:	854a                	mv	a0,s2
    80003340:	4d2020ef          	jal	80005812 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003344:	409c                	lw	a5,0(s1)
    80003346:	ef81                	bnez	a5,8000335e <holdingsleep+0x32>
    80003348:	4481                	li	s1,0
  release(&lk->lk);
    8000334a:	854a                	mv	a0,s2
    8000334c:	556020ef          	jal	800058a2 <release>
  return r;
}
    80003350:	8526                	mv	a0,s1
    80003352:	70a2                	ld	ra,40(sp)
    80003354:	7402                	ld	s0,32(sp)
    80003356:	64e2                	ld	s1,24(sp)
    80003358:	6942                	ld	s2,16(sp)
    8000335a:	6145                	addi	sp,sp,48
    8000335c:	8082                	ret
    8000335e:	e44e                	sd	s3,8(sp)
  r = lk->locked && (lk->pid == myproc()->pid);
    80003360:	0284a983          	lw	s3,40(s1)
    80003364:	9fbfd0ef          	jal	80000d5e <myproc>
    80003368:	5904                	lw	s1,48(a0)
    8000336a:	413484b3          	sub	s1,s1,s3
    8000336e:	0014b493          	seqz	s1,s1
    80003372:	69a2                	ld	s3,8(sp)
    80003374:	bfd9                	j	8000334a <holdingsleep+0x1e>

0000000080003376 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003376:	1141                	addi	sp,sp,-16
    80003378:	e406                	sd	ra,8(sp)
    8000337a:	e022                	sd	s0,0(sp)
    8000337c:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    8000337e:	00004597          	auipc	a1,0x4
    80003382:	17a58593          	addi	a1,a1,378 # 800074f8 <etext+0x4f8>
    80003386:	00014517          	auipc	a0,0x14
    8000338a:	61250513          	addi	a0,a0,1554 # 80017998 <ftable>
    8000338e:	3fa020ef          	jal	80005788 <initlock>
}
    80003392:	60a2                	ld	ra,8(sp)
    80003394:	6402                	ld	s0,0(sp)
    80003396:	0141                	addi	sp,sp,16
    80003398:	8082                	ret

000000008000339a <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    8000339a:	1101                	addi	sp,sp,-32
    8000339c:	ec06                	sd	ra,24(sp)
    8000339e:	e822                	sd	s0,16(sp)
    800033a0:	e426                	sd	s1,8(sp)
    800033a2:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800033a4:	00014517          	auipc	a0,0x14
    800033a8:	5f450513          	addi	a0,a0,1524 # 80017998 <ftable>
    800033ac:	466020ef          	jal	80005812 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800033b0:	00014497          	auipc	s1,0x14
    800033b4:	60048493          	addi	s1,s1,1536 # 800179b0 <ftable+0x18>
    800033b8:	00015717          	auipc	a4,0x15
    800033bc:	59870713          	addi	a4,a4,1432 # 80018950 <disk>
    if(f->ref == 0){
    800033c0:	40dc                	lw	a5,4(s1)
    800033c2:	cf89                	beqz	a5,800033dc <filealloc+0x42>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800033c4:	02848493          	addi	s1,s1,40
    800033c8:	fee49ce3          	bne	s1,a4,800033c0 <filealloc+0x26>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    800033cc:	00014517          	auipc	a0,0x14
    800033d0:	5cc50513          	addi	a0,a0,1484 # 80017998 <ftable>
    800033d4:	4ce020ef          	jal	800058a2 <release>
  return 0;
    800033d8:	4481                	li	s1,0
    800033da:	a809                	j	800033ec <filealloc+0x52>
      f->ref = 1;
    800033dc:	4785                	li	a5,1
    800033de:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    800033e0:	00014517          	auipc	a0,0x14
    800033e4:	5b850513          	addi	a0,a0,1464 # 80017998 <ftable>
    800033e8:	4ba020ef          	jal	800058a2 <release>
}
    800033ec:	8526                	mv	a0,s1
    800033ee:	60e2                	ld	ra,24(sp)
    800033f0:	6442                	ld	s0,16(sp)
    800033f2:	64a2                	ld	s1,8(sp)
    800033f4:	6105                	addi	sp,sp,32
    800033f6:	8082                	ret

00000000800033f8 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    800033f8:	1101                	addi	sp,sp,-32
    800033fa:	ec06                	sd	ra,24(sp)
    800033fc:	e822                	sd	s0,16(sp)
    800033fe:	e426                	sd	s1,8(sp)
    80003400:	1000                	addi	s0,sp,32
    80003402:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003404:	00014517          	auipc	a0,0x14
    80003408:	59450513          	addi	a0,a0,1428 # 80017998 <ftable>
    8000340c:	406020ef          	jal	80005812 <acquire>
  if(f->ref < 1)
    80003410:	40dc                	lw	a5,4(s1)
    80003412:	02f05063          	blez	a5,80003432 <filedup+0x3a>
    panic("filedup");
  f->ref++;
    80003416:	2785                	addiw	a5,a5,1
    80003418:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    8000341a:	00014517          	auipc	a0,0x14
    8000341e:	57e50513          	addi	a0,a0,1406 # 80017998 <ftable>
    80003422:	480020ef          	jal	800058a2 <release>
  return f;
}
    80003426:	8526                	mv	a0,s1
    80003428:	60e2                	ld	ra,24(sp)
    8000342a:	6442                	ld	s0,16(sp)
    8000342c:	64a2                	ld	s1,8(sp)
    8000342e:	6105                	addi	sp,sp,32
    80003430:	8082                	ret
    panic("filedup");
    80003432:	00004517          	auipc	a0,0x4
    80003436:	0ce50513          	addi	a0,a0,206 # 80007500 <etext+0x500>
    8000343a:	11a020ef          	jal	80005554 <panic>

000000008000343e <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    8000343e:	7139                	addi	sp,sp,-64
    80003440:	fc06                	sd	ra,56(sp)
    80003442:	f822                	sd	s0,48(sp)
    80003444:	f426                	sd	s1,40(sp)
    80003446:	0080                	addi	s0,sp,64
    80003448:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    8000344a:	00014517          	auipc	a0,0x14
    8000344e:	54e50513          	addi	a0,a0,1358 # 80017998 <ftable>
    80003452:	3c0020ef          	jal	80005812 <acquire>
  if(f->ref < 1)
    80003456:	40dc                	lw	a5,4(s1)
    80003458:	04f05a63          	blez	a5,800034ac <fileclose+0x6e>
    panic("fileclose");
  if(--f->ref > 0){
    8000345c:	37fd                	addiw	a5,a5,-1
    8000345e:	c0dc                	sw	a5,4(s1)
    80003460:	06f04063          	bgtz	a5,800034c0 <fileclose+0x82>
    80003464:	f04a                	sd	s2,32(sp)
    80003466:	ec4e                	sd	s3,24(sp)
    80003468:	e852                	sd	s4,16(sp)
    8000346a:	e456                	sd	s5,8(sp)
    release(&ftable.lock);
    return;
  }
  ff = *f;
    8000346c:	0004a903          	lw	s2,0(s1)
    80003470:	0094c783          	lbu	a5,9(s1)
    80003474:	89be                	mv	s3,a5
    80003476:	689c                	ld	a5,16(s1)
    80003478:	8a3e                	mv	s4,a5
    8000347a:	6c9c                	ld	a5,24(s1)
    8000347c:	8abe                	mv	s5,a5
  f->ref = 0;
    8000347e:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003482:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003486:	00014517          	auipc	a0,0x14
    8000348a:	51250513          	addi	a0,a0,1298 # 80017998 <ftable>
    8000348e:	414020ef          	jal	800058a2 <release>

  if(ff.type == FD_PIPE){
    80003492:	4785                	li	a5,1
    80003494:	04f90163          	beq	s2,a5,800034d6 <fileclose+0x98>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003498:	ffe9079b          	addiw	a5,s2,-2
    8000349c:	4705                	li	a4,1
    8000349e:	04f77563          	bgeu	a4,a5,800034e8 <fileclose+0xaa>
    800034a2:	7902                	ld	s2,32(sp)
    800034a4:	69e2                	ld	s3,24(sp)
    800034a6:	6a42                	ld	s4,16(sp)
    800034a8:	6aa2                	ld	s5,8(sp)
    800034aa:	a00d                	j	800034cc <fileclose+0x8e>
    800034ac:	f04a                	sd	s2,32(sp)
    800034ae:	ec4e                	sd	s3,24(sp)
    800034b0:	e852                	sd	s4,16(sp)
    800034b2:	e456                	sd	s5,8(sp)
    panic("fileclose");
    800034b4:	00004517          	auipc	a0,0x4
    800034b8:	05450513          	addi	a0,a0,84 # 80007508 <etext+0x508>
    800034bc:	098020ef          	jal	80005554 <panic>
    release(&ftable.lock);
    800034c0:	00014517          	auipc	a0,0x14
    800034c4:	4d850513          	addi	a0,a0,1240 # 80017998 <ftable>
    800034c8:	3da020ef          	jal	800058a2 <release>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
    800034cc:	70e2                	ld	ra,56(sp)
    800034ce:	7442                	ld	s0,48(sp)
    800034d0:	74a2                	ld	s1,40(sp)
    800034d2:	6121                	addi	sp,sp,64
    800034d4:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    800034d6:	85ce                	mv	a1,s3
    800034d8:	8552                	mv	a0,s4
    800034da:	332000ef          	jal	8000380c <pipeclose>
    800034de:	7902                	ld	s2,32(sp)
    800034e0:	69e2                	ld	s3,24(sp)
    800034e2:	6a42                	ld	s4,16(sp)
    800034e4:	6aa2                	ld	s5,8(sp)
    800034e6:	b7dd                	j	800034cc <fileclose+0x8e>
    begin_op();
    800034e8:	b37ff0ef          	jal	8000301e <begin_op>
    iput(ff.ip);
    800034ec:	8556                	mv	a0,s5
    800034ee:	a9cff0ef          	jal	8000278a <iput>
    end_op();
    800034f2:	b9dff0ef          	jal	8000308e <end_op>
    800034f6:	7902                	ld	s2,32(sp)
    800034f8:	69e2                	ld	s3,24(sp)
    800034fa:	6a42                	ld	s4,16(sp)
    800034fc:	6aa2                	ld	s5,8(sp)
    800034fe:	b7f9                	j	800034cc <fileclose+0x8e>

0000000080003500 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003500:	715d                	addi	sp,sp,-80
    80003502:	e486                	sd	ra,72(sp)
    80003504:	e0a2                	sd	s0,64(sp)
    80003506:	fc26                	sd	s1,56(sp)
    80003508:	f052                	sd	s4,32(sp)
    8000350a:	0880                	addi	s0,sp,80
    8000350c:	84aa                	mv	s1,a0
    8000350e:	8a2e                	mv	s4,a1
  struct proc *p = myproc();
    80003510:	84ffd0ef          	jal	80000d5e <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003514:	409c                	lw	a5,0(s1)
    80003516:	37f9                	addiw	a5,a5,-2
    80003518:	4705                	li	a4,1
    8000351a:	04f76263          	bltu	a4,a5,8000355e <filestat+0x5e>
    8000351e:	f84a                	sd	s2,48(sp)
    80003520:	f44e                	sd	s3,40(sp)
    80003522:	89aa                	mv	s3,a0
    ilock(f->ip);
    80003524:	6c88                	ld	a0,24(s1)
    80003526:	8e2ff0ef          	jal	80002608 <ilock>
    stati(f->ip, &st);
    8000352a:	fb840913          	addi	s2,s0,-72
    8000352e:	85ca                	mv	a1,s2
    80003530:	6c88                	ld	a0,24(s1)
    80003532:	c3aff0ef          	jal	8000296c <stati>
    iunlock(f->ip);
    80003536:	6c88                	ld	a0,24(s1)
    80003538:	97eff0ef          	jal	800026b6 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    8000353c:	46e1                	li	a3,24
    8000353e:	864a                	mv	a2,s2
    80003540:	85d2                	mv	a1,s4
    80003542:	0509b503          	ld	a0,80(s3)
    80003546:	d50fd0ef          	jal	80000a96 <copyout>
    8000354a:	41f5551b          	sraiw	a0,a0,0x1f
    8000354e:	7942                	ld	s2,48(sp)
    80003550:	79a2                	ld	s3,40(sp)
      return -1;
    return 0;
  }
  return -1;
}
    80003552:	60a6                	ld	ra,72(sp)
    80003554:	6406                	ld	s0,64(sp)
    80003556:	74e2                	ld	s1,56(sp)
    80003558:	7a02                	ld	s4,32(sp)
    8000355a:	6161                	addi	sp,sp,80
    8000355c:	8082                	ret
  return -1;
    8000355e:	557d                	li	a0,-1
    80003560:	bfcd                	j	80003552 <filestat+0x52>

0000000080003562 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003562:	7179                	addi	sp,sp,-48
    80003564:	f406                	sd	ra,40(sp)
    80003566:	f022                	sd	s0,32(sp)
    80003568:	e84a                	sd	s2,16(sp)
    8000356a:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    8000356c:	00854783          	lbu	a5,8(a0)
    80003570:	c3c5                	beqz	a5,80003610 <fileread+0xae>
    80003572:	ec26                	sd	s1,24(sp)
    80003574:	e44e                	sd	s3,8(sp)
    80003576:	84aa                	mv	s1,a0
    80003578:	892e                	mv	s2,a1
    8000357a:	89b2                	mv	s3,a2
    return -1;

  if(f->type == FD_PIPE){
    8000357c:	411c                	lw	a5,0(a0)
    8000357e:	4705                	li	a4,1
    80003580:	04e78363          	beq	a5,a4,800035c6 <fileread+0x64>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003584:	470d                	li	a4,3
    80003586:	04e78763          	beq	a5,a4,800035d4 <fileread+0x72>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    8000358a:	4709                	li	a4,2
    8000358c:	06e79a63          	bne	a5,a4,80003600 <fileread+0x9e>
    ilock(f->ip);
    80003590:	6d08                	ld	a0,24(a0)
    80003592:	876ff0ef          	jal	80002608 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003596:	874e                	mv	a4,s3
    80003598:	5094                	lw	a3,32(s1)
    8000359a:	864a                	mv	a2,s2
    8000359c:	4585                	li	a1,1
    8000359e:	6c88                	ld	a0,24(s1)
    800035a0:	bfaff0ef          	jal	8000299a <readi>
    800035a4:	892a                	mv	s2,a0
    800035a6:	00a05563          	blez	a0,800035b0 <fileread+0x4e>
      f->off += r;
    800035aa:	509c                	lw	a5,32(s1)
    800035ac:	9fa9                	addw	a5,a5,a0
    800035ae:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    800035b0:	6c88                	ld	a0,24(s1)
    800035b2:	904ff0ef          	jal	800026b6 <iunlock>
    800035b6:	64e2                	ld	s1,24(sp)
    800035b8:	69a2                	ld	s3,8(sp)
  } else {
    panic("fileread");
  }

  return r;
}
    800035ba:	854a                	mv	a0,s2
    800035bc:	70a2                	ld	ra,40(sp)
    800035be:	7402                	ld	s0,32(sp)
    800035c0:	6942                	ld	s2,16(sp)
    800035c2:	6145                	addi	sp,sp,48
    800035c4:	8082                	ret
    r = piperead(f->pipe, addr, n);
    800035c6:	6908                	ld	a0,16(a0)
    800035c8:	39a000ef          	jal	80003962 <piperead>
    800035cc:	892a                	mv	s2,a0
    800035ce:	64e2                	ld	s1,24(sp)
    800035d0:	69a2                	ld	s3,8(sp)
    800035d2:	b7e5                	j	800035ba <fileread+0x58>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    800035d4:	02451783          	lh	a5,36(a0)
    800035d8:	03079693          	slli	a3,a5,0x30
    800035dc:	92c1                	srli	a3,a3,0x30
    800035de:	4725                	li	a4,9
    800035e0:	02d76663          	bltu	a4,a3,8000360c <fileread+0xaa>
    800035e4:	0792                	slli	a5,a5,0x4
    800035e6:	00014717          	auipc	a4,0x14
    800035ea:	31270713          	addi	a4,a4,786 # 800178f8 <devsw>
    800035ee:	97ba                	add	a5,a5,a4
    800035f0:	639c                	ld	a5,0(a5)
    800035f2:	c395                	beqz	a5,80003616 <fileread+0xb4>
    r = devsw[f->major].read(1, addr, n);
    800035f4:	4505                	li	a0,1
    800035f6:	9782                	jalr	a5
    800035f8:	892a                	mv	s2,a0
    800035fa:	64e2                	ld	s1,24(sp)
    800035fc:	69a2                	ld	s3,8(sp)
    800035fe:	bf75                	j	800035ba <fileread+0x58>
    panic("fileread");
    80003600:	00004517          	auipc	a0,0x4
    80003604:	f1850513          	addi	a0,a0,-232 # 80007518 <etext+0x518>
    80003608:	74d010ef          	jal	80005554 <panic>
    8000360c:	64e2                	ld	s1,24(sp)
    8000360e:	69a2                	ld	s3,8(sp)
    return -1;
    80003610:	57fd                	li	a5,-1
    80003612:	893e                	mv	s2,a5
    80003614:	b75d                	j	800035ba <fileread+0x58>
    80003616:	64e2                	ld	s1,24(sp)
    80003618:	69a2                	ld	s3,8(sp)
    8000361a:	bfdd                	j	80003610 <fileread+0xae>

000000008000361c <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    8000361c:	00954783          	lbu	a5,9(a0)
    80003620:	12078463          	beqz	a5,80003748 <filewrite+0x12c>
{
    80003624:	711d                	addi	sp,sp,-96
    80003626:	ec86                	sd	ra,88(sp)
    80003628:	e8a2                	sd	s0,80(sp)
    8000362a:	e0ca                	sd	s2,64(sp)
    8000362c:	f456                	sd	s5,40(sp)
    8000362e:	f05a                	sd	s6,32(sp)
    80003630:	1080                	addi	s0,sp,96
    80003632:	892a                	mv	s2,a0
    80003634:	8b2e                	mv	s6,a1
    80003636:	8ab2                	mv	s5,a2
    return -1;

  if(f->type == FD_PIPE){
    80003638:	411c                	lw	a5,0(a0)
    8000363a:	4705                	li	a4,1
    8000363c:	02e78a63          	beq	a5,a4,80003670 <filewrite+0x54>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003640:	470d                	li	a4,3
    80003642:	02e78b63          	beq	a5,a4,80003678 <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003646:	4709                	li	a4,2
    80003648:	0ce79f63          	bne	a5,a4,80003726 <filewrite+0x10a>
    8000364c:	f852                	sd	s4,48(sp)
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    8000364e:	0ac05a63          	blez	a2,80003702 <filewrite+0xe6>
    80003652:	e4a6                	sd	s1,72(sp)
    80003654:	fc4e                	sd	s3,56(sp)
    80003656:	ec5e                	sd	s7,24(sp)
    80003658:	e862                	sd	s8,16(sp)
    8000365a:	e466                	sd	s9,8(sp)
    int i = 0;
    8000365c:	4a01                	li	s4,0
      int n1 = n - i;
      if(n1 > max)
    8000365e:	6b85                	lui	s7,0x1
    80003660:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80003664:	6785                	lui	a5,0x1
    80003666:	c007879b          	addiw	a5,a5,-1024 # c00 <_entry-0x7ffff400>
    8000366a:	8cbe                	mv	s9,a5
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    8000366c:	4c05                	li	s8,1
    8000366e:	a8ad                	j	800036e8 <filewrite+0xcc>
    ret = pipewrite(f->pipe, addr, n);
    80003670:	6908                	ld	a0,16(a0)
    80003672:	1f8000ef          	jal	8000386a <pipewrite>
    80003676:	a04d                	j	80003718 <filewrite+0xfc>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003678:	02451783          	lh	a5,36(a0)
    8000367c:	03079693          	slli	a3,a5,0x30
    80003680:	92c1                	srli	a3,a3,0x30
    80003682:	4725                	li	a4,9
    80003684:	0ad76d63          	bltu	a4,a3,8000373e <filewrite+0x122>
    80003688:	0792                	slli	a5,a5,0x4
    8000368a:	00014717          	auipc	a4,0x14
    8000368e:	26e70713          	addi	a4,a4,622 # 800178f8 <devsw>
    80003692:	97ba                	add	a5,a5,a4
    80003694:	679c                	ld	a5,8(a5)
    80003696:	c7c5                	beqz	a5,8000373e <filewrite+0x122>
    ret = devsw[f->major].write(1, addr, n);
    80003698:	4505                	li	a0,1
    8000369a:	9782                	jalr	a5
    8000369c:	a8b5                	j	80003718 <filewrite+0xfc>
      if(n1 > max)
    8000369e:	2981                	sext.w	s3,s3
      begin_op();
    800036a0:	97fff0ef          	jal	8000301e <begin_op>
      ilock(f->ip);
    800036a4:	01893503          	ld	a0,24(s2)
    800036a8:	f61fe0ef          	jal	80002608 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    800036ac:	874e                	mv	a4,s3
    800036ae:	02092683          	lw	a3,32(s2)
    800036b2:	016a0633          	add	a2,s4,s6
    800036b6:	85e2                	mv	a1,s8
    800036b8:	01893503          	ld	a0,24(s2)
    800036bc:	bd0ff0ef          	jal	80002a8c <writei>
    800036c0:	84aa                	mv	s1,a0
    800036c2:	00a05763          	blez	a0,800036d0 <filewrite+0xb4>
        f->off += r;
    800036c6:	02092783          	lw	a5,32(s2)
    800036ca:	9fa9                	addw	a5,a5,a0
    800036cc:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    800036d0:	01893503          	ld	a0,24(s2)
    800036d4:	fe3fe0ef          	jal	800026b6 <iunlock>
      end_op();
    800036d8:	9b7ff0ef          	jal	8000308e <end_op>

      if(r != n1){
    800036dc:	02999563          	bne	s3,s1,80003706 <filewrite+0xea>
        // error from writei
        break;
      }
      i += r;
    800036e0:	01448a3b          	addw	s4,s1,s4
    while(i < n){
    800036e4:	015a5963          	bge	s4,s5,800036f6 <filewrite+0xda>
      int n1 = n - i;
    800036e8:	414a87bb          	subw	a5,s5,s4
    800036ec:	89be                	mv	s3,a5
      if(n1 > max)
    800036ee:	fafbd8e3          	bge	s7,a5,8000369e <filewrite+0x82>
    800036f2:	89e6                	mv	s3,s9
    800036f4:	b76d                	j	8000369e <filewrite+0x82>
    800036f6:	64a6                	ld	s1,72(sp)
    800036f8:	79e2                	ld	s3,56(sp)
    800036fa:	6be2                	ld	s7,24(sp)
    800036fc:	6c42                	ld	s8,16(sp)
    800036fe:	6ca2                	ld	s9,8(sp)
    80003700:	a801                	j	80003710 <filewrite+0xf4>
    int i = 0;
    80003702:	4a01                	li	s4,0
    80003704:	a031                	j	80003710 <filewrite+0xf4>
    80003706:	64a6                	ld	s1,72(sp)
    80003708:	79e2                	ld	s3,56(sp)
    8000370a:	6be2                	ld	s7,24(sp)
    8000370c:	6c42                	ld	s8,16(sp)
    8000370e:	6ca2                	ld	s9,8(sp)
    }
    ret = (i == n ? n : -1);
    80003710:	034a9963          	bne	s5,s4,80003742 <filewrite+0x126>
    80003714:	8556                	mv	a0,s5
    80003716:	7a42                	ld	s4,48(sp)
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003718:	60e6                	ld	ra,88(sp)
    8000371a:	6446                	ld	s0,80(sp)
    8000371c:	6906                	ld	s2,64(sp)
    8000371e:	7aa2                	ld	s5,40(sp)
    80003720:	7b02                	ld	s6,32(sp)
    80003722:	6125                	addi	sp,sp,96
    80003724:	8082                	ret
    80003726:	e4a6                	sd	s1,72(sp)
    80003728:	fc4e                	sd	s3,56(sp)
    8000372a:	f852                	sd	s4,48(sp)
    8000372c:	ec5e                	sd	s7,24(sp)
    8000372e:	e862                	sd	s8,16(sp)
    80003730:	e466                	sd	s9,8(sp)
    panic("filewrite");
    80003732:	00004517          	auipc	a0,0x4
    80003736:	df650513          	addi	a0,a0,-522 # 80007528 <etext+0x528>
    8000373a:	61b010ef          	jal	80005554 <panic>
    return -1;
    8000373e:	557d                	li	a0,-1
    80003740:	bfe1                	j	80003718 <filewrite+0xfc>
    ret = (i == n ? n : -1);
    80003742:	557d                	li	a0,-1
    80003744:	7a42                	ld	s4,48(sp)
    80003746:	bfc9                	j	80003718 <filewrite+0xfc>
    return -1;
    80003748:	557d                	li	a0,-1
}
    8000374a:	8082                	ret

000000008000374c <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    8000374c:	7179                	addi	sp,sp,-48
    8000374e:	f406                	sd	ra,40(sp)
    80003750:	f022                	sd	s0,32(sp)
    80003752:	ec26                	sd	s1,24(sp)
    80003754:	e052                	sd	s4,0(sp)
    80003756:	1800                	addi	s0,sp,48
    80003758:	84aa                	mv	s1,a0
    8000375a:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    8000375c:	0005b023          	sd	zero,0(a1)
    80003760:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003764:	c37ff0ef          	jal	8000339a <filealloc>
    80003768:	e088                	sd	a0,0(s1)
    8000376a:	c549                	beqz	a0,800037f4 <pipealloc+0xa8>
    8000376c:	c2fff0ef          	jal	8000339a <filealloc>
    80003770:	00aa3023          	sd	a0,0(s4)
    80003774:	cd25                	beqz	a0,800037ec <pipealloc+0xa0>
    80003776:	e84a                	sd	s2,16(sp)
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003778:	98dfc0ef          	jal	80000104 <kalloc>
    8000377c:	892a                	mv	s2,a0
    8000377e:	c12d                	beqz	a0,800037e0 <pipealloc+0x94>
    80003780:	e44e                	sd	s3,8(sp)
    goto bad;
  pi->readopen = 1;
    80003782:	4985                	li	s3,1
    80003784:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003788:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    8000378c:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003790:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003794:	00004597          	auipc	a1,0x4
    80003798:	da458593          	addi	a1,a1,-604 # 80007538 <etext+0x538>
    8000379c:	7ed010ef          	jal	80005788 <initlock>
  (*f0)->type = FD_PIPE;
    800037a0:	609c                	ld	a5,0(s1)
    800037a2:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    800037a6:	609c                	ld	a5,0(s1)
    800037a8:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    800037ac:	609c                	ld	a5,0(s1)
    800037ae:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    800037b2:	609c                	ld	a5,0(s1)
    800037b4:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    800037b8:	000a3783          	ld	a5,0(s4)
    800037bc:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    800037c0:	000a3783          	ld	a5,0(s4)
    800037c4:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    800037c8:	000a3783          	ld	a5,0(s4)
    800037cc:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    800037d0:	000a3783          	ld	a5,0(s4)
    800037d4:	0127b823          	sd	s2,16(a5)
  return 0;
    800037d8:	4501                	li	a0,0
    800037da:	6942                	ld	s2,16(sp)
    800037dc:	69a2                	ld	s3,8(sp)
    800037de:	a00d                	j	80003800 <pipealloc+0xb4>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    800037e0:	6088                	ld	a0,0(s1)
    800037e2:	c119                	beqz	a0,800037e8 <pipealloc+0x9c>
    800037e4:	6942                	ld	s2,16(sp)
    800037e6:	a029                	j	800037f0 <pipealloc+0xa4>
    800037e8:	6942                	ld	s2,16(sp)
    800037ea:	a029                	j	800037f4 <pipealloc+0xa8>
    800037ec:	6088                	ld	a0,0(s1)
    800037ee:	c901                	beqz	a0,800037fe <pipealloc+0xb2>
    fileclose(*f0);
    800037f0:	c4fff0ef          	jal	8000343e <fileclose>
  if(*f1)
    800037f4:	000a3503          	ld	a0,0(s4)
    800037f8:	c119                	beqz	a0,800037fe <pipealloc+0xb2>
    fileclose(*f1);
    800037fa:	c45ff0ef          	jal	8000343e <fileclose>
  return -1;
    800037fe:	557d                	li	a0,-1
}
    80003800:	70a2                	ld	ra,40(sp)
    80003802:	7402                	ld	s0,32(sp)
    80003804:	64e2                	ld	s1,24(sp)
    80003806:	6a02                	ld	s4,0(sp)
    80003808:	6145                	addi	sp,sp,48
    8000380a:	8082                	ret

000000008000380c <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    8000380c:	1101                	addi	sp,sp,-32
    8000380e:	ec06                	sd	ra,24(sp)
    80003810:	e822                	sd	s0,16(sp)
    80003812:	e426                	sd	s1,8(sp)
    80003814:	e04a                	sd	s2,0(sp)
    80003816:	1000                	addi	s0,sp,32
    80003818:	84aa                	mv	s1,a0
    8000381a:	892e                	mv	s2,a1
  acquire(&pi->lock);
    8000381c:	7f7010ef          	jal	80005812 <acquire>
  if(writable){
    80003820:	02090763          	beqz	s2,8000384e <pipeclose+0x42>
    pi->writeopen = 0;
    80003824:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80003828:	21848513          	addi	a0,s1,536
    8000382c:	b69fd0ef          	jal	80001394 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80003830:	2204a783          	lw	a5,544(s1)
    80003834:	e781                	bnez	a5,8000383c <pipeclose+0x30>
    80003836:	2244a783          	lw	a5,548(s1)
    8000383a:	c38d                	beqz	a5,8000385c <pipeclose+0x50>
    release(&pi->lock);
    kfree((char*)pi);
  } else
    release(&pi->lock);
    8000383c:	8526                	mv	a0,s1
    8000383e:	064020ef          	jal	800058a2 <release>
}
    80003842:	60e2                	ld	ra,24(sp)
    80003844:	6442                	ld	s0,16(sp)
    80003846:	64a2                	ld	s1,8(sp)
    80003848:	6902                	ld	s2,0(sp)
    8000384a:	6105                	addi	sp,sp,32
    8000384c:	8082                	ret
    pi->readopen = 0;
    8000384e:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80003852:	21c48513          	addi	a0,s1,540
    80003856:	b3ffd0ef          	jal	80001394 <wakeup>
    8000385a:	bfd9                	j	80003830 <pipeclose+0x24>
    release(&pi->lock);
    8000385c:	8526                	mv	a0,s1
    8000385e:	044020ef          	jal	800058a2 <release>
    kfree((char*)pi);
    80003862:	8526                	mv	a0,s1
    80003864:	fb8fc0ef          	jal	8000001c <kfree>
    80003868:	bfe9                	j	80003842 <pipeclose+0x36>

000000008000386a <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    8000386a:	7159                	addi	sp,sp,-112
    8000386c:	f486                	sd	ra,104(sp)
    8000386e:	f0a2                	sd	s0,96(sp)
    80003870:	eca6                	sd	s1,88(sp)
    80003872:	e8ca                	sd	s2,80(sp)
    80003874:	e4ce                	sd	s3,72(sp)
    80003876:	e0d2                	sd	s4,64(sp)
    80003878:	fc56                	sd	s5,56(sp)
    8000387a:	1880                	addi	s0,sp,112
    8000387c:	84aa                	mv	s1,a0
    8000387e:	8aae                	mv	s5,a1
    80003880:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80003882:	cdcfd0ef          	jal	80000d5e <myproc>
    80003886:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80003888:	8526                	mv	a0,s1
    8000388a:	789010ef          	jal	80005812 <acquire>
  while(i < n){
    8000388e:	0d405263          	blez	s4,80003952 <pipewrite+0xe8>
    80003892:	f85a                	sd	s6,48(sp)
    80003894:	f45e                	sd	s7,40(sp)
    80003896:	f062                	sd	s8,32(sp)
    80003898:	ec66                	sd	s9,24(sp)
    8000389a:	e86a                	sd	s10,16(sp)
  int i = 0;
    8000389c:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    8000389e:	f9f40c13          	addi	s8,s0,-97
    800038a2:	4b85                	li	s7,1
    800038a4:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    800038a6:	21848d13          	addi	s10,s1,536
      sleep(&pi->nwrite, &pi->lock);
    800038aa:	21c48c93          	addi	s9,s1,540
    800038ae:	a82d                	j	800038e8 <pipewrite+0x7e>
      release(&pi->lock);
    800038b0:	8526                	mv	a0,s1
    800038b2:	7f1010ef          	jal	800058a2 <release>
      return -1;
    800038b6:	597d                	li	s2,-1
    800038b8:	7b42                	ld	s6,48(sp)
    800038ba:	7ba2                	ld	s7,40(sp)
    800038bc:	7c02                	ld	s8,32(sp)
    800038be:	6ce2                	ld	s9,24(sp)
    800038c0:	6d42                	ld	s10,16(sp)
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    800038c2:	854a                	mv	a0,s2
    800038c4:	70a6                	ld	ra,104(sp)
    800038c6:	7406                	ld	s0,96(sp)
    800038c8:	64e6                	ld	s1,88(sp)
    800038ca:	6946                	ld	s2,80(sp)
    800038cc:	69a6                	ld	s3,72(sp)
    800038ce:	6a06                	ld	s4,64(sp)
    800038d0:	7ae2                	ld	s5,56(sp)
    800038d2:	6165                	addi	sp,sp,112
    800038d4:	8082                	ret
      wakeup(&pi->nread);
    800038d6:	856a                	mv	a0,s10
    800038d8:	abdfd0ef          	jal	80001394 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    800038dc:	85a6                	mv	a1,s1
    800038de:	8566                	mv	a0,s9
    800038e0:	a69fd0ef          	jal	80001348 <sleep>
  while(i < n){
    800038e4:	05495a63          	bge	s2,s4,80003938 <pipewrite+0xce>
    if(pi->readopen == 0 || killed(pr)){
    800038e8:	2204a783          	lw	a5,544(s1)
    800038ec:	d3f1                	beqz	a5,800038b0 <pipewrite+0x46>
    800038ee:	854e                	mv	a0,s3
    800038f0:	c95fd0ef          	jal	80001584 <killed>
    800038f4:	fd55                	bnez	a0,800038b0 <pipewrite+0x46>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    800038f6:	2184a783          	lw	a5,536(s1)
    800038fa:	21c4a703          	lw	a4,540(s1)
    800038fe:	2007879b          	addiw	a5,a5,512
    80003902:	fcf70ae3          	beq	a4,a5,800038d6 <pipewrite+0x6c>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003906:	86de                	mv	a3,s7
    80003908:	01590633          	add	a2,s2,s5
    8000390c:	85e2                	mv	a1,s8
    8000390e:	0509b503          	ld	a0,80(s3)
    80003912:	a3cfd0ef          	jal	80000b4e <copyin>
    80003916:	05650063          	beq	a0,s6,80003956 <pipewrite+0xec>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    8000391a:	21c4a783          	lw	a5,540(s1)
    8000391e:	0017871b          	addiw	a4,a5,1
    80003922:	20e4ae23          	sw	a4,540(s1)
    80003926:	1ff7f793          	andi	a5,a5,511
    8000392a:	97a6                	add	a5,a5,s1
    8000392c:	f9f44703          	lbu	a4,-97(s0)
    80003930:	00e78c23          	sb	a4,24(a5)
      i++;
    80003934:	2905                	addiw	s2,s2,1
    80003936:	b77d                	j	800038e4 <pipewrite+0x7a>
    80003938:	7b42                	ld	s6,48(sp)
    8000393a:	7ba2                	ld	s7,40(sp)
    8000393c:	7c02                	ld	s8,32(sp)
    8000393e:	6ce2                	ld	s9,24(sp)
    80003940:	6d42                	ld	s10,16(sp)
  wakeup(&pi->nread);
    80003942:	21848513          	addi	a0,s1,536
    80003946:	a4ffd0ef          	jal	80001394 <wakeup>
  release(&pi->lock);
    8000394a:	8526                	mv	a0,s1
    8000394c:	757010ef          	jal	800058a2 <release>
  return i;
    80003950:	bf8d                	j	800038c2 <pipewrite+0x58>
  int i = 0;
    80003952:	4901                	li	s2,0
    80003954:	b7fd                	j	80003942 <pipewrite+0xd8>
    80003956:	7b42                	ld	s6,48(sp)
    80003958:	7ba2                	ld	s7,40(sp)
    8000395a:	7c02                	ld	s8,32(sp)
    8000395c:	6ce2                	ld	s9,24(sp)
    8000395e:	6d42                	ld	s10,16(sp)
    80003960:	b7cd                	j	80003942 <pipewrite+0xd8>

0000000080003962 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80003962:	711d                	addi	sp,sp,-96
    80003964:	ec86                	sd	ra,88(sp)
    80003966:	e8a2                	sd	s0,80(sp)
    80003968:	e4a6                	sd	s1,72(sp)
    8000396a:	e0ca                	sd	s2,64(sp)
    8000396c:	fc4e                	sd	s3,56(sp)
    8000396e:	f852                	sd	s4,48(sp)
    80003970:	f456                	sd	s5,40(sp)
    80003972:	1080                	addi	s0,sp,96
    80003974:	84aa                	mv	s1,a0
    80003976:	892e                	mv	s2,a1
    80003978:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    8000397a:	be4fd0ef          	jal	80000d5e <myproc>
    8000397e:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80003980:	8526                	mv	a0,s1
    80003982:	691010ef          	jal	80005812 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003986:	2184a703          	lw	a4,536(s1)
    8000398a:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    8000398e:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003992:	02f71363          	bne	a4,a5,800039b8 <piperead+0x56>
    80003996:	2244a783          	lw	a5,548(s1)
    8000399a:	cf99                	beqz	a5,800039b8 <piperead+0x56>
    if(killed(pr)){
    8000399c:	8552                	mv	a0,s4
    8000399e:	be7fd0ef          	jal	80001584 <killed>
    800039a2:	e53d                	bnez	a0,80003a10 <piperead+0xae>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800039a4:	85a6                	mv	a1,s1
    800039a6:	854e                	mv	a0,s3
    800039a8:	9a1fd0ef          	jal	80001348 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800039ac:	2184a703          	lw	a4,536(s1)
    800039b0:	21c4a783          	lw	a5,540(s1)
    800039b4:	fef701e3          	beq	a4,a5,80003996 <piperead+0x34>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800039b8:	07505163          	blez	s5,80003a1a <piperead+0xb8>
    800039bc:	f05a                	sd	s6,32(sp)
    800039be:	ec5e                	sd	s7,24(sp)
    800039c0:	e862                	sd	s8,16(sp)
    800039c2:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800039c4:	faf40c13          	addi	s8,s0,-81
    800039c8:	4b85                	li	s7,1
    800039ca:	5b7d                	li	s6,-1
    if(pi->nread == pi->nwrite)
    800039cc:	2184a783          	lw	a5,536(s1)
    800039d0:	21c4a703          	lw	a4,540(s1)
    800039d4:	04f70563          	beq	a4,a5,80003a1e <piperead+0xbc>
    ch = pi->data[pi->nread++ % PIPESIZE];
    800039d8:	0017871b          	addiw	a4,a5,1
    800039dc:	20e4ac23          	sw	a4,536(s1)
    800039e0:	1ff7f793          	andi	a5,a5,511
    800039e4:	97a6                	add	a5,a5,s1
    800039e6:	0187c783          	lbu	a5,24(a5)
    800039ea:	faf407a3          	sb	a5,-81(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800039ee:	86de                	mv	a3,s7
    800039f0:	8662                	mv	a2,s8
    800039f2:	85ca                	mv	a1,s2
    800039f4:	050a3503          	ld	a0,80(s4)
    800039f8:	89efd0ef          	jal	80000a96 <copyout>
    800039fc:	05650563          	beq	a0,s6,80003a46 <piperead+0xe4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003a00:	2985                	addiw	s3,s3,1
    80003a02:	0905                	addi	s2,s2,1
    80003a04:	fd3a94e3          	bne	s5,s3,800039cc <piperead+0x6a>
    80003a08:	7b02                	ld	s6,32(sp)
    80003a0a:	6be2                	ld	s7,24(sp)
    80003a0c:	6c42                	ld	s8,16(sp)
    80003a0e:	a819                	j	80003a24 <piperead+0xc2>
      release(&pi->lock);
    80003a10:	8526                	mv	a0,s1
    80003a12:	691010ef          	jal	800058a2 <release>
      return -1;
    80003a16:	59fd                	li	s3,-1
    80003a18:	a829                	j	80003a32 <piperead+0xd0>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003a1a:	4981                	li	s3,0
    80003a1c:	a021                	j	80003a24 <piperead+0xc2>
    80003a1e:	7b02                	ld	s6,32(sp)
    80003a20:	6be2                	ld	s7,24(sp)
    80003a22:	6c42                	ld	s8,16(sp)
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80003a24:	21c48513          	addi	a0,s1,540
    80003a28:	96dfd0ef          	jal	80001394 <wakeup>
  release(&pi->lock);
    80003a2c:	8526                	mv	a0,s1
    80003a2e:	675010ef          	jal	800058a2 <release>
  return i;
}
    80003a32:	854e                	mv	a0,s3
    80003a34:	60e6                	ld	ra,88(sp)
    80003a36:	6446                	ld	s0,80(sp)
    80003a38:	64a6                	ld	s1,72(sp)
    80003a3a:	6906                	ld	s2,64(sp)
    80003a3c:	79e2                	ld	s3,56(sp)
    80003a3e:	7a42                	ld	s4,48(sp)
    80003a40:	7aa2                	ld	s5,40(sp)
    80003a42:	6125                	addi	sp,sp,96
    80003a44:	8082                	ret
    80003a46:	7b02                	ld	s6,32(sp)
    80003a48:	6be2                	ld	s7,24(sp)
    80003a4a:	6c42                	ld	s8,16(sp)
    80003a4c:	bfe1                	j	80003a24 <piperead+0xc2>

0000000080003a4e <flags2perm>:

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

// map ELF permissions to PTE permission bits.
int flags2perm(int flags)
{
    80003a4e:	1141                	addi	sp,sp,-16
    80003a50:	e406                	sd	ra,8(sp)
    80003a52:	e022                	sd	s0,0(sp)
    80003a54:	0800                	addi	s0,sp,16
    80003a56:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    80003a58:	0035151b          	slliw	a0,a0,0x3
    80003a5c:	8921                	andi	a0,a0,8
      perm = PTE_X;
    if(flags & 0x2)
    80003a5e:	8b89                	andi	a5,a5,2
    80003a60:	c399                	beqz	a5,80003a66 <flags2perm+0x18>
      perm |= PTE_W;
    80003a62:	00456513          	ori	a0,a0,4
    return perm;
}
    80003a66:	60a2                	ld	ra,8(sp)
    80003a68:	6402                	ld	s0,0(sp)
    80003a6a:	0141                	addi	sp,sp,16
    80003a6c:	8082                	ret

0000000080003a6e <kexec>:
//
// the implementation of the exec() system call
//
int
kexec(char *path, char **argv)
{
    80003a6e:	df010113          	addi	sp,sp,-528
    80003a72:	20113423          	sd	ra,520(sp)
    80003a76:	20813023          	sd	s0,512(sp)
    80003a7a:	ffa6                	sd	s1,504(sp)
    80003a7c:	fbca                	sd	s2,496(sp)
    80003a7e:	0c00                	addi	s0,sp,528
    80003a80:	892a                	mv	s2,a0
    80003a82:	e0a43023          	sd	a0,-512(s0)
    80003a86:	deb43c23          	sd	a1,-520(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80003a8a:	ad4fd0ef          	jal	80000d5e <myproc>
    80003a8e:	84aa                	mv	s1,a0

  begin_op();
    80003a90:	d8eff0ef          	jal	8000301e <begin_op>

  // Open the executable file.
  if((ip = namei(path)) == 0){
    80003a94:	854a                	mv	a0,s2
    80003a96:	baaff0ef          	jal	80002e40 <namei>
    80003a9a:	c931                	beqz	a0,80003aee <kexec+0x80>
    80003a9c:	f3d2                	sd	s4,480(sp)
    80003a9e:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80003aa0:	b69fe0ef          	jal	80002608 <ilock>

  // Read the ELF header.
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80003aa4:	04000713          	li	a4,64
    80003aa8:	4681                	li	a3,0
    80003aaa:	e5040613          	addi	a2,s0,-432
    80003aae:	4581                	li	a1,0
    80003ab0:	8552                	mv	a0,s4
    80003ab2:	ee9fe0ef          	jal	8000299a <readi>
    80003ab6:	04000793          	li	a5,64
    80003aba:	00f51a63          	bne	a0,a5,80003ace <kexec+0x60>
    goto bad;

  // Is this really an ELF file?
  if(elf.magic != ELF_MAGIC)
    80003abe:	e5042703          	lw	a4,-432(s0)
    80003ac2:	464c47b7          	lui	a5,0x464c4
    80003ac6:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80003aca:	02f70563          	beq	a4,a5,80003af4 <kexec+0x86>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80003ace:	8552                	mv	a0,s4
    80003ad0:	d45fe0ef          	jal	80002814 <iunlockput>
    end_op();
    80003ad4:	dbaff0ef          	jal	8000308e <end_op>
    80003ad8:	7a1e                	ld	s4,480(sp)
    return -1;
    80003ada:	557d                	li	a0,-1
  }
  return -1;
}
    80003adc:	20813083          	ld	ra,520(sp)
    80003ae0:	20013403          	ld	s0,512(sp)
    80003ae4:	74fe                	ld	s1,504(sp)
    80003ae6:	795e                	ld	s2,496(sp)
    80003ae8:	21010113          	addi	sp,sp,528
    80003aec:	8082                	ret
    end_op();
    80003aee:	da0ff0ef          	jal	8000308e <end_op>
    return -1;
    80003af2:	b7e5                	j	80003ada <kexec+0x6c>
    80003af4:	ebda                	sd	s6,464(sp)
  if((pagetable = proc_pagetable(p)) == 0)
    80003af6:	8526                	mv	a0,s1
    80003af8:	b70fd0ef          	jal	80000e68 <proc_pagetable>
    80003afc:	8b2a                	mv	s6,a0
    80003afe:	26050063          	beqz	a0,80003d5e <kexec+0x2f0>
    80003b02:	f7ce                	sd	s3,488(sp)
    80003b04:	efd6                	sd	s5,472(sp)
    80003b06:	e7de                	sd	s7,456(sp)
    80003b08:	e3e2                	sd	s8,448(sp)
    80003b0a:	ff66                	sd	s9,440(sp)
    80003b0c:	fb6a                	sd	s10,432(sp)
    80003b0e:	f76e                	sd	s11,424(sp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003b10:	e8845783          	lhu	a5,-376(s0)
    80003b14:	cff9                	beqz	a5,80003bf2 <kexec+0x184>
    80003b16:	e7042683          	lw	a3,-400(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80003b1a:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003b1c:	4d01                	li	s10,0
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80003b1e:	03800d93          	li	s11,56

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    80003b22:	6c85                	lui	s9,0x1
    80003b24:	6a85                	lui	s5,0x1
    80003b26:	a085                	j	80003b86 <kexec+0x118>
      panic("loadseg: address should exist");
    80003b28:	00004517          	auipc	a0,0x4
    80003b2c:	a1850513          	addi	a0,a0,-1512 # 80007540 <etext+0x540>
    80003b30:	225010ef          	jal	80005554 <panic>
    if(sz - i < PGSIZE)
    80003b34:	2901                	sext.w	s2,s2
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80003b36:	874a                	mv	a4,s2
    80003b38:	009b86bb          	addw	a3,s7,s1
    80003b3c:	4581                	li	a1,0
    80003b3e:	8552                	mv	a0,s4
    80003b40:	e5bfe0ef          	jal	8000299a <readi>
    80003b44:	22a91163          	bne	s2,a0,80003d66 <kexec+0x2f8>
  for(i = 0; i < sz; i += PGSIZE){
    80003b48:	009a84bb          	addw	s1,s5,s1
    80003b4c:	0334f263          	bgeu	s1,s3,80003b70 <kexec+0x102>
    pa = walkaddr(pagetable, va + i);
    80003b50:	02049593          	slli	a1,s1,0x20
    80003b54:	9181                	srli	a1,a1,0x20
    80003b56:	95e2                	add	a1,a1,s8
    80003b58:	855a                	mv	a0,s6
    80003b5a:	925fc0ef          	jal	8000047e <walkaddr>
    80003b5e:	862a                	mv	a2,a0
    if(pa == 0)
    80003b60:	d561                	beqz	a0,80003b28 <kexec+0xba>
    if(sz - i < PGSIZE)
    80003b62:	409987bb          	subw	a5,s3,s1
    80003b66:	893e                	mv	s2,a5
    80003b68:	fcfcf6e3          	bgeu	s9,a5,80003b34 <kexec+0xc6>
    80003b6c:	8956                	mv	s2,s5
    80003b6e:	b7d9                	j	80003b34 <kexec+0xc6>
    sz = sz1;
    80003b70:	df043903          	ld	s2,-528(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003b74:	2d05                	addiw	s10,s10,1
    80003b76:	e0843783          	ld	a5,-504(s0)
    80003b7a:	0387869b          	addiw	a3,a5,56
    80003b7e:	e8845783          	lhu	a5,-376(s0)
    80003b82:	06fd5963          	bge	s10,a5,80003bf4 <kexec+0x186>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80003b86:	e0d43423          	sd	a3,-504(s0)
    80003b8a:	876e                	mv	a4,s11
    80003b8c:	e1840613          	addi	a2,s0,-488
    80003b90:	4581                	li	a1,0
    80003b92:	8552                	mv	a0,s4
    80003b94:	e07fe0ef          	jal	8000299a <readi>
    80003b98:	1db51563          	bne	a0,s11,80003d62 <kexec+0x2f4>
    if(ph.type != ELF_PROG_LOAD)
    80003b9c:	e1842783          	lw	a5,-488(s0)
    80003ba0:	4705                	li	a4,1
    80003ba2:	fce799e3          	bne	a5,a4,80003b74 <kexec+0x106>
    if(ph.memsz < ph.filesz)
    80003ba6:	e4043483          	ld	s1,-448(s0)
    80003baa:	e3843783          	ld	a5,-456(s0)
    80003bae:	1af4ea63          	bltu	s1,a5,80003d62 <kexec+0x2f4>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80003bb2:	e2843783          	ld	a5,-472(s0)
    80003bb6:	94be                	add	s1,s1,a5
    80003bb8:	1af4e563          	bltu	s1,a5,80003d62 <kexec+0x2f4>
    if(ph.vaddr % PGSIZE != 0)
    80003bbc:	17d2                	slli	a5,a5,0x34
    80003bbe:	1a079263          	bnez	a5,80003d62 <kexec+0x2f4>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80003bc2:	e1c42503          	lw	a0,-484(s0)
    80003bc6:	e89ff0ef          	jal	80003a4e <flags2perm>
    80003bca:	86aa                	mv	a3,a0
    80003bcc:	8626                	mv	a2,s1
    80003bce:	85ca                	mv	a1,s2
    80003bd0:	855a                	mv	a0,s6
    80003bd2:	b7bfc0ef          	jal	8000074c <uvmalloc>
    80003bd6:	dea43823          	sd	a0,-528(s0)
    80003bda:	18050463          	beqz	a0,80003d62 <kexec+0x2f4>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80003bde:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80003be2:	f80987e3          	beqz	s3,80003b70 <kexec+0x102>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80003be6:	e2843c03          	ld	s8,-472(s0)
    80003bea:	e2042b83          	lw	s7,-480(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80003bee:	4481                	li	s1,0
    80003bf0:	b785                	j	80003b50 <kexec+0xe2>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80003bf2:	4901                	li	s2,0
  iunlockput(ip);
    80003bf4:	8552                	mv	a0,s4
    80003bf6:	c1ffe0ef          	jal	80002814 <iunlockput>
  end_op();
    80003bfa:	c94ff0ef          	jal	8000308e <end_op>
  p = myproc();
    80003bfe:	960fd0ef          	jal	80000d5e <myproc>
    80003c02:	89aa                	mv	s3,a0
  uint64 oldsz = p->sz;
    80003c04:	04853a83          	ld	s5,72(a0)
  sz = PGROUNDUP(sz);
    80003c08:	6485                	lui	s1,0x1
    80003c0a:	14fd                	addi	s1,s1,-1 # fff <_entry-0x7ffff001>
    80003c0c:	94ca                	add	s1,s1,s2
    80003c0e:	77fd                	lui	a5,0xfffff
    80003c10:	8cfd                	and	s1,s1,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + (USERSTACK+1)*PGSIZE, PTE_W)) == 0)
    80003c12:	4691                	li	a3,4
    80003c14:	660d                	lui	a2,0x3
    80003c16:	9626                	add	a2,a2,s1
    80003c18:	85a6                	mv	a1,s1
    80003c1a:	855a                	mv	a0,s6
    80003c1c:	b31fc0ef          	jal	8000074c <uvmalloc>
    80003c20:	8a2a                	mv	s4,a0
    80003c22:	ed19                	bnez	a0,80003c40 <kexec+0x1d2>
    proc_freepagetable(pagetable, sz);
    80003c24:	85a6                	mv	a1,s1
    80003c26:	855a                	mv	a0,s6
    80003c28:	ac2fd0ef          	jal	80000eea <proc_freepagetable>
  if(ip){
    80003c2c:	79be                	ld	s3,488(sp)
    80003c2e:	7a1e                	ld	s4,480(sp)
    80003c30:	6afe                	ld	s5,472(sp)
    80003c32:	6b5e                	ld	s6,464(sp)
    80003c34:	6bbe                	ld	s7,456(sp)
    80003c36:	6c1e                	ld	s8,448(sp)
    80003c38:	7cfa                	ld	s9,440(sp)
    80003c3a:	7d5a                	ld	s10,432(sp)
    80003c3c:	7dba                	ld	s11,424(sp)
    80003c3e:	bd71                	j	80003ada <kexec+0x6c>
  uvmclear(pagetable, sz-(USERSTACK+1)*PGSIZE);
    80003c40:	75f5                	lui	a1,0xffffd
    80003c42:	95aa                	add	a1,a1,a0
    80003c44:	855a                	mv	a0,s6
    80003c46:	ccffc0ef          	jal	80000914 <uvmclear>
  stackbase = sp - USERSTACK*PGSIZE;
    80003c4a:	7c79                	lui	s8,0xffffe
    80003c4c:	9c52                	add	s8,s8,s4
  for(argc = 0; argv[argc]; argc++) {
    80003c4e:	df843783          	ld	a5,-520(s0)
    80003c52:	6388                	ld	a0,0(a5)
  sp = sz;
    80003c54:	8952                	mv	s2,s4
  for(argc = 0; argv[argc]; argc++) {
    80003c56:	4481                	li	s1,0
    ustack[argc] = sp;
    80003c58:	e9040c93          	addi	s9,s0,-368
    if(argc >= MAXARG)
    80003c5c:	02000d13          	li	s10,32
  for(argc = 0; argv[argc]; argc++) {
    80003c60:	cd21                	beqz	a0,80003cb8 <kexec+0x24a>
    sp -= strlen(argv[argc]) + 1;
    80003c62:	e7cfc0ef          	jal	800002de <strlen>
    80003c66:	0015079b          	addiw	a5,a0,1
    80003c6a:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80003c6e:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    80003c72:	05896163          	bltu	s2,s8,80003cb4 <kexec+0x246>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80003c76:	df843d83          	ld	s11,-520(s0)
    80003c7a:	000dbb83          	ld	s7,0(s11)
    80003c7e:	855e                	mv	a0,s7
    80003c80:	e5efc0ef          	jal	800002de <strlen>
    80003c84:	0015069b          	addiw	a3,a0,1
    80003c88:	865e                	mv	a2,s7
    80003c8a:	85ca                	mv	a1,s2
    80003c8c:	855a                	mv	a0,s6
    80003c8e:	e09fc0ef          	jal	80000a96 <copyout>
    80003c92:	02054163          	bltz	a0,80003cb4 <kexec+0x246>
    ustack[argc] = sp;
    80003c96:	00349793          	slli	a5,s1,0x3
    80003c9a:	97e6                	add	a5,a5,s9
    80003c9c:	0127b023          	sd	s2,0(a5) # fffffffffffff000 <end+0xffffffff7ffde498>
  for(argc = 0; argv[argc]; argc++) {
    80003ca0:	0485                	addi	s1,s1,1
    80003ca2:	008d8793          	addi	a5,s11,8
    80003ca6:	def43c23          	sd	a5,-520(s0)
    80003caa:	008db503          	ld	a0,8(s11)
    80003cae:	c509                	beqz	a0,80003cb8 <kexec+0x24a>
    if(argc >= MAXARG)
    80003cb0:	fba499e3          	bne	s1,s10,80003c62 <kexec+0x1f4>
  sz = sz1;
    80003cb4:	84d2                	mv	s1,s4
    80003cb6:	b7bd                	j	80003c24 <kexec+0x1b6>
  ustack[argc] = 0;
    80003cb8:	00349793          	slli	a5,s1,0x3
    80003cbc:	f9040713          	addi	a4,s0,-112
    80003cc0:	97ba                	add	a5,a5,a4
    80003cc2:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    80003cc6:	00148693          	addi	a3,s1,1
    80003cca:	068e                	slli	a3,a3,0x3
    80003ccc:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80003cd0:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80003cd4:	ff8960e3          	bltu	s2,s8,80003cb4 <kexec+0x246>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80003cd8:	e9040613          	addi	a2,s0,-368
    80003cdc:	85ca                	mv	a1,s2
    80003cde:	855a                	mv	a0,s6
    80003ce0:	db7fc0ef          	jal	80000a96 <copyout>
    80003ce4:	fc0548e3          	bltz	a0,80003cb4 <kexec+0x246>
  p->trapframe->a1 = sp;
    80003ce8:	0589b783          	ld	a5,88(s3)
    80003cec:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80003cf0:	e0043783          	ld	a5,-512(s0)
    80003cf4:	0007c703          	lbu	a4,0(a5)
    80003cf8:	cf11                	beqz	a4,80003d14 <kexec+0x2a6>
    80003cfa:	0785                	addi	a5,a5,1
    if(*s == '/')
    80003cfc:	02f00693          	li	a3,47
    80003d00:	a029                	j	80003d0a <kexec+0x29c>
  for(last=s=path; *s; s++)
    80003d02:	0785                	addi	a5,a5,1
    80003d04:	fff7c703          	lbu	a4,-1(a5)
    80003d08:	c711                	beqz	a4,80003d14 <kexec+0x2a6>
    if(*s == '/')
    80003d0a:	fed71ce3          	bne	a4,a3,80003d02 <kexec+0x294>
      last = s+1;
    80003d0e:	e0f43023          	sd	a5,-512(s0)
    80003d12:	bfc5                	j	80003d02 <kexec+0x294>
  safestrcpy(p->name, last, sizeof(p->name));
    80003d14:	4641                	li	a2,16
    80003d16:	e0043583          	ld	a1,-512(s0)
    80003d1a:	15898513          	addi	a0,s3,344
    80003d1e:	d8afc0ef          	jal	800002a8 <safestrcpy>
  oldpagetable = p->pagetable;
    80003d22:	0509b503          	ld	a0,80(s3)
  p->pagetable = pagetable;
    80003d26:	0569b823          	sd	s6,80(s3)
  p->sz = sz;
    80003d2a:	0549b423          	sd	s4,72(s3)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80003d2e:	0589b783          	ld	a5,88(s3)
    80003d32:	e6843703          	ld	a4,-408(s0)
    80003d36:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80003d38:	0589b783          	ld	a5,88(s3)
    80003d3c:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80003d40:	85d6                	mv	a1,s5
    80003d42:	9a8fd0ef          	jal	80000eea <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80003d46:	0004851b          	sext.w	a0,s1
    80003d4a:	79be                	ld	s3,488(sp)
    80003d4c:	7a1e                	ld	s4,480(sp)
    80003d4e:	6afe                	ld	s5,472(sp)
    80003d50:	6b5e                	ld	s6,464(sp)
    80003d52:	6bbe                	ld	s7,456(sp)
    80003d54:	6c1e                	ld	s8,448(sp)
    80003d56:	7cfa                	ld	s9,440(sp)
    80003d58:	7d5a                	ld	s10,432(sp)
    80003d5a:	7dba                	ld	s11,424(sp)
    80003d5c:	b341                	j	80003adc <kexec+0x6e>
    80003d5e:	6b5e                	ld	s6,464(sp)
    80003d60:	b3bd                	j	80003ace <kexec+0x60>
    return -1;
    80003d62:	df243823          	sd	s2,-528(s0)
    proc_freepagetable(pagetable, sz);
    80003d66:	df043583          	ld	a1,-528(s0)
    80003d6a:	855a                	mv	a0,s6
    80003d6c:	97efd0ef          	jal	80000eea <proc_freepagetable>
  if(ip){
    80003d70:	79be                	ld	s3,488(sp)
    80003d72:	6afe                	ld	s5,472(sp)
    80003d74:	6b5e                	ld	s6,464(sp)
    80003d76:	6bbe                	ld	s7,456(sp)
    80003d78:	6c1e                	ld	s8,448(sp)
    80003d7a:	7cfa                	ld	s9,440(sp)
    80003d7c:	7d5a                	ld	s10,432(sp)
    80003d7e:	7dba                	ld	s11,424(sp)
    80003d80:	b3b9                	j	80003ace <kexec+0x60>

0000000080003d82 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80003d82:	7179                	addi	sp,sp,-48
    80003d84:	f406                	sd	ra,40(sp)
    80003d86:	f022                	sd	s0,32(sp)
    80003d88:	ec26                	sd	s1,24(sp)
    80003d8a:	e84a                	sd	s2,16(sp)
    80003d8c:	1800                	addi	s0,sp,48
    80003d8e:	892e                	mv	s2,a1
    80003d90:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    80003d92:	fdc40593          	addi	a1,s0,-36
    80003d96:	eadfd0ef          	jal	80001c42 <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80003d9a:	fdc42703          	lw	a4,-36(s0)
    80003d9e:	47bd                	li	a5,15
    80003da0:	02e7e963          	bltu	a5,a4,80003dd2 <argfd+0x50>
    80003da4:	fbbfc0ef          	jal	80000d5e <myproc>
    80003da8:	fdc42703          	lw	a4,-36(s0)
    80003dac:	01a70793          	addi	a5,a4,26
    80003db0:	078e                	slli	a5,a5,0x3
    80003db2:	953e                	add	a0,a0,a5
    80003db4:	611c                	ld	a5,0(a0)
    80003db6:	cf91                	beqz	a5,80003dd2 <argfd+0x50>
    return -1;
  if(pfd)
    80003db8:	00090463          	beqz	s2,80003dc0 <argfd+0x3e>
    *pfd = fd;
    80003dbc:	00e92023          	sw	a4,0(s2)
  if(pf)
    80003dc0:	c091                	beqz	s1,80003dc4 <argfd+0x42>
    *pf = f;
    80003dc2:	e09c                	sd	a5,0(s1)
  return 0;
    80003dc4:	4501                	li	a0,0
}
    80003dc6:	70a2                	ld	ra,40(sp)
    80003dc8:	7402                	ld	s0,32(sp)
    80003dca:	64e2                	ld	s1,24(sp)
    80003dcc:	6942                	ld	s2,16(sp)
    80003dce:	6145                	addi	sp,sp,48
    80003dd0:	8082                	ret
    return -1;
    80003dd2:	557d                	li	a0,-1
    80003dd4:	bfcd                	j	80003dc6 <argfd+0x44>

0000000080003dd6 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80003dd6:	1101                	addi	sp,sp,-32
    80003dd8:	ec06                	sd	ra,24(sp)
    80003dda:	e822                	sd	s0,16(sp)
    80003ddc:	e426                	sd	s1,8(sp)
    80003dde:	1000                	addi	s0,sp,32
    80003de0:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80003de2:	f7dfc0ef          	jal	80000d5e <myproc>
    80003de6:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80003de8:	0d050793          	addi	a5,a0,208
    80003dec:	4501                	li	a0,0
    80003dee:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80003df0:	6398                	ld	a4,0(a5)
    80003df2:	cb19                	beqz	a4,80003e08 <fdalloc+0x32>
  for(fd = 0; fd < NOFILE; fd++){
    80003df4:	2505                	addiw	a0,a0,1
    80003df6:	07a1                	addi	a5,a5,8
    80003df8:	fed51ce3          	bne	a0,a3,80003df0 <fdalloc+0x1a>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80003dfc:	557d                	li	a0,-1
}
    80003dfe:	60e2                	ld	ra,24(sp)
    80003e00:	6442                	ld	s0,16(sp)
    80003e02:	64a2                	ld	s1,8(sp)
    80003e04:	6105                	addi	sp,sp,32
    80003e06:	8082                	ret
      p->ofile[fd] = f;
    80003e08:	01a50793          	addi	a5,a0,26
    80003e0c:	078e                	slli	a5,a5,0x3
    80003e0e:	963e                	add	a2,a2,a5
    80003e10:	e204                	sd	s1,0(a2)
      return fd;
    80003e12:	b7f5                	j	80003dfe <fdalloc+0x28>

0000000080003e14 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80003e14:	715d                	addi	sp,sp,-80
    80003e16:	e486                	sd	ra,72(sp)
    80003e18:	e0a2                	sd	s0,64(sp)
    80003e1a:	fc26                	sd	s1,56(sp)
    80003e1c:	f84a                	sd	s2,48(sp)
    80003e1e:	f44e                	sd	s3,40(sp)
    80003e20:	f052                	sd	s4,32(sp)
    80003e22:	ec56                	sd	s5,24(sp)
    80003e24:	e85a                	sd	s6,16(sp)
    80003e26:	0880                	addi	s0,sp,80
    80003e28:	892e                	mv	s2,a1
    80003e2a:	8a2e                	mv	s4,a1
    80003e2c:	8ab2                	mv	s5,a2
    80003e2e:	8b36                	mv	s6,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80003e30:	fb040593          	addi	a1,s0,-80
    80003e34:	826ff0ef          	jal	80002e5a <nameiparent>
    80003e38:	84aa                	mv	s1,a0
    return 0;
    80003e3a:	89aa                	mv	s3,a0
  if((dp = nameiparent(path, name)) == 0)
    80003e3c:	cd05                	beqz	a0,80003e74 <create+0x60>

  ilock(dp);
    80003e3e:	fcafe0ef          	jal	80002608 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80003e42:	4601                	li	a2,0
    80003e44:	fb040593          	addi	a1,s0,-80
    80003e48:	8526                	mv	a0,s1
    80003e4a:	d5bfe0ef          	jal	80002ba4 <dirlookup>
    80003e4e:	89aa                	mv	s3,a0
    80003e50:	c131                	beqz	a0,80003e94 <create+0x80>
    iunlockput(dp);
    80003e52:	8526                	mv	a0,s1
    80003e54:	9c1fe0ef          	jal	80002814 <iunlockput>
    ilock(ip);
    80003e58:	854e                	mv	a0,s3
    80003e5a:	faefe0ef          	jal	80002608 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80003e5e:	4789                	li	a5,2
    80003e60:	02f91563          	bne	s2,a5,80003e8a <create+0x76>
    80003e64:	0449d783          	lhu	a5,68(s3)
    80003e68:	37f9                	addiw	a5,a5,-2
    80003e6a:	17c2                	slli	a5,a5,0x30
    80003e6c:	93c1                	srli	a5,a5,0x30
    80003e6e:	4705                	li	a4,1
    80003e70:	00f76d63          	bltu	a4,a5,80003e8a <create+0x76>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80003e74:	854e                	mv	a0,s3
    80003e76:	60a6                	ld	ra,72(sp)
    80003e78:	6406                	ld	s0,64(sp)
    80003e7a:	74e2                	ld	s1,56(sp)
    80003e7c:	7942                	ld	s2,48(sp)
    80003e7e:	79a2                	ld	s3,40(sp)
    80003e80:	7a02                	ld	s4,32(sp)
    80003e82:	6ae2                	ld	s5,24(sp)
    80003e84:	6b42                	ld	s6,16(sp)
    80003e86:	6161                	addi	sp,sp,80
    80003e88:	8082                	ret
    iunlockput(ip);
    80003e8a:	854e                	mv	a0,s3
    80003e8c:	989fe0ef          	jal	80002814 <iunlockput>
    return 0;
    80003e90:	4981                	li	s3,0
    80003e92:	b7cd                	j	80003e74 <create+0x60>
  if((ip = ialloc(dp->dev, type)) == 0){
    80003e94:	85ca                	mv	a1,s2
    80003e96:	4088                	lw	a0,0(s1)
    80003e98:	e00fe0ef          	jal	80002498 <ialloc>
    80003e9c:	892a                	mv	s2,a0
    80003e9e:	cd15                	beqz	a0,80003eda <create+0xc6>
  ilock(ip);
    80003ea0:	f68fe0ef          	jal	80002608 <ilock>
  ip->major = major;
    80003ea4:	05591323          	sh	s5,70(s2)
  ip->minor = minor;
    80003ea8:	05691423          	sh	s6,72(s2)
  ip->nlink = 1;
    80003eac:	4785                	li	a5,1
    80003eae:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80003eb2:	854a                	mv	a0,s2
    80003eb4:	ea0fe0ef          	jal	80002554 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80003eb8:	4705                	li	a4,1
    80003eba:	02ea0463          	beq	s4,a4,80003ee2 <create+0xce>
  if(dirlink(dp, name, ip->inum) < 0)
    80003ebe:	00492603          	lw	a2,4(s2)
    80003ec2:	fb040593          	addi	a1,s0,-80
    80003ec6:	8526                	mv	a0,s1
    80003ec8:	ecffe0ef          	jal	80002d96 <dirlink>
    80003ecc:	06054263          	bltz	a0,80003f30 <create+0x11c>
  iunlockput(dp);
    80003ed0:	8526                	mv	a0,s1
    80003ed2:	943fe0ef          	jal	80002814 <iunlockput>
    return 0;
    80003ed6:	89ca                	mv	s3,s2
    80003ed8:	bf71                	j	80003e74 <create+0x60>
    iunlockput(dp);
    80003eda:	8526                	mv	a0,s1
    80003edc:	939fe0ef          	jal	80002814 <iunlockput>
    return 0;
    80003ee0:	bfdd                	j	80003ed6 <create+0xc2>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80003ee2:	00492603          	lw	a2,4(s2)
    80003ee6:	00003597          	auipc	a1,0x3
    80003eea:	67a58593          	addi	a1,a1,1658 # 80007560 <etext+0x560>
    80003eee:	854a                	mv	a0,s2
    80003ef0:	ea7fe0ef          	jal	80002d96 <dirlink>
    80003ef4:	02054e63          	bltz	a0,80003f30 <create+0x11c>
    80003ef8:	40d0                	lw	a2,4(s1)
    80003efa:	00003597          	auipc	a1,0x3
    80003efe:	66e58593          	addi	a1,a1,1646 # 80007568 <etext+0x568>
    80003f02:	854a                	mv	a0,s2
    80003f04:	e93fe0ef          	jal	80002d96 <dirlink>
    80003f08:	02054463          	bltz	a0,80003f30 <create+0x11c>
  if(dirlink(dp, name, ip->inum) < 0)
    80003f0c:	00492603          	lw	a2,4(s2)
    80003f10:	fb040593          	addi	a1,s0,-80
    80003f14:	8526                	mv	a0,s1
    80003f16:	e81fe0ef          	jal	80002d96 <dirlink>
    80003f1a:	00054b63          	bltz	a0,80003f30 <create+0x11c>
    dp->nlink++;  // for ".."
    80003f1e:	04a4d783          	lhu	a5,74(s1)
    80003f22:	2785                	addiw	a5,a5,1
    80003f24:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80003f28:	8526                	mv	a0,s1
    80003f2a:	e2afe0ef          	jal	80002554 <iupdate>
    80003f2e:	b74d                	j	80003ed0 <create+0xbc>
  ip->nlink = 0;
    80003f30:	04091523          	sh	zero,74(s2)
  iupdate(ip);
    80003f34:	854a                	mv	a0,s2
    80003f36:	e1efe0ef          	jal	80002554 <iupdate>
  iunlockput(ip);
    80003f3a:	854a                	mv	a0,s2
    80003f3c:	8d9fe0ef          	jal	80002814 <iunlockput>
  iunlockput(dp);
    80003f40:	8526                	mv	a0,s1
    80003f42:	8d3fe0ef          	jal	80002814 <iunlockput>
  return 0;
    80003f46:	b73d                	j	80003e74 <create+0x60>

0000000080003f48 <sys_dup>:
{
    80003f48:	7179                	addi	sp,sp,-48
    80003f4a:	f406                	sd	ra,40(sp)
    80003f4c:	f022                	sd	s0,32(sp)
    80003f4e:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80003f50:	fd840613          	addi	a2,s0,-40
    80003f54:	4581                	li	a1,0
    80003f56:	4501                	li	a0,0
    80003f58:	e2bff0ef          	jal	80003d82 <argfd>
    80003f5c:	02054863          	bltz	a0,80003f8c <sys_dup+0x44>
    80003f60:	ec26                	sd	s1,24(sp)
    80003f62:	e84a                	sd	s2,16(sp)
  if((fd=fdalloc(f)) < 0)
    80003f64:	fd843483          	ld	s1,-40(s0)
    80003f68:	8526                	mv	a0,s1
    80003f6a:	e6dff0ef          	jal	80003dd6 <fdalloc>
    80003f6e:	892a                	mv	s2,a0
    80003f70:	00054c63          	bltz	a0,80003f88 <sys_dup+0x40>
  filedup(f);
    80003f74:	8526                	mv	a0,s1
    80003f76:	c82ff0ef          	jal	800033f8 <filedup>
  return fd;
    80003f7a:	854a                	mv	a0,s2
    80003f7c:	64e2                	ld	s1,24(sp)
    80003f7e:	6942                	ld	s2,16(sp)
}
    80003f80:	70a2                	ld	ra,40(sp)
    80003f82:	7402                	ld	s0,32(sp)
    80003f84:	6145                	addi	sp,sp,48
    80003f86:	8082                	ret
    80003f88:	64e2                	ld	s1,24(sp)
    80003f8a:	6942                	ld	s2,16(sp)
    return -1;
    80003f8c:	557d                	li	a0,-1
    80003f8e:	bfcd                	j	80003f80 <sys_dup+0x38>

0000000080003f90 <sys_read>:
{
    80003f90:	7179                	addi	sp,sp,-48
    80003f92:	f406                	sd	ra,40(sp)
    80003f94:	f022                	sd	s0,32(sp)
    80003f96:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80003f98:	fd840593          	addi	a1,s0,-40
    80003f9c:	4505                	li	a0,1
    80003f9e:	cc1fd0ef          	jal	80001c5e <argaddr>
  argint(2, &n);
    80003fa2:	fe440593          	addi	a1,s0,-28
    80003fa6:	4509                	li	a0,2
    80003fa8:	c9bfd0ef          	jal	80001c42 <argint>
  if(argfd(0, 0, &f) < 0)
    80003fac:	fe840613          	addi	a2,s0,-24
    80003fb0:	4581                	li	a1,0
    80003fb2:	4501                	li	a0,0
    80003fb4:	dcfff0ef          	jal	80003d82 <argfd>
    80003fb8:	87aa                	mv	a5,a0
    return -1;
    80003fba:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80003fbc:	0007ca63          	bltz	a5,80003fd0 <sys_read+0x40>
  return fileread(f, p, n);
    80003fc0:	fe442603          	lw	a2,-28(s0)
    80003fc4:	fd843583          	ld	a1,-40(s0)
    80003fc8:	fe843503          	ld	a0,-24(s0)
    80003fcc:	d96ff0ef          	jal	80003562 <fileread>
}
    80003fd0:	70a2                	ld	ra,40(sp)
    80003fd2:	7402                	ld	s0,32(sp)
    80003fd4:	6145                	addi	sp,sp,48
    80003fd6:	8082                	ret

0000000080003fd8 <sys_write>:
{
    80003fd8:	7179                	addi	sp,sp,-48
    80003fda:	f406                	sd	ra,40(sp)
    80003fdc:	f022                	sd	s0,32(sp)
    80003fde:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80003fe0:	fd840593          	addi	a1,s0,-40
    80003fe4:	4505                	li	a0,1
    80003fe6:	c79fd0ef          	jal	80001c5e <argaddr>
  argint(2, &n);
    80003fea:	fe440593          	addi	a1,s0,-28
    80003fee:	4509                	li	a0,2
    80003ff0:	c53fd0ef          	jal	80001c42 <argint>
  if(argfd(0, 0, &f) < 0)
    80003ff4:	fe840613          	addi	a2,s0,-24
    80003ff8:	4581                	li	a1,0
    80003ffa:	4501                	li	a0,0
    80003ffc:	d87ff0ef          	jal	80003d82 <argfd>
    80004000:	87aa                	mv	a5,a0
    return -1;
    80004002:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004004:	0007ca63          	bltz	a5,80004018 <sys_write+0x40>
  return filewrite(f, p, n);
    80004008:	fe442603          	lw	a2,-28(s0)
    8000400c:	fd843583          	ld	a1,-40(s0)
    80004010:	fe843503          	ld	a0,-24(s0)
    80004014:	e08ff0ef          	jal	8000361c <filewrite>
}
    80004018:	70a2                	ld	ra,40(sp)
    8000401a:	7402                	ld	s0,32(sp)
    8000401c:	6145                	addi	sp,sp,48
    8000401e:	8082                	ret

0000000080004020 <sys_close>:
{
    80004020:	1101                	addi	sp,sp,-32
    80004022:	ec06                	sd	ra,24(sp)
    80004024:	e822                	sd	s0,16(sp)
    80004026:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80004028:	fe040613          	addi	a2,s0,-32
    8000402c:	fec40593          	addi	a1,s0,-20
    80004030:	4501                	li	a0,0
    80004032:	d51ff0ef          	jal	80003d82 <argfd>
    return -1;
    80004036:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004038:	02054063          	bltz	a0,80004058 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
    8000403c:	d23fc0ef          	jal	80000d5e <myproc>
    80004040:	fec42783          	lw	a5,-20(s0)
    80004044:	07e9                	addi	a5,a5,26
    80004046:	078e                	slli	a5,a5,0x3
    80004048:	953e                	add	a0,a0,a5
    8000404a:	00053023          	sd	zero,0(a0)
  fileclose(f);
    8000404e:	fe043503          	ld	a0,-32(s0)
    80004052:	becff0ef          	jal	8000343e <fileclose>
  return 0;
    80004056:	4781                	li	a5,0
}
    80004058:	853e                	mv	a0,a5
    8000405a:	60e2                	ld	ra,24(sp)
    8000405c:	6442                	ld	s0,16(sp)
    8000405e:	6105                	addi	sp,sp,32
    80004060:	8082                	ret

0000000080004062 <sys_fstat>:
{
    80004062:	1101                	addi	sp,sp,-32
    80004064:	ec06                	sd	ra,24(sp)
    80004066:	e822                	sd	s0,16(sp)
    80004068:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    8000406a:	fe040593          	addi	a1,s0,-32
    8000406e:	4505                	li	a0,1
    80004070:	beffd0ef          	jal	80001c5e <argaddr>
  if(argfd(0, 0, &f) < 0)
    80004074:	fe840613          	addi	a2,s0,-24
    80004078:	4581                	li	a1,0
    8000407a:	4501                	li	a0,0
    8000407c:	d07ff0ef          	jal	80003d82 <argfd>
    80004080:	87aa                	mv	a5,a0
    return -1;
    80004082:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004084:	0007c863          	bltz	a5,80004094 <sys_fstat+0x32>
  return filestat(f, st);
    80004088:	fe043583          	ld	a1,-32(s0)
    8000408c:	fe843503          	ld	a0,-24(s0)
    80004090:	c70ff0ef          	jal	80003500 <filestat>
}
    80004094:	60e2                	ld	ra,24(sp)
    80004096:	6442                	ld	s0,16(sp)
    80004098:	6105                	addi	sp,sp,32
    8000409a:	8082                	ret

000000008000409c <sys_link>:
{
    8000409c:	7169                	addi	sp,sp,-304
    8000409e:	f606                	sd	ra,296(sp)
    800040a0:	f222                	sd	s0,288(sp)
    800040a2:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800040a4:	08000613          	li	a2,128
    800040a8:	ed040593          	addi	a1,s0,-304
    800040ac:	4501                	li	a0,0
    800040ae:	bcdfd0ef          	jal	80001c7a <argstr>
    800040b2:	0c054a63          	bltz	a0,80004186 <sys_link+0xea>
    800040b6:	08000613          	li	a2,128
    800040ba:	f5040593          	addi	a1,s0,-176
    800040be:	4505                	li	a0,1
    800040c0:	bbbfd0ef          	jal	80001c7a <argstr>
    800040c4:	0c054163          	bltz	a0,80004186 <sys_link+0xea>
    800040c8:	ee26                	sd	s1,280(sp)
  begin_op();
    800040ca:	f55fe0ef          	jal	8000301e <begin_op>
  if((ip = namei(old)) == 0){
    800040ce:	ed040513          	addi	a0,s0,-304
    800040d2:	d6ffe0ef          	jal	80002e40 <namei>
    800040d6:	84aa                	mv	s1,a0
    800040d8:	c53d                	beqz	a0,80004146 <sys_link+0xaa>
  ilock(ip);
    800040da:	d2efe0ef          	jal	80002608 <ilock>
  if(ip->type == T_DIR){
    800040de:	04449703          	lh	a4,68(s1)
    800040e2:	4785                	li	a5,1
    800040e4:	06f70563          	beq	a4,a5,8000414e <sys_link+0xb2>
    800040e8:	ea4a                	sd	s2,272(sp)
  ip->nlink++;
    800040ea:	04a4d783          	lhu	a5,74(s1)
    800040ee:	2785                	addiw	a5,a5,1
    800040f0:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800040f4:	8526                	mv	a0,s1
    800040f6:	c5efe0ef          	jal	80002554 <iupdate>
  iunlock(ip);
    800040fa:	8526                	mv	a0,s1
    800040fc:	dbafe0ef          	jal	800026b6 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004100:	fd040593          	addi	a1,s0,-48
    80004104:	f5040513          	addi	a0,s0,-176
    80004108:	d53fe0ef          	jal	80002e5a <nameiparent>
    8000410c:	892a                	mv	s2,a0
    8000410e:	c931                	beqz	a0,80004162 <sys_link+0xc6>
  ilock(dp);
    80004110:	cf8fe0ef          	jal	80002608 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004114:	854a                	mv	a0,s2
    80004116:	00092703          	lw	a4,0(s2)
    8000411a:	409c                	lw	a5,0(s1)
    8000411c:	04f71063          	bne	a4,a5,8000415c <sys_link+0xc0>
    80004120:	40d0                	lw	a2,4(s1)
    80004122:	fd040593          	addi	a1,s0,-48
    80004126:	c71fe0ef          	jal	80002d96 <dirlink>
    8000412a:	02054963          	bltz	a0,8000415c <sys_link+0xc0>
  iunlockput(dp);
    8000412e:	854a                	mv	a0,s2
    80004130:	ee4fe0ef          	jal	80002814 <iunlockput>
  iput(ip);
    80004134:	8526                	mv	a0,s1
    80004136:	e54fe0ef          	jal	8000278a <iput>
  end_op();
    8000413a:	f55fe0ef          	jal	8000308e <end_op>
  return 0;
    8000413e:	4501                	li	a0,0
    80004140:	64f2                	ld	s1,280(sp)
    80004142:	6952                	ld	s2,272(sp)
    80004144:	a091                	j	80004188 <sys_link+0xec>
    end_op();
    80004146:	f49fe0ef          	jal	8000308e <end_op>
    return -1;
    8000414a:	64f2                	ld	s1,280(sp)
    8000414c:	a82d                	j	80004186 <sys_link+0xea>
    iunlockput(ip);
    8000414e:	8526                	mv	a0,s1
    80004150:	ec4fe0ef          	jal	80002814 <iunlockput>
    end_op();
    80004154:	f3bfe0ef          	jal	8000308e <end_op>
    return -1;
    80004158:	64f2                	ld	s1,280(sp)
    8000415a:	a035                	j	80004186 <sys_link+0xea>
    iunlockput(dp);
    8000415c:	854a                	mv	a0,s2
    8000415e:	eb6fe0ef          	jal	80002814 <iunlockput>
  ilock(ip);
    80004162:	8526                	mv	a0,s1
    80004164:	ca4fe0ef          	jal	80002608 <ilock>
  ip->nlink--;
    80004168:	04a4d783          	lhu	a5,74(s1)
    8000416c:	37fd                	addiw	a5,a5,-1
    8000416e:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004172:	8526                	mv	a0,s1
    80004174:	be0fe0ef          	jal	80002554 <iupdate>
  iunlockput(ip);
    80004178:	8526                	mv	a0,s1
    8000417a:	e9afe0ef          	jal	80002814 <iunlockput>
  end_op();
    8000417e:	f11fe0ef          	jal	8000308e <end_op>
  return -1;
    80004182:	64f2                	ld	s1,280(sp)
    80004184:	6952                	ld	s2,272(sp)
    return -1;
    80004186:	557d                	li	a0,-1
}
    80004188:	70b2                	ld	ra,296(sp)
    8000418a:	7412                	ld	s0,288(sp)
    8000418c:	6155                	addi	sp,sp,304
    8000418e:	8082                	ret

0000000080004190 <sys_unlink>:
{
    80004190:	7151                	addi	sp,sp,-240
    80004192:	f586                	sd	ra,232(sp)
    80004194:	f1a2                	sd	s0,224(sp)
    80004196:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004198:	08000613          	li	a2,128
    8000419c:	f3040593          	addi	a1,s0,-208
    800041a0:	4501                	li	a0,0
    800041a2:	ad9fd0ef          	jal	80001c7a <argstr>
    800041a6:	14054763          	bltz	a0,800042f4 <sys_unlink+0x164>
    800041aa:	eda6                	sd	s1,216(sp)
  begin_op();
    800041ac:	e73fe0ef          	jal	8000301e <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800041b0:	fb040593          	addi	a1,s0,-80
    800041b4:	f3040513          	addi	a0,s0,-208
    800041b8:	ca3fe0ef          	jal	80002e5a <nameiparent>
    800041bc:	84aa                	mv	s1,a0
    800041be:	c955                	beqz	a0,80004272 <sys_unlink+0xe2>
  ilock(dp);
    800041c0:	c48fe0ef          	jal	80002608 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    800041c4:	00003597          	auipc	a1,0x3
    800041c8:	39c58593          	addi	a1,a1,924 # 80007560 <etext+0x560>
    800041cc:	fb040513          	addi	a0,s0,-80
    800041d0:	9bffe0ef          	jal	80002b8e <namecmp>
    800041d4:	10050a63          	beqz	a0,800042e8 <sys_unlink+0x158>
    800041d8:	00003597          	auipc	a1,0x3
    800041dc:	39058593          	addi	a1,a1,912 # 80007568 <etext+0x568>
    800041e0:	fb040513          	addi	a0,s0,-80
    800041e4:	9abfe0ef          	jal	80002b8e <namecmp>
    800041e8:	10050063          	beqz	a0,800042e8 <sys_unlink+0x158>
    800041ec:	e9ca                	sd	s2,208(sp)
  if((ip = dirlookup(dp, name, &off)) == 0)
    800041ee:	f2c40613          	addi	a2,s0,-212
    800041f2:	fb040593          	addi	a1,s0,-80
    800041f6:	8526                	mv	a0,s1
    800041f8:	9adfe0ef          	jal	80002ba4 <dirlookup>
    800041fc:	892a                	mv	s2,a0
    800041fe:	0e050463          	beqz	a0,800042e6 <sys_unlink+0x156>
    80004202:	e5ce                	sd	s3,200(sp)
  ilock(ip);
    80004204:	c04fe0ef          	jal	80002608 <ilock>
  if(ip->nlink < 1)
    80004208:	04a91783          	lh	a5,74(s2)
    8000420c:	06f05763          	blez	a5,8000427a <sys_unlink+0xea>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004210:	04491703          	lh	a4,68(s2)
    80004214:	4785                	li	a5,1
    80004216:	06f70863          	beq	a4,a5,80004286 <sys_unlink+0xf6>
  memset(&de, 0, sizeof(de));
    8000421a:	fc040993          	addi	s3,s0,-64
    8000421e:	4641                	li	a2,16
    80004220:	4581                	li	a1,0
    80004222:	854e                	mv	a0,s3
    80004224:	f3bfb0ef          	jal	8000015e <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004228:	4741                	li	a4,16
    8000422a:	f2c42683          	lw	a3,-212(s0)
    8000422e:	864e                	mv	a2,s3
    80004230:	4581                	li	a1,0
    80004232:	8526                	mv	a0,s1
    80004234:	859fe0ef          	jal	80002a8c <writei>
    80004238:	47c1                	li	a5,16
    8000423a:	08f51763          	bne	a0,a5,800042c8 <sys_unlink+0x138>
  if(ip->type == T_DIR){
    8000423e:	04491703          	lh	a4,68(s2)
    80004242:	4785                	li	a5,1
    80004244:	08f70863          	beq	a4,a5,800042d4 <sys_unlink+0x144>
  iunlockput(dp);
    80004248:	8526                	mv	a0,s1
    8000424a:	dcafe0ef          	jal	80002814 <iunlockput>
  ip->nlink--;
    8000424e:	04a95783          	lhu	a5,74(s2)
    80004252:	37fd                	addiw	a5,a5,-1
    80004254:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004258:	854a                	mv	a0,s2
    8000425a:	afafe0ef          	jal	80002554 <iupdate>
  iunlockput(ip);
    8000425e:	854a                	mv	a0,s2
    80004260:	db4fe0ef          	jal	80002814 <iunlockput>
  end_op();
    80004264:	e2bfe0ef          	jal	8000308e <end_op>
  return 0;
    80004268:	4501                	li	a0,0
    8000426a:	64ee                	ld	s1,216(sp)
    8000426c:	694e                	ld	s2,208(sp)
    8000426e:	69ae                	ld	s3,200(sp)
    80004270:	a059                	j	800042f6 <sys_unlink+0x166>
    end_op();
    80004272:	e1dfe0ef          	jal	8000308e <end_op>
    return -1;
    80004276:	64ee                	ld	s1,216(sp)
    80004278:	a8b5                	j	800042f4 <sys_unlink+0x164>
    panic("unlink: nlink < 1");
    8000427a:	00003517          	auipc	a0,0x3
    8000427e:	2f650513          	addi	a0,a0,758 # 80007570 <etext+0x570>
    80004282:	2d2010ef          	jal	80005554 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004286:	04c92703          	lw	a4,76(s2)
    8000428a:	02000793          	li	a5,32
    8000428e:	f8e7f6e3          	bgeu	a5,a4,8000421a <sys_unlink+0x8a>
    80004292:	89be                	mv	s3,a5
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004294:	4741                	li	a4,16
    80004296:	86ce                	mv	a3,s3
    80004298:	f1840613          	addi	a2,s0,-232
    8000429c:	4581                	li	a1,0
    8000429e:	854a                	mv	a0,s2
    800042a0:	efafe0ef          	jal	8000299a <readi>
    800042a4:	47c1                	li	a5,16
    800042a6:	00f51b63          	bne	a0,a5,800042bc <sys_unlink+0x12c>
    if(de.inum != 0)
    800042aa:	f1845783          	lhu	a5,-232(s0)
    800042ae:	eba1                	bnez	a5,800042fe <sys_unlink+0x16e>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800042b0:	29c1                	addiw	s3,s3,16
    800042b2:	04c92783          	lw	a5,76(s2)
    800042b6:	fcf9efe3          	bltu	s3,a5,80004294 <sys_unlink+0x104>
    800042ba:	b785                	j	8000421a <sys_unlink+0x8a>
      panic("isdirempty: readi");
    800042bc:	00003517          	auipc	a0,0x3
    800042c0:	2cc50513          	addi	a0,a0,716 # 80007588 <etext+0x588>
    800042c4:	290010ef          	jal	80005554 <panic>
    panic("unlink: writei");
    800042c8:	00003517          	auipc	a0,0x3
    800042cc:	2d850513          	addi	a0,a0,728 # 800075a0 <etext+0x5a0>
    800042d0:	284010ef          	jal	80005554 <panic>
    dp->nlink--;
    800042d4:	04a4d783          	lhu	a5,74(s1)
    800042d8:	37fd                	addiw	a5,a5,-1
    800042da:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    800042de:	8526                	mv	a0,s1
    800042e0:	a74fe0ef          	jal	80002554 <iupdate>
    800042e4:	b795                	j	80004248 <sys_unlink+0xb8>
    800042e6:	694e                	ld	s2,208(sp)
  iunlockput(dp);
    800042e8:	8526                	mv	a0,s1
    800042ea:	d2afe0ef          	jal	80002814 <iunlockput>
  end_op();
    800042ee:	da1fe0ef          	jal	8000308e <end_op>
  return -1;
    800042f2:	64ee                	ld	s1,216(sp)
    return -1;
    800042f4:	557d                	li	a0,-1
}
    800042f6:	70ae                	ld	ra,232(sp)
    800042f8:	740e                	ld	s0,224(sp)
    800042fa:	616d                	addi	sp,sp,240
    800042fc:	8082                	ret
    iunlockput(ip);
    800042fe:	854a                	mv	a0,s2
    80004300:	d14fe0ef          	jal	80002814 <iunlockput>
    goto bad;
    80004304:	694e                	ld	s2,208(sp)
    80004306:	69ae                	ld	s3,200(sp)
    80004308:	b7c5                	j	800042e8 <sys_unlink+0x158>

000000008000430a <sys_open>:

uint64
sys_open(void)
{
    8000430a:	7131                	addi	sp,sp,-192
    8000430c:	fd06                	sd	ra,184(sp)
    8000430e:	f922                	sd	s0,176(sp)
    80004310:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80004312:	f4c40593          	addi	a1,s0,-180
    80004316:	4505                	li	a0,1
    80004318:	92bfd0ef          	jal	80001c42 <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    8000431c:	08000613          	li	a2,128
    80004320:	f5040593          	addi	a1,s0,-176
    80004324:	4501                	li	a0,0
    80004326:	955fd0ef          	jal	80001c7a <argstr>
    8000432a:	10054563          	bltz	a0,80004434 <sys_open+0x12a>
    8000432e:	f526                	sd	s1,168(sp)
    return -1;

  begin_op();
    80004330:	ceffe0ef          	jal	8000301e <begin_op>

  if(omode & O_CREATE){
    80004334:	f4c42783          	lw	a5,-180(s0)
    80004338:	2007f793          	andi	a5,a5,512
    8000433c:	cfd9                	beqz	a5,800043da <sys_open+0xd0>
    ip = create(path, T_FILE, 0, 0);
    8000433e:	4681                	li	a3,0
    80004340:	4601                	li	a2,0
    80004342:	4589                	li	a1,2
    80004344:	f5040513          	addi	a0,s0,-176
    80004348:	acdff0ef          	jal	80003e14 <create>
    8000434c:	84aa                	mv	s1,a0
    if(ip == 0){
    8000434e:	c151                	beqz	a0,800043d2 <sys_open+0xc8>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004350:	04449703          	lh	a4,68(s1)
    80004354:	478d                	li	a5,3
    80004356:	00f71763          	bne	a4,a5,80004364 <sys_open+0x5a>
    8000435a:	0464d703          	lhu	a4,70(s1)
    8000435e:	47a5                	li	a5,9
    80004360:	0ae7e863          	bltu	a5,a4,80004410 <sys_open+0x106>
    80004364:	f14a                	sd	s2,160(sp)
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004366:	834ff0ef          	jal	8000339a <filealloc>
    8000436a:	892a                	mv	s2,a0
    8000436c:	cd4d                	beqz	a0,80004426 <sys_open+0x11c>
    8000436e:	ed4e                	sd	s3,152(sp)
    80004370:	a67ff0ef          	jal	80003dd6 <fdalloc>
    80004374:	89aa                	mv	s3,a0
    80004376:	0a054463          	bltz	a0,8000441e <sys_open+0x114>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    8000437a:	04449703          	lh	a4,68(s1)
    8000437e:	478d                	li	a5,3
    80004380:	0af70f63          	beq	a4,a5,8000443e <sys_open+0x134>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004384:	4789                	li	a5,2
    80004386:	00f92023          	sw	a5,0(s2)
    f->off = 0;
    8000438a:	02092023          	sw	zero,32(s2)
  }
  f->ip = ip;
    8000438e:	00993c23          	sd	s1,24(s2)
  f->readable = !(omode & O_WRONLY);
    80004392:	f4c42783          	lw	a5,-180(s0)
    80004396:	0017f713          	andi	a4,a5,1
    8000439a:	00174713          	xori	a4,a4,1
    8000439e:	00e90423          	sb	a4,8(s2)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    800043a2:	0037f713          	andi	a4,a5,3
    800043a6:	00e03733          	snez	a4,a4
    800043aa:	00e904a3          	sb	a4,9(s2)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    800043ae:	4007f793          	andi	a5,a5,1024
    800043b2:	c791                	beqz	a5,800043be <sys_open+0xb4>
    800043b4:	04449703          	lh	a4,68(s1)
    800043b8:	4789                	li	a5,2
    800043ba:	08f70963          	beq	a4,a5,8000444c <sys_open+0x142>
    itrunc(ip);
  }

  iunlock(ip);
    800043be:	8526                	mv	a0,s1
    800043c0:	af6fe0ef          	jal	800026b6 <iunlock>
  end_op();
    800043c4:	ccbfe0ef          	jal	8000308e <end_op>

  return fd;
    800043c8:	854e                	mv	a0,s3
    800043ca:	74aa                	ld	s1,168(sp)
    800043cc:	790a                	ld	s2,160(sp)
    800043ce:	69ea                	ld	s3,152(sp)
    800043d0:	a09d                	j	80004436 <sys_open+0x12c>
      end_op();
    800043d2:	cbdfe0ef          	jal	8000308e <end_op>
      return -1;
    800043d6:	74aa                	ld	s1,168(sp)
    800043d8:	a8b1                	j	80004434 <sys_open+0x12a>
    if((ip = namei(path)) == 0){
    800043da:	f5040513          	addi	a0,s0,-176
    800043de:	a63fe0ef          	jal	80002e40 <namei>
    800043e2:	84aa                	mv	s1,a0
    800043e4:	c115                	beqz	a0,80004408 <sys_open+0xfe>
    ilock(ip);
    800043e6:	a22fe0ef          	jal	80002608 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    800043ea:	04449703          	lh	a4,68(s1)
    800043ee:	4785                	li	a5,1
    800043f0:	f6f710e3          	bne	a4,a5,80004350 <sys_open+0x46>
    800043f4:	f4c42783          	lw	a5,-180(s0)
    800043f8:	d7b5                	beqz	a5,80004364 <sys_open+0x5a>
      iunlockput(ip);
    800043fa:	8526                	mv	a0,s1
    800043fc:	c18fe0ef          	jal	80002814 <iunlockput>
      end_op();
    80004400:	c8ffe0ef          	jal	8000308e <end_op>
      return -1;
    80004404:	74aa                	ld	s1,168(sp)
    80004406:	a03d                	j	80004434 <sys_open+0x12a>
      end_op();
    80004408:	c87fe0ef          	jal	8000308e <end_op>
      return -1;
    8000440c:	74aa                	ld	s1,168(sp)
    8000440e:	a01d                	j	80004434 <sys_open+0x12a>
    iunlockput(ip);
    80004410:	8526                	mv	a0,s1
    80004412:	c02fe0ef          	jal	80002814 <iunlockput>
    end_op();
    80004416:	c79fe0ef          	jal	8000308e <end_op>
    return -1;
    8000441a:	74aa                	ld	s1,168(sp)
    8000441c:	a821                	j	80004434 <sys_open+0x12a>
      fileclose(f);
    8000441e:	854a                	mv	a0,s2
    80004420:	81eff0ef          	jal	8000343e <fileclose>
    80004424:	69ea                	ld	s3,152(sp)
    iunlockput(ip);
    80004426:	8526                	mv	a0,s1
    80004428:	becfe0ef          	jal	80002814 <iunlockput>
    end_op();
    8000442c:	c63fe0ef          	jal	8000308e <end_op>
    return -1;
    80004430:	74aa                	ld	s1,168(sp)
    80004432:	790a                	ld	s2,160(sp)
    return -1;
    80004434:	557d                	li	a0,-1
}
    80004436:	70ea                	ld	ra,184(sp)
    80004438:	744a                	ld	s0,176(sp)
    8000443a:	6129                	addi	sp,sp,192
    8000443c:	8082                	ret
    f->type = FD_DEVICE;
    8000443e:	00e92023          	sw	a4,0(s2)
    f->major = ip->major;
    80004442:	04649783          	lh	a5,70(s1)
    80004446:	02f91223          	sh	a5,36(s2)
    8000444a:	b791                	j	8000438e <sys_open+0x84>
    itrunc(ip);
    8000444c:	8526                	mv	a0,s1
    8000444e:	aa8fe0ef          	jal	800026f6 <itrunc>
    80004452:	b7b5                	j	800043be <sys_open+0xb4>

0000000080004454 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004454:	7175                	addi	sp,sp,-144
    80004456:	e506                	sd	ra,136(sp)
    80004458:	e122                	sd	s0,128(sp)
    8000445a:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    8000445c:	bc3fe0ef          	jal	8000301e <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004460:	08000613          	li	a2,128
    80004464:	f7040593          	addi	a1,s0,-144
    80004468:	4501                	li	a0,0
    8000446a:	811fd0ef          	jal	80001c7a <argstr>
    8000446e:	02054363          	bltz	a0,80004494 <sys_mkdir+0x40>
    80004472:	4681                	li	a3,0
    80004474:	4601                	li	a2,0
    80004476:	4585                	li	a1,1
    80004478:	f7040513          	addi	a0,s0,-144
    8000447c:	999ff0ef          	jal	80003e14 <create>
    80004480:	c911                	beqz	a0,80004494 <sys_mkdir+0x40>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004482:	b92fe0ef          	jal	80002814 <iunlockput>
  end_op();
    80004486:	c09fe0ef          	jal	8000308e <end_op>
  return 0;
    8000448a:	4501                	li	a0,0
}
    8000448c:	60aa                	ld	ra,136(sp)
    8000448e:	640a                	ld	s0,128(sp)
    80004490:	6149                	addi	sp,sp,144
    80004492:	8082                	ret
    end_op();
    80004494:	bfbfe0ef          	jal	8000308e <end_op>
    return -1;
    80004498:	557d                	li	a0,-1
    8000449a:	bfcd                	j	8000448c <sys_mkdir+0x38>

000000008000449c <sys_mknod>:

uint64
sys_mknod(void)
{
    8000449c:	7135                	addi	sp,sp,-160
    8000449e:	ed06                	sd	ra,152(sp)
    800044a0:	e922                	sd	s0,144(sp)
    800044a2:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    800044a4:	b7bfe0ef          	jal	8000301e <begin_op>
  argint(1, &major);
    800044a8:	f6c40593          	addi	a1,s0,-148
    800044ac:	4505                	li	a0,1
    800044ae:	f94fd0ef          	jal	80001c42 <argint>
  argint(2, &minor);
    800044b2:	f6840593          	addi	a1,s0,-152
    800044b6:	4509                	li	a0,2
    800044b8:	f8afd0ef          	jal	80001c42 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    800044bc:	08000613          	li	a2,128
    800044c0:	f7040593          	addi	a1,s0,-144
    800044c4:	4501                	li	a0,0
    800044c6:	fb4fd0ef          	jal	80001c7a <argstr>
    800044ca:	02054563          	bltz	a0,800044f4 <sys_mknod+0x58>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    800044ce:	f6841683          	lh	a3,-152(s0)
    800044d2:	f6c41603          	lh	a2,-148(s0)
    800044d6:	458d                	li	a1,3
    800044d8:	f7040513          	addi	a0,s0,-144
    800044dc:	939ff0ef          	jal	80003e14 <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    800044e0:	c911                	beqz	a0,800044f4 <sys_mknod+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
    800044e2:	b32fe0ef          	jal	80002814 <iunlockput>
  end_op();
    800044e6:	ba9fe0ef          	jal	8000308e <end_op>
  return 0;
    800044ea:	4501                	li	a0,0
}
    800044ec:	60ea                	ld	ra,152(sp)
    800044ee:	644a                	ld	s0,144(sp)
    800044f0:	610d                	addi	sp,sp,160
    800044f2:	8082                	ret
    end_op();
    800044f4:	b9bfe0ef          	jal	8000308e <end_op>
    return -1;
    800044f8:	557d                	li	a0,-1
    800044fa:	bfcd                	j	800044ec <sys_mknod+0x50>

00000000800044fc <sys_chdir>:

uint64
sys_chdir(void)
{
    800044fc:	7135                	addi	sp,sp,-160
    800044fe:	ed06                	sd	ra,152(sp)
    80004500:	e922                	sd	s0,144(sp)
    80004502:	e14a                	sd	s2,128(sp)
    80004504:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004506:	859fc0ef          	jal	80000d5e <myproc>
    8000450a:	892a                	mv	s2,a0
  
  begin_op();
    8000450c:	b13fe0ef          	jal	8000301e <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004510:	08000613          	li	a2,128
    80004514:	f6040593          	addi	a1,s0,-160
    80004518:	4501                	li	a0,0
    8000451a:	f60fd0ef          	jal	80001c7a <argstr>
    8000451e:	02054f63          	bltz	a0,8000455c <sys_chdir+0x60>
    80004522:	e526                	sd	s1,136(sp)
    80004524:	f6040513          	addi	a0,s0,-160
    80004528:	919fe0ef          	jal	80002e40 <namei>
    8000452c:	84aa                	mv	s1,a0
    8000452e:	c515                	beqz	a0,8000455a <sys_chdir+0x5e>
    end_op();
    return -1;
  }
  ilock(ip);
    80004530:	8d8fe0ef          	jal	80002608 <ilock>
  if(ip->type != T_DIR){
    80004534:	04449703          	lh	a4,68(s1)
    80004538:	4785                	li	a5,1
    8000453a:	02f71963          	bne	a4,a5,8000456c <sys_chdir+0x70>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    8000453e:	8526                	mv	a0,s1
    80004540:	976fe0ef          	jal	800026b6 <iunlock>
  iput(p->cwd);
    80004544:	15093503          	ld	a0,336(s2)
    80004548:	a42fe0ef          	jal	8000278a <iput>
  end_op();
    8000454c:	b43fe0ef          	jal	8000308e <end_op>
  p->cwd = ip;
    80004550:	14993823          	sd	s1,336(s2)
  return 0;
    80004554:	4501                	li	a0,0
    80004556:	64aa                	ld	s1,136(sp)
    80004558:	a029                	j	80004562 <sys_chdir+0x66>
    8000455a:	64aa                	ld	s1,136(sp)
    end_op();
    8000455c:	b33fe0ef          	jal	8000308e <end_op>
    return -1;
    80004560:	557d                	li	a0,-1
}
    80004562:	60ea                	ld	ra,152(sp)
    80004564:	644a                	ld	s0,144(sp)
    80004566:	690a                	ld	s2,128(sp)
    80004568:	610d                	addi	sp,sp,160
    8000456a:	8082                	ret
    iunlockput(ip);
    8000456c:	8526                	mv	a0,s1
    8000456e:	aa6fe0ef          	jal	80002814 <iunlockput>
    end_op();
    80004572:	b1dfe0ef          	jal	8000308e <end_op>
    return -1;
    80004576:	64aa                	ld	s1,136(sp)
    80004578:	b7e5                	j	80004560 <sys_chdir+0x64>

000000008000457a <sys_exec>:

uint64
sys_exec(void)
{
    8000457a:	7105                	addi	sp,sp,-480
    8000457c:	ef86                	sd	ra,472(sp)
    8000457e:	eba2                	sd	s0,464(sp)
    80004580:	1380                	addi	s0,sp,480
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80004582:	e2840593          	addi	a1,s0,-472
    80004586:	4505                	li	a0,1
    80004588:	ed6fd0ef          	jal	80001c5e <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    8000458c:	08000613          	li	a2,128
    80004590:	f3040593          	addi	a1,s0,-208
    80004594:	4501                	li	a0,0
    80004596:	ee4fd0ef          	jal	80001c7a <argstr>
    8000459a:	0c054e63          	bltz	a0,80004676 <sys_exec+0xfc>
    8000459e:	e7a6                	sd	s1,456(sp)
    800045a0:	e3ca                	sd	s2,448(sp)
    800045a2:	ff4e                	sd	s3,440(sp)
    800045a4:	fb52                	sd	s4,432(sp)
    800045a6:	f756                	sd	s5,424(sp)
    800045a8:	f35a                	sd	s6,416(sp)
    800045aa:	ef5e                	sd	s7,408(sp)
    return -1;
  }
  memset(argv, 0, sizeof(argv));
    800045ac:	e3040a13          	addi	s4,s0,-464
    800045b0:	10000613          	li	a2,256
    800045b4:	4581                	li	a1,0
    800045b6:	8552                	mv	a0,s4
    800045b8:	ba7fb0ef          	jal	8000015e <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    800045bc:	84d2                	mv	s1,s4
  memset(argv, 0, sizeof(argv));
    800045be:	89d2                	mv	s3,s4
    800045c0:	4901                	li	s2,0
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800045c2:	e2040a93          	addi	s5,s0,-480
      break;
    }
    argv[i] = kalloc();
    if(argv[i] == 0)
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800045c6:	6b05                	lui	s6,0x1
    if(i >= NELEM(argv)){
    800045c8:	02000b93          	li	s7,32
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800045cc:	00391513          	slli	a0,s2,0x3
    800045d0:	85d6                	mv	a1,s5
    800045d2:	e2843783          	ld	a5,-472(s0)
    800045d6:	953e                	add	a0,a0,a5
    800045d8:	de4fd0ef          	jal	80001bbc <fetchaddr>
    800045dc:	02054663          	bltz	a0,80004608 <sys_exec+0x8e>
    if(uarg == 0){
    800045e0:	e2043783          	ld	a5,-480(s0)
    800045e4:	c3b9                	beqz	a5,8000462a <sys_exec+0xb0>
    argv[i] = kalloc();
    800045e6:	b1ffb0ef          	jal	80000104 <kalloc>
    800045ea:	85aa                	mv	a1,a0
    800045ec:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    800045f0:	cd01                	beqz	a0,80004608 <sys_exec+0x8e>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800045f2:	865a                	mv	a2,s6
    800045f4:	e2043503          	ld	a0,-480(s0)
    800045f8:	e0afd0ef          	jal	80001c02 <fetchstr>
    800045fc:	00054663          	bltz	a0,80004608 <sys_exec+0x8e>
    if(i >= NELEM(argv)){
    80004600:	0905                	addi	s2,s2,1
    80004602:	09a1                	addi	s3,s3,8
    80004604:	fd7914e3          	bne	s2,s7,800045cc <sys_exec+0x52>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004608:	100a0a13          	addi	s4,s4,256
    8000460c:	6088                	ld	a0,0(s1)
    8000460e:	cd29                	beqz	a0,80004668 <sys_exec+0xee>
    kfree(argv[i]);
    80004610:	a0dfb0ef          	jal	8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004614:	04a1                	addi	s1,s1,8
    80004616:	ff449be3          	bne	s1,s4,8000460c <sys_exec+0x92>
    8000461a:	64be                	ld	s1,456(sp)
    8000461c:	691e                	ld	s2,448(sp)
    8000461e:	79fa                	ld	s3,440(sp)
    80004620:	7a5a                	ld	s4,432(sp)
    80004622:	7aba                	ld	s5,424(sp)
    80004624:	7b1a                	ld	s6,416(sp)
    80004626:	6bfa                	ld	s7,408(sp)
    80004628:	a0b9                	j	80004676 <sys_exec+0xfc>
      argv[i] = 0;
    8000462a:	0009079b          	sext.w	a5,s2
    8000462e:	e3040593          	addi	a1,s0,-464
    80004632:	078e                	slli	a5,a5,0x3
    80004634:	97ae                	add	a5,a5,a1
    80004636:	0007b023          	sd	zero,0(a5)
  int ret = kexec(path, argv);
    8000463a:	f3040513          	addi	a0,s0,-208
    8000463e:	c30ff0ef          	jal	80003a6e <kexec>
    80004642:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004644:	100a0a13          	addi	s4,s4,256
    80004648:	6088                	ld	a0,0(s1)
    8000464a:	c511                	beqz	a0,80004656 <sys_exec+0xdc>
    kfree(argv[i]);
    8000464c:	9d1fb0ef          	jal	8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004650:	04a1                	addi	s1,s1,8
    80004652:	ff449be3          	bne	s1,s4,80004648 <sys_exec+0xce>
  return ret;
    80004656:	854a                	mv	a0,s2
    80004658:	64be                	ld	s1,456(sp)
    8000465a:	691e                	ld	s2,448(sp)
    8000465c:	79fa                	ld	s3,440(sp)
    8000465e:	7a5a                	ld	s4,432(sp)
    80004660:	7aba                	ld	s5,424(sp)
    80004662:	7b1a                	ld	s6,416(sp)
    80004664:	6bfa                	ld	s7,408(sp)
    80004666:	a809                	j	80004678 <sys_exec+0xfe>
    80004668:	64be                	ld	s1,456(sp)
    8000466a:	691e                	ld	s2,448(sp)
    8000466c:	79fa                	ld	s3,440(sp)
    8000466e:	7a5a                	ld	s4,432(sp)
    80004670:	7aba                	ld	s5,424(sp)
    80004672:	7b1a                	ld	s6,416(sp)
    80004674:	6bfa                	ld	s7,408(sp)
    return -1;
    80004676:	557d                	li	a0,-1
  return -1;
}
    80004678:	60fe                	ld	ra,472(sp)
    8000467a:	645e                	ld	s0,464(sp)
    8000467c:	613d                	addi	sp,sp,480
    8000467e:	8082                	ret

0000000080004680 <sys_pipe>:

uint64
sys_pipe(void)
{
    80004680:	7139                	addi	sp,sp,-64
    80004682:	fc06                	sd	ra,56(sp)
    80004684:	f822                	sd	s0,48(sp)
    80004686:	f426                	sd	s1,40(sp)
    80004688:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    8000468a:	ed4fc0ef          	jal	80000d5e <myproc>
    8000468e:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    80004690:	fd840593          	addi	a1,s0,-40
    80004694:	4501                	li	a0,0
    80004696:	dc8fd0ef          	jal	80001c5e <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    8000469a:	fc840593          	addi	a1,s0,-56
    8000469e:	fd040513          	addi	a0,s0,-48
    800046a2:	8aaff0ef          	jal	8000374c <pipealloc>
    800046a6:	0a054463          	bltz	a0,8000474e <sys_pipe+0xce>
    return -1;
  fd0 = -1;
    800046aa:	57fd                	li	a5,-1
    800046ac:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800046b0:	fd043503          	ld	a0,-48(s0)
    800046b4:	f22ff0ef          	jal	80003dd6 <fdalloc>
    800046b8:	fca42223          	sw	a0,-60(s0)
    800046bc:	08054163          	bltz	a0,8000473e <sys_pipe+0xbe>
    800046c0:	fc843503          	ld	a0,-56(s0)
    800046c4:	f12ff0ef          	jal	80003dd6 <fdalloc>
    800046c8:	fca42023          	sw	a0,-64(s0)
    800046cc:	06054063          	bltz	a0,8000472c <sys_pipe+0xac>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800046d0:	4691                	li	a3,4
    800046d2:	fc440613          	addi	a2,s0,-60
    800046d6:	fd843583          	ld	a1,-40(s0)
    800046da:	68a8                	ld	a0,80(s1)
    800046dc:	bbafc0ef          	jal	80000a96 <copyout>
    800046e0:	00054f63          	bltz	a0,800046fe <sys_pipe+0x7e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    800046e4:	4691                	li	a3,4
    800046e6:	fc040613          	addi	a2,s0,-64
    800046ea:	fd843583          	ld	a1,-40(s0)
    800046ee:	95b6                	add	a1,a1,a3
    800046f0:	68a8                	ld	a0,80(s1)
    800046f2:	ba4fc0ef          	jal	80000a96 <copyout>
    800046f6:	87aa                	mv	a5,a0
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    800046f8:	4501                	li	a0,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800046fa:	0407db63          	bgez	a5,80004750 <sys_pipe+0xd0>
    p->ofile[fd0] = 0;
    800046fe:	fc442783          	lw	a5,-60(s0)
    80004702:	07e9                	addi	a5,a5,26
    80004704:	078e                	slli	a5,a5,0x3
    80004706:	97a6                	add	a5,a5,s1
    80004708:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    8000470c:	fc042783          	lw	a5,-64(s0)
    80004710:	07e9                	addi	a5,a5,26
    80004712:	078e                	slli	a5,a5,0x3
    80004714:	97a6                	add	a5,a5,s1
    80004716:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    8000471a:	fd043503          	ld	a0,-48(s0)
    8000471e:	d21fe0ef          	jal	8000343e <fileclose>
    fileclose(wf);
    80004722:	fc843503          	ld	a0,-56(s0)
    80004726:	d19fe0ef          	jal	8000343e <fileclose>
    return -1;
    8000472a:	a015                	j	8000474e <sys_pipe+0xce>
    if(fd0 >= 0)
    8000472c:	fc442783          	lw	a5,-60(s0)
    80004730:	0007c763          	bltz	a5,8000473e <sys_pipe+0xbe>
      p->ofile[fd0] = 0;
    80004734:	07e9                	addi	a5,a5,26
    80004736:	078e                	slli	a5,a5,0x3
    80004738:	97a6                	add	a5,a5,s1
    8000473a:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    8000473e:	fd043503          	ld	a0,-48(s0)
    80004742:	cfdfe0ef          	jal	8000343e <fileclose>
    fileclose(wf);
    80004746:	fc843503          	ld	a0,-56(s0)
    8000474a:	cf5fe0ef          	jal	8000343e <fileclose>
    return -1;
    8000474e:	557d                	li	a0,-1
}
    80004750:	70e2                	ld	ra,56(sp)
    80004752:	7442                	ld	s0,48(sp)
    80004754:	74a2                	ld	s1,40(sp)
    80004756:	6121                	addi	sp,sp,64
    80004758:	8082                	ret
    8000475a:	0000                	unimp
    8000475c:	0000                	unimp
	...

0000000080004760 <kernelvec>:
.globl kerneltrap
.globl kernelvec
.align 4
kernelvec:
        # make room to save registers.
        addi sp, sp, -256
    80004760:	7111                	addi	sp,sp,-256

        # save caller-saved registers.
        sd ra, 0(sp)
    80004762:	e006                	sd	ra,0(sp)
        # sd sp, 8(sp)
        sd gp, 16(sp)
    80004764:	e80e                	sd	gp,16(sp)
        sd tp, 24(sp)
    80004766:	ec12                	sd	tp,24(sp)
        sd t0, 32(sp)
    80004768:	f016                	sd	t0,32(sp)
        sd t1, 40(sp)
    8000476a:	f41a                	sd	t1,40(sp)
        sd t2, 48(sp)
    8000476c:	f81e                	sd	t2,48(sp)
        sd a0, 72(sp)
    8000476e:	e4aa                	sd	a0,72(sp)
        sd a1, 80(sp)
    80004770:	e8ae                	sd	a1,80(sp)
        sd a2, 88(sp)
    80004772:	ecb2                	sd	a2,88(sp)
        sd a3, 96(sp)
    80004774:	f0b6                	sd	a3,96(sp)
        sd a4, 104(sp)
    80004776:	f4ba                	sd	a4,104(sp)
        sd a5, 112(sp)
    80004778:	f8be                	sd	a5,112(sp)
        sd a6, 120(sp)
    8000477a:	fcc2                	sd	a6,120(sp)
        sd a7, 128(sp)
    8000477c:	e146                	sd	a7,128(sp)
        sd t3, 216(sp)
    8000477e:	edf2                	sd	t3,216(sp)
        sd t4, 224(sp)
    80004780:	f1f6                	sd	t4,224(sp)
        sd t5, 232(sp)
    80004782:	f5fa                	sd	t5,232(sp)
        sd t6, 240(sp)
    80004784:	f9fe                	sd	t6,240(sp)

        # call the C trap handler in trap.c
        call kerneltrap
    80004786:	b44fd0ef          	jal	80001aca <kerneltrap>

        # restore registers.
        ld ra, 0(sp)
    8000478a:	6082                	ld	ra,0(sp)
        # ld sp, 8(sp)
        ld gp, 16(sp)
    8000478c:	61c2                	ld	gp,16(sp)
        # not tp (contains hartid), in case we moved CPUs
        ld t0, 32(sp)
    8000478e:	7282                	ld	t0,32(sp)
        ld t1, 40(sp)
    80004790:	7322                	ld	t1,40(sp)
        ld t2, 48(sp)
    80004792:	73c2                	ld	t2,48(sp)
        ld a0, 72(sp)
    80004794:	6526                	ld	a0,72(sp)
        ld a1, 80(sp)
    80004796:	65c6                	ld	a1,80(sp)
        ld a2, 88(sp)
    80004798:	6666                	ld	a2,88(sp)
        ld a3, 96(sp)
    8000479a:	7686                	ld	a3,96(sp)
        ld a4, 104(sp)
    8000479c:	7726                	ld	a4,104(sp)
        ld a5, 112(sp)
    8000479e:	77c6                	ld	a5,112(sp)
        ld a6, 120(sp)
    800047a0:	7866                	ld	a6,120(sp)
        ld a7, 128(sp)
    800047a2:	688a                	ld	a7,128(sp)
        ld t3, 216(sp)
    800047a4:	6e6e                	ld	t3,216(sp)
        ld t4, 224(sp)
    800047a6:	7e8e                	ld	t4,224(sp)
        ld t5, 232(sp)
    800047a8:	7f2e                	ld	t5,232(sp)
        ld t6, 240(sp)
    800047aa:	7fce                	ld	t6,240(sp)

        addi sp, sp, 256
    800047ac:	6111                	addi	sp,sp,256

        # return to whatever we were doing in the kernel.
        sret
    800047ae:	10200073          	sret
    800047b2:	00000013          	nop
    800047b6:	00000013          	nop
    800047ba:	00000013          	nop

00000000800047be <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    800047be:	1141                	addi	sp,sp,-16
    800047c0:	e406                	sd	ra,8(sp)
    800047c2:	e022                	sd	s0,0(sp)
    800047c4:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    800047c6:	0c000737          	lui	a4,0xc000
    800047ca:	4785                	li	a5,1
    800047cc:	d71c                	sw	a5,40(a4)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    800047ce:	c35c                	sw	a5,4(a4)
}
    800047d0:	60a2                	ld	ra,8(sp)
    800047d2:	6402                	ld	s0,0(sp)
    800047d4:	0141                	addi	sp,sp,16
    800047d6:	8082                	ret

00000000800047d8 <plicinithart>:

void
plicinithart(void)
{
    800047d8:	1141                	addi	sp,sp,-16
    800047da:	e406                	sd	ra,8(sp)
    800047dc:	e022                	sd	s0,0(sp)
    800047de:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800047e0:	d4afc0ef          	jal	80000d2a <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    800047e4:	0085171b          	slliw	a4,a0,0x8
    800047e8:	0c0027b7          	lui	a5,0xc002
    800047ec:	97ba                	add	a5,a5,a4
    800047ee:	40200713          	li	a4,1026
    800047f2:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    800047f6:	00d5151b          	slliw	a0,a0,0xd
    800047fa:	0c2017b7          	lui	a5,0xc201
    800047fe:	97aa                	add	a5,a5,a0
    80004800:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80004804:	60a2                	ld	ra,8(sp)
    80004806:	6402                	ld	s0,0(sp)
    80004808:	0141                	addi	sp,sp,16
    8000480a:	8082                	ret

000000008000480c <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    8000480c:	1141                	addi	sp,sp,-16
    8000480e:	e406                	sd	ra,8(sp)
    80004810:	e022                	sd	s0,0(sp)
    80004812:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80004814:	d16fc0ef          	jal	80000d2a <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80004818:	00d5151b          	slliw	a0,a0,0xd
    8000481c:	0c2017b7          	lui	a5,0xc201
    80004820:	97aa                	add	a5,a5,a0
  return irq;
}
    80004822:	43c8                	lw	a0,4(a5)
    80004824:	60a2                	ld	ra,8(sp)
    80004826:	6402                	ld	s0,0(sp)
    80004828:	0141                	addi	sp,sp,16
    8000482a:	8082                	ret

000000008000482c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    8000482c:	1101                	addi	sp,sp,-32
    8000482e:	ec06                	sd	ra,24(sp)
    80004830:	e822                	sd	s0,16(sp)
    80004832:	e426                	sd	s1,8(sp)
    80004834:	1000                	addi	s0,sp,32
    80004836:	84aa                	mv	s1,a0
  int hart = cpuid();
    80004838:	cf2fc0ef          	jal	80000d2a <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    8000483c:	00d5179b          	slliw	a5,a0,0xd
    80004840:	0c201737          	lui	a4,0xc201
    80004844:	97ba                	add	a5,a5,a4
    80004846:	c3c4                	sw	s1,4(a5)
}
    80004848:	60e2                	ld	ra,24(sp)
    8000484a:	6442                	ld	s0,16(sp)
    8000484c:	64a2                	ld	s1,8(sp)
    8000484e:	6105                	addi	sp,sp,32
    80004850:	8082                	ret

0000000080004852 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80004852:	1141                	addi	sp,sp,-16
    80004854:	e406                	sd	ra,8(sp)
    80004856:	e022                	sd	s0,0(sp)
    80004858:	0800                	addi	s0,sp,16
  if(i >= NUM)
    8000485a:	479d                	li	a5,7
    8000485c:	04a7ca63          	blt	a5,a0,800048b0 <free_desc+0x5e>
    panic("free_desc 1");
  if(disk.free[i])
    80004860:	00014797          	auipc	a5,0x14
    80004864:	0f078793          	addi	a5,a5,240 # 80018950 <disk>
    80004868:	97aa                	add	a5,a5,a0
    8000486a:	0187c783          	lbu	a5,24(a5)
    8000486e:	e7b9                	bnez	a5,800048bc <free_desc+0x6a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80004870:	00451693          	slli	a3,a0,0x4
    80004874:	00014797          	auipc	a5,0x14
    80004878:	0dc78793          	addi	a5,a5,220 # 80018950 <disk>
    8000487c:	6398                	ld	a4,0(a5)
    8000487e:	9736                	add	a4,a4,a3
    80004880:	00073023          	sd	zero,0(a4) # c201000 <_entry-0x73dff000>
  disk.desc[i].len = 0;
    80004884:	6398                	ld	a4,0(a5)
    80004886:	9736                	add	a4,a4,a3
    80004888:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    8000488c:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    80004890:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    80004894:	97aa                	add	a5,a5,a0
    80004896:	4705                	li	a4,1
    80004898:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    8000489c:	00014517          	auipc	a0,0x14
    800048a0:	0cc50513          	addi	a0,a0,204 # 80018968 <disk+0x18>
    800048a4:	af1fc0ef          	jal	80001394 <wakeup>
}
    800048a8:	60a2                	ld	ra,8(sp)
    800048aa:	6402                	ld	s0,0(sp)
    800048ac:	0141                	addi	sp,sp,16
    800048ae:	8082                	ret
    panic("free_desc 1");
    800048b0:	00003517          	auipc	a0,0x3
    800048b4:	d0050513          	addi	a0,a0,-768 # 800075b0 <etext+0x5b0>
    800048b8:	49d000ef          	jal	80005554 <panic>
    panic("free_desc 2");
    800048bc:	00003517          	auipc	a0,0x3
    800048c0:	d0450513          	addi	a0,a0,-764 # 800075c0 <etext+0x5c0>
    800048c4:	491000ef          	jal	80005554 <panic>

00000000800048c8 <virtio_disk_init>:
{
    800048c8:	1101                	addi	sp,sp,-32
    800048ca:	ec06                	sd	ra,24(sp)
    800048cc:	e822                	sd	s0,16(sp)
    800048ce:	e426                	sd	s1,8(sp)
    800048d0:	e04a                	sd	s2,0(sp)
    800048d2:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    800048d4:	00003597          	auipc	a1,0x3
    800048d8:	cfc58593          	addi	a1,a1,-772 # 800075d0 <etext+0x5d0>
    800048dc:	00014517          	auipc	a0,0x14
    800048e0:	19c50513          	addi	a0,a0,412 # 80018a78 <disk+0x128>
    800048e4:	6a5000ef          	jal	80005788 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800048e8:	100017b7          	lui	a5,0x10001
    800048ec:	4398                	lw	a4,0(a5)
    800048ee:	747277b7          	lui	a5,0x74727
    800048f2:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800048f6:	14f71263          	bne	a4,a5,80004a3a <virtio_disk_init+0x172>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800048fa:	100017b7          	lui	a5,0x10001
    800048fe:	43d8                	lw	a4,4(a5)
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80004900:	4789                	li	a5,2
    80004902:	12f71c63          	bne	a4,a5,80004a3a <virtio_disk_init+0x172>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80004906:	100017b7          	lui	a5,0x10001
    8000490a:	4798                	lw	a4,8(a5)
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    8000490c:	4789                	li	a5,2
    8000490e:	12f71663          	bne	a4,a5,80004a3a <virtio_disk_init+0x172>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80004912:	100017b7          	lui	a5,0x10001
    80004916:	47d8                	lw	a4,12(a5)
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80004918:	554d47b7          	lui	a5,0x554d4
    8000491c:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80004920:	10f71d63          	bne	a4,a5,80004a3a <virtio_disk_init+0x172>
  *R(VIRTIO_MMIO_STATUS) = status;
    80004924:	100017b7          	lui	a5,0x10001
    80004928:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    8000492c:	4705                	li	a4,1
    8000492e:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80004930:	470d                	li	a4,3
    80004932:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80004934:	10001737          	lui	a4,0x10001
    80004938:	4b18                	lw	a4,16(a4)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    8000493a:	c7ffe6b7          	lui	a3,0xc7ffe
    8000493e:	75f68693          	addi	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fddbf7>
    80004942:	8f75                	and	a4,a4,a3
    80004944:	100016b7          	lui	a3,0x10001
    80004948:	d298                	sw	a4,32(a3)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000494a:	472d                	li	a4,11
    8000494c:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    8000494e:	0707a903          	lw	s2,112(a5)
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80004952:	00897793          	andi	a5,s2,8
    80004956:	0e078863          	beqz	a5,80004a46 <virtio_disk_init+0x17e>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    8000495a:	100017b7          	lui	a5,0x10001
    8000495e:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    80004962:	43fc                	lw	a5,68(a5)
    80004964:	0e079763          	bnez	a5,80004a52 <virtio_disk_init+0x18a>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80004968:	100017b7          	lui	a5,0x10001
    8000496c:	5bdc                	lw	a5,52(a5)
  if(max == 0)
    8000496e:	0e078863          	beqz	a5,80004a5e <virtio_disk_init+0x196>
  if(max < NUM)
    80004972:	471d                	li	a4,7
    80004974:	0ef77b63          	bgeu	a4,a5,80004a6a <virtio_disk_init+0x1a2>
  disk.desc = kalloc();
    80004978:	f8cfb0ef          	jal	80000104 <kalloc>
    8000497c:	00014497          	auipc	s1,0x14
    80004980:	fd448493          	addi	s1,s1,-44 # 80018950 <disk>
    80004984:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    80004986:	f7efb0ef          	jal	80000104 <kalloc>
    8000498a:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    8000498c:	f78fb0ef          	jal	80000104 <kalloc>
    80004990:	87aa                	mv	a5,a0
    80004992:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    80004994:	6088                	ld	a0,0(s1)
    80004996:	0e050063          	beqz	a0,80004a76 <virtio_disk_init+0x1ae>
    8000499a:	00014717          	auipc	a4,0x14
    8000499e:	fbe73703          	ld	a4,-66(a4) # 80018958 <disk+0x8>
    800049a2:	00173713          	seqz	a4,a4
    800049a6:	0017b793          	seqz	a5,a5
    800049aa:	8fd9                	or	a5,a5,a4
    800049ac:	e7e9                	bnez	a5,80004a76 <virtio_disk_init+0x1ae>
  memset(disk.desc, 0, PGSIZE);
    800049ae:	6605                	lui	a2,0x1
    800049b0:	4581                	li	a1,0
    800049b2:	facfb0ef          	jal	8000015e <memset>
  memset(disk.avail, 0, PGSIZE);
    800049b6:	00014497          	auipc	s1,0x14
    800049ba:	f9a48493          	addi	s1,s1,-102 # 80018950 <disk>
    800049be:	6605                	lui	a2,0x1
    800049c0:	4581                	li	a1,0
    800049c2:	6488                	ld	a0,8(s1)
    800049c4:	f9afb0ef          	jal	8000015e <memset>
  memset(disk.used, 0, PGSIZE);
    800049c8:	6605                	lui	a2,0x1
    800049ca:	4581                	li	a1,0
    800049cc:	6888                	ld	a0,16(s1)
    800049ce:	f90fb0ef          	jal	8000015e <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800049d2:	100017b7          	lui	a5,0x10001
    800049d6:	4721                	li	a4,8
    800049d8:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    800049da:	4098                	lw	a4,0(s1)
    800049dc:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    800049e0:	40d8                	lw	a4,4(s1)
    800049e2:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    800049e6:	649c                	ld	a5,8(s1)
    800049e8:	10001737          	lui	a4,0x10001
    800049ec:	08f72823          	sw	a5,144(a4) # 10001090 <_entry-0x6fffef70>
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    800049f0:	9781                	srai	a5,a5,0x20
    800049f2:	08f72a23          	sw	a5,148(a4)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    800049f6:	689c                	ld	a5,16(s1)
    800049f8:	0af72023          	sw	a5,160(a4)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    800049fc:	9781                	srai	a5,a5,0x20
    800049fe:	0af72223          	sw	a5,164(a4)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    80004a02:	4785                	li	a5,1
    80004a04:	c37c                	sw	a5,68(a4)
    disk.free[i] = 1;
    80004a06:	00f48c23          	sb	a5,24(s1)
    80004a0a:	00f48ca3          	sb	a5,25(s1)
    80004a0e:	00f48d23          	sb	a5,26(s1)
    80004a12:	00f48da3          	sb	a5,27(s1)
    80004a16:	00f48e23          	sb	a5,28(s1)
    80004a1a:	00f48ea3          	sb	a5,29(s1)
    80004a1e:	00f48f23          	sb	a5,30(s1)
    80004a22:	00f48fa3          	sb	a5,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80004a26:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80004a2a:	07272823          	sw	s2,112(a4)
}
    80004a2e:	60e2                	ld	ra,24(sp)
    80004a30:	6442                	ld	s0,16(sp)
    80004a32:	64a2                	ld	s1,8(sp)
    80004a34:	6902                	ld	s2,0(sp)
    80004a36:	6105                	addi	sp,sp,32
    80004a38:	8082                	ret
    panic("could not find virtio disk");
    80004a3a:	00003517          	auipc	a0,0x3
    80004a3e:	ba650513          	addi	a0,a0,-1114 # 800075e0 <etext+0x5e0>
    80004a42:	313000ef          	jal	80005554 <panic>
    panic("virtio disk FEATURES_OK unset");
    80004a46:	00003517          	auipc	a0,0x3
    80004a4a:	bba50513          	addi	a0,a0,-1094 # 80007600 <etext+0x600>
    80004a4e:	307000ef          	jal	80005554 <panic>
    panic("virtio disk should not be ready");
    80004a52:	00003517          	auipc	a0,0x3
    80004a56:	bce50513          	addi	a0,a0,-1074 # 80007620 <etext+0x620>
    80004a5a:	2fb000ef          	jal	80005554 <panic>
    panic("virtio disk has no queue 0");
    80004a5e:	00003517          	auipc	a0,0x3
    80004a62:	be250513          	addi	a0,a0,-1054 # 80007640 <etext+0x640>
    80004a66:	2ef000ef          	jal	80005554 <panic>
    panic("virtio disk max queue too short");
    80004a6a:	00003517          	auipc	a0,0x3
    80004a6e:	bf650513          	addi	a0,a0,-1034 # 80007660 <etext+0x660>
    80004a72:	2e3000ef          	jal	80005554 <panic>
    panic("virtio disk kalloc");
    80004a76:	00003517          	auipc	a0,0x3
    80004a7a:	c0a50513          	addi	a0,a0,-1014 # 80007680 <etext+0x680>
    80004a7e:	2d7000ef          	jal	80005554 <panic>

0000000080004a82 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80004a82:	711d                	addi	sp,sp,-96
    80004a84:	ec86                	sd	ra,88(sp)
    80004a86:	e8a2                	sd	s0,80(sp)
    80004a88:	e4a6                	sd	s1,72(sp)
    80004a8a:	e0ca                	sd	s2,64(sp)
    80004a8c:	fc4e                	sd	s3,56(sp)
    80004a8e:	f852                	sd	s4,48(sp)
    80004a90:	f456                	sd	s5,40(sp)
    80004a92:	f05a                	sd	s6,32(sp)
    80004a94:	ec5e                	sd	s7,24(sp)
    80004a96:	e862                	sd	s8,16(sp)
    80004a98:	1080                	addi	s0,sp,96
    80004a9a:	89aa                	mv	s3,a0
    80004a9c:	8b2e                	mv	s6,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80004a9e:	00c52b83          	lw	s7,12(a0)
    80004aa2:	001b9b9b          	slliw	s7,s7,0x1
    80004aa6:	1b82                	slli	s7,s7,0x20
    80004aa8:	020bdb93          	srli	s7,s7,0x20

  acquire(&disk.vdisk_lock);
    80004aac:	00014517          	auipc	a0,0x14
    80004ab0:	fcc50513          	addi	a0,a0,-52 # 80018a78 <disk+0x128>
    80004ab4:	55f000ef          	jal	80005812 <acquire>
  for(int i = 0; i < NUM; i++){
    80004ab8:	44a1                	li	s1,8
      disk.free[i] = 0;
    80004aba:	00014a97          	auipc	s5,0x14
    80004abe:	e96a8a93          	addi	s5,s5,-362 # 80018950 <disk>
  for(int i = 0; i < 3; i++){
    80004ac2:	4a0d                	li	s4,3
    idx[i] = alloc_desc();
    80004ac4:	5c7d                	li	s8,-1
    80004ac6:	a095                	j	80004b2a <virtio_disk_rw+0xa8>
      disk.free[i] = 0;
    80004ac8:	00fa8733          	add	a4,s5,a5
    80004acc:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80004ad0:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80004ad2:	0207c563          	bltz	a5,80004afc <virtio_disk_rw+0x7a>
  for(int i = 0; i < 3; i++){
    80004ad6:	2905                	addiw	s2,s2,1
    80004ad8:	0611                	addi	a2,a2,4 # 1004 <_entry-0x7fffeffc>
    80004ada:	05490c63          	beq	s2,s4,80004b32 <virtio_disk_rw+0xb0>
    idx[i] = alloc_desc();
    80004ade:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80004ae0:	00014717          	auipc	a4,0x14
    80004ae4:	e7070713          	addi	a4,a4,-400 # 80018950 <disk>
    80004ae8:	4781                	li	a5,0
    if(disk.free[i]){
    80004aea:	01874683          	lbu	a3,24(a4)
    80004aee:	fee9                	bnez	a3,80004ac8 <virtio_disk_rw+0x46>
  for(int i = 0; i < NUM; i++){
    80004af0:	2785                	addiw	a5,a5,1
    80004af2:	0705                	addi	a4,a4,1
    80004af4:	fe979be3          	bne	a5,s1,80004aea <virtio_disk_rw+0x68>
    idx[i] = alloc_desc();
    80004af8:	0185a023          	sw	s8,0(a1)
      for(int j = 0; j < i; j++)
    80004afc:	01205d63          	blez	s2,80004b16 <virtio_disk_rw+0x94>
        free_desc(idx[j]);
    80004b00:	fa042503          	lw	a0,-96(s0)
    80004b04:	d4fff0ef          	jal	80004852 <free_desc>
      for(int j = 0; j < i; j++)
    80004b08:	4785                	li	a5,1
    80004b0a:	0127d663          	bge	a5,s2,80004b16 <virtio_disk_rw+0x94>
        free_desc(idx[j]);
    80004b0e:	fa442503          	lw	a0,-92(s0)
    80004b12:	d41ff0ef          	jal	80004852 <free_desc>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80004b16:	00014597          	auipc	a1,0x14
    80004b1a:	f6258593          	addi	a1,a1,-158 # 80018a78 <disk+0x128>
    80004b1e:	00014517          	auipc	a0,0x14
    80004b22:	e4a50513          	addi	a0,a0,-438 # 80018968 <disk+0x18>
    80004b26:	823fc0ef          	jal	80001348 <sleep>
  for(int i = 0; i < 3; i++){
    80004b2a:	fa040613          	addi	a2,s0,-96
    80004b2e:	4901                	li	s2,0
    80004b30:	b77d                	j	80004ade <virtio_disk_rw+0x5c>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80004b32:	fa042503          	lw	a0,-96(s0)
    80004b36:	00451693          	slli	a3,a0,0x4

  if(write)
    80004b3a:	00014797          	auipc	a5,0x14
    80004b3e:	e1678793          	addi	a5,a5,-490 # 80018950 <disk>
    80004b42:	00451713          	slli	a4,a0,0x4
    80004b46:	0a070713          	addi	a4,a4,160
    80004b4a:	973e                	add	a4,a4,a5
    80004b4c:	01603633          	snez	a2,s6
    80004b50:	c710                	sw	a2,8(a4)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80004b52:	00072623          	sw	zero,12(a4)
  buf0->sector = sector;
    80004b56:	01773823          	sd	s7,16(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80004b5a:	6398                	ld	a4,0(a5)
    80004b5c:	9736                	add	a4,a4,a3
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80004b5e:	0a868613          	addi	a2,a3,168 # 100010a8 <_entry-0x6fffef58>
    80004b62:	963e                	add	a2,a2,a5
  disk.desc[idx[0]].addr = (uint64) buf0;
    80004b64:	e310                	sd	a2,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80004b66:	6390                	ld	a2,0(a5)
    80004b68:	00d605b3          	add	a1,a2,a3
    80004b6c:	4741                	li	a4,16
    80004b6e:	c598                	sw	a4,8(a1)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80004b70:	4805                	li	a6,1
    80004b72:	01059623          	sh	a6,12(a1)
  disk.desc[idx[0]].next = idx[1];
    80004b76:	fa442703          	lw	a4,-92(s0)
    80004b7a:	00e59723          	sh	a4,14(a1)

  disk.desc[idx[1]].addr = (uint64) b->data;
    80004b7e:	0712                	slli	a4,a4,0x4
    80004b80:	963a                	add	a2,a2,a4
    80004b82:	05898593          	addi	a1,s3,88
    80004b86:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    80004b88:	0007b883          	ld	a7,0(a5)
    80004b8c:	9746                	add	a4,a4,a7
    80004b8e:	40000613          	li	a2,1024
    80004b92:	c710                	sw	a2,8(a4)
  if(write)
    80004b94:	001b3613          	seqz	a2,s6
    80004b98:	0016161b          	slliw	a2,a2,0x1
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80004b9c:	01066633          	or	a2,a2,a6
    80004ba0:	00c71623          	sh	a2,12(a4)
  disk.desc[idx[1]].next = idx[2];
    80004ba4:	fa842583          	lw	a1,-88(s0)
    80004ba8:	00b71723          	sh	a1,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80004bac:	00250613          	addi	a2,a0,2
    80004bb0:	0612                	slli	a2,a2,0x4
    80004bb2:	963e                	add	a2,a2,a5
    80004bb4:	577d                	li	a4,-1
    80004bb6:	00e60823          	sb	a4,16(a2)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80004bba:	0592                	slli	a1,a1,0x4
    80004bbc:	98ae                	add	a7,a7,a1
    80004bbe:	03068713          	addi	a4,a3,48
    80004bc2:	973e                	add	a4,a4,a5
    80004bc4:	00e8b023          	sd	a4,0(a7)
  disk.desc[idx[2]].len = 1;
    80004bc8:	6398                	ld	a4,0(a5)
    80004bca:	972e                	add	a4,a4,a1
    80004bcc:	01072423          	sw	a6,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80004bd0:	4689                	li	a3,2
    80004bd2:	00d71623          	sh	a3,12(a4)
  disk.desc[idx[2]].next = 0;
    80004bd6:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80004bda:	0109a223          	sw	a6,4(s3)
  disk.info[idx[0]].b = b;
    80004bde:	01363423          	sd	s3,8(a2)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80004be2:	6794                	ld	a3,8(a5)
    80004be4:	0026d703          	lhu	a4,2(a3)
    80004be8:	8b1d                	andi	a4,a4,7
    80004bea:	0706                	slli	a4,a4,0x1
    80004bec:	96ba                	add	a3,a3,a4
    80004bee:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    80004bf2:	0330000f          	fence	rw,rw

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80004bf6:	6798                	ld	a4,8(a5)
    80004bf8:	00275783          	lhu	a5,2(a4)
    80004bfc:	2785                	addiw	a5,a5,1
    80004bfe:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80004c02:	0330000f          	fence	rw,rw

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80004c06:	100017b7          	lui	a5,0x10001
    80004c0a:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80004c0e:	0049a783          	lw	a5,4(s3)
    80004c12:	01079f63          	bne	a5,a6,80004c30 <virtio_disk_rw+0x1ae>
    sleep(b, &disk.vdisk_lock);
    80004c16:	00014917          	auipc	s2,0x14
    80004c1a:	e6290913          	addi	s2,s2,-414 # 80018a78 <disk+0x128>
  while(b->disk == 1) {
    80004c1e:	84be                	mv	s1,a5
    sleep(b, &disk.vdisk_lock);
    80004c20:	85ca                	mv	a1,s2
    80004c22:	854e                	mv	a0,s3
    80004c24:	f24fc0ef          	jal	80001348 <sleep>
  while(b->disk == 1) {
    80004c28:	0049a783          	lw	a5,4(s3)
    80004c2c:	fe978ae3          	beq	a5,s1,80004c20 <virtio_disk_rw+0x19e>
  }

  disk.info[idx[0]].b = 0;
    80004c30:	fa042903          	lw	s2,-96(s0)
    80004c34:	00290713          	addi	a4,s2,2
    80004c38:	0712                	slli	a4,a4,0x4
    80004c3a:	00014797          	auipc	a5,0x14
    80004c3e:	d1678793          	addi	a5,a5,-746 # 80018950 <disk>
    80004c42:	97ba                	add	a5,a5,a4
    80004c44:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    80004c48:	00014997          	auipc	s3,0x14
    80004c4c:	d0898993          	addi	s3,s3,-760 # 80018950 <disk>
    80004c50:	00491713          	slli	a4,s2,0x4
    80004c54:	0009b783          	ld	a5,0(s3)
    80004c58:	97ba                	add	a5,a5,a4
    80004c5a:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80004c5e:	854a                	mv	a0,s2
    80004c60:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80004c64:	befff0ef          	jal	80004852 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80004c68:	8885                	andi	s1,s1,1
    80004c6a:	f0fd                	bnez	s1,80004c50 <virtio_disk_rw+0x1ce>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80004c6c:	00014517          	auipc	a0,0x14
    80004c70:	e0c50513          	addi	a0,a0,-500 # 80018a78 <disk+0x128>
    80004c74:	42f000ef          	jal	800058a2 <release>
}
    80004c78:	60e6                	ld	ra,88(sp)
    80004c7a:	6446                	ld	s0,80(sp)
    80004c7c:	64a6                	ld	s1,72(sp)
    80004c7e:	6906                	ld	s2,64(sp)
    80004c80:	79e2                	ld	s3,56(sp)
    80004c82:	7a42                	ld	s4,48(sp)
    80004c84:	7aa2                	ld	s5,40(sp)
    80004c86:	7b02                	ld	s6,32(sp)
    80004c88:	6be2                	ld	s7,24(sp)
    80004c8a:	6c42                	ld	s8,16(sp)
    80004c8c:	6125                	addi	sp,sp,96
    80004c8e:	8082                	ret

0000000080004c90 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80004c90:	1101                	addi	sp,sp,-32
    80004c92:	ec06                	sd	ra,24(sp)
    80004c94:	e822                	sd	s0,16(sp)
    80004c96:	e426                	sd	s1,8(sp)
    80004c98:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80004c9a:	00014497          	auipc	s1,0x14
    80004c9e:	cb648493          	addi	s1,s1,-842 # 80018950 <disk>
    80004ca2:	00014517          	auipc	a0,0x14
    80004ca6:	dd650513          	addi	a0,a0,-554 # 80018a78 <disk+0x128>
    80004caa:	369000ef          	jal	80005812 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80004cae:	100017b7          	lui	a5,0x10001
    80004cb2:	53bc                	lw	a5,96(a5)
    80004cb4:	8b8d                	andi	a5,a5,3
    80004cb6:	10001737          	lui	a4,0x10001
    80004cba:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80004cbc:	0330000f          	fence	rw,rw

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80004cc0:	689c                	ld	a5,16(s1)
    80004cc2:	0204d703          	lhu	a4,32(s1)
    80004cc6:	0027d783          	lhu	a5,2(a5) # 10001002 <_entry-0x6fffeffe>
    80004cca:	04f70663          	beq	a4,a5,80004d16 <virtio_disk_intr+0x86>
    __sync_synchronize();
    80004cce:	0330000f          	fence	rw,rw
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80004cd2:	6898                	ld	a4,16(s1)
    80004cd4:	0204d783          	lhu	a5,32(s1)
    80004cd8:	8b9d                	andi	a5,a5,7
    80004cda:	078e                	slli	a5,a5,0x3
    80004cdc:	97ba                	add	a5,a5,a4
    80004cde:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80004ce0:	00278713          	addi	a4,a5,2
    80004ce4:	0712                	slli	a4,a4,0x4
    80004ce6:	9726                	add	a4,a4,s1
    80004ce8:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    80004cec:	e321                	bnez	a4,80004d2c <virtio_disk_intr+0x9c>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80004cee:	0789                	addi	a5,a5,2
    80004cf0:	0792                	slli	a5,a5,0x4
    80004cf2:	97a6                	add	a5,a5,s1
    80004cf4:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    80004cf6:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80004cfa:	e9afc0ef          	jal	80001394 <wakeup>

    disk.used_idx += 1;
    80004cfe:	0204d783          	lhu	a5,32(s1)
    80004d02:	2785                	addiw	a5,a5,1
    80004d04:	17c2                	slli	a5,a5,0x30
    80004d06:	93c1                	srli	a5,a5,0x30
    80004d08:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80004d0c:	6898                	ld	a4,16(s1)
    80004d0e:	00275703          	lhu	a4,2(a4)
    80004d12:	faf71ee3          	bne	a4,a5,80004cce <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80004d16:	00014517          	auipc	a0,0x14
    80004d1a:	d6250513          	addi	a0,a0,-670 # 80018a78 <disk+0x128>
    80004d1e:	385000ef          	jal	800058a2 <release>
}
    80004d22:	60e2                	ld	ra,24(sp)
    80004d24:	6442                	ld	s0,16(sp)
    80004d26:	64a2                	ld	s1,8(sp)
    80004d28:	6105                	addi	sp,sp,32
    80004d2a:	8082                	ret
      panic("virtio_disk_intr status");
    80004d2c:	00003517          	auipc	a0,0x3
    80004d30:	96c50513          	addi	a0,a0,-1684 # 80007698 <etext+0x698>
    80004d34:	021000ef          	jal	80005554 <panic>

0000000080004d38 <timerinit>:
}

// ask each hart to generate timer interrupts.
void
timerinit()
{
    80004d38:	1141                	addi	sp,sp,-16
    80004d3a:	e406                	sd	ra,8(sp)
    80004d3c:	e022                	sd	s0,0(sp)
    80004d3e:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mie" : "=r" (x) );
    80004d40:	304027f3          	csrr	a5,mie
  // enable supervisor-mode timer interrupts.
  w_mie(r_mie() | MIE_STIE);
    80004d44:	0207e793          	ori	a5,a5,32
  asm volatile("csrw mie, %0" : : "r" (x));
    80004d48:	30479073          	csrw	mie,a5
  asm volatile("csrr %0, 0x30a" : "=r" (x) );
    80004d4c:	30a027f3          	csrr	a5,0x30a
  
  // enable the sstc extension (i.e. stimecmp).
  w_menvcfg(r_menvcfg() | (1L << 63)); 
    80004d50:	577d                	li	a4,-1
    80004d52:	177e                	slli	a4,a4,0x3f
    80004d54:	8fd9                	or	a5,a5,a4
  asm volatile("csrw 0x30a, %0" : : "r" (x));
    80004d56:	30a79073          	csrw	0x30a,a5
  asm volatile("csrr %0, mcounteren" : "=r" (x) );
    80004d5a:	306027f3          	csrr	a5,mcounteren
  
  // allow supervisor to use stimecmp and time.
  w_mcounteren(r_mcounteren() | 2);
    80004d5e:	0027e793          	ori	a5,a5,2
  asm volatile("csrw mcounteren, %0" : : "r" (x));
    80004d62:	30679073          	csrw	mcounteren,a5
  asm volatile("csrr %0, time" : "=r" (x) );
    80004d66:	c01027f3          	rdtime	a5
  
  // ask for the very first timer interrupt.
  w_stimecmp(r_time() + 1000000);
    80004d6a:	000f4737          	lui	a4,0xf4
    80004d6e:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    80004d72:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    80004d74:	14d79073          	csrw	stimecmp,a5
}
    80004d78:	60a2                	ld	ra,8(sp)
    80004d7a:	6402                	ld	s0,0(sp)
    80004d7c:	0141                	addi	sp,sp,16
    80004d7e:	8082                	ret

0000000080004d80 <start>:
{
    80004d80:	1141                	addi	sp,sp,-16
    80004d82:	e406                	sd	ra,8(sp)
    80004d84:	e022                	sd	s0,0(sp)
    80004d86:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80004d88:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80004d8c:	7779                	lui	a4,0xffffe
    80004d8e:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffddc97>
    80004d92:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80004d94:	6705                	lui	a4,0x1
    80004d96:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004d9a:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80004d9c:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80004da0:	ffffb797          	auipc	a5,0xffffb
    80004da4:	56a78793          	addi	a5,a5,1386 # 8000030a <main>
    80004da8:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80004dac:	4781                	li	a5,0
    80004dae:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80004db2:	67c1                	lui	a5,0x10
    80004db4:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004db6:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80004dba:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80004dbe:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE);
    80004dc2:	2207e793          	ori	a5,a5,544
  asm volatile("csrw sie, %0" : : "r" (x));
    80004dc6:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80004dca:	57fd                	li	a5,-1
    80004dcc:	83a9                	srli	a5,a5,0xa
    80004dce:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80004dd2:	47bd                	li	a5,15
    80004dd4:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80004dd8:	f61ff0ef          	jal	80004d38 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80004ddc:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80004de0:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80004de2:	823e                	mv	tp,a5
  asm volatile("mret");
    80004de4:	30200073          	mret
}
    80004de8:	60a2                	ld	ra,8(sp)
    80004dea:	6402                	ld	s0,0(sp)
    80004dec:	0141                	addi	sp,sp,16
    80004dee:	8082                	ret

0000000080004df0 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80004df0:	7119                	addi	sp,sp,-128
    80004df2:	fc86                	sd	ra,120(sp)
    80004df4:	f8a2                	sd	s0,112(sp)
    80004df6:	f4a6                	sd	s1,104(sp)
    80004df8:	0100                	addi	s0,sp,128
  char buf[32];
  int i = 0;

  while(i < n){
    80004dfa:	06c05b63          	blez	a2,80004e70 <consolewrite+0x80>
    80004dfe:	f0ca                	sd	s2,96(sp)
    80004e00:	ecce                	sd	s3,88(sp)
    80004e02:	e8d2                	sd	s4,80(sp)
    80004e04:	e4d6                	sd	s5,72(sp)
    80004e06:	e0da                	sd	s6,64(sp)
    80004e08:	fc5e                	sd	s7,56(sp)
    80004e0a:	f862                	sd	s8,48(sp)
    80004e0c:	f466                	sd	s9,40(sp)
    80004e0e:	f06a                	sd	s10,32(sp)
    80004e10:	8b2a                	mv	s6,a0
    80004e12:	8bae                	mv	s7,a1
    80004e14:	8a32                	mv	s4,a2
  int i = 0;
    80004e16:	4481                	li	s1,0
    int nn = sizeof(buf);
    if(nn > n - i)
    80004e18:	02000c93          	li	s9,32
    80004e1c:	02000d13          	li	s10,32
      nn = n - i;
    if(either_copyin(buf, user_src, src+i, nn) == -1)
    80004e20:	f8040a93          	addi	s5,s0,-128
    80004e24:	5c7d                	li	s8,-1
    80004e26:	a025                	j	80004e4e <consolewrite+0x5e>
    if(nn > n - i)
    80004e28:	0009099b          	sext.w	s3,s2
    if(either_copyin(buf, user_src, src+i, nn) == -1)
    80004e2c:	86ce                	mv	a3,s3
    80004e2e:	01748633          	add	a2,s1,s7
    80004e32:	85da                	mv	a1,s6
    80004e34:	8556                	mv	a0,s5
    80004e36:	8b5fc0ef          	jal	800016ea <either_copyin>
    80004e3a:	03850d63          	beq	a0,s8,80004e74 <consolewrite+0x84>
      break;
    uartwrite(buf, nn);
    80004e3e:	85ce                	mv	a1,s3
    80004e40:	8556                	mv	a0,s5
    80004e42:	7c8000ef          	jal	8000560a <uartwrite>
    i += nn;
    80004e46:	009904bb          	addw	s1,s2,s1
  while(i < n){
    80004e4a:	0144d963          	bge	s1,s4,80004e5c <consolewrite+0x6c>
    if(nn > n - i)
    80004e4e:	409a07bb          	subw	a5,s4,s1
    80004e52:	893e                	mv	s2,a5
    80004e54:	fcfcdae3          	bge	s9,a5,80004e28 <consolewrite+0x38>
    80004e58:	896a                	mv	s2,s10
    80004e5a:	b7f9                	j	80004e28 <consolewrite+0x38>
    80004e5c:	7906                	ld	s2,96(sp)
    80004e5e:	69e6                	ld	s3,88(sp)
    80004e60:	6a46                	ld	s4,80(sp)
    80004e62:	6aa6                	ld	s5,72(sp)
    80004e64:	6b06                	ld	s6,64(sp)
    80004e66:	7be2                	ld	s7,56(sp)
    80004e68:	7c42                	ld	s8,48(sp)
    80004e6a:	7ca2                	ld	s9,40(sp)
    80004e6c:	7d02                	ld	s10,32(sp)
    80004e6e:	a821                	j	80004e86 <consolewrite+0x96>
  int i = 0;
    80004e70:	4481                	li	s1,0
    80004e72:	a811                	j	80004e86 <consolewrite+0x96>
    80004e74:	7906                	ld	s2,96(sp)
    80004e76:	69e6                	ld	s3,88(sp)
    80004e78:	6a46                	ld	s4,80(sp)
    80004e7a:	6aa6                	ld	s5,72(sp)
    80004e7c:	6b06                	ld	s6,64(sp)
    80004e7e:	7be2                	ld	s7,56(sp)
    80004e80:	7c42                	ld	s8,48(sp)
    80004e82:	7ca2                	ld	s9,40(sp)
    80004e84:	7d02                	ld	s10,32(sp)
  }

  return i;
}
    80004e86:	8526                	mv	a0,s1
    80004e88:	70e6                	ld	ra,120(sp)
    80004e8a:	7446                	ld	s0,112(sp)
    80004e8c:	74a6                	ld	s1,104(sp)
    80004e8e:	6109                	addi	sp,sp,128
    80004e90:	8082                	ret

0000000080004e92 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80004e92:	711d                	addi	sp,sp,-96
    80004e94:	ec86                	sd	ra,88(sp)
    80004e96:	e8a2                	sd	s0,80(sp)
    80004e98:	e4a6                	sd	s1,72(sp)
    80004e9a:	e0ca                	sd	s2,64(sp)
    80004e9c:	fc4e                	sd	s3,56(sp)
    80004e9e:	f852                	sd	s4,48(sp)
    80004ea0:	f05a                	sd	s6,32(sp)
    80004ea2:	ec5e                	sd	s7,24(sp)
    80004ea4:	1080                	addi	s0,sp,96
    80004ea6:	8b2a                	mv	s6,a0
    80004ea8:	8a2e                	mv	s4,a1
    80004eaa:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80004eac:	8bb2                	mv	s7,a2
  acquire(&cons.lock);
    80004eae:	0001c517          	auipc	a0,0x1c
    80004eb2:	be250513          	addi	a0,a0,-1054 # 80020a90 <cons>
    80004eb6:	15d000ef          	jal	80005812 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80004eba:	0001c497          	auipc	s1,0x1c
    80004ebe:	bd648493          	addi	s1,s1,-1066 # 80020a90 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80004ec2:	0001c917          	auipc	s2,0x1c
    80004ec6:	c6690913          	addi	s2,s2,-922 # 80020b28 <cons+0x98>
  while(n > 0){
    80004eca:	0b305b63          	blez	s3,80004f80 <consoleread+0xee>
    while(cons.r == cons.w){
    80004ece:	0984a783          	lw	a5,152(s1)
    80004ed2:	09c4a703          	lw	a4,156(s1)
    80004ed6:	0af71063          	bne	a4,a5,80004f76 <consoleread+0xe4>
      if(killed(myproc())){
    80004eda:	e85fb0ef          	jal	80000d5e <myproc>
    80004ede:	ea6fc0ef          	jal	80001584 <killed>
    80004ee2:	e12d                	bnez	a0,80004f44 <consoleread+0xb2>
      sleep(&cons.r, &cons.lock);
    80004ee4:	85a6                	mv	a1,s1
    80004ee6:	854a                	mv	a0,s2
    80004ee8:	c60fc0ef          	jal	80001348 <sleep>
    while(cons.r == cons.w){
    80004eec:	0984a783          	lw	a5,152(s1)
    80004ef0:	09c4a703          	lw	a4,156(s1)
    80004ef4:	fef703e3          	beq	a4,a5,80004eda <consoleread+0x48>
    80004ef8:	f456                	sd	s5,40(sp)
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    80004efa:	0001c717          	auipc	a4,0x1c
    80004efe:	b9670713          	addi	a4,a4,-1130 # 80020a90 <cons>
    80004f02:	0017869b          	addiw	a3,a5,1
    80004f06:	08d72c23          	sw	a3,152(a4)
    80004f0a:	07f7f693          	andi	a3,a5,127
    80004f0e:	9736                	add	a4,a4,a3
    80004f10:	01874703          	lbu	a4,24(a4)
    80004f14:	00070a9b          	sext.w	s5,a4

    if(c == C('D')){  // end-of-file
    80004f18:	4691                	li	a3,4
    80004f1a:	04da8663          	beq	s5,a3,80004f66 <consoleread+0xd4>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80004f1e:	fae407a3          	sb	a4,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80004f22:	4685                	li	a3,1
    80004f24:	faf40613          	addi	a2,s0,-81
    80004f28:	85d2                	mv	a1,s4
    80004f2a:	855a                	mv	a0,s6
    80004f2c:	f74fc0ef          	jal	800016a0 <either_copyout>
    80004f30:	57fd                	li	a5,-1
    80004f32:	04f50663          	beq	a0,a5,80004f7e <consoleread+0xec>
      break;

    dst++;
    80004f36:	0a05                	addi	s4,s4,1
    --n;
    80004f38:	39fd                	addiw	s3,s3,-1

    if(c == '\n'){
    80004f3a:	47a9                	li	a5,10
    80004f3c:	04fa8b63          	beq	s5,a5,80004f92 <consoleread+0x100>
    80004f40:	7aa2                	ld	s5,40(sp)
    80004f42:	b761                	j	80004eca <consoleread+0x38>
        release(&cons.lock);
    80004f44:	0001c517          	auipc	a0,0x1c
    80004f48:	b4c50513          	addi	a0,a0,-1204 # 80020a90 <cons>
    80004f4c:	157000ef          	jal	800058a2 <release>
        return -1;
    80004f50:	557d                	li	a0,-1
    }
  }
  release(&cons.lock);

  return target - n;
}
    80004f52:	60e6                	ld	ra,88(sp)
    80004f54:	6446                	ld	s0,80(sp)
    80004f56:	64a6                	ld	s1,72(sp)
    80004f58:	6906                	ld	s2,64(sp)
    80004f5a:	79e2                	ld	s3,56(sp)
    80004f5c:	7a42                	ld	s4,48(sp)
    80004f5e:	7b02                	ld	s6,32(sp)
    80004f60:	6be2                	ld	s7,24(sp)
    80004f62:	6125                	addi	sp,sp,96
    80004f64:	8082                	ret
      if(n < target){
    80004f66:	0179fa63          	bgeu	s3,s7,80004f7a <consoleread+0xe8>
        cons.r--;
    80004f6a:	0001c717          	auipc	a4,0x1c
    80004f6e:	baf72f23          	sw	a5,-1090(a4) # 80020b28 <cons+0x98>
    80004f72:	7aa2                	ld	s5,40(sp)
    80004f74:	a031                	j	80004f80 <consoleread+0xee>
    80004f76:	f456                	sd	s5,40(sp)
    80004f78:	b749                	j	80004efa <consoleread+0x68>
    80004f7a:	7aa2                	ld	s5,40(sp)
    80004f7c:	a011                	j	80004f80 <consoleread+0xee>
    80004f7e:	7aa2                	ld	s5,40(sp)
  release(&cons.lock);
    80004f80:	0001c517          	auipc	a0,0x1c
    80004f84:	b1050513          	addi	a0,a0,-1264 # 80020a90 <cons>
    80004f88:	11b000ef          	jal	800058a2 <release>
  return target - n;
    80004f8c:	413b853b          	subw	a0,s7,s3
    80004f90:	b7c9                	j	80004f52 <consoleread+0xc0>
    80004f92:	7aa2                	ld	s5,40(sp)
    80004f94:	b7f5                	j	80004f80 <consoleread+0xee>

0000000080004f96 <consputc>:
{
    80004f96:	1141                	addi	sp,sp,-16
    80004f98:	e406                	sd	ra,8(sp)
    80004f9a:	e022                	sd	s0,0(sp)
    80004f9c:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80004f9e:	10000793          	li	a5,256
    80004fa2:	00f50863          	beq	a0,a5,80004fb2 <consputc+0x1c>
    uartputc_sync(c);
    80004fa6:	6f8000ef          	jal	8000569e <uartputc_sync>
}
    80004faa:	60a2                	ld	ra,8(sp)
    80004fac:	6402                	ld	s0,0(sp)
    80004fae:	0141                	addi	sp,sp,16
    80004fb0:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80004fb2:	4521                	li	a0,8
    80004fb4:	6ea000ef          	jal	8000569e <uartputc_sync>
    80004fb8:	02000513          	li	a0,32
    80004fbc:	6e2000ef          	jal	8000569e <uartputc_sync>
    80004fc0:	4521                	li	a0,8
    80004fc2:	6dc000ef          	jal	8000569e <uartputc_sync>
    80004fc6:	b7d5                	j	80004faa <consputc+0x14>

0000000080004fc8 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80004fc8:	1101                	addi	sp,sp,-32
    80004fca:	ec06                	sd	ra,24(sp)
    80004fcc:	e822                	sd	s0,16(sp)
    80004fce:	e426                	sd	s1,8(sp)
    80004fd0:	1000                	addi	s0,sp,32
    80004fd2:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80004fd4:	0001c517          	auipc	a0,0x1c
    80004fd8:	abc50513          	addi	a0,a0,-1348 # 80020a90 <cons>
    80004fdc:	037000ef          	jal	80005812 <acquire>

  switch(c){
    80004fe0:	47d5                	li	a5,21
    80004fe2:	0af48163          	beq	s1,a5,80005084 <consoleintr+0xbc>
    80004fe6:	0297c563          	blt	a5,s1,80005010 <consoleintr+0x48>
    80004fea:	47a1                	li	a5,8
    80004fec:	0ef48663          	beq	s1,a5,800050d8 <consoleintr+0x110>
    80004ff0:	47c1                	li	a5,16
    80004ff2:	10f49763          	bne	s1,a5,80005100 <consoleintr+0x138>
  case C('P'):  // Print process list.
    procdump();
    80004ff6:	f3efc0ef          	jal	80001734 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80004ffa:	0001c517          	auipc	a0,0x1c
    80004ffe:	a9650513          	addi	a0,a0,-1386 # 80020a90 <cons>
    80005002:	0a1000ef          	jal	800058a2 <release>
}
    80005006:	60e2                	ld	ra,24(sp)
    80005008:	6442                	ld	s0,16(sp)
    8000500a:	64a2                	ld	s1,8(sp)
    8000500c:	6105                	addi	sp,sp,32
    8000500e:	8082                	ret
  switch(c){
    80005010:	07f00793          	li	a5,127
    80005014:	0cf48263          	beq	s1,a5,800050d8 <consoleintr+0x110>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005018:	0001c717          	auipc	a4,0x1c
    8000501c:	a7870713          	addi	a4,a4,-1416 # 80020a90 <cons>
    80005020:	0a072783          	lw	a5,160(a4)
    80005024:	09872703          	lw	a4,152(a4)
    80005028:	9f99                	subw	a5,a5,a4
    8000502a:	07f00713          	li	a4,127
    8000502e:	fcf766e3          	bltu	a4,a5,80004ffa <consoleintr+0x32>
      c = (c == '\r') ? '\n' : c;
    80005032:	47b5                	li	a5,13
    80005034:	0cf48963          	beq	s1,a5,80005106 <consoleintr+0x13e>
      consputc(c);
    80005038:	8526                	mv	a0,s1
    8000503a:	f5dff0ef          	jal	80004f96 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    8000503e:	0001c717          	auipc	a4,0x1c
    80005042:	a5270713          	addi	a4,a4,-1454 # 80020a90 <cons>
    80005046:	0a072683          	lw	a3,160(a4)
    8000504a:	0016879b          	addiw	a5,a3,1
    8000504e:	863e                	mv	a2,a5
    80005050:	0af72023          	sw	a5,160(a4)
    80005054:	07f6f693          	andi	a3,a3,127
    80005058:	9736                	add	a4,a4,a3
    8000505a:	00970c23          	sb	s1,24(a4)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    8000505e:	ff648713          	addi	a4,s1,-10
    80005062:	00173713          	seqz	a4,a4
    80005066:	14f1                	addi	s1,s1,-4
    80005068:	0014b493          	seqz	s1,s1
    8000506c:	8f45                	or	a4,a4,s1
    8000506e:	e361                	bnez	a4,8000512e <consoleintr+0x166>
    80005070:	0001c717          	auipc	a4,0x1c
    80005074:	ab872703          	lw	a4,-1352(a4) # 80020b28 <cons+0x98>
    80005078:	9f99                	subw	a5,a5,a4
    8000507a:	08000713          	li	a4,128
    8000507e:	f6e79ee3          	bne	a5,a4,80004ffa <consoleintr+0x32>
    80005082:	a075                	j	8000512e <consoleintr+0x166>
    80005084:	e04a                	sd	s2,0(sp)
    while(cons.e != cons.w &&
    80005086:	0001c717          	auipc	a4,0x1c
    8000508a:	a0a70713          	addi	a4,a4,-1526 # 80020a90 <cons>
    8000508e:	0a072783          	lw	a5,160(a4)
    80005092:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005096:	0001c497          	auipc	s1,0x1c
    8000509a:	9fa48493          	addi	s1,s1,-1542 # 80020a90 <cons>
    while(cons.e != cons.w &&
    8000509e:	4929                	li	s2,10
    800050a0:	02f70863          	beq	a4,a5,800050d0 <consoleintr+0x108>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    800050a4:	37fd                	addiw	a5,a5,-1
    800050a6:	07f7f713          	andi	a4,a5,127
    800050aa:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    800050ac:	01874703          	lbu	a4,24(a4)
    800050b0:	03270263          	beq	a4,s2,800050d4 <consoleintr+0x10c>
      cons.e--;
    800050b4:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    800050b8:	10000513          	li	a0,256
    800050bc:	edbff0ef          	jal	80004f96 <consputc>
    while(cons.e != cons.w &&
    800050c0:	0a04a783          	lw	a5,160(s1)
    800050c4:	09c4a703          	lw	a4,156(s1)
    800050c8:	fcf71ee3          	bne	a4,a5,800050a4 <consoleintr+0xdc>
    800050cc:	6902                	ld	s2,0(sp)
    800050ce:	b735                	j	80004ffa <consoleintr+0x32>
    800050d0:	6902                	ld	s2,0(sp)
    800050d2:	b725                	j	80004ffa <consoleintr+0x32>
    800050d4:	6902                	ld	s2,0(sp)
    800050d6:	b715                	j	80004ffa <consoleintr+0x32>
    if(cons.e != cons.w){
    800050d8:	0001c717          	auipc	a4,0x1c
    800050dc:	9b870713          	addi	a4,a4,-1608 # 80020a90 <cons>
    800050e0:	0a072783          	lw	a5,160(a4)
    800050e4:	09c72703          	lw	a4,156(a4)
    800050e8:	f0f709e3          	beq	a4,a5,80004ffa <consoleintr+0x32>
      cons.e--;
    800050ec:	37fd                	addiw	a5,a5,-1
    800050ee:	0001c717          	auipc	a4,0x1c
    800050f2:	a4f72123          	sw	a5,-1470(a4) # 80020b30 <cons+0xa0>
      consputc(BACKSPACE);
    800050f6:	10000513          	li	a0,256
    800050fa:	e9dff0ef          	jal	80004f96 <consputc>
    800050fe:	bdf5                	j	80004ffa <consoleintr+0x32>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005100:	ee048de3          	beqz	s1,80004ffa <consoleintr+0x32>
    80005104:	bf11                	j	80005018 <consoleintr+0x50>
      consputc(c);
    80005106:	4529                	li	a0,10
    80005108:	e8fff0ef          	jal	80004f96 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    8000510c:	0001c797          	auipc	a5,0x1c
    80005110:	98478793          	addi	a5,a5,-1660 # 80020a90 <cons>
    80005114:	0a07a703          	lw	a4,160(a5)
    80005118:	0017069b          	addiw	a3,a4,1
    8000511c:	8636                	mv	a2,a3
    8000511e:	0ad7a023          	sw	a3,160(a5)
    80005122:	07f77713          	andi	a4,a4,127
    80005126:	97ba                	add	a5,a5,a4
    80005128:	4729                	li	a4,10
    8000512a:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    8000512e:	0001c797          	auipc	a5,0x1c
    80005132:	9ec7af23          	sw	a2,-1538(a5) # 80020b2c <cons+0x9c>
        wakeup(&cons.r);
    80005136:	0001c517          	auipc	a0,0x1c
    8000513a:	9f250513          	addi	a0,a0,-1550 # 80020b28 <cons+0x98>
    8000513e:	a56fc0ef          	jal	80001394 <wakeup>
    80005142:	bd65                	j	80004ffa <consoleintr+0x32>

0000000080005144 <consoleinit>:

void
consoleinit(void)
{
    80005144:	1141                	addi	sp,sp,-16
    80005146:	e406                	sd	ra,8(sp)
    80005148:	e022                	sd	s0,0(sp)
    8000514a:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    8000514c:	00002597          	auipc	a1,0x2
    80005150:	56458593          	addi	a1,a1,1380 # 800076b0 <etext+0x6b0>
    80005154:	0001c517          	auipc	a0,0x1c
    80005158:	93c50513          	addi	a0,a0,-1732 # 80020a90 <cons>
    8000515c:	62c000ef          	jal	80005788 <initlock>

  uartinit();
    80005160:	454000ef          	jal	800055b4 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005164:	00012797          	auipc	a5,0x12
    80005168:	79478793          	addi	a5,a5,1940 # 800178f8 <devsw>
    8000516c:	00000717          	auipc	a4,0x0
    80005170:	d2670713          	addi	a4,a4,-730 # 80004e92 <consoleread>
    80005174:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005176:	00000717          	auipc	a4,0x0
    8000517a:	c7a70713          	addi	a4,a4,-902 # 80004df0 <consolewrite>
    8000517e:	ef98                	sd	a4,24(a5)
}
    80005180:	60a2                	ld	ra,8(sp)
    80005182:	6402                	ld	s0,0(sp)
    80005184:	0141                	addi	sp,sp,16
    80005186:	8082                	ret

0000000080005188 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(long long xx, int base, int sign)
{
    80005188:	7139                	addi	sp,sp,-64
    8000518a:	fc06                	sd	ra,56(sp)
    8000518c:	f822                	sd	s0,48(sp)
    8000518e:	f04a                	sd	s2,32(sp)
    80005190:	0080                	addi	s0,sp,64
  char buf[20];
  int i;
  unsigned long long x;

  if(sign && (sign = (xx < 0)))
    80005192:	c219                	beqz	a2,80005198 <printint+0x10>
    80005194:	08054063          	bltz	a0,80005214 <printint+0x8c>
    x = -xx;
  else
    x = xx;
    80005198:	4301                	li	t1,0

  i = 0;
    8000519a:	fc840913          	addi	s2,s0,-56
    x = xx;
    8000519e:	86ca                	mv	a3,s2
  i = 0;
    800051a0:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800051a2:	00002817          	auipc	a6,0x2
    800051a6:	66680813          	addi	a6,a6,1638 # 80007808 <digits>
    800051aa:	88ba                	mv	a7,a4
    800051ac:	0017061b          	addiw	a2,a4,1
    800051b0:	8732                	mv	a4,a2
    800051b2:	02b577b3          	remu	a5,a0,a1
    800051b6:	97c2                	add	a5,a5,a6
    800051b8:	0007c783          	lbu	a5,0(a5)
    800051bc:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    800051c0:	87aa                	mv	a5,a0
    800051c2:	02b55533          	divu	a0,a0,a1
    800051c6:	0685                	addi	a3,a3,1
    800051c8:	feb7f1e3          	bgeu	a5,a1,800051aa <printint+0x22>

  if(sign)
    800051cc:	00030b63          	beqz	t1,800051e2 <printint+0x5a>
    buf[i++] = '-';
    800051d0:	fe040793          	addi	a5,s0,-32
    800051d4:	963e                	add	a2,a2,a5
    800051d6:	02d00793          	li	a5,45
    800051da:	fef60423          	sb	a5,-24(a2)
    800051de:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
    800051e2:	02e05463          	blez	a4,8000520a <printint+0x82>
    800051e6:	f426                	sd	s1,40(sp)
    800051e8:	377d                	addiw	a4,a4,-1
    800051ea:	00e904b3          	add	s1,s2,a4
    800051ee:	197d                	addi	s2,s2,-1
    800051f0:	993a                	add	s2,s2,a4
    800051f2:	1702                	slli	a4,a4,0x20
    800051f4:	9301                	srli	a4,a4,0x20
    800051f6:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    800051fa:	0004c503          	lbu	a0,0(s1)
    800051fe:	d99ff0ef          	jal	80004f96 <consputc>
  while(--i >= 0)
    80005202:	14fd                	addi	s1,s1,-1
    80005204:	ff249be3          	bne	s1,s2,800051fa <printint+0x72>
    80005208:	74a2                	ld	s1,40(sp)
}
    8000520a:	70e2                	ld	ra,56(sp)
    8000520c:	7442                	ld	s0,48(sp)
    8000520e:	7902                	ld	s2,32(sp)
    80005210:	6121                	addi	sp,sp,64
    80005212:	8082                	ret
    x = -xx;
    80005214:	40a00533          	neg	a0,a0
  if(sign && (sign = (xx < 0)))
    80005218:	4305                	li	t1,1
    x = -xx;
    8000521a:	b741                	j	8000519a <printint+0x12>

000000008000521c <printf>:
}

// Print to the console.
int
printf(char *fmt, ...)
{
    8000521c:	7131                	addi	sp,sp,-192
    8000521e:	fc86                	sd	ra,120(sp)
    80005220:	f8a2                	sd	s0,112(sp)
    80005222:	f4a6                	sd	s1,104(sp)
    80005224:	0100                	addi	s0,sp,128
    80005226:	84aa                	mv	s1,a0
    80005228:	e40c                	sd	a1,8(s0)
    8000522a:	e810                	sd	a2,16(s0)
    8000522c:	ec14                	sd	a3,24(s0)
    8000522e:	f018                	sd	a4,32(s0)
    80005230:	f41c                	sd	a5,40(s0)
    80005232:	03043823          	sd	a6,48(s0)
    80005236:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, cx, c0, c1, c2;
  char *s;

  if(panicking == 0)
    8000523a:	00002797          	auipc	a5,0x2
    8000523e:	6167a783          	lw	a5,1558(a5) # 80007850 <panicking>
    80005242:	cf9d                	beqz	a5,80005280 <printf+0x64>
    acquire(&pr.lock);

  va_start(ap, fmt);
    80005244:	00840793          	addi	a5,s0,8
    80005248:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    8000524c:	0004c503          	lbu	a0,0(s1)
    80005250:	22050363          	beqz	a0,80005476 <printf+0x25a>
    80005254:	f0ca                	sd	s2,96(sp)
    80005256:	ecce                	sd	s3,88(sp)
    80005258:	e8d2                	sd	s4,80(sp)
    8000525a:	e4d6                	sd	s5,72(sp)
    8000525c:	e0da                	sd	s6,64(sp)
    8000525e:	fc5e                	sd	s7,56(sp)
    80005260:	f862                	sd	s8,48(sp)
    80005262:	f06a                	sd	s10,32(sp)
    80005264:	ec6e                	sd	s11,24(sp)
    80005266:	4a01                	li	s4,0
    if(cx != '%'){
    80005268:	02500993          	li	s3,37
      printint(va_arg(ap, uint64), 10, 1);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
      printint(va_arg(ap, uint64), 10, 1);
      i += 2;
    } else if(c0 == 'u'){
    8000526c:	07500c13          	li	s8,117
      printint(va_arg(ap, uint64), 10, 0);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
      printint(va_arg(ap, uint64), 10, 0);
      i += 2;
    } else if(c0 == 'x'){
    80005270:	07800d13          	li	s10,120
      printint(va_arg(ap, uint64), 16, 0);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
      printint(va_arg(ap, uint64), 16, 0);
      i += 2;
    } else if(c0 == 'p'){
    80005274:	07000d93          	li	s11,112
      printint(va_arg(ap, uint64), 10, 0);
    80005278:	4b29                	li	s6,10
    if(c0 == 'd'){
    8000527a:	06400b93          	li	s7,100
    8000527e:	a015                	j	800052a2 <printf+0x86>
    acquire(&pr.lock);
    80005280:	0001c517          	auipc	a0,0x1c
    80005284:	8b850513          	addi	a0,a0,-1864 # 80020b38 <pr>
    80005288:	58a000ef          	jal	80005812 <acquire>
    8000528c:	bf65                	j	80005244 <printf+0x28>
      consputc(cx);
    8000528e:	d09ff0ef          	jal	80004f96 <consputc>
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    80005292:	001a079b          	addiw	a5,s4,1
    80005296:	8a3e                	mv	s4,a5
    80005298:	97a6                	add	a5,a5,s1
    8000529a:	0007c503          	lbu	a0,0(a5)
    8000529e:	1c050363          	beqz	a0,80005464 <printf+0x248>
    if(cx != '%'){
    800052a2:	ff3516e3          	bne	a0,s3,8000528e <printf+0x72>
    i++;
    800052a6:	001a091b          	addiw	s2,s4,1
    c0 = fmt[i+0] & 0xff;
    800052aa:	012487b3          	add	a5,s1,s2
    800052ae:	0007ca83          	lbu	s5,0(a5)
    if(c0) c1 = fmt[i+1] & 0xff;
    800052b2:	200a8763          	beqz	s5,800054c0 <printf+0x2a4>
    800052b6:	0017c703          	lbu	a4,1(a5)
    if(c1) c2 = fmt[i+2] & 0xff;
    800052ba:	1e070a63          	beqz	a4,800054ae <printf+0x292>
    if(c0 == 'd'){
    800052be:	037a8963          	beq	s5,s7,800052f0 <printf+0xd4>
    } else if(c0 == 'l' && c1 == 'd'){
    800052c2:	f94a8793          	addi	a5,s5,-108
    800052c6:	0017b793          	seqz	a5,a5
    800052ca:	f9c70693          	addi	a3,a4,-100
    800052ce:	0016b693          	seqz	a3,a3
    800052d2:	8efd                	and	a3,a3,a5
    800052d4:	ca9d                	beqz	a3,8000530a <printf+0xee>
      printint(va_arg(ap, uint64), 10, 1);
    800052d6:	f8843783          	ld	a5,-120(s0)
    800052da:	00878713          	addi	a4,a5,8
    800052de:	f8e43423          	sd	a4,-120(s0)
    800052e2:	4605                	li	a2,1
    800052e4:	85da                	mv	a1,s6
    800052e6:	6388                	ld	a0,0(a5)
    800052e8:	ea1ff0ef          	jal	80005188 <printint>
      i += 1;
    800052ec:	2a09                	addiw	s4,s4,2
    800052ee:	b755                	j	80005292 <printf+0x76>
      printint(va_arg(ap, int), 10, 1);
    800052f0:	f8843783          	ld	a5,-120(s0)
    800052f4:	00878713          	addi	a4,a5,8
    800052f8:	f8e43423          	sd	a4,-120(s0)
    800052fc:	4605                	li	a2,1
    800052fe:	85da                	mv	a1,s6
    80005300:	4388                	lw	a0,0(a5)
    80005302:	e87ff0ef          	jal	80005188 <printint>
    i++;
    80005306:	8a4a                	mv	s4,s2
    80005308:	b769                	j	80005292 <printf+0x76>
    if(c1) c2 = fmt[i+2] & 0xff;
    8000530a:	012486b3          	add	a3,s1,s2
    8000530e:	863a                	mv	a2,a4
    80005310:	0026c703          	lbu	a4,2(a3)
    80005314:	aa65                	j	800054cc <printf+0x2b0>
      printint(va_arg(ap, uint64), 10, 1);
    80005316:	f8843783          	ld	a5,-120(s0)
    8000531a:	00878713          	addi	a4,a5,8
    8000531e:	f8e43423          	sd	a4,-120(s0)
    80005322:	4605                	li	a2,1
    80005324:	45a9                	li	a1,10
    80005326:	6388                	ld	a0,0(a5)
    80005328:	e61ff0ef          	jal	80005188 <printint>
      i += 2;
    8000532c:	2a0d                	addiw	s4,s4,3
    8000532e:	b795                	j	80005292 <printf+0x76>
      printint(va_arg(ap, uint32), 10, 0);
    80005330:	f8843783          	ld	a5,-120(s0)
    80005334:	00878713          	addi	a4,a5,8
    80005338:	f8e43423          	sd	a4,-120(s0)
    8000533c:	4601                	li	a2,0
    8000533e:	85da                	mv	a1,s6
    80005340:	0007e503          	lwu	a0,0(a5)
    80005344:	e45ff0ef          	jal	80005188 <printint>
    80005348:	bf7d                	j	80005306 <printf+0xea>
      printint(va_arg(ap, uint64), 10, 0);
    8000534a:	f8843783          	ld	a5,-120(s0)
    8000534e:	00878713          	addi	a4,a5,8
    80005352:	f8e43423          	sd	a4,-120(s0)
    80005356:	4601                	li	a2,0
    80005358:	85da                	mv	a1,s6
    8000535a:	6388                	ld	a0,0(a5)
    8000535c:	e2dff0ef          	jal	80005188 <printint>
      i += 1;
    80005360:	2a09                	addiw	s4,s4,2
    80005362:	bf05                	j	80005292 <printf+0x76>
      printint(va_arg(ap, uint64), 10, 0);
    80005364:	f8843783          	ld	a5,-120(s0)
    80005368:	00878713          	addi	a4,a5,8
    8000536c:	f8e43423          	sd	a4,-120(s0)
    80005370:	4601                	li	a2,0
    80005372:	45a9                	li	a1,10
    80005374:	6388                	ld	a0,0(a5)
    80005376:	e13ff0ef          	jal	80005188 <printint>
      i += 2;
    8000537a:	2a0d                	addiw	s4,s4,3
    8000537c:	bf19                	j	80005292 <printf+0x76>
      printint(va_arg(ap, uint32), 16, 0);
    8000537e:	f8843783          	ld	a5,-120(s0)
    80005382:	00878713          	addi	a4,a5,8
    80005386:	f8e43423          	sd	a4,-120(s0)
    8000538a:	4601                	li	a2,0
    8000538c:	45c1                	li	a1,16
    8000538e:	0007e503          	lwu	a0,0(a5)
    80005392:	df7ff0ef          	jal	80005188 <printint>
    80005396:	bf85                	j	80005306 <printf+0xea>
      printint(va_arg(ap, uint64), 16, 0);
    80005398:	f8843783          	ld	a5,-120(s0)
    8000539c:	00878713          	addi	a4,a5,8
    800053a0:	f8e43423          	sd	a4,-120(s0)
    800053a4:	4601                	li	a2,0
    800053a6:	45c1                	li	a1,16
    800053a8:	6388                	ld	a0,0(a5)
    800053aa:	ddfff0ef          	jal	80005188 <printint>
      i += 1;
    800053ae:	2a09                	addiw	s4,s4,2
    800053b0:	b5cd                	j	80005292 <printf+0x76>
      printint(va_arg(ap, uint64), 16, 0);
    800053b2:	f8843783          	ld	a5,-120(s0)
    800053b6:	00878713          	addi	a4,a5,8
    800053ba:	f8e43423          	sd	a4,-120(s0)
    800053be:	45c1                	li	a1,16
    800053c0:	6388                	ld	a0,0(a5)
    800053c2:	dc7ff0ef          	jal	80005188 <printint>
      i += 2;
    800053c6:	2a0d                	addiw	s4,s4,3
    800053c8:	b5e9                	j	80005292 <printf+0x76>
    800053ca:	f466                	sd	s9,40(sp)
      printptr(va_arg(ap, uint64));
    800053cc:	f8843783          	ld	a5,-120(s0)
    800053d0:	00878713          	addi	a4,a5,8
    800053d4:	f8e43423          	sd	a4,-120(s0)
    800053d8:	0007ba83          	ld	s5,0(a5)
  consputc('0');
    800053dc:	03000513          	li	a0,48
    800053e0:	bb7ff0ef          	jal	80004f96 <consputc>
  consputc('x');
    800053e4:	07800513          	li	a0,120
    800053e8:	bafff0ef          	jal	80004f96 <consputc>
    800053ec:	4a41                	li	s4,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800053ee:	00002c97          	auipc	s9,0x2
    800053f2:	41ac8c93          	addi	s9,s9,1050 # 80007808 <digits>
    800053f6:	03cad793          	srli	a5,s5,0x3c
    800053fa:	97e6                	add	a5,a5,s9
    800053fc:	0007c503          	lbu	a0,0(a5)
    80005400:	b97ff0ef          	jal	80004f96 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80005404:	0a92                	slli	s5,s5,0x4
    80005406:	3a7d                	addiw	s4,s4,-1
    80005408:	fe0a17e3          	bnez	s4,800053f6 <printf+0x1da>
    8000540c:	7ca2                	ld	s9,40(sp)
    8000540e:	bde5                	j	80005306 <printf+0xea>
    } else if(c0 == 'c'){
      consputc(va_arg(ap, uint));
    80005410:	f8843783          	ld	a5,-120(s0)
    80005414:	00878713          	addi	a4,a5,8
    80005418:	f8e43423          	sd	a4,-120(s0)
    8000541c:	4388                	lw	a0,0(a5)
    8000541e:	b79ff0ef          	jal	80004f96 <consputc>
    80005422:	b5d5                	j	80005306 <printf+0xea>
    } else if(c0 == 's'){
      if((s = va_arg(ap, char*)) == 0)
    80005424:	f8843783          	ld	a5,-120(s0)
    80005428:	00878713          	addi	a4,a5,8
    8000542c:	f8e43423          	sd	a4,-120(s0)
    80005430:	0007ba03          	ld	s4,0(a5)
    80005434:	000a0d63          	beqz	s4,8000544e <printf+0x232>
        s = "(null)";
      for(; *s; s++)
    80005438:	000a4503          	lbu	a0,0(s4)
    8000543c:	ec0505e3          	beqz	a0,80005306 <printf+0xea>
        consputc(*s);
    80005440:	b57ff0ef          	jal	80004f96 <consputc>
      for(; *s; s++)
    80005444:	0a05                	addi	s4,s4,1
    80005446:	000a4503          	lbu	a0,0(s4)
    8000544a:	f97d                	bnez	a0,80005440 <printf+0x224>
    8000544c:	bd6d                	j	80005306 <printf+0xea>
        s = "(null)";
    8000544e:	00002a17          	auipc	s4,0x2
    80005452:	26aa0a13          	addi	s4,s4,618 # 800076b8 <etext+0x6b8>
      for(; *s; s++)
    80005456:	02800513          	li	a0,40
    8000545a:	b7dd                	j	80005440 <printf+0x224>
    } else if(c0 == '%'){
      consputc('%');
    8000545c:	8556                	mv	a0,s5
    8000545e:	b39ff0ef          	jal	80004f96 <consputc>
    80005462:	b555                	j	80005306 <printf+0xea>
    80005464:	7906                	ld	s2,96(sp)
    80005466:	69e6                	ld	s3,88(sp)
    80005468:	6a46                	ld	s4,80(sp)
    8000546a:	6aa6                	ld	s5,72(sp)
    8000546c:	6b06                	ld	s6,64(sp)
    8000546e:	7be2                	ld	s7,56(sp)
    80005470:	7c42                	ld	s8,48(sp)
    80005472:	7d02                	ld	s10,32(sp)
    80005474:	6de2                	ld	s11,24(sp)
    }

  }
  va_end(ap);

  if(panicking == 0)
    80005476:	00002797          	auipc	a5,0x2
    8000547a:	3da7a783          	lw	a5,986(a5) # 80007850 <panicking>
    8000547e:	c38d                	beqz	a5,800054a0 <printf+0x284>
    release(&pr.lock);

  return 0;
}
    80005480:	4501                	li	a0,0
    80005482:	70e6                	ld	ra,120(sp)
    80005484:	7446                	ld	s0,112(sp)
    80005486:	74a6                	ld	s1,104(sp)
    80005488:	6129                	addi	sp,sp,192
    8000548a:	8082                	ret
    8000548c:	7906                	ld	s2,96(sp)
    8000548e:	69e6                	ld	s3,88(sp)
    80005490:	6a46                	ld	s4,80(sp)
    80005492:	6aa6                	ld	s5,72(sp)
    80005494:	6b06                	ld	s6,64(sp)
    80005496:	7be2                	ld	s7,56(sp)
    80005498:	7c42                	ld	s8,48(sp)
    8000549a:	7d02                	ld	s10,32(sp)
    8000549c:	6de2                	ld	s11,24(sp)
    8000549e:	bfe1                	j	80005476 <printf+0x25a>
    release(&pr.lock);
    800054a0:	0001b517          	auipc	a0,0x1b
    800054a4:	69850513          	addi	a0,a0,1688 # 80020b38 <pr>
    800054a8:	3fa000ef          	jal	800058a2 <release>
  return 0;
    800054ac:	bfd1                	j	80005480 <printf+0x264>
    if(c0 == 'd'){
    800054ae:	e57a81e3          	beq	s5,s7,800052f0 <printf+0xd4>
    } else if(c0 == 'l' && c1 == 'd'){
    800054b2:	f94a8793          	addi	a5,s5,-108
    800054b6:	0017b793          	seqz	a5,a5
    800054ba:	863a                	mv	a2,a4
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    800054bc:	4681                	li	a3,0
    800054be:	a01d                	j	800054e4 <printf+0x2c8>
    } else if(c0 == 'l' && c1 == 'd'){
    800054c0:	f94a8793          	addi	a5,s5,-108
    800054c4:	0017b793          	seqz	a5,a5
    c1 = c2 = 0;
    800054c8:	8656                	mv	a2,s5
    800054ca:	8756                	mv	a4,s5
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    800054cc:	f9460693          	addi	a3,a2,-108
    800054d0:	0016b693          	seqz	a3,a3
    800054d4:	8efd                	and	a3,a3,a5
    800054d6:	f9c70593          	addi	a1,a4,-100
    800054da:	0015b593          	seqz	a1,a1
    800054de:	8df5                	and	a1,a1,a3
    800054e0:	e2059be3          	bnez	a1,80005316 <printf+0xfa>
    } else if(c0 == 'u'){
    800054e4:	e58a86e3          	beq	s5,s8,80005330 <printf+0x114>
    } else if(c0 == 'l' && c1 == 'u'){
    800054e8:	f8b60593          	addi	a1,a2,-117
    800054ec:	0015b593          	seqz	a1,a1
    800054f0:	8dfd                	and	a1,a1,a5
    800054f2:	e4059ce3          	bnez	a1,8000534a <printf+0x12e>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    800054f6:	f8b70593          	addi	a1,a4,-117
    800054fa:	0015b593          	seqz	a1,a1
    800054fe:	8df5                	and	a1,a1,a3
    80005500:	e60592e3          	bnez	a1,80005364 <printf+0x148>
    } else if(c0 == 'x'){
    80005504:	e7aa8de3          	beq	s5,s10,8000537e <printf+0x162>
    } else if(c0 == 'l' && c1 == 'x'){
    80005508:	f8860613          	addi	a2,a2,-120
    8000550c:	00163613          	seqz	a2,a2
    80005510:	8e7d                	and	a2,a2,a5
    80005512:	e80613e3          	bnez	a2,80005398 <printf+0x17c>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    80005516:	f8870713          	addi	a4,a4,-120
    8000551a:	00173713          	seqz	a4,a4
    8000551e:	8f75                	and	a4,a4,a3
    80005520:	e80719e3          	bnez	a4,800053b2 <printf+0x196>
    } else if(c0 == 'p'){
    80005524:	ebba83e3          	beq	s5,s11,800053ca <printf+0x1ae>
    } else if(c0 == 'c'){
    80005528:	06300793          	li	a5,99
    8000552c:	eefa82e3          	beq	s5,a5,80005410 <printf+0x1f4>
    } else if(c0 == 's'){
    80005530:	07300793          	li	a5,115
    80005534:	eefa88e3          	beq	s5,a5,80005424 <printf+0x208>
    } else if(c0 == '%'){
    80005538:	02500793          	li	a5,37
    8000553c:	f2fa80e3          	beq	s5,a5,8000545c <printf+0x240>
    } else if(c0 == 0){
    80005540:	f40a86e3          	beqz	s5,8000548c <printf+0x270>
      consputc('%');
    80005544:	02500513          	li	a0,37
    80005548:	a4fff0ef          	jal	80004f96 <consputc>
      consputc(c0);
    8000554c:	8556                	mv	a0,s5
    8000554e:	a49ff0ef          	jal	80004f96 <consputc>
    80005552:	bb55                	j	80005306 <printf+0xea>

0000000080005554 <panic>:

void
panic(char *s)
{
    80005554:	1101                	addi	sp,sp,-32
    80005556:	ec06                	sd	ra,24(sp)
    80005558:	e822                	sd	s0,16(sp)
    8000555a:	e426                	sd	s1,8(sp)
    8000555c:	e04a                	sd	s2,0(sp)
    8000555e:	1000                	addi	s0,sp,32
    80005560:	892a                	mv	s2,a0
  panicking = 1;
    80005562:	4485                	li	s1,1
    80005564:	00002797          	auipc	a5,0x2
    80005568:	2e97a623          	sw	s1,748(a5) # 80007850 <panicking>
  printf("panic: ");
    8000556c:	00002517          	auipc	a0,0x2
    80005570:	15450513          	addi	a0,a0,340 # 800076c0 <etext+0x6c0>
    80005574:	ca9ff0ef          	jal	8000521c <printf>
  printf("%s\n", s);
    80005578:	85ca                	mv	a1,s2
    8000557a:	00002517          	auipc	a0,0x2
    8000557e:	14e50513          	addi	a0,a0,334 # 800076c8 <etext+0x6c8>
    80005582:	c9bff0ef          	jal	8000521c <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005586:	00002797          	auipc	a5,0x2
    8000558a:	2c97a323          	sw	s1,710(a5) # 8000784c <panicked>
  for(;;)
    8000558e:	a001                	j	8000558e <panic+0x3a>

0000000080005590 <printfinit>:
    ;
}

void
printfinit(void)
{
    80005590:	1141                	addi	sp,sp,-16
    80005592:	e406                	sd	ra,8(sp)
    80005594:	e022                	sd	s0,0(sp)
    80005596:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    80005598:	00002597          	auipc	a1,0x2
    8000559c:	13858593          	addi	a1,a1,312 # 800076d0 <etext+0x6d0>
    800055a0:	0001b517          	auipc	a0,0x1b
    800055a4:	59850513          	addi	a0,a0,1432 # 80020b38 <pr>
    800055a8:	1e0000ef          	jal	80005788 <initlock>
}
    800055ac:	60a2                	ld	ra,8(sp)
    800055ae:	6402                	ld	s0,0(sp)
    800055b0:	0141                	addi	sp,sp,16
    800055b2:	8082                	ret

00000000800055b4 <uartinit>:
extern volatile int panicking; // from printf.c
extern volatile int panicked; // from printf.c

void
uartinit(void)
{
    800055b4:	1141                	addi	sp,sp,-16
    800055b6:	e406                	sd	ra,8(sp)
    800055b8:	e022                	sd	s0,0(sp)
    800055ba:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    800055bc:	100007b7          	lui	a5,0x10000
    800055c0:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    800055c4:	10000737          	lui	a4,0x10000
    800055c8:	f8000693          	li	a3,-128
    800055cc:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800055d0:	468d                	li	a3,3
    800055d2:	10000637          	lui	a2,0x10000
    800055d6:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800055da:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800055de:	00d701a3          	sb	a3,3(a4)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800055e2:	8732                	mv	a4,a2
    800055e4:	461d                	li	a2,7
    800055e6:	00c70123          	sb	a2,2(a4)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800055ea:	00d780a3          	sb	a3,1(a5)

  initlock(&tx_lock, "uart");
    800055ee:	00002597          	auipc	a1,0x2
    800055f2:	0ea58593          	addi	a1,a1,234 # 800076d8 <etext+0x6d8>
    800055f6:	0001b517          	auipc	a0,0x1b
    800055fa:	55a50513          	addi	a0,a0,1370 # 80020b50 <tx_lock>
    800055fe:	18a000ef          	jal	80005788 <initlock>
}
    80005602:	60a2                	ld	ra,8(sp)
    80005604:	6402                	ld	s0,0(sp)
    80005606:	0141                	addi	sp,sp,16
    80005608:	8082                	ret

000000008000560a <uartwrite>:
// transmit buf[] to the uart. it blocks if the
// uart is busy, so it cannot be called from
// interrupts, only from write() system calls.
void
uartwrite(char buf[], int n)
{
    8000560a:	715d                	addi	sp,sp,-80
    8000560c:	e486                	sd	ra,72(sp)
    8000560e:	e0a2                	sd	s0,64(sp)
    80005610:	fc26                	sd	s1,56(sp)
    80005612:	ec56                	sd	s5,24(sp)
    80005614:	0880                	addi	s0,sp,80
    80005616:	8aaa                	mv	s5,a0
    80005618:	84ae                	mv	s1,a1
  acquire(&tx_lock);
    8000561a:	0001b517          	auipc	a0,0x1b
    8000561e:	53650513          	addi	a0,a0,1334 # 80020b50 <tx_lock>
    80005622:	1f0000ef          	jal	80005812 <acquire>

  int i = 0;
  while(i < n){ 
    80005626:	06905063          	blez	s1,80005686 <uartwrite+0x7c>
    8000562a:	f84a                	sd	s2,48(sp)
    8000562c:	f44e                	sd	s3,40(sp)
    8000562e:	f052                	sd	s4,32(sp)
    80005630:	e85a                	sd	s6,16(sp)
    80005632:	e45e                	sd	s7,8(sp)
    80005634:	8a56                	mv	s4,s5
    80005636:	9aa6                	add	s5,s5,s1
    while(tx_busy != 0){
    80005638:	00002497          	auipc	s1,0x2
    8000563c:	22048493          	addi	s1,s1,544 # 80007858 <tx_busy>
      // wait for a UART transmit-complete interrupt
      // to set tx_busy to 0.
      sleep(&tx_chan, &tx_lock);
    80005640:	0001b997          	auipc	s3,0x1b
    80005644:	51098993          	addi	s3,s3,1296 # 80020b50 <tx_lock>
    80005648:	00002917          	auipc	s2,0x2
    8000564c:	20c90913          	addi	s2,s2,524 # 80007854 <tx_chan>
    }   
      
    WriteReg(THR, buf[i]);
    80005650:	10000bb7          	lui	s7,0x10000
    i += 1;
    tx_busy = 1;
    80005654:	4b05                	li	s6,1
    80005656:	a005                	j	80005676 <uartwrite+0x6c>
      sleep(&tx_chan, &tx_lock);
    80005658:	85ce                	mv	a1,s3
    8000565a:	854a                	mv	a0,s2
    8000565c:	cedfb0ef          	jal	80001348 <sleep>
    while(tx_busy != 0){
    80005660:	409c                	lw	a5,0(s1)
    80005662:	fbfd                	bnez	a5,80005658 <uartwrite+0x4e>
    WriteReg(THR, buf[i]);
    80005664:	000a4783          	lbu	a5,0(s4)
    80005668:	00fb8023          	sb	a5,0(s7) # 10000000 <_entry-0x70000000>
    tx_busy = 1;
    8000566c:	0164a023          	sw	s6,0(s1)
  while(i < n){ 
    80005670:	0a05                	addi	s4,s4,1
    80005672:	015a0563          	beq	s4,s5,8000567c <uartwrite+0x72>
    while(tx_busy != 0){
    80005676:	409c                	lw	a5,0(s1)
    80005678:	f3e5                	bnez	a5,80005658 <uartwrite+0x4e>
    8000567a:	b7ed                	j	80005664 <uartwrite+0x5a>
    8000567c:	7942                	ld	s2,48(sp)
    8000567e:	79a2                	ld	s3,40(sp)
    80005680:	7a02                	ld	s4,32(sp)
    80005682:	6b42                	ld	s6,16(sp)
    80005684:	6ba2                	ld	s7,8(sp)
  }

  release(&tx_lock);
    80005686:	0001b517          	auipc	a0,0x1b
    8000568a:	4ca50513          	addi	a0,a0,1226 # 80020b50 <tx_lock>
    8000568e:	214000ef          	jal	800058a2 <release>
}
    80005692:	60a6                	ld	ra,72(sp)
    80005694:	6406                	ld	s0,64(sp)
    80005696:	74e2                	ld	s1,56(sp)
    80005698:	6ae2                	ld	s5,24(sp)
    8000569a:	6161                	addi	sp,sp,80
    8000569c:	8082                	ret

000000008000569e <uartputc_sync>:
// interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    8000569e:	1101                	addi	sp,sp,-32
    800056a0:	ec06                	sd	ra,24(sp)
    800056a2:	e822                	sd	s0,16(sp)
    800056a4:	e426                	sd	s1,8(sp)
    800056a6:	1000                	addi	s0,sp,32
    800056a8:	84aa                	mv	s1,a0
  if(panicking == 0)
    800056aa:	00002797          	auipc	a5,0x2
    800056ae:	1a67a783          	lw	a5,422(a5) # 80007850 <panicking>
    800056b2:	cb91                	beqz	a5,800056c6 <uartputc_sync+0x28>
    push_off();

  if(panicked){
    800056b4:	00002797          	auipc	a5,0x2
    800056b8:	1987a783          	lw	a5,408(a5) # 8000784c <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800056bc:	10000737          	lui	a4,0x10000
    800056c0:	0715                	addi	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
  if(panicked){
    800056c2:	c789                	beqz	a5,800056cc <uartputc_sync+0x2e>
    for(;;)
    800056c4:	a001                	j	800056c4 <uartputc_sync+0x26>
    push_off();
    800056c6:	108000ef          	jal	800057ce <push_off>
    800056ca:	b7ed                	j	800056b4 <uartputc_sync+0x16>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800056cc:	00074783          	lbu	a5,0(a4)
    800056d0:	0207f793          	andi	a5,a5,32
    800056d4:	dfe5                	beqz	a5,800056cc <uartputc_sync+0x2e>
    ;
  WriteReg(THR, c);
    800056d6:	100007b7          	lui	a5,0x10000
    800056da:	00978023          	sb	s1,0(a5) # 10000000 <_entry-0x70000000>

  if(panicking == 0)
    800056de:	00002797          	auipc	a5,0x2
    800056e2:	1727a783          	lw	a5,370(a5) # 80007850 <panicking>
    800056e6:	c791                	beqz	a5,800056f2 <uartputc_sync+0x54>
    pop_off();
}
    800056e8:	60e2                	ld	ra,24(sp)
    800056ea:	6442                	ld	s0,16(sp)
    800056ec:	64a2                	ld	s1,8(sp)
    800056ee:	6105                	addi	sp,sp,32
    800056f0:	8082                	ret
    pop_off();
    800056f2:	160000ef          	jal	80005852 <pop_off>
}
    800056f6:	bfcd                	j	800056e8 <uartputc_sync+0x4a>

00000000800056f8 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    800056f8:	1141                	addi	sp,sp,-16
    800056fa:	e406                	sd	ra,8(sp)
    800056fc:	e022                	sd	s0,0(sp)
    800056fe:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & LSR_RX_READY){
    80005700:	100007b7          	lui	a5,0x10000
    80005704:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80005708:	8b85                	andi	a5,a5,1
    8000570a:	cb89                	beqz	a5,8000571c <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    8000570c:	100007b7          	lui	a5,0x10000
    80005710:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    80005714:	60a2                	ld	ra,8(sp)
    80005716:	6402                	ld	s0,0(sp)
    80005718:	0141                	addi	sp,sp,16
    8000571a:	8082                	ret
    return -1;
    8000571c:	557d                	li	a0,-1
    8000571e:	bfdd                	j	80005714 <uartgetc+0x1c>

0000000080005720 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    80005720:	1101                	addi	sp,sp,-32
    80005722:	ec06                	sd	ra,24(sp)
    80005724:	e822                	sd	s0,16(sp)
    80005726:	e426                	sd	s1,8(sp)
    80005728:	1000                	addi	s0,sp,32
  ReadReg(ISR); // acknowledge the interrupt
    8000572a:	100007b7          	lui	a5,0x10000
    8000572e:	0027c783          	lbu	a5,2(a5) # 10000002 <_entry-0x6ffffffe>

  acquire(&tx_lock);
    80005732:	0001b517          	auipc	a0,0x1b
    80005736:	41e50513          	addi	a0,a0,1054 # 80020b50 <tx_lock>
    8000573a:	0d8000ef          	jal	80005812 <acquire>
  if(ReadReg(LSR) & LSR_TX_IDLE){
    8000573e:	100007b7          	lui	a5,0x10000
    80005742:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80005746:	0207f793          	andi	a5,a5,32
    8000574a:	ef99                	bnez	a5,80005768 <uartintr+0x48>
    // UART finished transmitting; wake up sending thread.
    tx_busy = 0;
    wakeup(&tx_chan);
  }
  release(&tx_lock);
    8000574c:	0001b517          	auipc	a0,0x1b
    80005750:	40450513          	addi	a0,a0,1028 # 80020b50 <tx_lock>
    80005754:	14e000ef          	jal	800058a2 <release>

  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    80005758:	54fd                	li	s1,-1
    int c = uartgetc();
    8000575a:	f9fff0ef          	jal	800056f8 <uartgetc>
    if(c == -1)
    8000575e:	02950063          	beq	a0,s1,8000577e <uartintr+0x5e>
      break;
    consoleintr(c);
    80005762:	867ff0ef          	jal	80004fc8 <consoleintr>
  while(1){
    80005766:	bfd5                	j	8000575a <uartintr+0x3a>
    tx_busy = 0;
    80005768:	00002797          	auipc	a5,0x2
    8000576c:	0e07a823          	sw	zero,240(a5) # 80007858 <tx_busy>
    wakeup(&tx_chan);
    80005770:	00002517          	auipc	a0,0x2
    80005774:	0e450513          	addi	a0,a0,228 # 80007854 <tx_chan>
    80005778:	c1dfb0ef          	jal	80001394 <wakeup>
    8000577c:	bfc1                	j	8000574c <uartintr+0x2c>
  }
}
    8000577e:	60e2                	ld	ra,24(sp)
    80005780:	6442                	ld	s0,16(sp)
    80005782:	64a2                	ld	s1,8(sp)
    80005784:	6105                	addi	sp,sp,32
    80005786:	8082                	ret

0000000080005788 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80005788:	1141                	addi	sp,sp,-16
    8000578a:	e406                	sd	ra,8(sp)
    8000578c:	e022                	sd	s0,0(sp)
    8000578e:	0800                	addi	s0,sp,16
  lk->name = name;
    80005790:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80005792:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80005796:	00053823          	sd	zero,16(a0)
}
    8000579a:	60a2                	ld	ra,8(sp)
    8000579c:	6402                	ld	s0,0(sp)
    8000579e:	0141                	addi	sp,sp,16
    800057a0:	8082                	ret

00000000800057a2 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800057a2:	411c                	lw	a5,0(a0)
    800057a4:	e399                	bnez	a5,800057aa <holding+0x8>
    800057a6:	4501                	li	a0,0
  return r;
}
    800057a8:	8082                	ret
{
    800057aa:	1101                	addi	sp,sp,-32
    800057ac:	ec06                	sd	ra,24(sp)
    800057ae:	e822                	sd	s0,16(sp)
    800057b0:	e426                	sd	s1,8(sp)
    800057b2:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    800057b4:	691c                	ld	a5,16(a0)
    800057b6:	84be                	mv	s1,a5
    800057b8:	d86fb0ef          	jal	80000d3e <mycpu>
    800057bc:	40a48533          	sub	a0,s1,a0
    800057c0:	00153513          	seqz	a0,a0
}
    800057c4:	60e2                	ld	ra,24(sp)
    800057c6:	6442                	ld	s0,16(sp)
    800057c8:	64a2                	ld	s1,8(sp)
    800057ca:	6105                	addi	sp,sp,32
    800057cc:	8082                	ret

00000000800057ce <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    800057ce:	1101                	addi	sp,sp,-32
    800057d0:	ec06                	sd	ra,24(sp)
    800057d2:	e822                	sd	s0,16(sp)
    800057d4:	e426                	sd	s1,8(sp)
    800057d6:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800057d8:	100027f3          	csrr	a5,sstatus
    800057dc:	84be                	mv	s1,a5
    800057de:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800057e2:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800057e4:	10079073          	csrw	sstatus,a5

  // disable interrupts to prevent an involuntary context
  // switch while using mycpu().
  intr_off();

  if(mycpu()->noff == 0)
    800057e8:	d56fb0ef          	jal	80000d3e <mycpu>
    800057ec:	5d3c                	lw	a5,120(a0)
    800057ee:	cb99                	beqz	a5,80005804 <push_off+0x36>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    800057f0:	d4efb0ef          	jal	80000d3e <mycpu>
    800057f4:	5d3c                	lw	a5,120(a0)
    800057f6:	2785                	addiw	a5,a5,1
    800057f8:	dd3c                	sw	a5,120(a0)
}
    800057fa:	60e2                	ld	ra,24(sp)
    800057fc:	6442                	ld	s0,16(sp)
    800057fe:	64a2                	ld	s1,8(sp)
    80005800:	6105                	addi	sp,sp,32
    80005802:	8082                	ret
    mycpu()->intena = old;
    80005804:	d3afb0ef          	jal	80000d3e <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80005808:	0014d793          	srli	a5,s1,0x1
    8000580c:	8b85                	andi	a5,a5,1
    8000580e:	dd7c                	sw	a5,124(a0)
    80005810:	b7c5                	j	800057f0 <push_off+0x22>

0000000080005812 <acquire>:
{
    80005812:	1101                	addi	sp,sp,-32
    80005814:	ec06                	sd	ra,24(sp)
    80005816:	e822                	sd	s0,16(sp)
    80005818:	e426                	sd	s1,8(sp)
    8000581a:	1000                	addi	s0,sp,32
    8000581c:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    8000581e:	fb1ff0ef          	jal	800057ce <push_off>
  if(holding(lk))
    80005822:	8526                	mv	a0,s1
    80005824:	f7fff0ef          	jal	800057a2 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80005828:	4705                	li	a4,1
  if(holding(lk))
    8000582a:	ed11                	bnez	a0,80005846 <acquire+0x34>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8000582c:	0ce4a7af          	amoswap.w.aq	a5,a4,(s1)
    80005830:	fff5                	bnez	a5,8000582c <acquire+0x1a>
  __sync_synchronize();
    80005832:	0330000f          	fence	rw,rw
  lk->cpu = mycpu();
    80005836:	d08fb0ef          	jal	80000d3e <mycpu>
    8000583a:	e888                	sd	a0,16(s1)
}
    8000583c:	60e2                	ld	ra,24(sp)
    8000583e:	6442                	ld	s0,16(sp)
    80005840:	64a2                	ld	s1,8(sp)
    80005842:	6105                	addi	sp,sp,32
    80005844:	8082                	ret
    panic("acquire");
    80005846:	00002517          	auipc	a0,0x2
    8000584a:	e9a50513          	addi	a0,a0,-358 # 800076e0 <etext+0x6e0>
    8000584e:	d07ff0ef          	jal	80005554 <panic>

0000000080005852 <pop_off>:

void
pop_off(void)
{
    80005852:	1141                	addi	sp,sp,-16
    80005854:	e406                	sd	ra,8(sp)
    80005856:	e022                	sd	s0,0(sp)
    80005858:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    8000585a:	ce4fb0ef          	jal	80000d3e <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000585e:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80005862:	8b89                	andi	a5,a5,2
  if(intr_get())
    80005864:	e39d                	bnez	a5,8000588a <pop_off+0x38>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80005866:	5d3c                	lw	a5,120(a0)
    80005868:	02f05763          	blez	a5,80005896 <pop_off+0x44>
    panic("pop_off");
  c->noff -= 1;
    8000586c:	37fd                	addiw	a5,a5,-1
    8000586e:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80005870:	eb89                	bnez	a5,80005882 <pop_off+0x30>
    80005872:	5d7c                	lw	a5,124(a0)
    80005874:	c799                	beqz	a5,80005882 <pop_off+0x30>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80005876:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000587a:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000587e:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80005882:	60a2                	ld	ra,8(sp)
    80005884:	6402                	ld	s0,0(sp)
    80005886:	0141                	addi	sp,sp,16
    80005888:	8082                	ret
    panic("pop_off - interruptible");
    8000588a:	00002517          	auipc	a0,0x2
    8000588e:	e5e50513          	addi	a0,a0,-418 # 800076e8 <etext+0x6e8>
    80005892:	cc3ff0ef          	jal	80005554 <panic>
    panic("pop_off");
    80005896:	00002517          	auipc	a0,0x2
    8000589a:	e6a50513          	addi	a0,a0,-406 # 80007700 <etext+0x700>
    8000589e:	cb7ff0ef          	jal	80005554 <panic>

00000000800058a2 <release>:
{
    800058a2:	1101                	addi	sp,sp,-32
    800058a4:	ec06                	sd	ra,24(sp)
    800058a6:	e822                	sd	s0,16(sp)
    800058a8:	e426                	sd	s1,8(sp)
    800058aa:	1000                	addi	s0,sp,32
    800058ac:	84aa                	mv	s1,a0
  if(!holding(lk))
    800058ae:	ef5ff0ef          	jal	800057a2 <holding>
    800058b2:	c105                	beqz	a0,800058d2 <release+0x30>
  lk->cpu = 0;
    800058b4:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    800058b8:	0330000f          	fence	rw,rw
  __sync_lock_release(&lk->locked);
    800058bc:	0310000f          	fence	rw,w
    800058c0:	0004a023          	sw	zero,0(s1)
  pop_off();
    800058c4:	f8fff0ef          	jal	80005852 <pop_off>
}
    800058c8:	60e2                	ld	ra,24(sp)
    800058ca:	6442                	ld	s0,16(sp)
    800058cc:	64a2                	ld	s1,8(sp)
    800058ce:	6105                	addi	sp,sp,32
    800058d0:	8082                	ret
    panic("release");
    800058d2:	00002517          	auipc	a0,0x2
    800058d6:	e3650513          	addi	a0,a0,-458 # 80007708 <etext+0x708>
    800058da:	c7bff0ef          	jal	80005554 <panic>
	...

0000000080006000 <_trampoline>:
    80006000:	14051073          	csrw	sscratch,a0
    80006004:	02000537          	lui	a0,0x2000
    80006008:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000600a:	0536                	slli	a0,a0,0xd
    8000600c:	02153423          	sd	ra,40(a0)
    80006010:	02253823          	sd	sp,48(a0)
    80006014:	02353c23          	sd	gp,56(a0)
    80006018:	04453023          	sd	tp,64(a0)
    8000601c:	04553423          	sd	t0,72(a0)
    80006020:	04653823          	sd	t1,80(a0)
    80006024:	04753c23          	sd	t2,88(a0)
    80006028:	f120                	sd	s0,96(a0)
    8000602a:	f524                	sd	s1,104(a0)
    8000602c:	fd2c                	sd	a1,120(a0)
    8000602e:	e150                	sd	a2,128(a0)
    80006030:	e554                	sd	a3,136(a0)
    80006032:	e958                	sd	a4,144(a0)
    80006034:	ed5c                	sd	a5,152(a0)
    80006036:	0b053023          	sd	a6,160(a0)
    8000603a:	0b153423          	sd	a7,168(a0)
    8000603e:	0b253823          	sd	s2,176(a0)
    80006042:	0b353c23          	sd	s3,184(a0)
    80006046:	0d453023          	sd	s4,192(a0)
    8000604a:	0d553423          	sd	s5,200(a0)
    8000604e:	0d653823          	sd	s6,208(a0)
    80006052:	0d753c23          	sd	s7,216(a0)
    80006056:	0f853023          	sd	s8,224(a0)
    8000605a:	0f953423          	sd	s9,232(a0)
    8000605e:	0fa53823          	sd	s10,240(a0)
    80006062:	0fb53c23          	sd	s11,248(a0)
    80006066:	11c53023          	sd	t3,256(a0)
    8000606a:	11d53423          	sd	t4,264(a0)
    8000606e:	11e53823          	sd	t5,272(a0)
    80006072:	11f53c23          	sd	t6,280(a0)
    80006076:	140022f3          	csrr	t0,sscratch
    8000607a:	06553823          	sd	t0,112(a0)
    8000607e:	00853103          	ld	sp,8(a0)
    80006082:	02053203          	ld	tp,32(a0)
    80006086:	01053283          	ld	t0,16(a0)
    8000608a:	00053303          	ld	t1,0(a0)
    8000608e:	12000073          	sfence.vma
    80006092:	18031073          	csrw	satp,t1
    80006096:	12000073          	sfence.vma
    8000609a:	9282                	jalr	t0

000000008000609c <userret>:
    8000609c:	12000073          	sfence.vma
    800060a0:	18051073          	csrw	satp,a0
    800060a4:	12000073          	sfence.vma
    800060a8:	02000537          	lui	a0,0x2000
    800060ac:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    800060ae:	0536                	slli	a0,a0,0xd
    800060b0:	02853083          	ld	ra,40(a0)
    800060b4:	03053103          	ld	sp,48(a0)
    800060b8:	03853183          	ld	gp,56(a0)
    800060bc:	04053203          	ld	tp,64(a0)
    800060c0:	04853283          	ld	t0,72(a0)
    800060c4:	05053303          	ld	t1,80(a0)
    800060c8:	05853383          	ld	t2,88(a0)
    800060cc:	7120                	ld	s0,96(a0)
    800060ce:	7524                	ld	s1,104(a0)
    800060d0:	7d2c                	ld	a1,120(a0)
    800060d2:	6150                	ld	a2,128(a0)
    800060d4:	6554                	ld	a3,136(a0)
    800060d6:	6958                	ld	a4,144(a0)
    800060d8:	6d5c                	ld	a5,152(a0)
    800060da:	0a053803          	ld	a6,160(a0)
    800060de:	0a853883          	ld	a7,168(a0)
    800060e2:	0b053903          	ld	s2,176(a0)
    800060e6:	0b853983          	ld	s3,184(a0)
    800060ea:	0c053a03          	ld	s4,192(a0)
    800060ee:	0c853a83          	ld	s5,200(a0)
    800060f2:	0d053b03          	ld	s6,208(a0)
    800060f6:	0d853b83          	ld	s7,216(a0)
    800060fa:	0e053c03          	ld	s8,224(a0)
    800060fe:	0e853c83          	ld	s9,232(a0)
    80006102:	0f053d03          	ld	s10,240(a0)
    80006106:	0f853d83          	ld	s11,248(a0)
    8000610a:	10053e03          	ld	t3,256(a0)
    8000610e:	10853e83          	ld	t4,264(a0)
    80006112:	11053f03          	ld	t5,272(a0)
    80006116:	11853f83          	ld	t6,280(a0)
    8000611a:	7928                	ld	a0,112(a0)
    8000611c:	10200073          	sret
	...
