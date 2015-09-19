module Keys where

import Data.List
import System.Exit
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.WindowNavigation
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.EZConfig
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run
import XMonad.Util.Scratchpad
import XMonad.Util.XSelection
import Graphics.X11.ExtraTypes.XF86
import XMonad.Prompt.Window

import qualified Data.Map        as M
import qualified XMonad.StackSet as W

import Configs

-- | Key bindings. Add, modify or remove key bindings here.
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

  [
-- | Scratchpads
    ((modm,               xK_F4    ), namedScratchpadAction scratchpads "htop")
  , ((modm,               xK_F5    ), namedScratchpadAction scratchpads "gvim")

-- | App launchers
  , ((modm,               xK_d     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"") -- launch dmenu
  , ((modm .|. shiftMask, xK_d     ), spawn "gmrun")                                          -- launch gmrun (better dmenu)
  , ((modm,               xK_Return), spawn $ XMonad.terminal conf)                           -- launch terminal
  , ((modm,               xK_F1    ), spawn "google-chrome-stable")                           -- launch chrome
  , ((modm,               xK_F3    ), spawn "pcmanfm")                                        -- launch file manager
  , ((modm              , xK_F11   ), prompt ("urxvt" ++ " -e") greenXPConfig)                -- run any command (gmrun with completion)

-- | Media keys
  , ((mod1Mask          , xK_3     ),  spawn "amixer -q set Master 5%-")
  , ((mod1Mask          , xK_4     ),  spawn "amixer -q set Master 5%+")
  , ((0,   xF86XK_AudioLowerVolume ),  spawn "amixer -q set Master 5%-")
  , ((0,   xF86XK_AudioRaiseVolume ),  spawn "amixer -q set Master 5%+")
  , ((0,   xF86XK_MonBrightnessUp  ),  spawn "xbacklight -steps 1 -time 0 -inc 8")
  , ((0,   xF86XK_MonBrightnessDown),  spawn "xbacklight -steps 1 -time 0 -dec 6")

-- | Workspace shortcuts
  , ((modm     , xK_f), moveTo Next EmptyWS)  -- find a free workspace
  , ((mod1Mask,           xK_Down),  nextWS)  -- alt+down moves to next workspace
  , ((mod1Mask,           xK_Up),    prevWS)  -- alt+up moves to prev workspace

-- | Xmonad shortcuts
  , ((modm .|. shiftMask, xK_e     ), io (exitWith ExitSuccess))
  , ((modm .|. shiftMask, xK_r     ), spawn "xmonad --recompile; xmonad --restart")
  , ((modm .|. shiftMask, xK_l     ), spawn "xscreensaver-command -lock")
  , ((modm .|. shiftMask, xK_s     ), spawn "xscreensaver-command -lock && sleep 2 && systemctl suspend -i")
  , ((modm              , xK_F12   ), commandPrompt fireSPConfig "command" commands)
  , ((mod1Mask          , xK_space ), windowPromptGoto defaultXPConfig { autoComplete = Just 500000 })
  , ((modm .|. shiftMask, xK_q     ), kill)

-- | Layout shortcuts
  , ((modm,               xK_space ), sendMessage NextLayout)             -- Rotate through the available layout algorithms
  , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- Reset the layouts on the current workspace to default
  , ((modm,               xK_n     ), refresh)                            -- Resize viewed windows to the correct size

  -- Move focus to the next window
  , ((modm,               xK_Tab   ), windows W.focusDown)
  , ((modm,               xK_j     ), windows W.focusDown)
  , ((modm,               xK_Right ), windows W.focusDown)

  -- Move focus to the previous window
  , ((modm,               xK_k     ), windows W.focusUp  )
  , ((modm,               xK_Left  ), windows W.focusUp  )

-- |Master window management
  , ((modm,               xK_m     ), windows W.focusMaster)   -- Move focus to the master window 
  , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)    -- Swap the focused window and the master window

  -- Swap the focused window with the next window
  , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

  -- Swap the focused window with the previous window
  , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

  -- Shrink the master area
  , ((modm,               xK_h     ), sendMessage Shrink)

  -- Expand the master area
  , ((modm,               xK_l     ), sendMessage Expand)

  -- Increment the number of windows in the master area
  , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

  -- Deincrement the number of windows in the master area
  , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

  -- Push window back into tiling
  , ((modm,               xK_t     ), withFocused $ windows . W.sink)
  ]
  ++

  --
  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  --
  [
    ((m .|. modm, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
  ]

  ++
  -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
  [
    ((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
  ]


-- | Mouse bindings: default actions bound to mouse events
mouseBindings :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
mouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList
    -- mod-button1 %! Set the window to floating mode and move by dragging
    [ ((modMask, button1), \w -> focus w >> mouseMoveWindow w
                                          >> windows W.shiftMaster)
    -- mod-button2 %! Raise the window to the top of the stack
    , ((modMask, button2), windows . (W.shiftMaster .) . W.focusWindow)
    -- mod-button3 %! Set the window to floating mode and resize by dragging
    , ((modMask, button3), \w -> focus w >> mouseResizeWindow w
                                         >> windows W.shiftMaster)
    ]