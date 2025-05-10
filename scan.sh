#!/bin/bash

echo "Welcome to Simple Nmap Bash Scanner"
read -p "Enter the target IP or domain: " target

if [[ -z "$target" ]]; then
    echo "Error: No target provided."
    exit 1
fi

mkdir -p results

timestamp=$(date +"%Y%m%d_%H%M%S")
filename="results/${target}_${timestamp}_scan.txt"

echo "Scanning host: $target"
echo "Results will be saved in $filename"

echo "Running Ping Scan..." | tee -a "$filename"
nmap -sn "$target" | tee -a "$filename"

echo -e "\nRunning Port Scan..." | tee -a "$filename"
nmap -p- "$target" | tee -a "$filename"

echo -e "\nRunning OS Detection and Service Version Scan..." | tee -a "$filename"
nmap -A "$target" | tee -a "$filename"

echo -e "\nScan completed. Check the file: $filename"

