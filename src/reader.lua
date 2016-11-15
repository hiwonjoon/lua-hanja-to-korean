local utf8 = utf8 or require 'lua-utf8'
local hanja_korean_pair = require 'hanjakorean.pairs'

local UnicodeHanjaBase = 0x3400
local UnicodeHanjaLast = 0x9FFF

local reader = function(str)
   local t = {}
   for i = 1, utf8.len(str) do
      local byte = utf8.byte(str,i,i)
      if ((byte < UnicodeHanjaBase) or (byte > UnicodeHanjaLast)) then
         table.insert(t,utf8.char(byte))
      else
         if( hanja_korean_pair[byte] ~= nil ) then
            table.insert(t,utf8.char(hanja_korean_pair[byte]))
         else
            table.insert(t,utf8.char(byte))
         end
      end
   end
   local s = table.concat(t,"")
   return s
end
return reader

--The code below is implention in python for Doeum rule.
--The code is grabbed from https://github.com/suminb/hanja, so credits goes there.
--def dooeum(previous, current):
--    """두음법칙을 적용하기 위한 함수."""
--    p, c = separate(previous), separate(current)
--    offset = 0
--
--    current_head = build(c[0], c[1], 0)
--
--    # 모음이나 ㄴ 받침 뒤에 이어지는 '렬, 률'은 '열, 율'로 발음한다.
--    if previous.isalnum():
--        if current in (u'렬', u'률') and is_hangul(previous) and p[2] in (0, 2):
--            offset = 6
--    # 한자음 '녀, 뇨, 뉴, 니', '랴, 려, 례, 료, 류, 리'가 단어 첫머리에 올 때
--    # '여, 요, 유, 이', '야, 여, 예, 요, 유, 이'로 발음한다.
--    elif current_head in (u'녀', u'뇨', u'뉴', u'니'):
--        offset = 9
--    elif current_head in (u'랴', u'려', u'례', u'료', u'류', u'리'):
--        offset = 6
--    # 한자음 '라, 래, 로, 뢰, 루, 르'가 단어 첫머리에 올 때 '나, 내, 노, 뇌,
--    # 누, 느'로 발음한다.
--    elif current_head in (u'라', u'래', u'로', u'뢰', u'루', u'르'):
--        offset = -3
--
--    return build(c[0] + offset, c[1], c[2])
