<#
    .SYNOPSIS
        Fixes Santa's expense report.

    .NOTES
        https://adventofcode.com/2020/day/1
#>
[CmdletBinding()]
Param(
    $Sum = 2020
)

# Get input
[int32[]]$ExpenseReport = @()
Do {
    $UserInput = Read-Host -Prompt "Input values from expense report (enter blank or 'q' to exit)"
    # If we got an integer, add it to the report
    If ($UserInput -as [int32]) {
        $ExpenseReport += $UserInput
    }
    ElseIf ($UserInput -eq '' -or $UserInput -eq 'q') {
        Write-Verbose "Exiting input loop."
    }
    Else {
        Write-Warning "The value '$UserInput' cannot be converted to an interger and will be ignored."
    }
} Until ($UserInput -eq '' -or $UserInput -eq 'q')

# ForEach element in array
ForEach ($FirstEntry in $ExpenseReport) {
    ForEach ($SecondEntry in $ExpenseReport -notmatch $FirstEntry) {
        $MagicNumber = $Sum - $FirstEntry - $SecondEntry

        # does this magic number exist?
        If ($ExpenseReport -contains $MagicNumber) {
            $Answer = $FirstEntry * $SecondEntry * $MagicNumber
            break
        }
    }
}

If ($Answer) {
    Write-Host "The answer is: $Answer"
}
Else {
    Write-Error "Unable to determine the answer."
}
