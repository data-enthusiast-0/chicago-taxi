#!/bin/bash

# check present working directory
# echo $PWD

# input file 
# input="/Users/ashish/Documents/Workspace/statsProject/sampleData.csv"
input="sampleData2.csv"

# output file
output="outputFile.csv"

# Read File line-by-line
n=1

<<COMMENT
# Source Variables
01 Trip ID
02 Taxi ID
03 Trip Start Timestamp
04 Trip End Timestamp
05 Trip Seconds
06 Trip Miles
07 Pickup Census Tract
08 Dropoff Census Tract
09 Pickup Community Area
10 Dropoff Community Area
11 Fare
12 Tips
13 Tolls
14 Extras
15 Trip Total
16 Payment Type
17 Company
18 Pickup Centroid Latitude
19 Pickup Centroid Longitude
20 Pickup Centroid Location
21 Dropoff Centroid Latitude
22 Dropoff Centroid Longitude
23 Dropoff Centroid Location
COMMENT

# Working Variables
var1=0
var2=0
var3=0
var4=0
var5=0
var6=0
var7=0
var8=0
var9=0
var10=0
var11=0
var13=0
var14=0
var15=0
var16=0
var17=0
var18=0
var19=0
var20=0
var21=0
var22=0
var23=0

# Storage Variables
TripID=''
TripStartDate=''
TripStartTime=''
TripMonth=''
TripSeconds=''
TripMiles=''
TripFare=''
TripTips=''
TripTolls=''
TripExtras=''
TripTotal=''
PaymentType=''

while read line; do
    # reading each line
    # echo "Line No. $n : $line"
    n=$((n+1))

    #pre-process the line by removing quotes, $, etc. 
    line=`echo $line | awk -F'"' -v OFS='' '{ for (i=2; i<=NF; i+=2) gsub(",", "", $i) } 1'`
    line=`echo $line | tr -d $`
    # echo $line

    # Parse all the relevant information and clean it up
    var1=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $1}' | awk '{$1=$1};1'`
    TripID=$var1
    # var2=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $2}' | awk '{$1=$1};1'`
    var3=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $3}' | awk '{$1=$1};1'`
    TripStartDate=`echo $var3 | awk 'BEGIN{FS="[ ]"; OFS=","}{print$1}' | awk '{$1=$1};1'`
    TripStartTime=`echo $var3 | awk 'BEGIN{FS="[ ]"}{print$2}' | awk '{$1=$1};1'`
    TripMonth=`echo $var3 | awk 'BEGIN{FS="/";OFS=","}{print$1}' | awk '{$1=$1};1'`
    TripYear=`echo $TripStartDate | awk 'BEGIN{FS="/";OFS=","}{print$3}' | awk '{$1=$1};1'`

    # var4=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $4}' | awk '{$1=$1};1'`
    
    # Trip Seconds
    var5=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $5}' | awk '{$1=$1};1'`
    TripSeconds=$var5

    # Trip Miles
    var6=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $6}' | awk '{$1=$1};1'`
    TripMiles=$var6
    
    # var7=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $7}' | awk '{$1=$1};1'`
    # var8=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $8}' | awk '{$1=$1};1'`
    # var9=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $9}' | awk '{$1=$1};1'`
    # var10=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $10}' | awk '{$1=$1};1'`
    
    # Trip Fare
    var11=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $11}' | awk '{$1=$1};1'`
    TripFare=$var11

    # Trip 
    var12=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $12}' | awk '{$1=$1};1'`
    TripTips=$var12

    # Trip Tolls
    var13=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $13}' | awk '{$1=$1};1'`
    TripTolls=$var13

    # TripExtras=''
    var14=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $14}' | awk '{$1=$1};1'`
    TripExtras=$var14

    #  Trip Total=
    var15=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $15}' | awk '{$1=$1};1'`
    TripTotal=$var15
    
    # Payment Type
    var16=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $16}' | awk '{$1=$1};1'`
    PaymentType=$var16

    # var17=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $17}' | awk '{$1=$1};1'`
    # var18=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $18}' | awk '{$1=$1};1'`
    # var19=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $19}' | awk '{$1=$1};1'`
    # var20=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $20}' | awk '{$1=$1};1'`
    # var21=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $21}' | awk '{$1=$1};1'`
    # var22=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $22}' | awk '{$1=$1};1'`
    # var23=`echo $line | awk 'BEGIN{FS=","; OFS=","} {print $23}' | awk '{$1=$1};1'`
    
    echo -e "$TripID,$TripStartDate,$TripStartTime,$TripMonth,$TripYear,$TripSeconds,$TripMiles,$TripFare,$TripTips,$TripTolls,$TripExtras,$TripTotal,$PaymentType" >> $output
    # Print the variables of interest
done < $input
