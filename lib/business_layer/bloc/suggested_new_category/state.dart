part of 'suggested_topics_bloc.dart';

class SuggestedTopicsState {}

class SuggestedTopicsLoading extends SuggestedTopicsState {}

class SuggestedTopicsInitial extends SuggestedTopicsState {}

class SuggestedTopicsLoaded extends SuggestedTopicsState {
  final List<SuggestedTopic> suggestedTopics;
  SuggestedTopicsLoaded({required this.suggestedTopics});
}

class SuggestedTopicsError extends SuggestedTopicsState {}

class SuggestedTopicsNetworkError extends SuggestedTopicsState {}
