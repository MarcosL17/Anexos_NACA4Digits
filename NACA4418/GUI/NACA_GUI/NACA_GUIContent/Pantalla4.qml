
import QtQuick
import QtQuick.Controls

Rectangle {
    id: rectangle
    anchors.fill: parent
    color: "#282828"
    border.color: "#282828"
    //property real angle: servo.angle

    
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
            text: qsTr("DashBoard")
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
        width: parent.width * 0.5
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
                    // pressureData.reset_all_sensors()
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
                width: parent.width / 4 - 10; height: parent.height / 2 - 10
                color: "#363636"; border.color: "#282828"
                property var dataPoints: []
                property real timeWindow: 60  // Mostrar los últimos 60 segundos

                Canvas {
                    id: canvas0
                    anchors.fill: parent
                    onPaint: {
                        if (typeof parent.dataPoints === "undefined") return;
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        // Dibujar ejes
                        ctx.strokeStyle = "#eaeaea"
                        ctx.lineWidth = 1
                        ctx.beginPath()
                        ctx.moveTo(0, height - 20)
                        ctx.lineTo(width, height - 20)
                        ctx.stroke()
                        ctx.beginPath()
                        ctx.moveTo(40, 0)
                        ctx.lineTo(40, height)
                        ctx.stroke()

                        if (parent.dataPoints.length > 0) {
                            var currentTime = Date.now() / 1000.0
                            var startTime = currentTime - parent.timeWindow
                            var minPressure = -120, maxPressure = 120

                            ctx.strokeStyle = "#ffcc00"
                            ctx.lineWidth = 2
                            ctx.beginPath()
                            var started = false;
                            for (var i = 0; i < parent.dataPoints.length; i++) {
                                var pt = parent.dataPoints[i]
                                if (pt.time >= startTime) {
                                    var x = 40 + ((pt.time - startTime) / parent.timeWindow) * (width - 40)
                                    var y = height - 20 - ((pt.pressure - minPressure) / (maxPressure - minPressure)) * (height - 20)
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

                Timer {
                    interval: 100; running: true; repeat: true
                    onTriggered: {
                        canvas0.requestPaint()
                    }
                }
            }

            // Sensor 2 (sensorIndex 1)
            Rectangle {
                id: sensorRect1
                width: parent.width / 4 - 10; height: parent.height / 2 - 10
                color: "#363636"; border.color: "#282828"
                property var dataPoints: []
                property real timeWindow: 60

                Canvas {
                    id: canvas1
                    anchors.fill: parent
                    onPaint: {
                        if (typeof parent.dataPoints === "undefined") return;
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.strokeStyle = "#eaeaea"
                        ctx.lineWidth = 1
                        ctx.beginPath()
                        ctx.moveTo(0, height - 20)
                        ctx.lineTo(width, height - 20)
                        ctx.stroke()
                        ctx.beginPath()
                        ctx.moveTo(40, 0)
                        ctx.lineTo(40, height)
                        ctx.stroke()

                        if (parent.dataPoints.length > 0) {
                            var currentTime = Date.now() / 1000.0
                            var startTime = currentTime - parent.timeWindow
                            var minPressure = -120, maxPressure = 120
                            ctx.strokeStyle = "#ffcc00"
                            ctx.lineWidth = 2
                            ctx.beginPath()
                            var started = false;
                            for (var i = 0; i < parent.dataPoints.length; i++) {
                                var pt = parent.dataPoints[i]
                                if (pt.time >= startTime) {
                                    var x = 40 + ((pt.time - startTime) / parent.timeWindow) * (width - 40)
                                    var y = height - 20 - ((pt.pressure - minPressure) / (maxPressure - minPressure)) * (height - 20)
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

                Timer {
                    interval: 100; running: true; repeat: true
                    onTriggered: canvas1.requestPaint()
                }
            }

            // Sensor 3 (sensorIndex 2)
            Rectangle {
                id: sensorRect2
                width: parent.width / 4 - 10; height: parent.height / 2 - 10
                color: "#363636"; border.color: "#282828"
                property var dataPoints: []
                property real timeWindow: 60

                Canvas {
                    id: canvas2
                    anchors.fill: parent
                    onPaint: {
                        if (typeof parent.dataPoints === "undefined") return;
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.strokeStyle = "#eaeaea"
                        ctx.lineWidth = 1
                        ctx.beginPath()
                        ctx.moveTo(0, height - 20)
                        ctx.lineTo(width, height - 20)
                        ctx.stroke()
                        ctx.beginPath()
                        ctx.moveTo(40, 0)
                        ctx.lineTo(40, height)
                        ctx.stroke()

                        if (parent.dataPoints.length > 0) {
                            var currentTime = Date.now() / 1000.0
                            var startTime = currentTime - parent.timeWindow
                            var minPressure = -120, maxPressure = 120
                            ctx.strokeStyle = "#ffcc00"
                            ctx.lineWidth = 2
                            ctx.beginPath()
                            var started = false;
                            for (var i = 0; i < parent.dataPoints.length; i++) {
                                var pt = parent.dataPoints[i]
                                if (pt.time >= startTime) {
                                    var x = 40 + ((pt.time - startTime) / parent.timeWindow) * (width - 40)
                                    var y = height - 20 - ((pt.pressure - minPressure) / (maxPressure - minPressure)) * (height - 20)
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

                Timer { interval: 100; running: true; repeat: true; onTriggered: canvas2.requestPaint() }
            }

            // Sensor 4 (sensorIndex 3)
            Rectangle {
                id: sensorRect3
                width: parent.width / 4 - 10; height: parent.height / 2 - 10
                color: "#363636"; border.color: "#282828"
                property var dataPoints: []
                property real timeWindow: 60

                Canvas {
                    id: canvas3
                    anchors.fill: parent
                    onPaint: {
                        if (typeof parent.dataPoints === "undefined") return;
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.strokeStyle = "#eaeaea"
                        ctx.lineWidth = 1
                        ctx.beginPath()
                        ctx.moveTo(0, height - 20)
                        ctx.lineTo(width, height - 20)
                        ctx.stroke()
                        ctx.beginPath()
                        ctx.moveTo(40, 0)
                        ctx.lineTo(40, height)
                        ctx.stroke()

                        if (parent.dataPoints.length > 0) {
                            var currentTime = Date.now() / 1000.0
                            var startTime = currentTime - parent.timeWindow
                            var minPressure = -120, maxPressure = 120
                            ctx.strokeStyle = "#ffcc00"
                            ctx.lineWidth = 2
                            ctx.beginPath()
                            var started = false;
                            for (var i = 0; i < parent.dataPoints.length; i++) {
                                var pt = parent.dataPoints[i]
                                if (pt.time >= startTime) {
                                    var x = 40 + ((pt.time - startTime) / parent.timeWindow) * (width - 40)
                                    var y = height - 20 - ((pt.pressure - minPressure) / (maxPressure - minPressure)) * (height - 20)
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

                Timer { interval: 100; running: true; repeat: true; onTriggered: canvas3.requestPaint() }
            }

            // Sensor 5 (sensorIndex 4)
            Rectangle {
                id: sensorRect4
                width: parent.width / 4 - 10; height: parent.height / 2 - 10
                color: "#363636"; border.color: "#282828"
                property var dataPoints: []
                property real timeWindow: 60

                Canvas {
                    id: canvas4
                    anchors.fill: parent
                    onPaint: {
                        if (typeof parent.dataPoints === "undefined") return;
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.strokeStyle = "#eaeaea"
                        ctx.lineWidth = 1
                        ctx.beginPath()
                        ctx.moveTo(0, height - 20)
                        ctx.lineTo(width, height - 20)
                        ctx.stroke()
                        ctx.beginPath()
                        ctx.moveTo(40, 0)
                        ctx.lineTo(40, height)
                        ctx.stroke()

                        if (parent.dataPoints.length > 0) {
                            var currentTime = Date.now() / 1000.0
                            var startTime = currentTime - parent.timeWindow
                            var minPressure = -120, maxPressure = 120
                            ctx.strokeStyle = "#ffcc00"
                            ctx.lineWidth = 2
                            ctx.beginPath()
                            var started = false;
                            for (var i = 0; i < parent.dataPoints.length; i++) {
                                var pt = parent.dataPoints[i]
                                if (pt.time >= startTime) {
                                    var x = 40 + ((pt.time - startTime) / parent.timeWindow) * (width - 40)
                                    var y = height - 20 - ((pt.pressure - minPressure) / (maxPressure - minPressure)) * (height - 20)
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

                Timer { interval: 100; running: true; repeat: true; onTriggered: canvas4.requestPaint() }
            }

            // Sensor 6 (sensorIndex 5)
            Rectangle {
                id: sensorRect5
                width: parent.width / 4 - 10; height: parent.height / 2 - 10
                color: "#363636"; border.color: "#282828"
                property var dataPoints: []
                property real timeWindow: 60

                Canvas {
                    id: canvas5
                    anchors.fill: parent
                    onPaint: {
                        if (typeof parent.dataPoints === "undefined") return;
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.strokeStyle = "#eaeaea"
                        ctx.lineWidth = 1
                        ctx.beginPath()
                        ctx.moveTo(0, height - 20)
                        ctx.lineTo(width, height - 20)
                        ctx.stroke()
                        ctx.beginPath()
                        ctx.moveTo(40, 0)
                        ctx.lineTo(40, height)
                        ctx.stroke()

                        if (parent.dataPoints.length > 0) {
                            var currentTime = Date.now() / 1000.0
                            var startTime = currentTime - parent.timeWindow
                            var minPressure = -120, maxPressure = 120
                            ctx.strokeStyle = "#ffcc00"
                            ctx.lineWidth = 2
                            ctx.beginPath()
                            var started = false;
                            for (var i = 0; i < parent.dataPoints.length; i++) {
                                var pt = parent.dataPoints[i]
                                if (pt.time >= startTime) {
                                    var x = 40 + ((pt.time - startTime) / parent.timeWindow) * (width - 40)
                                    var y = height - 20 - ((pt.pressure - minPressure) / (maxPressure - minPressure)) * (height - 20)
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

                Timer { interval: 100; running: true; repeat: true; onTriggered: canvas5.requestPaint() }
            }

            // Sensor 7 (sensorIndex 6)
            Rectangle {
                id: sensorRect6
                width: parent.width / 4 - 10; height: parent.height / 2 - 10
                color: "#363636"; border.color: "#282828"
                property var dataPoints: []
                property real timeWindow: 60

                Canvas {
                    id: canvas6
                    anchors.fill: parent
                    onPaint: {
                        if (typeof parent.dataPoints === "undefined") return;
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.strokeStyle = "#eaeaea"
                        ctx.lineWidth = 1
                        ctx.beginPath()
                        ctx.moveTo(0, height - 20)
                        ctx.lineTo(width, height - 20)
                        ctx.stroke()
                        ctx.beginPath()
                        ctx.moveTo(40, 0)
                        ctx.lineTo(40, height)
                        ctx.stroke()

                        if (parent.dataPoints.length > 0) {
                            var currentTime = Date.now() / 1000.0
                            var startTime = currentTime - parent.timeWindow
                            var minPressure = -120, maxPressure = 120
                            ctx.strokeStyle = "#ffcc00"
                            ctx.lineWidth = 2
                            ctx.beginPath()
                            var started = false;
                            for (var i = 0; i < parent.dataPoints.length; i++) {
                                var pt = parent.dataPoints[i]
                                if (pt.time >= startTime) {
                                    var x = 40 + ((pt.time - startTime) / parent.timeWindow) * (width - 40)
                                    var y = height - 20 - ((pt.pressure - minPressure) / (maxPressure - minPressure)) * (height - 20)
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

                Timer { interval: 100; running: true; repeat: true; onTriggered: canvas6.requestPaint() }
            }

            // Sensor 8 (sensorIndex 7)
            Rectangle {
                id: sensorRect7
                width: parent.width / 4 - 10; height: parent.height / 2 - 10
                color: "#363636"; border.color: "#282828"
                property var dataPoints: []
                property real timeWindow: 60

                Canvas {
                    id: canvas7
                    anchors.fill: parent
                    onPaint: {
                        if (typeof parent.dataPoints === "undefined") return;
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.strokeStyle = "#eaeaea"
                        ctx.lineWidth = 1
                        ctx.beginPath()
                        ctx.moveTo(0, height - 20)
                        ctx.lineTo(width, height - 20)
                        ctx.stroke()
                        ctx.beginPath()
                        ctx.moveTo(40, 0)
                        ctx.lineTo(40, height)
                        ctx.stroke()

                        if (parent.dataPoints.length > 0) {
                            var currentTime = Date.now() / 1000.0
                            var startTime = currentTime - parent.timeWindow
                            var minPressure = -500, maxPressure = 500
                            ctx.strokeStyle = "#ffcc00"
                            ctx.lineWidth = 2
                            ctx.beginPath()
                            var started = false;
                            for (var i = 0; i < parent.dataPoints.length; i++) {
                                var pt = parent.dataPoints[i]
                                if (pt.time >= startTime) {
                                    var x = 40 + ((pt.time - startTime) / parent.timeWindow) * (width - 40)
                                    var y = height - 20 - ((pt.pressure - minPressure) / (maxPressure - minPressure)) * (height - 20)
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

                Timer { interval: 100; running: true; repeat: true; onTriggered: canvas7.requestPaint() }
            }
        }

        Connections {
            target: pressureData
            onPressureUpdated: function(sensorIndex, pressure) {
                //console.log("Se recibió presión para sensor", sensorIndex, ":", pressure);
                var currentTime = Date.now() / 1000.0;
                switch (sensorIndex) {
                    case 0:
                        sensorRect0.dataPoints.push({ time: currentTime, pressure: pressure });
                        while (sensorRect0.dataPoints.length && sensorRect0.dataPoints[0].time < currentTime - sensorRect0.timeWindow)
                            sensorRect0.dataPoints.shift();
                        break;
                    case 1:
                        sensorRect1.dataPoints.push({ time: currentTime, pressure: pressure });
                        console.log("sensorRect1 dataPoints length:", sensorRect1.dataPoints.length);
                        while (sensorRect1.dataPoints.length && sensorRect1.dataPoints[0].time < currentTime - sensorRect1.timeWindow)
                            sensorRect1.dataPoints.shift();
                        break;
                    case 2:
                        sensorRect2.dataPoints.push({ time: currentTime, pressure: pressure });
                        console.log("sensorRect2 dataPoints length:", sensorRect2.dataPoints.length);
                        while (sensorRect2.dataPoints.length && sensorRect2.dataPoints[0].time < currentTime - sensorRect2.timeWindow)
                            sensorRect2.dataPoints.shift();
                        break;
                    case 3:
                        sensorRect3.dataPoints.push({ time: currentTime, pressure: pressure });
                        while (sensorRect3.dataPoints.length && sensorRect3.dataPoints[0].time < currentTime - sensorRect3.timeWindow)
                            sensorRect3.dataPoints.shift();
                        break;
                    case 4:
                        sensorRect4.dataPoints.push({ time: currentTime, pressure: pressure });
                        console.log("sensorRect4 dataPoints length:", sensorRect4.dataPoints.length);
                        while (sensorRect4.dataPoints.length && sensorRect4.dataPoints[0].time < currentTime - sensorRect4.timeWindow)
                            sensorRect4.dataPoints.shift();
                        break;
                    case 5:
                        sensorRect5.dataPoints.push({ time: currentTime, pressure: pressure });
                        console.log("sensorRect5 dataPoints length:", sensorRect5.dataPoints.length);
                        while (sensorRect5.dataPoints.length && sensorRect5.dataPoints[0].time < currentTime - sensorRect5.timeWindow)
                            sensorRect5.dataPoints.shift();
                        break;
                    case 6:
                        sensorRect6.dataPoints.push({ time: currentTime, pressure: pressure });
                        console.log("sensorRect6 dataPoints length:", sensorRect6.dataPoints.length);
                        while (sensorRect6.dataPoints.length && sensorRect6.dataPoints[0].time < currentTime - sensorRect6.timeWindow)
                            sensorRect6.dataPoints.shift();
                        break;
                    case 7:
                        sensorRect7.dataPoints.push({ time: currentTime, pressure: pressure });
                        console.log("sensorRect7 dataPoints length:", sensorRect7.dataPoints.length);
                        while (sensorRect7.dataPoints.length && sensorRect7.dataPoints[0].time < currentTime - sensorRect7.timeWindow)
                            sensorRect7.dataPoints.shift();
                        break;
                }
            }
        }
    }

    Rectangle {
        id: rectangle_manualcontrol
        color: "#282828"
        border.color: "#282828"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: parent.height * 0.16
        width: rectangle.width * 0.25
        height: rectangle.height * 0.42



        Slider {
                id: slider1
                from: -90
                to: 90
                value: servo.angle
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: parent.width * 0.26
                anchors.topMargin: parent.height * 0.2
                width: parent.width * 0.60


                onValueChanged: {
                    if (!textField1.activeFocus) {
                        //angle = value;
                        servo.move(value)
                    }
                }
            }

            // 🔹 Campo de texto para ingresar manualmente el ángulo
        TextField {
                id: textField1
                width: parent.width * 0.1
                height: width * 0.75
                horizontalAlignment: Text.AlignHCenter

                // 🔹 Asegurar que `text` siempre refleje `angle`
                text: servo.angle.toFixed(0)
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: parent.width * 0.1
                anchors.topMargin: parent.height * 0.18
                onEditingFinished: {
                    let newAngle = parseFloat(text);
                    if (!isNaN(newAngle) && newAngle >= -90 && newAngle <= 90) {
                        //angle = newAngle;  // 🔹 Prioriza el valor ingresado en `TextField`
                        slider1.value = newAngle;  // 🔹 Actualiza el `Slider`
                        servo.move(newAngle)
                    } else {
                        text = servo.angle.toFixed(0);  // 🔹 Restaura el valor si es inválido
                    }
                }
            }

        Text {
                id: text1
                width: parent.width
                height: 23
                color: "#ffffff"
                text: qsTr("Control manual del servo")
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 0
                anchors.topMargin: parent.height * 0.05
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
                font.family: "Roboto"
            }

        Text {
                id: _text2
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: parent.width * 0.55
                anchors.topMargin: parent.height * 0.13
                color: "#ffffff"
                text: qsTr("0º")
                font.pixelSize: 12
                font.family: "Roboto"
            }

        Text {
                id: _text3
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: parent.width * 0.85
                anchors.topMargin: parent.height * 0.13
                width: 19
                height: 15
                color: "#ffffff"
                text: qsTr("90º")
                font.pixelSize: 12
                font.family: "Roboto"
            }

        Text {
                id: _text4
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: parent.width * 0.25
                anchors.topMargin: parent.height * 0.13
                color: "#ffffff"
                text: qsTr("-90º")
                font.pixelSize: 12
                font.family: "Roboto"
            }

        Image {
                id: image
                width: parent.width
                height: width*0.5
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 0
                anchors.topMargin: parent.height * 0.35
                source: "../IMG/Seccion_perfil.png"
                rotation: servo.angle
                fillMode: Image.PreserveAspectFit

            }


    }

    Rectangle {
        id: rectangle_velcontrol
        color: "#282828"
        border.color: "#282828"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        width: rectangle.width * 0.25
        height: rectangle.height * 0.42

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

    Rectangle {
        id: rectangle_autocontrol
        color: "#282828"
        border.color: "#282828"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        width: rectangle.width * 0.25
        height: rectangle.height * 0.84

        Text {
            id: text2
            width: 42
            height: 17
            color: "#ffffff"
            text: qsTr("Control automático")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: parent.width * 0.35
            anchors.topMargin: parent.height * 0.03
            font.pixelSize: 16
            font.family: "Roboto"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Column {
            id: column
            width: parent.width * 0.3
            height: parent.height * 0.25
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: parent.width * 0.15
            anchors.topMargin: parent.height * 0.08
            spacing: parent.height * 0.055

            Text {
                id: text3
                color: "#ffffff"
                text: qsTr("Ángulo de inicio:")
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.pixelSize: 12
                font.family: "Roboto"
            }

            Text {
                id: text4
                color: "#ffffff"
                text: qsTr("Ángulo de paso:")
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.pixelSize: 12
                font.family: "Roboto"
            }

            Text {
                id: text5
                color: "#ffffff"
                text: qsTr("Ángulo final:")
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.pixelSize: 12
                font.family: "Roboto"
            }

            Text {
                id: text6
                color: "#ffffff"
                text: qsTr("Tiempo de medición de datos:")
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.pixelSize: 12
                font.family: "Roboto"
            }


        }

        Column {

            id: column2
            width: parent.width * 0.3
            height: parent.height * 0.25
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: parent.width * 0.7
            anchors.topMargin: parent.height * 0.08
            spacing: parent.height * 0.035

            TextField {
                property real a0 : 0
                id: textField_a0
                width: parent.width * 0.22
                height: parent.width * 0.22
                text: a0.toFixed(0)
                anchors.left: parent.left
                anchors.leftMargin: 0
            }

            TextField {
                property real ap : 0
                id: textField_ap
                width: parent.width * 0.22
                height: parent.width * 0.22
                text: ap.toFixed(0)
                anchors.left: parent.left
                anchors.leftMargin: 0
            }

            TextField {
                property real af : 0
                id: textField_af
                width: parent.width * 0.22
                height: parent.width * 0.22
                text: af.toFixed(0)
                anchors.left: parent.left
                anchors.leftMargin: 0
            }

            TextField {
                property real t : 0
                id: textField_t
                width: parent.width * 0.22
                height: parent.width * 0.22
                text: t.toFixed(0)
                anchors.left: parent.left
                anchors.leftMargin: 0
            }

        }

        Boton_componente {
            id: boton_componente
            width: parent.width * 0.15
            height: parent.height * 0.04
            text: qsTr("Inicio")
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.35
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked:{
                console.log("Botón Iniciar presionado")

                var inicio = parseFloat(textField_a0.text)
                var fin = parseFloat(textField_af.text)
                var paso = parseFloat(textField_ap.text)
                var tiempo = parseFloat(textField_t.text)

                if (!isNaN(inicio) && !isNaN(fin) && !isNaN(paso) && !isNaN(tiempo)) {
                    servo.auto_move(inicio, fin, paso, tiempo)
                    pressureData.startGeneration()
                } 
                else {
                    console.log("Valores inválidos para auto_move")
                }

            }

        }



    }



}

