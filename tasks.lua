local task = require("spooder").task

task.test {
	'luacheck .';
	'busted .';
}
