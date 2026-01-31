# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## \[1.29.0] - 2026-01-31

### Added

* **DungeonCleaning Loot System**: Implemented complete loot drop system for enemies with chance-based loot tables and visual effects
* **DungeonCleaning LootService**: Created server-side service for managing loot drops from defeated enemies with character-based loot configuration
* **DungeonCleaning Items Data**: Added Items.luau data module with item definitions including Poop item with score values
* **DungeonCleaning ItemsRepository**: Implemented repository pattern for accessing item data and assets following established repository architecture
* **DungeonCleaning Loot Assets**: Added LootVFX and Poop assets to shared assets module for loot drop visual feedback
* **Loot Drop Mechanics**: Implemented loot spawning system with physics-based positioning, pickup detection, and automatic cleanup

### Changed

* **DungeonCleaning ToolService**: Enhanced to integrate with LootService for dropping loot when enemies are defeated during weapon attacks
* **DungeonCleaning Server Services**: Added LootService to Services module initialization and lifecycle management
* **DungeonCleaning Shared Data**: Enhanced Data module to include Items data for centralized item definitions
* **DungeonCleaning Shared Infrastructure**: Added ItemsRepository to Repositories module for item data access
* **DungeonCleaning Shared Assets**: Enhanced Assets module to include LootVFX and Poop assets
* **Sourcemap**: Updated to include new LootService, Items data, and ItemsRepository modules

### Infrastructure

* **Loot System Architecture**: Established complete loot drop pattern with character-based loot tables and chance-based drop mechanics
* **Item Data Management**: Implemented data-driven item system with centralized item definitions and asset access
* **Repository Pattern Consistency**: ItemsRepository follows same repository pattern as other minigame repositories for code consistency
* **Loot Lifecycle Management**: Proper loot spawning, pickup detection, and cleanup flow with visual effects integration

## \[1.28.0] - 2026-01-30

### Added

* **DungeonCleaning Tool/Weapon System**: Implemented complete weapon system with client and server ToolServices for weapon management, attack handling, and hitbox detection
* **DungeonCleaning Client ToolService**: Added client-side service for managing weapon tools, animation playback, combo system, and weapon equipping/unequipping
* **DungeonCleaning Server ToolService**: Created server-side service for handling weapon attacks, hitbox detection, enemy damage application, gate attacks, and visual effects
* **DungeonCleaning InputService**: Implemented client-side input service for binding weapon usage to mouse clicks with ContextActionService integration
* **DungeonCleaning AnimationService**: Added client-side animation service for managing weapon animations including one-handed idle and combo slash animations (1-4)
* **DungeonCleaning GameService**: Created server-side GameService extending BaseGameService with trigger zone system for detecting player entry into dungeon
* **DungeonCleaning Animations Assets**: Added comprehensive animations module with OneHandedIdle, OneHandednSlash1-4, and other weapon animations
* **DungeonCleaning Weapon Constants**: Added USE_WEAPON, ENEMY_ATTACKED, and GATE_ATTACKED events to constants for weapon system coordination
* **DungeonCleaning Hitbox Assets**: Added Hitbox and HitEnemyVFX assets to shared assets module

### Changed

* **DungeonCleaning Client Services**: Enhanced Services module to include AnimationService, ToolService, and InputService initialization
* **DungeonCleaning Server Services**: Updated Services module to include GameService and ToolService with proper lifecycle management
* **DungeonCleaning Shared Assets**: Enhanced Assets module to include Animations, Hitbox, and HitEnemyVFX assets
* **DungeonCleaning Constants**: Added weapon-related events (USE_WEAPON, ENEMY_ATTACKED) to SERVER_EVENTS, CLIENT_EVENTS, and REMOTE_EVENTS
* **DungeonCleaning Client Infrastructure**: Added Repositories directory structure for future repository implementations
* **CameraController**: Enhanced camera controller with improved mouse control integration
* **EventBus**: Updated EventBus infrastructure for better event handling
* **Sourcemap**: Updated to include new DungeonCleaning service modules and assets

