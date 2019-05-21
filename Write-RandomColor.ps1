Function Write-RandomColor {
    <#
        .DESCRIPTION
        Write out every character in a string as a random color.

        .SYNTAX
        Write-RandomColor -InputString "Hello World"
        Write-RandomColor @(Get-Process)
        Out-Color "Your String Here"
    #>
    [Alias('Out-Color')]
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        $InputString
    )
    Try{
        # Convert input to string, then to char array.
        $InputString = ( $InputString | Out-String ).ToCharArray()
        # Enumerate all console colors and filter out the current background color.
        $FontColors = @( $( [Enum]::GetValues([ConsoleColor]) | ForEach-Object { If( $_ -notmatch $(Get-Host).UI.RawUI.BackgroundColor ){ $_ } } ) )

        # Color each char randomly
        ForEach( $Char in $InputString ){
            $RandomColor = $FontColors[ $(Get-Random -Minimum 0 -Maximum $FontColors.Length ) ]
            Write-Host $Char -NoNewline -ForegroundColor $RandomColor
        }
    }
    Catch{ $_.Exception.Message }
}