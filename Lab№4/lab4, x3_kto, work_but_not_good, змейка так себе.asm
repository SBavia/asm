.model small
   
.data					;Segment data.   Store koordinat of body snake
msg     db "  You can control snake using arrows keys." 
        db "  All other keys will stop the snake."
	    db "  Press esc to exit."
	    db "  Press any key to start..."
Msg_len = $ - Msg	    
Mes1 db ' Game Over! You are LOSER!! '
Mes2 db 'Your points: '    
Points db 0  
Mes1_len = $ - Mes1  ; length of the first message

random_numeral_1 dw 30h     
const db 0
random_numeral_2 dw 30h 
new_line db 0dh, 0ah, '$' 

count  db 10  dup('$') ; counter
snake	dw count dup(0)
	

.stack 100h

.code

Delay proc      ; orginise delay(wait)
    push cx
	mov ah,0       ;function
	int 1Ah        ; call interrupt ( taimer) 
	mov [random_numeral_2], dx 
	add dx,3       ; after interrupt cx and dx store amount of tick s momenta sbrosa
	mov bx,dx      
repeat:   
	int 1Ah        ; after this int dx will change
	cmp dx,bx      ; compare old ticks with new
	jl repeat ; if less 
	pop cx
	ret
Delay endp 

Key_Press proc
	
	mov ax, 0100h    ;check presure of the key and write in ah -scan-code BIOS symbol,al-askii-code symbol
	int 16h          ; install ZF=1 if have some problems and other
	jz en 			;if we didn't press smth, TODO exit
	
	xor ah, ah     ; for 01h function we ned to do zero in ah
	int 16h         ;if key pressed, read code of the key 
	
	cmp ah, 50h     ; key "down"  or p
	jne up          ; if NE RAVNO(not equally), go
	
	cmp cx,0FF00h		;compare to not go for yourself (na cebya)
	je en               ;RAVNO   (equally)
	
	mov cx,0100h     ;when we will do ax+cx, after this operation we get new koor (down in 1 line)and  we can go DOWN
	jmp en
up:	
    cmp ah,48h   ; if key "up"
	jne left
	
	cmp cx,0100h    ; early we press DOWN
	je touch_tail
	
	mov cx,0FF00h    ;when we will do ax+cx, after this operation ah=0, and we can go UP
	jmp en
left:
    cmp ah,4Bh     ; i
	jne right
	
	cmp cx,0001h
	je touch_tail
	
	mov cx,0FFFFh    ; change koor X(na - 1) and can go LEFT
	jmp en
right: 
    cmp cx,0FFFFh
	je touch_tail
	
	mov cx,0001h  ; change koor X(na 1) and can go RIGHT
	jmp en
touch_tail:
    call Game_over	 
en:
	ret
Key_Press endp

Add_Food proc 
    xor dx,dx 
    call Random  
sc:
    ;check with  border of this number (50h = 80d ), 50h -is border , but food appeared  not on the border    
	cmp bh,4Eh
	jb ok1       ; if all is well then GO 
new_numeral_for_food1:	
	call Random 
	jmp sc        
ok1:
    cmp bh, 2h
    jl new_numeral_for_food1
	mov dl,bh         ;write koord
sc2:
 ;check with  border of this number (19h = 25d )
    cmp bh,17h
    jb ok2
new_numeral_for_food2:    
	call Random
	jmp sc2
ok2: 
    cmp bh, 2h
    jl new_numeral_for_food2
	mov dh,bh         ;write koord (the second)
	 
	xor bx,bx
	
	mov ax,0200h
	int 10h           ; install cursor
	mov ax,0800h
	int 10h
	
	cmp al,2Ah       ;check this place; 2A- "*" aski 
	je sc 
    
    cmp al,0DBh       ;check this place; 0DBh- "block" aski 
	je sc                  
	
	mov ax, 0200h   ; show food
	mov dl, 0003h   
	int 21h   
	
	ret
Add_Food endp  

Random_numerl_for_1 proc
    push cx
    call Delay 
    mov cx, 50h
    cwd
    mov ax, [random_numeral_2]  
    div cx  
    pop cx
    ret
Random_numerl_for_1 endp

Random_numerl_for_2 proc 
    push cx
    call Delay 
    mov cx, 19h 
    cwd
    mov ax, [random_numeral_2] 
    div cx     ; after divide in dx -remainder
    pop cx
    ret
Random_numerl_for_2 endp

Add_Block proc
Beg:
    call Random_numerl_for_1 
    mov bx, dx
	mov dl,bl         ;write koord
   
    call Random_numerl_for_2 
    mov bx, dx
	mov dh,bl         ;write koord (the second)
	
	xor bx,bx 
	
	mov ax,0200h
	int 10h           ; install cursor
	mov ax,0800h      ;read symbols
	int 10h
	
	cmp al,2Ah       ;check this place; 2A- "*" aski 
	je Beg 
   
    cmp al,03h       ;check this place; 0300- "heart" aski 
	je Beg                   
	
	cmp al,0DBh       ;check this place; 0dbh- "block" aski 
	je Beg   
	
	mov ax, 0200h   ; show block
	mov dl, 00DBh   
	int 21h   
    ret
