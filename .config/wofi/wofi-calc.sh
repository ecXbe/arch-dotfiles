#!/bin/bash

wofi() {
    command wofi -n "$@"
}

export -f wofi

exec wofi-calc "$@"
