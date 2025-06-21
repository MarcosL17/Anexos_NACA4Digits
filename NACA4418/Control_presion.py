import smbus2 as smbus
import time

def selector_canal(bus,direccion_multi,canal):
    bus.write_byte(direccion_multi,1<<canal) 
    #Indicamos dirección propia del multiplexor, y dado que la dirección del canal es el número en binario, movemos en 1 tantas posiciones como canal sea
    time.sleep(0.1)

def start_sensores(bus, direccion_sensor):
    command=[0x36,0x1E] #Comando para inicar medición continua
    bus.write_i2c_block_data(direccion_sensor, command[0], command[1:])
    time.sleep(0.1)

def lectura_sensores(bus, direccion_sensor):

    data= bus.read_i2c_block_data(direccion_sensor,0,9)
    presion_raw = data[0]<<8 | data[1] #Combina los datos de 8 bits en uno de 16 bits
    temperatura_raw = data[3]<<8 | data[4]
    factor_escala = data[6]<<8 | data[7]

    #Aplicar factores de escala
    presion=presion_raw/factor_escala
    temperatura= temperatura_raw/200

    return presion, temperatura

def main():
    bus=smbus.SMBus(1)
    direccion_multi = 0x70
    direccion_sensor= 0x25

    try:
        for canal in range(6):#colocar número de sensores conectados al multiplexor
            selector_canal(bus,direccion_multi,canal)
            start_sensores(bus,direccion_sensor)
        print("Medición continua ACTIVADA en todos los sensores. Presione Ctrl + C para detener la medición")

        while True:
            for canal in range(6):
                selector_canal(bus,direccion_multi,canal)
                presion,temperatura = lectura_sensores(bus, direccion_sensor)
                print(f"Canal {canal}: Presión = {presion:.2f} Pa , Temperatura = {temperatura:.2f} ºC")
                time.sleep(0.1)
    except KeyboardInterrupt:
        print("\nDeteniendo mediciones")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        for canal in range(6):
            selector_canal(bus,direccion_multi,canal)
            bus.write_i2c_block_data(direccion_sensor,0x3F,[0xF9]) #Detener mediciones
        print("Mediciones detenidas con éxito")

if __name__ == "__main__":
    main()