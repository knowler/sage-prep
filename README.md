# Sage Deployment Prep Script

Sometimes you gotta use FTP. This script helps you prepare a
Sage theme for deployment.

## Instructions

1. Copy `bin` into your theme's directory.
2. Make sure the script is executable:
   ```sh
   chmod +x bin/prep.sh
   ```
3. Add the script to your `package.json`:
   ```diff
   "scripts": {
   +  "prep": "npm run build:production && ./bin/prep.sh"
   }
   ```

## Usage

If you've set everything up correctly, `yarn prep` will now
create a ready-to-distribute archive of your theme. When
extracting, it will keep the timestamp + hash on the folder
name. This is so you can drop it into a folder that might
already have an newer version of the theme. I typically append
`-old` to the previous one and then (quickly) remove the
timestamp + hash from the one I just extracted. It's about as
sketchy as using FTP in the first place. ¯\\\_(ツ)_/¯

## Output

This is a bare minimum distribution of Sage, which means it
removes all the necessary files for building. This discourages
modifications. It leaves a nice note warning people of this
(`dist-info.md`) as well as information regarding who last
built, what the datetime was, and the current commit short hash.

```shell
your-theme-name-{timestamp}-{latest git short hash}
├── app/
├── config/
├── dist/
├── resources/
│   ├── functions.php
│   ├── index.php
│   ├── screenshot.png
│   ├── style.css
│   └── views/
├── vendor/                   # Optimized, no-dev (from Trellis)
├── LICENSE.md                # Legally required
└── dist-info.md              # Warning + build info
```
