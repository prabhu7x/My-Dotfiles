from ranger.api.commands import Command

class paste_as_root(Command):
	def execute(self):
		if self.fm.do_cut:
			self.fm.execute_console('shell sudo mv %c .')
		else:
			self.fm.execute_console('shell sudo cp -r %c .')

######## udisk ########

from plugins.ranger_udisk_menu.mounter import mount

class Drop_all_and_exit_CURRENT_DIR(Command):
	def execute(self):
			self.fm.execute_console("shell dragon -a -x %s &")

class Drop_all_and_exit_from_MULTI_DIR(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -a -x %c &')

class Drag_single_file_from_MULTI_DIR(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -k %c &')

class target(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -t %c &')

class Drag_single_file_from_group_CURRENT(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -k %s &')

class Drop_all_files_from_CURRENT_DIR_and_Stay(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -a %s &')

class Drop_all_files_from_MULTI_DIR_and_Stay(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -a %c &')

class Drag_single_file_from_group_ICON_CURRENT_DIR(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -i %s &')

class Drag_single_file_from_group_ICON_MULTI_DIR(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -i %c &')

# class Copy_Full_Path(Command):
# 	def execute(self):
# 			self.fm.execute_console('shell echo -n %d/%f | sed "s|/home/$USER|\$HOME|" | xclip -selection clipboard ; notify-send "Copied to clipboard"')
# 			self.fm.execute_console('shell echo -n %d/%f | sed "s#/home/$USER#\$HOME#" | sed "s/ / $(printf "\\\\") /g" | xclip -selection clipboard ; notify-send "Copied to clipboard"')

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


from plugins.ranger_udisk_menu.mounter import mount

class Drop_all_and_exit_CURRENT_DIR(Command):
	def execute(self):
			self.fm.execute_console("shell dragon -a -x %s &")

class Drop_all_and_exit_from_MULTI_DIR(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -a -x %c &')

class Drag_single_file_from_MULTI_DIR(Command):
	def execute(self):
			self.fm.execute_console('shell dragon -k %c &')

class send_file(Command):
	def execute(self):
			self.fm.execute_console('shell read -p "Device name:" device_name && kdeconnect-cli --name "$device_name" --share %s && notify-send "sending..." &')