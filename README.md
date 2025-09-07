
# 🏗️ GG184 OpenRoads Workspace Seed

This repo documents how to build a **Bentley OpenRoads Designer workspace** aligned to **National Highways GG184 naming conventions** and **Uniclass 2015 classification**, based on the process I went through (with a lot of help from ChatGPT).

The idea:  
- Civil engineers often inherit *architectural-style* BIM standards.  
- GG184 + MCHW + Uniclass provide the UK Highways-compliant framework.  
- With a bit of scripting + automation, you can spin up a **discipline-split, parametric, standards-compliant workspace** in no time.

---

## 🔑 What we built

1. **Feature Definitions** (`MCHW_FeatureDefinitions_GG184.xml`)  
   - Uses **NH Role codes** (CH, CD, CE, CB, CX, etc.)  
   - Mapped to **Uniclass 2015** product/system codes from MCHW tables.  
   - Correctly wires **Linear**, **Profile**, and **Surface/Mesh** symbologies.

2. **Feature Symbology** (`MCHW_FeatureSymbology_GG184.xml`)  
   - Matches the schema of standard OpenRoads Feature Symbology XML.  
   - References GG184-compliant **Element Template paths**.

3. **Element Templates** (`ORD_MCHW_Element_Templates_DgnData.xml`)  
   - GG184-compliant **Level names** (validated with regex).  
   - Correct NH Role codes (CH/CD/CE/CB/CX).  
   - Uses Uniclass table + short code in the level names.  
   - Feature symbology references built in.

4. **Template Library (ITL)** (`UK_Highways_Templates_Parametric_MATCHED.itl`)  
   - Example **S2 Urban**, **D2AP Central Reserve**, **Local Access with Cycle Track**.  
   - Includes **parametric constraint labels** (Lane_Width, Surf_T, Kerb_Upstand, etc.).  
   - Components named per **GG184 convention**:  
     ```
     <Role>_<Classif>_M3_<Originator>_<Type>_<Subtype>
     ```
     e.g. `CH_EF3060_M3_ATRL_CarriagewayTop_0001`.

5. **Discipline-Split Workspace CFG** (`GG184_OrganizationSetup.cfg`)  
   - Loads **Common** and **CX** + **Base** DGNLibs *always*.  
   - Switches in **discipline-specific** DGNLibs (CH, CD, CE, CB, CX) based on a **marker file** in the same folder as the active DGN (e.g. `._GG184_DISCIPLINE_CD`).  
   - Keeps everything clean and flexible.

6. **PowerShell Scripts**  
   - `New-GG184Project.ps1` → scaffolds a project folder with CH/CD/CE/CB/CX subfolders + marker files.  
   - `Set-GG184Discipline.ps1` → set or switch the discipline marker in any folder.  
   - `Build-Dgnlibs-From-Imports.ps1` → placeholder script to copy/import your XML-based standards into DGNLibs.

---

## 📂 Workspace Layout

```
Configuration/
  Organization/
    WorkSpaceSetup/
      GG184_OrganizationSetup.cfg
      New-GG184Project.ps1
      Set-GG184Discipline.ps1
      Build-Dgnlibs-From-Imports.ps1
  WorkSpaces/
    GG184/
      GG184.cfg
      WorkSets/
  Organization-Civil/
    Standards/
      Dgnlib/
        Common/
        Feature Definitions/
          CH/
          CD/
          CE/
          CB/
          CX/
          _Base/
        Feature Symbology/
          CH/
          CD/
          CE/
          CB/
          CX/
        Element Templates/
          CH/
          CD/
          CE/
          CB/
          CX/
      ITL/
        UK_Highways_Templates_Parametric_MATCHED.itl
      Import/
        ORD_MCHW_Element_Templates_DgnData.xml
        MCHW_FeatureDefinitions_GG184.xml
        MCHW_FeatureSymbology_GG184.xml
        ORD_MCHW_Level_Audit.csv
```

---

## 🚀 How to Replicate for *Your* Client Standards

You can follow the same process with your own dataset and codes. Here are the prompts I used with ChatGPT (feel free to reuse):

1. **Start with a Feature Definitions XML**  
   ```
   Create a Bentley OpenRoads Feature Definition XML file where the Feature Definitions 
   are based on [client’s specification / standard].
   ```

2. **Generate Feature Symbology + Element Templates**  
   ```
   Create the associated Feature Symbology and Element Template XMLs. 
   The element template should include Levels/Layer names compliant with [client’s naming convention regex].
   ```

3. **Align Role Codes**  
   ```
   The component naming role should align with the Feature Definitions used 
   and associated Level in the Element Template.
   ```

4. **Build ITL with Parametric Templates**  
   ```
   Create an ITL file using the Feature Definitions for highway road elements and cross sections. 
   Make sure parametric constraint labels are added.
   ```

5. **Discipline-Split Workspace**  
   ```
   Create a discipline-split workspace. Ensure that [default role] + Base Feature Definitions always load. 
   Use marker files in the DGN folder to switch which discipline-specific DGNLibs load.
   Provide batch/PowerShell scripts to scaffold new projects and set discipline markers.
   ```

---

## 📝 Next Steps
- Import the XMLs into proper **DGNLibs** using OpenRoads “Manage” → “Import”.  
- Replace the placeholder `Build-Dgnlibs-From-Imports.ps1` with your own **corporate export** process.  
- Populate the discipline buckets (CH/CD/CE/CB/CX) with the actual imported DGNLibs.  
- Extend the ITL with **junction civil cells** or **drainage templates** as needed.  
