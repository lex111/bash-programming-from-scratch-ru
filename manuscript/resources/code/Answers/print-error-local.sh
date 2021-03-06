#!/bin/bash

code_to_error_ru()
{
  case $1 in
    1)
      echo "Не найден файл"
      ;;
    2)
      echo "Нет прав для чтения файла"
      ;;
  esac
}

code_to_error_en()
{
  case $1 in
    1)
      echo "The following file was not found:"
      ;;
    2)
      echo "You do not have permissions to read the following file:"
      ;;
  esac
}

print_error()
{
  if [[ "$LANG" == ru_RU* ]]
  then
    echo "$(code_to_error_ru $1) $2" >> debug.log
  else
    echo "$(code_to_error_en $1) $2" >> debug.log
  fi
}

print_error 1 "readme.txt"
