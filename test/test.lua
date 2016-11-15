hanjakorean = require 'hanjakorean'

f = io.open("test.txt","r")
io.input(f)
str = io.read("*all")
io.close(f)

f = io.open("result.txt","r")
io.input(f)
result = io.read("*all")
io.close(f)

translated = hanjakorean.reader(str)
print(translated)
--print (decomposed)
--print '--------------------------------'
--print (composed)
--print '--------------------------------'
--print (str)
-- composed = ComposeKoreanString(decomposed)
-- print (str==composed)
assert (result == translated)
