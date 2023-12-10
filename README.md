# Compare JSON tool performance

Currently several JMES implementation are compared.

## Install JP

```
sudo apt install jp
or
brew install jmespath/jmespath/jp
```

## Run Benchmarks

```
./tools/jmespath/run.sh 2>/dev/null | tee /tmp/1 && cat /tmp/1 | tools/format.sh ; rm /tmp/1
./tools/jmespath/run-compliance.sh 2>/dev/null | tee /tmp/1 && cat /tmp/1 | tools/format.sh ; rm /tmp/1
```

## Benchmark Results

### Compliance Tests
| Benchmark |            n |   jp-java |   jp-graal |   jp-go |   jp-rust |   jp-js |
|--------------|----------:|----------:|-----------:|--------:|----------:|--------:|
| boolean |        1000000 |        88 |$${\color[RGB]{121,189,66}        26 }$$|      66 |       549 |     767 |
| current |          10000 |        44 |$${\color[RGB]{121,189,66}        37 }$$|     117 |      1836 |    1407 |
| filters |          10000 |       113 |         33 |$${\color[RGB]{121,189,66}     31 }$$|       132 |     219 |
| functions |       100000 |       595 |        126 |$${\color[RGB]{121,189,66}    110 }$$|      1335 |    1413 |
| identifiers |      10000 |       266 |$${\color[RGB]{121,189,66}        66 }$$|     247 |      1301 |    3688 |
| indices |         100000 |       587 |        189 |$${\color[RGB]{121,189,66}    175 }$$|      1327 |    1236 |
| literal |         100000 |        36 |$${\color[RGB]{121,189,66}         4 }$$|      63 |       936 |    1319 |
| multiselect |     100000 |       467 |$${\color[RGB]{121,189,66}       236 }$$|     291 |      1003 |    1217 |
| slice |           100000 |       873 |$${\color[RGB]{121,189,66}       456 }$$|    1279 |      3034 |    3224 |
| syntax |          100000 |       191 |$${\color[RGB]{121,189,66}        61 }$$|     143 |       456 |    1375 |
| wildcard |        100000 |      1734 |$${\color[RGB]{121,189,66}       981 }$$|    1194 |      5641 |    5348 |


### Large Input
| Benchmark |        n |   jp-java |   jp-graal |   jp-go |   jp-rust |   jp-js |
|--------------|------:|----------:|-----------:|--------:|----------:|--------:|
| select_attr |    100 |      1152 |        533 |$${\color[RGB]{121,189,66}    422 }$$|      9391 |     586 |
| sort_by |         10 |       140 |         60 |$${\color[RGB]{121,189,66}     45 }$$|       941 |      82 |
| sort |            10 |       421 |        374 |     256 |      1082 |$${\color[RGB]{121,189,66}    188 }$$|
| min |             10 |       276 |        149 |$${\color[RGB]{121,189,66}     54 }$$|       934 |      69 |
| min_by |          10 |       175 |         70 |$${\color[RGB]{121,189,66}     18 }$$|       921 |      31 |
| max |             10 |       268 |        147 |$${\color[RGB]{121,189,66}     53 }$$|       941 |      69 |
| max_by |          10 |       189 |         71 |$${\color[RGB]{121,189,66}     18 }$$|       900 |      32 |
| contains |        10 |       171 |        210 |$${\color[RGB]{121,189,66}    120 }$$|       974 |     152 |
| sum |             10 |       262 |        130 |$${\color[RGB]{121,189,66}     56 }$$|       921 |      70 |
| avg |             10 |       259 |        125 |$${\color[RGB]{121,189,66}     52 }$$|       921 |      70 |
| reverse |         10 |        35 |         16 |$${\color[RGB]{121,189,66}      2 }$$|       795 |$${\color[RGB]{121,189,66}      2 }$$|

## Links

- https://jmespath.org/
- https://jmespath.org/libraries.html
- https://github.com/jmespath/jmespath.test
