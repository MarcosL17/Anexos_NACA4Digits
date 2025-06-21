
import QtQuick
import QtQuick.Controls

Rectangle {

    id: rectangle
    anchors.fill: parent
    color: "#282828"
    border.color: "#282828"
    property real angle: 0

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
        id: rectangle2
        color: "#303030"
        height: parent.height * 0.84
        width: parent.width * 0.60
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.topMargin: 175

        Slider {
            id: slider
            x: 386
            y: 110
            from: -90
            to: 90
            value: angle  // 🔹 Enlaza `angle` con `Slider`
            width: 300

            onValueChanged: {
                if (!textField.activeFocus) {
                    angle = value;  // 🔹 Actualiza `angle` solo si el usuario no escribe
                    servo.move(angle)
                }
            }
        }

        // 🔹 Campo de texto para ingresar manualmente el ángulo
        TextField {
            id: textField
            x: 205
            y: 112
            width: 100
            horizontalAlignment: Text.AlignHCenter

            // 🔹 Asegurar que `text` siempre refleje `angle`
            text: angle.toFixed(0)

            onEditingFinished: {
                let newAngle = parseFloat(text);
                if (!isNaN(newAngle) && newAngle >= -90 && newAngle <= 90) {
                    angle = newAngle;  // 🔹 Prioriza el valor ingresado en `TextField`
                    slider.value = newAngle;  // 🔹 Actualiza el `Slider`
                    servo.move(newAngle)
                } else {
                    text = angle.toFixed(0);  // 🔹 Restaura el valor si es inválido
                }
            }
        }

        // 🔹 Texto que muestra el ángulo actual
        Text {
            x: 1200
            y: 47
            text: "Ángulo: " + angle.toFixed(0) + "°"  // 🔹 Se actualiza con `angle`
            color: "white"
            font.pixelSize: 18
        }

        Text {
            id: _text1
            x: 135
            y: 32
            width: 170
            height: 39
            color: "#ffffff"
            text: qsTr("Control Manual")
            font.pixelSize: 21
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Roboto"
        }

        Text {
            id: _text2
            x: 530
            y: 89
            color: "#ffffff"
            text: qsTr("0º")
            font.pixelSize: 12
            font.family: "Roboto"
        }

        Text {
            id: _text3
            x: 674
            y: 89
            color: "#ffffff"
            text: qsTr("90º")
            font.pixelSize: 12
            font.family: "Roboto"
        }

        Text {
            id: _text4
            x: 386
            y: 89
            color: "#ffffff"
            text: qsTr("-90º")
            font.pixelSize: 12
            font.family: "Roboto"
        }

        Text {
            id: _text5
            x: 135
            y: 390
            width: 225
            height: 39
            color: "#ffffff"
            text: qsTr("Programar Automático")
            font.pixelSize: 21
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Roboto"
        }

        TextField {
            id: textField1
            x: 145
            y: 470
            width: 83
            height: 30
            text: " "
            horizontalAlignment: Text.AlignHCenter
            font.family: "Roboto"
            placeholderText: qsTr("Text Field")
        }

        TextField {
            id: textField2
            x: 253
            y: 470
            width: 83
            height: 30
            text: " "
            horizontalAlignment: Text.AlignHCenter
            placeholderText: qsTr("Text Field")
            font.family: "Roboto"
        }

        TextField {
            id: textField3
            x: 361
            y: 470
            width: 83
            height: 30
            text: " "
            horizontalAlignment: Text.AlignHCenter
            placeholderText: qsTr("Text Field")
            font.family: "Roboto"
        }

        TextField {
            id: textField4
            x: 530
            y: 470
            width: 83
            height: 30
            text: " "
            horizontalAlignment: Text.AlignHCenter
            placeholderText: qsTr("Text Field")
            font.family: "Roboto"
        }

        Boton_componente {
            id: boton_componente
            x: 726
            y: 465
            text: "Iniciar"
            font.family: "Roboto"
            onClicked: {
                // Obtener y convertir los valores de los text fields
                var inicio = parseFloat(textField1.text)
                var fin = parseFloat(textField2.text)
                var paso = parseFloat(textField3.text)
                var tiempo = parseFloat(textField4.text)

                // Puedes agregar validaciones de entrada aquí
                if (!isNaN(inicio) && !isNaN(fin) && !isNaN(paso) && !isNaN(tiempo)) {
                    servo.auto_move(inicio, fin, paso, tiempo)
                } else {
                    console.log("Valores inválidos para auto_move")
                }
            }
        }

        Text {
            id: _text6
            x: 145
            y: 449
            width: 83
            height: 16
            color: "#ffffff"
            text: qsTr("Inicio")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Roboto"
        }

        Text {
            id: _text7
            x: 253
            y: 449
            width: 83
            height: 16
            color: "#ffffff"
            text: qsTr("Final")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Roboto"
        }

        Text {
            id: _text8
            x: 361
            y: 449
            width: 83
            height: 16
            color: "#ffffff"
            text: qsTr("Paso")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Roboto"
        }

        Text {
            id: _text9
            x: 530
            y: 449
            width: 83
            height: 16
            color: "#ffffff"
            text: qsTr("Tiempo espera")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Roboto"
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
            text: qsTr("Control del Servomotor")
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

    



    Image {
        id: image

        width: parent.width * 0.40
        height: width
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 0
        source: "../IMG/Seccion_perfil.png"
        anchors.verticalCenterOffset: 100
        rotation: angle
        fillMode: Image.PreserveAspectFit
    }
}