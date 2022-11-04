#!/usr/bin/env just --justfile
#Aliases allow recipes to be invoked with alternative names:

alias fmt := format
alias chk := check

# allow to override earlier recipes with the same name.

set allow-duplicate-recipes := true

# load a .env file, if present.

set dotenv-load := true

# export all variables as environment variables.

set export := true

# pass positional arguments.

set positional-arguments := true

# set the command used to invoke recipes and evaluate backticks.

set shell := ["bash", "-uc"]

# ignore recipe lines beginning with #.

set ignore-comments := true

# search justfile in parent directory

set fallback := true

# absolute path to the current directory

invocation_directory := invocation_directory()
home_dir := env_var('HOME')

# absolute path to the just executable

just_executable := just_executable()

# retrieves the path of the parent directory of the current justfile.

justfile_directory := justfile_directory()

# retrieves the path of the current justfile

justfile := justfile()
TERM := 'xterm-256color'
home_dir2 := env_var_or_default('key', 'default')

# select one or more recipes to run using a binary
@__default:
    just --choose

# show usefull info
@info:
    just --evaluate

# list available recipes and their arguments
@list:
    just --list  

# Edit justfile
@edit:
    just --edit

# run code checker
check *FILES="--all":
    trunk check $FILES --upload --series main --token $TRUNK_TOKEN

# run code checker
check *FILES="--all":
    trunk check --fix $FILES $FILES

# run code formatter
@format *FILES="--all":
    just --fmt  --unstable
    trunk fmt $FILES
    trunk check  --fix $FILES

# create commit
@commit MESSAGE *FLAGS:
    git commit {{ FLAGS }} -m "{{ MESSAGE }}"

# upgrade trunk
@upgrade:
    trunk upgrade

# generate shell completion
@completions $SHELL="fish":
    just --completions  $SHELL > completions/just.$SHELL

@runner command="status":
    #!/usr/bin/env bash
    set -euxo pipefail
    echo "$invocation_directory"
    function mkdir (){
      mkdir actions-runner && cd actions-runner
    }
    $command
