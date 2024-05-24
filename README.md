## Scripts
A small collection of scripts. Anything using Rofi may need my custom themes to set the width. All you have to do is either delete `-theme <option>` from the Rofi command, or copy *small.rasi* and *fullscreen.rasi* from *~/.config/rofi/* and edit the line which imports the theme you are currently using. If you're using my theme, everything should work.

+ **./.local/bin/bup :** A simple script for creating a backup of a file, or a dated backup with an optional note.
+ **./.local/bin/mkeys.sh :** Putting all the media commands in one place.
+ **./.local/bin/podget3.sh :** A script which uses Rofi as a dialogue for downloading podcasts to a preset dir with wget (cliphist, rofi, wget)
+ **./.local/bin/rofi_exit.sh :** Uses Rofi as a shut down/logout dialogue. (rofi)
+ **./.local/bin/sway_focus_move.sh :** If the focused window is tiled, focus will be moved in the direction of hjkl, if it's floating, it will be moved to one of four preset coords.
+ **./.local/bin/sway_scratchpads.sh :** Have three named scratchpads and one generic one, see also waybar_scratchpads.sh
+ **./.local/bin/waybar_bettermem.sh :** A simple memory widget that puts swap icon alongside memory icon
+ **./.local/bin/waybar_scratchpads.sh :** Shows an individual icon for each named scratchpad as well as the unnamed one (works with sway_scratchpads.sh)
+ **./.local/bin/waybar_temp.sh :** A cpu temp widget that will only show the fan speed if it's spinning. Also has alert levels.
+ **./.local/bin/waybar_utils.sh :** Puts volume, backlight and battery in the same little bubble.
+ **./.local/bin/ytd.sh :** Use Rofi as a dialogue for yt-dlp, taking the most recent clipboard entry and prompting the user to select a format, then a download sub directory. (cliphist, yt-dlp, rofi)

## Config files
+ **./.config/rofi/ :** A modified version of the Arc Dark theme with colours to match my waybar and dunst, along with a couple of theme files for different Rofi window sizes
+ **./.config/sway/config :** A fairly unspectacular config but it will give context to the scripts
+ **./.config/waybar/config :** nothing really so special
+ **./.config/waybar/style.css :** It looks nice I think
+ **./.zshrc :** Very basic case insensitive completion, open the current command in nvim, sets nvim as the man page reader. Also contains a bunch of aliases and functions.
