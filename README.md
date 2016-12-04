# Convert IMDB actors.list and actresses.list files to JSON

This should create a map of actors/actresses to the movies and TV shows they
have participated in. It edits files in-place with sed-like speed.

## Usage
```
$ curl -O ftp://ftp.fu-berlin.de/pub/misc/movies/database/actors.list.gz
$ gzip -d actors.list.gz
$ mv actors.list actors.json
$ ./actorsListToJSON actors.json
```

## Prerequisites
Older versions of Perl may work, but this script has been tested with v5.24.0.

## After creating the file
```python
import json

with open('actors.json', encoding='ISO-8859-1') as data_file:
    data = json.load(data_file)
    print(data['Bacon, Kevin (I)'])
```
