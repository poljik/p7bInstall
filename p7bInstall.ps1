$keysPath = "E:\Ключи\"

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Установка ключа'
$form.Size = New-Object System.Drawing.Size(400,800)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,730)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,730)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Отмена'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,10)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Выберите ключ:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,30)
$listBox.Size = New-Object System.Drawing.Size(365,20)
$listBox.Height = 700

$listBox.SelectionMode = 'MultiExtended'

$List = Get-ChildItem $keysPath -Include *.p7b -Recurse -Force
for ( $index = 0; $index -lt $List.count; $index++) {
    [void] $listBox.Items.Add(($List[$index] | Split-Path -Leaf))
}

$form.Controls.Add($listBox)
$form.Topmost = $true
$result = $form.ShowDialog()
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $x = $listBox.SelectedItem
    for ( $index = 0; $index -lt $x.count; $index++) {
        $key = Get-ChildItem $keysPath -Include $x[$index] -Recurse -Force
        AvCmUt4.exe -i $key -LOG NUL > $Null
    }
}