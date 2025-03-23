# Scripts de Consulta

- [scriptconsulta4.1.sql](https://github.com/joshuacorraless/Caso-1--Entregable-2/blob/main/scriptconsulta4.1.sql)
- [scriptconsulta4.2.sql](https://github.com/joshuacorraless/Caso-1--Entregable-2/blob/main/scriptconsulta4.2.sql)
- [scriptconsulta4.3.sql](https://github.com/joshuacorraless/Caso-1--Entregable-2/blob/main/scriptconsulta4.3.sql)
- [scriptconsulta4.4.sql](https://github.com/joshuacorraless/Caso-1--Entregable-2/blob/main/scriptconsulta4.4.sql)

## Tabla Script Consulta 4.1
| full_name             | email                          | country        | total_paid_colones |
|-----------------------|--------------------------------|----------------|--------------------|
| Adrián Rojas          | adrián.rojas@example.com       | Panamá         | 7964.03            |
| Alberto Salazar       | alberto.salazar@example.com    | Estados Unidos | 13285.78           |
| Andrés Ramírez        | andrés.ramírez@example.com     | México         | 5838.75            |
| Carlos Aguilar        | carlos.aguilar@example.com     | México         | 8381.05            |
| Daniel Quesada        | daniel.quesada@example.com     | Costa Rica     | 1711.73            |
| David López           | david.lópez@example.com        | México         | 981.79             |
| Diego Navarro         | diego.navarro@example.com      | México         | 5927.63            |
| Edgar Cordero         | edgar.cordero@example.com      | Costa Rica     | 5130.59            |
| Esteban Gómez         | esteban.gómez@example.com      | Guatemala      | 1365.94            |
| Felipe Soto           | felipe.soto@example.com        | Guatemala      | 1536.35            |
| Fernando Porras       | fernando.porras@example.com    | Costa Rica     | 2991.45            |
| Gustavo Hernández     | gustavo.hernández@example.com  | Costa Rica     | 2490.01            |
| Jorge Alvarado        | jorge.alvarado@example.com     | México         | 5280.99            |
| Joshua Jiménez        | joshua.jiménez@example.com     | México         | 7774.26            |
| José Chaves           | josé.chaves@example.com        | Guatemala      | 4182.39            |
| Juan Vargas           | juan.vargas@example.com        | Panamá         | 8555.97            |
| Luis Castro           | luis.castro@example.com        | Guatemala      | 840.73             |
| Marco Bolaños         | marco.bolaños@example.com      | México         | 6224.83            |
| Mario González        | mario.gonzález@example.com     | México         | 6562.47            |
| Oscar Barquero        | oscar.barquero@example.com     | México         | 3125.57            |
| Pedro Calderón        | pepe.mora@example.com          | México         | 6987.96            |
| Rodolfo Fernández     | rodolfo.fernández@example.com  | Costa Rica     | 3368.68            |
| Rodrigo Solano        | rodrigo.solano@example.com     | Costa Rica     | 4784.11            |


## Tabla Script Consulta 4.2
| full_name           | email                        | days_left |
|---------------------|------------------------------|-----------|
| Alberto Silva       | alberto.silva@example.com     | 11        |
| Andrés Rodriguez    | andrés.rodriguez@example.com  | 1         |
| Armando Mendoza     | armando.mendoza@example.com   | 8         |
| Carlos Sanchez      | carlos.sanchez@example.com    | 13        |
| David Romero        | david.romero@example.com      | 2         |
| Diego Fernandez     | diego.fernandez@example.com   | 7         |
| Eduardo Vargas      | eduardo.vargas@example.com    | 6         |
| Felipe Ramirez      | felipe.ramirez@example.com    | 6         |
| Francisco Garcia    | francisco.garcia@example.com  | 1         |
| Guillermo Morales   | guillermo.morales@example.com | 11        |
| José Lopez          | josé.lopez@example.com        | 6         |
| Juan Martinez       | juan.martinez@example.com     | 5         |
| Manuel Diaz         | manuel.diaz@example.com       | 1         |
| Martin Castro       | martin.castro@example.com     | 5         |
| Oscar Rivera        | oscar.rivera@example.com      | 6         |
| Pedro Gomez         | pedro.gomez@example.com       | 3         |


## Tabla Script Consulta 4.3 (top 15 usuarios más activos)
| userid | full_name             | login_count |
|--------|-----------------------|-------------|
| 57     | Raul Alvarez          | 30          |
| 55     | Ricardo Torres        | 29          |
| 41     | Roberto Perez         | 29          |
| 16     | Jorge Alvarado        | 29          |
| 48     | Andrés Rodriguez      | 28          |
| 34     | Diego Fernandez       | 28          |
| 43     | Sergio Ruiz           | 27          |
| 54     | Alberto Silva         | 26          |
| 53     | David Romero          | 26          |
| 50     | José Lopez            | 26          |
| 49     | Armando Mendoza       | 26          |
| 42     | Pedro Gomez           | 25          |
| 10     | David López           | 25          |
| 12     | Gustavo Hernández     | 25          |
| 28     | Andrés Rodríguez      | 25          |

## Tabla Script Consulta 4.3 (top 15 usuarios menos activos)
| userid | full_name             | login_count |
|--------|-----------------------|-------------|
| 1      | Charlie Sánchez       | 10          |
| 63     | Sergio Ruiz           | 12          |
| 54     | Diego Fernandez       | 13          |
| 30     | José Lopez            | 15          |
| 27     | Carlos Aguilar        | 15          |
| 8      | Luis Castro           | 16          |
| 5      | Joshua Jiménez        | 17          |
| 39     | Felipe Ramirez        | 17          |
| 18     | Andrés Ramírez        | 17          |
| 38     | Alberto Silva         | 17          |
| 15     | Alberto Salazar       | 17          |
| 11     | Rodolfo Fernández     | 17          |
| 6      | José Chaves           | 18          |
| 13     | Adrián Rojas          | 18          |


## Tabla Script Consulta 4.4 
(la tabla se ordena por prioridad de ocurrencias en la fecha, y luego por fecha de más reciente a más antigua)
| Fecha      | tipo Error                               | Ocurrencias |
|------------|------------------------------------------|----------|
| 2025-02-21 | Alucinaciones de la IA                   | 5        | 
| 2023-10-23 | Problemas con acentos o dialectos        | 4        | 
| 2023-10-21 | Falla en reconocer nombres de proveedores | 4        | 
| 2023-11-18 | Ruido ambiental                          | 4        | 
| 2023-11-13 | Confusión de comandos de voz             | 4        | 
| 2023-11-13 | Errores en fechas de pagos               | 3        | 
| 2023-10-30 | Problemas con acentos o dialectos        | 3        | 
| 2023-10-23 | Confusión de comandos de voz             | 3        | 
| 2025-03-16 | Malinterpretación de montos             | 3        | 
| 2025-03-16 | Confusión de comandos de voz             | 3        | 
| 2025-03-16 | Falla en reconocer nombres de proveedores | 3        | 
| 2025-03-16 | Errores en fechas de pagos               | 3        | 
| 2025-03-16 | Procesamiento de moneda extranjera       | 3        | 
| 2023-11-15 | Ruido ambiental                          | 3        | 
| 2023-11-13 | Errores en identificación de cuentas    | 2        | 
| 2025-03-16 | Malinterpretación de montos             | 2        | 
| 2025-03-16 | Falta de contexto                        | 2        | 
| 2025-03-16 | Errores en identificación de cuentas    | 2        | 
| 2025-03-16 | Ruido ambiental                          | 2        | 
| 2025-03-02 | Alucinaciones de la IA                   | 2        | 
| 2025-03-02 | Malinterpretación de montos             | 2        | 
| 2023-10-21 | Problemas con acentos o dialectos        | 2        | 
| 2025-03-02 | Alucinaciones de la IA                   | 2        | 


