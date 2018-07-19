#!/bin/bash
# Pulls files from the following directories and puts them into Elasticsearch
# * Uses the file names to name the index for each object
PATTERNS_DIR=/etc/patterns
SEARCH_DIR=/etc/searches
VIS_DIR=/etc/visualizations
DASH_DIR=/etc/dashboards

# Make sure Kibana is reachable
echo "Trying to reach Kibana..."
until $(curl --output /dev/null --fail --silent -X GET "${KIBANA}"); do
  echo "Couldn't get Kibana at $KIBANA, are you sure it's reachable?"
  sleep 5
done

# Create Index Patterns
PATTERNS_FOUND=`ls -1 ${PATTERNS_DIR}/*.json 2>/dev/null | wc -l`
if [ $PATTERNS_FOUND != 0 ]
then
  for file in ${PATTERNS_DIR}/*.json
  do
    NAME=`basename ${file} .json`
    echo "Loading index pattern ${NAME}:"
    curl -XPOST "${KIBANA}/api/kibana/index-pattern/import" -H 'kbn-xsrf:true' -H 'Content-type:application/json' -d @${file} || exit 1
    echo
  done
else
  echo "No index patterns found in $PATTERNS_DIR, skipping"
fi

# Create Searches
SEARCHES_FOUND=`ls -1 ${SEARCH_DIR}/*.json 2>/dev/null | wc -l`
if [ $SEARCHES_FOUND != 0 ]
then
  for file in ${SEARCH_DIR}/*.json
  do
    NAME=`basename ${file} .json`
    echo "Loading Search ${NAME}:"
    curl -XPOST "${KIBANA}/api/kibana/search/import" -H 'kbn-xsrf:true' -H 'Content-type:application/json' -d @${file} || exit 1
    echo
  done
else
  echo "No search objects found in $SEARCH_DIR, skipping"
fi
  
# Create Visualizations
VIS_FOUND=`ls -1 ${VIS_DIR}/*.json 2>/dev/null | wc -l`
if [ $VIS_FOUND != 0 ]
then
  for file in ${VIS_DIR}/*.json
  do
    NAME=`basename ${file} .json`
    echo "Loading dashboard ${NAME}:"
    curl -XPOST "${KIBANA}/api/kibana/visualizations/import" -H 'kbn-xsrf:true' -H 'Content-type:application/json' -d @${file} || exit 1
    echo
  done
else
  echo "No visualizations found in $VIS_DIR, skipping"
fi
    
# Create Dahboards
DASH_FOUND=`ls -1 ${DASH_DIR}/*.json 2>/dev/null | wc -l`
if [ $DASH_FOUND != 0 ]
then 
  for file in ${DASH_DIR}/*.json
  do
    NAME=`basename ${file} .json`
    echo "Loading dashboard ${NAME}:"
    curl -XPOST "${KIBANA}/api/kibana/dashboards/import" -H 'kbn-xsrf:true' -H 'Content-type:application/json' -d @${file} || exit 1
    echo
  done
else
  echo "No dashboards found in $DASH_DIR, skipping"
fi
