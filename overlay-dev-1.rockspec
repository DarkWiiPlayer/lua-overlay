package = "overlay"
version = "dev-1"
source = {
	url = "git+https://github.com/darkwiiplayer/lua-overlay"
}
description = {
	homepage = "https://github.com/darkwiiplayer/lua-overlay",
	license = "Unlicense"
}
build = {
	type = "builtin",
	modules = {
		overlay = "src/overlay.lua"
	}
}
