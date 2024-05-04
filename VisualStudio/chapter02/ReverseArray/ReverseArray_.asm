.model flat,c

.code
;extern "C" void ReverseArray_(int* y, const int* x, int n);
; 0 error
; 1 success

ReverseArray_ proc
push ebp
mov ebp,esp
push edi
push esi

mov edi,[ebp+8]
mov esi,[ebp+12]
mov ecx,[ebp+16]
xor eax,eax			;eax=0
test ecx,ecx
jle ERROR		; if n<=0, jump

lea esi,[esi+ecx*4-4]
pushfd
std

@@:
lodsd			;eax=*x--
mov [edi],eax
add edi,4
dec ecx
jne @B

popfd
mov eax,1

ERROR:
pop esi
pop edi
pop ebp
ret
ReverseArray_ endp
end
