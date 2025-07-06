#!/bin/bash
rm metar.txt
curl https://metar.vatsim.net/all -o metar.txt
