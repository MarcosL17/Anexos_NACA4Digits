#Programa creado para el cálculo paramétrico de un perfil alar de tipo NACA 4 digitos
import os
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from mpl_toolkits.mplot3d import Axes3D
from OCC.Core.BRepPrimAPI import BRepPrimAPI_MakePrism
from OCC.Core.gp import gp_Pnt, gp_Vec
from OCC.Core.BRepBuilderAPI import BRepBuilderAPI_MakeWire, BRepBuilderAPI_MakeEdge,BRepBuilderAPI_MakeFace
from OCC.Core.BRep import BRep_Tool
from OCC.Core.TopAbs import TopAbs_ShapeEnum
from OCC.Core.TopoDS import TopoDS_Shape
from OCC.Core.BRepTools import breptools


os.system('cls')

titulo = "Cálculo paramétrico de perfil NACA-4 Digitos"
guion=len(titulo)

print(f"{titulo}")

for i in range(guion+1):
    print("-",end="")
print("\n\nPulsa cualquier tecla para continuar...")
input()
os.system('cls')

titulo = "Cálculo paramétrico de perfil NACA-4 Digitos"
guion=len(titulo)

print(f"{titulo}")

for i in range(guion+1):
    print("-",end="")

while True:
    print("\n\nIntroduce el código del perfil NACA de 4 dígitos a generar.\n\n")
    digitos=input("Código 4 dígitos: ")

    if len(digitos)==4:
        break
    else:
        print("\nPorfavor, introduzca un valor de 4 dígitos\n\n")
    
#print(f"Su codigo es: {digitos}")

m=int(digitos[0])/100 #Primerdig/Máxima combadura de la línea media (% de tamaño total de la cuerda - 2->2% de c)
p=int(digitos[1])/10 #Segundodig/Posición en x del punto de máximo espesor de combadura (4->40% de c)
t= int(digitos[2:])/100#Tercer&cuartodig/Máximo espesor total del perfil(3y4=12->12% de c)

n=int(input("Número de nodos para generar EXTRADÓS/INTRADÓS:"))
c=int(input("Medida cuerda:"))
ancho=int(input("Indica ancho del modelo 3D:"))
x=np.empty(n+1) #Array para almacenar los valores de x
yc=np.empty(n+1) #Array para almacenar los valores de yc
yt=np.empty(n+1) #Array para almacenar los valores de yt (espesor respcto cuerda media)
dyc_dx=np.empty(n+1)
theta=np.empty(n+1)


a=0
theta_k=0
while a<=(n):
    x[a]=(1/2)*(1-np.cos(np.pi*theta_k))
    a=a+1
    theta_k=theta_k+(1/n)
    
a=0
while a<=(n):
    yt[a]=(t*5)*((0.2969*np.sqrt(x[a]))-(0.1260*x[a])-(0.3516*(x[a]**2))+(0.2843*(x[a]**3))-(0.1015*(x[a]**4)))
    a=a+1
yt[n]=0 #Dado que se calculan números finitos de puntos, el perfil no se cierra correctamente, y forzamos que este último punto sea yt=0

xu=np.empty(n+1)
yu=np.empty(n+1)
xl=np.empty(n+1)
yl=np.empty(n+1)

if m==0 and p==0:
    a=0
    while a<=(n):
        xu[a]=x[a]
        yu[a]=yt[a]
        xl[a]=x[a]
        yl[a]=-yt[a]
        a=a+1

else:
    a=0
    while a<=(n):
        if x[a]<=p:
            yc[a]=(m/(p**2))*((2*p*x[a])-(x[a]**2))
        else:
            yc[a]=(m/((1-p)**2))*((1-2*p)+(2*p*x[a])-(x[a]**2))
        a=a+1

    a=0
    while a<=(n):
        if x[a]<=p:
            dyc_dx[a]=(2*m/(p**2))*((p-x[a]))
        else:
            dyc_dx[a]=(2*m/((1-p)**2))*((p-x[a]))
        a=a+1
    a=0
    while a<=(n):
        theta[a]=np.arctan(dyc_dx[a])
        a=a+1

    #Coordenadas finales del pefil (xu,yu -> Extradós)(xl,yl -> Intradós)
    a=0
    while a<=(n):
        xu[a]=x[a]-(yt[a]*np.sin(theta[a]))
        yu[a]=yc[a]+(yt[a]*np.cos(theta[a]))
        xl[a]=x[a]+(yt[a]*np.sin(theta[a]))
        yl[a]=yc[a]-(yt[a]*np.cos(theta[a]))
        a=a+1

