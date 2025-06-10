# Arhibu: Roommate Finder Mobile App

## Overview
Arhibu is a mobile application built with Flutter, designed to help users find compatible roommates. It provides a comprehensive account setup process, personalized profile management, chat functionality for communication, and robust filtering options to find ideal living arrangements.

## Features
-   **Account Setup:** A multi-step form to collect detailed user information, including personal details, location, lifestyle preferences, and room preferences.
-   **Profile Management:** Users can customize their profile, upload a profile picture, and view their setup information.
-   **Roommate Matching:** (Implied by filtering) Users can filter potential roommates or listings based on various criteria.
-   **Chat System:** Integrated chat functionality for users to communicate with potential roommates.
-   **Dynamic UI:** Responsive and intuitive user interface designed for a seamless mobile experience.

## Technologies Used
-   **Flutter:** UI Toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
-   **Dart:** Programming language for Flutter.
-   **flutter_bloc:** State management solution for managing the application's state, including profile setup and listing data.
-   **image_picker:** For handling image uploads from the device gallery.
-   **http:** For making API requests to the backend (e.g., profile submission).
-   **flutter_svg:** For rendering SVG images in the application.

## Getting Started

### Prerequisites
-   [Flutter SDK](https://flutter.dev/docs/get-started/install) installed.
-   An IDE like Android Studio, VS Code, or Cursor with Flutter and Dart plugins.

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Gebeyaa/Roomate_Finder_mobile.git
    cd Roomate_Finder_mobile
    ```

2.  **Get dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the application:**
    ```bash
    flutter run
    ```
    (Ensure you have a device or emulator connected, or select a target platform.)

### Project Structure
-   `lib/`: Contains the main application source code.
    -   `features/`: Organized by feature (e.g., `account_setup`, `home`, `chat`, `profile`, `filter`).
        -   `presentation/`: UI components (screens, widgets), BLoCs/Cubits.
        -   `domain/`: Business logic (entities, use cases, repositories).
        -   `data/`: Data sources and models.
-   `images/`: Stores application assets like SVG logos and placeholder images.

## API Endpoint
The application interacts with the following backend API for user profile management:
-   `https://arhibu-be.onrender.com/api/user/profile`

## Contributing
(Optional section for contribution guidelines)

## License
(Optional section for license information)
