#Requires AutoHotkey v2.0
#SingleInstance Force

titleNeedle   := "Expediente Digital"
checkInterval := 400  ; ms

; guarda janelas já tratadas (para não "puxar de volta")
movedWindows := Map()

SetTimer(WatchED, checkInterval)

WatchED() {
    global movedWindows, titleNeedle
    portraitMon := GetPortraitMonitor()
    if (portraitMon = 0)
        return

    ; Área útil do monitor em retrato (desconta barra de tarefas)
    MonitorGetWorkArea(portraitMon, &waLeft, &waTop, &waRight, &waBottom)

    ; remove entradas de janelas que não existem mais
    for hwnd, _ in movedWindows {
        if !WinExist("ahk_id " hwnd)
            movedWindows.Delete(hwnd)
    }

    hwndList := WinGetList(titleNeedle)
    for hwnd in hwndList {

        ; já tratada, não move novamente
        if movedWindows.Has(hwnd)
            continue

        ; ignora minimizadas
        winState := WinGetMinMax(hwnd)
        if (winState = -1)
            continue

        ; filtra por navegador
        proc := StrLower(WinGetProcessName(hwnd))
        if (proc != "chrome.exe" && proc != "msedge.exe" && proc != "firefox.exe")
            continue

        ; se já estiver no monitor retrato (aprox.), não mexe
        WinGetPos(&x, &y, &w, &h, hwnd)
        if (x >= waLeft && x <= waRight && y >= waTop && y <= waBottom)
            continue

        ; se estiver maximizada, restaura antes de mover
        if (winState = 1) {
            WinRestore(hwnd)
            Sleep(80)
        }

        ; empurra para dentro do monitor retrato e maximiza
        WinMove(waLeft, waTop, , , hwnd)
        Sleep(80)
        WinMaximize(hwnd)

        movedWindows[hwnd] := true
    }
}

GetPortraitMonitor() {
    count := MonitorGetCount()
    Loop count {
        idx := A_Index

        ; Pega coordenadas do monitor idx
        MonitorGet(idx, &left, &top, &right, &bottom)

        width  := right - left
        height := bottom - top

        if (height > width)
            return idx
    }
    return 0
}
