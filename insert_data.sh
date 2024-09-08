#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

#for teams
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

  #ovveride first row
  if [[ $YEAR == 'year' ]]
  then
    continue
  fi
  
  
  #insert_data teams
  RESULT_INSERT_WINNER=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
  RESULT_INSERT_OPPONENT=$($PSQL "insert into teams(name) values('$OPPONENT')")
  
  done

 # for games
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

  #ovveride first row
  if [[ $YEAR == 'year' ]]
  then
    continue
  fi
  # ID OF TEAMS
  ID_WINNER=$($PSQL "select team_id from teams where name='$WINNER'")
  ID_OPPONENT=$($PSQL "select team_id from teams where name='$OPPONENT'")

  
  
  #insert_data games
  RESULT_INSERT_GMAE=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR,'$ROUND', $ID_WINNER, $ID_OPPONENT, $WINNER_GOALS, $OPPONENT_GOALS)")
  
  done