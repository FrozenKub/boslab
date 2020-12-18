#!/bin/bash

printf "Каталоги:\n"
ls -l "$1" | grep ^d

printf "Обычные Файлы:\n"
ls -l "$1" | grep ^-

printf "Символьные Ссылки:\n"
ls -l "$1" | grep ^l

printf "Символьные Устройства:\n" #character file
ls -l "$1" | grep ^c

printf "Блочные Устройства:\n"
ls -l "$1" | grep ^b