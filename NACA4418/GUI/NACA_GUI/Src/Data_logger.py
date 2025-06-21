
import pandas as pd
import time
import os
import paramiko

class DataLogger:
    def __init__(self):
        # Diccionario para almacenar los datos por sensor.
        # Cada sensor tendrá una lista de registros (con ángulo, presión, temperatura y timestamp)
        self.data = {}
        self.start_time = time.time()

    def log_data(self, sensor_index, angle, pressure, temperature):
        # Inicializa la lista para el sensor si aún no existe
        if sensor_index not in self.data:
            self.data[sensor_index] = {
                'timestamp': [],
                'angle': [],
                'pressure': [],
                'temperature': []
            }
        # Guarda el registro actual en la lista del sensor
        timestamp = time.time() - self.start_time
        self.data[sensor_index]['timestamp'].append(timestamp)
        self.data[sensor_index]['angle'].append(angle)
        self.data[sensor_index]['pressure'].append(pressure)
        self.data[sensor_index]['temperature'].append(temperature)
        print(f"Log sensor {sensor_index}: angle={angle}, pressure={pressure}, temperature={temperature}")

    def export_csv(self, filename):
        # Combina los datos de todos los sensores en una única lista de registros
        rows = []
        for sensor_index, sensor_data in self.data.items():
            n = len(sensor_data['timestamp'])
            for i in range(n):
                rows.append({
                    'sensor_index': sensor_index,
                    'timestamp': sensor_data['timestamp'][i],
                    'angle': sensor_data['angle'][i],
                    'pressure': sensor_data['pressure'][i],
                    'temperature': sensor_data['temperature'][i]
                })
        # Crea un DataFrame con pandas y lo exporta a un archivo CSV
        filepath = os.path.join("/home/pi/Documents/NACA4418/GUI/CSV_Documents", filename)
        df = pd.DataFrame(rows)
        df.to_csv(filepath, index=False)
        print(f"Datos exportados a {filename}")

            # Enviar por SFTP
        self.send_via_sftp(filepath, filename)

    def send_via_sftp(self, local_path, remote_filename):
        host = "IP_DEL_PORTATIL"
        port = 22
        username = "mlg17"
        password = "marcos17"  # O usa una clave privada

        remote_path = f"C:/Users/MLG17/Documents/PythonProyects/TFG_PerfilAlar/CSV_DATA/{remote_filename}"  # Ajusta la ruta de destino

        try:
            transport = paramiko.Transport((host, port))
            transport.connect(username=username, password=password)

            sftp = paramiko.SFTPClient.from_transport(transport)
            sftp.put(local_path, remote_path)

            sftp.close()
            transport.close()

            print(f"Archivo enviado por SFTP a {remote_path}")
        except Exception as e:
            print(f"Error en la transferencia SFTP: {e}")