### Infrastructure

* **Weapon System Architecture**: Established complete weapon system pattern with client-server synchronization for attack handling
* **Animation Management**: Implemented animation service pattern for weapon animations with combo system support
* **Input Binding**: Enhanced input handling with ContextActionService integration for weapon usage
* **Hitbox Detection**: Implemented server-side hitbox detection system using GetPartBoundsInBox for enemy and gate attacks
* **Game Entry System**: Added trigger zone pattern for detecting player entry into minigame areas

## \[1.27.0] - 2026-01-29

### Added

* **DungeonCleaning Building Entity**: Implemented Building domain entity with id, model, and score tracking
* **DungeonCleaning BuildingRepository**: Added repository pattern for building entity management with createBuildingEntity() and getBuildingEntity() methods
* **DungeonCleaning BuildingService**: Created server-side service for building registration and lifecycle management

### Changed

* **DungeonCleaning Services**: Enhanced Services module to include BuildingService initialization and lifecycle
* **DungeonCleaning Application**: Updated Application to initialize BuildingService alongside PlayerService and EnemyService
* **DungeonCleaning Repositories**: Added BuildingRepository to server repositories module initialization
* **DungeonCleaning Entities**: Integrated Building entity into Shared domain entities module
* **Sourcemap**: Updated to include new Building entity module

## \[1.26.0] - 2026-01-29

### Added

* **DungeonCleaning Services**: Added client/server player services and service initialization scaffolding
* **DungeonCleaning Repositories**: Added server repositories for enemy/building/player plus shared player repository
* **DungeonCleaning Data & Enemy Entity**: Introduced enemy entity and shared enemy data definitions
* **DungeonCleaning Shared Modules**: Added Shared/Data and Shared/Infrastructure module scaffolding

### Changed

* **DungeonCleaning App Wiring**: Hooked application and infrastructure init flows to services/repositories
* **Minigame Cleanup**: Removed unused headers/imports in base/minigame services and repositories
* **Sourcemap**: Updated to include new DungeonCleaning modules

## \[1.25.0] - 2026-01-29

### Added

* **Core Minigame Base Services**: Introduced shared base services for minigame game and player lifecycles (client/server)
* **Core Minigame Base Repository**: Added shared base player repository for minigame player entity management

### Changed

* **FoodEating & Shooting Services**: Refactored game and player services to extend core minigame base services
* **Minigame Player Repositories**: Simplified shared player repositories to inherit from base repository
* **FoodEating Result Emission**: Aligned game result event to use core minigame constants
* **Sourcemap**: Updated to include new Core/Shared/Minigame modules

## \[1.24.0] - 2026-01-29

### Added

* **Core ResultUI Component**: Implemented game result display UI with player scores, rankings, and scrollable player list
* **SHOW\_GAME\_RESULT Event**: Added server event for triggering game result display across all players
* **OPEN\_RESULT\_UI Event**: Added client event for opening the result UI with game data
* **FoodEating Game Finished Flow**: Implemented complete game finish flow collecting player scores and displaying results

### Changed

* **Core Client UI**: Enhanced with ResultUI ScreenGui containing close button, game name label, and player result template system
* **Core Presentation Layer**: Added event listener for OPEN\_RESULT\_UI to show game results
* **Core Server PlayerService**: Added SHOW\_GAME\_RESULT event handler for processing and forwarding game results
* **Core Shared Constants**: Added OPEN\_RESULT\_UI to CLIENT\_EVENTS and SHOW\_GAME\_RESULT to SERVER\_EVENTS
* **FoodEating ChairService**: Enhanced with core event bus integration, GAME\_FINISHED listener, and result collection logic
* **FoodEating Chair Entity**: Enhanced clear() method to eject occupants by triggering jump

### Infrastructure

