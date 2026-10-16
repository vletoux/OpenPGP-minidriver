# OpenPGP minidriver

A minidriver for the OpenPGP card.

These project should be considered in addition to the [OpenPGP CSP project](https://github.com/vletoux/OpenPGP-CSP).

It has been designed to provide support for the OpenPGP card.

## Getting Started

Open the solution in any recent Visual Studio (the toolset is selected automatically) and build the project,
or run `build.cmd [Release|Debug] [Win32|x64|ARM64]` to build every platform (x86, x64 and ARM64).

The version number is generated from the git tag (`GenerateVersion.ps1`, written to `version.h`).

### Installers

`msi.cmd` builds the x86, x64 and ARM64 MSI (WiX Toolset v5, restored from NuGet).
`sign.cmd <certificate> [bin|msi]` signs the DLLs or the MSI.
The MSI copies the minidriver in the system folder and registers the OpenPGP card v2 / v3 ATR.

### Prerequisites

The current release is signed by a SHA2 certificate (kernel mode signing).
That means that the [Microsoft Security Advisory 3033929](https://docs.microsoft.com/en-us/security-updates/securityadvisories/2015/3033929) MUST be installed.

## Running the tests

Run certutil -scinfo (beware of the 32 or 64 bits version when doing test - c:\windows\syswow64\certutil.exe is the 32 bits one)
and double check that the Card name is filled.

### Certutil test with the "Open PGP Card v2"



```
  0: SCM Microsystems Inc. SCR33x USB Smart Card Reader 0
--- Lecteur�: SCM Microsystems Inc. SCR33x USB Smart Card Reader 0
--- Statut�: SCARD_STATE_PRESENT | SCARD_STATE_UNPOWERED
--- Statut�: Carte disponible pour utilisation.
---   Carte�: OpenPGP
---    ATR�:
        3b da 18 ff 81 b1 fe 75  1f 03 00 31 c5 73 c0 01   ;......u...1.s..
        40 00 90 00 0c                                     @....
```

## Authors

* **Vincent LE TOUX** - *Initial commit*

## License

This project is licensed under the LGPL License

