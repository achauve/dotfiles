from System.Drawing import Color, Font
from System.Linq import Enumerable
from Windawesome import ILayout, TileLayout, FullScreenLayout, FloatingLayout, IPlugin, Workspace
from Windawesome import Bar, LayoutWidget, WorkspacesWidget, ApplicationTabsWidget, SystemTrayWidget, CpuMonitorWidget, RamMonitorWidget, LaptopBatteryMonitorWidget, LanguageBarWidget, SeparatorWidget
from Windawesome import LoggerPlugin, ShortcutsManager, InputLanguageChangerPlugin
from Windawesome.NativeMethods import MOD
from System import Tuple
from System.Windows.Forms import Keys



def tile_layout():
    return TileLayout(masterAreaAxis = TileLayout.LayoutAxis.LeftToRight, masterAreaWindowsCount = 1, masterAreaFactor = 0.5)


def onLayoutLabelClick():
	if windawesome.CurrentWorkspace.Layout.LayoutName() == "Full Screen":
		windawesome.CurrentWorkspace.ChangeLayout(FloatingLayout())
	elif windawesome.CurrentWorkspace.Layout.LayoutName() == "Floating":
		windawesome.CurrentWorkspace.ChangeLayout(tile_layout())
	else:
		windawesome.CurrentWorkspace.ChangeLayout(FullScreenLayout())

config.WindowBorderWidth = 1
config.WindowPaddedBorderWidth = 0

workspacesWidgetForegroundColors = [Color.Yellow for i in range(0, 10)]
workspacesWidgetForegroundColors[0] = Color.LightSeaGreen
workspacesWidgetBackgroundColors = [Color.Black for i in range(0, 10)]


def create_bar(monitor):
	return Bar(windawesome.monitors[monitor],
		[
			WorkspacesWidget(
				normalForegroundColor = workspacesWidgetForegroundColors,
				normalBackgroundColor = workspacesWidgetBackgroundColors,
				highlightedForegroundColor = Color.DarkOrange,
				highlightedBackgroundColor = Color.Black,
				highlightedInactiveForegroundColor = Color.LightSeaGreen,
				highlightedInactiveBackgroundColor = Color.Black,
				flashingForegroundColor = Color.Black
			),
			LayoutWidget(
				foregroundColor = Color.Gold,
				backgroundColor = Color.Black,
				onClick = onLayoutLabelClick
			)
		],

		[
			SystemTrayWidget(),
			LanguageBarWidget(
				foregroundColor = Color.Gold,
				backgroundColor = Color.Black
			),
			SeparatorWidget(
				foregroundColor = Color.Gold,
				backgroundColor = Color.Black
			),
			DateTimeWidget("ddd, d-MMM", "", "", Color.Black, Color.Gold),
			SeparatorWidget(
				foregroundColor = Color.Gold,
				backgroundColor = Color.Black
			),
			DateTimeWidget("HH:mm tt", "", "", Color.Black, Color.Gold),
		],

		[
			ApplicationTabsWidget(
				normalForegroundColor = Color.LightSeaGreen,
				normalBackgroundColor = Color.Black,
				highlightedForegroundColor = Color.DarkOrange,
				highlightedBackgroundColor = Color.Black,
			)
		],

		backgroundColor = Color.Black,
		font = Font("Consolas", 11)
	)

all_bars = [ create_bar(monitor=0) ]
if len(windawesome.monitors) > 1:
    all_bars.append(create_bar(monitor=1))

config.Bars = Enumerable.ToArray[Bar](all_bars)



snd_monitor = 1 if len(windawesome.monitors) > 1 else 0

config.Workspaces = Enumerable.ToArray[Workspace]([
	Workspace(windawesome.monitors[0], FullScreenLayout(), [config.Bars[0]], name='1 main'),
	Workspace(windawesome.monitors[0], tile_layout(), [config.Bars[0]], name='2'),
	Workspace(windawesome.monitors[0], tile_layout(), [config.Bars[0]], name='3'),
	Workspace(windawesome.monitors[0], tile_layout(), [config.Bars[0]], name='4'),
	Workspace(windawesome.monitors[0], tile_layout(), [config.Bars[0]], name='5'),

	Workspace(windawesome.monitors[snd_monitor], FullScreenLayout(), [config.Bars[snd_monitor]], name='6 mail'),
	Workspace(windawesome.monitors[snd_monitor], FullScreenLayout(), [config.Bars[snd_monitor]], name='7 web'),
	Workspace(windawesome.monitors[snd_monitor], tile_layout(), [config.Bars[snd_monitor]], name='8 '),
	Workspace(windawesome.monitors[snd_monitor], tile_layout(), [config.Bars[snd_monitor]], name='9 '),


	# Workspace(windawesome.monitors[0], FullScreenLayout(), [config.Bars[0]]),
	# Workspace(windawesome.monitors[0], TileLayout(masterAreaAxis = TileLayout.LayoutAxis.TopToBottom, masterAreaWindowsCount = 2, masterAreaFactor = 0.5), [config.Bars[0]], name = 'chat'),
	# Workspace(windawesome.monitors[0], FullScreenLayout(), [config.Bars[0]]),
	# Workspace(windawesome.monitors[0], FullScreenLayout(), [config.Bars[0]]),
	# Workspace(windawesome.monitors[0], FullScreenLayout(), [config.Bars[0]]),
	# Workspace(windawesome.monitors[0], FullScreenLayout(), [config.Bars[0]], name = 'mail'),
	# Workspace(windawesome.monitors[0], FullScreenLayout(), [config.Bars[0]], name = 'BC')
])

starting_workspaces = [ config.Workspaces[0] ]
if len(windawesome.monitors) > 1:
    starting_workspaces.append(config.Workspaces[5])
config.StartingWorkspaces = starting_workspaces


config.Plugins = [
	#LoggerPlugin(logWorkspaceSwitching = True, logWindowMinimization = True, logWindowRestoration = True,
	#	logActivation = True),
	ShortcutsManager(),
	InputLanguageChangerPlugin(["icoicq", "icoSKYPE", "icoGOOGLE", "icoChannel", "icoJabber"])
]
