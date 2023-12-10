

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
| select_attr |    100 |      1152 |        533 |$${lor{green}    422 }27861|      9391 |     586 |
| sort_by |         10 |       140 |         60 |$${lor{green}     45 }27861|       941 |      82 |
| sort |            10 |       421 |        374 |     256 |      1082 |$${lor{green}    188 }27861|
| min |             10 |       276 |        149 |$${lor{green}     54 }27861|       934 |      69 |
| min_by |          10 |       175 |         70 |$${lor{green}     18 }27861|       921 |      31 |
| max |             10 |       268 |        147 |$${lor{green}     53 }27861|       941 |      69 |
| max_by |          10 |       189 |         71 |$${lor{green}     18 }27861|       900 |      32 |
| contains |        10 |       171 |        210 |$${lor{green}    120 }27861|       974 |     152 |
| sum |             10 |       262 |        130 |$${lor{green}     56 }27861|       921 |      70 |
| avg |             10 |       259 |        125 |$${lor{green}     52 }27861|       921 |      70 |
| reverse |         10 |        35 |         16 |$${lor{green}      2 }27861|       795 |$${lor{green}      2 }27861|



## Compliance Tests
| Benchmark |            n |   jp-java |   jp-graal |   jp-go |   jp-rust |   jp-js |
|--------------|----------:|----------:|-----------:|--------:|----------:|--------:|
| boolean |        1000000 |        88 |$${lor{green}        26 }27861|      66 |       549 |     767 |
| current |          10000 |        44 |$${lor{green}        37 }27861|     117 |      1836 |    1407 |
| filters |          10000 |       113 |         33 |$${lor{green}     31 }27861|       132 |     219 |
| functions |       100000 |       595 |        126 |$${lor{green}    110 }27861|      1335 |    1413 |
| identifiers |      10000 |       266 |$${lor{green}        66 }27861|     247 |      1301 |    3688 |
| indices |         100000 |       587 |        189 |$${lor{green}    175 }27861|      1327 |    1236 |
| literal |         100000 |        36 |$${lor{green}         4 }27861|      63 |       936 |    1319 |
| multiselect |     100000 |       467 |$${lor{green}       236 }27861|     291 |      1003 |    1217 |
| pipe |            100000 |$${lor{green}        0 }27861|$${lor{green}         0 }27861|$${lor{green}      0 }27861|$${lor{green}        0 }27861|$${lor{green}      0 }27861|
| slice |           100000 |       873 |$${lor{green}       456 }27861|    1279 |      3034 |    3224 |
| syntax |          100000 |       191 |$${lor{green}        61 }27861|     143 |       456 |    1375 |
| wildcard |        100000 |      1734 |$${lor{green}       981 }27861|    1194 |      5641 |    5348 |

