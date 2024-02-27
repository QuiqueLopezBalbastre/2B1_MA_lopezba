
@int Biggest (int a, int b)
@ r0 -> a
@ r1 -> b
@ return in r0

    .global Biggest

Biggest:
  mov r2, r0    @r2 = a
  cmp r1, r0    @if(b == a)
  movgt r2, r1  @if((b > a) == true) -> r2 = b
  mov r0, r2    @return r0
  bx lr



@int Smallest (int a, int b)
@ r0 -> a
@ r1 -> b
@ return in r0

  .global Smallest
  
Smallest:
  mov r2, r0    @r2 = a
  cmp r1, r0    @if(b == a)
  movlt r2, r1  @if((b < a) == true) -> r2 = b
  mov r0, r2    @return r0
  bx lr
 


@ int TotalOfArray (int *array, int len)
@ r0 -> *array
@ r1 -> len
@ return in r0      

  .global TotalOfArray


TotalOfArray:
  ldr r2,[r0]         @r2 = *array
  add r0, r0, #4      @array++
  sub r1, r1, #1      @len--

while_sum:
  cmp r1, #0          @if(len == 0)
  ble exit_while_sum  @if(len <= 0) -> exit_while
  ldr r3,[r0]         @r3 = *array
  add r2, r2, r3      @res += v
  add r0, r0, #4      @*array++
  sub r1, r1, #1      @len--
  b while_sum
 
exit_while_sum:
  mov r0, r2
  bx lr
  
 /* 
int BiggestOfArray (int *array, int len)
{
  int res = *array++;
  len--;
  while (len != 0) {
    int v = *array++;
    if (v > res)
      res = v;
    len--;
  }

  return res;
}
  */
  
@ int BiggestOfArray(int *array, int len)
@ r0 -> *array
@ r1 -> len
@ return r0

  .global BiggestOfArray
  
BiggestOfArray:
  ldr r2,[r0]       @r2 = *array
  add r0, r0, #4    @*array++
  sub r1, r1, #1    @len--
  
while_biggest:
  cmp r1, #0
  ble exit_while_biggest
  ldr r3, [r0]
  cmp r2, r3
  movlt r2, r3
  add r0, r0, #4
  sub r1, r1, #1
  b while_biggest

exit_while_biggest:
  mov r0, r2
  bx lr
  
@ int SmallestOfArray(int *array, int len)
@ r0 -> *array
@ r1 -> len
@ return r0

  .global SmallestOfArray
  
SmallestOfArray:
  ldr r2,[r0]       @r2 = *array
  add r0, r0, #4    @*array++
  sub r1, r1, #1    @len--
  
while_smallest:
  cmp r1, #0
  ble exit_while_smallest
  ldr r3, [r0]
  cmp r2, r3
  movgt r2, r3
  add r0, r0, #4
  sub r1, r1, #1
  b while_smallest

exit_while_smallest:
  mov r0, r2
  bx lr
  
  
