## Информация о командах

Мы научились основным командам навигации по файловой системе. Прежде чем продолжить наше знакомство с командным интерпретатором Bash, стоит рассмотреть один важный вопрос: где получить информацию о той или иной команде?

Разработчики первых версий UNIX подумали над этой проблемой. В случае графического интерфейса, элементарные действия интуитивно понятны. Но при работе с командной строкой всё не так очевидно. Пользователь может оказаться с системой один на один и у него должен быть способ самостоятельно получить нужную информацию.

Начнём со справки о встроенных командах интерпретатора Bash. Чтобы вывести её на экран, выполните команду `help`. Результат приведён на иллюстрации 2-20.

{caption: "Иллюстрация 2-20. Результат выполнения команды `help`", height: "50%"}
![Результат help](images/BashShell/bash-help.png)

В выводе `help` указаны все команды, которые интерпретатор Bash исполняет самостоятельно. Если вы набираете команду, которой нет в этом списке, будет вызвана соответствующая ей GNU утилита или программа.

Например, команда `cd` есть в списке `help`. Это значит, что Bash выполняет её сам, не вызывая какое-то вспомогательное приложение. Когда же вы вводите команду `find`, которой в списке `help` нет, Bash ищет соответствующую утилиту на жёстком диске и запускает её с указанными вами параметрами.

