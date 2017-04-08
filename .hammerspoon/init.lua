-- ref: https://github.com/naoya/hammerspoon-init
require('watcher')
require('lib')

-- CmdQ2回で終了のやつ http://qiita.com/oppara/items/802b6c723e94c7a9f907
require('double_cmdq_to_quit')

-- CommandでIMEオンオフするやつ http://mi2.hatenablog.com/entry/2017/03/13/011156
require('cmd_ime')

-- iterm2ではリマップしない
function handleGlobalAppEvent(name, event, app)
   if event == hs.application.watcher.activated then
      -- hs.alert.show(name)
      if name == "iTerm2" then
         disableAllHotkeys()
      else
         enableAllHotkeys()
      end
   end
end
appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
appsWatcher:start()

-- キーリマップ
remapKey({'ctrl'}, 'e', keyCode('right', {'cmd'}))
remapKey({'ctrl'}, 'a', keyCode('left', {'cmd'}))
