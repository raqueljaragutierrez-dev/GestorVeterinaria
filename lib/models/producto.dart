class Producto {
  //clase llamada producto, establece q informacion debe tener cada producto o servicio
  final int id; //final significa una vez asignado un valor no se puede volver a cambiar en ese objeto
  final String nombre;
  final String descripcion;
  final double precio;
  final String categoria;
  final String tipo;
  final String imagen;

  Producto({
    //el constructor crea los objetos d la clase, q es un producto concreto creado utilizando ese molde
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.categoria,
    required this.tipo,
    required this.imagen,
  });
}
