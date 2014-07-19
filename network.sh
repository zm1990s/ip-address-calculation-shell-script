#!/bin/bash

convertnum()
{
let se2=0
while [ $se2 -le 7 ]
do
if [ $cc -eq 1 ]
# 等于1时输出1
then
shuzux["$se1"]=1;
let cc=0
elif [ $cc -ge 2 ]
then
let bb=$cc%2
# echo $bb xx
shuzux["$se1"]=$bb
let cc=$cc/2
else
shuzux["$se1"]=0
fi
let se1=$se1+1
let se2=$se2+1
done
}


usage()
{
echo -e " usage: <ip-address> [netmask | mask length]\n example: 192.168.1.1 24\n or       192.168.1.1 255.255.255.0 \t"
continue
}


converttonum()
{
# echo $length
let se=4
let lengthmask=0
while [ $se -gt 0 ]
# ip的四个分组，每个分组进行转换，存入数组中
do
cc=`echo $length|awk 'BEGIN{FS="."}{print $'$se'}'`
case $cc in 
255)
let length1=8
;;
254)
let  length1=7
;;
252)
let  length1=6
;;
248)
let  length1=5
;;
240)
let  length1=4
;;
224)
let  length1=3
;;
192)
let  length1=2
;;
128)
let  length1=1
;;
0)
let length1=0
;;
esac
let se=$se-1
let lengthmask=$length1+$lengthmask
done
let length=$lengthmask
}

convertnumto ()
{
  case $lengthmask in
  32)
  mask=255.255.255.255
  reversemask=0.0.0.0
  ;;
   31)
  mask=255.255.255.254
   reversemask=0.0.0.1
  ;;
   30)
  mask=255.255.255.252
   reversemask=0.0.0.3
  ;;
   29)
  mask=255.255.255.248
   reversemask=0.0.0.7
  ;;
   28)
  mask=255.255.255.240
   reversemask=0.0.0.15
  ;;
   27)
  mask=255.255.255.224
   reversemask=0.0.0.31
  ;;
   26)
  mask=255.255.255.192
   reversemask=0.0.0.63
  ;;
   25)
  mask=255.255.255.128
   reversemask=0.0.0.127
  ;;
  24)
  mask=255.255.255.0
   reversemask=0.0.0.255
  ;;
   23)
  mask=255.255.254.0
   reversemask=0.0.1.255
  ;;
   22)
  mask=255.255.252.0
   reversemask=0.0.3.255
  ;; 
  21)
  mask=255.255.248.0
   reversemask=0.0.7.255
  ;;
   20)
  mask=255.255.240.0
   reversemask=0.0.15.255
  ;;
   19)
  mask=255.255.224.0
   reversemask=0.0.31.255
  ;;
   18)
  mask=255.255.192.0
   reversemask=0.0.63.255
  ;;
   17)
  mask=255.255.128.0
   reversemask=0.0.127.255
  ;;
   16)
  mask=255.255.0.0
   reversemask=0.0.255.255
  ;;
   15)
  mask=255.254.0.0
   reversemask=0.1.255.255
  ;;
   14)
  mask=255.252.0.0
  reversemask=0.3.255.255
  ;;
   13)
  mask=255.248.0.0
  reversemask=0.7.255.255
  ;;
   12)
  mask=255.240.0.0
  reversemask=0.15.255.255
  ;;
   11)
  mask=255.224.0.0
  reversemask=0.31.255.255
  ;;
   10)
  mask=255.192.0.0
  reversemask=0.63.255.255
  ;;
   9)
  mask=255.128.0.0
  reversemask=0.127.255.255
  ;;
   8)
  mask=255.0.0.0
  reversemask=0.255.255.255
  ;;
   7)
  mask=254.0.0.0
  reversemask=1.255.255.255
  ;;
   6)
  mask=252.0.0.0
  reversemask=3.255.255.255
  ;;
   5)
  mask=248.0.0.0
  reversemask=7.255.255.255
  ;;
   4)
  mask=240.0.0.0
  reversemask=15.255.255.255
  ;;
   3)
  mask=224.0.0.0
  reversemask=31.255.255.255
  ;; 
  2)
  mask=192.0.0.0
  reversemask=63.255.255.255
  ;;
  1)
  mask=128.0.0.0
  reversemask=127.255.255.255
  ;;
  0)
  mask=0.0.0.0
  reversemask=255.255.255.255
  
  esac
}


