FROM registry.suse.com/bci/bci-base:latest

WORKDIR /

# 安裝wget
RUN zypper in -y wget && \
    # 下載BusyBox二進位檔
    wget https://busybox.net/downloads/binaries/1.28.1-defconfig-multiarch/busybox-x86_64 -O /bin/busybox && \
    # 設置執行權限
    chmod +x /bin/busybox && \
    # 建立/opt/www目錄
    mkdir -p /opt/www

# 複製public_html資料夾到/opt/www
COPY index.html /opt/www

# 設置ENTRYPOINT和CMD
CMD ["busybox", "httpd", "-p", "80", "-h", "/opt/www", "-f"]
