from Servo_auto import ServoController
from Pressure_control import Pressure_functions
from Data_logger import DataLogger
from PySide6.QtCore import QObject, QTimer, Signal, Slot,Property

import sys
import random
import datetime


class PressureData(QObject):
    pressureUpdated = Signal(int, float)  # (sensorIndex, pressureValue)

    def __init__(self, servo_controller, parent=None):
        super().__init__()
        self.pressure = Pressure_functions()
        self.logger = DataLogger()
        self.servo_controller = servo_controller
        self.timer = QTimer()
        self.timer.setInterval(100)
        self.timer.timeout.connect(self.update_data)
    
    @Slot()
    def startGeneration(self):
        print("Generación iniciada")
        self.pressure.start_all_sensors()
        self.timer.start()

    @Slot()
    def stopGeneration(self):
        print("Generación detenida")
        self.timer.stop()
        self.pressure.stop_all_sensors()
        fecha=datetime.datetime.now()
        self.logger.export_csv(f"datos_sensores_{fecha}.csv")
    
    @Slot()
    def reset_all_sensors(self):
        self.pressure.reset_sensors()

    def get_pressure_value(self,i):
        """Simulación de presión - sustituir por lectura real."""
        sensorIndex,pressure,temperature = self.pressure.ciclo_sensores(i)
        return sensorIndex, pressure,temperature


    @Slot()
    def update_data(self):
        for i in range(8):
            sensorIndex, pressure,temperature = self.get_pressure_value(i)
            current_angle = self.servo_controller.current_angle
            self.pressureUpdated.emit(sensorIndex, pressure)
            self.logger.log_data(sensorIndex, current_angle, pressure, temperature)


class ServoControllerQML(QObject):
    angleChanged = Signal(int)

    def __init__(self, pressure_data, servo_controller, parent=None):
        super().__init__(parent)
        self.controller = servo_controller
        self.pressure_data = pressure_data
        self._angle = 0

    @Slot(float)
    def move(self, angulo):
        """
        Se invoca desde el slider o TextField de ángulo.
        """
        # En este ejemplo se asume que el valor del slider es el ángulo de ataque.
        self.controller.move(angulo)
        self.set_angle(angulo)
    
    def get_angle(self):
        return self._angle

    def set_angle(self, value):
        if self._angle != value:
            self._angle = value
            self.angleChanged.emit(value)

    angle = Property(int, get_angle, set_angle, notify=angleChanged)

    @Slot(float, float, float, float)
    def auto_move(self, inicio, final, paso, tiempo):
        print("Empieza AutoMove")
        self._auto_move_inicio = inicio
        self._auto_move_final = final
        self._auto_move_paso = abs(paso) if inicio < final else -abs(paso)
        self._auto_move_tiempo = tiempo * 1000  # QTimer usa milisegundos
        self._auto_move_actual = inicio + self._auto_move_paso
        self.set_angle(inicio)
        self.move(inicio)

        # Asegurar que no haya otro timer activo antes
        if hasattr(self, '_auto_move_timer') and self._auto_move_timer.isActive():
            self._auto_move_timer.stop()

        self._auto_move_timer = QTimer()
        self._auto_move_timer.timeout.connect(self._auto_move_step)
        self._auto_move_timer.start(self._auto_move_tiempo)

    @Slot()
    def stop_servo(self):
        self.controller.out()

    def zero_position(self):
        self.controller.zero_position()
        self.set_angle(0)

    def _auto_move_step(self):
        
        # Verificar si hemos llegado al final
        if (self._auto_move_paso > 0 and self._auto_move_actual > self._auto_move_final) or (self._auto_move_paso < 0 and self._auto_move_actual < self._auto_move_final):
            self._auto_move_timer.stop()
            self.pressure_data.stopGeneration()
            #self.pressure_data.reset_all_sensors()
            self.zero_position()
            print("Medición automática finalizada")
            return
        
        print(self._auto_move_actual)
        self.set_angle(self._auto_move_actual)
        self.move(self._auto_move_actual)
        self._auto_move_actual += self._auto_move_paso

    