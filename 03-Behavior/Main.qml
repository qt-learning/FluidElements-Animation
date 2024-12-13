import QtQuick
import QtQuick.Controls.Basic

/* This example demonstrates the use of Behavior and SpringAnimation in QML.
 *
 *  Behavior: An animation type that automatically animates property changes.
 *  It ensures smooth transitions whenever the specified property is modified.
 *  Reference: https://doc.qt.io/qt-6/qml-qtquick-behavior.html
 *
 *  SpringAnimation: Simulates spring-like motion with configurable properties such as:
 *      - spring: Controls the stiffness (higher values = faster oscillation)
 *      - damping: Controls how quickly the oscillation settles (higher = less bounce)
 *  Reference: https://doc.qt.io/qt-6/qml-qtquick-springanimation.html */

ApplicationWindow {
    id: root
    visible: true
    width: 800
    height: 600
    title: "Behavior Animation Example"

    Rectangle {
        id: sky
        width: root.width
        height: 20
        color: "lightblue"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
    }

    Rectangle {
        id: trampoline
        width: root.width
        height: 100
        color: "green"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
    }

    Rectangle {
        id: ball
        width: 50
        height: width
        radius: width / 2
        color: "red"
        anchors.horizontalCenter: parent.horizontalCenter

        y: trampoline.y - height

        /* The Behavior automatically animates any changes to the ball's y position
         * using a spring effect, creating a realistic bouncing motion without
         * requiring explicit animation setup for each position change */
        Behavior on y {
            SpringAnimation {
                id: behaviorAnimation
                spring: 4       // Moderate spring stiffness for natural bounce
                damping: 0.2    // Low damping allows multiple bounces before settling
            }
        }
    }

    Label {
        anchors.centerIn: parent
        text: "Click to Bounce"
        font {
            pixelSize: 24
            bold: true
        }
        visible: !behaviorAnimation.running
    }

    MouseArea {
        anchors.fill: parent
        // Toggle between top and bottom positions
        onClicked: {
            ball.y = (ball.y === sky.height) ? trampoline.y - ball.height : sky.height;
        }
    }
}
