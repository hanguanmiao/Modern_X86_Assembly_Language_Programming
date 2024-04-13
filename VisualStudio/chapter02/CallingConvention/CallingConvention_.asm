.model flat,c
.code


;extern "C" void CalculateSums_(int a, int b, int c, int* s1, int* s2, int* s3);


CalculateSums_	proc

;function prologue
push ebp
mov	ebp,esp
sub	esp,12
push ebx
push esi
push edi

mov	eax,[ebp+8]		;eax=a
mov	ebx,[ebp+12]	;ebx=b
mov ecx,[ebp+16]	;ecx=c
mov edx,[ebp+20]	;edx=s1
mov esi,[ebp+24]	;esi=s2
mov edi,[ebp+28]	;sdi=s3

;calculate: a+b+c
mov [ebp-4],eax
add	[ebp-4],ebx
add [ebp-4],ecx

;calculate: a*a + b*b + c*c
imul eax,eax		;eax=a*a
imul ebx,ebx		;ebx=b*b
imul ecx,ecx		;ecx=c*c
mov [ebp-8],eax
add [ebp-8],ebx
add [ebp-8],ecx

;calculate: a*a*a + b*b*b + c*c*c
imul eax,[ebp+8]		;eax=a*a*a
imul ebx,[ebp+12]	;ebx=b*b*b
imul ecx,[ebp+16]	;ecx=c*c*c
mov [ebp-12],eax
add [ebp-12],ebx
add [ebp-12],ecx

mov eax,[ebp-4]
mov [edx],eax		;save to s1
mov eax,[ebp-8]
mov [esi],eax		;save to s2
mov eax,[ebp-12]
mov [edi],eax		;save to s3


;function epilogue
pop edi
pop esi
pop ebx
mov esp,ebp
pop ebp
ret

CalculateSums_	endp
end