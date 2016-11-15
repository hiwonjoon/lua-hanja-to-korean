package = "hanjakorean"
 version = "0.1-1"
 source = {
    url = "https://github.com/hiwonjoon/lua-hanja-to-korean",
	tag = "master"
 }
 description = {
    summary = "Package for reading hanja character in korean.",
    detailed = [[
		Package for reading hanja character in korean.
    ]],
    homepage = "https://github.com/hiwonjoon/lua-hanja-to-korean",
    license = "MIT"
 }
 dependencies = {
    "lua ~> 5.1",
	"luautf8 >= 0.1.1"
    -- If you depend on other rocks, add them here
 }
 build = {
	type = "builtin",
	modules = {
		['hanjakorean.init'] = 'init.lua',
		['hanjakorean.pairs']  = "src/pairs.lua",
		['hanjakorean.reader']  = "src/reader.lua",
	}
 }
