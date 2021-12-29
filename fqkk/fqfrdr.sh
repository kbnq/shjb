rm -rf ja.txt ju.txt ji.txt js.txt
r=$(awk 'BEGIN{srand();printf "%.16f\n",rand()}')
ua=$(cat ua.txt)
ck=$(cat ck.txt)
rw=$(cat rw.txt)
zlm=
if [ -s zlm.txt ]
then zlm=$(cat zlm.txt)
zs=1
fi
curl -k -i --raw -o fqfrdr.txt "http://$rw/fast_reada/do_read?for=$zlm&zs=$zs&pageshow&r=$r" -H "Host: $rw" -H "Proxy-Connection: keep-alive" -H "User-Agent: $ua" -H "X-Requested-With: XMLHttpRequest" -H "Accept: */*" -H "Cookie: $ck" -H "Referer: http://$rw/fast_reada/read" -H "Accept-Encoding: gunzip, deflate" -H "Accept-Language: zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7" -s
if [ $(grep -c "oauth2" fqfrdr.txt) -eq 1 ]
then jkey=$(cat fqfrdr.txt | grep -o "jkey.*" | cut -d '"' -f3)
if [ -n "$jkey" ]
then echo $jkey > jkey.txt
else rm -rf jkey.txt
fi
echo $(cat fqfrdr.txt | grep -o "appid.*" | cut -d '&' -f1 | cut -d '=' -f2) > ja.txt
echo $(cat fqfrdr.txt | grep -o "uri.*" | cut -d "%" -f4 | cut -c 3-) > ju.txt
echo $(cat fqfrdr.txt | grep -o "%3D.*" | cut -d '&' -f1 | cut -c 4-) > ji.txt
echo $(cat fqfrdr.txt | grep -o "state.*" | cut -d '&' -f1 | cut -d '=' -f2) > js.txt
else dt=$(date '+%Y-%m-%d %H:%M:%S')
echo $dt 未检测到微信授权，每天第一次阅读需要手动阅读进行微信授权，若已授权则检查是否黑号 > ckerror.txt
fi
