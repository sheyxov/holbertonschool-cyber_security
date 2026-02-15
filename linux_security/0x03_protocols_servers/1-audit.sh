#!/bin/bash
sudo sshd -T | grep -vE '^(port|protocol|listenaddress)'
