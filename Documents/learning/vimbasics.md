- [Find and replace](#find-and-replace.)
- [Run Shell commands](#shell-commands)

### find and replace.
:[range]s/{pattern}/{string}/[flags] [count]

- to repalce a word in a line 
:s /existing word/new word

- to replace in entire line 

    - `:s /existing word/new word/g`

- To replace n line to n line 
>    - :n,ns/new/old/g
>
>   - eg:5,10s/new/old/g

- wth regular expressions
The dot . character indicates the current line and $ - the dollar sign the last line.
To substitute ‘foo’ in all lines starting from the current line to the last one:

    - :.,$s/foo/bar/

- The line specifier can also be set using the ‘+’ or ‘-’ symbol,followed by a number that is added or subtracted from the preceding line number. If the number after the symbol is omitted, it defaults to 1.

- For example to substitute each ‘foo’ with ‘bar’ starting from the current line and the four next lines, type:

    - :.,+4s/foo/bar/g

- To replace in entire file
    - :%s/new/old/g

- select manually in VISUAL MODE	and do the same things.

- To confirm each substitution, use the c flag:

    - :s/old/new/gc

>- replace with bar (y/n/a/q/l/^E/^Y)?
>
>Press y to replace the match or l to replace the match and quit. Press n to skip the match and q or Esc to quit substitution.
The a option substitutes the match and all remaining occurrences of the match.
To scroll the screen down, use CTRL+Y, and to scroll up, use CTRL+E.

> If the {string} part is omitted, it is considered as an empty string, and the matched pattern is deleted.
The following command deletes all instances of the string ‘foo’ in the current line:

>   - :s/old//g

> Case Sensitivity #
>
> By default, the search operation is case sensitive; searching for “FOO” will not match “Foo”.
>
> To ignore case for the search pattern, use the i flag:
>
> - :s/Foo/bar/gi
>
> Another way to force ignore case is to append \c after the search pattern. For example, /Linux\c performs ignore case search.
>
>If you changed the default case setting and you want to perform case sensitive search, use the I flag:
>
> - :s/foo/bar/gi
>
>Uppercase \C after the pattern also forces case match search.


- Advance usage

- - Examples

- Comment lines (add # before the line) from 5 to 20:

    - :5,20s/^/#/

- Uncomment lines from 5 to 20, revert the previous changes:

    - :5,20s/^#//

- Replace all instances of ‘apple’, ‘orange’, and ‘mango’ with ‘fruit’:

    - :%s/apple\|orange\|mango/fruit/g

- Remove trailing whitespace at the end of each line:

     - :%s/\s\+$//e

>- Substituting Whole Word
>
>The substitute command looks for the pattern as a string, not a whole word. If, for example, you were searching for “gnu”, the search find matches where “gnu” is embedded in larger words, such as “cygnus” or “magnum”.

- To search for a whole word, type \< to mark the beginning of a word, enter the search pattern, type \> to mark the end of a word:

- For example, to search for the word “foo” you would use \<foo\>:

    - :s/\<foo\>/bar/

- copy text to systemclipboard
install gvim and copied text automatically sent to  systemclipboard	
    - or :"+y


## shell commands

- click `!!` in normal mode and then it will let you type shell commands in vim command line.

- yank text with register
    - "{register}y
- to paste
    - "{register}p
- To view the contents of all registers, use the :reg command:

- Accessing Yanked Text

> By default, yanked text is stored in the unnamed register (""). However, Vim also stores the most recent yanked text in the yank register ("0), which is useful if you overwrite the unnamed register with a delete or change operation.

    - "0p: Paste the most recently yanked text (from the 0 register).

    - ""p: Paste from the unnamed register (which may contain the last yanked or deleted text).

Special Register

Vim has several special registers:

    "": Unnamed register (default for yank, delete, and change operations).

    "0: Yank register (stores the most recently yanked text).

    "1-"9: Numbered registers (store deleted or changed text, with "1 being the most recent).

    "+: System clipboard register (for copying to/pasting from the system clipboard).

    "*: Primary selection register (for X11 clipboard).

