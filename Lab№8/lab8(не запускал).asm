NLN EQU 0Dh,0Ah
STE EQU 24h

;;Макрос вывода строки
output_str macro str
	push ax
	push dx
	mov ah,09h
	lea dx,str
	int 21h
	pop dx
	pop ax
endm

wait_macro macro
	push ax
	push cx
	push dx
	mov cx,3h
	mov dx,0D40h
	mov ah,83h
	int 15h
	pop dx
	pop cx
	pop ax	
endm

.model small

.stack 100h

.data
	NewLine			db NLN,STE
	aboutText		db "Displays the choosen file content in text form.",NLN,NLN
					db "LAB4 [drive:][path] file",NLN,NLN
					db "  file	Name of file to open.",NLN,NLN
					db "Does not works without parameters!",NLN,STE	
	wrongArgsMsg	db "Wrong command line parametres!",NLN,STE
	seeHelpMsg		db "Use /? to see help.",NLN,STE
	noArgMsg		db "You should input file name as an command line parameter!",NLN,STE
	fileNotFountMsg db "File not found!",NLN,STE
	pathNotFoundMsg db "Path not found!",NLN,STE
	noAccessMsg		db "Access is denied!",NLN,STE
	openErrorMsg	db "File open error!",NLN,STE
	readNoAccessMsg db "Access to read is denied!",NLN,STE
	FatalErrorMsg   db "Fatal error!", NLN,STE
	continueMsg		db "Press to continue...",STE
	
	
	fileName db 126 DUP(0)
	fileHandle dw 0
	
	strBuffer db 2 DUP(STE)
	strBufferLen = 1
	
	old_int23	dd ?
	new_int23	dd ?
	
.code
	main PROC
	
	jmp main_start
	
	_int23:
		pushf
		push ax
		push dx
		push ds
		
		;;Внутри самого перывания восстанавливаем
		;;оригинальный обработчик, чтобы если
		;;повторно вызвалось это же прерывание не возникла
		;;блокировка
		mov ax,@data
		mov ds,ax
        
		mov dx,word ptr old_int23
		mov ax,word ptr old_int23+2
		mov ds,ax
		
		mov ah,25h
		mov al,23h
		int 21h
		
		mov ah,08h
		int 21h
		
		mov ax,@data
		mov ds,ax
		
		;;Возврщаем свой обработчик
		mov dx,word ptr new_int23
		mov ax,word ptr new_int23+2
		mov ds,ax
		
		mov ah,25h
		mov al,23h
		int 21h
		
		pop ds
		pop dx
		pop ax
		popf
		
		iret

	

	
	main_start:		
		push ds
		push es
		push cs
		pop es
		
		;;Готовим данные для записи нового
		;;вектора прерывания
		mov ax,@data
		mov ds,ax
		mov dx,_int23
		mov word ptr new_int23,dx
		mov word ptr new_int23+2,es
		
		;;Сохраняем старый вектор
		mov ah,35h
		mov al,23h
		int 21h
		mov word ptr old_int23,bx
		mov word ptr old_int23+2,es
		
		;;Записываем новый
		push cs
		pop ds
		mov ah,25h
		mov al,23h
		int 21h
		
		pop es
		pop ds
		
		int 23h
		
		;;Установка в ES начала сегмента данных
		;;Регистр DS не изменяем - он указывает на начало PSP
		mov ax,@data
		mov es,ax
		;;Записываем в CX длину командной строки
		;;Для выполнения повтора строковой команды
		xor cx,cx
		mov cl,[80h]
		;;Если нет аргумента
		cmp cx,0
		je no_arg
		dec cx
		
		;;Проверка на специальный аргумент
		mov bl,[82h]
		cmp bl,'/'
		jne file
		mov bl,[83h]
		cmp bl,'?'
		jne file
		mov bl,[84h]
		cmp bl,20h
		je about
		cmp bl,0Dh
	about:
		mov ds,ax
		output_str aboutText
		jmp exit
		
	file:
		;;В регистр SI записывем смещение командной строки
		;;81h + пропускаем символ пробела
		mov si,82h
		;;В регистр DI записываем смещение переменной file
		lea di,fileName
		;;Переписываем аргумент командной строки в file
		rep movsb
		;;Записываем в DS начало сегмента данных
		mov ds,ax
               
        ;;Открываем файл
        mov ah,3Dh
        ;;Режим только для чтения
        mov al,000b
        ;;Адрес буфера с именем файла
        lea dx,fileName
        int 21h
        ;;Если файл не открылся
        ;;Обробатываем это
        jb cannot_open
        ;;Записываем идентификатор файла
        mov fileHandle,ax
                
        ;;Выводим содержимое файла
        mov bx,ax
		;;Очистить терминал
		mov ax,0003h
		int 10h
	    lea dx,strBuffer
	read:
		;;Чтение в буфер
		mov ah,3Fh
		;;Число считываемых символов
		;;И буфер для считывания
		mov cx,strBufferLen
		int 21h
		;;Если произошла ошибка - обраьотать
		jb read_error  
        ;;Проверяем сколько считано
        cmp ax,strBufferLen
        je out_buffer
        ;;Если считано меньше максимума
        mov si,ax
        ;;Помещаем символ конца, выводим строку
 		mov [strBuffer+si],0Ah
 		mov [strBuffer+si+1],STE
 		mov ah,09h
 		int 21h
        ;;И закрываем файл
 		jmp close_file       
	out_buffer:
		;;Выводим считанную строку
 		mov ah,09h
 		int 21h
		push ax
		push cx
		push dx
		mov ah,03h
		mov bh,00h
		int 10h
		cmp dx,174Fh
	    jle to_read
	    output_str continueMsg	
		mov ah,08h
		int 21h
		mov ax,0003h
		int 10h	    
	to_read:
		pop dx
		pop cx
		pop ax
 		jmp read    
        
	close_file:    
        ;;Закрываем файл
        mov ah,3Eh
        mov bx,fileHandle
        int 21h
        	
	exit:
		;;Восстанавливаем оригинальный обработчик на выходе
		push cs:old_int23+2
		pop ds
		mov dx,word ptr cs:old_int23
		mov ah,25h
		mov al,23h
		int 21h
		;;Завершение
		mov ax,4C00h
		int 21h
	          
	          
	wrong_args:
		mov ds,ax
		output_str wrongArgsMsg
		output_str seeHelpMsg
	    jmp exit
	    
	no_arg:
	    mov ds,ax
	    output_str noArgMsg
	    output_str seeHelpMsg
		jmp exit
	
	;;Обработка ошибки открытия
	cannot_open:
		cmp ax,02h
		je file_not_found
		cmp ax,03h
		je path_not_found
		cmp ax,05h
		je no_access
		output_str openErrorMsg
		jmp exit
		
		file_not_found:
			output_str fileNotFountMsg
			jmp exit
		path_not_found:
			output_str pathNotFoundMsg
			jmp exit
		no_access:
			output_str noAccessMsg
			jmp exit
	
	;;Обработка ошибки при чтении		
	read_error:
		cmp ax,05h
		je read_no_access
		output_str fatalErrorMsg
		jmp exit
		
		read_no_access:
			output_str readNoAccessMsg
			jmp exit
			
	main ENDP
end