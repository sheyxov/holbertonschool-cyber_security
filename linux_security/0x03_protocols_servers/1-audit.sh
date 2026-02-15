#!/bin/bash
sudo sshd -T | grep -v -E '^(port|protocol|listenaddress)'
