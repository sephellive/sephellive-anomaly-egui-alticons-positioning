$ErrorActionPreference = "Stop"

$repository = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$runtime = Join-Path $repository "gamedata\scripts\zzz_sep_egui_alticons_positioning.script"
$mcm = Join-Path $repository "gamedata\scripts\zzz_sep_egui_alticons_positioning_mcm.script"
$localizations = @(
	(Join-Path $repository "gamedata\configs\text\eng\ui_st_sep_egui_alticons_positioning.xml"),
	(Join-Path $repository "gamedata\configs\text\rus\ui_st_sep_egui_alticons_positioning.xml")
)

foreach ($required in @($runtime, $mcm) + $localizations) {
	if (-not (Test-Path -LiteralPath $required -PathType Leaf)) {
		throw "Missing required file: $required"
	}
}

$runtimeSource = Get-Content -LiteralPath $runtime -Raw
foreach ($token in @(
	'local ICON_ELEMENTS = {"back_s", "back_f", "icon_s", "icon_f"}',
	'dialog_position.x + icon_position.x',
	'dialog_position.y + icon_position.y - 15',
	'position_timer(hud, slot)',
	'indicator.typ == "booster"',
	'slot.xcvb_time:SetText("120")',
	'actor_status.UIIndicators:InitControls()',
	'actor_status.UIIndicators:Update(force)'
)) {
	if ($runtimeSource -notmatch [regex]::Escape($token)) {
		throw "Required timer-safe implementation token missing: $token"
	}
}

if ($runtimeSource -match 'ICON_ELEMENTS\s*=\s*\{[^}]*xcvb_time') {
	throw "Timer labels must not be moved in panel-local icon coordinates."
}

foreach ($forbidden in @(
	"gamedata\scripts\actor_status.script",
	"gamedata\scripts\alticons.script"
)) {
	if (Test-Path -LiteralPath (Join-Path $repository $forbidden)) {
		throw "The addon must not replace EGUI file: $forbidden"
	}
}

foreach ($xmlPath in $localizations) {
	$document = New-Object System.Xml.XmlDocument
	$document.Load($xmlPath)
	if ($document.string_table.string.Count -lt 12) {
		throw "Localization is incomplete: $xmlPath"
	}
}

Write-Output "Static validation passed: EGUI-only layout wrapper, timer anchoring, preview, MCM and localization found."
