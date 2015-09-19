import System.Taffybar

import System.Taffybar.Systray
import System.Taffybar.TaffyPager
import System.Taffybar.SimpleClock
import System.Taffybar.FreedesktopNotifications
{-import System.Taffybar.Battery-}
import System.Taffybar.Weather
import System.Taffybar.MPRIS
import System.Taffybar.NetMonitor

import System.Taffybar.Widgets.PollingBar
import System.Taffybar.Widgets.PollingGraph

import System.Information.Memory
import System.Information.CPU

import MyBattery

-- Used for myPagerConfig
import Graphics.UI.Gtk (escapeMarkup)
import Graphics.X11.Types
import Graphics.X11.Xlib.Extras
import Text.Printf (printf)

-- | Escape strings so that they can be safely displayed by Pango in the
-- bar widget
escape :: String -> String
escape = escapeMarkup

emptyS :: String -> String
emptyS s
   | True = ""

-- | Creates markup with the given foreground and background colors and the
-- given contents.
colorize :: String -- ^ Foreground color.
         -> String -- ^ Background color.
         -> String -- ^ Contents.
         -> String
colorize fg bg = printf "<span%s%s>%s</span>" (attr "fg" fg) (attr "bg" bg)
  where attr name value
          | null value = ""
          | otherwise  = printf " %scolor=\"%s\"" name value

-- | Limit a string to a certain length, adding "..." if truncated.
shorten :: Int -> String -> String
shorten l s
  | length s <= l = s
  | l >= 3        = take (l - 3) s ++ "..."
  | otherwise     = "..."

-- | Wrap the given string in the given delimiters.
wrap :: String -- ^ Left delimiter.
     -> String -- ^ Right delimiter.
     -> String -- ^ Output string.
     -> String
wrap open close s = open ++ s ++ close

memCallback = do
  mi <- parseMeminfo
  return [memoryUsedRatio mi]

cpuCallback = do
  (userLoad, systemLoad, totalLoad) <- cpuLoad
  return [totalLoad, systemLoad]

myPagerConfig :: PagerConfig
myPagerConfig = PagerConfig
  { activeWindow     = escape . shorten 50
  , activeLayout     = wrap " " " " . escape
  , activeWorkspace  = colorize "yellow" "" . wrap "[" "]" . escape
  , hiddenWorkspace  = escape
  , emptyWorkspace   = emptyS
  , visibleWorkspace = wrap "(" ")" . escape
  , urgentWorkspace  = colorize "red" "yellow" . escape
  , widgetSep        = "  :  "
  }

myNetFormat :: String
myNetFormat = "▼ $inKB$kb/s   ▲ $outKB$kb/s"

myPager = taffyPagerNew myPagerConfig

main = do
  let memCfg = defaultGraphConfig { graphDataColors = [(1, 0, 0, 1)]
                                  , graphLabel = Just "mem"
                                  }
      cpuCfg = defaultGraphConfig { graphDataColors = [ (0, 1, 0, 1)
                                                      , (1, 0, 1, 0.5)
                                                      ]
                                  , graphLabel = Just "cpu"
                                  }
  let clock = textClockNew Nothing "<span fgcolor='orange'>%a %b %_d %H:%M:%S</span>" 1
      pager = myPager
      note = notifyAreaNew defaultNotificationConfig
      wea = weatherNew (defaultWeatherConfig "VILK") {weatherTemplate = "$tempC$°C @ $humidity$ hum"} 10
      mpris = mprisNew defaultMPRISConfig
      mem = pollingGraphNew memCfg 1 memCallback
      cpu = pollingGraphNew cpuCfg 0.5 cpuCallback
      wnet = netMonitorNewWith 10 "wlp8s0" 1 myNetFormat
      enet = netMonitorNewWith 10 "enp9s0" 1 myNetFormat
      batt  = batteryBarNew defaultBatteryConfig 30
      tray = systrayNew
  defaultTaffybar defaultTaffybarConfig { startWidgets = [ pager, note ]
                                        , endWidgets = [ tray, wea, clock, mem, cpu, batt, enet, wnet, mpris ]
                                        }
