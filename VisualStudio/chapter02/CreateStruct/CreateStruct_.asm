.model flat,c
include TestStruct_.inc
extern malloc:proc
extern free:proc

.code
;extern "C" TestStruct * CreateTestStruct_(__int8 val8, __int16 val16, __int32 val32, __int64 val64)
CreateTestStruct_ proc
push ebp
mov ebp,esp

push sizeof TestStruct
call malloc
add esp,4
or eax,eax		;if null, jump
jz MallocError

mov dl,[ebp+8]
mov [eax+TestStruct.Val8],dl

mov dx,[ebp+12]
mov [eax+TestStruct.Val16],dx

mov edx,[ebp+16]
mov [eax+TestStruct.Val32],edx

mov ecx,[ebp+20]
mov edx,[ebp+24]
mov dword ptr [eax+TestStruct.Val64],ecx
mov dword ptr [eax+TestStruct.Val64+4],edx

MallocError:
pop ebp
ret
CreateTestStruct_ endp

;extern "C" void ReleaseTestStruct_(TestStruct * p);
ReleaseTestStruct_ proc
push ebp
mov ebp,esp

push [ebp+8]
call free
add esp,4

pop ebp
ret
ReleaseTestStruct_ endp

end

