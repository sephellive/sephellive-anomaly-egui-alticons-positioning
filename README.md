# EGUI AltIcons Positioning

Dedicated live positioning addon for the AltIcons implementation bundled with Enhanced Graphical User Interface 0.6.6a for S.T.A.L.K.E.R. Anomaly 1.5.3.

It moves the complete EGUI AltIcons row, adjusts icon spacing, and keeps booster countdown timers anchored to their corresponding icons. The in-game adjustment window temporarily previews every EGUI AltIcon and representative booster timers without adding gameplay effects.

This is a new standalone addon. It does not modify or depend on `sephellive-hud-positioning`.

## Requirements

- S.T.A.L.K.E.R. Anomaly 1.5.3
- Enhanced Graphical User Interface 0.6.6a with its bundled AltIcons script
- Anomaly Mod Configuration Menu (MCM)

## Installation

Install the release ZIP with Mod Organizer 2 after EGUI. Disable Sephellive HUD Positioning if it is installed; both addons wrap the same runtime HUD class and must not be active together.

Restart the game, then open **MCM -> EGUI AltIcons Positioning**.

The release archive starts directly with `gamedata/` and has no wrapper directory. A new game is not required.

## Configuration

- Horizontal offset moves the complete AltIcons row left or right.
- Vertical offset moves the complete row up or down.
- Icon spacing changes the gap between adjacent icon slots.
- Preview / Adjust opens an in-game live-positioning window.
- Reset to defaults restores EGUI's original offsets and two-pixel spacing.

Settings apply immediately and are stored by MCM.

English and Russian MCM string tables use Windows-1251, matching the Anomaly runtime localization loader.

## Timer-safe layout

EGUI creates icons and backgrounds as children of the AltIcons panel, but creates booster countdown labels as separate windows with absolute HUD coordinates. Moving all slot elements as if they shared the same coordinate system displaces those timers.

This addon therefore:

1. moves only icon and background layers in panel-local coordinates;
2. moves the panel itself by the configured X/Y offset;
3. recalculates every timer from the final panel and icon positions;
4. repeats that timer anchoring whenever the live layout changes.

## Compatibility

- Does not replace `actor_status.script`, `alticons.script`, or any EGUI XML/texture.
- Does not alter status values, booster durations, or gameplay state.
- Must not be enabled together with Sephellive HUD Positioning.
- Addons that replace `actor_status.UIIndicators.InitControls` or `Update` after this addon may require a compatibility patch.
- Removing the addon is save-safe.

## Credits

- INC and RavenAscendant — EGUI and its bundled AltIcons implementation.
- Sephellive HUD Positioning — reference for the live preview and adjustment workflow.

## License

The original code in this repository is licensed under the MIT License. Third-party addons and game assets remain the property of their respective authors.