Add_Block endp

Random proc  
    push dx
    push cx
    push ax  
     mov ax, [random_numeral_1]
     mov cx, 2517
     mul cx
     mov cx, 1384
     add ax, cx
     mov cx, 6553
     div cx   ; ax divide cx
     mov [random_numeral_1], dx 
     mov bx, dx
    pop ax
    pop cx
    pop dx
    ret
Random endp

Game_Over proc
     push ax
     mov ah, [count]
     cmp ah, 5
     pop ax
     jle check
      
     cmp dl, 50h
     je  game_over_exit
     cmp dl, 0  
     je  game_over_exit
     cmp dh, 0         
     je  game_over_exit
     cmp dh, 19h       
     je  game_over_exit     
check:
     cmp al,2Ah
     je game_over_exit     
     
     cmp al,0DBh       ; 0dbh- "block" aski
     je game_over_exit    
     jmp good
     
game_over_exit:  
    mov ax,3h           ;install gamepad 80x25
	int	10h 			;clear game field
    
    call Show_Points
    
    mov dx,offset new_line  ; do new line(such as '\n'in c)
    mov ah,9h
    int 21h 
   
    
    mov ax,0B800h     ; segment adress of memory
    mov es,ax
    mov ax,03h
    int 10h
    mov di, 0
    mov si, offset Mes1
    mov cx, Mes1_len
    mov ah,0Ch
begin1:
    lodsb           ; read(copy) byte from string
    stosw            ; white word in word
    loop begin1
    
    int 20h 
good:
     ret
Game_Over endp

Show_Points proc 
     xor bx,bx  
     xor dx,dx 
     xor si,si
     mov cx, 10
    
Show:  
     mov dl, count[bx] 
     cmp dl,'$'
     je EndShow
      
     cmp dl,9 
     jbe Numberal     ; if less or  RAVNO   
     add dl, 7h ;
Numberal: 
     add dl,30h
     
     mov points[si], dl
     inc si 
     inc bx      
     loop Show
    
     cmp cx,0
     je EndShow
EndShow:      
     ret
Show_Points endp 

Start:
	mov ax,@data
	mov ds,ax
    
	mov ax,3h           ;install gamepad 80x25
	int	10h 			;clear game field
    
    lea dx,  msg
    mov ah, 9 
    int 21h
    mov ax,0B800h     ; segment adress of memory
    mov es,ax
    mov ax,03h
    int 10h  
    
    mov di, 0
    mov si, offset Msg
    mov cx, Msg_len
    mov ah,0Ch
begin2:
    lodsb           ; read(copy) byte from string
    stosw            ; write word in string
    loop begin2  
    
    mov ah, 00h     ; wait for any key
    int 16h
    
    mov ax,3h           ;install gamepad 80x25
	int	10h 			;clear game field
	
    xor bx,bx 
    xor dx,dx
    mov count[bx], 5
	mov si,8			;index koodr of the  head, 8 because our koor are words 2*4
	xor di,di			;index koord of   the tail 
	mov cx,1h		    ;use for  control of the head. if we can addition smth, koord X and Y depend on value CX
    
    call Add_Block
    call Add_Food 
   
Main:				
	call Delay
	call Key_Press
    
    xor bh,bh
	mov ax,[snake+si]		;get koord of the head 
	add ax,cx		        ;change koord x (= of the head)
	inc si				
	inc si

nex:		
	mov [snake+si],ax		;set new koord of the head in our memory
	
	mov dx, ax
    mov ax,0200h
	int 10h 			;call interrupt. Move cursor

	mov ax,0800h
	int 10h             ;read symbol  
	call game_over
	mov dh,al  ;  al store read symbld
push cx
push bx
mov     al, '*'
mov     ah, 09h
mov     bl, 0eh ; attribute.
mov     cx, 1   ; single char.
int     10h     ;interrupt show symbol '*'
pop bx
pop cx
	cmp dh,03h          ; compare current symbol with food
	jne didnot_eat 
	
	push cx             ; improve counter (ate food)
	mov ch, [count]
	inc ch
	mov [count],ch
	pop cx 
	
    xor ax,ax
   
	call add_food       ; if ate then TODO new food  
	call Add_Block
	jmp Main
	
didnot_eat:

	mov ax,0200h 	; need to do zero in al, because int 10h move "*" to al	
	mov dx,[snake+di]  ; install cursor on the tail
	int 10h 
	
	mov ax,0200h    ;mov ah,02h 
	mov dl,0020h    ; set askii code of the space
	int 21h			;show space and delete tail
	inc di
	inc di
jmp Main
end	Start     