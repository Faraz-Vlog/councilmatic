#!/usr/bin/env bash
#
# Update JSON Database - To be run to establish a baseline of files
#
# Written by Howard Matis - April 2, 2019

# Now using API scraper

VERSION="3.0.0"
ISDARWIN='Darwin'
LINUXTYPE=$(uname -s) # If equals ISDARWIN then we are running under OSX on a local development Mac

if [ $LINUXTYPE = $ISDARWIN ]; then
	echo "Running under Mac OSX/Darwin"
	DIR=/Users/matis/Documents/OpenOakland/Councilmatic-master/Councilmatic
else
	echo "NOT Running under Darwin, assuming Ubuntu/AWS"
	DIR=/home/howard/Councilmatic
fi

if [ $LINUXTYPE = $ISDARWIN ]; then
	PYTHON=/Users/matis/anaconda3/bin/python   #Must specify correct version of Python
else
	PYTHON=/home/howard/miniconda3/bin/python  #Must specify correct version of Python
fi

echo $PYTHON


echo "Beginning full json scrape. Version "$VERSION
cd $DIR
pwd

YEAR="2014"
for YEAR in {2014..2019..1}     # Loop from years 2014 to 2019
    do
        echo "Doing the JSON Scrape for YEAR $YEAR"
        COMMAND="run_meeting_json.py --year $YEAR --output WebPage/website/scraped/ScraperTEMP.json"
        echo "Starting the Scrape with the command:" $COMMAND
        $PYTHON $COMMAND
        retVal=$?
        if [ $retVal -ne 0 ]; then
            echo "Scraper error. Will ignore"
        else
            mv  WebPage/website/scraped/ScraperTEMP.json  WebPage/website/scraped/Scraper$YEAR.json
            echo "Successful scraper file for year $YEAR"
        fi
        echo ""
done

echo "Scraper_full_json.sh completed"
#


