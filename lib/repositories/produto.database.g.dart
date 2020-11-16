// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto.database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProdutoDao _produtoDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Produto` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `nome` TEXT, `concluido` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProdutoDao get produtoDao {
    return _produtoDaoInstance ??= _$ProdutoDao(database, changeListener);
  }
}

class _$ProdutoDao extends ProdutoDao {
  _$ProdutoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _produtoInsertionAdapter = InsertionAdapter(
            database,
            'Produto',
            (Produto item) => <String, dynamic>{
                  'id': item.id,
                  'nome': item.nome,
                  'concluido':
                      item.concluido == null ? null : (item.concluido ? 1 : 0)
                }),
        _produtoUpdateAdapter = UpdateAdapter(
            database,
            'Produto',
            ['id'],
            (Produto item) => <String, dynamic>{
                  'id': item.id,
                  'nome': item.nome,
                  'concluido':
                      item.concluido == null ? null : (item.concluido ? 1 : 0)
                }),
        _produtoDeletionAdapter = DeletionAdapter(
            database,
            'Produto',
            ['id'],
            (Produto item) => <String, dynamic>{
                  'id': item.id,
                  'nome': item.nome,
                  'concluido':
                      item.concluido == null ? null : (item.concluido ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Produto> _produtoInsertionAdapter;

  final UpdateAdapter<Produto> _produtoUpdateAdapter;

  final DeletionAdapter<Produto> _produtoDeletionAdapter;

  @override
  Future<List<Produto>> getAll() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Produto order by concluido, nome',
        mapper: (Map<String, dynamic> row) => Produto(
            id: row['id'] as int,
            nome: row['nome'] as String,
            concluido: row['concluido'] == null
                ? null
                : (row['concluido'] as int) != 0));
  }

  @override
  Future<Produto> getProdutoById(int id) async {
    return _queryAdapter.query('SELECT * from Produto where id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Produto(
            id: row['id'] as int,
            nome: row['nome'] as String,
            concluido: row['concluido'] == null
                ? null
                : (row['concluido'] as int) != 0));
  }

  @override
  Future<int> insertProduto(Produto p) {
    return _produtoInsertionAdapter.insertAndReturnId(
        p, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateProduto(Produto p) {
    return _produtoUpdateAdapter.updateAndReturnChangedRows(
        p, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteProduto(Produto p) {
    return _produtoDeletionAdapter.deleteAndReturnChangedRows(p);
  }
}
