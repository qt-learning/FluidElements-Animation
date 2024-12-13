import QtQuick
import QtQuick.Controls.Basic

ApplicationWindow {
    id: root
    width: 800
    height: 600
    title: "Property Animation Example"
    visible: true

    property int currentColorIndex: 1

    Rectangle {
        id: animatedRectangle
        width: 100
        height: 100
        color: "red"

        x: 0
        y: 0

        /* Behavior animations automatically animate property changes
         * when the property value is modified. In this case, color
         * transitions will be smoothly animated over 1 second
         * Reference: https://doc.qt.io/qt-6/qml-qtquick-behavior.html */
        Behavior on color {
            ColorAnimation {
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }
    }

    // Single property animation that continuously rotates the rectangle
    // Reference: https://doc.qt.io/qt-6/qml-qtquick-propertyanimation.html
    PropertyAnimation {
        target: animatedRectangle
        property: "rotation"
        from: 0
        to: 360
        duration: 2000
        loops: Animation.Infinite
        easing.type: Easing.InOutQuad
        running: true
    }

    /* Sequential animation runs child animations one after another:
     *  1. Scale up from 1.0 to 1.5
     *  2. Pause for 500ms
     *  3. Scale down from 1.5 to 1.0
     * Reference: https://doc.qt.io/qt-6/qml-qtquick-sequentialanimation.html */
    SequentialAnimation {
        loops: Animation.Infinite
        PropertyAnimation {
            target: animatedRectangle
            property: "scale"
            from: 1.0
            to: 1.5
            duration: 1000
        }
        PauseAnimation {
            duration: 500
        }
        PropertyAnimation {
            target: animatedRectangle
            property: "scale"
            from: 1.5
            to: 1.0
            duration: 1000
        }
        running: true
    }

    /* Parallel animation runs multiple animations simultaneously
     * Creates a diagonal movement by animating x and y coordinates together
     * Reference: https://doc.qt.io/qt-6/qml-qtquick-parallelanimation.html */
    ParallelAnimation {
        loops: Animation.Infinite
        NumberAnimation {
            target: animatedRectangle
            property: "x"
            from: 0
            to: root.width - animatedRectangle.width
            duration: 2000
        }
        NumberAnimation {
            target: animatedRectangle
            property: "y"
            from: 0
            to: root.height - animatedRectangle.height
            duration: 2000
        }
        running: true
    }

    // Timer-based color toggle between red and blue
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            root.currentColorIndex = root.currentColorIndex === 1 ? 2 : 1;
            animatedRectangle.color = root.currentColorIndex === 1 ? "red" : "blue";
        }
    }
}
