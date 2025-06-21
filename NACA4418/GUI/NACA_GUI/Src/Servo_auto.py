import pigpio
import time

SERVOPIN = 18

class ServoController:
    def __init__(self, servo_pin=SERVOPIN):
        self.servo_pin = servo_pin
        self.pi = pigpio.pi()
        self.current_angle = 0
        if not self.pi.connected:
            raise Exception("Error: No se ha podido conectar con pigpio")
        else:
            print("CONECTADO CON PIGPIO")
        
    
    def set_angulo(self, angulo):
        angulo_fl = float(angulo)
        # Interpolación lineal para 0-180º (500-2500µs)
        pulso = 500 + (((2500 - 500) * angulo_fl) / 180)
        self.pi.set_servo_pulsewidth(self.servo_pin, pulso)
    
    def conversor(self, angulo_ataque):
        # Permite tratar el ángulo de ataque partiendo que el 0º es 90º del servo
        angulo_ataque = int(angulo_ataque)
        self.current_angle = angulo_ataque
        print("Ángulo de ataque recibido:", angulo_ataque)
        if angulo_ataque == 0:
            return 90
        else:
            return 90 - angulo_ataque
    
    def move(self, angulo_ataque):
        # Convierte el ángulo de ataque y mueve el servo
        angulo_convertido = self.conversor(angulo_ataque)
        print(f"Moviendo servo a {angulo_convertido}° (ángulo de ataque: {angulo_ataque})")
        self.set_angulo(angulo_convertido)
    
    #def auto_move(self, inicio, final, paso, tiempo):
        #i=inicio
        #if inicio>final:
        #    paso=-paso
        #for i in range(inicio,final,paso):
        #   self.set_angulo(self.conversor(i))
        #   time.sleep(tiempo)
        
    def zero_position(self):
        self.pi.set_servo_pulsewidth(self.servo_pin, 1500)
        
    def out(self):
        # Vuelve a la posición central y detiene el servo
        self.pi.set_servo_pulsewidth(self.servo_pin, 1500)
        self.pi.stop()
        print("SERVO DETENIDO Y PIGPIO DESCONECTADO")
