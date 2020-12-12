<#
    .SYNOPSIS
        Password validator for North Pole Toboggan Rental Shop

    .NOTES
        https://adventofcode.com/2020/day/2
#>
[CmdletBinding()]
Param(
)

# Get input
[string[]]$PasswordList = @()
Do {
    $UserInput = Read-Host -Prompt "Input values (enter blank or 'q' to exit)"
    If ($UserInput -ne '' -and $UserInput -ne 'q') {
        $PasswordList += $UserInput
    }
} Until ($UserInput -eq '' -or $UserInput -eq 'q')

$ValidPasswords = 0
$regex = "^(?'min'\d+)-(?'max'\d+) (?'letter'\w): (?'token'\w+)$"

ForEach ($Password in $PasswordList) {
    # Parse line
    If ($Password -match $regex) {
        $Pos1 = $Matches.min
        $Pos2 = $Matches.max
        $Letter = $Matches.letter
        $Token = $Matches.token

        If ($Token[$Pos1 - 1] -eq $Letter -xor $Token[$Pos2 - 1] -eq $Letter) {
            $ValidPasswords++
        }
        Else {
            Write-Verbose "The password '$Password' is invalid."
        }
    }
    Else {
        Write-Error "The input '$Password' does not match the regex '$regex'."
    }
}

Write-Host "Found $ValidPasswords valid passwords."
