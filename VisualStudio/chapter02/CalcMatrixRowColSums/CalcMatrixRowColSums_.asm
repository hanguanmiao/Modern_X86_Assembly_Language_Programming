.model flat,c

;extern "C" int CalcMatrixRowColSums_(const int* x, int nrows, int ncols, int* row_sums, int* col_sums);
.code

CalcMatrixRowColSums_ proc
push ebp
mov ebp,esp
push ebx
push esi
push edi

; check if nrows and ncols are valid
xor eax,eax
cmp dword ptr [ebp+12],0
jle InvalidArg
mov ecx,[ebp+16]
cmp ecx,0
jle InvalidArg

;initialize elements of array col_sums to 0
mov edi,[ebp+24]
rep stosd 

xor esi,esi			;i=0
mov ebx,[ebp+8]		;ebx=x

LP1:
mov edi,[ebp+20]
mov dword ptr [edi+esi*4],0	;initilize row_sums[i] to 0

mov edx,esi
imul edx,[ebp+16]
xor edi,edi			;j=0

LP2:
mov ecx,edx
add ecx,edi
mov eax,[ebx+ecx*4]
mov ecx,[ebp+20]
add [ecx+esi*4],eax
mov ecx,[ebp+24]
add [ecx+edi*4],eax

inc edi
cmp edi,[ebp+16]
jl LP2

inc esi
cmp esi,[ebp+12]
jl LP1

mov eax,1

InvalidArg:
pop edi
pop esi
pop ebx
pop ebp
ret
CalcMatrixRowColSums_ endp

end