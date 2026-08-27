# Structured Derivations — Local Package Notes

This repository is installed as a **local Typst package**.  
Do **not** copy the `lib/` directory into individual projects.

## Install on a new Windows PC

Prerequisites:

```powershell
typst --version
git --version
```

Clone the repository wherever you normally keep source repositories:

```powershell
git clone <REPOSITORY-URL>
cd structured-derivations
```

Install the package:

```powershell
.\install.ps1
```

If PowerShell blocks local scripts:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

The installer reads the package name and version from `typst.toml`, finds Typst's local package directory, and creates a Windows junction from that package location to this Git working tree.

There is still only **one real copy** of the library: this repository.

---

## Use it in a Typst project

Create a project anywhere you like. At the top of the `.typ` file:

```typst
#import "@local/structured-derivations:0.1.0": *
```

Then use the library normally.

For example:

```typst
#centred-theory(
  [A tiny theory],

  section([Assumptions]),

  assume(
    [A1],
    $R = R$,
    $S = S$,
  ),

  section([Observations]),

  observe(
    [O1],
    $R = S$,
    $S = T$,
  ),
)
```

For multi-line assumptions, observations, etc., the marker appears only on the first line. Continuation rows have a **blank first column** and remain aligned in the second column.

---

## Ordinary library updates

Edit the files in this repository.

Because the Typst package points directly at this working tree, projects using the installed version see the changes immediately.

When satisfied:

```powershell
git add .
git commit -m "Describe the change"
git push
```

There is no need to rerun `install.ps1` for ordinary edits.

---

## Release a new package version

When deliberately moving to a new package version, change the version in `typst.toml`, for example:

```toml
version = "0.2.0"
```

Then commit and tag it:

```powershell
git add typst.toml
git commit -m "Release 0.2.0"
git tag v0.2.0
git push
git push --tags
```

Run the installer again:

```powershell
.\install.ps1
```

New projects can then import:

```typst
#import "@local/structured-derivations:0.2.0": *
```

### Important

The installed package is a junction to the **live Git working tree**.

Therefore, while `0.1.0` is installed, ordinary edits to the repository also change what local projects see as `0.1.0`.

Git commits provide development history; package-version bumps and Git tags mark deliberate stable points.

---

## Uninstall

To remove version `0.1.0` from Typst:

```powershell
Remove-Item `
  "$env:APPDATA\typst\packages\local\structured-derivations\0.1.0"
```

This removes only the junction. It does **not** delete the Git repository.

To remove the whole local package registration:

```powershell
Remove-Item `
  "$env:APPDATA\typst\packages\local\structured-derivations" `
  -Recurse
```

The repository itself remains wherever it was cloned.

---

## The short version

### Once per Windows PC

```powershell
git clone <REPOSITORY-URL>
cd structured-derivations
.\install.ps1
```

### In every Typst project

```typst
#import "@local/structured-derivations:0.1.0": *
```

### When editing the library

Edit this repo, test, commit, and push.

No copying `lib/` into projects.
