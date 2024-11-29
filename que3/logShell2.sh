#!/bin/bash
# Declare an associative array(map) to track bookings
declare -A bookings

# Read the log file line by line 
while IFS= read -r line; do
    # Extract necessary fields from each log entry
    user=$(echo "$line" | awk '{print $3}')
    action=$(echo "$line" | awk '{print $5}')
    source=$(echo "$line" | awk '{print $8}')
    destination=$(echo "$line" | awk '{print $10}')

    # Combining user, source, and destination for creating a  unique key
    key="$user $source $destination"

    # Handling booking and cancellation logic
    if [[ "$action" == "booked" ]]; then
        ((bookings["$key"]++))  # Increment booking count
    elif [[ "$action" == "cancelled" ]]; then
        ((bookings["$key"]--))  # Decrement booking count if cancelled
    fi

    echo "$key"
done < "$1"

# Output the results: user and the number of bookings
for key in "${!bookings[@]}"; do
    # Extract the user from the key (the first part of the key is the user)
    name=$(echo "$key" | awk '{print $1}')
    count={bookings["key"]}

    # Output the user and the booking count for this key
    echo "$name $count"
done

