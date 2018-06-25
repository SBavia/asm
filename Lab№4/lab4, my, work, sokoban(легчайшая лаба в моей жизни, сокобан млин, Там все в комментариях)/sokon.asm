.Model Small                   ; ������ ������ ��� ���

stack segment
    dw   256  dup(0)           ; ������� ����� �������� � 256 ����
ends
    
    
    Macro SetPos X,Y           ; ������ ��� ��������� ������� � ����������� x, y
        Mov Ah,02h             ; ������� 02 � ���������� ��������� �������
        Mov Dh,X               ; ����� ������ (������ �� 0, ��������� �� ������ 25 ������ ������ ���������)
        Mov Dl,Y               ; ����� ������� (������ �� 0)
        int 10h                ; ���������� BIOS 10h
    endm
    
    Macro PaintPlayer          ; ������ ��� ��������� �������� �����
        Mov Ah,09h             ; ������� 09 - ������ ������ �� �������
        ;push bx
        ;Mov Bl,01h
        Lea Dx,Player          ; ����� ������, ��������������� �������� '$' (ASCII 24H)
        int 21h                ; ���������� BIOS 21h
        ;pop bx
    endm
    
    Macro PaintBall            ; ������ ��� ��������� ������, ������� ����� �������
        Mov Ah,02h             ; ������� 02 - ����� ������� �� �������
        ;Mov dh,011h
        Mov Dl,04h            ; ������, ��������� �� ����������� �����
        int 21h                ; ���������� BIOS 21h
    endm
    
    Macro Clear                ; ������ ��� ������� ������(������� � ������)
        Mov Ah,02h             ; ������� 02 - ����� ������� �� �������
        Mov Dl,00h             ; ������, ��������� �� ����������� �����(0)
        int 21h                ; ���������� BIOS 21h
    endm

    Macro SetLine line        ; ������ ��� ������ ������ �� �����
        SetPos Cl,00h         ; � ������� y �������� ���������� �������� cx(cl)
        Mov Ah,09h            ; ������� 09 - ������ ������ �� �������
        Lea Dx,line           ; ����� ������, ��������������� �������� '$' (ASCII 24H)
        int 21h               ; ���������� BIOS 21h
    endm
    
    Macro SetMap              ; ������ ��� ���������� �����
        xor cx, cx            ; ��������� cx
        SetLine Map0          ; ����� ����� ���������
        inc cx                ; +1 � cx ����� ������ ��������� ����, � �� �������� ���� �� ����
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
    
    Macro Win                 ; ������ ��� ������ ��������� � ������
        call ClearScreen      ; ��������� ������� ������
        SetPos 6,6            ; ���������� ������ � ������� x = 6, y = 6
        Mov Ah,09h            ; ������� 09 - ������ ������ �� �������
        lea dx,Msg1           ; ����� ������, ��������������� �������� '$' (ASCII 24H)
        int 21h               ; ���������� BIOS 21h
    endm


data segment
    Player db 02h,"$" 
    
    Map0 db  "++++++++++++++++++++++++++++++++++++++++$"     ; 
    Map1 db  "|              ###############         |$"     ; 
    Map2 db  "|              #             #         |$"     ; 
    Map3 db  "|              #             #         |$"     ; �
    Map4 db  "|    #######   #  ########   #         |$"     ; �
    Map5 db  "|#####     #####  #      #   ######    |$"     ; �
    Map6 db  "|#           ##   #      #        #### |$"     ; �
    Map7 db  "|#   ####         #      #           # |$"     ; �
    Map8 db  "|#####  #         #      #           # |$"     ;
    Map9 db  "|       ###########      ########    0#|$"     ;
    Map10 db "|                               #######|$"     ;
    Map11 db "++++++++++++++++++++++++++++++++++++++++$"     ;
    
    xPlayer db 06h           ; ��������� ������� x ��� ������
    yPlayer db 06h           ; ��������� ������� y ��� ������
    
    xBall db 08h              ; ��������� ������� x ��� ������
    yBall db 06h              ; ��������� ������� y ��� ������
    
    xBlock db 00h             ; ��������� ������� x ��� �����
    yBlock db 00h             ; ��������� ������� y ��� �����
    
    CantMoveBall db 01h       ; ����������, ������� ���������� ����� �� ��������� �����
    
    direction db 00h          ; ���������� ��� �������� ����������� �����������(0 - �����, 1 - ����, 2 - �����, 3 - ������)
 
    Msg1 db "Congratulations you win$"      ; ��������� � ������
    wait_time dw 0            ; ��������� ����� �������� = 0
    cur_dir db 00h            ; ���������� ��� ������� ������� �������
