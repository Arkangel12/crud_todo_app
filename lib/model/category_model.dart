import 'package:equatable/equatable.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class Category extends Equatable {
  const Category({
    this.id,
    required this.name,
    required this.emoji,
    this.todoSize,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as String?,
        name: json['name'] as String,
        emoji: EmojiParser().get(json['emoji'] as String),
        todoSize: (json['todoSize'] as int?) ?? 0,
      );

  final String? id;
  final String name;
  final Emoji emoji;
  final int? todoSize;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'emoji': emoji.full,
        'todoSize': todoSize ?? 0
      };

  @override
  List<Object?> get props => [id, name, emoji, todoSize];
}
