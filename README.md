# Docker-Adventskalender

Ein Adventskalender im Container: vom 1. bis 24. Dezember zeigt jeder Start das Türchen des Tages.

```bash
docker run --rm tdeutsch/adventskalender:2022
# oder
docker run --rm ghcr.io/tuxpeople/adventskalender:2022
```

## Jahrgänge

Das Tag ist die Jahreszahl, jedes Jahr hat eigene Türchen:

| Tag | Inhalt |
|---|---|
| `2019`, `2020` | Zitate zur Adventszeit |
| `2022` | Kubernetes-Tipps, mit Giraffe |

Es gibt bewusst kein `latest`.

## Neues Jahr

1. Einen bestehenden Jahrgang kopieren, z.B. `cp -r years/2022 years/2026`
2. Die 24 Türchen ersetzen (eine Zeile pro Tag) und `entrypoint.sh` bei Bedarf anpassen
3. Lokal testen: `docker build --build-arg YEAR=2026 -t advent:2026 . && bash test.sh advent:2026`
4. PR öffnen; nach dem Merge wird `:2026` auf Docker Hub und GHCR veröffentlicht

## Aufbau

- `years/<Jahr>/`: `entrypoint.sh` und die Texte eines Jahrgangs
- `Dockerfile`: gemeinsam für alle Jahre (`--build-arg YEAR=<Jahr>`), Alpine, läuft als UID 1000
- `test.sh`: prüft ein Image vor, während (1., 12., 24.) und nach dem Advent mit einem gefälschten `date`
- `.github/workflows/build.yml`: baut und testet jeden Jahrgang; auf `master` und monatlich werden alle Jahrgänge neu veröffentlicht (Sicherheitsupdates, die Tags bleiben gleich), signiert mit Cosign, mit SBOM- und Provenance-Attestation
