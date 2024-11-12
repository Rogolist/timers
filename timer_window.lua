
checkButton = require('timers/util/check_button')
popupFuncs = require('timers/util/popup_menu')

--popupMenu = popupFuncs.SetViewOfPopupMenuFrame("ClockSettingsMenu", "UIParent")
tooltip = api.Interface:CreateEmptyWindow("Tooltip", "UIParent")
popupFuncs.CreateTooltipDrawable(tooltip)
tooltip:Show(false)
infoLabel = tooltip:CreateChildWidget("label", "infoLabel", 0, true)
infoLabel:AddAnchor("CENTER", tooltip, 0, 0)
infoLabel:SetAutoResize(true)
infoLabel:SetText("Info")
infoLabel:SetHeight(FONT_SIZE.LARGE)
infoLabel.style:SetFontSize(FONT_SIZE.LARGE)
infoLabel.style:SetAlign(3)
ApplyTextColor(infoLabel, FONT_COLOR.WHITE)



function ShowToolTip(text, parent)
    if text == nil then
        return
    end

    infoLabel:SetText(text)
    local x = infoLabel:GetWidth() + 10
    tooltip:SetExtent(x + 10, 34)
    tooltip:RemoveAllAnchors()
    if parent.PosX > 1600 then
        tooltip:AddAnchor("TOPLEFT", parent, -x - 10, 0)
    else
        tooltip:AddAnchor("TOPRIGHT", parent, x + 10, 0)
    end

    
    tooltip:Show(true)
end

function HideTooltip()
    tooltip:Show(false)
end

local cntr = 0
local WindowFuncs = {}
local ROWPADDING = 12
BSCBTN = {
    path = "ui/common/default.dds",
    fontColor = {
        normal = {
            0.407843,
            0.266667,
            0.0705882,
            1,
        },
        pushed = {
            0.407843,
            0.266667,
            0.0705882,
            1,
        },
        highlight = {
            0.603922,
            0.376471,
            0.0627451,
            1,
        },
        disabled = {
            0.360784,
            0.360784,
            0.360784,
            1,
        },
    },
    coords = {
        normal = {
            727,
            247,
            60,
            25,
        },
        disable = {
            788,
            273,
            60,
            25,
        },
        over = {
            727,
            273,
            60,
            25,
        },
        click = {
            788,
            247,
            60,
            25,
        },
    },
    fontInset = {
        top = 0,
        right = 11,
        left = 11,
        bottom = 0,
    },
    width = 30,
    height = 24,
    autoResize = true,
    drawableType = "ninePart",
    coordsKey = "btn",
}

Settings = api.Interface:CreateWindow("alertItemWnd", "Timer Settings", 300, 300)
Settings:SetTitle("Settings")
Settings:AddAnchor("CENTER", "UIParent", 0, 0)
Settings:SetCloseOnEscape(true)


settingsTitleLabel = Settings:CreateChildWidget("label", "titleLabel", 0, true)
settingsTitleLabel:AddAnchor("TOPLEFT", Settings, 15, 47)
settingsTitleLabel:SetText("Title:")
settingsTitleLabel:SetHeight(FONT_SIZE.LARGE)
settingsTitleLabel.style:SetFontSize(FONT_SIZE.LARGE)
settingsTitleLabel.style:SetAlign(3)
ApplyTextColor(settingsTitleLabel, FONT_COLOR.DEFAULT)

local titleEditbox = W_CTRL.CreateEdit("titleEditbox", Settings)
titleEditbox:AddAnchor("TOPLEFT", Settings, 100, 45)
titleEditbox:SetExtent(170, 24)
titleEditbox:SetMaxTextLength(15)

Settings.titleEditbox = titleEditbox

local okButton = Settings:CreateChildWidget("button", "okButton", 0, false)
okButton:SetText("Confirm")
okButton:AddAnchor("BOTTOM", Settings, -45, -10)
ApplyButtonSkin(okButton, BUTTON_BASIC.DEFAULT)

Settings.okButton = okButton

local cancelButton = Settings:CreateChildWidget("button", "okButton", 0, false)
cancelButton:SetText("Cancel")
cancelButton:AddAnchor("BOTTOM", Settings, 45, -10)
ApplyButtonSkin(cancelButton, BUTTON_BASIC.DEFAULT)

Settings.cancelButton = cancelButton

