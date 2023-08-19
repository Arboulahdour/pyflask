import json
import os

def assert_close_enough(actual, expected, tolerance):
    return abs(actual - expected) <= tolerance

def test_index(app, client):
    res = client.get('/')
    assert res.status_code == 200

    response_data = json.loads(res.get_data(as_text=True), object_pairs_hook=dict)

    python_version = response_data['pythonVersion']

    assert response_data['name'] == 'pyflask'
    assert response_data['appVersion'] == os.environ['VERSION']
    assert response_data['pythonVersion'] == python_version
    assert response_data['status'] == 'running'

    # Calculate tolerances based on the provided values and acceptable variation
    uptime_tolerance = 5  # seconds
    memory_tolerance = 50000  # kilobytes
    cpu_tolerance = 1.0  # percentage

    # Perform assertions with calculated tolerances
    assert response_data['uptime'] >= 10 - uptime_tolerance
    assert_close_enough(response_data['memoryUsage']['total'], 2030940 * 1024, memory_tolerance)
    assert_close_enough(response_data['memoryUsage']['available'], 1459336 * 1024, memory_tolerance)
    assert_close_enough(response_data['memoryUsage']['used'], 374468 * 1024, memory_tolerance)
    assert_close_enough(response_data['cpuUsage'], 0.05, cpu_tolerance)  # Using the load average value
    assert isinstance(response_data['processId'], int)