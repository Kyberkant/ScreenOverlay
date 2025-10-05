#Requires AutoHotkey v2.0

framesPath := "C:\Users\42070\OneDrive\Plocha\projecty\evernight_overlay\frames\"
frames := []

; Načtení všech PNG snímků
Loop Files framesPath . "*.png"
{
    frames.Push(A_LoopFileFullPath)
}

; Kontrola, jestli jsou nějaké snímky
if (frames.Length = 0)
{
    MsgBox("Ve složce nejsou žádné snímky!")
    ExitApp
}

; Vytvoření GUI
overlay := Gui("+AlwaysOnTop +ToolWindow -Caption +Border")
overlay.Color := "000000"
pic := overlay.Add("Picture", "w800 h600", frames[1])
overlay.Show()
overlay.Title := "GIF Overlay"

hWnd := overlay.Hwnd
WinSet("Transparent", 255, "ahk_id " hWnd)
WinSet("ExStyle", "+0x20", "ahk_id " hWnd)

currentFrame := 1
frameDelay := 100
SetTimer(NextFrame, frameDelay)

NextFrame() {
    global frames, pic, currentFrame
    currentFrame++
    if (currentFrame > frames.Length)
        currentFrame := 1
    pic.Value := frames[currentFrame]
}

; Zavření GUI přes ESC
Esc:: {
    overlay.Destroy()
    ExitApp
}
