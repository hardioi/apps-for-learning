import 'package:di_clean_architecture_solid/feature/domain/entities/person_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PersonSearchState extends Equatable {
  const PersonSearchState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PersonSearchEmty extends PersonSearchState {}

class PersonSearchLoading extends PersonSearchState {}

class PersonSearchLoaded extends PersonSearchState {
  final List<PersonEntity> persons;

  const PersonSearchLoaded({required this.persons});

  @override
  // TODO: implement props
  List<Object?> get props => [persons];
}

class PersonSearchError extends PersonSearchState {
  final String message;

  PersonSearchError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
