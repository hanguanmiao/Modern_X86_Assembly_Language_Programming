.model flat,c

.code
;extern "C" void SseSfpCompareFloat_(float a, float b, bool* results);
SseSfpCompareFloat_ proc
push ebp
mov ebp,esp

movss xmm0,real4 ptr [ebp+8]
movss xmm1,real4 ptr [ebp+12]
mov edx,[ebp+16]

comiss xmm0,xmm1
setp byte ptr [eax]
jnp @F
xor al,al
mov byte ptr [edx+1],al
mov byte ptr [edx+2],al
mov byte ptr [edx+3],al
mov byte ptr [edx+4],al
mov byte ptr [edx+5],al
mov byte ptr [edx+6],al
jmp Done

@@:
setb byte ptr [edx+1]
setbe byte ptr [edx+2]
sete byte ptr [edx+3]
setne byte ptr [edx+4]
seta byte ptr [edx+5]
setae byte ptr [edx+6]

Done:
pop ebp
ret
SseSfpCompareFloat_ endp

;extern "C" void SseSfpCompareDouble_(double a, double b, bool* results);
SseSfpCompareDouble_ proc
push ebp
mov ebp,esp

movsd xmm0,real8 ptr [ebp+8]
movsd xmm1,real8 ptr [ebp+16]
mov edx,[ebp+24]

comisd xmm0,xmm1
setp byte ptr [eax]
jnp @F
xor al,al
mov byte ptr  [edx+1],al
mov byte ptr  [edx+2],al
mov byte ptr  [edx+3],al
mov byte ptr  [edx+4],al
mov byte ptr  [edx+5],al
mov byte ptr  [edx+6],al
jmp Done

@@:
setb byte ptr [edx+1]
setbe byte ptr [edx+2]
sete byte ptr [edx+3]
setne byte ptr [edx+4]
seta byte ptr [edx+5]
setae byte ptr [edx+6]

Done:
pop ebp
ret
SseSfpCompareDouble_ endp

end