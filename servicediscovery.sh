aws ec2 describe-instances --region $1 --filters 'Name=tag:prometheus,Values=on' --output text --query 'Reservations[].Instances[].[PrivateIpAddress]' > instances_ips

sed  -i 's/$/:9100/g' instances_ips
sed  -i 's/^/"/g' instances_ips
sed  -i 's/$/"/g' instances_ips
sed  -i 's/$/,/g' instances_ips
tr '\n' ' ' < instances_ips > instances_ips_final
sed -i 's/^/[/g' instances_ips_final
sed -i 's/$/]/g' instances_ips_final
sed -i 's/^/    - targets: /' instances_ips_final
targets=`cat instances_ips_final`

sed -i "29s/.*/$targets/" $2

systemctl restart prometheus.service
