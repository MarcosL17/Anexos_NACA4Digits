
import QtQuick
import QtQuick.Controls
import NACA_GUI
//import QtQuick.Studio.Components

Rectangle {
    id: rectangle
    anchors.fill: parent
    color: "#282828"

    Text {
        id: _text
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 58
        color: "#019ef3"
        text: qsTr("PROYECTO NACA")
        font.pixelSize: 100
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.styleName: "Negrita"
        font.family: "Roboto"
    }

    Image {
        id: image
        height: parent.height * 0.5
        anchors.top: parent.top
        anchors.topMargin: 200
        width: height
        source: "../IMG/Soporte.png"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }
    Row{
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 100

        Boton_componente {
            id: boton_componente
            width: 278
            height: 105
            text: "SERVO"
            font.pointSize: 30
            display: AbstractButton.TextOnly
            onClicked: stackView.push("Pantalla1.qml");
        }

        Boton_componente {
            id: boton_componente1
            width: 252
            height: 108
            text: "PRESIÓN"
            rotation: 0
            font.pointSize: 30
            display: AbstractButton.TextOnly
            onClicked: stackView.push("Pantalla2.qml")
        }

        Boton_componente {
            id: boton_componente2
            width: 246
            height: 105
            text: "PITOT"
            font.pointSize: 30
            display: AbstractButton.TextOnly
            onClicked: stackView.push("Pantalla3.qml")
        }

        Boton_componente {
            id: boton_componente3
            width: 296
            height: 105
            text: "DASHBOARD"
            display: AbstractButton.TextOnly
            font.pointSize: 30
            onClicked: stackView.push("Pantalla4.qml")
        }
    }
}

