.model flat,c

.code
;extern "C" int CompareArrays_(const int* x, const int* y, int n);
; -1  invalid
; 0<=i<n	index of string where doesn't match
; n		all match
CompareArrays_ proc
push ebp
mov ebp,esp
push esi
push edi

mov eax,-1
mov ecx,[ebp+16]
test ecx,ecx
jle @F				;n<=0,jump

;cmp arrays
mov eax,ecx
mov esi,[ebp+8]
mov edi,[ebp+12]
repe cmpsd
je @F

; if not equal, calculate index
sub eax,ecx
dec eax

@@:
pop edi
pop esi
pop ebp
ret
CompareArrays_ endp
end