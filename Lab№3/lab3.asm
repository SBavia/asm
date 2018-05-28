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
        mov     bl,Temp_Column       ;размер строки равен 12 байтам тк 6 столбцов*2
        mov     al,2
        mul     bl
        mov     bx,ax
        
        xor     cx,cx     
        mov     cl,     Temp_Row     ;строки
        lea     si,     matr         ;смещение на матрицу
            
        ForI:
                push    cx           ;сохраняем наше количество строк
                mov     cl,  Temp_Column    
                mov     di,     si   ;смещаемся каждый раз на первый элемент в след. строке
                mov     ax,     0    ;для суммы строки
        ForJ:
                add ax, [di]         ;суммирование
                push ax
                mov ax, [di]
                call Show_AColumn
                call probelproc
                pop ax
                jo Trigger           ;если сработал флаг переполнения                      
                add di, 2            ;перемещаемся на след эл в строке               
        loop    ForJ
                
                pop     cx           ;вытаскиваем наше количество непросуммированных строк
                
                call Result                
                call Show_AColumn    ;вывод суммы тк она может быть и отриц
                call correctproc
                
        Next:
                add     si, bx       ; si сейчас стоит у нас на 1-ом элементе строки которую мы просуммировали
                loop    ForI         ;прибавляем 12 байт и стоим уже на след строке в первом элементе 
        
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
        mov ah,09h         ;вывод сообщения                      
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
        mov ah,09h        ;вывод сообщения                      
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
    mov cx,ax  ;вычисление размерности
    
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
    sub dl, 30h                  ;перевод в число для чисел <10 и не -
    mov si, offset Temp_Column   ;это и так число
    mov al, [si]
    sub al, 1                    ;просто коррекция тк макс строк столбоц при вводе 6 а при выводе enter[][]у нас от 0 до 5
    cmp dl, al
    je minus5
    add CurrColumn,01
       
    jmp endSHOW
    
    minus5:
    sub CurrColumn, al ;по аски коду просто
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
                                  
        mov dl,10                 ;Символ который надо вывести на экран
        mov ah,2                  ;Функция DOS вывода символа
        int 21h                   ;Прерывание для выполнения ф-ции
                                  
        cmp Len,0                 
        je errInputEl              ;если равно(т.е. ничего не ввели)
                                  
        mov minus,0               ;Reset minus
        xor bx,bx                 ;Reset bx
                                  
        mov bl,Len                
        lea si,Len                
                                  
        add si,bx                 
        mov bl,1                  
                                  
                                  
        xor cx,cx                 
        mov cl,Len                
        inputElLoop:              ;процедура обработки выходного флага из чексистем        
            std                   ;Установка флага направления движения по массиву
            lodsb                 ;Считать байт по адресу DS:SI в AL
                                  ;Теперь в al находится текущий символ
            call checkSym         ;Проверка число ли это
                                  ;ah - flag
            cmp ah,1              ;Если ah содержит 1, то значит символ не прошел контроль checkSym и в процессе ее выполнения стал 1
            je errInputEl         ;Обрабатываем данную ситуацию
                                  ;
            cmp ah,2              ;Если ah после выполнения checkSym содержит 2, то значит был введен знак минуса, необходима дальшейная проверка 
            je nextSym            ;
                                  ;
            sub al,'0'            ;Если мы находимся на этом шагу, то в al лежит символ в диапазоне '0'..'9', отнимаем '0' чтобы получить его числовое значение
            mul bl                ;Умножоем текущую цифру на разряд
                                  ;
            test ah,ah            ;Побитовое and с изменением ТОЛЬКО флагов, результат не сохраняется
                                  ;Проверка значения регистра на равенство нулю, Если равно нулю -> Ошибок не выявлено
            jnz errInputEl        ;Если не ноль - ошибка ввода
                                  
            add Buffer,al         ;Записываем текущую часть числа в массив. Тип 123 = 3 + 2*10 + 1*100
                                  
            jo errInputEl         ;Если есть перепонение
            js errInputEl         ;Знак равен 1
                                  
            mov al,bl             ;В al загружаем bl
            mov bl,10             ;В bl 10
            mul bl                ;Умножаем al на 10, переход на следующий разряд числа
                                  
            test ah,ah            ;Побитовое and с флагами опять
            jz ElNextCheck        ;Если нуль или равно
                                   
                                  
            cmp ah,3              ;Если ah !=3 ошибка ввода
            jne errInputEl        ;Т.к. от 0 до 2 мы проверили, 10^3 в 16сс = 3xx, то 10^3 еще допустима, а из 10^4+ нет
                                  
                                  
            ElNextCheck:          
                mov bl,al         
                jmp nextSym       
                                  
                                  
            errInputEl:           
                call ErrorInput   ;Вывод сообщения об ошибке ввода
                jmp exitInputEl   ;Попытка ввести число заново
                                  
            nextSym: 
            xor ah, ah            
        loop inputElLoop          
                                  
    cmp minus,0                   
    je exitInputEl   ;если минус есть, то инвертируем число       
    neg Buffer  ;делаем число отрицательным                    
                                  
    exitInputEl:                  
    pop cx                        ;Восстанавливаем cx
    ret                           
endp

checkSym proc                     
    cmp al,'-'                    ;Если элемент равен минусу, то делаем вывод, что мы пытаемся ввести отрицательное число
    je minusSym                    ; zf=1 равен
                                  
    cmp al,'9'                    
    ja errCheckSym                ;Если символ больше 9 - ошибка ввода
                                  
    cmp al,'0'                    
    jb errCheckSym                ;Если символ меньше 0 - ошибка ввода
                                  
    jmp exitCheckGood             ;Если символ - цифра - переходим в exitCheckGood, где сбрасываем метку ошибки
                                  
    minusSym:                     
        cmp si,offset Len         
        je exitWithMinus          
                                 
    errCheckSym:                  
        mov ah,1                  ;Incorrect symbol
        jmp exitCheckSym          
                                  
    exitWithMinus:                
        mov ah,2                  
        mov minus, 1              ;Устанавливаем метку, что число отрицательное
        cmp Len, 1               
        je errCheckSym            ;Если число состоит только из минуса либо были введены 2+ минуса - ошибка ввода!
                                  
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