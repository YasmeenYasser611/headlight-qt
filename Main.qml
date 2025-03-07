import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs

Window {
    width: 620
    height: 480
    visible: true
    title: qsTr("dashboard")
    color: "black"
    // Define a custom signal
    signal buttonClicked(int buttonId)

    StackView {
        id: stackview1
        anchors.fill: parent
        initialItem: homepage
    }

    Page {
          id: homepage
          Rectangle {
              anchors.fill: parent
              anchors.bottomMargin: 15

              Image {
                  id: background1
                  source: "file:background3.png"
                  anchors.fill: parent
                  fillMode: Image.PreserveAspectCrop
                  visible: true
              }

              Image {
                  id: itiLogo
                  width: 150
                  height: 275
                  source: "file:iti2.png"
                  fillMode: Image.PreserveAspectFit
                  anchors.left: parent.left
                  anchors.top: parent.top
                  clip: true
              }

              Image {
                  id: eslogo
                  width: 200
                  height: 150
                  //source:"file:ES.jpeg"
                  source:"file:es2.png"
                  fillMode: Image.PreserveAspectFit
                  anchors.right: parent.right
                  anchors.top: parent.top
                  visible: true
              }


              // Display date and time at the top center
              GridLayout {
                  anchors.top: parent.top
                  anchors.horizontalCenter: parent.horizontalCenter
                  columns: 1
                  rowSpacing: 30
                  anchors.topMargin: 250

                  Text {
                      id: timeDisplay
                      font.bold: true
                      font.pointSize: 40
                      color: "white"
                      font.family: "Oswald"
                      text: Qt.formatDateTime(new Date(), "  hh:mm:ss ap")
                  }

                  Text {
                      id: dateDisplay
                      font.bold: true
                      font.pointSize: 20
                      color: "yellow"
                      font.family: "Oswald"
                      text: Qt.formatDateTime(new Date(), "dddd, MMMM d yyyy")
                  }

                  Text {
                      id: txt2
                      text: qsTr("Headlight Commander")
                      font.bold: true
                      font.pointSize: 35
                      style: Text.Outline // Creates a text outline
                      styleColor: "darkblue" // Outline color
                      color: "cyan" // Main text color
                      font.family: "Montserrat"
                      anchors.horizontalCenter: parent.horizontalCenter
                  }

                  Timer {
                      interval: 1000
                      running: true
                      repeat: true
                      onTriggered: {
                          timeDisplay.text = Qt.formatDateTime(new Date(), "hh:mm:ss ap")
                          dateDisplay.text = Qt.formatDateTime(new Date(), "dddd, MMMM d yyyy")
                      }
                  }
              }

              // Display names and button at the bottom center
              Column {
                  anchors.bottom: parent.bottom
                  anchors.horizontalCenter: parent.horizontalCenter
                  spacing: 20
                  anchors.bottomMargin: 50 // Adjust margin for better spacing

                  Text {
                      id: txt1
                      text: qsTr("Yasmeen Yasser mohamed")
                      font.bold: true
                      font.pointSize: 30
                      style: Text.Outline // Creates a text outline
                      styleColor: "darkblue" // Outline color
                      color: "cyan" // Main text color
                      font.family: "Roboto"
                      anchors.horizontalCenter: parent.horizontalCenter
                  }

                  Button {
                      anchors.horizontalCenter: parent.horizontalCenter
                      font.bold: true
                      font.pointSize: 16
                      contentItem: Text {
                          text: "Control Page"
                          color: "white"
                          font.bold: true
                          font.pointSize: 18
                      }
                      background: Rectangle {
                          color: "darkblue"
                          radius: 10
                      }
                      onClicked: {
                          stackview1.push(settingPageComponent.createObject(stackview1))
                      }
                  }
              }
          }
      }

    Component {
        id: settingPageComponent
        Page {
            id: settingpage
            property string lightStatus: "OFF" // Default value
            Rectangle {
                anchors.fill: parent
                anchors.bottomMargin: 15
                color: "#222" // Dark background for better contrast

                // Background Image - Always Fit the Screen
                Image {
                    id: background2
                    source: "file:back2.png"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    visible: true
                }
                Image {
                    id: itiLogo
                    width: 150
                    height: 150
                    source: "file:iti.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.left: parent.left
                    anchors.top: parent.top
                    clip: true
                }


                Image {
                    id: eslogo
                    width: 200
                    height: 150
                    //source:"file:ES.jpeg"
                    source:"file:es2.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.right: parent.right
                    anchors.top: parent.top
                    visible: true
                }



                GridLayout {
                    anchors.centerIn: parent
                    columns: 1
                    rowSpacing: 30
                    width: parent.width * 0.9  // Responsive width
                    height: parent.height * 0.9  // Responsive height
                    // Colorful Text for Status
                    Text {
                        id: ledstatusId
                        text: "Current Lights Status: " + lightStatus
                        font.bold: true
                        font.pointSize: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        style: Text.Outline // Creates a text outline
                        styleColor: "black" // Outline color
                        color: "yellow" // Main text color
                    }

                    // Headlights Icons
                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 30
                        Image {
                            id: on
                            source:"file:on.png"
                            width: 100
                            height: 100
                            fillMode: Image.PreserveAspectFit
                            visible: false
                        }
                        Image {
                            id: on2
                            source:"file:on.png"
                            width: 100
                            height: 100
                            fillMode: Image.PreserveAspectFit
                            visible: false
                        }
                        Image {
                            id: off
                            source:"file:off.svg"
                            width: 100
                            height: 100
                            fillMode: Image.PreserveAspectFit
                            visible: true
                        }
                        Image {
                            id: off2
                            source:"file:off.svg"
                            width: 100
                            height: 100
                            fillMode: Image.PreserveAspectFit
                            visible: true
                        }

                        Rectangle {
                            width: 20
                            height: 20
                            radius: 10
                            color: lightStatus === "ON" ? "green" : "red"  // Dynamic color change based on status
                            //anchors.left: ledstatusId.right
                            //anchors.leftMargin: 10
                        }


                    }



                    // Buttons for LED Control
                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 30

                        Button {
                            text: "Turn On"
                            font.pointSize: 16
                            background: Rectangle {
                                color: "green"
                                radius: 15
                                border.color: "darkgreen"  // Add subtle border
                                border.width: 2
                                anchors.margins: 5  // Margin around the button
                            }
                            onClicked: {
                                ledController.handleButtonClick(1)
                                lightStatus = "ON"
                                off.visible=false
                                off2.visible=false
                                on.visible=true
                                on2.visible=true


                            }
                        }

                        Button {
                            text: "Turn Off"
                            font.pointSize: 16
                            background: Rectangle {
                                color: "red"
                                radius: 15
                                border.color: "darkred"  // Add subtle border
                                border.width: 2
                                anchors.margins: 5  // Margin around the button
                            }
                            onClicked: {
                                ledController.handleButtonClick(2)
                                lightStatus = "OFF"
                                on.visible=false
                                on2.visible=false
                                off.visible=true
                                off2.visible=true
                            }
                        }
                    }

                    Text {
                                   id: tempDisplay
                                   font.bold: true
                                   font.pointSize: 20
                                   width: 100
                                   height: 100
                                   anchors.horizontalCenter: parent.horizontalCenter
                                   anchors.topMargin: 20
                                   style: Text.Outline // Creates a text outline
                                   styleColor: "black" // Outline color
                                   color: "yellow" // Main text color
                                   visible: false
                               }
                    Button {
                        //text: "Get CPU Temperature"
                        font.bold: true
                        font.pointSize: 18
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 20
                        background: Rectangle {
                            color: "cyan"
                            radius: 10
                        }
                        // Set the text color to white
                        contentItem: Text {
                            text: "Get CPU Temperature"
                            color: "black"
                            font.bold: true
                            font.pointSize: 18
                        }
                        onClicked: {
                            tempDisplay.visible = true
                            var temp = ledController.getCpuTemperature()
                            tempDisplay.text = "CPU Temp: " + temp
                        }
                    }

                    // Return to Home Button
                    Button {
                        font.bold: true
                        font.pointSize: 18
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 20
                        // Set the text color to white
                        contentItem: Text {
                            text: "Home Page"
                            color: "black"
                            font.bold: true
                            font.pointSize: 18
                        }
                        background: Rectangle {
                            color: "cyan"
                            radius: 10
                        }
                        onClicked: {
                            stackview1.pop()
                        }
                    }
                }
            }
        }


    }
    PageIndicator {
        id: page1ind
        count: stackview1.depth
        currentIndex: stackview1.depth - 1
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

