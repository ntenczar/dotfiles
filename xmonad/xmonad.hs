import XMonad
import XMonad.Config
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig (additionalKeys)

main = xmonad =<< xmobar myConfig

myModMask = mod4Mask
myTerminal = "terminator"
myFocusFollowsMouse = False
myClickJustFocuses = True
myBorderWidth   = 2
myNormalBorderColor  = "#282A36"
myFocusedBorderColor = "#6272A4"

myConfig = def
  { terminal           = myTerminal
  , modMask            = myModMask
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
