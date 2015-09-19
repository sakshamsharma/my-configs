module Startup where

import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Cursor
import XMonad.Util.SpawnOnce

myStartup :: X ()
myStartup = do
  ewmhDesktopsStartup
  setDefaultCursor xC_left_ptr
  spawnOnce "taffybar"
  spawnOnce "nm-applet"
  spawnOnce "pasystray"
  spawnOnce "xscreensaver -no-splash"
  spawnOnce "conky -c ~/.conky/sideconky &"
  spawn "xrdb -merge ~/.Xresources"