settingsCountdownLabel = Settings:CreateChildWidget("label", "settingsCountdownLabel", 0, true)
settingsCountdownLabel:AddAnchor("TOPLEFT", Settings, 15, 47 + FONT_SIZE.LARGE + ROWPADDING)
settingsCountdownLabel:SetText("Timer:")
settingsCountdownLabel:SetHeight(FONT_SIZE.LARGE)
settingsCountdownLabel.style:SetFontSize(FONT_SIZE.LARGE)
settingsCountdownLabel.style:SetAlign(3)
ApplyTextColor(settingsCountdownLabel, FONT_COLOR.DEFAULT)

Settings.settingsCountdownLabel = settingsCountdownLabel

Settings.timerCheckButton = checkButton.CreateCheckButton("timerCheckButton", Settings, nil)
Settings.timerCheckButton:AddAnchor("TOPLEFT", Settings, 100, 47 + FONT_SIZE.LARGE + ROWPADDING)
Settings.timerCheckButton:SetButtonStyle("default")
Settings.timerCheckButton:Show(true)




settingsTimerDurationLabel = Settings:CreateChildWidget("label", "settingsTimerDurationLabel", 0, true)
settingsTimerDurationLabel:AddAnchor("TOPLEFT", Settings, 15, 47 + (FONT_SIZE.LARGE * 2) + (ROWPADDING * 2))
settingsTimerDurationLabel:SetText("Time:")
settingsTimerDurationLabel:SetHeight(FONT_SIZE.LARGE)
settingsTimerDurationLabel.style:SetFontSize(FONT_SIZE.LARGE)
settingsTimerDurationLabel.style:SetAlign(3)
ApplyTextColor(settingsTimerDurationLabel, FONT_COLOR.DEFAULT)
settingsTimerDurationLabel:Show(false)

settingsTimerDurationLabelInstruction = Settings:CreateChildWidget("label", "settingsTimerDurationLabelInstruction", 0, true)
settingsTimerDurationLabelInstruction:AddAnchor("TOPLEFT", Settings, 100, 47 + (FONT_SIZE.LARGE * 3) + (ROWPADDING * 3))
settingsTimerDurationLabelInstruction:SetText(" HH:MM:SS")
settingsTimerDurationLabelInstruction:SetHeight(FONT_SIZE.LARGE)
settingsTimerDurationLabelInstruction.style:SetFontSize(FONT_SIZE.LARGE)
settingsTimerDurationLabelInstruction.style:SetAlign(3)
ApplyTextColor(settingsTimerDurationLabelInstruction, FONT_COLOR.DEFAULT)
settingsTimerDurationLabelInstruction:Show(false)

local hoursEditbox = W_CTRL.CreateEdit("hoursEditbox", Settings)
hoursEditbox:AddAnchor("TOPLEFT", Settings, 100, 47 + (FONT_SIZE.LARGE * 2) + (ROWPADDING * 2))
hoursEditbox:SetExtent(28, 24)
hoursEditbox:SetMaxTextLength(2)
hoursEditbox:SetDigit(true)
hoursEditbox:Show(false)

Settings.hoursEditbox = hoursEditbox

local minutesEditbox = W_CTRL.CreateEdit("minutesEditbox", Settings)
minutesEditbox:AddAnchor("TOPLEFT", Settings, 100 + 30, 47 + (FONT_SIZE.LARGE * 2) + (ROWPADDING * 2))
minutesEditbox:SetExtent(28, 24)
minutesEditbox:SetMaxTextLength(2)
minutesEditbox:SetDigit(true)
minutesEditbox:Show(false)

Settings.minutesEditbox = minutesEditbox

local secondsEditbox = W_CTRL.CreateEdit("secondsEditbox", Settings)
secondsEditbox:AddAnchor("TOPLEFT", Settings, 100 + 60, 47 + (FONT_SIZE.LARGE * 2) + (ROWPADDING * 2))
secondsEditbox:SetExtent(28, 24)
secondsEditbox:SetMaxTextLength(2)
secondsEditbox:SetDigit(true)
secondsEditbox:Show(false)

Settings.secondsEditbox = secondsEditbox



function OnCheckChanged()
    local checked = Settings.timerCheckButton:GetChecked()
    settingsTimerDurationLabel:Show(checked)
    settingsTimerDurationLabelInstruction:Show(checked)
    hoursEditbox:Show(checked)
    minutesEditbox:Show(checked)
    secondsEditbox:Show(checked)
end

Settings.timerCheckButton:SetHandler("OnCheckChanged", OnCheckChanged)

