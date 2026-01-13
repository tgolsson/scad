fetch:
    wget -L https://files.openscad.org/snapshots/OpenSCAD-2026.01.03-x86_64.AppImage
download: fetch
   chmod +x OpenSCAD-2026.01.03-x86_64.AppImage

run *args:
   ./OpenSCAD-2026.01.03-x86_64.AppImage {{args}}

launch *args:
   emacs {{args}} &
   ./OpenSCAD-2026.01.03-x86_64.AppImage {{args}} &


export file:
   ./OpenSCAD-2026.01.03-x86_64.AppImage -o /mnt/c/Users/mail/Documents/{{file}}.3mf {{file}}.scad