* **Result Display System**: Established pattern for minigame result display through core UI components
* **Event Flow Integration**: Connected minigame finish events to core result display system
* **Player Result Sorting**: Implemented score-based ranking for game result presentation

## \[1.23.0] - 2026-01-29

### Added

* **FoodEating Periodic Minigame Updates**: Implemented periodic update system for minigames with FoodController firing UPDATE\_MINIGAME events every second
* **FoodEating ClickerMinigame Decay**: Added automatic progress decay system (0.1 per second) requiring continuous player interaction
* **FoodEating TaperMinigame Periodic Spawning**: Implemented periodic taper button creation every 2 seconds for time-based challenge
* **FoodEating Score Tracking System**: Added real-time score change tracking using player entity score attribute Changed event
* **FoodEating Score Display Integration**: Integrated score updates into UI presentation layer with UPDATE\_SCORE event handling
* **FoodEating Core Mouse Control Integration**: Enhanced InputService integration with core SET\_FREE\_MOUSE event for coordinated mouse control

### Changed

* **FoodEating FoodController**: Enhanced with periodic update system firing UPDATE\_MINIGAME events at 1-second intervals
* **FoodEating FoodService**: Added UPDATE\_MINIGAME event listener to trigger update() method on active minigame modules
* **FoodEating ClickerMinigame**: Enhanced with update() method implementing automatic progress decay over time
* **FoodEating TaperMinigame**: Enhanced with update() method for periodic taper button creation with 2-second intervals
* **FoodEating Client PlayerService**: Refactored to track score changes using player entity score attribute Changed event and fire UPDATE\_SCORE events
* **FoodEating Presentation Layer**: Enhanced with UPDATE\_SCORE event listener for real-time score display updates
* **FoodEating InputService**: Improved integration with core event system for SET\_FREE\_MOUSE coordination
* **FoodEating Constants**: Added UPDATE\_MINIGAME and UPDATE\_SCORE events to CLIENT\_EVENTS

### Infrastructure

* **Time-Based Minigame Mechanics**: Established periodic update pattern for minigames requiring continuous player engagement
* **Score Synchronization**: Enhanced score tracking with real-time updates through player entity attribute changes
* **Event-Driven UI Updates**: Improved UI responsiveness with event-driven score and minigame state updates
* **Mouse Control Coordination**: Better integration between minigame input handling and core camera/mouse control systems

## \[1.22.0] - 2026-01-28

### Added

* **FoodEating PlayerRepository Pattern**: Implemented complete repository pattern for player entity management following Shooting minigame pattern
* **FoodEating Shared PlayerRepository**: Created SharedFoodEatingPlayerRepository base class in Shared/Infrastructure/Repositories/ for player entity lifecycle management
* **FoodEating Client PlayerRepository**: Added ClientFoodEatingPlayerRepository extending shared repository for client-side player entity tracking
* **FoodEating Server PlayerRepository**: Added ServerFoodEatingPlayerRepository extending shared repository for server-side player entity management
* **FoodEating Shared Application Services**: Created Shared/Application/Services/ directory with base PlayerService class for code reuse
* **FoodEating Player Entity Integration**: Integrated player repository into PlayerServices for entity-based state management

### Changed

* **FoodEating Client PlayerService**: Refactored to use PlayerRepository for player entity management with createPlayerEntity() and removePlayerEntity() methods
* **FoodEating Server PlayerService**: Enhanced to use PlayerRepository for score management and player entity lifecycle (create, get, remove)
* **FoodEating Client Infrastructure**: Added PlayerRepository to client repositories module for entity management
* **FoodEating Server Infrastructure**: Added PlayerRepository to server repositories module alongside ChairRepository and FoodRepository
* **FoodEating PlayerService Architecture**: Refactored PlayerServices to extend shared base class for consistent pattern across client and server
* **FoodEating Score System**: Enhanced score system to use player entity addScore() method through repository pattern

### Infrastructure

