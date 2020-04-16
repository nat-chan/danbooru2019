#!/bin/bash
test(){
    path=$1
    if [ -z "$path" ]; then
        path=/danbooru2019/512px/0051/
    fi
    rsync \
    --stats \
    --human-readable \
    --verbose \
    --dry-run \
    rsync://78.46.86.149:873$path .$path
}


main(){
    path=$1
    if [ -z "$path" ]; then
        path=/danbooru2019/original/0001/
    fi
    mkdir -p .$path
    rsync \
    --human-readable \
    --info=progress2 \
    rsync://78.46.86.149:873$path .$path
}

for i in {0000..0999}; do
    main /danbooru2019/original/$i/
    echo $i
done

: << 'EOF'

--stats \
--human-readable \
--progress \
--verbose \
--dry-run \

-a または --archive … アーカイブモード。-rlptgoD を指定したのと同じ (-H が含まれていないことに注意)
具体的には下記オプションを全て指定したのと同じである。
-r: ディレクトリを再帰的にコピー
-l: シンボリックリンクを、そのままシンボリックリンクとしてコピー
-p: パーミッションをそのままコピー
-t: タイムスタンプをそのままコピー
-g: グループをそのままコピー
-o: ファイルオーナー (所有者) をそのままコピー
-D: デバイスファイルやを特殊ファイルを、そのままコピー

EOF
