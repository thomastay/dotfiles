[CmdletBinding(SupportsShouldProcess = $True)]
Param (
  [Parameter(Mandatory = $true)]
  [string]$URL,
  [Switch]$audio,
  [Switch]$ignoreErrors
)
$command = $URL, '-o', '%(title)s.%(ext)s'
if ($audio) {
  $command += "-x", "--postprocessor-args", "`"-threads 2`""
}
if ($ignoreErrors) {
  $command += "--ignore-errors"
}
Write-Information "Executing Command..."
Write-Information ("youtube-dl " + ($command -join " "))
Start-Process -NoNewWindow -Wait -FilePath "youtube-dl" -ArgumentList $command 

<#
  .SYNOPSIS
  Downloads a file using youtube-dl.

  .DESCRIPTION
  Takes as input a URL, and a switch to download as MP3
  Uses youtube-dl (a Python extension) to download the files

  .PARAMETER URL
  Specifies the URL. Mandatory.

  .PARAMETER audio
  Switch, specifying if the video should be downloaded as an audio file
  Note that this does not necessarily download an mp3 file, it might
  download an .opus file

  .PARAMETER ignoreErrors
  Switch, specifying whether ytdl should Continue on download errors,
  for example to skip unavailable videos in a playlist

  .LINK
  https://github.com/ytdl-org/youtube-dl

  .EXAMPLE
  PS> Get-Youtube -URL https://www.youtube.com/watch?v=yDOtENyOxyA -audio

  .EXAMPLE
  PS> Get-Youtube https://www.youtube.com/playlist?list=PLD6GNPaln5zKG4XKdMCN5YrgkIivJnkYd -ignoreErrors

  .EXAMPLE
  PS> Get-Youtube https://www.youtube.com/watch?v=yDOtENyOxyA -WhatIf
  #>