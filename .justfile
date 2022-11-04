#!/usr/bin/env just --justfile

aAliases allow recipes to be invoked with alternative names:
alias fmt := format
alias chk := check

# allow to override earlier recipes with the same name.
set allow-duplicate-recipes
# load a .env file, if present.
set dotenv-load
# export all variables as environment variables.
set export
# pass positional arguments.
set positional-arguments
# set the command used to invoke recipes and evaluate backticks.
set shell := ["bash", "-uc"]
# ignore recipe lines beginning with #.
set ignore-comments
# search justfile in parent directory
set fallback

# select one or more recipes to run using a binary
@default:
  just --choose
# list available recipes and their arguments
@list:
  just --list  
# run code checker
@check *TARGET="--all":
  trunk --fix check $TARGET
# run code formatter
@format *TARGET="--all":
  trunk --fix check $TARGET
