import json
import sys, os

myPath = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, myPath + '/../')

def test_index(app, client):
    res = client.get('/')
    assert res.status_code == 200
    expected = {'Python': 'Flask Application !!!'}
    assert expected == json.loads(res.get_data(as_text=True))
