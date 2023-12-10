

```
sudo apt install jp
or
brew install jmespath/jmespath/jp
```

```
./tools/jmespath/run.sh 2>/dev/null | tee /tmp/1 && cat /tmp/1 | tools/format.sh ; rm /tmp/1
./tools/jmespath/run-compliance.sh 2>/dev/null | tee /tmp/1 && cat /tmp/1 | tools/format.sh ; rm /tmp/1
```

# Benchmark Results

## Large Input
| Benchmark |        n |   jp-java |   jp-graal |   jp-go |   jp-rust |   jp-js |
|--------------|------:|----------:|-----------:|--------:|----------:|--------:|
| select_attr |    100 |      1152 |        533 |    $${\color{green}422}$$ |      9391 |     586 |
| sort_by |         10 |       140 |         60 |     $${\color{green}45}$$ |       941 |      82 |
| sort |            10 |       421 |        374 |     256 |      1082 |    $${\color{green}188}$$ |
| min |             10 |       276 |        149 |     $${\color{green}54}$$ |       934 |      69 |
| min_by |          10 |       175 |         70 |     $${\color{green}18}$$ |       921 |      31 |
| max |             10 |       268 |        147 |     $${\color{green}53}$$ |       941 |      69 |
| max_by |          10 |       189 |         71 |     $${\color{green}18}$$ |       900 |      32 |
| contains |        10 |       171 |        210 |    $${\color{green}120}$$ |       974 |     152 |
| sum |             10 |       262 |        130 |     $${\color{green}56}$$ |       921 |      70 |
| avg |             10 |       259 |        125 |     $${\color{green}52}$$ |       921 |      70 |
| reverse |         10 |        35 |         16 |      $${\color{green}2}$$ |       795 |      $${\color{green}2}$$ |



## Compliance Tests
| Benchmark |            n |   jp-java |   jp-graal |   jp-go |   jp-rust |   jp-js |
|--------------|----------:|----------:|-----------:|--------:|----------:|--------:|
| boolean |        1000000 |        88 |        $${\color{green}26}$$ |      66 |       549 |     767 |
| current |          10000 |        44 |        $${\color{green}37}$$ |     117 |      1836 |    1407 |
| filters |          10000 |       113 |         33 |     $${\color{green}31}$$ |       132 |     219 |
| functions |       100000 |       595 |        126 |    $${\color{green}110}$$ |      1335 |    1413 |
| identifiers |      10000 |       266 |        $${\color{green}66}$$ |     247 |      1301 |    3688 |
| indices |         100000 |       587 |        189 |    $${\color{green}175}$$ |      1327 |    1236 |
| literal |         100000 |        36 |         $${\color{green}4}$$ |      63 |       936 |    1319 |
| multiselect |     100000 |       467 |       $${\color{green}236}$$ |     291 |      1003 |    1217 |
| pipe |            100000 |        $${\color{green}0}$$ |         $${\color{green}0}$$ |      $${\color{green}0}$$ |        $${\color{green}0}$$ |      $${\color{green}0}$$ |
| slice |           100000 |       873 |       $${\color{green}456}$$ |    1279 |      3034 |    3224 |
| syntax |          100000 |       191 |        $${\color{green}61}$$ |     143 |       456 |    1375 |
| wildcard |        100000 |      1734 |       $${\color{green}981}$$ |    1194 |      5641 |    5348 |

