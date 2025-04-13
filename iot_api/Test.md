### 接口测试说明

| 功能       | URL示例（Get请求）      | 返回示例                                                     |
| ---------- | ----------------------- | ------------------------------------------------------------ |
| 打开风扇   | http://IP:5000/fan/on   | {"message":"风扇已打开","status":"success"                   |
| 关闭风扇   | http://IP:5000/fan/off  | {"message":"风扇已关闭","status":"success"}                  |
| 打开晾衣杆 | http://IP:5000/rack/on  | {"message":"晾衣杆已打开","status":"success"}                |
| 关闭晾衣杆 | http://IP:5000/rack/off | {"message":"晾衣杆已关闭","status":"success"}                |
| 查询状态   | http://IP:5000/status   | {"clothes_rack_status":false,"fan_status":true,"update_time":"2025-04-15 14:30:00"} |

