.model flat,c

.const
StartMinVal qword 0ffffffffffffffffh
StartMaxVal qword  0000000000000000h

.code
extern NMIN:dword

;extern "C" bool MmxCalcMinMax_(Uint8 * x, int n, Uint8 * x_min, Uint8 * x_max);
MmxCalcMinMax_ proc
push ebp
mov ebp,esp

xor eax,eax
mov ecx,[ebp+12]
cmp ecx,NMIN
jl Done
test ecx,0fh
jnz Done

shr ecx,4
mov edx,[ebp+8]
movq mm4,[StartMinVal]
movq mm6,mm4
movq mm5,[StartMaxVal]
movq mm7,mm5

@@:
movq mm0,[edx]
movq mm1,[edx+8]
pminub mm4,mm0
pminub mm6,mm1
pmaxub mm5,mm0
pmaxub mm7,mm1
add edx,16
dec ecx
jnz @B

pminub mm6,mm4
pshufw mm0,mm6,00001110b
pminub mm6,mm0
pshufw mm0,mm6,00000001b
pminub mm6,mm0
pextrw eax,mm6,0
cmp al,ah
jbe @F
mov al,ah
@@:
mov edx,[ebp+16]
mov [edx],al

pmaxub mm7,mm5
pshufw mm0,mm7,00001110b
pmaxub mm7,mm0
pshufw mm0,mm7,00000001b
pmaxub mm7,mm0
pextrw eax,mm7,0
cmp al,ah
jae @F
mov al,ah
@@:
mov edx,[ebp+20]
mov [edx],al

emms
mov eax,1

Done:
pop ebp
ret
MmxCalcMinMax_ endp
end