import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders(smartBorders)

import XMonad.Hooks.EwmhDesktops        (ewmh)
import System.Taffybar.Hooks.PagerHints (pagerHints)

import Keys
import Configs
import Startup

main =
  xmonad $ ewmh $ pagerHints $ defaultConfig {
    manageHook = manageDocks <+> manageHook defaultConfig <+> composeAll myManagementHooks
  , layoutHook = avoidStruts $ smartBorders myLayout
  , keys               = myKeys
  , workspaces         = myWorkspaces
  , startupHook        = myStartup
  , normalBorderColor  = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  , modMask = mod4Mask
  , terminal = "urxvt"
  }
