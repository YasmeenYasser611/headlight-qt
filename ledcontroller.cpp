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
