import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _itens = [];

  void _carregarItens(){


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Lista"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, indice){
            print("item ${indice}");
            return ListTile(
              title: Text( indice.toString()),
              subtitle: const Text("subtitulo"),
            );
          },
        ),
      ),
    );
  }
}
