# ============================================================
# setup-poste.ps1 — Prépare un poste Windows pour gérer le site
# de La Parenthèse (installation des outils + configuration).
#
# Usage : ouvrir un terminal PowerShell puis :
#   powershell -ExecutionPolicy Bypass -File .\setup-poste.ps1
# (ou clic droit sur le fichier → « Exécuter avec PowerShell »)
#
# Le script peut être relancé sans risque : il saute ce qui est
# déjà installé ou déjà configuré.
# ============================================================

$ErrorActionPreference = "Stop"

function Install-Outil {
    param([string]$Id, [string]$Nom)
    $deja = winget list --id $Id -e --accept-source-agreements 2>$null | Select-String $Id
    if ($deja) {
        Write-Host "[ok] $Nom est déjà installé" -ForegroundColor Green
    } else {
        Write-Host "Installation de $Nom ..." -ForegroundColor Cyan
        winget install --id $Id -e --silent --accept-source-agreements --accept-package-agreements
    }
}

Write-Host "=== Outils ===" -ForegroundColor Yellow
Install-Outil -Id "Git.Git"                    -Nom "Git"
Install-Outil -Id "GitHub.cli"                 -Nom "GitHub CLI (gh)"
Install-Outil -Id "Hugo.Hugo.Extended"         -Nom "Hugo (extended)"
Install-Outil -Id "Microsoft.VisualStudioCode" -Nom "Visual Studio Code"

# Recharge le PATH pour que git / gh / code soient utilisables
# immédiatement dans cette session.
$env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
            [Environment]::GetEnvironmentVariable("Path", "User")

Write-Host "=== Identité Git ===" -ForegroundColor Yellow
if (-not (git config --global user.name)) {
    $nom = Read-Host "Nom affiché dans l'historique des modifications (ex. Prénom Nom)"
    git config --global user.name "$nom"
}
if (-not (git config --global user.email)) {
    $mail = Read-Host "Adresse e-mail du compte GitHub"
    git config --global user.email "$mail"
}
Write-Host "[ok] Git : $(git config --global user.name) <$(git config --global user.email)>" -ForegroundColor Green

Write-Host "=== Connexion GitHub ===" -ForegroundColor Yellow
gh auth status 2>$null | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host "Une page va s'ouvrir dans le navigateur :"
    Write-Host "se connecter avec le compte GitHub de la librairie (LaParenthese)."
    gh auth login --hostname github.com --git-protocol https --web
} else {
    Write-Host "[ok] Déjà connecté à GitHub" -ForegroundColor Green
}

Write-Host "=== Récupération du site ===" -ForegroundColor Yellow
$dest = Join-Path $HOME "Documents\site-la-parenthese"
if (Test-Path $dest) {
    Write-Host "[ok] Le site est déjà présent : $dest" -ForegroundColor Green
} else {
    gh repo clone LaParenthese/site $dest
    Write-Host "[ok] Site cloné dans $dest" -ForegroundColor Green
}

Write-Host "=== Extensions VS Code ===" -ForegroundColor Yellow
# Interface de VS Code en français + correcteur orthographique français
code --install-extension MS-CEINTL.vscode-language-pack-fr 2>$null
code --install-extension streetsidesoftware.code-spell-checker 2>$null
code --install-extension streetsidesoftware.code-spell-checker-french 2>$null

Write-Host ""
Write-Host "=== Terminé ! ===" -ForegroundColor Yellow
Write-Host "Pour travailler sur le site :"
Write-Host "  1. Ouvrir VS Code sur le site :   code `"$dest`""
Write-Host "  2. Prévisualiser en local :       hugo server   (puis http://localhost:1313)"
Write-Host "  3. Publier : dans VS Code, onglet Source Control -> message -> Commit -> Sync"
Write-Host "Le site en ligne se met à jour tout seul ~1 minute après le Sync."
Write-Host "Mode d'emploi complet : README.md à la racine du site."
