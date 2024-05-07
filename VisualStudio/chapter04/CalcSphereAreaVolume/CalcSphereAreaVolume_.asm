.model flat,c

.const
r8_4p0	real8	4.0
r8_3p0	real8	3.0

.code
;extern "C" bool CalcSphereAreaVolume_(double r, double* sa, double* v);
; error 0
; success 1
CalcSphereAreaVolume_ proc
push ebp
mov ebp,esp

xor eax,eax
fld real8 ptr [ebp+8]	;st(0)=r
fldz					;st(1)=4,st(1)=0
fcomip st(0),st(1)
fstp st(0)
jp Done			;not a NaN
ja Done			;0>r

fld real8 ptr [ebp+8]
fld st(0)				;st(0)=r,st(1)=r
fmul st(0),st(0)		;st(0)=r*r,st(1)=r
fldpi					;st(0)=pi
fmul [r8_4p0]			;st(0)=pi*r*r
fmulp

mov edx,[ebp+16]
fst real8 ptr [edx] 

fmulp
fdiv [r8_3p0]
mov edx,[ebp+20]
fstp real8 ptr [edx]

mov eax,1

Done:
pop ebp
ret
CalcSphereAreaVolume_ endp
end