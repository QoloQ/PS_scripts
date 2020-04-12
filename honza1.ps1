param(
	[string]$url = $(throw "-url required"),
	[string]$module = $(throw "-module required"),
	
	[Parameter(Mandatory=$False)]
	[string]$klient_id = "sugar",

	[Parameter(Mandatory=$False)]
	[string]$jmeno = "jchmelarapi",

	[string]$heslo = (Read-Host -AsSecureString "password:") 
	
) 


<#
[string]$klient_id = "sugar"
[string]$jmeno = "jchmelarapi" #>
[string]$heslo = "8iMGYRM7A7eb8P" 

##$heslo = ConvertFrom-SecureString $heslo

$dataa = '"{\"grant_type\":\"password\",
 \"client_id\":\"'+ $klient_id+'\",
  \"client_secret\":\"\",
  \"username\":\"'+ $jmeno+'\",
  \"password\":\"'+$heslo+'\",
  \"platform\":\"base\"}"'

$finurl = $url + $module



$token= (curl --request POST --url $finurl --header "Cache-Control:no-cache" --header "Content-Type: application/json" --header "Accept: application/json" --data $dataa | convertfrom-json | select -Property access_token).access_token

$tokk = $token.access_token
$resp = curl -X GET -H OAuth-Token:$token https://dsugar.kapitol.cz/rest/v11/ping
$resp
