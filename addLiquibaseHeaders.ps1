# Define the directory and the base text to prepend
$DIRECTORY = "."
$BASE_TEXT = "--liquibase formatted sql`n--changeset author:1 endDelimiter:GO"

# Check if directory exists
if (-not (Test-Path -Path $DIRECTORY -PathType Container)) {
    Write-Host "Directory $DIRECTORY does not exist."
    exit 1
}

# Get all .sql files in the directory and subdirectories
Get-ChildItem -Path $DIRECTORY -Filter "*.sql" -Recurse -File | ForEach-Object {
    $FILE = $_.FullName
    
    # Check if file already contains liquibase header
    $content = Get-Content -Path $FILE -Raw
    if ($content -match "liquibase formatted sql") {
        Write-Host "Skipping $FILE - already contains Liquibase header"
        return
    }
    
    # Get the directory path of the file
    $DIR_PATH = $_.DirectoryName
    Write-Host "DIR_PATH $DIR_PATH"
    
    # Check if the path contains Functions, Stored Procs, or Views
    if ($DIR_PATH -match "(Functions|Stored\s+Procs|Views)") {
        # Add runOnChange:true for these specific subdirectories
        $TEXT_TO_PREPEND = "$BASE_TEXT runOnChange:true"
        Write-Host "Adding header with runOnChange:true to $FILE"
    }
    else {
        # Use base text for other files
        $TEXT_TO_PREPEND = $BASE_TEXT
        Write-Host "Adding standard header to $FILE"
    }
    
    # Prepend the text to the file
    $TEXT_TO_PREPEND + "`n" + $content | Set-Content -Path $FILE -NoNewline
    Write-Host "Prepended text to $FILE"
}

Write-Host "Liquibase Headers have been added."