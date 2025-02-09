# Flutter Product Listing App

## Overview
This Flutter application allows users to browse and manage a list of products fetched from an external API. Users can view product details, mark products as favorites, manage their shopping cart, and access their favorite products on a separate screen.

## Features
- **Product Listing Screen**: Displays a responsive grid/list of products with title, image, price, and rate.
- **Product Details Screen**: Shows detailed information about the selected product.
- **Favorites Feature**: Users can mark products as favorites, which are stored locally using Hive.
- **Cart Screen**: Users can add products to their cart, with automatic price calculations for a smooth checkout experience.
- **Responsive Layout**: Adapts to mobile, tablet, and desktop screens using Media Query and Layout Builder.
- **Performance Optimization**: Utilizes efficient state management with Provider.
- **Dark Mode**: Optional dark mode implementation.

## Technical Requirements
- Flutter framework (latest stable version).
- State Management: Provider.
- Local Storage: Hive.
- API Integration: REST API with HTTP package.
- Responsive Design for mobile, tablet, and desktop.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/SayedMamdouh94/store-task-app.git
2. Navigate to the project directory:
  cd store-task-app
3. Install dependencies:
  flutter pub get
## Running the App
- To run the application, use the following command:
  flutter run
