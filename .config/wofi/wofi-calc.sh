#!/bin/bash

wofi() {
    command wofi -n "$@"
}
export -f wofi

(qalc -e &) ; exec wofi-calc "$@"
