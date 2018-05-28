; multi-segment executable file template.

data segment  
    space db ' '
    enter  db 0dh,0ah,'$' 
    InputString db 'String', 0dh, 0ah, '$'
    InputWord db 'Word', 0dh, 0ah, '$'    
    Resault db 'Resault', 0dh, 0ah, '$'
      
    buferForFinish db 40  
    len2 db 0
    str2 db 200 dup ('$')
    
    buferForWord db 40  
    len1 db 0
    str1 db 200 dup ('$')
    
    buferForString db 40  
    len db 0
    str db 200 dup ('$')
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
    mov bx, 1
                 
    ;typing "String"             
    mov ah,9h
    mov dx,offset InputString
    int 21h   
                    
    ;reading string                 
    mov ah,0Ah   
    mov dx, offset buferForString       
    ;lea dx,bufer
    int 21h    
    
    ;typing Enter
    mov ah,9h   
    mov dx,offset enter      
    int 21h 
    
    ;typing "Word"
    mov ah,9h
    mov dx,offset InputWord
    int 21h   
    
    ;reading word          
    mov ah,0ah
    mov dx,offset buferForWord
    int 21h 
    
    ;typing Enter
    mov ah,9h   
    mov dx,offset enter      
    int 21h   
    
    ;if string is empty  go end
    mov cx,0
    mov cl,buferForString[1]
    jcxz end            ;if cx = 0
                       
    ;if word is empty  go end                   
    mov dx,0
    mov dl,buferForWord[1]
    or dx,dx
    jz end          ; if 0
     
    lea si,str[0] 
    mov di,si
     
for:             ;looking for symbol
    lodsb      
    cmp al,space    ;compare to symbol  si++(=pointre1++)
    je newWord     ;if pointer1[si] != " " go to newWord     if =
    loop for       ;else go to for
     
    inc si          ;when i want to delete last word

newWord:  
    pushf
    cld
    mov ax,si      ; ax = si count length of word in string
    sub ax,di      ; ax = ax - si
    dec ax         ; ax - 1
    cmp ax,dx      ; if ax == dx
     
    jne next       ; if(wordInString.Length != wordForDelete.Length)      if !=
     
    ;comparer
    push    si     ; add in stack
    push    di
    push    cx
    push    es
    push    ds
    pop     es     ; delete from stack to es
    mov     cx, dx    ; length of strings
    lea     si, str1[0]  ;comparer if (word in string - buferForWord = 0) word in string=buferForWord
    repe    cmpsb    ; cmp while symbols = (sym1 = sym2)
    pop     es
    pop     cx
    pop     di
    pop     si
    jne     next             ; if !=
    jcxz    skipCopy         ; if cx = 0
    
    ;delete
    push    cx
    push    si
    push    di
    push    es
    push    ds
    pop     es 
    inc     cx     ; cx = cx - 1
    rep movsb      ; repeat while cx != 0
    pop     es
    pop     di
    pop     si
    pop     cx
    mov     si, di
    
    ;infinite cycle for deleting all words
    ;cmp bx, 0
    loop for 
    ;cmp bx,1
    ;je for
     
skipCopy:   
    inc cx
    rep     movsb

next:
    popf
    mov     di, si         ; di = si
    jcxz    end            ; if(cx==0) go to end
    loop    for            ; else go to for

end: 
    ;typing "Resault"
    mov ah,9h
    mov dx,offset Resault
    int 21h 
   ; xor dx,dx 
           
    ;typing string
    mov ah,9h
    lea dx,str
    int 21h         
    
    ;exit
    mov ax, 4c00h 
    int 21h      
    int 20h
ends

end start 