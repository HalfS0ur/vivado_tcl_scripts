# vivado_tcl_scripts
Herramientas para ejecutar vivado en tcl basadas en el repositorio https://github.com/pmendozap/vivado_tcl_tec

## Requisitos
Para correr estas herramientas se necesita de:
1. Instalar Xilinx Vivado (Las herramientas fueron diseñadas en la versión 2019.1)
2. Si se usa en ambiente Windows:
    a. Instalar GNU Make para windows. Una opción es: https://gnuwin32.sourceforge.net/packages.html

    b. GTKWave: visualizador ligero de curvas de simulación. Es un visualizador alternativo al de Vivado y es opcional para estos scripts. Descargar para windows en: https://gtkwave.sourceforge.net/
    
    c. Asegurarse de que los ejecutables de Vivado y Make están en el PATH de windows:

    - En el menú de inicio buscar por:
        - "Variables de entorno" si es en español
        - "Environment variables" si es en inglés
    - En la sección de variables de usuario (panel superior) buscar por `path`

    - Click en `editar` y luego en `nuevo`
    - Insertar la dirección de los binarios de Vivado. Ejemplo:
        - Si Vivado está instalado en `c:\xilinx\Vivado` y se tiene la versión 2019.1, entonces usar:
        `C:\Xilinx\Vivado\2019.1\bin`
    - Volver a agregar un nuevo campo y agregar la ruta para los ejecutables de windows 64 bits. Ejemplo:
        - Para los misma configuración anterior, se agregaría: `C:\Xilinx\Vivado\2019.1\lib\win64.o`
    
    - Agregar una nueva entrada con la ruta donde se guardó el ejecutable de Make (se descargó en un paso anterior)

    - Agregar una nueva entrada con la ruta donde se guardó el ejecutable de GTKWave (se descargó en un paso anterior)


    - Dar click en aceptar en las ventanas de manejo de variables.

    d. Probar que los setting funcionan:

    - Abrir power shell o cmd
    - Ejecutar `make -h`. Debe mostrar la ayuda de Make
    - Ejecutar `Vivado -h`. Debe mostrar la ayuda de Vivado.
    - (opcional) Ejecutar `gtkwave -h`. Debe mostrar la ayuda de Make
  
## Estructura del proyecto:
    ```
    PROJECT_NAME
        ├── .git
        ├── .gitignore
        ├── project_name.tcl         # Project generator script
        ├── src/                     # Tracked source files
        │   ├── design
        │   │    ├── *.v
        │   │    └── *.vhd
        │   ├── testbench
        │   │    ├── *.v
        │   │    └── *.vhd
        │   ├── blockdesign
        │   │    ├── ui
        │   │    ├── ip
        │   │    ├── *.bd
        │   │    └── ...
        │   └── ...
        └── vivado_project/          # Untracked generated files
            ├── project_name.xpr
            ├── project_name.cache/
            ├── project_name.hw/
            ├── project_name.sim/
            └── ...
    ```

## Forma de uso:

- El flujo propuesto consiste de dos juegos de scripts. 
    - El juego principal de scripts se encuentra en la carpeta `scripts`. Estos permiten la simulación y sintesis en diferentes niveles, además de una herramienta para programar la tarjeta FPGA. 
    - El segundo juego se usa a nivel de cada *subproyecto* y consiste de scripts para crear y actualizar los proyectos de Vivado, un script con variables globales relativas al subproyecto y un archivo de Make.

