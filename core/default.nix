{ pkgs, ... }:

{
  # 开启 nix-ld，为预编译的动态链接 Linux 二进制文件提供支持
  # 这是让 VSCodium Remote Server 和其他非 Nix 打包程序运行的核心
  programs.nix-ld.enable = true;

  # 配置 nix-ld 需要暴露的动态链接库
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib  # 提供 libstdc++.so.6 和 libgcc_s.so.1 (Node.js 极其依赖)
    zlib              # 提供 libz.so.1 (基础压缩库)
    openssl           # 网络请求相关的基础加密库
    curl              # 很多下载脚本依赖的基础库
  ];
}
