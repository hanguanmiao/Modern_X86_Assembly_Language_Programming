.model flat,c

.code
;extern "C" MmxVal MmxAdd_(MmxVal a, MmxVal b, MmxAddOp op)
MmxAdd_ proc
push ebp
mov ebp,esp

mov eax,[ebp+24]
cmp eax,AddOpTableCount
jae BadAddOp

movq mm0,[ebp+8]
movq mm1,[ebp+16]
jmp [AddOpTable+eax*4]

MmxPaddb:
paddb mm0,mm1
jmp SaveResult

MmxPaddsb:
paddsb mm0,mm1
jmp SaveResult

MmxPaddusb:
paddusb mm0,mm1
jmp SaveResult

MmxPaddw:
paddw mm0,mm1
jmp SaveResult

MmxPaddsw:
paddsw mm0,mm1
jmp SaveResult

MmxPaddusw:
paddusw mm0,mm1
jmp SaveResult

Mmxpaddd:
paddd mm0,mm1
jmp SaveResult

BadAddOp:
pxor mm0,mm0

SaveResult:
movd eax,mm0
pshufw mm2,mm0,01001110b
movd edx,mm2

emms

pop ebp
ret

align 4
AddOpTable:
dword MmxPaddb, MmxPaddsb, MmxPaddusb, MmxPaddw, MmxPaddsw, MmxPaddusw, MmxPaddd
AddOpTableCount equ ($-AddOptable) / size dword

MmxAdd_ endp
end
