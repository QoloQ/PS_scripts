## This script is made to get authtoken from server which can by then
## used for communication with server. Variable $data is string lookin
## like json bc that is what this specific server expects.
## I agree with public use of this code.



param(
	[string]$url = $(throw "-url required"),

	[string]$module = $(throw "-module required"),
	
	[Parameter(Mandatory=$False)]
	[string]$klient_id = "sugar",

	[Parameter(Mandatory=$False)]
	[string]$jmeno = "jchmelarapi",

	[Security.SecureString]$heslo = (Read-Host -AsSecureString "password:") 
	) 


"converting from ss...."
$pass = convertfrom-securestring $heslo -asplaintext
"printin the answer..."

$pass 

$data = '"{\"grant_type\":\"password\",
 \"client_id\":\"'+ $klient_id+'\",
  \"client_secret\":\"\",
  \"username\":\"'+ $jmeno+'\",
  \"password\":\"'+$heslo_sec+'\",
  \"platform\":\"base\"}"'

$finurl = $url + $module





$token= (curl --request POST --url $finurl --header "Cache-Control:no-cache" --header "Content-Type: application/json" --header "Accept: application/json" --data $data | convertfrom-json | select -Property access_token).access_token

$resp = curl -X GET -H OAuth-Token:$token https://dsugar.kapitol.cz/rest/v11/ping


