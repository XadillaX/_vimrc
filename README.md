# XadillaX' Vimrc

## Installation

Clone the project first:

```sh
$ git clone git@github.com:XadillaX/_vimrc.git
```

Install [dein.vim](https://github.com/Shougo/dein.vim).

```sh
$ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
$ sh ./installer.sh ~/.cache/dein
$ rm installer.sh
```

Open NeoVIM and run:

```viml
:call dein#clear_state()
:call dein#install()
```

Enjoy!
