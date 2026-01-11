#!/bin/bash
sudo nmap -PS -p 20,80,443 -sn $1
