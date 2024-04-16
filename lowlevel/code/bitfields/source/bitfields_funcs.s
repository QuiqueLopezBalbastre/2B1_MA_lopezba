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
    mov r7,#0x1f
    and r9,r7,r3                @ ball_r = color
    and r10,r7,r3,lsr #5        @ ball_g = color >> 5
    and r11,r7,r3,lsr #10       @ ball_b = color >> 10

y_movement:
    
    mov r4,#0                   @ x = 0

x_movement:
    
    ldrb r6,[r1],#1             @ int t = *sprite++
    cmp r6,#0
    beq end_x_movement
    ldrh r8,[r0]                @ back_color = *dst
    
unpack_color:
    and r3,r7,r8                @ r = back_color
    and r6,r7,r8,lsr #5         @ g = back_color >> 5
    and r12,r7,r8,lsr #10       @ b = back_color >> 10    

color_average:

    add r3,r3,r3,lsl#1          @ r = (r << 1) + r
    add r3,r3,r9                @ r = r + ball_r
    mov r3,r3,lsr #2            @ r = r >> 2
    add r6,r6,r6,lsl#1          @ g = (g << 1) + g
    add r6,r6,r10               @ g = g + ball_g
    mov r6,r6,lsr #2            @ g = g >> 2
    add r12,r12,r12,lsl#1       @ b = (b << 1) + b
    add r12,r12,r11             @ b = b + ball_b
    mov r12,r12,lsr #2          @ b = b >> 2

reassemble_color:    
    orr r3,r6,lsl #5            @ (r | g << 5)
    orr r3,r12,lsl #10          @ (r | g << 5 | b << 10)
    strh r3,[r0]                @ *dst = r

           
end_x_movement:

    
    add r0,r0,#2                @ *dst++
    add r4,r4,#1                @ x++
    cmp r4,#16                  @ if x == SIZE
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
  int ball_r = color & 0x1f;
  int ball_g = (color >> 5) & 0x1f;
  int ball_b = (color >> 10) & 0x1f;
  int x, y;
  int side = BALL_SIDE;
  for (y=0; y<side; y++) {
    for (x=0; x<side; x++) {
      int t = *sprite++; // read solid/transparent
      if (t) {
        unsigned int back_color = *dst;
  //    unsigned int back_color = 0x1f;
    // Unpack color
        int r = back_color & 0x1f;
        int g = (back_color >> 5) & 0x1f;
        int b = (back_color >> 10) & 0x1f;
        // Color average
        r = ((r << 1) + r + ball_r) >> 2;
        g = ((g << 1) + g + ball_g) >> 2;
        b = ((b << 1) + b + ball_b) >> 2;
        // Reassemble color
        *dst = r | (g << 5) | (b<<10);
  //      *dst = back_color | back_color << 5 | back_color << 10;
      }
    dst++;
    }
    dst += stride_pixels - side;
  } 
}
*/
