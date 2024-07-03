.model flat,c

.code
;extern "C" void SsePiAddI16_(const XmmVal* a, const XmmVal* b, XmmVal c[2]);
SsePiAddI16_ proc
push ebp
mov ebp,esp

mov eax,[ebp+8]
mov ecx,[ebp+12]
mov edx,[ebp+16]

movdqa xmm0,[eax]
movdqa xmm1,xmm0
movdqa xmm2,[ecx]

paddw xmm0,xmm2
paddsw xmm1,xmm2

movdqa [edx],xmm0
movdqa [edx+16],xmm1

pop ebp
ret
SsePiAddI16_ endp

;extern "C" void SsePiSubI32_(const XmmVal* a, const XmmVal* b, XmmVal* c);
SsePiSubI32_ proc
push ebp
mov ebp,esp

mov eax,[ebp+8]
mov ecx,[ebp+12]
mov edx,[ebp+16]

movdqa xmm0,[eax]
psubd xmm0,[ecx]
movdqu [edx],xmm0

pop ebp
ret
SsePiSubI32_ endp

;extern "C" void SsePiMul32_(const XmmVal* a, const XmmVal* b, XmmVal c[2]);
SsePiMul32_ proc
push ebp
mov ebp,esp

mov eax,[ebp+8]
mov ecx,[ebp+12]
mov edx,[ebp+16]

movdqa xmm0,[eax]
movdqa xmm1,[ecx]

movdqa xmm2,xmm0
pmulld xmm0,xmm1
pmuldq xmm2,xmm1

movdqa [edx],xmm0
movdqa [edx+16],xmm2

pop ebp
ret
SsePiMul32_ endp

end