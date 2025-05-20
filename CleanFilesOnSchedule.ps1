# Part 1: Settings #######################################################################################

$Days = 30 # Number of days

# Part 2: Folders #############################################################################################

$Paths = @(
    "C:\Folder1\*",
    "C:\Folder2\*",
    "C:\Folder3\*"
    # Add other paths here
    # "C:\Path04\*",
)

# Part 3: Function to clear folders and delete files ############################################################

function Cleanup-Folder {
    param (
        [string]$Path,
        [datetime]$CutoffDate
    )
    
    Get-ChildItem -Path $Path -Include *.* -File -Recurse | Where-Object { $_.LastWriteTime -lt $CutoffDate } | Remove-Item -Force
}

# Part 4: Iterate through the folders and clean up ############################################################
$CalculateDays = (Get-Date).AddDays(-$Days) # Calculate the number of days

foreach ($Path in $Paths) {
    Cleanup-Folder -Path $Path -CutoffDate $CalculateDays
}
