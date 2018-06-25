.Model Small                   ; модель памяти для ЕХЕ

stack segment
    dw   256  dup(0)           ; сегмент стека размером в 256 байт
ends
    
    
    Macro SetPos X,Y           ; Макрос для установки курсора с параметрами x, y
        Mov Ah,02h             ; Функция 02 – установить положение курсора
        Mov Dh,X               ; номер строки (считая от 0, установка на строку 25 делает курсор невидимым)
        Mov Dl,Y               ; номер столбца (считая от 0)
        int 10h                ; Прерывание BIOS 10h
    endm
    
    Macro PaintPlayer          ; Макрос для отрисовки главного героя
        Mov Ah,09h             ; функция 09 - выдать строку на дисплей
        ;push bx
        ;Mov Bl,01h
        Lea Dx,Player          ; адрес строки, заканчивающейся символом '$' (ASCII 24H)
        int 21h                ; Прерывание BIOS 21h
        ;pop bx
    endm
    
    Macro PaintBall            ; Макрос для отрисовки мячика, который будем двигать
        Mov Ah,02h             ; функция 02 - вывод символа на дисплей
        ;Mov dh,011h
        Mov Dl,04h            ; символ, выводимый на стандартный вывод
        int 21h                ; Прерывание BIOS 21h
    endm
    
    Macro Clear                ; Макрос для очистки строки(символа в строке)
        Mov Ah,02h             ; функция 02 - вывод символа на дисплей
        Mov Dl,00h             ; символ, выводимый на стандартный вывод(0)
        int 21h                ; Прерывание BIOS 21h
    endm

    Macro SetLine line        ; Макрос для вывода строки на экран
        SetPos Cl,00h         ; в позицию y посылаем содержимое регистра cx(cl)
        Mov Ah,09h            ; функция 09 - выдать строку на дисплей
        Lea Dx,line           ; адрес строки, заканчивающейся символом '$' (ASCII 24H)
        int 21h               ; Прерывание BIOS 21h
    endm
    
    Macro SetMap              ; Макрос для прорисовки карты
        xor cx, cx            ; обнуление cx
        SetLine Map0          ; вывод карты построчно
        inc cx                ; +1 к cx чтобы строки смещались вниз, а не наезжали одна на одну
        SetLine Map1  
        inc cx
        SetLine Map2
        inc cx
        SetLine Map3
        inc cx
        SetLine Map4
        inc cx
        SetLine Map5
        inc cx
        SetLine Map6
        inc cx
        SetLine Map7
        inc cx
        SetLine Map8
        inc cx
        SetLine Map9
        inc cx
        SetLine Map10
        inc cx
        SetLine Map11
    endm
    
    Macro Win                 ; макрос для вывода сообщения о победе
        call ClearScreen      ; процедура очистки экрана
        SetPos 6,6            ; установить курсор в позицию x = 6, y = 6
        Mov Ah,09h            ; функция 09 - выдать строку на дисплей
        lea dx,Msg1           ; адрес строки, заканчивающейся символом '$' (ASCII 24H)
        int 21h               ; Прерывание BIOS 21h
    endm


data segment
    Player db 02h,"$" 
    
    Map0 db  "++++++++++++++++++++++++++++++++++++++++$"     ; 
    Map1 db  "|              ###############         |$"     ; 
    Map2 db  "|              #             #         |$"     ; 
    Map3 db  "|              #             #         |$"     ; к
    Map4 db  "|    #######   #  ########   #         |$"     ; а
    Map5 db  "|#####     #####  #      #   ######    |$"     ; р
    Map6 db  "|#           ##   #      #        #### |$"     ; т
    Map7 db  "|#   ####         #      #           # |$"     ; а
    Map8 db  "|#####  #         #      #           # |$"     ;
    Map9 db  "|       ###########      ########    0#|$"     ;
    Map10 db "|                               #######|$"     ;
    Map11 db "++++++++++++++++++++++++++++++++++++++++$"     ;
    
    xPlayer db 06h           ; начальная позиция x для Игрока
    yPlayer db 06h           ; начальная позиция y для Игрока
    
    xBall db 08h              ; начальная позиция x для Шарика
    yBall db 06h              ; начальная позиция y для Шарика
    
    xBlock db 00h             ; начальная позиция x для Блока
    yBlock db 00h             ; начальная позиция y для Блока
    
    CantMoveBall db 01h       ; переменная, которая показывает может ли двигаться мячик
    
    direction db 00h          ; переменная для указания направления перемещения(0 - вверх, 1 - вниз, 2 - влево, 3 - вправо)
 
    Msg1 db "Congratulations you win$"      ; сообщение о победе
    wait_time dw 0            ; начальное время ожидания = 0
    cur_dir db 00h            ; переменная для текущей нажатой клавиши