#Escalado de las coordenadas
xu_escalada=c*xu
yu_escalada=c*yu
xl_escalada=c*xl
yl_escalada=c*yl
x_escalada=c*x
yc_escalada=c*yc
yt_escalada=c*yt

coordenadas = {
    "x": x_escalada.astype(float),
    "yc": yc_escalada.astype(float),
    "yt": yt_escalada.astype(float),
    "θ": theta.astype(float),
    "xu": xu_escalada.astype(float),
    "yu": yu_escalada.astype(float),
    "xl": xl_escalada.astype(float),
    "yl": yl_escalada.astype(float),
}

s1=input("¿Quiere generar un Excel con las coordenadas del perfil? S/N: ")

if s1=="S":
    df=pd.DataFrame(coordenadas)
    df.to_excel(f"C:/Users/MLG17/Documents/PythonProyects/Excels_Perfiles/Coordenadas_NACA_{digitos}_C{c}.xlsx", index=False)

s2=input("¿Quiere generar una representación 2D del perfil? S/N: ")

if s2=="S":
    plt.plot(xu_escalada,yu_escalada,label="Extradós",color="red")
    plt.plot(xl_escalada,yl_escalada,label="Intradós",color="blue")
    plt.plot(xl_escalada,yc_escalada,'o',label="Main line",color="green",markersize=1)
    plt.title(f"Representación 2D perfil NACA{digitos}")
    plt.legend()
    plt.grid()
    plt.axis("equal") #Escalar los ejes de manera uniforme, para evitar disrsión en la representación
    plt.show()

#Cerramos el contorno definido
x_tot=np.concatenate((xu_escalada,xl_escalada[::-1]))
y_tot=np.concatenate((yu_escalada,yl_escalada[::-1]))


s3=input("¿Quiere generar una representación 3D del perfil? S/N: ")

if s3=="S":
    z=np.linspace(0,ancho,4)
    X,Z=np.meshgrid(x_tot,z)
    Y,Z=np.meshgrid(y_tot,z)


    fig = plt.figure()
    tresd = fig.add_subplot(111, projection='3d')

    # Superficie superior
    tresd.plot_surface(X, Z, Y, color='b', alpha=0.7)

    tresd.set_title(f"Representación NACA {digitos} 3D")

    # Configurar los ejes
    tresd.set_xlabel('X')
    tresd.set_ylabel('Z')
    tresd.set_zlabel('Y')
    tresd.set_zlim([-(c*0.3),(c*0.4)])
    plt.show()

#Crear el modelo 3D en .BREP

s4=input("¿Quiere generar una archivo .BREP del perfil? S/N: ")

if s4=="S":
    aristas=[]
    for i in range(len(x_tot)-1): #Se usa -1 ya que después vamos a unir un punto co  el siguiente, de fomra que con el antepenultimo conectaremos con el último.
        p1=gp_Pnt(x_tot[i],y_tot[i],0)
        p2=gp_Pnt(x_tot[i+1],y_tot[i+1],0)

        # Verificar si los puntos son diferentes
        if (x_tot[i] == x_tot[i+1]) and (y_tot[i] == y_tot[i+1]):
            continue  # Saltar esta iteración si los puntos son iguales

        union=BRepBuilderAPI_MakeEdge(p1,p2).Edge()
        aristas.append(union)

    wire_function=BRepBuilderAPI_MakeWire() #Le doy un nombre a la función para facilitar su uso
    for j in aristas:
        wire_function.Add(j) #Añado uno a uno las aristas al contorno
    contorno=wire_function.Wire() #Genero el contorno/wire

    cara=BRepBuilderAPI_MakeFace(contorno).Face()
    #Extrusión:
    v_extrusion=gp_Vec(0,0,ancho) #Vector de la extrusión
    solido=BRepPrimAPI_MakePrism(cara,v_extrusion).Shape() #Se genera el sólido


    # Escribir el sólido en un archivo BREP como prueba
    ruta_brep = f"C:/Users/MLG17/Documents/PythonProyects/TFG_PerfilAlar/Perfil_NACA{digitos}_C{c}_A{ancho}.brep"
    breptools().Write(solido, ruta_brep)
