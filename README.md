yandex-tank-ammo-generator
==========================

Ammo file generator for yandex-tank

Usage
=====

```
Ammo generator for yandex-tank v.2
  
Usage: ./ammo-generator -u url -[cmrh]
  -u: url (like http://host/uri)
  -c: cookies
  -m: method (GET, POST) by default will be GET
  -r: run yandex-tank againt created ammo file
  -h: help

Examples:
  
  1)

  ./ammo-generator -u "http://localhost/index.html"
  
  will generate file 'ammo_localhost_index.html.txt':
    136
    GET /index.html HTTP/1.1
    User-Agent: YandexTank/1.1.1
    Host: localhost
    Accept-Encoding: gzip, deflate
    Cookie: 
    Connection: Close

  2)

  ./ammo-generator -u "http://localhost/index.html" -r

  will generate file 'ammo_localhost_index.html.txt' and run yandex-tank:
    yandex-tank ammo_localhost_index.html.txt

  3)

  ./ammo-generator -u "http://localhost/index.html" -c "sessionId: xxx"
  will generate file 'ammo_localhost_index.html.txt':
    150
    GET /index.html HTTP/1.1
    User-Agent: YandexTank/1.1.1
    Host: localhost
    Accept-Encoding: gzip, deflate
    Cookie: sessionId: xxx
    Connection: Close

  4)

  ./ammo-generator -u "http://localhost/index.html" -c "sessionId: xxx" -m POST
  will generate file 'ammo_localhost_index.html.txt':
    151
    POST /index.html HTTP/1.1
    User-Agent: YandexTank/1.1.1
    Host: localhost
    Accept-Encoding: gzip, deflate
    Cookie: sessionId: xxx
    Connection: Close
```
