import sys
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from backend import ServoControllerQML
from backend import PressureData
from Servo_auto import ServoController

if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.addImportPath("/home/pi/Documents/NACA4418/GUI/NACA_GUI")
    
    servo_controller = ServoController()

    # Instanciamos nuestro wrapper de sensores de presión y lo exponemos a QML
    pressure_data = PressureData(servo_controller)
    engine.rootContext().setContextProperty("pressureData", pressure_data)

    # Instanciamos nuestro wrapper del servo y lo exponemos a QML
    servo = ServoControllerQML(pressure_data,servo_controller)
    engine.rootContext().setContextProperty("servo", servo)

    
    
    engine.load("/home/pi/Documents/NACA4418/GUI/NACA_GUI/NACA_GUIContent/main.qml")

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())