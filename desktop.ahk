LAlt & 1::  ; LWin + 1
{
    Send("#^{Left}")  ; Sends Win + Ctrl + Left to switch to the previous desktop
}
return

LAlt & 2::  ; LWin + 2
{
    Send("#^{Right}")  ; Sends Win + Ctrl + Right to switch to the next desktop
}


; AutoHotkey v2 script for media controls with Ctrl + Alt

; Next song: Ctrl + Alt + Right Arrow
^!Right::Send "{Media_Next}"

; Previous song: Ctrl + Alt + Left Arrow
^!Left::Send "{Media_Prev}"

; Play/Pause: Ctrl + Alt + Shift + Space
+^!Space::Send "{Media_Play_Pause}"


CapsLock::Esc


#1::Return  ; Disables Win + 1
#2::Return  ; Disables Win + 2
#3::Return  ; Disables Win + 3
#4::Return  ; Disables Win + 4
#5::Return  ; Disables Win + 5
#6::Return  ; Disables Win + 6
#7::Return  ; Disables Win + 7
#8::Return  ; Disables Win + 8
#9::Return  ; Disables Win + 9
#0::Return  ; Disables Win + 0
