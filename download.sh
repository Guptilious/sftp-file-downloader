#!/bin/sh

DATE_END=$(date -u +%Y%m%d)
DATE_START=$(date -u +%Y%m%d -d "-37 days")
CLIENT="<CLIENT_NAME>"
URL="sftp.<URL>.com"

curr="$DATE_START"

while true; do
        INCLUDE="${INCLUDE:+$INCLUDE }--include-glob=${curr}_export_*.csv"

lftp -e "mirror -r --exclude-glob=* $INCLUDE /csv; exit;" "sftp://$CLIENT@$URL"    # ensure you access the server manually first as logins can sometimes be rejected. This example runs using a .netrc file for credentials.

    [ "$curr" \< "$DATE_END" ] || break
    curr=$( date +%Y%m%d --date "$curr +1 day" )
done

exit 0
