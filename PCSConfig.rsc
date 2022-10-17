#get script file
/tool/fetch "https://git.eworm.de/cgit/routeros-scripts/plain/" 

#Variables
:global clouddns

#Ajustement du firewall pour PCS
/ip firewall/ address-list/ add list=PCS address=remote.pcsupreme.com
/ip firewall/ filter/ add chain=input protocol=tcp dst-port=8291 in-interface-list=WAN src-address-list=PCS action=accept comment="PCS WinBox Allow"

#Récupérations des informations
set $clouddns /ip/cloud/print
/system backup save name=email_backup
/tool e-mail send file=email_backup.backup to="me@test.com" body="See attached file" \
   subject="$[/system identity get name] $[/system clock get time] $[/system clock get date] Backup")
