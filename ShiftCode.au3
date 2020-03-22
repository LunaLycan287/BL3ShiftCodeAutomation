#include <Array.au3>
#include <ButtonConstants.au3>
#include <File.au3>
#include <FileConstants.au3>
#include <GUIConstantsEx.au3>
#include <Misc.au3>
#include <MsgBoxConstants.au3>
#include <StaticConstants.au3>
#include <StringConstants.au3>
#include <WinAPIFiles.au3>
#include <WindowsConstants.au3>

CONST $INI_FILENAME = ".\ShiftCodes.ini"
CONST $SHIFT_LIST_FILENAME = ".\ShiftCodesList.txt"
CONST $USED_SHIFT_LIST_FILENAME = "./UsedShiftCodesList.txt"
CONST $X = 0
CONST $Y = 1
CONST $INPUT_1 = 0
CONST $INPUT_2 = 1
CONST $INPUT_3 = 2
CONST $INPUT_4 = 3
CONST $INPUT_5 = 4
CONST $SUBMIT = 5
Global $arrClickPos[6][2]


ShowStartGui()


Func ShowStartGui()
   #Region ### START Koda GUI section ### Form=F:\Entwicklung\AutoIt\koda_1.7.3.0\Forms\BL3Start.kxf
   $frmBL3Start = GUICreate("Borderlands 3 Shift Codes", 544, 123, @Desktopwidth/2, @DesktopHeight/2)
   $Label1 = GUICtrlCreateLabel("This Tool was created to quickly enter SHIFT-Codes in Borderlands 3 (since they disabled copy/paste).", 8, 8, 489, 17)
   $Label2 = GUICtrlCreateLabel("Make sure your Borderlands 3 is running and set to Display Mode:", 8, 32, 313, 17)
   $Label3 = GUICtrlCreateLabel("Windowed Borderless", 328, 32, 126, 17)
   GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
   $Label4 = GUICtrlCreateLabel("If this is your first time Using this Tool or if your Monitor Setup has changed, please run a Position Calibration first.", 8, 56, 531, 17)
   $btnPosCalibrate = GUICtrlCreateButton("&Position Calibration", 344, 88, 107, 25)
   $btnStart = GUICtrlCreateButton("&Start", 264, 88, 75, 25)
   $btnExit = GUICtrlCreateButton("&Exit", 456, 88, 75, 25)
   GUISetState(@SW_SHOW)
   #EndRegion ### END Koda GUI section ###
   While 1
	  $nMsg = GUIGetMsg()
	  Switch $nMsg
		 Case $btnStart
			GUIDelete($frmBL3Start)
			Start()
		 Case $btnPosCalibrate
			GUIDelete($frmBL3Start)
			PosCalibrate()
		 Case $btnExit,$GUI_EVENT_CLOSE
			Exit
	  EndSwitch
   WEnd
EndFunc

Func PosCalibrate()
   Local $arr[6] =  [$INPUT_1,$INPUT_2,$INPUT_3,$INPUT_4,$INPUT_5,$SUBMIT]
   Local $retCalibGui = 0;

   For $i = 0 To UBound($arr)-1
	  $retCalibGui = ShowCalibrateGui($arr[$i])
	  If $retCalibGui <> 0 Then ExitLoop
	  GetPos($arr[$i])
   Next

   If $retCalibGui == 0 Then
	  ; Save to Ini
	  For $i = 0 To UBound($arr)-1
		 IniWrite($INI_FILENAME, PositionToText($arr[$i]), AxisToText($X), $arrClickPos[$arr[$i]][$X])
		 IniWrite($INI_FILENAME, PositionToText($arr[$i]), AxisToText($Y), $arrClickPos[$arr[$i]][$Y])
	  Next
   EndIf

   ShowStartGui()
EndFunc

Func AxisToText($axis)
   Switch $axis
	  Case $X
		 $txt_axis = "X"
	  Case $Y
		 $txt_axis = "Y"
   EndSwitch
   Return $txt_axis
EndFunc

Func PositionToText($position)
   Switch $position
	  Case $INPUT_1
		 $txt_pos = "First Input"
	  Case $INPUT_2
		 $txt_pos = "Second Input"
	  Case $INPUT_3
		 $txt_pos = "Third Input"
	  Case $INPUT_4
		 $txt_pos = "Fourth Input"
	  Case $INPUT_5
		 $txt_pos = "Fifth Input"
	  Case $SUBMIT
		 $txt_pos = "Submit Button"
   EndSwitch
   Return $txt_pos
EndFunc

Func ShowCalibrateGui($position)
   #Region ### START Koda GUI section ### Form=F:\Entwicklung\AutoIt\koda_1.7.3.0\Forms\BL3CalibDialog.kxf
   $frmCalibDialog = GUICreate("Calibration", 250, 83, @Desktopwidth/2, @DesktopHeight/2)
   $btnOK = GUICtrlCreateButton("&OK", 9, 48, 75, 25)
   $btnCancel = GUICtrlCreateButton("&Cancel", 90, 48, 75, 25)
   $btnExit = GUICtrlCreateButton("&Exit", 168, 48, 75, 25)
   $Label1 = GUICtrlCreateLabel("Please click on the ", 8, 16, 97, 17)
   $lblPosType = GUICtrlCreateLabel(PositionToText($position), 112, 16, 83, 17)
   GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
   GUISetState(@SW_SHOW)
   #EndRegion ### END Koda GUI section ###

   While 1
	   $nMsg = GUIGetMsg()
	   Switch $nMsg
			Case $btnOK
			   GUIDelete($frmCalibDialog)
			   ExitLoop
			Case $btnCancel
			   GUIDelete($frmCalibDialog)
			   return -1
			Case $btnExit,$GUI_EVENT_CLOSE
			   Exit
	   EndSwitch
	WEnd
	return 0
