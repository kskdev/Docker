# Build Guide
$B%$%a!<%8$N%S%k%I$H%3%s%F%J$N:n@.J}K!$r4JC1$K@bL@(B($B$[$\HwK:O?(B)

## Docker Image$B$N%S%k%I(B
```
nvidia-docker build --rm --no-cache -t conda3:440 .
```

### $B@bL@(B
- ``` nvidia-docker build ```
 - Dockerfile $B$+$i(B Image $B$r%S%k%I(B
- ``` --rm ```
 - $B%$%a!<%8:n@.8eCf4V%$%a!<%8$r:o=|$9$k(B($BMW$O40@.$^$G:n$C$?CfESH>C<$J%U%!%$%k$O:o=|(B)
- ``` --no-cache ```
 - $BJ8;zNs$NDL$j%-%c%C%7%e$r;H$o$:$K%S%k%I(B
- ``` -t ```
 - $B%S%k%I8e$K%$%a!<%8$N%j%]%8%H%jL>$H%?%0L>$rIUM?!%$3$3$G$O(B conda3:440 $B$HL?L>(B(RepoName:TagName)
- ``` . ```
 - $B%S%k%I$K;H$&(BDockerfile$B$N%G%#%l%/%H%j(B


## Docker Container $B$N:n@.(B
```
nvidia-docker run --rm -it -v /home/osumi:/home/osumi -v /data/osumi:/data/osumi --name kskdevConda3  conda3:440
```

### $B@bL@(B
- ``` nvidia-docker run ```
 - $B%3%s%F%J$N:n@.!%$3$N8e$m$KBgDq?'$s$J%*%W%7%g%s$,IUM?$5$l$k(B
- ``` --rm ```
 - $B%3%s%F%J$N=*N;;~!$$=$N%3%s%F%J$rGK4~$9$k(B
- ``` -it ```
 - $B%3%s%F%JFbIt$GA`:n$G$-$k$h$&$K$9$k(B
- ``` -v ```
 - $B;XDj$7$?%G%#%l%/%H%j$r%[%9%H$H6&M-$9$k!%J#?t;XDj$b2DG=(B
- ``` --name ```
 - $B%3%s%F%J$KL>A0$rIU$1$k!%(B
- ``` conda3:440 ```
 - $B:n@.$9$k%3%s%F%J$N(BImage$B$r;XDj(B



