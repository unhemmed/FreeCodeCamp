#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~ ~ ~ The Salon ~ ~ ~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo "How might we serve you?"
  GET_SERVICE_LIST



}

GET_SERVICE_LIST() {

  SERVICE_LIST=$($PSQL "SELECT service_id,name FROM services")
  echo "$SERVICE_LIST" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done

  read SERVICE_ID_SELECTED
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    MAIN_MENU "Please enter the number of the service you desire."
  else
    GET_SERVICE=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED")
    if [[ -z $GET_SERVICE ]]
    then
      MAIN_MENU "Please enter a valid number."
    else
      APPOINTMENT_MANAGER $SERVICE_ID_SELECTED
    fi
  fi
}

APPOINTMENT_MANAGER() {
  SERVICE_ID=$1
  echo -e "\nPlease enter your phone number:"
  read CUSTOMER_PHONE
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_ID ]]
  then
    # add customer
    ADD_CUSTOMER $CUSTOMER_PHONE
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  fi
  while [[ -z $SERVICE_TIME ]]
  do
  echo -e "\nPlease enter your preferred appointment time:"
  read SERVICE_TIME
  done

  INSERT_APPT=$($PSQL "INSERT INTO appointments(time,customer_id,service_id) VALUES('$SERVICE_TIME',$CUSTOMER_ID,$SERVICE_ID)")
  
  GET_APPT=$($PSQL "SELECT time,c.name,s.name FROM appointments AS a INNER JOIN customers as c ON c.customer_id=a.customer_id INNER JOIN services AS s ON s.service_id=a.service_id ORDER BY a.appointment_id DESC LIMIT 1")
  echo "$GET_APPT" | while read APPT_TIME BAR APPT_NAME BAR APPT_SERVICE
  do
  echo -e "\nI have put you down for a $APPT_SERVICE at $APPT_TIME, $APPT_NAME."
  done
}

ADD_CUSTOMER(){
  PHONE_NUMBER=$1  
  while [[ -z $CUSTOMER_NAME ]]
  do
    echo -e "\nPlease enter your name"
    read CUSTOMER_NAME
  done

  INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$PHONE_NUMBER')")

}

MAIN_MENU
