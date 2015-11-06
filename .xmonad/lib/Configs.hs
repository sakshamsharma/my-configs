module Configs where

import XMonad
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders(smartBorders)
import System.IO
import Data.Monoid
import Data.Maybe
import System.Exit
import XMonad.Util.Scratchpad
import XMonad.Util.NamedScratchpad
import XMonad.Actions.Submap
import XMonad.Hooks.ManageHelpers

import XMonad.Prompt
import XMonad.Prompt.Input

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

scratchpads =
  [
    NS "htop" "urxvt -e htop" (title =? "htop") (customFloating $ W.RationalRect 0 0 1 (5/12))  -- <F4>
  , NS "gvim" "gvim" (className =? "Gvim") (customFloating $ W.RationalRect 0 0 0 0)    -- <F5>
  ]


-- special command prompt
commandPrompt :: XPConfig -> String -> M.Map String (X ()) -> X ()
commandPrompt c p m = inputPromptWithCompl c p (mkComplFunFromList (M.keys m)) ?+ (\k -> fromMaybe (return ()) (M.lookup k m))

commands :: M.Map String (X ())
commands = M.fromList
  [ ("logout"       , io    exitSuccess)
  , ("lock"         , spawn "xscreensaver-command -lock")
  , ("suspend"      , spawn "xscreensaver-command -lock && sleep 2 && systemctl suspend -i")
  , ("shutdown"     , spawn "sleep 2 && systemctl poweroff")
  , ("restart"      , spawn "sleep 2 && systemctl reboot")
  , ("sleep"        , spawn $ "xscreensaver-command -lock && sleep 2 && sudo pm-suspend")
  ]

-- shellprompt config
fireSPConfig = defaultXPConfig
  { bgColor             = colorFocusBG,
    fgColor             = colorNormalFG,
    bgHLight            = colorNormalBG,
    fgHLight            = colorFocusFG,
    borderColor         = "black",
    promptBorderWidth   = 0,
    position            = Bottom,
    height              = 12,
    historySize         = 256,
    defaultText         = "",
    autoComplete        = Nothing
  }

myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

{-myStartup :: X ()-}
{-myStartup = do-}
  {-spawn "conky -c ~/.conky/sideconky &"-}

myManagementHooks :: [ManageHook]
myManagementHooks = [ composeOne [ isFullscreen -?> doFullFloat  ] ]

myLayout = tiled ||| stiled ||| Mirror tiled ||| Full
 where
  -- default tiling algorithm partitions the screen into two panes
  tiled = Tall nmaster1 delta ratio

  stiled = spacing 5 $ Tall nmaster2 delta ratio

  nmaster1 = 1  -- The default number of windows in the master pane
  nmaster2 = 2  -- Same
  ratio = 1/2   -- Default proportion of screen occupied by master pane
  delta = 5/100 -- Percent of screen to increment by when resizing panes


-- color definitions
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#0000ff"

-- colors for shellprompt
colorNormalFG = "#B6B4B8"
colorNormalBG = "#2F2E2B"
colorNormalBO = "#1C2636"
colorFocusFG = "#FFFFFF"
colorFocusBG = "#2F2E2B"
colorFocusBO = "#FF0000"
colorOtherFG = "#707070"
colorOtherBG = "#2F2E2B"
