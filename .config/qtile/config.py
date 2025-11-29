from libqtile.config import Click, Drag, Group, Key, Match, Screen
from qtile_extras.widget.decorations import RectDecoration
from libqtile.backend.wayland import InputConfig
from libqtile import bar, layout, qtile, hook
from qtile_extras import widget
from libqtile.lazy import lazy
import subprocess
import os

os.environ["HYPRSHOT_DIR"] = os.path.expanduser("~/Pictures/Screenshots")

#Useful variables
mod      : str            = "mod4"
terminal : str            = "kitty"
colors   : dict[str, str] = {
    "background"      : "#00000000",
    "filling"         : "#282738",
    "groups_current"  : "#F2003C",
    "groups_active"   : "#DA8548",
    "groups_inactive" : "#FFFFFF",
    "clock"           : "#74C7EC",
    "wlan"            : "#89B4FA",
    "memory"          : "#FF5F1F",
    "battery"         : "#DA8548",
    "volume"          : "#A6E3A1",
    "power"           : "#FF5F1F",
}


@hook.subscribe.startup_once
def autostart() -> None:
    script_path = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call(script_path)


def wrap_terminal(command: str) -> str:
    return f"{terminal} {command}"


def wrap_wayland(command: str) -> str:
    if qtile.core.name == "wayland":
        return command + " --enable-features=UseOzonePlatform --ozone-platform=wayland"
    return command


keys : list[Key] = [
    #Qtile builtin keybindings
    Key([mod],            "h",       lazy.layout.left(),              desc="Move focus to left"),
    Key([mod],            "l",       lazy.layout.right(),             desc="Move focus to right"),
    Key([mod],            "j",       lazy.layout.down(),              desc="Move focus down"),
    Key([mod],            "k",       lazy.layout.up(),                desc="Move focus up"),
    Key([mod],            "space",   lazy.layout.next(),              desc="Move window focus to other window"),
    Key([mod, "shift"],   "h",       lazy.layout.shuffle_left(),      desc="Move window to the left"),
    Key([mod, "shift"],   "l",       lazy.layout.shuffle_right(),     desc="Move window to the right",),
    Key([mod, "shift"],   "j",       lazy.layout.shuffle_down(),      desc="Move window down"),
    Key([mod, "shift"],   "k",       lazy.layout.shuffle_up(),        desc="Move window up"),
    Key([mod, "control"], "h",       lazy.layout.grow_left(),         desc="Grow window to the left"),
    Key([mod, "control"], "l",       lazy.layout.grow_right(),        desc="Grow window to the right"),
    Key([mod, "control"], "j",       lazy.layout.grow_down(),         desc="Grow window down"),
    Key([mod, "control"], "k",       lazy.layout.grow_up(),           desc="Grow window up"),
    Key([mod],            "n",       lazy.layout.normalize(),         desc="Reset all window sizes"),
    Key([mod, "shift"],   "Return",  lazy.layout.toggle_split(),      desc="Toggle between split and unsplit sides of stack",),
    Key([mod],            "Tab",     lazy.next_layout(),              desc="Toggle between layouts"),
    Key([mod, "shift"],   "c",       lazy.window.kill(),              desc="Kill focused window"),
    Key([mod],            "f",       lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window",),
    Key([mod],            "t",       lazy.window.toggle_floating(),   desc="Toggle floating on the focused window",),
    Key([mod, "control"], "r",       lazy.reload_config(),            desc="Reload the config"),
    Key([mod, "shift"],   "q",       lazy.shutdown(),                 desc="Shutdown Qtile"),

    #Spawn apps
    Key([mod],            "Return",  lazy.spawn(terminal),                 desc="Launch terminal"),
    Key([mod, "shift"],   "t",       lazy.spawn("telegram"),               desc="Open telegram"),
    Key([mod, "shift"],   "v",       lazy.spawn(wrap_wayland("vivaldi")),  desc="Open vivaldi browser",),
    Key([mod, "shift"],   "o",       lazy.spawn(wrap_wayland("obsidian")), desc="Open obsidian"),
    Key([mod, "shift"],   "d",       lazy.spawn(wrap_wayland("discord")),  desc="Open discord"),
    Key([mod, "shift"],   "n",       lazy.spawn(wrap_terminal("nvim")),    desc="Open neovim"),

    #Screenshot
    Key(["shift"],        "print",   lazy.spawn("hyprshot -m region --clipboard-only"), desc="Screenshot to clipboard",),
    Key([],               "print",   lazy.spawn("hyprshot -m region"),                  desc="Screenshot to image"),

    #Switch keyboard layout
    Key(["mod1"],         "shift_l", lazy.widget["customkeyboardlayout"].toggle_layout(), desc="Next keyboard layout",),
    Key(["shift"],        "alt_l",   lazy.widget["customkeyboardlayout"].toggle_layout(), desc="Next keyboard layout",),
]

#Switch to TTY
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

groups : list[Group] = [Group(i) for i in "123456789"]
for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
        ]
    )


