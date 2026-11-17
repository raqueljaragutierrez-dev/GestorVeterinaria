import 'package:flutter/material.dart';

//este archivo es la pantalla principal de VetCare
import 'agregar_producto_screen.dart'; //abre el formulario para agregar productos
import '../data/productos_iniciales.dart'; //obtiene los productos iniciales
import '../models/producto.dart'; //permite utilizar la clase producto
import '../widgets/tarjeta_producto.dart'; //muestra cada producto en una tarjeta
import '../widgets/encabezado.dart'; //muestra el encabezado

//StatefulWidget  permite actualizar la interfaz cuando cambia su estado mientras utilizamos la aplicacion
class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override //este metodo crea el objeto q administra el estado de la pantalla, CatalogoScreen define el widget y establece q tendra estado
  State<CatalogoScreen> createState() => _CatalogoScreenState(); //CatalogoScreenState administra ese estado y construye la interfaz
}

//esta clase contiene la informacion y los metodos q permiten q la pantalla funcione
class _CatalogoScreenState extends State<CatalogoScreen> {
  // Lista que contiene los productos y servicios del catálogo. es una lista modificable
  //List.from crea una lista independientebq si podemos modificar agregando nuevos elementos
  final List<Producto> productos = List.from(productosIniciales);
  //metodo q va a conectar el formulario con el catalogo
  //DENTRO DE ESTE METODO SE CALCULA ID ID DEL NUEVO PRODUCTO
  Future<void> _abrirFormulario() async {
    // Calculamos el siguiente identificador disponible.
    int nuevoId = productos.isEmpty
        ? 1
        : productos
                  .map(
                    (producto) => producto.id,
                  ) //recorre todos los productos de la lista y obtiene sus id
                  .reduce((a, b) => a > b ? a : b) + //compara los identificadores y obtiene el mayor, le suma 1 al mayor y tendra el nuevo id
              1;

    // Abrimos el formulario y esperamos el producto.Navigator.push() permite navegar desde la pantalla actual hacia otra
    final nuevoProducto = await Navigator.push<Producto>(
      //AQUI SE REFLEJA LA NAVEGACION ENTRE PANTALLAS
      //recibe el resultado de Navigator.po()
      //indica q esperamos recibir un objeto de esa clase Producto
      context,
      MaterialPageRoute(
        //es una clase d flutter q permite definir la ruta o trasmision hacia otra pantalla
        //aqui creamos la pantalla del formulario y le enviamos el identificador q calculamos, asi sabe q id debe asignarle al nuevo producto
        builder: (context) => AgregarProductoScreen(nuevoId: nuevoId),
      ),
    );

    // Si recibimos un producto, lo agregamos al catálogo.
    if (nuevoProducto != null) {
      setState(() {
        //le indica a flutter q el estado d esta pantalla cambio y debe reconstruir la interfaz para ese cambio
        productos.add(nuevoProducto); //add modifica la lista, le agrega el nuevoProducto a la lista productos
      });
    }
  }

  //CONSTRUCCION VISUAL DE LA PANTALLA
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VetCare'),
        centerTitle: true,
      ), //AppBar crea la barra superior

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          //permite desplazarse verticalmente cuando el contenido es mas alto q el espacio disponible
          child: Column(
            //organiza los componenes verticalmente, encabezado, titulo, descripcion, boton agregar, cuadricula tarjetas
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Encabezado(), //llamamos el widget del encabezado

              const SizedBox(height: 16),

              const Text(
                'Catálogo veterinario', //muestra el titulo principal
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'Productos y servicios para tus mascotas', //breve descripcion
                style: TextStyle(fontSize: 15),
              ),

              const SizedBox(height: 20),
              //crea el boton q permite abrir el formulario
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _abrirFormulario,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar producto o servicio'),
                ),
              ),

              const SizedBox(height: 16),
              //ADAPTAR EL CATALOGO AL TAMAÑO DE PANTALLA
              LayoutBuilder(
                //permite conocer el espacio disponible para un widget y construir su contenido segun ese espacio
                builder: (context, constraints) {
                  int columnas; //almacenara la cantidad d columnas q vamos a utilizar
                  //aqui se evalua el ancho disponible, adaptacion para celulares, tabletas y pantallas grandes
                  if (constraints.maxWidth < 600) {
                    columnas = 1;
                  } else if (constraints.maxWidth < 900) {
                    columnas = 2;
                  } else {
                    //si son 900 o mas 3 columnas
                    columnas = 3;
                  }
                  //mostrar las tarjetas, muestra los productos
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: productos
                        .length, //indica cuantas tarjetas debe construir
                    //configurar las columnas
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //permite establecer una cantidad fija d columnas
                      crossAxisCount: columnas, //utiliza la cantidad q calculamos con LayoutBuilder
                      crossAxisSpacing:
                          12, //deja espacio horizontal entre tarjetas
                      mainAxisSpacing:
                          12, //deja espacio vertical entre tarjetas
                      childAspectRatio: 0.75, //establece la proporcion entre el ancho y el alto d cada tarjeta
                    ),
                    //este bloque indica como se construye cada elemento de la cuadricula
                    itemBuilder: (context, index) {
                      final producto = productos[index]; //obtiene el producto q corresponde a la posicion actual de la lista

                      return TarjetaProducto(
                        producto: producto,
                      ); //crea una tarjeta y le envia el producto
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
