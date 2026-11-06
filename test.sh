#!/usr/bin/env bash
# Smoke test for one year's image: before, during and after Advent.
# A fake `date` in /usr/local/bin (ahead of /bin in PATH) sets the day.
# Usage: test.sh <image>
set -euo pipefail
image="$1"
# Not in $TMPDIR: Colima does not share it with its VM
mkdir -p "$HOME/.cache"
fake="$(mktemp -d "$HOME/.cache/advent-test.XXXXXX")"
trap 'rm -rf "$fake"' EXIT

run_on() { # run_on <MMDD>
  cat >"$fake/date" <<EOF
#!/bin/sh
case "\$1" in
  +%m%d) echo $1 ;;
  +%d) echo ${1:2:2} ;;
  +%-d) echo $((10#${1:2:2})) ;;
  *) exec /bin/date "\$@" ;;
esac
EOF
  chmod 755 "$fake/date"
  docker run --rm --read-only --cap-drop ALL -v "$fake/date:/usr/local/bin/date:ro" "$image"
}

out=$(run_on 1130)
grep -q "noch nicht Advent" <<<"$out" || { echo "::error::30 Nov: $out"; exit 1; }

for day in 01 12 24; do
  out=$(run_on "12${day}")
  grep -q "TÜRCHEN $((10#$day))" <<<"$out" || { echo "::error::$day Dec: no door"; echo "$out"; exit 1; }
  # Every door has content: more than the heading and the signature
  [[ $(grep -c '[[:alnum:]]' <<<"$out") -ge 3 ]] || { echo "::error::$day Dec: empty door"; echo "$out"; exit 1; }
done
echo "$out"

out=$(run_on 1225)
grep -q "nicht mehr Advent" <<<"$out" || { echo "::error::25 Dec: $out"; exit 1; }

[[ "$(docker inspect --format '{{.Config.User}}' "$image")" == "1000" ]]
echo "✅ $image: before, during (1, 12, 24) and after Advent, runs as UID 1000"