layouts : list = [
    layout.Columns(
        border_focus=colors["groups_active"],
        border_normal="#000000",
        border_width=4,
        margin=5,
        margin_on_single=10,
    ),
    layout.Max(),
]


#Oval around widgets
powerline : dict = {
    "decorations": [RectDecoration(colour=colors["filling"], radius=18, filled=True, group=True)],
    "padding": 10,
}
widget_defaults : dict[str, str | int] = {
    "font": "JetBrainsMono Nerd Font Bold",
    "fontsize": 20,
    "padding": 6,
}
extension_defaults : dict[str, str | int] = widget_defaults.copy()

small_spacer       : widget.Spacer        = widget.Spacer(length=12, background=colors["background"])
big_spacer         : widget.Spacer        = widget.Spacer(background=colors["background"])

screens : list[Screen] = [
    Screen(
        top=bar.Bar(
            [
                widget.Image(
                    filename="~/.config/qtile/arch.png",
                    background=colors["background"],
                ),
                small_spacer,
                widget.GroupBox(
                    fontsize=28,
                    highlight_method="block",
                    active=colors["groups_active"],
                    block_highlight_text_color=colors["groups_current"],
                    highlight_color=colors["filling"],
                    inactive=colors["groups_inactive"],
                    background=colors["background"],
                    this_current_screen_border=colors["filling"],
                    this_screen_border=colors["filling"],
                    other_current_screen_border=colors["filling"],
                    other_screen_border=colors["filling"],
                    urgent_border=colors["filling"],
                    rounded=True,
                    disable_drag=True,
                    **powerline,
                    margin_x=14,
                ),
                big_spacer,
                widget.Clock(
                    format=" %d.%m.%Y | %H:%M  ",
                    background=colors["background"],
                    foreground=colors["clock"],
                    **powerline,
                ),
                big_spacer,
                widget.Wlan(
                    background=colors["background"],
                    foreground=colors["wlan"],
                    format="{essid}",
                    fmt="  {}",
                    **powerline,
                ),
                small_spacer,
                widget.StatusNotifier(
                    background=colors["background"], 
                    **powerline
                ),
                small_spacer,
                widget.Memory(
                    background=colors["background"],
                    measure_mem="G",
                    format="{NotAvailable: .2f}G",
                    foreground=colors["memory"],
                    update_interval=2,
                    fmt=" {}",
                    **powerline,
                ),
                small_spacer,
                widget.Battery(
                    background=colors["background"],
                    foreground=colors["battery"],
                    format="{percent:2.0%}",
                    fmt="\uf241  {}",
                    update_interval=10,
                    **powerline,
                ),
                small_spacer,
                widget.Volume(
                    background=colors["background"],
                    foreground=colors["volume"],
                    update_interval=0.2,
                    unmute_format="{volume}%",
                    mute_format="M",
                    fmt="  {}",
                    **powerline,
                ),
                small_spacer,
                widget.CustomKeyboardLayout(
                    en_text="🇺🇸",
                    ru_text="🇷🇺",
                    background=colors["background"],
                    **powerline,
                ),
                small_spacer,
                widget.QuickExit(
                    background=colors["background"],
                    foreground=colors["power"],
                    font="sans",
                    fontsize=40,
                    decorations=[RectDecoration(colour=colors["filling"], radius=18, filled=True, group=False)],
                    padding=12,
                    fmt="⏻",
                ),
            ],
            36,
            background=colors["background"],
            border_width=[0, 0, 0, 0],
            margin=[18, 10, 8, 10],
        ),
    ),
]


mouse : list = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], 
        "Button3", 
        lazy.window.set_size_floating(), 
        start=lazy.window.get_size()
    ),
    Click(
        [mod], 
        "Button2", 
        lazy.window.bring_to_front()
    ),
]


#Settings
dgroups_key_binder  : None = None
dgroups_app_rules   : list = []
follow_mouse_focus  : bool = True
bring_front_click   : bool = False
floats_kept_above   : bool = True
cursor_warp         : bool = False
reconfigure_screens : bool = True
auto_fullscreen     : bool = True
auto_minimize       : bool = True

focus_on_window_activation : str = "smart"
wl_xcursor_theme           : str = "Bibata-Original-Amber"
wl_xcursor_size            : int = 32

#Which windows will always be floating
floating_layout : layout.Floating = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
    ]
)

#Hardware settings
wl_input_rules : dict[str] = {
    "type:keyboard": InputConfig(
        kb_layout="us,ru",
        kb_options="grp:alt_shift_toggle,caps:swapescape",
    ),
    "type:touchpad": InputConfig(tap=True, natural_scroll=True),
}