* **Repository Pattern Consistency**: FoodEating minigame now follows same repository pattern as Shooting minigame for player entities
* **Code Reuse**: Shared repository pattern reduces code duplication between client and server player management
* **Entity Lifecycle Management**: Improved player entity lifecycle with proper creation, retrieval, and cleanup through repository
* **State Management**: Enhanced state management with entity-based approach instead of event-only communication

## \[1.21.0] - 2026-01-28

### Added

* **FoodEating Game Timer System**: Implemented complete game timer system with countdown functionality matching Shooting minigame pattern
* **FoodEating GameService**: Added server-side GameService for managing game state with 30-second default time and countdown timer
* **FoodEating Client GameService**: Added client-side GameService for game entity management and time synchronization
* **FoodEating GameController**: Created server controller for periodic game time updates with 1-second interval countdown
* **FoodEating Timer UI Display**: Added timer label to FoodEating UI showing game time countdown
* **FoodEating Game Lifecycle**: Implemented GAME\_FINISHED event handling for proper game end and cleanup flow
* **FoodEating Time Events**: Added UPDATE\_TIME and GAME\_FINISHED events to SERVER\_EVENTS and CLIENT\_EVENTS constants

### Changed

* **EventBus Infrastructure**: Refactored EventBus from directory structure (EventBus/init.luau and EventBus/Event.model.json) to single consolidated file (EventBus.luau) for simpler structure
* **FoodEating Application**: Enhanced Application with GAME\_FINISHED event listener for automatic game stop on time expiration
* **FoodEating Controllers**: Integrated GameController into Controllers heartbeat update loop alongside FoodController
* **FoodEating Services**: Added GameService to both client and server service initialization
* **FoodEating Presentation**: Added UPDATE\_TIME event listener for timer display updates in UI

### Infrastructure

* **Game Timer Consistency**: FoodEating minigame now follows same timer pattern as Shooting minigame for consistency
* **EventBus Simplification**: Consolidated EventBus structure reduces complexity and improves maintainability
* **Game Lifecycle Management**: Enhanced game lifecycle with proper finish/stop flow matching Shooting minigame pattern
* **Time Synchronization**: Implemented time synchronization between server and client with event-driven updates

## \[1.20.0] - 2026-01-28

### Added

* **FoodEating ComboMinigame Logic**: Implemented complete combo minigame mechanics with sequence tracking, input validation, and completion detection
* **FoodEating Food Data System**: Created comprehensive Food.luau data module with all food definitions including eatingType and combo sequences
* **FoodEating KeyImages Data**: Added KeyImages.luau module with UI image asset IDs for arrow keys (Left, Right, Up, Down) used in combo minigame
* **FoodEating ComboMinigame UI**: Implemented key image display system showing combo sequence with visual feedback for completed keys
* **FoodEating ComboMinigame Input Success Event**: Added COMBO\_MINIGAME\_INPUT\_SUCCESS event to constants for UI synchronization

### Changed

* **FoodEating ComboMinigame**: Enhanced with proper input handling, sequence validation, and automatic completion when combo is finished
* **FoodEating FoodRepository**: Refactored to use new Food data structure from Shared/Data/Food.luau instead of hardcoded food definitions
* **FoodEating ComboMinigame UI**: Enhanced with dynamic key image creation, combo sequence visualization, and progress transparency updates
* **FoodEating Shared Data Module**: Updated Shared/Data/init.luau to include Food and KeyImages modules for centralized data access
* **FoodEating Food Entity**: Enhanced Food entity to support combo sequences in food data structure

### Infrastructure

* **Data-Driven Food System**: Established data-driven approach for food definitions with eatingType and combo sequences
* **Combo Sequence Visualization**: Implemented visual feedback system showing combo progress through key image transparency
* **Food Data Centralization**: Centralized all food definitions in Shared/Data/Food.luau for easier maintenance and expansion

## \[1.19.0] - 2026-01-28

### Added

