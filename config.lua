Config = {}

Config.Debug = false -- 如果不知道干什么的请保持关闭谢谢

--- 语言
Config.Language = 'zh-cn'

--- 是否兼容 RONNIE_TD_RadioP25
Config.CompatRadioP25 = true

--- 按住喊话（FiveM 键位设置可改）
--- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.HoldKey = 'RMENU'

--- 车外拿取后，离车超过此距离自动归还（米）
Config.MaxTakeDistance = 4.0

--- 车门打开阈值（0–1）
Config.DoorOpenThreshold = 0.12

--[[
  通知方式（弹窗提示）
  'ox_lib' = ox_lib notify
  'okok'   = okokNotify
  'qb'     = qb-core Notify
  'esx'    = ESX.ShowNotification
  'gta'    = 原版 GTA feed 通知
]]
Config.Notify = 'ox_lib'

--[[
  互动方式（车外拿取 / 归还）— 只选一个
  'ox_target'    = ox_target
  'qb_target'    = qb-target
  'target'       = qtarget / qb-target（同 qb_target）
  'ox_lib'       = ox_lib TextUI + 按 E
  'okok'         = okokTextUI + 按 E
  'qb'           = qb-core DrawText + 按 E
  'jg'           = jg-textui + 按 E
  'cd_drawtextui'= Codesign drawtextui + 按 E
  'drawtext3d'   = 世界 3D 文字 + 按 E
  'gta_3d'       = GTA 浮动帮助 + 按 E
  'gta_2d'       = GTA 底部帮助 + 按 E
]]
Config.Interact = 'ox_target'

--- 非 target：按键（38 = E / INPUT_PICKUP）
Config.InteractKey = 38
--- GTA 2D/3D 帮助文本里的按键图标
Config.InteractControl = 'INPUT_PICKUP'
--- 互动距离（target / 靠近判定共用）
Config.TargetDistance = 2.0

--- 互动额外东西（drawtext3d / gta_* / okok）
Config.InteractDraw = {
    marker = false,
    markerType = 2,
    markerScale = vec3(0.2, 0.2, 0.2),
    markerColor = { r = 0, g = 150, b = 255, a = 180 },
    textZOffset = 0.35,
    --- drawtext3d：GTA 字体 ID（0~7）
    --- https://docs.fivem.net/natives/?_0x66E0276CC5F6B9DA
    textFont = 0,
    textScale = 0.35,
    textColor = { r = 255, g = 255, b = 255, a = 215 },
    --- 仅 Interact = 'okok'
    okokColor = 'darkblue',
    okokPosition = 'left',
}

--- 可操作座位（-1 驾驶 / 0 副驾）
Config.Seats = {
    [-1] = true,
    [0] = true,
}

--- 座位 → 车门索引（拿取互动）
Config.SeatDoors = {
    [-1] = { door = 0, bones = { 'door_dside_f', 'seat_dside_f' } },
    [0] = { door = 1, bones = { 'door_pside_f', 'seat_pside_f' } },
}

--- 距离衰减（最终 distant 用车辆 range 覆盖）
Config.Range = {
    nearRatio = 0.08,   -- near = range * nearRatio
    farRatio = 0.35,    -- far   = range * farRatio
    rolloff = 1.0,
    edge = 0.2,
    sendPadding = 10.0, -- 服务端多发这么多米
    vehicleDoorOpen = 1.0,    -- 有车门开着：不衰减
    vehicleWindowOpen = 0.82, -- 门关、有车窗开着：衰减
    vehicleClosed = 0.55,     -- 门窗都关：衰减
    doorOpenThreshold = 0.08, -- 车门打开阈值
    interior = 0.40,          -- 建筑室内：衰减
    delay = true,             -- 按 343 m/s 延迟
}

Config.Sound = {
    volume = 0.60, -- 音量
    selfMonitor = 0,      -- 本地耳返关闭；自己听车体 3D
    selfEffects = 0,      -- 本地特效也关，咔哒/啸叫随音频走 3D
    selfDelay = 0.04,     -- 本地延迟
    bitrate = 24000,      -- 比特率
    keyClick = true,      -- 按住时咔哒声
    lineNoise = 0.50,      -- 按住时线路底噪（哼声+沙沙）；0=关，原版约 1.0，默认压到 0.25
    keepMicOpen = 20,      -- 保持麦克风打开时间（秒）
    squeal = {
        outside = 1.0,      -- 车外啸叫音量
        inside = 1.0,       -- 车内啸叫音量
        freqMin = 1860,     -- 啸叫频率范围：最低
        freqMax = 1980,     -- 啸叫频率范围：最高
        level = 0.013,      -- 啸叫音量
    },
}

--- [车名] > 坐标 > 声音距离
Config.Vehicles = {
    ['police'] = {
        offset = vector3(-0.0200, 0.6600, 0.2400),
        range = 130.0,
    },
    ['police2'] = {
        offset = vector3(0.0000, 0.6400, 0.3100),
        range = 120,
    },
    ['lapd25f'] = {
        offset = vector3(0.1300, 0.2300, 0.1800),
        range = 120,
    },
}
--[[
  Config.Vehicles：
    [车模名] = {
      offset = vector3(x, y, z), -- 车体本地坐标：缆线挂点 + 喇叭发声点
      range  = 130.0,            -- 声音最远距离（米）
    }
]]
