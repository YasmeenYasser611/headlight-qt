# Headlight Commander - Qt Quick Application

## Overview

**Headlight Commander** is a Qt Quick (QML) application designed to control a car's front lights. The application provides a user-friendly interface with LED status indicators, control buttons, and additional features such as displaying the system's CPU temperature.

## Features

- **Home Page**
  - 📅 Displays the current time and date.
  - 🏷️ Shows a project title and user name.
  - 🔄 Provides navigation to the control page.
- **Control Page**
  - 🚦 Displays the current headlight status (**ON/OFF**).
  - 🔘 Provides buttons to turn the headlights **ON** or **OFF**.
  - 💡 Shows visual LED indicators reflecting the headlight status.
  - 🌡️ Retrieves and displays the system's CPU temperature.
  - ⬅️ Allows navigation back to the home page.

## Technologies Used

- **Qt Quick (QML)** for UI development
- **Qt Quick Controls** for interactive components
- **Qt Quick Layouts** for structured design
- **JavaScript (within QML)** for handling logic and events
- **C++ (Qt)** for backend logic and hardware communication

## Installation & Running the Project

### Prerequisites

- Install **Qt Creator** and Qt development tools.
- Ensure **Qt Quick** and **Qt Quick Controls** modules are installed.
- If running on an embedded system, ensure necessary device drivers are available.

### Steps to Run

1. Clone the repository or copy the project files.
2. Open the project in **Qt Creator**.
3. Build and run the project using the appropriate Qt version.
4. The application will launch in a window with interactive UI components.

## File Structure

```
/HeadlightCommander
│── build/                 # Build directory
│── CMakeLists.txt         # CMake configuration file
│── CMakeLists.txt.user    # CMake user-specific file
│── ledcontroller.cpp      # C++ source file for LED control logic
│── ledcontroller.h        # C++ header file for LED controller class
│── main.cpp               # Main C++ entry point
│── Main.qml               # Main QML file containing UI logic
│── Main.qml.autosave      # Autosaved version of Main.qml
│── README.md              # Project documentation (this file)
│── .gitignore             # Git ignore file
```


## C++ Class: `LedController`

### Purpose

The `LedController` class is responsible for handling LED operations and retrieving system information.

### Implementation

#### Header File: `ledcontroller.h`

```cpp
#ifndef LEDCONTROLLER_H
#define LEDCONTROLLER_H

#include <QObject>

    class LedController : public QObject {
    Q_OBJECT
public:
    explicit LedController(QObject *parent = nullptr);

public slots:
    void handleButtonClick(int buttonId);  // Slot to handle QML button clicks
    Q_INVOKABLE QString getCpuTemperature();  // Function to get CPU temperature
};

#endif
```

#### Source File: `ledcontroller.cpp`

```cpp
#include "ledcontroller.h"
#include <QDebug>
#include <X11/XKBlib.h>  // For controlling Caps Lock LED in Linux
#include <fstream>  // For reading files
#include <QString>  // For returning temperature as a QString

LedController::LedController(QObject *parent) : QObject(parent) {}

void LedController::handleButtonClick(int buttonId) {
    qDebug() << "Button Clicked:" << buttonId;

    Display *display = XOpenDisplay(nullptr);
    if (!display) {
        qDebug() << "Failed to open X display";
        return;
    }

    // Get the current state of the keyboard LEDs
    XKeyboardState state;
    XGetKeyboardControl(display, &state);

    // Set the new LED state based on button input
    if (buttonId == 1) {
        // Turn on the LED (Caps Lock on)
        XkbLockModifiers(display, XkbUseCoreKbd, LockMask, LockMask);
        qDebug() << "Turning Caps Lock LED ON";
    } else if (buttonId == 2) {
        // Turn off the LED (Caps Lock off)
        XkbLockModifiers(display, XkbUseCoreKbd, LockMask, 0);
        qDebug() << "Turning Caps Lock LED OFF";
    } else {
        qDebug() << "Invalid button ID. Use 1 to turn on or 2 to turn off.";
    }

    XCloseDisplay(display);
}

QString LedController::getCpuTemperature() {
    // Read CPU temperature
    std::ifstream tempFile("/sys/class/thermal/thermal_zone0/temp");
    if (tempFile.is_open()) {
        int temp;
        tempFile >> temp;  // Read the temperature in millidegrees Celsius
        tempFile.close();

        // Convert the temperature to degrees Celsius and return as a QString
        double tempCelsius = temp / 1000.0;
        return QString::number(tempCelsius, 'f', 2) + " °C";  // Format to 2 decimal places
    } else {
        return "Failed to read CPU temperature";
    }
}

```

## Usage

1. Open the application and navigate to the **Control Page**.
2. Use the buttons to switch the headlights **ON** or **OFF**.
3. Observe the real-time LED status updates.
4. Click the **Get CPU Temperature** button to check the system temperature.
5. Return to the **Home Page** using the corresponding button.

## Future Improvements

- ⚙️ Implement real hardware integration for controlling actual headlights with rpi.
- 📈 Add more features like automatic light adjustment based on environment conditions.
- 🎨 Enhance the UI with animations and smoother transitions.


## APP UI

![](1.png "")

![](2.png "")

![](3.png "")
