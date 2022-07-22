void main(List<String> args) {


   
   Produto produtoNovo2 = Produto(id: '10', descricao: 'cafe');

  print(produtoNovo2.descricao);
  
}

class Produto{
   String id;
   String descricao;

  Produto({required this.id, required this.descricao});
}