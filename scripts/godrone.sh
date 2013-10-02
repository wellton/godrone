#!/bin/sh
# godrone.sh kills the Parrot firmware (if neccessary) and launches the next
# godrone.next binary.
set -eu

bin="${1}"

touch /tmp/.norespawn
killall -9 program.elf || true
killall -9 "${bin}" || true
cd /data/video
rm -f "${bin}"
mv "${bin}.next" "${bin}"
chmod +x "${bin}"
# Taken from /bin/program.elf.respawner.sh. Not sure why/if it is needed, seems
# to turn the bottom LED red.
gpio 181 -d ho 1
GOGCTRACE=1 "./${bin}"