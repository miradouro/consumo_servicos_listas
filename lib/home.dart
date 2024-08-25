import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _urlBase = "https://jsonplaceholder.typicode.com";

  void _recuperarPostagens(){


  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: _recuperarPostagens(),
      builder: (context, snapshot){
        String resultado;
        switch( snapshot.connectionState ){
          case ConnectionState.none:
          case ConnectionState.waiting:
            print("waiting");
            resultado = "Carregando...";
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            print("done");
            if( snapshot.hasError ){
              resultado = "Erro ao carregar os dados...";
            }else{
              double valor = snapshot.data!["USD"]["buy"];
              resultado = "Preço do BitCoin: ${valor.toString()}";
            }
            break;
        }

        return Center(
          child: Text(resultado),
        );
      },
    );
  }
}
