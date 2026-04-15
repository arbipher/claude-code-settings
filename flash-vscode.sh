#!/bin/bash
# Flash the VS Code window that owns this Claude Code session.
# Identifies the window by workspace name (git root basename) via partial title match.
# Works on WSL — calls powershell.exe to invoke Win32 FlashWindow.

WORKSPACE=$(basename "$(git rev-parse --show-toplevel 2>/dev/null || pwd)")

powershell.exe -c "
Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
using System.Text;
public class WinHelper {
    public delegate bool EnumProc(IntPtr hWnd, IntPtr lParam);
    [DllImport(\"user32.dll\")] public static extern bool EnumWindows(EnumProc f, IntPtr l);
    [DllImport(\"user32.dll\")] public static extern int GetWindowText(IntPtr h, StringBuilder s, int n);
    [DllImport(\"user32.dll\")] public static extern bool IsWindowVisible(IntPtr h);
    [DllImport(\"user32.dll\")] public static extern bool FlashWindow(IntPtr h, bool b);
    public static IntPtr Find(string partial) {
        IntPtr found = IntPtr.Zero;
        EnumWindows((h, l) => {
            if (!IsWindowVisible(h)) return true;
            var sb = new StringBuilder(256);
            GetWindowText(h, sb, 256);
            if (sb.ToString().Contains(partial)) { found = h; return false; }
            return true;
        }, IntPtr.Zero);
        return found;
    }
}
'@
\$hwnd = [WinHelper]::Find('$WORKSPACE - ')
if (\$hwnd -ne [IntPtr]::Zero) { [WinHelper]::FlashWindow(\$hwnd, \$true) }
" &
