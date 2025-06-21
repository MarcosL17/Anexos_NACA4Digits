
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
            text: qsTr("Control de Presión")
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
        id: grafica_presion
        width: parent.width * 0.8
        height: parent.height * 0.84
        color: "#363636"
        border.color: "#282828"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter

        Row{
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 100
            padding: 10

            Button {
                text: "Iniciar Generación"
                onClicked:{
                    console.log("Botón Iniciar presionado")
                    pressureData.startGeneration()
                }
            }
            Button {
                text: "Detener Generación"
                onClicked:{
                    console.log("Botón Detener presionado")
                    pressureData.stopGeneration()
                }
            }
        }

        Grid {
            id: gridSensors
            width: parent.width
            height: parent.height * 0.9
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            columns: 4
            rowSpacing: 10
            columnSpacing: 10

            // Sensor 1 (sensorIndex 0)
            Rectangle {
                id: sensorRect0  
                width: parent.width / 4 - 10
                height: parent.height / 2 - 10
                color: "#363636"
                border.color: "#282828"
                property var dataPoints: []
                property real timeWindow: 60
                property real latestPressure: 0

                Item {
                    anchors.fill: parent

                    Canvas {
                        id: canvas0  
                        anchors.fill: parent
                        onPaint: {
                            if (typeof sensorRect0.dataPoints === "undefined") return;
                            var ctx = getContext("2d")
                            ctx.clearRect(0, 0, width, height)

                            ctx.strokeStyle = "#eaeaea"
                            ctx.lineWidth = 1
                            ctx.beginPath()
                            ctx.moveTo(0, height/2)
                            ctx.lineTo(width, height/2)
                            ctx.stroke()
                            ctx.beginPath()
                            ctx.moveTo(40, 0)
                            ctx.lineTo(40, height)
                            ctx.stroke()

                            if (sensorRect0.dataPoints.length > 0) {
                                var currentTime = Date.now() / 1000.0
                                var startTime = currentTime - sensorRect0.timeWindow
                                var minPressure = -200, maxPressure = 200
                                ctx.strokeStyle = "#ffcc00"
                                ctx.lineWidth = 2
                                ctx.beginPath()
                                var started = false
                                for (var i = 0; i < sensorRect0.dataPoints.length; i++) {
                                    var pt = sensorRect0.dataPoints[i]
                                    if (pt.time >= startTime) {
                                        var x = 40 + ((pt.time - startTime) / sensorRect0.timeWindow) * (width - 40)
                                        var y = height - ((pt.pressure - minPressure) / (maxPressure - minPressure)) * (height)
                                        if (!started) {
                                            ctx.moveTo(x, y)
                                            started = true
                                        } else {
                                            ctx.lineTo(x, y)
                                        }
                                    }
                                }
                                ctx.stroke()
                            }
                        }
                    }

                    Text {
                        id: lastValue0 
                        text: "Última presión: " + sensorRect0.latestPressure.toFixed(2) + " Pa"
                        color: "white"
                        font.pixelSize: 14
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 10
                        z: 1
                    }
                }

                Timer {
                    interval: 100
                    running: true
                    repeat: true
                    onTriggered: canvas0.requestPaint()
                }
            }

            // Sensor 2 (sensorIndex 1)
            Rectangle {
                id: sensorRect1
                width: parent.width / 4 - 10
                height: parent.height / 2 - 10
                color: "#363636"
                border.color: "#282828"
                property var dataPoints: []
                property real timeWindow: 60
                property real latestPressure: 0

                Item {
                    anchors.fill: parent

                    Canvas {
                        id: canvas1
                        anchors.fill: parent
                        onPaint: {
                            if (typeof sensorRect1.dataPoints === "undefined") return;
                            var ctx = getContext("2d")
                            ctx.clearRect(0, 0, width, height)

                            ctx.strokeStyle = "#eaeaea"
                            ctx.lineWidth = 1
                            ctx.beginPath()
                            ctx.moveTo(0, height/2)
                            ctx.lineTo(width, height/2)
                            ctx.stroke()
                            ctx.beginPath()
                            ctx.moveTo(40, 0)
                            ctx.lineTo(40, height)
                            ctx.stroke()

                            if (sensorRect1.dataPoints.length > 0) {
                                var currentTime = Date.now() / 1000.0
                                var startTime = currentTime - sensorRect1.timeWindow
                                var minPressure = -200, maxPressure = 200
                                ctx.strokeStyle = "#ffcc00"
                                ctx.lineWidth = 2
                                ctx.beginPath()
                                var started = false
                                for (var i = 0; i < sensorRect1.dataPoints.length; i++) {
                                    var pt = sensorRect1.dataPoints[i]
                                    if (pt.time >= startTime) {
                                        var x = 40 + ((pt.time - startTime) / sensorRect1.timeWindow) * (width - 40)
                                        var y = height - ((pt.pressure - minPressure) / (maxPressure - minPressure)) * height
                                        if (!started) {
                                            ctx.moveTo(x, y)
                                            started = true
                                        } else {
                                            ctx.lineTo(x, y)
                                        }
                                    }
                                }
                                ctx.stroke()
                            }
                        }
                    }

                    Text {
                        id: lastValue1
                        text: "Última presión: " + sensorRect1.latestPressure.toFixed(2) + " Pa"
                        color: "white"
                        font.pixelSize: 14
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 10
                        z: 1
                    }
                }

                Timer {
                    interval: 100
                    running: true
                    repeat: true
                    onTriggered: canvas1.requestPaint()
                }
            }

            // Sensor 3 (sensorIndex 2)
            Rectangle {
                id: sensorRect2
                width: parent.width / 4 - 10
                height: parent.height / 2 - 10
                color: "#363636"
                border.color: "#282828"
                property var dataPoints: []
                property real timeWindow: 60
                property real latestPressure: 0

                Item {
                    anchors.fill: parent

                    Canvas {
                        id: canvas2
                        anchors.fill: parent
                        onPaint: {
                            if (typeof sensorRect2.dataPoints === "undefined") return;
                            var ctx = getContext("2d")
                            ctx.clearRect(0, 0, width, height)

                            ctx.strokeStyle = "#eaeaea"
                            ctx.lineWidth = 1
                            ctx.beginPath()
                            ctx.moveTo(0, height/2)
                            ctx.lineTo(width, height/2)
                            ctx.stroke()
                            ctx.beginPath()
                            ctx.moveTo(40, 0)
                            ctx.lineTo(40, height)
                            ctx.stroke()

                            if (sensorRect2.dataPoints.length > 0) {
                                var currentTime = Date.now() / 1000.0
                                var startTime = currentTime - sensorRect2.timeWindow
                                var minPressure = -200, maxPressure = 200
                                ctx.strokeStyle = "#ffcc00"
                                ctx.lineWidth = 2
                                ctx.beginPath()
                                var started = false
                                for (var i = 0; i < sensorRect2.dataPoints.length; i++) {
                                    var pt = sensorRect2.dataPoints[i]
                                    if (pt.time >= startTime) {
                                        var x = 40 + ((pt.time - startTime) / sensorRect2.timeWindow) * (width - 40)
                                        var y = height - ((pt.pressure - minPressure) / (maxPressure - minPressure)) * height
                                        if (!started) {
                                            ctx.moveTo(x, y)
                                            started = true
                                        } else {
                                            ctx.lineTo(x, y)
                                        }
                                    }
                                }
                                ctx.stroke()
                            }
                        }
                    }

                    Text {
                        id: lastValue2
                        text: "Última presión: " + sensorRect2.latestPressure.toFixed(2) + " Pa"
                        color: "white"
                        font.pixelSize: 14
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 10
                        z: 1
                    }
                }

                Timer {
                    interval: 100
                    running: true
                    repeat: true
                    onTriggered: canvas2.requestPaint()
                }
            }


            // Sensor 4 (sensorIndex 3)
            Rectangle {
                id: sensorRect3
                width: parent.width / 4 - 10
                height: parent.height / 2 - 10
                color: "#363636"
                border.color: "#282828"
                property var dataPoints: []
                property real timeWindow: 60
                property real latestPressure: 0

                Item {
                    anchors.fill: parent

                    Canvas {
                        id: canvas3
                        anchors.fill: parent
                        onPaint: {
                            if (typeof sensorRect3.dataPoints === "undefined") return;
                            var ctx = getContext("2d")
                            ctx.clearRect(0, 0, width, height)

                            ctx.strokeStyle = "#eaeaea"
                            ctx.lineWidth = 1
                            ctx.beginPath()
                            ctx.moveTo(0, height/2)
                            ctx.lineTo(width, height/2)
                            ctx.stroke()
                            ctx.beginPath()
                            ctx.moveTo(40, 0)
                            ctx.lineTo(40, height)
                            ctx.stroke()

                            if (sensorRect3.dataPoints.length > 0) {
                                var currentTime = Date.now() / 1000.0
                                var startTime = currentTime - sensorRect3.timeWindow
                                var minPressure = -200, maxPressure = 200
                                ctx.strokeStyle = "#ffcc00"
                                ctx.lineWidth = 2
                                ctx.beginPath()
                                var started = false
                                for (var i = 0; i < sensorRect3.dataPoints.length; i++) {
                                    var pt = sensorRect3.dataPoints[i]
                                    if (pt.time >= startTime) {
                                        var x = 40 + ((pt.time - startTime) / sensorRect3.timeWindow) * (width - 40)
                                        var y = height - ((pt.pressure - minPressure) / (maxPressure - minPressure)) * height
                                        if (!started) {
                                            ctx.moveTo(x, y)
                                            started = true
                                        } else {
                                            ctx.lineTo(x, y)
                                        }
                                    }
                                }
                                ctx.stroke()
                            }
                        }
                    }

                    Text {
                        id: lastValue3
                        text: "Última presión: " + sensorRect3.latestPressure.toFixed(2) + " Pa"
                        color: "white"
                        font.pixelSize: 14
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 10
                        z: 1
                    }
                }

                Timer {
                    interval: 100
                    running: true
                    repeat: true
                    onTriggered: canvas3.requestPaint()
                }
            }

            // Sensor 5 (sensorIndex 4)
            Rectangle {
                id: sensorRect4
                width: parent.width / 4 - 10
                height: parent.height / 2 - 10
                color: "#363636"
                border.color: "#282828"
                property var dataPoints: []
                property real timeWindow: 60
                property real latestPressure: 0

                Item {
                    anchors.fill: parent

                    Canvas {
                        id: canvas4
                        anchors.fill: parent
                        onPaint: {
                            if (typeof sensorRect4.dataPoints === "undefined") return;
                            var ctx = getContext("2d")
                            ctx.clearRect(0, 0, width, height)

                            ctx.strokeStyle = "#eaeaea"
                            ctx.lineWidth = 1
                            ctx.beginPath()
                            ctx.moveTo(0, height/2)
                            ctx.lineTo(width, height/2)
                            ctx.stroke()
                            ctx.beginPath()
                            ctx.moveTo(40, 0)
                            ctx.lineTo(40, height)
                            ctx.stroke()

                            if (sensorRect4.dataPoints.length > 0) {
                                var currentTime = Date.now() / 1000.0
                                var startTime = currentTime - sensorRect4.timeWindow
                                var minPressure = -200, maxPressure = 200
                                ctx.strokeStyle = "#ffcc00"
                                ctx.lineWidth = 2
                                ctx.beginPath()
                                var started = false
                                for (var i = 0; i < sensorRect4.dataPoints.length; i++) {
                                    var pt = sensorRect4.dataPoints[i]
                                    if (pt.time >= startTime) {
                                        var x = 40 + ((pt.time - startTime) / sensorRect4.timeWindow) * (width - 40)
                                        var y = height - ((pt.pressure - minPressure) / (maxPressure - minPressure)) * height
                                        if (!started) {
                                            ctx.moveTo(x, y)
                                            started = true
                                        } else {
                                            ctx.lineTo(x, y)
                                        }
                                    }
                                }
                                ctx.stroke()
                            }
                        }
                    }

                    Text {
                        id: lastValue4
                        text: "Última presión: " + sensorRect4.latestPressure.toFixed(2) + " Pa"
                        color: "white"
                        font.pixelSize: 14
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 10
                        z: 1
                    }
                }

                Timer {
                    interval: 100
                    running: true
                    repeat: true
                    onTriggered: canvas4.requestPaint()
                }
            }
            // Sensor 6 (sensorIndex 5)
            Rectangle {
                id: sensorRect5
                width: parent.width / 4 - 10
                height: parent.height / 2 - 10
                color: "#363636"
                border.color: "#282828"
                property var dataPoints: []
                property real timeWindow: 60
                property real latestPressure: 0

                Item {
                    anchors.fill: parent

                    Canvas {
                        id: canvas5
                        anchors.fill: parent
                        onPaint: {
                            if (typeof sensorRect5.dataPoints === "undefined") return;
                            var ctx = getContext("2d")
                            ctx.clearRect(0, 0, width, height)

                            ctx.strokeStyle = "#eaeaea"
                            ctx.lineWidth = 1
                            ctx.beginPath()
                            ctx.moveTo(0, height/2)
                            ctx.lineTo(width, height/2)
                            ctx.stroke()
                            ctx.beginPath()
                            ctx.moveTo(40, 0)
                            ctx.lineTo(40, height)
                            ctx.stroke()

                            if (sensorRect5.dataPoints.length > 0) {
                                var currentTime = Date.now() / 1000.0
                                var startTime = currentTime - sensorRect5.timeWindow
                                var minPressure = -200, maxPressure = 200
                                ctx.strokeStyle = "#ffcc00"
                                ctx.lineWidth = 2
                                ctx.beginPath()
                                var started = false
                                for (var i = 0; i < sensorRect5.dataPoints.length; i++) {
                                    var pt = sensorRect5.dataPoints[i]
                                    if (pt.time >= startTime) {
                                        var x = 40 + ((pt.time - startTime) / sensorRect5.timeWindow) * (width - 40)
                                        var y = height - ((pt.pressure - minPressure) / (maxPressure - minPressure)) * height
                                        if (!started) {
                                            ctx.moveTo(x, y)
                                            started = true
                                        } else {
                                            ctx.lineTo(x, y)
                                        }
                                    }
                                }
                                ctx.stroke()
                            }
                        }
                    }

                    Text {
                        id: lastValue5
                        text: "Última presión: " + sensorRect5.latestPressure.toFixed(2) + " Pa"
                        color: "white"
                        font.pixelSize: 14
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 10
                        z: 1
                    }
                }

                Timer {
                    interval: 100
                    running: true
                    repeat: true
                    onTriggered: canvas5.requestPaint()
                }
            }

            // Sensor 7 (sensorIndex 6)
            Rectangle {
                id: sensorRect6
                width: parent.width / 4 - 10
                height: parent.height / 2 - 10
                color: "#363636"
                border.color: "#282828"
                property var dataPoints: []
                property real timeWindow: 60
                property real latestPressure: 0

                Item {
                    anchors.fill: parent

                    Canvas {
                        id: canvas6
                        anchors.fill: parent
                        onPaint: {
                            if (typeof sensorRect6.dataPoints === "undefined") return;
                            var ctx = getContext("2d")
                            ctx.clearRect(0, 0, width, height)

                            ctx.strokeStyle = "#eaeaea"
                            ctx.lineWidth = 1
                            ctx.beginPath()
                            ctx.moveTo(0, height/2)
                            ctx.lineTo(width, height/2)
                            ctx.stroke()
                            ctx.beginPath()
                            ctx.moveTo(40, 0)
                            ctx.lineTo(40, height)
                            ctx.stroke()

                            if (sensorRect6.dataPoints.length > 0) {
                                var currentTime = Date.now() / 1000.0
                                var startTime = currentTime - sensorRect6.timeWindow
                                var minPressure = -200, maxPressure = 200
                                ctx.strokeStyle = "#ffcc00"
                                ctx.lineWidth = 2
                                ctx.beginPath()
                                var started = false
                                for (var i = 0; i < sensorRect6.dataPoints.length; i++) {
                                    var pt = sensorRect6.dataPoints[i]
                                    if (pt.time >= startTime) {
                                        var x = 40 + ((pt.time - startTime) / sensorRect6.timeWindow) * (width - 40)
                                        var y = height - ((pt.pressure - minPressure) / (maxPressure - minPressure)) * height
                                        if (!started) {
                                            ctx.moveTo(x, y)
                                            started = true
                                        } else {
                                            ctx.lineTo(x, y)
                                        }
                                    }
                                }
                                ctx.stroke()
                            }
                        }
                    }

                    Text {
                        id: lastValue6
                        text: "Última presión: " + sensorRect6.latestPressure.toFixed(2) + " Pa"
                        color: "white"
                        font.pixelSize: 14
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 10
                        z: 1
                    }
                }

                Timer {
                    interval: 100
                    running: true
                    repeat: true
                    onTriggered: canvas6.requestPaint()
                }
            }
            // Sensor 8 (sensorIndex 7)
            Rectangle {
                id: sensorRect7
                width: parent.width / 4 - 10
                height: parent.height / 2 - 10
                color: "#363636"
                border.color: "#282828"
                property var dataPoints: []
                property real timeWindow: 60
                property real latestPressure: 0

                Item {
                    anchors.fill: parent

                    Canvas {
                        id: canvas7
                        anchors.fill: parent
                        onPaint: {
                            if (typeof sensorRect7.dataPoints === "undefined") return;
                            var ctx = getContext("2d")
                            ctx.clearRect(0, 0, width, height)

                            ctx.strokeStyle = "#eaeaea"
                            ctx.lineWidth = 1
                            ctx.beginPath()
                            ctx.moveTo(0, height/2)
                            ctx.lineTo(width, height/2)
                            ctx.stroke()
                            ctx.beginPath()
                            ctx.moveTo(40, 0)
                            ctx.lineTo(40, height)
                            ctx.stroke()

                            if (sensorRect7.dataPoints.length > 0) {
                                var currentTime = Date.now() / 1000.0
                                var startTime = currentTime - sensorRect7.timeWindow
                                var minPressure = -200, maxPressure = 200
                                ctx.strokeStyle = "#ffcc00"
                                ctx.lineWidth = 2
                                ctx.beginPath()
                                var started = false
                                for (var i = 0; i < sensorRect7.dataPoints.length; i++) {
                                    var pt = sensorRect7.dataPoints[i]
                                    if (pt.time >= startTime) {
                                        var x = 40 + ((pt.time - startTime) / sensorRect7.timeWindow) * (width - 40)
                                        var y = height - ((pt.pressure - minPressure) / (maxPressure - minPressure)) * height
                                        if (!started) {
                                            ctx.moveTo(x, y)
                                            started = true
                                        } else {
                                            ctx.lineTo(x, y)
                                        }
                                    }
                                }
                                ctx.stroke()
                            }
                        }
                    }

                    Text {
                        id: lastValue7
                        text: "Última presión: " + sensorRect7.latestPressure.toFixed(2) + " Pa"
                        color: "white"
                        font.pixelSize: 14
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 10
                        z: 1
                    }
                }

                Timer {
                    interval: 100
                    running: true
                    repeat: true
                    onTriggered: canvas7.requestPaint()
                }
            }
        }
        Connections {
            target: pressureData
            onPressureUpdated: function(sensorIndex, pressure) {
                console.log("Se recibió presión para sensor", sensorIndex, ":", pressure);
                var currentTime = Date.now() / 1000.0;
                switch (sensorIndex) {
                    case 0:
                        sensorRect0.dataPoints.push({ time: currentTime, pressure: pressure });
                        sensorRect0.latestPressure = pressure;
                        console.log("sensorRect0 dataPoints length:", sensorRect0.dataPoints.length);
                        while (sensorRect0.dataPoints.length && sensorRect0.dataPoints[0].time < currentTime - sensorRect0.timeWindow)
                            sensorRect0.dataPoints.shift();
                        break;
                    case 1:
                        sensorRect1.dataPoints.push({ time: currentTime, pressure: pressure });
                        sensorRect1.latestPressure = pressure;
                        console.log("sensorRect1 dataPoints length:", sensorRect1.dataPoints.length);
                        while (sensorRect1.dataPoints.length && sensorRect1.dataPoints[0].time < currentTime - sensorRect1.timeWindow)
                            sensorRect1.dataPoints.shift();
                        break;
                    case 2:
                        sensorRect2.dataPoints.push({ time: currentTime, pressure: pressure });
                        sensorRect2.latestPressure = pressure;
                        console.log("sensorRect2 dataPoints length:", sensorRect2.dataPoints.length);
                        while (sensorRect2.dataPoints.length && sensorRect2.dataPoints[0].time < currentTime - sensorRect2.timeWindow)
                            sensorRect2.dataPoints.shift();
                        break;
                    case 3:
                        sensorRect3.dataPoints.push({ time: currentTime, pressure: pressure });
                        sensorRect3.latestPressure = pressure;
                        while (sensorRect3.dataPoints.length && sensorRect3.dataPoints[0].time < currentTime - sensorRect3.timeWindow)
                            sensorRect3.dataPoints.shift();
                        break;
                    case 4:
                        sensorRect4.dataPoints.push({ time: currentTime, pressure: pressure });
                        sensorRect4.latestPressure = pressure;
                        console.log("sensorRect4 dataPoints length:", sensorRect4.dataPoints.length);
                        while (sensorRect4.dataPoints.length && sensorRect4.dataPoints[0].time < currentTime - sensorRect4.timeWindow)
                            sensorRect4.dataPoints.shift();
                        break;
                    case 5:
                        sensorRect5.dataPoints.push({ time: currentTime, pressure: pressure });
                        sensorRect5.latestPressure = pressure;
                        console.log("sensorRect5 dataPoints length:", sensorRect5.dataPoints.length);
                        while (sensorRect5.dataPoints.length && sensorRect5.dataPoints[0].time < currentTime - sensorRect5.timeWindow)
                            sensorRect5.dataPoints.shift();
                        break;
                    case 6:
                        sensorRect6.dataPoints.push({ time: currentTime, pressure: pressure });
                        sensorRect6.latestPressure = pressure;
                        console.log("sensorRect6 dataPoints length:", sensorRect6.dataPoints.length);
                        while (sensorRect6.dataPoints.length && sensorRect6.dataPoints[0].time < currentTime - sensorRect6.timeWindow)
                            sensorRect6.dataPoints.shift();
                        break;
                    case 7:
                        sensorRect7.dataPoints.push({ time: currentTime, pressure: pressure });
                        sensorRect7.latestPressure = pressure;
                        console.log("sensorRect7 dataPoints length:", sensorRect7.dataPoints.length);
                        while (sensorRect7.dataPoints.length && sensorRect7.dataPoints[0].time < currentTime - sensorRect7.timeWindow)
                            sensorRect7.dataPoints.shift();
                        break;
                }
            }
        }
    }
}
