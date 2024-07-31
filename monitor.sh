#!/bin/bash

# Numero di esecuzioni desiderate
N=20

# File di output per la raccolta dei dati CPU
CPU_USAGE_FILE="cpu_usage.txt"

# Inizializzare il file di output (opzionale, per rimuovere dati precedenti)
echo "Raccolta dati CPU" > $CPU_USAGE_FILE

# Avviare il programma Rust e raccogliere i dati per N volte
for ((i=1; i<=N; i++))
do
    # Eseguire il programma Rust in background
    ./10claim &

    # PID del programma Rust
    PID=$!

    # Raccolta dati CPU con top in modalità batch, appending al file di output
    echo "Esecuzione $i" >> $CPU_USAGE_FILE
    top -b -d 1 -n 10 >> $CPU_USAGE_FILE

    # Attendere che il programma Rust termini
    wait $PID

    echo "Esecuzione $i completata."
done

echo "Raccolta dati completata."
