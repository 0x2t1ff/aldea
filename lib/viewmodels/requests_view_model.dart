import 'package:aldea/models/community_request.dart';
import 'package:aldea/viewmodels/base_model.dart';

class RequestsViewModel extends BaseModel{
  final List<CommunityRequest> requests;

  RequestsViewModel(this.requests);
}