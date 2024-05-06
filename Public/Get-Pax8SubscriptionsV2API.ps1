function Get-Pax8SubscriptionsV2API {
  [CmdletBinding()]
  Param()
  $companyIDs = Get-Pax8CompaniesV2API
  $results = foreach ($companyid in $companyIDs) {
    #Write-Host "Working on $($companyid.Name)"
    try {
      $Response = Invoke-WebRequest -Method Get `
        -Uri ("https://app.pax8.com/p8p/api-v2/1/subscription?&companyId=$($companyid.id)&size=200") `
        -ContentType 'application/json' `
        -Headers @{
        Authorization = "Bearer $($script:Pax8Token)"
      } `
        -ea stop
      $JSON = $Response.content | ConvertFrom-Json
      $json
    } catch {
      Write-Error "An Error Occured $($_) "
    }
  }
  return $Results
}
