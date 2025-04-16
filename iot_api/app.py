from flask import Flask, jsonify, Response
import pymysql

app = Flask(__name__)

# 数据库配置（替换为你的实际信息）
DB_CONFIG = {
    'host': '159.75.158.12',
    'user': 'root',
    'password': '123456',
    'database': 'iot',
    'port': 3306,
    'cursorclass': pymysql.cursors.DictCursor  # 返回字典格式结果
}


def execute_sql(sql, params=None):
    """执行SQL并返回结果"""
    connection = pymysql.connect(**DB_CONFIG)
    try:
        with connection.cursor() as cursor:
            cursor.execute(sql, params)
            connection.commit()
            if cursor.rowcount > 0:
                return cursor.fetchall()
    finally:
        connection.close()


# 接口1: 打开风扇
@app.route('/fan/on', methods=['GET'])
def fan_on():
    execute_sql("UPDATE hang SET fan_status = TRUE, update_time = NOW() ORDER BY update_time DESC LIMIT 1")
    return jsonify({'status': 'success', 'message': '风扇已打开'})


# 接口2: 关闭风扇
@app.route('/fan/off', methods=['GET'])
def fan_off():
    execute_sql("UPDATE hang SET fan_status = FALSE, update_time = NOW() ORDER BY update_time DESC LIMIT 1")
    return jsonify({'status': 'success', 'message': '风扇已关闭'})


# 接口3: 打开晾衣杆
@app.route('/rack/on', methods=['GET'])
def rack_on():
    execute_sql("UPDATE hang SET clothes_rack_status = TRUE, update_time = NOW() ORDER BY update_time DESC LIMIT 1")
    return jsonify({'status': 'success', 'message': '晾衣杆已打开'})


# 接口4: 关闭晾衣杆
@app.route('/rack/off', methods=['GET'])
def rack_off():
    execute_sql("UPDATE hang SET clothes_rack_status = FALSE, update_time = NOW() ORDER BY update_time DESC LIMIT 1")
    return jsonify({'status': 'success', 'message': '晾衣杆已关闭'})


# 接口5: 查询当前状态
@app.route('/status', methods=['GET'])
def get_status():
    result = execute_sql(
        "SELECT fan_status, clothes_rack_status, update_time FROM hang ORDER BY update_time DESC LIMIT 1")
    if result:
        return jsonify({
            'fan_status': bool(result[0]['fan_status']),
            'clothes_rack_status': bool(result[0]['clothes_rack_status']),
            'update_time': result[0]['update_time'].strftime('%Y-%m-%d %H:%M:%S')
        })
    return jsonify({'error': '无数据'}), 404


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
