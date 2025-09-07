# GG184 Discipline-Split Workspace

This workspace loads **different DGNLibs per discipline** (CH/CD/CE/CB/CX) based on a small **marker file** in the same folder as the active DGN.

## How it works
- The CFG checks for a file named `._GG184_DISCIPLINE_<ROLE>` in the **active DGN's folder**.
- If found, it sets `GG184_DISCIPLINE` to that role and only loads DGNLibs from the matching subfolders:
  - `Dgnlib/Feature Definitions/<ROLE>/`
  - `Dgnlib/Feature Symbology/<ROLE>/`
  - `Dgnlib/Element Templates/<ROLE>/`
- If no marker exists, the default is **CH** (Highways).

## Quick start
```powershell
# Create a project folder with CH/CD/CE/CB/CX and markers
powershell -ExecutionPolicy Bypass -File ".\Configuration\Organization\WorkSpaceSetup\New-GG184Project.ps1" -ProjectRoot "D:\Projects\A12\Design"
# Or change an existing folder to CE
powershell -ExecutionPolicy Bypass -File ".\Configuration\Organization\WorkSpaceSetup\Set-GG184Discipline.ps1" -Discipline CE -Folder "D:\Projects\A12\Design\CE"
```

## Notes
- Replace the placeholder script `Build-Dgnlibs-From-Imports.ps1` with your internal export process
  after you import the **Feature Definitions/Symbology/Element Templates** XMLs into DGNLibs.
- You can keep **Common** DGNLibs (levels, annotation, shared) in `Dgnlib/Common/` – these always load.
- This approach avoids brittle path matching and works for any nested project structure.
