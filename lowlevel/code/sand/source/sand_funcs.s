

@ void SeedParticles (const Source* sources, Particle* particles, int nparticles, unsigned short* screen);
@ r0 -> sources
@ r1 -> particles
@ r2 -> nparticles
@ r3 -> screen

        @.global SeedParticles

@typedef struct {
@  unsigned char  x, y;     @ 0, 1
@  unsigned char  alive;    @ 2
@  char           PADDING; // Just to be sure sizeof(Particle) is a factor of 4
@} Particle; sizeof() == 4

@typedef struct
@{
@  unsigned short x, y;     @ 0, 2
@} Source; sizeof() == 4

SeedParticles:

    stmdb sp!,{r4,r5,r6,r7,r8,r9,r10,r11,r12,r14}
    
    mov     r8,#8               @ int nsources = NUM_SOURCES
    
seed_loop:
    ldrb    r4,[r1,#2]          @ particles->alive    
    cmp     r4,#0
    bne     particle_alive

    ldrh    r4,[r0,#0]          @ int x = sources->x
    ldrh    r5,[r0,#2]          @ int y = sources->y

    mov     r7,#240             @ SCREEN_W
    mul     r5,r7,r5            @ * y
    add     r6,r6,r4            @ + x
    mov     r6,r6,lsl #1        @ * sizeof(short)
    ldrh    r6,[r3,r6]          @ screen[]
    
    
    streqb  r4,[r1,#0]          @ particles->x   
    streqb  r5,[r1,#1]          @ particles->y
    moveq   r6,#1
    streqb  r6,[r1,#2]          @ particles->alive

    add r0,r0,#4                @ sources++
    sub r8,r8,#1                @ nsources--
    
particle_alive:
    add     r1,r1,#4            @ particles++
    subs    r2,r2,#1            @ nparticles--

    beq seed_done
    cmp r1,#0
    bne seed_loop

seed_done:
    ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,r12,r14}
    bx lr




@ void UpdateParticles (Particle* particles, int nparticles, unsigned short* screen)
@ r0 -> particles
@ r1 -> nparticles
@ r2 -> screen

        .global UpdateParticles

UpdateParticles:
    stmdb sp!,{r4,r5,r6,r7,r8,r9,r10,r11,r12,r14}

    mov r11,#240                 @ SCREEN_W = 240    

update_loop:
    ldrb r10,[r0,#2]
    cmp r10,#0
    beq next_particle
    ldrb r3,[r0,#0]             @ x = particles->x
    ldrb r4,[r0,#1]             @ y = particles->y
    mul r6,r4,r11                @ SCREEN_W * y
    add r6,r6,r3                @ x + (SCREEN_W * y)
    mov r6,r6,lsl#1             @ sizeof(short)
    add r5,r2,r6                @ current = &screen[x + (SCREEN_W * y)]
    add r6,r5,#480              @ down = current + SCREEN_W
    mov r7,#33                  @ new_x = NO_SLOT
 
    
    ldrh r9,[r6]
    cmp r9,#0                   @ if(down[0] == 0)    
    moveq r7,#0                 @ new_x = 0
    beq occupy_slot
    ldrh r9,[r6,#-2]
    cmp r9,#0                  @ if(down[-1] == BLACK)
    moveq r7,#-1               @ new_x = -1
    beq occupy_slot
    ldrh r9,[r6,#2]            @ if(down[1] == BLACK)
    cmp r9,#0
    moveq r7,#1                @ new_x = 1

occupy_slot:
    cmp r7,#33
    beq update_kill
    mov r8,#0                   
    strh r8,[r5]                @ current = BLACK
    mov r8,   #0x3f00           @ WHITE
    orr r8,r8,#0x00ff           @ WHITE
    mov r9,r7,lsl#1             @ sizeof(short)
    strh r8,[r6,r9]             @ down[new_x] = WHITE

    add r3,r3,r7                @ x + new_x
    strb r3,[r0,#0]             @ particles->x = x + new_x
    add r4,r4,#1                @ y + 1
    strb r4,[r0,#1]             @ particles->y = y + 1
    b next_particle

update_kill:
    mov r7,#0
    strb r7,[r0,#2]             @ particle->alive = 0

next_particle:
    add r0,r0,#4
    subs r1,r1,#1    
    bne update_loop             @ while(nparticles != 0)
    
update_done:
    ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,r12,r14}
    bx lr



/*
do {
    if (particles->alive != 0) {
      // Mirar si hay sitio debajo
      int x = particles->x;
      int y = particles->y;
      unsigned short* current = &screen [x + SCREEN_W * y];
      unsigned short* down = current + SCREEN_W;
      int new_x = NO_SLOT;
      
      if (down[0] == BLACK)
        new_x = 0;      // There is room just down the current position
      else if (down[-1] == BLACK)
          new_x = -1;      // There is room left-down 
        else if (down[1] == BLACK)
            new_x = 1;      // There is room right-down 
      
      if (new_x != NO_SLOT) {
        *current = BLACK; // Clean the old position
        down[new_x] = WHITE; // Ocuppy the new position, color white
        particles->x = x + new_x;
        particles->y = y + 1;
      }
      else
        particles->alive = 0;

    }

    particles++;
    nparticles--;

 } while (nparticles != 0);  // Do while there is particles left
*/
