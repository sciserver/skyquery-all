# Source install libraries
. .\deploy\instutil.ps1
. .\deploy\instlib.ps1

WrapItself $PSCommandPath $args

$verb = $args[1]

. Configure
Init
InitRegistry

if ($verb -match "^help") {
	# TODO
	echo "This will display the help some day."
} elseif ($verb -match "^createdb") {
	$ErrorActionPreference = "Stop"
	InstallLogging $true
	InstallJobPersistence $true
	InstallRegistry $true
} elseif ($verb -match "^initdb") {
	$ErrorActionPreference = "Stop"
	InstallLogging
	InstallJobPersistence
	InstallRegistry
} elseif ($verb -match "^initreg") {
	InstallSkyQuery
	ImportRegistry
} elseif ($verb -match "^servers") {
	FindServers
	PrintServers
} elseif ($verb -match "^install") {
	$ErrorActionPreference = "Stop"
	
	AskPasswords

	# Find servers
	FindServers
	PrintServers

	CreateBinariesDir
	CopyBinaries

	InstallWebAdmin
	InstallWebUI

	InstallRemotingService
	InstallScheduler

	CreateCodeDb
	InstallCodeDbScripts
	
	echo "Install complete. Run 'setup start $config' to finish installation."
} elseif ($verb -match "^reinstall") {
	$ErrorActionPreference = "Stop"

	FindServers

	StopScheduler
	StopRemotingService
	
	CopyBinaries

	InstallWebAdmin
	InstallWebUI

	RemoveCodeDbScripts
	InstallCodeDbScripts

	StartRemotingService
	StartScheduler

	echo "Reinstall complete."
} elseif ($verb -match "^start") {
	FindServers

	StartRemotingService
	StartScheduler

	echo "Services started."
} elseif ($verb -match "^stop") {
	FindServers

	StopScheduler
	StopRemotingService

	echo "Services stopped."
} elseif ($verb -match "^remove") {
	FindServers

	StopScheduler
	RemoveScheduler

	StopRemotingService
	RemoveRemotingService

	DropCodeDb
	
	RemoveWebUI
	RemoveWebAdmin

	RemoveBinaries

	echo "Remove complete. Run 'setup purge $config' to delete registry."
} elseif ($verb -match "^purge") {
	RemoveRegistry
	RemoveJobPersistence
	RemoveLogging

	echo "Configuration purged."
} elseif ($verb -match "^debug") {

	# ADD DEBUG CODE HERE

	FindServers
	PrintServers

	Write-Host "----- Start debug -----"

	$ss = GetBinariesServers
	$ss = GetBinariesServers
	$ss

	Write-Host "----- End debug -----"

	# -------------------

} else {
	Write-Host "Unrecognized verb: $verb"
}