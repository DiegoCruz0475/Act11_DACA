import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: InicioPage(),
    debugShowCheckedModeBanner: false,
    title: 'Yeyo Dwellings App',
  ));
}

// --- CONFIGURACIÓN DE COLORES ---
const Color azulPrimario = Color(0xFF0D47A1); // Azul formal oscuro
const Color azulLlamativo = Color(0xFF1976D2); // Azul vibrante
const Color cafeMenu = Color(0xFF6D4C41);      // Café para el botón lateral
const Color azulFondo = Color(0xFFF5F7FA);     // Fondo grisáceo azulado

// --- PANTALLA 1: INICIO ---
class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: azulFondo,
      appBar: AppBar(
        title: const Text(
          'Inicio',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: azulPrimario,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Fila: Vendedores + Botón Café Desplegable
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: _buildMenuButton(context, "Vendedores", Icons.people, azulLlamativo, null),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: _buildBotonCafe(),
                  ),
                ],
              ),

              // Botones principales en orden
              _buildMenuButton(context, "Casas en venta", Icons.sell, azulLlamativo, null),
              _buildMenuButton(context, "Casas en renta", Icons.key, azulLlamativo, const CasasRentaPage()),
              _buildMenuButton(context, "Contacto", Icons.contact_mail, azulLlamativo, null),
              _buildMenuButton(context, "Agendar cita", Icons.calendar_today, azulPrimario, null),

              const SizedBox(height: 50),

              // Pie de página con imagen de casa centrada
              const Center(
                child: Column(
                  children: [
                    Text(
                      "Yeyo Dwellings",
                      style: TextStyle(
                        color: azulPrimario,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image(
                        image: NetworkImage('https://images.unsplash.com/photo-1568605114967-8130f3a36994?q=80&w=500'),
                        width: 260,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para botones de menú
  Widget _buildMenuButton(BuildContext context, String texto, IconData icono, Color color, Widget? destino) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ElevatedButton.icon(
        onPressed: () {
          if (destino != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => destino));
          }
        },
        icon: Icon(icono, color: Colors.white),
        label: Text(texto, style: const TextStyle(color: Colors.white, fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
        ),
      ),
    );
  }

  // Botón café (1/6 del tamaño)
  Widget _buildBotonCafe() {
    return Container(
      height: 58,
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: cafeMenu,
        borderRadius: BorderRadius.circular(12),
      ),
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, color: Colors.white),
        itemBuilder: (context) => [
          const PopupMenuItem(child: Text("Configuración")),
          const PopupMenuItem(child: Text("Filtros")),
        ],
      ),
    );
  }
}

// --- PANTALLA 2: CASAS RENTA ---
class CasasRentaPage extends StatelessWidget {
  const CasasRentaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: azulFondo,
      appBar: AppBar(
        title: const Text(
          'Casas en Renta',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: azulPrimario,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Botón de navegación (Pequeño café a la derecha)
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: cafeMenu,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.tune, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),

          // Listado de casas
          _buildCasaCard(
            "Residencial Los Olivos",
            "\$12,500",
            "\$10,000",
            "Juan Pérez",
            "Av. de la Raza #123",
            "https://images.unsplash.com/photo-1570129477492-45c003edd2be?q=80&w=400",
          ),
          _buildCasaCard(
            "Villa del Sol",
            "\$8,900",
            "\$8,900",
            "Maria Garcia",
            "Col. Jardines, Calle 5",
            "https://images.unsplash.com/photo-1583608205776-bfd35f0d9f83?q=80&w=400",
          ),
          _buildCasaCard(
            "Loft Moderno",
            "\$15,000",
            "\$15,000",
            "Inmobiliaria Yeyo",
            "Zona Centro, Edificio A",
            "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=400",
          ),
        ],
      ),
    );
  }

  // Widget para cada contenedor de casa
  Widget _buildCasaCard(String nombre, String precio, String deposito, String vendedor, String ubicacion, String url) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
        ],
      ),
      child: Row(
        children: [
          // Imagen Izquierda Circular
          Container(
            width: 85,
            height: 85,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: azulPrimario.withOpacity(0.5), width: 2),
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),

          // Datos de la casa (Derecha)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título azul, fondo blanco, borde negro
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    nombre,
                    style: const TextStyle(
                      color: azulPrimario,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text("Precio/mes: $precio", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                Text("Depósito: $deposito", style: const TextStyle(fontSize: 12)),
                Text("Vendedor: $vendedor", style: const TextStyle(fontSize: 12)),
                Text("Ubicación: $ubicacion", 
                  style: const TextStyle(fontSize: 11, color: Colors.grey, fontStyle: FontStyle.italic),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}