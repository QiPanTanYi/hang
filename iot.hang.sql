CREATE DATABASE iot;
USE iot;  -- 切换到iot数据库
CREATE TABLE hang (
    fan_status BOOLEAN NOT NULL DEFAULT FALSE COMMENT '风扇状态（true=开，false=关）',
    clothes_rack_status BOOLEAN NOT NULL DEFAULT FALSE COMMENT '晾衣杆状态（true=开，false=关）',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
    PRIMARY KEY (fan_status, clothes_rack_status, update_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='设备状态表';

INSERT INTO iot.hang (fan_status, clothes_rack_status) VALUES (FALSE, FALSE);