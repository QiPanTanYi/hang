#include <Servo.h>
Servo yj;

// 定义风扇控制引脚
const int fanPin = 8;  // 风扇连接到数字引脚8

void setup() {
  pinMode(A1, INPUT);
  pinMode(A0, INPUT);
  pinMode(fanPin, OUTPUT);  // 设置风扇引脚为输出模式
  Serial.begin(9600);
  yj.attach(7);
}

void loop() {
  int L = analogRead(A1);
  int R = analogRead(A0);
  Serial.print("L: ");
  Serial.print(L);
  Serial.print(" | R: ");
  Serial.println(R);

    if (L > 300 || R < 500) {
    yj.write(0); // 收
      if (R < 500) {
      digitalWrite(fanPin, HIGH);  // 打开风扇
      delay(5000);
      digitalWrite(fanPin, LOW);
    }
  }else if (L < 300 && R > 500) {
    yj.write(90);
  }else{
    digitalWrite(fanPin, LOW);
  }

  delay(500);
}