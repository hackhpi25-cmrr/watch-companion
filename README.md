# Tinnitus Relief Watch App

A standalone Apple Watch application designed to help manage tinnitus through various techniques:

- Distraction games and activities
- Relaxation exercises
- Ear care information and reminders
- Customizable settings

## Setup Instructions

### Opening in Xcode

To set up this project in Xcode:

1. Open Xcode
2. Choose "Create a new Xcode project"
3. Select "Watch App" as the template
4. Name the project "Tinnitus"
5. Choose your Team, Organization Identifier, etc.
6. Create the project in a different location
7. After creation, replace the generated Swift files with the ones in this repository:
   - Replace `ContentView.swift` with the one from this repo
   - Replace `TinnitusApp.swift` with the one from this repo
   - Replace the Assets.xcassets folder with the one from this repo
   - Replace the Preview Content folder with the one from this repo

### Project Structure

- `TinnitusApp.swift` - The main app entry point
- `ContentView.swift` - The main interface with tab views for different sections
- `Assets.xcassets` - Image assets and colors
- `Preview Content` - Assets for SwiftUI previews

## Features

- **Distraction Games**: Interactive activities to shift focus away from tinnitus sounds
- **Relaxation**: Guided breathing and relaxation exercises
- **Ear Care**: Information about protecting hearing and managing tinnitus
- **Settings**: Customization options for the app

## Requirements

- watchOS 10.0+
- Xcode 15.0+ 