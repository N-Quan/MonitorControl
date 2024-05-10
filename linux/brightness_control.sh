# Check if an argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <brightness_level>"
    echo "brightness_level should be an integer from 0 to 100"
    exit 1
fi

# Extract the brightness level from the argument
brightness_level=$1

# Validate the brightness level
if ! [[ "$brightness_level" =~ ^[0-9]+$ ]]; then
    echo "Error: Invalid brightness level. It should be an integer."
    exit 1
fi

if [ "$brightness_level" -lt 0 ] || [ "$brightness_level" -gt 100 ]; then
    echo "Error: Invalid brightness level. It should be between 0 and 100."
    exit 1
fi

echo $brightness_level

# Get the maximum luminance value of each monitor
# max_luminance_monitor0=$(monitorcontrol --monitor 0 --get-max-luminance)
# max_luminance_monitor1=$(monitorcontrol --monitor 1 --get-max-luminance)
max_luminance_monitor0=100
max_luminance_monitor1=30
# Calculate the relative adjustment factors for each monitor
adjustment_factor_monitor0=$(echo "scale=2; 100 / $max_luminance_monitor0" | bc)
adjustment_factor_monitor1=$(echo "scale=2; 100 / $max_luminance_monitor1" | bc)

# Apply the relative adjustment factors to the brightness level
adjusted_brightness_level_monitor0=$(echo "scale=2; $brightness_level * $adjustment_factor_monitor0" | bc)
adjusted_brightness_level_monitor1=$(echo "scale=2; $brightness_level * $adjustment_factor_monitor1" | bc)

# Set the adjusted luminance of each monitor
monitorcontrol --monitor 0 --set-luminance "$adjusted_brightness_level_monitor0"
monitorcontrol --monitor 1 --set-luminance "$adjusted_brightness_level_monitor1"
