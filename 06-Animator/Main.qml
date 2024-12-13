import QtQuick
import QtQuick.Controls.Basic

/*  The Animator types provide a more efficient way to animate properties
 *  compared to traditional property animations, as they run directly on the
 *  render thread. This means they can continue animating smoothly even when
 *  the main thread is blocked.
 *
 *  Reference: https://doc.qt.io/qt-6/qml-qtquick-animator.html */
ApplicationWindow {
    id: root
    visible: true
    width: 800
    height: 600
    title: "Animator Example"

    Rectangle {
        id: animatedRect
        width: 100
        height: animatedRect.width
        color: "black"

        x: 100
        y: 100

        state: "Default"
        states: [
            State {
                name: "Default"
                PropertyChanges {
                    animatedRect {
                        x: 100
                        y: 100
                        scale: 1
                        opacity: 1
                    }
                }
            },
            State {
                name: "Expanded"
                PropertyChanges {
                    animatedRect {
                        x: 400
                        y: 300
                        scale: 2
                        opacity: 0.5
                    }
                }
            }
        ]
        transitions: [
            Transition {
                //  Wildcard "*" matches any state change
                from: "*"
                to: "*"
                /*  XAnimator/YAnimator: Animate position changes smoothly
                 *  Advantages over NumberAnimation:
                 *      - Runs on render thread
                 *      - Better performance for position animations
                 *      - Reduced stuttering during complex animations */
                XAnimator {
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
                YAnimator {
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }

                /* ScaleAnimator: Handles uniform scaling transformations
                 * More efficient than using Scale + NumberAnimation */
                ScaleAnimator {
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }

                /* OpacityAnimator: Smooth transparency transitions
                 * Ideal for fade effects and visibility changes */
                OpacityAnimator {
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
            }
        ]
    }

    Button {
        text: "Toggle State"
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: 20
        }

        onClicked: {
            animatedRect.state = animatedRect.state === "Default" ? "Expanded" : "Default";
        }
    }
}
