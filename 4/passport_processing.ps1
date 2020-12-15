<#

#>
[CmdletBinding()]
Param()

# Get input
[string[]]$BulkInput = @()
Do {
    $UserInput = Read-Host -Prompt "Input values (enter 'q' to exit)"
    If ($UserInput -ne 'q') {
        $BulkInput += $UserInput
    }
} Until ($UserInput -eq 'q')

$Passports = (($BulkInput | Out-String) -split "`n`r`n").Trim()

$REQUIRED_FIELDS = @(
    'byr',
    'iyr',
    'eyr',
    'hgt',
    'hcl',
    'ecl',
    'pid'
)

$ValidPassports = 0

:passport ForEach ($Passport in $Passports) {
    ForEach ($Field in $REQUIRED_FIELDS) {
        If ($Passport -notmatch "$Field`:") {
            Write-Error "The key '$Field' was not found in '$Passport'."
            continue passport
        }
    }

    $ValidPassports++
}

Write-Host "Found $ValidPassports valid passports."
