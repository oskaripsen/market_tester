Project logic 
### Frontend (Flutter)
- Core components with standardized widgets and layout helpers
- Theme system for consistent design (colors, typography, dimensions)
- Models, Services, Repositories for data management
- Screens and domain-specific widgets for UI
- Utils and config for environment switching
- Testing infrastructure for unit/widget tests

### Backend (FastAPI)
- API routing with organized endpoints and dependencies
- Core configuration and security features
- Database models with SQLAlchemy ORM
- Pydantic schemas for validation
- Service-based business logic
- Utility helpers for common operations
- Comprehensive test suite
- Deployment configuration for Fly.io

This structure allows clean scaling, testability, and easy feature addition—ideal for agile product evolution.

Project directory

market_tester/
├── frontend/                        # Flutter app
│   ├── lib/
│   │   ├── core/                    # Foundational components and layout logic
│   │   │   ├── widgets/             # Standard UI components (e.g., AppButton, AppInputField)
│   │   │   └── layout/              # Layout helpers, spacing, breakpoints
│   │   ├── theme/                   # Design system (colors, typography, etc.)
│   │   │   ├── colors.dart
│   │   │   ├── typography.dart
│   │   │   ├── dimens.dart
│   │   │   └── theme.dart
│   │   ├── models/                  # Dart models (e.g., Persona, TestResult)
│   │   ├── services/                # Business logic & local helpers
│   │   ├── repositories/            # Handles API communication
│   │   ├── screens/                 # UI screens/views
│   │   ├── widgets/                 # Domain-specific reusable widgets
│   │   ├── utils/                   # General utilities and extensions
│   │   ├── config/                  # Environment configuration
│   │   └── main.dart                # App entry point
│   ├── assets/                      # Fonts, images, etc.
│   ├── test/                        # Frontend unit/widget tests
│   └── pubspec.yaml                 # Flutter dependencies
│
├── backend/                         # FastAPI backend
│   ├── app/
│   │   ├── api/
│   │   │   ├── routes/              # API endpoints (e.g., personas, simulations)
│   │   │   └── dependencies/        # Reusable API dependencies
│   │   ├── core/                    # App-level configuration and utilities
│   │   │   ├── config.py            # Env vars, settings
│   │   │   └── security.py          # Optional auth logic
│   │   ├── db/
│   │   │   ├── models/              # SQLAlchemy ORM models
│   │   │   ├── session.py           # DB session handling
│   │   │   └── base.py              # Declarative base & metadata
│   │   ├── schemas/                 # Pydantic models for validation
│   │   ├── services/                # Business logic (persona simulation, scoring, etc.)
│   │   ├── utils/                   # Common helpers (prompt builders, formatting)
│   │   └── main.py                  # FastAPI app entrypoint
│   ├── tests/                       # Backend unit and integration tests
│   ├── requirements.txt             # Python dependencies
│   └── fly.toml                     # Fly.io deployment config
│
├── .github/                         # CI/CD workflows
│   ├── workflows/                   # GitHub Actions for tests/deploy
│
├── docker-compose.yml               # Local dev container setup (if needed)
└── README.md                        # Project documentation
