.model flat,c
.code

;extern "C" int IntegerMulDiv_(int a, int b, int* prod, int* quo, int* rem);

;返回值： 0 Error
;        1 success

IntegerMulDiv_ proc

;函数序言
push ebp
mov ebp,esp
push ebx

xor eax,eax             ;设置错误返回值为0
mov ecx,[ebp+8]         ;ecx=a
mov edx,[ebp+12]        ;edx=b
or  edx,edx             ;检测b是否为0
jz  InvalidDivisor

;计算乘积
imul edx,ecx
mov  eax,[ebp+16]       ;eax=prod
mov  [eax],edx            ;*prod=乘积

;计算除数
mov  eax,ecx            ;eax=a
cdq
idiv dword ptr [ebp+12] ;a/b
mov  ecx,[ebp+20]       ;ecx=quo
mov  [ecx],eax
mov  ecx,[ebp+24]        ;ecx=rem
mov  [ecx],edx

mov eax,1               ;设置成功返回值1

;函数结语
InvalidDivisor:
pop ebx
pop ebp
ret

IntegerMulDiv_ endp
end