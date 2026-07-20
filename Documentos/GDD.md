# UNIVERSIDAD NACIONAL DEL LITORAL
## Facultad de Ingeniería y Ciencias Hídricas
### Tecnicatura en Diseño y Programación de Videojuegos
**Proyecto Final**

---

# GAME DESIGN DOCUMENT (GDD)

**Nombre del Juego:** Spellbound Tonics  
**Autor:** Mateo Pereyra Sangoy
**Versión:** 1.0.0  
**Fecha de actualización:** 19/07/2026

## Ficha del Grupo
| Apellido y Nombre Completo | Función dentro del grupo                             |
| :------------------------- | :--------------------------------------------------- |
| Pereyra Sangoy, Mateo      | Game Designer / Level Design / Programmer / Producer |


---

## 1. High Concept y Visión Inicial

![[31df67bf-dbe7-499d-be06-d44f2c61ef28.png]]
>*Imagen de preproducción generada por IA, donde se busca expresar el "mood" y ambientación del proyecto*

Life-sim RPG donde eres una bruja que recolecta materiales, crea y descubre pociones, registra sus propias recetas y vende los productos a los aldeanos al mismo tiempo que mejora su tienda, cuida su fama, y forma lazos con los habitantes del pueblo.

---

## 2. Estructura Core del Proyecto

### 2.1 Objetivo del Proyecto
Este proyecto tiene como propósito principal convertirse en el primer lanzamiento oficial del autor y consolidar una comunidad inicial de jugadores, al mismo tiempo que es usado como proyecto final de la tecnicatura.

Como producto, se busca lograr un juego funcional, coherente con sus reglas y capaz de darle al jugador la experiencia ofrecida: sesiones relajantes de descubrimiento, prueba, y exploración del mundo de juego.

Como proyecto académico, se busca desarrollar un prototipo eficiente, sostenible y capaz de ser desarrollado a mayor profundidad mediante versiones posteriores de manera eficaz, demostrando tener los conocimientos adecuados para lograrlo. 

### 2.2 Diseño e investigación
- **Definición de idea:** El jugador deberá recolectar materiales para descubrir recetas y pociones, registrarlas y luego venderlas o consumirlas. A medida que vaya generando dinero, tendrá la posibilidad de mejorar la tienda, decorarla comprar materiales, etc. El jugador puede explorar zonas salvajes, como el bosque, para recolectar lo que necesite, o ir al pueblo donde podrá comprar objetos e interactuar y relacionarse con NPCs. Si bien es secundario al core loop, en ciertas zonas puede haber enemigos los cuales el jugador podrá derrotar utilizando hechizos. Dichos hechizos puede tener también otros usos ajenos al combate.
- **Género:** Life-sim, top-down, cozy RPG, gestión de tienda.
- **Referencias:** 
	- Estética inspirada en la subcultura y arquitectura gótica
	- Mecánicas generales y ambientación inspiradas en Stardew Valley y Little Witch in the Woods
	- Mecánica de precios y fama inspirado en la venta de objetos de Moonlighter
- **Público objetivo:** El juego se encuentra dirigido a un público entusiasta de experiencias "cozy", de una edad entre 18 y 26 años, fanáticos de la exploración y sesiones gratificantes con poco o nulo castigo ante errores.
- **Mecánicas principales:** Las mecánicas principales de Spellbound Tonics son:
	 1. Movimiento en 8 direcciones
	 2. Exploración y recolección 
	 3. Creación de pociones
	 4. Interacción con NPCs
	 5. Lanzamiento de hechizos (para combate u otros usos)
	 6. Gestión de tienda (venta de productos, mejoras)
	 7. Registro de materiales/recetas/pociones

### 2.3 Concepto del Juego
El juego toma lugar en un mundo moderno pero fantástico, con seres mitológicos y de fantasía, y sistemas como la magia.
La historia no está definida, ya que el juego empieza con Nyx (la bruja) asentándose en su nueva casa-tienda, y luego el jugador puede tomar distintos caminos según las relaciones que forme.
El "gancho" principal del gameplay es la creación de pociones (incluyendo el probar distintos materiales, descubrir sus efectos, y el registro de los mismos), su posterior venta y la progresión de modificar la tienda, inicialmente en mal estado, en una casa decorada, amplia y organizada a gusto del jugador. Además, este tipo de audiencias suele disfrutar profundamente el formar lazos con otros personajes y conocer más de ellos, descubriendo como se desenvuelven dichas relaciones.

### 2.4 Premisas del Videojuego
**Reglas fundamentales del diseño del proyecto:** 
- La base del progreso se encuentra en explorar y descubrir.
- No existe una "lose condition" ni castigos graves. Ante ciertos eventos, el jugador puede recibir leves penalizaciones que no detendrán ni evitarán su progreso.
- La ambientación debe transmitir paz y oscuridad pero de manera acogedora.
- Los NPCs deben tener configuraciones (personalidad, hábitos, etc) diferentes y generar interés en el jugador.
- El proceso de creación de pociones debe ser divertido y gratificante. 2 recetas diferentes pueden ser similares, pero no iguales. 
- Descubrir nuevas pociones y recetas debe ser entretenido, no frustrante. El jugador debe ser incitado a hacerlo y recompensando por ello mediante misiones, pedidos o valores de venta importantes.
- Las mejoras del jugador o la tienda deben ofrecer nuevas opciones al jugador y funcionar como un progreso real, no solamente algo estético.

