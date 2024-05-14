.model flat,c

.code
;extern "C" bool MmxShift_(MmxVal a, MmxShiftOp shift_op, int count, MmxVal * b);
MmxShift_ proc
push ebp
mov ebp,esp

xor eax,eax
mov edx,[ebp+16]			;edx=shift_op
cmp edx,ShiftOpTableCount
jae BadShiftOp

mov eax,1
movq mm0,[ebp+8]
movd mm1, dword ptr [ebp+20]
jmp [ShiftOpTable + edx*4]

MmxPsllw:
psllw mm0,mm1
jmp SaveResult

MmxPsrlw:
psrlw mm0,mm1
jmp SaveResult

MmxPsraw:
psraw mm0,mm1
jmp SaveResult

MmxPslld:
pslld mm0,mm1
jmp SaveResult

MmxPsrld:
psrld mm0,mm1
jmp SaveResult

MmxPsrad:
psrad mm0,mm1
jmp SaveResult

BadShiftOp:
pxor mm0,mm0

SaveResult:
mov edx,[ebp+24]
movq [edx],mm0
emms

pop ebp
ret

align 4
ShiftOpTable: 
dword MmxPsllw, MmxPsrlw, MmxPsraw, MmxPslld, MmxPsrld, MmxPsrad
ShiftOpTableCount equ ($-ShiftOpTable) / sizeof dword
MmxShift_ endp

end