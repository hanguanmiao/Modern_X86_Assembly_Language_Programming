.model flat,c
include TestStruct_.inc

.code
;extern "C" __int64 CalcStructSum_(const TestStruct * ts)
CalcStructSum_ proc
push ebp
mov ebp,esp
push ebx
push esi

mov esi,[ebp+8]	;esi=ts
movsx eax,byte ptr [esi+TestStruct.Val8]
movsx ebx,word ptr [esi+TestStruct.Val16]
add eax,ebx

cdq
mov ecx,edx
mov ebx,eax

mov eax,dword ptr [esi+TestStruct.Val32]
cdq
add eax,ebx
adc edx,ecx

add eax,dword ptr[esi+TestStruct.Val64]
adc edx,dword ptr[esi+TestStruct.Val64+4]

pop esi
pop ebx
pop ebp
ret
CalcStructSum_ endp

end