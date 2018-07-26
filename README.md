# Sage Deployment Prep Script

Sometimes you gotta use FTP. This script helps you prepare a
Sage theme for deployment.

## Instructions

1. Copy `bin` into your theme's directory.
2. Make sure the script is executable:
   ```sh
   chmod +x bin/prep.sh
   ```
3. Add the script to your `packages.json`:
   ```diff
   "scripts": {
   +  "prep": "npm run build:production && ./bin/prep.sh"
   }
   ```
