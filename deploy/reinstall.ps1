# Reinstalls SkyQuery binary components and web sites
# before execution, make sure to dot source an appropriate config file:
# . .\skyquery-config\scidev01\configure.ps1
# .\deploy\reinstall.ps1

$controller = $skyquery_controller
$nodes = $skyquery_nodes
$servers = $controller + $nodes

# Stop the scheduler
if ($skyquery_deployscheduler)
{
	echo "Stopping scheduler on the controller..."
	icm $controller -Script { param($sn) net stop $sn } -Args $skyquery_schedulerservice
}

# Stop the remoting service
if ($skyquery_deployremoteservice)
{
	echo "Stopping remoting service '$skyquery_remoteservice' on all servers..."
	icm $servers -Script { param($sn) net stop $sn } -Args $skyquery_remoteservice
}

# Overwrite binaries
if ($skyquery_deployscheduler -or $skyquery_deployremoteservice)
{
	echo "Copying binaries to all servers..."
	foreach ( $s in $servers ) { cp .\bin\$skyquery_config\* \\$s\$skyquery_gwbin -recurse -force }
}

# Overwrite web sites on the controller
if ($skyquery_deploywww)
{
	echo "Deploying web site to controller"
	foreach ( $s in $controller ) { cp .\bin\$skyquery_config\* \\$s\$skyquery_www -recurse -force }
}

# Restart remoting service
if ($skyquery_deployremoteservice)
{
	echo "Starting remoting service '$skyquery_remoteservice' on all servers..."
	icm $servers -Script { param($sn) net start $sn } -Args $skyquery_remoteservice
}

# Restart scheduler
if ($skyquery_deployscheduler)
{
	echo "Starting scheduler on the controller..."
	icm $controller -Script { param($sn) net start $sn } -Args $skyquery_schedulerservice
}