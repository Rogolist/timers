local api = require("api")

local TimerAddon = {
    name = "Timers",
    author = "Delarme & Psejik",
    desc = "Timer windows",
    version = "1.3"
}
--692,495
CLOCKBTN = {
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
    width = 28,
    height = 28,
    autoResize = true,
    drawableType = "drawable",
    coordsKey = "btn",
}

local TimerWnd
local OpenWindows = {}
local Utils

function SettingsChanged()
    
    local persistentData = {}
    for i = 1, #OpenWindows do
        
        local window = OpenWindows[i]
        
        local call = window.Export
        
        local res, data = pcall(call)
        if res == false then
            api.Log:Err(data)
            return
        end
        
        table.insert(persistentData, data)
    end
    api.File:Write("timers/data/_globals.lua", persistentData)
end

function CloseTimer(wnd)

    if wnd.idx == #OpenWindows then
        local rem = table.remove(OpenWindows)
    else
        -- move the last element into the spot the closed window has, then remove the last spot
        local mov = OpenWindows[#OpenWindows]
        mov.idx = wnd.idx
        OpenWindows[mov.idx] = mov
        table.remove(OpenWindows)
    end
    wnd:Show(false)
    SettingsChanged()
end

function CreateTimerInternal()
    local newtimer = Utils.Create() -- Utils = require("timers/timer_window") => WindowFuncs.Create = CreateTimerWindow
    newtimer:Show(true)
    newtimer.idx = #OpenWindows + 1
    newtimer.OnClose = CloseTimer
    table.insert(OpenWindows, newtimer)
    return newtimer
end

function CreateTimer()

    CreateTimerInternal()
    SettingsChanged()

end

function ClockBtnOnClick() -- при нажатии на значек часов
    
    local success, retval = pcall(CreateTimer)

    if success == false then
        api.Log:Err(tostring(retval))
    end
end

local function OnLoad()

	local settings = api.GetSettings("timers")
	
	if not settings.x then settings.x = 1400 end
	if not settings.y then settings.y = 0 end

    TimerWnd = api.Interface:CreateEmptyWindow("timerAddonWnd", "UIParent")
    TimerWnd:AddAnchor("TOPRIGHT", "UIParent", -350, 0)
    TimerWnd:SetExtent(28, 28)
    TimerWnd:Show(true)
   
    local clockBtn = TimerWnd:CreateChildWidget("button", "clockBtn", 0, true)  
    --clockBtn:AddAnchor("TOPLEFT", TimerWnd, 0, 0)
    --clockBtn:AddAnchor("BOTTOMRIGHT", TimerWnd, 0, 0)
	clockBtn:AddAnchor("TOPLEFT", "UIParent", settings.x, settings.y) --"TOPRIGHT"
	TimerWnd:SetExtent(28, 28)

    api.Interface:ApplyButtonSkin(clockBtn, CLOCKBTN)
    local clockIconTexture = clockBtn:CreateImageDrawable(TEXTURE_PATH.HUD, "background")
    clockIconTexture:SetTextureInfo("clock")
    clockIconTexture:SetExtent(28,28)
    clockIconTexture:AddAnchor("TOPLEFT", clockBtn, 0, 0)

    Utils = require("timers/timer_window")
    Utils.Save = SettingsChanged
    clockBtn:SetHandler("OnClick", ClockBtnOnClick)
	
    function clockBtn:OnDragStart()
        if api.Input:IsShiftKeyDown() then
            clockBtn:StartMoving()
            api.Cursor:ClearCursor()
            api.Cursor:SetCursorImage(CURSOR_PATH.MOVE, 0, 0)
        end
    end

    function clockBtn:OnDragStop()
        local current_x, current_y = clockBtn:GetOffset()
        settings.x = current_x
        settings.y = current_y
        api.SaveSettings()
        clockBtn:StopMovingOrSizing()
        api.Cursor:ClearCursor()
    end
	
    clockBtn:SetHandler("OnDragStart", clockBtn.OnDragStart)
    clockBtn:SetHandler("OnDragStop", clockBtn.OnDragStop)
    clockBtn:EnableDrag(true)

    -- load data
    data = api.File:Read("timers/data/_globals.lua")
    if data ~= nil then
        for i = 1, #data do
            record = data[i]
            local timer = CreateTimerInternal()
            timer:Import(record)
        end
    end
end

local function Update(dt)
    for i = 1, #OpenWindows do
        local success, result = pcall(OpenWindows[i].OnUpdate, dt)
        if success == false then
            api.Log:Err(result)
        end
        --OpenWindows[i]:OnUpdate(dt)
    end
end

local function OnUpdate(dt)
    local success, result = pcall(Update, dt)
    if success == false then
        api.Log:Err(result)
    end
end

local function OnUnload()
    if TimerWnd ~= nil then
        TimerWnd:Show(false)
        TimerWnd = nil
    end
    if OpenWindows ~= nil then
        for i = 1, #OpenWindows do
            OpenWindows[i]:Show(false)
        end
        OpenWindows = nil
    end
    if Utils == nil then
        return
    end
    if Utils.Settings ~= nil then
        Utils.Settings:Show(false)
    end
   
    if Utils.Unload ~= nil then
        Utils.Unload()
    end
end
api.On("UPDATE", OnUpdate)
TimerAddon.OnLoad = OnLoad
TimerAddon.OnUnload = OnUnload

return TimerAddon