.model flat,c

.code
;extern "C" void SsePfpConvert_(const XmmVal * a, XmmVal * b, CvtOp cvt_op);
SsePfpConvert_ proc
push ebp
mov ebp,esp

mov eax,[ebp+8]
mov ecx,[ebp+12]
mov edx,[ebp+16]
cmp edx,CvtOpTableCount
jae BadCvtOp
jmp [CvtOpTable+edx*4]

SseCvtdq2ps:
movdqa xmm0,[eax]
cvtdq2ps xmm1,xmm0
movaps [ecx],xmm1
pop ebp
ret

SseCvtdq2pd:
movdqa xmm0,[eax]
cvtdq2pd xmm1,xmm0
movapd [ecx],xmm1
pop ebp
ret

SseCvtps2dq:
movaps xmm0,[eax]
cvtps2dq xmm1,xmm0
movdqa [ecx],xmm1
pop ebp
ret

SseCvtpd2dq:
movaps xmm0,[eax]
cvtpd2dq xmm1,xmm0
movdqa [ecx],xmm1
pop ebp
ret

SseCvtps2pd:
movaps xmm0,[eax]
cvtps2pd xmm1,xmm0
movapd [ecx],xmm1
pop ebp
ret

SseCvtpd2ps:
movapd xmm0,[eax]
cvtpd2ps xmm1,xmm0
movaps [ecx],xmm1
pop ebp
ret

BadCvtOp:
pop ebp
ret

CvtOpTable dword  SseCvtdq2ps, SseCvtdq2pd, SseCvtps2dq, SseCvtpd2dq, SseCvtps2pd, SseCvtpd2ps
CvtOpTableCount equ ($-CvtOpTable)/size dword
SsePfpConvert_ endp
end