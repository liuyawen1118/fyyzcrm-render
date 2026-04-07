# 使用轻量级 JDK 镜像
FROM eclipse-temurin:8-jre-alpine

# 设置时区
ENV TZ=Asia/Shanghai

# 设置工作目录
WORKDIR /app

# 复制 JAR 文件到容器
COPY fyyzcrm.jar /app/fyyzcrm.jar

# 暴露端口（根据你的应用配置，默认 8080 或 9999）
EXPOSE 9999

# 设置 JVM 参数（优化内存使用）
ENV JAVA_OPTS="-Xms256m -Xmx512m -XX:+UseG1GC"

# 健康检查（可选，SpringBoot Actuator）
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
  CMD wget -q --spider http://localhost:9999/fyyzcrm/Enter || exit 1

# 启动应用
CMD ["sh", "-c", "java $JAVA_OPTS -jar /app/fyyzcrm.jar"]