Settings.TimerWindow = nil
function OpenSettingsInternal(window)
    Settings.TimerWindow = window
    WindowFuncs.Settings:Show(true)
    if window.TitleText ~= nil then
        titleEditbox:SetText(window.TitleText)
    else
        titleEditbox:SetText("")
    end
    Settings.timerCheckButton:SetChecked(window.IsTimer)
    local runningTime = window.TimerDuration
    
    local runningSeconds = runningTime / 1000
    local runningMinutes = runningSeconds / 60
    local runningHours = runningMinutes / 60
    runningSeconds = math.floor(runningSeconds % 60)
    runningMinutes = math.floor(runningMinutes % 60)
    runningHours = math.floor(runningHours % 24)
    hoursEditbox:SetText(tostring(runningHours))
    minutesEditbox:SetText(tostring(runningMinutes))
    secondsEditbox:SetText(tostring(runningSeconds))
end
function OpenSettings(window)
    local result, error pcall(OpenSettingsInternal, window)
    if not result then
        api.Log:Err(error)
    end
end
function OnConfirmInternal()
    local titleStr = titleEditbox:GetText()
    local timer = Settings.timerCheckButton:GetChecked()
    timeduration = nil
    if timer then
        local hours = hoursEditbox:GetText()

        
        hours = tonumber(hours)
        if hours == nil then  
            hours = 0
        end

        
        local minutes = minutesEditbox:GetText()
        minutes = tonumber(minutes)
        if minutes == nil then
            minutes = 0
        end
        minutes = minutes + (hours * 60)


        local seconds = secondsEditbox:GetText()
        seconds = tonumber(seconds)
        if seconds == nil then
            seconds = 0
        end
        seconds = seconds + (minutes * 60)

        timeduration = seconds * 1000
    end
    Settings.TimerWindow:UpdateSettings(titleStr, timer, timeduration)
    WindowFuncs.Settings:Show(false)
end
function OnConfirm()
    local result, error = pcall(OnConfirmInternal)

    if result == false then
        api.Log:Err(error)
    end
end

function OnCancel()
    Settings.TimerWindow = nil
    WindowFuncs.Settings:Show(false)
    titleEditbox:SetText("")
end

okButton:SetHandler("OnClick", OnConfirm)

cancelButton:SetHandler("OnClick", OnCancel)

