import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';

/// Sender type for chat messages
enum MessageSender {
  user,
  ai,
  system;

  bool get isUser => this == MessageSender.user;
  bool get isAi => this == MessageSender.ai;
  bool get isSystem => this == MessageSender.system;
}

/// Represents a chat message in the AI assistant conversation
@freezed
abstract class ChatMessage with _$ChatMessage {
  const ChatMessage._();

  const factory ChatMessage({
    required String id,
    required String content,
    required MessageSender sender,
    required DateTime timestamp,

    /// Optional context snapshot at the time of message
    @Default(null) GameContextSnapshot? context,

    /// Is this message still being streamed
    @Default(false) bool isStreaming,

    /// Error message if failed
    @Default(null) String? error,
  }) = _ChatMessage;

  /// Check if message has error
  bool get hasError => error != null;

  /// Get formatted timestamp
  String get formattedTime {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

/// Snapshot of game context at the time of chat message
@freezed
abstract class GameContextSnapshot with _$GameContextSnapshot {
  const GameContextSnapshot._();

  const factory GameContextSnapshot({
    /// Hero's hole cards as display strings (e.g., ['A♠', 'K♥'])
    @Default([]) List<String> heroCards,

    /// Board cards as display strings
    @Default([]) List<String> boardCards,

    /// Current board phase (preflop, flop, turn, river)
    @Default('preflop') String boardPhase,

    /// Number of opponents
    @Default(0) int opponentCount,

    /// Current pot size
    @Default(0) double potSize,

    /// Amount to call
    @Default(0) double amountToCall,

    /// Hero's calculated equity (if available)
    @Default(null) double? heroEquity,

    /// Pot odds ratio string
    @Default('-') String potOddsRatio,

    /// Required equity to call
    @Default(0) double requiredEquity,

    /// Hero's current hand rank (if board has cards)
    @Default(null) String? heroHandRank,
  }) = _GameContextSnapshot;

  /// Check if hero has cards
  bool get hasHeroCards => heroCards.length == 2;

  /// Check if there's a board
  bool get hasBoard => boardCards.isNotEmpty;

  /// Get summary string for display
  String get summary {
    if (!hasHeroCards) return 'No cards set';

    final cards = heroCards.join(' ');
    final phase = boardPhase[0].toUpperCase() + boardPhase.substring(1);
    final opponents = opponentCount == 1
        ? '1 opponent'
        : '$opponentCount opponents';

    return '$cards vs $opponents ($phase)';
  }
}

/// Quick action suggestion for the chat
@freezed
abstract class QuickAction with _$QuickAction {
  const factory QuickAction({
    required String label,
    required String prompt,
    @Default(null) String? icon,
  }) = _QuickAction;
}
