import QtQuick
import QtQuick.Controls.Basic

/*  This example demonstrates QML States and Transitions for fluid UI animations.
 *  States define property configurations for QML elements, while Transitions
 *  define how those properties animate when state changes occur.
 *
 *  Reference: https://doc.qt.io/qt-6/qml-qtquick-state.html
 *  Reference: https://doc.qt.io/qt-6/qml-qtquick-transition.html
 *  Reference: https://doc.qt.io/qt-6/qml-qtquick-propertychanges.html */
ApplicationWindow {
    id: root
    visible: true
    width: 800
    height: 600
    title: "States and Transitions Example"

    Item {
        anchors {
            fill: parent
            margins: 64
        }

        Button {
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
            }
            text: "Toggle State"
            onClicked: {
                rect.state = rect.state === "Rectangle" ? "Circle" : "Rectangle";
            }
        }

        Rectangle {
            id: rect

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            width: 400
            height: width / 2
            radius: width * 0.05
            color: "green"

            state: "Rectangle"

            /*
             *  States define different visual configurations of the rectangle:
             *      - Rectangle state: wide green rectangle with small corner radius
             *      - Circle state: perfect circle shape with red color
             *  PropertyChanges is used to define the property values or bindings in each state.
             */
            states: [
                State {
                    name: "Rectangle"
                    // Aspect ratio 2:1 for rectangle state
                    PropertyChanges {
                        rect.width: 400
                        rect.height: rect.width / 2
                        rect.radius: rect.width * 0.05
                        rect.color: "green"
                    }
                },
                State {
                    name: "Circle"
                    // 1:1 aspect ratio with radius = height/2 creates perfect circle
                    PropertyChanges {
                        rect.width: 200
                        rect.height: rect.width
                        rect.radius: rect.height / 2
                        rect.color: "red"
                    }
                }
            ]

            /*
             *  Transitions define how properties animate between states.
             *  Each transition can have multiple animations for different properties.
             *  Different easing curves are used for visual variety:
             *      - OutBounce: Bouncy effect when transitioning to circle
             *      - OutExpo: Sharp start with smooth deceleration when returning to rectangle
             */
            transitions: [
                Transition {
                    from: "Rectangle"
                    to: "Circle"
                    NumberAnimation {
                        properties: "radius,width"
                        duration: 2000
                        easing.type: Easing.OutBounce
                    }
                    ColorAnimation {
                        properties: "color"
                        duration: 2000
                        easing.type: Easing.OutBounce
                    }
                },
                Transition {
                    from: "Circle"
                    to: "Rectangle"
                    NumberAnimation {
                        properties: "radius,width"
                        duration: 2000
                        easing.type: Easing.OutExpo
                    }
                    ColorAnimation {
                        properties: "color"
                        duration: 2000
                        easing.type: Easing.OutExpo
                    }
                }
            ]
        }
    }
}
