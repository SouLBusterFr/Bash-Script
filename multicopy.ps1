function multicopy {
    <#
    .SYNOPSIS
        multicopy permet de récupérer un fichier en source avec -file pour le copier
        dans plusieurs dossiers avec -dest étant le dossier parent dans lequel se trouve tous les dossiers
        où copier le fichier source.

        Utilisation : multicopy -file /path/to/file -dest /path/to/dest

    .DESCRIPTION
        Le script prend en compte deux paramètre, -file et -dest. le paramètre -file permet de spécifier le fichier source à copier
        Le paramètre -dest permet de spécifier le dossier parent contenant tous les dossiers où sera copier le fichier source.

    .PARAMETER file
        Le fichier source à copier.

    .PARAMETER dest
        Le dossier de destination.

    .EXAMPLE
        multicopy -file /path/to/file -dest /path/to/dest
        multicopy -help

    .NOTES   
    #>


# Défini les paramètres -file et -dest
    
    [CmdletBinding(PositionalBinding=$false)]
    param(       
       [switch]$help,
       
       [Parameter(HelpMessage="Le fichier source à copier")]
       [string]$file,

       [Parameter(HelpMessage="Le dossier de destination")]
       [string]$dest

       )
    If(!$file -or !$dest) {
        Write-Host "-file et -dest on besoin d'être définis. Pour plus d'info : Get-Help multicopy ou multicopy -help"
    }
    ElseIf($file -and $dest) {
        Write-Host $file
        Write-Host $dest
        # Boucle pour parcourir tous les dossiers de destination
        ForEach ($dir in Get-ChildItem -Path $dest -Directory) {

            # Copie du fichier dans le dossier de destination actuel
            Copy-Item -Path $file -Destination $dir.FullName

            # Affichage d'un message indiquant le dossier de destination actuel
            Write-Host "Copier dans : $dir"
        }
    }
    If($help -eq $true){
    Write-Host @"
    .SYNOPSIS
        multicopy permet de récupérer un fichier en source avec -file pour le copier
        dans plusieurs dossiers avec -dest étant le dossier parent dans lequel se trouve tous les dossiers
        où copier le fichier source.

        Utilisation : multicopy -file /path/to/file -dest /path/to/dest

    .DESCRIPTION
        Le script prend en compte deux paramètre, -file et -dest. le paramètre -file permet de 
        spécifier le fichier source à copier
        
        Le paramètre -dest permet de spécifier le dossier parent contenant tous les dossiers
        où sera copier le fichier source.

    .PARAMETRE file
        Le fichier source à copier.

    .PARAMETRE dest
        Le dossier de destination.

    .EXEMPLES
        multicopy -file /path/to/file -dest /path/to/dest
        multicopy -help
"@ 
    }
}