* **FoodEating ClickerMinigame Logic**: Implemented complete clicker minigame mechanics with progress tracking (0-1 range), input handling, and automatic decay over time
* **FoodEating ClickerMinigame Completion**: Added food eating completion logic that fires EAT\_FOOD remote event when progress reaches maximum
* **FoodEating ComboMinigame Toggle**: Implemented toggle events for enabling/disabling combo minigame input handling
* **FoodEating Input Service Events**: Added CLICKER\_MINIGAME\_INPUT and COMBO\_MINIGAME\_INPUT events to constants for minigame input coordination
* **FoodEating UI Progress Tracking**: Implemented progress bar updates for ClickerMinigame UI module with real-time progress synchronization
* **FoodEating UI Lifecycle**: Added init() methods to all UI modules (ClickerMinigame, ComboMinigame, TaperMinigame) for proper event listener setup
* **FoodEating Application Stop Flow**: Enhanced Application stop() method to properly cleanup services and minigame modules

### Changed

* **FoodEating ClickerMinigame**: Enhanced with progress tracking system, event-driven input handling, and completion detection
* **FoodEating InputService**: Refactored to use event-driven toggle system for different minigame types instead of player join/leave events
* **FoodEating InputService**: Changed from ContextActionService-only to hybrid approach (ContextActionService for clicker, UserInputService for combo)
* **FoodEating FoodService**: Added stop() method to properly cleanup all minigame modules when application stops
* **FoodEating Services**: Enhanced Services module with stop() method for proper lifecycle management
* **FoodEating PlayerService**: Fixed application lifecycle order - application start/stop now fires before/after events
* **FoodEating UI Modules**: Refactored to accept diContainer parameter for dependency injection and event bus access
* **FoodEating Presentation**: Enhanced with PLAYER\_JOINED\_FOOD\_EATING and PLAYER\_LEFT\_FOOD\_EATING event listeners for UI toggle
* **FoodEating UI**: Changed setup() to init() method for consistency with service initialization pattern
* **FoodEating UI**: Added Enabled property control for UI visibility management

### Infrastructure

* **Event-Driven Input Binding**: Implemented toggle-based input binding system allowing minigames to dynamically enable/disable input handling
* **Minigame Lifecycle Management**: Enhanced minigame module lifecycle with proper start/stop/update flow and cleanup
* **Progress Synchronization**: Established event-driven progress synchronization between minigame logic and UI presentation
* **Service Cleanup Pattern**: Standardized service cleanup pattern with stop() methods throughout application lifecycle

## \[1.18.0] - 2026-01-28

### Added

* **FoodEating Minigame Modules**: Implemented modular minigame system with three minigame types (ClickerMinigame, ComboMinigame, TaperMinigame) for different food eating mechanics
* **FoodEating FoodController**: Client-side controller for periodic minigame updates with 1-second interval
* **FoodEating Minigame UI Modules**: Created UI modules for each minigame type (ClickerMinigame, ComboMinigame, TaperMinigame) with show/hide functionality
* **FoodEating Eating Types**: Added eatingType system (taper, clicker, combo) to food data for different minigame mechanics
* **FoodEating Application Lifecycle**: Enhanced Application with start/stop methods for controller lifecycle management
* **FoodEating Minigame Integration**: Integrated minigame modules into FoodService with event-driven activation based on food type

### Changed

* **FoodEating FoodService**: Refactored into modular structure with minigame modules directory (FoodService/Modules/) for better organization
* **FoodEating Food Data**: Enhanced food data with eatingType field mapping each food to its corresponding minigame type
* **FoodEating InputService**: Enhanced with player join/leave event handling for proper input binding lifecycle
* **FoodEating PlayerService**: Added application start/stop integration for proper lifecycle management
* **FoodEating UI**: Refactored to support multiple minigame UI modules with dynamic activation based on eatingType
* **FoodEating Presentation**: Enhanced with SPAWN\_FOOD event listener for minigame UI activation

