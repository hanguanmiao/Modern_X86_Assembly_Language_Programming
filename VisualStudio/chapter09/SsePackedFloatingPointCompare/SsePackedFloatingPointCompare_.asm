.model flat,c

.code
;extern "C" void SsePfpCompareFloat_(const XmmVal * a, const XmmVal * b, XmmVal c[8]);
SsePfpCompareFloat_ proc
push ebp
mov ebp,esp

mov eax,[ebp+8]
mov ecx,[ebp+12]
mov edx,[ebp+16]
movaps xmm0,[eax]
movaps xmm1,[ecx]

; Perform packed EQUAL compare
movaps xmm2,xmm0
cmpeqps xmm2,xmm1
movdqa [edx],xmm2

; Perform packed LESS THAN compare
movaps xmm2,xmm0
cmpltps xmm2,xmm1
movdqa [edx+16],xmm2

; Perform packed LESS THAN OR EQUAL compare
movaps xmm2,xmm0
cmpleps xmm2,xmm1
movdqa [edx+32],xmm2

; Perform packed UNORDERED compare
movaps xmm2,xmm0
cmpunordps xmm2,xmm1
movdqa [edx+48],xmm2

; Perform packed NOT EQUAL compare
movaps xmm2,xmm0
cmpneqps xmm2,xmm1
movdqa [edx+64],xmm2

; Perform packed NOT LESS THAN compare
movaps xmm2,xmm0
cmpnltps xmm2,xmm1
movdqa [edx+80],xmm2

; Perform packed NOT LESS THAN OR EQUAL compare
movaps xmm2,xmm0
cmpnleps xmm2,xmm1
movdqa [edx+96],xmm2

; Perform packed ORDERED compare
movaps xmm2,xmm0
cmpordps xmm2,xmm1
movdqa [edx+112],xmm2

pop ebp
ret
SsePfpCompareFloat_ endp

end