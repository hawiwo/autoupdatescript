# autoupdatescript
das script prüft (git diff) ob die online repository aktueller ist und
updated dann ggf. das lokale Verzeichnis. Weitere Scripts und Dateien können hinzugefügt werden.
Branches können mit git checkout origin/{BRANCH} gewechselt werden. Wichtig: die Zeile BRANCH="{BRANCH}" muss passen

Änderungen an der crontab in der auto function
    # crontab -l | sed -E '/#.*updatethingspeak\.sh.*/s/^#//' | crontab -
    # crontab -l | sed -E '/.*updatethingspeak\.sh.*/s/^/#/' | crontab -
    # crontab -l | sed '/\*\/15/c\2 0 * * * \/bin\/bash \/home\/pi\/autoupdatescript\/updatethingspeak.sh' | crontab -
    # crontab -l | sed '/updatethingspeak.sh 2/c\2 0 * * * \/bin\/bash \/home\/pi\/autoupdatescript\/updatethingspeak.sh 2' | crontab -
