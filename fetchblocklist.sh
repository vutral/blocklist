#!/bin/sh

URL1='http://list.iblocklist.com/?list=ydxerpxkpcfqjaybcssw&fileformat=p2p&archiveformat=gz'

wget -Y off -O level1.p2p.gz $URL1
gunzip level1.p2p.gz

