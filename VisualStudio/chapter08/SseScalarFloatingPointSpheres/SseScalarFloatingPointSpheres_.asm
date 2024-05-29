.model flat,c

.const
r8_pi real8 3.14159265358979323846
r8_four real8 4.0
r8_three real8 3.0
r8_neg_one real8 -1.0

.code
;extern "C" bool SseSfpCalcSphereAreaVolume_(double r, double* sa, double* v);
SseSfpCalcSphereAreaVolume_ proc
push ebp
mov ebp,esp

movsd xmm0,real8 ptr [ebp+8]
mov ecx,[ebp+16]
mov edx,[ebp+20]
xorpd xmm7,xmm7
comisd xmm0,xmm7
jp BadRadius
jb BadRadius

movsd xmm1,xmm0
mulsd xmm1,xmm0
mulsd xmm1,real8 ptr [r8_four]
mulsd xmm1,[r8_pi]
movsd real8 ptr [ecx],xmm1

mulsd xmm1,xmm0
divsd xmm1,real8 ptr [r8_three]
movsd real8 ptr [edx],xmm1

mov eax,1
pop ebp
ret

BadRadius:
movsd xmm0,[r8_neg_one]
movsd real8 ptr [ecx],xmm0
movsd real8 ptr [edx],xmm0
xor eax,eax
pop ebp
ret
SseSfpCalcSphereAreaVolume_ endp
end