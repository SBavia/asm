.Model Small 
stack segment
    dw   128  dup(0)
ends

Macro SetPos X,Y
Mov Ah,02h             ;
Mov Dh,X               ;Set position of the  cursor
Mov Dl,Y
int 10h
endm

Macro PaintPalett
Mov Ah,09h
push bx
Mov Bl,01h
Lea Dx,Palet
int 21h
pop bx
endm

Macro Clear
Mov Ah,02h
Mov Dl,00h
int 21h
endm

Macro Marco Horizontal
SetPos 1,1
Mov Ah,09h
Lea Dx,Horizontal
int 21h

SetPos 11,1
Mov Ah,09h
Lea Dx,Horizontal
int 21h
endm

Macro Marco2 Vertical
Mov Cx,11
For: SetPos Cl,00h
Mov Ah,09h
Lea Dx,Vertical
int 21h

SetPos Cl,28h
Mov Ah,09h
Lea Dx,Vertical
int 21h
Loop For
endm


Macro SetBall
SetPos yBall,xBall
endm

Macro Ball
Mov Ah,02h
;Mov dh,011h
Mov Dl,002h
int 21h
;mov ah, 09
;mov bh, 00
;mov bl, 011h
;mov al, 002h
;int 10h
endm

Macro Block
Mov Ah,02h
Mov Dl,023h
int 21h
endm    

Macro Set_blocks 
mov bh, 00
SetPos 2,2
Mov Ah,09h
;mov ah, 13h 
;mov bl,100b
Lea Dx,Blocks1
;int 10h
int 21h

SetPos 3,2
Mov Ah,09h
Lea Dx,Blocks2
int 21h
endm


Macro Total_goals
SetPos 14,4
Mov Ah,09h
Lea Dx,Score
int 21h    
SetPos 15,4
Mov Ah,02h
Mov Dl,goals
Add Dl,30h
int 21h

SetPos 15,10
Mov Ah,02h
Mov Dl,looses
Add Dl,30h
int 21h
endm


data segment
Palet db "=====$" 
Msg db "++++++++++++++++++++++++++++++++++++++++$" 
Blocks1 db "        ####          ####            $"
Blocks2 db " ######     ##########     ###########$" 
Score db "Loose Score$"
Msj2 db "|$"
xPalet1 db 06h
xPaletend1 db 0Ah
yBall db 09h
xBall db 08h 
xBlock db 08h
yBlock db 09h
cur_location dw 0
LimUp db 01h
LimDown db 10
flag1 db 00h
flag2 db 02h
goals db 00h
looses db 00h
Msg1 db "Congratulations you beat the computer$"
Msg2 db "Computer is win$"
wait_time dw 0 
symbol dw 0
cur_dir db 00h
ends

code segment
main:  
mov ax, @data	; set data segment;
mov	ds, ax
mov bh, 00 
mov ah, 0		; function 0 (set video mode)

mov al, 03h	
int 10h 
;mov ah, 1
;int 21h
  
;call Create_bloc
;mov ah,09h
;lea dx, 
Set_blocks
Total_goals
call  Init_all 

mov ah,10h
int 16h 

Ciclo:

CMP cur_dir,061h
je GoLeft  

CMP cur_dir,064h
je GoRight  

next:   
push ax
mov ah, xBall
mov xBlock, ah
mov ah, yBall
mov yBlock, ah
pop ax

call Ball_move 

keys:
Mov Cx,10
Mov Ah,01h ;-------> record a keystroke
int 16h               
jz no_keys 


CMP Al,073h
Je Escp   

mov     cur_dir, al

Mov Ah,00h  ;pulls the value of the key pressed
int 16h
    
Mov Al,00h 

no_keys:
mov     ah, 00h
int     1ah
cmp     dx, wait_time
jb      keys
add     dx, 4
mov     wait_time, dx 

jmp Ciclo


noBuffer:  
    Mov cur_dir,00h  
    jmp next

GoRight:
    CMP xPaletend1,28h
    Je noBuffer
    SetPos 10,xPalet1
    Clear
    Add xPalet1,01h 
    Add xPaletend1,01h
    SetPos 10,xPalet1
    PaintPalett
    
    JMP noBuffer

GoLeft:
    CMP xPalet1,01h
    Je noBuffer
    SetPos 10,xPaletend1
    Clear
    Sub xPalet1,01h
    Sub xPaletend1,01h
    SetPos 10,xPalet1
    PaintPalett
    
    JMP noBuffer

Win1:                        ;winner's message
    Mov Ah,09h
    Lea DX,Msg2
    int 21h
JMP Escp

Win2:  
    Mov Ah,09h
    Lea DX,Msg1
    int 21h
JMP Escp
Escp:
Mov Ah,00h                  
int 16h
;wait for any key....    
    
    mov ax, 4c00h ; exit to operating system.
    int 21h  
ret

Ball_move proc near 
    
VerCB:   

JMP compares
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UpRight:
   
  ; push 0B800h 
;   pop es
;   mov dl,0 
;   mov bl,0
;   mov dh,xBall+1
;   mov bh,yBall-1
;   mov cur_location,yBall-1
;   cwd
;   mul dx,cur_location
;   mov si,[dx] 
;   ;mov dh,yBall
;   ;mul si, [dx]
;    ;mov di, word ptr symbol
;   cld
;   lodsw
    Dec yBlock
    Inc xBlock
   ; mov ah,                                
   SetPos yBlock,xBlock
    mov ah,08
    mov bh,00  
    int 10h
    CMP AL,23h
   je  Beat 
   
   ;SetPos yBall,xBall+1
   ; mov ah,08h
   ; int 10h
   ; CMP AL,23H
   ;je  Beat 
    ;call Beat
    
    Mov Al,xBall
    Add Al,01h
    CMP Al,27h
  Je Es2
