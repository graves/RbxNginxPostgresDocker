#!/bin/bash
APPNAME='SampleApp'

cd /var/www/$APPNAME && rake db:create && rake db:migrate && foreman start
