# PlatziStore

## Overview

PlatziStore is an iOS application built with Swift and SwiftUI. The app is designed to showcase the use of clean architecture principles, including MVVM (Model-View-ViewModel) architecture, networking, and image handling. This project demonstrates the core skills of Swift, SwiftUI, and clean architecture, along with additional functionalities such as product search, filtering, and image caching.

## Features

- Retrieve and display product information and associated images from fakeapi.platzi.com.
- Detail view for each product with more information.
- Filters for product categories, price and name.
- Image caching for optimized performance.
- Support for both Light and Dark Mode.

## Project Structure

This project follows clean architecture principles with a clear separation of concerns:

1. **Entities**: Core data models.
   - `Product.swift`
   - `Category.swift`

2. **Use Cases**: Encapsulate business logic.
   - `FetchProductsUseCase.swift`
   - `FetchSingleProductUseCase.swift`
   - `FetchCategoriesUseCase.swift`
   - `DefaultUseCases.swift`

3. **Repositories**: Abstract data access.
   - `ProductsRepository.swift`
   - `CategoriesRepository.swift`
   - `DefaultRepositories.swift`

4. **Data Sources**: Handle network calls.
   - `RemoteDataSource.swift`
   - `DefaultRemoteDataSource.swift`

5. **ViewModel**: Manages the state and interacts with UseCases.
   - `ProductsViewModel.swift`

6. **Views**: Display data and bind to the ViewModel.
   - `CategoryPicker.swift`
   - `ContentView.swift`
   - `ErrorMessageView.swift`
   - `FiltersView.swift`
   - `NoProductsView.swift`
   - `PriceRangeSlider.swift`
   - `ProductCellView.swift`
   - `ProductDetailView.swift`
   - `ProductsGridView.swift`
   - `ProductsListView.swift`

7. **Helpers**: Utility classes for network error handling and image caching.
   - `NetworkError.swift`
   - `ImageCacheManager.swift`
   - `ImageLoader.swift`

## Technical Details

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Networking**: URLSession
- **Architecture**: MVVM with clean architecture principles
- **Testing**: XCTest

### How It Works

- The **ViewModel** interacts with **UseCases** to fetch data and update the **View**.
- **UseCases** interact with **Repositories**, which in turn interact with **DataSources** to fetch the data from the network.
- **Views** display data and bind to the **ViewModel** to reflect changes in the UI.

### Image Caching

The app implements image caching to improve performance and user experience. Cached images are stored and retrieved using `ImageCacheManager.swift`.

### Light and Dark Mode Support

The app supports both Light and Dark Mode to provide an optimal user experience in different lighting conditions.

## Getting Started

1. Clone the repository.
2. Open the project in Xcode.
3. Build and run the project on the simulator or a physical device.

## External Libraries

No external libraries were used in this project. Networking is handled using `URLSession`, and image caching is implemented with custom logic.

## Conclusion

This project demonstrates the application of clean architecture principles in iOS development, focusing on maintainability, testability, and scalability. The PlatziStore app provides a user-friendly interface for searching and viewing products, with additional functionalities like filtering and image caching to enhance the user experience.
