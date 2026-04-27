# Contributing to stoic-cli

First, thanks for showing up.

stoic-cli is a tiny tool with a simple mission:

> Move faster inside Git repositories.

Small and sharp tools matter. If you'd like to improve this one, you're welcome here.

---

# Ways to Contribute

You can help by:

- Fixing bugs
- Improving shell compatibility
- Making commands faster
- Improving autocomplete
- Writing docs
- Suggesting better UX
- Testing on Bash / Zsh / Linux / macOS
- Reporting weird edge cases

Even one useful issue helps.

---

# Project Philosophy

Please keep changes aligned with these values:

- Fast
- Simple
- Readable
- Minimal dependencies
- **Git-repo focused**
- Pleasant developer experience

If a feature adds complexity without real value, it probably doesn't belong.

---

# Project Structure

```
root/
  src/
    bash/       # bash specific code
    zsh/        # zsh specific code
    commands/   # commands for users
    helpers/    # reusable logic
  install.sh
  uninstall.sh
  update.sh
  readme.md
  constributions.md
  version.txt
  help.txt
```

---

# Development Guidelines

### Shell Scripts

**Code style:**
* Use the command as file name for `/src/commands/*`.
* Write or use helper function in `/src/helpers/*`.
* Every helper function should start with `stoic_cli_helper__`, i.e. `stoic_cli_helper__descriptive_name.sh`
* Every function file in `/src/commands` and `/src/helpers` should be a `.sh` file, no `bash` or `zsh` specific code.
* Helper functions are not imported in other files, instead they are copied in the `functions.sh` file at the top. see [how it works](https://github.com/whostoic/stoic-cli/blob/main/how-it-works.md)

**Please prefer:**

* Commands faster to type
* Clear naming
* Safe quoting
* Portable commands
* Readable logic

### Example

**Good**

```bash
local dir="$1"
mkdir -p "$dir"
```

**Less ideal**

```bash
mkdir -p $1
```

---

# Testing Checklist

Before opening a PR, test:

### Install

```bash
./install.sh
```

### Commands

```bash
gr
gr api
mkcd demo-folder
cdb 2
stoic version
```

### Uninstall

```bash
stoic uninstall
```

### Shell Startup

Open a new terminal and verify no errors appear.

---

# Pull Requests

**Please keep PRs:**

* Focused
* Small
* Explained clearly

**Include:**

* What changed
* Why it changed
* How you tested it

---

# Code Style

**Use simple shell style:**
```bash
if [ -z "$root" ]; then
return 1
fi
```

> Prefer readability over clever tricks.

---

# Things We Probably Don't Want
* Heavy dependencies  
* Analytics / tracking 
* Bloated frameworks 
* Magic behavior users can't understand 
* Features unrelated to repo navigation

---

# Bug Reports

**Please include:**

* OS
* Shell (bash / zsh)
* Command used
* Expected result
* Actual result
* Error output

That saves time for everyone.

---

# Final Note

This is not a big thing, but some small utilities to save time spent on writing obvious code again and again.

Thank you for using and contributing.