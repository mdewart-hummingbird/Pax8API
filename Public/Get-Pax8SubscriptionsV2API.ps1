function Get-Pax8SubscriptionsV2API {
  [CmdletBinding()]
  Param()
  $companyIDs = Get-Pax8CompaniesV2API
  $results = foreach ($companyid in $companyIDs) {
    #Write-Host "Working on $($companyid.Name)"
    try {
      $Response = Invoke-WebRequest -Method Get `
        -Uri ($script:Pax8BaseURLv2 + "subscription?&companyId=$($companyid.id)&size=200") -ContentType 'application/json' -Headers @{
        Authorization = "Bearer $($script:Pax8Token)"
      } -ErrorAction Stop
      $JSON = $Response.content | ConvertFrom-Json
      $json
    } catch {
      Write-Error "An Error Occured $($_) "
    }
  }
  return $Results
}
