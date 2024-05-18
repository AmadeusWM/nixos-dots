{pkgs, ...}: {
  home.packages = with pkgs; [
    # dependencies
    ffmpeg_5-full
    slop
    xorg.libxcb
    # source: https://ronamosa.io/docs/archive/2017-07-10-i3wm-Block-Status-Screen/
    (pkgs.writeShellScriptBin "i3-record" ''
      #!/usr/bin/env bash
      # start|stop screencast
      killall -SIGINT ffmpeg && exit # stop when already running

      mkdir -p "$HOME/Videos/ScreenCasts"

      OUTFILE="$HOME/Videos/ScreenCasts/screencast--$(date +'%Y-%m-%d--%H-%M-%S').mp4"
      echo -n $OUTFILE | xclip -selection clipboard # -n to strip newline

      # screen resolution
      slop=$(slop -f "%x %y %w %h %g %i") || exit 1
      read -r X Y W H G ID <<< $slop

      # let the recording process take over this pid
      # exec ffmpeg \
      #   -f pulse \
      #   -i default \
      #   -ac 2 \
      #   -acodec vorbis \
      #   -f x11grab \
      #   -r 25 \
      #   -s $SCREENRES \
      #   -i :0.0 \
      #   -vcodec libx264 $OUTFILE
      exec ffmpeg \
        -f pulse \
        -i default \
        -ac 2 \
        -acodec vorbis \
        -f x11grab -s "$W"x"$H" -i :0.0+$X,$Y -c:v libx264 -pix_fmt yuv420p -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" $OUTFILE 
    '')
  ];
}
