#Persistent
#NoEnv
#KeyHistory 0
SetBatchLines, -1
SetControlDelay, -1
SendMode Input
SetTitleMatchMode fast
SetTitleMatchMode 2
SetWinDelay, -1
CoordMode, Mouse, Window
Gui, Color, 0A0C10, FFFFFF
Gui, Font, s12 cADBAC7 Bold
Gui, Add, Text, x10 y10 w200 h20 center vStatusLabel, NaN
Gui, Add, DropDownList,w200 Center vFunctionList, LR|VHL|CAV
Gui, Add, Button,w200 Center gRunFunction, Run Function
Gui, Add, Button,w200 Center gStopScript, Stop Script
Gui, Add, Button,w200 Center gRestoreBtn, Restore
Gui, +AlwaysOnTop
Gui, Show

Return

GuiClose:
    Exitapp
    Return

global Running := True
global PreWin := a

CAV()
{
    if(SendSleep(4, 1500) = False)
        Return 
    Loop
    { ;17.5 sec circle, 3 sec 2, 7.5 sec 3, 3 sec 4
        if(SendSleep(5, 800) = False)
            Return 
        if(SendSleep(1, 1000) = False)
            Return
        if(SendSleep(2, 800) = False)
            Return
        if(SendSleep(1, 1000) = False)
            Return
        if(SendSleep(4, 800) = False)
            Return
        if(SendSleep(1, 1000) = False)
            Return
        if(SendSleep(2, 800) = False)
            Return
        if(SendSleep(1, 1000) = False)
            Return
        if(SendSleep(3, 800) = False)
            Return
        if(SendSleep(1, 1000) = False)
            Return
        if(SendSleep(2, 800) = False)
            Return
        if(SendSleep(1, 1000) = False)
            Return
        if(SendSleep(4, 800) = False)
            Return
        if(SendSleep(1, 1000) = False)
            Return
        if(SendSleep(2, 800) = False)
            Return
        if(SendSleep(1, 1000) = False)
            Return
        if(SendSleep(4, 800) = False)
            Return
        if(SendSleep(1, 1000) = False)
            Return
        if(SendSleep(2, 800) = False)
            Return
        if(SendSleep(1, 1000) = False)
            Return
    }
}
LR()
{
    if(SendSleep(4, 2000) = False)
        Return  
    Loop
    {
        if(SendSleep(2, 1200) = False)
            Return    
        if(SendSleep(3, 1200) = False)
            Return  
        if(SendSleep(4, 1200) = False)
            Return  
        if(SendSleep(5, 1200) = False)
            Return  
        if(SendSleep(2, 1200) = False)
            Return  
        if(SendSleep(3, 1200) = False)
            Return 
        if(SendSleep(4, 1200) = False)
            Return  
    }
    Return
}
VHL()
{ ;7.5 sec cicle, 2 sec cd for 2, 2.5 cd for 3, 0.8 sec normal cd
    Loop
    {
        if(SendSleep(2, 1000) = False)
            Return
        if(SendSleep(5, 1050) = False)
            Return    
        if(SendSleep(2, 800) = False)
            Return 
        if(SendSleep(3, 1250) = False)
            Return 
        if(SendSleep(2, 2050) = False)
            Return    
        if(SendSleep(2, 800) = False)
            Return
        if(SendSleep(3, 1250) = False)
            Return 
    } 
    Return
}

RunFunction()
{   
    Running = True

    GuiControlGet, FunctionList
    GuiControl,, StatusLabel, {%FunctionList%} Script is running...

    If(FunctionList = "LR")
        LR()    
    Else If(FunctionList = "VHL")
        VHL()
    Else if(FunctionList = "CAV")
        CAV()
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
