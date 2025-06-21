import pigpio
import time



pi= pigpio.pi()
#Comprobamos si esta conectado el daemon pigpio (El proceso en segunod plano que gestiona los pines)
if not pi.connected:
    print("Error: No se ha podido conectar con pigpio")
    exit()
else:
    print("CONECTADO CON PIGPIO")

SERVOPIN=18

def set_angulo(angulo):
    angulo_fl = float(angulo)
    pulso = 500 + (( (2500 - 500) * angulo_fl ) / 180) #Interpolación lineal para 0-180º (500-2500us)
    pi.set_servo_pulsewidth(SERVOPIN,pulso)

def conversor(angulo_ataque): #Permite tratar el ángulo de ataque partiendo que el 0º es 90º del servo
    angulo_ataque=int(angulo_ataque)
    print (angulo_ataque)
    if angulo_ataque == 0:
        return 90
    else:
        return 90-angulo_ataque


try:
    while True:
        angulo = input("Introduce el ángulo deseado: ")
        set_angulo(conversor(angulo))
        time.sleep(1)
        print("Servo en posición:",angulo)
except KeyboardInterrupt:
    print("Programa interumpido")

finally:
    pi.set_servo_pulsewidth(SERVOPIN,1500) #Vuelve a posición 0 para el perfil alar (90º del servo)
    time.sleep(2)
    pi.set_servo_pulsewidth(SERVOPIN,0)
    pi.stop
    print("SERVO DETENIDO Y PIGPIO DESCONECTADO")
