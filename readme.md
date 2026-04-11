# nix_config

个人的nix wsl使用。工作流如下：新机器编写`flake.nix`与`host/[主机名]/[配置名].nix`设置本主机核心配置（关键是主机安装git）后，使用`sudo nixos-rebuild switch --flake .#[主机名]`拉取核心配置。然后，通过`git clone`将本配置拉到主用户目录下，然后将主机配置与此配置作整合，整合完毕后重新推送到远程。