EndFunc

Func GetPos($position)
   While 1
	  ToolTip("Click on the " & PositionToText($position))
	  If _IsPressed("01") Then ExitLoop
   WEnd
   ToolTip("")
   $arr = MouseGetPos()
   $arrClickPos[$position][$X] = $arr[$X]
   $arrClickPos[$position][$Y] = $arr[$Y]
EndFunc

Func ReadSettings()
   If (FileExists($INI_FILENAME)) Then
	  Local $arr[6] =  [$INPUT_1,$INPUT_2,$INPUT_3,$INPUT_4,$INPUT_5,$SUBMIT]
	  For $i = 0 To UBound($arr)-1
		 Local $valX = IniRead($INI_FILENAME, PositionToText($arr[$i]), AxisToText($X), -1)
		 Local $valY = IniRead($INI_FILENAME, PositionToText($arr[$i]), AxisToText($Y), -1)
		 If $valX == -1 Or $valY == -1 Then
			return -2
		 EndIf
		 $arrClickPos[$arr[$i]][$X] = $valX
		 $arrClickPos[$arr[$i]][$Y] = $valY
	  Next
	  return 0
   ElseIf
	  return -1
   EndIf
EndFunc

Func Start()
   Local $retReadSettings = ReadSettings()
   If $retReadSettings == -1 Then
	  MsgBox($MB_OK, "Error", "Settings file does not exist. Please redo the Position Calibration.")
	  ShowStartGui()
   ElseIf $retReadSettings == -2 Then
	  MsgBox($MB_OK, "Error", "Settings file is corrupted. Please redo the Position Calibration.")
	  ShowStartGui()
   Else
	  Local $arrShiftCodes
	  Local $arrShiftCodesDelPos[1] = [0]
	  If _FileReadToArray($SHIFT_LIST_FILENAME, $arrShiftCodes, $FRTA_NOCOUNT) == 1 Then

		 ;Enter the keys
		 For $i = 0 To UBound($arrShiftCodes)-1
			$retEnterKey = EnterKey($arrShiftCodes[$i]);
			If $retEnterKey == 0 Then
			   $arrShiftCodesDelPos[0] = _ArrayAdd($arrShiftCodesDelPos, $i)
			ElseIf $retEnterKey == -1 Then
			   MsgBox($MB_OK, "Error", "The SHIFT Code '"&$arrShiftCodes[$i]&"' is invalid.")
			EndIf

			If $i <> UBound($arrShiftCodes)-1 Then
			   $retNextKey = MsgBox($MB_YESNO + $MB_ICONQUESTION, "Continue?", "Enter the next SHIFT-Code?")
			   If $retNextKey == $IDNO Then
				  ExitLoop
			   EndIf
			EndIf
 		 Next

		 ;Save used codes to list and
		 If UBound($arrShiftCodesDelPos) >= 1 Then
			Local $hFileOpen = FileOpen($USED_SHIFT_LIST_FILENAME, $FO_APPEND)
			If $hFileOpen = -1 Then
			   MsgBox($MB_ICONERROR, "Error", "An error occurred whilst writing the UsedShiftKeyList.txt")
			EndIf
			For $i = 1 To UBound($arrShiftCodesDelPos)-1
			   FileWriteLine($hFileOpen, $arrShiftCodes[$arrShiftCodesDelPos[$i]])
			Next
			_ArrayDelete($arrShiftCodes, $arrShiftCodesDelPos)
			FileClose($hFileOpen)

			_FileWriteFromArray($SHIFT_LIST_FILENAME, $arrShiftCodes)
		 EndIf

		 MsgBox($MB_OK, "Info", "Done.")
		 Exit
	  ElseIf
		 MsgBox($MB_OK, "Error", "ShiftKeyList.txt does not exist.")
	  EndIf
   EndIf
EndFunc

Func EnterKey($shiftCode)
   If StringRegExp($shiftCode, "[a-zA-Z0-9]{5}\-[a-zA-Z0-9]{5}\-[a-zA-Z0-9]{5}\-[a-zA-Z0-9]{5}\-[a-zA-Z0-9]{5}") == 1 Then
	  Local $arr = StringSplit($shiftCode,'-', $STR_NOCOUNT)
	  For $i = 0 To 5
		 Local $pos
		 Switch $i
			Case 0
			   $pos = $INPUT_1
			Case 1
			   $pos = $INPUT_2
			Case 2
			   $pos = $INPUT_3
			Case 3
			   $pos = $INPUT_4
			Case 4
			   $pos = $INPUT_5
			Case 5
			   $pos = $SUBMIT
		 EndSwitch

		 MouseClick($MOUSE_CLICK_LEFT, $arrClickPos[$pos][$X], $arrClickPos[$pos][$Y])
		 If $pos <> $SUBMIT Then
			Send("{BS}{BS}{BS}{BS}{BS}") ; Delete all in front
			Send("{DEL}{DEL}{DEL}{DEL}{DEL}") ; Delete all in back
			Send($arr[$i])
		 EndIf
	  Next
   Else
	  return -1
   EndIf
   return 0
EndFunc
