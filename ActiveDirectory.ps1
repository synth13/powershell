#########################################
#Global Variables
#########################################
$ggName =  "Global_Group_Name"

#########################################
#functions
#########################################

function Get-GGMembers ($ggName) {
    <#
        get-adgroupmember fields returned by command
            distingusihedName - contains organizations and OUs
            name - user's acutal name
            objectClass - user or usergroup
            objectGUID
            SamAccountName - unique name ID
            SID
    #>

    $ggMembers = get-adgroupmember $ggName | ? {$_.objectClass -eq "user"} | select -ExpandProperty SamAccountName

    return $ggMembers
}

function Get-MembersProfileInfo ($ggMembers) {
    <#
        get-ADUser fields returned by command
            DistinguishedName
            Enabled
            GivenName
            ObjectClass
            ObjectGUID
            SamAccountName
            SID
            Surname
            UserPrincipalName
    #>    
    
    $memberProfileInfo = @()

    foreach ($ggMember in $ggMembers) {

    $memberProfileInfo += get-ADUser $ggMember | Select -ExpandProperty UserPrincipalName

    }


    return $memberProfileInfo
}


$ggMembers = Get-GGMembers $ggName

$memberProfileInfo = Get-MembersProfileInfo $ggMembers
