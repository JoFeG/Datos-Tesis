# Datos mrsat


El notebook `Datos.ipynb` tiene solo la llamada (en python) al csv antiguo, datos de 2022-06-16 a 2022-07-13.

El notebook `mrsat_API_load.ipynb` llama al servicio REST para curvas y grafica (en Julia).

---

## Servicio REST para Curvas


`GET {API}/status`  
Servicio para verificar el estado de la API  
Ejemplo: https://mrsat.test-citiaps.cl/status

`GET {API}/mrsat/areas`  
Retorna una lista con datos de las áreas disponibles  
Ejemplo: https://mrsat.test-citiaps.cl/mrsat/areas  
Retorno: `[{"id": 10500, "name": "Ayacara"}, {"id": 10502, "name": "Punta Colaco"}, … ]`  

`GET {API}/mrsat/analysis`  
Parámetro opcional: `area` (id, int)  
Retorna una lista con los Strings identificadores de análisis disponibles  
Ejemplo: https://mrsat.test-citiaps.cl/mrsat/analysis?area=10525  
Retorno: `["AZA", "DTX", "PTX_AO"," VAM", "VPM", "YTX"]`  

`GET {API}/mrsat/{area}/{analysis}/curves`  
Parámetros obligatorios: `area` (id, int), `analysis` (name, string upper-case)  
Parámetro opcional: `fill_type` ("fill_0", "fill_interpolated", “fill_not”)  
Parámetro opcional: `smooth_type` ("average_7", "average_15", "exponential_09", "exponential_05", "exponential_01")  
Parámetro opcional: `estimation_type` (“linear_05_01”, “linear_05_005”, “linear_05_002”. 05 indica 50% de los puntos usados para la tendencia. 01, 005 o 002 indican la fracción usada para definir el borde de la curva. Opciones adicionales podrían agregarse después)  
Retorna un json con los datos de múltiples curvas (“original”, “smooth” y opcionalmente “estimation”)  
Ejemplo: https://mrsat.test-citiaps.cl/mrsat/10345/YTX/curves?fill_type=fill_interpolated&smooth_type=exponential_01&estimation_type=linear_05_002  
Retorno: `{"original": {"name": "10345-YTX", "points": [{"x": 17899.0, "y": 0.0, "date": "2019-01-03"}, …]}, “smooth”: {"name": "10345-YTX-smooth", "points": [...]} }`  



Desplegado en citiaps@200.14.214.214  
Por ahora NO está dockerizado, sino instalado como servicio en ~/generic-estimation/, puerto 5560, redireccionado  a mrsat.test-citiaps.cl

