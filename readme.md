# Overlay

A Lua library to create "overlay" tables.

```lua
local overlay = require 'overlay'

local t = overlay(
    { foo = 1 }, -- takes precedence
    { foo = 0, bar = 0 }
)

print(t:get('foo')) --> 1
print(t:get('bar')) --> 0
```

It also allows overlaying of nested tables like complex configurations

```lua
local config = overlay(
    { user = { name = "local" } };
    { user = { name = "root", password = "1111" } };
)

print(t:get('user', 'name')) --> local
print(t:get('user', 'password')) --> 1111
```

Overlay tables can be accessed with any Lua value. There are no magic or
reserved keys.

When indexing operations may fail, whether by errors in an `__index` metamethod,
or when different levels may return non-indexable items, the function will fail.
To instead skip to the next layer, use the `pget` (protected get) method
instead.
Note that this may conceal errors that you might want to fix.

```lua
local config = overlay(
    { difficult = setmetatable({}, {__index=error}) };
    { difficult = { value = ">:3" } };
)

print(config:pget('difficult', 'value')) --> >:3
```

The `xpget` function allows passing an error handler as the first argument that
will be called for any errors before continuing through the stack.

```lua
print(config:xpget(log.warn, 'difficult', 'value')) -> >:3
```
