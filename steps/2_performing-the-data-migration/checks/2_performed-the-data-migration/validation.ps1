param(
    [string]
    $Resourcegroupname
)

if ((Get-Module -ListAvailable Az.DataMigration) -eq $null)
	{
       Install-Module -Name Az.DataMigration -RequiredVersion 0.7.4 -Force
    }

$dmsinstance = Get-AzResource -ResourceGroupName $Resourcegroupname -ResourceType Microsoft.DataMigration/services;
$dmsname = $dmsinstance.Name;

$datamigrationactivity = Get-AzDataMigrationTask -TaskName Datamigrationactivity -ServiceName $dmsname -ResourceGroupName $Resourcegroupname -ProjectName SqlToSqlDbMigrationProject -Expand;
$result = $datamigrationactivity.ProjectTask.Properties.State;

if ($result -eq "Succeeded") { 
    Write-Host "data migration activity completed" }
else { Write-Host "Please complete data migration activity" }
