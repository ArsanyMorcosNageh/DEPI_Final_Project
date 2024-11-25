# Flutter E-Commerce Application

This project is a *modern e-commerce application* built using Flutter, providing seamless user interaction with a clean and customizable UI. The application includes essential features like authentication, product browsing, shopping cart, payment integration, and user profile management.

---

## Demo

🎥 *Demo Video*:  
Click below to watch a complete walkthrough of the application in action:  
[![Watch Demo](https://github.com/Gaser666/depi_project_2/blob/main/documentation/DemoGIF.gif)](#) 

---

## Features

- *Authentication*: User registration and login powered by Firebase.
- *Product Management*: Browsing, searching, and detailed product viewing.
- *Shopping Cart*: Add, remove, and manage products in a cart.
- *Payment Integration*: Streamlined checkout and payment process.
- *User Profile*: Personalized user data and preferences.
- *Custom Widgets*: Reusable and adaptable components for easy scalability.

---

## Directory Structure

### *lib/*
This folder contains all the source code for the application.

#### *1. main.dart*
The entry point of the application, initializing essential services and routing.

#### *2. screens/*
Houses all UI screens of the app:
- *auth/*:
  - firebase_options.dart: Firebase configuration.
  - login.dart: User login screen.
  - reg.dart: User registration screen.
- *pages/*:
  - home_page.dart: Main landing page of the application.
  - onboard.dart: Onboarding screens for first-time users.
  - payment_page.dart: Payment and checkout screen.
  - profile_page.dart: User profile page.
  - search_page.dart: Product search functionality.
  - shopping_cart.dart: Shopping cart UI.
- *Widgets*:
  - Modular and reusable components such as:
    - custom_app_bar.dart
    - product_card.dart
    - skeleton_product_card.dart

#### *3. services/*
- Contains all backend-related code and API integration:
  - services.dart: Handles communication with external services (e.g., Firebase).

---

## Getting Started

### *1. Prerequisites*
Ensure you have the following installed:
- Flutter SDK
- Dart SDK
- A code editor (e.g., VS Code, Android Studio)
- Firebase account and configuration.

### *2. Installation*
1. Clone this repository:
   bash
   git clone https://github.com/your-repo.git
   cd your-project-folder
   
2. Install dependencies:
   bash
   flutter pub get
   
3. Run the application:
   bash
   flutter run
   

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.

---

## Project Resources

- 📊 *Marketing Presentation*: [View here](https://www.canva.com/design/DAGWj0-bPf0/LGfddUw0sJsnFsovSMfBsg/view?utm_content=DAGWj0-bPf0&utm_campaign=designshare&utm_medium=link&utm_source=editor) 
- 🎓 *Project Presentation*: [view here](https://www.canva.com/design/DAGWkKQAAW4/iAVDu01gFvzRShh8KOJerw/view?utm_content=DAGWkKQAAW4&utm_campaign=designshare&utm_medium=link&utm_source=editor)
- 📋 *Framework Documentation: [Access here](#) *(Insert link to framework document)  

---

## Customization

- *Themes*: Modify the ThemeData in main.dart to customize the app’s appearance.
- *Assets*: Update the contents of the assets/ folder for images and icons.

---

## Contributions

Contributions, issues, and feature requests are welcome!
