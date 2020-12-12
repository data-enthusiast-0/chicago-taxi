#!/bin/bash
# 
# Ashish Agarwal (ashish.agarwal.chicagobooth.edu)
# 
# File to process sample data - Taxi_Data_Sample_*.csv
# 
# Remove data where trip Fare=0; compute 

# check present working directory
# echo $PWD

# input file 
# input="/Users/ashish/Documents/Workspace/statsProject/sampleData.csv"
input="Taxi_Data_Sample_2013_1000.csv"

# input line header
# Trip ID, Trip Date, Trip Time, Trip Month, Trip Year, Trip Seconds, Trip Miles, Trip Fare, Trip Tip, Trip Extras, Trip Toll, Trip Total, Payment Type
# 8b072199064a641d2b1092308d8112076d6b3c3f,11/14/2013,08:45:00,11,2013,300,0,5.45,2.00,0.00,0.00,7.45,Credit Card

# output file
output="Taxi_Data_Reg2_2013.csv"

# input line header
# Trip ID, Trip Date, Trip Time, Trip Month, Trip Year, Trip Seconds, Trip Miles, Trip Fare, Trip Tip, Trip Extras, Trip Toll, Trip Total, Payment Type
# 8b072199064a641d2b1092308d8112076d6b3c3f,11/14/2013,08:45:00,11,2013,300,0,5.45,2.00,0.00,0.00,7.45,Credit Card
# $line,$TripTipPercent,$Payment

# Declare Variables

Payment=0
TripTipPercent=0
TripFareCheck=0

# Read File line-by-line
while read line; do
    # reading each line
    # echo "Line No. $n : $line"
    n=$((n+1))
    
    # check if line can be read
    # echo -e $line

    # Print the variables of interest
    # echo -e "$TripID,$TripStartDate,$TripStartTime,$TripMonth,$TripYear,$TripSeconds,$TripMiles,$TripFare,$TripTips,$TripTolls,$TripExtras,$TripTotal,$PaymentType" >> $output
    
    TripFare=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $8}'`
    TripTips=`echo $line | awk 'BEGIN{FS=",";OFS=","} {print $9}'`

    # if (( $TripFare == 0 ));
    TripFareCheck=$(echo "$TripFare!=0" | bc)
    TripTipCheck=$(echo "$TripTips!=0" | bc)

    # echo $TripFareCheck
    if [[ "$TripFareCheck" -eq "0" ]] || [[ "$TripTipCheck" -eq "0" ]]
    then
        echo -e 'Fare OR Tip is 0' ;
    else
        # Compute Tip Percent
        TripTipPercent=$(echo "scale=4;$TripTips*100/$TripFare" | bc)

        # Check Math
        # echo -e "Percent=$TripTipPercent"

        # Compute Payment
        PaymentType=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $13}'`
        if [[ "$PaymentType" == "Cash" ]]; 
        then
            Payment=0
        else
            Payment=1
        fi

        # echo -e "$PaymentType,$Payment"

        # Save output to File
        echo -e "$line,$TripTipPercent,$Payment" >> $output
    fi

done < $input