;  Je ComingUpRight
    
    Mov Al,yBall
    Sub Al,01h
    Mov Bl,LimUp
    CMP Al,Bl
  Je ComingUpRight
    SetPos yBall,xBall
    Clear
    Dec yBall
    Inc xBall
    SetPos yBall,xBall
    Ball
    Mov flag2,01h
  JMP ver_score
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UpLeft:  
  
   Dec yBlock
   Dec xBlock
   ; mov ah,                                
   SetPos yBlock,xBlock
    mov ah,08
    mov bh,00  
    int 10h
    CMP AL,23h
   je  Beat 
    
    Mov Al,xBall
    Sub Al,01h
    CMP Al,01h 
   Je Es0
;   Je ComingUpLeft
    
    Mov Al,yBall
    Sub Al,01h
    Mov Bl,LimUp
    CMP Al,Bl
  Je ComingUpLeft
    
    SetPos yBall,xBall
    Clear
    Dec yBall
    Dec xBall
    SetPos yBall,xBall
    Ball
    Mov flag2,00h
  JMP ver_score
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DownLeft:
  
    Inc yBlock
    Dec xBlock
   ; mov ah,                                
   SetPos yBlock,xBlock
    mov ah,08
    mov bh,00  
    int 10h
    CMP AL,23h
   je  Beat  
     
    Mov Al,xBall
    Sub Al,01h
    CMP Al,01h
   Je Es1
;   Je ComingDownLeft 
     
    Mov Al,yBall
    Add Al,01h
    Mov Bl,LimDown
    CMP Al,Bl 
    je Bounce
  ;Je ComingDownLeft
    
    SetPos yBall,xBall
    Clear
    Inc yBall
    Dec xBall
    SetPos yBall,xBall
    Ball
    Mov flag2,01h
  JMP ver_score
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DownRight: 
    
    Inc yBlock
    Inc xBlock
   ; mov ah,                                
   SetPos yBlock,xBlock
    mov ah,08
    mov bh,00  
    int 10h
    CMP AL,23h
   je  Beat 
    
    Mov Al,xBall
    Add Al,01h
    CMP Al,27h 
   Je Es3
;  Je ComingDownRight
    
    Mov Al,yBall
    Add Al,01h
    Mov Bl,LimDown
    CMP Al,Bl 
    Je Bounce
  ;Je ComingDownRight
    
    SetPos yBall,xBall
    Clear
    Inc yBall
    Inc xBall
    SetPos yBall,xBall
    Ball
    Mov flag2,00h
  JMP ver_score 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
TouchedPalet:
ComingUpRight:
CMP flag1,0      ;tell where the ball is coming from
Je Sumflag

ComingDownRight:
CMP flag1,01h
Je Restartflag

ComingUpLeft:
CMP flag1,02h
Je Sumflag

ComingDownLeft:
CMP flag1,03h
Je Restartflag

Sumflag:
Add flag1,01h
ret
;JMP Ciclo

Restartflag:
Sub flag1,01h 
ret
;JMP Ciclo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Bounce:
Mov Al,xBall
Mov Bl,xPalet1
CMP Al,Bl
Jb Gol
Mov Bl,xPaletend1
CMP Al,Bl
Ja Gol 
jmp TouchedPalet         ;to know if the ball bounced or passed the limit
;Jne Gol
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Es0: Mov flag1,00h
JMP compares

Es1: Mov flag1,01h
JMP compares

Es2: Mov flag1,02h
JMP compares

Es3: Mov flag1,03h
JMP compares

compares:
CMP flag1,00h
Je UpRight

CMP flag1,01h
Je DownRight

CMP flag1,02h
Je UpLeft

CMP flag1,03h             ;ball dirrecion
Je DownLeft
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

Beat:
Clear 
SetPos 15,4
    Add looses,01h
    Mov Ah,02h
    Mov Dl,looses
    Add Dl,30h
    int 21h
Total_goals
jmp TouchedPalet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Gol:
    SetPos 15,10
    Add goals,01h
    Mov Ah,02h
    Mov Dl,goals
    Add Dl,30h
    int 21h
    SetPos yBall,xBall
    Clear
    Mov yBall,9 
    push bx
    Mov bh,xPalet1
    Mov xBall,bh
    pop bx 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
JMP Winner
ver_score:                      
    ret

Winner:
    Mov Al,goals
    CMP Al,5
    Je Win1
    
    Mov Al,looses
    CMP Al,5
    Je Win2
call  Init_all
ret 

Ball_move endp  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Init_all proc near        ;--------> Print each frame and pallets  
Marco Msg
Marco2 Msj2
SetPos 10,xPalet1
PaintPalett
    SetBall
    Ball   
    
;push dx
;mov dx, 20000
;mov ah, 86h
;int 15h
;pop dx 
mov Al,0 
ret 
Init_all endp 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Create_block proc near
;    push cx
;    mov cx,27h
;cycle:
;SetPos 02h,cl
;Block  
;loop cycle
;pop cx   
;ret
;Create_block endp
ends 
end main    

;.Exit

