pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Basic

/*  Path Animation Example - Heart Rate Monitor Visualization
 *
 *  This example demonstrates Qt Quick's Path Animation capabilities by creating
 *  a heart rate monitor visualization. Key concepts demonstrated:
 *      1. Path Definition: Uses PathLine elements to create an EKG-like path
 *      2. Path Animation: Animates objects along the defined path
 *      3. Trailing Effect: Creates a visual trail using delayed animations
 *
 *  Reference: https://doc.qt.io/qt-6/qml-qtquick-pathanimation.html */

ApplicationWindow {
    id: root
    visible: true
    width: 800
    height: 600
    title: "Path Animation Example"
    color: "black"

    // Controls animation speed based on heart rate (beats per minute).
    property int pulse: 60
    property int speed: 3000 / (pulse / 60)

    Item {
        id: pathRoot
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width - heart.width
        height: 200

        /* Path Definition
         * Creates an EKG-like pattern using connected PathLine segments
         * The path is defined using relative positions to maintain
         * proportions when the window is resized. */
        Path {
            id: path
            startX: 0
            startY: pathRoot.height

            PathLine {
                x: pathRoot.width * 0.125
                y: pathRoot.height / 2
            }
            PathLine {
                x: pathRoot.width * 0.1875
                y: pathRoot.height / 4
            }
            PathLine {
                x: pathRoot.width * 0.25
                y: pathRoot.height * 3 / 4
            }
            PathLine {
                x: pathRoot.width * 0.3125
                y: pathRoot.height / 2
            }
            PathLine {
                x: pathRoot.width * 0.375
                y: pathRoot.height / 2
            }
            PathLine {
                x: pathRoot.width * 0.4375
                y: pathRoot.height / 4
            }
            PathLine {
                x: pathRoot.width * 0.5
                y: pathRoot.height * 3 / 4
            }
            PathLine {
                x: pathRoot.width * 0.5625
                y: pathRoot.height / 2
            }
            PathLine {
                x: pathRoot.width * (0.5 + 0.125)
                y: pathRoot.height / 2
            }
            PathLine {
                x: pathRoot.width * (0.5 + 0.1875)
                y: pathRoot.height / 4
            }
            PathLine {
                x: pathRoot.width * (0.5 + 0.25)
                y: pathRoot.height * 3 / 4
            }
            PathLine {
                x: pathRoot.width * (0.5 + 0.3125)
                y: pathRoot.height / 2
            }
            PathLine {
                x: pathRoot.width * (0.5 + 0.375)
                y: pathRoot.height / 2
            }
            PathLine {
                x: pathRoot.width * (0.5 + 0.4375)
                y: pathRoot.height / 4
            }
            PathLine {
                x: pathRoot.width * (0.5 + 0.5)
                y: pathRoot.height / 2
            }
        }

        /*  Leading Pulse Indicator
         *  Main animated element that travels along the path
         *  Acts as the reference point for trailing elements. */
        Rectangle {
            id: pulseLine
            width: 10
            height: 10
            radius: 5
            color: "red"

            PathAnimation {
                id: pathAnimation
                target: pulseLine
                path: path
                duration: root.speed
                loops: Animation.Infinite
                easing.type: Easing.Linear
                running: true
            }
        }

        /* Trailing Effect Implementation
         * Creates a series of delayed followers that create
         * a fading trail effect behind the main pulse.
         *
         * Each follower starts with a delay proportional to its index
         * and has decreasing opacity to create the fade effect */
        Repeater {
            id: rep
            model: 20

            Rectangle {
                id: shadowLine
                required property int index
                required property int modelData
                property var shadowPath: path
                property int delay: 20
                width: 10
                height: 10
                radius: 5
                color: "red"
                opacity: 1.0 - (index / rep.model)

                SequentialAnimation {
                    loops: Animation.Infinite
                    PauseAnimation {
                        duration: shadowLine.delay * shadowLine.index
                    }
                    PathAnimation {
                        target: shadowLine
                        path: shadowLine.shadowPath
                        duration: root.speed - shadowLine.delay * shadowLine.index
                        easing.type: Easing.Linear
                    }
                    running: true
                }
            }
        }

        /* Heart Visualization
         * Scales based on the Y position of the pulse line.
         * Creates a beating effect synchronized with the EKG animation. */
        Item {
            id: heartArea
            width: 100
            height: pathRoot.height
            anchors.left: pathRoot.right
            anchors.leftMargin: -heart.width * .5

            Image {
                id: heart
                anchors.centerIn: parent
                width: 100
                height: 100
                source: "heart.svg"

                Behavior on scale {
                    NumberAnimation {
                        duration: 20
                    }
                }
            }

            /* Heart Scale Animation
             * Continuously updates the heart scale based on the pulse
             * line's vertical position, creating a pulsing effect. */
            Timer {
                id: animationTimer
                interval: 16
                running: true
                repeat: true
                onTriggered: {
                    var heartScale = 1 + (pathRoot.height / 2 - pulseLine.y) / (pathRoot.height / 4);
                    heart.scale = Math.max(0.5, heartScale);
                }
            }
        }
    }
}
