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
 |-----------|---------:|----------:|-----------:|--------:|----------:|--------:|
 | select_attr |    100 |       860 |        552 |      423 * |    9515 |   579 |   
 | sort_by |         10 |       104 |         59 |       45 * |     940 |   83 |    
 | sort |            10 |       392 |        370 |     256 |      1075 |      189 * |     
 | min |             10 |       258 |        142 |       55 * |     915 |   69 |    
 | min_by |          10 |       166 |         69 |       18 * |     916 |   32 |    
 | max |             10 |       258 |        143 |       58 * |     913 |   70 |    
 | max_by |          10 |       172 |         70 |       18 * |     904 |   31 |    
 | contains |        10 |       178 |        149 |      122 * |     981 |   150 |   
 | sum |             10 |       245 |        126 |       58 * |     904 |   71 |    
 | avg |             10 |       253 |        124 |       53 * |     922 |   71 |    
 | reverse |         10 |        36 |         15 |        2 * |     801 |   2 * | 

## Links

- https://jmespath.org/
- https://jmespath.org/libraries.html
- https://github.com/jmespath/jmespath.test
