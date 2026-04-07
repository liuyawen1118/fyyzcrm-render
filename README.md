# FyyzCRM - Spring Boot Application

## 项目信息

- **框架**: Spring Boot 2.7.0
- **JDK 版本**: 8
- **端口**: 9999
- **部署平台**: Render

## 部署说明

本项目通过 Docker 自动从 GitHub Releases 下载最新的 JAR 文件进行在Render平台上部署。

### 更新应用版本

1. 在 GitHub Releases 中创建新版本（如 v1.0.1）
2. 上传新的 JAR 文件
3. 更新 Dockerfile 中的版本号
4. 推送代码到 GitHub
5. Render 会自动重新部署

### 环境变量

- `SPRING_PROFILES_ACTIVE`: prod
- `TZ`: Asia/Shanghai
- `JAVA_OPTS`: -Xms256m -Xmx400m

## 访问地址

部署成功后，应用将在以下地址可访问：
```
https://fyyzcrm-render.onrender.com
```