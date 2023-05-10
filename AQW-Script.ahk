﻿#Persistent
#NoEnv
#KeyHistory 0
SetBatchLines, -1
SetControlDelay, -1
SendMode Input
SetTitleMatchMode fast
SetTitleMatchMode 2
SetWinDelay, -1
Gui, Color, 0A0C10, FFFFFF
Gui, Font, s12 cADBAC7 Bold
Gui, Add, Text, x10 y10 w200 h20 center vStatusLabel, NaN
Gui, Add, DropDownList,w200 Center vFunctionList, AAS|VHL Atk|VHL Def
Gui, Add, Button,w200 Center gRunFunction, Run Function
Gui, Add, Button,w200 Center gStopScript, Stop Script
Gui, Add, Button,w200 Center gRestoreBtn, Restore
Gui, Add, Button,w200 Center gQuestWindow, Quests
Gui, +AlwaysOnTop
Gui, Show

Return

GuiClose:
    Exitapp
    Return

global Running := True
global PreWin := a

AAS()
{
    Loop
    {
        if(SendSleep(1, 500) = False)
            Return    
        if(SendSleep(3, 1500) = False)
            Return  
        if(SendSleep(4, 500) = False)
            Return  
        if(SendSleep(1, 1000) = False)
            Return  
        if(SendSleep(3, 500) = False)
            Return  
        if(SendSleep(1, 1500) = False)
            Return 
        if(SendSleep(3, 500) = False)
            Return  
    }
    Return
}

VHL_OFF()
{
    Loop
    {
        if(SendSleep(4, 2000) = False)
            Return  
        if(SendSleep(3, 1000) = False)
            Return 
        if(SendSleep(5, 2000) = False)
            Return    
        if(SendSleep(3, 1000) = False)
            Return 
        if(SendSleep(4, 2000) = False)
            Return  
        if(SendSleep(3, 1000) = False)
            Return 
    }
    Return
}

VHL_DEF()
{
    Loop
    {
        if(SendSleep(2, 2000) = False)
            Return  
        if(SendSleep(3, 1000) = False)
            Return 
        if(SendSleep(5, 2000) = False)
            Return    
        if(SendSleep(3, 1000) = False)
            Return 
        if(SendSleep(2, 2000) = False)
            Return  
        if(SendSleep(3, 1000) = False)
            Return 
    } 
    Return
}

RunFunction()
{   
    Running = True

    GuiControlGet, FunctionList
    GuiControl,, StatusLabel, {%FunctionList%} Script is running...

    If(FunctionList = "AAS")
        AAS()    
    Else If(FunctionList = "VHL Atk")
        VHL_OFF()      
    Else If(FunctionList = "VHL Def")    
        VHL_DEF()  
    Return
}

RestoreBtn()
{
    Reload
}

StopScript()
{
    Running := False
    GuiControl,, StatusLabel, NaN
    Return
}

SendSleep(key, time)
{
    if(Running = False)
    {
        Return false
    }
    Else
    {
        ControlFocus, Chrome Legacy Window, ahk_exe Artix Game Launcher.exe
        ControlSend, Chrome Legacy Window, %key%, ahk_exe Artix Game Launcher.exe

        GuiControlGet, MyCheckbox
        
        Sleep, time

        Return
    } 
}

; for the quest window
{    

    QuestWindow()
    {
        Gui Main: New, HWNDhwnd LabelGui AlwaysOnTop, Quest Auto Complete
        Win.Main := hwnd
        {
            Gui, Add, Text, y3 w26 h26 Border gCrossHair ReadOnly HWNDh8 Border
            Gui, Add, Text, x13 y17 w19 h1 Border vHBar
            Gui, Add, Text, x22 y8 w1 h19 Border vVBar
        }
        Gui, show
        Return
    }

    ~Lbutton Up::
    {
        Hotkey, ~LButton Up, Off
        Gui Main: Default
        if Not CH {
            GuiControl, Show, HBar
            GuiControl, Show, VBar
            CrossHair(CH:=true)
        }
        Sleep, -1
        return
    }
    CrossHair:
    {
        if (A_GuiEvent = "Normal") {
            Hotkey, ~LButton Up, On
            {
                GuiControl, Hide, HBar
                GuiControl, Hide, VBar
                CrossHair(CH:=false)
            }
        }
        return
    }
    OnExitCleanup:
    {
        CrossHair(true)
    }
    CrossHair(OnOff=1) {
        static AndMask, XorMask, $, h_cursor, IDC_CROSS := 32515
        ,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13
        , b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13
        , h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13
        if (OnOff = "Init" or OnOff = "I" or $ = "") {
            $ := "h"
            , VarSetCapacity( h_cursor,4444, 1 )
            , VarSetCapacity( AndMask, 32*4, 0xFF )
            , VarSetCapacity( XorMask, 32*4, 0 )
            , system_cursors := "32512,32513,32514,32515,32516,32642,32643,32644,32645,32646,32648,32649,32650"
            StringSplit c, system_cursors, `,
            Loop, %c0%
                h_cursor   := DllCall( "LoadCursor", "uint",0, "uint",c%A_Index% )
                , h%A_Index% := DllCall( "CopyImage",  "uint",h_cursor, "uint",2, "int",0, "int",0, "uint",0 )
                , b%A_Index% := DllCall("LoadCursor", "Uint", "", "Int", IDC_CROSS, "Uint")
        }
        $ := (OnOff = 0 || OnOff = "Off" || $ = "h" && (OnOff < 0 || OnOff = "Toggle" || OnOff = "T")) ? "b" : "h"
        Loop, %c0%
            h_cursor := DllCall( "CopyImage", "uint",%$%%A_Index%, "uint",2, "int",0, "int",0, "uint",0 )
            , DllCall( "SetSystemCursor", "uint",h_cursor, "uint",c%A_Index% )
    }
}

