from flask import Flask, request, jsonify
from flask_cors import CORS
import os
import yaml
import sys 

from functools import wraps
from monitorcontrol import *

app = Flask(__name__)
cors = CORS(app) # !!! Remove if CORS is handled by nginx
port = 5000

# API Key Setup
VALID_API_KEYS = ['YOUR_API_KEY']
def require_api_key(view_func):
    @wraps(view_func)
    def decorated_func(*args, **kwargs):
        api_key = request.headers.get('X-API-Key')

        if not api_key or api_key not in VALID_API_KEYS:
            return jsonify(error='Invalid API key'), 401

        return view_func(*args, **kwargs)

    return decorated_func

@app.route('/')
def home():
	return 'MonitorControl App'

@app.route('/get_port', methods=['GET'])
@require_api_key
def get_port():
    return jsonify(message=f'MonitorControl running on {port}')
    
@app.route('/set_brightness', methods=['POST'])
@require_api_key
def set_brightness():
    try:
        data = request.get_json()
        brightness = data.get('brightness')
        
        if brightness is None:
            return jsonify(error='Brightness level not provided'), 400
        
        if not (0 <= brightness <= 100):
            return jsonify(error='Brightness level must be between 0 and 100'), 400
        
        set_monitor_brightness(brightness)
        
        return jsonify(message='Brightness set successfully'), 200
    
    except Exception as e:
        return jsonify(error=str(e)), 500

def set_monitor_brightness(brightness_level):
    config_file = 'config.yml'

    config = read_config(config_file)
    max_luminance_monitor0 = config['max_luminance']['monitor0']
    max_luminance_monitor1 = config['max_luminance']['monitor1']

    brightness_level = validate_brightness_level(brightness_level)

    adjustment_factor_monitor0 = 100 / max_luminance_monitor0
    adjustment_factor_monitor1 = 100 / max_luminance_monitor1

    adjusted_brightness_level_monitor0 = int(brightness_level * adjustment_factor_monitor0)
    adjusted_brightness_level_monitor1 = int(brightness_level * adjustment_factor_monitor1)

    brightness_list = [adjusted_brightness_level_monitor0, adjusted_brightness_level_monitor1]
    try:
        count = 0
        for monitor in get_monitors():
            with monitor:
                monitor.set_luminance(brightness_list[count])
            count += 1

        print("Brightness set successfully for both monitors.")
    except Exception as e:
        print(f"Error setting brightness: {e}")

def validate_brightness_level(brightness_level):
    try:
        brightness_level = int(brightness_level)
    except ValueError:
        print("Error: Invalid brightness level. It should be an integer.")

    if brightness_level < 0 or brightness_level > 100:
        print("Error: Invalid brightness level. It should be between 0 and 100.")

    return brightness_level

def read_config(config_file):
    if not os.path.exists(config_file):
        print(f"Configuration file not found: {config_file}")

    with open(config_file, 'r') as file:
        config = yaml.safe_load(file)

    return config

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)