# 第一階段：用於建置和複製資源
FROM registry.suse.com/bci/bci-base:latest AS builder

WORKDIR /

# 安裝wget
RUN zypper in -y wget

# 下載BusyBox二進位檔
RUN wget https://busybox.net/downloads/binaries/1.28.1-defconfig-multiarch/busybox-x86_64 -O /bin/busybox

# 設置執行權限
RUN chmod +x /bin/busybox

# 建立/opt/www目錄
RUN mkdir -p /opt/www

# 複製index.html到/opt/www
COPY index.html /opt/www

# 複製assets目錄到/opt/www/assets
COPY assets /opt/www/assets

# 第二階段：用於運行應用程式
FROM registry.suse.com/bci/bci-minimal:latest

# 複製第一階段中建置的資源
COPY --from=builder /bin/busybox /bin/busybox
COPY --from=builder /opt/www /opt/www

# 設置ENTRYPOINT和CMD
CMD ["busybox", "httpd", "-p", "80", "-h", "/opt/www", "-f"]
