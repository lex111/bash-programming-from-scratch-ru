## Компьютерная программа

Мы рассмотрели функции ОС. Теперь познакомимся с компьютерной программой. Что она из себя представляет? Как происходит её запуск и исполнение? Попробуем отвтить на эти вопросы.

### Память компьютера

Любая компьютерная программа исполняется центральным процессором (CPU). Она хранится на жёстком диске в виде файла. Когда вы запускаете её, ОС загружает содержимое этого файла в оперативную память. Сразу возникает вопрос: зачем это нужно? Почему нельзя просто исполнить файл на диске?

В современном компьютере есть [несколько уровней памяти](https://ru.wikipedia.org/wiki/Иерархия_памяти). Они изображены на иллюстрации 1-1.

{caption: "Иллюстрация 1-1. Уровни памяти персонального компьютера"}
![Уровни памяти](images/GeneralInformation/memory-levels.png)

Стрелки на иллюстрации 1-1 соответствуют потокам данных. Их загрузка и выгрузка возможна только между соседними уровнями памяти. Другими словами если процессору нужны данные с дисковой памяти, они будут сначала загружены в оперативную память, затем в кэш и только потом попадут в регистры. Аналогичным образом происходит и обратный процесс записи данных на диск.

Уровни памяти отличаются друг от друга несколькими параметрами:

1. **Скорость доступа** определяет объём данных, читаемый или записываемых в единицу времени на носитель. Обычно измеряется в [**байтах**](https://ru.wikipedia.org/wiki/Байт) за секунду (байт/с).

2. **Объём** — количество данных, которое может храниться на носителе. Измеряется в байтах.

3. **Стоимость** — цена носителя в соотношении к его объёму. Измеряется в долларах или центах за байт или бит.

4. **Время доступа** — время, через которое процессор получит доступ к прочитанным данным. Обычно измеряется в **тактовых сигналах** проецссора.

Соотношение рассмотренных параметров для разных типов памяти приведено в таблице 1-1.

{caption: "Таблица 1-1. Уровни памяти персонального компьютера"}
| Уровень | Память | Объём | Скорость доступа | Время доступа | Стоимость |
| --- | --- | --- | --- | --- | --- |
| 1 | [**Регистры**](https://ru.wikipedia.org/wiki/Регистр_процессора) процессора. | до тысячи байтов | — | 1 такт | — |
| 2 | [**Кэш**](https://ru.wikipedia.org/wiki/Кэш_процессора) память процессора. | от одного килобайта до нескольких мегабайтов | от 700 до 100 гигабайт/сек | от 2 до 100 тактов | — |
| 3 | Оперативная память (RAM) | десятки гигабайтов | 10 гигабайт/сек | до 1000 тактов | $10<sup>-9</sup>/байт |
| 4 | Дисковая память ([**жёсткие диски**](https://ru.wikipedia.org/wiki/Жёсткий_диск) и [**твёрдотельные накопители**](https://ru.wikipedia.org/wiki/Твердотельный_накопитель)) | терабайты | 2000 мегабайт/сек | до 10000000 тактов | $10<sup>-12</sup>/байт |

Таблица 1-1 вызывает вопросы. Разве скорости доступа к данным в 2000 Мб/с недостаточно для чтения и исполнения файла приложения размером с десятки мегабайт? На самом деле важна не столько скорость чтения данных в байтах, а то как долго простаивает процессор, дожидаясь доступа к ним. Это время доступа к памяти измеряется в числе [тактовых сигналов](https://ru.wikipedia.org/wiki/Тактовый_сигнал) или тактах. Такт синхронизирует выполнение всех операций процессора. Как правило, элементарная операция занимает от одного до нескольких тактов.

Итак, если бы процессору приходилось читать код программы с жёсткого диска и записывать на него промежуточные данные и результаты, выполнение простейших алгоритмов заняло бы в лучшем случае недели. Причём большую часть этого времени процессор простаивал бы, находясь в ожидании выполнения операций чтения и записи. Иерархическая организация памяти позволяет на порядки ускорить доступ к данным, необходимым процессору в данный момент. Тем самым решается проблема его простаивания.

Обратите внимание, что чем меньше время доступа к памяти, тем ближе она физически расположена к процессору. Наример, внутренняя память CPU (регистры и кэш) находится внутри его кристалла. Оперативная память расположена на [**материнской плате**](https://ru.wikipedia.org/wiki/Материнская_плата) рядом с процессором и соединена с ним по высокочастотной [**шине данных**](https://ru.wikipedia.org/wiki/Шина_данных). Дисковая память подключается к материнской плате через относительно медленную шину данных.

### Машинный и исходный код

Предположим ОС успешно загрузила данные из исполняемого файла приложения в оперативную память. В этом файле хранится [**машинный код**](https://ru.wikipedia.org/wiki/Машинный_код). Он представляет собой инструкции процессора, которые могут быть исполнены его логическими блоками. Каждая такая инструкция представляет собой элементарную операцию над данными, хранящимися в регистрах или кэше CPU.

Если вы откроете исполняемый файл в редакторе, то увидите машинный код в [шестнадцатеричном](https://ru.wikipedia.org/wiki/Шестнадцатеричная_система_счисления) представлении. На самом деле в файле хранится [**двоичный код**](https://ru.wikipedia.org/wiki/Двоичный_код#Пример_«доисторического»_использования_кодов), а редактор для удобства чтения переводит его в шестнадцатеричный формат. Именно в двоичном коде процессор принимает свои инструкции. Очевидно, для человека писать программу в двоичных кодах неудобно и трудоёмко. Поэтому появились специальные приложения: [**компиляторы**](https://ru.wikipedia.org/wiki/Компилятор) и [**интерпретаторы**](https://ru.wikipedia.org/wiki/Интерпретатор#История). Их задача заключается в трансляции текста программы, написанном на каком-то [**языке программирования**](https://ru.wikipedia.org/wiki/Язык_программирования), в машинный код. Этот текст называется [**исходным кодом**](https://ru.wikipedia.org/wiki/Исходный_код).

Рассмотрим пример. Листинг 1-1 демонстрирует исходный код программы на языке C, выводящий на консоль текст "Hello world!".

{caption: "Листинг 1-1. Исходный код программы на языке C", format: C}
![`HelloWorld.c`](code/GeneralInformation/HelloWorld.c)

В листинге 1-2 приведена та же самая программа в виде машинного кода (в шестнадцатеричном представлении).

{caption: "Листинг 1-2. Машинный код программы"}
![`MachineCode.txt`](code/GeneralInformation/MachineCode.txt)

Очевидно, что код из листинга 1-1 намного проще прочитать, понять и отредактировать в случае необходимости. Именно эти преимущества работы с исходным кодом и обеспечивают компиляторы и интерпретаторы. Рассмотрим подробнее принцип их работы и различия.

#### Компилятор

// TODO: Сделать схему компиляции исходного кода в машинный и его исполнение.

#### Интерпретатор

// TODO: Сделать схему интерпретации исходного кода в машинный и его исполнение.

Идея интерпретаторов заключается в том, чтобы читать команды программы из файла построчно и сразу же отправлять их процессору для исполнения. То есть можно сказать, что интерпретатор — это программа, которая переводит команды программы на "язык" процессора.

Текст приложения пишется на каком-то [языке программирования](https://ru.wikipedia.org/wiki/Язык_программирования), отличном от двоичного кода процессорных инструкций. Этот текст называется [**исходным кодом**](https://ru.wikipedia.org/wiki/Исходный_код). Интерпретатор читает исходный код из файла на диске и исполняет указанные в нём команды друг за другом.

Очевидно, процесс интерпретации значительно замедляет работу приложения. Вместо его непосредственного исполнения на процессоре, появляется программа-посредник. Получается, что компьютер должен предоставлять ресурсы не только вашему приложению, но и его интерпретатору. Однако, эта плата за удобство разработки программ зачастую приемлема. Как правило, язык программирования намного удобнее и выразительнее двоичного кода. Благодаря чему, написанные на нём программы намного проще (а значит и дешевле) разрабатывать и поддерживать.

// TODO: Рассказать про альтернативы интерпретаторов компиляторы. Начать с них, а потом перейти к интерпретаторам.