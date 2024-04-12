.model flat,c
.code

CalcSum_ proc

push ebp
mov ebp,esp

mov eax,[ebp+8]
mov ebx,[ebp+12]
mov edx,[ebp+16]

add eax,ebx
add eax,edx

pop ebp
ret

CalcSum_ endp
end