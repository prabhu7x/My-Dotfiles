# OneDark colorscheme for Ranger (based on Atom's One Dark)
from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class OneDark(ColorScheme):
    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        # Directory
        if context.directory:
            fg = 73 # Light blue
            # bg = 215
            # fg+= BRIGHT
            attr |= bold

        # Executable file
        elif context.executable and not any((context.media, context.container, context.fifo, context.socket)):
            fg = 118  # Green
            attr |= bold

        # Symlink
        elif context.link:
            fg = 212  # Pink
            attr |= bold

        # Media files
        elif context.media:
            if context.image:
                fg = 215  # Orange
            else:
                fg = 204  # Purple

        # Special files
        elif context.socket:
            fg = 223  # Peach
        elif context.fifo or context.device:
            fg = 187  # Light yellow

        # Text files
        elif context.document:
            fg = 252  # Nearly white

        # Archives
        elif context.container:
            fg = 173  # Brown

        # Selected item
        if context.selected:
            attr |= reverse
            bg = 51 
            fg = 0

        # Marked item
        if context.marked:
            attr |= bold
            fg = 220  # Yellow
        if context.marked and context.selected:
            fg = 226
            bg = 0
            # fg += BRIGHT
            attr = bold             # Bold text


        # Bad permissions
        if context.bad:
            fg = 160  # Red
            attr |= bold

        return fg, bg, attr