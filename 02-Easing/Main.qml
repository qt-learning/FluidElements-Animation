import QtQuick
import QtQuick.Controls.Basic

/*   This example demonstrates different easing curves available in Qt Quick animations.
 *
 *   Easing curves modify the interpolation of property animations to create more natural
 *   and appealing motion effects. Some of the  predefined curves can be categorized under:
 *      - Linear: No easing (constant velocity)
 *      - In/Out/InOut: Acceleration, deceleration, or both
 *      - Elastic: Oscillating effects with spring-like motion
 *      - Bounce: Simulates bouncing behavior
 *   You can see all the available easing types in the documentation.
 *   Reference: https://doc.qt.io/qt-6/qml-qtquick-propertyanimation.html#easing.type-prop */

ApplicationWindow {
    id: rootWindow
    width: 640
    height: 480
    title: "Easing Types Example"
    visible: true

    Column {
        spacing: 20
        anchors.fill: parent

        Rectangle {
            id: inOut
            width: 100
            height: 50

            color: "slategray"

            PropertyAnimation {
                /* InOutQuad: Acceleration followed by deceleration
                 * Ideal for natural bi-directional movements like sliding panels
                 * The curve is smooth at both ends, providing gentle starts and stops */
                target: inOut
                property: "x"
                from: 0
                to: rootWindow.width - inOut.width
                running: true
                easing.type: Easing.InOutQuad
                loops: Animation.Infinite
                duration: 4000
            }

            Text {
                text: "InOutQuad"
                anchors.centerIn: parent
            }
        }

        Rectangle {
            id: outBounce
            width: 100
            height: 50
            color: "honeydew"

            PropertyAnimation {
                /* OutBounce: Creates a bouncing effect at the end of the animation
                 * Perfect for emphasizing arrivals or dropping objects
                 * The bounce intensity decreases naturally, simulating energy loss */
                target: outBounce
                property: "x"
                from: 0
                to: rootWindow.width - outBounce.width
                running: true
                easing.type: Easing.OutBounce
                duration: 4000
                loops: Animation.Infinite
            }

            Text {
                text: "OutBounce"
                anchors.centerIn: parent
            }
        }

        Rectangle {
            id: inElastic
            width: 100
            height: 50
            color: "darkorange"

            PropertyAnimation {
                /* InElastic: Creates a spring-like effect at the start
                 * Useful for emphasizing sudden movements or stretching effects
                 * The oscillation amplitude decreases over time, similar to a rubber band */
                target: inElastic
                property: "x"
                from: 0
                to: rootWindow.width - inElastic.width
                running: true
                easing.type: Easing.InElastic
                duration: 4000
                loops: Animation.Infinite
            }

            Text {
                text: "InElastic"
                anchors.centerIn: parent
            }
        }
    }
}
