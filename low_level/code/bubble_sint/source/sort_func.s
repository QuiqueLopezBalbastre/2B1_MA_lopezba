
.globl SortArray

@ static void SortArray (signed int *array, int len)
@ signed int *array - r0
@ int len - r1

SortArray:
  stmdb   sp!,{r4,r5,r6,r7,r8}     @ prolog

while_loop:
  cmp   r1,#1     
  ble   sort_done   @ while (len < 1)

  mov   r2,#1     @ ordered = 1    
  mov   r3,#0     @ i
  sub   r8,r1,#1  @ len - 1
for_loop:
  cmp   r3,r8
  bge   for_done

  ldr   r4,[r0,r3,lsl #2]       @t0 = array[i]
  add   r6,r3,#1                @  i +1
  ldr   r5,[r0,r6,lsl #2]       @ t1 = array[i+1]

  cmp     r4,r5
  strge   r5,[r0,r3,lsl #2]       @ array[i] = t1
  strge   r4,[r0,r6,lsl #2]       @ array[i+1] = t0
  movge   r2,#0         @ ordered = 0

skip_swap:
  add   r3,r3,#1   @ i++
  b     for_loop

for_done:
  cmp   r2,#0
  bne   sort_done   @ if (ordered) return
  sub   r1,r1,#1    @ len--
  b     while_loop

sort_done:
  ldmia   sp!,{r4,r5,r6,r7,r8}    @ epilog
  mov     pc,lr

