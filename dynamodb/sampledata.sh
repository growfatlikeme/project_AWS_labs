#!/bin/bash

# Get table name and region from command line arguments
TABLE_NAME=$1
REGION=$2

# Use the parameters in the commands
aws dynamodb put-item \
    --table-name "$TABLE_NAME" \
    --region "$REGION" \
    --item \
        '{"ISBN": {"S": "978-0134685991"}, "Genre": {"S": "Technology"}, "Title": {"S": "Effective Java"}, "Author": {"S": "Joshua Bloch"}, "Stock": {"N": "1"}}'

aws dynamodb put-item \
    --table-name "$TABLE_NAME" \
    --region "$REGION" \
    --item \
        '{"ISBN": {"S": "978-0134685009"}, "Genre": {"S": "Technology"}, "Title": {"S": "Learning Python"}, "Author": {"S": "Mark Lutz"}, "Stock": {"N": "2"}}'

aws dynamodb put-item \
    --table-name "$TABLE_NAME" \
    --region "$REGION" \
    --item \
        '{"ISBN": {"S": "974-0134789698"}, "Genre": {"S": "Fiction"}, "Title": {"S": "The Hitchhiker"}, "Author": {"S": "Douglas Adams"}, "Stock": {"N": "10"}}'

aws dynamodb put-item \
    --table-name "$TABLE_NAME" \
    --region "$REGION" \
    --item \
        '{"ISBN": {"S": "982-01346653457"}, "Genre": {"S": "Fiction"}, "Title": {"S": "Dune"}, "Author": {"S": "Frank Herbert"}, "Stock": {"N": "8"}}'

aws dynamodb put-item \
    --table-name "$TABLE_NAME" \
    --region "$REGION" \
    --item \
        '{"ISBN": {"S": "978-01346854325"}, "Genre": {"S": "Technology"}, "Title": {"S": "System Design"}, "Author": {"S": "Mark Lutz"}}'
