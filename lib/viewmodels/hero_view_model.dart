import 'package:aldea/locator.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/viewmodels/base_model.dart';

class HeroViewModel extends BaseModel{
final NavigationService _navigationService = locator<NavigationService>();


void popScreen(){
  _navigationService.pop();
}
}