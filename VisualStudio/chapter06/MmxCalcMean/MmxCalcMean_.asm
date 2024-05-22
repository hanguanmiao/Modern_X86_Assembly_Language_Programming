.model flat,c

.code
extern NMIN:dword, NMAX : dword

;extern "C" bool MmxCalcMean_(const Uint8 * x, int n, Uint32 * sum_x, double* mean);
MmxCalcMean_ proc
push ebp
mov ebp, esp
sub esp, 8

xor eax, eax
mov ecx, [ebp+12]
cmp ecx, [NMIN]
jl Done
cmp ecx, [NMAX]
jg Done
test ecx, 0fh
jnz Done
shr ecx, 4

mov edx, [ebp + 8]
pxor mm4, mm4
pxor mm5, mm5
pxor mm7, mm7

@@:
movq mm0, [edx]
movq mm1,[edx+8]

movq mm2,mm0
movq mm3,mm1
punpcklbw mm0,mm7
punpcklbw mm1,mm7
punpckhbw mm2,mm7
punpckhbw mm3,mm7
paddw mm0,mm2
paddw mm1,mm3
paddw mm0,mm1

movq mm1,mm0
punpcklwd mm0,mm7
punpckhwd mm1,mm7
paddd mm4,mm0
paddd mm5,mm1

add edx,16
dec ecx
jnz @B

paddd mm5,mm4
pshufw mm6,mm5,00001110b
paddd mm6,mm5
movd eax,mm6
emms

mov dword ptr [ebp-8],eax
mov dword ptr [ebp-4],0
fild qword ptr [ebp-8] 
fild dword ptr [ebp+12]
fdivp

mov edx,[ebp+20]
fstp real8 ptr [edx] 
mov edx,[ebp+16]
mov [edx],eax
mov eax,1

Done:
mov esp,ebp
pop ebp
ret
MmxCalcMean_ endp
end