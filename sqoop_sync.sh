tft() {
    if [ ${1:8:2} -lt 7 ]
    then d=`date -d "${1:0:8} -1 day" +%Y%m%d`
    else d=${1:0:8}
    fi
    stm="to_date('`date -d "$d" +%Y-%m-%d` 07:30:00', 'yyyy-mm-dd hh24:mi:ss')"
    etm="to_date('`date -d "$d 1 day" +%Y-%m-%d` 07:30:00', 'yyyy-mm-dd hh24:mi:ss')"
    }
# job
sqp_imp_d() {
    sqoop eval --connect $conn --username $u --password $p --query "select 1 from dual$rl" || (echo "Error!"; exit 1)
    impala-shell -q "alter table $hdb.$htb drop if exists partition (date_timekey='$d')" || (echo "Error!"; exit 1)
    sqoop import --connect $conn --username $u --password $p --query "$sql" --hcatalog-database $hdb --hcatalog-table $htb --hcatalog-home $hchm -m 1 --hcatalog-partition-keys date_timekey --hcatalog-partition-values $d || (echo "Error!"; exit 1)
    hdfs dfs -rm -r -f -skipTrash /user/hive/warehouse/$hdb.db/$htb/_SCRATCH*
    impala-shell -q "refresh $hdb.$htb partition (date_timekey='$d')" || (echo "Error!"; exit 1)
    }

tft $2 
source $1 || (echo "Error!"; exit 1)
sqp_imp_d
