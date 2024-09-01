# Define parameter that allows input as project name
param(
    [string]$projectName 
)

# Check if a name was provided
if (-not $projectName) {
    Write-Host "Please provide a project name." # Displays error message
    exit 1 #exits with error status
}

# Create a directory with project name
mkdir $projectName 
cd $projectName

# Initialize a git repository
git init 

# Create a virtual environment in the project directory
python -m venv venv 

#Activate the environment
.\venv\Scripts\Activate.ps1

#creates empty requirements.txt file
New-Item requirements.txt -ItemType File 

#Install dependencies
pip install pytest

# Save the list of packages to the requirements.txt file
pip freeze > requirements.txt

#print confirmation message
Write-Host "Project $projectName created and virtual environment established."