### 2.5 Condiciones del Desarrollo
+ **Motor gráfico:** Godot 4.1.
+ **Control de versiones:** repositorio en Git con estructuración de branches para arte, documentos y código.
+ **Metodologías de trabajo:** metodología y planificación scrumban; iteraciones luego de implementar mecánicas, zonas o cambios grandes; comunicación sobre cambios en documentos, arte o diseño al resto del equipo.
+ **Documentación dinámica:** los documentos de diseño (GDD, ADD, TDD, etc.), ubicados en sus respectivos branches, deben ser utilizados como guías por el equipo, y modificadas según requiera el proyecto, por quien esté a cargo de cada área.
+ **Uso de assets:** se utilizarán assets públicos, principalmente gratuitos, pero se buscará reemplazar por assets propios en la medida de lo posible. 
### 2.6 Alcance del proyecto
Inicialmente, se entregará un prototipo, cuyo scope incluye:
- Personaje principal con sus debidas acciones
- Zona inicial del bosque y la tienda
- Exploración
- 6 ingredientes
- Sistema de creación de pociones (mezcla, detección de efectividad)
- La gestión de la tienda (etapa de venta, área del hogar, área de venta)
- NPCs **incompletos** (aparecen para comprar durante la fase de venta)

Como tareas de nivel medio-punta, se buscará incluir:
* 1 enemigo
* 1 hechizo
* Objetos decorativos
* NPC con diálogos y/o acciones
* Interacción con NPCs
* Ingredientes extras
* Sistema de registro de recetas

En milestones posteriores, se entregará un Vertical Slice, y luego se seguirá con el resto del desarrollo hasta concluir en una versión comercial, con todo el contenido final.

---

## 3. Diseño Detallado del Juego

### 3.1 Elementos del Juego
* **Personaje principal:** Nyx Sioux, una bruja que busca construir su vida en un nuevo pueblo a base de vender pociones
* **Materiales de pociones:** Materiales diversos, cada uno con efectos y rasgos distintivos que, al ser combinados, resultan en pociones varias.
* **Hechizos:** poderes únicos que le permiten al jugador derrotar enemigos y obtener ciertos tipos de materiales.
* **Enemigos:** En ciertas zonas, como cuevas y bosques, pueden encontrarse enemigos como slimes y espíritus. Derrotarlos proporciona distintos materiales.
* **Dinero:** obtenido a través de la vents de pociones, permite comprar materiales, realizar mejoras y obtener distintos tipos de objetos miscelaneos. Cada cierto tiempo, el jugador deberá pagar un alquiler sobre la tienda, o será penalizado.
* **Pociones:** pueden ser vendidas, o consumidas por el jugador para obtener distintos efectos.
* **Tienda:** La tienda también sirve como casa para el jugador. Dentro, puede vender pociones, dormir, guardar objetos, y más.
* **Aldeanos:** Distintos seres habitan la aldea cercana al pueblo. El jugador puede interactuar con ellos por ocio o misiones.
* **Fama:** la tienda mejora o empeora su fama a través de su decoración, ventas y precios. Una mayor fama atrae a más clientes, mientras que una fama mala hará que sea más difícil atraerlos.
* **Enciclopedia de recetas:** libro donde el jugador puede anotar recetas y hacer comentarios sobre las mismas

### 3.2 Reglas
* El juego se divide entre la fase de exploración y la fase de venta. El jugador decide cuando pasar de la primera a la segunda mediante un cartel en su tienda.
* El jugador no puede abandonar su tienda mientras está abierta.
* Cada ciertos días, se debe pagar un alquiler que irá aumentando en costo. De no pagarse, objetos varios serán retirados hasta llegar al valor debido. Esto funciona como una condición de derrota, pero leve.
* El jugador no puede conseguir materiales raros sin aventurarse en zonas nuevas y/o utilizar ciertos hechizos.
* Las pociones necesitan un mínimo de 2 ingredientes, con un máximo de 3.

### 3.3 Sistema de creación de pociones
**[Importante: sujeto a cambios y modificaciones, falta testeos y balanceamiento en umbrales y cantidades.]**
Para fabricar pociones, el jugador utilizará una mesa especial en la tienda. En la misma, podrá depositar los ingredientes a usar (mínimo de 2, máximo de 3).

**3.3.1 Ingredientes:**
Los diferentes ingredientes o materiales tienen propiedades, algunos 1 y otros 2.
Aquellos ingredientes con 1 propiedad tienen un 100% de efectividad, mientras que los que tienen 2, tienen una propiedad predominante y una secundaria. La propiedad predominante tiene una efectividad aleatoria dentro de un rango predefinido, y la secundaria tiene como efectividad el faltante para llegar al 100%. 
Ejemplos:
* Hierba medicinal (1 propiedad): curacion 100%
* Amapola (2 propiedades): curación 55-75%, debilidad 45-25% (según el faltante para llegar a 100%)
Al mismo tiempo, los ingredientes tienen una rareza que sirve para el cálculo de valor de la poción.