### Infrastructure

* **Modular Minigame Architecture**: Established modular minigame system allowing different food types to trigger different minigame mechanics
* **Event-Driven Minigame Activation**: Implemented event-driven system for activating appropriate minigame based on food eatingType
* **Controller Lifecycle Management**: Enhanced application lifecycle with proper start/stop flow for controllers
* **UI Module Pattern**: Standardized UI module pattern with setup/start/stop methods for consistent minigame UI management

## \[1.17.0] - 2026-01-27

### Added

* **FoodEating Food Entity**: Implemented Food domain entity with foodModel and foodType tracking
* **FoodEating FoodService**: Server-side service for managing food spawning and eating mechanics with chair integration
* **FoodEating FoodRepository**: Repository pattern implementation for food entity management following established patterns
* **FoodEating FoodController**: Controller for periodic food spawning with 1-second interval updates
* **FoodEating InputService**: Client-side service for handling mouse click input to eat food with ContextActionService binding
* **FoodEating ItemsRepository**: Shared repository for accessing food assets following repository pattern
* **FoodEating Assets Module**: Added comprehensive food assets collection (Bread, Burger, Fries, Pizza, Steak, Pies, Cakes, etc.)
* **Food Spawning System**: Implemented automatic food spawning for occupied chairs without current food
* **Food Eating Mechanics**: Added eat food functionality with remote event handling and chair-food interaction

### Changed

* **Chair Entity**: Enhanced with foodSpawnPart field, currentFood tracking, spawnFood() method, and eatFood() method for food lifecycle management
* **ChairRepository**: Added getChairByPlayer() method for finding chairs by occupant player
* **FoodEating Constants**: Added SPAWN\_FOOD server event and EAT\_FOOD remote event for food system coordination
* **FoodEating Architecture**: Reorganized services into Application/Services directory structure for better organization
* **FoodEating Infrastructure**: Added Infrastructure layer with ItemsRepository for shared asset access

### Infrastructure

* **Food System Architecture**: Complete food spawning and eating system with event-driven architecture
* **Controller Pattern**: FoodController integrated into application lifecycle with periodic updates
* **Input Handling**: Client-side input service with event-driven food eating actions
* **Repository Pattern Consistency**: FoodRepository follows same pattern as ChairRepository for code consistency
* **Asset Management**: Centralized food asset management through ItemsRepository with shared infrastructure

## \[1.16.0] - 2026-01-27

### Added

* **FoodEating Chair System**: Implemented Chair entity with seat and proximity prompt handling for player interaction
* **FoodEating ChairService**: Server-side service for managing chair entities and player seating mechanics
* **FoodEating ChairRepository**: Repository pattern implementation for chair entity management following established patterns
* **FoodEating PlayerService**: Server-side player service with camera mode switching for seated players
* **FoodEating Constants**: Added shared constants module with PLAYER\_JOINED\_FOOD\_EATING and PLAYER\_LEFT\_FOOD\_EATING events
* **Fixed Camera Mode**: Added FIXED camera mode to camera system for static camera positioning (used by FoodEating minigame)
* **FoodEating Infrastructure**: Added Infrastructure layer with Repositories module for FoodEating minigame

### Changed

* **CameraController**: Enhanced with `_setFixedCameraMode()` method for static camera positioning based on CFrame
* **Core Constants**: Added FIXED camera mode to CAMERA\_MODES and updated cameraMode type alias
* **FoodEating Map Assets**: Added Workspace/Maps/FoodEating/ directory with chair assets
* **Shooting PlayerService**: Updated with reward calculation method for game completion

### Infrastructure

* **FoodEating Architecture**: Established complete server-side architecture with ChairService, ChairRepository, and PlayerService
* **Camera Mode System**: Extended camera system to support three modes: Default, Following, and Fixed
* **Repository Pattern Consistency**: FoodEating ChairRepository follows same pattern as other minigame repositories
* **Event-Driven Architecture**: FoodEating minigame integrated with event bus for player join/leave notifications

