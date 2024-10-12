#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

while [[ -z $USERNAME ]]
do
  echo Enter your username:
  read USERNAME
done

#get user
USER_DATA=$($PSQL "SELECT * FROM users WHERE username='$USERNAME'")
if [[ -z $USER_DATA ]]
then
#add user
  ADD_USER=$($PSQL "INSERT INTO users(username,games_played,best_game) VALUES('$USERNAME',0,1000)")
  USER_DATA=$($PSQL "SELECT * FROM users WHERE username='$USERNAME'")
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  #welcome existing user
  FORMATTED_USER_DATA=$(echo "$USER_DATA" | sed 's/|/ /g')
  echo $FORMATTED_USER_DATA | while read USER_ID USERNAME GAMES_PLAYED BEST_GAME
  do
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
fi

#gameplay
MY_NUMBER=$(($SRANDOM%1000 + 1))
#echo "$MY_NUMBER"
NUM_GUESSES=0
echo "Guess the secret number between 1 and 1000:"
RIGHT_ANSWER=false
while [[ $RIGHT_ANSWER == false ]]
do
  read GUESS
  if [[ ! $GUESS =~ ^[0-9]+$ ]]  
  then
    echo "That is not an integer, guess again:"
    NUM_GUESSES=$(($NUM_GUESSES - 1))
  else
    if [[ $GUESS > $MY_NUMBER ]]
    then
    #too high
      echo "It's lower than that, guess again:"
      #read GUESS
    elif [[ $GUESS < $MY_NUMBER ]]
    then
    #too low
      echo "It's higher than that, guess again:"
      #read GUESS
    else
      RIGHT_ANSWER=true
    fi
  fi
  #read GUESS
  NUM_GUESSES=$(($NUM_GUESSES + 1))
done

#you win!
#update database
USER_DATA=$($PSQL "SELECT * FROM users WHERE username='$USERNAME'")
FORMATTED_USER_DATA=$(echo "$USER_DATA" | sed 's/|/ /g')
#echo $FORMATTED_USER_DATA
echo $FORMATTED_USER_DATA | while read USER_ID USERNAME GAMES_PLAYED BEST_GAME
do
  GAMES_PLAYED=$(($GAMES_PLAYED + 1))
  if (( $BEST_GAME > $NUM_GUESSES ))
  then
    ADD_RESULTS=$($PSQL "UPDATE users SET games_played='$GAMES_PLAYED', best_game='$NUM_GUESSES' WHERE username='$USERNAME'")
  else
    ADD_RESULTS=$($PSQL "UPDATE users SET games_played='$GAMES_PLAYED' WHERE username='$USERNAME'")
  fi
done
#congratulate and end
echo "You guessed it in $NUM_GUESSES tries. The secret number was $MY_NUMBER. Nice job!" 
