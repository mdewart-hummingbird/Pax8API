function Get-Pax8ProductsV2API {
  [CmdletBinding()]
  Param(
  )
  $partnerguid = (Get-Pax8CompaniesV2API)[0].partnerguid
  try {
    $Complete = $false
    $PageNo = 0
    $Result = do {
						$Response = Invoke-WebRequest -Method Get `
        -Uri ("https://app.pax8.com/p8p/api/v3/partners/$partnerguid/products/search/query" + "?page=$PageNo&size=200") `
        -ContentType 'application/json' `
        -Headers @{
        Authorization = "Bearer $($script:Pax8Token)"
      } `
        -ea stop
						$JSON = $Response | ConvertFrom-Json
						if ($JSON.Page) {
        if (($JSON.Page.totalPages - 1) -eq $PageNo -or $JSON.Page.totalPages -eq 0) {
          $Complete = $true
        }
        $PageNo = $PageNo + 1
        $JSON.content
						} else {
        $Complete = $true
        $JSON
						}
    } while ($Complete -eq $false)
  } catch {
    Write-Error "An Error Occured $($_) "
  }





  return $result
}