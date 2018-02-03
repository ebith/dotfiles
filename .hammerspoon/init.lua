-- ref: https://github.com/naoya/hammerspoon-init
require('watcher')
require('lib')

-- CmdQ2回で終了のやつ http://qiita.com/oppara/items/802b6c723e94c7a9f907
require('double_cmdq_to_quit')

-- CommandでIMEオンオフするやつ http://mi2.hatenablog.com/entry/2017/03/13/011156
require('cmd_ime')

-- リマップしないやつ
local ignores = { "iTerm2", "MacVim" }
local function hasValue (tab, val)
  for index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end
function handleGlobalAppEvent(name, event, app)
   if event == hs.application.watcher.activated then
      -- hs.alert.show(name)
      if hasValue(ignores, name) then
         disableAllHotkeys()
      else
         enableAllHotkeys()
      end
   end
end
appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
appsWatcher:start()

-- キーリマップ
remapKey({"ctrl"}, "p", keyCode("up"))
remapKey({"ctrl"}, "n", keyCode("down"))
remapKey({"ctrl"}, "f", keyCode("right"))
remapKey({"ctrl"}, "b", keyCode("left"))

remapKey({"ctrl"}, "w", keyCode("delete", {"option"}))

local function killLine()
    return keyCode("right", {"cmd", "shift"}, keyCode("x", {"cmd"}))
end
remapKey({"ctrl"}, "u", killLine())

remapKey({'ctrl'}, 'e', keyCode('right', {'cmd'}))
remapKey({'ctrl'}, 'a', keyCode('left', {'cmd'}))
