.model flat,c

.const
public LsEpsilon_
LsEpsilon_ real8 1.0e-12

.code
;extern "C" bool CalcLeastSquares_(const double* x, const double* y, int n, double* m, double* b);
CalcLeastSquares_ proc
push ebp
mov ebp,esp
sub esp,8

xor eax,eax
mov ecx,[ebp+16]
test ecx,ecx
jle Done
mov eax,[ebp+8]		;eax=x
mov edx,[ebp+12]	;edx=y

fldz
fldz
fldz
fldz
;stack sum_x,sum_y,sum_xy,sum_xx

@@:
fld real8 ptr [eax]
fld st(0)
fld st(0)
fld real8 ptr [edx]
;stack y,x,x,x,sum_x,sum_y,sum_xy,sum_xx

fadd st(5),st(0)	;sum_y += y
fmulp
;stack xy,x,x,sum_x,sum_y,sum_xy,sum_xx

faddp st(5),st(0)	;sum_xy += xy
;stack x,x,sum_x,sum_y,sum_xy,sum_xx

fadd st(2),st(0)	;sum_x += x
fmulp
;stack xx,sum_x,sum_y,sum_xy,sum_xx

faddp st(4),st(0)	;sum_xx += xx
;stack sum_x,sum_y,sum_xy,sum_xx

add eax,8
add edx,8
dec ecx
jnz @B

;caculate denominator = n * sum_xx - sum_x * sum_x
fild dword ptr [ebp+16]
fmul st(0),st(4)
;stack n * sum_xx,sum_x,sum_y,sum_xy,sum_xx

fld st(1)
fld st(0)
;stack sum_x,sum_x,n * sum_xx,sum_x,sum_y,sum_xy,sum_xx

fmulp
fsubp
fst real8 ptr [ebp-8]
;stack denominator,sum_x,sum_y,sum_xy,sum_xx

fabs
fld [LsEpsilon_]
fcomip st(0),st(1)
fstp st(0)
jae InvalidParam
;stack sum_x,sum_y,sum_xy,sum_xx

;slope = (n * sum_xy - sum_x * sum_y)/denom
fild dword ptr [ebp+16]
;stack n,sum_x,sum_y,sum_xy,sum_xx

fmul st(0),st(3)
fld st(2)
fld st(2)
fmulp
fsubp
fdiv real8 ptr [ebp-8]
mov eax,[ebp+20]
fstp real8 ptr [eax]
;stack sum_x,sum_y,sum_xy,sum_xx

;intercept = (sum_xx * sum_y - sum_x * sum_xy)/denom
fxch st(3)
;stack sum_xx,sum_y,sum_xy,sum_x

fmulp
fxch st(2)
;stack sum_x,sum_xy,sum_xx * sum_y

fmulp
fsubp
;stack sum_xx * sum_y - sum_x * sum_xy

fdiv real8 ptr [ebp-8]
mov eax,[ebp+24]
fstp real8 ptr [eax]
mov eax,1

Done:
mov esp,ebp
pop ebp
ret

InvalidParam:
fstp st(0)
fstp st(0)
fstp st(0)
fstp st(0)
xor eax,eax
mov esp,ebp
pop ebp
ret


CalcLeastSquares_ endp
end