## \[1.15.0] - 2026-01-27

### Added

* **Core Player Entity**: Created MiniGamePlayerEntity base class in Core/Shared/Domain/MiniGameEntities/Player.luau with score tracking and lifecycle management
* **Minigame Player Entities**: Implemented Player entities for all minigames (DungeonCleaning, FoodEating, ItemSearch, Racing, Shooting) extending core Player entity
* **Game Finishing System**: Added GAME\_FINISHED event to Shooting minigame constants for game end detection
* **Application Lifecycle**: Enhanced Application stop() method to properly cleanup services (gameService, playerService, targetService) on game finish

### Changed

* **Game Entity Location**: Moved Game entity from Core/Shared/Domain/Entities/Game.luau to Core/Shared/Domain/MiniGameEntities/Game.luau for better organization
* **GameService**: Enhanced GameService to fire GAME\_FINISHED event when game time expires
* **Application Event Handling**: Added GAME\_FINISHED event listener in Application init() to trigger game stop and cleanup
* **Player Entity Pattern**: Standardized Player entity inheritance pattern across all minigames matching Game entity pattern

### Infrastructure

* **Entity Consistency**: All minigames now have consistent Player and Game entity patterns with core entity inheritance
* **Lifecycle Management**: Improved game lifecycle with proper finish/stop/cleanup flow
* **Code Organization**: Better separation of core entities (MiniGameEntities) from domain-specific entities

## \[1.14.0] - 2026-01-27

### Added

* **Domain Layer Architecture**: Implemented Domain layer structure for all minigames (DungeonCleaning, FoodEating, ItemSearch, Racing) following clean architecture pattern
* **Game Entity Inheritance**: Created Game entities for all minigames extending core Game entity with time tracking functionality
* **Minigame Domain Entities**: Added Domain/Entities structure to DungeonCleaning, FoodEating, ItemSearch, and Racing minigames
* **Consistent Shared Module Pattern**: Standardized Shared module initialization across all minigames with dependency injection support

### Changed

* **Core Game Entity**: Refactored Game entity constructor to accept `gameModule` parameter for better inheritance support
* **Minigame Shared Modules**: Enhanced all minigame Shared modules (DungeonCleaning, FoodEating, ItemSearch, Racing) with proper dependency injection, domain initialization, and event bus setup
* **Naming Consistency**: Updated Shooting minigame class names to use "Shared" prefix (SharedShootingDomain, SharedShootingEntities) for consistency
* **Code Formatting**: Improved indentation and code organization across minigame Domain modules

### Infrastructure

* **Architecture Consistency**: All minigames now follow the same architectural pattern with Domain layer separation
* **Code Reuse**: Game entities across minigames inherit from core Game entity, reducing code duplication
* **Dependency Injection**: Standardized DI container usage across all minigame Shared modules
* **Event System Integration**: Consistent event bus initialization pattern across all minigames

## \[1.13.0] - 2026-01-27

### Added

* **Game Entity System**: Implemented ShootingGameEntity domain entity with time tracking and countdown timer functionality
* **Server GameService**: Server-side service for managing game state with initial time configuration (60 seconds)
* **Client GameService**: Client-side service for game entity management and time synchronization
* **GameController**: Server controller for periodic game time updates with 1-second interval countdown
* **Timer UI Display**: Added timer label to Shooting UI showing formatted time (MM:SS)
* **Time Events**: Added UPDATE\_TIME events to SERVER\_EVENTS, REMOTE\_EVENTS, and CLIENT\_EVENTS constants
* **Time Synchronization**: Implemented time synchronization between server and client with event-driven updates

### Changed

* **Controllers Module**: Enhanced to include GameController in heartbeat update loop alongside TargetController
* **UI Presentation**: Added UPDATE\_TIME event listener for timer display updates
* **Game Entity Lifecycle**: Game entity created when player joins balista and synchronized to client
* **Application Services**: Added GameService to both client and server service initialization

