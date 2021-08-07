import 'package:equatable/equatable.dart';

abstract class AlarmEvent extends Equatable{
  final String? path;
  const AlarmEvent(this.path);
  
  @override
  List<Object?> get props => [path];
}

class LoadSoundTrack extends AlarmEvent{
  LoadSoundTrack(String path) : super(path);
  
}