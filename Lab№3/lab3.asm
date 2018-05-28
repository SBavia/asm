.model	small
.stack	100h
.data            

MaxColumn equ 6
MaxRow equ 5
MinColumnRow equ 0

Temp_Column db ?
Temp_Row db ?          
            
ArrayLength                 db  ?

Error                       db  0Dh,'Error!',0Ah, '$'                                
ErrorInputStr               db  0Dh,'Input error!',0Ah, '$'

InputColumnStr              db  0Dh,'Input array Column (1-6): $'
InputRowStr                 db  0Dh,'Input array Row (1-5): $'

ErrorColumn                 db  0Dh,'Array Column from 1 to 6.', 0Ah, '$'
ErrorRow                    db  0Dh,'Array Row from 1 to 5.', 0Ah, '$'
                                 
InputInterval               db  0Dh,'Interval -127 to 127.', 0Ah, '$'    
AnswerQuotient              db  3 dup('0'),'$'  
AnswerRemainder             db  3 dup(0),'$'  
AnswerArray                 db  3 dup(0),'$' 

ResultStr                   db  0Dh,'Result: $'      
                                
Buffer                      db  ?
                                           
quotient                    db ?
remainder                   db ?
	
                                                                              
                                
MaxNumLen                   db  5  
Len                         db  ?                         
buff                        db  MaxNumLen dup (0)              
                                
minus                       dw  0 

matr                        dw  0 ,0 ,0 ,0 ,0 ,0
                            dw  0 ,0 ,0 ,0 ,0 ,0                            
                            dw  0 ,0 ,0 ,0 ,0 ,0
                            dw  0 ,0 ,0 ,0 ,0 ,0
                            dw  0 ,0 ,0 ,0 ,0 ,0
                   
ResultStrSum                db  'Sum: $'
correct                     db  0Ah,0Dh, '$'
probel                      db '   $'

str_1                       db 0Dh,'Enter ['
CurrRow                       db '0'
str_2                       db '] ['
CurrColumn                       db '0'
str_3                       db '] - $'

.code
 
main    proc
        mov     ax,     @data
        mov     ds,     ax
        
        call inputInfo
        call correctproc
        xor     bx,bx               
        xor     ax,ax
        mov     bl,Temp_Column       ;������ ������ ����� 12 ������ �� 6 ��������*2
        mov     al,2
        mul     bl
        mov     bx,ax
        
        xor     cx,cx     
        mov     cl,     Temp_Row     ;������
        lea     si,     matr         ;�������� �� �������
            
        ForI:
                push    cx           ;��������� ���� ���������� �����
                mov     cl,  Temp_Column    
                mov     di,     si   ;��������� ������ ��� �� ������ ������� � ����. ������
                mov     ax,     0    ;��� ����� ������
        ForJ:
                add ax, [di]         ;������������
                push ax
                mov ax, [di]
                call Show_AColumn
                call probelproc
                pop ax
                jo Trigger           ;���� �������� ���� ������������                      
                add di, 2            ;������������ �� ���� �� � ������               
        loop    ForJ
                
                pop     cx           ;����������� ���� ���������� ������������������ �����
                
                call Result                
                call Show_AColumn    ;����� ����� �� ��� ����� ���� � �����
                call correctproc
                
        Next:
                add     si, bx       ; si ������ ����� � ��� �� 1-�� �������� ������ ������� �� ��������������
                loop    ForI         ;���������� 12 ���� � ����� ��� �� ���� ������ � ������ �������� 
        
        Ending:                               
                                                              
                mov     ax,     4C00h   ;End
                int     21h
        
        Trigger:                        ;End
                mov ah,09h
                lea dx,Error
                int     21h
                mov     ax,     4C00h
                int     21h                            
          
main    endp 

Result proc
        push ax
        push dx
        mov ah,09h         ;����� ���������                      
        lea dx, ResultStrSum           
        int 21h
        pop dx
        pop ax
ret
Result endp
    
correctproc proc
        push ax
        push dx
        mov ah,09h                           
        lea dx, correct           
        int 21h
        pop dx
        pop ax    
ret    
correctproc endp

probelproc proc
        push ax
        push dx
        mov ah,09h        ;����� ���������                      
        lea dx, probel           
        int 21h
        pop dx
        pop ax               
ret
probelproc endp


Show_AColumn proc
    
        push    ax
        push    bx
        push    cx
        push    dx
        push    di
 
        mov     cx, 10
        xor     di, di
 
        or      ax, ax
        jns     Conv
        push    ax
        mov     dx, '-'
        mov     ah, 2
        int     21h
        pop     ax
 
        neg     ax
 
Conv:
        xor     dx, dx
        div     cx
        add     dl, '0'
        inc     di
        push    dx
        or      ax, ax
        jnz     Conv
        
