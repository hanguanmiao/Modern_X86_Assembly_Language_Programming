.model flat,c

.const
DegToRad real8 0.01745329252
RadToDeg real8 57.2957795131

.code
;extern "C" void RectToPolar_(double x, double y, double* r, double* a);
RectToPolar_ proc
push ebp
mov ebp,esp

fld real8 ptr [ebp+16]
fld real8 ptr [ebp+8]
fpatan
fmul [RadToDeg]
mov eax,[ebp+28]
fstp real8 ptr [eax]

fld real8 ptr [ebp+8]
fmul st(0),st(0)
fld real8 ptr [ebp+16]
fmul st(0),st(0)
faddp 
fsqrt
mov eax,[ebp+24]
fstp real8 ptr [eax]

pop ebp
ret
RectToPolar_ endp

;extern "c" void PolarToRect_(double r, double a, double* x, double* y);
PolarToRect_ proc
push ebp
mov ebp,esp

fld real8 ptr [ebp+16]
fmul [DegToRad]
fsincos

fmul real8 ptr [ebp+8]
mov eax,[ebp+24]
fstp real8 ptr [eax]

fmul real8 ptr [ebp+8]
mov eax,[ebp+28]
fstp real8 ptr [eax]

pop ebp
ret
PolarToRect_ endp


end