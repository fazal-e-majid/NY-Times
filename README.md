# NY Times

Leveraged Swift and SwiftUI for developing this project.

### Technologies used

* Swift
* SwiftUI
* MVVM
* Combine
* TDD (Unit tests using XCTest)

---

### Requirements

To build and run this project:

* **Xcode 16.3+**
* **iOS 18.4+**
* Third Party Dependency: **SDWebImageSwiftUI**  -> [github](https://github.com/SDWebImage/SDWebImageSwiftUI)
* **ApiKey** already added


---

### How to run

* **Clone the repository**
* **Open the project:** `NY Times.xcodeproj`
* **Build and Run:**
* Select your target device or simulator from the scheme dropdown in Xcode.
* Press `⌘ + R` to build and run the application.

---

### Running Tests

This project uses a **Test Plan** to manage and run tests.

* **Open the Test Plan:** Navigate to the `TestPlan.xctestplan` and run tests.
* **Execute Tests:** To run all tests, you can also press `⌘ + U`.
* To run a specific test class or method, click the diamond icon next to it in the code editor or the Test Navigator.

---

### Features

The Application consists of two main views.
1. **Articles List:** This is where we are hitting api request to fetch all the articles.
2. **Detail View:** The user can click on the article which will open up the detail screen where article's detail is displayed using `webview`. 

The Application is scalable and maintainable. 


-----
