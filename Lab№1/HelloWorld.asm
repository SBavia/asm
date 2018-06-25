CSEG segment
org 100h

Begin:
	mov ah,9
	mov dx,offset Message
	int 21h
	int 20h
	Message db 'Hello, World!$'
CSEG ends
end Begin