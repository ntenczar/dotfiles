import XMonad
import XMonad.Config
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run (spawnPipe, hPutStrLn)

main = do
  xmproc <- spawnPipe "~/.local/bin/xmobar ~/.xmobarrc"
  xmonad $ myConfig xmproc

myModMask = mod4Mask
myTerminal = "terminator"
myFocusFollowsMouse = False
myClickJustFocuses = True
myBorderWidth   = 2
myNormalBorderColor  = "#282A36"
myFocusedBorderColor = "#6272A4"

myConfig xmproc = desktopConfig
  { modMask            = myModMask
  , manageHook         = manageDocks <+> manageHook desktopConfig
  , layoutHook         = avoidStruts $ layoutHook desktopConfig
  , handleEventHook    = handleEventHook defaultConfig <+> docksEventHook
  , logHook            = dynamicLogWithPP xmobarPP
                           { ppOutput          = hPutStrLn xmproc
                           , ppTitle           = xmobarColor "purple"  "" . shorten 50
                           , ppHiddenNoWindows = xmobarColor "grey" ""
                           }
  , terminal           = myTerminal
  , focusFollowsMouse  = myFocusFollowsMouse
  , clickJustFocuses   = myClickJustFocuses
  , borderWidth        = myBorderWidth
  , normalBorderColor  = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  } `additionalKeys` myAdditionalKeys

dmenu = "dmenu_run -fn \"xft:Inconsolata-dz for Powerline:size=13\" \
        \ -nf '#bd93f9' -nb '#282A36' -sf '#bd93f9' -sb '#000000'"

myAdditionalKeys =
  [
    ((myModMask, xK_p), spawn dmenu)
  ]
