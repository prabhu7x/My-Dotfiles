
from ranger.api.commands import Command
class paste_as_root(Command):
	def execute(self):
		if self.fm.do_cut:
			self.fm.execute_console('shell sudo mv %c .')
		else:
			self.fm.execute_console('shell sudo cp -r %c .')

######## udisk ########

from plugins.ranger_udisk_menu.mounter import mount

####### Dragon drag and drop #######

class Drop_all_and_exit_CURRENT_DIR(Command):
	def execute(self):
			self.fm.execute_console("shell dragon -a -x %s &")

class Drop_all_and_exit_from_MULTI_DIR(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -a -x %c &')

class Drop_single_file_from_MULTI_DIR(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -k %c &')

class target(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -t %c &')

class Drop_single_file_from_CURRENT(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -k %s &')

class Drop_all_from_CURRENT_DIR_and_Stay(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -a %s &')

class Drop_all_from_MULTI_DIR_and_Stay(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -a %c &')

class Drop_single_file_CURRENT_DIR__icon(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -i %s &')

class Drop_single_MULTI_DIR__icon(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -i %c')
class Hell(Command):
	def execute(self):
			self.fm.execute_console('shell echo %c')

class Copy_Full_Path(Command):
	def execute(self):
            self.fm.execute_console(r'shell echo -n %d/%f | sed "s|/home/$USER|\$HOME|" | xclip -selection clipboard ; notify-send "Copied to clipboard"')
			# self.fm.execute_console('shell echo -n %d/%f | sed "s#/home/$USER#\$HOME#" | sed "s/ / $(printf "\\\\") /g" | xclip -selection clipboard ; notify-send "Copied to clipboard"')

class clear_filter(Command):
    def execute(self):
        self.fm.execute_console("filter")

import ranger.api
from ranger.core.loader import CommandLoader

class scr(ranger.api.commands.Command):
    def execute(self):
        # Execute the default 'open_with' command to open files in applications
        self.fm.execute_console("shell -w xdg-open -- %s" % " ".join(self.fm.thistab.get_selection()))

        # Execute the 'i3-msg move scratchpad' command to move Ranger to scratchpad
        self.fm.execute_console("shell -w i3-msg move scratchpad")


# move to scratchpad
class mov(Command):
    def execute(self):
        self.fm.execute_console("shell i3-msg move scratchpad")

# tab name change

class move_files(Command):
    def execute(self):
        self.fm.execute_console("shell zip -r -m %f %s")

# move files with password
class move_files_with_pass(Command):
    def execute(self):
        self.fm.execute_console("shell zip -e -m -r %f %s")
# zip files
class zip_files(Command):
    def execute(self):
        self.fm.execute_console("shell zip -r $PWD %s")
# zip files with password
class zip_files_with_pass(Command):
    def execute(self):
        self.fm.execute_console("shell zip -e -r $PWD %s")

#### fuzzy finder ####

class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        import subprocess
        import os.path
        if self.quantifier:
            # match only directories
            # command="find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            # -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m --reverse --header='Jump to file'"
            command = r"find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m --reverse --header='Jump to file'"
        else:
            # match files and directories
            # command="find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            # -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m --reverse --header='Jump to filemap <C-f> fzf_select'"
            command = r"find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m --reverse --header='Jump to file'"
        fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


class filter_images(Command):
    """
    :filter_images

    Filter and display only image files in the current directory.
    """
    def execute(self):
                self.fm.execute_console(r'filter ^.*\.(png|jpe?g|gif|bmp|tiff|webp)$')

class copy_image(Command):
	def execute(self):
			self.fm.execute_console('shell xclip -selection clipboard -target image/png %f')

################ kde-connect ##################
class send_files_by_device(Command):
	def execute(self):
			self.fm.execute_console("shell $HOME/scripts/kde-share-device.sh '%s'")

class send_files_global(Command):
	def execute(self):
			self.fm.execute_console('shell kdeconnect-cli --name NOTE --share %c && notify-send "sending..." ')

class send_files_current_dir(Command):
	def execute(self):
			self.fm.execute_console('shell kdeconnect-cli --name NOTE --share %s && notify-send "sending..." ')



import os
import subprocess

class FzF(Command):
    """
    :fzf_cd_parent

    Launch fzf to select a file (with a preview using bat) and change the
    current directory to the parent directory of the selected file.
    """
    def execute(self):
        # Build the fzf command with a prompt and preview using bat
        command = (
            "fzf --prompt='Select a file: ' "
            "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
        )
        # Execute the command
        fzf = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout, _ = fzf.communicate()

        # If fzf returns successfully, process the output
        if fzf.returncode == 0:
            selected_file = stdout.decode("utf-8").strip()
            if selected_file:
                parent_dir = os.path.dirname(selected_file)
                self.fm.cd(parent_dir)
