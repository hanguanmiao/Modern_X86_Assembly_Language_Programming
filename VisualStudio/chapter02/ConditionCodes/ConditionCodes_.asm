.model flat,c

.code

;extern "C" int SignedMinA_(int a, int b, int c)
SignedMinA_ proc
push ebp
mov ebp,esp

mov eax,[ebp+8]		;eax=a
mov ecx,[ebp+12]	;ecx=b
cmp eax,ecx
jle @f
mov eax,ecx			
@@:
mov ecx,[ebp+16]	;ecx=c
cmp eax,ecx
jle @F
mov eax,ecx

@@:
pop ebp
ret
SignedMinA_ endp

;extern "C" int SignedMaxA_(int a, int b, int c);
SignedMaxA_ proc
push ebp
mov ebp,esp

mov eax,[ebp+8]		;eax=a
mov ecx,[ebp+12]	;ecx=b
cmp eax,ecx
jge @F
mov eax,ecx
@@:
mov ecx,[ebp+16]	;ecx=c
cmp eax,ecx
jge @F
mov eax,ecx

@@ :
pop ebp
ret
SignedMaxA_ endp

;extern "C" int SignedMinB_(int a, int b, int c);
SignedMinB_ proc
push ebp
mov ebp,esp

mov eax,[ebp+8]		;eax=a
mov ecx,[ebp+12]	;ecx=b
cmp eax,ecx
cmovg eax,ecx
mov ecx,[ebp+16]	;ecx=c
cmp eax,ecx
cmovg eax,ecx

pop ebp
ret
SignedMinB_ endp

;extern "C" int SignedMaxB_(int a, int b, int c);
SignedMaxB_ proc
push ebp
mov ebp,esp

mov eax,[ebp+8]		;eax=a
mov ecx,[ebp+12]	;ecx=b
cmp eax,ecx
cmovl eax,ecx
mov ecx,[ebp+16]	;ecx=c
cmp eax,ecx
cmovl eax,ecx

pop ebp
ret
SignedMaxB_ endp

end