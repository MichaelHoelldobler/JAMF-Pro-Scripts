#!/bin/bash

####################################
# Global – System Data
####################################

# Remove application
rm -rf /Applications/think-cell

# Remove application support
rm -rf "/Library/Application Support/think-cell"
rm -rf "/Library/Application Support/Microsoft/think-cell"

# Remove logs
rm -rf "/Library/Logs/think-cell"


####################################
# User Data - for EACH User
####################################

for USER_HOME in /Users/*; do
    # Nur echte Userverzeichnisse (kein Shared, kein Guest ohne Home)
    USERNAME=$(basename "$USER_HOME")
    if [[ "$USERNAME" == "Shared" ]] || [[ "$USERNAME" == ".localized" ]]; then
        continue
    fi

    echo "Bereinige Thinkcell-Daten für Benutzer: $USERNAME"

    # Application Support
    rm -rf "$USER_HOME/Library/Application Support/think-cell"
    rm -rf "$USER_HOME/Library/Application Support/Microsoft/think-cell"

    # Logs
    rm -rf "$USER_HOME/Library/Logs/think-cell"

    # Group Containers – Thinkcell
    rm -rf "$USER_HOME/Library/Group Containers/UBF8T346G9.Office/think-cell"

    # Group Containers Caches
    #rm -rfv "$USER_HOME/Library/Group Containers/UBF8T346G9.Office/Library/Caches/think-cell_*"
    su - "$USER_HOME" -c "rm -rfv -- '$USER_HOME/Library/Group Containers/UBF8T346G9.Office/Library/Caches/think-cell_*'"


done

echo "Thinkcell-Deinstallation abgeschlossen."
exit 0
