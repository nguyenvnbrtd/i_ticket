import 'package:uuid/uuid.dart';

class UniqueIdGenerator{
  static final UniqueIdGenerator _instance = UniqueIdGenerator._internal();

  factory UniqueIdGenerator() => _instance;

  UniqueIdGenerator._internal();

  static const _uuid = Uuid();

  static String get uniqueId => _uuid.v1();
}