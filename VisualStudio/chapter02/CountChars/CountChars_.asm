.model flat,c

.code
;extern "C" int CountChars_(wchar_t* s, wchar_t c);

CountChars_ proc
push ebp
mov ebp,esp
push esi

mov esi,[ebp+8]
mov cx,[ebp+12]
xor edx,edx

@@:
lodsw
or ax,ax
jz @F
cmp ax,cx
jnz @B
inc edx
jmp @B

@@:
mov eax,edx
pop esi
pop ebp
ret

CountChars_ endp

end