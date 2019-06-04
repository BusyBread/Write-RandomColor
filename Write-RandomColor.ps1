<#
    .DESCRIPTION
    Write every character in a string as a random color.

    .SYNTAX
        Write-RandomColors -InputString @(Get-Process)
        Write-RandomColors "WRITE THIS RANDOMLY"
        Write-Colors "WRITE THIS RANDOMLY TOO"
#>
Function Write-RandomColors {
    [Alias('Write-Colors')]
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNull()]
        $InputString 
    )
    
    Try{

        $InputString = ( $InputString  | Out-String ).ToCharArray()

        # Remove current backgroud color from list of available colors for better visabilbity
        $SystemColors = @()
        $Current_BG = (Get-Host).UI.RawUI.BackgroundColor
        ForEach( $Color in [Enum]::GetValues([System.ConsoleColor]) ){
           If ($Color -notmatch $Current_BG){
               $SystemColors += $Color
           }
        }

        # Loop through the provided input string and apply a random color to every character.
        For( $i=0; $i -lt $InputString.Length; $i++){
            $RandomColor = $SystemColors[ $(Get-Random -Minimum 0 -Maximum $SystemColors.Length ) ]
            Write-Host $InputString[$i] -NoNewline -ForegroundColor $RandomColor
        }
    }
    Catch{ 
        Write-Host $_.Exception.Message -Fore Red
     }
}
