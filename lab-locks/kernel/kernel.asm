
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
_entry:
        # set up a stack for C.
        # stack0 is declared in start.c,
        # with a 4096-byte stack per CPU.
        # sp = stack0 + ((hartid + 1) * 4096)
        la sp, stack0
    80000000:	0001c117          	auipc	sp,0x1c
    80000004:	89010113          	addi	sp,sp,-1904 # 8001b890 <stack0>
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
    80000016:	274050ef          	jal	8000528a <start>

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
    8000001c:	7139                	addi	sp,sp,-64
    8000001e:	fc06                	sd	ra,56(sp)
    80000020:	f822                	sd	s0,48(sp)
    80000022:	f426                	sd	s1,40(sp)
    80000024:	f04a                	sd	s2,32(sp)
    80000026:	ec4e                	sd	s3,24(sp)
    80000028:	e852                	sd	s4,16(sp)
    8000002a:	e456                	sd	s5,8(sp)
    8000002c:	0080                	addi	s0,sp,64
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    8000002e:	00025797          	auipc	a5,0x25
    80000032:	91278793          	addi	a5,a5,-1774 # 80024940 <end>
    80000036:	00f53733          	sltu	a4,a0,a5
    8000003a:	47c5                	li	a5,17
    8000003c:	07ee                	slli	a5,a5,0x1b
    8000003e:	17fd                	addi	a5,a5,-1
    80000040:	00a7b7b3          	sltu	a5,a5,a0
    80000044:	8fd9                	or	a5,a5,a4
    80000046:	03451713          	slli	a4,a0,0x34
    8000004a:	8fd9                	or	a5,a5,a4
    8000004c:	ebb1                	bnez	a5,800000a0 <kfree+0x84>
    8000004e:	84aa                	mv	s1,a0
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000050:	6605                	lui	a2,0x1
    80000052:	4585                	li	a1,1
    80000054:	1e2000ef          	jal	80000236 <memset>
  r = (struct run*)pa;
  //calling push_off and pop_off to disable interrupts when getting cpuid
  push_off();
    80000058:	4ff050ef          	jal	80005d56 <push_off>
  int cpu=cpuid();
    8000005c:	5a5000ef          	jal	80000e00 <cpuid>
  
  acquire(&kmem[cpu].lock);
    80000060:	00009a97          	auipc	s5,0x9
    80000064:	cc0a8a93          	addi	s5,s5,-832 # 80008d20 <kmem>
    80000068:	00151993          	slli	s3,a0,0x1
    8000006c:	00a98933          	add	s2,s3,a0
    80000070:	0912                	slli	s2,s2,0x4
    80000072:	9956                	add	s2,s2,s5
    80000074:	854a                	mv	a0,s2
    80000076:	525050ef          	jal	80005d9a <acquire>
  //adding the new freed page to the freelist
  r->next=kmem[cpu].freelist;
    8000007a:	02093783          	ld	a5,32(s2)
    8000007e:	e09c                	sd	a5,0(s1)
  kmem[cpu].freelist=r;
    80000080:	02993023          	sd	s1,32(s2)
  release(&kmem[cpu].lock);
    80000084:	854a                	mv	a0,s2
    80000086:	651050ef          	jal	80005ed6 <release>
  pop_off();
    8000008a:	5fd050ef          	jal	80005e86 <pop_off>

}
    8000008e:	70e2                	ld	ra,56(sp)
    80000090:	7442                	ld	s0,48(sp)
    80000092:	74a2                	ld	s1,40(sp)
    80000094:	7902                	ld	s2,32(sp)
    80000096:	69e2                	ld	s3,24(sp)
    80000098:	6a42                	ld	s4,16(sp)
    8000009a:	6aa2                	ld	s5,8(sp)
    8000009c:	6121                	addi	sp,sp,64
    8000009e:	8082                	ret
    panic("kfree");
    800000a0:	00008517          	auipc	a0,0x8
    800000a4:	f6050513          	addi	a0,a0,-160 # 80008000 <etext>
    800000a8:	1b7050ef          	jal	80005a5e <panic>

00000000800000ac <freerange>:
{
    800000ac:	7179                	addi	sp,sp,-48
    800000ae:	f406                	sd	ra,40(sp)
    800000b0:	f022                	sd	s0,32(sp)
    800000b2:	ec26                	sd	s1,24(sp)
    800000b4:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800000b6:	6785                	lui	a5,0x1
    800000b8:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    800000bc:	00e504b3          	add	s1,a0,a4
    800000c0:	777d                	lui	a4,0xfffff
    800000c2:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000c4:	94be                	add	s1,s1,a5
    800000c6:	0295e263          	bltu	a1,s1,800000ea <freerange+0x3e>
    800000ca:	e84a                	sd	s2,16(sp)
    800000cc:	e44e                	sd	s3,8(sp)
    800000ce:	e052                	sd	s4,0(sp)
    800000d0:	892e                	mv	s2,a1
    kfree(p);
    800000d2:	8a3a                	mv	s4,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000d4:	89be                	mv	s3,a5
    kfree(p);
    800000d6:	01448533          	add	a0,s1,s4
    800000da:	f43ff0ef          	jal	8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000de:	94ce                	add	s1,s1,s3
    800000e0:	fe997be3          	bgeu	s2,s1,800000d6 <freerange+0x2a>
    800000e4:	6942                	ld	s2,16(sp)
    800000e6:	69a2                	ld	s3,8(sp)
    800000e8:	6a02                	ld	s4,0(sp)
}
    800000ea:	70a2                	ld	ra,40(sp)
    800000ec:	7402                	ld	s0,32(sp)
    800000ee:	64e2                	ld	s1,24(sp)
    800000f0:	6145                	addi	sp,sp,48
    800000f2:	8082                	ret

00000000800000f4 <kinit>:
{
    800000f4:	7139                	addi	sp,sp,-64
    800000f6:	fc06                	sd	ra,56(sp)
    800000f8:	f822                	sd	s0,48(sp)
    800000fa:	f426                	sd	s1,40(sp)
    800000fc:	f04a                	sd	s2,32(sp)
    800000fe:	ec4e                	sd	s3,24(sp)
    80000100:	e852                	sd	s4,16(sp)
    80000102:	e456                	sd	s5,8(sp)
    80000104:	0080                	addi	s0,sp,64
  for(int i=0;i<NCPU;i++){
    80000106:	00009917          	auipc	s2,0x9
    8000010a:	c1a90913          	addi	s2,s2,-998 # 80008d20 <kmem>
    8000010e:	4481                	li	s1,0
    snprintf(kmem[i].name,8,"kmem%d", i);
    80000110:	00008a97          	auipc	s5,0x8
    80000114:	f00a8a93          	addi	s5,s5,-256 # 80008010 <etext+0x10>
    80000118:	4a21                	li	s4,8
    8000011a:	02890993          	addi	s3,s2,40
    8000011e:	86a6                	mv	a3,s1
    80000120:	8656                	mv	a2,s5
    80000122:	85d2                	mv	a1,s4
    80000124:	854e                	mv	a0,s3
    80000126:	78b040ef          	jal	800050b0 <snprintf>
    initlock(&kmem[i].lock, kmem[i].name);
    8000012a:	85ce                	mv	a1,s3
    8000012c:	854a                	mv	a0,s2
    8000012e:	641050ef          	jal	80005f6e <initlock>
  for(int i=0;i<NCPU;i++){
    80000132:	2485                	addiw	s1,s1,1
    80000134:	03090913          	addi	s2,s2,48
    80000138:	ff4491e3          	bne	s1,s4,8000011a <kinit+0x26>
  freerange(end, (void*)PHYSTOP);
    8000013c:	45c5                	li	a1,17
    8000013e:	05ee                	slli	a1,a1,0x1b
    80000140:	00025517          	auipc	a0,0x25
    80000144:	80050513          	addi	a0,a0,-2048 # 80024940 <end>
    80000148:	f65ff0ef          	jal	800000ac <freerange>
}
    8000014c:	70e2                	ld	ra,56(sp)
    8000014e:	7442                	ld	s0,48(sp)
    80000150:	74a2                	ld	s1,40(sp)
    80000152:	7902                	ld	s2,32(sp)
    80000154:	69e2                	ld	s3,24(sp)
    80000156:	6a42                	ld	s4,16(sp)
    80000158:	6aa2                	ld	s5,8(sp)
    8000015a:	6121                	addi	sp,sp,64
    8000015c:	8082                	ret

000000008000015e <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void 
*kalloc(void)
{
    8000015e:	7139                	addi	sp,sp,-64
    80000160:	fc06                	sd	ra,56(sp)
    80000162:	f822                	sd	s0,48(sp)
    80000164:	f426                	sd	s1,40(sp)
    80000166:	ec4e                	sd	s3,24(sp)
    80000168:	e852                	sd	s4,16(sp)
    8000016a:	0080                	addi	s0,sp,64
  struct run *r;

  push_off();
    8000016c:	3eb050ef          	jal	80005d56 <push_off>
  int cpu = cpuid();
    80000170:	491000ef          	jal	80000e00 <cpuid>
    80000174:	89aa                	mv	s3,a0

  //try to allocate from the current cpu's free list
  acquire(&kmem[cpu].lock);
    80000176:	00151793          	slli	a5,a0,0x1
    8000017a:	97aa                	add	a5,a5,a0
    8000017c:	0792                	slli	a5,a5,0x4
    8000017e:	00009497          	auipc	s1,0x9
    80000182:	ba248493          	addi	s1,s1,-1118 # 80008d20 <kmem>
    80000186:	94be                	add	s1,s1,a5
    80000188:	8526                	mv	a0,s1
    8000018a:	411050ef          	jal	80005d9a <acquire>
  r=kmem[cpu].freelist;
    8000018e:	0204ba03          	ld	s4,32(s1)
  if(r)
    80000192:	020a0763          	beqz	s4,800001c0 <kalloc+0x62>
    kmem[cpu].freelist=r->next;
    80000196:	000a3683          	ld	a3,0(s4)
    8000019a:	f094                	sd	a3,32(s1)
  release(&kmem[cpu].lock);
    8000019c:	8526                	mv	a0,s1
    8000019e:	539050ef          	jal	80005ed6 <release>
      }
      release(&kmem[i].lock);
    }
  }
  
  pop_off();
    800001a2:	4e5050ef          	jal	80005e86 <pop_off>
  if(r)
    memset((char*)r, 5, PGSIZE);
    800001a6:	6605                	lui	a2,0x1
    800001a8:	4595                	li	a1,5
    800001aa:	8552                	mv	a0,s4
    800001ac:	08a000ef          	jal	80000236 <memset>
  return (void*)r;
    800001b0:	8552                	mv	a0,s4
    800001b2:	70e2                	ld	ra,56(sp)
    800001b4:	7442                	ld	s0,48(sp)
    800001b6:	74a2                	ld	s1,40(sp)
    800001b8:	69e2                	ld	s3,24(sp)
    800001ba:	6a42                	ld	s4,16(sp)
    800001bc:	6121                	addi	sp,sp,64
    800001be:	8082                	ret
    800001c0:	f04a                	sd	s2,32(sp)
    800001c2:	e456                	sd	s5,8(sp)
    800001c4:	e05a                	sd	s6,0(sp)
  release(&kmem[cpu].lock);
    800001c6:	8526                	mv	a0,s1
    800001c8:	50f050ef          	jal	80005ed6 <release>
  if(!r){
    800001cc:	00009917          	auipc	s2,0x9
    800001d0:	b5490913          	addi	s2,s2,-1196 # 80008d20 <kmem>
    for(int i=0;i<NCPU;i++){
    800001d4:	4481                	li	s1,0
    800001d6:	4b21                	li	s6,8
    800001d8:	a825                	j	80000210 <kalloc+0xb2>
        kmem[i].freelist = r->next;
    800001da:	000ab683          	ld	a3,0(s5)
    800001de:	00149793          	slli	a5,s1,0x1
    800001e2:	97a6                	add	a5,a5,s1
    800001e4:	0792                	slli	a5,a5,0x4
    800001e6:	00009717          	auipc	a4,0x9
    800001ea:	b3a70713          	addi	a4,a4,-1222 # 80008d20 <kmem>
    800001ee:	97ba                	add	a5,a5,a4
    800001f0:	f394                	sd	a3,32(a5)
        release(&kmem[i].lock);
    800001f2:	854a                	mv	a0,s2
    800001f4:	4e3050ef          	jal	80005ed6 <release>
  pop_off();
    800001f8:	48f050ef          	jal	80005e86 <pop_off>
      r=kmem[i].freelist;
    800001fc:	8a56                	mv	s4,s5
    800001fe:	7902                	ld	s2,32(sp)
    80000200:	6aa2                	ld	s5,8(sp)
    80000202:	6b02                	ld	s6,0(sp)
    80000204:	b74d                	j	800001a6 <kalloc+0x48>
    for(int i=0;i<NCPU;i++){
    80000206:	2485                	addiw	s1,s1,1
    80000208:	03090913          	addi	s2,s2,48
    8000020c:	01648f63          	beq	s1,s6,8000022a <kalloc+0xcc>
      if(i==cpu) continue; 
    80000210:	fe998be3          	beq	s3,s1,80000206 <kalloc+0xa8>
      acquire(&kmem[i].lock);
    80000214:	854a                	mv	a0,s2
    80000216:	385050ef          	jal	80005d9a <acquire>
      r=kmem[i].freelist;
    8000021a:	02093a83          	ld	s5,32(s2)
      if(r) {
    8000021e:	fa0a9ee3          	bnez	s5,800001da <kalloc+0x7c>
      release(&kmem[i].lock);
    80000222:	854a                	mv	a0,s2
    80000224:	4b3050ef          	jal	80005ed6 <release>
    80000228:	bff9                	j	80000206 <kalloc+0xa8>
  pop_off();
    8000022a:	45d050ef          	jal	80005e86 <pop_off>
  if(r)
    8000022e:	7902                	ld	s2,32(sp)
    80000230:	6aa2                	ld	s5,8(sp)
    80000232:	6b02                	ld	s6,0(sp)
    80000234:	bfb5                	j	800001b0 <kalloc+0x52>

0000000080000236 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000236:	1141                	addi	sp,sp,-16
    80000238:	e406                	sd	ra,8(sp)
    8000023a:	e022                	sd	s0,0(sp)
    8000023c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    8000023e:	ca19                	beqz	a2,80000254 <memset+0x1e>
    80000240:	87aa                	mv	a5,a0
    80000242:	1602                	slli	a2,a2,0x20
    80000244:	9201                	srli	a2,a2,0x20
    80000246:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    8000024a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    8000024e:	0785                	addi	a5,a5,1
    80000250:	fee79de3          	bne	a5,a4,8000024a <memset+0x14>
  }
  return dst;
}
    80000254:	60a2                	ld	ra,8(sp)
    80000256:	6402                	ld	s0,0(sp)
    80000258:	0141                	addi	sp,sp,16
    8000025a:	8082                	ret

000000008000025c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8000025c:	1141                	addi	sp,sp,-16
    8000025e:	e406                	sd	ra,8(sp)
    80000260:	e022                	sd	s0,0(sp)
    80000262:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    80000264:	ce19                	beqz	a2,80000282 <memcmp+0x26>
    80000266:	1602                	slli	a2,a2,0x20
    80000268:	9201                	srli	a2,a2,0x20
    8000026a:	00c506b3          	add	a3,a0,a2
    if(*s1 != *s2)
    8000026e:	00054783          	lbu	a5,0(a0)
    80000272:	0005c703          	lbu	a4,0(a1)
    80000276:	00e79b63          	bne	a5,a4,8000028c <memcmp+0x30>
      return *s1 - *s2;
    s1++, s2++;
    8000027a:	0505                	addi	a0,a0,1
    8000027c:	0585                	addi	a1,a1,1
  while(n-- > 0){
    8000027e:	fed518e3          	bne	a0,a3,8000026e <memcmp+0x12>
  }

  return 0;
    80000282:	4501                	li	a0,0
}
    80000284:	60a2                	ld	ra,8(sp)
    80000286:	6402                	ld	s0,0(sp)
    80000288:	0141                	addi	sp,sp,16
    8000028a:	8082                	ret
      return *s1 - *s2;
    8000028c:	40e7853b          	subw	a0,a5,a4
    80000290:	bfd5                	j	80000284 <memcmp+0x28>

0000000080000292 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80000292:	1141                	addi	sp,sp,-16
    80000294:	e406                	sd	ra,8(sp)
    80000296:	e022                	sd	s0,0(sp)
    80000298:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    8000029a:	c61d                	beqz	a2,800002c8 <memmove+0x36>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    8000029c:	00a5f963          	bgeu	a1,a0,800002ae <memmove+0x1c>
    800002a0:	02061693          	slli	a3,a2,0x20
    800002a4:	9281                	srli	a3,a3,0x20
    800002a6:	00d58733          	add	a4,a1,a3
    800002aa:	02e56363          	bltu	a0,a4,800002d0 <memmove+0x3e>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800002ae:	1602                	slli	a2,a2,0x20
    800002b0:	9201                	srli	a2,a2,0x20
    800002b2:	00c587b3          	add	a5,a1,a2
{
    800002b6:	872a                	mv	a4,a0
      *d++ = *s++;
    800002b8:	0585                	addi	a1,a1,1
    800002ba:	0705                	addi	a4,a4,1
    800002bc:	fff5c683          	lbu	a3,-1(a1)
    800002c0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    800002c4:	fef59ae3          	bne	a1,a5,800002b8 <memmove+0x26>

  return dst;
}
    800002c8:	60a2                	ld	ra,8(sp)
    800002ca:	6402                	ld	s0,0(sp)
    800002cc:	0141                	addi	sp,sp,16
    800002ce:	8082                	ret
    d += n;
    800002d0:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    800002d2:	fff6079b          	addiw	a5,a2,-1 # fff <_entry-0x7ffff001>
    800002d6:	1782                	slli	a5,a5,0x20
    800002d8:	9381                	srli	a5,a5,0x20
    800002da:	fff7c793          	not	a5,a5
    800002de:	97ba                	add	a5,a5,a4
      *--d = *--s;
    800002e0:	177d                	addi	a4,a4,-1
    800002e2:	16fd                	addi	a3,a3,-1
    800002e4:	00074603          	lbu	a2,0(a4)
    800002e8:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    800002ec:	fee79ae3          	bne	a5,a4,800002e0 <memmove+0x4e>
    800002f0:	bfe1                	j	800002c8 <memmove+0x36>

00000000800002f2 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    800002f2:	1141                	addi	sp,sp,-16
    800002f4:	e406                	sd	ra,8(sp)
    800002f6:	e022                	sd	s0,0(sp)
    800002f8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    800002fa:	f99ff0ef          	jal	80000292 <memmove>
}
    800002fe:	60a2                	ld	ra,8(sp)
    80000300:	6402                	ld	s0,0(sp)
    80000302:	0141                	addi	sp,sp,16
    80000304:	8082                	ret

0000000080000306 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000306:	1141                	addi	sp,sp,-16
    80000308:	e406                	sd	ra,8(sp)
    8000030a:	e022                	sd	s0,0(sp)
    8000030c:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    8000030e:	ce01                	beqz	a2,80000326 <strncmp+0x20>
    80000310:	00054783          	lbu	a5,0(a0)
    80000314:	cb99                	beqz	a5,8000032a <strncmp+0x24>
    80000316:	0005c703          	lbu	a4,0(a1)
    8000031a:	00f71863          	bne	a4,a5,8000032a <strncmp+0x24>
    n--, p++, q++;
    8000031e:	367d                	addiw	a2,a2,-1
    80000320:	0505                	addi	a0,a0,1
    80000322:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000324:	f675                	bnez	a2,80000310 <strncmp+0xa>
  if(n == 0)
    return 0;
    80000326:	4501                	li	a0,0
    80000328:	a031                	j	80000334 <strncmp+0x2e>
  return (uchar)*p - (uchar)*q;
    8000032a:	00054503          	lbu	a0,0(a0)
    8000032e:	0005c783          	lbu	a5,0(a1)
    80000332:	9d1d                	subw	a0,a0,a5
}
    80000334:	60a2                	ld	ra,8(sp)
    80000336:	6402                	ld	s0,0(sp)
    80000338:	0141                	addi	sp,sp,16
    8000033a:	8082                	ret

000000008000033c <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    8000033c:	1141                	addi	sp,sp,-16
    8000033e:	e406                	sd	ra,8(sp)
    80000340:	e022                	sd	s0,0(sp)
    80000342:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000344:	87aa                	mv	a5,a0
    80000346:	a011                	j	8000034a <strncpy+0xe>
    80000348:	8636                	mv	a2,a3
    8000034a:	02c05763          	blez	a2,80000378 <strncpy+0x3c>
    8000034e:	fff6069b          	addiw	a3,a2,-1
    80000352:	0785                	addi	a5,a5,1
    80000354:	0005c703          	lbu	a4,0(a1)
    80000358:	fee78fa3          	sb	a4,-1(a5)
    8000035c:	0585                	addi	a1,a1,1
    8000035e:	f76d                	bnez	a4,80000348 <strncpy+0xc>
    ;
  while(n-- > 0)
    80000360:	873e                	mv	a4,a5
    80000362:	00d05b63          	blez	a3,80000378 <strncpy+0x3c>
    80000366:	9fb1                	addw	a5,a5,a2
    80000368:	37fd                	addiw	a5,a5,-1
    *s++ = 0;
    8000036a:	0705                	addi	a4,a4,1
    8000036c:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    80000370:	40e786bb          	subw	a3,a5,a4
    80000374:	fed04be3          	bgtz	a3,8000036a <strncpy+0x2e>
  return os;
}
    80000378:	60a2                	ld	ra,8(sp)
    8000037a:	6402                	ld	s0,0(sp)
    8000037c:	0141                	addi	sp,sp,16
    8000037e:	8082                	ret

0000000080000380 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80000380:	1141                	addi	sp,sp,-16
    80000382:	e406                	sd	ra,8(sp)
    80000384:	e022                	sd	s0,0(sp)
    80000386:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    80000388:	02c05363          	blez	a2,800003ae <safestrcpy+0x2e>
    8000038c:	fff6069b          	addiw	a3,a2,-1
    80000390:	1682                	slli	a3,a3,0x20
    80000392:	9281                	srli	a3,a3,0x20
    80000394:	96ae                	add	a3,a3,a1
    80000396:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    80000398:	00d58963          	beq	a1,a3,800003aa <safestrcpy+0x2a>
    8000039c:	0585                	addi	a1,a1,1
    8000039e:	0785                	addi	a5,a5,1
    800003a0:	fff5c703          	lbu	a4,-1(a1)
    800003a4:	fee78fa3          	sb	a4,-1(a5)
    800003a8:	fb65                	bnez	a4,80000398 <safestrcpy+0x18>
    ;
  *s = 0;
    800003aa:	00078023          	sb	zero,0(a5)
  return os;
}
    800003ae:	60a2                	ld	ra,8(sp)
    800003b0:	6402                	ld	s0,0(sp)
    800003b2:	0141                	addi	sp,sp,16
    800003b4:	8082                	ret

00000000800003b6 <strlen>:

int
strlen(const char *s)
{
    800003b6:	1141                	addi	sp,sp,-16
    800003b8:	e406                	sd	ra,8(sp)
    800003ba:	e022                	sd	s0,0(sp)
    800003bc:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    800003be:	00054783          	lbu	a5,0(a0)
    800003c2:	cf91                	beqz	a5,800003de <strlen+0x28>
    800003c4:	00150793          	addi	a5,a0,1
    800003c8:	86be                	mv	a3,a5
    800003ca:	0785                	addi	a5,a5,1
    800003cc:	fff7c703          	lbu	a4,-1(a5)
    800003d0:	ff65                	bnez	a4,800003c8 <strlen+0x12>
    800003d2:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
    800003d6:	60a2                	ld	ra,8(sp)
    800003d8:	6402                	ld	s0,0(sp)
    800003da:	0141                	addi	sp,sp,16
    800003dc:	8082                	ret
  for(n = 0; s[n]; n++)
    800003de:	4501                	li	a0,0
    800003e0:	bfdd                	j	800003d6 <strlen+0x20>

00000000800003e2 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    800003e2:	1101                	addi	sp,sp,-32
    800003e4:	ec06                	sd	ra,24(sp)
    800003e6:	e822                	sd	s0,16(sp)
    800003e8:	e426                	sd	s1,8(sp)
    800003ea:	1000                	addi	s0,sp,32
  if(cpuid() == 0){
    800003ec:	215000ef          	jal	80000e00 <cpuid>
    kcsaninit();
#endif
    __sync_synchronize();
    started = 1;
  } else {
    while(atomic_read4((int *) &started) == 0)
    800003f0:	00009497          	auipc	s1,0x9
    800003f4:	8e048493          	addi	s1,s1,-1824 # 80008cd0 <started>
  if(cpuid() == 0){
    800003f8:	c905                	beqz	a0,80000428 <main+0x46>
    while(atomic_read4((int *) &started) == 0)
    800003fa:	8526                	mv	a0,s1
    800003fc:	112060ef          	jal	8000650e <atomic_read4>
    80000400:	dd6d                	beqz	a0,800003fa <main+0x18>
      ;
    __sync_synchronize();
    80000402:	0330000f          	fence	rw,rw
    printf("hart %d starting\n", cpuid());
    80000406:	1fb000ef          	jal	80000e00 <cpuid>
    8000040a:	85aa                	mv	a1,a0
    8000040c:	00008517          	auipc	a0,0x8
    80000410:	c2c50513          	addi	a0,a0,-980 # 80008038 <etext+0x38>
    80000414:	312050ef          	jal	80005726 <printf>
    kvminithart();    // turn on paging
    80000418:	084000ef          	jal	8000049c <kvminithart>
    trapinithart();   // install kernel trap vector
    8000041c:	568010ef          	jal	80001984 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000420:	548040ef          	jal	80004968 <plicinithart>
  }

  scheduler();        
    80000424:	671000ef          	jal	80001294 <scheduler>
    consoleinit();
    80000428:	226050ef          	jal	8000564e <consoleinit>
    statsinit();
    8000042c:	3ab040ef          	jal	80004fd6 <statsinit>
    printfinit();
    80000430:	66a050ef          	jal	80005a9a <printfinit>
    printf("\n");
    80000434:	00008517          	auipc	a0,0x8
    80000438:	be450513          	addi	a0,a0,-1052 # 80008018 <etext+0x18>
    8000043c:	2ea050ef          	jal	80005726 <printf>
    printf("xv6 kernel is booting\n");
    80000440:	00008517          	auipc	a0,0x8
    80000444:	be050513          	addi	a0,a0,-1056 # 80008020 <etext+0x20>
    80000448:	2de050ef          	jal	80005726 <printf>
    printf("\n");
    8000044c:	00008517          	auipc	a0,0x8
    80000450:	bcc50513          	addi	a0,a0,-1076 # 80008018 <etext+0x18>
    80000454:	2d2050ef          	jal	80005726 <printf>
    kinit();         // physical page allocator
    80000458:	c9dff0ef          	jal	800000f4 <kinit>
    kvminit();       // create kernel page table
    8000045c:	2c0000ef          	jal	8000071c <kvminit>
    kvminithart();   // turn on paging
    80000460:	03c000ef          	jal	8000049c <kvminithart>
    procinit();      // process table
    80000464:	0eb000ef          	jal	80000d4e <procinit>
    trapinit();      // trap vectors
    80000468:	4f8010ef          	jal	80001960 <trapinit>
    trapinithart();  // install kernel trap vector
    8000046c:	518010ef          	jal	80001984 <trapinithart>
    plicinit();      // set up interrupt controller
    80000470:	4de040ef          	jal	8000494e <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000474:	4f4040ef          	jal	80004968 <plicinithart>
    binit();         // buffer cache
    80000478:	3e1010ef          	jal	80002058 <binit>
    iinit();         // inode table
    8000047c:	13a020ef          	jal	800025b6 <iinit>
    fileinit();      // file table
    80000480:	078030ef          	jal	800034f8 <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000484:	5d4040ef          	jal	80004a58 <virtio_disk_init>
    userinit();      // first user process
    80000488:	479000ef          	jal	80001100 <userinit>
    __sync_synchronize();
    8000048c:	0330000f          	fence	rw,rw
    started = 1;
    80000490:	4785                	li	a5,1
    80000492:	00009717          	auipc	a4,0x9
    80000496:	82f72f23          	sw	a5,-1986(a4) # 80008cd0 <started>
    8000049a:	b769                	j	80000424 <main+0x42>

000000008000049c <kvminithart>:

// Switch the current CPU's h/w page table register to
// the kernel's page table, and enable paging.
void
kvminithart()
{
    8000049c:	1141                	addi	sp,sp,-16
    8000049e:	e406                	sd	ra,8(sp)
    800004a0:	e022                	sd	s0,0(sp)
    800004a2:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    800004a4:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    800004a8:	00009797          	auipc	a5,0x9
    800004ac:	8307b783          	ld	a5,-2000(a5) # 80008cd8 <kernel_pagetable>
    800004b0:	83b1                	srli	a5,a5,0xc
    800004b2:	577d                	li	a4,-1
    800004b4:	177e                	slli	a4,a4,0x3f
    800004b6:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    800004b8:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    800004bc:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    800004c0:	60a2                	ld	ra,8(sp)
    800004c2:	6402                	ld	s0,0(sp)
    800004c4:	0141                	addi	sp,sp,16
    800004c6:	8082                	ret

00000000800004c8 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    800004c8:	7139                	addi	sp,sp,-64
    800004ca:	fc06                	sd	ra,56(sp)
    800004cc:	f822                	sd	s0,48(sp)
    800004ce:	f426                	sd	s1,40(sp)
    800004d0:	f04a                	sd	s2,32(sp)
    800004d2:	ec4e                	sd	s3,24(sp)
    800004d4:	e852                	sd	s4,16(sp)
    800004d6:	e456                	sd	s5,8(sp)
    800004d8:	e05a                	sd	s6,0(sp)
    800004da:	0080                	addi	s0,sp,64
    800004dc:	84aa                	mv	s1,a0
    800004de:	89ae                	mv	s3,a1
    800004e0:	8b32                	mv	s6,a2
  if(va >= MAXVA)
    800004e2:	57fd                	li	a5,-1
    800004e4:	83e9                	srli	a5,a5,0x1a
    800004e6:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    800004e8:	4ab1                	li	s5,12
  if(va >= MAXVA)
    800004ea:	06b7e363          	bltu	a5,a1,80000550 <walk+0x88>
    pte_t *pte = &pagetable[PX(level, va)];
    800004ee:	0149d933          	srl	s2,s3,s4
    800004f2:	1ff97913          	andi	s2,s2,511
    800004f6:	090e                	slli	s2,s2,0x3
    800004f8:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800004fa:	00093483          	ld	s1,0(s2)
    800004fe:	0014f793          	andi	a5,s1,1
      pagetable = (pagetable_t)PTE2PA(*pte);
    80000502:	80a9                	srli	s1,s1,0xa
    80000504:	04b2                	slli	s1,s1,0xc
    if(*pte & PTE_V) {
    80000506:	e395                	bnez	a5,8000052a <walk+0x62>
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80000508:	040b0a63          	beqz	s6,8000055c <walk+0x94>
    8000050c:	c53ff0ef          	jal	8000015e <kalloc>
    80000510:	84aa                	mv	s1,a0
    80000512:	c50d                	beqz	a0,8000053c <walk+0x74>
        return 0;
      memset(pagetable, 0, PGSIZE);
    80000514:	6605                	lui	a2,0x1
    80000516:	4581                	li	a1,0
    80000518:	d1fff0ef          	jal	80000236 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    8000051c:	00c4d793          	srli	a5,s1,0xc
    80000520:	07aa                	slli	a5,a5,0xa
    80000522:	0017e793          	ori	a5,a5,1
    80000526:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    8000052a:	3a5d                	addiw	s4,s4,-9
    8000052c:	fd5a11e3          	bne	s4,s5,800004ee <walk+0x26>
    }
  }
  return &pagetable[PX(0, va)];
    80000530:	00c9d513          	srli	a0,s3,0xc
    80000534:	1ff57513          	andi	a0,a0,511
    80000538:	050e                	slli	a0,a0,0x3
    8000053a:	9526                	add	a0,a0,s1
}
    8000053c:	70e2                	ld	ra,56(sp)
    8000053e:	7442                	ld	s0,48(sp)
    80000540:	74a2                	ld	s1,40(sp)
    80000542:	7902                	ld	s2,32(sp)
    80000544:	69e2                	ld	s3,24(sp)
    80000546:	6a42                	ld	s4,16(sp)
    80000548:	6aa2                	ld	s5,8(sp)
    8000054a:	6b02                	ld	s6,0(sp)
    8000054c:	6121                	addi	sp,sp,64
    8000054e:	8082                	ret
    panic("walk");
    80000550:	00008517          	auipc	a0,0x8
    80000554:	b0050513          	addi	a0,a0,-1280 # 80008050 <etext+0x50>
    80000558:	506050ef          	jal	80005a5e <panic>
        return 0;
    8000055c:	4501                	li	a0,0
    8000055e:	bff9                	j	8000053c <walk+0x74>

0000000080000560 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80000560:	57fd                	li	a5,-1
    80000562:	83e9                	srli	a5,a5,0x1a
    80000564:	00b7f463          	bgeu	a5,a1,8000056c <walkaddr+0xc>
    return 0;
    80000568:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    8000056a:	8082                	ret
{
    8000056c:	1141                	addi	sp,sp,-16
    8000056e:	e406                	sd	ra,8(sp)
    80000570:	e022                	sd	s0,0(sp)
    80000572:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80000574:	4601                	li	a2,0
    80000576:	f53ff0ef          	jal	800004c8 <walk>
  if(pte == 0)
    8000057a:	c519                	beqz	a0,80000588 <walkaddr+0x28>
  if((*pte & PTE_V) == 0)
    8000057c:	6108                	ld	a0,0(a0)
  if((*pte & PTE_U) == 0)
    8000057e:	01157713          	andi	a4,a0,17
    80000582:	47c5                	li	a5,17
    80000584:	00f70763          	beq	a4,a5,80000592 <walkaddr+0x32>
    return 0;
    80000588:	4501                	li	a0,0
}
    8000058a:	60a2                	ld	ra,8(sp)
    8000058c:	6402                	ld	s0,0(sp)
    8000058e:	0141                	addi	sp,sp,16
    80000590:	8082                	ret
  pa = PTE2PA(*pte);
    80000592:	8129                	srli	a0,a0,0xa
    80000594:	0532                	slli	a0,a0,0xc
  return pa;
    80000596:	bfd5                	j	8000058a <walkaddr+0x2a>

0000000080000598 <mappages>:
// va and size MUST be page-aligned.
// Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80000598:	715d                	addi	sp,sp,-80
    8000059a:	e486                	sd	ra,72(sp)
    8000059c:	e0a2                	sd	s0,64(sp)
    8000059e:	fc26                	sd	s1,56(sp)
    800005a0:	f84a                	sd	s2,48(sp)
    800005a2:	f44e                	sd	s3,40(sp)
    800005a4:	f052                	sd	s4,32(sp)
    800005a6:	ec56                	sd	s5,24(sp)
    800005a8:	e85a                	sd	s6,16(sp)
    800005aa:	e45e                	sd	s7,8(sp)
    800005ac:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    800005ae:	03459793          	slli	a5,a1,0x34
    800005b2:	e7b1                	bnez	a5,800005fe <mappages+0x66>
    800005b4:	8a2a                	mv	s4,a0
    800005b6:	8aba                	mv	s5,a4
    panic("mappages: va not aligned");

  if((size % PGSIZE) != 0)
    800005b8:	03461793          	slli	a5,a2,0x34
    800005bc:	e7b9                	bnez	a5,8000060a <mappages+0x72>
    panic("mappages: size not aligned");

  if(size == 0)
    800005be:	ce21                	beqz	a2,80000616 <mappages+0x7e>
    panic("mappages: size");
  
  a = va;
  last = va + size - PGSIZE;
    800005c0:	77fd                	lui	a5,0xfffff
    800005c2:	963e                	add	a2,a2,a5
    800005c4:	00b60933          	add	s2,a2,a1
  a = va;
    800005c8:	84ae                	mv	s1,a1
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    800005ca:	4b05                	li	s6,1
    800005cc:	40b689b3          	sub	s3,a3,a1
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    800005d0:	6b85                	lui	s7,0x1
    if((pte = walk(pagetable, a, 1)) == 0)
    800005d2:	865a                	mv	a2,s6
    800005d4:	85a6                	mv	a1,s1
    800005d6:	8552                	mv	a0,s4
    800005d8:	ef1ff0ef          	jal	800004c8 <walk>
    800005dc:	c929                	beqz	a0,8000062e <mappages+0x96>
    if(*pte & PTE_V)
    800005de:	611c                	ld	a5,0(a0)
    800005e0:	8b85                	andi	a5,a5,1
    800005e2:	e3a1                	bnez	a5,80000622 <mappages+0x8a>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800005e4:	013487b3          	add	a5,s1,s3
    800005e8:	83b1                	srli	a5,a5,0xc
    800005ea:	07aa                	slli	a5,a5,0xa
    800005ec:	0157e7b3          	or	a5,a5,s5
    800005f0:	0017e793          	ori	a5,a5,1
    800005f4:	e11c                	sd	a5,0(a0)
    if(a == last)
    800005f6:	05248863          	beq	s1,s2,80000646 <mappages+0xae>
    a += PGSIZE;
    800005fa:	94de                	add	s1,s1,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    800005fc:	bfd9                	j	800005d2 <mappages+0x3a>
    panic("mappages: va not aligned");
    800005fe:	00008517          	auipc	a0,0x8
    80000602:	a5a50513          	addi	a0,a0,-1446 # 80008058 <etext+0x58>
    80000606:	458050ef          	jal	80005a5e <panic>
    panic("mappages: size not aligned");
    8000060a:	00008517          	auipc	a0,0x8
    8000060e:	a6e50513          	addi	a0,a0,-1426 # 80008078 <etext+0x78>
    80000612:	44c050ef          	jal	80005a5e <panic>
    panic("mappages: size");
    80000616:	00008517          	auipc	a0,0x8
    8000061a:	a8250513          	addi	a0,a0,-1406 # 80008098 <etext+0x98>
    8000061e:	440050ef          	jal	80005a5e <panic>
      panic("mappages: remap");
    80000622:	00008517          	auipc	a0,0x8
    80000626:	a8650513          	addi	a0,a0,-1402 # 800080a8 <etext+0xa8>
    8000062a:	434050ef          	jal	80005a5e <panic>
      return -1;
    8000062e:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    80000630:	60a6                	ld	ra,72(sp)
    80000632:	6406                	ld	s0,64(sp)
    80000634:	74e2                	ld	s1,56(sp)
    80000636:	7942                	ld	s2,48(sp)
    80000638:	79a2                	ld	s3,40(sp)
    8000063a:	7a02                	ld	s4,32(sp)
    8000063c:	6ae2                	ld	s5,24(sp)
    8000063e:	6b42                	ld	s6,16(sp)
    80000640:	6ba2                	ld	s7,8(sp)
    80000642:	6161                	addi	sp,sp,80
    80000644:	8082                	ret
  return 0;
    80000646:	4501                	li	a0,0
    80000648:	b7e5                	j	80000630 <mappages+0x98>

000000008000064a <kvmmap>:
{
    8000064a:	1141                	addi	sp,sp,-16
    8000064c:	e406                	sd	ra,8(sp)
    8000064e:	e022                	sd	s0,0(sp)
    80000650:	0800                	addi	s0,sp,16
    80000652:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80000654:	86b2                	mv	a3,a2
    80000656:	863e                	mv	a2,a5
    80000658:	f41ff0ef          	jal	80000598 <mappages>
    8000065c:	e509                	bnez	a0,80000666 <kvmmap+0x1c>
}
    8000065e:	60a2                	ld	ra,8(sp)
    80000660:	6402                	ld	s0,0(sp)
    80000662:	0141                	addi	sp,sp,16
    80000664:	8082                	ret
    panic("kvmmap");
    80000666:	00008517          	auipc	a0,0x8
    8000066a:	a5250513          	addi	a0,a0,-1454 # 800080b8 <etext+0xb8>
    8000066e:	3f0050ef          	jal	80005a5e <panic>

0000000080000672 <kvmmake>:
{
    80000672:	1101                	addi	sp,sp,-32
    80000674:	ec06                	sd	ra,24(sp)
    80000676:	e822                	sd	s0,16(sp)
    80000678:	e426                	sd	s1,8(sp)
    8000067a:	e04a                	sd	s2,0(sp)
    8000067c:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    8000067e:	ae1ff0ef          	jal	8000015e <kalloc>
    80000682:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    80000684:	6605                	lui	a2,0x1
    80000686:	4581                	li	a1,0
    80000688:	bafff0ef          	jal	80000236 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    8000068c:	4719                	li	a4,6
    8000068e:	6685                	lui	a3,0x1
    80000690:	10000637          	lui	a2,0x10000
    80000694:	85b2                	mv	a1,a2
    80000696:	8526                	mv	a0,s1
    80000698:	fb3ff0ef          	jal	8000064a <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    8000069c:	4719                	li	a4,6
    8000069e:	6685                	lui	a3,0x1
    800006a0:	10001637          	lui	a2,0x10001
    800006a4:	85b2                	mv	a1,a2
    800006a6:	8526                	mv	a0,s1
    800006a8:	fa3ff0ef          	jal	8000064a <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x4000000, PTE_R | PTE_W);
    800006ac:	4719                	li	a4,6
    800006ae:	040006b7          	lui	a3,0x4000
    800006b2:	0c000637          	lui	a2,0xc000
    800006b6:	85b2                	mv	a1,a2
    800006b8:	8526                	mv	a0,s1
    800006ba:	f91ff0ef          	jal	8000064a <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800006be:	00008917          	auipc	s2,0x8
    800006c2:	94290913          	addi	s2,s2,-1726 # 80008000 <etext>
    800006c6:	4729                	li	a4,10
    800006c8:	800006b7          	lui	a3,0x80000
    800006cc:	96ca                	add	a3,a3,s2
    800006ce:	4605                	li	a2,1
    800006d0:	067e                	slli	a2,a2,0x1f
    800006d2:	85b2                	mv	a1,a2
    800006d4:	8526                	mv	a0,s1
    800006d6:	f75ff0ef          	jal	8000064a <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800006da:	4719                	li	a4,6
    800006dc:	46c5                	li	a3,17
    800006de:	06ee                	slli	a3,a3,0x1b
    800006e0:	412686b3          	sub	a3,a3,s2
    800006e4:	864a                	mv	a2,s2
    800006e6:	85ca                	mv	a1,s2
    800006e8:	8526                	mv	a0,s1
    800006ea:	f61ff0ef          	jal	8000064a <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800006ee:	4729                	li	a4,10
    800006f0:	6685                	lui	a3,0x1
    800006f2:	00007617          	auipc	a2,0x7
    800006f6:	90e60613          	addi	a2,a2,-1778 # 80007000 <_trampoline>
    800006fa:	040005b7          	lui	a1,0x4000
    800006fe:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000700:	05b2                	slli	a1,a1,0xc
    80000702:	8526                	mv	a0,s1
    80000704:	f47ff0ef          	jal	8000064a <kvmmap>
  proc_mapstacks(kpgtbl);
    80000708:	8526                	mv	a0,s1
    8000070a:	5b6000ef          	jal	80000cc0 <proc_mapstacks>
}
    8000070e:	8526                	mv	a0,s1
    80000710:	60e2                	ld	ra,24(sp)
    80000712:	6442                	ld	s0,16(sp)
    80000714:	64a2                	ld	s1,8(sp)
    80000716:	6902                	ld	s2,0(sp)
    80000718:	6105                	addi	sp,sp,32
    8000071a:	8082                	ret

000000008000071c <kvminit>:
{
    8000071c:	1141                	addi	sp,sp,-16
    8000071e:	e406                	sd	ra,8(sp)
    80000720:	e022                	sd	s0,0(sp)
    80000722:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80000724:	f4fff0ef          	jal	80000672 <kvmmake>
    80000728:	00008797          	auipc	a5,0x8
    8000072c:	5aa7b823          	sd	a0,1456(a5) # 80008cd8 <kernel_pagetable>
}
    80000730:	60a2                	ld	ra,8(sp)
    80000732:	6402                	ld	s0,0(sp)
    80000734:	0141                	addi	sp,sp,16
    80000736:	8082                	ret

0000000080000738 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80000738:	1101                	addi	sp,sp,-32
    8000073a:	ec06                	sd	ra,24(sp)
    8000073c:	e822                	sd	s0,16(sp)
    8000073e:	e426                	sd	s1,8(sp)
    80000740:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80000742:	a1dff0ef          	jal	8000015e <kalloc>
    80000746:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000748:	c509                	beqz	a0,80000752 <uvmcreate+0x1a>
    return 0;
  memset(pagetable, 0, PGSIZE);
    8000074a:	6605                	lui	a2,0x1
    8000074c:	4581                	li	a1,0
    8000074e:	ae9ff0ef          	jal	80000236 <memset>
  return pagetable;
}
    80000752:	8526                	mv	a0,s1
    80000754:	60e2                	ld	ra,24(sp)
    80000756:	6442                	ld	s0,16(sp)
    80000758:	64a2                	ld	s1,8(sp)
    8000075a:	6105                	addi	sp,sp,32
    8000075c:	8082                	ret

000000008000075e <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. It's OK if the mappings don't exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    8000075e:	7139                	addi	sp,sp,-64
    80000760:	fc06                	sd	ra,56(sp)
    80000762:	f822                	sd	s0,48(sp)
    80000764:	0080                	addi	s0,sp,64
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000766:	03459793          	slli	a5,a1,0x34
    8000076a:	e38d                	bnez	a5,8000078c <uvmunmap+0x2e>
    8000076c:	f04a                	sd	s2,32(sp)
    8000076e:	ec4e                	sd	s3,24(sp)
    80000770:	e852                	sd	s4,16(sp)
    80000772:	e456                	sd	s5,8(sp)
    80000774:	e05a                	sd	s6,0(sp)
    80000776:	8a2a                	mv	s4,a0
    80000778:	892e                	mv	s2,a1
    8000077a:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000077c:	0632                	slli	a2,a2,0xc
    8000077e:	00b609b3          	add	s3,a2,a1
    80000782:	6b05                	lui	s6,0x1
    80000784:	0535f963          	bgeu	a1,s3,800007d6 <uvmunmap+0x78>
    80000788:	f426                	sd	s1,40(sp)
    8000078a:	a015                	j	800007ae <uvmunmap+0x50>
    8000078c:	f426                	sd	s1,40(sp)
    8000078e:	f04a                	sd	s2,32(sp)
    80000790:	ec4e                	sd	s3,24(sp)
    80000792:	e852                	sd	s4,16(sp)
    80000794:	e456                	sd	s5,8(sp)
    80000796:	e05a                	sd	s6,0(sp)
    panic("uvmunmap: not aligned");
    80000798:	00008517          	auipc	a0,0x8
    8000079c:	92850513          	addi	a0,a0,-1752 # 800080c0 <etext+0xc0>
    800007a0:	2be050ef          	jal	80005a5e <panic>
      continue;
    if(do_free){
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
    800007a4:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800007a8:	995a                	add	s2,s2,s6
    800007aa:	03397563          	bgeu	s2,s3,800007d4 <uvmunmap+0x76>
    if((pte = walk(pagetable, a, 0)) == 0) // leaf page table entry allocated?
    800007ae:	4601                	li	a2,0
    800007b0:	85ca                	mv	a1,s2
    800007b2:	8552                	mv	a0,s4
    800007b4:	d15ff0ef          	jal	800004c8 <walk>
    800007b8:	84aa                	mv	s1,a0
    800007ba:	d57d                	beqz	a0,800007a8 <uvmunmap+0x4a>
    if((*pte & PTE_V) == 0)  // has physical page been allocated?
    800007bc:	611c                	ld	a5,0(a0)
    800007be:	0017f713          	andi	a4,a5,1
    800007c2:	d37d                	beqz	a4,800007a8 <uvmunmap+0x4a>
    if(do_free){
    800007c4:	fe0a80e3          	beqz	s5,800007a4 <uvmunmap+0x46>
      uint64 pa = PTE2PA(*pte);
    800007c8:	83a9                	srli	a5,a5,0xa
      kfree((void*)pa);
    800007ca:	00c79513          	slli	a0,a5,0xc
    800007ce:	84fff0ef          	jal	8000001c <kfree>
    800007d2:	bfc9                	j	800007a4 <uvmunmap+0x46>
    800007d4:	74a2                	ld	s1,40(sp)
    800007d6:	7902                	ld	s2,32(sp)
    800007d8:	69e2                	ld	s3,24(sp)
    800007da:	6a42                	ld	s4,16(sp)
    800007dc:	6aa2                	ld	s5,8(sp)
    800007de:	6b02                	ld	s6,0(sp)
  }
}
    800007e0:	70e2                	ld	ra,56(sp)
    800007e2:	7442                	ld	s0,48(sp)
    800007e4:	6121                	addi	sp,sp,64
    800007e6:	8082                	ret

00000000800007e8 <uvmdealloc>:
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
  if(newsz >= oldsz)
    800007e8:	04b67163          	bgeu	a2,a1,8000082a <uvmdealloc+0x42>
{
    800007ec:	1101                	addi	sp,sp,-32
    800007ee:	ec06                	sd	ra,24(sp)
    800007f0:	e822                	sd	s0,16(sp)
    800007f2:	e426                	sd	s1,8(sp)
    800007f4:	1000                	addi	s0,sp,32
    800007f6:	84b2                	mv	s1,a2
    return oldsz;

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800007f8:	6785                	lui	a5,0x1
    800007fa:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800007fc:	00f60733          	add	a4,a2,a5
    80000800:	76fd                	lui	a3,0xfffff
    80000802:	8f75                	and	a4,a4,a3
    80000804:	97ae                	add	a5,a5,a1
    80000806:	8ff5                	and	a5,a5,a3
    80000808:	00f76863          	bltu	a4,a5,80000818 <uvmdealloc+0x30>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
    8000080c:	8526                	mv	a0,s1
}
    8000080e:	60e2                	ld	ra,24(sp)
    80000810:	6442                	ld	s0,16(sp)
    80000812:	64a2                	ld	s1,8(sp)
    80000814:	6105                	addi	sp,sp,32
    80000816:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80000818:	8f99                	sub	a5,a5,a4
    8000081a:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    8000081c:	4685                	li	a3,1
    8000081e:	0007861b          	sext.w	a2,a5
    80000822:	85ba                	mv	a1,a4
    80000824:	f3bff0ef          	jal	8000075e <uvmunmap>
    80000828:	b7d5                	j	8000080c <uvmdealloc+0x24>
    return oldsz;
    8000082a:	852e                	mv	a0,a1
}
    8000082c:	8082                	ret

000000008000082e <uvmalloc>:
  if(newsz < oldsz)
    8000082e:	08b66e63          	bltu	a2,a1,800008ca <uvmalloc+0x9c>
{
    80000832:	715d                	addi	sp,sp,-80
    80000834:	e486                	sd	ra,72(sp)
    80000836:	e0a2                	sd	s0,64(sp)
    80000838:	f052                	sd	s4,32(sp)
    8000083a:	ec56                	sd	s5,24(sp)
    8000083c:	e45e                	sd	s7,8(sp)
    8000083e:	0880                	addi	s0,sp,80
    80000840:	8aaa                	mv	s5,a0
    80000842:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    80000844:	6785                	lui	a5,0x1
    80000846:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000848:	95be                	add	a1,a1,a5
    8000084a:	77fd                	lui	a5,0xfffff
    8000084c:	8fed                	and	a5,a5,a1
    8000084e:	8bbe                	mv	s7,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000850:	04c7f163          	bgeu	a5,a2,80000892 <uvmalloc+0x64>
    80000854:	fc26                	sd	s1,56(sp)
    80000856:	f84a                	sd	s2,48(sp)
    80000858:	f44e                	sd	s3,40(sp)
    8000085a:	e85a                	sd	s6,16(sp)
    8000085c:	893e                	mv	s2,a5
    memset(mem, 0, PGSIZE);
    8000085e:	6985                	lui	s3,0x1
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000860:	0126eb13          	ori	s6,a3,18
    mem = kalloc();
    80000864:	8fbff0ef          	jal	8000015e <kalloc>
    80000868:	84aa                	mv	s1,a0
    if(mem == 0){
    8000086a:	c515                	beqz	a0,80000896 <uvmalloc+0x68>
    memset(mem, 0, PGSIZE);
    8000086c:	864e                	mv	a2,s3
    8000086e:	4581                	li	a1,0
    80000870:	9c7ff0ef          	jal	80000236 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000874:	875a                	mv	a4,s6
    80000876:	86a6                	mv	a3,s1
    80000878:	864e                	mv	a2,s3
    8000087a:	85ca                	mv	a1,s2
    8000087c:	8556                	mv	a0,s5
    8000087e:	d1bff0ef          	jal	80000598 <mappages>
    80000882:	e91d                	bnez	a0,800008b8 <uvmalloc+0x8a>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000884:	994e                	add	s2,s2,s3
    80000886:	fd496fe3          	bltu	s2,s4,80000864 <uvmalloc+0x36>
    8000088a:	74e2                	ld	s1,56(sp)
    8000088c:	7942                	ld	s2,48(sp)
    8000088e:	79a2                	ld	s3,40(sp)
    80000890:	6b42                	ld	s6,16(sp)
  return newsz;
    80000892:	8552                	mv	a0,s4
    80000894:	a819                	j	800008aa <uvmalloc+0x7c>
      uvmdealloc(pagetable, a, oldsz);
    80000896:	865e                	mv	a2,s7
    80000898:	85ca                	mv	a1,s2
    8000089a:	8556                	mv	a0,s5
    8000089c:	f4dff0ef          	jal	800007e8 <uvmdealloc>
      return 0;
    800008a0:	4501                	li	a0,0
    800008a2:	74e2                	ld	s1,56(sp)
    800008a4:	7942                	ld	s2,48(sp)
    800008a6:	79a2                	ld	s3,40(sp)
    800008a8:	6b42                	ld	s6,16(sp)
}
    800008aa:	60a6                	ld	ra,72(sp)
    800008ac:	6406                	ld	s0,64(sp)
    800008ae:	7a02                	ld	s4,32(sp)
    800008b0:	6ae2                	ld	s5,24(sp)
    800008b2:	6ba2                	ld	s7,8(sp)
    800008b4:	6161                	addi	sp,sp,80
    800008b6:	8082                	ret
      kfree(mem);
    800008b8:	8526                	mv	a0,s1
    800008ba:	f62ff0ef          	jal	8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    800008be:	865e                	mv	a2,s7
    800008c0:	85ca                	mv	a1,s2
    800008c2:	8556                	mv	a0,s5
    800008c4:	f25ff0ef          	jal	800007e8 <uvmdealloc>
      return 0;
    800008c8:	bfe1                	j	800008a0 <uvmalloc+0x72>
    return oldsz;
    800008ca:	852e                	mv	a0,a1
}
    800008cc:	8082                	ret

00000000800008ce <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    800008ce:	7179                	addi	sp,sp,-48
    800008d0:	f406                	sd	ra,40(sp)
    800008d2:	f022                	sd	s0,32(sp)
    800008d4:	ec26                	sd	s1,24(sp)
    800008d6:	e84a                	sd	s2,16(sp)
    800008d8:	e44e                	sd	s3,8(sp)
    800008da:	1800                	addi	s0,sp,48
    800008dc:	89aa                	mv	s3,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800008de:	84aa                	mv	s1,a0
    800008e0:	6905                	lui	s2,0x1
    800008e2:	992a                	add	s2,s2,a0
    800008e4:	a811                	j	800008f8 <freewalk+0x2a>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
      freewalk((pagetable_t)child);
      pagetable[i] = 0;
    } else if(pte & PTE_V){
      panic("freewalk: leaf");
    800008e6:	00007517          	auipc	a0,0x7
    800008ea:	7f250513          	addi	a0,a0,2034 # 800080d8 <etext+0xd8>
    800008ee:	170050ef          	jal	80005a5e <panic>
  for(int i = 0; i < 512; i++){
    800008f2:	04a1                	addi	s1,s1,8
    800008f4:	03248163          	beq	s1,s2,80000916 <freewalk+0x48>
    pte_t pte = pagetable[i];
    800008f8:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800008fa:	0017f713          	andi	a4,a5,1
    800008fe:	db75                	beqz	a4,800008f2 <freewalk+0x24>
    80000900:	00e7f713          	andi	a4,a5,14
    80000904:	f36d                	bnez	a4,800008e6 <freewalk+0x18>
      uint64 child = PTE2PA(pte);
    80000906:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    80000908:	00c79513          	slli	a0,a5,0xc
    8000090c:	fc3ff0ef          	jal	800008ce <freewalk>
      pagetable[i] = 0;
    80000910:	0004b023          	sd	zero,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000914:	bff9                	j	800008f2 <freewalk+0x24>
    }
  }
  kfree((void*)pagetable);
    80000916:	854e                	mv	a0,s3
    80000918:	f04ff0ef          	jal	8000001c <kfree>
}
    8000091c:	70a2                	ld	ra,40(sp)
    8000091e:	7402                	ld	s0,32(sp)
    80000920:	64e2                	ld	s1,24(sp)
    80000922:	6942                	ld	s2,16(sp)
    80000924:	69a2                	ld	s3,8(sp)
    80000926:	6145                	addi	sp,sp,48
    80000928:	8082                	ret

000000008000092a <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    8000092a:	1101                	addi	sp,sp,-32
    8000092c:	ec06                	sd	ra,24(sp)
    8000092e:	e822                	sd	s0,16(sp)
    80000930:	e426                	sd	s1,8(sp)
    80000932:	1000                	addi	s0,sp,32
    80000934:	84aa                	mv	s1,a0
  if(sz > 0)
    80000936:	e989                	bnez	a1,80000948 <uvmfree+0x1e>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000938:	8526                	mv	a0,s1
    8000093a:	f95ff0ef          	jal	800008ce <freewalk>
}
    8000093e:	60e2                	ld	ra,24(sp)
    80000940:	6442                	ld	s0,16(sp)
    80000942:	64a2                	ld	s1,8(sp)
    80000944:	6105                	addi	sp,sp,32
    80000946:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000948:	6785                	lui	a5,0x1
    8000094a:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000094c:	95be                	add	a1,a1,a5
    8000094e:	4685                	li	a3,1
    80000950:	00c5d613          	srli	a2,a1,0xc
    80000954:	4581                	li	a1,0
    80000956:	e09ff0ef          	jal	8000075e <uvmunmap>
    8000095a:	bff9                	j	80000938 <uvmfree+0xe>

000000008000095c <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    8000095c:	ca59                	beqz	a2,800009f2 <uvmcopy+0x96>
{
    8000095e:	715d                	addi	sp,sp,-80
    80000960:	e486                	sd	ra,72(sp)
    80000962:	e0a2                	sd	s0,64(sp)
    80000964:	fc26                	sd	s1,56(sp)
    80000966:	f84a                	sd	s2,48(sp)
    80000968:	f44e                	sd	s3,40(sp)
    8000096a:	f052                	sd	s4,32(sp)
    8000096c:	ec56                	sd	s5,24(sp)
    8000096e:	e85a                	sd	s6,16(sp)
    80000970:	e45e                	sd	s7,8(sp)
    80000972:	0880                	addi	s0,sp,80
    80000974:	8b2a                	mv	s6,a0
    80000976:	8bae                	mv	s7,a1
    80000978:	8ab2                	mv	s5,a2
  for(i = 0; i < sz; i += PGSIZE){
    8000097a:	4481                	li	s1,0
      continue;   // physical page hasn't been allocated
    pa = PTE2PA(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    8000097c:	6a05                	lui	s4,0x1
    8000097e:	a021                	j	80000986 <uvmcopy+0x2a>
  for(i = 0; i < sz; i += PGSIZE){
    80000980:	94d2                	add	s1,s1,s4
    80000982:	0554fc63          	bgeu	s1,s5,800009da <uvmcopy+0x7e>
    if((pte = walk(old, i, 0)) == 0)
    80000986:	4601                	li	a2,0
    80000988:	85a6                	mv	a1,s1
    8000098a:	855a                	mv	a0,s6
    8000098c:	b3dff0ef          	jal	800004c8 <walk>
    80000990:	d965                	beqz	a0,80000980 <uvmcopy+0x24>
    if((*pte & PTE_V) == 0)
    80000992:	00053983          	ld	s3,0(a0)
    80000996:	0019f793          	andi	a5,s3,1
    8000099a:	d3fd                	beqz	a5,80000980 <uvmcopy+0x24>
    if((mem = kalloc()) == 0)
    8000099c:	fc2ff0ef          	jal	8000015e <kalloc>
    800009a0:	892a                	mv	s2,a0
    800009a2:	c11d                	beqz	a0,800009c8 <uvmcopy+0x6c>
    pa = PTE2PA(*pte);
    800009a4:	00a9d593          	srli	a1,s3,0xa
    memmove(mem, (char*)pa, PGSIZE);
    800009a8:	8652                	mv	a2,s4
    800009aa:	05b2                	slli	a1,a1,0xc
    800009ac:	8e7ff0ef          	jal	80000292 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    800009b0:	3ff9f713          	andi	a4,s3,1023
    800009b4:	86ca                	mv	a3,s2
    800009b6:	8652                	mv	a2,s4
    800009b8:	85a6                	mv	a1,s1
    800009ba:	855e                	mv	a0,s7
    800009bc:	bddff0ef          	jal	80000598 <mappages>
    800009c0:	d161                	beqz	a0,80000980 <uvmcopy+0x24>
      kfree(mem);
    800009c2:	854a                	mv	a0,s2
    800009c4:	e58ff0ef          	jal	8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    800009c8:	4685                	li	a3,1
    800009ca:	00c4d613          	srli	a2,s1,0xc
    800009ce:	4581                	li	a1,0
    800009d0:	855e                	mv	a0,s7
    800009d2:	d8dff0ef          	jal	8000075e <uvmunmap>
  return -1;
    800009d6:	557d                	li	a0,-1
    800009d8:	a011                	j	800009dc <uvmcopy+0x80>
  return 0;
    800009da:	4501                	li	a0,0
}
    800009dc:	60a6                	ld	ra,72(sp)
    800009de:	6406                	ld	s0,64(sp)
    800009e0:	74e2                	ld	s1,56(sp)
    800009e2:	7942                	ld	s2,48(sp)
    800009e4:	79a2                	ld	s3,40(sp)
    800009e6:	7a02                	ld	s4,32(sp)
    800009e8:	6ae2                	ld	s5,24(sp)
    800009ea:	6b42                	ld	s6,16(sp)
    800009ec:	6ba2                	ld	s7,8(sp)
    800009ee:	6161                	addi	sp,sp,80
    800009f0:	8082                	ret
  return 0;
    800009f2:	4501                	li	a0,0
}
    800009f4:	8082                	ret

00000000800009f6 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    800009f6:	1141                	addi	sp,sp,-16
    800009f8:	e406                	sd	ra,8(sp)
    800009fa:	e022                	sd	s0,0(sp)
    800009fc:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    800009fe:	4601                	li	a2,0
    80000a00:	ac9ff0ef          	jal	800004c8 <walk>
  if(pte == 0)
    80000a04:	c901                	beqz	a0,80000a14 <uvmclear+0x1e>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000a06:	611c                	ld	a5,0(a0)
    80000a08:	9bbd                	andi	a5,a5,-17
    80000a0a:	e11c                	sd	a5,0(a0)
}
    80000a0c:	60a2                	ld	ra,8(sp)
    80000a0e:	6402                	ld	s0,0(sp)
    80000a10:	0141                	addi	sp,sp,16
    80000a12:	8082                	ret
    panic("uvmclear");
    80000a14:	00007517          	auipc	a0,0x7
    80000a18:	6d450513          	addi	a0,a0,1748 # 800080e8 <etext+0xe8>
    80000a1c:	042050ef          	jal	80005a5e <panic>

0000000080000a20 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000a20:	cac5                	beqz	a3,80000ad0 <copyinstr+0xb0>
{
    80000a22:	715d                	addi	sp,sp,-80
    80000a24:	e486                	sd	ra,72(sp)
    80000a26:	e0a2                	sd	s0,64(sp)
    80000a28:	fc26                	sd	s1,56(sp)
    80000a2a:	f84a                	sd	s2,48(sp)
    80000a2c:	f44e                	sd	s3,40(sp)
    80000a2e:	f052                	sd	s4,32(sp)
    80000a30:	ec56                	sd	s5,24(sp)
    80000a32:	e85a                	sd	s6,16(sp)
    80000a34:	e45e                	sd	s7,8(sp)
    80000a36:	0880                	addi	s0,sp,80
    80000a38:	8aaa                	mv	s5,a0
    80000a3a:	84ae                	mv	s1,a1
    80000a3c:	8bb2                	mv	s7,a2
    80000a3e:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000a40:	7b7d                	lui	s6,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000a42:	6a05                	lui	s4,0x1
    80000a44:	a82d                	j	80000a7e <copyinstr+0x5e>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000a46:	00078023          	sb	zero,0(a5)
        got_null = 1;
    80000a4a:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000a4c:	0017c793          	xori	a5,a5,1
    80000a50:	40f0053b          	negw	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000a54:	60a6                	ld	ra,72(sp)
    80000a56:	6406                	ld	s0,64(sp)
    80000a58:	74e2                	ld	s1,56(sp)
    80000a5a:	7942                	ld	s2,48(sp)
    80000a5c:	79a2                	ld	s3,40(sp)
    80000a5e:	7a02                	ld	s4,32(sp)
    80000a60:	6ae2                	ld	s5,24(sp)
    80000a62:	6b42                	ld	s6,16(sp)
    80000a64:	6ba2                	ld	s7,8(sp)
    80000a66:	6161                	addi	sp,sp,80
    80000a68:	8082                	ret
    80000a6a:	fff98713          	addi	a4,s3,-1 # fff <_entry-0x7ffff001>
    80000a6e:	9726                	add	a4,a4,s1
      --max;
    80000a70:	40b709b3          	sub	s3,a4,a1
    srcva = va0 + PGSIZE;
    80000a74:	01490bb3          	add	s7,s2,s4
  while(got_null == 0 && max > 0){
    80000a78:	04e58463          	beq	a1,a4,80000ac0 <copyinstr+0xa0>
{
    80000a7c:	84be                	mv	s1,a5
    va0 = PGROUNDDOWN(srcva);
    80000a7e:	016bf933          	and	s2,s7,s6
    pa0 = walkaddr(pagetable, va0);
    80000a82:	85ca                	mv	a1,s2
    80000a84:	8556                	mv	a0,s5
    80000a86:	adbff0ef          	jal	80000560 <walkaddr>
    if(pa0 == 0)
    80000a8a:	cd0d                	beqz	a0,80000ac4 <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    80000a8c:	41790633          	sub	a2,s2,s7
    80000a90:	9652                	add	a2,a2,s4
    if(n > max)
    80000a92:	00c9f363          	bgeu	s3,a2,80000a98 <copyinstr+0x78>
    80000a96:	864e                	mv	a2,s3
    while(n > 0){
    80000a98:	ca05                	beqz	a2,80000ac8 <copyinstr+0xa8>
    char *p = (char *) (pa0 + (srcva - va0));
    80000a9a:	034b9693          	slli	a3,s7,0x34
    80000a9e:	92d1                	srli	a3,a3,0x34
    80000aa0:	96aa                	add	a3,a3,a0
    80000aa2:	87a6                	mv	a5,s1
      if(*p == '\0'){
    80000aa4:	8e85                	sub	a3,a3,s1
    while(n > 0){
    80000aa6:	9626                	add	a2,a2,s1
    80000aa8:	85be                	mv	a1,a5
      if(*p == '\0'){
    80000aaa:	00f68733          	add	a4,a3,a5
    80000aae:	00074703          	lbu	a4,0(a4)
    80000ab2:	db51                	beqz	a4,80000a46 <copyinstr+0x26>
        *dst = *p;
    80000ab4:	00e78023          	sb	a4,0(a5)
      dst++;
    80000ab8:	0785                	addi	a5,a5,1
    while(n > 0){
    80000aba:	fec797e3          	bne	a5,a2,80000aa8 <copyinstr+0x88>
    80000abe:	b775                	j	80000a6a <copyinstr+0x4a>
    srcva = va0 + PGSIZE;
    80000ac0:	4781                	li	a5,0
    80000ac2:	b769                	j	80000a4c <copyinstr+0x2c>
      return -1;
    80000ac4:	557d                	li	a0,-1
    80000ac6:	b779                	j	80000a54 <copyinstr+0x34>
    srcva = va0 + PGSIZE;
    80000ac8:	6b85                	lui	s7,0x1
    80000aca:	9bca                	add	s7,s7,s2
    80000acc:	87a6                	mv	a5,s1
    80000ace:	b77d                	j	80000a7c <copyinstr+0x5c>
    80000ad0:	4781                	li	a5,0
  if(got_null){
    80000ad2:	0017c793          	xori	a5,a5,1
    80000ad6:	40f0053b          	negw	a0,a5
}
    80000ada:	8082                	ret

0000000080000adc <ismapped>:
  return mem;
}

int
ismapped(pagetable_t pagetable, uint64 va)
{
    80000adc:	1141                	addi	sp,sp,-16
    80000ade:	e406                	sd	ra,8(sp)
    80000ae0:	e022                	sd	s0,0(sp)
    80000ae2:	0800                	addi	s0,sp,16
  pte_t *pte = walk(pagetable, va, 0);
    80000ae4:	4601                	li	a2,0
    80000ae6:	9e3ff0ef          	jal	800004c8 <walk>
  if (pte == 0) {
    80000aea:	c119                	beqz	a0,80000af0 <ismapped+0x14>
    return 0;
  }
  if (*pte & PTE_V){
    80000aec:	6108                	ld	a0,0(a0)
    80000aee:	8905                	andi	a0,a0,1
    return 1;
  }
  return 0;
}
    80000af0:	60a2                	ld	ra,8(sp)
    80000af2:	6402                	ld	s0,0(sp)
    80000af4:	0141                	addi	sp,sp,16
    80000af6:	8082                	ret

0000000080000af8 <vmfault>:
{
    80000af8:	7179                	addi	sp,sp,-48
    80000afa:	f406                	sd	ra,40(sp)
    80000afc:	f022                	sd	s0,32(sp)
    80000afe:	e84a                	sd	s2,16(sp)
    80000b00:	e052                	sd	s4,0(sp)
    80000b02:	1800                	addi	s0,sp,48
    80000b04:	8a2a                	mv	s4,a0
    80000b06:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80000b08:	32c000ef          	jal	80000e34 <myproc>
  if (va >= p->sz)
    80000b0c:	693c                	ld	a5,80(a0)
    80000b0e:	00f96d63          	bltu	s2,a5,80000b28 <vmfault+0x30>
    return 0;
    80000b12:	4a01                	li	s4,0
}
    80000b14:	8552                	mv	a0,s4
    80000b16:	70a2                	ld	ra,40(sp)
    80000b18:	7402                	ld	s0,32(sp)
    80000b1a:	6942                	ld	s2,16(sp)
    80000b1c:	6a02                	ld	s4,0(sp)
    80000b1e:	6145                	addi	sp,sp,48
    80000b20:	8082                	ret
    80000b22:	64e2                	ld	s1,24(sp)
    80000b24:	69a2                	ld	s3,8(sp)
    80000b26:	b7f5                	j	80000b12 <vmfault+0x1a>
    80000b28:	ec26                	sd	s1,24(sp)
    80000b2a:	e44e                	sd	s3,8(sp)
    80000b2c:	84aa                	mv	s1,a0
  va = PGROUNDDOWN(va);
    80000b2e:	77fd                	lui	a5,0xfffff
    80000b30:	00f979b3          	and	s3,s2,a5
  if(ismapped(pagetable, va)) {
    80000b34:	85ce                	mv	a1,s3
    80000b36:	8552                	mv	a0,s4
    80000b38:	fa5ff0ef          	jal	80000adc <ismapped>
    80000b3c:	c501                	beqz	a0,80000b44 <vmfault+0x4c>
    80000b3e:	64e2                	ld	s1,24(sp)
    80000b40:	69a2                	ld	s3,8(sp)
    80000b42:	bfc1                	j	80000b12 <vmfault+0x1a>
  mem = (uint64) kalloc();
    80000b44:	e1aff0ef          	jal	8000015e <kalloc>
    80000b48:	892a                	mv	s2,a0
  if(mem == 0)
    80000b4a:	dd61                	beqz	a0,80000b22 <vmfault+0x2a>
  mem = (uint64) kalloc();
    80000b4c:	8a2a                	mv	s4,a0
  memset((void *) mem, 0, PGSIZE);
    80000b4e:	6605                	lui	a2,0x1
    80000b50:	4581                	li	a1,0
    80000b52:	ee4ff0ef          	jal	80000236 <memset>
  if (mappages(p->pagetable, va, PGSIZE, mem, PTE_W|PTE_U|PTE_R) != 0) {
    80000b56:	4759                	li	a4,22
    80000b58:	86ca                	mv	a3,s2
    80000b5a:	6605                	lui	a2,0x1
    80000b5c:	85ce                	mv	a1,s3
    80000b5e:	6ca8                	ld	a0,88(s1)
    80000b60:	a39ff0ef          	jal	80000598 <mappages>
    80000b64:	e501                	bnez	a0,80000b6c <vmfault+0x74>
    80000b66:	64e2                	ld	s1,24(sp)
    80000b68:	69a2                	ld	s3,8(sp)
    80000b6a:	b76d                	j	80000b14 <vmfault+0x1c>
    kfree((void *)mem);
    80000b6c:	854a                	mv	a0,s2
    80000b6e:	caeff0ef          	jal	8000001c <kfree>
    return 0;
    80000b72:	64e2                	ld	s1,24(sp)
    80000b74:	69a2                	ld	s3,8(sp)
    80000b76:	bf71                	j	80000b12 <vmfault+0x1a>

0000000080000b78 <copyout>:
  while(len > 0){
    80000b78:	cad5                	beqz	a3,80000c2c <copyout+0xb4>
{
    80000b7a:	711d                	addi	sp,sp,-96
    80000b7c:	ec86                	sd	ra,88(sp)
    80000b7e:	e8a2                	sd	s0,80(sp)
    80000b80:	e4a6                	sd	s1,72(sp)
    80000b82:	e0ca                	sd	s2,64(sp)
    80000b84:	fc4e                	sd	s3,56(sp)
    80000b86:	f852                	sd	s4,48(sp)
    80000b88:	f456                	sd	s5,40(sp)
    80000b8a:	f05a                	sd	s6,32(sp)
    80000b8c:	ec5e                	sd	s7,24(sp)
    80000b8e:	e862                	sd	s8,16(sp)
    80000b90:	e466                	sd	s9,8(sp)
    80000b92:	e06a                	sd	s10,0(sp)
    80000b94:	1080                	addi	s0,sp,96
    80000b96:	8baa                	mv	s7,a0
    80000b98:	84ae                	mv	s1,a1
    80000b9a:	8b32                	mv	s6,a2
    80000b9c:	8ab6                	mv	s5,a3
    va0 = PGROUNDDOWN(dstva);
    80000b9e:	7d7d                	lui	s10,0xfffff
    if(va0 >= MAXVA)
    80000ba0:	5cfd                	li	s9,-1
    80000ba2:	01acdc93          	srli	s9,s9,0x1a
    n = PGSIZE - (dstva - va0);
    80000ba6:	6c05                	lui	s8,0x1
    80000ba8:	a081                	j	80000be8 <copyout+0x70>
      return -1;
    80000baa:	557d                	li	a0,-1
}
    80000bac:	60e6                	ld	ra,88(sp)
    80000bae:	6446                	ld	s0,80(sp)
    80000bb0:	64a6                	ld	s1,72(sp)
    80000bb2:	6906                	ld	s2,64(sp)
    80000bb4:	79e2                	ld	s3,56(sp)
    80000bb6:	7a42                	ld	s4,48(sp)
    80000bb8:	7aa2                	ld	s5,40(sp)
    80000bba:	7b02                	ld	s6,32(sp)
    80000bbc:	6be2                	ld	s7,24(sp)
    80000bbe:	6c42                	ld	s8,16(sp)
    80000bc0:	6ca2                	ld	s9,8(sp)
    80000bc2:	6d02                	ld	s10,0(sp)
    80000bc4:	6125                	addi	sp,sp,96
    80000bc6:	8082                	ret
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000bc8:	03449513          	slli	a0,s1,0x34
    80000bcc:	9151                	srli	a0,a0,0x34
    80000bce:	0009061b          	sext.w	a2,s2
    80000bd2:	85da                	mv	a1,s6
    80000bd4:	954e                	add	a0,a0,s3
    80000bd6:	ebcff0ef          	jal	80000292 <memmove>
    len -= n;
    80000bda:	412a8ab3          	sub	s5,s5,s2
    src += n;
    80000bde:	9b4a                	add	s6,s6,s2
    dstva = va0 + PGSIZE;
    80000be0:	018a04b3          	add	s1,s4,s8
  while(len > 0){
    80000be4:	040a8263          	beqz	s5,80000c28 <copyout+0xb0>
    va0 = PGROUNDDOWN(dstva);
    80000be8:	01a4fa33          	and	s4,s1,s10
    if(va0 >= MAXVA)
    80000bec:	fb4cefe3          	bltu	s9,s4,80000baa <copyout+0x32>
    pa0 = walkaddr(pagetable, va0);
    80000bf0:	85d2                	mv	a1,s4
    80000bf2:	855e                	mv	a0,s7
    80000bf4:	96dff0ef          	jal	80000560 <walkaddr>
    80000bf8:	89aa                	mv	s3,a0
    if(pa0 == 0) {
    80000bfa:	e901                	bnez	a0,80000c0a <copyout+0x92>
      if((pa0 = vmfault(pagetable, va0, 0)) == 0) {
    80000bfc:	4601                	li	a2,0
    80000bfe:	85d2                	mv	a1,s4
    80000c00:	855e                	mv	a0,s7
    80000c02:	ef7ff0ef          	jal	80000af8 <vmfault>
    80000c06:	89aa                	mv	s3,a0
    80000c08:	d14d                	beqz	a0,80000baa <copyout+0x32>
    pte = walk(pagetable, va0, 0);
    80000c0a:	4601                	li	a2,0
    80000c0c:	85d2                	mv	a1,s4
    80000c0e:	855e                	mv	a0,s7
    80000c10:	8b9ff0ef          	jal	800004c8 <walk>
    if((*pte & PTE_W) == 0)
    80000c14:	611c                	ld	a5,0(a0)
    80000c16:	8b91                	andi	a5,a5,4
    80000c18:	dbc9                	beqz	a5,80000baa <copyout+0x32>
    n = PGSIZE - (dstva - va0);
    80000c1a:	409a0933          	sub	s2,s4,s1
    80000c1e:	9962                	add	s2,s2,s8
    if(n > len)
    80000c20:	fb2af4e3          	bgeu	s5,s2,80000bc8 <copyout+0x50>
    80000c24:	8956                	mv	s2,s5
    80000c26:	b74d                	j	80000bc8 <copyout+0x50>
  return 0;
    80000c28:	4501                	li	a0,0
    80000c2a:	b749                	j	80000bac <copyout+0x34>
    80000c2c:	4501                	li	a0,0
}
    80000c2e:	8082                	ret

0000000080000c30 <copyin>:
  while(len > 0){
    80000c30:	c6d1                	beqz	a3,80000cbc <copyin+0x8c>
{
    80000c32:	715d                	addi	sp,sp,-80
    80000c34:	e486                	sd	ra,72(sp)
    80000c36:	e0a2                	sd	s0,64(sp)
    80000c38:	fc26                	sd	s1,56(sp)
    80000c3a:	f84a                	sd	s2,48(sp)
    80000c3c:	f44e                	sd	s3,40(sp)
    80000c3e:	f052                	sd	s4,32(sp)
    80000c40:	ec56                	sd	s5,24(sp)
    80000c42:	e85a                	sd	s6,16(sp)
    80000c44:	e45e                	sd	s7,8(sp)
    80000c46:	e062                	sd	s8,0(sp)
    80000c48:	0880                	addi	s0,sp,80
    80000c4a:	8baa                	mv	s7,a0
    80000c4c:	8aae                	mv	s5,a1
    80000c4e:	84b2                	mv	s1,a2
    80000c50:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000c52:	7c7d                	lui	s8,0xfffff
    n = PGSIZE - (srcva - va0);
    80000c54:	6b05                	lui	s6,0x1
    80000c56:	a03d                	j	80000c84 <copyin+0x54>
    80000c58:	409a0933          	sub	s2,s4,s1
    80000c5c:	995a                	add	s2,s2,s6
    if(n > len)
    80000c5e:	0129f363          	bgeu	s3,s2,80000c64 <copyin+0x34>
    80000c62:	894e                	mv	s2,s3
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000c64:	03449593          	slli	a1,s1,0x34
    80000c68:	91d1                	srli	a1,a1,0x34
    80000c6a:	0009061b          	sext.w	a2,s2
    80000c6e:	95aa                	add	a1,a1,a0
    80000c70:	8556                	mv	a0,s5
    80000c72:	e20ff0ef          	jal	80000292 <memmove>
    len -= n;
    80000c76:	412989b3          	sub	s3,s3,s2
    dst += n;
    80000c7a:	9aca                	add	s5,s5,s2
    srcva = va0 + PGSIZE;
    80000c7c:	016a04b3          	add	s1,s4,s6
  while(len > 0){
    80000c80:	02098163          	beqz	s3,80000ca2 <copyin+0x72>
    va0 = PGROUNDDOWN(srcva);
    80000c84:	0184fa33          	and	s4,s1,s8
    pa0 = walkaddr(pagetable, va0);
    80000c88:	85d2                	mv	a1,s4
    80000c8a:	855e                	mv	a0,s7
    80000c8c:	8d5ff0ef          	jal	80000560 <walkaddr>
    if(pa0 == 0) {
    80000c90:	f561                	bnez	a0,80000c58 <copyin+0x28>
      if((pa0 = vmfault(pagetable, va0, 0)) == 0) {
    80000c92:	4601                	li	a2,0
    80000c94:	85d2                	mv	a1,s4
    80000c96:	855e                	mv	a0,s7
    80000c98:	e61ff0ef          	jal	80000af8 <vmfault>
    80000c9c:	fd55                	bnez	a0,80000c58 <copyin+0x28>
        return -1;
    80000c9e:	557d                	li	a0,-1
    80000ca0:	a011                	j	80000ca4 <copyin+0x74>
  return 0;
    80000ca2:	4501                	li	a0,0
}
    80000ca4:	60a6                	ld	ra,72(sp)
    80000ca6:	6406                	ld	s0,64(sp)
    80000ca8:	74e2                	ld	s1,56(sp)
    80000caa:	7942                	ld	s2,48(sp)
    80000cac:	79a2                	ld	s3,40(sp)
    80000cae:	7a02                	ld	s4,32(sp)
    80000cb0:	6ae2                	ld	s5,24(sp)
    80000cb2:	6b42                	ld	s6,16(sp)
    80000cb4:	6ba2                	ld	s7,8(sp)
    80000cb6:	6c02                	ld	s8,0(sp)
    80000cb8:	6161                	addi	sp,sp,80
    80000cba:	8082                	ret
  return 0;
    80000cbc:	4501                	li	a0,0
}
    80000cbe:	8082                	ret

0000000080000cc0 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80000cc0:	715d                	addi	sp,sp,-80
    80000cc2:	e486                	sd	ra,72(sp)
    80000cc4:	e0a2                	sd	s0,64(sp)
    80000cc6:	fc26                	sd	s1,56(sp)
    80000cc8:	f84a                	sd	s2,48(sp)
    80000cca:	f44e                	sd	s3,40(sp)
    80000ccc:	f052                	sd	s4,32(sp)
    80000cce:	ec56                	sd	s5,24(sp)
    80000cd0:	e85a                	sd	s6,16(sp)
    80000cd2:	e45e                	sd	s7,8(sp)
    80000cd4:	0880                	addi	s0,sp,80
    80000cd6:	8aaa                	mv	s5,a0
    80000cd8:	4481                	li	s1,0
  
  for(p = proc; p < &proc[NPROC]; p++) {
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000cda:	677d47b7          	lui	a5,0x677d4
    80000cde:	6cf78793          	addi	a5,a5,1743 # 677d46cf <_entry-0x1882b931>
    80000ce2:	51b3c937          	lui	s2,0x51b3c
    80000ce6:	ea390913          	addi	s2,s2,-349 # 51b3bea3 <_entry-0x2e4c415d>
    80000cea:	1902                	slli	s2,s2,0x20
    80000cec:	993e                	add	s2,s2,a5
    80000cee:	040009b7          	lui	s3,0x4000
    80000cf2:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000cf4:	09b2                	slli	s3,s3,0xc
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000cf6:	4b99                	li	s7,6
    80000cf8:	6b05                	lui	s6,0x1
  for(p = proc; p < &proc[NPROC]; p++) {
    80000cfa:	6a19                	lui	s4,0x6
    80000cfc:	e00a0a13          	addi	s4,s4,-512 # 5e00 <_entry-0x7fffa200>
    char *pa = kalloc();
    80000d00:	c5eff0ef          	jal	8000015e <kalloc>
    80000d04:	862a                	mv	a2,a0
    if(pa == 0)
    80000d06:	cd15                	beqz	a0,80000d42 <proc_mapstacks+0x82>
    uint64 va = KSTACK((int) (p - proc));
    80000d08:	4034d593          	srai	a1,s1,0x3
    80000d0c:	032585b3          	mul	a1,a1,s2
    80000d10:	05b6                	slli	a1,a1,0xd
    80000d12:	6789                	lui	a5,0x2
    80000d14:	9dbd                	addw	a1,a1,a5
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000d16:	875e                	mv	a4,s7
    80000d18:	86da                	mv	a3,s6
    80000d1a:	40b985b3          	sub	a1,s3,a1
    80000d1e:	8556                	mv	a0,s5
    80000d20:	92bff0ef          	jal	8000064a <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d24:	17848493          	addi	s1,s1,376
    80000d28:	fd449ce3          	bne	s1,s4,80000d00 <proc_mapstacks+0x40>
  }
}
    80000d2c:	60a6                	ld	ra,72(sp)
    80000d2e:	6406                	ld	s0,64(sp)
    80000d30:	74e2                	ld	s1,56(sp)
    80000d32:	7942                	ld	s2,48(sp)
    80000d34:	79a2                	ld	s3,40(sp)
    80000d36:	7a02                	ld	s4,32(sp)
    80000d38:	6ae2                	ld	s5,24(sp)
    80000d3a:	6b42                	ld	s6,16(sp)
    80000d3c:	6ba2                	ld	s7,8(sp)
    80000d3e:	6161                	addi	sp,sp,80
    80000d40:	8082                	ret
      panic("kalloc");
    80000d42:	00007517          	auipc	a0,0x7
    80000d46:	3b650513          	addi	a0,a0,950 # 800080f8 <etext+0xf8>
    80000d4a:	515040ef          	jal	80005a5e <panic>

0000000080000d4e <procinit>:

// initialize the proc table.
void
procinit(void)
{
    80000d4e:	7139                	addi	sp,sp,-64
    80000d50:	fc06                	sd	ra,56(sp)
    80000d52:	f822                	sd	s0,48(sp)
    80000d54:	f426                	sd	s1,40(sp)
    80000d56:	f04a                	sd	s2,32(sp)
    80000d58:	ec4e                	sd	s3,24(sp)
    80000d5a:	e852                	sd	s4,16(sp)
    80000d5c:	e456                	sd	s5,8(sp)
    80000d5e:	e05a                	sd	s6,0(sp)
    80000d60:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000d62:	00007597          	auipc	a1,0x7
    80000d66:	39e58593          	addi	a1,a1,926 # 80008100 <etext+0x100>
    80000d6a:	00008517          	auipc	a0,0x8
    80000d6e:	13650513          	addi	a0,a0,310 # 80008ea0 <pid_lock>
    80000d72:	1fc050ef          	jal	80005f6e <initlock>
  initlock(&wait_lock, "wait_lock");
    80000d76:	00007597          	auipc	a1,0x7
    80000d7a:	39258593          	addi	a1,a1,914 # 80008108 <etext+0x108>
    80000d7e:	00008517          	auipc	a0,0x8
    80000d82:	14250513          	addi	a0,a0,322 # 80008ec0 <wait_lock>
    80000d86:	1e8050ef          	jal	80005f6e <initlock>
    80000d8a:	4901                	li	s2,0
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d8c:	00008497          	auipc	s1,0x8
    80000d90:	55448493          	addi	s1,s1,1364 # 800092e0 <proc>
      initlock(&p->lock, "proc");
    80000d94:	00007a97          	auipc	s5,0x7
    80000d98:	384a8a93          	addi	s5,s5,900 # 80008118 <etext+0x118>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80000d9c:	677d47b7          	lui	a5,0x677d4
    80000da0:	6cf78793          	addi	a5,a5,1743 # 677d46cf <_entry-0x1882b931>
    80000da4:	51b3c9b7          	lui	s3,0x51b3c
    80000da8:	ea398993          	addi	s3,s3,-349 # 51b3bea3 <_entry-0x2e4c415d>
    80000dac:	1982                	slli	s3,s3,0x20
    80000dae:	99be                	add	s3,s3,a5
    80000db0:	04000a37          	lui	s4,0x4000
    80000db4:	1a7d                	addi	s4,s4,-1 # 3ffffff <_entry-0x7c000001>
    80000db6:	0a32                	slli	s4,s4,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000db8:	0000eb17          	auipc	s6,0xe
    80000dbc:	328b0b13          	addi	s6,s6,808 # 8000f0e0 <tickslock>
      initlock(&p->lock, "proc");
    80000dc0:	85d6                	mv	a1,s5
    80000dc2:	8526                	mv	a0,s1
    80000dc4:	1aa050ef          	jal	80005f6e <initlock>
      p->state = UNUSED;
    80000dc8:	0204a023          	sw	zero,32(s1)
      p->kstack = KSTACK((int) (p - proc));
    80000dcc:	40395793          	srai	a5,s2,0x3
    80000dd0:	033787b3          	mul	a5,a5,s3
    80000dd4:	07b6                	slli	a5,a5,0xd
    80000dd6:	6709                	lui	a4,0x2
    80000dd8:	9fb9                	addw	a5,a5,a4
    80000dda:	40fa07b3          	sub	a5,s4,a5
    80000dde:	e4bc                	sd	a5,72(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000de0:	17848493          	addi	s1,s1,376
    80000de4:	17890913          	addi	s2,s2,376
    80000de8:	fd649ce3          	bne	s1,s6,80000dc0 <procinit+0x72>
  }
}
    80000dec:	70e2                	ld	ra,56(sp)
    80000dee:	7442                	ld	s0,48(sp)
    80000df0:	74a2                	ld	s1,40(sp)
    80000df2:	7902                	ld	s2,32(sp)
    80000df4:	69e2                	ld	s3,24(sp)
    80000df6:	6a42                	ld	s4,16(sp)
    80000df8:	6aa2                	ld	s5,8(sp)
    80000dfa:	6b02                	ld	s6,0(sp)
    80000dfc:	6121                	addi	sp,sp,64
    80000dfe:	8082                	ret

0000000080000e00 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000e00:	1141                	addi	sp,sp,-16
    80000e02:	e406                	sd	ra,8(sp)
    80000e04:	e022                	sd	s0,0(sp)
    80000e06:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000e08:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000e0a:	2501                	sext.w	a0,a0
    80000e0c:	60a2                	ld	ra,8(sp)
    80000e0e:	6402                	ld	s0,0(sp)
    80000e10:	0141                	addi	sp,sp,16
    80000e12:	8082                	ret

0000000080000e14 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    80000e14:	1141                	addi	sp,sp,-16
    80000e16:	e406                	sd	ra,8(sp)
    80000e18:	e022                	sd	s0,0(sp)
    80000e1a:	0800                	addi	s0,sp,16
    80000e1c:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000e1e:	2781                	sext.w	a5,a5
    80000e20:	079e                	slli	a5,a5,0x7
  return c;
}
    80000e22:	00008517          	auipc	a0,0x8
    80000e26:	0be50513          	addi	a0,a0,190 # 80008ee0 <cpus>
    80000e2a:	953e                	add	a0,a0,a5
    80000e2c:	60a2                	ld	ra,8(sp)
    80000e2e:	6402                	ld	s0,0(sp)
    80000e30:	0141                	addi	sp,sp,16
    80000e32:	8082                	ret

0000000080000e34 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80000e34:	1101                	addi	sp,sp,-32
    80000e36:	ec06                	sd	ra,24(sp)
    80000e38:	e822                	sd	s0,16(sp)
    80000e3a:	e426                	sd	s1,8(sp)
    80000e3c:	1000                	addi	s0,sp,32
  push_off();
    80000e3e:	719040ef          	jal	80005d56 <push_off>
    80000e42:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000e44:	2781                	sext.w	a5,a5
    80000e46:	079e                	slli	a5,a5,0x7
    80000e48:	00008717          	auipc	a4,0x8
    80000e4c:	05870713          	addi	a4,a4,88 # 80008ea0 <pid_lock>
    80000e50:	97ba                	add	a5,a5,a4
    80000e52:	63bc                	ld	a5,64(a5)
    80000e54:	84be                	mv	s1,a5
  pop_off();
    80000e56:	030050ef          	jal	80005e86 <pop_off>
  return p;
}
    80000e5a:	8526                	mv	a0,s1
    80000e5c:	60e2                	ld	ra,24(sp)
    80000e5e:	6442                	ld	s0,16(sp)
    80000e60:	64a2                	ld	s1,8(sp)
    80000e62:	6105                	addi	sp,sp,32
    80000e64:	8082                	ret

0000000080000e66 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000e66:	7179                	addi	sp,sp,-48
    80000e68:	f406                	sd	ra,40(sp)
    80000e6a:	f022                	sd	s0,32(sp)
    80000e6c:	ec26                	sd	s1,24(sp)
    80000e6e:	1800                	addi	s0,sp,48
  extern char userret[];
  static int first = 1;
  struct proc *p = myproc();
    80000e70:	fc5ff0ef          	jal	80000e34 <myproc>
    80000e74:	84aa                	mv	s1,a0

  // Still holding p->lock from scheduler.
  release(&p->lock);
    80000e76:	060050ef          	jal	80005ed6 <release>

  if (first) {
    80000e7a:	00008797          	auipc	a5,0x8
    80000e7e:	e467a783          	lw	a5,-442(a5) # 80008cc0 <first.1>
    80000e82:	cf95                	beqz	a5,80000ebe <forkret+0x58>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    fsinit(ROOTDEV);
    80000e84:	4505                	li	a0,1
    80000e86:	3f9010ef          	jal	80002a7e <fsinit>

    first = 0;
    80000e8a:	00008797          	auipc	a5,0x8
    80000e8e:	e207ab23          	sw	zero,-458(a5) # 80008cc0 <first.1>
    // ensure other cores see first=0.
    __sync_synchronize();
    80000e92:	0330000f          	fence	rw,rw

    // We can invoke kexec() now that file system is initialized.
    // Put the return value (argc) of kexec into a0.
    p->trapframe->a0 = kexec("/init", (char *[]){ "/init", 0 });
    80000e96:	00007797          	auipc	a5,0x7
    80000e9a:	28a78793          	addi	a5,a5,650 # 80008120 <etext+0x120>
    80000e9e:	fcf43823          	sd	a5,-48(s0)
    80000ea2:	fc043c23          	sd	zero,-40(s0)
    80000ea6:	fd040593          	addi	a1,s0,-48
    80000eaa:	853e                	mv	a0,a5
    80000eac:	54b020ef          	jal	80003bf6 <kexec>
    80000eb0:	70bc                	ld	a5,96(s1)
    80000eb2:	fba8                	sd	a0,112(a5)
    if (p->trapframe->a0 == -1) {
    80000eb4:	70bc                	ld	a5,96(s1)
    80000eb6:	7bb8                	ld	a4,112(a5)
    80000eb8:	57fd                	li	a5,-1
    80000eba:	02f70d63          	beq	a4,a5,80000ef4 <forkret+0x8e>
      panic("exec");
    }
  }

  // return to user space, mimicing usertrap()'s return.
  prepare_return();
    80000ebe:	2e3000ef          	jal	800019a0 <prepare_return>
  uint64 satp = MAKE_SATP(p->pagetable);
    80000ec2:	6ca8                	ld	a0,88(s1)
    80000ec4:	8131                	srli	a0,a0,0xc
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80000ec6:	04000737          	lui	a4,0x4000
    80000eca:	177d                	addi	a4,a4,-1 # 3ffffff <_entry-0x7c000001>
    80000ecc:	0732                	slli	a4,a4,0xc
    80000ece:	00006797          	auipc	a5,0x6
    80000ed2:	1ce78793          	addi	a5,a5,462 # 8000709c <userret>
    80000ed6:	00006697          	auipc	a3,0x6
    80000eda:	12a68693          	addi	a3,a3,298 # 80007000 <_trampoline>
    80000ede:	8f95                	sub	a5,a5,a3
    80000ee0:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80000ee2:	577d                	li	a4,-1
    80000ee4:	177e                	slli	a4,a4,0x3f
    80000ee6:	8d59                	or	a0,a0,a4
    80000ee8:	9782                	jalr	a5
}
    80000eea:	70a2                	ld	ra,40(sp)
    80000eec:	7402                	ld	s0,32(sp)
    80000eee:	64e2                	ld	s1,24(sp)
    80000ef0:	6145                	addi	sp,sp,48
    80000ef2:	8082                	ret
      panic("exec");
    80000ef4:	00007517          	auipc	a0,0x7
    80000ef8:	23450513          	addi	a0,a0,564 # 80008128 <etext+0x128>
    80000efc:	363040ef          	jal	80005a5e <panic>

0000000080000f00 <allocpid>:
{
    80000f00:	1101                	addi	sp,sp,-32
    80000f02:	ec06                	sd	ra,24(sp)
    80000f04:	e822                	sd	s0,16(sp)
    80000f06:	e426                	sd	s1,8(sp)
    80000f08:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000f0a:	00008517          	auipc	a0,0x8
    80000f0e:	f9650513          	addi	a0,a0,-106 # 80008ea0 <pid_lock>
    80000f12:	689040ef          	jal	80005d9a <acquire>
  pid = nextpid;
    80000f16:	00008797          	auipc	a5,0x8
    80000f1a:	dae78793          	addi	a5,a5,-594 # 80008cc4 <nextpid>
    80000f1e:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000f20:	0014871b          	addiw	a4,s1,1
    80000f24:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000f26:	00008517          	auipc	a0,0x8
    80000f2a:	f7a50513          	addi	a0,a0,-134 # 80008ea0 <pid_lock>
    80000f2e:	7a9040ef          	jal	80005ed6 <release>
}
    80000f32:	8526                	mv	a0,s1
    80000f34:	60e2                	ld	ra,24(sp)
    80000f36:	6442                	ld	s0,16(sp)
    80000f38:	64a2                	ld	s1,8(sp)
    80000f3a:	6105                	addi	sp,sp,32
    80000f3c:	8082                	ret

0000000080000f3e <proc_pagetable>:
{
    80000f3e:	1101                	addi	sp,sp,-32
    80000f40:	ec06                	sd	ra,24(sp)
    80000f42:	e822                	sd	s0,16(sp)
    80000f44:	e426                	sd	s1,8(sp)
    80000f46:	e04a                	sd	s2,0(sp)
    80000f48:	1000                	addi	s0,sp,32
    80000f4a:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000f4c:	fecff0ef          	jal	80000738 <uvmcreate>
    80000f50:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000f52:	cd05                	beqz	a0,80000f8a <proc_pagetable+0x4c>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80000f54:	4729                	li	a4,10
    80000f56:	00006697          	auipc	a3,0x6
    80000f5a:	0aa68693          	addi	a3,a3,170 # 80007000 <_trampoline>
    80000f5e:	6605                	lui	a2,0x1
    80000f60:	040005b7          	lui	a1,0x4000
    80000f64:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000f66:	05b2                	slli	a1,a1,0xc
    80000f68:	e30ff0ef          	jal	80000598 <mappages>
    80000f6c:	02054663          	bltz	a0,80000f98 <proc_pagetable+0x5a>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80000f70:	4719                	li	a4,6
    80000f72:	06093683          	ld	a3,96(s2)
    80000f76:	6605                	lui	a2,0x1
    80000f78:	020005b7          	lui	a1,0x2000
    80000f7c:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000f7e:	05b6                	slli	a1,a1,0xd
    80000f80:	8526                	mv	a0,s1
    80000f82:	e16ff0ef          	jal	80000598 <mappages>
    80000f86:	00054f63          	bltz	a0,80000fa4 <proc_pagetable+0x66>
}
    80000f8a:	8526                	mv	a0,s1
    80000f8c:	60e2                	ld	ra,24(sp)
    80000f8e:	6442                	ld	s0,16(sp)
    80000f90:	64a2                	ld	s1,8(sp)
    80000f92:	6902                	ld	s2,0(sp)
    80000f94:	6105                	addi	sp,sp,32
    80000f96:	8082                	ret
    uvmfree(pagetable, 0);
    80000f98:	4581                	li	a1,0
    80000f9a:	8526                	mv	a0,s1
    80000f9c:	98fff0ef          	jal	8000092a <uvmfree>
    return 0;
    80000fa0:	4481                	li	s1,0
    80000fa2:	b7e5                	j	80000f8a <proc_pagetable+0x4c>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000fa4:	4681                	li	a3,0
    80000fa6:	4605                	li	a2,1
    80000fa8:	040005b7          	lui	a1,0x4000
    80000fac:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000fae:	05b2                	slli	a1,a1,0xc
    80000fb0:	8526                	mv	a0,s1
    80000fb2:	facff0ef          	jal	8000075e <uvmunmap>
    uvmfree(pagetable, 0);
    80000fb6:	4581                	li	a1,0
    80000fb8:	8526                	mv	a0,s1
    80000fba:	971ff0ef          	jal	8000092a <uvmfree>
    return 0;
    80000fbe:	b7cd                	j	80000fa0 <proc_pagetable+0x62>

0000000080000fc0 <proc_freepagetable>:
{
    80000fc0:	1101                	addi	sp,sp,-32
    80000fc2:	ec06                	sd	ra,24(sp)
    80000fc4:	e822                	sd	s0,16(sp)
    80000fc6:	e426                	sd	s1,8(sp)
    80000fc8:	e04a                	sd	s2,0(sp)
    80000fca:	1000                	addi	s0,sp,32
    80000fcc:	84aa                	mv	s1,a0
    80000fce:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000fd0:	4681                	li	a3,0
    80000fd2:	4605                	li	a2,1
    80000fd4:	040005b7          	lui	a1,0x4000
    80000fd8:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000fda:	05b2                	slli	a1,a1,0xc
    80000fdc:	f82ff0ef          	jal	8000075e <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80000fe0:	4681                	li	a3,0
    80000fe2:	4605                	li	a2,1
    80000fe4:	020005b7          	lui	a1,0x2000
    80000fe8:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000fea:	05b6                	slli	a1,a1,0xd
    80000fec:	8526                	mv	a0,s1
    80000fee:	f70ff0ef          	jal	8000075e <uvmunmap>
  uvmfree(pagetable, sz);
    80000ff2:	85ca                	mv	a1,s2
    80000ff4:	8526                	mv	a0,s1
    80000ff6:	935ff0ef          	jal	8000092a <uvmfree>
}
    80000ffa:	60e2                	ld	ra,24(sp)
    80000ffc:	6442                	ld	s0,16(sp)
    80000ffe:	64a2                	ld	s1,8(sp)
    80001000:	6902                	ld	s2,0(sp)
    80001002:	6105                	addi	sp,sp,32
    80001004:	8082                	ret

0000000080001006 <freeproc>:
{
    80001006:	1101                	addi	sp,sp,-32
    80001008:	ec06                	sd	ra,24(sp)
    8000100a:	e822                	sd	s0,16(sp)
    8000100c:	e426                	sd	s1,8(sp)
    8000100e:	1000                	addi	s0,sp,32
    80001010:	84aa                	mv	s1,a0
  if(p->trapframe)
    80001012:	7128                	ld	a0,96(a0)
    80001014:	c119                	beqz	a0,8000101a <freeproc+0x14>
    kfree((void*)p->trapframe);
    80001016:	806ff0ef          	jal	8000001c <kfree>
  p->trapframe = 0;
    8000101a:	0604b023          	sd	zero,96(s1)
  if(p->pagetable)
    8000101e:	6ca8                	ld	a0,88(s1)
    80001020:	c501                	beqz	a0,80001028 <freeproc+0x22>
    proc_freepagetable(p->pagetable, p->sz);
    80001022:	68ac                	ld	a1,80(s1)
    80001024:	f9dff0ef          	jal	80000fc0 <proc_freepagetable>
  p->pagetable = 0;
    80001028:	0404bc23          	sd	zero,88(s1)
  p->sz = 0;
    8000102c:	0404b823          	sd	zero,80(s1)
  p->pid = 0;
    80001030:	0204ac23          	sw	zero,56(s1)
  p->parent = 0;
    80001034:	0404b023          	sd	zero,64(s1)
  p->name[0] = 0;
    80001038:	16048023          	sb	zero,352(s1)
  p->chan = 0;
    8000103c:	0204b423          	sd	zero,40(s1)
  p->killed = 0;
    80001040:	0204a823          	sw	zero,48(s1)
  p->xstate = 0;
    80001044:	0204aa23          	sw	zero,52(s1)
  p->state = UNUSED;
    80001048:	0204a023          	sw	zero,32(s1)
}
    8000104c:	60e2                	ld	ra,24(sp)
    8000104e:	6442                	ld	s0,16(sp)
    80001050:	64a2                	ld	s1,8(sp)
    80001052:	6105                	addi	sp,sp,32
    80001054:	8082                	ret

0000000080001056 <allocproc>:
{
    80001056:	1101                	addi	sp,sp,-32
    80001058:	ec06                	sd	ra,24(sp)
    8000105a:	e822                	sd	s0,16(sp)
    8000105c:	e426                	sd	s1,8(sp)
    8000105e:	e04a                	sd	s2,0(sp)
    80001060:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80001062:	00008497          	auipc	s1,0x8
    80001066:	27e48493          	addi	s1,s1,638 # 800092e0 <proc>
    8000106a:	0000e917          	auipc	s2,0xe
    8000106e:	07690913          	addi	s2,s2,118 # 8000f0e0 <tickslock>
    acquire(&p->lock);
    80001072:	8526                	mv	a0,s1
    80001074:	527040ef          	jal	80005d9a <acquire>
    if(p->state == UNUSED) {
    80001078:	509c                	lw	a5,32(s1)
    8000107a:	cb91                	beqz	a5,8000108e <allocproc+0x38>
      release(&p->lock);
    8000107c:	8526                	mv	a0,s1
    8000107e:	659040ef          	jal	80005ed6 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001082:	17848493          	addi	s1,s1,376
    80001086:	ff2496e3          	bne	s1,s2,80001072 <allocproc+0x1c>
  return 0;
    8000108a:	4481                	li	s1,0
    8000108c:	a099                	j	800010d2 <allocproc+0x7c>
  p->pid = allocpid();
    8000108e:	e73ff0ef          	jal	80000f00 <allocpid>
    80001092:	dc88                	sw	a0,56(s1)
  p->state = USED;
    80001094:	4785                	li	a5,1
    80001096:	d09c                	sw	a5,32(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001098:	8c6ff0ef          	jal	8000015e <kalloc>
    8000109c:	892a                	mv	s2,a0
    8000109e:	f0a8                	sd	a0,96(s1)
    800010a0:	c121                	beqz	a0,800010e0 <allocproc+0x8a>
  p->pincpu = 0;
    800010a2:	1604b823          	sd	zero,368(s1)
  p->pagetable = proc_pagetable(p);
    800010a6:	8526                	mv	a0,s1
    800010a8:	e97ff0ef          	jal	80000f3e <proc_pagetable>
    800010ac:	892a                	mv	s2,a0
    800010ae:	eca8                	sd	a0,88(s1)
  if(p->pagetable == 0){
    800010b0:	c121                	beqz	a0,800010f0 <allocproc+0x9a>
  memset(&p->context, 0, sizeof(p->context));
    800010b2:	07000613          	li	a2,112
    800010b6:	4581                	li	a1,0
    800010b8:	06848513          	addi	a0,s1,104
    800010bc:	97aff0ef          	jal	80000236 <memset>
  p->context.ra = (uint64)forkret;
    800010c0:	00000797          	auipc	a5,0x0
    800010c4:	da678793          	addi	a5,a5,-602 # 80000e66 <forkret>
    800010c8:	f4bc                	sd	a5,104(s1)
  p->context.sp = p->kstack + PGSIZE;
    800010ca:	64bc                	ld	a5,72(s1)
    800010cc:	6705                	lui	a4,0x1
    800010ce:	97ba                	add	a5,a5,a4
    800010d0:	f8bc                	sd	a5,112(s1)
}
    800010d2:	8526                	mv	a0,s1
    800010d4:	60e2                	ld	ra,24(sp)
    800010d6:	6442                	ld	s0,16(sp)
    800010d8:	64a2                	ld	s1,8(sp)
    800010da:	6902                	ld	s2,0(sp)
    800010dc:	6105                	addi	sp,sp,32
    800010de:	8082                	ret
    freeproc(p);
    800010e0:	8526                	mv	a0,s1
    800010e2:	f25ff0ef          	jal	80001006 <freeproc>
    release(&p->lock);
    800010e6:	8526                	mv	a0,s1
    800010e8:	5ef040ef          	jal	80005ed6 <release>
    return 0;
    800010ec:	84ca                	mv	s1,s2
    800010ee:	b7d5                	j	800010d2 <allocproc+0x7c>
    freeproc(p);
    800010f0:	8526                	mv	a0,s1
    800010f2:	f15ff0ef          	jal	80001006 <freeproc>
    release(&p->lock);
    800010f6:	8526                	mv	a0,s1
    800010f8:	5df040ef          	jal	80005ed6 <release>
    return 0;
    800010fc:	84ca                	mv	s1,s2
    800010fe:	bfd1                	j	800010d2 <allocproc+0x7c>

0000000080001100 <userinit>:
{
    80001100:	1101                	addi	sp,sp,-32
    80001102:	ec06                	sd	ra,24(sp)
    80001104:	e822                	sd	s0,16(sp)
    80001106:	e426                	sd	s1,8(sp)
    80001108:	1000                	addi	s0,sp,32
  p = allocproc();
    8000110a:	f4dff0ef          	jal	80001056 <allocproc>
    8000110e:	84aa                	mv	s1,a0
  initproc = p;
    80001110:	00008797          	auipc	a5,0x8
    80001114:	bca7b823          	sd	a0,-1072(a5) # 80008ce0 <initproc>
  p->cwd = namei("/");
    80001118:	00007517          	auipc	a0,0x7
    8000111c:	01850513          	addi	a0,a0,24 # 80008130 <etext+0x130>
    80001120:	6a3010ef          	jal	80002fc2 <namei>
    80001124:	14a4bc23          	sd	a0,344(s1)
  p->state = RUNNABLE;
    80001128:	478d                	li	a5,3
    8000112a:	d09c                	sw	a5,32(s1)
  release(&p->lock);
    8000112c:	8526                	mv	a0,s1
    8000112e:	5a9040ef          	jal	80005ed6 <release>
}
    80001132:	60e2                	ld	ra,24(sp)
    80001134:	6442                	ld	s0,16(sp)
    80001136:	64a2                	ld	s1,8(sp)
    80001138:	6105                	addi	sp,sp,32
    8000113a:	8082                	ret

000000008000113c <growproc>:
{
    8000113c:	1101                	addi	sp,sp,-32
    8000113e:	ec06                	sd	ra,24(sp)
    80001140:	e822                	sd	s0,16(sp)
    80001142:	e426                	sd	s1,8(sp)
    80001144:	e04a                	sd	s2,0(sp)
    80001146:	1000                	addi	s0,sp,32
    80001148:	892a                	mv	s2,a0
  struct proc *p = myproc();
    8000114a:	cebff0ef          	jal	80000e34 <myproc>
    8000114e:	84aa                	mv	s1,a0
  sz = p->sz;
    80001150:	692c                	ld	a1,80(a0)
  if(n > 0){
    80001152:	01204c63          	bgtz	s2,8000116a <growproc+0x2e>
  } else if(n < 0){
    80001156:	02094463          	bltz	s2,8000117e <growproc+0x42>
  p->sz = sz;
    8000115a:	e8ac                	sd	a1,80(s1)
  return 0;
    8000115c:	4501                	li	a0,0
}
    8000115e:	60e2                	ld	ra,24(sp)
    80001160:	6442                	ld	s0,16(sp)
    80001162:	64a2                	ld	s1,8(sp)
    80001164:	6902                	ld	s2,0(sp)
    80001166:	6105                	addi	sp,sp,32
    80001168:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    8000116a:	4691                	li	a3,4
    8000116c:	00b90633          	add	a2,s2,a1
    80001170:	6d28                	ld	a0,88(a0)
    80001172:	ebcff0ef          	jal	8000082e <uvmalloc>
    80001176:	85aa                	mv	a1,a0
    80001178:	f16d                	bnez	a0,8000115a <growproc+0x1e>
      return -1;
    8000117a:	557d                	li	a0,-1
    8000117c:	b7cd                	j	8000115e <growproc+0x22>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    8000117e:	00b90633          	add	a2,s2,a1
    80001182:	6d28                	ld	a0,88(a0)
    80001184:	e64ff0ef          	jal	800007e8 <uvmdealloc>
    80001188:	85aa                	mv	a1,a0
    8000118a:	bfc1                	j	8000115a <growproc+0x1e>

000000008000118c <kfork>:
{
    8000118c:	7139                	addi	sp,sp,-64
    8000118e:	fc06                	sd	ra,56(sp)
    80001190:	f822                	sd	s0,48(sp)
    80001192:	f426                	sd	s1,40(sp)
    80001194:	e456                	sd	s5,8(sp)
    80001196:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001198:	c9dff0ef          	jal	80000e34 <myproc>
    8000119c:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    8000119e:	eb9ff0ef          	jal	80001056 <allocproc>
    800011a2:	c92d                	beqz	a0,80001214 <kfork+0x88>
    800011a4:	e852                	sd	s4,16(sp)
    800011a6:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    800011a8:	050ab603          	ld	a2,80(s5)
    800011ac:	6d2c                	ld	a1,88(a0)
    800011ae:	058ab503          	ld	a0,88(s5)
    800011b2:	faaff0ef          	jal	8000095c <uvmcopy>
    800011b6:	04054863          	bltz	a0,80001206 <kfork+0x7a>
    800011ba:	f04a                	sd	s2,32(sp)
    800011bc:	ec4e                	sd	s3,24(sp)
  np->sz = p->sz;
    800011be:	050ab783          	ld	a5,80(s5)
    800011c2:	04fa3823          	sd	a5,80(s4)
  *(np->trapframe) = *(p->trapframe);
    800011c6:	060ab683          	ld	a3,96(s5)
    800011ca:	87b6                	mv	a5,a3
    800011cc:	060a3703          	ld	a4,96(s4)
    800011d0:	12068693          	addi	a3,a3,288
    800011d4:	6388                	ld	a0,0(a5)
    800011d6:	678c                	ld	a1,8(a5)
    800011d8:	6b90                	ld	a2,16(a5)
    800011da:	e308                	sd	a0,0(a4)
    800011dc:	e70c                	sd	a1,8(a4)
    800011de:	eb10                	sd	a2,16(a4)
    800011e0:	6f90                	ld	a2,24(a5)
    800011e2:	ef10                	sd	a2,24(a4)
    800011e4:	02078793          	addi	a5,a5,32
    800011e8:	02070713          	addi	a4,a4,32 # 1020 <_entry-0x7fffefe0>
    800011ec:	fed794e3          	bne	a5,a3,800011d4 <kfork+0x48>
  np->trapframe->a0 = 0;
    800011f0:	060a3783          	ld	a5,96(s4)
    800011f4:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    800011f8:	0d8a8493          	addi	s1,s5,216
    800011fc:	0d8a0913          	addi	s2,s4,216
    80001200:	158a8993          	addi	s3,s5,344
    80001204:	a831                	j	80001220 <kfork+0x94>
    freeproc(np);
    80001206:	8552                	mv	a0,s4
    80001208:	dffff0ef          	jal	80001006 <freeproc>
    release(&np->lock);
    8000120c:	8552                	mv	a0,s4
    8000120e:	4c9040ef          	jal	80005ed6 <release>
    return -1;
    80001212:	6a42                	ld	s4,16(sp)
    return -1;
    80001214:	54fd                	li	s1,-1
    80001216:	a885                	j	80001286 <kfork+0xfa>
  for(i = 0; i < NOFILE; i++)
    80001218:	04a1                	addi	s1,s1,8
    8000121a:	0921                	addi	s2,s2,8
    8000121c:	01348963          	beq	s1,s3,8000122e <kfork+0xa2>
    if(p->ofile[i])
    80001220:	6088                	ld	a0,0(s1)
    80001222:	d97d                	beqz	a0,80001218 <kfork+0x8c>
      np->ofile[i] = filedup(p->ofile[i]);
    80001224:	356020ef          	jal	8000357a <filedup>
    80001228:	00a93023          	sd	a0,0(s2)
    8000122c:	b7f5                	j	80001218 <kfork+0x8c>
  np->cwd = idup(p->cwd);
    8000122e:	158ab503          	ld	a0,344(s5)
    80001232:	516010ef          	jal	80002748 <idup>
    80001236:	14aa3c23          	sd	a0,344(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    8000123a:	4641                	li	a2,16
    8000123c:	160a8593          	addi	a1,s5,352
    80001240:	160a0513          	addi	a0,s4,352
    80001244:	93cff0ef          	jal	80000380 <safestrcpy>
  pid = np->pid;
    80001248:	038a2483          	lw	s1,56(s4)
  release(&np->lock);
    8000124c:	8552                	mv	a0,s4
    8000124e:	489040ef          	jal	80005ed6 <release>
  acquire(&wait_lock);
    80001252:	00008517          	auipc	a0,0x8
    80001256:	c6e50513          	addi	a0,a0,-914 # 80008ec0 <wait_lock>
    8000125a:	341040ef          	jal	80005d9a <acquire>
  np->parent = p;
    8000125e:	055a3023          	sd	s5,64(s4)
  release(&wait_lock);
    80001262:	00008517          	auipc	a0,0x8
    80001266:	c5e50513          	addi	a0,a0,-930 # 80008ec0 <wait_lock>
    8000126a:	46d040ef          	jal	80005ed6 <release>
  acquire(&np->lock);
    8000126e:	8552                	mv	a0,s4
    80001270:	32b040ef          	jal	80005d9a <acquire>
  np->state = RUNNABLE;
    80001274:	478d                	li	a5,3
    80001276:	02fa2023          	sw	a5,32(s4)
  release(&np->lock);
    8000127a:	8552                	mv	a0,s4
    8000127c:	45b040ef          	jal	80005ed6 <release>
    80001280:	7902                	ld	s2,32(sp)
    80001282:	69e2                	ld	s3,24(sp)
    80001284:	6a42                	ld	s4,16(sp)
}
    80001286:	8526                	mv	a0,s1
    80001288:	70e2                	ld	ra,56(sp)
    8000128a:	7442                	ld	s0,48(sp)
    8000128c:	74a2                	ld	s1,40(sp)
    8000128e:	6aa2                	ld	s5,8(sp)
    80001290:	6121                	addi	sp,sp,64
    80001292:	8082                	ret

0000000080001294 <scheduler>:
{
    80001294:	715d                	addi	sp,sp,-80
    80001296:	e486                	sd	ra,72(sp)
    80001298:	e0a2                	sd	s0,64(sp)
    8000129a:	fc26                	sd	s1,56(sp)
    8000129c:	f84a                	sd	s2,48(sp)
    8000129e:	f44e                	sd	s3,40(sp)
    800012a0:	f052                	sd	s4,32(sp)
    800012a2:	ec56                	sd	s5,24(sp)
    800012a4:	e85a                	sd	s6,16(sp)
    800012a6:	e45e                	sd	s7,8(sp)
    800012a8:	e062                	sd	s8,0(sp)
    800012aa:	0880                	addi	s0,sp,80
    800012ac:	8792                	mv	a5,tp
  int id = r_tp();
    800012ae:	2781                	sext.w	a5,a5
  struct cpu *c = &cpus[id];
    800012b0:	00779713          	slli	a4,a5,0x7
    800012b4:	00008a17          	auipc	s4,0x8
    800012b8:	c2ca0a13          	addi	s4,s4,-980 # 80008ee0 <cpus>
    800012bc:	9a3a                	add	s4,s4,a4
  c->proc = 0;
    800012be:	00008697          	auipc	a3,0x8
    800012c2:	be268693          	addi	a3,a3,-1054 # 80008ea0 <pid_lock>
    800012c6:	96ba                	add	a3,a3,a4
    800012c8:	0406b023          	sd	zero,64(a3)
        swtch(&c->context, &p->context);
    800012cc:	00008b97          	auipc	s7,0x8
    800012d0:	c1cb8b93          	addi	s7,s7,-996 # 80008ee8 <cpus+0x8>
    800012d4:	9bba                	add	s7,s7,a4
      if(p->state == RUNNABLE) {
    800012d6:	4a8d                	li	s5,3
        p->state = RUNNING;
    800012d8:	4c11                	li	s8,4
        c->proc = p;
    800012da:	8b36                	mv	s6,a3
    800012dc:	a005                	j	800012fc <scheduler+0x68>
        release(&p->lock);
    800012de:	8526                	mv	a0,s1
    800012e0:	3f7040ef          	jal	80005ed6 <release>
        continue;
    800012e4:	a8b1                	j	80001340 <scheduler+0xac>
    if(nproc <= 2) {   // only init and sh exist
    800012e6:	4789                	li	a5,2
    800012e8:	0127ca63          	blt	a5,s2,800012fc <scheduler+0x68>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800012ec:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800012f0:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800012f4:	10079073          	csrw	sstatus,a5
      asm volatile("wfi");
    800012f8:	10500073          	wfi
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800012fc:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001300:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001304:	10079073          	csrw	sstatus,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001308:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    8000130c:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000130e:	10079073          	csrw	sstatus,a5
    int nproc = 0;
    80001312:	4901                	li	s2,0
    for(p = proc; p < &proc[NPROC]; p++) {
    80001314:	00008497          	auipc	s1,0x8
    80001318:	fcc48493          	addi	s1,s1,-52 # 800092e0 <proc>
    8000131c:	0000e997          	auipc	s3,0xe
    80001320:	dc498993          	addi	s3,s3,-572 # 8000f0e0 <tickslock>
    80001324:	a015                	j	80001348 <scheduler+0xb4>
      if(p->pincpu && p->pincpu != c) {
    80001326:	1704b703          	ld	a4,368(s1)
    8000132a:	414707b3          	sub	a5,a4,s4
    8000132e:	00f037b3          	snez	a5,a5
    80001332:	00e03733          	snez	a4,a4
    80001336:	8ff9                	and	a5,a5,a4
    80001338:	f3dd                	bnez	a5,800012de <scheduler+0x4a>
      release(&p->lock);
    8000133a:	8526                	mv	a0,s1
    8000133c:	39b040ef          	jal	80005ed6 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80001340:	17848493          	addi	s1,s1,376
    80001344:	fb3481e3          	beq	s1,s3,800012e6 <scheduler+0x52>
      acquire(&p->lock);
    80001348:	8526                	mv	a0,s1
    8000134a:	251040ef          	jal	80005d9a <acquire>
      if(p->state != UNUSED) {
    8000134e:	5098                	lw	a4,32(s1)
    80001350:	db79                	beqz	a4,80001326 <scheduler+0x92>
        nproc++;
    80001352:	2905                	addiw	s2,s2,1
      if(p->pincpu && p->pincpu != c) {
    80001354:	1704b783          	ld	a5,368(s1)
    80001358:	00f036b3          	snez	a3,a5
    8000135c:	414787b3          	sub	a5,a5,s4
    80001360:	00f037b3          	snez	a5,a5
    80001364:	8ff5                	and	a5,a5,a3
    80001366:	ffa5                	bnez	a5,800012de <scheduler+0x4a>
      if(p->state == RUNNABLE) {
    80001368:	fd5719e3          	bne	a4,s5,8000133a <scheduler+0xa6>
        p->state = RUNNING;
    8000136c:	0384a023          	sw	s8,32(s1)
        c->proc = p;
    80001370:	049b3023          	sd	s1,64(s6)
        swtch(&c->context, &p->context);
    80001374:	06848593          	addi	a1,s1,104
    80001378:	855e                	mv	a0,s7
    8000137a:	57c000ef          	jal	800018f6 <swtch>
        c->proc = 0;
    8000137e:	040b3023          	sd	zero,64(s6)
    80001382:	bf65                	j	8000133a <scheduler+0xa6>

0000000080001384 <sched>:
{
    80001384:	7179                	addi	sp,sp,-48
    80001386:	f406                	sd	ra,40(sp)
    80001388:	f022                	sd	s0,32(sp)
    8000138a:	ec26                	sd	s1,24(sp)
    8000138c:	e84a                	sd	s2,16(sp)
    8000138e:	e44e                	sd	s3,8(sp)
    80001390:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001392:	aa3ff0ef          	jal	80000e34 <myproc>
    80001396:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001398:	193040ef          	jal	80005d2a <holding>
    8000139c:	c92d                	beqz	a0,8000140e <sched+0x8a>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000139e:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    800013a0:	2781                	sext.w	a5,a5
    800013a2:	079e                	slli	a5,a5,0x7
    800013a4:	00008717          	auipc	a4,0x8
    800013a8:	afc70713          	addi	a4,a4,-1284 # 80008ea0 <pid_lock>
    800013ac:	97ba                	add	a5,a5,a4
    800013ae:	0b87a703          	lw	a4,184(a5)
    800013b2:	4785                	li	a5,1
    800013b4:	06f71363          	bne	a4,a5,8000141a <sched+0x96>
  if(p->state == RUNNING)
    800013b8:	5098                	lw	a4,32(s1)
    800013ba:	4791                	li	a5,4
    800013bc:	06f70563          	beq	a4,a5,80001426 <sched+0xa2>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800013c0:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800013c4:	8b89                	andi	a5,a5,2
  if(intr_get())
    800013c6:	e7b5                	bnez	a5,80001432 <sched+0xae>
  asm volatile("mv %0, tp" : "=r" (x) );
    800013c8:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    800013ca:	00008917          	auipc	s2,0x8
    800013ce:	ad690913          	addi	s2,s2,-1322 # 80008ea0 <pid_lock>
    800013d2:	2781                	sext.w	a5,a5
    800013d4:	079e                	slli	a5,a5,0x7
    800013d6:	97ca                	add	a5,a5,s2
    800013d8:	0bc7a983          	lw	s3,188(a5)
    800013dc:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800013de:	2781                	sext.w	a5,a5
    800013e0:	079e                	slli	a5,a5,0x7
    800013e2:	00008597          	auipc	a1,0x8
    800013e6:	b0658593          	addi	a1,a1,-1274 # 80008ee8 <cpus+0x8>
    800013ea:	95be                	add	a1,a1,a5
    800013ec:	06848513          	addi	a0,s1,104
    800013f0:	506000ef          	jal	800018f6 <swtch>
    800013f4:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    800013f6:	2781                	sext.w	a5,a5
    800013f8:	079e                	slli	a5,a5,0x7
    800013fa:	993e                	add	s2,s2,a5
    800013fc:	0b392e23          	sw	s3,188(s2)
}
    80001400:	70a2                	ld	ra,40(sp)
    80001402:	7402                	ld	s0,32(sp)
    80001404:	64e2                	ld	s1,24(sp)
    80001406:	6942                	ld	s2,16(sp)
    80001408:	69a2                	ld	s3,8(sp)
    8000140a:	6145                	addi	sp,sp,48
    8000140c:	8082                	ret
    panic("sched p->lock");
    8000140e:	00007517          	auipc	a0,0x7
    80001412:	d2a50513          	addi	a0,a0,-726 # 80008138 <etext+0x138>
    80001416:	648040ef          	jal	80005a5e <panic>
    panic("sched locks");
    8000141a:	00007517          	auipc	a0,0x7
    8000141e:	d2e50513          	addi	a0,a0,-722 # 80008148 <etext+0x148>
    80001422:	63c040ef          	jal	80005a5e <panic>
    panic("sched RUNNING");
    80001426:	00007517          	auipc	a0,0x7
    8000142a:	d3250513          	addi	a0,a0,-718 # 80008158 <etext+0x158>
    8000142e:	630040ef          	jal	80005a5e <panic>
    panic("sched interruptible");
    80001432:	00007517          	auipc	a0,0x7
    80001436:	d3650513          	addi	a0,a0,-714 # 80008168 <etext+0x168>
    8000143a:	624040ef          	jal	80005a5e <panic>

000000008000143e <yield>:
{
    8000143e:	1101                	addi	sp,sp,-32
    80001440:	ec06                	sd	ra,24(sp)
    80001442:	e822                	sd	s0,16(sp)
    80001444:	e426                	sd	s1,8(sp)
    80001446:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80001448:	9edff0ef          	jal	80000e34 <myproc>
    8000144c:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000144e:	14d040ef          	jal	80005d9a <acquire>
  p->state = RUNNABLE;
    80001452:	478d                	li	a5,3
    80001454:	d09c                	sw	a5,32(s1)
  sched();
    80001456:	f2fff0ef          	jal	80001384 <sched>
  release(&p->lock);
    8000145a:	8526                	mv	a0,s1
    8000145c:	27b040ef          	jal	80005ed6 <release>
}
    80001460:	60e2                	ld	ra,24(sp)
    80001462:	6442                	ld	s0,16(sp)
    80001464:	64a2                	ld	s1,8(sp)
    80001466:	6105                	addi	sp,sp,32
    80001468:	8082                	ret

000000008000146a <sleep>:

// Sleep on channel chan, releasing condition lock lk.
// Re-acquires lk when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    8000146a:	7179                	addi	sp,sp,-48
    8000146c:	f406                	sd	ra,40(sp)
    8000146e:	f022                	sd	s0,32(sp)
    80001470:	ec26                	sd	s1,24(sp)
    80001472:	e84a                	sd	s2,16(sp)
    80001474:	e44e                	sd	s3,8(sp)
    80001476:	1800                	addi	s0,sp,48
    80001478:	89aa                	mv	s3,a0
    8000147a:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000147c:	9b9ff0ef          	jal	80000e34 <myproc>
    80001480:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80001482:	119040ef          	jal	80005d9a <acquire>
  release(lk);
    80001486:	854a                	mv	a0,s2
    80001488:	24f040ef          	jal	80005ed6 <release>

  // Go to sleep.
  p->chan = chan;
    8000148c:	0334b423          	sd	s3,40(s1)
  p->state = SLEEPING;
    80001490:	4789                	li	a5,2
    80001492:	d09c                	sw	a5,32(s1)

  sched();
    80001494:	ef1ff0ef          	jal	80001384 <sched>

  // Tidy up.
  p->chan = 0;
    80001498:	0204b423          	sd	zero,40(s1)

  // Reacquire original lock.
  release(&p->lock);
    8000149c:	8526                	mv	a0,s1
    8000149e:	239040ef          	jal	80005ed6 <release>
  acquire(lk);
    800014a2:	854a                	mv	a0,s2
    800014a4:	0f7040ef          	jal	80005d9a <acquire>
}
    800014a8:	70a2                	ld	ra,40(sp)
    800014aa:	7402                	ld	s0,32(sp)
    800014ac:	64e2                	ld	s1,24(sp)
    800014ae:	6942                	ld	s2,16(sp)
    800014b0:	69a2                	ld	s3,8(sp)
    800014b2:	6145                	addi	sp,sp,48
    800014b4:	8082                	ret

00000000800014b6 <wakeup>:

// Wake up all processes sleeping on channel chan.
// Caller should hold the condition lock.
void
wakeup(void *chan)
{
    800014b6:	7139                	addi	sp,sp,-64
    800014b8:	fc06                	sd	ra,56(sp)
    800014ba:	f822                	sd	s0,48(sp)
    800014bc:	f426                	sd	s1,40(sp)
    800014be:	f04a                	sd	s2,32(sp)
    800014c0:	ec4e                	sd	s3,24(sp)
    800014c2:	e852                	sd	s4,16(sp)
    800014c4:	e456                	sd	s5,8(sp)
    800014c6:	0080                	addi	s0,sp,64
    800014c8:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800014ca:	00008497          	auipc	s1,0x8
    800014ce:	e1648493          	addi	s1,s1,-490 # 800092e0 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    800014d2:	4989                	li	s3,2
        p->state = RUNNABLE;
    800014d4:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    800014d6:	0000e917          	auipc	s2,0xe
    800014da:	c0a90913          	addi	s2,s2,-1014 # 8000f0e0 <tickslock>
    800014de:	a801                	j	800014ee <wakeup+0x38>
      }
      release(&p->lock);
    800014e0:	8526                	mv	a0,s1
    800014e2:	1f5040ef          	jal	80005ed6 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800014e6:	17848493          	addi	s1,s1,376
    800014ea:	03248263          	beq	s1,s2,8000150e <wakeup+0x58>
    if(p != myproc()){
    800014ee:	947ff0ef          	jal	80000e34 <myproc>
    800014f2:	fe950ae3          	beq	a0,s1,800014e6 <wakeup+0x30>
      acquire(&p->lock);
    800014f6:	8526                	mv	a0,s1
    800014f8:	0a3040ef          	jal	80005d9a <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800014fc:	509c                	lw	a5,32(s1)
    800014fe:	ff3791e3          	bne	a5,s3,800014e0 <wakeup+0x2a>
    80001502:	749c                	ld	a5,40(s1)
    80001504:	fd479ee3          	bne	a5,s4,800014e0 <wakeup+0x2a>
        p->state = RUNNABLE;
    80001508:	0354a023          	sw	s5,32(s1)
    8000150c:	bfd1                	j	800014e0 <wakeup+0x2a>
    }
  }
}
    8000150e:	70e2                	ld	ra,56(sp)
    80001510:	7442                	ld	s0,48(sp)
    80001512:	74a2                	ld	s1,40(sp)
    80001514:	7902                	ld	s2,32(sp)
    80001516:	69e2                	ld	s3,24(sp)
    80001518:	6a42                	ld	s4,16(sp)
    8000151a:	6aa2                	ld	s5,8(sp)
    8000151c:	6121                	addi	sp,sp,64
    8000151e:	8082                	ret

0000000080001520 <reparent>:
{
    80001520:	7179                	addi	sp,sp,-48
    80001522:	f406                	sd	ra,40(sp)
    80001524:	f022                	sd	s0,32(sp)
    80001526:	ec26                	sd	s1,24(sp)
    80001528:	e84a                	sd	s2,16(sp)
    8000152a:	e44e                	sd	s3,8(sp)
    8000152c:	e052                	sd	s4,0(sp)
    8000152e:	1800                	addi	s0,sp,48
    80001530:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001532:	00008497          	auipc	s1,0x8
    80001536:	dae48493          	addi	s1,s1,-594 # 800092e0 <proc>
      pp->parent = initproc;
    8000153a:	00007a17          	auipc	s4,0x7
    8000153e:	7a6a0a13          	addi	s4,s4,1958 # 80008ce0 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001542:	0000e997          	auipc	s3,0xe
    80001546:	b9e98993          	addi	s3,s3,-1122 # 8000f0e0 <tickslock>
    8000154a:	a029                	j	80001554 <reparent+0x34>
    8000154c:	17848493          	addi	s1,s1,376
    80001550:	01348b63          	beq	s1,s3,80001566 <reparent+0x46>
    if(pp->parent == p){
    80001554:	60bc                	ld	a5,64(s1)
    80001556:	ff279be3          	bne	a5,s2,8000154c <reparent+0x2c>
      pp->parent = initproc;
    8000155a:	000a3503          	ld	a0,0(s4)
    8000155e:	e0a8                	sd	a0,64(s1)
      wakeup(initproc);
    80001560:	f57ff0ef          	jal	800014b6 <wakeup>
    80001564:	b7e5                	j	8000154c <reparent+0x2c>
}
    80001566:	70a2                	ld	ra,40(sp)
    80001568:	7402                	ld	s0,32(sp)
    8000156a:	64e2                	ld	s1,24(sp)
    8000156c:	6942                	ld	s2,16(sp)
    8000156e:	69a2                	ld	s3,8(sp)
    80001570:	6a02                	ld	s4,0(sp)
    80001572:	6145                	addi	sp,sp,48
    80001574:	8082                	ret

0000000080001576 <kexit>:
{
    80001576:	7179                	addi	sp,sp,-48
    80001578:	f406                	sd	ra,40(sp)
    8000157a:	f022                	sd	s0,32(sp)
    8000157c:	ec26                	sd	s1,24(sp)
    8000157e:	e84a                	sd	s2,16(sp)
    80001580:	e44e                	sd	s3,8(sp)
    80001582:	e052                	sd	s4,0(sp)
    80001584:	1800                	addi	s0,sp,48
    80001586:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80001588:	8adff0ef          	jal	80000e34 <myproc>
    8000158c:	89aa                	mv	s3,a0
  if(p == initproc)
    8000158e:	00007797          	auipc	a5,0x7
    80001592:	7527b783          	ld	a5,1874(a5) # 80008ce0 <initproc>
    80001596:	0d850493          	addi	s1,a0,216
    8000159a:	15850913          	addi	s2,a0,344
    8000159e:	00a79b63          	bne	a5,a0,800015b4 <kexit+0x3e>
    panic("init exiting");
    800015a2:	00007517          	auipc	a0,0x7
    800015a6:	bde50513          	addi	a0,a0,-1058 # 80008180 <etext+0x180>
    800015aa:	4b4040ef          	jal	80005a5e <panic>
  for(int fd = 0; fd < NOFILE; fd++){
    800015ae:	04a1                	addi	s1,s1,8
    800015b0:	01248963          	beq	s1,s2,800015c2 <kexit+0x4c>
    if(p->ofile[fd]){
    800015b4:	6088                	ld	a0,0(s1)
    800015b6:	dd65                	beqz	a0,800015ae <kexit+0x38>
      fileclose(f);
    800015b8:	008020ef          	jal	800035c0 <fileclose>
      p->ofile[fd] = 0;
    800015bc:	0004b023          	sd	zero,0(s1)
    800015c0:	b7fd                	j	800015ae <kexit+0x38>
  begin_op();
    800015c2:	3df010ef          	jal	800031a0 <begin_op>
  iput(p->cwd);
    800015c6:	1589b503          	ld	a0,344(s3)
    800015ca:	342010ef          	jal	8000290c <iput>
  end_op();
    800015ce:	443010ef          	jal	80003210 <end_op>
  p->cwd = 0;
    800015d2:	1409bc23          	sd	zero,344(s3)
  acquire(&wait_lock);
    800015d6:	00008517          	auipc	a0,0x8
    800015da:	8ea50513          	addi	a0,a0,-1814 # 80008ec0 <wait_lock>
    800015de:	7bc040ef          	jal	80005d9a <acquire>
  reparent(p);
    800015e2:	854e                	mv	a0,s3
    800015e4:	f3dff0ef          	jal	80001520 <reparent>
  wakeup(p->parent);
    800015e8:	0409b503          	ld	a0,64(s3)
    800015ec:	ecbff0ef          	jal	800014b6 <wakeup>
  acquire(&p->lock);
    800015f0:	854e                	mv	a0,s3
    800015f2:	7a8040ef          	jal	80005d9a <acquire>
  p->xstate = status;
    800015f6:	0349aa23          	sw	s4,52(s3)
  p->state = ZOMBIE;
    800015fa:	4795                	li	a5,5
    800015fc:	02f9a023          	sw	a5,32(s3)
  release(&wait_lock);
    80001600:	00008517          	auipc	a0,0x8
    80001604:	8c050513          	addi	a0,a0,-1856 # 80008ec0 <wait_lock>
    80001608:	0cf040ef          	jal	80005ed6 <release>
  sched();
    8000160c:	d79ff0ef          	jal	80001384 <sched>
  panic("zombie exit");
    80001610:	00007517          	auipc	a0,0x7
    80001614:	b8050513          	addi	a0,a0,-1152 # 80008190 <etext+0x190>
    80001618:	446040ef          	jal	80005a5e <panic>

000000008000161c <kkill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kkill(int pid)
{
    8000161c:	7179                	addi	sp,sp,-48
    8000161e:	f406                	sd	ra,40(sp)
    80001620:	f022                	sd	s0,32(sp)
    80001622:	ec26                	sd	s1,24(sp)
    80001624:	e84a                	sd	s2,16(sp)
    80001626:	e44e                	sd	s3,8(sp)
    80001628:	1800                	addi	s0,sp,48
    8000162a:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    8000162c:	00008497          	auipc	s1,0x8
    80001630:	cb448493          	addi	s1,s1,-844 # 800092e0 <proc>
    80001634:	0000e997          	auipc	s3,0xe
    80001638:	aac98993          	addi	s3,s3,-1364 # 8000f0e0 <tickslock>
    acquire(&p->lock);
    8000163c:	8526                	mv	a0,s1
    8000163e:	75c040ef          	jal	80005d9a <acquire>
    if(p->pid == pid){
    80001642:	5c9c                	lw	a5,56(s1)
    80001644:	01278b63          	beq	a5,s2,8000165a <kkill+0x3e>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80001648:	8526                	mv	a0,s1
    8000164a:	08d040ef          	jal	80005ed6 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    8000164e:	17848493          	addi	s1,s1,376
    80001652:	ff3495e3          	bne	s1,s3,8000163c <kkill+0x20>
  }
  return -1;
    80001656:	557d                	li	a0,-1
    80001658:	a819                	j	8000166e <kkill+0x52>
      p->killed = 1;
    8000165a:	4785                	li	a5,1
    8000165c:	d89c                	sw	a5,48(s1)
      if(p->state == SLEEPING){
    8000165e:	5098                	lw	a4,32(s1)
    80001660:	4789                	li	a5,2
    80001662:	00f70d63          	beq	a4,a5,8000167c <kkill+0x60>
      release(&p->lock);
    80001666:	8526                	mv	a0,s1
    80001668:	06f040ef          	jal	80005ed6 <release>
      return 0;
    8000166c:	4501                	li	a0,0
}
    8000166e:	70a2                	ld	ra,40(sp)
    80001670:	7402                	ld	s0,32(sp)
    80001672:	64e2                	ld	s1,24(sp)
    80001674:	6942                	ld	s2,16(sp)
    80001676:	69a2                	ld	s3,8(sp)
    80001678:	6145                	addi	sp,sp,48
    8000167a:	8082                	ret
        p->state = RUNNABLE;
    8000167c:	478d                	li	a5,3
    8000167e:	d09c                	sw	a5,32(s1)
    80001680:	b7dd                	j	80001666 <kkill+0x4a>

0000000080001682 <setkilled>:

void
setkilled(struct proc *p)
{
    80001682:	1101                	addi	sp,sp,-32
    80001684:	ec06                	sd	ra,24(sp)
    80001686:	e822                	sd	s0,16(sp)
    80001688:	e426                	sd	s1,8(sp)
    8000168a:	1000                	addi	s0,sp,32
    8000168c:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000168e:	70c040ef          	jal	80005d9a <acquire>
  p->killed = 1;
    80001692:	4785                	li	a5,1
    80001694:	d89c                	sw	a5,48(s1)
  release(&p->lock);
    80001696:	8526                	mv	a0,s1
    80001698:	03f040ef          	jal	80005ed6 <release>
}
    8000169c:	60e2                	ld	ra,24(sp)
    8000169e:	6442                	ld	s0,16(sp)
    800016a0:	64a2                	ld	s1,8(sp)
    800016a2:	6105                	addi	sp,sp,32
    800016a4:	8082                	ret

00000000800016a6 <killed>:

int
killed(struct proc *p)
{
    800016a6:	1101                	addi	sp,sp,-32
    800016a8:	ec06                	sd	ra,24(sp)
    800016aa:	e822                	sd	s0,16(sp)
    800016ac:	e426                	sd	s1,8(sp)
    800016ae:	e04a                	sd	s2,0(sp)
    800016b0:	1000                	addi	s0,sp,32
    800016b2:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    800016b4:	6e6040ef          	jal	80005d9a <acquire>
  k = p->killed;
    800016b8:	589c                	lw	a5,48(s1)
    800016ba:	893e                	mv	s2,a5
  release(&p->lock);
    800016bc:	8526                	mv	a0,s1
    800016be:	019040ef          	jal	80005ed6 <release>
  return k;
}
    800016c2:	854a                	mv	a0,s2
    800016c4:	60e2                	ld	ra,24(sp)
    800016c6:	6442                	ld	s0,16(sp)
    800016c8:	64a2                	ld	s1,8(sp)
    800016ca:	6902                	ld	s2,0(sp)
    800016cc:	6105                	addi	sp,sp,32
    800016ce:	8082                	ret

00000000800016d0 <kwait>:
{
    800016d0:	715d                	addi	sp,sp,-80
    800016d2:	e486                	sd	ra,72(sp)
    800016d4:	e0a2                	sd	s0,64(sp)
    800016d6:	fc26                	sd	s1,56(sp)
    800016d8:	f84a                	sd	s2,48(sp)
    800016da:	f44e                	sd	s3,40(sp)
    800016dc:	f052                	sd	s4,32(sp)
    800016de:	ec56                	sd	s5,24(sp)
    800016e0:	e85a                	sd	s6,16(sp)
    800016e2:	e45e                	sd	s7,8(sp)
    800016e4:	0880                	addi	s0,sp,80
    800016e6:	8baa                	mv	s7,a0
  struct proc *p = myproc();
    800016e8:	f4cff0ef          	jal	80000e34 <myproc>
    800016ec:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800016ee:	00007517          	auipc	a0,0x7
    800016f2:	7d250513          	addi	a0,a0,2002 # 80008ec0 <wait_lock>
    800016f6:	6a4040ef          	jal	80005d9a <acquire>
        if(pp->state == ZOMBIE){
    800016fa:	4a15                	li	s4,5
        havekids = 1;
    800016fc:	4a85                	li	s5,1
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800016fe:	0000e997          	auipc	s3,0xe
    80001702:	9e298993          	addi	s3,s3,-1566 # 8000f0e0 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001706:	00007b17          	auipc	s6,0x7
    8000170a:	7bab0b13          	addi	s6,s6,1978 # 80008ec0 <wait_lock>
    8000170e:	a861                	j	800017a6 <kwait+0xd6>
          pid = pp->pid;
    80001710:	0384a983          	lw	s3,56(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    80001714:	000b8c63          	beqz	s7,8000172c <kwait+0x5c>
    80001718:	4691                	li	a3,4
    8000171a:	03448613          	addi	a2,s1,52
    8000171e:	85de                	mv	a1,s7
    80001720:	05893503          	ld	a0,88(s2)
    80001724:	c54ff0ef          	jal	80000b78 <copyout>
    80001728:	02054a63          	bltz	a0,8000175c <kwait+0x8c>
          freeproc(pp);
    8000172c:	8526                	mv	a0,s1
    8000172e:	8d9ff0ef          	jal	80001006 <freeproc>
          release(&pp->lock);
    80001732:	8526                	mv	a0,s1
    80001734:	7a2040ef          	jal	80005ed6 <release>
          release(&wait_lock);
    80001738:	00007517          	auipc	a0,0x7
    8000173c:	78850513          	addi	a0,a0,1928 # 80008ec0 <wait_lock>
    80001740:	796040ef          	jal	80005ed6 <release>
}
    80001744:	854e                	mv	a0,s3
    80001746:	60a6                	ld	ra,72(sp)
    80001748:	6406                	ld	s0,64(sp)
    8000174a:	74e2                	ld	s1,56(sp)
    8000174c:	7942                	ld	s2,48(sp)
    8000174e:	79a2                	ld	s3,40(sp)
    80001750:	7a02                	ld	s4,32(sp)
    80001752:	6ae2                	ld	s5,24(sp)
    80001754:	6b42                	ld	s6,16(sp)
    80001756:	6ba2                	ld	s7,8(sp)
    80001758:	6161                	addi	sp,sp,80
    8000175a:	8082                	ret
            release(&pp->lock);
    8000175c:	8526                	mv	a0,s1
    8000175e:	778040ef          	jal	80005ed6 <release>
            release(&wait_lock);
    80001762:	00007517          	auipc	a0,0x7
    80001766:	75e50513          	addi	a0,a0,1886 # 80008ec0 <wait_lock>
    8000176a:	76c040ef          	jal	80005ed6 <release>
            return -1;
    8000176e:	a881                	j	800017be <kwait+0xee>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001770:	17848493          	addi	s1,s1,376
    80001774:	03348063          	beq	s1,s3,80001794 <kwait+0xc4>
      if(pp->parent == p){
    80001778:	60bc                	ld	a5,64(s1)
    8000177a:	ff279be3          	bne	a5,s2,80001770 <kwait+0xa0>
        acquire(&pp->lock);
    8000177e:	8526                	mv	a0,s1
    80001780:	61a040ef          	jal	80005d9a <acquire>
        if(pp->state == ZOMBIE){
    80001784:	509c                	lw	a5,32(s1)
    80001786:	f94785e3          	beq	a5,s4,80001710 <kwait+0x40>
        release(&pp->lock);
    8000178a:	8526                	mv	a0,s1
    8000178c:	74a040ef          	jal	80005ed6 <release>
        havekids = 1;
    80001790:	8756                	mv	a4,s5
    80001792:	bff9                	j	80001770 <kwait+0xa0>
    if(!havekids || killed(p)){
    80001794:	cf19                	beqz	a4,800017b2 <kwait+0xe2>
    80001796:	854a                	mv	a0,s2
    80001798:	f0fff0ef          	jal	800016a6 <killed>
    8000179c:	e919                	bnez	a0,800017b2 <kwait+0xe2>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000179e:	85da                	mv	a1,s6
    800017a0:	854a                	mv	a0,s2
    800017a2:	cc9ff0ef          	jal	8000146a <sleep>
    havekids = 0;
    800017a6:	4701                	li	a4,0
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800017a8:	00008497          	auipc	s1,0x8
    800017ac:	b3848493          	addi	s1,s1,-1224 # 800092e0 <proc>
    800017b0:	b7e1                	j	80001778 <kwait+0xa8>
      release(&wait_lock);
    800017b2:	00007517          	auipc	a0,0x7
    800017b6:	70e50513          	addi	a0,a0,1806 # 80008ec0 <wait_lock>
    800017ba:	71c040ef          	jal	80005ed6 <release>
            return -1;
    800017be:	59fd                	li	s3,-1
    800017c0:	b751                	j	80001744 <kwait+0x74>

00000000800017c2 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    800017c2:	7179                	addi	sp,sp,-48
    800017c4:	f406                	sd	ra,40(sp)
    800017c6:	f022                	sd	s0,32(sp)
    800017c8:	ec26                	sd	s1,24(sp)
    800017ca:	e84a                	sd	s2,16(sp)
    800017cc:	e44e                	sd	s3,8(sp)
    800017ce:	e052                	sd	s4,0(sp)
    800017d0:	1800                	addi	s0,sp,48
    800017d2:	84aa                	mv	s1,a0
    800017d4:	8a2e                	mv	s4,a1
    800017d6:	89b2                	mv	s3,a2
    800017d8:	8936                	mv	s2,a3
  struct proc *p = myproc();
    800017da:	e5aff0ef          	jal	80000e34 <myproc>
  if(user_dst){
    800017de:	cc99                	beqz	s1,800017fc <either_copyout+0x3a>
    return copyout(p->pagetable, dst, src, len);
    800017e0:	86ca                	mv	a3,s2
    800017e2:	864e                	mv	a2,s3
    800017e4:	85d2                	mv	a1,s4
    800017e6:	6d28                	ld	a0,88(a0)
    800017e8:	b90ff0ef          	jal	80000b78 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800017ec:	70a2                	ld	ra,40(sp)
    800017ee:	7402                	ld	s0,32(sp)
    800017f0:	64e2                	ld	s1,24(sp)
    800017f2:	6942                	ld	s2,16(sp)
    800017f4:	69a2                	ld	s3,8(sp)
    800017f6:	6a02                	ld	s4,0(sp)
    800017f8:	6145                	addi	sp,sp,48
    800017fa:	8082                	ret
    memmove((char *)dst, src, len);
    800017fc:	0009061b          	sext.w	a2,s2
    80001800:	85ce                	mv	a1,s3
    80001802:	8552                	mv	a0,s4
    80001804:	a8ffe0ef          	jal	80000292 <memmove>
    return 0;
    80001808:	8526                	mv	a0,s1
    8000180a:	b7cd                	j	800017ec <either_copyout+0x2a>

000000008000180c <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    8000180c:	7179                	addi	sp,sp,-48
    8000180e:	f406                	sd	ra,40(sp)
    80001810:	f022                	sd	s0,32(sp)
    80001812:	ec26                	sd	s1,24(sp)
    80001814:	e84a                	sd	s2,16(sp)
    80001816:	e44e                	sd	s3,8(sp)
    80001818:	e052                	sd	s4,0(sp)
    8000181a:	1800                	addi	s0,sp,48
    8000181c:	8a2a                	mv	s4,a0
    8000181e:	84ae                	mv	s1,a1
    80001820:	89b2                	mv	s3,a2
    80001822:	8936                	mv	s2,a3
  struct proc *p = myproc();
    80001824:	e10ff0ef          	jal	80000e34 <myproc>
  if(user_src){
    80001828:	cc99                	beqz	s1,80001846 <either_copyin+0x3a>
    return copyin(p->pagetable, dst, src, len);
    8000182a:	86ca                	mv	a3,s2
    8000182c:	864e                	mv	a2,s3
    8000182e:	85d2                	mv	a1,s4
    80001830:	6d28                	ld	a0,88(a0)
    80001832:	bfeff0ef          	jal	80000c30 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001836:	70a2                	ld	ra,40(sp)
    80001838:	7402                	ld	s0,32(sp)
    8000183a:	64e2                	ld	s1,24(sp)
    8000183c:	6942                	ld	s2,16(sp)
    8000183e:	69a2                	ld	s3,8(sp)
    80001840:	6a02                	ld	s4,0(sp)
    80001842:	6145                	addi	sp,sp,48
    80001844:	8082                	ret
    memmove(dst, (char*)src, len);
    80001846:	0009061b          	sext.w	a2,s2
    8000184a:	85ce                	mv	a1,s3
    8000184c:	8552                	mv	a0,s4
    8000184e:	a45fe0ef          	jal	80000292 <memmove>
    return 0;
    80001852:	8526                	mv	a0,s1
    80001854:	b7cd                	j	80001836 <either_copyin+0x2a>

0000000080001856 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001856:	715d                	addi	sp,sp,-80
    80001858:	e486                	sd	ra,72(sp)
    8000185a:	e0a2                	sd	s0,64(sp)
    8000185c:	fc26                	sd	s1,56(sp)
    8000185e:	f84a                	sd	s2,48(sp)
    80001860:	f44e                	sd	s3,40(sp)
    80001862:	f052                	sd	s4,32(sp)
    80001864:	ec56                	sd	s5,24(sp)
    80001866:	e85a                	sd	s6,16(sp)
    80001868:	e45e                	sd	s7,8(sp)
    8000186a:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    8000186c:	00006517          	auipc	a0,0x6
    80001870:	7ac50513          	addi	a0,a0,1964 # 80008018 <etext+0x18>
    80001874:	6b3030ef          	jal	80005726 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001878:	00008497          	auipc	s1,0x8
    8000187c:	bc848493          	addi	s1,s1,-1080 # 80009440 <proc+0x160>
    80001880:	0000e917          	auipc	s2,0xe
    80001884:	9c090913          	addi	s2,s2,-1600 # 8000f240 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001888:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    8000188a:	00007a97          	auipc	s5,0x7
    8000188e:	916a8a93          	addi	s5,s5,-1770 # 800081a0 <etext+0x1a0>
    printf("%d %s %s", p->pid, state, p->name);
    80001892:	00007a17          	auipc	s4,0x7
    80001896:	916a0a13          	addi	s4,s4,-1770 # 800081a8 <etext+0x1a8>
    printf("\n");
    8000189a:	00006997          	auipc	s3,0x6
    8000189e:	77e98993          	addi	s3,s3,1918 # 80008018 <etext+0x18>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800018a2:	00007b97          	auipc	s7,0x7
    800018a6:	276b8b93          	addi	s7,s7,630 # 80008b18 <states.0>
    800018aa:	a829                	j	800018c4 <procdump+0x6e>
    printf("%d %s %s", p->pid, state, p->name);
    800018ac:	ed86a583          	lw	a1,-296(a3)
    800018b0:	8552                	mv	a0,s4
    800018b2:	675030ef          	jal	80005726 <printf>
    printf("\n");
    800018b6:	854e                	mv	a0,s3
    800018b8:	66f030ef          	jal	80005726 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800018bc:	17848493          	addi	s1,s1,376
    800018c0:	03248063          	beq	s1,s2,800018e0 <procdump+0x8a>
    if(p->state == UNUSED)
    800018c4:	86a6                	mv	a3,s1
    800018c6:	ec04a783          	lw	a5,-320(s1)
    800018ca:	dbed                	beqz	a5,800018bc <procdump+0x66>
      state = "???";
    800018cc:	8656                	mv	a2,s5
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800018ce:	fcfb6fe3          	bltu	s6,a5,800018ac <procdump+0x56>
    800018d2:	02079713          	slli	a4,a5,0x20
    800018d6:	01d75793          	srli	a5,a4,0x1d
    800018da:	97de                	add	a5,a5,s7
    800018dc:	6390                	ld	a2,0(a5)
      state = states[p->state];
    800018de:	b7f9                	j	800018ac <procdump+0x56>
  }
}
    800018e0:	60a6                	ld	ra,72(sp)
    800018e2:	6406                	ld	s0,64(sp)
    800018e4:	74e2                	ld	s1,56(sp)
    800018e6:	7942                	ld	s2,48(sp)
    800018e8:	79a2                	ld	s3,40(sp)
    800018ea:	7a02                	ld	s4,32(sp)
    800018ec:	6ae2                	ld	s5,24(sp)
    800018ee:	6b42                	ld	s6,16(sp)
    800018f0:	6ba2                	ld	s7,8(sp)
    800018f2:	6161                	addi	sp,sp,80
    800018f4:	8082                	ret

00000000800018f6 <swtch>:
# Save current registers in old. Load from new.	


.globl swtch
swtch:
        sd ra, 0(a0)
    800018f6:	00153023          	sd	ra,0(a0)
        sd sp, 8(a0)
    800018fa:	00253423          	sd	sp,8(a0)
        sd s0, 16(a0)
    800018fe:	e900                	sd	s0,16(a0)
        sd s1, 24(a0)
    80001900:	ed04                	sd	s1,24(a0)
        sd s2, 32(a0)
    80001902:	03253023          	sd	s2,32(a0)
        sd s3, 40(a0)
    80001906:	03353423          	sd	s3,40(a0)
        sd s4, 48(a0)
    8000190a:	03453823          	sd	s4,48(a0)
        sd s5, 56(a0)
    8000190e:	03553c23          	sd	s5,56(a0)
        sd s6, 64(a0)
    80001912:	05653023          	sd	s6,64(a0)
        sd s7, 72(a0)
    80001916:	05753423          	sd	s7,72(a0)
        sd s8, 80(a0)
    8000191a:	05853823          	sd	s8,80(a0)
        sd s9, 88(a0)
    8000191e:	05953c23          	sd	s9,88(a0)
        sd s10, 96(a0)
    80001922:	07a53023          	sd	s10,96(a0)
        sd s11, 104(a0)
    80001926:	07b53423          	sd	s11,104(a0)

        ld ra, 0(a1)
    8000192a:	0005b083          	ld	ra,0(a1)
        ld sp, 8(a1)
    8000192e:	0085b103          	ld	sp,8(a1)
        ld s0, 16(a1)
    80001932:	6980                	ld	s0,16(a1)
        ld s1, 24(a1)
    80001934:	6d84                	ld	s1,24(a1)
        ld s2, 32(a1)
    80001936:	0205b903          	ld	s2,32(a1)
        ld s3, 40(a1)
    8000193a:	0285b983          	ld	s3,40(a1)
        ld s4, 48(a1)
    8000193e:	0305ba03          	ld	s4,48(a1)
        ld s5, 56(a1)
    80001942:	0385ba83          	ld	s5,56(a1)
        ld s6, 64(a1)
    80001946:	0405bb03          	ld	s6,64(a1)
        ld s7, 72(a1)
    8000194a:	0485bb83          	ld	s7,72(a1)
        ld s8, 80(a1)
    8000194e:	0505bc03          	ld	s8,80(a1)
        ld s9, 88(a1)
    80001952:	0585bc83          	ld	s9,88(a1)
        ld s10, 96(a1)
    80001956:	0605bd03          	ld	s10,96(a1)
        ld s11, 104(a1)
    8000195a:	0685bd83          	ld	s11,104(a1)
        
        ret
    8000195e:	8082                	ret

0000000080001960 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001960:	1141                	addi	sp,sp,-16
    80001962:	e406                	sd	ra,8(sp)
    80001964:	e022                	sd	s0,0(sp)
    80001966:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001968:	00007597          	auipc	a1,0x7
    8000196c:	88058593          	addi	a1,a1,-1920 # 800081e8 <etext+0x1e8>
    80001970:	0000d517          	auipc	a0,0xd
    80001974:	77050513          	addi	a0,a0,1904 # 8000f0e0 <tickslock>
    80001978:	5f6040ef          	jal	80005f6e <initlock>
}
    8000197c:	60a2                	ld	ra,8(sp)
    8000197e:	6402                	ld	s0,0(sp)
    80001980:	0141                	addi	sp,sp,16
    80001982:	8082                	ret

0000000080001984 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001984:	1141                	addi	sp,sp,-16
    80001986:	e406                	sd	ra,8(sp)
    80001988:	e022                	sd	s0,0(sp)
    8000198a:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    8000198c:	00003797          	auipc	a5,0x3
    80001990:	f6478793          	addi	a5,a5,-156 # 800048f0 <kernelvec>
    80001994:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001998:	60a2                	ld	ra,8(sp)
    8000199a:	6402                	ld	s0,0(sp)
    8000199c:	0141                	addi	sp,sp,16
    8000199e:	8082                	ret

00000000800019a0 <prepare_return>:
//
// set up trapframe and control registers for a return to user space
//
void
prepare_return(void)
{
    800019a0:	1141                	addi	sp,sp,-16
    800019a2:	e406                	sd	ra,8(sp)
    800019a4:	e022                	sd	s0,0(sp)
    800019a6:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    800019a8:	c8cff0ef          	jal	80000e34 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800019ac:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800019b0:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800019b2:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(). because a trap from kernel
  // code to usertrap would be a disaster, turn off interrupts.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    800019b6:	04000737          	lui	a4,0x4000
    800019ba:	177d                	addi	a4,a4,-1 # 3ffffff <_entry-0x7c000001>
    800019bc:	0732                	slli	a4,a4,0xc
    800019be:	00005797          	auipc	a5,0x5
    800019c2:	64278793          	addi	a5,a5,1602 # 80007000 <_trampoline>
    800019c6:	00005697          	auipc	a3,0x5
    800019ca:	63a68693          	addi	a3,a3,1594 # 80007000 <_trampoline>
    800019ce:	8f95                	sub	a5,a5,a3
    800019d0:	97ba                	add	a5,a5,a4
  asm volatile("csrw stvec, %0" : : "r" (x));
    800019d2:	10579073          	csrw	stvec,a5
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    800019d6:	713c                	ld	a5,96(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    800019d8:	18002773          	csrr	a4,satp
    800019dc:	e398                	sd	a4,0(a5)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    800019de:	7138                	ld	a4,96(a0)
    800019e0:	653c                	ld	a5,72(a0)
    800019e2:	6685                	lui	a3,0x1
    800019e4:	97b6                	add	a5,a5,a3
    800019e6:	e71c                	sd	a5,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    800019e8:	713c                	ld	a5,96(a0)
    800019ea:	00000717          	auipc	a4,0x0
    800019ee:	0f470713          	addi	a4,a4,244 # 80001ade <usertrap>
    800019f2:	eb98                	sd	a4,16(a5)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    800019f4:	713c                	ld	a5,96(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    800019f6:	8712                	mv	a4,tp
    800019f8:	f398                	sd	a4,32(a5)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800019fa:	100027f3          	csrr	a5,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800019fe:	eff7f793          	andi	a5,a5,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001a02:	0207e793          	ori	a5,a5,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001a06:	10079073          	csrw	sstatus,a5
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001a0a:	713c                	ld	a5,96(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001a0c:	6f9c                	ld	a5,24(a5)
    80001a0e:	14179073          	csrw	sepc,a5
}
    80001a12:	60a2                	ld	ra,8(sp)
    80001a14:	6402                	ld	s0,0(sp)
    80001a16:	0141                	addi	sp,sp,16
    80001a18:	8082                	ret

0000000080001a1a <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001a1a:	1141                	addi	sp,sp,-16
    80001a1c:	e406                	sd	ra,8(sp)
    80001a1e:	e022                	sd	s0,0(sp)
    80001a20:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80001a22:	bdeff0ef          	jal	80000e00 <cpuid>
    80001a26:	cd11                	beqz	a0,80001a42 <clockintr+0x28>
  asm volatile("csrr %0, time" : "=r" (x) );
    80001a28:	c01027f3          	rdtime	a5
  }

  // ask for the next timer interrupt. this also clears
  // the interrupt request. 1000000 is about a tenth
  // of a second.
  w_stimecmp(r_time() + 1000000);
    80001a2c:	000f4737          	lui	a4,0xf4
    80001a30:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    80001a34:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    80001a36:	14d79073          	csrw	stimecmp,a5
}
    80001a3a:	60a2                	ld	ra,8(sp)
    80001a3c:	6402                	ld	s0,0(sp)
    80001a3e:	0141                	addi	sp,sp,16
    80001a40:	8082                	ret
    acquire(&tickslock);
    80001a42:	0000d517          	auipc	a0,0xd
    80001a46:	69e50513          	addi	a0,a0,1694 # 8000f0e0 <tickslock>
    80001a4a:	350040ef          	jal	80005d9a <acquire>
    ticks++;
    80001a4e:	00007717          	auipc	a4,0x7
    80001a52:	29a70713          	addi	a4,a4,666 # 80008ce8 <ticks>
    80001a56:	431c                	lw	a5,0(a4)
    80001a58:	2785                	addiw	a5,a5,1
    80001a5a:	c31c                	sw	a5,0(a4)
    wakeup(&ticks);
    80001a5c:	853a                	mv	a0,a4
    80001a5e:	a59ff0ef          	jal	800014b6 <wakeup>
    release(&tickslock);
    80001a62:	0000d517          	auipc	a0,0xd
    80001a66:	67e50513          	addi	a0,a0,1662 # 8000f0e0 <tickslock>
    80001a6a:	46c040ef          	jal	80005ed6 <release>
    80001a6e:	bf6d                	j	80001a28 <clockintr+0xe>

0000000080001a70 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80001a70:	1101                	addi	sp,sp,-32
    80001a72:	ec06                	sd	ra,24(sp)
    80001a74:	e822                	sd	s0,16(sp)
    80001a76:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001a78:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if(scause == 0x8000000000000009L){
    80001a7c:	57fd                	li	a5,-1
    80001a7e:	17fe                	slli	a5,a5,0x3f
    80001a80:	07a5                	addi	a5,a5,9
    80001a82:	00f70c63          	beq	a4,a5,80001a9a <devintr+0x2a>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000005L){
    80001a86:	57fd                	li	a5,-1
    80001a88:	17fe                	slli	a5,a5,0x3f
    80001a8a:	0795                	addi	a5,a5,5
    // timer interrupt.
    clockintr();
    return 2;
  } else {
    return 0;
    80001a8c:	4501                	li	a0,0
  } else if(scause == 0x8000000000000005L){
    80001a8e:	04f70463          	beq	a4,a5,80001ad6 <devintr+0x66>
  }
}
    80001a92:	60e2                	ld	ra,24(sp)
    80001a94:	6442                	ld	s0,16(sp)
    80001a96:	6105                	addi	sp,sp,32
    80001a98:	8082                	ret
    80001a9a:	e426                	sd	s1,8(sp)
    int irq = plic_claim();
    80001a9c:	701020ef          	jal	8000499c <plic_claim>
    80001aa0:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001aa2:	47a9                	li	a5,10
    80001aa4:	02f50363          	beq	a0,a5,80001aca <devintr+0x5a>
    } else if(irq == VIRTIO0_IRQ){
    80001aa8:	4785                	li	a5,1
    80001aaa:	02f50363          	beq	a0,a5,80001ad0 <devintr+0x60>
    } else if(irq){
    80001aae:	c919                	beqz	a0,80001ac4 <devintr+0x54>
      printf("unexpected interrupt irq=%d\n", irq);
    80001ab0:	85aa                	mv	a1,a0
    80001ab2:	00006517          	auipc	a0,0x6
    80001ab6:	73e50513          	addi	a0,a0,1854 # 800081f0 <etext+0x1f0>
    80001aba:	46d030ef          	jal	80005726 <printf>
      plic_complete(irq);
    80001abe:	8526                	mv	a0,s1
    80001ac0:	6fd020ef          	jal	800049bc <plic_complete>
    return 1;
    80001ac4:	4505                	li	a0,1
    80001ac6:	64a2                	ld	s1,8(sp)
    80001ac8:	b7e9                	j	80001a92 <devintr+0x22>
      uartintr();
    80001aca:	160040ef          	jal	80005c2a <uartintr>
    if(irq)
    80001ace:	bfc5                	j	80001abe <devintr+0x4e>
      virtio_disk_intr();
    80001ad0:	388030ef          	jal	80004e58 <virtio_disk_intr>
    if(irq)
    80001ad4:	b7ed                	j	80001abe <devintr+0x4e>
    clockintr();
    80001ad6:	f45ff0ef          	jal	80001a1a <clockintr>
    return 2;
    80001ada:	4509                	li	a0,2
    80001adc:	bf5d                	j	80001a92 <devintr+0x22>

0000000080001ade <usertrap>:
{
    80001ade:	1101                	addi	sp,sp,-32
    80001ae0:	ec06                	sd	ra,24(sp)
    80001ae2:	e822                	sd	s0,16(sp)
    80001ae4:	e426                	sd	s1,8(sp)
    80001ae6:	e04a                	sd	s2,0(sp)
    80001ae8:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001aea:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001aee:	1007f793          	andi	a5,a5,256
    80001af2:	eba5                	bnez	a5,80001b62 <usertrap+0x84>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001af4:	00003797          	auipc	a5,0x3
    80001af8:	dfc78793          	addi	a5,a5,-516 # 800048f0 <kernelvec>
    80001afc:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001b00:	b34ff0ef          	jal	80000e34 <myproc>
    80001b04:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001b06:	713c                	ld	a5,96(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001b08:	14102773          	csrr	a4,sepc
    80001b0c:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001b0e:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001b12:	47a1                	li	a5,8
    80001b14:	04f70d63          	beq	a4,a5,80001b6e <usertrap+0x90>
  } else if((which_dev = devintr()) != 0){
    80001b18:	f59ff0ef          	jal	80001a70 <devintr>
    80001b1c:	892a                	mv	s2,a0
    80001b1e:	e945                	bnez	a0,80001bce <usertrap+0xf0>
    80001b20:	14202773          	csrr	a4,scause
  } else if((r_scause() == 15 || r_scause() == 13) &&
    80001b24:	47bd                	li	a5,15
    80001b26:	08f70863          	beq	a4,a5,80001bb6 <usertrap+0xd8>
    80001b2a:	14202773          	csrr	a4,scause
    80001b2e:	47b5                	li	a5,13
    80001b30:	08f70363          	beq	a4,a5,80001bb6 <usertrap+0xd8>
    80001b34:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause 0x%lx pid=%d\n", r_scause(), p->pid);
    80001b38:	5c90                	lw	a2,56(s1)
    80001b3a:	00006517          	auipc	a0,0x6
    80001b3e:	6f650513          	addi	a0,a0,1782 # 80008230 <etext+0x230>
    80001b42:	3e5030ef          	jal	80005726 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001b46:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001b4a:	14302673          	csrr	a2,stval
    printf("            sepc=0x%lx stval=0x%lx\n", r_sepc(), r_stval());
    80001b4e:	00006517          	auipc	a0,0x6
    80001b52:	71250513          	addi	a0,a0,1810 # 80008260 <etext+0x260>
    80001b56:	3d1030ef          	jal	80005726 <printf>
    setkilled(p);
    80001b5a:	8526                	mv	a0,s1
    80001b5c:	b27ff0ef          	jal	80001682 <setkilled>
    80001b60:	a035                	j	80001b8c <usertrap+0xae>
    panic("usertrap: not from user mode");
    80001b62:	00006517          	auipc	a0,0x6
    80001b66:	6ae50513          	addi	a0,a0,1710 # 80008210 <etext+0x210>
    80001b6a:	6f5030ef          	jal	80005a5e <panic>
    if(killed(p))
    80001b6e:	b39ff0ef          	jal	800016a6 <killed>
    80001b72:	ed15                	bnez	a0,80001bae <usertrap+0xd0>
    p->trapframe->epc += 4;
    80001b74:	70b8                	ld	a4,96(s1)
    80001b76:	6f1c                	ld	a5,24(a4)
    80001b78:	0791                	addi	a5,a5,4
    80001b7a:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b7c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001b80:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b84:	10079073          	csrw	sstatus,a5
    syscall();
    80001b88:	23c000ef          	jal	80001dc4 <syscall>
  if(killed(p))
    80001b8c:	8526                	mv	a0,s1
    80001b8e:	b19ff0ef          	jal	800016a6 <killed>
    80001b92:	e139                	bnez	a0,80001bd8 <usertrap+0xfa>
  prepare_return();
    80001b94:	e0dff0ef          	jal	800019a0 <prepare_return>
  uint64 satp = MAKE_SATP(p->pagetable);
    80001b98:	6ca8                	ld	a0,88(s1)
    80001b9a:	8131                	srli	a0,a0,0xc
    80001b9c:	57fd                	li	a5,-1
    80001b9e:	17fe                	slli	a5,a5,0x3f
    80001ba0:	8d5d                	or	a0,a0,a5
}
    80001ba2:	60e2                	ld	ra,24(sp)
    80001ba4:	6442                	ld	s0,16(sp)
    80001ba6:	64a2                	ld	s1,8(sp)
    80001ba8:	6902                	ld	s2,0(sp)
    80001baa:	6105                	addi	sp,sp,32
    80001bac:	8082                	ret
      kexit(-1);
    80001bae:	557d                	li	a0,-1
    80001bb0:	9c7ff0ef          	jal	80001576 <kexit>
    80001bb4:	b7c1                	j	80001b74 <usertrap+0x96>
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001bb6:	143025f3          	csrr	a1,stval
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001bba:	14202673          	csrr	a2,scause
            vmfault(p->pagetable, r_stval(), (r_scause() == 13)? 1 : 0) != 0) {
    80001bbe:	164d                	addi	a2,a2,-13 # ff3 <_entry-0x7ffff00d>
    80001bc0:	00163613          	seqz	a2,a2
    80001bc4:	6ca8                	ld	a0,88(s1)
    80001bc6:	f33fe0ef          	jal	80000af8 <vmfault>
  } else if((r_scause() == 15 || r_scause() == 13) &&
    80001bca:	f169                	bnez	a0,80001b8c <usertrap+0xae>
    80001bcc:	b7a5                	j	80001b34 <usertrap+0x56>
  if(killed(p))
    80001bce:	8526                	mv	a0,s1
    80001bd0:	ad7ff0ef          	jal	800016a6 <killed>
    80001bd4:	c511                	beqz	a0,80001be0 <usertrap+0x102>
    80001bd6:	a011                	j	80001bda <usertrap+0xfc>
    80001bd8:	4901                	li	s2,0
    kexit(-1);
    80001bda:	557d                	li	a0,-1
    80001bdc:	99bff0ef          	jal	80001576 <kexit>
  if(which_dev == 2)
    80001be0:	4789                	li	a5,2
    80001be2:	faf919e3          	bne	s2,a5,80001b94 <usertrap+0xb6>
    yield();
    80001be6:	859ff0ef          	jal	8000143e <yield>
    80001bea:	b76d                	j	80001b94 <usertrap+0xb6>

0000000080001bec <kerneltrap>:
{
    80001bec:	7179                	addi	sp,sp,-48
    80001bee:	f406                	sd	ra,40(sp)
    80001bf0:	f022                	sd	s0,32(sp)
    80001bf2:	ec26                	sd	s1,24(sp)
    80001bf4:	e84a                	sd	s2,16(sp)
    80001bf6:	e44e                	sd	s3,8(sp)
    80001bf8:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001bfa:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001bfe:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001c02:	142027f3          	csrr	a5,scause
    80001c06:	89be                	mv	s3,a5
  if((sstatus & SSTATUS_SPP) == 0)
    80001c08:	1004f793          	andi	a5,s1,256
    80001c0c:	c795                	beqz	a5,80001c38 <kerneltrap+0x4c>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001c0e:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001c12:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001c14:	eb85                	bnez	a5,80001c44 <kerneltrap+0x58>
  if((which_dev = devintr()) == 0){
    80001c16:	e5bff0ef          	jal	80001a70 <devintr>
    80001c1a:	c91d                	beqz	a0,80001c50 <kerneltrap+0x64>
  if(which_dev == 2 && myproc() != 0)
    80001c1c:	4789                	li	a5,2
    80001c1e:	04f50a63          	beq	a0,a5,80001c72 <kerneltrap+0x86>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001c22:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001c26:	10049073          	csrw	sstatus,s1
}
    80001c2a:	70a2                	ld	ra,40(sp)
    80001c2c:	7402                	ld	s0,32(sp)
    80001c2e:	64e2                	ld	s1,24(sp)
    80001c30:	6942                	ld	s2,16(sp)
    80001c32:	69a2                	ld	s3,8(sp)
    80001c34:	6145                	addi	sp,sp,48
    80001c36:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001c38:	00006517          	auipc	a0,0x6
    80001c3c:	65050513          	addi	a0,a0,1616 # 80008288 <etext+0x288>
    80001c40:	61f030ef          	jal	80005a5e <panic>
    panic("kerneltrap: interrupts enabled");
    80001c44:	00006517          	auipc	a0,0x6
    80001c48:	66c50513          	addi	a0,a0,1644 # 800082b0 <etext+0x2b0>
    80001c4c:	613030ef          	jal	80005a5e <panic>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001c50:	14102673          	csrr	a2,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001c54:	143026f3          	csrr	a3,stval
    printf("scause=0x%lx sepc=0x%lx stval=0x%lx\n", scause, r_sepc(), r_stval());
    80001c58:	85ce                	mv	a1,s3
    80001c5a:	00006517          	auipc	a0,0x6
    80001c5e:	67650513          	addi	a0,a0,1654 # 800082d0 <etext+0x2d0>
    80001c62:	2c5030ef          	jal	80005726 <printf>
    panic("kerneltrap");
    80001c66:	00006517          	auipc	a0,0x6
    80001c6a:	69250513          	addi	a0,a0,1682 # 800082f8 <etext+0x2f8>
    80001c6e:	5f1030ef          	jal	80005a5e <panic>
  if(which_dev == 2 && myproc() != 0)
    80001c72:	9c2ff0ef          	jal	80000e34 <myproc>
    80001c76:	d555                	beqz	a0,80001c22 <kerneltrap+0x36>
    yield();
    80001c78:	fc6ff0ef          	jal	8000143e <yield>
    80001c7c:	b75d                	j	80001c22 <kerneltrap+0x36>

0000000080001c7e <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001c7e:	1101                	addi	sp,sp,-32
    80001c80:	ec06                	sd	ra,24(sp)
    80001c82:	e822                	sd	s0,16(sp)
    80001c84:	e426                	sd	s1,8(sp)
    80001c86:	1000                	addi	s0,sp,32
    80001c88:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001c8a:	9aaff0ef          	jal	80000e34 <myproc>
  switch (n) {
    80001c8e:	4795                	li	a5,5
    80001c90:	0497e163          	bltu	a5,s1,80001cd2 <argraw+0x54>
    80001c94:	048a                	slli	s1,s1,0x2
    80001c96:	00007717          	auipc	a4,0x7
    80001c9a:	eb270713          	addi	a4,a4,-334 # 80008b48 <states.0+0x30>
    80001c9e:	94ba                	add	s1,s1,a4
    80001ca0:	409c                	lw	a5,0(s1)
    80001ca2:	97ba                	add	a5,a5,a4
    80001ca4:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001ca6:	713c                	ld	a5,96(a0)
    80001ca8:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001caa:	60e2                	ld	ra,24(sp)
    80001cac:	6442                	ld	s0,16(sp)
    80001cae:	64a2                	ld	s1,8(sp)
    80001cb0:	6105                	addi	sp,sp,32
    80001cb2:	8082                	ret
    return p->trapframe->a1;
    80001cb4:	713c                	ld	a5,96(a0)
    80001cb6:	7fa8                	ld	a0,120(a5)
    80001cb8:	bfcd                	j	80001caa <argraw+0x2c>
    return p->trapframe->a2;
    80001cba:	713c                	ld	a5,96(a0)
    80001cbc:	63c8                	ld	a0,128(a5)
    80001cbe:	b7f5                	j	80001caa <argraw+0x2c>
    return p->trapframe->a3;
    80001cc0:	713c                	ld	a5,96(a0)
    80001cc2:	67c8                	ld	a0,136(a5)
    80001cc4:	b7dd                	j	80001caa <argraw+0x2c>
    return p->trapframe->a4;
    80001cc6:	713c                	ld	a5,96(a0)
    80001cc8:	6bc8                	ld	a0,144(a5)
    80001cca:	b7c5                	j	80001caa <argraw+0x2c>
    return p->trapframe->a5;
    80001ccc:	713c                	ld	a5,96(a0)
    80001cce:	6fc8                	ld	a0,152(a5)
    80001cd0:	bfe9                	j	80001caa <argraw+0x2c>
  panic("argraw");
    80001cd2:	00006517          	auipc	a0,0x6
    80001cd6:	63650513          	addi	a0,a0,1590 # 80008308 <etext+0x308>
    80001cda:	585030ef          	jal	80005a5e <panic>

0000000080001cde <fetchaddr>:
{
    80001cde:	1101                	addi	sp,sp,-32
    80001ce0:	ec06                	sd	ra,24(sp)
    80001ce2:	e822                	sd	s0,16(sp)
    80001ce4:	e426                	sd	s1,8(sp)
    80001ce6:	e04a                	sd	s2,0(sp)
    80001ce8:	1000                	addi	s0,sp,32
    80001cea:	84aa                	mv	s1,a0
    80001cec:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001cee:	946ff0ef          	jal	80000e34 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80001cf2:	693c                	ld	a5,80(a0)
    80001cf4:	02f4f663          	bgeu	s1,a5,80001d20 <fetchaddr+0x42>
    80001cf8:	00848713          	addi	a4,s1,8
    80001cfc:	02e7e263          	bltu	a5,a4,80001d20 <fetchaddr+0x42>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001d00:	46a1                	li	a3,8
    80001d02:	8626                	mv	a2,s1
    80001d04:	85ca                	mv	a1,s2
    80001d06:	6d28                	ld	a0,88(a0)
    80001d08:	f29fe0ef          	jal	80000c30 <copyin>
    80001d0c:	00a03533          	snez	a0,a0
    80001d10:	40a0053b          	negw	a0,a0
}
    80001d14:	60e2                	ld	ra,24(sp)
    80001d16:	6442                	ld	s0,16(sp)
    80001d18:	64a2                	ld	s1,8(sp)
    80001d1a:	6902                	ld	s2,0(sp)
    80001d1c:	6105                	addi	sp,sp,32
    80001d1e:	8082                	ret
    return -1;
    80001d20:	557d                	li	a0,-1
    80001d22:	bfcd                	j	80001d14 <fetchaddr+0x36>

0000000080001d24 <fetchstr>:
{
    80001d24:	7179                	addi	sp,sp,-48
    80001d26:	f406                	sd	ra,40(sp)
    80001d28:	f022                	sd	s0,32(sp)
    80001d2a:	ec26                	sd	s1,24(sp)
    80001d2c:	e84a                	sd	s2,16(sp)
    80001d2e:	e44e                	sd	s3,8(sp)
    80001d30:	1800                	addi	s0,sp,48
    80001d32:	89aa                	mv	s3,a0
    80001d34:	84ae                	mv	s1,a1
    80001d36:	8932                	mv	s2,a2
  struct proc *p = myproc();
    80001d38:	8fcff0ef          	jal	80000e34 <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    80001d3c:	86ca                	mv	a3,s2
    80001d3e:	864e                	mv	a2,s3
    80001d40:	85a6                	mv	a1,s1
    80001d42:	6d28                	ld	a0,88(a0)
    80001d44:	cddfe0ef          	jal	80000a20 <copyinstr>
    80001d48:	00054c63          	bltz	a0,80001d60 <fetchstr+0x3c>
  return strlen(buf);
    80001d4c:	8526                	mv	a0,s1
    80001d4e:	e68fe0ef          	jal	800003b6 <strlen>
}
    80001d52:	70a2                	ld	ra,40(sp)
    80001d54:	7402                	ld	s0,32(sp)
    80001d56:	64e2                	ld	s1,24(sp)
    80001d58:	6942                	ld	s2,16(sp)
    80001d5a:	69a2                	ld	s3,8(sp)
    80001d5c:	6145                	addi	sp,sp,48
    80001d5e:	8082                	ret
    return -1;
    80001d60:	557d                	li	a0,-1
    80001d62:	bfc5                	j	80001d52 <fetchstr+0x2e>

0000000080001d64 <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    80001d64:	1101                	addi	sp,sp,-32
    80001d66:	ec06                	sd	ra,24(sp)
    80001d68:	e822                	sd	s0,16(sp)
    80001d6a:	e426                	sd	s1,8(sp)
    80001d6c:	1000                	addi	s0,sp,32
    80001d6e:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001d70:	f0fff0ef          	jal	80001c7e <argraw>
    80001d74:	c088                	sw	a0,0(s1)
}
    80001d76:	60e2                	ld	ra,24(sp)
    80001d78:	6442                	ld	s0,16(sp)
    80001d7a:	64a2                	ld	s1,8(sp)
    80001d7c:	6105                	addi	sp,sp,32
    80001d7e:	8082                	ret

0000000080001d80 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    80001d80:	1101                	addi	sp,sp,-32
    80001d82:	ec06                	sd	ra,24(sp)
    80001d84:	e822                	sd	s0,16(sp)
    80001d86:	e426                	sd	s1,8(sp)
    80001d88:	1000                	addi	s0,sp,32
    80001d8a:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001d8c:	ef3ff0ef          	jal	80001c7e <argraw>
    80001d90:	e088                	sd	a0,0(s1)
}
    80001d92:	60e2                	ld	ra,24(sp)
    80001d94:	6442                	ld	s0,16(sp)
    80001d96:	64a2                	ld	s1,8(sp)
    80001d98:	6105                	addi	sp,sp,32
    80001d9a:	8082                	ret

0000000080001d9c <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80001d9c:	1101                	addi	sp,sp,-32
    80001d9e:	ec06                	sd	ra,24(sp)
    80001da0:	e822                	sd	s0,16(sp)
    80001da2:	e426                	sd	s1,8(sp)
    80001da4:	e04a                	sd	s2,0(sp)
    80001da6:	1000                	addi	s0,sp,32
    80001da8:	892e                	mv	s2,a1
    80001daa:	84b2                	mv	s1,a2
  *ip = argraw(n);
    80001dac:	ed3ff0ef          	jal	80001c7e <argraw>
  uint64 addr;
  argaddr(n, &addr);
  return fetchstr(addr, buf, max);
    80001db0:	8626                	mv	a2,s1
    80001db2:	85ca                	mv	a1,s2
    80001db4:	f71ff0ef          	jal	80001d24 <fetchstr>
}
    80001db8:	60e2                	ld	ra,24(sp)
    80001dba:	6442                	ld	s0,16(sp)
    80001dbc:	64a2                	ld	s1,8(sp)
    80001dbe:	6902                	ld	s2,0(sp)
    80001dc0:	6105                	addi	sp,sp,32
    80001dc2:	8082                	ret

0000000080001dc4 <syscall>:
};


void
syscall(void)
{
    80001dc4:	1101                	addi	sp,sp,-32
    80001dc6:	ec06                	sd	ra,24(sp)
    80001dc8:	e822                	sd	s0,16(sp)
    80001dca:	e426                	sd	s1,8(sp)
    80001dcc:	e04a                	sd	s2,0(sp)
    80001dce:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80001dd0:	864ff0ef          	jal	80000e34 <myproc>
    80001dd4:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80001dd6:	06053903          	ld	s2,96(a0)
    80001dda:	0a893783          	ld	a5,168(s2)
    80001dde:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80001de2:	37fd                	addiw	a5,a5,-1
    80001de4:	02300713          	li	a4,35
    80001de8:	00f76f63          	bltu	a4,a5,80001e06 <syscall+0x42>
    80001dec:	00369713          	slli	a4,a3,0x3
    80001df0:	00007797          	auipc	a5,0x7
    80001df4:	d7078793          	addi	a5,a5,-656 # 80008b60 <syscalls>
    80001df8:	97ba                	add	a5,a5,a4
    80001dfa:	639c                	ld	a5,0(a5)
    80001dfc:	c789                	beqz	a5,80001e06 <syscall+0x42>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    80001dfe:	9782                	jalr	a5
    80001e00:	06a93823          	sd	a0,112(s2)
    80001e04:	a829                	j	80001e1e <syscall+0x5a>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80001e06:	16048613          	addi	a2,s1,352
    80001e0a:	5c8c                	lw	a1,56(s1)
    80001e0c:	00006517          	auipc	a0,0x6
    80001e10:	50450513          	addi	a0,a0,1284 # 80008310 <etext+0x310>
    80001e14:	113030ef          	jal	80005726 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80001e18:	70bc                	ld	a5,96(s1)
    80001e1a:	577d                	li	a4,-1
    80001e1c:	fbb8                	sd	a4,112(a5)
  }
}
    80001e1e:	60e2                	ld	ra,24(sp)
    80001e20:	6442                	ld	s0,16(sp)
    80001e22:	64a2                	ld	s1,8(sp)
    80001e24:	6902                	ld	s2,0(sp)
    80001e26:	6105                	addi	sp,sp,32
    80001e28:	8082                	ret

0000000080001e2a <sys_exit>:
#endif
#include "vm.h"

uint64
sys_exit(void)
{
    80001e2a:	1101                	addi	sp,sp,-32
    80001e2c:	ec06                	sd	ra,24(sp)
    80001e2e:	e822                	sd	s0,16(sp)
    80001e30:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80001e32:	fec40593          	addi	a1,s0,-20
    80001e36:	4501                	li	a0,0
    80001e38:	f2dff0ef          	jal	80001d64 <argint>
  kexit(n);
    80001e3c:	fec42503          	lw	a0,-20(s0)
    80001e40:	f36ff0ef          	jal	80001576 <kexit>
  return 0;  // not reached
}
    80001e44:	4501                	li	a0,0
    80001e46:	60e2                	ld	ra,24(sp)
    80001e48:	6442                	ld	s0,16(sp)
    80001e4a:	6105                	addi	sp,sp,32
    80001e4c:	8082                	ret

0000000080001e4e <sys_getpid>:

uint64
sys_getpid(void)
{
    80001e4e:	1141                	addi	sp,sp,-16
    80001e50:	e406                	sd	ra,8(sp)
    80001e52:	e022                	sd	s0,0(sp)
    80001e54:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80001e56:	fdffe0ef          	jal	80000e34 <myproc>
}
    80001e5a:	5d08                	lw	a0,56(a0)
    80001e5c:	60a2                	ld	ra,8(sp)
    80001e5e:	6402                	ld	s0,0(sp)
    80001e60:	0141                	addi	sp,sp,16
    80001e62:	8082                	ret

0000000080001e64 <sys_fork>:

uint64
sys_fork(void)
{
    80001e64:	1141                	addi	sp,sp,-16
    80001e66:	e406                	sd	ra,8(sp)
    80001e68:	e022                	sd	s0,0(sp)
    80001e6a:	0800                	addi	s0,sp,16
  return kfork();
    80001e6c:	b20ff0ef          	jal	8000118c <kfork>
}
    80001e70:	60a2                	ld	ra,8(sp)
    80001e72:	6402                	ld	s0,0(sp)
    80001e74:	0141                	addi	sp,sp,16
    80001e76:	8082                	ret

0000000080001e78 <sys_wait>:

uint64
sys_wait(void)
{
    80001e78:	1101                	addi	sp,sp,-32
    80001e7a:	ec06                	sd	ra,24(sp)
    80001e7c:	e822                	sd	s0,16(sp)
    80001e7e:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80001e80:	fe840593          	addi	a1,s0,-24
    80001e84:	4501                	li	a0,0
    80001e86:	efbff0ef          	jal	80001d80 <argaddr>
  return kwait(p);
    80001e8a:	fe843503          	ld	a0,-24(s0)
    80001e8e:	843ff0ef          	jal	800016d0 <kwait>
}
    80001e92:	60e2                	ld	ra,24(sp)
    80001e94:	6442                	ld	s0,16(sp)
    80001e96:	6105                	addi	sp,sp,32
    80001e98:	8082                	ret

0000000080001e9a <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80001e9a:	7179                	addi	sp,sp,-48
    80001e9c:	f406                	sd	ra,40(sp)
    80001e9e:	f022                	sd	s0,32(sp)
    80001ea0:	ec26                	sd	s1,24(sp)
    80001ea2:	1800                	addi	s0,sp,48
  uint64 addr;
  int t;
  int n;

  argint(0, &n);
    80001ea4:	fd840593          	addi	a1,s0,-40
    80001ea8:	4501                	li	a0,0
    80001eaa:	ebbff0ef          	jal	80001d64 <argint>
  argint(1, &t);
    80001eae:	fdc40593          	addi	a1,s0,-36
    80001eb2:	4505                	li	a0,1
    80001eb4:	eb1ff0ef          	jal	80001d64 <argint>
  addr = myproc()->sz;
    80001eb8:	f7dfe0ef          	jal	80000e34 <myproc>
    80001ebc:	6924                	ld	s1,80(a0)

  if(t == SBRK_EAGER || n < 0) {
    80001ebe:	fdc42703          	lw	a4,-36(s0)
    80001ec2:	4785                	li	a5,1
    80001ec4:	02f70163          	beq	a4,a5,80001ee6 <sys_sbrk+0x4c>
    80001ec8:	fd842783          	lw	a5,-40(s0)
    80001ecc:	0007cd63          	bltz	a5,80001ee6 <sys_sbrk+0x4c>
    }
  } else {
    // Lazily allocate memory for this process: increase its memory
    // size but don't allocate memory. If the processes uses the
    // memory, vmfault() will allocate it.
    if(addr + n < addr)
    80001ed0:	97a6                	add	a5,a5,s1
    80001ed2:	0297e863          	bltu	a5,s1,80001f02 <sys_sbrk+0x68>
      return -1;
    myproc()->sz += n;
    80001ed6:	f5ffe0ef          	jal	80000e34 <myproc>
    80001eda:	fd842703          	lw	a4,-40(s0)
    80001ede:	693c                	ld	a5,80(a0)
    80001ee0:	97ba                	add	a5,a5,a4
    80001ee2:	e93c                	sd	a5,80(a0)
    80001ee4:	a039                	j	80001ef2 <sys_sbrk+0x58>
    if(growproc(n) < 0) {
    80001ee6:	fd842503          	lw	a0,-40(s0)
    80001eea:	a52ff0ef          	jal	8000113c <growproc>
    80001eee:	00054863          	bltz	a0,80001efe <sys_sbrk+0x64>
  }
  return addr;
}
    80001ef2:	8526                	mv	a0,s1
    80001ef4:	70a2                	ld	ra,40(sp)
    80001ef6:	7402                	ld	s0,32(sp)
    80001ef8:	64e2                	ld	s1,24(sp)
    80001efa:	6145                	addi	sp,sp,48
    80001efc:	8082                	ret
      return -1;
    80001efe:	54fd                	li	s1,-1
    80001f00:	bfcd                	j	80001ef2 <sys_sbrk+0x58>
      return -1;
    80001f02:	54fd                	li	s1,-1
    80001f04:	b7fd                	j	80001ef2 <sys_sbrk+0x58>

0000000080001f06 <sys_pause>:

uint64
sys_pause(void)
{
    80001f06:	7139                	addi	sp,sp,-64
    80001f08:	fc06                	sd	ra,56(sp)
    80001f0a:	f822                	sd	s0,48(sp)
    80001f0c:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;


  argint(0, &n);
    80001f0e:	fcc40593          	addi	a1,s0,-52
    80001f12:	4501                	li	a0,0
    80001f14:	e51ff0ef          	jal	80001d64 <argint>
  if(n < 0)
    80001f18:	fcc42783          	lw	a5,-52(s0)
    80001f1c:	0607c863          	bltz	a5,80001f8c <sys_pause+0x86>
    n = 0;
  acquire(&tickslock);
    80001f20:	0000d517          	auipc	a0,0xd
    80001f24:	1c050513          	addi	a0,a0,448 # 8000f0e0 <tickslock>
    80001f28:	673030ef          	jal	80005d9a <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    80001f2c:	fcc42783          	lw	a5,-52(s0)
    80001f30:	c3b9                	beqz	a5,80001f76 <sys_pause+0x70>
    80001f32:	f426                	sd	s1,40(sp)
    80001f34:	f04a                	sd	s2,32(sp)
    80001f36:	ec4e                	sd	s3,24(sp)
  ticks0 = ticks;
    80001f38:	00007997          	auipc	s3,0x7
    80001f3c:	db09a983          	lw	s3,-592(s3) # 80008ce8 <ticks>
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80001f40:	0000d917          	auipc	s2,0xd
    80001f44:	1a090913          	addi	s2,s2,416 # 8000f0e0 <tickslock>
    80001f48:	00007497          	auipc	s1,0x7
    80001f4c:	da048493          	addi	s1,s1,-608 # 80008ce8 <ticks>
    if(killed(myproc())){
    80001f50:	ee5fe0ef          	jal	80000e34 <myproc>
    80001f54:	f52ff0ef          	jal	800016a6 <killed>
    80001f58:	ed0d                	bnez	a0,80001f92 <sys_pause+0x8c>
    sleep(&ticks, &tickslock);
    80001f5a:	85ca                	mv	a1,s2
    80001f5c:	8526                	mv	a0,s1
    80001f5e:	d0cff0ef          	jal	8000146a <sleep>
  while(ticks - ticks0 < n){
    80001f62:	409c                	lw	a5,0(s1)
    80001f64:	413787bb          	subw	a5,a5,s3
    80001f68:	fcc42703          	lw	a4,-52(s0)
    80001f6c:	fee7e2e3          	bltu	a5,a4,80001f50 <sys_pause+0x4a>
    80001f70:	74a2                	ld	s1,40(sp)
    80001f72:	7902                	ld	s2,32(sp)
    80001f74:	69e2                	ld	s3,24(sp)
  }
  release(&tickslock);
    80001f76:	0000d517          	auipc	a0,0xd
    80001f7a:	16a50513          	addi	a0,a0,362 # 8000f0e0 <tickslock>
    80001f7e:	759030ef          	jal	80005ed6 <release>
  return 0;
    80001f82:	4501                	li	a0,0
}
    80001f84:	70e2                	ld	ra,56(sp)
    80001f86:	7442                	ld	s0,48(sp)
    80001f88:	6121                	addi	sp,sp,64
    80001f8a:	8082                	ret
    n = 0;
    80001f8c:	fc042623          	sw	zero,-52(s0)
    80001f90:	bf41                	j	80001f20 <sys_pause+0x1a>
      release(&tickslock);
    80001f92:	0000d517          	auipc	a0,0xd
    80001f96:	14e50513          	addi	a0,a0,334 # 8000f0e0 <tickslock>
    80001f9a:	73d030ef          	jal	80005ed6 <release>
      return -1;
    80001f9e:	557d                	li	a0,-1
    80001fa0:	74a2                	ld	s1,40(sp)
    80001fa2:	7902                	ld	s2,32(sp)
    80001fa4:	69e2                	ld	s3,24(sp)
    80001fa6:	bff9                	j	80001f84 <sys_pause+0x7e>

0000000080001fa8 <sys_kill>:
#endif


uint64
sys_kill(void)
{
    80001fa8:	1101                	addi	sp,sp,-32
    80001faa:	ec06                	sd	ra,24(sp)
    80001fac:	e822                	sd	s0,16(sp)
    80001fae:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80001fb0:	fec40593          	addi	a1,s0,-20
    80001fb4:	4501                	li	a0,0
    80001fb6:	dafff0ef          	jal	80001d64 <argint>
  return kkill(pid);
    80001fba:	fec42503          	lw	a0,-20(s0)
    80001fbe:	e5eff0ef          	jal	8000161c <kkill>
}
    80001fc2:	60e2                	ld	ra,24(sp)
    80001fc4:	6442                	ld	s0,16(sp)
    80001fc6:	6105                	addi	sp,sp,32
    80001fc8:	8082                	ret

0000000080001fca <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80001fca:	1101                	addi	sp,sp,-32
    80001fcc:	ec06                	sd	ra,24(sp)
    80001fce:	e822                	sd	s0,16(sp)
    80001fd0:	e426                	sd	s1,8(sp)
    80001fd2:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80001fd4:	0000d517          	auipc	a0,0xd
    80001fd8:	10c50513          	addi	a0,a0,268 # 8000f0e0 <tickslock>
    80001fdc:	5bf030ef          	jal	80005d9a <acquire>
  xticks = ticks;
    80001fe0:	00007797          	auipc	a5,0x7
    80001fe4:	d087a783          	lw	a5,-760(a5) # 80008ce8 <ticks>
    80001fe8:	84be                	mv	s1,a5
  release(&tickslock);
    80001fea:	0000d517          	auipc	a0,0xd
    80001fee:	0f650513          	addi	a0,a0,246 # 8000f0e0 <tickslock>
    80001ff2:	6e5030ef          	jal	80005ed6 <release>
  return xticks;
}
    80001ff6:	02049513          	slli	a0,s1,0x20
    80001ffa:	9101                	srli	a0,a0,0x20
    80001ffc:	60e2                	ld	ra,24(sp)
    80001ffe:	6442                	ld	s0,16(sp)
    80002000:	64a2                	ld	s1,8(sp)
    80002002:	6105                	addi	sp,sp,32
    80002004:	8082                	ret

0000000080002006 <sys_cpupin>:

#ifdef LAB_LOCK
uint64
sys_cpupin(void)
{
    80002006:	7179                	addi	sp,sp,-48
    80002008:	f406                	sd	ra,40(sp)
    8000200a:	f022                	sd	s0,32(sp)
    8000200c:	ec26                	sd	s1,24(sp)
    8000200e:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80002010:	e25fe0ef          	jal	80000e34 <myproc>
    80002014:	84aa                	mv	s1,a0
  int cpu;

  argint(0, &cpu);
    80002016:	fdc40593          	addi	a1,s0,-36
    8000201a:	4501                	li	a0,0
    8000201c:	d49ff0ef          	jal	80001d64 <argint>
  if (cpu < 0 || cpu >= NCPU)
    80002020:	fdc42703          	lw	a4,-36(s0)
    80002024:	479d                	li	a5,7
    return -1;
    80002026:	557d                	li	a0,-1
  if (cpu < 0 || cpu >= NCPU)
    80002028:	02e7e363          	bltu	a5,a4,8000204e <sys_cpupin+0x48>
  acquire(&p->lock);
    8000202c:	8526                	mv	a0,s1
    8000202e:	56d030ef          	jal	80005d9a <acquire>
  p->pincpu = &cpus[cpu];
    80002032:	fdc42783          	lw	a5,-36(s0)
    80002036:	079e                	slli	a5,a5,0x7
    80002038:	00007717          	auipc	a4,0x7
    8000203c:	ea870713          	addi	a4,a4,-344 # 80008ee0 <cpus>
    80002040:	97ba                	add	a5,a5,a4
    80002042:	16f4b823          	sd	a5,368(s1)
  release(&p->lock);
    80002046:	8526                	mv	a0,s1
    80002048:	68f030ef          	jal	80005ed6 <release>
  return 0;
    8000204c:	4501                	li	a0,0
}
    8000204e:	70a2                	ld	ra,40(sp)
    80002050:	7402                	ld	s0,32(sp)
    80002052:	64e2                	ld	s1,24(sp)
    80002054:	6145                	addi	sp,sp,48
    80002056:	8082                	ret

0000000080002058 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80002058:	7179                	addi	sp,sp,-48
    8000205a:	f406                	sd	ra,40(sp)
    8000205c:	f022                	sd	s0,32(sp)
    8000205e:	ec26                	sd	s1,24(sp)
    80002060:	e84a                	sd	s2,16(sp)
    80002062:	e44e                	sd	s3,8(sp)
    80002064:	e052                	sd	s4,0(sp)
    80002066:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80002068:	00006597          	auipc	a1,0x6
    8000206c:	2c858593          	addi	a1,a1,712 # 80008330 <etext+0x330>
    80002070:	0000d517          	auipc	a0,0xd
    80002074:	09050513          	addi	a0,a0,144 # 8000f100 <bcache>
    80002078:	6f7030ef          	jal	80005f6e <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    8000207c:	00015797          	auipc	a5,0x15
    80002080:	08478793          	addi	a5,a5,132 # 80017100 <bcache+0x8000>
    80002084:	00015717          	auipc	a4,0x15
    80002088:	3dc70713          	addi	a4,a4,988 # 80017460 <bcache+0x8360>
    8000208c:	3ae7b823          	sd	a4,944(a5)
  bcache.head.next = &bcache.head;
    80002090:	3ae7bc23          	sd	a4,952(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002094:	0000d497          	auipc	s1,0xd
    80002098:	08c48493          	addi	s1,s1,140 # 8000f120 <bcache+0x20>
    b->next = bcache.head.next;
    8000209c:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    8000209e:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    800020a0:	00006a17          	auipc	s4,0x6
    800020a4:	298a0a13          	addi	s4,s4,664 # 80008338 <etext+0x338>
    b->next = bcache.head.next;
    800020a8:	3b893783          	ld	a5,952(s2)
    800020ac:	ecbc                	sd	a5,88(s1)
    b->prev = &bcache.head;
    800020ae:	0534b823          	sd	s3,80(s1)
    initsleeplock(&b->lock, "buffer");
    800020b2:	85d2                	mv	a1,s4
    800020b4:	01048513          	addi	a0,s1,16
    800020b8:	342010ef          	jal	800033fa <initsleeplock>
    bcache.head.next->prev = b;
    800020bc:	3b893783          	ld	a5,952(s2)
    800020c0:	eba4                	sd	s1,80(a5)
    bcache.head.next = b;
    800020c2:	3a993c23          	sd	s1,952(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800020c6:	46048493          	addi	s1,s1,1120
    800020ca:	fd349fe3          	bne	s1,s3,800020a8 <binit+0x50>
  }
}
    800020ce:	70a2                	ld	ra,40(sp)
    800020d0:	7402                	ld	s0,32(sp)
    800020d2:	64e2                	ld	s1,24(sp)
    800020d4:	6942                	ld	s2,16(sp)
    800020d6:	69a2                	ld	s3,8(sp)
    800020d8:	6a02                	ld	s4,0(sp)
    800020da:	6145                	addi	sp,sp,48
    800020dc:	8082                	ret

00000000800020de <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    800020de:	7179                	addi	sp,sp,-48
    800020e0:	f406                	sd	ra,40(sp)
    800020e2:	f022                	sd	s0,32(sp)
    800020e4:	ec26                	sd	s1,24(sp)
    800020e6:	e84a                	sd	s2,16(sp)
    800020e8:	e44e                	sd	s3,8(sp)
    800020ea:	1800                	addi	s0,sp,48
    800020ec:	892a                	mv	s2,a0
    800020ee:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    800020f0:	0000d517          	auipc	a0,0xd
    800020f4:	01050513          	addi	a0,a0,16 # 8000f100 <bcache>
    800020f8:	4a3030ef          	jal	80005d9a <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800020fc:	00015497          	auipc	s1,0x15
    80002100:	3bc4b483          	ld	s1,956(s1) # 800174b8 <bcache+0x83b8>
    80002104:	00015797          	auipc	a5,0x15
    80002108:	35c78793          	addi	a5,a5,860 # 80017460 <bcache+0x8360>
    8000210c:	02f48b63          	beq	s1,a5,80002142 <bread+0x64>
    80002110:	873e                	mv	a4,a5
    80002112:	a021                	j	8000211a <bread+0x3c>
    80002114:	6ca4                	ld	s1,88(s1)
    80002116:	02e48663          	beq	s1,a4,80002142 <bread+0x64>
    if(b->dev == dev && b->blockno == blockno){
    8000211a:	449c                	lw	a5,8(s1)
    8000211c:	ff279ce3          	bne	a5,s2,80002114 <bread+0x36>
    80002120:	44dc                	lw	a5,12(s1)
    80002122:	ff3799e3          	bne	a5,s3,80002114 <bread+0x36>
      b->refcnt++;
    80002126:	44bc                	lw	a5,72(s1)
    80002128:	2785                	addiw	a5,a5,1
    8000212a:	c4bc                	sw	a5,72(s1)
      release(&bcache.lock);
    8000212c:	0000d517          	auipc	a0,0xd
    80002130:	fd450513          	addi	a0,a0,-44 # 8000f100 <bcache>
    80002134:	5a3030ef          	jal	80005ed6 <release>
      acquiresleep(&b->lock);
    80002138:	01048513          	addi	a0,s1,16
    8000213c:	2f4010ef          	jal	80003430 <acquiresleep>
      return b;
    80002140:	a889                	j	80002192 <bread+0xb4>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002142:	00015497          	auipc	s1,0x15
    80002146:	36e4b483          	ld	s1,878(s1) # 800174b0 <bcache+0x83b0>
    8000214a:	00015797          	auipc	a5,0x15
    8000214e:	31678793          	addi	a5,a5,790 # 80017460 <bcache+0x8360>
    80002152:	00f48863          	beq	s1,a5,80002162 <bread+0x84>
    80002156:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80002158:	44bc                	lw	a5,72(s1)
    8000215a:	cb91                	beqz	a5,8000216e <bread+0x90>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    8000215c:	68a4                	ld	s1,80(s1)
    8000215e:	fee49de3          	bne	s1,a4,80002158 <bread+0x7a>
  panic("bget: no buffers");
    80002162:	00006517          	auipc	a0,0x6
    80002166:	1de50513          	addi	a0,a0,478 # 80008340 <etext+0x340>
    8000216a:	0f5030ef          	jal	80005a5e <panic>
      b->dev = dev;
    8000216e:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80002172:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80002176:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    8000217a:	4785                	li	a5,1
    8000217c:	c4bc                	sw	a5,72(s1)
      release(&bcache.lock);
    8000217e:	0000d517          	auipc	a0,0xd
    80002182:	f8250513          	addi	a0,a0,-126 # 8000f100 <bcache>
    80002186:	551030ef          	jal	80005ed6 <release>
      acquiresleep(&b->lock);
    8000218a:	01048513          	addi	a0,s1,16
    8000218e:	2a2010ef          	jal	80003430 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002192:	409c                	lw	a5,0(s1)
    80002194:	cb89                	beqz	a5,800021a6 <bread+0xc8>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002196:	8526                	mv	a0,s1
    80002198:	70a2                	ld	ra,40(sp)
    8000219a:	7402                	ld	s0,32(sp)
    8000219c:	64e2                	ld	s1,24(sp)
    8000219e:	6942                	ld	s2,16(sp)
    800021a0:	69a2                	ld	s3,8(sp)
    800021a2:	6145                	addi	sp,sp,48
    800021a4:	8082                	ret
    virtio_disk_rw(b, 0);
    800021a6:	4581                	li	a1,0
    800021a8:	8526                	mv	a0,s1
    800021aa:	269020ef          	jal	80004c12 <virtio_disk_rw>
    b->valid = 1;
    800021ae:	4785                	li	a5,1
    800021b0:	c09c                	sw	a5,0(s1)
  return b;
    800021b2:	b7d5                	j	80002196 <bread+0xb8>

00000000800021b4 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800021b4:	1101                	addi	sp,sp,-32
    800021b6:	ec06                	sd	ra,24(sp)
    800021b8:	e822                	sd	s0,16(sp)
    800021ba:	e426                	sd	s1,8(sp)
    800021bc:	1000                	addi	s0,sp,32
    800021be:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800021c0:	0541                	addi	a0,a0,16
    800021c2:	2ec010ef          	jal	800034ae <holdingsleep>
    800021c6:	c911                	beqz	a0,800021da <bwrite+0x26>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    800021c8:	4585                	li	a1,1
    800021ca:	8526                	mv	a0,s1
    800021cc:	247020ef          	jal	80004c12 <virtio_disk_rw>
}
    800021d0:	60e2                	ld	ra,24(sp)
    800021d2:	6442                	ld	s0,16(sp)
    800021d4:	64a2                	ld	s1,8(sp)
    800021d6:	6105                	addi	sp,sp,32
    800021d8:	8082                	ret
    panic("bwrite");
    800021da:	00006517          	auipc	a0,0x6
    800021de:	17e50513          	addi	a0,a0,382 # 80008358 <etext+0x358>
    800021e2:	07d030ef          	jal	80005a5e <panic>

00000000800021e6 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800021e6:	1101                	addi	sp,sp,-32
    800021e8:	ec06                	sd	ra,24(sp)
    800021ea:	e822                	sd	s0,16(sp)
    800021ec:	e426                	sd	s1,8(sp)
    800021ee:	e04a                	sd	s2,0(sp)
    800021f0:	1000                	addi	s0,sp,32
    800021f2:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800021f4:	01050913          	addi	s2,a0,16
    800021f8:	854a                	mv	a0,s2
    800021fa:	2b4010ef          	jal	800034ae <holdingsleep>
    800021fe:	c125                	beqz	a0,8000225e <brelse+0x78>
    panic("brelse");

  releasesleep(&b->lock);
    80002200:	854a                	mv	a0,s2
    80002202:	274010ef          	jal	80003476 <releasesleep>

  acquire(&bcache.lock);
    80002206:	0000d517          	auipc	a0,0xd
    8000220a:	efa50513          	addi	a0,a0,-262 # 8000f100 <bcache>
    8000220e:	38d030ef          	jal	80005d9a <acquire>
  b->refcnt--;
    80002212:	44bc                	lw	a5,72(s1)
    80002214:	37fd                	addiw	a5,a5,-1
    80002216:	c4bc                	sw	a5,72(s1)
  if (b->refcnt == 0) {
    80002218:	e79d                	bnez	a5,80002246 <brelse+0x60>
    // no one is waiting for it.
    b->next->prev = b->prev;
    8000221a:	6cb8                	ld	a4,88(s1)
    8000221c:	68bc                	ld	a5,80(s1)
    8000221e:	eb3c                	sd	a5,80(a4)
    b->prev->next = b->next;
    80002220:	6cb8                	ld	a4,88(s1)
    80002222:	efb8                	sd	a4,88(a5)
    b->next = bcache.head.next;
    80002224:	00015797          	auipc	a5,0x15
    80002228:	edc78793          	addi	a5,a5,-292 # 80017100 <bcache+0x8000>
    8000222c:	3b87b703          	ld	a4,952(a5)
    80002230:	ecb8                	sd	a4,88(s1)
    b->prev = &bcache.head;
    80002232:	00015717          	auipc	a4,0x15
    80002236:	22e70713          	addi	a4,a4,558 # 80017460 <bcache+0x8360>
    8000223a:	e8b8                	sd	a4,80(s1)
    bcache.head.next->prev = b;
    8000223c:	3b87b703          	ld	a4,952(a5)
    80002240:	eb24                	sd	s1,80(a4)
    bcache.head.next = b;
    80002242:	3a97bc23          	sd	s1,952(a5)
  }
  
  release(&bcache.lock);
    80002246:	0000d517          	auipc	a0,0xd
    8000224a:	eba50513          	addi	a0,a0,-326 # 8000f100 <bcache>
    8000224e:	489030ef          	jal	80005ed6 <release>
}
    80002252:	60e2                	ld	ra,24(sp)
    80002254:	6442                	ld	s0,16(sp)
    80002256:	64a2                	ld	s1,8(sp)
    80002258:	6902                	ld	s2,0(sp)
    8000225a:	6105                	addi	sp,sp,32
    8000225c:	8082                	ret
    panic("brelse");
    8000225e:	00006517          	auipc	a0,0x6
    80002262:	10250513          	addi	a0,a0,258 # 80008360 <etext+0x360>
    80002266:	7f8030ef          	jal	80005a5e <panic>

000000008000226a <bpin>:

void
bpin(struct buf *b) {
    8000226a:	1101                	addi	sp,sp,-32
    8000226c:	ec06                	sd	ra,24(sp)
    8000226e:	e822                	sd	s0,16(sp)
    80002270:	e426                	sd	s1,8(sp)
    80002272:	1000                	addi	s0,sp,32
    80002274:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002276:	0000d517          	auipc	a0,0xd
    8000227a:	e8a50513          	addi	a0,a0,-374 # 8000f100 <bcache>
    8000227e:	31d030ef          	jal	80005d9a <acquire>
  b->refcnt++;
    80002282:	44bc                	lw	a5,72(s1)
    80002284:	2785                	addiw	a5,a5,1
    80002286:	c4bc                	sw	a5,72(s1)
  release(&bcache.lock);
    80002288:	0000d517          	auipc	a0,0xd
    8000228c:	e7850513          	addi	a0,a0,-392 # 8000f100 <bcache>
    80002290:	447030ef          	jal	80005ed6 <release>
}
    80002294:	60e2                	ld	ra,24(sp)
    80002296:	6442                	ld	s0,16(sp)
    80002298:	64a2                	ld	s1,8(sp)
    8000229a:	6105                	addi	sp,sp,32
    8000229c:	8082                	ret

000000008000229e <bunpin>:

void
bunpin(struct buf *b) {
    8000229e:	1101                	addi	sp,sp,-32
    800022a0:	ec06                	sd	ra,24(sp)
    800022a2:	e822                	sd	s0,16(sp)
    800022a4:	e426                	sd	s1,8(sp)
    800022a6:	1000                	addi	s0,sp,32
    800022a8:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800022aa:	0000d517          	auipc	a0,0xd
    800022ae:	e5650513          	addi	a0,a0,-426 # 8000f100 <bcache>
    800022b2:	2e9030ef          	jal	80005d9a <acquire>
  b->refcnt--;
    800022b6:	44bc                	lw	a5,72(s1)
    800022b8:	37fd                	addiw	a5,a5,-1
    800022ba:	c4bc                	sw	a5,72(s1)
  release(&bcache.lock);
    800022bc:	0000d517          	auipc	a0,0xd
    800022c0:	e4450513          	addi	a0,a0,-444 # 8000f100 <bcache>
    800022c4:	413030ef          	jal	80005ed6 <release>
}
    800022c8:	60e2                	ld	ra,24(sp)
    800022ca:	6442                	ld	s0,16(sp)
    800022cc:	64a2                	ld	s1,8(sp)
    800022ce:	6105                	addi	sp,sp,32
    800022d0:	8082                	ret

00000000800022d2 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800022d2:	1101                	addi	sp,sp,-32
    800022d4:	ec06                	sd	ra,24(sp)
    800022d6:	e822                	sd	s0,16(sp)
    800022d8:	e426                	sd	s1,8(sp)
    800022da:	e04a                	sd	s2,0(sp)
    800022dc:	1000                	addi	s0,sp,32
    800022de:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800022e0:	00d5d79b          	srliw	a5,a1,0xd
    800022e4:	00015597          	auipc	a1,0x15
    800022e8:	5f85a583          	lw	a1,1528(a1) # 800178dc <sb+0x1c>
    800022ec:	9dbd                	addw	a1,a1,a5
    800022ee:	df1ff0ef          	jal	800020de <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    800022f2:	0074f713          	andi	a4,s1,7
    800022f6:	4785                	li	a5,1
    800022f8:	00e797bb          	sllw	a5,a5,a4
  bi = b % BPB;
    800022fc:	14ce                	slli	s1,s1,0x33
  if((bp->data[bi/8] & m) == 0)
    800022fe:	90d9                	srli	s1,s1,0x36
    80002300:	00950733          	add	a4,a0,s1
    80002304:	06074703          	lbu	a4,96(a4)
    80002308:	00e7f6b3          	and	a3,a5,a4
    8000230c:	c29d                	beqz	a3,80002332 <bfree+0x60>
    8000230e:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002310:	94aa                	add	s1,s1,a0
    80002312:	fff7c793          	not	a5,a5
    80002316:	8f7d                	and	a4,a4,a5
    80002318:	06e48023          	sb	a4,96(s1)
  log_write(bp);
    8000231c:	01e010ef          	jal	8000333a <log_write>
  brelse(bp);
    80002320:	854a                	mv	a0,s2
    80002322:	ec5ff0ef          	jal	800021e6 <brelse>
}
    80002326:	60e2                	ld	ra,24(sp)
    80002328:	6442                	ld	s0,16(sp)
    8000232a:	64a2                	ld	s1,8(sp)
    8000232c:	6902                	ld	s2,0(sp)
    8000232e:	6105                	addi	sp,sp,32
    80002330:	8082                	ret
    panic("freeing free block");
    80002332:	00006517          	auipc	a0,0x6
    80002336:	03650513          	addi	a0,a0,54 # 80008368 <etext+0x368>
    8000233a:	724030ef          	jal	80005a5e <panic>

000000008000233e <balloc>:
{
    8000233e:	715d                	addi	sp,sp,-80
    80002340:	e486                	sd	ra,72(sp)
    80002342:	e0a2                	sd	s0,64(sp)
    80002344:	fc26                	sd	s1,56(sp)
    80002346:	0880                	addi	s0,sp,80
  for(b = 0; b < sb.size; b += BPB){
    80002348:	00015797          	auipc	a5,0x15
    8000234c:	57c7a783          	lw	a5,1404(a5) # 800178c4 <sb+0x4>
    80002350:	0e078263          	beqz	a5,80002434 <balloc+0xf6>
    80002354:	f84a                	sd	s2,48(sp)
    80002356:	f44e                	sd	s3,40(sp)
    80002358:	f052                	sd	s4,32(sp)
    8000235a:	ec56                	sd	s5,24(sp)
    8000235c:	e85a                	sd	s6,16(sp)
    8000235e:	e45e                	sd	s7,8(sp)
    80002360:	e062                	sd	s8,0(sp)
    80002362:	8baa                	mv	s7,a0
    80002364:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002366:	00015b17          	auipc	s6,0x15
    8000236a:	55ab0b13          	addi	s6,s6,1370 # 800178c0 <sb>
      m = 1 << (bi % 8);
    8000236e:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002370:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80002372:	6c09                	lui	s8,0x2
    80002374:	a09d                	j	800023da <balloc+0x9c>
        bp->data[bi/8] |= m;  // Mark block in use.
    80002376:	97ca                	add	a5,a5,s2
    80002378:	8e55                	or	a2,a2,a3
    8000237a:	06c78023          	sb	a2,96(a5)
        log_write(bp);
    8000237e:	854a                	mv	a0,s2
    80002380:	7bb000ef          	jal	8000333a <log_write>
        brelse(bp);
    80002384:	854a                	mv	a0,s2
    80002386:	e61ff0ef          	jal	800021e6 <brelse>
  bp = bread(dev, bno);
    8000238a:	85a6                	mv	a1,s1
    8000238c:	855e                	mv	a0,s7
    8000238e:	d51ff0ef          	jal	800020de <bread>
    80002392:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    80002394:	40000613          	li	a2,1024
    80002398:	4581                	li	a1,0
    8000239a:	06050513          	addi	a0,a0,96
    8000239e:	e99fd0ef          	jal	80000236 <memset>
  log_write(bp);
    800023a2:	854a                	mv	a0,s2
    800023a4:	797000ef          	jal	8000333a <log_write>
  brelse(bp);
    800023a8:	854a                	mv	a0,s2
    800023aa:	e3dff0ef          	jal	800021e6 <brelse>
        return b + bi;
    800023ae:	7942                	ld	s2,48(sp)
    800023b0:	79a2                	ld	s3,40(sp)
    800023b2:	7a02                	ld	s4,32(sp)
    800023b4:	6ae2                	ld	s5,24(sp)
    800023b6:	6b42                	ld	s6,16(sp)
    800023b8:	6ba2                	ld	s7,8(sp)
    800023ba:	6c02                	ld	s8,0(sp)
}
    800023bc:	8526                	mv	a0,s1
    800023be:	60a6                	ld	ra,72(sp)
    800023c0:	6406                	ld	s0,64(sp)
    800023c2:	74e2                	ld	s1,56(sp)
    800023c4:	6161                	addi	sp,sp,80
    800023c6:	8082                	ret
    brelse(bp);
    800023c8:	854a                	mv	a0,s2
    800023ca:	e1dff0ef          	jal	800021e6 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    800023ce:	015c0abb          	addw	s5,s8,s5
    800023d2:	004b2783          	lw	a5,4(s6)
    800023d6:	04faf863          	bgeu	s5,a5,80002426 <balloc+0xe8>
    bp = bread(dev, BBLOCK(b, sb));
    800023da:	40dad59b          	sraiw	a1,s5,0xd
    800023de:	01cb2783          	lw	a5,28(s6)
    800023e2:	9dbd                	addw	a1,a1,a5
    800023e4:	855e                	mv	a0,s7
    800023e6:	cf9ff0ef          	jal	800020de <bread>
    800023ea:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800023ec:	004b2503          	lw	a0,4(s6)
    800023f0:	84d6                	mv	s1,s5
    800023f2:	4701                	li	a4,0
    800023f4:	fca4fae3          	bgeu	s1,a0,800023c8 <balloc+0x8a>
      m = 1 << (bi % 8);
    800023f8:	00777693          	andi	a3,a4,7
    800023fc:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002400:	41f7579b          	sraiw	a5,a4,0x1f
    80002404:	01d7d79b          	srliw	a5,a5,0x1d
    80002408:	9fb9                	addw	a5,a5,a4
    8000240a:	4037d79b          	sraiw	a5,a5,0x3
    8000240e:	00f90633          	add	a2,s2,a5
    80002412:	06064603          	lbu	a2,96(a2)
    80002416:	00c6f5b3          	and	a1,a3,a2
    8000241a:	ddb1                	beqz	a1,80002376 <balloc+0x38>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000241c:	2705                	addiw	a4,a4,1
    8000241e:	2485                	addiw	s1,s1,1
    80002420:	fd471ae3          	bne	a4,s4,800023f4 <balloc+0xb6>
    80002424:	b755                	j	800023c8 <balloc+0x8a>
    80002426:	7942                	ld	s2,48(sp)
    80002428:	79a2                	ld	s3,40(sp)
    8000242a:	7a02                	ld	s4,32(sp)
    8000242c:	6ae2                	ld	s5,24(sp)
    8000242e:	6b42                	ld	s6,16(sp)
    80002430:	6ba2                	ld	s7,8(sp)
    80002432:	6c02                	ld	s8,0(sp)
  printf("balloc: out of blocks\n");
    80002434:	00006517          	auipc	a0,0x6
    80002438:	f4c50513          	addi	a0,a0,-180 # 80008380 <etext+0x380>
    8000243c:	2ea030ef          	jal	80005726 <printf>
  return 0;
    80002440:	4481                	li	s1,0
    80002442:	bfad                	j	800023bc <balloc+0x7e>

0000000080002444 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    80002444:	7179                	addi	sp,sp,-48
    80002446:	f406                	sd	ra,40(sp)
    80002448:	f022                	sd	s0,32(sp)
    8000244a:	ec26                	sd	s1,24(sp)
    8000244c:	e84a                	sd	s2,16(sp)
    8000244e:	e44e                	sd	s3,8(sp)
    80002450:	1800                	addi	s0,sp,48
    80002452:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80002454:	47ad                	li	a5,11
    80002456:	02b7e363          	bltu	a5,a1,8000247c <bmap+0x38>
    if((addr = ip->addrs[bn]) == 0){
    8000245a:	02059793          	slli	a5,a1,0x20
    8000245e:	01e7d593          	srli	a1,a5,0x1e
    80002462:	00b509b3          	add	s3,a0,a1
    80002466:	0589a483          	lw	s1,88(s3)
    8000246a:	e0b5                	bnez	s1,800024ce <bmap+0x8a>
      addr = balloc(ip->dev);
    8000246c:	4108                	lw	a0,0(a0)
    8000246e:	ed1ff0ef          	jal	8000233e <balloc>
    80002472:	84aa                	mv	s1,a0
      if(addr == 0)
    80002474:	cd29                	beqz	a0,800024ce <bmap+0x8a>
        return 0;
      ip->addrs[bn] = addr;
    80002476:	04a9ac23          	sw	a0,88(s3)
    8000247a:	a891                	j	800024ce <bmap+0x8a>
    }
    return addr;
  }
  bn -= NDIRECT;
    8000247c:	ff45879b          	addiw	a5,a1,-12
    80002480:	873e                	mv	a4,a5
    80002482:	89be                	mv	s3,a5

  if(bn < NINDIRECT){
    80002484:	0ff00793          	li	a5,255
    80002488:	06e7e763          	bltu	a5,a4,800024f6 <bmap+0xb2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    8000248c:	08852483          	lw	s1,136(a0)
    80002490:	e891                	bnez	s1,800024a4 <bmap+0x60>
      addr = balloc(ip->dev);
    80002492:	4108                	lw	a0,0(a0)
    80002494:	eabff0ef          	jal	8000233e <balloc>
    80002498:	84aa                	mv	s1,a0
      if(addr == 0)
    8000249a:	c915                	beqz	a0,800024ce <bmap+0x8a>
    8000249c:	e052                	sd	s4,0(sp)
        return 0;
      ip->addrs[NDIRECT] = addr;
    8000249e:	08a92423          	sw	a0,136(s2)
    800024a2:	a011                	j	800024a6 <bmap+0x62>
    800024a4:	e052                	sd	s4,0(sp)
    }
    bp = bread(ip->dev, addr);
    800024a6:	85a6                	mv	a1,s1
    800024a8:	00092503          	lw	a0,0(s2)
    800024ac:	c33ff0ef          	jal	800020de <bread>
    800024b0:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    800024b2:	06050793          	addi	a5,a0,96
    if((addr = a[bn]) == 0){
    800024b6:	02099713          	slli	a4,s3,0x20
    800024ba:	01e75593          	srli	a1,a4,0x1e
    800024be:	97ae                	add	a5,a5,a1
    800024c0:	89be                	mv	s3,a5
    800024c2:	4384                	lw	s1,0(a5)
    800024c4:	cc89                	beqz	s1,800024de <bmap+0x9a>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    800024c6:	8552                	mv	a0,s4
    800024c8:	d1fff0ef          	jal	800021e6 <brelse>
    return addr;
    800024cc:	6a02                	ld	s4,0(sp)
  }
  panic("bmap: out of range");
}
    800024ce:	8526                	mv	a0,s1
    800024d0:	70a2                	ld	ra,40(sp)
    800024d2:	7402                	ld	s0,32(sp)
    800024d4:	64e2                	ld	s1,24(sp)
    800024d6:	6942                	ld	s2,16(sp)
    800024d8:	69a2                	ld	s3,8(sp)
    800024da:	6145                	addi	sp,sp,48
    800024dc:	8082                	ret
      addr = balloc(ip->dev);
    800024de:	00092503          	lw	a0,0(s2)
    800024e2:	e5dff0ef          	jal	8000233e <balloc>
    800024e6:	84aa                	mv	s1,a0
      if(addr){
    800024e8:	dd79                	beqz	a0,800024c6 <bmap+0x82>
        a[bn] = addr;
    800024ea:	00a9a023          	sw	a0,0(s3)
        log_write(bp);
    800024ee:	8552                	mv	a0,s4
    800024f0:	64b000ef          	jal	8000333a <log_write>
    800024f4:	bfc9                	j	800024c6 <bmap+0x82>
    800024f6:	e052                	sd	s4,0(sp)
  panic("bmap: out of range");
    800024f8:	00006517          	auipc	a0,0x6
    800024fc:	ea050513          	addi	a0,a0,-352 # 80008398 <etext+0x398>
    80002500:	55e030ef          	jal	80005a5e <panic>

0000000080002504 <iget>:
{
    80002504:	7179                	addi	sp,sp,-48
    80002506:	f406                	sd	ra,40(sp)
    80002508:	f022                	sd	s0,32(sp)
    8000250a:	ec26                	sd	s1,24(sp)
    8000250c:	e84a                	sd	s2,16(sp)
    8000250e:	e44e                	sd	s3,8(sp)
    80002510:	e052                	sd	s4,0(sp)
    80002512:	1800                	addi	s0,sp,48
    80002514:	89aa                	mv	s3,a0
    80002516:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002518:	00015517          	auipc	a0,0x15
    8000251c:	3c850513          	addi	a0,a0,968 # 800178e0 <itable>
    80002520:	07b030ef          	jal	80005d9a <acquire>
  empty = 0;
    80002524:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002526:	00015497          	auipc	s1,0x15
    8000252a:	3da48493          	addi	s1,s1,986 # 80017900 <itable+0x20>
    8000252e:	00017697          	auipc	a3,0x17
    80002532:	ff268693          	addi	a3,a3,-14 # 80019520 <log>
    80002536:	a819                	j	8000254c <iget+0x48>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002538:	0017b793          	seqz	a5,a5
    8000253c:	00193713          	seqz	a4,s2
    80002540:	8ff9                	and	a5,a5,a4
    80002542:	eb85                	bnez	a5,80002572 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002544:	09048493          	addi	s1,s1,144
    80002548:	02d48763          	beq	s1,a3,80002576 <iget+0x72>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    8000254c:	449c                	lw	a5,8(s1)
    8000254e:	fef055e3          	blez	a5,80002538 <iget+0x34>
    80002552:	4098                	lw	a4,0(s1)
    80002554:	ff3718e3          	bne	a4,s3,80002544 <iget+0x40>
    80002558:	40d8                	lw	a4,4(s1)
    8000255a:	ff4715e3          	bne	a4,s4,80002544 <iget+0x40>
      ip->ref++;
    8000255e:	2785                	addiw	a5,a5,1
    80002560:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002562:	00015517          	auipc	a0,0x15
    80002566:	37e50513          	addi	a0,a0,894 # 800178e0 <itable>
    8000256a:	16d030ef          	jal	80005ed6 <release>
      return ip;
    8000256e:	8926                	mv	s2,s1
    80002570:	a025                	j	80002598 <iget+0x94>
      empty = ip;
    80002572:	8926                	mv	s2,s1
    80002574:	bfc1                	j	80002544 <iget+0x40>
  if(empty == 0)
    80002576:	02090a63          	beqz	s2,800025aa <iget+0xa6>
  ip->dev = dev;
    8000257a:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    8000257e:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002582:	4785                	li	a5,1
    80002584:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002588:	04092423          	sw	zero,72(s2)
  release(&itable.lock);
    8000258c:	00015517          	auipc	a0,0x15
    80002590:	35450513          	addi	a0,a0,852 # 800178e0 <itable>
    80002594:	143030ef          	jal	80005ed6 <release>
}
    80002598:	854a                	mv	a0,s2
    8000259a:	70a2                	ld	ra,40(sp)
    8000259c:	7402                	ld	s0,32(sp)
    8000259e:	64e2                	ld	s1,24(sp)
    800025a0:	6942                	ld	s2,16(sp)
    800025a2:	69a2                	ld	s3,8(sp)
    800025a4:	6a02                	ld	s4,0(sp)
    800025a6:	6145                	addi	sp,sp,48
    800025a8:	8082                	ret
    panic("iget: no inodes");
    800025aa:	00006517          	auipc	a0,0x6
    800025ae:	e0650513          	addi	a0,a0,-506 # 800083b0 <etext+0x3b0>
    800025b2:	4ac030ef          	jal	80005a5e <panic>

00000000800025b6 <iinit>:
{
    800025b6:	7179                	addi	sp,sp,-48
    800025b8:	f406                	sd	ra,40(sp)
    800025ba:	f022                	sd	s0,32(sp)
    800025bc:	ec26                	sd	s1,24(sp)
    800025be:	e84a                	sd	s2,16(sp)
    800025c0:	e44e                	sd	s3,8(sp)
    800025c2:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    800025c4:	00006597          	auipc	a1,0x6
    800025c8:	dfc58593          	addi	a1,a1,-516 # 800083c0 <etext+0x3c0>
    800025cc:	00015517          	auipc	a0,0x15
    800025d0:	31450513          	addi	a0,a0,788 # 800178e0 <itable>
    800025d4:	19b030ef          	jal	80005f6e <initlock>
  for(i = 0; i < NINODE; i++) {
    800025d8:	00015497          	auipc	s1,0x15
    800025dc:	33848493          	addi	s1,s1,824 # 80017910 <itable+0x30>
    800025e0:	00017997          	auipc	s3,0x17
    800025e4:	f5098993          	addi	s3,s3,-176 # 80019530 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    800025e8:	00006917          	auipc	s2,0x6
    800025ec:	de090913          	addi	s2,s2,-544 # 800083c8 <etext+0x3c8>
    800025f0:	85ca                	mv	a1,s2
    800025f2:	8526                	mv	a0,s1
    800025f4:	607000ef          	jal	800033fa <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    800025f8:	09048493          	addi	s1,s1,144
    800025fc:	ff349ae3          	bne	s1,s3,800025f0 <iinit+0x3a>
}
    80002600:	70a2                	ld	ra,40(sp)
    80002602:	7402                	ld	s0,32(sp)
    80002604:	64e2                	ld	s1,24(sp)
    80002606:	6942                	ld	s2,16(sp)
    80002608:	69a2                	ld	s3,8(sp)
    8000260a:	6145                	addi	sp,sp,48
    8000260c:	8082                	ret

000000008000260e <ialloc>:
{
    8000260e:	7139                	addi	sp,sp,-64
    80002610:	fc06                	sd	ra,56(sp)
    80002612:	f822                	sd	s0,48(sp)
    80002614:	0080                	addi	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    80002616:	00015717          	auipc	a4,0x15
    8000261a:	2b672703          	lw	a4,694(a4) # 800178cc <sb+0xc>
    8000261e:	4785                	li	a5,1
    80002620:	06e7f063          	bgeu	a5,a4,80002680 <ialloc+0x72>
    80002624:	f426                	sd	s1,40(sp)
    80002626:	f04a                	sd	s2,32(sp)
    80002628:	ec4e                	sd	s3,24(sp)
    8000262a:	e852                	sd	s4,16(sp)
    8000262c:	e456                	sd	s5,8(sp)
    8000262e:	e05a                	sd	s6,0(sp)
    80002630:	8aaa                	mv	s5,a0
    80002632:	8b2e                	mv	s6,a1
    80002634:	893e                	mv	s2,a5
    bp = bread(dev, IBLOCK(inum, sb));
    80002636:	00015a17          	auipc	s4,0x15
    8000263a:	28aa0a13          	addi	s4,s4,650 # 800178c0 <sb>
    8000263e:	00495593          	srli	a1,s2,0x4
    80002642:	018a2783          	lw	a5,24(s4)
    80002646:	9dbd                	addw	a1,a1,a5
    80002648:	8556                	mv	a0,s5
    8000264a:	a95ff0ef          	jal	800020de <bread>
    8000264e:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002650:	06050993          	addi	s3,a0,96
    80002654:	00f97793          	andi	a5,s2,15
    80002658:	079a                	slli	a5,a5,0x6
    8000265a:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    8000265c:	00099783          	lh	a5,0(s3)
    80002660:	cb9d                	beqz	a5,80002696 <ialloc+0x88>
    brelse(bp);
    80002662:	b85ff0ef          	jal	800021e6 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002666:	0905                	addi	s2,s2,1
    80002668:	00ca2703          	lw	a4,12(s4)
    8000266c:	0009079b          	sext.w	a5,s2
    80002670:	fce7e7e3          	bltu	a5,a4,8000263e <ialloc+0x30>
    80002674:	74a2                	ld	s1,40(sp)
    80002676:	7902                	ld	s2,32(sp)
    80002678:	69e2                	ld	s3,24(sp)
    8000267a:	6a42                	ld	s4,16(sp)
    8000267c:	6aa2                	ld	s5,8(sp)
    8000267e:	6b02                	ld	s6,0(sp)
  printf("ialloc: no inodes\n");
    80002680:	00006517          	auipc	a0,0x6
    80002684:	d5050513          	addi	a0,a0,-688 # 800083d0 <etext+0x3d0>
    80002688:	09e030ef          	jal	80005726 <printf>
  return 0;
    8000268c:	4501                	li	a0,0
}
    8000268e:	70e2                	ld	ra,56(sp)
    80002690:	7442                	ld	s0,48(sp)
    80002692:	6121                	addi	sp,sp,64
    80002694:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    80002696:	04000613          	li	a2,64
    8000269a:	4581                	li	a1,0
    8000269c:	854e                	mv	a0,s3
    8000269e:	b99fd0ef          	jal	80000236 <memset>
      dip->type = type;
    800026a2:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    800026a6:	8526                	mv	a0,s1
    800026a8:	493000ef          	jal	8000333a <log_write>
      brelse(bp);
    800026ac:	8526                	mv	a0,s1
    800026ae:	b39ff0ef          	jal	800021e6 <brelse>
      return iget(dev, inum);
    800026b2:	0009059b          	sext.w	a1,s2
    800026b6:	8556                	mv	a0,s5
    800026b8:	e4dff0ef          	jal	80002504 <iget>
    800026bc:	74a2                	ld	s1,40(sp)
    800026be:	7902                	ld	s2,32(sp)
    800026c0:	69e2                	ld	s3,24(sp)
    800026c2:	6a42                	ld	s4,16(sp)
    800026c4:	6aa2                	ld	s5,8(sp)
    800026c6:	6b02                	ld	s6,0(sp)
    800026c8:	b7d9                	j	8000268e <ialloc+0x80>

00000000800026ca <iupdate>:
{
    800026ca:	1101                	addi	sp,sp,-32
    800026cc:	ec06                	sd	ra,24(sp)
    800026ce:	e822                	sd	s0,16(sp)
    800026d0:	e426                	sd	s1,8(sp)
    800026d2:	e04a                	sd	s2,0(sp)
    800026d4:	1000                	addi	s0,sp,32
    800026d6:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800026d8:	415c                	lw	a5,4(a0)
    800026da:	0047d79b          	srliw	a5,a5,0x4
    800026de:	00015597          	auipc	a1,0x15
    800026e2:	1fa5a583          	lw	a1,506(a1) # 800178d8 <sb+0x18>
    800026e6:	9dbd                	addw	a1,a1,a5
    800026e8:	4108                	lw	a0,0(a0)
    800026ea:	9f5ff0ef          	jal	800020de <bread>
    800026ee:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    800026f0:	06050793          	addi	a5,a0,96
    800026f4:	40d8                	lw	a4,4(s1)
    800026f6:	8b3d                	andi	a4,a4,15
    800026f8:	071a                	slli	a4,a4,0x6
    800026fa:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    800026fc:	04c49703          	lh	a4,76(s1)
    80002700:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002704:	04e49703          	lh	a4,78(s1)
    80002708:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    8000270c:	05049703          	lh	a4,80(s1)
    80002710:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002714:	05249703          	lh	a4,82(s1)
    80002718:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    8000271c:	48f8                	lw	a4,84(s1)
    8000271e:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002720:	03400613          	li	a2,52
    80002724:	05848593          	addi	a1,s1,88
    80002728:	00c78513          	addi	a0,a5,12
    8000272c:	b67fd0ef          	jal	80000292 <memmove>
  log_write(bp);
    80002730:	854a                	mv	a0,s2
    80002732:	409000ef          	jal	8000333a <log_write>
  brelse(bp);
    80002736:	854a                	mv	a0,s2
    80002738:	aafff0ef          	jal	800021e6 <brelse>
}
    8000273c:	60e2                	ld	ra,24(sp)
    8000273e:	6442                	ld	s0,16(sp)
    80002740:	64a2                	ld	s1,8(sp)
    80002742:	6902                	ld	s2,0(sp)
    80002744:	6105                	addi	sp,sp,32
    80002746:	8082                	ret

0000000080002748 <idup>:
{
    80002748:	1101                	addi	sp,sp,-32
    8000274a:	ec06                	sd	ra,24(sp)
    8000274c:	e822                	sd	s0,16(sp)
    8000274e:	e426                	sd	s1,8(sp)
    80002750:	1000                	addi	s0,sp,32
    80002752:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002754:	00015517          	auipc	a0,0x15
    80002758:	18c50513          	addi	a0,a0,396 # 800178e0 <itable>
    8000275c:	63e030ef          	jal	80005d9a <acquire>
  ip->ref++;
    80002760:	449c                	lw	a5,8(s1)
    80002762:	2785                	addiw	a5,a5,1
    80002764:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002766:	00015517          	auipc	a0,0x15
    8000276a:	17a50513          	addi	a0,a0,378 # 800178e0 <itable>
    8000276e:	768030ef          	jal	80005ed6 <release>
}
    80002772:	8526                	mv	a0,s1
    80002774:	60e2                	ld	ra,24(sp)
    80002776:	6442                	ld	s0,16(sp)
    80002778:	64a2                	ld	s1,8(sp)
    8000277a:	6105                	addi	sp,sp,32
    8000277c:	8082                	ret

000000008000277e <ilock>:
{
    8000277e:	1101                	addi	sp,sp,-32
    80002780:	ec06                	sd	ra,24(sp)
    80002782:	e822                	sd	s0,16(sp)
    80002784:	e426                	sd	s1,8(sp)
    80002786:	1000                	addi	s0,sp,32
  if(ip == 0 || atomic_read4(&ip->ref) < 1)
    80002788:	c115                	beqz	a0,800027ac <ilock+0x2e>
    8000278a:	84aa                	mv	s1,a0
    8000278c:	0521                	addi	a0,a0,8
    8000278e:	581030ef          	jal	8000650e <atomic_read4>
    80002792:	00a05d63          	blez	a0,800027ac <ilock+0x2e>
  acquiresleep(&ip->lock);
    80002796:	01048513          	addi	a0,s1,16
    8000279a:	497000ef          	jal	80003430 <acquiresleep>
  if(ip->valid == 0){
    8000279e:	44bc                	lw	a5,72(s1)
    800027a0:	cf89                	beqz	a5,800027ba <ilock+0x3c>
}
    800027a2:	60e2                	ld	ra,24(sp)
    800027a4:	6442                	ld	s0,16(sp)
    800027a6:	64a2                	ld	s1,8(sp)
    800027a8:	6105                	addi	sp,sp,32
    800027aa:	8082                	ret
    800027ac:	e04a                	sd	s2,0(sp)
    panic("ilock");
    800027ae:	00006517          	auipc	a0,0x6
    800027b2:	c3a50513          	addi	a0,a0,-966 # 800083e8 <etext+0x3e8>
    800027b6:	2a8030ef          	jal	80005a5e <panic>
    800027ba:	e04a                	sd	s2,0(sp)
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800027bc:	40dc                	lw	a5,4(s1)
    800027be:	0047d79b          	srliw	a5,a5,0x4
    800027c2:	00015597          	auipc	a1,0x15
    800027c6:	1165a583          	lw	a1,278(a1) # 800178d8 <sb+0x18>
    800027ca:	9dbd                	addw	a1,a1,a5
    800027cc:	4088                	lw	a0,0(s1)
    800027ce:	911ff0ef          	jal	800020de <bread>
    800027d2:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    800027d4:	06050593          	addi	a1,a0,96
    800027d8:	40dc                	lw	a5,4(s1)
    800027da:	8bbd                	andi	a5,a5,15
    800027dc:	079a                	slli	a5,a5,0x6
    800027de:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    800027e0:	00059783          	lh	a5,0(a1)
    800027e4:	04f49623          	sh	a5,76(s1)
    ip->major = dip->major;
    800027e8:	00259783          	lh	a5,2(a1)
    800027ec:	04f49723          	sh	a5,78(s1)
    ip->minor = dip->minor;
    800027f0:	00459783          	lh	a5,4(a1)
    800027f4:	04f49823          	sh	a5,80(s1)
    ip->nlink = dip->nlink;
    800027f8:	00659783          	lh	a5,6(a1)
    800027fc:	04f49923          	sh	a5,82(s1)
    ip->size = dip->size;
    80002800:	459c                	lw	a5,8(a1)
    80002802:	c8fc                	sw	a5,84(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002804:	03400613          	li	a2,52
    80002808:	05b1                	addi	a1,a1,12
    8000280a:	05848513          	addi	a0,s1,88
    8000280e:	a85fd0ef          	jal	80000292 <memmove>
    brelse(bp);
    80002812:	854a                	mv	a0,s2
    80002814:	9d3ff0ef          	jal	800021e6 <brelse>
    ip->valid = 1;
    80002818:	4785                	li	a5,1
    8000281a:	c4bc                	sw	a5,72(s1)
    if(ip->type == 0)
    8000281c:	04c49783          	lh	a5,76(s1)
    80002820:	c399                	beqz	a5,80002826 <ilock+0xa8>
    80002822:	6902                	ld	s2,0(sp)
    80002824:	bfbd                	j	800027a2 <ilock+0x24>
      panic("ilock: no type");
    80002826:	00006517          	auipc	a0,0x6
    8000282a:	bca50513          	addi	a0,a0,-1078 # 800083f0 <etext+0x3f0>
    8000282e:	230030ef          	jal	80005a5e <panic>

0000000080002832 <iunlock>:
{
    80002832:	1101                	addi	sp,sp,-32
    80002834:	ec06                	sd	ra,24(sp)
    80002836:	e822                	sd	s0,16(sp)
    80002838:	e426                	sd	s1,8(sp)
    8000283a:	e04a                	sd	s2,0(sp)
    8000283c:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || atomic_read4(&ip->ref) < 1)
    8000283e:	c51d                	beqz	a0,8000286c <iunlock+0x3a>
    80002840:	84aa                	mv	s1,a0
    80002842:	01050913          	addi	s2,a0,16
    80002846:	854a                	mv	a0,s2
    80002848:	467000ef          	jal	800034ae <holdingsleep>
    8000284c:	c105                	beqz	a0,8000286c <iunlock+0x3a>
    8000284e:	00848513          	addi	a0,s1,8
    80002852:	4bd030ef          	jal	8000650e <atomic_read4>
    80002856:	00a05b63          	blez	a0,8000286c <iunlock+0x3a>
  releasesleep(&ip->lock);
    8000285a:	854a                	mv	a0,s2
    8000285c:	41b000ef          	jal	80003476 <releasesleep>
}
    80002860:	60e2                	ld	ra,24(sp)
    80002862:	6442                	ld	s0,16(sp)
    80002864:	64a2                	ld	s1,8(sp)
    80002866:	6902                	ld	s2,0(sp)
    80002868:	6105                	addi	sp,sp,32
    8000286a:	8082                	ret
    panic("iunlock");
    8000286c:	00006517          	auipc	a0,0x6
    80002870:	b9450513          	addi	a0,a0,-1132 # 80008400 <etext+0x400>
    80002874:	1ea030ef          	jal	80005a5e <panic>

0000000080002878 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002878:	7179                	addi	sp,sp,-48
    8000287a:	f406                	sd	ra,40(sp)
    8000287c:	f022                	sd	s0,32(sp)
    8000287e:	ec26                	sd	s1,24(sp)
    80002880:	e84a                	sd	s2,16(sp)
    80002882:	e44e                	sd	s3,8(sp)
    80002884:	1800                	addi	s0,sp,48
    80002886:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002888:	05850493          	addi	s1,a0,88
    8000288c:	08850913          	addi	s2,a0,136
    80002890:	a021                	j	80002898 <itrunc+0x20>
    80002892:	0491                	addi	s1,s1,4
    80002894:	01248b63          	beq	s1,s2,800028aa <itrunc+0x32>
    if(ip->addrs[i]){
    80002898:	408c                	lw	a1,0(s1)
    8000289a:	dde5                	beqz	a1,80002892 <itrunc+0x1a>
      bfree(ip->dev, ip->addrs[i]);
    8000289c:	0009a503          	lw	a0,0(s3)
    800028a0:	a33ff0ef          	jal	800022d2 <bfree>
      ip->addrs[i] = 0;
    800028a4:	0004a023          	sw	zero,0(s1)
    800028a8:	b7ed                	j	80002892 <itrunc+0x1a>
    }
  }

  if(ip->addrs[NDIRECT]){
    800028aa:	0889a583          	lw	a1,136(s3)
    800028ae:	ed89                	bnez	a1,800028c8 <itrunc+0x50>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }
  
  ip->size = 0;
    800028b0:	0409aa23          	sw	zero,84(s3)
  iupdate(ip);
    800028b4:	854e                	mv	a0,s3
    800028b6:	e15ff0ef          	jal	800026ca <iupdate>
}
    800028ba:	70a2                	ld	ra,40(sp)
    800028bc:	7402                	ld	s0,32(sp)
    800028be:	64e2                	ld	s1,24(sp)
    800028c0:	6942                	ld	s2,16(sp)
    800028c2:	69a2                	ld	s3,8(sp)
    800028c4:	6145                	addi	sp,sp,48
    800028c6:	8082                	ret
    800028c8:	e052                	sd	s4,0(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    800028ca:	0009a503          	lw	a0,0(s3)
    800028ce:	811ff0ef          	jal	800020de <bread>
    800028d2:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    800028d4:	06050493          	addi	s1,a0,96
    800028d8:	46050913          	addi	s2,a0,1120
    800028dc:	a021                	j	800028e4 <itrunc+0x6c>
    800028de:	0491                	addi	s1,s1,4
    800028e0:	01248963          	beq	s1,s2,800028f2 <itrunc+0x7a>
      if(a[j])
    800028e4:	408c                	lw	a1,0(s1)
    800028e6:	dde5                	beqz	a1,800028de <itrunc+0x66>
        bfree(ip->dev, a[j]);
    800028e8:	0009a503          	lw	a0,0(s3)
    800028ec:	9e7ff0ef          	jal	800022d2 <bfree>
    800028f0:	b7fd                	j	800028de <itrunc+0x66>
    brelse(bp);
    800028f2:	8552                	mv	a0,s4
    800028f4:	8f3ff0ef          	jal	800021e6 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    800028f8:	0889a583          	lw	a1,136(s3)
    800028fc:	0009a503          	lw	a0,0(s3)
    80002900:	9d3ff0ef          	jal	800022d2 <bfree>
    ip->addrs[NDIRECT] = 0;
    80002904:	0809a423          	sw	zero,136(s3)
    80002908:	6a02                	ld	s4,0(sp)
    8000290a:	b75d                	j	800028b0 <itrunc+0x38>

000000008000290c <iput>:
{
    8000290c:	1101                	addi	sp,sp,-32
    8000290e:	ec06                	sd	ra,24(sp)
    80002910:	e822                	sd	s0,16(sp)
    80002912:	e426                	sd	s1,8(sp)
    80002914:	1000                	addi	s0,sp,32
    80002916:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002918:	00015517          	auipc	a0,0x15
    8000291c:	fc850513          	addi	a0,a0,-56 # 800178e0 <itable>
    80002920:	47a030ef          	jal	80005d9a <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002924:	4498                	lw	a4,8(s1)
    80002926:	4785                	li	a5,1
    80002928:	02f70063          	beq	a4,a5,80002948 <iput+0x3c>
  ip->ref--;
    8000292c:	449c                	lw	a5,8(s1)
    8000292e:	37fd                	addiw	a5,a5,-1
    80002930:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002932:	00015517          	auipc	a0,0x15
    80002936:	fae50513          	addi	a0,a0,-82 # 800178e0 <itable>
    8000293a:	59c030ef          	jal	80005ed6 <release>
}
    8000293e:	60e2                	ld	ra,24(sp)
    80002940:	6442                	ld	s0,16(sp)
    80002942:	64a2                	ld	s1,8(sp)
    80002944:	6105                	addi	sp,sp,32
    80002946:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002948:	44bc                	lw	a5,72(s1)
    8000294a:	d3ed                	beqz	a5,8000292c <iput+0x20>
    8000294c:	05249783          	lh	a5,82(s1)
    80002950:	fff1                	bnez	a5,8000292c <iput+0x20>
    80002952:	e04a                	sd	s2,0(sp)
    acquiresleep(&ip->lock);
    80002954:	01048793          	addi	a5,s1,16
    80002958:	893e                	mv	s2,a5
    8000295a:	853e                	mv	a0,a5
    8000295c:	2d5000ef          	jal	80003430 <acquiresleep>
    release(&itable.lock);
    80002960:	00015517          	auipc	a0,0x15
    80002964:	f8050513          	addi	a0,a0,-128 # 800178e0 <itable>
    80002968:	56e030ef          	jal	80005ed6 <release>
    itrunc(ip);
    8000296c:	8526                	mv	a0,s1
    8000296e:	f0bff0ef          	jal	80002878 <itrunc>
    ip->type = 0;
    80002972:	04049623          	sh	zero,76(s1)
    iupdate(ip);
    80002976:	8526                	mv	a0,s1
    80002978:	d53ff0ef          	jal	800026ca <iupdate>
    ip->valid = 0;
    8000297c:	0404a423          	sw	zero,72(s1)
    releasesleep(&ip->lock);
    80002980:	854a                	mv	a0,s2
    80002982:	2f5000ef          	jal	80003476 <releasesleep>
    acquire(&itable.lock);
    80002986:	00015517          	auipc	a0,0x15
    8000298a:	f5a50513          	addi	a0,a0,-166 # 800178e0 <itable>
    8000298e:	40c030ef          	jal	80005d9a <acquire>
    80002992:	6902                	ld	s2,0(sp)
    80002994:	bf61                	j	8000292c <iput+0x20>

0000000080002996 <iunlockput>:
{
    80002996:	1101                	addi	sp,sp,-32
    80002998:	ec06                	sd	ra,24(sp)
    8000299a:	e822                	sd	s0,16(sp)
    8000299c:	e426                	sd	s1,8(sp)
    8000299e:	1000                	addi	s0,sp,32
    800029a0:	84aa                	mv	s1,a0
  iunlock(ip);
    800029a2:	e91ff0ef          	jal	80002832 <iunlock>
  iput(ip);
    800029a6:	8526                	mv	a0,s1
    800029a8:	f65ff0ef          	jal	8000290c <iput>
}
    800029ac:	60e2                	ld	ra,24(sp)
    800029ae:	6442                	ld	s0,16(sp)
    800029b0:	64a2                	ld	s1,8(sp)
    800029b2:	6105                	addi	sp,sp,32
    800029b4:	8082                	ret

00000000800029b6 <ireclaim>:
  for (int inum = 1; inum < sb.ninodes; inum++) {
    800029b6:	00015717          	auipc	a4,0x15
    800029ba:	f1672703          	lw	a4,-234(a4) # 800178cc <sb+0xc>
    800029be:	4785                	li	a5,1
    800029c0:	0ae7fe63          	bgeu	a5,a4,80002a7c <ireclaim+0xc6>
{
    800029c4:	7139                	addi	sp,sp,-64
    800029c6:	fc06                	sd	ra,56(sp)
    800029c8:	f822                	sd	s0,48(sp)
    800029ca:	f426                	sd	s1,40(sp)
    800029cc:	f04a                	sd	s2,32(sp)
    800029ce:	ec4e                	sd	s3,24(sp)
    800029d0:	e852                	sd	s4,16(sp)
    800029d2:	e456                	sd	s5,8(sp)
    800029d4:	e05a                	sd	s6,0(sp)
    800029d6:	0080                	addi	s0,sp,64
    800029d8:	8aaa                	mv	s5,a0
  for (int inum = 1; inum < sb.ninodes; inum++) {
    800029da:	84be                	mv	s1,a5
    struct buf *bp = bread(dev, IBLOCK(inum, sb));
    800029dc:	00015a17          	auipc	s4,0x15
    800029e0:	ee4a0a13          	addi	s4,s4,-284 # 800178c0 <sb>
      printf("ireclaim: orphaned inode %d\n", inum);
    800029e4:	00006b17          	auipc	s6,0x6
    800029e8:	a24b0b13          	addi	s6,s6,-1500 # 80008408 <etext+0x408>
    800029ec:	a099                	j	80002a32 <ireclaim+0x7c>
    800029ee:	85ce                	mv	a1,s3
    800029f0:	855a                	mv	a0,s6
    800029f2:	535020ef          	jal	80005726 <printf>
      ip = iget(dev, inum);
    800029f6:	85ce                	mv	a1,s3
    800029f8:	8556                	mv	a0,s5
    800029fa:	b0bff0ef          	jal	80002504 <iget>
    800029fe:	89aa                	mv	s3,a0
    brelse(bp);
    80002a00:	854a                	mv	a0,s2
    80002a02:	fe4ff0ef          	jal	800021e6 <brelse>
    if (ip) {
    80002a06:	00098f63          	beqz	s3,80002a24 <ireclaim+0x6e>
      begin_op();
    80002a0a:	796000ef          	jal	800031a0 <begin_op>
      ilock(ip);
    80002a0e:	854e                	mv	a0,s3
    80002a10:	d6fff0ef          	jal	8000277e <ilock>
      iunlock(ip);
    80002a14:	854e                	mv	a0,s3
    80002a16:	e1dff0ef          	jal	80002832 <iunlock>
      iput(ip);
    80002a1a:	854e                	mv	a0,s3
    80002a1c:	ef1ff0ef          	jal	8000290c <iput>
      end_op();
    80002a20:	7f0000ef          	jal	80003210 <end_op>
  for (int inum = 1; inum < sb.ninodes; inum++) {
    80002a24:	0485                	addi	s1,s1,1
    80002a26:	00ca2703          	lw	a4,12(s4)
    80002a2a:	0004879b          	sext.w	a5,s1
    80002a2e:	02e7fd63          	bgeu	a5,a4,80002a68 <ireclaim+0xb2>
    80002a32:	0004899b          	sext.w	s3,s1
    struct buf *bp = bread(dev, IBLOCK(inum, sb));
    80002a36:	0044d593          	srli	a1,s1,0x4
    80002a3a:	018a2783          	lw	a5,24(s4)
    80002a3e:	9dbd                	addw	a1,a1,a5
    80002a40:	8556                	mv	a0,s5
    80002a42:	e9cff0ef          	jal	800020de <bread>
    80002a46:	892a                	mv	s2,a0
    struct dinode *dip = (struct dinode *)bp->data + inum % IPB;
    80002a48:	06050793          	addi	a5,a0,96
    80002a4c:	00f9f713          	andi	a4,s3,15
    80002a50:	071a                	slli	a4,a4,0x6
    80002a52:	97ba                	add	a5,a5,a4
    if (dip->type != 0 && dip->nlink == 0) {  // is an orphaned inode
    80002a54:	00079703          	lh	a4,0(a5)
    80002a58:	c701                	beqz	a4,80002a60 <ireclaim+0xaa>
    80002a5a:	00679783          	lh	a5,6(a5)
    80002a5e:	dbc1                	beqz	a5,800029ee <ireclaim+0x38>
    brelse(bp);
    80002a60:	854a                	mv	a0,s2
    80002a62:	f84ff0ef          	jal	800021e6 <brelse>
    if (ip) {
    80002a66:	bf7d                	j	80002a24 <ireclaim+0x6e>
}
    80002a68:	70e2                	ld	ra,56(sp)
    80002a6a:	7442                	ld	s0,48(sp)
    80002a6c:	74a2                	ld	s1,40(sp)
    80002a6e:	7902                	ld	s2,32(sp)
    80002a70:	69e2                	ld	s3,24(sp)
    80002a72:	6a42                	ld	s4,16(sp)
    80002a74:	6aa2                	ld	s5,8(sp)
    80002a76:	6b02                	ld	s6,0(sp)
    80002a78:	6121                	addi	sp,sp,64
    80002a7a:	8082                	ret
    80002a7c:	8082                	ret

0000000080002a7e <fsinit>:
fsinit(int dev) {
    80002a7e:	1101                	addi	sp,sp,-32
    80002a80:	ec06                	sd	ra,24(sp)
    80002a82:	e822                	sd	s0,16(sp)
    80002a84:	e426                	sd	s1,8(sp)
    80002a86:	e04a                	sd	s2,0(sp)
    80002a88:	1000                	addi	s0,sp,32
    80002a8a:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002a8c:	4585                	li	a1,1
    80002a8e:	e50ff0ef          	jal	800020de <bread>
    80002a92:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002a94:	02000613          	li	a2,32
    80002a98:	06050593          	addi	a1,a0,96
    80002a9c:	00015517          	auipc	a0,0x15
    80002aa0:	e2450513          	addi	a0,a0,-476 # 800178c0 <sb>
    80002aa4:	feefd0ef          	jal	80000292 <memmove>
  brelse(bp);
    80002aa8:	8526                	mv	a0,s1
    80002aaa:	f3cff0ef          	jal	800021e6 <brelse>
  if(sb.magic != FSMAGIC)
    80002aae:	00015717          	auipc	a4,0x15
    80002ab2:	e1272703          	lw	a4,-494(a4) # 800178c0 <sb>
    80002ab6:	102037b7          	lui	a5,0x10203
    80002aba:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002abe:	02f71263          	bne	a4,a5,80002ae2 <fsinit+0x64>
  initlog(dev, &sb);
    80002ac2:	00015597          	auipc	a1,0x15
    80002ac6:	dfe58593          	addi	a1,a1,-514 # 800178c0 <sb>
    80002aca:	854a                	mv	a0,s2
    80002acc:	652000ef          	jal	8000311e <initlog>
  ireclaim(dev);
    80002ad0:	854a                	mv	a0,s2
    80002ad2:	ee5ff0ef          	jal	800029b6 <ireclaim>
}
    80002ad6:	60e2                	ld	ra,24(sp)
    80002ad8:	6442                	ld	s0,16(sp)
    80002ada:	64a2                	ld	s1,8(sp)
    80002adc:	6902                	ld	s2,0(sp)
    80002ade:	6105                	addi	sp,sp,32
    80002ae0:	8082                	ret
    panic("invalid file system");
    80002ae2:	00006517          	auipc	a0,0x6
    80002ae6:	94650513          	addi	a0,a0,-1722 # 80008428 <etext+0x428>
    80002aea:	775020ef          	jal	80005a5e <panic>

0000000080002aee <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002aee:	1141                	addi	sp,sp,-16
    80002af0:	e406                	sd	ra,8(sp)
    80002af2:	e022                	sd	s0,0(sp)
    80002af4:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002af6:	411c                	lw	a5,0(a0)
    80002af8:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002afa:	415c                	lw	a5,4(a0)
    80002afc:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002afe:	04c51783          	lh	a5,76(a0)
    80002b02:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002b06:	05251783          	lh	a5,82(a0)
    80002b0a:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002b0e:	05456783          	lwu	a5,84(a0)
    80002b12:	e99c                	sd	a5,16(a1)
}
    80002b14:	60a2                	ld	ra,8(sp)
    80002b16:	6402                	ld	s0,0(sp)
    80002b18:	0141                	addi	sp,sp,16
    80002b1a:	8082                	ret

0000000080002b1c <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002b1c:	497c                	lw	a5,84(a0)
    80002b1e:	0ed7e663          	bltu	a5,a3,80002c0a <readi+0xee>
{
    80002b22:	7159                	addi	sp,sp,-112
    80002b24:	f486                	sd	ra,104(sp)
    80002b26:	f0a2                	sd	s0,96(sp)
    80002b28:	eca6                	sd	s1,88(sp)
    80002b2a:	e0d2                	sd	s4,64(sp)
    80002b2c:	fc56                	sd	s5,56(sp)
    80002b2e:	f85a                	sd	s6,48(sp)
    80002b30:	f45e                	sd	s7,40(sp)
    80002b32:	1880                	addi	s0,sp,112
    80002b34:	8b2a                	mv	s6,a0
    80002b36:	8bae                	mv	s7,a1
    80002b38:	8a32                	mv	s4,a2
    80002b3a:	84b6                	mv	s1,a3
    80002b3c:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    80002b3e:	9f35                	addw	a4,a4,a3
    return 0;
    80002b40:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80002b42:	0ad76b63          	bltu	a4,a3,80002bf8 <readi+0xdc>
    80002b46:	e4ce                	sd	s3,72(sp)
  if(off + n > ip->size)
    80002b48:	00e7f463          	bgeu	a5,a4,80002b50 <readi+0x34>
    n = ip->size - off;
    80002b4c:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002b50:	080a8b63          	beqz	s5,80002be6 <readi+0xca>
    80002b54:	e8ca                	sd	s2,80(sp)
    80002b56:	f062                	sd	s8,32(sp)
    80002b58:	ec66                	sd	s9,24(sp)
    80002b5a:	e86a                	sd	s10,16(sp)
    80002b5c:	e46e                	sd	s11,8(sp)
    80002b5e:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002b60:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002b64:	5c7d                	li	s8,-1
    80002b66:	a80d                	j	80002b98 <readi+0x7c>
    80002b68:	020d1d93          	slli	s11,s10,0x20
    80002b6c:	020ddd93          	srli	s11,s11,0x20
    80002b70:	06090613          	addi	a2,s2,96
    80002b74:	86ee                	mv	a3,s11
    80002b76:	963e                	add	a2,a2,a5
    80002b78:	85d2                	mv	a1,s4
    80002b7a:	855e                	mv	a0,s7
    80002b7c:	c47fe0ef          	jal	800017c2 <either_copyout>
    80002b80:	05850363          	beq	a0,s8,80002bc6 <readi+0xaa>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002b84:	854a                	mv	a0,s2
    80002b86:	e60ff0ef          	jal	800021e6 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002b8a:	013d09bb          	addw	s3,s10,s3
    80002b8e:	009d04bb          	addw	s1,s10,s1
    80002b92:	9a6e                	add	s4,s4,s11
    80002b94:	0559f363          	bgeu	s3,s5,80002bda <readi+0xbe>
    uint addr = bmap(ip, off/BSIZE);
    80002b98:	00a4d59b          	srliw	a1,s1,0xa
    80002b9c:	855a                	mv	a0,s6
    80002b9e:	8a7ff0ef          	jal	80002444 <bmap>
    80002ba2:	85aa                	mv	a1,a0
    if(addr == 0)
    80002ba4:	c139                	beqz	a0,80002bea <readi+0xce>
    bp = bread(ip->dev, addr);
    80002ba6:	000b2503          	lw	a0,0(s6)
    80002baa:	d34ff0ef          	jal	800020de <bread>
    80002bae:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002bb0:	3ff4f793          	andi	a5,s1,1023
    80002bb4:	40fc873b          	subw	a4,s9,a5
    80002bb8:	413a86bb          	subw	a3,s5,s3
    80002bbc:	8d3a                	mv	s10,a4
    80002bbe:	fae6f5e3          	bgeu	a3,a4,80002b68 <readi+0x4c>
    80002bc2:	8d36                	mv	s10,a3
    80002bc4:	b755                	j	80002b68 <readi+0x4c>
      brelse(bp);
    80002bc6:	854a                	mv	a0,s2
    80002bc8:	e1eff0ef          	jal	800021e6 <brelse>
      tot = -1;
    80002bcc:	59fd                	li	s3,-1
      break;
    80002bce:	6946                	ld	s2,80(sp)
    80002bd0:	7c02                	ld	s8,32(sp)
    80002bd2:	6ce2                	ld	s9,24(sp)
    80002bd4:	6d42                	ld	s10,16(sp)
    80002bd6:	6da2                	ld	s11,8(sp)
    80002bd8:	a831                	j	80002bf4 <readi+0xd8>
    80002bda:	6946                	ld	s2,80(sp)
    80002bdc:	7c02                	ld	s8,32(sp)
    80002bde:	6ce2                	ld	s9,24(sp)
    80002be0:	6d42                	ld	s10,16(sp)
    80002be2:	6da2                	ld	s11,8(sp)
    80002be4:	a801                	j	80002bf4 <readi+0xd8>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002be6:	89d6                	mv	s3,s5
    80002be8:	a031                	j	80002bf4 <readi+0xd8>
    80002bea:	6946                	ld	s2,80(sp)
    80002bec:	7c02                	ld	s8,32(sp)
    80002bee:	6ce2                	ld	s9,24(sp)
    80002bf0:	6d42                	ld	s10,16(sp)
    80002bf2:	6da2                	ld	s11,8(sp)
  }
  return tot;
    80002bf4:	854e                	mv	a0,s3
    80002bf6:	69a6                	ld	s3,72(sp)
}
    80002bf8:	70a6                	ld	ra,104(sp)
    80002bfa:	7406                	ld	s0,96(sp)
    80002bfc:	64e6                	ld	s1,88(sp)
    80002bfe:	6a06                	ld	s4,64(sp)
    80002c00:	7ae2                	ld	s5,56(sp)
    80002c02:	7b42                	ld	s6,48(sp)
    80002c04:	7ba2                	ld	s7,40(sp)
    80002c06:	6165                	addi	sp,sp,112
    80002c08:	8082                	ret
    return 0;
    80002c0a:	4501                	li	a0,0
}
    80002c0c:	8082                	ret

0000000080002c0e <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002c0e:	497c                	lw	a5,84(a0)
    80002c10:	0ed7ee63          	bltu	a5,a3,80002d0c <writei+0xfe>
{
    80002c14:	7159                	addi	sp,sp,-112
    80002c16:	f486                	sd	ra,104(sp)
    80002c18:	f0a2                	sd	s0,96(sp)
    80002c1a:	e8ca                	sd	s2,80(sp)
    80002c1c:	e0d2                	sd	s4,64(sp)
    80002c1e:	fc56                	sd	s5,56(sp)
    80002c20:	f85a                	sd	s6,48(sp)
    80002c22:	f45e                	sd	s7,40(sp)
    80002c24:	1880                	addi	s0,sp,112
    80002c26:	8aaa                	mv	s5,a0
    80002c28:	8bae                	mv	s7,a1
    80002c2a:	8a32                	mv	s4,a2
    80002c2c:	8936                	mv	s2,a3
    80002c2e:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002c30:	9f35                	addw	a4,a4,a3
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80002c32:	000437b7          	lui	a5,0x43
    80002c36:	00e7b7b3          	sltu	a5,a5,a4
  if(off > ip->size || off + n < off)
    80002c3a:	00d73733          	sltu	a4,a4,a3
  if(off + n > MAXFILE*BSIZE)
    80002c3e:	8fd9                	or	a5,a5,a4
    80002c40:	ef91                	bnez	a5,80002c5c <writei+0x4e>
    80002c42:	e4ce                	sd	s3,72(sp)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002c44:	0a0b0c63          	beqz	s6,80002cfc <writei+0xee>
    80002c48:	eca6                	sd	s1,88(sp)
    80002c4a:	f062                	sd	s8,32(sp)
    80002c4c:	ec66                	sd	s9,24(sp)
    80002c4e:	e86a                	sd	s10,16(sp)
    80002c50:	e46e                	sd	s11,8(sp)
    80002c52:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002c54:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002c58:	5c7d                	li	s8,-1
    80002c5a:	a835                	j	80002c96 <writei+0x88>
    return -1;
    80002c5c:	557d                	li	a0,-1
    80002c5e:	a071                	j	80002cea <writei+0xdc>
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002c60:	020d1d93          	slli	s11,s10,0x20
    80002c64:	020ddd93          	srli	s11,s11,0x20
    80002c68:	06048513          	addi	a0,s1,96
    80002c6c:	86ee                	mv	a3,s11
    80002c6e:	8652                	mv	a2,s4
    80002c70:	85de                	mv	a1,s7
    80002c72:	953e                	add	a0,a0,a5
    80002c74:	b99fe0ef          	jal	8000180c <either_copyin>
    80002c78:	05850663          	beq	a0,s8,80002cc4 <writei+0xb6>
      brelse(bp);
      break;
    }
    log_write(bp);
    80002c7c:	8526                	mv	a0,s1
    80002c7e:	6bc000ef          	jal	8000333a <log_write>
    brelse(bp);
    80002c82:	8526                	mv	a0,s1
    80002c84:	d62ff0ef          	jal	800021e6 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002c88:	013d09bb          	addw	s3,s10,s3
    80002c8c:	012d093b          	addw	s2,s10,s2
    80002c90:	9a6e                	add	s4,s4,s11
    80002c92:	0369fc63          	bgeu	s3,s6,80002cca <writei+0xbc>
    uint addr = bmap(ip, off/BSIZE);
    80002c96:	00a9559b          	srliw	a1,s2,0xa
    80002c9a:	8556                	mv	a0,s5
    80002c9c:	fa8ff0ef          	jal	80002444 <bmap>
    80002ca0:	85aa                	mv	a1,a0
    if(addr == 0)
    80002ca2:	c505                	beqz	a0,80002cca <writei+0xbc>
    bp = bread(ip->dev, addr);
    80002ca4:	000aa503          	lw	a0,0(s5)
    80002ca8:	c36ff0ef          	jal	800020de <bread>
    80002cac:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002cae:	3ff97793          	andi	a5,s2,1023
    80002cb2:	40fc873b          	subw	a4,s9,a5
    80002cb6:	413b06bb          	subw	a3,s6,s3
    80002cba:	8d3a                	mv	s10,a4
    80002cbc:	fae6f2e3          	bgeu	a3,a4,80002c60 <writei+0x52>
    80002cc0:	8d36                	mv	s10,a3
    80002cc2:	bf79                	j	80002c60 <writei+0x52>
      brelse(bp);
    80002cc4:	8526                	mv	a0,s1
    80002cc6:	d20ff0ef          	jal	800021e6 <brelse>
  }

  if(off > ip->size)
    80002cca:	054aa783          	lw	a5,84(s5)
    80002cce:	0327f963          	bgeu	a5,s2,80002d00 <writei+0xf2>
    ip->size = off;
    80002cd2:	052aaa23          	sw	s2,84(s5)
    80002cd6:	64e6                	ld	s1,88(sp)
    80002cd8:	7c02                	ld	s8,32(sp)
    80002cda:	6ce2                	ld	s9,24(sp)
    80002cdc:	6d42                	ld	s10,16(sp)
    80002cde:	6da2                	ld	s11,8(sp)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80002ce0:	8556                	mv	a0,s5
    80002ce2:	9e9ff0ef          	jal	800026ca <iupdate>

  return tot;
    80002ce6:	854e                	mv	a0,s3
    80002ce8:	69a6                	ld	s3,72(sp)
}
    80002cea:	70a6                	ld	ra,104(sp)
    80002cec:	7406                	ld	s0,96(sp)
    80002cee:	6946                	ld	s2,80(sp)
    80002cf0:	6a06                	ld	s4,64(sp)
    80002cf2:	7ae2                	ld	s5,56(sp)
    80002cf4:	7b42                	ld	s6,48(sp)
    80002cf6:	7ba2                	ld	s7,40(sp)
    80002cf8:	6165                	addi	sp,sp,112
    80002cfa:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002cfc:	89da                	mv	s3,s6
    80002cfe:	b7cd                	j	80002ce0 <writei+0xd2>
    80002d00:	64e6                	ld	s1,88(sp)
    80002d02:	7c02                	ld	s8,32(sp)
    80002d04:	6ce2                	ld	s9,24(sp)
    80002d06:	6d42                	ld	s10,16(sp)
    80002d08:	6da2                	ld	s11,8(sp)
    80002d0a:	bfd9                	j	80002ce0 <writei+0xd2>
    return -1;
    80002d0c:	557d                	li	a0,-1
}
    80002d0e:	8082                	ret

0000000080002d10 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80002d10:	1141                	addi	sp,sp,-16
    80002d12:	e406                	sd	ra,8(sp)
    80002d14:	e022                	sd	s0,0(sp)
    80002d16:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80002d18:	4639                	li	a2,14
    80002d1a:	decfd0ef          	jal	80000306 <strncmp>
}
    80002d1e:	60a2                	ld	ra,8(sp)
    80002d20:	6402                	ld	s0,0(sp)
    80002d22:	0141                	addi	sp,sp,16
    80002d24:	8082                	ret

0000000080002d26 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80002d26:	711d                	addi	sp,sp,-96
    80002d28:	ec86                	sd	ra,88(sp)
    80002d2a:	e8a2                	sd	s0,80(sp)
    80002d2c:	e4a6                	sd	s1,72(sp)
    80002d2e:	e0ca                	sd	s2,64(sp)
    80002d30:	fc4e                	sd	s3,56(sp)
    80002d32:	f852                	sd	s4,48(sp)
    80002d34:	f456                	sd	s5,40(sp)
    80002d36:	f05a                	sd	s6,32(sp)
    80002d38:	ec5e                	sd	s7,24(sp)
    80002d3a:	1080                	addi	s0,sp,96
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80002d3c:	04c51703          	lh	a4,76(a0)
    80002d40:	4785                	li	a5,1
    80002d42:	02f71963          	bne	a4,a5,80002d74 <dirlookup+0x4e>
    80002d46:	892a                	mv	s2,a0
    80002d48:	8aae                	mv	s5,a1
    80002d4a:	8bb2                	mv	s7,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80002d4c:	497c                	lw	a5,84(a0)
    80002d4e:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002d50:	fa040a13          	addi	s4,s0,-96
    80002d54:	49c1                	li	s3,16
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
    80002d56:	fa240b13          	addi	s6,s0,-94
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002d5a:	ef95                	bnez	a5,80002d96 <dirlookup+0x70>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80002d5c:	4501                	li	a0,0
}
    80002d5e:	60e6                	ld	ra,88(sp)
    80002d60:	6446                	ld	s0,80(sp)
    80002d62:	64a6                	ld	s1,72(sp)
    80002d64:	6906                	ld	s2,64(sp)
    80002d66:	79e2                	ld	s3,56(sp)
    80002d68:	7a42                	ld	s4,48(sp)
    80002d6a:	7aa2                	ld	s5,40(sp)
    80002d6c:	7b02                	ld	s6,32(sp)
    80002d6e:	6be2                	ld	s7,24(sp)
    80002d70:	6125                	addi	sp,sp,96
    80002d72:	8082                	ret
    panic("dirlookup not DIR");
    80002d74:	00005517          	auipc	a0,0x5
    80002d78:	6cc50513          	addi	a0,a0,1740 # 80008440 <etext+0x440>
    80002d7c:	4e3020ef          	jal	80005a5e <panic>
      panic("dirlookup read");
    80002d80:	00005517          	auipc	a0,0x5
    80002d84:	6d850513          	addi	a0,a0,1752 # 80008458 <etext+0x458>
    80002d88:	4d7020ef          	jal	80005a5e <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002d8c:	24c1                	addiw	s1,s1,16
    80002d8e:	05492783          	lw	a5,84(s2)
    80002d92:	fcf4f5e3          	bgeu	s1,a5,80002d5c <dirlookup+0x36>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002d96:	874e                	mv	a4,s3
    80002d98:	86a6                	mv	a3,s1
    80002d9a:	8652                	mv	a2,s4
    80002d9c:	4581                	li	a1,0
    80002d9e:	854a                	mv	a0,s2
    80002da0:	d7dff0ef          	jal	80002b1c <readi>
    80002da4:	fd351ee3          	bne	a0,s3,80002d80 <dirlookup+0x5a>
    if(de.inum == 0)
    80002da8:	fa045783          	lhu	a5,-96(s0)
    80002dac:	d3e5                	beqz	a5,80002d8c <dirlookup+0x66>
    if(namecmp(name, de.name) == 0){
    80002dae:	85da                	mv	a1,s6
    80002db0:	8556                	mv	a0,s5
    80002db2:	f5fff0ef          	jal	80002d10 <namecmp>
    80002db6:	f979                	bnez	a0,80002d8c <dirlookup+0x66>
      if(poff)
    80002db8:	000b8463          	beqz	s7,80002dc0 <dirlookup+0x9a>
        *poff = off;
    80002dbc:	009ba023          	sw	s1,0(s7)
      return iget(dp->dev, inum);
    80002dc0:	fa045583          	lhu	a1,-96(s0)
    80002dc4:	00092503          	lw	a0,0(s2)
    80002dc8:	f3cff0ef          	jal	80002504 <iget>
    80002dcc:	bf49                	j	80002d5e <dirlookup+0x38>

0000000080002dce <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80002dce:	711d                	addi	sp,sp,-96
    80002dd0:	ec86                	sd	ra,88(sp)
    80002dd2:	e8a2                	sd	s0,80(sp)
    80002dd4:	e4a6                	sd	s1,72(sp)
    80002dd6:	e0ca                	sd	s2,64(sp)
    80002dd8:	fc4e                	sd	s3,56(sp)
    80002dda:	f852                	sd	s4,48(sp)
    80002ddc:	f456                	sd	s5,40(sp)
    80002dde:	f05a                	sd	s6,32(sp)
    80002de0:	ec5e                	sd	s7,24(sp)
    80002de2:	e862                	sd	s8,16(sp)
    80002de4:	e466                	sd	s9,8(sp)
    80002de6:	e06a                	sd	s10,0(sp)
    80002de8:	1080                	addi	s0,sp,96
    80002dea:	84aa                	mv	s1,a0
    80002dec:	8b2e                	mv	s6,a1
    80002dee:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80002df0:	00054703          	lbu	a4,0(a0)
    80002df4:	02f00793          	li	a5,47
    80002df8:	00f70f63          	beq	a4,a5,80002e16 <namex+0x48>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80002dfc:	838fe0ef          	jal	80000e34 <myproc>
    80002e00:	15853503          	ld	a0,344(a0)
    80002e04:	945ff0ef          	jal	80002748 <idup>
    80002e08:	8a2a                	mv	s4,a0
  while(*path == '/')
    80002e0a:	02f00993          	li	s3,47
  if(len >= DIRSIZ)
    80002e0e:	4c35                	li	s8,13
    memmove(name, s, DIRSIZ);
    80002e10:	4cb9                	li	s9,14

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80002e12:	4b85                	li	s7,1
    80002e14:	a879                	j	80002eb2 <namex+0xe4>
    ip = iget(ROOTDEV, ROOTINO);
    80002e16:	4585                	li	a1,1
    80002e18:	852e                	mv	a0,a1
    80002e1a:	eeaff0ef          	jal	80002504 <iget>
    80002e1e:	8a2a                	mv	s4,a0
    80002e20:	b7ed                	j	80002e0a <namex+0x3c>
      iunlockput(ip);
    80002e22:	8552                	mv	a0,s4
    80002e24:	b73ff0ef          	jal	80002996 <iunlockput>
      return 0;
    80002e28:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80002e2a:	8552                	mv	a0,s4
    80002e2c:	60e6                	ld	ra,88(sp)
    80002e2e:	6446                	ld	s0,80(sp)
    80002e30:	64a6                	ld	s1,72(sp)
    80002e32:	6906                	ld	s2,64(sp)
    80002e34:	79e2                	ld	s3,56(sp)
    80002e36:	7a42                	ld	s4,48(sp)
    80002e38:	7aa2                	ld	s5,40(sp)
    80002e3a:	7b02                	ld	s6,32(sp)
    80002e3c:	6be2                	ld	s7,24(sp)
    80002e3e:	6c42                	ld	s8,16(sp)
    80002e40:	6ca2                	ld	s9,8(sp)
    80002e42:	6d02                	ld	s10,0(sp)
    80002e44:	6125                	addi	sp,sp,96
    80002e46:	8082                	ret
      iunlock(ip);
    80002e48:	8552                	mv	a0,s4
    80002e4a:	9e9ff0ef          	jal	80002832 <iunlock>
      return ip;
    80002e4e:	bff1                	j	80002e2a <namex+0x5c>
      iunlockput(ip);
    80002e50:	8552                	mv	a0,s4
    80002e52:	b45ff0ef          	jal	80002996 <iunlockput>
      return 0;
    80002e56:	8a4a                	mv	s4,s2
    80002e58:	bfc9                	j	80002e2a <namex+0x5c>
  while(*path != '/' && *path != 0)
    80002e5a:	8926                	mv	s2,s1
  len = path - s;
    80002e5c:	4d01                	li	s10,0
    80002e5e:	4601                	li	a2,0
    memmove(name, s, len);
    80002e60:	2601                	sext.w	a2,a2
    80002e62:	85a6                	mv	a1,s1
    80002e64:	8556                	mv	a0,s5
    80002e66:	c2cfd0ef          	jal	80000292 <memmove>
    name[len] = 0;
    80002e6a:	9d56                	add	s10,s10,s5
    80002e6c:	000d0023          	sb	zero,0(s10) # fffffffffffff000 <end+0xffffffff7ffda6c0>
    80002e70:	84ca                	mv	s1,s2
  while(*path == '/')
    80002e72:	0004c783          	lbu	a5,0(s1)
    80002e76:	01379763          	bne	a5,s3,80002e84 <namex+0xb6>
    path++;
    80002e7a:	0485                	addi	s1,s1,1
  while(*path == '/')
    80002e7c:	0004c783          	lbu	a5,0(s1)
    80002e80:	ff378de3          	beq	a5,s3,80002e7a <namex+0xac>
    ilock(ip);
    80002e84:	8552                	mv	a0,s4
    80002e86:	8f9ff0ef          	jal	8000277e <ilock>
    if(ip->type != T_DIR){
    80002e8a:	04ca1783          	lh	a5,76(s4)
    80002e8e:	f9779ae3          	bne	a5,s7,80002e22 <namex+0x54>
    if(nameiparent && *path == '\0'){
    80002e92:	000b0563          	beqz	s6,80002e9c <namex+0xce>
    80002e96:	0004c783          	lbu	a5,0(s1)
    80002e9a:	d7dd                	beqz	a5,80002e48 <namex+0x7a>
    if((next = dirlookup(ip, name, 0)) == 0){
    80002e9c:	4601                	li	a2,0
    80002e9e:	85d6                	mv	a1,s5
    80002ea0:	8552                	mv	a0,s4
    80002ea2:	e85ff0ef          	jal	80002d26 <dirlookup>
    80002ea6:	892a                	mv	s2,a0
    80002ea8:	d545                	beqz	a0,80002e50 <namex+0x82>
    iunlockput(ip);
    80002eaa:	8552                	mv	a0,s4
    80002eac:	aebff0ef          	jal	80002996 <iunlockput>
    ip = next;
    80002eb0:	8a4a                	mv	s4,s2
  while(*path == '/')
    80002eb2:	0004c783          	lbu	a5,0(s1)
    80002eb6:	01379763          	bne	a5,s3,80002ec4 <namex+0xf6>
    path++;
    80002eba:	0485                	addi	s1,s1,1
  while(*path == '/')
    80002ebc:	0004c783          	lbu	a5,0(s1)
    80002ec0:	ff378de3          	beq	a5,s3,80002eba <namex+0xec>
  if(*path == 0)
    80002ec4:	c7a1                	beqz	a5,80002f0c <namex+0x13e>
  while(*path != '/' && *path != 0)
    80002ec6:	0004c703          	lbu	a4,0(s1)
    80002eca:	fd170793          	addi	a5,a4,-47
    80002ece:	00f037b3          	snez	a5,a5
    80002ed2:	00e03733          	snez	a4,a4
    80002ed6:	8ff9                	and	a5,a5,a4
    80002ed8:	d3c9                	beqz	a5,80002e5a <namex+0x8c>
    80002eda:	8926                	mv	s2,s1
    path++;
    80002edc:	0905                	addi	s2,s2,1
  while(*path != '/' && *path != 0)
    80002ede:	00094703          	lbu	a4,0(s2)
    80002ee2:	fd170793          	addi	a5,a4,-47
    80002ee6:	00f037b3          	snez	a5,a5
    80002eea:	00e03733          	snez	a4,a4
    80002eee:	8ff9                	and	a5,a5,a4
    80002ef0:	f7f5                	bnez	a5,80002edc <namex+0x10e>
  len = path - s;
    80002ef2:	40990633          	sub	a2,s2,s1
    80002ef6:	00060d1b          	sext.w	s10,a2
  if(len >= DIRSIZ)
    80002efa:	f7ac53e3          	bge	s8,s10,80002e60 <namex+0x92>
    memmove(name, s, DIRSIZ);
    80002efe:	8666                	mv	a2,s9
    80002f00:	85a6                	mv	a1,s1
    80002f02:	8556                	mv	a0,s5
    80002f04:	b8efd0ef          	jal	80000292 <memmove>
    80002f08:	84ca                	mv	s1,s2
    80002f0a:	b7a5                	j	80002e72 <namex+0xa4>
  if(nameiparent){
    80002f0c:	f00b0fe3          	beqz	s6,80002e2a <namex+0x5c>
    iput(ip);
    80002f10:	8552                	mv	a0,s4
    80002f12:	9fbff0ef          	jal	8000290c <iput>
    return 0;
    80002f16:	bf09                	j	80002e28 <namex+0x5a>

0000000080002f18 <dirlink>:
{
    80002f18:	715d                	addi	sp,sp,-80
    80002f1a:	e486                	sd	ra,72(sp)
    80002f1c:	e0a2                	sd	s0,64(sp)
    80002f1e:	f84a                	sd	s2,48(sp)
    80002f20:	ec56                	sd	s5,24(sp)
    80002f22:	e85a                	sd	s6,16(sp)
    80002f24:	0880                	addi	s0,sp,80
    80002f26:	892a                	mv	s2,a0
    80002f28:	8aae                	mv	s5,a1
    80002f2a:	8b32                	mv	s6,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80002f2c:	4601                	li	a2,0
    80002f2e:	df9ff0ef          	jal	80002d26 <dirlookup>
    80002f32:	ed1d                	bnez	a0,80002f70 <dirlink+0x58>
    80002f34:	fc26                	sd	s1,56(sp)
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002f36:	05492483          	lw	s1,84(s2)
    80002f3a:	c4b9                	beqz	s1,80002f88 <dirlink+0x70>
    80002f3c:	f44e                	sd	s3,40(sp)
    80002f3e:	f052                	sd	s4,32(sp)
    80002f40:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002f42:	fb040a13          	addi	s4,s0,-80
    80002f46:	49c1                	li	s3,16
    80002f48:	874e                	mv	a4,s3
    80002f4a:	86a6                	mv	a3,s1
    80002f4c:	8652                	mv	a2,s4
    80002f4e:	4581                	li	a1,0
    80002f50:	854a                	mv	a0,s2
    80002f52:	bcbff0ef          	jal	80002b1c <readi>
    80002f56:	03351163          	bne	a0,s3,80002f78 <dirlink+0x60>
    if(de.inum == 0)
    80002f5a:	fb045783          	lhu	a5,-80(s0)
    80002f5e:	c39d                	beqz	a5,80002f84 <dirlink+0x6c>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002f60:	24c1                	addiw	s1,s1,16
    80002f62:	05492783          	lw	a5,84(s2)
    80002f66:	fef4e1e3          	bltu	s1,a5,80002f48 <dirlink+0x30>
    80002f6a:	79a2                	ld	s3,40(sp)
    80002f6c:	7a02                	ld	s4,32(sp)
    80002f6e:	a829                	j	80002f88 <dirlink+0x70>
    iput(ip);
    80002f70:	99dff0ef          	jal	8000290c <iput>
    return -1;
    80002f74:	557d                	li	a0,-1
    80002f76:	a83d                	j	80002fb4 <dirlink+0x9c>
      panic("dirlink read");
    80002f78:	00005517          	auipc	a0,0x5
    80002f7c:	4f050513          	addi	a0,a0,1264 # 80008468 <etext+0x468>
    80002f80:	2df020ef          	jal	80005a5e <panic>
    80002f84:	79a2                	ld	s3,40(sp)
    80002f86:	7a02                	ld	s4,32(sp)
  strncpy(de.name, name, DIRSIZ);
    80002f88:	4639                	li	a2,14
    80002f8a:	85d6                	mv	a1,s5
    80002f8c:	fb240513          	addi	a0,s0,-78
    80002f90:	bacfd0ef          	jal	8000033c <strncpy>
  de.inum = inum;
    80002f94:	fb641823          	sh	s6,-80(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002f98:	4741                	li	a4,16
    80002f9a:	86a6                	mv	a3,s1
    80002f9c:	fb040613          	addi	a2,s0,-80
    80002fa0:	4581                	li	a1,0
    80002fa2:	854a                	mv	a0,s2
    80002fa4:	c6bff0ef          	jal	80002c0e <writei>
    80002fa8:	1541                	addi	a0,a0,-16
    80002faa:	00a03533          	snez	a0,a0
    80002fae:	40a0053b          	negw	a0,a0
    80002fb2:	74e2                	ld	s1,56(sp)
}
    80002fb4:	60a6                	ld	ra,72(sp)
    80002fb6:	6406                	ld	s0,64(sp)
    80002fb8:	7942                	ld	s2,48(sp)
    80002fba:	6ae2                	ld	s5,24(sp)
    80002fbc:	6b42                	ld	s6,16(sp)
    80002fbe:	6161                	addi	sp,sp,80
    80002fc0:	8082                	ret

0000000080002fc2 <namei>:

struct inode*
namei(char *path)
{
    80002fc2:	1101                	addi	sp,sp,-32
    80002fc4:	ec06                	sd	ra,24(sp)
    80002fc6:	e822                	sd	s0,16(sp)
    80002fc8:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80002fca:	fe040613          	addi	a2,s0,-32
    80002fce:	4581                	li	a1,0
    80002fd0:	dffff0ef          	jal	80002dce <namex>
}
    80002fd4:	60e2                	ld	ra,24(sp)
    80002fd6:	6442                	ld	s0,16(sp)
    80002fd8:	6105                	addi	sp,sp,32
    80002fda:	8082                	ret

0000000080002fdc <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80002fdc:	1141                	addi	sp,sp,-16
    80002fde:	e406                	sd	ra,8(sp)
    80002fe0:	e022                	sd	s0,0(sp)
    80002fe2:	0800                	addi	s0,sp,16
    80002fe4:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80002fe6:	4585                	li	a1,1
    80002fe8:	de7ff0ef          	jal	80002dce <namex>
}
    80002fec:	60a2                	ld	ra,8(sp)
    80002fee:	6402                	ld	s0,0(sp)
    80002ff0:	0141                	addi	sp,sp,16
    80002ff2:	8082                	ret

0000000080002ff4 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80002ff4:	1101                	addi	sp,sp,-32
    80002ff6:	ec06                	sd	ra,24(sp)
    80002ff8:	e822                	sd	s0,16(sp)
    80002ffa:	e426                	sd	s1,8(sp)
    80002ffc:	e04a                	sd	s2,0(sp)
    80002ffe:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003000:	00016917          	auipc	s2,0x16
    80003004:	52090913          	addi	s2,s2,1312 # 80019520 <log>
    80003008:	02092583          	lw	a1,32(s2)
    8000300c:	02c92503          	lw	a0,44(s2)
    80003010:	8ceff0ef          	jal	800020de <bread>
    80003014:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80003016:	03092603          	lw	a2,48(s2)
    8000301a:	d130                	sw	a2,96(a0)
  for (i = 0; i < log.lh.n; i++) {
    8000301c:	00c05f63          	blez	a2,8000303a <write_head+0x46>
    80003020:	00016717          	auipc	a4,0x16
    80003024:	53470713          	addi	a4,a4,1332 # 80019554 <log+0x34>
    80003028:	87aa                	mv	a5,a0
    8000302a:	060a                	slli	a2,a2,0x2
    8000302c:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    8000302e:	4314                	lw	a3,0(a4)
    80003030:	d3f4                	sw	a3,100(a5)
  for (i = 0; i < log.lh.n; i++) {
    80003032:	0711                	addi	a4,a4,4
    80003034:	0791                	addi	a5,a5,4 # 43004 <_entry-0x7ffbcffc>
    80003036:	fec79ce3          	bne	a5,a2,8000302e <write_head+0x3a>
  }
  bwrite(buf);
    8000303a:	8526                	mv	a0,s1
    8000303c:	978ff0ef          	jal	800021b4 <bwrite>
  brelse(buf);
    80003040:	8526                	mv	a0,s1
    80003042:	9a4ff0ef          	jal	800021e6 <brelse>
}
    80003046:	60e2                	ld	ra,24(sp)
    80003048:	6442                	ld	s0,16(sp)
    8000304a:	64a2                	ld	s1,8(sp)
    8000304c:	6902                	ld	s2,0(sp)
    8000304e:	6105                	addi	sp,sp,32
    80003050:	8082                	ret

0000000080003052 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80003052:	00016797          	auipc	a5,0x16
    80003056:	4fe7a783          	lw	a5,1278(a5) # 80019550 <log+0x30>
    8000305a:	0cf05163          	blez	a5,8000311c <install_trans+0xca>
{
    8000305e:	715d                	addi	sp,sp,-80
    80003060:	e486                	sd	ra,72(sp)
    80003062:	e0a2                	sd	s0,64(sp)
    80003064:	fc26                	sd	s1,56(sp)
    80003066:	f84a                	sd	s2,48(sp)
    80003068:	f44e                	sd	s3,40(sp)
    8000306a:	f052                	sd	s4,32(sp)
    8000306c:	ec56                	sd	s5,24(sp)
    8000306e:	e85a                	sd	s6,16(sp)
    80003070:	e45e                	sd	s7,8(sp)
    80003072:	e062                	sd	s8,0(sp)
    80003074:	0880                	addi	s0,sp,80
    80003076:	8b2a                	mv	s6,a0
    80003078:	00016a97          	auipc	s5,0x16
    8000307c:	4dca8a93          	addi	s5,s5,1244 # 80019554 <log+0x34>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003080:	4981                	li	s3,0
      printf("recovering tail %d dst %d\n", tail, log.lh.block[tail]);
    80003082:	00005c17          	auipc	s8,0x5
    80003086:	3f6c0c13          	addi	s8,s8,1014 # 80008478 <etext+0x478>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000308a:	00016a17          	auipc	s4,0x16
    8000308e:	496a0a13          	addi	s4,s4,1174 # 80019520 <log>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80003092:	40000b93          	li	s7,1024
    80003096:	a025                	j	800030be <install_trans+0x6c>
      printf("recovering tail %d dst %d\n", tail, log.lh.block[tail]);
    80003098:	000aa603          	lw	a2,0(s5)
    8000309c:	85ce                	mv	a1,s3
    8000309e:	8562                	mv	a0,s8
    800030a0:	686020ef          	jal	80005726 <printf>
    800030a4:	a839                	j	800030c2 <install_trans+0x70>
    brelse(lbuf);
    800030a6:	854a                	mv	a0,s2
    800030a8:	93eff0ef          	jal	800021e6 <brelse>
    brelse(dbuf);
    800030ac:	8526                	mv	a0,s1
    800030ae:	938ff0ef          	jal	800021e6 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800030b2:	2985                	addiw	s3,s3,1
    800030b4:	0a91                	addi	s5,s5,4
    800030b6:	030a2783          	lw	a5,48(s4)
    800030ba:	04f9d563          	bge	s3,a5,80003104 <install_trans+0xb2>
    if(recovering) {
    800030be:	fc0b1de3          	bnez	s6,80003098 <install_trans+0x46>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800030c2:	020a2583          	lw	a1,32(s4)
    800030c6:	013585bb          	addw	a1,a1,s3
    800030ca:	2585                	addiw	a1,a1,1
    800030cc:	02ca2503          	lw	a0,44(s4)
    800030d0:	80eff0ef          	jal	800020de <bread>
    800030d4:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    800030d6:	000aa583          	lw	a1,0(s5)
    800030da:	02ca2503          	lw	a0,44(s4)
    800030de:	800ff0ef          	jal	800020de <bread>
    800030e2:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800030e4:	865e                	mv	a2,s7
    800030e6:	06090593          	addi	a1,s2,96
    800030ea:	06050513          	addi	a0,a0,96
    800030ee:	9a4fd0ef          	jal	80000292 <memmove>
    bwrite(dbuf);  // write dst to disk
    800030f2:	8526                	mv	a0,s1
    800030f4:	8c0ff0ef          	jal	800021b4 <bwrite>
    if(recovering == 0)
    800030f8:	fa0b17e3          	bnez	s6,800030a6 <install_trans+0x54>
      bunpin(dbuf);
    800030fc:	8526                	mv	a0,s1
    800030fe:	9a0ff0ef          	jal	8000229e <bunpin>
    80003102:	b755                	j	800030a6 <install_trans+0x54>
}
    80003104:	60a6                	ld	ra,72(sp)
    80003106:	6406                	ld	s0,64(sp)
    80003108:	74e2                	ld	s1,56(sp)
    8000310a:	7942                	ld	s2,48(sp)
    8000310c:	79a2                	ld	s3,40(sp)
    8000310e:	7a02                	ld	s4,32(sp)
    80003110:	6ae2                	ld	s5,24(sp)
    80003112:	6b42                	ld	s6,16(sp)
    80003114:	6ba2                	ld	s7,8(sp)
    80003116:	6c02                	ld	s8,0(sp)
    80003118:	6161                	addi	sp,sp,80
    8000311a:	8082                	ret
    8000311c:	8082                	ret

000000008000311e <initlog>:
{
    8000311e:	7179                	addi	sp,sp,-48
    80003120:	f406                	sd	ra,40(sp)
    80003122:	f022                	sd	s0,32(sp)
    80003124:	ec26                	sd	s1,24(sp)
    80003126:	e84a                	sd	s2,16(sp)
    80003128:	e44e                	sd	s3,8(sp)
    8000312a:	1800                	addi	s0,sp,48
    8000312c:	84aa                	mv	s1,a0
    8000312e:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003130:	00016917          	auipc	s2,0x16
    80003134:	3f090913          	addi	s2,s2,1008 # 80019520 <log>
    80003138:	00005597          	auipc	a1,0x5
    8000313c:	36058593          	addi	a1,a1,864 # 80008498 <etext+0x498>
    80003140:	854a                	mv	a0,s2
    80003142:	62d020ef          	jal	80005f6e <initlock>
  log.start = sb->logstart;
    80003146:	0149a583          	lw	a1,20(s3)
    8000314a:	02b92023          	sw	a1,32(s2)
  log.dev = dev;
    8000314e:	02992623          	sw	s1,44(s2)
  struct buf *buf = bread(log.dev, log.start);
    80003152:	8526                	mv	a0,s1
    80003154:	f8bfe0ef          	jal	800020de <bread>
  log.lh.n = lh->n;
    80003158:	5130                	lw	a2,96(a0)
    8000315a:	02c92823          	sw	a2,48(s2)
  for (i = 0; i < log.lh.n; i++) {
    8000315e:	00c05f63          	blez	a2,8000317c <initlog+0x5e>
    80003162:	87aa                	mv	a5,a0
    80003164:	00016717          	auipc	a4,0x16
    80003168:	3f070713          	addi	a4,a4,1008 # 80019554 <log+0x34>
    8000316c:	060a                	slli	a2,a2,0x2
    8000316e:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    80003170:	53f4                	lw	a3,100(a5)
    80003172:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003174:	0791                	addi	a5,a5,4
    80003176:	0711                	addi	a4,a4,4
    80003178:	fec79ce3          	bne	a5,a2,80003170 <initlog+0x52>
  brelse(buf);
    8000317c:	86aff0ef          	jal	800021e6 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80003180:	4505                	li	a0,1
    80003182:	ed1ff0ef          	jal	80003052 <install_trans>
  log.lh.n = 0;
    80003186:	00016797          	auipc	a5,0x16
    8000318a:	3c07a523          	sw	zero,970(a5) # 80019550 <log+0x30>
  write_head(); // clear the log
    8000318e:	e67ff0ef          	jal	80002ff4 <write_head>
}
    80003192:	70a2                	ld	ra,40(sp)
    80003194:	7402                	ld	s0,32(sp)
    80003196:	64e2                	ld	s1,24(sp)
    80003198:	6942                	ld	s2,16(sp)
    8000319a:	69a2                	ld	s3,8(sp)
    8000319c:	6145                	addi	sp,sp,48
    8000319e:	8082                	ret

00000000800031a0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    800031a0:	1101                	addi	sp,sp,-32
    800031a2:	ec06                	sd	ra,24(sp)
    800031a4:	e822                	sd	s0,16(sp)
    800031a6:	e426                	sd	s1,8(sp)
    800031a8:	e04a                	sd	s2,0(sp)
    800031aa:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    800031ac:	00016517          	auipc	a0,0x16
    800031b0:	37450513          	addi	a0,a0,884 # 80019520 <log>
    800031b4:	3e7020ef          	jal	80005d9a <acquire>
  while(1){
    if(log.committing){
    800031b8:	00016497          	auipc	s1,0x16
    800031bc:	36848493          	addi	s1,s1,872 # 80019520 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGBLOCKS){
    800031c0:	4979                	li	s2,30
    800031c2:	a029                	j	800031cc <begin_op+0x2c>
      sleep(&log, &log.lock);
    800031c4:	85a6                	mv	a1,s1
    800031c6:	8526                	mv	a0,s1
    800031c8:	aa2fe0ef          	jal	8000146a <sleep>
    if(log.committing){
    800031cc:	549c                	lw	a5,40(s1)
    800031ce:	fbfd                	bnez	a5,800031c4 <begin_op+0x24>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGBLOCKS){
    800031d0:	50d8                	lw	a4,36(s1)
    800031d2:	2705                	addiw	a4,a4,1
    800031d4:	0027179b          	slliw	a5,a4,0x2
    800031d8:	9fb9                	addw	a5,a5,a4
    800031da:	0017979b          	slliw	a5,a5,0x1
    800031de:	5894                	lw	a3,48(s1)
    800031e0:	9fb5                	addw	a5,a5,a3
    800031e2:	00f95763          	bge	s2,a5,800031f0 <begin_op+0x50>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    800031e6:	85a6                	mv	a1,s1
    800031e8:	8526                	mv	a0,s1
    800031ea:	a80fe0ef          	jal	8000146a <sleep>
    800031ee:	bff9                	j	800031cc <begin_op+0x2c>
    } else {
      log.outstanding += 1;
    800031f0:	00016797          	auipc	a5,0x16
    800031f4:	34e7aa23          	sw	a4,852(a5) # 80019544 <log+0x24>
      release(&log.lock);
    800031f8:	00016517          	auipc	a0,0x16
    800031fc:	32850513          	addi	a0,a0,808 # 80019520 <log>
    80003200:	4d7020ef          	jal	80005ed6 <release>
      break;
    }
  }
}
    80003204:	60e2                	ld	ra,24(sp)
    80003206:	6442                	ld	s0,16(sp)
    80003208:	64a2                	ld	s1,8(sp)
    8000320a:	6902                	ld	s2,0(sp)
    8000320c:	6105                	addi	sp,sp,32
    8000320e:	8082                	ret

0000000080003210 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003210:	7139                	addi	sp,sp,-64
    80003212:	fc06                	sd	ra,56(sp)
    80003214:	f822                	sd	s0,48(sp)
    80003216:	f426                	sd	s1,40(sp)
    80003218:	f04a                	sd	s2,32(sp)
    8000321a:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    8000321c:	00016497          	auipc	s1,0x16
    80003220:	30448493          	addi	s1,s1,772 # 80019520 <log>
    80003224:	8526                	mv	a0,s1
    80003226:	375020ef          	jal	80005d9a <acquire>
  log.outstanding -= 1;
    8000322a:	50dc                	lw	a5,36(s1)
    8000322c:	37fd                	addiw	a5,a5,-1
    8000322e:	893e                	mv	s2,a5
    80003230:	d0dc                	sw	a5,36(s1)
  if(log.committing)
    80003232:	549c                	lw	a5,40(s1)
    80003234:	ebb9                	bnez	a5,8000328a <end_op+0x7a>
    panic("log.committing");
  if(log.outstanding == 0){
    80003236:	06091363          	bnez	s2,8000329c <end_op+0x8c>
    do_commit = 1;
    log.committing = 1;
    8000323a:	00016497          	auipc	s1,0x16
    8000323e:	2e648493          	addi	s1,s1,742 # 80019520 <log>
    80003242:	4785                	li	a5,1
    80003244:	d49c                	sw	a5,40(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80003246:	8526                	mv	a0,s1
    80003248:	48f020ef          	jal	80005ed6 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    8000324c:	589c                	lw	a5,48(s1)
    8000324e:	06f04463          	bgtz	a5,800032b6 <end_op+0xa6>
    acquire(&log.lock);
    80003252:	00016517          	auipc	a0,0x16
    80003256:	2ce50513          	addi	a0,a0,718 # 80019520 <log>
    8000325a:	341020ef          	jal	80005d9a <acquire>
    log.committing = 0;
    8000325e:	00016797          	auipc	a5,0x16
    80003262:	2e07a523          	sw	zero,746(a5) # 80019548 <log+0x28>
    wakeup(&log);
    80003266:	00016517          	auipc	a0,0x16
    8000326a:	2ba50513          	addi	a0,a0,698 # 80019520 <log>
    8000326e:	a48fe0ef          	jal	800014b6 <wakeup>
    release(&log.lock);
    80003272:	00016517          	auipc	a0,0x16
    80003276:	2ae50513          	addi	a0,a0,686 # 80019520 <log>
    8000327a:	45d020ef          	jal	80005ed6 <release>
}
    8000327e:	70e2                	ld	ra,56(sp)
    80003280:	7442                	ld	s0,48(sp)
    80003282:	74a2                	ld	s1,40(sp)
    80003284:	7902                	ld	s2,32(sp)
    80003286:	6121                	addi	sp,sp,64
    80003288:	8082                	ret
    8000328a:	ec4e                	sd	s3,24(sp)
    8000328c:	e852                	sd	s4,16(sp)
    8000328e:	e456                	sd	s5,8(sp)
    panic("log.committing");
    80003290:	00005517          	auipc	a0,0x5
    80003294:	21050513          	addi	a0,a0,528 # 800084a0 <etext+0x4a0>
    80003298:	7c6020ef          	jal	80005a5e <panic>
    wakeup(&log);
    8000329c:	00016517          	auipc	a0,0x16
    800032a0:	28450513          	addi	a0,a0,644 # 80019520 <log>
    800032a4:	a12fe0ef          	jal	800014b6 <wakeup>
  release(&log.lock);
    800032a8:	00016517          	auipc	a0,0x16
    800032ac:	27850513          	addi	a0,a0,632 # 80019520 <log>
    800032b0:	427020ef          	jal	80005ed6 <release>
  if(do_commit){
    800032b4:	b7e9                	j	8000327e <end_op+0x6e>
    800032b6:	ec4e                	sd	s3,24(sp)
    800032b8:	e852                	sd	s4,16(sp)
    800032ba:	e456                	sd	s5,8(sp)
  for (tail = 0; tail < log.lh.n; tail++) {
    800032bc:	00016a97          	auipc	s5,0x16
    800032c0:	298a8a93          	addi	s5,s5,664 # 80019554 <log+0x34>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800032c4:	00016a17          	auipc	s4,0x16
    800032c8:	25ca0a13          	addi	s4,s4,604 # 80019520 <log>
    800032cc:	020a2583          	lw	a1,32(s4)
    800032d0:	012585bb          	addw	a1,a1,s2
    800032d4:	2585                	addiw	a1,a1,1
    800032d6:	02ca2503          	lw	a0,44(s4)
    800032da:	e05fe0ef          	jal	800020de <bread>
    800032de:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800032e0:	000aa583          	lw	a1,0(s5)
    800032e4:	02ca2503          	lw	a0,44(s4)
    800032e8:	df7fe0ef          	jal	800020de <bread>
    800032ec:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    800032ee:	40000613          	li	a2,1024
    800032f2:	06050593          	addi	a1,a0,96
    800032f6:	06048513          	addi	a0,s1,96
    800032fa:	f99fc0ef          	jal	80000292 <memmove>
    bwrite(to);  // write the log
    800032fe:	8526                	mv	a0,s1
    80003300:	eb5fe0ef          	jal	800021b4 <bwrite>
    brelse(from);
    80003304:	854e                	mv	a0,s3
    80003306:	ee1fe0ef          	jal	800021e6 <brelse>
    brelse(to);
    8000330a:	8526                	mv	a0,s1
    8000330c:	edbfe0ef          	jal	800021e6 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003310:	2905                	addiw	s2,s2,1
    80003312:	0a91                	addi	s5,s5,4
    80003314:	030a2783          	lw	a5,48(s4)
    80003318:	faf94ae3          	blt	s2,a5,800032cc <end_op+0xbc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    8000331c:	cd9ff0ef          	jal	80002ff4 <write_head>
    install_trans(0); // Now install writes to home locations
    80003320:	4501                	li	a0,0
    80003322:	d31ff0ef          	jal	80003052 <install_trans>
    log.lh.n = 0;
    80003326:	00016797          	auipc	a5,0x16
    8000332a:	2207a523          	sw	zero,554(a5) # 80019550 <log+0x30>
    write_head();    // Erase the transaction from the log
    8000332e:	cc7ff0ef          	jal	80002ff4 <write_head>
    80003332:	69e2                	ld	s3,24(sp)
    80003334:	6a42                	ld	s4,16(sp)
    80003336:	6aa2                	ld	s5,8(sp)
    80003338:	bf29                	j	80003252 <end_op+0x42>

000000008000333a <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    8000333a:	1101                	addi	sp,sp,-32
    8000333c:	ec06                	sd	ra,24(sp)
    8000333e:	e822                	sd	s0,16(sp)
    80003340:	e426                	sd	s1,8(sp)
    80003342:	1000                	addi	s0,sp,32
    80003344:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    80003346:	00016517          	auipc	a0,0x16
    8000334a:	1da50513          	addi	a0,a0,474 # 80019520 <log>
    8000334e:	24d020ef          	jal	80005d9a <acquire>
  if (log.lh.n >= LOGBLOCKS)
    80003352:	00016617          	auipc	a2,0x16
    80003356:	1fe62603          	lw	a2,510(a2) # 80019550 <log+0x30>
    8000335a:	47f5                	li	a5,29
    8000335c:	04c7cc63          	blt	a5,a2,800033b4 <log_write+0x7a>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80003360:	00016797          	auipc	a5,0x16
    80003364:	1e47a783          	lw	a5,484(a5) # 80019544 <log+0x24>
    80003368:	04f05c63          	blez	a5,800033c0 <log_write+0x86>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    8000336c:	4781                	li	a5,0
    8000336e:	04c05f63          	blez	a2,800033cc <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003372:	44cc                	lw	a1,12(s1)
    80003374:	00016717          	auipc	a4,0x16
    80003378:	1e070713          	addi	a4,a4,480 # 80019554 <log+0x34>
  for (i = 0; i < log.lh.n; i++) {
    8000337c:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000337e:	4314                	lw	a3,0(a4)
    80003380:	04b68663          	beq	a3,a1,800033cc <log_write+0x92>
  for (i = 0; i < log.lh.n; i++) {
    80003384:	2785                	addiw	a5,a5,1
    80003386:	0711                	addi	a4,a4,4
    80003388:	fef61be3          	bne	a2,a5,8000337e <log_write+0x44>
      break;
  }
  log.lh.block[i] = b->blockno;
    8000338c:	0631                	addi	a2,a2,12
    8000338e:	060a                	slli	a2,a2,0x2
    80003390:	00016797          	auipc	a5,0x16
    80003394:	19078793          	addi	a5,a5,400 # 80019520 <log>
    80003398:	97b2                	add	a5,a5,a2
    8000339a:	44d8                	lw	a4,12(s1)
    8000339c:	c3d8                	sw	a4,4(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    8000339e:	8526                	mv	a0,s1
    800033a0:	ecbfe0ef          	jal	8000226a <bpin>
    log.lh.n++;
    800033a4:	00016717          	auipc	a4,0x16
    800033a8:	17c70713          	addi	a4,a4,380 # 80019520 <log>
    800033ac:	5b1c                	lw	a5,48(a4)
    800033ae:	2785                	addiw	a5,a5,1
    800033b0:	db1c                	sw	a5,48(a4)
    800033b2:	a80d                	j	800033e4 <log_write+0xaa>
    panic("too big a transaction");
    800033b4:	00005517          	auipc	a0,0x5
    800033b8:	0fc50513          	addi	a0,a0,252 # 800084b0 <etext+0x4b0>
    800033bc:	6a2020ef          	jal	80005a5e <panic>
    panic("log_write outside of trans");
    800033c0:	00005517          	auipc	a0,0x5
    800033c4:	10850513          	addi	a0,a0,264 # 800084c8 <etext+0x4c8>
    800033c8:	696020ef          	jal	80005a5e <panic>
  log.lh.block[i] = b->blockno;
    800033cc:	00c78693          	addi	a3,a5,12
    800033d0:	068a                	slli	a3,a3,0x2
    800033d2:	00016717          	auipc	a4,0x16
    800033d6:	14e70713          	addi	a4,a4,334 # 80019520 <log>
    800033da:	9736                	add	a4,a4,a3
    800033dc:	44d4                	lw	a3,12(s1)
    800033de:	c354                	sw	a3,4(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800033e0:	faf60fe3          	beq	a2,a5,8000339e <log_write+0x64>
  }
  release(&log.lock);
    800033e4:	00016517          	auipc	a0,0x16
    800033e8:	13c50513          	addi	a0,a0,316 # 80019520 <log>
    800033ec:	2eb020ef          	jal	80005ed6 <release>
}
    800033f0:	60e2                	ld	ra,24(sp)
    800033f2:	6442                	ld	s0,16(sp)
    800033f4:	64a2                	ld	s1,8(sp)
    800033f6:	6105                	addi	sp,sp,32
    800033f8:	8082                	ret

00000000800033fa <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800033fa:	1101                	addi	sp,sp,-32
    800033fc:	ec06                	sd	ra,24(sp)
    800033fe:	e822                	sd	s0,16(sp)
    80003400:	e426                	sd	s1,8(sp)
    80003402:	e04a                	sd	s2,0(sp)
    80003404:	1000                	addi	s0,sp,32
    80003406:	84aa                	mv	s1,a0
    80003408:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    8000340a:	00005597          	auipc	a1,0x5
    8000340e:	0de58593          	addi	a1,a1,222 # 800084e8 <etext+0x4e8>
    80003412:	0521                	addi	a0,a0,8
    80003414:	35b020ef          	jal	80005f6e <initlock>
  lk->name = name;
    80003418:	0324b423          	sd	s2,40(s1)
  lk->locked = 0;
    8000341c:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003420:	0204a823          	sw	zero,48(s1)
}
    80003424:	60e2                	ld	ra,24(sp)
    80003426:	6442                	ld	s0,16(sp)
    80003428:	64a2                	ld	s1,8(sp)
    8000342a:	6902                	ld	s2,0(sp)
    8000342c:	6105                	addi	sp,sp,32
    8000342e:	8082                	ret

0000000080003430 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003430:	1101                	addi	sp,sp,-32
    80003432:	ec06                	sd	ra,24(sp)
    80003434:	e822                	sd	s0,16(sp)
    80003436:	e426                	sd	s1,8(sp)
    80003438:	e04a                	sd	s2,0(sp)
    8000343a:	1000                	addi	s0,sp,32
    8000343c:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8000343e:	00850913          	addi	s2,a0,8
    80003442:	854a                	mv	a0,s2
    80003444:	157020ef          	jal	80005d9a <acquire>
  while (lk->locked) {
    80003448:	409c                	lw	a5,0(s1)
    8000344a:	c799                	beqz	a5,80003458 <acquiresleep+0x28>
    sleep(lk, &lk->lk);
    8000344c:	85ca                	mv	a1,s2
    8000344e:	8526                	mv	a0,s1
    80003450:	81afe0ef          	jal	8000146a <sleep>
  while (lk->locked) {
    80003454:	409c                	lw	a5,0(s1)
    80003456:	fbfd                	bnez	a5,8000344c <acquiresleep+0x1c>
  }
  lk->locked = 1;
    80003458:	4785                	li	a5,1
    8000345a:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    8000345c:	9d9fd0ef          	jal	80000e34 <myproc>
    80003460:	5d1c                	lw	a5,56(a0)
    80003462:	d89c                	sw	a5,48(s1)
  release(&lk->lk);
    80003464:	854a                	mv	a0,s2
    80003466:	271020ef          	jal	80005ed6 <release>
}
    8000346a:	60e2                	ld	ra,24(sp)
    8000346c:	6442                	ld	s0,16(sp)
    8000346e:	64a2                	ld	s1,8(sp)
    80003470:	6902                	ld	s2,0(sp)
    80003472:	6105                	addi	sp,sp,32
    80003474:	8082                	ret

0000000080003476 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003476:	1101                	addi	sp,sp,-32
    80003478:	ec06                	sd	ra,24(sp)
    8000347a:	e822                	sd	s0,16(sp)
    8000347c:	e426                	sd	s1,8(sp)
    8000347e:	e04a                	sd	s2,0(sp)
    80003480:	1000                	addi	s0,sp,32
    80003482:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003484:	00850913          	addi	s2,a0,8
    80003488:	854a                	mv	a0,s2
    8000348a:	111020ef          	jal	80005d9a <acquire>
  lk->locked = 0;
    8000348e:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003492:	0204a823          	sw	zero,48(s1)
  wakeup(lk);
    80003496:	8526                	mv	a0,s1
    80003498:	81efe0ef          	jal	800014b6 <wakeup>
  release(&lk->lk);
    8000349c:	854a                	mv	a0,s2
    8000349e:	239020ef          	jal	80005ed6 <release>
}
    800034a2:	60e2                	ld	ra,24(sp)
    800034a4:	6442                	ld	s0,16(sp)
    800034a6:	64a2                	ld	s1,8(sp)
    800034a8:	6902                	ld	s2,0(sp)
    800034aa:	6105                	addi	sp,sp,32
    800034ac:	8082                	ret

00000000800034ae <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800034ae:	7179                	addi	sp,sp,-48
    800034b0:	f406                	sd	ra,40(sp)
    800034b2:	f022                	sd	s0,32(sp)
    800034b4:	ec26                	sd	s1,24(sp)
    800034b6:	e84a                	sd	s2,16(sp)
    800034b8:	1800                	addi	s0,sp,48
    800034ba:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    800034bc:	00850913          	addi	s2,a0,8
    800034c0:	854a                	mv	a0,s2
    800034c2:	0d9020ef          	jal	80005d9a <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800034c6:	409c                	lw	a5,0(s1)
    800034c8:	ef81                	bnez	a5,800034e0 <holdingsleep+0x32>
    800034ca:	4481                	li	s1,0
  release(&lk->lk);
    800034cc:	854a                	mv	a0,s2
    800034ce:	209020ef          	jal	80005ed6 <release>
  return r;
}
    800034d2:	8526                	mv	a0,s1
    800034d4:	70a2                	ld	ra,40(sp)
    800034d6:	7402                	ld	s0,32(sp)
    800034d8:	64e2                	ld	s1,24(sp)
    800034da:	6942                	ld	s2,16(sp)
    800034dc:	6145                	addi	sp,sp,48
    800034de:	8082                	ret
    800034e0:	e44e                	sd	s3,8(sp)
  r = lk->locked && (lk->pid == myproc()->pid);
    800034e2:	0304a983          	lw	s3,48(s1)
    800034e6:	94ffd0ef          	jal	80000e34 <myproc>
    800034ea:	5d04                	lw	s1,56(a0)
    800034ec:	413484b3          	sub	s1,s1,s3
    800034f0:	0014b493          	seqz	s1,s1
    800034f4:	69a2                	ld	s3,8(sp)
    800034f6:	bfd9                	j	800034cc <holdingsleep+0x1e>

00000000800034f8 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    800034f8:	1141                	addi	sp,sp,-16
    800034fa:	e406                	sd	ra,8(sp)
    800034fc:	e022                	sd	s0,0(sp)
    800034fe:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003500:	00005597          	auipc	a1,0x5
    80003504:	ff858593          	addi	a1,a1,-8 # 800084f8 <etext+0x4f8>
    80003508:	00016517          	auipc	a0,0x16
    8000350c:	16850513          	addi	a0,a0,360 # 80019670 <ftable>
    80003510:	25f020ef          	jal	80005f6e <initlock>
}
    80003514:	60a2                	ld	ra,8(sp)
    80003516:	6402                	ld	s0,0(sp)
    80003518:	0141                	addi	sp,sp,16
    8000351a:	8082                	ret

000000008000351c <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    8000351c:	1101                	addi	sp,sp,-32
    8000351e:	ec06                	sd	ra,24(sp)
    80003520:	e822                	sd	s0,16(sp)
    80003522:	e426                	sd	s1,8(sp)
    80003524:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003526:	00016517          	auipc	a0,0x16
    8000352a:	14a50513          	addi	a0,a0,330 # 80019670 <ftable>
    8000352e:	06d020ef          	jal	80005d9a <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003532:	00016497          	auipc	s1,0x16
    80003536:	15e48493          	addi	s1,s1,350 # 80019690 <ftable+0x20>
    8000353a:	00017717          	auipc	a4,0x17
    8000353e:	0f670713          	addi	a4,a4,246 # 8001a630 <disk>
    if(f->ref == 0){
    80003542:	40dc                	lw	a5,4(s1)
    80003544:	cf89                	beqz	a5,8000355e <filealloc+0x42>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003546:	02848493          	addi	s1,s1,40
    8000354a:	fee49ce3          	bne	s1,a4,80003542 <filealloc+0x26>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    8000354e:	00016517          	auipc	a0,0x16
    80003552:	12250513          	addi	a0,a0,290 # 80019670 <ftable>
    80003556:	181020ef          	jal	80005ed6 <release>
  return 0;
    8000355a:	4481                	li	s1,0
    8000355c:	a809                	j	8000356e <filealloc+0x52>
      f->ref = 1;
    8000355e:	4785                	li	a5,1
    80003560:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003562:	00016517          	auipc	a0,0x16
    80003566:	10e50513          	addi	a0,a0,270 # 80019670 <ftable>
    8000356a:	16d020ef          	jal	80005ed6 <release>
}
    8000356e:	8526                	mv	a0,s1
    80003570:	60e2                	ld	ra,24(sp)
    80003572:	6442                	ld	s0,16(sp)
    80003574:	64a2                	ld	s1,8(sp)
    80003576:	6105                	addi	sp,sp,32
    80003578:	8082                	ret

000000008000357a <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    8000357a:	1101                	addi	sp,sp,-32
    8000357c:	ec06                	sd	ra,24(sp)
    8000357e:	e822                	sd	s0,16(sp)
    80003580:	e426                	sd	s1,8(sp)
    80003582:	1000                	addi	s0,sp,32
    80003584:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003586:	00016517          	auipc	a0,0x16
    8000358a:	0ea50513          	addi	a0,a0,234 # 80019670 <ftable>
    8000358e:	00d020ef          	jal	80005d9a <acquire>
  if(f->ref < 1)
    80003592:	40dc                	lw	a5,4(s1)
    80003594:	02f05063          	blez	a5,800035b4 <filedup+0x3a>
    panic("filedup");
  f->ref++;
    80003598:	2785                	addiw	a5,a5,1
    8000359a:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    8000359c:	00016517          	auipc	a0,0x16
    800035a0:	0d450513          	addi	a0,a0,212 # 80019670 <ftable>
    800035a4:	133020ef          	jal	80005ed6 <release>
  return f;
}
    800035a8:	8526                	mv	a0,s1
    800035aa:	60e2                	ld	ra,24(sp)
    800035ac:	6442                	ld	s0,16(sp)
    800035ae:	64a2                	ld	s1,8(sp)
    800035b0:	6105                	addi	sp,sp,32
    800035b2:	8082                	ret
    panic("filedup");
    800035b4:	00005517          	auipc	a0,0x5
    800035b8:	f4c50513          	addi	a0,a0,-180 # 80008500 <etext+0x500>
    800035bc:	4a2020ef          	jal	80005a5e <panic>

00000000800035c0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    800035c0:	7139                	addi	sp,sp,-64
    800035c2:	fc06                	sd	ra,56(sp)
    800035c4:	f822                	sd	s0,48(sp)
    800035c6:	f426                	sd	s1,40(sp)
    800035c8:	0080                	addi	s0,sp,64
    800035ca:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    800035cc:	00016517          	auipc	a0,0x16
    800035d0:	0a450513          	addi	a0,a0,164 # 80019670 <ftable>
    800035d4:	7c6020ef          	jal	80005d9a <acquire>
  if(f->ref < 1)
    800035d8:	40dc                	lw	a5,4(s1)
    800035da:	04f05a63          	blez	a5,8000362e <fileclose+0x6e>
    panic("fileclose");
  if(--f->ref > 0){
    800035de:	37fd                	addiw	a5,a5,-1
    800035e0:	c0dc                	sw	a5,4(s1)
    800035e2:	06f04063          	bgtz	a5,80003642 <fileclose+0x82>
    800035e6:	f04a                	sd	s2,32(sp)
    800035e8:	ec4e                	sd	s3,24(sp)
    800035ea:	e852                	sd	s4,16(sp)
    800035ec:	e456                	sd	s5,8(sp)
    release(&ftable.lock);
    return;
  }
  ff = *f;
    800035ee:	0004a903          	lw	s2,0(s1)
    800035f2:	0094c783          	lbu	a5,9(s1)
    800035f6:	89be                	mv	s3,a5
    800035f8:	689c                	ld	a5,16(s1)
    800035fa:	8a3e                	mv	s4,a5
    800035fc:	6c9c                	ld	a5,24(s1)
    800035fe:	8abe                	mv	s5,a5
  f->ref = 0;
    80003600:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003604:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003608:	00016517          	auipc	a0,0x16
    8000360c:	06850513          	addi	a0,a0,104 # 80019670 <ftable>
    80003610:	0c7020ef          	jal	80005ed6 <release>

  if(ff.type == FD_PIPE){
    80003614:	4785                	li	a5,1
    80003616:	04f90163          	beq	s2,a5,80003658 <fileclose+0x98>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    8000361a:	ffe9079b          	addiw	a5,s2,-2
    8000361e:	4705                	li	a4,1
    80003620:	04f77563          	bgeu	a4,a5,8000366a <fileclose+0xaa>
    80003624:	7902                	ld	s2,32(sp)
    80003626:	69e2                	ld	s3,24(sp)
    80003628:	6a42                	ld	s4,16(sp)
    8000362a:	6aa2                	ld	s5,8(sp)
    8000362c:	a00d                	j	8000364e <fileclose+0x8e>
    8000362e:	f04a                	sd	s2,32(sp)
    80003630:	ec4e                	sd	s3,24(sp)
    80003632:	e852                	sd	s4,16(sp)
    80003634:	e456                	sd	s5,8(sp)
    panic("fileclose");
    80003636:	00005517          	auipc	a0,0x5
    8000363a:	ed250513          	addi	a0,a0,-302 # 80008508 <etext+0x508>
    8000363e:	420020ef          	jal	80005a5e <panic>
    release(&ftable.lock);
    80003642:	00016517          	auipc	a0,0x16
    80003646:	02e50513          	addi	a0,a0,46 # 80019670 <ftable>
    8000364a:	08d020ef          	jal	80005ed6 <release>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
    8000364e:	70e2                	ld	ra,56(sp)
    80003650:	7442                	ld	s0,48(sp)
    80003652:	74a2                	ld	s1,40(sp)
    80003654:	6121                	addi	sp,sp,64
    80003656:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003658:	85ce                	mv	a1,s3
    8000365a:	8552                	mv	a0,s4
    8000365c:	332000ef          	jal	8000398e <pipeclose>
    80003660:	7902                	ld	s2,32(sp)
    80003662:	69e2                	ld	s3,24(sp)
    80003664:	6a42                	ld	s4,16(sp)
    80003666:	6aa2                	ld	s5,8(sp)
    80003668:	b7dd                	j	8000364e <fileclose+0x8e>
    begin_op();
    8000366a:	b37ff0ef          	jal	800031a0 <begin_op>
    iput(ff.ip);
    8000366e:	8556                	mv	a0,s5
    80003670:	a9cff0ef          	jal	8000290c <iput>
    end_op();
    80003674:	b9dff0ef          	jal	80003210 <end_op>
    80003678:	7902                	ld	s2,32(sp)
    8000367a:	69e2                	ld	s3,24(sp)
    8000367c:	6a42                	ld	s4,16(sp)
    8000367e:	6aa2                	ld	s5,8(sp)
    80003680:	b7f9                	j	8000364e <fileclose+0x8e>

0000000080003682 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003682:	715d                	addi	sp,sp,-80
    80003684:	e486                	sd	ra,72(sp)
    80003686:	e0a2                	sd	s0,64(sp)
    80003688:	fc26                	sd	s1,56(sp)
    8000368a:	f052                	sd	s4,32(sp)
    8000368c:	0880                	addi	s0,sp,80
    8000368e:	84aa                	mv	s1,a0
    80003690:	8a2e                	mv	s4,a1
  struct proc *p = myproc();
    80003692:	fa2fd0ef          	jal	80000e34 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003696:	409c                	lw	a5,0(s1)
    80003698:	37f9                	addiw	a5,a5,-2
    8000369a:	4705                	li	a4,1
    8000369c:	04f76263          	bltu	a4,a5,800036e0 <filestat+0x5e>
    800036a0:	f84a                	sd	s2,48(sp)
    800036a2:	f44e                	sd	s3,40(sp)
    800036a4:	89aa                	mv	s3,a0
    ilock(f->ip);
    800036a6:	6c88                	ld	a0,24(s1)
    800036a8:	8d6ff0ef          	jal	8000277e <ilock>
    stati(f->ip, &st);
    800036ac:	fb840913          	addi	s2,s0,-72
    800036b0:	85ca                	mv	a1,s2
    800036b2:	6c88                	ld	a0,24(s1)
    800036b4:	c3aff0ef          	jal	80002aee <stati>
    iunlock(f->ip);
    800036b8:	6c88                	ld	a0,24(s1)
    800036ba:	978ff0ef          	jal	80002832 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    800036be:	46e1                	li	a3,24
    800036c0:	864a                	mv	a2,s2
    800036c2:	85d2                	mv	a1,s4
    800036c4:	0589b503          	ld	a0,88(s3)
    800036c8:	cb0fd0ef          	jal	80000b78 <copyout>
    800036cc:	41f5551b          	sraiw	a0,a0,0x1f
    800036d0:	7942                	ld	s2,48(sp)
    800036d2:	79a2                	ld	s3,40(sp)
      return -1;
    return 0;
  }
  return -1;
}
    800036d4:	60a6                	ld	ra,72(sp)
    800036d6:	6406                	ld	s0,64(sp)
    800036d8:	74e2                	ld	s1,56(sp)
    800036da:	7a02                	ld	s4,32(sp)
    800036dc:	6161                	addi	sp,sp,80
    800036de:	8082                	ret
  return -1;
    800036e0:	557d                	li	a0,-1
    800036e2:	bfcd                	j	800036d4 <filestat+0x52>

00000000800036e4 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    800036e4:	7179                	addi	sp,sp,-48
    800036e6:	f406                	sd	ra,40(sp)
    800036e8:	f022                	sd	s0,32(sp)
    800036ea:	e84a                	sd	s2,16(sp)
    800036ec:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    800036ee:	00854783          	lbu	a5,8(a0)
    800036f2:	c3c5                	beqz	a5,80003792 <fileread+0xae>
    800036f4:	ec26                	sd	s1,24(sp)
    800036f6:	e44e                	sd	s3,8(sp)
    800036f8:	84aa                	mv	s1,a0
    800036fa:	892e                	mv	s2,a1
    800036fc:	89b2                	mv	s3,a2
    return -1;

  if(f->type == FD_PIPE){
    800036fe:	411c                	lw	a5,0(a0)
    80003700:	4705                	li	a4,1
    80003702:	04e78363          	beq	a5,a4,80003748 <fileread+0x64>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003706:	470d                	li	a4,3
    80003708:	04e78763          	beq	a5,a4,80003756 <fileread+0x72>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    8000370c:	4709                	li	a4,2
    8000370e:	06e79a63          	bne	a5,a4,80003782 <fileread+0x9e>
    ilock(f->ip);
    80003712:	6d08                	ld	a0,24(a0)
    80003714:	86aff0ef          	jal	8000277e <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003718:	874e                	mv	a4,s3
    8000371a:	5094                	lw	a3,32(s1)
    8000371c:	864a                	mv	a2,s2
    8000371e:	4585                	li	a1,1
    80003720:	6c88                	ld	a0,24(s1)
    80003722:	bfaff0ef          	jal	80002b1c <readi>
    80003726:	892a                	mv	s2,a0
    80003728:	00a05563          	blez	a0,80003732 <fileread+0x4e>
      f->off += r;
    8000372c:	509c                	lw	a5,32(s1)
    8000372e:	9fa9                	addw	a5,a5,a0
    80003730:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003732:	6c88                	ld	a0,24(s1)
    80003734:	8feff0ef          	jal	80002832 <iunlock>
    80003738:	64e2                	ld	s1,24(sp)
    8000373a:	69a2                	ld	s3,8(sp)
  } else {
    panic("fileread");
  }

  return r;
}
    8000373c:	854a                	mv	a0,s2
    8000373e:	70a2                	ld	ra,40(sp)
    80003740:	7402                	ld	s0,32(sp)
    80003742:	6942                	ld	s2,16(sp)
    80003744:	6145                	addi	sp,sp,48
    80003746:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003748:	6908                	ld	a0,16(a0)
    8000374a:	3a0000ef          	jal	80003aea <piperead>
    8000374e:	892a                	mv	s2,a0
    80003750:	64e2                	ld	s1,24(sp)
    80003752:	69a2                	ld	s3,8(sp)
    80003754:	b7e5                	j	8000373c <fileread+0x58>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003756:	02451783          	lh	a5,36(a0)
    8000375a:	03079693          	slli	a3,a5,0x30
    8000375e:	92c1                	srli	a3,a3,0x30
    80003760:	4725                	li	a4,9
    80003762:	02d76663          	bltu	a4,a3,8000378e <fileread+0xaa>
    80003766:	0792                	slli	a5,a5,0x4
    80003768:	00016717          	auipc	a4,0x16
    8000376c:	e6870713          	addi	a4,a4,-408 # 800195d0 <devsw>
    80003770:	97ba                	add	a5,a5,a4
    80003772:	639c                	ld	a5,0(a5)
    80003774:	c395                	beqz	a5,80003798 <fileread+0xb4>
    r = devsw[f->major].read(1, addr, n);
    80003776:	4505                	li	a0,1
    80003778:	9782                	jalr	a5
    8000377a:	892a                	mv	s2,a0
    8000377c:	64e2                	ld	s1,24(sp)
    8000377e:	69a2                	ld	s3,8(sp)
    80003780:	bf75                	j	8000373c <fileread+0x58>
    panic("fileread");
    80003782:	00005517          	auipc	a0,0x5
    80003786:	d9650513          	addi	a0,a0,-618 # 80008518 <etext+0x518>
    8000378a:	2d4020ef          	jal	80005a5e <panic>
    8000378e:	64e2                	ld	s1,24(sp)
    80003790:	69a2                	ld	s3,8(sp)
    return -1;
    80003792:	57fd                	li	a5,-1
    80003794:	893e                	mv	s2,a5
    80003796:	b75d                	j	8000373c <fileread+0x58>
    80003798:	64e2                	ld	s1,24(sp)
    8000379a:	69a2                	ld	s3,8(sp)
    8000379c:	bfdd                	j	80003792 <fileread+0xae>

000000008000379e <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    8000379e:	00954783          	lbu	a5,9(a0)
    800037a2:	12078463          	beqz	a5,800038ca <filewrite+0x12c>
{
    800037a6:	711d                	addi	sp,sp,-96
    800037a8:	ec86                	sd	ra,88(sp)
    800037aa:	e8a2                	sd	s0,80(sp)
    800037ac:	e0ca                	sd	s2,64(sp)
    800037ae:	f456                	sd	s5,40(sp)
    800037b0:	f05a                	sd	s6,32(sp)
    800037b2:	1080                	addi	s0,sp,96
    800037b4:	892a                	mv	s2,a0
    800037b6:	8b2e                	mv	s6,a1
    800037b8:	8ab2                	mv	s5,a2
    return -1;

  if(f->type == FD_PIPE){
    800037ba:	411c                	lw	a5,0(a0)
    800037bc:	4705                	li	a4,1
    800037be:	02e78a63          	beq	a5,a4,800037f2 <filewrite+0x54>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800037c2:	470d                	li	a4,3
    800037c4:	02e78b63          	beq	a5,a4,800037fa <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    800037c8:	4709                	li	a4,2
    800037ca:	0ce79f63          	bne	a5,a4,800038a8 <filewrite+0x10a>
    800037ce:	f852                	sd	s4,48(sp)
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    800037d0:	0ac05a63          	blez	a2,80003884 <filewrite+0xe6>
    800037d4:	e4a6                	sd	s1,72(sp)
    800037d6:	fc4e                	sd	s3,56(sp)
    800037d8:	ec5e                	sd	s7,24(sp)
    800037da:	e862                	sd	s8,16(sp)
    800037dc:	e466                	sd	s9,8(sp)
    int i = 0;
    800037de:	4a01                	li	s4,0
      int n1 = n - i;
      if(n1 > max)
    800037e0:	6b85                	lui	s7,0x1
    800037e2:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    800037e6:	6785                	lui	a5,0x1
    800037e8:	c007879b          	addiw	a5,a5,-1024 # c00 <_entry-0x7ffff400>
    800037ec:	8cbe                	mv	s9,a5
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    800037ee:	4c05                	li	s8,1
    800037f0:	a8ad                	j	8000386a <filewrite+0xcc>
    ret = pipewrite(f->pipe, addr, n);
    800037f2:	6908                	ld	a0,16(a0)
    800037f4:	1fe000ef          	jal	800039f2 <pipewrite>
    800037f8:	a04d                	j	8000389a <filewrite+0xfc>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    800037fa:	02451783          	lh	a5,36(a0)
    800037fe:	03079693          	slli	a3,a5,0x30
    80003802:	92c1                	srli	a3,a3,0x30
    80003804:	4725                	li	a4,9
    80003806:	0ad76d63          	bltu	a4,a3,800038c0 <filewrite+0x122>
    8000380a:	0792                	slli	a5,a5,0x4
    8000380c:	00016717          	auipc	a4,0x16
    80003810:	dc470713          	addi	a4,a4,-572 # 800195d0 <devsw>
    80003814:	97ba                	add	a5,a5,a4
    80003816:	679c                	ld	a5,8(a5)
    80003818:	c7c5                	beqz	a5,800038c0 <filewrite+0x122>
    ret = devsw[f->major].write(1, addr, n);
    8000381a:	4505                	li	a0,1
    8000381c:	9782                	jalr	a5
    8000381e:	a8b5                	j	8000389a <filewrite+0xfc>
      if(n1 > max)
    80003820:	2981                	sext.w	s3,s3
      begin_op();
    80003822:	97fff0ef          	jal	800031a0 <begin_op>
      ilock(f->ip);
    80003826:	01893503          	ld	a0,24(s2)
    8000382a:	f55fe0ef          	jal	8000277e <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    8000382e:	874e                	mv	a4,s3
    80003830:	02092683          	lw	a3,32(s2)
    80003834:	016a0633          	add	a2,s4,s6
    80003838:	85e2                	mv	a1,s8
    8000383a:	01893503          	ld	a0,24(s2)
    8000383e:	bd0ff0ef          	jal	80002c0e <writei>
    80003842:	84aa                	mv	s1,a0
    80003844:	00a05763          	blez	a0,80003852 <filewrite+0xb4>
        f->off += r;
    80003848:	02092783          	lw	a5,32(s2)
    8000384c:	9fa9                	addw	a5,a5,a0
    8000384e:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003852:	01893503          	ld	a0,24(s2)
    80003856:	fddfe0ef          	jal	80002832 <iunlock>
      end_op();
    8000385a:	9b7ff0ef          	jal	80003210 <end_op>

      if(r != n1){
    8000385e:	02999563          	bne	s3,s1,80003888 <filewrite+0xea>
        // error from writei
        break;
      }
      i += r;
    80003862:	01448a3b          	addw	s4,s1,s4
    while(i < n){
    80003866:	015a5963          	bge	s4,s5,80003878 <filewrite+0xda>
      int n1 = n - i;
    8000386a:	414a87bb          	subw	a5,s5,s4
    8000386e:	89be                	mv	s3,a5
      if(n1 > max)
    80003870:	fafbd8e3          	bge	s7,a5,80003820 <filewrite+0x82>
    80003874:	89e6                	mv	s3,s9
    80003876:	b76d                	j	80003820 <filewrite+0x82>
    80003878:	64a6                	ld	s1,72(sp)
    8000387a:	79e2                	ld	s3,56(sp)
    8000387c:	6be2                	ld	s7,24(sp)
    8000387e:	6c42                	ld	s8,16(sp)
    80003880:	6ca2                	ld	s9,8(sp)
    80003882:	a801                	j	80003892 <filewrite+0xf4>
    int i = 0;
    80003884:	4a01                	li	s4,0
    80003886:	a031                	j	80003892 <filewrite+0xf4>
    80003888:	64a6                	ld	s1,72(sp)
    8000388a:	79e2                	ld	s3,56(sp)
    8000388c:	6be2                	ld	s7,24(sp)
    8000388e:	6c42                	ld	s8,16(sp)
    80003890:	6ca2                	ld	s9,8(sp)
    }
    ret = (i == n ? n : -1);
    80003892:	034a9963          	bne	s5,s4,800038c4 <filewrite+0x126>
    80003896:	8556                	mv	a0,s5
    80003898:	7a42                	ld	s4,48(sp)
  } else {
    panic("filewrite");
  }

  return ret;
}
    8000389a:	60e6                	ld	ra,88(sp)
    8000389c:	6446                	ld	s0,80(sp)
    8000389e:	6906                	ld	s2,64(sp)
    800038a0:	7aa2                	ld	s5,40(sp)
    800038a2:	7b02                	ld	s6,32(sp)
    800038a4:	6125                	addi	sp,sp,96
    800038a6:	8082                	ret
    800038a8:	e4a6                	sd	s1,72(sp)
    800038aa:	fc4e                	sd	s3,56(sp)
    800038ac:	f852                	sd	s4,48(sp)
    800038ae:	ec5e                	sd	s7,24(sp)
    800038b0:	e862                	sd	s8,16(sp)
    800038b2:	e466                	sd	s9,8(sp)
    panic("filewrite");
    800038b4:	00005517          	auipc	a0,0x5
    800038b8:	c7450513          	addi	a0,a0,-908 # 80008528 <etext+0x528>
    800038bc:	1a2020ef          	jal	80005a5e <panic>
    return -1;
    800038c0:	557d                	li	a0,-1
    800038c2:	bfe1                	j	8000389a <filewrite+0xfc>
    ret = (i == n ? n : -1);
    800038c4:	557d                	li	a0,-1
    800038c6:	7a42                	ld	s4,48(sp)
    800038c8:	bfc9                	j	8000389a <filewrite+0xfc>
    return -1;
    800038ca:	557d                	li	a0,-1
}
    800038cc:	8082                	ret

00000000800038ce <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    800038ce:	7179                	addi	sp,sp,-48
    800038d0:	f406                	sd	ra,40(sp)
    800038d2:	f022                	sd	s0,32(sp)
    800038d4:	ec26                	sd	s1,24(sp)
    800038d6:	e052                	sd	s4,0(sp)
    800038d8:	1800                	addi	s0,sp,48
    800038da:	84aa                	mv	s1,a0
    800038dc:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    800038de:	0005b023          	sd	zero,0(a1)
    800038e2:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    800038e6:	c37ff0ef          	jal	8000351c <filealloc>
    800038ea:	e088                	sd	a0,0(s1)
    800038ec:	c549                	beqz	a0,80003976 <pipealloc+0xa8>
    800038ee:	c2fff0ef          	jal	8000351c <filealloc>
    800038f2:	00aa3023          	sd	a0,0(s4)
    800038f6:	cd25                	beqz	a0,8000396e <pipealloc+0xa0>
    800038f8:	e84a                	sd	s2,16(sp)
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    800038fa:	865fc0ef          	jal	8000015e <kalloc>
    800038fe:	892a                	mv	s2,a0
    80003900:	c12d                	beqz	a0,80003962 <pipealloc+0x94>
    80003902:	e44e                	sd	s3,8(sp)
    goto bad;
  pi->readopen = 1;
    80003904:	4985                	li	s3,1
    80003906:	23352423          	sw	s3,552(a0)
  pi->writeopen = 1;
    8000390a:	23352623          	sw	s3,556(a0)
  pi->nwrite = 0;
    8000390e:	22052223          	sw	zero,548(a0)
  pi->nread = 0;
    80003912:	22052023          	sw	zero,544(a0)
  initlock(&pi->lock, "pipe");
    80003916:	00005597          	auipc	a1,0x5
    8000391a:	c2258593          	addi	a1,a1,-990 # 80008538 <etext+0x538>
    8000391e:	650020ef          	jal	80005f6e <initlock>
  (*f0)->type = FD_PIPE;
    80003922:	609c                	ld	a5,0(s1)
    80003924:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003928:	609c                	ld	a5,0(s1)
    8000392a:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    8000392e:	609c                	ld	a5,0(s1)
    80003930:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003934:	609c                	ld	a5,0(s1)
    80003936:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    8000393a:	000a3783          	ld	a5,0(s4)
    8000393e:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003942:	000a3783          	ld	a5,0(s4)
    80003946:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    8000394a:	000a3783          	ld	a5,0(s4)
    8000394e:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003952:	000a3783          	ld	a5,0(s4)
    80003956:	0127b823          	sd	s2,16(a5)
  return 0;
    8000395a:	4501                	li	a0,0
    8000395c:	6942                	ld	s2,16(sp)
    8000395e:	69a2                	ld	s3,8(sp)
    80003960:	a00d                	j	80003982 <pipealloc+0xb4>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003962:	6088                	ld	a0,0(s1)
    80003964:	c119                	beqz	a0,8000396a <pipealloc+0x9c>
    80003966:	6942                	ld	s2,16(sp)
    80003968:	a029                	j	80003972 <pipealloc+0xa4>
    8000396a:	6942                	ld	s2,16(sp)
    8000396c:	a029                	j	80003976 <pipealloc+0xa8>
    8000396e:	6088                	ld	a0,0(s1)
    80003970:	c901                	beqz	a0,80003980 <pipealloc+0xb2>
    fileclose(*f0);
    80003972:	c4fff0ef          	jal	800035c0 <fileclose>
  if(*f1)
    80003976:	000a3503          	ld	a0,0(s4)
    8000397a:	c119                	beqz	a0,80003980 <pipealloc+0xb2>
    fileclose(*f1);
    8000397c:	c45ff0ef          	jal	800035c0 <fileclose>
  return -1;
    80003980:	557d                	li	a0,-1
}
    80003982:	70a2                	ld	ra,40(sp)
    80003984:	7402                	ld	s0,32(sp)
    80003986:	64e2                	ld	s1,24(sp)
    80003988:	6a02                	ld	s4,0(sp)
    8000398a:	6145                	addi	sp,sp,48
    8000398c:	8082                	ret

000000008000398e <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    8000398e:	1101                	addi	sp,sp,-32
    80003990:	ec06                	sd	ra,24(sp)
    80003992:	e822                	sd	s0,16(sp)
    80003994:	e426                	sd	s1,8(sp)
    80003996:	e04a                	sd	s2,0(sp)
    80003998:	1000                	addi	s0,sp,32
    8000399a:	84aa                	mv	s1,a0
    8000399c:	892e                	mv	s2,a1
  acquire(&pi->lock);
    8000399e:	3fc020ef          	jal	80005d9a <acquire>
  if(writable){
    800039a2:	02090763          	beqz	s2,800039d0 <pipeclose+0x42>
    pi->writeopen = 0;
    800039a6:	2204a623          	sw	zero,556(s1)
    wakeup(&pi->nread);
    800039aa:	22048513          	addi	a0,s1,544
    800039ae:	b09fd0ef          	jal	800014b6 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    800039b2:	2284a783          	lw	a5,552(s1)
    800039b6:	e781                	bnez	a5,800039be <pipeclose+0x30>
    800039b8:	22c4a783          	lw	a5,556(s1)
    800039bc:	c38d                	beqz	a5,800039de <pipeclose+0x50>
#ifdef LAB_LOCK
    freelock(&pi->lock);
#endif    
    kfree((char*)pi);
  } else
    release(&pi->lock);
    800039be:	8526                	mv	a0,s1
    800039c0:	516020ef          	jal	80005ed6 <release>
}
    800039c4:	60e2                	ld	ra,24(sp)
    800039c6:	6442                	ld	s0,16(sp)
    800039c8:	64a2                	ld	s1,8(sp)
    800039ca:	6902                	ld	s2,0(sp)
    800039cc:	6105                	addi	sp,sp,32
    800039ce:	8082                	ret
    pi->readopen = 0;
    800039d0:	2204a423          	sw	zero,552(s1)
    wakeup(&pi->nwrite);
    800039d4:	22448513          	addi	a0,s1,548
    800039d8:	adffd0ef          	jal	800014b6 <wakeup>
    800039dc:	bfd9                	j	800039b2 <pipeclose+0x24>
    release(&pi->lock);
    800039de:	8526                	mv	a0,s1
    800039e0:	4f6020ef          	jal	80005ed6 <release>
    freelock(&pi->lock);
    800039e4:	8526                	mv	a0,s1
    800039e6:	52c020ef          	jal	80005f12 <freelock>
    kfree((char*)pi);
    800039ea:	8526                	mv	a0,s1
    800039ec:	e30fc0ef          	jal	8000001c <kfree>
    800039f0:	bfd1                	j	800039c4 <pipeclose+0x36>

00000000800039f2 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    800039f2:	7159                	addi	sp,sp,-112
    800039f4:	f486                	sd	ra,104(sp)
    800039f6:	f0a2                	sd	s0,96(sp)
    800039f8:	eca6                	sd	s1,88(sp)
    800039fa:	e8ca                	sd	s2,80(sp)
    800039fc:	e4ce                	sd	s3,72(sp)
    800039fe:	e0d2                	sd	s4,64(sp)
    80003a00:	fc56                	sd	s5,56(sp)
    80003a02:	1880                	addi	s0,sp,112
    80003a04:	84aa                	mv	s1,a0
    80003a06:	8aae                	mv	s5,a1
    80003a08:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80003a0a:	c2afd0ef          	jal	80000e34 <myproc>
    80003a0e:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80003a10:	8526                	mv	a0,s1
    80003a12:	388020ef          	jal	80005d9a <acquire>
  while(i < n){
    80003a16:	0d405263          	blez	s4,80003ada <pipewrite+0xe8>
    80003a1a:	f85a                	sd	s6,48(sp)
    80003a1c:	f45e                	sd	s7,40(sp)
    80003a1e:	f062                	sd	s8,32(sp)
    80003a20:	ec66                	sd	s9,24(sp)
    80003a22:	e86a                	sd	s10,16(sp)
  int i = 0;
    80003a24:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003a26:	f9f40c13          	addi	s8,s0,-97
    80003a2a:	4b85                	li	s7,1
    80003a2c:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80003a2e:	22048d13          	addi	s10,s1,544
      sleep(&pi->nwrite, &pi->lock);
    80003a32:	22448c93          	addi	s9,s1,548
    80003a36:	a82d                	j	80003a70 <pipewrite+0x7e>
      release(&pi->lock);
    80003a38:	8526                	mv	a0,s1
    80003a3a:	49c020ef          	jal	80005ed6 <release>
      return -1;
    80003a3e:	597d                	li	s2,-1
    80003a40:	7b42                	ld	s6,48(sp)
    80003a42:	7ba2                	ld	s7,40(sp)
    80003a44:	7c02                	ld	s8,32(sp)
    80003a46:	6ce2                	ld	s9,24(sp)
    80003a48:	6d42                	ld	s10,16(sp)
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80003a4a:	854a                	mv	a0,s2
    80003a4c:	70a6                	ld	ra,104(sp)
    80003a4e:	7406                	ld	s0,96(sp)
    80003a50:	64e6                	ld	s1,88(sp)
    80003a52:	6946                	ld	s2,80(sp)
    80003a54:	69a6                	ld	s3,72(sp)
    80003a56:	6a06                	ld	s4,64(sp)
    80003a58:	7ae2                	ld	s5,56(sp)
    80003a5a:	6165                	addi	sp,sp,112
    80003a5c:	8082                	ret
      wakeup(&pi->nread);
    80003a5e:	856a                	mv	a0,s10
    80003a60:	a57fd0ef          	jal	800014b6 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80003a64:	85a6                	mv	a1,s1
    80003a66:	8566                	mv	a0,s9
    80003a68:	a03fd0ef          	jal	8000146a <sleep>
  while(i < n){
    80003a6c:	05495a63          	bge	s2,s4,80003ac0 <pipewrite+0xce>
    if(pi->readopen == 0 || killed(pr)){
    80003a70:	2284a783          	lw	a5,552(s1)
    80003a74:	d3f1                	beqz	a5,80003a38 <pipewrite+0x46>
    80003a76:	854e                	mv	a0,s3
    80003a78:	c2ffd0ef          	jal	800016a6 <killed>
    80003a7c:	fd55                	bnez	a0,80003a38 <pipewrite+0x46>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80003a7e:	2204a783          	lw	a5,544(s1)
    80003a82:	2244a703          	lw	a4,548(s1)
    80003a86:	2007879b          	addiw	a5,a5,512
    80003a8a:	fcf70ae3          	beq	a4,a5,80003a5e <pipewrite+0x6c>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003a8e:	86de                	mv	a3,s7
    80003a90:	01590633          	add	a2,s2,s5
    80003a94:	85e2                	mv	a1,s8
    80003a96:	0589b503          	ld	a0,88(s3)
    80003a9a:	996fd0ef          	jal	80000c30 <copyin>
    80003a9e:	05650063          	beq	a0,s6,80003ade <pipewrite+0xec>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80003aa2:	2244a783          	lw	a5,548(s1)
    80003aa6:	0017871b          	addiw	a4,a5,1
    80003aaa:	22e4a223          	sw	a4,548(s1)
    80003aae:	1ff7f793          	andi	a5,a5,511
    80003ab2:	97a6                	add	a5,a5,s1
    80003ab4:	f9f44703          	lbu	a4,-97(s0)
    80003ab8:	02e78023          	sb	a4,32(a5)
      i++;
    80003abc:	2905                	addiw	s2,s2,1
    80003abe:	b77d                	j	80003a6c <pipewrite+0x7a>
    80003ac0:	7b42                	ld	s6,48(sp)
    80003ac2:	7ba2                	ld	s7,40(sp)
    80003ac4:	7c02                	ld	s8,32(sp)
    80003ac6:	6ce2                	ld	s9,24(sp)
    80003ac8:	6d42                	ld	s10,16(sp)
  wakeup(&pi->nread);
    80003aca:	22048513          	addi	a0,s1,544
    80003ace:	9e9fd0ef          	jal	800014b6 <wakeup>
  release(&pi->lock);
    80003ad2:	8526                	mv	a0,s1
    80003ad4:	402020ef          	jal	80005ed6 <release>
  return i;
    80003ad8:	bf8d                	j	80003a4a <pipewrite+0x58>
  int i = 0;
    80003ada:	4901                	li	s2,0
    80003adc:	b7fd                	j	80003aca <pipewrite+0xd8>
    80003ade:	7b42                	ld	s6,48(sp)
    80003ae0:	7ba2                	ld	s7,40(sp)
    80003ae2:	7c02                	ld	s8,32(sp)
    80003ae4:	6ce2                	ld	s9,24(sp)
    80003ae6:	6d42                	ld	s10,16(sp)
    80003ae8:	b7cd                	j	80003aca <pipewrite+0xd8>

0000000080003aea <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80003aea:	711d                	addi	sp,sp,-96
    80003aec:	ec86                	sd	ra,88(sp)
    80003aee:	e8a2                	sd	s0,80(sp)
    80003af0:	e4a6                	sd	s1,72(sp)
    80003af2:	e0ca                	sd	s2,64(sp)
    80003af4:	fc4e                	sd	s3,56(sp)
    80003af6:	f852                	sd	s4,48(sp)
    80003af8:	f456                	sd	s5,40(sp)
    80003afa:	1080                	addi	s0,sp,96
    80003afc:	84aa                	mv	s1,a0
    80003afe:	892e                	mv	s2,a1
    80003b00:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80003b02:	b32fd0ef          	jal	80000e34 <myproc>
    80003b06:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80003b08:	8526                	mv	a0,s1
    80003b0a:	290020ef          	jal	80005d9a <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003b0e:	2204a703          	lw	a4,544(s1)
    80003b12:	2244a783          	lw	a5,548(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003b16:	22048993          	addi	s3,s1,544
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003b1a:	02f71363          	bne	a4,a5,80003b40 <piperead+0x56>
    80003b1e:	22c4a783          	lw	a5,556(s1)
    80003b22:	cf99                	beqz	a5,80003b40 <piperead+0x56>
    if(killed(pr)){
    80003b24:	8552                	mv	a0,s4
    80003b26:	b81fd0ef          	jal	800016a6 <killed>
    80003b2a:	e53d                	bnez	a0,80003b98 <piperead+0xae>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003b2c:	85a6                	mv	a1,s1
    80003b2e:	854e                	mv	a0,s3
    80003b30:	93bfd0ef          	jal	8000146a <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003b34:	2204a703          	lw	a4,544(s1)
    80003b38:	2244a783          	lw	a5,548(s1)
    80003b3c:	fef701e3          	beq	a4,a5,80003b1e <piperead+0x34>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003b40:	07505163          	blez	s5,80003ba2 <piperead+0xb8>
    80003b44:	f05a                	sd	s6,32(sp)
    80003b46:	ec5e                	sd	s7,24(sp)
    80003b48:	e862                	sd	s8,16(sp)
    80003b4a:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80003b4c:	faf40c13          	addi	s8,s0,-81
    80003b50:	4b85                	li	s7,1
    80003b52:	5b7d                	li	s6,-1
    if(pi->nread == pi->nwrite)
    80003b54:	2204a783          	lw	a5,544(s1)
    80003b58:	2244a703          	lw	a4,548(s1)
    80003b5c:	04f70563          	beq	a4,a5,80003ba6 <piperead+0xbc>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80003b60:	0017871b          	addiw	a4,a5,1
    80003b64:	22e4a023          	sw	a4,544(s1)
    80003b68:	1ff7f793          	andi	a5,a5,511
    80003b6c:	97a6                	add	a5,a5,s1
    80003b6e:	0207c783          	lbu	a5,32(a5)
    80003b72:	faf407a3          	sb	a5,-81(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80003b76:	86de                	mv	a3,s7
    80003b78:	8662                	mv	a2,s8
    80003b7a:	85ca                	mv	a1,s2
    80003b7c:	058a3503          	ld	a0,88(s4)
    80003b80:	ff9fc0ef          	jal	80000b78 <copyout>
    80003b84:	05650563          	beq	a0,s6,80003bce <piperead+0xe4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003b88:	2985                	addiw	s3,s3,1
    80003b8a:	0905                	addi	s2,s2,1
    80003b8c:	fd3a94e3          	bne	s5,s3,80003b54 <piperead+0x6a>
    80003b90:	7b02                	ld	s6,32(sp)
    80003b92:	6be2                	ld	s7,24(sp)
    80003b94:	6c42                	ld	s8,16(sp)
    80003b96:	a819                	j	80003bac <piperead+0xc2>
      release(&pi->lock);
    80003b98:	8526                	mv	a0,s1
    80003b9a:	33c020ef          	jal	80005ed6 <release>
      return -1;
    80003b9e:	59fd                	li	s3,-1
    80003ba0:	a829                	j	80003bba <piperead+0xd0>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003ba2:	4981                	li	s3,0
    80003ba4:	a021                	j	80003bac <piperead+0xc2>
    80003ba6:	7b02                	ld	s6,32(sp)
    80003ba8:	6be2                	ld	s7,24(sp)
    80003baa:	6c42                	ld	s8,16(sp)
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80003bac:	22448513          	addi	a0,s1,548
    80003bb0:	907fd0ef          	jal	800014b6 <wakeup>
  release(&pi->lock);
    80003bb4:	8526                	mv	a0,s1
    80003bb6:	320020ef          	jal	80005ed6 <release>
  return i;
}
    80003bba:	854e                	mv	a0,s3
    80003bbc:	60e6                	ld	ra,88(sp)
    80003bbe:	6446                	ld	s0,80(sp)
    80003bc0:	64a6                	ld	s1,72(sp)
    80003bc2:	6906                	ld	s2,64(sp)
    80003bc4:	79e2                	ld	s3,56(sp)
    80003bc6:	7a42                	ld	s4,48(sp)
    80003bc8:	7aa2                	ld	s5,40(sp)
    80003bca:	6125                	addi	sp,sp,96
    80003bcc:	8082                	ret
    80003bce:	7b02                	ld	s6,32(sp)
    80003bd0:	6be2                	ld	s7,24(sp)
    80003bd2:	6c42                	ld	s8,16(sp)
    80003bd4:	bfe1                	j	80003bac <piperead+0xc2>

0000000080003bd6 <flags2perm>:

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

// map ELF permissions to PTE permission bits.
int flags2perm(int flags)
{
    80003bd6:	1141                	addi	sp,sp,-16
    80003bd8:	e406                	sd	ra,8(sp)
    80003bda:	e022                	sd	s0,0(sp)
    80003bdc:	0800                	addi	s0,sp,16
    80003bde:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    80003be0:	0035151b          	slliw	a0,a0,0x3
    80003be4:	8921                	andi	a0,a0,8
      perm = PTE_X;
    if(flags & 0x2)
    80003be6:	8b89                	andi	a5,a5,2
    80003be8:	c399                	beqz	a5,80003bee <flags2perm+0x18>
      perm |= PTE_W;
    80003bea:	00456513          	ori	a0,a0,4
    return perm;
}
    80003bee:	60a2                	ld	ra,8(sp)
    80003bf0:	6402                	ld	s0,0(sp)
    80003bf2:	0141                	addi	sp,sp,16
    80003bf4:	8082                	ret

0000000080003bf6 <kexec>:
//
// the implementation of the exec() system call
//
int
kexec(char *path, char **argv)
{
    80003bf6:	df010113          	addi	sp,sp,-528
    80003bfa:	20113423          	sd	ra,520(sp)
    80003bfe:	20813023          	sd	s0,512(sp)
    80003c02:	ffa6                	sd	s1,504(sp)
    80003c04:	fbca                	sd	s2,496(sp)
    80003c06:	0c00                	addi	s0,sp,528
    80003c08:	892a                	mv	s2,a0
    80003c0a:	e0a43023          	sd	a0,-512(s0)
    80003c0e:	deb43c23          	sd	a1,-520(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80003c12:	a22fd0ef          	jal	80000e34 <myproc>
    80003c16:	84aa                	mv	s1,a0

  begin_op();
    80003c18:	d88ff0ef          	jal	800031a0 <begin_op>

  // Open the executable file.
  if((ip = namei(path)) == 0){
    80003c1c:	854a                	mv	a0,s2
    80003c1e:	ba4ff0ef          	jal	80002fc2 <namei>
    80003c22:	c931                	beqz	a0,80003c76 <kexec+0x80>
    80003c24:	f3d2                	sd	s4,480(sp)
    80003c26:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80003c28:	b57fe0ef          	jal	8000277e <ilock>

  // Read the ELF header.
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80003c2c:	04000713          	li	a4,64
    80003c30:	4681                	li	a3,0
    80003c32:	e5040613          	addi	a2,s0,-432
    80003c36:	4581                	li	a1,0
    80003c38:	8552                	mv	a0,s4
    80003c3a:	ee3fe0ef          	jal	80002b1c <readi>
    80003c3e:	04000793          	li	a5,64
    80003c42:	00f51a63          	bne	a0,a5,80003c56 <kexec+0x60>
    goto bad;

  // Is this really an ELF file?
  if(elf.magic != ELF_MAGIC)
    80003c46:	e5042703          	lw	a4,-432(s0)
    80003c4a:	464c47b7          	lui	a5,0x464c4
    80003c4e:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80003c52:	02f70563          	beq	a4,a5,80003c7c <kexec+0x86>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80003c56:	8552                	mv	a0,s4
    80003c58:	d3ffe0ef          	jal	80002996 <iunlockput>
    end_op();
    80003c5c:	db4ff0ef          	jal	80003210 <end_op>
    80003c60:	7a1e                	ld	s4,480(sp)
    return -1;
    80003c62:	557d                	li	a0,-1
  }
  return -1;
}
    80003c64:	20813083          	ld	ra,520(sp)
    80003c68:	20013403          	ld	s0,512(sp)
    80003c6c:	74fe                	ld	s1,504(sp)
    80003c6e:	795e                	ld	s2,496(sp)
    80003c70:	21010113          	addi	sp,sp,528
    80003c74:	8082                	ret
    end_op();
    80003c76:	d9aff0ef          	jal	80003210 <end_op>
    return -1;
    80003c7a:	b7e5                	j	80003c62 <kexec+0x6c>
    80003c7c:	ebda                	sd	s6,464(sp)
  if((pagetable = proc_pagetable(p)) == 0)
    80003c7e:	8526                	mv	a0,s1
    80003c80:	abefd0ef          	jal	80000f3e <proc_pagetable>
    80003c84:	8b2a                	mv	s6,a0
    80003c86:	26050063          	beqz	a0,80003ee6 <kexec+0x2f0>
    80003c8a:	f7ce                	sd	s3,488(sp)
    80003c8c:	efd6                	sd	s5,472(sp)
    80003c8e:	e7de                	sd	s7,456(sp)
    80003c90:	e3e2                	sd	s8,448(sp)
    80003c92:	ff66                	sd	s9,440(sp)
    80003c94:	fb6a                	sd	s10,432(sp)
    80003c96:	f76e                	sd	s11,424(sp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003c98:	e8845783          	lhu	a5,-376(s0)
    80003c9c:	cff9                	beqz	a5,80003d7a <kexec+0x184>
    80003c9e:	e7042683          	lw	a3,-400(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80003ca2:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003ca4:	4d01                	li	s10,0
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80003ca6:	03800d93          	li	s11,56

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    80003caa:	6c85                	lui	s9,0x1
    80003cac:	6a85                	lui	s5,0x1
    80003cae:	a085                	j	80003d0e <kexec+0x118>
      panic("loadseg: address should exist");
    80003cb0:	00005517          	auipc	a0,0x5
    80003cb4:	89050513          	addi	a0,a0,-1904 # 80008540 <etext+0x540>
    80003cb8:	5a7010ef          	jal	80005a5e <panic>
    if(sz - i < PGSIZE)
    80003cbc:	2901                	sext.w	s2,s2
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80003cbe:	874a                	mv	a4,s2
    80003cc0:	009b86bb          	addw	a3,s7,s1
    80003cc4:	4581                	li	a1,0
    80003cc6:	8552                	mv	a0,s4
    80003cc8:	e55fe0ef          	jal	80002b1c <readi>
    80003ccc:	22a91163          	bne	s2,a0,80003eee <kexec+0x2f8>
  for(i = 0; i < sz; i += PGSIZE){
    80003cd0:	009a84bb          	addw	s1,s5,s1
    80003cd4:	0334f263          	bgeu	s1,s3,80003cf8 <kexec+0x102>
    pa = walkaddr(pagetable, va + i);
    80003cd8:	02049593          	slli	a1,s1,0x20
    80003cdc:	9181                	srli	a1,a1,0x20
    80003cde:	95e2                	add	a1,a1,s8
    80003ce0:	855a                	mv	a0,s6
    80003ce2:	87ffc0ef          	jal	80000560 <walkaddr>
    80003ce6:	862a                	mv	a2,a0
    if(pa == 0)
    80003ce8:	d561                	beqz	a0,80003cb0 <kexec+0xba>
    if(sz - i < PGSIZE)
    80003cea:	409987bb          	subw	a5,s3,s1
    80003cee:	893e                	mv	s2,a5
    80003cf0:	fcfcf6e3          	bgeu	s9,a5,80003cbc <kexec+0xc6>
    80003cf4:	8956                	mv	s2,s5
    80003cf6:	b7d9                	j	80003cbc <kexec+0xc6>
    sz = sz1;
    80003cf8:	df043903          	ld	s2,-528(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003cfc:	2d05                	addiw	s10,s10,1
    80003cfe:	e0843783          	ld	a5,-504(s0)
    80003d02:	0387869b          	addiw	a3,a5,56
    80003d06:	e8845783          	lhu	a5,-376(s0)
    80003d0a:	06fd5963          	bge	s10,a5,80003d7c <kexec+0x186>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80003d0e:	e0d43423          	sd	a3,-504(s0)
    80003d12:	876e                	mv	a4,s11
    80003d14:	e1840613          	addi	a2,s0,-488
    80003d18:	4581                	li	a1,0
    80003d1a:	8552                	mv	a0,s4
    80003d1c:	e01fe0ef          	jal	80002b1c <readi>
    80003d20:	1db51563          	bne	a0,s11,80003eea <kexec+0x2f4>
    if(ph.type != ELF_PROG_LOAD)
    80003d24:	e1842783          	lw	a5,-488(s0)
    80003d28:	4705                	li	a4,1
    80003d2a:	fce799e3          	bne	a5,a4,80003cfc <kexec+0x106>
    if(ph.memsz < ph.filesz)
    80003d2e:	e4043483          	ld	s1,-448(s0)
    80003d32:	e3843783          	ld	a5,-456(s0)
    80003d36:	1af4ea63          	bltu	s1,a5,80003eea <kexec+0x2f4>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80003d3a:	e2843783          	ld	a5,-472(s0)
    80003d3e:	94be                	add	s1,s1,a5
    80003d40:	1af4e563          	bltu	s1,a5,80003eea <kexec+0x2f4>
    if(ph.vaddr % PGSIZE != 0)
    80003d44:	17d2                	slli	a5,a5,0x34
    80003d46:	1a079263          	bnez	a5,80003eea <kexec+0x2f4>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80003d4a:	e1c42503          	lw	a0,-484(s0)
    80003d4e:	e89ff0ef          	jal	80003bd6 <flags2perm>
    80003d52:	86aa                	mv	a3,a0
    80003d54:	8626                	mv	a2,s1
    80003d56:	85ca                	mv	a1,s2
    80003d58:	855a                	mv	a0,s6
    80003d5a:	ad5fc0ef          	jal	8000082e <uvmalloc>
    80003d5e:	dea43823          	sd	a0,-528(s0)
    80003d62:	18050463          	beqz	a0,80003eea <kexec+0x2f4>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80003d66:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80003d6a:	f80987e3          	beqz	s3,80003cf8 <kexec+0x102>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80003d6e:	e2843c03          	ld	s8,-472(s0)
    80003d72:	e2042b83          	lw	s7,-480(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80003d76:	4481                	li	s1,0
    80003d78:	b785                	j	80003cd8 <kexec+0xe2>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80003d7a:	4901                	li	s2,0
  iunlockput(ip);
    80003d7c:	8552                	mv	a0,s4
    80003d7e:	c19fe0ef          	jal	80002996 <iunlockput>
  end_op();
    80003d82:	c8eff0ef          	jal	80003210 <end_op>
  p = myproc();
    80003d86:	8aefd0ef          	jal	80000e34 <myproc>
    80003d8a:	89aa                	mv	s3,a0
  uint64 oldsz = p->sz;
    80003d8c:	05053a83          	ld	s5,80(a0)
  sz = PGROUNDUP(sz);
    80003d90:	6485                	lui	s1,0x1
    80003d92:	14fd                	addi	s1,s1,-1 # fff <_entry-0x7ffff001>
    80003d94:	94ca                	add	s1,s1,s2
    80003d96:	77fd                	lui	a5,0xfffff
    80003d98:	8cfd                	and	s1,s1,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + (USERSTACK+1)*PGSIZE, PTE_W)) == 0)
    80003d9a:	4691                	li	a3,4
    80003d9c:	6609                	lui	a2,0x2
    80003d9e:	9626                	add	a2,a2,s1
    80003da0:	85a6                	mv	a1,s1
    80003da2:	855a                	mv	a0,s6
    80003da4:	a8bfc0ef          	jal	8000082e <uvmalloc>
    80003da8:	8a2a                	mv	s4,a0
    80003daa:	ed19                	bnez	a0,80003dc8 <kexec+0x1d2>
    proc_freepagetable(pagetable, sz);
    80003dac:	85a6                	mv	a1,s1
    80003dae:	855a                	mv	a0,s6
    80003db0:	a10fd0ef          	jal	80000fc0 <proc_freepagetable>
  if(ip){
    80003db4:	79be                	ld	s3,488(sp)
    80003db6:	7a1e                	ld	s4,480(sp)
    80003db8:	6afe                	ld	s5,472(sp)
    80003dba:	6b5e                	ld	s6,464(sp)
    80003dbc:	6bbe                	ld	s7,456(sp)
    80003dbe:	6c1e                	ld	s8,448(sp)
    80003dc0:	7cfa                	ld	s9,440(sp)
    80003dc2:	7d5a                	ld	s10,432(sp)
    80003dc4:	7dba                	ld	s11,424(sp)
    80003dc6:	bd71                	j	80003c62 <kexec+0x6c>
  uvmclear(pagetable, sz-(USERSTACK+1)*PGSIZE);
    80003dc8:	75f9                	lui	a1,0xffffe
    80003dca:	95aa                	add	a1,a1,a0
    80003dcc:	855a                	mv	a0,s6
    80003dce:	c29fc0ef          	jal	800009f6 <uvmclear>
  stackbase = sp - USERSTACK*PGSIZE;
    80003dd2:	7c7d                	lui	s8,0xfffff
    80003dd4:	9c52                	add	s8,s8,s4
  for(argc = 0; argv[argc]; argc++) {
    80003dd6:	df843783          	ld	a5,-520(s0)
    80003dda:	6388                	ld	a0,0(a5)
  sp = sz;
    80003ddc:	8952                	mv	s2,s4
  for(argc = 0; argv[argc]; argc++) {
    80003dde:	4481                	li	s1,0
    ustack[argc] = sp;
    80003de0:	e9040c93          	addi	s9,s0,-368
    if(argc >= MAXARG)
    80003de4:	02000d13          	li	s10,32
  for(argc = 0; argv[argc]; argc++) {
    80003de8:	cd21                	beqz	a0,80003e40 <kexec+0x24a>
    sp -= strlen(argv[argc]) + 1;
    80003dea:	dccfc0ef          	jal	800003b6 <strlen>
    80003dee:	0015079b          	addiw	a5,a0,1
    80003df2:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80003df6:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    80003dfa:	05896163          	bltu	s2,s8,80003e3c <kexec+0x246>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80003dfe:	df843d83          	ld	s11,-520(s0)
    80003e02:	000dbb83          	ld	s7,0(s11)
    80003e06:	855e                	mv	a0,s7
    80003e08:	daefc0ef          	jal	800003b6 <strlen>
    80003e0c:	0015069b          	addiw	a3,a0,1
    80003e10:	865e                	mv	a2,s7
    80003e12:	85ca                	mv	a1,s2
    80003e14:	855a                	mv	a0,s6
    80003e16:	d63fc0ef          	jal	80000b78 <copyout>
    80003e1a:	02054163          	bltz	a0,80003e3c <kexec+0x246>
    ustack[argc] = sp;
    80003e1e:	00349793          	slli	a5,s1,0x3
    80003e22:	97e6                	add	a5,a5,s9
    80003e24:	0127b023          	sd	s2,0(a5) # fffffffffffff000 <end+0xffffffff7ffda6c0>
  for(argc = 0; argv[argc]; argc++) {
    80003e28:	0485                	addi	s1,s1,1
    80003e2a:	008d8793          	addi	a5,s11,8
    80003e2e:	def43c23          	sd	a5,-520(s0)
    80003e32:	008db503          	ld	a0,8(s11)
    80003e36:	c509                	beqz	a0,80003e40 <kexec+0x24a>
    if(argc >= MAXARG)
    80003e38:	fba499e3          	bne	s1,s10,80003dea <kexec+0x1f4>
  sz = sz1;
    80003e3c:	84d2                	mv	s1,s4
    80003e3e:	b7bd                	j	80003dac <kexec+0x1b6>
  ustack[argc] = 0;
    80003e40:	00349793          	slli	a5,s1,0x3
    80003e44:	f9040713          	addi	a4,s0,-112
    80003e48:	97ba                	add	a5,a5,a4
    80003e4a:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    80003e4e:	00148693          	addi	a3,s1,1
    80003e52:	068e                	slli	a3,a3,0x3
    80003e54:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80003e58:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80003e5c:	ff8960e3          	bltu	s2,s8,80003e3c <kexec+0x246>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80003e60:	e9040613          	addi	a2,s0,-368
    80003e64:	85ca                	mv	a1,s2
    80003e66:	855a                	mv	a0,s6
    80003e68:	d11fc0ef          	jal	80000b78 <copyout>
    80003e6c:	fc0548e3          	bltz	a0,80003e3c <kexec+0x246>
  p->trapframe->a1 = sp;
    80003e70:	0609b783          	ld	a5,96(s3)
    80003e74:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80003e78:	e0043783          	ld	a5,-512(s0)
    80003e7c:	0007c703          	lbu	a4,0(a5)
    80003e80:	cf11                	beqz	a4,80003e9c <kexec+0x2a6>
    80003e82:	0785                	addi	a5,a5,1
    if(*s == '/')
    80003e84:	02f00693          	li	a3,47
    80003e88:	a029                	j	80003e92 <kexec+0x29c>
  for(last=s=path; *s; s++)
    80003e8a:	0785                	addi	a5,a5,1
    80003e8c:	fff7c703          	lbu	a4,-1(a5)
    80003e90:	c711                	beqz	a4,80003e9c <kexec+0x2a6>
    if(*s == '/')
    80003e92:	fed71ce3          	bne	a4,a3,80003e8a <kexec+0x294>
      last = s+1;
    80003e96:	e0f43023          	sd	a5,-512(s0)
    80003e9a:	bfc5                	j	80003e8a <kexec+0x294>
  safestrcpy(p->name, last, sizeof(p->name));
    80003e9c:	4641                	li	a2,16
    80003e9e:	e0043583          	ld	a1,-512(s0)
    80003ea2:	16098513          	addi	a0,s3,352
    80003ea6:	cdafc0ef          	jal	80000380 <safestrcpy>
  oldpagetable = p->pagetable;
    80003eaa:	0589b503          	ld	a0,88(s3)
  p->pagetable = pagetable;
    80003eae:	0569bc23          	sd	s6,88(s3)
  p->sz = sz;
    80003eb2:	0549b823          	sd	s4,80(s3)
  p->trapframe->epc = elf.entry;  // initial program counter = ulib.c:start()
    80003eb6:	0609b783          	ld	a5,96(s3)
    80003eba:	e6843703          	ld	a4,-408(s0)
    80003ebe:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80003ec0:	0609b783          	ld	a5,96(s3)
    80003ec4:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80003ec8:	85d6                	mv	a1,s5
    80003eca:	8f6fd0ef          	jal	80000fc0 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80003ece:	0004851b          	sext.w	a0,s1
    80003ed2:	79be                	ld	s3,488(sp)
    80003ed4:	7a1e                	ld	s4,480(sp)
    80003ed6:	6afe                	ld	s5,472(sp)
    80003ed8:	6b5e                	ld	s6,464(sp)
    80003eda:	6bbe                	ld	s7,456(sp)
    80003edc:	6c1e                	ld	s8,448(sp)
    80003ede:	7cfa                	ld	s9,440(sp)
    80003ee0:	7d5a                	ld	s10,432(sp)
    80003ee2:	7dba                	ld	s11,424(sp)
    80003ee4:	b341                	j	80003c64 <kexec+0x6e>
    80003ee6:	6b5e                	ld	s6,464(sp)
    80003ee8:	b3bd                	j	80003c56 <kexec+0x60>
    return -1;
    80003eea:	df243823          	sd	s2,-528(s0)
    proc_freepagetable(pagetable, sz);
    80003eee:	df043583          	ld	a1,-528(s0)
    80003ef2:	855a                	mv	a0,s6
    80003ef4:	8ccfd0ef          	jal	80000fc0 <proc_freepagetable>
  if(ip){
    80003ef8:	79be                	ld	s3,488(sp)
    80003efa:	6afe                	ld	s5,472(sp)
    80003efc:	6b5e                	ld	s6,464(sp)
    80003efe:	6bbe                	ld	s7,456(sp)
    80003f00:	6c1e                	ld	s8,448(sp)
    80003f02:	7cfa                	ld	s9,440(sp)
    80003f04:	7d5a                	ld	s10,432(sp)
    80003f06:	7dba                	ld	s11,424(sp)
    80003f08:	b3b9                	j	80003c56 <kexec+0x60>

0000000080003f0a <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80003f0a:	7179                	addi	sp,sp,-48
    80003f0c:	f406                	sd	ra,40(sp)
    80003f0e:	f022                	sd	s0,32(sp)
    80003f10:	ec26                	sd	s1,24(sp)
    80003f12:	e84a                	sd	s2,16(sp)
    80003f14:	1800                	addi	s0,sp,48
    80003f16:	892e                	mv	s2,a1
    80003f18:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    80003f1a:	fdc40593          	addi	a1,s0,-36
    80003f1e:	e47fd0ef          	jal	80001d64 <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80003f22:	fdc42703          	lw	a4,-36(s0)
    80003f26:	47bd                	li	a5,15
    80003f28:	02e7e963          	bltu	a5,a4,80003f5a <argfd+0x50>
    80003f2c:	f09fc0ef          	jal	80000e34 <myproc>
    80003f30:	fdc42703          	lw	a4,-36(s0)
    80003f34:	01a70793          	addi	a5,a4,26
    80003f38:	078e                	slli	a5,a5,0x3
    80003f3a:	953e                	add	a0,a0,a5
    80003f3c:	651c                	ld	a5,8(a0)
    80003f3e:	cf91                	beqz	a5,80003f5a <argfd+0x50>
    return -1;
  if(pfd)
    80003f40:	00090463          	beqz	s2,80003f48 <argfd+0x3e>
    *pfd = fd;
    80003f44:	00e92023          	sw	a4,0(s2)
  if(pf)
    80003f48:	c091                	beqz	s1,80003f4c <argfd+0x42>
    *pf = f;
    80003f4a:	e09c                	sd	a5,0(s1)
  return 0;
    80003f4c:	4501                	li	a0,0
}
    80003f4e:	70a2                	ld	ra,40(sp)
    80003f50:	7402                	ld	s0,32(sp)
    80003f52:	64e2                	ld	s1,24(sp)
    80003f54:	6942                	ld	s2,16(sp)
    80003f56:	6145                	addi	sp,sp,48
    80003f58:	8082                	ret
    return -1;
    80003f5a:	557d                	li	a0,-1
    80003f5c:	bfcd                	j	80003f4e <argfd+0x44>

0000000080003f5e <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80003f5e:	1101                	addi	sp,sp,-32
    80003f60:	ec06                	sd	ra,24(sp)
    80003f62:	e822                	sd	s0,16(sp)
    80003f64:	e426                	sd	s1,8(sp)
    80003f66:	1000                	addi	s0,sp,32
    80003f68:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80003f6a:	ecbfc0ef          	jal	80000e34 <myproc>
    80003f6e:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80003f70:	0d850793          	addi	a5,a0,216
    80003f74:	4501                	li	a0,0
    80003f76:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80003f78:	6398                	ld	a4,0(a5)
    80003f7a:	cb19                	beqz	a4,80003f90 <fdalloc+0x32>
  for(fd = 0; fd < NOFILE; fd++){
    80003f7c:	2505                	addiw	a0,a0,1
    80003f7e:	07a1                	addi	a5,a5,8
    80003f80:	fed51ce3          	bne	a0,a3,80003f78 <fdalloc+0x1a>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80003f84:	557d                	li	a0,-1
}
    80003f86:	60e2                	ld	ra,24(sp)
    80003f88:	6442                	ld	s0,16(sp)
    80003f8a:	64a2                	ld	s1,8(sp)
    80003f8c:	6105                	addi	sp,sp,32
    80003f8e:	8082                	ret
      p->ofile[fd] = f;
    80003f90:	01a50793          	addi	a5,a0,26
    80003f94:	078e                	slli	a5,a5,0x3
    80003f96:	963e                	add	a2,a2,a5
    80003f98:	e604                	sd	s1,8(a2)
      return fd;
    80003f9a:	b7f5                	j	80003f86 <fdalloc+0x28>

0000000080003f9c <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80003f9c:	715d                	addi	sp,sp,-80
    80003f9e:	e486                	sd	ra,72(sp)
    80003fa0:	e0a2                	sd	s0,64(sp)
    80003fa2:	fc26                	sd	s1,56(sp)
    80003fa4:	f84a                	sd	s2,48(sp)
    80003fa6:	f44e                	sd	s3,40(sp)
    80003fa8:	f052                	sd	s4,32(sp)
    80003faa:	ec56                	sd	s5,24(sp)
    80003fac:	e85a                	sd	s6,16(sp)
    80003fae:	0880                	addi	s0,sp,80
    80003fb0:	892e                	mv	s2,a1
    80003fb2:	8a2e                	mv	s4,a1
    80003fb4:	8ab2                	mv	s5,a2
    80003fb6:	8b36                	mv	s6,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80003fb8:	fb040593          	addi	a1,s0,-80
    80003fbc:	820ff0ef          	jal	80002fdc <nameiparent>
    80003fc0:	84aa                	mv	s1,a0
    return 0;
    80003fc2:	89aa                	mv	s3,a0
  if((dp = nameiparent(path, name)) == 0)
    80003fc4:	cd05                	beqz	a0,80003ffc <create+0x60>

  ilock(dp);
    80003fc6:	fb8fe0ef          	jal	8000277e <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80003fca:	4601                	li	a2,0
    80003fcc:	fb040593          	addi	a1,s0,-80
    80003fd0:	8526                	mv	a0,s1
    80003fd2:	d55fe0ef          	jal	80002d26 <dirlookup>
    80003fd6:	89aa                	mv	s3,a0
    80003fd8:	c131                	beqz	a0,8000401c <create+0x80>
    iunlockput(dp);
    80003fda:	8526                	mv	a0,s1
    80003fdc:	9bbfe0ef          	jal	80002996 <iunlockput>
    ilock(ip);
    80003fe0:	854e                	mv	a0,s3
    80003fe2:	f9cfe0ef          	jal	8000277e <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80003fe6:	4789                	li	a5,2
    80003fe8:	02f91563          	bne	s2,a5,80004012 <create+0x76>
    80003fec:	04c9d783          	lhu	a5,76(s3)
    80003ff0:	37f9                	addiw	a5,a5,-2
    80003ff2:	17c2                	slli	a5,a5,0x30
    80003ff4:	93c1                	srli	a5,a5,0x30
    80003ff6:	4705                	li	a4,1
    80003ff8:	00f76d63          	bltu	a4,a5,80004012 <create+0x76>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80003ffc:	854e                	mv	a0,s3
    80003ffe:	60a6                	ld	ra,72(sp)
    80004000:	6406                	ld	s0,64(sp)
    80004002:	74e2                	ld	s1,56(sp)
    80004004:	7942                	ld	s2,48(sp)
    80004006:	79a2                	ld	s3,40(sp)
    80004008:	7a02                	ld	s4,32(sp)
    8000400a:	6ae2                	ld	s5,24(sp)
    8000400c:	6b42                	ld	s6,16(sp)
    8000400e:	6161                	addi	sp,sp,80
    80004010:	8082                	ret
    iunlockput(ip);
    80004012:	854e                	mv	a0,s3
    80004014:	983fe0ef          	jal	80002996 <iunlockput>
    return 0;
    80004018:	4981                	li	s3,0
    8000401a:	b7cd                	j	80003ffc <create+0x60>
  if((ip = ialloc(dp->dev, type)) == 0){
    8000401c:	85ca                	mv	a1,s2
    8000401e:	4088                	lw	a0,0(s1)
    80004020:	deefe0ef          	jal	8000260e <ialloc>
    80004024:	892a                	mv	s2,a0
    80004026:	cd15                	beqz	a0,80004062 <create+0xc6>
  ilock(ip);
    80004028:	f56fe0ef          	jal	8000277e <ilock>
  ip->major = major;
    8000402c:	05591723          	sh	s5,78(s2)
  ip->minor = minor;
    80004030:	05691823          	sh	s6,80(s2)
  ip->nlink = 1;
    80004034:	4785                	li	a5,1
    80004036:	04f91923          	sh	a5,82(s2)
  iupdate(ip);
    8000403a:	854a                	mv	a0,s2
    8000403c:	e8efe0ef          	jal	800026ca <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80004040:	4705                	li	a4,1
    80004042:	02ea0463          	beq	s4,a4,8000406a <create+0xce>
  if(dirlink(dp, name, ip->inum) < 0)
    80004046:	00492603          	lw	a2,4(s2)
    8000404a:	fb040593          	addi	a1,s0,-80
    8000404e:	8526                	mv	a0,s1
    80004050:	ec9fe0ef          	jal	80002f18 <dirlink>
    80004054:	06054263          	bltz	a0,800040b8 <create+0x11c>
  iunlockput(dp);
    80004058:	8526                	mv	a0,s1
    8000405a:	93dfe0ef          	jal	80002996 <iunlockput>
    return 0;
    8000405e:	89ca                	mv	s3,s2
    80004060:	bf71                	j	80003ffc <create+0x60>
    iunlockput(dp);
    80004062:	8526                	mv	a0,s1
    80004064:	933fe0ef          	jal	80002996 <iunlockput>
    return 0;
    80004068:	bfdd                	j	8000405e <create+0xc2>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    8000406a:	00492603          	lw	a2,4(s2)
    8000406e:	00004597          	auipc	a1,0x4
    80004072:	4f258593          	addi	a1,a1,1266 # 80008560 <etext+0x560>
    80004076:	854a                	mv	a0,s2
    80004078:	ea1fe0ef          	jal	80002f18 <dirlink>
    8000407c:	02054e63          	bltz	a0,800040b8 <create+0x11c>
    80004080:	40d0                	lw	a2,4(s1)
    80004082:	00004597          	auipc	a1,0x4
    80004086:	4e658593          	addi	a1,a1,1254 # 80008568 <etext+0x568>
    8000408a:	854a                	mv	a0,s2
    8000408c:	e8dfe0ef          	jal	80002f18 <dirlink>
    80004090:	02054463          	bltz	a0,800040b8 <create+0x11c>
  if(dirlink(dp, name, ip->inum) < 0)
    80004094:	00492603          	lw	a2,4(s2)
    80004098:	fb040593          	addi	a1,s0,-80
    8000409c:	8526                	mv	a0,s1
    8000409e:	e7bfe0ef          	jal	80002f18 <dirlink>
    800040a2:	00054b63          	bltz	a0,800040b8 <create+0x11c>
    dp->nlink++;  // for ".."
    800040a6:	0524d783          	lhu	a5,82(s1)
    800040aa:	2785                	addiw	a5,a5,1
    800040ac:	04f49923          	sh	a5,82(s1)
    iupdate(dp);
    800040b0:	8526                	mv	a0,s1
    800040b2:	e18fe0ef          	jal	800026ca <iupdate>
    800040b6:	b74d                	j	80004058 <create+0xbc>
  ip->nlink = 0;
    800040b8:	04091923          	sh	zero,82(s2)
  iupdate(ip);
    800040bc:	854a                	mv	a0,s2
    800040be:	e0cfe0ef          	jal	800026ca <iupdate>
  iunlockput(ip);
    800040c2:	854a                	mv	a0,s2
    800040c4:	8d3fe0ef          	jal	80002996 <iunlockput>
  iunlockput(dp);
    800040c8:	8526                	mv	a0,s1
    800040ca:	8cdfe0ef          	jal	80002996 <iunlockput>
  return 0;
    800040ce:	b73d                	j	80003ffc <create+0x60>

00000000800040d0 <sys_dup>:
{
    800040d0:	7179                	addi	sp,sp,-48
    800040d2:	f406                	sd	ra,40(sp)
    800040d4:	f022                	sd	s0,32(sp)
    800040d6:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    800040d8:	fd840613          	addi	a2,s0,-40
    800040dc:	4581                	li	a1,0
    800040de:	4501                	li	a0,0
    800040e0:	e2bff0ef          	jal	80003f0a <argfd>
    800040e4:	02054863          	bltz	a0,80004114 <sys_dup+0x44>
    800040e8:	ec26                	sd	s1,24(sp)
    800040ea:	e84a                	sd	s2,16(sp)
  if((fd=fdalloc(f)) < 0)
    800040ec:	fd843483          	ld	s1,-40(s0)
    800040f0:	8526                	mv	a0,s1
    800040f2:	e6dff0ef          	jal	80003f5e <fdalloc>
    800040f6:	892a                	mv	s2,a0
    800040f8:	00054c63          	bltz	a0,80004110 <sys_dup+0x40>
  filedup(f);
    800040fc:	8526                	mv	a0,s1
    800040fe:	c7cff0ef          	jal	8000357a <filedup>
  return fd;
    80004102:	854a                	mv	a0,s2
    80004104:	64e2                	ld	s1,24(sp)
    80004106:	6942                	ld	s2,16(sp)
}
    80004108:	70a2                	ld	ra,40(sp)
    8000410a:	7402                	ld	s0,32(sp)
    8000410c:	6145                	addi	sp,sp,48
    8000410e:	8082                	ret
    80004110:	64e2                	ld	s1,24(sp)
    80004112:	6942                	ld	s2,16(sp)
    return -1;
    80004114:	557d                	li	a0,-1
    80004116:	bfcd                	j	80004108 <sys_dup+0x38>

0000000080004118 <sys_read>:
{
    80004118:	7179                	addi	sp,sp,-48
    8000411a:	f406                	sd	ra,40(sp)
    8000411c:	f022                	sd	s0,32(sp)
    8000411e:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004120:	fd840593          	addi	a1,s0,-40
    80004124:	4505                	li	a0,1
    80004126:	c5bfd0ef          	jal	80001d80 <argaddr>
  argint(2, &n);
    8000412a:	fe440593          	addi	a1,s0,-28
    8000412e:	4509                	li	a0,2
    80004130:	c35fd0ef          	jal	80001d64 <argint>
  if(argfd(0, 0, &f) < 0)
    80004134:	fe840613          	addi	a2,s0,-24
    80004138:	4581                	li	a1,0
    8000413a:	4501                	li	a0,0
    8000413c:	dcfff0ef          	jal	80003f0a <argfd>
    80004140:	87aa                	mv	a5,a0
    return -1;
    80004142:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004144:	0007ca63          	bltz	a5,80004158 <sys_read+0x40>
  return fileread(f, p, n);
    80004148:	fe442603          	lw	a2,-28(s0)
    8000414c:	fd843583          	ld	a1,-40(s0)
    80004150:	fe843503          	ld	a0,-24(s0)
    80004154:	d90ff0ef          	jal	800036e4 <fileread>
}
    80004158:	70a2                	ld	ra,40(sp)
    8000415a:	7402                	ld	s0,32(sp)
    8000415c:	6145                	addi	sp,sp,48
    8000415e:	8082                	ret

0000000080004160 <sys_write>:
{
    80004160:	7179                	addi	sp,sp,-48
    80004162:	f406                	sd	ra,40(sp)
    80004164:	f022                	sd	s0,32(sp)
    80004166:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004168:	fd840593          	addi	a1,s0,-40
    8000416c:	4505                	li	a0,1
    8000416e:	c13fd0ef          	jal	80001d80 <argaddr>
  argint(2, &n);
    80004172:	fe440593          	addi	a1,s0,-28
    80004176:	4509                	li	a0,2
    80004178:	bedfd0ef          	jal	80001d64 <argint>
  if(argfd(0, 0, &f) < 0)
    8000417c:	fe840613          	addi	a2,s0,-24
    80004180:	4581                	li	a1,0
    80004182:	4501                	li	a0,0
    80004184:	d87ff0ef          	jal	80003f0a <argfd>
    80004188:	87aa                	mv	a5,a0
    return -1;
    8000418a:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    8000418c:	0007ca63          	bltz	a5,800041a0 <sys_write+0x40>
  return filewrite(f, p, n);
    80004190:	fe442603          	lw	a2,-28(s0)
    80004194:	fd843583          	ld	a1,-40(s0)
    80004198:	fe843503          	ld	a0,-24(s0)
    8000419c:	e02ff0ef          	jal	8000379e <filewrite>
}
    800041a0:	70a2                	ld	ra,40(sp)
    800041a2:	7402                	ld	s0,32(sp)
    800041a4:	6145                	addi	sp,sp,48
    800041a6:	8082                	ret

00000000800041a8 <sys_close>:
{
    800041a8:	1101                	addi	sp,sp,-32
    800041aa:	ec06                	sd	ra,24(sp)
    800041ac:	e822                	sd	s0,16(sp)
    800041ae:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800041b0:	fe040613          	addi	a2,s0,-32
    800041b4:	fec40593          	addi	a1,s0,-20
    800041b8:	4501                	li	a0,0
    800041ba:	d51ff0ef          	jal	80003f0a <argfd>
    return -1;
    800041be:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    800041c0:	02054063          	bltz	a0,800041e0 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
    800041c4:	c71fc0ef          	jal	80000e34 <myproc>
    800041c8:	fec42783          	lw	a5,-20(s0)
    800041cc:	07e9                	addi	a5,a5,26
    800041ce:	078e                	slli	a5,a5,0x3
    800041d0:	953e                	add	a0,a0,a5
    800041d2:	00053423          	sd	zero,8(a0)
  fileclose(f);
    800041d6:	fe043503          	ld	a0,-32(s0)
    800041da:	be6ff0ef          	jal	800035c0 <fileclose>
  return 0;
    800041de:	4781                	li	a5,0
}
    800041e0:	853e                	mv	a0,a5
    800041e2:	60e2                	ld	ra,24(sp)
    800041e4:	6442                	ld	s0,16(sp)
    800041e6:	6105                	addi	sp,sp,32
    800041e8:	8082                	ret

00000000800041ea <sys_fstat>:
{
    800041ea:	1101                	addi	sp,sp,-32
    800041ec:	ec06                	sd	ra,24(sp)
    800041ee:	e822                	sd	s0,16(sp)
    800041f0:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    800041f2:	fe040593          	addi	a1,s0,-32
    800041f6:	4505                	li	a0,1
    800041f8:	b89fd0ef          	jal	80001d80 <argaddr>
  if(argfd(0, 0, &f) < 0)
    800041fc:	fe840613          	addi	a2,s0,-24
    80004200:	4581                	li	a1,0
    80004202:	4501                	li	a0,0
    80004204:	d07ff0ef          	jal	80003f0a <argfd>
    80004208:	87aa                	mv	a5,a0
    return -1;
    8000420a:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    8000420c:	0007c863          	bltz	a5,8000421c <sys_fstat+0x32>
  return filestat(f, st);
    80004210:	fe043583          	ld	a1,-32(s0)
    80004214:	fe843503          	ld	a0,-24(s0)
    80004218:	c6aff0ef          	jal	80003682 <filestat>
}
    8000421c:	60e2                	ld	ra,24(sp)
    8000421e:	6442                	ld	s0,16(sp)
    80004220:	6105                	addi	sp,sp,32
    80004222:	8082                	ret

0000000080004224 <sys_link>:
{
    80004224:	7169                	addi	sp,sp,-304
    80004226:	f606                	sd	ra,296(sp)
    80004228:	f222                	sd	s0,288(sp)
    8000422a:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000422c:	08000613          	li	a2,128
    80004230:	ed040593          	addi	a1,s0,-304
    80004234:	4501                	li	a0,0
    80004236:	b67fd0ef          	jal	80001d9c <argstr>
    8000423a:	0c054a63          	bltz	a0,8000430e <sys_link+0xea>
    8000423e:	08000613          	li	a2,128
    80004242:	f5040593          	addi	a1,s0,-176
    80004246:	4505                	li	a0,1
    80004248:	b55fd0ef          	jal	80001d9c <argstr>
    8000424c:	0c054163          	bltz	a0,8000430e <sys_link+0xea>
    80004250:	ee26                	sd	s1,280(sp)
  begin_op();
    80004252:	f4ffe0ef          	jal	800031a0 <begin_op>
  if((ip = namei(old)) == 0){
    80004256:	ed040513          	addi	a0,s0,-304
    8000425a:	d69fe0ef          	jal	80002fc2 <namei>
    8000425e:	84aa                	mv	s1,a0
    80004260:	c53d                	beqz	a0,800042ce <sys_link+0xaa>
  ilock(ip);
    80004262:	d1cfe0ef          	jal	8000277e <ilock>
  if(ip->type == T_DIR){
    80004266:	04c49703          	lh	a4,76(s1)
    8000426a:	4785                	li	a5,1
    8000426c:	06f70563          	beq	a4,a5,800042d6 <sys_link+0xb2>
    80004270:	ea4a                	sd	s2,272(sp)
  ip->nlink++;
    80004272:	0524d783          	lhu	a5,82(s1)
    80004276:	2785                	addiw	a5,a5,1
    80004278:	04f49923          	sh	a5,82(s1)
  iupdate(ip);
    8000427c:	8526                	mv	a0,s1
    8000427e:	c4cfe0ef          	jal	800026ca <iupdate>
  iunlock(ip);
    80004282:	8526                	mv	a0,s1
    80004284:	daefe0ef          	jal	80002832 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004288:	fd040593          	addi	a1,s0,-48
    8000428c:	f5040513          	addi	a0,s0,-176
    80004290:	d4dfe0ef          	jal	80002fdc <nameiparent>
    80004294:	892a                	mv	s2,a0
    80004296:	c931                	beqz	a0,800042ea <sys_link+0xc6>
  ilock(dp);
    80004298:	ce6fe0ef          	jal	8000277e <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    8000429c:	854a                	mv	a0,s2
    8000429e:	00092703          	lw	a4,0(s2)
    800042a2:	409c                	lw	a5,0(s1)
    800042a4:	04f71063          	bne	a4,a5,800042e4 <sys_link+0xc0>
    800042a8:	40d0                	lw	a2,4(s1)
    800042aa:	fd040593          	addi	a1,s0,-48
    800042ae:	c6bfe0ef          	jal	80002f18 <dirlink>
    800042b2:	02054963          	bltz	a0,800042e4 <sys_link+0xc0>
  iunlockput(dp);
    800042b6:	854a                	mv	a0,s2
    800042b8:	edefe0ef          	jal	80002996 <iunlockput>
  iput(ip);
    800042bc:	8526                	mv	a0,s1
    800042be:	e4efe0ef          	jal	8000290c <iput>
  end_op();
    800042c2:	f4ffe0ef          	jal	80003210 <end_op>
  return 0;
    800042c6:	4501                	li	a0,0
    800042c8:	64f2                	ld	s1,280(sp)
    800042ca:	6952                	ld	s2,272(sp)
    800042cc:	a091                	j	80004310 <sys_link+0xec>
    end_op();
    800042ce:	f43fe0ef          	jal	80003210 <end_op>
    return -1;
    800042d2:	64f2                	ld	s1,280(sp)
    800042d4:	a82d                	j	8000430e <sys_link+0xea>
    iunlockput(ip);
    800042d6:	8526                	mv	a0,s1
    800042d8:	ebefe0ef          	jal	80002996 <iunlockput>
    end_op();
    800042dc:	f35fe0ef          	jal	80003210 <end_op>
    return -1;
    800042e0:	64f2                	ld	s1,280(sp)
    800042e2:	a035                	j	8000430e <sys_link+0xea>
    iunlockput(dp);
    800042e4:	854a                	mv	a0,s2
    800042e6:	eb0fe0ef          	jal	80002996 <iunlockput>
  ilock(ip);
    800042ea:	8526                	mv	a0,s1
    800042ec:	c92fe0ef          	jal	8000277e <ilock>
  ip->nlink--;
    800042f0:	0524d783          	lhu	a5,82(s1)
    800042f4:	37fd                	addiw	a5,a5,-1
    800042f6:	04f49923          	sh	a5,82(s1)
  iupdate(ip);
    800042fa:	8526                	mv	a0,s1
    800042fc:	bcefe0ef          	jal	800026ca <iupdate>
  iunlockput(ip);
    80004300:	8526                	mv	a0,s1
    80004302:	e94fe0ef          	jal	80002996 <iunlockput>
  end_op();
    80004306:	f0bfe0ef          	jal	80003210 <end_op>
  return -1;
    8000430a:	64f2                	ld	s1,280(sp)
    8000430c:	6952                	ld	s2,272(sp)
    return -1;
    8000430e:	557d                	li	a0,-1
}
    80004310:	70b2                	ld	ra,296(sp)
    80004312:	7412                	ld	s0,288(sp)
    80004314:	6155                	addi	sp,sp,304
    80004316:	8082                	ret

0000000080004318 <sys_unlink>:
{
    80004318:	7151                	addi	sp,sp,-240
    8000431a:	f586                	sd	ra,232(sp)
    8000431c:	f1a2                	sd	s0,224(sp)
    8000431e:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004320:	08000613          	li	a2,128
    80004324:	f3040593          	addi	a1,s0,-208
    80004328:	4501                	li	a0,0
    8000432a:	a73fd0ef          	jal	80001d9c <argstr>
    8000432e:	14054763          	bltz	a0,8000447c <sys_unlink+0x164>
    80004332:	eda6                	sd	s1,216(sp)
  begin_op();
    80004334:	e6dfe0ef          	jal	800031a0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004338:	fb040593          	addi	a1,s0,-80
    8000433c:	f3040513          	addi	a0,s0,-208
    80004340:	c9dfe0ef          	jal	80002fdc <nameiparent>
    80004344:	84aa                	mv	s1,a0
    80004346:	c955                	beqz	a0,800043fa <sys_unlink+0xe2>
  ilock(dp);
    80004348:	c36fe0ef          	jal	8000277e <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    8000434c:	00004597          	auipc	a1,0x4
    80004350:	21458593          	addi	a1,a1,532 # 80008560 <etext+0x560>
    80004354:	fb040513          	addi	a0,s0,-80
    80004358:	9b9fe0ef          	jal	80002d10 <namecmp>
    8000435c:	10050a63          	beqz	a0,80004470 <sys_unlink+0x158>
    80004360:	00004597          	auipc	a1,0x4
    80004364:	20858593          	addi	a1,a1,520 # 80008568 <etext+0x568>
    80004368:	fb040513          	addi	a0,s0,-80
    8000436c:	9a5fe0ef          	jal	80002d10 <namecmp>
    80004370:	10050063          	beqz	a0,80004470 <sys_unlink+0x158>
    80004374:	e9ca                	sd	s2,208(sp)
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004376:	f2c40613          	addi	a2,s0,-212
    8000437a:	fb040593          	addi	a1,s0,-80
    8000437e:	8526                	mv	a0,s1
    80004380:	9a7fe0ef          	jal	80002d26 <dirlookup>
    80004384:	892a                	mv	s2,a0
    80004386:	0e050463          	beqz	a0,8000446e <sys_unlink+0x156>
    8000438a:	e5ce                	sd	s3,200(sp)
  ilock(ip);
    8000438c:	bf2fe0ef          	jal	8000277e <ilock>
  if(ip->nlink < 1)
    80004390:	05291783          	lh	a5,82(s2)
    80004394:	06f05763          	blez	a5,80004402 <sys_unlink+0xea>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004398:	04c91703          	lh	a4,76(s2)
    8000439c:	4785                	li	a5,1
    8000439e:	06f70863          	beq	a4,a5,8000440e <sys_unlink+0xf6>
  memset(&de, 0, sizeof(de));
    800043a2:	fc040993          	addi	s3,s0,-64
    800043a6:	4641                	li	a2,16
    800043a8:	4581                	li	a1,0
    800043aa:	854e                	mv	a0,s3
    800043ac:	e8bfb0ef          	jal	80000236 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800043b0:	4741                	li	a4,16
    800043b2:	f2c42683          	lw	a3,-212(s0)
    800043b6:	864e                	mv	a2,s3
    800043b8:	4581                	li	a1,0
    800043ba:	8526                	mv	a0,s1
    800043bc:	853fe0ef          	jal	80002c0e <writei>
    800043c0:	47c1                	li	a5,16
    800043c2:	08f51763          	bne	a0,a5,80004450 <sys_unlink+0x138>
  if(ip->type == T_DIR){
    800043c6:	04c91703          	lh	a4,76(s2)
    800043ca:	4785                	li	a5,1
    800043cc:	08f70863          	beq	a4,a5,8000445c <sys_unlink+0x144>
  iunlockput(dp);
    800043d0:	8526                	mv	a0,s1
    800043d2:	dc4fe0ef          	jal	80002996 <iunlockput>
  ip->nlink--;
    800043d6:	05295783          	lhu	a5,82(s2)
    800043da:	37fd                	addiw	a5,a5,-1
    800043dc:	04f91923          	sh	a5,82(s2)
  iupdate(ip);
    800043e0:	854a                	mv	a0,s2
    800043e2:	ae8fe0ef          	jal	800026ca <iupdate>
  iunlockput(ip);
    800043e6:	854a                	mv	a0,s2
    800043e8:	daefe0ef          	jal	80002996 <iunlockput>
  end_op();
    800043ec:	e25fe0ef          	jal	80003210 <end_op>
  return 0;
    800043f0:	4501                	li	a0,0
    800043f2:	64ee                	ld	s1,216(sp)
    800043f4:	694e                	ld	s2,208(sp)
    800043f6:	69ae                	ld	s3,200(sp)
    800043f8:	a059                	j	8000447e <sys_unlink+0x166>
    end_op();
    800043fa:	e17fe0ef          	jal	80003210 <end_op>
    return -1;
    800043fe:	64ee                	ld	s1,216(sp)
    80004400:	a8b5                	j	8000447c <sys_unlink+0x164>
    panic("unlink: nlink < 1");
    80004402:	00004517          	auipc	a0,0x4
    80004406:	16e50513          	addi	a0,a0,366 # 80008570 <etext+0x570>
    8000440a:	654010ef          	jal	80005a5e <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    8000440e:	05492703          	lw	a4,84(s2)
    80004412:	02000793          	li	a5,32
    80004416:	f8e7f6e3          	bgeu	a5,a4,800043a2 <sys_unlink+0x8a>
    8000441a:	89be                	mv	s3,a5
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000441c:	4741                	li	a4,16
    8000441e:	86ce                	mv	a3,s3
    80004420:	f1840613          	addi	a2,s0,-232
    80004424:	4581                	li	a1,0
    80004426:	854a                	mv	a0,s2
    80004428:	ef4fe0ef          	jal	80002b1c <readi>
    8000442c:	47c1                	li	a5,16
    8000442e:	00f51b63          	bne	a0,a5,80004444 <sys_unlink+0x12c>
    if(de.inum != 0)
    80004432:	f1845783          	lhu	a5,-232(s0)
    80004436:	eba1                	bnez	a5,80004486 <sys_unlink+0x16e>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004438:	29c1                	addiw	s3,s3,16
    8000443a:	05492783          	lw	a5,84(s2)
    8000443e:	fcf9efe3          	bltu	s3,a5,8000441c <sys_unlink+0x104>
    80004442:	b785                	j	800043a2 <sys_unlink+0x8a>
      panic("isdirempty: readi");
    80004444:	00004517          	auipc	a0,0x4
    80004448:	14450513          	addi	a0,a0,324 # 80008588 <etext+0x588>
    8000444c:	612010ef          	jal	80005a5e <panic>
    panic("unlink: writei");
    80004450:	00004517          	auipc	a0,0x4
    80004454:	15050513          	addi	a0,a0,336 # 800085a0 <etext+0x5a0>
    80004458:	606010ef          	jal	80005a5e <panic>
    dp->nlink--;
    8000445c:	0524d783          	lhu	a5,82(s1)
    80004460:	37fd                	addiw	a5,a5,-1
    80004462:	04f49923          	sh	a5,82(s1)
    iupdate(dp);
    80004466:	8526                	mv	a0,s1
    80004468:	a62fe0ef          	jal	800026ca <iupdate>
    8000446c:	b795                	j	800043d0 <sys_unlink+0xb8>
    8000446e:	694e                	ld	s2,208(sp)
  iunlockput(dp);
    80004470:	8526                	mv	a0,s1
    80004472:	d24fe0ef          	jal	80002996 <iunlockput>
  end_op();
    80004476:	d9bfe0ef          	jal	80003210 <end_op>
  return -1;
    8000447a:	64ee                	ld	s1,216(sp)
    return -1;
    8000447c:	557d                	li	a0,-1
}
    8000447e:	70ae                	ld	ra,232(sp)
    80004480:	740e                	ld	s0,224(sp)
    80004482:	616d                	addi	sp,sp,240
    80004484:	8082                	ret
    iunlockput(ip);
    80004486:	854a                	mv	a0,s2
    80004488:	d0efe0ef          	jal	80002996 <iunlockput>
    goto bad;
    8000448c:	694e                	ld	s2,208(sp)
    8000448e:	69ae                	ld	s3,200(sp)
    80004490:	b7c5                	j	80004470 <sys_unlink+0x158>

0000000080004492 <sys_open>:

uint64
sys_open(void)
{
    80004492:	7131                	addi	sp,sp,-192
    80004494:	fd06                	sd	ra,184(sp)
    80004496:	f922                	sd	s0,176(sp)
    80004498:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    8000449a:	f4c40593          	addi	a1,s0,-180
    8000449e:	4505                	li	a0,1
    800044a0:	8c5fd0ef          	jal	80001d64 <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    800044a4:	08000613          	li	a2,128
    800044a8:	f5040593          	addi	a1,s0,-176
    800044ac:	4501                	li	a0,0
    800044ae:	8effd0ef          	jal	80001d9c <argstr>
    800044b2:	10054563          	bltz	a0,800045bc <sys_open+0x12a>
    800044b6:	f526                	sd	s1,168(sp)
    return -1;

  begin_op();
    800044b8:	ce9fe0ef          	jal	800031a0 <begin_op>

  if(omode & O_CREATE){
    800044bc:	f4c42783          	lw	a5,-180(s0)
    800044c0:	2007f793          	andi	a5,a5,512
    800044c4:	cfd9                	beqz	a5,80004562 <sys_open+0xd0>
    ip = create(path, T_FILE, 0, 0);
    800044c6:	4681                	li	a3,0
    800044c8:	4601                	li	a2,0
    800044ca:	4589                	li	a1,2
    800044cc:	f5040513          	addi	a0,s0,-176
    800044d0:	acdff0ef          	jal	80003f9c <create>
    800044d4:	84aa                	mv	s1,a0
    if(ip == 0){
    800044d6:	c151                	beqz	a0,8000455a <sys_open+0xc8>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    800044d8:	04c49703          	lh	a4,76(s1)
    800044dc:	478d                	li	a5,3
    800044de:	00f71763          	bne	a4,a5,800044ec <sys_open+0x5a>
    800044e2:	04e4d703          	lhu	a4,78(s1)
    800044e6:	47a5                	li	a5,9
    800044e8:	0ae7e863          	bltu	a5,a4,80004598 <sys_open+0x106>
    800044ec:	f14a                	sd	s2,160(sp)
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    800044ee:	82eff0ef          	jal	8000351c <filealloc>
    800044f2:	892a                	mv	s2,a0
    800044f4:	cd4d                	beqz	a0,800045ae <sys_open+0x11c>
    800044f6:	ed4e                	sd	s3,152(sp)
    800044f8:	a67ff0ef          	jal	80003f5e <fdalloc>
    800044fc:	89aa                	mv	s3,a0
    800044fe:	0a054463          	bltz	a0,800045a6 <sys_open+0x114>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004502:	04c49703          	lh	a4,76(s1)
    80004506:	478d                	li	a5,3
    80004508:	0af70f63          	beq	a4,a5,800045c6 <sys_open+0x134>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    8000450c:	4789                	li	a5,2
    8000450e:	00f92023          	sw	a5,0(s2)
    f->off = 0;
    80004512:	02092023          	sw	zero,32(s2)
  }
  f->ip = ip;
    80004516:	00993c23          	sd	s1,24(s2)
  f->readable = !(omode & O_WRONLY);
    8000451a:	f4c42783          	lw	a5,-180(s0)
    8000451e:	0017f713          	andi	a4,a5,1
    80004522:	00174713          	xori	a4,a4,1
    80004526:	00e90423          	sb	a4,8(s2)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    8000452a:	0037f713          	andi	a4,a5,3
    8000452e:	00e03733          	snez	a4,a4
    80004532:	00e904a3          	sb	a4,9(s2)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004536:	4007f793          	andi	a5,a5,1024
    8000453a:	c791                	beqz	a5,80004546 <sys_open+0xb4>
    8000453c:	04c49703          	lh	a4,76(s1)
    80004540:	4789                	li	a5,2
    80004542:	08f70963          	beq	a4,a5,800045d4 <sys_open+0x142>
    itrunc(ip);
  }

  iunlock(ip);
    80004546:	8526                	mv	a0,s1
    80004548:	aeafe0ef          	jal	80002832 <iunlock>
  end_op();
    8000454c:	cc5fe0ef          	jal	80003210 <end_op>

  return fd;
    80004550:	854e                	mv	a0,s3
    80004552:	74aa                	ld	s1,168(sp)
    80004554:	790a                	ld	s2,160(sp)
    80004556:	69ea                	ld	s3,152(sp)
    80004558:	a09d                	j	800045be <sys_open+0x12c>
      end_op();
    8000455a:	cb7fe0ef          	jal	80003210 <end_op>
      return -1;
    8000455e:	74aa                	ld	s1,168(sp)
    80004560:	a8b1                	j	800045bc <sys_open+0x12a>
    if((ip = namei(path)) == 0){
    80004562:	f5040513          	addi	a0,s0,-176
    80004566:	a5dfe0ef          	jal	80002fc2 <namei>
    8000456a:	84aa                	mv	s1,a0
    8000456c:	c115                	beqz	a0,80004590 <sys_open+0xfe>
    ilock(ip);
    8000456e:	a10fe0ef          	jal	8000277e <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004572:	04c49703          	lh	a4,76(s1)
    80004576:	4785                	li	a5,1
    80004578:	f6f710e3          	bne	a4,a5,800044d8 <sys_open+0x46>
    8000457c:	f4c42783          	lw	a5,-180(s0)
    80004580:	d7b5                	beqz	a5,800044ec <sys_open+0x5a>
      iunlockput(ip);
    80004582:	8526                	mv	a0,s1
    80004584:	c12fe0ef          	jal	80002996 <iunlockput>
      end_op();
    80004588:	c89fe0ef          	jal	80003210 <end_op>
      return -1;
    8000458c:	74aa                	ld	s1,168(sp)
    8000458e:	a03d                	j	800045bc <sys_open+0x12a>
      end_op();
    80004590:	c81fe0ef          	jal	80003210 <end_op>
      return -1;
    80004594:	74aa                	ld	s1,168(sp)
    80004596:	a01d                	j	800045bc <sys_open+0x12a>
    iunlockput(ip);
    80004598:	8526                	mv	a0,s1
    8000459a:	bfcfe0ef          	jal	80002996 <iunlockput>
    end_op();
    8000459e:	c73fe0ef          	jal	80003210 <end_op>
    return -1;
    800045a2:	74aa                	ld	s1,168(sp)
    800045a4:	a821                	j	800045bc <sys_open+0x12a>
      fileclose(f);
    800045a6:	854a                	mv	a0,s2
    800045a8:	818ff0ef          	jal	800035c0 <fileclose>
    800045ac:	69ea                	ld	s3,152(sp)
    iunlockput(ip);
    800045ae:	8526                	mv	a0,s1
    800045b0:	be6fe0ef          	jal	80002996 <iunlockput>
    end_op();
    800045b4:	c5dfe0ef          	jal	80003210 <end_op>
    return -1;
    800045b8:	74aa                	ld	s1,168(sp)
    800045ba:	790a                	ld	s2,160(sp)
    return -1;
    800045bc:	557d                	li	a0,-1
}
    800045be:	70ea                	ld	ra,184(sp)
    800045c0:	744a                	ld	s0,176(sp)
    800045c2:	6129                	addi	sp,sp,192
    800045c4:	8082                	ret
    f->type = FD_DEVICE;
    800045c6:	00e92023          	sw	a4,0(s2)
    f->major = ip->major;
    800045ca:	04e49783          	lh	a5,78(s1)
    800045ce:	02f91223          	sh	a5,36(s2)
    800045d2:	b791                	j	80004516 <sys_open+0x84>
    itrunc(ip);
    800045d4:	8526                	mv	a0,s1
    800045d6:	aa2fe0ef          	jal	80002878 <itrunc>
    800045da:	b7b5                	j	80004546 <sys_open+0xb4>

00000000800045dc <sys_mkdir>:

uint64
sys_mkdir(void)
{
    800045dc:	7175                	addi	sp,sp,-144
    800045de:	e506                	sd	ra,136(sp)
    800045e0:	e122                	sd	s0,128(sp)
    800045e2:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    800045e4:	bbdfe0ef          	jal	800031a0 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    800045e8:	08000613          	li	a2,128
    800045ec:	f7040593          	addi	a1,s0,-144
    800045f0:	4501                	li	a0,0
    800045f2:	faafd0ef          	jal	80001d9c <argstr>
    800045f6:	02054363          	bltz	a0,8000461c <sys_mkdir+0x40>
    800045fa:	4681                	li	a3,0
    800045fc:	4601                	li	a2,0
    800045fe:	4585                	li	a1,1
    80004600:	f7040513          	addi	a0,s0,-144
    80004604:	999ff0ef          	jal	80003f9c <create>
    80004608:	c911                	beqz	a0,8000461c <sys_mkdir+0x40>
    end_op();
    return -1;
  }
  iunlockput(ip);
    8000460a:	b8cfe0ef          	jal	80002996 <iunlockput>
  end_op();
    8000460e:	c03fe0ef          	jal	80003210 <end_op>
  return 0;
    80004612:	4501                	li	a0,0
}
    80004614:	60aa                	ld	ra,136(sp)
    80004616:	640a                	ld	s0,128(sp)
    80004618:	6149                	addi	sp,sp,144
    8000461a:	8082                	ret
    end_op();
    8000461c:	bf5fe0ef          	jal	80003210 <end_op>
    return -1;
    80004620:	557d                	li	a0,-1
    80004622:	bfcd                	j	80004614 <sys_mkdir+0x38>

0000000080004624 <sys_mknod>:

uint64
sys_mknod(void)
{
    80004624:	7135                	addi	sp,sp,-160
    80004626:	ed06                	sd	ra,152(sp)
    80004628:	e922                	sd	s0,144(sp)
    8000462a:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    8000462c:	b75fe0ef          	jal	800031a0 <begin_op>
  argint(1, &major);
    80004630:	f6c40593          	addi	a1,s0,-148
    80004634:	4505                	li	a0,1
    80004636:	f2efd0ef          	jal	80001d64 <argint>
  argint(2, &minor);
    8000463a:	f6840593          	addi	a1,s0,-152
    8000463e:	4509                	li	a0,2
    80004640:	f24fd0ef          	jal	80001d64 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004644:	08000613          	li	a2,128
    80004648:	f7040593          	addi	a1,s0,-144
    8000464c:	4501                	li	a0,0
    8000464e:	f4efd0ef          	jal	80001d9c <argstr>
    80004652:	02054563          	bltz	a0,8000467c <sys_mknod+0x58>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004656:	f6841683          	lh	a3,-152(s0)
    8000465a:	f6c41603          	lh	a2,-148(s0)
    8000465e:	458d                	li	a1,3
    80004660:	f7040513          	addi	a0,s0,-144
    80004664:	939ff0ef          	jal	80003f9c <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004668:	c911                	beqz	a0,8000467c <sys_mknod+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
    8000466a:	b2cfe0ef          	jal	80002996 <iunlockput>
  end_op();
    8000466e:	ba3fe0ef          	jal	80003210 <end_op>
  return 0;
    80004672:	4501                	li	a0,0
}
    80004674:	60ea                	ld	ra,152(sp)
    80004676:	644a                	ld	s0,144(sp)
    80004678:	610d                	addi	sp,sp,160
    8000467a:	8082                	ret
    end_op();
    8000467c:	b95fe0ef          	jal	80003210 <end_op>
    return -1;
    80004680:	557d                	li	a0,-1
    80004682:	bfcd                	j	80004674 <sys_mknod+0x50>

0000000080004684 <sys_chdir>:

uint64
sys_chdir(void)
{
    80004684:	7135                	addi	sp,sp,-160
    80004686:	ed06                	sd	ra,152(sp)
    80004688:	e922                	sd	s0,144(sp)
    8000468a:	e14a                	sd	s2,128(sp)
    8000468c:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    8000468e:	fa6fc0ef          	jal	80000e34 <myproc>
    80004692:	892a                	mv	s2,a0
  
  begin_op();
    80004694:	b0dfe0ef          	jal	800031a0 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004698:	08000613          	li	a2,128
    8000469c:	f6040593          	addi	a1,s0,-160
    800046a0:	4501                	li	a0,0
    800046a2:	efafd0ef          	jal	80001d9c <argstr>
    800046a6:	02054f63          	bltz	a0,800046e4 <sys_chdir+0x60>
    800046aa:	e526                	sd	s1,136(sp)
    800046ac:	f6040513          	addi	a0,s0,-160
    800046b0:	913fe0ef          	jal	80002fc2 <namei>
    800046b4:	84aa                	mv	s1,a0
    800046b6:	c515                	beqz	a0,800046e2 <sys_chdir+0x5e>
    end_op();
    return -1;
  }
  ilock(ip);
    800046b8:	8c6fe0ef          	jal	8000277e <ilock>
  if(ip->type != T_DIR){
    800046bc:	04c49703          	lh	a4,76(s1)
    800046c0:	4785                	li	a5,1
    800046c2:	02f71963          	bne	a4,a5,800046f4 <sys_chdir+0x70>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    800046c6:	8526                	mv	a0,s1
    800046c8:	96afe0ef          	jal	80002832 <iunlock>
  iput(p->cwd);
    800046cc:	15893503          	ld	a0,344(s2)
    800046d0:	a3cfe0ef          	jal	8000290c <iput>
  end_op();
    800046d4:	b3dfe0ef          	jal	80003210 <end_op>
  p->cwd = ip;
    800046d8:	14993c23          	sd	s1,344(s2)
  return 0;
    800046dc:	4501                	li	a0,0
    800046de:	64aa                	ld	s1,136(sp)
    800046e0:	a029                	j	800046ea <sys_chdir+0x66>
    800046e2:	64aa                	ld	s1,136(sp)
    end_op();
    800046e4:	b2dfe0ef          	jal	80003210 <end_op>
    return -1;
    800046e8:	557d                	li	a0,-1
}
    800046ea:	60ea                	ld	ra,152(sp)
    800046ec:	644a                	ld	s0,144(sp)
    800046ee:	690a                	ld	s2,128(sp)
    800046f0:	610d                	addi	sp,sp,160
    800046f2:	8082                	ret
    iunlockput(ip);
    800046f4:	8526                	mv	a0,s1
    800046f6:	aa0fe0ef          	jal	80002996 <iunlockput>
    end_op();
    800046fa:	b17fe0ef          	jal	80003210 <end_op>
    return -1;
    800046fe:	64aa                	ld	s1,136(sp)
    80004700:	b7e5                	j	800046e8 <sys_chdir+0x64>

0000000080004702 <sys_exec>:

uint64
sys_exec(void)
{
    80004702:	7105                	addi	sp,sp,-480
    80004704:	ef86                	sd	ra,472(sp)
    80004706:	eba2                	sd	s0,464(sp)
    80004708:	1380                	addi	s0,sp,480
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    8000470a:	e2840593          	addi	a1,s0,-472
    8000470e:	4505                	li	a0,1
    80004710:	e70fd0ef          	jal	80001d80 <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80004714:	08000613          	li	a2,128
    80004718:	f3040593          	addi	a1,s0,-208
    8000471c:	4501                	li	a0,0
    8000471e:	e7efd0ef          	jal	80001d9c <argstr>
    80004722:	0c054e63          	bltz	a0,800047fe <sys_exec+0xfc>
    80004726:	e7a6                	sd	s1,456(sp)
    80004728:	e3ca                	sd	s2,448(sp)
    8000472a:	ff4e                	sd	s3,440(sp)
    8000472c:	fb52                	sd	s4,432(sp)
    8000472e:	f756                	sd	s5,424(sp)
    80004730:	f35a                	sd	s6,416(sp)
    80004732:	ef5e                	sd	s7,408(sp)
    return -1;
  }
  memset(argv, 0, sizeof(argv));
    80004734:	e3040a13          	addi	s4,s0,-464
    80004738:	10000613          	li	a2,256
    8000473c:	4581                	li	a1,0
    8000473e:	8552                	mv	a0,s4
    80004740:	af7fb0ef          	jal	80000236 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80004744:	84d2                	mv	s1,s4
  memset(argv, 0, sizeof(argv));
    80004746:	89d2                	mv	s3,s4
    80004748:	4901                	li	s2,0
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    8000474a:	e2040a93          	addi	s5,s0,-480
      break;
    }
    argv[i] = kalloc();
    if(argv[i] == 0)
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    8000474e:	6b05                	lui	s6,0x1
    if(i >= NELEM(argv)){
    80004750:	02000b93          	li	s7,32
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004754:	00391513          	slli	a0,s2,0x3
    80004758:	85d6                	mv	a1,s5
    8000475a:	e2843783          	ld	a5,-472(s0)
    8000475e:	953e                	add	a0,a0,a5
    80004760:	d7efd0ef          	jal	80001cde <fetchaddr>
    80004764:	02054663          	bltz	a0,80004790 <sys_exec+0x8e>
    if(uarg == 0){
    80004768:	e2043783          	ld	a5,-480(s0)
    8000476c:	c3b9                	beqz	a5,800047b2 <sys_exec+0xb0>
    argv[i] = kalloc();
    8000476e:	9f1fb0ef          	jal	8000015e <kalloc>
    80004772:	85aa                	mv	a1,a0
    80004774:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80004778:	cd01                	beqz	a0,80004790 <sys_exec+0x8e>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    8000477a:	865a                	mv	a2,s6
    8000477c:	e2043503          	ld	a0,-480(s0)
    80004780:	da4fd0ef          	jal	80001d24 <fetchstr>
    80004784:	00054663          	bltz	a0,80004790 <sys_exec+0x8e>
    if(i >= NELEM(argv)){
    80004788:	0905                	addi	s2,s2,1
    8000478a:	09a1                	addi	s3,s3,8
    8000478c:	fd7914e3          	bne	s2,s7,80004754 <sys_exec+0x52>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004790:	100a0a13          	addi	s4,s4,256
    80004794:	6088                	ld	a0,0(s1)
    80004796:	cd29                	beqz	a0,800047f0 <sys_exec+0xee>
    kfree(argv[i]);
    80004798:	885fb0ef          	jal	8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000479c:	04a1                	addi	s1,s1,8
    8000479e:	ff449be3          	bne	s1,s4,80004794 <sys_exec+0x92>
    800047a2:	64be                	ld	s1,456(sp)
    800047a4:	691e                	ld	s2,448(sp)
    800047a6:	79fa                	ld	s3,440(sp)
    800047a8:	7a5a                	ld	s4,432(sp)
    800047aa:	7aba                	ld	s5,424(sp)
    800047ac:	7b1a                	ld	s6,416(sp)
    800047ae:	6bfa                	ld	s7,408(sp)
    800047b0:	a0b9                	j	800047fe <sys_exec+0xfc>
      argv[i] = 0;
    800047b2:	0009079b          	sext.w	a5,s2
    800047b6:	e3040593          	addi	a1,s0,-464
    800047ba:	078e                	slli	a5,a5,0x3
    800047bc:	97ae                	add	a5,a5,a1
    800047be:	0007b023          	sd	zero,0(a5)
  int ret = kexec(path, argv);
    800047c2:	f3040513          	addi	a0,s0,-208
    800047c6:	c30ff0ef          	jal	80003bf6 <kexec>
    800047ca:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800047cc:	100a0a13          	addi	s4,s4,256
    800047d0:	6088                	ld	a0,0(s1)
    800047d2:	c511                	beqz	a0,800047de <sys_exec+0xdc>
    kfree(argv[i]);
    800047d4:	849fb0ef          	jal	8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800047d8:	04a1                	addi	s1,s1,8
    800047da:	ff449be3          	bne	s1,s4,800047d0 <sys_exec+0xce>
  return ret;
    800047de:	854a                	mv	a0,s2
    800047e0:	64be                	ld	s1,456(sp)
    800047e2:	691e                	ld	s2,448(sp)
    800047e4:	79fa                	ld	s3,440(sp)
    800047e6:	7a5a                	ld	s4,432(sp)
    800047e8:	7aba                	ld	s5,424(sp)
    800047ea:	7b1a                	ld	s6,416(sp)
    800047ec:	6bfa                	ld	s7,408(sp)
    800047ee:	a809                	j	80004800 <sys_exec+0xfe>
    800047f0:	64be                	ld	s1,456(sp)
    800047f2:	691e                	ld	s2,448(sp)
    800047f4:	79fa                	ld	s3,440(sp)
    800047f6:	7a5a                	ld	s4,432(sp)
    800047f8:	7aba                	ld	s5,424(sp)
    800047fa:	7b1a                	ld	s6,416(sp)
    800047fc:	6bfa                	ld	s7,408(sp)
    return -1;
    800047fe:	557d                	li	a0,-1
  return -1;
}
    80004800:	60fe                	ld	ra,472(sp)
    80004802:	645e                	ld	s0,464(sp)
    80004804:	613d                	addi	sp,sp,480
    80004806:	8082                	ret

0000000080004808 <sys_pipe>:

uint64
sys_pipe(void)
{
    80004808:	7139                	addi	sp,sp,-64
    8000480a:	fc06                	sd	ra,56(sp)
    8000480c:	f822                	sd	s0,48(sp)
    8000480e:	f426                	sd	s1,40(sp)
    80004810:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80004812:	e22fc0ef          	jal	80000e34 <myproc>
    80004816:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    80004818:	fd840593          	addi	a1,s0,-40
    8000481c:	4501                	li	a0,0
    8000481e:	d62fd0ef          	jal	80001d80 <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    80004822:	fc840593          	addi	a1,s0,-56
    80004826:	fd040513          	addi	a0,s0,-48
    8000482a:	8a4ff0ef          	jal	800038ce <pipealloc>
    8000482e:	0a054463          	bltz	a0,800048d6 <sys_pipe+0xce>
    return -1;
  fd0 = -1;
    80004832:	57fd                	li	a5,-1
    80004834:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80004838:	fd043503          	ld	a0,-48(s0)
    8000483c:	f22ff0ef          	jal	80003f5e <fdalloc>
    80004840:	fca42223          	sw	a0,-60(s0)
    80004844:	08054163          	bltz	a0,800048c6 <sys_pipe+0xbe>
    80004848:	fc843503          	ld	a0,-56(s0)
    8000484c:	f12ff0ef          	jal	80003f5e <fdalloc>
    80004850:	fca42023          	sw	a0,-64(s0)
    80004854:	06054063          	bltz	a0,800048b4 <sys_pipe+0xac>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80004858:	4691                	li	a3,4
    8000485a:	fc440613          	addi	a2,s0,-60
    8000485e:	fd843583          	ld	a1,-40(s0)
    80004862:	6ca8                	ld	a0,88(s1)
    80004864:	b14fc0ef          	jal	80000b78 <copyout>
    80004868:	00054f63          	bltz	a0,80004886 <sys_pipe+0x7e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    8000486c:	4691                	li	a3,4
    8000486e:	fc040613          	addi	a2,s0,-64
    80004872:	fd843583          	ld	a1,-40(s0)
    80004876:	95b6                	add	a1,a1,a3
    80004878:	6ca8                	ld	a0,88(s1)
    8000487a:	afefc0ef          	jal	80000b78 <copyout>
    8000487e:	87aa                	mv	a5,a0
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80004880:	4501                	li	a0,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80004882:	0407db63          	bgez	a5,800048d8 <sys_pipe+0xd0>
    p->ofile[fd0] = 0;
    80004886:	fc442783          	lw	a5,-60(s0)
    8000488a:	07e9                	addi	a5,a5,26
    8000488c:	078e                	slli	a5,a5,0x3
    8000488e:	97a6                	add	a5,a5,s1
    80004890:	0007b423          	sd	zero,8(a5)
    p->ofile[fd1] = 0;
    80004894:	fc042783          	lw	a5,-64(s0)
    80004898:	07e9                	addi	a5,a5,26
    8000489a:	078e                	slli	a5,a5,0x3
    8000489c:	97a6                	add	a5,a5,s1
    8000489e:	0007b423          	sd	zero,8(a5)
    fileclose(rf);
    800048a2:	fd043503          	ld	a0,-48(s0)
    800048a6:	d1bfe0ef          	jal	800035c0 <fileclose>
    fileclose(wf);
    800048aa:	fc843503          	ld	a0,-56(s0)
    800048ae:	d13fe0ef          	jal	800035c0 <fileclose>
    return -1;
    800048b2:	a015                	j	800048d6 <sys_pipe+0xce>
    if(fd0 >= 0)
    800048b4:	fc442783          	lw	a5,-60(s0)
    800048b8:	0007c763          	bltz	a5,800048c6 <sys_pipe+0xbe>
      p->ofile[fd0] = 0;
    800048bc:	07e9                	addi	a5,a5,26
    800048be:	078e                	slli	a5,a5,0x3
    800048c0:	97a6                	add	a5,a5,s1
    800048c2:	0007b423          	sd	zero,8(a5)
    fileclose(rf);
    800048c6:	fd043503          	ld	a0,-48(s0)
    800048ca:	cf7fe0ef          	jal	800035c0 <fileclose>
    fileclose(wf);
    800048ce:	fc843503          	ld	a0,-56(s0)
    800048d2:	ceffe0ef          	jal	800035c0 <fileclose>
    return -1;
    800048d6:	557d                	li	a0,-1
}
    800048d8:	70e2                	ld	ra,56(sp)
    800048da:	7442                	ld	s0,48(sp)
    800048dc:	74a2                	ld	s1,40(sp)
    800048de:	6121                	addi	sp,sp,64
    800048e0:	8082                	ret
	...

00000000800048f0 <kernelvec>:
.globl kerneltrap
.globl kernelvec
.align 4
kernelvec:
        # make room to save registers.
        addi sp, sp, -256
    800048f0:	7111                	addi	sp,sp,-256

        # save caller-saved registers.
        sd ra, 0(sp)
    800048f2:	e006                	sd	ra,0(sp)
        # sd sp, 8(sp)
        sd gp, 16(sp)
    800048f4:	e80e                	sd	gp,16(sp)
        sd tp, 24(sp)
    800048f6:	ec12                	sd	tp,24(sp)
        sd t0, 32(sp)
    800048f8:	f016                	sd	t0,32(sp)
        sd t1, 40(sp)
    800048fa:	f41a                	sd	t1,40(sp)
        sd t2, 48(sp)
    800048fc:	f81e                	sd	t2,48(sp)
        sd a0, 72(sp)
    800048fe:	e4aa                	sd	a0,72(sp)
        sd a1, 80(sp)
    80004900:	e8ae                	sd	a1,80(sp)
        sd a2, 88(sp)
    80004902:	ecb2                	sd	a2,88(sp)
        sd a3, 96(sp)
    80004904:	f0b6                	sd	a3,96(sp)
        sd a4, 104(sp)
    80004906:	f4ba                	sd	a4,104(sp)
        sd a5, 112(sp)
    80004908:	f8be                	sd	a5,112(sp)
        sd a6, 120(sp)
    8000490a:	fcc2                	sd	a6,120(sp)
        sd a7, 128(sp)
    8000490c:	e146                	sd	a7,128(sp)
        sd t3, 216(sp)
    8000490e:	edf2                	sd	t3,216(sp)
        sd t4, 224(sp)
    80004910:	f1f6                	sd	t4,224(sp)
        sd t5, 232(sp)
    80004912:	f5fa                	sd	t5,232(sp)
        sd t6, 240(sp)
    80004914:	f9fe                	sd	t6,240(sp)

        # call the C trap handler in trap.c
        call kerneltrap
    80004916:	ad6fd0ef          	jal	80001bec <kerneltrap>

        # restore registers.
        ld ra, 0(sp)
    8000491a:	6082                	ld	ra,0(sp)
        # ld sp, 8(sp)
        ld gp, 16(sp)
    8000491c:	61c2                	ld	gp,16(sp)
        # not tp (contains hartid), in case we moved CPUs
        ld t0, 32(sp)
    8000491e:	7282                	ld	t0,32(sp)
        ld t1, 40(sp)
    80004920:	7322                	ld	t1,40(sp)
        ld t2, 48(sp)
    80004922:	73c2                	ld	t2,48(sp)
        ld a0, 72(sp)
    80004924:	6526                	ld	a0,72(sp)
        ld a1, 80(sp)
    80004926:	65c6                	ld	a1,80(sp)
        ld a2, 88(sp)
    80004928:	6666                	ld	a2,88(sp)
        ld a3, 96(sp)
    8000492a:	7686                	ld	a3,96(sp)
        ld a4, 104(sp)
    8000492c:	7726                	ld	a4,104(sp)
        ld a5, 112(sp)
    8000492e:	77c6                	ld	a5,112(sp)
        ld a6, 120(sp)
    80004930:	7866                	ld	a6,120(sp)
        ld a7, 128(sp)
    80004932:	688a                	ld	a7,128(sp)
        ld t3, 216(sp)
    80004934:	6e6e                	ld	t3,216(sp)
        ld t4, 224(sp)
    80004936:	7e8e                	ld	t4,224(sp)
        ld t5, 232(sp)
    80004938:	7f2e                	ld	t5,232(sp)
        ld t6, 240(sp)
    8000493a:	7fce                	ld	t6,240(sp)

        addi sp, sp, 256
    8000493c:	6111                	addi	sp,sp,256

        # return to whatever we were doing in the kernel.
        sret
    8000493e:	10200073          	sret
    80004942:	00000013          	nop
    80004946:	00000013          	nop
    8000494a:	00000013          	nop

000000008000494e <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000494e:	1141                	addi	sp,sp,-16
    80004950:	e406                	sd	ra,8(sp)
    80004952:	e022                	sd	s0,0(sp)
    80004954:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80004956:	0c000737          	lui	a4,0xc000
    8000495a:	4785                	li	a5,1
    8000495c:	d71c                	sw	a5,40(a4)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    8000495e:	c35c                	sw	a5,4(a4)
}
    80004960:	60a2                	ld	ra,8(sp)
    80004962:	6402                	ld	s0,0(sp)
    80004964:	0141                	addi	sp,sp,16
    80004966:	8082                	ret

0000000080004968 <plicinithart>:

void
plicinithart(void)
{
    80004968:	1141                	addi	sp,sp,-16
    8000496a:	e406                	sd	ra,8(sp)
    8000496c:	e022                	sd	s0,0(sp)
    8000496e:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80004970:	c90fc0ef          	jal	80000e00 <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80004974:	0085171b          	slliw	a4,a0,0x8
    80004978:	0c0027b7          	lui	a5,0xc002
    8000497c:	97ba                	add	a5,a5,a4
    8000497e:	40200713          	li	a4,1026
    80004982:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80004986:	00d5151b          	slliw	a0,a0,0xd
    8000498a:	0c2017b7          	lui	a5,0xc201
    8000498e:	97aa                	add	a5,a5,a0
    80004990:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80004994:	60a2                	ld	ra,8(sp)
    80004996:	6402                	ld	s0,0(sp)
    80004998:	0141                	addi	sp,sp,16
    8000499a:	8082                	ret

000000008000499c <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    8000499c:	1141                	addi	sp,sp,-16
    8000499e:	e406                	sd	ra,8(sp)
    800049a0:	e022                	sd	s0,0(sp)
    800049a2:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800049a4:	c5cfc0ef          	jal	80000e00 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    800049a8:	00d5151b          	slliw	a0,a0,0xd
    800049ac:	0c2017b7          	lui	a5,0xc201
    800049b0:	97aa                	add	a5,a5,a0
  return irq;
}
    800049b2:	43c8                	lw	a0,4(a5)
    800049b4:	60a2                	ld	ra,8(sp)
    800049b6:	6402                	ld	s0,0(sp)
    800049b8:	0141                	addi	sp,sp,16
    800049ba:	8082                	ret

00000000800049bc <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800049bc:	1101                	addi	sp,sp,-32
    800049be:	ec06                	sd	ra,24(sp)
    800049c0:	e822                	sd	s0,16(sp)
    800049c2:	e426                	sd	s1,8(sp)
    800049c4:	1000                	addi	s0,sp,32
    800049c6:	84aa                	mv	s1,a0
  int hart = cpuid();
    800049c8:	c38fc0ef          	jal	80000e00 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    800049cc:	00d5179b          	slliw	a5,a0,0xd
    800049d0:	0c201737          	lui	a4,0xc201
    800049d4:	97ba                	add	a5,a5,a4
    800049d6:	c3c4                	sw	s1,4(a5)
}
    800049d8:	60e2                	ld	ra,24(sp)
    800049da:	6442                	ld	s0,16(sp)
    800049dc:	64a2                	ld	s1,8(sp)
    800049de:	6105                	addi	sp,sp,32
    800049e0:	8082                	ret

00000000800049e2 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    800049e2:	1141                	addi	sp,sp,-16
    800049e4:	e406                	sd	ra,8(sp)
    800049e6:	e022                	sd	s0,0(sp)
    800049e8:	0800                	addi	s0,sp,16
  if(i >= NUM)
    800049ea:	479d                	li	a5,7
    800049ec:	04a7ca63          	blt	a5,a0,80004a40 <free_desc+0x5e>
    panic("free_desc 1");
  if(disk.free[i])
    800049f0:	00016797          	auipc	a5,0x16
    800049f4:	c4078793          	addi	a5,a5,-960 # 8001a630 <disk>
    800049f8:	97aa                	add	a5,a5,a0
    800049fa:	0187c783          	lbu	a5,24(a5)
    800049fe:	e7b9                	bnez	a5,80004a4c <free_desc+0x6a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80004a00:	00451693          	slli	a3,a0,0x4
    80004a04:	00016797          	auipc	a5,0x16
    80004a08:	c2c78793          	addi	a5,a5,-980 # 8001a630 <disk>
    80004a0c:	6398                	ld	a4,0(a5)
    80004a0e:	9736                	add	a4,a4,a3
    80004a10:	00073023          	sd	zero,0(a4) # c201000 <_entry-0x73dff000>
  disk.desc[i].len = 0;
    80004a14:	6398                	ld	a4,0(a5)
    80004a16:	9736                	add	a4,a4,a3
    80004a18:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    80004a1c:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    80004a20:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    80004a24:	97aa                	add	a5,a5,a0
    80004a26:	4705                	li	a4,1
    80004a28:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    80004a2c:	00016517          	auipc	a0,0x16
    80004a30:	c1c50513          	addi	a0,a0,-996 # 8001a648 <disk+0x18>
    80004a34:	a83fc0ef          	jal	800014b6 <wakeup>
}
    80004a38:	60a2                	ld	ra,8(sp)
    80004a3a:	6402                	ld	s0,0(sp)
    80004a3c:	0141                	addi	sp,sp,16
    80004a3e:	8082                	ret
    panic("free_desc 1");
    80004a40:	00004517          	auipc	a0,0x4
    80004a44:	b7050513          	addi	a0,a0,-1168 # 800085b0 <etext+0x5b0>
    80004a48:	016010ef          	jal	80005a5e <panic>
    panic("free_desc 2");
    80004a4c:	00004517          	auipc	a0,0x4
    80004a50:	b7450513          	addi	a0,a0,-1164 # 800085c0 <etext+0x5c0>
    80004a54:	00a010ef          	jal	80005a5e <panic>

0000000080004a58 <virtio_disk_init>:
{
    80004a58:	1101                	addi	sp,sp,-32
    80004a5a:	ec06                	sd	ra,24(sp)
    80004a5c:	e822                	sd	s0,16(sp)
    80004a5e:	e426                	sd	s1,8(sp)
    80004a60:	e04a                	sd	s2,0(sp)
    80004a62:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80004a64:	00004597          	auipc	a1,0x4
    80004a68:	b6c58593          	addi	a1,a1,-1172 # 800085d0 <etext+0x5d0>
    80004a6c:	00016517          	auipc	a0,0x16
    80004a70:	cec50513          	addi	a0,a0,-788 # 8001a758 <disk+0x128>
    80004a74:	4fa010ef          	jal	80005f6e <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80004a78:	100017b7          	lui	a5,0x10001
    80004a7c:	4398                	lw	a4,0(a5)
    80004a7e:	747277b7          	lui	a5,0x74727
    80004a82:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80004a86:	14f71263          	bne	a4,a5,80004bca <virtio_disk_init+0x172>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80004a8a:	100017b7          	lui	a5,0x10001
    80004a8e:	43d8                	lw	a4,4(a5)
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80004a90:	4789                	li	a5,2
    80004a92:	12f71c63          	bne	a4,a5,80004bca <virtio_disk_init+0x172>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80004a96:	100017b7          	lui	a5,0x10001
    80004a9a:	4798                	lw	a4,8(a5)
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80004a9c:	4789                	li	a5,2
    80004a9e:	12f71663          	bne	a4,a5,80004bca <virtio_disk_init+0x172>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80004aa2:	100017b7          	lui	a5,0x10001
    80004aa6:	47d8                	lw	a4,12(a5)
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80004aa8:	554d47b7          	lui	a5,0x554d4
    80004aac:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80004ab0:	10f71d63          	bne	a4,a5,80004bca <virtio_disk_init+0x172>
  *R(VIRTIO_MMIO_STATUS) = status;
    80004ab4:	100017b7          	lui	a5,0x10001
    80004ab8:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    80004abc:	4705                	li	a4,1
    80004abe:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80004ac0:	470d                	li	a4,3
    80004ac2:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80004ac4:	10001737          	lui	a4,0x10001
    80004ac8:	4b18                	lw	a4,16(a4)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80004aca:	c7ffe6b7          	lui	a3,0xc7ffe
    80004ace:	75f68693          	addi	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fd9e1f>
    80004ad2:	8f75                	and	a4,a4,a3
    80004ad4:	100016b7          	lui	a3,0x10001
    80004ad8:	d298                	sw	a4,32(a3)
  *R(VIRTIO_MMIO_STATUS) = status;
    80004ada:	472d                	li	a4,11
    80004adc:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    80004ade:	0707a903          	lw	s2,112(a5)
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80004ae2:	00897793          	andi	a5,s2,8
    80004ae6:	0e078863          	beqz	a5,80004bd6 <virtio_disk_init+0x17e>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80004aea:	100017b7          	lui	a5,0x10001
    80004aee:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    80004af2:	43fc                	lw	a5,68(a5)
    80004af4:	0e079763          	bnez	a5,80004be2 <virtio_disk_init+0x18a>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80004af8:	100017b7          	lui	a5,0x10001
    80004afc:	5bdc                	lw	a5,52(a5)
  if(max == 0)
    80004afe:	0e078863          	beqz	a5,80004bee <virtio_disk_init+0x196>
  if(max < NUM)
    80004b02:	471d                	li	a4,7
    80004b04:	0ef77b63          	bgeu	a4,a5,80004bfa <virtio_disk_init+0x1a2>
  disk.desc = kalloc();
    80004b08:	e56fb0ef          	jal	8000015e <kalloc>
    80004b0c:	00016497          	auipc	s1,0x16
    80004b10:	b2448493          	addi	s1,s1,-1244 # 8001a630 <disk>
    80004b14:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    80004b16:	e48fb0ef          	jal	8000015e <kalloc>
    80004b1a:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    80004b1c:	e42fb0ef          	jal	8000015e <kalloc>
    80004b20:	87aa                	mv	a5,a0
    80004b22:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    80004b24:	6088                	ld	a0,0(s1)
    80004b26:	0e050063          	beqz	a0,80004c06 <virtio_disk_init+0x1ae>
    80004b2a:	00016717          	auipc	a4,0x16
    80004b2e:	b0e73703          	ld	a4,-1266(a4) # 8001a638 <disk+0x8>
    80004b32:	00173713          	seqz	a4,a4
    80004b36:	0017b793          	seqz	a5,a5
    80004b3a:	8fd9                	or	a5,a5,a4
    80004b3c:	e7e9                	bnez	a5,80004c06 <virtio_disk_init+0x1ae>
  memset(disk.desc, 0, PGSIZE);
    80004b3e:	6605                	lui	a2,0x1
    80004b40:	4581                	li	a1,0
    80004b42:	ef4fb0ef          	jal	80000236 <memset>
  memset(disk.avail, 0, PGSIZE);
    80004b46:	00016497          	auipc	s1,0x16
    80004b4a:	aea48493          	addi	s1,s1,-1302 # 8001a630 <disk>
    80004b4e:	6605                	lui	a2,0x1
    80004b50:	4581                	li	a1,0
    80004b52:	6488                	ld	a0,8(s1)
    80004b54:	ee2fb0ef          	jal	80000236 <memset>
  memset(disk.used, 0, PGSIZE);
    80004b58:	6605                	lui	a2,0x1
    80004b5a:	4581                	li	a1,0
    80004b5c:	6888                	ld	a0,16(s1)
    80004b5e:	ed8fb0ef          	jal	80000236 <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80004b62:	100017b7          	lui	a5,0x10001
    80004b66:	4721                	li	a4,8
    80004b68:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    80004b6a:	4098                	lw	a4,0(s1)
    80004b6c:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80004b70:	40d8                	lw	a4,4(s1)
    80004b72:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    80004b76:	649c                	ld	a5,8(s1)
    80004b78:	10001737          	lui	a4,0x10001
    80004b7c:	08f72823          	sw	a5,144(a4) # 10001090 <_entry-0x6fffef70>
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80004b80:	9781                	srai	a5,a5,0x20
    80004b82:	08f72a23          	sw	a5,148(a4)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    80004b86:	689c                	ld	a5,16(s1)
    80004b88:	0af72023          	sw	a5,160(a4)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80004b8c:	9781                	srai	a5,a5,0x20
    80004b8e:	0af72223          	sw	a5,164(a4)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    80004b92:	4785                	li	a5,1
    80004b94:	c37c                	sw	a5,68(a4)
    disk.free[i] = 1;
    80004b96:	00f48c23          	sb	a5,24(s1)
    80004b9a:	00f48ca3          	sb	a5,25(s1)
    80004b9e:	00f48d23          	sb	a5,26(s1)
    80004ba2:	00f48da3          	sb	a5,27(s1)
    80004ba6:	00f48e23          	sb	a5,28(s1)
    80004baa:	00f48ea3          	sb	a5,29(s1)
    80004bae:	00f48f23          	sb	a5,30(s1)
    80004bb2:	00f48fa3          	sb	a5,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80004bb6:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80004bba:	07272823          	sw	s2,112(a4)
}
    80004bbe:	60e2                	ld	ra,24(sp)
    80004bc0:	6442                	ld	s0,16(sp)
    80004bc2:	64a2                	ld	s1,8(sp)
    80004bc4:	6902                	ld	s2,0(sp)
    80004bc6:	6105                	addi	sp,sp,32
    80004bc8:	8082                	ret
    panic("could not find virtio disk");
    80004bca:	00004517          	auipc	a0,0x4
    80004bce:	a1650513          	addi	a0,a0,-1514 # 800085e0 <etext+0x5e0>
    80004bd2:	68d000ef          	jal	80005a5e <panic>
    panic("virtio disk FEATURES_OK unset");
    80004bd6:	00004517          	auipc	a0,0x4
    80004bda:	a2a50513          	addi	a0,a0,-1494 # 80008600 <etext+0x600>
    80004bde:	681000ef          	jal	80005a5e <panic>
    panic("virtio disk should not be ready");
    80004be2:	00004517          	auipc	a0,0x4
    80004be6:	a3e50513          	addi	a0,a0,-1474 # 80008620 <etext+0x620>
    80004bea:	675000ef          	jal	80005a5e <panic>
    panic("virtio disk has no queue 0");
    80004bee:	00004517          	auipc	a0,0x4
    80004bf2:	a5250513          	addi	a0,a0,-1454 # 80008640 <etext+0x640>
    80004bf6:	669000ef          	jal	80005a5e <panic>
    panic("virtio disk max queue too short");
    80004bfa:	00004517          	auipc	a0,0x4
    80004bfe:	a6650513          	addi	a0,a0,-1434 # 80008660 <etext+0x660>
    80004c02:	65d000ef          	jal	80005a5e <panic>
    panic("virtio disk kalloc");
    80004c06:	00004517          	auipc	a0,0x4
    80004c0a:	a7a50513          	addi	a0,a0,-1414 # 80008680 <etext+0x680>
    80004c0e:	651000ef          	jal	80005a5e <panic>

0000000080004c12 <virtio_disk_rw>:
}
#endif

void
virtio_disk_rw(struct buf *b, int write)
{
    80004c12:	711d                	addi	sp,sp,-96
    80004c14:	ec86                	sd	ra,88(sp)
    80004c16:	e8a2                	sd	s0,80(sp)
    80004c18:	e4a6                	sd	s1,72(sp)
    80004c1a:	e0ca                	sd	s2,64(sp)
    80004c1c:	fc4e                	sd	s3,56(sp)
    80004c1e:	f852                	sd	s4,48(sp)
    80004c20:	f456                	sd	s5,40(sp)
    80004c22:	f05a                	sd	s6,32(sp)
    80004c24:	ec5e                	sd	s7,24(sp)
    80004c26:	e862                	sd	s8,16(sp)
    80004c28:	1080                	addi	s0,sp,96
    80004c2a:	89aa                	mv	s3,a0
    80004c2c:	8b2e                	mv	s6,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80004c2e:	4544                	lw	s1,12(a0)

  acquire(&disk.vdisk_lock);
    80004c30:	00016517          	auipc	a0,0x16
    80004c34:	b2850513          	addi	a0,a0,-1240 # 8001a758 <disk+0x128>
    80004c38:	162010ef          	jal	80005d9a <acquire>
  for(int i = 0; i < NBUF; i++){
    80004c3c:	00016697          	auipc	a3,0x16
    80004c40:	b3c68693          	addi	a3,a3,-1220 # 8001a778 <xbufs>
    80004c44:	4781                	li	a5,0
    80004c46:	4679                	li	a2,30
    if(xbufs[i] == b){
    80004c48:	6298                	ld	a4,0(a3)
    80004c4a:	02e98563          	beq	s3,a4,80004c74 <virtio_disk_rw+0x62>
    if(xbufs[i] == 0){
    80004c4e:	cb19                	beqz	a4,80004c64 <virtio_disk_rw+0x52>
  for(int i = 0; i < NBUF; i++){
    80004c50:	2785                	addiw	a5,a5,1
    80004c52:	06a1                	addi	a3,a3,8
    80004c54:	fec79ae3          	bne	a5,a2,80004c48 <virtio_disk_rw+0x36>
  panic("more than NBUF bufs");
    80004c58:	00004517          	auipc	a0,0x4
    80004c5c:	a4050513          	addi	a0,a0,-1472 # 80008698 <etext+0x698>
    80004c60:	5ff000ef          	jal	80005a5e <panic>
      xbufs[i] = b;
    80004c64:	078e                	slli	a5,a5,0x3
    80004c66:	00016717          	auipc	a4,0x16
    80004c6a:	9ca70713          	addi	a4,a4,-1590 # 8001a630 <disk>
    80004c6e:	97ba                	add	a5,a5,a4
    80004c70:	1537b423          	sd	s3,328(a5)
  uint64 sector = b->blockno * (BSIZE / 512);
    80004c74:	0014949b          	slliw	s1,s1,0x1
    80004c78:	02049793          	slli	a5,s1,0x20
    80004c7c:	9381                	srli	a5,a5,0x20
    80004c7e:	8c3e                	mv	s8,a5
  for(int i = 0; i < NUM; i++){
    80004c80:	44a1                	li	s1,8
      disk.free[i] = 0;
    80004c82:	00016a97          	auipc	s5,0x16
    80004c86:	9aea8a93          	addi	s5,s5,-1618 # 8001a630 <disk>
  for(int i = 0; i < 3; i++){
    80004c8a:	4a0d                	li	s4,3
    idx[i] = alloc_desc();
    80004c8c:	5bfd                	li	s7,-1
    80004c8e:	a095                	j	80004cf2 <virtio_disk_rw+0xe0>
      disk.free[i] = 0;
    80004c90:	00fa8733          	add	a4,s5,a5
    80004c94:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80004c98:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80004c9a:	0207c563          	bltz	a5,80004cc4 <virtio_disk_rw+0xb2>
  for(int i = 0; i < 3; i++){
    80004c9e:	2905                	addiw	s2,s2,1
    80004ca0:	0611                	addi	a2,a2,4 # 1004 <_entry-0x7fffeffc>
    80004ca2:	05490c63          	beq	s2,s4,80004cfa <virtio_disk_rw+0xe8>
    idx[i] = alloc_desc();
    80004ca6:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80004ca8:	00016717          	auipc	a4,0x16
    80004cac:	98870713          	addi	a4,a4,-1656 # 8001a630 <disk>
    80004cb0:	4781                	li	a5,0
    if(disk.free[i]){
    80004cb2:	01874683          	lbu	a3,24(a4)
    80004cb6:	fee9                	bnez	a3,80004c90 <virtio_disk_rw+0x7e>
  for(int i = 0; i < NUM; i++){
    80004cb8:	2785                	addiw	a5,a5,1
    80004cba:	0705                	addi	a4,a4,1
    80004cbc:	fe979be3          	bne	a5,s1,80004cb2 <virtio_disk_rw+0xa0>
    idx[i] = alloc_desc();
    80004cc0:	0175a023          	sw	s7,0(a1)
      for(int j = 0; j < i; j++)
    80004cc4:	01205d63          	blez	s2,80004cde <virtio_disk_rw+0xcc>
        free_desc(idx[j]);
    80004cc8:	fa042503          	lw	a0,-96(s0)
    80004ccc:	d17ff0ef          	jal	800049e2 <free_desc>
      for(int j = 0; j < i; j++)
    80004cd0:	4785                	li	a5,1
    80004cd2:	0127d663          	bge	a5,s2,80004cde <virtio_disk_rw+0xcc>
        free_desc(idx[j]);
    80004cd6:	fa442503          	lw	a0,-92(s0)
    80004cda:	d09ff0ef          	jal	800049e2 <free_desc>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80004cde:	00016597          	auipc	a1,0x16
    80004ce2:	a7a58593          	addi	a1,a1,-1414 # 8001a758 <disk+0x128>
    80004ce6:	00016517          	auipc	a0,0x16
    80004cea:	96250513          	addi	a0,a0,-1694 # 8001a648 <disk+0x18>
    80004cee:	f7cfc0ef          	jal	8000146a <sleep>
  for(int i = 0; i < 3; i++){
    80004cf2:	fa040613          	addi	a2,s0,-96
    80004cf6:	4901                	li	s2,0
    80004cf8:	b77d                	j	80004ca6 <virtio_disk_rw+0x94>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80004cfa:	fa042503          	lw	a0,-96(s0)
    80004cfe:	00451613          	slli	a2,a0,0x4

  if(write)
    80004d02:	00016797          	auipc	a5,0x16
    80004d06:	92e78793          	addi	a5,a5,-1746 # 8001a630 <disk>
    80004d0a:	00451713          	slli	a4,a0,0x4
    80004d0e:	0a070713          	addi	a4,a4,160
    80004d12:	973e                	add	a4,a4,a5
    80004d14:	016036b3          	snez	a3,s6
    80004d18:	c714                	sw	a3,8(a4)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80004d1a:	00072623          	sw	zero,12(a4)
  buf0->sector = sector;
    80004d1e:	01873823          	sd	s8,16(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80004d22:	6398                	ld	a4,0(a5)
    80004d24:	9732                	add	a4,a4,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80004d26:	0a860693          	addi	a3,a2,168
    80004d2a:	96be                	add	a3,a3,a5
  disk.desc[idx[0]].addr = (uint64) buf0;
    80004d2c:	e314                	sd	a3,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80004d2e:	6394                	ld	a3,0(a5)
    80004d30:	00c685b3          	add	a1,a3,a2
    80004d34:	4741                	li	a4,16
    80004d36:	c598                	sw	a4,8(a1)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80004d38:	4805                	li	a6,1
    80004d3a:	01059623          	sh	a6,12(a1)
  disk.desc[idx[0]].next = idx[1];
    80004d3e:	fa442703          	lw	a4,-92(s0)
    80004d42:	00e59723          	sh	a4,14(a1)

  disk.desc[idx[1]].addr = (uint64) b->data;
    80004d46:	0712                	slli	a4,a4,0x4
    80004d48:	96ba                	add	a3,a3,a4
    80004d4a:	06098593          	addi	a1,s3,96
    80004d4e:	e28c                	sd	a1,0(a3)
  disk.desc[idx[1]].len = BSIZE;
    80004d50:	0007b883          	ld	a7,0(a5)
    80004d54:	9746                	add	a4,a4,a7
    80004d56:	40000693          	li	a3,1024
    80004d5a:	c714                	sw	a3,8(a4)
  if(write)
    80004d5c:	001b3693          	seqz	a3,s6
    80004d60:	0016969b          	slliw	a3,a3,0x1
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80004d64:	0106e6b3          	or	a3,a3,a6
    80004d68:	00d71623          	sh	a3,12(a4)
  disk.desc[idx[1]].next = idx[2];
    80004d6c:	fa842583          	lw	a1,-88(s0)
    80004d70:	00b71723          	sh	a1,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80004d74:	00250693          	addi	a3,a0,2
    80004d78:	0692                	slli	a3,a3,0x4
    80004d7a:	96be                	add	a3,a3,a5
    80004d7c:	577d                	li	a4,-1
    80004d7e:	00e68823          	sb	a4,16(a3)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80004d82:	0592                	slli	a1,a1,0x4
    80004d84:	98ae                	add	a7,a7,a1
    80004d86:	03060713          	addi	a4,a2,48
    80004d8a:	973e                	add	a4,a4,a5
    80004d8c:	00e8b023          	sd	a4,0(a7)
  disk.desc[idx[2]].len = 1;
    80004d90:	6398                	ld	a4,0(a5)
    80004d92:	972e                	add	a4,a4,a1
    80004d94:	01072423          	sw	a6,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80004d98:	4609                	li	a2,2
    80004d9a:	00c71623          	sh	a2,12(a4)
  disk.desc[idx[2]].next = 0;
    80004d9e:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80004da2:	0109a223          	sw	a6,4(s3)
  disk.info[idx[0]].b = b;
    80004da6:	0136b423          	sd	s3,8(a3)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80004daa:	6794                	ld	a3,8(a5)
    80004dac:	0026d703          	lhu	a4,2(a3)
    80004db0:	8b1d                	andi	a4,a4,7
    80004db2:	0706                	slli	a4,a4,0x1
    80004db4:	96ba                	add	a3,a3,a4
    80004db6:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    80004dba:	0330000f          	fence	rw,rw

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80004dbe:	6798                	ld	a4,8(a5)
    80004dc0:	00275783          	lhu	a5,2(a4)
    80004dc4:	2785                	addiw	a5,a5,1
    80004dc6:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80004dca:	0330000f          	fence	rw,rw

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80004dce:	100017b7          	lui	a5,0x10001
    80004dd2:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80004dd6:	0049a783          	lw	a5,4(s3)
    80004dda:	01079f63          	bne	a5,a6,80004df8 <virtio_disk_rw+0x1e6>
    sleep(b, &disk.vdisk_lock);
    80004dde:	00016917          	auipc	s2,0x16
    80004de2:	97a90913          	addi	s2,s2,-1670 # 8001a758 <disk+0x128>
  while(b->disk == 1) {
    80004de6:	84be                	mv	s1,a5
    sleep(b, &disk.vdisk_lock);
    80004de8:	85ca                	mv	a1,s2
    80004dea:	854e                	mv	a0,s3
    80004dec:	e7efc0ef          	jal	8000146a <sleep>
  while(b->disk == 1) {
    80004df0:	0049a783          	lw	a5,4(s3)
    80004df4:	fe978ae3          	beq	a5,s1,80004de8 <virtio_disk_rw+0x1d6>
  }

  disk.info[idx[0]].b = 0;
    80004df8:	fa042903          	lw	s2,-96(s0)
    80004dfc:	00290713          	addi	a4,s2,2
    80004e00:	0712                	slli	a4,a4,0x4
    80004e02:	00016797          	auipc	a5,0x16
    80004e06:	82e78793          	addi	a5,a5,-2002 # 8001a630 <disk>
    80004e0a:	97ba                	add	a5,a5,a4
    80004e0c:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    80004e10:	00016997          	auipc	s3,0x16
    80004e14:	82098993          	addi	s3,s3,-2016 # 8001a630 <disk>
    80004e18:	00491713          	slli	a4,s2,0x4
    80004e1c:	0009b783          	ld	a5,0(s3)
    80004e20:	97ba                	add	a5,a5,a4
    80004e22:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80004e26:	854a                	mv	a0,s2
    80004e28:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80004e2c:	bb7ff0ef          	jal	800049e2 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80004e30:	8885                	andi	s1,s1,1
    80004e32:	f0fd                	bnez	s1,80004e18 <virtio_disk_rw+0x206>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80004e34:	00016517          	auipc	a0,0x16
    80004e38:	92450513          	addi	a0,a0,-1756 # 8001a758 <disk+0x128>
    80004e3c:	09a010ef          	jal	80005ed6 <release>
}
    80004e40:	60e6                	ld	ra,88(sp)
    80004e42:	6446                	ld	s0,80(sp)
    80004e44:	64a6                	ld	s1,72(sp)
    80004e46:	6906                	ld	s2,64(sp)
    80004e48:	79e2                	ld	s3,56(sp)
    80004e4a:	7a42                	ld	s4,48(sp)
    80004e4c:	7aa2                	ld	s5,40(sp)
    80004e4e:	7b02                	ld	s6,32(sp)
    80004e50:	6be2                	ld	s7,24(sp)
    80004e52:	6c42                	ld	s8,16(sp)
    80004e54:	6125                	addi	sp,sp,96
    80004e56:	8082                	ret

0000000080004e58 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80004e58:	1101                	addi	sp,sp,-32
    80004e5a:	ec06                	sd	ra,24(sp)
    80004e5c:	e822                	sd	s0,16(sp)
    80004e5e:	e426                	sd	s1,8(sp)
    80004e60:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80004e62:	00015497          	auipc	s1,0x15
    80004e66:	7ce48493          	addi	s1,s1,1998 # 8001a630 <disk>
    80004e6a:	00016517          	auipc	a0,0x16
    80004e6e:	8ee50513          	addi	a0,a0,-1810 # 8001a758 <disk+0x128>
    80004e72:	729000ef          	jal	80005d9a <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80004e76:	100017b7          	lui	a5,0x10001
    80004e7a:	53bc                	lw	a5,96(a5)
    80004e7c:	8b8d                	andi	a5,a5,3
    80004e7e:	10001737          	lui	a4,0x10001
    80004e82:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80004e84:	0330000f          	fence	rw,rw

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80004e88:	689c                	ld	a5,16(s1)
    80004e8a:	0204d703          	lhu	a4,32(s1)
    80004e8e:	0027d783          	lhu	a5,2(a5) # 10001002 <_entry-0x6fffeffe>
    80004e92:	04f70663          	beq	a4,a5,80004ede <virtio_disk_intr+0x86>
    __sync_synchronize();
    80004e96:	0330000f          	fence	rw,rw
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80004e9a:	6898                	ld	a4,16(s1)
    80004e9c:	0204d783          	lhu	a5,32(s1)
    80004ea0:	8b9d                	andi	a5,a5,7
    80004ea2:	078e                	slli	a5,a5,0x3
    80004ea4:	97ba                	add	a5,a5,a4
    80004ea6:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80004ea8:	00278713          	addi	a4,a5,2
    80004eac:	0712                	slli	a4,a4,0x4
    80004eae:	9726                	add	a4,a4,s1
    80004eb0:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    80004eb4:	e321                	bnez	a4,80004ef4 <virtio_disk_intr+0x9c>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80004eb6:	0789                	addi	a5,a5,2
    80004eb8:	0792                	slli	a5,a5,0x4
    80004eba:	97a6                	add	a5,a5,s1
    80004ebc:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    80004ebe:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80004ec2:	df4fc0ef          	jal	800014b6 <wakeup>

    disk.used_idx += 1;
    80004ec6:	0204d783          	lhu	a5,32(s1)
    80004eca:	2785                	addiw	a5,a5,1
    80004ecc:	17c2                	slli	a5,a5,0x30
    80004ece:	93c1                	srli	a5,a5,0x30
    80004ed0:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80004ed4:	6898                	ld	a4,16(s1)
    80004ed6:	00275703          	lhu	a4,2(a4)
    80004eda:	faf71ee3          	bne	a4,a5,80004e96 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80004ede:	00016517          	auipc	a0,0x16
    80004ee2:	87a50513          	addi	a0,a0,-1926 # 8001a758 <disk+0x128>
    80004ee6:	7f1000ef          	jal	80005ed6 <release>
}
    80004eea:	60e2                	ld	ra,24(sp)
    80004eec:	6442                	ld	s0,16(sp)
    80004eee:	64a2                	ld	s1,8(sp)
    80004ef0:	6105                	addi	sp,sp,32
    80004ef2:	8082                	ret
      panic("virtio_disk_intr status");
    80004ef4:	00003517          	auipc	a0,0x3
    80004ef8:	7bc50513          	addi	a0,a0,1980 # 800086b0 <etext+0x6b0>
    80004efc:	363000ef          	jal	80005a5e <panic>

0000000080004f00 <statswrite>:
int statscopyin(char*, int);
int statslock(char*, int);
  
int
statswrite(int user_src, uint64 src, int n)
{
    80004f00:	1141                	addi	sp,sp,-16
    80004f02:	e406                	sd	ra,8(sp)
    80004f04:	e022                	sd	s0,0(sp)
    80004f06:	0800                	addi	s0,sp,16
  return -1;
}
    80004f08:	557d                	li	a0,-1
    80004f0a:	60a2                	ld	ra,8(sp)
    80004f0c:	6402                	ld	s0,0(sp)
    80004f0e:	0141                	addi	sp,sp,16
    80004f10:	8082                	ret

0000000080004f12 <statsread>:

int
statsread(int user_dst, uint64 dst, int n)
{
    80004f12:	7179                	addi	sp,sp,-48
    80004f14:	f406                	sd	ra,40(sp)
    80004f16:	f022                	sd	s0,32(sp)
    80004f18:	ec26                	sd	s1,24(sp)
    80004f1a:	e44e                	sd	s3,8(sp)
    80004f1c:	e052                	sd	s4,0(sp)
    80004f1e:	1800                	addi	s0,sp,48
    80004f20:	89aa                	mv	s3,a0
    80004f22:	8a2e                	mv	s4,a1
    80004f24:	84b2                	mv	s1,a2
  int m;

  acquire(&stats.lock);
    80004f26:	00016517          	auipc	a0,0x16
    80004f2a:	94250513          	addi	a0,a0,-1726 # 8001a868 <stats>
    80004f2e:	66d000ef          	jal	80005d9a <acquire>

  if(stats.sz == 0) {
    80004f32:	00017797          	auipc	a5,0x17
    80004f36:	9567a783          	lw	a5,-1706(a5) # 8001b888 <stats+0x1020>
    80004f3a:	c7b5                	beqz	a5,80004fa6 <statsread+0x94>
#endif
#ifdef LAB_LOCK
    stats.sz = statslock(stats.buf, BUFSZ);
#endif
  }
  m = stats.sz - stats.off;
    80004f3c:	00017797          	auipc	a5,0x17
    80004f40:	92c78793          	addi	a5,a5,-1748 # 8001b868 <stats+0x1000>
    80004f44:	53d8                	lw	a4,36(a5)
    80004f46:	539c                	lw	a5,32(a5)
    80004f48:	9f99                	subw	a5,a5,a4

  if (m > 0) {
    80004f4a:	06f05a63          	blez	a5,80004fbe <statsread+0xac>
    80004f4e:	e84a                	sd	s2,16(sp)
    if(m > n)
    80004f50:	86be                	mv	a3,a5
    80004f52:	00f4d363          	bge	s1,a5,80004f58 <statsread+0x46>
    80004f56:	86a6                	mv	a3,s1
    80004f58:	8936                	mv	s2,a3
    80004f5a:	0006849b          	sext.w	s1,a3
      m  = n;
    if(either_copyout(user_dst, dst, stats.buf+stats.off, m) != -1) {
    80004f5e:	86a6                	mv	a3,s1
    80004f60:	00016617          	auipc	a2,0x16
    80004f64:	92860613          	addi	a2,a2,-1752 # 8001a888 <stats+0x20>
    80004f68:	963a                	add	a2,a2,a4
    80004f6a:	85d2                	mv	a1,s4
    80004f6c:	854e                	mv	a0,s3
    80004f6e:	855fc0ef          	jal	800017c2 <either_copyout>
    80004f72:	57fd                	li	a5,-1
    80004f74:	04f50f63          	beq	a0,a5,80004fd2 <statsread+0xc0>
      stats.off += m;
    80004f78:	00017717          	auipc	a4,0x17
    80004f7c:	8f070713          	addi	a4,a4,-1808 # 8001b868 <stats+0x1000>
    80004f80:	535c                	lw	a5,36(a4)
    80004f82:	00f907bb          	addw	a5,s2,a5
    80004f86:	d35c                	sw	a5,36(a4)
    80004f88:	6942                	ld	s2,16(sp)
  } else {
    m = -1;
    stats.sz = 0;
    stats.off = 0;
  }
  release(&stats.lock);
    80004f8a:	00016517          	auipc	a0,0x16
    80004f8e:	8de50513          	addi	a0,a0,-1826 # 8001a868 <stats>
    80004f92:	745000ef          	jal	80005ed6 <release>
  return m;
}
    80004f96:	8526                	mv	a0,s1
    80004f98:	70a2                	ld	ra,40(sp)
    80004f9a:	7402                	ld	s0,32(sp)
    80004f9c:	64e2                	ld	s1,24(sp)
    80004f9e:	69a2                	ld	s3,8(sp)
    80004fa0:	6a02                	ld	s4,0(sp)
    80004fa2:	6145                	addi	sp,sp,48
    80004fa4:	8082                	ret
    stats.sz = statslock(stats.buf, BUFSZ);
    80004fa6:	6585                	lui	a1,0x1
    80004fa8:	00016517          	auipc	a0,0x16
    80004fac:	8e050513          	addi	a0,a0,-1824 # 8001a888 <stats+0x20>
    80004fb0:	5a4010ef          	jal	80006554 <statslock>
    80004fb4:	00017797          	auipc	a5,0x17
    80004fb8:	8ca7aa23          	sw	a0,-1836(a5) # 8001b888 <stats+0x1020>
    80004fbc:	b741                	j	80004f3c <statsread+0x2a>
    stats.sz = 0;
    80004fbe:	00017797          	auipc	a5,0x17
    80004fc2:	8aa78793          	addi	a5,a5,-1878 # 8001b868 <stats+0x1000>
    80004fc6:	0207a023          	sw	zero,32(a5)
    stats.off = 0;
    80004fca:	0207a223          	sw	zero,36(a5)
    m = -1;
    80004fce:	54fd                	li	s1,-1
    80004fd0:	bf6d                	j	80004f8a <statsread+0x78>
    80004fd2:	6942                	ld	s2,16(sp)
    80004fd4:	bf5d                	j	80004f8a <statsread+0x78>

0000000080004fd6 <statsinit>:

void
statsinit(void)
{
    80004fd6:	1141                	addi	sp,sp,-16
    80004fd8:	e406                	sd	ra,8(sp)
    80004fda:	e022                	sd	s0,0(sp)
    80004fdc:	0800                	addi	s0,sp,16
  initlock(&stats.lock, "stats");
    80004fde:	00003597          	auipc	a1,0x3
    80004fe2:	6ea58593          	addi	a1,a1,1770 # 800086c8 <etext+0x6c8>
    80004fe6:	00016517          	auipc	a0,0x16
    80004fea:	88250513          	addi	a0,a0,-1918 # 8001a868 <stats>
    80004fee:	781000ef          	jal	80005f6e <initlock>

  devsw[STATS].read = statsread;
    80004ff2:	00014797          	auipc	a5,0x14
    80004ff6:	5de78793          	addi	a5,a5,1502 # 800195d0 <devsw>
    80004ffa:	00000717          	auipc	a4,0x0
    80004ffe:	f1870713          	addi	a4,a4,-232 # 80004f12 <statsread>
    80005002:	f398                	sd	a4,32(a5)
  devsw[STATS].write = statswrite;
    80005004:	00000717          	auipc	a4,0x0
    80005008:	efc70713          	addi	a4,a4,-260 # 80004f00 <statswrite>
    8000500c:	f798                	sd	a4,40(a5)
}
    8000500e:	60a2                	ld	ra,8(sp)
    80005010:	6402                	ld	s0,0(sp)
    80005012:	0141                	addi	sp,sp,16
    80005014:	8082                	ret

0000000080005016 <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
    80005016:	1101                	addi	sp,sp,-32
    80005018:	ec06                	sd	ra,24(sp)
    8000501a:	e822                	sd	s0,16(sp)
    8000501c:	1000                	addi	s0,sp,32
    8000501e:	88aa                	mv	a7,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
    80005020:	c299                	beqz	a3,80005026 <sprintint+0x10>
    80005022:	0805c163          	bltz	a1,800050a4 <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
    80005026:	4e81                	li	t4,0

  i = 0;
    80005028:	fe040693          	addi	a3,s0,-32
    x = xx;
    8000502c:	8736                	mv	a4,a3
  i = 0;
    8000502e:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
    80005030:	00004317          	auipc	t1,0x4
    80005034:	c5830313          	addi	t1,t1,-936 # 80008c88 <digits>
    80005038:	8e2a                	mv	t3,a0
    8000503a:	0015081b          	addiw	a6,a0,1
    8000503e:	8542                	mv	a0,a6
    80005040:	02c5f7bb          	remuw	a5,a1,a2
    80005044:	1782                	slli	a5,a5,0x20
    80005046:	9381                	srli	a5,a5,0x20
    80005048:	979a                	add	a5,a5,t1
    8000504a:	0007c783          	lbu	a5,0(a5)
    8000504e:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
    80005052:	87ae                	mv	a5,a1
    80005054:	02c5d5bb          	divuw	a1,a1,a2
    80005058:	0705                	addi	a4,a4,1
    8000505a:	fcc7ffe3          	bgeu	a5,a2,80005038 <sprintint+0x22>

  if(sign)
    8000505e:	000e8b63          	beqz	t4,80005074 <sprintint+0x5e>
    buf[i++] = '-';
    80005062:	ff040793          	addi	a5,s0,-16
    80005066:	983e                	add	a6,a6,a5
    80005068:	02d00793          	li	a5,45
    8000506c:	fef80823          	sb	a5,-16(a6)
    80005070:	002e051b          	addiw	a0,t3,2

  n = 0;
  while(--i >= 0)
    80005074:	02a05c63          	blez	a0,800050ac <sprintint+0x96>
    80005078:	fff5059b          	addiw	a1,a0,-1
    8000507c:	00b68733          	add	a4,a3,a1
    80005080:	87c6                	mv	a5,a7
    80005082:	00188613          	addi	a2,a7,1
    80005086:	1582                	slli	a1,a1,0x20
    80005088:	9181                	srli	a1,a1,0x20
    8000508a:	962e                	add	a2,a2,a1
  *s = c;
    8000508c:	00074683          	lbu	a3,0(a4)
    80005090:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
    80005094:	177d                	addi	a4,a4,-1
    80005096:	0785                	addi	a5,a5,1
    80005098:	fec79ae3          	bne	a5,a2,8000508c <sprintint+0x76>
    n += sputc(s+n, buf[i]);
  return n;
}
    8000509c:	60e2                	ld	ra,24(sp)
    8000509e:	6442                	ld	s0,16(sp)
    800050a0:	6105                	addi	sp,sp,32
    800050a2:	8082                	ret
    x = -xx;
    800050a4:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
    800050a8:	4e85                	li	t4,1
    x = -xx;
    800050aa:	bfbd                	j	80005028 <sprintint+0x12>
  n = 0;
    800050ac:	4501                	li	a0,0
    800050ae:	b7fd                	j	8000509c <sprintint+0x86>

00000000800050b0 <snprintf>:

int
snprintf(char *buf, unsigned long sz, const char *fmt, ...)
{
    800050b0:	7135                	addi	sp,sp,-160
    800050b2:	f486                	sd	ra,104(sp)
    800050b4:	f0a2                	sd	s0,96(sp)
    800050b6:	eca6                	sd	s1,88(sp)
    800050b8:	1880                	addi	s0,sp,112
    800050ba:	e414                	sd	a3,8(s0)
    800050bc:	e818                	sd	a4,16(s0)
    800050be:	ec1c                	sd	a5,24(s0)
    800050c0:	03043023          	sd	a6,32(s0)
    800050c4:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  va_start(ap, fmt);
    800050c8:	00840793          	addi	a5,s0,8
    800050cc:	f8f43c23          	sd	a5,-104(s0)
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
    800050d0:	c995                	beqz	a1,80005104 <snprintf+0x54>
    800050d2:	e8ca                	sd	s2,80(sp)
    800050d4:	e4ce                	sd	s3,72(sp)
    800050d6:	e0d2                	sd	s4,64(sp)
    800050d8:	fc56                	sd	s5,56(sp)
    800050da:	f85a                	sd	s6,48(sp)
    800050dc:	f45e                	sd	s7,40(sp)
    800050de:	f062                	sd	s8,32(sp)
    800050e0:	ec66                	sd	s9,24(sp)
    800050e2:	e86a                	sd	s10,16(sp)
    800050e4:	8a2a                	mv	s4,a0
    800050e6:	89ae                	mv	s3,a1
    800050e8:	8ab2                	mv	s5,a2
    800050ea:	4481                	li	s1,0
    800050ec:	4901                	li	s2,0
    800050ee:	4501                	li	a0,0
    if(c != '%'){
    800050f0:	02500b13          	li	s6,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    800050f4:	07300b93          	li	s7,115
    800050f8:	07800d13          	li	s10,120
    case 'd':
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
      break;
    case 'x':
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
    800050fc:	4c05                	li	s8,1
    switch(c){
    800050fe:	06400c93          	li	s9,100
    80005102:	a819                	j	80005118 <snprintf+0x68>
  int off = 0;
    80005104:	4481                	li	s1,0
    80005106:	a8d9                	j	800051dc <snprintf+0x12c>
  *s = c;
    80005108:	9552                	add	a0,a0,s4
    8000510a:	00f50023          	sb	a5,0(a0)
      off += sputc(buf+off, c);
    8000510e:	2485                	addiw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
    80005110:	2905                	addiw	s2,s2,1
    80005112:	8526                	mv	a0,s1
    80005114:	1134fd63          	bgeu	s1,s3,8000522e <snprintf+0x17e>
    80005118:	012a87b3          	add	a5,s5,s2
    8000511c:	0007c783          	lbu	a5,0(a5)
    80005120:	0007871b          	sext.w	a4,a5
    80005124:	c3ed                	beqz	a5,80005206 <snprintf+0x156>
    if(c != '%'){
    80005126:	ff6711e3          	bne	a4,s6,80005108 <snprintf+0x58>
    c = fmt[++i] & 0xff;
    8000512a:	0019079b          	addiw	a5,s2,1
    8000512e:	893e                	mv	s2,a5
    80005130:	97d6                	add	a5,a5,s5
    80005132:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
    80005136:	c3f5                	beqz	a5,8000521a <snprintf+0x16a>
    switch(c){
    80005138:	05778663          	beq	a5,s7,80005184 <snprintf+0xd4>
    8000513c:	02fbe463          	bltu	s7,a5,80005164 <snprintf+0xb4>
    80005140:	0b678463          	beq	a5,s6,800051e8 <snprintf+0x138>
    80005144:	0b979763          	bne	a5,s9,800051f2 <snprintf+0x142>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
    80005148:	f9843783          	ld	a5,-104(s0)
    8000514c:	00878713          	addi	a4,a5,8
    80005150:	f8e43c23          	sd	a4,-104(s0)
    80005154:	86e2                	mv	a3,s8
    80005156:	4629                	li	a2,10
    80005158:	438c                	lw	a1,0(a5)
    8000515a:	9552                	add	a0,a0,s4
    8000515c:	ebbff0ef          	jal	80005016 <sprintint>
    80005160:	9ca9                	addw	s1,s1,a0
      break;
    80005162:	b77d                	j	80005110 <snprintf+0x60>
    switch(c){
    80005164:	09a79763          	bne	a5,s10,800051f2 <snprintf+0x142>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
    80005168:	f9843783          	ld	a5,-104(s0)
    8000516c:	00878713          	addi	a4,a5,8
    80005170:	f8e43c23          	sd	a4,-104(s0)
    80005174:	86e2                	mv	a3,s8
    80005176:	4641                	li	a2,16
    80005178:	438c                	lw	a1,0(a5)
    8000517a:	9552                	add	a0,a0,s4
    8000517c:	e9bff0ef          	jal	80005016 <sprintint>
    80005180:	9ca9                	addw	s1,s1,a0
      break;
    80005182:	b779                	j	80005110 <snprintf+0x60>
    case 's':
      if((s = va_arg(ap, char*)) == 0)
    80005184:	f9843783          	ld	a5,-104(s0)
    80005188:	00878713          	addi	a4,a5,8
    8000518c:	f8e43c23          	sd	a4,-104(s0)
    80005190:	639c                	ld	a5,0(a5)
    80005192:	c785                	beqz	a5,800051ba <snprintf+0x10a>
        s = "(null)";
      for(; *s && off < sz; s++)
    80005194:	0007c703          	lbu	a4,0(a5)
    80005198:	df25                	beqz	a4,80005110 <snprintf+0x60>
    8000519a:	0334f763          	bgeu	s1,s3,800051c8 <snprintf+0x118>
  *s = c;
    8000519e:	009a06b3          	add	a3,s4,s1
    800051a2:	00e68023          	sb	a4,0(a3)
      for(; *s && off < sz; s++)
    800051a6:	0785                	addi	a5,a5,1
    800051a8:	0007c703          	lbu	a4,0(a5)
    800051ac:	00148693          	addi	a3,s1,1
    800051b0:	c319                	beqz	a4,800051b6 <snprintf+0x106>
    800051b2:	84b6                	mv	s1,a3
    800051b4:	b7dd                	j	8000519a <snprintf+0xea>
        off += sputc(buf+off, *s);
    800051b6:	2485                	addiw	s1,s1,1
    800051b8:	bfa1                	j	80005110 <snprintf+0x60>
        s = "(null)";
    800051ba:	00003797          	auipc	a5,0x3
    800051be:	51678793          	addi	a5,a5,1302 # 800086d0 <etext+0x6d0>
      for(; *s && off < sz; s++)
    800051c2:	02800713          	li	a4,40
    800051c6:	bfd1                	j	8000519a <snprintf+0xea>
    800051c8:	2481                	sext.w	s1,s1
    800051ca:	6946                	ld	s2,80(sp)
    800051cc:	69a6                	ld	s3,72(sp)
    800051ce:	6a06                	ld	s4,64(sp)
    800051d0:	7ae2                	ld	s5,56(sp)
    800051d2:	7b42                	ld	s6,48(sp)
    800051d4:	7ba2                	ld	s7,40(sp)
    800051d6:	7c02                	ld	s8,32(sp)
    800051d8:	6ce2                	ld	s9,24(sp)
    800051da:	6d42                	ld	s10,16(sp)
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
}
    800051dc:	8526                	mv	a0,s1
    800051de:	70a6                	ld	ra,104(sp)
    800051e0:	7406                	ld	s0,96(sp)
    800051e2:	64e6                	ld	s1,88(sp)
    800051e4:	610d                	addi	sp,sp,160
    800051e6:	8082                	ret
  *s = c;
    800051e8:	9552                	add	a0,a0,s4
    800051ea:	01650023          	sb	s6,0(a0)
      off += sputc(buf+off, '%');
    800051ee:	2485                	addiw	s1,s1,1
      break;
    800051f0:	b705                	j	80005110 <snprintf+0x60>
  *s = c;
    800051f2:	9552                	add	a0,a0,s4
    800051f4:	01650023          	sb	s6,0(a0)
      off += sputc(buf+off, '%');
    800051f8:	0014871b          	addiw	a4,s1,1
  *s = c;
    800051fc:	9752                	add	a4,a4,s4
    800051fe:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
    80005202:	2489                	addiw	s1,s1,2
      break;
    80005204:	b731                	j	80005110 <snprintf+0x60>
    80005206:	6946                	ld	s2,80(sp)
    80005208:	69a6                	ld	s3,72(sp)
    8000520a:	6a06                	ld	s4,64(sp)
    8000520c:	7ae2                	ld	s5,56(sp)
    8000520e:	7b42                	ld	s6,48(sp)
    80005210:	7ba2                	ld	s7,40(sp)
    80005212:	7c02                	ld	s8,32(sp)
    80005214:	6ce2                	ld	s9,24(sp)
    80005216:	6d42                	ld	s10,16(sp)
    80005218:	b7d1                	j	800051dc <snprintf+0x12c>
    8000521a:	6946                	ld	s2,80(sp)
    8000521c:	69a6                	ld	s3,72(sp)
    8000521e:	6a06                	ld	s4,64(sp)
    80005220:	7ae2                	ld	s5,56(sp)
    80005222:	7b42                	ld	s6,48(sp)
    80005224:	7ba2                	ld	s7,40(sp)
    80005226:	7c02                	ld	s8,32(sp)
    80005228:	6ce2                	ld	s9,24(sp)
    8000522a:	6d42                	ld	s10,16(sp)
    8000522c:	bf45                	j	800051dc <snprintf+0x12c>
    8000522e:	6946                	ld	s2,80(sp)
    80005230:	69a6                	ld	s3,72(sp)
    80005232:	6a06                	ld	s4,64(sp)
    80005234:	7ae2                	ld	s5,56(sp)
    80005236:	7b42                	ld	s6,48(sp)
    80005238:	7ba2                	ld	s7,40(sp)
    8000523a:	7c02                	ld	s8,32(sp)
    8000523c:	6ce2                	ld	s9,24(sp)
    8000523e:	6d42                	ld	s10,16(sp)
    80005240:	bf71                	j	800051dc <snprintf+0x12c>

0000000080005242 <timerinit>:
}

// ask each hart to generate timer interrupts.
void
timerinit()
{
    80005242:	1141                	addi	sp,sp,-16
    80005244:	e406                	sd	ra,8(sp)
    80005246:	e022                	sd	s0,0(sp)
    80005248:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mie" : "=r" (x) );
    8000524a:	304027f3          	csrr	a5,mie
  // enable supervisor-mode timer interrupts.
  w_mie(r_mie() | MIE_STIE);
    8000524e:	0207e793          	ori	a5,a5,32
  asm volatile("csrw mie, %0" : : "r" (x));
    80005252:	30479073          	csrw	mie,a5
  asm volatile("csrr %0, 0x30a" : "=r" (x) );
    80005256:	30a027f3          	csrr	a5,0x30a
  
  // enable the sstc extension (i.e. stimecmp).
  w_menvcfg(r_menvcfg() | (1L << 63)); 
    8000525a:	577d                	li	a4,-1
    8000525c:	177e                	slli	a4,a4,0x3f
    8000525e:	8fd9                	or	a5,a5,a4
  asm volatile("csrw 0x30a, %0" : : "r" (x));
    80005260:	30a79073          	csrw	0x30a,a5
  asm volatile("csrr %0, mcounteren" : "=r" (x) );
    80005264:	306027f3          	csrr	a5,mcounteren
  
  // allow supervisor to use stimecmp and time.
  w_mcounteren(r_mcounteren() | 2);
    80005268:	0027e793          	ori	a5,a5,2
  asm volatile("csrw mcounteren, %0" : : "r" (x));
    8000526c:	30679073          	csrw	mcounteren,a5
  asm volatile("csrr %0, time" : "=r" (x) );
    80005270:	c01027f3          	rdtime	a5
  
  // ask for the very first timer interrupt.
  w_stimecmp(r_time() + 1000000);
    80005274:	000f4737          	lui	a4,0xf4
    80005278:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    8000527c:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    8000527e:	14d79073          	csrw	stimecmp,a5
}
    80005282:	60a2                	ld	ra,8(sp)
    80005284:	6402                	ld	s0,0(sp)
    80005286:	0141                	addi	sp,sp,16
    80005288:	8082                	ret

000000008000528a <start>:
{
    8000528a:	1141                	addi	sp,sp,-16
    8000528c:	e406                	sd	ra,8(sp)
    8000528e:	e022                	sd	s0,0(sp)
    80005290:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005292:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80005296:	7779                	lui	a4,0xffffe
    80005298:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd9ebf>
    8000529c:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    8000529e:	6705                	lui	a4,0x1
    800052a0:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800052a4:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800052a6:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    800052aa:	ffffb797          	auipc	a5,0xffffb
    800052ae:	13878793          	addi	a5,a5,312 # 800003e2 <main>
    800052b2:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    800052b6:	4781                	li	a5,0
    800052b8:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800052bc:	67c1                	lui	a5,0x10
    800052be:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800052c0:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    800052c4:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    800052c8:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE);
    800052cc:	2207e793          	ori	a5,a5,544
  asm volatile("csrw sie, %0" : : "r" (x));
    800052d0:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    800052d4:	57fd                	li	a5,-1
    800052d6:	83a9                	srli	a5,a5,0xa
    800052d8:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    800052dc:	47bd                	li	a5,15
    800052de:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    800052e2:	f61ff0ef          	jal	80005242 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800052e6:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800052ea:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    800052ec:	823e                	mv	tp,a5
  asm volatile("mret");
    800052ee:	30200073          	mret
}
    800052f2:	60a2                	ld	ra,8(sp)
    800052f4:	6402                	ld	s0,0(sp)
    800052f6:	0141                	addi	sp,sp,16
    800052f8:	8082                	ret

00000000800052fa <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    800052fa:	7119                	addi	sp,sp,-128
    800052fc:	fc86                	sd	ra,120(sp)
    800052fe:	f8a2                	sd	s0,112(sp)
    80005300:	f4a6                	sd	s1,104(sp)
    80005302:	0100                	addi	s0,sp,128
  char buf[32];
  int i = 0;

  while(i < n){
    80005304:	06c05b63          	blez	a2,8000537a <consolewrite+0x80>
    80005308:	f0ca                	sd	s2,96(sp)
    8000530a:	ecce                	sd	s3,88(sp)
    8000530c:	e8d2                	sd	s4,80(sp)
    8000530e:	e4d6                	sd	s5,72(sp)
    80005310:	e0da                	sd	s6,64(sp)
    80005312:	fc5e                	sd	s7,56(sp)
    80005314:	f862                	sd	s8,48(sp)
    80005316:	f466                	sd	s9,40(sp)
    80005318:	f06a                	sd	s10,32(sp)
    8000531a:	8b2a                	mv	s6,a0
    8000531c:	8bae                	mv	s7,a1
    8000531e:	8a32                	mv	s4,a2
  int i = 0;
    80005320:	4481                	li	s1,0
    int nn = sizeof(buf);
    if(nn > n - i)
    80005322:	02000c93          	li	s9,32
    80005326:	02000d13          	li	s10,32
      nn = n - i;
    if(either_copyin(buf, user_src, src+i, nn) == -1)
    8000532a:	f8040a93          	addi	s5,s0,-128
    8000532e:	5c7d                	li	s8,-1
    80005330:	a025                	j	80005358 <consolewrite+0x5e>
    if(nn > n - i)
    80005332:	0009099b          	sext.w	s3,s2
    if(either_copyin(buf, user_src, src+i, nn) == -1)
    80005336:	86ce                	mv	a3,s3
    80005338:	01748633          	add	a2,s1,s7
    8000533c:	85da                	mv	a1,s6
    8000533e:	8556                	mv	a0,s5
    80005340:	cccfc0ef          	jal	8000180c <either_copyin>
    80005344:	03850d63          	beq	a0,s8,8000537e <consolewrite+0x84>
      break;
    uartwrite(buf, nn);
    80005348:	85ce                	mv	a1,s3
    8000534a:	8556                	mv	a0,s5
    8000534c:	7c8000ef          	jal	80005b14 <uartwrite>
    i += nn;
    80005350:	009904bb          	addw	s1,s2,s1
  while(i < n){
    80005354:	0144d963          	bge	s1,s4,80005366 <consolewrite+0x6c>
    if(nn > n - i)
    80005358:	409a07bb          	subw	a5,s4,s1
    8000535c:	893e                	mv	s2,a5
    8000535e:	fcfcdae3          	bge	s9,a5,80005332 <consolewrite+0x38>
    80005362:	896a                	mv	s2,s10
    80005364:	b7f9                	j	80005332 <consolewrite+0x38>
    80005366:	7906                	ld	s2,96(sp)
    80005368:	69e6                	ld	s3,88(sp)
    8000536a:	6a46                	ld	s4,80(sp)
    8000536c:	6aa6                	ld	s5,72(sp)
    8000536e:	6b06                	ld	s6,64(sp)
    80005370:	7be2                	ld	s7,56(sp)
    80005372:	7c42                	ld	s8,48(sp)
    80005374:	7ca2                	ld	s9,40(sp)
    80005376:	7d02                	ld	s10,32(sp)
    80005378:	a821                	j	80005390 <consolewrite+0x96>
  int i = 0;
    8000537a:	4481                	li	s1,0
    8000537c:	a811                	j	80005390 <consolewrite+0x96>
    8000537e:	7906                	ld	s2,96(sp)
    80005380:	69e6                	ld	s3,88(sp)
    80005382:	6a46                	ld	s4,80(sp)
    80005384:	6aa6                	ld	s5,72(sp)
    80005386:	6b06                	ld	s6,64(sp)
    80005388:	7be2                	ld	s7,56(sp)
    8000538a:	7c42                	ld	s8,48(sp)
    8000538c:	7ca2                	ld	s9,40(sp)
    8000538e:	7d02                	ld	s10,32(sp)
  }

  return i;
}
    80005390:	8526                	mv	a0,s1
    80005392:	70e6                	ld	ra,120(sp)
    80005394:	7446                	ld	s0,112(sp)
    80005396:	74a6                	ld	s1,104(sp)
    80005398:	6109                	addi	sp,sp,128
    8000539a:	8082                	ret

000000008000539c <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    8000539c:	711d                	addi	sp,sp,-96
    8000539e:	ec86                	sd	ra,88(sp)
    800053a0:	e8a2                	sd	s0,80(sp)
    800053a2:	e4a6                	sd	s1,72(sp)
    800053a4:	e0ca                	sd	s2,64(sp)
    800053a6:	fc4e                	sd	s3,56(sp)
    800053a8:	f852                	sd	s4,48(sp)
    800053aa:	f05a                	sd	s6,32(sp)
    800053ac:	ec5e                	sd	s7,24(sp)
    800053ae:	1080                	addi	s0,sp,96
    800053b0:	8b2a                	mv	s6,a0
    800053b2:	8a2e                	mv	s4,a1
    800053b4:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    800053b6:	8bb2                	mv	s7,a2
  acquire(&cons.lock);
    800053b8:	0001e517          	auipc	a0,0x1e
    800053bc:	4d850513          	addi	a0,a0,1240 # 80023890 <cons>
    800053c0:	1db000ef          	jal	80005d9a <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    800053c4:	0001e497          	auipc	s1,0x1e
    800053c8:	4cc48493          	addi	s1,s1,1228 # 80023890 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    800053cc:	0001e917          	auipc	s2,0x1e
    800053d0:	56490913          	addi	s2,s2,1380 # 80023930 <cons+0xa0>
  while(n > 0){
    800053d4:	0b305b63          	blez	s3,8000548a <consoleread+0xee>
    while(cons.r == cons.w){
    800053d8:	0a04a783          	lw	a5,160(s1)
    800053dc:	0a44a703          	lw	a4,164(s1)
    800053e0:	0af71063          	bne	a4,a5,80005480 <consoleread+0xe4>
      if(killed(myproc())){
    800053e4:	a51fb0ef          	jal	80000e34 <myproc>
    800053e8:	abefc0ef          	jal	800016a6 <killed>
    800053ec:	e12d                	bnez	a0,8000544e <consoleread+0xb2>
      sleep(&cons.r, &cons.lock);
    800053ee:	85a6                	mv	a1,s1
    800053f0:	854a                	mv	a0,s2
    800053f2:	878fc0ef          	jal	8000146a <sleep>
    while(cons.r == cons.w){
    800053f6:	0a04a783          	lw	a5,160(s1)
    800053fa:	0a44a703          	lw	a4,164(s1)
    800053fe:	fef703e3          	beq	a4,a5,800053e4 <consoleread+0x48>
    80005402:	f456                	sd	s5,40(sp)
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    80005404:	0001e717          	auipc	a4,0x1e
    80005408:	48c70713          	addi	a4,a4,1164 # 80023890 <cons>
    8000540c:	0017869b          	addiw	a3,a5,1
    80005410:	0ad72023          	sw	a3,160(a4)
    80005414:	07f7f693          	andi	a3,a5,127
    80005418:	9736                	add	a4,a4,a3
    8000541a:	02074703          	lbu	a4,32(a4)
    8000541e:	00070a9b          	sext.w	s5,a4

    if(c == C('D')){  // end-of-file
    80005422:	4691                	li	a3,4
    80005424:	04da8663          	beq	s5,a3,80005470 <consoleread+0xd4>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80005428:	fae407a3          	sb	a4,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    8000542c:	4685                	li	a3,1
    8000542e:	faf40613          	addi	a2,s0,-81
    80005432:	85d2                	mv	a1,s4
    80005434:	855a                	mv	a0,s6
    80005436:	b8cfc0ef          	jal	800017c2 <either_copyout>
    8000543a:	57fd                	li	a5,-1
    8000543c:	04f50663          	beq	a0,a5,80005488 <consoleread+0xec>
      break;

    dst++;
    80005440:	0a05                	addi	s4,s4,1
    --n;
    80005442:	39fd                	addiw	s3,s3,-1

    if(c == '\n'){
    80005444:	47a9                	li	a5,10
    80005446:	04fa8b63          	beq	s5,a5,8000549c <consoleread+0x100>
    8000544a:	7aa2                	ld	s5,40(sp)
    8000544c:	b761                	j	800053d4 <consoleread+0x38>
        release(&cons.lock);
    8000544e:	0001e517          	auipc	a0,0x1e
    80005452:	44250513          	addi	a0,a0,1090 # 80023890 <cons>
    80005456:	281000ef          	jal	80005ed6 <release>
        return -1;
    8000545a:	557d                	li	a0,-1
    }
  }
  release(&cons.lock);

  return target - n;
}
    8000545c:	60e6                	ld	ra,88(sp)
    8000545e:	6446                	ld	s0,80(sp)
    80005460:	64a6                	ld	s1,72(sp)
    80005462:	6906                	ld	s2,64(sp)
    80005464:	79e2                	ld	s3,56(sp)
    80005466:	7a42                	ld	s4,48(sp)
    80005468:	7b02                	ld	s6,32(sp)
    8000546a:	6be2                	ld	s7,24(sp)
    8000546c:	6125                	addi	sp,sp,96
    8000546e:	8082                	ret
      if(n < target){
    80005470:	0179fa63          	bgeu	s3,s7,80005484 <consoleread+0xe8>
        cons.r--;
    80005474:	0001e717          	auipc	a4,0x1e
    80005478:	4af72e23          	sw	a5,1212(a4) # 80023930 <cons+0xa0>
    8000547c:	7aa2                	ld	s5,40(sp)
    8000547e:	a031                	j	8000548a <consoleread+0xee>
    80005480:	f456                	sd	s5,40(sp)
    80005482:	b749                	j	80005404 <consoleread+0x68>
    80005484:	7aa2                	ld	s5,40(sp)
    80005486:	a011                	j	8000548a <consoleread+0xee>
    80005488:	7aa2                	ld	s5,40(sp)
  release(&cons.lock);
    8000548a:	0001e517          	auipc	a0,0x1e
    8000548e:	40650513          	addi	a0,a0,1030 # 80023890 <cons>
    80005492:	245000ef          	jal	80005ed6 <release>
  return target - n;
    80005496:	413b853b          	subw	a0,s7,s3
    8000549a:	b7c9                	j	8000545c <consoleread+0xc0>
    8000549c:	7aa2                	ld	s5,40(sp)
    8000549e:	b7f5                	j	8000548a <consoleread+0xee>

00000000800054a0 <consputc>:
{
    800054a0:	1141                	addi	sp,sp,-16
    800054a2:	e406                	sd	ra,8(sp)
    800054a4:	e022                	sd	s0,0(sp)
    800054a6:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    800054a8:	10000793          	li	a5,256
    800054ac:	00f50863          	beq	a0,a5,800054bc <consputc+0x1c>
    uartputc_sync(c);
    800054b0:	6f8000ef          	jal	80005ba8 <uartputc_sync>
}
    800054b4:	60a2                	ld	ra,8(sp)
    800054b6:	6402                	ld	s0,0(sp)
    800054b8:	0141                	addi	sp,sp,16
    800054ba:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    800054bc:	4521                	li	a0,8
    800054be:	6ea000ef          	jal	80005ba8 <uartputc_sync>
    800054c2:	02000513          	li	a0,32
    800054c6:	6e2000ef          	jal	80005ba8 <uartputc_sync>
    800054ca:	4521                	li	a0,8
    800054cc:	6dc000ef          	jal	80005ba8 <uartputc_sync>
    800054d0:	b7d5                	j	800054b4 <consputc+0x14>

00000000800054d2 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800054d2:	1101                	addi	sp,sp,-32
    800054d4:	ec06                	sd	ra,24(sp)
    800054d6:	e822                	sd	s0,16(sp)
    800054d8:	e426                	sd	s1,8(sp)
    800054da:	1000                	addi	s0,sp,32
    800054dc:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    800054de:	0001e517          	auipc	a0,0x1e
    800054e2:	3b250513          	addi	a0,a0,946 # 80023890 <cons>
    800054e6:	0b5000ef          	jal	80005d9a <acquire>

  switch(c){
    800054ea:	47d5                	li	a5,21
    800054ec:	0af48163          	beq	s1,a5,8000558e <consoleintr+0xbc>
    800054f0:	0297c563          	blt	a5,s1,8000551a <consoleintr+0x48>
    800054f4:	47a1                	li	a5,8
    800054f6:	0ef48663          	beq	s1,a5,800055e2 <consoleintr+0x110>
    800054fa:	47c1                	li	a5,16
    800054fc:	10f49763          	bne	s1,a5,8000560a <consoleintr+0x138>
  case C('P'):  // Print process list.
    procdump();
    80005500:	b56fc0ef          	jal	80001856 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005504:	0001e517          	auipc	a0,0x1e
    80005508:	38c50513          	addi	a0,a0,908 # 80023890 <cons>
    8000550c:	1cb000ef          	jal	80005ed6 <release>
}
    80005510:	60e2                	ld	ra,24(sp)
    80005512:	6442                	ld	s0,16(sp)
    80005514:	64a2                	ld	s1,8(sp)
    80005516:	6105                	addi	sp,sp,32
    80005518:	8082                	ret
  switch(c){
    8000551a:	07f00793          	li	a5,127
    8000551e:	0cf48263          	beq	s1,a5,800055e2 <consoleintr+0x110>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005522:	0001e717          	auipc	a4,0x1e
    80005526:	36e70713          	addi	a4,a4,878 # 80023890 <cons>
    8000552a:	0a872783          	lw	a5,168(a4)
    8000552e:	0a072703          	lw	a4,160(a4)
    80005532:	9f99                	subw	a5,a5,a4
    80005534:	07f00713          	li	a4,127
    80005538:	fcf766e3          	bltu	a4,a5,80005504 <consoleintr+0x32>
      c = (c == '\r') ? '\n' : c;
    8000553c:	47b5                	li	a5,13
    8000553e:	0cf48963          	beq	s1,a5,80005610 <consoleintr+0x13e>
      consputc(c);
    80005542:	8526                	mv	a0,s1
    80005544:	f5dff0ef          	jal	800054a0 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005548:	0001e717          	auipc	a4,0x1e
    8000554c:	34870713          	addi	a4,a4,840 # 80023890 <cons>
    80005550:	0a872683          	lw	a3,168(a4)
    80005554:	0016879b          	addiw	a5,a3,1
    80005558:	863e                	mv	a2,a5
    8000555a:	0af72423          	sw	a5,168(a4)
    8000555e:	07f6f693          	andi	a3,a3,127
    80005562:	9736                	add	a4,a4,a3
    80005564:	02970023          	sb	s1,32(a4)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80005568:	ff648713          	addi	a4,s1,-10
    8000556c:	00173713          	seqz	a4,a4
    80005570:	14f1                	addi	s1,s1,-4
    80005572:	0014b493          	seqz	s1,s1
    80005576:	8f45                	or	a4,a4,s1
    80005578:	e361                	bnez	a4,80005638 <consoleintr+0x166>
    8000557a:	0001e717          	auipc	a4,0x1e
    8000557e:	3b672703          	lw	a4,950(a4) # 80023930 <cons+0xa0>
    80005582:	9f99                	subw	a5,a5,a4
    80005584:	08000713          	li	a4,128
    80005588:	f6e79ee3          	bne	a5,a4,80005504 <consoleintr+0x32>
    8000558c:	a075                	j	80005638 <consoleintr+0x166>
    8000558e:	e04a                	sd	s2,0(sp)
    while(cons.e != cons.w &&
    80005590:	0001e717          	auipc	a4,0x1e
    80005594:	30070713          	addi	a4,a4,768 # 80023890 <cons>
    80005598:	0a872783          	lw	a5,168(a4)
    8000559c:	0a472703          	lw	a4,164(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    800055a0:	0001e497          	auipc	s1,0x1e
    800055a4:	2f048493          	addi	s1,s1,752 # 80023890 <cons>
    while(cons.e != cons.w &&
    800055a8:	4929                	li	s2,10
    800055aa:	02f70863          	beq	a4,a5,800055da <consoleintr+0x108>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    800055ae:	37fd                	addiw	a5,a5,-1
    800055b0:	07f7f713          	andi	a4,a5,127
    800055b4:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    800055b6:	02074703          	lbu	a4,32(a4)
    800055ba:	03270263          	beq	a4,s2,800055de <consoleintr+0x10c>
      cons.e--;
    800055be:	0af4a423          	sw	a5,168(s1)
      consputc(BACKSPACE);
    800055c2:	10000513          	li	a0,256
    800055c6:	edbff0ef          	jal	800054a0 <consputc>
    while(cons.e != cons.w &&
    800055ca:	0a84a783          	lw	a5,168(s1)
    800055ce:	0a44a703          	lw	a4,164(s1)
    800055d2:	fcf71ee3          	bne	a4,a5,800055ae <consoleintr+0xdc>
    800055d6:	6902                	ld	s2,0(sp)
    800055d8:	b735                	j	80005504 <consoleintr+0x32>
    800055da:	6902                	ld	s2,0(sp)
    800055dc:	b725                	j	80005504 <consoleintr+0x32>
    800055de:	6902                	ld	s2,0(sp)
    800055e0:	b715                	j	80005504 <consoleintr+0x32>
    if(cons.e != cons.w){
    800055e2:	0001e717          	auipc	a4,0x1e
    800055e6:	2ae70713          	addi	a4,a4,686 # 80023890 <cons>
    800055ea:	0a872783          	lw	a5,168(a4)
    800055ee:	0a472703          	lw	a4,164(a4)
    800055f2:	f0f709e3          	beq	a4,a5,80005504 <consoleintr+0x32>
      cons.e--;
    800055f6:	37fd                	addiw	a5,a5,-1
    800055f8:	0001e717          	auipc	a4,0x1e
    800055fc:	34f72023          	sw	a5,832(a4) # 80023938 <cons+0xa8>
      consputc(BACKSPACE);
    80005600:	10000513          	li	a0,256
    80005604:	e9dff0ef          	jal	800054a0 <consputc>
    80005608:	bdf5                	j	80005504 <consoleintr+0x32>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    8000560a:	ee048de3          	beqz	s1,80005504 <consoleintr+0x32>
    8000560e:	bf11                	j	80005522 <consoleintr+0x50>
      consputc(c);
    80005610:	4529                	li	a0,10
    80005612:	e8fff0ef          	jal	800054a0 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005616:	0001e797          	auipc	a5,0x1e
    8000561a:	27a78793          	addi	a5,a5,634 # 80023890 <cons>
    8000561e:	0a87a703          	lw	a4,168(a5)
    80005622:	0017069b          	addiw	a3,a4,1
    80005626:	8636                	mv	a2,a3
    80005628:	0ad7a423          	sw	a3,168(a5)
    8000562c:	07f77713          	andi	a4,a4,127
    80005630:	97ba                	add	a5,a5,a4
    80005632:	4729                	li	a4,10
    80005634:	02e78023          	sb	a4,32(a5)
        cons.w = cons.e;
    80005638:	0001e797          	auipc	a5,0x1e
    8000563c:	2ec7ae23          	sw	a2,764(a5) # 80023934 <cons+0xa4>
        wakeup(&cons.r);
    80005640:	0001e517          	auipc	a0,0x1e
    80005644:	2f050513          	addi	a0,a0,752 # 80023930 <cons+0xa0>
    80005648:	e6ffb0ef          	jal	800014b6 <wakeup>
    8000564c:	bd65                	j	80005504 <consoleintr+0x32>

000000008000564e <consoleinit>:

void
consoleinit(void)
{
    8000564e:	1141                	addi	sp,sp,-16
    80005650:	e406                	sd	ra,8(sp)
    80005652:	e022                	sd	s0,0(sp)
    80005654:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80005656:	00003597          	auipc	a1,0x3
    8000565a:	08258593          	addi	a1,a1,130 # 800086d8 <etext+0x6d8>
    8000565e:	0001e517          	auipc	a0,0x1e
    80005662:	23250513          	addi	a0,a0,562 # 80023890 <cons>
    80005666:	109000ef          	jal	80005f6e <initlock>

  uartinit();
    8000566a:	454000ef          	jal	80005abe <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    8000566e:	00014797          	auipc	a5,0x14
    80005672:	f6278793          	addi	a5,a5,-158 # 800195d0 <devsw>
    80005676:	00000717          	auipc	a4,0x0
    8000567a:	d2670713          	addi	a4,a4,-730 # 8000539c <consoleread>
    8000567e:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005680:	00000717          	auipc	a4,0x0
    80005684:	c7a70713          	addi	a4,a4,-902 # 800052fa <consolewrite>
    80005688:	ef98                	sd	a4,24(a5)
}
    8000568a:	60a2                	ld	ra,8(sp)
    8000568c:	6402                	ld	s0,0(sp)
    8000568e:	0141                	addi	sp,sp,16
    80005690:	8082                	ret

0000000080005692 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(long long xx, int base, int sign)
{
    80005692:	7139                	addi	sp,sp,-64
    80005694:	fc06                	sd	ra,56(sp)
    80005696:	f822                	sd	s0,48(sp)
    80005698:	f04a                	sd	s2,32(sp)
    8000569a:	0080                	addi	s0,sp,64
  char buf[20];
  int i;
  unsigned long long x;

  if(sign && (sign = (xx < 0)))
    8000569c:	c219                	beqz	a2,800056a2 <printint+0x10>
    8000569e:	08054063          	bltz	a0,8000571e <printint+0x8c>
    x = -xx;
  else
    x = xx;
    800056a2:	4301                	li	t1,0

  i = 0;
    800056a4:	fc840913          	addi	s2,s0,-56
    x = xx;
    800056a8:	86ca                	mv	a3,s2
  i = 0;
    800056aa:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800056ac:	00003817          	auipc	a6,0x3
    800056b0:	5f480813          	addi	a6,a6,1524 # 80008ca0 <digits>
    800056b4:	88ba                	mv	a7,a4
    800056b6:	0017061b          	addiw	a2,a4,1
    800056ba:	8732                	mv	a4,a2
    800056bc:	02b577b3          	remu	a5,a0,a1
    800056c0:	97c2                	add	a5,a5,a6
    800056c2:	0007c783          	lbu	a5,0(a5)
    800056c6:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    800056ca:	87aa                	mv	a5,a0
    800056cc:	02b55533          	divu	a0,a0,a1
    800056d0:	0685                	addi	a3,a3,1
    800056d2:	feb7f1e3          	bgeu	a5,a1,800056b4 <printint+0x22>

  if(sign)
    800056d6:	00030b63          	beqz	t1,800056ec <printint+0x5a>
    buf[i++] = '-';
    800056da:	fe040793          	addi	a5,s0,-32
    800056de:	963e                	add	a2,a2,a5
    800056e0:	02d00793          	li	a5,45
    800056e4:	fef60423          	sb	a5,-24(a2)
    800056e8:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
    800056ec:	02e05463          	blez	a4,80005714 <printint+0x82>
    800056f0:	f426                	sd	s1,40(sp)
    800056f2:	377d                	addiw	a4,a4,-1
    800056f4:	00e904b3          	add	s1,s2,a4
    800056f8:	197d                	addi	s2,s2,-1
    800056fa:	993a                	add	s2,s2,a4
    800056fc:	1702                	slli	a4,a4,0x20
    800056fe:	9301                	srli	a4,a4,0x20
    80005700:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80005704:	0004c503          	lbu	a0,0(s1)
    80005708:	d99ff0ef          	jal	800054a0 <consputc>
  while(--i >= 0)
    8000570c:	14fd                	addi	s1,s1,-1
    8000570e:	ff249be3          	bne	s1,s2,80005704 <printint+0x72>
    80005712:	74a2                	ld	s1,40(sp)
}
    80005714:	70e2                	ld	ra,56(sp)
    80005716:	7442                	ld	s0,48(sp)
    80005718:	7902                	ld	s2,32(sp)
    8000571a:	6121                	addi	sp,sp,64
    8000571c:	8082                	ret
    x = -xx;
    8000571e:	40a00533          	neg	a0,a0
  if(sign && (sign = (xx < 0)))
    80005722:	4305                	li	t1,1
    x = -xx;
    80005724:	b741                	j	800056a4 <printint+0x12>

0000000080005726 <printf>:
}

// Print to the console.
int
printf(char *fmt, ...)
{
    80005726:	7131                	addi	sp,sp,-192
    80005728:	fc86                	sd	ra,120(sp)
    8000572a:	f8a2                	sd	s0,112(sp)
    8000572c:	f4a6                	sd	s1,104(sp)
    8000572e:	0100                	addi	s0,sp,128
    80005730:	84aa                	mv	s1,a0
    80005732:	e40c                	sd	a1,8(s0)
    80005734:	e810                	sd	a2,16(s0)
    80005736:	ec14                	sd	a3,24(s0)
    80005738:	f018                	sd	a4,32(s0)
    8000573a:	f41c                	sd	a5,40(s0)
    8000573c:	03043823          	sd	a6,48(s0)
    80005740:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, cx, c0, c1, c2;
  char *s;

  if(panicking == 0)
    80005744:	00003797          	auipc	a5,0x3
    80005748:	5ac7a783          	lw	a5,1452(a5) # 80008cf0 <panicking>
    8000574c:	cf9d                	beqz	a5,8000578a <printf+0x64>
    acquire(&pr.lock);

  va_start(ap, fmt);
    8000574e:	00840793          	addi	a5,s0,8
    80005752:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    80005756:	0004c503          	lbu	a0,0(s1)
    8000575a:	22050363          	beqz	a0,80005980 <printf+0x25a>
    8000575e:	f0ca                	sd	s2,96(sp)
    80005760:	ecce                	sd	s3,88(sp)
    80005762:	e8d2                	sd	s4,80(sp)
    80005764:	e4d6                	sd	s5,72(sp)
    80005766:	e0da                	sd	s6,64(sp)
    80005768:	fc5e                	sd	s7,56(sp)
    8000576a:	f862                	sd	s8,48(sp)
    8000576c:	f06a                	sd	s10,32(sp)
    8000576e:	ec6e                	sd	s11,24(sp)
    80005770:	4a01                	li	s4,0
    if(cx != '%'){
    80005772:	02500993          	li	s3,37
      printint(va_arg(ap, uint64), 10, 1);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
      printint(va_arg(ap, uint64), 10, 1);
      i += 2;
    } else if(c0 == 'u'){
    80005776:	07500c13          	li	s8,117
      printint(va_arg(ap, uint64), 10, 0);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
      printint(va_arg(ap, uint64), 10, 0);
      i += 2;
    } else if(c0 == 'x'){
    8000577a:	07800d13          	li	s10,120
      printint(va_arg(ap, uint64), 16, 0);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
      printint(va_arg(ap, uint64), 16, 0);
      i += 2;
    } else if(c0 == 'p'){
    8000577e:	07000d93          	li	s11,112
      printint(va_arg(ap, uint64), 10, 0);
    80005782:	4b29                	li	s6,10
    if(c0 == 'd'){
    80005784:	06400b93          	li	s7,100
    80005788:	a015                	j	800057ac <printf+0x86>
    acquire(&pr.lock);
    8000578a:	0001e517          	auipc	a0,0x1e
    8000578e:	1b650513          	addi	a0,a0,438 # 80023940 <pr>
    80005792:	608000ef          	jal	80005d9a <acquire>
    80005796:	bf65                	j	8000574e <printf+0x28>
      consputc(cx);
    80005798:	d09ff0ef          	jal	800054a0 <consputc>
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    8000579c:	001a079b          	addiw	a5,s4,1
    800057a0:	8a3e                	mv	s4,a5
    800057a2:	97a6                	add	a5,a5,s1
    800057a4:	0007c503          	lbu	a0,0(a5)
    800057a8:	1c050363          	beqz	a0,8000596e <printf+0x248>
    if(cx != '%'){
    800057ac:	ff3516e3          	bne	a0,s3,80005798 <printf+0x72>
    i++;
    800057b0:	001a091b          	addiw	s2,s4,1
    c0 = fmt[i+0] & 0xff;
    800057b4:	012487b3          	add	a5,s1,s2
    800057b8:	0007ca83          	lbu	s5,0(a5)
    if(c0) c1 = fmt[i+1] & 0xff;
    800057bc:	200a8763          	beqz	s5,800059ca <printf+0x2a4>
    800057c0:	0017c703          	lbu	a4,1(a5)
    if(c1) c2 = fmt[i+2] & 0xff;
    800057c4:	1e070a63          	beqz	a4,800059b8 <printf+0x292>
    if(c0 == 'd'){
    800057c8:	037a8963          	beq	s5,s7,800057fa <printf+0xd4>
    } else if(c0 == 'l' && c1 == 'd'){
    800057cc:	f94a8793          	addi	a5,s5,-108
    800057d0:	0017b793          	seqz	a5,a5
    800057d4:	f9c70693          	addi	a3,a4,-100
    800057d8:	0016b693          	seqz	a3,a3
    800057dc:	8efd                	and	a3,a3,a5
    800057de:	ca9d                	beqz	a3,80005814 <printf+0xee>
      printint(va_arg(ap, uint64), 10, 1);
    800057e0:	f8843783          	ld	a5,-120(s0)
    800057e4:	00878713          	addi	a4,a5,8
    800057e8:	f8e43423          	sd	a4,-120(s0)
    800057ec:	4605                	li	a2,1
    800057ee:	85da                	mv	a1,s6
    800057f0:	6388                	ld	a0,0(a5)
    800057f2:	ea1ff0ef          	jal	80005692 <printint>
      i += 1;
    800057f6:	2a09                	addiw	s4,s4,2
    800057f8:	b755                	j	8000579c <printf+0x76>
      printint(va_arg(ap, int), 10, 1);
    800057fa:	f8843783          	ld	a5,-120(s0)
    800057fe:	00878713          	addi	a4,a5,8
    80005802:	f8e43423          	sd	a4,-120(s0)
    80005806:	4605                	li	a2,1
    80005808:	85da                	mv	a1,s6
    8000580a:	4388                	lw	a0,0(a5)
    8000580c:	e87ff0ef          	jal	80005692 <printint>
    i++;
    80005810:	8a4a                	mv	s4,s2
    80005812:	b769                	j	8000579c <printf+0x76>
    if(c1) c2 = fmt[i+2] & 0xff;
    80005814:	012486b3          	add	a3,s1,s2
    80005818:	863a                	mv	a2,a4
    8000581a:	0026c703          	lbu	a4,2(a3)
    8000581e:	aa65                	j	800059d6 <printf+0x2b0>
      printint(va_arg(ap, uint64), 10, 1);
    80005820:	f8843783          	ld	a5,-120(s0)
    80005824:	00878713          	addi	a4,a5,8
    80005828:	f8e43423          	sd	a4,-120(s0)
    8000582c:	4605                	li	a2,1
    8000582e:	45a9                	li	a1,10
    80005830:	6388                	ld	a0,0(a5)
    80005832:	e61ff0ef          	jal	80005692 <printint>
      i += 2;
    80005836:	2a0d                	addiw	s4,s4,3
    80005838:	b795                	j	8000579c <printf+0x76>
      printint(va_arg(ap, uint32), 10, 0);
    8000583a:	f8843783          	ld	a5,-120(s0)
    8000583e:	00878713          	addi	a4,a5,8
    80005842:	f8e43423          	sd	a4,-120(s0)
    80005846:	4601                	li	a2,0
    80005848:	85da                	mv	a1,s6
    8000584a:	0007e503          	lwu	a0,0(a5)
    8000584e:	e45ff0ef          	jal	80005692 <printint>
    80005852:	bf7d                	j	80005810 <printf+0xea>
      printint(va_arg(ap, uint64), 10, 0);
    80005854:	f8843783          	ld	a5,-120(s0)
    80005858:	00878713          	addi	a4,a5,8
    8000585c:	f8e43423          	sd	a4,-120(s0)
    80005860:	4601                	li	a2,0
    80005862:	85da                	mv	a1,s6
    80005864:	6388                	ld	a0,0(a5)
    80005866:	e2dff0ef          	jal	80005692 <printint>
      i += 1;
    8000586a:	2a09                	addiw	s4,s4,2
    8000586c:	bf05                	j	8000579c <printf+0x76>
      printint(va_arg(ap, uint64), 10, 0);
    8000586e:	f8843783          	ld	a5,-120(s0)
    80005872:	00878713          	addi	a4,a5,8
    80005876:	f8e43423          	sd	a4,-120(s0)
    8000587a:	4601                	li	a2,0
    8000587c:	45a9                	li	a1,10
    8000587e:	6388                	ld	a0,0(a5)
    80005880:	e13ff0ef          	jal	80005692 <printint>
      i += 2;
    80005884:	2a0d                	addiw	s4,s4,3
    80005886:	bf19                	j	8000579c <printf+0x76>
      printint(va_arg(ap, uint32), 16, 0);
    80005888:	f8843783          	ld	a5,-120(s0)
    8000588c:	00878713          	addi	a4,a5,8
    80005890:	f8e43423          	sd	a4,-120(s0)
    80005894:	4601                	li	a2,0
    80005896:	45c1                	li	a1,16
    80005898:	0007e503          	lwu	a0,0(a5)
    8000589c:	df7ff0ef          	jal	80005692 <printint>
    800058a0:	bf85                	j	80005810 <printf+0xea>
      printint(va_arg(ap, uint64), 16, 0);
    800058a2:	f8843783          	ld	a5,-120(s0)
    800058a6:	00878713          	addi	a4,a5,8
    800058aa:	f8e43423          	sd	a4,-120(s0)
    800058ae:	4601                	li	a2,0
    800058b0:	45c1                	li	a1,16
    800058b2:	6388                	ld	a0,0(a5)
    800058b4:	ddfff0ef          	jal	80005692 <printint>
      i += 1;
    800058b8:	2a09                	addiw	s4,s4,2
    800058ba:	b5cd                	j	8000579c <printf+0x76>
      printint(va_arg(ap, uint64), 16, 0);
    800058bc:	f8843783          	ld	a5,-120(s0)
    800058c0:	00878713          	addi	a4,a5,8
    800058c4:	f8e43423          	sd	a4,-120(s0)
    800058c8:	45c1                	li	a1,16
    800058ca:	6388                	ld	a0,0(a5)
    800058cc:	dc7ff0ef          	jal	80005692 <printint>
      i += 2;
    800058d0:	2a0d                	addiw	s4,s4,3
    800058d2:	b5e9                	j	8000579c <printf+0x76>
    800058d4:	f466                	sd	s9,40(sp)
      printptr(va_arg(ap, uint64));
    800058d6:	f8843783          	ld	a5,-120(s0)
    800058da:	00878713          	addi	a4,a5,8
    800058de:	f8e43423          	sd	a4,-120(s0)
    800058e2:	0007ba83          	ld	s5,0(a5)
  consputc('0');
    800058e6:	03000513          	li	a0,48
    800058ea:	bb7ff0ef          	jal	800054a0 <consputc>
  consputc('x');
    800058ee:	07800513          	li	a0,120
    800058f2:	bafff0ef          	jal	800054a0 <consputc>
    800058f6:	4a41                	li	s4,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800058f8:	00003c97          	auipc	s9,0x3
    800058fc:	3a8c8c93          	addi	s9,s9,936 # 80008ca0 <digits>
    80005900:	03cad793          	srli	a5,s5,0x3c
    80005904:	97e6                	add	a5,a5,s9
    80005906:	0007c503          	lbu	a0,0(a5)
    8000590a:	b97ff0ef          	jal	800054a0 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    8000590e:	0a92                	slli	s5,s5,0x4
    80005910:	3a7d                	addiw	s4,s4,-1
    80005912:	fe0a17e3          	bnez	s4,80005900 <printf+0x1da>
    80005916:	7ca2                	ld	s9,40(sp)
    80005918:	bde5                	j	80005810 <printf+0xea>
    } else if(c0 == 'c'){
      consputc(va_arg(ap, uint));
    8000591a:	f8843783          	ld	a5,-120(s0)
    8000591e:	00878713          	addi	a4,a5,8
    80005922:	f8e43423          	sd	a4,-120(s0)
    80005926:	4388                	lw	a0,0(a5)
    80005928:	b79ff0ef          	jal	800054a0 <consputc>
    8000592c:	b5d5                	j	80005810 <printf+0xea>
    } else if(c0 == 's'){
      if((s = va_arg(ap, char*)) == 0)
    8000592e:	f8843783          	ld	a5,-120(s0)
    80005932:	00878713          	addi	a4,a5,8
    80005936:	f8e43423          	sd	a4,-120(s0)
    8000593a:	0007ba03          	ld	s4,0(a5)
    8000593e:	000a0d63          	beqz	s4,80005958 <printf+0x232>
        s = "(null)";
      for(; *s; s++)
    80005942:	000a4503          	lbu	a0,0(s4)
    80005946:	ec0505e3          	beqz	a0,80005810 <printf+0xea>
        consputc(*s);
    8000594a:	b57ff0ef          	jal	800054a0 <consputc>
      for(; *s; s++)
    8000594e:	0a05                	addi	s4,s4,1
    80005950:	000a4503          	lbu	a0,0(s4)
    80005954:	f97d                	bnez	a0,8000594a <printf+0x224>
    80005956:	bd6d                	j	80005810 <printf+0xea>
        s = "(null)";
    80005958:	00003a17          	auipc	s4,0x3
    8000595c:	d78a0a13          	addi	s4,s4,-648 # 800086d0 <etext+0x6d0>
      for(; *s; s++)
    80005960:	02800513          	li	a0,40
    80005964:	b7dd                	j	8000594a <printf+0x224>
    } else if(c0 == '%'){
      consputc('%');
    80005966:	8556                	mv	a0,s5
    80005968:	b39ff0ef          	jal	800054a0 <consputc>
    8000596c:	b555                	j	80005810 <printf+0xea>
    8000596e:	7906                	ld	s2,96(sp)
    80005970:	69e6                	ld	s3,88(sp)
    80005972:	6a46                	ld	s4,80(sp)
    80005974:	6aa6                	ld	s5,72(sp)
    80005976:	6b06                	ld	s6,64(sp)
    80005978:	7be2                	ld	s7,56(sp)
    8000597a:	7c42                	ld	s8,48(sp)
    8000597c:	7d02                	ld	s10,32(sp)
    8000597e:	6de2                	ld	s11,24(sp)
    }

  }
  va_end(ap);

  if(panicking == 0)
    80005980:	00003797          	auipc	a5,0x3
    80005984:	3707a783          	lw	a5,880(a5) # 80008cf0 <panicking>
    80005988:	c38d                	beqz	a5,800059aa <printf+0x284>
    release(&pr.lock);

  return 0;
}
    8000598a:	4501                	li	a0,0
    8000598c:	70e6                	ld	ra,120(sp)
    8000598e:	7446                	ld	s0,112(sp)
    80005990:	74a6                	ld	s1,104(sp)
    80005992:	6129                	addi	sp,sp,192
    80005994:	8082                	ret
    80005996:	7906                	ld	s2,96(sp)
    80005998:	69e6                	ld	s3,88(sp)
    8000599a:	6a46                	ld	s4,80(sp)
    8000599c:	6aa6                	ld	s5,72(sp)
    8000599e:	6b06                	ld	s6,64(sp)
    800059a0:	7be2                	ld	s7,56(sp)
    800059a2:	7c42                	ld	s8,48(sp)
    800059a4:	7d02                	ld	s10,32(sp)
    800059a6:	6de2                	ld	s11,24(sp)
    800059a8:	bfe1                	j	80005980 <printf+0x25a>
    release(&pr.lock);
    800059aa:	0001e517          	auipc	a0,0x1e
    800059ae:	f9650513          	addi	a0,a0,-106 # 80023940 <pr>
    800059b2:	524000ef          	jal	80005ed6 <release>
  return 0;
    800059b6:	bfd1                	j	8000598a <printf+0x264>
    if(c0 == 'd'){
    800059b8:	e57a81e3          	beq	s5,s7,800057fa <printf+0xd4>
    } else if(c0 == 'l' && c1 == 'd'){
    800059bc:	f94a8793          	addi	a5,s5,-108
    800059c0:	0017b793          	seqz	a5,a5
    800059c4:	863a                	mv	a2,a4
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    800059c6:	4681                	li	a3,0
    800059c8:	a01d                	j	800059ee <printf+0x2c8>
    } else if(c0 == 'l' && c1 == 'd'){
    800059ca:	f94a8793          	addi	a5,s5,-108
    800059ce:	0017b793          	seqz	a5,a5
    c1 = c2 = 0;
    800059d2:	8656                	mv	a2,s5
    800059d4:	8756                	mv	a4,s5
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    800059d6:	f9460693          	addi	a3,a2,-108
    800059da:	0016b693          	seqz	a3,a3
    800059de:	8efd                	and	a3,a3,a5
    800059e0:	f9c70593          	addi	a1,a4,-100
    800059e4:	0015b593          	seqz	a1,a1
    800059e8:	8df5                	and	a1,a1,a3
    800059ea:	e2059be3          	bnez	a1,80005820 <printf+0xfa>
    } else if(c0 == 'u'){
    800059ee:	e58a86e3          	beq	s5,s8,8000583a <printf+0x114>
    } else if(c0 == 'l' && c1 == 'u'){
    800059f2:	f8b60593          	addi	a1,a2,-117
    800059f6:	0015b593          	seqz	a1,a1
    800059fa:	8dfd                	and	a1,a1,a5
    800059fc:	e4059ce3          	bnez	a1,80005854 <printf+0x12e>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    80005a00:	f8b70593          	addi	a1,a4,-117
    80005a04:	0015b593          	seqz	a1,a1
    80005a08:	8df5                	and	a1,a1,a3
    80005a0a:	e60592e3          	bnez	a1,8000586e <printf+0x148>
    } else if(c0 == 'x'){
    80005a0e:	e7aa8de3          	beq	s5,s10,80005888 <printf+0x162>
    } else if(c0 == 'l' && c1 == 'x'){
    80005a12:	f8860613          	addi	a2,a2,-120
    80005a16:	00163613          	seqz	a2,a2
    80005a1a:	8e7d                	and	a2,a2,a5
    80005a1c:	e80613e3          	bnez	a2,800058a2 <printf+0x17c>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    80005a20:	f8870713          	addi	a4,a4,-120
    80005a24:	00173713          	seqz	a4,a4
    80005a28:	8f75                	and	a4,a4,a3
    80005a2a:	e80719e3          	bnez	a4,800058bc <printf+0x196>
    } else if(c0 == 'p'){
    80005a2e:	ebba83e3          	beq	s5,s11,800058d4 <printf+0x1ae>
    } else if(c0 == 'c'){
    80005a32:	06300793          	li	a5,99
    80005a36:	eefa82e3          	beq	s5,a5,8000591a <printf+0x1f4>
    } else if(c0 == 's'){
    80005a3a:	07300793          	li	a5,115
    80005a3e:	eefa88e3          	beq	s5,a5,8000592e <printf+0x208>
    } else if(c0 == '%'){
    80005a42:	02500793          	li	a5,37
    80005a46:	f2fa80e3          	beq	s5,a5,80005966 <printf+0x240>
    } else if(c0 == 0){
    80005a4a:	f40a86e3          	beqz	s5,80005996 <printf+0x270>
      consputc('%');
    80005a4e:	02500513          	li	a0,37
    80005a52:	a4fff0ef          	jal	800054a0 <consputc>
      consputc(c0);
    80005a56:	8556                	mv	a0,s5
    80005a58:	a49ff0ef          	jal	800054a0 <consputc>
    80005a5c:	bb55                	j	80005810 <printf+0xea>

0000000080005a5e <panic>:

void
panic(char *s)
{
    80005a5e:	1101                	addi	sp,sp,-32
    80005a60:	ec06                	sd	ra,24(sp)
    80005a62:	e822                	sd	s0,16(sp)
    80005a64:	e426                	sd	s1,8(sp)
    80005a66:	e04a                	sd	s2,0(sp)
    80005a68:	1000                	addi	s0,sp,32
    80005a6a:	892a                	mv	s2,a0
  panicking = 1;
    80005a6c:	4485                	li	s1,1
    80005a6e:	00003797          	auipc	a5,0x3
    80005a72:	2897a123          	sw	s1,642(a5) # 80008cf0 <panicking>
  printf("panic: ");
    80005a76:	00003517          	auipc	a0,0x3
    80005a7a:	c6a50513          	addi	a0,a0,-918 # 800086e0 <etext+0x6e0>
    80005a7e:	ca9ff0ef          	jal	80005726 <printf>
  printf("%s\n", s);
    80005a82:	85ca                	mv	a1,s2
    80005a84:	00003517          	auipc	a0,0x3
    80005a88:	c6450513          	addi	a0,a0,-924 # 800086e8 <etext+0x6e8>
    80005a8c:	c9bff0ef          	jal	80005726 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005a90:	00003797          	auipc	a5,0x3
    80005a94:	2497ae23          	sw	s1,604(a5) # 80008cec <panicked>
  for(;;)
    80005a98:	a001                	j	80005a98 <panic+0x3a>

0000000080005a9a <printfinit>:
    ;
}

void
printfinit(void)
{
    80005a9a:	1141                	addi	sp,sp,-16
    80005a9c:	e406                	sd	ra,8(sp)
    80005a9e:	e022                	sd	s0,0(sp)
    80005aa0:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    80005aa2:	00003597          	auipc	a1,0x3
    80005aa6:	c4e58593          	addi	a1,a1,-946 # 800086f0 <etext+0x6f0>
    80005aaa:	0001e517          	auipc	a0,0x1e
    80005aae:	e9650513          	addi	a0,a0,-362 # 80023940 <pr>
    80005ab2:	4bc000ef          	jal	80005f6e <initlock>
}
    80005ab6:	60a2                	ld	ra,8(sp)
    80005ab8:	6402                	ld	s0,0(sp)
    80005aba:	0141                	addi	sp,sp,16
    80005abc:	8082                	ret

0000000080005abe <uartinit>:
extern volatile int panicking; // from printf.c
extern volatile int panicked; // from printf.c

void
uartinit(void)
{
    80005abe:	1141                	addi	sp,sp,-16
    80005ac0:	e406                	sd	ra,8(sp)
    80005ac2:	e022                	sd	s0,0(sp)
    80005ac4:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80005ac6:	100007b7          	lui	a5,0x10000
    80005aca:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80005ace:	10000737          	lui	a4,0x10000
    80005ad2:	f8000693          	li	a3,-128
    80005ad6:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80005ada:	468d                	li	a3,3
    80005adc:	10000637          	lui	a2,0x10000
    80005ae0:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80005ae4:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80005ae8:	00d701a3          	sb	a3,3(a4)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80005aec:	8732                	mv	a4,a2
    80005aee:	461d                	li	a2,7
    80005af0:	00c70123          	sb	a2,2(a4)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80005af4:	00d780a3          	sb	a3,1(a5)

  initlock(&tx_lock, "uart");
    80005af8:	00003597          	auipc	a1,0x3
    80005afc:	c0058593          	addi	a1,a1,-1024 # 800086f8 <etext+0x6f8>
    80005b00:	0001e517          	auipc	a0,0x1e
    80005b04:	e6050513          	addi	a0,a0,-416 # 80023960 <tx_lock>
    80005b08:	466000ef          	jal	80005f6e <initlock>
}
    80005b0c:	60a2                	ld	ra,8(sp)
    80005b0e:	6402                	ld	s0,0(sp)
    80005b10:	0141                	addi	sp,sp,16
    80005b12:	8082                	ret

0000000080005b14 <uartwrite>:
// transmit buf[] to the uart. it blocks if the
// uart is busy, so it cannot be called from
// interrupts, only from write() system calls.
void
uartwrite(char buf[], int n)
{
    80005b14:	715d                	addi	sp,sp,-80
    80005b16:	e486                	sd	ra,72(sp)
    80005b18:	e0a2                	sd	s0,64(sp)
    80005b1a:	fc26                	sd	s1,56(sp)
    80005b1c:	ec56                	sd	s5,24(sp)
    80005b1e:	0880                	addi	s0,sp,80
    80005b20:	8aaa                	mv	s5,a0
    80005b22:	84ae                	mv	s1,a1
  acquire(&tx_lock);
    80005b24:	0001e517          	auipc	a0,0x1e
    80005b28:	e3c50513          	addi	a0,a0,-452 # 80023960 <tx_lock>
    80005b2c:	26e000ef          	jal	80005d9a <acquire>

  int i = 0;
  while(i < n){ 
    80005b30:	06905063          	blez	s1,80005b90 <uartwrite+0x7c>
    80005b34:	f84a                	sd	s2,48(sp)
    80005b36:	f44e                	sd	s3,40(sp)
    80005b38:	f052                	sd	s4,32(sp)
    80005b3a:	e85a                	sd	s6,16(sp)
    80005b3c:	e45e                	sd	s7,8(sp)
    80005b3e:	8a56                	mv	s4,s5
    80005b40:	9aa6                	add	s5,s5,s1
    while(tx_busy != 0){
    80005b42:	00003497          	auipc	s1,0x3
    80005b46:	1b648493          	addi	s1,s1,438 # 80008cf8 <tx_busy>
      // wait for a UART transmit-complete interrupt
      // to set tx_busy to 0.
      sleep(&tx_chan, &tx_lock);
    80005b4a:	0001e997          	auipc	s3,0x1e
    80005b4e:	e1698993          	addi	s3,s3,-490 # 80023960 <tx_lock>
    80005b52:	00003917          	auipc	s2,0x3
    80005b56:	1a290913          	addi	s2,s2,418 # 80008cf4 <tx_chan>
    }   
      
    WriteReg(THR, buf[i]);
    80005b5a:	10000bb7          	lui	s7,0x10000
    i += 1;
    tx_busy = 1;
    80005b5e:	4b05                	li	s6,1
    80005b60:	a005                	j	80005b80 <uartwrite+0x6c>
      sleep(&tx_chan, &tx_lock);
    80005b62:	85ce                	mv	a1,s3
    80005b64:	854a                	mv	a0,s2
    80005b66:	905fb0ef          	jal	8000146a <sleep>
    while(tx_busy != 0){
    80005b6a:	409c                	lw	a5,0(s1)
    80005b6c:	fbfd                	bnez	a5,80005b62 <uartwrite+0x4e>
    WriteReg(THR, buf[i]);
    80005b6e:	000a4783          	lbu	a5,0(s4)
    80005b72:	00fb8023          	sb	a5,0(s7) # 10000000 <_entry-0x70000000>
    tx_busy = 1;
    80005b76:	0164a023          	sw	s6,0(s1)
  while(i < n){ 
    80005b7a:	0a05                	addi	s4,s4,1
    80005b7c:	015a0563          	beq	s4,s5,80005b86 <uartwrite+0x72>
    while(tx_busy != 0){
    80005b80:	409c                	lw	a5,0(s1)
    80005b82:	f3e5                	bnez	a5,80005b62 <uartwrite+0x4e>
    80005b84:	b7ed                	j	80005b6e <uartwrite+0x5a>
    80005b86:	7942                	ld	s2,48(sp)
    80005b88:	79a2                	ld	s3,40(sp)
    80005b8a:	7a02                	ld	s4,32(sp)
    80005b8c:	6b42                	ld	s6,16(sp)
    80005b8e:	6ba2                	ld	s7,8(sp)
  }

  release(&tx_lock);
    80005b90:	0001e517          	auipc	a0,0x1e
    80005b94:	dd050513          	addi	a0,a0,-560 # 80023960 <tx_lock>
    80005b98:	33e000ef          	jal	80005ed6 <release>
}
    80005b9c:	60a6                	ld	ra,72(sp)
    80005b9e:	6406                	ld	s0,64(sp)
    80005ba0:	74e2                	ld	s1,56(sp)
    80005ba2:	6ae2                	ld	s5,24(sp)
    80005ba4:	6161                	addi	sp,sp,80
    80005ba6:	8082                	ret

0000000080005ba8 <uartputc_sync>:
// interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80005ba8:	1101                	addi	sp,sp,-32
    80005baa:	ec06                	sd	ra,24(sp)
    80005bac:	e822                	sd	s0,16(sp)
    80005bae:	e426                	sd	s1,8(sp)
    80005bb0:	1000                	addi	s0,sp,32
    80005bb2:	84aa                	mv	s1,a0
  if(panicking == 0)
    80005bb4:	00003797          	auipc	a5,0x3
    80005bb8:	13c7a783          	lw	a5,316(a5) # 80008cf0 <panicking>
    80005bbc:	cb91                	beqz	a5,80005bd0 <uartputc_sync+0x28>
    push_off();

  if(panicked){
    80005bbe:	00003797          	auipc	a5,0x3
    80005bc2:	12e7a783          	lw	a5,302(a5) # 80008cec <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80005bc6:	10000737          	lui	a4,0x10000
    80005bca:	0715                	addi	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
  if(panicked){
    80005bcc:	c789                	beqz	a5,80005bd6 <uartputc_sync+0x2e>
    for(;;)
    80005bce:	a001                	j	80005bce <uartputc_sync+0x26>
    push_off();
    80005bd0:	186000ef          	jal	80005d56 <push_off>
    80005bd4:	b7ed                	j	80005bbe <uartputc_sync+0x16>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80005bd6:	00074783          	lbu	a5,0(a4)
    80005bda:	0207f793          	andi	a5,a5,32
    80005bde:	dfe5                	beqz	a5,80005bd6 <uartputc_sync+0x2e>
    ;
  WriteReg(THR, c);
    80005be0:	100007b7          	lui	a5,0x10000
    80005be4:	00978023          	sb	s1,0(a5) # 10000000 <_entry-0x70000000>

  if(panicking == 0)
    80005be8:	00003797          	auipc	a5,0x3
    80005bec:	1087a783          	lw	a5,264(a5) # 80008cf0 <panicking>
    80005bf0:	c791                	beqz	a5,80005bfc <uartputc_sync+0x54>
    pop_off();
}
    80005bf2:	60e2                	ld	ra,24(sp)
    80005bf4:	6442                	ld	s0,16(sp)
    80005bf6:	64a2                	ld	s1,8(sp)
    80005bf8:	6105                	addi	sp,sp,32
    80005bfa:	8082                	ret
    pop_off();
    80005bfc:	28a000ef          	jal	80005e86 <pop_off>
}
    80005c00:	bfcd                	j	80005bf2 <uartputc_sync+0x4a>

0000000080005c02 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80005c02:	1141                	addi	sp,sp,-16
    80005c04:	e406                	sd	ra,8(sp)
    80005c06:	e022                	sd	s0,0(sp)
    80005c08:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & LSR_RX_READY){
    80005c0a:	100007b7          	lui	a5,0x10000
    80005c0e:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80005c12:	8b85                	andi	a5,a5,1
    80005c14:	cb89                	beqz	a5,80005c26 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    80005c16:	100007b7          	lui	a5,0x10000
    80005c1a:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    80005c1e:	60a2                	ld	ra,8(sp)
    80005c20:	6402                	ld	s0,0(sp)
    80005c22:	0141                	addi	sp,sp,16
    80005c24:	8082                	ret
    return -1;
    80005c26:	557d                	li	a0,-1
    80005c28:	bfdd                	j	80005c1e <uartgetc+0x1c>

0000000080005c2a <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    80005c2a:	1101                	addi	sp,sp,-32
    80005c2c:	ec06                	sd	ra,24(sp)
    80005c2e:	e822                	sd	s0,16(sp)
    80005c30:	e426                	sd	s1,8(sp)
    80005c32:	1000                	addi	s0,sp,32
  ReadReg(ISR); // acknowledge the interrupt
    80005c34:	100007b7          	lui	a5,0x10000
    80005c38:	0027c783          	lbu	a5,2(a5) # 10000002 <_entry-0x6ffffffe>

  acquire(&tx_lock);
    80005c3c:	0001e517          	auipc	a0,0x1e
    80005c40:	d2450513          	addi	a0,a0,-732 # 80023960 <tx_lock>
    80005c44:	156000ef          	jal	80005d9a <acquire>
  if(ReadReg(LSR) & LSR_TX_IDLE){
    80005c48:	100007b7          	lui	a5,0x10000
    80005c4c:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80005c50:	0207f793          	andi	a5,a5,32
    80005c54:	ef99                	bnez	a5,80005c72 <uartintr+0x48>
    // UART finished transmitting; wake up sending thread.
    tx_busy = 0;
    wakeup(&tx_chan);
  }
  release(&tx_lock);
    80005c56:	0001e517          	auipc	a0,0x1e
    80005c5a:	d0a50513          	addi	a0,a0,-758 # 80023960 <tx_lock>
    80005c5e:	278000ef          	jal	80005ed6 <release>

  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    80005c62:	54fd                	li	s1,-1
    int c = uartgetc();
    80005c64:	f9fff0ef          	jal	80005c02 <uartgetc>
    if(c == -1)
    80005c68:	02950063          	beq	a0,s1,80005c88 <uartintr+0x5e>
      break;
    consoleintr(c);
    80005c6c:	867ff0ef          	jal	800054d2 <consoleintr>
  while(1){
    80005c70:	bfd5                	j	80005c64 <uartintr+0x3a>
    tx_busy = 0;
    80005c72:	00003797          	auipc	a5,0x3
    80005c76:	0807a323          	sw	zero,134(a5) # 80008cf8 <tx_busy>
    wakeup(&tx_chan);
    80005c7a:	00003517          	auipc	a0,0x3
    80005c7e:	07a50513          	addi	a0,a0,122 # 80008cf4 <tx_chan>
    80005c82:	835fb0ef          	jal	800014b6 <wakeup>
    80005c86:	bfc1                	j	80005c56 <uartintr+0x2c>
  }
}
    80005c88:	60e2                	ld	ra,24(sp)
    80005c8a:	6442                	ld	s0,16(sp)
    80005c8c:	64a2                	ld	s1,8(sp)
    80005c8e:	6105                	addi	sp,sp,32
    80005c90:	8082                	ret

0000000080005c92 <delay>:
  }
}

static uint
delay()
{
    80005c92:	1141                	addi	sp,sp,-16
    80005c94:	e406                	sd	ra,8(sp)
    80005c96:	e022                	sd	s0,0(sp)
    80005c98:	0800                	addi	s0,sp,16
    80005c9a:	6789                	lui	a5,0x2
    80005c9c:	71078793          	addi	a5,a5,1808 # 2710 <_entry-0x7fffd8f0>
  static uint v;
  for (int i = 0; i < 10000; i++) {
    __atomic_fetch_add(&v, 1, __ATOMIC_RELAXED);
    80005ca0:	00003717          	auipc	a4,0x3
    80005ca4:	06470713          	addi	a4,a4,100 # 80008d04 <v.1>
    80005ca8:	4685                	li	a3,1
    80005caa:	00d7202f          	amoadd.w	zero,a3,(a4)
  for (int i = 0; i < 10000; i++) {
    80005cae:	37fd                	addiw	a5,a5,-1
    80005cb0:	ffed                	bnez	a5,80005caa <delay+0x18>
  }
  return __atomic_load_n(&v, __ATOMIC_RELAXED);
    80005cb2:	00003797          	auipc	a5,0x3
    80005cb6:	05278793          	addi	a5,a5,82 # 80008d04 <v.1>
    80005cba:	4388                	lw	a0,0(a5)
}
    80005cbc:	2501                	sext.w	a0,a0
    80005cbe:	60a2                	ld	ra,8(sp)
    80005cc0:	6402                	ld	s0,0(sp)
    80005cc2:	0141                	addi	sp,sp,16
    80005cc4:	8082                	ret

0000000080005cc6 <rwspinlock_test_step>:
{
    80005cc6:	1101                	addi	sp,sp,-32
    80005cc8:	ec06                	sd	ra,24(sp)
    80005cca:	e822                	sd	s0,16(sp)
    80005ccc:	e426                	sd	s1,8(sp)
    80005cce:	e04a                	sd	s2,0(sp)
    80005cd0:	1000                	addi	s0,sp,32
    80005cd2:	84aa                	mv	s1,a0
    80005cd4:	892e                	mv	s2,a1
  __atomic_fetch_add(&barrier, 1, __ATOMIC_ACQ_REL);
    80005cd6:	00003797          	auipc	a5,0x3
    80005cda:	02a78793          	addi	a5,a5,42 # 80008d00 <barrier.0>
    80005cde:	4705                	li	a4,1
    80005ce0:	06e7a02f          	amoadd.w.aqrl	zero,a4,(a5)
  while (__atomic_load_n(&barrier, __ATOMIC_RELAXED) < ncpu * step) {
    80005ce4:	0025169b          	slliw	a3,a0,0x2
    80005ce8:	873e                	mv	a4,a5
    80005cea:	431c                	lw	a5,0(a4)
    80005cec:	2781                	sext.w	a5,a5
    80005cee:	fed7eee3          	bltu	a5,a3,80005cea <rwspinlock_test_step+0x24>
  if (cpuid() == 0) {
    80005cf2:	90efb0ef          	jal	80000e00 <cpuid>
    80005cf6:	c519                	beqz	a0,80005d04 <rwspinlock_test_step+0x3e>
}
    80005cf8:	60e2                	ld	ra,24(sp)
    80005cfa:	6442                	ld	s0,16(sp)
    80005cfc:	64a2                	ld	s1,8(sp)
    80005cfe:	6902                	ld	s2,0(sp)
    80005d00:	6105                	addi	sp,sp,32
    80005d02:	8082                	ret
    printf("rwspinlock_test: step %d: %s\n", step, msg);
    80005d04:	864a                	mv	a2,s2
    80005d06:	85a6                	mv	a1,s1
    80005d08:	00003517          	auipc	a0,0x3
    80005d0c:	9f850513          	addi	a0,a0,-1544 # 80008700 <etext+0x700>
    80005d10:	a17ff0ef          	jal	80005726 <printf>
}
    80005d14:	b7d5                	j	80005cf8 <rwspinlock_test_step+0x32>

0000000080005d16 <initrwlock>:
{
    80005d16:	1141                	addi	sp,sp,-16
    80005d18:	e406                	sd	ra,8(sp)
    80005d1a:	e022                	sd	s0,0(sp)
    80005d1c:	0800                	addi	s0,sp,16
  rwlk->state=0;
    80005d1e:	00053023          	sd	zero,0(a0)
}
    80005d22:	60a2                	ld	ra,8(sp)
    80005d24:	6402                	ld	s0,0(sp)
    80005d26:	0141                	addi	sp,sp,16
    80005d28:	8082                	ret

0000000080005d2a <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80005d2a:	411c                	lw	a5,0(a0)
    80005d2c:	e399                	bnez	a5,80005d32 <holding+0x8>
    80005d2e:	4501                	li	a0,0
  return r;
}
    80005d30:	8082                	ret
{
    80005d32:	1101                	addi	sp,sp,-32
    80005d34:	ec06                	sd	ra,24(sp)
    80005d36:	e822                	sd	s0,16(sp)
    80005d38:	e426                	sd	s1,8(sp)
    80005d3a:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80005d3c:	691c                	ld	a5,16(a0)
    80005d3e:	84be                	mv	s1,a5
    80005d40:	8d4fb0ef          	jal	80000e14 <mycpu>
    80005d44:	40a48533          	sub	a0,s1,a0
    80005d48:	00153513          	seqz	a0,a0
}
    80005d4c:	60e2                	ld	ra,24(sp)
    80005d4e:	6442                	ld	s0,16(sp)
    80005d50:	64a2                	ld	s1,8(sp)
    80005d52:	6105                	addi	sp,sp,32
    80005d54:	8082                	ret

0000000080005d56 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80005d56:	1101                	addi	sp,sp,-32
    80005d58:	ec06                	sd	ra,24(sp)
    80005d5a:	e822                	sd	s0,16(sp)
    80005d5c:	e426                	sd	s1,8(sp)
    80005d5e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80005d60:	100027f3          	csrr	a5,sstatus
    80005d64:	84be                	mv	s1,a5
    80005d66:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80005d6a:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80005d6c:	10079073          	csrw	sstatus,a5

  // disable interrupts to prevent an involuntary context
  // switch while using mycpu().
  intr_off();

  if(mycpu()->noff == 0)
    80005d70:	8a4fb0ef          	jal	80000e14 <mycpu>
    80005d74:	5d3c                	lw	a5,120(a0)
    80005d76:	cb99                	beqz	a5,80005d8c <push_off+0x36>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80005d78:	89cfb0ef          	jal	80000e14 <mycpu>
    80005d7c:	5d3c                	lw	a5,120(a0)
    80005d7e:	2785                	addiw	a5,a5,1
    80005d80:	dd3c                	sw	a5,120(a0)
}
    80005d82:	60e2                	ld	ra,24(sp)
    80005d84:	6442                	ld	s0,16(sp)
    80005d86:	64a2                	ld	s1,8(sp)
    80005d88:	6105                	addi	sp,sp,32
    80005d8a:	8082                	ret
    mycpu()->intena = old;
    80005d8c:	888fb0ef          	jal	80000e14 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80005d90:	0014d793          	srli	a5,s1,0x1
    80005d94:	8b85                	andi	a5,a5,1
    80005d96:	dd7c                	sw	a5,124(a0)
    80005d98:	b7c5                	j	80005d78 <push_off+0x22>

0000000080005d9a <acquire>:
{
    80005d9a:	1101                	addi	sp,sp,-32
    80005d9c:	ec06                	sd	ra,24(sp)
    80005d9e:	e822                	sd	s0,16(sp)
    80005da0:	e426                	sd	s1,8(sp)
    80005da2:	1000                	addi	s0,sp,32
    80005da4:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80005da6:	fb1ff0ef          	jal	80005d56 <push_off>
  if(holding(lk))
    80005daa:	8526                	mv	a0,s1
    80005dac:	f7fff0ef          	jal	80005d2a <holding>
    80005db0:	e519                	bnez	a0,80005dbe <acquire+0x24>
    __sync_fetch_and_add(&(lk->n), 1);
    80005db2:	4785                	li	a5,1
    80005db4:	01c48713          	addi	a4,s1,28
    80005db8:	06f7202f          	amoadd.w.aqrl	zero,a5,(a4)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) {
    80005dbc:	a819                	j	80005dd2 <acquire+0x38>
    panic("acquire");
    80005dbe:	00003517          	auipc	a0,0x3
    80005dc2:	9fa50513          	addi	a0,a0,-1542 # 800087b8 <etext+0x7b8>
    80005dc6:	c99ff0ef          	jal	80005a5e <panic>
    __sync_fetch_and_add(&(lk->nts), 1);
    80005dca:	01848713          	addi	a4,s1,24
    80005dce:	06f7202f          	amoadd.w.aqrl	zero,a5,(a4)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) {
    80005dd2:	0cf4a72f          	amoswap.w.aq	a4,a5,(s1)
    80005dd6:	fb75                	bnez	a4,80005dca <acquire+0x30>
  __sync_synchronize();
    80005dd8:	0330000f          	fence	rw,rw
  lk->cpu = mycpu();
    80005ddc:	838fb0ef          	jal	80000e14 <mycpu>
    80005de0:	e888                	sd	a0,16(s1)
}
    80005de2:	60e2                	ld	ra,24(sp)
    80005de4:	6442                	ld	s0,16(sp)
    80005de6:	64a2                	ld	s1,8(sp)
    80005de8:	6105                	addi	sp,sp,32
    80005dea:	8082                	ret

0000000080005dec <read_acquire>:
{
    80005dec:	1101                	addi	sp,sp,-32
    80005dee:	ec06                	sd	ra,24(sp)
    80005df0:	e822                	sd	s0,16(sp)
    80005df2:	e426                	sd	s1,8(sp)
    80005df4:	1000                	addi	s0,sp,32
    80005df6:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80005df8:	f5fff0ef          	jal	80005d56 <push_off>
  uint64 curr=__atomic_load_n(&rwlk->state,__ATOMIC_RELAXED);
    80005dfc:	86a6                	mv	a3,s1
    80005dfe:	609c                	ld	a5,0(s1)
    if(curr&(RW_ACTIVE_WRITER|RW_WAITING_WRITERS)){
    80005e00:	577d                	li	a4,-1
    80005e02:	9301                	srli	a4,a4,0x20
    80005e04:	02f76463          	bltu	a4,a5,80005e2c <read_acquire+0x40>
    uint64 l=curr+1; //increment reader count
    80005e08:	00178593          	addi	a1,a5,1
    if(__atomic_compare_exchange_n(&rwlk->state, &curr, l, 0, __ATOMIC_ACQUIRE, __ATOMIC_RELAXED)) {
    80005e0c:	1406b62f          	lr.d.aq	a2,(a3)
    80005e10:	00f61563          	bne	a2,a5,80005e1a <read_acquire+0x2e>
    80005e14:	18b6b52f          	sc.d	a0,a1,(a3)
    80005e18:	f975                	bnez	a0,80005e0c <read_acquire+0x20>
    80005e1a:	00f61763          	bne	a2,a5,80005e28 <read_acquire+0x3c>
}
    80005e1e:	60e2                	ld	ra,24(sp)
    80005e20:	6442                	ld	s0,16(sp)
    80005e22:	64a2                	ld	s1,8(sp)
    80005e24:	6105                	addi	sp,sp,32
    80005e26:	8082                	ret
    80005e28:	87b2                	mv	a5,a2
    80005e2a:	bfe9                	j	80005e04 <read_acquire+0x18>
      curr=__atomic_load_n(&rwlk->state, __ATOMIC_RELAXED);
    80005e2c:	609c                	ld	a5,0(s1)
      continue;
    80005e2e:	bfd9                	j	80005e04 <read_acquire+0x18>

0000000080005e30 <write_acquire>:
{
    80005e30:	1101                	addi	sp,sp,-32
    80005e32:	ec06                	sd	ra,24(sp)
    80005e34:	e822                	sd	s0,16(sp)
    80005e36:	e426                	sd	s1,8(sp)
    80005e38:	1000                	addi	s0,sp,32
    80005e3a:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80005e3c:	f1bff0ef          	jal	80005d56 <push_off>
  __atomic_fetch_add(&rwlk->state, RW_WAITING_INC, __ATOMIC_RELAXED);
    80005e40:	85a6                	mv	a1,s1
    80005e42:	4785                	li	a5,1
    80005e44:	1786                	slli	a5,a5,0x21
    80005e46:	00f4b02f          	amoadd.d	zero,a5,(s1)
  uint64 curr=__atomic_load_n(&rwlk->state, __ATOMIC_RELAXED);
    80005e4a:	609c                	ld	a5,0(s1)
      uint64 l=(curr| RW_ACTIVE_WRITER)-RW_WAITING_INC;
    80005e4c:	4605                	li	a2,1
    80005e4e:	1602                	slli	a2,a2,0x20
    80005e50:	56fd                	li	a3,-1
    80005e52:	1686                	slli	a3,a3,0x21
    if ((curr & RW_READERS_MASK) == 0 && (curr & RW_ACTIVE_WRITER) == 0) {//until no active readers or writers
    80005e54:	01f79713          	slli	a4,a5,0x1f
    80005e58:	c709                	beqz	a4,80005e62 <write_acquire+0x32>
      curr=__atomic_load_n(&rwlk->state, __ATOMIC_RELAXED);
    80005e5a:	609c                	ld	a5,0(s1)
    80005e5c:	bfe5                	j	80005e54 <write_acquire+0x24>
    80005e5e:	87aa                	mv	a5,a0
    80005e60:	bfd5                	j	80005e54 <write_acquire+0x24>
      uint64 l=(curr| RW_ACTIVE_WRITER)-RW_WAITING_INC;
    80005e62:	00c7e733          	or	a4,a5,a2
    80005e66:	9736                	add	a4,a4,a3
      if (__atomic_compare_exchange_n(&rwlk->state, &curr, l, 0, __ATOMIC_ACQUIRE, __ATOMIC_RELAXED)) {
    80005e68:	1405b52f          	lr.d.aq	a0,(a1)
    80005e6c:	00f51663          	bne	a0,a5,80005e78 <write_acquire+0x48>
    80005e70:	18e5b82f          	sc.d	a6,a4,(a1)
    80005e74:	fe081ae3          	bnez	a6,80005e68 <write_acquire+0x38>
    80005e78:	fef513e3          	bne	a0,a5,80005e5e <write_acquire+0x2e>
}
    80005e7c:	60e2                	ld	ra,24(sp)
    80005e7e:	6442                	ld	s0,16(sp)
    80005e80:	64a2                	ld	s1,8(sp)
    80005e82:	6105                	addi	sp,sp,32
    80005e84:	8082                	ret

0000000080005e86 <pop_off>:

void
pop_off(void)
{
    80005e86:	1141                	addi	sp,sp,-16
    80005e88:	e406                	sd	ra,8(sp)
    80005e8a:	e022                	sd	s0,0(sp)
    80005e8c:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80005e8e:	f87fa0ef          	jal	80000e14 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80005e92:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80005e96:	8b89                	andi	a5,a5,2
  if(intr_get())
    80005e98:	e39d                	bnez	a5,80005ebe <pop_off+0x38>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80005e9a:	5d3c                	lw	a5,120(a0)
    80005e9c:	02f05763          	blez	a5,80005eca <pop_off+0x44>
    panic("pop_off");
  c->noff -= 1;
    80005ea0:	37fd                	addiw	a5,a5,-1
    80005ea2:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80005ea4:	eb89                	bnez	a5,80005eb6 <pop_off+0x30>
    80005ea6:	5d7c                	lw	a5,124(a0)
    80005ea8:	c799                	beqz	a5,80005eb6 <pop_off+0x30>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80005eaa:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80005eae:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80005eb2:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80005eb6:	60a2                	ld	ra,8(sp)
    80005eb8:	6402                	ld	s0,0(sp)
    80005eba:	0141                	addi	sp,sp,16
    80005ebc:	8082                	ret
    panic("pop_off - interruptible");
    80005ebe:	00003517          	auipc	a0,0x3
    80005ec2:	86250513          	addi	a0,a0,-1950 # 80008720 <etext+0x720>
    80005ec6:	b99ff0ef          	jal	80005a5e <panic>
    panic("pop_off");
    80005eca:	00003517          	auipc	a0,0x3
    80005ece:	86e50513          	addi	a0,a0,-1938 # 80008738 <etext+0x738>
    80005ed2:	b8dff0ef          	jal	80005a5e <panic>

0000000080005ed6 <release>:
{
    80005ed6:	1101                	addi	sp,sp,-32
    80005ed8:	ec06                	sd	ra,24(sp)
    80005eda:	e822                	sd	s0,16(sp)
    80005edc:	e426                	sd	s1,8(sp)
    80005ede:	1000                	addi	s0,sp,32
    80005ee0:	84aa                	mv	s1,a0
  if(!holding(lk))
    80005ee2:	e49ff0ef          	jal	80005d2a <holding>
    80005ee6:	c105                	beqz	a0,80005f06 <release+0x30>
  lk->cpu = 0;
    80005ee8:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80005eec:	0330000f          	fence	rw,rw
  __sync_lock_release(&lk->locked);
    80005ef0:	0310000f          	fence	rw,w
    80005ef4:	0004a023          	sw	zero,0(s1)
  pop_off();
    80005ef8:	f8fff0ef          	jal	80005e86 <pop_off>
}
    80005efc:	60e2                	ld	ra,24(sp)
    80005efe:	6442                	ld	s0,16(sp)
    80005f00:	64a2                	ld	s1,8(sp)
    80005f02:	6105                	addi	sp,sp,32
    80005f04:	8082                	ret
    panic("release");
    80005f06:	00003517          	auipc	a0,0x3
    80005f0a:	8ca50513          	addi	a0,a0,-1846 # 800087d0 <etext+0x7d0>
    80005f0e:	b51ff0ef          	jal	80005a5e <panic>

0000000080005f12 <freelock>:
{
    80005f12:	1101                	addi	sp,sp,-32
    80005f14:	ec06                	sd	ra,24(sp)
    80005f16:	e822                	sd	s0,16(sp)
    80005f18:	e426                	sd	s1,8(sp)
    80005f1a:	1000                	addi	s0,sp,32
    80005f1c:	84aa                	mv	s1,a0
  acquire(&lock_locks);
    80005f1e:	0001e517          	auipc	a0,0x1e
    80005f22:	a6250513          	addi	a0,a0,-1438 # 80023980 <lock_locks>
    80005f26:	e75ff0ef          	jal	80005d9a <acquire>
  for (i = 0; i < NLOCK; i++) {
    80005f2a:	0001e717          	auipc	a4,0x1e
    80005f2e:	a7670713          	addi	a4,a4,-1418 # 800239a0 <locks>
    80005f32:	4781                	li	a5,0
    80005f34:	1f400613          	li	a2,500
    if(locks[i] == lk) {
    80005f38:	6314                	ld	a3,0(a4)
    80005f3a:	00968763          	beq	a3,s1,80005f48 <freelock+0x36>
  for (i = 0; i < NLOCK; i++) {
    80005f3e:	2785                	addiw	a5,a5,1
    80005f40:	0721                	addi	a4,a4,8
    80005f42:	fec79be3          	bne	a5,a2,80005f38 <freelock+0x26>
    80005f46:	a809                	j	80005f58 <freelock+0x46>
      locks[i] = 0;
    80005f48:	078e                	slli	a5,a5,0x3
    80005f4a:	0001e717          	auipc	a4,0x1e
    80005f4e:	a5670713          	addi	a4,a4,-1450 # 800239a0 <locks>
    80005f52:	97ba                	add	a5,a5,a4
    80005f54:	0007b023          	sd	zero,0(a5)
  release(&lock_locks);
    80005f58:	0001e517          	auipc	a0,0x1e
    80005f5c:	a2850513          	addi	a0,a0,-1496 # 80023980 <lock_locks>
    80005f60:	f77ff0ef          	jal	80005ed6 <release>
}
    80005f64:	60e2                	ld	ra,24(sp)
    80005f66:	6442                	ld	s0,16(sp)
    80005f68:	64a2                	ld	s1,8(sp)
    80005f6a:	6105                	addi	sp,sp,32
    80005f6c:	8082                	ret

0000000080005f6e <initlock>:
{
    80005f6e:	1101                	addi	sp,sp,-32
    80005f70:	ec06                	sd	ra,24(sp)
    80005f72:	e822                	sd	s0,16(sp)
    80005f74:	e426                	sd	s1,8(sp)
    80005f76:	1000                	addi	s0,sp,32
    80005f78:	84aa                	mv	s1,a0
  lk->name = name;
    80005f7a:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80005f7c:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80005f80:	00053823          	sd	zero,16(a0)
  lk->nts = 0;
    80005f84:	00052c23          	sw	zero,24(a0)
  lk->n = 0;
    80005f88:	00052e23          	sw	zero,28(a0)
  acquire(&lock_locks);
    80005f8c:	0001e517          	auipc	a0,0x1e
    80005f90:	9f450513          	addi	a0,a0,-1548 # 80023980 <lock_locks>
    80005f94:	e07ff0ef          	jal	80005d9a <acquire>
  for (i = 0; i < NLOCK; i++) {
    80005f98:	0001e717          	auipc	a4,0x1e
    80005f9c:	a0870713          	addi	a4,a4,-1528 # 800239a0 <locks>
    80005fa0:	4781                	li	a5,0
    80005fa2:	1f400613          	li	a2,500
    if(locks[i] == 0) {
    80005fa6:	6314                	ld	a3,0(a4)
    80005fa8:	ca99                	beqz	a3,80005fbe <initlock+0x50>
  for (i = 0; i < NLOCK; i++) {
    80005faa:	2785                	addiw	a5,a5,1
    80005fac:	0721                	addi	a4,a4,8
    80005fae:	fec79ce3          	bne	a5,a2,80005fa6 <initlock+0x38>
  panic("findslot");
    80005fb2:	00002517          	auipc	a0,0x2
    80005fb6:	78e50513          	addi	a0,a0,1934 # 80008740 <etext+0x740>
    80005fba:	aa5ff0ef          	jal	80005a5e <panic>
      locks[i] = lk;
    80005fbe:	078e                	slli	a5,a5,0x3
    80005fc0:	0001e717          	auipc	a4,0x1e
    80005fc4:	9e070713          	addi	a4,a4,-1568 # 800239a0 <locks>
    80005fc8:	97ba                	add	a5,a5,a4
    80005fca:	e384                	sd	s1,0(a5)
      release(&lock_locks);
    80005fcc:	0001e517          	auipc	a0,0x1e
    80005fd0:	9b450513          	addi	a0,a0,-1612 # 80023980 <lock_locks>
    80005fd4:	f03ff0ef          	jal	80005ed6 <release>
}
    80005fd8:	60e2                	ld	ra,24(sp)
    80005fda:	6442                	ld	s0,16(sp)
    80005fdc:	64a2                	ld	s1,8(sp)
    80005fde:	6105                	addi	sp,sp,32
    80005fe0:	8082                	ret

0000000080005fe2 <read_release>:
{
    80005fe2:	1141                	addi	sp,sp,-16
    80005fe4:	e406                	sd	ra,8(sp)
    80005fe6:	e022                	sd	s0,0(sp)
    80005fe8:	0800                	addi	s0,sp,16
  uint64 curr =__atomic_load_n(&rwlk->state, __ATOMIC_RELAXED);
    80005fea:	611c                	ld	a5,0(a0)
    if ((curr & RW_READERS_MASK) == 0)
    80005fec:	02079713          	slli	a4,a5,0x20
    80005ff0:	9301                	srli	a4,a4,0x20
    80005ff2:	c705                	beqz	a4,8000601a <read_release+0x38>
    uint64 l=curr-1;
    80005ff4:	fff78693          	addi	a3,a5,-1
    if (__atomic_compare_exchange_n(&rwlk->state, &curr, l, 0, __ATOMIC_RELEASE, __ATOMIC_RELAXED)) {
    80005ff8:	1005372f          	lr.d	a4,(a0)
    80005ffc:	00f71563          	bne	a4,a5,80006006 <read_release+0x24>
    80006000:	1ad5362f          	sc.d.rl	a2,a3,(a0)
    80006004:	fa75                	bnez	a2,80005ff8 <read_release+0x16>
    80006006:	40f706b3          	sub	a3,a4,a5
    8000600a:	87ba                	mv	a5,a4
    8000600c:	f2e5                	bnez	a3,80005fec <read_release+0xa>
  pop_off();
    8000600e:	e79ff0ef          	jal	80005e86 <pop_off>
}
    80006012:	60a2                	ld	ra,8(sp)
    80006014:	6402                	ld	s0,0(sp)
    80006016:	0141                	addi	sp,sp,16
    80006018:	8082                	ret
      panic("read_release: no readers");
    8000601a:	00002517          	auipc	a0,0x2
    8000601e:	73650513          	addi	a0,a0,1846 # 80008750 <etext+0x750>
    80006022:	a3dff0ef          	jal	80005a5e <panic>

0000000080006026 <write_release>:
{
    80006026:	1141                	addi	sp,sp,-16
    80006028:	e406                	sd	ra,8(sp)
    8000602a:	e022                	sd	s0,0(sp)
    8000602c:	0800                	addi	s0,sp,16
  uint64 curr=__atomic_load_n(&rwlk->state, __ATOMIC_RELAXED);
    8000602e:	6118                	ld	a4,0(a0)
    if((curr & RW_ACTIVE_WRITER) == 0)
    80006030:	01f71793          	slli	a5,a4,0x1f
    80006034:	0207d763          	bgez	a5,80006062 <write_release+0x3c>
    uint64 l=curr&~RW_ACTIVE_WRITER;
    80006038:	57fd                	li	a5,-1
    8000603a:	1782                	slli	a5,a5,0x20
    8000603c:	17fd                	addi	a5,a5,-1
    8000603e:	8ff9                	and	a5,a5,a4
    if (__atomic_compare_exchange_n(&rwlk->state, &curr, l, 0, __ATOMIC_RELEASE, __ATOMIC_RELAXED)) {
    80006040:	100536af          	lr.d	a3,(a0)
    80006044:	00e69563          	bne	a3,a4,8000604e <write_release+0x28>
    80006048:	1af5362f          	sc.d.rl	a2,a5,(a0)
    8000604c:	fa75                	bnez	a2,80006040 <write_release+0x1a>
    8000604e:	40e687b3          	sub	a5,a3,a4
    80006052:	8736                	mv	a4,a3
    80006054:	fff1                	bnez	a5,80006030 <write_release+0xa>
  pop_off();
    80006056:	e31ff0ef          	jal	80005e86 <pop_off>
}
    8000605a:	60a2                	ld	ra,8(sp)
    8000605c:	6402                	ld	s0,0(sp)
    8000605e:	0141                	addi	sp,sp,16
    80006060:	8082                	ret
      panic("write_release: not held by writer");
    80006062:	00002517          	auipc	a0,0x2
    80006066:	70e50513          	addi	a0,a0,1806 # 80008770 <etext+0x770>
    8000606a:	9f5ff0ef          	jal	80005a5e <panic>

000000008000606e <sys_rwlktest>:
{
    8000606e:	7159                	addi	sp,sp,-112
    80006070:	f486                	sd	ra,104(sp)
    80006072:	f0a2                	sd	s0,96(sp)
    80006074:	eca6                	sd	s1,88(sp)
    80006076:	e8ca                	sd	s2,80(sp)
    80006078:	e4ce                	sd	s3,72(sp)
    8000607a:	e0d2                	sd	s4,64(sp)
    8000607c:	fc56                	sd	s5,56(sp)
    8000607e:	f85a                	sd	s6,48(sp)
    80006080:	f45e                	sd	s7,40(sp)
    80006082:	f062                	sd	s8,32(sp)
    80006084:	ec66                	sd	s9,24(sp)
    80006086:	e86a                	sd	s10,16(sp)
    80006088:	1880                	addi	s0,sp,112
  push_off();
    8000608a:	ccdff0ef          	jal	80005d56 <push_off>
  int id = cpuid();
    8000608e:	d73fa0ef          	jal	80000e00 <cpuid>
    80006092:	8baa                	mv	s7,a0
  rwspinlock_test_step(++step, "initrwlock");
    80006094:	00002597          	auipc	a1,0x2
    80006098:	70458593          	addi	a1,a1,1796 # 80008798 <etext+0x798>
    8000609c:	4505                	li	a0,1
    8000609e:	c29ff0ef          	jal	80005cc6 <rwspinlock_test_step>
  if (id == 0) {
    800060a2:	0c0b8163          	beqz	s7,80006164 <sys_rwlktest+0xf6>
  rwspinlock_test_step(++step, "concurrent read_acquire");
    800060a6:	00002597          	auipc	a1,0x2
    800060aa:	70258593          	addi	a1,a1,1794 # 800087a8 <etext+0x7a8>
    800060ae:	4509                	li	a0,2
    800060b0:	c17ff0ef          	jal	80005cc6 <rwspinlock_test_step>
    800060b4:	000f44b7          	lui	s1,0xf4
    800060b8:	24048493          	addi	s1,s1,576 # f4240 <_entry-0x7ff0bdc0>
    read_acquire(&l);
    800060bc:	00003917          	auipc	s2,0x3
    800060c0:	c5c90913          	addi	s2,s2,-932 # 80008d18 <l.5>
    800060c4:	854a                	mv	a0,s2
    800060c6:	d27ff0ef          	jal	80005dec <read_acquire>
  for (int i = 0; i < 1000000; i++)
    800060ca:	34fd                	addiw	s1,s1,-1
    800060cc:	fce5                	bnez	s1,800060c4 <sys_rwlktest+0x56>
  rwspinlock_test_step(++step, "concurrent read_release");
    800060ce:	00002597          	auipc	a1,0x2
    800060d2:	6f258593          	addi	a1,a1,1778 # 800087c0 <etext+0x7c0>
    800060d6:	450d                	li	a0,3
    800060d8:	befff0ef          	jal	80005cc6 <rwspinlock_test_step>
    800060dc:	000f4937          	lui	s2,0xf4
    800060e0:	24090913          	addi	s2,s2,576 # f4240 <_entry-0x7ff0bdc0>
    read_release(&l);
    800060e4:	00003997          	auipc	s3,0x3
    800060e8:	c3498993          	addi	s3,s3,-972 # 80008d18 <l.5>
    800060ec:	854e                	mv	a0,s3
    800060ee:	ef5ff0ef          	jal	80005fe2 <read_release>
  for (int i = 0; i < 1000000; i++)
    800060f2:	fff9049b          	addiw	s1,s2,-1
    800060f6:	8926                	mv	s2,s1
    800060f8:	f8f5                	bnez	s1,800060ec <sys_rwlktest+0x7e>
  rwspinlock_test_step(++step, "prepare read_acquire for writer priority test");
    800060fa:	00002597          	auipc	a1,0x2
    800060fe:	6de58593          	addi	a1,a1,1758 # 800087d8 <etext+0x7d8>
    80006102:	4511                	li	a0,4
    80006104:	bc3ff0ef          	jal	80005cc6 <rwspinlock_test_step>
  if (id == 1) {
    80006108:	4785                	li	a5,1
    8000610a:	06fb8263          	beq	s7,a5,8000616e <sys_rwlktest+0x100>
  rwspinlock_test_step(++step, "writer priority test");
    8000610e:	00002597          	auipc	a1,0x2
    80006112:	6fa58593          	addi	a1,a1,1786 # 80008808 <etext+0x808>
    80006116:	4515                	li	a0,5
    80006118:	bafff0ef          	jal	80005cc6 <rwspinlock_test_step>
  if (id == 0) {
    8000611c:	0c0b8363          	beqz	s7,800061e2 <sys_rwlktest+0x174>
  if (id == 2) {
    80006120:	4789                	li	a5,2
    80006122:	0efb9263          	bne	s7,a5,80006206 <sys_rwlktest+0x198>
    delay();
    80006126:	b6dff0ef          	jal	80005c92 <delay>
    read_acquire(&l);
    8000612a:	00003517          	auipc	a0,0x3
    8000612e:	bee50513          	addi	a0,a0,-1042 # 80008d18 <l.5>
    80006132:	cbbff0ef          	jal	80005dec <read_acquire>
    uint f = __atomic_load_n(&flag, __ATOMIC_RELAXED);
    80006136:	00003797          	auipc	a5,0x3
    8000613a:	bda78793          	addi	a5,a5,-1062 # 80008d10 <flag.4>
    8000613e:	439c                	lw	a5,0(a5)
    80006140:	2781                	sext.w	a5,a5
  int r = 0;
    80006142:	4c01                	li	s8,0
    if (f == 0) {
    80006144:	0e078a63          	beqz	a5,80006238 <sys_rwlktest+0x1ca>
    read_release(&l);
    80006148:	00003517          	auipc	a0,0x3
    8000614c:	bd050513          	addi	a0,a0,-1072 # 80008d18 <l.5>
    80006150:	e93ff0ef          	jal	80005fe2 <read_release>
  rwspinlock_test_step(++step, "checking for concurrent readers/writers");
    80006154:	00002597          	auipc	a1,0x2
    80006158:	70c58593          	addi	a1,a1,1804 # 80008860 <etext+0x860>
    8000615c:	4519                	li	a0,6
    8000615e:	b69ff0ef          	jal	80005cc6 <rwspinlock_test_step>
  if (id == 0) {
    80006162:	a0e5                	j	8000624a <sys_rwlktest+0x1dc>
  rwlk->state=0;
    80006164:	00003797          	auipc	a5,0x3
    80006168:	ba07ba23          	sd	zero,-1100(a5) # 80008d18 <l.5>
    8000616c:	bf2d                	j	800060a6 <sys_rwlktest+0x38>
  if (id == 1) {
    8000616e:	49f9                	li	s3,30
      read_acquire(&l);
    80006170:	00003a17          	auipc	s4,0x3
    80006174:	ba8a0a13          	addi	s4,s4,-1112 # 80008d18 <l.5>
    80006178:	8552                	mv	a0,s4
    8000617a:	c73ff0ef          	jal	80005dec <read_acquire>
    for (int i = 0; i < 30; i++) {
    8000617e:	39fd                	addiw	s3,s3,-1
    80006180:	fe099ce3          	bnez	s3,80006178 <sys_rwlktest+0x10a>
  rwspinlock_test_step(++step, "writer priority test");
    80006184:	00002597          	auipc	a1,0x2
    80006188:	68458593          	addi	a1,a1,1668 # 80008808 <etext+0x808>
    8000618c:	4515                	li	a0,5
    8000618e:	b39ff0ef          	jal	80005cc6 <rwspinlock_test_step>
    delay();
    80006192:	b01ff0ef          	jal	80005c92 <delay>
    80006196:	49a9                	li	s3,10
      read_release(&l);
    80006198:	00003a17          	auipc	s4,0x3
    8000619c:	b80a0a13          	addi	s4,s4,-1152 # 80008d18 <l.5>
    800061a0:	8552                	mv	a0,s4
    800061a2:	e41ff0ef          	jal	80005fe2 <read_release>
    for (int i = 0; i < 10; i++) {
    800061a6:	39fd                	addiw	s3,s3,-1
    800061a8:	fe099ce3          	bnez	s3,800061a0 <sys_rwlktest+0x132>
    delay();
    800061ac:	ae7ff0ef          	jal	80005c92 <delay>
    800061b0:	49a9                	li	s3,10
      read_release(&l);
    800061b2:	00003a17          	auipc	s4,0x3
    800061b6:	b66a0a13          	addi	s4,s4,-1178 # 80008d18 <l.5>
    800061ba:	8552                	mv	a0,s4
    800061bc:	e27ff0ef          	jal	80005fe2 <read_release>
    for (int i = 0; i < 10; i++) {
    800061c0:	39fd                	addiw	s3,s3,-1
    800061c2:	fe099ce3          	bnez	s3,800061ba <sys_rwlktest+0x14c>
    delay();
    800061c6:	acdff0ef          	jal	80005c92 <delay>
    800061ca:	49a9                	li	s3,10
      read_release(&l);
    800061cc:	00003a17          	auipc	s4,0x3
    800061d0:	b4ca0a13          	addi	s4,s4,-1204 # 80008d18 <l.5>
    800061d4:	8552                	mv	a0,s4
    800061d6:	e0dff0ef          	jal	80005fe2 <read_release>
    for (int i = 0; i < 10; i++) {
    800061da:	39fd                	addiw	s3,s3,-1
    800061dc:	fe099ce3          	bnez	s3,800061d4 <sys_rwlktest+0x166>
    800061e0:	a01d                	j	80006206 <sys_rwlktest+0x198>
    write_acquire(&l);
    800061e2:	00003517          	auipc	a0,0x3
    800061e6:	b3650513          	addi	a0,a0,-1226 # 80008d18 <l.5>
    800061ea:	c47ff0ef          	jal	80005e30 <write_acquire>
    __atomic_store_n(&flag, 1, __ATOMIC_RELAXED);
    800061ee:	00003797          	auipc	a5,0x3
    800061f2:	b2278793          	addi	a5,a5,-1246 # 80008d10 <flag.4>
    800061f6:	4705                	li	a4,1
    800061f8:	c398                	sw	a4,0(a5)
    write_release(&l);
    800061fa:	00003517          	auipc	a0,0x3
    800061fe:	b1e50513          	addi	a0,a0,-1250 # 80008d18 <l.5>
    80006202:	e25ff0ef          	jal	80006026 <write_release>
  rwspinlock_test_step(++step, "checking for concurrent readers/writers");
    80006206:	00002597          	auipc	a1,0x2
    8000620a:	65a58593          	addi	a1,a1,1626 # 80008860 <etext+0x860>
    8000620e:	4519                	li	a0,6
    80006210:	ab7ff0ef          	jal	80005cc6 <rwspinlock_test_step>
    uint maxwv = 0;
    80006214:	8a26                	mv	s4,s1
  if (id == 0) {
    80006216:	000f49b7          	lui	s3,0xf4
    8000621a:	24098993          	addi	s3,s3,576 # f4240 <_entry-0x7ff0bdc0>
    8000621e:	020b9563          	bnez	s7,80006248 <sys_rwlktest+0x1da>
      write_acquire(&l);
    80006222:	00003a97          	auipc	s5,0x3
    80006226:	af6a8a93          	addi	s5,s5,-1290 # 80008d18 <l.5>
      uint x = __atomic_add_fetch(&v, 1, __ATOMIC_ACQ_REL);
    8000622a:	00003497          	auipc	s1,0x3
    8000622e:	ae248493          	addi	s1,s1,-1310 # 80008d0c <v.3>
    80006232:	4c05                	li	s8,1
      uint y = __atomic_fetch_sub(&v, 1, __ATOMIC_ACQ_REL);
    80006234:	5b7d                	li	s6,-1
    80006236:	a089                	j	80006278 <sys_rwlktest+0x20a>
      printf("rwspinlock_test: reader sneaked ahead of waiting writer\n");
    80006238:	00002517          	auipc	a0,0x2
    8000623c:	5e850513          	addi	a0,a0,1512 # 80008820 <etext+0x820>
    80006240:	ce6ff0ef          	jal	80005726 <printf>
      r = -1;
    80006244:	5c7d                	li	s8,-1
    80006246:	b709                	j	80006148 <sys_rwlktest+0xda>
  if (id == 0) {
    80006248:	4c01                	li	s8,0
    uint maxrv = 0;
    8000624a:	000f4a37          	lui	s4,0xf4
    8000624e:	240a0a13          	addi	s4,s4,576 # f4240 <_entry-0x7ff0bdc0>
      read_acquire(&l);
    80006252:	00003a97          	auipc	s5,0x3
    80006256:	ac6a8a93          	addi	s5,s5,-1338 # 80008d18 <l.5>
      uint x = __atomic_add_fetch(&v, 1, __ATOMIC_ACQ_REL);
    8000625a:	00003997          	auipc	s3,0x3
    8000625e:	ab298993          	addi	s3,s3,-1358 # 80008d0c <v.3>
    80006262:	4c85                	li	s9,1
      uint y = __atomic_fetch_sub(&v, 1, __ATOMIC_ACQ_REL);
    80006264:	5b7d                	li	s6,-1
    80006266:	a09d                	j	800062cc <sys_rwlktest+0x25e>
      if (y > maxwv) {
    80006268:	00070a1b          	sext.w	s4,a4
      write_release(&l);
    8000626c:	8556                	mv	a0,s5
    8000626e:	db9ff0ef          	jal	80006026 <write_release>
    for (int i = 0; i < 1000000; i++) {
    80006272:	39fd                	addiw	s3,s3,-1
    80006274:	02098663          	beqz	s3,800062a0 <sys_rwlktest+0x232>
      write_acquire(&l);
    80006278:	8556                	mv	a0,s5
    8000627a:	bb7ff0ef          	jal	80005e30 <write_acquire>
      uint x = __atomic_add_fetch(&v, 1, __ATOMIC_ACQ_REL);
    8000627e:	0784a72f          	amoadd.w.aqrl	a4,s8,(s1)
    80006282:	2705                	addiw	a4,a4,1
      uint y = __atomic_fetch_sub(&v, 1, __ATOMIC_ACQ_REL);
    80006284:	0764a6af          	amoadd.w.aqrl	a3,s6,(s1)
      if (y > maxwv) {
    80006288:	87ba                	mv	a5,a4
    8000628a:	0006861b          	sext.w	a2,a3
    8000628e:	00c77363          	bgeu	a4,a2,80006294 <sys_rwlktest+0x226>
    80006292:	87b6                	mv	a5,a3
    80006294:	873e                	mv	a4,a5
    80006296:	2781                	sext.w	a5,a5
    80006298:	fd47f8e3          	bgeu	a5,s4,80006268 <sys_rwlktest+0x1fa>
    8000629c:	8752                	mv	a4,s4
    8000629e:	b7e9                	j	80006268 <sys_rwlktest+0x1fa>
    if (maxwv > 1) {
    800062a0:	4785                	li	a5,1
    800062a2:	8c5e                	mv	s8,s7
    800062a4:	0547fb63          	bgeu	a5,s4,800062fa <sys_rwlktest+0x28c>
      printf("rwspinlock_test: cpu %d saw concurrent reads/writes: %d\n", id, maxwv);
    800062a8:	8652                	mv	a2,s4
    800062aa:	4581                	li	a1,0
    800062ac:	00002517          	auipc	a0,0x2
    800062b0:	5dc50513          	addi	a0,a0,1500 # 80008888 <etext+0x888>
    800062b4:	c72ff0ef          	jal	80005726 <printf>
      r = -1;
    800062b8:	5c7d                	li	s8,-1
    800062ba:	a081                	j	800062fa <sys_rwlktest+0x28c>
      if (y > maxrv) {
    800062bc:	0007049b          	sext.w	s1,a4
      read_release(&l);
    800062c0:	8556                	mv	a0,s5
    800062c2:	d21ff0ef          	jal	80005fe2 <read_release>
    for (int i = 0; i < 1000000; i++) {
    800062c6:	3a7d                	addiw	s4,s4,-1
    800062c8:	020a0663          	beqz	s4,800062f4 <sys_rwlktest+0x286>
      read_acquire(&l);
    800062cc:	8556                	mv	a0,s5
    800062ce:	b1fff0ef          	jal	80005dec <read_acquire>
      uint x = __atomic_add_fetch(&v, 1, __ATOMIC_ACQ_REL);
    800062d2:	0799a72f          	amoadd.w.aqrl	a4,s9,(s3)
    800062d6:	2705                	addiw	a4,a4,1
      uint y = __atomic_fetch_sub(&v, 1, __ATOMIC_ACQ_REL);
    800062d8:	0769a6af          	amoadd.w.aqrl	a3,s6,(s3)
      if (y > maxrv) {
    800062dc:	87ba                	mv	a5,a4
    800062de:	0006861b          	sext.w	a2,a3
    800062e2:	00c77363          	bgeu	a4,a2,800062e8 <sys_rwlktest+0x27a>
    800062e6:	87b6                	mv	a5,a3
    800062e8:	873e                	mv	a4,a5
    800062ea:	2781                	sext.w	a5,a5
    800062ec:	fc97f8e3          	bgeu	a5,s1,800062bc <sys_rwlktest+0x24e>
    800062f0:	8726                	mv	a4,s1
    800062f2:	b7e9                	j	800062bc <sys_rwlktest+0x24e>
    if (maxrv < 2) {
    800062f4:	4785                	li	a5,1
    800062f6:	0297f863          	bgeu	a5,s1,80006326 <sys_rwlktest+0x2b8>
  rwspinlock_test_step(++step, "checking for concurrent writers");
    800062fa:	00002597          	auipc	a1,0x2
    800062fe:	60658593          	addi	a1,a1,1542 # 80008900 <etext+0x900>
    80006302:	451d                	li	a0,7
    80006304:	9c3ff0ef          	jal	80005cc6 <rwspinlock_test_step>
    80006308:	000f49b7          	lui	s3,0xf4
    8000630c:	24098993          	addi	s3,s3,576 # f4240 <_entry-0x7ff0bdc0>
    write_acquire(&l);
    80006310:	00003a17          	auipc	s4,0x3
    80006314:	a08a0a13          	addi	s4,s4,-1528 # 80008d18 <l.5>
    uint x = __atomic_add_fetch(&v, 1, __ATOMIC_ACQ_REL);
    80006318:	00003497          	auipc	s1,0x3
    8000631c:	9f448493          	addi	s1,s1,-1548 # 80008d0c <v.3>
    80006320:	4b05                	li	s6,1
    uint y = __atomic_fetch_sub(&v, 1, __ATOMIC_ACQ_REL);
    80006322:	5afd                	li	s5,-1
    80006324:	a015                	j	80006348 <sys_rwlktest+0x2da>
      printf("rwspinlock_test: cpu %d never saw concurrent reads: %d\n", id, maxrv);
    80006326:	8626                	mv	a2,s1
    80006328:	85de                	mv	a1,s7
    8000632a:	00002517          	auipc	a0,0x2
    8000632e:	59e50513          	addi	a0,a0,1438 # 800088c8 <etext+0x8c8>
    80006332:	bf4ff0ef          	jal	80005726 <printf>
      r = -1;
    80006336:	b749                	j	800062b8 <sys_rwlktest+0x24a>
    if (y > maxwv) {
    80006338:	0007091b          	sext.w	s2,a4
    write_release(&l);
    8000633c:	8552                	mv	a0,s4
    8000633e:	ce9ff0ef          	jal	80006026 <write_release>
  for (int i = 0; i < 1000000; i++) {
    80006342:	39fd                	addiw	s3,s3,-1
    80006344:	02098663          	beqz	s3,80006370 <sys_rwlktest+0x302>
    write_acquire(&l);
    80006348:	8552                	mv	a0,s4
    8000634a:	ae7ff0ef          	jal	80005e30 <write_acquire>
    uint x = __atomic_add_fetch(&v, 1, __ATOMIC_ACQ_REL);
    8000634e:	0764a72f          	amoadd.w.aqrl	a4,s6,(s1)
    80006352:	2705                	addiw	a4,a4,1
    uint y = __atomic_fetch_sub(&v, 1, __ATOMIC_ACQ_REL);
    80006354:	0754a6af          	amoadd.w.aqrl	a3,s5,(s1)
    if (y > maxwv) {
    80006358:	87ba                	mv	a5,a4
    8000635a:	0006861b          	sext.w	a2,a3
    8000635e:	00c77363          	bgeu	a4,a2,80006364 <sys_rwlktest+0x2f6>
    80006362:	87b6                	mv	a5,a3
    80006364:	873e                	mv	a4,a5
    80006366:	2781                	sext.w	a5,a5
    80006368:	fd27f8e3          	bgeu	a5,s2,80006338 <sys_rwlktest+0x2ca>
    8000636c:	874a                	mv	a4,s2
    8000636e:	b7e9                	j	80006338 <sys_rwlktest+0x2ca>
  if (maxwv > 1) {
    80006370:	4785                	li	a5,1
    80006372:	0727eb63          	bltu	a5,s2,800063e8 <sys_rwlktest+0x37a>
  rwspinlock_test_step(++step, "acquiring multiple locks");
    80006376:	00002597          	auipc	a1,0x2
    8000637a:	5e258593          	addi	a1,a1,1506 # 80008958 <etext+0x958>
    8000637e:	4521                	li	a0,8
    80006380:	947ff0ef          	jal	80005cc6 <rwspinlock_test_step>
  rwlk->state=0;
    80006384:	f8043c23          	sd	zero,-104(s0)
  write_acquire(&l2);
    80006388:	f9840493          	addi	s1,s0,-104
    8000638c:	8526                	mv	a0,s1
    8000638e:	aa3ff0ef          	jal	80005e30 <write_acquire>
  read_acquire(&l);
    80006392:	00003517          	auipc	a0,0x3
    80006396:	98650513          	addi	a0,a0,-1658 # 80008d18 <l.5>
    8000639a:	a53ff0ef          	jal	80005dec <read_acquire>
  rwspinlock_test_step(++step, "releasing multiple locks");
    8000639e:	00002597          	auipc	a1,0x2
    800063a2:	5da58593          	addi	a1,a1,1498 # 80008978 <etext+0x978>
    800063a6:	4525                	li	a0,9
    800063a8:	91fff0ef          	jal	80005cc6 <rwspinlock_test_step>
  write_release(&l2);
    800063ac:	8526                	mv	a0,s1
    800063ae:	c79ff0ef          	jal	80006026 <write_release>
  read_release(&l);
    800063b2:	00003517          	auipc	a0,0x3
    800063b6:	96650513          	addi	a0,a0,-1690 # 80008d18 <l.5>
    800063ba:	c29ff0ef          	jal	80005fe2 <read_release>
    800063be:	44ad                	li	s1,11
    rwspinlock_test_step(++step, "prepare read_acquire for multiple writer priority test");
    800063c0:	00002a97          	auipc	s5,0x2
    800063c4:	5d8a8a93          	addi	s5,s5,1496 # 80008998 <etext+0x998>
    if (id == 3) {
    800063c8:	498d                	li	s3,3
    rwspinlock_test_step(++step, "multiple writer priority test");
    800063ca:	00002b17          	auipc	s6,0x2
    800063ce:	606b0b13          	addi	s6,s6,1542 # 800089d0 <etext+0x9d0>
    if (id == 0 || id == 1) {
    800063d2:	4c85                	li	s9,1
    if (id == 2) {
    800063d4:	4d09                	li	s10,2
      read_acquire(&l);
    800063d6:	00003917          	auipc	s2,0x3
    800063da:	94290913          	addi	s2,s2,-1726 # 80008d18 <l.5>
      if (writer_count == 0) {
    800063de:	00003a17          	auipc	s4,0x3
    800063e2:	92aa0a13          	addi	s4,s4,-1750 # 80008d08 <writer_count.2>
    800063e6:	a059                	j	8000646c <sys_rwlktest+0x3fe>
    printf("rwspinlock_test: cpu %d saw concurrent writes: %d\n", id, maxwv);
    800063e8:	864a                	mv	a2,s2
    800063ea:	85de                	mv	a1,s7
    800063ec:	00002517          	auipc	a0,0x2
    800063f0:	53450513          	addi	a0,a0,1332 # 80008920 <etext+0x920>
    800063f4:	b32ff0ef          	jal	80005726 <printf>
    r = -1;
    800063f8:	5c7d                	li	s8,-1
    800063fa:	bfb5                	j	80006376 <sys_rwlktest+0x308>
      writer_count = 0;
    800063fc:	000a2023          	sw	zero,0(s4)
      read_acquire(&l);
    80006400:	854a                	mv	a0,s2
    80006402:	9ebff0ef          	jal	80005dec <read_acquire>
      read_acquire(&l);
    80006406:	854a                	mv	a0,s2
    80006408:	9e5ff0ef          	jal	80005dec <read_acquire>
    rwspinlock_test_step(++step, "multiple writer priority test");
    8000640c:	85da                	mv	a1,s6
    8000640e:	8526                	mv	a0,s1
    80006410:	8b7ff0ef          	jal	80005cc6 <rwspinlock_test_step>
    if (id == 3) {
    80006414:	053b9863          	bne	s7,s3,80006464 <sys_rwlktest+0x3f6>
      delay();
    80006418:	87bff0ef          	jal	80005c92 <delay>
      read_release(&l);
    8000641c:	854a                	mv	a0,s2
    8000641e:	bc5ff0ef          	jal	80005fe2 <read_release>
      delay();
    80006422:	871ff0ef          	jal	80005c92 <delay>
      read_release(&l);
    80006426:	854a                	mv	a0,s2
    80006428:	bbbff0ef          	jal	80005fe2 <read_release>
      delay();
    8000642c:	867ff0ef          	jal	80005c92 <delay>
      delay();
    80006430:	863ff0ef          	jal	80005c92 <delay>
      read_acquire(&l);
    80006434:	854a                	mv	a0,s2
    80006436:	9b7ff0ef          	jal	80005dec <read_acquire>
      if (writer_count != 2) {
    8000643a:	000a2783          	lw	a5,0(s4)
    8000643e:	09a79063          	bne	a5,s10,800064be <sys_rwlktest+0x450>
      read_release(&l);
    80006442:	854a                	mv	a0,s2
    80006444:	b9fff0ef          	jal	80005fe2 <read_release>
    80006448:	a831                	j	80006464 <sys_rwlktest+0x3f6>
      write_acquire(&l);
    8000644a:	854a                	mv	a0,s2
    8000644c:	9e5ff0ef          	jal	80005e30 <write_acquire>
      writer_count++;
    80006450:	000a2783          	lw	a5,0(s4)
    80006454:	2785                	addiw	a5,a5,1
    80006456:	00fa2023          	sw	a5,0(s4)
      delay();
    8000645a:	839ff0ef          	jal	80005c92 <delay>
      write_release(&l);
    8000645e:	854a                	mv	a0,s2
    80006460:	bc7ff0ef          	jal	80006026 <write_release>
  for (int i = 0; i < 10; i++) {
    80006464:	2489                	addiw	s1,s1,2
    80006466:	47fd                	li	a5,31
    80006468:	06f48363          	beq	s1,a5,800064ce <sys_rwlktest+0x460>
    rwspinlock_test_step(++step, "prepare read_acquire for multiple writer priority test");
    8000646c:	85d6                	mv	a1,s5
    8000646e:	fff4851b          	addiw	a0,s1,-1
    80006472:	855ff0ef          	jal	80005cc6 <rwspinlock_test_step>
    if (id == 3) {
    80006476:	f93b83e3          	beq	s7,s3,800063fc <sys_rwlktest+0x38e>
    rwspinlock_test_step(++step, "multiple writer priority test");
    8000647a:	85da                	mv	a1,s6
    8000647c:	8526                	mv	a0,s1
    8000647e:	849ff0ef          	jal	80005cc6 <rwspinlock_test_step>
    if (id == 0 || id == 1) {
    80006482:	fd7cf4e3          	bgeu	s9,s7,8000644a <sys_rwlktest+0x3dc>
    if (id == 2) {
    80006486:	fdab9fe3          	bne	s7,s10,80006464 <sys_rwlktest+0x3f6>
      delay();
    8000648a:	809ff0ef          	jal	80005c92 <delay>
      read_acquire(&l);
    8000648e:	854a                	mv	a0,s2
    80006490:	95dff0ef          	jal	80005dec <read_acquire>
      if (writer_count == 0) {
    80006494:	000a2783          	lw	a5,0(s4)
    80006498:	cb99                	beqz	a5,800064ae <sys_rwlktest+0x440>
      delay();
    8000649a:	ff8ff0ef          	jal	80005c92 <delay>
      delay();
    8000649e:	ff4ff0ef          	jal	80005c92 <delay>
      delay();
    800064a2:	ff0ff0ef          	jal	80005c92 <delay>
      read_release(&l);
    800064a6:	854a                	mv	a0,s2
    800064a8:	b3bff0ef          	jal	80005fe2 <read_release>
    if (id == 3) {
    800064ac:	bf65                	j	80006464 <sys_rwlktest+0x3f6>
        printf("rwspinlock_test: reader sneaked ahead of both waiting writers\n");
    800064ae:	00002517          	auipc	a0,0x2
    800064b2:	54250513          	addi	a0,a0,1346 # 800089f0 <etext+0x9f0>
    800064b6:	a70ff0ef          	jal	80005726 <printf>
        r = -1;
    800064ba:	5c7d                	li	s8,-1
    800064bc:	bff9                	j	8000649a <sys_rwlktest+0x42c>
        printf("rwspinlock_test: reader sneaked ahead of second waiting writer\n");
    800064be:	00002517          	auipc	a0,0x2
    800064c2:	57250513          	addi	a0,a0,1394 # 80008a30 <etext+0xa30>
    800064c6:	a60ff0ef          	jal	80005726 <printf>
        r = -1;
    800064ca:	5c7d                	li	s8,-1
    800064cc:	bf9d                	j	80006442 <sys_rwlktest+0x3d4>
  rwspinlock_test_step(++step, "done");
    800064ce:	00002597          	auipc	a1,0x2
    800064d2:	5a258593          	addi	a1,a1,1442 # 80008a70 <etext+0xa70>
    800064d6:	4579                	li	a0,30
    800064d8:	feeff0ef          	jal	80005cc6 <rwspinlock_test_step>
  printf("rwspinlock_test(%d): %d\n", id, r);
    800064dc:	8662                	mv	a2,s8
    800064de:	85de                	mv	a1,s7
    800064e0:	00002517          	auipc	a0,0x2
    800064e4:	59850513          	addi	a0,a0,1432 # 80008a78 <etext+0xa78>
    800064e8:	a3eff0ef          	jal	80005726 <printf>
  pop_off();
    800064ec:	99bff0ef          	jal	80005e86 <pop_off>
}
    800064f0:	8562                	mv	a0,s8
    800064f2:	70a6                	ld	ra,104(sp)
    800064f4:	7406                	ld	s0,96(sp)
    800064f6:	64e6                	ld	s1,88(sp)
    800064f8:	6946                	ld	s2,80(sp)
    800064fa:	69a6                	ld	s3,72(sp)
    800064fc:	6a06                	ld	s4,64(sp)
    800064fe:	7ae2                	ld	s5,56(sp)
    80006500:	7b42                	ld	s6,48(sp)
    80006502:	7ba2                	ld	s7,40(sp)
    80006504:	7c02                	ld	s8,32(sp)
    80006506:	6ce2                	ld	s9,24(sp)
    80006508:	6d42                	ld	s10,16(sp)
    8000650a:	6165                	addi	sp,sp,112
    8000650c:	8082                	ret

000000008000650e <atomic_read4>:

// Read a shared 32-bit value without holding a lock
int
atomic_read4(int *addr) {
    8000650e:	1141                	addi	sp,sp,-16
    80006510:	e406                	sd	ra,8(sp)
    80006512:	e022                	sd	s0,0(sp)
    80006514:	0800                	addi	s0,sp,16
  uint32 val;
  __atomic_load(addr, &val, __ATOMIC_SEQ_CST);
    80006516:	0330000f          	fence	rw,rw
    8000651a:	4108                	lw	a0,0(a0)
    8000651c:	0230000f          	fence	r,rw
  return val;
}
    80006520:	2501                	sext.w	a0,a0
    80006522:	60a2                	ld	ra,8(sp)
    80006524:	6402                	ld	s0,0(sp)
    80006526:	0141                	addi	sp,sp,16
    80006528:	8082                	ret

000000008000652a <snprint_lock>:
#ifdef LAB_LOCK
int
snprint_lock(char *buf, int sz, struct spinlock *lk)
{
  int n = 0;
  if(lk->n > 0) {
    8000652a:	4e5c                	lw	a5,28(a2)
    8000652c:	00f04463          	bgtz	a5,80006534 <snprint_lock+0xa>
  int n = 0;
    80006530:	4501                	li	a0,0
    n = snprintf(buf, sz, "lock: %s: #test-and-set %d #acquire() %d\n",
                 lk->name, lk->nts, lk->n);
  }
  return n;
}
    80006532:	8082                	ret
{
    80006534:	1141                	addi	sp,sp,-16
    80006536:	e406                	sd	ra,8(sp)
    80006538:	e022                	sd	s0,0(sp)
    8000653a:	0800                	addi	s0,sp,16
    n = snprintf(buf, sz, "lock: %s: #test-and-set %d #acquire() %d\n",
    8000653c:	4e18                	lw	a4,24(a2)
    8000653e:	6614                	ld	a3,8(a2)
    80006540:	00002617          	auipc	a2,0x2
    80006544:	55860613          	addi	a2,a2,1368 # 80008a98 <etext+0xa98>
    80006548:	b69fe0ef          	jal	800050b0 <snprintf>
}
    8000654c:	60a2                	ld	ra,8(sp)
    8000654e:	6402                	ld	s0,0(sp)
    80006550:	0141                	addi	sp,sp,16
    80006552:	8082                	ret

0000000080006554 <statslock>:

int
statslock(char *buf, int sz) {
    80006554:	711d                	addi	sp,sp,-96
    80006556:	ec86                	sd	ra,88(sp)
    80006558:	e8a2                	sd	s0,80(sp)
    8000655a:	e4a6                	sd	s1,72(sp)
    8000655c:	e0ca                	sd	s2,64(sp)
    8000655e:	fc4e                	sd	s3,56(sp)
    80006560:	f852                	sd	s4,48(sp)
    80006562:	f456                	sd	s5,40(sp)
    80006564:	f05a                	sd	s6,32(sp)
    80006566:	ec5e                	sd	s7,24(sp)
    80006568:	e862                	sd	s8,16(sp)
    8000656a:	e466                	sd	s9,8(sp)
    8000656c:	e06a                	sd	s10,0(sp)
    8000656e:	1080                	addi	s0,sp,96
    80006570:	8aaa                	mv	s5,a0
    80006572:	8b2e                	mv	s6,a1
  int n;
  int tot = 0;

  acquire(&lock_locks);
    80006574:	0001d517          	auipc	a0,0x1d
    80006578:	40c50513          	addi	a0,a0,1036 # 80023980 <lock_locks>
    8000657c:	81fff0ef          	jal	80005d9a <acquire>
  n = snprintf(buf, sz, "--- lock kmem stats\n");
    80006580:	00002617          	auipc	a2,0x2
    80006584:	54860613          	addi	a2,a2,1352 # 80008ac8 <etext+0xac8>
    80006588:	85da                	mv	a1,s6
    8000658a:	8556                	mv	a0,s5
    8000658c:	b25fe0ef          	jal	800050b0 <snprintf>
    80006590:	8a2a                	mv	s4,a0
  for(int i = 0; i < NLOCK; i++) {
    80006592:	0001dc17          	auipc	s8,0x1d
    80006596:	40ec0c13          	addi	s8,s8,1038 # 800239a0 <locks>
    8000659a:	0001ec97          	auipc	s9,0x1e
    8000659e:	3a6c8c93          	addi	s9,s9,934 # 80024940 <end>
  n = snprintf(buf, sz, "--- lock kmem stats\n");
    800065a2:	84e2                	mv	s1,s8
  int tot = 0;
    800065a4:	4b81                	li	s7,0
    if(locks[i] == 0)
      break;
    if(strncmp(locks[i]->name, "kmem", strlen("kmem")) == 0) {
    800065a6:	00002917          	auipc	s2,0x2
    800065aa:	53a90913          	addi	s2,s2,1338 # 80008ae0 <etext+0xae0>
    800065ae:	a021                	j	800065b6 <statslock+0x62>
  for(int i = 0; i < NLOCK; i++) {
    800065b0:	04a1                	addi	s1,s1,8
    800065b2:	03948c63          	beq	s1,s9,800065ea <statslock+0x96>
    if(locks[i] == 0)
    800065b6:	609c                	ld	a5,0(s1)
    800065b8:	cb8d                	beqz	a5,800065ea <statslock+0x96>
    if(strncmp(locks[i]->name, "kmem", strlen("kmem")) == 0) {
    800065ba:	0087b983          	ld	s3,8(a5)
    800065be:	854a                	mv	a0,s2
    800065c0:	df7f90ef          	jal	800003b6 <strlen>
    800065c4:	862a                	mv	a2,a0
    800065c6:	85ca                	mv	a1,s2
    800065c8:	854e                	mv	a0,s3
    800065ca:	d3df90ef          	jal	80000306 <strncmp>
    800065ce:	f16d                	bnez	a0,800065b0 <statslock+0x5c>
      tot += locks[i]->nts;
    800065d0:	6090                	ld	a2,0(s1)
    800065d2:	4e1c                	lw	a5,24(a2)
    800065d4:	01778bbb          	addw	s7,a5,s7
      n += snprint_lock(buf +n, sz-n, locks[i]);
    800065d8:	414b05bb          	subw	a1,s6,s4
    800065dc:	014a8533          	add	a0,s5,s4
    800065e0:	f4bff0ef          	jal	8000652a <snprint_lock>
    800065e4:	01450a3b          	addw	s4,a0,s4
    800065e8:	b7e1                	j	800065b0 <statslock+0x5c>
    }
  }
  
  n += snprintf(buf+n, sz-n, "--- top 5 contended locks:\n");
    800065ea:	00002617          	auipc	a2,0x2
    800065ee:	4fe60613          	addi	a2,a2,1278 # 80008ae8 <etext+0xae8>
    800065f2:	414b05bb          	subw	a1,s6,s4
    800065f6:	014a8533          	add	a0,s5,s4
    800065fa:	ab7fe0ef          	jal	800050b0 <snprintf>
    800065fe:	014509bb          	addw	s3,a0,s4
    80006602:	4a15                	li	s4,5
  int last = 100000000;
    80006604:	05f5e837          	lui	a6,0x5f5e
    80006608:	10080813          	addi	a6,a6,256 # 5f5e100 <_entry-0x7a0a1f00>
  for(int t = 0; t < 5; t++) {
    int top = 0;
    for(int i = 0; i < NLOCK; i++) {
      if(locks[i] == 0)
        break;
      if(locks[i]->nts > locks[top]->nts && locks[i]->nts < last) {
    8000660c:	0001d497          	auipc	s1,0x1d
    80006610:	39448493          	addi	s1,s1,916 # 800239a0 <locks>
    for(int i = 0; i < NLOCK; i++) {
    80006614:	1f400913          	li	s2,500
    80006618:	a891                	j	8000666c <statslock+0x118>
    8000661a:	2685                	addiw	a3,a3,1
    8000661c:	0621                	addi	a2,a2,8
    8000661e:	03268263          	beq	a3,s2,80006642 <statslock+0xee>
      if(locks[i] == 0)
    80006622:	621c                	ld	a5,0(a2)
    80006624:	cf99                	beqz	a5,80006642 <statslock+0xee>
      if(locks[i]->nts > locks[top]->nts && locks[i]->nts < last) {
    80006626:	4f98                	lw	a4,24(a5)
    80006628:	00359793          	slli	a5,a1,0x3
    8000662c:	97a6                	add	a5,a5,s1
    8000662e:	639c                	ld	a5,0(a5)
    80006630:	4f9c                	lw	a5,24(a5)
    80006632:	00e7a7b3          	slt	a5,a5,a4
    80006636:	01072733          	slt	a4,a4,a6
    8000663a:	8ff9                	and	a5,a5,a4
    8000663c:	dff9                	beqz	a5,8000661a <statslock+0xc6>
        top = i;
    8000663e:	85b6                	mv	a1,a3
    80006640:	bfe9                	j	8000661a <statslock+0xc6>
      }
    }
    n += snprint_lock(buf+n, sz-n, locks[top]);
    80006642:	058e                	slli	a1,a1,0x3
    80006644:	00b48cb3          	add	s9,s1,a1
    80006648:	000cb603          	ld	a2,0(s9)
    8000664c:	413b05bb          	subw	a1,s6,s3
    80006650:	013a8533          	add	a0,s5,s3
    80006654:	ed7ff0ef          	jal	8000652a <snprint_lock>
    80006658:	01350d3b          	addw	s10,a0,s3
    8000665c:	89ea                	mv	s3,s10
    last = locks[top]->nts;
    8000665e:	000cb783          	ld	a5,0(s9)
    80006662:	0187a803          	lw	a6,24(a5)
  for(int t = 0; t < 5; t++) {
    80006666:	3a7d                	addiw	s4,s4,-1
    80006668:	000a0663          	beqz	s4,80006674 <statslock+0x120>
  int tot = 0;
    8000666c:	8662                	mv	a2,s8
    for(int i = 0; i < NLOCK; i++) {
    8000666e:	4681                	li	a3,0
    int top = 0;
    80006670:	4581                	li	a1,0
    80006672:	bf45                	j	80006622 <statslock+0xce>
  }
  n += snprintf(buf+n, sz-n, "tot= %d\n", tot);
    80006674:	86de                	mv	a3,s7
    80006676:	00002617          	auipc	a2,0x2
    8000667a:	49260613          	addi	a2,a2,1170 # 80008b08 <etext+0xb08>
    8000667e:	41ab05bb          	subw	a1,s6,s10
    80006682:	01aa8533          	add	a0,s5,s10
    80006686:	a2bfe0ef          	jal	800050b0 <snprintf>
    8000668a:	01a50d3b          	addw	s10,a0,s10
  release(&lock_locks);  
    8000668e:	0001d517          	auipc	a0,0x1d
    80006692:	2f250513          	addi	a0,a0,754 # 80023980 <lock_locks>
    80006696:	841ff0ef          	jal	80005ed6 <release>
  return n;
}
    8000669a:	856a                	mv	a0,s10
    8000669c:	60e6                	ld	ra,88(sp)
    8000669e:	6446                	ld	s0,80(sp)
    800066a0:	64a6                	ld	s1,72(sp)
    800066a2:	6906                	ld	s2,64(sp)
    800066a4:	79e2                	ld	s3,56(sp)
    800066a6:	7a42                	ld	s4,48(sp)
    800066a8:	7aa2                	ld	s5,40(sp)
    800066aa:	7b02                	ld	s6,32(sp)
    800066ac:	6be2                	ld	s7,24(sp)
    800066ae:	6c42                	ld	s8,16(sp)
    800066b0:	6ca2                	ld	s9,8(sp)
    800066b2:	6d02                	ld	s10,0(sp)
    800066b4:	6125                	addi	sp,sp,96
    800066b6:	8082                	ret
	...

0000000080007000 <_trampoline>:
    80007000:	14051073          	csrw	sscratch,a0
    80007004:	02000537          	lui	a0,0x2000
    80007008:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000700a:	0536                	slli	a0,a0,0xd
    8000700c:	02153423          	sd	ra,40(a0)
    80007010:	02253823          	sd	sp,48(a0)
    80007014:	02353c23          	sd	gp,56(a0)
    80007018:	04453023          	sd	tp,64(a0)
    8000701c:	04553423          	sd	t0,72(a0)
    80007020:	04653823          	sd	t1,80(a0)
    80007024:	04753c23          	sd	t2,88(a0)
    80007028:	f120                	sd	s0,96(a0)
    8000702a:	f524                	sd	s1,104(a0)
    8000702c:	fd2c                	sd	a1,120(a0)
    8000702e:	e150                	sd	a2,128(a0)
    80007030:	e554                	sd	a3,136(a0)
    80007032:	e958                	sd	a4,144(a0)
    80007034:	ed5c                	sd	a5,152(a0)
    80007036:	0b053023          	sd	a6,160(a0)
    8000703a:	0b153423          	sd	a7,168(a0)
    8000703e:	0b253823          	sd	s2,176(a0)
    80007042:	0b353c23          	sd	s3,184(a0)
    80007046:	0d453023          	sd	s4,192(a0)
    8000704a:	0d553423          	sd	s5,200(a0)
    8000704e:	0d653823          	sd	s6,208(a0)
    80007052:	0d753c23          	sd	s7,216(a0)
    80007056:	0f853023          	sd	s8,224(a0)
    8000705a:	0f953423          	sd	s9,232(a0)
    8000705e:	0fa53823          	sd	s10,240(a0)
    80007062:	0fb53c23          	sd	s11,248(a0)
    80007066:	11c53023          	sd	t3,256(a0)
    8000706a:	11d53423          	sd	t4,264(a0)
    8000706e:	11e53823          	sd	t5,272(a0)
    80007072:	11f53c23          	sd	t6,280(a0)
    80007076:	140022f3          	csrr	t0,sscratch
    8000707a:	06553823          	sd	t0,112(a0)
    8000707e:	00853103          	ld	sp,8(a0)
    80007082:	02053203          	ld	tp,32(a0)
    80007086:	01053283          	ld	t0,16(a0)
    8000708a:	00053303          	ld	t1,0(a0)
    8000708e:	12000073          	sfence.vma
    80007092:	18031073          	csrw	satp,t1
    80007096:	12000073          	sfence.vma
    8000709a:	9282                	jalr	t0

000000008000709c <userret>:
    8000709c:	12000073          	sfence.vma
    800070a0:	18051073          	csrw	satp,a0
    800070a4:	12000073          	sfence.vma
    800070a8:	02000537          	lui	a0,0x2000
    800070ac:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    800070ae:	0536                	slli	a0,a0,0xd
    800070b0:	02853083          	ld	ra,40(a0)
    800070b4:	03053103          	ld	sp,48(a0)
    800070b8:	03853183          	ld	gp,56(a0)
    800070bc:	04053203          	ld	tp,64(a0)
    800070c0:	04853283          	ld	t0,72(a0)
    800070c4:	05053303          	ld	t1,80(a0)
    800070c8:	05853383          	ld	t2,88(a0)
    800070cc:	7120                	ld	s0,96(a0)
    800070ce:	7524                	ld	s1,104(a0)
    800070d0:	7d2c                	ld	a1,120(a0)
    800070d2:	6150                	ld	a2,128(a0)
    800070d4:	6554                	ld	a3,136(a0)
    800070d6:	6958                	ld	a4,144(a0)
    800070d8:	6d5c                	ld	a5,152(a0)
    800070da:	0a053803          	ld	a6,160(a0)
    800070de:	0a853883          	ld	a7,168(a0)
    800070e2:	0b053903          	ld	s2,176(a0)
    800070e6:	0b853983          	ld	s3,184(a0)
    800070ea:	0c053a03          	ld	s4,192(a0)
    800070ee:	0c853a83          	ld	s5,200(a0)
    800070f2:	0d053b03          	ld	s6,208(a0)
    800070f6:	0d853b83          	ld	s7,216(a0)
    800070fa:	0e053c03          	ld	s8,224(a0)
    800070fe:	0e853c83          	ld	s9,232(a0)
    80007102:	0f053d03          	ld	s10,240(a0)
    80007106:	0f853d83          	ld	s11,248(a0)
    8000710a:	10053e03          	ld	t3,256(a0)
    8000710e:	10853e83          	ld	t4,264(a0)
    80007112:	11053f03          	ld	t5,272(a0)
    80007116:	11853f83          	ld	t6,280(a0)
    8000711a:	7928                	ld	a0,112(a0)
    8000711c:	10200073          	sret
	...
