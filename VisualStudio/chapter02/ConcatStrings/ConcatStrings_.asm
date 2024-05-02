.model flat,c

.code
;extern "C" int ConcatStrings_(wchar_t* des, int des_size, const wchar_t* const* src, int src_n);
; error -1,  success wcslen of des
ConcatStrings_ proc
push ebp
mov ebp,esp
sub esp,8		;[ebp-4]=des_wcslen,[ebp-8]=src_idx
push ebx
push esi
push edi

;check des_size
mov eax,-1
mov ecx,[ebp+12]
cmp ecx,0
jle ERROR

;check src_n
mov ecx,[ebp+20]
cmp ecx,0
jle ERROR

;initilize
xor eax,eax
mov ebx,[ebp+8]		;ebx=des
mov [ebx],ax		;des[0]='\0'
mov [ebp-4],eax		;des_wcslen=0
mov [ebp-8],eax		;src_idx=0

LP:
mov eax,[ebp+16]	;eax=src
mov edx,[ebp-8]		;edx=i
mov esi,[eax+edx*4]
mov edi,esi

xor eax,eax
mov ecx,-1
repne scasw
not ecx
dec ecx

mov eax,[ebp-4]		;eax=des_wcslen
mov edx,eax			;edx=des_wcslen
add eax,ecx

cmp eax,[ebp+12]
jge DONE

;add [ebp-4],ecx
mov [ebp-4],eax

lea edi,[ebx+edx*2]
inc ecx				;include '\0'
rep movsw

mov eax,[ebp-8]
inc eax
mov [ebp-8],eax
cmp eax,[ebp+20]
jl LP


DONE:
mov eax,[ebp-4]
ERROR:
pop edi
pop esi
pop ebx
mov esp,ebp
pop ebp
ret

ConcatStrings_ endp

end