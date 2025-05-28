import 'dart:async';


import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:startup_chatbot/model/conversation.dart';

class SqlManipulation {
  Database? _database;
  final _dbName = 'conversations.db';

  // Initialize database
  Future<Database> get database async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), _dbName);
      print('Initializing database at path: $path'); // Debug log

      return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          print('Creating conversation table...'); // Debug log
          await db.execute('''
            CREATE TABLE IF NOT EXISTS conversation (
              id TEXT PRIMARY KEY,
              text TEXT NOT NULL,
              authorid TEXT NOT NULL
            )
          ''');
          print('Table created successfully'); // Debug log
        },
        onOpen: (db) {
          print('Database opened successfully'); // Debug log
        },
      );
    } catch (e) {
      print('Error initializing database: $e');
      rethrow;
    }
  }

  // Modified insert method with better error handling
  Future<void> InsertConversation(ChatMessge message) async {
    Database? db;
    try {
      db = await database;
      if (!db.isOpen) {
        throw Exception('Database is not open');
      }

      final Map<String, dynamic> messageMap = {
        'id': message.id,
        'text': message.text,
        'authorid': message.author.id,
      };

      print('Inserting message: $messageMap'); // Debug log

      await db.insert(
        'conversation',
        messageMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Message inserted successfully'); // Debug log
    } catch (e) {
      print('Error inserting conversation: $e');
      throw Exception('Failed to insert conversation: $e');
    }
  }

  Future<List<types.Message>> getConversations() async {
    try {
      final db = await database;
      print('Fetching conversations from database...'); // Debug log
      final List<Map<String, dynamic>> maps = await db.query('conversation');
      print('Found ${maps.length} conversations'); // Debug log

      return maps.map((map) {
        print('Converting message: $map'); // Debug log
        return types.TextMessage(
          id: map['id'] as String,
          text: map['text'] as String,
          author: types.User(id: map['authorid'] as String),
          createdAt: DateTime.now().millisecondsSinceEpoch,
        );
      }).toList();
    } catch (e) {
      print('Error getting conversations: $e');
      return [];
    }
  }

  // Add dispose method to properly close the database
  Future<void> dispose() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
    }
  }

  delete() async {
    try {
      final db = await database;
      print('Deleting all conversations from database...'); // Debug log
      await db.delete('conversation');
      print('All conversations deleted successfully'); // Debug log
    } catch (e) {
      print('Error deleting conversations: $e');
    }
  }

  Future<void> deleteConversation(List<types.Message> mesages ) async {
    try {
      final db = await database;
      print('Deleting specific conversations from database...'); // Debug log

      for (var message in mesages) {
        print('Deleting message with id: ${message.id}'); // Debug log
        await db.delete(
          'conversation',
          where: 'id = ?',
          whereArgs: [message.id],
        );
      }
      print('Specific conversations deleted successfully'); // Debug log
    } catch (e) {
      print('Error deleting specific conversations: $e');
    }







  }
}
