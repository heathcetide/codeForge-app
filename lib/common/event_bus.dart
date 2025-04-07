import 'package:event_bus/event_bus.dart';

// Create a global instance of EventBus
EventBus eventBus = EventBus();

// Define your events
class CustomEvent {
  final String message;
  CustomEvent(this.message);
}

// Usage example:
// To fire an event: eventBus.fire(CustomEvent('Hello EventBus!'));
// To listen to an event:
// eventBus.on<CustomEvent>().listen((event) {
//   print(event.message);
// });
//使用示例：
//触发事件：eventBus.fire(CustomEvent('Hello EventBus!'));
//监听事件：eventBus.on<CustomEvent>().listen((event) { print(event.message); });
