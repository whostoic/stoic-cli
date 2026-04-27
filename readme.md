# stoic-cli

Shell utilities to navigate large git repos faster and reduce repetitive typing.

---

## Features

* `cdb`  > jump backward multiple directories
* `gr`  > jump to repo root + fuzzy navigate inside it
* `shc` > jump to predefined paths
* `mkcd` > create a directory and jump inside
* Works with **bash** and **zsh**
* Optional **fzf integration** for fast selection
* Tab completion support

---

## Installation

### 1. Clone the repo

```bash
git clone https://github.com/whostoic/stoic-cli.git && cd ./stoic-cli && chmod +x install.sh && ./install.sh
```

### 3. Restart your terminal or run:

```bash
source ~/.bashrc   # or ~/.zshrc
```

---

## Optional: Install fzf (recommended)

### macOS

```bash
brew install fzf && $(brew --prefix)/opt/fzf/install
```

### Linux

```bash
sudo apt install fzf # or > sudo dnf install fzf (fedora, centos, rhel, etc.) 
```

or see installation here > https://github.com/junegunn/fzf#installation

---

## Usage

### `cdb` > Go back directories

```bash
cdb        # cd ../
cdb 2      # cd ../../
cdb 3      # cd ../../../
```

---

### `gr` > Jump inside repo

From anywhere inside your repo:
> [ ! ] `gr` works **only inside Git repositories**. It will explicitly fail if used outside one.

```bash
gr            # go to repo root
gr apps       # go to root/apps
gr web        # fuzzy match (e.g. apps/web)
gr ui         # fuzzy match (e.g. packages/ui)
gr ty         # fuzzy match (e.g. packages/typescript-config)
```

> [ i ] `gr` fuzzy navigation excludes directories inside `.gitignore`, except if the exact path to the directory is provided as the argument.

If multiple matches exist:

* Uses `fzf` if installed
* Otherwise prints options

---

### `mkcd` > `mkdir` and `cd` in one command

```bash
mkcd app	# mkdir app && cd app
```

---

### `shc` > Jump to predefined paths

Use `shc` as shortcuts manager. To use this:

* Create a `.stoic-shortcuts` file in your git repo root.
* Add shortcuts like below:

```
web=apps/web
mig=packages/database/migrations
com=packages/ui/src/components
 ^       ^
key     path
```

> [ i ] `path` should be relative to the repo root.

> [ ! ] `shc` works **only inside Git repositories**. It will explicitly fail if used outside one.

---

## How it works

* Detects repo root via `git`
* Falls back to `apps/` or `packages/` structure
* Uses `find` + fuzzy matching for navigation

---

## Why?

Reduce:

* Repetitive `cd ../../..`
* Manual searching in large monorepos
* Typing multiple command to complete on action
* Keyboard wear ;)

---

## Update

Run `stoic update` to download and install the latest version of stoic-cli.

---

## Uninstall

An executable file is stored at `~/.stoic-cli/uninstall.sh`, run this file or the below command.

```bash
stoic uninstall
```

> If the `uninstall.sh` file is deleted by mistake or is no longer available:
>  * Either reinstall this tool and then uninstall (recommended)
>  * or create shell file in your `~/` directory and copy the content of the `uninstall.sh` file to your created file. Then make it executable and run the file.

---

## Conclusion

* Run `stoic` for help.
* Create an issue for bugs or feature requests.
* See `contributions.md`.