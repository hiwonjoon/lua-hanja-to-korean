function Set (list)
    local set = {}
    for i, l in ipairs(list) do set[l] = i end
    return set
end
local utf8 = utf8 or require 'lua-utf8'
--            ㄱ      ㄲ      ㄴ      ㄷ      ㄸ      ㄹ      ㅁ      ㅂ      ㅃ      ㅅ      ㅆ      ㅇ      ㅈ      ㅉ      ㅊ      ㅋ      ㅌ      ㅍ      ㅎ
local choTbl = { 0x3131, 0x3132, 0x3134, 0x3137, 0x3138, 0x3139, 0x3141, 0x3142, 0x3143, 0x3145, 0x3146, 0x3147, 0x3148, 0x3149, 0x314a, 0x314b, 0x314c, 0x314d, 0x314e }
--              ㅏ      ㅐ      ㅑ      ㅒ      ㅓ      ㅔ      ㅕ      ㅖ      ㅗ      ㅘ      ㅙ      ㅚ      ㅛ      ㅜ      ㅝ      ㅞ      ㅟ      ㅠ      ㅡ      ㅢ      ㅣ
local jungTbl = { 0x314f, 0x3150, 0x3151, 0x3152, 0x3153, 0x3154, 0x3155, 0x3156, 0x3157, 0x3158, 0x3159, 0x315a, 0x315b, 0x315c, 0x315d, 0x315e, 0x315f, 0x3160, 0x3161, 0x3162, 0x3163 }
--                      ㄱ      ㄲ      ㄳ      ㄴ      ㄵ      ㄶ      ㄷ      ㄹ      ㄺ      ㄻ      ㄼ      ㄽ      ㄾ      ㄿ      ㅀ      ㅁ      ㅂ      ㅄ      ㅅ      ㅆ      ㅇ      ㅈ      ㅊ      ㅋ      ㅌ      ㅍ      ㅎ
local jongTbl = { 0,      0x3131, 0x3132, 0x3133, 0x3134, 0x3135, 0x3136, 0x3137, 0x3139, 0x313a, 0x313b, 0x313c, 0x313d, 0x313e, 0x313f, 0x3140, 0x3141, 0x3142, 0x3144, 0x3145, 0x3146, 0x3147, 0x3148, 0x314a, 0x314b, 0x314c, 0x314d, 0x314e }

local choSet = Set { 0x3131, 0x3132, 0x3134, 0x3137, 0x3138, 0x3139, 0x3141, 0x3142, 0x3143, 0x3145, 0x3146, 0x3147, 0x3148, 0x3149, 0x314a, 0x314b, 0x314c, 0x314d, 0x314e }
--              ㅏ      ㅐ      ㅑ      ㅒ      ㅓ      ㅔ      ㅕ      ㅖ      ㅗ      ㅘ      ㅙ      ㅚ      ㅛ      ㅜ      ㅝ      ㅞ      ㅟ      ㅠ      ㅡ      ㅢ      ㅣ
local jungSet = Set { 0x314f, 0x3150, 0x3151, 0x3152, 0x3153, 0x3154, 0x3155, 0x3156, 0x3157, 0x3158, 0x3159, 0x315a, 0x315b, 0x315c, 0x315d, 0x315e, 0x315f, 0x3160, 0x3161, 0x3162, 0x3163 }
--                      ㄱ      ㄲ      ㄳ      ㄴ      ㄵ      ㄶ      ㄷ      ㄹ      ㄺ      ㄻ      ㄼ      ㄽ      ㄾ      ㄿ      ㅀ      ㅁ      ㅂ      ㅄ      ㅅ      ㅆ      ㅇ      ㅈ      ㅊ      ㅋ      ㅌ      ㅍ      ㅎ
local jongSet = Set { 0,      0x3131, 0x3132, 0x3133, 0x3134, 0x3135, 0x3136, 0x3137, 0x3139, 0x313a, 0x313b, 0x313c, 0x313d, 0x313e, 0x313f, 0x3140, 0x3141, 0x3142, 0x3144, 0x3145, 0x3146, 0x3147, 0x3148, 0x314a, 0x314b, 0x314c, 0x314d, 0x314e }

local UniCodeHangulBase = 0xAC00;
local UniCodeHangulLast = 0xD79F;

--                 ㄸ        ㅃ      ㅉ  
local ChoOnly = Set { 0x3138,  0x3143, 0x3149 }
--                   ㄳ      ㄵ      ㄶ       ㄺ      ㄻ      ㄼ      ㄽ      ㄾ      ㄿ      ㅀ        ㅄ    
local JongOnly = Set { 0x3133, 0x3135, 0x3136, 0x313a, 0x313b, 0x313c, 0x313d, 0x313e, 0x313f, 0x3140, 0x3144 }
--                  ㅏ      ㅐ      ㅑ      ㅒ      ㅓ      ㅔ      ㅕ      ㅖ      ㅗ      ㅘ      ㅙ      ㅚ      ㅛ      ㅜ      ㅝ      ㅞ      ㅟ      ㅠ      ㅡ      ㅢ      ㅣ
local composer = function (str)
    function Set (list)
        local set = {}
        for i, l in ipairs(list) do set[l] = i end
        return set
    end
    local utf8 = utf8 or require 'lua-utf8'

    local UniCodeHangulBase = 0xAC00;
    
    local t = {}
    
    local current = {cho=0,jung=0,jong=0}
    function ComposeChar(info) 
        if( info.cho == 0 ) then
            return ""
        elseif( info.jung == 0 ) then
            local c = utf8.char(info.cho)
            info.cho = 0
            return c
        else
            --print (choTbl[info.cho],jungTbl[info.jung],jongTbl[info.jong])

            local c = utf8.char(UniCodeHangulBase + ((choSet[info.cho]-1)*21*28) + (jungSet[info.jung]-1)*28 + jongSet[info.jong]-1)
            info.cho = 0
            info.jung = 0
            info.jong = 0
            return c
        end
    end
    
    for i = 1, utf8.len(str) do
        local byte = utf8.byte(str,i,i)
        flag = false;
        if (jungTbl[1] <= byte) and (byte <= jungTbl[#jungTbl]) then
            if( current.jong > 0 ) and not JongOnly[current.jong] then
                local temp = current.jong
                current.jong = 0
                table.insert(t,ComposeChar(current))
                current.cho = temp
                current.jung = byte
            elseif (current.cho > 0) and (current.jung == 0) and (current.jong == 0) then
                current.jung = byte
            else
                flag = true;
            end
        elseif (choTbl[1] <= byte) and (byte <= choTbl[#choTbl]) then
            if current.jong > 0 then
                table.insert(t,ComposeChar(current))
            end
            
            if( ChoOnly[byte] ) then
                if( current.cho == 0 ) then
                    current.cho = byte
                else
                    flag = true
                end
            elseif( JongOnly[byte] ) then
                if (current.cho > 0) and (current.jung > 0) then
                    current.jong = byte
                    table.insert(t,ComposeChar(current))
                else
                    flag = true;
                end
            else
                if( current.cho == 0 ) then
                    current.cho = byte
                elseif (current.cho > 0) and (current.jung > 0 ) then
                    current.jong = byte
                else
                    flag = true
                end
            end
        else
            flag = true
        end
        
        if (flag) then
            table.insert(t,ComposeChar(current))
            table.insert(t,utf8.char(byte))
        end
    end
    s = table.concat(t,"")
    return s
end
return composer;
