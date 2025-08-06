section .data
    menu_msg db 10, '===== Shape Generation System =====',10
             db 'A. Rectangle',10
             db 'B. Diamond',10
             db 'C. Triangle',10
             db 'D. Circle',10
             db 'E. Heart',10
             db 'F. Hexagon',10
             db 'G. Ladder',10
             db 'H. Rocket',10
             db 'I. Sinusoid Wave',10
             db 'J. Line',10
             db 'K. Exit',10
             db 'Enter your choice (A-K): ',0
    menu_len equ $-menu_msg
    
    invalid_choice db 'Invalid choice. Please try again.',10,0
    invalid_len equ $-invalid_choice
    
    star db '*'
    space db ' '
    newline db 10
    underscore db '_'
    
    radius equ 5

section .bss
    choice resb 2

section .text
    global _start

_start:
menu_loop:
    ; print menu
    mov eax, 4          
    mov ebx, 1          
    mov ecx, menu_msg   
    mov edx, menu_len   
    int 0x80
    
    ; get choice
    mov eax, 3          
    mov ebx, 0          
    mov ecx, choice     
    mov edx, 2          
    int 0x80
    
    ; process choice
    mov al, [choice]
    
    cmp al, 'A'
    je print_rectangle
    cmp al, 'a'
    je print_rectangle
    
    cmp al, 'B'
    je print_diamond
    cmp al, 'b'
    je print_diamond
    
    cmp al, 'C'
    je print_triangle
    cmp al, 'c'
    je print_triangle
    
    cmp al, 'D'
    je print_circle
    cmp al, 'd'
    je print_circle
    
    cmp al, 'E'
    je print_heart
    cmp al, 'e'
    je print_heart
    
    cmp al, 'F'
    je print_hexagon
    cmp al, 'f'
    je print_hexagon
    
    cmp al, 'G'
    je print_ladder
    cmp al, 'g'
    je print_ladder
    
    cmp al, 'H'
    je print_rocket
    cmp al, 'h'
    je print_rocket
    
    cmp al, 'I'
    je print_sinwave
    cmp al, 'i'
    je print_sinwave
    
    cmp al, 'J'
    je print_line
    cmp al, 'j'
    je print_line
    
    cmp al, 'K'
    je exit_program
    cmp al, 'k'
    je exit_program
    
    ; invalid choice
    mov eax, 4
    mov ebx, 1
    mov ecx, invalid_choice
    mov edx, invalid_len
    int 0x80
    jmp menu_loop

; rectangle
print_rectangle:
    mov esi, 5          ; height
.rect_loop:
    mov ecx, 10         ; width
    call print_stars
    call print_newline
    dec esi
    jnz .rect_loop
    jmp menu_loop

; diamond
print_diamond:
    mov esi, 0
.diamond_top:
    cmp esi, 3
    je .diamond_bottom
    mov ecx, 2
    sub ecx, esi
    call print_spaces
    mov ecx, esi
    shl ecx, 1
    add ecx, 1
    call print_stars
    call print_newline
    inc esi
    jmp .diamond_top
    
.diamond_bottom:
    mov esi, 1
.diamond_bottom_loop:
    cmp esi, 3
    je menu_loop
    mov ecx, esi
    call print_spaces
    mov ecx, esi
    shl ecx, 1
    mov eax, 5
    sub eax, ecx
    mov ecx, eax
    call print_stars
    call print_newline
    inc esi
    jmp .diamond_bottom_loop

; triangle
print_triangle:
    mov esi, 1 
.triangle_loop:
    mov ecx, 5
    sub ecx, esi
    call print_spaces
    
    mov ecx, esi
    shl ecx, 1
    dec ecx
    call print_stars
    
    call print_newline
    inc esi
    cmp esi, 6
    jne .triangle_loop
    jmp menu_loop

; hexagon
print_hexagon:
    ; top (3 stars)
    mov ecx, 4
    call print_spaces
    mov ecx, 3
    call print_stars
    call print_newline
    
    ; upper middle (7 stars)
    mov ecx, 2
    call print_spaces
    mov ecx, 7
    call print_stars
    call print_newline
    
    ; middle (11 stars)
    mov ecx, 0
    call print_spaces
    mov ecx, 11
    call print_stars
    call print_newline
    
    ; lower middle (7 stars)
    mov ecx, 2
    call print_spaces
    mov ecx, 7
    call print_stars
    call print_newline
    
    ; bottom (3 stars)
    mov ecx, 4
    call print_spaces
    mov ecx, 3
    call print_stars
    call print_newline
    
    jmp menu_loop

; line
print_line:
    mov ecx, 10
    call print_stars
    call print_newline
    jmp menu_loop

;ladder
print_ladder:
    mov esi, 10
    
.ladder_loop:
    test esi, 1         
    jnz .print_rung
    
    ; print side with spaces (even lines)
    call print_star     
    mov ecx, 3          
    call print_spaces
    call print_star
    call print_newline
    jmp .next_line
    
