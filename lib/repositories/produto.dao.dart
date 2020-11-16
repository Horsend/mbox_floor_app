
import 'package:floor/floor.dart';
import 'package:mbox_floor_app/models/produto.model.dart';

@dao
abstract class ProdutoDao{
  @Query('SELECT * FROM Produto order by concluido, nome')
  Future<List<Produto>> getAll();
  @Query("SELECT * from Produto where id = :id")
  Future<Produto> getProdutoById(int id);
  @insert
  Future<int> insertProduto(Produto p);
  @update
  Future<int> updateProduto(Produto p);
  @delete
  Future<int> deleteProduto(Produto p);
}