Show:
        pop     dx
        mov     ah, 2
        int     21h
        dec     di
        jnz     Show
 
        pop     di
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
Show_AColumn endp


inputInfo proc                        
    call inputArrayRow
    call inputArrayColumn       
    call inputArray                                         
    ret                           
endp 

inputArrayColumn proc   
    mov cx, 1           
    inputColumn:
       call ShowColumn
       call inputElementBuff          
       
       test ah, ah
       jnz inputColumn 
       
       cmp Buffer, MaxColumn
       jg inputColumn_FAIL   
       
       cmp Buffer, MinColumnRow
       jle inputColumn_FAIL   
       
       jmp inputColumn_OK
       
       inputColumn_FAIL:
       
       call ShowErrorColumn 
       jmp inputColumn
       
       inputColumn_OK:
       
       mov bl, Buffer 
       mov Temp_Column, bl                 
    loop inputColumn     
    ret      
endp

inputArrayRow proc   
    mov cx, 1           
    inputRow:
       call ShowRow
       call inputElementBuff          
       
       test ah, ah
       jnz inputRow
       
       cmp Buffer, MaxRow
       jg inputRow_FAIL   
       
       cmp Buffer, MinColumnRow
       jle inputRow_FAIL   
       
       jmp inputRow_OK
       
       inputRow_FAIL:
       
       call ShowErrorRow 
       jmp inputRow
       
       inputRow_OK:
       
       mov bl, Buffer 
       mov Temp_Row, bl                 
    loop inputRow     
    ret      
endp

inputArray proc
    lea di,matr                     
    
    push ax
    push dx
    
    xor ax,ax
    xor dx,dx
    
    mov al,Temp_Row
    mov dl,Temp_Column
    mul dl                                           
    mov cx,ax  ;���������� �����������
    
    pop dx
    pop ax
     
    
    lea dx, InputInterval
    mov ah, 09h 
    int 21h   
             
    inputArrayLoop: 
       call ShowInput                    
       call inputElementBuff      
       
       test ah, ah
       jnz inputArrayLoop
       
       mov bx,word ptr Buffer
       cmp bl, 0
       jl Minus_bl 
       mov [di], bx
       add di, 2
       call ColumnRowshow
                            
    loop inputArrayLoop           
    ret
    Minus_bl:
    mov bh, -1
    mov [di], bx
    add di, 2
    call ColumnRowshow
     
    loop inputArrayLoop           
    ret      
endp  

ColumnRowshow proc
    push ax
    push dx
    push cx
    push bx
    push di
    push si
    
    xor dx,dx
    xor ax,ax 
    
    mov dl, [CurrColumn]
    sub dl, 30h                  ;������� � ����� ��� ����� <10 � �� -
    mov si, offset Temp_Column   ;��� � ��� �����
    mov al, [si]
    sub al, 1                    ;������ ��������� �� ���� ����� ������� ��� ����� 6 � ��� ������ enter[][]� ��� �� 0 �� 5
    cmp dl, al
    je minus5
    add CurrColumn,01
       
    jmp endSHOW
    
    minus5:
    sub CurrColumn, al ;�� ���� ���� ������
    add CurrRow, 1
    
    endSHOW: 
    pop si
    pop di
    pop bx
    pop cx
    pop dx
    pop ax 
    ret    
ColumnRowshow endp 

resetBuffer proc
    mov Buffer, 0    
    ret
endp    

