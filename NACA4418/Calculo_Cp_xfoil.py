
import subprocess
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import os
from pathlib import Path
import textwrap


#Importar excel
df = pd.read_excel(r'C:\Users\MLG17\OneDrive - unizar.es\TFG\CALCULOS EXCEL\TEST_-30_30_v7.xlsx')

tabla = df.groupby(['angle', 'sensor_index'])['pressure'].mean().reset_index()#Obtenemos valor promedio de presión de cada sensor, para cada angulo
matriz= tabla.pivot(index='sensor_index', columns='angle', values='pressure')

presion_prom=matriz.values
angulos = matriz.columns.to_numpy() # ángulos de ataque
sensores = matriz.index.to_numpy() #Sensores

print(presion_prom)
print(angulos)
print(sensores)

#Calculo de presión dinámica

density=1.2041 #kg/m3 a 200m y 20º
velocity= 13.02#float(input("Introduce la velocidad del fluido a la que se realizaron las medidas (m/s): "))

p_din= (density*(velocity**2))/2

print(f"La presión dinámica es:{p_din:.2f}")

#Calculamos Cp, de forma que las presiones medidas y almacenadas en nuestro array se adimensionalizan con la presión dinámica.

Cp_matrix_1=(presion_prom/p_din)
Cp_matrix=Cp_matrix_1

print(Cp_matrix)

#Posición de los sensores
Extrados=[0,2,4,6]
Intrados=[1,3,5,7]

x_sensor_extra=np.array([9.98,29.98,49.98,69.98]) #
x_sensor_intra=np.array([19.98,39.98,59.98,79.96]) #
#Adimensionalizamos respecto de la cuerda
c=125
x_sensor_extra_c=x_sensor_extra/c
x_sensor_intra_c=x_sensor_intra/c

num_angulos = len(angulos)
num_sensores = len(sensores)

print(num_angulos)
print(num_sensores)

plt.figure(figsize=(10, 6))

for i in range(num_angulos):
    Cp_extra=np.empty(int(num_sensores/2))
    Cp_intra=np.empty(int(num_sensores/2))
    
    a=0
    b=0
    for j in range(num_sensores):
       
        if sensores[j] in Extrados:
            if angulos[i]>=0:
                Cp_extra[a]=(Cp_matrix[j,i]-0.1398)/0.722
                a=a+1
            else:
                Cp_extra[a]=(Cp_matrix[j,i]*0.722+0.1398)
                a=a+1
        else:
            if angulos[i]>=0:
                Cp_intra[b]=(Cp_matrix[j,i]*0.722+0.1398)
                b=b+1
            else:
                Cp_intra[b]=(Cp_matrix[j,i]-0.1398)/0.722
                b=b+1

    if angulos[i] in [-15]:#-20,-15,-10,-5,0,5,10,15,20
        
        # Parámetros del análisis
        airfoil = "4418"
        reynolds = 108000
        alpha = angulos[i]
        cp_filename = Path(__file__).parent / f"cp_data_{alpha}.txt"

        # Script de comandos para XFOIL
        xfoil_input = (
            f"NACA 4418\n"
            f"PANE\n"
            f"OPER\n"
            f"VISC 108000\n"
            f"ALFA {alpha}\n"
            f"CPWR\n"
            f"{cp_filename.name}\n"
            f"\n"      # línea en blanco crítica
            f"QUIT\n"
        )
        # Guardar comandos en archivo temporal
        with open("xfoil_commands.in", "w", newline='\n') as f:
            f.write(xfoil_input)

        with open("xfoil_commands.in", "r") as f:
            print("--- Comando generado ---")
            print(f.read())

        # Ejecutar XFOIL con entrada desde el archivo de comandos
        script_dir = Path(__file__).parent
        xfoil_path = script_dir / "xfoil.exe"

        # Confirmación (esto deberías ver que imprime bien la ruta)
        print(f"Ruta XFOIL: {xfoil_path}")

        # Ejecutar desde cmd, con redirección
        with open("xfoil_commands.in", "r") as input_file:
            result = subprocess.run([str(xfoil_path)], stdin=input_file, cwd=xfoil_path.parent)

        if cp_filename.exists():
            print(f"Archivo generado: {cp_filename}")
        else:
            print("No se ha generado el archivo de Cp. Revisa entrada o convergencia.")

        if os.path.exists(cp_filename):
            # Leer y graficar Cp
            df = pd.read_csv(
                cp_filename,
                sep='\s+',
                comment='#',
                header=None,
                skiprows=3,  # Saltamos las 3 primeras líneas no numéricas
                names=['x', 'y', 'Cp']
            )
            #df = df.sort_values(by='x/c')  # Muy importante

            plt.plot(df['x'], df['Cp'], color='green', label=f'XFOIL α={alpha}°')

        else:
            print("No se ha generado el archivo de Cp. Verifica que XFOIL esté correctamente instalado.")

        plt.plot(x_sensor_extra_c, Cp_extra, linestyle='-',color='red', marker='o', label=f'α={angulos[i]}° Extradós')
        plt.plot(x_sensor_intra_c, Cp_intra, linestyle='--',color='blue', marker='x', label=f'α={angulos[i]}° Intradós')
        ang=angulos[i]

       
plt.gca().invert_yaxis()  # Cp se grafica con eje Y invertido
plt.grid(True)
plt.xlabel('x/c')
#plt.xticks(np.linspace(0, 1, 11))  # ticks de 0.0 a 1.0 en pasos de 0.1
plt.ylabel('$C_p$')
plt.title(f'Distribución de $C_p$ para α = {ang}')
plt.legend()
plt.tight_layout()
plt.show()
