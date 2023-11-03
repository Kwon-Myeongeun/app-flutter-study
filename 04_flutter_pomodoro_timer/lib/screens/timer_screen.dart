import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pomodoro_timer/tools/utils.dart';

enum TimerStatus { running, paused, stopped, resting }

class TimerScreen extends StatefulWidget {
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  //집중 시간
  static const WORK_SECONDS = 3;

  //휴식 시간
  static const REST_SECONDS = 2;

  //현재 타이머 상태
  late TimerStatus _timerStatus;

  //현재 타이머 시간
  late int _timer;

  //완료된 뽀모도로 횟수
  late int _pomodoroCount;

  //State 초기화
  @override
  void initState() {
    super.initState();
    _timerStatus = TimerStatus.stopped;
    print(_timerStatus.toString());
    _timer = WORK_SECONDS;
    _pomodoroCount = 0;
  }

  void run() {
    //현재 타이머 상태 State 변경
    setState(() {
      _timerStatus = TimerStatus.running;
      print("[=>] " + _timerStatus.toString());
      runTimer();
    });
  }

  void rest() {
    //현재 타이머 상태 State 변경
    //현재 타이머 시간을 휴식 시간으로 변경
    setState(() {
      _timer = REST_SECONDS;
      _timerStatus = TimerStatus.resting;
      print("[=>] " + _timerStatus.toString());
    });
  }

  void pause() {
    //현재 타이머 상태 State 변경
    setState(() {
      _timerStatus = TimerStatus.paused;
      print("[=>] " + _timerStatus.toString());
    });
  }

  void resume() {
    run();
  }

  void stop() {
    //현재 타이머 상태 State 변경
    //현재 타이머 시간을 집중 시간으로 변경
    setState(() {
      _timer = WORK_SECONDS;
      _timerStatus = TimerStatus.stopped;
      print("[=>] " + _timerStatus.toString());
    });
  }

  //초단위로 카운트하는 비동기 함수
  void runTimer() async {
    //Timer.periodic : Duration에 설정한 단위 시간 마다 함수 본문 실행
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      switch (_timerStatus) {
        case TimerStatus.paused:
          t.cancel();
          break;
        case TimerStatus.stopped:
          t.cancel();
          break;
        case TimerStatus.running:
          if (_timer <= 0) {
            showToast("작업 완료!");
            rest();
          } else {
            //현재 타이머 시간 State 변경
            setState(() {
              _timer -= 1;
            });
          }
          break;
        case TimerStatus.resting:
          if (_timer <= 0) {
            //현재 타이머 시간 State 변경
            setState(() {
              _pomodoroCount += 1;
            });
            showToast("오늘 $_pomodoroCount개의 뽀모도로를 달성했습니다.");
            t.cancel();
            //시작버튼 누르기도 번거로운 예빈씨를 위한 무한 뽀모도로
            setState(() {
              _timer = WORK_SECONDS;
            });
            run();
          } else {
            //현재 타이머 시간 State 변경
            setState(() {
              _timer -= 1;
            });
          }
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _runningButtons = [
      ElevatedButton(
        child: Text(
          _timerStatus == TimerStatus.paused ? '계속하기' : '일시정지',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(primary: Colors.blue),
        onPressed: _timerStatus == TimerStatus.paused ? resume : pause,
      ),
      Padding(
        padding: EdgeInsets.all(20),
      ),
      ElevatedButton(
        child: Text(
          '포기하기',
          style: TextStyle(fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(primary: Colors.grey),
        onPressed: stop,
      ),
    ];
    final List<Widget> _stoppedButtons = [
      ElevatedButton(
        child: Text(
          '시작하기',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          //이거 뭐임 시작하기가 resting인 상태에서 어케 표시됨?
          /*primary:
              _timerStatus == TimerStatus.resting ? Colors.green : Colors.blue,*/
            primary: Colors.blue),
        onPressed: run,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('뽀모도로 타이머 앱'),
        backgroundColor:
        //현재 타이머 상태가 resting이면 초록 아님 파랑
        _timerStatus == TimerStatus.resting ? Colors.green : Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Center(
              child: Text(
                secondsToString(_timer),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              //현재 타이머 상태가 resting이면 초록 아님 파랑
              color: _timerStatus == TimerStatus.resting
                  ? Colors.green
                  : Colors.blue,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //현재 타이머 상태가 resting이면 버튼없음
            children: _timerStatus == TimerStatus.resting
                ? const []
            //현재 타이머 상태가 stopped이면 시작하기 버튼, 아니면 계속하기, 일시정지 버튼
                : _timerStatus == TimerStatus.stopped
                ? _stoppedButtons
                : _runningButtons,
          )
        ],
      ),
    );
  }
}
