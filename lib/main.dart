import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:telephony/telephony.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(BotaoPanicoApp());

class BotaoPanicoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaPanico(),
    );
  }
}

class TelaPanico extends StatefulWidget {
  @override
  _TelaPanicoState createState() => _TelaPanicoState();
}

class _TelaPanicoState extends State<TelaPanico> {
  final Telephony telephony = Telephony.instance;
  List<String> numerosEmergencia = [];

  @override
  void initState() {
    super.initState();
    carregarNumeros();
  }

  Future<void> carregarNumeros() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      numerosEmergencia = prefs.getStringList('numeros') ?? [];
    });
  }

  Future<bool> pedirPermissoes() async {
    final permissoes = await [
      Permission.location,
      Permission.sms,
    ].request();

    return permissoes.values.every((perm) => perm.isGranted);
  }

  Future<void> enviarSMScomLocalizacao() async {
    Position posicao = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    String mensagem =
        "🚨 AJUDA! Estou em perigo! Minha localização: https://www.google.com/maps/search/?api=1&query=${posicao.latitude},${posicao.longitude}";

    for (String numero in numerosEmergencia) {
      await telephony.sendSms(to: numero, message: mensagem);
    }
  }

  void ativarBotaoPanico() async {
    bool permissoesOK = await pedirPermissoes();

    if (permissoesOK && numerosEmergencia.isNotEmpty) {
      enviarSMScomLocalizacao();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("🚨 Alerta enviado com sucesso!")),
      );
    } else if (numerosEmergencia.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Nenhum número cadastrado!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("🚫 Permissões não concedidas!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.redAccent),
              child: Text(
                'Configurações',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Gerenciar Números'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConfiguracaoNumeros())).then(
                    (_) => carregarNumeros());
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Botão de Pânico'),
      ),
      backgroundColor: Colors.redAccent,
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: Colors.white,
            minimumSize: Size(250, 250),
            elevation: 10,
          ),
          child: Text(
            'SOS',
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          onPressed: ativarBotaoPanico,
        ),
      ),
    );
  }
}

class ConfiguracaoNumeros extends StatefulWidget {
  @override
  _ConfiguracaoNumerosState createState() => _ConfiguracaoNumerosState();
}

class _ConfiguracaoNumerosState extends State<ConfiguracaoNumeros> {
  final TextEditingController controllerNumero = TextEditingController();
  List<String> numeros = [];

  @override
  void initState() {
    super.initState();
    carregarNumeros();
  }

  Future<void> carregarNumeros() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      numeros = prefs.getStringList('numeros') ?? [];
    });
  }

  Future<void> salvarNumero(String numero) async {
    final prefs = await SharedPreferences.getInstance();
    if (numero.isNotEmpty && !numeros.contains(numero)) {
      numeros.add(numero);
      await prefs.setStringList('numeros', numeros);
      setState(() {});
      controllerNumero.clear();
    }
  }

  Future<void> removerNumero(String numero) async {
    final prefs = await SharedPreferences.getInstance();
    numeros.remove(numero);
    await prefs.setStringList('numeros', numeros);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Números de Emergência'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controllerNumero,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  labelText: 'Adicionar número',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => salvarNumero(controllerNumero.text),
                  )),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: numeros.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(numeros[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => removerNumero(numeros[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
