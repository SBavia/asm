.model tiny
.code
.186
org 100h  

start: 
    call     COMMAND_LINE
    STRING_TO_NUMBER number,numberSize  
continue:
    mov getNumber, ax 
        
    cmp ax, max_size     
    ja INPUT_ERROR      ;if > max 
    cmp ax, 1     
    jl INPUT_ERROR      ;if < min    
    
newProgram:
    mov ax, cntPrograms ;counter of programs
    cmp ax, getNumber   ;do while counter != number
    jae exit            ;if (counter == number)  exit
     
    mov sp, program_length+100h+200h
    mov ah, 4Ah ;new size of memory
    stack_shift = program_length+100h+200h
    mov bx, stack_shift shr 4+1 ;size in paragraphs + 1
    int 21h  
      
    mov ax, cs  
    mov word ptr EPB+4, ax ;segment cmd
    mov word ptr EPB+8, ax ;segment 1 FCB
    mov word ptr EPB+0Ch, ax ; segment 2 FCB
    
   ;visov programmy
   mov ax, 4B00h ;func 4BH
   mov dx, offset program_path ;way to file
   mov bx, offset EPB ;block EPB
   int 21h ;start program 
   
   inc cntPrograms
   jmp newProgram

exit:   
   int 20h ;exit program, not ret cause stack is 
           ;not in its place   
  
  
;----------------------- procedures -------------------------------     

COMMAND_LINE PROC    
      push cx 
      push si
      push di
      push ax
      
      xor cx, cx 
      mov cl, es:[80h]        ; cmd nah-sa v es:[80h] ( dlina )
      cmp cl, 0   
      je NO_FIND_COMMAND_LINE
      
      mov di, 82h             ; esli para-ri ne 0 togda v di parametri stroki
      mov si, offset number   ; v si number parameter
READ_FN:                      ; get file name from cmd and write it to nameFile
      mov al, es:[di]         
      cmp al, 20h             ; compare with ' '
      je INPUT_ERROR 
      cmp al, 0Dh     
      je PARAM_IS_READ
      
      mov [si], al 
      inc di
      inc numberSize
      cmp numberSize,3
      jg NO_FIND_COMMAND_LINE 
      inc si 
      jmp READ_FN     
    
PARAM_IS_READ:
    mov [si], 24h  ; $ to numberY 
    pop ax
    pop di 
    pop si 
    pop cx 
    
    ret    
COMMAND_LINE endp 
                                      ; if nothing was found
NO_FIND_COMMAND_LINE:                            
      PRINT    [bad_cmd_message]
      jmp      exit   
   
      
PRINT MACRO outLine                   
      mov      ah, 09h  
      lea      dx, outline
      int      21h     
endm        
 
 
STRING_TO_NUMBER macro number, size                ; transform str into number
    push cx                
    push dx
    push bx
    push si
    push di
          
    xor ax,ax
    xor dx,dx
    mov dl,[number]
    mov ax,size
                                   
    lea si,number                      ; save adress of str
    mov di,10                          ; mnogitelb dl9 4isla
    mov cx,ax                          ; length of str
    jcxz INPUT_ERROR                   ; if enter ERROR
    xor ax,ax                          ; null registers
    xor bx,bx     
    xor dx,dx
    mov bl,byte ptr[si]                ; read 1st symbol
    push bx                            ; save 1st symbol
    cmp bl,'-'                         ; compare with '-'
    jne INPUT_LOOP                     ; if not '-' , then go to cycle
    jmp INPUT_ERROR
endm

INPUT_LOOP:                            ; processing every symbol
    mov bl,[si]                        ; reading symbol(bl-number;ax-whole)
    inc si                                     ; to next symbol
    cmp bl,'0'                             ; compare symbol with interval [0,9]
    jl INPUT_ERROR                         ; if less then error
    cmp bl,'9'                             ; 
    jg INPUT_ERROR                         ; if greater then error
    sub bl,'0'                             ;bx=bx-'0'
    mul di                                     ;ax*=10;
    jc INPUT_ERROR                         ;ax+=bx;
    add ax,bx                              ; accumulating result
    jc INPUT_ERROR                         ; if overflow
    loop INPUT_LOOP                       
    jmp INPUT_END                          ; end of processing

INPUT_ERROR:                           ; if error
    xor ax,ax                          ; nulling the result
    PRINT [bad_cmd_message]                   ; error
    jmp exit        

INPUT_END:
    pop bx                             ; loading 1st symbol
    pop di                 
    pop si
    pop bx
    pop dx
    pop cx
    jmp continue

;----------------------- data -------------------------------

number       db  9 dup(0)   ;number
numberSize   dw  0    
getNumber    dw  ?
max_size     equ 255
cntPrograms  dw 0

program_path db "DUCK.EXE", 0    ;file name
EPB          dw 0000                       
             dw offset commandline,0       ;cmd adress
             dw 005Ch,0,006Ch, 0           ;FCB adresses
commandline  db 125                        ;cmd length
             db " /?"                      ;cmd (3)
command_text db 122 dup (?)                ;cmd (122)
program_length equ $-start                 ;program length   

bad_cmd_message db "Error. I need only one argument, 1<=number<=255 ", '$'   
bad_program_path_message db "Program path is incorrect", '$'

end start 
    
    