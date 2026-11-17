import 'package:flutter/material.dart'; // permite utilizar los componentes visuales de flutter, como container
//Text, Icon, Row, Column

//permite q el encabezado aaceda al proveedor de favoritos
import '../providers/provider_favoritos.dart';

//clase dond  extends StatelessWidget  indica q es un widget q no administra un estado mutable propio
//se utiliza StatelessWidget xq el encabezado no necesita modificar su propia informacion, el diseño es el mismo
class Encabezado extends StatelessWidget {
  const Encabezado({super.key}); //constructor no necsita recibir parametros, xq siempre muestra la misma estructura visula

  @override //indica q estamos sobreescribiendo un metodo heredado de StatelessWidget
  Widget build(BuildContext context) {
    //este metodo construye la interfaz visual del encabezado
    // Obtenemos el proveedor de favoritos.
    final favoritos = ProviderFavoritos.of(
      //lo guarda en la variable favoritos
      //permite consultar la informacion compartida de favoritos
      context,
    );
    //estructura principal, container es un componente q permite crear un espacio visual y personalizar demiensiones
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(16),
      ),
      //organiza los elementos verticalmente
      child: Column(
        //permite organizar varios componentes uno debajo del otro,una fila con el logo, nombre y contador y un texto descriptivo debajo
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            //organiza sus elementos horizontalmente uno al lado del otro
            children: [
              const Icon(Icons.pets, color: Colors.white, size: 32),
              //crea un espacio de 10 pixeles logicos entre el icono y el texto
              const SizedBox(width: 10),

              const Text(
                'VetCare',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(), //espacio
              //muesta un corazon blanco y deja un pequeño espacio antes del contador
              const Icon(Icons.favorite, color: Colors.white, size: 24),

              const SizedBox(width: 5),

              Text(
                //la propiedad cantidad devuelve el numero de elementos favoritos marcados
                '${favoritos.cantidad}', //es el objeto q obtuvimos del proveedor, canidad accede al getter de FavoritosProvider
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          //
          const SizedBox(height: 8),

          const Text(
            'Tu compañero en el cuidado de tus mascotas',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
