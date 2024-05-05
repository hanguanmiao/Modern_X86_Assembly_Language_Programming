.model flat,c

.const
r8_sfFtoC	real8	0.5555555556			;5/9
r8_sfCtoF	real8	1.8						;9/5
i4_32		dword	32

.code
;extern "C" double FtoC_(double deg_f);
FtoC_ proc
push ebp
mov ebp,esp

fld [r8_sfFtoC]
fld real8 ptr [ebp+8]
fild [i4_32]

fsubp
fmulp

pop ebp
ret
FtoC_ endp

;extern "C" double CtoF_(double deg_c);
CtoF_ proc
push ebp
mov ebp,esp

fld real8 ptr [ebp+8]
fmul [r8_sfCtoF]
fiadd [i4_32]

pop ebp
ret
CtoF_ endp

end