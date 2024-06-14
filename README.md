# "Aliash"

Handy alias snippets to use instantly on a, for example, new server.

## Getting started

`.bash_aliases` includes ones for:

- Bash (certainly)
- Git: mainly aligned to [gitalias](https://github.com/GitAlias/gitalias)
- Docker: mainly inspired by [tcnksm/docker-alias](https://github.com/tcnksm/docker-alias)

```sh
curl https://raw.githubusercontent.com/bonniss/aliash/master/.bash_aliases -o ~/.bash_aliases
cat << EOF >> ~/.bashrc
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
EOF
```

## Bonus

Use [liquidprompt](https://liquidprompt.readthedocs.io/) for better bash prompt with Git. `liquidprompt` is [available as packages on various platforms](https://liquidprompt.readthedocs.io/en/stable/install/packages.html). Example command to install on Debian (Ubuntu).

```sh
apt-get install liquidprompt
```

![liquid prompt](https://camo.githubusercontent.com/48bb90ae2c052a2e61039873bb7a44c3db0e77f70cb540e7246fe819aeea7f81/68747470733a2f2f7261772e6769746875622e636f6d2f6c697175696470726f6d70742f6c697175696470726f6d70742f6d61737465722f64656d6f2e706e67)

## Useful resources

- [Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles)
- [wrfly/bash_aliases](https://github.com/wrfly/bash_aliases)
- [gitkurwa](https://github.com/jakubnabrdalik/gitkurwa): List of aliases for long, long git commands.
- [magicmonty/bash-git-prompt](https://github.com/magicmonty/bash-git-prompt)
- [twolfson/sexy-bash-prompt](https://github.com/twolfson/sexy-bash-prompt)
- [arialdomartini/oh-my-git](https://github.com/arialdomartini/oh-my-git)
