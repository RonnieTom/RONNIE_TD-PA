--[[!
  RONNIE_TD_PA — PROPRIETARY — Copyright (c) 2026 RONNIE. All rights reserved.
  服务器启动广告 + GitHub 版本检查
]]

local RES = GetCurrentResourceName()
local VERSION = GetResourceMetadata(RES, 'version', 0) or '0.1.0'
local GITHUB_REPO = 'RonnieTom/RONNIE_TD-PA'
local GITHUB_URL = ('https://github.com/%s'):format(GITHUB_REPO)

local function line(s)
    print(s)
end

local function printBanner()
    line('^5--------------------------------------------------------------------^7')
    line('^5--------------------------------------------------------------------^7')
    line([[^3$$$$$$$\   $$$$$$\  $$\   $$\ $$\   $$\ $$$$$$\ $$$$$$$$\     $$$$$$$$\ ^7]])
    line([[^3$$  __$$\ $$  __$$\ $$$\  $$ |$$$\  $$ |\_$$  _|$$  _____|    \__$$  __|^7]])
    line([[^3$$ |  $$ |$$ /  $$ |$$$$\ $$ |$$$$\ $$ |  $$ |  $$ |             $$ |   ^7]])
    line([[^3$$$$$$$  |$$ |  $$ |$$ $$\$$ |$$ $$\$$ |  $$ |  $$$$$\           $$ |   ^7]])
    line([[^3$$  __$$< $$ |  $$ |$$ \$$$$ |$$ \$$$$ |  $$ |  $$  __|          $$ |   ^7]])
    line([[^3$$ |  $$ |$$ |  $$ |$$ |\$$$ |$$ |\$$$ |  $$ |  $$ |             $$ |   ^7]])
    line([[^3$$ |  $$ | $$$$$$  |$$ | \$$ |$$ | \$$ |$$$$$$\ $$$$$$$$\        $$ |   ^7]])
    line([[^3\__|  \__| \______/ \__|  \__|\__|  \__|\______|\________|$$$$$$\\__|   ^7]])
    line([[^3                                                          \______|      ^7]])
    line('')
    line('^2        QQ : 3547376520       |  版权所有 : RONNIE_T^7')
    line('^2        脚本 : RONNIE_TD_PA   |  依赖 : RONNIE_TD_PA_lib / RadioAmin^7')
    line(('^2        开发者 : RONNIE_T      |  版本 : %s^7'):format(VERSION))
    line('^2        License : 许可信息仅供参考 请以 LICENSE 为准 不可二次分发^7')
    line('^5--------------------------------------------------------------------^7')
    line('^5--------------------------------------------------------------------^7')
end

local function printUpdateBlock(lines)
    local out = {}
    for i = 1, #lines do
        if lines[i] and lines[i] ~= '' then
            out[#out + 1] = lines[i]
        end
    end
    if #out == 0 then
        return
    end
    line('^5--------------------------------------------------------------------^7')
    line('^5--------------------------------------------------------------------^7')
    for i = 1, #out do
        line(('^3%s^7'):format(out[i]))
    end
    line('^5--------------------------------------------------------------------^7')
    line('^5--------------------------------------------------------------------^7')
end

local function verTuple(v)
    local a, b, c = tostring(v or '0'):match('(%d+)%.(%d+)%.(%d+)')
    if not a then
        a, b = tostring(v or '0'):match('(%d+)%.(%d+)')
        c = 0
    end
    return tonumber(a) or 0, tonumber(b) or 0, tonumber(c) or 0
end

local function isNewer(remote, localV)
    local r1, r2, r3 = verTuple(remote)
    local l1, l2, l3 = verTuple(localV)
    if r1 ~= l1 then
        return r1 > l1
    end
    if r2 ~= l2 then
        return r2 > l2
    end
    return r3 > l3
end

local function handleRemoteVersion(remote, title)
    remote = tostring(remote or ''):gsub('^v', '')
    if remote == '' then
        printUpdateBlock({
            'Github : 无法解析最新版本',
            ('仓库 : %s'):format(GITHUB_URL),
        })
        return
    end
    if isNewer(remote, VERSION) then
        printUpdateBlock({
            ('Github 更新可用 : %s → %s'):format(VERSION, remote),
            title and title ~= '' and ('标题 : %s'):format(title) or nil,
            ('仓库 : %s'):format(GITHUB_URL),
            '请前往 Github 查看更新说明',
        })
    else
        printUpdateBlock({
            ('Github : 已是最新版本 (%s)'):format(VERSION),
            ('仓库 : %s'):format(GITHUB_URL),
        })
    end
end

local function checkTags()
    PerformHttpRequest(
        ('https://api.github.com/repos/%s/tags'):format(GITHUB_REPO),
        function(status, body)
            if status ~= 200 or type(body) ~= 'string' then
                printUpdateBlock({
                    ('Github : 暂无法检查更新（HTTP %s）'):format(tostring(status)),
                    ('仓库 : %s'):format(GITHUB_URL),
                })
                return
            end
            local tag = body:match('"name"%s*:%s*"(v?[%d%.]+)"')
            if not tag then
                printUpdateBlock({
                    'Github : 暂无 Release / Tag',
                    ('仓库 : %s'):format(GITHUB_URL),
                    ('当前版本 : %s'):format(VERSION),
                })
                return
            end
            handleRemoteVersion(tag)
        end,
        'GET',
        '',
        { ['User-Agent'] = 'RONNIE_TD_PA' }
    )
end

local function checkGithub()
    PerformHttpRequest(
        ('https://api.github.com/repos/%s/releases/latest'):format(GITHUB_REPO),
        function(status, body)
            if status == 404 then
                checkTags()
                return
            end
            if status ~= 200 or type(body) ~= 'string' or body == '' then
                checkTags()
                return
            end
            local remote = body:match('"tag_name"%s*:%s*"(v?[%d%.]+)"')
            local title = body:match('"name"%s*:%s*"(.-)"')
            handleRemoteVersion(remote, title)
        end,
        'GET',
        '',
        { ['User-Agent'] = 'RONNIE_TD_PA' }
    )
end

CreateThread(function()
    Wait(500)
    printBanner()
    checkGithub()
end)
