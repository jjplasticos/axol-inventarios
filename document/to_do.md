## To do
---
### 30/11/2023
- [x] ui: Desbordamiento en "View Alamcen" 
  - Clave: #001
  - Detección: 30/11/2023
  - Resolución: 30/11/2023
  - Reproducción: Al minimizar ventana de la view
  - Ubicación: /lib/../inventory/view/views/warehouse_view.dart

### 06/12/2023
- [x] fix: Error en indicación de estado stock
  - Descripción: Indica mensaje de "sin stock" cuando se pretende realizar una entrada.
  - Clave: #002
  - Detección: 06/12/2023
  - Resolución: 06/12/2023
  - Reproducción: al intentar ingresar una entrada con una cantidad mayor al stock actual.
  - Ubicación: lib\plugins\inventory_\inventory\view\widgets\inventory_movement\listview_inventory_movement.dart

- [ ] fix: Crea la salida aún cuando no se cuenta con stock de un producto
  - Clave: #003
  - Detección: 06/12/2023
  - Resolución: ------
  - Reproducción: al agregar un movimiento de entrada con un producto que se encuentra sin stock
  - Ubicación: lib\plugins\inventory_\inventory\view\widgets\inventory_movement\

- [ ] perf: Cambiár logica de verificación se stock.
  - Clave: #perf001
  - Detección: 06/12/2023
  - Resolusión: ------
  - Descripción: para la actualización del cubit encargada de mostrar los datos en pantalla, se utiliza diferente metodo para cada acción. Se debe de cambiar para usar el mismo metodo para todas las acciones de la view que involucren, la actualización de los datos en pantalla.