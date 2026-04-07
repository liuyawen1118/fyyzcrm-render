# 使用轻量级 JDK 镜像
FROM eclipse-temurin:8-jre-alpine

# 安装 wget（用于下载文件）
RUN apk add --no-cache wget

# 设置时区
ENV TZ=Asia/Shanghai

# 设置工作目录
WORKDIR /app

# 或者使用固定的 URL（推荐，更稳定）
RUN wget --no-check-certificate https://github.com/liuyawen1118/fyyzcrm-render/releases/download/v1.0.0/fyyzcrm.jar -O /app/fyyzcrm.jar

# 验证文件下载成功
RUN ls -lh /app/fyyzcrm.jar

# 暴露端口（根据你的应用配置，默认 8080 或 9999）
EXPOSE 9999

# 设置 JVM 参数（优化内存使用，Render 免费套餐 512MB）
ENV JAVA_OPTS="-Xms256m -Xmx400m -XX:+UseG1GC -XX:MaxPermSize=128m -Dfile.encoding=UTF-8 -Djdk.tls.client.protocols=TLSv1.2,TLSv1.3 -Dhttps.protocols=TLSv1.2,TLSv1.3 -Djavax.net.ssl.trustStoreType=JKS"

# 健康检查（可选，SpringBoot Actuator）
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
  CMD wget -q --spider http://localhost:9999/fyyzcrm/Enter || exit 1

# 启动应用
CMD ["sh", "-c", "java $JAVA_OPTS -jar /app/fyyzcrm.jar"]