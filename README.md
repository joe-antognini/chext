# chext -- Change a file's extension

`chext` is a simple shell utility to change the extension of a file or list
of files.

## Options

`-i` -- Interactive mode.  Prompts for confirmation before moving a file
that would overwrite an existing file.

`-v` -- Verbose mode.  Show the original and final filename.

## Examples

```
$ # Change the extension of a single file
$ touch foo.bar
$ chext foo.bar baz
$ ls
foo.baz

$ # Change the extension of multiple files
$ touch qux.baz
$ chext *.baz bar
$ ls
foo.bar qux.bar

$ # Verbose mode
$ chext -v *.bar baz
foo.bar -> foo.baz
qux.bar -> qux.baz

$ # Prompt before overwriting a file
$ touch qux.bit
$ chext -i qux.* bar
overwrite qux.bar? (y/n [n])
not overwritten
$ ls
foo.baz qux.bar qux.bit

$ # chext handles multiple extensions
$ rm *
$ touch foo.bar.baz
$ chext foo.bar.baz qux
$ ls
foo.bar.qux

$ # chext doesn't get confused by hidden files
$ touch .foo
$ chext .foo bar
chext: change extension of .foo to bar: File has no extension
```
