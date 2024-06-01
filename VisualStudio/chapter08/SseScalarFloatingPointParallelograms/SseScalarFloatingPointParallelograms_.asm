.model flat,c

PDATA	struct
A		real8 ?
B		real8 ?
Alpha	real8 ?
Beta	real8 ?
H		real8 ?
Area	real8 ?
P		real8 ?
Q		real8 ?
BadVal	byte ?
Pad		byte 7 dup(?)
PDATA	ends

.const
public SizeofPdataX86_
r8_2p0		real8 2.0
r8_180p0	real8 180.0
r8_MinusOne real8 -1.0
SizeofPdataX86_	dword size PDATA

.code
extern sin:proc, cos:proc
extern DegToRad:real8

;extern "C" bool SseSfpParallelograms_(PDATA * pdata, int n);

; Local stack: [ebp-8] x87 FPU transfer location
; [ebp-16] Alpha in radians
;
; Requires SSE2
SseSfpParallelograms_ proc
push ebp
mov ebp,esp
sub esp,16
push ebx

; Load arguments and validate n
xor eax,eax
mov ebx,[ebp+8]
mov ecx,[ebp+12]
test ecx,ecx
jle Done

; Initialize constant values
Loop1:
movsd xmm6,real8 ptr [r8_180p0]
xorpd xmm7,xmm7
sub esp,8

; Load and validate A and B
movsd xmm0,real8 ptr [ebx+PDATA.A]
movsd xmm1,real8 ptr [ebx+PDATA.B]
comisd xmm0,xmm7
jp InvalidValue
jbe InvalidValue
comisd xmm1,xmm7
jp InvalidValue
jbe InvalidValue

; Load and validate Alpha
movsd xmm2,real8 ptr [ebx+PDATA.Alpha]
comisd xmm2,xmm7
jp InvalidValue
jbe InvalidValue
comisd xmm2,xmm6
jae InvalidValue

; Compute Beta
subsd xmm6,xmm2
movsd real8 ptr [ebx+PDATA.Beta],xmm6

; Compute sin(Alpha)
mulsd xmm2,real8 ptr [DegToRad]
movsd real8 ptr [ebp-16],xmm2
movsd real8 ptr [esp],xmm2
call sin
fstp real8 ptr [ebp-8]

; Compute parallelogram Height and Area
movsd xmm0,real8 ptr [ebx+PDATA.A]
mulsd xmm0,real8 ptr [ebp-8]
movsd real8 ptr [ebx+PDATA.H],xmm0
mulsd xmm0,real8 ptr [ebx+PDATA.B]
movsd real8 ptr [ebx+PDATA.Area],xmm0

; Compute cos(Alpha)
movsd xmm0,real8 ptr [ebp-16]
movsd real8 ptr [esp],xmm0
call cos
fstp real8 ptr [ebp-8]

; Compute 2.0 * A * B * cos(Alpha)
movsd xmm0,real8 ptr [r8_2p0]
movsd xmm1,real8 ptr [ebx+PDATA.A]
movsd xmm2,real8 ptr [ebx+PDATA.B]
mulsd xmm0,xmm1
mulsd xmm0,xmm2
mulsd xmm0,real8 ptr [ebp-8]

; Compute A * A + B * B
movsd xmm3,xmm1
movsd xmm4,xmm2
mulsd xmm3,xmm3
mulsd xmm4,xmm4
addsd xmm3,xmm4
movsd xmm4,xmm3

; Compute P and Q
subsd xmm3,xmm0
sqrtsd xmm3,xmm3
movsd real8 ptr [ebx+PDATA.P],xmm3
addsd xmm4,xmm0
sqrtsd xmm4,xmm4
movsd real8 ptr [ebx+PDATA.Q],xmm4
mov dword ptr [ebx+PDATA.BadVal],0

NextItem:
add esp,8
add ebx,size PDATA
dec ecx
jnz Loop1


Done:
pop ebx
mov esp,ebp
pop ebp
ret

InvalidValue:
movsd xmm0,real8 ptr [r8_MinusOne]
movsd real8 ptr [ebx+PDATA.Beta],xmm0
movsd real8 ptr [ebx+PDATA.H],xmm0
movsd real8 ptr [ebx+PDATA.Area],xmm0
movsd real8 ptr [ebx+PDATA.P],xmm0
movsd real8 ptr [ebx+PDATA.Q],xmm0
mov dword ptr [ebx+PDATA.BadVal],1
jmp NextItem

SseSfpParallelograms_ endp
end