import QtQuick
import NACA_GUI
import QtQuick.Controls

Window {
    visible: true
    width: 1920
    height: 1080

    title: "NACA_GUI"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem:"Menu.qml"

    }
}
