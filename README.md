# config

My config files, kept in git so I can share them across machines.

## Usage

```sh
./sync.sh push   # repo -> machine
./sync.sh pull   # machine -> repo
```

`push` skips a file if its destination directory doesn't exist (e.g. the app
isn't installed). `pull` skips a file if it doesn't exist on this machine.
Both overwrite the target without asking, so check `git diff` after a `pull`
and before a `push` on a new machine.

## Adding a file

Add a `"repo file|destination"` entry to `MAPPINGS` in `sync.sh`, then `./sync.sh pull`
to bring the file into the repo (or add it to the repo by hand).

| Repo file    | Destination                    |
| ------------ | ------------------------------ |
| `herdr.toml` | `~/.config/herdr/config.toml`  |
