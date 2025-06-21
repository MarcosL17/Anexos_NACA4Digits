import smbus2 as smbus
import time
import struct

class Pressure_functions:
    def __init__(self):
        self.bus = smbus.SMBus(1)

    def selector_canal(self,bus,direccion_multi,canal):
        bus.write_byte(direccion_multi,1<<canal) 
        #Indicamos dirección propia del multiplexor, y dado que la dirección del canal es el número en binario, movemos en 1 tantas posiciones como canal sea
        time.sleep(0.1)

    def start_sensores(self,bus, direccion_sensor):
        command=[0x36,0x1E] #Comando para inicar medición continua
        bus.write_i2c_block_data(direccion_sensor, command[0], command[1:])
        time.sleep(0.1)

    def lectura_sensores(self,bus, direccion_sensor):

        data= bus.read_i2c_block_data(direccion_sensor,0,9)
        presion_raw = struct.unpack('>h', bytes(data[0:2]))[0]
        temperatura_raw = struct.unpack('>h', bytes(data[3:5]))[0]
        factor_escala = struct.unpack('>h', bytes(data[6:8]))[0]
        print(factor_escala)

        #Aplicar factores de escala
        presion=presion_raw/factor_escala
        temperatura= temperatura_raw/200

        return presion, temperatura
    
    def start_all_sensors(self):
        direccion_multi = 0x70
        direccion_sensor= 0x25

        for canal in range(8):#colocar número de sensores conectados al multiplexor
                self.selector_canal(self.bus,direccion_multi,canal)
                self.start_sensores(self.bus,direccion_sensor)
                print("Medición continua ACTIVADA en todos los sensores. Presione Ctrl + C para detener la medición")

         

    def ciclo_sensores(self,canal):

        direccion_multi = 0x70
        direccion_sensor= 0x25
       
        self.selector_canal(self.bus,direccion_multi,canal)
        presion,temperatura = self.lectura_sensores(self.bus, direccion_sensor)
        print(f"Canal {canal}: Presión = {presion:.2f} Pa , Temperatura = {temperatura:.2f} ºC")
        #time.sleep(0.1)
        return canal,presion,temperatura
    
    def stop_all_sensors(self):
         
        direccion_multi = 0x70
        direccion_sensor= 0x25
    
        for canal in range(8):
            self.selector_canal(self.bus,direccion_multi,canal)
            self.bus.write_i2c_block_data(direccion_sensor,0x3F,[0xF9]) #Detener mediciones

        print("Mediciones detenidas con éxito")
    
    def reset_sensors(self):
        
        direccion_multi = 0x70
        direccion_sensor= 0x25
    
        for canal in range(8):
            self.selector_canal(self.bus,direccion_multi,canal)
            self.bus.write_byte(0x00, 0x06)
            time.sleep(0.005)  # Esperar unos milisegundos


        print("Mediciones reseteadas con éxito")



   