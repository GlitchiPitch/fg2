# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-23

### Added
- **Project Structure**: Established clean architecture with Application, Domain, Infrastructure, and Presentation layers
- **Client Architecture**: Implemented client-side controllers, services, and use cases
- **Server Architecture**: Implemented server-side services, repositories, and use cases
- **Shared Components**: Created shared domain entities, services, and infrastructure components
- **Dependency Injection**: Added DIContainer for dependency management
- **Event System**: Implemented EventBus and RemoteEventService for client-server communication
- **Player System**: Created Player entity, repository, and services
- **Configuration**: Added configuration and constants modules
- **Development Tools**: Set up development environment with selene linting and aftman package management

### Infrastructure
- **Build System**: Configured Roblox project with sourcemap.json and default.project.json
- **Code Quality**: Added selene.toml for Lua code linting
- **Package Management**: Configured aftman.toml for tool management

### Documentation
- **Development Docs**: Created .dev/ directory structure for CHANGELOG.md and TODO.md
- **Architecture**: Established modular architecture following clean architecture principles