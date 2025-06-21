from Servo_auto import ServoController
from Pressure_control import Pressure_functions
from PySide6.QtCore import QObject, QTimer, Signal, Slot

import sys
import random

class ServoControllerQML(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.controller = ServoController()  # Se conecta a pigpio

    @Slot(float)
    def move(self, angulo):
        """
        Se invoca desde el slider o TextField de ángulo.
        """
        # En este ejemplo se asume que el valor del slider es el ángulo de ataque.
        self.controller.move(angulo)

    @Slot(float, float, float, float)
    def auto_move(self, inicio, final, paso, tiempo):
        """
        Se invoca al presionar el botón 'Iniciar'
        Los parámetros se reciben como float; se convierten según sea necesario.
        """
        # Si lo prefieres, puedes hacer validaciones o conversión de tipos aquí
        self.controller.auto_move(int(inicio), int(final), int(paso), tiempo)
    
    @Slot()
    def stop_servo(self):
        self.controller.out()

class PressureData(QObject):
    pressureUpdated = Signal(int, float)  # (sensorIndex, pressureValue)

    def __init__(self):
        super().__init__()
        self.pressure = Pressure_functions()
        self.timer = QTimer()
        self.timer.setInterval(100)
        self.timer.timeout.connect(self.update_data)
    
    @Slot()
    def startGeneration(self):
        print("Generación iniciada")
        self.timer.start()

    @Slot()
    def stopGeneration(self):
        print("Generación detenida")
        self.timer.stop()

    def get_pressure_value(self):
        """Simulación de presión - sustituir por lectura real."""
        sensorIndex = random.randint(0, 7)
        pressure = random.uniform(-500, 500)
        return sensorIndex, pressure


    @Slot()
    def update_data(self):
        sensorIndex, pressure = self.get_pressure_value()
        self.pressureUpdated.emit(sensorIndex, pressure)