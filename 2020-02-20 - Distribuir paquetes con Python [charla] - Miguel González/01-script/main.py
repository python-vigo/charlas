# chove.py

import datetime as dt
import json

import urllib.request
import urllib.parse

from operator import itemgetter


parse_forecast = itemgetter("manha", "tarde", "noite")


def parse_date(value):
    return dt.datetime.strptime(value, "%Y-%m-%dT%H:%M:%S")


# Build URL
url = "http://servizos.meteogalicia.gal/rss/predicion/jsonPredConcellos.action"
query_string = urllib.parse.urlencode({"idConc": "36057"})
full_url = f"{url}?{query_string}"

# Make request
with urllib.request.urlopen(full_url) as response:
    content = response.read()

# Parse response
data = json.loads(content)
forecast = data["predConcello"]["listaPredDiaConcello"]
date = parse_date(forecast[0]["dataPredicion"])
rain_forecast = parse_forecast(forecast[0]["pchoiva"])

# Print result
print(f"La predicción para {date:%d/%m/%Y} es:")
print()
print(f"Mañana {rain_forecast[0]}%")
print(f"Tarde {rain_forecast[1]}%")
print(f"Noche {rain_forecast[2]}%")
