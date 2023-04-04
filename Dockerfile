FROM archlinux:base

RUN pacman -Syu --needed --noconfirm \
    binutils \
    fakeroot \
    grep \
    namcap \
    sudo \
    lib32-libglvnd \
    lib32-libx11

RUN sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

RUN useradd -d /build -m build
RUN echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER build
WORKDIR /build

COPY scripts/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
