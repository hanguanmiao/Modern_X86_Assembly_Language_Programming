.model flat,c

extern GlChar:byte
extern GlShort:word
extern GlInt:dword
extern GlLongLong:qword

;extern "C" void IntegerAddition_(char a, short b, int c, long long d);

.code
IntegerAddition_ proc

push ebp
mov ebp,esp

mov al,[ebp+8]
add [GlChar],al

mov ax,[ebp+12]
add [GlShort],ax

mov eax,[ebp+16]
add [GlInt],eax

mov eax,[ebp+20]
mov ecx,[ebp+24]
add dword ptr [GlLongLong],eax
adc dword ptr [GlLongLong+4],ecx

pop ebp
ret

IntegerAddition_ endp
end