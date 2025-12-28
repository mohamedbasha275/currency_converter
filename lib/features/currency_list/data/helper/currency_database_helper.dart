import 'package:currency_converter/features/currency_list/data/models/currency_list_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CurrencyDatabaseHelper {
  static final CurrencyDatabaseHelper instance = CurrencyDatabaseHelper._init();
  static Database? _database;

  CurrencyDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('currencies.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE currencies (
        id $idType,
        code $textType UNIQUE,
        name $textType,
        symbol $textType,
        flagUrl $textType,
        createdAt $textType
      )
    ''');

    // Create index for faster searches
    await db.execute('''
      CREATE INDEX idx_currency_code ON currencies(code)
    ''');
  }

  Future<void> insertCurrencies(List<CurrencyListModel> currencies) async {
    final db = await database;
    final batch = db.batch();
    final timestamp = DateTime.now().toIso8601String();

    for (var currency in currencies) {
      batch.insert(
        'currencies',
        {
          'code': currency.code,
          'name': currency.name,
          'symbol': currency.symbol,
          'flagUrl': currency.flagUrl,
          'createdAt': timestamp,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }


  Future<List<CurrencyListModel>> getCurrencies() async {
    final db = await database;
    final result = await db.query(
      'currencies',
      orderBy: 'code ASC',
    );

    return result.map((json) => CurrencyListModel.fromJson(json)).toList();
  }


  Future<bool> hasCurrencies() async {
    final db = await database;
    final result = await db.query(
      'currencies',
      columns: ['COUNT(*) as count'],
    );
    
    final count = Sqflite.firstIntValue(result) ?? 0;
    return count > 0;
  }


  Future<void> clearCurrencies() async {
    final db = await database;
    await db.delete('currencies');
  }


  Future<List<CurrencyListModel>> searchCurrencies(String query) async {
    final db = await database;
    final result = await db.query(
      'currencies',
      where: 'code LIKE ? OR name LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'code ASC',
    );

    return result.map((json) => CurrencyListModel.fromJson(json)).toList();
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}

