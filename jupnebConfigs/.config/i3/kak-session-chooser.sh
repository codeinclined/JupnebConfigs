#!/bin/sh

rofi -version &> /dev/null

if [ $? -ne 0 ]; then
    MENU_CMD="dmenu"
    MENU_ARGS=
else
    MENU_CMD="rofi"
    MENU_ARGS=(-dmenu -i -width -80 -p kak-session: -mesg $'SESSION\t\t\t\t\tUSER')
fi

SESSION_LIST=

for KAK_USER in $(ls -1 /tmp/kakoune); do
    for KAK_USER_SESSION in $(ls -1 /tmp/kakoune/"${KAK_USER}"); do
        SESSION_LIST="${SESSION_LIST}${KAK_USER_SESSION}\t\t\t\t\t${KAK_USER}\n"
    done
done

SESSION_LIST="${SESSION_LIST}"'(New session...)'

MENU_INPUT=$(printf "${SESSION_LIST}" | "$MENU_CMD" "${MENU_ARGS[@]}")

if [ $? -eq 0 ]; then
    if [ "$MENU_INPUT" == '(New session...)' ]; then
        SESSION_CHOICE=$(${MENU_CMD} ${MENU_ARGS[@]})
	if [ $? -eq 0 ]; then
            kak -s "${SESSION_CHOICE}"
        fi
    else
        SESSION_CHOICE=$(printf "${MENU_INPUT}" | awk '{print $1}')
        SESSION_USER=$(printf "${MENU_INPUT}" | awk '{print $(NF)}') 
        kak -c "${SESSION_USER}/${SESSION_CHOICE}" $@
    fi
fi
