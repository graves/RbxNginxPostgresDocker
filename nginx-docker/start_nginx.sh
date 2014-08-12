#!/bin/bash
PUMASOCKET='/tmp/sockets/puma.sock'

chmod 777 "$PUMASOCKET" && nginx
