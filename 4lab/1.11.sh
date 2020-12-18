#!/bin/bash

printf "Каталоги:\n"
ls -l . | grep ^d

printf "Обычные Файлы:\n"
ls -l . | grep ^-

printf "Символьные Ссылки:\n"
ls -l . | grep ^l

printf "Символьные Устройства:\n" #character file
ls -l . | grep ^c

printf "Блочные Устройства:\n"
ls -l . | grep ^b