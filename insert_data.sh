#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE games,teams;")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != 'year' ]]
  then
    #GET TEAM ID OF WINNER
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    #IF NOT FOUND
    if [[ -z $WINNER_ID ]]
    then
      #ADD NEW TEAM_ID
      NEW_TEAM_ID=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")
      if [[ $NEW_TEAM_ID == 'INSERT 0 1' ]]
      then
        echo Inserted into teams, $WINNER
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
      fi
    fi
    #GET TEAM ID OF LOSER
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    #IF NOT FOUND
    if [[ -z $OPPONENT_ID ]]
    then
      #ADD NEW TEAM_ID
      NEW_TEAM_ID=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');")
      if [[ $NEW_TEAM_ID == 'INSERT 0 1' ]]
      then
        echo Inserted into teams, $OPPONENT
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
      fi
    fi

  NEW_GAME_ENTRY=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS);")
  if [[ $NEW_GAME_ENTRY == 'INSERT 0 1' ]]
  then
    echo Inserted into games, $YEAR $ROUND
  fi

  fi
done

