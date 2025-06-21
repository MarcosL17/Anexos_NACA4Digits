
import QtQuick
import QtQuick.Controls

Button {
    id: control

    leftPadding: 4
    rightPadding: 4

    text: "My Button"
    baselineOffset: 170
    spacing: 8
    font.family: "Roboto"

    background: buttonBackground
    Rectangle {
        id: buttonBackground
        color: "#8b8b8b"
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        radius: 20
        border.color: "#8b8b8b"
    }

    states: [
        State {
            name: "normal"
            when: !control.hovered

            PropertyChanges {
                target: buttonBackground
                color: "#8b8b8b"
            }

            PropertyChanges {
                target: control
                font.family: "Roboto"
            }
        },

        State {
            name: "hover"
            when: control.hovered

            PropertyChanges {
                target: buttonBackground
                color: "#019ef3"
                border.color: "#019ef3"
            }
        },
        State {
            name: "down"
            when: control.down

            PropertyChanges {
                target: buttonBackground
                color: "#019ef3"
                border.color: "#00000000"
            }
        }
    ]
}
