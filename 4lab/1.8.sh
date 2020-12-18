#!/bin/bash

printf "Процессов Пользователя:\n"
whoami
ps aux -u "$(whoami)" | wc -l
printf "Процессов Пользователя root:\n"
ps aux -u root | wc -l