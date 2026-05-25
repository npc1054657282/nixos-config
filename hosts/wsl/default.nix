{
  pkgs,
  username,
  ...
}: {
  wsl = {
    enable = true;
    defaultUser = "${username}";
    startMenuLaunchers = true;
    # 把windows的环境变量也附加进来了，我认为没必要，因此特别取消了这种做法
    interop.includePath = false;
  };
  networking.hostName = "wsl";
  environment.systemPackages = with pkgs; [
    tree
    file
    wslu
    wsl-open
    #教程推荐kitty，我不理解纯终端wsl要这个有什么用，不装
    # kitty
    # 主机层应该放没有就用不了这台机器的软件，我认为git符合这个定位
    git
  ];
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  time.timeZone = "Asia/Shanghai";
  system.stateVersion = "25.11";
  users.users.${username}.openssh.authorizedKeys.keyFiles = [
    ./authorized_keys
  ];
}
