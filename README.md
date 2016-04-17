# Josh W Lewis' dotfiles

Thanks to [Matias' dotfiles](https://github.com/mathieasbynens/dotfiles) for
the template and inspiration.

## Installation

**Warning:** This will overwrite your existing dotfiles. Back them up!

```bash
git clone https://github.com/joshwlewis/dotfiles.git && cd dotfiles && source bootstrap.sh
```

## Updating

The bootstrap script symlinks your dotfiles. So you can just update this repo
with `git pull`.

### Specify the `$PATH`

If `~/.path` exists, it will be sourced along with the other files, before any feature testing (such as [detecting which version of `ls` is being used](https://github.com/mathiasbynens/dotfiles/blob/aff769fd75225d8f2e481185a71d5e05b76002dc/.aliases#L21-26)) takes place.

Here’s an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```bash
export PATH="/usr/local/bin:$PATH"
```

### Add custom commands without creating a new fork

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.