- La lista de archivos y su uso es:
    - **globals.tcl**: Encierra variables globales para un subproyecto. De los cambios más importantes que se deben aplicar es indicar el nombre del módulo TOP y del módulo de simulación. Una copia de este archivo debe ubicarse en la carpeta correspondiente al sub-proyecto. (ideado para estar en build/\<subproyecto\>)
    - **create_project.tcl**: Posee los comandos para poder crear el proyecto de Vivado correspondiente al sub-proyecto actual. Debe modificarse en caso de requerir usar IP-cores, o usar carpetas específicas para los fuentes. Además, se recomienda indicar explicitamente el archivo de constraints a usar. Una copia de este archivo debe ubicarse en la carpeta correspondiente al sub-proyecto. (ideado para estar en build/\<subproyecto\>)
    - **update_project.tcl**: Posee los comandos para poder actualizar el proyecto de Vivado correspondiente al sub-proyecto actual. Este archivo se usa para agregar nuevos archivos fuente a un sub-proyecto. Debe modificarse en caso de requerir usar IP-cores, o usar carpetas específicas para los fuentes. Además, se recomienda indicar explicitamente el archivo de constraints a usar. Una copia de este archivo debe ubicarse en la carpeta correspondiente al sub-proyecto. (ideado para estar en build/\<subproyecto\>)
    

    - **logic_synthesis.tcl**: Posee los comandos necesarios para realizar la síntesis lógica de un sub-proyecto. Este archivo se debe mantener en scripts sin modificar ya que es general para todos los sub-proyectos.

    - **physical_synthesis.tcl**: Posee los comandos necesarios para realizar la síntesis física (implementación) de un sub-proyecto. Este archivo se debe mantener en scripts sin modificar ya que es general para todos los sub-proyectos.

    - **program.tcl**: Posee los comandos necesarios para programar el archivo de configuración al FPGA. Este archivo se debe mantener en scripts sin modificar ya que es general para todos los sub-proyectos.

    - **behavioral_sim.tcl**: Posee los comandos necesarios ejecutar una simulación de comportamiento. Si la bandera de *GTKWave* está activa en el archivo `globals.tcl` entonces se hace uso del visualizador GTKWave en lugar de Vivado. Este archivo se debe mantener en scripts sin modificar ya que es general para todos los sub-proyectos.

    - **post_synthesis_timing_sim.tcl**: Posee los comandos necesarios ejecutar una simulación post-síntesis con temporización. Si la bandera de *GTKWave* está activa en el archivo `globals.tcl` entonces se hace uso del visualizador GTKWave en lugar de Vivado. Este archivo se debe mantener en scripts sin modificar ya que es general para todos los sub-proyectos.

    - **post_implementation_timing_sim.tcl**: Posee los comandos necesarios ejecutar una simulación post-implementación con temporización. Si la bandera de *GTKWave* está activa en el archivo `globals.tcl` entonces se hace uso del visualizador GTKWave en lugar de Vivado. Este archivo se debe mantener en scripts sin modificar ya que es general para todos los sub-proyectos.

    - **Makefile**: Se usa para ejecutar los diversos flujos de desarrollo.
    
- Por cada sub-proyecto, se debe crear una carpeta dentro de build. En esta carpeta se copian los archivos `globals.tcl`, `create_project.tcl`, `update_project.tcl` y `Makefile`. Estos archivos se deben adaptar al proyecto.

- Ejecutar por medio de `make` los diferentes flujos de desarrollo.

- El presente repositorio presenta un *subproyecto* ejemplo. Para correr este ejemplo basta con abrir una terminal de comandos y ejecutar alguna de las recetas en el Makefile. La lista de opciones disponibles para el ejemplo son:
    - `make create`: Crea el ambiente de Vivado para correr el flujo sobre los archivos fuente. 
    - `make update`: Actualiza el ambiente de Vivado para correr el flujo sobre los archivos

    - `make open`: Abre el proyecto en el GUI de Vivado.

    - `make logic_synth`: Ejecuta la síntesis lógica del proyecto actual.

    - `make phy_synth`: Ejecuta la síntesis física del proyecto actual.

    - `make program`: Programa la FPGA

    - `make behavioral_sim`: Ejecuta la simulación de comportamiento.

    - `make post_synth_sim`: Ejecuta la simulación post-síntesis.

    - `make post_imp_sim`: Ejecuta la simulación post-implementación.

    - `make flow`: Ejecuta el flujo de síntesis completo.

    - `make clean`: Límpia el ambiente de archivos temporales y del proyecto de Vivado.

    - `make`, `make all`: crea el proyecto, ejecuta el flujo de síntesis completo y abre Vivado.