ends


code segment
    main:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
        mov ax, @data	
        mov	ds, ax      ; указать сегмент данных
        
        ;mov bh, 00 
        mov ah, 0		; function 0 (set video mode), функция установки видеорежима
        mov al, 03h	    ; цветной текст 80х25 с очисткой экрана, стандартный 16-цветный текстовый режим, Видеорежим номер 3 используется в DOS по умолчанию
        int 10h         ; вызвать прерывание BIOS

        call  Init_all  ; выводим на экран карту, игрока и мячик
        
        cycle:
            CMP cur_dir,061h    ; если нажата клавиша A
            je GoLeft           ; если равно  
            
            CMP cur_dir,064h    ; если нажата клавиша D
            je GoRight          ; если равно
            
            CMP cur_dir,077h    ; если нажата клавиша W
            je GoUp             ; если равно
            
            CMP cur_dir,073h    ; если нажата клавиша S
            je GoDown           ; если равно
        
        next:                   ; блок для того чтобы мячик и игрок не наезжали на препятсвия
            push ax
            mov ah, xBall
            mov xBlock, ah
            mov ah, yBall
            mov yBlock, ah
            pop ax 
       
        keys:
            Mov Cx,10
            Mov Ah,01h          ; определить наличие символов в буфере
            int 16h             ; прерывание 16h           
            jz no_keys          ; если ноль
                    
            CMP Al,071h         ; если нажата клавиша Q
            je Escape           ; если равно
                    
            mov cur_dir, al     ; поместить в cur_dir текущую клавишу из буфера
            
            Mov Ah,00h          ; читать следующий символ из буфера
            int 16h             ; прерывание 16h
                
            Mov Al,00h          ; поместить в AL 0
            
        no_keys:                    ; ожидание нажатия клавиши
            mov     ah, 00h         ; Чтение счетчика циклов таймера
            int     1ah             ; прерывание 1ah
            cmp     dx, wait_time   ; клавишу нажали
            jb      keys            ; если ниже
            add     dx, 4           ;
            mov     wait_time, dx   ;
            
            jmp cycle               ; безусловный переход 
            
        noBuffer:  
            Mov cur_dir,00h         ; поместить в cur_dir 0
            Mov CantMoveBall, 01h   ; поместить в переменную 1
            jmp next                ; безусловный переход

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             
        GoRight:                        ; движение вправо
            Add xPlayer,01h            ; добавить к координате x игрока 1   
            SetPos yPlayer,xPlayer    ; установить курсор в новое положение
            mov ah,08                   ; функция 08 – считать символ и атрибут символа в текущей позиции курсора
            mov bh,00                   ; номер страницы
            int 10h                     ; Прерывание BIOS 10h  
            
            Sub xPlayer,01h        ; уменьшить координату x игрока на 1
            CMP AL,23h              ; если след. элемент в строке #(т.е. блок), то мы застряли и не двигаемся
            je noBuffer             ; если равно    
            CMP AL,04h              ; иначе двигаемся вправо
            jne MoveRight           ; если не равно
            
            mov direction, 03h      ; в dir записываем 3(0 - вверх, 1 - вниз, 2 - влево, 3 - вправо)
            call Ball_move          ; вызываем процедуру для перемещения мячика
            xor cx, cx              ; обнуление cx
            mov cl,CantMoveBall     ; если мы уперлись в стенку
            jcxz noBuffer           ; переход, если CX = 0
           
        MoveRight:                      ; перемещение игрока вправо      
            SetPos yPlayer,xPlayer      ; установить курсор в новое положение
            Clear                       ; очистить строку
            Add xPlayer,01h             ; добавить к координате x игрока 1
            SetPos yPlayer,xPlayer      ; установить курсор в новое положение
        
            PaintPlayer                 ; нарисовать игрока в новом положении
            
            jmp noBuffer          ; безусловный переход

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
        GoLeft:
            Sub xPlayer,01h
            SetPos yPlayer,xPlayer
            mov ah,08  ; функция 08 – считать символ и атрибут символа в текущей позиции курсора
            mov bh,00  ; номер страницы
            int 10h    ; Прерывание BIOS 10h
             
            Add xPlayer,01h 
            CMP AL,23h
            je noBuffer             ; если равно  
            CMP AL,04h
            jne MoveLeft            ; если не равно
            
            mov direction, 02h
            call Ball_move          ; вызываем
            xor cx, cx              ; обнуление cx
            mov cl,CantMoveBall     ; если мы уперлись в стенку
            jcxz noBuffer           ; переход, если CX = 0
            
        MoveLeft:   
            SetPos yPlayer,xPlayer
            Clear
            Sub xPlayer,01h
            SetPos yPlayer,xPlayer
        
            PaintPlayer
                              
            jmp noBuffer            ; безусловный переход  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;            
        GoUp:
            Sub yPlayer,01h
            SetPos yPlayer,xPlayer
            mov ah,08  ; функция 08 – считать символ и атрибут символа в текущей позиции курсора
            mov bh,00  ; номер страницы
            int 10h    ; Прерывание BIOS 10h  
            
            Add yPlayer,01h
            CMP AL,23h
            je noBuffer             ; если равно 
            CMP AL,04h
            jne MoveUp              ; если не равно
            
            mov direction, 00h
            call Ball_move 
            xor cx, cx              ; обнуление cx
            mov cl,CantMoveBall 
            jcxz noBuffer           ; переход, если CX = 0
            
        MoveUp:  
            SetPos yPlayer,xPlayer                        
            Clear
            Sub yPlayer,01h 
            SetPos yPlayer,xPlayer
            PaintPlayer
            
            jmp noBuffer            ; безусловный переход

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
        GoDown:
            Add yPlayer,01h
            SetPos yPlayer,xPlayer
            mov ah,08               ; функция 08 – считать символ и атрибут символа в текущей позиции курсора
            mov bh,00               ; номер страницы
            int 10h                 ; Прерывание BIOS 10h 
            
            Sub yPlayer,01h
            CMP AL,23h
            je noBuffer             ; если равно  
            CMP AL,04h
            jne MoveDown            ; если не равно  
            
            mov direction, 01h
            call Ball_move 
            xor cx, cx              ; обнуление cx
            mov cl,CantMoveBall
            jcxz noBuffer           ; переход, если CX = 0
            
        MoveDown:   
            SetPos yPlayer,xPlayer
            Clear
            Add yPlayer,01h 
            SetPos yPlayer,xPlayer
            PaintPlayer
            
            jmp noBuffer            ; безусловный переход        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
        Escape:
            Mov Ah,00h          ; читать следующий символ из буфера                  
            int 16h             ; Прерывание 16h
            mov ax, 4c00h       ; Выход в опер. систему
            int 21h             ; Прерывание 21h
        ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        Ball_move proc near 
            jmp compares                ; безусловный переход
             
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            BallUp:
               
               Dec yBall                            
               
               SetPos yBall,xBall
               mov ah,08               ; функция 08 – считать символ и атрибут символа в текущей позиции курсора
               mov bh,00               ; номер страницы
               int 10h                 ; Прерывание BIOS 10h
               CMP AL,30h
               je Winner               ; если равно 
               CMP AL,23h
               jne moveBallUp          ; если не равно
               mov CantMoveBall, 00h
               Inc yBall
            ret                        ; возврат из процедуры
            
                  
            moveBallUp:
                inc yBall
                SetPos yBall,xBall  
                Clear
                Dec yBall
                ;Inc xBall
                SetPos yBall,xBall
                PaintBall
                mov  direction,04h 
                ;Mov flag2,01h
              jmp ver_score             ; безусловный переход

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            BallLeft:  
              
               Dec xBall
                                     
               SetPos yBall,xBall
                mov ah,08  ; функция 08 – считать символ и атрибут символа в текущей позиции курсора
                mov bh,00  ; номер страницы
                int 10h    ; Прерывание BIOS 10h 
                CMP AL,30h
                je Winner               ; если равно 
                CMP AL,23h 
                jne moveballLeft        ; если не равно    
                mov CantMoveBall, 00h
                Inc xBall
                ret                     ; возврат из процедуры
            
            moveballLeft:
                Inc xBall   
                SetPos yBall,xBall
                Clear
               
                Dec xBall
                SetPos yBall,xBall
                PaintBall
                Mov direction,00h
              jmp ver_score                 ; безусловный переход                 
          
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            BallRight:
              
                Inc xBall              ; координата x блока +1
                                                       
               SetPos yBall,xBall     ; установить курсор в новое положение блока
                mov ah,08               ; функция 08 – считать символ и атрибут символа в текущей позиции курсора
                mov bh,00               ; номер страницы
                int 10h                 ; Прерывание BIOS 10h
                CMP AL,30h              ; если достигли финиша, то вызываем макрос Виннер
                je Winner               ; если равно 
                CMP AL,23h              ; если уперлись в стенку
                jne moveBallRight       ; если не равно , то перемещаем мячик   
                mov CantMoveBall, 00h   ; если все-таки уперлись в стенку, то в CMB записываем 0
                Dec xBall               ; возвращаем координату x на старое положение
                ret                     ; возврат из процедуры
            
            moveBallRight:              ; двигаем мячик вправо
                dec xBall              ; уменьшаем координату x мячик на 1
                SetPos yBall,xBall      ; устанавливаем курсор в новые координаты
                Clear                   ; чистим 
                Inc xBall               ; увеличиваем координату x мячика на 1
                SetPos yBall,xBall      ; устанвливаем курсор в новую позицию
                PaintBall               ; рисуем мячик
                mov direction,04h       ; 
              jmp ver_score             ; безусловный переход

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            BallDown: 
                
                Inc yBall
                               
               SetPos yBall,xBall
                mov ah,08  ; функция 08 – считать символ и атрибут символа в текущей позиции курсора
                mov bh,00  ; номер страницы
                int 10h    ; Прерывание BIOS 10h
                CMP AL,30h
                je Winner                   ; если равно 
                CMP AL,23h 
                jne moveBallDown            ; если не равно    
                mov CantMoveBall, 00h       
                Dec yBall
                ret                         ; возврат из процедуры
            
            moveBallDown:
                Dec yBall    
                SetPos yBall,xBall
                Clear
                Inc yBall
                ;Inc xBall
                SetPos yBall,xBall
                PaintBall
                Mov direction,04h
              jmp ver_score                 ; безусловный переход 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
            compares:                           ; узнаем напрвление, в котором хотим двигаться(0 - вверх, 1 - вниз, 2 - влево, 3 - вправо)
                CMP direction,00h
                Je BallUp                       ; если равно
                
                CMP direction,01h
                Je BallDown                     ; если равно
                
                CMP direction,02h
                Je BallLeft                     ; если равно
                
                CMP direction,03h               
                Je BallRight                    ; если равно
            
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;            
            ver_score:                      
                ret                         ; возврат из процедуры
            
            Winner:  
                Win 
                jmp Escape              ; безусловный переход
                ret                     ; возврат из процедуры
         Ball_move endp 
         
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        Init_all proc near              ; процедура для вывода на экран карты, героя и мячика
            SetMap                      ; вывести карту
            SetPos yPlayer,xPlayer    ; установить координаты для игрока
            PaintPlayer                 ; нарисовать игрока
            SetPos yBall,xBall          ; установить координаты для мячика
            PaintBall                   ; нарисовать мячик
            ;mov Al,0                    ;
            ret                         ; возврат из процедуры
        Init_all endp 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ClearScreen  proc near          ; процедура для полной очистки экрана  
            SetPos 12,0                 ; установить курсор в нижний левый угол
            mov cx, 12                  ; кол-во раз, которое нужно пройти, т.к. x = 12(0 .. 11)
            loop_clear:                 ; цикл очистки по строкам
                push cx                 ; заносим cx в стек, чтобы он не уменьшался, когда мы будем проходить по столбцам
                SetPos cl,0             ; устанавливаем в начало
                mov cx, 41              ; кол-во раз, которое нужно пройти, т.к. y = 41(0 .. 41)
                loop_for:               ; цикл по столбцам
                    Clear               ; удалить символ
                loop loop_for
                pop cx                  ; восстанавливаем cx для дальнейшего прохода по строкам
            loop loop_clear
             
            SetPos 0,0                  ; устанавливаем курсор в верхний левый угол
            mov cx, 41                  ; заносим в cx 41, чтобы удалить верхнюю строчку
            
            loop_for2:                  ; цикл для удаления верхней строчки
                Clear                   ; ; удалить символ
            loop loop_for2 
            ret                     ; возврат из процедуры 
        ClearScreen endp
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
    ends 
end main