Где Bash ищет утилиты для выполнения команд? У него есть список путей для их поиска. Этот список хранится в [**переменной окружения**](https://ru.wikipedia.org/wiki/Переменная_среды) с именем `PATH`. [**Переменную**](https://ru.wikipedia.org/wiki/Переменная_(программирование)) можно представить как некоторое значение, которое имеет имя. Например, мы можем сказать: текущее время 12 часов. В этом случае именем переменной будет "текущее время", а значением "12 часов".

Значение переменных в Bash можно выводить командой `echo`. Чтобы вывести переменную с именем `PATH`, выполните следующее:
{line-numbers: false}
```
echo "$PATH"
```

Зачем нам понадобился знак доллара `$` перед именем переменной? Вообще, команда `echo` выводит строку, которую получает входным параметром. Например, если вы выполните `echo 123`, то получите в выводе `123`. Когда вы ставите `$` перед каким-то словом, вы сообщаете Bash, что это имя переменной. Оно обрабатывается иначе, чем обычная строка. Когда Bash встречает имя переменной в команде, он ищет его в своём списке. Если это имя ему известно, он подставит вместо него значение переменной. В противном случае будет подставлена пустая строка.

I> Заключать имена переменных в строках в двойные кавычки `"` считается [хорошей практикой](https://www.tldp.org/LDP/abs/html/quotingvar.html). Это позволяет избежать потенциальных ошибок. Например, Bash подставляет значение переменной вместо её имени. Если в подстановке встречаются управляющие символы, они будут обработаны интерпретатором. В результате вставленное значение переменной будет отличаться от того, что хранится в памяти Bash. Это может привести к некорректному поведению программы.

Вернёмся к нашей команде вывода переменной `PATH`. После её выполнения будет распечатана строка как на иллюстрации 2-21.

{caption: "Иллюстрация 2-21. Значение переменной `PATH`", height: "30%", width: "100%"}
![Значение PATH](images/BashShell/echo-path.png)

Что означает этот вывод? Перед нами строка, которая состоит из набора путей, разделённых двоеточиями. Если мы представим эти пути в виде списка, он будет выглядеть следующим образом:
{line-numbers: false}
```
/usr/local/bin
/usr/bin
/bin
/opt/bin
/c/Windows/System32
/c/Windows
/c/Windows/System32/Wbem
/c/Windows/System32/WindowsPowerShell/v1.0/
```

I> Формат переменной `PATH` вызывает вопросы. Почему нельзя хранить пути в виде списка с [разделителем строки](https://ru.wikipedia.org/wiki/Перевод_строки) после каждого? Тогда бы при выводе переменной на экран, её было бы удобнее читать. Короткий ответ заключается в том, что так проще программировать. Использование символа перевода строки `\n` чревато ошибками при работе с переменной.

Итак, вернёмся к нашей задаче получения информации о доступных командах. Будет логичным искать вспомогательные утилиты там же, где их ищет Bash. Команда `find` поможет вам с поиском нужного файла в каждом из каталогов `PATH`. Так вы обнаружите, что сама утилита `find`, например, находится в обоих каталогах `/bin` и `/usr/bin`.

I> Чтобы вывести все переменные окружения, установленные в данный момент, выполните команду `env` без параметров.

Узнать путь до той или иной программы, используемой Bash, поможет команда `type`. Вызовите её, передав первым параметром имя интересующей вас утилиты. В результате будет выведен абсолютный путь до неё как на иллюстрации 2-22.

{caption: "Иллюстрация 2-22. Результат выполнения команды `type`", height: "30%"}
![Результат `type`](images/BashShell/type-command.png)

Из этого вывода команды `type` мы узнали пути до утилит `find` и `ls`. Также выяснили, что путь `ls` хэшируется. Это значит, что Bash запомнил его и не будет искать каждый раз через переменную `PATH`. Если скопировать утилиту в другое место, то Bash её не найдёт. Кроме этого благодаря `find` мы уточнили, что `pwd` является встроенной командой интерпретатора.

Предположим, что нужная нам утилита нашлась по одному из путей `PATH`. Как узнать, какие входные параметры она принимает? Если вам нужна краткая справка, вызовите утилиту и передайте входным параметром строку `--help`. Иллюстрация 2-23 демонстрирует вывод справки для команды `cat`.

{caption: "Иллюстрация 2-23. Справка команды `cat`", height: "50%"}
![Справка `cat`](images/BashShell/cat-help.png)

Если на вашей системе в качестве языка по умолчанию установлен английский, то скорее всего информация о командах будет доступна только на нём. Если вам нужен перевод на русский, вы можете найти его в [Интернете](https://www.opennet.ru/man.shtml?topic=cat&russian=0&category=&submit=%F0%CF%CB%C1%DA%C1%D4%D8+man). Но каждый раз использовать браузер может быть неудобно. Альтернативное решение — использовать онлайн переводчик [Google Translate](https://translate.google.com) или [DeepL](https://www.deepl.com/translator). Если вы используйте Linux, переключите системный язык на русский. После этого документация тоже переключится на него.

Если вам нужна более детальная информация о команде, воспользуйтесь системой документации `info`. Предположим, вы хотите узнать примеры использования утилиты `cat` или получить её подробное описание. Для этого вызовите команду:
{line-numbers: false}
```
info cat
```

Результат этого вызова приведён на иллюстрации 2-24.

{caption: "Иллюстрация 2-24. Справка info по команде `cat`", height: "50%"}
![Справка info по `cat`](images/BashShell/cat-info.png)

Перед вами программа для чтения текстовых документов. Чтобы прокручивать текст вверх и вниз, воспользуйтесь клавишами PageUp и PageDown, либо стрелками. Для выхода из программы нажмите Q.

I> Система документации `info` была введена разработчиками GNU утилит. До этого на UNIX системах повсеместно использовалась более старая программа `man`. Её функциональность очень похожа на `info`. Поэтому в MSYS2 `man` не устанавливается по умолчанию, но вы можете скачать её отдельно. Вызов справки через man выглядит следующим образом:
{line-numbers: false}
```
man cat
```

Мы разобрались со случаем, когда имя утилиты известно. Но что делать, если подходящая команда нам незнакома? Лучшим решением будет поиск ответа в интернете через [Google](https://www.google.com). Советы по использованию командной строки, как правило, намного лаконичнее инструкций, связанных с GUI. Вам не нужны скриншоты и видеоролики с объяснениями каждого действия. Вместо этого достаточно одной единственной строчки с вызовом команды, которая сделает всё необходимое.

Если ваша задача не совсем обычна, имеет смысл поискать информацию на английском языке. Сообщество англоязычных пользователей Bash огромно, и кто-то наверняка уже сталкивался с вашей задачей и решил её.

{caption: "Упражнение 2-5. Использование системы документации", format: text, line-numbers: false}
```
Найдите информацию по каждой из команд, представленных в таблице 2-1. Изучите флаги команд ls и find, которые мы не рассмотрели.
```