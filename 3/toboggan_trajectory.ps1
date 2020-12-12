[CmdletBinding()]
Param()

# Get input
[string[]]$Map = @()
Do {
    $UserInput = Read-Host -Prompt "Input values (enter blank or 'q' to exit)"
    If ($UserInput -ne '' -and $UserInput -ne 'q') {
        $Map += $UserInput
    }
} Until ($UserInput -eq '' -or $UserInput -eq 'q')


function DoSlope {
    Param(
        $Map,

        $Right,

        $Down
    )

    # Determine the width and height of the input map
    $MapWidth = $Map[0].Length
    $MapHeight = $Map.Count

    $X = 0
    $Y = 0
    $TreesHit = 0

    # Keep moving right 3, down 1 until we hit the bottom of the input map
    Do {
        # Move our position
        $X += $Right
        $Y += $Down

        # If our x coordinate is larger than the input map width, we need to wrap back to the other side
        If ($X -gt $MapWidth - 1) {
            $X -= $MapWidth
        }

        # Check for collision with '#' in input map
        If ($Map[$Y][$X] -eq '#') {
            Write-Verbose "We hit a tree!"
            $TreesHit++
        }

    } While ($Y -lt $MapHeight - 1)

    return $TreesHit
}

$Answer = 1

$Answer *= DoSlope -Map $Map -Right 1 -Down 1
$Answer *= DoSlope -Map $Map -Right 3 -Down 1
$Answer *= DoSlope -Map $Map -Right 5 -Down 1
$Answer *= DoSlope -Map $Map -Right 7 -Down 1
$Answer *= DoSlope -Map $Map -Right 1 -Down 2

Write-Host "The magic answer is: $Answer"
