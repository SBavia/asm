.model tiny
.code
    org 80h			;смещение 80h от начала PSP
    cmd_length db ?		;длина командной строки
    cmd_line db ?		;командная строка
    org 100h			;смещение сегмента кода на 100h, СОМ-программа
start:
    cld
    mov bp,sp
    mov cl,cmd_length
    cmp cl,1         ;проверка длины командной строки
    jle exit         ;выход из программы

    mov cx,-1
    mov di,offset cmd_line    ;начало командной строки
find_param:          ;пропускаем первые пробелы
    mov al,' '
    repz scasb
    dec di  
    push di
    inc word ptr argc
    mov si,di       ;устанавливаем в si текущее смещение командной строки
scan_params:
    lodsb           ;загружаем символ из строки
    cmp al,0Dh      ;проверяем на конец строки
    je params_ended
    cmp al,20h      ;проверяем на пробел
    jne scan_params ;если обнаружен пробел – анализируем следующий параметр
    dec si
    mov byte ptr [si],0   ;записываем в конец текущего параметра 0 
    mov di,si
    inc di
    jmp short next_param   ;продолжаем  поиск параметров
params_ended:
    dec si
    mov byte ptr [si],0    ;устанавливаем в конец строки 0


;получаем второй параметр - кол-во раз, кот-е нужно запустить
next_param:           ;пропускаем первые пробелы
    mov al,' '
    repe scasb
    dec di
    inc word ptr argc
    mov si, di        ;устанавливаем в si текущее смещение командной строки
    mov di, offset number
scan_param:
    cmp [si],0Dh      ;проверяем на конец строки
    je param_ended
    cmp [si],20h      ;проверяем на пробел
    je param_ended
    movsb
    jmp scan_param
param_ended:
    mov byte ptr [si],0     ;устанавливаем в конец строки 0

    mov si, offset number

string_to_num:
    xor dx,dx   
loop_:    
    xor ax,ax
    lodsb       
    test al,al 
    jz  ex
    cmp al,'9'  
    jnbe  loop_
    cmp al,'0'       
    jb    loop_
    sub ax,'0' 
    
    push ax
    mov ax, dx
    mov dx, 10
    mul dx
    mov dx, ax
    pop ax 
    add dx, ax  
    jmp  loop_
ex:     
    mov ax,dx   
    mov num, ax
    
    
    ;перемещение стека на 200h после окончания сегмента программы
    mov sp, program_length+100H+200H

    ;освободить всю память программы после ее окончания
    mov ah, 4Ah
    stack_offset = program_length+ 100h + 200h
    mov bx, stack_offset shr 4 + 1     ; размер в параграфах + 1
    int 21h

    ; заполняем поля структуры EPB    
    mov ax,cs
    mov word ptr EPB+4,ax   ; сегмент командной строки
    mov word ptr EPB+8,ax     ; сегмент первого FCB
    mov word ptr EPB+0Ch,ax    ; сегмент второго FCB

    mov cx, num    ;количество запусков программы
cycle:
    mov ax,4B00h		;функция DOS 4Bh
    mov dx, offset cmd_line+1	;начало командной строки, путь к файлу
    
    mov bx, offset EPB		;блок EPB
    int 21h             ; запустить программу
    jnc next			;в случае ошибки – вывод сообщения
    mov ah,9
    lea dx, error
    int 21h
next:
    loop cycle

exit:
    int 20h	;выход из программы 20 прерывание, т.к. стек перемещен, ret нельзя - стек перемещен

error db "error",10,13,'$'     ;сообщение об ошибке
EPB dw 0000                    ;текущее окружение
dw offset commandline,0        ;адрес командной строки
dw 005Ch,0,006Ch,0             ;адреса FCB программы
commandline db 125             ;длина командной строки
db " /?"                       ; командная строка (3)
command_text db 122 dup(?)     ; командная строки (122)
programm db 80 dup(0)  
number db 80 dup(0)
num dw 0
argc dw 0
program_length equ $-start     ; длина программы
end start