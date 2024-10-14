import 'dart:async';

void main() {
  PomodoroTimer pomodoro = PomodoroTimer();
  pomodoro.start();
}

class PomodoroTimer {
  static const int workDuration = 25 * 60; // 25 minutes in seconds
  static const int shortBreakDuration = 5 * 60; // 5 minutes in seconds
  static const int longBreakDuration = 15 * 60; // 15 minutes in seconds
  int currentTime = workDuration;
  int pomodoroCount = 0;
  bool isWorking = true; // Indicates if it's work time
  Timer? timer;

  void start() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (currentTime > 0) {
        currentTime--;
        printTime();
      } else {
        if (isWorking) {
          pomodoroCount++;
          if (pomodoroCount % 4 == 0) {
            // After 4 Pomodoros, take a long break
            print('Pomodoro complete! Time for a long break.');
            currentTime = longBreakDuration;
          } else {
            // Take a short break after a work session
            print('Pomodoro complete! Time for a short break.');
            currentTime = shortBreakDuration;
          }
        } else {
          print('Break over! Back to work.');
          currentTime = workDuration;
        }
        isWorking = !isWorking;
      }
    });
  }

  void printTime() {
    int minutes = currentTime ~/ 60;
    int seconds = currentTime % 60;
    String formattedTime =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    print(
        isWorking ? 'Work Time: $formattedTime' : 'Break Time: $formattedTime');
  }
}
