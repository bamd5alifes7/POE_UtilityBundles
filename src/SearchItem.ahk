﻿GetItemName(){
    Key := 
    if GetbyClipboard(){
        Key := ItemAnalysis()
    }
    else{
        Key := GetbyInput()
    }
    Sleep, 300
    return Key
}

GetbyClipboard(){
    Clipboard = 
    Send ^c
    Sleep 100
    if Clipboard =
        return False
    else
        return True
}

GetbyInput(){
    InputBox, itemName, SearchItem, What are you searching for?
    return itemName
}

ItemAnalysis(){
    i := 0
    Key := 

    Loop, parse, clipboard, `n, `r
    {
        ;MsgBox,   %A_LoopField%
        IfInString A_LoopField,-----
        {
            break
        }
        if(i==1)
        {
            Key := A_LoopField
        }
        else if(i==2)
        {
            Key := Key " " A_LoopField
        }
        i := i+1
    }

    Key := StrReplace(Key, "<<set:MS>><<set:M>><<set:S>>")
    ; MsgBox %Key%
    return Key   
}

SearchItem(url){
    ie := ComObjCreate("InternetExplorer.Application")
    ie.Visible := true  ; This is known to work incorrectly on IE7.
    ie.Navigate(url)
    Sleep 100
    
    ;判斷網頁是否載入完畢,30秒內
    Loop 300
    {
        try
        {
            aa := ie.document.getElementsbyClassName("multiselect__input")[0].placeholder
            ;MsgBox % aa
        }
        catch
        {
        }
 
        if aa contains ...,Search ; check if aa == 搜尋道具... or Search
        {
            break
        }
        Sleep, 100
    }
    Sleep 100

    ;ie.document.getElementsbyClassName("multiselect__input")[0].value := "Search key word" ;測試用
    ;Send  % getAscStr(KeyWord)
    Send ^v
    Sleep,100
    Send {ENTER}
    Sleep, 100
    ie.document.getElementsbyClassName("btn search-btn")[0].click()
    Sleep, 100
    
    ;sURL := GetActiveBrowserURL()
    ;MsgBox %sURL%
    return
}

