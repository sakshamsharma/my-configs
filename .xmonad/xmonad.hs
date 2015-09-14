import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.CycleWS
import XMonad.Layout.Spacing
import System.IO
import Data.Monoid
import System.Exit
import XMonad.Util.Scratchpad
import XMonad.Util.NamedScratchpad

import XMonad.Prompt
import XMonad.Prompt.Ssh
import XMonad.Prompt.Window
import XMonad.Prompt.Workspace
import XMonad.Prompt.Input

import XMonad.Hooks.EwmhDesktops        (ewmh)
import System.Taffybar.Hooks.PagerHints (pagerHints)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

scratchpads = [ NS "gvim" "gvim" (className =? "Gvim") (customFloating $ W.RationalRect (0) (0) (0) (0)) ]

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

  [
  -----------------------
  -- App launchers
  -----------------------
    ((modm,               xK_d     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"") -- launch dmenu
  , ((modm .|. shiftMask, xK_d     ), spawn "gmrun")                                          -- launch gmrun (better dmenu)
  , ((modm,               xK_Return), spawn $ XMonad.terminal conf)                           -- launch terminal
  , ((modm,               xK_F1    ), spawn "google-chrome-stable")                           -- launch chrome
  , ((modm,               xK_F3    ), spawn "pcmanfm")                                        -- launch file manager

  -- media keys
  , ((mod1Mask          , xK_3),  spawn "amixer -q set Master 5%-")
  , ((mod1Mask          , xK_4),  spawn "amixer -q set Master 5%+")


  ------------------------
  -- Workspace shortcuts
  ------------------------
  , ((modm     , xK_f), moveTo Next EmptyWS)  -- find a free workspace
  , ((mod1Mask,           xK_Down),  nextWS)  -- alt+down moves to next workspace
  , ((mod1Mask,           xK_Up),    prevWS)  -- alt+up moves to prev workspace

  -- close focused window
  , ((modm .|. shiftMask, xK_q     ), kill)

  --------------------
  -- Xmonad shortcuts
  --------------------
  , ((modm .|. shiftMask, xK_e     ), io (exitWith ExitSuccess))
  , ((modm              , xK_r     ), spawn "xmonad --recompile; xmonad --restart")
  , ((modm .|. shiftMask, xK_l     ), spawn "xscreensaver-command -lock")
  , ((modm .|. shiftMask, xK_s     ), spawn "xscreensaver-command -lock && sleep 2 && systemctl suspend -i")
  , ((modm              , xK_F12   ), workspacePrompt  defaultXPConfig (windows . W.greedyView))

  --------------------
  -- layout shortcuts
  --------------------
  , ((modm,               xK_space ), sendMessage NextLayout)             -- Rotate through the available layout algorithms
  , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) --  Reset the layouts on the current workspace to default

  -- Resize viewed windows to the correct size
  , ((modm,               xK_n     ), refresh)

  -- Move focus to the next window
  , ((modm,               xK_Tab   ), windows W.focusDown)

  -- Move focus to the next window
  , ((modm,               xK_j     ), windows W.focusDown)

  -- Move focus to the previous window
  , ((modm,               xK_k     ), windows W.focusUp  )

  -- Move focus to the master window
  , ((modm,               xK_m     ), windows W.focusMaster  )

  -- Swap the focused window with the next window
  , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

  -- Swap the focused window with the previous window
  , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

  -- Shrink the master area
  , ((modm,               xK_h     ), sendMessage Shrink)

  -- Expand the master area
  , ((modm,               xK_l     ), sendMessage Expand)

  -- Push window back into tiling
  , ((modm,               xK_t     ), withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area
  , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

  -- Deincrement the number of windows in the master area
  , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

  -- scratchpad
  , ((modm,  xK_s ),  namedScratchpadAction scratchpads "gvim")
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

myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#0000ff"

myStartup :: X ()
myStartup = do
  spawn "conky -c ~/.conky/sideconky &"

myManagementHooks :: [ManageHook]
myManagementHooks = [
  resource =? "trayer" --> doIgnore
  , scratchpadManageHook (W.RationalRect 0.125 0.25 0.75 0.5)
  ]

myLayout = tiled ||| stiled ||| Mirror tiled ||| Full
 where
  -- default tiling algorithm partitions the screen into two panes
  tiled = Tall nmaster1 delta ratio

  stiled = spacing 5 $ Tall nmaster2 delta ratio
  -- The default number of windows in the master pane
  nmaster1 = 1

  nmaster2 = 2
  -- Default proportion of screen occupied by master pane
  ratio = 4/7
  -- Percent of screen to increment by when resizing panes
  delta = 5/100

main = do
  {-xmproc <- spawnPipe "/usr/bin/xmobar /home/saksham/.xmobarrc"-}
  xmonad $ ewmh $ pagerHints $ defaultConfig {
    manageHook = manageDocks <+> manageHook defaultConfig <+> composeAll myManagementHooks,
    layoutHook = avoidStruts  $ myLayout,
--  logHook = dynamicLogWithPP xmobarPP
--  {
--    ppOutput = hPutStrLn xmproc,
--    ppTitle = xmobarColor "green" "" . shorten 50
--  },
    keys               = myKeys,
    workspaces         = myWorkspaces,
    startupHook        = myStartup,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,

    modMask = mod4Mask,     -- Rebind Mod to the Windows key
    terminal = "urxvt"
  }

  {-`additionalKeys`-}
    {-[ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")-}
    {-, ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")-}
    {-, ((0, xK_Print), spawn "scrot")-}
    {-]-}
