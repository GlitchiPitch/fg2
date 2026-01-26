# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.12.0] - 2026-01-26

### Added

* **Player Entity System**: Implemented ShootingPlayerEntity domain entity with score tracking and serialization support
* **Player Repository Pattern**: Created shared PlayerRepository following repository pattern for player entity management
* **Client PlayerRepository**: Client-side repository extending shared repository for player entity tracking
* **Server PlayerRepository**: Server-side repository extending shared repository for player entity management
* **Player Entity Serialization**: Added `toData()` and `fromData()` methods for player entity state serialization
* **Player Entity Score Management**: Implemented `addScore()` method for score updates on player entities

### Changed

* **Shared PlayerService**: Enhanced with playerRepository integration and base structure for client/server implementations
* **Client PlayerService**: Refactored to use PlayerRepository for entity management, added `getPlayerEntity()` method, and integrated with player entity state synchronization
* **Server PlayerService**: Enhanced to use PlayerRepository for score management, added player entity synchronization on join, and improved score update flow with entity state
* **UI Score Display**: Updated to use `playerService:getPlayerEntity()` for accessing player score from entity instead of event data
* **Score System Architecture**: Refactored score system to use repository pattern for persistent player state management
* **Player State Synchronization**: Improved player state synchronization between server and client using entity serialization

### Infrastructure

* **Repository Pattern Consistency**: Player entities now follow the same repository pattern as Balista entities for code consistency
* **Entity Lifecycle Management**: Better player entity lifecycle management with proper creation, retrieval, and cleanup
* **State Management**: Improved state management with entity-based approach instead of event-only communication
* **Code Reuse**: Shared repository pattern reduces code duplication between client and server player management

## [1.11.0] - 2026-01-26

### Added

* **Score System**: Implemented complete scoring system for target hits with score tracking and display
* **Score Display UI**: Added score label and animated score updates in Shooting UI
* **Score Events**: Added ADD_SCORE events to SERVER_EVENTS, REMOTE_EVENTS, and CLIENT_EVENTS constants
* **Target Score Integration**: Target entities now include score values from item data
* **Score Animation**: Implemented smooth score transition animation using TweenService

### Changed

* **TargetService**: Enhanced to fire ADD_SCORE events when targets are hit with player tracking
* **Server PlayerService**: Added score handling to forward ADD_SCORE events to clients
* **Client PlayerService**: Added ADD_SCORE remote event handling and client event firing
* **UI Presentation**: Integrated score update handling in Presentation layer event connections
* **Shooting UI**: Added updateScore method with score label display and animation support
* **Target Hit Flow**: Improved target hit detection flow with score calculation and player attribution

### Infrastructure

* **Score Synchronization**: Complete score synchronization between server and client
* **Event Flow**: Enhanced event-driven architecture for score updates across all layers
* **UI Integration**: Better integration between game logic and UI presentation for score display

## [1.10.0] - 2026-01-26

### Added

* **Client Shoot Event Handling**: Added remote event connection for shoot result synchronization from server
* **Ammo Index System**: Implemented string-based ammo indexing system for better asset management
* **Shoot Callback Pattern**: Added onShootCallback to balista setup for flexible bullet creation

### Changed

* **Server BalistaService**: Refactored ammo system to use string indexes (`_ammoIndexes`) instead of direct model references
* **Ammo Asset Management**: Changed from array-based ammo storage to dictionary-based asset lookup (`_ammoAssets`)
* **Shoot Result Handling**: Enhanced shoot result processing with proper reload/success state management and client synchronization
* **Balista Shoot Method**: Changed return type from table to string ("reload" or "success") for clearer state communication
* **Ammo Random Selection**: Refactored `_getRandomAmmo()` to return string names instead of Model instances
* **Reload State Management**: Improved reloading state tracking in `setAmmo()` method with automatic state updates
* **Client BalistaService**: Added `_onShoot()` method stub for handling shoot results from server

### Infrastructure

* **Callback Pattern**: Implemented callback-based bullet creation for better separation of concerns
* **State Communication**: Improved state synchronization between server and client with string-based result codes
* **Asset Management**: Better separation between ammo data (indexes) and ammo assets (models)

## [1.9.0] - 2026-01-26

### Added

* **Client BalistaService**: New client-side service for managing balista entities with event-driven architecture
* **Shared BalistaRepository**: Created shared repository pattern implementation for balista entity management
* **Balista Entity Serialization**: Added `toData()` method for balista entity state serialization
* **Reloading System**: Implemented ammo reloading mechanism with 2-second reload delay
* **Client BalistaRepository**: Client-side repository extending shared repository for balista entity tracking
* **Shooting UI**: Added Presentation layer UI structure for shooting minigame

### Changed

* **Balista Entity Constructor**: Refactored to accept data table parameter instead of separate arguments for better flexibility
* **Balista Shoot Method**: Enhanced to return reload status and prevent shooting during reload
* **Balista Destroy Method**: Improved cleanup with proper ammo and connection disposal
* **Repository Pattern**: Server and Client repositories now inherit from shared repository for code reuse
* **Server BalistaService**: Enhanced with GUID-based balista IDs and balista data synchronization to client
* **Client PlayerService**: Updated to pass balista data through event chain for proper entity creation
* **Event Data Flow**: Improved event data passing between server and client for balista state synchronization

### Infrastructure

* **Code Reuse**: Shared repository pattern reduces code duplication between client and server
* **Entity Lifecycle**: Better entity state management with serialization support
* **Event Architecture**: Enhanced event-driven communication with structured data passing
* **Client-Server Sync**: Improved synchronization of balista entities between client and server

