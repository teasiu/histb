# extra scripts

extra_scripts_path=${WORK_PATH}/package_files/bin_scripts


extra_scripts=`find ${extra_scripts_path}|grep "\.sh$"`
for i in $extra_scripts ;do
    extra_script_file=`basename $i`
    extra_script_name=$(echo ${extra_script_file%.sh})

    # copy files to rootfs
    extra_script_files=${extra_scripts_path}/${extra_script_name}.files
    if [ -d ${extra_script_files} ]; then
        cp -a ${extra_script_files}/* ${ROOTFS}
    fi

    cp -a ${extra_scripts_path}/$extra_script_file ${ROOTFS}/usr/bin
    chmod +x ${ROOTFS}/usr/bin/$extra_script_file

    echo "extra script "$extra_script_file" added"
done


