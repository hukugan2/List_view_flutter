import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? Key}) : super(key: Key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  List<String> listaProdutos =
      List<String>.generate(20, (i) => 'Produto ${i + 1}');

  Future<List<Produto>?> _getProdutos() async {
    Uri uri = Uri.parse(
        'https://api.json-generator.com/templates/UMReeO7FCeBY/data?access_token=0w97zihkb5hbcisy1edihvkd8ub8orkkuqauege6');

    print(listaProdutos.length);

    print(uri);

    var response = await http.get(uri);

    var dados = json.decode(response.body) as List;
    List<Produto> produtos = [];

    dados.forEach((elemento) {
      Produto produto = Produto(
        double.parse(elemento['preco']),
        elemento['imagem'],
        elemento['produto'],
        elemento['endereco'],
        elemento['descricao'],
        elemento['produto_id'],
        int.parse(elemento['quantidade']),
      );
      produtos.add(produto);
    });

    return produtos;
  }

  @override
  Widget build(BuildContext context) {
    /*
  listaProdutos.add('Produto 1');
  listaProdutos.add('Produto 2');
  listaProdutos.add('Produto 3');
  */

    /*
for(int i = 1; i <= 100; i++){

 listaProdutos.add('Produto $i');

}
 */

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('List View'),
        ),
        body: FutureBuilder(
            future: _getProdutos(),
       
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.data == null ){
                return Text('Carregando...');
              }else{

              

              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, indice) {
                    return ListTile(
                      title: Text('${snapshot.data[indice].produto}'),
                      onTap: () {
                        print(
                          'o produto selecionado foi ${snapshot.data[indice].produto}, na posição $indice');
                      },
                    );
                  }
                  );
              }
            }),
      ),
    );
  }
}

/*
{
    "preco": "874.78",
    "imagem": "http://placehold.it/128x128",
    "produto": "reprehenderit id culpa",
    "endereco": "Lois Avenue 31, Rossmore, Nevada",
    "descricao": "Id veniam ea ipsum pariatur voluptate. Amet fugiat deserunt laboris et sint excepteur voluptate dolor aute.",
    "produto_id": "62d973dbb7e1940a90fa3be3",
    "quantidade": "66"
  },

*/
class Produtos {
  final List produtos;

  Produtos(this.produtos);
}

class Produto {
final double preco;
 final String imagem;
 final String produto;
 final String endereco;
 final String descricao;
 final String produtoId;
 final int quantidade;

  Produto(this.preco, this.imagem, this.produto, this.endereco, this.descricao,
      this.produtoId, this.quantidade);

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      json['preco'],
      json['imagem'],
      json['produto'],
      json['endereco'],
      json['descricao'],
      json['produto_id'],
      json['quantidade'],
    );
  }

  Map<String, dynamic> toJson() => {
        'preco': preco,
        'imagem': imagem,
        'produto': produto,
        'endereco': endereco,
        'descricao': descricao,
        'produto_id': produtoId,
        'quantidade': quantidade,
      };
}
