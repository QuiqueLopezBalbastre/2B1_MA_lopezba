@ void Paint (unsigned short* dst, unsigned char* sprite, int stride_pixels, unsigned int color);
@ r0 -> dst
@ r1 -> sprite
@ r2 -> stride_pixels
@ r3 -> color

    .global Paint

Paint:
    stmdb sp!,{r4,r5,r6,r7,r8,r9,r10,r11,r12,r14}
    
    mov r5,#0                   @ y = 0
    @ size = BALL_SIZE
    @ size = 16

y_movement:
    
    mov r4,#0                   @ x = 0

x_movement:
    
    ldrb r6,[r1],#1              @ int t = *sprite++
    @add r1,r1,#1                @ sprite++
    cmp r6,#0
    beq end_x_movement
    mov r8,#0x1f                @ back_color = 0x1f0000
    strh r8,[r0]                @ *dst = back_color
    
           
end_x_movement:

    add r0,r0,#2                @ *dst++
    add r4,r4,#1
    cmp r4,#16
    blt x_movement

end_y_movement:

    sub r7,r2,#16
    add r0,r0,r7,lsl#1
    add r5,r5,#1
    cmp r5,#16
    blt y_movement
    
Paint_done:
    ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,r12,r14}
    bx lr

/*
void Paint (unsigned short* dst, unsigned char* sprite, int stride_pixels, unsigned int color)
{
  //int ball_r = color & 0x1f;
  //int ball_g = (color >> 5) & 0x1f;
  //int ball_b = (color >> 10) & 0x1f;
  int x, y;
  int side = BALL_SIDE;
  for (y=0; y<side; y++) {
    for (x=0; x<side; x++) {
      int t = *sprite++; // read solid/transparent
      if (t) {
  //    unsigned int back_color = *dst;
        unsigned int back_color = 0x1f;
        // Unpack color
  //      int r = back_color & 0x1f;
  //      int g = (back_color >> 5) & 0x1f;
  //      int b = (back_color >> 10) & 0x1f;
        // Color average
  //      r = ((r << 1) + r + ball_r) >> 2;
  //      g = ((g << 1) + g + ball_g) >> 2;
  //      b = ((b << 1) + b + ball_b) >> 2;
        // Reassemble color
  //      *dst = r | (g << 5) | (b<<10);
  //      *dst = back_color | back_color << 5 | back_color << 10;
      }
    dst++;
    }
    dst += stride_pixels - side;
  } 
}
*/
