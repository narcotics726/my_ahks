;Put shortcut files (*.lnk) under the same folder
;Naming them as the key you want to assign
;
;The script will find the target exe and bind hot key "Win+Shift+{lnkName}" to it
;For example:
;Create a lnk of Google Chrome and name it as "q.lnk", hot key "Win+Shift+q" will be created
;
;For windows app like "Windows Terminal" which has different "ahk_exe" name and target
;Name it "t_WindowsTerminal.exe.lnk" to make sure ahk can find the correct window

DIR := A_SCRIPTDir . "\*.lnk"

CreateHotKey(key, target, window) {
    MsgBox key . ' assigned to ' . target . ' ahk: ' . window
    Handler(ThisHotKey) {
        if WinExist("ahk_exe " . window) {
            if WinActive("ahk_exe" . window) {
                Send "!{TAB}"
            } else {
                WinActivate
            }
        } else {
            Run target
        }
    }
    Hotkey '#+' . key, Handler
}

Loop Files, DIR
{
    hotK := SubStr(A_LoopFileName, 1, -4)
    FileGetShortcut A_LoopFileName, &OutTarget
    if (StrLen(hotK) == 1) {
        ahkExe := OutTarget
    } else {
        ahkExe := SubStr(hotK, 3)
        hotK := SubStr(hotK, 1, 1)
    }

    CreateHotKey(hotK, OutTarget, ahkExe)
}
