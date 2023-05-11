; for the quest window
{    
    global HBar, VBar, InputXY, Input1, Input2, Input3, Input4
    QuestWindow()
    {
        Gui Main: New, HWNDhwnd LabelSecondGui AlwaysOnTop, Quest Auto Complete
        Win.Main := hwnd
        {                  
            Gui, Color, 0A0C10, FFFFFF
            Gui, Font, cADBAC7 bold
            Gui, Add, Text, y4 x10 w26 h26 Border gCrossHair ReadOnly HWNDh8 Border
            Gui, Add, Text, x13 y17 w19 h1 Border vHBar
            Gui, Add, Text, x22 y8 w1 h19 Border vVBar
            Gui, Add, Edit, vInputXY x+30
            Gui, Add, Text, x200 y10, Quest
            Gui, Add, Edit, vInput1 x250 y10
            Gui, Add, Text, x200 y50, Accept
            Gui, Add, Edit, vInput2 x250 y50
            Gui, Add, Text, x380 y10, Start
            Gui, Add, Edit, vInput3 x410 y10
            Gui, Add, Text, x380 y50, End
            Gui, Add, Edit, vInput4 x410 y50       
            Gui, Add, Button, y45 x62 w100 h30 default gButtonConfirm, Confirm 
        }
        Gui, show
        Return
    }
    SecondGuiGuiClose()
    {
        Gui, Destroy
        Return
    }

    ButtonConfirm()
    {


        Gui, Destroy
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
            GameWindowID := WinExist("ahk_exe Artix Game Launcher.exe")
            MouseGetPos, xpos, ypos,,, ahk_id %GameWindowID%
            GuiControl,, InputXY, X:%xpos% | y:%ypos%
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