### Infrastructure

* **Game State Management**: Centralized game state management with entity-based time tracking
* **Controller Integration**: GameController integrated into existing controller heartbeat system for consistent updates
* **Event Flow**: Enhanced event-driven architecture for game time synchronization across all layers
* **UI Integration**: Timer display integrated into existing Shooting UI with proper formatting

## \[1.12.0] - 2026-01-26

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

## \[1.11.0] - 2026-01-26

### Added

* **Score System**: Implemented complete scoring system for target hits with score tracking and display
* **Score Display UI**: Added score label and animated score updates in Shooting UI
* **Score Events**: Added ADD\_SCORE events to SERVER\_EVENTS, REMOTE\_EVENTS, and CLIENT\_EVENTS constants
* **Target Score Integration**: Target entities now include score values from item data
* **Score Animation**: Implemented smooth score transition animation using TweenService

### Changed

* **TargetService**: Enhanced to fire ADD\_SCORE events when targets are hit with player tracking
* **Server PlayerService**: Added score handling to forward ADD\_SCORE events to clients
* **Client PlayerService**: Added ADD\_SCORE remote event handling and client event firing
* **UI Presentation**: Integrated score update handling in Presentation layer event connections
* **Shooting UI**: Added updateScore method with score label display and animation support
* **Target Hit Flow**: Improved target hit detection flow with score calculation and player attribution

### Infrastructure

* **Score Synchronization**: Complete score synchronization between server and client
* **Event Flow**: Enhanced event-driven architecture for score updates across all layers
* **UI Integration**: Better integration between game logic and UI presentation for score display

## \[1.10.0] - 2026-01-26

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

## \[1.9.0] - 2026-01-26

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

## \[1.8.0] - 2026-01-25

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

## \[1.7.0] - 2026-01-24

### Added

* **Target Spawner System**: Implemented spawner location system for flying and ground targets
* **Target Type Categorization**: Added support for flying (Starship, BigStarship) and ground (Tank, LightTank) target types
* **Controller Lifecycle Management**: Added start/stop methods to Controllers for proper lifecycle management
* **Server Events**: Added SPAWN\_TARGET and TARGET\_SPAWNED events to constants for target spawning coordination

### Changed

* **TargetController**: Refactored spawnTarget to private method (\_spawnTarget) for better encapsulation
* **Controllers Module**: Separated initialization and runtime logic with init/start/stop methods
* **TargetService**: Enhanced with spawner-based target placement and target type selection logic
* **Application Architecture**: Added controllers field to Application class type definition
* **Code Formatting**: Improved indentation and code organization across Shooting minigame server files

### Infrastructure

* **Event-Driven Architecture**: Improved event bus integration for target spawning workflow
* **Code Organization**: Better separation between initialization and runtime execution phases

## \[1.6.0] - 2026-01-24

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

## \[1.5.0] - 2026-01-24

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

## \[1.4.0] - 2026-01-24

### Added

* **Shooting Mechanics**: Implemented projectile shooting system for CrossbowShooting minigame
* **Parabolic Trajectory**: Added physics-based projectile motion with gravity and velocity calculations
* **CrossbowShooting InputService**: Client-side service for handling mouse click shooting input
* **Shoot Event Handling**: Server-side shoot event processing with balista owner validation
* **Assets Module**: Created shared Assets module for CrossbowShooting minigame resources
* **Client Events**: Added CLIENT\_EVENTS constants for player joined/left balista notifications

### Changed

* **BalistasService**: Enhanced with shooting mechanics, projectile spawning, and parabolic trajectory physics
* **CrossbowShooting PlayerService**: Added event bus firing for player joined/left balista events
* **CrossbowShooting Services**: Integrated InputService into client services initialization
* **Constants**: Added SHOOT remote event and CLIENT\_EVENTS definitions
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
