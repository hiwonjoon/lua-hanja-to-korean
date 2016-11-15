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

local UniCodeHangulBase = 0xAC00;
local UniCodeHangulLast = 0xD79F;

--                 ㄸ        ㅃ      ㅉ  
local ChoOnly = Set { 0x3138,  0x3143, 0x3149 }
--                   ㄳ      ㄵ      ㄶ       ㄺ      ㄻ      ㄼ      ㄽ      ㄾ      ㄿ      ㅀ        ㅄ    
local JongOnly = Set { 0x3133, 0x3135, 0x3136, 0x313a, 0x313b, 0x313c, 0x313d, 0x313e, 0x313f, 0x3140, 0x3144 }
--                  ㅏ      ㅐ      ㅑ      ㅒ      ㅓ      ㅔ      ㅕ      ㅖ      ㅗ      ㅘ      ㅙ      ㅚ      ㅛ      ㅜ      ㅝ      ㅞ      ㅟ      ㅠ      ㅡ      ㅢ      ㅣ

local decomposer = function (str)
    local t = {}
    
    for i = 1, utf8.len(str) do
        local byte = utf8.byte(str,i,i)
        if ((byte < UniCodeHangulBase) or (byte > UniCodeHangulLast)) then
            table.insert(t,utf8.char(byte))
        else
            local nUniCode = byte - UniCodeHangulBase;
            local cho = math.floor(nUniCode / (21 * 28))+1;
            nUniCode = nUniCode % (21 * 28);
            local jung = math.floor(nUniCode / 28)+1;
            nUniCode = nUniCode % 28;
            local jong = nUniCode+1;

            table.insert(t,utf8.char(choTbl[cho]))
            table.insert(t,utf8.char(jungTbl[jung]))
            if(jong ~= 1) then
                table.insert(t,utf8.char(jongTbl[jong]))
            end
        end
    end
    local s = table.concat(t,"")
    return s
end
return decomposer