WindowFuncs.OpenSettings = OpenSettings
WindowFuncs.Settings = Settings
function CreateTimerWindow()
    cntr = cntr + 1
    local wnd = api.Interface:CreateEmptyWindow("timerAddonWnd" .. cntr, "UIParent")
    
    wnd:AddAnchor("TOPLEFT", "UIParent", 1400, 0)
    wnd:SetExtent(170, 95)
    wnd:Show(true)

    wnd.Minimized = false

    wnd.bg = wnd:CreateNinePartDrawable(TEXTURE_PATH.HUD, "background")
    wnd.bg:SetTextureInfo("bg_quest")
    wnd.bg:SetColor(0, 0, 0, 0.5)
    wnd.bg:AddAnchor("TOPLEFT", wnd, 0, 0)
    wnd.bg:AddAnchor("BOTTOMRIGHT", wnd, 0, 0)
    --wnd.bg:SetAutoResize(true)
    
    function wnd:OnDragStart(arg)
      if arg == nil then
        wnd:StartMoving()
        api.Cursor:ClearCursor()
        api.Cursor:SetCursorImage(CURSOR_PATH.MOVE, 0, 0)
        return
      end
      if arg == "LeftButton" and api.Input:IsShiftKeyDown() then
        wnd:StartMoving()
        api.Cursor:ClearCursor()
        api.Cursor:SetCursorImage(CURSOR_PATH.MOVE, 0, 0)
      end
    end
    
    wnd.OnSettingsChanged = nil
    
    function SettingsChanged(wnd)
        if WindowFuncs.Save ~= nil then
            WindowFuncs.Save(wnd)
        end
    end

    wnd.PosX = 1400
    wnd.PosY = 0

    wnd.infoTable = popupFuncs.GetDefaultPopupInfoTable()

    function wnd:MenuPopup(clickButton)
        if clickButton == "RightButton" then
            local success, result = pcall(popupFuncs.ShowPopUpMenu, "ClockPopup", wnd, wnd.infoTable, false, nil)
            if success == false then
                api.Log:Err(result)
            end
        end
    end

    function wnd:OnEnter()
        if wnd.Minimized then
            ShowToolTip(wnd.TitleText, wnd)
        end
    end
    function wnd:OnLeave()
        HideTooltip()
    end

    wnd:SetHandler("OnClick", wnd.MenuPopup)
    wnd:SetHandler("OnEnter", wnd.OnEnter)
    wnd:SetHandler("OnLeave", wnd.OnLeave)

    function wnd:OnDragStop()
      wnd:StopMovingOrSizing()
      PosX, PosY = wnd:GetOffset()
      wnd.PosX = PosX
      wnd.PosY = PosY
      api.Cursor:ClearCursor()
      SettingsChanged()
    end

    wnd:SetHandler("OnDragStart", wnd.OnDragStart)
    wnd:SetHandler("OnDragStop", wnd.OnDragStop)
    if wnd.RegisterForDrag ~= nil then
        wnd:RegisterForDrag("LeftButton")
    end
    if wnd.EnableDrag ~= nil then
        wnd:EnableDrag(true)
    end

    wnd.closeBtn = wnd:CreateChildWidget("button", "closeBtn", 0, true)  
    wnd.closeBtn:AddAnchor("TOPRIGHT", wnd, -5, 5)
    api.Interface:ApplyButtonSkin(wnd.closeBtn, BUTTON_BASIC.WINDOW_SMALL_CLOSE)
    wnd.closeBtn:Show(true)
    wnd.OnClose = nil

    function OnClose(button, clicktype)
        if wnd.OnClose ~= nil then
            wnd.OnClose(wnd)
        end

    end

    wnd.closeBtn:SetHandler("OnClick", OnClose)

    local clockIcon = wnd:CreateChildWidget("label", "clockIcon", 0, true)  
    clockIcon:AddAnchor("TOPLEFT", wnd, 10, 2)
    local clockIconTexture = clockIcon:CreateImageDrawable(TEXTURE_PATH.HUD, "background")
    clockIconTexture:SetTextureInfo("clock")
    clockIconTexture:AddAnchor("TOPLEFT", clockIcon, 0, 0)

    local titleLabel = wnd:CreateChildWidget("label", "titleLabel", 0, true)
    titleLabel.style:SetShadow(true)
    titleLabel.style:SetAlign(ALIGN.CENTER)
    titleLabel:AddAnchor("TOP", wnd, "TOP", 0, 15)
    titleLabel.style:SetFontSize(FONT_SIZE.LARGE)

    wnd.titleLabel = titleLabel
    wnd.TitleText = nil
    wnd.IsTimer = false
    wnd.TimerDuration = 0

    function wnd:UpdateTitle(newTitle)
        if newTitle == nil or newTitle == "" then
            newTitle = "Timer " .. tostring(cntr)
        end
         wnd.titleLabel:SetText(newTitle)

    end

    wnd:UpdateTitle(wnd.TitleText)

    local clockLabel = wnd:CreateChildWidget("label", "clockLabel", 0, true)
    wnd.clockLabel  = clockLabel
    wnd.clockLabel.style:SetShadow(true)
    wnd.clockLabel.style:SetAlign(ALIGN.CENTER)
    wnd.clockLabel:AddAnchor("CENTER", wnd, -5, -3)
    wnd.clockLabel.style:SetFontSize(FONT_SIZE.XLARGE)
    wnd.clockLabel:SetText("00:00")

    wnd.startBtn = wnd:CreateChildWidget("button", "startBtn", 0, true)  
    wnd.startBtn:AddAnchor("BOTTOM", wnd, -50, -10)
    wnd.startBtn:SetText("Start")
    api.Interface:ApplyButtonSkin(wnd.startBtn, BSCBTN)
    
    wnd.startBtn:Show(true)
    
    wnd.running = false
    wnd.starttime = 0
    wnd.starttimelt = 0
    wnd.elapsedTime = 0

    function wnd:Start()
        
        wnd.running = true

        if  wnd.IsTimer then
            runningTime = api.Time:GetUiMsec() - wnd.starttime
            runningTime = runningTime + wnd.elapsedTime;
            runningTime = wnd.TimerDuration - runningTime
            if runningTime < 0 then
                wnd.Restart()
            end
        end
        wnd.starttime = api.Time:GetUiMsec()
        wnd.starttimelt = api.Time:GetLocalTime() 
        
        SettingsChanged()

    end

    wnd.startBtn:SetHandler("OnClick", wnd.Start)

    wnd.stopBtn = wnd:CreateChildWidget("button", "stopBtn", 0, true)  
    wnd.stopBtn:AddAnchor("BOTTOM", wnd, 0, -10)
    wnd.stopBtn:SetText("Stop")
    api.Interface:ApplyButtonSkin(wnd.stopBtn, BSCBTN)
    wnd.stopBtn:Show(true)

    function wnd:Stop()
        if wnd.running then
            wnd.elapsedTime = api.Time:GetUiMsec() - wnd.starttime + wnd.elapsedTime
            wnd.running = false
            SettingsChanged()
        end

     end

    wnd.stopBtn:SetHandler("OnClick", wnd.Stop)

    wnd.restartBtn = wnd:CreateChildWidget("button", "restartBtn", 0, true)  
    wnd.restartBtn:AddAnchor("BOTTOM", wnd, 50, -10)
    wnd.restartBtn:SetText("Reset")
    api.Interface:ApplyButtonSkin(wnd.restartBtn, BSCBTN)
    wnd.restartBtn:Show(true)

    function wnd:Restart()
        wnd.elapsedTime = 0
        if wnd.IsTimer then
            runningTime = wnd.TimerDuration
            runningSeconds = runningTime / 1000
            runningMinutes = runningSeconds / 60
            runningHours = runningMinutes / 60
            runningSeconds = math.floor(runningSeconds % 60)
            runningMinutes = math.floor(runningMinutes % 60)
            runningHours = math.floor(runningHours % 24)
            if runningHours > 0 then
                wnd.clockLabel:SetText(string.format("%02d:%02d:%02d", runningHours, runningMinutes, runningSeconds))
            else
                wnd.clockLabel:SetText(string.format("%02d:%02d", runningMinutes, runningSeconds))
            end
        else
            wnd.clockLabel:SetText("00:00")
        end
        if wnd.running then
            wnd.starttime = api.Time:GetUiMsec()
            wnd.starttimelt = api.Time:GetLocalTime() 
        end
        SettingsChanged()

    end

    wnd.restartBtn:SetHandler("OnClick", wnd.Restart)


    function wnd:OnUpdate(dt)

        if wnd.running then

            runningTime = api.Time:GetUiMsec() - wnd.starttime
            runningTime = runningTime + wnd.elapsedTime;
            if wnd.IsTimer then
                
                runningTime = wnd.TimerDuration - runningTime
                if runningTime < 0 then
                    runningTime = 0
                    wnd:Stop()
                end
            end
            

            runningSeconds = runningTime / 1000
            runningMinutes = runningSeconds / 60
            runningHours = runningMinutes / 60

            runningSeconds = math.floor(runningSeconds % 60)
            runningMinutes = math.floor(runningMinutes % 60)
            runningHours = math.floor(runningHours % 24)
            if runningHours > 0 then
                wnd.clockLabel:SetText(string.format("%02d:%02d:%02d", runningHours, runningMinutes, runningSeconds))
            else
                wnd.clockLabel:SetText(string.format("%02d:%02d", runningMinutes, runningSeconds))
            end
        end
    end

    function OpenSettings()
        WindowFuncs.OpenSettings(wnd)
    end

    wnd.infoTable:AddInfo("Start", wnd.Start)
    wnd.infoTable:AddInfo("Stop", wnd.Stop)
    wnd.infoTable:AddInfo("Reset", wnd.Restart)
    wnd.infoTable:AddInfo("Settings", OpenSettings)

    wnd.settingsButton = wnd:CreateChildWidget("button", "Settings", 170, 95)
    wnd.settingsButton:AddAnchor("RIGHT", wnd, -10, -3)
    api.Interface:ApplyButtonSkin(wnd.settingsButton, BUTTON_CONTENTS.APPELLATION)

    wnd.settingsButton:SetHandler("OnClick", OpenSettings)

    local minimizeButton = wnd:CreateChildWidget("button", "minimizeBtn", 0, true)  
    minimizeButton:SetExtent(16, 18)
    minimizeButton:AddAnchor("TOPRIGHT", wnd, -26, 7)
    local minimizeButtonTexture = minimizeButton:CreateImageDrawable(TEXTURE_PATH.HUD, "background")
    minimizeButtonTexture:SetTexture(TEXTURE_PATH.HUD)
    minimizeButtonTexture:SetCoords(754, 121, 26, 28)
    minimizeButtonTexture:AddAnchor("TOPLEFT", minimizeButton, 0, 0)
    minimizeButtonTexture:SetExtent(16, 18)

    local maximizeButtonTexture = minimizeButton:CreateImageDrawable(TEXTURE_PATH.HUD, "background")
    maximizeButtonTexture:SetTexture(TEXTURE_PATH.HUD)
    maximizeButtonTexture:SetCoords(754, 94, 26, 28)
    maximizeButtonTexture:AddAnchor("TOPLEFT", minimizeButton, 0, 0)
    maximizeButtonTexture:SetExtent(16, 18)
    maximizeButtonTexture:Show(false)

    wnd.minimizeButton = minimizeButton
    wnd.minimizeButtonTexture = minimizeButtonTexture
    wnd.maximizeButtonTexture = maximizeButtonTexture
    wnd.Minimized = false
    function wnd:SetVisibilityLevel()
         if wnd.Minimized then
            wnd:SetExtent(170, 35)
            wnd.settingsButton:Show(false)
            wnd.restartBtn:Show(false)
            wnd.stopBtn:Show(false)
            wnd.startBtn:Show(false)
            --wnd.clockLabel:Show(false)
            wnd.titleLabel:Show(false)
            
            wnd.minimizeButtonTexture:Show(false)
            wnd.maximizeButtonTexture:Show(true)
            wnd:OnEnter()
        else
            wnd:SetExtent(170, 95)
            wnd.settingsButton:Show(true)
            wnd.restartBtn:Show(true)
            wnd.stopBtn:Show(true)
            wnd.startBtn:Show(true)
            --wnd.clockLabel:Show(false)
            --wnd.clockLabel:RemoveAllAnchors()
            --wnd.clockLabel:AddAnchor("TOP", wnd, "TOP", 0, 45)
            
            wnd.titleLabel:Show(true)
            wnd.minimizeButtonTexture:Show(true)
            wnd.maximizeButtonTexture:Show(false)
            wnd:OnLeave()

        end   
    end

    
    function wnd:OnMinimize(button, clicktype)

        if wnd.Minimized == true then
            wnd.Minimized = false
        else
            wnd.Minimized = true
        end
        --wnd.Minimized = not wnd.Minimized
        wnd:SetVisibilityLevel()
        SettingsChanged()
    end



    wnd.minimizeButton:SetHandler("OnClick", wnd.OnMinimize)


    function wnd:Export()
        data = {
            run = wnd.running,
            start = wnd.starttimelt,
            elapsed = string.format("%d", wnd.elapsedTime),
            posx = wnd.PosX,
            posy = wnd.PosY,
            istimer = wnd.IsTimer,
            duration = wnd.TimerDuration,
            minimized = wnd.Minimized
            }
        if wnd.TitleText ~= nil then
            data.title = wnd.TitleText
        end

        return data
    end

    function wnd:Import(data)

        wnd.running = data.run
        wnd.starttimelt = data.start

        local starttime = tonumber(string.sub(wnd.starttimelt, -6))
        local currtime = tonumber(string.sub(api.Time:GetLocalTime(), -6))
        if starttime > currtime then
            currtime = currtime + 1000000
        end

        wnd.elapsedTime = tonumber(data.elapsed)
        wnd.starttime =  api.Time:GetUiMsec() - ((currtime - starttime) * 1000)

        wnd.PosX = data.posx
        wnd.PosY = data.posy
        wnd.TitleText = data.title

        if wnd.TitleText ~= nil then
            wnd:UpdateTitle(wnd.TitleText)
        end
        if data.istimer ~= nil then
            wnd.IsTimer = data.istimer
        end
        if data.duration ~= nil then
            wnd.TimerDuration = data.duration
        end
        wnd:RemoveAllAnchors()
        wnd:AddAnchor("TOPLEFT", "UIParent", wnd.PosX, wnd.PosY)
        if data.minimized ~= nil then
            wnd.Minimized = data.minimized
            wnd:SetVisibilityLevel()
            HideTooltip()
        end
        if not wnd.running then
            wnd:Restart()
        end
    end
    
    function wnd:UpdateSettings(newTitle, timer, duration)
        wnd.TitleText = newTitle
        wnd.IsTimer = timer
        if duration ~= nil then
            wnd.TimerDuration = duration
        else
            wnd.TimerDuration = 0
        end
        
        wnd:UpdateTitle(newTitle)
        if not wnd.running then
            wnd:Restart()
        end
        SettingsChanged()  
    end


    return wnd
end

local function OnUnload()
    if popupMenu ~= nil then
        popupMenu:Show(false)
        popupMenu = nil
    end
end

WindowFuncs.Create = CreateTimerWindow
WindowFuncs.Save = nil
WindowFuncs.Unload = OnUnload
return WindowFuncs