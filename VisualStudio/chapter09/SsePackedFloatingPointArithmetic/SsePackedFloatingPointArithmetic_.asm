.model flat,c

.const
Pfp32Abs dword 7fffffffh,7fffffffh,7fffffffh,7fffffffh
Pfp64Abs qword 7fffffffffffffffh,7fffffffffffffffh

.code
;extern "C" void SsePackedFpMath32_(const XmmVal * a, const XmmVal * b, XmmVal c[8]);
SsePackedFpMath32_ proc
push ebp
mov ebp,esp

mov eax,[ebp+8]
mov ecx,[ebp+12]
mov edx,[ebp+16]
movaps xmm0,[eax]
movaps xmm1,[ecx]

movaps xmm2,xmm0
addps xmm2,xmm1
movaps [edx],xmm2

movaps xmm2,xmm0
subps xmm2,xmm1
movaps [edx+16],xmm2

movaps xmm2,xmm0
mulps xmm2,xmm1
movaps [edx+32],xmm2

movaps xmm2,xmm0
divps xmm2,xmm1
movaps [edx+48],xmm2

movaps xmm2,xmm0
andps xmm2,xmmword ptr [Pfp32Abs]
movaps [edx+64],xmm2

sqrtps xmm2,xmm0
movaps [edx+80],xmm2

movaps xmm2,xmm0
minps xmm2,xmm1
movaps [edx+96],xmm2

maxps xmm0,xmm1
movaps [edx+112],xmm0

pop ebp
ret
SsePackedFpMath32_ endp

;extern "C" void SsePackedFpMath64_(const XmmVal * a, const XmmVal * b, XmmVal c[8]);
SsePackedFpMath64_ proc
push ebp
mov ebp,esp

mov eax,[ebp+8]
mov ecx,[ebp+12]
mov edx,[ebp+16]
movapd xmm0,[eax]
movapd xmm1,[ecx]

movapd xmm2,xmm0
addpd xmm2,xmm1
movapd [edx],xmm2

movapd xmm2,xmm0
subpd xmm2,xmm1
movapd [edx+16],xmm2

movapd xmm2,xmm0
mulpd xmm2,xmm1
movapd [edx+32],xmm2

movapd xmm2,xmm0
divpd xmm2,xmm1
movapd [edx+48],xmm2

movapd xmm2,xmm0
andpd xmm2,xmmword ptr [Pfp64Abs]
movapd [edx+64],xmm2

sqrtpd xmm2,xmm0
movapd [edx+80],xmm2

movapd xmm2,xmm0
minpd xmm2,xmm1
movapd [edx+96],xmm2

maxpd xmm0,xmm1
movapd [edx+112],xmm0

pop ebp
ret
SsePackedFpMath64_ endp
end