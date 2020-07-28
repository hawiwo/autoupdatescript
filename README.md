# autoupdatescript

Das script prüft (git diff) ob die online repository aktueller ist und
updated sich dann ggf. **main** wird dann mit aktualisiertem script aufgerufen.
Branches können mit git checkout origin/{BRANCH} gewechselt werden. Wichtig: die Zeile BRANCH="{BRANCH}" muss passen

---

## Änderungen an der crontab

### Zeile ändern

```
crontab -l | sed -E '/#.*updatethingspeak\.sh.*/s/^#//' | crontab -
crontab -l | sed -E '/.*updatethingspeak\.sh.*/s/^/#/' | crontab -
crontab -l | sed '/\*\/15/c\2 0 * * * \/bin\/bash \/home\/pi\/autoupdatescript\/updatethingspeak.sh' | crontab -
crontab -l | sed '/updatethingspeak.sh 2/c\2 0 * * * \/bin\/bash \/home\/pi\/autoupdatescript\/updatethingspeak.sh 2' | crontab -
```

### Zeile danach/davor einfügen

```
crontab -l | sed '/updatethingspeak.sh 2/a\2 0 * * * \/bin\/bash \/home\/pi\/autoupdatescript\/updatethingspeak.sh 2' | crontab -
crontab -l | sed '/updatethingspeak.sh 2/i\2 0 * * * \/bin\/bash \/home\/pi\/autoupdatescript\/updatethingspeak.sh 2' | crontab -
```
## Webseiten Daten posten
curl -X POST -F "field1=$(date +"%Y-%m-%d %H:%M:%S")$((RANDOM%1+50)).$((RANDOM%999))" -k http://www.waldhof1.de/cs.php
