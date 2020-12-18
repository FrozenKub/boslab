#!/bin/bash

printf "Домашний Каталог Пользователя"
whoami
printf "\nСодержит Обычных Файлов:\n"
find ~ -maxdepth 1  -type f -not -name ".*" -print  | wc -l
printf "Скрытых файлов:\n"
find ~ -maxdepth 1  -type f -name ".*" -print  | wc -l