inputElementBuff proc             
    push cx                       
    inputElMain:                  
        call resetBuffer          
        
        mov ah,0Ah                  
        lea dx, MaxNumLen         
        int 21h                   
                                  
        mov dl,10                 ;������ ������� ���� ������� �� �����
        mov ah,2                  ;������� DOS ������ �������
        int 21h                   ;���������� ��� ���������� �-���
                                  
        cmp Len,0                 
        je errInputEl              ;���� �����(�.�. ������ �� �����)
                                  
        mov minus,0               ;Reset minus
        xor bx,bx                 ;Reset bx
                                  
        mov bl,Len                
        lea si,Len                
                                  
        add si,bx                 
        mov bl,1                  
                                  
                                  
        xor cx,cx                 
        mov cl,Len                
        inputElLoop:              ;��������� ��������� ��������� ����� �� ���������        
            std                   ;��������� ����� ����������� �������� �� �������
            lodsb                 ;������� ���� �� ������ DS:SI � AL
                                  ;������ � al ��������� ������� ������
            call checkSym         ;�������� ����� �� ���
                                  ;ah - flag
            cmp ah,1              ;���� ah �������� 1, �� ������ ������ �� ������ �������� checkSym � � �������� �� ���������� ���� 1
            je errInputEl         ;������������ ������ ��������
                                  ;
            cmp ah,2              ;���� ah ����� ���������� checkSym �������� 2, �� ������ ��� ������ ���� ������, ���������� ���������� �������� 
            je nextSym            ;
                                  ;
            sub al,'0'            ;���� �� ��������� �� ���� ����, �� � al ����� ������ � ��������� '0'..'9', �������� '0' ����� �������� ��� �������� ��������
            mul bl                ;�������� ������� ����� �� ������
                                  ;
            test ah,ah            ;��������� and � ���������� ������ ������, ��������� �� �����������
                                  ;�������� �������� �������� �� ��������� ����, ���� ����� ���� -> ������ �� ��������
            jnz errInputEl        ;���� �� ���� - ������ �����
                                  
            add Buffer,al         ;���������� ������� ����� ����� � ������. ��� 123 = 3 + 2*10 + 1*100
                                  
            jo errInputEl         ;���� ���� �����������
            js errInputEl         ;���� ����� 1
                                  
            mov al,bl             ;� al ��������� bl
            mov bl,10             ;� bl 10
            mul bl                ;�������� al �� 10, ������� �� ��������� ������ �����
                                  
            test ah,ah            ;��������� and � ������� �����
            jz ElNextCheck        ;���� ���� ��� �����
                                   
                                  
            cmp ah,3              ;���� ah !=3 ������ �����
            jne errInputEl        ;�.�. �� 0 �� 2 �� ���������, 10^3 � 16�� = 3xx, �� 10^3 ��� ���������, � �� 10^4+ ���
                                  
                                  
            ElNextCheck:          
                mov bl,al         
                jmp nextSym       
                                  
                                  
            errInputEl:           
                call ErrorInput   ;����� ��������� �� ������ �����
                jmp exitInputEl   ;������� ������ ����� ������
                                  
            nextSym: 
            xor ah, ah            
        loop inputElLoop          
                                  
    cmp minus,0                   
    je exitInputEl   ;���� ����� ����, �� ����������� �����       
    neg Buffer  ;������ ����� �������������                    
                                  
    exitInputEl:                  
    pop cx                        ;��������������� cx
    ret                           
endp

checkSym proc                     
    cmp al,'-'                    ;���� ������� ����� ������, �� ������ �����, ��� �� �������� ������ ������������� �����
    je minusSym                    ; zf=1 �����
                                  
    cmp al,'9'                    
    ja errCheckSym                ;���� ������ ������ 9 - ������ �����
                                  
    cmp al,'0'                    
    jb errCheckSym                ;���� ������ ������ 0 - ������ �����
                                  
    jmp exitCheckGood             ;���� ������ - ����� - ��������� � exitCheckGood, ��� ���������� ����� ������
                                  
    minusSym:                     
        cmp si,offset Len         
        je exitWithMinus          
                                 
    errCheckSym:                  
        mov ah,1                  ;Incorrect symbol
        jmp exitCheckSym          
                                  
    exitWithMinus:                
        mov ah,2                  
        mov minus, 1              ;������������� �����, ��� ����� �������������
        cmp Len, 1               
        je errCheckSym            ;���� ����� ������� ������ �� ������ ���� ���� ������� 2+ ������ - ������ �����!
                                  
        jmp exitCheckSym          
                                  
    exitCheckGood:                
        xor ah,ah                 ;Ah = 0 
                                  
    exitCheckSym:                 
        ret                       
endp                              
                                  
ErrorInput proc                   
    lea dx, ErrorInputStr      
    mov ah, 09h                   
    int 21h                       
    ret                           
endp                              

ShowColumn proc
    push ax
    push dx
      
    mov ah,09h                      
    lea dx, InputColumnStr           
    int 21h  
    
    pop ax
    pop dx 
     
    ret
endp

ShowRow proc
    push ax
    push dx
      
    mov ah,09h                      
    lea dx, InputRowStr           
    int 21h  
    
    pop ax
    pop dx 
     
    ret
endp 
         
                              
ShowInput proc                   
    mov ax,di                    
    add ax,1                 
    mov bl, 10
    div bl          
              
    push di                              
           
    outputMessage:                      
   
    push ax
    push dx
                                  
    mov ah,09h                   
    lea dx, str_1          
    int 21h 
    
    pop dx
    pop ax
    pop di
                        
    ret                           
endp    


ShowErrorColumn proc
    push ax
    push dx
      
    mov ah,09h                      
    lea dx, ErrorColumn           
    int 21h  
    
    pop ax
    pop dx 
     
    ret
endp

ShowErrorRow proc
    push ax
    push dx
      
    mov ah,09h                      
    lea dx, ErrorRow          
    int 21h  
    
    pop ax
    pop dx 
     
    ret
endp
 
end     main