import 'package:dust_app/model/state_model.dart';
import 'package:dust_app/model/status_model.dart';

class StateAndStatusModel{
  final ItemCode itemCode;
  final StatusModel status;
  final StateModel state;

  const StateAndStatusModel({
    required this.itemCode,
    required this.status,
    required this.state,
  });
}