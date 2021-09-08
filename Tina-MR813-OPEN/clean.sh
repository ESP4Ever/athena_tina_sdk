#!/bin/bash
work_dir=$(pwd)
rm -rf ${work_dir}/out/*
rm -rf ${work_dir}/tmp

cd ${work_dir}/lichee/linux-4.9
make clean

cd ${work_dir}/lichee/brandy-2.0/u-boot-2018
make clean

cd ${work_dir}/lichee/brandy-2.0/spl
make clean

cd ${work_dir}