.print_rung:
    call print_star
    mov ecx, 3          
.rung_loop:
    push ecx
    mov eax, 4
    mov ebx, 1
    mov ecx, underscore
    mov edx, 1
    int 0x80
    pop ecx
    loop .rung_loop
    call print_star     
    call print_newline
    
.next_line:
    dec esi
    jnz .ladder_loop
    
    jmp menu_loop

; sin wave
print_sinwave:
    mov esi, 0          
.sinwave_loop:
    cmp esi, 10
    je menu_loop
    
    mov eax, esi
    and eax, 3          
    dec eax
    mov ecx, 5          
    add ecx, eax        
    
    call print_spaces
    call print_star
    call print_newline
    
    inc esi
    jmp .sinwave_loop

; rocket
print_rocket:
    ; top (1 star)
    mov ecx, 3
    call print_spaces
    call print_star
    call print_newline
    
    ; upper body (3 stars)
    mov ecx, 2
    call print_spaces
    mov ecx, 3
    call print_stars
    call print_newline
    
    ; middle body (5 stars)
    mov ecx, 1
    call print_spaces
    mov ecx, 5
    call print_stars
    call print_newline
    
    ; lower body (7 stars)
    mov ecx, 0
    call print_spaces
    mov ecx, 7
    call print_stars
    call print_newline
    
    ; fins (3 stars)
    mov ecx, 2
    call print_spaces
    mov ecx, 3
    call print_stars
    call print_newline
    
    ; fins again (3 stars)
    mov ecx, 2
    call print_spaces
    mov ecx, 3
    call print_stars
    call print_newline
    
    ; windows (3 stars with spaces)
    mov ecx, 1
    call print_spaces
    call print_star
    mov ecx, 1
    call print_spaces
    call print_star
    mov ecx, 1
    call print_spaces
    call print_star
    call print_newline
    
    ; lower windows (3 stars with wider spaces)
    mov ecx, 0
    call print_spaces
    call print_star
    mov ecx, 2
    call print_spaces
    call print_star
    mov ecx, 2
    call print_spaces
    call print_star
    call print_newline
    
    ; base (7 stars)
    mov ecx, 0
    call print_spaces
    mov ecx, 7
    call print_stars
    call print_newline
    
    ; exhaust (3 stars)
    mov ecx, 2
    call print_spaces
    mov ecx, 3
    call print_stars
    call print_newline
    
    jmp menu_loop

; circle
print_circle:
    mov esi, -radius
.circle_y:
    mov edi, -2 * radius
.circle_x:
    mov eax, edi
    sar eax, 1
    imul eax, eax
    mov ebx, esi
    imul ebx, ebx
    add eax, ebx
    cmp eax, radius * radius
    jg .circle_space
    call print_star
    jmp .circle_next_x
.circle_space:
    call print_space
.circle_next_x:
    inc edi
    cmp edi, 2 * radius
    jle .circle_x
    call print_newline
    inc esi
    cmp esi, radius
    jle .circle_y
    jmp menu_loop

; heart
print_heart:
    mov esi, -6
.heart_y:
    mov edi, -12
.heart_x:
    mov eax, edi
    imul eax
    mov ebx, eax
    mov eax, esi
    imul eax
    lea ecx, [eax + ebx]
    sub ecx, 25
    mov eax, ecx
    imul eax, ecx
    imul eax, ecx
    mov edx, edi
    imul edx, edx
    mov ecx, esi
    imul ecx, ecx
    imul ecx, esi
    imul edx, ecx
    cmp eax, edx
    jle .heart_star
    call print_space
    jmp .heart_next_x
.heart_star:
    call print_star
.heart_next_x:
    inc edi
    cmp edi, 12
    jle .heart_x
    call print_newline
    inc esi
    cmp esi, 6
    jle .heart_y
    jmp menu_loop

print_ladder_side:
    push ecx
    call print_star
    mov ecx, 5
    call print_spaces
    call print_star
    call print_newline
    pop ecx
    ret

print_ladder_rung:
    push ecx
    call print_star
    mov ecx, 5
.rung_loop:
    push ecx
    mov eax, 4
    mov ebx, 1
    mov ecx, underscore
    mov edx, 1
    int 0x80
    pop ecx
    loop .rung_loop
    call print_star
    call print_newline
    pop ecx
    ret

print_stars:
    pushad
.stars_loop:
    jecxz .stars_done
    call print_star
    loop .stars_loop
.stars_done:
    popad
    ret

print_spaces:
    pushad
.spaces_loop:
    jecxz .spaces_done
    call print_space
    loop .spaces_loop
.spaces_done:
    popad
    ret

print_star:
    pushad
    mov eax, 4
    mov ebx, 1
    mov ecx, star
    mov edx, 1
    int 0x80
    popad
    ret

print_space:
    pushad
    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80
    popad
    ret

print_newline:
    pushad
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    popad
    ret

exit_program:
    mov eax, 1
    mov ebx, 0 
    int 0x80