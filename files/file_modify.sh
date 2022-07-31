#/bin/sh
# define array
dirs=(
"demo"
"demo2"
)

# define a associate array，must in bash version 4
declare -A dic
dic=(
    [cont]="replace"
    [cont2]="replace2"
)

for dir in "${dirs[@]}"; do
    if [ -d "${dir}/" ]; then
        echo "${dir}"
        cd ${dir}
        for key in $(echo ${!dic[*]}); do
            value=${dic[${key}]}
            echo "${key} ==> ${value}"
            # 1.修改文件内容，在 MAC 系统下，sed -i 后面要接 “” 或 备份文件
            grep -rl ${key} --exclude="*.bin" --exclude-dir="tool" | xargs sed -i "" "s/${key}/${value}/g"
            # 3.修改文件夹名
            find . -name "*${key}*" -type d | sed -e "p;s/${key}/${value}/g" | xargs -n2 mv
            # 2.修改文件名
            find . -name "*${key}*" -type f | sed -e "p;s/${key}/${value}/g" | xargs -n2 mv
        done
        cd -
    else
        echo "dir not exist!"
    fi
done
