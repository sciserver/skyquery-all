#region SkyNode utils

function DeploySkyNodeScripts($name, $version, $subset) {
	$databases = FindDatabaseInstances "DatabaseDefinition:Graywulf\SciServer\SkyQuery\$name" "$version"
	$scripts = FindFiles ".\skyquery-skynodes\sql\$dbname\*" "\d+_($subset).*\.sql"
	Write-Host "Deploying SkyNode scripts to:"
	foreach ($db in $databases) {
		$s = $db["Server"]
		$d = $db["Database"]
		Write-Host "... " $s $d
		foreach ($f in $scripts) {
			Write-Host "... ... " $f.Name
			ExecSqlScript "$s" "$d" $f.FullName
		}
	}
}

function DropSkyNodeMetadata($name, $version) {
	$databases = FindDatabaseInstances "DatabaseDefinition:Graywulf\SciServer\SkyQuery\$name" "$version"
	Write-Host "Dropping SkyNode metadata from:"
	foreach ($db in $databases) {
		$s = $db["Server"]
		$d = $db["Database"]
		Write-Host "... " $s $d
		& ".\bin\$skyquery_target\gwmetautil.exe" drop -Server "$s" -Database "$d" -E
	}
}

function ImportSkyNodeMetadata($name, $version) {
	$databases = FindDatabaseInstances "DatabaseDefinition:Graywulf\SciServer\SkyQuery\$name" "$version"
	$scripts = FindFiles ".\skyquery-skynodes\sql\$dbname\*" "\d+_meta\.xml"
	Write-Host "Generating SkyNode metadata to:"
	foreach ($db in $databases) {
		$s = $db["Server"]
		$d = $db["Database"]
		Write-Host "... " $s $d
		foreach ($f in $scripts) {
			Write-Host "... ... " $f.Name
			& ".\bin\$skyquery_target\gwmetautil.exe" import -Server "$s" -Database "$d" -E -Input "$($f.FullName)"
		}
	}
}

function FixSkyNodeUsers($name, $version) {
	$databases = FindDatabaseInstances "DatabaseDefinition:Graywulf\SciServer\SkyQuery\$name" "$version"
	Write-Host "Fixing SkyNode users in:"
	foreach ($db in $databases) {
		$s = $db["Server"]
		$d = $db["Database"]
		Write-Host "... " $s $d
		$ro = IsDatabaseReadOnly "$s" "$d"
		if ($ro -eq "1") {
			Write-Host "... ... Setting database read-write"
			SetDatabaseRestrictedUser "$s" "$d"
			SetDatabaseReadWrite "$s" "$d"
		}
		FixUser "$s" "$d" "$skyquery_admin_account" "db_owner"
		FixUser "$s" "$d" "$skyquery_service_account" "db_owner"
		FixUser "$s" "$d" "$skyquery_user_account" "db_owner"
		if ($ro -eq "1") {
			Write-Host "... ... Setting database read-only"
			SetDatabaseMultiUser "$s" "$d"
			SetDatabaseReadOnly "$s" "$d"
		}
	}
}

#endregion
# -------------------------------------------------------------