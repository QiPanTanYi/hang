#include <SoftwareSerial.h>
#include <Servo.h>

// WiFi配置
const char* WIFI_SSID = "nano";       // WiFi名称
const char* WIFI_PASSWORD = "12345678"; // WiFi密码

// 后端服务器配置
const String BACKEND_IP = "159.75.158.12"; // 后端IP
const int BACKEND_PORT = 5000;          // 后端端口

// 传感器阈值
const int L_THRESHOLD = 350; // 光敏电阻阈值
const int R_THRESHOLD = 500; // 雨滴传感器阈值

Servo yj;
SoftwareSerial esp(2, 3);  // RX, TX

const int fanPin = 8;  // 风扇-D8

void sendAT(String cmd, int delayTime = 2000) {
  esp.println(cmd);
  delay(delayTime);
  while (esp.available()) {
    Serial.write(esp.read());  // 打印ESP8266返回信息
  }
}

void setup() {
  Serial.begin(9600);
  esp.begin(115200); // ESP8266默认波特率
  yj.attach(7);
  yj.write(0);
  pinMode(A1, INPUT);
  pinMode(A0, INPUT);
  pinMode(fanPin, OUTPUT);

  Serial.println("初始化ESP8266...");

  sendAT("AT+RST", 2000);              // 重启模块
  sendAT("AT+CWMODE=1", 1000);         // 设置为Station模式
  sendAT("AT+CWJAP=\"" + String(WIFI_SSID) + "\",\"" + String(WIFI_PASSWORD) + "\"", 6000); // 连接WiFi热点
  sendAT("AT+CIPMUX=0", 1000);         // 单连接模式
  Serial.println("连接完成");
  yj.write(0);
  sendHttp(BACKEND_IP, "/rack/off"); 
}

void sendHttp(String host, String path) {
  String cmd = "AT+CIPSTART=\"TCP\",\"" + host + "\"," + String(BACKEND_PORT);
  sendAT(cmd, 3000);

  String httpRequest = "GET " + path + " HTTP/1.1\r\nHost: " + host + "\r\nConnection: close\r\n\r\n";
  int length = httpRequest.length();

  esp.print("AT+CIPSEND=");  // 发送长度
  esp.println(length);
  delay(1000);

  esp.print(httpRequest);  // 正式发送HTTP请求
  delay(3000);
  while (esp.available()) {
    Serial.write(esp.read());
  }

  sendAT("AT+CIPCLOSE", 500);  // 关闭连接
}

void loop() {
  int L = analogRead(A1);
  int R = analogRead(A0);

  Serial.print("L: ");
  Serial.print(L);
  Serial.print(" | R: ");
  Serial.println(R);

  if (L > L_THRESHOLD || R < R_THRESHOLD) {
    yj.write(0);
    sendHttp(BACKEND_IP, "/rack/off");  // 收起晾衣杆

    if (R < R_THRESHOLD) {
      digitalWrite(fanPin, HIGH);
      sendHttp(BACKEND_IP, "/fan/on");  // 开风扇
      delay(5000);    // 吹5秒
      digitalWrite(fanPin, LOW);
      sendHttp(BACKEND_IP, "/fan/off"); // 关风扇
    }
  } else if (L < L_THRESHOLD && R > R_THRESHOLD) {
    yj.write(90);
    sendHttp(BACKEND_IP, "/rack/on");   // 打开晾衣杆
  } else {
    digitalWrite(fanPin, LOW);
    sendHttp(BACKEND_IP, "/fan/off");   // 无需风扇
  }

  delay(1000); // 每1秒上报一次，防止频繁访问
}