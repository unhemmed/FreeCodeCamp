#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  LOOKUP_VALUE=$1

  #check if atomic number
  if [[ $LOOKUP_VALUE =~ ^[0-9]+$ ]]
  then 
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$LOOKUP_VALUE")
  else
    #check if symbol
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$LOOKUP_VALUE'")
    if [[ -z $ATOMIC_NUMBER ]]
    then
    #check if name
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$LOOKUP_VALUE'")
    fi
  fi

  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else
    GET_ELEMENT=$($PSQL "SELECT e.atomic_number,e.name,e.symbol,t.type,p.atomic_mass,p.melting_point_celsius,p.boiling_point_celsius FROM elements as e INNER JOIN properties as p ON e.atomic_number=p.atomic_number INNER JOIN types as t ON p.type_id=t.type_id WHERE e.atomic_number=$ATOMIC_NUMBER")
    GET_ELEMENT_FORMATTED=$(echo $GET_ELEMENT | sed 's/|/ /g')
    echo $GET_ELEMENT_FORMATTED | while read ATOMIC_NUM A_NAME A_SYMBOL A_TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
    do
      echo "The element with atomic number $ATOMIC_NUM is $A_NAME ($A_SYMBOL). It's a $A_TYPE, with a mass of $ATOMIC_MASS amu. $A_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
fi
