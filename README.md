## 🍷 Wine Label Scanner

### Overview

**Wine Label Scanner** is a sleek Flutter app that allows users to upload images of wine labels and send them to a remote server for processing. With a modern dark-themed UI and robust upload handling, it's built for speed, clarity, and smooth UX.

### Screenshot

<img width="506" height="932" alt="image" src="https://github.com/user-attachments/assets/998ba9f5-0450-4e5a-81c3-db43b2e2e4cf" />


### ✨ Features

* 📷 Pick an image from camera or gallery
* 🌐 Configure the server URL in settings
* 🚀 Upload wine label to `/upload` endpoint
* 🧠 Real-time status feedback with animations
* 💾 Persistent server settings using `SharedPreferences`
* 🌑 Elegant Material 3 dark mode theme

---

### ⚙️ Technologies Used

* Flutter + Dart
* `image_picker`
* `http`
* `shared_preferences`
* Material Design 3

---

### 🛠 Getting Started

1. **Clone the repo**

   ```bash
   git clone https://github.com/yourusername/wine-label-scanner.git
   cd wine-label-scanner
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run
   ```

---

### 🔧 Configuration

To set the backend server:

1. Tap the ⚙️ Settings icon in the app.
2. Enter your server’s base URL (e.g., `http://192.168.1.42:5000`).
3. Save it — the app will append `/upload` automatically.

---

### 🧪 Development Notes

* Upload timeout is set to 60 seconds.
* Filename is dynamically generated based on timestamp.
* All user feedback is animated and localized in the app for better UX.

---

### 📂 File Structure Highlights

* `main.dart`: Entry point with theme, routing, and UI.
* `ImageUploader`: Main screen to pick/upload images.
* `SettingsScreen`: Configurable server endpoint with validation.

---

