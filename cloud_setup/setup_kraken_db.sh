#/bin/bash

#usage: bash setup_db.sh path_to_place_db use_small_db
# bash setup_db.sh /dev/sda4/kdb2/ 1


use_small_db=0
db_path=$1
echo "num args" $#
if [[ $# -eq 2 ]]; then
    use_small_db=1

fi

db_link=""
db_zip=""
if [[ $use_small_db -eq 1 ]];
then
        db_link="https://genome-idx.s3.amazonaws.com/kraken/k2_standard_08gb_20230314.tar.gz"
        db_zip="k2_standard_08gb_20230314.tar.gz"
else
        db_link="https://genome-idx.s3.amazonaws.com/kraken/k2_standard_20230314.tar.gz"
        db_zip="k2_standard_20230314.tar.gz"
fi

cd $db_path
wget $db_link
tar -xvzf $db_zip
cd -
