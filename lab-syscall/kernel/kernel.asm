
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
_entry:
        # set up a stack for C.
        # stack0 is declared in start.c,
        # with a 4096-byte stack per CPU.
        # sp = stack0 + ((hartid + 1) * 4096)
        la sp, stack0
    80000000:	0001b117          	auipc	sp,0x1b
    80000004:	cb010113          	addi	sp,sp,-848 # 8001acb0 <stack0>
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
    80000016:	62b040ef          	jal	80004e40 <start>

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
    80000028:	00023797          	auipc	a5,0x23
    8000002c:	d6078793          	addi	a5,a5,-672 # 80022d88 <end>
    80000030:	00f53733          	sltu	a4,a0,a5
    80000034:	47c5                	li	a5,17
    80000036:	07ee                	slli	a5,a5,0x1b
    80000038:	17fd                	addi	a5,a5,-1
    8000003a:	00a7b7b3          	sltu	a5,a5,a0
    8000003e:	8fd9                	or	a5,a5,a4
    80000040:	03451713          	slli	a4,a0,0x34
    80000044:	8fd9                	or	a5,a5,a4
    80000046:	e79d                	bnez	a5,80000074 <kfree+0x58>
    80000048:	84aa                	mv	s1,a0
  memset(pa, 1, PGSIZE);
#endif
  
  r = (struct run*)pa;

  acquire(&kmem.lock);
    8000004a:	00008917          	auipc	s2,0x8
    8000004e:	83690913          	addi	s2,s2,-1994 # 80007880 <kmem>
    80000052:	854a                	mv	a0,s2
    80000054:	07f050ef          	jal	800058d2 <acquire>
  r->next = kmem.freelist;
    80000058:	01893783          	ld	a5,24(s2)
    8000005c:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    8000005e:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    80000062:	854a                	mv	a0,s2
    80000064:	0ff050ef          	jal	80005962 <release>
}
    80000068:	60e2                	ld	ra,24(sp)
    8000006a:	6442                	ld	s0,16(sp)
    8000006c:	64a2                	ld	s1,8(sp)
    8000006e:	6902                	ld	s2,0(sp)
    80000070:	6105                	addi	sp,sp,32
    80000072:	8082                	ret
    panic("kfree");
    80000074:	00007517          	auipc	a0,0x7
    80000078:	f8c50513          	addi	a0,a0,-116 # 80007000 <etext>
    8000007c:	598050ef          	jal	80005614 <panic>

0000000080000080 <freerange>:
{
    80000080:	7179                	addi	sp,sp,-48
    80000082:	f406                	sd	ra,40(sp)
    80000084:	f022                	sd	s0,32(sp)
    80000086:	ec26                	sd	s1,24(sp)
    80000088:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    8000008a:	6785                	lui	a5,0x1
    8000008c:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    80000090:	00e504b3          	add	s1,a0,a4
    80000094:	777d                	lui	a4,0xfffff
    80000096:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE) {
    80000098:	94be                	add	s1,s1,a5
    8000009a:	0295e263          	bltu	a1,s1,800000be <freerange+0x3e>
    8000009e:	e84a                	sd	s2,16(sp)
    800000a0:	e44e                	sd	s3,8(sp)
    800000a2:	e052                	sd	s4,0(sp)
    800000a4:	892e                	mv	s2,a1
    kfree(p);
    800000a6:	8a3a                	mv	s4,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE) {
    800000a8:	89be                	mv	s3,a5
    kfree(p);
    800000aa:	01448533          	add	a0,s1,s4
    800000ae:	f6fff0ef          	jal	8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE) {
    800000b2:	94ce                	add	s1,s1,s3
    800000b4:	fe997be3          	bgeu	s2,s1,800000aa <freerange+0x2a>
    800000b8:	6942                	ld	s2,16(sp)
    800000ba:	69a2                	ld	s3,8(sp)
    800000bc:	6a02                	ld	s4,0(sp)
}
    800000be:	70a2                	ld	ra,40(sp)
    800000c0:	7402                	ld	s0,32(sp)
    800000c2:	64e2                	ld	s1,24(sp)
    800000c4:	6145                	addi	sp,sp,48
    800000c6:	8082                	ret

00000000800000c8 <kinit>:
{
    800000c8:	1141                	addi	sp,sp,-16
    800000ca:	e406                	sd	ra,8(sp)
    800000cc:	e022                	sd	s0,0(sp)
    800000ce:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000d0:	00007597          	auipc	a1,0x7
    800000d4:	f4058593          	addi	a1,a1,-192 # 80007010 <etext+0x10>
    800000d8:	00007517          	auipc	a0,0x7
    800000dc:	7a850513          	addi	a0,a0,1960 # 80007880 <kmem>
    800000e0:	768050ef          	jal	80005848 <initlock>
  freerange(end, (void*)PHYSTOP);
    800000e4:	45c5                	li	a1,17
    800000e6:	05ee                	slli	a1,a1,0x1b
    800000e8:	00023517          	auipc	a0,0x23
    800000ec:	ca050513          	addi	a0,a0,-864 # 80022d88 <end>
    800000f0:	f91ff0ef          	jal	80000080 <freerange>
}
    800000f4:	60a2                	ld	ra,8(sp)
    800000f6:	6402                	ld	s0,0(sp)
    800000f8:	0141                	addi	sp,sp,16
    800000fa:	8082                	ret

00000000800000fc <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    800000fc:	1101                	addi	sp,sp,-32
    800000fe:	ec06                	sd	ra,24(sp)
    80000100:	e822                	sd	s0,16(sp)
    80000102:	e426                	sd	s1,8(sp)
    80000104:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000106:	00007517          	auipc	a0,0x7
    8000010a:	77a50513          	addi	a0,a0,1914 # 80007880 <kmem>
    8000010e:	7c4050ef          	jal	800058d2 <acquire>
  r = kmem.freelist;
    80000112:	00007497          	auipc	s1,0x7
    80000116:	7864b483          	ld	s1,1926(s1) # 80007898 <kmem+0x18>
  if(r) {
    8000011a:	c491                	beqz	s1,80000126 <kalloc+0x2a>
    kmem.freelist = r->next;
    8000011c:	609c                	ld	a5,0(s1)
    8000011e:	00007717          	auipc	a4,0x7
    80000122:	76f73d23          	sd	a5,1914(a4) # 80007898 <kmem+0x18>
  }
  release(&kmem.lock);
    80000126:	00007517          	auipc	a0,0x7
    8000012a:	75a50513          	addi	a0,a0,1882 # 80007880 <kmem>
    8000012e:	035050ef          	jal	80005962 <release>
#ifndef LAB_SYSCALL
  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
#endif
  return (void*)r;
}
    80000132:	8526                	mv	a0,s1
    80000134:	60e2                	ld	ra,24(sp)
    80000136:	6442                	ld	s0,16(sp)
    80000138:	64a2                	ld	s1,8(sp)
    8000013a:	6105                	addi	sp,sp,32
    8000013c:	8082                	ret

000000008000013e <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    8000013e:	1141                	addi	sp,sp,-16
    80000140:	e406                	sd	ra,8(sp)
    80000142:	e022                	sd	s0,0(sp)
    80000144:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000146:	ca19                	beqz	a2,8000015c <memset+0x1e>
    80000148:	87aa                	mv	a5,a0
    8000014a:	1602                	slli	a2,a2,0x20
    8000014c:	9201                	srli	a2,a2,0x20
    8000014e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000152:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000156:	0785                	addi	a5,a5,1
    80000158:	fee79de3          	bne	a5,a4,80000152 <memset+0x14>
  }
  return dst;
}
    8000015c:	60a2                	ld	ra,8(sp)
    8000015e:	6402                	ld	s0,0(sp)
    80000160:	0141                	addi	sp,sp,16
    80000162:	8082                	ret

0000000080000164 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000164:	1141                	addi	sp,sp,-16
    80000166:	e406                	sd	ra,8(sp)
    80000168:	e022                	sd	s0,0(sp)
    8000016a:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    8000016c:	ce19                	beqz	a2,8000018a <memcmp+0x26>
    8000016e:	1602                	slli	a2,a2,0x20
    80000170:	9201                	srli	a2,a2,0x20
    80000172:	00c506b3          	add	a3,a0,a2
    if(*s1 != *s2)
    80000176:	00054783          	lbu	a5,0(a0)
    8000017a:	0005c703          	lbu	a4,0(a1)
    8000017e:	00e79b63          	bne	a5,a4,80000194 <memcmp+0x30>
      return *s1 - *s2;
    s1++, s2++;
    80000182:	0505                	addi	a0,a0,1
    80000184:	0585                	addi	a1,a1,1
  while(n-- > 0){
    80000186:	fed518e3          	bne	a0,a3,80000176 <memcmp+0x12>
  }

  return 0;
    8000018a:	4501                	li	a0,0
}
    8000018c:	60a2                	ld	ra,8(sp)
    8000018e:	6402                	ld	s0,0(sp)
    80000190:	0141                	addi	sp,sp,16
    80000192:	8082                	ret
      return *s1 - *s2;
    80000194:	40e7853b          	subw	a0,a5,a4
    80000198:	bfd5                	j	8000018c <memcmp+0x28>

000000008000019a <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    8000019a:	1141                	addi	sp,sp,-16
    8000019c:	e406                	sd	ra,8(sp)
    8000019e:	e022                	sd	s0,0(sp)
    800001a0:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001a2:	c61d                	beqz	a2,800001d0 <memmove+0x36>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001a4:	00a5f963          	bgeu	a1,a0,800001b6 <memmove+0x1c>
    800001a8:	02061693          	slli	a3,a2,0x20
    800001ac:	9281                	srli	a3,a3,0x20
    800001ae:	00d58733          	add	a4,a1,a3
    800001b2:	02e56363          	bltu	a0,a4,800001d8 <memmove+0x3e>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001b6:	1602                	slli	a2,a2,0x20
    800001b8:	9201                	srli	a2,a2,0x20
    800001ba:	00c587b3          	add	a5,a1,a2
{
    800001be:	872a                	mv	a4,a0
      *d++ = *s++;
    800001c0:	0585                	addi	a1,a1,1
    800001c2:	0705                	addi	a4,a4,1
    800001c4:	fff5c683          	lbu	a3,-1(a1)
    800001c8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    800001cc:	fef59ae3          	bne	a1,a5,800001c0 <memmove+0x26>

  return dst;
}
    800001d0:	60a2                	ld	ra,8(sp)
    800001d2:	6402                	ld	s0,0(sp)
    800001d4:	0141                	addi	sp,sp,16
    800001d6:	8082                	ret
    d += n;
    800001d8:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    800001da:	fff6079b          	addiw	a5,a2,-1
    800001de:	1782                	slli	a5,a5,0x20
    800001e0:	9381                	srli	a5,a5,0x20
    800001e2:	fff7c793          	not	a5,a5
    800001e6:	97ba                	add	a5,a5,a4
      *--d = *--s;
    800001e8:	177d                	addi	a4,a4,-1
    800001ea:	16fd                	addi	a3,a3,-1
    800001ec:	00074603          	lbu	a2,0(a4)
    800001f0:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    800001f4:	fee79ae3          	bne	a5,a4,800001e8 <memmove+0x4e>
    800001f8:	bfe1                	j	800001d0 <memmove+0x36>

00000000800001fa <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    800001fa:	1141                	addi	sp,sp,-16
    800001fc:	e406                	sd	ra,8(sp)
    800001fe:	e022                	sd	s0,0(sp)
    80000200:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000202:	f99ff0ef          	jal	8000019a <memmove>
}
    80000206:	60a2                	ld	ra,8(sp)
    80000208:	6402                	ld	s0,0(sp)
    8000020a:	0141                	addi	sp,sp,16
    8000020c:	8082                	ret

000000008000020e <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    8000020e:	1141                	addi	sp,sp,-16
    80000210:	e406                	sd	ra,8(sp)
    80000212:	e022                	sd	s0,0(sp)
    80000214:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000216:	ce01                	beqz	a2,8000022e <strncmp+0x20>
    80000218:	00054783          	lbu	a5,0(a0)
    8000021c:	cb99                	beqz	a5,80000232 <strncmp+0x24>
    8000021e:	0005c703          	lbu	a4,0(a1)
    80000222:	00f71863          	bne	a4,a5,80000232 <strncmp+0x24>
    n--, p++, q++;
    80000226:	367d                	addiw	a2,a2,-1
    80000228:	0505                	addi	a0,a0,1
    8000022a:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    8000022c:	f675                	bnez	a2,80000218 <strncmp+0xa>
  if(n == 0)
    return 0;
    8000022e:	4501                	li	a0,0
    80000230:	a031                	j	8000023c <strncmp+0x2e>
  return (uchar)*p - (uchar)*q;
    80000232:	00054503          	lbu	a0,0(a0)
    80000236:	0005c783          	lbu	a5,0(a1)
    8000023a:	9d1d                	subw	a0,a0,a5
}
    8000023c:	60a2                	ld	ra,8(sp)
    8000023e:	6402                	ld	s0,0(sp)
    80000240:	0141                	addi	sp,sp,16
    80000242:	8082                	ret

0000000080000244 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000244:	1141                	addi	sp,sp,-16
    80000246:	e406                	sd	ra,8(sp)
    80000248:	e022                	sd	s0,0(sp)
    8000024a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    8000024c:	87aa                	mv	a5,a0
    8000024e:	a011                	j	80000252 <strncpy+0xe>
    80000250:	8636                	mv	a2,a3
    80000252:	02c05763          	blez	a2,80000280 <strncpy+0x3c>
    80000256:	fff6069b          	addiw	a3,a2,-1
    8000025a:	0785                	addi	a5,a5,1
    8000025c:	0005c703          	lbu	a4,0(a1)
    80000260:	fee78fa3          	sb	a4,-1(a5)
    80000264:	0585                	addi	a1,a1,1
    80000266:	f76d                	bnez	a4,80000250 <strncpy+0xc>
    ;
  while(n-- > 0)
    80000268:	873e                	mv	a4,a5
    8000026a:	00d05b63          	blez	a3,80000280 <strncpy+0x3c>
    8000026e:	9fb1                	addw	a5,a5,a2
    80000270:	37fd                	addiw	a5,a5,-1
    *s++ = 0;
    80000272:	0705                	addi	a4,a4,1
    80000274:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    80000278:	40e786bb          	subw	a3,a5,a4
    8000027c:	fed04be3          	bgtz	a3,80000272 <strncpy+0x2e>
  return os;
}
    80000280:	60a2                	ld	ra,8(sp)
    80000282:	6402                	ld	s0,0(sp)
    80000284:	0141                	addi	sp,sp,16
    80000286:	8082                	ret

0000000080000288 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80000288:	1141                	addi	sp,sp,-16
    8000028a:	e406                	sd	ra,8(sp)
    8000028c:	e022                	sd	s0,0(sp)
    8000028e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    80000290:	02c05363          	blez	a2,800002b6 <safestrcpy+0x2e>
    80000294:	fff6069b          	addiw	a3,a2,-1
    80000298:	1682                	slli	a3,a3,0x20
    8000029a:	9281                	srli	a3,a3,0x20
    8000029c:	96ae                	add	a3,a3,a1
    8000029e:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002a0:	00d58963          	beq	a1,a3,800002b2 <safestrcpy+0x2a>
    800002a4:	0585                	addi	a1,a1,1
    800002a6:	0785                	addi	a5,a5,1
    800002a8:	fff5c703          	lbu	a4,-1(a1)
    800002ac:	fee78fa3          	sb	a4,-1(a5)
    800002b0:	fb65                	bnez	a4,800002a0 <safestrcpy+0x18>
    ;
  *s = 0;
    800002b2:	00078023          	sb	zero,0(a5)
  return os;
}
    800002b6:	60a2                	ld	ra,8(sp)
    800002b8:	6402                	ld	s0,0(sp)
    800002ba:	0141                	addi	sp,sp,16
    800002bc:	8082                	ret

00000000800002be <strlen>:

int
strlen(const char *s)
{
    800002be:	1141                	addi	sp,sp,-16
    800002c0:	e406                	sd	ra,8(sp)
    800002c2:	e022                	sd	s0,0(sp)
    800002c4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    800002c6:	00054783          	lbu	a5,0(a0)
    800002ca:	cf91                	beqz	a5,800002e6 <strlen+0x28>
    800002cc:	00150793          	addi	a5,a0,1
    800002d0:	86be                	mv	a3,a5
    800002d2:	0785                	addi	a5,a5,1
    800002d4:	fff7c703          	lbu	a4,-1(a5)
    800002d8:	ff65                	bnez	a4,800002d0 <strlen+0x12>
    800002da:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
    800002de:	60a2                	ld	ra,8(sp)
    800002e0:	6402                	ld	s0,0(sp)
    800002e2:	0141                	addi	sp,sp,16
    800002e4:	8082                	ret
  for(n = 0; s[n]; n++)
    800002e6:	4501                	li	a0,0
    800002e8:	bfdd                	j	800002de <strlen+0x20>

00000000800002ea <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    800002ea:	1141                	addi	sp,sp,-16
    800002ec:	e406                	sd	ra,8(sp)
    800002ee:	e022                	sd	s0,0(sp)
    800002f0:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    800002f2:	21f000ef          	jal	80000d10 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    800002f6:	00007717          	auipc	a4,0x7
    800002fa:	55a70713          	addi	a4,a4,1370 # 80007850 <started>
  if(cpuid() == 0){
    800002fe:	c515                	beqz	a0,8000032a <main+0x40>
    while(started == 0)
    80000300:	431c                	lw	a5,0(a4)
    80000302:	dffd                	beqz	a5,80000300 <main+0x16>
      ;
    __sync_synchronize();
    80000304:	0330000f          	fence	rw,rw
    printf("hart %d starting\n", cpuid());
    80000308:	209000ef          	jal	80000d10 <cpuid>
    8000030c:	85aa                	mv	a1,a0
    8000030e:	00007517          	auipc	a0,0x7
    80000312:	d2a50513          	addi	a0,a0,-726 # 80007038 <etext+0x38>
    80000316:	7c7040ef          	jal	800052dc <printf>
    kvminithart();    // turn on paging
    8000031a:	080000ef          	jal	8000039a <kvminithart>
    trapinithart();   // install kernel trap vector
    8000031e:	542010ef          	jal	80001860 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000322:	576040ef          	jal	80004898 <plicinithart>
  }

  scheduler();        
    80000326:	693000ef          	jal	800011b8 <scheduler>
    consoleinit();
    8000032a:	6db040ef          	jal	80005204 <consoleinit>
    printfinit();
    8000032e:	322050ef          	jal	80005650 <printfinit>
    printf("\n");
    80000332:	00007517          	auipc	a0,0x7
    80000336:	ce650513          	addi	a0,a0,-794 # 80007018 <etext+0x18>
    8000033a:	7a3040ef          	jal	800052dc <printf>
    printf("xv6 kernel is booting\n");
    8000033e:	00007517          	auipc	a0,0x7
    80000342:	ce250513          	addi	a0,a0,-798 # 80007020 <etext+0x20>
    80000346:	797040ef          	jal	800052dc <printf>
    printf("\n");
    8000034a:	00007517          	auipc	a0,0x7
    8000034e:	cce50513          	addi	a0,a0,-818 # 80007018 <etext+0x18>
    80000352:	78b040ef          	jal	800052dc <printf>
    kinit();         // physical page allocator
    80000356:	d73ff0ef          	jal	800000c8 <kinit>
    kvminit();       // create kernel page table
    8000035a:	2c0000ef          	jal	8000061a <kvminit>
    kvminithart();   // turn on paging
    8000035e:	03c000ef          	jal	8000039a <kvminithart>
    procinit();      // process table
    80000362:	0ff000ef          	jal	80000c60 <procinit>
    trapinit();      // trap vectors
    80000366:	4d6010ef          	jal	8000183c <trapinit>
    trapinithart();  // install kernel trap vector
    8000036a:	4f6010ef          	jal	80001860 <trapinithart>
    plicinit();      // set up interrupt controller
    8000036e:	510040ef          	jal	8000487e <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000372:	526040ef          	jal	80004898 <plicinithart>
    binit();         // buffer cache
    80000376:	425010ef          	jal	80001f9a <binit>
    iinit();         // inode table
    8000037a:	17e020ef          	jal	800024f8 <iinit>
    fileinit();      // file table
    8000037e:	0b0030ef          	jal	8000342e <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000382:	606040ef          	jal	80004988 <virtio_disk_init>
    userinit();      // first user process
    80000386:	487000ef          	jal	8000100c <userinit>
    __sync_synchronize();
    8000038a:	0330000f          	fence	rw,rw
    started = 1;
    8000038e:	4785                	li	a5,1
    80000390:	00007717          	auipc	a4,0x7
    80000394:	4cf72023          	sw	a5,1216(a4) # 80007850 <started>
    80000398:	b779                	j	80000326 <main+0x3c>

000000008000039a <kvminithart>:

// Switch the current CPU's h/w page table register to
// the kernel's page table, and enable paging.
void
kvminithart()
{
    8000039a:	1141                	addi	sp,sp,-16
    8000039c:	e406                	sd	ra,8(sp)
    8000039e:	e022                	sd	s0,0(sp)
    800003a0:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    800003a2:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    800003a6:	00007797          	auipc	a5,0x7
    800003aa:	4b27b783          	ld	a5,1202(a5) # 80007858 <kernel_pagetable>
    800003ae:	83b1                	srli	a5,a5,0xc
    800003b0:	577d                	li	a4,-1
    800003b2:	177e                	slli	a4,a4,0x3f
    800003b4:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    800003b6:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    800003ba:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    800003be:	60a2                	ld	ra,8(sp)
    800003c0:	6402                	ld	s0,0(sp)
    800003c2:	0141                	addi	sp,sp,16
    800003c4:	8082                	ret

00000000800003c6 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    800003c6:	7139                	addi	sp,sp,-64
    800003c8:	fc06                	sd	ra,56(sp)
    800003ca:	f822                	sd	s0,48(sp)
    800003cc:	f426                	sd	s1,40(sp)
    800003ce:	f04a                	sd	s2,32(sp)
    800003d0:	ec4e                	sd	s3,24(sp)
    800003d2:	e852                	sd	s4,16(sp)
    800003d4:	e456                	sd	s5,8(sp)
    800003d6:	e05a                	sd	s6,0(sp)
    800003d8:	0080                	addi	s0,sp,64
    800003da:	84aa                	mv	s1,a0
    800003dc:	89ae                	mv	s3,a1
    800003de:	8b32                	mv	s6,a2
  if(va >= MAXVA)
    800003e0:	57fd                	li	a5,-1
    800003e2:	83e9                	srli	a5,a5,0x1a
    800003e4:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    800003e6:	4ab1                	li	s5,12
  if(va >= MAXVA)
    800003e8:	06b7e363          	bltu	a5,a1,8000044e <walk+0x88>
    pte_t *pte = &pagetable[PX(level, va)];
    800003ec:	0149d933          	srl	s2,s3,s4
    800003f0:	1ff97913          	andi	s2,s2,511
    800003f4:	090e                	slli	s2,s2,0x3
    800003f6:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800003f8:	00093483          	ld	s1,0(s2)
    800003fc:	0014f793          	andi	a5,s1,1
      pagetable = (pagetable_t)PTE2PA(*pte);
    80000400:	80a9                	srli	s1,s1,0xa
    80000402:	04b2                	slli	s1,s1,0xc
    if(*pte & PTE_V) {
    80000404:	e395                	bnez	a5,80000428 <walk+0x62>
      if(PTE_LEAF(*pte)) {
        return pte;
      }
#endif
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80000406:	040b0a63          	beqz	s6,8000045a <walk+0x94>
    8000040a:	cf3ff0ef          	jal	800000fc <kalloc>
    8000040e:	84aa                	mv	s1,a0
    80000410:	c50d                	beqz	a0,8000043a <walk+0x74>
        return 0;
      memset(pagetable, 0, PGSIZE);
    80000412:	6605                	lui	a2,0x1
    80000414:	4581                	li	a1,0
    80000416:	d29ff0ef          	jal	8000013e <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    8000041a:	00c4d793          	srli	a5,s1,0xc
    8000041e:	07aa                	slli	a5,a5,0xa
    80000420:	0017e793          	ori	a5,a5,1
    80000424:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    80000428:	3a5d                	addiw	s4,s4,-9
    8000042a:	fd5a11e3          	bne	s4,s5,800003ec <walk+0x26>
    }
  }
  return &pagetable[PX(0, va)];
    8000042e:	00c9d513          	srli	a0,s3,0xc
    80000432:	1ff57513          	andi	a0,a0,511
    80000436:	050e                	slli	a0,a0,0x3
    80000438:	9526                	add	a0,a0,s1
}
    8000043a:	70e2                	ld	ra,56(sp)
    8000043c:	7442                	ld	s0,48(sp)
    8000043e:	74a2                	ld	s1,40(sp)
    80000440:	7902                	ld	s2,32(sp)
    80000442:	69e2                	ld	s3,24(sp)
    80000444:	6a42                	ld	s4,16(sp)
    80000446:	6aa2                	ld	s5,8(sp)
    80000448:	6b02                	ld	s6,0(sp)
    8000044a:	6121                	addi	sp,sp,64
    8000044c:	8082                	ret
    panic("walk");
    8000044e:	00007517          	auipc	a0,0x7
    80000452:	c0250513          	addi	a0,a0,-1022 # 80007050 <etext+0x50>
    80000456:	1be050ef          	jal	80005614 <panic>
        return 0;
    8000045a:	4501                	li	a0,0
    8000045c:	bff9                	j	8000043a <walk+0x74>

000000008000045e <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    8000045e:	57fd                	li	a5,-1
    80000460:	83e9                	srli	a5,a5,0x1a
    80000462:	00b7f463          	bgeu	a5,a1,8000046a <walkaddr+0xc>
    return 0;
    80000466:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000468:	8082                	ret
{
    8000046a:	1141                	addi	sp,sp,-16
    8000046c:	e406                	sd	ra,8(sp)
    8000046e:	e022                	sd	s0,0(sp)
    80000470:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80000472:	4601                	li	a2,0
    80000474:	f53ff0ef          	jal	800003c6 <walk>
  if(pte == 0)
    80000478:	c519                	beqz	a0,80000486 <walkaddr+0x28>
  if((*pte & PTE_V) == 0)
    8000047a:	6108                	ld	a0,0(a0)
  if((*pte & PTE_U) == 0)
    8000047c:	01157713          	andi	a4,a0,17
    80000480:	47c5                	li	a5,17
    80000482:	00f70763          	beq	a4,a5,80000490 <walkaddr+0x32>
    return 0;
    80000486:	4501                	li	a0,0
}
    80000488:	60a2                	ld	ra,8(sp)
    8000048a:	6402                	ld	s0,0(sp)
    8000048c:	0141                	addi	sp,sp,16
    8000048e:	8082                	ret
  pa = PTE2PA(*pte);
    80000490:	8129                	srli	a0,a0,0xa
    80000492:	0532                	slli	a0,a0,0xc
  return pa;
    80000494:	bfd5                	j	80000488 <walkaddr+0x2a>

0000000080000496 <mappages>:
// va and size MUST be page-aligned.
// Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80000496:	715d                	addi	sp,sp,-80
    80000498:	e486                	sd	ra,72(sp)
    8000049a:	e0a2                	sd	s0,64(sp)
    8000049c:	fc26                	sd	s1,56(sp)
    8000049e:	f84a                	sd	s2,48(sp)
    800004a0:	f44e                	sd	s3,40(sp)
    800004a2:	f052                	sd	s4,32(sp)
    800004a4:	ec56                	sd	s5,24(sp)
    800004a6:	e85a                	sd	s6,16(sp)
    800004a8:	e45e                	sd	s7,8(sp)
    800004aa:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    800004ac:	03459793          	slli	a5,a1,0x34
    800004b0:	e7b1                	bnez	a5,800004fc <mappages+0x66>
    800004b2:	8a2a                	mv	s4,a0
    800004b4:	8aba                	mv	s5,a4
    panic("mappages: va not aligned");

  if((size % PGSIZE) != 0)
    800004b6:	03461793          	slli	a5,a2,0x34
    800004ba:	e7b9                	bnez	a5,80000508 <mappages+0x72>
    panic("mappages: size not aligned");

  if(size == 0)
    800004bc:	ce21                	beqz	a2,80000514 <mappages+0x7e>
    panic("mappages: size");
  
  a = va;
  last = va + size - PGSIZE;
    800004be:	77fd                	lui	a5,0xfffff
    800004c0:	963e                	add	a2,a2,a5
    800004c2:	00b60933          	add	s2,a2,a1
  a = va;
    800004c6:	84ae                	mv	s1,a1
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    800004c8:	4b05                	li	s6,1
    800004ca:	40b689b3          	sub	s3,a3,a1
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    800004ce:	6b85                	lui	s7,0x1
    if((pte = walk(pagetable, a, 1)) == 0)
    800004d0:	865a                	mv	a2,s6
    800004d2:	85a6                	mv	a1,s1
    800004d4:	8552                	mv	a0,s4
    800004d6:	ef1ff0ef          	jal	800003c6 <walk>
    800004da:	c929                	beqz	a0,8000052c <mappages+0x96>
    if(*pte & PTE_V)
    800004dc:	611c                	ld	a5,0(a0)
    800004de:	8b85                	andi	a5,a5,1
    800004e0:	e3a1                	bnez	a5,80000520 <mappages+0x8a>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800004e2:	013487b3          	add	a5,s1,s3
    800004e6:	83b1                	srli	a5,a5,0xc
    800004e8:	07aa                	slli	a5,a5,0xa
    800004ea:	0157e7b3          	or	a5,a5,s5
    800004ee:	0017e793          	ori	a5,a5,1
    800004f2:	e11c                	sd	a5,0(a0)
    if(a == last)
    800004f4:	05248863          	beq	s1,s2,80000544 <mappages+0xae>
    a += PGSIZE;
    800004f8:	94de                	add	s1,s1,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    800004fa:	bfd9                	j	800004d0 <mappages+0x3a>
    panic("mappages: va not aligned");
    800004fc:	00007517          	auipc	a0,0x7
    80000500:	b5c50513          	addi	a0,a0,-1188 # 80007058 <etext+0x58>
    80000504:	110050ef          	jal	80005614 <panic>
    panic("mappages: size not aligned");
    80000508:	00007517          	auipc	a0,0x7
    8000050c:	b7050513          	addi	a0,a0,-1168 # 80007078 <etext+0x78>
    80000510:	104050ef          	jal	80005614 <panic>
    panic("mappages: size");
    80000514:	00007517          	auipc	a0,0x7
    80000518:	b8450513          	addi	a0,a0,-1148 # 80007098 <etext+0x98>
    8000051c:	0f8050ef          	jal	80005614 <panic>
      panic("mappages: remap");
    80000520:	00007517          	auipc	a0,0x7
    80000524:	b8850513          	addi	a0,a0,-1144 # 800070a8 <etext+0xa8>
    80000528:	0ec050ef          	jal	80005614 <panic>
      return -1;
    8000052c:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    8000052e:	60a6                	ld	ra,72(sp)
    80000530:	6406                	ld	s0,64(sp)
    80000532:	74e2                	ld	s1,56(sp)
    80000534:	7942                	ld	s2,48(sp)
    80000536:	79a2                	ld	s3,40(sp)
    80000538:	7a02                	ld	s4,32(sp)
    8000053a:	6ae2                	ld	s5,24(sp)
    8000053c:	6b42                	ld	s6,16(sp)
    8000053e:	6ba2                	ld	s7,8(sp)
    80000540:	6161                	addi	sp,sp,80
    80000542:	8082                	ret
  return 0;
    80000544:	4501                	li	a0,0
    80000546:	b7e5                	j	8000052e <mappages+0x98>

0000000080000548 <kvmmap>:
{
    80000548:	1141                	addi	sp,sp,-16
    8000054a:	e406                	sd	ra,8(sp)
    8000054c:	e022                	sd	s0,0(sp)
    8000054e:	0800                	addi	s0,sp,16
    80000550:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80000552:	86b2                	mv	a3,a2
    80000554:	863e                	mv	a2,a5
    80000556:	f41ff0ef          	jal	80000496 <mappages>
    8000055a:	e509                	bnez	a0,80000564 <kvmmap+0x1c>
}
    8000055c:	60a2                	ld	ra,8(sp)
    8000055e:	6402                	ld	s0,0(sp)
    80000560:	0141                	addi	sp,sp,16
    80000562:	8082                	ret
    panic("kvmmap");
    80000564:	00007517          	auipc	a0,0x7
    80000568:	b5450513          	addi	a0,a0,-1196 # 800070b8 <etext+0xb8>
    8000056c:	0a8050ef          	jal	80005614 <panic>

0000000080000570 <kvmmake>:
{
    80000570:	1101                	addi	sp,sp,-32
    80000572:	ec06                	sd	ra,24(sp)
    80000574:	e822                	sd	s0,16(sp)
    80000576:	e426                	sd	s1,8(sp)
    80000578:	e04a                	sd	s2,0(sp)
    8000057a:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    8000057c:	b81ff0ef          	jal	800000fc <kalloc>
    80000580:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    80000582:	6605                	lui	a2,0x1
    80000584:	4581                	li	a1,0
    80000586:	bb9ff0ef          	jal	8000013e <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    8000058a:	4719                	li	a4,6
    8000058c:	6685                	lui	a3,0x1
    8000058e:	10000637          	lui	a2,0x10000
    80000592:	85b2                	mv	a1,a2
    80000594:	8526                	mv	a0,s1
    80000596:	fb3ff0ef          	jal	80000548 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    8000059a:	4719                	li	a4,6
    8000059c:	6685                	lui	a3,0x1
    8000059e:	10001637          	lui	a2,0x10001
    800005a2:	85b2                	mv	a1,a2
    800005a4:	8526                	mv	a0,s1
    800005a6:	fa3ff0ef          	jal	80000548 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x4000000, PTE_R | PTE_W);
    800005aa:	4719                	li	a4,6
    800005ac:	040006b7          	lui	a3,0x4000
    800005b0:	0c000637          	lui	a2,0xc000
    800005b4:	85b2                	mv	a1,a2
    800005b6:	8526                	mv	a0,s1
    800005b8:	f91ff0ef          	jal	80000548 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800005bc:	00007917          	auipc	s2,0x7
    800005c0:	a4490913          	addi	s2,s2,-1468 # 80007000 <etext>
    800005c4:	4729                	li	a4,10
    800005c6:	800006b7          	lui	a3,0x80000
    800005ca:	96ca                	add	a3,a3,s2
    800005cc:	4605                	li	a2,1
    800005ce:	067e                	slli	a2,a2,0x1f
    800005d0:	85b2                	mv	a1,a2
    800005d2:	8526                	mv	a0,s1
    800005d4:	f75ff0ef          	jal	80000548 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800005d8:	4719                	li	a4,6
    800005da:	46c5                	li	a3,17
    800005dc:	06ee                	slli	a3,a3,0x1b
    800005de:	412686b3          	sub	a3,a3,s2
    800005e2:	864a                	mv	a2,s2
    800005e4:	85ca                	mv	a1,s2
    800005e6:	8526                	mv	a0,s1
    800005e8:	f61ff0ef          	jal	80000548 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800005ec:	4729                	li	a4,10
    800005ee:	6685                	lui	a3,0x1
    800005f0:	00006617          	auipc	a2,0x6
    800005f4:	a1060613          	addi	a2,a2,-1520 # 80006000 <_trampoline>
    800005f8:	040005b7          	lui	a1,0x4000
    800005fc:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    800005fe:	05b2                	slli	a1,a1,0xc
    80000600:	8526                	mv	a0,s1
    80000602:	f47ff0ef          	jal	80000548 <kvmmap>
  proc_mapstacks(kpgtbl);
    80000606:	8526                	mv	a0,s1
    80000608:	5cc000ef          	jal	80000bd4 <proc_mapstacks>
}
    8000060c:	8526                	mv	a0,s1
    8000060e:	60e2                	ld	ra,24(sp)
    80000610:	6442                	ld	s0,16(sp)
    80000612:	64a2                	ld	s1,8(sp)
    80000614:	6902                	ld	s2,0(sp)
    80000616:	6105                	addi	sp,sp,32
    80000618:	8082                	ret

000000008000061a <kvminit>:
{
    8000061a:	1141                	addi	sp,sp,-16
    8000061c:	e406                	sd	ra,8(sp)
    8000061e:	e022                	sd	s0,0(sp)
    80000620:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80000622:	f4fff0ef          	jal	80000570 <kvmmake>
    80000626:	00007797          	auipc	a5,0x7
    8000062a:	22a7b923          	sd	a0,562(a5) # 80007858 <kernel_pagetable>
}
    8000062e:	60a2                	ld	ra,8(sp)
    80000630:	6402                	ld	s0,0(sp)
    80000632:	0141                	addi	sp,sp,16
    80000634:	8082                	ret

0000000080000636 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80000636:	1101                	addi	sp,sp,-32
    80000638:	ec06                	sd	ra,24(sp)
    8000063a:	e822                	sd	s0,16(sp)
    8000063c:	e426                	sd	s1,8(sp)
    8000063e:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80000640:	abdff0ef          	jal	800000fc <kalloc>
    80000644:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000646:	c509                	beqz	a0,80000650 <uvmcreate+0x1a>
    return 0;
  memset(pagetable, 0, PGSIZE);
    80000648:	6605                	lui	a2,0x1
    8000064a:	4581                	li	a1,0
    8000064c:	af3ff0ef          	jal	8000013e <memset>
  return pagetable;
}
    80000650:	8526                	mv	a0,s1
    80000652:	60e2                	ld	ra,24(sp)
    80000654:	6442                	ld	s0,16(sp)
    80000656:	64a2                	ld	s1,8(sp)
    80000658:	6105                	addi	sp,sp,32
    8000065a:	8082                	ret

000000008000065c <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. It's OK if the mappings don't exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    8000065c:	715d                	addi	sp,sp,-80
    8000065e:	e486                	sd	ra,72(sp)
    80000660:	e0a2                	sd	s0,64(sp)
    80000662:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;
  int sz = PGSIZE;

  if((va % PGSIZE) != 0)
    80000664:	03459793          	slli	a5,a1,0x34
    80000668:	e39d                	bnez	a5,8000068e <uvmunmap+0x32>
    8000066a:	f84a                	sd	s2,48(sp)
    8000066c:	f44e                	sd	s3,40(sp)
    8000066e:	f052                	sd	s4,32(sp)
    80000670:	ec56                	sd	s5,24(sp)
    80000672:	e85a                	sd	s6,16(sp)
    80000674:	e45e                	sd	s7,8(sp)
    80000676:	8a2a                	mv	s4,a0
    80000678:	892e                	mv	s2,a1
    8000067a:	8b36                	mv	s6,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += sz){
    8000067c:	0632                	slli	a2,a2,0xc
    8000067e:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0) // leaf page table entry allocated?
      continue;
    if((*pte & PTE_V) == 0)  // has physical page been allocated?
      continue;
    sz = PGSIZE;
    if(PTE_FLAGS(*pte) == PTE_V)
    80000682:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += sz){
    80000684:	6a85                	lui	s5,0x1
    80000686:	0735f463          	bgeu	a1,s3,800006ee <uvmunmap+0x92>
    8000068a:	fc26                	sd	s1,56(sp)
    8000068c:	a80d                	j	800006be <uvmunmap+0x62>
    8000068e:	fc26                	sd	s1,56(sp)
    80000690:	f84a                	sd	s2,48(sp)
    80000692:	f44e                	sd	s3,40(sp)
    80000694:	f052                	sd	s4,32(sp)
    80000696:	ec56                	sd	s5,24(sp)
    80000698:	e85a                	sd	s6,16(sp)
    8000069a:	e45e                	sd	s7,8(sp)
    panic("uvmunmap: not aligned");
    8000069c:	00007517          	auipc	a0,0x7
    800006a0:	a2450513          	addi	a0,a0,-1500 # 800070c0 <etext+0xc0>
    800006a4:	771040ef          	jal	80005614 <panic>
      panic("uvmunmap: not a leaf");
    800006a8:	00007517          	auipc	a0,0x7
    800006ac:	a3050513          	addi	a0,a0,-1488 # 800070d8 <etext+0xd8>
    800006b0:	765040ef          	jal	80005614 <panic>
    if(do_free){
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
    800006b4:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += sz){
    800006b8:	9956                	add	s2,s2,s5
    800006ba:	03397963          	bgeu	s2,s3,800006ec <uvmunmap+0x90>
    if((pte = walk(pagetable, a, 0)) == 0) // leaf page table entry allocated?
    800006be:	4601                	li	a2,0
    800006c0:	85ca                	mv	a1,s2
    800006c2:	8552                	mv	a0,s4
    800006c4:	d03ff0ef          	jal	800003c6 <walk>
    800006c8:	84aa                	mv	s1,a0
    800006ca:	d57d                	beqz	a0,800006b8 <uvmunmap+0x5c>
    if((*pte & PTE_V) == 0)  // has physical page been allocated?
    800006cc:	611c                	ld	a5,0(a0)
    800006ce:	0017f713          	andi	a4,a5,1
    800006d2:	d37d                	beqz	a4,800006b8 <uvmunmap+0x5c>
    if(PTE_FLAGS(*pte) == PTE_V)
    800006d4:	3ff7f713          	andi	a4,a5,1023
    800006d8:	fd7708e3          	beq	a4,s7,800006a8 <uvmunmap+0x4c>
    if(do_free){
    800006dc:	fc0b0ce3          	beqz	s6,800006b4 <uvmunmap+0x58>
      uint64 pa = PTE2PA(*pte);
    800006e0:	83a9                	srli	a5,a5,0xa
      kfree((void*)pa);
    800006e2:	00c79513          	slli	a0,a5,0xc
    800006e6:	937ff0ef          	jal	8000001c <kfree>
    800006ea:	b7e9                	j	800006b4 <uvmunmap+0x58>
    800006ec:	74e2                	ld	s1,56(sp)
    800006ee:	7942                	ld	s2,48(sp)
    800006f0:	79a2                	ld	s3,40(sp)
    800006f2:	7a02                	ld	s4,32(sp)
    800006f4:	6ae2                	ld	s5,24(sp)
    800006f6:	6b42                	ld	s6,16(sp)
    800006f8:	6ba2                	ld	s7,8(sp)
  }
}
    800006fa:	60a6                	ld	ra,72(sp)
    800006fc:	6406                	ld	s0,64(sp)
    800006fe:	6161                	addi	sp,sp,80
    80000700:	8082                	ret

0000000080000702 <uvmdealloc>:
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
  if(newsz >= oldsz)
    80000702:	04b67163          	bgeu	a2,a1,80000744 <uvmdealloc+0x42>
{
    80000706:	1101                	addi	sp,sp,-32
    80000708:	ec06                	sd	ra,24(sp)
    8000070a:	e822                	sd	s0,16(sp)
    8000070c:	e426                	sd	s1,8(sp)
    8000070e:	1000                	addi	s0,sp,32
    80000710:	84b2                	mv	s1,a2
    return oldsz;

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80000712:	6785                	lui	a5,0x1
    80000714:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000716:	00f60733          	add	a4,a2,a5
    8000071a:	76fd                	lui	a3,0xfffff
    8000071c:	8f75                	and	a4,a4,a3
    8000071e:	97ae                	add	a5,a5,a1
    80000720:	8ff5                	and	a5,a5,a3
    80000722:	00f76863          	bltu	a4,a5,80000732 <uvmdealloc+0x30>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
    80000726:	8526                	mv	a0,s1
}
    80000728:	60e2                	ld	ra,24(sp)
    8000072a:	6442                	ld	s0,16(sp)
    8000072c:	64a2                	ld	s1,8(sp)
    8000072e:	6105                	addi	sp,sp,32
    80000730:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80000732:	8f99                	sub	a5,a5,a4
    80000734:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80000736:	4685                	li	a3,1
    80000738:	0007861b          	sext.w	a2,a5
    8000073c:	85ba                	mv	a1,a4
    8000073e:	f1fff0ef          	jal	8000065c <uvmunmap>
    80000742:	b7d5                	j	80000726 <uvmdealloc+0x24>
    return oldsz;
    80000744:	852e                	mv	a0,a1
}
    80000746:	8082                	ret

0000000080000748 <uvmalloc>:
  if(newsz < oldsz)
    80000748:	08b66a63          	bltu	a2,a1,800007dc <uvmalloc+0x94>
{
    8000074c:	715d                	addi	sp,sp,-80
    8000074e:	e486                	sd	ra,72(sp)
    80000750:	e0a2                	sd	s0,64(sp)
    80000752:	f052                	sd	s4,32(sp)
    80000754:	ec56                	sd	s5,24(sp)
    80000756:	e45e                	sd	s7,8(sp)
    80000758:	0880                	addi	s0,sp,80
    8000075a:	8aaa                	mv	s5,a0
    8000075c:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    8000075e:	6785                	lui	a5,0x1
    80000760:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000762:	95be                	add	a1,a1,a5
    80000764:	77fd                	lui	a5,0xfffff
    80000766:	8fed                	and	a5,a5,a1
    80000768:	8bbe                	mv	s7,a5
  for(a = oldsz; a < newsz; a += sz){
    8000076a:	02c7fd63          	bgeu	a5,a2,800007a4 <uvmalloc+0x5c>
    8000076e:	fc26                	sd	s1,56(sp)
    80000770:	f84a                	sd	s2,48(sp)
    80000772:	f44e                	sd	s3,40(sp)
    80000774:	e85a                	sd	s6,16(sp)
    80000776:	893e                	mv	s2,a5
    if(mappages(pagetable, a, sz, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000778:	0126eb13          	ori	s6,a3,18
    8000077c:	6985                	lui	s3,0x1
    mem = kalloc();
    8000077e:	97fff0ef          	jal	800000fc <kalloc>
    80000782:	84aa                	mv	s1,a0
    if(mem == 0){
    80000784:	c115                	beqz	a0,800007a8 <uvmalloc+0x60>
    if(mappages(pagetable, a, sz, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000786:	875a                	mv	a4,s6
    80000788:	86aa                	mv	a3,a0
    8000078a:	864e                	mv	a2,s3
    8000078c:	85ca                	mv	a1,s2
    8000078e:	8556                	mv	a0,s5
    80000790:	d07ff0ef          	jal	80000496 <mappages>
    80000794:	e91d                	bnez	a0,800007ca <uvmalloc+0x82>
  for(a = oldsz; a < newsz; a += sz){
    80000796:	994e                	add	s2,s2,s3
    80000798:	ff4963e3          	bltu	s2,s4,8000077e <uvmalloc+0x36>
    8000079c:	74e2                	ld	s1,56(sp)
    8000079e:	7942                	ld	s2,48(sp)
    800007a0:	79a2                	ld	s3,40(sp)
    800007a2:	6b42                	ld	s6,16(sp)
  return newsz;
    800007a4:	8552                	mv	a0,s4
    800007a6:	a819                	j	800007bc <uvmalloc+0x74>
      uvmdealloc(pagetable, a, oldsz);
    800007a8:	865e                	mv	a2,s7
    800007aa:	85ca                	mv	a1,s2
    800007ac:	8556                	mv	a0,s5
    800007ae:	f55ff0ef          	jal	80000702 <uvmdealloc>
      return 0;
    800007b2:	4501                	li	a0,0
    800007b4:	74e2                	ld	s1,56(sp)
    800007b6:	7942                	ld	s2,48(sp)
    800007b8:	79a2                	ld	s3,40(sp)
    800007ba:	6b42                	ld	s6,16(sp)
}
    800007bc:	60a6                	ld	ra,72(sp)
    800007be:	6406                	ld	s0,64(sp)
    800007c0:	7a02                	ld	s4,32(sp)
    800007c2:	6ae2                	ld	s5,24(sp)
    800007c4:	6ba2                	ld	s7,8(sp)
    800007c6:	6161                	addi	sp,sp,80
    800007c8:	8082                	ret
      kfree(mem);
    800007ca:	8526                	mv	a0,s1
    800007cc:	851ff0ef          	jal	8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    800007d0:	865e                	mv	a2,s7
    800007d2:	85ca                	mv	a1,s2
    800007d4:	8556                	mv	a0,s5
    800007d6:	f2dff0ef          	jal	80000702 <uvmdealloc>
      return 0;
    800007da:	bfe1                	j	800007b2 <uvmalloc+0x6a>
    return oldsz;
    800007dc:	852e                	mv	a0,a1
}
    800007de:	8082                	ret

00000000800007e0 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    800007e0:	7179                	addi	sp,sp,-48
    800007e2:	f406                	sd	ra,40(sp)
    800007e4:	f022                	sd	s0,32(sp)
    800007e6:	ec26                	sd	s1,24(sp)
    800007e8:	e84a                	sd	s2,16(sp)
    800007ea:	e44e                	sd	s3,8(sp)
    800007ec:	1800                	addi	s0,sp,48
    800007ee:	89aa                	mv	s3,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800007f0:	84aa                	mv	s1,a0
    800007f2:	6905                	lui	s2,0x1
    800007f4:	992a                	add	s2,s2,a0
    800007f6:	a811                	j	8000080a <freewalk+0x2a>
      uint64 child = PTE2PA(pte);
      freewalk((pagetable_t)child);
      pagetable[i] = 0;
    } else if(pte & PTE_V){
      // backtrace();
      panic("freewalk: leaf");
    800007f8:	00007517          	auipc	a0,0x7
    800007fc:	8f850513          	addi	a0,a0,-1800 # 800070f0 <etext+0xf0>
    80000800:	615040ef          	jal	80005614 <panic>
  for(int i = 0; i < 512; i++){
    80000804:	04a1                	addi	s1,s1,8
    80000806:	03248163          	beq	s1,s2,80000828 <freewalk+0x48>
    pte_t pte = pagetable[i];
    8000080a:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    8000080c:	0017f713          	andi	a4,a5,1
    80000810:	db75                	beqz	a4,80000804 <freewalk+0x24>
    80000812:	00e7f713          	andi	a4,a5,14
    80000816:	f36d                	bnez	a4,800007f8 <freewalk+0x18>
      uint64 child = PTE2PA(pte);
    80000818:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    8000081a:	00c79513          	slli	a0,a5,0xc
    8000081e:	fc3ff0ef          	jal	800007e0 <freewalk>
      pagetable[i] = 0;
    80000822:	0004b023          	sd	zero,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000826:	bff9                	j	80000804 <freewalk+0x24>
    }
  }
  kfree((void*)pagetable);
    80000828:	854e                	mv	a0,s3
    8000082a:	ff2ff0ef          	jal	8000001c <kfree>
}
    8000082e:	70a2                	ld	ra,40(sp)
    80000830:	7402                	ld	s0,32(sp)
    80000832:	64e2                	ld	s1,24(sp)
    80000834:	6942                	ld	s2,16(sp)
    80000836:	69a2                	ld	s3,8(sp)
    80000838:	6145                	addi	sp,sp,48
    8000083a:	8082                	ret

000000008000083c <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    8000083c:	1101                	addi	sp,sp,-32
    8000083e:	ec06                	sd	ra,24(sp)
    80000840:	e822                	sd	s0,16(sp)
    80000842:	e426                	sd	s1,8(sp)
    80000844:	1000                	addi	s0,sp,32
    80000846:	84aa                	mv	s1,a0
  if(sz > 0)
    80000848:	e989                	bnez	a1,8000085a <uvmfree+0x1e>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    8000084a:	8526                	mv	a0,s1
    8000084c:	f95ff0ef          	jal	800007e0 <freewalk>
}
    80000850:	60e2                	ld	ra,24(sp)
    80000852:	6442                	ld	s0,16(sp)
    80000854:	64a2                	ld	s1,8(sp)
    80000856:	6105                	addi	sp,sp,32
    80000858:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    8000085a:	6785                	lui	a5,0x1
    8000085c:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000085e:	95be                	add	a1,a1,a5
    80000860:	4685                	li	a3,1
    80000862:	00c5d613          	srli	a2,a1,0xc
    80000866:	4581                	li	a1,0
    80000868:	df5ff0ef          	jal	8000065c <uvmunmap>
    8000086c:	bff9                	j	8000084a <uvmfree+0xe>

000000008000086e <uvmcopy>:
  uint64 pa, i;
  uint flags;
  char *mem;
  int szinc = PGSIZE;

  for(i = 0; i < sz; i += szinc){
    8000086e:	ca59                	beqz	a2,80000904 <uvmcopy+0x96>
{
    80000870:	715d                	addi	sp,sp,-80
    80000872:	e486                	sd	ra,72(sp)
    80000874:	e0a2                	sd	s0,64(sp)
    80000876:	fc26                	sd	s1,56(sp)
    80000878:	f84a                	sd	s2,48(sp)
    8000087a:	f44e                	sd	s3,40(sp)
    8000087c:	f052                	sd	s4,32(sp)
    8000087e:	ec56                	sd	s5,24(sp)
    80000880:	e85a                	sd	s6,16(sp)
    80000882:	e45e                	sd	s7,8(sp)
    80000884:	0880                	addi	s0,sp,80
    80000886:	8b2a                	mv	s6,a0
    80000888:	8bae                	mv	s7,a1
    8000088a:	8ab2                	mv	s5,a2
  for(i = 0; i < sz; i += szinc){
    8000088c:	4481                	li	s1,0
    szinc = PGSIZE;
    pa = PTE2PA(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    8000088e:	6a05                	lui	s4,0x1
    80000890:	a021                	j	80000898 <uvmcopy+0x2a>
  for(i = 0; i < sz; i += szinc){
    80000892:	94d2                	add	s1,s1,s4
    80000894:	0554fc63          	bgeu	s1,s5,800008ec <uvmcopy+0x7e>
    if((pte = walk(old, i, 0)) == 0)
    80000898:	4601                	li	a2,0
    8000089a:	85a6                	mv	a1,s1
    8000089c:	855a                	mv	a0,s6
    8000089e:	b29ff0ef          	jal	800003c6 <walk>
    800008a2:	d965                	beqz	a0,80000892 <uvmcopy+0x24>
    if((*pte & PTE_V) == 0) {
    800008a4:	00053983          	ld	s3,0(a0)
    800008a8:	0019f793          	andi	a5,s3,1
    800008ac:	d3fd                	beqz	a5,80000892 <uvmcopy+0x24>
    if((mem = kalloc()) == 0)
    800008ae:	84fff0ef          	jal	800000fc <kalloc>
    800008b2:	892a                	mv	s2,a0
    800008b4:	c11d                	beqz	a0,800008da <uvmcopy+0x6c>
    pa = PTE2PA(*pte);
    800008b6:	00a9d593          	srli	a1,s3,0xa
    memmove(mem, (char*)pa, PGSIZE);
    800008ba:	8652                	mv	a2,s4
    800008bc:	05b2                	slli	a1,a1,0xc
    800008be:	8ddff0ef          	jal	8000019a <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    800008c2:	3ff9f713          	andi	a4,s3,1023
    800008c6:	86ca                	mv	a3,s2
    800008c8:	8652                	mv	a2,s4
    800008ca:	85a6                	mv	a1,s1
    800008cc:	855e                	mv	a0,s7
    800008ce:	bc9ff0ef          	jal	80000496 <mappages>
    800008d2:	d161                	beqz	a0,80000892 <uvmcopy+0x24>
      kfree(mem);
    800008d4:	854a                	mv	a0,s2
    800008d6:	f46ff0ef          	jal	8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    800008da:	4685                	li	a3,1
    800008dc:	00c4d613          	srli	a2,s1,0xc
    800008e0:	4581                	li	a1,0
    800008e2:	855e                	mv	a0,s7
    800008e4:	d79ff0ef          	jal	8000065c <uvmunmap>
  return -1;
    800008e8:	557d                	li	a0,-1
    800008ea:	a011                	j	800008ee <uvmcopy+0x80>
  return 0;
    800008ec:	4501                	li	a0,0
}
    800008ee:	60a6                	ld	ra,72(sp)
    800008f0:	6406                	ld	s0,64(sp)
    800008f2:	74e2                	ld	s1,56(sp)
    800008f4:	7942                	ld	s2,48(sp)
    800008f6:	79a2                	ld	s3,40(sp)
    800008f8:	7a02                	ld	s4,32(sp)
    800008fa:	6ae2                	ld	s5,24(sp)
    800008fc:	6b42                	ld	s6,16(sp)
    800008fe:	6ba2                	ld	s7,8(sp)
    80000900:	6161                	addi	sp,sp,80
    80000902:	8082                	ret
  return 0;
    80000904:	4501                	li	a0,0
}
    80000906:	8082                	ret

0000000080000908 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000908:	1141                	addi	sp,sp,-16
    8000090a:	e406                	sd	ra,8(sp)
    8000090c:	e022                	sd	s0,0(sp)
    8000090e:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000910:	4601                	li	a2,0
    80000912:	ab5ff0ef          	jal	800003c6 <walk>
  if(pte == 0)
    80000916:	c901                	beqz	a0,80000926 <uvmclear+0x1e>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000918:	611c                	ld	a5,0(a0)
    8000091a:	9bbd                	andi	a5,a5,-17
    8000091c:	e11c                	sd	a5,0(a0)
}
    8000091e:	60a2                	ld	ra,8(sp)
    80000920:	6402                	ld	s0,0(sp)
    80000922:	0141                	addi	sp,sp,16
    80000924:	8082                	ret
    panic("uvmclear");
    80000926:	00006517          	auipc	a0,0x6
    8000092a:	7da50513          	addi	a0,a0,2010 # 80007100 <etext+0x100>
    8000092e:	4e7040ef          	jal	80005614 <panic>

0000000080000932 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000932:	cac5                	beqz	a3,800009e2 <copyinstr+0xb0>
{
    80000934:	715d                	addi	sp,sp,-80
    80000936:	e486                	sd	ra,72(sp)
    80000938:	e0a2                	sd	s0,64(sp)
    8000093a:	fc26                	sd	s1,56(sp)
    8000093c:	f84a                	sd	s2,48(sp)
    8000093e:	f44e                	sd	s3,40(sp)
    80000940:	f052                	sd	s4,32(sp)
    80000942:	ec56                	sd	s5,24(sp)
    80000944:	e85a                	sd	s6,16(sp)
    80000946:	e45e                	sd	s7,8(sp)
    80000948:	0880                	addi	s0,sp,80
    8000094a:	8aaa                	mv	s5,a0
    8000094c:	84ae                	mv	s1,a1
    8000094e:	8bb2                	mv	s7,a2
    80000950:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000952:	7b7d                	lui	s6,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000954:	6a05                	lui	s4,0x1
    80000956:	a82d                	j	80000990 <copyinstr+0x5e>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000958:	00078023          	sb	zero,0(a5)
        got_null = 1;
    8000095c:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    8000095e:	0017c793          	xori	a5,a5,1
    80000962:	40f0053b          	negw	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000966:	60a6                	ld	ra,72(sp)
    80000968:	6406                	ld	s0,64(sp)
    8000096a:	74e2                	ld	s1,56(sp)
    8000096c:	7942                	ld	s2,48(sp)
    8000096e:	79a2                	ld	s3,40(sp)
    80000970:	7a02                	ld	s4,32(sp)
    80000972:	6ae2                	ld	s5,24(sp)
    80000974:	6b42                	ld	s6,16(sp)
    80000976:	6ba2                	ld	s7,8(sp)
    80000978:	6161                	addi	sp,sp,80
    8000097a:	8082                	ret
    8000097c:	fff98713          	addi	a4,s3,-1 # fff <_entry-0x7ffff001>
    80000980:	9726                	add	a4,a4,s1
      --max;
    80000982:	40b709b3          	sub	s3,a4,a1
    srcva = va0 + PGSIZE;
    80000986:	01490bb3          	add	s7,s2,s4
  while(got_null == 0 && max > 0){
    8000098a:	04e58463          	beq	a1,a4,800009d2 <copyinstr+0xa0>
{
    8000098e:	84be                	mv	s1,a5
    va0 = PGROUNDDOWN(srcva);
    80000990:	016bf933          	and	s2,s7,s6
    pa0 = walkaddr(pagetable, va0);
    80000994:	85ca                	mv	a1,s2
    80000996:	8556                	mv	a0,s5
    80000998:	ac7ff0ef          	jal	8000045e <walkaddr>
    if(pa0 == 0)
    8000099c:	cd0d                	beqz	a0,800009d6 <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    8000099e:	41790633          	sub	a2,s2,s7
    800009a2:	9652                	add	a2,a2,s4
    if(n > max)
    800009a4:	00c9f363          	bgeu	s3,a2,800009aa <copyinstr+0x78>
    800009a8:	864e                	mv	a2,s3
    while(n > 0){
    800009aa:	ca05                	beqz	a2,800009da <copyinstr+0xa8>
    char *p = (char *) (pa0 + (srcva - va0));
    800009ac:	034b9693          	slli	a3,s7,0x34
    800009b0:	92d1                	srli	a3,a3,0x34
    800009b2:	96aa                	add	a3,a3,a0
    800009b4:	87a6                	mv	a5,s1
      if(*p == '\0'){
    800009b6:	8e85                	sub	a3,a3,s1
    while(n > 0){
    800009b8:	9626                	add	a2,a2,s1
    800009ba:	85be                	mv	a1,a5
      if(*p == '\0'){
    800009bc:	00f68733          	add	a4,a3,a5
    800009c0:	00074703          	lbu	a4,0(a4)
    800009c4:	db51                	beqz	a4,80000958 <copyinstr+0x26>
        *dst = *p;
    800009c6:	00e78023          	sb	a4,0(a5)
      dst++;
    800009ca:	0785                	addi	a5,a5,1
    while(n > 0){
    800009cc:	fec797e3          	bne	a5,a2,800009ba <copyinstr+0x88>
    800009d0:	b775                	j	8000097c <copyinstr+0x4a>
    srcva = va0 + PGSIZE;
    800009d2:	4781                	li	a5,0
    800009d4:	b769                	j	8000095e <copyinstr+0x2c>
      return -1;
    800009d6:	557d                	li	a0,-1
    800009d8:	b779                	j	80000966 <copyinstr+0x34>
    srcva = va0 + PGSIZE;
    800009da:	6b85                	lui	s7,0x1
    800009dc:	9bca                	add	s7,s7,s2
    800009de:	87a6                	mv	a5,s1
    800009e0:	b77d                	j	8000098e <copyinstr+0x5c>
    800009e2:	4781                	li	a5,0
  if(got_null){
    800009e4:	0017c793          	xori	a5,a5,1
    800009e8:	40f0053b          	negw	a0,a5
}
    800009ec:	8082                	ret

00000000800009ee <ismapped>:
  }
  return mem;
}

int
ismapped(pagetable_t pagetable, uint64 va) {
    800009ee:	1141                	addi	sp,sp,-16
    800009f0:	e406                	sd	ra,8(sp)
    800009f2:	e022                	sd	s0,0(sp)
    800009f4:	0800                	addi	s0,sp,16
  pte_t *pte = walk(pagetable, va, 0);
    800009f6:	4601                	li	a2,0
    800009f8:	9cfff0ef          	jal	800003c6 <walk>
  if (pte == 0) {
    800009fc:	c119                	beqz	a0,80000a02 <ismapped+0x14>
    return 0;
  }
  if (*pte & PTE_V){
    800009fe:	6108                	ld	a0,0(a0)
    80000a00:	8905                	andi	a0,a0,1
    return 1;
  }
  return 0;
}
    80000a02:	60a2                	ld	ra,8(sp)
    80000a04:	6402                	ld	s0,0(sp)
    80000a06:	0141                	addi	sp,sp,16
    80000a08:	8082                	ret

0000000080000a0a <vmfault>:
{
    80000a0a:	7179                	addi	sp,sp,-48
    80000a0c:	f406                	sd	ra,40(sp)
    80000a0e:	f022                	sd	s0,32(sp)
    80000a10:	e84a                	sd	s2,16(sp)
    80000a12:	e052                	sd	s4,0(sp)
    80000a14:	1800                	addi	s0,sp,48
    80000a16:	8a2a                	mv	s4,a0
    80000a18:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80000a1a:	32a000ef          	jal	80000d44 <myproc>
  if (va >= p->sz)
    80000a1e:	653c                	ld	a5,72(a0)
    80000a20:	00f96d63          	bltu	s2,a5,80000a3a <vmfault+0x30>
    return 0;
    80000a24:	4a01                	li	s4,0
}
    80000a26:	8552                	mv	a0,s4
    80000a28:	70a2                	ld	ra,40(sp)
    80000a2a:	7402                	ld	s0,32(sp)
    80000a2c:	6942                	ld	s2,16(sp)
    80000a2e:	6a02                	ld	s4,0(sp)
    80000a30:	6145                	addi	sp,sp,48
    80000a32:	8082                	ret
    80000a34:	64e2                	ld	s1,24(sp)
    80000a36:	69a2                	ld	s3,8(sp)
    80000a38:	b7f5                	j	80000a24 <vmfault+0x1a>
    80000a3a:	ec26                	sd	s1,24(sp)
    80000a3c:	e44e                	sd	s3,8(sp)
    80000a3e:	84aa                	mv	s1,a0
  va = PGROUNDDOWN(va);
    80000a40:	77fd                	lui	a5,0xfffff
    80000a42:	00f979b3          	and	s3,s2,a5
  if(ismapped(pagetable, va)) {
    80000a46:	85ce                	mv	a1,s3
    80000a48:	8552                	mv	a0,s4
    80000a4a:	fa5ff0ef          	jal	800009ee <ismapped>
    80000a4e:	c501                	beqz	a0,80000a56 <vmfault+0x4c>
    80000a50:	64e2                	ld	s1,24(sp)
    80000a52:	69a2                	ld	s3,8(sp)
    80000a54:	bfc1                	j	80000a24 <vmfault+0x1a>
  mem = (uint64) kalloc();
    80000a56:	ea6ff0ef          	jal	800000fc <kalloc>
    80000a5a:	892a                	mv	s2,a0
  if(mem == 0)
    80000a5c:	dd61                	beqz	a0,80000a34 <vmfault+0x2a>
  mem = (uint64) kalloc();
    80000a5e:	8a2a                	mv	s4,a0
  memset((void *) mem, 0, PGSIZE);
    80000a60:	6605                	lui	a2,0x1
    80000a62:	4581                	li	a1,0
    80000a64:	edaff0ef          	jal	8000013e <memset>
  if (mappages(p->pagetable, va, PGSIZE, mem, PTE_W|PTE_U|PTE_R) != 0) {
    80000a68:	4759                	li	a4,22
    80000a6a:	86ca                	mv	a3,s2
    80000a6c:	6605                	lui	a2,0x1
    80000a6e:	85ce                	mv	a1,s3
    80000a70:	68a8                	ld	a0,80(s1)
    80000a72:	a25ff0ef          	jal	80000496 <mappages>
    80000a76:	e501                	bnez	a0,80000a7e <vmfault+0x74>
    80000a78:	64e2                	ld	s1,24(sp)
    80000a7a:	69a2                	ld	s3,8(sp)
    80000a7c:	b76d                	j	80000a26 <vmfault+0x1c>
    kfree((void *)mem);
    80000a7e:	854a                	mv	a0,s2
    80000a80:	d9cff0ef          	jal	8000001c <kfree>
    return 0;
    80000a84:	64e2                	ld	s1,24(sp)
    80000a86:	69a2                	ld	s3,8(sp)
    80000a88:	bf71                	j	80000a24 <vmfault+0x1a>

0000000080000a8a <copyout>:
  while(len > 0){
    80000a8a:	cadd                	beqz	a3,80000b40 <copyout+0xb6>
{
    80000a8c:	711d                	addi	sp,sp,-96
    80000a8e:	ec86                	sd	ra,88(sp)
    80000a90:	e8a2                	sd	s0,80(sp)
    80000a92:	e4a6                	sd	s1,72(sp)
    80000a94:	e0ca                	sd	s2,64(sp)
    80000a96:	fc4e                	sd	s3,56(sp)
    80000a98:	f852                	sd	s4,48(sp)
    80000a9a:	f456                	sd	s5,40(sp)
    80000a9c:	f05a                	sd	s6,32(sp)
    80000a9e:	ec5e                	sd	s7,24(sp)
    80000aa0:	e862                	sd	s8,16(sp)
    80000aa2:	e466                	sd	s9,8(sp)
    80000aa4:	e06a                	sd	s10,0(sp)
    80000aa6:	1080                	addi	s0,sp,96
    80000aa8:	8baa                	mv	s7,a0
    80000aaa:	84ae                	mv	s1,a1
    80000aac:	8b32                	mv	s6,a2
    80000aae:	8ab6                	mv	s5,a3
    va0 = PGROUNDDOWN(dstva);
    80000ab0:	7d7d                	lui	s10,0xfffff
    if (va0 >= MAXVA)
    80000ab2:	5cfd                	li	s9,-1
    80000ab4:	01acdc93          	srli	s9,s9,0x1a
    n = PGSIZE - (dstva - va0);
    80000ab8:	6c05                	lui	s8,0x1
    80000aba:	a081                	j	80000afa <copyout+0x70>
      return -1;
    80000abc:	557d                	li	a0,-1
}
    80000abe:	60e6                	ld	ra,88(sp)
    80000ac0:	6446                	ld	s0,80(sp)
    80000ac2:	64a6                	ld	s1,72(sp)
    80000ac4:	6906                	ld	s2,64(sp)
    80000ac6:	79e2                	ld	s3,56(sp)
    80000ac8:	7a42                	ld	s4,48(sp)
    80000aca:	7aa2                	ld	s5,40(sp)
    80000acc:	7b02                	ld	s6,32(sp)
    80000ace:	6be2                	ld	s7,24(sp)
    80000ad0:	6c42                	ld	s8,16(sp)
    80000ad2:	6ca2                	ld	s9,8(sp)
    80000ad4:	6d02                	ld	s10,0(sp)
    80000ad6:	6125                	addi	sp,sp,96
    80000ad8:	8082                	ret
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000ada:	03449513          	slli	a0,s1,0x34
    80000ade:	9151                	srli	a0,a0,0x34
    80000ae0:	0009061b          	sext.w	a2,s2
    80000ae4:	85da                	mv	a1,s6
    80000ae6:	954e                	add	a0,a0,s3
    80000ae8:	eb2ff0ef          	jal	8000019a <memmove>
    len -= n;
    80000aec:	412a8ab3          	sub	s5,s5,s2
    src += n;
    80000af0:	9b4a                	add	s6,s6,s2
    dstva = va0 + PGSIZE;
    80000af2:	018a04b3          	add	s1,s4,s8
  while(len > 0){
    80000af6:	040a8363          	beqz	s5,80000b3c <copyout+0xb2>
    va0 = PGROUNDDOWN(dstva);
    80000afa:	01a4fa33          	and	s4,s1,s10
    if (va0 >= MAXVA)
    80000afe:	fb4cefe3          	bltu	s9,s4,80000abc <copyout+0x32>
    pa0 = walkaddr(pagetable, va0);
    80000b02:	85d2                	mv	a1,s4
    80000b04:	855e                	mv	a0,s7
    80000b06:	959ff0ef          	jal	8000045e <walkaddr>
    80000b0a:	89aa                	mv	s3,a0
    if(pa0 == 0) {
    80000b0c:	e901                	bnez	a0,80000b1c <copyout+0x92>
      if((pa0 = vmfault(pagetable, va0, 0)) == 0) {
    80000b0e:	4601                	li	a2,0
    80000b10:	85d2                	mv	a1,s4
    80000b12:	855e                	mv	a0,s7
    80000b14:	ef7ff0ef          	jal	80000a0a <vmfault>
    80000b18:	89aa                	mv	s3,a0
    80000b1a:	d14d                	beqz	a0,80000abc <copyout+0x32>
    if((pte = walk(pagetable, va0, 0)) == 0) {
    80000b1c:	4601                	li	a2,0
    80000b1e:	85d2                	mv	a1,s4
    80000b20:	855e                	mv	a0,s7
    80000b22:	8a5ff0ef          	jal	800003c6 <walk>
    80000b26:	d959                	beqz	a0,80000abc <copyout+0x32>
    if((*pte & PTE_W) == 0)
    80000b28:	611c                	ld	a5,0(a0)
    80000b2a:	8b91                	andi	a5,a5,4
    80000b2c:	dbc1                	beqz	a5,80000abc <copyout+0x32>
    n = PGSIZE - (dstva - va0);
    80000b2e:	409a0933          	sub	s2,s4,s1
    80000b32:	9962                	add	s2,s2,s8
    if(n > len)
    80000b34:	fb2af3e3          	bgeu	s5,s2,80000ada <copyout+0x50>
    80000b38:	8956                	mv	s2,s5
    80000b3a:	b745                	j	80000ada <copyout+0x50>
  return 0;
    80000b3c:	4501                	li	a0,0
    80000b3e:	b741                	j	80000abe <copyout+0x34>
    80000b40:	4501                	li	a0,0
}
    80000b42:	8082                	ret

0000000080000b44 <copyin>:
  while(len > 0){
    80000b44:	c6d1                	beqz	a3,80000bd0 <copyin+0x8c>
{
    80000b46:	715d                	addi	sp,sp,-80
    80000b48:	e486                	sd	ra,72(sp)
    80000b4a:	e0a2                	sd	s0,64(sp)
    80000b4c:	fc26                	sd	s1,56(sp)
    80000b4e:	f84a                	sd	s2,48(sp)
    80000b50:	f44e                	sd	s3,40(sp)
    80000b52:	f052                	sd	s4,32(sp)
    80000b54:	ec56                	sd	s5,24(sp)
    80000b56:	e85a                	sd	s6,16(sp)
    80000b58:	e45e                	sd	s7,8(sp)
    80000b5a:	e062                	sd	s8,0(sp)
    80000b5c:	0880                	addi	s0,sp,80
    80000b5e:	8baa                	mv	s7,a0
    80000b60:	8aae                	mv	s5,a1
    80000b62:	84b2                	mv	s1,a2
    80000b64:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000b66:	7c7d                	lui	s8,0xfffff
    n = PGSIZE - (srcva - va0);
    80000b68:	6b05                	lui	s6,0x1
    80000b6a:	a03d                	j	80000b98 <copyin+0x54>
    80000b6c:	409a0933          	sub	s2,s4,s1
    80000b70:	995a                	add	s2,s2,s6
    if(n > len)
    80000b72:	0129f363          	bgeu	s3,s2,80000b78 <copyin+0x34>
    80000b76:	894e                	mv	s2,s3
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000b78:	03449593          	slli	a1,s1,0x34
    80000b7c:	91d1                	srli	a1,a1,0x34
    80000b7e:	0009061b          	sext.w	a2,s2
    80000b82:	95aa                	add	a1,a1,a0
    80000b84:	8556                	mv	a0,s5
    80000b86:	e14ff0ef          	jal	8000019a <memmove>
    len -= n;
    80000b8a:	412989b3          	sub	s3,s3,s2
    dst += n;
    80000b8e:	9aca                	add	s5,s5,s2
    srcva = va0 + PGSIZE;
    80000b90:	016a04b3          	add	s1,s4,s6
  while(len > 0){
    80000b94:	02098163          	beqz	s3,80000bb6 <copyin+0x72>
    va0 = PGROUNDDOWN(srcva);
    80000b98:	0184fa33          	and	s4,s1,s8
    pa0 = walkaddr(pagetable, va0);
    80000b9c:	85d2                	mv	a1,s4
    80000b9e:	855e                	mv	a0,s7
    80000ba0:	8bfff0ef          	jal	8000045e <walkaddr>
    if(pa0 == 0) {
    80000ba4:	f561                	bnez	a0,80000b6c <copyin+0x28>
      if((pa0 = vmfault(pagetable, va0, 0)) == 0) {
    80000ba6:	4601                	li	a2,0
    80000ba8:	85d2                	mv	a1,s4
    80000baa:	855e                	mv	a0,s7
    80000bac:	e5fff0ef          	jal	80000a0a <vmfault>
    80000bb0:	fd55                	bnez	a0,80000b6c <copyin+0x28>
        return -1;
    80000bb2:	557d                	li	a0,-1
    80000bb4:	a011                	j	80000bb8 <copyin+0x74>
  return 0;
    80000bb6:	4501                	li	a0,0
}
    80000bb8:	60a6                	ld	ra,72(sp)
    80000bba:	6406                	ld	s0,64(sp)
    80000bbc:	74e2                	ld	s1,56(sp)
    80000bbe:	7942                	ld	s2,48(sp)
    80000bc0:	79a2                	ld	s3,40(sp)
    80000bc2:	7a02                	ld	s4,32(sp)
    80000bc4:	6ae2                	ld	s5,24(sp)
    80000bc6:	6b42                	ld	s6,16(sp)
    80000bc8:	6ba2                	ld	s7,8(sp)
    80000bca:	6c02                	ld	s8,0(sp)
    80000bcc:	6161                	addi	sp,sp,80
    80000bce:	8082                	ret
  return 0;
    80000bd0:	4501                	li	a0,0
}
    80000bd2:	8082                	ret

0000000080000bd4 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80000bd4:	715d                	addi	sp,sp,-80
    80000bd6:	e486                	sd	ra,72(sp)
    80000bd8:	e0a2                	sd	s0,64(sp)
    80000bda:	fc26                	sd	s1,56(sp)
    80000bdc:	f84a                	sd	s2,48(sp)
    80000bde:	f44e                	sd	s3,40(sp)
    80000be0:	f052                	sd	s4,32(sp)
    80000be2:	ec56                	sd	s5,24(sp)
    80000be4:	e85a                	sd	s6,16(sp)
    80000be6:	e45e                	sd	s7,8(sp)
    80000be8:	0880                	addi	s0,sp,80
    80000bea:	8aaa                	mv	s5,a0
    80000bec:	4481                	li	s1,0
  
  for(p = proc; p < &proc[NPROC]; p++) {
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000bee:	421087b7          	lui	a5,0x42108
    80000bf2:	42078793          	addi	a5,a5,1056 # 42108420 <_entry-0x3def7be0>
    80000bf6:	01e79993          	slli	s3,a5,0x1e
    80000bfa:	99be                	add	s3,s3,a5
    80000bfc:	fff9c993          	not	s3,s3
    80000c00:	04000937          	lui	s2,0x4000
    80000c04:	197d                	addi	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
    80000c06:	0932                	slli	s2,s2,0xc
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000c08:	4b99                	li	s7,6
    80000c0a:	6b05                	lui	s6,0x1
  for(p = proc; p < &proc[NPROC]; p++) {
    80000c0c:	6a21                	lui	s4,0x8
    80000c0e:	c00a0a13          	addi	s4,s4,-1024 # 7c00 <_entry-0x7fff8400>
    char *pa = kalloc();
    80000c12:	ceaff0ef          	jal	800000fc <kalloc>
    80000c16:	862a                	mv	a2,a0
    if(pa == 0)
    80000c18:	cd15                	beqz	a0,80000c54 <proc_mapstacks+0x80>
    uint64 va = KSTACK((int) (p - proc));
    80000c1a:	4044d593          	srai	a1,s1,0x4
    80000c1e:	033585b3          	mul	a1,a1,s3
    80000c22:	05b6                	slli	a1,a1,0xd
    80000c24:	6789                	lui	a5,0x2
    80000c26:	9dbd                	addw	a1,a1,a5
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000c28:	875e                	mv	a4,s7
    80000c2a:	86da                	mv	a3,s6
    80000c2c:	40b905b3          	sub	a1,s2,a1
    80000c30:	8556                	mv	a0,s5
    80000c32:	917ff0ef          	jal	80000548 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000c36:	1f048493          	addi	s1,s1,496
    80000c3a:	fd449ce3          	bne	s1,s4,80000c12 <proc_mapstacks+0x3e>
  }
}
    80000c3e:	60a6                	ld	ra,72(sp)
    80000c40:	6406                	ld	s0,64(sp)
    80000c42:	74e2                	ld	s1,56(sp)
    80000c44:	7942                	ld	s2,48(sp)
    80000c46:	79a2                	ld	s3,40(sp)
    80000c48:	7a02                	ld	s4,32(sp)
    80000c4a:	6ae2                	ld	s5,24(sp)
    80000c4c:	6b42                	ld	s6,16(sp)
    80000c4e:	6ba2                	ld	s7,8(sp)
    80000c50:	6161                	addi	sp,sp,80
    80000c52:	8082                	ret
      panic("kalloc");
    80000c54:	00006517          	auipc	a0,0x6
    80000c58:	4bc50513          	addi	a0,a0,1212 # 80007110 <etext+0x110>
    80000c5c:	1b9040ef          	jal	80005614 <panic>

0000000080000c60 <procinit>:

// initialize the proc table.
void
procinit(void)
{
    80000c60:	7139                	addi	sp,sp,-64
    80000c62:	fc06                	sd	ra,56(sp)
    80000c64:	f822                	sd	s0,48(sp)
    80000c66:	f426                	sd	s1,40(sp)
    80000c68:	f04a                	sd	s2,32(sp)
    80000c6a:	ec4e                	sd	s3,24(sp)
    80000c6c:	e852                	sd	s4,16(sp)
    80000c6e:	e456                	sd	s5,8(sp)
    80000c70:	e05a                	sd	s6,0(sp)
    80000c72:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000c74:	00006597          	auipc	a1,0x6
    80000c78:	4a458593          	addi	a1,a1,1188 # 80007118 <etext+0x118>
    80000c7c:	00007517          	auipc	a0,0x7
    80000c80:	c2450513          	addi	a0,a0,-988 # 800078a0 <pid_lock>
    80000c84:	3c5040ef          	jal	80005848 <initlock>
  initlock(&wait_lock, "wait_lock");
    80000c88:	00006597          	auipc	a1,0x6
    80000c8c:	49858593          	addi	a1,a1,1176 # 80007120 <etext+0x120>
    80000c90:	00007517          	auipc	a0,0x7
    80000c94:	c2850513          	addi	a0,a0,-984 # 800078b8 <wait_lock>
    80000c98:	3b1040ef          	jal	80005848 <initlock>
    80000c9c:	4901                	li	s2,0
  for(p = proc; p < &proc[NPROC]; p++) {
    80000c9e:	00007497          	auipc	s1,0x7
    80000ca2:	03248493          	addi	s1,s1,50 # 80007cd0 <proc>
      initlock(&p->lock, "proc");
    80000ca6:	00006a97          	auipc	s5,0x6
    80000caa:	48aa8a93          	addi	s5,s5,1162 # 80007130 <etext+0x130>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80000cae:	421087b7          	lui	a5,0x42108
    80000cb2:	42078793          	addi	a5,a5,1056 # 42108420 <_entry-0x3def7be0>
    80000cb6:	01e79a13          	slli	s4,a5,0x1e
    80000cba:	9a3e                	add	s4,s4,a5
    80000cbc:	fffa4a13          	not	s4,s4
    80000cc0:	040009b7          	lui	s3,0x4000
    80000cc4:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000cc6:	09b2                	slli	s3,s3,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000cc8:	0000fb17          	auipc	s6,0xf
    80000ccc:	c08b0b13          	addi	s6,s6,-1016 # 8000f8d0 <tickslock>
      initlock(&p->lock, "proc");
    80000cd0:	85d6                	mv	a1,s5
    80000cd2:	8526                	mv	a0,s1
    80000cd4:	375040ef          	jal	80005848 <initlock>
      p->state = UNUSED;
    80000cd8:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK((int) (p - proc));
    80000cdc:	40495793          	srai	a5,s2,0x4
    80000ce0:	034787b3          	mul	a5,a5,s4
    80000ce4:	07b6                	slli	a5,a5,0xd
    80000ce6:	6709                	lui	a4,0x2
    80000ce8:	9fb9                	addw	a5,a5,a4
    80000cea:	40f987b3          	sub	a5,s3,a5
    80000cee:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000cf0:	1f048493          	addi	s1,s1,496
    80000cf4:	1f090913          	addi	s2,s2,496
    80000cf8:	fd649ce3          	bne	s1,s6,80000cd0 <procinit+0x70>
  }
}
    80000cfc:	70e2                	ld	ra,56(sp)
    80000cfe:	7442                	ld	s0,48(sp)
    80000d00:	74a2                	ld	s1,40(sp)
    80000d02:	7902                	ld	s2,32(sp)
    80000d04:	69e2                	ld	s3,24(sp)
    80000d06:	6a42                	ld	s4,16(sp)
    80000d08:	6aa2                	ld	s5,8(sp)
    80000d0a:	6b02                	ld	s6,0(sp)
    80000d0c:	6121                	addi	sp,sp,64
    80000d0e:	8082                	ret

0000000080000d10 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000d10:	1141                	addi	sp,sp,-16
    80000d12:	e406                	sd	ra,8(sp)
    80000d14:	e022                	sd	s0,0(sp)
    80000d16:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000d18:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000d1a:	2501                	sext.w	a0,a0
    80000d1c:	60a2                	ld	ra,8(sp)
    80000d1e:	6402                	ld	s0,0(sp)
    80000d20:	0141                	addi	sp,sp,16
    80000d22:	8082                	ret

0000000080000d24 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    80000d24:	1141                	addi	sp,sp,-16
    80000d26:	e406                	sd	ra,8(sp)
    80000d28:	e022                	sd	s0,0(sp)
    80000d2a:	0800                	addi	s0,sp,16
    80000d2c:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000d2e:	2781                	sext.w	a5,a5
    80000d30:	079e                	slli	a5,a5,0x7
  return c;
}
    80000d32:	00007517          	auipc	a0,0x7
    80000d36:	b9e50513          	addi	a0,a0,-1122 # 800078d0 <cpus>
    80000d3a:	953e                	add	a0,a0,a5
    80000d3c:	60a2                	ld	ra,8(sp)
    80000d3e:	6402                	ld	s0,0(sp)
    80000d40:	0141                	addi	sp,sp,16
    80000d42:	8082                	ret

0000000080000d44 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80000d44:	1101                	addi	sp,sp,-32
    80000d46:	ec06                	sd	ra,24(sp)
    80000d48:	e822                	sd	s0,16(sp)
    80000d4a:	e426                	sd	s1,8(sp)
    80000d4c:	1000                	addi	s0,sp,32
  push_off();
    80000d4e:	341040ef          	jal	8000588e <push_off>
    80000d52:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000d54:	2781                	sext.w	a5,a5
    80000d56:	079e                	slli	a5,a5,0x7
    80000d58:	00007717          	auipc	a4,0x7
    80000d5c:	b4870713          	addi	a4,a4,-1208 # 800078a0 <pid_lock>
    80000d60:	97ba                	add	a5,a5,a4
    80000d62:	7b9c                	ld	a5,48(a5)
    80000d64:	84be                	mv	s1,a5
  pop_off();
    80000d66:	3ad040ef          	jal	80005912 <pop_off>
  return p;
}
    80000d6a:	8526                	mv	a0,s1
    80000d6c:	60e2                	ld	ra,24(sp)
    80000d6e:	6442                	ld	s0,16(sp)
    80000d70:	64a2                	ld	s1,8(sp)
    80000d72:	6105                	addi	sp,sp,32
    80000d74:	8082                	ret

0000000080000d76 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000d76:	7179                	addi	sp,sp,-48
    80000d78:	f406                	sd	ra,40(sp)
    80000d7a:	f022                	sd	s0,32(sp)
    80000d7c:	ec26                	sd	s1,24(sp)
    80000d7e:	1800                	addi	s0,sp,48
  extern char userret[];
  static int first = 1;
  struct proc *p = myproc();
    80000d80:	fc5ff0ef          	jal	80000d44 <myproc>
    80000d84:	84aa                	mv	s1,a0

  // Still holding p->lock from scheduler.
  release(&p->lock);
    80000d86:	3dd040ef          	jal	80005962 <release>

  if (first) {
    80000d8a:	00007797          	auipc	a5,0x7
    80000d8e:	ab67a783          	lw	a5,-1354(a5) # 80007840 <first.1>
    80000d92:	cf95                	beqz	a5,80000dce <forkret+0x58>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    fsinit(ROOTDEV);
    80000d94:	4505                	li	a0,1
    80000d96:	41f010ef          	jal	800029b4 <fsinit>

    first = 0;
    80000d9a:	00007797          	auipc	a5,0x7
    80000d9e:	aa07a323          	sw	zero,-1370(a5) # 80007840 <first.1>
    // ensure other cores see first=0.
    __sync_synchronize();
    80000da2:	0330000f          	fence	rw,rw

    // We can invoke kexec() now that file system is initialized.
    // Put the return value (argc) of kexec into a0.
    p->trapframe->a0 = kexec("/init", (char *[]){ "/init", 0 });
    80000da6:	00006797          	auipc	a5,0x6
    80000daa:	39278793          	addi	a5,a5,914 # 80007138 <etext+0x138>
    80000dae:	fcf43823          	sd	a5,-48(s0)
    80000db2:	fc043c23          	sd	zero,-40(s0)
    80000db6:	fd040593          	addi	a1,s0,-48
    80000dba:	853e                	mv	a0,a5
    80000dbc:	56b020ef          	jal	80003b26 <kexec>
    80000dc0:	6cbc                	ld	a5,88(s1)
    80000dc2:	fba8                	sd	a0,112(a5)
    if (p->trapframe->a0 == -1) {
    80000dc4:	6cbc                	ld	a5,88(s1)
    80000dc6:	7bb8                	ld	a4,112(a5)
    80000dc8:	57fd                	li	a5,-1
    80000dca:	02f70d63          	beq	a4,a5,80000e04 <forkret+0x8e>
      panic("exec");
    }
  }

  // return to user space, mimicing usertrap()'s return.
  prepare_return();
    80000dce:	2af000ef          	jal	8000187c <prepare_return>
  uint64 satp = MAKE_SATP(p->pagetable);
    80000dd2:	68a8                	ld	a0,80(s1)
    80000dd4:	8131                	srli	a0,a0,0xc
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80000dd6:	04000737          	lui	a4,0x4000
    80000dda:	177d                	addi	a4,a4,-1 # 3ffffff <_entry-0x7c000001>
    80000ddc:	0732                	slli	a4,a4,0xc
    80000dde:	00005797          	auipc	a5,0x5
    80000de2:	2be78793          	addi	a5,a5,702 # 8000609c <userret>
    80000de6:	00005697          	auipc	a3,0x5
    80000dea:	21a68693          	addi	a3,a3,538 # 80006000 <_trampoline>
    80000dee:	8f95                	sub	a5,a5,a3
    80000df0:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80000df2:	577d                	li	a4,-1
    80000df4:	177e                	slli	a4,a4,0x3f
    80000df6:	8d59                	or	a0,a0,a4
    80000df8:	9782                	jalr	a5
}
    80000dfa:	70a2                	ld	ra,40(sp)
    80000dfc:	7402                	ld	s0,32(sp)
    80000dfe:	64e2                	ld	s1,24(sp)
    80000e00:	6145                	addi	sp,sp,48
    80000e02:	8082                	ret
      panic("exec");
    80000e04:	00006517          	auipc	a0,0x6
    80000e08:	33c50513          	addi	a0,a0,828 # 80007140 <etext+0x140>
    80000e0c:	009040ef          	jal	80005614 <panic>

0000000080000e10 <allocpid>:
{
    80000e10:	1101                	addi	sp,sp,-32
    80000e12:	ec06                	sd	ra,24(sp)
    80000e14:	e822                	sd	s0,16(sp)
    80000e16:	e426                	sd	s1,8(sp)
    80000e18:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000e1a:	00007517          	auipc	a0,0x7
    80000e1e:	a8650513          	addi	a0,a0,-1402 # 800078a0 <pid_lock>
    80000e22:	2b1040ef          	jal	800058d2 <acquire>
  pid = nextpid;
    80000e26:	00007797          	auipc	a5,0x7
    80000e2a:	a1e78793          	addi	a5,a5,-1506 # 80007844 <nextpid>
    80000e2e:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000e30:	0014871b          	addiw	a4,s1,1
    80000e34:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000e36:	00007517          	auipc	a0,0x7
    80000e3a:	a6a50513          	addi	a0,a0,-1430 # 800078a0 <pid_lock>
    80000e3e:	325040ef          	jal	80005962 <release>
}
    80000e42:	8526                	mv	a0,s1
    80000e44:	60e2                	ld	ra,24(sp)
    80000e46:	6442                	ld	s0,16(sp)
    80000e48:	64a2                	ld	s1,8(sp)
    80000e4a:	6105                	addi	sp,sp,32
    80000e4c:	8082                	ret

0000000080000e4e <proc_pagetable>:
{
    80000e4e:	1101                	addi	sp,sp,-32
    80000e50:	ec06                	sd	ra,24(sp)
    80000e52:	e822                	sd	s0,16(sp)
    80000e54:	e426                	sd	s1,8(sp)
    80000e56:	e04a                	sd	s2,0(sp)
    80000e58:	1000                	addi	s0,sp,32
    80000e5a:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000e5c:	fdaff0ef          	jal	80000636 <uvmcreate>
    80000e60:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000e62:	cd05                	beqz	a0,80000e9a <proc_pagetable+0x4c>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80000e64:	4729                	li	a4,10
    80000e66:	00005697          	auipc	a3,0x5
    80000e6a:	19a68693          	addi	a3,a3,410 # 80006000 <_trampoline>
    80000e6e:	6605                	lui	a2,0x1
    80000e70:	040005b7          	lui	a1,0x4000
    80000e74:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000e76:	05b2                	slli	a1,a1,0xc
    80000e78:	e1eff0ef          	jal	80000496 <mappages>
    80000e7c:	02054663          	bltz	a0,80000ea8 <proc_pagetable+0x5a>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80000e80:	4719                	li	a4,6
    80000e82:	05893683          	ld	a3,88(s2)
    80000e86:	6605                	lui	a2,0x1
    80000e88:	020005b7          	lui	a1,0x2000
    80000e8c:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000e8e:	05b6                	slli	a1,a1,0xd
    80000e90:	8526                	mv	a0,s1
    80000e92:	e04ff0ef          	jal	80000496 <mappages>
    80000e96:	00054f63          	bltz	a0,80000eb4 <proc_pagetable+0x66>
}
    80000e9a:	8526                	mv	a0,s1
    80000e9c:	60e2                	ld	ra,24(sp)
    80000e9e:	6442                	ld	s0,16(sp)
    80000ea0:	64a2                	ld	s1,8(sp)
    80000ea2:	6902                	ld	s2,0(sp)
    80000ea4:	6105                	addi	sp,sp,32
    80000ea6:	8082                	ret
    uvmfree(pagetable, 0);
    80000ea8:	4581                	li	a1,0
    80000eaa:	8526                	mv	a0,s1
    80000eac:	991ff0ef          	jal	8000083c <uvmfree>
    return 0;
    80000eb0:	4481                	li	s1,0
    80000eb2:	b7e5                	j	80000e9a <proc_pagetable+0x4c>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000eb4:	4681                	li	a3,0
    80000eb6:	4605                	li	a2,1
    80000eb8:	040005b7          	lui	a1,0x4000
    80000ebc:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000ebe:	05b2                	slli	a1,a1,0xc
    80000ec0:	8526                	mv	a0,s1
    80000ec2:	f9aff0ef          	jal	8000065c <uvmunmap>
    uvmfree(pagetable, 0);
    80000ec6:	4581                	li	a1,0
    80000ec8:	8526                	mv	a0,s1
    80000eca:	973ff0ef          	jal	8000083c <uvmfree>
    return 0;
    80000ece:	b7cd                	j	80000eb0 <proc_pagetable+0x62>

0000000080000ed0 <proc_freepagetable>:
{
    80000ed0:	1101                	addi	sp,sp,-32
    80000ed2:	ec06                	sd	ra,24(sp)
    80000ed4:	e822                	sd	s0,16(sp)
    80000ed6:	e426                	sd	s1,8(sp)
    80000ed8:	e04a                	sd	s2,0(sp)
    80000eda:	1000                	addi	s0,sp,32
    80000edc:	84aa                	mv	s1,a0
    80000ede:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000ee0:	4681                	li	a3,0
    80000ee2:	4605                	li	a2,1
    80000ee4:	040005b7          	lui	a1,0x4000
    80000ee8:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000eea:	05b2                	slli	a1,a1,0xc
    80000eec:	f70ff0ef          	jal	8000065c <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80000ef0:	4681                	li	a3,0
    80000ef2:	4605                	li	a2,1
    80000ef4:	020005b7          	lui	a1,0x2000
    80000ef8:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000efa:	05b6                	slli	a1,a1,0xd
    80000efc:	8526                	mv	a0,s1
    80000efe:	f5eff0ef          	jal	8000065c <uvmunmap>
  uvmfree(pagetable, sz);
    80000f02:	85ca                	mv	a1,s2
    80000f04:	8526                	mv	a0,s1
    80000f06:	937ff0ef          	jal	8000083c <uvmfree>
}
    80000f0a:	60e2                	ld	ra,24(sp)
    80000f0c:	6442                	ld	s0,16(sp)
    80000f0e:	64a2                	ld	s1,8(sp)
    80000f10:	6902                	ld	s2,0(sp)
    80000f12:	6105                	addi	sp,sp,32
    80000f14:	8082                	ret

0000000080000f16 <freeproc>:
{
    80000f16:	1101                	addi	sp,sp,-32
    80000f18:	ec06                	sd	ra,24(sp)
    80000f1a:	e822                	sd	s0,16(sp)
    80000f1c:	e426                	sd	s1,8(sp)
    80000f1e:	1000                	addi	s0,sp,32
    80000f20:	84aa                	mv	s1,a0
  if(p->trapframe)
    80000f22:	6d28                	ld	a0,88(a0)
    80000f24:	c119                	beqz	a0,80000f2a <freeproc+0x14>
    kfree((void*)p->trapframe);
    80000f26:	8f6ff0ef          	jal	8000001c <kfree>
  p->trapframe = 0;
    80000f2a:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80000f2e:	68a8                	ld	a0,80(s1)
    80000f30:	c501                	beqz	a0,80000f38 <freeproc+0x22>
    proc_freepagetable(p->pagetable, p->sz);
    80000f32:	64ac                	ld	a1,72(s1)
    80000f34:	f9dff0ef          	jal	80000ed0 <proc_freepagetable>
  p->pagetable = 0;
    80000f38:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80000f3c:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80000f40:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80000f44:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80000f48:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80000f4c:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80000f50:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80000f54:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80000f58:	0004ac23          	sw	zero,24(s1)
}
    80000f5c:	60e2                	ld	ra,24(sp)
    80000f5e:	6442                	ld	s0,16(sp)
    80000f60:	64a2                	ld	s1,8(sp)
    80000f62:	6105                	addi	sp,sp,32
    80000f64:	8082                	ret

0000000080000f66 <allocproc>:
{
    80000f66:	1101                	addi	sp,sp,-32
    80000f68:	ec06                	sd	ra,24(sp)
    80000f6a:	e822                	sd	s0,16(sp)
    80000f6c:	e426                	sd	s1,8(sp)
    80000f6e:	e04a                	sd	s2,0(sp)
    80000f70:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80000f72:	00007497          	auipc	s1,0x7
    80000f76:	d5e48493          	addi	s1,s1,-674 # 80007cd0 <proc>
    80000f7a:	0000f917          	auipc	s2,0xf
    80000f7e:	95690913          	addi	s2,s2,-1706 # 8000f8d0 <tickslock>
    acquire(&p->lock);
    80000f82:	8526                	mv	a0,s1
    80000f84:	14f040ef          	jal	800058d2 <acquire>
    if(p->state == UNUSED) {
    80000f88:	4c9c                	lw	a5,24(s1)
    80000f8a:	cb91                	beqz	a5,80000f9e <allocproc+0x38>
      release(&p->lock);
    80000f8c:	8526                	mv	a0,s1
    80000f8e:	1d5040ef          	jal	80005962 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000f92:	1f048493          	addi	s1,s1,496
    80000f96:	ff2496e3          	bne	s1,s2,80000f82 <allocproc+0x1c>
  return 0;
    80000f9a:	4481                	li	s1,0
    80000f9c:	a089                	j	80000fde <allocproc+0x78>
  p->pid = allocpid();
    80000f9e:	e73ff0ef          	jal	80000e10 <allocpid>
    80000fa2:	d888                	sw	a0,48(s1)
  p->state = USED;
    80000fa4:	4785                	li	a5,1
    80000fa6:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80000fa8:	954ff0ef          	jal	800000fc <kalloc>
    80000fac:	892a                	mv	s2,a0
    80000fae:	eca8                	sd	a0,88(s1)
    80000fb0:	cd15                	beqz	a0,80000fec <allocproc+0x86>
  p->pagetable = proc_pagetable(p);
    80000fb2:	8526                	mv	a0,s1
    80000fb4:	e9bff0ef          	jal	80000e4e <proc_pagetable>
    80000fb8:	892a                	mv	s2,a0
    80000fba:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    80000fbc:	c121                	beqz	a0,80000ffc <allocproc+0x96>
  memset(&p->context, 0, sizeof(p->context));
    80000fbe:	07000613          	li	a2,112
    80000fc2:	4581                	li	a1,0
    80000fc4:	06048513          	addi	a0,s1,96
    80000fc8:	976ff0ef          	jal	8000013e <memset>
  p->context.ra = (uint64)forkret;
    80000fcc:	00000797          	auipc	a5,0x0
    80000fd0:	daa78793          	addi	a5,a5,-598 # 80000d76 <forkret>
    80000fd4:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80000fd6:	60bc                	ld	a5,64(s1)
    80000fd8:	6705                	lui	a4,0x1
    80000fda:	97ba                	add	a5,a5,a4
    80000fdc:	f4bc                	sd	a5,104(s1)
}
    80000fde:	8526                	mv	a0,s1
    80000fe0:	60e2                	ld	ra,24(sp)
    80000fe2:	6442                	ld	s0,16(sp)
    80000fe4:	64a2                	ld	s1,8(sp)
    80000fe6:	6902                	ld	s2,0(sp)
    80000fe8:	6105                	addi	sp,sp,32
    80000fea:	8082                	ret
    freeproc(p);
    80000fec:	8526                	mv	a0,s1
    80000fee:	f29ff0ef          	jal	80000f16 <freeproc>
    release(&p->lock);
    80000ff2:	8526                	mv	a0,s1
    80000ff4:	16f040ef          	jal	80005962 <release>
    return 0;
    80000ff8:	84ca                	mv	s1,s2
    80000ffa:	b7d5                	j	80000fde <allocproc+0x78>
    freeproc(p);
    80000ffc:	8526                	mv	a0,s1
    80000ffe:	f19ff0ef          	jal	80000f16 <freeproc>
    release(&p->lock);
    80001002:	8526                	mv	a0,s1
    80001004:	15f040ef          	jal	80005962 <release>
    return 0;
    80001008:	84ca                	mv	s1,s2
    8000100a:	bfd1                	j	80000fde <allocproc+0x78>

000000008000100c <userinit>:
{
    8000100c:	1101                	addi	sp,sp,-32
    8000100e:	ec06                	sd	ra,24(sp)
    80001010:	e822                	sd	s0,16(sp)
    80001012:	e426                	sd	s1,8(sp)
    80001014:	1000                	addi	s0,sp,32
  p = allocproc();
    80001016:	f51ff0ef          	jal	80000f66 <allocproc>
    8000101a:	84aa                	mv	s1,a0
  initproc = p;
    8000101c:	00007797          	auipc	a5,0x7
    80001020:	84a7b223          	sd	a0,-1980(a5) # 80007860 <initproc>
  p->cwd = namei("/");
    80001024:	00006517          	auipc	a0,0x6
    80001028:	12450513          	addi	a0,a0,292 # 80007148 <etext+0x148>
    8000102c:	6cd010ef          	jal	80002ef8 <namei>
    80001030:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001034:	478d                	li	a5,3
    80001036:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001038:	8526                	mv	a0,s1
    8000103a:	129040ef          	jal	80005962 <release>
}
    8000103e:	60e2                	ld	ra,24(sp)
    80001040:	6442                	ld	s0,16(sp)
    80001042:	64a2                	ld	s1,8(sp)
    80001044:	6105                	addi	sp,sp,32
    80001046:	8082                	ret

0000000080001048 <growproc>:
{
    80001048:	1101                	addi	sp,sp,-32
    8000104a:	ec06                	sd	ra,24(sp)
    8000104c:	e822                	sd	s0,16(sp)
    8000104e:	e426                	sd	s1,8(sp)
    80001050:	e04a                	sd	s2,0(sp)
    80001052:	1000                	addi	s0,sp,32
    80001054:	892a                	mv	s2,a0
  struct proc *p = myproc();
    80001056:	cefff0ef          	jal	80000d44 <myproc>
    8000105a:	84aa                	mv	s1,a0
  sz = p->sz;
    8000105c:	652c                	ld	a1,72(a0)
  if(n > 0){
    8000105e:	01204c63          	bgtz	s2,80001076 <growproc+0x2e>
  } else if(n < 0){
    80001062:	02094463          	bltz	s2,8000108a <growproc+0x42>
  p->sz = sz;
    80001066:	e4ac                	sd	a1,72(s1)
  return 0;
    80001068:	4501                	li	a0,0
}
    8000106a:	60e2                	ld	ra,24(sp)
    8000106c:	6442                	ld	s0,16(sp)
    8000106e:	64a2                	ld	s1,8(sp)
    80001070:	6902                	ld	s2,0(sp)
    80001072:	6105                	addi	sp,sp,32
    80001074:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80001076:	4691                	li	a3,4
    80001078:	00b90633          	add	a2,s2,a1
    8000107c:	6928                	ld	a0,80(a0)
    8000107e:	ecaff0ef          	jal	80000748 <uvmalloc>
    80001082:	85aa                	mv	a1,a0
    80001084:	f16d                	bnez	a0,80001066 <growproc+0x1e>
      return -1;
    80001086:	557d                	li	a0,-1
    80001088:	b7cd                	j	8000106a <growproc+0x22>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    8000108a:	00b90633          	add	a2,s2,a1
    8000108e:	6928                	ld	a0,80(a0)
    80001090:	e72ff0ef          	jal	80000702 <uvmdealloc>
    80001094:	85aa                	mv	a1,a0
    80001096:	bfc1                	j	80001066 <growproc+0x1e>

0000000080001098 <kfork>:
{
    80001098:	7139                	addi	sp,sp,-64
    8000109a:	fc06                	sd	ra,56(sp)
    8000109c:	f822                	sd	s0,48(sp)
    8000109e:	f426                	sd	s1,40(sp)
    800010a0:	e456                	sd	s5,8(sp)
    800010a2:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    800010a4:	ca1ff0ef          	jal	80000d44 <myproc>
    800010a8:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    800010aa:	ebdff0ef          	jal	80000f66 <allocproc>
    800010ae:	c92d                	beqz	a0,80001120 <kfork+0x88>
    800010b0:	ec4e                	sd	s3,24(sp)
    800010b2:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    800010b4:	048ab603          	ld	a2,72(s5)
    800010b8:	692c                	ld	a1,80(a0)
    800010ba:	050ab503          	ld	a0,80(s5)
    800010be:	fb0ff0ef          	jal	8000086e <uvmcopy>
    800010c2:	04054863          	bltz	a0,80001112 <kfork+0x7a>
    800010c6:	f04a                	sd	s2,32(sp)
    800010c8:	e852                	sd	s4,16(sp)
  np->sz = p->sz;
    800010ca:	048ab783          	ld	a5,72(s5)
    800010ce:	04f9b423          	sd	a5,72(s3)
  *(np->trapframe) = *(p->trapframe);
    800010d2:	058ab683          	ld	a3,88(s5)
    800010d6:	87b6                	mv	a5,a3
    800010d8:	0589b703          	ld	a4,88(s3)
    800010dc:	12068693          	addi	a3,a3,288
    800010e0:	6388                	ld	a0,0(a5)
    800010e2:	678c                	ld	a1,8(a5)
    800010e4:	6b90                	ld	a2,16(a5)
    800010e6:	e308                	sd	a0,0(a4)
    800010e8:	e70c                	sd	a1,8(a4)
    800010ea:	eb10                	sd	a2,16(a4)
    800010ec:	6f90                	ld	a2,24(a5)
    800010ee:	ef10                	sd	a2,24(a4)
    800010f0:	02078793          	addi	a5,a5,32
    800010f4:	02070713          	addi	a4,a4,32 # 1020 <_entry-0x7fffefe0>
    800010f8:	fed794e3          	bne	a5,a3,800010e0 <kfork+0x48>
  np->trapframe->a0 = 0;
    800010fc:	0589b783          	ld	a5,88(s3)
    80001100:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001104:	0d0a8493          	addi	s1,s5,208
    80001108:	0d098913          	addi	s2,s3,208
    8000110c:	150a8a13          	addi	s4,s5,336
    80001110:	a831                	j	8000112c <kfork+0x94>
    freeproc(np);
    80001112:	854e                	mv	a0,s3
    80001114:	e03ff0ef          	jal	80000f16 <freeproc>
    release(&np->lock);
    80001118:	854e                	mv	a0,s3
    8000111a:	049040ef          	jal	80005962 <release>
    return -1;
    8000111e:	69e2                	ld	s3,24(sp)
    return -1;
    80001120:	54fd                	li	s1,-1
    80001122:	a061                	j	800011aa <kfork+0x112>
  for(i = 0; i < NOFILE; i++)
    80001124:	04a1                	addi	s1,s1,8
    80001126:	0921                	addi	s2,s2,8
    80001128:	01448963          	beq	s1,s4,8000113a <kfork+0xa2>
    if(p->ofile[i])
    8000112c:	6088                	ld	a0,0(s1)
    8000112e:	d97d                	beqz	a0,80001124 <kfork+0x8c>
      np->ofile[i] = filedup(p->ofile[i]);
    80001130:	380020ef          	jal	800034b0 <filedup>
    80001134:	00a93023          	sd	a0,0(s2)
    80001138:	b7f5                	j	80001124 <kfork+0x8c>
  np->cwd = idup(p->cwd);
    8000113a:	150ab503          	ld	a0,336(s5)
    8000113e:	54c010ef          	jal	8000268a <idup>
    80001142:	14a9b823          	sd	a0,336(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001146:	4641                	li	a2,16
    80001148:	158a8593          	addi	a1,s5,344
    8000114c:	15898513          	addi	a0,s3,344
    80001150:	938ff0ef          	jal	80000288 <safestrcpy>
  pid = np->pid;
    80001154:	0309a483          	lw	s1,48(s3)
  release(&np->lock);
    80001158:	854e                	mv	a0,s3
    8000115a:	009040ef          	jal	80005962 <release>
  acquire(&wait_lock);
    8000115e:	00006517          	auipc	a0,0x6
    80001162:	75a50513          	addi	a0,a0,1882 # 800078b8 <wait_lock>
    80001166:	76c040ef          	jal	800058d2 <acquire>
  np->parent = p;
    8000116a:	0359bc23          	sd	s5,56(s3)
  release(&wait_lock);
    8000116e:	00006517          	auipc	a0,0x6
    80001172:	74a50513          	addi	a0,a0,1866 # 800078b8 <wait_lock>
    80001176:	7ec040ef          	jal	80005962 <release>
  acquire(&np->lock);
    8000117a:	854e                	mv	a0,s3
    8000117c:	756040ef          	jal	800058d2 <acquire>
  np->state = RUNNABLE;
    80001180:	478d                	li	a5,3
    80001182:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    80001186:	854e                	mv	a0,s3
    80001188:	7da040ef          	jal	80005962 <release>
  np->interpose_mask=p->interpose_mask;
    8000118c:	168aa783          	lw	a5,360(s5)
    80001190:	16f9a423          	sw	a5,360(s3)
  safestrcpy(np->interpose_path,p->interpose_path, MAXPATH);
    80001194:	08000613          	li	a2,128
    80001198:	16ca8593          	addi	a1,s5,364
    8000119c:	16c98513          	addi	a0,s3,364
    800011a0:	8e8ff0ef          	jal	80000288 <safestrcpy>
    800011a4:	7902                	ld	s2,32(sp)
    800011a6:	69e2                	ld	s3,24(sp)
    800011a8:	6a42                	ld	s4,16(sp)
}
    800011aa:	8526                	mv	a0,s1
    800011ac:	70e2                	ld	ra,56(sp)
    800011ae:	7442                	ld	s0,48(sp)
    800011b0:	74a2                	ld	s1,40(sp)
    800011b2:	6aa2                	ld	s5,8(sp)
    800011b4:	6121                	addi	sp,sp,64
    800011b6:	8082                	ret

00000000800011b8 <scheduler>:
{
    800011b8:	715d                	addi	sp,sp,-80
    800011ba:	e486                	sd	ra,72(sp)
    800011bc:	e0a2                	sd	s0,64(sp)
    800011be:	fc26                	sd	s1,56(sp)
    800011c0:	f84a                	sd	s2,48(sp)
    800011c2:	f44e                	sd	s3,40(sp)
    800011c4:	f052                	sd	s4,32(sp)
    800011c6:	ec56                	sd	s5,24(sp)
    800011c8:	e85a                	sd	s6,16(sp)
    800011ca:	e45e                	sd	s7,8(sp)
    800011cc:	e062                	sd	s8,0(sp)
    800011ce:	0880                	addi	s0,sp,80
    800011d0:	8792                	mv	a5,tp
  int id = r_tp();
    800011d2:	2781                	sext.w	a5,a5
  c->proc = 0;
    800011d4:	00779693          	slli	a3,a5,0x7
    800011d8:	00006717          	auipc	a4,0x6
    800011dc:	6c870713          	addi	a4,a4,1736 # 800078a0 <pid_lock>
    800011e0:	9736                	add	a4,a4,a3
    800011e2:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    800011e6:	00006b17          	auipc	s6,0x6
    800011ea:	6f2b0b13          	addi	s6,s6,1778 # 800078d8 <cpus+0x8>
    800011ee:	9b36                	add	s6,s6,a3
        p->state = RUNNING;
    800011f0:	4c11                	li	s8,4
        c->proc = p;
    800011f2:	8a3a                	mv	s4,a4
        found = 1;
    800011f4:	4b85                	li	s7,1
    800011f6:	a83d                	j	80001234 <scheduler+0x7c>
      release(&p->lock);
    800011f8:	8526                	mv	a0,s1
    800011fa:	768040ef          	jal	80005962 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800011fe:	1f048493          	addi	s1,s1,496
    80001202:	03248563          	beq	s1,s2,8000122c <scheduler+0x74>
      acquire(&p->lock);
    80001206:	8526                	mv	a0,s1
    80001208:	6ca040ef          	jal	800058d2 <acquire>
      if(p->state == RUNNABLE) {
    8000120c:	4c9c                	lw	a5,24(s1)
    8000120e:	ff3795e3          	bne	a5,s3,800011f8 <scheduler+0x40>
        p->state = RUNNING;
    80001212:	0184ac23          	sw	s8,24(s1)
        c->proc = p;
    80001216:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    8000121a:	06048593          	addi	a1,s1,96
    8000121e:	855a                	mv	a0,s6
    80001220:	5b2000ef          	jal	800017d2 <swtch>
        c->proc = 0;
    80001224:	020a3823          	sd	zero,48(s4)
        found = 1;
    80001228:	8ade                	mv	s5,s7
    8000122a:	b7f9                	j	800011f8 <scheduler+0x40>
    if(found == 0) {
    8000122c:	000a9463          	bnez	s5,80001234 <scheduler+0x7c>
      asm volatile("wfi");
    80001230:	10500073          	wfi
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001234:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001238:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000123c:	10079073          	csrw	sstatus,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001240:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001244:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001246:	10079073          	csrw	sstatus,a5
    int found = 0;
    8000124a:	4a81                	li	s5,0
    for(p = proc; p < &proc[NPROC]; p++) {
    8000124c:	00007497          	auipc	s1,0x7
    80001250:	a8448493          	addi	s1,s1,-1404 # 80007cd0 <proc>
      if(p->state == RUNNABLE) {
    80001254:	498d                	li	s3,3
    for(p = proc; p < &proc[NPROC]; p++) {
    80001256:	0000e917          	auipc	s2,0xe
    8000125a:	67a90913          	addi	s2,s2,1658 # 8000f8d0 <tickslock>
    8000125e:	b765                	j	80001206 <scheduler+0x4e>

0000000080001260 <sched>:
{
    80001260:	7179                	addi	sp,sp,-48
    80001262:	f406                	sd	ra,40(sp)
    80001264:	f022                	sd	s0,32(sp)
    80001266:	ec26                	sd	s1,24(sp)
    80001268:	e84a                	sd	s2,16(sp)
    8000126a:	e44e                	sd	s3,8(sp)
    8000126c:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    8000126e:	ad7ff0ef          	jal	80000d44 <myproc>
    80001272:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001274:	5ee040ef          	jal	80005862 <holding>
    80001278:	c92d                	beqz	a0,800012ea <sched+0x8a>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000127a:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    8000127c:	2781                	sext.w	a5,a5
    8000127e:	079e                	slli	a5,a5,0x7
    80001280:	00006717          	auipc	a4,0x6
    80001284:	62070713          	addi	a4,a4,1568 # 800078a0 <pid_lock>
    80001288:	97ba                	add	a5,a5,a4
    8000128a:	0a87a703          	lw	a4,168(a5)
    8000128e:	4785                	li	a5,1
    80001290:	06f71363          	bne	a4,a5,800012f6 <sched+0x96>
  if(p->state == RUNNING)
    80001294:	4c98                	lw	a4,24(s1)
    80001296:	4791                	li	a5,4
    80001298:	06f70563          	beq	a4,a5,80001302 <sched+0xa2>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000129c:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800012a0:	8b89                	andi	a5,a5,2
  if(intr_get())
    800012a2:	e7b5                	bnez	a5,8000130e <sched+0xae>
  asm volatile("mv %0, tp" : "=r" (x) );
    800012a4:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    800012a6:	00006917          	auipc	s2,0x6
    800012aa:	5fa90913          	addi	s2,s2,1530 # 800078a0 <pid_lock>
    800012ae:	2781                	sext.w	a5,a5
    800012b0:	079e                	slli	a5,a5,0x7
    800012b2:	97ca                	add	a5,a5,s2
    800012b4:	0ac7a983          	lw	s3,172(a5)
    800012b8:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800012ba:	2781                	sext.w	a5,a5
    800012bc:	079e                	slli	a5,a5,0x7
    800012be:	00006597          	auipc	a1,0x6
    800012c2:	61a58593          	addi	a1,a1,1562 # 800078d8 <cpus+0x8>
    800012c6:	95be                	add	a1,a1,a5
    800012c8:	06048513          	addi	a0,s1,96
    800012cc:	506000ef          	jal	800017d2 <swtch>
    800012d0:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    800012d2:	2781                	sext.w	a5,a5
    800012d4:	079e                	slli	a5,a5,0x7
    800012d6:	993e                	add	s2,s2,a5
    800012d8:	0b392623          	sw	s3,172(s2)
}
    800012dc:	70a2                	ld	ra,40(sp)
    800012de:	7402                	ld	s0,32(sp)
    800012e0:	64e2                	ld	s1,24(sp)
    800012e2:	6942                	ld	s2,16(sp)
    800012e4:	69a2                	ld	s3,8(sp)
    800012e6:	6145                	addi	sp,sp,48
    800012e8:	8082                	ret
    panic("sched p->lock");
    800012ea:	00006517          	auipc	a0,0x6
    800012ee:	e6650513          	addi	a0,a0,-410 # 80007150 <etext+0x150>
    800012f2:	322040ef          	jal	80005614 <panic>
    panic("sched locks");
    800012f6:	00006517          	auipc	a0,0x6
    800012fa:	e6a50513          	addi	a0,a0,-406 # 80007160 <etext+0x160>
    800012fe:	316040ef          	jal	80005614 <panic>
    panic("sched RUNNING");
    80001302:	00006517          	auipc	a0,0x6
    80001306:	e6e50513          	addi	a0,a0,-402 # 80007170 <etext+0x170>
    8000130a:	30a040ef          	jal	80005614 <panic>
    panic("sched interruptible");
    8000130e:	00006517          	auipc	a0,0x6
    80001312:	e7250513          	addi	a0,a0,-398 # 80007180 <etext+0x180>
    80001316:	2fe040ef          	jal	80005614 <panic>

000000008000131a <yield>:
{
    8000131a:	1101                	addi	sp,sp,-32
    8000131c:	ec06                	sd	ra,24(sp)
    8000131e:	e822                	sd	s0,16(sp)
    80001320:	e426                	sd	s1,8(sp)
    80001322:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80001324:	a21ff0ef          	jal	80000d44 <myproc>
    80001328:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000132a:	5a8040ef          	jal	800058d2 <acquire>
  p->state = RUNNABLE;
    8000132e:	478d                	li	a5,3
    80001330:	cc9c                	sw	a5,24(s1)
  sched();
    80001332:	f2fff0ef          	jal	80001260 <sched>
  release(&p->lock);
    80001336:	8526                	mv	a0,s1
    80001338:	62a040ef          	jal	80005962 <release>
}
    8000133c:	60e2                	ld	ra,24(sp)
    8000133e:	6442                	ld	s0,16(sp)
    80001340:	64a2                	ld	s1,8(sp)
    80001342:	6105                	addi	sp,sp,32
    80001344:	8082                	ret

0000000080001346 <sleep>:

// Sleep on channel chan, releasing condition lock lk.
// Re-acquires lk when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80001346:	7179                	addi	sp,sp,-48
    80001348:	f406                	sd	ra,40(sp)
    8000134a:	f022                	sd	s0,32(sp)
    8000134c:	ec26                	sd	s1,24(sp)
    8000134e:	e84a                	sd	s2,16(sp)
    80001350:	e44e                	sd	s3,8(sp)
    80001352:	1800                	addi	s0,sp,48
    80001354:	89aa                	mv	s3,a0
    80001356:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001358:	9edff0ef          	jal	80000d44 <myproc>
    8000135c:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    8000135e:	574040ef          	jal	800058d2 <acquire>
  release(lk);
    80001362:	854a                	mv	a0,s2
    80001364:	5fe040ef          	jal	80005962 <release>

  // Go to sleep.
  p->chan = chan;
    80001368:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    8000136c:	4789                	li	a5,2
    8000136e:	cc9c                	sw	a5,24(s1)

  sched();
    80001370:	ef1ff0ef          	jal	80001260 <sched>

  // Tidy up.
  p->chan = 0;
    80001374:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    80001378:	8526                	mv	a0,s1
    8000137a:	5e8040ef          	jal	80005962 <release>
  acquire(lk);
    8000137e:	854a                	mv	a0,s2
    80001380:	552040ef          	jal	800058d2 <acquire>
}
    80001384:	70a2                	ld	ra,40(sp)
    80001386:	7402                	ld	s0,32(sp)
    80001388:	64e2                	ld	s1,24(sp)
    8000138a:	6942                	ld	s2,16(sp)
    8000138c:	69a2                	ld	s3,8(sp)
    8000138e:	6145                	addi	sp,sp,48
    80001390:	8082                	ret

0000000080001392 <wakeup>:

// Wake up all processes sleeping on channel chan.
// Caller should hold the condition lock.
void
wakeup(void *chan)
{
    80001392:	7139                	addi	sp,sp,-64
    80001394:	fc06                	sd	ra,56(sp)
    80001396:	f822                	sd	s0,48(sp)
    80001398:	f426                	sd	s1,40(sp)
    8000139a:	f04a                	sd	s2,32(sp)
    8000139c:	ec4e                	sd	s3,24(sp)
    8000139e:	e852                	sd	s4,16(sp)
    800013a0:	e456                	sd	s5,8(sp)
    800013a2:	0080                	addi	s0,sp,64
    800013a4:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800013a6:	00007497          	auipc	s1,0x7
    800013aa:	92a48493          	addi	s1,s1,-1750 # 80007cd0 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    800013ae:	4989                	li	s3,2
        p->state = RUNNABLE;
    800013b0:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    800013b2:	0000e917          	auipc	s2,0xe
    800013b6:	51e90913          	addi	s2,s2,1310 # 8000f8d0 <tickslock>
    800013ba:	a801                	j	800013ca <wakeup+0x38>
      }
      release(&p->lock);
    800013bc:	8526                	mv	a0,s1
    800013be:	5a4040ef          	jal	80005962 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800013c2:	1f048493          	addi	s1,s1,496
    800013c6:	03248263          	beq	s1,s2,800013ea <wakeup+0x58>
    if(p != myproc()){
    800013ca:	97bff0ef          	jal	80000d44 <myproc>
    800013ce:	fe950ae3          	beq	a0,s1,800013c2 <wakeup+0x30>
      acquire(&p->lock);
    800013d2:	8526                	mv	a0,s1
    800013d4:	4fe040ef          	jal	800058d2 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800013d8:	4c9c                	lw	a5,24(s1)
    800013da:	ff3791e3          	bne	a5,s3,800013bc <wakeup+0x2a>
    800013de:	709c                	ld	a5,32(s1)
    800013e0:	fd479ee3          	bne	a5,s4,800013bc <wakeup+0x2a>
        p->state = RUNNABLE;
    800013e4:	0154ac23          	sw	s5,24(s1)
    800013e8:	bfd1                	j	800013bc <wakeup+0x2a>
    }
  }
}
    800013ea:	70e2                	ld	ra,56(sp)
    800013ec:	7442                	ld	s0,48(sp)
    800013ee:	74a2                	ld	s1,40(sp)
    800013f0:	7902                	ld	s2,32(sp)
    800013f2:	69e2                	ld	s3,24(sp)
    800013f4:	6a42                	ld	s4,16(sp)
    800013f6:	6aa2                	ld	s5,8(sp)
    800013f8:	6121                	addi	sp,sp,64
    800013fa:	8082                	ret

00000000800013fc <reparent>:
{
    800013fc:	7179                	addi	sp,sp,-48
    800013fe:	f406                	sd	ra,40(sp)
    80001400:	f022                	sd	s0,32(sp)
    80001402:	ec26                	sd	s1,24(sp)
    80001404:	e84a                	sd	s2,16(sp)
    80001406:	e44e                	sd	s3,8(sp)
    80001408:	e052                	sd	s4,0(sp)
    8000140a:	1800                	addi	s0,sp,48
    8000140c:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000140e:	00007497          	auipc	s1,0x7
    80001412:	8c248493          	addi	s1,s1,-1854 # 80007cd0 <proc>
      pp->parent = initproc;
    80001416:	00006a17          	auipc	s4,0x6
    8000141a:	44aa0a13          	addi	s4,s4,1098 # 80007860 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000141e:	0000e997          	auipc	s3,0xe
    80001422:	4b298993          	addi	s3,s3,1202 # 8000f8d0 <tickslock>
    80001426:	a029                	j	80001430 <reparent+0x34>
    80001428:	1f048493          	addi	s1,s1,496
    8000142c:	01348b63          	beq	s1,s3,80001442 <reparent+0x46>
    if(pp->parent == p){
    80001430:	7c9c                	ld	a5,56(s1)
    80001432:	ff279be3          	bne	a5,s2,80001428 <reparent+0x2c>
      pp->parent = initproc;
    80001436:	000a3503          	ld	a0,0(s4)
    8000143a:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    8000143c:	f57ff0ef          	jal	80001392 <wakeup>
    80001440:	b7e5                	j	80001428 <reparent+0x2c>
}
    80001442:	70a2                	ld	ra,40(sp)
    80001444:	7402                	ld	s0,32(sp)
    80001446:	64e2                	ld	s1,24(sp)
    80001448:	6942                	ld	s2,16(sp)
    8000144a:	69a2                	ld	s3,8(sp)
    8000144c:	6a02                	ld	s4,0(sp)
    8000144e:	6145                	addi	sp,sp,48
    80001450:	8082                	ret

0000000080001452 <kexit>:
{
    80001452:	7179                	addi	sp,sp,-48
    80001454:	f406                	sd	ra,40(sp)
    80001456:	f022                	sd	s0,32(sp)
    80001458:	ec26                	sd	s1,24(sp)
    8000145a:	e84a                	sd	s2,16(sp)
    8000145c:	e44e                	sd	s3,8(sp)
    8000145e:	e052                	sd	s4,0(sp)
    80001460:	1800                	addi	s0,sp,48
    80001462:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80001464:	8e1ff0ef          	jal	80000d44 <myproc>
    80001468:	89aa                	mv	s3,a0
  if(p == initproc)
    8000146a:	00006797          	auipc	a5,0x6
    8000146e:	3f67b783          	ld	a5,1014(a5) # 80007860 <initproc>
    80001472:	0d050493          	addi	s1,a0,208
    80001476:	15050913          	addi	s2,a0,336
    8000147a:	00a79b63          	bne	a5,a0,80001490 <kexit+0x3e>
    panic("init exiting");
    8000147e:	00006517          	auipc	a0,0x6
    80001482:	d1a50513          	addi	a0,a0,-742 # 80007198 <etext+0x198>
    80001486:	18e040ef          	jal	80005614 <panic>
  for(int fd = 0; fd < NOFILE; fd++){
    8000148a:	04a1                	addi	s1,s1,8
    8000148c:	01248963          	beq	s1,s2,8000149e <kexit+0x4c>
    if(p->ofile[fd]){
    80001490:	6088                	ld	a0,0(s1)
    80001492:	dd65                	beqz	a0,8000148a <kexit+0x38>
      fileclose(f);
    80001494:	062020ef          	jal	800034f6 <fileclose>
      p->ofile[fd] = 0;
    80001498:	0004b023          	sd	zero,0(s1)
    8000149c:	b7fd                	j	8000148a <kexit+0x38>
  begin_op();
    8000149e:	439010ef          	jal	800030d6 <begin_op>
  iput(p->cwd);
    800014a2:	1509b503          	ld	a0,336(s3)
    800014a6:	39c010ef          	jal	80002842 <iput>
  end_op();
    800014aa:	49d010ef          	jal	80003146 <end_op>
  p->cwd = 0;
    800014ae:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    800014b2:	00006517          	auipc	a0,0x6
    800014b6:	40650513          	addi	a0,a0,1030 # 800078b8 <wait_lock>
    800014ba:	418040ef          	jal	800058d2 <acquire>
  reparent(p);
    800014be:	854e                	mv	a0,s3
    800014c0:	f3dff0ef          	jal	800013fc <reparent>
  wakeup(p->parent);
    800014c4:	0389b503          	ld	a0,56(s3)
    800014c8:	ecbff0ef          	jal	80001392 <wakeup>
  acquire(&p->lock);
    800014cc:	854e                	mv	a0,s3
    800014ce:	404040ef          	jal	800058d2 <acquire>
  p->xstate = status;
    800014d2:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    800014d6:	4795                	li	a5,5
    800014d8:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    800014dc:	00006517          	auipc	a0,0x6
    800014e0:	3dc50513          	addi	a0,a0,988 # 800078b8 <wait_lock>
    800014e4:	47e040ef          	jal	80005962 <release>
  sched();
    800014e8:	d79ff0ef          	jal	80001260 <sched>
  panic("zombie exit");
    800014ec:	00006517          	auipc	a0,0x6
    800014f0:	cbc50513          	addi	a0,a0,-836 # 800071a8 <etext+0x1a8>
    800014f4:	120040ef          	jal	80005614 <panic>

00000000800014f8 <kkill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kkill(int pid)
{
    800014f8:	7179                	addi	sp,sp,-48
    800014fa:	f406                	sd	ra,40(sp)
    800014fc:	f022                	sd	s0,32(sp)
    800014fe:	ec26                	sd	s1,24(sp)
    80001500:	e84a                	sd	s2,16(sp)
    80001502:	e44e                	sd	s3,8(sp)
    80001504:	1800                	addi	s0,sp,48
    80001506:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80001508:	00006497          	auipc	s1,0x6
    8000150c:	7c848493          	addi	s1,s1,1992 # 80007cd0 <proc>
    80001510:	0000e997          	auipc	s3,0xe
    80001514:	3c098993          	addi	s3,s3,960 # 8000f8d0 <tickslock>
    acquire(&p->lock);
    80001518:	8526                	mv	a0,s1
    8000151a:	3b8040ef          	jal	800058d2 <acquire>
    if(p->pid == pid){
    8000151e:	589c                	lw	a5,48(s1)
    80001520:	01278b63          	beq	a5,s2,80001536 <kkill+0x3e>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80001524:	8526                	mv	a0,s1
    80001526:	43c040ef          	jal	80005962 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    8000152a:	1f048493          	addi	s1,s1,496
    8000152e:	ff3495e3          	bne	s1,s3,80001518 <kkill+0x20>
  }
  return -1;
    80001532:	557d                	li	a0,-1
    80001534:	a819                	j	8000154a <kkill+0x52>
      p->killed = 1;
    80001536:	4785                	li	a5,1
    80001538:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    8000153a:	4c98                	lw	a4,24(s1)
    8000153c:	4789                	li	a5,2
    8000153e:	00f70d63          	beq	a4,a5,80001558 <kkill+0x60>
      release(&p->lock);
    80001542:	8526                	mv	a0,s1
    80001544:	41e040ef          	jal	80005962 <release>
      return 0;
    80001548:	4501                	li	a0,0
}
    8000154a:	70a2                	ld	ra,40(sp)
    8000154c:	7402                	ld	s0,32(sp)
    8000154e:	64e2                	ld	s1,24(sp)
    80001550:	6942                	ld	s2,16(sp)
    80001552:	69a2                	ld	s3,8(sp)
    80001554:	6145                	addi	sp,sp,48
    80001556:	8082                	ret
        p->state = RUNNABLE;
    80001558:	478d                	li	a5,3
    8000155a:	cc9c                	sw	a5,24(s1)
    8000155c:	b7dd                	j	80001542 <kkill+0x4a>

000000008000155e <setkilled>:

void
setkilled(struct proc *p)
{
    8000155e:	1101                	addi	sp,sp,-32
    80001560:	ec06                	sd	ra,24(sp)
    80001562:	e822                	sd	s0,16(sp)
    80001564:	e426                	sd	s1,8(sp)
    80001566:	1000                	addi	s0,sp,32
    80001568:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000156a:	368040ef          	jal	800058d2 <acquire>
  p->killed = 1;
    8000156e:	4785                	li	a5,1
    80001570:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    80001572:	8526                	mv	a0,s1
    80001574:	3ee040ef          	jal	80005962 <release>
}
    80001578:	60e2                	ld	ra,24(sp)
    8000157a:	6442                	ld	s0,16(sp)
    8000157c:	64a2                	ld	s1,8(sp)
    8000157e:	6105                	addi	sp,sp,32
    80001580:	8082                	ret

0000000080001582 <killed>:

int
killed(struct proc *p)
{
    80001582:	1101                	addi	sp,sp,-32
    80001584:	ec06                	sd	ra,24(sp)
    80001586:	e822                	sd	s0,16(sp)
    80001588:	e426                	sd	s1,8(sp)
    8000158a:	e04a                	sd	s2,0(sp)
    8000158c:	1000                	addi	s0,sp,32
    8000158e:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    80001590:	342040ef          	jal	800058d2 <acquire>
  k = p->killed;
    80001594:	549c                	lw	a5,40(s1)
    80001596:	893e                	mv	s2,a5
  release(&p->lock);
    80001598:	8526                	mv	a0,s1
    8000159a:	3c8040ef          	jal	80005962 <release>
  return k;
}
    8000159e:	854a                	mv	a0,s2
    800015a0:	60e2                	ld	ra,24(sp)
    800015a2:	6442                	ld	s0,16(sp)
    800015a4:	64a2                	ld	s1,8(sp)
    800015a6:	6902                	ld	s2,0(sp)
    800015a8:	6105                	addi	sp,sp,32
    800015aa:	8082                	ret

00000000800015ac <kwait>:
{
    800015ac:	715d                	addi	sp,sp,-80
    800015ae:	e486                	sd	ra,72(sp)
    800015b0:	e0a2                	sd	s0,64(sp)
    800015b2:	fc26                	sd	s1,56(sp)
    800015b4:	f84a                	sd	s2,48(sp)
    800015b6:	f44e                	sd	s3,40(sp)
    800015b8:	f052                	sd	s4,32(sp)
    800015ba:	ec56                	sd	s5,24(sp)
    800015bc:	e85a                	sd	s6,16(sp)
    800015be:	e45e                	sd	s7,8(sp)
    800015c0:	0880                	addi	s0,sp,80
    800015c2:	8baa                	mv	s7,a0
  struct proc *p = myproc();
    800015c4:	f80ff0ef          	jal	80000d44 <myproc>
    800015c8:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800015ca:	00006517          	auipc	a0,0x6
    800015ce:	2ee50513          	addi	a0,a0,750 # 800078b8 <wait_lock>
    800015d2:	300040ef          	jal	800058d2 <acquire>
        if(pp->state == ZOMBIE){
    800015d6:	4a15                	li	s4,5
        havekids = 1;
    800015d8:	4a85                	li	s5,1
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800015da:	0000e997          	auipc	s3,0xe
    800015de:	2f698993          	addi	s3,s3,758 # 8000f8d0 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800015e2:	00006b17          	auipc	s6,0x6
    800015e6:	2d6b0b13          	addi	s6,s6,726 # 800078b8 <wait_lock>
    800015ea:	a861                	j	80001682 <kwait+0xd6>
          pid = pp->pid;
    800015ec:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    800015f0:	000b8c63          	beqz	s7,80001608 <kwait+0x5c>
    800015f4:	4691                	li	a3,4
    800015f6:	02c48613          	addi	a2,s1,44
    800015fa:	85de                	mv	a1,s7
    800015fc:	05093503          	ld	a0,80(s2)
    80001600:	c8aff0ef          	jal	80000a8a <copyout>
    80001604:	02054a63          	bltz	a0,80001638 <kwait+0x8c>
          freeproc(pp);
    80001608:	8526                	mv	a0,s1
    8000160a:	90dff0ef          	jal	80000f16 <freeproc>
          release(&pp->lock);
    8000160e:	8526                	mv	a0,s1
    80001610:	352040ef          	jal	80005962 <release>
          release(&wait_lock);
    80001614:	00006517          	auipc	a0,0x6
    80001618:	2a450513          	addi	a0,a0,676 # 800078b8 <wait_lock>
    8000161c:	346040ef          	jal	80005962 <release>
}
    80001620:	854e                	mv	a0,s3
    80001622:	60a6                	ld	ra,72(sp)
    80001624:	6406                	ld	s0,64(sp)
    80001626:	74e2                	ld	s1,56(sp)
    80001628:	7942                	ld	s2,48(sp)
    8000162a:	79a2                	ld	s3,40(sp)
    8000162c:	7a02                	ld	s4,32(sp)
    8000162e:	6ae2                	ld	s5,24(sp)
    80001630:	6b42                	ld	s6,16(sp)
    80001632:	6ba2                	ld	s7,8(sp)
    80001634:	6161                	addi	sp,sp,80
    80001636:	8082                	ret
            release(&pp->lock);
    80001638:	8526                	mv	a0,s1
    8000163a:	328040ef          	jal	80005962 <release>
            release(&wait_lock);
    8000163e:	00006517          	auipc	a0,0x6
    80001642:	27a50513          	addi	a0,a0,634 # 800078b8 <wait_lock>
    80001646:	31c040ef          	jal	80005962 <release>
            return -1;
    8000164a:	a881                	j	8000169a <kwait+0xee>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000164c:	1f048493          	addi	s1,s1,496
    80001650:	03348063          	beq	s1,s3,80001670 <kwait+0xc4>
      if(pp->parent == p){
    80001654:	7c9c                	ld	a5,56(s1)
    80001656:	ff279be3          	bne	a5,s2,8000164c <kwait+0xa0>
        acquire(&pp->lock);
    8000165a:	8526                	mv	a0,s1
    8000165c:	276040ef          	jal	800058d2 <acquire>
        if(pp->state == ZOMBIE){
    80001660:	4c9c                	lw	a5,24(s1)
    80001662:	f94785e3          	beq	a5,s4,800015ec <kwait+0x40>
        release(&pp->lock);
    80001666:	8526                	mv	a0,s1
    80001668:	2fa040ef          	jal	80005962 <release>
        havekids = 1;
    8000166c:	8756                	mv	a4,s5
    8000166e:	bff9                	j	8000164c <kwait+0xa0>
    if(!havekids || killed(p)){
    80001670:	cf19                	beqz	a4,8000168e <kwait+0xe2>
    80001672:	854a                	mv	a0,s2
    80001674:	f0fff0ef          	jal	80001582 <killed>
    80001678:	e919                	bnez	a0,8000168e <kwait+0xe2>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000167a:	85da                	mv	a1,s6
    8000167c:	854a                	mv	a0,s2
    8000167e:	cc9ff0ef          	jal	80001346 <sleep>
    havekids = 0;
    80001682:	4701                	li	a4,0
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001684:	00006497          	auipc	s1,0x6
    80001688:	64c48493          	addi	s1,s1,1612 # 80007cd0 <proc>
    8000168c:	b7e1                	j	80001654 <kwait+0xa8>
      release(&wait_lock);
    8000168e:	00006517          	auipc	a0,0x6
    80001692:	22a50513          	addi	a0,a0,554 # 800078b8 <wait_lock>
    80001696:	2cc040ef          	jal	80005962 <release>
            return -1;
    8000169a:	59fd                	li	s3,-1
    8000169c:	b751                	j	80001620 <kwait+0x74>

000000008000169e <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    8000169e:	7179                	addi	sp,sp,-48
    800016a0:	f406                	sd	ra,40(sp)
    800016a2:	f022                	sd	s0,32(sp)
    800016a4:	ec26                	sd	s1,24(sp)
    800016a6:	e84a                	sd	s2,16(sp)
    800016a8:	e44e                	sd	s3,8(sp)
    800016aa:	e052                	sd	s4,0(sp)
    800016ac:	1800                	addi	s0,sp,48
    800016ae:	84aa                	mv	s1,a0
    800016b0:	8a2e                	mv	s4,a1
    800016b2:	89b2                	mv	s3,a2
    800016b4:	8936                	mv	s2,a3
  struct proc *p = myproc();
    800016b6:	e8eff0ef          	jal	80000d44 <myproc>
  if(user_dst){
    800016ba:	cc99                	beqz	s1,800016d8 <either_copyout+0x3a>
    return copyout(p->pagetable, dst, src, len);
    800016bc:	86ca                	mv	a3,s2
    800016be:	864e                	mv	a2,s3
    800016c0:	85d2                	mv	a1,s4
    800016c2:	6928                	ld	a0,80(a0)
    800016c4:	bc6ff0ef          	jal	80000a8a <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800016c8:	70a2                	ld	ra,40(sp)
    800016ca:	7402                	ld	s0,32(sp)
    800016cc:	64e2                	ld	s1,24(sp)
    800016ce:	6942                	ld	s2,16(sp)
    800016d0:	69a2                	ld	s3,8(sp)
    800016d2:	6a02                	ld	s4,0(sp)
    800016d4:	6145                	addi	sp,sp,48
    800016d6:	8082                	ret
    memmove((char *)dst, src, len);
    800016d8:	0009061b          	sext.w	a2,s2
    800016dc:	85ce                	mv	a1,s3
    800016de:	8552                	mv	a0,s4
    800016e0:	abbfe0ef          	jal	8000019a <memmove>
    return 0;
    800016e4:	8526                	mv	a0,s1
    800016e6:	b7cd                	j	800016c8 <either_copyout+0x2a>

00000000800016e8 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800016e8:	7179                	addi	sp,sp,-48
    800016ea:	f406                	sd	ra,40(sp)
    800016ec:	f022                	sd	s0,32(sp)
    800016ee:	ec26                	sd	s1,24(sp)
    800016f0:	e84a                	sd	s2,16(sp)
    800016f2:	e44e                	sd	s3,8(sp)
    800016f4:	e052                	sd	s4,0(sp)
    800016f6:	1800                	addi	s0,sp,48
    800016f8:	8a2a                	mv	s4,a0
    800016fa:	84ae                	mv	s1,a1
    800016fc:	89b2                	mv	s3,a2
    800016fe:	8936                	mv	s2,a3
  struct proc *p = myproc();
    80001700:	e44ff0ef          	jal	80000d44 <myproc>
  if(user_src){
    80001704:	cc99                	beqz	s1,80001722 <either_copyin+0x3a>
    return copyin(p->pagetable, dst, src, len);
    80001706:	86ca                	mv	a3,s2
    80001708:	864e                	mv	a2,s3
    8000170a:	85d2                	mv	a1,s4
    8000170c:	6928                	ld	a0,80(a0)
    8000170e:	c36ff0ef          	jal	80000b44 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001712:	70a2                	ld	ra,40(sp)
    80001714:	7402                	ld	s0,32(sp)
    80001716:	64e2                	ld	s1,24(sp)
    80001718:	6942                	ld	s2,16(sp)
    8000171a:	69a2                	ld	s3,8(sp)
    8000171c:	6a02                	ld	s4,0(sp)
    8000171e:	6145                	addi	sp,sp,48
    80001720:	8082                	ret
    memmove(dst, (char*)src, len);
    80001722:	0009061b          	sext.w	a2,s2
    80001726:	85ce                	mv	a1,s3
    80001728:	8552                	mv	a0,s4
    8000172a:	a71fe0ef          	jal	8000019a <memmove>
    return 0;
    8000172e:	8526                	mv	a0,s1
    80001730:	b7cd                	j	80001712 <either_copyin+0x2a>

0000000080001732 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001732:	715d                	addi	sp,sp,-80
    80001734:	e486                	sd	ra,72(sp)
    80001736:	e0a2                	sd	s0,64(sp)
    80001738:	fc26                	sd	s1,56(sp)
    8000173a:	f84a                	sd	s2,48(sp)
    8000173c:	f44e                	sd	s3,40(sp)
    8000173e:	f052                	sd	s4,32(sp)
    80001740:	ec56                	sd	s5,24(sp)
    80001742:	e85a                	sd	s6,16(sp)
    80001744:	e45e                	sd	s7,8(sp)
    80001746:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001748:	00006517          	auipc	a0,0x6
    8000174c:	8d050513          	addi	a0,a0,-1840 # 80007018 <etext+0x18>
    80001750:	38d030ef          	jal	800052dc <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001754:	00006497          	auipc	s1,0x6
    80001758:	6d448493          	addi	s1,s1,1748 # 80007e28 <proc+0x158>
    8000175c:	0000e917          	auipc	s2,0xe
    80001760:	2cc90913          	addi	s2,s2,716 # 8000fa28 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001764:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001766:	00006a97          	auipc	s5,0x6
    8000176a:	a52a8a93          	addi	s5,s5,-1454 # 800071b8 <etext+0x1b8>
    printf("%d %s %s", p->pid, state, p->name);
    8000176e:	00006a17          	auipc	s4,0x6
    80001772:	a52a0a13          	addi	s4,s4,-1454 # 800071c0 <etext+0x1c0>
    printf("\n");
    80001776:	00006997          	auipc	s3,0x6
    8000177a:	8a298993          	addi	s3,s3,-1886 # 80007018 <etext+0x18>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000177e:	00006b97          	auipc	s7,0x6
    80001782:	faab8b93          	addi	s7,s7,-86 # 80007728 <states.0>
    80001786:	a829                	j	800017a0 <procdump+0x6e>
    printf("%d %s %s", p->pid, state, p->name);
    80001788:	ed86a583          	lw	a1,-296(a3)
    8000178c:	8552                	mv	a0,s4
    8000178e:	34f030ef          	jal	800052dc <printf>
    printf("\n");
    80001792:	854e                	mv	a0,s3
    80001794:	349030ef          	jal	800052dc <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001798:	1f048493          	addi	s1,s1,496
    8000179c:	03248063          	beq	s1,s2,800017bc <procdump+0x8a>
    if(p->state == UNUSED)
    800017a0:	86a6                	mv	a3,s1
    800017a2:	ec04a783          	lw	a5,-320(s1)
    800017a6:	dbed                	beqz	a5,80001798 <procdump+0x66>
      state = "???";
    800017a8:	8656                	mv	a2,s5
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800017aa:	fcfb6fe3          	bltu	s6,a5,80001788 <procdump+0x56>
    800017ae:	02079713          	slli	a4,a5,0x20
    800017b2:	01d75793          	srli	a5,a4,0x1d
    800017b6:	97de                	add	a5,a5,s7
    800017b8:	6390                	ld	a2,0(a5)
      state = states[p->state];
    800017ba:	b7f9                	j	80001788 <procdump+0x56>
  }
}
    800017bc:	60a6                	ld	ra,72(sp)
    800017be:	6406                	ld	s0,64(sp)
    800017c0:	74e2                	ld	s1,56(sp)
    800017c2:	7942                	ld	s2,48(sp)
    800017c4:	79a2                	ld	s3,40(sp)
    800017c6:	7a02                	ld	s4,32(sp)
    800017c8:	6ae2                	ld	s5,24(sp)
    800017ca:	6b42                	ld	s6,16(sp)
    800017cc:	6ba2                	ld	s7,8(sp)
    800017ce:	6161                	addi	sp,sp,80
    800017d0:	8082                	ret

00000000800017d2 <swtch>:
# Save current registers in old. Load from new.	


.globl swtch
swtch:
        sd ra, 0(a0)
    800017d2:	00153023          	sd	ra,0(a0)
        sd sp, 8(a0)
    800017d6:	00253423          	sd	sp,8(a0)
        sd s0, 16(a0)
    800017da:	e900                	sd	s0,16(a0)
        sd s1, 24(a0)
    800017dc:	ed04                	sd	s1,24(a0)
        sd s2, 32(a0)
    800017de:	03253023          	sd	s2,32(a0)
        sd s3, 40(a0)
    800017e2:	03353423          	sd	s3,40(a0)
        sd s4, 48(a0)
    800017e6:	03453823          	sd	s4,48(a0)
        sd s5, 56(a0)
    800017ea:	03553c23          	sd	s5,56(a0)
        sd s6, 64(a0)
    800017ee:	05653023          	sd	s6,64(a0)
        sd s7, 72(a0)
    800017f2:	05753423          	sd	s7,72(a0)
        sd s8, 80(a0)
    800017f6:	05853823          	sd	s8,80(a0)
        sd s9, 88(a0)
    800017fa:	05953c23          	sd	s9,88(a0)
        sd s10, 96(a0)
    800017fe:	07a53023          	sd	s10,96(a0)
        sd s11, 104(a0)
    80001802:	07b53423          	sd	s11,104(a0)

        ld ra, 0(a1)
    80001806:	0005b083          	ld	ra,0(a1)
        ld sp, 8(a1)
    8000180a:	0085b103          	ld	sp,8(a1)
        ld s0, 16(a1)
    8000180e:	6980                	ld	s0,16(a1)
        ld s1, 24(a1)
    80001810:	6d84                	ld	s1,24(a1)
        ld s2, 32(a1)
    80001812:	0205b903          	ld	s2,32(a1)
        ld s3, 40(a1)
    80001816:	0285b983          	ld	s3,40(a1)
        ld s4, 48(a1)
    8000181a:	0305ba03          	ld	s4,48(a1)
        ld s5, 56(a1)
    8000181e:	0385ba83          	ld	s5,56(a1)
        ld s6, 64(a1)
    80001822:	0405bb03          	ld	s6,64(a1)
        ld s7, 72(a1)
    80001826:	0485bb83          	ld	s7,72(a1)
        ld s8, 80(a1)
    8000182a:	0505bc03          	ld	s8,80(a1)
        ld s9, 88(a1)
    8000182e:	0585bc83          	ld	s9,88(a1)
        ld s10, 96(a1)
    80001832:	0605bd03          	ld	s10,96(a1)
        ld s11, 104(a1)
    80001836:	0685bd83          	ld	s11,104(a1)
        
        ret
    8000183a:	8082                	ret

000000008000183c <trapinit>:

extern int devintr();

void
trapinit(void)
{
    8000183c:	1141                	addi	sp,sp,-16
    8000183e:	e406                	sd	ra,8(sp)
    80001840:	e022                	sd	s0,0(sp)
    80001842:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001844:	00006597          	auipc	a1,0x6
    80001848:	9bc58593          	addi	a1,a1,-1604 # 80007200 <etext+0x200>
    8000184c:	0000e517          	auipc	a0,0xe
    80001850:	08450513          	addi	a0,a0,132 # 8000f8d0 <tickslock>
    80001854:	7f5030ef          	jal	80005848 <initlock>
}
    80001858:	60a2                	ld	ra,8(sp)
    8000185a:	6402                	ld	s0,0(sp)
    8000185c:	0141                	addi	sp,sp,16
    8000185e:	8082                	ret

0000000080001860 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001860:	1141                	addi	sp,sp,-16
    80001862:	e406                	sd	ra,8(sp)
    80001864:	e022                	sd	s0,0(sp)
    80001866:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001868:	00003797          	auipc	a5,0x3
    8000186c:	fb878793          	addi	a5,a5,-72 # 80004820 <kernelvec>
    80001870:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001874:	60a2                	ld	ra,8(sp)
    80001876:	6402                	ld	s0,0(sp)
    80001878:	0141                	addi	sp,sp,16
    8000187a:	8082                	ret

000000008000187c <prepare_return>:
//
// set up trapframe and control registers for a return to user space
//
void
prepare_return(void)
{
    8000187c:	1141                	addi	sp,sp,-16
    8000187e:	e406                	sd	ra,8(sp)
    80001880:	e022                	sd	s0,0(sp)
    80001882:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001884:	cc0ff0ef          	jal	80000d44 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001888:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    8000188c:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000188e:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(). because a trap from kernel
  // code to usertrap would be a disaster, turn off interrupts.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80001892:	04000737          	lui	a4,0x4000
    80001896:	177d                	addi	a4,a4,-1 # 3ffffff <_entry-0x7c000001>
    80001898:	0732                	slli	a4,a4,0xc
    8000189a:	00004797          	auipc	a5,0x4
    8000189e:	76678793          	addi	a5,a5,1894 # 80006000 <_trampoline>
    800018a2:	00004697          	auipc	a3,0x4
    800018a6:	75e68693          	addi	a3,a3,1886 # 80006000 <_trampoline>
    800018aa:	8f95                	sub	a5,a5,a3
    800018ac:	97ba                	add	a5,a5,a4
  asm volatile("csrw stvec, %0" : : "r" (x));
    800018ae:	10579073          	csrw	stvec,a5
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    800018b2:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    800018b4:	18002773          	csrr	a4,satp
    800018b8:	e398                	sd	a4,0(a5)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    800018ba:	6d38                	ld	a4,88(a0)
    800018bc:	613c                	ld	a5,64(a0)
    800018be:	6685                	lui	a3,0x1
    800018c0:	97b6                	add	a5,a5,a3
    800018c2:	e71c                	sd	a5,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    800018c4:	6d3c                	ld	a5,88(a0)
    800018c6:	00000717          	auipc	a4,0x0
    800018ca:	0f470713          	addi	a4,a4,244 # 800019ba <usertrap>
    800018ce:	eb98                	sd	a4,16(a5)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    800018d0:	6d3c                	ld	a5,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    800018d2:	8712                	mv	a4,tp
    800018d4:	f398                	sd	a4,32(a5)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800018d6:	100027f3          	csrr	a5,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800018da:	eff7f793          	andi	a5,a5,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800018de:	0207e793          	ori	a5,a5,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800018e2:	10079073          	csrw	sstatus,a5
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    800018e6:	6d3c                	ld	a5,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    800018e8:	6f9c                	ld	a5,24(a5)
    800018ea:	14179073          	csrw	sepc,a5
}
    800018ee:	60a2                	ld	ra,8(sp)
    800018f0:	6402                	ld	s0,0(sp)
    800018f2:	0141                	addi	sp,sp,16
    800018f4:	8082                	ret

00000000800018f6 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    800018f6:	1141                	addi	sp,sp,-16
    800018f8:	e406                	sd	ra,8(sp)
    800018fa:	e022                	sd	s0,0(sp)
    800018fc:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    800018fe:	c12ff0ef          	jal	80000d10 <cpuid>
    80001902:	cd11                	beqz	a0,8000191e <clockintr+0x28>
  asm volatile("csrr %0, time" : "=r" (x) );
    80001904:	c01027f3          	rdtime	a5
  }

  // ask for the next timer interrupt. this also clears
  // the interrupt request. 1000000 is about a tenth
  // of a second.
  w_stimecmp(r_time() + 1000000);
    80001908:	000f4737          	lui	a4,0xf4
    8000190c:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    80001910:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    80001912:	14d79073          	csrw	stimecmp,a5
}
    80001916:	60a2                	ld	ra,8(sp)
    80001918:	6402                	ld	s0,0(sp)
    8000191a:	0141                	addi	sp,sp,16
    8000191c:	8082                	ret
    acquire(&tickslock);
    8000191e:	0000e517          	auipc	a0,0xe
    80001922:	fb250513          	addi	a0,a0,-78 # 8000f8d0 <tickslock>
    80001926:	7ad030ef          	jal	800058d2 <acquire>
    ticks++;
    8000192a:	00006717          	auipc	a4,0x6
    8000192e:	f3e70713          	addi	a4,a4,-194 # 80007868 <ticks>
    80001932:	431c                	lw	a5,0(a4)
    80001934:	2785                	addiw	a5,a5,1
    80001936:	c31c                	sw	a5,0(a4)
    wakeup(&ticks);
    80001938:	853a                	mv	a0,a4
    8000193a:	a59ff0ef          	jal	80001392 <wakeup>
    release(&tickslock);
    8000193e:	0000e517          	auipc	a0,0xe
    80001942:	f9250513          	addi	a0,a0,-110 # 8000f8d0 <tickslock>
    80001946:	01c040ef          	jal	80005962 <release>
    8000194a:	bf6d                	j	80001904 <clockintr+0xe>

000000008000194c <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    8000194c:	1101                	addi	sp,sp,-32
    8000194e:	ec06                	sd	ra,24(sp)
    80001950:	e822                	sd	s0,16(sp)
    80001952:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001954:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if(scause == 0x8000000000000009L){
    80001958:	57fd                	li	a5,-1
    8000195a:	17fe                	slli	a5,a5,0x3f
    8000195c:	07a5                	addi	a5,a5,9
    8000195e:	00f70c63          	beq	a4,a5,80001976 <devintr+0x2a>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000005L){
    80001962:	57fd                	li	a5,-1
    80001964:	17fe                	slli	a5,a5,0x3f
    80001966:	0795                	addi	a5,a5,5
    // timer interrupt.
    clockintr();
    return 2;
  } else {
    return 0;
    80001968:	4501                	li	a0,0
  } else if(scause == 0x8000000000000005L){
    8000196a:	04f70463          	beq	a4,a5,800019b2 <devintr+0x66>
  }
}
    8000196e:	60e2                	ld	ra,24(sp)
    80001970:	6442                	ld	s0,16(sp)
    80001972:	6105                	addi	sp,sp,32
    80001974:	8082                	ret
    80001976:	e426                	sd	s1,8(sp)
    int irq = plic_claim();
    80001978:	755020ef          	jal	800048cc <plic_claim>
    8000197c:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    8000197e:	47a9                	li	a5,10
    80001980:	02f50363          	beq	a0,a5,800019a6 <devintr+0x5a>
    } else if(irq == VIRTIO0_IRQ){
    80001984:	4785                	li	a5,1
    80001986:	02f50363          	beq	a0,a5,800019ac <devintr+0x60>
    } else if(irq){
    8000198a:	c919                	beqz	a0,800019a0 <devintr+0x54>
      printf("unexpected interrupt irq=%d\n", irq);
    8000198c:	85aa                	mv	a1,a0
    8000198e:	00006517          	auipc	a0,0x6
    80001992:	87a50513          	addi	a0,a0,-1926 # 80007208 <etext+0x208>
    80001996:	147030ef          	jal	800052dc <printf>
      plic_complete(irq);
    8000199a:	8526                	mv	a0,s1
    8000199c:	751020ef          	jal	800048ec <plic_complete>
    return 1;
    800019a0:	4505                	li	a0,1
    800019a2:	64a2                	ld	s1,8(sp)
    800019a4:	b7e9                	j	8000196e <devintr+0x22>
      uartintr();
    800019a6:	63b030ef          	jal	800057e0 <uartintr>
    if(irq)
    800019aa:	bfc5                	j	8000199a <devintr+0x4e>
      virtio_disk_intr();
    800019ac:	3a4030ef          	jal	80004d50 <virtio_disk_intr>
    if(irq)
    800019b0:	b7ed                	j	8000199a <devintr+0x4e>
    clockintr();
    800019b2:	f45ff0ef          	jal	800018f6 <clockintr>
    return 2;
    800019b6:	4509                	li	a0,2
    800019b8:	bf5d                	j	8000196e <devintr+0x22>

00000000800019ba <usertrap>:
{
    800019ba:	1101                	addi	sp,sp,-32
    800019bc:	ec06                	sd	ra,24(sp)
    800019be:	e822                	sd	s0,16(sp)
    800019c0:	e426                	sd	s1,8(sp)
    800019c2:	e04a                	sd	s2,0(sp)
    800019c4:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800019c6:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    800019ca:	1007f793          	andi	a5,a5,256
    800019ce:	eba5                	bnez	a5,80001a3e <usertrap+0x84>
  asm volatile("csrw stvec, %0" : : "r" (x));
    800019d0:	00003797          	auipc	a5,0x3
    800019d4:	e5078793          	addi	a5,a5,-432 # 80004820 <kernelvec>
    800019d8:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    800019dc:	b68ff0ef          	jal	80000d44 <myproc>
    800019e0:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    800019e2:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800019e4:	14102773          	csrr	a4,sepc
    800019e8:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    800019ea:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    800019ee:	47a1                	li	a5,8
    800019f0:	04f70d63          	beq	a4,a5,80001a4a <usertrap+0x90>
  } else if((which_dev = devintr()) != 0){
    800019f4:	f59ff0ef          	jal	8000194c <devintr>
    800019f8:	892a                	mv	s2,a0
    800019fa:	e945                	bnez	a0,80001aaa <usertrap+0xf0>
    800019fc:	14202773          	csrr	a4,scause
  } else if((r_scause() == 15 || r_scause() == 13) &&
    80001a00:	47bd                	li	a5,15
    80001a02:	08f70863          	beq	a4,a5,80001a92 <usertrap+0xd8>
    80001a06:	14202773          	csrr	a4,scause
    80001a0a:	47b5                	li	a5,13
    80001a0c:	08f70363          	beq	a4,a5,80001a92 <usertrap+0xd8>
    80001a10:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause 0x%lx pid=%d\n", r_scause(), p->pid);
    80001a14:	5890                	lw	a2,48(s1)
    80001a16:	00006517          	auipc	a0,0x6
    80001a1a:	83250513          	addi	a0,a0,-1998 # 80007248 <etext+0x248>
    80001a1e:	0bf030ef          	jal	800052dc <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001a22:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001a26:	14302673          	csrr	a2,stval
    printf("            sepc=0x%lx stval=0x%lx\n", r_sepc(), r_stval());
    80001a2a:	00006517          	auipc	a0,0x6
    80001a2e:	84e50513          	addi	a0,a0,-1970 # 80007278 <etext+0x278>
    80001a32:	0ab030ef          	jal	800052dc <printf>
    setkilled(p);
    80001a36:	8526                	mv	a0,s1
    80001a38:	b27ff0ef          	jal	8000155e <setkilled>
    80001a3c:	a035                	j	80001a68 <usertrap+0xae>
    panic("usertrap: not from user mode");
    80001a3e:	00005517          	auipc	a0,0x5
    80001a42:	7ea50513          	addi	a0,a0,2026 # 80007228 <etext+0x228>
    80001a46:	3cf030ef          	jal	80005614 <panic>
    if(killed(p))
    80001a4a:	b39ff0ef          	jal	80001582 <killed>
    80001a4e:	ed15                	bnez	a0,80001a8a <usertrap+0xd0>
    p->trapframe->epc += 4;
    80001a50:	6cb8                	ld	a4,88(s1)
    80001a52:	6f1c                	ld	a5,24(a4)
    80001a54:	0791                	addi	a5,a5,4
    80001a56:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001a58:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001a5c:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001a60:	10079073          	csrw	sstatus,a5
    syscall();
    80001a64:	23c000ef          	jal	80001ca0 <syscall>
  if(killed(p))
    80001a68:	8526                	mv	a0,s1
    80001a6a:	b19ff0ef          	jal	80001582 <killed>
    80001a6e:	e139                	bnez	a0,80001ab4 <usertrap+0xfa>
  prepare_return();
    80001a70:	e0dff0ef          	jal	8000187c <prepare_return>
  uint64 satp = MAKE_SATP(p->pagetable);
    80001a74:	68a8                	ld	a0,80(s1)
    80001a76:	8131                	srli	a0,a0,0xc
    80001a78:	57fd                	li	a5,-1
    80001a7a:	17fe                	slli	a5,a5,0x3f
    80001a7c:	8d5d                	or	a0,a0,a5
}
    80001a7e:	60e2                	ld	ra,24(sp)
    80001a80:	6442                	ld	s0,16(sp)
    80001a82:	64a2                	ld	s1,8(sp)
    80001a84:	6902                	ld	s2,0(sp)
    80001a86:	6105                	addi	sp,sp,32
    80001a88:	8082                	ret
      kexit(-1);
    80001a8a:	557d                	li	a0,-1
    80001a8c:	9c7ff0ef          	jal	80001452 <kexit>
    80001a90:	b7c1                	j	80001a50 <usertrap+0x96>
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001a92:	143025f3          	csrr	a1,stval
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001a96:	14202673          	csrr	a2,scause
            vmfault(p->pagetable, r_stval(), (r_scause() == 13)? 1 : 0) != 0) {
    80001a9a:	164d                	addi	a2,a2,-13 # ff3 <_entry-0x7ffff00d>
    80001a9c:	00163613          	seqz	a2,a2
    80001aa0:	68a8                	ld	a0,80(s1)
    80001aa2:	f69fe0ef          	jal	80000a0a <vmfault>
  } else if((r_scause() == 15 || r_scause() == 13) &&
    80001aa6:	f169                	bnez	a0,80001a68 <usertrap+0xae>
    80001aa8:	b7a5                	j	80001a10 <usertrap+0x56>
  if(killed(p))
    80001aaa:	8526                	mv	a0,s1
    80001aac:	ad7ff0ef          	jal	80001582 <killed>
    80001ab0:	c511                	beqz	a0,80001abc <usertrap+0x102>
    80001ab2:	a011                	j	80001ab6 <usertrap+0xfc>
    80001ab4:	4901                	li	s2,0
    kexit(-1);
    80001ab6:	557d                	li	a0,-1
    80001ab8:	99bff0ef          	jal	80001452 <kexit>
  if(which_dev == 2)
    80001abc:	4789                	li	a5,2
    80001abe:	faf919e3          	bne	s2,a5,80001a70 <usertrap+0xb6>
    yield();
    80001ac2:	859ff0ef          	jal	8000131a <yield>
    80001ac6:	b76d                	j	80001a70 <usertrap+0xb6>

0000000080001ac8 <kerneltrap>:
{
    80001ac8:	7179                	addi	sp,sp,-48
    80001aca:	f406                	sd	ra,40(sp)
    80001acc:	f022                	sd	s0,32(sp)
    80001ace:	ec26                	sd	s1,24(sp)
    80001ad0:	e84a                	sd	s2,16(sp)
    80001ad2:	e44e                	sd	s3,8(sp)
    80001ad4:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001ad6:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001ada:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001ade:	142027f3          	csrr	a5,scause
    80001ae2:	89be                	mv	s3,a5
  if((sstatus & SSTATUS_SPP) == 0)
    80001ae4:	1004f793          	andi	a5,s1,256
    80001ae8:	c795                	beqz	a5,80001b14 <kerneltrap+0x4c>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001aea:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001aee:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001af0:	eb85                	bnez	a5,80001b20 <kerneltrap+0x58>
  if((which_dev = devintr()) == 0){
    80001af2:	e5bff0ef          	jal	8000194c <devintr>
    80001af6:	c91d                	beqz	a0,80001b2c <kerneltrap+0x64>
  if(which_dev == 2 && myproc() != 0)
    80001af8:	4789                	li	a5,2
    80001afa:	04f50a63          	beq	a0,a5,80001b4e <kerneltrap+0x86>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001afe:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b02:	10049073          	csrw	sstatus,s1
}
    80001b06:	70a2                	ld	ra,40(sp)
    80001b08:	7402                	ld	s0,32(sp)
    80001b0a:	64e2                	ld	s1,24(sp)
    80001b0c:	6942                	ld	s2,16(sp)
    80001b0e:	69a2                	ld	s3,8(sp)
    80001b10:	6145                	addi	sp,sp,48
    80001b12:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001b14:	00005517          	auipc	a0,0x5
    80001b18:	78c50513          	addi	a0,a0,1932 # 800072a0 <etext+0x2a0>
    80001b1c:	2f9030ef          	jal	80005614 <panic>
    panic("kerneltrap: interrupts enabled");
    80001b20:	00005517          	auipc	a0,0x5
    80001b24:	7a850513          	addi	a0,a0,1960 # 800072c8 <etext+0x2c8>
    80001b28:	2ed030ef          	jal	80005614 <panic>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001b2c:	14102673          	csrr	a2,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001b30:	143026f3          	csrr	a3,stval
    printf("scause=0x%lx sepc=0x%lx stval=0x%lx\n", scause, r_sepc(), r_stval());
    80001b34:	85ce                	mv	a1,s3
    80001b36:	00005517          	auipc	a0,0x5
    80001b3a:	7b250513          	addi	a0,a0,1970 # 800072e8 <etext+0x2e8>
    80001b3e:	79e030ef          	jal	800052dc <printf>
    panic("kerneltrap");
    80001b42:	00005517          	auipc	a0,0x5
    80001b46:	7ce50513          	addi	a0,a0,1998 # 80007310 <etext+0x310>
    80001b4a:	2cb030ef          	jal	80005614 <panic>
  if(which_dev == 2 && myproc() != 0)
    80001b4e:	9f6ff0ef          	jal	80000d44 <myproc>
    80001b52:	d555                	beqz	a0,80001afe <kerneltrap+0x36>
    yield();
    80001b54:	fc6ff0ef          	jal	8000131a <yield>
    80001b58:	b75d                	j	80001afe <kerneltrap+0x36>

0000000080001b5a <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001b5a:	1101                	addi	sp,sp,-32
    80001b5c:	ec06                	sd	ra,24(sp)
    80001b5e:	e822                	sd	s0,16(sp)
    80001b60:	e426                	sd	s1,8(sp)
    80001b62:	1000                	addi	s0,sp,32
    80001b64:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001b66:	9deff0ef          	jal	80000d44 <myproc>
  switch (n) {
    80001b6a:	4795                	li	a5,5
    80001b6c:	0497e163          	bltu	a5,s1,80001bae <argraw+0x54>
    80001b70:	048a                	slli	s1,s1,0x2
    80001b72:	00006717          	auipc	a4,0x6
    80001b76:	be670713          	addi	a4,a4,-1050 # 80007758 <states.0+0x30>
    80001b7a:	94ba                	add	s1,s1,a4
    80001b7c:	409c                	lw	a5,0(s1)
    80001b7e:	97ba                	add	a5,a5,a4
    80001b80:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001b82:	6d3c                	ld	a5,88(a0)
    80001b84:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001b86:	60e2                	ld	ra,24(sp)
    80001b88:	6442                	ld	s0,16(sp)
    80001b8a:	64a2                	ld	s1,8(sp)
    80001b8c:	6105                	addi	sp,sp,32
    80001b8e:	8082                	ret
    return p->trapframe->a1;
    80001b90:	6d3c                	ld	a5,88(a0)
    80001b92:	7fa8                	ld	a0,120(a5)
    80001b94:	bfcd                	j	80001b86 <argraw+0x2c>
    return p->trapframe->a2;
    80001b96:	6d3c                	ld	a5,88(a0)
    80001b98:	63c8                	ld	a0,128(a5)
    80001b9a:	b7f5                	j	80001b86 <argraw+0x2c>
    return p->trapframe->a3;
    80001b9c:	6d3c                	ld	a5,88(a0)
    80001b9e:	67c8                	ld	a0,136(a5)
    80001ba0:	b7dd                	j	80001b86 <argraw+0x2c>
    return p->trapframe->a4;
    80001ba2:	6d3c                	ld	a5,88(a0)
    80001ba4:	6bc8                	ld	a0,144(a5)
    80001ba6:	b7c5                	j	80001b86 <argraw+0x2c>
    return p->trapframe->a5;
    80001ba8:	6d3c                	ld	a5,88(a0)
    80001baa:	6fc8                	ld	a0,152(a5)
    80001bac:	bfe9                	j	80001b86 <argraw+0x2c>
  panic("argraw");
    80001bae:	00005517          	auipc	a0,0x5
    80001bb2:	77250513          	addi	a0,a0,1906 # 80007320 <etext+0x320>
    80001bb6:	25f030ef          	jal	80005614 <panic>

0000000080001bba <fetchaddr>:
{
    80001bba:	1101                	addi	sp,sp,-32
    80001bbc:	ec06                	sd	ra,24(sp)
    80001bbe:	e822                	sd	s0,16(sp)
    80001bc0:	e426                	sd	s1,8(sp)
    80001bc2:	e04a                	sd	s2,0(sp)
    80001bc4:	1000                	addi	s0,sp,32
    80001bc6:	84aa                	mv	s1,a0
    80001bc8:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001bca:	97aff0ef          	jal	80000d44 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80001bce:	653c                	ld	a5,72(a0)
    80001bd0:	02f4f663          	bgeu	s1,a5,80001bfc <fetchaddr+0x42>
    80001bd4:	00848713          	addi	a4,s1,8
    80001bd8:	02e7e263          	bltu	a5,a4,80001bfc <fetchaddr+0x42>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001bdc:	46a1                	li	a3,8
    80001bde:	8626                	mv	a2,s1
    80001be0:	85ca                	mv	a1,s2
    80001be2:	6928                	ld	a0,80(a0)
    80001be4:	f61fe0ef          	jal	80000b44 <copyin>
    80001be8:	00a03533          	snez	a0,a0
    80001bec:	40a0053b          	negw	a0,a0
}
    80001bf0:	60e2                	ld	ra,24(sp)
    80001bf2:	6442                	ld	s0,16(sp)
    80001bf4:	64a2                	ld	s1,8(sp)
    80001bf6:	6902                	ld	s2,0(sp)
    80001bf8:	6105                	addi	sp,sp,32
    80001bfa:	8082                	ret
    return -1;
    80001bfc:	557d                	li	a0,-1
    80001bfe:	bfcd                	j	80001bf0 <fetchaddr+0x36>

0000000080001c00 <fetchstr>:
{
    80001c00:	7179                	addi	sp,sp,-48
    80001c02:	f406                	sd	ra,40(sp)
    80001c04:	f022                	sd	s0,32(sp)
    80001c06:	ec26                	sd	s1,24(sp)
    80001c08:	e84a                	sd	s2,16(sp)
    80001c0a:	e44e                	sd	s3,8(sp)
    80001c0c:	1800                	addi	s0,sp,48
    80001c0e:	89aa                	mv	s3,a0
    80001c10:	84ae                	mv	s1,a1
    80001c12:	8932                	mv	s2,a2
  struct proc *p = myproc();
    80001c14:	930ff0ef          	jal	80000d44 <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    80001c18:	86ca                	mv	a3,s2
    80001c1a:	864e                	mv	a2,s3
    80001c1c:	85a6                	mv	a1,s1
    80001c1e:	6928                	ld	a0,80(a0)
    80001c20:	d13fe0ef          	jal	80000932 <copyinstr>
    80001c24:	00054c63          	bltz	a0,80001c3c <fetchstr+0x3c>
  return strlen(buf);
    80001c28:	8526                	mv	a0,s1
    80001c2a:	e94fe0ef          	jal	800002be <strlen>
}
    80001c2e:	70a2                	ld	ra,40(sp)
    80001c30:	7402                	ld	s0,32(sp)
    80001c32:	64e2                	ld	s1,24(sp)
    80001c34:	6942                	ld	s2,16(sp)
    80001c36:	69a2                	ld	s3,8(sp)
    80001c38:	6145                	addi	sp,sp,48
    80001c3a:	8082                	ret
    return -1;
    80001c3c:	557d                	li	a0,-1
    80001c3e:	bfc5                	j	80001c2e <fetchstr+0x2e>

0000000080001c40 <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    80001c40:	1101                	addi	sp,sp,-32
    80001c42:	ec06                	sd	ra,24(sp)
    80001c44:	e822                	sd	s0,16(sp)
    80001c46:	e426                	sd	s1,8(sp)
    80001c48:	1000                	addi	s0,sp,32
    80001c4a:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001c4c:	f0fff0ef          	jal	80001b5a <argraw>
    80001c50:	c088                	sw	a0,0(s1)
}
    80001c52:	60e2                	ld	ra,24(sp)
    80001c54:	6442                	ld	s0,16(sp)
    80001c56:	64a2                	ld	s1,8(sp)
    80001c58:	6105                	addi	sp,sp,32
    80001c5a:	8082                	ret

0000000080001c5c <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    80001c5c:	1101                	addi	sp,sp,-32
    80001c5e:	ec06                	sd	ra,24(sp)
    80001c60:	e822                	sd	s0,16(sp)
    80001c62:	e426                	sd	s1,8(sp)
    80001c64:	1000                	addi	s0,sp,32
    80001c66:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001c68:	ef3ff0ef          	jal	80001b5a <argraw>
    80001c6c:	e088                	sd	a0,0(s1)
}
    80001c6e:	60e2                	ld	ra,24(sp)
    80001c70:	6442                	ld	s0,16(sp)
    80001c72:	64a2                	ld	s1,8(sp)
    80001c74:	6105                	addi	sp,sp,32
    80001c76:	8082                	ret

0000000080001c78 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80001c78:	1101                	addi	sp,sp,-32
    80001c7a:	ec06                	sd	ra,24(sp)
    80001c7c:	e822                	sd	s0,16(sp)
    80001c7e:	e426                	sd	s1,8(sp)
    80001c80:	e04a                	sd	s2,0(sp)
    80001c82:	1000                	addi	s0,sp,32
    80001c84:	892e                	mv	s2,a1
    80001c86:	84b2                	mv	s1,a2
  *ip = argraw(n);
    80001c88:	ed3ff0ef          	jal	80001b5a <argraw>
  uint64 addr;
  argaddr(n, &addr);
  return fetchstr(addr, buf, max);
    80001c8c:	8626                	mv	a2,s1
    80001c8e:	85ca                	mv	a1,s2
    80001c90:	f71ff0ef          	jal	80001c00 <fetchstr>
}
    80001c94:	60e2                	ld	ra,24(sp)
    80001c96:	6442                	ld	s0,16(sp)
    80001c98:	64a2                	ld	s1,8(sp)
    80001c9a:	6902                	ld	s2,0(sp)
    80001c9c:	6105                	addi	sp,sp,32
    80001c9e:	8082                	ret

0000000080001ca0 <syscall>:
[SYS_interpose] sys_interpose,
};

void
syscall(void)
{
    80001ca0:	7171                	addi	sp,sp,-176
    80001ca2:	f506                	sd	ra,168(sp)
    80001ca4:	f122                	sd	s0,160(sp)
    80001ca6:	ed26                	sd	s1,152(sp)
    80001ca8:	e94a                	sd	s2,144(sp)
    80001caa:	1900                	addi	s0,sp,176
  int num;
  struct proc *p = myproc();
    80001cac:	898ff0ef          	jal	80000d44 <myproc>
    80001cb0:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80001cb2:	05853903          	ld	s2,88(a0)
    80001cb6:	0a893783          	ld	a5,168(s2)
    80001cba:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80001cbe:	37fd                	addiw	a5,a5,-1
    80001cc0:	4755                	li	a4,21
    80001cc2:	08f76363          	bltu	a4,a5,80001d48 <syscall+0xa8>
    80001cc6:	e54e                	sd	s3,136(sp)
    80001cc8:	00369713          	slli	a4,a3,0x3
    80001ccc:	00006797          	auipc	a5,0x6
    80001cd0:	aa478793          	addi	a5,a5,-1372 # 80007770 <syscalls>
    80001cd4:	97ba                	add	a5,a5,a4
    80001cd6:	639c                	ld	a5,0(a5)
    80001cd8:	89be                	mv	s3,a5
    80001cda:	c7b5                	beqz	a5,80001d46 <syscall+0xa6>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    if(((p->interpose_mask)&(1<<num))){
    80001cdc:	16852783          	lw	a5,360(a0)
    80001ce0:	40d7d7bb          	sraw	a5,a5,a3
    80001ce4:	8b85                	andi	a5,a5,1
    80001ce6:	cbb9                	beqz	a5,80001d3c <syscall+0x9c>
      if(num==SYS_open||num==SYS_exec){
    80001ce8:	9add                	andi	a3,a3,-9
    80001cea:	479d                	li	a5,7
    80001cec:	00f68763          	beq	a3,a5,80001cfa <syscall+0x5a>
        else if(strncmp(path,p->interpose_path,MAXPATH)==0){
          p->trapframe->a0 =syscalls[num]();
        }
        else p->trapframe->a0=-1;
      }
      else p->trapframe->a0=-1; //stores return value from the system call
    80001cf0:	57fd                	li	a5,-1
    80001cf2:	06f93823          	sd	a5,112(s2)
    80001cf6:	69aa                	ld	s3,136(sp)
    80001cf8:	a0a5                	j	80001d60 <syscall+0xc0>
        if(argstr(0,path,MAXPATH)<0){
    80001cfa:	08000613          	li	a2,128
    80001cfe:	f5040593          	addi	a1,s0,-176
    80001d02:	4501                	li	a0,0
    80001d04:	f75ff0ef          	jal	80001c78 <argstr>
    80001d08:	00055763          	bgez	a0,80001d16 <syscall+0x76>
          p->trapframe->a0=-1; 
    80001d0c:	6cbc                	ld	a5,88(s1)
    80001d0e:	577d                	li	a4,-1
    80001d10:	fbb8                	sd	a4,112(a5)
    80001d12:	69aa                	ld	s3,136(sp)
    80001d14:	a0b1                	j	80001d60 <syscall+0xc0>
        else if(strncmp(path,p->interpose_path,MAXPATH)==0){
    80001d16:	08000613          	li	a2,128
    80001d1a:	16c48593          	addi	a1,s1,364
    80001d1e:	f5040513          	addi	a0,s0,-176
    80001d22:	cecfe0ef          	jal	8000020e <strncmp>
    80001d26:	e511                	bnez	a0,80001d32 <syscall+0x92>
          p->trapframe->a0 =syscalls[num]();
    80001d28:	6ca4                	ld	s1,88(s1)
    80001d2a:	9982                	jalr	s3
    80001d2c:	f8a8                	sd	a0,112(s1)
    80001d2e:	69aa                	ld	s3,136(sp)
    80001d30:	a805                	j	80001d60 <syscall+0xc0>
        else p->trapframe->a0=-1;
    80001d32:	6cbc                	ld	a5,88(s1)
    80001d34:	577d                	li	a4,-1
    80001d36:	fbb8                	sd	a4,112(a5)
    80001d38:	69aa                	ld	s3,136(sp)
    80001d3a:	a01d                	j	80001d60 <syscall+0xc0>
    }
    else p->trapframe->a0 =syscalls[num]();
    80001d3c:	9982                	jalr	s3
    80001d3e:	06a93823          	sd	a0,112(s2)
    80001d42:	69aa                	ld	s3,136(sp)
    80001d44:	a831                	j	80001d60 <syscall+0xc0>
    80001d46:	69aa                	ld	s3,136(sp)
  } else {
    printf("%d %s: unknown sys call %d\n",
    80001d48:	15848613          	addi	a2,s1,344
    80001d4c:	588c                	lw	a1,48(s1)
    80001d4e:	00005517          	auipc	a0,0x5
    80001d52:	5da50513          	addi	a0,a0,1498 # 80007328 <etext+0x328>
    80001d56:	586030ef          	jal	800052dc <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80001d5a:	6cbc                	ld	a5,88(s1)
    80001d5c:	577d                	li	a4,-1
    80001d5e:	fbb8                	sd	a4,112(a5)
  }
}
    80001d60:	70aa                	ld	ra,168(sp)
    80001d62:	740a                	ld	s0,160(sp)
    80001d64:	64ea                	ld	s1,152(sp)
    80001d66:	694a                	ld	s2,144(sp)
    80001d68:	614d                	addi	sp,sp,176
    80001d6a:	8082                	ret

0000000080001d6c <sys_exit>:
#include "proc.h"
#include "vm.h"

uint64
sys_exit(void)
{
    80001d6c:	1101                	addi	sp,sp,-32
    80001d6e:	ec06                	sd	ra,24(sp)
    80001d70:	e822                	sd	s0,16(sp)
    80001d72:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80001d74:	fec40593          	addi	a1,s0,-20
    80001d78:	4501                	li	a0,0
    80001d7a:	ec7ff0ef          	jal	80001c40 <argint>
  kexit(n);
    80001d7e:	fec42503          	lw	a0,-20(s0)
    80001d82:	ed0ff0ef          	jal	80001452 <kexit>
  return 0;  // not reached
}
    80001d86:	4501                	li	a0,0
    80001d88:	60e2                	ld	ra,24(sp)
    80001d8a:	6442                	ld	s0,16(sp)
    80001d8c:	6105                	addi	sp,sp,32
    80001d8e:	8082                	ret

0000000080001d90 <sys_getpid>:

uint64
sys_getpid(void)
{
    80001d90:	1141                	addi	sp,sp,-16
    80001d92:	e406                	sd	ra,8(sp)
    80001d94:	e022                	sd	s0,0(sp)
    80001d96:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80001d98:	fadfe0ef          	jal	80000d44 <myproc>
}
    80001d9c:	5908                	lw	a0,48(a0)
    80001d9e:	60a2                	ld	ra,8(sp)
    80001da0:	6402                	ld	s0,0(sp)
    80001da2:	0141                	addi	sp,sp,16
    80001da4:	8082                	ret

0000000080001da6 <sys_fork>:

uint64
sys_fork(void)
{
    80001da6:	1141                	addi	sp,sp,-16
    80001da8:	e406                	sd	ra,8(sp)
    80001daa:	e022                	sd	s0,0(sp)
    80001dac:	0800                	addi	s0,sp,16
  return kfork();
    80001dae:	aeaff0ef          	jal	80001098 <kfork>
}
    80001db2:	60a2                	ld	ra,8(sp)
    80001db4:	6402                	ld	s0,0(sp)
    80001db6:	0141                	addi	sp,sp,16
    80001db8:	8082                	ret

0000000080001dba <sys_wait>:

uint64
sys_wait(void)
{
    80001dba:	1101                	addi	sp,sp,-32
    80001dbc:	ec06                	sd	ra,24(sp)
    80001dbe:	e822                	sd	s0,16(sp)
    80001dc0:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80001dc2:	fe840593          	addi	a1,s0,-24
    80001dc6:	4501                	li	a0,0
    80001dc8:	e95ff0ef          	jal	80001c5c <argaddr>
  return kwait(p);
    80001dcc:	fe843503          	ld	a0,-24(s0)
    80001dd0:	fdcff0ef          	jal	800015ac <kwait>
}
    80001dd4:	60e2                	ld	ra,24(sp)
    80001dd6:	6442                	ld	s0,16(sp)
    80001dd8:	6105                	addi	sp,sp,32
    80001dda:	8082                	ret

0000000080001ddc <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80001ddc:	7179                	addi	sp,sp,-48
    80001dde:	f406                	sd	ra,40(sp)
    80001de0:	f022                	sd	s0,32(sp)
    80001de2:	ec26                	sd	s1,24(sp)
    80001de4:	1800                	addi	s0,sp,48
  uint64 addr;
  int t;
  int n;

  argint(0, &n);
    80001de6:	fd840593          	addi	a1,s0,-40
    80001dea:	4501                	li	a0,0
    80001dec:	e55ff0ef          	jal	80001c40 <argint>
  argint(1, &t);
    80001df0:	fdc40593          	addi	a1,s0,-36
    80001df4:	4505                	li	a0,1
    80001df6:	e4bff0ef          	jal	80001c40 <argint>
  addr = myproc()->sz;
    80001dfa:	f4bfe0ef          	jal	80000d44 <myproc>
    80001dfe:	6524                	ld	s1,72(a0)

  if(t == SBRK_EAGER || n < 0) {
    80001e00:	fdc42703          	lw	a4,-36(s0)
    80001e04:	4785                	li	a5,1
    80001e06:	02f70163          	beq	a4,a5,80001e28 <sys_sbrk+0x4c>
    80001e0a:	fd842783          	lw	a5,-40(s0)
    80001e0e:	0007cd63          	bltz	a5,80001e28 <sys_sbrk+0x4c>
    }
  } else {
    // Lazily allocate memory for this process: increase its memory
    // size but don't allocate memory. If the processes uses the
    // memory, vmfault() will allocate it.
    if(addr + n < addr)
    80001e12:	97a6                	add	a5,a5,s1
    80001e14:	0297e863          	bltu	a5,s1,80001e44 <sys_sbrk+0x68>
      return -1;
    myproc()->sz += n;
    80001e18:	f2dfe0ef          	jal	80000d44 <myproc>
    80001e1c:	fd842703          	lw	a4,-40(s0)
    80001e20:	653c                	ld	a5,72(a0)
    80001e22:	97ba                	add	a5,a5,a4
    80001e24:	e53c                	sd	a5,72(a0)
    80001e26:	a039                	j	80001e34 <sys_sbrk+0x58>
    if(growproc(n) < 0) {
    80001e28:	fd842503          	lw	a0,-40(s0)
    80001e2c:	a1cff0ef          	jal	80001048 <growproc>
    80001e30:	00054863          	bltz	a0,80001e40 <sys_sbrk+0x64>
  }
  return addr;
}
    80001e34:	8526                	mv	a0,s1
    80001e36:	70a2                	ld	ra,40(sp)
    80001e38:	7402                	ld	s0,32(sp)
    80001e3a:	64e2                	ld	s1,24(sp)
    80001e3c:	6145                	addi	sp,sp,48
    80001e3e:	8082                	ret
      return -1;
    80001e40:	54fd                	li	s1,-1
    80001e42:	bfcd                	j	80001e34 <sys_sbrk+0x58>
      return -1;
    80001e44:	54fd                	li	s1,-1
    80001e46:	b7fd                	j	80001e34 <sys_sbrk+0x58>

0000000080001e48 <sys_pause>:

uint64
sys_pause(void)
{
    80001e48:	7139                	addi	sp,sp,-64
    80001e4a:	fc06                	sd	ra,56(sp)
    80001e4c:	f822                	sd	s0,48(sp)
    80001e4e:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    80001e50:	fcc40593          	addi	a1,s0,-52
    80001e54:	4501                	li	a0,0
    80001e56:	debff0ef          	jal	80001c40 <argint>
  if(n < 0)
    80001e5a:	fcc42783          	lw	a5,-52(s0)
    80001e5e:	0607c863          	bltz	a5,80001ece <sys_pause+0x86>
    n = 0;
  acquire(&tickslock);
    80001e62:	0000e517          	auipc	a0,0xe
    80001e66:	a6e50513          	addi	a0,a0,-1426 # 8000f8d0 <tickslock>
    80001e6a:	269030ef          	jal	800058d2 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    80001e6e:	fcc42783          	lw	a5,-52(s0)
    80001e72:	c3b9                	beqz	a5,80001eb8 <sys_pause+0x70>
    80001e74:	f426                	sd	s1,40(sp)
    80001e76:	f04a                	sd	s2,32(sp)
    80001e78:	ec4e                	sd	s3,24(sp)
  ticks0 = ticks;
    80001e7a:	00006997          	auipc	s3,0x6
    80001e7e:	9ee9a983          	lw	s3,-1554(s3) # 80007868 <ticks>
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80001e82:	0000e917          	auipc	s2,0xe
    80001e86:	a4e90913          	addi	s2,s2,-1458 # 8000f8d0 <tickslock>
    80001e8a:	00006497          	auipc	s1,0x6
    80001e8e:	9de48493          	addi	s1,s1,-1570 # 80007868 <ticks>
    if(killed(myproc())){
    80001e92:	eb3fe0ef          	jal	80000d44 <myproc>
    80001e96:	eecff0ef          	jal	80001582 <killed>
    80001e9a:	ed0d                	bnez	a0,80001ed4 <sys_pause+0x8c>
    sleep(&ticks, &tickslock);
    80001e9c:	85ca                	mv	a1,s2
    80001e9e:	8526                	mv	a0,s1
    80001ea0:	ca6ff0ef          	jal	80001346 <sleep>
  while(ticks - ticks0 < n){
    80001ea4:	409c                	lw	a5,0(s1)
    80001ea6:	413787bb          	subw	a5,a5,s3
    80001eaa:	fcc42703          	lw	a4,-52(s0)
    80001eae:	fee7e2e3          	bltu	a5,a4,80001e92 <sys_pause+0x4a>
    80001eb2:	74a2                	ld	s1,40(sp)
    80001eb4:	7902                	ld	s2,32(sp)
    80001eb6:	69e2                	ld	s3,24(sp)
  }
  release(&tickslock);
    80001eb8:	0000e517          	auipc	a0,0xe
    80001ebc:	a1850513          	addi	a0,a0,-1512 # 8000f8d0 <tickslock>
    80001ec0:	2a3030ef          	jal	80005962 <release>
  return 0;
    80001ec4:	4501                	li	a0,0
}
    80001ec6:	70e2                	ld	ra,56(sp)
    80001ec8:	7442                	ld	s0,48(sp)
    80001eca:	6121                	addi	sp,sp,64
    80001ecc:	8082                	ret
    n = 0;
    80001ece:	fc042623          	sw	zero,-52(s0)
    80001ed2:	bf41                	j	80001e62 <sys_pause+0x1a>
      release(&tickslock);
    80001ed4:	0000e517          	auipc	a0,0xe
    80001ed8:	9fc50513          	addi	a0,a0,-1540 # 8000f8d0 <tickslock>
    80001edc:	287030ef          	jal	80005962 <release>
      return -1;
    80001ee0:	557d                	li	a0,-1
    80001ee2:	74a2                	ld	s1,40(sp)
    80001ee4:	7902                	ld	s2,32(sp)
    80001ee6:	69e2                	ld	s3,24(sp)
    80001ee8:	bff9                	j	80001ec6 <sys_pause+0x7e>

0000000080001eea <sys_kill>:

uint64
sys_kill(void)
{
    80001eea:	1101                	addi	sp,sp,-32
    80001eec:	ec06                	sd	ra,24(sp)
    80001eee:	e822                	sd	s0,16(sp)
    80001ef0:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80001ef2:	fec40593          	addi	a1,s0,-20
    80001ef6:	4501                	li	a0,0
    80001ef8:	d49ff0ef          	jal	80001c40 <argint>
  return kkill(pid);
    80001efc:	fec42503          	lw	a0,-20(s0)
    80001f00:	df8ff0ef          	jal	800014f8 <kkill>
}
    80001f04:	60e2                	ld	ra,24(sp)
    80001f06:	6442                	ld	s0,16(sp)
    80001f08:	6105                	addi	sp,sp,32
    80001f0a:	8082                	ret

0000000080001f0c <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80001f0c:	1101                	addi	sp,sp,-32
    80001f0e:	ec06                	sd	ra,24(sp)
    80001f10:	e822                	sd	s0,16(sp)
    80001f12:	e426                	sd	s1,8(sp)
    80001f14:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80001f16:	0000e517          	auipc	a0,0xe
    80001f1a:	9ba50513          	addi	a0,a0,-1606 # 8000f8d0 <tickslock>
    80001f1e:	1b5030ef          	jal	800058d2 <acquire>
  xticks = ticks;
    80001f22:	00006797          	auipc	a5,0x6
    80001f26:	9467a783          	lw	a5,-1722(a5) # 80007868 <ticks>
    80001f2a:	84be                	mv	s1,a5
  release(&tickslock);
    80001f2c:	0000e517          	auipc	a0,0xe
    80001f30:	9a450513          	addi	a0,a0,-1628 # 8000f8d0 <tickslock>
    80001f34:	22f030ef          	jal	80005962 <release>
  return xticks;
}
    80001f38:	02049513          	slli	a0,s1,0x20
    80001f3c:	9101                	srli	a0,a0,0x20
    80001f3e:	60e2                	ld	ra,24(sp)
    80001f40:	6442                	ld	s0,16(sp)
    80001f42:	64a2                	ld	s1,8(sp)
    80001f44:	6105                	addi	sp,sp,32
    80001f46:	8082                	ret

0000000080001f48 <sys_interpose>:

uint64
sys_interpose(void)
{
    80001f48:	7135                	addi	sp,sp,-160
    80001f4a:	ed06                	sd	ra,152(sp)
    80001f4c:	e922                	sd	s0,144(sp)
    80001f4e:	1100                	addi	s0,sp,160
    int mask;
    char path[MAXPATH];
    
    argint(0, &mask);
    80001f50:	fec40593          	addi	a1,s0,-20
    80001f54:	4501                	li	a0,0
    80001f56:	cebff0ef          	jal	80001c40 <argint>
    //arg number, dest, number of bytes
    if(argstr(1,path,MAXPATH)<0){
    80001f5a:	08000613          	li	a2,128
    80001f5e:	f6840593          	addi	a1,s0,-152
    80001f62:	4505                	li	a0,1
    80001f64:	d15ff0ef          	jal	80001c78 <argstr>
      return -1;
    80001f68:	57fd                	li	a5,-1
    if(argstr(1,path,MAXPATH)<0){
    80001f6a:	02054363          	bltz	a0,80001f90 <sys_interpose+0x48>
    }
    myproc()->interpose_mask=mask;
    80001f6e:	dd7fe0ef          	jal	80000d44 <myproc>
    80001f72:	fec42783          	lw	a5,-20(s0)
    80001f76:	16f52423          	sw	a5,360(a0)
    safestrcpy(myproc()->interpose_path, path, MAXPATH);
    80001f7a:	dcbfe0ef          	jal	80000d44 <myproc>
    80001f7e:	08000613          	li	a2,128
    80001f82:	f6840593          	addi	a1,s0,-152
    80001f86:	16c50513          	addi	a0,a0,364
    80001f8a:	afefe0ef          	jal	80000288 <safestrcpy>
    return 0;
    80001f8e:	4781                	li	a5,0
    80001f90:	853e                	mv	a0,a5
    80001f92:	60ea                	ld	ra,152(sp)
    80001f94:	644a                	ld	s0,144(sp)
    80001f96:	610d                	addi	sp,sp,160
    80001f98:	8082                	ret

0000000080001f9a <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80001f9a:	7179                	addi	sp,sp,-48
    80001f9c:	f406                	sd	ra,40(sp)
    80001f9e:	f022                	sd	s0,32(sp)
    80001fa0:	ec26                	sd	s1,24(sp)
    80001fa2:	e84a                	sd	s2,16(sp)
    80001fa4:	e44e                	sd	s3,8(sp)
    80001fa6:	e052                	sd	s4,0(sp)
    80001fa8:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80001faa:	00005597          	auipc	a1,0x5
    80001fae:	39e58593          	addi	a1,a1,926 # 80007348 <etext+0x348>
    80001fb2:	0000e517          	auipc	a0,0xe
    80001fb6:	93650513          	addi	a0,a0,-1738 # 8000f8e8 <bcache>
    80001fba:	08f030ef          	jal	80005848 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80001fbe:	00016797          	auipc	a5,0x16
    80001fc2:	92a78793          	addi	a5,a5,-1750 # 800178e8 <bcache+0x8000>
    80001fc6:	00016717          	auipc	a4,0x16
    80001fca:	b8a70713          	addi	a4,a4,-1142 # 80017b50 <bcache+0x8268>
    80001fce:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80001fd2:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80001fd6:	0000e497          	auipc	s1,0xe
    80001fda:	92a48493          	addi	s1,s1,-1750 # 8000f900 <bcache+0x18>
    b->next = bcache.head.next;
    80001fde:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80001fe0:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80001fe2:	00005a17          	auipc	s4,0x5
    80001fe6:	36ea0a13          	addi	s4,s4,878 # 80007350 <etext+0x350>
    b->next = bcache.head.next;
    80001fea:	2b893783          	ld	a5,696(s2)
    80001fee:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80001ff0:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80001ff4:	85d2                	mv	a1,s4
    80001ff6:	01048513          	addi	a0,s1,16
    80001ffa:	336010ef          	jal	80003330 <initsleeplock>
    bcache.head.next->prev = b;
    80001ffe:	2b893783          	ld	a5,696(s2)
    80002002:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002004:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002008:	45848493          	addi	s1,s1,1112
    8000200c:	fd349fe3          	bne	s1,s3,80001fea <binit+0x50>
  }
}
    80002010:	70a2                	ld	ra,40(sp)
    80002012:	7402                	ld	s0,32(sp)
    80002014:	64e2                	ld	s1,24(sp)
    80002016:	6942                	ld	s2,16(sp)
    80002018:	69a2                	ld	s3,8(sp)
    8000201a:	6a02                	ld	s4,0(sp)
    8000201c:	6145                	addi	sp,sp,48
    8000201e:	8082                	ret

0000000080002020 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002020:	7179                	addi	sp,sp,-48
    80002022:	f406                	sd	ra,40(sp)
    80002024:	f022                	sd	s0,32(sp)
    80002026:	ec26                	sd	s1,24(sp)
    80002028:	e84a                	sd	s2,16(sp)
    8000202a:	e44e                	sd	s3,8(sp)
    8000202c:	1800                	addi	s0,sp,48
    8000202e:	892a                	mv	s2,a0
    80002030:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80002032:	0000e517          	auipc	a0,0xe
    80002036:	8b650513          	addi	a0,a0,-1866 # 8000f8e8 <bcache>
    8000203a:	099030ef          	jal	800058d2 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    8000203e:	00016497          	auipc	s1,0x16
    80002042:	b624b483          	ld	s1,-1182(s1) # 80017ba0 <bcache+0x82b8>
    80002046:	00016797          	auipc	a5,0x16
    8000204a:	b0a78793          	addi	a5,a5,-1270 # 80017b50 <bcache+0x8268>
    8000204e:	02f48b63          	beq	s1,a5,80002084 <bread+0x64>
    80002052:	873e                	mv	a4,a5
    80002054:	a021                	j	8000205c <bread+0x3c>
    80002056:	68a4                	ld	s1,80(s1)
    80002058:	02e48663          	beq	s1,a4,80002084 <bread+0x64>
    if(b->dev == dev && b->blockno == blockno){
    8000205c:	449c                	lw	a5,8(s1)
    8000205e:	ff279ce3          	bne	a5,s2,80002056 <bread+0x36>
    80002062:	44dc                	lw	a5,12(s1)
    80002064:	ff3799e3          	bne	a5,s3,80002056 <bread+0x36>
      b->refcnt++;
    80002068:	40bc                	lw	a5,64(s1)
    8000206a:	2785                	addiw	a5,a5,1
    8000206c:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000206e:	0000e517          	auipc	a0,0xe
    80002072:	87a50513          	addi	a0,a0,-1926 # 8000f8e8 <bcache>
    80002076:	0ed030ef          	jal	80005962 <release>
      acquiresleep(&b->lock);
    8000207a:	01048513          	addi	a0,s1,16
    8000207e:	2e8010ef          	jal	80003366 <acquiresleep>
      return b;
    80002082:	a889                	j	800020d4 <bread+0xb4>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002084:	00016497          	auipc	s1,0x16
    80002088:	b144b483          	ld	s1,-1260(s1) # 80017b98 <bcache+0x82b0>
    8000208c:	00016797          	auipc	a5,0x16
    80002090:	ac478793          	addi	a5,a5,-1340 # 80017b50 <bcache+0x8268>
    80002094:	00f48863          	beq	s1,a5,800020a4 <bread+0x84>
    80002098:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    8000209a:	40bc                	lw	a5,64(s1)
    8000209c:	cb91                	beqz	a5,800020b0 <bread+0x90>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    8000209e:	64a4                	ld	s1,72(s1)
    800020a0:	fee49de3          	bne	s1,a4,8000209a <bread+0x7a>
  panic("bget: no buffers");
    800020a4:	00005517          	auipc	a0,0x5
    800020a8:	2b450513          	addi	a0,a0,692 # 80007358 <etext+0x358>
    800020ac:	568030ef          	jal	80005614 <panic>
      b->dev = dev;
    800020b0:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    800020b4:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    800020b8:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    800020bc:	4785                	li	a5,1
    800020be:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800020c0:	0000e517          	auipc	a0,0xe
    800020c4:	82850513          	addi	a0,a0,-2008 # 8000f8e8 <bcache>
    800020c8:	09b030ef          	jal	80005962 <release>
      acquiresleep(&b->lock);
    800020cc:	01048513          	addi	a0,s1,16
    800020d0:	296010ef          	jal	80003366 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    800020d4:	409c                	lw	a5,0(s1)
    800020d6:	cb89                	beqz	a5,800020e8 <bread+0xc8>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    800020d8:	8526                	mv	a0,s1
    800020da:	70a2                	ld	ra,40(sp)
    800020dc:	7402                	ld	s0,32(sp)
    800020de:	64e2                	ld	s1,24(sp)
    800020e0:	6942                	ld	s2,16(sp)
    800020e2:	69a2                	ld	s3,8(sp)
    800020e4:	6145                	addi	sp,sp,48
    800020e6:	8082                	ret
    virtio_disk_rw(b, 0);
    800020e8:	4581                	li	a1,0
    800020ea:	8526                	mv	a0,s1
    800020ec:	257020ef          	jal	80004b42 <virtio_disk_rw>
    b->valid = 1;
    800020f0:	4785                	li	a5,1
    800020f2:	c09c                	sw	a5,0(s1)
  return b;
    800020f4:	b7d5                	j	800020d8 <bread+0xb8>

00000000800020f6 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800020f6:	1101                	addi	sp,sp,-32
    800020f8:	ec06                	sd	ra,24(sp)
    800020fa:	e822                	sd	s0,16(sp)
    800020fc:	e426                	sd	s1,8(sp)
    800020fe:	1000                	addi	s0,sp,32
    80002100:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002102:	0541                	addi	a0,a0,16
    80002104:	2e0010ef          	jal	800033e4 <holdingsleep>
    80002108:	c911                	beqz	a0,8000211c <bwrite+0x26>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    8000210a:	4585                	li	a1,1
    8000210c:	8526                	mv	a0,s1
    8000210e:	235020ef          	jal	80004b42 <virtio_disk_rw>
}
    80002112:	60e2                	ld	ra,24(sp)
    80002114:	6442                	ld	s0,16(sp)
    80002116:	64a2                	ld	s1,8(sp)
    80002118:	6105                	addi	sp,sp,32
    8000211a:	8082                	ret
    panic("bwrite");
    8000211c:	00005517          	auipc	a0,0x5
    80002120:	25450513          	addi	a0,a0,596 # 80007370 <etext+0x370>
    80002124:	4f0030ef          	jal	80005614 <panic>

0000000080002128 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80002128:	1101                	addi	sp,sp,-32
    8000212a:	ec06                	sd	ra,24(sp)
    8000212c:	e822                	sd	s0,16(sp)
    8000212e:	e426                	sd	s1,8(sp)
    80002130:	e04a                	sd	s2,0(sp)
    80002132:	1000                	addi	s0,sp,32
    80002134:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002136:	01050913          	addi	s2,a0,16
    8000213a:	854a                	mv	a0,s2
    8000213c:	2a8010ef          	jal	800033e4 <holdingsleep>
    80002140:	c125                	beqz	a0,800021a0 <brelse+0x78>
    panic("brelse");

  releasesleep(&b->lock);
    80002142:	854a                	mv	a0,s2
    80002144:	268010ef          	jal	800033ac <releasesleep>

  acquire(&bcache.lock);
    80002148:	0000d517          	auipc	a0,0xd
    8000214c:	7a050513          	addi	a0,a0,1952 # 8000f8e8 <bcache>
    80002150:	782030ef          	jal	800058d2 <acquire>
  b->refcnt--;
    80002154:	40bc                	lw	a5,64(s1)
    80002156:	37fd                	addiw	a5,a5,-1
    80002158:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    8000215a:	e79d                	bnez	a5,80002188 <brelse+0x60>
    // no one is waiting for it.
    b->next->prev = b->prev;
    8000215c:	68b8                	ld	a4,80(s1)
    8000215e:	64bc                	ld	a5,72(s1)
    80002160:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    80002162:	68b8                	ld	a4,80(s1)
    80002164:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80002166:	00015797          	auipc	a5,0x15
    8000216a:	78278793          	addi	a5,a5,1922 # 800178e8 <bcache+0x8000>
    8000216e:	2b87b703          	ld	a4,696(a5)
    80002172:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80002174:	00016717          	auipc	a4,0x16
    80002178:	9dc70713          	addi	a4,a4,-1572 # 80017b50 <bcache+0x8268>
    8000217c:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    8000217e:	2b87b703          	ld	a4,696(a5)
    80002182:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002184:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    80002188:	0000d517          	auipc	a0,0xd
    8000218c:	76050513          	addi	a0,a0,1888 # 8000f8e8 <bcache>
    80002190:	7d2030ef          	jal	80005962 <release>
}
    80002194:	60e2                	ld	ra,24(sp)
    80002196:	6442                	ld	s0,16(sp)
    80002198:	64a2                	ld	s1,8(sp)
    8000219a:	6902                	ld	s2,0(sp)
    8000219c:	6105                	addi	sp,sp,32
    8000219e:	8082                	ret
    panic("brelse");
    800021a0:	00005517          	auipc	a0,0x5
    800021a4:	1d850513          	addi	a0,a0,472 # 80007378 <etext+0x378>
    800021a8:	46c030ef          	jal	80005614 <panic>

00000000800021ac <bpin>:

void
bpin(struct buf *b) {
    800021ac:	1101                	addi	sp,sp,-32
    800021ae:	ec06                	sd	ra,24(sp)
    800021b0:	e822                	sd	s0,16(sp)
    800021b2:	e426                	sd	s1,8(sp)
    800021b4:	1000                	addi	s0,sp,32
    800021b6:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800021b8:	0000d517          	auipc	a0,0xd
    800021bc:	73050513          	addi	a0,a0,1840 # 8000f8e8 <bcache>
    800021c0:	712030ef          	jal	800058d2 <acquire>
  b->refcnt++;
    800021c4:	40bc                	lw	a5,64(s1)
    800021c6:	2785                	addiw	a5,a5,1
    800021c8:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800021ca:	0000d517          	auipc	a0,0xd
    800021ce:	71e50513          	addi	a0,a0,1822 # 8000f8e8 <bcache>
    800021d2:	790030ef          	jal	80005962 <release>
}
    800021d6:	60e2                	ld	ra,24(sp)
    800021d8:	6442                	ld	s0,16(sp)
    800021da:	64a2                	ld	s1,8(sp)
    800021dc:	6105                	addi	sp,sp,32
    800021de:	8082                	ret

00000000800021e0 <bunpin>:

void
bunpin(struct buf *b) {
    800021e0:	1101                	addi	sp,sp,-32
    800021e2:	ec06                	sd	ra,24(sp)
    800021e4:	e822                	sd	s0,16(sp)
    800021e6:	e426                	sd	s1,8(sp)
    800021e8:	1000                	addi	s0,sp,32
    800021ea:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800021ec:	0000d517          	auipc	a0,0xd
    800021f0:	6fc50513          	addi	a0,a0,1788 # 8000f8e8 <bcache>
    800021f4:	6de030ef          	jal	800058d2 <acquire>
  b->refcnt--;
    800021f8:	40bc                	lw	a5,64(s1)
    800021fa:	37fd                	addiw	a5,a5,-1
    800021fc:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800021fe:	0000d517          	auipc	a0,0xd
    80002202:	6ea50513          	addi	a0,a0,1770 # 8000f8e8 <bcache>
    80002206:	75c030ef          	jal	80005962 <release>
}
    8000220a:	60e2                	ld	ra,24(sp)
    8000220c:	6442                	ld	s0,16(sp)
    8000220e:	64a2                	ld	s1,8(sp)
    80002210:	6105                	addi	sp,sp,32
    80002212:	8082                	ret

0000000080002214 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80002214:	1101                	addi	sp,sp,-32
    80002216:	ec06                	sd	ra,24(sp)
    80002218:	e822                	sd	s0,16(sp)
    8000221a:	e426                	sd	s1,8(sp)
    8000221c:	e04a                	sd	s2,0(sp)
    8000221e:	1000                	addi	s0,sp,32
    80002220:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80002222:	00d5d79b          	srliw	a5,a1,0xd
    80002226:	00016597          	auipc	a1,0x16
    8000222a:	d9e5a583          	lw	a1,-610(a1) # 80017fc4 <sb+0x1c>
    8000222e:	9dbd                	addw	a1,a1,a5
    80002230:	df1ff0ef          	jal	80002020 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80002234:	0074f713          	andi	a4,s1,7
    80002238:	4785                	li	a5,1
    8000223a:	00e797bb          	sllw	a5,a5,a4
  bi = b % BPB;
    8000223e:	14ce                	slli	s1,s1,0x33
  if((bp->data[bi/8] & m) == 0)
    80002240:	90d9                	srli	s1,s1,0x36
    80002242:	00950733          	add	a4,a0,s1
    80002246:	05874703          	lbu	a4,88(a4)
    8000224a:	00e7f6b3          	and	a3,a5,a4
    8000224e:	c29d                	beqz	a3,80002274 <bfree+0x60>
    80002250:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002252:	94aa                	add	s1,s1,a0
    80002254:	fff7c793          	not	a5,a5
    80002258:	8f7d                	and	a4,a4,a5
    8000225a:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    8000225e:	012010ef          	jal	80003270 <log_write>
  brelse(bp);
    80002262:	854a                	mv	a0,s2
    80002264:	ec5ff0ef          	jal	80002128 <brelse>
}
    80002268:	60e2                	ld	ra,24(sp)
    8000226a:	6442                	ld	s0,16(sp)
    8000226c:	64a2                	ld	s1,8(sp)
    8000226e:	6902                	ld	s2,0(sp)
    80002270:	6105                	addi	sp,sp,32
    80002272:	8082                	ret
    panic("freeing free block");
    80002274:	00005517          	auipc	a0,0x5
    80002278:	10c50513          	addi	a0,a0,268 # 80007380 <etext+0x380>
    8000227c:	398030ef          	jal	80005614 <panic>

0000000080002280 <balloc>:
{
    80002280:	715d                	addi	sp,sp,-80
    80002282:	e486                	sd	ra,72(sp)
    80002284:	e0a2                	sd	s0,64(sp)
    80002286:	fc26                	sd	s1,56(sp)
    80002288:	0880                	addi	s0,sp,80
  for(b = 0; b < sb.size; b += BPB){
    8000228a:	00016797          	auipc	a5,0x16
    8000228e:	d227a783          	lw	a5,-734(a5) # 80017fac <sb+0x4>
    80002292:	0e078263          	beqz	a5,80002376 <balloc+0xf6>
    80002296:	f84a                	sd	s2,48(sp)
    80002298:	f44e                	sd	s3,40(sp)
    8000229a:	f052                	sd	s4,32(sp)
    8000229c:	ec56                	sd	s5,24(sp)
    8000229e:	e85a                	sd	s6,16(sp)
    800022a0:	e45e                	sd	s7,8(sp)
    800022a2:	e062                	sd	s8,0(sp)
    800022a4:	8baa                	mv	s7,a0
    800022a6:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    800022a8:	00016b17          	auipc	s6,0x16
    800022ac:	d00b0b13          	addi	s6,s6,-768 # 80017fa8 <sb>
      m = 1 << (bi % 8);
    800022b0:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800022b2:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    800022b4:	6c09                	lui	s8,0x2
    800022b6:	a09d                	j	8000231c <balloc+0x9c>
        bp->data[bi/8] |= m;  // Mark block in use.
    800022b8:	97ca                	add	a5,a5,s2
    800022ba:	8e55                	or	a2,a2,a3
    800022bc:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    800022c0:	854a                	mv	a0,s2
    800022c2:	7af000ef          	jal	80003270 <log_write>
        brelse(bp);
    800022c6:	854a                	mv	a0,s2
    800022c8:	e61ff0ef          	jal	80002128 <brelse>
  bp = bread(dev, bno);
    800022cc:	85a6                	mv	a1,s1
    800022ce:	855e                	mv	a0,s7
    800022d0:	d51ff0ef          	jal	80002020 <bread>
    800022d4:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    800022d6:	40000613          	li	a2,1024
    800022da:	4581                	li	a1,0
    800022dc:	05850513          	addi	a0,a0,88
    800022e0:	e5ffd0ef          	jal	8000013e <memset>
  log_write(bp);
    800022e4:	854a                	mv	a0,s2
    800022e6:	78b000ef          	jal	80003270 <log_write>
  brelse(bp);
    800022ea:	854a                	mv	a0,s2
    800022ec:	e3dff0ef          	jal	80002128 <brelse>
        return b + bi;
    800022f0:	7942                	ld	s2,48(sp)
    800022f2:	79a2                	ld	s3,40(sp)
    800022f4:	7a02                	ld	s4,32(sp)
    800022f6:	6ae2                	ld	s5,24(sp)
    800022f8:	6b42                	ld	s6,16(sp)
    800022fa:	6ba2                	ld	s7,8(sp)
    800022fc:	6c02                	ld	s8,0(sp)
}
    800022fe:	8526                	mv	a0,s1
    80002300:	60a6                	ld	ra,72(sp)
    80002302:	6406                	ld	s0,64(sp)
    80002304:	74e2                	ld	s1,56(sp)
    80002306:	6161                	addi	sp,sp,80
    80002308:	8082                	ret
    brelse(bp);
    8000230a:	854a                	mv	a0,s2
    8000230c:	e1dff0ef          	jal	80002128 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80002310:	015c0abb          	addw	s5,s8,s5
    80002314:	004b2783          	lw	a5,4(s6)
    80002318:	04faf863          	bgeu	s5,a5,80002368 <balloc+0xe8>
    bp = bread(dev, BBLOCK(b, sb));
    8000231c:	40dad59b          	sraiw	a1,s5,0xd
    80002320:	01cb2783          	lw	a5,28(s6)
    80002324:	9dbd                	addw	a1,a1,a5
    80002326:	855e                	mv	a0,s7
    80002328:	cf9ff0ef          	jal	80002020 <bread>
    8000232c:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000232e:	004b2503          	lw	a0,4(s6)
    80002332:	84d6                	mv	s1,s5
    80002334:	4701                	li	a4,0
    80002336:	fca4fae3          	bgeu	s1,a0,8000230a <balloc+0x8a>
      m = 1 << (bi % 8);
    8000233a:	00777693          	andi	a3,a4,7
    8000233e:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002342:	41f7579b          	sraiw	a5,a4,0x1f
    80002346:	01d7d79b          	srliw	a5,a5,0x1d
    8000234a:	9fb9                	addw	a5,a5,a4
    8000234c:	4037d79b          	sraiw	a5,a5,0x3
    80002350:	00f90633          	add	a2,s2,a5
    80002354:	05864603          	lbu	a2,88(a2)
    80002358:	00c6f5b3          	and	a1,a3,a2
    8000235c:	ddb1                	beqz	a1,800022b8 <balloc+0x38>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000235e:	2705                	addiw	a4,a4,1
    80002360:	2485                	addiw	s1,s1,1
    80002362:	fd471ae3          	bne	a4,s4,80002336 <balloc+0xb6>
    80002366:	b755                	j	8000230a <balloc+0x8a>
    80002368:	7942                	ld	s2,48(sp)
    8000236a:	79a2                	ld	s3,40(sp)
    8000236c:	7a02                	ld	s4,32(sp)
    8000236e:	6ae2                	ld	s5,24(sp)
    80002370:	6b42                	ld	s6,16(sp)
    80002372:	6ba2                	ld	s7,8(sp)
    80002374:	6c02                	ld	s8,0(sp)
  printf("balloc: out of blocks\n");
    80002376:	00005517          	auipc	a0,0x5
    8000237a:	02250513          	addi	a0,a0,34 # 80007398 <etext+0x398>
    8000237e:	75f020ef          	jal	800052dc <printf>
  return 0;
    80002382:	4481                	li	s1,0
    80002384:	bfad                	j	800022fe <balloc+0x7e>

0000000080002386 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    80002386:	7179                	addi	sp,sp,-48
    80002388:	f406                	sd	ra,40(sp)
    8000238a:	f022                	sd	s0,32(sp)
    8000238c:	ec26                	sd	s1,24(sp)
    8000238e:	e84a                	sd	s2,16(sp)
    80002390:	e44e                	sd	s3,8(sp)
    80002392:	1800                	addi	s0,sp,48
    80002394:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80002396:	47ad                	li	a5,11
    80002398:	02b7e363          	bltu	a5,a1,800023be <bmap+0x38>
    if((addr = ip->addrs[bn]) == 0){
    8000239c:	02059793          	slli	a5,a1,0x20
    800023a0:	01e7d593          	srli	a1,a5,0x1e
    800023a4:	00b509b3          	add	s3,a0,a1
    800023a8:	0509a483          	lw	s1,80(s3)
    800023ac:	e0b5                	bnez	s1,80002410 <bmap+0x8a>
      addr = balloc(ip->dev);
    800023ae:	4108                	lw	a0,0(a0)
    800023b0:	ed1ff0ef          	jal	80002280 <balloc>
    800023b4:	84aa                	mv	s1,a0
      if(addr == 0)
    800023b6:	cd29                	beqz	a0,80002410 <bmap+0x8a>
        return 0;
      ip->addrs[bn] = addr;
    800023b8:	04a9a823          	sw	a0,80(s3)
    800023bc:	a891                	j	80002410 <bmap+0x8a>
    }
    return addr;
  }
  bn -= NDIRECT;
    800023be:	ff45879b          	addiw	a5,a1,-12
    800023c2:	873e                	mv	a4,a5
    800023c4:	89be                	mv	s3,a5

  if(bn < NINDIRECT){
    800023c6:	0ff00793          	li	a5,255
    800023ca:	06e7e763          	bltu	a5,a4,80002438 <bmap+0xb2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    800023ce:	08052483          	lw	s1,128(a0)
    800023d2:	e891                	bnez	s1,800023e6 <bmap+0x60>
      addr = balloc(ip->dev);
    800023d4:	4108                	lw	a0,0(a0)
    800023d6:	eabff0ef          	jal	80002280 <balloc>
    800023da:	84aa                	mv	s1,a0
      if(addr == 0)
    800023dc:	c915                	beqz	a0,80002410 <bmap+0x8a>
    800023de:	e052                	sd	s4,0(sp)
        return 0;
      ip->addrs[NDIRECT] = addr;
    800023e0:	08a92023          	sw	a0,128(s2)
    800023e4:	a011                	j	800023e8 <bmap+0x62>
    800023e6:	e052                	sd	s4,0(sp)
    }
    bp = bread(ip->dev, addr);
    800023e8:	85a6                	mv	a1,s1
    800023ea:	00092503          	lw	a0,0(s2)
    800023ee:	c33ff0ef          	jal	80002020 <bread>
    800023f2:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    800023f4:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    800023f8:	02099713          	slli	a4,s3,0x20
    800023fc:	01e75593          	srli	a1,a4,0x1e
    80002400:	97ae                	add	a5,a5,a1
    80002402:	89be                	mv	s3,a5
    80002404:	4384                	lw	s1,0(a5)
    80002406:	cc89                	beqz	s1,80002420 <bmap+0x9a>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    80002408:	8552                	mv	a0,s4
    8000240a:	d1fff0ef          	jal	80002128 <brelse>
    return addr;
    8000240e:	6a02                	ld	s4,0(sp)
  }

  panic("bmap: out of range");
}
    80002410:	8526                	mv	a0,s1
    80002412:	70a2                	ld	ra,40(sp)
    80002414:	7402                	ld	s0,32(sp)
    80002416:	64e2                	ld	s1,24(sp)
    80002418:	6942                	ld	s2,16(sp)
    8000241a:	69a2                	ld	s3,8(sp)
    8000241c:	6145                	addi	sp,sp,48
    8000241e:	8082                	ret
      addr = balloc(ip->dev);
    80002420:	00092503          	lw	a0,0(s2)
    80002424:	e5dff0ef          	jal	80002280 <balloc>
    80002428:	84aa                	mv	s1,a0
      if(addr){
    8000242a:	dd79                	beqz	a0,80002408 <bmap+0x82>
        a[bn] = addr;
    8000242c:	00a9a023          	sw	a0,0(s3)
        log_write(bp);
    80002430:	8552                	mv	a0,s4
    80002432:	63f000ef          	jal	80003270 <log_write>
    80002436:	bfc9                	j	80002408 <bmap+0x82>
    80002438:	e052                	sd	s4,0(sp)
  panic("bmap: out of range");
    8000243a:	00005517          	auipc	a0,0x5
    8000243e:	f7650513          	addi	a0,a0,-138 # 800073b0 <etext+0x3b0>
    80002442:	1d2030ef          	jal	80005614 <panic>

0000000080002446 <iget>:
{
    80002446:	7179                	addi	sp,sp,-48
    80002448:	f406                	sd	ra,40(sp)
    8000244a:	f022                	sd	s0,32(sp)
    8000244c:	ec26                	sd	s1,24(sp)
    8000244e:	e84a                	sd	s2,16(sp)
    80002450:	e44e                	sd	s3,8(sp)
    80002452:	e052                	sd	s4,0(sp)
    80002454:	1800                	addi	s0,sp,48
    80002456:	89aa                	mv	s3,a0
    80002458:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    8000245a:	00016517          	auipc	a0,0x16
    8000245e:	b6e50513          	addi	a0,a0,-1170 # 80017fc8 <itable>
    80002462:	470030ef          	jal	800058d2 <acquire>
  empty = 0;
    80002466:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002468:	00016497          	auipc	s1,0x16
    8000246c:	b7848493          	addi	s1,s1,-1160 # 80017fe0 <itable+0x18>
    80002470:	00017697          	auipc	a3,0x17
    80002474:	60068693          	addi	a3,a3,1536 # 80019a70 <log>
    80002478:	a819                	j	8000248e <iget+0x48>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    8000247a:	0017b793          	seqz	a5,a5
    8000247e:	00193713          	seqz	a4,s2
    80002482:	8ff9                	and	a5,a5,a4
    80002484:	eb85                	bnez	a5,800024b4 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002486:	08848493          	addi	s1,s1,136
    8000248a:	02d48763          	beq	s1,a3,800024b8 <iget+0x72>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    8000248e:	449c                	lw	a5,8(s1)
    80002490:	fef055e3          	blez	a5,8000247a <iget+0x34>
    80002494:	4098                	lw	a4,0(s1)
    80002496:	ff3718e3          	bne	a4,s3,80002486 <iget+0x40>
    8000249a:	40d8                	lw	a4,4(s1)
    8000249c:	ff4715e3          	bne	a4,s4,80002486 <iget+0x40>
      ip->ref++;
    800024a0:	2785                	addiw	a5,a5,1
    800024a2:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    800024a4:	00016517          	auipc	a0,0x16
    800024a8:	b2450513          	addi	a0,a0,-1244 # 80017fc8 <itable>
    800024ac:	4b6030ef          	jal	80005962 <release>
      return ip;
    800024b0:	8926                	mv	s2,s1
    800024b2:	a025                	j	800024da <iget+0x94>
      empty = ip;
    800024b4:	8926                	mv	s2,s1
    800024b6:	bfc1                	j	80002486 <iget+0x40>
  if(empty == 0)
    800024b8:	02090a63          	beqz	s2,800024ec <iget+0xa6>
  ip->dev = dev;
    800024bc:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    800024c0:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    800024c4:	4785                	li	a5,1
    800024c6:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    800024ca:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    800024ce:	00016517          	auipc	a0,0x16
    800024d2:	afa50513          	addi	a0,a0,-1286 # 80017fc8 <itable>
    800024d6:	48c030ef          	jal	80005962 <release>
}
    800024da:	854a                	mv	a0,s2
    800024dc:	70a2                	ld	ra,40(sp)
    800024de:	7402                	ld	s0,32(sp)
    800024e0:	64e2                	ld	s1,24(sp)
    800024e2:	6942                	ld	s2,16(sp)
    800024e4:	69a2                	ld	s3,8(sp)
    800024e6:	6a02                	ld	s4,0(sp)
    800024e8:	6145                	addi	sp,sp,48
    800024ea:	8082                	ret
    panic("iget: no inodes");
    800024ec:	00005517          	auipc	a0,0x5
    800024f0:	edc50513          	addi	a0,a0,-292 # 800073c8 <etext+0x3c8>
    800024f4:	120030ef          	jal	80005614 <panic>

00000000800024f8 <iinit>:
{
    800024f8:	7179                	addi	sp,sp,-48
    800024fa:	f406                	sd	ra,40(sp)
    800024fc:	f022                	sd	s0,32(sp)
    800024fe:	ec26                	sd	s1,24(sp)
    80002500:	e84a                	sd	s2,16(sp)
    80002502:	e44e                	sd	s3,8(sp)
    80002504:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80002506:	00005597          	auipc	a1,0x5
    8000250a:	ed258593          	addi	a1,a1,-302 # 800073d8 <etext+0x3d8>
    8000250e:	00016517          	auipc	a0,0x16
    80002512:	aba50513          	addi	a0,a0,-1350 # 80017fc8 <itable>
    80002516:	332030ef          	jal	80005848 <initlock>
  for(i = 0; i < NINODE; i++) {
    8000251a:	00016497          	auipc	s1,0x16
    8000251e:	ad648493          	addi	s1,s1,-1322 # 80017ff0 <itable+0x28>
    80002522:	00017997          	auipc	s3,0x17
    80002526:	55e98993          	addi	s3,s3,1374 # 80019a80 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    8000252a:	00005917          	auipc	s2,0x5
    8000252e:	eb690913          	addi	s2,s2,-330 # 800073e0 <etext+0x3e0>
    80002532:	85ca                	mv	a1,s2
    80002534:	8526                	mv	a0,s1
    80002536:	5fb000ef          	jal	80003330 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    8000253a:	08848493          	addi	s1,s1,136
    8000253e:	ff349ae3          	bne	s1,s3,80002532 <iinit+0x3a>
}
    80002542:	70a2                	ld	ra,40(sp)
    80002544:	7402                	ld	s0,32(sp)
    80002546:	64e2                	ld	s1,24(sp)
    80002548:	6942                	ld	s2,16(sp)
    8000254a:	69a2                	ld	s3,8(sp)
    8000254c:	6145                	addi	sp,sp,48
    8000254e:	8082                	ret

0000000080002550 <ialloc>:
{
    80002550:	7139                	addi	sp,sp,-64
    80002552:	fc06                	sd	ra,56(sp)
    80002554:	f822                	sd	s0,48(sp)
    80002556:	0080                	addi	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    80002558:	00016717          	auipc	a4,0x16
    8000255c:	a5c72703          	lw	a4,-1444(a4) # 80017fb4 <sb+0xc>
    80002560:	4785                	li	a5,1
    80002562:	06e7f063          	bgeu	a5,a4,800025c2 <ialloc+0x72>
    80002566:	f426                	sd	s1,40(sp)
    80002568:	f04a                	sd	s2,32(sp)
    8000256a:	ec4e                	sd	s3,24(sp)
    8000256c:	e852                	sd	s4,16(sp)
    8000256e:	e456                	sd	s5,8(sp)
    80002570:	e05a                	sd	s6,0(sp)
    80002572:	8aaa                	mv	s5,a0
    80002574:	8b2e                	mv	s6,a1
    80002576:	893e                	mv	s2,a5
    bp = bread(dev, IBLOCK(inum, sb));
    80002578:	00016a17          	auipc	s4,0x16
    8000257c:	a30a0a13          	addi	s4,s4,-1488 # 80017fa8 <sb>
    80002580:	00495593          	srli	a1,s2,0x4
    80002584:	018a2783          	lw	a5,24(s4)
    80002588:	9dbd                	addw	a1,a1,a5
    8000258a:	8556                	mv	a0,s5
    8000258c:	a95ff0ef          	jal	80002020 <bread>
    80002590:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002592:	05850993          	addi	s3,a0,88
    80002596:	00f97793          	andi	a5,s2,15
    8000259a:	079a                	slli	a5,a5,0x6
    8000259c:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    8000259e:	00099783          	lh	a5,0(s3)
    800025a2:	cb9d                	beqz	a5,800025d8 <ialloc+0x88>
    brelse(bp);
    800025a4:	b85ff0ef          	jal	80002128 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    800025a8:	0905                	addi	s2,s2,1
    800025aa:	00ca2703          	lw	a4,12(s4)
    800025ae:	0009079b          	sext.w	a5,s2
    800025b2:	fce7e7e3          	bltu	a5,a4,80002580 <ialloc+0x30>
    800025b6:	74a2                	ld	s1,40(sp)
    800025b8:	7902                	ld	s2,32(sp)
    800025ba:	69e2                	ld	s3,24(sp)
    800025bc:	6a42                	ld	s4,16(sp)
    800025be:	6aa2                	ld	s5,8(sp)
    800025c0:	6b02                	ld	s6,0(sp)
  printf("ialloc: no inodes\n");
    800025c2:	00005517          	auipc	a0,0x5
    800025c6:	e2650513          	addi	a0,a0,-474 # 800073e8 <etext+0x3e8>
    800025ca:	513020ef          	jal	800052dc <printf>
  return 0;
    800025ce:	4501                	li	a0,0
}
    800025d0:	70e2                	ld	ra,56(sp)
    800025d2:	7442                	ld	s0,48(sp)
    800025d4:	6121                	addi	sp,sp,64
    800025d6:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    800025d8:	04000613          	li	a2,64
    800025dc:	4581                	li	a1,0
    800025de:	854e                	mv	a0,s3
    800025e0:	b5ffd0ef          	jal	8000013e <memset>
      dip->type = type;
    800025e4:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    800025e8:	8526                	mv	a0,s1
    800025ea:	487000ef          	jal	80003270 <log_write>
      brelse(bp);
    800025ee:	8526                	mv	a0,s1
    800025f0:	b39ff0ef          	jal	80002128 <brelse>
      return iget(dev, inum);
    800025f4:	0009059b          	sext.w	a1,s2
    800025f8:	8556                	mv	a0,s5
    800025fa:	e4dff0ef          	jal	80002446 <iget>
    800025fe:	74a2                	ld	s1,40(sp)
    80002600:	7902                	ld	s2,32(sp)
    80002602:	69e2                	ld	s3,24(sp)
    80002604:	6a42                	ld	s4,16(sp)
    80002606:	6aa2                	ld	s5,8(sp)
    80002608:	6b02                	ld	s6,0(sp)
    8000260a:	b7d9                	j	800025d0 <ialloc+0x80>

000000008000260c <iupdate>:
{
    8000260c:	1101                	addi	sp,sp,-32
    8000260e:	ec06                	sd	ra,24(sp)
    80002610:	e822                	sd	s0,16(sp)
    80002612:	e426                	sd	s1,8(sp)
    80002614:	e04a                	sd	s2,0(sp)
    80002616:	1000                	addi	s0,sp,32
    80002618:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    8000261a:	415c                	lw	a5,4(a0)
    8000261c:	0047d79b          	srliw	a5,a5,0x4
    80002620:	00016597          	auipc	a1,0x16
    80002624:	9a05a583          	lw	a1,-1632(a1) # 80017fc0 <sb+0x18>
    80002628:	9dbd                	addw	a1,a1,a5
    8000262a:	4108                	lw	a0,0(a0)
    8000262c:	9f5ff0ef          	jal	80002020 <bread>
    80002630:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002632:	05850793          	addi	a5,a0,88
    80002636:	40d8                	lw	a4,4(s1)
    80002638:	8b3d                	andi	a4,a4,15
    8000263a:	071a                	slli	a4,a4,0x6
    8000263c:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    8000263e:	04449703          	lh	a4,68(s1)
    80002642:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002646:	04649703          	lh	a4,70(s1)
    8000264a:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    8000264e:	04849703          	lh	a4,72(s1)
    80002652:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002656:	04a49703          	lh	a4,74(s1)
    8000265a:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    8000265e:	44f8                	lw	a4,76(s1)
    80002660:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002662:	03400613          	li	a2,52
    80002666:	05048593          	addi	a1,s1,80
    8000266a:	00c78513          	addi	a0,a5,12
    8000266e:	b2dfd0ef          	jal	8000019a <memmove>
  log_write(bp);
    80002672:	854a                	mv	a0,s2
    80002674:	3fd000ef          	jal	80003270 <log_write>
  brelse(bp);
    80002678:	854a                	mv	a0,s2
    8000267a:	aafff0ef          	jal	80002128 <brelse>
}
    8000267e:	60e2                	ld	ra,24(sp)
    80002680:	6442                	ld	s0,16(sp)
    80002682:	64a2                	ld	s1,8(sp)
    80002684:	6902                	ld	s2,0(sp)
    80002686:	6105                	addi	sp,sp,32
    80002688:	8082                	ret

000000008000268a <idup>:
{
    8000268a:	1101                	addi	sp,sp,-32
    8000268c:	ec06                	sd	ra,24(sp)
    8000268e:	e822                	sd	s0,16(sp)
    80002690:	e426                	sd	s1,8(sp)
    80002692:	1000                	addi	s0,sp,32
    80002694:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002696:	00016517          	auipc	a0,0x16
    8000269a:	93250513          	addi	a0,a0,-1742 # 80017fc8 <itable>
    8000269e:	234030ef          	jal	800058d2 <acquire>
  ip->ref++;
    800026a2:	449c                	lw	a5,8(s1)
    800026a4:	2785                	addiw	a5,a5,1
    800026a6:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    800026a8:	00016517          	auipc	a0,0x16
    800026ac:	92050513          	addi	a0,a0,-1760 # 80017fc8 <itable>
    800026b0:	2b2030ef          	jal	80005962 <release>
}
    800026b4:	8526                	mv	a0,s1
    800026b6:	60e2                	ld	ra,24(sp)
    800026b8:	6442                	ld	s0,16(sp)
    800026ba:	64a2                	ld	s1,8(sp)
    800026bc:	6105                	addi	sp,sp,32
    800026be:	8082                	ret

00000000800026c0 <ilock>:
{
    800026c0:	1101                	addi	sp,sp,-32
    800026c2:	ec06                	sd	ra,24(sp)
    800026c4:	e822                	sd	s0,16(sp)
    800026c6:	e426                	sd	s1,8(sp)
    800026c8:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    800026ca:	cd19                	beqz	a0,800026e8 <ilock+0x28>
    800026cc:	84aa                	mv	s1,a0
    800026ce:	451c                	lw	a5,8(a0)
    800026d0:	00f05c63          	blez	a5,800026e8 <ilock+0x28>
  acquiresleep(&ip->lock);
    800026d4:	0541                	addi	a0,a0,16
    800026d6:	491000ef          	jal	80003366 <acquiresleep>
  if(ip->valid == 0){
    800026da:	40bc                	lw	a5,64(s1)
    800026dc:	cf89                	beqz	a5,800026f6 <ilock+0x36>
}
    800026de:	60e2                	ld	ra,24(sp)
    800026e0:	6442                	ld	s0,16(sp)
    800026e2:	64a2                	ld	s1,8(sp)
    800026e4:	6105                	addi	sp,sp,32
    800026e6:	8082                	ret
    800026e8:	e04a                	sd	s2,0(sp)
    panic("ilock");
    800026ea:	00005517          	auipc	a0,0x5
    800026ee:	d1650513          	addi	a0,a0,-746 # 80007400 <etext+0x400>
    800026f2:	723020ef          	jal	80005614 <panic>
    800026f6:	e04a                	sd	s2,0(sp)
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800026f8:	40dc                	lw	a5,4(s1)
    800026fa:	0047d79b          	srliw	a5,a5,0x4
    800026fe:	00016597          	auipc	a1,0x16
    80002702:	8c25a583          	lw	a1,-1854(a1) # 80017fc0 <sb+0x18>
    80002706:	9dbd                	addw	a1,a1,a5
    80002708:	4088                	lw	a0,0(s1)
    8000270a:	917ff0ef          	jal	80002020 <bread>
    8000270e:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002710:	05850593          	addi	a1,a0,88
    80002714:	40dc                	lw	a5,4(s1)
    80002716:	8bbd                	andi	a5,a5,15
    80002718:	079a                	slli	a5,a5,0x6
    8000271a:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    8000271c:	00059783          	lh	a5,0(a1)
    80002720:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002724:	00259783          	lh	a5,2(a1)
    80002728:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    8000272c:	00459783          	lh	a5,4(a1)
    80002730:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002734:	00659783          	lh	a5,6(a1)
    80002738:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    8000273c:	459c                	lw	a5,8(a1)
    8000273e:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002740:	03400613          	li	a2,52
    80002744:	05b1                	addi	a1,a1,12
    80002746:	05048513          	addi	a0,s1,80
    8000274a:	a51fd0ef          	jal	8000019a <memmove>
    brelse(bp);
    8000274e:	854a                	mv	a0,s2
    80002750:	9d9ff0ef          	jal	80002128 <brelse>
    ip->valid = 1;
    80002754:	4785                	li	a5,1
    80002756:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002758:	04449783          	lh	a5,68(s1)
    8000275c:	c399                	beqz	a5,80002762 <ilock+0xa2>
    8000275e:	6902                	ld	s2,0(sp)
    80002760:	bfbd                	j	800026de <ilock+0x1e>
      panic("ilock: no type");
    80002762:	00005517          	auipc	a0,0x5
    80002766:	ca650513          	addi	a0,a0,-858 # 80007408 <etext+0x408>
    8000276a:	6ab020ef          	jal	80005614 <panic>

000000008000276e <iunlock>:
{
    8000276e:	1101                	addi	sp,sp,-32
    80002770:	ec06                	sd	ra,24(sp)
    80002772:	e822                	sd	s0,16(sp)
    80002774:	e426                	sd	s1,8(sp)
    80002776:	e04a                	sd	s2,0(sp)
    80002778:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    8000277a:	c505                	beqz	a0,800027a2 <iunlock+0x34>
    8000277c:	84aa                	mv	s1,a0
    8000277e:	01050913          	addi	s2,a0,16
    80002782:	854a                	mv	a0,s2
    80002784:	461000ef          	jal	800033e4 <holdingsleep>
    80002788:	cd09                	beqz	a0,800027a2 <iunlock+0x34>
    8000278a:	449c                	lw	a5,8(s1)
    8000278c:	00f05b63          	blez	a5,800027a2 <iunlock+0x34>
  releasesleep(&ip->lock);
    80002790:	854a                	mv	a0,s2
    80002792:	41b000ef          	jal	800033ac <releasesleep>
}
    80002796:	60e2                	ld	ra,24(sp)
    80002798:	6442                	ld	s0,16(sp)
    8000279a:	64a2                	ld	s1,8(sp)
    8000279c:	6902                	ld	s2,0(sp)
    8000279e:	6105                	addi	sp,sp,32
    800027a0:	8082                	ret
    panic("iunlock");
    800027a2:	00005517          	auipc	a0,0x5
    800027a6:	c7650513          	addi	a0,a0,-906 # 80007418 <etext+0x418>
    800027aa:	66b020ef          	jal	80005614 <panic>

00000000800027ae <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    800027ae:	7179                	addi	sp,sp,-48
    800027b0:	f406                	sd	ra,40(sp)
    800027b2:	f022                	sd	s0,32(sp)
    800027b4:	ec26                	sd	s1,24(sp)
    800027b6:	e84a                	sd	s2,16(sp)
    800027b8:	e44e                	sd	s3,8(sp)
    800027ba:	1800                	addi	s0,sp,48
    800027bc:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    800027be:	05050493          	addi	s1,a0,80
    800027c2:	08050913          	addi	s2,a0,128
    800027c6:	a021                	j	800027ce <itrunc+0x20>
    800027c8:	0491                	addi	s1,s1,4
    800027ca:	01248b63          	beq	s1,s2,800027e0 <itrunc+0x32>
    if(ip->addrs[i]){
    800027ce:	408c                	lw	a1,0(s1)
    800027d0:	dde5                	beqz	a1,800027c8 <itrunc+0x1a>
      bfree(ip->dev, ip->addrs[i]);
    800027d2:	0009a503          	lw	a0,0(s3)
    800027d6:	a3fff0ef          	jal	80002214 <bfree>
      ip->addrs[i] = 0;
    800027da:	0004a023          	sw	zero,0(s1)
    800027de:	b7ed                	j	800027c8 <itrunc+0x1a>
    }
  }

  if(ip->addrs[NDIRECT]){
    800027e0:	0809a583          	lw	a1,128(s3)
    800027e4:	ed89                	bnez	a1,800027fe <itrunc+0x50>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    800027e6:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    800027ea:	854e                	mv	a0,s3
    800027ec:	e21ff0ef          	jal	8000260c <iupdate>
}
    800027f0:	70a2                	ld	ra,40(sp)
    800027f2:	7402                	ld	s0,32(sp)
    800027f4:	64e2                	ld	s1,24(sp)
    800027f6:	6942                	ld	s2,16(sp)
    800027f8:	69a2                	ld	s3,8(sp)
    800027fa:	6145                	addi	sp,sp,48
    800027fc:	8082                	ret
    800027fe:	e052                	sd	s4,0(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002800:	0009a503          	lw	a0,0(s3)
    80002804:	81dff0ef          	jal	80002020 <bread>
    80002808:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    8000280a:	05850493          	addi	s1,a0,88
    8000280e:	45850913          	addi	s2,a0,1112
    80002812:	a021                	j	8000281a <itrunc+0x6c>
    80002814:	0491                	addi	s1,s1,4
    80002816:	01248963          	beq	s1,s2,80002828 <itrunc+0x7a>
      if(a[j])
    8000281a:	408c                	lw	a1,0(s1)
    8000281c:	dde5                	beqz	a1,80002814 <itrunc+0x66>
        bfree(ip->dev, a[j]);
    8000281e:	0009a503          	lw	a0,0(s3)
    80002822:	9f3ff0ef          	jal	80002214 <bfree>
    80002826:	b7fd                	j	80002814 <itrunc+0x66>
    brelse(bp);
    80002828:	8552                	mv	a0,s4
    8000282a:	8ffff0ef          	jal	80002128 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    8000282e:	0809a583          	lw	a1,128(s3)
    80002832:	0009a503          	lw	a0,0(s3)
    80002836:	9dfff0ef          	jal	80002214 <bfree>
    ip->addrs[NDIRECT] = 0;
    8000283a:	0809a023          	sw	zero,128(s3)
    8000283e:	6a02                	ld	s4,0(sp)
    80002840:	b75d                	j	800027e6 <itrunc+0x38>

0000000080002842 <iput>:
{
    80002842:	1101                	addi	sp,sp,-32
    80002844:	ec06                	sd	ra,24(sp)
    80002846:	e822                	sd	s0,16(sp)
    80002848:	e426                	sd	s1,8(sp)
    8000284a:	1000                	addi	s0,sp,32
    8000284c:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    8000284e:	00015517          	auipc	a0,0x15
    80002852:	77a50513          	addi	a0,a0,1914 # 80017fc8 <itable>
    80002856:	07c030ef          	jal	800058d2 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    8000285a:	4498                	lw	a4,8(s1)
    8000285c:	4785                	li	a5,1
    8000285e:	02f70063          	beq	a4,a5,8000287e <iput+0x3c>
  ip->ref--;
    80002862:	449c                	lw	a5,8(s1)
    80002864:	37fd                	addiw	a5,a5,-1
    80002866:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002868:	00015517          	auipc	a0,0x15
    8000286c:	76050513          	addi	a0,a0,1888 # 80017fc8 <itable>
    80002870:	0f2030ef          	jal	80005962 <release>
}
    80002874:	60e2                	ld	ra,24(sp)
    80002876:	6442                	ld	s0,16(sp)
    80002878:	64a2                	ld	s1,8(sp)
    8000287a:	6105                	addi	sp,sp,32
    8000287c:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    8000287e:	40bc                	lw	a5,64(s1)
    80002880:	d3ed                	beqz	a5,80002862 <iput+0x20>
    80002882:	04a49783          	lh	a5,74(s1)
    80002886:	fff1                	bnez	a5,80002862 <iput+0x20>
    80002888:	e04a                	sd	s2,0(sp)
    acquiresleep(&ip->lock);
    8000288a:	01048793          	addi	a5,s1,16
    8000288e:	893e                	mv	s2,a5
    80002890:	853e                	mv	a0,a5
    80002892:	2d5000ef          	jal	80003366 <acquiresleep>
    release(&itable.lock);
    80002896:	00015517          	auipc	a0,0x15
    8000289a:	73250513          	addi	a0,a0,1842 # 80017fc8 <itable>
    8000289e:	0c4030ef          	jal	80005962 <release>
    itrunc(ip);
    800028a2:	8526                	mv	a0,s1
    800028a4:	f0bff0ef          	jal	800027ae <itrunc>
    ip->type = 0;
    800028a8:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    800028ac:	8526                	mv	a0,s1
    800028ae:	d5fff0ef          	jal	8000260c <iupdate>
    ip->valid = 0;
    800028b2:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    800028b6:	854a                	mv	a0,s2
    800028b8:	2f5000ef          	jal	800033ac <releasesleep>
    acquire(&itable.lock);
    800028bc:	00015517          	auipc	a0,0x15
    800028c0:	70c50513          	addi	a0,a0,1804 # 80017fc8 <itable>
    800028c4:	00e030ef          	jal	800058d2 <acquire>
    800028c8:	6902                	ld	s2,0(sp)
    800028ca:	bf61                	j	80002862 <iput+0x20>

00000000800028cc <iunlockput>:
{
    800028cc:	1101                	addi	sp,sp,-32
    800028ce:	ec06                	sd	ra,24(sp)
    800028d0:	e822                	sd	s0,16(sp)
    800028d2:	e426                	sd	s1,8(sp)
    800028d4:	1000                	addi	s0,sp,32
    800028d6:	84aa                	mv	s1,a0
  iunlock(ip);
    800028d8:	e97ff0ef          	jal	8000276e <iunlock>
  iput(ip);
    800028dc:	8526                	mv	a0,s1
    800028de:	f65ff0ef          	jal	80002842 <iput>
}
    800028e2:	60e2                	ld	ra,24(sp)
    800028e4:	6442                	ld	s0,16(sp)
    800028e6:	64a2                	ld	s1,8(sp)
    800028e8:	6105                	addi	sp,sp,32
    800028ea:	8082                	ret

00000000800028ec <ireclaim>:
  for (int inum = 1; inum < sb.ninodes; inum++) {
    800028ec:	00015717          	auipc	a4,0x15
    800028f0:	6c872703          	lw	a4,1736(a4) # 80017fb4 <sb+0xc>
    800028f4:	4785                	li	a5,1
    800028f6:	0ae7fe63          	bgeu	a5,a4,800029b2 <ireclaim+0xc6>
{
    800028fa:	7139                	addi	sp,sp,-64
    800028fc:	fc06                	sd	ra,56(sp)
    800028fe:	f822                	sd	s0,48(sp)
    80002900:	f426                	sd	s1,40(sp)
    80002902:	f04a                	sd	s2,32(sp)
    80002904:	ec4e                	sd	s3,24(sp)
    80002906:	e852                	sd	s4,16(sp)
    80002908:	e456                	sd	s5,8(sp)
    8000290a:	e05a                	sd	s6,0(sp)
    8000290c:	0080                	addi	s0,sp,64
    8000290e:	8aaa                	mv	s5,a0
  for (int inum = 1; inum < sb.ninodes; inum++) {
    80002910:	84be                	mv	s1,a5
    struct buf *bp = bread(dev, IBLOCK(inum, sb));
    80002912:	00015a17          	auipc	s4,0x15
    80002916:	696a0a13          	addi	s4,s4,1686 # 80017fa8 <sb>
      printf("ireclaim: orphaned inode %d\n", inum);
    8000291a:	00005b17          	auipc	s6,0x5
    8000291e:	b06b0b13          	addi	s6,s6,-1274 # 80007420 <etext+0x420>
    80002922:	a099                	j	80002968 <ireclaim+0x7c>
    80002924:	85ce                	mv	a1,s3
    80002926:	855a                	mv	a0,s6
    80002928:	1b5020ef          	jal	800052dc <printf>
      ip = iget(dev, inum);
    8000292c:	85ce                	mv	a1,s3
    8000292e:	8556                	mv	a0,s5
    80002930:	b17ff0ef          	jal	80002446 <iget>
    80002934:	89aa                	mv	s3,a0
    brelse(bp);
    80002936:	854a                	mv	a0,s2
    80002938:	ff0ff0ef          	jal	80002128 <brelse>
    if (ip) {
    8000293c:	00098f63          	beqz	s3,8000295a <ireclaim+0x6e>
      begin_op();
    80002940:	796000ef          	jal	800030d6 <begin_op>
      ilock(ip);
    80002944:	854e                	mv	a0,s3
    80002946:	d7bff0ef          	jal	800026c0 <ilock>
      iunlock(ip);
    8000294a:	854e                	mv	a0,s3
    8000294c:	e23ff0ef          	jal	8000276e <iunlock>
      iput(ip);
    80002950:	854e                	mv	a0,s3
    80002952:	ef1ff0ef          	jal	80002842 <iput>
      end_op();
    80002956:	7f0000ef          	jal	80003146 <end_op>
  for (int inum = 1; inum < sb.ninodes; inum++) {
    8000295a:	0485                	addi	s1,s1,1
    8000295c:	00ca2703          	lw	a4,12(s4)
    80002960:	0004879b          	sext.w	a5,s1
    80002964:	02e7fd63          	bgeu	a5,a4,8000299e <ireclaim+0xb2>
    80002968:	0004899b          	sext.w	s3,s1
    struct buf *bp = bread(dev, IBLOCK(inum, sb));
    8000296c:	0044d593          	srli	a1,s1,0x4
    80002970:	018a2783          	lw	a5,24(s4)
    80002974:	9dbd                	addw	a1,a1,a5
    80002976:	8556                	mv	a0,s5
    80002978:	ea8ff0ef          	jal	80002020 <bread>
    8000297c:	892a                	mv	s2,a0
    struct dinode *dip = (struct dinode *)bp->data + inum % IPB;
    8000297e:	05850793          	addi	a5,a0,88
    80002982:	00f9f713          	andi	a4,s3,15
    80002986:	071a                	slli	a4,a4,0x6
    80002988:	97ba                	add	a5,a5,a4
    if (dip->type != 0 && dip->nlink == 0) {  // is an orphaned inode
    8000298a:	00079703          	lh	a4,0(a5)
    8000298e:	c701                	beqz	a4,80002996 <ireclaim+0xaa>
    80002990:	00679783          	lh	a5,6(a5)
    80002994:	dbc1                	beqz	a5,80002924 <ireclaim+0x38>
    brelse(bp);
    80002996:	854a                	mv	a0,s2
    80002998:	f90ff0ef          	jal	80002128 <brelse>
    if (ip) {
    8000299c:	bf7d                	j	8000295a <ireclaim+0x6e>
}
    8000299e:	70e2                	ld	ra,56(sp)
    800029a0:	7442                	ld	s0,48(sp)
    800029a2:	74a2                	ld	s1,40(sp)
    800029a4:	7902                	ld	s2,32(sp)
    800029a6:	69e2                	ld	s3,24(sp)
    800029a8:	6a42                	ld	s4,16(sp)
    800029aa:	6aa2                	ld	s5,8(sp)
    800029ac:	6b02                	ld	s6,0(sp)
    800029ae:	6121                	addi	sp,sp,64
    800029b0:	8082                	ret
    800029b2:	8082                	ret

00000000800029b4 <fsinit>:
fsinit(int dev) {
    800029b4:	1101                	addi	sp,sp,-32
    800029b6:	ec06                	sd	ra,24(sp)
    800029b8:	e822                	sd	s0,16(sp)
    800029ba:	e426                	sd	s1,8(sp)
    800029bc:	e04a                	sd	s2,0(sp)
    800029be:	1000                	addi	s0,sp,32
    800029c0:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    800029c2:	4585                	li	a1,1
    800029c4:	e5cff0ef          	jal	80002020 <bread>
    800029c8:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    800029ca:	02000613          	li	a2,32
    800029ce:	05850593          	addi	a1,a0,88
    800029d2:	00015517          	auipc	a0,0x15
    800029d6:	5d650513          	addi	a0,a0,1494 # 80017fa8 <sb>
    800029da:	fc0fd0ef          	jal	8000019a <memmove>
  brelse(bp);
    800029de:	8526                	mv	a0,s1
    800029e0:	f48ff0ef          	jal	80002128 <brelse>
  if(sb.magic != FSMAGIC)
    800029e4:	00015717          	auipc	a4,0x15
    800029e8:	5c472703          	lw	a4,1476(a4) # 80017fa8 <sb>
    800029ec:	102037b7          	lui	a5,0x10203
    800029f0:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    800029f4:	02f71263          	bne	a4,a5,80002a18 <fsinit+0x64>
  initlog(dev, &sb);
    800029f8:	00015597          	auipc	a1,0x15
    800029fc:	5b058593          	addi	a1,a1,1456 # 80017fa8 <sb>
    80002a00:	854a                	mv	a0,s2
    80002a02:	652000ef          	jal	80003054 <initlog>
  ireclaim(dev);
    80002a06:	854a                	mv	a0,s2
    80002a08:	ee5ff0ef          	jal	800028ec <ireclaim>
}
    80002a0c:	60e2                	ld	ra,24(sp)
    80002a0e:	6442                	ld	s0,16(sp)
    80002a10:	64a2                	ld	s1,8(sp)
    80002a12:	6902                	ld	s2,0(sp)
    80002a14:	6105                	addi	sp,sp,32
    80002a16:	8082                	ret
    panic("invalid file system");
    80002a18:	00005517          	auipc	a0,0x5
    80002a1c:	a2850513          	addi	a0,a0,-1496 # 80007440 <etext+0x440>
    80002a20:	3f5020ef          	jal	80005614 <panic>

0000000080002a24 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002a24:	1141                	addi	sp,sp,-16
    80002a26:	e406                	sd	ra,8(sp)
    80002a28:	e022                	sd	s0,0(sp)
    80002a2a:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002a2c:	411c                	lw	a5,0(a0)
    80002a2e:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002a30:	415c                	lw	a5,4(a0)
    80002a32:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002a34:	04451783          	lh	a5,68(a0)
    80002a38:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002a3c:	04a51783          	lh	a5,74(a0)
    80002a40:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002a44:	04c56783          	lwu	a5,76(a0)
    80002a48:	e99c                	sd	a5,16(a1)
}
    80002a4a:	60a2                	ld	ra,8(sp)
    80002a4c:	6402                	ld	s0,0(sp)
    80002a4e:	0141                	addi	sp,sp,16
    80002a50:	8082                	ret

0000000080002a52 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002a52:	457c                	lw	a5,76(a0)
    80002a54:	0ed7e663          	bltu	a5,a3,80002b40 <readi+0xee>
{
    80002a58:	7159                	addi	sp,sp,-112
    80002a5a:	f486                	sd	ra,104(sp)
    80002a5c:	f0a2                	sd	s0,96(sp)
    80002a5e:	eca6                	sd	s1,88(sp)
    80002a60:	e0d2                	sd	s4,64(sp)
    80002a62:	fc56                	sd	s5,56(sp)
    80002a64:	f85a                	sd	s6,48(sp)
    80002a66:	f45e                	sd	s7,40(sp)
    80002a68:	1880                	addi	s0,sp,112
    80002a6a:	8b2a                	mv	s6,a0
    80002a6c:	8bae                	mv	s7,a1
    80002a6e:	8a32                	mv	s4,a2
    80002a70:	84b6                	mv	s1,a3
    80002a72:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    80002a74:	9f35                	addw	a4,a4,a3
    return 0;
    80002a76:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80002a78:	0ad76b63          	bltu	a4,a3,80002b2e <readi+0xdc>
    80002a7c:	e4ce                	sd	s3,72(sp)
  if(off + n > ip->size)
    80002a7e:	00e7f463          	bgeu	a5,a4,80002a86 <readi+0x34>
    n = ip->size - off;
    80002a82:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002a86:	080a8b63          	beqz	s5,80002b1c <readi+0xca>
    80002a8a:	e8ca                	sd	s2,80(sp)
    80002a8c:	f062                	sd	s8,32(sp)
    80002a8e:	ec66                	sd	s9,24(sp)
    80002a90:	e86a                	sd	s10,16(sp)
    80002a92:	e46e                	sd	s11,8(sp)
    80002a94:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002a96:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002a9a:	5c7d                	li	s8,-1
    80002a9c:	a80d                	j	80002ace <readi+0x7c>
    80002a9e:	020d1d93          	slli	s11,s10,0x20
    80002aa2:	020ddd93          	srli	s11,s11,0x20
    80002aa6:	05890613          	addi	a2,s2,88
    80002aaa:	86ee                	mv	a3,s11
    80002aac:	963e                	add	a2,a2,a5
    80002aae:	85d2                	mv	a1,s4
    80002ab0:	855e                	mv	a0,s7
    80002ab2:	bedfe0ef          	jal	8000169e <either_copyout>
    80002ab6:	05850363          	beq	a0,s8,80002afc <readi+0xaa>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002aba:	854a                	mv	a0,s2
    80002abc:	e6cff0ef          	jal	80002128 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002ac0:	013d09bb          	addw	s3,s10,s3
    80002ac4:	009d04bb          	addw	s1,s10,s1
    80002ac8:	9a6e                	add	s4,s4,s11
    80002aca:	0559f363          	bgeu	s3,s5,80002b10 <readi+0xbe>
    uint addr = bmap(ip, off/BSIZE);
    80002ace:	00a4d59b          	srliw	a1,s1,0xa
    80002ad2:	855a                	mv	a0,s6
    80002ad4:	8b3ff0ef          	jal	80002386 <bmap>
    80002ad8:	85aa                	mv	a1,a0
    if(addr == 0)
    80002ada:	c139                	beqz	a0,80002b20 <readi+0xce>
    bp = bread(ip->dev, addr);
    80002adc:	000b2503          	lw	a0,0(s6)
    80002ae0:	d40ff0ef          	jal	80002020 <bread>
    80002ae4:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002ae6:	3ff4f793          	andi	a5,s1,1023
    80002aea:	40fc873b          	subw	a4,s9,a5
    80002aee:	413a86bb          	subw	a3,s5,s3
    80002af2:	8d3a                	mv	s10,a4
    80002af4:	fae6f5e3          	bgeu	a3,a4,80002a9e <readi+0x4c>
    80002af8:	8d36                	mv	s10,a3
    80002afa:	b755                	j	80002a9e <readi+0x4c>
      brelse(bp);
    80002afc:	854a                	mv	a0,s2
    80002afe:	e2aff0ef          	jal	80002128 <brelse>
      tot = -1;
    80002b02:	59fd                	li	s3,-1
      break;
    80002b04:	6946                	ld	s2,80(sp)
    80002b06:	7c02                	ld	s8,32(sp)
    80002b08:	6ce2                	ld	s9,24(sp)
    80002b0a:	6d42                	ld	s10,16(sp)
    80002b0c:	6da2                	ld	s11,8(sp)
    80002b0e:	a831                	j	80002b2a <readi+0xd8>
    80002b10:	6946                	ld	s2,80(sp)
    80002b12:	7c02                	ld	s8,32(sp)
    80002b14:	6ce2                	ld	s9,24(sp)
    80002b16:	6d42                	ld	s10,16(sp)
    80002b18:	6da2                	ld	s11,8(sp)
    80002b1a:	a801                	j	80002b2a <readi+0xd8>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002b1c:	89d6                	mv	s3,s5
    80002b1e:	a031                	j	80002b2a <readi+0xd8>
    80002b20:	6946                	ld	s2,80(sp)
    80002b22:	7c02                	ld	s8,32(sp)
    80002b24:	6ce2                	ld	s9,24(sp)
    80002b26:	6d42                	ld	s10,16(sp)
    80002b28:	6da2                	ld	s11,8(sp)
  }
  return tot;
    80002b2a:	854e                	mv	a0,s3
    80002b2c:	69a6                	ld	s3,72(sp)
}
    80002b2e:	70a6                	ld	ra,104(sp)
    80002b30:	7406                	ld	s0,96(sp)
    80002b32:	64e6                	ld	s1,88(sp)
    80002b34:	6a06                	ld	s4,64(sp)
    80002b36:	7ae2                	ld	s5,56(sp)
    80002b38:	7b42                	ld	s6,48(sp)
    80002b3a:	7ba2                	ld	s7,40(sp)
    80002b3c:	6165                	addi	sp,sp,112
    80002b3e:	8082                	ret
    return 0;
    80002b40:	4501                	li	a0,0
}
    80002b42:	8082                	ret

0000000080002b44 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002b44:	457c                	lw	a5,76(a0)
    80002b46:	0ed7ee63          	bltu	a5,a3,80002c42 <writei+0xfe>
{
    80002b4a:	7159                	addi	sp,sp,-112
    80002b4c:	f486                	sd	ra,104(sp)
    80002b4e:	f0a2                	sd	s0,96(sp)
    80002b50:	e8ca                	sd	s2,80(sp)
    80002b52:	e0d2                	sd	s4,64(sp)
    80002b54:	fc56                	sd	s5,56(sp)
    80002b56:	f85a                	sd	s6,48(sp)
    80002b58:	f45e                	sd	s7,40(sp)
    80002b5a:	1880                	addi	s0,sp,112
    80002b5c:	8aaa                	mv	s5,a0
    80002b5e:	8bae                	mv	s7,a1
    80002b60:	8a32                	mv	s4,a2
    80002b62:	8936                	mv	s2,a3
    80002b64:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002b66:	9f35                	addw	a4,a4,a3
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80002b68:	000437b7          	lui	a5,0x43
    80002b6c:	00e7b7b3          	sltu	a5,a5,a4
  if(off > ip->size || off + n < off)
    80002b70:	00d73733          	sltu	a4,a4,a3
  if(off + n > MAXFILE*BSIZE)
    80002b74:	8fd9                	or	a5,a5,a4
    80002b76:	ef91                	bnez	a5,80002b92 <writei+0x4e>
    80002b78:	e4ce                	sd	s3,72(sp)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002b7a:	0a0b0c63          	beqz	s6,80002c32 <writei+0xee>
    80002b7e:	eca6                	sd	s1,88(sp)
    80002b80:	f062                	sd	s8,32(sp)
    80002b82:	ec66                	sd	s9,24(sp)
    80002b84:	e86a                	sd	s10,16(sp)
    80002b86:	e46e                	sd	s11,8(sp)
    80002b88:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002b8a:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002b8e:	5c7d                	li	s8,-1
    80002b90:	a835                	j	80002bcc <writei+0x88>
    return -1;
    80002b92:	557d                	li	a0,-1
    80002b94:	a071                	j	80002c20 <writei+0xdc>
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002b96:	020d1d93          	slli	s11,s10,0x20
    80002b9a:	020ddd93          	srli	s11,s11,0x20
    80002b9e:	05848513          	addi	a0,s1,88
    80002ba2:	86ee                	mv	a3,s11
    80002ba4:	8652                	mv	a2,s4
    80002ba6:	85de                	mv	a1,s7
    80002ba8:	953e                	add	a0,a0,a5
    80002baa:	b3ffe0ef          	jal	800016e8 <either_copyin>
    80002bae:	05850663          	beq	a0,s8,80002bfa <writei+0xb6>
      brelse(bp);
      break;
    }
    log_write(bp);
    80002bb2:	8526                	mv	a0,s1
    80002bb4:	6bc000ef          	jal	80003270 <log_write>
    brelse(bp);
    80002bb8:	8526                	mv	a0,s1
    80002bba:	d6eff0ef          	jal	80002128 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002bbe:	013d09bb          	addw	s3,s10,s3
    80002bc2:	012d093b          	addw	s2,s10,s2
    80002bc6:	9a6e                	add	s4,s4,s11
    80002bc8:	0369fc63          	bgeu	s3,s6,80002c00 <writei+0xbc>
    uint addr = bmap(ip, off/BSIZE);
    80002bcc:	00a9559b          	srliw	a1,s2,0xa
    80002bd0:	8556                	mv	a0,s5
    80002bd2:	fb4ff0ef          	jal	80002386 <bmap>
    80002bd6:	85aa                	mv	a1,a0
    if(addr == 0)
    80002bd8:	c505                	beqz	a0,80002c00 <writei+0xbc>
    bp = bread(ip->dev, addr);
    80002bda:	000aa503          	lw	a0,0(s5)
    80002bde:	c42ff0ef          	jal	80002020 <bread>
    80002be2:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002be4:	3ff97793          	andi	a5,s2,1023
    80002be8:	40fc873b          	subw	a4,s9,a5
    80002bec:	413b06bb          	subw	a3,s6,s3
    80002bf0:	8d3a                	mv	s10,a4
    80002bf2:	fae6f2e3          	bgeu	a3,a4,80002b96 <writei+0x52>
    80002bf6:	8d36                	mv	s10,a3
    80002bf8:	bf79                	j	80002b96 <writei+0x52>
      brelse(bp);
    80002bfa:	8526                	mv	a0,s1
    80002bfc:	d2cff0ef          	jal	80002128 <brelse>
  }

  if(off > ip->size)
    80002c00:	04caa783          	lw	a5,76(s5)
    80002c04:	0327f963          	bgeu	a5,s2,80002c36 <writei+0xf2>
    ip->size = off;
    80002c08:	052aa623          	sw	s2,76(s5)
    80002c0c:	64e6                	ld	s1,88(sp)
    80002c0e:	7c02                	ld	s8,32(sp)
    80002c10:	6ce2                	ld	s9,24(sp)
    80002c12:	6d42                	ld	s10,16(sp)
    80002c14:	6da2                	ld	s11,8(sp)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80002c16:	8556                	mv	a0,s5
    80002c18:	9f5ff0ef          	jal	8000260c <iupdate>

  return tot;
    80002c1c:	854e                	mv	a0,s3
    80002c1e:	69a6                	ld	s3,72(sp)
}
    80002c20:	70a6                	ld	ra,104(sp)
    80002c22:	7406                	ld	s0,96(sp)
    80002c24:	6946                	ld	s2,80(sp)
    80002c26:	6a06                	ld	s4,64(sp)
    80002c28:	7ae2                	ld	s5,56(sp)
    80002c2a:	7b42                	ld	s6,48(sp)
    80002c2c:	7ba2                	ld	s7,40(sp)
    80002c2e:	6165                	addi	sp,sp,112
    80002c30:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002c32:	89da                	mv	s3,s6
    80002c34:	b7cd                	j	80002c16 <writei+0xd2>
    80002c36:	64e6                	ld	s1,88(sp)
    80002c38:	7c02                	ld	s8,32(sp)
    80002c3a:	6ce2                	ld	s9,24(sp)
    80002c3c:	6d42                	ld	s10,16(sp)
    80002c3e:	6da2                	ld	s11,8(sp)
    80002c40:	bfd9                	j	80002c16 <writei+0xd2>
    return -1;
    80002c42:	557d                	li	a0,-1
}
    80002c44:	8082                	ret

0000000080002c46 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80002c46:	1141                	addi	sp,sp,-16
    80002c48:	e406                	sd	ra,8(sp)
    80002c4a:	e022                	sd	s0,0(sp)
    80002c4c:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80002c4e:	4639                	li	a2,14
    80002c50:	dbefd0ef          	jal	8000020e <strncmp>
}
    80002c54:	60a2                	ld	ra,8(sp)
    80002c56:	6402                	ld	s0,0(sp)
    80002c58:	0141                	addi	sp,sp,16
    80002c5a:	8082                	ret

0000000080002c5c <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80002c5c:	711d                	addi	sp,sp,-96
    80002c5e:	ec86                	sd	ra,88(sp)
    80002c60:	e8a2                	sd	s0,80(sp)
    80002c62:	e4a6                	sd	s1,72(sp)
    80002c64:	e0ca                	sd	s2,64(sp)
    80002c66:	fc4e                	sd	s3,56(sp)
    80002c68:	f852                	sd	s4,48(sp)
    80002c6a:	f456                	sd	s5,40(sp)
    80002c6c:	f05a                	sd	s6,32(sp)
    80002c6e:	ec5e                	sd	s7,24(sp)
    80002c70:	1080                	addi	s0,sp,96
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80002c72:	04451703          	lh	a4,68(a0)
    80002c76:	4785                	li	a5,1
    80002c78:	02f71963          	bne	a4,a5,80002caa <dirlookup+0x4e>
    80002c7c:	892a                	mv	s2,a0
    80002c7e:	8aae                	mv	s5,a1
    80002c80:	8bb2                	mv	s7,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80002c82:	457c                	lw	a5,76(a0)
    80002c84:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002c86:	fa040a13          	addi	s4,s0,-96
    80002c8a:	49c1                	li	s3,16
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
    80002c8c:	fa240b13          	addi	s6,s0,-94
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002c90:	ef95                	bnez	a5,80002ccc <dirlookup+0x70>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80002c92:	4501                	li	a0,0
}
    80002c94:	60e6                	ld	ra,88(sp)
    80002c96:	6446                	ld	s0,80(sp)
    80002c98:	64a6                	ld	s1,72(sp)
    80002c9a:	6906                	ld	s2,64(sp)
    80002c9c:	79e2                	ld	s3,56(sp)
    80002c9e:	7a42                	ld	s4,48(sp)
    80002ca0:	7aa2                	ld	s5,40(sp)
    80002ca2:	7b02                	ld	s6,32(sp)
    80002ca4:	6be2                	ld	s7,24(sp)
    80002ca6:	6125                	addi	sp,sp,96
    80002ca8:	8082                	ret
    panic("dirlookup not DIR");
    80002caa:	00004517          	auipc	a0,0x4
    80002cae:	7ae50513          	addi	a0,a0,1966 # 80007458 <etext+0x458>
    80002cb2:	163020ef          	jal	80005614 <panic>
      panic("dirlookup read");
    80002cb6:	00004517          	auipc	a0,0x4
    80002cba:	7ba50513          	addi	a0,a0,1978 # 80007470 <etext+0x470>
    80002cbe:	157020ef          	jal	80005614 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002cc2:	24c1                	addiw	s1,s1,16
    80002cc4:	04c92783          	lw	a5,76(s2)
    80002cc8:	fcf4f5e3          	bgeu	s1,a5,80002c92 <dirlookup+0x36>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002ccc:	874e                	mv	a4,s3
    80002cce:	86a6                	mv	a3,s1
    80002cd0:	8652                	mv	a2,s4
    80002cd2:	4581                	li	a1,0
    80002cd4:	854a                	mv	a0,s2
    80002cd6:	d7dff0ef          	jal	80002a52 <readi>
    80002cda:	fd351ee3          	bne	a0,s3,80002cb6 <dirlookup+0x5a>
    if(de.inum == 0)
    80002cde:	fa045783          	lhu	a5,-96(s0)
    80002ce2:	d3e5                	beqz	a5,80002cc2 <dirlookup+0x66>
    if(namecmp(name, de.name) == 0){
    80002ce4:	85da                	mv	a1,s6
    80002ce6:	8556                	mv	a0,s5
    80002ce8:	f5fff0ef          	jal	80002c46 <namecmp>
    80002cec:	f979                	bnez	a0,80002cc2 <dirlookup+0x66>
      if(poff)
    80002cee:	000b8463          	beqz	s7,80002cf6 <dirlookup+0x9a>
        *poff = off;
    80002cf2:	009ba023          	sw	s1,0(s7)
      return iget(dp->dev, inum);
    80002cf6:	fa045583          	lhu	a1,-96(s0)
    80002cfa:	00092503          	lw	a0,0(s2)
    80002cfe:	f48ff0ef          	jal	80002446 <iget>
    80002d02:	bf49                	j	80002c94 <dirlookup+0x38>

0000000080002d04 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80002d04:	711d                	addi	sp,sp,-96
    80002d06:	ec86                	sd	ra,88(sp)
    80002d08:	e8a2                	sd	s0,80(sp)
    80002d0a:	e4a6                	sd	s1,72(sp)
    80002d0c:	e0ca                	sd	s2,64(sp)
    80002d0e:	fc4e                	sd	s3,56(sp)
    80002d10:	f852                	sd	s4,48(sp)
    80002d12:	f456                	sd	s5,40(sp)
    80002d14:	f05a                	sd	s6,32(sp)
    80002d16:	ec5e                	sd	s7,24(sp)
    80002d18:	e862                	sd	s8,16(sp)
    80002d1a:	e466                	sd	s9,8(sp)
    80002d1c:	e06a                	sd	s10,0(sp)
    80002d1e:	1080                	addi	s0,sp,96
    80002d20:	84aa                	mv	s1,a0
    80002d22:	8b2e                	mv	s6,a1
    80002d24:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80002d26:	00054703          	lbu	a4,0(a0)
    80002d2a:	02f00793          	li	a5,47
    80002d2e:	00f70f63          	beq	a4,a5,80002d4c <namex+0x48>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80002d32:	812fe0ef          	jal	80000d44 <myproc>
    80002d36:	15053503          	ld	a0,336(a0)
    80002d3a:	951ff0ef          	jal	8000268a <idup>
    80002d3e:	8a2a                	mv	s4,a0
  while(*path == '/')
    80002d40:	02f00993          	li	s3,47
  if(len >= DIRSIZ)
    80002d44:	4c35                	li	s8,13
    memmove(name, s, DIRSIZ);
    80002d46:	4cb9                	li	s9,14

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80002d48:	4b85                	li	s7,1
    80002d4a:	a879                	j	80002de8 <namex+0xe4>
    ip = iget(ROOTDEV, ROOTINO);
    80002d4c:	4585                	li	a1,1
    80002d4e:	852e                	mv	a0,a1
    80002d50:	ef6ff0ef          	jal	80002446 <iget>
    80002d54:	8a2a                	mv	s4,a0
    80002d56:	b7ed                	j	80002d40 <namex+0x3c>
      iunlockput(ip);
    80002d58:	8552                	mv	a0,s4
    80002d5a:	b73ff0ef          	jal	800028cc <iunlockput>
      return 0;
    80002d5e:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80002d60:	8552                	mv	a0,s4
    80002d62:	60e6                	ld	ra,88(sp)
    80002d64:	6446                	ld	s0,80(sp)
    80002d66:	64a6                	ld	s1,72(sp)
    80002d68:	6906                	ld	s2,64(sp)
    80002d6a:	79e2                	ld	s3,56(sp)
    80002d6c:	7a42                	ld	s4,48(sp)
    80002d6e:	7aa2                	ld	s5,40(sp)
    80002d70:	7b02                	ld	s6,32(sp)
    80002d72:	6be2                	ld	s7,24(sp)
    80002d74:	6c42                	ld	s8,16(sp)
    80002d76:	6ca2                	ld	s9,8(sp)
    80002d78:	6d02                	ld	s10,0(sp)
    80002d7a:	6125                	addi	sp,sp,96
    80002d7c:	8082                	ret
      iunlock(ip);
    80002d7e:	8552                	mv	a0,s4
    80002d80:	9efff0ef          	jal	8000276e <iunlock>
      return ip;
    80002d84:	bff1                	j	80002d60 <namex+0x5c>
      iunlockput(ip);
    80002d86:	8552                	mv	a0,s4
    80002d88:	b45ff0ef          	jal	800028cc <iunlockput>
      return 0;
    80002d8c:	8a4a                	mv	s4,s2
    80002d8e:	bfc9                	j	80002d60 <namex+0x5c>
  while(*path != '/' && *path != 0)
    80002d90:	8926                	mv	s2,s1
  len = path - s;
    80002d92:	4d01                	li	s10,0
    80002d94:	4601                	li	a2,0
    memmove(name, s, len);
    80002d96:	2601                	sext.w	a2,a2
    80002d98:	85a6                	mv	a1,s1
    80002d9a:	8556                	mv	a0,s5
    80002d9c:	bfefd0ef          	jal	8000019a <memmove>
    name[len] = 0;
    80002da0:	9d56                	add	s10,s10,s5
    80002da2:	000d0023          	sb	zero,0(s10) # fffffffffffff000 <end+0xffffffff7ffdc278>
    80002da6:	84ca                	mv	s1,s2
  while(*path == '/')
    80002da8:	0004c783          	lbu	a5,0(s1)
    80002dac:	01379763          	bne	a5,s3,80002dba <namex+0xb6>
    path++;
    80002db0:	0485                	addi	s1,s1,1
  while(*path == '/')
    80002db2:	0004c783          	lbu	a5,0(s1)
    80002db6:	ff378de3          	beq	a5,s3,80002db0 <namex+0xac>
    ilock(ip);
    80002dba:	8552                	mv	a0,s4
    80002dbc:	905ff0ef          	jal	800026c0 <ilock>
    if(ip->type != T_DIR){
    80002dc0:	044a1783          	lh	a5,68(s4)
    80002dc4:	f9779ae3          	bne	a5,s7,80002d58 <namex+0x54>
    if(nameiparent && *path == '\0'){
    80002dc8:	000b0563          	beqz	s6,80002dd2 <namex+0xce>
    80002dcc:	0004c783          	lbu	a5,0(s1)
    80002dd0:	d7dd                	beqz	a5,80002d7e <namex+0x7a>
    if((next = dirlookup(ip, name, 0)) == 0){
    80002dd2:	4601                	li	a2,0
    80002dd4:	85d6                	mv	a1,s5
    80002dd6:	8552                	mv	a0,s4
    80002dd8:	e85ff0ef          	jal	80002c5c <dirlookup>
    80002ddc:	892a                	mv	s2,a0
    80002dde:	d545                	beqz	a0,80002d86 <namex+0x82>
    iunlockput(ip);
    80002de0:	8552                	mv	a0,s4
    80002de2:	aebff0ef          	jal	800028cc <iunlockput>
    ip = next;
    80002de6:	8a4a                	mv	s4,s2
  while(*path == '/')
    80002de8:	0004c783          	lbu	a5,0(s1)
    80002dec:	01379763          	bne	a5,s3,80002dfa <namex+0xf6>
    path++;
    80002df0:	0485                	addi	s1,s1,1
  while(*path == '/')
    80002df2:	0004c783          	lbu	a5,0(s1)
    80002df6:	ff378de3          	beq	a5,s3,80002df0 <namex+0xec>
  if(*path == 0)
    80002dfa:	c7a1                	beqz	a5,80002e42 <namex+0x13e>
  while(*path != '/' && *path != 0)
    80002dfc:	0004c703          	lbu	a4,0(s1)
    80002e00:	fd170793          	addi	a5,a4,-47
    80002e04:	00f037b3          	snez	a5,a5
    80002e08:	00e03733          	snez	a4,a4
    80002e0c:	8ff9                	and	a5,a5,a4
    80002e0e:	d3c9                	beqz	a5,80002d90 <namex+0x8c>
    80002e10:	8926                	mv	s2,s1
    path++;
    80002e12:	0905                	addi	s2,s2,1
  while(*path != '/' && *path != 0)
    80002e14:	00094703          	lbu	a4,0(s2)
    80002e18:	fd170793          	addi	a5,a4,-47
    80002e1c:	00f037b3          	snez	a5,a5
    80002e20:	00e03733          	snez	a4,a4
    80002e24:	8ff9                	and	a5,a5,a4
    80002e26:	f7f5                	bnez	a5,80002e12 <namex+0x10e>
  len = path - s;
    80002e28:	40990633          	sub	a2,s2,s1
    80002e2c:	00060d1b          	sext.w	s10,a2
  if(len >= DIRSIZ)
    80002e30:	f7ac53e3          	bge	s8,s10,80002d96 <namex+0x92>
    memmove(name, s, DIRSIZ);
    80002e34:	8666                	mv	a2,s9
    80002e36:	85a6                	mv	a1,s1
    80002e38:	8556                	mv	a0,s5
    80002e3a:	b60fd0ef          	jal	8000019a <memmove>
    80002e3e:	84ca                	mv	s1,s2
    80002e40:	b7a5                	j	80002da8 <namex+0xa4>
  if(nameiparent){
    80002e42:	f00b0fe3          	beqz	s6,80002d60 <namex+0x5c>
    iput(ip);
    80002e46:	8552                	mv	a0,s4
    80002e48:	9fbff0ef          	jal	80002842 <iput>
    return 0;
    80002e4c:	bf09                	j	80002d5e <namex+0x5a>

0000000080002e4e <dirlink>:
{
    80002e4e:	715d                	addi	sp,sp,-80
    80002e50:	e486                	sd	ra,72(sp)
    80002e52:	e0a2                	sd	s0,64(sp)
    80002e54:	f84a                	sd	s2,48(sp)
    80002e56:	ec56                	sd	s5,24(sp)
    80002e58:	e85a                	sd	s6,16(sp)
    80002e5a:	0880                	addi	s0,sp,80
    80002e5c:	892a                	mv	s2,a0
    80002e5e:	8aae                	mv	s5,a1
    80002e60:	8b32                	mv	s6,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80002e62:	4601                	li	a2,0
    80002e64:	df9ff0ef          	jal	80002c5c <dirlookup>
    80002e68:	ed1d                	bnez	a0,80002ea6 <dirlink+0x58>
    80002e6a:	fc26                	sd	s1,56(sp)
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002e6c:	04c92483          	lw	s1,76(s2)
    80002e70:	c4b9                	beqz	s1,80002ebe <dirlink+0x70>
    80002e72:	f44e                	sd	s3,40(sp)
    80002e74:	f052                	sd	s4,32(sp)
    80002e76:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002e78:	fb040a13          	addi	s4,s0,-80
    80002e7c:	49c1                	li	s3,16
    80002e7e:	874e                	mv	a4,s3
    80002e80:	86a6                	mv	a3,s1
    80002e82:	8652                	mv	a2,s4
    80002e84:	4581                	li	a1,0
    80002e86:	854a                	mv	a0,s2
    80002e88:	bcbff0ef          	jal	80002a52 <readi>
    80002e8c:	03351163          	bne	a0,s3,80002eae <dirlink+0x60>
    if(de.inum == 0)
    80002e90:	fb045783          	lhu	a5,-80(s0)
    80002e94:	c39d                	beqz	a5,80002eba <dirlink+0x6c>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002e96:	24c1                	addiw	s1,s1,16
    80002e98:	04c92783          	lw	a5,76(s2)
    80002e9c:	fef4e1e3          	bltu	s1,a5,80002e7e <dirlink+0x30>
    80002ea0:	79a2                	ld	s3,40(sp)
    80002ea2:	7a02                	ld	s4,32(sp)
    80002ea4:	a829                	j	80002ebe <dirlink+0x70>
    iput(ip);
    80002ea6:	99dff0ef          	jal	80002842 <iput>
    return -1;
    80002eaa:	557d                	li	a0,-1
    80002eac:	a83d                	j	80002eea <dirlink+0x9c>
      panic("dirlink read");
    80002eae:	00004517          	auipc	a0,0x4
    80002eb2:	5d250513          	addi	a0,a0,1490 # 80007480 <etext+0x480>
    80002eb6:	75e020ef          	jal	80005614 <panic>
    80002eba:	79a2                	ld	s3,40(sp)
    80002ebc:	7a02                	ld	s4,32(sp)
  strncpy(de.name, name, DIRSIZ);
    80002ebe:	4639                	li	a2,14
    80002ec0:	85d6                	mv	a1,s5
    80002ec2:	fb240513          	addi	a0,s0,-78
    80002ec6:	b7efd0ef          	jal	80000244 <strncpy>
  de.inum = inum;
    80002eca:	fb641823          	sh	s6,-80(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002ece:	4741                	li	a4,16
    80002ed0:	86a6                	mv	a3,s1
    80002ed2:	fb040613          	addi	a2,s0,-80
    80002ed6:	4581                	li	a1,0
    80002ed8:	854a                	mv	a0,s2
    80002eda:	c6bff0ef          	jal	80002b44 <writei>
    80002ede:	1541                	addi	a0,a0,-16
    80002ee0:	00a03533          	snez	a0,a0
    80002ee4:	40a0053b          	negw	a0,a0
    80002ee8:	74e2                	ld	s1,56(sp)
}
    80002eea:	60a6                	ld	ra,72(sp)
    80002eec:	6406                	ld	s0,64(sp)
    80002eee:	7942                	ld	s2,48(sp)
    80002ef0:	6ae2                	ld	s5,24(sp)
    80002ef2:	6b42                	ld	s6,16(sp)
    80002ef4:	6161                	addi	sp,sp,80
    80002ef6:	8082                	ret

0000000080002ef8 <namei>:

struct inode*
namei(char *path)
{
    80002ef8:	1101                	addi	sp,sp,-32
    80002efa:	ec06                	sd	ra,24(sp)
    80002efc:	e822                	sd	s0,16(sp)
    80002efe:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80002f00:	fe040613          	addi	a2,s0,-32
    80002f04:	4581                	li	a1,0
    80002f06:	dffff0ef          	jal	80002d04 <namex>
}
    80002f0a:	60e2                	ld	ra,24(sp)
    80002f0c:	6442                	ld	s0,16(sp)
    80002f0e:	6105                	addi	sp,sp,32
    80002f10:	8082                	ret

0000000080002f12 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80002f12:	1141                	addi	sp,sp,-16
    80002f14:	e406                	sd	ra,8(sp)
    80002f16:	e022                	sd	s0,0(sp)
    80002f18:	0800                	addi	s0,sp,16
    80002f1a:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80002f1c:	4585                	li	a1,1
    80002f1e:	de7ff0ef          	jal	80002d04 <namex>
}
    80002f22:	60a2                	ld	ra,8(sp)
    80002f24:	6402                	ld	s0,0(sp)
    80002f26:	0141                	addi	sp,sp,16
    80002f28:	8082                	ret

0000000080002f2a <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80002f2a:	1101                	addi	sp,sp,-32
    80002f2c:	ec06                	sd	ra,24(sp)
    80002f2e:	e822                	sd	s0,16(sp)
    80002f30:	e426                	sd	s1,8(sp)
    80002f32:	e04a                	sd	s2,0(sp)
    80002f34:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80002f36:	00017917          	auipc	s2,0x17
    80002f3a:	b3a90913          	addi	s2,s2,-1222 # 80019a70 <log>
    80002f3e:	01892583          	lw	a1,24(s2)
    80002f42:	02492503          	lw	a0,36(s2)
    80002f46:	8daff0ef          	jal	80002020 <bread>
    80002f4a:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80002f4c:	02892603          	lw	a2,40(s2)
    80002f50:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80002f52:	00c05f63          	blez	a2,80002f70 <write_head+0x46>
    80002f56:	00017717          	auipc	a4,0x17
    80002f5a:	b4670713          	addi	a4,a4,-1210 # 80019a9c <log+0x2c>
    80002f5e:	87aa                	mv	a5,a0
    80002f60:	060a                	slli	a2,a2,0x2
    80002f62:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    80002f64:	4314                	lw	a3,0(a4)
    80002f66:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    80002f68:	0711                	addi	a4,a4,4
    80002f6a:	0791                	addi	a5,a5,4 # 43004 <_entry-0x7ffbcffc>
    80002f6c:	fec79ce3          	bne	a5,a2,80002f64 <write_head+0x3a>
  }
  bwrite(buf);
    80002f70:	8526                	mv	a0,s1
    80002f72:	984ff0ef          	jal	800020f6 <bwrite>
  brelse(buf);
    80002f76:	8526                	mv	a0,s1
    80002f78:	9b0ff0ef          	jal	80002128 <brelse>
}
    80002f7c:	60e2                	ld	ra,24(sp)
    80002f7e:	6442                	ld	s0,16(sp)
    80002f80:	64a2                	ld	s1,8(sp)
    80002f82:	6902                	ld	s2,0(sp)
    80002f84:	6105                	addi	sp,sp,32
    80002f86:	8082                	ret

0000000080002f88 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80002f88:	00017797          	auipc	a5,0x17
    80002f8c:	b107a783          	lw	a5,-1264(a5) # 80019a98 <log+0x28>
    80002f90:	0cf05163          	blez	a5,80003052 <install_trans+0xca>
{
    80002f94:	715d                	addi	sp,sp,-80
    80002f96:	e486                	sd	ra,72(sp)
    80002f98:	e0a2                	sd	s0,64(sp)
    80002f9a:	fc26                	sd	s1,56(sp)
    80002f9c:	f84a                	sd	s2,48(sp)
    80002f9e:	f44e                	sd	s3,40(sp)
    80002fa0:	f052                	sd	s4,32(sp)
    80002fa2:	ec56                	sd	s5,24(sp)
    80002fa4:	e85a                	sd	s6,16(sp)
    80002fa6:	e45e                	sd	s7,8(sp)
    80002fa8:	e062                	sd	s8,0(sp)
    80002faa:	0880                	addi	s0,sp,80
    80002fac:	8b2a                	mv	s6,a0
    80002fae:	00017a97          	auipc	s5,0x17
    80002fb2:	aeea8a93          	addi	s5,s5,-1298 # 80019a9c <log+0x2c>
  for (tail = 0; tail < log.lh.n; tail++) {
    80002fb6:	4981                	li	s3,0
      printf("recovering tail %d dst %d\n", tail, log.lh.block[tail]);
    80002fb8:	00004c17          	auipc	s8,0x4
    80002fbc:	4d8c0c13          	addi	s8,s8,1240 # 80007490 <etext+0x490>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80002fc0:	00017a17          	auipc	s4,0x17
    80002fc4:	ab0a0a13          	addi	s4,s4,-1360 # 80019a70 <log>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80002fc8:	40000b93          	li	s7,1024
    80002fcc:	a025                	j	80002ff4 <install_trans+0x6c>
      printf("recovering tail %d dst %d\n", tail, log.lh.block[tail]);
    80002fce:	000aa603          	lw	a2,0(s5)
    80002fd2:	85ce                	mv	a1,s3
    80002fd4:	8562                	mv	a0,s8
    80002fd6:	306020ef          	jal	800052dc <printf>
    80002fda:	a839                	j	80002ff8 <install_trans+0x70>
    brelse(lbuf);
    80002fdc:	854a                	mv	a0,s2
    80002fde:	94aff0ef          	jal	80002128 <brelse>
    brelse(dbuf);
    80002fe2:	8526                	mv	a0,s1
    80002fe4:	944ff0ef          	jal	80002128 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80002fe8:	2985                	addiw	s3,s3,1
    80002fea:	0a91                	addi	s5,s5,4
    80002fec:	028a2783          	lw	a5,40(s4)
    80002ff0:	04f9d563          	bge	s3,a5,8000303a <install_trans+0xb2>
    if(recovering) {
    80002ff4:	fc0b1de3          	bnez	s6,80002fce <install_trans+0x46>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80002ff8:	018a2583          	lw	a1,24(s4)
    80002ffc:	013585bb          	addw	a1,a1,s3
    80003000:	2585                	addiw	a1,a1,1
    80003002:	024a2503          	lw	a0,36(s4)
    80003006:	81aff0ef          	jal	80002020 <bread>
    8000300a:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    8000300c:	000aa583          	lw	a1,0(s5)
    80003010:	024a2503          	lw	a0,36(s4)
    80003014:	80cff0ef          	jal	80002020 <bread>
    80003018:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    8000301a:	865e                	mv	a2,s7
    8000301c:	05890593          	addi	a1,s2,88
    80003020:	05850513          	addi	a0,a0,88
    80003024:	976fd0ef          	jal	8000019a <memmove>
    bwrite(dbuf);  // write dst to disk
    80003028:	8526                	mv	a0,s1
    8000302a:	8ccff0ef          	jal	800020f6 <bwrite>
    if(recovering == 0)
    8000302e:	fa0b17e3          	bnez	s6,80002fdc <install_trans+0x54>
      bunpin(dbuf);
    80003032:	8526                	mv	a0,s1
    80003034:	9acff0ef          	jal	800021e0 <bunpin>
    80003038:	b755                	j	80002fdc <install_trans+0x54>
}
    8000303a:	60a6                	ld	ra,72(sp)
    8000303c:	6406                	ld	s0,64(sp)
    8000303e:	74e2                	ld	s1,56(sp)
    80003040:	7942                	ld	s2,48(sp)
    80003042:	79a2                	ld	s3,40(sp)
    80003044:	7a02                	ld	s4,32(sp)
    80003046:	6ae2                	ld	s5,24(sp)
    80003048:	6b42                	ld	s6,16(sp)
    8000304a:	6ba2                	ld	s7,8(sp)
    8000304c:	6c02                	ld	s8,0(sp)
    8000304e:	6161                	addi	sp,sp,80
    80003050:	8082                	ret
    80003052:	8082                	ret

0000000080003054 <initlog>:
{
    80003054:	7179                	addi	sp,sp,-48
    80003056:	f406                	sd	ra,40(sp)
    80003058:	f022                	sd	s0,32(sp)
    8000305a:	ec26                	sd	s1,24(sp)
    8000305c:	e84a                	sd	s2,16(sp)
    8000305e:	e44e                	sd	s3,8(sp)
    80003060:	1800                	addi	s0,sp,48
    80003062:	84aa                	mv	s1,a0
    80003064:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003066:	00017917          	auipc	s2,0x17
    8000306a:	a0a90913          	addi	s2,s2,-1526 # 80019a70 <log>
    8000306e:	00004597          	auipc	a1,0x4
    80003072:	44258593          	addi	a1,a1,1090 # 800074b0 <etext+0x4b0>
    80003076:	854a                	mv	a0,s2
    80003078:	7d0020ef          	jal	80005848 <initlock>
  log.start = sb->logstart;
    8000307c:	0149a583          	lw	a1,20(s3)
    80003080:	00b92c23          	sw	a1,24(s2)
  log.dev = dev;
    80003084:	02992223          	sw	s1,36(s2)
  struct buf *buf = bread(log.dev, log.start);
    80003088:	8526                	mv	a0,s1
    8000308a:	f97fe0ef          	jal	80002020 <bread>
  log.lh.n = lh->n;
    8000308e:	4d30                	lw	a2,88(a0)
    80003090:	02c92423          	sw	a2,40(s2)
  for (i = 0; i < log.lh.n; i++) {
    80003094:	00c05f63          	blez	a2,800030b2 <initlog+0x5e>
    80003098:	87aa                	mv	a5,a0
    8000309a:	00017717          	auipc	a4,0x17
    8000309e:	a0270713          	addi	a4,a4,-1534 # 80019a9c <log+0x2c>
    800030a2:	060a                	slli	a2,a2,0x2
    800030a4:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    800030a6:	4ff4                	lw	a3,92(a5)
    800030a8:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    800030aa:	0791                	addi	a5,a5,4
    800030ac:	0711                	addi	a4,a4,4
    800030ae:	fec79ce3          	bne	a5,a2,800030a6 <initlog+0x52>
  brelse(buf);
    800030b2:	876ff0ef          	jal	80002128 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    800030b6:	4505                	li	a0,1
    800030b8:	ed1ff0ef          	jal	80002f88 <install_trans>
  log.lh.n = 0;
    800030bc:	00017797          	auipc	a5,0x17
    800030c0:	9c07ae23          	sw	zero,-1572(a5) # 80019a98 <log+0x28>
  write_head(); // clear the log
    800030c4:	e67ff0ef          	jal	80002f2a <write_head>
}
    800030c8:	70a2                	ld	ra,40(sp)
    800030ca:	7402                	ld	s0,32(sp)
    800030cc:	64e2                	ld	s1,24(sp)
    800030ce:	6942                	ld	s2,16(sp)
    800030d0:	69a2                	ld	s3,8(sp)
    800030d2:	6145                	addi	sp,sp,48
    800030d4:	8082                	ret

00000000800030d6 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    800030d6:	1101                	addi	sp,sp,-32
    800030d8:	ec06                	sd	ra,24(sp)
    800030da:	e822                	sd	s0,16(sp)
    800030dc:	e426                	sd	s1,8(sp)
    800030de:	e04a                	sd	s2,0(sp)
    800030e0:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    800030e2:	00017517          	auipc	a0,0x17
    800030e6:	98e50513          	addi	a0,a0,-1650 # 80019a70 <log>
    800030ea:	7e8020ef          	jal	800058d2 <acquire>
  while(1){
    if(log.committing){
    800030ee:	00017497          	auipc	s1,0x17
    800030f2:	98248493          	addi	s1,s1,-1662 # 80019a70 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGBLOCKS){
    800030f6:	4979                	li	s2,30
    800030f8:	a029                	j	80003102 <begin_op+0x2c>
      sleep(&log, &log.lock);
    800030fa:	85a6                	mv	a1,s1
    800030fc:	8526                	mv	a0,s1
    800030fe:	a48fe0ef          	jal	80001346 <sleep>
    if(log.committing){
    80003102:	509c                	lw	a5,32(s1)
    80003104:	fbfd                	bnez	a5,800030fa <begin_op+0x24>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGBLOCKS){
    80003106:	4cd8                	lw	a4,28(s1)
    80003108:	2705                	addiw	a4,a4,1
    8000310a:	0027179b          	slliw	a5,a4,0x2
    8000310e:	9fb9                	addw	a5,a5,a4
    80003110:	0017979b          	slliw	a5,a5,0x1
    80003114:	5494                	lw	a3,40(s1)
    80003116:	9fb5                	addw	a5,a5,a3
    80003118:	00f95763          	bge	s2,a5,80003126 <begin_op+0x50>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    8000311c:	85a6                	mv	a1,s1
    8000311e:	8526                	mv	a0,s1
    80003120:	a26fe0ef          	jal	80001346 <sleep>
    80003124:	bff9                	j	80003102 <begin_op+0x2c>
    } else {
      log.outstanding += 1;
    80003126:	00017797          	auipc	a5,0x17
    8000312a:	96e7a323          	sw	a4,-1690(a5) # 80019a8c <log+0x1c>
      release(&log.lock);
    8000312e:	00017517          	auipc	a0,0x17
    80003132:	94250513          	addi	a0,a0,-1726 # 80019a70 <log>
    80003136:	02d020ef          	jal	80005962 <release>
      break;
    }
  }
}
    8000313a:	60e2                	ld	ra,24(sp)
    8000313c:	6442                	ld	s0,16(sp)
    8000313e:	64a2                	ld	s1,8(sp)
    80003140:	6902                	ld	s2,0(sp)
    80003142:	6105                	addi	sp,sp,32
    80003144:	8082                	ret

0000000080003146 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003146:	7139                	addi	sp,sp,-64
    80003148:	fc06                	sd	ra,56(sp)
    8000314a:	f822                	sd	s0,48(sp)
    8000314c:	f426                	sd	s1,40(sp)
    8000314e:	f04a                	sd	s2,32(sp)
    80003150:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003152:	00017497          	auipc	s1,0x17
    80003156:	91e48493          	addi	s1,s1,-1762 # 80019a70 <log>
    8000315a:	8526                	mv	a0,s1
    8000315c:	776020ef          	jal	800058d2 <acquire>
  log.outstanding -= 1;
    80003160:	4cdc                	lw	a5,28(s1)
    80003162:	37fd                	addiw	a5,a5,-1
    80003164:	893e                	mv	s2,a5
    80003166:	ccdc                	sw	a5,28(s1)
  if(log.committing)
    80003168:	509c                	lw	a5,32(s1)
    8000316a:	ebb9                	bnez	a5,800031c0 <end_op+0x7a>
    panic("log.committing");
  if(log.outstanding == 0){
    8000316c:	06091363          	bnez	s2,800031d2 <end_op+0x8c>
    do_commit = 1;
    log.committing = 1;
    80003170:	00017497          	auipc	s1,0x17
    80003174:	90048493          	addi	s1,s1,-1792 # 80019a70 <log>
    80003178:	4785                	li	a5,1
    8000317a:	d09c                	sw	a5,32(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    8000317c:	8526                	mv	a0,s1
    8000317e:	7e4020ef          	jal	80005962 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80003182:	549c                	lw	a5,40(s1)
    80003184:	06f04463          	bgtz	a5,800031ec <end_op+0xa6>
    acquire(&log.lock);
    80003188:	00017517          	auipc	a0,0x17
    8000318c:	8e850513          	addi	a0,a0,-1816 # 80019a70 <log>
    80003190:	742020ef          	jal	800058d2 <acquire>
    log.committing = 0;
    80003194:	00017797          	auipc	a5,0x17
    80003198:	8e07ae23          	sw	zero,-1796(a5) # 80019a90 <log+0x20>
    wakeup(&log);
    8000319c:	00017517          	auipc	a0,0x17
    800031a0:	8d450513          	addi	a0,a0,-1836 # 80019a70 <log>
    800031a4:	9eefe0ef          	jal	80001392 <wakeup>
    release(&log.lock);
    800031a8:	00017517          	auipc	a0,0x17
    800031ac:	8c850513          	addi	a0,a0,-1848 # 80019a70 <log>
    800031b0:	7b2020ef          	jal	80005962 <release>
}
    800031b4:	70e2                	ld	ra,56(sp)
    800031b6:	7442                	ld	s0,48(sp)
    800031b8:	74a2                	ld	s1,40(sp)
    800031ba:	7902                	ld	s2,32(sp)
    800031bc:	6121                	addi	sp,sp,64
    800031be:	8082                	ret
    800031c0:	ec4e                	sd	s3,24(sp)
    800031c2:	e852                	sd	s4,16(sp)
    800031c4:	e456                	sd	s5,8(sp)
    panic("log.committing");
    800031c6:	00004517          	auipc	a0,0x4
    800031ca:	2f250513          	addi	a0,a0,754 # 800074b8 <etext+0x4b8>
    800031ce:	446020ef          	jal	80005614 <panic>
    wakeup(&log);
    800031d2:	00017517          	auipc	a0,0x17
    800031d6:	89e50513          	addi	a0,a0,-1890 # 80019a70 <log>
    800031da:	9b8fe0ef          	jal	80001392 <wakeup>
  release(&log.lock);
    800031de:	00017517          	auipc	a0,0x17
    800031e2:	89250513          	addi	a0,a0,-1902 # 80019a70 <log>
    800031e6:	77c020ef          	jal	80005962 <release>
  if(do_commit){
    800031ea:	b7e9                	j	800031b4 <end_op+0x6e>
    800031ec:	ec4e                	sd	s3,24(sp)
    800031ee:	e852                	sd	s4,16(sp)
    800031f0:	e456                	sd	s5,8(sp)
  for (tail = 0; tail < log.lh.n; tail++) {
    800031f2:	00017a97          	auipc	s5,0x17
    800031f6:	8aaa8a93          	addi	s5,s5,-1878 # 80019a9c <log+0x2c>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800031fa:	00017a17          	auipc	s4,0x17
    800031fe:	876a0a13          	addi	s4,s4,-1930 # 80019a70 <log>
    80003202:	018a2583          	lw	a1,24(s4)
    80003206:	012585bb          	addw	a1,a1,s2
    8000320a:	2585                	addiw	a1,a1,1
    8000320c:	024a2503          	lw	a0,36(s4)
    80003210:	e11fe0ef          	jal	80002020 <bread>
    80003214:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80003216:	000aa583          	lw	a1,0(s5)
    8000321a:	024a2503          	lw	a0,36(s4)
    8000321e:	e03fe0ef          	jal	80002020 <bread>
    80003222:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80003224:	40000613          	li	a2,1024
    80003228:	05850593          	addi	a1,a0,88
    8000322c:	05848513          	addi	a0,s1,88
    80003230:	f6bfc0ef          	jal	8000019a <memmove>
    bwrite(to);  // write the log
    80003234:	8526                	mv	a0,s1
    80003236:	ec1fe0ef          	jal	800020f6 <bwrite>
    brelse(from);
    8000323a:	854e                	mv	a0,s3
    8000323c:	eedfe0ef          	jal	80002128 <brelse>
    brelse(to);
    80003240:	8526                	mv	a0,s1
    80003242:	ee7fe0ef          	jal	80002128 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003246:	2905                	addiw	s2,s2,1
    80003248:	0a91                	addi	s5,s5,4
    8000324a:	028a2783          	lw	a5,40(s4)
    8000324e:	faf94ae3          	blt	s2,a5,80003202 <end_op+0xbc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80003252:	cd9ff0ef          	jal	80002f2a <write_head>
    install_trans(0); // Now install writes to home locations
    80003256:	4501                	li	a0,0
    80003258:	d31ff0ef          	jal	80002f88 <install_trans>
    log.lh.n = 0;
    8000325c:	00017797          	auipc	a5,0x17
    80003260:	8207ae23          	sw	zero,-1988(a5) # 80019a98 <log+0x28>
    write_head();    // Erase the transaction from the log
    80003264:	cc7ff0ef          	jal	80002f2a <write_head>
    80003268:	69e2                	ld	s3,24(sp)
    8000326a:	6a42                	ld	s4,16(sp)
    8000326c:	6aa2                	ld	s5,8(sp)
    8000326e:	bf29                	j	80003188 <end_op+0x42>

0000000080003270 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80003270:	1101                	addi	sp,sp,-32
    80003272:	ec06                	sd	ra,24(sp)
    80003274:	e822                	sd	s0,16(sp)
    80003276:	e426                	sd	s1,8(sp)
    80003278:	1000                	addi	s0,sp,32
    8000327a:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    8000327c:	00016517          	auipc	a0,0x16
    80003280:	7f450513          	addi	a0,a0,2036 # 80019a70 <log>
    80003284:	64e020ef          	jal	800058d2 <acquire>
  if (log.lh.n >= LOGBLOCKS)
    80003288:	00017617          	auipc	a2,0x17
    8000328c:	81062603          	lw	a2,-2032(a2) # 80019a98 <log+0x28>
    80003290:	47f5                	li	a5,29
    80003292:	04c7cc63          	blt	a5,a2,800032ea <log_write+0x7a>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80003296:	00016797          	auipc	a5,0x16
    8000329a:	7f67a783          	lw	a5,2038(a5) # 80019a8c <log+0x1c>
    8000329e:	04f05c63          	blez	a5,800032f6 <log_write+0x86>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    800032a2:	4781                	li	a5,0
    800032a4:	04c05f63          	blez	a2,80003302 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorption
    800032a8:	44cc                	lw	a1,12(s1)
    800032aa:	00016717          	auipc	a4,0x16
    800032ae:	7f270713          	addi	a4,a4,2034 # 80019a9c <log+0x2c>
  for (i = 0; i < log.lh.n; i++) {
    800032b2:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    800032b4:	4314                	lw	a3,0(a4)
    800032b6:	04b68663          	beq	a3,a1,80003302 <log_write+0x92>
  for (i = 0; i < log.lh.n; i++) {
    800032ba:	2785                	addiw	a5,a5,1
    800032bc:	0711                	addi	a4,a4,4
    800032be:	fef61be3          	bne	a2,a5,800032b4 <log_write+0x44>
      break;
  }
  log.lh.block[i] = b->blockno;
    800032c2:	0621                	addi	a2,a2,8
    800032c4:	060a                	slli	a2,a2,0x2
    800032c6:	00016797          	auipc	a5,0x16
    800032ca:	7aa78793          	addi	a5,a5,1962 # 80019a70 <log>
    800032ce:	97b2                	add	a5,a5,a2
    800032d0:	44d8                	lw	a4,12(s1)
    800032d2:	c7d8                	sw	a4,12(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    800032d4:	8526                	mv	a0,s1
    800032d6:	ed7fe0ef          	jal	800021ac <bpin>
    log.lh.n++;
    800032da:	00016717          	auipc	a4,0x16
    800032de:	79670713          	addi	a4,a4,1942 # 80019a70 <log>
    800032e2:	571c                	lw	a5,40(a4)
    800032e4:	2785                	addiw	a5,a5,1
    800032e6:	d71c                	sw	a5,40(a4)
    800032e8:	a80d                	j	8000331a <log_write+0xaa>
    panic("too big a transaction");
    800032ea:	00004517          	auipc	a0,0x4
    800032ee:	1de50513          	addi	a0,a0,478 # 800074c8 <etext+0x4c8>
    800032f2:	322020ef          	jal	80005614 <panic>
    panic("log_write outside of trans");
    800032f6:	00004517          	auipc	a0,0x4
    800032fa:	1ea50513          	addi	a0,a0,490 # 800074e0 <etext+0x4e0>
    800032fe:	316020ef          	jal	80005614 <panic>
  log.lh.block[i] = b->blockno;
    80003302:	00878693          	addi	a3,a5,8
    80003306:	068a                	slli	a3,a3,0x2
    80003308:	00016717          	auipc	a4,0x16
    8000330c:	76870713          	addi	a4,a4,1896 # 80019a70 <log>
    80003310:	9736                	add	a4,a4,a3
    80003312:	44d4                	lw	a3,12(s1)
    80003314:	c754                	sw	a3,12(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80003316:	faf60fe3          	beq	a2,a5,800032d4 <log_write+0x64>
  }
  release(&log.lock);
    8000331a:	00016517          	auipc	a0,0x16
    8000331e:	75650513          	addi	a0,a0,1878 # 80019a70 <log>
    80003322:	640020ef          	jal	80005962 <release>
}
    80003326:	60e2                	ld	ra,24(sp)
    80003328:	6442                	ld	s0,16(sp)
    8000332a:	64a2                	ld	s1,8(sp)
    8000332c:	6105                	addi	sp,sp,32
    8000332e:	8082                	ret

0000000080003330 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80003330:	1101                	addi	sp,sp,-32
    80003332:	ec06                	sd	ra,24(sp)
    80003334:	e822                	sd	s0,16(sp)
    80003336:	e426                	sd	s1,8(sp)
    80003338:	e04a                	sd	s2,0(sp)
    8000333a:	1000                	addi	s0,sp,32
    8000333c:	84aa                	mv	s1,a0
    8000333e:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80003340:	00004597          	auipc	a1,0x4
    80003344:	1c058593          	addi	a1,a1,448 # 80007500 <etext+0x500>
    80003348:	0521                	addi	a0,a0,8
    8000334a:	4fe020ef          	jal	80005848 <initlock>
  lk->name = name;
    8000334e:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80003352:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003356:	0204a423          	sw	zero,40(s1)
}
    8000335a:	60e2                	ld	ra,24(sp)
    8000335c:	6442                	ld	s0,16(sp)
    8000335e:	64a2                	ld	s1,8(sp)
    80003360:	6902                	ld	s2,0(sp)
    80003362:	6105                	addi	sp,sp,32
    80003364:	8082                	ret

0000000080003366 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003366:	1101                	addi	sp,sp,-32
    80003368:	ec06                	sd	ra,24(sp)
    8000336a:	e822                	sd	s0,16(sp)
    8000336c:	e426                	sd	s1,8(sp)
    8000336e:	e04a                	sd	s2,0(sp)
    80003370:	1000                	addi	s0,sp,32
    80003372:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003374:	00850913          	addi	s2,a0,8
    80003378:	854a                	mv	a0,s2
    8000337a:	558020ef          	jal	800058d2 <acquire>
  while (lk->locked) {
    8000337e:	409c                	lw	a5,0(s1)
    80003380:	c799                	beqz	a5,8000338e <acquiresleep+0x28>
    sleep(lk, &lk->lk);
    80003382:	85ca                	mv	a1,s2
    80003384:	8526                	mv	a0,s1
    80003386:	fc1fd0ef          	jal	80001346 <sleep>
  while (lk->locked) {
    8000338a:	409c                	lw	a5,0(s1)
    8000338c:	fbfd                	bnez	a5,80003382 <acquiresleep+0x1c>
  }
  lk->locked = 1;
    8000338e:	4785                	li	a5,1
    80003390:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003392:	9b3fd0ef          	jal	80000d44 <myproc>
    80003396:	591c                	lw	a5,48(a0)
    80003398:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    8000339a:	854a                	mv	a0,s2
    8000339c:	5c6020ef          	jal	80005962 <release>
}
    800033a0:	60e2                	ld	ra,24(sp)
    800033a2:	6442                	ld	s0,16(sp)
    800033a4:	64a2                	ld	s1,8(sp)
    800033a6:	6902                	ld	s2,0(sp)
    800033a8:	6105                	addi	sp,sp,32
    800033aa:	8082                	ret

00000000800033ac <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800033ac:	1101                	addi	sp,sp,-32
    800033ae:	ec06                	sd	ra,24(sp)
    800033b0:	e822                	sd	s0,16(sp)
    800033b2:	e426                	sd	s1,8(sp)
    800033b4:	e04a                	sd	s2,0(sp)
    800033b6:	1000                	addi	s0,sp,32
    800033b8:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800033ba:	00850913          	addi	s2,a0,8
    800033be:	854a                	mv	a0,s2
    800033c0:	512020ef          	jal	800058d2 <acquire>
  lk->locked = 0;
    800033c4:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800033c8:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    800033cc:	8526                	mv	a0,s1
    800033ce:	fc5fd0ef          	jal	80001392 <wakeup>
  release(&lk->lk);
    800033d2:	854a                	mv	a0,s2
    800033d4:	58e020ef          	jal	80005962 <release>
}
    800033d8:	60e2                	ld	ra,24(sp)
    800033da:	6442                	ld	s0,16(sp)
    800033dc:	64a2                	ld	s1,8(sp)
    800033de:	6902                	ld	s2,0(sp)
    800033e0:	6105                	addi	sp,sp,32
    800033e2:	8082                	ret

00000000800033e4 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800033e4:	7179                	addi	sp,sp,-48
    800033e6:	f406                	sd	ra,40(sp)
    800033e8:	f022                	sd	s0,32(sp)
    800033ea:	ec26                	sd	s1,24(sp)
    800033ec:	e84a                	sd	s2,16(sp)
    800033ee:	1800                	addi	s0,sp,48
    800033f0:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    800033f2:	00850913          	addi	s2,a0,8
    800033f6:	854a                	mv	a0,s2
    800033f8:	4da020ef          	jal	800058d2 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800033fc:	409c                	lw	a5,0(s1)
    800033fe:	ef81                	bnez	a5,80003416 <holdingsleep+0x32>
    80003400:	4481                	li	s1,0
  release(&lk->lk);
    80003402:	854a                	mv	a0,s2
    80003404:	55e020ef          	jal	80005962 <release>
  return r;
}
    80003408:	8526                	mv	a0,s1
    8000340a:	70a2                	ld	ra,40(sp)
    8000340c:	7402                	ld	s0,32(sp)
    8000340e:	64e2                	ld	s1,24(sp)
    80003410:	6942                	ld	s2,16(sp)
    80003412:	6145                	addi	sp,sp,48
    80003414:	8082                	ret
    80003416:	e44e                	sd	s3,8(sp)
  r = lk->locked && (lk->pid == myproc()->pid);
    80003418:	0284a983          	lw	s3,40(s1)
    8000341c:	929fd0ef          	jal	80000d44 <myproc>
    80003420:	5904                	lw	s1,48(a0)
    80003422:	413484b3          	sub	s1,s1,s3
    80003426:	0014b493          	seqz	s1,s1
    8000342a:	69a2                	ld	s3,8(sp)
    8000342c:	bfd9                	j	80003402 <holdingsleep+0x1e>

000000008000342e <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    8000342e:	1141                	addi	sp,sp,-16
    80003430:	e406                	sd	ra,8(sp)
    80003432:	e022                	sd	s0,0(sp)
    80003434:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003436:	00004597          	auipc	a1,0x4
    8000343a:	0da58593          	addi	a1,a1,218 # 80007510 <etext+0x510>
    8000343e:	00016517          	auipc	a0,0x16
    80003442:	77a50513          	addi	a0,a0,1914 # 80019bb8 <ftable>
    80003446:	402020ef          	jal	80005848 <initlock>
}
    8000344a:	60a2                	ld	ra,8(sp)
    8000344c:	6402                	ld	s0,0(sp)
    8000344e:	0141                	addi	sp,sp,16
    80003450:	8082                	ret

0000000080003452 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003452:	1101                	addi	sp,sp,-32
    80003454:	ec06                	sd	ra,24(sp)
    80003456:	e822                	sd	s0,16(sp)
    80003458:	e426                	sd	s1,8(sp)
    8000345a:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    8000345c:	00016517          	auipc	a0,0x16
    80003460:	75c50513          	addi	a0,a0,1884 # 80019bb8 <ftable>
    80003464:	46e020ef          	jal	800058d2 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003468:	00016497          	auipc	s1,0x16
    8000346c:	76848493          	addi	s1,s1,1896 # 80019bd0 <ftable+0x18>
    80003470:	00017717          	auipc	a4,0x17
    80003474:	70070713          	addi	a4,a4,1792 # 8001ab70 <disk>
    if(f->ref == 0){
    80003478:	40dc                	lw	a5,4(s1)
    8000347a:	cf89                	beqz	a5,80003494 <filealloc+0x42>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8000347c:	02848493          	addi	s1,s1,40
    80003480:	fee49ce3          	bne	s1,a4,80003478 <filealloc+0x26>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003484:	00016517          	auipc	a0,0x16
    80003488:	73450513          	addi	a0,a0,1844 # 80019bb8 <ftable>
    8000348c:	4d6020ef          	jal	80005962 <release>
  return 0;
    80003490:	4481                	li	s1,0
    80003492:	a809                	j	800034a4 <filealloc+0x52>
      f->ref = 1;
    80003494:	4785                	li	a5,1
    80003496:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003498:	00016517          	auipc	a0,0x16
    8000349c:	72050513          	addi	a0,a0,1824 # 80019bb8 <ftable>
    800034a0:	4c2020ef          	jal	80005962 <release>
}
    800034a4:	8526                	mv	a0,s1
    800034a6:	60e2                	ld	ra,24(sp)
    800034a8:	6442                	ld	s0,16(sp)
    800034aa:	64a2                	ld	s1,8(sp)
    800034ac:	6105                	addi	sp,sp,32
    800034ae:	8082                	ret

00000000800034b0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    800034b0:	1101                	addi	sp,sp,-32
    800034b2:	ec06                	sd	ra,24(sp)
    800034b4:	e822                	sd	s0,16(sp)
    800034b6:	e426                	sd	s1,8(sp)
    800034b8:	1000                	addi	s0,sp,32
    800034ba:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    800034bc:	00016517          	auipc	a0,0x16
    800034c0:	6fc50513          	addi	a0,a0,1788 # 80019bb8 <ftable>
    800034c4:	40e020ef          	jal	800058d2 <acquire>
  if(f->ref < 1)
    800034c8:	40dc                	lw	a5,4(s1)
    800034ca:	02f05063          	blez	a5,800034ea <filedup+0x3a>
    panic("filedup");
  f->ref++;
    800034ce:	2785                	addiw	a5,a5,1
    800034d0:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    800034d2:	00016517          	auipc	a0,0x16
    800034d6:	6e650513          	addi	a0,a0,1766 # 80019bb8 <ftable>
    800034da:	488020ef          	jal	80005962 <release>
  return f;
}
    800034de:	8526                	mv	a0,s1
    800034e0:	60e2                	ld	ra,24(sp)
    800034e2:	6442                	ld	s0,16(sp)
    800034e4:	64a2                	ld	s1,8(sp)
    800034e6:	6105                	addi	sp,sp,32
    800034e8:	8082                	ret
    panic("filedup");
    800034ea:	00004517          	auipc	a0,0x4
    800034ee:	02e50513          	addi	a0,a0,46 # 80007518 <etext+0x518>
    800034f2:	122020ef          	jal	80005614 <panic>

00000000800034f6 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    800034f6:	7139                	addi	sp,sp,-64
    800034f8:	fc06                	sd	ra,56(sp)
    800034fa:	f822                	sd	s0,48(sp)
    800034fc:	f426                	sd	s1,40(sp)
    800034fe:	0080                	addi	s0,sp,64
    80003500:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003502:	00016517          	auipc	a0,0x16
    80003506:	6b650513          	addi	a0,a0,1718 # 80019bb8 <ftable>
    8000350a:	3c8020ef          	jal	800058d2 <acquire>
  if(f->ref < 1)
    8000350e:	40dc                	lw	a5,4(s1)
    80003510:	04f05a63          	blez	a5,80003564 <fileclose+0x6e>
    panic("fileclose");
  if(--f->ref > 0){
    80003514:	37fd                	addiw	a5,a5,-1
    80003516:	c0dc                	sw	a5,4(s1)
    80003518:	06f04063          	bgtz	a5,80003578 <fileclose+0x82>
    8000351c:	f04a                	sd	s2,32(sp)
    8000351e:	ec4e                	sd	s3,24(sp)
    80003520:	e852                	sd	s4,16(sp)
    80003522:	e456                	sd	s5,8(sp)
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003524:	0004a903          	lw	s2,0(s1)
    80003528:	0094c783          	lbu	a5,9(s1)
    8000352c:	89be                	mv	s3,a5
    8000352e:	689c                	ld	a5,16(s1)
    80003530:	8a3e                	mv	s4,a5
    80003532:	6c9c                	ld	a5,24(s1)
    80003534:	8abe                	mv	s5,a5
  f->ref = 0;
    80003536:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    8000353a:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    8000353e:	00016517          	auipc	a0,0x16
    80003542:	67a50513          	addi	a0,a0,1658 # 80019bb8 <ftable>
    80003546:	41c020ef          	jal	80005962 <release>

  if(ff.type == FD_PIPE){
    8000354a:	4785                	li	a5,1
    8000354c:	04f90163          	beq	s2,a5,8000358e <fileclose+0x98>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003550:	ffe9079b          	addiw	a5,s2,-2
    80003554:	4705                	li	a4,1
    80003556:	04f77563          	bgeu	a4,a5,800035a0 <fileclose+0xaa>
    8000355a:	7902                	ld	s2,32(sp)
    8000355c:	69e2                	ld	s3,24(sp)
    8000355e:	6a42                	ld	s4,16(sp)
    80003560:	6aa2                	ld	s5,8(sp)
    80003562:	a00d                	j	80003584 <fileclose+0x8e>
    80003564:	f04a                	sd	s2,32(sp)
    80003566:	ec4e                	sd	s3,24(sp)
    80003568:	e852                	sd	s4,16(sp)
    8000356a:	e456                	sd	s5,8(sp)
    panic("fileclose");
    8000356c:	00004517          	auipc	a0,0x4
    80003570:	fb450513          	addi	a0,a0,-76 # 80007520 <etext+0x520>
    80003574:	0a0020ef          	jal	80005614 <panic>
    release(&ftable.lock);
    80003578:	00016517          	auipc	a0,0x16
    8000357c:	64050513          	addi	a0,a0,1600 # 80019bb8 <ftable>
    80003580:	3e2020ef          	jal	80005962 <release>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
    80003584:	70e2                	ld	ra,56(sp)
    80003586:	7442                	ld	s0,48(sp)
    80003588:	74a2                	ld	s1,40(sp)
    8000358a:	6121                	addi	sp,sp,64
    8000358c:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    8000358e:	85ce                	mv	a1,s3
    80003590:	8552                	mv	a0,s4
    80003592:	332000ef          	jal	800038c4 <pipeclose>
    80003596:	7902                	ld	s2,32(sp)
    80003598:	69e2                	ld	s3,24(sp)
    8000359a:	6a42                	ld	s4,16(sp)
    8000359c:	6aa2                	ld	s5,8(sp)
    8000359e:	b7dd                	j	80003584 <fileclose+0x8e>
    begin_op();
    800035a0:	b37ff0ef          	jal	800030d6 <begin_op>
    iput(ff.ip);
    800035a4:	8556                	mv	a0,s5
    800035a6:	a9cff0ef          	jal	80002842 <iput>
    end_op();
    800035aa:	b9dff0ef          	jal	80003146 <end_op>
    800035ae:	7902                	ld	s2,32(sp)
    800035b0:	69e2                	ld	s3,24(sp)
    800035b2:	6a42                	ld	s4,16(sp)
    800035b4:	6aa2                	ld	s5,8(sp)
    800035b6:	b7f9                	j	80003584 <fileclose+0x8e>

00000000800035b8 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    800035b8:	715d                	addi	sp,sp,-80
    800035ba:	e486                	sd	ra,72(sp)
    800035bc:	e0a2                	sd	s0,64(sp)
    800035be:	fc26                	sd	s1,56(sp)
    800035c0:	f052                	sd	s4,32(sp)
    800035c2:	0880                	addi	s0,sp,80
    800035c4:	84aa                	mv	s1,a0
    800035c6:	8a2e                	mv	s4,a1
  struct proc *p = myproc();
    800035c8:	f7cfd0ef          	jal	80000d44 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    800035cc:	409c                	lw	a5,0(s1)
    800035ce:	37f9                	addiw	a5,a5,-2
    800035d0:	4705                	li	a4,1
    800035d2:	04f76263          	bltu	a4,a5,80003616 <filestat+0x5e>
    800035d6:	f84a                	sd	s2,48(sp)
    800035d8:	f44e                	sd	s3,40(sp)
    800035da:	89aa                	mv	s3,a0
    ilock(f->ip);
    800035dc:	6c88                	ld	a0,24(s1)
    800035de:	8e2ff0ef          	jal	800026c0 <ilock>
    stati(f->ip, &st);
    800035e2:	fb840913          	addi	s2,s0,-72
    800035e6:	85ca                	mv	a1,s2
    800035e8:	6c88                	ld	a0,24(s1)
    800035ea:	c3aff0ef          	jal	80002a24 <stati>
    iunlock(f->ip);
    800035ee:	6c88                	ld	a0,24(s1)
    800035f0:	97eff0ef          	jal	8000276e <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    800035f4:	46e1                	li	a3,24
    800035f6:	864a                	mv	a2,s2
    800035f8:	85d2                	mv	a1,s4
    800035fa:	0509b503          	ld	a0,80(s3)
    800035fe:	c8cfd0ef          	jal	80000a8a <copyout>
    80003602:	41f5551b          	sraiw	a0,a0,0x1f
    80003606:	7942                	ld	s2,48(sp)
    80003608:	79a2                	ld	s3,40(sp)
      return -1;
    return 0;
  }
  return -1;
}
    8000360a:	60a6                	ld	ra,72(sp)
    8000360c:	6406                	ld	s0,64(sp)
    8000360e:	74e2                	ld	s1,56(sp)
    80003610:	7a02                	ld	s4,32(sp)
    80003612:	6161                	addi	sp,sp,80
    80003614:	8082                	ret
  return -1;
    80003616:	557d                	li	a0,-1
    80003618:	bfcd                	j	8000360a <filestat+0x52>

000000008000361a <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    8000361a:	7179                	addi	sp,sp,-48
    8000361c:	f406                	sd	ra,40(sp)
    8000361e:	f022                	sd	s0,32(sp)
    80003620:	e84a                	sd	s2,16(sp)
    80003622:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003624:	00854783          	lbu	a5,8(a0)
    80003628:	c3c5                	beqz	a5,800036c8 <fileread+0xae>
    8000362a:	ec26                	sd	s1,24(sp)
    8000362c:	e44e                	sd	s3,8(sp)
    8000362e:	84aa                	mv	s1,a0
    80003630:	892e                	mv	s2,a1
    80003632:	89b2                	mv	s3,a2
    return -1;

  if(f->type == FD_PIPE){
    80003634:	411c                	lw	a5,0(a0)
    80003636:	4705                	li	a4,1
    80003638:	04e78363          	beq	a5,a4,8000367e <fileread+0x64>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    8000363c:	470d                	li	a4,3
    8000363e:	04e78763          	beq	a5,a4,8000368c <fileread+0x72>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003642:	4709                	li	a4,2
    80003644:	06e79a63          	bne	a5,a4,800036b8 <fileread+0x9e>
    ilock(f->ip);
    80003648:	6d08                	ld	a0,24(a0)
    8000364a:	876ff0ef          	jal	800026c0 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    8000364e:	874e                	mv	a4,s3
    80003650:	5094                	lw	a3,32(s1)
    80003652:	864a                	mv	a2,s2
    80003654:	4585                	li	a1,1
    80003656:	6c88                	ld	a0,24(s1)
    80003658:	bfaff0ef          	jal	80002a52 <readi>
    8000365c:	892a                	mv	s2,a0
    8000365e:	00a05563          	blez	a0,80003668 <fileread+0x4e>
      f->off += r;
    80003662:	509c                	lw	a5,32(s1)
    80003664:	9fa9                	addw	a5,a5,a0
    80003666:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003668:	6c88                	ld	a0,24(s1)
    8000366a:	904ff0ef          	jal	8000276e <iunlock>
    8000366e:	64e2                	ld	s1,24(sp)
    80003670:	69a2                	ld	s3,8(sp)
  } else {
    panic("fileread");
  }

  return r;
}
    80003672:	854a                	mv	a0,s2
    80003674:	70a2                	ld	ra,40(sp)
    80003676:	7402                	ld	s0,32(sp)
    80003678:	6942                	ld	s2,16(sp)
    8000367a:	6145                	addi	sp,sp,48
    8000367c:	8082                	ret
    r = piperead(f->pipe, addr, n);
    8000367e:	6908                	ld	a0,16(a0)
    80003680:	39a000ef          	jal	80003a1a <piperead>
    80003684:	892a                	mv	s2,a0
    80003686:	64e2                	ld	s1,24(sp)
    80003688:	69a2                	ld	s3,8(sp)
    8000368a:	b7e5                	j	80003672 <fileread+0x58>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    8000368c:	02451783          	lh	a5,36(a0)
    80003690:	03079693          	slli	a3,a5,0x30
    80003694:	92c1                	srli	a3,a3,0x30
    80003696:	4725                	li	a4,9
    80003698:	02d76663          	bltu	a4,a3,800036c4 <fileread+0xaa>
    8000369c:	0792                	slli	a5,a5,0x4
    8000369e:	00016717          	auipc	a4,0x16
    800036a2:	47a70713          	addi	a4,a4,1146 # 80019b18 <devsw>
    800036a6:	97ba                	add	a5,a5,a4
    800036a8:	639c                	ld	a5,0(a5)
    800036aa:	c395                	beqz	a5,800036ce <fileread+0xb4>
    r = devsw[f->major].read(1, addr, n);
    800036ac:	4505                	li	a0,1
    800036ae:	9782                	jalr	a5
    800036b0:	892a                	mv	s2,a0
    800036b2:	64e2                	ld	s1,24(sp)
    800036b4:	69a2                	ld	s3,8(sp)
    800036b6:	bf75                	j	80003672 <fileread+0x58>
    panic("fileread");
    800036b8:	00004517          	auipc	a0,0x4
    800036bc:	e7850513          	addi	a0,a0,-392 # 80007530 <etext+0x530>
    800036c0:	755010ef          	jal	80005614 <panic>
    800036c4:	64e2                	ld	s1,24(sp)
    800036c6:	69a2                	ld	s3,8(sp)
    return -1;
    800036c8:	57fd                	li	a5,-1
    800036ca:	893e                	mv	s2,a5
    800036cc:	b75d                	j	80003672 <fileread+0x58>
    800036ce:	64e2                	ld	s1,24(sp)
    800036d0:	69a2                	ld	s3,8(sp)
    800036d2:	bfdd                	j	800036c8 <fileread+0xae>

00000000800036d4 <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    800036d4:	00954783          	lbu	a5,9(a0)
    800036d8:	12078463          	beqz	a5,80003800 <filewrite+0x12c>
{
    800036dc:	711d                	addi	sp,sp,-96
    800036de:	ec86                	sd	ra,88(sp)
    800036e0:	e8a2                	sd	s0,80(sp)
    800036e2:	e0ca                	sd	s2,64(sp)
    800036e4:	f456                	sd	s5,40(sp)
    800036e6:	f05a                	sd	s6,32(sp)
    800036e8:	1080                	addi	s0,sp,96
    800036ea:	892a                	mv	s2,a0
    800036ec:	8b2e                	mv	s6,a1
    800036ee:	8ab2                	mv	s5,a2
    return -1;

  if(f->type == FD_PIPE){
    800036f0:	411c                	lw	a5,0(a0)
    800036f2:	4705                	li	a4,1
    800036f4:	02e78a63          	beq	a5,a4,80003728 <filewrite+0x54>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800036f8:	470d                	li	a4,3
    800036fa:	02e78b63          	beq	a5,a4,80003730 <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    800036fe:	4709                	li	a4,2
    80003700:	0ce79f63          	bne	a5,a4,800037de <filewrite+0x10a>
    80003704:	f852                	sd	s4,48(sp)
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003706:	0ac05a63          	blez	a2,800037ba <filewrite+0xe6>
    8000370a:	e4a6                	sd	s1,72(sp)
    8000370c:	fc4e                	sd	s3,56(sp)
    8000370e:	ec5e                	sd	s7,24(sp)
    80003710:	e862                	sd	s8,16(sp)
    80003712:	e466                	sd	s9,8(sp)
    int i = 0;
    80003714:	4a01                	li	s4,0
      int n1 = n - i;
      if(n1 > max)
    80003716:	6b85                	lui	s7,0x1
    80003718:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    8000371c:	6785                	lui	a5,0x1
    8000371e:	c007879b          	addiw	a5,a5,-1024 # c00 <_entry-0x7ffff400>
    80003722:	8cbe                	mv	s9,a5
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003724:	4c05                	li	s8,1
    80003726:	a8ad                	j	800037a0 <filewrite+0xcc>
    ret = pipewrite(f->pipe, addr, n);
    80003728:	6908                	ld	a0,16(a0)
    8000372a:	1f8000ef          	jal	80003922 <pipewrite>
    8000372e:	a04d                	j	800037d0 <filewrite+0xfc>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003730:	02451783          	lh	a5,36(a0)
    80003734:	03079693          	slli	a3,a5,0x30
    80003738:	92c1                	srli	a3,a3,0x30
    8000373a:	4725                	li	a4,9
    8000373c:	0ad76d63          	bltu	a4,a3,800037f6 <filewrite+0x122>
    80003740:	0792                	slli	a5,a5,0x4
    80003742:	00016717          	auipc	a4,0x16
    80003746:	3d670713          	addi	a4,a4,982 # 80019b18 <devsw>
    8000374a:	97ba                	add	a5,a5,a4
    8000374c:	679c                	ld	a5,8(a5)
    8000374e:	c7c5                	beqz	a5,800037f6 <filewrite+0x122>
    ret = devsw[f->major].write(1, addr, n);
    80003750:	4505                	li	a0,1
    80003752:	9782                	jalr	a5
    80003754:	a8b5                	j	800037d0 <filewrite+0xfc>
      if(n1 > max)
    80003756:	2981                	sext.w	s3,s3
      begin_op();
    80003758:	97fff0ef          	jal	800030d6 <begin_op>
      ilock(f->ip);
    8000375c:	01893503          	ld	a0,24(s2)
    80003760:	f61fe0ef          	jal	800026c0 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003764:	874e                	mv	a4,s3
    80003766:	02092683          	lw	a3,32(s2)
    8000376a:	016a0633          	add	a2,s4,s6
    8000376e:	85e2                	mv	a1,s8
    80003770:	01893503          	ld	a0,24(s2)
    80003774:	bd0ff0ef          	jal	80002b44 <writei>
    80003778:	84aa                	mv	s1,a0
    8000377a:	00a05763          	blez	a0,80003788 <filewrite+0xb4>
        f->off += r;
    8000377e:	02092783          	lw	a5,32(s2)
    80003782:	9fa9                	addw	a5,a5,a0
    80003784:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003788:	01893503          	ld	a0,24(s2)
    8000378c:	fe3fe0ef          	jal	8000276e <iunlock>
      end_op();
    80003790:	9b7ff0ef          	jal	80003146 <end_op>

      if(r != n1){
    80003794:	02999563          	bne	s3,s1,800037be <filewrite+0xea>
        // error from writei
        break;
      }
      i += r;
    80003798:	01448a3b          	addw	s4,s1,s4
    while(i < n){
    8000379c:	015a5963          	bge	s4,s5,800037ae <filewrite+0xda>
      int n1 = n - i;
    800037a0:	414a87bb          	subw	a5,s5,s4
    800037a4:	89be                	mv	s3,a5
      if(n1 > max)
    800037a6:	fafbd8e3          	bge	s7,a5,80003756 <filewrite+0x82>
    800037aa:	89e6                	mv	s3,s9
    800037ac:	b76d                	j	80003756 <filewrite+0x82>
    800037ae:	64a6                	ld	s1,72(sp)
    800037b0:	79e2                	ld	s3,56(sp)
    800037b2:	6be2                	ld	s7,24(sp)
    800037b4:	6c42                	ld	s8,16(sp)
    800037b6:	6ca2                	ld	s9,8(sp)
    800037b8:	a801                	j	800037c8 <filewrite+0xf4>
    int i = 0;
    800037ba:	4a01                	li	s4,0
    800037bc:	a031                	j	800037c8 <filewrite+0xf4>
    800037be:	64a6                	ld	s1,72(sp)
    800037c0:	79e2                	ld	s3,56(sp)
    800037c2:	6be2                	ld	s7,24(sp)
    800037c4:	6c42                	ld	s8,16(sp)
    800037c6:	6ca2                	ld	s9,8(sp)
    }
    ret = (i == n ? n : -1);
    800037c8:	034a9963          	bne	s5,s4,800037fa <filewrite+0x126>
    800037cc:	8556                	mv	a0,s5
    800037ce:	7a42                	ld	s4,48(sp)
  } else {
    panic("filewrite");
  }

  return ret;
}
    800037d0:	60e6                	ld	ra,88(sp)
    800037d2:	6446                	ld	s0,80(sp)
    800037d4:	6906                	ld	s2,64(sp)
    800037d6:	7aa2                	ld	s5,40(sp)
    800037d8:	7b02                	ld	s6,32(sp)
    800037da:	6125                	addi	sp,sp,96
    800037dc:	8082                	ret
    800037de:	e4a6                	sd	s1,72(sp)
    800037e0:	fc4e                	sd	s3,56(sp)
    800037e2:	f852                	sd	s4,48(sp)
    800037e4:	ec5e                	sd	s7,24(sp)
    800037e6:	e862                	sd	s8,16(sp)
    800037e8:	e466                	sd	s9,8(sp)
    panic("filewrite");
    800037ea:	00004517          	auipc	a0,0x4
    800037ee:	d5650513          	addi	a0,a0,-682 # 80007540 <etext+0x540>
    800037f2:	623010ef          	jal	80005614 <panic>
    return -1;
    800037f6:	557d                	li	a0,-1
    800037f8:	bfe1                	j	800037d0 <filewrite+0xfc>
    ret = (i == n ? n : -1);
    800037fa:	557d                	li	a0,-1
    800037fc:	7a42                	ld	s4,48(sp)
    800037fe:	bfc9                	j	800037d0 <filewrite+0xfc>
    return -1;
    80003800:	557d                	li	a0,-1
}
    80003802:	8082                	ret

0000000080003804 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003804:	7179                	addi	sp,sp,-48
    80003806:	f406                	sd	ra,40(sp)
    80003808:	f022                	sd	s0,32(sp)
    8000380a:	ec26                	sd	s1,24(sp)
    8000380c:	e052                	sd	s4,0(sp)
    8000380e:	1800                	addi	s0,sp,48
    80003810:	84aa                	mv	s1,a0
    80003812:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003814:	0005b023          	sd	zero,0(a1)
    80003818:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    8000381c:	c37ff0ef          	jal	80003452 <filealloc>
    80003820:	e088                	sd	a0,0(s1)
    80003822:	c549                	beqz	a0,800038ac <pipealloc+0xa8>
    80003824:	c2fff0ef          	jal	80003452 <filealloc>
    80003828:	00aa3023          	sd	a0,0(s4)
    8000382c:	cd25                	beqz	a0,800038a4 <pipealloc+0xa0>
    8000382e:	e84a                	sd	s2,16(sp)
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003830:	8cdfc0ef          	jal	800000fc <kalloc>
    80003834:	892a                	mv	s2,a0
    80003836:	c12d                	beqz	a0,80003898 <pipealloc+0x94>
    80003838:	e44e                	sd	s3,8(sp)
    goto bad;
  pi->readopen = 1;
    8000383a:	4985                	li	s3,1
    8000383c:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003840:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003844:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003848:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    8000384c:	00004597          	auipc	a1,0x4
    80003850:	d0458593          	addi	a1,a1,-764 # 80007550 <etext+0x550>
    80003854:	7f5010ef          	jal	80005848 <initlock>
  (*f0)->type = FD_PIPE;
    80003858:	609c                	ld	a5,0(s1)
    8000385a:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    8000385e:	609c                	ld	a5,0(s1)
    80003860:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003864:	609c                	ld	a5,0(s1)
    80003866:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    8000386a:	609c                	ld	a5,0(s1)
    8000386c:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003870:	000a3783          	ld	a5,0(s4)
    80003874:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003878:	000a3783          	ld	a5,0(s4)
    8000387c:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003880:	000a3783          	ld	a5,0(s4)
    80003884:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003888:	000a3783          	ld	a5,0(s4)
    8000388c:	0127b823          	sd	s2,16(a5)
  return 0;
    80003890:	4501                	li	a0,0
    80003892:	6942                	ld	s2,16(sp)
    80003894:	69a2                	ld	s3,8(sp)
    80003896:	a00d                	j	800038b8 <pipealloc+0xb4>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003898:	6088                	ld	a0,0(s1)
    8000389a:	c119                	beqz	a0,800038a0 <pipealloc+0x9c>
    8000389c:	6942                	ld	s2,16(sp)
    8000389e:	a029                	j	800038a8 <pipealloc+0xa4>
    800038a0:	6942                	ld	s2,16(sp)
    800038a2:	a029                	j	800038ac <pipealloc+0xa8>
    800038a4:	6088                	ld	a0,0(s1)
    800038a6:	c901                	beqz	a0,800038b6 <pipealloc+0xb2>
    fileclose(*f0);
    800038a8:	c4fff0ef          	jal	800034f6 <fileclose>
  if(*f1)
    800038ac:	000a3503          	ld	a0,0(s4)
    800038b0:	c119                	beqz	a0,800038b6 <pipealloc+0xb2>
    fileclose(*f1);
    800038b2:	c45ff0ef          	jal	800034f6 <fileclose>
  return -1;
    800038b6:	557d                	li	a0,-1
}
    800038b8:	70a2                	ld	ra,40(sp)
    800038ba:	7402                	ld	s0,32(sp)
    800038bc:	64e2                	ld	s1,24(sp)
    800038be:	6a02                	ld	s4,0(sp)
    800038c0:	6145                	addi	sp,sp,48
    800038c2:	8082                	ret

00000000800038c4 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    800038c4:	1101                	addi	sp,sp,-32
    800038c6:	ec06                	sd	ra,24(sp)
    800038c8:	e822                	sd	s0,16(sp)
    800038ca:	e426                	sd	s1,8(sp)
    800038cc:	e04a                	sd	s2,0(sp)
    800038ce:	1000                	addi	s0,sp,32
    800038d0:	84aa                	mv	s1,a0
    800038d2:	892e                	mv	s2,a1
  acquire(&pi->lock);
    800038d4:	7ff010ef          	jal	800058d2 <acquire>
  if(writable){
    800038d8:	02090763          	beqz	s2,80003906 <pipeclose+0x42>
    pi->writeopen = 0;
    800038dc:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    800038e0:	21848513          	addi	a0,s1,536
    800038e4:	aaffd0ef          	jal	80001392 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    800038e8:	2204a783          	lw	a5,544(s1)
    800038ec:	e781                	bnez	a5,800038f4 <pipeclose+0x30>
    800038ee:	2244a783          	lw	a5,548(s1)
    800038f2:	c38d                	beqz	a5,80003914 <pipeclose+0x50>
    release(&pi->lock);
    kfree((char*)pi);
  } else
    release(&pi->lock);
    800038f4:	8526                	mv	a0,s1
    800038f6:	06c020ef          	jal	80005962 <release>
}
    800038fa:	60e2                	ld	ra,24(sp)
    800038fc:	6442                	ld	s0,16(sp)
    800038fe:	64a2                	ld	s1,8(sp)
    80003900:	6902                	ld	s2,0(sp)
    80003902:	6105                	addi	sp,sp,32
    80003904:	8082                	ret
    pi->readopen = 0;
    80003906:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    8000390a:	21c48513          	addi	a0,s1,540
    8000390e:	a85fd0ef          	jal	80001392 <wakeup>
    80003912:	bfd9                	j	800038e8 <pipeclose+0x24>
    release(&pi->lock);
    80003914:	8526                	mv	a0,s1
    80003916:	04c020ef          	jal	80005962 <release>
    kfree((char*)pi);
    8000391a:	8526                	mv	a0,s1
    8000391c:	f00fc0ef          	jal	8000001c <kfree>
    80003920:	bfe9                	j	800038fa <pipeclose+0x36>

0000000080003922 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80003922:	7159                	addi	sp,sp,-112
    80003924:	f486                	sd	ra,104(sp)
    80003926:	f0a2                	sd	s0,96(sp)
    80003928:	eca6                	sd	s1,88(sp)
    8000392a:	e8ca                	sd	s2,80(sp)
    8000392c:	e4ce                	sd	s3,72(sp)
    8000392e:	e0d2                	sd	s4,64(sp)
    80003930:	fc56                	sd	s5,56(sp)
    80003932:	1880                	addi	s0,sp,112
    80003934:	84aa                	mv	s1,a0
    80003936:	8aae                	mv	s5,a1
    80003938:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    8000393a:	c0afd0ef          	jal	80000d44 <myproc>
    8000393e:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80003940:	8526                	mv	a0,s1
    80003942:	791010ef          	jal	800058d2 <acquire>
  while(i < n){
    80003946:	0d405263          	blez	s4,80003a0a <pipewrite+0xe8>
    8000394a:	f85a                	sd	s6,48(sp)
    8000394c:	f45e                	sd	s7,40(sp)
    8000394e:	f062                	sd	s8,32(sp)
    80003950:	ec66                	sd	s9,24(sp)
    80003952:	e86a                	sd	s10,16(sp)
  int i = 0;
    80003954:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003956:	f9f40c13          	addi	s8,s0,-97
    8000395a:	4b85                	li	s7,1
    8000395c:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    8000395e:	21848d13          	addi	s10,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80003962:	21c48c93          	addi	s9,s1,540
    80003966:	a82d                	j	800039a0 <pipewrite+0x7e>
      release(&pi->lock);
    80003968:	8526                	mv	a0,s1
    8000396a:	7f9010ef          	jal	80005962 <release>
      return -1;
    8000396e:	597d                	li	s2,-1
    80003970:	7b42                	ld	s6,48(sp)
    80003972:	7ba2                	ld	s7,40(sp)
    80003974:	7c02                	ld	s8,32(sp)
    80003976:	6ce2                	ld	s9,24(sp)
    80003978:	6d42                	ld	s10,16(sp)
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    8000397a:	854a                	mv	a0,s2
    8000397c:	70a6                	ld	ra,104(sp)
    8000397e:	7406                	ld	s0,96(sp)
    80003980:	64e6                	ld	s1,88(sp)
    80003982:	6946                	ld	s2,80(sp)
    80003984:	69a6                	ld	s3,72(sp)
    80003986:	6a06                	ld	s4,64(sp)
    80003988:	7ae2                	ld	s5,56(sp)
    8000398a:	6165                	addi	sp,sp,112
    8000398c:	8082                	ret
      wakeup(&pi->nread);
    8000398e:	856a                	mv	a0,s10
    80003990:	a03fd0ef          	jal	80001392 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80003994:	85a6                	mv	a1,s1
    80003996:	8566                	mv	a0,s9
    80003998:	9affd0ef          	jal	80001346 <sleep>
  while(i < n){
    8000399c:	05495a63          	bge	s2,s4,800039f0 <pipewrite+0xce>
    if(pi->readopen == 0 || killed(pr)){
    800039a0:	2204a783          	lw	a5,544(s1)
    800039a4:	d3f1                	beqz	a5,80003968 <pipewrite+0x46>
    800039a6:	854e                	mv	a0,s3
    800039a8:	bdbfd0ef          	jal	80001582 <killed>
    800039ac:	fd55                	bnez	a0,80003968 <pipewrite+0x46>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    800039ae:	2184a783          	lw	a5,536(s1)
    800039b2:	21c4a703          	lw	a4,540(s1)
    800039b6:	2007879b          	addiw	a5,a5,512
    800039ba:	fcf70ae3          	beq	a4,a5,8000398e <pipewrite+0x6c>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800039be:	86de                	mv	a3,s7
    800039c0:	01590633          	add	a2,s2,s5
    800039c4:	85e2                	mv	a1,s8
    800039c6:	0509b503          	ld	a0,80(s3)
    800039ca:	97afd0ef          	jal	80000b44 <copyin>
    800039ce:	05650063          	beq	a0,s6,80003a0e <pipewrite+0xec>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    800039d2:	21c4a783          	lw	a5,540(s1)
    800039d6:	0017871b          	addiw	a4,a5,1
    800039da:	20e4ae23          	sw	a4,540(s1)
    800039de:	1ff7f793          	andi	a5,a5,511
    800039e2:	97a6                	add	a5,a5,s1
    800039e4:	f9f44703          	lbu	a4,-97(s0)
    800039e8:	00e78c23          	sb	a4,24(a5)
      i++;
    800039ec:	2905                	addiw	s2,s2,1
    800039ee:	b77d                	j	8000399c <pipewrite+0x7a>
    800039f0:	7b42                	ld	s6,48(sp)
    800039f2:	7ba2                	ld	s7,40(sp)
    800039f4:	7c02                	ld	s8,32(sp)
    800039f6:	6ce2                	ld	s9,24(sp)
    800039f8:	6d42                	ld	s10,16(sp)
  wakeup(&pi->nread);
    800039fa:	21848513          	addi	a0,s1,536
    800039fe:	995fd0ef          	jal	80001392 <wakeup>
  release(&pi->lock);
    80003a02:	8526                	mv	a0,s1
    80003a04:	75f010ef          	jal	80005962 <release>
  return i;
    80003a08:	bf8d                	j	8000397a <pipewrite+0x58>
  int i = 0;
    80003a0a:	4901                	li	s2,0
    80003a0c:	b7fd                	j	800039fa <pipewrite+0xd8>
    80003a0e:	7b42                	ld	s6,48(sp)
    80003a10:	7ba2                	ld	s7,40(sp)
    80003a12:	7c02                	ld	s8,32(sp)
    80003a14:	6ce2                	ld	s9,24(sp)
    80003a16:	6d42                	ld	s10,16(sp)
    80003a18:	b7cd                	j	800039fa <pipewrite+0xd8>

0000000080003a1a <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80003a1a:	711d                	addi	sp,sp,-96
    80003a1c:	ec86                	sd	ra,88(sp)
    80003a1e:	e8a2                	sd	s0,80(sp)
    80003a20:	e4a6                	sd	s1,72(sp)
    80003a22:	e0ca                	sd	s2,64(sp)
    80003a24:	fc4e                	sd	s3,56(sp)
    80003a26:	f852                	sd	s4,48(sp)
    80003a28:	f456                	sd	s5,40(sp)
    80003a2a:	1080                	addi	s0,sp,96
    80003a2c:	84aa                	mv	s1,a0
    80003a2e:	892e                	mv	s2,a1
    80003a30:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80003a32:	b12fd0ef          	jal	80000d44 <myproc>
    80003a36:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80003a38:	8526                	mv	a0,s1
    80003a3a:	699010ef          	jal	800058d2 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003a3e:	2184a703          	lw	a4,536(s1)
    80003a42:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003a46:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003a4a:	02f71363          	bne	a4,a5,80003a70 <piperead+0x56>
    80003a4e:	2244a783          	lw	a5,548(s1)
    80003a52:	cf99                	beqz	a5,80003a70 <piperead+0x56>
    if(killed(pr)){
    80003a54:	8552                	mv	a0,s4
    80003a56:	b2dfd0ef          	jal	80001582 <killed>
    80003a5a:	e53d                	bnez	a0,80003ac8 <piperead+0xae>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003a5c:	85a6                	mv	a1,s1
    80003a5e:	854e                	mv	a0,s3
    80003a60:	8e7fd0ef          	jal	80001346 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003a64:	2184a703          	lw	a4,536(s1)
    80003a68:	21c4a783          	lw	a5,540(s1)
    80003a6c:	fef701e3          	beq	a4,a5,80003a4e <piperead+0x34>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003a70:	07505163          	blez	s5,80003ad2 <piperead+0xb8>
    80003a74:	f05a                	sd	s6,32(sp)
    80003a76:	ec5e                	sd	s7,24(sp)
    80003a78:	e862                	sd	s8,16(sp)
    80003a7a:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80003a7c:	faf40c13          	addi	s8,s0,-81
    80003a80:	4b85                	li	s7,1
    80003a82:	5b7d                	li	s6,-1
    if(pi->nread == pi->nwrite)
    80003a84:	2184a783          	lw	a5,536(s1)
    80003a88:	21c4a703          	lw	a4,540(s1)
    80003a8c:	04f70563          	beq	a4,a5,80003ad6 <piperead+0xbc>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80003a90:	0017871b          	addiw	a4,a5,1
    80003a94:	20e4ac23          	sw	a4,536(s1)
    80003a98:	1ff7f793          	andi	a5,a5,511
    80003a9c:	97a6                	add	a5,a5,s1
    80003a9e:	0187c783          	lbu	a5,24(a5)
    80003aa2:	faf407a3          	sb	a5,-81(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80003aa6:	86de                	mv	a3,s7
    80003aa8:	8662                	mv	a2,s8
    80003aaa:	85ca                	mv	a1,s2
    80003aac:	050a3503          	ld	a0,80(s4)
    80003ab0:	fdbfc0ef          	jal	80000a8a <copyout>
    80003ab4:	05650563          	beq	a0,s6,80003afe <piperead+0xe4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003ab8:	2985                	addiw	s3,s3,1
    80003aba:	0905                	addi	s2,s2,1
    80003abc:	fd3a94e3          	bne	s5,s3,80003a84 <piperead+0x6a>
    80003ac0:	7b02                	ld	s6,32(sp)
    80003ac2:	6be2                	ld	s7,24(sp)
    80003ac4:	6c42                	ld	s8,16(sp)
    80003ac6:	a819                	j	80003adc <piperead+0xc2>
      release(&pi->lock);
    80003ac8:	8526                	mv	a0,s1
    80003aca:	699010ef          	jal	80005962 <release>
      return -1;
    80003ace:	59fd                	li	s3,-1
    80003ad0:	a829                	j	80003aea <piperead+0xd0>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003ad2:	4981                	li	s3,0
    80003ad4:	a021                	j	80003adc <piperead+0xc2>
    80003ad6:	7b02                	ld	s6,32(sp)
    80003ad8:	6be2                	ld	s7,24(sp)
    80003ada:	6c42                	ld	s8,16(sp)
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80003adc:	21c48513          	addi	a0,s1,540
    80003ae0:	8b3fd0ef          	jal	80001392 <wakeup>
  release(&pi->lock);
    80003ae4:	8526                	mv	a0,s1
    80003ae6:	67d010ef          	jal	80005962 <release>
  return i;
}
    80003aea:	854e                	mv	a0,s3
    80003aec:	60e6                	ld	ra,88(sp)
    80003aee:	6446                	ld	s0,80(sp)
    80003af0:	64a6                	ld	s1,72(sp)
    80003af2:	6906                	ld	s2,64(sp)
    80003af4:	79e2                	ld	s3,56(sp)
    80003af6:	7a42                	ld	s4,48(sp)
    80003af8:	7aa2                	ld	s5,40(sp)
    80003afa:	6125                	addi	sp,sp,96
    80003afc:	8082                	ret
    80003afe:	7b02                	ld	s6,32(sp)
    80003b00:	6be2                	ld	s7,24(sp)
    80003b02:	6c42                	ld	s8,16(sp)
    80003b04:	bfe1                	j	80003adc <piperead+0xc2>

0000000080003b06 <flags2perm>:

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

// map ELF permissions to PTE permission bits.
int flags2perm(int flags)
{
    80003b06:	1141                	addi	sp,sp,-16
    80003b08:	e406                	sd	ra,8(sp)
    80003b0a:	e022                	sd	s0,0(sp)
    80003b0c:	0800                	addi	s0,sp,16
    80003b0e:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    80003b10:	0035151b          	slliw	a0,a0,0x3
    80003b14:	8921                	andi	a0,a0,8
      perm = PTE_X;
    if(flags & 0x2)
    80003b16:	8b89                	andi	a5,a5,2
    80003b18:	c399                	beqz	a5,80003b1e <flags2perm+0x18>
      perm |= PTE_W;
    80003b1a:	00456513          	ori	a0,a0,4
    return perm;
}
    80003b1e:	60a2                	ld	ra,8(sp)
    80003b20:	6402                	ld	s0,0(sp)
    80003b22:	0141                	addi	sp,sp,16
    80003b24:	8082                	ret

0000000080003b26 <kexec>:
//
// the implementation of the exec() system call
//
int
kexec(char *path, char **argv)
{
    80003b26:	df010113          	addi	sp,sp,-528
    80003b2a:	20113423          	sd	ra,520(sp)
    80003b2e:	20813023          	sd	s0,512(sp)
    80003b32:	ffa6                	sd	s1,504(sp)
    80003b34:	fbca                	sd	s2,496(sp)
    80003b36:	0c00                	addi	s0,sp,528
    80003b38:	892a                	mv	s2,a0
    80003b3a:	e0a43023          	sd	a0,-512(s0)
    80003b3e:	deb43c23          	sd	a1,-520(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80003b42:	a02fd0ef          	jal	80000d44 <myproc>
    80003b46:	84aa                	mv	s1,a0

  begin_op();
    80003b48:	d8eff0ef          	jal	800030d6 <begin_op>

  // Open the executable file.
  if((ip = namei(path)) == 0){
    80003b4c:	854a                	mv	a0,s2
    80003b4e:	baaff0ef          	jal	80002ef8 <namei>
    80003b52:	c931                	beqz	a0,80003ba6 <kexec+0x80>
    80003b54:	f3d2                	sd	s4,480(sp)
    80003b56:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80003b58:	b69fe0ef          	jal	800026c0 <ilock>

  // Read the ELF header.
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80003b5c:	04000713          	li	a4,64
    80003b60:	4681                	li	a3,0
    80003b62:	e5040613          	addi	a2,s0,-432
    80003b66:	4581                	li	a1,0
    80003b68:	8552                	mv	a0,s4
    80003b6a:	ee9fe0ef          	jal	80002a52 <readi>
    80003b6e:	04000793          	li	a5,64
    80003b72:	00f51a63          	bne	a0,a5,80003b86 <kexec+0x60>
    goto bad;

  // Is this really an ELF file?
  if(elf.magic != ELF_MAGIC)
    80003b76:	e5042703          	lw	a4,-432(s0)
    80003b7a:	464c47b7          	lui	a5,0x464c4
    80003b7e:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80003b82:	02f70563          	beq	a4,a5,80003bac <kexec+0x86>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80003b86:	8552                	mv	a0,s4
    80003b88:	d45fe0ef          	jal	800028cc <iunlockput>
    end_op();
    80003b8c:	dbaff0ef          	jal	80003146 <end_op>
    80003b90:	7a1e                	ld	s4,480(sp)
    return -1;
    80003b92:	557d                	li	a0,-1
  }
  return -1;
}
    80003b94:	20813083          	ld	ra,520(sp)
    80003b98:	20013403          	ld	s0,512(sp)
    80003b9c:	74fe                	ld	s1,504(sp)
    80003b9e:	795e                	ld	s2,496(sp)
    80003ba0:	21010113          	addi	sp,sp,528
    80003ba4:	8082                	ret
    end_op();
    80003ba6:	da0ff0ef          	jal	80003146 <end_op>
    return -1;
    80003baa:	b7e5                	j	80003b92 <kexec+0x6c>
    80003bac:	ebda                	sd	s6,464(sp)
  if((pagetable = proc_pagetable(p)) == 0)
    80003bae:	8526                	mv	a0,s1
    80003bb0:	a9efd0ef          	jal	80000e4e <proc_pagetable>
    80003bb4:	8b2a                	mv	s6,a0
    80003bb6:	26050063          	beqz	a0,80003e16 <kexec+0x2f0>
    80003bba:	f7ce                	sd	s3,488(sp)
    80003bbc:	efd6                	sd	s5,472(sp)
    80003bbe:	e7de                	sd	s7,456(sp)
    80003bc0:	e3e2                	sd	s8,448(sp)
    80003bc2:	ff66                	sd	s9,440(sp)
    80003bc4:	fb6a                	sd	s10,432(sp)
    80003bc6:	f76e                	sd	s11,424(sp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003bc8:	e8845783          	lhu	a5,-376(s0)
    80003bcc:	cff9                	beqz	a5,80003caa <kexec+0x184>
    80003bce:	e7042683          	lw	a3,-400(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80003bd2:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003bd4:	4d01                	li	s10,0
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80003bd6:	03800d93          	li	s11,56

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    80003bda:	6c85                	lui	s9,0x1
    80003bdc:	6a85                	lui	s5,0x1
    80003bde:	a085                	j	80003c3e <kexec+0x118>
      panic("loadseg: address should exist");
    80003be0:	00004517          	auipc	a0,0x4
    80003be4:	97850513          	addi	a0,a0,-1672 # 80007558 <etext+0x558>
    80003be8:	22d010ef          	jal	80005614 <panic>
    if(sz - i < PGSIZE)
    80003bec:	2901                	sext.w	s2,s2
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80003bee:	874a                	mv	a4,s2
    80003bf0:	009b86bb          	addw	a3,s7,s1
    80003bf4:	4581                	li	a1,0
    80003bf6:	8552                	mv	a0,s4
    80003bf8:	e5bfe0ef          	jal	80002a52 <readi>
    80003bfc:	22a91163          	bne	s2,a0,80003e1e <kexec+0x2f8>
  for(i = 0; i < sz; i += PGSIZE){
    80003c00:	009a84bb          	addw	s1,s5,s1
    80003c04:	0334f263          	bgeu	s1,s3,80003c28 <kexec+0x102>
    pa = walkaddr(pagetable, va + i);
    80003c08:	02049593          	slli	a1,s1,0x20
    80003c0c:	9181                	srli	a1,a1,0x20
    80003c0e:	95e2                	add	a1,a1,s8
    80003c10:	855a                	mv	a0,s6
    80003c12:	84dfc0ef          	jal	8000045e <walkaddr>
    80003c16:	862a                	mv	a2,a0
    if(pa == 0)
    80003c18:	d561                	beqz	a0,80003be0 <kexec+0xba>
    if(sz - i < PGSIZE)
    80003c1a:	409987bb          	subw	a5,s3,s1
    80003c1e:	893e                	mv	s2,a5
    80003c20:	fcfcf6e3          	bgeu	s9,a5,80003bec <kexec+0xc6>
    80003c24:	8956                	mv	s2,s5
    80003c26:	b7d9                	j	80003bec <kexec+0xc6>
    sz = sz1;
    80003c28:	df043903          	ld	s2,-528(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003c2c:	2d05                	addiw	s10,s10,1
    80003c2e:	e0843783          	ld	a5,-504(s0)
    80003c32:	0387869b          	addiw	a3,a5,56
    80003c36:	e8845783          	lhu	a5,-376(s0)
    80003c3a:	06fd5963          	bge	s10,a5,80003cac <kexec+0x186>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80003c3e:	e0d43423          	sd	a3,-504(s0)
    80003c42:	876e                	mv	a4,s11
    80003c44:	e1840613          	addi	a2,s0,-488
    80003c48:	4581                	li	a1,0
    80003c4a:	8552                	mv	a0,s4
    80003c4c:	e07fe0ef          	jal	80002a52 <readi>
    80003c50:	1db51563          	bne	a0,s11,80003e1a <kexec+0x2f4>
    if(ph.type != ELF_PROG_LOAD)
    80003c54:	e1842783          	lw	a5,-488(s0)
    80003c58:	4705                	li	a4,1
    80003c5a:	fce799e3          	bne	a5,a4,80003c2c <kexec+0x106>
    if(ph.memsz < ph.filesz)
    80003c5e:	e4043483          	ld	s1,-448(s0)
    80003c62:	e3843783          	ld	a5,-456(s0)
    80003c66:	1af4ea63          	bltu	s1,a5,80003e1a <kexec+0x2f4>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80003c6a:	e2843783          	ld	a5,-472(s0)
    80003c6e:	94be                	add	s1,s1,a5
    80003c70:	1af4e563          	bltu	s1,a5,80003e1a <kexec+0x2f4>
    if(ph.vaddr % PGSIZE != 0)
    80003c74:	17d2                	slli	a5,a5,0x34
    80003c76:	1a079263          	bnez	a5,80003e1a <kexec+0x2f4>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80003c7a:	e1c42503          	lw	a0,-484(s0)
    80003c7e:	e89ff0ef          	jal	80003b06 <flags2perm>
    80003c82:	86aa                	mv	a3,a0
    80003c84:	8626                	mv	a2,s1
    80003c86:	85ca                	mv	a1,s2
    80003c88:	855a                	mv	a0,s6
    80003c8a:	abffc0ef          	jal	80000748 <uvmalloc>
    80003c8e:	dea43823          	sd	a0,-528(s0)
    80003c92:	18050463          	beqz	a0,80003e1a <kexec+0x2f4>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80003c96:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80003c9a:	f80987e3          	beqz	s3,80003c28 <kexec+0x102>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80003c9e:	e2843c03          	ld	s8,-472(s0)
    80003ca2:	e2042b83          	lw	s7,-480(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80003ca6:	4481                	li	s1,0
    80003ca8:	b785                	j	80003c08 <kexec+0xe2>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80003caa:	4901                	li	s2,0
  iunlockput(ip);
    80003cac:	8552                	mv	a0,s4
    80003cae:	c1ffe0ef          	jal	800028cc <iunlockput>
  end_op();
    80003cb2:	c94ff0ef          	jal	80003146 <end_op>
  p = myproc();
    80003cb6:	88efd0ef          	jal	80000d44 <myproc>
    80003cba:	89aa                	mv	s3,a0
  uint64 oldsz = p->sz;
    80003cbc:	04853a83          	ld	s5,72(a0)
  sz = PGROUNDUP(sz);
    80003cc0:	6485                	lui	s1,0x1
    80003cc2:	14fd                	addi	s1,s1,-1 # fff <_entry-0x7ffff001>
    80003cc4:	94ca                	add	s1,s1,s2
    80003cc6:	77fd                	lui	a5,0xfffff
    80003cc8:	8cfd                	and	s1,s1,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + (USERSTACK+1)*PGSIZE, PTE_W)) == 0)
    80003cca:	4691                	li	a3,4
    80003ccc:	6609                	lui	a2,0x2
    80003cce:	9626                	add	a2,a2,s1
    80003cd0:	85a6                	mv	a1,s1
    80003cd2:	855a                	mv	a0,s6
    80003cd4:	a75fc0ef          	jal	80000748 <uvmalloc>
    80003cd8:	8a2a                	mv	s4,a0
    80003cda:	ed19                	bnez	a0,80003cf8 <kexec+0x1d2>
    proc_freepagetable(pagetable, sz);
    80003cdc:	85a6                	mv	a1,s1
    80003cde:	855a                	mv	a0,s6
    80003ce0:	9f0fd0ef          	jal	80000ed0 <proc_freepagetable>
  if(ip){
    80003ce4:	79be                	ld	s3,488(sp)
    80003ce6:	7a1e                	ld	s4,480(sp)
    80003ce8:	6afe                	ld	s5,472(sp)
    80003cea:	6b5e                	ld	s6,464(sp)
    80003cec:	6bbe                	ld	s7,456(sp)
    80003cee:	6c1e                	ld	s8,448(sp)
    80003cf0:	7cfa                	ld	s9,440(sp)
    80003cf2:	7d5a                	ld	s10,432(sp)
    80003cf4:	7dba                	ld	s11,424(sp)
    80003cf6:	bd71                	j	80003b92 <kexec+0x6c>
  uvmclear(pagetable, sz-(USERSTACK+1)*PGSIZE);
    80003cf8:	75f9                	lui	a1,0xffffe
    80003cfa:	95aa                	add	a1,a1,a0
    80003cfc:	855a                	mv	a0,s6
    80003cfe:	c0bfc0ef          	jal	80000908 <uvmclear>
  stackbase = sp - USERSTACK*PGSIZE;
    80003d02:	7c7d                	lui	s8,0xfffff
    80003d04:	9c52                	add	s8,s8,s4
  for(argc = 0; argv[argc]; argc++) {
    80003d06:	df843783          	ld	a5,-520(s0)
    80003d0a:	6388                	ld	a0,0(a5)
  sp = sz;
    80003d0c:	8952                	mv	s2,s4
  for(argc = 0; argv[argc]; argc++) {
    80003d0e:	4481                	li	s1,0
    ustack[argc] = sp;
    80003d10:	e9040c93          	addi	s9,s0,-368
    if(argc >= MAXARG)
    80003d14:	02000d13          	li	s10,32
  for(argc = 0; argv[argc]; argc++) {
    80003d18:	cd21                	beqz	a0,80003d70 <kexec+0x24a>
    sp -= strlen(argv[argc]) + 1;
    80003d1a:	da4fc0ef          	jal	800002be <strlen>
    80003d1e:	0015079b          	addiw	a5,a0,1
    80003d22:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80003d26:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    80003d2a:	05896163          	bltu	s2,s8,80003d6c <kexec+0x246>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80003d2e:	df843d83          	ld	s11,-520(s0)
    80003d32:	000dbb83          	ld	s7,0(s11)
    80003d36:	855e                	mv	a0,s7
    80003d38:	d86fc0ef          	jal	800002be <strlen>
    80003d3c:	0015069b          	addiw	a3,a0,1
    80003d40:	865e                	mv	a2,s7
    80003d42:	85ca                	mv	a1,s2
    80003d44:	855a                	mv	a0,s6
    80003d46:	d45fc0ef          	jal	80000a8a <copyout>
    80003d4a:	02054163          	bltz	a0,80003d6c <kexec+0x246>
    ustack[argc] = sp;
    80003d4e:	00349793          	slli	a5,s1,0x3
    80003d52:	97e6                	add	a5,a5,s9
    80003d54:	0127b023          	sd	s2,0(a5) # fffffffffffff000 <end+0xffffffff7ffdc278>
  for(argc = 0; argv[argc]; argc++) {
    80003d58:	0485                	addi	s1,s1,1
    80003d5a:	008d8793          	addi	a5,s11,8
    80003d5e:	def43c23          	sd	a5,-520(s0)
    80003d62:	008db503          	ld	a0,8(s11)
    80003d66:	c509                	beqz	a0,80003d70 <kexec+0x24a>
    if(argc >= MAXARG)
    80003d68:	fba499e3          	bne	s1,s10,80003d1a <kexec+0x1f4>
  sz = sz1;
    80003d6c:	84d2                	mv	s1,s4
    80003d6e:	b7bd                	j	80003cdc <kexec+0x1b6>
  ustack[argc] = 0;
    80003d70:	00349793          	slli	a5,s1,0x3
    80003d74:	f9040713          	addi	a4,s0,-112
    80003d78:	97ba                	add	a5,a5,a4
    80003d7a:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    80003d7e:	00148693          	addi	a3,s1,1
    80003d82:	068e                	slli	a3,a3,0x3
    80003d84:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80003d88:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80003d8c:	ff8960e3          	bltu	s2,s8,80003d6c <kexec+0x246>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80003d90:	e9040613          	addi	a2,s0,-368
    80003d94:	85ca                	mv	a1,s2
    80003d96:	855a                	mv	a0,s6
    80003d98:	cf3fc0ef          	jal	80000a8a <copyout>
    80003d9c:	fc0548e3          	bltz	a0,80003d6c <kexec+0x246>
  p->trapframe->a1 = sp;
    80003da0:	0589b783          	ld	a5,88(s3)
    80003da4:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80003da8:	e0043783          	ld	a5,-512(s0)
    80003dac:	0007c703          	lbu	a4,0(a5)
    80003db0:	cf11                	beqz	a4,80003dcc <kexec+0x2a6>
    80003db2:	0785                	addi	a5,a5,1
    if(*s == '/')
    80003db4:	02f00693          	li	a3,47
    80003db8:	a029                	j	80003dc2 <kexec+0x29c>
  for(last=s=path; *s; s++)
    80003dba:	0785                	addi	a5,a5,1
    80003dbc:	fff7c703          	lbu	a4,-1(a5)
    80003dc0:	c711                	beqz	a4,80003dcc <kexec+0x2a6>
    if(*s == '/')
    80003dc2:	fed71ce3          	bne	a4,a3,80003dba <kexec+0x294>
      last = s+1;
    80003dc6:	e0f43023          	sd	a5,-512(s0)
    80003dca:	bfc5                	j	80003dba <kexec+0x294>
  safestrcpy(p->name, last, sizeof(p->name));
    80003dcc:	4641                	li	a2,16
    80003dce:	e0043583          	ld	a1,-512(s0)
    80003dd2:	15898513          	addi	a0,s3,344
    80003dd6:	cb2fc0ef          	jal	80000288 <safestrcpy>
  oldpagetable = p->pagetable;
    80003dda:	0509b503          	ld	a0,80(s3)
  p->pagetable = pagetable;
    80003dde:	0569b823          	sd	s6,80(s3)
  p->sz = sz;
    80003de2:	0549b423          	sd	s4,72(s3)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80003de6:	0589b783          	ld	a5,88(s3)
    80003dea:	e6843703          	ld	a4,-408(s0)
    80003dee:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80003df0:	0589b783          	ld	a5,88(s3)
    80003df4:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80003df8:	85d6                	mv	a1,s5
    80003dfa:	8d6fd0ef          	jal	80000ed0 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80003dfe:	0004851b          	sext.w	a0,s1
    80003e02:	79be                	ld	s3,488(sp)
    80003e04:	7a1e                	ld	s4,480(sp)
    80003e06:	6afe                	ld	s5,472(sp)
    80003e08:	6b5e                	ld	s6,464(sp)
    80003e0a:	6bbe                	ld	s7,456(sp)
    80003e0c:	6c1e                	ld	s8,448(sp)
    80003e0e:	7cfa                	ld	s9,440(sp)
    80003e10:	7d5a                	ld	s10,432(sp)
    80003e12:	7dba                	ld	s11,424(sp)
    80003e14:	b341                	j	80003b94 <kexec+0x6e>
    80003e16:	6b5e                	ld	s6,464(sp)
    80003e18:	b3bd                	j	80003b86 <kexec+0x60>
    return -1;
    80003e1a:	df243823          	sd	s2,-528(s0)
    proc_freepagetable(pagetable, sz);
    80003e1e:	df043583          	ld	a1,-528(s0)
    80003e22:	855a                	mv	a0,s6
    80003e24:	8acfd0ef          	jal	80000ed0 <proc_freepagetable>
  if(ip){
    80003e28:	79be                	ld	s3,488(sp)
    80003e2a:	6afe                	ld	s5,472(sp)
    80003e2c:	6b5e                	ld	s6,464(sp)
    80003e2e:	6bbe                	ld	s7,456(sp)
    80003e30:	6c1e                	ld	s8,448(sp)
    80003e32:	7cfa                	ld	s9,440(sp)
    80003e34:	7d5a                	ld	s10,432(sp)
    80003e36:	7dba                	ld	s11,424(sp)
    80003e38:	b3b9                	j	80003b86 <kexec+0x60>

0000000080003e3a <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80003e3a:	7179                	addi	sp,sp,-48
    80003e3c:	f406                	sd	ra,40(sp)
    80003e3e:	f022                	sd	s0,32(sp)
    80003e40:	ec26                	sd	s1,24(sp)
    80003e42:	e84a                	sd	s2,16(sp)
    80003e44:	1800                	addi	s0,sp,48
    80003e46:	892e                	mv	s2,a1
    80003e48:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    80003e4a:	fdc40593          	addi	a1,s0,-36
    80003e4e:	df3fd0ef          	jal	80001c40 <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80003e52:	fdc42703          	lw	a4,-36(s0)
    80003e56:	47bd                	li	a5,15
    80003e58:	02e7e963          	bltu	a5,a4,80003e8a <argfd+0x50>
    80003e5c:	ee9fc0ef          	jal	80000d44 <myproc>
    80003e60:	fdc42703          	lw	a4,-36(s0)
    80003e64:	01a70793          	addi	a5,a4,26
    80003e68:	078e                	slli	a5,a5,0x3
    80003e6a:	953e                	add	a0,a0,a5
    80003e6c:	611c                	ld	a5,0(a0)
    80003e6e:	cf91                	beqz	a5,80003e8a <argfd+0x50>
    return -1;
  if(pfd)
    80003e70:	00090463          	beqz	s2,80003e78 <argfd+0x3e>
    *pfd = fd;
    80003e74:	00e92023          	sw	a4,0(s2)
  if(pf)
    80003e78:	c091                	beqz	s1,80003e7c <argfd+0x42>
    *pf = f;
    80003e7a:	e09c                	sd	a5,0(s1)
  return 0;
    80003e7c:	4501                	li	a0,0
}
    80003e7e:	70a2                	ld	ra,40(sp)
    80003e80:	7402                	ld	s0,32(sp)
    80003e82:	64e2                	ld	s1,24(sp)
    80003e84:	6942                	ld	s2,16(sp)
    80003e86:	6145                	addi	sp,sp,48
    80003e88:	8082                	ret
    return -1;
    80003e8a:	557d                	li	a0,-1
    80003e8c:	bfcd                	j	80003e7e <argfd+0x44>

0000000080003e8e <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80003e8e:	1101                	addi	sp,sp,-32
    80003e90:	ec06                	sd	ra,24(sp)
    80003e92:	e822                	sd	s0,16(sp)
    80003e94:	e426                	sd	s1,8(sp)
    80003e96:	1000                	addi	s0,sp,32
    80003e98:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80003e9a:	eabfc0ef          	jal	80000d44 <myproc>
    80003e9e:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80003ea0:	0d050793          	addi	a5,a0,208
    80003ea4:	4501                	li	a0,0
    80003ea6:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80003ea8:	6398                	ld	a4,0(a5)
    80003eaa:	cb19                	beqz	a4,80003ec0 <fdalloc+0x32>
  for(fd = 0; fd < NOFILE; fd++){
    80003eac:	2505                	addiw	a0,a0,1
    80003eae:	07a1                	addi	a5,a5,8
    80003eb0:	fed51ce3          	bne	a0,a3,80003ea8 <fdalloc+0x1a>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80003eb4:	557d                	li	a0,-1
}
    80003eb6:	60e2                	ld	ra,24(sp)
    80003eb8:	6442                	ld	s0,16(sp)
    80003eba:	64a2                	ld	s1,8(sp)
    80003ebc:	6105                	addi	sp,sp,32
    80003ebe:	8082                	ret
      p->ofile[fd] = f;
    80003ec0:	01a50793          	addi	a5,a0,26
    80003ec4:	078e                	slli	a5,a5,0x3
    80003ec6:	963e                	add	a2,a2,a5
    80003ec8:	e204                	sd	s1,0(a2)
      return fd;
    80003eca:	b7f5                	j	80003eb6 <fdalloc+0x28>

0000000080003ecc <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80003ecc:	715d                	addi	sp,sp,-80
    80003ece:	e486                	sd	ra,72(sp)
    80003ed0:	e0a2                	sd	s0,64(sp)
    80003ed2:	fc26                	sd	s1,56(sp)
    80003ed4:	f84a                	sd	s2,48(sp)
    80003ed6:	f44e                	sd	s3,40(sp)
    80003ed8:	f052                	sd	s4,32(sp)
    80003eda:	ec56                	sd	s5,24(sp)
    80003edc:	e85a                	sd	s6,16(sp)
    80003ede:	0880                	addi	s0,sp,80
    80003ee0:	892e                	mv	s2,a1
    80003ee2:	8a2e                	mv	s4,a1
    80003ee4:	8ab2                	mv	s5,a2
    80003ee6:	8b36                	mv	s6,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80003ee8:	fb040593          	addi	a1,s0,-80
    80003eec:	826ff0ef          	jal	80002f12 <nameiparent>
    80003ef0:	84aa                	mv	s1,a0
    return 0;
    80003ef2:	89aa                	mv	s3,a0
  if((dp = nameiparent(path, name)) == 0)
    80003ef4:	cd05                	beqz	a0,80003f2c <create+0x60>

  ilock(dp);
    80003ef6:	fcafe0ef          	jal	800026c0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80003efa:	4601                	li	a2,0
    80003efc:	fb040593          	addi	a1,s0,-80
    80003f00:	8526                	mv	a0,s1
    80003f02:	d5bfe0ef          	jal	80002c5c <dirlookup>
    80003f06:	89aa                	mv	s3,a0
    80003f08:	c131                	beqz	a0,80003f4c <create+0x80>
    iunlockput(dp);
    80003f0a:	8526                	mv	a0,s1
    80003f0c:	9c1fe0ef          	jal	800028cc <iunlockput>
    ilock(ip);
    80003f10:	854e                	mv	a0,s3
    80003f12:	faefe0ef          	jal	800026c0 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80003f16:	4789                	li	a5,2
    80003f18:	02f91563          	bne	s2,a5,80003f42 <create+0x76>
    80003f1c:	0449d783          	lhu	a5,68(s3)
    80003f20:	37f9                	addiw	a5,a5,-2
    80003f22:	17c2                	slli	a5,a5,0x30
    80003f24:	93c1                	srli	a5,a5,0x30
    80003f26:	4705                	li	a4,1
    80003f28:	00f76d63          	bltu	a4,a5,80003f42 <create+0x76>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80003f2c:	854e                	mv	a0,s3
    80003f2e:	60a6                	ld	ra,72(sp)
    80003f30:	6406                	ld	s0,64(sp)
    80003f32:	74e2                	ld	s1,56(sp)
    80003f34:	7942                	ld	s2,48(sp)
    80003f36:	79a2                	ld	s3,40(sp)
    80003f38:	7a02                	ld	s4,32(sp)
    80003f3a:	6ae2                	ld	s5,24(sp)
    80003f3c:	6b42                	ld	s6,16(sp)
    80003f3e:	6161                	addi	sp,sp,80
    80003f40:	8082                	ret
    iunlockput(ip);
    80003f42:	854e                	mv	a0,s3
    80003f44:	989fe0ef          	jal	800028cc <iunlockput>
    return 0;
    80003f48:	4981                	li	s3,0
    80003f4a:	b7cd                	j	80003f2c <create+0x60>
  if((ip = ialloc(dp->dev, type)) == 0){
    80003f4c:	85ca                	mv	a1,s2
    80003f4e:	4088                	lw	a0,0(s1)
    80003f50:	e00fe0ef          	jal	80002550 <ialloc>
    80003f54:	892a                	mv	s2,a0
    80003f56:	cd15                	beqz	a0,80003f92 <create+0xc6>
  ilock(ip);
    80003f58:	f68fe0ef          	jal	800026c0 <ilock>
  ip->major = major;
    80003f5c:	05591323          	sh	s5,70(s2)
  ip->minor = minor;
    80003f60:	05691423          	sh	s6,72(s2)
  ip->nlink = 1;
    80003f64:	4785                	li	a5,1
    80003f66:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80003f6a:	854a                	mv	a0,s2
    80003f6c:	ea0fe0ef          	jal	8000260c <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80003f70:	4705                	li	a4,1
    80003f72:	02ea0463          	beq	s4,a4,80003f9a <create+0xce>
  if(dirlink(dp, name, ip->inum) < 0)
    80003f76:	00492603          	lw	a2,4(s2)
    80003f7a:	fb040593          	addi	a1,s0,-80
    80003f7e:	8526                	mv	a0,s1
    80003f80:	ecffe0ef          	jal	80002e4e <dirlink>
    80003f84:	06054263          	bltz	a0,80003fe8 <create+0x11c>
  iunlockput(dp);
    80003f88:	8526                	mv	a0,s1
    80003f8a:	943fe0ef          	jal	800028cc <iunlockput>
    return 0;
    80003f8e:	89ca                	mv	s3,s2
    80003f90:	bf71                	j	80003f2c <create+0x60>
    iunlockput(dp);
    80003f92:	8526                	mv	a0,s1
    80003f94:	939fe0ef          	jal	800028cc <iunlockput>
    return 0;
    80003f98:	bfdd                	j	80003f8e <create+0xc2>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80003f9a:	00492603          	lw	a2,4(s2)
    80003f9e:	00003597          	auipc	a1,0x3
    80003fa2:	5da58593          	addi	a1,a1,1498 # 80007578 <etext+0x578>
    80003fa6:	854a                	mv	a0,s2
    80003fa8:	ea7fe0ef          	jal	80002e4e <dirlink>
    80003fac:	02054e63          	bltz	a0,80003fe8 <create+0x11c>
    80003fb0:	40d0                	lw	a2,4(s1)
    80003fb2:	00003597          	auipc	a1,0x3
    80003fb6:	5ce58593          	addi	a1,a1,1486 # 80007580 <etext+0x580>
    80003fba:	854a                	mv	a0,s2
    80003fbc:	e93fe0ef          	jal	80002e4e <dirlink>
    80003fc0:	02054463          	bltz	a0,80003fe8 <create+0x11c>
  if(dirlink(dp, name, ip->inum) < 0)
    80003fc4:	00492603          	lw	a2,4(s2)
    80003fc8:	fb040593          	addi	a1,s0,-80
    80003fcc:	8526                	mv	a0,s1
    80003fce:	e81fe0ef          	jal	80002e4e <dirlink>
    80003fd2:	00054b63          	bltz	a0,80003fe8 <create+0x11c>
    dp->nlink++;  // for ".."
    80003fd6:	04a4d783          	lhu	a5,74(s1)
    80003fda:	2785                	addiw	a5,a5,1
    80003fdc:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80003fe0:	8526                	mv	a0,s1
    80003fe2:	e2afe0ef          	jal	8000260c <iupdate>
    80003fe6:	b74d                	j	80003f88 <create+0xbc>
  ip->nlink = 0;
    80003fe8:	04091523          	sh	zero,74(s2)
  iupdate(ip);
    80003fec:	854a                	mv	a0,s2
    80003fee:	e1efe0ef          	jal	8000260c <iupdate>
  iunlockput(ip);
    80003ff2:	854a                	mv	a0,s2
    80003ff4:	8d9fe0ef          	jal	800028cc <iunlockput>
  iunlockput(dp);
    80003ff8:	8526                	mv	a0,s1
    80003ffa:	8d3fe0ef          	jal	800028cc <iunlockput>
  return 0;
    80003ffe:	b73d                	j	80003f2c <create+0x60>

0000000080004000 <sys_dup>:
{
    80004000:	7179                	addi	sp,sp,-48
    80004002:	f406                	sd	ra,40(sp)
    80004004:	f022                	sd	s0,32(sp)
    80004006:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004008:	fd840613          	addi	a2,s0,-40
    8000400c:	4581                	li	a1,0
    8000400e:	4501                	li	a0,0
    80004010:	e2bff0ef          	jal	80003e3a <argfd>
    80004014:	02054863          	bltz	a0,80004044 <sys_dup+0x44>
    80004018:	ec26                	sd	s1,24(sp)
    8000401a:	e84a                	sd	s2,16(sp)
  if((fd=fdalloc(f)) < 0)
    8000401c:	fd843483          	ld	s1,-40(s0)
    80004020:	8526                	mv	a0,s1
    80004022:	e6dff0ef          	jal	80003e8e <fdalloc>
    80004026:	892a                	mv	s2,a0
    80004028:	00054c63          	bltz	a0,80004040 <sys_dup+0x40>
  filedup(f);
    8000402c:	8526                	mv	a0,s1
    8000402e:	c82ff0ef          	jal	800034b0 <filedup>
  return fd;
    80004032:	854a                	mv	a0,s2
    80004034:	64e2                	ld	s1,24(sp)
    80004036:	6942                	ld	s2,16(sp)
}
    80004038:	70a2                	ld	ra,40(sp)
    8000403a:	7402                	ld	s0,32(sp)
    8000403c:	6145                	addi	sp,sp,48
    8000403e:	8082                	ret
    80004040:	64e2                	ld	s1,24(sp)
    80004042:	6942                	ld	s2,16(sp)
    return -1;
    80004044:	557d                	li	a0,-1
    80004046:	bfcd                	j	80004038 <sys_dup+0x38>

0000000080004048 <sys_read>:
{
    80004048:	7179                	addi	sp,sp,-48
    8000404a:	f406                	sd	ra,40(sp)
    8000404c:	f022                	sd	s0,32(sp)
    8000404e:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004050:	fd840593          	addi	a1,s0,-40
    80004054:	4505                	li	a0,1
    80004056:	c07fd0ef          	jal	80001c5c <argaddr>
  argint(2, &n);
    8000405a:	fe440593          	addi	a1,s0,-28
    8000405e:	4509                	li	a0,2
    80004060:	be1fd0ef          	jal	80001c40 <argint>
  if(argfd(0, 0, &f) < 0)
    80004064:	fe840613          	addi	a2,s0,-24
    80004068:	4581                	li	a1,0
    8000406a:	4501                	li	a0,0
    8000406c:	dcfff0ef          	jal	80003e3a <argfd>
    80004070:	87aa                	mv	a5,a0
    return -1;
    80004072:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004074:	0007ca63          	bltz	a5,80004088 <sys_read+0x40>
  return fileread(f, p, n);
    80004078:	fe442603          	lw	a2,-28(s0)
    8000407c:	fd843583          	ld	a1,-40(s0)
    80004080:	fe843503          	ld	a0,-24(s0)
    80004084:	d96ff0ef          	jal	8000361a <fileread>
}
    80004088:	70a2                	ld	ra,40(sp)
    8000408a:	7402                	ld	s0,32(sp)
    8000408c:	6145                	addi	sp,sp,48
    8000408e:	8082                	ret

0000000080004090 <sys_write>:
{
    80004090:	7179                	addi	sp,sp,-48
    80004092:	f406                	sd	ra,40(sp)
    80004094:	f022                	sd	s0,32(sp)
    80004096:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004098:	fd840593          	addi	a1,s0,-40
    8000409c:	4505                	li	a0,1
    8000409e:	bbffd0ef          	jal	80001c5c <argaddr>
  argint(2, &n);
    800040a2:	fe440593          	addi	a1,s0,-28
    800040a6:	4509                	li	a0,2
    800040a8:	b99fd0ef          	jal	80001c40 <argint>
  if(argfd(0, 0, &f) < 0)
    800040ac:	fe840613          	addi	a2,s0,-24
    800040b0:	4581                	li	a1,0
    800040b2:	4501                	li	a0,0
    800040b4:	d87ff0ef          	jal	80003e3a <argfd>
    800040b8:	87aa                	mv	a5,a0
    return -1;
    800040ba:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800040bc:	0007ca63          	bltz	a5,800040d0 <sys_write+0x40>
  return filewrite(f, p, n);
    800040c0:	fe442603          	lw	a2,-28(s0)
    800040c4:	fd843583          	ld	a1,-40(s0)
    800040c8:	fe843503          	ld	a0,-24(s0)
    800040cc:	e08ff0ef          	jal	800036d4 <filewrite>
}
    800040d0:	70a2                	ld	ra,40(sp)
    800040d2:	7402                	ld	s0,32(sp)
    800040d4:	6145                	addi	sp,sp,48
    800040d6:	8082                	ret

00000000800040d8 <sys_close>:
{
    800040d8:	1101                	addi	sp,sp,-32
    800040da:	ec06                	sd	ra,24(sp)
    800040dc:	e822                	sd	s0,16(sp)
    800040de:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800040e0:	fe040613          	addi	a2,s0,-32
    800040e4:	fec40593          	addi	a1,s0,-20
    800040e8:	4501                	li	a0,0
    800040ea:	d51ff0ef          	jal	80003e3a <argfd>
    return -1;
    800040ee:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    800040f0:	02054063          	bltz	a0,80004110 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
    800040f4:	c51fc0ef          	jal	80000d44 <myproc>
    800040f8:	fec42783          	lw	a5,-20(s0)
    800040fc:	07e9                	addi	a5,a5,26
    800040fe:	078e                	slli	a5,a5,0x3
    80004100:	953e                	add	a0,a0,a5
    80004102:	00053023          	sd	zero,0(a0)
  fileclose(f);
    80004106:	fe043503          	ld	a0,-32(s0)
    8000410a:	becff0ef          	jal	800034f6 <fileclose>
  return 0;
    8000410e:	4781                	li	a5,0
}
    80004110:	853e                	mv	a0,a5
    80004112:	60e2                	ld	ra,24(sp)
    80004114:	6442                	ld	s0,16(sp)
    80004116:	6105                	addi	sp,sp,32
    80004118:	8082                	ret

000000008000411a <sys_fstat>:
{
    8000411a:	1101                	addi	sp,sp,-32
    8000411c:	ec06                	sd	ra,24(sp)
    8000411e:	e822                	sd	s0,16(sp)
    80004120:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    80004122:	fe040593          	addi	a1,s0,-32
    80004126:	4505                	li	a0,1
    80004128:	b35fd0ef          	jal	80001c5c <argaddr>
  if(argfd(0, 0, &f) < 0)
    8000412c:	fe840613          	addi	a2,s0,-24
    80004130:	4581                	li	a1,0
    80004132:	4501                	li	a0,0
    80004134:	d07ff0ef          	jal	80003e3a <argfd>
    80004138:	87aa                	mv	a5,a0
    return -1;
    8000413a:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    8000413c:	0007c863          	bltz	a5,8000414c <sys_fstat+0x32>
  return filestat(f, st);
    80004140:	fe043583          	ld	a1,-32(s0)
    80004144:	fe843503          	ld	a0,-24(s0)
    80004148:	c70ff0ef          	jal	800035b8 <filestat>
}
    8000414c:	60e2                	ld	ra,24(sp)
    8000414e:	6442                	ld	s0,16(sp)
    80004150:	6105                	addi	sp,sp,32
    80004152:	8082                	ret

0000000080004154 <sys_link>:
{
    80004154:	7169                	addi	sp,sp,-304
    80004156:	f606                	sd	ra,296(sp)
    80004158:	f222                	sd	s0,288(sp)
    8000415a:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000415c:	08000613          	li	a2,128
    80004160:	ed040593          	addi	a1,s0,-304
    80004164:	4501                	li	a0,0
    80004166:	b13fd0ef          	jal	80001c78 <argstr>
    8000416a:	0c054a63          	bltz	a0,8000423e <sys_link+0xea>
    8000416e:	08000613          	li	a2,128
    80004172:	f5040593          	addi	a1,s0,-176
    80004176:	4505                	li	a0,1
    80004178:	b01fd0ef          	jal	80001c78 <argstr>
    8000417c:	0c054163          	bltz	a0,8000423e <sys_link+0xea>
    80004180:	ee26                	sd	s1,280(sp)
  begin_op();
    80004182:	f55fe0ef          	jal	800030d6 <begin_op>
  if((ip = namei(old)) == 0){
    80004186:	ed040513          	addi	a0,s0,-304
    8000418a:	d6ffe0ef          	jal	80002ef8 <namei>
    8000418e:	84aa                	mv	s1,a0
    80004190:	c53d                	beqz	a0,800041fe <sys_link+0xaa>
  ilock(ip);
    80004192:	d2efe0ef          	jal	800026c0 <ilock>
  if(ip->type == T_DIR){
    80004196:	04449703          	lh	a4,68(s1)
    8000419a:	4785                	li	a5,1
    8000419c:	06f70563          	beq	a4,a5,80004206 <sys_link+0xb2>
    800041a0:	ea4a                	sd	s2,272(sp)
  ip->nlink++;
    800041a2:	04a4d783          	lhu	a5,74(s1)
    800041a6:	2785                	addiw	a5,a5,1
    800041a8:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800041ac:	8526                	mv	a0,s1
    800041ae:	c5efe0ef          	jal	8000260c <iupdate>
  iunlock(ip);
    800041b2:	8526                	mv	a0,s1
    800041b4:	dbafe0ef          	jal	8000276e <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    800041b8:	fd040593          	addi	a1,s0,-48
    800041bc:	f5040513          	addi	a0,s0,-176
    800041c0:	d53fe0ef          	jal	80002f12 <nameiparent>
    800041c4:	892a                	mv	s2,a0
    800041c6:	c931                	beqz	a0,8000421a <sys_link+0xc6>
  ilock(dp);
    800041c8:	cf8fe0ef          	jal	800026c0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    800041cc:	854a                	mv	a0,s2
    800041ce:	00092703          	lw	a4,0(s2)
    800041d2:	409c                	lw	a5,0(s1)
    800041d4:	04f71063          	bne	a4,a5,80004214 <sys_link+0xc0>
    800041d8:	40d0                	lw	a2,4(s1)
    800041da:	fd040593          	addi	a1,s0,-48
    800041de:	c71fe0ef          	jal	80002e4e <dirlink>
    800041e2:	02054963          	bltz	a0,80004214 <sys_link+0xc0>
  iunlockput(dp);
    800041e6:	854a                	mv	a0,s2
    800041e8:	ee4fe0ef          	jal	800028cc <iunlockput>
  iput(ip);
    800041ec:	8526                	mv	a0,s1
    800041ee:	e54fe0ef          	jal	80002842 <iput>
  end_op();
    800041f2:	f55fe0ef          	jal	80003146 <end_op>
  return 0;
    800041f6:	4501                	li	a0,0
    800041f8:	64f2                	ld	s1,280(sp)
    800041fa:	6952                	ld	s2,272(sp)
    800041fc:	a091                	j	80004240 <sys_link+0xec>
    end_op();
    800041fe:	f49fe0ef          	jal	80003146 <end_op>
    return -1;
    80004202:	64f2                	ld	s1,280(sp)
    80004204:	a82d                	j	8000423e <sys_link+0xea>
    iunlockput(ip);
    80004206:	8526                	mv	a0,s1
    80004208:	ec4fe0ef          	jal	800028cc <iunlockput>
    end_op();
    8000420c:	f3bfe0ef          	jal	80003146 <end_op>
    return -1;
    80004210:	64f2                	ld	s1,280(sp)
    80004212:	a035                	j	8000423e <sys_link+0xea>
    iunlockput(dp);
    80004214:	854a                	mv	a0,s2
    80004216:	eb6fe0ef          	jal	800028cc <iunlockput>
  ilock(ip);
    8000421a:	8526                	mv	a0,s1
    8000421c:	ca4fe0ef          	jal	800026c0 <ilock>
  ip->nlink--;
    80004220:	04a4d783          	lhu	a5,74(s1)
    80004224:	37fd                	addiw	a5,a5,-1
    80004226:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    8000422a:	8526                	mv	a0,s1
    8000422c:	be0fe0ef          	jal	8000260c <iupdate>
  iunlockput(ip);
    80004230:	8526                	mv	a0,s1
    80004232:	e9afe0ef          	jal	800028cc <iunlockput>
  end_op();
    80004236:	f11fe0ef          	jal	80003146 <end_op>
  return -1;
    8000423a:	64f2                	ld	s1,280(sp)
    8000423c:	6952                	ld	s2,272(sp)
    return -1;
    8000423e:	557d                	li	a0,-1
}
    80004240:	70b2                	ld	ra,296(sp)
    80004242:	7412                	ld	s0,288(sp)
    80004244:	6155                	addi	sp,sp,304
    80004246:	8082                	ret

0000000080004248 <sys_unlink>:
{
    80004248:	7151                	addi	sp,sp,-240
    8000424a:	f586                	sd	ra,232(sp)
    8000424c:	f1a2                	sd	s0,224(sp)
    8000424e:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004250:	08000613          	li	a2,128
    80004254:	f3040593          	addi	a1,s0,-208
    80004258:	4501                	li	a0,0
    8000425a:	a1ffd0ef          	jal	80001c78 <argstr>
    8000425e:	14054763          	bltz	a0,800043ac <sys_unlink+0x164>
    80004262:	eda6                	sd	s1,216(sp)
  begin_op();
    80004264:	e73fe0ef          	jal	800030d6 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004268:	fb040593          	addi	a1,s0,-80
    8000426c:	f3040513          	addi	a0,s0,-208
    80004270:	ca3fe0ef          	jal	80002f12 <nameiparent>
    80004274:	84aa                	mv	s1,a0
    80004276:	c955                	beqz	a0,8000432a <sys_unlink+0xe2>
  ilock(dp);
    80004278:	c48fe0ef          	jal	800026c0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    8000427c:	00003597          	auipc	a1,0x3
    80004280:	2fc58593          	addi	a1,a1,764 # 80007578 <etext+0x578>
    80004284:	fb040513          	addi	a0,s0,-80
    80004288:	9bffe0ef          	jal	80002c46 <namecmp>
    8000428c:	10050a63          	beqz	a0,800043a0 <sys_unlink+0x158>
    80004290:	00003597          	auipc	a1,0x3
    80004294:	2f058593          	addi	a1,a1,752 # 80007580 <etext+0x580>
    80004298:	fb040513          	addi	a0,s0,-80
    8000429c:	9abfe0ef          	jal	80002c46 <namecmp>
    800042a0:	10050063          	beqz	a0,800043a0 <sys_unlink+0x158>
    800042a4:	e9ca                	sd	s2,208(sp)
  if((ip = dirlookup(dp, name, &off)) == 0)
    800042a6:	f2c40613          	addi	a2,s0,-212
    800042aa:	fb040593          	addi	a1,s0,-80
    800042ae:	8526                	mv	a0,s1
    800042b0:	9adfe0ef          	jal	80002c5c <dirlookup>
    800042b4:	892a                	mv	s2,a0
    800042b6:	0e050463          	beqz	a0,8000439e <sys_unlink+0x156>
    800042ba:	e5ce                	sd	s3,200(sp)
  ilock(ip);
    800042bc:	c04fe0ef          	jal	800026c0 <ilock>
  if(ip->nlink < 1)
    800042c0:	04a91783          	lh	a5,74(s2)
    800042c4:	06f05763          	blez	a5,80004332 <sys_unlink+0xea>
  if(ip->type == T_DIR && !isdirempty(ip)){
    800042c8:	04491703          	lh	a4,68(s2)
    800042cc:	4785                	li	a5,1
    800042ce:	06f70863          	beq	a4,a5,8000433e <sys_unlink+0xf6>
  memset(&de, 0, sizeof(de));
    800042d2:	fc040993          	addi	s3,s0,-64
    800042d6:	4641                	li	a2,16
    800042d8:	4581                	li	a1,0
    800042da:	854e                	mv	a0,s3
    800042dc:	e63fb0ef          	jal	8000013e <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800042e0:	4741                	li	a4,16
    800042e2:	f2c42683          	lw	a3,-212(s0)
    800042e6:	864e                	mv	a2,s3
    800042e8:	4581                	li	a1,0
    800042ea:	8526                	mv	a0,s1
    800042ec:	859fe0ef          	jal	80002b44 <writei>
    800042f0:	47c1                	li	a5,16
    800042f2:	08f51763          	bne	a0,a5,80004380 <sys_unlink+0x138>
  if(ip->type == T_DIR){
    800042f6:	04491703          	lh	a4,68(s2)
    800042fa:	4785                	li	a5,1
    800042fc:	08f70863          	beq	a4,a5,8000438c <sys_unlink+0x144>
  iunlockput(dp);
    80004300:	8526                	mv	a0,s1
    80004302:	dcafe0ef          	jal	800028cc <iunlockput>
  ip->nlink--;
    80004306:	04a95783          	lhu	a5,74(s2)
    8000430a:	37fd                	addiw	a5,a5,-1
    8000430c:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004310:	854a                	mv	a0,s2
    80004312:	afafe0ef          	jal	8000260c <iupdate>
  iunlockput(ip);
    80004316:	854a                	mv	a0,s2
    80004318:	db4fe0ef          	jal	800028cc <iunlockput>
  end_op();
    8000431c:	e2bfe0ef          	jal	80003146 <end_op>
  return 0;
    80004320:	4501                	li	a0,0
    80004322:	64ee                	ld	s1,216(sp)
    80004324:	694e                	ld	s2,208(sp)
    80004326:	69ae                	ld	s3,200(sp)
    80004328:	a059                	j	800043ae <sys_unlink+0x166>
    end_op();
    8000432a:	e1dfe0ef          	jal	80003146 <end_op>
    return -1;
    8000432e:	64ee                	ld	s1,216(sp)
    80004330:	a8b5                	j	800043ac <sys_unlink+0x164>
    panic("unlink: nlink < 1");
    80004332:	00003517          	auipc	a0,0x3
    80004336:	25650513          	addi	a0,a0,598 # 80007588 <etext+0x588>
    8000433a:	2da010ef          	jal	80005614 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    8000433e:	04c92703          	lw	a4,76(s2)
    80004342:	02000793          	li	a5,32
    80004346:	f8e7f6e3          	bgeu	a5,a4,800042d2 <sys_unlink+0x8a>
    8000434a:	89be                	mv	s3,a5
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000434c:	4741                	li	a4,16
    8000434e:	86ce                	mv	a3,s3
    80004350:	f1840613          	addi	a2,s0,-232
    80004354:	4581                	li	a1,0
    80004356:	854a                	mv	a0,s2
    80004358:	efafe0ef          	jal	80002a52 <readi>
    8000435c:	47c1                	li	a5,16
    8000435e:	00f51b63          	bne	a0,a5,80004374 <sys_unlink+0x12c>
    if(de.inum != 0)
    80004362:	f1845783          	lhu	a5,-232(s0)
    80004366:	eba1                	bnez	a5,800043b6 <sys_unlink+0x16e>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004368:	29c1                	addiw	s3,s3,16
    8000436a:	04c92783          	lw	a5,76(s2)
    8000436e:	fcf9efe3          	bltu	s3,a5,8000434c <sys_unlink+0x104>
    80004372:	b785                	j	800042d2 <sys_unlink+0x8a>
      panic("isdirempty: readi");
    80004374:	00003517          	auipc	a0,0x3
    80004378:	22c50513          	addi	a0,a0,556 # 800075a0 <etext+0x5a0>
    8000437c:	298010ef          	jal	80005614 <panic>
    panic("unlink: writei");
    80004380:	00003517          	auipc	a0,0x3
    80004384:	23850513          	addi	a0,a0,568 # 800075b8 <etext+0x5b8>
    80004388:	28c010ef          	jal	80005614 <panic>
    dp->nlink--;
    8000438c:	04a4d783          	lhu	a5,74(s1)
    80004390:	37fd                	addiw	a5,a5,-1
    80004392:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004396:	8526                	mv	a0,s1
    80004398:	a74fe0ef          	jal	8000260c <iupdate>
    8000439c:	b795                	j	80004300 <sys_unlink+0xb8>
    8000439e:	694e                	ld	s2,208(sp)
  iunlockput(dp);
    800043a0:	8526                	mv	a0,s1
    800043a2:	d2afe0ef          	jal	800028cc <iunlockput>
  end_op();
    800043a6:	da1fe0ef          	jal	80003146 <end_op>
  return -1;
    800043aa:	64ee                	ld	s1,216(sp)
    return -1;
    800043ac:	557d                	li	a0,-1
}
    800043ae:	70ae                	ld	ra,232(sp)
    800043b0:	740e                	ld	s0,224(sp)
    800043b2:	616d                	addi	sp,sp,240
    800043b4:	8082                	ret
    iunlockput(ip);
    800043b6:	854a                	mv	a0,s2
    800043b8:	d14fe0ef          	jal	800028cc <iunlockput>
    goto bad;
    800043bc:	694e                	ld	s2,208(sp)
    800043be:	69ae                	ld	s3,200(sp)
    800043c0:	b7c5                	j	800043a0 <sys_unlink+0x158>

00000000800043c2 <sys_open>:

uint64
sys_open(void)
{
    800043c2:	7131                	addi	sp,sp,-192
    800043c4:	fd06                	sd	ra,184(sp)
    800043c6:	f922                	sd	s0,176(sp)
    800043c8:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    800043ca:	f4c40593          	addi	a1,s0,-180
    800043ce:	4505                	li	a0,1
    800043d0:	871fd0ef          	jal	80001c40 <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    800043d4:	08000613          	li	a2,128
    800043d8:	f5040593          	addi	a1,s0,-176
    800043dc:	4501                	li	a0,0
    800043de:	89bfd0ef          	jal	80001c78 <argstr>
    800043e2:	10054563          	bltz	a0,800044ec <sys_open+0x12a>
    800043e6:	f526                	sd	s1,168(sp)
    return -1;

  begin_op();
    800043e8:	ceffe0ef          	jal	800030d6 <begin_op>

  if(omode & O_CREATE){
    800043ec:	f4c42783          	lw	a5,-180(s0)
    800043f0:	2007f793          	andi	a5,a5,512
    800043f4:	cfd9                	beqz	a5,80004492 <sys_open+0xd0>
    ip = create(path, T_FILE, 0, 0);
    800043f6:	4681                	li	a3,0
    800043f8:	4601                	li	a2,0
    800043fa:	4589                	li	a1,2
    800043fc:	f5040513          	addi	a0,s0,-176
    80004400:	acdff0ef          	jal	80003ecc <create>
    80004404:	84aa                	mv	s1,a0
    if(ip == 0){
    80004406:	c151                	beqz	a0,8000448a <sys_open+0xc8>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004408:	04449703          	lh	a4,68(s1)
    8000440c:	478d                	li	a5,3
    8000440e:	00f71763          	bne	a4,a5,8000441c <sys_open+0x5a>
    80004412:	0464d703          	lhu	a4,70(s1)
    80004416:	47a5                	li	a5,9
    80004418:	0ae7e863          	bltu	a5,a4,800044c8 <sys_open+0x106>
    8000441c:	f14a                	sd	s2,160(sp)
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    8000441e:	834ff0ef          	jal	80003452 <filealloc>
    80004422:	892a                	mv	s2,a0
    80004424:	cd4d                	beqz	a0,800044de <sys_open+0x11c>
    80004426:	ed4e                	sd	s3,152(sp)
    80004428:	a67ff0ef          	jal	80003e8e <fdalloc>
    8000442c:	89aa                	mv	s3,a0
    8000442e:	0a054463          	bltz	a0,800044d6 <sys_open+0x114>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004432:	04449703          	lh	a4,68(s1)
    80004436:	478d                	li	a5,3
    80004438:	0af70f63          	beq	a4,a5,800044f6 <sys_open+0x134>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    8000443c:	4789                	li	a5,2
    8000443e:	00f92023          	sw	a5,0(s2)
    f->off = 0;
    80004442:	02092023          	sw	zero,32(s2)
  }
  f->ip = ip;
    80004446:	00993c23          	sd	s1,24(s2)
  f->readable = !(omode & O_WRONLY);
    8000444a:	f4c42783          	lw	a5,-180(s0)
    8000444e:	0017f713          	andi	a4,a5,1
    80004452:	00174713          	xori	a4,a4,1
    80004456:	00e90423          	sb	a4,8(s2)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    8000445a:	0037f713          	andi	a4,a5,3
    8000445e:	00e03733          	snez	a4,a4
    80004462:	00e904a3          	sb	a4,9(s2)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004466:	4007f793          	andi	a5,a5,1024
    8000446a:	c791                	beqz	a5,80004476 <sys_open+0xb4>
    8000446c:	04449703          	lh	a4,68(s1)
    80004470:	4789                	li	a5,2
    80004472:	08f70963          	beq	a4,a5,80004504 <sys_open+0x142>
    itrunc(ip);
  }

  iunlock(ip);
    80004476:	8526                	mv	a0,s1
    80004478:	af6fe0ef          	jal	8000276e <iunlock>
  end_op();
    8000447c:	ccbfe0ef          	jal	80003146 <end_op>

  return fd;
    80004480:	854e                	mv	a0,s3
    80004482:	74aa                	ld	s1,168(sp)
    80004484:	790a                	ld	s2,160(sp)
    80004486:	69ea                	ld	s3,152(sp)
    80004488:	a09d                	j	800044ee <sys_open+0x12c>
      end_op();
    8000448a:	cbdfe0ef          	jal	80003146 <end_op>
      return -1;
    8000448e:	74aa                	ld	s1,168(sp)
    80004490:	a8b1                	j	800044ec <sys_open+0x12a>
    if((ip = namei(path)) == 0){
    80004492:	f5040513          	addi	a0,s0,-176
    80004496:	a63fe0ef          	jal	80002ef8 <namei>
    8000449a:	84aa                	mv	s1,a0
    8000449c:	c115                	beqz	a0,800044c0 <sys_open+0xfe>
    ilock(ip);
    8000449e:	a22fe0ef          	jal	800026c0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    800044a2:	04449703          	lh	a4,68(s1)
    800044a6:	4785                	li	a5,1
    800044a8:	f6f710e3          	bne	a4,a5,80004408 <sys_open+0x46>
    800044ac:	f4c42783          	lw	a5,-180(s0)
    800044b0:	d7b5                	beqz	a5,8000441c <sys_open+0x5a>
      iunlockput(ip);
    800044b2:	8526                	mv	a0,s1
    800044b4:	c18fe0ef          	jal	800028cc <iunlockput>
      end_op();
    800044b8:	c8ffe0ef          	jal	80003146 <end_op>
      return -1;
    800044bc:	74aa                	ld	s1,168(sp)
    800044be:	a03d                	j	800044ec <sys_open+0x12a>
      end_op();
    800044c0:	c87fe0ef          	jal	80003146 <end_op>
      return -1;
    800044c4:	74aa                	ld	s1,168(sp)
    800044c6:	a01d                	j	800044ec <sys_open+0x12a>
    iunlockput(ip);
    800044c8:	8526                	mv	a0,s1
    800044ca:	c02fe0ef          	jal	800028cc <iunlockput>
    end_op();
    800044ce:	c79fe0ef          	jal	80003146 <end_op>
    return -1;
    800044d2:	74aa                	ld	s1,168(sp)
    800044d4:	a821                	j	800044ec <sys_open+0x12a>
      fileclose(f);
    800044d6:	854a                	mv	a0,s2
    800044d8:	81eff0ef          	jal	800034f6 <fileclose>
    800044dc:	69ea                	ld	s3,152(sp)
    iunlockput(ip);
    800044de:	8526                	mv	a0,s1
    800044e0:	becfe0ef          	jal	800028cc <iunlockput>
    end_op();
    800044e4:	c63fe0ef          	jal	80003146 <end_op>
    return -1;
    800044e8:	74aa                	ld	s1,168(sp)
    800044ea:	790a                	ld	s2,160(sp)
    return -1;
    800044ec:	557d                	li	a0,-1
}
    800044ee:	70ea                	ld	ra,184(sp)
    800044f0:	744a                	ld	s0,176(sp)
    800044f2:	6129                	addi	sp,sp,192
    800044f4:	8082                	ret
    f->type = FD_DEVICE;
    800044f6:	00e92023          	sw	a4,0(s2)
    f->major = ip->major;
    800044fa:	04649783          	lh	a5,70(s1)
    800044fe:	02f91223          	sh	a5,36(s2)
    80004502:	b791                	j	80004446 <sys_open+0x84>
    itrunc(ip);
    80004504:	8526                	mv	a0,s1
    80004506:	aa8fe0ef          	jal	800027ae <itrunc>
    8000450a:	b7b5                	j	80004476 <sys_open+0xb4>

000000008000450c <sys_mkdir>:

uint64
sys_mkdir(void)
{
    8000450c:	7175                	addi	sp,sp,-144
    8000450e:	e506                	sd	ra,136(sp)
    80004510:	e122                	sd	s0,128(sp)
    80004512:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004514:	bc3fe0ef          	jal	800030d6 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004518:	08000613          	li	a2,128
    8000451c:	f7040593          	addi	a1,s0,-144
    80004520:	4501                	li	a0,0
    80004522:	f56fd0ef          	jal	80001c78 <argstr>
    80004526:	02054363          	bltz	a0,8000454c <sys_mkdir+0x40>
    8000452a:	4681                	li	a3,0
    8000452c:	4601                	li	a2,0
    8000452e:	4585                	li	a1,1
    80004530:	f7040513          	addi	a0,s0,-144
    80004534:	999ff0ef          	jal	80003ecc <create>
    80004538:	c911                	beqz	a0,8000454c <sys_mkdir+0x40>
    end_op();
    return -1;
  }
  iunlockput(ip);
    8000453a:	b92fe0ef          	jal	800028cc <iunlockput>
  end_op();
    8000453e:	c09fe0ef          	jal	80003146 <end_op>
  return 0;
    80004542:	4501                	li	a0,0
}
    80004544:	60aa                	ld	ra,136(sp)
    80004546:	640a                	ld	s0,128(sp)
    80004548:	6149                	addi	sp,sp,144
    8000454a:	8082                	ret
    end_op();
    8000454c:	bfbfe0ef          	jal	80003146 <end_op>
    return -1;
    80004550:	557d                	li	a0,-1
    80004552:	bfcd                	j	80004544 <sys_mkdir+0x38>

0000000080004554 <sys_mknod>:

uint64
sys_mknod(void)
{
    80004554:	7135                	addi	sp,sp,-160
    80004556:	ed06                	sd	ra,152(sp)
    80004558:	e922                	sd	s0,144(sp)
    8000455a:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    8000455c:	b7bfe0ef          	jal	800030d6 <begin_op>
  argint(1, &major);
    80004560:	f6c40593          	addi	a1,s0,-148
    80004564:	4505                	li	a0,1
    80004566:	edafd0ef          	jal	80001c40 <argint>
  argint(2, &minor);
    8000456a:	f6840593          	addi	a1,s0,-152
    8000456e:	4509                	li	a0,2
    80004570:	ed0fd0ef          	jal	80001c40 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004574:	08000613          	li	a2,128
    80004578:	f7040593          	addi	a1,s0,-144
    8000457c:	4501                	li	a0,0
    8000457e:	efafd0ef          	jal	80001c78 <argstr>
    80004582:	02054563          	bltz	a0,800045ac <sys_mknod+0x58>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004586:	f6841683          	lh	a3,-152(s0)
    8000458a:	f6c41603          	lh	a2,-148(s0)
    8000458e:	458d                	li	a1,3
    80004590:	f7040513          	addi	a0,s0,-144
    80004594:	939ff0ef          	jal	80003ecc <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004598:	c911                	beqz	a0,800045ac <sys_mknod+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
    8000459a:	b32fe0ef          	jal	800028cc <iunlockput>
  end_op();
    8000459e:	ba9fe0ef          	jal	80003146 <end_op>
  return 0;
    800045a2:	4501                	li	a0,0
}
    800045a4:	60ea                	ld	ra,152(sp)
    800045a6:	644a                	ld	s0,144(sp)
    800045a8:	610d                	addi	sp,sp,160
    800045aa:	8082                	ret
    end_op();
    800045ac:	b9bfe0ef          	jal	80003146 <end_op>
    return -1;
    800045b0:	557d                	li	a0,-1
    800045b2:	bfcd                	j	800045a4 <sys_mknod+0x50>

00000000800045b4 <sys_chdir>:

uint64
sys_chdir(void)
{
    800045b4:	7135                	addi	sp,sp,-160
    800045b6:	ed06                	sd	ra,152(sp)
    800045b8:	e922                	sd	s0,144(sp)
    800045ba:	e14a                	sd	s2,128(sp)
    800045bc:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    800045be:	f86fc0ef          	jal	80000d44 <myproc>
    800045c2:	892a                	mv	s2,a0
  
  begin_op();
    800045c4:	b13fe0ef          	jal	800030d6 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    800045c8:	08000613          	li	a2,128
    800045cc:	f6040593          	addi	a1,s0,-160
    800045d0:	4501                	li	a0,0
    800045d2:	ea6fd0ef          	jal	80001c78 <argstr>
    800045d6:	02054f63          	bltz	a0,80004614 <sys_chdir+0x60>
    800045da:	e526                	sd	s1,136(sp)
    800045dc:	f6040513          	addi	a0,s0,-160
    800045e0:	919fe0ef          	jal	80002ef8 <namei>
    800045e4:	84aa                	mv	s1,a0
    800045e6:	c515                	beqz	a0,80004612 <sys_chdir+0x5e>
    end_op();
    return -1;
  }
  ilock(ip);
    800045e8:	8d8fe0ef          	jal	800026c0 <ilock>
  if(ip->type != T_DIR){
    800045ec:	04449703          	lh	a4,68(s1)
    800045f0:	4785                	li	a5,1
    800045f2:	02f71963          	bne	a4,a5,80004624 <sys_chdir+0x70>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    800045f6:	8526                	mv	a0,s1
    800045f8:	976fe0ef          	jal	8000276e <iunlock>
  iput(p->cwd);
    800045fc:	15093503          	ld	a0,336(s2)
    80004600:	a42fe0ef          	jal	80002842 <iput>
  end_op();
    80004604:	b43fe0ef          	jal	80003146 <end_op>
  p->cwd = ip;
    80004608:	14993823          	sd	s1,336(s2)
  return 0;
    8000460c:	4501                	li	a0,0
    8000460e:	64aa                	ld	s1,136(sp)
    80004610:	a029                	j	8000461a <sys_chdir+0x66>
    80004612:	64aa                	ld	s1,136(sp)
    end_op();
    80004614:	b33fe0ef          	jal	80003146 <end_op>
    return -1;
    80004618:	557d                	li	a0,-1
}
    8000461a:	60ea                	ld	ra,152(sp)
    8000461c:	644a                	ld	s0,144(sp)
    8000461e:	690a                	ld	s2,128(sp)
    80004620:	610d                	addi	sp,sp,160
    80004622:	8082                	ret
    iunlockput(ip);
    80004624:	8526                	mv	a0,s1
    80004626:	aa6fe0ef          	jal	800028cc <iunlockput>
    end_op();
    8000462a:	b1dfe0ef          	jal	80003146 <end_op>
    return -1;
    8000462e:	64aa                	ld	s1,136(sp)
    80004630:	b7e5                	j	80004618 <sys_chdir+0x64>

0000000080004632 <sys_exec>:

uint64
sys_exec(void)
{
    80004632:	7105                	addi	sp,sp,-480
    80004634:	ef86                	sd	ra,472(sp)
    80004636:	eba2                	sd	s0,464(sp)
    80004638:	1380                	addi	s0,sp,480
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    8000463a:	e2840593          	addi	a1,s0,-472
    8000463e:	4505                	li	a0,1
    80004640:	e1cfd0ef          	jal	80001c5c <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80004644:	08000613          	li	a2,128
    80004648:	f3040593          	addi	a1,s0,-208
    8000464c:	4501                	li	a0,0
    8000464e:	e2afd0ef          	jal	80001c78 <argstr>
    80004652:	0c054e63          	bltz	a0,8000472e <sys_exec+0xfc>
    80004656:	e7a6                	sd	s1,456(sp)
    80004658:	e3ca                	sd	s2,448(sp)
    8000465a:	ff4e                	sd	s3,440(sp)
    8000465c:	fb52                	sd	s4,432(sp)
    8000465e:	f756                	sd	s5,424(sp)
    80004660:	f35a                	sd	s6,416(sp)
    80004662:	ef5e                	sd	s7,408(sp)
    return -1;
  }
  memset(argv, 0, sizeof(argv));
    80004664:	e3040a13          	addi	s4,s0,-464
    80004668:	10000613          	li	a2,256
    8000466c:	4581                	li	a1,0
    8000466e:	8552                	mv	a0,s4
    80004670:	acffb0ef          	jal	8000013e <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80004674:	84d2                	mv	s1,s4
  memset(argv, 0, sizeof(argv));
    80004676:	89d2                	mv	s3,s4
    80004678:	4901                	li	s2,0
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    8000467a:	e2040a93          	addi	s5,s0,-480
      break;
    }
    argv[i] = kalloc();
    if(argv[i] == 0)
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    8000467e:	6b05                	lui	s6,0x1
    if(i >= NELEM(argv)){
    80004680:	02000b93          	li	s7,32
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004684:	00391513          	slli	a0,s2,0x3
    80004688:	85d6                	mv	a1,s5
    8000468a:	e2843783          	ld	a5,-472(s0)
    8000468e:	953e                	add	a0,a0,a5
    80004690:	d2afd0ef          	jal	80001bba <fetchaddr>
    80004694:	02054663          	bltz	a0,800046c0 <sys_exec+0x8e>
    if(uarg == 0){
    80004698:	e2043783          	ld	a5,-480(s0)
    8000469c:	c3b9                	beqz	a5,800046e2 <sys_exec+0xb0>
    argv[i] = kalloc();
    8000469e:	a5ffb0ef          	jal	800000fc <kalloc>
    800046a2:	85aa                	mv	a1,a0
    800046a4:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    800046a8:	cd01                	beqz	a0,800046c0 <sys_exec+0x8e>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800046aa:	865a                	mv	a2,s6
    800046ac:	e2043503          	ld	a0,-480(s0)
    800046b0:	d50fd0ef          	jal	80001c00 <fetchstr>
    800046b4:	00054663          	bltz	a0,800046c0 <sys_exec+0x8e>
    if(i >= NELEM(argv)){
    800046b8:	0905                	addi	s2,s2,1
    800046ba:	09a1                	addi	s3,s3,8
    800046bc:	fd7914e3          	bne	s2,s7,80004684 <sys_exec+0x52>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800046c0:	100a0a13          	addi	s4,s4,256
    800046c4:	6088                	ld	a0,0(s1)
    800046c6:	cd29                	beqz	a0,80004720 <sys_exec+0xee>
    kfree(argv[i]);
    800046c8:	955fb0ef          	jal	8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800046cc:	04a1                	addi	s1,s1,8
    800046ce:	ff449be3          	bne	s1,s4,800046c4 <sys_exec+0x92>
    800046d2:	64be                	ld	s1,456(sp)
    800046d4:	691e                	ld	s2,448(sp)
    800046d6:	79fa                	ld	s3,440(sp)
    800046d8:	7a5a                	ld	s4,432(sp)
    800046da:	7aba                	ld	s5,424(sp)
    800046dc:	7b1a                	ld	s6,416(sp)
    800046de:	6bfa                	ld	s7,408(sp)
    800046e0:	a0b9                	j	8000472e <sys_exec+0xfc>
      argv[i] = 0;
    800046e2:	0009079b          	sext.w	a5,s2
    800046e6:	e3040593          	addi	a1,s0,-464
    800046ea:	078e                	slli	a5,a5,0x3
    800046ec:	97ae                	add	a5,a5,a1
    800046ee:	0007b023          	sd	zero,0(a5)
  int ret = kexec(path, argv);
    800046f2:	f3040513          	addi	a0,s0,-208
    800046f6:	c30ff0ef          	jal	80003b26 <kexec>
    800046fa:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800046fc:	100a0a13          	addi	s4,s4,256
    80004700:	6088                	ld	a0,0(s1)
    80004702:	c511                	beqz	a0,8000470e <sys_exec+0xdc>
    kfree(argv[i]);
    80004704:	919fb0ef          	jal	8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004708:	04a1                	addi	s1,s1,8
    8000470a:	ff449be3          	bne	s1,s4,80004700 <sys_exec+0xce>
  return ret;
    8000470e:	854a                	mv	a0,s2
    80004710:	64be                	ld	s1,456(sp)
    80004712:	691e                	ld	s2,448(sp)
    80004714:	79fa                	ld	s3,440(sp)
    80004716:	7a5a                	ld	s4,432(sp)
    80004718:	7aba                	ld	s5,424(sp)
    8000471a:	7b1a                	ld	s6,416(sp)
    8000471c:	6bfa                	ld	s7,408(sp)
    8000471e:	a809                	j	80004730 <sys_exec+0xfe>
    80004720:	64be                	ld	s1,456(sp)
    80004722:	691e                	ld	s2,448(sp)
    80004724:	79fa                	ld	s3,440(sp)
    80004726:	7a5a                	ld	s4,432(sp)
    80004728:	7aba                	ld	s5,424(sp)
    8000472a:	7b1a                	ld	s6,416(sp)
    8000472c:	6bfa                	ld	s7,408(sp)
    return -1;
    8000472e:	557d                	li	a0,-1
  return -1;
}
    80004730:	60fe                	ld	ra,472(sp)
    80004732:	645e                	ld	s0,464(sp)
    80004734:	613d                	addi	sp,sp,480
    80004736:	8082                	ret

0000000080004738 <sys_pipe>:

uint64
sys_pipe(void)
{
    80004738:	7139                	addi	sp,sp,-64
    8000473a:	fc06                	sd	ra,56(sp)
    8000473c:	f822                	sd	s0,48(sp)
    8000473e:	f426                	sd	s1,40(sp)
    80004740:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80004742:	e02fc0ef          	jal	80000d44 <myproc>
    80004746:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    80004748:	fd840593          	addi	a1,s0,-40
    8000474c:	4501                	li	a0,0
    8000474e:	d0efd0ef          	jal	80001c5c <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    80004752:	fc840593          	addi	a1,s0,-56
    80004756:	fd040513          	addi	a0,s0,-48
    8000475a:	8aaff0ef          	jal	80003804 <pipealloc>
    8000475e:	0a054463          	bltz	a0,80004806 <sys_pipe+0xce>
    return -1;
  fd0 = -1;
    80004762:	57fd                	li	a5,-1
    80004764:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80004768:	fd043503          	ld	a0,-48(s0)
    8000476c:	f22ff0ef          	jal	80003e8e <fdalloc>
    80004770:	fca42223          	sw	a0,-60(s0)
    80004774:	08054163          	bltz	a0,800047f6 <sys_pipe+0xbe>
    80004778:	fc843503          	ld	a0,-56(s0)
    8000477c:	f12ff0ef          	jal	80003e8e <fdalloc>
    80004780:	fca42023          	sw	a0,-64(s0)
    80004784:	06054063          	bltz	a0,800047e4 <sys_pipe+0xac>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80004788:	4691                	li	a3,4
    8000478a:	fc440613          	addi	a2,s0,-60
    8000478e:	fd843583          	ld	a1,-40(s0)
    80004792:	68a8                	ld	a0,80(s1)
    80004794:	af6fc0ef          	jal	80000a8a <copyout>
    80004798:	00054f63          	bltz	a0,800047b6 <sys_pipe+0x7e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    8000479c:	4691                	li	a3,4
    8000479e:	fc040613          	addi	a2,s0,-64
    800047a2:	fd843583          	ld	a1,-40(s0)
    800047a6:	95b6                	add	a1,a1,a3
    800047a8:	68a8                	ld	a0,80(s1)
    800047aa:	ae0fc0ef          	jal	80000a8a <copyout>
    800047ae:	87aa                	mv	a5,a0
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    800047b0:	4501                	li	a0,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800047b2:	0407db63          	bgez	a5,80004808 <sys_pipe+0xd0>
    p->ofile[fd0] = 0;
    800047b6:	fc442783          	lw	a5,-60(s0)
    800047ba:	07e9                	addi	a5,a5,26
    800047bc:	078e                	slli	a5,a5,0x3
    800047be:	97a6                	add	a5,a5,s1
    800047c0:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    800047c4:	fc042783          	lw	a5,-64(s0)
    800047c8:	07e9                	addi	a5,a5,26
    800047ca:	078e                	slli	a5,a5,0x3
    800047cc:	97a6                	add	a5,a5,s1
    800047ce:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    800047d2:	fd043503          	ld	a0,-48(s0)
    800047d6:	d21fe0ef          	jal	800034f6 <fileclose>
    fileclose(wf);
    800047da:	fc843503          	ld	a0,-56(s0)
    800047de:	d19fe0ef          	jal	800034f6 <fileclose>
    return -1;
    800047e2:	a015                	j	80004806 <sys_pipe+0xce>
    if(fd0 >= 0)
    800047e4:	fc442783          	lw	a5,-60(s0)
    800047e8:	0007c763          	bltz	a5,800047f6 <sys_pipe+0xbe>
      p->ofile[fd0] = 0;
    800047ec:	07e9                	addi	a5,a5,26
    800047ee:	078e                	slli	a5,a5,0x3
    800047f0:	97a6                	add	a5,a5,s1
    800047f2:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    800047f6:	fd043503          	ld	a0,-48(s0)
    800047fa:	cfdfe0ef          	jal	800034f6 <fileclose>
    fileclose(wf);
    800047fe:	fc843503          	ld	a0,-56(s0)
    80004802:	cf5fe0ef          	jal	800034f6 <fileclose>
    return -1;
    80004806:	557d                	li	a0,-1
}
    80004808:	70e2                	ld	ra,56(sp)
    8000480a:	7442                	ld	s0,48(sp)
    8000480c:	74a2                	ld	s1,40(sp)
    8000480e:	6121                	addi	sp,sp,64
    80004810:	8082                	ret
	...

0000000080004820 <kernelvec>:
.globl kerneltrap
.globl kernelvec
.align 4
kernelvec:
        # make room to save registers.
        addi sp, sp, -256
    80004820:	7111                	addi	sp,sp,-256

        # save caller-saved registers.
        sd ra, 0(sp)
    80004822:	e006                	sd	ra,0(sp)
        # sd sp, 8(sp)
        sd gp, 16(sp)
    80004824:	e80e                	sd	gp,16(sp)
        sd tp, 24(sp)
    80004826:	ec12                	sd	tp,24(sp)
        sd t0, 32(sp)
    80004828:	f016                	sd	t0,32(sp)
        sd t1, 40(sp)
    8000482a:	f41a                	sd	t1,40(sp)
        sd t2, 48(sp)
    8000482c:	f81e                	sd	t2,48(sp)
        sd a0, 72(sp)
    8000482e:	e4aa                	sd	a0,72(sp)
        sd a1, 80(sp)
    80004830:	e8ae                	sd	a1,80(sp)
        sd a2, 88(sp)
    80004832:	ecb2                	sd	a2,88(sp)
        sd a3, 96(sp)
    80004834:	f0b6                	sd	a3,96(sp)
        sd a4, 104(sp)
    80004836:	f4ba                	sd	a4,104(sp)
        sd a5, 112(sp)
    80004838:	f8be                	sd	a5,112(sp)
        sd a6, 120(sp)
    8000483a:	fcc2                	sd	a6,120(sp)
        sd a7, 128(sp)
    8000483c:	e146                	sd	a7,128(sp)
        sd t3, 216(sp)
    8000483e:	edf2                	sd	t3,216(sp)
        sd t4, 224(sp)
    80004840:	f1f6                	sd	t4,224(sp)
        sd t5, 232(sp)
    80004842:	f5fa                	sd	t5,232(sp)
        sd t6, 240(sp)
    80004844:	f9fe                	sd	t6,240(sp)

        # call the C trap handler in trap.c
        call kerneltrap
    80004846:	a82fd0ef          	jal	80001ac8 <kerneltrap>

        # restore registers.
        ld ra, 0(sp)
    8000484a:	6082                	ld	ra,0(sp)
        # ld sp, 8(sp)
        ld gp, 16(sp)
    8000484c:	61c2                	ld	gp,16(sp)
        # not tp (contains hartid), in case we moved CPUs
        ld t0, 32(sp)
    8000484e:	7282                	ld	t0,32(sp)
        ld t1, 40(sp)
    80004850:	7322                	ld	t1,40(sp)
        ld t2, 48(sp)
    80004852:	73c2                	ld	t2,48(sp)
        ld a0, 72(sp)
    80004854:	6526                	ld	a0,72(sp)
        ld a1, 80(sp)
    80004856:	65c6                	ld	a1,80(sp)
        ld a2, 88(sp)
    80004858:	6666                	ld	a2,88(sp)
        ld a3, 96(sp)
    8000485a:	7686                	ld	a3,96(sp)
        ld a4, 104(sp)
    8000485c:	7726                	ld	a4,104(sp)
        ld a5, 112(sp)
    8000485e:	77c6                	ld	a5,112(sp)
        ld a6, 120(sp)
    80004860:	7866                	ld	a6,120(sp)
        ld a7, 128(sp)
    80004862:	688a                	ld	a7,128(sp)
        ld t3, 216(sp)
    80004864:	6e6e                	ld	t3,216(sp)
        ld t4, 224(sp)
    80004866:	7e8e                	ld	t4,224(sp)
        ld t5, 232(sp)
    80004868:	7f2e                	ld	t5,232(sp)
        ld t6, 240(sp)
    8000486a:	7fce                	ld	t6,240(sp)

        addi sp, sp, 256
    8000486c:	6111                	addi	sp,sp,256

        # return to whatever we were doing in the kernel.
        sret
    8000486e:	10200073          	sret
    80004872:	00000013          	nop
    80004876:	00000013          	nop
    8000487a:	00000013          	nop

000000008000487e <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000487e:	1141                	addi	sp,sp,-16
    80004880:	e406                	sd	ra,8(sp)
    80004882:	e022                	sd	s0,0(sp)
    80004884:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80004886:	0c000737          	lui	a4,0xc000
    8000488a:	4785                	li	a5,1
    8000488c:	d71c                	sw	a5,40(a4)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    8000488e:	c35c                	sw	a5,4(a4)
}
    80004890:	60a2                	ld	ra,8(sp)
    80004892:	6402                	ld	s0,0(sp)
    80004894:	0141                	addi	sp,sp,16
    80004896:	8082                	ret

0000000080004898 <plicinithart>:

void
plicinithart(void)
{
    80004898:	1141                	addi	sp,sp,-16
    8000489a:	e406                	sd	ra,8(sp)
    8000489c:	e022                	sd	s0,0(sp)
    8000489e:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800048a0:	c70fc0ef          	jal	80000d10 <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    800048a4:	0085171b          	slliw	a4,a0,0x8
    800048a8:	0c0027b7          	lui	a5,0xc002
    800048ac:	97ba                	add	a5,a5,a4
    800048ae:	40200713          	li	a4,1026
    800048b2:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    800048b6:	00d5151b          	slliw	a0,a0,0xd
    800048ba:	0c2017b7          	lui	a5,0xc201
    800048be:	97aa                	add	a5,a5,a0
    800048c0:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    800048c4:	60a2                	ld	ra,8(sp)
    800048c6:	6402                	ld	s0,0(sp)
    800048c8:	0141                	addi	sp,sp,16
    800048ca:	8082                	ret

00000000800048cc <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    800048cc:	1141                	addi	sp,sp,-16
    800048ce:	e406                	sd	ra,8(sp)
    800048d0:	e022                	sd	s0,0(sp)
    800048d2:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800048d4:	c3cfc0ef          	jal	80000d10 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    800048d8:	00d5151b          	slliw	a0,a0,0xd
    800048dc:	0c2017b7          	lui	a5,0xc201
    800048e0:	97aa                	add	a5,a5,a0
  return irq;
}
    800048e2:	43c8                	lw	a0,4(a5)
    800048e4:	60a2                	ld	ra,8(sp)
    800048e6:	6402                	ld	s0,0(sp)
    800048e8:	0141                	addi	sp,sp,16
    800048ea:	8082                	ret

00000000800048ec <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800048ec:	1101                	addi	sp,sp,-32
    800048ee:	ec06                	sd	ra,24(sp)
    800048f0:	e822                	sd	s0,16(sp)
    800048f2:	e426                	sd	s1,8(sp)
    800048f4:	1000                	addi	s0,sp,32
    800048f6:	84aa                	mv	s1,a0
  int hart = cpuid();
    800048f8:	c18fc0ef          	jal	80000d10 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    800048fc:	00d5179b          	slliw	a5,a0,0xd
    80004900:	0c201737          	lui	a4,0xc201
    80004904:	97ba                	add	a5,a5,a4
    80004906:	c3c4                	sw	s1,4(a5)
}
    80004908:	60e2                	ld	ra,24(sp)
    8000490a:	6442                	ld	s0,16(sp)
    8000490c:	64a2                	ld	s1,8(sp)
    8000490e:	6105                	addi	sp,sp,32
    80004910:	8082                	ret

0000000080004912 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80004912:	1141                	addi	sp,sp,-16
    80004914:	e406                	sd	ra,8(sp)
    80004916:	e022                	sd	s0,0(sp)
    80004918:	0800                	addi	s0,sp,16
  if(i >= NUM)
    8000491a:	479d                	li	a5,7
    8000491c:	04a7ca63          	blt	a5,a0,80004970 <free_desc+0x5e>
    panic("free_desc 1");
  if(disk.free[i])
    80004920:	00016797          	auipc	a5,0x16
    80004924:	25078793          	addi	a5,a5,592 # 8001ab70 <disk>
    80004928:	97aa                	add	a5,a5,a0
    8000492a:	0187c783          	lbu	a5,24(a5)
    8000492e:	e7b9                	bnez	a5,8000497c <free_desc+0x6a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80004930:	00451693          	slli	a3,a0,0x4
    80004934:	00016797          	auipc	a5,0x16
    80004938:	23c78793          	addi	a5,a5,572 # 8001ab70 <disk>
    8000493c:	6398                	ld	a4,0(a5)
    8000493e:	9736                	add	a4,a4,a3
    80004940:	00073023          	sd	zero,0(a4) # c201000 <_entry-0x73dff000>
  disk.desc[i].len = 0;
    80004944:	6398                	ld	a4,0(a5)
    80004946:	9736                	add	a4,a4,a3
    80004948:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    8000494c:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    80004950:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    80004954:	97aa                	add	a5,a5,a0
    80004956:	4705                	li	a4,1
    80004958:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    8000495c:	00016517          	auipc	a0,0x16
    80004960:	22c50513          	addi	a0,a0,556 # 8001ab88 <disk+0x18>
    80004964:	a2ffc0ef          	jal	80001392 <wakeup>
}
    80004968:	60a2                	ld	ra,8(sp)
    8000496a:	6402                	ld	s0,0(sp)
    8000496c:	0141                	addi	sp,sp,16
    8000496e:	8082                	ret
    panic("free_desc 1");
    80004970:	00003517          	auipc	a0,0x3
    80004974:	c5850513          	addi	a0,a0,-936 # 800075c8 <etext+0x5c8>
    80004978:	49d000ef          	jal	80005614 <panic>
    panic("free_desc 2");
    8000497c:	00003517          	auipc	a0,0x3
    80004980:	c5c50513          	addi	a0,a0,-932 # 800075d8 <etext+0x5d8>
    80004984:	491000ef          	jal	80005614 <panic>

0000000080004988 <virtio_disk_init>:
{
    80004988:	1101                	addi	sp,sp,-32
    8000498a:	ec06                	sd	ra,24(sp)
    8000498c:	e822                	sd	s0,16(sp)
    8000498e:	e426                	sd	s1,8(sp)
    80004990:	e04a                	sd	s2,0(sp)
    80004992:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80004994:	00003597          	auipc	a1,0x3
    80004998:	c5458593          	addi	a1,a1,-940 # 800075e8 <etext+0x5e8>
    8000499c:	00016517          	auipc	a0,0x16
    800049a0:	2fc50513          	addi	a0,a0,764 # 8001ac98 <disk+0x128>
    800049a4:	6a5000ef          	jal	80005848 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800049a8:	100017b7          	lui	a5,0x10001
    800049ac:	4398                	lw	a4,0(a5)
    800049ae:	747277b7          	lui	a5,0x74727
    800049b2:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800049b6:	14f71263          	bne	a4,a5,80004afa <virtio_disk_init+0x172>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800049ba:	100017b7          	lui	a5,0x10001
    800049be:	43d8                	lw	a4,4(a5)
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800049c0:	4789                	li	a5,2
    800049c2:	12f71c63          	bne	a4,a5,80004afa <virtio_disk_init+0x172>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800049c6:	100017b7          	lui	a5,0x10001
    800049ca:	4798                	lw	a4,8(a5)
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800049cc:	4789                	li	a5,2
    800049ce:	12f71663          	bne	a4,a5,80004afa <virtio_disk_init+0x172>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    800049d2:	100017b7          	lui	a5,0x10001
    800049d6:	47d8                	lw	a4,12(a5)
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800049d8:	554d47b7          	lui	a5,0x554d4
    800049dc:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800049e0:	10f71d63          	bne	a4,a5,80004afa <virtio_disk_init+0x172>
  *R(VIRTIO_MMIO_STATUS) = status;
    800049e4:	100017b7          	lui	a5,0x10001
    800049e8:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    800049ec:	4705                	li	a4,1
    800049ee:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800049f0:	470d                	li	a4,3
    800049f2:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    800049f4:	10001737          	lui	a4,0x10001
    800049f8:	4b18                	lw	a4,16(a4)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800049fa:	c7ffe6b7          	lui	a3,0xc7ffe
    800049fe:	75f68693          	addi	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fdb9d7>
    80004a02:	8f75                	and	a4,a4,a3
    80004a04:	100016b7          	lui	a3,0x10001
    80004a08:	d298                	sw	a4,32(a3)
  *R(VIRTIO_MMIO_STATUS) = status;
    80004a0a:	472d                	li	a4,11
    80004a0c:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    80004a0e:	0707a903          	lw	s2,112(a5)
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80004a12:	00897793          	andi	a5,s2,8
    80004a16:	0e078863          	beqz	a5,80004b06 <virtio_disk_init+0x17e>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80004a1a:	100017b7          	lui	a5,0x10001
    80004a1e:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    80004a22:	43fc                	lw	a5,68(a5)
    80004a24:	0e079763          	bnez	a5,80004b12 <virtio_disk_init+0x18a>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80004a28:	100017b7          	lui	a5,0x10001
    80004a2c:	5bdc                	lw	a5,52(a5)
  if(max == 0)
    80004a2e:	0e078863          	beqz	a5,80004b1e <virtio_disk_init+0x196>
  if(max < NUM)
    80004a32:	471d                	li	a4,7
    80004a34:	0ef77b63          	bgeu	a4,a5,80004b2a <virtio_disk_init+0x1a2>
  disk.desc = kalloc();
    80004a38:	ec4fb0ef          	jal	800000fc <kalloc>
    80004a3c:	00016497          	auipc	s1,0x16
    80004a40:	13448493          	addi	s1,s1,308 # 8001ab70 <disk>
    80004a44:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    80004a46:	eb6fb0ef          	jal	800000fc <kalloc>
    80004a4a:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    80004a4c:	eb0fb0ef          	jal	800000fc <kalloc>
    80004a50:	87aa                	mv	a5,a0
    80004a52:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    80004a54:	6088                	ld	a0,0(s1)
    80004a56:	0e050063          	beqz	a0,80004b36 <virtio_disk_init+0x1ae>
    80004a5a:	00016717          	auipc	a4,0x16
    80004a5e:	11e73703          	ld	a4,286(a4) # 8001ab78 <disk+0x8>
    80004a62:	00173713          	seqz	a4,a4
    80004a66:	0017b793          	seqz	a5,a5
    80004a6a:	8fd9                	or	a5,a5,a4
    80004a6c:	e7e9                	bnez	a5,80004b36 <virtio_disk_init+0x1ae>
  memset(disk.desc, 0, PGSIZE);
    80004a6e:	6605                	lui	a2,0x1
    80004a70:	4581                	li	a1,0
    80004a72:	eccfb0ef          	jal	8000013e <memset>
  memset(disk.avail, 0, PGSIZE);
    80004a76:	00016497          	auipc	s1,0x16
    80004a7a:	0fa48493          	addi	s1,s1,250 # 8001ab70 <disk>
    80004a7e:	6605                	lui	a2,0x1
    80004a80:	4581                	li	a1,0
    80004a82:	6488                	ld	a0,8(s1)
    80004a84:	ebafb0ef          	jal	8000013e <memset>
  memset(disk.used, 0, PGSIZE);
    80004a88:	6605                	lui	a2,0x1
    80004a8a:	4581                	li	a1,0
    80004a8c:	6888                	ld	a0,16(s1)
    80004a8e:	eb0fb0ef          	jal	8000013e <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80004a92:	100017b7          	lui	a5,0x10001
    80004a96:	4721                	li	a4,8
    80004a98:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    80004a9a:	4098                	lw	a4,0(s1)
    80004a9c:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80004aa0:	40d8                	lw	a4,4(s1)
    80004aa2:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    80004aa6:	649c                	ld	a5,8(s1)
    80004aa8:	10001737          	lui	a4,0x10001
    80004aac:	08f72823          	sw	a5,144(a4) # 10001090 <_entry-0x6fffef70>
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80004ab0:	9781                	srai	a5,a5,0x20
    80004ab2:	08f72a23          	sw	a5,148(a4)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    80004ab6:	689c                	ld	a5,16(s1)
    80004ab8:	0af72023          	sw	a5,160(a4)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80004abc:	9781                	srai	a5,a5,0x20
    80004abe:	0af72223          	sw	a5,164(a4)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    80004ac2:	4785                	li	a5,1
    80004ac4:	c37c                	sw	a5,68(a4)
    disk.free[i] = 1;
    80004ac6:	00f48c23          	sb	a5,24(s1)
    80004aca:	00f48ca3          	sb	a5,25(s1)
    80004ace:	00f48d23          	sb	a5,26(s1)
    80004ad2:	00f48da3          	sb	a5,27(s1)
    80004ad6:	00f48e23          	sb	a5,28(s1)
    80004ada:	00f48ea3          	sb	a5,29(s1)
    80004ade:	00f48f23          	sb	a5,30(s1)
    80004ae2:	00f48fa3          	sb	a5,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80004ae6:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80004aea:	07272823          	sw	s2,112(a4)
}
    80004aee:	60e2                	ld	ra,24(sp)
    80004af0:	6442                	ld	s0,16(sp)
    80004af2:	64a2                	ld	s1,8(sp)
    80004af4:	6902                	ld	s2,0(sp)
    80004af6:	6105                	addi	sp,sp,32
    80004af8:	8082                	ret
    panic("could not find virtio disk");
    80004afa:	00003517          	auipc	a0,0x3
    80004afe:	afe50513          	addi	a0,a0,-1282 # 800075f8 <etext+0x5f8>
    80004b02:	313000ef          	jal	80005614 <panic>
    panic("virtio disk FEATURES_OK unset");
    80004b06:	00003517          	auipc	a0,0x3
    80004b0a:	b1250513          	addi	a0,a0,-1262 # 80007618 <etext+0x618>
    80004b0e:	307000ef          	jal	80005614 <panic>
    panic("virtio disk should not be ready");
    80004b12:	00003517          	auipc	a0,0x3
    80004b16:	b2650513          	addi	a0,a0,-1242 # 80007638 <etext+0x638>
    80004b1a:	2fb000ef          	jal	80005614 <panic>
    panic("virtio disk has no queue 0");
    80004b1e:	00003517          	auipc	a0,0x3
    80004b22:	b3a50513          	addi	a0,a0,-1222 # 80007658 <etext+0x658>
    80004b26:	2ef000ef          	jal	80005614 <panic>
    panic("virtio disk max queue too short");
    80004b2a:	00003517          	auipc	a0,0x3
    80004b2e:	b4e50513          	addi	a0,a0,-1202 # 80007678 <etext+0x678>
    80004b32:	2e3000ef          	jal	80005614 <panic>
    panic("virtio disk kalloc");
    80004b36:	00003517          	auipc	a0,0x3
    80004b3a:	b6250513          	addi	a0,a0,-1182 # 80007698 <etext+0x698>
    80004b3e:	2d7000ef          	jal	80005614 <panic>

0000000080004b42 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80004b42:	711d                	addi	sp,sp,-96
    80004b44:	ec86                	sd	ra,88(sp)
    80004b46:	e8a2                	sd	s0,80(sp)
    80004b48:	e4a6                	sd	s1,72(sp)
    80004b4a:	e0ca                	sd	s2,64(sp)
    80004b4c:	fc4e                	sd	s3,56(sp)
    80004b4e:	f852                	sd	s4,48(sp)
    80004b50:	f456                	sd	s5,40(sp)
    80004b52:	f05a                	sd	s6,32(sp)
    80004b54:	ec5e                	sd	s7,24(sp)
    80004b56:	e862                	sd	s8,16(sp)
    80004b58:	1080                	addi	s0,sp,96
    80004b5a:	89aa                	mv	s3,a0
    80004b5c:	8b2e                	mv	s6,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80004b5e:	00c52b83          	lw	s7,12(a0)
    80004b62:	001b9b9b          	slliw	s7,s7,0x1
    80004b66:	1b82                	slli	s7,s7,0x20
    80004b68:	020bdb93          	srli	s7,s7,0x20

  acquire(&disk.vdisk_lock);
    80004b6c:	00016517          	auipc	a0,0x16
    80004b70:	12c50513          	addi	a0,a0,300 # 8001ac98 <disk+0x128>
    80004b74:	55f000ef          	jal	800058d2 <acquire>
  for(int i = 0; i < NUM; i++){
    80004b78:	44a1                	li	s1,8
      disk.free[i] = 0;
    80004b7a:	00016a97          	auipc	s5,0x16
    80004b7e:	ff6a8a93          	addi	s5,s5,-10 # 8001ab70 <disk>
  for(int i = 0; i < 3; i++){
    80004b82:	4a0d                	li	s4,3
    idx[i] = alloc_desc();
    80004b84:	5c7d                	li	s8,-1
    80004b86:	a095                	j	80004bea <virtio_disk_rw+0xa8>
      disk.free[i] = 0;
    80004b88:	00fa8733          	add	a4,s5,a5
    80004b8c:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80004b90:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80004b92:	0207c563          	bltz	a5,80004bbc <virtio_disk_rw+0x7a>
  for(int i = 0; i < 3; i++){
    80004b96:	2905                	addiw	s2,s2,1
    80004b98:	0611                	addi	a2,a2,4 # 1004 <_entry-0x7fffeffc>
    80004b9a:	05490c63          	beq	s2,s4,80004bf2 <virtio_disk_rw+0xb0>
    idx[i] = alloc_desc();
    80004b9e:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80004ba0:	00016717          	auipc	a4,0x16
    80004ba4:	fd070713          	addi	a4,a4,-48 # 8001ab70 <disk>
    80004ba8:	4781                	li	a5,0
    if(disk.free[i]){
    80004baa:	01874683          	lbu	a3,24(a4)
    80004bae:	fee9                	bnez	a3,80004b88 <virtio_disk_rw+0x46>
  for(int i = 0; i < NUM; i++){
    80004bb0:	2785                	addiw	a5,a5,1
    80004bb2:	0705                	addi	a4,a4,1
    80004bb4:	fe979be3          	bne	a5,s1,80004baa <virtio_disk_rw+0x68>
    idx[i] = alloc_desc();
    80004bb8:	0185a023          	sw	s8,0(a1)
      for(int j = 0; j < i; j++)
    80004bbc:	01205d63          	blez	s2,80004bd6 <virtio_disk_rw+0x94>
        free_desc(idx[j]);
    80004bc0:	fa042503          	lw	a0,-96(s0)
    80004bc4:	d4fff0ef          	jal	80004912 <free_desc>
      for(int j = 0; j < i; j++)
    80004bc8:	4785                	li	a5,1
    80004bca:	0127d663          	bge	a5,s2,80004bd6 <virtio_disk_rw+0x94>
        free_desc(idx[j]);
    80004bce:	fa442503          	lw	a0,-92(s0)
    80004bd2:	d41ff0ef          	jal	80004912 <free_desc>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80004bd6:	00016597          	auipc	a1,0x16
    80004bda:	0c258593          	addi	a1,a1,194 # 8001ac98 <disk+0x128>
    80004bde:	00016517          	auipc	a0,0x16
    80004be2:	faa50513          	addi	a0,a0,-86 # 8001ab88 <disk+0x18>
    80004be6:	f60fc0ef          	jal	80001346 <sleep>
  for(int i = 0; i < 3; i++){
    80004bea:	fa040613          	addi	a2,s0,-96
    80004bee:	4901                	li	s2,0
    80004bf0:	b77d                	j	80004b9e <virtio_disk_rw+0x5c>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80004bf2:	fa042503          	lw	a0,-96(s0)
    80004bf6:	00451693          	slli	a3,a0,0x4

  if(write)
    80004bfa:	00016797          	auipc	a5,0x16
    80004bfe:	f7678793          	addi	a5,a5,-138 # 8001ab70 <disk>
    80004c02:	00451713          	slli	a4,a0,0x4
    80004c06:	0a070713          	addi	a4,a4,160
    80004c0a:	973e                	add	a4,a4,a5
    80004c0c:	01603633          	snez	a2,s6
    80004c10:	c710                	sw	a2,8(a4)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80004c12:	00072623          	sw	zero,12(a4)
  buf0->sector = sector;
    80004c16:	01773823          	sd	s7,16(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80004c1a:	6398                	ld	a4,0(a5)
    80004c1c:	9736                	add	a4,a4,a3
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80004c1e:	0a868613          	addi	a2,a3,168 # 100010a8 <_entry-0x6fffef58>
    80004c22:	963e                	add	a2,a2,a5
  disk.desc[idx[0]].addr = (uint64) buf0;
    80004c24:	e310                	sd	a2,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80004c26:	6390                	ld	a2,0(a5)
    80004c28:	00d605b3          	add	a1,a2,a3
    80004c2c:	4741                	li	a4,16
    80004c2e:	c598                	sw	a4,8(a1)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80004c30:	4805                	li	a6,1
    80004c32:	01059623          	sh	a6,12(a1)
  disk.desc[idx[0]].next = idx[1];
    80004c36:	fa442703          	lw	a4,-92(s0)
    80004c3a:	00e59723          	sh	a4,14(a1)

  disk.desc[idx[1]].addr = (uint64) b->data;
    80004c3e:	0712                	slli	a4,a4,0x4
    80004c40:	963a                	add	a2,a2,a4
    80004c42:	05898593          	addi	a1,s3,88
    80004c46:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    80004c48:	0007b883          	ld	a7,0(a5)
    80004c4c:	9746                	add	a4,a4,a7
    80004c4e:	40000613          	li	a2,1024
    80004c52:	c710                	sw	a2,8(a4)
  if(write)
    80004c54:	001b3613          	seqz	a2,s6
    80004c58:	0016161b          	slliw	a2,a2,0x1
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80004c5c:	01066633          	or	a2,a2,a6
    80004c60:	00c71623          	sh	a2,12(a4)
  disk.desc[idx[1]].next = idx[2];
    80004c64:	fa842583          	lw	a1,-88(s0)
    80004c68:	00b71723          	sh	a1,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80004c6c:	00250613          	addi	a2,a0,2
    80004c70:	0612                	slli	a2,a2,0x4
    80004c72:	963e                	add	a2,a2,a5
    80004c74:	577d                	li	a4,-1
    80004c76:	00e60823          	sb	a4,16(a2)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80004c7a:	0592                	slli	a1,a1,0x4
    80004c7c:	98ae                	add	a7,a7,a1
    80004c7e:	03068713          	addi	a4,a3,48
    80004c82:	973e                	add	a4,a4,a5
    80004c84:	00e8b023          	sd	a4,0(a7)
  disk.desc[idx[2]].len = 1;
    80004c88:	6398                	ld	a4,0(a5)
    80004c8a:	972e                	add	a4,a4,a1
    80004c8c:	01072423          	sw	a6,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80004c90:	4689                	li	a3,2
    80004c92:	00d71623          	sh	a3,12(a4)
  disk.desc[idx[2]].next = 0;
    80004c96:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80004c9a:	0109a223          	sw	a6,4(s3)
  disk.info[idx[0]].b = b;
    80004c9e:	01363423          	sd	s3,8(a2)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80004ca2:	6794                	ld	a3,8(a5)
    80004ca4:	0026d703          	lhu	a4,2(a3)
    80004ca8:	8b1d                	andi	a4,a4,7
    80004caa:	0706                	slli	a4,a4,0x1
    80004cac:	96ba                	add	a3,a3,a4
    80004cae:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    80004cb2:	0330000f          	fence	rw,rw

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80004cb6:	6798                	ld	a4,8(a5)
    80004cb8:	00275783          	lhu	a5,2(a4)
    80004cbc:	2785                	addiw	a5,a5,1
    80004cbe:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80004cc2:	0330000f          	fence	rw,rw

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80004cc6:	100017b7          	lui	a5,0x10001
    80004cca:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80004cce:	0049a783          	lw	a5,4(s3)
    80004cd2:	01079f63          	bne	a5,a6,80004cf0 <virtio_disk_rw+0x1ae>
    sleep(b, &disk.vdisk_lock);
    80004cd6:	00016917          	auipc	s2,0x16
    80004cda:	fc290913          	addi	s2,s2,-62 # 8001ac98 <disk+0x128>
  while(b->disk == 1) {
    80004cde:	84be                	mv	s1,a5
    sleep(b, &disk.vdisk_lock);
    80004ce0:	85ca                	mv	a1,s2
    80004ce2:	854e                	mv	a0,s3
    80004ce4:	e62fc0ef          	jal	80001346 <sleep>
  while(b->disk == 1) {
    80004ce8:	0049a783          	lw	a5,4(s3)
    80004cec:	fe978ae3          	beq	a5,s1,80004ce0 <virtio_disk_rw+0x19e>
  }

  disk.info[idx[0]].b = 0;
    80004cf0:	fa042903          	lw	s2,-96(s0)
    80004cf4:	00290713          	addi	a4,s2,2
    80004cf8:	0712                	slli	a4,a4,0x4
    80004cfa:	00016797          	auipc	a5,0x16
    80004cfe:	e7678793          	addi	a5,a5,-394 # 8001ab70 <disk>
    80004d02:	97ba                	add	a5,a5,a4
    80004d04:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    80004d08:	00016997          	auipc	s3,0x16
    80004d0c:	e6898993          	addi	s3,s3,-408 # 8001ab70 <disk>
    80004d10:	00491713          	slli	a4,s2,0x4
    80004d14:	0009b783          	ld	a5,0(s3)
    80004d18:	97ba                	add	a5,a5,a4
    80004d1a:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80004d1e:	854a                	mv	a0,s2
    80004d20:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80004d24:	befff0ef          	jal	80004912 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80004d28:	8885                	andi	s1,s1,1
    80004d2a:	f0fd                	bnez	s1,80004d10 <virtio_disk_rw+0x1ce>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80004d2c:	00016517          	auipc	a0,0x16
    80004d30:	f6c50513          	addi	a0,a0,-148 # 8001ac98 <disk+0x128>
    80004d34:	42f000ef          	jal	80005962 <release>
}
    80004d38:	60e6                	ld	ra,88(sp)
    80004d3a:	6446                	ld	s0,80(sp)
    80004d3c:	64a6                	ld	s1,72(sp)
    80004d3e:	6906                	ld	s2,64(sp)
    80004d40:	79e2                	ld	s3,56(sp)
    80004d42:	7a42                	ld	s4,48(sp)
    80004d44:	7aa2                	ld	s5,40(sp)
    80004d46:	7b02                	ld	s6,32(sp)
    80004d48:	6be2                	ld	s7,24(sp)
    80004d4a:	6c42                	ld	s8,16(sp)
    80004d4c:	6125                	addi	sp,sp,96
    80004d4e:	8082                	ret

0000000080004d50 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80004d50:	1101                	addi	sp,sp,-32
    80004d52:	ec06                	sd	ra,24(sp)
    80004d54:	e822                	sd	s0,16(sp)
    80004d56:	e426                	sd	s1,8(sp)
    80004d58:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80004d5a:	00016497          	auipc	s1,0x16
    80004d5e:	e1648493          	addi	s1,s1,-490 # 8001ab70 <disk>
    80004d62:	00016517          	auipc	a0,0x16
    80004d66:	f3650513          	addi	a0,a0,-202 # 8001ac98 <disk+0x128>
    80004d6a:	369000ef          	jal	800058d2 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80004d6e:	100017b7          	lui	a5,0x10001
    80004d72:	53bc                	lw	a5,96(a5)
    80004d74:	8b8d                	andi	a5,a5,3
    80004d76:	10001737          	lui	a4,0x10001
    80004d7a:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80004d7c:	0330000f          	fence	rw,rw

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80004d80:	689c                	ld	a5,16(s1)
    80004d82:	0204d703          	lhu	a4,32(s1)
    80004d86:	0027d783          	lhu	a5,2(a5) # 10001002 <_entry-0x6fffeffe>
    80004d8a:	04f70663          	beq	a4,a5,80004dd6 <virtio_disk_intr+0x86>
    __sync_synchronize();
    80004d8e:	0330000f          	fence	rw,rw
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80004d92:	6898                	ld	a4,16(s1)
    80004d94:	0204d783          	lhu	a5,32(s1)
    80004d98:	8b9d                	andi	a5,a5,7
    80004d9a:	078e                	slli	a5,a5,0x3
    80004d9c:	97ba                	add	a5,a5,a4
    80004d9e:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80004da0:	00278713          	addi	a4,a5,2
    80004da4:	0712                	slli	a4,a4,0x4
    80004da6:	9726                	add	a4,a4,s1
    80004da8:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    80004dac:	e321                	bnez	a4,80004dec <virtio_disk_intr+0x9c>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80004dae:	0789                	addi	a5,a5,2
    80004db0:	0792                	slli	a5,a5,0x4
    80004db2:	97a6                	add	a5,a5,s1
    80004db4:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    80004db6:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80004dba:	dd8fc0ef          	jal	80001392 <wakeup>

    disk.used_idx += 1;
    80004dbe:	0204d783          	lhu	a5,32(s1)
    80004dc2:	2785                	addiw	a5,a5,1
    80004dc4:	17c2                	slli	a5,a5,0x30
    80004dc6:	93c1                	srli	a5,a5,0x30
    80004dc8:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80004dcc:	6898                	ld	a4,16(s1)
    80004dce:	00275703          	lhu	a4,2(a4)
    80004dd2:	faf71ee3          	bne	a4,a5,80004d8e <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80004dd6:	00016517          	auipc	a0,0x16
    80004dda:	ec250513          	addi	a0,a0,-318 # 8001ac98 <disk+0x128>
    80004dde:	385000ef          	jal	80005962 <release>
}
    80004de2:	60e2                	ld	ra,24(sp)
    80004de4:	6442                	ld	s0,16(sp)
    80004de6:	64a2                	ld	s1,8(sp)
    80004de8:	6105                	addi	sp,sp,32
    80004dea:	8082                	ret
      panic("virtio_disk_intr status");
    80004dec:	00003517          	auipc	a0,0x3
    80004df0:	8c450513          	addi	a0,a0,-1852 # 800076b0 <etext+0x6b0>
    80004df4:	021000ef          	jal	80005614 <panic>

0000000080004df8 <timerinit>:
}

// ask each hart to generate timer interrupts.
void
timerinit()
{
    80004df8:	1141                	addi	sp,sp,-16
    80004dfa:	e406                	sd	ra,8(sp)
    80004dfc:	e022                	sd	s0,0(sp)
    80004dfe:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mie" : "=r" (x) );
    80004e00:	304027f3          	csrr	a5,mie
  // enable supervisor-mode timer interrupts.
  w_mie(r_mie() | MIE_STIE);
    80004e04:	0207e793          	ori	a5,a5,32
  asm volatile("csrw mie, %0" : : "r" (x));
    80004e08:	30479073          	csrw	mie,a5
  asm volatile("csrr %0, 0x30a" : "=r" (x) );
    80004e0c:	30a027f3          	csrr	a5,0x30a
  
  // enable the sstc extension (i.e. stimecmp).
  w_menvcfg(r_menvcfg() | (1L << 63)); 
    80004e10:	577d                	li	a4,-1
    80004e12:	177e                	slli	a4,a4,0x3f
    80004e14:	8fd9                	or	a5,a5,a4
  asm volatile("csrw 0x30a, %0" : : "r" (x));
    80004e16:	30a79073          	csrw	0x30a,a5
  asm volatile("csrr %0, mcounteren" : "=r" (x) );
    80004e1a:	306027f3          	csrr	a5,mcounteren
  
  // allow supervisor to use stimecmp and time.
  w_mcounteren(r_mcounteren() | 2);
    80004e1e:	0027e793          	ori	a5,a5,2
  asm volatile("csrw mcounteren, %0" : : "r" (x));
    80004e22:	30679073          	csrw	mcounteren,a5
  asm volatile("csrr %0, time" : "=r" (x) );
    80004e26:	c01027f3          	rdtime	a5
  
  // ask for the very first timer interrupt.
  w_stimecmp(r_time() + 1000000);
    80004e2a:	000f4737          	lui	a4,0xf4
    80004e2e:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    80004e32:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    80004e34:	14d79073          	csrw	stimecmp,a5
}
    80004e38:	60a2                	ld	ra,8(sp)
    80004e3a:	6402                	ld	s0,0(sp)
    80004e3c:	0141                	addi	sp,sp,16
    80004e3e:	8082                	ret

0000000080004e40 <start>:
{
    80004e40:	1141                	addi	sp,sp,-16
    80004e42:	e406                	sd	ra,8(sp)
    80004e44:	e022                	sd	s0,0(sp)
    80004e46:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80004e48:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80004e4c:	7779                	lui	a4,0xffffe
    80004e4e:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdba77>
    80004e52:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80004e54:	6705                	lui	a4,0x1
    80004e56:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004e5a:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80004e5c:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80004e60:	ffffb797          	auipc	a5,0xffffb
    80004e64:	48a78793          	addi	a5,a5,1162 # 800002ea <main>
    80004e68:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80004e6c:	4781                	li	a5,0
    80004e6e:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80004e72:	67c1                	lui	a5,0x10
    80004e74:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004e76:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80004e7a:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80004e7e:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE);
    80004e82:	2207e793          	ori	a5,a5,544
  asm volatile("csrw sie, %0" : : "r" (x));
    80004e86:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80004e8a:	57fd                	li	a5,-1
    80004e8c:	83a9                	srli	a5,a5,0xa
    80004e8e:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80004e92:	47bd                	li	a5,15
    80004e94:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80004e98:	f61ff0ef          	jal	80004df8 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80004e9c:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80004ea0:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80004ea2:	823e                	mv	tp,a5
  asm volatile("mret");
    80004ea4:	30200073          	mret
}
    80004ea8:	60a2                	ld	ra,8(sp)
    80004eaa:	6402                	ld	s0,0(sp)
    80004eac:	0141                	addi	sp,sp,16
    80004eae:	8082                	ret

0000000080004eb0 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80004eb0:	7119                	addi	sp,sp,-128
    80004eb2:	fc86                	sd	ra,120(sp)
    80004eb4:	f8a2                	sd	s0,112(sp)
    80004eb6:	f4a6                	sd	s1,104(sp)
    80004eb8:	0100                	addi	s0,sp,128
  char buf[32];
  int i = 0;

  while(i < n){
    80004eba:	06c05b63          	blez	a2,80004f30 <consolewrite+0x80>
    80004ebe:	f0ca                	sd	s2,96(sp)
    80004ec0:	ecce                	sd	s3,88(sp)
    80004ec2:	e8d2                	sd	s4,80(sp)
    80004ec4:	e4d6                	sd	s5,72(sp)
    80004ec6:	e0da                	sd	s6,64(sp)
    80004ec8:	fc5e                	sd	s7,56(sp)
    80004eca:	f862                	sd	s8,48(sp)
    80004ecc:	f466                	sd	s9,40(sp)
    80004ece:	f06a                	sd	s10,32(sp)
    80004ed0:	8b2a                	mv	s6,a0
    80004ed2:	8bae                	mv	s7,a1
    80004ed4:	8a32                	mv	s4,a2
  int i = 0;
    80004ed6:	4481                	li	s1,0
    int nn = sizeof(buf);
    if(nn > n - i)
    80004ed8:	02000c93          	li	s9,32
    80004edc:	02000d13          	li	s10,32
      nn = n - i;
    if(either_copyin(buf, user_src, src+i, nn) == -1)
    80004ee0:	f8040a93          	addi	s5,s0,-128
    80004ee4:	5c7d                	li	s8,-1
    80004ee6:	a025                	j	80004f0e <consolewrite+0x5e>
    if(nn > n - i)
    80004ee8:	0009099b          	sext.w	s3,s2
    if(either_copyin(buf, user_src, src+i, nn) == -1)
    80004eec:	86ce                	mv	a3,s3
    80004eee:	01748633          	add	a2,s1,s7
    80004ef2:	85da                	mv	a1,s6
    80004ef4:	8556                	mv	a0,s5
    80004ef6:	ff2fc0ef          	jal	800016e8 <either_copyin>
    80004efa:	03850d63          	beq	a0,s8,80004f34 <consolewrite+0x84>
      break;
    uartwrite(buf, nn);
    80004efe:	85ce                	mv	a1,s3
    80004f00:	8556                	mv	a0,s5
    80004f02:	7c8000ef          	jal	800056ca <uartwrite>
    i += nn;
    80004f06:	009904bb          	addw	s1,s2,s1
  while(i < n){
    80004f0a:	0144d963          	bge	s1,s4,80004f1c <consolewrite+0x6c>
    if(nn > n - i)
    80004f0e:	409a07bb          	subw	a5,s4,s1
    80004f12:	893e                	mv	s2,a5
    80004f14:	fcfcdae3          	bge	s9,a5,80004ee8 <consolewrite+0x38>
    80004f18:	896a                	mv	s2,s10
    80004f1a:	b7f9                	j	80004ee8 <consolewrite+0x38>
    80004f1c:	7906                	ld	s2,96(sp)
    80004f1e:	69e6                	ld	s3,88(sp)
    80004f20:	6a46                	ld	s4,80(sp)
    80004f22:	6aa6                	ld	s5,72(sp)
    80004f24:	6b06                	ld	s6,64(sp)
    80004f26:	7be2                	ld	s7,56(sp)
    80004f28:	7c42                	ld	s8,48(sp)
    80004f2a:	7ca2                	ld	s9,40(sp)
    80004f2c:	7d02                	ld	s10,32(sp)
    80004f2e:	a821                	j	80004f46 <consolewrite+0x96>
  int i = 0;
    80004f30:	4481                	li	s1,0
    80004f32:	a811                	j	80004f46 <consolewrite+0x96>
    80004f34:	7906                	ld	s2,96(sp)
    80004f36:	69e6                	ld	s3,88(sp)
    80004f38:	6a46                	ld	s4,80(sp)
    80004f3a:	6aa6                	ld	s5,72(sp)
    80004f3c:	6b06                	ld	s6,64(sp)
    80004f3e:	7be2                	ld	s7,56(sp)
    80004f40:	7c42                	ld	s8,48(sp)
    80004f42:	7ca2                	ld	s9,40(sp)
    80004f44:	7d02                	ld	s10,32(sp)
  }

  return i;
}
    80004f46:	8526                	mv	a0,s1
    80004f48:	70e6                	ld	ra,120(sp)
    80004f4a:	7446                	ld	s0,112(sp)
    80004f4c:	74a6                	ld	s1,104(sp)
    80004f4e:	6109                	addi	sp,sp,128
    80004f50:	8082                	ret

0000000080004f52 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80004f52:	711d                	addi	sp,sp,-96
    80004f54:	ec86                	sd	ra,88(sp)
    80004f56:	e8a2                	sd	s0,80(sp)
    80004f58:	e4a6                	sd	s1,72(sp)
    80004f5a:	e0ca                	sd	s2,64(sp)
    80004f5c:	fc4e                	sd	s3,56(sp)
    80004f5e:	f852                	sd	s4,48(sp)
    80004f60:	f05a                	sd	s6,32(sp)
    80004f62:	ec5e                	sd	s7,24(sp)
    80004f64:	1080                	addi	s0,sp,96
    80004f66:	8b2a                	mv	s6,a0
    80004f68:	8a2e                	mv	s4,a1
    80004f6a:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80004f6c:	8bb2                	mv	s7,a2
  acquire(&cons.lock);
    80004f6e:	0001e517          	auipc	a0,0x1e
    80004f72:	d4250513          	addi	a0,a0,-702 # 80022cb0 <cons>
    80004f76:	15d000ef          	jal	800058d2 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80004f7a:	0001e497          	auipc	s1,0x1e
    80004f7e:	d3648493          	addi	s1,s1,-714 # 80022cb0 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80004f82:	0001e917          	auipc	s2,0x1e
    80004f86:	dc690913          	addi	s2,s2,-570 # 80022d48 <cons+0x98>
  while(n > 0){
    80004f8a:	0b305b63          	blez	s3,80005040 <consoleread+0xee>
    while(cons.r == cons.w){
    80004f8e:	0984a783          	lw	a5,152(s1)
    80004f92:	09c4a703          	lw	a4,156(s1)
    80004f96:	0af71063          	bne	a4,a5,80005036 <consoleread+0xe4>
      if(killed(myproc())){
    80004f9a:	dabfb0ef          	jal	80000d44 <myproc>
    80004f9e:	de4fc0ef          	jal	80001582 <killed>
    80004fa2:	e12d                	bnez	a0,80005004 <consoleread+0xb2>
      sleep(&cons.r, &cons.lock);
    80004fa4:	85a6                	mv	a1,s1
    80004fa6:	854a                	mv	a0,s2
    80004fa8:	b9efc0ef          	jal	80001346 <sleep>
    while(cons.r == cons.w){
    80004fac:	0984a783          	lw	a5,152(s1)
    80004fb0:	09c4a703          	lw	a4,156(s1)
    80004fb4:	fef703e3          	beq	a4,a5,80004f9a <consoleread+0x48>
    80004fb8:	f456                	sd	s5,40(sp)
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    80004fba:	0001e717          	auipc	a4,0x1e
    80004fbe:	cf670713          	addi	a4,a4,-778 # 80022cb0 <cons>
    80004fc2:	0017869b          	addiw	a3,a5,1
    80004fc6:	08d72c23          	sw	a3,152(a4)
    80004fca:	07f7f693          	andi	a3,a5,127
    80004fce:	9736                	add	a4,a4,a3
    80004fd0:	01874703          	lbu	a4,24(a4)
    80004fd4:	00070a9b          	sext.w	s5,a4

    if(c == C('D')){  // end-of-file
    80004fd8:	4691                	li	a3,4
    80004fda:	04da8663          	beq	s5,a3,80005026 <consoleread+0xd4>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80004fde:	fae407a3          	sb	a4,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80004fe2:	4685                	li	a3,1
    80004fe4:	faf40613          	addi	a2,s0,-81
    80004fe8:	85d2                	mv	a1,s4
    80004fea:	855a                	mv	a0,s6
    80004fec:	eb2fc0ef          	jal	8000169e <either_copyout>
    80004ff0:	57fd                	li	a5,-1
    80004ff2:	04f50663          	beq	a0,a5,8000503e <consoleread+0xec>
      break;

    dst++;
    80004ff6:	0a05                	addi	s4,s4,1
    --n;
    80004ff8:	39fd                	addiw	s3,s3,-1

    if(c == '\n'){
    80004ffa:	47a9                	li	a5,10
    80004ffc:	04fa8b63          	beq	s5,a5,80005052 <consoleread+0x100>
    80005000:	7aa2                	ld	s5,40(sp)
    80005002:	b761                	j	80004f8a <consoleread+0x38>
        release(&cons.lock);
    80005004:	0001e517          	auipc	a0,0x1e
    80005008:	cac50513          	addi	a0,a0,-852 # 80022cb0 <cons>
    8000500c:	157000ef          	jal	80005962 <release>
        return -1;
    80005010:	557d                	li	a0,-1
    }
  }
  release(&cons.lock);

  return target - n;
}
    80005012:	60e6                	ld	ra,88(sp)
    80005014:	6446                	ld	s0,80(sp)
    80005016:	64a6                	ld	s1,72(sp)
    80005018:	6906                	ld	s2,64(sp)
    8000501a:	79e2                	ld	s3,56(sp)
    8000501c:	7a42                	ld	s4,48(sp)
    8000501e:	7b02                	ld	s6,32(sp)
    80005020:	6be2                	ld	s7,24(sp)
    80005022:	6125                	addi	sp,sp,96
    80005024:	8082                	ret
      if(n < target){
    80005026:	0179fa63          	bgeu	s3,s7,8000503a <consoleread+0xe8>
        cons.r--;
    8000502a:	0001e717          	auipc	a4,0x1e
    8000502e:	d0f72f23          	sw	a5,-738(a4) # 80022d48 <cons+0x98>
    80005032:	7aa2                	ld	s5,40(sp)
    80005034:	a031                	j	80005040 <consoleread+0xee>
    80005036:	f456                	sd	s5,40(sp)
    80005038:	b749                	j	80004fba <consoleread+0x68>
    8000503a:	7aa2                	ld	s5,40(sp)
    8000503c:	a011                	j	80005040 <consoleread+0xee>
    8000503e:	7aa2                	ld	s5,40(sp)
  release(&cons.lock);
    80005040:	0001e517          	auipc	a0,0x1e
    80005044:	c7050513          	addi	a0,a0,-912 # 80022cb0 <cons>
    80005048:	11b000ef          	jal	80005962 <release>
  return target - n;
    8000504c:	413b853b          	subw	a0,s7,s3
    80005050:	b7c9                	j	80005012 <consoleread+0xc0>
    80005052:	7aa2                	ld	s5,40(sp)
    80005054:	b7f5                	j	80005040 <consoleread+0xee>

0000000080005056 <consputc>:
{
    80005056:	1141                	addi	sp,sp,-16
    80005058:	e406                	sd	ra,8(sp)
    8000505a:	e022                	sd	s0,0(sp)
    8000505c:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    8000505e:	10000793          	li	a5,256
    80005062:	00f50863          	beq	a0,a5,80005072 <consputc+0x1c>
    uartputc_sync(c);
    80005066:	6f8000ef          	jal	8000575e <uartputc_sync>
}
    8000506a:	60a2                	ld	ra,8(sp)
    8000506c:	6402                	ld	s0,0(sp)
    8000506e:	0141                	addi	sp,sp,16
    80005070:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80005072:	4521                	li	a0,8
    80005074:	6ea000ef          	jal	8000575e <uartputc_sync>
    80005078:	02000513          	li	a0,32
    8000507c:	6e2000ef          	jal	8000575e <uartputc_sync>
    80005080:	4521                	li	a0,8
    80005082:	6dc000ef          	jal	8000575e <uartputc_sync>
    80005086:	b7d5                	j	8000506a <consputc+0x14>

0000000080005088 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005088:	1101                	addi	sp,sp,-32
    8000508a:	ec06                	sd	ra,24(sp)
    8000508c:	e822                	sd	s0,16(sp)
    8000508e:	e426                	sd	s1,8(sp)
    80005090:	1000                	addi	s0,sp,32
    80005092:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005094:	0001e517          	auipc	a0,0x1e
    80005098:	c1c50513          	addi	a0,a0,-996 # 80022cb0 <cons>
    8000509c:	037000ef          	jal	800058d2 <acquire>

  switch(c){
    800050a0:	47d5                	li	a5,21
    800050a2:	0af48163          	beq	s1,a5,80005144 <consoleintr+0xbc>
    800050a6:	0297c563          	blt	a5,s1,800050d0 <consoleintr+0x48>
    800050aa:	47a1                	li	a5,8
    800050ac:	0ef48663          	beq	s1,a5,80005198 <consoleintr+0x110>
    800050b0:	47c1                	li	a5,16
    800050b2:	10f49763          	bne	s1,a5,800051c0 <consoleintr+0x138>
  case C('P'):  // Print process list.
    procdump();
    800050b6:	e7cfc0ef          	jal	80001732 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    800050ba:	0001e517          	auipc	a0,0x1e
    800050be:	bf650513          	addi	a0,a0,-1034 # 80022cb0 <cons>
    800050c2:	0a1000ef          	jal	80005962 <release>
}
    800050c6:	60e2                	ld	ra,24(sp)
    800050c8:	6442                	ld	s0,16(sp)
    800050ca:	64a2                	ld	s1,8(sp)
    800050cc:	6105                	addi	sp,sp,32
    800050ce:	8082                	ret
  switch(c){
    800050d0:	07f00793          	li	a5,127
    800050d4:	0cf48263          	beq	s1,a5,80005198 <consoleintr+0x110>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    800050d8:	0001e717          	auipc	a4,0x1e
    800050dc:	bd870713          	addi	a4,a4,-1064 # 80022cb0 <cons>
    800050e0:	0a072783          	lw	a5,160(a4)
    800050e4:	09872703          	lw	a4,152(a4)
    800050e8:	9f99                	subw	a5,a5,a4
    800050ea:	07f00713          	li	a4,127
    800050ee:	fcf766e3          	bltu	a4,a5,800050ba <consoleintr+0x32>
      c = (c == '\r') ? '\n' : c;
    800050f2:	47b5                	li	a5,13
    800050f4:	0cf48963          	beq	s1,a5,800051c6 <consoleintr+0x13e>
      consputc(c);
    800050f8:	8526                	mv	a0,s1
    800050fa:	f5dff0ef          	jal	80005056 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    800050fe:	0001e717          	auipc	a4,0x1e
    80005102:	bb270713          	addi	a4,a4,-1102 # 80022cb0 <cons>
    80005106:	0a072683          	lw	a3,160(a4)
    8000510a:	0016879b          	addiw	a5,a3,1
    8000510e:	863e                	mv	a2,a5
    80005110:	0af72023          	sw	a5,160(a4)
    80005114:	07f6f693          	andi	a3,a3,127
    80005118:	9736                	add	a4,a4,a3
    8000511a:	00970c23          	sb	s1,24(a4)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    8000511e:	ff648713          	addi	a4,s1,-10
    80005122:	00173713          	seqz	a4,a4
    80005126:	14f1                	addi	s1,s1,-4
    80005128:	0014b493          	seqz	s1,s1
    8000512c:	8f45                	or	a4,a4,s1
    8000512e:	e361                	bnez	a4,800051ee <consoleintr+0x166>
    80005130:	0001e717          	auipc	a4,0x1e
    80005134:	c1872703          	lw	a4,-1000(a4) # 80022d48 <cons+0x98>
    80005138:	9f99                	subw	a5,a5,a4
    8000513a:	08000713          	li	a4,128
    8000513e:	f6e79ee3          	bne	a5,a4,800050ba <consoleintr+0x32>
    80005142:	a075                	j	800051ee <consoleintr+0x166>
    80005144:	e04a                	sd	s2,0(sp)
    while(cons.e != cons.w &&
    80005146:	0001e717          	auipc	a4,0x1e
    8000514a:	b6a70713          	addi	a4,a4,-1174 # 80022cb0 <cons>
    8000514e:	0a072783          	lw	a5,160(a4)
    80005152:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005156:	0001e497          	auipc	s1,0x1e
    8000515a:	b5a48493          	addi	s1,s1,-1190 # 80022cb0 <cons>
    while(cons.e != cons.w &&
    8000515e:	4929                	li	s2,10
    80005160:	02f70863          	beq	a4,a5,80005190 <consoleintr+0x108>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005164:	37fd                	addiw	a5,a5,-1
    80005166:	07f7f713          	andi	a4,a5,127
    8000516a:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    8000516c:	01874703          	lbu	a4,24(a4)
    80005170:	03270263          	beq	a4,s2,80005194 <consoleintr+0x10c>
      cons.e--;
    80005174:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80005178:	10000513          	li	a0,256
    8000517c:	edbff0ef          	jal	80005056 <consputc>
    while(cons.e != cons.w &&
    80005180:	0a04a783          	lw	a5,160(s1)
    80005184:	09c4a703          	lw	a4,156(s1)
    80005188:	fcf71ee3          	bne	a4,a5,80005164 <consoleintr+0xdc>
    8000518c:	6902                	ld	s2,0(sp)
    8000518e:	b735                	j	800050ba <consoleintr+0x32>
    80005190:	6902                	ld	s2,0(sp)
    80005192:	b725                	j	800050ba <consoleintr+0x32>
    80005194:	6902                	ld	s2,0(sp)
    80005196:	b715                	j	800050ba <consoleintr+0x32>
    if(cons.e != cons.w){
    80005198:	0001e717          	auipc	a4,0x1e
    8000519c:	b1870713          	addi	a4,a4,-1256 # 80022cb0 <cons>
    800051a0:	0a072783          	lw	a5,160(a4)
    800051a4:	09c72703          	lw	a4,156(a4)
    800051a8:	f0f709e3          	beq	a4,a5,800050ba <consoleintr+0x32>
      cons.e--;
    800051ac:	37fd                	addiw	a5,a5,-1
    800051ae:	0001e717          	auipc	a4,0x1e
    800051b2:	baf72123          	sw	a5,-1118(a4) # 80022d50 <cons+0xa0>
      consputc(BACKSPACE);
    800051b6:	10000513          	li	a0,256
    800051ba:	e9dff0ef          	jal	80005056 <consputc>
    800051be:	bdf5                	j	800050ba <consoleintr+0x32>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    800051c0:	ee048de3          	beqz	s1,800050ba <consoleintr+0x32>
    800051c4:	bf11                	j	800050d8 <consoleintr+0x50>
      consputc(c);
    800051c6:	4529                	li	a0,10
    800051c8:	e8fff0ef          	jal	80005056 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    800051cc:	0001e797          	auipc	a5,0x1e
    800051d0:	ae478793          	addi	a5,a5,-1308 # 80022cb0 <cons>
    800051d4:	0a07a703          	lw	a4,160(a5)
    800051d8:	0017069b          	addiw	a3,a4,1
    800051dc:	8636                	mv	a2,a3
    800051de:	0ad7a023          	sw	a3,160(a5)
    800051e2:	07f77713          	andi	a4,a4,127
    800051e6:	97ba                	add	a5,a5,a4
    800051e8:	4729                	li	a4,10
    800051ea:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    800051ee:	0001e797          	auipc	a5,0x1e
    800051f2:	b4c7af23          	sw	a2,-1186(a5) # 80022d4c <cons+0x9c>
        wakeup(&cons.r);
    800051f6:	0001e517          	auipc	a0,0x1e
    800051fa:	b5250513          	addi	a0,a0,-1198 # 80022d48 <cons+0x98>
    800051fe:	994fc0ef          	jal	80001392 <wakeup>
    80005202:	bd65                	j	800050ba <consoleintr+0x32>

0000000080005204 <consoleinit>:

void
consoleinit(void)
{
    80005204:	1141                	addi	sp,sp,-16
    80005206:	e406                	sd	ra,8(sp)
    80005208:	e022                	sd	s0,0(sp)
    8000520a:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    8000520c:	00002597          	auipc	a1,0x2
    80005210:	4bc58593          	addi	a1,a1,1212 # 800076c8 <etext+0x6c8>
    80005214:	0001e517          	auipc	a0,0x1e
    80005218:	a9c50513          	addi	a0,a0,-1380 # 80022cb0 <cons>
    8000521c:	62c000ef          	jal	80005848 <initlock>

  uartinit();
    80005220:	454000ef          	jal	80005674 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005224:	00015797          	auipc	a5,0x15
    80005228:	8f478793          	addi	a5,a5,-1804 # 80019b18 <devsw>
    8000522c:	00000717          	auipc	a4,0x0
    80005230:	d2670713          	addi	a4,a4,-730 # 80004f52 <consoleread>
    80005234:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005236:	00000717          	auipc	a4,0x0
    8000523a:	c7a70713          	addi	a4,a4,-902 # 80004eb0 <consolewrite>
    8000523e:	ef98                	sd	a4,24(a5)
}
    80005240:	60a2                	ld	ra,8(sp)
    80005242:	6402                	ld	s0,0(sp)
    80005244:	0141                	addi	sp,sp,16
    80005246:	8082                	ret

0000000080005248 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(long long xx, int base, int sign)
{
    80005248:	7139                	addi	sp,sp,-64
    8000524a:	fc06                	sd	ra,56(sp)
    8000524c:	f822                	sd	s0,48(sp)
    8000524e:	f04a                	sd	s2,32(sp)
    80005250:	0080                	addi	s0,sp,64
  char buf[20];
  int i;
  unsigned long long x;

  if(sign && (sign = (xx < 0)))
    80005252:	c219                	beqz	a2,80005258 <printint+0x10>
    80005254:	08054063          	bltz	a0,800052d4 <printint+0x8c>
    x = -xx;
  else
    x = xx;
    80005258:	4301                	li	t1,0

  i = 0;
    8000525a:	fc840913          	addi	s2,s0,-56
    x = xx;
    8000525e:	86ca                	mv	a3,s2
  i = 0;
    80005260:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    80005262:	00002817          	auipc	a6,0x2
    80005266:	5c680813          	addi	a6,a6,1478 # 80007828 <digits>
    8000526a:	88ba                	mv	a7,a4
    8000526c:	0017061b          	addiw	a2,a4,1
    80005270:	8732                	mv	a4,a2
    80005272:	02b577b3          	remu	a5,a0,a1
    80005276:	97c2                	add	a5,a5,a6
    80005278:	0007c783          	lbu	a5,0(a5)
    8000527c:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80005280:	87aa                	mv	a5,a0
    80005282:	02b55533          	divu	a0,a0,a1
    80005286:	0685                	addi	a3,a3,1
    80005288:	feb7f1e3          	bgeu	a5,a1,8000526a <printint+0x22>

  if(sign)
    8000528c:	00030b63          	beqz	t1,800052a2 <printint+0x5a>
    buf[i++] = '-';
    80005290:	fe040793          	addi	a5,s0,-32
    80005294:	963e                	add	a2,a2,a5
    80005296:	02d00793          	li	a5,45
    8000529a:	fef60423          	sb	a5,-24(a2)
    8000529e:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
    800052a2:	02e05463          	blez	a4,800052ca <printint+0x82>
    800052a6:	f426                	sd	s1,40(sp)
    800052a8:	377d                	addiw	a4,a4,-1
    800052aa:	00e904b3          	add	s1,s2,a4
    800052ae:	197d                	addi	s2,s2,-1
    800052b0:	993a                	add	s2,s2,a4
    800052b2:	1702                	slli	a4,a4,0x20
    800052b4:	9301                	srli	a4,a4,0x20
    800052b6:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    800052ba:	0004c503          	lbu	a0,0(s1)
    800052be:	d99ff0ef          	jal	80005056 <consputc>
  while(--i >= 0)
    800052c2:	14fd                	addi	s1,s1,-1
    800052c4:	ff249be3          	bne	s1,s2,800052ba <printint+0x72>
    800052c8:	74a2                	ld	s1,40(sp)
}
    800052ca:	70e2                	ld	ra,56(sp)
    800052cc:	7442                	ld	s0,48(sp)
    800052ce:	7902                	ld	s2,32(sp)
    800052d0:	6121                	addi	sp,sp,64
    800052d2:	8082                	ret
    x = -xx;
    800052d4:	40a00533          	neg	a0,a0
  if(sign && (sign = (xx < 0)))
    800052d8:	4305                	li	t1,1
    x = -xx;
    800052da:	b741                	j	8000525a <printint+0x12>

00000000800052dc <printf>:
}

// Print to the console.
int
printf(char *fmt, ...)
{
    800052dc:	7131                	addi	sp,sp,-192
    800052de:	fc86                	sd	ra,120(sp)
    800052e0:	f8a2                	sd	s0,112(sp)
    800052e2:	f4a6                	sd	s1,104(sp)
    800052e4:	0100                	addi	s0,sp,128
    800052e6:	84aa                	mv	s1,a0
    800052e8:	e40c                	sd	a1,8(s0)
    800052ea:	e810                	sd	a2,16(s0)
    800052ec:	ec14                	sd	a3,24(s0)
    800052ee:	f018                	sd	a4,32(s0)
    800052f0:	f41c                	sd	a5,40(s0)
    800052f2:	03043823          	sd	a6,48(s0)
    800052f6:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, cx, c0, c1, c2;
  char *s;

  if(panicking == 0)
    800052fa:	00002797          	auipc	a5,0x2
    800052fe:	5767a783          	lw	a5,1398(a5) # 80007870 <panicking>
    80005302:	cf9d                	beqz	a5,80005340 <printf+0x64>
    acquire(&pr.lock);

  va_start(ap, fmt);
    80005304:	00840793          	addi	a5,s0,8
    80005308:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    8000530c:	0004c503          	lbu	a0,0(s1)
    80005310:	22050363          	beqz	a0,80005536 <printf+0x25a>
    80005314:	f0ca                	sd	s2,96(sp)
    80005316:	ecce                	sd	s3,88(sp)
    80005318:	e8d2                	sd	s4,80(sp)
    8000531a:	e4d6                	sd	s5,72(sp)
    8000531c:	e0da                	sd	s6,64(sp)
    8000531e:	fc5e                	sd	s7,56(sp)
    80005320:	f862                	sd	s8,48(sp)
    80005322:	f06a                	sd	s10,32(sp)
    80005324:	ec6e                	sd	s11,24(sp)
    80005326:	4a01                	li	s4,0
    if(cx != '%'){
    80005328:	02500993          	li	s3,37
      printint(va_arg(ap, uint64), 10, 1);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
      printint(va_arg(ap, uint64), 10, 1);
      i += 2;
    } else if(c0 == 'u'){
    8000532c:	07500c13          	li	s8,117
      printint(va_arg(ap, uint64), 10, 0);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
      printint(va_arg(ap, uint64), 10, 0);
      i += 2;
    } else if(c0 == 'x'){
    80005330:	07800d13          	li	s10,120
      printint(va_arg(ap, uint64), 16, 0);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
      printint(va_arg(ap, uint64), 16, 0);
      i += 2;
    } else if(c0 == 'p'){
    80005334:	07000d93          	li	s11,112
      printint(va_arg(ap, uint64), 10, 0);
    80005338:	4b29                	li	s6,10
    if(c0 == 'd'){
    8000533a:	06400b93          	li	s7,100
    8000533e:	a015                	j	80005362 <printf+0x86>
    acquire(&pr.lock);
    80005340:	0001e517          	auipc	a0,0x1e
    80005344:	a1850513          	addi	a0,a0,-1512 # 80022d58 <pr>
    80005348:	58a000ef          	jal	800058d2 <acquire>
    8000534c:	bf65                	j	80005304 <printf+0x28>
      consputc(cx);
    8000534e:	d09ff0ef          	jal	80005056 <consputc>
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    80005352:	001a079b          	addiw	a5,s4,1
    80005356:	8a3e                	mv	s4,a5
    80005358:	97a6                	add	a5,a5,s1
    8000535a:	0007c503          	lbu	a0,0(a5)
    8000535e:	1c050363          	beqz	a0,80005524 <printf+0x248>
    if(cx != '%'){
    80005362:	ff3516e3          	bne	a0,s3,8000534e <printf+0x72>
    i++;
    80005366:	001a091b          	addiw	s2,s4,1
    c0 = fmt[i+0] & 0xff;
    8000536a:	012487b3          	add	a5,s1,s2
    8000536e:	0007ca83          	lbu	s5,0(a5)
    if(c0) c1 = fmt[i+1] & 0xff;
    80005372:	200a8763          	beqz	s5,80005580 <printf+0x2a4>
    80005376:	0017c703          	lbu	a4,1(a5)
    if(c1) c2 = fmt[i+2] & 0xff;
    8000537a:	1e070a63          	beqz	a4,8000556e <printf+0x292>
    if(c0 == 'd'){
    8000537e:	037a8963          	beq	s5,s7,800053b0 <printf+0xd4>
    } else if(c0 == 'l' && c1 == 'd'){
    80005382:	f94a8793          	addi	a5,s5,-108
    80005386:	0017b793          	seqz	a5,a5
    8000538a:	f9c70693          	addi	a3,a4,-100
    8000538e:	0016b693          	seqz	a3,a3
    80005392:	8efd                	and	a3,a3,a5
    80005394:	ca9d                	beqz	a3,800053ca <printf+0xee>
      printint(va_arg(ap, uint64), 10, 1);
    80005396:	f8843783          	ld	a5,-120(s0)
    8000539a:	00878713          	addi	a4,a5,8
    8000539e:	f8e43423          	sd	a4,-120(s0)
    800053a2:	4605                	li	a2,1
    800053a4:	85da                	mv	a1,s6
    800053a6:	6388                	ld	a0,0(a5)
    800053a8:	ea1ff0ef          	jal	80005248 <printint>
      i += 1;
    800053ac:	2a09                	addiw	s4,s4,2
    800053ae:	b755                	j	80005352 <printf+0x76>
      printint(va_arg(ap, int), 10, 1);
    800053b0:	f8843783          	ld	a5,-120(s0)
    800053b4:	00878713          	addi	a4,a5,8
    800053b8:	f8e43423          	sd	a4,-120(s0)
    800053bc:	4605                	li	a2,1
    800053be:	85da                	mv	a1,s6
    800053c0:	4388                	lw	a0,0(a5)
    800053c2:	e87ff0ef          	jal	80005248 <printint>
    i++;
    800053c6:	8a4a                	mv	s4,s2
    800053c8:	b769                	j	80005352 <printf+0x76>
    if(c1) c2 = fmt[i+2] & 0xff;
    800053ca:	012486b3          	add	a3,s1,s2
    800053ce:	863a                	mv	a2,a4
    800053d0:	0026c703          	lbu	a4,2(a3)
    800053d4:	aa65                	j	8000558c <printf+0x2b0>
      printint(va_arg(ap, uint64), 10, 1);
    800053d6:	f8843783          	ld	a5,-120(s0)
    800053da:	00878713          	addi	a4,a5,8
    800053de:	f8e43423          	sd	a4,-120(s0)
    800053e2:	4605                	li	a2,1
    800053e4:	45a9                	li	a1,10
    800053e6:	6388                	ld	a0,0(a5)
    800053e8:	e61ff0ef          	jal	80005248 <printint>
      i += 2;
    800053ec:	2a0d                	addiw	s4,s4,3
    800053ee:	b795                	j	80005352 <printf+0x76>
      printint(va_arg(ap, uint32), 10, 0);
    800053f0:	f8843783          	ld	a5,-120(s0)
    800053f4:	00878713          	addi	a4,a5,8
    800053f8:	f8e43423          	sd	a4,-120(s0)
    800053fc:	4601                	li	a2,0
    800053fe:	85da                	mv	a1,s6
    80005400:	0007e503          	lwu	a0,0(a5)
    80005404:	e45ff0ef          	jal	80005248 <printint>
    80005408:	bf7d                	j	800053c6 <printf+0xea>
      printint(va_arg(ap, uint64), 10, 0);
    8000540a:	f8843783          	ld	a5,-120(s0)
    8000540e:	00878713          	addi	a4,a5,8
    80005412:	f8e43423          	sd	a4,-120(s0)
    80005416:	4601                	li	a2,0
    80005418:	85da                	mv	a1,s6
    8000541a:	6388                	ld	a0,0(a5)
    8000541c:	e2dff0ef          	jal	80005248 <printint>
      i += 1;
    80005420:	2a09                	addiw	s4,s4,2
    80005422:	bf05                	j	80005352 <printf+0x76>
      printint(va_arg(ap, uint64), 10, 0);
    80005424:	f8843783          	ld	a5,-120(s0)
    80005428:	00878713          	addi	a4,a5,8
    8000542c:	f8e43423          	sd	a4,-120(s0)
    80005430:	4601                	li	a2,0
    80005432:	45a9                	li	a1,10
    80005434:	6388                	ld	a0,0(a5)
    80005436:	e13ff0ef          	jal	80005248 <printint>
      i += 2;
    8000543a:	2a0d                	addiw	s4,s4,3
    8000543c:	bf19                	j	80005352 <printf+0x76>
      printint(va_arg(ap, uint32), 16, 0);
    8000543e:	f8843783          	ld	a5,-120(s0)
    80005442:	00878713          	addi	a4,a5,8
    80005446:	f8e43423          	sd	a4,-120(s0)
    8000544a:	4601                	li	a2,0
    8000544c:	45c1                	li	a1,16
    8000544e:	0007e503          	lwu	a0,0(a5)
    80005452:	df7ff0ef          	jal	80005248 <printint>
    80005456:	bf85                	j	800053c6 <printf+0xea>
      printint(va_arg(ap, uint64), 16, 0);
    80005458:	f8843783          	ld	a5,-120(s0)
    8000545c:	00878713          	addi	a4,a5,8
    80005460:	f8e43423          	sd	a4,-120(s0)
    80005464:	4601                	li	a2,0
    80005466:	45c1                	li	a1,16
    80005468:	6388                	ld	a0,0(a5)
    8000546a:	ddfff0ef          	jal	80005248 <printint>
      i += 1;
    8000546e:	2a09                	addiw	s4,s4,2
    80005470:	b5cd                	j	80005352 <printf+0x76>
      printint(va_arg(ap, uint64), 16, 0);
    80005472:	f8843783          	ld	a5,-120(s0)
    80005476:	00878713          	addi	a4,a5,8
    8000547a:	f8e43423          	sd	a4,-120(s0)
    8000547e:	45c1                	li	a1,16
    80005480:	6388                	ld	a0,0(a5)
    80005482:	dc7ff0ef          	jal	80005248 <printint>
      i += 2;
    80005486:	2a0d                	addiw	s4,s4,3
    80005488:	b5e9                	j	80005352 <printf+0x76>
    8000548a:	f466                	sd	s9,40(sp)
      printptr(va_arg(ap, uint64));
    8000548c:	f8843783          	ld	a5,-120(s0)
    80005490:	00878713          	addi	a4,a5,8
    80005494:	f8e43423          	sd	a4,-120(s0)
    80005498:	0007ba83          	ld	s5,0(a5)
  consputc('0');
    8000549c:	03000513          	li	a0,48
    800054a0:	bb7ff0ef          	jal	80005056 <consputc>
  consputc('x');
    800054a4:	07800513          	li	a0,120
    800054a8:	bafff0ef          	jal	80005056 <consputc>
    800054ac:	4a41                	li	s4,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800054ae:	00002c97          	auipc	s9,0x2
    800054b2:	37ac8c93          	addi	s9,s9,890 # 80007828 <digits>
    800054b6:	03cad793          	srli	a5,s5,0x3c
    800054ba:	97e6                	add	a5,a5,s9
    800054bc:	0007c503          	lbu	a0,0(a5)
    800054c0:	b97ff0ef          	jal	80005056 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800054c4:	0a92                	slli	s5,s5,0x4
    800054c6:	3a7d                	addiw	s4,s4,-1
    800054c8:	fe0a17e3          	bnez	s4,800054b6 <printf+0x1da>
    800054cc:	7ca2                	ld	s9,40(sp)
    800054ce:	bde5                	j	800053c6 <printf+0xea>
    } else if(c0 == 'c'){
      consputc(va_arg(ap, uint));
    800054d0:	f8843783          	ld	a5,-120(s0)
    800054d4:	00878713          	addi	a4,a5,8
    800054d8:	f8e43423          	sd	a4,-120(s0)
    800054dc:	4388                	lw	a0,0(a5)
    800054de:	b79ff0ef          	jal	80005056 <consputc>
    800054e2:	b5d5                	j	800053c6 <printf+0xea>
    } else if(c0 == 's'){
      if((s = va_arg(ap, char*)) == 0)
    800054e4:	f8843783          	ld	a5,-120(s0)
    800054e8:	00878713          	addi	a4,a5,8
    800054ec:	f8e43423          	sd	a4,-120(s0)
    800054f0:	0007ba03          	ld	s4,0(a5)
    800054f4:	000a0d63          	beqz	s4,8000550e <printf+0x232>
        s = "(null)";
      for(; *s; s++)
    800054f8:	000a4503          	lbu	a0,0(s4)
    800054fc:	ec0505e3          	beqz	a0,800053c6 <printf+0xea>
        consputc(*s);
    80005500:	b57ff0ef          	jal	80005056 <consputc>
      for(; *s; s++)
    80005504:	0a05                	addi	s4,s4,1
    80005506:	000a4503          	lbu	a0,0(s4)
    8000550a:	f97d                	bnez	a0,80005500 <printf+0x224>
    8000550c:	bd6d                	j	800053c6 <printf+0xea>
        s = "(null)";
    8000550e:	00002a17          	auipc	s4,0x2
    80005512:	1c2a0a13          	addi	s4,s4,450 # 800076d0 <etext+0x6d0>
      for(; *s; s++)
    80005516:	02800513          	li	a0,40
    8000551a:	b7dd                	j	80005500 <printf+0x224>
    } else if(c0 == '%'){
      consputc('%');
    8000551c:	8556                	mv	a0,s5
    8000551e:	b39ff0ef          	jal	80005056 <consputc>
    80005522:	b555                	j	800053c6 <printf+0xea>
    80005524:	7906                	ld	s2,96(sp)
    80005526:	69e6                	ld	s3,88(sp)
    80005528:	6a46                	ld	s4,80(sp)
    8000552a:	6aa6                	ld	s5,72(sp)
    8000552c:	6b06                	ld	s6,64(sp)
    8000552e:	7be2                	ld	s7,56(sp)
    80005530:	7c42                	ld	s8,48(sp)
    80005532:	7d02                	ld	s10,32(sp)
    80005534:	6de2                	ld	s11,24(sp)
    }

  }
  va_end(ap);

  if(panicking == 0)
    80005536:	00002797          	auipc	a5,0x2
    8000553a:	33a7a783          	lw	a5,826(a5) # 80007870 <panicking>
    8000553e:	c38d                	beqz	a5,80005560 <printf+0x284>
    release(&pr.lock);

  return 0;
}
    80005540:	4501                	li	a0,0
    80005542:	70e6                	ld	ra,120(sp)
    80005544:	7446                	ld	s0,112(sp)
    80005546:	74a6                	ld	s1,104(sp)
    80005548:	6129                	addi	sp,sp,192
    8000554a:	8082                	ret
    8000554c:	7906                	ld	s2,96(sp)
    8000554e:	69e6                	ld	s3,88(sp)
    80005550:	6a46                	ld	s4,80(sp)
    80005552:	6aa6                	ld	s5,72(sp)
    80005554:	6b06                	ld	s6,64(sp)
    80005556:	7be2                	ld	s7,56(sp)
    80005558:	7c42                	ld	s8,48(sp)
    8000555a:	7d02                	ld	s10,32(sp)
    8000555c:	6de2                	ld	s11,24(sp)
    8000555e:	bfe1                	j	80005536 <printf+0x25a>
    release(&pr.lock);
    80005560:	0001d517          	auipc	a0,0x1d
    80005564:	7f850513          	addi	a0,a0,2040 # 80022d58 <pr>
    80005568:	3fa000ef          	jal	80005962 <release>
  return 0;
    8000556c:	bfd1                	j	80005540 <printf+0x264>
    if(c0 == 'd'){
    8000556e:	e57a81e3          	beq	s5,s7,800053b0 <printf+0xd4>
    } else if(c0 == 'l' && c1 == 'd'){
    80005572:	f94a8793          	addi	a5,s5,-108
    80005576:	0017b793          	seqz	a5,a5
    8000557a:	863a                	mv	a2,a4
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    8000557c:	4681                	li	a3,0
    8000557e:	a01d                	j	800055a4 <printf+0x2c8>
    } else if(c0 == 'l' && c1 == 'd'){
    80005580:	f94a8793          	addi	a5,s5,-108
    80005584:	0017b793          	seqz	a5,a5
    c1 = c2 = 0;
    80005588:	8656                	mv	a2,s5
    8000558a:	8756                	mv	a4,s5
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    8000558c:	f9460693          	addi	a3,a2,-108
    80005590:	0016b693          	seqz	a3,a3
    80005594:	8efd                	and	a3,a3,a5
    80005596:	f9c70593          	addi	a1,a4,-100
    8000559a:	0015b593          	seqz	a1,a1
    8000559e:	8df5                	and	a1,a1,a3
    800055a0:	e2059be3          	bnez	a1,800053d6 <printf+0xfa>
    } else if(c0 == 'u'){
    800055a4:	e58a86e3          	beq	s5,s8,800053f0 <printf+0x114>
    } else if(c0 == 'l' && c1 == 'u'){
    800055a8:	f8b60593          	addi	a1,a2,-117
    800055ac:	0015b593          	seqz	a1,a1
    800055b0:	8dfd                	and	a1,a1,a5
    800055b2:	e4059ce3          	bnez	a1,8000540a <printf+0x12e>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    800055b6:	f8b70593          	addi	a1,a4,-117
    800055ba:	0015b593          	seqz	a1,a1
    800055be:	8df5                	and	a1,a1,a3
    800055c0:	e60592e3          	bnez	a1,80005424 <printf+0x148>
    } else if(c0 == 'x'){
    800055c4:	e7aa8de3          	beq	s5,s10,8000543e <printf+0x162>
    } else if(c0 == 'l' && c1 == 'x'){
    800055c8:	f8860613          	addi	a2,a2,-120
    800055cc:	00163613          	seqz	a2,a2
    800055d0:	8e7d                	and	a2,a2,a5
    800055d2:	e80613e3          	bnez	a2,80005458 <printf+0x17c>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    800055d6:	f8870713          	addi	a4,a4,-120
    800055da:	00173713          	seqz	a4,a4
    800055de:	8f75                	and	a4,a4,a3
    800055e0:	e80719e3          	bnez	a4,80005472 <printf+0x196>
    } else if(c0 == 'p'){
    800055e4:	ebba83e3          	beq	s5,s11,8000548a <printf+0x1ae>
    } else if(c0 == 'c'){
    800055e8:	06300793          	li	a5,99
    800055ec:	eefa82e3          	beq	s5,a5,800054d0 <printf+0x1f4>
    } else if(c0 == 's'){
    800055f0:	07300793          	li	a5,115
    800055f4:	eefa88e3          	beq	s5,a5,800054e4 <printf+0x208>
    } else if(c0 == '%'){
    800055f8:	02500793          	li	a5,37
    800055fc:	f2fa80e3          	beq	s5,a5,8000551c <printf+0x240>
    } else if(c0 == 0){
    80005600:	f40a86e3          	beqz	s5,8000554c <printf+0x270>
      consputc('%');
    80005604:	02500513          	li	a0,37
    80005608:	a4fff0ef          	jal	80005056 <consputc>
      consputc(c0);
    8000560c:	8556                	mv	a0,s5
    8000560e:	a49ff0ef          	jal	80005056 <consputc>
    80005612:	bb55                	j	800053c6 <printf+0xea>

0000000080005614 <panic>:

void
panic(char *s)
{
    80005614:	1101                	addi	sp,sp,-32
    80005616:	ec06                	sd	ra,24(sp)
    80005618:	e822                	sd	s0,16(sp)
    8000561a:	e426                	sd	s1,8(sp)
    8000561c:	e04a                	sd	s2,0(sp)
    8000561e:	1000                	addi	s0,sp,32
    80005620:	892a                	mv	s2,a0
  panicking = 1;
    80005622:	4485                	li	s1,1
    80005624:	00002797          	auipc	a5,0x2
    80005628:	2497a623          	sw	s1,588(a5) # 80007870 <panicking>
  printf("panic: ");
    8000562c:	00002517          	auipc	a0,0x2
    80005630:	0ac50513          	addi	a0,a0,172 # 800076d8 <etext+0x6d8>
    80005634:	ca9ff0ef          	jal	800052dc <printf>
  printf("%s\n", s);
    80005638:	85ca                	mv	a1,s2
    8000563a:	00002517          	auipc	a0,0x2
    8000563e:	0a650513          	addi	a0,a0,166 # 800076e0 <etext+0x6e0>
    80005642:	c9bff0ef          	jal	800052dc <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005646:	00002797          	auipc	a5,0x2
    8000564a:	2297a323          	sw	s1,550(a5) # 8000786c <panicked>
  for(;;)
    8000564e:	a001                	j	8000564e <panic+0x3a>

0000000080005650 <printfinit>:
    ;
}

void
printfinit(void)
{
    80005650:	1141                	addi	sp,sp,-16
    80005652:	e406                	sd	ra,8(sp)
    80005654:	e022                	sd	s0,0(sp)
    80005656:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    80005658:	00002597          	auipc	a1,0x2
    8000565c:	09058593          	addi	a1,a1,144 # 800076e8 <etext+0x6e8>
    80005660:	0001d517          	auipc	a0,0x1d
    80005664:	6f850513          	addi	a0,a0,1784 # 80022d58 <pr>
    80005668:	1e0000ef          	jal	80005848 <initlock>
}
    8000566c:	60a2                	ld	ra,8(sp)
    8000566e:	6402                	ld	s0,0(sp)
    80005670:	0141                	addi	sp,sp,16
    80005672:	8082                	ret

0000000080005674 <uartinit>:
extern volatile int panicking; // from printf.c
extern volatile int panicked; // from printf.c

void
uartinit(void)
{
    80005674:	1141                	addi	sp,sp,-16
    80005676:	e406                	sd	ra,8(sp)
    80005678:	e022                	sd	s0,0(sp)
    8000567a:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    8000567c:	100007b7          	lui	a5,0x10000
    80005680:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80005684:	10000737          	lui	a4,0x10000
    80005688:	f8000693          	li	a3,-128
    8000568c:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80005690:	468d                	li	a3,3
    80005692:	10000637          	lui	a2,0x10000
    80005696:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    8000569a:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    8000569e:	00d701a3          	sb	a3,3(a4)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800056a2:	8732                	mv	a4,a2
    800056a4:	461d                	li	a2,7
    800056a6:	00c70123          	sb	a2,2(a4)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800056aa:	00d780a3          	sb	a3,1(a5)

  initlock(&tx_lock, "uart");
    800056ae:	00002597          	auipc	a1,0x2
    800056b2:	04258593          	addi	a1,a1,66 # 800076f0 <etext+0x6f0>
    800056b6:	0001d517          	auipc	a0,0x1d
    800056ba:	6ba50513          	addi	a0,a0,1722 # 80022d70 <tx_lock>
    800056be:	18a000ef          	jal	80005848 <initlock>
}
    800056c2:	60a2                	ld	ra,8(sp)
    800056c4:	6402                	ld	s0,0(sp)
    800056c6:	0141                	addi	sp,sp,16
    800056c8:	8082                	ret

00000000800056ca <uartwrite>:
// transmit buf[] to the uart. it blocks if the
// uart is busy, so it cannot be called from
// interrupts, only from write() system calls.
void
uartwrite(char buf[], int n)
{
    800056ca:	715d                	addi	sp,sp,-80
    800056cc:	e486                	sd	ra,72(sp)
    800056ce:	e0a2                	sd	s0,64(sp)
    800056d0:	fc26                	sd	s1,56(sp)
    800056d2:	ec56                	sd	s5,24(sp)
    800056d4:	0880                	addi	s0,sp,80
    800056d6:	8aaa                	mv	s5,a0
    800056d8:	84ae                	mv	s1,a1
  acquire(&tx_lock);
    800056da:	0001d517          	auipc	a0,0x1d
    800056de:	69650513          	addi	a0,a0,1686 # 80022d70 <tx_lock>
    800056e2:	1f0000ef          	jal	800058d2 <acquire>

  int i = 0;
  while(i < n){ 
    800056e6:	06905063          	blez	s1,80005746 <uartwrite+0x7c>
    800056ea:	f84a                	sd	s2,48(sp)
    800056ec:	f44e                	sd	s3,40(sp)
    800056ee:	f052                	sd	s4,32(sp)
    800056f0:	e85a                	sd	s6,16(sp)
    800056f2:	e45e                	sd	s7,8(sp)
    800056f4:	8a56                	mv	s4,s5
    800056f6:	9aa6                	add	s5,s5,s1
    while(tx_busy != 0){
    800056f8:	00002497          	auipc	s1,0x2
    800056fc:	18048493          	addi	s1,s1,384 # 80007878 <tx_busy>
      // wait for a UART transmit-complete interrupt
      // to set tx_busy to 0.
      sleep(&tx_chan, &tx_lock);
    80005700:	0001d997          	auipc	s3,0x1d
    80005704:	67098993          	addi	s3,s3,1648 # 80022d70 <tx_lock>
    80005708:	00002917          	auipc	s2,0x2
    8000570c:	16c90913          	addi	s2,s2,364 # 80007874 <tx_chan>
    }   
      
    WriteReg(THR, buf[i]);
    80005710:	10000bb7          	lui	s7,0x10000
    i += 1;
    tx_busy = 1;
    80005714:	4b05                	li	s6,1
    80005716:	a005                	j	80005736 <uartwrite+0x6c>
      sleep(&tx_chan, &tx_lock);
    80005718:	85ce                	mv	a1,s3
    8000571a:	854a                	mv	a0,s2
    8000571c:	c2bfb0ef          	jal	80001346 <sleep>
    while(tx_busy != 0){
    80005720:	409c                	lw	a5,0(s1)
    80005722:	fbfd                	bnez	a5,80005718 <uartwrite+0x4e>
    WriteReg(THR, buf[i]);
    80005724:	000a4783          	lbu	a5,0(s4)
    80005728:	00fb8023          	sb	a5,0(s7) # 10000000 <_entry-0x70000000>
    tx_busy = 1;
    8000572c:	0164a023          	sw	s6,0(s1)
  while(i < n){ 
    80005730:	0a05                	addi	s4,s4,1
    80005732:	015a0563          	beq	s4,s5,8000573c <uartwrite+0x72>
    while(tx_busy != 0){
    80005736:	409c                	lw	a5,0(s1)
    80005738:	f3e5                	bnez	a5,80005718 <uartwrite+0x4e>
    8000573a:	b7ed                	j	80005724 <uartwrite+0x5a>
    8000573c:	7942                	ld	s2,48(sp)
    8000573e:	79a2                	ld	s3,40(sp)
    80005740:	7a02                	ld	s4,32(sp)
    80005742:	6b42                	ld	s6,16(sp)
    80005744:	6ba2                	ld	s7,8(sp)
  }

  release(&tx_lock);
    80005746:	0001d517          	auipc	a0,0x1d
    8000574a:	62a50513          	addi	a0,a0,1578 # 80022d70 <tx_lock>
    8000574e:	214000ef          	jal	80005962 <release>
}
    80005752:	60a6                	ld	ra,72(sp)
    80005754:	6406                	ld	s0,64(sp)
    80005756:	74e2                	ld	s1,56(sp)
    80005758:	6ae2                	ld	s5,24(sp)
    8000575a:	6161                	addi	sp,sp,80
    8000575c:	8082                	ret

000000008000575e <uartputc_sync>:
// interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    8000575e:	1101                	addi	sp,sp,-32
    80005760:	ec06                	sd	ra,24(sp)
    80005762:	e822                	sd	s0,16(sp)
    80005764:	e426                	sd	s1,8(sp)
    80005766:	1000                	addi	s0,sp,32
    80005768:	84aa                	mv	s1,a0
  if(panicking == 0)
    8000576a:	00002797          	auipc	a5,0x2
    8000576e:	1067a783          	lw	a5,262(a5) # 80007870 <panicking>
    80005772:	cb91                	beqz	a5,80005786 <uartputc_sync+0x28>
    push_off();

  if(panicked){
    80005774:	00002797          	auipc	a5,0x2
    80005778:	0f87a783          	lw	a5,248(a5) # 8000786c <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    8000577c:	10000737          	lui	a4,0x10000
    80005780:	0715                	addi	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
  if(panicked){
    80005782:	c789                	beqz	a5,8000578c <uartputc_sync+0x2e>
    for(;;)
    80005784:	a001                	j	80005784 <uartputc_sync+0x26>
    push_off();
    80005786:	108000ef          	jal	8000588e <push_off>
    8000578a:	b7ed                	j	80005774 <uartputc_sync+0x16>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    8000578c:	00074783          	lbu	a5,0(a4)
    80005790:	0207f793          	andi	a5,a5,32
    80005794:	dfe5                	beqz	a5,8000578c <uartputc_sync+0x2e>
    ;
  WriteReg(THR, c);
    80005796:	100007b7          	lui	a5,0x10000
    8000579a:	00978023          	sb	s1,0(a5) # 10000000 <_entry-0x70000000>

  if(panicking == 0)
    8000579e:	00002797          	auipc	a5,0x2
    800057a2:	0d27a783          	lw	a5,210(a5) # 80007870 <panicking>
    800057a6:	c791                	beqz	a5,800057b2 <uartputc_sync+0x54>
    pop_off();
}
    800057a8:	60e2                	ld	ra,24(sp)
    800057aa:	6442                	ld	s0,16(sp)
    800057ac:	64a2                	ld	s1,8(sp)
    800057ae:	6105                	addi	sp,sp,32
    800057b0:	8082                	ret
    pop_off();
    800057b2:	160000ef          	jal	80005912 <pop_off>
}
    800057b6:	bfcd                	j	800057a8 <uartputc_sync+0x4a>

00000000800057b8 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    800057b8:	1141                	addi	sp,sp,-16
    800057ba:	e406                	sd	ra,8(sp)
    800057bc:	e022                	sd	s0,0(sp)
    800057be:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & LSR_RX_READY){
    800057c0:	100007b7          	lui	a5,0x10000
    800057c4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800057c8:	8b85                	andi	a5,a5,1
    800057ca:	cb89                	beqz	a5,800057dc <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    800057cc:	100007b7          	lui	a5,0x10000
    800057d0:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    800057d4:	60a2                	ld	ra,8(sp)
    800057d6:	6402                	ld	s0,0(sp)
    800057d8:	0141                	addi	sp,sp,16
    800057da:	8082                	ret
    return -1;
    800057dc:	557d                	li	a0,-1
    800057de:	bfdd                	j	800057d4 <uartgetc+0x1c>

00000000800057e0 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    800057e0:	1101                	addi	sp,sp,-32
    800057e2:	ec06                	sd	ra,24(sp)
    800057e4:	e822                	sd	s0,16(sp)
    800057e6:	e426                	sd	s1,8(sp)
    800057e8:	1000                	addi	s0,sp,32
  ReadReg(ISR); // acknowledge the interrupt
    800057ea:	100007b7          	lui	a5,0x10000
    800057ee:	0027c783          	lbu	a5,2(a5) # 10000002 <_entry-0x6ffffffe>

  acquire(&tx_lock);
    800057f2:	0001d517          	auipc	a0,0x1d
    800057f6:	57e50513          	addi	a0,a0,1406 # 80022d70 <tx_lock>
    800057fa:	0d8000ef          	jal	800058d2 <acquire>
  if(ReadReg(LSR) & LSR_TX_IDLE){
    800057fe:	100007b7          	lui	a5,0x10000
    80005802:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80005806:	0207f793          	andi	a5,a5,32
    8000580a:	ef99                	bnez	a5,80005828 <uartintr+0x48>
    // UART finished transmitting; wake up sending thread.
    tx_busy = 0;
    wakeup(&tx_chan);
  }
  release(&tx_lock);
    8000580c:	0001d517          	auipc	a0,0x1d
    80005810:	56450513          	addi	a0,a0,1380 # 80022d70 <tx_lock>
    80005814:	14e000ef          	jal	80005962 <release>

  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    80005818:	54fd                	li	s1,-1
    int c = uartgetc();
    8000581a:	f9fff0ef          	jal	800057b8 <uartgetc>
    if(c == -1)
    8000581e:	02950063          	beq	a0,s1,8000583e <uartintr+0x5e>
      break;
    consoleintr(c);
    80005822:	867ff0ef          	jal	80005088 <consoleintr>
  while(1){
    80005826:	bfd5                	j	8000581a <uartintr+0x3a>
    tx_busy = 0;
    80005828:	00002797          	auipc	a5,0x2
    8000582c:	0407a823          	sw	zero,80(a5) # 80007878 <tx_busy>
    wakeup(&tx_chan);
    80005830:	00002517          	auipc	a0,0x2
    80005834:	04450513          	addi	a0,a0,68 # 80007874 <tx_chan>
    80005838:	b5bfb0ef          	jal	80001392 <wakeup>
    8000583c:	bfc1                	j	8000580c <uartintr+0x2c>
  }
}
    8000583e:	60e2                	ld	ra,24(sp)
    80005840:	6442                	ld	s0,16(sp)
    80005842:	64a2                	ld	s1,8(sp)
    80005844:	6105                	addi	sp,sp,32
    80005846:	8082                	ret

0000000080005848 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80005848:	1141                	addi	sp,sp,-16
    8000584a:	e406                	sd	ra,8(sp)
    8000584c:	e022                	sd	s0,0(sp)
    8000584e:	0800                	addi	s0,sp,16
  lk->name = name;
    80005850:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80005852:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80005856:	00053823          	sd	zero,16(a0)
}
    8000585a:	60a2                	ld	ra,8(sp)
    8000585c:	6402                	ld	s0,0(sp)
    8000585e:	0141                	addi	sp,sp,16
    80005860:	8082                	ret

0000000080005862 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80005862:	411c                	lw	a5,0(a0)
    80005864:	e399                	bnez	a5,8000586a <holding+0x8>
    80005866:	4501                	li	a0,0
  return r;
}
    80005868:	8082                	ret
{
    8000586a:	1101                	addi	sp,sp,-32
    8000586c:	ec06                	sd	ra,24(sp)
    8000586e:	e822                	sd	s0,16(sp)
    80005870:	e426                	sd	s1,8(sp)
    80005872:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80005874:	691c                	ld	a5,16(a0)
    80005876:	84be                	mv	s1,a5
    80005878:	cacfb0ef          	jal	80000d24 <mycpu>
    8000587c:	40a48533          	sub	a0,s1,a0
    80005880:	00153513          	seqz	a0,a0
}
    80005884:	60e2                	ld	ra,24(sp)
    80005886:	6442                	ld	s0,16(sp)
    80005888:	64a2                	ld	s1,8(sp)
    8000588a:	6105                	addi	sp,sp,32
    8000588c:	8082                	ret

000000008000588e <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    8000588e:	1101                	addi	sp,sp,-32
    80005890:	ec06                	sd	ra,24(sp)
    80005892:	e822                	sd	s0,16(sp)
    80005894:	e426                	sd	s1,8(sp)
    80005896:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80005898:	100027f3          	csrr	a5,sstatus
    8000589c:	84be                	mv	s1,a5
    8000589e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800058a2:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800058a4:	10079073          	csrw	sstatus,a5

  // disable interrupts to prevent an involuntary context
  // switch while using mycpu().
  intr_off();

  if(mycpu()->noff == 0)
    800058a8:	c7cfb0ef          	jal	80000d24 <mycpu>
    800058ac:	5d3c                	lw	a5,120(a0)
    800058ae:	cb99                	beqz	a5,800058c4 <push_off+0x36>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    800058b0:	c74fb0ef          	jal	80000d24 <mycpu>
    800058b4:	5d3c                	lw	a5,120(a0)
    800058b6:	2785                	addiw	a5,a5,1
    800058b8:	dd3c                	sw	a5,120(a0)
}
    800058ba:	60e2                	ld	ra,24(sp)
    800058bc:	6442                	ld	s0,16(sp)
    800058be:	64a2                	ld	s1,8(sp)
    800058c0:	6105                	addi	sp,sp,32
    800058c2:	8082                	ret
    mycpu()->intena = old;
    800058c4:	c60fb0ef          	jal	80000d24 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    800058c8:	0014d793          	srli	a5,s1,0x1
    800058cc:	8b85                	andi	a5,a5,1
    800058ce:	dd7c                	sw	a5,124(a0)
    800058d0:	b7c5                	j	800058b0 <push_off+0x22>

00000000800058d2 <acquire>:
{
    800058d2:	1101                	addi	sp,sp,-32
    800058d4:	ec06                	sd	ra,24(sp)
    800058d6:	e822                	sd	s0,16(sp)
    800058d8:	e426                	sd	s1,8(sp)
    800058da:	1000                	addi	s0,sp,32
    800058dc:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    800058de:	fb1ff0ef          	jal	8000588e <push_off>
  if(holding(lk))
    800058e2:	8526                	mv	a0,s1
    800058e4:	f7fff0ef          	jal	80005862 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800058e8:	4705                	li	a4,1
  if(holding(lk))
    800058ea:	ed11                	bnez	a0,80005906 <acquire+0x34>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800058ec:	0ce4a7af          	amoswap.w.aq	a5,a4,(s1)
    800058f0:	fff5                	bnez	a5,800058ec <acquire+0x1a>
  __sync_synchronize();
    800058f2:	0330000f          	fence	rw,rw
  lk->cpu = mycpu();
    800058f6:	c2efb0ef          	jal	80000d24 <mycpu>
    800058fa:	e888                	sd	a0,16(s1)
}
    800058fc:	60e2                	ld	ra,24(sp)
    800058fe:	6442                	ld	s0,16(sp)
    80005900:	64a2                	ld	s1,8(sp)
    80005902:	6105                	addi	sp,sp,32
    80005904:	8082                	ret
    panic("acquire");
    80005906:	00002517          	auipc	a0,0x2
    8000590a:	df250513          	addi	a0,a0,-526 # 800076f8 <etext+0x6f8>
    8000590e:	d07ff0ef          	jal	80005614 <panic>

0000000080005912 <pop_off>:

void
pop_off(void)
{
    80005912:	1141                	addi	sp,sp,-16
    80005914:	e406                	sd	ra,8(sp)
    80005916:	e022                	sd	s0,0(sp)
    80005918:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    8000591a:	c0afb0ef          	jal	80000d24 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000591e:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80005922:	8b89                	andi	a5,a5,2
  if(intr_get())
    80005924:	e39d                	bnez	a5,8000594a <pop_off+0x38>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80005926:	5d3c                	lw	a5,120(a0)
    80005928:	02f05763          	blez	a5,80005956 <pop_off+0x44>
    panic("pop_off");
  c->noff -= 1;
    8000592c:	37fd                	addiw	a5,a5,-1
    8000592e:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80005930:	eb89                	bnez	a5,80005942 <pop_off+0x30>
    80005932:	5d7c                	lw	a5,124(a0)
    80005934:	c799                	beqz	a5,80005942 <pop_off+0x30>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80005936:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000593a:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000593e:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80005942:	60a2                	ld	ra,8(sp)
    80005944:	6402                	ld	s0,0(sp)
    80005946:	0141                	addi	sp,sp,16
    80005948:	8082                	ret
    panic("pop_off - interruptible");
    8000594a:	00002517          	auipc	a0,0x2
    8000594e:	db650513          	addi	a0,a0,-586 # 80007700 <etext+0x700>
    80005952:	cc3ff0ef          	jal	80005614 <panic>
    panic("pop_off");
    80005956:	00002517          	auipc	a0,0x2
    8000595a:	dc250513          	addi	a0,a0,-574 # 80007718 <etext+0x718>
    8000595e:	cb7ff0ef          	jal	80005614 <panic>

0000000080005962 <release>:
{
    80005962:	1101                	addi	sp,sp,-32
    80005964:	ec06                	sd	ra,24(sp)
    80005966:	e822                	sd	s0,16(sp)
    80005968:	e426                	sd	s1,8(sp)
    8000596a:	1000                	addi	s0,sp,32
    8000596c:	84aa                	mv	s1,a0
  if(!holding(lk))
    8000596e:	ef5ff0ef          	jal	80005862 <holding>
    80005972:	c105                	beqz	a0,80005992 <release+0x30>
  lk->cpu = 0;
    80005974:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80005978:	0330000f          	fence	rw,rw
  __sync_lock_release(&lk->locked);
    8000597c:	0310000f          	fence	rw,w
    80005980:	0004a023          	sw	zero,0(s1)
  pop_off();
    80005984:	f8fff0ef          	jal	80005912 <pop_off>
}
    80005988:	60e2                	ld	ra,24(sp)
    8000598a:	6442                	ld	s0,16(sp)
    8000598c:	64a2                	ld	s1,8(sp)
    8000598e:	6105                	addi	sp,sp,32
    80005990:	8082                	ret
    panic("release");
    80005992:	00002517          	auipc	a0,0x2
    80005996:	d8e50513          	addi	a0,a0,-626 # 80007720 <etext+0x720>
    8000599a:	c7bff0ef          	jal	80005614 <panic>
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
