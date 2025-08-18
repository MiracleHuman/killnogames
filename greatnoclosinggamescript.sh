
# Sleep for 5 seconds
#sleep 5

# Get the class of the active window
active_class=$(hyprctl activewindow -j | jq -r ".class")

# Define an array of process names to check
process_names=("lastepoch" "dota2" "another_process" "yet_another_process")

# Flag to indicate if the active class matches any process name
is_child_process=false

# Loop through the array to check for matches
for process in "${process_names[@]}"; do
    if [[ "$active_class" == "$process" ]]; then
        is_child_process=true
        break
    fi
done

# Check if the active window is one of the specified processes
if $is_child_process; then
    # If the active window is one of the specified processes, do nothing
    exit 0
else 
    # Check if the active window class is "Steam"
    if [[ "$active_class" == "steam" ]]; then
        # Unmap (hide) the Steam window
        xdotool windowunmap $(xdotool getactivewindow)
    else
        # If the active window is not one of the specified processes, kill the active window
        hyprctl dispatch killactive ""
    fi
fi