ends


code segment
    main:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
        mov ax, @data	
        mov	ds, ax      ; ������� ������� ������
        
        ;mov bh, 00 
        mov ah, 0		; function 0 (set video mode), ������� ��������� �����������
        mov al, 03h	    ; ������� ����� 80�25 � �������� ������, ����������� 16-������� ��������� �����, ���������� ����� 3 ������������ � DOS �� ���������
        int 10h         ; ������� ���������� BIOS

        call  Init_all  ; ������� �� ����� �����, ������ � �����
        
        cycle:
            CMP cur_dir,061h    ; ���� ������ ������� A
            je GoLeft           ; ���� �����  
            
            CMP cur_dir,064h    ; ���� ������ ������� D
            je GoRight          ; ���� �����
            
            CMP cur_dir,077h    ; ���� ������ ������� W
            je GoUp             ; ���� �����
            
            CMP cur_dir,073h    ; ���� ������ ������� S
            je GoDown           ; ���� �����
        
        next:                   ; ���� ��� ���� ����� ����� � ����� �� �������� �� ����������
            push ax
            mov ah, xBall
            mov xBlock, ah
            mov ah, yBall
            mov yBlock, ah
            pop ax 
       
        keys:
            Mov Cx,10
            Mov Ah,01h          ; ���������� ������� �������� � ������
            int 16h             ; ���������� 16h           
            jz no_keys          ; ���� ����
                    
            CMP Al,071h         ; ���� ������ ������� Q
            je Escape           ; ���� �����
                    
            mov cur_dir, al     ; ��������� � cur_dir ������� ������� �� ������
            
            Mov Ah,00h          ; ������ ��������� ������ �� ������
            int 16h             ; ���������� 16h
                
            Mov Al,00h          ; ��������� � AL 0
            
        no_keys:                    ; �������� ������� �������
            mov     ah, 00h         ; ������ �������� ������ �������
            int     1ah             ; ���������� 1ah
            cmp     dx, wait_time   ; ������� ������
            jb      keys            ; ���� ����
            add     dx, 4           ;
            mov     wait_time, dx   ;
            
            jmp cycle               ; ����������� ������� 
            
        noBuffer:  
            Mov cur_dir,00h         ; ��������� � cur_dir 0
            Mov CantMoveBall, 01h   ; ��������� � ���������� 1
            jmp next                ; ����������� �������

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             
        GoRight:                        ; �������� ������
            Add xPlayer,01h            ; �������� � ���������� x ������ 1   
            SetPos yPlayer,xPlayer    ; ���������� ������ � ����� ���������
            mov ah,08                   ; ������� 08 � ������� ������ � ������� ������� � ������� ������� �������
            mov bh,00                   ; ����� ��������
            int 10h                     ; ���������� BIOS 10h  
            
            Sub xPlayer,01h        ; ��������� ���������� x ������ �� 1
            CMP AL,23h              ; ���� ����. ������� � ������ #(�.�. ����), �� �� �������� � �� ���������
            je noBuffer             ; ���� �����    
            CMP AL,04h              ; ����� ��������� ������
            jne MoveRight           ; ���� �� �����
            
            mov direction, 03h      ; � dir ���������� 3(0 - �����, 1 - ����, 2 - �����, 3 - ������)
            call Ball_move          ; �������� ��������� ��� ����������� ������
            xor cx, cx              ; ��������� cx
            mov cl,CantMoveBall     ; ���� �� �������� � ������
            jcxz noBuffer           ; �������, ���� CX = 0
           
        MoveRight:                      ; ����������� ������ ������      
            SetPos yPlayer,xPlayer      ; ���������� ������ � ����� ���������
            Clear                       ; �������� ������
            Add xPlayer,01h             ; �������� � ���������� x ������ 1
            SetPos yPlayer,xPlayer      ; ���������� ������ � ����� ���������
        
            PaintPlayer                 ; ���������� ������ � ����� ���������
            
            jmp noBuffer          ; ����������� �������

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
        GoLeft:
            Sub xPlayer,01h
            SetPos yPlayer,xPlayer
            mov ah,08  ; ������� 08 � ������� ������ � ������� ������� � ������� ������� �������
            mov bh,00  ; ����� ��������
            int 10h    ; ���������� BIOS 10h
             
            Add xPlayer,01h 
            CMP AL,23h
            je noBuffer             ; ���� �����  
            CMP AL,04h
            jne MoveLeft            ; ���� �� �����
            
            mov direction, 02h
            call Ball_move          ; ��������
            xor cx, cx              ; ��������� cx
            mov cl,CantMoveBall     ; ���� �� �������� � ������
            jcxz noBuffer           ; �������, ���� CX = 0
            
        MoveLeft:   
            SetPos yPlayer,xPlayer
            Clear
            Sub xPlayer,01h
            SetPos yPlayer,xPlayer
        
            PaintPlayer
                              
            jmp noBuffer            ; ����������� �������  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;            
        GoUp:
            Sub yPlayer,01h
            SetPos yPlayer,xPlayer
            mov ah,08  ; ������� 08 � ������� ������ � ������� ������� � ������� ������� �������
            mov bh,00  ; ����� ��������
            int 10h    ; ���������� BIOS 10h  
            
            Add yPlayer,01h
            CMP AL,23h
            je noBuffer             ; ���� ����� 
            CMP AL,04h
            jne MoveUp              ; ���� �� �����
            
            mov direction, 00h
            call Ball_move 
            xor cx, cx              ; ��������� cx
            mov cl,CantMoveBall 
            jcxz noBuffer           ; �������, ���� CX = 0
            
        MoveUp:  
            SetPos yPlayer,xPlayer                        
            Clear
            Sub yPlayer,01h 
            SetPos yPlayer,xPlayer
            PaintPlayer
            
            jmp noBuffer            ; ����������� �������

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
        GoDown:
            Add yPlayer,01h
            SetPos yPlayer,xPlayer
            mov ah,08               ; ������� 08 � ������� ������ � ������� ������� � ������� ������� �������
            mov bh,00               ; ����� ��������
            int 10h                 ; ���������� BIOS 10h 
            
            Sub yPlayer,01h
            CMP AL,23h
            je noBuffer             ; ���� �����  
            CMP AL,04h
            jne MoveDown            ; ���� �� �����  
            
            mov direction, 01h
            call Ball_move 
            xor cx, cx              ; ��������� cx
            mov cl,CantMoveBall
            jcxz noBuffer           ; �������, ���� CX = 0
            
        MoveDown:   
            SetPos yPlayer,xPlayer
            Clear
            Add yPlayer,01h 
            SetPos yPlayer,xPlayer
            PaintPlayer
            
            jmp noBuffer            ; ����������� �������        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
        Escape:
            Mov Ah,00h          ; ������ ��������� ������ �� ������                  
            int 16h             ; ���������� 16h
            mov ax, 4c00h       ; ����� � ����. �������
            int 21h             ; ���������� 21h
        ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        Ball_move proc near 
            jmp compares                ; ����������� �������
             
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            BallUp:
               
               Dec yBall                            
               
               SetPos yBall,xBall
               mov ah,08               ; ������� 08 � ������� ������ � ������� ������� � ������� ������� �������
               mov bh,00               ; ����� ��������
               int 10h                 ; ���������� BIOS 10h
               CMP AL,30h
               je Winner               ; ���� ����� 
               CMP AL,23h
               jne moveBallUp          ; ���� �� �����
               mov CantMoveBall, 00h
               Inc yBall
            ret                        ; ������� �� ���������
            
                  
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
              jmp ver_score             ; ����������� �������

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            BallLeft:  
              
               Dec xBall
                                     
               SetPos yBall,xBall
                mov ah,08  ; ������� 08 � ������� ������ � ������� ������� � ������� ������� �������
                mov bh,00  ; ����� ��������
                int 10h    ; ���������� BIOS 10h 
                CMP AL,30h
                je Winner               ; ���� ����� 
                CMP AL,23h 
                jne moveballLeft        ; ���� �� �����    
                mov CantMoveBall, 00h
                Inc xBall
                ret                     ; ������� �� ���������
            
            moveballLeft:
                Inc xBall   
                SetPos yBall,xBall
                Clear
               
                Dec xBall
                SetPos yBall,xBall
                PaintBall
                Mov direction,00h
              jmp ver_score                 ; ����������� �������                 
          
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            BallRight:
              
                Inc xBall              ; ���������� x ����� +1
                                                       
               SetPos yBall,xBall     ; ���������� ������ � ����� ��������� �����
                mov ah,08               ; ������� 08 � ������� ������ � ������� ������� � ������� ������� �������
                mov bh,00               ; ����� ��������
                int 10h                 ; ���������� BIOS 10h
                CMP AL,30h              ; ���� �������� ������, �� �������� ������ ������
                je Winner               ; ���� ����� 
                CMP AL,23h              ; ���� �������� � ������
                jne moveBallRight       ; ���� �� ����� , �� ���������� �����   
                mov CantMoveBall, 00h   ; ���� ���-���� �������� � ������, �� � CMB ���������� 0
                Dec xBall               ; ���������� ���������� x �� ������ ���������
                ret                     ; ������� �� ���������
            
            moveBallRight:              ; ������� ����� ������
                dec xBall              ; ��������� ���������� x ����� �� 1
                SetPos yBall,xBall      ; ������������� ������ � ����� ����������
                Clear                   ; ������ 
                Inc xBall               ; ����������� ���������� x ������ �� 1
                SetPos yBall,xBall      ; ������������ ������ � ����� �������
                PaintBall               ; ������ �����
                mov direction,04h       ; 
              jmp ver_score             ; ����������� �������

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            BallDown: 
                
                Inc yBall
                               
               SetPos yBall,xBall
                mov ah,08  ; ������� 08 � ������� ������ � ������� ������� � ������� ������� �������
                mov bh,00  ; ����� ��������
                int 10h    ; ���������� BIOS 10h
                CMP AL,30h
                je Winner                   ; ���� ����� 
                CMP AL,23h 
                jne moveBallDown            ; ���� �� �����    
                mov CantMoveBall, 00h       
                Dec yBall
                ret                         ; ������� �� ���������
            
            moveBallDown:
                Dec yBall    
                SetPos yBall,xBall
                Clear
                Inc yBall
                ;Inc xBall
                SetPos yBall,xBall
                PaintBall
                Mov direction,04h
              jmp ver_score                 ; ����������� ������� 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
            compares:                           ; ������ ����������, � ������� ����� ���������(0 - �����, 1 - ����, 2 - �����, 3 - ������)
                CMP direction,00h
                Je BallUp                       ; ���� �����
                
                CMP direction,01h
                Je BallDown                     ; ���� �����
                
                CMP direction,02h
                Je BallLeft                     ; ���� �����
                
                CMP direction,03h               
                Je BallRight                    ; ���� �����
            
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;            
            ver_score:                      
                ret                         ; ������� �� ���������
            
            Winner:  
                Win 
                jmp Escape              ; ����������� �������
                ret                     ; ������� �� ���������
         Ball_move endp 
         
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        Init_all proc near              ; ��������� ��� ������ �� ����� �����, ����� � ������
            SetMap                      ; ������� �����
            SetPos yPlayer,xPlayer    ; ���������� ���������� ��� ������
            PaintPlayer                 ; ���������� ������
            SetPos yBall,xBall          ; ���������� ���������� ��� ������
            PaintBall                   ; ���������� �����
            ;mov Al,0                    ;
            ret                         ; ������� �� ���������
        Init_all endp 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ClearScreen  proc near          ; ��������� ��� ������ ������� ������  
            SetPos 12,0                 ; ���������� ������ � ������ ����� ����
            mov cx, 12                  ; ���-�� ���, ������� ����� ������, �.�. x = 12(0 .. 11)
            loop_clear:                 ; ���� ������� �� �������
                push cx                 ; ������� cx � ����, ����� �� �� ����������, ����� �� ����� ��������� �� ��������
                SetPos cl,0             ; ������������� � ������
                mov cx, 41              ; ���-�� ���, ������� ����� ������, �.�. y = 41(0 .. 41)
                loop_for:               ; ���� �� ��������
                    Clear               ; ������� ������
                loop loop_for
                pop cx                  ; ��������������� cx ��� ����������� ������� �� �������
            loop loop_clear
             
            SetPos 0,0                  ; ������������� ������ � ������� ����� ����
            mov cx, 41                  ; ������� � cx 41, ����� ������� ������� �������
            
            loop_for2:                  ; ���� ��� �������� ������� �������
                Clear                   ; ; ������� ������
            loop loop_for2 
            ret                     ; ������� �� ��������� 
        ClearScreen endp
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
    ends 
end main