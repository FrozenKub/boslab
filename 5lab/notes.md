1) Устанавливаем для  скрипта выполнение 'echo "Аварийное завершение..."; exit 1' при получения сигнала. 

2) `$$` -  Выполняется: `ls -l /proc/pid-of-bash`. Когда мы вызовываем ` ls -l /proc/self`, вызов происходит при помощи процесса ls, аналогично: `ls -l /proc/pid-of-ls`. Данные pid отличаются => отличаестся вывод.

3) 
```
total 0
lrwx------ 1 user user 64 Dec  18 19:43 0 -> /dev/pts/0  # stdin
lrwx------ 1 user user 64 Dec  18 19:43 1 -> /dev/pts/0  # stdout
lrwx------ 1 user user 64 Dec  18 19:43 2 -> /dev/pts/0	# stderr

```
4) Дискрипторы изменяются, программа производит вывод (в файлы)
```
total 0
l-wx------ 1 root root 64 Dec  18 17:27 0 -> /dev/pts/0
l-wx------ 1 root root 64 Dec  18 17:27 1 -> /tmp/ls.out
l-wx------ 1 root root 64 Dec  18 17:27 2 -> /tmp/ls.err
```

5) При изменении дискриптора в зависимости от потока меняются права:
Для входящих `lr-x`, для выводящих `l-wx`
```
~$ ls -l /proc/self/fd > /tmp/ls.out 2> /tmp/ls.err 0</tmp/ls.in
~$ cat /tmp/ls.out
total 0
lr-x------ 1 user user 64 Dec  18 20:03 0 -> /tmp/ls.in
l-wx------ 1 user user 64 Dec  18 20:03 1 -> /tmp/ls.out
l-wx------ 1 user user 64 Dec  18 20:03 2 -> /tmp/ls.err
lr-x------ 1 user user 64 Dec  18 20:03 3 -> /proc/730/fd

```

6) Команда exec не создает новый процес. 


7) pos означает номер позици дискриптора.
```
frozenkub@frozenkubwork:~# cat -A ~/test.out
Test3$
Test333$
```	


8) Да. Команда rm не удаляет данные, а убирает ссылку на них. У нас есть вторая ссылка, через которую мы получим доступ к данным.

```
frozenkub@frozenkubwork:~# ls -l /proc/$$/fd
total 0
lrwx------ 1 root root 64 Dec  18 17:25 0 -> /dev/pts/0
lrwx------ 1 root root 64 Dec  18 17:25 1 -> /dev/pts/0
lrwx------ 1 root root 64 Dec  18 17:25 2 -> /dev/pts/0
lrwx------ 1 root root 64 Dec  18 17:25 255 -> /dev/pts/0
l-wx------ 1 root root 64 Dec  18 17:25 3 -> '/root/test.out (deleted)'
lr-x------ 1 root root 64 Dec  18 17:25 4 -> '/root/test.out (deleted)'
frozenkub@frozenkubwork:~# cat ~/test.out 
cat: /root/test.out: No such file or directory
frozenkub@frozenkubwork:~# cat <&4
Test3
Test333
```
