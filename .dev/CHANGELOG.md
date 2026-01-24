# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## \[1.3.0] - 2026-01-24

### Added

* **Camera Following Mode**: Implemented smooth camera following system with mouse-controlled rotation
* **Camera CFrame Synchronization**: Added client-server camera CFrame synchronization for balista alignment
* **CrossbowShooting PlayerService**: Client and server services for managing player state during balista interactions
* **Player Visibility Management**: Automatic character transparency when players join balistas
* **Camera Mode Attributes**: Player attribute system for camera mode state management

### Changed

* **CameraController**: Enhanced with following camera mode, smooth angle interpolation, and CFrame synchronization
* **BalistasService**: Integrated with camera system for real-time balista orientation based on player camera
* **Core PlayerService (Client)**: Added camera mode change handling and improved attribute synchronization
* **Core PlayerService (Server)**: Added camera CFrame reception and camera mode setting functionality
* **Constants**: Added camera mode constants and remote event definitions for camera synchronization

### Infrastructure

* **Camera System**: Complete camera mode switching system with Default and Following modes
* **Event Integration**: Enhanced event system for camera state changes and synchronization
* **Balista Integration**: Seamless integration between balista seats and camera system

## \[1.2.0] - 2026-01-23

### Added

* **InputService**: New client service for handling user input and mouse movement events
* **BalistasService**: Server-side service for managing balistas in CrossbowShooting minigame
* **CrossbowShooting Constants**: Shared constants module for the CrossbowShooting minigame

### Changed

* **MinigameLoader Service**: Introduced centralized minigame loading and session management
* **Core Architecture**: Refactored Master, Client, and Server classes to use MinigameLoader instead of direct minigame instantiation
* **Minigame Integration**: Updated all minigame initialization to use the new loading system
* **Event System**: Enhanced EventBus integration with input handling

### Infrastructure

* **Service Architecture**: Improved separation of concerns between core systems and minigame management
* **Code Organization**: Cleaner initialization flow with centralized minigame coordination
* **Input Processing**: Added mouse movement event handling and game state integration

## \[1.1.1] - 2026-01-23

## \[1.1.0] - 2026-01-23

### Added

* **Core Module**: Reorganized main game code into Core/ directory for better modularity
* **Minigame System**: Added 5 new minigames with independent architecture:
  * CrossbowShooting: Target shooting mechanics
  * DungeonCleaning: Area cleanup objectives
  * FoodEating: Consumption-based gameplay
  * ItemSearch: Object finding challenges
  * Racing: Competitive racing tracks
* **MinigameMaster**: New shared component for minigame management and coordination

### Changed

* **Project Structure**: Moved Client/, Server/, Shared/ directories into Core/ module
* **Version Management**: Relocated GameVersion.model.json to Core/Server/ directory

### Infrastructure

* **Modular Architecture**: Implemented scalable minigame architecture with shared core systems
* **Build Configuration**: Updated default.project.json and sourcemap.json for new structure

## \[1.0.0] - 2026-01-23

### Added

* **Project Structure**: Established clean architecture with Application, Domain, Infrastructure, and Presentation layers
* **Client Architecture**: Implemented client-side controllers, services, and use cases
* **Server Architecture**: Implemented server-side services, repositories, and use cases
* **Shared Components**: Created shared domain entities, services, and infrastructure components
* **Dependency Injection**: Added DIContainer for dependency management
* **Event System**: Implemented EventBus and RemoteEventService for client-server communication
* **Player System**: Created Player entity, repository, and services
* **Configuration**: Added configuration and constants modules
* **Development Tools**: Set up development environment with selene linting and aftman package management

### Infrastructure

* **Build System**: Configured Roblox project with sourcemap.json and default.project.json
* **Code Quality**: Added selene.toml for Lua code linting
* **Package Management**: Configured aftman.toml for tool management

### Documentation

* **Development Docs**: Created .dev/ directory structure for CHANGELOG.md and TODO.md
* **Architecture**: Established modular architecture following clean architecture principles
