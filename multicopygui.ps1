# Création de la boite de dialogue pour choisir un fichier
$objForm = New-Object System.Windows.Forms.OpenFileDialog
$objForm.InitialDirectory = $PWD
$objForm.Title = "Choisissez le fichier à copier"
$objForm.ShowDialog()
$file = $objForm.FileName


# Création de la boite de dialogue pour le dossier de destination
$objForm2 = New-Object System.Windows.Forms.FolderBrowserDialog
$objForm2.SelectedPath = $PWD
$objForm2.Description = "Destination"
$objForm2.ShowDialog()
$dest = $objForm2.SelectedPath


# Boucle pour parcourir tous les dossiers de destination
ForEach ($dir in Get-ChildItem -Path $dest -Directory) {

    # Copie du fichier dans le dossier de destination actuel
    Copy-Item -Path $file -Destination $dir.FullName

    # Affichage d'un message indiquant le dossier de destination actuel
    Write-Host "Copier dans : $dir"
}