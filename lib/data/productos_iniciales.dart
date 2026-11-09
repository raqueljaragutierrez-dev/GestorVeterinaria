import '../models/producto.dart'; //importa la clase producto

//datos locales, informacion para mostrar
final List<Producto> productosIniciales = [
  //crea una lista q contiene objetos d tipo Producto
  Producto(
    id: 1,
    nombre: 'Alimento para perros',
    descripcion: 'Alimento balanceado para perros adultos.',
    precio: 12500,
    categoria: 'Alimentos',
    tipo: 'Producto',
    imagen: 'assets/images/AlimentoPerro.png',
  ),
  Producto(
    id: 2,
    nombre: 'Alimento para gatos',
    descripcion: 'Alimento completo para gatos adultos.',
    precio: 8500,
    categoria: 'Alimentos',
    tipo: 'Producto',
    imagen: 'assets/images/AlimentoGato.png',
  ),
  Producto(
    id: 3,
    nombre: 'Baño para mascotas',
    descripcion: 'Servicio de baño e higiene para mascotas.',
    precio: 7000,
    categoria: 'Estética',
    tipo: 'Servicio',
    imagen: 'assets/images/BanoMascota.png',
  ),
  Producto(
    id: 4,
    nombre: 'Consulta veterinaria',
    descripcion: 'Servicio de valoración general de la mascota.',
    precio: 15000,
    categoria: 'Consultas',
    tipo: 'Servicio',
    imagen: 'assets/images/ConsultaVeterinaria.png',
  ),
];
