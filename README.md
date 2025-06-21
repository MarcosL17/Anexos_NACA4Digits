# Prototipo de Perfil Alar NACA 4418

Este repositorio contiene todos los archivos y scripts necesarios para el desarrollo, control y análisis de un perfil alar NACA 4418 sensorizado. El proyecto combina hardware (Raspberry Pi, sensores de presión, servo MG996R) con software desarrollado en Python y PySide6 para controlar, visualizar y analizar datos experimentales.

---

## 📁 Estructura del Proyecto

### `Calculo_Cp_Xfoil`
Scripts para:
- Procesado de datos recogidos por los sensores.
- Cálculo del coeficiente de presión (Cp) experimental.
- Comparación con valores teóricos obtenidos con XFOIL.
- Representación gráfica de resultados.

### `Generador_PerfilNACA_4Dig_Parametrico`
Herramienta para:
- Generación de perfiles NACA de 4 dígitos.
- Exportación de modelos 3D.

### `GUI/` — Interfaz Gráfica en PySide6
#### `NACA_GUIContent/`
- `Menu`: Menú principal del sistema.
- `Pantalla1`: Control del ángulo del perfil mediante servo.
- `Pantalla2`: Monitorización de sensores de presión.
- `Pantalla3`: Control de la velocidad del flujo.
- `Pantalla4`: Dashboard general con datos resumidos.
- `Main`: Archivo principal de la interfaz.

#### `Src/`
- `main.py`: Script de ejecución de la interfaz.
- `backend.py`: Enlace entre scripts de control y GUI.
- `pressure_control.py`: Gestión del TCA9548A y sensores SDP810-500Pa.
- `servo_auto.py`: Control del servomotor MG996R.
- `data_logger.py`: Exportación de datos a CSV y envío por SFTP.

---

## ⚙️ Requisitos

- Python 3.9+
- PySide6
- matplotlib
- numpy
- pandas
- matplotlib-cpp (opcional)
- Servidor X11 activo (para uso remoto vía SSH)
- Entorno virtual en de venv para poder instalar correctamente Pyside6

---

## 🔧 Hardware Utilizado

- Raspberry Pi 4B (8GB)
- Multiplexor I2C TCA9548A
- 8 sensores de presión diferencial SDP810-500Pa
- Servo MG996R
- Perfil alar NACA 4418 impreso en 3D

---

## ▶️ Ejecución

```bash
# Clona el repositorio en la Raspberry Pi
git clone https://github.com/usuario/proyecto-naca4418.git

# Accede vía SSH con reenvío gráfico
ssh -X pi@<IP_RASPBERRY>

# Lanza la GUI desde su carpeta
cd GUI/Src
python3 main.py
