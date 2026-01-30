#Requires AutoHotkey v2.0
#SingleInstance Force

titleNeedle   := "Expediente Digital"
checkInterval := 400  ; ms

SetTimer(WatchED, checkInterval)

WatchED() {
    portraitMon := GetPortraitMonitor()
    if (portraitMon = 0)
        return

    ; Área útil do monitor em retrato (desconta barra de tarefas)
    MonitorGetWorkArea(portraitMon, &waLeft, &waTop, &waRight, &waBottom)

    hwndList := WinGetList(titleNeedle)
    for hwnd in hwndList {

        ; ignora minimizadas
        if (WinGetMinMax(hwnd) = -1)
            continue

        ; filtra por navegador
        proc := StrLower(WinGetProcessName(hwnd))
        if (proc != "chrome.exe" && proc != "msedge.exe" && proc != "firefox.exe")
            continue

        ; se já estiver no monitor retrato (aprox.), não mexe
        WinGetPos(&x, &y, &w, &h, hwnd)
        if (x >= waLeft && x <= waRight && y >= waTop && y <= waBottom)
            continue

        ; empurra para dentro do monitor retrato e maximiza
        WinMove(waLeft, waTop, 800, 600, hwnd)
        WinMaximize(hwnd)
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
