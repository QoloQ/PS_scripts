param(
	[Parameter(Mandatory=$True)]
	[string]$user,

	[string]$password = (read-host -AsSecureString "pass_plz: ")

)

$user
$password