ipzhuanhuan()
{
  let se=0
# let ses1=8

while [ $se -le 3 ]
do
# cc=`echo $ip|awk 'BEGIN{FS="."}{print $'$se'}'`
# 转换第se个分组
# convertnum
let ses=$se*8
#echo $ses=?
# let ses1=$se*8
# echo ${shuzuz[10]::$ses1}
shuzucache=(`echo  ${shuzuin[@]:$ses:8}`)
# echo ${shuzucache[@]}  
# shuzucache 是8位^[[A2进制，转10进制用
let ses1=7
let sum2=0

while [ $ses1 -ge 0 ]
do

case $ses1 in
7)
let sum=${shuzucache["$ses1"]}*1
;;
6)
let sum=${shuzucache["$ses1"]}*2
;;
5)
let sum=${shuzucache["$ses1"]}*4
;;
4)
let sum=${shuzucache["$ses1"]}*8
;;
3)
let sum=${shuzucache["$ses1"]}*16
;;
2)
let sum=${shuzucache["$ses1"]}*32
;;
1)
let sum=${shuzucache["$ses1"]}*64
;;
0)
let sum=${shuzucache["$ses1"]}*128
;;
esac


let sum2=$sum+$sum2
# 计算每8位的和
let ses1=$ses1-1
done
shuzuout["$se"]=$sum2
let se=$se+1

done
}


while [ 1 ]
do
read b
case $b in 
$NULL)
continue
;;

[0-9]*.*[0-9]*.*[0-9]*.*[0-9]*[" "]*[0-9])
;;
exit|quit)
exit
;;

*)
usage
;;
esac

ip=`echo $b|awk 'BEGIN{FS=" "}{print $1}'`
let se1=0
# 设置数组初始长度,se1为全局变量，值为0-31
let se=4
while [ $se -gt 0 ]
# ip的四个分组，每个分组进行转换，存入数组中
do
cc=`echo $ip|awk 'BEGIN{FS="."}{print $'$se'}'`
# 转换第se个分组
convertnum
let se=$se-1
done

length=`echo $b|awk 'BEGIN{FS=" "}{print $2}'`

# 如果$2是掩码，则必需转换成掩码长度lengthmask
if [ `echo $length|grep '\.'` ]
then
mask=$length
converttonum 
convertnumto 
#将掩码转换成长度
else lengthmask=$length
convertnumto 
# 将长度转换成掩码
fi
# 逆序变顺序：
let se3=0
while [ $se3 -lt 32 ]
# 总共要循环32次，将32位都转了
do
let se4=31-$se3
if [ $length -gt 0 ]
then
shuzuy["$se3"]=${shuzux["$se4"]}
else shuzuy["$se3"]=0
# 如果length大于0,则照样输出，超出length的部分全清0
fi
let length=$length-1
# echo ${shuzuy["$se3"]}
let se3=$se3+1
done
shuzuz=(${shuzuy[@]})
shuzue=(${shuzuy[@]})
# let se5=$lengthmask+1
# echo se5=$se5
shuzuz[31]=1
# echo shuzuz=${shuzuz[@]}
let se=$lengthmask
while [ $se -lt 31 ] 
do
shuzue["$se"]=1
let se=$se+1
done


# echo ${shuzuy[@]}

# 2进制转换回10进制。。。。。
# 也是四个组合，8位对应乘相应的数再相加输出
shuzuin=(${shuzuy[@]})
ipzhuanhuan
ipfinal=(${shuzuout[@]})

shuzuin=(${shuzuz[@]})
ipzhuanhuan
ipstart=(${shuzuout[@]})

shuzuin=(${shuzue[@]})
ipzhuanhuan
ipend=(${shuzuout[@]})





echo -e "\n网段：\t\t`echo ${ipfinal[@]} |awk '{print $1"."$2"."$3"."$4}'`"
# echo -e "\n网段：${ipfinal[@]} "|awk '{print $0}'
echo -e  "掩码位数：\t$lengthmask"
echo -e "子网掩码：\t$mask"
echo -e "反掩码：\t$reversemask"
echo -e "ip范围：\t`echo ${ipstart[@]} |awk '{print $1"."$2"."$3"."$4}'` - `echo ${ipend[@]} |awk '{print $1"."$2"."$3"."$4}'`\n"

unset length
done
