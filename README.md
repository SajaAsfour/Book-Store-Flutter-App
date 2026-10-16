
# Book Store — Flutter Mobile Application

A cross-platform bookstore application built with **Flutter** and **Dart**, allowing users to discover books, browse bestsellers, search and filter the catalog, manage favorites, and interact with a shopping cart. The application integrates with a REST API for book data and account operations, with Firebase Authentication support for social sign-in.

**Repository:** [SajaAsfour/Book-Store-Flutter-App](https://github.com/SajaAsfour/Book-Store-Flutter-App)

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
- [API Integration](#api-integration)
- [Application Flow](#application-flow)
- [State Management](#state-management)
- [Testing](#testing)
- [Troubleshooting](#troubleshooting)
- [Future Improvements](#future-improvements)
- [Author](#author)

---

## Overview

Book Store is a mobile application designed to provide a convenient bookstore browsing and shopping experience.

The application combines a responsive Flutter interface with remote API integration, authentication flows, persistent local preferences, and structured state management. Its codebase separates application screens, business logic, data repositories, reusable widgets, and shared services.

This project demonstrates practical experience with:

- Flutter UI development
- REST API integration
- Authentication integration
- Asynchronous programming
- State management
- Mobile application architecture

## Features

### 1. Authentication and Account Management

- User registration and email/password login through the REST API.
- Google Sign-In integration using Firebase Authentication.
- Facebook Sign-In integration using Firebase Authentication.
- Forgot-password workflow.
- Verification-code and password-reset screens.
- Password-change screen.
- Local persistence of relevant session and user information.

> Social authentication requires the corresponding Firebase providers and platform configurations to be enabled.

### 2. Book Discovery and Browsing

- Home screen featuring best-selling books.
- Recommended-books section.
- Flash-sale section.
- Complete book catalog.
- Book details screen.
- Book cover images, descriptions, categories, prices, and discount information.
- Loading and error states for remote data operations.

### 3. Search, Filtering, and Sorting

- Search functionality for discovering books.
- Filter books by name and category.
- Filter by minimum and maximum price.
- Sort the catalog alphabetically by book name.
- Paginated book listings, displaying six books per page in the catalog grid.

### 4. Favorites

- Add books to or remove books from favorites.
- Display the current favorites list.
- Persist favorite selections locally using Shared Preferences.
- Separate locally stored favorites by user email.

**Note:** Favorites are stored locally on the device rather than through a dedicated server-side favorites endpoint.

### 5. Shopping Cart

- Add books to the cart through the REST API.
- Retrieve cart contents from the backend.
- Display cart items and totals.
- Increase or decrease item quantities.
- Remove items from the displayed cart.
- Recalculate item totals and the cart total when quantities change.

Cart operations use a combination of API requests and client-side state management. Backend persistence should be verified separately for each operation.

### 6. Checkout Interface

Available payment options include:

- Online payment
- Cash on delivery
- POS on delivery

Additional functionality:

- Add an order note.
- Navigate through the order confirmation interface.

> The repository includes checkout and confirmation screens. The presence of these screens alone does not confirm a completed payment gateway or server-side order-processing workflow.

### 7. Profile and Navigation

- Profile screen.
- Personal-data screen.
- Bottom navigation interface.
- Named application routes for organized navigation between features.
- Responsive layout support using Flutter ScreenUtil.

---

## Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform application UI |
| Dart | Application programming language |
| flutter_bloc | State management using Cubit and BlocBuilder |
| Dio | HTTP requests and REST API communication |
| Firebase Core | Firebase initialization |
| Firebase Authentication | Social authentication integration |
| Google Sign-In | Google account sign-in |
| Facebook Auth | Facebook account sign-in |
| Shared Preferences | Local persistence of preferences and selected user data |
| Flutter ScreenUtil | Screen adaptation and responsive sizing |
| Font Awesome Flutter | Additional icons |
| Flutter Native Splash | Native splash-screen configuration |

### Development Tools

- Git and GitHub
- Android Studio or Visual Studio Code
- Flutter SDK and Dart SDK
- Android Emulator or a physical Android device
- Xcode and an appropriate iOS development environment for iOS builds

---

## Architecture

The application follows a **feature-oriented architecture**, separating presentation, data access, and application-wide services.

### Presentation Layer

Contains screens, reusable widgets, and UI components. It renders application states and responds to user interactions.

### State Management Layer

Uses Cubit and Flutter Bloc to manage asynchronous operations and expose states such as loading, success, and error.

### Data Layer

Contains repositories responsible for retrieving book data, handling authentication requests, and interacting with cart and favorites functionality.

### Core Layer

Contains shared models, application routes, styling utilities, networking configuration, and local storage services.

### Architectural Benefits

- Clear separation of responsibilities.
- Reusable UI components and shared services.
- Easier maintenance and feature development.
- Centralized handling of API requests.
- Consistent UI updates through state management.
- Improved organization as the application grows.

---

## Project Structure

The following is a simplified overview of the repository structure:

```text
Book-Store-Flutter-App/
├── android/                 # Android platform configuration
├── ios/                     # iOS platform configuration
├── assets/
│   └── images/              # Application image assets
├── fonts/                   # Custom fonts
├── lib/
│   ├── core/
│   │   ├── app_routes/      # Named routes and route generation
│   │   ├── models/          # Shared data models
│   │   ├── services/
│   │   │   ├── local/       # Local storage helpers
│   │   │   └── networking/  # HTTP client configuration
│   │   └── utils/           # Shared utilities and styling
│   ├── features/
│   │   ├── all_book/        # Book catalog and retrieval
│   │   ├── book_details/    # Book details
│   │   ├── book_filter/     # Catalog filtering
│   │   ├── bottom_nav_bar/  # Main navigation
│   │   ├── code_verification/
│   │   ├── create_account/
│   │   ├── favorites/
│   │   ├── flash_sale/
│   │   ├── forget_password/
│   │   ├── home/
│   │   ├── login/
│   │   ├── my_cart/         # Cart and checkout screens
│   │   ├── password_change/
│   │   ├── profile/
│   │   ├── reset_password/
│   │   ├── search/
│   │   └── splash_screen/
│   ├── book_store.dart      # Root application widget
│   ├── firebase_options.dart
│   └── main.dart            # Application entry point
├── test/                    # Flutter tests
├── web/                     # Web platform files
├── windows/                 # Windows platform files
├── linux/                   # Linux platform files
├── macos/                   # macOS platform files
├── firebase.json            # FlutterFire configuration
├── pubspec.yaml             # Dependencies and asset configuration
└── README.md
```

Individual feature folders generally contain presentation components, state-management classes, and repositories where applicable.

---

## Prerequisites

Before running the application, make sure you have:

- Flutter SDK installed.
- Dart SDK compatible with the project.
- Git installed.
- Android Studio or Visual Studio Code.
- An Android emulator, physical Android device, or configured iOS development environment.
- Access to the configured REST API.
- A Firebase project configured for any authentication providers you intend to use.

The project specifies Dart SDK compatibility through the environment section of `pubspec.yaml`.

---

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/SajaAsfour/Book-Store-Flutter-App.git
```

### 2. Navigate to the Project

```bash
cd Book-Store-Flutter-App
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Check the Flutter Environment

```bash
flutter doctor
```

Resolve any missing platform tools or SDK requirements reported by Flutter Doctor.

### 5. Configure Firebase and the API

Follow the configuration instructions below before testing authentication or other backend-dependent features.

### 6. Run the Application

Connect a device or start an emulator, then execute:

```bash
flutter run
```

To list available devices:

```bash
flutter devices
```

---

## Configuration

### REST API

The application currently uses the following API base URL:

```text
https://codingarabic.online/api/
```

The URL is configured in:

```text
lib/core/services/networking/dio_factory.dart
```

The `DioFactory` class initializes the HTTP client, configures JSON headers and connection timeouts, and provides methods for GET and POST requests.

If the API becomes unavailable or the backend changes, update the configuration and ensure the repository endpoints match the backend API.

**Recommendation:** For a production-ready application, move environment-specific configuration into a dedicated configuration layer rather than hardcoding the base URL.

### Firebase

Firebase initialization is performed in `main.dart`, using the generated `firebase_options.dart` configuration.

The repository contains platform configuration for Android and iOS. Firebase options for web and desktop platforms are not configured in the current implementation.

Before testing social authentication:

1. Configure the Firebase project.
2. Register the appropriate Android and iOS applications.
3. Enable Google and Facebook authentication providers as needed.
4. Configure the platform-specific authentication settings.
5. Verify the required native configuration files and OAuth settings.
6. Test authentication on the intended platform.

**Security note:** Do not commit private service-account credentials, private keys, or other sensitive secrets to a public repository.

### Local Storage

Shared Preferences are initialized when the application starts. The application uses local storage for selected session information, user details, and favorites.

Local preferences are not a replacement for secure credential storage. Review the token-storage approach before using the application in a production environment.

---

## API Integration

Remote communication is centralized through `DioFactory`, while repositories encapsulate feature-specific requests.

The implementation includes requests for operations such as:

| Operation | Endpoint |
|---|---|
| User login | `POST /login` |
| Account registration | `POST /register` |
| Password recovery | `POST /forget-password` |
| Retrieve all books | `GET /products` |
| Retrieve bestsellers | `GET /products-bestseller` |
| Add an item to the cart | `POST /add-to-cart` |
| Retrieve the cart | `GET /cart` |

The exact request payloads and response formats are determined by the configured backend.

### Authentication

For API-based login, the application sends the user's credentials to the backend. On a successful response, it stores the returned token and configures the HTTP client to send it in the Authorization header as a Bearer token.

Firebase Authentication is used for Google and Facebook sign-in.

These authentication flows use different mechanisms. Backend authorization and token handling should be verified before assuming that Firebase-authenticated sessions are interchangeable with API-issued sessions.

### Book Data

Book responses are mapped to `ProductModel`, which represents fields including:

- Book ID and name.
- Description.
- Price and discounted price.
- Discount percentage.
- Stock information.
- Bestseller status.
- Image URL.
- Category.

This model allows the UI to work with structured Dart objects rather than raw JSON throughout the application.

---

## Application Flow

The main application flow can be summarized as follows:

1. **Initialization:** Flutter initializes Firebase, local storage, and the HTTP client.
2. **Navigation:** The root widget configures the application router and initial screen.
3. **Authentication:** Users can register, sign in, or access the password-recovery flow.
4. **Discovery:** The home screen loads bestseller and recommended-book content.
5. **Browsing:** Users can search, filter, sort, and open book details.
6. **Personalization:** Users can save books to their local favorites list.
7. **Cart:** Users can add books to the cart and manage displayed quantities.
8. **Checkout:** Users can select a payment option, add a note, and continue to the confirmation screen.

Some flows depend on the external API, Firebase configuration, or backend availability.

---

## State Management

The project uses the **Cubit pattern** from `flutter_bloc` to manage feature state.

Examples include:

- `LoginCubit`
- `CreateAccountCubit`
- `ForgetPasswordCubit`
- `CodeVerificationCubit`
- `ResetPasswordCubit`
- `FavoritesCubit`
- `CartCubit`
- `BestSellerCubit`

Cubit classes encapsulate operations and emit state changes. Widgets consume these states to display loading indicators, successful results, or error messages.

For example, the bestseller flow requests book data through a repository and exposes loading, success, and error states to the home screen.

---

## Testing

The repository includes a Flutter test directory and uses Flutter's testing dependencies.

### Run Tests

```bash
flutter test
```

### Run Static Analysis

```bash
flutter analyze
```

These commands help identify test failures, potential bugs, and code-quality issues.

The presence of a test directory does not guarantee complete test coverage. Authentication, API error handling, favorites persistence, cart calculations, and navigation should be tested explicitly before a production release.

---

## Troubleshooting

### Dependencies Fail to Resolve

Run:

```bash
flutter clean
flutter pub get
```

Check that your installed Flutter and Dart versions satisfy the SDK constraints in `pubspec.yaml`.

### Books Do Not Load

- Verify that the API base URL is correct.
- Check your internet connection.
- Confirm that the API is reachable and returning the expected JSON structure.
- Review the application logs for network or response-parsing errors.

### Authentication Fails

- Confirm the backend credentials and endpoint configuration.
- Check Firebase initialization.
- Verify the enabled authentication providers and OAuth settings.
- Confirm that the required Android or iOS configuration is present.

### Cart Operations Fail

- Check whether the API is reachable.
- Verify that the user session and Bearer token are valid.
- Confirm that the backend supports the requested cart operation.
- Review API responses and application logs.

### Platform Configuration Errors

The current Firebase options are configured for Android and iOS. Additional configuration is required before running Firebase-dependent functionality on unsupported platforms.

---

## Future Improvements

Potential improvements for a more production-ready release include:

- Add automated unit and widget tests for critical flows.
- Introduce environment-specific API configuration.
- Improve centralized error handling and network diagnostics.
- Review token persistence and session expiration handling.
- Synchronize cart quantity changes and removals with dedicated backend endpoints where supported.
- Complete and validate server-side order placement and payment integration.
- Improve loading, empty, and offline states.
- Add application screenshots and a demonstration video.
- Document API contracts and required Firebase configuration in greater detail.

These items are suggestions for further development, not claims that the features are already implemented.

---

## Author

**Saja Asfour**

Computer Engineering graduate interested in mobile application development, software engineering, and AI.

- **GitHub:** [@SajaAsfour](https://github.com/SajaAsfour)
- **Project Repository:** [Book-Store-Flutter-App](https://github.com/SajaAsfour/Book-Store-Flutter-App)

---

**Built with Flutter and Dart.**
