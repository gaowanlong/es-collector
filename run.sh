#!/bin/bash -x
# Copyright: EasyStack
# Author: Wanlong Gao <wanlong.gao@easystack.cn>
#
# This is the main script.

SRC_DIR=$(dirname $0)
mkdir -p $SRC_DIR/logs
for collector in $(find $SRC_DIR/collectors -executable ! -type d)
do
	collector_name=$(basename $collector)
	log_file=$SRC_DIR/logs/$collector_name
	{
		date +"%F %T" >>$log_file
		$collector &>>$log_file
		date +"%F %T" >>$log_file
		gzip -f $log_file
	} &
done

wait
