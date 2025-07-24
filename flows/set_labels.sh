#!/bin/bash

# Run Liquibase status and capture the output
status_output=$(liquibase status)

# Check if the command ran successfully
if [ $? -ne 0 ]; then
    echo "Liquibase status command failed"
    exit 1
fi

# Check if there are any pending changesets
if echo "$status_output" | grep -q "up to date"; then
    echo "Liquibase status returned no pending changesets. Exiting set_labels."
    exit 0
fi

# Example Liquibase Status command:
# 2 changesets have not been applied to <JDBC_URL>
#     changelogs/issues/ABC-0001/001.sql::lb_test_table_01::asmith
#     changelogs/issues/ABC-0001/001.sql::lb_test_table_02::asmith

# Parse each line after the first
echo "$status_output" | tail -n +2 | while IFS= read -r line; do

    # Trim leading/trailing whitespace
    clean_line=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    # Skip empty lines
    if [ -z "$clean_line" ]; then
        continue
    fi

    filepath=$(echo "$clean_line" | awk -F'::' '{print $1}')
    id=$(echo "$clean_line" | awk -F'::' '{print $2}')
    author=$(echo "$clean_line" | awk -F'::' '{print $3}')
	
    # Get the issue ID from the filepath. Set the Issue ID as a label for the changeset.	
    if [[ "$filepath" =~ issues/([A-Z]+-[0-9]+)/ ]]; then
	issue_id="${BASH_REMATCH[1]}"
	echo "Issue ID: $issue_id"
		
	# Print the extracted values from the status command
	echo "Setting Issue ID Label $issue_id for Filepath: $filepath, ID: $id, Author: $author"
	
	# Use the liquibase set-labels command using the values above
	liquibase set-labels --set-as=$issue_id --changeset-author=$author --changeset-id=$id --changeset-path=$filepath
		
    else
	echo "Issue ID not found"
    fi
done

# Check in any Label changes to git
git status
add add changelogs/*
git commit -m'Added Liquibase labels to pending changesets'
git push