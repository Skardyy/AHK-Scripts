#Persistent
#NoEnv
#KeyHistory 0
SetBatchLines, -1
SetControlDelay, -1
SendMode Input
SetTitleMatchMode fast
SetTitleMatchMode 2
SetWinDelay, -1
Gui, Add, Text, x10 y10 w200 h20 vStatusLabel, NaN
Gui, Add, DropDownList, vFunctionList, AAS|VHL Atk|VHL Def
Gui, Add, Button, gRunFunction, Run Function
Gui, Add, Button, gStopScript, Stop Script
Gui, Add, Checkbox, vMyCheckbox, Return Focus?
Gui, Add, Button, gRestoreBtn, Restore
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
        GetFocused()
       
        WinActivate, ahk_exe Artix Game Launcher.exe

        ControlSend,, %key%, ahk_exe Artix Game Launcher.exe

        GuiControlGet, MyCheckbox
        if(MyCheckbox = 1)
        {
            WinActivate, %PreWin%
        }
        
        Sleep, time

        Return
    } 
}

GetFocused()
{
    Win := WinExist("A")
    if(Win != WinExist(ahk_exe Artix Game Launcher.exe)) ; checks if the game is focused
    {
        PreWin := Win
    }
    Return
}
