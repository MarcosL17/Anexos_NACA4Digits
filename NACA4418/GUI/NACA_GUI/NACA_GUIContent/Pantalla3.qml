
import QtQuick
import QtQuick.Controls

Rectangle {
    id: rectangle
    anchors.fill: parent
    color: "#282828"
    border.color: "#282828"


    Rectangle {
        id: desplegable
        width: parent.width * 0.1
        height: parent.height
        opacity: 1
        z:1

        color: "#019ef3"
        x: -width// Oculto fuera de la pantalla al inicio
        visible: true

        Column {
            opacity: 1
            anchors.fill: parent
            leftPadding: 0
            topPadding: 175
            padding: 20

            Button {
                width: desplegable.width
                height: desplegable.height * 0.1
                visible: true
                text: "Servo"
                font.family: "Roboto"
                font.pointSize: 16
                background: Rectangle {
                    id: bg1
                    color: "#019ef3"
                    opacity: 0.7
                }
                MouseArea {
                    onClicked: stackView.push("Pantalla1.qml")
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: bg1.color = "lightgray"
                    onExited: bg1.color = "#019ef3"
                    onPressed: bg1.color = "darkgray"
                    onReleased: bg1.color = "#019ef3"
                }
            }
            Button {
                text: "Presión"
                width: desplegable.width
                height: desplegable.height * 0.1
                visible: true
                font.family: "Roboto"
                font.pointSize: 16
                background: Rectangle {
                    id: bg2
                    color: "#019ef3"
                    opacity: 0.7
                }
                MouseArea {
                    onClicked: stackView.push("Pantalla2.qml")
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: bg2.color = "lightgray"
                    onExited: bg2.color = "#019ef3"
                    onPressed: bg2.color = "darkgray"
                    onReleased: bg2.color = "#019ef3"
                }
            }
            Button {
                text: "Tubo Pitot"
                width: desplegable.width
                height: desplegable.height * 0.1
                visible: true
                font.family: "Roboto"
                font.pointSize: 16
                background: Rectangle {
                    id: bg3
                    color: "#019ef3"
                    opacity: 0.7
                }
                MouseArea {
                    onClicked: stackView.push("Pantalla3.qml")
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: bg3.color = "lightgray"
                    onExited: bg3.color = "#019ef3"
                    onPressed: bg3.color = "darkgray"
                    onReleased: bg3.color = "#019ef3"
                }
            }
            Button {
                text: "Dashboard"
                width: desplegable.width
                height: desplegable.height * 0.1
                visible: true
                font.family: "Roboto"
                font.pointSize: 16
                background: Rectangle {
                    id: bg
                    color: "#019ef3"
                    opacity: 0.7
                }
                MouseArea {
                    onClicked: stackView.push("Pantalla4.qml")
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: bg.color = "lightgray"
                    onExited: bg.color = "#019ef3"
                    onPressed: bg.color = "darkgray"
                    onReleased: bg.color = "#019ef3"
                }
            }

        }
        Button {
            x: 0
            y: 700
            text: "Volver a Menu"
            width: desplegable.width
            height: desplegable.height * 0.1
            visible: true
            font.family: "Roboto"
            font.pointSize: 16

            background: Rectangle {
                id: bg5
                color: "#019ef3"
                opacity: 0.7
            }
            MouseArea {
                onClicked: stackView.push("Menu.qml")
                anchors.fill: parent
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                hoverEnabled: true
                onEntered: bg5.color = "lightgray"
                onExited: bg5.color = "#019ef3"
                onPressed: bg5.color = "darkgray"
                onReleased: bg5.color = "#019ef3"
            }
        }
    }

    Rectangle {
        id: rectangle1
        z:2
        color: "#232323"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height * 0.16

        Button {
            id: button
            width:desplegable.width
            height: rectangle1.height
            text: qsTr("Button")
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 0
            anchors.topMargin: 0
            flat: true
            icon.height: desplegable.width * 0.3
            icon.width: rectangle1.height * 0.3
            icon.color: "#ffffff"
            icon.source: "../IMG/power-switch.png"
            display: AbstractButton.IconOnly
            onClicked: {
                servo.stop_servo()
                //pressureData.stopGeneration()
                Qt.quit()
            }
        }
        Button {
            width:desplegable.width
            height: rectangle1.height
            text: "Abrir Menú"
            anchors.top: parent.top
            flat: true
            highlighted: false
            icon.height: desplegable.width * 0.3
            icon.width: rectangle1.height * 0.3
            icon.color: "#eaeaea"
            icon.source: "../IMG/menu-tres-barras-delineadas.png"
            display: AbstractButton.IconOnly
            anchors.left: parent.left
            onClicked: desplegable.x = (desplegable.x === 0 ? -200 : 0) // Alterna entre abierto y cerrado
        }


        Text {
            id: _text
            height: rectangle1.height * 0.5
            color: "#eaeaea"
            text: qsTr("Control de velocidad")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: rectangle1.height * 0.25
            font.pixelSize: rectangle1.height * 0.25
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Roboto"
        }
    }

    Rectangle {
        id: rectangle_velcontrol
        color: "#282828"
        border.color: "#282828"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 150
        width: parent.width * 0.70
        height: parent.height * 0.70


        Text {
        id: text1_vel
        width: parent.width
        height: 23
        color: "#ffffff"
        text: qsTr("Medidor velocidad del fluido")
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.topMargin: parent.height * 0.05
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter
        font.family: "Roboto"
        }

        Image {
                id: image2
                width: parent.width
                height: width*0.5

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 0
                anchors.topMargin: parent.height * 0.21

                source: "../IMG/PITOT.png"
                rotation: 0
                fillMode: Image.PreserveAspectFit

        }
        TextField {
            property real vel : 0
            id: textField_VEL
            width: 32
            height: 32
            horizontalAlignment: Text.AlignHCenter

            // 🔹 Asegurar que `text` siempre refleje `angle`
            text: vel.toFixed(0)
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: parent.width * 0.2
            anchors.topMargin: parent.height * 0.2
        }

        TextField {
                        property real press : 0
                        id: textField_PRESS
                        width: 32
                        height: 32
                        horizontalAlignment: Text.AlignHCenter
                        text: press.toFixed(0)
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.leftMargin: parent.width * 0.77
                        anchors.topMargin: parent.height * 0.45
                    }

    }


}