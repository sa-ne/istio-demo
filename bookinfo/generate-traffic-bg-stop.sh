#!/bin/bash

ps -ef | grep generate-traffic.sh | grep -v grep | awk '{ print $2 }' | xargs kill -9
