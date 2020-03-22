# Borderlands 3 SHiFT Code Automation
This Script was created to Quickly enter Multiple SHiFT Codes into Borderlands 3 (Might work with Borderlands 2 & TPS not tested).
It was specifically created because this time they don't allow us to copy/paste the whole SHiFT Code and we have to type it.

## How To Use
### Creating / Updating the List of SHiFT Codes
SHiFT Codes are stored in a file named "**ShiftCodesList.txt**" in the same folder as the .exe  
Every line in this file is a new SHiFT Code.   
Example:
```
ZFKJ3-TT3BB-JTBJT-T3JJT-JWX9H
HXKBT-XJ6FR-WBRKJ-J3TTB-RSBHR
ZFKJ3-TT6FF-KTFKT-T3JJT-JWX36
```
An Example file with some SHiFT Codes, that don't expire, has also been provided in the Repository. 

### Prerequisites for Script
You have to start Borderlands 3 and have it running while the working with the Script 

Make sure that Borderlands 3 is in Display Mode **Windowed Borderless**  
Go to **Options**->**Visuals** and it should be the first entry

### Calibration
When using the Script for the first time or if you changed anything with your Monitor setup you have to do a Calibration so the Script knows where to click.

Start the Script and click on **Position Calibration**
For every time you have to click a Message Box is shown telling you what to click and allowing you to abort and keep your old values.

### Entering SHiFT Codes
Make Sure that no other Windows are in front of the Borderlands 3 Window.  
To start entering the SHiFT Codes click on **Start** in the main dialog.  
**DO NOT** touch the mouse / keyboard / controller while it's entering Codes. You can only use them while a Message Box is present to click the buttons.

## FAQ
**Q: What is file X for?**  
**A:** ShiftCodesList.txt - List of the SHiFT Codes to apply when running the Script
   ShiftCodes.ini - Contains Settings for the Script. You don't have to touch it manually.  
   UsedShiftCodesList.txt - Contains all the SHiFT Codes that have already been applied. This is just a log and not cross referenced when loading the SHiFT Codes

**Q: Why do I have to click a Message Box after each code?**  
**A:** In other Borderlands versions you had a timeout after entering a wrong / used SHiFT Code. In case they also implemented it in this game you first have to confirm that you are able to continue. Also you can use the time when the Message Box is open to do something else (like answer a chat message) and it allows you to abort if there was some error in between.  
I might in the future add a Checkbox to toggle to disable this behavior

**Q: Why in AutoIt?**  
**A:** This started as a small Script for me but expanded rapidly when I thought about sharing it with my friends and you strangers on the internet. Since I already had most of it in AutoIt I didn't change to a different language. Sadly this means it is only compatible with Windows.
