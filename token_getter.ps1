param(
	[string]$url = $(throw "-url required"),
	[string]$ping = $(throw "-ping required"),
	[string]$metoda_aut = $(throw "-metoda_aut required"),
	
	[Parameter(Mandatory=$True)]
	[int]$klient_id,

	[Parameter(Mandatory=$True)]
	[string]$jmeno,

	[string]$heslo = (Read-Host -AsSecureString "password:")

)

$data = '{
"grant_type":"password", 
"client_id":' + $klient_id + ', 
"client_secret":"", 
"username":' + $jmeno + ', 
"password":' + $heslo + ', 
"platform":"base"
}'

$tok = curl --request POST --url $url+$metoda_autentizace --header "Cache-Control:no-cache" --header "Content-Type: application/json" --header "Accept: application/json" --data $data | ConvertFrom-Json | select -P access_token 

"testin token now..."

curl -s -X GET -H OAuth-Token:$tok $url+$ping