from flask import Flask, jsonify
from datetime import datetime
import os
import psutil
import platform

app = Flask(__name__)


@app.route('/')
def index():
    python_version = platform.python_version()
    memory_usage = psutil.virtual_memory()
    cpu_usage = psutil.cpu_percent(interval=1)
    process_id = os.getpid()
    boot_time = psutil.boot_time()
    uptime_seconds = int((datetime.now().timestamp() - boot_time))
    return jsonify({'name': 'pyflask',
                    'appVersion': os.environ['VERSION'],
                    'pythonVersion': python_version,
                    'status': 'running',
                    'uptime': uptime_seconds,
                    'memoryUsage': {
                      'total': memory_usage.total,
                      'available': memory_usage.available,
                      'used': memory_usage.used
                    },
                    'cpuUsage': cpu_usage,
                    'processId': process_id
                })


if __name__ == '__main__':
    app.run(host="0.0.0.0", port="5000", debug=True)