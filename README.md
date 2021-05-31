# Marvel Technical Test

Prueba técnica usando Clean Swift como patrón de arquitectura.

Se obtienen los datos del Api de Marvel, para mostrar un listado paginado de los personajes (celdas con tamaño dinámico basado en su contenido), y el detalle de cada personaje seleccionado desde el listado previo.

# Librerías utilizadas: 

Alamofire, SwiftyJSON para las conexiones de Api-rest y su parseo.
Alamofire-image para la caché de las imágenes y mostrarlas tipo lazy. 
SkeletonView y JGProgressHUD para indicar y amenizar los progresos de carga tanto en el listado como en el detalle.
