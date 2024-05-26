.model flat,c

.code
;extern "C" bool SseSfpConversion_(XmmScalar * a, XmmScalar * b, CvtOp cvt_op);
SseSfpConversion_ proc
push ebp
mov ebp,esp

mov edx,[ebp+8]
mov ecx,[ebp+12]
mov eax,[ebp+16]
cmp eax,CvtOpTableCount
jae BadCvtOp
jmp [CvtOpTable + eax*4]

SseCvtsi2ss:
mov eax,[ecx]
cvtsi2ss xmm0,eax
movss real4 ptr [edx],xmm0
mov eax,1
pop ebp
ret

SseCvtss2si:
movss xmm0,real4 ptr [ecx]
cvtss2si eax,xmm0
mov [edx],eax
mov eax,1
pop ebp
ret

SseCvtsi2sd:
mov eax,[ecx]
cvtsi2sd xmm0,eax
movsd real8 ptr [edx],xmm0
mov eax,1
pop ebp
ret

SseCvtsd2si:
movsd xmm0,real8 ptr [ecx]
cvtsd2si eax,xmm0
mov [edx],eax
mov eax,1
pop ebp
ret

SseCvtss2sd:
movss xmm0,real4 ptr [ecx]
cvtss2sd xmm1,xmm0
movsd real8 ptr [edx],xmm1
mov eax,1
pop ebp
ret

SseCvtsd2ss:
movsd xmm0,real8 ptr [ecx]
cvtsd2ss xmm1,xmm0
movss real4 ptr [edx],xmm1
mov eax,1
pop ebp
ret

BadCvtOp:
xor eax,eax
pop ebp
ret

CvtOpTable dword SseCvtsi2ss, SseCvtss2si, SseCvtsi2sd, SseCvtsd2si, SseCvtss2sd, SseCvtsd2ss
CvtOpTableCount equ ($ - CvtOpTable)/ sizeof dword
SseSfpConversion_ endp

;extern "C" Uint32 SseGetMxcsr_(void);
SseGetMxcsr_ proc
push ebp
mov ebp,esp
sub esp,4

stmxcsr [ebp-4]
mov eax,[ebp-4]

mov esp,ebp
pop ebp
ret
SseGetMxcsr_ endp

;extern "C" Uint32 SseSetMxcsr_(Uint32 mxcsr);
SseSetMxcsr_ proc
push ebp
mov ebp,esp
sub esp,4

mov eax,[ebp+8]
and eax,0ffffh
mov [ebp-4],eax
ldmxcsr [ebp-4]

mov esp,ebp
pop ebp
ret
SseSetMxcsr_ endp

;extern "C" SseRm SseGetMxcsrRoundingMode_(void);
MxcsrRcMask equ 9fffh
MxcsrRcShift equ 13

SseGetMxcsrRoundingMode_ proc
push ebp
mov ebp,esp
sub esp,4

stmxcsr [ebp-4]
mov eax,[ebp-4]
shr eax,MxcsrRcShift
and eax,3

mov esp,ebp
pop ebp
ret
SseGetMxcsrRoundingMode_ endp

;extern "C" void SseSetMxcsrRoundingMode_(SseRm rm);
SseSetMxcsrRoundingMode_ proc
push ebp
mov ebp,esp
sub esp,4

mov ecx,[ebp+8]
and ecx,3
shl ecx,MxcsrRcShift

stmxcsr [ebp-4]
mov eax,[ebp-4]
and eax,MxcsrRcMask

or eax,ecx
mov [ebp-4],eax
ldmxcsr [ebp-4]

mov esp,ebp
pop ebp
ret
SseSetMxcsrRoundingMode_ endp

end