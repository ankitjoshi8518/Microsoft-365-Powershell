# Enable winrm basic auth from command prompt. REMEMBER TO DISABLE THIS ON YOUR COMPUTER AFTER COMPLETING THE TASK
winrm get winrm/config/client/auth
winrm set winrm/config/client/auth @{Basic="true"}

# go to Exchange admin center > Hybrid > Click on Configure (Exchange online powershell)
# create csv file with the minimum following content

Name              DisplayName    PrimarySmtpAddress                      
DIST GROUP NAME   DISPLAY NAME   smtpaddressgroup1@domain.com
DIST GROUP NAME 2 DISPLAY NAME 2 smtpaddressgroup2@domain.com

#Importing csv and creating distribution group for internal users only
$distgroup=import-csv -path \\pathtocsvfile
$testdist | foreach-object {New-DistributionGroup -Name $_.Name -DisplayName $_.displayname -PrimarySmtpAddress $_.primarysmtpaddress -RequireSenderAuthenticationEnabled $true }

#Add members to distribution groups
Add-DistributionGroupMember -Identity DLPrimarysmtp@domain.com -Member useremail@domain.com