## [1.8.0] - 2026-01-25

### Added

* **Target Entity**: Complete domain entity implementation with spawn, movement, and destroy lifecycle
* **Target Movement System**: Implemented AlignPosition and AlignOrientation for smooth target movement between spawners
* **Target Repository**: New repository pattern for managing target entities with ID-based tracking
* **Application Lifecycle Management**: Added start/stop methods to Application class for proper controller lifecycle
* **Target Auto-Destruction**: Automatic target cleanup after 10 seconds with proper resource cleanup

### Changed

* **TargetService**: Enhanced with spawner-based target placement and random target type selection (flying/ground)
* **BalistaService**: Integrated with application lifecycle - starts/stops controllers when players join/leave balistas
* **PlayerService**: Added event handling for player joined/left balista events with camera mode switching
* **Controllers Module**: Implemented RunService.Heartbeat connection for continuous target spawning updates
* **Infrastructure Layer**: Added TargetRepository to server infrastructure repositories
* **Target Spawning Logic**: Improved spawner selection with random start/finish attachment pairing

### Infrastructure

* **Repository Pattern**: Complete TargetRepository implementation following repository pattern for target entity management
* **Entity Lifecycle**: Proper cleanup of AlignPosition, AlignOrientation, and Attachment instances on target destruction
* **Event Integration**: Enhanced event-driven architecture for target spawning coordination
* **Code Organization**: Better separation between domain entities, repositories, and services

## [1.7.0] - 2026-01-24

### Added

* **Target Spawner System**: Implemented spawner location system for flying and ground targets
* **Target Type Categorization**: Added support for flying (Starship, BigStarship) and ground (Tank, LightTank) target types
* **Controller Lifecycle Management**: Added start/stop methods to Controllers for proper lifecycle management
* **Server Events**: Added SPAWN_TARGET and TARGET_SPAWNED events to constants for target spawning coordination

### Changed

* **TargetController**: Refactored spawnTarget to private method (_spawnTarget) for better encapsulation
* **Controllers Module**: Separated initialization and runtime logic with init/start/stop methods
* **TargetService**: Enhanced with spawner-based target placement and target type selection logic
* **Application Architecture**: Added controllers field to Application class type definition
* **Code Formatting**: Improved indentation and code organization across Shooting minigame server files

### Infrastructure

* **Event-Driven Architecture**: Improved event bus integration for target spawning workflow
* **Code Organization**: Better separation between initialization and runtime execution phases

## [1.6.0] - 2026-01-24

### Added

* **ItemsRepository**: Created shared repository pattern for accessing item data and assets
* **TargetService**: New server service for managing target spawning and lifecycle
* **TargetController**: Controller for periodic target spawning with configurable intervals
* **Infrastructure Layer**: Added Infrastructure module to Shooting minigame for repository management
* **New Target Assets**: Added Starship, BigStarship, Tank, and LightTank models for target variety
* **Item Data System**: Enhanced Items data structure with type annotations and expanded item definitions

### Changed

* **BalistaService**: Refactored to use ItemsRepository instead of direct asset access for better separation of concerns
* **Assets Module**: Renamed Ship to Starship and added new target models (BigStarship, Tank, LightTank)
* **Items Data**: Expanded item definitions with Starship, BigStarship, Tank, and LightTank entries
* **Shared Module**: Integrated Infrastructure layer for repository access

### Infrastructure

* **Repository Pattern**: Implemented ItemsRepository following repository pattern for data access abstraction
* **Code Cleanup**: Removed unused imports and debug code from BalistaService
* **Architecture**: Improved separation between data access and business logic layers

## [1.5.0] - 2026-01-24

### Changed

* **Minigame Rename**: Renamed CrossbowShooting minigame to Shooting for better clarity and consistency
* **MinigameMaster**: Enhanced to skip Presentation layer initialization on server-side for better performance
* **Constants**: Updated minigame constants to use "Shooting" instead of "CrossbowShooting"
* **Master Integration**: Updated Master.luau to load "Shooting" minigame instead of "CrossbowShooting"
* **Project Configuration**: Updated default.project.json and sourcemap.json to reflect new minigame name

### Infrastructure

* **Code Organization**: Improved minigame naming consistency across the codebase
* **Server Optimization**: Presentation layer is now properly excluded from server-side initialization
* **Build System**: Updated build configuration to match new minigame structure

## [1.4.0] - 2026-01-24

### Added

* **Shooting Mechanics**: Implemented projectile shooting system for CrossbowShooting minigame
* **Parabolic Trajectory**: Added physics-based projectile motion with gravity and velocity calculations
* **CrossbowShooting InputService**: Client-side service for handling mouse click shooting input
* **Shoot Event Handling**: Server-side shoot event processing with balista owner validation
* **Assets Module**: Created shared Assets module for CrossbowShooting minigame resources
* **Client Events**: Added CLIENT_EVENTS constants for player joined/left balista notifications

### Changed

* **BalistasService**: Enhanced with shooting mechanics, projectile spawning, and parabolic trajectory physics
* **CrossbowShooting PlayerService**: Added event bus firing for player joined/left balista events
* **CrossbowShooting Services**: Integrated InputService into client services initialization
* **Constants**: Added SHOOT remote event and CLIENT_EVENTS definitions
* **Shared Module**: Added Assets module integration for shared resource access
* **Core InputService**: Added ContextActionService import for action binding support

### Infrastructure

* **Projectile Physics**: Implemented frame-by-frame physics simulation with gravity and velocity updates
* **Event System**: Enhanced event flow between client and server for shooting actions
* **Balista Owner Tracking**: Improved balista ownership management for shooting validation

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