Ciertas propiedades son contrarias entre sí, y se restan o cancelan. En la mesa, el jugador puede ver la tabla de opuestos y la efectividad% de cada ingrediente.

**3.3.2 Pociones:***
La creación de pociones pasa por varios procesos. Primero, las propiedades de cada ingrediente a utilizar se reducen a la mitad. Luego, aquellos que sean iguales se suman, y los que sean opuestos se cancelan. Finalmente, aquellas efectividades que sobrepasen el umbral de 25% de efectividad serán aplicados a la poción final, y las que no, serán descartadas.

**Ejemplo:**
1. Amapola (rareza común, 60% de curación, 40% de  debilidad) + hierba medicinal (rareza común, 100% de curación)
2. Se reducen en un 50%: 30% de curación, 20% de debilidad + 50% curación 
3. Se suman los iguales: 80% de curación, 20% de debilidad
4. Umbral: curación pasa, debilidad se descarta
5. Poción final: poción de rareza común, curación con efectividad al 80%.

**Nota: los valores decimales se redondean al entero más cercano hacia arriba.** 

**3.3.3 Valor***
El valor **recomendado** de las pociones se evalúa según la efectividad y la rareza. Los números reales, asi como los valotes base, aún no han sido decididos, pero la rareza funcionará como un multiplicador al valor base. Al mismo tiempo, por cada 5% por encima del 50% de efectividad, el valor aumenta. El valor final será el precio sugerido, pero el jugador puede arriesgarse y subirlo, o bajarlo para atraer más fama.

**Nota: se evalúa dar más profundidad a las rarezas, mediante proporcionar más efectividad a aquellos ingredientes más raros.** 

### 3.4 Descripción de una sesión de juego
El jugador comienza en la pantalla de menú principal, donde puede ver las opciones, salir, o elegir su partida. Al entrar a su partida, comienza en la tienda. Saliendo de ella, se encuentra en el bosque principal, donde recogerá distintos tipos de objetos. El jugador también puede optar por recorrer el pueblo e interactuar con los NPCs. El jugador explora la zona hasta que decida volver a la tienda, donde irá a una mesa especial y abrirá el menú de creación de pociones. Una vez en el mismo, seleccionará los items a utilizar y creará una poción. Asi, descubrirá propiedades de dichos items, y si la receta es nueva, puede abrir su libro de registros para anotarla y hacer comentarios o etiquetarla. Al finalizar, el jugador pondrá sobre diferentes estantes las pociones que desea vender, les asignará un precio, y abrirá la tienda. Clientes comenzarán a entrar, y si aprueban el precio, compraran pociones. Si consideran que es muy alto, tendrán opiniones negativas y la fama de la tienda se verá afectada. Luego de un tiempo, o si el jugador se queda sin pociones para vender, la tienda cerrará automáticamente y el jugador podra volver a salir libremente. Finalmente, el jugador irá a la cama dentro de la tienda y terminará el día.

### 3.5 Estética y Experiencia del Jugador
Estéticamente, se busca formar un ambiente de relajación, donde el jugador sepa que no hay peligros capaces de arruinarle la partida y lo animen a explorar. Esto se logrará, principalmente, entre la música y una paleta de colores predominantemente sombría de tonos no intensos.
Las mecánicas de creación de pociones buscan que el jugador experimente un desafío en alcanzar una poción económicamente rentable, al mismo tiempo que, incluso sin lograr una muy buena poción, obtenga igualmente una recompensa. Esto motiva al jugador a experimentar y encontrar las recetas que más valor tengan, o que más le sirvan para su aventura, sin frustrarlo ante fallos pero tampoco recompensarlo de sobremanera.

---

## 4. Arte, Audio y Bocetos
**4.1 Bocetos de Pantalla / UI:** 
1. **Boceto de HUD:** 
![[Untitled 07-18-2026 08-03-15.png]]
Elementos: 
* Esquina superior izquierda: barra de vida y maná
* Esquina superior derecha: dinero actual
* Lateral izquierdo: Hechizo activo, y botones para cambiarlo
* Barra inferior: slots de items

2. **Menú Principal:** 
![[618686aa-c78e-4851-99bd-bd7f9ed38a86.png]]
Elementos:
* Botón de jugar: redirige a la pantalla de crear/cargar partida 
* Botón de opciones: ajustes del juego
* Botón de salir: cierra el juego

**4.2 Estilo Visual y Sonoro:** 
El proyecto cuenta con una estética Pixel-Art, y una paleta de colores con predominancia de tonos azules, violetas y rojos oscuros. 
La música se caracteriza por tener un ritmo tranquilo, sin frenetismo, pacífico y algo melancólico.
Los efectos de sonido varían según su enfoque: los botones y efectos de UI son cortos y suaves, los efectos de ambiente son persistentes (como sonidos de animales, viento o plantas), y los efectos de acciones (como moverse, hechizos, o recolectar objetos) son más audibles, pero igualmente cortos e instantáneos.